// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/LeggiDxf.cs
// Temporary copy. Align/move to shared source when possible.
// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/LeggiDxf.cs
// Temporary copy. Align/move to shared source when possible.
using netDxf;
using netDxf.Blocks;
using netDxf.Collections;
using netDxf.Entities;
using netDxf.Header;
using netDxf.Tables;
using NetTopologySuite.Algorithm;
using NetTopologySuite.Geometries;
using NetTopologySuite.LinearReferencing;
using NetTopologySuite.Operation.Linemerge;
using NetTopologySuite.Operation.Polygonize;
using NetTopologySuite.Triangulate.Tri;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Globalization;
using System.Linq;
using System.Text;
using Termodel;
using Termodel.Core.Model3D;
using Termodel.utilities;
using static Polig3D;
using static Termodel.Leggidxf.LeggiDxf;
using static Termodel.Modello;
using static Termodel.utilities.UtiDb;
using Termodel.Impianti.Pannelli;

namespace Termodel.Leggidxf
{
    public enum PosizionePonte
    {
        Manuale,
        Sopra,
        Sotto,
        Destra,
        Sinistra
    }
    public enum EnumOriginePonte
    {
        Manuale,
        Finestra,
        Rielaborato,
        Parete
    }
    public class TDatilocale
    {
       
        // Proprietà per l'ID del locale
        public string Id { get; set; }

        // Proprietà per la descrizione del locale
        public string Descrizione { get; set; }

        // Proprietà per la superficie netta del locale
        public double SuperficieNetta { get; set; }

        public double SuperficieParetiInPianta =0; 


        // Proprietà per il volume netto del locale
        public double VolumeNetto { get; set; }

        // Proprietà per l'altezza netta media del locale
        public double AltezzaNettaMedia { get; set; }
        public double AltezzaLordaMedia { get; set; }
        public double QuotaPavimento { get; set; }
        public string Zona { get; set; }
        public string tipoSoffitto { get; set; }
        public string confineSoffitto { get; set; }
        public int ColoreCopertura { get; set; } = 0;
        public string tipoPavimento { get; set; }
        public string confinePavimento { get; set; }
        // Costruttore senza parametri
        public TDatilocale()
        {
        }

        // Costruttore con parametri
        public TDatilocale(string id, string descrizione, double superficieNetta, double volumeNetto, double altezzaNettaMedia, double altezzaLordaMedia, double quotapavimento)
        {
            Id = id;
            Descrizione = descrizione;
            SuperficieNetta = superficieNetta;
            VolumeNetto = volumeNetto;
            AltezzaNettaMedia = altezzaNettaMedia;
            AltezzaLordaMedia = altezzaLordaMedia;
            QuotaPavimento = quotapavimento;
            SuperficieParetiInPianta = 0;

        }

        public double AltezzaPareti()
        {
            Modello.netto = false;
            if (Modello.netto)
                return AltezzaNettaMedia;
            else
            if (Modello.numeropiani == 1)
            {
                double altp = AltezzaNettaMedia + (AltezzaLordaMedia - AltezzaNettaMedia) * 2;
                return altp;
            }
           return AltezzaLordaMedia;
        }

        // Metodo override per visualizzare le informazioni del locale
        public override string ToString()
        {
            return $"ID: {Id}, Descrizione: {Descrizione}, Superficie Netta: {SuperficieNetta}, Volume Netto: {VolumeNetto}, Altezza Netta Media: {AltezzaNettaMedia}";
        }
    }
    public class Coordinate3D
    {
        public double X { get; }
        public double Y { get; }
        public double Z { get; }

        public Coordinate3D(double x, double y, double z)
        {
            X = x;
            Y = y;
            Z = z;
        }
    }
 
    public class TDatiSuperficieOpaca
    {
        public string Codice { get; set; }
        
        public string Confine { get; set; }

        public string Id { get; set; }
        // dati per finestra
        public double LunghezzaParete { get; set; }

         public int NumeroAnte { get; set; }
        public double Altezza { get; set; }
        public double Larghezza { get; set; }
        public double Sottofinestra { get; set; }
        public double Sopraluce { get; set; }

        public double SuperficieADetrarre=0;

        public bool Balcone = false;
        public double Attribuzione = 1;
        public EnumOriginePonte OriginePonte= EnumOriginePonte.Parete;
        public bool Verticale;
        public Coordinate3D? Start { get; set; }
        public Coordinate3D? End { get; set; }
        public double LunghezzaPonte
        {
            get
            {
                if (Start == null || End == null) return 0.0;

                double dx = End.X - Start.X;
                double dy = End.Y - Start.Y;
                double dz = End.Z - Start.Z;
                return Math.Sqrt(dx * dx + dy * dy + dz * dz);
            }
        }
        public Coordinate3D? CentroPonte
{
    get
    {
        if (Start == null || End == null) return null;
        return new Coordinate3D(
            (Start.X + End.X) * 0.5,
            (Start.Y + End.Y) * 0.5,
            (Start.Z + End.Z) * 0.5
        );
    }
}
        // ✅ Posizione relativa (Sopra, Sotto, Destra, Sinistra, Manuale)
        public PosizionePonte PosizioneRelativa { get; set; } = PosizionePonte.Manuale;
        public GiunzioneType AngoloPrima { get; set; } = GiunzioneType.Piana;
        public GiunzioneType AngoloDopo { get; set; } = GiunzioneType.Piana;
        // costruttore per finestra
        public TDatiSuperficieOpaca(string id, string codice, double altezza, double larghezza, double sottofinestra,int numeroAnte, double sopraluce)
        {
            Id = id;
            Codice = codice;
            Altezza = altezza;
            Larghezza = larghezza;
            Sottofinestra = sottofinestra;
            Sopraluce = sopraluce;
            NumeroAnte = numeroAnte;
            Confine = null;// Si utilizza quello della superficie a cui è associata 
        }
        // costruttore per superfici opache
        public TDatiSuperficieOpaca(string codice, string confine,
                                   GiunzioneType angoloPrima = GiunzioneType.Piana,
                                   GiunzioneType angoloDopo = GiunzioneType.Piana)
        {
            Codice = codice;
            Confine = confine;

            AngoloPrima = angoloPrima;
            AngoloDopo = angoloDopo;
        }
        // costruttore per ponte
        public TDatiSuperficieOpaca(string codice, double larghezza, double altezza, Coordinate3D start, Coordinate3D end, bool verticale, PosizionePonte posizioneRelativa = PosizionePonte.Manuale, EnumOriginePonte originePonte = EnumOriginePonte.Parete)
        {
            Codice = codice;
            Larghezza = larghezza;
            Altezza = altezza;
            Confine = null; // Si utilizza quello della superficie a cui è associato

            Start = start;
            End = end;
            PosizioneRelativa = posizioneRelativa;
            Verticale = verticale;
            OriginePonte = originePonte;   
        }

    }
    public class TDatiFinestra
    {
        // Proprietà per l'ID del locale
        public string Id { get; set; }

        // Proprietà per la descrizione del locale
        public string Descrizione { get; set; }

        public string Porta = "Struttura trasparente";

        public string Tipo { get; set; }
        public double Altezza { get; set; }
        public double Larghezza { get; set; }
        public double Sottofinestra { get; set; }
        public double SpessorePavimento = 0;
        public double Sopraluce { get; set; }
        public int NumeroAnte { get; set; }
        public TDatiFinestra()
        {
            NumeroAnte = 1;
        }


        // Costruttore con parametri
        public TDatiFinestra(string id, string descrizione, double superficieNetta, double volumeNetto, double altezzaNettaMedia, string DescrBreve, double spessorePavimento)
        {
            Id = id;
            Descrizione = descrizione;
            Sottofinestra = 1;
            Sopraluce = 0;
            SpessorePavimento = spessorePavimento;
        }



        // Metodo override per visualizzare le informazioni del locale
        public override string ToString()
        {
            return $"ID: {Id}, Descrizione: {Descrizione}";
        }
    }
    public class TDatiPonte
    {
        // Proprietà per la descrizione del locale
        public string Descrizione { get; set; }

        public string DescBreve { get; set; }

        public string Orientamento { get; set; }
        public double TrasmLin { get; set; }
        public string Lunghezza { get; set; }
    }
    public partial class LeggiDxf : Component
    {
        // Modificato da Codex per realizzare: il Core headless non conserva controlli WPF.
        private object? drawingCanvas;
        private object? coordinateListBox;
        private string InfoString;
        private double AltezzaNettaPiano;
        private double AltezzaLordaPiano;
        private string FileName;
        private string LayerName;
        private string Nome_Piano;
        private double Quota_Piano;
        private double DirezNord;
        private PosizionePiano Posizionepiano;
        private int GlobModo;
        public static string CAutomatico = "Automatico";
        public static string CEsterno = "Esterno";
        public static string CDaPiano = "Da piano";
        public Coordinate orig { get; set; } = new Coordinate(0, 0);

        public Coordinate Origine(Coordinate parametro)
        {
            if (parametro == null)
            {
                throw new ArgumentNullException(nameof(parametro), "Il parametro non può essere nullo.");
            }

            // Calcola la differenza tra 'parametro' e 'orig'
            return new Coordinate(
                parametro.X - orig.X,
                parametro.Y - orig.Y
            );
        }
        public bool Calpestabile { get; set; } = true;
        public List<Dictionary<string, object>> Locali { get; private set; }
        public List<Dictionary<string, object>> Finestre { get; private set; }
        public List<Dictionary<string, object>> Ponti { get; private set; }
        public List<Dictionary<string, object>> Colmi { get; private set; }
        // Proprietà per contenere un riferimento a un'istanza della classe Modello
        public Modello ModelloEdificio { get; private set; }
        public LeggiDxf(Modello modelloEdificio)
        {
            InitializeComponent();

            // Assegna l'istanza di Modello passata al costruttore alla proprietà ModelloEdificio
            ModelloEdificio = modelloEdificio ?? throw new ArgumentNullException(nameof(modelloEdificio));
        }
        public LeggiDxf()
        {
            InitializeComponent();

        }
        // Proprietà per memorizzare l'istanza di Utidb
        public UtiDb utiDb { get; set; }

        // Altri membri della classe LeggiDxf

        // Costruttore della classe LeggiDxf

        public LeggiDxf(IContainer container)
        {
            container.Add(this);

            InitializeComponent();
        }
        // Modificato da Codex per realizzare: firma neutrale mantenuta soltanto per
        // compatibilità durante la migrazione; renderer e lista non sono usati.
        public LeggiDxf(object? canvas, object? listbox, UtiDb utidbInstance, Modello modelloEdificio)
        {
            this.drawingCanvas = canvas;
            this.coordinateListBox = listbox;
            this.utiDb = utidbInstance;
            ModelloEdificio = modelloEdificio ?? throw new ArgumentNullException(nameof(modelloEdificio));
            InitializeComponent();
        }
        // Proprietà per accedere al documento XML caricato

        public void Associa_Blocchi_A_Parete(string tipo, List<Dictionary<string, object>> blocchi, List<LineString> pareti, double tolleranza)
        {
            foreach (var blocco in blocchi)
            {
                double x = (double)blocco["xins"];
                double y = (double)blocco["yins"];
                var puntoInserimento = new Coordinate(x, y);

                int indiceParetePiùVicino = -1;
                double distanzaMinima = double.MaxValue;

                // Trova la parete più vicina entro la tolleranza
                for (int i = 0; i < pareti.Count; i++)
                {
                    LineString parete = pareti[i];
                    double distanza = parete.Distance(new NetTopologySuite.Geometries.Point(puntoInserimento));

                    if (distanza < distanzaMinima && distanza <= tolleranza)
                    {
                        distanzaMinima = distanza;
                        indiceParetePiùVicino = i;
                    }
                }

                // Se non è stata trovata nessuna parete entro la tolleranza, solleva un'eccezione
                if (indiceParetePiùVicino == -1)
                {
                    HelixDXF.I.ErroreConGrafica($"Blocco {tipo} ( sfera grande e rossa ) non associabile a nessuna parete", null, Quota_Piano);

                    //throw new Exception($"File:{FileName} layer:{LayerName} ,blocco {tipo} non associabile a nessuna parete");
                }

                // Assegna l'indice della parete più vicina al campo "IndiceParete"
                blocco["IndiceParete"] = indiceParetePiùVicino;
            }
        }




        public List<Dictionary<string, object>> Blocchi_parete(List<Dictionary<string, object>> blocchi, List<Coordinate> coordinateParete, double tolleranza)
        {
            // Crea una GeometryFactory per costruire la LineString
            var geometryFactory = new NetTopologySuite.Geometries.GeometryFactory();

            // Crea una LineString dalla lista di coordinate della parete
            var parete = geometryFactory.CreateLineString(coordinateParete.ToArray());

            // Crea una lista per contenere i blocchi vicini alla parete
            var blocchiVicinanza = new List<Dictionary<string, object>>();

            foreach (var blocco in blocchi)
            {
                // Recupera le coordinate del blocco
                double x = (double)blocco["xins"];
                double y = (double)blocco["yins"];
                var puntoInserimento = new Coordinate(x, y);

                // Calcola la distanza tra il punto di inserimento del blocco e la parete
                double distanza = parete.Distance(new NetTopologySuite.Geometries.Point(puntoInserimento));

                // Se il blocco è entro la tolleranza, aggiungilo alla lista
                if (distanza <= tolleranza)
                {
                    blocchiVicinanza.Add(blocco);
                }
            }

            return blocchiVicinanza;
        }


        public List<Dictionary<string, object>> Blocchi_parete_originale(List<Dictionary<string, object>> blocchi, List<Coordinate> coordinateParete)
        {
            // Trova l'indice della parete corrispondente alle coordinate fornite
            int indiceParete = ModelloEdificio.Lines2DCor.GetIndexByCoordinates(coordinateParete);
            //Lines2DCor_temp
            // Filtra i blocchi per selezionare solo quelli che hanno lo stesso indice parete
            var blocchiAssociati = blocchi.Where(blocco => (int)blocco["IndiceParete"] == indiceParete).ToList();

            return blocchiAssociati;
        }
        private TDatiPonte CaricaDatiPonte(Dictionary<string, object> ponte)
        {

            // Crea un nuovo oggetto TDatilocale
            var DatiPonte = new TDatiPonte();


            // Se il primo blocco esiste, carica le proprietà dai tag attributo
            if (ponte != null && ponte.ContainsKey("Attributi"))
            {
                var attributi = (List<Dictionary<string, string>>)ponte["Attributi"];

                foreach (var attributo in attributi)
                {
                    string TagAttributo = attributo["Tag"].ToUpper();
                    switch (TagAttributo)
                    {
                        case "TIPO":
                            DatiPonte.DescBreve = attributo["Valore"];
                            utiDb.VerificaAttributoArchivio("Ponte (PON) ", TagAttributo, ponte, DatiPonte.DescBreve, "Ponti", "DescBreve", Quota_Piano);

                            break;
                        case "LUNGHEZZA":
                            DatiPonte.Lunghezza = attributo["Valore"];
                            if (DatiPonte.Lunghezza.ToLower() != "lunghezza parete")
                            {
                                Utigen.VerificaAttributoNumero("Ponte (PON) ", TagAttributo, ponte, DatiPonte.Lunghezza, Quota_Piano);

                                DatiPonte.Lunghezza = Utigen.DoubleToStrPunto(Utigen.CVStrToDouble_attrib(attributo["Valore"]));
                            }
                            break;
                        case "ORIENTAMENTO":
                            //DatiFinestra.Larghezza = attributo["Valore"];
                            DatiPonte.Orientamento = attributo["Valore"];
                            break;

                    }
                }

            }

            return DatiPonte;
        }
        public void PontiParete(List<Dictionary<string, object>> blocchiFiltrati, double spessoreParete, double AltezzaParete, Coordinate start, Coordinate end)
        {
            // Crea una singola istanza di TDatiPonte
            TDatiPonte ponte = new TDatiPonte();

            foreach (var blocco in blocchiFiltrati)
            {
                ponte = CaricaDatiPonte(blocco);
                //CompletaSuperficieTrasparente(nodoConfine, finestra.Id);
                // Estrai il punto di inserimento dal dizionario utilizzando la forma suggerita
                if (blocco.TryGetValue("xins", out var xValue) && blocco.TryGetValue("yins", out var yValue))
                {
                    // Cast degli oggetti a double per creare la coordinata
                    double xins = Convert.ToDouble(xValue);
                    double yins = Convert.ToDouble(yValue);
                    var puntoInserimento = new Coordinate(xins, yins);

                    // Passa il punto di inserimento insieme alle coordinate della parete a BIM_Finestra
                    double lunghezzaponte = double.NaN;


                    if (ponte.Lunghezza != "Lunghezza parete" && ponte.Lunghezza != "Altezza parete") lunghezzaponte = Utigen.CVStrToDouble(ponte.Lunghezza);

                    if (ponte.Orientamento == "Orizzontale")
                    {
                        Coordinate nuovoStart = start;
                        Coordinate nuovoEnd = end;
                        if (ponte.Lunghezza != "Lunghezza parete")
                        {
                            // Calcola il centro della linea originale
                            var centroX = (start.X + end.X) / 2;
                            var centroY = (start.Y + end.Y) / 2;

                            // Calcola la direzione della linea come vettore normalizzato
                            double dx = end.X - start.X;
                            double dy = end.Y - start.Y;
                            double lunghezzaOriginale = Math.Sqrt(dx * dx + dy * dy);

                            double direzioneX = dx / lunghezzaOriginale;
                            double direzioneY = dy / lunghezzaOriginale;

                            // Calcola la metà della lunghezza del ponte
                            double mezzaLunghezzaPonte = lunghezzaponte / 2;

                            // Calcola i nuovi punti di inizio e fine
                            nuovoStart = new Coordinate(centroX - direzioneX * mezzaLunghezzaPonte, centroY - direzioneY * mezzaLunghezzaPonte);
                            nuovoEnd = new Coordinate(centroX + direzioneX * mezzaLunghezzaPonte, centroY + direzioneY * mezzaLunghezzaPonte);
                        }
                        ModelloEdificio.AggiungiPonteOriz(new Modello.Line(nuovoStart, nuovoEnd), 0, 0, spessoreParete, "Ponte", ponte.DescBreve);

                    }
                    else
                    {
                        if (ponte.Lunghezza == "Altezza parete") lunghezzaponte = AltezzaParete;
                        ModelloEdificio.AggiungiPonteVert(0, puntoInserimento, start, end, spessoreParete, lunghezzaponte, "Ponte", ponte.DescBreve);
                    }

                }
                else
                {
                    // Gestisci il caso in cui il punto di inserimento non sia presente o non sia nel formato corretto
                    Console.WriteLine("Punto di inserimento non trovato o non valido per il blocco.");
                }
            }
        }
        //---------------------------------------------------------------------------------------------------------------------------
        public Modello.Line LineaBaseFinestra(Modello.Line lineaBaseParete, Coordinate puntoInserimentoFinestra, double larghezzaFinestra)
        {
            // Calcola la direzione della lineaBaseParete
            double deltaX = lineaBaseParete.End.X - lineaBaseParete.Start.X;
            double deltaY = lineaBaseParete.End.Y - lineaBaseParete.Start.Y;
            double lunghezzaParete = Math.Sqrt(deltaX * deltaX + deltaY * deltaY);

            // Calcola i componenti di direzione normalizzati della parete
            double dirX = deltaX / lunghezzaParete;
            double dirY = deltaY / lunghezzaParete;

            // Calcola metà della larghezza della finestra per posizionare i punti di inizio e fine
            double halfWidth = larghezzaFinestra / 2;

            // Determina i punti di inizio e fine della linea base della finestra
            Coordinate startPointFinestra = new Coordinate(
                puntoInserimentoFinestra.X - halfWidth * dirX,
                puntoInserimentoFinestra.Y - halfWidth * dirY
            );

            Coordinate endPointFinestra = new Coordinate(
                puntoInserimentoFinestra.X + halfWidth * dirX,
                puntoInserimentoFinestra.Y + halfWidth * dirY
            );

            // Restituisce la linea di base della finestra come un nuovo oggetto Line
            return new Modello.Line(startPointFinestra, endPointFinestra);
        }


        public enum GiunzioneType
        {
            Sporgente,   // Indica una giunzione sporgente
            Rientrante,  // Indica una giunzione rientrante
            Piana        // Indica una giunzione piana
        }
        public static GiunzioneType TipoGiunzione(
           NetTopologySuite.Geometries.Coordinate linea1Start,
           NetTopologySuite.Geometries.Coordinate linea1End,
           NetTopologySuite.Geometries.Coordinate linea2Start,
           NetTopologySuite.Geometries.Coordinate linea2End,
           bool PoligonoADestra)
        {
            // Calcolo dei vettori delle due linee
            Vector v1 = new Vector(linea1End.X - linea1Start.X, linea1End.Y - linea1Start.Y);
            Vector v2 = new Vector(linea2End.X - linea2Start.X, linea2End.Y - linea2Start.Y);

            // Normalizza i vettori
            v1.Normalize();
            v2.Normalize();

            // Calcolo dell'angolo tra i vettori in gradi
            double dotProduct = Vector.Multiply(v1, v2); // Prodotto scalare
            double angle = Math.Acos(dotProduct) * (180 / Math.PI); // Angolo in gradi

            // Determina il tipo di giunzione in base all'angolo
            if (angle < 45)
            {
                return GiunzioneType.Piana;
            }
            else
            {
                // Determina se è sporgente o rientrante
                // Calcolo del prodotto vettoriale per determinare il verso
                double crossProduct = v1.X * v2.Y - v1.Y * v2.X;

                if (PoligonoADestra)
                {
                    // Se il poligono è a destra (orario), invertiamo il significato del crossProduct
                    crossProduct = -crossProduct;
                }

                if (crossProduct > 0)
                {
                    return GiunzioneType.Sporgente;
                }
                else
                {
                    return GiunzioneType.Rientrante;
                }
            }
        }

        public void PontiAutomatici(string DescrBreve, bool parete, double LargLung, double Altezza, double Altezza2, double SottoFinestra, GiunzioneType giunzione, Modello.Line lineaBase, Coordinate puntoInserimento, double quota, PosizionePiano posizionepiano = PosizionePiano.PianoIntermedio)
        {
            if (utiDb.ItemNessuno(DescrBreve))
            {
                //Console.WriteLine("Gruppo di ponti automatici non trovato.");
                return;
            }
            double DimPonte = 0.5;

            // Esegui ricerca del ponte specifico per "Alto" e "Basso" (comuni sia a parete che a finestra)
            string ponteAlto;
            string ponteBasso;
            string postfisso = "";
            EnumOriginePonte origineponte = EnumOriginePonte.Parete;
            if (!parete)
            {
                origineponte = EnumOriginePonte.Finestra;
                postfisso = "Finestre";
            }
            if (parete)
            {
                // Alto
                if (posizionepiano == PosizionePiano.Ultimo)
                {
                    ponteAlto = utiDb.GetDataDB("DescBreve", DescrBreve, "AltoUltimo", utiDb.GetCollection("PontiAutomatici"+postfisso));
                    if (string.IsNullOrEmpty(ponteAlto))
                        ponteAlto = utiDb.GetDataDB("DescBreve", DescrBreve, "Alto", utiDb.GetCollection("PontiAutomatici" + postfisso));
                }
                else
                {
                    ponteAlto = utiDb.GetDataDB("DescBreve", DescrBreve, "Alto", utiDb.GetCollection("PontiAutomatici" + postfisso));
                }

                // Basso
                if (posizionepiano == PosizionePiano.PianoTerra)
                {
                    ponteBasso = utiDb.GetDataDB("DescBreve", DescrBreve, "BassoTerra", utiDb.GetCollection("PontiAutomatici" + postfisso));
                    if (string.IsNullOrEmpty(ponteBasso))
                        ponteBasso = utiDb.GetDataDB("DescBreve", DescrBreve, "Basso", utiDb.GetCollection("PontiAutomatici" + postfisso));
                }
                else
                {
                    ponteBasso = utiDb.GetDataDB("DescBreve", DescrBreve, "Basso", utiDb.GetCollection("PontiAutomatici" + postfisso));
                }
            }
            else
            {
                ponteAlto = utiDb.GetDataDB("DescBreve", DescrBreve, "Alto", utiDb.GetCollection("PontiAutomatici" + postfisso));
                ponteBasso = utiDb.GetDataDB("DescBreve", DescrBreve, "Basso", utiDb.GetCollection("PontiAutomatici" + postfisso));
            }

            string cassonetto = utiDb.GetDataDB("DescBreve", DescrBreve, "TipoCassonetto", utiDb.GetCollection("PontiAutomatici" + postfisso));
            string sottofinestra = utiDb.GetDataDB("DescBreve", DescrBreve, "TipoSottofinestra", utiDb.GetCollection("PontiAutomatici" + postfisso));

            // Utilizzo della linea base per determinare il posizionamento del ponte
            double quotaOrizzontale = parete ? Altezza : SottoFinestra + Altezza;
            double quotaOrizzontale2 = parete ? Altezza2 : SottoFinestra + Altezza;

            Modello.Line lineabaseelaborata = lineaBase;
            if (!parete) lineabaseelaborata = LineaBaseFinestra(lineaBase, puntoInserimento, LargLung);


            // Aggiunta dei ponti orizzontali ("Alto" e "Basso") con `DimPonte` come spessore
            if (!utiDb.ItemNessuno(ponteAlto))
            {
                ModelloEdificio.AggiungiPonteOriz(lineabaseelaborata, quotaOrizzontale, quotaOrizzontale2, DimPonte, "Ponte automatico in alto", ponteAlto,OriginePonte:origineponte);
            }
            if (!string.IsNullOrWhiteSpace(cassonetto) && !utiDb.ItemNessuno(cassonetto))
            {
                double AltCassonetto=Utigen.CVStrToDouble(cassonetto);
                if (!double.IsNaN(AltCassonetto))
                ModelloEdificio.AggiungiPonteOriz(lineabaseelaborata, quotaOrizzontale, quotaOrizzontale2, DimPonte, "Cassonetto", cassonetto, AltCassonetto, EnumOriginePonte.Finestra);
            }
            quotaOrizzontale = parete ? 0 : SottoFinestra;

            if (!utiDb.ItemNessuno(ponteBasso))
            {
                ModelloEdificio.AggiungiPonteOriz(lineabaseelaborata, quotaOrizzontale+quota, quotaOrizzontale, DimPonte, "Ponte automatico in basso", ponteBasso,OriginePonte:origineponte);
            }

            if (!string.IsNullOrWhiteSpace(sottofinestra) && sottofinestra!="Uguale alla parete")
            {
                if (!double.IsNaN(SottoFinestra))
                ModelloEdificio.AggiungiPonteOriz(lineabaseelaborata, quotaOrizzontale+quota, quotaOrizzontale, DimPonte, "Sottofinestra", sottofinestra, SottoFinestra, OriginePonte: origineponte);
            }
            double quotaVerticale = parete ? 0 : SottoFinestra;
            // Aggiunta dei ponti verticali in base al tipo di giunzione per le pareti
            if (parete)
            {
                // Calcolo del punto di inserimento e dei punti start e end per i ponti verticali
                // Usa la quota come Z per determinare l'altezza dei punti verticali
                Coordinate puntoInserimentoPar = new Coordinate(lineaBase.End.X, lineaBase.End.Y);  // Quota come Z
                new Coordinate(lineaBase.Start.X, lineaBase.Start.Y); Coordinate start = new Coordinate(lineaBase.Start.X, lineaBase.Start.Y); ;  // Inizio del ponte
                Coordinate end = new Coordinate(lineaBase.End.X, lineaBase.End.Y);  // Fine del ponte con la stessa Z

                string SpigoloParete;

                switch (giunzione)
                {
                    case GiunzioneType.Sporgente:
                        SpigoloParete = utiDb.GetDataDB("DescBreve", DescrBreve, "SpigoloPareteSporgente", utiDb.GetCollection("PontiAutomatici" + postfisso));
                        if (!utiDb.ItemNessuno(SpigoloParete))
                        {
                            ModelloEdificio.AggiungiPonteVert(quota, puntoInserimentoPar, start, end, DimPonte, Altezza2, "Ponte automatico spigolo sporgente", SpigoloParete);
                        }
                        break;

                    case GiunzioneType.Rientrante:
                        SpigoloParete = utiDb.GetDataDB("DescBreve", DescrBreve, "SpigoloPareteRientrante", utiDb.GetCollection("PontiAutomatici" + postfisso));
                        if (!utiDb.ItemNessuno(SpigoloParete))
                        {
                            ModelloEdificio.AggiungiPonteVert(quota, puntoInserimentoPar, start, end, DimPonte, Altezza2, "Ponte automatico spigolo rientrante", SpigoloParete);
                        }
                        break;

                    case GiunzioneType.Piana:
                        SpigoloParete = utiDb.GetDataDB("DescBreve", DescrBreve, "GiunzioneParetePiana", utiDb.GetCollection("PontiAutomatici" + postfisso));
                        if (!utiDb.ItemNessuno(SpigoloParete))
                        {
                            ModelloEdificio.AggiungiPonteVert(quota, puntoInserimentoPar, start, end, DimPonte, Altezza2, "Ponte automatico giunzione piana", SpigoloParete);
                        }
                        break;
                }
            }
            else
            {

                string LateraliFinestra = utiDb.GetDataDB("DescBreve", DescrBreve, "LateraliFinestra", utiDb.GetCollection("PontiAutomatici" + postfisso));
                if (!utiDb.ItemNessuno(LateraliFinestra))
                {
                    Coordinate start = new Coordinate(lineabaseelaborata.Start.X, lineabaseelaborata.Start.Y);  // Inizio del ponte
                    Coordinate end = new Coordinate(lineabaseelaborata.End.X, lineabaseelaborata.End.Y);
                    ModelloEdificio.AggiungiPonteVert(SottoFinestra, start, start, end, DimPonte, Altezza, "Ponte automatico laterale", LateraliFinestra,EnumOriginePonte.Finestra);
                    ModelloEdificio.AggiungiPonteVert(SottoFinestra, end, start, end, DimPonte, Altezza, "Ponte automatico laterale", LateraliFinestra, EnumOriginePonte.Finestra);

                }

            }
        }

        //---------------------------------------------------------------------------------------------------------------------------

        private TDatiFinestra CaricaDatiFinestra(Dictionary<string, object> finestra)
        {

            // Crea un nuovo oggetto TDatilocale
            var DatiFinestra = new TDatiFinestra();


            // Se il primo blocco esiste, carica le proprietà dai tag attributo
            if (finestra != null && finestra.ContainsKey("Attributi"))
            {
                var attributi = (List<Dictionary<string, string>>)finestra["Attributi"];

                foreach (var attributo in attributi)
                {
                    var valore = attributo["Valore"];
                    valore = valore?.Trim().Replace(";", "");
                    string TagAttributo = attributo["Tag"].ToUpper();
                    switch (TagAttributo)
                    {
                        case "PORTA":
                            DatiFinestra.Porta = valore;
                            if (valore != "Struttura trasparente")
                                utiDb.VerificaAttributoArchivio("Finestra (FIN) ", TagAttributo, finestra, DatiFinestra.Porta, "Pareti", "DescBreve", Quota_Piano);

                            break;
                        case "TIPO":
                            if (valore == "Da piano")
                                DatiFinestra.Tipo = utiDb.GetDataDB("Nome", Nome_Piano, "TipoFinestre", utiDb.GetCollection("Piani"));
                            else DatiFinestra.Tipo = valore;
                            utiDb.VerificaAttributoArchivio("Finestra (FIN) ", TagAttributo, finestra, DatiFinestra.Tipo, "Finestre", "DescBreve", Quota_Piano);

                            break;
                        case "ALTEZZA":
                            //DatiFinestra.Altezza = attributo["Valore"];
                            Utigen.VerificaAttributoNumero("Finestra (FIN) ", TagAttributo, finestra, DatiFinestra.Tipo, Quota_Piano);
                            DatiFinestra.Altezza = Utigen.CVStrToDouble_attrib(valore);

                            break;
                        case "LARGHEZZA":
                            //DatiFinestra.Larghezza = attributo["Valore"];
                            Utigen.VerificaAttributoNumero("Finestra (FIN) ", TagAttributo, finestra, DatiFinestra.Tipo, Quota_Piano);

                            DatiFinestra.Larghezza = Utigen.CVStrToDouble_attrib(valore);
                            break;
                        case "NUMEROANTE":
                            //DatiFinestra.Larghezza = attributo["Valore"];
                            DatiFinestra.NumeroAnte = int.Parse(valore);
                            Utigen.VerificaAttributoNumero("Finestra (FIN) ", TagAttributo, finestra, DatiFinestra.Tipo, Quota_Piano);

                            if (DatiFinestra.NumeroAnte < 1) DatiFinestra.NumeroAnte = 1;
                            break;
                        case "SOTTOFINESTRA":
                            //DatiFinestra.Larghezza = attributo["Valore"];
                            Utigen.VerificaAttributoNumero("Finestra (FIN) ", TagAttributo, finestra, DatiFinestra.Tipo, Quota_Piano);

                            DatiFinestra.Sottofinestra = Utigen.CVStrToDouble_attrib(valore);
                            break;
                        case "SOPRALUCE":
                            //DatiFinestra.Larghezza = attributo["Valore"];
                            Utigen.VerificaAttributoNumero("Finestra (FIN) ", TagAttributo, finestra, DatiFinestra.Tipo, Quota_Piano);

                            DatiFinestra.Sopraluce = Utigen.CVStrToDouble_attrib(valore);
                            break;

                    }
                }
                DatiFinestra.Id = utiDb.GetDataDB("DescBreve", DatiFinestra.Tipo, "Codice", utiDb.GetCollection("Finestre"));
                // Controlla se il risultato è vuoto o nullo
                if (string.IsNullOrEmpty(DatiFinestra.Id))
                {
                    // Segnala l'errore tramite LogError
                    TermodelLog.LogError($"L'attributo CODICE della finestra {DatiFinestra.Tipo} non è stato trovato in archivio.");
                }
            }

            return DatiFinestra;
        }
        public bool PareteFinestrata(TDatiFinestra finestra, double spessoreParete, string pontiFinestra, Modello.Line line)
        {
            string ifFinestrata = utiDb.GetDataDB("DescBreve", finestra.Tipo, "Finestrata", utiDb.GetCollection("Finestre"));
            if (ifFinestrata != "Parete finestrata") return false;
            double lunghezzaParete = line.Start.Distance(line.End);
            double larghezzaFinestra = finestra.Larghezza;

            // Validazione larghezza finestra
            if (larghezzaFinestra <= 0)
            {
                TermodelLog.LogError($"Finestra tipo '{finestra.Tipo}' ha larghezza non valida: {larghezzaFinestra}.");
                return false;
            }

            // Spazio tra finestre in base al ponte
            double spazioTraFinestre = utiDb.ItemNessuno(pontiFinestra) ? 0.0 : 0.2; // default 20cm se ponte presente

            // Calcolo quante finestre stanno sulla parete
            int numFinestre = (int)((lunghezzaParete + spazioTraFinestre) / (larghezzaFinestra + spazioTraFinestre));

            if (numFinestre == 0)
            {
                TermodelLog.LogError($"Parete troppo corta per finestre tipo '{finestra.Tipo}' (L={lunghezzaParete:F2} m).");
                return false;
            }

            // Direzione della parete come vettore normalizzato
            double dx = line.End.X - line.Start.X;
            double dy = line.End.Y - line.Start.Y;
            double lung = Math.Sqrt(dx * dx + dy * dy);
            double ux = dx / lung;
            double uy = dy / lung;

            for (int i = 0; i < numFinestre; i++)
            {
                double offsetCentro = i * (larghezzaFinestra + spazioTraFinestre) + larghezzaFinestra / 2;

                var puntoInserimento = new Coordinate(
                    line.Start.X + ux * offsetCentro,
                    line.Start.Y + uy * offsetCentro
                );

                

                // 🔹 Inserimento nel modello 3D
                ModelloEdificio.AggiungiFinestra(finestra, line.Start, line.End, puntoInserimento, spessoreParete);

                // 🔹 Inserimento nella pianta 2D (se richiesto)
                if (GlobModo == 2 && Calpestabile)
                {
                    GeneraPianta.AggiungiFinestra2D(finestra.Larghezza, line.Start, line.End, puntoInserimento, spessoreParete);
                }

                // 🔹 Eventuale ponte automatico
                if (!utiDb.ItemNessuno(pontiFinestra))
                {
                    PontiAutomatici(
                       DescrBreve: pontiFinestra,
                       parete: false,
                       LargLung: finestra.Larghezza,
                       Altezza: finestra.Altezza,
                       Altezza2: 0, // Se non usato, o passare Sopraluce se rilevante
                       SottoFinestra: finestra.Sottofinestra,
                       giunzione: GiunzioneType.Sporgente,
                       lineaBase: line,
                       puntoInserimento: puntoInserimento,
                       quota: 0 // oppure quota effettiva se disponibile
                   );

                }
            }

            TermodelLog.WriteLog($"Parete finestrata completata: {numFinestre} finestre tipo '{finestra.Tipo}' posizionate.");
            return true;
        }


        public void FinestreParete(List<Dictionary<string, object>> blocchiFiltrati, double spessoreParete, Coordinate start, Coordinate end)
        {
            // Crea una singola istanza di TDatiFinestra
            TDatiFinestra finestra = new TDatiFinestra();

            foreach (var blocco in blocchiFiltrati)
            {
                finestra = CaricaDatiFinestra(blocco);

                // Estrai il punto di inserimento dal dizionario utilizzando la forma suggerita
                if (blocco.TryGetValue("xins", out var xValue) && blocco.TryGetValue("yins", out var yValue))
                {
                    // Cast degli oggetti a double per creare la coordinata
                    double xins = Convert.ToDouble(xValue);
                    double yins = Convert.ToDouble(yValue);
                    var puntoInserimento = new Coordinate(xins, yins);

                    // Passa il punto di inserimento insieme alle coordinate della parete a BIM_Finestra
                    //BIM_Finestra(model, finestra, start, end, puntoInserimento, parete, spessoreParete);
                    var pontiFinestra = utiDb.GetDataDB("DescBreve", finestra.Tipo, "PontiAutomatici", utiDb.GetCollection("Finestre"));
                    var line = new Modello.Line(start, end);
                    if (!PareteFinestrata(finestra, spessoreParete, pontiFinestra, line))
                    {
                        ModelloEdificio.AggiungiFinestra(finestra, start, end, puntoInserimento, spessoreParete);
                        if (GlobModo == 2 && Calpestabile)
                            GeneraPianta.AggiungiFinestra2D(finestra.Larghezza, start, end, puntoInserimento, spessoreParete);
                        if (!utiDb.ItemNessuno(pontiFinestra))
                            PontiAutomatici(pontiFinestra, false, finestra.Larghezza, finestra.Altezza, 0, finestra.Sottofinestra, GiunzioneType.Sporgente, new Modello.Line(start, end), puntoInserimento, 0);
                    }

                }
                else
                {
                    // Gestisci il caso in cui il punto di inserimento non sia presente o non sia nel formato corretto
                    Console.WriteLine("Punto di inserimento non trovato o non valido per il blocco.");
                }
            }
        }

        public string GetComponentIdByCoordinates(Coordinate coord1, Coordinate coord2)
        {
            // Crea una lista per le coordinate da cercare
            List<Coordinate> coordinatesToSearch = new List<Coordinate> { coord1, coord2 };

            // Ottieni i dati utente associati a queste coordinate
            string userData = DXFLineCheck.GetUserDataByCoordinates(coordinatesToSearch);

            // Se sono presenti dati utente, cerca l'ID del componente stratigrafia
            if (userData != null)
            {
                string idComponenteStratigrafia = CercaCodiceParete(userData, utiDb.GetCollection("Pareti"));

                // Restituisci l'ID del componente stratigrafia se trovato
                if (idComponenteStratigrafia != null)
                {
                    return idComponenteStratigrafia;
                }
            }

            // Restituisci null se non viene trovato nessun componente stratigrafia corrispondente
            return null;
        }
        public static NetTopologySuite.Geometries.Polygon CopyExteriorRing(NetTopologySuite.Geometries.Polygon polygonOrig)
        {
            // Crea una GeometryFactory per il nuovo Polygon
            var geometryFactory = new GeometryFactory();

            // Copia profonda delle coordinate dell'ExteriorRing
            var exteriorCoords = polygonOrig.ExteriorRing.Coordinates
                .Select(coord => new Coordinate(coord.X, coord.Y))
                .ToArray();

            // Crea il nuovo LinearRing per l'ExteriorRing
            var exteriorRing = geometryFactory.CreateLinearRing(exteriorCoords);

            // Crea e restituisci un nuovo Polygon con solo l'ExteriorRing
            return geometryFactory.CreatePolygon(exteriorRing);
        }
        public double Calcola_spessore(string codice)
        {
            if (codice != null)
            {
                var spessore = Database.DB.GetDataDB("DescBreve", codice, "Spessore", utiDb.GetCollection("Pareti"));
                if (spessore != null) return Utigen.CVStrToDouble(spessore) / 100;
                else return double.NaN;

            }
            else return double.NaN;
        }

        public void AggiungiParetiLocale(NetTopologySuite.Geometries.Polygon polygon, TDatilocale datiLocale, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> paretiCollection)
        {
            // Identificazione della categoria della zona
            CategoriaZona categoriaZona = CategoriaZona.DaCalcolare;

            if (Database.DB.TipoZona(CategoriaZona.PozzoLuce, datiLocale.Zona))
                categoriaZona = CategoriaZona.PozzoLuce;
            else if (Database.DB.TipoZona(CategoriaZona.Balcone, datiLocale.Zona))
                categoriaZona = CategoriaZona.Balcone;
            else if (Database.DB.TipoZona(CategoriaZona.Adiacente, datiLocale.Zona))
                categoriaZona = CategoriaZona.Adiacente;


            LinearRing anelloEsterno = (LinearRing) polygon.ExteriorRing;
            var PoligonoADestra = !anelloEsterno.IsCCW;

            bool mansardato = false;
            

            //------------    Soffitto   ------------------------
            var idComponenteStratigrafia = utiDb.GetDataDB("DescBreve", datiLocale.tipoSoffitto, "Codice", paretiCollection);
            // Controlla se il risultato è vuoto o nullo
            if (string.IsNullOrEmpty(idComponenteStratigrafia))
            {
                // Segnala l'errore tramite LogError
                TermodelLog.LogError($"Il soffitto con codice {datiLocale.tipoSoffitto} non è stato trovato in archivio.");
            }

            if (!string.IsNullOrEmpty(idComponenteStratigrafia))
            {

                //if (Calpestabile)
                if (Calpestabile && (categoriaZona == CategoriaZona.DaCalcolare || categoriaZona == CategoriaZona.Adiacente))

                {
                    ModelloEdificio.countsoffitti += 1;
                    //if (GlobModo == 2 && datiLocale.confineSoffitto == Modello.C_copertura)
                    if (GlobModo == 2 && datiLocale.ColoreCopertura != 0)
                        {
                        ModelloEdificio.ColoreTettoCor = datiLocale.ColoreCopertura;
                            var tetto = ModelloEdificio.CercaTetto();
                        
                        // Controlla se il tetto o i lineStrings sono null prima di creare l'istanza DXFLineCheck
                        if (tetto != null && tetto.LineCheck != null && tetto.LineCheck.lineStrings != null)
                        {
                            var UdataPoly = ModelloEdificio.Lines2DCor.UserdataPolygon(polygon);
                            mansardato = true;
                            var TettoEPiano = new DXFLineCheck(null);
                            TettoEPiano.AddLineStrings(tetto.LineCheck.lineStrings);
                            ModelloEdificio.SetLines2DCor_provvisorioo(TettoEPiano);
                            TettoEPiano.AddLineStrings(UdataPoly);
  
                            var FaldeLocale = TettoEPiano.ElaboraGrafo(polygon);
                            //ErroreManager.AddErroreDXF(datiLocale.Descrizione, 0, "(debug) Linee (rosse) locale verti tetto+ locale", TettoEPiano.lineStrings, UdataPoly);

                            polygon = TettoEPiano.UnisciPoligoni(FaldeLocale);
                            //var polygon_mansardato = TettoEPiano.UnisciPoligoni(FaldeLocale);
                            int count = 1;
                            foreach (var FaldaLocale in FaldeLocale)
                            {
                                // if (count == 1 && FaldaLocale is NetTopologySuite.Geometries.Polygon poly) ErroreManager.AddErroreDXF(datiLocale.Descrizione, 0, $"(Mansardato:{count}) Linee (rosse) locale verti tetto+ locale", TettoEPiano.lineStrings, TettoEPiano.PolygonToListLinestring(poly), Dis3D: false);

                                //ModelloEdificio.AggiungiSolaio(FaldaLocale, 0.3, 3.3, $"Soffittolocale, falda:{count}", "Tetto", false);
                                //Quote tetti espressi in valoire assoluto
                                //ModelloEdificio.AggiungiSolaio(FaldaLocale, 0.3, datiLocale.AltezzaPareti(), $"S. mansardato, falda:{count}", "Tetto", Solaio3D:true, falde:false, TipoElemento.Mansardato, new TDatiSuperficieOpaca(datiLocale.tipoSoffitto, datiLocale.confineSoffitto));
                                ModelloEdificio.AggiungiSolaio(FaldaLocale, Calcola_spessore(datiLocale.tipoSoffitto), 0, $"S. mansardato:{ModelloEdificio.countsoffitti}, falda:{count}", "Tetto", Solaio3D: true, falde: false, TipoElemento.Mansardato, new TDatiSuperficieOpaca(datiLocale.tipoSoffitto, datiLocale.confineSoffitto));
                                count += 1; 
                            }
                            //ModelloEdificio.RestoreLines2DCor();
                        }
                        else
                        {
                            // Gestione dell'errore o comportamento alternativo
                            TermodelLog.LogError($"Il locale {datiLocale.Descrizione}{Environment.NewLine} " +
                                        $"({InfoString}){Environment.NewLine}" +
                                        $" fa riferimento ad una copertura , ma non esiste un piano copertura.{Environment.NewLine}" +
                                        $"Controllare le proprietà del locale e l'elenco dei piani.");

                        }
                    }
                    else ModelloEdificio.AggiungiSolaio(polygon, Calcola_spessore(datiLocale.tipoSoffitto), datiLocale.AltezzaPareti()+datiLocale.QuotaPavimento, $"Soffitto N.{ModelloEdificio.countsoffitti}", "", false, false, TipoElemento.Soffitto, new TDatiSuperficieOpaca(datiLocale.tipoSoffitto, datiLocale.confineSoffitto));
                }

            }
            else
            {
                TermodelLog.LogError($"idComponenteStratigrafia non trovato per il tipo soffitto {datiLocale.tipoSoffitto} in AggiungiParetiLocale.");
                // Puoi aggiungere ulteriori log o gestione dell'errore qui, se necessario
            }
            //------------    Pavimento   ------------------------
            idComponenteStratigrafia = utiDb.GetDataDB("DescBreve", datiLocale.tipoPavimento, "Codice", paretiCollection);
            // Controlla se il risultato è vuoto o nullo
            if (string.IsNullOrEmpty(idComponenteStratigrafia))
            {
                // Segnala l'errore tramite LogError
                TermodelLog.LogError($"Il pavimento con codice {datiLocale.tipoPavimento} non è stato trovato in archivio.");
            }
            ModelloEdificio.countpavimenti += 1;
            if (!string.IsNullOrEmpty(idComponenteStratigrafia))
            {
                //if (Calpestabile) 
                if (Calpestabile && categoriaZona != CategoriaZona.PozzoLuce)
                    ModelloEdificio.AggiungiSolaio(polygon, Calcola_spessore(datiLocale.tipoPavimento), datiLocale.QuotaPavimento, $"Pavimento N.{ModelloEdificio.countpavimenti}", "", false, false, TipoElemento.Pavimento, new TDatiSuperficieOpaca(datiLocale.tipoPavimento, datiLocale.confinePavimento));
            }
            else
            {
                ErrorManager.ErrorMessage = $"idComponenteStratigrafia non trovato per il tipo pavimento {datiLocale.tipoPavimento} in AggiungiParetiLocale.";
                // Puoi aggiungere ulteriori log o gestione dell'errore qui, se necessario
            }

            // Definizione della variabile userData con valore predefinito
            idComponenteStratigrafia = null;
            //NetTopologySuite.Geometries.Geometry boundary = polygon.Boundary;
            //polygon.ExteriorRing.Coordinates[]
            List<Coordinate> coordinatesToSearch = new List<Coordinate>();
            List<Dictionary<string, object>> blocchiAssociati;
            //if (Calpestabile)
            // Calcolo iniziale "Prima volta" → angolo al primo vertice (indice 0)
            var prev = polygon.ExteriorRing.Coordinates[polygon.ExteriorRing.NumPoints - 2]; // penultimo punto
            var current = polygon.ExteriorRing.Coordinates[0];
            var next = polygon.ExteriorRing.Coordinates[1];

            GiunzioneType giunzionePrima = TipoGiunzione(
                prev,     // linea1Start
                current,  // linea1End
                current,  // linea2Start (uguale a linea1End, vertice comune)
                next,     // linea2End
                PoligonoADestra
            );
            if (Calpestabile && categoriaZona != CategoriaZona.Balcone && categoriaZona  != CategoriaZona.PozzoLuce)
                for (int i = 0; i < polygon.ExteriorRing.NumPoints - 1; i++)
                {
                    
                    // Gestione della chiusura del poligono
                    bool isLastSegment = (i == polygon.ExteriorRing.NumPoints - 2);

                    // Definizione delle linee
                    var linea1Start = polygon.ExteriorRing.Coordinates[i];
                    var linea1End = polygon.ExteriorRing.Coordinates[(i + 1) % polygon.ExteriorRing.NumPoints];
                    var linea2Start = linea1End;
                    var linea2End = isLastSegment
                        ? polygon.ExteriorRing.Coordinates[1] // Collegamento al secondo punto per chiusura
                        : polygon.ExteriorRing.Coordinates[(i + 2) % polygon.ExteriorRing.NumPoints];

                    // Calcolo del tipo di giunzione
                   
                    GiunzioneType giunzione = TipoGiunzione(linea1Start, linea1End, linea2Start, linea2End, PoligonoADestra);
                    /*
                    TermodelLog.WriteLog(
                    $"[Giunzione Parete i={i}] " +
                    $"linea1Start=({linea1Start.X:0.###},{linea1Start.Y:0.###}) → " +
                    $"linea1End=({linea1End.X:0.###},{linea1End.Y:0.###}) → " +
                    $"linea2Start=({linea2Start.X:0.###},{linea2Start.Y:0.###}) | " +
                    $"linea2End=({linea2End.X:0.###},{linea2End.Y:0.###}) | " +
                    $"Giunzione: {giunzione}"
                    );
                    */
                    coordinatesToSearch.Clear();
                    coordinatesToSearch.Add(polygon.ExteriorRing.Coordinates[i]);
                    coordinatesToSearch.Add(polygon.ExteriorRing.Coordinates[i + 1]);
                    string userData = null;
                    //if (!mansardato) 
                    userData = ModelloEdificio.Lines2DCor.GetUserDataByCoordinates(coordinatesToSearch);
                    string confine = "Sconosciuto";
                    string coloreparete = null;
                    if (userData != null)
                    {
                        coloreparete = Utigen.GetItemFromCommaSeparatedString(userData, (int)PUserdata.colore);
                        confine = Utigen.GetItemFromCommaSeparatedString(userData, (int)PUserdata.tlinea);
                        idComponenteStratigrafia = CercaCodiceParete(coloreparete, paretiCollection);
                    }
                    var datiparete = new TDatiSuperficieOpaca(idComponenteStratigrafia, confine,giunzionePrima,giunzione);
                    var spessoreparete =
                        string.Equals(
                            confine,
                            "DIVIDI",
                            StringComparison.OrdinalIgnoreCase)
                            ? 0
                            : ModelloEdificio.Lines2DCor.SpessoreParete(coordinatesToSearch);
                    if (confine == null)
                    {
                        TermodelLog.LogError($"Confine  non trovato per userdata {userData} in AggiungiParetiLocale.");
                        // Puoi aggiungere ulteriori log o gestione dell'errore qui, se necessario
                    }
                    if (idComponenteStratigrafia == null)
                    {
                        TermodelLog.LogError($"idComponenteStratigrafia non trovato userdata {userData} in AggiungiParetiLocale.");
                        // Puoi aggiungere ulteriori log o gestione dell'errore qui, se necessario
                    }
                    Modello.Line lineponte = new Modello.Line(coordinatesToSearch[0], coordinatesToSearch[1]);

                    bool invertiti = false;
                    if (!PoligonoADestra)
                    {
                        invertiti = true;
                        Coordinate temp = coordinatesToSearch[0];
                        coordinatesToSearch[0] = coordinatesToSearch[1];
                        coordinatesToSearch[1] = temp;
                    }

                    Modello.Line line = new Modello.Line(coordinatesToSearch[0], coordinatesToSearch[1]);
                   

                    double LengthLine = Math.Sqrt(
                    Math.Pow(coordinatesToSearch[1].X - coordinatesToSearch[0].X, 2) +
                    Math.Pow(coordinatesToSearch[1].Y - coordinatesToSearch[0].Y, 2));
                    datiparete.LunghezzaParete = LengthLine;
                    var altezzaPonti1 = datiLocale.AltezzaPareti();
                    var altezzaPonti2 = datiLocale.AltezzaPareti();

                    ModelloEdificio.countpareti += 1;
                    if (mansardato)
                    {
                        var h1 = ModelloEdificio.Tettocor.CalcZ(coordinatesToSearch[0].X, coordinatesToSearch[0].Y, ModelloEdificio.Tetti3dCor);
                        var h2 = ModelloEdificio.Tettocor.CalcZ(coordinatesToSearch[1].X, coordinatesToSearch[1].Y, ModelloEdificio.Tetti3dCor);
                        //altezzaPonti1 = h1 + datiLocale.AltezzaPareti();
                        //altezzaPonti2 = h2 + datiLocale.AltezzaPareti();
                        //ModelloEdificio.AggiungiParete(line, h1 + datiLocale.AltezzaPareti(), h2 + datiLocale.AltezzaPareti(), spessoreparete, $"Parete N.{ModelloEdificio.countpareti}", "", datiparete);
                        //Le quote dei tetti sono in valore assoluto
                        h1 -= ModelloEdificio.QuotaCorrente;
                        h2 -= ModelloEdificio.QuotaCorrente;
                        altezzaPonti1 = h1;
                        altezzaPonti2 = h2;
                        ModelloEdificio.AggiungiParete(line, datiLocale.QuotaPavimento, h1 - datiLocale.QuotaPavimento, h2 - datiLocale.QuotaPavimento, spessoreparete, $"Parete N.{ModelloEdificio.countpareti}", "", datiparete);
                    }
                    else
                    {
                        double altezzaPar = datiLocale.AltezzaPareti();
                        ModelloEdificio.AggiungiParete(line, datiLocale.QuotaPavimento, altezzaPar, altezzaPar, spessoreparete, $"Parete N.{ModelloEdificio.countpareti}", "", datiparete);
                    }
                    giunzionePrima = giunzione;
                    if (!string.Equals(confine, "FITTIZIA", StringComparison.OrdinalIgnoreCase) &&
                        !string.Equals(confine, "DIVIDI", StringComparison.OrdinalIgnoreCase))
                    datiLocale.SuperficieParetiInPianta += LengthLine * spessoreparete;
                    
                    blocchiAssociati = Blocchi_parete(Finestre, coordinatesToSearch,Geometria.Appros);
                    FinestreParete(blocchiAssociati, spessoreparete, coordinatesToSearch[0], coordinatesToSearch[1]);
                    blocchiAssociati = Blocchi_parete(Ponti, coordinatesToSearch, Geometria.Appros);
                    PontiParete(blocchiAssociati, spessoreparete, datiLocale.AltezzaPareti(), coordinatesToSearch[0], coordinatesToSearch[1]);


                    var ponteParete = utiDb.GetDataDB("DescBreve", idComponenteStratigrafia, "PontiAutomatici", utiDb.GetCollection("Pareti"));
                    // Controlla se il risultato è vuoto o nullo
                    if (string.IsNullOrEmpty(ponteParete))
                    {
                        // Segnala l'errore tramite LogError
                        TermodelLog.LogError($"Il ponte termico automatico con codice {idComponenteStratigrafia} non è stato trovato in archivio.");
                    }
                    else if (!utiDb.ItemNessuno(ponteParete))
                    // ModelloEdificio.AggiungiPonteOriz(line, 3, 0.5, "Ponte", "Ponte");
                    {
                        if (invertiti)
                        {
                            double temp = altezzaPonti1;
                            altezzaPonti1 = altezzaPonti2;
                            altezzaPonti2 = temp;
                        }
                        PontiAutomatici(ponteParete, true, 0, altezzaPonti1, altezzaPonti2, 0, giunzione, lineponte, new Coordinate(0, 0), 0, Posizionepiano);
                    }  
                }

            if (mansardato) ModelloEdificio.RestoreLines2DCor();
        }

        public List<Dictionary<string, object>> LeggiBlocchi(DxfDocument dxf, string layer, string nomeBlocco)
        {
            var blocchiTrovati = new List<Dictionary<string, object>>();

            // Itera su tutti i blocchi nel documento DXF
            foreach (Insert blocco in dxf.Inserts)
            {
                // Controlla se il blocco si trova sul layer specificato e ha il nome richiesto
                if (blocco.Layer.Name.ToLower() == layer.ToLower() && blocco.Block.Name == nomeBlocco)
                {
                    // Ottieni il punto di inserimento del blocco
                    double x = blocco.Position.X;
                    double y = blocco.Position.Y;

                    // Crea una lista per gli attributi del blocco
                    var attributi = new List<Dictionary<string, string>>();

                    // Itera sugli attributi del blocco (se presenti)
                    foreach (netDxf.Entities.Attribute attribute in blocco.Attributes)
                    {
                        var attributo = new Dictionary<string, string>
                {
                    { "Tag", attribute.Tag },
                    { "Valore", attribute.Value?.ToString() ?? string.Empty }  // Gestisci valori nulli
                };
                        attributi.Add(attributo);
                    }

                    // Crea un dizionario per rappresentare il blocco e le sue proprietà
                    var bloccoDict = new Dictionary<string, object>
            {
                { "xins", x-orig.X },
                { "yins", y-orig.Y },
                { "Attributi", attributi },
                { "IndiceParete", -1 }
            };

                    blocchiTrovati.Add(bloccoDict);
                }
            }

            return blocchiTrovati;
        }
        //----------------------- Estrae la lista di blocchi contenuti in un poliono
        public List<Dictionary<string, object>> DatiLocale(NetTopologySuite.Geometries.Polygon polygon, List<Dictionary<string, object>> blocchi)
        {
            var blocchiNelPoligono = new List<Dictionary<string, object>>();

            foreach (var blocco in blocchi)
            {
                if (blocco.TryGetValue("xins", out var xValue) && blocco.TryGetValue("yins", out var yValue))
                {
                    // Converti le coordinate in double
                    if (double.TryParse(xValue.ToString(), out double x) &&
                        double.TryParse(yValue.ToString(), out double y))
                    {
                        // Crea un punto usando le coordinate
                        var punto = new NetTopologySuite.Geometries.Point(x, y);

                        // Verifica se il punto si trova all'interno del poligono
                        if (polygon.Contains(punto))
                        {
                            blocchiNelPoligono.Add(blocco);
                        }
                    }
                }
            }

            return blocchiNelPoligono;
        }
        //------------------------------------ Estrae i dati del locale dagli attributi
        // Modificato da Codex per realizzare: censimento preliminare dei locali
        // senza segnalare subito l'assenza del simbolo nelle suddivisioni DIVIDI.
        private TDatilocale CaricaDatiLocale(
            NetTopologySuite.Geometries.Polygon polygonShape,
            int localeCounter,
            bool segnalaSimboloMancante = true)

        {
            // Estrae la lista di blocchi contenuti in un poliono
            var Attributilocale = DatiLocale(polygonShape, Locali);


            //------------------------------------ Estrae i dati del locale dagli attributi
            var nuovoLocale = new TDatilocale
            {
                Id = $"locale_{localeCounter}",
                SuperficieNetta = Math.Round(polygonShape.Area, 1),
                VolumeNetto = Math.Round(polygonShape.Area * 3, 1), // esempio di calcolo del volume
                AltezzaNettaMedia = AltezzaNettaPiano, // esempio di altezza media
                AltezzaLordaMedia = AltezzaLordaPiano,
                QuotaPavimento = 0 // esempio di altezza media
            };
            // Estrai il primo blocco dalla lista Attributilocale, se esiste
            var primoBlocco = Attributilocale.FirstOrDefault();
            if (primoBlocco == null)
            {
                if (segnalaSimboloMancante && GlobModo == 2)
                    //TermodelLog.LogError($"Errore nel disegno CAD{Environment.NewLine} Piano: {Nome_Piano}{Environment.NewLine}Layer: {LayerName}{Environment.NewLine}Un perimetro chiuso non è stato identificato con il blocco locale{Environment.NewLine}Hai dimenticato il simbolo apposito{Environment.NewLine}oppure il Layer del simbolo non è -{LayerName}-.");
                    HelixDXF.I.ErroreConGrafica("Un perimetro chiuso ( linee rosse ) non è stato identificato con il blocco locale", HelixDXF_class.EstraiLinee2DdaPoligono(polygonShape), Quota_Piano);
                return null;
            }
            // Se il primo blocco esiste, carica le proprietà dai tag attributo
            if (primoBlocco != null && primoBlocco.ContainsKey("Attributi"))
            {
                var attributi = (List<Dictionary<string, string>>)primoBlocco["Attributi"];

                foreach (var attributo in attributi)
                {
                    string TagAttributo = attributo["Tag"].ToUpper();
                    switch (TagAttributo)
                    {
                        case "ZONA":
                            nuovoLocale.Zona = attributo["Valore"];
                            utiDb.VerificaAttributoArchivio("locale (LOC) ", TagAttributo, primoBlocco, nuovoLocale.Zona, "Zone", "Codice", Quota_Piano);
                            break;
                        case "TSOF":
                            nuovoLocale.tipoSoffitto = attributo["Valore"];
                            utiDb.VerificaAttributoArchivio("locale (LOC) ", TagAttributo, primoBlocco, nuovoLocale.tipoSoffitto, "Pareti", "DescBreve", Quota_Piano);

                            break;
                        case "CSOF":
                            string confineS = attributo["Valore"];
                            if (confineS == CAutomatico)
                                confineS = utiDb.GetDataDBSingleRow("ConfineSoffittoAutomatico", utiDb.GetCollection("DatiCad"));
                            nuovoLocale.confineSoffitto = confineS;
                            if (confineS.ToLower() != "esterno")
                            utiDb.VerificaAttributoArchivio("locale (LOC) ", TagAttributo, primoBlocco, confineS, "Confini", "Codice", Quota_Piano);

                            break;
                        case "CCOPERTURA":
                            int Colorec;
                            string valoreColore = attributo["Valore"];

                            // Tenta di convertire in intero e verifica che sia valido
                            if (int.TryParse(TogliDescColore(valoreColore), out Colorec))
                            {
                                nuovoLocale.ColoreCopertura = Colorec; // Assegna il valore solo se è valido
                            }
                            else
                            {
                                Console.WriteLine($"Errore: Il valore '{valoreColore}' non è un numero intero valido per il colore della copertura.");
                                nuovoLocale.ColoreCopertura = 0; // Imposta un valore di default se la conversione fallisce
                            }
                            break;
                        case "TPAV":
                            nuovoLocale.tipoPavimento = attributo["Valore"];
                            utiDb.VerificaAttributoArchivio("locale (LOC) ", TagAttributo, primoBlocco, nuovoLocale.tipoPavimento, "Pareti", "DescBreve", Quota_Piano);

                            break;
                        case "CPAV":
                            string confineP = attributo["Valore"];
                            if (confineP == CAutomatico)
                                confineP = utiDb.GetDataDBSingleRow("ConfinePavimentoAutomatico", utiDb.GetCollection("DatiCad"));
                            nuovoLocale.confinePavimento = confineP;
                            if (confineP.ToLower() != "esterno")
                                utiDb.VerificaAttributoArchivio("locale (LOC) ", TagAttributo, primoBlocco, confineP, "Confini", "Codice", Quota_Piano);

                            break;
                        case "ALTEZZANETTA":
                            string ALTEZZANETTA = attributo["Valore"];
                            
                                if (ALTEZZANETTA != CDaPiano)
                                {
                                    Utigen.VerificaAttributoNumero("locale (LOC) ", TagAttributo, primoBlocco, ALTEZZANETTA, Quota_Piano);

                                    nuovoLocale.AltezzaNettaMedia = Utigen.CVStrToDouble_attrib(ALTEZZANETTA);
                                }
                         break;
                        case "ALTEZZALORDA":
                            string ALTEZZALORDA = attributo["Valore"];
                            
                            if (ALTEZZALORDA != CDaPiano)
                            {
                                Utigen.VerificaAttributoNumero("locale (LOC) ", TagAttributo, primoBlocco, ALTEZZALORDA, Quota_Piano);

                                nuovoLocale.AltezzaLordaMedia = Utigen.CVStrToDouble_attrib(ALTEZZALORDA);
                            }
                            break;
                        case "QUOTAPAVIMENTO":
                            string QUOTAPAVIMENTO = attributo["Valore"];
                            
                            if (QUOTAPAVIMENTO != CDaPiano)
                            {
                                Utigen.VerificaAttributoNumero("locale (LOC) ", TagAttributo, primoBlocco, QUOTAPAVIMENTO, Quota_Piano);

                                nuovoLocale.QuotaPavimento = Utigen.CVStrToDouble_attrib(QUOTAPAVIMENTO);
                            }
                            break;
                        case "DESCR.":
                            nuovoLocale.Descrizione = attributo["Valore"];
                            break;
                    }
                }
            }
            if (double.IsNaN(nuovoLocale.AltezzaNettaMedia))
                nuovoLocale.AltezzaNettaMedia = AltezzaNettaPiano;
            return nuovoLocale;
        }


        public void AssociaBlocchiAParete(string tipo, List<Dictionary<string, object>> blocchi, List<LineString> pareti, double tolleranza)
        {
            int count = 0;
            foreach (var blocco in blocchi)
            {
                TermodelLog.WriteLog($"Analizzo blocco {blocco.ToString}",category:TermodelLog.LogCategory.colmi);
                double x = (double)blocco["xins"];
                double y = (double)blocco["yins"];
                var puntoInserimento = new Coordinate(x, y);

                int indiceParetePiùVicino = -1;
                double distanzaMinima = double.MaxValue;

                // Trova la parete più vicina entro la tolleranza
                for (int i = 0; i < pareti.Count; i++)
                {
                    LineString parete = pareti[i];
                    double distanza = parete.Distance(new NetTopologySuite.Geometries.Point(puntoInserimento));

                    if (distanza < distanzaMinima && distanza <= tolleranza)
                    {
                        distanzaMinima = distanza;
                        indiceParetePiùVicino = i;
                    }
                }

                // Se non è stata trovata nessuna parete entro la tolleranza, solleva un'eccezione
                if (indiceParetePiùVicino == -1)
                {
                    if (tipo != "Colmo")
                       HelixDXF.I.ErroreConGrafica($"Blocco {tipo} ( sfera grande e rossa ) non associabile a nessuna parete", null, Quota_Piano, blocco);

                    //throw new Exception($"File:{FileName} layer:{LayerName} ,blocco {tipo} non associabile a nessuna parete");
                }
                else
                {
                    // Assegna l'indice della parete più vicina al campo "IndiceParete"
                    blocco["IndiceParete"] = indiceParetePiùVicino;
                    if (tipo == "Colmo")
                    {
                        //TermodelLog.WriteLog($"➡️ Blocco COLMO trovato in X={blocco["xins"]}, Y={blocco["yins"]}");

                        var attributi = (List<Dictionary<string, string>>)blocco["Attributi"];
                        var parete = pareti[indiceParetePiùVicino];
                        // creo lo sced da aggiungere
                        var sced = new Sced
                        {
                            StartCoordinate = parete.StartPoint.Coordinate,
                            EndCoordinate = parete.EndPoint.Coordinate,
                            BaseSced = 0,
                            AltezzaSced = 0
                        };
                        foreach (var attributo in attributi)
                        {
                            switch (attributo["Tag"].ToUpper())
                            {
                                case "QUOTACOLMO":
                                    count += 1;

                                    TermodelLog.WriteLog($@"🔧 QUOTACOLMO = {attributo["Valore"]}
↪️ assegnata alla parete #{indiceParetePiùVicino}
📐 coordinate:
   - start: X={parete.StartPoint.X} Y={parete.StartPoint.Y}
   - end:   X={parete.EndPoint.X} Y={parete.EndPoint.Y}", category: TermodelLog.LogCategory.colmi);

                                    parete.UserData = Utigen.SetUserdataValue(parete.UserData.ToString(), attributo["Valore"], PUserdata.Z1);
                                    parete.UserData = Utigen.SetUserdataValue(parete.UserData.ToString(), attributo["Valore"], PUserdata.Z2);
                                    sced.AltezzaSced = Utigen.CVStrToDouble_attrib( attributo["Valore"]);
                                    break;

                                case "QUOTAGRONDA":
                                    TermodelLog.WriteLog($"📐 QUOTAGRONDA = {attributo["Valore"]} registrata in ModelloEdificio.QuotaGrondaCor", category: TermodelLog.LogCategory.colmi);
                                    ModelloEdificio.QuotaGrondaCor = Utigen.CVStrToDouble(attributo["Valore"]);
                                    break;
                                case "QUOTASHED":
                                    TermodelLog.WriteLog($"📐 QUOTASHED = {attributo["Valore"]} registrata in ModelloEdificio.QuotaGrondaCor", category: TermodelLog.LogCategory.colmi);
                                    sced.BaseSced = Utigen.CVStrToDouble_attrib(attributo["Valore"]);
                                    break;
                                case "LATOPARTEBASSA":
                                    string att = attributo["Valore"].ToLower();
                                    if (att == "destra o sopra" || att == "sinistra o sotto")
                                    {
                                        // Aggiungi lo sced alla lista
                                        ModelloEdificio.scedList.Add(sced);
                                    }
                                    break;
                            }
                        }
                    }

                }
                
            }
            TermodelLog.WriteLog($"Assegnati {count} linee a blocchi tipo:{tipo}");
        }
        // Modificato da Codex per realizzare: vettore geometrico neutrale al posto di XbimVector3D.
        public ModelVector3D Normalize(ModelVector3D vector)
        {
            double length = Math.Sqrt(vector.X * vector.X + vector.Y * vector.Y + vector.Z * vector.Z);
            if (length > 0)
            {
                return new ModelVector3D(vector.X / length, vector.Y / length, vector.Z / length);
            }
            return vector; // Restituisce il vettore originale se la lunghezza è zero (evita la divisione per zero)
        }

        private static string TogliDescColore(string input)
        {
            if (input == null)
                return string.Empty;

            // Cerca la posizione del primo "-"
            int index = input.IndexOf('-');
            if (index != -1)
            {
                // Rimuove tutto ciò che segue il "-"
                input = input.Substring(0, index);
            }

            // Rimuove gli spazi bianchi
            return new string(input.Where(c => !char.IsWhiteSpace(c)).ToArray());
        }

        public static string CercaCodiceParete(string coloreCad, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> paretiCollection)
        {
            string codiceParete = null;

            foreach (var parete in paretiCollection)
            {
                if (parete.ContainsKey("Colore") && TogliDescColore(parete["Colore"]?.ToString()) == coloreCad)
                {
                    codiceParete = parete.ContainsKey("DescBreve") ? parete["DescBreve"]?.ToString() : string.Empty;
                    break; // Trovata corrispondenza, esci dal ciclo
                }
            }
            if (codiceParete == null)
                TermodelLog.LogError($"Parete con il colore {coloreCad} non trovato nell'archivio pareti.");
            return codiceParete; // Restituisci il codice trovato o stringa vuota se non trovato
        }

        // Funzione per ottenere il UserData di una LineString cercandola per coordinate
        private List<NetTopologySuite.Geometries.LineString> lineStrings = new List<NetTopologySuite.Geometries.LineString>();
        // Proprietà DXFLineCheck
        public DXFLineCheck DXFLineCheck { get; private set; }
        // Funzione per verificare se due array di Coordinate corrispondono
        public static string StringNord_xml(double angolo)
        {
            //La codifica Blumatica che si spera sia quella corretta XML
            return StringNord(angolo+180);
        }
        public static string StringNord(double angolo)
        {
            // Normalizza l'angolo tra 0 e 360 gradi
            angolo = angolo % 360;
            if (angolo < 0)
            {
                angolo += 360;
            }

            string direzioneCardinale = "";

            if ((angolo >= 0 && angolo < 22.5) || (angolo >= 337.5 && angolo < 360))
            {
                direzioneCardinale = "Nord";
            }
            else if (angolo >= 22.5 && angolo < 67.5)
            {
                direzioneCardinale = "Nord-Est";
            }
            else if (angolo >= 67.5 && angolo < 112.5)
            {
                direzioneCardinale = "Est";
            }
            else if (angolo >= 112.5 && angolo < 157.5)
            {
                direzioneCardinale = "Sud-Est";
            }
            else if (angolo >= 157.5 && angolo < 202.5)
            {
                direzioneCardinale = "Sud";
            }
            else if (angolo >= 202.5 && angolo < 247.5)
            {
                direzioneCardinale = "Sud-Ovest";
            }
            else if (angolo >= 247.5 && angolo < 292.5)
            {
                direzioneCardinale = "Ovest";
            }
            else if (angolo >= 292.5 && angolo < 337.5)
            {
                direzioneCardinale = "Nord-Ovest";
            }

            // Restituisci la direzione cardinale con l'angolo tra parentesi senza cifre decimali
            return $"{direzioneCardinale} ({Math.Round(angolo)})";
        }
        public static string StringInclinazione(double inclinazione)
        {
            // Normalizza inclinazione tra 0 e 360
            inclinazione = inclinazione % 360;
            if (inclinazione < 0)
            {
                inclinazione += 360;
            }

            string tipoSuperficie = "";

            // Definizione dei range
            if (Math.Abs(inclinazione - 0) < 1e-2 || Math.Abs(inclinazione - 360) < 1e-2)
            {
                tipoSuperficie = "Solaio";
            }
            else if (Math.Abs(inclinazione - 180) < 1e-2)
            {
                tipoSuperficie = "Pavimento";
            }
            else if (Math.Abs(inclinazione - 90) < 1e-2 || Math.Abs(inclinazione - 270) < 1e-2)
            {
                tipoSuperficie = "Parete";
            }
            else
            {
                tipoSuperficie = "Soffitto mansardato";
            }

            // Restituisci il tipo superficie con l'inclinazione arrotondata
            return $"{tipoSuperficie} ({Math.Round(inclinazione)}°)";
        }

        public double RilevaNord(DxfDocument dxf, string layerName)
        {
            double DirezNord = double.NaN; // Valore predefinito nel caso in cui non venga trovato il blocco

            var blocchiNord = dxf.Blocks
                .Where(block => block.Name.Equals("nord", StringComparison.OrdinalIgnoreCase));

            foreach (var block in blocchiNord)
            {
                foreach (var insert in dxf.Inserts)
                {
                    if (
                        //insert.Layer.Name.Equals(layerName, StringComparison.OrdinalIgnoreCase) &&
                        insert.Block.Name.Equals(block.Name, StringComparison.OrdinalIgnoreCase))
                    {
                        // Il blocco "nord" è disegnato con la freccia rivolta verso l'alto (Y+),
                        // quindi quando insert.Rotation = 0, in realtà punta a Nord (non a Est).
                        // Aggiungiamo 90° per riallineare il riferimento con il sistema CAD (0° = Est)
                        DirezNord = (insert.Rotation + 90) % 360;
                        string direzioneCardinale = StringNord(DirezNord);
                        InfoString += $"Parte superiore del disegno rivolta a: {direzioneCardinale}";
                        return DirezNord; // Restituisce la direzione del nord trovata
                    }
                }
            }

            if (double.IsNaN(DirezNord))
            {
                //InfoString += "Blocco 'nord' non trovato sul layer specificato.";
            }

            return DirezNord;
        }
        public Coordinate RilevaAllineamento(DxfDocument dxf, string layerName)
        {
            // Inizializza il punto di inserimento a (0, 0, 0)
            Coordinate puntoInserimento = new Coordinate(0, 0);

            // Trova tutti i blocchi con il nome "allinea"
            var blocchiAllinea = dxf.Blocks
                .Where(block => block.Name.Equals("allinea", StringComparison.OrdinalIgnoreCase));

            // Itera sui blocchi trovati
            foreach (var block in blocchiAllinea)
            {
                // Cerca le istanze di inserimento del blocco
                foreach (var insert in dxf.Inserts)
                {
                    if (insert.Layer.Name.Equals(layerName, StringComparison.OrdinalIgnoreCase) &&
                        insert.Block.Name.Equals(block.Name, StringComparison.OrdinalIgnoreCase))
                    {
                        // Aggiorna le coordinate del punto di inserimento
                        puntoInserimento = new Coordinate(insert.Position.X, insert.Position.Y);
                        return puntoInserimento; // Restituisce le coordinate del punto di inserimento trovate
                    }
                }
            }

            // Restituisce il punto di inserimento inizializzato se il blocco "allinea" non è stato trovato
            return puntoInserimento;
        }



      
        // Funzione realizzata da Codex in autonomia
        private TDatilocale CopiaLocaleCircuito(
            NetTopologySuite.Geometries.Polygon poligonoDestinazione,
            IReadOnlyDictionary<NetTopologySuite.Geometries.Polygon, TDatilocale> localiRisolti,
            IReadOnlyDictionary<NetTopologySuite.Geometries.Polygon, string> originiDati,
            int localeCounter,
            out string origineDati,
            out string errore)
        {
            origineDati = null;
            errore = null;

            if (poligonoDestinazione == null ||
                localiRisolti == null ||
                localiRisolti.Count == 0)
            {
                errore = "Nessun locale adiacente con dati disponibili.";
                return null;
            }

            var candidati = new List<(
                NetTopologySuite.Geometries.Polygon Poligono,
                TDatilocale Dati,
                string Origine,
                double LunghezzaDividi)>();

            foreach (KeyValuePair<
                NetTopologySuite.Geometries.Polygon,
                TDatilocale> localeRisolto in localiRisolti)
            {
                NetTopologySuite.Geometries.Geometry confineCondiviso;
                try
                {
                    confineCondiviso = poligonoDestinazione
                        .Boundary
                        .Intersection(localeRisolto.Key.Boundary);
                }
                catch (NetTopologySuite.Geometries.TopologyException)
                {
                    continue;
                }

                if (confineCondiviso == null ||
                    confineCondiviso.IsEmpty ||
                    confineCondiviso.Length <= 0.001)
                {
                    continue;
                }

                double lunghezzaDividi = 0;
                foreach (LineString linea in
                    ModelloEdificio.Lines2DCor.lineStrings)
                {
                    string userData = linea.UserData?.ToString();
                    string tipoLinea = userData == null
                        ? null
                        : Utigen.GetItemFromCommaSeparatedString(
                            userData,
                            (int)PUserdata.tlinea);
                    if (!string.Equals(
                        tipoLinea,
                        "DIVIDI",
                        StringComparison.OrdinalIgnoreCase))
                    {
                        continue;
                    }

                    try
                    {
                        lunghezzaDividi += confineCondiviso
                            .Intersection(linea)
                            .Length;
                    }
                    catch (NetTopologySuite.Geometries.TopologyException)
                    {
                        // La singola linea non può essere usata come confine
                        // affidabile; si continua con le altre.
                    }
                }

                if (lunghezzaDividi <= 0.001)
                    continue;

                originiDati.TryGetValue(
                    localeRisolto.Key,
                    out string origine);
                candidati.Add((
                    localeRisolto.Key,
                    localeRisolto.Value,
                    origine ?? localeRisolto.Value.Id,
                    lunghezzaDividi));
            }

            if (candidati.Count == 0)
            {
                errore =
                    "Il locale senza simbolo non confina tramite DIVIDI " +
                    "con un locale già risolto.";
                return null;
            }

            List<string> originiDistinte = candidati
                .Select(c => c.Origine)
                .Where(o => !string.IsNullOrWhiteSpace(o))
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .ToList();
            if (originiDistinte.Count > 1)
            {
                errore =
                    "La suddivisione confina con locali provenienti da " +
                    "simboli differenti. Inserire un simbolo locale per " +
                    "eliminare l'ambiguità.";
                return null;
            }

            var sorgente = candidati
                .OrderByDescending(c => c.LunghezzaDividi)
                .First();
            origineDati = sorgente.Origine;

            double altezzaVolume =
                sorgente.Dati.SuperficieNetta > 0
                    ? sorgente.Dati.VolumeNetto /
                      sorgente.Dati.SuperficieNetta
                    : sorgente.Dati.AltezzaNettaMedia;
            if (double.IsNaN(altezzaVolume) ||
                double.IsInfinity(altezzaVolume) ||
                altezzaVolume <= 0)
            {
                altezzaVolume = sorgente.Dati.AltezzaNettaMedia;
            }

            return new TDatilocale
            {
                Id = $"locale_{localeCounter}",
                Descrizione = sorgente.Dati.Descrizione,
                SuperficieNetta = Math.Round(
                    poligonoDestinazione.Area,
                    1),
                SuperficieParetiInPianta = 0,
                VolumeNetto = Math.Round(
                    poligonoDestinazione.Area * altezzaVolume,
                    1),
                AltezzaNettaMedia = sorgente.Dati.AltezzaNettaMedia,
                AltezzaLordaMedia = sorgente.Dati.AltezzaLordaMedia,
                QuotaPavimento = sorgente.Dati.QuotaPavimento,
                Zona = sorgente.Dati.Zona,
                tipoSoffitto = sorgente.Dati.tipoSoffitto,
                confineSoffitto = sorgente.Dati.confineSoffitto,
                ColoreCopertura = sorgente.Dati.ColoreCopertura,
                tipoPavimento = sorgente.Dati.tipoPavimento,
                confinePavimento = sorgente.Dati.confinePavimento
            };
        }

        // Funzione realizzata da Codex in autonomia
        private void AggiungiLocaliCalpestabiliConCircuiti(
            List<NetTopologySuite.Geometries.Geometry> poligoni,
            System.Collections.ObjectModel.ObservableCollection<
                Dictionary<string, object>> paretiCollection)
        {
            List<NetTopologySuite.Geometries.Polygon> locali = poligoni
                .OfType<NetTopologySuite.Geometries.Polygon>()
                .ToList();
            var localiRisolti = new Dictionary<
                NetTopologySuite.Geometries.Polygon,
                TDatilocale>();
            var originiDati = new Dictionary<
                NetTopologySuite.Geometries.Polygon,
                string>();
            var localiInAttesa =
                new List<NetTopologySuite.Geometries.Polygon>();
            var errori = new Dictionary<
                NetTopologySuite.Geometries.Polygon,
                string>();
            int prossimoId = ModelloEdificio.localeCounter;

            // Primo censimento: l'ordine dei poligoni nel DXF non deve
            // influenzare la disponibilità dei simboli locali.
            foreach (NetTopologySuite.Geometries.Polygon locale in locali)
            {
                TDatilocale dati = CaricaDatiLocale(
                    locale,
                    prossimoId,
                    segnalaSimboloMancante: false);
                if (dati == null)
                {
                    localiInAttesa.Add(locale);
                    continue;
                }

                localiRisolti[locale] = dati;
                originiDati[locale] = dati.Id;
                prossimoId++;
            }

            bool progressi;
            do
            {
                progressi = false;
                foreach (NetTopologySuite.Geometries.Polygon locale in
                    localiInAttesa.ToList())
                {
                    TDatilocale dati = CopiaLocaleCircuito(
                        locale,
                        localiRisolti,
                        originiDati,
                        prossimoId,
                        out string origine,
                        out string errore);
                    if (dati == null)
                    {
                        errori[locale] = errore;
                        continue;
                    }

                    localiRisolti[locale] = dati;
                    originiDati[locale] = origine;
                    localiInAttesa.Remove(locale);
                    errori.Remove(locale);
                    prossimoId++;
                    progressi = true;
                }
            }
            while (progressi && localiInAttesa.Count > 0);

            foreach (NetTopologySuite.Geometries.Polygon locale in
                localiInAttesa)
            {
                string dettaglio = errori.TryGetValue(
                    locale,
                    out string errore)
                    ? errore
                    : "Simbolo locale mancante.";
                HelixDXF.I.ErroreConGrafica(
                    $"Locale senza simbolo non risolto automaticamente. " +
                    dettaglio,
                    HelixDXF_class.EstraiLinee2DdaPoligono(locale),
                    Quota_Piano);
            }

            foreach (NetTopologySuite.Geometries.Polygon locale in locali)
            {
                if (!localiRisolti.TryGetValue(
                    locale,
                    out TDatilocale dati))
                {
                    continue;
                }

                IoPannelli.AddParalleloLocale(
                    locale,
                    dati.Id,
                    Nome_Piano);
                ModelloEdificio.ModelloLocale(dati.Id, dati);
                AggiungiParetiLocale(
                    locale,
                    dati,
                    paretiCollection);
                ModelloEdificio.localeCounter++;
            }
        }

        // Modificato da Codex per realizzare: propagazione iterativa dei dati
        // del simbolo locale attraverso le sole suddivisioni DIVIDI.
        public void AggiungiLocali(List<NetTopologySuite.Geometries.Geometry> poligoni, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> paretiCollection)
        {
            if (Calpestabile)
            {
                AggiungiLocaliCalpestabiliConCircuiti(
                    poligoni,
                    paretiCollection);
                return;
            }

             
            //int localeCounter = 1;
            foreach (var polygon in poligoni)
            {
                if (polygon is NetTopologySuite.Geometries.Polygon polygonShape)
                {
                    var nuovoLocale = new TDatilocale
                    {
                        Id = $"locale_{ModelloEdificio.localeCounter}",
                        SuperficieNetta = 0,
                        VolumeNetto = 0,
                        AltezzaNettaMedia = double.NaN
                    };
                    TermodelLog.WriteLog($"----- Elabora un poligono (AggiungiLocali) {ModelloEdificio.localeCounter}");

                    if (!Calpestabile)
                    {
                        // In cerca dei pozziluce
                        int loccounter = 0;
                        var nuovoLocaletemp = CaricaDatiLocale(polygonShape, loccounter);
                        if (nuovoLocaletemp != null)
                        {
                            CategoriaZona categoriaZona = CategoriaZona.DaCalcolare;

                            if (Database.DB.TipoZona(CategoriaZona.PozzoLuce, nuovoLocaletemp.Zona))
                                continue;    
                            
                        }
                        // In cerca dei pozziluce
                        ModelloEdificio.CountFalde += 1;
                        TermodelLog.WriteLog($"Copertura, falda ( non triangolata ):{ModelloEdificio.CountFalde}");
                        ModelloEdificio.FaldaCor = $"falda:{ModelloEdificio.CountFalde}";
                        ModelloEdificio.ModelloLocale($"Tetto, falda:{ModelloEdificio.CountFalde}", nuovoLocale);
                        //Debug
                        // if (ModelloEdificio.CountFalde == 2) 
                        //SVGHelper.GeneraSVG("Falda", ModelloEdificio.Lines2DCor.lineStrings, polygonShape);
                        //string descrizione,bool Solaio3D,bool falde,
                        double sp= GestProg.Rivestimenti ? 0.02 : 0.1;
                        ModelloEdificio.AggiungiSolaio(polygonShape, sp, 0, $"Tetto, falda:{ModelloEdificio.CountFalde}", "Tetto", false, true, TipoElemento.Falda, new TDatiSuperficieOpaca(nuovoLocale.tipoSoffitto, nuovoLocale.confineSoffitto));
                        ModelloEdificio.localeCounter++;                     
                    }
                    else
                    {
                        // Se è un piano calpestabile cerca il blocco con i dati del locale , se falda omette
                        nuovoLocale = CaricaDatiLocale(polygonShape, ModelloEdificio.localeCounter);
                        if (nuovoLocale != null)
                        {
                            IoPannelli.AddParalleloLocale(
                                polygonShape,
                                nuovoLocale.Id,
                                Nome_Piano);
                            ModelloEdificio.ModelloLocale(nuovoLocale.Id, nuovoLocale);
                            AggiungiParetiLocale(polygonShape, nuovoLocale, paretiCollection);
                            ModelloEdificio.localeCounter++;
                        }
                    }
                }

            }
        }
        public DxfDocument dxf = null;
        public string currentDXFName = "";
       
        public string Leggi_Dxf(string filename)
        {
            // Modificato da Codex per realizzare: nel percorso Web il documento CAD
            // è già stato costruito in memoria da SvgDxfReader.
            if (dxf is not null && filename == currentDXFName) return "";
            if (filename == currentDXFName && dxf == null) return "";
            if (!System.IO.File.Exists(filename))
            {
                return $"Il disegno CAD {System.IO.Path.GetFileName(filename)}, relativo al piano:{Nome_Piano}, non è stato ancora elaborato.Clicca su 'Visualizza il plugin Cad' e poi su 'Apri il Cad' per creare il disegno schematico dell'edificio.";
            }
            string res = "";
            try
            {
                dxf = DxfDocument.Load(filename);
                currentDXFName = filename;
            }
            catch (Exception ex)
            {
                TermodelLog.LogError($"Errore durante la lettura del file DXF '{filename}': {ex.Message}");
                return InfoString;
            }
        return res;
        }
        private static bool CoordDentroLimite(Vector3 punto)
        {
            return Math.Abs(punto.X) <= 1000 &&
                   Math.Abs(punto.Y) <= 1000 &&
                   Math.Abs(punto.Z) <= 1000;
        }
        ModelVector3D traslazione = new(0, 0, 0);
        public enum PosizionePiano
        {
            Errore = -1,
            PianoTerra = 1,
            PianoIntermedio = 2,
            Ultimo = 3,
            Copertura = 4
        }
        public string LeggiFileDxf(string NomePiano,double altezzanettapiano, double altezzalordapiano, string filename , string layerName, string tipopiano, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> paretiCollection,int modo, double quotapiano, PosizionePiano posizionepiano = PosizionePiano.PianoIntermedio)
        {
            
            AltezzaNettaPiano = altezzanettapiano;
            AltezzaLordaPiano = altezzalordapiano;
            FileName = filename;
            LayerName = layerName;
            Nome_Piano = NomePiano;
            Quota_Piano = quotapiano;
            Posizionepiano = posizionepiano;
            InfoString = $"File: {filename}  Layer: {layerName}  ";
            TermodelLog.LogContesto = InfoString+ Environment.NewLine;
            if (ErrorManager.EsisteErrore()) return InfoString;
            var errore = Leggi_Dxf(filename);
            if (errore != "")
            {
                TermodelLog.LogError($"{errore}");
                return "";
            }

            else
            {
                
                // controllo sulla posizione del disegno
                foreach (var e in dxf.Lines
                .Where(e => e.Layer != null &&
                e.Layer.Name.Equals(layerName, StringComparison.OrdinalIgnoreCase)))
                {
                    if (!CoordDentroLimite(e.StartPoint) || !CoordDentroLimite(e.EndPoint))
                    {
                        TermodelLog.LogError($" {InfoString}: Linee fuori scala , coordinate > +/- 1000 metri, spostare il disegno verso l'origine degli assi cartesiani (0,0)");
                    }
                }
                Calpestabile = tipopiano == "Calpestabile";
                DirezNord = RilevaNord(dxf, layerName);
                if ((!Calpestabile && modo == 2) || (Calpestabile && modo == 1)) return "";
                GlobModo = modo;
                if (!double.IsNaN(DirezNord))
                {
                    //if (!double.IsNaN(ModelloEdificio.direzNord) ) TermodelLog.LogError("E presente più di un simbolo NORD dei disegni DXF");
                    //else 
                    ModelloEdificio.direzNord = DirezNord;
                }

                orig = RilevaAllineamento(dxf, layerName);
                traslazione = new ModelVector3D(
                -orig.X,
                -orig.Y,
                quotapiano
                 );

                IoPannelli.LeggiTubiDXF(dxf, Nome_Piano, Quota_Piano, orig.X, orig.Y);

                //if ( modo == 2) 
                HelixDXF.I.ImportaDaDxf(dxf, LayerName, traslazione);

                Locali = LeggiBlocchi(dxf, layerName, "LOC");
                Finestre = LeggiBlocchi(dxf, layerName, "FIN");
                Ponti = LeggiBlocchi(dxf, layerName, "PON");
                Colmi = LeggiBlocchi(dxf, layerName, "Colmo");
                //String layerName = "0";
                // Filtra le linee per il layer specificato
                ModelloEdificio.CountFalde = 0;
                ModelloEdificio.ListaVerticiTetti = new List<(double X, double Y, double Z, double? Z2)>();
                int ripetizioni = 1;
                //Separa i tetti indipendenti con colori diversi
                // Definiamo `uniqueColors` come una lista di colori AutoCAD
                
                
                List<AciColor> uniqueColors = new List<AciColor>();
                if (!Calpestabile)
                {
                    var filteredLineTetti = dxf.Lines
                        .Where(e => e.Layer != null && e.Layer.Name.Equals(layerName, StringComparison.OrdinalIgnoreCase))
                        .ToList(); // Converti in lista per evitare doppie enumerazioni
                                   // HashSet per memorizzare gli Index già aggiunti ed evitare duplicati
                    HashSet<int> coloriAggiunti = new HashSet<int>();
                    // Estrai i colori unici dalle linee filtrate
                    foreach (var linea in filteredLineTetti)
                    {
                        if (linea.Color != null && !coloriAggiunti.Contains(linea.Color.Index))
                        {
                            uniqueColors.Add(linea.Color); // Aggiunge il colore alla lista
                            coloriAggiunti.Add(linea.Color.Index); // Segna l'index come già aggiunto
                        }
                    }

                    ripetizioni = uniqueColors.Count();
                }

                var filteredLines = dxf.Lines.Where(e => e.Layer != null && e.Layer.Name.Equals(layerName, StringComparison.OrdinalIgnoreCase));

                //DrawInCanvas(drawingCanvas, filteredLines);
                //Modifica tetti a più colori crea il piano una sola volta per non cancellare i poligono 3d;
                ModelloEdificio.CreaRecordLineePiano(ModelloEdificio, NomePiano, tipopiano);
                for (int i = 0; i < ripetizioni; i++)
                {
                    if (!Calpestabile)
                    {
                        var currentColor = uniqueColors[i]; // Seleziona il colore attuale
                        ModelloEdificio.ColoreTettoCor = currentColor.Index;
                        // Filtra le linee per layer e colore
                        filteredLines = dxf.Lines
                            .Where(e => e.Layer != null && e.Layer.Name.Equals(layerName, StringComparison.OrdinalIgnoreCase)
                                        && e.Color.Index == currentColor.Index) // Filtra per colore
                            .ToList();

                    }
                    var lineStrings = new List<NetTopologySuite.Geometries.LineString>();
                    foreach (var entity in filteredLines)
                    {
                        var lineString = new NetTopologySuite.Geometries.LineString(new[]
                            {
                        new Coordinate(entity.StartPoint.X-orig.X,entity.StartPoint.Y-orig.Y),
                         new Coordinate(entity.EndPoint.X-orig.X, entity.EndPoint.Y-orig.Y)
                        });
                        string confine = entity.Linetype.ToString();

                        if (!string.IsNullOrEmpty(confine))
                        {
                            if (!string.Equals(confine, "FITTIZIA", StringComparison.OrdinalIgnoreCase) &&
                                !string.Equals(confine, "DIVIDI", StringComparison.OrdinalIgnoreCase))
                                confine = utiDb.GetDataDB("Tipolinea", entity.Linetype.ToString(), "Codice", utiDb.GetCollection("Confini"));
                        }
                        if (string.IsNullOrEmpty(confine))
                        {
                            TermodelLog.LogError($"{TermodelLog.LogContesto}, Tipo linea '{entity.Linetype?.ToString() ?? "Null"}' non trova riscontro nell'archivio confini  ");
                            confine = "Sconosciuto";
                        }
                        lineString.UserData = $"{entity.Color}|{confine}|{entity.StartPoint.Z}|{entity.EndPoint.Z}";
                        lineStrings.Add(lineString);
                    }

                    AssociaBlocchiAParete("Finestra", Finestre, lineStrings, Geometria.Appros);
                    AssociaBlocchiAParete("Ponte", Ponti, lineStrings, Geometria.Appros);
                    if (!Calpestabile)
                    {
                        TermodelLog.WriteLog($"-----------------  Assegnazione della Z in base ai blocchi colmo");
                    }
                        AssociaBlocchiAParete("Colmo", Colmi, lineStrings, Geometria.Appros);
                    var polygons = new List<NetTopologySuite.Geometries.Geometry>();

                    DXFLineCheck = new DXFLineCheck(lineStrings);

                    DXFLineCheck.Spezza_linee();
                    DXFLineCheck.RimuoviLineeDuplicate();
                    DXFLineCheck.RaggruppaNodi();
                    if (!Calpestabile)
                    {
                        //  Propaga la quota dei colmi alle linee adiacenti
                        DXFLineCheck.SettaZVicini();
                        // Assegna a tutte le quota=0 la quota della gronda
                        //TermodelLog.WriteLog($"Assegna a tutte le quota=0 la quota della gronda:{ModelloEdificio.QuotaGrondaCor}");
                        int count = 0;
                        foreach (var line in DXFLineCheck.lineStrings)
                        {
                            var z1 = Utigen.Get_Z(line.UserData, 1);
                            var z2 = Utigen.Get_Z(line.UserData, 2);

                            if (DXFLineCheck.ISZero(z1))
                            {
                                //TermodelLog.WriteLog($"🟠 Z1 assente su linea: start=({line.StartPoint.X},{line.StartPoint.Y}) → end=({line.EndPoint.X},{line.EndPoint.Y}) — impostata a {ModelloEdificio.QuotaGrondaCor}");
                                count += 1;
                                line.UserData = Utigen.SetUserdataValue(
                                    line.UserData.ToString(),
                                    Utigen.DoubleToStrPunto(ModelloEdificio.QuotaGrondaCor),
                                    PUserdata.Z1
                                );
                            }

                            if (DXFLineCheck.ISZero(z2))
                            {
                                count += 1;
                                //TermodelLog.WriteLog($"🟠 Z2 assente su linea: start=({line.StartPoint.X},{line.StartPoint.Y}) → end=({line.EndPoint.X},{line.EndPoint.Y}) — impostata a {ModelloEdificio.QuotaGrondaCor}");
                                line.UserData = Utigen.SetUserdataValue(
                                    line.UserData.ToString(),
                                    Utigen.DoubleToStrPunto(ModelloEdificio.QuotaGrondaCor),
                                    PUserdata.Z2
                                );
                            }
                        }
                        TermodelLog.WriteLog($"Assegnati {count} vertici a quota gronda ");
                        TermodelLog.WriteLog($"----------- Poligonizzazione delle falde ");


                        if (TermodelLog.IsEnabled(TermodelLog.LogCategory.colmi))
                        {
                            TermodelLog.WriteLog("📋 LOGGONE QUOTE FINALI (linea per linea):");

                            int index = 0;
                            foreach (var line in DXFLineCheck.lineStrings)
                            {
                                var p1 = line.StartPoint;
                                var p2 = line.EndPoint;

                                string z1_str = Utigen.Get_Z(line.UserData, 1);
                                string z2_str = Utigen.Get_Z(line.UserData, 2);

                                double z1 = Utigen.CVStrToDouble(z1_str);
                                double z2 = Utigen.CVStrToDouble(z2_str);

                                TermodelLog.WriteLog(
                                    $"#{index++:00} ▶️ START: ({p1.X:F3}, {p1.Y:F3}) Z1={z1:F2} | END: ({p2.X:F3}, {p2.Y:F3}) Z2={z2:F2}"
                                );
                            }
                        }
                    }
                    var sconnesse = DXFLineCheck.RilevaLineeNonConnesse(appros: 0);
                    if (sconnesse.Count() > 0) HelixDXF.I.ErroreConGrafica("(disegno di input) Linee (rosse) non connesse da entrambi i lati", sconnesse, quotapiano);
                    /*
                    {
                        HelixDXF.I.ErroriNelDxf(sconnesse,traslazione);
                        TermodelLog.LogError("(disegno di input) Linee (rosse) non connesse da entrambi i lati");
                       // ErroreManager.AddErroreDXF(NomePiano, 0, "(disegno di input) Linee (rosse) non connesse con il resto del grafo", lineStrings, sconnesse);
                    }
                    */
                    //if (!Calpestabile) SVGHelper.AnomalieLinee(lineStrings, DXFLineCheck.RilevaLineeNonConnesse(), "NonConnesse");

                    // Fornisce le linee alla classe Tetti
                    if (!Calpestabile) ModelloEdificio.SetLines2DCor(DXFLineCheck);

                    ModelloEdificio.ModoCor = modo;

                    // Informazioni per l'elaborazione interpiano
                    // creati nell'ipotesi interazione tra piani  poi realizzata in Polig 3d
                    //if (modo == 1)

                    ModelloEdificio.AggiungiLineePiano(ModelloEdificio, NomePiano, tipopiano, lineStrings);
                    ModelloEdificio.SettaLines2DCor(NomePiano);

                    // disattivato in attesa di comprensione
                    //DXFLineCheck = ModelloEdificio.Lines2DCor;

                    if (lineStrings.Count == 0)
                        TermodelLog.LogError($"Layer:{layerName} non hai disegnato nessuna linea ( parete)");
                    else if (lineStrings.Count < 3)
                        HelixDXF.I.ErroreConGrafica($"Layer:{layerName}, numero linee ( linee rosse ): {lineStrings.Count} insufficienti per formare un perimetro", lineStrings, Quota_Piano);
                   else TermodelLog.WriteLog($"Poligonizzazione della pianta linee:{lineStrings.Count} ");

                    //TermodelLog.LogDisegnoSVG(ModelloEdificio.Lines2DCor.lineStrings, null);

                    var polygonizer = new NetTopologySuite.Operation.Polygonize.Polygonizer();
                    
                    foreach (var lineString in lineStrings)
                    {
                        polygonizer.Add(lineString);
                    }

                    var poligoni = polygonizer.GetPolygons();
                    /* senza multipoligoni
                    foreach (var polygon in poligoni)
                    {
                        if (polygon.IsValid)
                        {
                            polygons.Add(polygon);
                        }
                    }
                    */
                    //con multipoligoni
                    foreach (var geom in poligoni)
                    {
                        if (geom is NetTopologySuite.Geometries.Polygon poligonoSingolo)
                        {
                            if (poligonoSingolo.IsValid)
                                polygons.Add(poligonoSingolo);
                        }
                        else if (geom is NetTopologySuite.Geometries.MultiPolygon multi)
                        {
                            foreach (NetTopologySuite.Geometries.Polygon poligonoMultiplo in multi.Geometries.OfType<NetTopologySuite.Geometries.Polygon>())
                            {
                                if (poligonoMultiplo.IsValid)
                                    polygons.Add(poligonoMultiplo);
                            }
                        }
                    }



                    // fine multipoligoni
                    if (polygons.Count == 0) TermodelLog.LogError($"Poligonizzazione della pianta del piano '{NomePiano}' {Environment.NewLine} dal file  '{filename}' {Environment.NewLine} sul layer '{layerName}'{Environment.NewLine} numero linee (pareti): {lineStrings.Count} nessun poligono rilevato");
                    else
                    {
                        //disattivato per multipoligoni
                        if (GlobModo == 2 && Calpestabile) GeneraPianta.GeneraPiantaPiano(DXFLineCheck, GestProg.PathProg, NomePiano, polygons, true);

                        AggiungiLocali(polygons, paretiCollection);
                        if (!Calpestabile)
                            ModelloEdificio.Tettocor.DisegnaSceds();
                        //disattivato per multipoligoni
                        if (GlobModo == 2 && Calpestabile) GeneraPianta.SalvaDXF();
                    }
                }
            }
            return InfoString;
        }

        // Funzione realizzata da Codex in autonomia
        public string LeggiDocumentoDxf(
            DxfDocument document,
            string nomeDocumento,
            string nomePiano,
            double altezzaNettaPiano,
            double altezzaLordaPiano,
            string layerName,
            string tipoPiano,
            System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> paretiCollection,
            int modo,
            double quotaPiano,
            PosizionePiano posizionePiano = PosizionePiano.PianoIntermedio)
        {
            ArgumentNullException.ThrowIfNull(document);
            dxf = document;
            currentDXFName = nomeDocumento;
            return LeggiFileDxf(
                nomePiano,
                altezzaNettaPiano,
                altezzaLordaPiano,
                nomeDocumento,
                layerName,
                tipoPiano,
                paretiCollection,
                modo,
                quotaPiano,
                posizionePiano);
        }
  
    }

}
