using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Xml.Linq;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Facciata diagnostica per eseguire nel banco prova il sorgente Vittorio
/// copiato in Termodel.Core, senza modificarne l'algoritmo geometrico.
/// </summary>
public static class StrategiaVittorioBenchmark
{
    private static readonly object EngineGate = new();

    // Funzione realizzata da Codex in autonomia
    public static StrategiaVittorioBenchmarkSample Run(string localeXml)
    {
        if (string.IsNullOrWhiteSpace(localeXml))
            throw new ArgumentException("Fixture Vittorio vuota.", nameof(localeXml));

        XDocument.Parse(localeXml, LoadOptions.PreserveWhitespace);

        string tempRoot = Path.Combine(
            Path.GetTempPath(),
            "TermodelVittorioBenchmark",
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
                    SpiralHeating.Program.AggiornaSpirali();
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
                    "StrategiaVittorio non ha prodotto locale.svg.");
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
                SpiralHeating.Program.PassoTubi,
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

public sealed record StrategiaVittorioBenchmarkSample(
    string Svg,
    string ResultLocaleXml,
    double StepMeters,
    int LocaleCount,
    int SpiralPointCount,
    long ElapsedMilliseconds,
    long MemoryDeltaBytes,
    IReadOnlyList<string> Diagnostics);
