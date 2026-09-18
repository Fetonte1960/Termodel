using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.IO;
using System.Windows.Controls;
using System.Windows;
using Termodel.utilities;
using System.Text.RegularExpressions;
using System.Windows.Shapes;
using System.Text;

namespace Termodel.Leggidxf
{
    public class ScriptCad
    {
        // Proprietà DriveScript che contiene il percorso degli script
        public string DriveScript { get; set; }

        // Costruttore che inizializza la proprietà DriveScript
        public ScriptCad()
        {
            DriveScript = GestProg.ProgramPath;
        }

        public static Dictionary<string, string> GetInstalledAutoCADVersionsold()
        {
            Dictionary<string, string> installedVersions = new Dictionary<string, string>();
            string registryKey = @"SOFTWARE\Autodesk\AutoCAD";

            using (RegistryKey key = Registry.LocalMachine.OpenSubKey(registryKey))
            {
                if (key != null)
                {
                    foreach (string subKeyName in key.GetSubKeyNames())
                    {
                        using (RegistryKey subKey = key.OpenSubKey(subKeyName))
                        {
                            if (subKey != null)
                            {
                                foreach (string versionKeyName in subKey.GetSubKeyNames())
                                {
                                    using (RegistryKey versionKey = subKey.OpenSubKey(versionKeyName))
                                    {
                                        if (versionKey != null)
                                        {
                                            string productName = (string)versionKey.GetValue("ProductName");
                                            string exePath = (string)versionKey.GetValue("AcadLocation");

                                            if (!string.IsNullOrEmpty(productName) && !string.IsNullOrEmpty(exePath))
                                            {
                                                installedVersions.Add(productName, exePath);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            return installedVersions;
        }
        public static Dictionary<string, string> GetInstalledAutoCADVersions()
        {
            Dictionary<string, string> installedVersions = new Dictionary<string, string>();

            string[] chiaviRicerca = new string[]
            {
        @"SOFTWARE\Autodesk\AutoCAD",
        @"SOFTWARE\WOW6432Node\Autodesk\AutoCAD",
        @"SOFTWARE\Autodesk\AutoCAD LT",
        @"SOFTWARE\WOW6432Node\Autodesk\AutoCAD LT"     
            };
   //         @"SOFTWARE\Autodesk\AutoCAD LT\R30\ACADLT-7101\Install"
   // Le versioi moderrne non vengono rilevate esaminare i registri con regedit
            foreach (string baseKey in chiaviRicerca)
            {
                TermodelLog.WriteLog($"📂 Scansione chiave: {baseKey}");

                using (RegistryKey key = Registry.LocalMachine.OpenSubKey(baseKey))
                {
                    if (key == null)
                    {
                        TermodelLog.WriteLog($"❌ Chiave non trovata: {baseKey}");
                        continue;
                    }

                    foreach (string subKeyName in key.GetSubKeyNames())
                    {
                        string subKeyPath = $@"{baseKey}\{subKeyName}";
                        using (RegistryKey subKey = key.OpenSubKey(subKeyName))
                        {
                            if (subKey == null)
                            {
                                TermodelLog.WriteLog($"⛔ Subchiave non accessibile: {subKeyPath}");
                                continue;
                            }

                            foreach (string versionKeyName in subKey.GetSubKeyNames())
                            {
                                string versionKeyPath = $@"{subKeyPath}\{versionKeyName}";
                                using (RegistryKey versionKey = subKey.OpenSubKey(versionKeyName))
                                {
                                    if (versionKey == null)
                                    {
                                        TermodelLog.WriteLog($"⛔ VersionKey non accessibile: {versionKeyPath}");
                                        continue;
                                    }

                                    string productName = versionKey.GetValue("ProductName") as string;
                                    string exePath = versionKey.GetValue("AcadLocation") as string
                                                   ?? versionKey.GetValue("InstallDir") as string;

                                    if (!string.IsNullOrEmpty(productName) && !string.IsNullOrEmpty(exePath))
                                    {
                                        TermodelLog.WriteLog($"✅ Trovato: {productName} in {exePath}");
                                        if (!installedVersions.ContainsKey(productName))
                                            installedVersions.Add(productName, exePath);
                                    }
                                    else
                                    {
                                        TermodelLog.WriteLog($"⚠️ Chiave incompleta: {versionKeyPath} — ProductName='{productName}', Path='{exePath}'");
                                    }
                                }
                            }
                        }
                    }
                }
            }

            TermodelLog.WriteLog($"📋 Totale versioni rilevate: {installedVersions.Count}");
            return installedVersions;
        }


        public static Dictionary<string, string> GetInstalledAutoCADVersions_old()
        {
            Dictionary<string, string> installedVersions = new Dictionary<string, string>();
            string registryKey = @"SOFTWARE\Autodesk\AutoCAD";

            using (RegistryKey key = Registry.LocalMachine.OpenSubKey(registryKey))
            {
                if (key != null)
                {
                    foreach (string subKeyName in key.GetSubKeyNames())
                    {
                        using (RegistryKey subKey = key.OpenSubKey(subKeyName))
                        {
                            if (subKey != null)
                            {
                                foreach (string versionKeyName in subKey.GetSubKeyNames())
                                {
                                    using (RegistryKey versionKey = subKey.OpenSubKey(versionKeyName))
                                    {
                                        if (versionKey != null)
                                        {
                                            string productName = (string)versionKey.GetValue("ProductName");
                                            string exePath = (string)versionKey.GetValue("AcadLocation");

                                            if (!string.IsNullOrEmpty(productName) && !string.IsNullOrEmpty(exePath))
                                            {
                                                installedVersions.Add(productName, exePath);
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            return installedVersions;
        }

        public void PopulateAutoCADVersionsComboBox(ComboBox comboBox)
        {
            Dictionary<string, string> installedVersions = GetInstalledAutoCADVersions();

            // Imposta ItemsSource a null prima di modificarlo
            comboBox.ItemsSource = null;

            // Pulisci gli elementi esistenti
            comboBox.Items.Clear();

            // Aggiungi le versioni installate al ComboBox
            foreach (var version in installedVersions.Keys)
            {
                comboBox.Items.Add(version);
            }

            // Seleziona il primo elemento come predefinito, se disponibile
            if (comboBox.Items.Count > 0)
            {
                comboBox.SelectedIndex = 0;
            }
        }
        public string FindAutoCADExecutablePath_old(string version)
        {
            var installedVersions = GetInstalledAutoCADVersions();
            if (installedVersions.ContainsKey(version))
            {
                string acadPath = installedVersions[version];
                string acadExecutable = System.IO.Path.Combine(acadPath, "acad.exe");

                if (File.Exists(acadExecutable))
                {
                    return acadExecutable;
                }
                else
                {
                    // Tentativo con un altro nome di eseguibile, nel caso in cui il primo non esista
                    acadExecutable = System.IO.Path.Combine(acadPath, "acadlt.exe");
                    if (File.Exists(acadExecutable))
                    {
                        return acadExecutable;
                    }
                }
            }

            return null;
        }

        public static string FindAutoCADExecutablePathold(int minVersion)
        {
            TermodelLog.WriteLog("Log");
            var installedVersions = GetInstalledAutoCADVersions();
            if (installedVersions.Count == 0)
            {
                return null; // Nessuna versione di AutoCAD trovata
            }

            
            // 🟢 Filtriamo solo le versioni di AutoCAD standard (NO LT)
            var autocadVersions = installedVersions
                .Where(v => IsAutoCADStandard(v.Key) && ExtractVersionNumber(v.Key) >= minVersion)
                .OrderByDescending(v => ExtractVersionNumber(v.Key))
                .ToList();

            // 🔵 Filtriamo solo le versioni di AutoCAD LT (ma solo se >= 2024)
            var autocadLTVersions = installedVersions
                .Where(v => IsAutoCADLT(v.Key) && ExtractVersionNumber(v.Key) >= 2024)
                .OrderByDescending(v => ExtractVersionNumber(v.Key))
                .ToList();


            // Proviamo prima AutoCAD standard
            foreach (var entry in autocadVersions)
            {
                string acadExecutable = System.IO.Path.Combine(entry.Value, "acad.exe");
                if (File.Exists(acadExecutable))
                {
                    return acadExecutable;
                }
            }

            // Se non troviamo AutoCAD normale, proviamo con AutoCAD LT
            foreach (var entry in autocadLTVersions)
            {
                string acadLTExecutable = System.IO.Path.Combine(entry.Value, "acadlt.exe");
                if (File.Exists(acadLTExecutable))
                {
                    return acadLTExecutable;
                }
            }

            return null; // Nessuna versione compatibile trovata
        }
        public static string FindAutoCADExecutablePath(int minVersion, int minLTVersion = 2024)
        {
            TermodelLog.WriteLog("🔍 Inizio ricerca AutoCAD - minVersion: " + minVersion + ", minLTVersion: " + minLTVersion);

            var installedVersions = GetInstalledAutoCADVersions();

            TermodelLog.WriteLog($"🔧 Versioni installate trovate: {installedVersions.Count}");

            if (installedVersions.Count == 0)
            {
                TermodelLog.WriteLog("❌ Nessuna versione di AutoCAD trovata.");
                return null;
            }

            // AutoCAD standard
            var autocadVersions = installedVersions
                .Where(v => IsAutoCADStandard(v.Key))
                .Select(v => new { Version = ExtractVersionNumber(v.Key), Path = v.Value, Label = v.Key })
                .Where(v => v.Version >= minVersion)
                .OrderByDescending(v => v.Version)
                .ToList();

            TermodelLog.WriteLog($"🟢 Versioni AutoCAD standard compatibili trovate: {autocadVersions.Count}");
            foreach (var v in autocadVersions)
                TermodelLog.WriteLog($"🟢 Standard: {v.Label} (v{v.Version}) in {v.Path}");

            // AutoCAD LT
            var autocadLTVersions = installedVersions
                .Where(v => IsAutoCADLT(v.Key))
                .Select(v => new { Version = ExtractVersionNumber(v.Key), Path = v.Value, Label = v.Key })
                .Where(v => v.Version >= minLTVersion)
                .OrderByDescending(v => v.Version)
                .ToList();

            TermodelLog.WriteLog($"🔵 Versioni AutoCAD LT compatibili trovate: {autocadLTVersions.Count}");
            foreach (var v in autocadLTVersions)
                TermodelLog.WriteLog($"🔵 LT: {v.Label} (v{v.Version}) in {v.Path}");

            // Verifica AutoCAD standard
            foreach (var entry in autocadVersions)
            {
                string path = System.IO.Path.Combine(entry.Path, "acad.exe");
                TermodelLog.WriteLog($"➡️ Verifica esistenza: {path}");
                if (File.Exists(path))
                {
                    TermodelLog.WriteLog($"✅ AutoCAD trovato: {path}");
                    return path;
                }
                TermodelLog.WriteLog($"⛔ File non trovato: {path}");
            }

            // Verifica AutoCAD LT
            foreach (var entry in autocadLTVersions)
            {
                string path = System.IO.Path.Combine(entry.Path, "acadlt.exe");
                TermodelLog.WriteLog($"➡️ Verifica esistenza: {path}");
                if (File.Exists(path))
                {
                    TermodelLog.WriteLog($"✅ AutoCAD LT trovato: {path}");
                    return path;
                }
                TermodelLog.WriteLog($"⛔ File non trovato: {path}");
            }

            TermodelLog.WriteLog("❌ Nessuna versione compatibile di AutoCAD (standard o LT) trovata.");
            return null;
        }

        public static string FindAutoCADExecutablePathold(int minVersion, int minLTVersion = 2024)
        {
            TermodelLog.WriteLog("🔍 Inizio ricerca AutoCAD - minVersion: " + minVersion + ", minLTVersion: " + minLTVersion);

            var installedVersions = GetInstalledAutoCADVersions();
            TermodelLog.WriteLog($"🔧 Versioni installate trovate: {installedVersions.Count}");

            if (installedVersions.Count == 0)
            {
                TermodelLog.WriteLog("❌ Nessuna versione di AutoCAD trovata.");
                return null;
            }

            // AutoCAD standard
            var autocadVersions = installedVersions
                .Where(v => IsAutoCADStandard(v.Key))
                .Select(v => new { Version = ExtractVersionNumber(v.Key), Path = v.Value, Label = v.Key })
                .Where(v => v.Version >= minVersion)
                .OrderByDescending(v => v.Version)
                .ToList();

            TermodelLog.WriteLog($"🟢 Versioni AutoCAD standard compatibili trovate: {autocadVersions.Count}");
            foreach (var v in autocadVersions)
                TermodelLog.WriteLog($"🟢 Standard: {v.Label} (v{v.Version}) in {v.Path}");

            // AutoCAD LT
            var autocadLTVersions = installedVersions
                .Where(v => IsAutoCADLT(v.Key))
                .Select(v => new { Version = ExtractVersionNumber(v.Key), Path = v.Value, Label = v.Key })
                .Where(v => v.Version >= minLTVersion)
                .OrderByDescending(v => v.Version)
                .ToList();

            TermodelLog.WriteLog($"🔵 Versioni AutoCAD LT compatibili trovate: {autocadLTVersions.Count}");
            foreach (var v in autocadLTVersions)
                TermodelLog.WriteLog($"🔵 LT: {v.Label} (v{v.Version}) in {v.Path}");

            // Prova AutoCAD standard
            foreach (var entry in autocadVersions)
            {
                string path = System.IO.Path.Combine(entry.Path, "acad.exe");
                TermodelLog.WriteLog($"➡️ Verifica esistenza: {path}");
                if (File.Exists(path))
                {
                    TermodelLog.WriteLog($"✅ AutoCAD trovato: {path}");
                    return path;
                }
                TermodelLog.WriteLog("⛔ File non trovato");
            }

            // Prova AutoCAD LT
            foreach (var entry in autocadLTVersions)
            {
                string path = System.IO.Path.Combine(entry.Path, "acadlt.exe");
                TermodelLog.WriteLog($"➡️ Verifica esistenza: {path}");
                if (File.Exists(path))
                {
                    TermodelLog.WriteLog($"✅ AutoCAD LT trovato: {path}");
                    return path;
                }
                TermodelLog.WriteLog("⛔ File non trovato");
            }

            TermodelLog.WriteLog("❌ Nessuna versione compatibile di AutoCAD (standard o LT) trovata.");
            return null;
        }

        private static bool IsVersionGreaterOrEqual(string foundVersion, string requiredVersion)
        {
            if (int.TryParse(foundVersion, out int found) && int.TryParse(requiredVersion, out int required))
            {
                return found >= required;
            }
            return false; // In caso di errore di parsing, restituiamo false
        }
        private static int ExtractVersionNumber(string productName)
        {
            var match = Regex.Match(productName, @"\b(20\d{2})\b");
            return match.Success ? int.Parse(match.Value) : 0;
        }
        private static bool IsAutoCADStandard(string productName)
        {
            return productName.StartsWith("AutoCAD") && !productName.Contains("LT");
        }

        // 📌 Controlla se il nome è una versione di AutoCAD LT
        private static bool IsAutoCADLT(string productName)
        {
            return productName.StartsWith("AutoCAD LT");
        }

        public static void GeneraScriptAvvio(
            string path,
            string cadPath,
            bool primaInstallazione)
        {
            try
            {
               string termodelPath = GestProg.ProgramPath;

                // Percorsi completi per Lisp e personalizzazione CUIX
                string lispPath = System.IO.Path.Combine(termodelPath, "termodel.lsp");
                string cuixPath = System.IO.Path.Combine(termodelPath, "termodel.cuix");

                string scriptContent;
                if (primaInstallazione)
                {
                    scriptContent = $@"
(setenv ""ACAD"" (strcat ""{termodelPath.Replace(@"\", @"\\")};"" (getenv ""ACAD"")))
(load ""{lispPath.Replace(@"\", @"\\")}"")
(setvar ""INSUNITS"" 4)
(setvar ""MEASUREMENT"" 1)
(command ""CARICAIUPERS"" ""{cuixPath.Replace(@"\", @"\\")}"")
";
                }
                else
                {
                    scriptContent = $@"
(load ""{lispPath.Replace(@"\", @"\\")}"")
";
                }

                if (SupportaPluginDotNet(cadPath))
                {
                    string pluginPath = System.IO.Path.Combine(
                        GestProg.ProgramPath,
                        "Plugin",
                        "Termodel.Plugin.AutoCAD.dll");

                    if (File.Exists(pluginPath))
                    {
                        scriptContent += $@"
_.NETLOAD
""{pluginPath}""
TERMODELFORM
";
                    }
                    else
                    {
                        TermodelLog.LogError(
                            $"Plugin AutoCAD non trovato in {pluginPath}. Avvio CAD senza plugin .NET.");
                    }
                }


                // Percorso completo per salvare il file startup.scr
                string scriptPath = path;

                // Scrive il file .scr
                File.WriteAllText(scriptPath, scriptContent);

                Console.WriteLine($"✅ File di script AutoCAD generato con successo: {scriptPath}");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"❌ Errore nella generazione dello script AutoCAD: {ex.Message}");
            }
        }

        private static bool SupportaPluginDotNet(string cadPath)
        {
            string eseguibile = System.IO.Path.GetFileNameWithoutExtension(cadPath);
            return string.Equals(
                eseguibile,
                "acad",
                StringComparison.OrdinalIgnoreCase);
        }
        public static bool ConfermaSettaggiAutocad()
        {
            // Testo della finestra di conferma
            string messaggio = "Termodel apporterà le seguenti modifiche alla configurazione di AutoCAD:\n\n" +
                               "✅ Aggiungerà un percorso di ricerca per i file Lisp e script.\n" +
                               "✅ Aggiungerà una personalizzazione (CUIX) per l'interfaccia.\n" +
                               "✅ Imposterà l'unità di inserimento blocchi su 'Metri'.\n\n" +
                               "❗ Queste modifiche sono necessarie per il corretto funzionamento di Termodel.\n\n" +
                               "Vuoi procedere con l'operazione?";

            // Mostra un messaggio di conferma con pulsanti OK/Annulla
            MessageBoxResult risultato = MessageBox.Show(
                messaggio,
                "⚙️ Configurazione AutoCAD",
                MessageBoxButton.OKCancel,
                MessageBoxImage.Question
            );

            // Restituisce true se l'utente conferma, false altrimenti
            return risultato == MessageBoxResult.OK;
        }
        private static bool IsFileLocked(string filePath)
        {
            try
            {
                using (FileStream stream = new FileStream(filePath, FileMode.Open, FileAccess.ReadWrite, FileShare.None))
                {
                    stream.Close();
                }
                return false; // Il file non è bloccato
            }
            catch (IOException)
            {
                return true; // Il file è bloccato
            }
        }
        public static  void StartCad(string cadPath, string dispath, bool primavolta)
        {
            
            try
            {
                if (!File.Exists(dispath))
                {
                    string sorgente = System.IO.Path.Combine(GestProg.ProgramPath, "modello.dxf");

                    if (File.Exists(sorgente))
                    {
                        // Copia il file modello nella destinazione prevista
                        File.Copy(sorgente, dispath);
                    }
                    else
                    {
                        // Mostra un messaggio di errore se il file modello non esiste
                        MessageBox.Show("File modello.dxf non trovato in " + sorgente, "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                        return; // Blocca l'esecuzione
                    }
                }
                // Controlla se il file è già aperto da un'altra applicazione
                if (IsFileLocked(dispath))
                {
                    MessageBox.Show("Il disegno è gia aperto nel CAD.Puoi continuare le modifiche ed usare il comando Salva della Toolbar per aggiornare il modello.",
                                    "Disegno già in elaborazione", MessageBoxButton.OK, MessageBoxImage.Warning);
                    return; // Esci senza aprire un altro AutoCAD
                }
                string scriptPath = System.IO.Path.Combine(GestProg.ProgramPath, "avviotermodel.scr");
                GeneraScriptAvvio(scriptPath, cadPath, primavolta);

                // Crea il processo con il percorso del CAD e il disegno da aprire come argomento
                ProcessStartInfo startInfo = new ProcessStartInfo
                {
                    FileName = cadPath,  // Eseguibile del CAD
                    
                    Arguments = $"\"{dispath}\" /b \"{scriptPath}\"",  // Passa il file DXF e uno script AutoCAD
                    UseShellExecute = true  // Necessario per avviare eseguibili di programmi esterni
                };

                Process.Start(startInfo);
            }
            catch (Exception ex)
            {
                System.Windows.MessageBox.Show($"Errore nell'avvio del CAD: {ex.Message}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
    
    public void OpenAutoCAD(string fileName, string acadPath)
        {
            //ConfermaSettaggiAutocad();
            try
            {
            // Avvia AutoCAD con il file specificato
            // Costruisce i parametri di avvio
            string args = $"\"{fileName}\" /lisp \"termodel\"";

            // Avvia AutoCAD con i parametri specificati
            System.Diagnostics.Process.Start(acadPath, args);
            //System.Diagnostics.Process.Start(acadPath, fileName);
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Errore durante l'apertura di AutoCAD: {ex.Message}");
            }
        }


        private string CleanColor(string colore)
        {
            // Cerca il primo spazio
            int spaceIndex = colore.IndexOf(' ');

            if (spaceIndex != -1)
            {
                // Se trovi uno spazio, estrai la parte numerica prima dello spazio
                string numeroColore = colore.Substring(0, spaceIndex);

                // Tenta di convertire il numero in un intero
                if (int.TryParse(numeroColore, out int result))
                {
                    return result.ToString();
                }
            }

            // Se non riesci a trovare uno spazio o non riesci a convertire in intero, ritorna il colore di default "1"
            return "1";
        }
        public enum TipoComandoEnum
        {
            Parete,
            Locale,
            Finestra,
            Ponte,
            Allinea,
            Nord,
            Colmo,
            Layer,
            Tubo,
            Dividi
            // Aggiungi altri tipi di comando se necessario
        }
        public string SostDataDB(System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> DataCollection, string InputStr)
        {
            try
            {
                if (DataCollection == null || DataCollection.Count == 0)
                {
                    Console.WriteLine("La collezione dati è vuota o nulla.");
                    return InputStr;
                }

                var dataRow = DataCollection[0];

                foreach (var key in dataRow.Keys)
                {
                    if (dataRow[key] != null)
                    {
                        string placeholder = $"{{{key}}}";
                        string value = dataRow[key].ToString();

                        if (key == "Colore")
                        {
                            InputStr = InputStr.Replace(placeholder, CleanColor(value));
                        }
                        else if ((key == "AltezzaNetta" || key == "AltezzaLorda") &&
                                 dataRow.ContainsKey("FonteAltezza") &&
                                 dataRow["FonteAltezza"]?.ToString() == "Da piano")
                        {
                            InputStr = InputStr.Replace(placeholder, "Da piano");
                        }
                        else if (key == "QuotaPavimento" &&
                                 dataRow.ContainsKey("FonteQuotaPavimento") &&
                                 dataRow["FonteQuotaPavimento"]?.ToString() == "Da piano")
                        {
                            InputStr = InputStr.Replace(placeholder, "Da piano");
                        }
                        else if (key == "LungPonte" &&
                                 dataRow.ContainsKey("FonteLunghezzaPonte") &&
                                 dataRow["FonteLunghezzaPonte"]?.ToString() != "Valore imposto")
                        {
                            if (dataRow.ContainsKey("OrientamentoPonte") &&
                                dataRow["OrientamentoPonte"]?.ToString() == "Orizzontale")
                                InputStr = InputStr.Replace(placeholder, "Lunghezza parete");
                            else
                                InputStr = InputStr.Replace(placeholder, "Altezza parete");
                        }
                        else
                        {
                            InputStr = InputStr.Replace(placeholder, value);
                        }
                    }
                }

                return InputStr;
            }
            catch (Exception ex)
            {
            return null; // ritorna comunque l'input originale se c'è stato un errore
            }
        }

        public void Script_Aggiorna(string Nuovo_Disegno)
        {
            // Percorso di salvataggio dello script
            string percorsoScript = System.IO.Path.Combine(GestProg.ProgramPath, "aggiorna.scr");

            // Modificato da Codex per realizzare: progetto senza DXF non bloccante e nessuno script CAD obsoleto.
            string NuovoDisegno = string.IsNullOrWhiteSpace(Nuovo_Disegno)
                ? null
                : System.IO.Path.Combine(GestProg.PathProg, Nuovo_Disegno + ".dxf");
            if (NuovoDisegno == null || !File.Exists(NuovoDisegno))
            {
                TermodelLog.WriteLog("Script CAD non disponibile: il progetto non dispone del DXF selezionato.");
                File.WriteAllLines(percorsoScript, new[]
                {
                    "(prompt \"\\nTermodel: disegno DXF non disponibile. Importare o selezionare un disegno.\")",
                    "(princ)"
                });
                return;
            }

            // Contenuto dello script
            string[] righeScript = new string[]
           {
 //   "FILEDIA 1",           // abilita i dialoghi
 //   "._CLOSE",
 //   "S",
    "avviso_aggiorna",
    "._OPEN",
    $"\"{NuovoDisegno}\"",
    "(load \"termodel.lsp\")"
    };


            // Scrive il file
            File.WriteAllLines(percorsoScript, righeScript);
        }

        public void Script_Disegna(System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> parametriCollection)
        {
            ScriptDisegna("Parete", parametriCollection);
            ScriptDisegna("Locale", parametriCollection);
            ScriptDisegna("Finestra", parametriCollection);
            ScriptDisegna("Ponte", parametriCollection);
            ScriptDisegna("Allinea", parametriCollection);
            ScriptDisegna("Nord", parametriCollection);
            ScriptDisegna("Colmo", parametriCollection);
            ScriptDisegna("Layer", parametriCollection);
            ScriptDisegna("Tubo", parametriCollection);
            ScriptDisegna("Dividi", parametriCollection);
            ComunicazioneAutoCad.AggiornaJsonAutocad(parametriCollection);
        }

        public void ScriptDisegna(string tipoComando, System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> parametriCollection)
        {
            try
            {
                // Verifica se il tipo di comando è supportato
                if (!Enum.TryParse(tipoComando, out TipoComandoEnum tipo))
                {
                    throw new ArgumentException("Tipo di comando non supportato.");
                }

                // Converti la collezione di dizionari in un singolo dizionario di stringhe
                Dictionary<string, string> parametri = new Dictionary<string, string>();
                if (parametriCollection.Count > 0)
                {
                    foreach (var item in parametriCollection[0])
                    {
                        if (item.Key != null && item.Value != null)
                        {
                            parametri[item.Key] = item.Value.ToString();
                        }
                    }
                }

                // Seleziona il template in base al tipo di comando
                string scriptTemplate;
                string nomeFile;
                switch (tipo)
                {
                    case TipoComandoEnum.Locale:
                        nomeFile = "loc.atr";
                        scriptTemplate =
        @"DESCR.,{DescrizioneLocale}
ZONA,{Zona}
CPAV,{ConfinePavimento}
CSOF,{ConfineSoffitto}
CCOPERTURA,{ColoreCopertura}
TPAV,{TipoPavimento}
TSOF,{TipoSoffitto}
ALTEZZALORDA,{AltezzaLorda}
ALTEZZANETTA,{AltezzaNetta}
QUOTAPAVIMENTO,{QuotaPavimento}";
                        break;
                    case TipoComandoEnum.Finestra:
                        nomeFile = "fin.atr";
                        scriptTemplate =
        @"PORTA,{Porta}
TIPO,{TipoFinestra}
LARGHEZZA,{LarghezzaFinestra}
ALTEZZA,{AltezzaFinestra}
NUMEROANTE,{AnteFinestra}
SOTTOFINESTRA,{SottoFinestra}
SOPRALUCE,{SopraLuce}";
                        break;
                    case TipoComandoEnum.Colmo:
                        nomeFile = "colmo.atr";
                        scriptTemplate =
        @"QUOTACOLMO,{QuotaColmo}
QUOTAGRONDA,{QuotaGronda}
LATOPARTEBASSA,{LatoParteBassaShed}
QUOTASHED,{QuotaShed}
PARETESHED,{PareteShed}";
                        break;
                    case TipoComandoEnum.Ponte:
                        nomeFile = "pon.atr";
                        scriptTemplate =
        @"TIPO,{TipoPonte}
ORIENTAMENTO,{OrientamentoPonte}
LUNGHEZZA,{LungPonte}";
                        break;
                    case TipoComandoEnum.Parete:
                        nomeFile = "parete.scr";
                        scriptTemplate =
        @"-layer
n
{Layer}
r
{Layer}

-colore
{Colore}
-tlinea
s
{TipoLinea}

thickness
0
LWDISPLAY
1
linea
";
                        break;
                    case TipoComandoEnum.Tubo:
                        nomeFile = "Tubo.scr";
                        scriptTemplate =
        @"-layer
n
{Layer}_tubipannelli
r
{Layer}_tubipannelli

-colore
1
-tlinea
s
Continuous

thickness
0
LWDISPLAY
1
linea
";
                        break;
                    case TipoComandoEnum.Dividi:
                        nomeFile = "Dividi.scr";
                        scriptTemplate =
        @"-layer
n
{Layer}
r
{Layer}

-colore
3
-tlinea
s
DIVIDI

thickness
0
LWDISPLAY
1
linea
";
                        break;
                    case TipoComandoEnum.Layer:
                        nomeFile = "Layer.scr";
                        scriptTemplate =
        @"-layer
n
{Layer}
r
{Layer}
avviso_layer

";
                        break;
                    case TipoComandoEnum.Allinea:
                        nomeFile = "Allinea.scr";
                        scriptTemplate =
        @"-layer
n
{Layer}
r
{Layer}

-inser
Allinea
s
1
r
0
";
                        break;
                    case TipoComandoEnum.Nord:
                        nomeFile = "Nord.scr";
                        scriptTemplate =
        @"-layer
n
{Layer}
r
{Layer}

-inser
nord
s
1
";
                        break;


                    // Aggiungi altri case per altri tipi di comando
                    // case TipoComandoEnum.AltroComando:
                    //     scriptTemplate = "...";
                    //     break;

                    default:
                        throw new ArgumentException("Tipo di comando non gestito.");
                }

                /* Sostituisci i segnaposto nel template con i valori dei parametri
                string scriptContent = scriptTemplate
                    .Replace("{LAYER}", parametri.ContainsKey("Layer") ? parametri["Layer"] : "DefaultLayer")
                    .Replace("{COLORE}", parametri.ContainsKey("Colore") ? CleanColor(parametri["Colore"]) : "1")
                    .Replace("{TIPOLINEA}", parametri.ContainsKey("TipoLinea") ? parametri["TipoLinea"] : "Continuous")
                    .Replace("{DescrizioneLocale}", parametri.ContainsKey("DescrizioneLocale") ? parametri["DescrizioneLocale"] : "DescrizioneLocale ?")
                    .Replace("{Zona}", parametri.ContainsKey("Zona") ? parametri["Zona"] : "Zona ?")
                    .Replace("{ConfinePavimento}", parametri.ContainsKey("ConfinePavimento") ? parametri["ConfinePavimento"] : "ConfinePavimento ?")
                    .Replace("{ConfineSoffitto}", parametri.ContainsKey("ConfineSoffitto") ? parametri["ConfineSoffitto"] : "ConfineSoffitto ?")
                    .Replace("{TipoPavimento}", parametri.ContainsKey("TipoPavimento") ? parametri["TipoPavimento"] : "TipoPavimento ?")
                    .Replace("{TipoSoffitto}", parametri.ContainsKey("TipoSoffitto") ? parametri["TipoSoffitto"] : "TipoSoffitto")
                    .Replace("{TipoFinestra}", parametri.ContainsKey("TipoFinestra") ? parametri["TipoFinestra"] : "TipoFinestra")
                    .Replace("{LarghezzaFinestra}", parametri.ContainsKey("LarghezzaFinestra") ? parametri["LarghezzaFinestraa"] : "LarghezzaFinestra")
                    .Replace("{AltezzaFinestra}", parametri.ContainsKey("AltezzaFinestra") ? parametri["AltezzaFinestra"] : "AltezzaFinestra")
                    .Replace("{SottoFinestra}", parametri.ContainsKey("SottoFinestra") ? parametri["SottoFinestra"] : "SottoFinestra")
                    .Replace("{TipoPonte}", parametri.ContainsKey("TipoPonte") ? parametri["TipoPonte"] : "TipoPonte");
                */
                // Percorso completo del file di script, con il nome del tipo di comando

                string scriptContent = SostDataDB(parametriCollection, scriptTemplate);
                if (scriptContent == null)
                {
                    scriptContent = scriptTemplate;
                    throw new ArgumentException($"Campo {scriptTemplate} non valido nel plugin Autocad .");
                }
                string scriptFilePath = System.IO.Path.Combine(DriveScript, nomeFile);

                // Scrivi il contenuto nello script
                File.WriteAllText(scriptFilePath, scriptContent);

                scriptFilePath = System.IO.Path.Combine(DriveScript, "layer.atr");
                // Scrivi il contenuto nello script
                File.WriteAllText(scriptFilePath, parametri.ContainsKey("Layer") ? parametri["Layer"] : "DefaultLayer");

                // Esempio di output per confermare l'operazione
                Console.WriteLine($"Scritto script per '{tipo}' in '{scriptFilePath}'");
            }
            catch (Exception ex)
            {
                 //Gestione dell'eccezione con un messaggio personalizzato
                MessageBox.Show($"Non sono riuscito a generare lo script: {tipoComando}. Errore: {ex.Message}");
            }
        }
        public void CopiaBloccoTestoDaTab(int tabIndex)
        {
            string tipo = tabIndex switch
            {
                2 => "FIN",
                3 => "PON",
                4 => "LOC",
                5 => "Colmo",
                _ => null
            };

            if (tipo == null)
            {
                TermodelLog.WriteLog("[INFO] Nessun blocco generabile per il tab corrente.");
                return;
            }

            string pathATR = System.IO.Path.Combine(GestProg.ProgramPath, $"{tipo}.atr");
            if (!File.Exists(pathATR))
            {
                TermodelLog.WriteLog($"[ERRORE] File .atr non trovato: {pathATR}");
                return;
            }

            var righe = File.ReadAllLines(pathATR);
            var sb = new StringBuilder();
            sb.AppendLine($"BLOCCO,{tipo}");
            foreach (var riga in righe)
                sb.AppendLine(riga);

            Clipboard.SetText(sb.ToString());
            TermodelLog.WriteLog($"[OK] Copiato testo {tipo} per LibreCAD in clipboard.");
        }

    }

}
