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
        bool includeDetailedDiagnostics = false,
        IReadOnlyCollection<string>? rejectedDecisionKeys = null,
        IReadOnlyList<string>? lockedSupplyDecisionPrefix = null)
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

        IReadOnlySet<string>? decisionRejectSet =
            NormalizeRejectedDecisionKeys(rejectedDecisionKeys);
        IReadOnlyList<string>? decisionPrefix =
            NormalizeDecisionPrefix(lockedSupplyDecisionPrefix);

        StrategiaDiegoResult result =
            StrategiaDiegoEngine.Generate(
                document,
                stepMeters,
                numberSpiralNodes: true,
                rejectedDecisionKeys: decisionRejectSet,
                lockedSupplyDecisionPrefix: decisionPrefix);

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
        int topCount = 20,
        IReadOnlyCollection<string>? rejectedDecisionKeys = null,
        IReadOnlyList<string>? lockedSupplyDecisionPrefix = null)
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
                topCount,
                NormalizeRejectedDecisionKeys(rejectedDecisionKeys),
                NormalizeDecisionPrefix(lockedSupplyDecisionPrefix));

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
                    item.DecisionKeys,
                    item.TerminalDecisionKey,
                    item.Svg))
                .ToArray());
    }
    public static StrategiaDiegoRankedSolutionExplorerSample ExploreRankedSolutions(
        string localeXml,
        double stepMeters = StrategiaDiegoEngine.DefaultStepMeters,
        int skipTop = 0,
        int count = 20,
        IReadOnlyCollection<string>? rejectedDecisionKeys = null,
        IReadOnlyList<string>? lockedSupplyDecisionPrefix = null)
    {
        if (string.IsNullOrWhiteSpace(localeXml))
            throw new ArgumentException("Fixture Diego vuota.", nameof(localeXml));
        if (skipTop < 0)
            throw new ArgumentOutOfRangeException(nameof(skipTop));
        if (count <= 0)
            throw new ArgumentOutOfRangeException(nameof(count));

        XDocument document = XDocument.Parse(
            localeXml,
            LoadOptions.PreserveWhitespace);

        StrategiaDiegoRankedSolutionExplorerResult result =
            StrategiaDiegoEngine.ExploreRankedSolutions(
                document,
                stepMeters,
                skipTop,
                count,
                NormalizeRejectedDecisionKeys(rejectedDecisionKeys),
                NormalizeDecisionPrefix(lockedSupplyDecisionPrefix));

        return new StrategiaDiegoRankedSolutionExplorerSample(
            result.LocaleId,
            result.StepMeters,
            result.SupplyNodes,
            result.SupplyTerminals,
            result.SkipTop,
            result.Items.Select(item =>
                new StrategiaDiegoRankedSolutionExplorerEntry(
                    item.SupplyRank,
                    item.SupplyTerminalNodeId,
                    item.SupplyActiveLengthMeters,
                    item.SupplyGoodness,
                    item.SupplyTotalLengthMeters,
                    item.SupplyNodeIds,
                    item.SupplyDecisionKeys,
                    item.SupplyTerminalDecisionKey,
                    item.ReturnFeasible,
                    item.ReturnTerminalNodeId,
                    item.ReturnActiveLengthMeters,
                    item.ReturnGoodness,
                    item.ReturnTotalLengthMeters,
                    item.ClosureLengthMeters,
                    item.CombinedMeritMeters,
                    item.ReturnRootSide,
                    item.ReturnNodeIds,
                    item.ReturnDecisionKeys,
                    item.ReturnTerminalDecisionKey,
                    item.ReturnNodesExplored,
                    item.CombinedTerminals,
                    item.AcceptedTerminals,
                    item.ReturnError,
                    item.Svg)).ToArray());
    }

    private static IReadOnlyList<string>? NormalizeDecisionPrefix(
        IReadOnlyList<string>? lockedSupplyDecisionPrefix)
    {
        if (lockedSupplyDecisionPrefix is null ||
            lockedSupplyDecisionPrefix.Count == 0)
        {
            return null;
        }

        var result = new List<string>();
        foreach (string raw in lockedSupplyDecisionPrefix)
        {
            string key = raw.Trim();
            if (key.Length == 0 ||
                key.StartsWith("#", StringComparison.Ordinal))
            {
                continue;
            }

            if (!key.StartsWith(
                    "DIEGO_DECISION ",
                    StringComparison.Ordinal))
            {
                throw new InvalidDataException(
                    "Prefix Lock: ogni riga deve essere una Decision Key canonica.");
            }

            result.Add(key);
        }

        return result.Count == 0
            ? null
            : result;
    }

    private static IReadOnlySet<string>? NormalizeRejectedDecisionKeys(
        IReadOnlyCollection<string>? rejectedDecisionKeys)
    {
        if (rejectedDecisionKeys is null ||
            rejectedDecisionKeys.Count == 0)
        {
            return null;
        }

        var result = new HashSet<string>(
            StringComparer.Ordinal);
        foreach (string raw in rejectedDecisionKeys)
        {
            string key = raw.Trim();
            if (key.Length == 0 ||
                key.StartsWith("#", StringComparison.Ordinal))
            {
                continue;
            }

            result.Add(key);
        }

        return result.Count == 0
            ? null
            : result;
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
    IReadOnlyList<string> DecisionKeys,
    string? TerminalDecisionKey,
    string Svg);

public sealed record StrategiaDiegoRankedSolutionExplorerSample(
    string LocaleId,
    double StepMeters,
    int SupplyNodes,
    int SupplyTerminals,
    int SkipTop,
    IReadOnlyList<StrategiaDiegoRankedSolutionExplorerEntry> Items);

public sealed record StrategiaDiegoRankedSolutionExplorerEntry(
    int SupplyRank,
    int SupplyTerminalNodeId,
    double SupplyActiveLengthMeters,
    double SupplyGoodness,
    double SupplyTotalLengthMeters,
    IReadOnlyList<int> SupplyNodeIds,
    IReadOnlyList<string> SupplyDecisionKeys,
    string? SupplyTerminalDecisionKey,
    bool ReturnFeasible,
    int? ReturnTerminalNodeId,
    double? ReturnActiveLengthMeters,
    double? ReturnGoodness,
    double? ReturnTotalLengthMeters,
    double? ClosureLengthMeters,
    double? CombinedMeritMeters,
    string? ReturnRootSide,
    IReadOnlyList<int>? ReturnNodeIds,
    IReadOnlyList<string>? ReturnDecisionKeys,
    string? ReturnTerminalDecisionKey,
    int ReturnNodesExplored,
    int CombinedTerminals,
    int AcceptedTerminals,
    string? ReturnError,
    string Svg);
