using Microsoft.Win32;
using System.Globalization;
using System.IO;
using System.Text;
using System.Windows;
using System.Windows.Media.Imaging;
using System.Xml.Linq;
using Termodel.Leggidxf;
using Termodel.Pareti.Editor.Services;
using Termodel.utilities;

namespace Termodel.AI;

public partial class CreaPianoDaRaster : Window
{
    private const string NomeFileIstruzioni = "CreaPianoTermodelDaRaster.md";
    private string? percorsoRaster;
    private string? rispostaAiCompleta;
    private string? contestoAiCopiato;

    public bool PianoImportato { get; private set; }

    // Funzione realizzata da Codex in autonomia
    public CreaPianoDaRaster()
    {
        InitializeComponent();
    }

    // Funzione realizzata da Codex in autonomia
    private void SelezionaRaster_Click(object sender, RoutedEventArgs e)
    {
        var dialogo = new OpenFileDialog
        {
            Title = "Seleziona la pianta raster",
            Filter = "Immagini raster|*.png;*.jpg;*.jpeg;*.bmp;*.tif;*.tiff|Tutti i file|*.*"
        };

        if (dialogo.ShowDialog(this) != true)
        {
            return;
        }

        percorsoRaster = dialogo.FileName;
        PercorsoRasterTextBox.Text = percorsoRaster;
        CaricaAnteprimaRaster(percorsoRaster);
        StatoTextBlock.Text = "Raster caricato. Ora copia le istruzioni e allega questa immagine alla chat AI.";
    }

    // Funzione realizzata da Codex in autonomia
    private void CaricaAnteprimaRaster(string percorso)
    {
        using var stream = File.OpenRead(percorso);
        var bitmap = new BitmapImage();
        bitmap.BeginInit();
        bitmap.CacheOption = BitmapCacheOption.OnLoad;
        bitmap.StreamSource = stream;
        bitmap.EndInit();
        bitmap.Freeze();

        AnteprimaRaster.Source = bitmap;
        NessunaAnteprimaTextBlock.Visibility = Visibility.Collapsed;
        AnteprimeTabControl.SelectedIndex = 0;
    }

    // Funzione realizzata da Codex in autonomia
    private void CopiaIstruzioni_Click(object sender, RoutedEventArgs e)
    {
        try
        {
            string percorsoIstruzioni = TrovaFileIstruzioni();
            string istruzioni = File.ReadAllText(percorsoIstruzioni);
            string archiviProgetto = CreaAppendiceArchiviProgetto();
            string catalogoMateriali = PromptStratigrafiaAiService.CreaCatalogoCompatto(CatalogoMaterialiDemo.Crea());
            string nomeRaster = string.IsNullOrWhiteSpace(percorsoRaster)
                ? "non ancora selezionata"
                : Path.GetFileName(percorsoRaster);

            contestoAiCopiato =
                istruzioni +
                Environment.NewLine + Environment.NewLine +
                archiviProgetto +
                Environment.NewLine + Environment.NewLine +
                catalogoMateriali +
                Environment.NewLine + Environment.NewLine +
                "---" + Environment.NewLine +
                $"IMMAGINE DI QUESTA SESSIONE: {nomeRaster}" + Environment.NewLine +
                "L'utente allegherà alla chat il file raster; non tentare di aprire il percorso locale di Termodel.";
            Clipboard.SetText(contestoAiCopiato);

            StatoTextBlock.Text = "Istruzioni, archivi e catalogo materiali copiati. Incollali nella chat AI e allega la pianta raster.";
            MessageBox.Show(
                "Istruzioni unificate, archivi del progetto e catalogo materiali copiati negli appunti.\n\nIncollali nella chat AI e allega la pianta raster selezionata.",
                "Crea piano da raster",
                MessageBoxButton.OK,
                MessageBoxImage.Information);
        }
        catch (Exception ex)
        {
            MessageBox.Show(ex.Message, "Istruzioni AI non disponibili", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }

    // Funzione realizzata da Codex in autonomia
    private static string CreaAppendiceArchiviProgetto()
    {
        var testo = new StringBuilder();
        testo.AppendLine("ARCHIVI ATTUALI DEL PROGETTO TERMODEL");
        testo.AppendLine("Quando scegli un tipo esistente, ricopia esattamente la descrizione indicata.");
        testo.AppendLine();
        testo.AppendLine("TIPI FINESTRA DISPONIBILI (TIPO del blocco FIN):");
        foreach (string descrizione in LeggiValoriArchivio("Finestre", "DescBreve"))
        {
            testo.AppendLine("- " + descrizione);
        }

        testo.AppendLine();
        testo.AppendLine("TIPI PARETE GIÀ DISPONIBILI:");
        foreach (string descrizione in LeggiValoriArchivio("Pareti", "DescBreve"))
        {
            testo.AppendLine("- " + descrizione);
        }

        return testo.ToString();
    }

    // Funzione realizzata da Codex in autonomia
    private static IReadOnlyList<string> LeggiValoriArchivio(string nomeArchivio, string nomeCampo)
    {
        var valori = Database.DB.GetCollection(nomeArchivio)
            .Where(riga => riga.ContainsKey(nomeCampo))
            .Select(riga => riga[nomeCampo]?.ToString()?.Trim())
            .Where(valore => !string.IsNullOrWhiteSpace(valore))
            .Select(valore => valore!)
            .Distinct(StringComparer.CurrentCultureIgnoreCase)
            .OrderBy(valore => valore, StringComparer.CurrentCultureIgnoreCase)
            .ToList();

        return valori.Count > 0 ? valori : ["(nessuna voce disponibile)"];
    }

    // Funzione realizzata da Codex in autonomia
    private static string TrovaFileIstruzioni()
    {
        string percorsoDistribuito = Path.Combine(AppContext.BaseDirectory, "IstruzioniAI", NomeFileIstruzioni);
        if (File.Exists(percorsoDistribuito))
        {
            return percorsoDistribuito;
        }

        string percorsoSorgente = Path.Combine(Directory.GetCurrentDirectory(), "IstruzioniAI", NomeFileIstruzioni);
        if (File.Exists(percorsoSorgente))
        {
            return percorsoSorgente;
        }

        throw new FileNotFoundException(
            "Il file di istruzioni AI non è stato trovato. Reinstalla o aggiorna Termodel.",
            percorsoDistribuito);
    }

    // Funzione realizzata da Codex in autonomia
    private void SelezionaSvg_Click(object sender, RoutedEventArgs e)
    {
        var dialogo = new OpenFileDialog
        {
            Title = "Seleziona DisegnoInput.svg prodotto dall'AI",
            Filter = "Disegno SVG|*.svg|File di testo|*.txt|Tutti i file|*.*"
        };

        if (dialogo.ShowDialog(this) != true)
        {
            return;
        }

        rispostaAiCompleta = File.ReadAllText(dialogo.FileName);
        SvgTextBox.Text = EstraiSvg(rispostaAiCompleta);
        AnteprimeTabControl.SelectedIndex = 1;
        StatoTextBlock.Text = "SVG caricato. Premi «Controlla e crea il piano Termodel».";
    }

    // Funzione realizzata da Codex in autonomia
    private void IncollaSvg_Click(object sender, RoutedEventArgs e)
    {
        try
        {
            rispostaAiCompleta = Clipboard.GetText(System.Windows.TextDataFormat.UnicodeText);
            SvgTextBox.Text = EstraiSvg(rispostaAiCompleta);
            AnteprimeTabControl.SelectedIndex = 1;
            StatoTextBlock.Text = "SVG incollato. Premi «Controlla e crea il piano Termodel».";
        }
        catch (Exception ex)
        {
            MessageBox.Show(ex.Message, "SVG non riconosciuto", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }

    // Funzione realizzata da Codex in autonomia
    private void Importa_Click(object sender, RoutedEventArgs e)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(percorsoRaster) || !File.Exists(percorsoRaster))
            {
                throw new InvalidOperationException("Seleziona prima la pianta raster originale: deve restare associata al progetto.");
            }

            string svg = EstraiSvg(SvgTextBox.Text);
            ValidaSvgTermodel(svg);

            if (string.IsNullOrWhiteSpace(GestProg.PathProg) || !Directory.Exists(GestProg.PathProg))
            {
                throw new DirectoryNotFoundException("Prima crea o apri un progetto Termodel valido.");
            }

            string percorsoSvgProgetto = Path.Combine(GestProg.PathProg, "DisegnoInput.svg");
            File.WriteAllText(percorsoSvgProgetto, svg);
            ConservaContestoNelProgetto(
                percorsoRaster,
                rispostaAiCompleta ?? svg,
                contestoAiCopiato ?? File.ReadAllText(TrovaFileIstruzioni()));

            var importatore = new CadGPT { ShowInTaskbar = false };
            try
            {
                importatore.ImportaSvgDaFile(percorsoSvgProgetto);
            }
            finally
            {
                importatore.Close();
            }

            PianoImportato = true;
            StatoTextBlock.Text = "Piano importato. Chiudi questa finestra per generare e controllare il modello.";
            MessageBox.Show(
                "Piano creato nel progetto.\n\nSono stati conservati il raster originale, lo SVG definitivo e le istruzioni AI usate.",
                "Crea piano da raster",
                MessageBoxButton.OK,
                MessageBoxImage.Information);
            DialogResult = true;
        }
        catch (Exception ex)
        {
            PianoImportato = false;
            StatoTextBlock.Text = "Importazione non eseguita: " + ex.Message;
            MessageBox.Show(ex.Message, "Impossibile creare il piano", MessageBoxButton.OK, MessageBoxImage.Error);
        }
    }

    // Funzione realizzata da Codex in autonomia
    private static string EstraiSvg(string testo)
    {
        if (string.IsNullOrWhiteSpace(testo))
        {
            throw new InvalidDataException("Non è presente alcun testo SVG.");
        }

        int inizio = testo.IndexOf("<svg", StringComparison.OrdinalIgnoreCase);
        int fineTag = testo.LastIndexOf("</svg>", StringComparison.OrdinalIgnoreCase);
        if (inizio < 0 || fineTag < inizio)
        {
            throw new InvalidDataException("Blocco <svg>...</svg> non trovato. Copia il codice SVG completo prodotto dall'AI.");
        }

        return testo.Substring(inizio, fineTag + "</svg>".Length - inizio).Trim();
    }

    // Funzione realizzata da Codex in autonomia
    private static void ValidaSvgTermodel(string svg)
    {
        XDocument documento;
        try
        {
            documento = XDocument.Parse(svg, LoadOptions.SetLineInfo);
        }
        catch (Exception ex)
        {
            throw new InvalidDataException("Lo SVG non è XML valido: " + ex.Message, ex);
        }

        XElement radice = documento.Root
            ?? throw new InvalidDataException("Lo SVG non contiene un elemento radice.");
        if (!radice.Name.LocalName.Equals("svg", StringComparison.OrdinalIgnoreCase))
        {
            throw new InvalidDataException("L'elemento radice deve essere <svg>.");
        }

        XElement? calpestabile = radice.Elements().FirstOrDefault(elemento =>
            elemento.Name.LocalName == "g" && (string?)elemento.Attribute("id") == "calpestabile");
        XElement? copertura = radice.Elements().FirstOrDefault(elemento =>
            elemento.Name.LocalName == "g" && (string?)elemento.Attribute("id") == "copertura");

        if (calpestabile is null || copertura is null)
        {
            throw new InvalidDataException("Servono i due gruppi diretti <g id=\"calpestabile\"> e <g id=\"copertura\">.");
        }

        XElement? figlioNonAmmesso = calpestabile.Elements().FirstOrDefault(elemento =>
            elemento.Name.LocalName is not ("line" or "text"));
        if (figlioNonAmmesso is not null)
        {
            throw new InvalidDataException($"Elemento <{figlioNonAmmesso.Name.LocalName}> non ammesso in calpestabile: usa solo line e text diretti.");
        }

        var linee = calpestabile.Elements()
            .Where(elemento => elemento.Name.LocalName == "line")
            .Select(LeggiLinea)
            .ToList();
        if (linee.Count == 0)
        {
            throw new InvalidDataException("Il gruppo calpestabile non contiene pareti <line>.");
        }

        bool contieneLocale = calpestabile.Elements()
            .Where(elemento => elemento.Name.LocalName == "text")
            .Select(elemento => string.Join("\n", elemento.DescendantNodes().OfType<XText>().Select(testo => testo.Value)))
            .Any(testo => testo.Contains("BLOCCO,LOC", StringComparison.OrdinalIgnoreCase));
        if (!contieneLocale)
        {
            throw new InvalidDataException("Manca almeno un blocco testuale BLOCCO,LOC.");
        }

        const double tolleranza = 0.5;
        for (int indice = 0; indice < linee.Count; indice++)
        {
            VerificaEstremitaCollegata(linee, indice, linee[indice].X1, linee[indice].Y1, tolleranza);
            VerificaEstremitaCollegata(linee, indice, linee[indice].X2, linee[indice].Y2, tolleranza);
        }
    }

    // Funzione realizzata da Codex in autonomia
    private static (double X1, double Y1, double X2, double Y2) LeggiLinea(XElement linea)
    {
        return (
            LeggiCoordinata(linea, "x1"),
            LeggiCoordinata(linea, "y1"),
            LeggiCoordinata(linea, "x2"),
            LeggiCoordinata(linea, "y2"));
    }

    // Funzione realizzata da Codex in autonomia
    private static double LeggiCoordinata(XElement linea, string nome)
    {
        string valore = (string?)linea.Attribute(nome)
            ?? throw new InvalidDataException($"Una linea non contiene l'attributo {nome}.");
        if (!double.TryParse(valore, NumberStyles.Float, CultureInfo.InvariantCulture, out double coordinata))
        {
            throw new InvalidDataException($"Coordinata {nome}=\"{valore}\" non valida: usa il punto come separatore decimale.");
        }

        return coordinata;
    }

    // Funzione realizzata da Codex in autonomia
    private static void VerificaEstremitaCollegata(
        IReadOnlyList<(double X1, double Y1, double X2, double Y2)> linee,
        int indiceLinea,
        double x,
        double y,
        double tolleranza)
    {
        for (int altroIndice = 0; altroIndice < linee.Count; altroIndice++)
        {
            if (altroIndice == indiceLinea)
            {
                continue;
            }

            var altra = linee[altroIndice];
            if (DistanzaPuntoSegmento(x, y, altra.X1, altra.Y1, altra.X2, altra.Y2) <= tolleranza)
            {
                return;
            }
        }

        throw new InvalidDataException(
            $"Estremità non collegata alle coordinate ({x.ToString("0.###", CultureInfo.InvariantCulture)}, " +
            $"{y.ToString("0.###", CultureInfo.InvariantCulture)}). Correggi la pianta nella chat AI prima di importarla.");
    }

    // Funzione realizzata da Codex in autonomia
    private static double DistanzaPuntoSegmento(
        double px,
        double py,
        double x1,
        double y1,
        double x2,
        double y2)
    {
        double dx = x2 - x1;
        double dy = y2 - y1;
        double quadratoLunghezza = (dx * dx) + (dy * dy);
        if (quadratoLunghezza <= double.Epsilon)
        {
            return Math.Sqrt(Math.Pow(px - x1, 2) + Math.Pow(py - y1, 2));
        }

        double t = (((px - x1) * dx) + ((py - y1) * dy)) / quadratoLunghezza;
        t = Math.Max(0, Math.Min(1, t));
        double proiezioneX = x1 + (t * dx);
        double proiezioneY = y1 + (t * dy);
        return Math.Sqrt(Math.Pow(px - proiezioneX, 2) + Math.Pow(py - proiezioneY, 2));
    }

    // Funzione realizzata da Codex in autonomia
    private static void ConservaContestoNelProgetto(string rasterOriginale, string rispostaAi, string istruzioniAiComplete)
    {
        string estensioneRaster = Path.GetExtension(rasterOriginale).ToLowerInvariant();
        string destinazioneRaster = Path.Combine(GestProg.PathProg, "PiantaRasterOriginale" + estensioneRaster);
        if (!Path.GetFullPath(rasterOriginale).Equals(Path.GetFullPath(destinazioneRaster), StringComparison.OrdinalIgnoreCase))
        {
            File.Copy(rasterOriginale, destinazioneRaster, overwrite: true);
        }

        File.WriteAllText(
            Path.Combine(GestProg.PathProg, "IstruzioniAI-CreaPianoDaRaster.md"),
            istruzioniAiComplete);

        File.WriteAllText(
            Path.Combine(GestProg.PathProg, "RispostaAI-CreaPiano.txt"),
            rispostaAi);
    }

    // Funzione realizzata da Codex in autonomia
    private void Chiudi_Click(object sender, RoutedEventArgs e)
    {
        DialogResult = PianoImportato;
    }
}
