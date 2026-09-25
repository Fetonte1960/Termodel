using System.Xml.Linq;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Facciata pubblica esclusivamente diagnostica/benchmark per StrategiaDiego.
/// Non modifica la selezione del motore usata dal Service.
/// </summary>
public static class StrategiaDiegoBenchmark
{
    public static StrategiaDiegoBenchmarkSample Run(
        string localeXml,
        double stepMeters = StrategiaDiegoEngine.DefaultStepMeters)
    {
        if (string.IsNullOrWhiteSpace(localeXml))
            throw new ArgumentException("Fixture Diego vuota.", nameof(localeXml));

        XDocument document = XDocument.Parse(
            localeXml,
            LoadOptions.PreserveWhitespace);

        StrategiaDiegoResult result =
            StrategiaDiegoEngine.Generate(document, stepMeters);

        StrategiaDiegoMetrics m = result.Metrics;
        return new StrategiaDiegoBenchmarkSample(
            result.Svg,
            result.StepMeters,
            m.SupplyNodes,
            m.SupplyTerminals,
            m.ReturnNodes,
            m.CombinedTerminals,
            m.AcceptedTerminals,
            m.MaxDepth,
            m.ElapsedMilliseconds,
            m.MemoryDeltaBytes,
            m.TotalNodes,
            m.MaxNodes,
            m.MaxDepthLimit,
            result.Diagnostics);
    }
}

public sealed record StrategiaDiegoBenchmarkSample(
    string Svg,
    double StepMeters,
    int SupplyNodes,
    int SupplyTerminals,
    int ReturnNodes,
    int CombinedTerminals,
    int AcceptedTerminals,
    int MaxDepth,
    long ElapsedMilliseconds,
    long MemoryDeltaBytes,
    int TotalNodes,
    int MaxNodes,
    int MaxDepthLimit,
    IReadOnlyList<string> Diagnostics);
