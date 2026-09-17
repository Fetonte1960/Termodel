using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.IO;
using System.Windows;
using System.Reflection;
using System.Diagnostics;
using System.IO.Compression;
using Microsoft.Win32;
using Termodel.Leggidxf;


namespace Termodel.utilities;
public static class GestProg
{
    public static string version = "3.2";
    public static bool  Debug=true;
    public static bool Rivestimenti = true;
    // Valori di default= @"C:\documenti\termomodel\Termodel.ini";
    public static string ProgramPath = @"C:\documenti\termomodel\";
    public static string DefaultProgettiPath = @"C:\documenti\termomodel\progetti";
    public static string UserDataPath = "";
    public static string DefaultEsempioProg = "Fabbricato con tetto a due falde e piano mansardato";
    public static string DefaultNomeProg = "NuovoProgetto";
    public static string metadataFilePath=  @"C:\DOCUMENTI\termomodel\codec\Termodel\definizionedati\definizionedati.json";
    // Variabili per il percorso dei progetti e il progetto corrente
    public static string ProgettiPath=null;
    public static string NomeProg=null;
    public static string ModelloDxfPath { get; set; } = @"C:\DOCUMENTI\termomodel\Modello.dxf";
    public static bool GeneraModellApertura = true;
    public static bool ModalitaWorkbench { get; private set; }
    private static string _workbenchProgramPath;
    private static string _workbenchProjectPath;
    // Percorso completo del progetto corrente
    public static string PathProg => Path.Combine(ProgettiPath, NomeProg);
    public static string PathProgDB => Path.Combine(PathProg, "dbtempfiles");

    // Funzione realizzata da Codex in autonomia
    public static void ConfiguraWorkbench(string programPath, string projectPath)
    {
        if (string.IsNullOrWhiteSpace(programPath))
            throw new ArgumentException("La cartella di lavoro del Workbench non è valida.", nameof(programPath));
        if (string.IsNullOrWhiteSpace(projectPath))
            throw new ArgumentException("La cartella del progetto di prova non è valida.", nameof(projectPath));

        string root = Path.GetFullPath(programPath);
        string project = Path.GetFullPath(projectPath);
        string relativo = Path.GetRelativePath(root, project);
        if (relativo == ".." || relativo.StartsWith($"..{Path.DirectorySeparatorChar}", StringComparison.Ordinal))
            throw new ArgumentException("Il progetto di prova deve trovarsi dentro la cartella isolata del Workbench.", nameof(projectPath));

        ModalitaWorkbench = true;
        _workbenchProgramPath = root;
        _workbenchProjectPath = project;
    }
    public static string FileDatiPath(string NomeArch)
    {
        return System.IO.Path.Combine(PathProgDB, $"{NomeArch}.xml");
    }
    public static string FileXMLPath
    {
        get
        {
            return System.IO.Path.Combine(PathProg, $"xml\\input.xml");
        }
    }
    public static string FileBIMPath
    {
        get
        {
            return System.IO.Path.Combine(ProgramPath, $"outbim.ifc");
        }
    }
    public static string FileXMLOutPath
    {
        get
        {
            return System.IO.Path.Combine(PathProg, $"xml\\output.xml");
        }
    }
    // Funzione realizzata da Codex in autonomia
    public static string FileLocaleXmlPath => Path.Combine(PathProg, "locale.xml");

    // Funzione realizzata da Codex in autonomia
    public static string FileLocaleSvgPath => Path.Combine(PathProg, "locale.svg");

    public static string fileMes(string pathfile)
    {
        
        // Calcola la parte del percorso residuo rimuovendo ProgramPath da pathfile
        string residuoPercorso = pathfile.Replace(ProgramPath, "").TrimStart('\\');

        // Costruisci il messaggio formattato
        string messaggio = $"I file di termodel si trovano in:\n{ProgramPath}\nIl file specifico si trova in:\n{residuoPercorso}";

        return messaggio;
    }

    public static string FileDXFPath(string nomefile)
    {
        {
            return System.IO.Path.Combine(PathProg, $"{nomefile}.dxf");
        }
    }
    static void SettaCartellaProgramma()
    {
        /*
        // Rileva il percorso dell'eseguibile corrente
        string executablePath = Assembly.GetExecutingAssembly().Location;
        string currentDirectory = Path.GetDirectoryName(executablePath);

        // Stampa la cartella corrente di esecuzione
        Console.WriteLine("Current Directory: " + currentDirectory);

        // Risale di due livelli per trovare la cartella principale
        // Modifica questo numero in base a quanti livelli vuoi risalire
        string mainDirectory = GetParentDirectory(currentDirectory, 2);
        ProgramPath = mainDirectory;
        */
        PrimoAvvio();
        ModelloDxfPath = Path.Combine(ProgramPath, "Modello.dxf");
        DefaultProgettiPath = Path.Combine(ProgramPath, "esempi");
        if (Directory.Exists(Path.Combine(DefaultProgettiPath, DefaultEsempioProg)))
            DefaultNomeProg = DefaultEsempioProg;
            // Stampa la cartella principale
            Console.WriteLine("Main Directory: " + ProgramPath);
    }

    static string GetParentDirectory(string path, int levelsUp)
    {
        DirectoryInfo directory = new DirectoryInfo(path);

        for (int i = 0; i < levelsUp; i++)
        {
            if (directory.Parent != null)
            {
                directory = directory.Parent;
            }
            else
            {
                // Se non ci sono più directory superiori, esci dal ciclo
                break;
            }
        }

        return directory.FullName;
    }
    public static void InitByXML()
    {
        // Controllo e copia input.xml se non esiste
        string inputXmlPath = FileXMLPath;
        string stileEdificioPath = Path.Combine(ProgramPath, "stileedificio.xml");
        if (!File.Exists(inputXmlPath))
        {
            if (File.Exists(stileEdificioPath))
            {
                File.Copy(stileEdificioPath, inputXmlPath);
                // Mostra una finestra di dialogo con una domanda
                var result = MessageBox.Show("Vuoi inizializzare il progetto con gli archivi dell'XML?",
                                             "Inizializza Progetto",
                                             MessageBoxButton.YesNo,
                                             MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes)
                {

                    MessageBox.Show("Progetto inizializzato con gli archivi dell'XML.", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);
                }
            }
            else
            {
                Console.WriteLine("Errore: il file stileedificio.xml non esiste nella cartella del programma.");
            }
        }
       
        
    }
    public static void SetProgcor(string progettiPath,string nomeProg)
    {
        ProgettiPath = progettiPath;
        NomeProg=nomeProg;
        string iniFilePath = Path.Combine(ProgramPath, "Termodel.ini");
        using (StreamWriter sw = new StreamWriter(iniFilePath))
        {
            sw.WriteLine($"ProgettiPath={ProgettiPath}");
            sw.WriteLine($"NomeProg={NomeProg}");
        }
        Database.DB.PathDatiDB = PathProgDB;
        Database.DB.LoadAllData();
    }
    public static bool NuovaVersione(string termodelPath)
    {
        string Versione = UserIni.Ini.LoadVar("Version");
        if (string.IsNullOrEmpty(Versione)||Versione!=version)
            {
            UserIni.Ini.SetVar("Version", version);

            if (Directory.Exists(termodelPath))
            {
               var result = MessageBox.Show($"Completamento dell'installazione , Versione:{version}, la cartella:\n\n{termodelPath} relativa alla vecchia versione deve essere cancellata ! ",
                                             "Conferma eliminazione",
                                             MessageBoxButton.YesNo,
                                             MessageBoxImage.Question);

                if (result == MessageBoxResult.Yes) return true;
                else return false;
            }
            return true;
        }
       return false;
    }
    public static void PrimoAvvio()
    {
        // Modificato da Codex per realizzare: avvio isolato del Termodel Workbench senza leggere,
        // cancellare o aggiornare la cartella Termodel reale dell'utente.
        if (ModalitaWorkbench)
        {
            ProgramPath = _workbenchProgramPath;
            UserDataPath = Path.Combine(ProgramPath, "UserData");
            DefaultProgettiPath = Path.GetDirectoryName(_workbenchProjectPath) ?? ProgramPath;
            DefaultNomeProg = Path.GetFileName(_workbenchProjectPath);
            Directory.CreateDirectory(ProgramPath);
            Directory.CreateDirectory(UserDataPath);
            Directory.CreateDirectory(_workbenchProjectPath);
            SVGHelper.Init_class();
            UserIni.InitClass();
            if (UserIni.Ini.LoadVar("Tutor") == "?")
                UserIni.Ini.SetVar("Tutor", false);
            if (UserIni.Ini.LoadVar("GeneraModelloAvvio") == "?")
                UserIni.Ini.SetVar("GeneraModelloAvvio", false);

            string metadataDistribuiti = Path.Combine(
                AppContext.BaseDirectory,
                "definizionedati",
                "definizionedati.json");
            if (File.Exists(metadataDistribuiti))
                metadataFilePath = metadataDistribuiti;

            return;
        }

        //MessageBox.Show("Primo avvio", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);
        // Ottieni il percorso della cartella "Documenti"
        string documentiPath = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
        string termodelPath = Path.Combine(documentiPath, "Termodel");
        ProgramPath = termodelPath;
        SVGHelper.Init_class();
        UserDataPath= Path.Combine(documentiPath, "TermodelUserData");
        if (!Directory.Exists(UserDataPath))
        {
            Directory.CreateDirectory(UserDataPath);
        }
        string installPath = Environment.GetFolderPath(Environment.SpecialFolder.LocalApplicationData);
        //string installPath = Environment.GetFolderPath(Environment.SpecialFolder.CommonApplicationData);
        #if DEBUG
        #else
        metadataFilePath = Path.Combine(installPath, "Termodel\\DatiNonModificabili\\definizionedati.json");
        #endif

        DefaultProgettiPath = Path.Combine(termodelPath, "esempi");
        // Controlla se la cartella "Termodel" esiste in Documenti
        // elimina termodel se la versione non è aggiornata
        UserIni.InitClass();
        //MessageBox.Show("UserIni.InitClass", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);

        if (NuovaVersione(termodelPath))
        {
            string percorsoCartella = termodelPath;

            try
            {
                if (Directory.Exists(percorsoCartella))
                {
                    Directory.Delete(percorsoCartella, recursive: true);
                    Console.WriteLine("Cartella eliminata con successo.");
                }
                else
                {
                    Console.WriteLine("La cartella non esiste.");
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore durante l'eliminazione: {ex.Message}");
            }
        }
        if (!Directory.Exists(termodelPath))
        {
            try
            {
                //string codiceInstallazione = Guid.NewGuid().ToString();  // oppure hash hardware + user
                //UserIni.Ini.SetVar("installcode", codiceInstallazione);
                // Crea la cartella "Termodel"
                Directory.CreateDirectory(termodelPath);
                TermodelLog.InitializeLog();
                TermodelLog.WriteLog($"Primo avvio ,cartella 'Termodel' creata in {termodelPath}.");

                // Rileva il percorso dell'eseguibile corrente

                //string executablePath = Assembly.GetExecutingAssembly().Location;
                //string installPath = Path.GetDirectoryName(executablePath);

                // Copia i file che devono essere modificati
                TermodelLog.WriteLog($"File in copia dalla cartella {Path.Combine(installPath, "Termodel\\DatiModificabili")} alla cartella {termodelPath}.");
                CopyDirectoryContents(Path.Combine(installPath,"Termodel\\DatiModificabili"),termodelPath);          
            }
            catch (Exception ex)
            {
                TermodelLog.WriteLog($"Errore durante il primo avvio: {ex.Message}");
            }
        }
        else
        {
            TermodelLog.WriteLog($"Cartella 'Termodel' in Documenti esistente. Non si tratta di primo avvio.");
        }
        if (!Directory.Exists(TermodelLog.svgDirectoryPath))
        {
            Directory.CreateDirectory(TermodelLog.svgDirectoryPath);
        }
    }

    // Funzione per copiare i file da una directory a un'altra
    public static void CopyDirectoryContents(string sourceDir, string targetDir)
    {
        // Controlla se la directory di origine esiste
        if (!Directory.Exists(sourceDir))
            throw new DirectoryNotFoundException($"La directory di origine '{sourceDir}' non esiste.");
        Directory.CreateDirectory(targetDir);

        DirectoryInfo sourceDirectory = new DirectoryInfo(sourceDir);
        DirectoryInfo[] directories = sourceDirectory.GetDirectories();

        // Copia tutti i file nella directory di destinazione
        FileInfo[] files = sourceDirectory.GetFiles();
        foreach (FileInfo file in files)
        {
            string targetFilePath = Path.Combine(targetDir, file.Name);
            file.CopyTo(targetFilePath, true); // Sovrascrive i file se esistono
        }

        // Copia tutte le sottodirectory nella directory di destinazione
        foreach (DirectoryInfo subDir in directories)
        {
            string newTargetDir = Path.Combine(targetDir, subDir.Name);
            Directory.CreateDirectory(newTargetDir);
            CopyDirectoryContents(subDir.FullName, newTargetDir);
        }
    }
    // Funzione per inizializzare le cartelle del progetto e leggere il file Termodel.ini
    public static string  InitProgetto(bool salvaconnome=false)
    {
        TermodelLog.WriteLog("InitProgetto");

        SettaCartellaProgramma();
        // Modificato da Codex per realizzare: selezione deterministica del progetto isolato
        // fornito dal Workbench, senza dipendere dal Termodel.ini dell'installazione reale.
        if (ModalitaWorkbench)
        {
            ProgettiPath = Path.GetDirectoryName(_workbenchProjectPath) ?? ProgramPath;
            NomeProg = Path.GetFileName(_workbenchProjectPath);
        }
        string iniFilePath = Path.Combine(ProgramPath, "Termodel.ini");
        bool inicorretto = false;
        if (ModalitaWorkbench)
        {
            inicorretto = Directory.Exists(PathProg);
        }
        else if (File.Exists(iniFilePath))
        {
            // Legge il file INI
            var lines = File.ReadAllLines(iniFilePath);
            foreach (var line in lines)
            {
                if (line.StartsWith("ProgettiPath="))
                {
                    ProgettiPath = line.Split('=')[1].Trim();
                }
                else if (line.StartsWith("NomeProg="))
                {
                    NomeProg = line.Split('=')[1].Trim();
                }
            }
            if (Directory.Exists(Path.Combine(ProgettiPath, NomeProg)))
            {
                inicorretto = true;
                TermodelLog.WriteLog($"Il progetto corrente è corretto in Termodel.ini {Path.Combine(ProgettiPath, NomeProg)}");
            }
            else TermodelLog.WriteLog($"Il progetto corrente non è corretto in Termodel.ini {Path.Combine(ProgettiPath, NomeProg)} o non esiste.");
        }
        else TermodelLog.WriteLog($"Il file {iniFilePath} non esiste.");
        if (!inicorretto)
        {
            // Inizializza con i valori di default
            ProgettiPath = DefaultProgettiPath;
            NomeProg = DefaultNomeProg;

            // Crea il file INI con i valori di default
            using (StreamWriter sw = new StreamWriter(iniFilePath))
            {
                sw.WriteLine($"ProgettiPath={DefaultProgettiPath}");
                sw.WriteLine($"NomeProg={DefaultEsempioProg}");
            }
            TermodelLog.WriteLog($"Progetto corrente al  valore di default.{Path.Combine(DefaultProgettiPath, DefaultEsempioProg)}");
        }

        // Controlla se le cartelle esistono e le crea se necessario
        if (!Directory.Exists(PathProg))
        {
            Directory.CreateDirectory(PathProg);
            Console.WriteLine($"Cartella progetto creata: {PathProg}");
        }

        if (!Directory.Exists(PathProgDB))
        {
            Directory.CreateDirectory(PathProgDB);
            Console.WriteLine($"Cartella DB temporanei creata: {PathProgDB}");
        }

        string xmlFolderPath = Path.Combine(PathProg, "xml");
        if (!Directory.Exists(xmlFolderPath))
        {
            Directory.CreateDirectory(xmlFolderPath);
            Console.WriteLine($"Cartella XML creata: {xmlFolderPath}");
        }

        if(!salvaconnome) InitByXML();

        return $"Termodel {version}  :  " + PathProg;
        
    }
    public static void SalvaProgettoZippato(string percorsoCartellaProgetto)
    {
        if (!Directory.Exists(percorsoCartellaProgetto))
        {
            MessageBox.Show("La cartella del progetto non esiste:\n" + percorsoCartellaProgetto);
            return;
        }

        // Nome del progetto = nome della cartella
        string nomeCartella = Path.GetFileName(percorsoCartellaProgetto.TrimEnd(Path.DirectorySeparatorChar));
        string cartellaPadre = Path.GetDirectoryName(percorsoCartellaProgetto);
        string percorsoZipDefault = Path.Combine(cartellaPadre, nomeCartella + ".zip");

        // Dialog per confermare o modificare il percorso ZIP
        SaveFileDialog dialog = new SaveFileDialog();
        dialog.Title = "Salva progetto in formato ZIP";
        dialog.Filter = "File ZIP (*.zip)|*.zip";
        dialog.FileName = Path.GetFileName(percorsoZipDefault);
        dialog.InitialDirectory = cartellaPadre;

        if (dialog.ShowDialog() != true)
            return;

        string percorsoZipFinale = dialog.FileName;

        try
        {
            if (File.Exists(percorsoZipFinale))
            {
                var result = MessageBox.Show("Il file ZIP esiste già. Vuoi sovrascriverlo?", "Conferma sovrascrittura", MessageBoxButton.YesNo);
                if (result != MessageBoxResult.Yes)
                    return;

                File.Delete(percorsoZipFinale);
            }

            // Versione customizzata: include tutte le sottocartelle, anche quelle con attributi speciali
            using (FileStream zipToOpen = new FileStream(percorsoZipFinale, FileMode.Create))
            using (ZipArchive archive = new ZipArchive(zipToOpen, ZipArchiveMode.Create))
            {
                string[] files = Directory.GetFiles(percorsoCartellaProgetto, "*", SearchOption.AllDirectories);

                foreach (string file in files)
                {
                    string percorsoRelativo = Path.GetRelativePath(percorsoCartellaProgetto, file);
                    archive.CreateEntryFromFile(file, Path.Combine(nomeCartella, percorsoRelativo), CompressionLevel.Fastest);
                }
            }

            MessageBox.Show("Backup creato correttamente:\n" + percorsoZipFinale);
        }
        catch (Exception ex)
        {
            MessageBox.Show("Errore durante la creazione del file ZIP:\n" + ex.Message);
        }
    }

    

    public static string LeggiProgettoZippato()
    {
        try
        {
            OpenFileDialog dialog = new OpenFileDialog();
            dialog.Title = "Seleziona un progetto Termodel zippato";
            dialog.Filter = "File ZIP (*.zip)|*.zip";

            if (dialog.ShowDialog() != true)
                return null;

            string percorsoZip = dialog.FileName;
            string nomeProgetto = Path.GetFileNameWithoutExtension(percorsoZip);

            // Default: C:\Users\<utente>\Documents\TermodelUserData
            string cartellaDefault = Path.Combine(
                Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
                "TermodelUserData"
            );

            // Assicurati che la cartella esista
            if (!Directory.Exists(cartellaDefault))
                Directory.CreateDirectory(cartellaDefault);

            // Chiedi all’utente la cartella di destinazione
            using (var folderDialog = new System.Windows.Forms.FolderBrowserDialog())
            {
                folderDialog.Description = "Seleziona la cartella di destinazione per il progetto";
                folderDialog.SelectedPath = cartellaDefault;

                if (folderDialog.ShowDialog() != System.Windows.Forms.DialogResult.OK)
                    return null;

                string cartellaDestinazione = folderDialog.SelectedPath;

                if (Directory.Exists(cartellaDestinazione))
                {
                    var result = MessageBox.Show("La cartella esiste già. Sovrascrivere?", "Conferma", MessageBoxButton.YesNo);
                    if (result != MessageBoxResult.Yes)
                        return null;

                    Directory.Delete(cartellaDestinazione, recursive: true);
                }

                ZipFile.ExtractToDirectory(percorsoZip, cartellaDestinazione);
                return Path.Combine(cartellaDestinazione, nomeProgetto); ;
            }
        }
        catch
        {
            return null;
        }
    }


}


