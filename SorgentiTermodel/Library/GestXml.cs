using System;
using System.IO;
using System.Xml.Linq;
using Termodel.utilities;
using Xbim.Ifc4.SharedBldgElements;
using static Termodel.Modello;
using Termodel.utilities;
using Termodel.Leggidxf;
using Newtonsoft.Json;
using System.Xml;
using System.Globalization;
using System.ComponentModel;
using Xbim.Ifc4.GeometryResource;
using static GestXml;
//using Microsoft.AspNetCore.Components;
using System.Windows.Controls;
using static Microsoft.Isam.Esent.Interop.EnumeratedColumn;
using Termodel;
using System.Windows.Documents;
using System.Windows;
using static Polig3D;
using netDxf.Tables;
using System.Security.Policy;
using Termodel.output;
using System.DirectoryServices.ActiveDirectory;
using netDxf.Entities;
using static Termodel.utilities.UtiDb;
using Termodel.Calcoli;
using Termodel.Impianti.Pannelli;

public static class GestXml
{

    public enum TipoConfine
    {
        Esterno,
        Interno,
        AmbienteNonClimatizzato,
        AmbienteClimatizzato,
        Terreno,
        Fittizia,
        Dividi,
        Sconosciuto  // Aggiunto per gestire tipi non previsti
    }
    public static TipoConfine StrTipoConfineToEnum(string tipoConfine)
    {
        if (tipoConfine == null) return TipoConfine.Sconosciuto;  // Gestione di tipi non previsti
        if (tipoConfine.ToLower() == "fittizia")
            return TipoConfine.Fittizia;
        if (tipoConfine.ToLower() == "dividi")
            return TipoConfine.Dividi;
        // if (tipoConfine.ToLower() == "esterno")
        //     return TipoConfine.Esterno;
        var ConfineTipizzato = "Esterno";
        if (tipoConfine != "Esterno")
            ConfineTipizzato = utidb.GetDataDB("Codice", tipoConfine, "Tipo", confinicollection);

        if (ConfineTipizzato == null)
            return TipoConfine.Sconosciuto;  // Gestione di tipi non previsti
        switch (ConfineTipizzato.ToLower())
        {
            case "automatico":
                return TipoConfine.Esterno;
            case "esterno":
                return TipoConfine.Esterno;
            case "interno":
                return TipoConfine.Interno;
            case "ambientenonclimatizzato":
                return TipoConfine.AmbienteNonClimatizzato;
            case "ambienteclimatizzato":
                return TipoConfine.AmbienteClimatizzato;
            case "terreno":
                return TipoConfine.Terreno;
            default:
                TermodelLog.LogError($"Tipo confine non riconosciuto: {tipoConfine}");
                return TipoConfine.Sconosciuto;  // Gestione di tipi non previsti
        }
    }
    public static UtiDb utidb = null;
    public static System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> pareticollection = null;
    public static System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> confinicollection = null;
    public static System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> zonecollection = null;
    public static System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> finestrecollection = null;
    public static System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> ponticollection = null;
    public static System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> nonclimatizzaticollection = null;
    public static double DirezioneNord;
    public static double superficieNettaTotale = 0;
    public static double volumeNettoTotale = 0;
    public static double superficieLordaDisperdenteTotale = 0;
    public static double volumeLordoClimatizzatoTotale = 0;
    public static double superficieInfissiTotale = 0;
    public static double trasmittanzaTotaleInfissi = 0;

    private static MainWindow _mainWindow;
    public static void Init_class(MainWindow mainWindow, UtiDb Utidb)
    {
        _mainWindow = mainWindow;
        utidb = Utidb;
        pareticollection = utidb.GetCollection("Pareti");
        confinicollection = utidb.GetCollection("Confini");
        zonecollection = utidb.GetCollection("Zone");
        finestrecollection = utidb.GetCollection("Finestre");
        ponticollection = utidb.GetCollection("Ponti");
        nonclimatizzaticollection = utidb.GetCollection("NonClimatizzati");
    }
    public static TipoConfine DeterminaTipoConfine(ElementoAssociato componente)
    {

        if (componente.Locale == null)
        {
            if (componente.PareteACuiAssociata != null && componente.PareteACuiAssociata.datiopaca != null)
            {
                //var tipoconfine = utidb.GetDataDB(string KeyField, string FindData, string ReturnField, confinicollection);
                return StrTipoConfineToEnum(componente.PareteACuiAssociata.datiopaca.Confine);

            }
        }
        else if (componente != null && componente.datiopaca != null && componente.datiopaca.Confine != null)
        {
            //var tipoconfine = utidb.GetDataDB(string KeyField, string FindData, string ReturnField, confinicollection);

            //if (componente.StessaZona != null || componente.StessaZona)
            //return StrTipoConfineToEnum("StessaZona");
            //else 
            return StrTipoConfineToEnum(componente.datiopaca.Confine);
        }
        TermodelLog.LogError($"{TermodelLog.LogContesto}, confine sconosciuto");
        return TipoConfine.Sconosciuto;
    }
    public static class XMLConverter
    {
        public static void XMLToJSON(XElement xmlElement, string jsonFilePath)
        {
            // Converte XElement in una stringa XML
            string xmlString = xmlElement.ToString();

            // Carica la stringa XML in un XmlDocument
            XmlDocument xmlDoc = new XmlDocument();
            xmlDoc.LoadXml(xmlString);

            // Converte XmlDocument in una stringa JSON
            string jsonString = JsonConvert.SerializeXmlNode(xmlDoc, Newtonsoft.Json.Formatting.Indented);

            // Scrive il JSON nel file specificato
            File.WriteAllText(jsonFilePath, jsonString);
        }

        // Funzione che converte XML in JSON e salva nello stesso percorso
        public static void SaveAsJson(string xmlOutPath)
        {
            // Carica l'XML
            XElement xmlElement = XElement.Load(xmlOutPath);

            // Ottiene il percorso con l'estensione .json
            string jsonFilePath = Path.ChangeExtension(xmlOutPath, ".json");

            // Salva il file JSON
            XMLToJSON(xmlElement, jsonFilePath);
        }
    }
    public static void AggiungiFinestre(XDocument doc, XElement superficieOpacaNode, IfcBuildingElementProxy pareteBase)
    {
        // Crea il nodo "superficieTrasparente" (fratello di "superficieOpaca")
        XElement superficieTrasparenteNode = new XElement("superficieTrasparente");

        // Cerca le finestre collegate alla parete
        var finestreCollegate = CercaFinestreCollegate(pareteBase);

        if (finestreCollegate != null && finestreCollegate.Count > 0)
        {
            foreach (var finestra in finestreCollegate)
            {
                // Creiamo un nodo "finestra" per ogni finestra trovata
                XElement finestraNode = new XElement("finestra");

                // Aggiungi gli attributi alla finestra, come nome, area, trasmittanza ecc.
                finestraNode.SetAttributeValue("nome", finestra.Name);
                finestraNode.SetAttributeValue("superficie", finestra.Superficie.ToString());
                finestraNode.SetAttributeValue("trasmittanza", finestra.Trasmittanza.ToString());
                // Aggiungi altri attributi rilevanti...

                // Aggiungi la finestra al nodo "superficieTrasparente"
                superficieTrasparenteNode.Add(finestraNode);
            }
        }
        else
        {
            // Se non ci sono finestre collegate, puoi loggare un messaggio o ignorare
            TermodelLog.LogOperation($"Nessuna finestra trovata per la parete {pareteBase.Name}");
        }

        // Aggiungi il nodo "superficieTrasparente" come fratello di "superficieOpaca"
        superficieOpacaNode.Parent.Add(superficieTrasparenteNode);
    }


    // Funzione per cercare le finestre collegate alla parete
    private static List<FinestraInfo> CercaFinestreCollegate(IfcBuildingElementProxy pareteBase)
    {
        // Simuliamo la ricerca di finestre collegate (questo dipende da come i dati sono organizzati nel tuo modello IFC)
        List<FinestraInfo> finestre = new List<FinestraInfo>();

        // Esempio di ricerca di finestre nel modello IFC (aggiungi la logica corretta)
        foreach (var relazione in pareteBase.ConnectedTo)
        {
            /*
            if (relazione is IfcWindow finestra)
            {
                // Aggiungi la finestra alla lista
                finestre.Add(new FinestraInfo(finestra.Name, finestra.GetSuperficie(), finestra.Trasmittanza));
            }
            */
        }

        return finestre;
    }

    // Classe helper per memorizzare le informazioni della finestra (puoi adattarla)
    public class FinestraInfo
    {
        public string Name { get; set; }
        public double Superficie { get; set; }
        public double Trasmittanza { get; set; }

        public FinestraInfo(string name, double superficie, double trasmittanza)
        {
            Name = name;
            Superficie = superficie;
            Trasmittanza = trasmittanza;
        }
    }
    public static XDocument _xdoc;

    public static XElement TrovaStratigrafiaPerId(string DescrizioneComponenteStratigrafia)
    {
        // Recupera il primo nodo listaStratigrafie nel documento XML _xdoc
        var listaStratigrafie = _xdoc.Descendants("listaStratigrafie").FirstOrDefault();

        if (listaStratigrafie != null)
        {
            // Cerca tra tutti i nodi stratigrafia all'interno di listaStratigrafie
            foreach (var stratigrafia in listaStratigrafie.Elements("stratigrafia"))
            {
                // Recupera l'id dal nodo identificativo all'interno di stratigrafia
                //string id = stratigrafia.Element("identificativo")?.Element("id")?.Value;

                // Modifica introdotta perche ID cambia nelle ditterenti sessioni
                string DescrizioneXML = stratigrafia.Element("identificativo")?.Element("descrizione")?.Value;

                // Confronta l'id estratto con quello passato come parametro
                if (DescrizioneXML.Trim() == DescrizioneComponenteStratigrafia.Trim())
                {
                    return stratigrafia; // Restituisce il nodo stratigrafia corrispondente
                }
            }
        }
        //TermodelLog.LogError($"Stratigrafia {DescrizioneComponenteStratigrafia} non trovata nell' XML di base.");
        return null; // Se non viene trovata corrispondenza, restituisce null
    }
    public static void CompletaSuperficieOpaca(XElement nodoDest, string idComponenteStratigrafia)
    {
        // Trova il nodo stratigrafia con l'id corrispondente

        var stratigrafia = TrovaStratigrafiaPerId(idComponenteStratigrafia);

        if (stratigrafia != null)
        {
            // Copia il campo descrizione nel nodo di destinazione
            var descrizione = stratigrafia.Element("identificativo")?.Element("descrizione")?.Value;
            var conduttanza = stratigrafia.Element("conduttanza")?.Value;

            if (descrizione != null)
            {
                nodoDest.Add(new XElement("descrizione", descrizione));
            }
            else
            {
                Console.WriteLine($"Descrizione non trovata per l'id: {idComponenteStratigrafia}");
            }
        }
        else
        {
            Console.WriteLine($"Stratigrafia non trovata per l'id: {idComponenteStratigrafia}");
        }
    }
    public static double ConvertiDirezioneInAngolo(IfcDirection direzione)
    {
        // Calcola l'angolo in radianti usando la funzione Atan2
        double angoloInRadianti = Math.Atan2(direzione.Y, direzione.X);

        // Converte l'angolo in gradi sessagesimali
        double angoloInGradi = angoloInRadianti * (180.0 / Math.PI);

        // Porta l'angolo nel range [0, 360]
        if (angoloInGradi < 0)
            angoloInGradi += 360;

        // Restituisce l'angolo arrotondato senza decimali
        return (int)Math.Round(angoloInGradi);
    }
    public static string OrientamentoParete(ElementoAssociato parete,double orientamentofalda =double.NaN)
    {
        if (parete.Tipo == TipoElemento.Parete)
        {
            // Calcola l'angolo origine asse x antiorario
            double direzioneparete = ConvertiDirezioneInAngolo(parete.Poligono.Direzione);
            //DirezioneNord origine asse x antiorario
            //angolo origine asse y orario (XML nazionale)
            // angolo += DirezioneNord +270;
            double angolo = -direzioneparete + 90 + DirezioneNord;
            /* Associazione geometrica Direznord=0
            0 >> OVEST 
            90 >>SUD
            180 >>  EST
            270 >> NORD
            Associazione blumatica
            270 >> EST
            180 >> NORD
            90 >> OVEST
            0 >> SUD
            combinata
            0>>90
            90>>0
            180>>270
            270>>180
            */
            //angolo = angolo + DirezioneNord - 180;
            // Riporta l'angolo nel range [0, 360]
            angolo = angolo % 360;  // Modulo per limitare l'angolo entro 360 gradi
            if (angolo < 0) angolo += 360;  // Se l'angolo è negativo, aggiungi 360 per renderlo positivo

            // Normalizza a multipli di 45 gradi
            angolo = Math.Round(angolo / 45) * 45;
            //TermodelLog.WriteLog($"Calcolo orientamento  direzione parete (orientamento vettore linea):{direzioneparete}");
            //TermodelLog.WriteLog($"Esposizione parete(esposizione solare secondo blumatica):{angolo}");
            // Restituisce l'angolo formattato
            return doubleToStr(angolo);

        }

        return "0";
    }

    public static string InclinazioneParete(ElementoAssociato parete, double inclinazionefalda = double.NaN)
    {
        if (!double.IsNaN(inclinazionefalda))
            return Math.Round(inclinazionefalda).ToString(CultureInfo.InvariantCulture);

        if (parete.Tipo == TipoElemento.Parete)
            return "90";

        if (parete.Tipo == TipoElemento.Soffitto)
            return "0";

        if (parete.Tipo == TipoElemento.Pavimento)
            return "180";

        return "0";
    }

    public static string IDNonRiscaldato(ElementoAssociato parete)
    {
        var confine = parete.datiopaca.Confine;
        if (parete.PareteACuiAssociata != null) confine = parete.PareteACuiAssociata.datiopaca.Confine;
        string streturn = "";
        bool errore = true;
        var descnonrisc = utidb.GetDataDB("Codice", confine, "TipoNonClimatizzato", confinicollection);
        if (descnonrisc == null) streturn = $"Confine :{confine}, non trovato in archivio";
        else
        {
            var idnonrisc = utidb.GetDataDB("Descrizione", descnonrisc, "IDXML", nonclimatizzaticollection);
            if (idnonrisc == null) streturn = $"Confine :{confine},tipologia ambiente non riscaldato {descnonrisc} non trovata in archivio";
            else
            {
                errore = false;
                streturn = idnonrisc;
            }
        }
        if (errore) TermodelLog.LogError(streturn);
        return streturn;
    }
    public static bool SuperficieVerticale(ElementoAssociato parete)
    {

        if (parete.Tipo == TipoElemento.Parete) return true;

        return false;
    }
    public static string TrasmittanzaPareteOld(string IdXML)
    {
        var stratigrafia = TrovaStratigrafiaPerId(IdXML);
        if (stratigrafia == null) return "Non trovata";
        return stratigrafia.Element("conduttanza")?.Value ?? "Non trovata";
    }
    public static string TrasmittanzaParete(ElementoAssociato componente)
    {
        double trasmittanzapav = Utigen.CVStrToDouble(utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "Trasmittanza", pareticollection));
        double trasmittanza = 0;
        trasmittanza = trasmittanzapav;
        if (componente.Tipo == TipoElemento.Pavimento)
        {
            var TipoPav = utidb.GetDataDB("Codice", componente.datiopaca.Confine, "Tipo", confinicollection);
            if (TipoPav == "Terreno")
                if (utidb.GetDataDB("Codice", componente.datiopaca.Confine, "TipoNonClimatizzato", confinicollection) == "Controterra")
                {
                    trasmittanza = TrasmittanzaElementoSuTerreno(componente);
                }
        }
        if (trasmittanza == null) return "Non trovata";
        return Utigen.DoubleToStrPuntoDec(trasmittanza, 3);
    }
    public static string DescrizioneParete(string IdXML)
    {
        var stratigrafia = TrovaStratigrafiaPerId(IdXML);
        if (stratigrafia == null) return "Non trovata";
        return stratigrafia.Element("identificativo")?.Element("descrizione")?.Value ?? "Non trovata";
    }
    public static string IDPareteXML(string DescrizioneXML)
    {
        //presente in  DatiOpaca
        //return utidb.GetDataDB("DescBreve", DescBreve, "Codice", pareticollection);
        var stratigrafia = TrovaStratigrafiaPerId(DescrizioneXML);
        if (stratigrafia == null)
        {
            //TermodelLog.LogError($"La parete:{DescrizioneXML}, presente negli archivi , non trova riscontro nell'XML di base.");
            return "Non trovata";
        }
        return stratigrafia.Element("identificativo")?.Element("id")?.Value ?? "Non trovata";
    }
    public static string AngoloToStrDeg(double angolorad)
    {
        // Conversione da radianti a gradi
        double angoloGradi = angolorad * (180.0 / Math.PI);

        // Restituisce il valore in gradi formattato con due cifre decimali e il punto come separatore decimale
        return angoloGradi.ToString("F2", CultureInfo.InvariantCulture);
    }
    public static string doubleToStr(double valore)
    {
        return valore.ToString("F2", CultureInfo.InvariantCulture);
    }
    public static string doubleToStrDecPunto(double valore, int decimali)
    {
        // Usa il parametro 'decimali' per definire la precisione
        return valore.ToString($"F{decimali}", CultureInfo.InvariantCulture);
    }
    private static XElement CreaNodoConValori(string nomeNodo, List<string> valori)
    {
        XElement nodo = new XElement(nomeNodo);


        foreach (var valore in valori)
        {
            nodo.Add(new XElement("valore", valore));
        }
        return nodo;
    }
    public static string EliminaSinoAlDuepunti(string valore)
    {
        if (string.IsNullOrEmpty(valore))
            return valore;

        int index = valore.IndexOf(':');

        if (index >= 0 && index < valore.Length - 1)
            return valore.Substring(index + 1).TrimStart(); // rimuove anche eventuale spazio iniziale

        return valore; // nessun ':' trovato, ritorna la stringa originale
    }

    //--------------------------------------------------------------------------------------------------------------

    //                                        FINESTRE

    //--------------------------------------------------------------------------------------------------------------
    public static string CercaProfiloTelaio(string descrizione)
    {
        if (string.IsNullOrWhiteSpace(descrizione))
        {
            Termodel.utilities.TermodelLog.LogError("Descrizione vuota: impossibile cercare il profilo del telaio.");
            return "0.08";
        }

        // Pattern aggiornato per catturare anche unità scritte per esteso
        var pattern = @"profilo\s*telaio\s*[:=]?\s*(\d+[.,]?\d*)\s*(mm|millimetri|cm|centimetri|m|metri|metro)?";
        var regex = new System.Text.RegularExpressions.Regex(pattern, System.Text.RegularExpressions.RegexOptions.IgnoreCase);
        var match = regex.Match(descrizione);

        if (match.Success)
        {
            var valoreStr = match.Groups[1].Value.Replace(",", ".");
            var unita = match.Groups[2].Success ? match.Groups[2].Value.ToLower().Trim() : "m";

            // Conversione delle unità in metri
            double fattore = unita switch
            {
                "mm" or "millimetri" => 1.0 / 1000,
                "cm" or "centimetri" => 1.0 / 100,
                "m" or "metri" or "metro" => 1.0,
                _ => 1.0 // fallback su metri
            };

            if (double.TryParse(valoreStr, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out double valore))
            {
                valore *= fattore;
                return valore.ToString("0.00", System.Globalization.CultureInfo.InvariantCulture);
            }
        }

        // Fallback con log dettagliato
        Termodel.utilities.TermodelLog.LogError(
            $"Non sono riuscito a trovare il profilo del telaio nella finestra.\n" +
            $"Descrizione: \"{descrizione}\".\n" +
            $"Formato previsto: \"profilo telaio = 6 cm\", \"profilotelaio: 70 mm\", \"profilo telaio 0.06 metri\"."
        );

        return "0.08";
    }


    public static void LoadFinestreCollectionFromXml(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> FinestreCollection)
    {
        if (Cened.LoadFinestreCollectionFromXmlCENED(xmlFilePath, FinestreCollection)) return;
        FinestreCollection.Clear();

        try
        {
            XDocument xdoc = XDocument.Load(xmlFilePath);
            var stratigrafieElements = xdoc.Descendants("vetrata");
            string ultimovalore = "";
            foreach (var element in stratigrafieElements)
            {
                var identificativoElement = element.Element("identificativo");
                if (identificativoElement != null)
                {
                    string codice = (string)identificativoElement.Element("id")?.Value?.Trim() ?? string.Empty;
                    string descrizione = (string)identificativoElement.Element("descrizione")?.Value?.Trim() ?? string.Empty;
                    string descBreve = (string)identificativoElement.Element("descrizione")?.Value?.Trim() ?? string.Empty;
                    // Se codice o descrizione sono entrambi vuoti, salta questo elemento
                    if ((string.IsNullOrEmpty(codice) && string.IsNullOrEmpty(descrizione)) || descrizione == ultimovalore)
                    {
                        continue;
                    }
                    // Calcola lo spessore totale
                    ultimovalore = descrizione;
                    Dictionary<string, object> finestra = new Dictionary<string, object>
                {
                    { "Codice", PulisciCodice(codice)  },
                    { "Descrizione", descrizione },
                    { "DescBreve",EliminaSinoAlDuepunti( descrizione ) },
                    { "Finestrata","Finestra semplice" },
                    { "PontiAutomatici","Finestra" },
                    { "LarghezzaProfiloTelaio", CercaProfiloTelaio(descrizione) }
                   
                    // Non aggiungere colore e spessore
                };

                    FinestreCollection.Add(finestra);
                }
                else
                {
                    Console.WriteLine($"Elemento 'identificativo' mancante in 'vetrata': {element}");
                    // Gestisci il caso in cui 'identificativo' manchi
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Errore durante il caricamento del file XML: {ex.Message}");
            // Gestisci l'eccezione in base alle tue esigenze
        }
    }
    //----------------------------
    public static int Codicefinestra;
    public static string DatiarchivioFinestreString(XDocument xdoc, string id, string NomeNodo, string NomeVariabile)
    {
        var listaVetrate = xdoc.Root.Descendants("listaVetrate").FirstOrDefault();
        if (listaVetrate == null)
        {
            return null; // Nodo 'listaVetrate' non trovato
        }

        var vetrata = listaVetrate.Elements("vetrata")
            .FirstOrDefault(v => (string)v.Element("identificativo")?.Element("id") == id);

        if (vetrata == null)
        {
            return null; // Vetrata con id specificato non trovata
        }

        var nodo = vetrata.Element(NomeNodo);
        if (nodo == null)
        {
            return null; // Nodo con nome specificato non trovato
        }

        var variabile = nodo.Element(NomeVariabile);
        if (variabile == null)
        {
            return null; // Variabile con nome specificato non trovata
        }

        return variabile.Value; // Ritorna il valore della variabile
    }

    public static double DatiarchivioFinestreDouble(XDocument xdoc, string id, string NomeNodo, string NomeVariabile)
    {
        // Ottieni il valore come stringa utilizzando la funzione DatiarchivioFinestreString
        string valoreStringa = DatiarchivioFinestreString(xdoc, id, NomeNodo, NomeVariabile);

        // Se il valore è null, restituisce NaN
        if (valoreStringa == null)
        {
            return double.NaN;
        }

        // Converte la stringa in double usando InvariantCulture per garantire il punto come separatore decimale
        return Convert.ToDouble(valoreStringa, CultureInfo.InvariantCulture);
    }
    //-------------------------------------------
    public static void AggiungiFinestrainarchivio(XDocument doc, string id)
    {
        // Trova il primo elemento 'listaVetrate' nell'albero XML
        var listaVetrate = doc.Root.Descendants("listaVetrate").FirstOrDefault();
        if (listaVetrate == null)
        {
            throw new Exception("Errore: Nodo 'listaVetrate' non trovato nel documento XML di destinazione.");
        }

        // Trova l'elemento 'vetrata' nel documento di origine con l'ID specificato
        var vetrataDaCopiare = _xdoc.Root
            .Descendants("listaVetrate")
            .Elements("vetrata")
            .FirstOrDefault(v => (string)v.Element("identificativo")?.Element("id") == id);

        if (vetrataDaCopiare == null)
        {
            throw new Exception($"Errore: Vetrata con id {id} non trovata nel documento XML di origine.");
        }

        // Aggiunge una copia della vetrata trovata a 'listaVetrate'
        listaVetrate.Add(new XElement(vetrataDaCopiare));
    }

    //-------------------------------------------
    public static void ScriviDatoFinestrainarchivio(XDocument doc, string id, string nodo, string variabile, string valore)
    {
        var vetrata = doc.Root.Element("listaVetrate")?
            .Elements("vetrata")
            .FirstOrDefault(v => (string)v.Element("identificativo")?.Element("id") == id);

        if (vetrata == null)
        {
            throw new Exception($"Errore: Vetrata con id {id} non trovata nel documento XML.");
        }

        var nodoElemento = vetrata.Element(nodo);
        if (nodoElemento == null)
        {
            throw new Exception($"Errore: Nodo {nodo} non trovato nella vetrata con id {id}.");
        }

        var variabileElemento = nodoElemento.Element(variabile);
        if (variabileElemento == null)
        {
            variabileElemento = new XElement(variabile, valore);
            nodoElemento.Add(variabileElemento);
        }
        else
        {
            variabileElemento.Value = valore;
        }
    }


    //-------------------------------------------
    // Lista parallela per tenere traccia dei tipi di finestre
    public static List<TDatiFinestra> listaFinestre = new List<TDatiFinestra>();
    public static XElement TrovaFinestraDaCopiare(XDocument XMLOriginale, string ID)
    {
        // Verifica se il nodo radice è presente
        var root = XMLOriginale.Root;
        if (root == null)
        {
            Console.WriteLine("Errore: Nodo radice mancante in XMLOriginale.");
            return null;
        }

        // Verifica se il nodo 'listaVetrate' è presente
        var listaVetrate = root.Descendants("listaVetrate");
        if (listaVetrate == null)
        {
            Console.WriteLine("Errore: Nodo 'listaVetrate' non trovato sotto il nodo radice.");
            return null;
        }

        // Itera su ogni elemento 'vetrata' per verificare se l'ID corrisponde
        foreach (var vetrata in listaVetrate.Elements("vetrata"))
        {
            var identificativo = vetrata.Element("identificativo");
            if (identificativo == null)
            {
                Console.WriteLine("Errore: Nodo 'identificativo' mancante in un elemento 'vetrata'.");
                continue;
            }

            var idElemento = identificativo.Element("id");
            if (idElemento == null)
            {
                Console.WriteLine("Errore: Nodo 'id' mancante sotto 'identificativo'.");
                continue;
            }

            string idValue = idElemento.Value;
            Console.WriteLine($"Verifica ID: trovato '{idValue}', confrontato con '{ID}'.");

            // Confronta l'ID trovato con quello richiesto
            if (idValue == ID)
            {
                Console.WriteLine("Finestra trovata.");
                return vetrata;
            }
        }

        // Se non trova alcuna finestra con l'ID specificato
        Console.WriteLine($"Errore: Nessuna finestra con ID '{ID}' trovata.");
        return null;
    }

    // Funzione realizzata da Codex in autonomia
    private static XElement CreaVetrataDaArchivioProgetto(string tipoFinestra, string nuovoID)
    {
        var rigaArchivio = finestrecollection.FirstOrDefault(riga =>
            riga.TryGetValue("DescBreve", out object valore) &&
            string.Equals(valore?.ToString()?.Trim(), tipoFinestra?.Trim(), StringComparison.OrdinalIgnoreCase));
        if (rigaArchivio == null)
        {
            return null;
        }

        double LeggiValore(string campo)
        {
            if (!rigaArchivio.TryGetValue(campo, out object valore))
            {
                return double.NaN;
            }

            return Utigen.CVStrToDouble(valore?.ToString());
        }

        double trasmittanzaTelaio = LeggiValore("TrasmittanzaTelaio");
        double trasmittanzaVetro = LeggiValore("TrasmittanzaVetro");
        double trasmittanzaDistanziatore = LeggiValore("TrasmittanzaDistanziatore");
        if (double.IsNaN(trasmittanzaTelaio) || double.IsNaN(trasmittanzaVetro))
        {
            return null;
        }

        if (double.IsNaN(trasmittanzaDistanziatore))
        {
            trasmittanzaDistanziatore = 0;
        }

        string descrizione = rigaArchivio.TryGetValue("Descrizione", out object valoreDescrizione)
            ? valoreDescrizione?.ToString()
            : tipoFinestra;

        return new XElement("vetrata",
            new XElement("identificativo",
                new XElement("id", nuovoID),
                new XElement("descrizione", descrizione)),
            new XElement("vetro",
                new XElement("descrizione", tipoFinestra),
                new XElement("tipoVetro", "0"),
                new XElement("trasmittanzaDistanziatore", doubleToStrDecPunto(trasmittanzaDistanziatore, 3)),
                new XElement("trasmittanzaVetro", doubleToStrDecPunto(trasmittanzaVetro, 3))),
            new XElement("telaio",
                new XElement("descrizione", tipoFinestra),
                new XElement("tipoTelaio", "0"),
                new XElement("trasmittanza", doubleToStrDecPunto(trasmittanzaTelaio, 3))));
    }


    public static XElement AggiungiFinestra(ElementoAssociato componente, XDocument XMLOriginale, XDocument XMLProdotto)
    {
        // Estrae le proprietà necessarie dal componente
        var Larghezza = componente.datiopaca.Larghezza;
        var Altezza = componente.datiopaca.Altezza;
        var NumeroAnte = componente.datiopaca.NumeroAnte;
        var DescrizioneXML = utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "Descrizione", finestrecollection);
        var ID = componente.datiopaca.Id;
        var Tipo = componente.datiopaca.Codice;

        // Cerca nella lista se esiste già una finestra con le stesse caratteristiche
        var finestraEsistente = listaFinestre.FirstOrDefault(f =>
            f.Larghezza == Larghezza &&
            f.Altezza == Altezza &&
            f.Tipo == Tipo &&
            f.NumeroAnte == NumeroAnte
        );

        // Se la finestra esiste già, usa l'ID esistente e crea il nodo XML
        if (finestraEsistente != null)
        {
            Console.WriteLine($"Finestra esistente trovata: ID = {finestraEsistente.Id}");
            return XMLFinestra(componente, XMLProdotto, finestraEsistente.Id);
        }

        // Genera un nuovo ID per la nuova finestra
        string nuovoID = "FN" + (listaFinestre.Count + 1).ToString("D4");

        // Crea un nuovo oggetto TDatiFinestra
        TDatiFinestra nuovaFinestra = new TDatiFinestra
        {
            Id = nuovoID,
            Descrizione = $"Finestra tipo {Tipo},{Larghezza} x {Altezza} - {NumeroAnte} ante",
            Tipo = Tipo,
            NumeroAnte = NumeroAnte,
            Altezza = Altezza,
            Larghezza = Larghezza,
            Sottofinestra = 0 // Imposta il valore di default, se necessario può essere modificato
        };

        // Aggiunge la nuova finestra alla lista
        listaFinestre.Add(nuovaFinestra);

        // Trova la finestra da duplicare nell'XML originale
        XElement finestraDaCopiare = null;
        if (DescrizioneXML != null)
            finestraDaCopiare = XMLOriginale.Root
        .Descendants("listaVetrate")
        .FirstOrDefault()?
        .Elements("vetrata")
        .FirstOrDefault(v => ((string)v.Element("identificativo")?.Element("descrizione"))?.Trim() == DescrizioneXML.Trim());


        //var finestraDaCopiare = TrovaFinestraDaCopiare(XMLOriginale, ID);
        if (finestraDaCopiare != null)
        {
            // Duplica la finestra esistente con il nuovo ID
            XElement nuovaVetrata = new XElement(finestraDaCopiare);
            nuovaVetrata.Element("identificativo")?.SetElementValue("id", nuovoID);

            // Trova l'elemento 'listaVetrate' nel documento di destinazione
            var listaVetrate = XMLProdotto.Root.Descendants("listaVetrate").FirstOrDefault();

            if (listaVetrate == null)
            {
                throw new Exception("Errore: Nodo 'listaVetrate' non trovato nel documento XML di destinazione.");
            }

            // Aggiunge la finestra duplicata a 'listaVetrate'
            listaVetrate.Add(nuovaVetrata);


            Console.WriteLine($"Nuova finestra creata: ID = {nuovoID}");
            // Crea e restituisce il nodo XML completo per la nuova finestra
            return XMLFinestra(componente, XMLProdotto, nuovoID);
        }
        else
        {
            // Modificato da Codex per realizzare: usare i dati completi del nuovo archivio Finestre quando manca la voce nell'XML APE storico.
            XElement nuovaVetrata = CreaVetrataDaArchivioProgetto(Tipo, nuovoID);
            var listaVetrate = XMLProdotto.Root.Descendants("listaVetrate").FirstOrDefault();
            if (nuovaVetrata == null || listaVetrate == null)
            {
                TermodelLog.LogError($"Finestra {DescrizioneXML}- non trovata nell'XML di base e dati archivio insufficienti.");
                return null;
            }

            listaVetrate.Add(nuovaVetrata);
            TermodelLog.WriteLog($"Finestra {Tipo} costruita dai dati dell'archivio progetto con ID {nuovoID}.");
            return XMLFinestra(componente, XMLProdotto, nuovoID);
            //throw new Exception($"Errore: Finestra con id {ID} non trovata nell'XML originale.");
        }
    }


    public static XElement XMLFinestra(ElementoAssociato componente, XDocument XMLProdotto, string ID)
    {
        double trasmittanzaVetro = DatiarchivioFinestreDouble(XMLProdotto, ID, "vetro", "trasmittanzaVetro");
        double trasmittanzaDistanziatore = DatiarchivioFinestreDouble(XMLProdotto, ID, "vetro", "trasmittanzaDistanziatore");
        double trasmittanzaTelaio = DatiarchivioFinestreDouble(XMLProdotto, ID, "telaio", "trasmittanza");
        if (double.IsNaN(trasmittanzaDistanziatore)) trasmittanzaDistanziatore = 0;
        // Controlla se uno dei valori è NaN
        if (double.IsNaN(trasmittanzaVetro) || double.IsNaN(trasmittanzaTelaio))
        {
            TermodelLog.LogError($"Dati sulla finestra id={ID} non trovati in archivio ( XML ).");
            return null;
        }

        Codicefinestra += 1;
        double superficieDisperdente = componente.datiopaca.Larghezza * componente.datiopaca.Altezza;
        int NumeroAnte = componente.datiopaca.NumeroAnte;
        double SpessoreTelaio = Convert.ToDouble(utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "LarghezzaProfiloTelaio", finestrecollection), CultureInfo.InvariantCulture);

        // Calcolo del sopraluce
        double altezzaInternaSopraluce = componente.datiopaca.Sopraluce - (2 * SpessoreTelaio);
        double larghezzaInternaSopraluce = componente.datiopaca.Larghezza - (2 * SpessoreTelaio);
        double areaVetroSopraluce = larghezzaInternaSopraluce * altezzaInternaSopraluce;
        double perimetroVetroSopraluce = 2 * larghezzaInternaSopraluce + altezzaInternaSopraluce * 2;
        double areaTelaioSopraluce = componente.datiopaca.Sopraluce * componente.datiopaca.Larghezza - areaVetroSopraluce;

        // Calcolo dell'infisso principale
        double larghezzaInterna = componente.datiopaca.Larghezza - (2 * SpessoreTelaio * NumeroAnte);
        double altezzaInterna = componente.datiopaca.Altezza - componente.datiopaca.Sopraluce - (2 * SpessoreTelaio);

        // Area totale del vetro
        double areaVetro = larghezzaInterna * altezzaInterna + areaVetroSopraluce;

        // Perimetro del vetro
        double perimetroVetro = 2 * larghezzaInterna + altezzaInterna * NumeroAnte * 2 + perimetroVetroSopraluce;

        // Area totale del telaio
        double areaTelaio = superficieDisperdente - areaVetro + areaTelaioSopraluce;

        //Calcolo totali

        // Trasmittanza dell'infisso (combinazione di vetro, telaio e distanziatore)
        double trasmittanzaInfisso = (trasmittanzaVetro * areaVetro + trasmittanzaTelaio * areaTelaio) / superficieDisperdente;
        double trasmittanzaInfissoCorretta = (trasmittanzaVetro * areaVetro + trasmittanzaTelaio * areaTelaio + trasmittanzaDistanziatore * perimetroVetro) / superficieDisperdente;
        //componente.PareteACuiAssociata.datiopaca.SuperficieADetrarre += superficieDisperdente;
        string testoAnte = NumeroAnte == 1 ? $"{NumeroAnte} anta" : $"{NumeroAnte} ante";
        if (componente.datiopaca.Sopraluce > 0) testoAnte += " con sopraluce";
        string descrizione = $"{utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "DescBreve", finestrecollection)} " +
            $" {doubleToStrDecPunto(componente.datiopaca.Larghezza, 2)} X {doubleToStrDecPunto(componente.datiopaca.Altezza, 2)} {testoAnte}";
        // Creiamo il nodo XML con la struttura indicata
        componente.Censito = true;
        //_mainWindow.report.NuovoParagrafo();
        superficieInfissiTotale += superficieDisperdente;
        trasmittanzaTotaleInfissi += trasmittanzaInfissoCorretta * superficieDisperdente;
        _mainWindow.report.AggiungiTestoFormattato("---", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3);
        _mainWindow.report.AggiungiTestoConValoreStringaPar("Finestra:", descrizione, Numcap: 3);
        _mainWindow.report.AggiungiTestoConValorePar("superficie:", superficieDisperdente, "m²", "Blue", "Red", 14, Numcap: 3);
        _mainWindow.report.AggiungiTestoConValorePar("trasmittanza:", trasmittanzaInfissoCorretta, "W/m²K", "Blue", "Red", 14, Numcap: 3);
        TermodelLog.WriteLog("Elaborazione finestra:" + descrizione);
        //_mainWindow.report.StampaParagrafo(Numcap: 3);
        XElement finestra = new XElement("superficieVetrata",
            //new XElement("descrizione", DatiarchivioFinestreString(XMLProdotto, ID, "identificativo", "descrizione") ?? "Descrizione non trovata"),
            new XElement("descrizione", descrizione),
            new XElement("superficieDisperdente", doubleToStrDecPunto(superficieDisperdente, 2)),
            new XElement("areaVetro", doubleToStrDecPunto(areaVetro, 2)),
            new XElement("perimetroVetro", doubleToStrDecPunto(perimetroVetro, 2)),
            new XElement("areaTelaio", doubleToStrDecPunto(areaTelaio, 2)),
            new XElement("trasmittanzaInfisso", doubleToStrDecPunto(trasmittanzaInfisso, 4)),
            new XElement("trasmittanzaInfissoCorretta", doubleToStrDecPunto(trasmittanzaInfissoCorretta, 4)),
            new XElement("fonteTrasmittanzaInfisso", "1"),
            new XElement("idComponenteVetrata", ID),
            new XElement("deltaR", "0"),
            new XElement("esposizione", OrientamentoParete(componente.PareteACuiAssociata)),
            new XElement("inclinazione", InclinazioneParete(componente.PareteACuiAssociata)),

            // FattoreOmbreggiatura
            CreaNodoConValori("fattoreOmbreggiatura", new List<string> { "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1" }),

            // FattoreOmbreggiaturaDiffusa
            new XElement("fattoreOmbreggiaturaDiffusa", "0.75"),

            // SchermatureMobili
            CreaNodoConValori("schermatureMobili", new List<string> { "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1", "1" }),

            // ExtraFlusso
            CreaNodoConValori("extraFlusso", new List<string> { "6.3483", "6.1526", "5.5538", "7.4137", "8.5487", "9.4800", "10.7454", "9.8314", "6.7594", "7.3481", "4.8621", "5.3366" }),

            // ApportiSolari
            CreaNodoConValori("apportiSolari", new List<string> { "3.8930", "5.3994", "7.0293", "9.3478", "12.0015", "12.7771", "12.5452", "11.7039", "8.2519", "6.4759", "4.9427", "3.5361" })
        );

        return finestra;
    }

    //--------------------------------------------------------------------------------------------------------------

    //                                        Ponti termici

    //--------------------------------------------------------------------------------------------------------------
    public static void LoadPontiCollectionFromXml_file(System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> PontiCollection)
    {
        // Crea il file dialog per selezionare un file .xmk
        Microsoft.Win32.OpenFileDialog openFileDialog = new Microsoft.Win32.OpenFileDialog
        {
            Filter = "File Ponti (*.xml)|*.xml",
            Title = "Seleziona il file da cui desideri importare i ponti termici ."
        };

        // Mostra il dialogo e verifica se l'utente ha selezionato un file
        bool? result = openFileDialog.ShowDialog();

        if (result == true)
        {
            string xmlFilePath = openFileDialog.FileName;

            // ⚠️ Pulisce prima la collection
            PontiCollection.Clear();

            // Carica i dati dal file selezionato
            LoadPontiCollectionFromXml(xmlFilePath, PontiCollection);
        }
        else
        {
            Console.WriteLine("Caricamento annullato dall'utente.");
        }
    }

    public static void LoadPontiCollectionFromXml(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> PontiCollection)
    {
        if (Cened.LoadPontiCollectionFromXmlCENED(xmlFilePath, PontiCollection)) return;
   
        PontiCollection.Clear();

        try
        {
            XDocument xdoc = XDocument.Load(xmlFilePath);
            var ponteTermicoElements = xdoc.Descendants("PonteTermico");

            foreach (var element in ponteTermicoElements)
            {
                var descrizioneElement = element.Element("descrizione");
                var trasmittanzaLineareElement = element.Element("trasmittanzaLineare");
                var CategoriaElement = element.Element("categoria");

                if (descrizioneElement != null && trasmittanzaLineareElement != null)
                {
                    string descrizione = descrizioneElement.Value?.Trim() ?? string.Empty;
                    string descBreve = descrizione; // Presumibilmente la descrizione breve è la stessa della descrizione completa
                    string trasmittanzaLineare = trasmittanzaLineareElement.Value?.Trim() ?? string.Empty;
                    string categoria = CategoriaElement.Value?.Trim() ?? string.Empty;

                    // Verifica se esiste già un elemento con la stessa descrizione nella collezione
                    bool esisteGia = PontiCollection.Any(p => p.ContainsKey("Descrizione") && (string)p["Descrizione"] == descrizione);

                    if (!esisteGia)
                    {
                        Dictionary<string, object> ponte = new Dictionary<string, object>
                    {
                        { "Descrizione", descrizione },
                        { "DescBreve",PulisciCodice( descBreve) },
                        { "TrasmLin", trasmittanzaLineare },
                        { "Categoria", categoria }
                    };

                        PontiCollection.Add(ponte);
                    }
                }
                else
                {
                    Console.WriteLine($"Elemento 'descrizione' o 'tramittanzaLineare' mancante in 'PonteTermico': {element}");
                    // Gestisci il caso in cui 'descrizione' o 'tramittanzaLineare' manchino
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Errore durante il caricamento del file XML: {ex.Message}");
            // Gestisci l'eccezione in base alle tue esigenze
        }
    }
    //---------------------------
    public static XElement TrovaPontePerId(string IDPonte)
    {
        // Recupera il nodo fabbricato nel documento XML _xdoc
        var fabbricato = _xdoc.Descendants("fabbricato").FirstOrDefault();

        if (fabbricato != null)
        {
            // Cerca tra tutti i nodi PonteTermico all'interno di fabbricato
            foreach (var ponteTermico in fabbricato.Descendants("PonteTermico"))
            {
                // Recupera la descrizione dal nodo PonteTermico
                string descrizione = ponteTermico.Element("descrizione")?.Value;

                // Confronta la descrizione estratta con quella passata come parametro
                if (descrizione == IDPonte)
                {
                    return ponteTermico; // Restituisce il nodo PonteTermico corrispondente
                }
            }
        }
        TermodelLog.LogError($"Ponte termico con descrizione '{IDPonte}' non trovato nell'XML importato.");
        return null; // Se non viene trovata corrispondenza, restituisce null
    }

    //---------------------------
    public static XElement AggiungiPonte(ElementoAssociato componente)
    {
        // Definizione dei dati del ponte termico, che possono essere estratti dal componente
        string descrizione = utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "Descrizione", ponticollection);
        string trasmittanzaLineare = utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "TrasmLin", ponticollection);
        string categoria = utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "Categoria", ponticollection);
        if (string.IsNullOrWhiteSpace(categoria))
            categoria = "1";
        /*
        var nodoponte = TrovaPontePerId(descrizione);
        if (nodoponte == null)
        {
            if (descrizione ==null) TermodelLog.LogError($"Dati del ponte {componente.datiopaca.Codice} non trovati in archivio");
            TermodelLog.LogError($"Dati del ponte {descrizione} non trovati nell'XML importato");
            return null;
        }
        string categoria = nodoponte.Element("categoria")?.Value;
        string trasmittanzaLineare = nodoponte.Element("trasmittanzaLineare")?.Value;
        */
        double lunghezza = componente.datiopaca.Larghezza;
        componente.Censito = true;
        //_mainWindow.report.NuovoParagrafo();
        _mainWindow.report.AggiungiTestoFormattato("---", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3);
        _mainWindow.report.AggiungiTestoConValoreStringaPar("Ponte termico:", descrizione, Numcap: 3);
        _mainWindow.report.AggiungiTestoConValorePar("lunghezza:", lunghezza, "m", "Blue", "Red", 14, Numcap: 3);
        _mainWindow.report.AggiungiTestoConValorePar("trasmittanza lineare :", Utigen.CVStrToDouble(trasmittanzaLineare), "W/mK", "Blue", "Red", 14, Numcap: 3);
        _mainWindow.report.AggiungiTestoConValoreStringaPar("Categoria:", categoria, Numcap: 3);
        //_mainWindow.report.StampaParagrafo(Numcap: 3);
        // Creazione del nodo XML PonteTermico
        XElement ponteTermico = new XElement("PonteTermico",
            new XElement("descrizione", descrizione),
            new XElement("categoria", categoria),
            new XElement("trasmittanzaLineare", trasmittanzaLineare),
            new XElement("lunghezza", lunghezza.ToString("F2", CultureInfo.InvariantCulture))
        );

        return ponteTermico;
    }
    
    //--------------------------------------------------------------------------------------------------------------

    //                                        Superfici Opache

    //--------------------------------------------------------------------------------------------------------------
    public static double CalcolaSpessore(XElement stratigrafiaElement)
    {
        double spessoreTotale = 0.0;

        var listStratiElement = stratigrafiaElement.Element("listaStrati");
        if (listStratiElement != null)
        {
            var stratiElements = listStratiElement.Elements("strato");
            foreach (var strato in stratiElements)
            {
                double spessore = 0.0;
                if (double.TryParse(strato.Element("spessore")?.Value, out spessore))
                {
                    spessoreTotale += spessore;
                }
            }
        }

        return spessoreTotale;
    }
    public static double CalcolaTrasm(XElement stratigrafiaElement)
    {
        double resistenzaTermicaTotale = 0.0;

        // Trova il nodo "listaStrati"
        var listStratiElement = stratigrafiaElement.Element("listaStrati");
        if (listStratiElement != null)
        {
            // Itera su ogni nodo "strato"
            var stratiElements = listStratiElement.Elements("strato");
            foreach (var strato in stratiElements)
            {
                double spessore = 0.0;
                double conduttivitaTermica = 0.0;

                // Prova a leggere lo spessore e la conduttività termica
                if (double.TryParse(strato.Element("spessore")?.Value, out spessore) &&
                    double.TryParse(strato.Element("conduttivitaTermica")?.Value, out conduttivitaTermica) &&
                    conduttivitaTermica > 0) // Evita la divisione per zero
                {
                    // Calcola la resistenza termica dello strato e aggiungila alla resistenza totale
                    resistenzaTermicaTotale += spessore / conduttivitaTermica;
                }
            }
        }

        // Calcola la trasmittanza come l'inverso della resistenza termica totale
        // Se la resistenza termica totale è zero, la trasmittanza sarà infinita (gestito con un fallback a 0)
        return resistenzaTermicaTotale > 0 ? 1.0 / resistenzaTermicaTotale : 0.0;
    }
    //---------------------------------------  TrasmittanzaTerreno Pagina 51 manuale Blumatica
    /// <summary>
    /// Calcola la trasmittanza termica del pavimento contro terra.
    /// </summary>
    /// <param name="superficie">Superficie del pavimento (m²).</param>
    /// <param name="perimetro">Perimetro del pavimento (m).</param>
    /// <param name="spessoreIsolante">Spessore dell'isolante sotto il pavimento (m).</param>
    /// <param name="lambdaIsolante">Conducibilità termica dell'isolante (W/mK).</param>
    /// <param name="lambdaTerreno">Conducibilità termica del terreno (W/mK).</param>
    /// <returns>La trasmittanza termica U (W/m²K).</returns>
    public static double TrasmittanzaTerreno(
      double superficie,         // Superficie del pavimento in m^2
      double perimetro,          // Perimetro geometrico del pavimento in m
      double spessoreIsolante,   // Spessore dell'isolante in m
      double lambdaIsolante,     // Conducibilità termica dell'isolante in W/mK
      double lambdaTerreno,      // Conducibilità termica del terreno in W/mK
      double thetaInt,           // Temperatura interna di progetto (°C)
      double thetaMe,            // Temperatura media esterna annuale (°C)
      double thetaE              // Temperatura esterna di progetto (°C)
  )
    {
        // Calcolo della resistenza termica dell'isolante (Rp)
        double Rp = spessoreIsolante / lambdaIsolante;

        // Calcolo della resistenza termica del terreno (Rt)
        double Rt = 1 / (2 * Math.PI * lambdaTerreno) * Math.Log(superficie / perimetro);

        // Resistenza superficiale interna (Rsi)
        double Rsi = 0.17;

        // Calcolo della resistenza termica totale (Rtot)
        double Rtot = Rsi + Rp + Rt;

        // Calcolo della trasmittanza termica equivalente (Uequiv)
        double Uequiv = 1 / Rtot;

        // Calcolo dei fattori di correzione f_g1 e f_g2
        double fg1 = 1.45; // Fattore predefinito per la variazione annuale della temperatura
        double fg2 = (thetaInt - thetaMe) / (thetaInt - thetaE); // Fattore di riduzione della temperatura

        // Calcolo della trasmittanza finale del terreno
        double TrasmittanzaTerreno = fg1 * fg2 * Uequiv;

        return TrasmittanzaTerreno;
    }


    public static double LambdaTerreno(string tipoTerreno)
    {
        switch (tipoTerreno.ToLower())
        {
            case "argilla o limo":
                return 1.5; // Indicativo: conducibilità termica per argilla o limo in W/mK
            case "sabbia o ghiaia":
                return 2.0; // Indicativo: conducibilità termica per sabbia o ghiaia in W/mK
            case "roccia":
                return 3.5; // Indicativo: conducibilità termica per roccia in W/mK
            default:
                throw new ArgumentException("Tipo di terreno non riconosciuto. Usare: 'Argilla o limo', 'Sabbia o ghiaia', 'Roccia'.");
        }
    }
    public static double TrasmittanzaElementoSuTerreno(ElementoAssociato componente)
    {

        double superficie = UtiBimNTS.AreaPolyIFC(componente.Poligono.Poligono, SuperficieVerticale(componente));
        double perimetro= UtiBimNTS.PerimetroPolyIFC(componente.Poligono.Poligono, SuperficieVerticale(componente));
        double spessoreIsolante= Utigen.CVStrToDouble(utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "Spessore", pareticollection))/100; 
        double lambdaIsolante= Utigen.CVStrToDouble(utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "Trasmittanza", pareticollection)); 
        double lambdaTerreno= LambdaTerreno(utidb.GetDataDB("Codice", componente.datiopaca.Confine, "TipoTerreno", confinicollection));
        double thetaInt = 20.0;            // Temperatura interna di progetto (°C)
        double thetaMe = 17.0;             // Temperatura media esterna annuale (°C) per Reggio Calabria
        double thetaE = 5.0;               // Temperatura esterna di progetto (°C) per Reggio Calabria
                                           // Chiamata alla funzione
        var trasmter = TrasmittanzaTerreno(
            superficie,
            perimetro,
            spessoreIsolante,
            lambdaIsolante,
            lambdaTerreno,
            thetaInt,
            thetaMe,
            thetaE
        );
        return trasmter;
    }
    //--------------------------------------- 
    public static string ColoreDaIndice(int indice)
    {
        return indice switch
        {
            1 => "1 - Rosso",
            2 => "2 - Giallo",
            3 => "3 - Verde",
            4 => "4 - Ciano",
            5 => "5 - Blu",
            6 => "6 - Magenta",
            7 => "7 - Bianco/Nero",
            8 => "8 - Grigio",
            9 => "9 - Grigio Scuro",
            _ => $"{indice} - Colore sconosciuto"
        };
    }
    public static string PulisciCodice(string input)
    {
        if (string.IsNullOrWhiteSpace(input))
            return string.Empty;

        // 1. Rimuove spazi iniziali e finali
        string cleaned = input.Trim();

        // 2. Rimuove caratteri di controllo ASCII (tab, newline, etc.)
        cleaned = new string(cleaned
            .Where(c => !char.IsControl(c) || c == '\n' || c == '\r')  // opzionalmente puoi rimuovere anche '\n' e '\r'
            .ToArray());

        // 3. Sostituisci virgolette tipografiche o simboli speciali
        cleaned = cleaned.Replace("“", "\"")
                         .Replace("”", "\"")
                         .Replace("‘", "'")
                         .Replace("’", "'");

        // 4. (Facoltativo) Elimina caratteri non ASCII (come BOM, caratteri invisibili Unicode)
        cleaned = new string(cleaned.Where(c => c <= 127).ToArray());

        // 5. Rimuove spazi multipli interni (opzionale)
        cleaned = System.Text.RegularExpressions.Regex.Replace(cleaned, @"\s+", " ");

        cleaned = cleaned.Replace(",", ".");
        return cleaned;
    }


    public static void LoadParetiCollectionFromXml(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> paretiCollection)
    {
        if (Cened.LoadParetiCollectionFromXmlCENED(xmlFilePath, paretiCollection)) return;
        paretiCollection.Clear();
        
        try
        {
            XMLConverter.SaveAsJson(xmlFilePath);
            XDocument xdoc = XDocument.Load(xmlFilePath);
            var stratigrafieElements = xdoc.Descendants("stratigrafia");
            int index = 0;
            string Ultimovalore = "";
            foreach (var element in stratigrafieElements)
            {
                
                var identificativoElement = element.Element("identificativo");
                if (identificativoElement != null)
                {
                    string codice = (string)identificativoElement.Element("id")?.Value?.Trim() ?? string.Empty;
                    string descrizione = (string)identificativoElement.Element("descrizione")?.Value?.Trim() ?? string.Empty;

                    // Se codice o descrizione sono entrambi vuoti, salta questo elemento
                    if (string.IsNullOrEmpty(codice) && string.IsNullOrEmpty(descrizione)|| Ultimovalore== descrizione)
                    {
                        continue;
                    }
                    index++;
                    Ultimovalore = descrizione;
                    // Calcola lo spessore totale
                    double spessoreTotale = CalcolaSpessore(element); 
                    double Trasmittanza = CalcolaTrasm(element);
                    Dictionary<string, object> parete = new Dictionary<string, object>
                {
                    { "Codice", codice },
                    { "DescBreve",PulisciCodice( EliminaSinoAlDuepunti(descrizione)) },
                    { "Colore", ColoreDaIndice(index) },
                    { "Descrizione", descrizione },
                    { "Spessore", Utigen.DoubleToStrPuntoDec(spessoreTotale,3) },
                    { "Trasmittanza", Utigen.DoubleToStrPuntoDec(Trasmittanza,3) },
                    { "PontiAutomatici", "Parete"}
                    // Non aggiungere colore e spessore
                };

                    paretiCollection.Add(parete);
                }
                else
                {
                    Console.WriteLine($"Elemento 'identificativo' mancante in 'stratigrafia': {element}");
                    // Gestisci il caso in cui 'identificativo' manchi
                }
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Errore durante il caricamento del file XML: {ex.Message}");
            // Gestisci l'eccezione in base alle tue esigenze
        }
    }
    //----------------------
    public static void AggiungiSuperficiAlLocale(XDocument doc, XElement localeNode,
                                            List<ElementoAssociato> confiniEsterni,
                                            List<ElementoAssociato> confiniAmbienteNonClimatizzato,
                                            List<ElementoAssociato> confiniAmbienteClimatizzato,
                                            List<ElementoAssociato> confiniTerreno,
                                            List<ElementoAssociato> confiniInterni,
        ref double superficie, ref double superficiedisperdente, ref double volume ,ref double altezzamedia )
    {
        double suppav = 0;
        double supdisp = 0;
        // Funzione per aggiungere le superfici da una lista
        void AggiungiSuperficieOpaca(XElement localeNode, List<ElementoAssociato> superficieLista, string tipoConfine)
        {
         
           XElement ConfineNode = new XElement($"confine{tipoConfine}");
            
           TermodelLog.LogOperation($"Elementi con {tipoConfine}");
            /*
            if (tipoConfine == "Esterno")
                foreach (var componente in superficieLista)
                {
                    
                    if (componente.Tipo == TipoElemento.Finestra)
                    {
                        XElement FinestraXml = AggiungiFinestra(componente, _xdoc, doc);
                        if (FinestraXml == null) continue;
                        ConfineNode.Add(FinestraXml);
                    }
                        if (componente.Tipo == TipoElemento.Ponte)
                    {
                        var ponte = AggiungiPonte(componente);
                        if (ponte != null) ConfineNode.Add(ponte);
                    }
                }
            */
            UtiBimNTS.VolumePerFalda.Clear();

            //Raccolta dei triangoli delle falde in un'unico report per falda
            Dictionary<string, ElementoAssociato> FaldaToComponente = new();

            foreach (var componente in superficieLista)
            {
                CalcolaOpaca(componente);
            }
            foreach (var kvp in UtiBimNTS.VolumePerFalda)
            {
                string nomeFalda = kvp.Key;
                var dati = kvp.Value;

                if (FaldaToComponente.TryGetValue(nomeFalda, out var componente))
                {
                    double orientamentoFalda = dati.Azimut;
                    double inclinazioneFalda = dati.Zenit;
                    double hMediaFalda = dati.HMedia;
                    double superficie3D = dati.SuperficieEffettiva;

                    CalcolaOpaca(componente, calcolofalde: true,
                                 OrientamentoFalda: orientamentoFalda,
                                 InclinazioneFalda: inclinazioneFalda,
                                 HmediaFalda: hMediaFalda,
                                 Superficie3D: superficie3D);
                }
                else
                {
                    TermodelLog.LogError($"Falda '{nomeFalda}' non ha un componente associato.");
                }

            }

            void CalcolaOpaca(ElementoAssociato  componente, bool calcolofalde=false,double OrientamentoFalda = double.NaN, double InclinazioneFalda = double.NaN, double HmediaFalda = double.NaN, double Superficie3D = double.NaN)
            {
                if ((componente.Tipo == TipoElemento.Mansardato) && !calcolofalde)
                {
                    string nomeFalda = componente.Poligono.ElementIdentifier;
                    UtiBimNTS.CalcolaVolume(componente.Poligono.Poligono, nomeFalda);

                    // Aggiungi al dizionario se non già presente
                    if (!FaldaToComponente.ContainsKey(nomeFalda))
                        FaldaToComponente[nomeFalda] = componente;

                    return;
                }
                if (componente.Tipo == TipoElemento.Ponte || componente.Tipo == TipoElemento.Finestra) return;
                var DescrizionePareteXML = utidb.GetDataDB("DescBreve", componente.datiopaca.Codice, "Descrizione", pareticollection);
                var IDXML = IDPareteXML(DescrizionePareteXML);
                if ( IDXML == null )
                    {
                    TermodelLog.LogError($"La superficie {componente.datiopaca.Codice}, di tipo {componente.Tipo} non è stata trovata nell' XML di base");
                    return; 
                    }
                //---------------Calcolo superficie da detrarre
                componente.datiopaca.SuperficieADetrarre = 0;
                if (tipoConfine == "Esterno")
                    foreach (var componenteassociato in ElementiAssociati)
                        if (componenteassociato.PareteACuiAssociata != null & componenteassociato.PareteACuiAssociata == componente)
                            if (componenteassociato.Tipo == TipoElemento.Finestra)
                                componente.datiopaca.SuperficieADetrarre += componenteassociato.datiopaca.Larghezza * componenteassociato.datiopaca.Altezza;
                //---------------
                var superficieDisperdenteDouble = UtiBimNTS.AreaPolyIFC(componente.Poligono.Poligono, SuperficieVerticale(componente));
                var superficieDisperdente = doubleToStr(superficieDisperdenteDouble-componente.datiopaca.SuperficieADetrarre);
                if (componente.Tipo == TipoElemento.Pavimento)
                    suppav = superficieDisperdenteDouble;

                // Crea un nodo "superficieOpaca"
                if (tipoConfine != "AmbienteClimatizzato")
                {
                    if (MurariaDisperdente(componente.Tipo))
                    {
                        supdisp += superficieDisperdenteDouble;
                        //TermodelLog.WriteLog($"Superficie muraria disperdente:{superficieDisperdente}, {componente.Tipo}  tipologia {componente.datiopaca.Codice} confine {componente.datiopaca.Confine}");

                    }
 
                    componente.Censito = true;
                    //_mainWindow.report.NuovoParagrafo();

                    // caso falda e caso normale
                    string strinclinazione = LeggiDxf.StringInclinazione(
                     Utigen.CVStrToDouble(
                     calcolofalde
                     ? InclinazioneParete(componente, InclinazioneFalda)
                     : InclinazioneParete(componente, double.NaN)));

                    _mainWindow.report.AggiungiTestoFormattato("-------------", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3);
                    // differenziazione caso mansardato
                    _mainWindow.report.AggiungiTestoFormattato(strinclinazione, grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3);
                    
                    if (strinclinazione!= "Solaio (0°)"&& strinclinazione != "Pavimento (180°)")
                        _mainWindow.report.AggiungiTestoFormattato(
                        LeggiDxf.StringNord_xml(
                        Utigen.CVStrToDouble(
                        calcolofalde
                        ? OrientamentoParete(componente, OrientamentoFalda)
                        : OrientamentoParete(componente, double.NaN)
                        )
                        ),
                        grassetto: true,
                        colore: "DarkRed",
                        dimensioneFont: 16,
                        Numcap: 3
                        ); 

                    _mainWindow.report.AggiungiTestoConValoreStringaPar("Confine:", tipoConfine, Numcap: 3);
                    _mainWindow.report.AggiungiTestoConValoreStringaPar("Tipologia:", DescrizionePareteXML, Numcap: 3);
                    //_mainWindow.report.AggiungiTestoConValorePar("inclinazione:", Utigen.CVStrToDouble(InclinazioneParete(componente)), "deg.", "Blue", "Red", 14, NumeroIntero: true, Numcap: 3);
                    _mainWindow.report.AggiungiTestoConValorePar("superficie lorda:", superficieDisperdenteDouble, "m²", "Blue", "Red", 14, Numcap: 3);
                    _mainWindow.report.AggiungiTestoConValorePar("superficie netta:", Utigen.CVStrToDouble(superficieDisperdente), "m²", "Blue", "Red", 14, Numcap: 3);
                    _mainWindow.report.AggiungiTestoConValorePar("superficie vetrata:", componente.datiopaca.SuperficieADetrarre, "m²", "Blue", "Red", 14, Numcap: 3);

                    _mainWindow.report.AggiungiTestoConValorePar("trasmittanza:", Utigen.CVStrToDouble(TrasmittanzaParete(componente)), "W/m²K", "Blue", "Red", 14, Numcap: 3);
                    //_mainWindow.report.AggiungiTestoConValorePar(", esposizione:", Utigen.CVStrToDouble(OrientamentoParete(componente)), "deg.", "Blue", "Red", 14,NumeroIntero : true, Numcap: 3);
                   // _mainWindow.report.StampaParagrafo(Numcap: 3);
                    XElement superficieNode = null;
                    if (tipoConfine == "AmbienteNonClimatizzato")
                    {
                        superficieNode = new XElement("superficieOpaca",
                             new XElement("descrizione", DescrizionePareteXML),
                             new XElement("idAmbienteConfinante", IDNonRiscaldato(componente)),
                             new XElement("tipo", "0"),
                             new XElement("superficieDisperdente", superficieDisperdente),
                             new XElement("trasmittanza", TrasmittanzaParete(componente)),
                             new XElement("fonteTrasmittanza", "1"),
                             new XElement("idComponenteStratigrafia", IDXML),
                             new XElement("inclinazione", InclinazioneParete(componente)),
                             new XElement("capacitàTermica", "40.32")
                         );
                    }
                    else
                    {
                        superficieNode = new XElement("superficieOpaca",
                            new XElement("descrizione", DescrizionePareteXML),
                            new XElement("tipo", "0"),
                            new XElement("superficieDisperdente", superficieDisperdente),
                            new XElement("trasmittanza", TrasmittanzaParete(componente)),
                            new XElement("fonteTrasmittanza", "1"),
                            new XElement("idComponenteStratigrafia", IDXML),
                            new XElement("colore", "1"),
                            // differenziazione mansardati
                            new XElement("esposizione", calcolofalde ? OrientamentoParete(componente, OrientamentoFalda) : OrientamentoParete(componente, double.NaN)),
                            new XElement("inclinazione", calcolofalde ? InclinazioneParete(componente, InclinazioneFalda) : InclinazioneParete(componente, double.NaN)),
                            new XElement("fattoreOmbreggiaturaDiffusa", "1"),
                            new XElement("capacitàTermica", "40.32")
                        );
                    }
                    if (tipoConfine == "Esterno")
                        
                        foreach (var componenteassociato in ElementiAssociati)
                        if (componenteassociato.PareteACuiAssociata!=null& componenteassociato.PareteACuiAssociata == componente)
                            {

                            if (componenteassociato.Tipo == TipoElemento.Finestra)
                            {
                                XElement FinestraXml = AggiungiFinestra(componenteassociato, _xdoc, doc);
                                if (FinestraXml == null) continue;
                                ConfineNode.Add(FinestraXml);
                            }
                            if (componenteassociato.Tipo == TipoElemento.Ponte)
                            {
                                var ponte = AggiungiPonte(componenteassociato);
                                if (ponte != null) ConfineNode.Add(ponte);
                            }
                        }
                    // Aggiungi il nodo della superficie solo se è pertinente al file XML che stai seguendo
                    // Nel Nazionale, aggiungiamo la superficie nel nodo di confine (es. Esterno), poi nel locale

                    if (Cened.IsCened) localeNode.Add(superficieNode);
                    else ConfineNode.Add(superficieNode);
                }

            }
            // Solo in Nazionale, aggiungiamo il ConfineNode al locale
            if (!Cened.IsCened) localeNode.Add(ConfineNode);
            
        }
       
        // Aggiungiamo le superfici per ciascuna lista
        AggiungiSuperficieOpaca(localeNode, confiniEsterni, "Esterno");
        AggiungiSuperficieOpaca(localeNode, confiniAmbienteNonClimatizzato, "AmbienteNonClimatizzato");
        AggiungiSuperficieOpaca(localeNode, confiniAmbienteClimatizzato, "AmbienteClimatizzato");
        AggiungiSuperficieOpaca(localeNode, confiniTerreno, "Terreno");
        AggiungiSuperficieOpaca(localeNode, confiniInterni, "Interno");
        superficie = suppav;
        superficiedisperdente = supdisp;
    }
    public static void Risultati()
    {
        // Ottieni la referenza della MainWindow
        MainWindow mainWindow = Application.Current.MainWindow as MainWindow;

        if (mainWindow != null)
        {
            // Assicurati che l'aggiornamento del TextBlock avvenga sul thread dell'interfaccia utente
            mainWindow.Dispatcher.Invoke(() =>
            {
                // Pulisci il contenuto del TextBlock
                mainWindow.txtInformazioniGenerali.Inlines.Clear();

                // Aggiungi le informazioni con valori in grassetto e unità di misura non in grassetto
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run("Superficie Netta Totale: ") { FontWeight = FontWeights.Normal });
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run($"{superficieNettaTotale:F1}") { FontWeight = FontWeights.Bold });
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run(" m²\n") { FontWeight = FontWeights.Normal });

                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run("Volume Netto Totale: ") { FontWeight = FontWeights.Normal });
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run($"{volumeNettoTotale:F1}") { FontWeight = FontWeights.Bold });
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run(" m³\n") { FontWeight = FontWeights.Normal });

                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run("Superficie Lorda Disperdente Totale: ") { FontWeight = FontWeights.Normal });
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run($"{superficieLordaDisperdenteTotale:F1}") { FontWeight = FontWeights.Bold });
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run(" m²\n") { FontWeight = FontWeights.Normal });

                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run("Volume Lordo Climatizzato Totale: ") { FontWeight = FontWeights.Normal });
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run($"{volumeLordoClimatizzatoTotale:F1}") { FontWeight = FontWeights.Bold });
                mainWindow.txtInformazioniGenerali.Inlines.Add(new Run(" m³") { FontWeight = FontWeights.Normal });
            });
        }
    }

    public static bool Esegui_calcolo_ape=false;
    public static void GeneraXml(string xmlBasePath, string xmlOutPath,double dirnord)
    {
        _mainWindow.report.SvuotaReportAPE();
       //Cened.IsCened = Cened.ISCENED(xmlBasePath);
        Cened.IsCened = false;// in attesa di certificazione
        if (Cened.IsCenedInput)  Cened.ArchivioFinestreDaCenedANazionale(Cened.PathCenedInput, xmlBasePath);
         DirezioneNord = dirnord;
        Codicefinestra = 0;
        // Carica il file XML di base con XDocument
        XDocument doc = XDocument.Load(xmlBasePath);
        if (Cened.IsCened)Cened.InizializzaNamespace(doc);
        _xdoc = new XDocument(doc);  // Copia del documento originale
        XMLConverter.SaveAsJson(xmlBasePath);
        listaFinestre.Clear();
        XElement? fabbricatoNode = null;
        if (!Cened.IsCened)
        {
            // Trova la sezione "Fabbricato" e rimuovi tutto il contenuto attuale
            fabbricatoNode = doc.Descendants("fabbricato").FirstOrDefault();
            var subEdifici = doc.Descendants("subEdificio");
            subEdifici.Remove();
            var listaVetrate = doc.Descendants("vetrata");
            listaVetrate.Remove();
        }
        superficieNettaTotale = 0;
        volumeNettoTotale = 0;
        superficieLordaDisperdenteTotale = 0;
        volumeLordoClimatizzatoTotale = 0;
        superficieInfissiTotale = 0;
        trasmittanzaTotaleInfissi = 0;

    TermodelLog.LogOperation("---------------------------------------------------------------------------------");
        TermodelLog.LogOperation("Inizio generazione XML");
        TermodelLog.LogOperation("---------------------------------------------------------------------------------");
        // Crea il nodo "subEdificio" per ogni zona
        // Ciclo for per iterare su zonecollection
        _mainWindow.report.CancellaTesto(Numcap: 2);
        _mainWindow.report.AggiungiTestoFormattato(" ", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 2,report:false);
        _mainWindow.report.AggiungiTestoFormattato("Dati Riassuntivi delle zone", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 2, report: false);
        if (zonecollection.Count < 1)
            TermodelLog.LogError("Nessuna zona in archivio è stata importata dall'XML di base.");
        for (int i = 0; i < zonecollection.Count; i++)
        {
            var zone = zonecollection[i];
            if (!Database.DB.TipoZona(CategoriaZona.DaCalcolare, zone["Codice"].ToString())) continue;
            double superficieNettaZona = 0;
            double superficieParetiZona = 0;
            double volumeNettoZona = 0;
            double superficieLordaDisperdenteZona = 0;
            double volumeLordoClimatizzatoZona = 0;
            
            string descrizioneZona = "Mancante";

            string idXml = "Mancante";
            //if (zone.ContainsKey("IDXML") && zone["IDXML"] != null)
            //    idXml = zone["IDXML"].ToString();
            if (zone.ContainsKey("Codice") && zone["Codice"] != null)
                idXml = zone["Codice"].ToString();
            idXml = IDXMLZona(_xdoc, idXml);

            if (zone.ContainsKey("Descrizione") && zone["Descrizione"] != null)
                descrizioneZona = zone["Descrizione"].ToString();
            TermodelLog.LogOperation($"----------------->  Elaborazione della zona: {descrizioneZona}");

            XElement? subEdificioNode;
            XElement listaLocaliNode;
            XElement DatilocaleNode;
            if (!Cened.IsCened)
            {
                subEdificioNode = new XElement("subEdificio",
            new XElement("identificativo",               // Crea il nodo "identificativo"
            new XElement("id", idXml),              // Nodo figlio "id" con valore "Zona"
            new XElement("descrizione", descrizioneZona)      // Nodo figlio "descrizione" con valore "Zona"
            ),
            new XElement("classificazioneDPR412", "0")
            // Crea il nodo "listaLocali"
            );
            listaLocaliNode = new XElement("listaLocali");
            }
            else
            {
                // ⚠️ Compatibilità con struttura XML nazionale:
                // Nel formato nazionale, listaLocali contiene anche le superfici disperdenti (superficieOpaca, superficieFinestrata, ecc.).
                // Per mantenere compatibilità col vecchio codice, listaLocaliNode continua ad essere usato anche in modalità CENED,
                // pur riferendosi in realtà al nodo <d:dispersioni> della zona.
                subEdificioNode = Cened.TrovaNodoZonaCENED(doc, zone["IDXML"].ToString());
                DatilocaleNode = Cened.GetOrCreateAmbientiNode(subEdificioNode);
                listaLocaliNode = Cened.GetOrCreateDispersioniNode(subEdificioNode);
                //DatilocaleNode.RemoveAll();
                //listaLocaliNode.RemoveAll();
            }
            //subEdificioNode.SetAttribute("nome", piano.Nome);
            //subEdificioNode.SetAttribute("quota", piano.QuotaCorrente.ToString());

                // Crea il nodo "listaLocali" per i locali associati al piano
           

            _mainWindow.report.CancellaTesto(Numcap: 3);
            _mainWindow.report.AggiungiTestoFormattato(" ", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3, report: false);
            _mainWindow.report.AggiungiTestoFormattato("Dati Riassuntivi dei piani", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3, report: false);

            // Scorri l'elenco dei piani da Polig3D
            foreach (var piano in Polig3D.ElencoPiani)
            {
                if (piano.Tipopiano != TipoPiano.Calpestabile) continue;

                _mainWindow.report.AggiungiTestoFormattato("  ", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3, report: false);
                _mainWindow.report.AggiungiTestoFormattato("-----------------------------------------------------------------------", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3, report: false);
                _mainWindow.report.AggiungiTestoConValoreStringa("Dati Riassuntivi del piano :", piano.Nome, "Blue", "Red", 14, Numcap: 3, report: false);

                
                TermodelLog.LogOperation($"=====================>  Elaborazione del piano: {piano.Nome}");





                // Aggiungi i locali associati al piano
                foreach (var locale in Polig3D.GetLocaliByPianoZona(piano.Nome, descrizioneZona))
                {
                    TermodelLog.LogOperation($"----------------->  Elaborazione del locale: {locale.DatiLocale.Id}:{locale.DatiLocale.Descrizione}");



                    // Crea le liste temporanee per i vari tipi di confini
                    var confiniEsterni = new List<ElementoAssociato>();
                    var confiniAmbienteNonClimatizzato = new List<ElementoAssociato>();
                    var confiniAmbienteClimatizzato = new List<ElementoAssociato>();
                    var confiniTerreno = new List<ElementoAssociato>();
                    var confiniInterni = new List<ElementoAssociato>();

                    double superficie = 0;
                    double superficie_netta = 0;
                    double superficiePareti = 0;
                    double superficiedisperdente = 0;
                    double volume = 0;
                    double altezzamedia = locale.DatiLocale.AltezzaNettaMedia;
                    double altezzaLorda = locale.DatiLocale.AltezzaLordaMedia;
                    bool PavimentoStessaZona = false;
                    double SupPavimentoStessaZona = 0;

                    foreach (var componente in Polig3D.GetComponentiByLocale(locale.DatiLocale.Id))
                    if (!componente.Poligono.Falda)
                    if (componente.StessaZona==null||!componente.StessaZona)
                        {
                        TermodelLog.LogContesto = $"Componente {componente.Tipo}";
                        var tipoConfine = DeterminaTipoConfine(componente);
                        //TermodelLog.LogOperation($"----------------->  Elaborazione dell'elemento tipo: {componente.Tipo}");
                        // Aggiungi il componente alla lista appropriata
                        switch (tipoConfine)
                        {
                            case TipoConfine.Esterno:
                                confiniEsterni.Add(componente);
                                break;
                            case TipoConfine.Interno:
                                confiniInterni.Add(componente);
                                break;
                            case TipoConfine.AmbienteNonClimatizzato:
                                confiniAmbienteNonClimatizzato.Add(componente);
                                break;
                            case TipoConfine.AmbienteClimatizzato:
                                confiniAmbienteClimatizzato.Add(componente);
                                break;
                            case TipoConfine.Terreno:
                                confiniTerreno.Add(componente);
                                break;
                            case TipoConfine.Fittizia:
                            case TipoConfine.Dividi:
                                // Separatori geometrici: non sono superfici
                                // disperdenti da esportare nel modello termico.
                                break;
                            case TipoConfine.Sconosciuto:
                                // Log o gestione del tipo sconosciuto
                                TermodelLog.LogError($"Tipo confine sconosciuto -{componente.datiopaca?.Confine ?? "DatiOpaca=null"}- per il componente {componente.Poligono?.ElementIdentifier ?? "ID non disponibile"}");
                                break;
                        }
                    
                        }
                        else //stessazona calcola comunque la superficie del pavimento
                        {
                                if (componente.Tipo == TipoElemento.Pavimento)
                                {
                                    var superficieDisperdenteDouble = UtiBimNTS.AreaPolyIFC(componente.Poligono.Poligono, SuperficieVerticale(componente));
                                    SupPavimentoStessaZona = superficieDisperdenteDouble;
                                    PavimentoStessaZona = true;
                                }   
                        }

                    XElement trasmissioneNode = new XElement("trasmissione");

                    _mainWindow.report.AggiungiTestoConValoreStringa("Locale :", $"{piano.Nome}-{locale.Nome}", "Blue", "Red", 14, Numcap: 3, report: false);

                    // Ora possiamo creare i nodi per ogni lista di confini
                    AggiungiSuperficiAlLocale(doc, trasmissioneNode, confiniEsterni, confiniAmbienteNonClimatizzato, confiniAmbienteClimatizzato, confiniTerreno, confiniInterni,ref superficie, ref superficiedisperdente, ref volume,ref altezzamedia);
                    if (PavimentoStessaZona) superficie = SupPavimentoStessaZona;
                    volume = superficie* altezzaLorda;
                    superficieNettaZona += superficie- locale.DatiLocale.SuperficieParetiInPianta;
                    volumeNettoZona += (superficie - locale.DatiLocale.SuperficieParetiInPianta) * altezzamedia;
                    volumeLordoClimatizzatoZona += volume;
                    superficieLordaDisperdenteZona += superficiedisperdente;
                    superficie_netta = superficie - locale.DatiLocale.SuperficieParetiInPianta;
                    double Volume_netto = superficie_netta * altezzamedia;
                    _mainWindow.report.AggiungiTestoFormattato("------------------------", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3,report:false);
                    _mainWindow.report.AggiungiTestoConValoreStringa("Dati Riassuntivi del locale :", $"{piano.Nome}-{locale.Nome}", "Blue", "Red", 14, Numcap: 3, report: false);
                    _mainWindow.report.AggiungiTestoConValore("Superficie lorda climatizzata:", superficie , "m²", "Blue", "Red", 14, Numcap: 3, report: false);
                    _mainWindow.report.AggiungiTestoConValore("Superficie netta climatizzata:", superficie_netta, "m²", "Blue", "Red", 14, Numcap: 3, report: false);
                    _mainWindow.report.AggiungiTestoConValore("Superficie Disperdente:", superficiedisperdente, "m²", "Blue", "Red", 14, Numcap: 3, report: false);
                    _mainWindow.report.AggiungiTestoConValore("Volume netto climatizzato:", Volume_netto, "m³", "Blue", "Red", 14, Numcap: 3, report: false);
                    _mainWindow.report.AggiungiTestoConValore("Volume lordo climatizzato:", volume, "m³", "Blue", "Red", 14, Numcap: 3, report: false);
                    _mainWindow.report.AggiungiTestoFormattato("  ", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 3, report: false);

                    XElement localeNode = new XElement("locale",
                                              new XElement("identificativo",
                                                  new XElement("id", $"{piano.Nome}-{locale.Nome}"),
                                                  new XElement("descrizione", $"{piano.Nome}-{locale.Nome}")
                                                  ),
                                              new XElement("superficieNetta", superficie_netta.ToString("F2", CultureInfo.InvariantCulture)),  // Due cifre decimali
                                              new XElement("volumeNetto", Volume_netto.ToString("F2", CultureInfo.InvariantCulture)),          // Due cifre decimali
                                              new XElement("altezzaNettaMedia", altezzamedia.ToString("F2", CultureInfo.InvariantCulture)),// Due cifre decimali
                         trasmissioneNode);
                    // Aggiungi il nodo "locale" alla "listaLocali"
                    listaLocaliNode.Add(localeNode);
                }

            }
            
            // Aggiungi il nodo "listaLocali" al "subEdificio"
            subEdificioNode.Add(listaLocaliNode);
            
            subEdificioNode.Add(new XElement("superficieNetta", doubleToStr(superficieNettaZona)));
            subEdificioNode.Add(new XElement("volumeNetto", doubleToStr(volumeNettoZona)));
            subEdificioNode.Add(new XElement("superficieLordaDisperdente", doubleToStr(superficieLordaDisperdenteZona)));
            subEdificioNode.Add(new XElement("volumeLordoClimatizzato", doubleToStr(volumeLordoClimatizzatoZona)));
            // Aggiungi il nodo "subEdificio" alla sezione "Fabbricato"
            if (!Cened.IsCened) fabbricatoNode.Add(subEdificioNode);

            superficieNettaTotale += superficieNettaZona;
            volumeNettoTotale += volumeNettoZona;
            superficieLordaDisperdenteTotale += superficieLordaDisperdenteZona;
            volumeLordoClimatizzatoTotale += volumeLordoClimatizzatoZona;
            _mainWindow.report.AggiungiTestoFormattato("  ", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 2, report: false);
            _mainWindow.report.AggiungiTestoConValoreStringa("Dati Riassuntivi della zona :", descrizioneZona, "Blue", "Red", 14, Numcap: 2, report:false);
            _mainWindow.report.AggiungiTestoConValore("Superficie netta climatizzata:", superficieNettaZona, "m²", "Blue", "Red", 14, Numcap: 2, report: false);
            _mainWindow.report.AggiungiTestoConValore("Superficie Disperdente:", superficieLordaDisperdenteZona, "m²", "Blue", "Red", 14, Numcap: 2, report: false);
            _mainWindow.report.AggiungiTestoConValore("Volume netto climatizzato:", volumeNettoZona, "m³", "Blue", "Red", 14, Numcap: 2, report: false);
            _mainWindow.report.AggiungiTestoConValore("Volume lordo climatizzato:", volumeLordoClimatizzatoZona, "m³", "Blue", "Red", 14, Numcap: 2, report: false);
            _mainWindow.report.AggiungiTestoFormattato("  ", grassetto: true, colore: "DarkRed", dimensioneFont: 16, Numcap: 2, report: false);

        }
        //Polig3D.ControllaCensiti();
        _mainWindow.report.CancellaTesto();
        // Titolo della sezione
        _mainWindow.report.AggiungiTestoFormattato("  ", grassetto: true, colore: "DarkRed", dimensioneFont: 16);
        _mainWindow.report.AggiungiTestoFormattato("Dati Riassuntivi del Modello", grassetto: true, colore: "DarkRed", dimensioneFont: 16);
        _mainWindow.report.AggiungiTestoConValore("Superficie netta climatizzata:", superficieNettaTotale, "m²", "Blue", "Red", 14);
        _mainWindow.report.AggiungiTestoConValore("Elementi censiti", ElementiAssociati.Count, "num", "Blue", "Red", 14);
        _mainWindow.report.AggiungiTestoConValore("Superficie Disperdente:", superficieLordaDisperdenteTotale, "m²", "Blue", "Red", 14);
        _mainWindow.report.AggiungiTestoConValore("Superficie totale infissi:", superficieInfissiTotale, "m²", "Blue", "Red", 14);
        _mainWindow.report.AggiungiTestoConValore("Trasmittanza media infissi:", trasmittanzaTotaleInfissi / superficieInfissiTotale, "W/m²K", "Blue", "Red", 14);
        _mainWindow.report.AggiungiTestoConValore("Volume netto climatizzato:", volumeNettoTotale, "m³", "Blue", "Red", 14);
        _mainWindow.report.AggiungiTestoConValore("Volume lordo climatizzato:", volumeLordoClimatizzatoTotale, "m³", "Blue", "Red", 14);
        _mainWindow.report.AggiungiTestoFormattato("  ", grassetto: true, colore: "DarkRed", dimensioneFont: 16);
        // Riga vuota per separazione visiva
        _mainWindow.report.AggiungiTesto("\n");
        //Risultati();
        //CopiaNodo(_xdoc, doc, "fabbricato");
        //CopiaNodo(_xdoc, doc, "subEdificio");
        // Salva l'XML modificato
        //CopiaNodo(_xdoc, doc, "listaLocali");
        //CopiaNodo(_xdoc, doc, "subEdificio", "locale");
        //CopiaNodo(_xdoc, doc, "locale", "identificativo");
        //CopiaNodo(_xdoc, doc, "locale", "trasmissione");
        //CopiaNodo(_xdoc, doc, "locale", "ventilazione");
        //CopiaNodo(_xdoc, doc, "locale", "apportiInterni");
        //CopiaNodo(_xdoc, doc, "locale", "zone");

        doc.Save(xmlOutPath);
        XMLConverter.SaveAsJson(xmlOutPath);
        // Modificato da Codex per realizzare: salvare gli elaborati pannelli nel progetto
        // corrente anche quando Termodel viene avviato da un'applicazione esterna.
        IoPannelli.SaveToFile(GestProg.FileLocaleXmlPath);
        var risultatoPannelli = CalcoloPannelli.EseguiCalcoloPannelli(
            doc,
            IoPannelli.GetDocument());
        _mainWindow.AggiornaReportPannelli(risultatoPannelli);
        // Modificato da Codex per realizzare: calcolare sempre le dispersioni senza eseguire
        // la bozza APE (edificio di riferimento, apporti, energia primaria e classe).
        var calcoloDispersioni = new CalcoloAPE();
        calcoloDispersioni.EseguiCalcoloDispersioni(doc);
        _mainWindow.AggiornaReportDispersioni(calcoloDispersioni.Risultato);

        // Vecchio codice:
        // Il richiamo al calcolo APE preliminare resta documentato ma temporaneamente disattivato.
        // if (Esegui_calcolo_ape)
        // {
        //     var ape = new CalcoloAPE();
        //     ape.EseguiCalcoloAPE(doc);
        //     _mainWindow.AggiornaReportDispersioni(ape.Risultato);
        // }


        //if (Cened.IsCened) Cened.SalvaCened(xmlBasePath);
    }

    public static void LoadZoneFromXML(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> ZoneCollection)
    {
        ZoneCollection.Clear();
        if (Cened.LoadZoneCollectionFromXmlCENED(xmlFilePath, ZoneCollection))
        {
            Database.DB.AggiungiZoneStandard();
            return;
        }
       // Carica il documento XML dal percorso fornito
       XDocument doc = XDocument.Load(xmlFilePath);

        // Seleziona tutti i nodi subEdificio
        var zoneNodes = doc.Descendants("subEdificio");

        // Itera su ciascun nodo subEdificio
        foreach (var zoneNode in zoneNodes)
        {
            // Creiamo un dizionario per la singola zona
            var zoneDict = new Dictionary<string, object>();

            // Estrai gli elementi necessari dal nodo
            var idElement = zoneNode.Element("identificativo")?.Element("id")?.Value;
            var descrizioneElement = zoneNode.Element("identificativo")?.Element("descrizione")?.Value;
            var codiceelement = PulisciCodice(descrizioneElement);
            // Assegnazione delle informazioni ai campi del dizionario
            zoneDict["Codice"] = codiceelement ?? string.Empty;  // Assegnazione: Codice = Descrizione
            zoneDict["IDXML"] = idElement ?? string.Empty;            // Assegnazione: IDXML = id
            zoneDict["Descrizione"] = descrizioneElement ?? string.Empty; // Assegnazione: Descrizione = Descrizione
            zoneDict["Tipo"] = "AmbienteClimatizzato"; // Valore fisso per il Tipo

            // Opzionale: se vuoi limitare la lunghezza dei campi, puoi usare substring
            zoneDict["Codice"] = ((string)zoneDict["Codice"]).Length > 250 ? ((string)zoneDict["Codice"]).Substring(0, 250) : zoneDict["Codice"];
            zoneDict["IDXML"] = ((string)zoneDict["IDXML"]).Length > 250 ? ((string)zoneDict["IDXML"]).Substring(0, 250) : zoneDict["IDXML"];
            zoneDict["Descrizione"] = ((string)zoneDict["Descrizione"]).Length > 350 ? ((string)zoneDict["Descrizione"]).Substring(0, 350) : zoneDict["Descrizione"];

            // Aggiungi il dizionario alla collezione
            ZoneCollection.Add(zoneDict);
        }
        Database.DB.AggiungiZoneStandard();
    }
    public static string IDXMLZona(XDocument doc,string descrizione)
    {
        // Seleziona tutti i nodi subEdificio
        var zoneNodes = doc.Descendants("subEdificio");

        // Itera su ciascun nodo subEdificio
        foreach (var zoneNode in zoneNodes)
        {
            // Estrai gli elementi necessari dal nodo
            var idElement = zoneNode.Element("identificativo")?.Element("id")?.Value;
            var descrizioneElement = zoneNode.Element("identificativo")?.Element("descrizione")?.Value;
            if (descrizioneElement == descrizione) return idElement;

        }
        return null;
    }
    public static void LoadNonClimatizzatiFromXML(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> NonClimatizzatiCollection)
    {
        // Carica il documento XML dal percorso fornito
        XDocument doc = XDocument.Load(xmlFilePath);

        // Seleziona il nodo "ambientiNonClimatizzati"
        var nonClimatizzatiNode = doc.Descendants("ambientiNonClimatizzati").FirstOrDefault();

        // Verifica che il nodo "ambientiNonClimatizzati" esista
        if (nonClimatizzatiNode == null)
        {
            throw new Exception("Il nodo 'ambientiNonClimatizzati' non è stato trovato nel file XML.");
        }

        // Seleziona tutti i nodi "ambiente" all'interno di "ambientiNonClimatizzati"
        var ambienteNodes = nonClimatizzatiNode.Descendants("ambiente");

        // Itera su ciascun nodo "ambiente"
        foreach (var ambienteNode in ambienteNodes)
        {
            // Creiamo un dizionario per il singolo ambiente non climatizzato
            var ambienteDict = new Dictionary<string, object>();

            // Estrai gli elementi necessari dal nodo "identificativo"
            var idElement = ambienteNode.Element("identificativo")?.Element("id")?.Value;
            var descrizioneElement = ambienteNode.Element("identificativo")?.Element("descrizione")?.Value;

            // Assegnazione delle informazioni ai campi del dizionario
            ambienteDict["IDXML"] = idElement ?? string.Empty;            // Assegnazione: IDXML = id
            ambienteDict["Descrizione"] = descrizioneElement ?? string.Empty; // Assegnazione: Descrizione = descrizione
            /*
            // Opzionale: se vuoi limitare la lunghezza dei campi, puoi usare substring
            ambienteDict["IDXML"] = ((string)ambienteDict["IDXML"]).Length > 150 ? ((string)ambienteDict["IDXML"]).Substring(0, 150) : ambienteDict["IDXML"];
            ambienteDict["Descrizione"] = ((string)ambienteDict["Descrizione"]).Length > 350 ? ((string)ambienteDict["Descrizione"]).Substring(0, 350) : ambienteDict["Descrizione"];
            */
            // Aggiungi il dizionario alla collezione
            NonClimatizzatiCollection.Add(ambienteDict);
        }
    }

    public static void CopiaNodo(XDocument doc1, XDocument doc2, string rootName, string nodoDaCopiare)
    {
        // Trova il nodo radice root1 nel primo documento, cercando tra i discendenti
        XElement root1 = doc1.Descendants(rootName).FirstOrDefault();
        if (root1 == null)
        {
            Console.WriteLine($"Nodo radice '{rootName}' non trovato nel primo documento.");
            return;
        }

        // Trova il nodo radice root2 nel secondo documento, cercando tra i discendenti
        XElement root2 = doc2.Descendants(rootName).FirstOrDefault();
        if (root2 == null)
        {
            Console.WriteLine($"Nodo radice '{rootName}' non trovato nel secondo documento.");
            return;
        }

        // Trova il nodo nel primo documento a partire dal nodo radice root1
        XElement nodoDaSostituire = root1.Descendants(nodoDaCopiare).FirstOrDefault();
        if (nodoDaSostituire == null)
        {
            Console.WriteLine($"Nodo '{nodoDaCopiare}' non trovato nel primo documento a partire dal nodo radice '{rootName}'.");
            return;
        }

        // Trova il nodo corrispondente nel secondo documento a partire dal nodo radice root2
        XElement nodoNelSecondoDoc = root2.Descendants(nodoDaCopiare).FirstOrDefault();
        if (nodoNelSecondoDoc != null)
        {
            // Sostituisci il nodo nel secondo documento
            nodoNelSecondoDoc.ReplaceWith(new XElement(nodoDaSostituire));
            Console.WriteLine($"Nodo '{nodoDaCopiare}' sostituito nel secondo documento.");
        }
        else
        {
            // Se il nodo non esiste nel secondo documento, lo aggiungiamo sotto il nodo radice root2
            root2.Add(new XElement(nodoDaSostituire));
            Console.WriteLine($"Nodo '{nodoDaCopiare}' non trovato nel secondo documento. Aggiunto come nuovo nodo.");
        }
    }
}
