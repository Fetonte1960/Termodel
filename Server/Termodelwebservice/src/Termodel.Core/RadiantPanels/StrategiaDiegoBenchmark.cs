using System.Xml.Linq;
using Termodel.utilities;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Facciata pubblica esclusivamente diagnostica/benchmark per StrategiaDiego.
/// Non modifica la selezione del motore usata dal Service.
/// </summary>
public static class StrategiaDiegoBenchmark
{
    public static StrategiaDiegoBenchmarkSample Run(
        string localeXml,
        double stepMeters = StrategiaDiegoEngine.DefaultStepMeters,
        bool includeDetailedDiagnostics = false)
    {
        if (string.IsNullOrWhiteSpace(localeXml))
            throw new ArgumentException("Fixture Diego vuota.", nameof(localeXml));

        XDocument document = XDocument.Parse(
            localeXml,
            LoadOptions.PreserveWhitespace);

        TermodelLog.InitializeLog(
            includeDetailedDiagnostics
                ? new TermodelLog.LogConfiguration(
                    true,
                    new HashSet<TermodelLog.LogCategory>
                    {
                        TermodelLog.LogCategory.SpiraliDiego
                    })
                : null);

        StrategiaDiegoResult result =
            StrategiaDiegoEngine.Generate(document, stepMeters);

        StrategiaDiegoMetrics m = result.Metrics;
        IReadOnlyList<string> diagnostics = includeDetailedDiagnostics
            ? result.Diagnostics.Concat(TermodelLog.Messages).ToArray()
            : result.Diagnostics;

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
            diagnostics);
    }
    public static StrategiaDiegoSupplyExplorerSample ExploreSupply(
        string localeXml,
        double stepMeters = StrategiaDiegoEngine.DefaultStepMeters,
        int topCount = 20)
    {
        if (string.IsNullOrWhiteSpace(localeXml))
            throw new ArgumentException("Fixture Diego vuota.", nameof(localeXml));
        if (topCount <= 0)
            throw new ArgumentOutOfRangeException(nameof(topCount));

        XDocument document = XDocument.Parse(
            localeXml,
            LoadOptions.PreserveWhitespace);

        StrategiaDiegoSupplyExplorerResult result =
            StrategiaDiegoEngine.ExploreSupply(
                document,
                stepMeters,
                topCount);

        return new StrategiaDiegoSupplyExplorerSample(
            result.LocaleId,
            result.StepMeters,
            result.SupplyNodes,
            result.SupplyTerminals,
            result.Items
                .Select(item => new StrategiaDiegoSupplyExplorerEntry(
                    item.Rank,
                    item.TerminalNodeId,
                    item.Depth,
                    item.ActiveLengthMeters,
                    item.Goodness,
                    item.TotalLengthMeters,
                    item.NodeIds,
                    item.Svg))
                .ToArray());
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

public sealed record StrategiaDiegoSupplyExplorerSample(
    string LocaleId,
    double StepMeters,
    int SupplyNodes,
    int SupplyTerminals,
    IReadOnlyList<StrategiaDiegoSupplyExplorerEntry> Items);

public sealed record StrategiaDiegoSupplyExplorerEntry(
    int Rank,
    int TerminalNodeId,
    int Depth,
    double ActiveLengthMeters,
    double Goodness,
    double TotalLengthMeters,
    IReadOnlyList<int> NodeIds,
    string Svg);
