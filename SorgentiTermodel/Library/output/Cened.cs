using System;
using System.Collections.Generic;
using System.IO.Compression;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Controls;
using System.Xml.Linq;
using Termodel.utilities;
using static GestXml;
using System.Xml;
using System.Drawing.Text;

namespace Termodel.output
{
    static class Cened
    {
        public static bool IsCened = false;
        public static bool IsCenedInput = false;
        public static string PathCenedInput = "";
        public static XNamespace ns_d { get; private set; }
        public static void InizializzaNamespace(XDocument doc)
        {
            if (doc?.Root == null)
                throw new ArgumentNullException(nameof(doc));

            ns_d = doc.Root.GetNamespaceOfPrefix("d");
        }
        public static bool ISCENED(string xmlFilePath)
        {
            return LeggiCened(xmlFilePath);
                XDocument xdoc = XDocument.Load(xmlFilePath);
                XNamespace ns_c = "http://www.cened.it/cenedplus2/calcolo";
           
            // Controlla che ci sia almeno un nodo radice con il namespace CENED
            var root = xdoc.Root;
            if (root == null || root.Name.Namespace != ns_c)
                return false;
            else return true;
         }
        public static bool LoadFinestreCollectionFromXmlCENED(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> FinestreCollection)
        {
            FinestreCollection.Clear();

            try
            {
                if (!ISCENED(xmlFilePath)) return false;
                XDocument xdoc = XDocument.Load(PathCenedInput);
                XNamespace ns_c = "http://www.cened.it/cenedplus2/calcolo";

                // Controlla che ci sia almeno un nodo radice con il namespace CENED
                var root = xdoc.Root;
                if (root == null || root.Name.Namespace != ns_c)
                    return false;

                XNamespace ns_d = xdoc.Root.GetNamespaceOfPrefix("d");
                var elementoOpacoElements = xdoc.Descendants(ns_d + "serramenti");
                //    .Where(x => (string)x.Attribute("tipo") == "PARETE");

                int index = 0;
                //string Ultimovalore = "";


                foreach (var opaca in elementoOpacoElements)
                {
                    string id = opaca.Attribute("id")?.Value ?? "";

                    var input = opaca.Element(ns_d + "input");
                    var output = opaca.Element(ns_d + "output");

                    if (input == null || output == null) continue;

                    string nome = input.Attribute("nome")?.Value ?? "";
                    string codiceInterno = input.Attribute("codice")?.Value ?? "";

                    string descrizione = $"{nome} ({codiceInterno})";

                    // Ricava la trasmittanza U da d:output
                    string trasmittanza = output.Attribute("u")?.Value ?? "?";
                    string spessore = output.Attribute("d")?.Value ?? "?"; // in mm, convertirlo se necessario
                    double spessoreTotalemm = Utigen.CVStrToDouble(spessore);
                    if (id != null)
                    {

                        Dictionary<string, object> parete = new Dictionary<string, object>
                {
                   { "Codice",id  },
                    { "Descrizione", codiceInterno },
                    { "DescBreve",nome },

                };

                        FinestreCollection.Add(parete);

                    }
                }

                return true;
            }
            catch
            {
                return false;
            }
        }
        public static bool LoadParetiCollectionFromXmlCENED(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> paretiCollection)
        {
            paretiCollection.Clear();

            try
            {
                if (!ISCENED(xmlFilePath)) return false;
                XDocument xdoc = XDocument.Load(PathCenedInput);
                XNamespace ns_c = "http://www.cened.it/cenedplus2/calcolo";

                // Controlla che ci sia almeno un nodo radice con il namespace CENED
                var root = xdoc.Root;
                if (root == null || root.Name.Namespace != ns_c)
                    return false;

                XNamespace ns_d = xdoc.Root.GetNamespaceOfPrefix("d");
                var elementoOpacoElements = xdoc.Descendants(ns_d + "opache");
                //    .Where(x => (string)x.Attribute("tipo") == "PARETE");

                int index = 0;
                //string Ultimovalore = "";


                foreach (var opaca in elementoOpacoElements)
                {
                    string id = opaca.Attribute("id")?.Value ?? "";

                    var input = opaca.Element(ns_d + "input");
                    var output = opaca.Element(ns_d + "output");

                    if (input == null || output == null) continue;

                    string nome = input.Attribute("nome")?.Value ?? "";
                    string codiceInterno = input.Attribute("codice")?.Value ?? "";

                    string descrizione = $"{nome} ({codiceInterno})";

                    // Ricava la trasmittanza U da d:output
                    string trasmittanza = output.Attribute("u")?.Value ?? "?";
                    string spessore = output.Attribute("d")?.Value ?? "?"; // in mm, convertirlo se necessario
                    double spessoreTotalemm = Utigen.CVStrToDouble(spessore) / 1000;
                    string tipostruttura = input.Attribute("tipoStrutturaOpache").Value;
                    if (id != null)
                    {
                        string colore = "";
                        if (tipostruttura == "1")
                        {
                            index++;
                            colore = GestXml.ColoreDaIndice(index);
                        }
                        Dictionary<string, object> parete = new Dictionary<string, object>
                {
                    { "Codice", id  },
                    { "DescBreve", nome },
                    { "Colore", colore },
                    { "Descrizione", codiceInterno },
                    { "Spessore",Utigen.DoubleToStrPuntoDec(spessoreTotalemm,3)},
                    { "Trasmittanza", Utigen.SettaDecimaliStr(trasmittanza,3)  },
                    { "PontiAutomatici", "Nessuno"}

                };

                        paretiCollection.Add(parete);

                    }
                }

                return true;
            }
            catch
            {
                return false;
            }
        }
        public static bool LoadPontiCollectionFromXmlCENED(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> PontiCollection)
        {

            try
            {
                if (!ISCENED(xmlFilePath)) return false;
                XDocument xdoc = XDocument.Load(PathCenedInput); 
                XNamespace ns_c = "http://www.cened.it/cenedplus2/calcolo";

                // Controlla che ci sia almeno un nodo radice con il namespace CENED
                var root = xdoc.Root;
                if (root == null || root.Name.Namespace != ns_c)
                    return false;
                PontiCollection.Clear();

                XNamespace ns_d = xdoc.Root.GetNamespaceOfPrefix("d");
                var elementoOpacoElements = xdoc.Descendants(ns_d + "ponti");
                //    .Where(x => (string)x.Attribute("tipo") == "PARETE");

                int index = 0;
                //string Ultimovalore = "";


                foreach (var opaca in elementoOpacoElements)
                {
                    string id = opaca.Attribute("id")?.Value ?? "";

                    var input = opaca.Element(ns_d + "input");
                    var output = opaca.Element(ns_d + "output");

                    if (input == null || output == null) continue;

                    string nome = input.Attribute("nome")?.Value ?? "";
                    string codiceInterno = input.Attribute("codice")?.Value ?? "";

                    string descrizione = $"{nome} ({codiceInterno})";

                    // Ricava la trasmittanza U da d:output
                    string trasmittanzalin = output.Attribute("psi_i")?.Value ?? "?";
                    if (id != null)
                    {

                        Dictionary<string, object> Ponte = new Dictionary<string, object>
                {
                        { "Descrizione", codiceInterno },
                        { "DescBreve",  nome  },
                        { "TrasmLin", trasmittanzalin }
                };

                        PontiCollection.Add(Ponte);

                    }
                }

                return true;
            }
            catch
            {
                return false;
            }
        }
        public static bool LoadZoneCollectionFromXmlCENED(string xmlFilePath, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> ZoneCollection)
        {

            try
            {
                if (!ISCENED(xmlFilePath)) return false;
                XDocument xdoc = XDocument.Load(PathCenedInput);
                XNamespace ns_c = "http://www.cened.it/cenedplus2/calcolo";

                // Controlla che ci sia almeno un nodo radice con il namespace CENED
                var root = xdoc.Root;
                if (root == null || root.Name.Namespace != ns_c)
                    return false;
                ZoneCollection.Clear();

                XNamespace ns_d = xdoc.Root.GetNamespaceOfPrefix("d");

                var subalterniRoot = xdoc.Descendants(ns_d + "subalterni").FirstOrDefault();
                if (subalterniRoot == null) return false;

                // Preleva sempre tutti i figli <d:subalterno>
                var subalterniElements = subalterniRoot.Elements(ns_d + "subalterno");

                foreach (var subalterno in subalterniElements)
                {
                    string idsub = subalterno.Attribute("id")?.Value ?? "";
                    var zoneElements = subalterno.Descendants(ns_d + "zona");
                    foreach (var zona in zoneElements)
                    {
                        string id = zona.Attribute("id")?.Value ?? "";
                        string nome = zona.Attribute("nome")?.Value ?? "";
                        string codiceInterno = zona.Attribute("codice")?.Value ?? "";

                        // Ricava la trasmittanza U da d:output
                        if (id != null)
                        {

                            Dictionary<string, object> DictZona = new Dictionary<string, object>
                        {
                        { "Descrizione", nome },
                        { "Codice",  nome  },
                        { "IDXML",  $"{idsub}:{id}" },
                        { "Tipo", "AmbienteClimatizzato" }
                        };

                            ZoneCollection.Add(DictZona);

                        }
                    }
                }

                return true;
            }
            catch
            {
                return false;
            }
        }
        public static XElement? TrovaNodoZonaCENED(XDocument xdoc, string idxml)
        {
            

            // Split IDXML → es. "1:ZT1"
            var parti = idxml.Split(':');
            if (parti.Length != 2)
                return null;

            string idSub = parti[0];
            string idZona = parti[1];

            // Trova il subalterno corrispondente
            var subalterniRoot = xdoc.Descendants(ns_d + "subalterni").FirstOrDefault();
            if (subalterniRoot == null)
                return null;

            var subalterno = subalterniRoot.Elements(ns_d + "subalterno")
                .FirstOrDefault(e => (string)e.Attribute("id") == idSub);

            if (subalterno == null)
                return null;

            // Cerca la zona dentro quel subalterno
            var zona = subalterno.Descendants(ns_d + "zona")
                .FirstOrDefault(z => (string)z.Attribute("id") == idZona);

            return zona;
        }
        public static XElement GetOrCreateAmbientiNode(XElement zonaNode)
        {
            if (zonaNode == null)
                throw new ArgumentNullException(nameof(zonaNode));

            

            // Cerca il nodo <d:ambienti> già presente
            var ambientiNode = zonaNode.Element(ns_d + "ambienti");

            // Se non esiste, lo crea e lo aggiunge alla zona
            if (ambientiNode == null)
            {
                ambientiNode = new XElement(ns_d + "ambienti");
                zonaNode.Add(ambientiNode);
            }

            return ambientiNode;
        }
        public static XElement GetOrCreateDispersioniNode(XElement zonaNode)
        {
            if (zonaNode == null)
                throw new ArgumentNullException(nameof(zonaNode));

            

            // Cerca il nodo <d:dispersioni> già presente
            var dispersioniNode = zonaNode.Element(ns_d + "dispersioni");

            // Se non esiste, lo crea e lo aggiunge alla zona
            if (dispersioniNode == null)
            {
                dispersioniNode = new XElement(ns_d + "dispersioni");
                zonaNode.Add(dispersioniNode);
            }

            return dispersioniNode;
        }
        public static bool LeggiCened(string XmlInputPath)
        {
            string inputFolder = Path.Combine(Path.GetDirectoryName(XmlInputPath), "cenedinput");
            string xmlfolder = Path.GetDirectoryName(XmlInputPath);
            try
            {
                string zipFile = Directory.GetFiles(inputFolder, "*.zip").FirstOrDefault();
                if (zipFile == null)
                {
                    IsCened = false;
                    IsCenedInput = false;
                    return false;
                }
                PathCenedInput = Path.Combine(xmlfolder, "inputCened.xml");
                IsCened = true;
                IsCenedInput = true;
                // Estrai contenuto in temp_extract
                string tempExtract = Path.Combine(inputFolder, "temp_extract");
                if (Directory.Exists(tempExtract))
                    Directory.Delete(tempExtract, true);
                Directory.CreateDirectory(tempExtract);
                ZipFile.ExtractToDirectory(zipFile, tempExtract);

                // Trova calcolo.xml
                string calcoloXml = Directory.GetFiles(tempExtract, "calcolo.xml", SearchOption.AllDirectories).FirstOrDefault();
                if (calcoloXml == null)
                    throw new FileNotFoundException("Il file calcolo.xml non è stato trovato nel pacchetto CENED.");

                // Copia calcolo.xml come input.xml nella root
                
                File.Copy(calcoloXml, Path.Combine(xmlfolder, "inputCened.xml"), true);
                XMLConverter.SaveAsJson(Path.Combine(xmlfolder, "inputCened.xml"));
                /* Duplica tutto in cenedoutput
                string outputFolder = Path.Combine(Directory.GetParent(inputFolder).FullName, "cenedoutput");
                if (Directory.Exists(outputFolder))
                    Directory.Delete(outputFolder, true);
                Directory.CreateDirectory(outputFolder);
                File.Copy(zipFile, Path.Combine(outputFolder, Path.GetFileName(zipFile)), true);
                */
                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Errore in LeggiCened: " + ex.Message);
                return false;
            }
        }
        public static bool SalvaCened(string XmlInputPath)
        {
            try
            {
                string xmlfolder = Path.GetDirectoryName(XmlInputPath);
                string outputXmlPath = Path.Combine(xmlfolder, "output.xml");
                if (!File.Exists(outputXmlPath))
                    throw new FileNotFoundException("Il file output.xml non esiste.");

                // Percorsi relativi a cenedoutput
                string inputFolder = Path.Combine(xmlfolder, "cenedinput");
                string outputFolder = Path.Combine(Directory.GetParent(inputFolder).FullName, "cenedoutput");
                string zipFilePath = Directory.GetFiles(outputFolder, "*.zip").FirstOrDefault();

                if (zipFilePath == null)
                    throw new FileNotFoundException("File zip originale non trovato in cenedoutput.");

                // Crea temp_extract sotto outputFolder
                string tempExtract = Path.Combine(outputFolder, "temp_extract");
                if (Directory.Exists(tempExtract))
                    Directory.Delete(tempExtract, true);
                Directory.CreateDirectory(tempExtract);

                // Estrai il contenuto dello zip originale
                ZipFile.ExtractToDirectory(zipFilePath, tempExtract);

                // Sovrascrivi calcolo.xml con output.xml
                string calcoloXmlPath = Path.Combine(tempExtract, "calcolo.xml");
                File.Copy(outputXmlPath, calcoloXmlPath, true);

                // Sovrascrivi il file zip con la nuova versione
                File.Delete(zipFilePath);
                ZipFile.CreateFromDirectory(tempExtract, zipFilePath);

                // Pulisci
                Directory.Delete(tempExtract, true);

                return true;
            }
            catch (Exception ex)
            {
                Console.WriteLine("Errore in SalvaCened: " + ex.Message);
                return false;
            }
        }
        public static void ArchivioFinestreDaCenedANazionale(string pathXmlCened, string pathOutputNazionale)
        {
            XmlDocument docCened = new XmlDocument();
            docCened.Load(pathXmlCened);

            XmlNamespaceManager ns = new XmlNamespaceManager(docCened.NameTable);
            ns.AddNamespace("d", "http://www.cened.it/cenedplus2/datiCalcolo");

            XmlNodeList nodiSerramenti = docCened.SelectNodes("//d:serramenti", ns);

            XmlDocument docOut = new XmlDocument();
            docOut.Load(pathOutputNazionale);

            // Rimuove listaVetrate esistente
            XmlNode nodoVecchio = docOut.SelectSingleNode("//listaVetrate");
            if (nodoVecchio != null && nodoVecchio.ParentNode != null)
                nodoVecchio.ParentNode.RemoveChild(nodoVecchio);

            XmlElement listaVetrate = docOut.CreateElement("listaVetrate");

            foreach (XmlNode serramento in nodiSerramenti)
            {
                XmlNode input = serramento.SelectSingleNode("d:input", ns);
                XmlNode output = serramento.SelectSingleNode("d:output", ns);

                string id = input?.Attributes["codice"]?.Value ?? "";
                string nome = input?.Attributes["nome"]?.Value ?? "Finestra CENED";
                string tipoVetro = input?.Attributes["tipoVetro2"]?.Value ?? "4";
                string trasmittanzaVetro = input?.Attributes["u_g_2"]?.Value ?? "1.4";
                string trasmittanzaDist = input?.Attributes["a_t_2"]?.Value ?? "0.08";

                string tipoTelaio = input?.Attributes["tipoTelaio2"]?.Value ?? "1";
                string trasmittanzaTelaio = input?.Attributes["u_w_2"]?.Value ?? "1.8";

                // Nodo <vetrata>
                XmlElement vetrata = docOut.CreateElement("vetrata");

                XmlElement identificativo = docOut.CreateElement("identificativo");
                identificativo.AppendChild(CreaElemento(docOut, "id", id));
                identificativo.AppendChild(CreaElemento(docOut, "descrizione", id));

                XmlElement vetro = docOut.CreateElement("vetro");
                vetro.AppendChild(CreaElemento(docOut, "descrizione", $"Tipo vetro {tipoVetro}"));
                vetro.AppendChild(CreaElemento(docOut, "tipoVetro", tipoVetro));
                vetro.AppendChild(CreaElemento(docOut, "trasmittanzaDistanziatore", trasmittanzaDist));
                vetro.AppendChild(CreaElemento(docOut, "trasmittanzaVetro", trasmittanzaVetro));

                XmlElement telaio = docOut.CreateElement("telaio");
                telaio.AppendChild(CreaElemento(docOut, "descrizione", $"Tipo telaio {tipoTelaio}"));
                telaio.AppendChild(CreaElemento(docOut, "tipoTelaio", tipoTelaio));
                telaio.AppendChild(CreaElemento(docOut, "trasmittanza", trasmittanzaTelaio));

                vetrata.AppendChild(identificativo);
                vetrata.AppendChild(vetro);
                vetrata.AppendChild(telaio);
                listaVetrate.AppendChild(vetrata);
            }

            docOut.DocumentElement.AppendChild(listaVetrate);
            docOut.Save(pathOutputNazionale);
        }

        private static XmlElement CreaElemento(XmlDocument doc, string nome, string valore)
        {
            XmlElement el = doc.CreateElement(nome);
            el.InnerText = valore;
            return el;
        }



    }
}
