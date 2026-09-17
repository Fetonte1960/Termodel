using System.Text;
using System.Windows;
using Microsoft.Win32;
using System.Windows.Controls;
//using System.Windows.Forms;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Xml.Linq;
using Termodel.Leggidxf;
using Termodel.utilities;
using System.IO;
using System.Collections.ObjectModel;
using System.Windows.Controls.Primitives;
using System.Data;
using netDxf.Collections;
using System.Reflection.Metadata;
using System.Diagnostics;
using Termodel.Energy_Plus;
using System.Globalization;
using Termodel.Tutor.codice;
using static Microsoft.Isam.Esent.Interop.EnumeratedColumn;
using System.Windows.Media.Media3D;
using System.Windows.Automation;
using Termodel.definizionedati;
using Termodel.GPT;
using netDxf.Tables;
using static GestXml;
using System.ComponentModel;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.TextBox;
using netDxf.Entities;
using System.Reflection.Metadata.Ecma335;
using System.Runtime.InteropServices;
using Termodel.Calcoli;
using Termodel.Impianti.Pannelli;
using TermodelAdvancedAI;
using Termodel.WorkbenchRuntime;
using Termodel.AI;


namespace Termodel
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private const double LarghezzaCodexRiservata = 480;
        private const int NumeroComandiAdvancedAIVisibili = 8;
        private readonly Queue<string> _comandiAdvancedAI = new();
        private readonly Dictionary<TabItem, Visibility> _visibilitaSchedePrimaMinimalista = new();
        private bool _modalitaAdvancedAIMinimalista;
        private WindowState _statoFinestraPrimaMinimalista;
        private Rect _rettangoloFinestraPrimaMinimalista;
        private Visibility _visibilitaMenuPrimaMinimalista;
        private Visibility _visibilitaTutorPrimaMinimalista;
        private Visibility _visibilitaGridGeneralePrimaMinimalista;
        private Visibility _visibilitaGridArchiviPrimaMinimalista;
        private Visibility _visibilitaGridDatiCadPrimaMinimalista;
        private Visibility _visibilitaPrimoErrorePrimaMinimalista;
        private Visibility _visibilitaBarraControlliPrimaMinimalista;
        private object? _intestazioneTabModelloPrimaMinimalista;
        private Thickness _bordoMainTabControlPrimaMinimalista;
        private Thickness _paddingMainTabControlPrimaMinimalista;
        private bool _topmostPrimaMinimalista;

        [StructLayout(LayoutKind.Sequential)]
        private struct RettangoloWin32
        {
            public int Left;
            public int Top;
            public int Right;
            public int Bottom;
        }

        [DllImport("user32.dll")]
        private static extern bool GetWindowRect(IntPtr hWnd, out RettangoloWin32 lpRect);
        /*
        public string PathProgDB { get; set; } = @"C:\DOCUMENTI\termomodel\progetti\prova\dbtempfiles";
        public string PathProg { get; set; } = @"C:\DOCUMENTI\termomodel\progetti\prova";
        
        public string ModelloDxfPath { get; set; } = @"C:\DOCUMENTI\termomodel\Modello.dxf";
        public string NomeProg { get; set; } = "prova";
        */
        public string NomeArch { get; set; } = "ElencoPiani";
        public bool Pianiloaded = true;
        public bool Paretiloaded = false;
        public bool Confiniloaded = false;
        public bool Zoneloaded = false;
        public bool Finestreloaded = false;
        /*
        public string FileDatiPath
        {
            get
            {
                return System.IO.Path.Combine(PathProgDB, $"{NomeArch}.xml");
            }
        }
        public string FileXMLPath
        {
            get
            {
                return System.IO.Path.Combine(PathProg, $"xml\\{NomeProg}.xml");
            }
        }
        public string FileXMLOutPath
        {
            get
            {
                return System.IO.Path.Combine(PathProg, $"out.xml");
            }
        }
        public string FileDXFPath(string nomefile)
        {
            {
                return System.IO.Path.Combine(PathProg, $"{nomefile}.dxf");
            }
        }
        */
        public string FileDXFNew(string nomefile)
        {
            // Componi il percorso completo del file DXF
            string filePath = System.IO.Path.Combine(GestProg.PathProg, $"{nomefile}.dxf");

            // Controlla se il file esiste
            if (!File.Exists(filePath))
            {
                // Se il file non esiste, controlla se il file modello esiste
                if (File.Exists(GestProg.ModelloDxfPath))
                {
                    // Copia il file modello nel percorso desiderato
                    File.Copy(GestProg.ModelloDxfPath, filePath);
                }
                else
                {
                    throw new FileNotFoundException("Il file modello non esiste.");
                }
            }

            // Restituisci il percorso del file DXF
            return filePath;
        }
        public string DefType { get; set; }
        public bool StopAggiornaForm { get; set; }
        // Proprietà per definire il tipo di riga da aggiungere
        public System.Collections.ObjectModel.ObservableCollection<Dictionary<string, object>> OCollection { get; set; }

        public UtiDb utiDb;
        private ScriptCad scriptCad;
        private readonly ComunicazioneAdvancedAI _comunicazioneAdvancedAI = new();
        public Modello modello_edificio;

        //private ObservableCollection<Dictionary<string, object>> PianiCollection;
        //private ObservableCollection<Dictionary<string, object>> ParetiCollection;
        //private ObservableCollection<Dictionary<string, object>> ConfiniCollection;

        //------------------------------ energyplus  ----------------------------------------
        private EnergyPlus _energyPlus;
        private string _idfFilePath;
        private string _weatherFilePath = @"path\to\weather.epw"; // Modifica con il percorso corretto
        private bool isInitialized = false;

        public static FiltriGrafici FiltriGraficiControlStatic { get; private set; }
        public TermodelReport report;
        public TermodelReport reportDispersioni;
        public TermodelReport reportPannelli;
        public bool ModoPlugin=false;
        internal RisultatoAPE UltimoRisultatoDispersioni { get; private set; }
        internal RisultatoCalcoloPannelli UltimoRisultatoPannelli { get; private set; }
        public MainWindow()
        {
             InitializeComponent();
            //MessageBox.Show("Init mainwindows", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);
            this.Title = GestProg.InitProgetto();
            TermodelLog.InitializeLog();
            TermodelLog.WriteLog("------------------- Init mainwindow -----------");
            //MessageBox.Show("InitProgetto eseguito", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);
            //this.Topmost = true; // Imposta il form come sempre in primo piano
            StopAggiornaForm = true;
            LoadTreeViewFromXml(GestProg.FileXMLPath, mytreeview);
            //MessageBox.Show("LoadTreeViewFromXml eseguito", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);
            utiDb = new UtiDb(GestProg.metadataFilePath, GestProg.PathProgDB);
            Database.DB = utiDb;
            GestXml.Init_class(this, utiDb);
            //MessageBox.Show("GestXml.Init_class", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);
            HelixDXF.InitClass();
            //DrawBim drawBimWindow = null;
            //DrawBim drawBimWindow = new DrawBim();
            //drawBimWindow.Show();
            //modello_edificio = new Modello(drawBimWindow);
            //var helixWindow = new FormHelix();
            //helixWindow.Show();


            scriptCad = new ScriptCad();
            ComunicazioneAutoCad.AvviaGestoreRichieste(utiDb, scriptCad);
            // Imposta il valore iniziale per la griglia-archivio
            DefType = "Piani";
            NomeArch = "ElencoPiani";
            //PianiCollection = new ObservableCollection<Dictionary<string, object>>();
            //ConfiniCollection = new ObservableCollection<Dictionary<string, object>>();
            //ParetiCollection = new ObservableCollection<Dictionary<string, object>>();
            //OCollection = PianiCollection;
            //DbGridCor.ItemsSource = PianiCollection;
            //utiDb.ConfigureDataGrid(DbGridCor, "Piani");
            //utiDb.LoadRecordFromXml(FileDatiPath, OCollection);
            //-------  Piani ------
            SetArchivio("Piani");

            //-------  DatiCad ------
            utiDb.LoadData("DatiCad");
            utiDb.InitCollection("DatiCad");

            utiDb.ConfigureForm(Grid_DatiCad, "DatiCad");
            utiDb.LeggiForm("DatiCad", Grid_DatiCad, 0);
            scriptCad.PopulateAutoCADVersionsComboBox(DatiCad_VersioneCad);

            CaricaDaXML.Visibility = Visibility.Collapsed;
            StopAggiornaForm = false;
            // Inizializza l'istanza di EnergyPlus

            _energyPlus = new EnergyPlus(@"C:\EnergyPlusV24-1-0\energyplus.exe"); // console
            isInitialized = true;                                                                     //_energyPlus = new EnergyPlus(@"C:\EnergyPlusV24-1-0\EP - Launch.exe"); // winapp
                                                                                                      // Collega l'evento FiltriChanged del controllo FiltriGrafici
            FiltriGraficiControl.FiltriChanged += FiltriGraficiControl_FiltriChanged;
            FiltriGraficiControlStatic = FiltriGraficiControl;
            //UserIni.InitClass(); spostata in gestprog
            SettaRivestimenti();
            report = new TermodelReport(richTextBoxDati1, richTextBoxDati2, richTextBoxDati3);
            reportDispersioni = new TermodelReport(richTextBoxDispersioni);
            reportPannelli = new TermodelReport(richTextBoxPannelli);
            reportDispersioni.AggiungiTestoFormattato(
                "Generare il modello per calcolare le dispersioni termiche.",
                colore: "DarkRed",
                report: false);
            reportPannelli.AggiungiTestoFormattato(
                "Aggiornare il modello per censire locali e circuiti.",
                colore: "DarkRed",
                report: false);
            ReportModello.InitClass(report);
            TermodelLog.WriteLog("-------------------Fine  Init mainwindow -----------");
            //MessageBox.Show("Fine  Init mainwindow", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);

        }

        public void AggiornaReportDispersioni(RisultatoAPE risultato)
        {
            // Modificato da Codex per realizzare: esposizione dell'ultimo risultato al report compatto del Workbench.
            UltimoRisultatoDispersioni = risultato;
            reportDispersioni.CancellaTesto();

            if (risultato == null)
            {
                reportDispersioni.AggiungiTestoFormattato(
                    "Risultati del calcolo non disponibili.",
                    colore: "DarkRed",
                    report: false);
                return;
            }

            var reale = risultato.EdificioReale;
            double coefficienteTotale = reale.HT_Totale + reale.HV;

            reportDispersioni.AggiungiTestoFormattato(
                "Dispersioni termiche",
                grassetto: true,
                colore: "DarkRed",
                dimensioneFont: 16,
                report: false);

            reportDispersioni.AggiungiTestoConValorePar(
                "Componenti opachi:",
                risultato.NumeroComponentiOpachi,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            reportDispersioni.AggiungiTestoConValore(
                "HT superfici opache:",
                reale.HT_Opaco,
                "W/K",
                dimensioneFont: 14,
                report: false);

            reportDispersioni.AggiungiTestoConValorePar(
                "Finestre:",
                risultato.NumeroFinestre,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            reportDispersioni.AggiungiTestoConValore(
                "HT finestre:",
                reale.HT_Finestra,
                "W/K",
                dimensioneFont: 14,
                report: false);

            reportDispersioni.AggiungiTestoConValorePar(
                "Ponti termici:",
                risultato.NumeroPontiTermici,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            reportDispersioni.AggiungiTestoConValore(
                "HT ponti termici:",
                reale.HT_PontiTermici,
                "W/K",
                dimensioneFont: 14,
                report: false);

            reportDispersioni.AggiungiTestoConValore(
                "HT totale per trasmissione:",
                reale.HT_Totale,
                "W/K",
                dimensioneFont: 14,
                report: false);

            reportDispersioni.AggiungiTestoConValore(
                "HV ventilazione:",
                reale.HV,
                "W/K",
                dimensioneFont: 14,
                report: false);

            reportDispersioni.AggiungiTestoConValore(
                "Coefficiente totale HT + HV:",
                coefficienteTotale,
                "W/K",
                dimensioneFont: 14,
                report: false);

            reportDispersioni.AggiungiTestoConValore(
                "Dispersione energetica annuale:",
                reale.QhDisp,
                "kWh/anno",
                dimensioneFont: 14,
                report: false);
        }

        internal void AggiornaReportPannelli(RisultatoCalcoloPannelli risultato)
        {
            // Modificato da Codex per realizzare: esposizione dell'ultimo risultato al report compatto del Workbench.
            UltimoRisultatoPannelli = risultato;
            reportPannelli.CancellaTesto();

            reportPannelli.AggiungiTestoFormattato(
                "Calcolo pannelli",
                grassetto: true,
                colore: "DarkRed",
                dimensioneFont: 16,
                report: false);

            int numeroErrori = risultato.Segnalazioni.Count(
                segnalazione =>
                    segnalazione.Livello == LivelloSegnalazionePannelli.Errore);
            int numeroWarning = risultato.Segnalazioni.Count(
                segnalazione =>
                    segnalazione.Livello == LivelloSegnalazionePannelli.Warning);

            reportPannelli.AggiungiTestoFormattato(
                "Errori e warning",
                grassetto: true,
                colore: "DarkRed",
                dimensioneFont: 15,
                report: false);

            reportPannelli.AggiungiTestoConValorePar(
                "Errori:",
                numeroErrori,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            reportPannelli.AggiungiTestoConValorePar(
                "Warning:",
                numeroWarning,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            if (numeroErrori == 0 && numeroWarning == 0)
            {
                reportPannelli.AggiungiTestoFormattato(
                    "Nessun errore o warning rilevato.",
                    colore: "Green",
                    dimensioneFont: 13,
                    report: false);
            }
            else
            {
                foreach (SegnalazionePannelli segnalazione in risultato.Segnalazioni
                    .Where(elemento =>
                        elemento.Livello !=
                        LivelloSegnalazionePannelli.Informazione)
                    .OrderBy(elemento => elemento.Livello))
                {
                    string contesto = string.Join(
                        " - ",
                        new[]
                        {
                            segnalazione.Piano,
                            segnalazione.Locale,
                            segnalazione.Circuito
                        }.Where(valore => !string.IsNullOrWhiteSpace(valore)));

                    string prefisso =
                        segnalazione.Livello ==
                        LivelloSegnalazionePannelli.Errore
                            ? "ERRORE"
                            : "WARNING";
                    string testoContesto = string.IsNullOrWhiteSpace(contesto)
                        ? string.Empty
                        : $" [{contesto}]";

                    reportPannelli.AggiungiTestoFormattato(
                        $"{prefisso} {segnalazione.Codice}{testoContesto}: " +
                        segnalazione.Messaggio,
                        grassetto:
                            segnalazione.Livello ==
                            LivelloSegnalazionePannelli.Errore,
                        colore:
                            segnalazione.Livello ==
                            LivelloSegnalazionePannelli.Errore
                                ? "Red"
                                : "DarkOrange",
                        dimensioneFont: 13,
                        report: false);
                }
            }

            reportPannelli.AggiungiTestoFormattato(
                "Dati iniziali di progetto",
                grassetto: true,
                colore: "DarkRed",
                dimensioneFont: 15,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Passo tubi:",
                risultato.DatiProgetto.PassoTubi,
                "m",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Diametro tubo:",
                risultato.DatiProgetto.DiametroEsternoTuboMm,
                "mm",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Spessore tubo:",
                risultato.DatiProgetto.SpessoreTuboMm,
                "mm",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Diametro interno tubo:",
                risultato.DatiProgetto.DiametroInternoTuboMm,
                "mm",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Temperatura mandata:",
                risultato.DatiProgetto.TemperaturaMandata,
                "°C",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Temperatura ambiente:",
                risultato.DatiProgetto.TemperaturaAmbiente,
                "°C",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Temperatura esterna di progetto:",
                risultato.DatiProgetto.TemperaturaEsternaProgetto,
                "°C",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Temperatura ritorno:",
                risultato.DatiProgetto.TemperaturaRitorno,
                "°C",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Salto termico:",
                risultato.DatiProgetto.SaltoTermico,
                "K",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Lunghezza matassa:",
                risultato.DatiProgetto.LunghezzaMatassa,
                "m",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Lunghezza massima circuito:",
                risultato.DatiProgetto.LunghezzaMassimaCircuito,
                "m",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Perdita di carico massima circuito:",
                risultato.DatiProgetto.PerditaCaricoMassimaCircuitoPa,
                "Pa",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Coefficiente provvisorio di resa:",
                risultato.DatiProgetto.CoefficienteResaWm2K,
                "W/m²K",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoFormattato(
                "Riepilogo geometrico",
                grassetto: true,
                colore: "DarkRed",
                dimensioneFont: 15,
                report: false);

            reportPannelli.AggiungiTestoConValorePar(
                "Piani censiti:",
                risultato.NumeroPiani,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            reportPannelli.AggiungiTestoConValorePar(
                "Locali censiti:",
                risultato.NumeroLocali,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            reportPannelli.AggiungiTestoConValorePar(
                "Circuiti generati:",
                risultato.NumeroCircuiti,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            reportPannelli.AggiungiTestoConValorePar(
                "Tubi di collegamento:",
                risultato.NumeroTubi,
                "n.",
                dimensioneFont: 14,
                NumeroIntero: true,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Superficie complessiva locali:",
                risultato.SuperficieTotaleLocali,
                "m²",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoConValore(
                "Lunghezza complessiva spirali:",
                risultato.LunghezzaTotaleSpirali,
                "m",
                dimensioneFont: 14,
                report: false);

            reportPannelli.AggiungiTestoFormattato(
                "Distinta dei circuiti",
                grassetto: true,
                colore: "DarkRed",
                dimensioneFont: 16,
                report: false);

            foreach (var piano in risultato.Piani)
            {
                reportPannelli.AggiungiTestoFormattato(
                    $"Piano: {piano.Nome}",
                    grassetto: true,
                    colore: "DarkRed",
                    dimensioneFont: 15,
                    report: false);

                foreach (var locale in piano.Locali)
                {
                    reportPannelli.AggiungiTestoFormattato(
                        $"Locale: {locale.Id}",
                        grassetto: true,
                        colore: "Blue",
                        dimensioneFont: 14,
                        report: false);

                    reportPannelli.AggiungiTestoConValore(
                        "Potenza richiesta locale:",
                        locale.PotenzaRichiesta,
                        "W",
                        dimensioneFont: 13,
                        report: false);

                    reportPannelli.AggiungiTestoConValore(
                        "Potenza erogabile locale:",
                        locale.PotenzaErogabile,
                        "W",
                        dimensioneFont: 13,
                        report: false);

                    if (locale.Circuiti.Count == 0)
                    {
                        reportPannelli.AggiungiTestoFormattato(
                            "Nessun circuito generato.",
                            colore: "DarkRed",
                            dimensioneFont: 13,
                            report: false);
                        continue;
                    }

                    foreach (var circuito in locale.Circuiti)
                    {
                        reportPannelli.AggiungiTestoFormattato(
                            circuito.Id,
                            grassetto: true,
                            colore: "Blue",
                            dimensioneFont: 13,
                            report: false);

                        reportPannelli.AggiungiTestoConValore(
                            "Passo tubi:",
                            circuito.PassoTubi,
                            "m",
                            dimensioneFont: 13,
                            report: false);

                        reportPannelli.AggiungiTestoConValore(
                            "Lunghezza circuito (provvisoria):",
                            circuito.LunghezzaCircuito,
                            "m",
                            dimensioneFont: 13,
                            report: false);

                        reportPannelli.AggiungiTestoConValore(
                            "Superficie servita:",
                            circuito.SuperficieServita,
                            "m²",
                            dimensioneFont: 13,
                            report: false);

                        reportPannelli.AggiungiTestoConValore(
                            "Potenza specifica:",
                            circuito.PotenzaSpecifica,
                            "W/m²",
                            dimensioneFont: 13,
                            report: false);

                        reportPannelli.AggiungiTestoConValore(
                            "Potenza richiesta:",
                            circuito.PotenzaRichiesta,
                            "W",
                            dimensioneFont: 13,
                            report: false);

                        reportPannelli.AggiungiTestoConValore(
                            "Potenza erogabile:",
                            circuito.PotenzaErogabile,
                            "W",
                            dimensioneFont: 13,
                            report: false);
                    }
                }
            }
        }

        // Funzione realizzata da Codex in autonomia
        private void MotoreSpiraliComboBox_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (MotoreSpiraliComboBox?.SelectedItem is ComboBoxItem voce && voce.Tag is string motore)
                IoPannelli.SelezionaMotore(motore);
        }
        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            TermodelLog.WriteLog("------------------- Window_Loaded -----------");

            MainWindow mainWindow = Application.Current.MainWindow as MainWindow;
            var drawBimControl = mainWindow?.GetDrawBimControl();
            Polig3D.LineeCostruzione = new LineManager(drawBimControl);

            // Modificato da Codex per realizzare: ascolto dei comandi grafici scritti da Codex.
            _comunicazioneAdvancedAI.ModalitaVisualizzazioneRichiesta +=
                ComunicazioneAdvancedAI_ModalitaVisualizzazioneRichiesta;
            _comunicazioneAdvancedAI.MenuRichiesto +=
                ComunicazioneAdvancedAI_MenuRichiesto;
            _comunicazioneAdvancedAI.ImportazioneSvgRichiesta +=
                ComunicazioneAdvancedAI_ImportazioneSvgRichiesta;
            _comunicazioneAdvancedAI.ComandoRicevuto +=
                ComunicazioneAdvancedAI_ComandoRicevuto;
            _comunicazioneAdvancedAI.InterfacciaRichiesta +=
                ComunicazioneAdvancedAI_InterfacciaRichiesta;
            _comunicazioneAdvancedAI.Avvia(
                System.IO.Path.Combine(GestProg.ProgramPath, "AdvancedAI"),
                "interfaccia.txt");

            DisattivaTuttiTabControls(this);
            AttivaTabControl(MainTabControl);
 
            utiDb.PopolaComboBox(ComboBoxDisegno, "Piani", "NomeFile");
            // Modificato da Codex per realizzare: recupero SVG prima della preparazione dello script CAD.
            PreparaDisegnoEScriptCad();

            Posizionamento_Iniziale();

            string val = UserIni.Ini.LoadVar("Tutor").ToLower();
            VisualizzaTutorMenu.IsChecked = val != "false";
            Settutor(VisualizzaTutorMenu.IsChecked);
            
            TermodelLog.WriteLog("------------------- Genera_modello() -----------");
            val = UserIni.Ini.LoadVar("GeneraModelloAvvio").ToLower();
            AggiornaModelloAvvioMenu.IsChecked = val != "false";
            if (AggiornaModelloAvvioMenu.IsChecked) Genera_modello();
#if DEBUG
#else
GeneraconIA.Visibility = Visibility.Collapsed; 
MenuArchivi.Visibility = Visibility.Collapsed; 
DatiClimatici.Visibility = Visibility.Collapsed; 
MenuCalcoli.Visibility = Visibility.Collapsed; 
#endif
            //MessageBox.Show("Dopo oscuramenti", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);

            // Carica la pagina TermodelBlazor nel Frame
            //MainFrame.Navigate(new TermodelBlazorHost());

            TermodelLog.WriteLog("-------------------fine  Window_Loaded -----------");

        }
        private bool Rivestimenti = false;
        public void SettaRivestimenti()
        {
            GestProg.Rivestimenti = Rivestimenti;
            //Settutor(!Rivestimenti);
            if (Rivestimenti)
            {

            }
        }

        public int Numeropiani()
        {
            // Recupera la collezione "Piani" dal database
            var pianicollection = utiDb.GetCollection("Piani");

            int numeroTotalePiani = 0;

            foreach (var piano in pianicollection)
            {
                // Verifica se il piano soddisfa i criteri
                if (piano.ContainsKey("Attivo") && piano["Attivo"].ToString() == "Attivo" &&
                    piano.ContainsKey("Tipo") && piano["Tipo"].ToString() == "Calpestabile")
                {
                    // Recupera il valore di "PianiUguali" e moltiplica
                    int pianiUguali = piano.ContainsKey("PianiUguali")
                        ? Convert.ToInt32(piano["PianiUguali"])
                        : 1; // Valore predefinito 1 se manca "PianiUguali"

                    numeroTotalePiani += pianiUguali;
                }
            }

            return numeroTotalePiani;
        }

 
        private void LoadTreeViewFromXml(string xmlFilePath, System.Windows.Controls.TreeView mytreeview)
        {
            // Controlla se il file esiste prima di eseguire la funzione
            if (!File.Exists(xmlFilePath))
            {
                Console.WriteLine($"Il file {xmlFilePath} non esiste.");
                return;
            }

            // Svuota il TreeView prima di aggiungere nuovi elementi
            mytreeview.Items.Clear();
            XDocument xdoc = XDocument.Load(xmlFilePath);
            if (xdoc.Root != null)
            {
                TreeViewItem rootItem = new TreeViewItem();
                rootItem.Header = xdoc.Root.Name.LocalName;
                mytreeview.Items.Add(rootItem);

                AddChildNodes(rootItem, xdoc.Root);
            }
        }
        private void AddChildNodes(TreeViewItem parentItem, XElement parentElement)
        {
            foreach (XElement element in parentElement.Elements())
            {
                TreeViewItem item = new TreeViewItem();
                //item.Header = element.ToString(); // Utilizza element.ToString() per ottenere una rappresentazione completa dell'elemento


                if (element.HasElements)
                {
                    item.Header = element.Name.LocalName; ;
                    parentItem.Items.Add(item);
                    AddChildNodes(item, element); // Ricorsivamente aggiunge i figli solo se ci sono elementi figlio
                }
                else
                {
                    item.Header = $"{element.Name.LocalName}: {element.Value.Trim()}";
                    parentItem.Items.Add(item);
                }
            }

        }
        private string GetSelectedGridValue(string nomecampo)
        {
            // Controlla se è stata selezionata una riga
            if (DbGridCor.SelectedItem != null)
            {
                // Verifica se l'elemento selezionato è un Dictionary<string, object>
                if (DbGridCor.SelectedItem is Dictionary<string, object> selectedRow)
                {
                    // Verifica se il dizionario contiene la chiave specificata
                    if (selectedRow.ContainsKey(nomecampo))
                    {
                        // Ottieni il valore associato alla chiave
                        object value = selectedRow[nomecampo];
                        return value != null ? value.ToString() : "Valore null";
                    }
                    else
                    {
                        ErrorManager.ErrorMessage = "Chiave " + nomecampo + " non trovata nella riga selezionata";
                        return ErrorManager.ErrorMessage;
                    }
                }
                else
                {
                    ErrorManager.ErrorMessage = "Il tipo dell'elemento selezionato non è un Dictionary<string, object>";
                    return ErrorManager.ErrorMessage;
                }
            }
            else
            {
                ErrorManager.ErrorMessage = "Nessuna riga selezionata";
                return ErrorManager.ErrorMessage;
            }
        }
        /*
        private string GetSelectedGridValue(string nomecampo)
        {
            // Controlla se è stata selezionata una riga e se non è la riga vuota aggiunta automaticamente
            if (DbGridCor.SelectedItem != null && DbGridCor.SelectedItem is DataRowView selectedItem)
            {
                // Ottieni il dizionario corrispondente alla riga selezionata
                var selectedRow = (Dictionary<string, object>)DbGridCor.SelectedItem;

                // Verifica se il dizionario contiene la chiave "LayerCad"
                if (selectedRow.ContainsKey(nomecampo))
                {
                    // Ottieni il valore associato alla chiave "LayerCad"
                    object layerCadValue = selectedRow[nomecampo];

                    // Converte il valore in una stringa e restituiscilo
                    return layerCadValue.ToString();
                }
                else
                {
                    ErrorManager.ErrorMessage = "Chiave " + nomecampo + " non trovata nella riga selezionata";
                    return ErrorManager.ErrorMessage;
                }
            }
            else
            {
                ErrorManager.ErrorMessage = " Nessuna riga selezionata";
                return ErrorManager.ErrorMessage;
            }
        }
        */
        private void LeggiDxf_click(object sender, RoutedEventArgs e)
        {
            String fileName = @"C:\DOCUMENTI\termomodel\prova2.DXF";
            LeggiDxf leggiDxf = new LeggiDxf(drawingCanvas, coordinateListBox, utiDb, modello_edificio);
            leggiDxf.LeggiFileDxf("??", 3, 3.3, fileName, "0", "Calpestabile", utiDb.GetCollection("Pareti"), 3,0);
        }

        private void SalvaTutto_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.MessageBox.Show("Il progetto è composto da tavole realizzate nel CAD che vengono salvate in formato DXF 2013 " +
                          "con l'apposito comando del CAD.\n\n" +
                          "Gli archivi contenenti i dati alfanumerici relativi al progetto sono accessibili dal menu Visualizza > Archivi.\n\n" +
                          "Il salvataggio degli archivi si realizza con l'apposito pulsante 'Salva' presente in basso.");


        }
        private void Salva_Click(object sender, RoutedEventArgs e)
        {
        utiDb.SaveRecordToXml<Dictionary<string, object>>(OCollection, GestProg.FileDatiPath(NomeArch));
            AggiornaDaticad();
        }
        private void AggiornaDaticad()
        {
            StopAggiornaForm = true;
            utiDb.SalvaForm("DatiCad", Grid_DatiCad, 0);
            utiDb.SaveData("DatiCad");//salva daticad

            //string Daticadcollection=utiDb.GetCollectionAsString("DatiCad"); //debug ,dati non corrotti

            utiDb.ConfigureForm(Grid_DatiCad, "DatiCad"); //corrompe daticad

            //Daticadcollection = utiDb.GetCollectionAsString("DatiCad"); //debug, dati corrotti


            utiDb.LoadData("DatiCad");//ripristina daticad
            utiDb.AutocompilaDatiCad();
            scriptCad.Script_Disegna(utiDb.GetCollection("DatiCad"));

            //Daticadcollection = utiDb.GetCollectionAsString("DatiCad"); //debug , i dati persistono corrotti

            utiDb.LeggiForm("DatiCad", Grid_DatiCad, 0);// compila la form
            
            utiDb.SaveData("DatiCad");
            StopAggiornaForm = false;
        }

        private void Aggiungiriga_Click(object sender, RoutedEventArgs e)
        {
            utiDb.AddEmptyRow(DbGridCor, DefType);
        }

        private void Cancellariga_Click(object sender, RoutedEventArgs e)
        {
            bool success = utiDb.RemoveRecord(DbGridCor, OCollection);
        }
        private void InserisciRigaPrima_Click(object sender, RoutedEventArgs e)
        {
            // Ottieni la riga selezionata dalla griglia
            var selectedRow = DbGridCor.SelectedItem as Dictionary<string, object>;
            if (selectedRow == null)
            {
                System.Windows.MessageBox.Show("Seleziona una riga nella griglia.");
                return;
            }

            // Trova l'indice della riga selezionata
            int selectedIndex = DbGridCor.Items.IndexOf(selectedRow);
            if (selectedIndex == -1)
            {
                System.Windows.MessageBox.Show("Riga selezionata non trovata.");
                return;
            }

            // Crea una nuova riga vuota
            var newRow = new Dictionary<string, object>();
            foreach (var column in DbGridCor.Columns)
            {
                newRow[column.Header.ToString()] = null; // Imposta tutti i valori a null
            }

            // Inserisci la nuova riga prima della riga selezionata
            if (OCollection is IList<Dictionary<string, object>> collection)
            {
                collection.Insert(selectedIndex, newRow);
            }
            else
            {
                System.Windows.MessageBox.Show("Errore nella collezione sottostante.");
                return;
            }

            // Aggiorna la griglia per riflettere i cambiamenti
            DbGridCor.Items.Refresh();
        }

        public void SetArchivio(string NomeArchivio)
        {
            ProgramStatus.SetVar(DefType, StBool.FALSE);
            DefType = NomeArchivio;
            ProgramStatus.SetVar(DefType, StBool.TRUE);
            Tutor.AggiornaTutor();
            NomeArch = NomeArchivio;
            OCollection = utiDb.GetCollection(NomeArchivio);
            DbGridCor.ItemsSource = utiDb.GetCollection(NomeArchivio);
            utiDb.ConfigureDataGrid(DbGridCor, NomeArchivio);
            utiDb.LoadData(NomeArchivio);
            SetButtonVisibility(NomeArchivio);
        }
        private void SetButtonVisibility(string archivio)
        {
            //Leggidxf.Visibility = Visibility.Collapsed;
            CaricaDaXML.Visibility = Visibility.Collapsed;
            Leggipiani.Visibility = Visibility.Collapsed;
            ApriCad.Visibility = Visibility.Collapsed;
            if (archivio == "Piani")
            {
                //Leggidxf.Visibility = Visibility.Visible;
                Leggipiani.Visibility = Visibility.Visible;
                ApriCad.Visibility = Visibility.Visible;
            }
            else if (archivio == "Pareti" || archivio == "Finestre" || archivio == "Ponti" || archivio == "Zone" || archivio == "NonClimatizzati")
            {
                CaricaDaXML.Visibility = Visibility.Visible;
            }
        }
  
        private void ToggleButton_Checked(object sender, RoutedEventArgs e)
        {
            ToggleButton checkedButton = sender as ToggleButton;

            // Deseleziona tutti gli altri ToggleButton nel StackPanel e rimuovi l'evidenziazione
            foreach (var child in (checkedButton.Parent as StackPanel).Children)
            {
                if (child is ToggleButton button && button != checkedButton)
                {
                    button.IsChecked = false;
                    button.ClearValue(ToggleButton.BackgroundProperty); // Ripristina lo stile originale del pulsante
                    button.ClearValue(ToggleButton.BorderBrushProperty); // Ripristina anche il bordo se necessario
                }
            }

            // Evidenzia il pulsante selezionato
            checkedButton.Background = new SolidColorBrush(Colors.LightBlue);  // Imposta il colore di sfondo del pulsante selezionato
            checkedButton.BorderBrush = new SolidColorBrush(Colors.DarkBlue);  // Optional: cambia anche il bordo per dare un effetto visivo
        }

        private void ToggleButton_Unchecked(object sender, RoutedEventArgs e)
        {
            ToggleButton uncheckedButton = sender as ToggleButton;

            // Ripristina lo stile originale quando il pulsante viene deselezionato
            uncheckedButton.ClearValue(ToggleButton.BackgroundProperty);
            uncheckedButton.ClearValue(ToggleButton.BorderBrushProperty);
        }


        private void CaricaDaXML_Click(object sender, RoutedEventArgs e)
        {
            LoadTreeViewFromXml(GestProg.FileXMLPath, treeXMLBase);
            if (DefType == "Pareti") GestXml.LoadParetiCollectionFromXml(GestProg.FileXMLPath, utiDb.GetCollection("Pareti"));
            else if (DefType == "Finestre") GestXml.LoadFinestreCollectionFromXml(GestProg.FileXMLPath, utiDb.GetCollection("Finestre"));
            else if (DefType == "Zone") GestXml.LoadZoneFromXML(GestProg.FileXMLPath, utiDb.GetCollection("Zone"));
            else if (DefType == "NonClimatizzati") GestXml.LoadNonClimatizzatiFromXML(GestProg.FileXMLPath, utiDb.GetCollection("NonClimatizzati"));
            else GestXml.LoadPontiCollectionFromXml_file(utiDb.GetCollection("Ponti"));
        }

        private void Leggidxf_Click_1(object sender, RoutedEventArgs e)
        {
            DatiProgControl.SelectedIndex = 2;
            String fileName = @"C:\DOCUMENTI\termomodel\prova2.DXF";
            LeggiDxf leggiDxf = new LeggiDxf(drawingCanvas, coordinateListBox, utiDb, modello_edificio);
            //leggiDxf.LeggiFileDxf(fileName, GetSelectedLayerCadValue());
            InfoString.Content = leggiDxf.LeggiFileDxf(GetSelectedGridValue("Nome"), 3, 3.3, GestProg.FileDXFPath(GetSelectedGridValue("NomeFile")), GetSelectedGridValue("LayerCad"), "Calpestabile", utiDb.GetCollection("Pareti"), 3,0);
        }
  

        public void LeggituttiiPiani(string PathXMLBase, string PathXMlOut)
        {
            // Modificato da Codex per realizzare: recupero automatico del DXF mancante dallo SVG del progetto.
            PreparaDxfMancanteDaSvg();
            GeneraModello.initclass(utiDb, drawingCanvas, coordinateListBox);
            PrimoErrore.Visibility = Visibility.Collapsed;
            GeneraModello.PrimoErrore = "";
            //await Task.Run(() => GeneraModello.LeggituttiiPiani(PathXMLBase, PathXMlOut));
            GeneraModello.LeggituttiiPiani(PathXMLBase, PathXMlOut);
            if (GeneraModello.PrimoErrore != "")
            {
                PrimoErrore.Visibility = Visibility.Visible;
                LabPrimoErrore.Content = GeneraModello.PrimoErrore;
            }


        }
        // Funzione realizzata da Codex in autonomia
        private void PreparaDisegnoEScriptCad()
        {
            try
            {
                PreparaDxfMancanteDaSvg();
            }
            catch (Exception ex)
            {
                // La form resta utilizzabile per correggere SVG o archivi del progetto.
                TermodelLog.WriteLog("Recupero SVG non riuscito: " + ex.Message);
                InfoString.Content = "Recupero SVG non riuscito: " + ex.Message;
            }

            try
            {
                // Aggiorna anche in assenza del DXF, per non conservare lo script del progetto precedente.
                scriptCad.Script_Aggiorna(ComboBoxDisegno.Text);
            }
            catch (Exception ex)
            {
                TermodelLog.WriteLog("Preparazione script CAD non riuscita: " + ex.Message);
                InfoString.Content = "Preparazione script CAD non riuscita: " + ex.Message;
            }
        }

        // Funzione realizzata da Codex in autonomia
        private void PreparaDxfMancanteDaSvg()
        {
            string dxf = System.IO.Path.Combine(GestProg.PathProg, "DisegnoInput.dxf");
            string svg = System.IO.Path.ChangeExtension(dxf, ".svg");
            if (File.Exists(dxf) || !File.Exists(svg)) return;
            var piani = utiDb.GetCollection("Piani").Where(p => string.Equals(
                p.GetValueOrDefault("NomeFile")?.ToString(), "DisegnoInput", StringComparison.OrdinalIgnoreCase)).ToList();
            var layers = piani.Where(p => string.Equals(p.GetValueOrDefault("Tipo")?.ToString(), "Calpestabile", StringComparison.OrdinalIgnoreCase))
                .Select(p => p.GetValueOrDefault("LayerCad")?.ToString()).Where(l => !string.IsNullOrWhiteSpace(l))
                .Distinct(StringComparer.OrdinalIgnoreCase).ToList();
            if (layers.Count != 1 || piani.Any(p => string.Equals(p.GetValueOrDefault("Tipo")?.ToString(), "Copertura", StringComparison.OrdinalIgnoreCase)
                && !string.Equals(p.GetValueOrDefault("LayerCad")?.ToString(), "copertura", StringComparison.OrdinalIgnoreCase)))
                throw new InvalidDataException("SVG automatico: occorre un unico layer calpestabile e l'eventuale layer copertura. Archivi non modificati.");
            var importatore = new CadGPT();
            try
            {
                importatore.CreaDxfMancanteDaSvg(svg, dxf, layers[0]!);
                TermodelLog.WriteLog("DXF generato automaticamente da SVG; dati dei piani conservati.");
            }
            finally { importatore.Close(); }
        }

        private void VisualizzaCalcolo_Click(object sender, RoutedEventArgs e)
        {
            ApriFinestraAPE();
        }
        private void ApriFinestraAPE()
        {
            var finestraAPE = new VisualizzaDatiApe();
            finestraAPE.ShowDialog();
        }

        // Modificato da Codex per realizzare: esecuzione controllata e senza finestre modali nel Workbench.
        internal bool Genera_modello(bool modalitaAutomatica = false)
        {
            //MessageBox.Show("Genera_modello", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);

            TermodelLog.InitializeLog();
            TermodelLog.WriteLog("Genera_modello()");
            Workinprogress win = null;
            if (!modalitaAutomatica)
            {
                win = new Workinprogress("Generazione del modello in corso");
                win.Owner = this;
                win.Show();
            }

            try
            {
                
                Application.Current.Dispatcher.Invoke(System.Windows.Threading.DispatcherPriority.Background,
                                          new Action(delegate { }));

                
                LoadTreeViewFromXml(GestProg.FileXMLPath, treeXMLBase);
                LeggituttiiPiani(GestProg.FileXMLPath, GestProg.FileXMLOutPath);
                LoadTreeViewFromXml(GestProg.FileXMLOutPath, treeXMLOut);
                win?.Close();
                if (!modalitaAutomatica)
                    TermodelLog.MostraErrore("Generazione del modello completata con successo!");
#if DEBUG
                if (GestXml.Esegui_calcolo_ape && !modalitaAutomatica)
                ApriFinestraAPE();
                //Unifilare_fotovoltaico.CreaUnifilareFotovoltaico();
#endif

                return true;
            }
            catch (Exception ex)
            {
                win?.Close();
                TermodelLog.LogError($"Errore durante la generazione del modello: {ex.Message}");
                return false;
            }
            finally
            {
                if (!modalitaAutomatica)
                {
                    this.Activate(); // ritorno focus
                    this.Focus();
                }
            }
        }

        // Funzione realizzata da Codex in autonomia
        internal bool EseguiVerificaWorkbench(out string errore)
        {
            errore = null;
            try
            {
                bool completato = Genera_modello(modalitaAutomatica: true);
                if (completato && TermodelLog.CisonoErrori())
                    completato = false;
                if (!completato)
                    errore = TermodelLog.erroreDaMostrare ?? "Generazione non completata.";
                return completato;
            }
            catch (Exception ex)
            {
                errore = ex.ToString();
                return false;
            }
        }
        private void daticlimatici_Click(object sender, RoutedEventArgs e)
        {
        var finestra = new Termodel.Calcoli.daticlimatici();
            finestra.Owner = this; // opzionale, se sei dentro una finestra WPF
            finestra.ShowDialog(); // usa Show() se non vuoi bloccare la finestra principale
         }
            private void AggiornaModelloButton_Click(object sender, RoutedEventArgs e)
        {
            Genera_modello();
        }
        private void Leggipiani_Click(object sender, RoutedEventArgs e)
        {
            Genera_modello();
 
        }
        private void Genera_Modello_calcolo_Click(object sender, RoutedEventArgs e)
        {
            // Vecchio codice:
            // GestXml.Esegui_calcolo_ape = true;
            // Genera_modello();
            // GestXml.Esegui_calcolo_ape = false;

        }
        public void DaticadCambiato()
        {
            if (!StopAggiornaForm)
            {
                utiDb.SalvaForm("DatiCad", Grid_DatiCad, 0);
                utiDb.CompilaCorrelati("DatiCad");
                utiDb.LeggiForm("DatiCad", Grid_DatiCad, 0);
                utiDb.SaveData("DatiCad");
                // Ottieni la collezione di parametri
                System.Collections.ObjectModel.ObservableCollection<System.Collections.Generic.Dictionary<string, object>> parametriCollection = utiDb.GetCollection("DatiCad");

                // Chiama il metodo ScriptDisegna con la collezione di parametri
                scriptCad.Script_Disegna(parametriCollection);
                scriptCad.CopiaBloccoTestoDaTab(disegnoTabControl.SelectedIndex);
            }
        }
        private void DatiCad_Change(object sender, SelectionChangedEventArgs e)
        {
            if (!StopAggiornaForm)
            {
                DaticadCambiato();

                // Copia il valore selezionato nella clipboard
                if (sender is ComboBox comboBox && comboBox.SelectedItem != null)
                {
                    string testo = comboBox.SelectedItem.ToString();

                    // Se stai usando oggetti complessi, puoi usare SelectedValue o SelectedItem.ToString()
                    Clipboard.SetText(testo);
                }
            }
        }

        private void AdjustFormSize(Grid grid)
        {
            var dimensions = utiDb.DimForm(grid);
            const double tabItemHeight = 0; // Altezza stimata per le linguette dei TabItem

            this.Width = dimensions.Width;
            this.Height = dimensions.Height + tabItemHeight * 2; // Aggiungi altezza per due linguette dei TabItem
        }

        private void disegnoTabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            if (Pareti.IsSelected)
            {
                // AdjustFormSize(Grid_DatiCad);
            }
            /*
            else if (Finestre.IsSelected)
            {
                AdjustFormSize(Grid_Finestre);
            }
            else if (PontiTermici.IsSelected)
            {
                AdjustFormSize(Grid_PontiTermici);
            }
            else if (Locali.IsSelected)
            {
                AdjustFormSize(Grid_Locali);
            }
            else if (Varie.IsSelected)
            {
                AdjustFormSize(Grid_Varie);
            }*/
        }
        private void Apri_Cad(string filePath)
        {
            // Ottieni il programma CAD selezionato dal ComboBox
            string selectedProgram = DatiCad_ProgrammaCad.SelectedItem as string;
            if (string.IsNullOrEmpty(selectedProgram))
            {
                System.Windows.MessageBox.Show("Seleziona un programma CAD dal menu a discesa.");
                return;
            }

            // Verifica quale programma CAD è selezionato
            if (selectedProgram == "Autocad")
            {
                // Ottieni la versione selezionata dal ComboBox
                string selectedVersion = DatiCad_VersioneCad.SelectedItem as string;
                if (string.IsNullOrEmpty(selectedVersion))
                {
                    System.Windows.MessageBox.Show("Seleziona una versione di AutoCAD dal menu a discesa.");
                    return;
                }

                // Trova il percorso dell'eseguibile AutoCAD per la versione selezionata
                string acadPath = ScriptCad.FindAutoCADExecutablePath(2020);
                if (string.IsNullOrEmpty(acadPath))
                {
                    System.Windows.MessageBox.Show("Impossibile trovare il percorso dell'eseguibile per la versione selezionata.");
                    return;
                }

                // Avvia AutoCAD con il file specificato
                scriptCad.OpenAutoCAD(filePath, acadPath);
            }
            else if (selectedProgram == "LibreCad")
            {
                // Percorso predefinito dell'eseguibile LibreCAD (modifica se necessario)
                string libreCadPath = @"C:\Program Files (x86)\LibreCAD\LibreCAD.exe";

                // Verifica se il file eseguibile di LibreCAD esiste
                if (!File.Exists(libreCadPath))
                {
                    System.Windows.MessageBox.Show("Impossibile trovare l'eseguibile di LibreCAD.");
                    return;
                }

                // Avvia LibreCAD con il file specificato
                Process.Start(libreCadPath, filePath);
            }
            else
            {
                System.Windows.MessageBox.Show("Programma CAD non supportato.");
            }
        }

        private void btnApriAutoCAD_Click(object sender, RoutedEventArgs e)
        {
            // Percorso del file da aprire
            string filePath = @"C:\DOCUMENTI\termomodel\progetti\prova\edificio.dxf";

            // Chiama la funzione ApriCad con il percorso del file
            Apri_Cad(filePath);
        }

        private void ApriCad_Click(object sender, RoutedEventArgs e)
        {
            // Ottieni la riga selezionata dalla DbGridCor
            var selectedRow = DbGridCor.SelectedItem as Dictionary<string, object>;
            if (selectedRow == null)
            {
                System.Windows.MessageBox.Show("Seleziona una riga nella griglia.");
                return;
            }

            // Ottieni il valore della colonna NomeFile dalla riga selezionata
            if (!selectedRow.TryGetValue("NomeFile", out object nomeFileObj) || nomeFileObj == null)
            {
                System.Windows.MessageBox.Show("Il campo NomeFile non può essere vuoto.");
                return;
            }

            string nomeFile = nomeFileObj as string;
            if (string.IsNullOrEmpty(nomeFile))
            {
                System.Windows.MessageBox.Show("Il campo NomeFile non può essere vuoto.");
                return;
            }
            // Ottieni il valore della colonna NomeFile dalla riga selezionata
            if (!selectedRow.TryGetValue("NomeFile", out object LayerCadFileObj) || LayerCadFileObj == null)
            {
                System.Windows.MessageBox.Show("Il campo LayerCad non può essere vuoto.");
                return;
            }

            string LayerCad = LayerCadFileObj as string;
            if (string.IsNullOrEmpty(LayerCad))
            {
                System.Windows.MessageBox.Show("Il campo LayerCad non può essere vuoto.");
                return;
            }
            // Ottieni il percorso completo del file DXF
            //string filePath = FileDXFNew(nomeFile);
            string filePath = System.IO.Path.Combine(GestProg.PathProg, $"{FileDXFNew(nomeFile)}");
            // Chiama la funzione ApriCad con il percorso del file
            System.Windows.MessageBox.Show($"Il file del disegno da editare si trova in:{filePath}");
            ProgramStatus.SetVar("CAD", StBool.TRUE);
            Tutor.AggiornaTutor();
            //Apri_Cad(filePath);
        }

        private void AprienergyPlus_Click(object sender, RoutedEventArgs e)
        {
            // Esegui EnergyPlus
            _energyPlus.RunSimulation();
        }

        private void RisultatienergyPlus_Click(object sender, RoutedEventArgs e)
        {
            _energyPlus.OpenResults();
        }

        private void MainTabControl_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            return;
            // Esegui solo se la form è completamente inizializzata
            if (!isInitialized)
                return;
            //utiDb.SaveRecordToXml<Dictionary<string, object>>(OCollection, FileDatiPath);
            //utiDb.ConfigureForm(Grid_DatiCad, "DatiCad");
        }

        private void PontiAutomaticiButton_Click(object sender, RoutedEventArgs e)
        {
            SetArchivio("PontiAutomatici");
        }

        private void DbGridCor_RowEditEnding(object sender, DataGridRowEditEndingEventArgs e)
        {

            if (e.EditAction == DataGridEditAction.Commit && e.Row.IsNewItem)
            {
                // Chiama la tua funzione per aggiungere la riga personalizzata
                //utiDb.AddEmptyRow(DbGridCor, DefType);
            }
        }
        private void DatiCad_button_Change(object sender, RoutedEventArgs e)
        {
            DaticadCambiato();
        }

        private void NumericInputOnly(object sender, TextCompositionEventArgs e)
        {
            TextBox textBox = sender as TextBox;

            // Combina il testo esistente con il nuovo carattere per validare l'intero contenuto
            string newText = textBox.Text + e.Text;

            // Consente solo numeri decimali e un singolo punto
            e.Handled = !double.TryParse(newText,
            System.Globalization.NumberStyles.AllowDecimalPoint | System.Globalization.NumberStyles.AllowLeadingSign,
            System.Globalization.CultureInfo.InvariantCulture, out _);
        }
        NuovoProgetto formNuovoProgetto = null;
        private void XML_Click_Importa(object sender, RoutedEventArgs e)
        {
            // Percorso iniziale: Documenti\Termodel\esempixml
            string documenti = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);
            string cartellaIniziale = System.IO.Path.Combine(documenti, "Termodel", "esempixml");

            // Destinazione del file XML nel progetto
            string destinazioneXml = System.IO.Path.Combine(GestProg.PathProg, "xml", "input.xml");

            // OpenFileDialog per selezionare file XML
            Microsoft.Win32.OpenFileDialog dlg = new Microsoft.Win32.OpenFileDialog
            {
                Title = "Seleziona un file XML",
                Filter = "File XML (*.xml)|*.xml",
                InitialDirectory = cartellaIniziale,
                CheckFileExists = true
            };

            // Mostra la finestra di selezione file
            bool? result = dlg.ShowDialog();

            if (result == true)
            {
                try
                {
                    // Copia il file selezionato nella destinazione
                    File.Copy(dlg.FileName, destinazioneXml, true);
                    XMLConverter.SaveAsJson(destinazioneXml);
                    LoadTreeViewFromXml(destinazioneXml, treeXMLBase);
                    // Conferma all’utente
                    MessageBox.Show("File XML importato correttamente.", "Importazione completata", MessageBoxButton.OK, MessageBoxImage.Information);

                    // Esegue la funzione
                    AggiornaDaXml();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Errore durante l'importazione del file XML:\n{ex.Message}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        public void AggiornaDaXml()
        {
            utiDb.LoadAllData();
            GestXml.LoadZoneFromXML(GestProg.FileXMLPath, utiDb.GetCollection("Zone"));
            GestXml.LoadParetiCollectionFromXml(GestProg.FileXMLPath, utiDb.GetCollection("Pareti"));
            GestXml.LoadFinestreCollectionFromXml(GestProg.FileXMLPath, utiDb.GetCollection("Finestre"));
            //GestXml.LoadPontiCollectionFromXml(GestProg.FileXMLPath, utiDb.GetCollection("Ponti"));
            utiDb.SaveAllData();
        }
        private void MenuSalvaProgettoZip_Click(object sender, RoutedEventArgs e)
        {
        GestProg.SalvaProgettoZippato(GestProg.PathProg);
        }

        private void MenuCaricaProgettoZip_Click(object sender, RoutedEventArgs e)
        {
            string cartellaProgetto = GestProg.LeggiProgettoZippato();
            if (cartellaProgetto == null) return;

            string cartellaPadre = System.IO.Path.GetDirectoryName(cartellaProgetto);
            string nomeProgetto = System.IO.Path.GetFileName(cartellaProgetto);

            // Imposta il progetto corrente e aggiorna
            GestProg.SetProgcor(cartellaPadre, nomeProgetto);
            AggiornaProgetto();
        }

        private void Nuovo_Click(object sender, RoutedEventArgs e)
        {

            formNuovoProgetto = new Termodel.utilities.NuovoProgetto();
            string defaultPath = System.IO.Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
           "TermodelUserData"
            ) + "\\";
            formNuovoProgetto.CartellaTextBox.Text = defaultPath;
            formNuovoProgetto.NomeProgettoTextBox.Text = NuovoProgetto.GeneraNomeProgettoTermodel(GestProg.UserDataPath);
            string nomeXML = Rivestimenti ? "Analisi rivestimenti" : "1 Zona Caldaia e componenti edilizi";
            defaultPath = System.IO.Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
           "Termodel", "esempiXML"
            ) + "\\"+ nomeXML+".xml";
            formNuovoProgetto.XmlTextBox.Text = defaultPath;
            defaultPath = System.IO.Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
           "Termodel", "Modelli", "Unico piano non mansardato"
            ) + "\\";
            formNuovoProgetto.CartellaModelloTextBox.Text = defaultPath;
            defaultPath = System.IO.Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
           "Termodel", "Modelli", "Ponti termici per edificio senza isolamento"
            ) + "\\";
            formNuovoProgetto.CartellaModelloPontiTextBox.Text = defaultPath;
            if (Rivestimenti) formNuovoProgetto.OscuraPerRivestimenti();
            bool? result = formNuovoProgetto.ShowDialog();
            if (result == true)
            {
                string newdir = System.IO.Path.Combine(formNuovoProgetto.CartellaTextBox.Text, formNuovoProgetto.NomeProgettoTextBox.Text) + "\\";
                Apriprogetto.AggiungiARecenti(newdir);

                GestProg.CopyDirectoryContents(formNuovoProgetto.CartellaModelloTextBox.Text, newdir);
                
                string pathpontiorig = System.IO.Path.Combine(formNuovoProgetto.CartellaModelloPontiTextBox.Text,"dbtempfiles");
                string pathpontidest = System.IO.Path.Combine(formNuovoProgetto.ProgettoPath, formNuovoProgetto.NomeProgetto, "dbtempfiles");
                File.Copy(System.IO.Path.Combine(pathpontiorig, "Ponti.xml"), System.IO.Path.Combine(pathpontidest, "Ponti.xml"), overwrite: true);
                File.Copy(System.IO.Path.Combine(pathpontiorig, "PontiAutomatici.xml"), System.IO.Path.Combine(pathpontidest, "PontiAutomatici.xml"), overwrite: true);
                File.Copy(System.IO.Path.Combine(pathpontiorig, "PontiAutomaticiFinestre.xml"), System.IO.Path.Combine(pathpontidest, "PontiAutomaticiFinestre.xml"), overwrite: true);

                GestProg.SetProgcor(formNuovoProgetto.ProgettoPath, formNuovoProgetto.NomeProgetto);
                this.Title = GestProg.InitProgetto();
                utiDb.PopolaComboBox(ComboBoxDisegno, "Piani", "NomeFile");
                // Modificato da Codex per realizzare: preparazione CAD dopo l'inizializzazione dei Piani.
                // Copia il file XML selezionato
                if (!string.IsNullOrEmpty(formNuovoProgetto.XmlPath))
                {
                    string destinazioneXml = System.IO.Path.Combine(GestProg.PathProg, "xml", "input.xml");
                    File.Copy(formNuovoProgetto.XmlPath, GestProg.FileXMLPath, overwrite: true);
                    XMLConverter.SaveAsJson(GestProg.FileXMLPath);
                    AggiornaDaXml();
                    utiDb.ConfigureForm(Grid_DatiCad, "DatiCad");
                    //utiDb.LeggiForm("DatiCad", Grid_DatiCad, 0);
                    LoadTreeViewFromXml(GestProg.FileXMLPath, treeXMLBase);
                    formNuovoProgetto.Nuovo_Piani();
                    utiDb.PopolaComboBox(ComboBoxDisegno, "Piani", "NomeFile");
                    // Modificato da Codex per realizzare: recupero SVG con i Piani del nuovo progetto già pronti.
                    PreparaDisegnoEScriptCad();
                    AggiornaDaticad();
                    MessageBox.Show("Il nuovo progetto è stato creato con successo.", "Conferma", MessageBoxButton.OK, MessageBoxImage.Information);
                    
                    #if DEBUG
                    //var finestra = new CadGPT();

                    //finestra.Owner = this;
                    //finestra.ShowDialog(); // 👈 apertura MODALE
                    #else
                    
                    #endif


                    Genera_modello();
                    //LeggituttiiPiani(GestProg.FileXMLPath, GestProg.FileXMLOutPath);
                    //LoadTreeViewFromXml(GestProg.FileXMLOutPath, treeXMLOut);
                }
                else
                {
                    // Modificato da Codex per realizzare: aggiornamento dello script anche senza XML selezionato.
                    PreparaDisegnoEScriptCad();
                }
            }
            else
            {
                Console.WriteLine("Operazione annullata.");
            }
        }
        public void AggiornaProgetto()
        {
            this.Title = GestProg.InitProgetto();
            utiDb.PopolaComboBox(ComboBoxDisegno, "Piani", "NomeFile");
            // Modificato da Codex per realizzare: recupero SVG anche con generazione automatica disattivata.
            PreparaDisegnoEScriptCad();
            if (AggiornaModelloAvvioMenu.IsChecked)
                //LeggituttiiPiani(GestProg.FileXMLPath, GestProg.FileXMLOutPath);
                Genera_modello();
        }
        private void Apri_Click(object sender, RoutedEventArgs e)
        {
            // Apri il dialogo per selezionare la cartella
            //var cartella = FileDia.SelezionaCartella("Selezionare la cartella del progetto da aprire");
            string cartella = "";

            var dlg = new Apriprogetto();
            bool? risultato = dlg.ShowDialog();

            if (risultato == true && !string.IsNullOrEmpty(dlg.CartellaSelezionata))
            {
                cartella = dlg.CartellaSelezionata;
                Apriprogetto.AggiungiARecenti(cartella);
                // Procedi con il caricamento del progetto da "cartella"
            }
            else
            {
                return; // L'utente ha annullato
            }

            if (!string.IsNullOrEmpty(cartella))
            {
                // Percorso della sottocartella "dbtempfiles"
                string dbTempFilesPath = System.IO.Path.Combine(cartella, "dbtempfiles");

                // Controllo se la cartella esiste
                if (Directory.Exists(dbTempFilesPath))
                {
                    // Imposta il progetto corrente e aggiorna
                    GestProg.SetProgcor(System.IO.Path.GetDirectoryName(cartella), System.IO.Path.GetFileName(cartella));
                    
                    AggiornaProgetto();
                }
                else
                {
                    // Mostra il messaggio di errore
                    MessageBox.Show("La cartella selezionata non contiene un progetto Termodel.", "Errore", MessageBoxButton.OK, MessageBoxImage.Warning);
                }
            }
        }

        /*
        private void Salva_Click(object sender, RoutedEventArgs e)
        {
            // Logica per salvare il file
            MessageBox.Show("File salvato.");
        }
        */
        private void SalvaConNome_Click(object sender, RoutedEventArgs e)
        {
            var formSalvaConNome = new Termodel.utilities.NuovoProgetto(true);
            bool? result = formSalvaConNome.ShowDialog();

            if (result == true)
            {
                string newdir = System.IO.Path.Combine(formSalvaConNome.ProgettoPath, formSalvaConNome.NomeProgetto);
                if (!Directory.Exists(newdir))
                {
                    try
                    {
                        Directory.CreateDirectory(newdir);
                    }
                    catch (Exception ex)
                    {
                        System.Windows.MessageBox.Show($"Errore durante la creazione della directory: {ex.Message}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                        return; // Esci dalla funzione se si verifica un errore
                    }
                }
                string oldProgettiPath = GestProg.ProgettiPath;
                string oldNomeProg = GestProg.NomeProg;
                GestProg.CopyDirectoryContents(System.IO.Path.Combine(oldProgettiPath, oldNomeProg), newdir);
                // Gestisci la logica per salvare il progetto con un nuovo nome o percorso
                GestProg.SetProgcor(formSalvaConNome.ProgettoPath, formSalvaConNome.NomeProgetto);
                this.Title = GestProg.InitProgetto(true);
                GeneraModello.initclass(utiDb, drawingCanvas, coordinateListBox);
                LeggituttiiPiani(GestProg.FileXMLPath, GestProg.FileXMLOutPath);
            }
            else
            {
                Console.WriteLine("Operazione di Salva con Nome annullata.");
            }
        }

        private void Esci_Click(object sender, RoutedEventArgs e)
        {
            // Chiudi l'applicazione
            this.Close();
        }

        private void Copia_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.MessageBox.Show("Elemento copiato.");
        }

        private void Incolla_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.MessageBox.Show("Elemento incollato.");
        }

        private void Elimina_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.MessageBox.Show("Elemento eliminato.");
        }

        private void ZoomIn_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.MessageBox.Show("Zoom In.");
        }

        private void ZoomOut_Click(object sender, RoutedEventArgs e)
        {
            DisattivaTuttiTabControls(this);
            //MessageBox.Show("Zoom Out.");
        }
        private void DisattivaTuttiTabControls(FrameworkElement rootElement)
        {
            return;
            // Trova tutti i TabControl e TabItem all'interno del layout
            foreach (var tabControl in FindVisualChildren<TabControl>(rootElement))
            {
                tabControl.Visibility = Visibility.Collapsed; // Oscura il TabControl
            }

            foreach (var tabItem in FindVisualChildren<TabItem>(rootElement))
            {
                tabItem.IsEnabled = false; // Disattiva ogni TabItem
            }
        }
        private IEnumerable<T> FindVisualChildren<T>(DependencyObject depObj) where T : DependencyObject
        {
            if (depObj != null)
            {
                for (int i = 0; i < VisualTreeHelper.GetChildrenCount(depObj); i++)
                {
                    DependencyObject child = VisualTreeHelper.GetChild(depObj, i);
                    if (child is T childOfType)
                    {
                        yield return childOfType;
                    }

                    foreach (T childOfChild in FindVisualChildren<T>(child))
                    {
                        yield return childOfChild;
                    }
                }
            }
        }
        private void AttivaTabControl(TabControl specificoTabControl)
        {
            return;
            AggiornaGrigliaTabControls(1, new GridLength(1, GridUnitType.Star)); // Prima riga: Espandibile
            AggiornaGrigliaTabControls(0, new GridLength(0));
            return;
            if (specificoTabControl == null)
            {
                Console.WriteLine("Errore: TabControl è nullo.");
                return;
            }

            Console.WriteLine($"Attivazione del TabControl: {specificoTabControl.Name}");

            // Mostra il TabControl
            specificoTabControl.Visibility = Visibility.Visible;

            // Attiva ogni TabItem
            foreach (var item in specificoTabControl.Items)
            {
                if (item is TabItem tabItem)
                {
                    tabItem.IsEnabled = true;
                    Console.WriteLine($"TabItem '{tabItem.Header}' è stato abilitato.");
                }
            }

            // Seleziona il primo TabItem (opzionale)
            if (specificoTabControl.Items.Count > 0)
            {
                specificoTabControl.SelectedIndex = 0;
                Console.WriteLine($"TabItem selezionato: {specificoTabControl.SelectedItem}");
            }
        }
        private void PosizionaInBassoDestra()
        {
            Rect areaLavoro = SystemParameters.WorkArea;

            double offsetBarraAutoCAD = 40; // Altezza stimata status bar

            this.Left = areaLavoro.Right - this.Width;
            this.Top = areaLavoro.Bottom - this.Height - offsetBarraAutoCAD;
        }
        private void Window_Closing(object sender, CancelEventArgs e)
        {
            // Modificato da Codex per realizzare: arresto del watcher Advanced AI alla chiusura.
            _comunicazioneAdvancedAI.Dispose();
            ComunicazioneAutoCad.ArrestaGestoreRichieste();
            // Salva posizione corrente in base alla modalità attiva
            WindowPositionManager.Salva(this, ModoPlugin);
        }

        // Funzione realizzata da Codex in autonomia
        private void ComunicazioneAdvancedAI_ModalitaVisualizzazioneRichiesta(
            object? sender,
            ModalitaVisualizzazioneEventArgs e)
        {
            Dispatcher.BeginInvoke(new Action(() =>
            {
                if (e.Modalita == ModalitaVisualizzazione.Diagnostica2D)
                {
                    Polig3D.VisualizzaDiagnosticaDxf(ricalcolaVista: true);
                    return;
                }

                PrimoErrore.Visibility = Visibility.Collapsed;
                Polig3D.GrafRedraw(RecalcView: true, forzaModello3D: true);
            }));
        }

        // Funzione realizzata da Codex in autonomia
        private void ComunicazioneAdvancedAI_MenuRichiesto(
            object? sender,
            MenuAdvancedAIEventArgs e)
        {
            Dispatcher.BeginInvoke(new Action(() =>
            {
                if (string.Equals(e.Voce, "nuovo", StringComparison.OrdinalIgnoreCase))
                {
                    Nuovo_Click(this, new RoutedEventArgs());
                }
            }));
        }

        // Funzione realizzata da Codex in autonomia
        private void ComunicazioneAdvancedAI_ImportazioneSvgRichiesta(
            object? sender,
            ImportazioneSvgAdvancedAIEventArgs e)
        {
            Dispatcher.BeginInvoke(new Action(() =>
            {
                try
                {
                    // Modificato da Codex per realizzare: importazione SVG da file senza mostrare la form CadGPT.
                    var importatore = new CadGPT();
                    importatore.ImportaSvgDaFile(e.PercorsoSvg);
                    importatore.Close();
                    Genera_modello();
                }
                catch (Exception ex)
                {
                    TermodelLog.LogError($"Errore durante l'importazione AdvancedAI del file SVG: {ex.Message}");
                }
            }));
        }

        // Funzione realizzata da Codex in autonomia
        private void ComunicazioneAdvancedAI_ComandoRicevuto(
            object? sender,
            ComandoAdvancedAIEventArgs e)
        {
            Dispatcher.BeginInvoke(new Action(() => AggiungiComandoAdvancedAI(e.Comando)));
        }

        // Funzione realizzata da Codex in autonomia
        private void ComunicazioneAdvancedAI_InterfacciaRichiesta(
            object? sender,
            InterfacciaAdvancedAIEventArgs e)
        {
            Dispatcher.BeginInvoke(new Action(() =>
            {
                if (e.Modalita == ModalitaInterfacciaAdvancedAI.MinimalistaAffiancata)
                {
                    AttivaModalitaAdvancedAIMinimalista();
                }
                // Modificato da Codex per realizzare: comando di spostamento senza input simulato.
                else if (e.Modalita == ModalitaInterfacciaAdvancedAI.Secondario)
                {
                    SpostaAdvancedAISulSecondario();
                }
                else
                {
                    DisattivaModalitaAdvancedAIMinimalista();
                }
            }));
        }

        // Funzione realizzata da Codex in autonomia
        private void SpostaAdvancedAISulSecondario()
        {
            var schermo = System.Windows.Forms.Screen.AllScreens.FirstOrDefault(s => !s.Primary);
            if (schermo is null)
            {
                AggiungiComandoAdvancedAI("Monitor secondario non disponibile");
                return;
            }

            var area = schermo.WorkingArea;
            WindowState = WindowState.Normal;
            var handle = new System.Windows.Interop.WindowInteropHelper(this).Handle;
            if (!PosizionaFinestraAdvancedAI(handle, IntPtr.Zero, area.Left, area.Top,
                area.Width, area.Height, 0x0004 | 0x0010))
                AggiungiComandoAdvancedAI("Spostamento sul monitor secondario non riuscito");
            else
                AggiungiComandoAdvancedAI("Finestra spostata sul monitor secondario");
        }

        // Funzione realizzata da Codex in autonomia
        [DllImport("user32.dll", EntryPoint = "SetWindowPos", SetLastError = true)]
        private static extern bool PosizionaFinestraAdvancedAI(IntPtr handle, IntPtr dopo,
            int x, int y, int larghezza, int altezza, uint flags);

        // Funzione realizzata da Codex in autonomia
        private void AggiungiComandoAdvancedAI(string comando)
        {
            _comandiAdvancedAI.Enqueue($"{DateTime.Now:HH:mm:ss}  {comando}");
            while (_comandiAdvancedAI.Count > NumeroComandiAdvancedAIVisibili)
            {
                _comandiAdvancedAI.Dequeue();
            }

            AdvancedAICommandText.Text = string.Join(Environment.NewLine, _comandiAdvancedAI);
        }

        // Funzione realizzata da Codex in autonomia
        private void AttivaModalitaAdvancedAIMinimalista()
        {
            if (_modalitaAdvancedAIMinimalista)
            {
                PosizionaAccantoACodex();
                return;
            }

            _modalitaAdvancedAIMinimalista = true;
            _statoFinestraPrimaMinimalista = WindowState;
            _rettangoloFinestraPrimaMinimalista = WindowState == WindowState.Normal
                ? new Rect(Left, Top, Width, Height)
                : RestoreBounds;
            _visibilitaMenuPrimaMinimalista = MainMenu.Visibility;
            _visibilitaTutorPrimaMinimalista = TutorBorder.Visibility;
            _visibilitaGridGeneralePrimaMinimalista = GridGenerale.Visibility;
            _visibilitaGridArchiviPrimaMinimalista = GridArchivi.Visibility;
            _visibilitaGridDatiCadPrimaMinimalista = Grid_DatiCad.Visibility;
            _visibilitaPrimoErrorePrimaMinimalista = PrimoErrore.Visibility;
            _visibilitaBarraControlliPrimaMinimalista = BarraControlliModello.Visibility;
            _intestazioneTabModelloPrimaMinimalista = TabModello.Header;
            _bordoMainTabControlPrimaMinimalista = MainTabControl.BorderThickness;
            _paddingMainTabControlPrimaMinimalista = MainTabControl.Padding;
            _topmostPrimaMinimalista = Topmost;

            _visibilitaSchedePrimaMinimalista.Clear();
            foreach (TabItem scheda in MainTabControl.Items.OfType<TabItem>())
            {
                _visibilitaSchedePrimaMinimalista[scheda] = scheda.Visibility;
                scheda.Visibility = scheda == TabModello ? Visibility.Visible : Visibility.Collapsed;
            }

            MainMenu.Visibility = Visibility.Collapsed;
            TutorBorder.Visibility = Visibility.Collapsed;
            GridArchivi.Visibility = Visibility.Collapsed;
            Grid_DatiCad.Visibility = Visibility.Collapsed;
            GridGenerale.Visibility = Visibility.Visible;
            MainTabControl.SelectedItem = TabModello;
            TabModello.Header = null;
            MainTabControl.BorderThickness = new Thickness(0);
            MainTabControl.Padding = new Thickness(0);
            PrimoErrore.Visibility = Visibility.Collapsed;
            BarraControlliModello.Visibility = Visibility.Collapsed;
            AdvancedAICommandPanel.Visibility = Visibility.Visible;
            AggiungiComandoAdvancedAI("Modalità minimale attivata");
            PosizionaAccantoACodex();
        }

        // Funzione realizzata da Codex in autonomia
        private void DisattivaModalitaAdvancedAIMinimalista()
        {
            if (!_modalitaAdvancedAIMinimalista)
            {
                return;
            }

            _modalitaAdvancedAIMinimalista = false;
            WindowState = WindowState.Normal;
            Left = _rettangoloFinestraPrimaMinimalista.Left;
            Top = _rettangoloFinestraPrimaMinimalista.Top;
            Width = _rettangoloFinestraPrimaMinimalista.Width;
            Height = _rettangoloFinestraPrimaMinimalista.Height;
            MainMenu.Visibility = _visibilitaMenuPrimaMinimalista;
            TutorBorder.Visibility = _visibilitaTutorPrimaMinimalista;
            GridGenerale.Visibility = _visibilitaGridGeneralePrimaMinimalista;
            GridArchivi.Visibility = _visibilitaGridArchiviPrimaMinimalista;
            Grid_DatiCad.Visibility = _visibilitaGridDatiCadPrimaMinimalista;
            PrimoErrore.Visibility = _visibilitaPrimoErrorePrimaMinimalista;
            TabModello.Header = _intestazioneTabModelloPrimaMinimalista;
            foreach (var voce in _visibilitaSchedePrimaMinimalista)
            {
                voce.Key.Visibility = voce.Value;
            }

            MainTabControl.BorderThickness = _bordoMainTabControlPrimaMinimalista;
            MainTabControl.Padding = _paddingMainTabControlPrimaMinimalista;
            BarraControlliModello.Visibility = _visibilitaBarraControlliPrimaMinimalista;
            AdvancedAICommandPanel.Visibility = Visibility.Collapsed;
            Topmost = _topmostPrimaMinimalista;
            WindowState = _statoFinestraPrimaMinimalista;
        }

        // Funzione realizzata da Codex in autonomia
        private void PosizionaAccantoACodex()
        {
            // Modificato da Codex per realizzare: affiancamento sul monitor di Codex usando solo coordinate Win32.
            // WorkingArea esclude la barra Windows; SetWindowPos evita di mescolare pixel e unità WPF.
            foreach (var codexHandle in TrovaFinestreClientAI())
            {
                {
                    try
                    {
                        if (codexHandle == IntPtr.Zero || !GetWindowRect(codexHandle, out var bordo))
                            continue;
                        var area = System.Windows.Forms.Screen.FromHandle(codexHandle).WorkingArea;
                        if (bordo.Bottom <= area.Top || bordo.Top >= area.Bottom ||
                            bordo.Right <= area.Left || bordo.Right >= area.Right)
                            continue;

                        int sinistra = Math.Max(area.Left, bordo.Right);
                        if (area.Right - sinistra < 200)
                            continue;

                        WindowState = WindowState.Normal;
                        var handle = new System.Windows.Interop.WindowInteropHelper(this).Handle;
                        if (!PosizionaFinestraAdvancedAI(handle, IntPtr.Zero, sinistra, area.Top,
                            area.Right - sinistra, area.Height, 0x0004 | 0x0010))
                            AggiungiComandoAdvancedAI("Affiancamento non riuscito");
                        else
                            AggiungiComandoAdvancedAI("Affiancato a Codex; barra Windows libera");
                        return;
                    }
                    catch (InvalidOperationException) { }
                    catch (System.ComponentModel.Win32Exception) { }
                }
            }

            AggiungiComandoAdvancedAI("Affiancamento: finestra Codex non rilevata o spazio insufficiente");
        }

        // Funzione realizzata da Codex in autonomia
        private static List<IntPtr> TrovaFinestreClientAI()
        {
            var finestre = new List<IntPtr>();
            EnumWindowsAdvancedAI((handle, _) =>
            {
                if (!IsWindowVisibleAdvancedAI(handle) || IsIconicAdvancedAI(handle)) return true;
                GetWindowThreadProcessIdAdvancedAI(handle, out uint pid);
                try
                {
                    using var processo = Process.GetProcessById((int)pid);
                    if (string.Equals(processo.ProcessName, "Codex", StringComparison.OrdinalIgnoreCase) ||
                        string.Equals(processo.ProcessName, "ChatGPT", StringComparison.OrdinalIgnoreCase))
                        finestre.Add(handle);
                }
                catch (ArgumentException) { }
                catch (InvalidOperationException) { }
                catch (System.ComponentModel.Win32Exception) { }
                return true;
            }, IntPtr.Zero);
            return finestre;
        }

        private delegate bool EnumWindowsCallbackAdvancedAI(IntPtr handle, IntPtr parametro);

        // Funzione realizzata da Codex in autonomia
        [DllImport("user32.dll", EntryPoint = "EnumWindows")]
        private static extern bool EnumWindowsAdvancedAI(EnumWindowsCallbackAdvancedAI callback, IntPtr parametro);
        // Funzione realizzata da Codex in autonomia
        [DllImport("user32.dll", EntryPoint = "IsWindowVisible")]
        private static extern bool IsWindowVisibleAdvancedAI(IntPtr handle);
        // Funzione realizzata da Codex in autonomia
        [DllImport("user32.dll", EntryPoint = "IsIconic")]
        private static extern bool IsIconicAdvancedAI(IntPtr handle);
        // Funzione realizzata da Codex in autonomia
        [DllImport("user32.dll", EntryPoint = "GetWindowThreadProcessId")]
        private static extern uint GetWindowThreadProcessIdAdvancedAI(IntPtr handle, out uint pid);

        // Funzione realizzata da Codex in autonomia
        private static double TrovaBordoDestroCodex(Rect area)
        {
            try
            {
                var processoCodex = Process.GetProcessesByName("Codex")
                    .FirstOrDefault(p => p.MainWindowHandle != IntPtr.Zero);
                if (processoCodex is not null &&
                    GetWindowRect(processoCodex.MainWindowHandle, out RettangoloWin32 rettangolo) &&
                    rettangolo.Left < area.Left + area.Width / 2 &&
                    rettangolo.Right > area.Left + 300 &&
                    rettangolo.Right < area.Right - 300)
                {
                    return rettangolo.Right;
                }
            }
            catch
            {
                // Il fallback mantiene disponibile la modalità anche se Codex non è rilevabile.
            }

            return area.Left + LarghezzaCodexRiservata;
        }

        // Funzione realizzata da Codex in autonomia
        private void MainWindow_PreviewKeyDown(object sender, KeyEventArgs e)
        {
            if (_modalitaAdvancedAIMinimalista && e.Key == Key.Escape)
            {
                DisattivaModalitaAdvancedAIMinimalista();
                e.Handled = true;
            }
        }
        //----------------  Posizionamento e Plugin
        private void Pluggin_Click(object sender, RoutedEventArgs e)
        {
            WindowPositionManager.Salva(this, false);
            ModoPlugin = true;
            Grid_DatiCad.Visibility = Visibility.Visible;
            GridGenerale.Visibility = Visibility.Collapsed;
            GridArchivi.Visibility = Visibility.Collapsed;
            ProgramStatus.SetVar("Pluggin", "true");
            ProgramStatus.SetVar("Archivi", "false");
            ProgramStatus.SetVar("CAD", StBool.FALSE);

            this.WindowState = WindowState.Normal;
            this.Topmost = true;

            bool posizioneApplicata = WindowPositionManager.Applica(this, true);
            if (!posizioneApplicata)
            {
                this.Width = 470;
                this.Height = 620;
                PosizionaInBassoDestra(); // fallback in basso a destra
            }
            Tutor.AggiornaTutor();
            SettutorPlugin(false);
            return;
        }
        private void Posizionamento_Iniziale()
        {
            bool posizioneApplicata = WindowPositionManager.Applica(this, false);

            if (!posizioneApplicata)
            {
                // fallback se la posizione non è valida o non salvata
                Rect area = SystemParameters.WorkArea;
                this.Left = area.Left;
                this.Top = area.Top;
                this.Width = area.Width;
                this.Height = area.Height;
            }
            this.WindowStartupLocation = WindowStartupLocation.Manual;
            this.WindowState = WindowState.Maximized; // Massimizza la finestra
        }
        private void Modello_Click(object sender, RoutedEventArgs e)
        {
            WindowPositionManager.Salva(this, true);
            ModoPlugin = false;
            GridGenerale.Visibility = Visibility.Visible;
            GridArchivi.Visibility = Visibility.Collapsed;
            Grid_DatiCad.Visibility = Visibility.Collapsed;
            ProgramStatus.SetVar("Pluggin", StBool.FALSE);
            ProgramStatus.SetVar("ModelloOk", "true");
            ProgramStatus.SetVar("Archivi", StBool.FALSE);
            ProgramStatus.SetVar("CAD", StBool.FALSE);

            WindowPositionManager.Applica(this, false); // carica posizione/dimensione

            /*
            // Ottieni l'area di lavoro disponibile (senza la taskbar)
            Rect workArea = SystemParameters.WorkArea;
            // Imposta la finestra alla dimensione massima possibile
            this.Left = workArea.Left;
            this.Top = workArea.Top;
            this.Width = workArea.Width;
            this.Height = workArea.Height;
            */
            this.WindowState = WindowState.Maximized;
            this.Topmost = false;
            
            Tutor.AggiornaTutor();
            SettutorPlugin(true);
            return;
            // Mostra il primo TabControl e nasconde il secondo
            AggiornaGrigliaTabControls(0, new GridLength(1, GridUnitType.Star)); // Prima riga: Espandibile
            AggiornaGrigliaTabControls(1, new GridLength(0));                   // Seconda riga: Collassata
        }
        //----------------  Fine Posizionamento e Plugin

        private void MenuArchivio(string archivio)
        {
            // Mostra il secondo TabControl e nasconde il primo
            GridArchivi.Visibility = Visibility.Visible;
            GridGenerale.Visibility = Visibility.Collapsed;
            Grid_DatiCad.Visibility = Visibility.Collapsed;
            ProgramStatus.SetVar("ModelloOk", "false");
            ProgramStatus.SetVar("Archivi", "true");
            ProgramStatus.SetVar("Pluggin", StBool.FALSE);

            SetArchivio(archivio);
            //Tutor.AggiornaTutor();
            return;
            AggiornaGrigliaTabControls(0, new GridLength(0));                   // Prima riga: Collassata
            AggiornaGrigliaTabControls(1, new GridLength(1, GridUnitType.Star)); // Seconda riga: Espandibile
        }
 

        /// <summary>
        /// Aggiorna le dimensioni della riga della griglia per mostrare o nascondere i TabControl.
        /// </summary>
        /// <param name="rowIndex">Indice della riga da aggiornare.</param>
        /// <param name="newHeight">Nuova altezza per la riga.</param>
        private void AggiornaGrigliaTabControls(int rowIndex, GridLength newHeight)
        {
            // Sostituisci con il nome effettivo della tua griglia
            var grid = (Grid)FindName("GridGenerale");
            if (grid != null && rowIndex < grid.RowDefinitions.Count)
            {
                grid.RowDefinitions[rowIndex].Height = newHeight;
            }
        }


  
        public DrawBim GetDrawBimControl()
        {
            return OpenGLView;
        }

        private void GeneraModelloAvvio_Click(object sender, RoutedEventArgs e)
        {
            if (AggiornaModelloAvvioMenu.IsChecked)
            {
                UserIni.Ini.SetVar("GeneraModelloAvvio", "true");
            }
            else
            {
                UserIni.Ini.SetVar("GeneraModelloAvvio", "false");
            }
        }
        
        private void DisattivaTutor_Click(object sender, RoutedEventArgs e)
        {
            Settutor(false);
            VisualizzaTutorMenu.IsChecked = false;
            UserIni.Ini.SetVar("Tutor","false");
        }
        
        private void SettutorPlugin(bool visibile)
        {
            if (visibile) visibile = UserIni.Ini.LoadVar("Tutor").ToLower() != "false";
            if (!visibile)
            {

                // Se il tutor è visibile, lo nascondiamo
                TutorBorder.Visibility = Visibility.Collapsed;
                VisualizzaTutorMenu.Header = "Mostra Tutor";
            }
            else
            {

                // Se il tutor è nascosto, lo mostriamo
                TutorBorder.Visibility = Visibility.Visible;
                VisualizzaTutorMenu.Header = "Nascondi Tutor";
            }
        }
        private void Settutor(bool visibile)
        {
            UserIni.Ini.SetVar("Tutor", visibile.ToString());
            if (!visibile)
            {
                // Se il tutor è visibile, lo nascondiamo
                TutorBorder.Visibility = Visibility.Collapsed;
                VisualizzaTutorMenu.Header = "Mostra Tutor";
            }
            else
            {
                // Se il tutor è nascosto, lo mostriamo
                TutorBorder.Visibility = Visibility.Visible;
                VisualizzaTutorMenu.Header = "Nascondi Tutor";
            }
        }
 
        private void VisualizzaTutorMenu_Click(object sender, RoutedEventArgs e)
        {
            Settutor(VisualizzaTutorMenu.IsChecked);
        }

        private void XML_Click(object sender, RoutedEventArgs e)
        {
            if (!Protezione.LicenzaValida())
            {
                new Protezione().MostraBloccoEsportazione();
                return;
            }

            string fileOrigine = GestProg.FileXMLOutPath;

            if (!File.Exists(fileOrigine))
            {
                MessageBox.Show("Il file XML non è stato ancora generato.", "Errore", MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            Microsoft.Win32.SaveFileDialog dlg = new Microsoft.Win32.SaveFileDialog
            {
                FileName = "output.xml",
                DefaultExt = ".xml",
                Filter = "File XML (*.xml)|*.xml",
                Title = "Salva una copia del file XML"
            };

            if (dlg.ShowDialog() == true)
            {
                try
                {
                    File.Copy(fileOrigine, dlg.FileName, overwrite: true);
                    MessageBox.Show($"✅ Il file XML è stato copiato con successo in:\n{dlg.FileName}", "Esportazione completata", MessageBoxButton.OK, MessageBoxImage.Information);
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Errore durante la copia del file:\n{ex.Message}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }


        private void BIM_Click(object sender, RoutedEventArgs e)
        {
            System.Windows.MessageBox.Show($"Il file BIM si trova in: \n{GestProg.fileMes(GestProg.FileBIMPath)}");
        }

        private void ToggleFiltriGrafici_Checked(object sender, RoutedEventArgs e)
        {
            // Mostra il contenitore dei filtri grafici
            FiltriGraficiPanel.Visibility = Visibility.Visible;

            // Modifica la larghezza della colonna per adattarsi al contenuto (Auto)
            FiltriColumn.Width = new GridLength(1, GridUnitType.Auto);
        }

        private void ToggleFiltriGrafici_Unchecked(object sender, RoutedEventArgs e)
        {
            // Nasconde il contenitore dei filtri grafici
            FiltriGraficiPanel.Visibility = Visibility.Collapsed;

            // Modifica la larghezza della colonna a zero
            FiltriColumn.Width = new GridLength(0);
        }
        // Gestore per l'evento FiltriChanged
        private void FiltriGraficiControl_FiltriChanged(object? sender, FiltriChangedEventArgs e)
        {
            Polig3D.GrafRedraw(false);
            // Logica per gestire il cambiamento dello stato di un filtro
            if (e.IsChecked)
            {
                Console.WriteLine($"Il filtro '{e.NomeFiltro}' è stato attivato.");
            }
            else
            {
                Console.WriteLine($"Il filtro '{e.NomeFiltro}' è stato disattivato.");
            }
        }

        private void Aggiungirigaprima_Click(object sender, RoutedEventArgs e)
        {

        }
        private void EditaNelCadPlugin_Click(object sender, RoutedEventArgs e)
        {
            EditaNelCadButtonFunz(true);
        }
        private void EditaNelCadButton_Click(object sender, RoutedEventArgs e)
        {
            EditaNelCadButtonFunz(false);
        }
        private void EditaNelCadButtonFunz(bool plugin)
        {
            string pathDxf = System.IO.Path.Combine(GestProg.PathProg, ComboBoxDisegno.Text + ".dxf");
            TermodelLog.InitializeLog();
            TermodelLog.WriteLog("------------------ EditaNelCadButton_Click -----------------");
            string cadPath = UserIni.Ini.LoadVar("CadPath");
            bool persInstallata = UserIni.Ini.LoadVar("PersInstallata") == "true";

            // Se il percorso non esiste o non è valido
            if (string.IsNullOrEmpty(cadPath) || !File.Exists(cadPath))
            {
                cadPath = ScriptCad.FindAutoCADExecutablePath(2020);
                if (cadPath == null)
                {
                    System.Windows.MessageBox.Show(
        "Non sono riuscito a trovare AutoCAD (qualsiasi versione) \n\n" +
        "oppure AutoCAD LT 2024 o successivi sul tuo computer.\n\n" +
        "Seleziona tu il percorso manualmente.",
        "⚠️ AutoCAD non trovato",
        MessageBoxButton.OK,
        MessageBoxImage.Warning
    );
                    // Apri un dialogo per selezionare l'eseguibile del CAD
                    OpenFileDialog openFileDialog = new OpenFileDialog
                    {
                        Title = "Seleziona il file eseguibile del CAD",
                        Filter = "Programmi (*.exe)|*.exe",
                        InitialDirectory = @"C:\Program Files\"
                    };

                    if (openFileDialog.ShowDialog() == true)
                    {
                        cadPath = openFileDialog.FileName;

                        // Verifica se il percorso selezionato è valido
                        if (File.Exists(cadPath))
                        {
                            // Salva il percorso nella configurazione
                            UserIni.Ini.SetVar("CadPath", cadPath);
                            System.Windows.MessageBox.Show("Percorso CAD salvato con successo!", "Configurazione aggiornata", MessageBoxButton.OK, MessageBoxImage.Information);
                            if (plugin)
                            {
                                if (!ScriptCad.ConfermaSettaggiAutocad()) return;
                                // ✅ Se ha accettato, aggiorna variabile
                                UserIni.Ini.SetVar("PersInstallata", "true");
                                TermodelLog.WriteLog("✔️ Utente ha accettato l'installazione delle personalizzazioni AutoCAD.");
                                ScriptCad.StartCad(cadPath, System.IO.Path.Combine(GestProg.PathProg, ComboBoxDisegno.Text + ".dxf"), true);
                            }
                            else ScriptCad.StartCad(cadPath, System.IO.Path.Combine(GestProg.PathProg, ComboBoxDisegno.Text + ".dxf"), false);
                        }
                        else
                        {
                            System.Windows.MessageBox.Show("Il file selezionato non è valido.", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                        }
                    }
                }
                else
                {
                    UserIni.Ini.SetVar("CadPath", cadPath);
                    if (!ScriptCad.ConfermaSettaggiAutocad()) return;
                    // Avvia il CAD
                    ScriptCad.StartCad(cadPath, pathDxf, true);
                }
            }
            else
            {
                if (plugin&& !persInstallata)
                {
                    if (!ScriptCad.ConfermaSettaggiAutocad()) return;
                    // ✅ Se ha accettato, aggiorna variabile
                    UserIni.Ini.SetVar("PersInstallata", "true");
                    TermodelLog.WriteLog("✔️ Utente ha accettato l'installazione delle personalizzazioni AutoCAD.");
                    ScriptCad.StartCad(cadPath, pathDxf, true);

                }
                else ScriptCad.StartCad(cadPath, pathDxf, false);
            }
        }
        // ------------   Stampa a video risultati di calcolo da cancellare spostato nella classe report termodel
        /*
        public System.Windows.Controls.RichTextBox Capitolo(int Numcap)
        {
            switch (Numcap)
            {
                case 1:
                    return richTextBoxDati1;
                    break;

                case 2:
                    return richTextBoxDati2;
                    break;
                case 3:
                    return richTextBoxDati3;
                    break;
                default:
                    return null;
                    break;
            }
        }
   
        public void AggiungiTesto(string testo, int Numcap=1)
        {
            if (Capitolo(Numcap).Document == null)
                Capitolo(Numcap).Document = new FlowDocument();

            Paragraph paragrafo = new Paragraph(new Run(testo));
            Capitolo(Numcap).Document.Blocks.Add(paragrafo);
        }

        public void AggiungiTestoFormattato(string testo, bool grassetto = false, bool corsivo = false, string colore = "Black", double dimensioneFont = 14, int Numcap=1)
        {
            if (Capitolo(Numcap).Document == null)
                Capitolo(Numcap).Document = new FlowDocument();

            Run run = new Run(testo)
            {
                Foreground = (Brush)new BrushConverter().ConvertFromString(colore),
                FontSize = dimensioneFont
            };

            // Imposta lo stile
            if (grassetto) run.FontWeight = FontWeights.Bold;
            if (corsivo) run.FontStyle = FontStyles.Italic;

            Paragraph paragrafo = new Paragraph(run);
            Capitolo(Numcap).Document.Blocks.Add(paragrafo);
        }
        public  Paragraph Paragrafo;

        public void StampaParagrafo(int Numcap = 1)
        {
            if (Capitolo(Numcap).Document == null)
                Capitolo(Numcap).Document = new FlowDocument();
            Capitolo(Numcap).Document.Blocks.Add(Paragrafo);
        }
        public void NuovoParagrafo()
        {
            Paragrafo = new Paragraph();
        }
        public void AggiungiTestoConValore(string descrizione, double valore, string unita, string coloreTesto = "Blue", string coloreValore = "Red", double dimensioneFont = 12, int Numcap = 1)
        {
         NuovoParagrafo();
         AggiungiTestoConValorePar(descrizione, valore, unita, coloreTesto , coloreValore, dimensioneFont);
         Capitolo(Numcap).Document.Blocks.Add(Paragrafo);
        }
        public void AggiungiTestoConValorePar(string descrizione, double valore, string unita, string coloreTesto = "Blue", string coloreValore = "Red", double dimensioneFont = 12)
        {
         

            // Creazione del paragrafo
            //Paragraph paragrafo = new Paragraph();

            // Testo descrittivo (blu)
            Run runDescrizione = new Run(descrizione + " ")
            {
                Foreground = (Brush)new BrushConverter().ConvertFromString(coloreTesto),
                FontSize = dimensioneFont
            };

            // Valore numerico (rosso)
            Run runValore = new Run($"{valore:F2} ")
            {
                Foreground = (Brush)new BrushConverter().ConvertFromString(coloreValore),
                FontSize = dimensioneFont,
                FontWeight = FontWeights.Bold // Grassetto per risalto
            };

            // Unità di misura (stesso colore del testo descrittivo)
            Run runUnita = new Run(unita)
            {
                Foreground = (Brush)new BrushConverter().ConvertFromString(coloreTesto),
                FontSize = dimensioneFont
            };

            // Aggiungiamo gli elementi al paragrafo
            Paragrafo.Inlines.Add(runDescrizione); // Testo descrittivo
            Paragrafo.Inlines.Add(runValore);      // Valore numerico
            Paragrafo.Inlines.Add(runUnita);       // Unità di misura

            // Aggiungiamo il paragrafo al RichTextBox
           // Capitolo(Numcap).Document.Blocks.Add(Paragrafo);
        }
        public void AggiungiTestoConValoreStringa(string descrizione, string valore, string coloreTesto = "Blue", string coloreValore = "Red", double dimensioneFont = 12, int Numcap = 1)
        {
            NuovoParagrafo();
            AggiungiTestoConValoreStringaPar(descrizione, valore, coloreTesto, coloreValore, dimensioneFont);
            Capitolo(Numcap).Document.Blocks.Add(Paragrafo);
        }
            public void AggiungiTestoConValoreStringaPar(string descrizione, string valore, string coloreTesto = "Blue", string coloreValore = "Red", double dimensioneFont = 12, int Numcap = 1)
        {
            if (Capitolo(Numcap).Document == null)
                Capitolo(Numcap).Document = new FlowDocument();

            // Creazione del paragrafo
            //Paragraph paragrafo = new Paragraph();

            // Testo descrittivo (blu)
            Run runDescrizione = new Run(descrizione + " ")
            {
                Foreground = (Brush)new BrushConverter().ConvertFromString(coloreTesto),
                FontSize = dimensioneFont
            };

            // Valore numerico (rosso)
            Run runValore = new Run($"{valore} ")
            {
                Foreground = (Brush)new BrushConverter().ConvertFromString(coloreValore),
                FontSize = dimensioneFont,
                FontWeight = FontWeights.Bold // Grassetto per risalto
            };

           

            // Aggiungiamo gli elementi al paragrafo
            Paragrafo.Inlines.Add(runDescrizione); // Testo descrittivo
            Paragrafo.Inlines.Add(runValore);      // Valore numerico
            

            // Aggiungiamo il paragrafo al RichTextBox
            Capitolo(Numcap).Document.Blocks.Add(Paragrafo);
        }
        
        public void CancellaTesto(int Numcap = 1)
        {
            Capitolo(Numcap).Document.Blocks.Clear();
        }
        */
        //-------------- Gestione archivi a griglia vecchia gestione
        private void ElencoPiani_Click(object sender, RoutedEventArgs e)
        {
            SetArchivio("Piani");
            //GestArchivio("Piani", "Archivio");
        }

        private void Pareti_Click(object sender, RoutedEventArgs e)
        {
            //GestArchivio("Pareti", "Archivio");
            SetArchivio("Pareti");
        }
        private void ConfiniiButton_Click(object sender, RoutedEventArgs e)
        {
            //GestArchivio("Confini", "Archivio");
            SetArchivio("Confini");
        }
        private void NonClimaButton_Click(object sender, RoutedEventArgs e)
        {
            // ricordarsi di aggiungere . . .AddDataCollection("Zone", "Zone");
            
            SetArchivio("NonClimatizzati");
        }
        private void FinestreButton_Click(object sender, RoutedEventArgs e)
        {
            //GestArchivio("Finestre", "Archivio");
            SetArchivio("Finestre");
        }
        private void ZoneButton_Click(object sender, RoutedEventArgs e)
        {
            // ricordarsi di aggiungere . . .AddDataCollection("Zone", "Zone");
            //GestArchivio("Zone", "Archivio");
            SetArchivio("Zone");
        }
        private void PontiButton_Click(object sender, RoutedEventArgs e)
        {
            // ricordarsi di aggiungere . . .AddDataCollection("Zone", "Zone");
            //GestArchivio("Ponti", "Archivio");
            SetArchivio("Ponti");
        }
 
        private void ApriArchivioPareti(object sender, RoutedEventArgs e)
        {
            MenuArchivio("Pareti");// gestione brutale
            
        }
        private void Archivi_Click(object sender, RoutedEventArgs e)
        {
            MenuArchivio("Piani");
        }
        // ------------------------------ Archivi nuova gestione
        // Pulsante modello
        private void ApriArchivioPiani(object sender, RoutedEventArgs e)
        {
            //MenuArchivio("Piani");// gestione brutale
            GestArchivio("Piani","Archivio");
        }
        private void MenuPareti_Click(object sender, RoutedEventArgs e)
        {
            GestArchivio("Pareti", "Archivio");
            //MenuArchivio("Pareti");
        }
        private void MenuFinestre_Click(object sender, RoutedEventArgs e)
        {
            GestArchivio("Finestre", "Archivio"); 
            //MenuArchivio("Finestre");
        }
        private void MenuPonti_Click(object sender, RoutedEventArgs e)
        {
            GestArchivio("Ponti", "Archivio");
           // MenuArchivio("Ponti");
        }
        private void MenuConfini_Click(object sender, RoutedEventArgs e)
        {
            GestArchivio("Confini", "Archivio");
            //MenuArchivio("Confini");
        }
        private void MenuZone_Click(object sender, RoutedEventArgs e)
        {
            GestArchivio("Zone", "Archivio");
            //MenuArchivio("Zone");
        }
        private void MenuPontiAutomatici_Click(object sender, RoutedEventArgs e)
        {
            GestArchivio("PontiAutomatici", "Archivio");
            //MenuArchivio("PontiAutomatici");
        }
        private void MenuPontiAutomaticiFinestre_Click(object sender, RoutedEventArgs e)
        {
            GestArchivio("PontiAutomaticiFinestre", "Archivio");
            //MenuArchivio("PontiAutomatici");
        }
        // ------------------------    Fine menu
        private void GestArchivio(string nomearchivio, string tipoform)
        {
            var form = new FormArchivio(nomearchivio, tipoform)
            {
                Owner = this // ✅ Collega la finestra all'owner (MainWindow)
            };

            bool? result = form.ShowDialog();
            if (result == true)
            {
                AggiornaDaticad();
            }

            // AggiungiRigaArchivio("Piani"); // ← lascia pure commentato se non usi ancora
        }

        private void AggiungiRigaArchivio(string archivio)
        {
          // 🔐 Salva lo stato attuale dell'archivio prima di modificare
            Database.DB.SaveData(archivio);

            // ➕ Aggiunge una nuova riga vuota
            var collezione = Database.DB.GetCollection(archivio);
 
            Database.DB.AddEmptyRowToCollection(archivio);

            // 🔢 Ottiene l’indice dell’ultima riga (appena aggiunta)
            int nuovoIndice = collezione.Count - 1;

            // 🔍 Apre la form per modificare la nuova riga
            AutoForm.DettaglioArchivio(archivio, nuovoIndice);

            // 💡 (opzionale) Ricarica o aggiorna combo se serve
        }
       
        private void ChiedaGPT_Click(object sender, RoutedEventArgs e)
        {
            // Esempio: contesto = 1, info testuale fittizia
            int contesto = 1;
            string info = "Descrizione del problema o stato attuale dell'oggetto selezionato.";

            // Richiama la form GPT in modalità modale
            FormGPTSupport.chiediagpt(contesto, info);
        }
        private void GeneraconIA_click(object sender, RoutedEventArgs e)
        {
            // Modificato da Codex per realizzare: sostituzione del progetto descritto a parole con il flusso raster-to-Termodel.
            var finestra = new CreaPianoDaRaster();

            finestra.Owner = this;
            bool? risultato = finestra.ShowDialog(); // 👈 apertura MODALE
            if (risultato == true && finestra.PianoImportato)
            {
                Genera_modello();
            }
        }
        
    }
}
