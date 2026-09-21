
using System.Collections.Generic;
using System.Windows;
using Xbim.Common;
using Xbim.Ifc;
using Xbim.Ifc4.Interfaces;
using Xbim.Ifc4.Kernel;
using Xbim.Ifc4.MeasureResource;
using Xbim.Ifc4.ProductExtension;
using Xbim.Ifc4.RepresentationResource;
using Xbim.Ifc4.GeometryResource;
using Xbim.Ifc4.GeometricConstraintResource;
using Xbim.Ifc4.SharedBldgElements;
using Xbim.Ifc4.ProfileResource;
using Xbim.Ifc4.GeometricModelResource;
using Xbim.Common.Geometry;
using Xbim.Ifc4.PresentationAppearanceResource;
using Xbim.Ifc4.PresentationDefinitionResource;
using Xbim.IO;
using Termodel.utilities;
using NetTopologySuite.Geometries;
using Termodel.Leggidxf;
using System.Windows.Media.Media3D;
using System.Windows.Media;
using Termodel;
using System.Xml.Linq;
using static Termodel.Modello;
using static GestXml;
using System;
using static Termodel.utilities.TermodelLog;
using System.Globalization;
using Termodel.Impianti.Pannelli;
using System.IO;
public class PoligonoEstrusoIfc
{
    // Geometria NTS del poligono
    public IfcPolyline Poligono { get; set; }

    // Spessore dell'estrusione
    public double Spessore { get; set; }

    // Identificatore dell'elemento
    public string ElementIdentifier { get; set; }

    // Punto di inserimento dell'elemento nel modello
    public IfcCartesianPoint PuntoInserimento { get; set; }

    // Direzione dell'estrusione
    public IfcDirection Direzione { get; set; }

    // Descrizione dell'elemento
    public string Descrizione { get; set; }

    // Tipo dell'elemento
    public string Tipo { get; set; }

    // Quota corrente
    public double QuotaCorrente { get; set; }
    public bool Tetto3D { get; set; }

    public bool Falda { get; set; }

    public bool Verticale { get; set; }
    // Costruttore per inizializzare le proprietà del poligono estruso
    public PoligonoEstrusoIfc(IfcPolyline poligono, double spessore, string elementIdentifier, IfcCartesianPoint puntoInserimento, IfcDirection direzione, string descrizione, string tipo, double quotaCorrente, bool tetto3d, bool falda, bool verticale)
    {
        Poligono = poligono;
        Spessore = spessore;
        ElementIdentifier = elementIdentifier;
        PuntoInserimento = puntoInserimento;
        Direzione = direzione;
        Descrizione = descrizione;
        Tipo = tipo;
        QuotaCorrente = quotaCorrente;
        Tetto3D = tetto3d;
        Falda = falda;
        Verticale = verticale;
    }
}

public static class Polig3D
{
    public static bool enabled = true;
    public static DrawBim drawBimControl;
    public static IfcStore model;
    public static int CountOggetti;
    public static IfcGeometricRepresentationContext GeometricRepresentationContext;
    
    public static IfcBuildingElementProxy PareteCorr { get; set; }
    // Proprietà per memorizzare l'elenco dei piani
    // Classe per rappresentare le informazioni sui piani
    public static LineManager LineeCostruzione=null;

    public static void InitClass()
    {
        MainWindow mainWindow = Application.Current.MainWindow as MainWindow;
        drawBimControl = mainWindow?.GetDrawBimControl();
        // Inizializza LineManager per linee di costruzione/debug
        //LineeCostruzione = new LineManager(drawBimControl);
       

        MainWindow.FiltriGraficiControlStatic.CancellaPiani();
        foreach (var piano in ElencoPiani)
        {
            MainWindow.FiltriGraficiControlStatic.AddPiano(piano.Nome);
        }

    }

    //-------------------------  Piani -------------------------------
    public class PianoInfo
    {
        public string Nome { get; }
        public double Elevazione { get; }
        public TipoPiano Tipopiano;
        public PianoInfo(string nome, double elevazione, TipoPiano TipoDelPiano)
        {
            Nome = nome;
            Elevazione = elevazione;
            Tipopiano = TipoDelPiano;
        }
    }
    public static List<PianoInfo> ElencoPiani { get; private set; } = new List<PianoInfo>();
    // Proprietà per memorizzare i locali
    public static void AggiungiPiano(string pianoNome, double elevazione, TipoPiano TipoDelPiano)
    {
        ElencoPiani.Add(new PianoInfo(pianoNome, elevazione, TipoDelPiano));
    }
    //-------------------------  Locali -------------------------------
    // Classe per rappresentare le informazioni sui locali
    // Enum per rappresentare il tipo di piano
    public enum TipoPiano
    {
        Calpestabile,
        Copertura,
        Terreno
    }
    public static TipoPiano StringToInTipoPiano(string tipoPianoStr)
    {
        switch (tipoPianoStr.ToLower())
        {
            case "calpestabile":
                return TipoPiano.Calpestabile;
            case "copertura":
                return TipoPiano.Copertura;
            case "terreno":
                return TipoPiano.Terreno;
            default:
                throw new ArgumentException($"Valore non valido per TipoPiano: {tipoPianoStr}");
        }
    }

    // Classe LocaleInfo
    public class LocaleInfo
    {
        public string Nome { get; }
        public string PianoAppartenenza { get; }
        public TDatilocale DatiLocale { get; }

        // Aggiunta della proprietà TipoPiano


        public LocaleInfo(string nome, string pianoAppartenenza, TDatilocale datilocale)
        {
            Nome = nome;
            PianoAppartenenza = pianoAppartenenza;
            DatiLocale = datilocale;

        }
    }

    // Lista statica per memorizzare i locali
    public static List<LocaleInfo> ElencoLocali { get; private set; } = new List<LocaleInfo>();

    // Funzione per aggiungere un locale all'elenco
    public static void AggiungiLocale(string localeNome, string pianoNome, TDatilocale datilocale)
    {
        ElencoLocali.Add(new LocaleInfo(localeNome, pianoNome, datilocale));
    }


    // Funzione per ottenere i locali associati a un determinato piano
    public static List<LocaleInfo> GetLocaliByPiano(string pianoNome)
    {
        return ElencoLocali.Where(l => l.PianoAppartenenza == pianoNome).ToList();
    }
    public static List<LocaleInfo> GetLocaliByPianoZona(string pianoNome,string ZonaNome)
    {
        return ElencoLocali.Where(l => l.PianoAppartenenza == pianoNome&&l.DatiLocale.Zona== ZonaNome).ToList();
    }
    // Funzione per ottenere i componenti (ElementiAssociati) in base al nome del locale
    public static List<ElementoAssociato> GetComponentiByLocale(string nomeLocale)
    {
        // Filtra l'elenco degli elementi associati in base al nome del locale
        return ElementiAssociati
            .Where(e =>
                (e.PareteACuiAssociata != null && e.PareteACuiAssociata.Locale != null && e.PareteACuiAssociata.Locale.Name == nomeLocale) ||
                (e.PareteACuiAssociata == null && e.Locale != null && e.Locale.Name == nomeLocale)
            )
            .ToList();
    }
    
    //------------------------- ----- -------------------------------

    public static IfcBuildingElementProxy AggiungiEstrudePolygon(double QuotaCorrente, IfcPolyline polyifc, double spessore, string elementIdentifier, IfcCartesianPoint puntoInserimento, IfcDirection direzione, string descrizione, TipoElemento tipo, bool verticale)
    {
        if (puntoInserimento.X == double.NaN || puntoInserimento.Y == double.NaN || puntoInserimento.Z == double.NaN)
            TermodelLog.LogError($"Il punto di inserimento del {tipo},{elementIdentifier},{descrizione} non sono definite correttamente");
        if (QuotaCorrente == double.NaN)
            TermodelLog.LogError($"Quota corrente del {tipo},{elementIdentifier},{descrizione} non sono definite correttamente");

        IfcBuildingElementProxy EstrudePolygonCor;
        try
        {
            using (var txn = model.BeginTransaction("Aggiungi Poligono Estruso"))
            {

                // Crea una nuova istanza di IfcCartesianPoint nel modello IFC
                double QuotaC = QuotaCorrente;
                // per le falde la quota è espressa in valore assoluto
                if (tipo == TipoElemento.Falda) QuotaC = 0;
                var puntoInserimentoCopia = model.Instances.New<IfcCartesianPoint>(cp =>
                {
                    cp.SetXYZ(
                        puntoInserimento.X,                 // Copia X
                        puntoInserimento.Y,                 // Copia Y
                        puntoInserimento.Z + QuotaC  // Modifica Z
                    );
                });
                //puntoInserimento.Z += QuotaCorrente;
                EstrudePolygonCor = model.Instances.New<IfcBuildingElementProxy>(bep =>
                {
                    //TermodelLog.LogOperation($"Errore durante l'aggiunta del poligono estruso: Redraw ifc p1A");
                    bep.Name = $"{elementIdentifier}";
                    bep.Description = descrizione;
                    bep.ObjectType = $"Oggetto n:{CountOggetti}";
                    bep.ObjectPlacement = model.Instances.New<IfcLocalPlacement>(lp =>
                    {
                        lp.RelativePlacement = model.Instances.New<IfcAxis2Placement3D>(rp =>
                        {
                            rp.Location = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(0, 0, 0));
                        });
                    });
                    
                    // Inizio rappresentazione geometrica del poligono
                    bep.Representation = model.Instances.New<IfcProductDefinitionShape>(pds =>
                    {
                        pds.Representations.Add(model.Instances.New<IfcShapeRepresentation>(sr =>
                        {
                            sr.ContextOfItems = GeometricRepresentationContext;
                            sr.RepresentationIdentifier = "Body";
                            sr.RepresentationType = "SweptSolid";
                            sr.Items.Add(model.Instances.New<IfcExtrudedAreaSolid>(eas =>
                            {
                                eas.Depth = spessore;
                                var polygonProfile = model.Instances.New<IfcArbitraryClosedProfileDef>(profile =>
                                {
                                    profile.ProfileType = IfcProfileTypeEnum.AREA;
                                    profile.OuterCurve = polyifc;
                                });
                                eas.SweptArea = polygonProfile;
                                eas.ExtrudedDirection = model.Instances.New<IfcDirection>(d =>
                                {
                                    if (verticale)
                                        d.SetXYZ(0, 1, 0);
                                    else
                                        d.SetXYZ(0, 0, 1);
                                });
                                eas.Position = model.Instances.New<IfcAxis2Placement3D>(a2p3d =>
                                {
                                    a2p3d.Location = puntoInserimentoCopia;
                                    a2p3d.RefDirection = direzione;
                                    a2p3d.Axis = model.Instances.New<IfcDirection>(d => d.SetXYZ(0, 0, 1));
                                });
                            }));
                        }));
                    });
                });

                txn.Commit();
            }
        }
        catch (Exception ex)
        {
            TermodelLog.LogOperation($"Errore durante l'aggiunta del poligono estruso: {ex.Message}");
            Console.WriteLine($"Errore durante l'aggiunta del poligono estruso: {ex.Message}");
            EstrudePolygonCor = null;
        }

        return EstrudePolygonCor;
    }
    public static IfcBuildingElementProxy AggiungiEstrudePolygonOpenGl(
    int NumeroElemento,
    double QuotaCorrente,
    IfcPolyline polyifc,
    double spessore,
    string elementIdentifier,
    IfcCartesianPoint puntoInserimento,
    IfcDirection direzione,
    string descrizione,
    TipoElemento Tipo,
    bool verticale,
    Coordinate3D Start,
    Coordinate3D End
    )
    {
        if (polyifc == null || polyifc.Points.Count < 3)
        {
            Console.WriteLine($"Errore: Poligono non valido ({Tipo}, {elementIdentifier}, {descrizione})");
            return null;
        }
        // Verifica i dati di input
        if (double.IsNaN(puntoInserimento.X) || double.IsNaN(puntoInserimento.Y) || double.IsNaN(puntoInserimento.Z))
        {
            Console.WriteLine($"Errore: Punto di inserimento non valido per {Tipo} {elementIdentifier}: {descrizione}");
            return null;
        }

        if (double.IsNaN(QuotaCorrente))
        {
            Console.WriteLine($"Errore: Quota corrente non valida per {Tipo} {elementIdentifier}: {descrizione}");
            return null;
        }

        // Le falde sono espresse in quota assoluta
        double baseHeight = 0;
        if (Tipo==TipoElemento.Falda) 
        baseHeight =  puntoInserimento.Z;
        else baseHeight = QuotaCorrente + puntoInserimento.Z;

        // Trasforma la direzione in angolo di rotazione (supponiamo un orientamento rispetto all'asse Z)
        double rotationAngle = 0;
        if (direzione != null && direzione.DirectionRatios.Count >= 2)
        {
            double dirX = direzione.DirectionRatios[0];
            double dirY = direzione.DirectionRatios[1];
            rotationAngle = Math.Atan2(dirY, dirX) * 180 / Math.PI; // Converti in gradi
        }

        // Colore per il poligono (può essere parametrizzato ulteriormente)

        MainWindow mainWindow = Application.Current.MainWindow as MainWindow;
        DrawBim drawBimControl = mainWindow?.GetDrawBimControl();
        // Chiamata alla funzione per disegnare il poligono estruso
        drawBimControl.DrawPolyEstruso(
            NumeroElemento,
            polyifc,
            baseHeight,
            spessore,
            verticale,
            puntoInserimento,
            new Point3D(puntoInserimento.X, puntoInserimento.Y, baseHeight), // Punto di inserimento come origine
            Tipo,
            elementIdentifier,
            descrizione,
            Start,
            End,
            rotationAngle // Rotazione calcolata

        );

        Console.WriteLine($"Poligono estruso aggiunto: {Tipo}, ID: {elementIdentifier}, Descrizione: {descrizione}");
        return null;
    }


    // Enum per rappresentare i tipi di elemento
    public enum TipoElemento
    {
        Parete,
        Soffitto,
        Pavimento,
        Finestra,
        Ponte,
        Falda,
        Mansardato
    }

    public static bool MurariaDisperdente(TipoElemento tipo)
    {
        return tipo == TipoElemento.Parete || tipo == TipoElemento.Soffitto || tipo == TipoElemento.Pavimento || tipo == TipoElemento.Mansardato;
    }
    public static bool DaCensire(TipoElemento tipo)
    {
        return tipo != TipoElemento.Falda ;
    }
    public static bool Aggre_Locale(TipoElemento tipoElemento)
    {
        return (tipoElemento == TipoElemento.Parete)
            || (tipoElemento == TipoElemento.Soffitto)
            || (tipoElemento == TipoElemento.Pavimento)
            || (tipoElemento == TipoElemento.Mansardato)
            || (tipoElemento == TipoElemento.Falda);
    }
    public static TDatilocale DatiLocaleACuiAssociato(ElementoAssociato el)
    {

        if (el.Locale == null)
        {
        return el.PareteACuiAssociata.Dati_locale;
        }
        else return el.Dati_locale;
    }
    public static ElementoAssociato Parete_ACuiAssociato(ElementoAssociato el)
    {

        if (el.Locale == null)
        {
            return el.PareteACuiAssociata;
        }
        else return el;
    }
    public static ElementoAssociato Parete_Corrente;

    public enum AzionePontiPostConfine
    {
        Nessuna,
        EliminaTuttiIPonti,
        RielaboraPonti,
        // Aggiungine altre se servono
    }
    public class ElementoAssociato
    {

        public AzionePontiPostConfine AzionePonti { get; set; } = AzionePontiPostConfine.Nessuna;
        public bool Censito = false;

        public IfcBuildingElementProxy PoligonoIFCBim;
        public PoligonoEstrusoIfc Poligono { get; set; }
        public IfcSpace Locale { get; set; }
        public string NomePiano { get; set; }
        public TipoElemento Tipo { get; set; }

        public TDatilocale Dati_locale;

        public bool Separatore = false; // intica che la parete è stata rilevata come confinante con un'altra
       
        public bool StessaZona = false; // intica che la parete è stata rilevata come confinante con un'altra

       

        public void Set_Stessa_Zona( ElementoAssociato el2)
        {
            StessaZona =false;
            if (Dati_locale != null&& el2.Dati_locale!=null)
            if(Dati_locale.Zona == el2.Dati_locale.Zona)
                    StessaZona =true;
                    
        }
        public TDatiSuperficieOpaca datiopaca { get; set; }

        // caso finestra ponte
        public IfcBuildingElementProxy PareteBase { get; set; }
        public ElementoAssociato PareteACuiAssociata { get; set; }


        // Costruttore elementi  parete
        ElementoAssociato(PoligonoEstrusoIfc poligono, IfcSpace locale, TDatilocale datilocale, TipoElemento tipo, TDatiSuperficieOpaca DatiOpaca,string _NomePiano)
        {
            NomePiano = _NomePiano;
            Poligono = poligono;
            Locale = locale;
            Dati_locale = datilocale;
            Tipo = tipo;
            datiopaca = DatiOpaca;
            Parete_Corrente = this;
            //TermodelLog.WriteLog($"Creo un'elemento associato ad un locale di tipo : {tipo} con confine {datiopaca?.Confine ?? "Datiopaca o confine null"}");
        }
        // Costruttore elementi associati a parete
        ElementoAssociato(string isparete, PoligonoEstrusoIfc poligono, IfcBuildingElementProxy pareteBase, TipoElemento tipo, TDatiSuperficieOpaca DatiOpaca,string _NomePiano)
        {
            NomePiano = _NomePiano;
            Locale = null;
            Poligono = poligono;
            PareteBase = pareteBase;
            datiopaca = DatiOpaca;
            Tipo = tipo;
            PareteACuiAssociata = Parete_Corrente;
            TermodelLog.WriteLog($"Creo un'elemento associato ad una parete di tipo : {tipo}",category:LogCategory.GeneraModello);
        }
        public ElementoAssociato(PoligonoEstrusoIfc poligono, IfcSpace locale, IfcBuildingElementProxy pareteBase, TipoElemento tipo)
        {
            Poligono = poligono;
            Locale = locale;
            PareteBase = pareteBase;
            PareteACuiAssociata = Parete_Corrente;
            Tipo = tipo;
            TermodelLog.WriteLog($"Creo un'elemento associato a ???? locale senza dati opaca");
        }

        //usato nella rilevazione dei confini per identificare una superficie di separazione
        public ElementoAssociato(PoligonoEstrusoIfc poligono, IfcSpace locale, IfcBuildingElementProxy pareteBase, TipoElemento tipo, TDatiSuperficieOpaca DatiOpaca,bool separatore,string nomepiano)
        {
            Poligono = poligono;
            Locale = locale;
            PareteBase = pareteBase;
            PareteACuiAssociata = Parete_Corrente;
            Tipo = tipo;
            datiopaca = DatiOpaca;
            Separatore = separatore;
            NomePiano = nomepiano;
            TermodelLog.WriteLog($"Creo un'elemento associato a ???? locale senza dati opaca");
        }
        public ElementoAssociato(ElementoAssociato elementoDaClonare, IfcPolyline nuovoPoligonoIfc)
        {
            // Clona tutte le proprietà dell'oggetto `PoligonoEstrusoIfc`, tranne il poligono IFC che viene passato come parametro


            Poligono = new PoligonoEstrusoIfc(
                nuovoPoligonoIfc,  // Imposta il nuovo poligono IFC
                elementoDaClonare.Poligono.Spessore,  // Copia lo spessore dal poligono originale
                elementoDaClonare.Poligono.ElementIdentifier,
                elementoDaClonare.Poligono.PuntoInserimento,  // Copia il punto di inserimento
                elementoDaClonare.Poligono.Direzione,  // Copia la direzione
                elementoDaClonare.Poligono.Descrizione,  // Copia la descrizione
                elementoDaClonare.Poligono.Tipo,  // Copia il tipo di poligono
                elementoDaClonare.Poligono.QuotaCorrente,  // Copia la quota corrente
                elementoDaClonare.Poligono.Tetto3D,
                elementoDaClonare.Poligono.Falda,
                elementoDaClonare.Poligono.Verticale);// Tetto3D

            // Copia le altre proprietà dal clone
            Locale = elementoDaClonare.Locale;  // Copia il locale
            PareteBase = elementoDaClonare.PareteBase;  // Copia la parete base
            Tipo = elementoDaClonare.Tipo;  // Copia il tipo di elemento
        }
        public static void AggiungiElemento(PoligonoEstrusoIfc poligono, TipoElemento tipoElemento, TDatiSuperficieOpaca DatiOpaca, IfcSpace locale, TDatilocale datilocale, IfcBuildingElementProxy pareteBase, string _NomePiano)
        {
            if (Aggre_Locale(tipoElemento))
            {
                // Aggiunge un elemento associato a un locale
                ElementiAssociati.Add(new ElementoAssociato(poligono, locale, datilocale, tipoElemento, DatiOpaca, _NomePiano));
            }
            else
            {
                // Aggiunge un elemento associato a una parete
                ElementiAssociati.Add(new ElementoAssociato("parete", poligono, pareteBase, tipoElemento, DatiOpaca, _NomePiano));
            }

        }
    }
    // Lista vuota per ospitare i nuovi poligoni generati dalle sovrapposizioni
    public static List<ElementoAssociato> nuoviPoligoni = new List<ElementoAssociato>();



    // Lista di poligoni estrusi e i loro riferimenti ai locali
    public static List<ElementoAssociato> ElementiAssociati = new List<ElementoAssociato>();

    // Metodo per rimuovere tutti gli elementi dalla lista
    public static void ClearAll()
    {
        ElementiAssociati.Clear();
        ElencoPiani.Clear();
        ElencoLocali.Clear();
    }
    public static void ControllaCensiti()
    {
        int count = 0;
        //TermodelLog.Initialize_LogErrori();
        foreach (ElementoAssociato elemento in ElementiAssociati)
            if (!elemento.Censito && DaCensire(elemento.Tipo) && !elemento.StessaZona)
            {
                count += 1;
                var Datiloc = Polig3D.DatiLocaleACuiAssociato(elemento);
                if (Datiloc == null)
                {
                    TermodelLog.LogError($"Elemento:{elemento.Tipo}" +
                         $",Piano:{elemento.NomePiano}" +
                         $", riferimento a locale non corretto"
                        );
                    continue;
                }
                var PareteBase = Polig3D.Parete_ACuiAssociato(elemento);
                if (PareteBase == null)
                {
                    TermodelLog.LogError($"Elemento:{elemento.Tipo}" +
                         $",Piano:{elemento.NomePiano}" +
                         $",Locale:{Polig3D.DatiLocaleACuiAssociato(elemento).Descrizione}" +
                         $", riferimento a parete base non corretto");
                    continue;
                }
                if (Polig3D.Parete_ACuiAssociato(elemento).datiopaca.Confine.ToUpper()!="FITTIZIA")
                TermodelLog.LogError($"Elemento:{elemento.Tipo}" +
                    $",Piano:{elemento.NomePiano}" +
                    $",Locale:{Polig3D.DatiLocaleACuiAssociato(elemento).Descrizione}" +
                    $",Confine:{Polig3D.Parete_ACuiAssociato(elemento).datiopaca.Confine} " +
                    $"non censito");
   
            }
        //var test= ElementiAssociati.Count();
    }
    // -------------------------------------------------------------------------------------------------------------

    //    Confine pareti verticali

    // -------------------------------------------------------------------------------------------------------------
    private static bool SuperficiComplanari(IfcCartesianPoint puntoInserimento1, IfcDirection direzione1,
                                        IfcCartesianPoint puntoInserimento2, IfcDirection direzione2,
                                        double APR, bool verticale, double aprAng = 0.001)
    {
        if (verticale)
        {
            // Logica per pareti verticali (già esistente)
            return VerticaliComplanari(puntoInserimento1, direzione1, puntoInserimento2, direzione2, APR, aprAng);
        }
        else
        {
            //già verificato in fase preliminare
            return true;
            // Verifica per pavimenti/soffitti (superfici orizzontali)
            if (Math.Abs(puntoInserimento1.Z - puntoInserimento2.Z) <= APR)
            {
                TermodelLog.LogOperation("Le due superfici orizzontali sono complanari.");
                return true;
            }
            else
            {
                // TermodelLog.LogOperation("Le superfici orizzontali non sono complanari.");
                return false;
            }
        }
    }

    private static bool VerticaliComplanari(IfcCartesianPoint puntoInserimento1, IfcDirection direzione1,
                                          IfcCartesianPoint puntoInserimento2, IfcDirection direzione2, double APR, double aprAng = 0.001)
    {
        // 1. Verifica se le direzioni sono uguali o opposte
        if (!DirezioniSimiliVert(direzione1, direzione2, aprAng))
        {
            //TermodelLog.LogOperation("Le direzioni delle due superfici non sono né uguali né opposte. Non sono complanari.");
            return false;
        }

        // 2. Calcola il vettore tra i due punti di inserimento
        double dx = puntoInserimento2.X - puntoInserimento1.X;
        double dy = puntoInserimento2.Y - puntoInserimento1.Y;
        //double dz = puntoInserimento2.Z - puntoInserimento1.Z;
        double dz = 0;
        // 3. Verifica se il vettore tra i punti di inserimento è parallelo alla direzione di sviluppo
        double dotProduct = dx * direzione1.X + dy * direzione1.Y + dz * direzione1.Z;
        double magnitudeVector = Math.Sqrt(dx * dx + dy * dy + dz * dz);
        double magnitudeDirection = Math.Sqrt(direzione1.X * direzione1.X + direzione1.Y * direzione1.Y + direzione1.Z * direzione1.Z);

        // Il prodotto scalare tra il vettore tra i punti e la direzione deve essere uguale alla magnitudine del vettore tra i punti
        double cosTheta = dotProduct / (magnitudeVector * magnitudeDirection);

        // Verifica che il vettore tra i punti sia parallelo alla direzione entro il margine APR
        if (Math.Abs(Math.Abs(cosTheta) - 1) > APR)
         //   if (Math.Abs(cosTheta - 1) > APR)
        {
            if (StopDebugConfini)
            {
                //TermodelLog.LogOperation($"I punti di inserimento non sono allineati con la direzione di sviluppo (cosTheta = {cosTheta}). Non sono complanari.");
                //TermodelLog.WriteLog($"Punto 1: ({puntoInserimento1.X}, {puntoInserimento1.Y}, {puntoInserimento1.Z})");
                //TermodelLog.WriteLog($"Punto 2: ({puntoInserimento2.X}, {puntoInserimento2.Y}, {puntoInserimento2.Z})");
                //TermodelLog.WriteLog($"Direzione: ({direzione1.X}, {direzione1.Y}, {direzione1.Z})");
                //TermodelLog.WriteLog($"dx={dx}, dy={dy}, dz={dz}, dotProduct={dotProduct}, cosTheta={cosTheta}");
            }
                return false;
        }

        // Se tutti i test sono passati, le superfici sono complanari
        //TermodelLog.LogOperation("Le due superfici sono complanari.");
        return true;
    }

    // Funzione che verifica se due direzioni sono simili o opposte di 180 gradi entro una tolleranza angolare
    private static bool DirezioniSimiliVert(IfcDirection direzione1, IfcDirection direzione2, double aprAng)
    {
        // Prodotto scalare tra le direzioni, ma ignoriamo la componente Z
        double dotProduct = direzione1.X * direzione2.X + direzione1.Y * direzione2.Y;

        // Calcolo delle magnitudini delle direzioni solo per le componenti X e Y
        double magnitude1 = Math.Sqrt(direzione1.X * direzione1.X + direzione1.Y * direzione1.Y);
        double magnitude2 = Math.Sqrt(direzione2.X * direzione2.X + direzione2.Y * direzione2.Y);

        // Calcolo del coseno dell'angolo tra le direzioni
        double cosAngolo = dotProduct / (magnitude1 * magnitude2);
        bool res= (Math.Abs(cosAngolo - 1) < aprAng) || (Math.Abs(cosAngolo + 1) < aprAng);
        if (StopDebugConfini&&!res)
        {
            //TermodelLog.WriteLog($"DirezioniSimiliVert d1:{direzione1}, d2:{direzione2}");
            //TermodelLog.WriteLog($"{res}   dotProduct={dotProduct}, magnitude1={magnitude1}, magnitude2={magnitude2}, cosAngolo={cosAngolo}");
        }
        // Verifica se le direzioni sono uguali (cosAngolo vicino a 1) o opposte (cosAngolo vicino a -1)
        return res;
    }
    // Funzione di supporto per convertire IfcPolyline in una geometria 2D proiettata sul piano X-Y

    // ------------------------------------  Converte i poligoni da IFC a 2d NetTopology suite  ---------------------------------------------------------

    private static NetTopologySuite.Geometries.Polygon ConvertiInPoligono2DVert(double quotac, IfcPolyline poligono, IfcCartesianPoint puntoInserimentoRiferimento, IfcCartesianPoint puntoInserimentoPoligono, IfcDirection direzione1, IfcDirection direzione2, ref bool direzioneOpposta)
    {
        var coordinate2D = new List<NetTopologySuite.Geometries.Coordinate>();

        // Calcoliamo la distanza tra i punti di inserimento del secondo poligono rispetto al primo, solo in XY
        double distanzaXY = Math.Sqrt(
            Math.Pow(puntoInserimentoPoligono.X - puntoInserimentoRiferimento.X, 2) +
            Math.Pow(puntoInserimentoPoligono.Y - puntoInserimentoRiferimento.Y, 2));
        double DifferenzaZ = puntoInserimentoPoligono.Z - puntoInserimentoRiferimento.Z;
        //double distanzaz = puntoInserimentoPoligono.Z+ Quota_corrente2 - (puntoInserimentoRiferimento.Z + Quota_corrente1);

        // Verifichiamo la direzione del secondo poligono rispetto al primo
        direzioneOpposta = VerificaDirezioneOpposta(direzione1, direzione2);

        // Trasformiamo ogni punto del poligono
        for (int i = 0; i < poligono.Points.Count; i++)
        {
            var punto = poligono.Points[i];

            // Se le direzioni sono opposte, invertiamo l'ordine dei punti
            double x = punto.X + distanzaXY;  // Correggiamo la X con la distanza tra i due punti di inserimento in XY
            if (direzioneOpposta)
            {
                x = -punto.X + distanzaXY;
                //punto = poligono.Points[poligono.Points.Count - 1 - i];
            }
            // Z diventa Y, X diventa X (con correzione solo in XY)
            double y = punto.Z + quotac+puntoInserimentoPoligono.Z;   // Z diventa Y nel piano 2D
            //double y = punto.Z + quotac ;   //prima della modifica

            coordinate2D.Add(new NetTopologySuite.Geometries.Coordinate(x, y));
        }

        var geometryFactory = new NetTopologySuite.Geometries.GeometryFactory();
        return geometryFactory.CreatePolygon(coordinate2D.ToArray());
    }
    private static NetTopologySuite.Geometries.Polygon ConvertiInPoligono2D(double quotac,
                                                                        IfcPolyline poligono,
                                                                        IfcCartesianPoint puntoInserimentoRiferimento,
                                                                        IfcCartesianPoint puntoInserimentoPoligono,
                                                                        IfcDirection direzione1,
                                                                        IfcDirection direzione2,
                                                                        bool verticale,
                                                                        ref bool direzioneOpposta)
    {
        // Se le superfici sono orizzontali, la trasformazione sarà più semplice
        // Nulla viene modificato
        if (!verticale)
        {
            // In questo caso ci basiamo solo su X e Y, ignorando Z
            var coordinate2D = new List<NetTopologySuite.Geometries.Coordinate>();
            foreach (var punto in poligono.Points)
            {
                double x = punto.X;
                double y = punto.Y;
                coordinate2D.Add(new NetTopologySuite.Geometries.Coordinate(x, y));
            }

            var geometryFactory = new NetTopologySuite.Geometries.GeometryFactory();
            return geometryFactory.CreatePolygon(coordinate2D.ToArray());
        }

        // Se la superficie è verticale, usiamo la logica esistente (che tiene conto di X, Y, Z)
        return ConvertiInPoligono2DVert(quotac, poligono, puntoInserimentoRiferimento, puntoInserimentoPoligono, direzione1, direzione2,ref direzioneOpposta);
    }


    // -------------------------Converte i poligoni da 2d NetTopology suite a IFC  -----------------------------

    private static IfcPolyline ConvertiDaPoligono2DConTransazione(double quotac, IfcStore model, NetTopologySuite.Geometries.Polygon poligono2D,
                                                                 IfcCartesianPoint nuovoPuntoInserimento, IfcCartesianPoint SecondoPuntoInserimento, IfcDirection nuovaDirezione,
                                                                 bool verticale,bool invertito)
    {
        poligono2D = EliminaVerticiEffimeri(poligono2D, 0.1);

        IfcPolyline ifcPolyline = null;
        double distanzaXY = Math.Sqrt(
            Math.Pow(nuovoPuntoInserimento.X - SecondoPuntoInserimento.X, 2) +
            Math.Pow(nuovoPuntoInserimento.Y - SecondoPuntoInserimento.Y, 2));
        // Iniziamo la transazione per lavorare con il modello IFC
        using (var txn = model.BeginTransaction("Converti Poligono2D in IFC"))
        {
            try
            {
                // Creiamo il nuovo poligono IFC e ripristiniamo i punti nel sistema IFC
                ifcPolyline = model.Instances.New<IfcPolyline>();

                foreach (var coord in poligono2D.Coordinates)
                {
                    double x = coord.X- distanzaXY;  // X rimane invariato
                    if(invertito) x = -coord.X-distanzaXY;

                    double y = coord.Y;  // Y rimane invariato
                    double z = 0;  // Inizialmente impostiamo Z a 0

                    // Se la superficie è verticale, facciamo la trasformazione classica (Z diventa Y)
                    if (verticale)
                    {
                        //z = coord.Y - quotac;  // prima della modifica
                        z = coord.Y - quotac-nuovoPuntoInserimento.Z;
                        y = 0;  // La Y è fissa a 0 per le superfici verticali
                    }
                    else
                    {
                        // Per superfici orizzontali, la Z è semplicemente 0, e la quota è rappresentata dal punto di inserimento
                        z = 0;  // La Z del poligono è 0, poiché la quota è rappresentata dal punto di inserimento
                    }

                    // Creiamo un nuovo punto IFC nel sistema 3D
                    var puntoIfc = model.Instances.New<IfcCartesianPoint>(p =>
                    {
                        p.SetXYZ(x, y, z);  // Coordiniamo XYZ
                    });

                    // Aggiungiamo il punto alla polyline IFC
                    ifcPolyline.Points.Add(puntoIfc);
                }

                // Commit della transazione se tutto è andato a buon fine
                txn.Commit();
                // TermodelLog.LogOperation("Poligono convertito con successo e aggiunto al modello IFC.");
            }
            catch (Exception ex)
            {
                // Se c'è un errore, facciamo il rollback della transazione
                txn.RollBack();
                TermodelLog.LogOperation($"Errore durante la conversione del poligono: {ex.Message}");
            }
        }

        // Ritorniamo il poligono IFC
        return ifcPolyline;
    }

    // -------------------------Converte i poligoni da 2d NetTopology suite a IFC  -----------------------------

    // Simulazione per verificare se le direzioni dei poligoni sono opposte
    private static bool VerificaDirezioneOpposta(IfcDirection direzione1, IfcDirection direzione2)
    {
        // Controlliamo se i vettori direzione sono opposti (per esempio se direzione1 è parallela ma negativa rispetto a direzione2)
        return (direzione1.X == -direzione2.X && direzione1.Y == -direzione2.Y && direzione1.Z == -direzione2.Z);
    }
    // Funzione che genera il poligono di sovrapposizione



    // Funzione che calcola l'area di un poligono (placeholder, implementare logica)
    private static double CalcolaArea(NetTopologySuite.Geometries.Geometry poligono)
    {
        // Verifica se l'oggetto è un poligono
        if (poligono is NetTopologySuite.Geometries.Polygon polygon)
        {
            return polygon.Area;  // NetTopologySuite calcola l'area direttamente
        }
        else
        {
            TermodelLog.LogOperation("Errore: la geometria non è un poligono. Impossibile calcolare l'area.");
            return 0.0;  // Se non è un poligono, restituisci 0 o un valore predefinito
        }
    }
    // ------------------------- Funzione che gestisce i poligoni che si sovrappongono -----------------------------
    private static bool VerificaPreliminareSovrapposizione(NetTopologySuite.Geometries.Polygon poligono1, NetTopologySuite.Geometries.Polygon poligono2, double apr)
    {
        // Otteniamo il bounding box (l'involucro rettangolare) di ciascun poligono
        var bbox1 = poligono1.EnvelopeInternal;
        var bbox2 = poligono2.EnvelopeInternal;

        // Verifica preliminare per sovrapposizione sui valori X
        if ((bbox1.MaxX + apr <= bbox2.MinX) || (bbox2.MaxX + apr <= bbox1.MinX))
        {
            //TermodelLog.LogOperation($"Nessuna sovrapposizione su asse X tra i due poligoni.");
            return false; // Non si sovrappongono sui valori X
        }

        // Verifica preliminare per sovrapposizione sui valori Y
        if ((bbox1.MaxY + apr <= bbox2.MinY) || (bbox2.MaxY + apr <= bbox1.MinY))
        {
            //TermodelLog.LogOperation($"Nessuna sovrapposizione su asse Y tra i due poligoni.");
            return false; // Non si sovrappongono sui valori Y
        }

        // Se passa i controlli preliminari di sovrapposizione, i poligoni potrebbero sovrapporsi
        //TermodelLog.LogOperation($"Possibile sovrapposizione rilevata tra i due poligoni.");
        return true;
    }
    // ---------------------------------------



    /// <summary>
    /// Elimina i vertici "effimeri" di un poligono, cioè quei vertici la cui rimozione non altera significativamente l'area del poligono.
    /// La tolleranza è espressa nelle stesse unità dell'area del poligono.
    /// </summary>
    /// <param name="poligono">Il poligono di input (deve essere di tipo Polygon)</param>
    /// <param name="tolleranzaArea">La variazione massima di area ammessa per considerare un vertice effimero</param>
    /// <returns>Un nuovo poligono semplificato</returns>
    public static Polygon EliminaVerticiEffimeri(NetTopologySuite.Geometries.Geometry poligono, double tolleranzaArea)
    {
        if (!(poligono is Polygon originalPolygon))
            throw new ArgumentException("La geometria deve essere un poligono.", nameof(poligono));

        // Calcola l'area originale
        double areaOriginale = originalPolygon.Area;

        // Ottieni la sequenza di coordinate dell'anello esterno come lista
        // Nota: l'anello deve essere chiuso (il primo e l'ultimo elemento sono uguali).
        var coords = originalPolygon.ExteriorRing.Coordinates.ToList();

        // Assicuriamoci che la lista sia chiusa
        if (!coords.First().Equals2D(coords.Last()))
            coords.Add(coords.First());

        bool eliminato;
        do
        {
            eliminato = false;

            // Itera su una copia della lista per evitare problemi di indice
            for (int i = 1; i < coords.Count - 1; i++) // Ignoriamo il primo e l'ultimo, poiché sono uguali
            {
                // Prova a rimuovere il vertice in posizione i
                var tempCoords = new List<Coordinate>(coords);
                tempCoords.RemoveAt(i);

                // Assicurati che il nuovo anello sia chiuso
                if (!tempCoords.First().Equals2D(tempCoords.Last()))
                    tempCoords.Add(tempCoords.First());

                // Ricostruisci il poligono
                var tempPolygon = new Polygon(new LinearRing(tempCoords.ToArray()));

                // Verifica se la variazione di area è entro la tolleranza
                if (Math.Abs(tempPolygon.Area - areaOriginale) <= tolleranzaArea)
                {
                    // Accetta la rimozione e aggiorna la lista dei vertici
                    coords = tempCoords;
                    eliminato = true;
                    break; // Esci dal ciclo for per ricominciare l'iterazione
                }
            }
        } while (eliminato && coords.Count > 3); // Continua finché riesci a rimuovere vertici e rimangono almeno 3 vertici

        // Ricostruisci il poligono finale assicurandoci che l'anello sia chiuso
        if (!coords.First().Equals2D(coords.Last()))
            coords.Add(coords.First());

        return new Polygon(new LinearRing(coords.ToArray()));
    }


private static bool PoligonoReale(NetTopologySuite.Geometries.Geometry poligonoSovrappostoGeom)
    {
        // Verifica se l'intersezione è vuota
        if (poligonoSovrappostoGeom==null||poligonoSovrappostoGeom.IsEmpty)
        {
            //TermodelLog.LogOperation("La parte sovrapposta tra i poligoni è vuota.");
            return false; // Nessuna sovrapposizione valida
        }

        // Verifica se l'intersezione è un poligono
        if (poligonoSovrappostoGeom is NetTopologySuite.Geometries.Polygon poligonoSovrappostoPoly)
        {
            // Verifica se l'area del poligono sovrapposto è inferiore alla soglia di approssimazione
            if (poligonoSovrappostoPoly.Area < Aprsup)
            {
                //TermodelLog.LogOperation($"Sovrapposizione ignorata poiché l'area è inferiore a {Aprsup} m².");
                return false; // Nessuna sovrapposizione significativa
            }
        }
        else
        {
            //TermodelLog.LogOperation("La geometria sovrapposta non è un poligono ed è stata ignorata.");
            return false; // Sovrapposizione non valida (non un poligono)
        }
        
        return true;
    }
    //--------------------------------------
    private static bool IfcDirInvertiti(IfcDirection d1, IfcDirection d2, double toleranceDegrees)
    {
        // Calcola la lunghezza (norma) dei vettori d1 e d2
        double length1 = Math.Sqrt(d1.X * d1.X + d1.Y * d1.Y + d1.Z * d1.Z);
        double length2 = Math.Sqrt(d2.X * d2.X + d2.Y * d2.Y + d2.Z * d2.Z);

        if (length1 == 0 || length2 == 0)
            throw new ArgumentException("Uno dei vettori di direzione ha lunghezza zero.");

        // Calcola il prodotto scalare dei due vettori
        double dot = d1.X * d2.X + d1.Y * d2.Y + d1.Z * d2.Z;

        // Normalizza il prodotto scalare dividendo per le norme dei vettori
        dot /= (length1 * length2);

        // Garantiamo che dot sia compreso tra -1 e 1 (per evitare errori in Math.Acos)
        dot = Math.Max(-1.0, Math.Min(1.0, dot));

        // Calcola l'angolo in radianti e convertilo in gradi
        double angleRadians = Math.Acos(dot);
        double angleDegrees = angleRadians * (180.0 / Math.PI);

        // Restituisce true se l'angolo differisce più della tolleranza specificata
        return angleDegrees > toleranceDegrees;
    }

    //--------------------------------------
    private static bool TrovaConfine(IfcStore model, ElementoAssociato par1, ElementoAssociato par2, bool vert, double Aprsup = 0.1)
    {
        // Chiamata alla funzione InvarianzaTrasformazioni per controllare che le trasformazioni siano corrette
        //bool invarianzaConfermata = InvarianzaTrasformazioni(model, par1.Poligono.Poligono, par1.Poligono.PuntoInserimento, par1.Poligono.Direzione, vert);

        //TermodelLog.LogOperation("-------------  Nuova analisi-------------------------");
        // 1. Proiezione dei poligoni 3D sul piano X-Y
        //TermodelLog.LogIfcPoly(par1.Poligono.Poligono, par1.Poligono.PuntoInserimento, par1.Poligono.Direzione,
        //$"Primo poligono: {par1.Poligono.ElementIdentifier}");

        //double zAssoluta1 = Quota_corrente1 + par1.Poligono.PuntoInserimento.Z;
        //double zAssoluta2 = Quota_corrente2 + par2.Poligono.PuntoInserimento.Z;
        //double diffZ = zAssoluta2 - zAssoluta1;
        double diffZ = Quota_corrente2 - Quota_corrente1;
        bool invertiti = false;
        var geom1 = ConvertiInPoligono2D(0, par1.Poligono.Poligono, par1.Poligono.PuntoInserimento, par1.Poligono.PuntoInserimento, par1.Poligono.Direzione, par1.Poligono.Direzione, vert, ref invertiti);


        //TermodelLog.LogIfcPoly(par2.Poligono.Poligono, par2.Poligono.PuntoInserimento, par2.Poligono.Direzione,
        //$"Secondo poligono: {par2.Poligono.ElementIdentifier}");

        var geom2 = ConvertiInPoligono2D(diffZ, par2.Poligono.Poligono, par1.Poligono.PuntoInserimento, par2.Poligono.PuntoInserimento, par1.Poligono.Direzione, par2.Poligono.Direzione, vert, ref invertiti);

        //var invertiti = IfcDirInvertiti(par1.Poligono.Direzione ,par2.Poligono.Direzione, 0.1);
        //if (invertiti&&vert) return false;
        // Log del poligono NTS dopo la conversione
        //TermodelLog.LogNtsPolygon(geom1, $"Poligono convertito da IFC a NTS: {par1.Poligono.ElementIdentifier}");

        // Log del poligono NTS dopo la conversione
        //TermodelLog.LogNtsPolygon(geom2, $"Poligono convertito da IFC a NTS: {par2.Poligono.ElementIdentifier}");

        // 2. Verifica se i poligoni 2D si intersecano
        string tipoSuperficie = vert ? "superfici verticali" : "superfici orizzontali";

        if (!vert)
        {

            TermodelLog.LogOperation($"==========> Verifica preliminare {tipoSuperficie} tra {par1.Poligono.ElementIdentifier} e {par2.Poligono.ElementIdentifier}.");
            //TermodelLog.LogDisegnoSVG(SVGHelper.SVGPolyNTS(geom1), geom2);
            //TermodelLog.LogNtsPolygon(geom1, $"Geom 1 ");
            //TermodelLog.LogNtsPolygon(geom2, $"Geom 2 ");
        }

        if (!VerificaPreliminareSovrapposizione(geom1, geom2, APR)) return false;


        if (!geom1.Intersects(geom2))
        {
            //TermodelLog.LogOperation("I poligoni non si intersecano nel piano X-Y.");
            return false; // Nessuna sovrapposizione
        }

        // 3. Generazione del poligono sovrapposto (parte comune tra i due poligoni)
        var poligonoSovrappostoGeom = NetTopologyPrime.IntersezioneSicura(geom1,geom2);

        if (!PoligonoReale(poligonoSovrappostoGeom)) return false;
       

        TermodelLog.LogOperation($"==========> Verifica sovrapposizione tra {tipoSuperficie} tra {par1.Poligono.ElementIdentifier} e {par2.Poligono.ElementIdentifier}.");
        
      if (!vert)
        {
            //TermodelLog.LogDisegnoSVG(SVGHelper.SVGPolyNTS(geom1), geom2);
            //TermodelLog.LogNtsPolygon(geom1, $"Geom 1 ");
            //TermodelLog.LogNtsPolygon(geom2, $"Geom 2 ");
        }
        
        // 4. Creazione della transazione IFC per l'inserimento dei poligoni sovrapposti
        //using (var txn = model.BeginTransaction("Inserisci Poligoni Sovrapposti"))
        //{
        try
        {

            IfcPolyline poligonoSovrapposto1 = null;
            IfcPolyline poligonoSovrapposto2 = null;
            // Verifica che l'oggetto di intersezione sia un poligono
            if (poligonoSovrappostoGeom is NetTopologySuite.Geometries.Polygon poligonoSovrappostoPolygon)
            {
                poligonoSovrapposto1 = ConvertiDaPoligono2DConTransazione(0, model, poligonoSovrappostoPolygon, par1.Poligono.PuntoInserimento, par1.Poligono.PuntoInserimento, par1.Poligono.Direzione, vert, invertiti);
                poligonoSovrapposto2 = ConvertiDaPoligono2DConTransazione(diffZ, model, poligonoSovrappostoPolygon, par2.Poligono.PuntoInserimento, par1.Poligono.PuntoInserimento, par2.Poligono.Direzione, vert, invertiti);
            }
            else
            {
                TermodelLog.LogOperation("Errore: la geometria sovrapposta non è un poligono.");
                return false;
            }


            // 6. Generazione dei poligoni residui (parte rimanente dopo la rimozione della parte sovrapposta)
            //return false;
            //------- Analisi poligono 1
            bool sdoppiato1 = false;
            var poligonoResiduo1Geom = NetTopologyPrime.DifferenzaSicura(geom1, poligonoSovrappostoGeom, "Residuo1");

            //var poligonoResiduo1Geom = geom1.Difference(poligonoSovrappostoGeom);
            //Polig3D.LineeCostruzione.AggiungiPoligonoNTS2D(-1.9, poligonoResiduo1Geom);

            //var poligonoResiduo1Geom =poligonoSovrappostoGeom;
            IfcPolyline poligonoResiduo1 = null;
            

            // Se il residuo è significativo, procediamo con la conversione e l'aggiornamento
            if (PoligonoReale(poligonoResiduo1Geom))
            //if (true)
            {
                if (poligonoResiduo1Geom is NetTopologySuite.Geometries.Polygon poligonoResiduo1Poly)
                {
                    
                    // Converte il residuo in IFC e lo aggiunge alla lista dei nuovi poligoni
                    poligonoResiduo1 = ConvertiDaPoligono2DConTransazione(0, model, poligonoResiduo1Poly, par1.Poligono.PuntoInserimento, par1.Poligono.PuntoInserimento, par1.Poligono.Direzione, vert, false);
                    
                    // La parte sovrapposta viene aggiunta alla lista, non richiede ulteriori sovrapposizioni
                    nuoviPoligoni.Add(new ElementoAssociato(
                                      new PoligonoEstrusoIfc(
                                      poligonoSovrapposto1,
                                      par1.Poligono.Spessore,
                                      "Sovrapposizione",
                                      par1.Poligono.PuntoInserimento,
                                      par1.Poligono.Direzione,
                                      $"Confina con {par2.Poligono.ElementIdentifier}",
                                      par1.Poligono.Tipo,
                                      par1.Poligono.QuotaCorrente,
                                      par1.Poligono.Tetto3D,
                                      par1.Poligono.Falda,
                                      par1.Poligono.Verticale),
                                      par1.Locale,  // Passa correttamente il locale di par1
                                      par1.PareteBase,  // Passa correttamente la parete base di par1
                                      par1.Tipo,
                                      new TDatiSuperficieOpaca(par1.datiopaca.Codice, par1.datiopaca.Confine),
                                      true,
                                      par1.NomePiano));  // Associa il tipo corretto di par1

                    // Assegniamo il residuo rimanente al poligono originale di par1
                    par1.Poligono.Poligono = poligonoResiduo1;
                    sdoppiato1 = true;
                }
            }
            else
            {
                //par1.datiopaca.Confine = "AmbienteClimatizzato";
                par1.Set_Stessa_Zona(par2);
                par1.Separatore = true;
            }
            // ------------ Analisi poligono 2
            bool sdoppiato2 = false;

           
            var poligonoResiduo2Geom = NetTopologyPrime.DifferenzaSicura(geom2, poligonoSovrappostoGeom, "Residuo2");
            //var poligonoResiduo2Geom = geom2.Difference(poligonoSovrappostoGeom);
            //Polig3D.LineeCostruzione.AggiungiPoligonoNTS2D(-2.2, poligonoResiduo2Geom);

            IfcPolyline poligonoResiduo2 = null;

            // Se il residuo è significativo, procediamo con la conversione e l'aggiornamento
            if (PoligonoReale(poligonoResiduo2Geom))
            {
                if (poligonoResiduo2Geom is NetTopologySuite.Geometries.Polygon poligonoResiduo2Poly)
                {
                    // Converte il residuo in IFC e lo aggiunge alla lista dei nuovi poligoni
                    poligonoResiduo2 = ConvertiDaPoligono2DConTransazione(diffZ, model, poligonoResiduo2Poly, par2.Poligono.PuntoInserimento, par1.Poligono.PuntoInserimento, par2.Poligono.Direzione, vert, invertiti);

                    nuoviPoligoni.Add(new ElementoAssociato(
                                      new PoligonoEstrusoIfc(
                                      poligonoSovrapposto2,
                                      par2.Poligono.Spessore,
                                      "Sovrapposizione",
                                      par2.Poligono.PuntoInserimento,
                                      par2.Poligono.Direzione,
                                      $"Confina con {par1.Poligono.ElementIdentifier}",
                                      par2.Poligono.Tipo,
                                      par2.Poligono.QuotaCorrente,
                                      par2.Poligono.Tetto3D,
                                      par2.Poligono.Falda, par2.Poligono.Verticale),
                                      par2.Locale,  // Passa correttamente il locale di par2
                                      par2.PareteBase,  // Passa correttamente la parete base di par2
                                      par2.Tipo,
                                      new TDatiSuperficieOpaca(par1.datiopaca.Codice, par1.datiopaca.Confine),
                                      true,
                                      par2.NomePiano));  // Associa il tipo corretto di par2

                    // Assegniamo il residuo rimanente al poligono originale di par2
                    par2.Poligono.Poligono = poligonoResiduo2;
                    sdoppiato2 = true;
                }
            }
            else
            {
                //par2.datiopaca.Confine = "AmbienteClimatizzato";
                par2.Set_Stessa_Zona(par1);
                par2.Separatore = true;
            }
            //Polig3D.LineeCostruzione.AggiungiPoligonoNTS2D(-1, geom1);
            //Polig3D.LineeCostruzione.AggiungiPoligonoNTS2D(-1.3, geom2);
           // Polig3D.LineeCostruzione.AggiungiPoligonoNTS2D(-1.6, poligonoSovrappostoGeom);
            
            // ---------------- Aggiorna i link di confine
            // return false;
            if (sdoppiato1 && sdoppiato2)
            {
                // Creazione di nuovi identificativi con subnumerazione per entrambi i poligoni
                string nuovoIdPar1 = $"{par1.Poligono.ElementIdentifier}-sub1";
                string nuovoIdPar2 = $"{par2.Poligono.ElementIdentifier}-sub1";

                // Aggiorna la descrizione per il poligono originale di par1 e par2
                par1.Poligono.Descrizione = $"Confina con: {nuovoIdPar2}";
                par2.Poligono.Descrizione = $"Confina con: {nuovoIdPar1}";

                // Aggiorna la descrizione e l'identificativo dei nuovi poligoni sdoppiati
                nuoviPoligoni[^2].Poligono.Descrizione = $"Confina con: {nuovoIdPar2}";
                nuoviPoligoni[^2].Poligono.ElementIdentifier = nuovoIdPar1;

                nuoviPoligoni[^1].Poligono.Descrizione = $"Confina con: {nuovoIdPar1}";
                nuoviPoligoni[^1].Poligono.ElementIdentifier = nuovoIdPar2;

                // Log per tracciare l'operazione in modo dettagliato
                //TermodelLog.LogOperation("I due poligoni  si intersecano e lasciano entrambe porzioni residue:");
                //TermodelLog.LogOperation($"1. Poligono originale par1 (ID: {par1.Poligono.ElementIdentifier}) aggiornato. Nuova descrizione: 'Confina con: {nuovoIdPar2}'");
                //TermodelLog.LogOperation($"2. Poligono originale par2 (ID: {par2.Poligono.ElementIdentifier}) aggiornato. Nuova descrizione: 'Confina con: {nuovoIdPar1}'");
                //TermodelLog.LogOperation($"3. Nuovo poligono di par1 creato con ID: {nuovoIdPar1}. Descrizione: 'Confina con: {nuovoIdPar2}'");
                //TermodelLog.LogOperation($"4. Nuovo poligono di par2 creato con ID: {nuovoIdPar2}. Descrizione: 'Confina con: {nuovoIdPar1}'");
            }
            else if (sdoppiato1)
            {
                // Solo par1 è stato sdoppiato
                string nuovoIdPar1 = $"{par1.Poligono.ElementIdentifier}-sub1";

                // Aggiorna la descrizione per il poligono originale di par2
                par2.Poligono.Descrizione = $"Confina con: {nuovoIdPar1}";

                // Aggiorna la descrizione e l'identificativo del nuovo poligono sdoppiato di par1
                nuoviPoligoni[^1].Poligono.Descrizione = $"Confina con: {par2.Poligono.ElementIdentifier}";
                nuoviPoligoni[^1].Poligono.ElementIdentifier = nuovoIdPar1;

                // Log per tracciare l'operazione in modo dettagliato
                //TermodelLog.LogOperation("Par 2 non lascia residui  par1 viene sdoppiato:");
                //TermodelLog.LogOperation($"1. Poligono originale par2 (ID: {par2.Poligono.ElementIdentifier}) aggiornato. Nuova descrizione: 'Confina con: {nuovoIdPar1}'");
                //TermodelLog.LogOperation($"2. Nuovo poligono di par1 creato con ID: {nuovoIdPar1}. Descrizione: 'Confina con: {par2.Poligono.ElementIdentifier}'");
            }
            else if (sdoppiato2)
            {
                // Solo par2 è stato sdoppiato
                string nuovoIdPar2 = $"{par2.Poligono.ElementIdentifier}-sub1";

                // Aggiorna la descrizione per il poligono originale di par1
                par1.Poligono.Descrizione = $"Confina con: {nuovoIdPar2}";

                // Aggiorna la descrizione e l'identificativo del nuovo poligono sdoppiato di par2
                nuoviPoligoni[^1].Poligono.Descrizione = $"Confina con: {par1.Poligono.ElementIdentifier}";
                nuoviPoligoni[^1].Poligono.ElementIdentifier = nuovoIdPar2;

                // Log per tracciare l'operazione in modo dettagliato
                //TermodelLog.LogOperation("Par 1 non lascia residui  par2 viene sdoppiato:");
                //TermodelLog.LogOperation($"1. Poligono originale di par1 (ID: {par1.Poligono.ElementIdentifier}) aggiornato con confine: {nuovoIdPar2}");
                //TermodelLog.LogOperation($"2. Nuovo poligono sdoppiato di par2 creato con ID: {nuovoIdPar2} e confine aggiornato con {par1.Poligono.ElementIdentifier}");
            }
            else
            {
                // Nessun poligono è stato sdoppiato
                par1.Poligono.Descrizione = $"Confina con: {par2.Poligono.ElementIdentifier}";
                par2.Poligono.Descrizione = $"Confina con: {par1.Poligono.ElementIdentifier}";

                // Log per tracciare l'operazione in modo dettagliato
                //TermodelLog.LogOperation("I poligoni si sovrappongono completamente:");
                //TermodelLog.LogOperation($"1. Poligono di par1 (ID: {par1.Poligono.ElementIdentifier}) aggiornato con confine: {par2.Poligono.ElementIdentifier}");
                //TermodelLog.LogOperation($"2. Poligono di par2 (ID: {par2.Poligono.ElementIdentifier}) aggiornato con confine: {par1.Poligono.ElementIdentifier}");
            }

            //txn.Commit(); // Committiamo la transazione se tutto è andato a buon fine
            Confini.GestisciPontiDopoSovrapposizione(par1, par2, sdoppiato1, sdoppiato2);
            return true;
        }
        catch (Exception ex)
        {
            // In caso di errore, facciamo il rollback della transazione
            //txn.RollBack();
            TermodelLog.LogOperation($"Errore durante l'operazione: {ex.Message}");
            return false;
        }
        //}
    }
    private static bool InvarianzaTrasformazioni(IfcStore model, IfcPolyline poligonoIfc, IfcCartesianPoint puntoInserimento, IfcDirection direzione, bool verticale = true)
    {
        TermodelLog.LogOperation("==========================================================================");

        //TermodelLog.LogOperation("Verifica di invarianza delle trasformazioni IFC -> NTS -> IFC.");
        // Log iniziale del poligono IFC
        //TermodelLog.LogIfcPoly(poligonoIfc, puntoInserimento, direzione, "Log del poligono IFC originale:");
        bool invertiti = false;
        // 1. Converti il poligono IFC in un poligono NTS
        var geomNTS = ConvertiInPoligono2D(0, poligonoIfc, puntoInserimento, puntoInserimento, direzione, direzione, verticale, ref invertiti);
        //TermodelLog.LogNtsPolygon(geomNTS, "Log del poligono NTS dopo la conversione da IFC:");

        // 2. Converti il poligono NTS di nuovo in un poligono IFC
        IfcPolyline poligonoIfcConvertito = ConvertiDaPoligono2DConTransazione(0, model, geomNTS, puntoInserimento, puntoInserimento, direzione, verticale,invertiti);
        //TermodelLog.LogIfcPoly(poligonoIfcConvertito, puntoInserimento, direzione, "Log del poligono IFC dopo la riconversione da NTS:");

        // 3. Verifica l'invarianza: il poligono risultante deve essere uguale all'originale
        bool invariato = ConfrontaPoligoniIFC(poligonoIfc, poligonoIfcConvertito);

        if (invariato)
        {
            //TermodelLog.LogOperation("Il poligono è invariato dopo le trasformazioni IFC -> NTS -> IFC.");
        }
        else
        {
            //TermodelLog.LogOperation("Il poligono NON è invariato dopo le trasformazioni IFC -> NTS -> IFC.");
        }
        //TermodelLog.LogOperation("==========================================================================");

        return invariato;
    }


    // Funzione di confronto tra due poligoni IFC
    private static bool ConfrontaPoligoniIFC(IfcPolyline poligono1, IfcPolyline poligono2)
    {
        // Verifica che il numero di punti sia lo stesso
        if (poligono1.Points.Count != poligono2.Points.Count)
        {
            return false;
        }

        // Confronta punto per punto
        for (int i = 0; i < poligono1.Points.Count; i++)
        {
            var p1 = poligono1.Points[i];
            var p2 = poligono2.Points[i];

            if (Math.Abs(p1.X - p2.X) > 0.001 || Math.Abs(p1.Y - p2.Y) > 0.001 || Math.Abs(p1.Z - p2.Z) > 0.001)
            {
                return false;
            }
        }

        return true;
    }
    private static bool SovrapponiSuperficie(IfcStore model, ElementoAssociato par1, ElementoAssociato par2, bool verticale)
    {
        // Verifica se i due poligoni sono complanari utilizzando la funzione SuperficiComplanari
        if (!SuperficiComplanari(par1.Poligono.PuntoInserimento, par1.Poligono.Direzione, par2.Poligono.PuntoInserimento, par2.Poligono.Direzione, APR, verticale))
        {
            if (StopDebugConfini)
            TermodelLog.LogOperation($"I poligoni {par1.Poligono.ElementIdentifier} e {par2.Poligono.ElementIdentifier} non sono complanari. Nessuna sovrapposizione possibile.");
            return false;
        }

        // Se i poligoni sono complanari, cerca sovrapposizioni)
        return TrovaConfine(model, par1, par2, verticale, Aprsup);
    }
    // ------------------------- Scandisce il database alla ricerca si superfici dello stesso tipo che si sovrappongono   -----------------------------
    public static double Quota_corrente1 = 0;
    public static double Quota_corrente2 = 0;
    public static void AnalizzaConfiniParete(ElementoAssociato elemento)
    {
        // Log per identificare l'elemento in analisi
        //TermodelLog.LogOperation($"Inizio analisi dei confini per la parete con ID: {elemento.Poligono.ElementIdentifier}");

        // Otteniamo l'indice dell'elemento attualmente in esame nella lista
        int indiceElemento = ElementiAssociati.IndexOf(elemento);

        // Scorriamo gli altri elementi successivi nella lista per evitare duplicati
        for (int i = indiceElemento + 1; i < ElementiAssociati.Count; i++)
         if(!ElementiAssociati[i].Poligono.Falda && !elemento.Separatore)
        {

            var altroElemento = ElementiAssociati[i];

            StopDebugConfini = ((elemento.Poligono.ElementIdentifier == debugConfine1 && altroElemento.Poligono.ElementIdentifier == debugConfine2) ||
            (elemento.Poligono.ElementIdentifier == debugConfine2 && altroElemento.Poligono.ElementIdentifier == debugConfine1));

                    Quota_corrente2 = altroElemento.Poligono.QuotaCorrente;
            // Verifichiamo che anche l'altro elemento sia di tipo Parete
            if ((altroElemento.Tipo == TipoElemento.Parete) && (elemento.Tipo == TipoElemento.Parete))
            {
                //TermodelLog.LogOperation($"Confronto con {altroElemento.Poligono.ElementIdentifier} ,{altroElemento.Poligono.Descrizione}.");

                // Lanciamo la funzione SovrapponiSuperficie per verificare la sovrapposizione tra le due pareti
                bool siSovrappongono = SovrapponiSuperficie(model, elemento, altroElemento, verticale);

                if (siSovrappongono)
                {
                    // Se c'è sovrapposizione, logghiamo l'informazione
                    TermodelLog.LogOperation($"Le pareti con ID {elemento.Poligono.ElementIdentifier},{elemento.Poligono.Descrizione} e {altroElemento.Poligono.ElementIdentifier} ,{altroElemento.Poligono.Descrizione} si sovrappongono.");
                }
            }
            // Verifichiamo che anche l'altro elemento sia di tipo Pavimento
            if (((altroElemento.Tipo == TipoElemento.Pavimento) && (elemento.Tipo == TipoElemento.Soffitto))||
                 ((elemento.Tipo == TipoElemento.Pavimento) && (altroElemento.Tipo == TipoElemento.Soffitto))
               )
            {
                
                // Lanciamo la funzione SovrapponiSuperficie per verificare la sovrapposizione tra le due pareti
                bool siSovrappongono = (Math.Abs((Quota_corrente2 + altroElemento.Poligono.PuntoInserimento.Z) - (elemento.Poligono.PuntoInserimento.Z + Quota_corrente1)) <= 0.1);

                
                //bool siSovrappongono = SovrapponiSuperficie(model, elemento, altroElemento, !verticale);

                if (siSovrappongono)
                {
                        //TermodelLog.LogOperation($"Quote verificate.");

                        //TermodelLog.LogOperation($" {altroElemento.Poligono.ElementIdentifier} ,{altroElemento.Poligono.Descrizione}.");

                        siSovrappongono = SovrapponiSuperficie(model, elemento, altroElemento, !verticale);
                    // Se c'è sovrapposizione, logghiamo l'informazione
                    TermodelLog.LogOperation($"I solai con ID {elemento.Poligono.ElementIdentifier},{elemento.Poligono.Descrizione} e {altroElemento.Poligono.ElementIdentifier} ,{altroElemento.Poligono.Descrizione} si sovrappongono.");
                }
            }
        }

        // Log finale
        //TermodelLog.LogOperation($"Analisi dei confini per la parete con ID: {elemento.Poligono.ElementIdentifier} completata.");
    }
    // -------------------------------------------------------------------------------------------------------------

    //    Analisi del confine delle superfici.

    // -------------------------------------------------------------------------------------------------------------
    static double APR = 0.01;
    static double Aprsup = 0.1;
    static bool verticale = true;
    static string debugConfine1 = "Parete N.6";
    static string debugConfine2 = "Parete N.4";
    static bool StopDebugConfini = false;
    public static void TrovaConfini(IfcStore modello, IfcGeometricRepresentationContext GeometricRepresentationContesto)
    {
        //return;
        TermodelLog.LogOperation($"----------------------------------------------------------------------");
        TermodelLog.LogOperation($"");
        TermodelLog.LogOperation($"       Analisi dei confini , contatto tra le superfici 3d ");
        TermodelLog.LogOperation($"");
        TermodelLog.LogOperation($"----------------------------------------------------------------------");
        TermodelLog.LogOperation($"");
        model = modello;
        GeometricRepresentationContext = GeometricRepresentationContesto;

        bool aggiunti = true;
        while (aggiunti)
        {
            aggiunti = false;
            nuoviPoligoni.Clear();
            foreach (var elemento in ElementiAssociati)
                if (!elemento.Poligono.Falda && !elemento.Separatore)
                {
                    Quota_corrente1 = elemento.Poligono.QuotaCorrente;
                    // Verifica il tipo di elemento
                    switch (elemento.Tipo)
                    {
                        case TipoElemento.Parete:

                            //TermodelLog.LogOperation($"------------   Analisi dei confini ,'Parete' con ID: {elemento.Poligono.ElementIdentifier},{elemento.Poligono.Descrizione} ");

                            // Aggiungere qui l'algoritmo per analizzare i confini delle pareti
                            AnalizzaConfiniParete(elemento);

                            break;

                        case TipoElemento.Soffitto:
                            if (!elemento.Poligono.Tetto3D)
                            {
                                //TermodelLog.LogOperation($"------------ Analisi dei confini per l'elemento di tipo . con ID: {elemento.Poligono.ElementIdentifier}");

                                // Aggiungere qui l'algoritmo per analizzare i confini dei soffitti
                                //AnalizzaConfiniSoffitto(elemento);
                                AnalizzaConfiniParete(elemento);
                            }
                            break;

                        case TipoElemento.Pavimento:
                            // Log dell'operazione
                            //TermodelLog.LogOperation($"Analisi dei confini per l'elemento di tipo 'Pavimento' con ID: {elemento.Poligono.ElementIdentifier}");

                            // Aggiungere qui l'algoritmo per analizzare i confini dei pavimenti
                            //AnalizzaConfiniPavimento(elemento);

                            break;

                        case TipoElemento.Finestra:
                            // Log dell'operazione
                            //TermodelLog.LogOperation($"Analisi dei confini per l'elemento di tipo 'Finestra' con ID: {elemento.Poligono.ElementIdentifier}");

                            // Aggiungere qui l'algoritmo per analizzare i confini delle finestre
                            //AnalizzaConfiniFinestra(elemento);

                            break;

                        case TipoElemento.Ponte:
                            // Log dell'operazione
                            //TermodelLog.LogOperation($"Analisi dei confini per l'elemento di tipo 'Ponte' con ID: {elemento.Poligono.ElementIdentifier}");

                            // Aggiungere qui l'algoritmo per analizzare i confini dei ponti
                            //AnalizzaConfiniPonte(elemento);

                            break;

                        default:
                            // Log dell'operazione nel caso in cui il tipo non sia riconosciuto
                            //TermodelLog.LogOperation($"Tipo di elemento sconosciuto per l'elemento con ID: {elemento.Poligono.ElementIdentifier}");
                            break;
                    }
                }

            // Log finale per segnalare la fine della ricerca dei confini
            TermodelLog.LogOperation("=======>  Ricerca dei confini completata, elenco poligoni aggiunti");
            // Se ci sono nuovi poligoni creati, aggiungerli al database per il redraw
            // ElementiAssociati.AddRange(nuoviPoligoni);
            if (nuoviPoligoni.Any())
            {
                aggiunti = true;
                foreach (var nuovoPoligono in nuoviPoligoni)
                {
                    ElementiAssociati.Add(nuovoPoligono); // Aggiungiamo i nuovi poligoni generati al DB principale
                    TermodelLog.LogOperation($"Nuovo poligono aggiunto al DB con ID: {nuovoPoligono.Poligono.ElementIdentifier} e Descrizione: {nuovoPoligono.Poligono.Descrizione}");
                }
            }
        }
        TermodelLog.LogOperation("-------------------------------------------------------------------------------------------------------------");
        TermodelLog.LogOperation("");
        TermodelLog.LogOperation("Ricerca dei confini tra i poligoni estrusi completata ...");
        TermodelLog.LogOperation("");
        TermodelLog.LogOperation("-------------------------------------------------------------------------------------------------------------");

    }
    // Metodo per ridisegnare tutti i poligoni nel modello BIM
    public static bool IsFittizia(ElementoAssociato elemento)
    {
        var confine = GestXml.DeterminaTipoConfine(elemento);
        //if(confine == TipoConfine.Fittizia)
        //    TermodelLog.LogOperation("Fittizia");
        return confine == TipoConfine.Fittizia;
    }


    // Modificato da Codex per realizzare: commutazione comandata tra diagnostica DXF 2D e modello 3D.
    public static void GrafRedraw(bool RecalcView, bool forzaModello3D = false)
    {
        drawBimControl.SvuotaBuffer();
        Polig3D.LineeCostruzione.SvuotaListaLinee();
        if (TermodelLog.erroreDaMostrare != null && !forzaModello3D)
        {
            VisualizzaDiagnosticaDxf(RecalcView);
            return;
        }



        if (GeneraModello.PrimoErrore != "" && !forzaModello3D)
        {
            ErroreManager.VisualizzaErrori();
        }
        else
        {
           
            TermodelLog.LogOperation("--------- Redraw Grafica 3d _________");
            // Modificato da Codex per realizzare: il check Pannelli attiva la vista fil di ferro composta da sole spirali e ponti termici.
            bool mostraSoloPannelliEPonti =
                MainWindow.FiltriGraficiControlStatic.ComponenteFiltrato("Pannelli");
            int idx = 0;
            foreach (var elemento in ElementiAssociati)
            {
                idx++;
                // DIVIDI è una linea topologica riservata alla suddivisione
                // delle aree dei circuiti. Non rappresenta un componente
                // edilizio e non deve mai essere visualizzata nel browser 3D.
                if (string.Equals(
                    elemento.datiopaca?.Confine,
                    "DIVIDI",
                    StringComparison.OrdinalIgnoreCase))
                {
                    continue;
                }

                // Modificato da Codex per realizzare: nella vista Pannelli escludere i componenti edilizi e conservare i ponti termici; le spirali SVG sono aggiunte al termine del ridisegno.
                if (mostraSoloPannelliEPonti && elemento.Tipo != TipoElemento.Ponte)
                {
                    continue;
                }

                //TermodelLog.LogOperation($"Elemento aggregato a locale con ID: {elemento.Poligono.ElementIdentifier}, descrizione: {elemento.Poligono.Descrizione}, Tipo: {elemento.Poligono.Tipo},confine:{GestXml.DeterminaTipoConfine(elemento).ToString()}, QuotaCorrente: {elemento.Poligono.QuotaCorrente}, Separatore: {elemento.Separatore}");

                //if (elemento.Separatore)
                //if (!elemento.StessaZona) continue;
                //var sz = MainWindow.FiltriGraficiControlStatic.ConfineFiltrato("StessaZona");
                //if (elemento.Separatore|| !elemento.StessaZona)
                //    {
                //    var sz = MainWindow.FiltriGraficiControlStatic.ConfineFiltrato("StessaZona");
                //}
                if (MainWindow.FiltriGraficiControlStatic.PianoFiltrato(elemento.NomePiano))
                    if (MainWindow.FiltriGraficiControlStatic.ComponenteFiltrato(elemento.Tipo.ToString()))
                    if (!elemento.StessaZona||MainWindow.FiltriGraficiControlStatic.ConfineFiltrato("StessaZona"))
                        if (
                            elemento.Poligono.Falda || 
                            elemento.Separatore||
                            (elemento.Tipo == TipoElemento.Mansardato && MainWindow.FiltriGraficiControlStatic.ConfineFiltrato("Esterno") ||
                              (elemento.Tipo != TipoElemento.Mansardato && 
                               !elemento.Poligono.Falda && 
                               MainWindow.FiltriGraficiControlStatic.ConfineFiltrato(GestXml.DeterminaTipoConfine(elemento).ToString()))
                              )
                            )
                           if (
                                elemento.Tipo == TipoElemento.Ponte||
                               //elemento.Poligono.Falda ||
                               //elemento.Separatore
                               (elemento.Separatore &&  MainWindow.FiltriGraficiControlStatic.SeparatoreFiltrato("Separatori")) ||

                               (!elemento.Separatore &&  MainWindow.FiltriGraficiControlStatic.SeparatoreFiltrato("NonSeparatori")) 
                               //                             (elemento.Tipo != TipoElemento.Mansardato && !elemento.Poligono.Falda && MainWindow.FiltriGraficiControlStatic.ConfineFiltrato(GestXml.DeterminaTipoConfine(elemento).ToString()))
                               )
                                if (
                                  !elemento.Separatore ||
                                  (elemento.Separatore && !IsFittizia(elemento))||
                                 ( IsFittizia(elemento) && MainWindow.FiltriGraficiControlStatic.SeparatoreFiltrato("Fittizie")) 
                                 )
                                {
                                        var Descrizione =elemento.Poligono.Descrizione;
                                        string len1 = elemento.datiopaca.LunghezzaPonte
                                        .ToString("0.0", CultureInfo.InvariantCulture); // 1 decimale, punto
                                        if (elemento.Tipo == TipoElemento.Ponte) Descrizione =
                                                $"{idx}:{ elemento.datiopaca.Codice},{len1} m";
                                        //string conf = GestXml.DeterminaTipoConfine(elemento).ToString();
                                        //if (elemento.Tipo == TipoElemento.Ponte) 
                                        {
                                            var nuovoPoligonoEstruso = AggiungiEstrudePolygonOpenGl(
                                           idx,
                                           elemento.Poligono.QuotaCorrente,
                                           elemento.Poligono.Poligono,
                                           elemento.Poligono.Spessore,
                                           elemento.Poligono.ElementIdentifier,
                                           elemento.Poligono.PuntoInserimento,
                                           elemento.Poligono.Direzione,
                                           Descrizione,
                                           elemento.Tipo,
                                           elemento.Poligono.Verticale,
                                           elemento.datiopaca.Start,
                                           elemento.datiopaca.End
                                       );
                                        }

                            }
            }
           // if (MainWindow.FiltriGraficiControlStatic.Lineeiltrate("Linee di costruzione"))
            //    LineeCostruzione.VisualizzaLinee3D();
        }
        //IoPannelli.DisegnaSpirali(drawBimControl.viewport,quotaPiano: 0);
        IoPannelli.DisegnaSvgSpirali(
    drawBimControl.viewport,
    // Modificato da Codex per realizzare: leggere l'SVG pannelli dal progetto corrente
    // anziché dipendere dalla cartella di avvio del processo.
    GestProg.FileLocaleSvgPath,
    quotaPiano: 0);
        drawBimControl.Redraw(RecalcView);
    }

    // Funzione realizzata da Codex in autonomia
    public static void VisualizzaDiagnosticaDxf(bool ricalcolaVista)
    {
        drawBimControl.SvuotaBuffer();
        Polig3D.LineeCostruzione.SvuotaListaLinee();

        MainWindow mainWindow = Application.Current.MainWindow as MainWindow;
        if (mainWindow != null)
        {
            mainWindow.LabPrimoErrore.Content =
                TermodelLog.erroreDaMostrare ?? "Modalità diagnostica input 2D";
            mainWindow.PrimoErrore.Visibility = Visibility.Visible;
        }

        HelixDXF.I.RenderFiltrato(
            drawBimControl.viewport,
            MainWindow.FiltriGraficiControlStatic,
            visualizzaTutto: true);
        drawBimControl.CalcolaLimitiInputDXF();
        drawBimControl.Redraw(ricalcolaVista);
    }
    public static void RedrawBim(IfcStore modello, IfcGeometricRepresentationContext GeometricRepresentationContesto)
    {
        
            model = modello;

            GeometricRepresentationContext = GeometricRepresentationContesto;

        //TrovaConfini();


        //InitClass();


        //-----
        TermodelLog.LogOperation("----------------------------  Generanzione degli elementi BIM -----------------------------------------");
        foreach (var elemento in ElementiAssociati)
        {
            var nuovoPoligonoEstruso = AggiungiEstrudePolygon(
                        elemento.Poligono.QuotaCorrente,
                        elemento.Poligono.Poligono,
                        elemento.Poligono.Spessore,
                        elemento.Poligono.ElementIdentifier,
                        elemento.Poligono.PuntoInserimento,
                        elemento.Poligono.Direzione,
                        elemento.Poligono.Descrizione,
                        elemento.Tipo,
                        false
                    );
            
                //string idLocale = elemento.Locale != null ? elemento.Locale.GlobalId.ToString() : "Nessun locale associato";
                using (var txn = model.BeginTransaction($"Redraw element {elemento.Poligono.ElementIdentifier}"))
                {
                    try
                    {

                        if (nuovoPoligonoEstruso != null)
                        {
                            if (Aggre_Locale(elemento.Tipo))
                            {
                            //TermodelLog.LogOperation($"Elemento aggregato a locale con ID: {elemento.Poligono.ElementIdentifier}, descrizione: {elemento.Poligono.Descrizione}, Tipo: {elemento.Poligono.Tipo}, QuotaCorrente: {elemento.Poligono.QuotaCorrente}, Separatore: {elemento.Separatore}");
                            
                            if (elemento.datiopaca.Confine !=null)
                            if (elemento.datiopaca.Confine.ToLower() == "fittizia"&& !elemento.Separatore) 
                                elemento.datiopaca.Confine = "Esterno";

                            //PareteCorr = nuovoPoligonoEstruso;
                            elemento.PoligonoIFCBim = nuovoPoligonoEstruso;
                            model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                                {
                                    r.RelatingStructure = elemento.Locale;
                                    r.RelatedElements.Add(nuovoPoligonoEstruso);
                                });
                            }
                            else if (PareteCorr != null)
                            {
                            //TermodelLog.LogOperation($"Elemento aggregato a parete con ID: {elemento.Poligono.ElementIdentifier}, descrizione: {elemento.Poligono.Descrizione}, Tipo: {elemento.Poligono.Tipo}, QuotaCorrente: {elemento.Poligono.QuotaCorrente}");

                            model.Instances.New<IfcRelAggregates>(rel =>
                                {
                                    //rel.RelatingObject = PareteCorr;
                                    rel.RelatingObject = elemento.PareteACuiAssociata.PoligonoIFCBim;
                                    rel.RelatedObjects.Add(nuovoPoligonoEstruso);
                                });
                            }
                        }

                        txn.Commit();
                    }
                    catch (Exception ex)
                    {
                        txn.RollBack();
                        // Log dell'errore in TermodelLog
                        TermodelLog.LogOperation($"Errore nel ridisegnare il poligono con ID: {elemento.Poligono.ElementIdentifier}. Messaggio di errore: {ex.Message}");
                        TermodelLog.LogOperation($"Stack trace: {ex.StackTrace}");
                        Console.WriteLine($"Errore nel ridisegnare il poligono {elemento.Poligono.ElementIdentifier}: {ex.Message}");
                    }
                }
            }
        //GrafRedraw();
    }
}
