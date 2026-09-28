using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Xml.Linq;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Facciata diagnostica per eseguire Vittorio_revisionato, derivazione pulita
/// del sorgente Vittorio usata per prove di equivalenza e astrazione controllata.
/// </summary>
public static class StrategiaVittorioRevisionatoBenchmark
{
    private static readonly object EngineGate = new();

    // Funzione realizzata da Codex in autonomia
    public static StrategiaVittorioRevisionatoBenchmarkSample Run(string localeXml)
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
                    SpiralHeatingVittorioRevisionato.Program.AggiornaSpirali();
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

            return new StrategiaVittorioRevisionatoBenchmarkSample(
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
}

public sealed record StrategiaVittorioRevisionatoBenchmarkSample(
    string Svg,
    string ResultLocaleXml,
    double StepMeters,
    int LocaleCount,
    int SpiralPointCount,
    long ElapsedMilliseconds,
    long MemoryDeltaBytes,
    IReadOnlyList<string> Diagnostics);
