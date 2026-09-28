using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Xml.Linq;
using Termodel.utilities;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Facciata diagnostica per eseguire nel banco prova la copia indipendente
/// Diego_Vittorio, senza modificare il motore Vittorio di riferimento.
/// </summary>
public static class StrategiaDiegoVittorioBenchmark
{
    private static readonly object EngineGate = new();

    // Funzione realizzata da Codex in autonomia
    public static StrategiaVittorioBenchmarkSample Run(
        string localeXml,
        double stepMeters = SpiralHeatingDiegoVittorio.Program.PassoTubi,
        TermodelLog.LogConfiguration? logConfiguration = null) =>
        RunCore(localeXml, stepMeters, supplyOnly: false, logConfiguration);

    // Diagnostica FASE 6C: restituisce l'output della sola generazione Supply,
    // prima di Return e chiusura LG-048.
    public static StrategiaVittorioBenchmarkSample RunSupplyOnly(
        string localeXml,
        double stepMeters = SpiralHeatingDiegoVittorio.Program.PassoTubi,
        TermodelLog.LogConfiguration? logConfiguration = null) =>
        RunCore(localeXml, stepMeters, supplyOnly: true, logConfiguration);

    private static StrategiaVittorioBenchmarkSample RunCore(
        string localeXml,
        double stepMeters,
        bool supplyOnly,
        TermodelLog.LogConfiguration? logConfiguration)
    {
        if (string.IsNullOrWhiteSpace(localeXml))
            throw new ArgumentException("Fixture Diego_Vittorio vuota.", nameof(localeXml));
        // Modificato da Codex per realizzare: accettare il passo richiesto
        // dall'Harness e rifiutare valori geometricamente non validi.
        if (!double.IsFinite(stepMeters) || stepMeters <= 0)
            throw new ArgumentOutOfRangeException(nameof(stepMeters));

        XDocument.Parse(localeXml, LoadOptions.PreserveWhitespace);

        string tempRoot = Path.Combine(
            Path.GetTempPath(),
            "TermodelDiegoVittorioBenchmark",
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
                    if (logConfiguration is not null)
                        TermodelLog.InitializeLog(logConfiguration);
                    if (supplyOnly)
                        SpiralHeatingDiegoVittorio.Program.AggiornaSoloMandata(stepMeters);
                    else
                        SpiralHeatingDiegoVittorio.Program.AggiornaSpirali(stepMeters);
                }
                finally
                {
                    Console.SetOut(previousOut);
                    Directory.SetCurrentDirectory(previousDirectory);
                    if (logConfiguration is not null)
                    {
                        diagnostics.AddRange(TermodelLog.Messages);
                        TermodelLog.Reset();
                    }
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
                    "Strategia Diego_Vittorio non ha prodotto locale.svg.");
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
                stepMeters,
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
