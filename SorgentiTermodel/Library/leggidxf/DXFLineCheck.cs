using NetTopologySuite.Geometries;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using Xbim.IO.Xml.BsConf;
using Xbim.Ifc4.Interfaces;
using Xbim.Ifc4.GeometryResource;
using Termodel.Leggidxf;
using Termodel.utilities;
using Microsoft.Isam.Esent.Interop;
using static Microsoft.Isam.Esent.Interop.EnumeratedColumn;
using NetTopologySuite.Utilities;
using static Termodel.utilities.TermodelLog;

namespace Termodel.Leggidxf
{
    public class DXFLineCheck
    {
        public void LogLineeCompatto(string tag = "")
        {
            var sb = new System.Text.StringBuilder();
            sb.AppendLine($"[DXFLineCheck.LogLineeCompatto {tag}] Linee contenute: {lineStrings.Count}");

            int index = 0;
            foreach (var line in lineStrings)
            {
                var c1 = line.GetCoordinateN(0);
                var c2 = line.GetCoordinateN(1);

                sb.AppendLine($"{index++:D3}) [{c1.X:0.##},{c1.Y:0.##}] → [{c2.X:0.##},{c2.Y:0.##}]");
            }

            TermodelLog.WriteLog(sb.ToString());
        }


        public bool IsPolygonClockwise(Polygon polygon)
        {
            double angleSum = 0;
            var exteriorRing = polygon.ExteriorRing;

            for (int i = 0; i < exteriorRing.NumPoints - 1; i++)
            {
                Coordinate p1 = exteriorRing.Coordinates[i];
                Coordinate p2 = exteriorRing.Coordinates[i + 1];
                Coordinate p3 = exteriorRing.Coordinates[(i + 2) % exteriorRing.NumPoints];

                angleSum += CalculateAngle(p1, p2, p3);
            }

            // Un angolo negativo indica un poligono orientato in senso orario (interno a destra)
            return angleSum < 0;
        }

        public double CalculateAngle(Coordinate p1, Coordinate p2, Coordinate p3)
        {
            double dx1 = p2.X - p1.X;
            double dy1 = p2.Y - p1.Y;
            double dx2 = p3.X - p2.X;
            double dy2 = p3.Y - p2.Y;

            double angle1 = Math.Atan2(dy1, dx1);
            double angle2 = Math.Atan2(dy2, dx2);

            double angle = angle2 - angle1;

            if (angle <= -Math.PI) angle += 2 * Math.PI;
            if (angle > Math.PI) angle -= 2 * Math.PI;

            return angle;
        }
        public List<LineString> lineStrings;
        private string irregolarita;
        // La lista di nodi quotati, dove ad ogni coppia (X, Y) è associata una lista di Z
        public Dictionary<(double X, double Y), List<double>> NodiQuotati { get; set; }

        // Costruttore che accetta una lista di LineString
        private void partecomunecostruttore()
        {
            this.irregolarita = ""; // Inizialmente la stringa di errori è vuota}

        }
        public DXFLineCheck(List<LineString> lineStrings)
        {
            this.lineStrings = lineStrings ?? new List<LineString>();
            // Crea una nuova lista copiando gli oggetti LineString
            //this.lineStrings = lineStrings != null
            //    ? new List<LineString>(lineStrings.Select(ls => new LineString(ls.Coordinates.ToArray())))
            //    : new List<LineString>(); 
            partecomunecostruttore();
        }
        public DXFLineCheck(List<LineString> lineStringsPiano1, List<LineString> lineStringsPiano2)
        {
            // Fusione delle due liste in una singola lista
            this.lineStrings = new List<LineString>();

            if (lineStringsPiano1 != null)
            {
                this.lineStrings.AddRange(lineStringsPiano1);
            }

            if (lineStringsPiano2 != null)
            {
                this.lineStrings.AddRange(lineStringsPiano2);
            }

            partecomunecostruttore();
        }
        public bool IsPolygonPartiallyCovered(Geometry geometryA, Polygon b)
        {
            // Verifica che geometryA sia un poligono
            if (!(geometryA is Polygon a))
            {
                // Se geometryA non è un poligono, restituisci false
                return false;
            }

            // Ottieni i vertici del poligono 'a'
            var coordinates = a.ExteriorRing.Coordinates;

            // Verifica se almeno un punto medio di un lato del poligono 'a' si trova all'interno del poligono 'b'
            for (int i = 0; i < coordinates.Length - 1; i++)
            {
                // Calcola il punto medio del lato corrente
                var puntoMedioX = (coordinates[i].X + coordinates[i + 1].X) / 2;
                var puntoMedioY = (coordinates[i].Y + coordinates[i + 1].Y) / 2;

                // Crea un punto per il punto medio
                var puntoMedio = new Point(puntoMedioX, puntoMedioY);

                // Verifica se il punto medio è contenuto all'interno del poligono 'b'
                if (b.Contains(puntoMedio))
                {
                    bool sufficientDistance = true;

                    // Ottieni i lati del poligono 'b'
                    var boundaryCoordinates = b.ExteriorRing.Coordinates;

                    // Verifica la distanza del punto medio da ogni lato del poligono 'b'
                    for (int j = 0; j < boundaryCoordinates.Length - 1; j++)
                    {
                        // Creiamo un segmento tra due punti consecutivi del poligono 'b'
                        var lineaSegmento = new LineString(new[] { boundaryCoordinates[j], boundaryCoordinates[j + 1] });

                        // Calcola la distanza del punto medio dal segmento
                        double distanzaDalLato = lineaSegmento.Distance(puntoMedio);

                        // Se la distanza dal lato è inferiore a 0.1, il punto non soddisfa la condizione
                        if (distanzaDalLato < 0.1)
                        {
                            sufficientDistance = false;
                            break;
                        }
                    }

                    // Se il punto medio è all'interno del poligono 'b' e dista almeno 0.1 da tutti i lati
                    if (sufficientDistance)
                    {
                        return true; // Almeno un punto medio soddisfa tutte le condizioni
                    }
                }
            }

            // Nessun punto medio soddisfa le condizioni
            return false;
        }
        public Polygon UnisciPoligoni(List<Geometry> geometries)
        {
            if (geometries == null || geometries.Count == 0)
            {
                return null; // Se la lista è vuota, restituisci null
            }

            // Filtra solo i poligoni
            var poligoni = geometries.OfType<Polygon>().ToList();

            if (poligoni.Count == 0)
            {
                return null; // Se non ci sono poligoni, restituisci null
            }

            // Inizializza il poligono di unione con il primo poligono della lista
            Geometry unionPolygon = poligoni[0];

            // Esegui l'unione dei poligoni successivi
            for (int i = 1; i < poligoni.Count; i++)
            {
                unionPolygon = unionPolygon.Union(poligoni[i]);
            }

            // Verifica se l'unione è un singolo poligono
            if (unionPolygon is Polygon poligonoUnito)
            {
                return poligonoUnito;
            }

            // Se il risultato non è un singolo poligono, restituisci null o gestisci diversamente
            return null;
        }
        public List<NetTopologySuite.Geometries.Geometry> ElaboraGrafo(NetTopologySuite.Geometries.Polygon polygono)
        {


            // Aggiungi il perimetro esterno del poligono (ExteriorRing)
            //if (polygono?.ExteriorRing != null)
            //{
            //    AddPolygon(polygono);
            //}
            TermodelLog.LogOperation($"Locale  mansardato , pianta del tetto");
            //TermodelLog.LogDisegnoSVG(lineStrings, null);
            TermodelLog.LogOperation($"Pianta tetto + locale (rosso )");
            //TermodelLog.LogDisegnoSVG(lineStrings, polygono);
            //SVGHelper.GeneraSVG("Locali_falde_prima", lineStrings, null);

            //SVGHelper.AnomalieLinee(lineStrings, polygono, "NonConnesse");


            /*
            var lineprima = lineStrings
            .Select(ls => (LineString)ls.Copy())
            .ToList();
            */
            Spezzalinee(lineStrings);
            //ErroreManager.AddErroreDXF("locale", 0, $"", lineprima, lineStrings, Dis3D: false);

            RimuoviLineeDuplicate();
            
            RaggruppaNodi();
             // rimuovi linee di lunghezza 0
            lineStrings = lineStrings.Where(line => line.Length > 0).ToList();

            SVGHelper.GeneraSVG("Locali_falde", lineStrings, null);
            var polygons = new List<NetTopologySuite.Geometries.Geometry>();
            var polygonizer = new NetTopologySuite.Operation.Polygonize.Polygonizer();

            foreach (var lineString in lineStrings)
            {
                polygonizer.Add(lineString);
            }
            int count2 = 0;
            foreach (var polygon in polygonizer.GetPolygons())
            {
                if (polygon.IsValid)
                {
                    count2 += 1;
                    bool copertura = IsPolygonPartiallyCovered(polygon, polygono);
                    // Controlla se il poligono risultante è completamente contenuto nel poligono del locale
                    //if (polygon.CoveredBy(polygono)) // Verifica se il poligono risultante è interno al polygono
                    if (copertura)
                    
                    {
                        polygons.Add(polygon);
                       
                    }
                }
            }
            // Visualizza i poligoni tramite SVGHelper
            SVGHelper.GeneraSVG("Poligoni_Tetto_Locale", SVGHelper.SVGPolygons(polygons), null);

            // Possibile caso di locale totalemte interno ad una falda
            if (polygons.Count ==0 ) 
            polygons.Add(polygono);
            

            // Ritorna la lista delle IfcPolyline che rappresentano i poligoni interni
            return polygons;
           
        }

        public double apr = 0.1;
        public bool UG_APR(double a, double b)
        {
            return Math.Abs(a - b) <= apr;
        }
        public  bool ISZero(string valore)
        {
            return this.UG_APR(Utigen.CVStrToDouble(valore) , 0);
        }
        // Metodo per aggiungere una LineString alla lista
        public void AddLineString(LineString lineString)
        {
            lineStrings.Add(lineString);
        }
        public void AddLineStrings(List<LineString> polygono)
        {
            if (polygono != null && polygono.Count > 0)
            {
                foreach (var lato in polygono)
                {
                    // Aggiungi ogni LineString alla lista del grafo elaborato
                    lineStrings.Add(lato);
                }
            }
        }
        public void AddPolygon(Polygon poligono)
        {
            // Ottieni l'anello esterno del poligono (ExteriorRing)
            var exteriorRing = poligono.ExteriorRing;

            // Estrai le coordinate dell'anello esterno
            var coordinates = exteriorRing.Coordinates;

            // Trasforma l'anello esterno del poligono in singole linee
            for (int i = 0; i < coordinates.Length - 1; i++)
            {
                // Crea una linea tra due punti consecutivi
                var line = new LineString(new Coordinate[] { coordinates[i], coordinates[i + 1] });

                // Aggiungi la linea alla collezione di linee
                lineStrings.Add(line);
            }
        }
        public List<LineString> PolygonToListLinestring(Polygon poligono)
        {
            // Inizializza una lista di LineString
            var ls = new List<LineString>();

            // Ottieni l'anello esterno del poligono (ExteriorRing)
            var exteriorRing = poligono.ExteriorRing;

            // Estrai le coordinate dell'anello esterno
            var coordinates = exteriorRing.Coordinates;

            // Trasforma l'anello esterno del poligono in singole linee
            for (int i = 0; i < coordinates.Length - 1; i++)
            {
                // Crea una linea tra due punti consecutivi
                var line = new LineString(new Coordinate[] { coordinates[i], coordinates[i + 1] });

                // Aggiungi la linea alla lista di LineString
                ls.Add(line);
            }

            // Restituisci la lista delle linee
            return ls;
        }

        public List<LineString> UserdataPolygon(Polygon poligono)
        {
            // Inizializza la lista di LineString
            List<LineString> UserdataPoly = new List<LineString>();

            // Ottieni l'anello esterno del poligono (ExteriorRing)
            var exteriorRing = poligono.ExteriorRing;

            // Estrai le coordinate dell'anello esterno
            var coordinates = exteriorRing.Coordinates;

            // Trasforma l'anello esterno del poligono in singole linee
            for (int i = 0; i < coordinates.Length - 1; i++)
            {
                // Crea una linea tra due punti consecutivi
                var line = new LineString(new Coordinate[] { coordinates[i], coordinates[i + 1] });

                // Converti l'array in una lista per passarlo alla funzione
                var coordinatesToSearch = new List<NetTopologySuite.Geometries.Coordinate> { coordinates[i], coordinates[i + 1] };

                // Imposta il userData sulla linea usando la funzione di ricerca
                line.UserData = GetUserDataByCoordinates(coordinatesToSearch);

                // Aggiungi la linea alla collezione di linee
                UserdataPoly.Add(line);
            }

            return UserdataPoly;
        }
        //-------------------------------------------------------------------------------------------------------------

        //                             RAGGRUPPA NODI

        //-------------------------------------------------------------------------------------------------------------
        public void SettaZVicini()
        {
            int contaZOrigine = 0;
            int contaPropagazioni = 0;

            foreach (var line in lineStrings)
            {
                if (!ISZero(Utigen.Get_Z(line.UserData, 1)) || !ISZero(Utigen.Get_Z(line.UserData, 2)))
                {
                    contaZOrigine++;
                    TermodelLog.WriteLog($"🔵 Z origine trovata in linea: start=({line.StartPoint.X},{line.StartPoint.Y}) end=({line.EndPoint.X},{line.EndPoint.Y}) Z1={Utigen.Get_Z(line.UserData, 1)} Z2={Utigen.Get_Z(line.UserData, 2)}", category : LogCategory.colmi);

                    foreach (var line2 in lineStrings)
                    {
                        if (line != line2)
                        {
                            if (ISZero(Utigen.Get_Z(line2.UserData, 1)) &&
                                !ISZero(Utigen.Get_Z(line.UserData, 1)) &&
                                UG_APR(line.StartPoint.Coordinate.X, line2.StartPoint.Coordinate.X) &&
                                UG_APR(line.StartPoint.Coordinate.Y, line2.StartPoint.Coordinate.Y))
                            {
                                line2.UserData = Utigen.SetUserdataValue(
                                    line2.UserData.ToString(),
                                    Utigen.Get_Z(line.UserData, 1),
                                    PUserdata.Z1
                                );
                                //TermodelLog.WriteLog($"↪️ Propagato Z1 a line2.StartPoint ({line2.StartPoint.X},{line2.StartPoint.Y})");
                                contaPropagazioni++;
                            }

                            if (ISZero(Utigen.Get_Z(line2.UserData, 1)) &&
                                !ISZero(Utigen.Get_Z(line.UserData, 2)) &&
                                UG_APR(line.EndPoint.Coordinate.X, line2.StartPoint.Coordinate.X) &&
                                UG_APR(line.EndPoint.Coordinate.Y, line2.StartPoint.Coordinate.Y))
                            {
                                line2.UserData = Utigen.SetUserdataValue(
                                    line2.UserData.ToString(),
                                    Utigen.Get_Z(line.UserData, 2),
                                    PUserdata.Z1
                                );
                                //TermodelLog.WriteLog($"↪️ Propagato Z2 a line2.StartPoint ({line2.StartPoint.X},{line2.StartPoint.Y})");
                                contaPropagazioni++;
                            }

                            if (ISZero(Utigen.Get_Z(line2.UserData, 2)) &&
                                !ISZero(Utigen.Get_Z(line.UserData, 2)) &&
                                UG_APR(line.EndPoint.Coordinate.X, line2.EndPoint.Coordinate.X) &&
                                UG_APR(line.EndPoint.Coordinate.Y, line2.EndPoint.Coordinate.Y))
                            {
                                line2.UserData = Utigen.SetUserdataValue(
                                    line2.UserData.ToString(),
                                    Utigen.Get_Z(line.UserData, 2),
                                    PUserdata.Z2
                                );
                                //TermodelLog.WriteLog($"↪️ Propagato Z2 a line2.EndPoint ({line2.EndPoint.X},{line2.EndPoint.Y})");
                                contaPropagazioni++;
                            }

                            if (ISZero(Utigen.Get_Z(line2.UserData, 2)) &&
                                !ISZero(Utigen.Get_Z(line.UserData, 1)) &&
                                UG_APR(line.StartPoint.Coordinate.X, line2.EndPoint.Coordinate.X) &&
                                UG_APR(line.StartPoint.Coordinate.Y, line2.EndPoint.Coordinate.Y))
                            {
                                line2.UserData = Utigen.SetUserdataValue(
                                    line2.UserData.ToString(),
                                    Utigen.Get_Z(line.UserData, 1),
                                    PUserdata.Z2
                                );
                                //TermodelLog.WriteLog($"↪️ Propagato Z1 a line2.EndPoint ({line2.EndPoint.X},{line2.EndPoint.Y})");
                                contaPropagazioni++;
                            }
                        }
                    }
                }
            }

            TermodelLog.WriteLog($"✅ SettaZVicini completato. Origini Z rilevate: {contaZOrigine}, propagazioni effettuate: {contaPropagazioni}");
        }


        // Funzione per raggruppare i nodi vicini tra loro
        public Dictionary<(double X, double Y), List<double>> RaggruppaNodi()
        {
            // Dizionario temporaneo per memorizzare i nodi quotati
            var nodiQuotati = new Dictionary<(double X, double Y), List<double>>();

            // Fase 1 
            foreach (var line in lineStrings)
            {
                // Fase 1 per il nodo iniziale
                var startCoord = line.StartPoint.Coordinate;
                //var zStart = line.StartPoint.Z;  // Prendi la Z dalla linea
                var nodoRaggruppatoStart = TrovaNodoRaggruppato(startCoord, nodiQuotati,true);
  
                // Fase 1  per il nodo finale
                var endCoord = line.EndPoint.Coordinate;
                //var zEnd = line.EndPoint.Z;  // Prendi la Z dalla linea
                var nodoRaggruppatoEnd = TrovaNodoRaggruppato(endCoord, nodiQuotati,true);
                
            }
            //Fase 2
            foreach (var line in lineStrings)
            {
                // Fase 2 per il nodo iniziale
                var startCoord = line.StartPoint.Coordinate;
                //var zStart = line.StartPoint.Z;  // Prendi la Z dalla linea
                var nodoRaggruppatoStart = TrovaNodoRaggruppato(startCoord, nodiQuotati,false);
                line.StartPoint.Coordinate.X = nodoRaggruppatoStart.X;
                line.StartPoint.Coordinate.Y = nodoRaggruppatoStart.Y;
                //AggiornaZNodo(nodoRaggruppatoStart, zStart, nodiQuotati);  // Aggiorna la Z

                // Fase 2 per il nodo finale
                var endCoord = line.EndPoint.Coordinate;
                //var zEnd = line.EndPoint.Z;  // Prendi la Z dalla linea
                var nodoRaggruppatoEnd = TrovaNodoRaggruppato(endCoord, nodiQuotati,false);
                line.EndPoint.Coordinate.X = nodoRaggruppatoEnd.X;
                line.EndPoint.Coordinate.Y = nodoRaggruppatoEnd.Y;
                //AggiornaZNodo(nodoRaggruppatoEnd, zEnd, nodiQuotati);  // Aggiorna la Z
            }

            return nodiQuotati;  // Restituisce il dizionario dei nodi raggruppati e aggiornati con le Z
        }
        // Funzione per verificare se due nodi sono vicini tra loro in base alla distanza 'apr'


        // Funzione per trovare il nodo raggruppato nella lista di nodi
        // Funzione per trovare un nodo raggruppato vicino usando l'approssimazione
        private Coordinate TrovaNodoRaggruppato(Coordinate nodo, Dictionary<(double X, double Y), List<double>> nodiQuotati,bool aggiungi)
        {
            foreach (var chiaveNodo in nodiQuotati.Keys)
            {
                // Controlla se il nodo corrente è vicino a un nodo già presente
                if (UG_APR(nodo.X, chiaveNodo.X) && UG_APR(nodo.Y, chiaveNodo.Y))
                {
                    return new Coordinate(chiaveNodo.X, chiaveNodo.Y);  // Restituisce il nodo raggruppato
                }
            }

            // Se non è vicino a nessun nodo, aggiungilo come nuovo nodo nella lista (senza toccare Z)
            if (aggiungi) AggiungiNodoAListaQuotati(nodo, 0, nodiQuotati);  // Inizializza Z a 0
            return nodo;
        }
        private void AggiungiNodoAListaQuotati(Coordinate nodo, double z, Dictionary<(double X, double Y), List<double>> nodiQuotati)
        {
            var chiaveNodo = (nodo.X, nodo.Y);

            if (nodiQuotati.ContainsKey(chiaveNodo))
            {
                if (!ZApprossimataPresente(nodiQuotati[chiaveNodo], z))
                {
                    nodiQuotati[chiaveNodo].Add(z);
                }
            }
            else
            {
                nodiQuotati[chiaveNodo] = new List<double> { z };
            }
        }
        // Funzione per verificare se una Z è già presente con approssimazione
        private bool ZApprossimataPresente(List<double> listaZ, double zVerificata)
        {
            foreach (var z in listaZ)
            {
                if (UG_APR(z, zVerificata))
                {
                    return true;  // La Z è già presente approssimativamente
                }
            }
            return false;  // Nessuna Z approssimata trovata
        }
        // Funzione per aggiornare la Z di un nodo nella lista NodiQuotati
        private void AggiornaZNodo(Coordinate nodo, double z, Dictionary<(double X, double Y), List<double>> nodiQuotati)
        {
            var chiaveNodo = (nodo.X, nodo.Y);

            // Verifica se la Z è valida e non approssimativamente uguale a una già presente
            if (z != 0 && nodiQuotati.ContainsKey(chiaveNodo) && !ZApprossimataPresente(nodiQuotati[chiaveNodo], z))
            {
                nodiQuotati[chiaveNodo].Add(z);  // Aggiungi la Z se non è già presente
            }
        }

        //  ----- vecchia versione 
        // Funzione di approssimazione per confrontare due valori di Z (o altri valori)

        private void RaggruppaNodiConZ(Coordinate nodo1, Coordinate nodo2, Dictionary<(double X, double Y), List<double>> nodiQuotatiTemp)
        {
            // Raggruppa le coordinate X e Y
            nodo2.X = nodo1.X;
            nodo2.Y = nodo1.Y;

            // Unisci le Z tra i due nodi
            var chiaveNodo1 = (nodo1.X, nodo1.Y);
            var chiaveNodo2 = (nodo2.X, nodo2.Y);

            if (nodiQuotatiTemp.ContainsKey(chiaveNodo2))
            {
                // Se nodo2 ha delle Z associate, uniscile a nodo1
                foreach (var z in nodiQuotatiTemp[chiaveNodo2])
                {
                    // Aggiungi la Z di nodo2 a nodo1 se non esiste già
                    if (!nodiQuotatiTemp[chiaveNodo1].Contains(z))
                    {
                        nodiQuotatiTemp[chiaveNodo1].Add(z);
                    }
                }

                // Rimuovi nodo2 dalla lista, poiché ora è stato unito a nodo1
                nodiQuotatiTemp.Remove(chiaveNodo2);
            }
        }
        private bool SonoVicini(Coordinate p1, Coordinate p2)
        {
            double distanza = p1.Distance(p2); // Utilizza la distanza euclidea tra i due punti
            return distanza <= apr;
        }
        //-------------------------------------------------------------------------------------------------------------

        //                            rimuovi  LINEE   Duplicate

        //-------------------------------------------------------------------------------------------------------------
        public void RimuoviLineeDuplicate()
        {
            var uniqueLines = new List<LineString>();

            foreach (var line in lineStrings)
            {
                if (!uniqueLines.Any(existing => LineeSimiliConApprossimazione(existing, line)))
                {
                    uniqueLines.Add(line);
                }
            }

            lineStrings = uniqueLines;
        }

        // Verifica se due linee sono simili usando approssimazione
        private bool LineeSimiliConApprossimazione(LineString line1, LineString line2)
        {
            var coords1 = line1.Coordinates;
            var coords2 = line2.Coordinates;

            // Lunghezze diverse implicano linee differenti
            if (coords1.Length != coords2.Length)
                return false;

            // Verifica coordinate con approssimazione in ordine normale o inverso
            return SequenceEqualWithTolerance(coords1, coords2) || SequenceEqualWithTolerance(coords1, coords2.Reverse().ToArray());
        }

        // Confronta due insiemi di coordinate con approssimazione
        private bool SequenceEqualWithTolerance(Coordinate[] coords1, Coordinate[] coords2)
        {
            for (int i = 0; i < coords1.Length; i++)
            {
                if (!Equals2DAPR(coords1[i], coords2[i]))
                {
                    return false;
                }
            }
            return true;
        }

        //-------------------------------------------------------------------------------------------------------------

        //                             LINEE   NON CONNESSE

        //-------------------------------------------------------------------------------------------------------------
        // Funzione per rilevare linee non connesse da entrambi i lati
        public List<LineString> RilevaLineeNonConnesse(double appros= double.NaN)
        {
            double aprtemp = apr;
            if (appros != double.NaN) apr=appros;
            var lineeNonConnesse = new List<LineString>();

            foreach (var line in lineStrings)
            {
                // Prendi i punti iniziale e finale della linea
                var startPoint = line.StartPoint;
                var endPoint = line.EndPoint;

                // Flag per indicare se la linea è connessa
                bool startConnected = false;
                bool endConnected = false;

                // Controlla se la linea è connessa con altre linee
                foreach (var otherLine in lineStrings)
                {
                    if (line == otherLine)
                        continue;

                    var otherStartPoint = otherLine.StartPoint;
                    var otherEndPoint = otherLine.EndPoint;

                    // Controlla se il punto iniziale è connesso a un altro punto finale o iniziale
                    if (UG_APR(startPoint.X, otherStartPoint.X) && UG_APR(startPoint.Y, otherStartPoint.Y) ||
                        UG_APR(startPoint.X, otherEndPoint.X) && UG_APR(startPoint.Y, otherEndPoint.Y))
                    {
                        startConnected = true;
                    }

                    // Controlla se il punto finale è connesso a un altro punto finale o iniziale
                    if (UG_APR(endPoint.X, otherStartPoint.X) && UG_APR(endPoint.Y, otherStartPoint.Y) ||
                        UG_APR(endPoint.X, otherEndPoint.X) && UG_APR(endPoint.Y, otherEndPoint.Y))
                    {
                        endConnected = true;
                    }
                }

                // Se la linea non è connessa da entrambi i lati, aggiungila alla lista
                if (!startConnected || !endConnected)
                {
                    lineeNonConnesse.Add(line);
                }
            }
            apr = aprtemp;
            return lineeNonConnesse;
        }
        //-------------------------------------------------------------------------------------------------------------

        //                             SPEZZA  LINEE

        //-------------------------------------------------------------------------------------------------------------
        public void Spezza_linee()
        {
            Spezzalinee(lineStrings);
        }
        public void Spezzalinee(List<LineString> lineStrings)
        {
            bool debug = TermodelLog.IsEnabled(TermodelLog.LogCategory.spezza);
            if (debug)
                TermodelLog.WriteLog("Inizio funzione Spezzalinee. Numero linee in ingresso: " + lineStrings.Count);

            // Fase 1: Trovare tutti i punti di intersezione
            var puntiIntersezione = new List<Point>();

            for (int i = 0; i < lineStrings.Count; i++)
            {
                var linea1 = lineStrings[i];
                if (debug)
                    TermodelLog.WriteLog($"Analizzando linea {i}: {linea1}");

                for (int j = i + 1; j < lineStrings.Count; j++)
                {
                    var linea2 = lineStrings[j];

                    if (debug)
                        TermodelLog.WriteLog($"→ Confronto linea {i} con linea {j}");
                    /*
                    if (linea1.Intersects(linea2))
                    {
                        Geometry intersezione = linea1.Intersection(linea2);
                    */
                    // sostituito per introdurre approssimazione
                    if (GeometriaHelper.Intersects(linea1, linea2, 0.001))
                    {
                        var intersezione = GeometriaHelper.Intersection(linea1, linea2, 0.001);
  
                    if (debug)
                            TermodelLog.WriteLog($"→ Intersezione trovata tra linea {i} e {j}: {intersezione}");

                        if (intersezione is Point puntoIntersezione)
                        {
                            puntiIntersezione.Add(puntoIntersezione);
                            if (debug)
                                TermodelLog.WriteLog($"→ Punto intersezione aggiunto: {puntoIntersezione.Coordinate}");
                        }
                        else if (debug)
                        {
                            TermodelLog.WriteLog($"→ Intersezione non è un punto ma un {intersezione.GeometryType}");
                        }
                    }
                }
            }

            if (debug)
                TermodelLog.WriteLog($"Totale punti di intersezione rilevati (prima della pulizia): {puntiIntersezione.Count}");

            // Fase 2: Ripulire la lista dai nodi duplicati
            puntiIntersezione = RipulisciPuntiDuplicati(puntiIntersezione);

            if (debug)
                TermodelLog.WriteLog($"Totale punti di intersezione dopo la ripulitura: {puntiIntersezione.Count}");

            // Fase 3: Spezzare ogni linea in corrispondenza dei punti di intersezione
            var nuoveLinee = new List<LineString>();
            int countLineeSpezzate = 0;

            foreach (var linea in lineStrings)
            {
                var segments = SpezzaLineaMultipla(linea, puntiIntersezione);
                nuoveLinee.AddRange(segments);

                if (debug)
                {
                    TermodelLog.WriteLog($"Linea originale: {linea} → spezzata in {segments.Count} segmenti");
                    countLineeSpezzate += segments.Count;
                }
            }

            // Sostituire la lista originale con le nuove linee spezzate
            lineStrings.Clear();
            lineStrings.AddRange(nuoveLinee);

            if (debug)
            {
                TermodelLog.WriteLog($"Numero totale di nuove linee spezzate: {countLineeSpezzate}");
                TermodelLog.WriteLog("Fine funzione Spezzalinee");
            }
        }


        // Funzione per ripulire i punti duplicati, ad esempio punti che si ripetono
        private List<Point> RipulisciPuntiDuplicati(List<Point> punti)
        {
            return punti
                .GroupBy(p => new { p.X, p.Y })
                .Select(g => g.First())
                .ToList();
        }
        bool PuntoValidoPerSpezzamento(LineString linea, Coordinate punto)
        {
            return !linea.GetCoordinateN(0).Equals2D(punto,apr) && !linea.GetCoordinateN(linea.NumPoints - 1).Equals2D(punto,apr);
        }

        // Funzione per spezzare una linea in più segmenti
        private List<LineString> SpezzaLineaMultipla(LineString linea, List<Point> puntiIntersezione)
        {
            var lineeSpezzate = new List<LineString> { linea }; // Inizia con la linea originale
            var userdataOriginale = linea.UserData?.ToString() ?? ""; // Conserva il UserData originale
            bool spezzamentoEseguito;

            // Ciclo iterativo: continua finché ci sono spezzamenti
            do
            {
                spezzamentoEseguito = false;

                for (int i = 0; i < lineeSpezzate.Count; i++) // Usa il ciclo for per iterare e modificare la lista
                {
                    var lineaAttuale = lineeSpezzate[i];
                    bool spezzata = false;

                    foreach (var punto in puntiIntersezione)
                    {
                        var start = lineaAttuale.GetCoordinateN(0);
                        var end = lineaAttuale.GetCoordinateN(lineaAttuale.NumPoints - 1);

                        // Controlla se il punto di intersezione è tra gli estremi della linea
                        if (PuntoTraSegmento(start, end, punto.Coordinate) && PuntoValidoPerSpezzamento(lineaAttuale, punto.Coordinate))
                        {
                            // Log del punto e del segmento
                            //TermodelLog.WriteLog($"[Spezzamento] Punto valido trovato per spezzamento: {punto.Coordinate}");
                            //TermodelLog.WriteLog($"[Spezzamento] Segmento originale: Start({start.X}, {start.Y}) End({end.X}, {end.Y})");

                            // Spezza la linea in due segmenti
                            var primoSegmentoCoord = new List<Coordinate> { lineaAttuale.GetCoordinateN(0), punto.Coordinate }; // Da start a punto
                            var secondoSegmentoCoord = new List<Coordinate> { punto.Coordinate, lineaAttuale.GetCoordinateN(lineaAttuale.NumPoints - 1) }; // Da punto a end
                            
                            var primoSegmento = new LineString(primoSegmentoCoord.ToArray());
                            var secondoSegmento = new LineString(secondoSegmentoCoord.ToArray());

                            // Mantieni il UserData
                            SetUserdata(lineaAttuale, primoSegmento, secondoSegmento, userdataOriginale);

                            // Sostituisci la linea attuale con il segmento accorciato e aggiungi il nuovo segmento
                            lineeSpezzate[i] = primoSegmento; // Sostituisce la linea originale con quella accorciata
                            lineeSpezzate.Insert(i + 1, secondoSegmento); // Aggiunge il nuovo segmento subito dopo

                            spezzamentoEseguito = true;
                            spezzata = true; // Segnala che uno spezzamento è stato eseguito
                            //TermodelLog.WriteLog($"[Spezzamento] Primo segmento creato: Start({primoSegmentoCoord[0].X}, {primoSegmentoCoord[0].Y}) End({primoSegmentoCoord[1].X}, {primoSegmentoCoord[1].Y})");
                            //TermodelLog.WriteLog($"[Spezzamento] Secondo segmento creato: Start({secondoSegmentoCoord[0].X}, {secondoSegmentoCoord[0].Y}) End({secondoSegmentoCoord[1].X}, {secondoSegmentoCoord[1].Y})");
                            //TermodelLog.WriteLog($"-------------------");
                            break; // Passa al prossimo segmento dopo lo spezzamento
                        }
                    }

                    if (spezzata) break; // Se la linea è stata spezzata, riparte dall'inizio della lista
                }

            }
            while (spezzamentoEseguito); // Continua finché ci sono spezzamenti

            return lineeSpezzate;
        }


        // Funzione per verificare se un punto è tra due vertici di un segmento
        private bool PuntoTraSegmento(Coordinate start, Coordinate end, Coordinate punto)
        {
            // Controlla se il punto è uno degli estremi
            if (punto.Equals2D(start) || punto.Equals2D(end))
            {
                return false; // Se il punto è uno degli estremi, non è considerato un'intersezione valida
            }

            // Calcola la distanza totale tra i due estremi
            var distanzaTotale = start.Distance(end);
            // Somma delle distanze dal punto ai due estremi
            var distanzaPunto = start.Distance(punto) + punto.Distance(end);
            var gf = new GeometryFactory();
            Coordinate[] coords = new Coordinate[]{start,end};
            LineString ls = gf.CreateLineString(coords);
            Point pt = gf.CreatePoint(punto);
            double distseg = pt.Distance(ls);
            return (Math.Abs(distseg) < apr);
            //return (Math.Abs(distanzaTotale - distanzaPunto) < apr) && (Math.Abs(distseg) < apr);
            // Verifica se la somma delle distanze dal punto ai vertici è approssimativamente uguale alla lunghezza del segmento
            //return Math.Abs(distanzaTotale - distanzaPunto) < 0.001;

        }
        public void SetUserdata(LineString lineaOriginale, LineString segmento1, LineString segmento2, string userdataOriginale)
        {
            // Se userdataOriginale è inconsistente (null o vuoto), assegna una stringa vuota ai segmenti e esci
            if (string.IsNullOrEmpty(userdataOriginale))
            {
                segmento1.UserData = "";
                segmento2.UserData = "";
                return; // Esci dalla funzione
            }

            // Converti il userdata in un dizionario utilizzando UserdataToDict
            var userdataDict = Utigen.UserdataToDict(userdataOriginale);

            // Ottieni il colore dal dizionario
            string colore = userdataDict[PUserdata.colore];

            // Ottieni Z1 e Z2 dal dizionario e converti in double
            double z1Originale = Utigen.CVStrToDouble(userdataDict[PUserdata.Z1]);
            double z2Originale = Utigen.CVStrToDouble(userdataDict[PUserdata.Z2]);

            if (UG_APR(z1Originale, z2Originale))
            {
                userdataDict[PUserdata.ColDeb] = "1";
                // Assegna la stessa Z ad entrambi i segmenti
                segmento1.UserData = Utigen.DictToUserdata(userdataDict); // 1 per il primo segmento
                userdataDict[PUserdata.ColDeb] = "2";
                segmento2.UserData = Utigen.DictToUserdata(userdataDict); ; // 2 per il secondo segmento
                return; // Esci dalla funzione senza eseguire il resto del codice
            }

            // Calcola la lunghezza totale della linea originale
            double lunghezzaTotale = lineaOriginale.StartPoint.Distance(lineaOriginale.EndPoint);

            // Calcola Z1 e Z2 per il primo segmento (interpolazione lineare)
            double z1Segmento1 = z1Originale + (z2Originale - z1Originale) * (segmento1.StartPoint.Distance(lineaOriginale.StartPoint) / lunghezzaTotale);
            double z2Segmento1 = z1Originale + (z2Originale - z1Originale) * (segmento1.EndPoint.Distance(lineaOriginale.StartPoint) / lunghezzaTotale);

            // Aggiorna il dizionario per il primo segmento
            userdataDict[PUserdata.Z1] = Utigen.DoubleToStrPunto(z1Segmento1);
            userdataDict[PUserdata.Z2] = Utigen.DoubleToStrPunto(z2Segmento1);

            // Assegna il userdata aggiornato al primo segmento
            userdataDict[PUserdata.ColDeb] = "1";
            segmento1.UserData = Utigen.DictToUserdata(userdataDict); // Aggiungi "1" per distinguere il primo segmento

            // Calcola Z1 e Z2 per il secondo segmento (interpolazione lineare)
            double z1Segmento2 = z1Originale + (z2Originale - z1Originale) * (segmento2.StartPoint.Distance(lineaOriginale.StartPoint) / lunghezzaTotale);
            double z2Segmento2 = z1Originale + (z2Originale - z1Originale) * (segmento2.EndPoint.Distance(lineaOriginale.StartPoint) / lunghezzaTotale);

            // Aggiorna il dizionario per il secondo segmento
            userdataDict[PUserdata.Z1] = Utigen.DoubleToStrPunto(z1Segmento2);
            userdataDict[PUserdata.Z2] = Utigen.DoubleToStrPunto(z2Segmento2);

            // Assegna il userdata aggiornato al secondo segmento
            userdataDict[PUserdata.ColDeb] = "2";
            segmento2.UserData = Utigen.DictToUserdata(userdataDict) ; // Aggiungi "2" per distinguere il secondo segmento
        }
        //-------------------------------------------------------------------------------------------------------------

        //                                          FUNZIONI 3D

        //-------------------------------------------------------------------------------------------------------------
        public string DoubleToCVStr(double value)
        {
            // Converti il double in stringa utilizzando CultureInfo.InvariantCulture
            return value.ToString(CultureInfo.InvariantCulture).Replace('.', ',');
        }
        public static double StrToDouble(string input)
        {
            string culture = "en-US";
            // Usa la cultura specificata o quella di default
            CultureInfo cultureInfo = CultureInfo.GetCultureInfo(culture);

            // Prova a convertire usando TryParse
            if (Double.TryParse(input, NumberStyles.Any, cultureInfo, out double result))
            {
                return result; // Conversione riuscita
            }

            // Se la conversione fallisce, solleva un'eccezione personalizzata
            throw new FormatException($"Errore: '{input}' non è un numero valido nel formato della cultura '{culture}'.");
        }
        
        // Metodo per cercare il UserData per coordinate specifiche
        public string GetValoriUserDataByCoordinates(List<Coordinate> coordinates,int indicevariabile)
        {
            var lineString = lineStrings.FirstOrDefault(ls => CoordinatesMatch(ls.Coordinates.ToList(), coordinates));
            if (lineString != null)
            {
                return Utigen.GetItemFromCommaSeparatedString(lineString.UserData?.ToString(), indicevariabile);
            }
            else
            {
                var coordinatesString = string.Join(", ", coordinates.Select(coord => $"({coord.X}, {coord.Y})"));
                TermodelLog.LogError($"Linea del poligono non trova riscontro con l'input {coordinatesString}");
                return "errore";
            }
        }
        public string GetUserDataByCoordinates(List<Coordinate> coordinates)
        {
            var lineString = lineStrings.FirstOrDefault(ls => CoordinatesMatch(ls.Coordinates.ToList(), coordinates));
            if (lineString != null)
            {
                return lineString.UserData?.ToString();
            }
            else
            {
                var coordinatesString = string.Join(", ", coordinates.Select(coord => $"({coord.X}, {coord.Y})"));
                TermodelLog.LogError( $"Linea del poligono non trova riscontro con l'input {coordinatesString}");
                return "errore";
            }
        }
        public double RecuperaZSingolaCoordinata(Coordinate coord)
        {
            // Crea una lista con una singola coordinata
            var coordinates = new List<Coordinate> { coord };

            // Usa GetUZByCoordinates per cercare la Z corrispondente
            double Z = GetUZByCoordinates(coordinates, 1);

            // Se la Z è valida, restituiscila
            if (!double.IsNaN(Z))
            {
                return Z;
            }
            Z = GetUZByCoordinates(coordinates, 2);

            // Se la Z è valida, restituiscila
            if (!double.IsNaN(Z))
            {
                return Z;
            }
            // Se non viene trovata una Z valida, restituisci NaN
            return double.NaN;
        }
        public double CVStrToDouble(string value)
        {
            // Controlla se la stringa è null o vuota
            if (string.IsNullOrEmpty(value))
            {
                return double.NaN; // Restituisce NaN se la stringa è null o vuota
            }
            // Sostituisci la virgola con il punto per la conversione
            string normalizedValue = value.Replace(',', '.');

            // Prova a convertire la stringa in double utilizzando CultureInfo.InvariantCulture
            if (double.TryParse(normalizedValue, NumberStyles.Any, CultureInfo.InvariantCulture, out double result))
            {
                return result;
            }
            else
            {
                // Se la conversione fallisce, restituisci NaN
                return double.NaN;
            }
        }
        public double GetUZByCoordinates1Way(List<Coordinate> coordinates, int ind)
        {
            double oldapr = this.apr;
            this.apr = 0.1;
            // Cerca la linea che corrisponde alle coordinate esatte
            var lineString = lineStrings.FirstOrDefault(ls => CoordinatesMatch1Way(ls.Coordinates.ToList(), coordinates));

            // Se la linea è trovata, restituisci la Z corrispondente all'indice specificato
            if (lineString != null)
            {
                int indz=(int)PUserdata.Z1;
                if (ind == 2) indz = (int)PUserdata.Z2;
                string stitem = Utigen.GetItemFromCommaSeparatedString(lineString.UserData?.ToString(), indz);
                double ceck = CVStrToDouble(stitem);
               // if ((ceck != 0) && (ceck != 1.5) && (ceck != 2))
               // {
               //     ceck = 0;
               // }
                return ceck;
                //  return StrToDouble(GetItemFromCommaSeparatedString(lineString.UserData?.ToString(), ind + 1));
            }
            this.apr= oldapr;
            // Se nessuna linea è trovata, restituisci NaN
            return double.NaN;
        }
        public double GetUZByCoordinates(List<Coordinate> coordinates, int ind)
        {

            // Cerca la linea che corrisponde alle coordinate esatte
            var lineString = lineStrings.FirstOrDefault(ls => CoordinatesMatch(ls.Coordinates.ToList(), coordinates));

            // Se la linea è trovata, restituisci la Z corrispondente all'indice specificato
            if (lineString != null)
            {
                return StrToDouble(Utigen.GetItemFromCommaSeparatedString(lineString.UserData?.ToString(), ind + 1));
            }

            // Se la linea non è trovata, controlla se le coordinate sono invertite
            var lineStringInverted = lineStrings.FirstOrDefault(ls => CoordinatesMatch(ls.Coordinates.ToList(), coordinates.AsEnumerable().Reverse().ToList()));

            if (lineStringInverted != null)
            {
                // Se le coordinate sono invertite, restituisci la Z invertendo l'indice (1 diventa 2, 2 diventa 1)
                int invertedInd = (ind == 1) ? 2 : 1;
                return StrToDouble(Utigen.GetItemFromCommaSeparatedString(lineStringInverted.UserData?.ToString(), invertedInd + 1));
            }

            // Se nessuna linea è trovata, restituisci NaN
            return double.NaN;
        }
        public int GetIndexByCoordinates(List<Coordinate> coordinates)
        {
            var lineString = lineStrings.FirstOrDefault(ls => CoordinatesMatch(ls.Coordinates.ToList(), coordinates));
            if (lineString != null)
            {
                return lineStrings.IndexOf(lineString);
            }
            else
            {
                var coordinatesString = string.Join(", ", coordinates.Select(coord => $"({coord.X}, {coord.Y})"));
                throw new Exception($"Linea del poligono non trova riscontro con l'input {coordinatesString}"); // Solleva un'eccezione con un messaggio descrittivo
            }
        }

        // Funzione privata per confrontare le coordinate
        private bool CoordinatesMatch(List<Coordinate> coordinates1, List<Coordinate> coordinates2)
        {
            if (coordinates1.Count != coordinates2.Count)
                return false;

            bool matchOriginal = true;
            bool matchReversed = true;

            for (int i = 0; i < coordinates1.Count; i++)
            {
                if (!coordinates1[i].Equals2D(coordinates2[i]))
                {
                    matchOriginal = false;
                }
                if (!coordinates1[i].Equals2D(coordinates2[coordinates2.Count - 1 - i]))
                {
                    matchReversed = false;
                }
            }

            return matchOriginal || matchReversed;
        }
       
        public bool Equals2DAPR(Coordinate coord1, Coordinate coord2)
        {
            // Confronta le coordinate X e Y con la tolleranza utilizzando UG_APR
            return UG_APR(coord1.X, coord2.X) && UG_APR(coord1.Y, coord2.Y);
        }
        private bool CoordinatesMatch1Way(List<Coordinate> coordinates1, List<Coordinate> coordinates2)
        {
            // Verifica se il numero di coordinate è diverso
           if (coordinates1.Count != coordinates2.Count)
                return false;

            // Controlla se tutte le coordinate corrispondono nella sequenza diretta
            for (int i = 0; i < coordinates1.Count; i++)
            {
                if (!Equals2DAPR(coordinates1[i],coordinates2[i]))
                //if (!coordinates1[i].Equals(coordinates2[i]))
                {
                    return false; // Se una coordinata non corrisponde, ritorna false
                }
            }

            return true; // Tutte le coordinate corrispondono
        }
        public double SpessoreParete(List<Coordinate> coordinates)
        {
            var tipoLinea = GetValoriUserDataByCoordinates(
                coordinates,
                (int)PUserdata.tlinea);

            // DIVIDI è un separatore topologico dei circuiti e non una
            // parete fisica: non deve produrre alcun offset del perimetro.
            if (string.Equals(
                tipoLinea,
                "DIVIDI",
                StringComparison.OrdinalIgnoreCase))
            {
                return 0;
            }

            var userData = GetValoriUserDataByCoordinates(coordinates, (int)PUserdata.colore);
            if (userData != null)
            {
                var coloreparete = Utigen.GetItemFromCommaSeparatedString(userData, (int)PUserdata.colore);
                if (coloreparete != null)
                {
                    var pareticollection = Database.DB.GetCollection("Pareti");
                    var DescBreve = LeggiDxf.CercaCodiceParete(coloreparete, pareticollection);
                    if (DescBreve != null)
                    {
                        var spessore = Database.DB.GetDataDB("DescBreve",DescBreve, "Spessore", pareticollection);
                        if (spessore != null) return CVStrToDouble(spessore)/100;
                        else return double.NaN; 

                    }
                    else return double.NaN;
                }
                else return double.NaN;
            }
            else return double.NaN;
        }

        // Metodo per ottenere la descrizione delle irregolarità
        public string GetErrori()
        {
            return irregolarita;
        }
    }
}
