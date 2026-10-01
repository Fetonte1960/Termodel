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

    public static StrategiaVittorioRevisionatoPureGeneratorCheck CheckPureGenerator()
    {
        const double step = 0.30;
        var starts = new[]
        {
            (X: 0.0, Y: 2.0),
            (X: 4.0, Y: 2.0)
        };

        int lastPointCount = 0;
        foreach (var start in starts)
        {
            var revisionatoPerimeter =
                new List<SpiralHeatingVittorioRevisionato.Punto>
                {
                    new(0.0, 0.0),
                    new(4.0, 0.0),
                    new(4.0, 4.0),
                    new(0.0, 4.0)
                };
            var vittorioPerimeter =
                new List<SpiralHeating.Punto>
                {
                    new(0.0, 0.0),
                    new(4.0, 0.0),
                    new(4.0, 4.0),
                    new(0.0, 4.0)
                };

            var revisionato =
                SpiralHeatingVittorioRevisionato.SpiralGenerator.Generate(
                    revisionatoPerimeter,
                    new SpiralHeatingVittorioRevisionato.Punto(start.X, start.Y),
                    step,
                    true);
            var vittorio =
                SpiralHeating.SpiralGenerator.Generate(
                    vittorioPerimeter,
                    new SpiralHeating.Punto(start.X, start.Y),
                    step,
                    true);

            if (!SamePoints(revisionato.spiral, vittorio.spiral))
            {
                throw new InvalidDataException(
                    $"Generate Vittorio puro: divergenza sullo start ({start.X:R},{start.Y:R}).");
            }

            lastPointCount = revisionato.spiral.Count;
        }

        return new StrategiaVittorioRevisionatoPureGeneratorCheck(
            EquivalentToVittorio: true,
            Cases: starts.Length,
            SupplyPoints: lastPointCount);
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

public sealed record StrategiaVittorioRevisionatoPureGeneratorCheck(
    bool EquivalentToVittorio,
    int Cases,
    int SupplyPoints);
