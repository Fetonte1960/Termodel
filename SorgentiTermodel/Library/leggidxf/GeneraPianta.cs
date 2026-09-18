using NetTopologySuite.Geometries;
using System;
using System.Collections.Generic;
using System.Linq;
using netDxf;
using netDxf.Entities;
using netDxf.Header;
using NetTopologySuite.Operation.Union;

namespace Termodel.Leggidxf
{
    public static class GeneraPianta
    {
        public static string OutputDXFPathName;
        public static string nomepianta;
        public static List<LineString> ListaLinee;
        public static List<Geometry> ListaPolilinee;
        public static bool PercorsoEsterno;

        public static void InitClass(string outputDXFPathName, bool percorsoEsterno)
        {
            OutputDXFPathName = outputDXFPathName;
            PercorsoEsterno = percorsoEsterno;
            ListaLinee = new List<LineString>();
            ListaPolilinee = new List<Geometry>();
        }

        public static void SalvaDXF()
        {
            // Salva il DXF versione R 2013
            // contenente le linee come entità "Linea" e i poligoni come entità Polilinea
            // Aggiungi l'estensione .dxf se non è già presente
            if (!nomepianta.EndsWith(".dxf", StringComparison.OrdinalIgnoreCase))
            {
                nomepianta += ".dxf";
            }

            DxfDocument dxf = new DxfDocument
            {
                DrawingVariables = { AcadVer = DxfVersion.AutoCad2013 } // Imposta la versione del file DXF a R 2013
            };

            // Aggiungi le linee come entità di tipo Linea
            foreach (var linea in ListaLinee)
            {
                var start = new Vector3(linea.StartPoint.X, linea.StartPoint.Y, 0);
                var end = new Vector3(linea.EndPoint.X, linea.EndPoint.Y, 0);
                dxf.AddEntity(new Line(start, end));
            }

            // Aggiungi i poligoni come entità di tipo Polilinea
            foreach (var polilinea in ListaPolilinee)
            {
                if (polilinea is Polygon polygon)
                {
                    var polyline = new LwPolyline();
                    foreach (var coord in polygon.Coordinates)
                    {
                        polyline.Vertexes.Add(new LwPolylineVertex(coord.X, coord.Y, 0));
                    }
                    polyline.IsClosed = true;
                    dxf.AddEntity(polyline);
                }
            }

            // Salva il file DXF
            string percorsoCompleto = System.IO.Path.Combine(OutputDXFPathName, nomepianta);
            dxf.Save(percorsoCompleto);
        }

        public static double SpessoreParete(string userdata)
        {
            // svilupperemo in una futura implementazione
            return 0.4;
        }
        /*
        public static Polygon PerimetroEsterno(List<Geometry> poligoni)
        {
            // Controlla che la lista non sia vuota
            if (poligoni == null || poligoni.Count == 0)
            {
                return null;
            }

            Geometry unione = null;

            // Esegui l'unione di tutti i poligoni per ottenere un perimetro esterno unico
            foreach (var geometria in poligoni)
            {
                if (geometria is Polygon poligono)
                {
                    // Se è il primo poligono, inizializza l'unione
                    if (unione == null)
                    {
                        unione = poligono;
                    }
                    else
                    {
                        // Unisci il poligono corrente con l'unione esistente
                        unione = unione.Union(poligono);
                    }
                }
                else if (geometria is MultiPolygon multiPolygon)
                {
                    // Se la geometria è un MultiPolygon, unisci ciascun poligono all'unione
                    foreach (Polygon singoloPoligono in multiPolygon)
                    {
                        if (unione == null)
                        {
                            unione = singoloPoligono;
                        }
                        else
                        {
                            unione = unione.Union(singoloPoligono);
                        }
                    }
                }
            }

            // Gestisci il risultato dell'unione finale
            if (unione is Polygon perimetroFinale)
            {
                // Se l'unione ha prodotto un singolo poligono, è il perimetro esterno
                return perimetroFinale;
            }
            else if (unione is MultiPolygon multiPoligonoFinale)
            {
                // Se l'unione finale è un MultiPolygon, unisci in un singolo poligono
                return (Polygon)multiPoligonoFinale.Union();
            }

            // Se l'unione non ha prodotto un poligono valido, restituisci null
            return null;
        }
        */
        public static Polygon PerimetroEsterno(List<Geometry> poligoni)
        {
            if (poligoni == null || poligoni.Count == 0)
                return null;

            // 1) Appiattisci tutto a una lista di Polygon
            var lista = new List<Geometry>();

            foreach (var g in poligoni)
            {
                if (g == null || g.IsEmpty) continue;

                if (g is Polygon p)
                {
                    lista.Add(p);
                }
                else if (g is MultiPolygon mp)
                {
                    for (int i = 0; i < mp.NumGeometries; i++)
                        lista.Add(mp.GetGeometryN(i));
                }
                else
                {
                    // GeometryCollection o altro: estrai poligoni
                    for (int i = 0; i < g.NumGeometries; i++)
                    {
                        var gi = g.GetGeometryN(i);
                        if (gi is Polygon pi) lista.Add(pi);
                        else if (gi is MultiPolygon mpi)
                            for (int k = 0; k < mpi.NumGeometries; k++)
                                lista.Add(mpi.GetGeometryN(k));
                    }
                }
            }

            if (lista.Count == 0) return null;

            // 2) Union robusta
            Geometry unione = UnaryUnionOp.Union(lista);
            if (unione == null || unione.IsEmpty) return null;

            // 3) Ritorna SEMPRE un Polygon: scegli quello di area maggiore
            Polygon best = null;

            if (unione is Polygon up)
            {
                best = up;
            }
            else
            {
                for (int i = 0; i < unione.NumGeometries; i++)
                {
                    if (unione.GetGeometryN(i) is Polygon pi)
                    {
                        if (best == null || pi.Area > best.Area) best = pi;
                    }
                }
            }

            if (best == null) return null;

            // 4) Perimetro esterno "pulito": usa solo l’ExteriorRing
            // (evita buchi/degenerazioni che spesso fanno fallire gli offset)
            return new Polygon((LinearRing)best.ExteriorRing);
        }
        private static Polygon SafeParalleloLocale(Polygon p, bool versoEsterno)
        {
            if (p == null || p.IsEmpty) return null;

            Geometry g;
            try
            {
                g = GeometriaHelper.ParalleloPoligono(p, versoEsterno);
            }
            catch
            {
                return null;
            }

            if (g == null || g.IsEmpty) return null;

            // se torna poligono ok
            if (g is Polygon pg)
                return new Polygon((LinearRing)pg.ExteriorRing);

            // se torna MultiPolygon/collezione: prendi il più grande
            Polygon best = null;
            for (int i = 0; i < g.NumGeometries; i++)
            {
                if (g.GetGeometryN(i) is Polygon pi)
                    if (best == null || pi.Area > best.Area) best = pi;
            }

            return best == null ? null : new Polygon((LinearRing)best.ExteriorRing);
        }


        public static void GeneraLocali(List<Geometry> poligoni)
        {
            // 1) Perimetro esterno edificio
            var unito = PerimetroEsterno(poligoni);
            ListaPolilinee.Add(unito);

            var perimEdificio = GeometriaHelper.ParalleloPoligono(unito, PercorsoEsterno);
            //ListaPolilinee.Add(perimEdificio);

            // 2) Locali: aggiungi ANCHE il parallelizzato
            foreach (var geometria in poligoni)
            {
                if (geometria is Polygon locale)
                {
                    // originale (se vuoi continuare a vederlo)
                    //ListaPolilinee.Add(locale);

                    // parallelizzato (quello che ti serve per pannelli)
                    var localePar = SafeParalleloLocale(locale, versoEsterno: true);
                    // ^ qui probabilmente vuoi "false" = verso interno (dipende dalla tua ParalleloPoligono)

                    if (localePar != null)
                        ListaPolilinee.Add(localePar);
                }
            }
        }


        // Metodo per espandere o contrarre una linea
        private static LineString EspandiLinea(Coordinate start, Coordinate end, double distanza)
        {
            // Implementa la logica per espandere o contrarre il lato con un buffer laterale
            // Questo è un esempio di funzione che dovrebbe calcolare un punto espanso o contratto
            // secondo la distanza e restituire una LineString modificata.

            // Esempio (sostituisci con una logica più precisa se necessario)
            var dx = end.X - start.X;
            var dy = end.Y - start.Y;
            var lunghezza = Math.Sqrt(dx * dx + dy * dy);

            // Calcola il vettore perpendicolare
            var offsetX = -dy / lunghezza * distanza;
            var offsetY = dx / lunghezza * distanza;

            // Nuovi punti spostati
            var nuovoStart = new Coordinate(start.X + offsetX, start.Y + offsetY);
            var nuovoEnd = new Coordinate(end.X + offsetX, end.Y + offsetY);

            return new LineString(new[] { nuovoStart, nuovoEnd });
        }

        // Metodo per costruire un poligono dai lati modificati
        private static Polygon CostruisciPoligonoDaLinee(List<LineString> linee)
        {
            // Questo metodo costruisce un poligono chiuso dai lati dati
            var coordinates = linee.SelectMany(linea => linea.Coordinates).ToList();

            // Chiudi il poligono aggiungendo il primo punto alla fine
            coordinates.Add(coordinates[0]);

            return new Polygon(new LinearRing(coordinates.ToArray()));
        }

        public static void GeneraPiantaPiano(DXFLineCheck lines2DCor,string outputDXFPathName, string Nomepianta, List<Geometry> poligoni,bool percorsoEsterno)
        {
            // Aggiunge alla lista delle polilinee il perimetro dei singoli locali (poligoni)
            // e la polilinea relativa al perimetro esterno di tutto l'edificio
            // tenendo conto di SpessoreParete(string userdata)
            // e di bool PercorsoEsterno che indica se le linee esterne del gruppo di poligoni rappresentano
            // il lato esterno delle pareti esterne oppure il lato interno
            GeometriaHelper.Lines2DCor = lines2DCor;
            InitClass(outputDXFPathName, percorsoEsterno);
            GeneraLocali(poligoni);
            nomepianta = Nomepianta;
            


        }

        private static Geometry ExpandPolygon(Polygon polygon, double distance)
        {
            // Funzione di esempio che espande o riduce il poligono in base allo spessore della parete
            // Utilizza NetTopologySuite per eseguire il buffering (positivo o negativo)
            return polygon.Buffer(distance);
        }
        public static void InsertSymb(List<LineString> linee, Coordinate puntoInserimento, double angoloRotazione)
        {
            foreach (var linea in linee)
            {
                // Applica la rotazione e lo spostamento a ciascuna linea
                var lineaTrasformata = TrasformaLinea(linea, puntoInserimento, angoloRotazione);

                // Aggiungi la linea trasformata al database linee della classe
                ListaLinee.Add(lineaTrasformata);
            }
        }

        // Funzione di supporto per applicare rotazione e traslazione a una linea
        private static LineString TrasformaLinea(LineString linea, Coordinate puntoInserimento, double angoloRotazione)
        {
            // Calcola il coseno e il seno dell'angolo di rotazione per evitare calcoli ripetuti
            double cosAngolo = Math.Cos(angoloRotazione);
            double sinAngolo = Math.Sin(angoloRotazione);

            // Trasforma ogni coordinata della linea
            var coordinateTrasformate = linea.Coordinates.Select(coord =>
            {
                // Rotazione attorno all'origine (0,0)
                double xRuotato = coord.X * cosAngolo - coord.Y * sinAngolo;
                double yRuotato = coord.X * sinAngolo + coord.Y * cosAngolo;

                // Spostamento rispetto al punto di inserimento
                double xFinale = xRuotato + puntoInserimento.X;
                double yFinale = yRuotato + puntoInserimento.Y;

                return new Coordinate(xFinale, yFinale);
            }).ToArray();

            // Restituisce una nuova LineString con le coordinate trasformate
            return new LineString(coordinateTrasformate);
        }

        //-------------------------------------------  Finestra
        public static List<LineString> DisegnaFinestra(double larghezza, double spessore, bool latoParete)
        {
            var lineeFinestra = new List<LineString>();

            // Calcola le coordinate degli estremi della finestra rispetto all'origine (0,0)
            double metàLarghezza = larghezza / 2.0;

            // Se latoParete è true, disegna la finestra in alto; se false, in basso rispetto all'asse Y
            double yPosizioneInfisso = latoParete ? spessore / 2.0 : -spessore / 2.0;

            // Estremi della finestra sulla parete, centrati rispetto all'origine
            Coordinate puntoInizioFinestra = new Coordinate(-metàLarghezza, 0);
            Coordinate puntoFineFinestra = new Coordinate(metàLarghezza, 0);

            // Linee verticali agli estremi della finestra per tagliare la parete
            LineString taglioSinistro = new LineString(new[]
            {
            new Coordinate(puntoInizioFinestra.X, yPosizioneInfisso - spessore / 2.0),
            new Coordinate(puntoInizioFinestra.X, yPosizioneInfisso + spessore / 2.0)
            });

            LineString taglioDestro = new LineString(new[]
            {
            new Coordinate(puntoFineFinestra.X, yPosizioneInfisso - spessore / 2.0),
            new Coordinate(puntoFineFinestra.X, yPosizioneInfisso + spessore / 2.0)
             });

            double spfin = 0.03;
            // Linee orizzontali per lo spessore dell'infisso della finestra
            LineString infissoSuperiore = new LineString(new[]
            {
            new Coordinate(puntoInizioFinestra.X, yPosizioneInfisso +spfin),
            new Coordinate(puntoFineFinestra.X, yPosizioneInfisso +spfin)
             });

            LineString infissoInferiore = new LineString(new[]
            {
            new Coordinate(puntoInizioFinestra.X, yPosizioneInfisso  - spfin),
            new Coordinate(puntoFineFinestra.X, yPosizioneInfisso -spfin)
            });

            // Aggiunge le linee create alla lista di linee della finestra
            lineeFinestra.Add(taglioSinistro);
            lineeFinestra.Add(taglioDestro);
            lineeFinestra.Add(infissoSuperiore);
            lineeFinestra.Add(infissoInferiore);

            return lineeFinestra;
        }
        public static void AggiungiFinestra2D(double larghezza, Coordinate start, Coordinate end, Coordinate puntoInserimento, double spessoreParete)
        {
            // Calcola l'angolo di inserimento in base alla direzione della parete (start -> end)
            double deltaX = end.X - start.X;
            double deltaY = end.Y - start.Y;
            double angoloInserimento = Math.Atan2(deltaY, deltaX);

            // Disegna la finestra rispetto all'origine (0,0), centrata, senza rotazione
            var finestraLinee = DisegnaFinestra(larghezza, spessoreParete, latoParete: false);

            // Inserisce il simbolo della finestra ruotato e traslato rispetto alla parete
            //disattivato per multipoligono InsertSymb(finestraLinee, puntoInserimento, angoloInserimento);
        }


    }
}
