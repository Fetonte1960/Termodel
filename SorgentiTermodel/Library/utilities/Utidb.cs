using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.IO;
using System.Windows.Controls;
using System.Windows.Data;
using System.Collections.ObjectModel;
using Newtonsoft.Json.Linq;
using System.ComponentModel;
using System.Xml.Serialization;
using System.Runtime.Serialization;
using System.Xml;
//using netDxf.Collections;
using NetTopologySuite.Utilities;
using static Microsoft.Isam.Esent.Interop.EnumeratedColumn;
using static System.Runtime.InteropServices.JavaScript.JSType;
using System.Drawing;
using System.Windows.Media.Media3D;
using System.Windows;
using System.Xml.Linq;
using Xbim.IO.Xml.BsConf;
using Termodel.utilities;
using System.Windows.Media;
using System.Windows.Documents;
using System.Collections;
using System.Globalization;
using System.Text;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TextBox;
using netDxf.Blocks;

namespace Termodel.utilities
{
    public static class Database
    {
        public static UtiDb DB;
    }
    public class Data_Collection
    {
        // La collection che contiene i dati
        public ObservableCollection<Dictionary<string, object>> DataCollection { get; set; }

        // Il nome dell'archivio relativo e di tipizzazione
        public string DefType { get; set; }
        public string NomeArch { get; set; }

        // Indica se è stata caricata in memoria
        public bool Loaded { get; set; }

        // Costruttore
        public Data_Collection(string defType, string nomeArch)
        {
            DataCollection = new ObservableCollection<Dictionary<string, object>>();
            DefType = defType;
            NomeArch = nomeArch;
            Loaded = false;
        }
    }
    public class UtiDb
    {

        public Dictionary<string, Data_Collection> DataCollections { get; set; }
        private Dictionary<string, Dictionary<string, Dictionary<string, object>>> metadata;
        // Proprietà per il percorso del file dei dati
        public string PathDatiDB { get; set; }
        public UtiDb(string metadataFilePath, string pathDatiDB)
        {
            // Inizializza la proprietà PathDatiDB
            PathDatiDB = pathDatiDB;
            DataCollections = new Dictionary<string, Data_Collection>();

            // Aggiungi la collezione per "DatiCad"
            AddDataCollection("DatiCad", "DatiCad");
            AddDataCollection("Confini", "Confini");
            AddDataCollection("Pareti", "Pareti");
            AddDataCollection("Piani", "Piani");
            AddDataCollection("Zone", "Zone");
            AddDataCollection("Finestre", "Finestre");
            AddDataCollection("Ponti", "Ponti");
            AddDataCollection("PontiAutomatici", "PontiAutomatici");
            AddDataCollection("PontiAutomaticiFinestre", "PontiAutomaticiFinestre");
            AddDataCollection("NonClimatizzati", "NonClimatizzati");
            LoadMetadata(metadataFilePath);
        }
        public string GetCollectionAsString(string idTipo)
        {
            if (!DataCollections.ContainsKey(idTipo))
            {
                return $"[DEBUG] La collezione con idTipo '{idTipo}' non esiste.";
            }

            var collection = DataCollections[idTipo].DataCollection;
            if (collection.Count == 0)
            {
                return $"[DEBUG] La collezione '{idTipo}' è vuota.";
            }

            var sb = new StringBuilder();
            sb.AppendLine($"[DEBUG] Contenuto della collezione '{idTipo}':");

            int riga = 0;
            foreach (var record in collection)
            {
                sb.AppendLine($"  Riga {riga++}:");

                foreach (var kvp in record)
                {
                    string chiave = kvp.Key;
                    string valore = kvp.Value?.ToString() ?? "(null)";
                    sb.AppendLine($"    {chiave} = {valore}");
                }
            }

            return sb.ToString();
        }
        // Funzioni specializzate ----------------------------------------------------------------
        //----- Zone
        public void AggiungiZoneStandard()
        {
            var zone = Database.DB.GetCollection("Zone");

            var tipiStandard = new List<string>
    {
        "AmbienteNonClimatizzato",
        "Edificio adiacente",
        "Pozzo luce",
        "Balcone"
    };

            foreach (var tipo in tipiStandard)
            {
                var nuovaZona = new Dictionary<string, object>
                {
                    ["Codice"] = tipo,
                    ["Descrizione"] = tipo,
                    ["Tipo"] = tipo,
                    ["IDXML"] = string.Empty,
                    ["TipoNonClimatizzato"] = "Ambiente senza serramenti esterni e con almeno due pareti esterne"
                };

                zone.Add(nuovaZona);
            }
        }
        public enum CategoriaZona
        {
            DaCalcolare,
            Balcone,
            PozzoLuce,
            Adiacente,
            Unclassified // aggiunto per compatibilità retroattiva
        }

        public bool TipoZona(CategoriaZona categoria, string codice)
        {
            var zone = Database.DB.GetCollection("Zone");
            
            var zona = zone.FirstOrDefault(z =>
                z.ContainsKey("Codice") && z["Codice"]?.ToString() == codice);
            
            if (zona == null)
            {
                TermodelLog.LogError($"Zona con codice \"{codice}\" non trovata. Considerata come 'DaCalcolare' per compatibilità.");
                return false;
            }
            
            if (!zona.ContainsKey("Tipo"))
            {
                TermodelLog.WriteLog($"Zona con codice \"{codice}\" trovata ma senza campo 'Tipo'. Considerata come 'DaCalcolare'.");
                return categoria == CategoriaZona.DaCalcolare;
            }

            string tipo = zona["Tipo"]?.ToString();

            switch (categoria)
            {
                case CategoriaZona.DaCalcolare:
                    return tipo == "AmbienteClimatizzato";

                case CategoriaZona.Balcone:
                    return tipo == "Balcone";

                case CategoriaZona.PozzoLuce:
                    return tipo == "Pozzo luce";

                case CategoriaZona.Adiacente:
                    return tipo == "Edificio adiacente";

                case CategoriaZona.Unclassified:
                    return tipo != "AmbienteClimatizzato"
                        && tipo != "Balcone"
                        && tipo != "Pozzo luce"
                        && tipo != "Edificio adiacente";

                default:
                    TermodelLog.WriteLog($"Categoria non riconosciuta per il tipo \"{tipo}\" della zona \"{codice}\". Considerata come 'DaCalcolare'.");
                    return categoria == CategoriaZona.DaCalcolare;
            }
        }



        //Fine funzioni specializzate--------------------------------------------------------------
        public ObservableCollection<Dictionary<string, object>> GetCollection(string idTipo)
        {
            if (DataCollections.ContainsKey(idTipo))
            {
                return DataCollections[idTipo].DataCollection;
            }
            else
            {
                Console.WriteLine($"La collezione con idTipo '{idTipo}' non esiste.");
                return new ObservableCollection<Dictionary<string, object>>();
            }
        }
        private void AddDataCollection(string defType, string nomeArch)
        {
            var dataCollection = new Data_Collection(defType, nomeArch);
            DataCollections[defType] = dataCollection;
        }
        public void CompilaCorrelati(string nomeArch)
        {
            if (!DataCollections.ContainsKey(nomeArch))
            {
                Console.WriteLine($"Archivio {nomeArch} non trovato.");
                return;
            }

            if (!metadata.ContainsKey(nomeArch))
            {
                Console.WriteLine($"Metadati per l'archivio {nomeArch} non trovati.");
                return;
            }

            var dataCollection = DataCollections[nomeArch];

            foreach (var record in dataCollection.DataCollection)
            {
                foreach (var field in record.Keys.ToList())
                {// Controlla se "nomeArch" esiste in metadata
                    if (metadata.ContainsKey(nomeArch) && metadata[nomeArch].ContainsKey(field)) // serve in caso un campo venga eliminato da definizione dati ma esiste  nell'XML
                    if (metadata[nomeArch][field].ContainsKey("Correlato"))
                    {
                        try
                        {
                            var correlatoInfo = (JArray)metadata[nomeArch][field]["Correlato"];
                            string correlatoArchivio = correlatoInfo[0].ToString();
                            string correlatoChiaveArchivio = correlatoInfo[1].ToString();
                            string correlatoCampoChiave = correlatoInfo[2].ToString();
                            string correlatoCampoValore = correlatoInfo[3].ToString();

                            if (!DataCollections.ContainsKey(correlatoArchivio))
                            {
                                Console.WriteLine($"Archivio correlato {correlatoArchivio} non trovato.");
                                return; // Se preferisci interrompere l'esecuzione del codice in questo punto.
                            }

                            var correlatoDataCollection = DataCollections[correlatoArchivio];
                                if (!record.ContainsKey(correlatoChiaveArchivio) || record[correlatoChiaveArchivio] == null)
                                {
                                    Console.WriteLine($"Chiave '{correlatoChiaveArchivio}' non trovata nel record o valore nullo.");
                                    continue;
                                }

                                string chiaveValore = record[correlatoChiaveArchivio].ToString();

                                if (string.IsNullOrWhiteSpace(chiaveValore) || chiaveValore == Nullcombo)
                                {
                                    record[field] = ""; // << Qui lo azzeri esplicitamente
                                    continue;           // E poi salti la compilazione
                                }
                                var correlatoRecord = correlatoDataCollection.DataCollection
                                .FirstOrDefault(r => r.ContainsKey(correlatoCampoChiave) && r[correlatoCampoChiave].ToString() == chiaveValore);

                            if (correlatoRecord != null && correlatoRecord.ContainsKey(correlatoCampoValore))
                            {
                                record[field] = correlatoRecord[correlatoCampoValore];
                            }
                        }
                        catch (Exception ex)
                        {
                            // Nessuna eccezione rilanciata, ma possiamo eventualmente loggare l'errore.
                            Console.WriteLine($"Si è verificato un errore: {ex.Message}");
                        }

                    }
                }
            }
        }
        public List<string> DifferentValue(string Nomedb, string campo)
        {
            // Ottieni la collezione dal database
            ObservableCollection<Dictionary<string, object>> collection = GetCollection(Nomedb);

            // Usa un HashSet per mantenere solo i valori unici
            HashSet<string> uniqueValues = new HashSet<string>();

            foreach (var item in collection)
            {
                // Controlla se il campo esiste e non è null
                if (item.ContainsKey(campo) && item[campo] != null)
                {
                    uniqueValues.Add(item[campo].ToString().Trim());
                }
            }

            // Converte l'HashSet in una lista e la restituisce
            return uniqueValues.ToList();
        }
        public void  PopolaComboBox(ComboBox comboBox, string Nomedb, string campo)
        {
            // Ottieni i valori distinti dal database
            List<string> valoriUnici = DifferentValue(Nomedb, campo);

            // Svuota il ComboBox prima di riempirlo
            comboBox.Items.Clear();

            // Aggiungi i valori unici alla ComboBox
            foreach (string valore in valoriUnici)
            {
                comboBox.Items.Add(valore);
            }

            // Se ci sono elementi nella lista, seleziona il primo valore valido
            if (valoriUnici.Count > 0)
            {
                comboBox.SelectedIndex = 0; // Seleziona il primo elemento
            }
        }
        private string PrendiIlPrimoValoreDaArchivio(string nomeArchivio, string nomeCampo)
        {
            var col = Database.DB.GetCollection(nomeArchivio);

            if (col == null || col.Count == 0)
                return null;

            foreach (var riga in col)
            {
                if (riga.TryGetValue(nomeCampo, out var val) && !string.IsNullOrWhiteSpace(val?.ToString()))
                {
                    return val.ToString();
                }
            }

            return null; // Nessun valore trovato
        }
 
        public void AutocompilaDatiCad()
        {
            var colDatiCad = Database.DB.GetCollection("DatiCad");
            if (colDatiCad == null || colDatiCad.Count == 0)
                return;

            bool CampoVuotoOSeleziona(object valore)
            {
                var str = valore?.ToString()?.Trim();
                return string.IsNullOrWhiteSpace(str) || str == "-Seleziona-";
            }

            // === Auto-compilazione campo "Piano" ===
            string pianoDefault = PrendiIlPrimoValoreDaArchivio("Piani", "Nome");
            if (!string.IsNullOrWhiteSpace(pianoDefault))
            {
                foreach (var riga in colDatiCad)
                {
                    if (!riga.TryGetValue("Piano", out var val) || CampoVuotoOSeleziona(val))
                        riga["Piano"] = pianoDefault;
                }
            }


            // === Auto-compilazione campo "TipoFinestra" ===
            string tipoFinestraDefault = PrendiIlPrimoValoreDaArchivio("Finestre", "DescBreve");
            if (!string.IsNullOrWhiteSpace(tipoFinestraDefault))
            {
                foreach (var riga in colDatiCad)
                {
                    if (!riga.TryGetValue("TipoFinestra", out var val) || CampoVuotoOSeleziona(val))
                        riga["TipoFinestra"] = tipoFinestraDefault;
                }
            }

            // === Auto-compilazione campo "TipoParete" ===
            string tipoPareteDefault = PrendiIlPrimoValoreDaArchivio("Pareti", "DescBreve");
            if (!string.IsNullOrWhiteSpace(tipoPareteDefault))
            {
                foreach (var riga in colDatiCad)
                {
                    if (!riga.TryGetValue("TipoParete", out var val) || CampoVuotoOSeleziona(val))
                        riga["TipoParete"] = tipoPareteDefault;
                }
            }

            // === Auto-compilazione campo "TipoPonte" ===
            string tipoPonteDefault = PrendiIlPrimoValoreDaArchivio("Ponti", "DescBreve");
            if (!string.IsNullOrWhiteSpace(tipoPonteDefault))
            {
                foreach (var riga in colDatiCad)
                {
                    if (!riga.TryGetValue("TipoPonte", out var val) || CampoVuotoOSeleziona(val))
                        riga["TipoPonte"] = tipoPonteDefault;
                }
            }

            // === Auto-compilazione campi "Confine..." ===
            string[] campiConfineAutomatico = { "ConfineParete", "ConfineSoffitto" };

            foreach (var riga in colDatiCad)
            {
                foreach (var campo in campiConfineAutomatico)
                {
                    if (!riga.TryGetValue(campo, out var val) || CampoVuotoOSeleziona(val))
                        riga[campo] = "Automatico";
                }

                if (!riga.TryGetValue("ConfineSoffittoAutomatico", out var valSoff) || CampoVuotoOSeleziona(valSoff))
                    riga["ConfineSoffittoAutomatico"] = "Esterno";

                if (!riga.TryGetValue("ConfinePavimentoAutomatico", out var valPav) || CampoVuotoOSeleziona(valPav))
                    riga["ConfinePavimentoAutomatico"] = "Terreno";
            }

            // === Auto-compilazione campo "Zona" ===
            string zonaDefault = PrendiIlPrimoValoreDaArchivio("Zone", "Descrizione");
            if (!string.IsNullOrWhiteSpace(zonaDefault))
            {
                foreach (var riga in colDatiCad)
                {
                    if (!riga.TryGetValue("Zona", out var val) || CampoVuotoOSeleziona(val))
                        riga["Zona"] = zonaDefault;
                }
            }

            // === Auto-compilazione campo "TipoSoffitto" ===
            string tipoSoffittoDefault = PrendiIlPrimoValoreDaArchivio("Pareti", "DescBreve");
            if (!string.IsNullOrWhiteSpace(tipoSoffittoDefault))
            {
                foreach (var riga in colDatiCad)
                {
                    if (!riga.TryGetValue("TipoSoffitto", out var val) || CampoVuotoOSeleziona(val))
                        riga["TipoSoffitto"] = tipoSoffittoDefault;
                }
            }

            // === Auto-compilazione campo "TipoPavimento" ===
            string tipoPavimentoDefault = PrendiIlPrimoValoreDaArchivio("Pareti", "DescBreve");
            if (!string.IsNullOrWhiteSpace(tipoPavimentoDefault))
            {
                foreach (var riga in colDatiCad)
                {
                    if (!riga.TryGetValue("TipoPavimento", out var val) || CampoVuotoOSeleziona(val))
                        riga["TipoPavimento"] = tipoPavimentoDefault;
                }
            }
            CompilaCorrelati("DatiCad");
        }


        public void VerificaAttributoArchivio(string nomeblocco, string nomeattributo, Dictionary<string, object> blocco,string valore, string archivio, string chiave,double quotapiano)
        {
            if (GetDataDB(chiave, valore, chiave, GetCollection(archivio)) == null)
                HelixDXF.I.ErroreConGrafica($"L'attributo {nomeattributo} del blocco {nomeblocco} ( pallino rosso grande ), non trova riscontro nell'archivio {archivio}",null, quotapiano, blocco);
        }

        public string GetDataDB(string KeyField, string FindData, string ReturnField, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> DataCollection)
        {
            string result = null;

            foreach (var item in DataCollection)
            {
                // Verifica se il dizionario contiene la chiave specificata
                if (item.ContainsKey(KeyField))
                {
                    // Controlla se il valore di KeyField è non-null e se FindData è non-null prima di eseguire ToString e Trim
                    var keyValue = item[KeyField]?.ToString();
                    if (keyValue != null && FindData != null && keyValue.Trim() == FindData.Trim())
                    {
                        // Se la chiave ReturnField esiste, assegna il suo valore a result
                        result = item.ContainsKey(ReturnField)
                        ? (item[ReturnField] is double numericValue
                        ? numericValue.ToString(CultureInfo.InvariantCulture)
                        : item[ReturnField]?.ToString())
                        : string.Empty;
                        break; // Trovata corrispondenza, esci dal ciclo
                    }
                }
            }

            // Se result è ancora vuoto, nessuna corrispondenza è stata trovata
            if (string.IsNullOrEmpty(result))
            {
                result = null;
                //result = $"{ReturnField} con {KeyField} = {FindData} non trovato nella collezione.";
                //MessageBox.Show(result); // Visualizza un messaggio all'utente
            }

            return result; // Restituisci il valore trovato o il messaggio di errore se non trovato
        }

        public string GetDataDBSingleRow(string ReturnField, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> DataCollection)
        {
            string result = "";

            if (DataCollection != null && DataCollection.Count > 0)
            {
                // Ottiene il primo elemento (prima riga)
                var firstRow = DataCollection[0];

                // Verifica se la chiave ReturnField esiste nella prima riga
                if (firstRow.ContainsKey(ReturnField))
                {
                    result = firstRow[ReturnField]?.ToString() ?? string.Empty;
                }
                else
                {
                    result = $"Il campo '{ReturnField}' non è stato trovato nella prima riga della collezione.";
                    MessageBox.Show(result);
                }
            }
            else
            {
                result = "La collezione è vuota o null.";
                MessageBox.Show(result);
            }

            return result; // Restituisce il valore trovato o un messaggio di errore
        }
        public void LoadData(string nomeArch)
        {
            if (DataCollections.ContainsKey(nomeArch))
            {
                var dataCollection = DataCollections[nomeArch];
                //if (!dataCollection.Loaded)
                {
                    string filePath = Path.Combine(PathDatiDB, $"{nomeArch}.xml");
                    LoadRecordFromXml(filePath, dataCollection.DataCollection);
                    dataCollection.Loaded = true;
                }
            }
        }
        public void SaveData(string nomeArch)
        {
            string filePath = Path.Combine(PathDatiDB, $"{nomeArch}.xml");
            SaveRecordToXml(GetCollection(nomeArch), filePath);
        }
        public void SaveAllData()
        {
            foreach (var dataCollection in DataCollections.Values)
            {
                dataCollection.Loaded = false;
                SaveData(dataCollection.NomeArch);
            }
        }
        public void LoadAllData()
        {
            foreach (var dataCollection in DataCollections.Values)
            {
                dataCollection.Loaded = false;
                LoadData(dataCollection.NomeArch);
            }
        }

        public void InitCollection_riga(string nomeArch, int rigaIndex)
        {
            // Ottiene la collezione corrispondente
            ObservableCollection<Dictionary<string, object>> collection = GetCollection(nomeArch);

            if (collection == null)
            {
                Console.WriteLine($"Archivio non trovato: {nomeArch}");
                return;
            }

            // Ottiene il modello di dati per l'archivio
            var recordMetadata = GetRecordMetadata(nomeArch);
            if (recordMetadata == null)
            {
                Console.WriteLine($"Nessun metadato trovato per l'archivio: {nomeArch}");
                return;
            }

            // Aggiunge nuove righe vuote fino a raggiungere l'indice desiderato
            while (collection.Count <= rigaIndex)
            {
                Dictionary<string, object> newRecord = new Dictionary<string, object>();

                foreach (var field in recordMetadata)
                {
                    string fieldName = field.Key;
                    var fieldMetadata = field.Value;

                    if (fieldMetadata.ContainsKey("Tipo"))
                    {
                        string fieldType = fieldMetadata["Tipo"].ToString();
                        switch (fieldType)
                        {
                            case "int":
                                newRecord[fieldName] = 0;
                                break;
                            case "double":
                                newRecord[fieldName] = 0.0;
                                break;
                            case "string":
                                newRecord[fieldName] = "";
                                break;
                            default:
                                newRecord[fieldName] = null;
                                break;
                        }
                    }
                    else
                    {
                        newRecord[fieldName] = null;
                    }
                }

                collection.Add(newRecord);
            }
        }

        public void InitCollection(string nomeArch)
        {
            // Ottiene la collezione corrispondente
            ObservableCollection<Dictionary<string, object>> collection = GetCollection(nomeArch);

            // Verifica se la collezione è vuota
            if (collection != null && collection.Count == 0)
            {
                // Ottiene il modello di dati per l'archivio
                var recordMetadata = GetRecordMetadata(nomeArch);

                if (recordMetadata == null)
                {
                    Console.WriteLine($"Nessun metadato trovato per l'archivio: {nomeArch}");
                    return;
                }

                // Crea un nuovo record con i campi vuoti
                Dictionary<string, object> newRecord = new Dictionary<string, object>();

                foreach (var field in recordMetadata)
                {
                    string fieldName = field.Key;
                    var fieldMetadata = field.Value;

                    // Imposta il valore di default in base al tipo di campo
                    if (fieldMetadata.ContainsKey("Tipo"))
                    {
                        string fieldType = fieldMetadata["Tipo"].ToString();
                        switch (fieldType)
                        {
                            case "int":
                                newRecord[fieldName] = 0;
                                break;
                            case "double":
                                newRecord[fieldName] = 0.0;
                                break;
                            case "string":
                                newRecord[fieldName] = "";
                                break;
                            default:
                                newRecord[fieldName] = null; // Valore di default per tipi non specificati
                                break;
                        }
                    }
                    else
                    {
                        newRecord[fieldName] = null; // Valore di default se il tipo non è specificato
                    }
                }

                // Aggiunge il nuovo record alla collezione
                collection.Add(newRecord);
            }
        }
        public void CompilaGridComboItems(DataGridComboBoxColumn comboBoxColumn, string nomeArch, string nomeCampo,string FirstItem)
        {
            // Verifica se il dizionario contiene il nome dell'archivio specificato
            if (DataCollections.ContainsKey(nomeArch))
            {
                // Ottieni la collezione di dati corrispondente
                var dataCollection = DataCollections[nomeArch].DataCollection;

                if (!DataCollections[nomeArch].Loaded)
                {
                    string filePath = Path.Combine(PathDatiDB, $"{nomeArch}.xml");
                    LoadRecordFromXml(filePath, dataCollection);
                    DataCollections[nomeArch].Loaded = true;
                }

                // Crea una lista per gli elementi del ComboBox
                List<string> comboItems = new List<string>();
                if (FirstItem!="") comboItems.Add(FirstItem);
                // Itera attraverso la collezione di dati
                foreach (var record in dataCollection)
                {
                    // Verifica se il record contiene il campo specificato
                    if (record.ContainsKey(nomeCampo))
                    {
                        // Aggiungi il valore del campo alla lista degli elementi
                        if (record[nomeCampo] is string fieldValue)
                        {
                            comboItems.Add(fieldValue);
                        }
                    }
                }

                // Imposta gli elementi del ComboBoxColumn
                comboBoxColumn.ItemsSource = comboItems;

                // Imposta il membro da visualizzare nel ComboBox utilizzando l'EditingElementStyle
                // Non è necessario impostare EditingElementStyle o DisplayMemberPath/SelectedValuePath
                // perché stai usando una lista di stringhe semplice.
                //comboBoxColumn.EditingElementStyle = new Style(typeof(ComboBox));
                //comboBoxColumn.EditingElementStyle.Setters.Add(new Setter(ComboBox.DisplayMemberPathProperty, nomeCampo));
                //comboBoxColumn.EditingElementStyle.Setters.Add(new Setter(ComboBox.SelectedValuePathProperty, nomeCampo));
            }
            else
            {
                // Gestisci il caso in cui l'archivio specificato non esista
                throw new ArgumentException($"L'archivio {nomeArch} non esiste.");
            }
        }
        public static string Nullcombo = "-Seleziona-";
        public void CompilaComboItems(ComboBox comboBox, string nomeArch, string nomeCampo, string FirstItem)
        {
            // Verifica se il dizionario contiene il nome dell'archivio specificato
            if (DataCollections.ContainsKey(nomeArch))
            {

                // Ottieni la collezione di dati corrispondente
                var dataCollection = DataCollections[nomeArch].DataCollection;

                if (!DataCollections[nomeArch].Loaded)
                {
                 string filePath = Path.Combine(PathDatiDB, $"{nomeArch}.xml");
                 LoadRecordFromXml(filePath, dataCollection);
                 DataCollections[nomeArch].Loaded = true;
                }
                // Crea una lista per gli elementi del ComboBox
                List<string> comboItems = new List<string> { Nullcombo };
                if (FirstItem != "") comboItems.Add(FirstItem);
                // Itera attraverso la collezione di dati
                foreach (var record in dataCollection)
                {
                    // Verifica se il record contiene il campo specificato
                    if (record.ContainsKey(nomeCampo))
                    {
                        // Aggiungi il valore del campo alla lista degli elementi
                        if (record[nomeCampo] is string fieldValue)
                        {
                            comboItems.Add(fieldValue);
                        }
                    }
                }

                // Imposta gli elementi del ComboBox
                comboBox.ItemsSource = comboItems;
            }
            else
            {
                // Gestisci il caso in cui l'archivio specificato non esista
                throw new ArgumentException($"L'archivio {nomeArch} non esiste.");
            }
        }
        public void LeggiForm(string nomeArch, Grid grid, int riga)
        {
            if (DataCollections.ContainsKey(nomeArch))
            {
                Data_Collection dataCollection = DataCollections[nomeArch];

                if (riga >= 0 && riga < dataCollection.DataCollection.Count)
                {
                    //var dict = dataCollection.DataCollection[riga];
                    var dictOriginale = dataCollection.DataCollection[riga];
                    var dict = new Dictionary<string, object>(dictOriginale);

                    foreach (var kvp in dict)
                    {
                        string key = kvp.Key;
                        object value = kvp.Value;

                        string controlName = $"{nomeArch}_{key}";
                        FrameworkElement control = grid.FindName(controlName) as FrameworkElement;

                        if (control != null)
                        {
                            // Mostra il valore del dizionario nei controlli della form
                            if (control is TextBlock textBlock)
                            {
                                textBlock.Text = value?.ToString() ?? "";
                            }
                            else if (control is TextBox textBox)
                            {
                                textBox.Text = value?.ToString() ?? "";
                            }
                            else if (control is CheckBox checkBox)
                            {
                                checkBox.IsChecked = (bool?)value ?? false;
                            }
                            else if (control is ComboBox comboBox)
                            {
                                comboBox.SelectedValue = value?.ToString();
                                //comboBox.SelectedItem = value;
                            }
                            // Aggiungi altre condizioni per gestire altri tipi di controllo se necessario
                        }
                    }
                }
                else
                {
                    Console.WriteLine($"Indice di riga {riga} non valido.");
                }
            }
            else
            {
                Console.WriteLine($"Archivio {nomeArch} non trovato.");
            }
        }

        public void SalvaForm(string nomeArch, Grid grid, int riga)
        {
            if (DataCollections.ContainsKey(nomeArch))
            {
                Data_Collection dataCollection = DataCollections[nomeArch];

                if (riga >= 0 && riga < dataCollection.DataCollection.Count)
                {
                    var dict = dataCollection.DataCollection[riga];
                    UpdateDictionaryFromGrid(grid, nomeArch, dict);

                    // Ora puoi aggiornare la riga nella collezione di dati
                    dataCollection.DataCollection[riga] = dict;
                }
                else
                {
                    Console.WriteLine($"Indice di riga {riga} non valido.");
                }
            }
            else
            {
                Console.WriteLine($"Archivio {nomeArch} non trovato.");
            }
        }

        private void UpdateDictionaryFromGrid(DependencyObject parent, string nomeArch, Dictionary<string, object> dict)
        {
            for (int i = 0; i < VisualTreeHelper.GetChildrenCount(parent); i++)
            {
                var child = VisualTreeHelper.GetChild(parent, i);
                if (child is FrameworkElement control)
                {
                    string controlName = control.Name;

                    if (controlName.StartsWith($"{nomeArch}_"))
                    {
                        string key = controlName.Substring($"{nomeArch}_".Length);

                        // Aggiorna o aggiungi il campo nella collezione
                        if (control is TextBox textBox)
                        {
                            dict[key] = textBox.Text;
                        }
                        else if (control is CheckBox checkBox)
                        {
                            dict[key] = checkBox.IsChecked;
                        }
                        else if (control is ComboBox comboBox)
                        {
                            dict[key] = comboBox.SelectedItem;
                        }
                        // Aggiungi altre condizioni per gestire altri tipi di controllo se necessario
                    }
                }

                // Ricorsione sui figli
                UpdateDictionaryFromGrid(child, nomeArch, dict);
            }
        }
        public object DatoDB(string Arch, string field)
        {
            object value = null;

            if (DataCollections.ContainsKey(Arch))
            {
                Data_Collection dataCollection = DataCollections[Arch];

                // Supponendo che ogni riga sia rappresentata da un dizionario con chiave string e valore object
                foreach (var dict in dataCollection.DataCollection)
                {
                    if (dict.ContainsKey(field))
                    {
                        value = dict[field];
                        break;
                    }
                }
            }
            else
            {
                Console.WriteLine($"Archivio {Arch} non trovato.");
            }

            return value;
        }
        /*
        public void SalvaForm(string nomeArch, Grid grid, int riga)
        {
            if (DataCollections.ContainsKey(nomeArch))
            {
                Data_Collection dataCollection = DataCollections[nomeArch];

                if (riga >= 0 && riga < dataCollection.DataCollection.Count)
                {
                    var dict = dataCollection.DataCollection[riga];

                    foreach (var kvp in dict)
                    {
                        string key = kvp.Key;
                        object value = kvp.Value;

                        string controlName = $"{nomeArch}_{key}";
                        FrameworkElement control = grid.FindName(controlName) as FrameworkElement;

                        if (control != null)
                        {
                            // Ottieni il valore dal controllo e aggiornalo nel dizionario
                            if (control is TextBox textBox)
                            {
                                dict[key] = textBox.Text;
                            }
                            else if (control is CheckBox checkBox)
                            {
                                dict[key] = checkBox.IsChecked;
                            }
                            else if (control is ComboBox comboBox)
                            {
                                dict[key] = comboBox.SelectedItem;
                            }
                            // Aggiungi altre condizioni per gestire altri tipi di controllo se necessario
                        }
                    }

                    // Ora puoi aggiornare la riga nella collezione di dati
                    dataCollection.DataCollection[riga] = dict;
                }
                else
                {
                    Console.WriteLine($"Indice di riga {riga} non valido.");
                }
            }
            else
            {
                Console.WriteLine($"Archivio {nomeArch} non trovato.");
            }
        }
        */
        public void BindForm(string nomeArch, Grid grid, int riga)
        {
            if (DataCollections.ContainsKey(nomeArch))
            {
                Data_Collection dataCollection = DataCollections[nomeArch];

                if (riga >= 0 && riga < dataCollection.DataCollection.Count)
                {
                    var dict = dataCollection.DataCollection[riga];

                    foreach (var kvp in dict)
                    {
                        string key = kvp.Key;
                        object value = kvp.Value;

                        string controlName = $"{nomeArch}_{key}";
                        FrameworkElement control = grid.FindName(controlName) as FrameworkElement;

                        if (control != null)
                        {
                            // Configura il binding dinamico in base al tipo di controllo
                            Binding binding = new Binding(key)
                            {
                                Mode = BindingMode.TwoWay,
                                Source = dict // Imposta il dizionario come sorgente del binding
                            };

                            // Applica il binding al controllo appropriato
                            if (control is TextBlock textBlock)
                            {
                                textBlock.SetBinding(TextBlock.TextProperty, binding);
                            }
                            else if (control is TextBox textBox)
                            {
                                textBox.SetBinding(TextBox.TextProperty, binding);
                            }
                            else if (control is CheckBox checkBox)
                            {
                                checkBox.SetBinding(CheckBox.IsCheckedProperty, binding);
                            }
                            else if (control is ComboBox comboBox)
                            {
                                comboBox.SetBinding(ComboBox.ItemsSourceProperty, new Binding(key));
                                comboBox.SetBinding(ComboBox.SelectedItemProperty, new Binding(key) { Mode = BindingMode.TwoWay });
                                comboBox.ItemsSource = value as ObservableCollection<string>;
                            }
                            // Aggiungi altre condizioni per gestire altri tipi di controllo se necessario
                        }
                    }
                }
                else
                {
                    Console.WriteLine($"Indice di riga {riga} non valido.");
                }
            }
            else
            {
                Console.WriteLine($"Archivio {nomeArch} non trovato.");
            }
        }

        private void LoadMetadata(string filePath)
        {
            try
            {
                string jsonContent = File.ReadAllText(filePath);
                metadata = JsonConvert.DeserializeObject<Dictionary<string, Dictionary<string, Dictionary<string, object>>>>(jsonContent);
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore durante il caricamento dei metadati: {ex.Message}");
                metadata = new Dictionary<string, Dictionary<string, Dictionary<string, object>>>();
            }
        }

        public Dictionary<string, object> GetFieldMetadata(string recordType, string fieldName)
        {
            if (metadata.ContainsKey(recordType) && metadata[recordType].ContainsKey(fieldName))
            {
                return metadata[recordType][fieldName];
            }
            return null; // Valore di default o gestione dell'errore
        }

        public Dictionary<string, Dictionary<string, object>> GetRecordMetadata(string recordType)
        {
            if (metadata.ContainsKey(recordType))
            {
                return metadata[recordType];
            }
            return null; // Valore di default o gestione dell'errore
        }
        [Serializable]
        public class KeyValuePair
        {
            [XmlAttribute]
            public string Key { get; set; }
            [XmlElement]
            public object Value { get; set; }
        }
        [Serializable]
        public class RecordContainer : INotifyPropertyChanged
        {
            private Dictionary<string, object> _fields;

            [XmlIgnore]
            public Dictionary<string, object> Fields
            {
                get => _fields;
                set
                {
                    if (_fields != value)
                    {
                        _fields = value;
                        OnPropertyChanged(nameof(Fields));
                    }
                }
            }

            public RecordContainer()
            {
                _fields = new Dictionary<string, object>();
            }

            public event PropertyChangedEventHandler PropertyChanged;

            protected void OnPropertyChanged(string propertyName)
            {
                PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
            }

            public object this[string key]
            {
                get => Fields.ContainsKey(key) ? Fields[key] : null;
                set
                {
                    if (Fields.ContainsKey(key))
                    {
                        if (Fields[key] != value)
                        {
                            Fields[key] = value;
                            OnPropertyChanged(nameof(Fields));
                        }
                    }
                    else
                    {
                        Fields.Add(key, value);
                        OnPropertyChanged(nameof(Fields));
                    }
                }
            }

            // Metodo per supportare la serializzazione del dizionario
            [XmlElement("Field")]
            public List<KeyValuePair> FieldsSerialization
            {
                get
                {
                    var list = new List<KeyValuePair>();
                    foreach (var kvp in _fields)
                    {
                        list.Add(new KeyValuePair() { Key = kvp.Key, Value = kvp.Value });
                    }
                    return list;
                }
                set
                {
                    _fields = new Dictionary<string, object>();
                    foreach (var entry in value)
                    {
                        _fields[entry.Key] = entry.Value;
                    }
                }
            }
        }
        public (double Width, double Height) DimForm(Grid grid, double margin = 20)
        {
            double maxWidth = 0;
            double totalHeight = 0;

            foreach (UIElement element in grid.Children)
            {
                if (element is StackPanel stackPanel)
                {
                    double stackPanelWidth = 0;
                    double stackPanelHeight = 0;

                    foreach (UIElement child in stackPanel.Children)
                    {
                        if (child is FrameworkElement control)
                        {
                            double childWidth = control.ActualWidth + control.Margin.Left + control.Margin.Right;
                            double childHeight = control.ActualHeight + control.Margin.Top + control.Margin.Bottom;

                            stackPanelWidth = Math.Max(stackPanelWidth, childWidth);
                            stackPanelHeight += childHeight + margin;
                        }
                    }

                    totalHeight += Math.Max(stackPanelHeight, stackPanel.Height);
                    maxWidth = Math.Max(maxWidth, stackPanelWidth);
                }
            }

            // Aggiungi un margine estetico
             double outerMargin = 2 * margin;
            maxWidth += outerMargin;
            totalHeight += outerMargin;

            return (maxWidth, totalHeight);
        }
        public void ConfigureForm(Grid formGrid, string recordType)
        {
            string Daticadcollection = "";
            try
            {
                var recordMetadata = GetRecordMetadata(recordType);

                if (recordMetadata == null)
                {
                    Console.WriteLine($"Nessun metadato trovato per il tipo di record: {recordType}");
                    return;
                }

                foreach (var field in recordMetadata)
                {
                    
                    string fieldName = field.Key;
                    
                    var fieldMetadata = field.Value;

                    string controlName = $"{recordType}_{fieldName}";

                    FrameworkElement control = formGrid.FindName(controlName) as FrameworkElement;

                    if (control != null && fieldMetadata.ContainsKey("Combo"))
                    {
                        var comboItems = fieldMetadata["Combo"] as JArray;
                        if (comboItems != null)
                        {
                            if (comboItems.Count >= 3 && comboItems[0].ToString() == "auto_combo")
                            {
                                string nomeArchivio = comboItems[1].ToString();
                                string nomeCampo = comboItems[2].ToString();

                                if (control is ComboBox comboBox)
                                {

                                    /*
                                     // Imposta ItemsSource su null per svuotare la ComboBox prima di riassegnare nuovi elementi
                                     comboBox.ItemsSource = null;
                                     comboBox.Items.Clear();
                                     // Disattiva temporaneamente la ComboBox
                                     // Se ItemsSource è una collezione modificabile (come ObservableCollection), svuota la collezione
                                     comboBox.SelectedItem = null;
                                     if (comboBox.ItemsSource is IList itemsList)
                                     {
                                         // Svuota la collezione legata a ItemsSource
                                         itemsList.Clear();
                                     }
                                     comboBox.ItemsSource = null;
                                     */
                                    //if (ReferenceEquals(comboBox.ItemsSource, DataCollections[nomeArch].DataCollection))
                                    //{
                                      //  Console.WriteLine("⚠️ ItemsSource punta direttamente alla DataCollection! Evito Clear.");
                                    //}
                                    comboBox.ItemsSource = null;
                                    comboBox.Items.Clear();
                                    comboBox.SelectedItem = null;
                                    //Daticadcollection = GetCollectionAsString("DatiCad");
                                    string FirstItem = "";
                                    if (comboItems.Count >= 4)
                                        FirstItem = comboItems[3].ToString();
                                    
                                    CompilaComboItems(comboBox, nomeArchivio, nomeCampo, FirstItem);
                                    //Daticadcollection = GetCollectionAsString("DatiCad");
                                }
                                else
                                {
                                    Console.WriteLine($"Errore: il controllo per il campo {fieldName} non è un ComboBox.");
                                }
                            }
                            else
                            {
                                if (control is ComboBox comboBox)
                                {
                                    /*
                                    // Imposta ItemsSource su null per svuotare la ComboBox prima di riassegnare nuovi elementi
                                    //comboBox.Items.Clear();
                                    // Disattiva temporaneamente la ComboBox
                                    comboBox.SelectedItem = null;
                                    if (comboBox.ItemsSource is IList itemsList)
                                    {
                                        // Svuota la collezione legata a ItemsSource
                                        itemsList.Clear();
                                    }
                                    comboBox.ItemsSource = null;
                                    */
                                    comboBox.ItemsSource = null;
                                    comboBox.Items.Clear();
                                    comboBox.SelectedItem = null;

                                    var listaSicura = comboItems?.Select(x => x?.ToString() ?? "").ToList();
                                    comboBox.ItemsSource = listaSicura ?? new List<string>();

                                    //comboBox.ItemsSource = comboItems.ToObject<List<string>>();
                                    comboBox.DisplayMemberPath = "";
                                    comboBox.SelectedValuePath = "";
                                    
                                }
                                else
                                {
                                    Console.WriteLine($"Errore nel parsing della lista combo per il campo {fieldName}");
                                }
                            }
                        }
                    }
                    else
                    {
                        Console.WriteLine($"Controllo non trovato o campo {fieldName} non contiene Combo.");
                    }
                    //Daticadcollection = GetCollectionAsString("DatiCad");
                }
            }
            catch (Exception ex)
            {
                // Messaggio di errore personalizzato
                MessageBox.Show($"Non sono riuscito a configurare la form {recordType}: {ex.Message}");
            }
        }

        public bool ItemNessuno(string item)
        {
            return string.IsNullOrWhiteSpace(item) || item.Trim().ToLowerInvariant() == "nessuno";
        }


        public void ConfigureDataGrid(DataGrid dataGrid, string recordType)
        {
            var recordMetadata = GetRecordMetadata(recordType);

            if (recordMetadata == null)
            {
                Console.WriteLine($"Nessun metadato trovato per il tipo di record: {recordType}");
                return;
            }

            dataGrid.Columns.Clear();

            foreach (var field in recordMetadata)
            {
                string fieldName = field.Key;
                var fieldMetadata = field.Value;

                DataGridColumn column;

                if (fieldMetadata.ContainsKey("Combo"))
                {
                    var comboItems = fieldMetadata["Combo"] as JArray;
                    if (comboItems != null)
                    {
                        if ( comboItems.Count >= 3 && comboItems[0].ToString() == "auto_combo")
                        {
                            string nomeArchivio = comboItems[1].ToString();
                            string nomeCampo = comboItems[2].ToString();

                            var comboBoxColumn = new DataGridComboBoxColumn
                            {
                                Header = fieldName,
                                SelectedValueBinding = new Binding($"[{fieldName}]"),
                            };
                            string FirstItem = "";
                            if (comboItems.Count >= 4 ) FirstItem= comboItems[3].ToString();
                            CompilaGridComboItems(comboBoxColumn, nomeArchivio, nomeCampo, FirstItem);

                            column = comboBoxColumn;
                        }
                        else
                        {
                            column = new DataGridComboBoxColumn
                            {
                                Header = fieldName,
                                SelectedValueBinding = new Binding($"[{fieldName}]"),
                                ItemsSource = comboItems.ToObject<List<string>>(),
                                DisplayMemberPath = "", // Se gli elementi del combo sono semplici stringhe, lascia vuoto
                                SelectedValuePath = ""  // Se gli elementi del combo sono semplici stringhe, lascia vuoto
                            };
                        }
                    }
                    else
                    {
                        Console.WriteLine($"Errore nel parsing della lista combo per il campo {fieldName}");
                        continue;
                    }
                }
                else
                {
                    
                    column = new DataGridTextColumn
                    {
                        Header = fieldName,
                        Binding = new Binding($"[{fieldName}]")
                    };

                    if (fieldMetadata.ContainsKey("LunghezzaMassima"))
                    {
                        ((DataGridTextColumn)column).Width = Convert.ToDouble(fieldMetadata["LunghezzaMassima"]);
                    }

                    if (fieldMetadata.ContainsKey("NumeroCifre") || fieldMetadata.ContainsKey("NumeroDecimali"))
                    {
                        int numeroCifre = fieldMetadata.ContainsKey("NumeroCifre") ? Convert.ToInt32(fieldMetadata["NumeroCifre"]) : 0;
                        int numeroDecimali = fieldMetadata.ContainsKey("NumeroDecimali") ? Convert.ToInt32(fieldMetadata["NumeroDecimali"]) : 0;
                        string formatString = $"{{0:F{numeroDecimali}}}";
                        ((DataGridTextColumn)column).Binding.StringFormat = formatString;
                    }
                    
                }

                dataGrid.Columns.Add(column);
            }
        }
        public Dictionary<string, object> CreaRigaInizializzata(string recordType)
        {
            var recordMetadata = GetRecordMetadata(recordType);
            if (recordMetadata == null) return null;

            Dictionary<string, object> newRecord = new Dictionary<string, object>();

            foreach (var field in recordMetadata)
            {
                string fieldName = field.Key;
                var fieldMetadata = field.Value;

                if (fieldMetadata.ContainsKey("Ini"))
                {
                    newRecord[fieldName] = fieldMetadata["Ini"];
                }
                else if (fieldMetadata.ContainsKey("Combo"))
                {
                    var comboArray = fieldMetadata["Combo"] as JArray;

                    if (comboArray != null && comboArray.Count > 0 && comboArray[0].ToString() == "auto_combo")
                    {
                        newRecord[fieldName] = comboArray.Count > 3 ? comboArray[3].ToString() : null;
                    }
                    else
                    {
                        newRecord[fieldName] = null;
                    }
                }
                else
                {
                    newRecord[fieldName] = null;
                }
            }

            return newRecord;
        }
        public void AddEmptyRowToCollection(string recordType)
        {
            var itemsSource = GetCollection(recordType);
            if (itemsSource == null) return;

            var newRecord = CreaRigaInizializzata(recordType);
            if (newRecord != null)
                itemsSource.Add(newRecord);
        }



        public void AddEmptyRowToCollectionOld( string recordType)
        {
            var itemsSource = GetCollection(recordType);
            // Ottiene i metadati del record specificato
            var recordMetadata = GetRecordMetadata(recordType);

            if (recordMetadata == null)
            {
                Console.WriteLine($"Nessun metadato trovato per il tipo di record: {recordType}");
                return;
            }

            if (itemsSource == null)
            {
                Console.WriteLine("Collection nulla o non corretta.");
                return;
            }

            // Crea un nuovo Dictionary<string, object> e inizializza i campi
            Dictionary<string, object> newRecord = new Dictionary<string, object>();

            foreach (var field in recordMetadata)
            {
                string fieldName = field.Key;
                var fieldMetadata = field.Value;

                // Inizializza il campo con "Ini" se presente
                if (fieldMetadata.ContainsKey("Ini"))
                {
                    newRecord[fieldName] = fieldMetadata["Ini"];
                }
                else if (fieldMetadata.ContainsKey("Combo"))
                {
                    var comboArray = fieldMetadata["Combo"] as JArray;

                    if (comboArray != null && comboArray.Count > 0 && comboArray[0].ToString() == "auto_combo")
                    {
                        if (comboArray.Count > 3)
                        {
                            newRecord[fieldName] = comboArray[3].ToString();
                        }
                        else
                        {
                            newRecord[fieldName] = null;
                        }
                    }
                    else
                    {
                        newRecord[fieldName] = null;
                    }
                }
                else
                {
                    newRecord[fieldName] = null;
                }
            }

            // Aggiunge la riga alla collezione
            itemsSource.Add(newRecord);
        }


        public void AddEmptyRow(DataGrid dataGrid, string recordType)
        {
            // Ottiene i metadati del record specificato
            var recordMetadata = GetRecordMetadata(recordType);

            if (recordMetadata == null)
            {
                Console.WriteLine($"Nessun metadato trovato per il tipo di record: {recordType}");
                return;
            }

            // Ottiene l'ItemsSource del DataGrid come ObservableCollection<Dictionary<string, object>>
            var itemsSource = dataGrid.ItemsSource as ObservableCollection<Dictionary<string, object>>;

            if (itemsSource == null)
            {
                Console.WriteLine("ItemsSource is null or not of the expected type.");
                return;
            }

            // Crea un nuovo Dictionary<string, object> e inizializza i campi
            Dictionary<string, object> newRecord = new Dictionary<string, object>();

            foreach (var field in recordMetadata)
            {
                string fieldName = field.Key;
                var fieldMetadata = field.Value;

                // Inizializza il campo con il valore di "Ini" se esiste
                if (fieldMetadata.ContainsKey("Ini"))
                {
                    newRecord[fieldName] = fieldMetadata["Ini"];
                }
                else if (fieldMetadata.ContainsKey("Combo"))
                {
                    // Verifica se è un campo "auto_combo" con un valore aggiuntivo
                    var comboArray = fieldMetadata["Combo"] as JArray;
                    
                    if (comboArray != null && comboArray.Count > 0 && comboArray[0].ToString() == "auto_combo")
                    {
                        if (comboArray.Count > 3)
                        {
                            newRecord[fieldName] = comboArray[3].ToString(); 
                        }
                        else
                        {
                            newRecord[fieldName] = null;
                        }
                    }
                    else
                    {
                        newRecord[fieldName] = null;
                    }
                }
                else
                {
                    // Inizializza con null se non esiste "Ini" o "Combo"
                    newRecord[fieldName] = null;
                }
            }

            // Aggiungi il nuovo record alla collezione
            itemsSource.Add(newRecord);
        }


        public void SaveRecordToXml<T>(ObservableCollection<T> records, string filePath)
        {
            DataContractSerializer serializer = new DataContractSerializer(typeof(ObservableCollection<T>));

            using (XmlWriter writer = XmlWriter.Create(filePath, new XmlWriterSettings { Indent = true }))
            {
                serializer.WriteObject(writer, records);
            }
        }
        // Funzione per caricare i dati da un file XML in una ObservableCollection
        public void LoadRecordFromXml<T>(string filePath, ObservableCollection<T> collection)
        {
            if (!File.Exists(filePath))
            {
                // Se il file non esiste, restituisce una collezione vuota
                collection.Clear();
                return;
            }

            DataContractSerializer serializer = new DataContractSerializer(typeof(ObservableCollection<T>));

            using (XmlReader reader = XmlReader.Create(filePath))
            {
                var loadedData = (ObservableCollection<T>)serializer.ReadObject(reader);

                collection.Clear(); // Svuota la collezione esistente

                foreach (var item in loadedData)
                {
                    collection.Add(item); // Aggiunge gli elementi caricati alla collezione
                }
            }
        }
        public bool RemoveRecord<T>(DataGrid dataGrid, ObservableCollection<T> collection)
        {
            try
            {
                if (dataGrid == null)
                {
                    throw new ArgumentNullException(nameof(dataGrid), "Il DataGrid non può essere nullo.");
                }

                if (collection == null)
                {
                    throw new ArgumentNullException(nameof(collection), "La collezione non può essere nulla.");
                }

                T selectedItem = (T)dataGrid.SelectedItem;

                if (selectedItem != null)
                {
                    collection.Remove(selectedItem);
                    return true; // Ritorna true se l'elemento è stato rimosso con successo
                }

                return false; // Ritorna false se non è stato trovato l'elemento da rimuovere
            }
            catch (Exception ex)
            {
                // Gestire eventuali eccezioni qui, ad esempio:
                Console.WriteLine($"Errore nella rimozione dell'elemento: {ex.Message}");
                return false;
            }
        }
    }     
}

