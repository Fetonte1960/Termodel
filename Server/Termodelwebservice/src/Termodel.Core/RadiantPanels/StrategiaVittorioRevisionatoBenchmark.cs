using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Xml.Linq;
using Termodel.utilities;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Facciata diagnostica per eseguire Vittorio_revisionato, derivazione pulita
/// del sorgente Vittorio usata per prove di equivalenza e astrazione controllata.
/// </summary>
public static class StrategiaVittorioRevisionatoBenchmark
{
    private static readonly object EngineGate = new();

    // Funzione realizzata da Codex in autonomia
    public static StrategiaVittorioBenchmarkSample Run(
        string localeXml,
        bool publicPath = false,
        TermodelLog.LogConfiguration? logConfiguration = null)
    {
        if (string.IsNullOrWhiteSpace(localeXml))
            throw new ArgumentException("Fixture Vittorio vuota.", nameof(localeXml));

        XDocument.Parse(localeXml, LoadOptions.PreserveWhitespace);

        string tempRoot = Path.Combine(
            Path.GetTempPath(),
            "TermodelVittorioRevisionatoBenchmark",
            Guid.NewGuid().ToString("N"));
        Directory.CreateDirectory(tempRoot);

        string inputPath = Path.Combine(tempRoot, "locale.xml");
        string svgPath = Path.Combine(tempRoot, "locale.svg");
        File.WriteAllText(inputPath, localeXml, new UTF8Encoding(false));

        long memoryBefore = GC.GetTotalMemory(forceFullCollection: true);
        var stopwatch = Stopwatch.StartNew();
        var diagnostics = new List<string>();
        TermodelLog.InitializeLog(logConfiguration);

        try
        {
            lock (EngineGate)
            {
                string previousDirectory = Environment.CurrentDirectory;
                TextWriter previousOut = Console.Out;
                using var capturedOut = new StringWriter(CultureInfo.InvariantCulture);
                try
                {
                    Directory.SetCurrentDirectory(tempRoot);
                    Console.SetOut(capturedOut);
                    if (publicPath)
                        SpiralHeatingVittorioRevisionato.Program.AggiornaSpirali();
                    else
                        SpiralHeatingVittorioRevisionato.Program.AggiornaSpirali(soloMandataPerEsameVisivo: false);
                }
                finally
                {
                    Console.SetOut(previousOut);
                    Directory.SetCurrentDirectory(previousDirectory);
                }

                diagnostics.AddRange(
                    capturedOut.ToString()
                        .Split(
                            new[] { "\r\n", "\n" },
                            StringSplitOptions.RemoveEmptyEntries));

                diagnostics.AddRange(TermodelLog.Messages);
            }

            stopwatch.Stop();
            if (!File.Exists(svgPath))
            {
                throw new InvalidDataException(
                    "StrategiaVittorioRevisionato non ha prodotto locale.svg.");
            }

            string resultXml = File.ReadAllText(inputPath, Encoding.UTF8);
            XDocument resultDocument = XDocument.Parse(
                resultXml,
                LoadOptions.PreserveWhitespace);
            int localeCount = resultDocument.Descendants("Locale").Count();
            int spiralPointCount = resultDocument
                .Descendants("Spirale")
                .Elements("Punto")
                .Count();

            return new StrategiaVittorioBenchmarkSample(
                File.ReadAllText(svgPath, Encoding.UTF8),
                resultXml,
                SpiralHeatingVittorioRevisionato.Program.PassoTubi,
                localeCount,
                spiralPointCount,
                stopwatch.ElapsedMilliseconds,
                GC.GetTotalMemory(forceFullCollection: false) - memoryBefore,
                diagnostics);
        }
        finally
        {
            try
            {
                if (Directory.Exists(tempRoot))
                    Directory.Delete(tempRoot, recursive: true);
            }
            catch
            {
                // La pulizia del workspace temporaneo non cambia il risultato.
            }
        }
    }

    public static StrategiaVittorioRevisionatoAbstractionCheck CheckAbstraction()
    {
        const double tolerance = 1e-12;
        if (Math.Abs(SpiralHeatingVittorioRevisionato.Program.P - 0.30) > tolerance ||
            Math.Abs(SpiralHeatingVittorioRevisionato.Program.DistanzaPareti - 0.15) > tolerance ||
            Math.Abs(SpiralHeatingVittorioRevisionato.Program.DistanzaMandataMandata - 0.60) > tolerance ||
            Math.Abs(SpiralHeatingVittorioRevisionato.Program.DistanzaRitorno - 0.30) > tolerance)
        {
            throw new InvalidDataException(
                "Vittorio_revisionato: contratto P incoerente; attesi " +
                "P=0,30, parete=0,15, Mandata-Mandata=0,60, Return=0,30.");
        }

        var perimeter = new List<SpiralHeatingVittorioRevisionato.Punto>
        {
            new(0.0, 0.0),
            new(4.0, 0.0),
            new(4.0, 4.0),
            new(0.0, 4.0)
        };
        var supplyStart =
            new SpiralHeatingVittorioRevisionato.Punto(0.0, 2.0);
        const double step = 0.30;

        var historical =
            SpiralHeatingVittorioRevisionato.SpiralGenerator.Generate(
                new List<SpiralHeatingVittorioRevisionato.Punto>(perimeter),
                supplyStart,
                step,
                true);

        var neutralInput = new SpiralHeatingVittorioRevisionato.SpiralGenerationInput
        {
            Perimetro =
                new List<SpiralHeatingVittorioRevisionato.Punto>(perimeter),
            StartPoint =
                new SpiralHeatingVittorioRevisionato.Punto(
                    supplyStart.X,
                    supplyStart.Y),
            Distanza = step,
            DrawSpiral = true
        };
        var neutral =
            SpiralHeatingVittorioRevisionato.SpiralGenerator.Generate(
                neutralInput);

        bool neutralEquivalent =
            SamePoints(historical.spiral, neutral.spiral);
        if (!neutralEquivalent)
        {
            throw new InvalidDataException(
                "Astrazione Vittorio_revisionato: il percorso neutro diverge dal Generate storico.");
        }

        var revisionato =
            SpiralHeatingVittorioRevisionato.SpiralGenerator.GenerateRevisionato(
                new SpiralHeatingVittorioRevisionato.SpiralGenerationInput
                {
                    Perimetro =
                        new List<SpiralHeatingVittorioRevisionato.Punto>(perimeter),
                    StartPoint =
                        new SpiralHeatingVittorioRevisionato.Punto(
                            supplyStart.X,
                            supplyStart.Y),
                    Distanza = step,
                    DistanzaParete =
                        SpiralHeatingVittorioRevisionato.Program.DistanzaPareti,
                    DistanzaMandataMandata =
                        SpiralHeatingVittorioRevisionato.Program.DistanzaMandataMandata,
                    DistanzaFinalizzazione =
                        SpiralHeatingVittorioRevisionato.Program.P,
                    DrawSpiral = true
                });

        if (revisionato.offsets.Count < 3)
        {
            throw new InvalidDataException(
                "Generate revisionato: servono almeno due offset utili sul quadrato 4x4.");
        }

        double wallDistance =
            revisionato.offsets[1].Min(p => p.X) - perimeter.Min(p => p.X);
        double supplySpacing =
            revisionato.offsets[2].Min(p => p.X) -
            revisionato.offsets[1].Min(p => p.X);

        if (Math.Abs(wallDistance - 0.15) > 0.000001 ||
            Math.Abs(supplySpacing - 0.60) > 0.000001)
        {
            throw new InvalidDataException(
                $"Generate revisionato: distanze inattese; " +
                $"parete={wallDistance:R}, Mandata-Mandata={supplySpacing:R}.");
        }

        var returnStart =
            new SpiralHeatingVittorioRevisionato.Punto(4.0, 2.0);
        var unconditionedReturn =
            SpiralHeatingVittorioRevisionato.SpiralGenerator.Generate(
                new SpiralHeatingVittorioRevisionato.SpiralGenerationInput
                {
                    Perimetro =
                        new List<SpiralHeatingVittorioRevisionato.Punto>(perimeter),
                    StartPoint = returnStart,
                    Distanza = step,
                    DrawSpiral = true
                });

        var conditionedReturn =
            SpiralHeatingVittorioRevisionato.SpiralGenerator.Generate(
                new SpiralHeatingVittorioRevisionato.SpiralGenerationInput
                {
                    Perimetro =
                        new List<SpiralHeatingVittorioRevisionato.Punto>(perimeter),
                    StartPoint =
                        new SpiralHeatingVittorioRevisionato.Punto(
                            returnStart.X,
                            returnStart.Y),
                    Distanza = step,
                    DrawSpiral = true,
                    LineeCondizionamento =
                        historical.spiral
                            .Select(p =>
                                new SpiralHeatingVittorioRevisionato.Punto(
                                    p.X,
                                    p.Y))
                            .ToList(),
                    DistanzaCondizionamento = step / 2.0
                });

        bool conditioningActive =
            conditionedReturn.spiral.Count <
            unconditionedReturn.spiral.Count;
        if (!conditioningActive)
        {
            throw new InvalidDataException(
                "Astrazione Vittorio_revisionato: la Supply non condiziona il percorso Return di prova.");
        }

        return new StrategiaVittorioRevisionatoAbstractionCheck(
            neutralEquivalent,
            historical.spiral.Count,
            unconditionedReturn.spiral.Count,
            conditionedReturn.spiral.Count,
            step / 2.0,
            SpiralHeatingVittorioRevisionato.Program.P,
            SpiralHeatingVittorioRevisionato.Program.DistanzaPareti,
            SpiralHeatingVittorioRevisionato.Program.DistanzaMandataMandata,
            SpiralHeatingVittorioRevisionato.Program.DistanzaRitorno,
            wallDistance,
            supplySpacing);
    }

    private static bool SamePoints(
        IReadOnlyList<SpiralHeatingVittorioRevisionato.Punto> a,
        IReadOnlyList<SpiralHeatingVittorioRevisionato.Punto> b)
    {
        if (a.Count != b.Count)
            return false;

        const double tolerance = 1e-12;
        for (int index = 0; index < a.Count; index++)
        {
            if (Math.Abs(a[index].X - b[index].X) > tolerance ||
                Math.Abs(a[index].Y - b[index].Y) > tolerance)
            {
                return false;
            }
        }
        return true;
    }
}

public sealed record StrategiaVittorioRevisionatoAbstractionCheck(
    bool NeutralEquivalent,
    int SupplyPoints,
    int UnconditionedReturnPoints,
    int ConditionedReturnPoints,
    double ConditioningDistanceMeters,
    double PMeters,
    double WallDistanceMeters,
    double SupplyToSupplyMeters,
    double ReturnDistanceMeters,
    double MeasuredWallDistanceMeters,
    double MeasuredSupplySpacingMeters);
