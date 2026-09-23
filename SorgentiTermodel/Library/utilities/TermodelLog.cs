using NetTopologySuite.Geometries;
using System;
using System.IO;
using Termodel.Leggidxf;
using Xbim.Ifc;
using Xbim.Ifc4.Interfaces;
using Xbim.Ifc4.GeometryResource;
using Xbim.Ifc4.ProductExtension;
using Xbim.Ifc4.MeasureResource;
using Xbim.Common.Geometry;
using System.Windows;
using System.Windows;
using static System.Runtime.InteropServices.JavaScript.JSType;


namespace Termodel.utilities
{
    internal static class TermodelLog
    {
        // Proprietà per abilitare/disabilitare il logging
        public static bool Enabled { get; set; } = true;

        // Estensione del file cambiata in .md per Markdown
        
        private static string logFilePath =Path.Combine(GestProg.ProgramPath, "TermodelLog.md");
        private static string errorFilePath = Path.Combine(GestProg.ProgramPath, "LogError.md");
        public static string svgDirectoryPath = Path.Combine(GestProg.ProgramPath, "svg");  // Cartella per i file SVG
        private static string HelperPath = "svg\\";  // Cartella per i file SVG
        private static int svgCounter = 0;  // Contatore per i file SVG
        private static bool errore=false;
        public static string LogContesto;

        // Metodo per scrivere nel file di log in formato Markdown
        // Funzione per verificare se il file è bloccato
        private static bool IsFileLocked(string filePath)
        {
            return false;
            try
            {
                GC.Collect();
                GC.WaitForPendingFinalizers();
                using (FileStream fs = new FileStream(filePath, FileMode.Open, FileAccess.Read, FileShare.None))
                {                 
                    return false; // Il file non è bloccato
                }
                
            }
            catch (IOException)
            {
                return true; // Il file è bloccato
            }
        }
        public static void WriteLogOld(string message)
        {
            if (!Enabled) return;

            try
            {
                using (FileStream fs = new FileStream(logFilePath, FileMode.Append, FileAccess.Write, FileShare.Read))
                using (StreamWriter sw = new StreamWriter(fs))
                {
                    if (errore)
                        sw.WriteLine($"** Errore **: {message}");
                    else
                        sw.WriteLine($"{message}");
                } // 🔹 Entrambi si chiudono qui, senza bisogno di `finally`
            }
            catch (IOException ioEx)
            {
                Console.WriteLine($"⚠ ERRORE: {ioEx.Message}");
            }
        }

        public enum LogCategory
        {
            Sempre,
            colmi,
            spezza,
            Error,
            Svg,
            RedrawHelix,
            GeneraModello,
            Performance,
            PontiAutomatici   // ← nuovo
        }

        public static bool IsEnabled(LogCategory category)
        {
            return category switch
            {
                LogCategory.Sempre => LogFlags.Sempre,
                LogCategory.colmi => LogFlags.colmi,
                LogCategory.spezza => LogFlags.spezza,
                LogCategory.Error => LogFlags.Error,
                LogCategory.Svg => LogFlags.Svg,
                LogCategory.RedrawHelix => LogFlags.RedrawHelix,
                LogCategory.GeneraModello => LogFlags.GeneraModello,
                LogCategory.Performance => LogFlags.Performance,
                LogCategory.PontiAutomatici => LogFlags.PontiAutomatici
            };
        }

        public static class LogFlags
        {
            public const bool Sempre = false;
            public const bool colmi = false;
            public const bool spezza = false;
            public const bool Error = false;
            public const bool Svg = false;
            public const bool RedrawHelix = false;
            public const bool GeneraModello = false;
            public const bool Performance = false;
            public const bool PontiAutomatici = true; 
        }

        // uso:
        // TermodelLog.WriteLog("[Ponti] Rigenerazione completata", LogCategory.PontiAutomatici);


        public static void WriteLog(string message, LogCategory category = LogCategory.Sempre)
        {
            if (!IsEnabled(category))
                return;
            if (!Enabled) return;  // Se il logging è disabilitato, esce dal metodo

            try
            {
                using (StreamWriter sw = new StreamWriter(logFilePath, true))
                {
                    // Scrivi il messaggio passato in formato Markdown
                    if (errore)
                        sw.WriteLine($"** Errore **:{message}");
                    else sw.WriteLine($"{message}");
                }
                if (errore)
                    using (StreamWriter sw = new StreamWriter(errorFilePath, true))
                    {
                        // Scrivi il messaggio passato in formato Markdown
                        sw.WriteLine(message);
                    }
                // TEST: Dopo la scrittura, verifichiamo se il file è accessibile
                if (IsFileLocked(logFilePath))
                {
                    bool test = false;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore nel log: {ex.Message}");
            }
        }

        // Metodo per inizializzare il log in formato Markdown
        public static void Initialize_Log()
        {
            logFilePath = Path.Combine(GestProg.ProgramPath, "TermodelLog.md");
            errorFilePath = Path.Combine(GestProg.ProgramPath, "LogError.md");
            svgDirectoryPath = Path.Combine(GestProg.ProgramPath, "svg");  // Cartella per i file SVG
        
            if (!Enabled) return;  // Se il logging è disabilitato, esce dal metodo

            try
            {
                svgCounter = 0;
               
                using (StreamWriter sw = new StreamWriter(logFilePath, false))
                {
                    // Intestazione Markdown
                    sw.WriteLine("# Log del programma Termodel");
                    sw.WriteLine("=== Inizio del log del programma Termodel ===\n");
                }
                if (IsFileLocked(logFilePath))
                {
                    bool test = false;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore durante l'inizializzazione del log: {ex.Message}");
            }
        }
        public static bool unerrore = false;
        public static void Initialize_LogErrori()
        {
            if (!Enabled) return;  // Se il logging è disabilitato, esce dal metodo
            unerrore = false;
            try
            {
                StreamWriter sw = new StreamWriter(errorFilePath, false);
                if (IsFileLocked(logFilePath))
                {
                    bool test = false;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore durante l'inizializzazione del log errori: {ex.Message}");
            }
        }
        public static bool CisonoErrori()
        {
            return unerrore;
            if (!Enabled) return false;  // Se il logging è disabilitato, esce immediatamente

            try
            {
                // Controlla se il file esiste
                if (File.Exists(errorFilePath))
                {
                    // Usando StreamReader con using per gestire la lettura del file e chiuderlo automaticamente
                    using (StreamReader sr = new StreamReader(errorFilePath))
                    {
                        string fileContent = sr.ReadToEnd();  // Legge tutto il contenuto del file

                        // Verifica se il contenuto non è vuoto
                        if (!string.IsNullOrWhiteSpace(fileContent))
                        {
                            // Visualizza il contenuto del file in una finestra di dialogo WPF
                            MessageBox.Show(fileContent, "Errori nel log", MessageBoxButton.OK, MessageBoxImage.Error);
                            return true;  // Restituisce true se ci sono errori
                        }
                        if (IsFileLocked(logFilePath))
                        {
                            bool test = false;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // In caso di eccezione, visualizza un messaggio di errore in una finestra di dialogo WPF
                MessageBox.Show($"Errore durante la lettura del log errori: {ex.Message}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
            }

            // Se il file non esiste o è vuoto, restituisce false
            return false;
        }

        public static void InitializeLog()
        {
            if (!Enabled) return;
            Initialize_Log();
            Initialize_LogErrori();
            erroreDaMostrare = null;
        }

            // Metodo per loggare un'operazione specifica in formato Markdown
            public static void LogOperation(string operationName)
        {
            if (!Enabled) return;
            // Aggiungi il nome dell'operazione come titolo di secondo livello in Markdown
            WriteLog($"{operationName}");    
        }

        // Metodo per loggare eventuali errori in formato Markdown
        public static string erroreDaMostrare = null;
        
        public static void MostraErrore(string TuttoOK)
        {
            if (erroreDaMostrare != null)
            {
                MainWindow mainWindow = Application.Current.MainWindow as MainWindow;
                // Modificato da Codex per realizzare: assegnazione della MainWindow come owner prima di mostrare il dialogo di errore.
                var finestraErrore = new HelpGPT(erroreDaMostrare);
                if (mainWindow != null)
                {
                    finestraErrore.Owner = mainWindow;
                }
                finestraErrore.ShowDialog();
                if (mainWindow != null)
                {
                    mainWindow.LabPrimoErrore.Content = erroreDaMostrare;
                    mainWindow.PrimoErrore.Visibility = Visibility.Visible;
                }
            }
            else MessageBox.Show(TuttoOK, "Successo", MessageBoxButton.OK, MessageBoxImage.Information); TermodelLog.LogOperation($"----------------------------------------------------------------------");

        }
 

        public static void LogError(string errorMessage)
        {
            if (!unerrore)
            {
                unerrore=true;
                erroreDaMostrare = errorMessage;
                //new HelpGPT(errorMessage).ShowDialog();
                //MessageBox.Show(errorMessage, "Errori nel log", MessageBoxButton.OK, MessageBoxImage.Error);
            }
                return;
            try
            {
                errore = true;
                WriteLog($" {errorMessage}\n");
            }
            catch (Exception ex)
            {
                var deskmes=ex.Message;
            }
            errore = false;
        }
        public static void LogDisegnoSVG(List<LineString> listaVerde, Geometry listaRossa)
        {
            return;
            if (!Enabled) return;
            // Crea la directory SVG se non esiste
            if (!Directory.Exists(svgDirectoryPath))
            {
                Directory.CreateDirectory(svgDirectoryPath);
            }

            // Genera il nome del file SVG con un postfisso autogenerato
            svgCounter++;
            string svgFileName = $"Disegno_{svgCounter}.svg";
            string svgFileHelperName = $"Disegno_{svgCounter}";
            //string svgFilePath = Path.Combine(svgDirectoryPath, svgFileName);
            string svgFilePath = $"{GestProg.ProgramPath}\\svg\\{svgFileName}";


            string SVGhelperpath = Path.Combine(HelperPath, svgFileHelperName); 

            // Genera il file SVG usando SVGHelper
            SVGHelper.GeneraSVG(svgFileHelperName, listaVerde, listaRossa);  // La funzione GeneraSVG prende il nome del file, le LineString e la geometria

            // Inserisci il link al file SVG nel log
            //WriteLog($"[Disegno SVG ]({svgFilePath})");
            WriteLog($"[Disegno SVG ]({svgFilePath})");
        }
        public static void LogIfcPoly(IfcPolyline poligono, IfcCartesianPoint puntoInserimento, IfcDirection direzione, string message)
        {
            // Log del messaggio personalizzato
            LogOperation(message);

            // Log i dettagli del poligono IFC
            if (poligono != null)
            {
                LogOperation($"Numero di punti nel poligono: {poligono.Points.Count}");

                foreach (var punto in poligono.Points)
                {
                    LogOperation($"Punto IFC: X={punto.X.ToString("F3")}, Y={punto.Y.ToString("F3")}, Z={punto.Z.ToString("F3")}");
                }
            }
            else
            {
                LogOperation("Poligono IFC nullo");
            }

            // Log i dettagli del punto di inserimento
            LogOperation($"Punto di inserimento: X={puntoInserimento.X.ToString("F3")}, Y={puntoInserimento.Y.ToString("F3")}, Z={puntoInserimento.Z.ToString("F3")}");

            // Log i dettagli della direzione
            LogOperation($"Direzione: X={direzione.X.ToString("F3")}, Y={direzione.Y.ToString("F3")}, Z={direzione.Z.ToString("F3")}");
        }
        public static void LogNtsPolygon(NetTopologySuite.Geometries.Polygon poligono, string message)
        {
            // Log del messaggio personalizzato
            LogOperation(message);

            // Verifica se il poligono non è nullo
            if (poligono != null)
            {
                LogOperation($"Numero di punti nel poligono: {poligono.Coordinates.Length}");

                foreach (var coord in poligono.Coordinates)
                {
                    LogOperation($"Punto: X={coord.X.ToString("F3")}, Y={coord.Y.ToString("F3")}");
                }
            }
            else
            {
                LogOperation("Poligono NTS nullo");
            }
        }

    }
}

