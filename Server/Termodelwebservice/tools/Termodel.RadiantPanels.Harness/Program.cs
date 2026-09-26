using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Text.Json.Nodes;
using System.Text.RegularExpressions;
using System.Xml.Linq;
using Termodel.Core.RadiantPanels;
using Termodel.Core.ProjectFiles;
using Termodel.Leggidxf;

return args.Length == 0
    ? Usage()
    : args[0].ToLowerInvariant() switch
    {
        "run" => Run(args.Skip(1).ToArray()),
        "prepare" => await PrepareAsync(args.Skip(1).ToArray()),
        _ => Usage()
    };

static int Usage()
{
    Console.Error.WriteLine("Termodel.RadiantPanels.Harness");
    Console.Error.WriteLine("  run --case <case.json> [--out <dir>] [--inspect-node N] [--compare-node M] [--solution-top N] [--skip-top N] [--solution-rank N] [--supply-top N] [--supply-rank N]");
    Console.Error.WriteLine("  run --input <locale.xml> [--id <case-id>] [--p <metri>] [--out <dir>] [--inspect-node N] [--compare-node M] [--solution-top N] [--skip-top N] [--solution-rank N] [--supply-top N] [--supply-rank N]");
    Console.Error.WriteLine("  prepare --project <project.tmdl> --output <locale.xml>");
    return 64;
}

static int Run(string[] args)
{
    try
    {
        string? casePath = Arg(args, "--case");
        string? inputPath = Arg(args, "--input");
        string? outputArg = Arg(args, "--out");
        string? idArg = Arg(args, "--id");
        string? stepArg = Arg(args, "--p");
        int? inspectNode = PositiveIntArg(args, "--inspect-node");
        int? compareNode = PositiveIntArg(args, "--compare-node");
        int? solutionTop = PositiveIntArg(args, "--solution-top");
        int? solutionRank = PositiveIntArg(args, "--solution-rank");
        int? supplyTop = PositiveIntArg(args, "--supply-top");
        int skipTop = NonNegativeIntArg(args, "--skip-top") ?? 0;
        int? supplyRank = PositiveIntArg(args, "--supply-rank");

        HarnessCase? testCase = null;
        if (!string.IsNullOrWhiteSpace(casePath))
        {
            string fullCasePath = Path.GetFullPath(casePath);
            testCase = JsonSerializer.Deserialize<HarnessCase>(
                File.ReadAllText(fullCasePath, Encoding.UTF8),
                new JsonSerializerOptions { PropertyNameCaseInsensitive = true })
                ?? throw new InvalidDataException("Case JSON vuoto.");

            string caseDirectory = Path.GetDirectoryName(fullCasePath)!;
            inputPath = Path.GetFullPath(
                Path.Combine(caseDirectory, testCase.PreparedInput));
            idArg ??= testCase.Id;
        }

        if (string.IsNullOrWhiteSpace(inputPath))
            throw new ArgumentException("Specificare --case oppure --input.");

        string fullInputPath = Path.GetFullPath(inputPath);
        if (!File.Exists(fullInputPath))
            throw new FileNotFoundException("Input pannelli non trovato.", fullInputPath);

        double stepMeters = testCase?.StepMeters ?? 0.30;
        if (!string.IsNullOrWhiteSpace(stepArg))
        {
            if (!double.TryParse(
                    stepArg,
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out stepMeters) ||
                !double.IsFinite(stepMeters) ||
                stepMeters <= 0)
            {
                throw new ArgumentException("--p deve essere un numero positivo in metri.");
            }
        }

        string caseId = SanitizeFileName(
            string.IsNullOrWhiteSpace(idArg)
                ? Path.GetFileNameWithoutExtension(
                    Path.GetFileNameWithoutExtension(fullInputPath))
                : idArg);

        string outputDir = Path.GetFullPath(
            string.IsNullOrWhiteSpace(outputArg)
                ? Path.Combine(Environment.CurrentDirectory, "RadiantHarnessOut")
                : outputArg);
        Directory.CreateDirectory(outputDir);

        string localeXml = File.ReadAllText(fullInputPath, Encoding.UTF8);

        if (inspectNode is not null)
        {
            return RunBranchInspector(
                localeXml,
                stepMeters,
                caseId,
                outputDir,
                inspectNode.Value,
                compareNode);
        }
        if (solutionTop is not null || solutionRank is not null)
        {
            int solutionSkip = solutionRank is null
                ? skipTop
                : solutionRank.Value - 1;
            int solutionCount = solutionRank is null
                ? solutionTop ?? 20
                : 1;

            return RunRankedSolutionExplorer(
                localeXml,
                stepMeters,
                caseId,
                outputDir,
                solutionSkip,
                solutionCount);
        }
        if (supplyTop is not null || supplyRank is not null || skipTop > 0)
        {
            int exportCount = supplyTop ?? 20;
            int requestedTop = supplyRank is not null
                ? supplyRank.Value
                : skipTop + exportCount;

            return RunSupplyExplorer(
                localeXml,
                stepMeters,
                caseId,
                outputDir,
                requestedTop,
                supplyRank,
                skipTop,
                exportCount);
        }

        StrategiaDiegoBenchmarkSample sample =
            StrategiaDiegoBenchmark.Run(
                localeXml,
                stepMeters,
                includeDetailedDiagnostics: true);

        string svgPath = Path.Combine(outputDir, caseId + ".svg");
        string logPath = Path.Combine(outputDir, caseId + ".log.txt");
        string metricsPath = Path.Combine(outputDir, caseId + ".metrics.json");

        File.WriteAllText(svgPath, sample.Svg, new UTF8Encoding(false));
        File.WriteAllLines(logPath, sample.Diagnostics, new UTF8Encoding(false));

        var metrics = new
        {
            caseId,
            description = testCase?.Description,
            input = fullInputPath,
            stepMeters = sample.StepMeters,
            sample.SupplyNodes,
            sample.SupplyTerminals,
            sample.ReturnNodes,
            sample.CombinedTerminals,
            sample.AcceptedTerminals,
            sample.MaxDepth,
            sample.TotalNodes,
            sample.MaxNodes,
            sample.MaxDepthLimit,
            sample.ElapsedMilliseconds,
            sample.MemoryDeltaBytes,
            diagnosticsCount = sample.Diagnostics.Count,
            svgSha256 = Sha256(sample.Svg)
        };

        File.WriteAllText(
            metricsPath,
            JsonSerializer.Serialize(metrics, new JsonSerializerOptions { WriteIndented = true }),
            new UTF8Encoding(false));

        Console.WriteLine("RADIANT_HARNESS_OK");
        Console.WriteLine($"case={caseId}");
        Console.WriteLine($"input={fullInputPath}");
        Console.WriteLine($"p={sample.StepMeters.ToString("0.###", CultureInfo.InvariantCulture)}");
        Console.WriteLine($"nodes={sample.TotalNodes}");
        Console.WriteLine($"acceptedTerminals={sample.AcceptedTerminals}");
        Console.WriteLine($"elapsedMs={sample.ElapsedMilliseconds}");
        Console.WriteLine($"svg={svgPath}");
        Console.WriteLine($"log={logPath}");
        Console.WriteLine($"metrics={metricsPath}");

        return sample.AcceptedTerminals > 0 ? 0 : 2;
    }
    catch (Exception ex)
    {
        Console.Error.WriteLine("RADIANT_HARNESS_FAILED");
        Console.Error.WriteLine(ex);
        return 3;
    }
}


static int RunBranchInspector(
    string localeXml,
    double stepMeters,
    string caseId,
    string outputDir,
    int inspectNode,
    int? compareNode)
{
    StrategiaDiegoBenchmarkSample sample =
        StrategiaDiegoBenchmark.Run(
            localeXml,
            stepMeters,
            includeDetailedDiagnostics: true);

    Dictionary<int, BranchEdge> edges =
        ParseSupplyEdges(sample.Diagnostics);

    if (!edges.ContainsKey(inspectNode))
        throw new InvalidDataException(
            $"Nodo Supply {inspectNode} non trovato nel log.");

    List<BranchEdge> targetPath =
        ReconstructBranchPath(edges, inspectNode);
    List<BranchEdge> comparePath =
        compareNode is int compare
            ? ReconstructBranchPath(edges, compare)
            : new List<BranchEdge>();

    List<BranchCandidate> candidates =
        ParseBranchCandidates(
            sample.Diagnostics,
            inspectNode,
            targetPath[^1].B);

    XDocument document = XDocument.Parse(
        localeXml,
        LoadOptions.PreserveWhitespace);
    List<InspectPoint> perimeter =
        ParseFirstLocalePerimeter(document);

    string inspectorDir = Path.Combine(
        outputDir,
        caseId + ".branch-inspector");
    Directory.CreateDirectory(inspectorDir);

    string svg = BuildBranchInspectorSvg(
        perimeter,
        targetPath,
        comparePath,
        candidates,
        inspectNode,
        compareNode);

    string svgPath = Path.Combine(
        inspectorDir,
        $"branch-node-{inspectNode:000}.svg");
    File.WriteAllText(
        svgPath,
        svg,
        new UTF8Encoding(false));

    string jsonPath = Path.Combine(
        inspectorDir,
        $"branch-node-{inspectNode:000}.json");
    var report = new
    {
        caseId,
        stepMeters,
        inspectNode,
        compareNode,
        targetPathNodeIds =
            BranchPathNodeIds(targetPath),
        comparePathNodeIds =
            comparePath.Count == 0
                ? Array.Empty<int>()
                : BranchPathNodeIds(comparePath),
        candidates = candidates.Select(candidate => new
        {
            candidate.Kind,
            candidate.Status,
            start = new { candidate.Start.X, candidate.Start.Y },
            target = candidate.Target is InspectPoint target
                ? new { target.X, target.Y }
                : null,
            intersection = candidate.Intersection is InspectPoint intersection
                ? new { intersection.X, intersection.Y }
                : null,
            candidate.Reference,
            candidate.ReferenceFamily,
            candidate.ReferenceType,
            candidate.RespectMeters,
            candidate.Reason
        }).ToArray()
    };
    File.WriteAllText(
        jsonPath,
        JsonSerializer.Serialize(
            report,
            new JsonSerializerOptions { WriteIndented = true }),
        new UTF8Encoding(false));

    string logPath = Path.Combine(
        inspectorDir,
        $"branch-node-{inspectNode:000}.log.txt");
    File.WriteAllLines(
        logPath,
        ExtractNodeDiagnosticWindow(
            sample.Diagnostics,
            inspectNode),
        new UTF8Encoding(false));

    Console.WriteLine("RADIANT_HARNESS_BRANCH_INSPECTOR_OK");
    Console.WriteLine($"case={caseId}");
    Console.WriteLine($"inspectNode={inspectNode}");
    Console.WriteLine($"compareNode={compareNode?.ToString(CultureInfo.InvariantCulture) ?? "-"}");
    Console.WriteLine($"targetPath={string.Join("->", BranchPathNodeIds(targetPath))}");
    Console.WriteLine($"candidates={candidates.Count}");
    foreach (BranchCandidate candidate in candidates)
    {
        Console.WriteLine(
            $"BRANCH_CANDIDATE kind={candidate.Kind} status={candidate.Status} " +
            $"target={(candidate.Target is InspectPoint t ? FormatInspectPoint(t) : "-")} " +
            $"reference={candidate.Reference ?? "-"} reason={candidate.Reason ?? "-"}");
    }
    Console.WriteLine($"svg={svgPath}");
    Console.WriteLine($"json={jsonPath}");
    Console.WriteLine($"log={logPath}");
    return 0;
}

static Dictionary<int, BranchEdge> ParseSupplyEdges(
    IReadOnlyList<string> diagnostics)
{
    var result = new Dictionary<int, BranchEdge>();

    Regex initial = new(
        @"TREE Supply initial ACCEPT node=(?<node>\d+) (?<a>\([^)]+\))->(?<b>\([^)]+\))");
    Regex choice = new(
        @"TREE Supply CHOICE (?<choice>\S+) ACCEPT parentNode=(?<parent>\d+) childNode=(?<child>\d+) (?<a>\([^)]+\))->(?<b>\([^)]+\))");

    foreach (string line in diagnostics)
    {
        Match initialMatch = initial.Match(line);
        if (initialMatch.Success)
        {
            int node = int.Parse(
                initialMatch.Groups["node"].Value,
                CultureInfo.InvariantCulture);
            result[node] = new BranchEdge(
                null,
                node,
                "INITIAL",
                ParseInspectPoint(initialMatch.Groups["a"].Value),
                ParseInspectPoint(initialMatch.Groups["b"].Value));
            continue;
        }

        Match choiceMatch = choice.Match(line);
        if (!choiceMatch.Success)
            continue;

        int parent = int.Parse(
            choiceMatch.Groups["parent"].Value,
            CultureInfo.InvariantCulture);
        int child = int.Parse(
            choiceMatch.Groups["child"].Value,
            CultureInfo.InvariantCulture);

        result[child] = new BranchEdge(
            parent,
            child,
            choiceMatch.Groups["choice"].Value,
            ParseInspectPoint(choiceMatch.Groups["a"].Value),
            ParseInspectPoint(choiceMatch.Groups["b"].Value));
    }

    return result;
}

static List<BranchEdge> ReconstructBranchPath(
    IReadOnlyDictionary<int, BranchEdge> edges,
    int nodeId)
{
    var reversed = new List<BranchEdge>();
    int current = nodeId;

    while (true)
    {
        if (!edges.TryGetValue(current, out BranchEdge? edge))
            throw new InvalidDataException(
                $"Impossibile ricostruire il nodo Supply {current}.");

        reversed.Add(edge);
        if (edge.ParentNodeId is null)
            break;

        current = edge.ParentNodeId.Value;
    }

    reversed.Reverse();
    return reversed;
}

static int[] BranchPathNodeIds(
    IReadOnlyList<BranchEdge> path) =>
    path.Select(edge => edge.ChildNodeId).ToArray();

static List<BranchCandidate> ParseBranchCandidates(
    IReadOnlyList<string> diagnostics,
    int nodeId,
    InspectPoint start)
{
    Regex straightCheck = new(
        $@"LG041 CANDIDATE CHECK parentNode={nodeId} family=Supply reference=(?<ref>\S+) refFamily=(?<family>\S+) type=(?<type>\S+) I=(?<i>\([^)]+\)) T=(?<t>\([^)]+\)) d=(?<d>[-0-9.]+)m");
    Regex straightOutcome = new(
        $@"LG041 CANDIDATE (?<status>ACCEPT|REJECT|DUPLICATE) parentNode={nodeId} family=Supply reference=(?<ref>\S+)");
    Regex tryCheck = new(
        $@"TRYEXT CHECK parentNode={nodeId} choice=(?<choice>\S+) family=Supply reference=(?<ref>\S+) refFamily=(?<family>\S+) type=(?<type>\S+) I=(?<i>\([^)]+\)) T=(?<t>\([^)]+\)) d=(?<d>[-0-9.]+)m");
    Regex tryOutcome = new(
        $@"TRYEXT (?<status>ACCEPT|REJECT) parentNode={nodeId} choice=(?<choice>\S+) reference=(?<ref>\S+)");
    Regex parallelTreeReject = new(
        $@"TREE Supply CHOICE (?<choice>PARALLELA_[AB]) REJECT parentNode={nodeId} start=(?<start>\([^)]+\)) dir=(?<dir>\([^)]+\)) requiredFront=(?<ref>\S+)");

    var result = new List<BranchCandidate>();
    BranchCandidate? pending = null;

    foreach (string line in diagnostics)
    {
        Match straight = straightCheck.Match(line);
        if (straight.Success)
        {
            pending = new BranchCandidate(
                "PROSEGUI_DRITTO",
                "PENDING",
                start,
                ParseInspectPoint(straight.Groups["t"].Value),
                ParseInspectPoint(straight.Groups["i"].Value),
                straight.Groups["ref"].Value,
                straight.Groups["family"].Value,
                straight.Groups["type"].Value,
                ParseInvariantDouble(straight.Groups["d"].Value),
                null);
            result.Add(pending);
            continue;
        }

        Match tryMatch = tryCheck.Match(line);
        if (tryMatch.Success)
        {
            pending = new BranchCandidate(
                tryMatch.Groups["choice"].Value,
                "PENDING",
                start,
                ParseInspectPoint(tryMatch.Groups["t"].Value),
                ParseInspectPoint(tryMatch.Groups["i"].Value),
                tryMatch.Groups["ref"].Value,
                tryMatch.Groups["family"].Value,
                tryMatch.Groups["type"].Value,
                ParseInvariantDouble(tryMatch.Groups["d"].Value),
                null);
            result.Add(pending);
            continue;
        }

        if (pending is not null &&
            pending.Status == "PENDING" &&
            line.Contains(
                "VALIDATE Supply REJECT",
                StringComparison.Ordinal))
        {
            pending.Reason = line[
                (line.IndexOf("VALIDATE Supply REJECT", StringComparison.Ordinal) +
                 "VALIDATE Supply REJECT".Length)..].Trim();
            continue;
        }

        Match straightResult = straightOutcome.Match(line);
        if (straightResult.Success)
        {
            BranchCandidate? match = result.LastOrDefault(candidate =>
                candidate.Kind == "PROSEGUI_DRITTO" &&
                candidate.Reference == straightResult.Groups["ref"].Value &&
                candidate.Status == "PENDING");
            if (match is not null)
                match.Status = straightResult.Groups["status"].Value;
            pending = null;
            continue;
        }

        Match tryResult = tryOutcome.Match(line);
        if (tryResult.Success)
        {
            BranchCandidate? match = result.LastOrDefault(candidate =>
                candidate.Kind == tryResult.Groups["choice"].Value &&
                candidate.Reference == tryResult.Groups["ref"].Value &&
                candidate.Status == "PENDING");
            if (match is not null)
                match.Status = tryResult.Groups["status"].Value;
            pending = null;
            continue;
        }

        Match treeReject = parallelTreeReject.Match(line);
        if (treeReject.Success &&
            !result.Any(candidate =>
                candidate.Kind == treeReject.Groups["choice"].Value))
        {
            result.Add(new BranchCandidate(
                treeReject.Groups["choice"].Value,
                "REJECT",
                ParseInspectPoint(treeReject.Groups["start"].Value),
                null,
                null,
                treeReject.Groups["ref"].Value,
                null,
                null,
                null,
                "nessun candidato geometrico valido"));
        }
    }

    foreach (BranchCandidate candidate in result.Where(candidate =>
                 candidate.Status == "PENDING"))
    {
        candidate.Status = "UNKNOWN";
    }

    return result;
}

static string[] ExtractNodeDiagnosticWindow(
    IReadOnlyList<string> diagnostics,
    int nodeId)
{
    int start = -1;
    int end = diagnostics.Count;
    string marker = $"TREE Supply NODE node={nodeId} ";

    for (int i = 0; i < diagnostics.Count; i++)
    {
        if (start < 0 &&
            diagnostics[i].Contains(marker, StringComparison.Ordinal))
        {
            start = i;
            continue;
        }

        if (start >= 0 &&
            diagnostics[i].Contains(
                "TREE Supply NODE node=",
                StringComparison.Ordinal))
        {
            end = i;
            break;
        }
    }

    if (start < 0)
        return Array.Empty<string>();

    return diagnostics
        .Skip(start)
        .Take(end - start)
        .ToArray();
}

static List<InspectPoint> ParseFirstLocalePerimeter(
    XDocument document)
{
    XElement locale = document
        .Descendants("Locale")
        .FirstOrDefault()
        ?? throw new InvalidDataException(
            "Branch Inspector: nessun Locale.");

    XElement perimeter = locale
        .Descendants("PerimetroInterno")
        .FirstOrDefault()
        ?? throw new InvalidDataException(
            "Branch Inspector: PerimetroInterno mancante.");

    List<InspectPoint> points = perimeter
        .Elements("Punto")
        .Select(point => new InspectPoint(
            double.Parse(
                (string?)point.Attribute("X") ?? "0",
                CultureInfo.InvariantCulture),
            double.Parse(
                (string?)point.Attribute("Y") ?? "0",
                CultureInfo.InvariantCulture)))
        .ToList();

    if (points.Count > 0 &&
        (points[0].X != points[^1].X ||
         points[0].Y != points[^1].Y))
    {
        points.Add(points[0]);
    }

    return points;
}

static string BuildBranchInspectorSvg(
    IReadOnlyList<InspectPoint> perimeter,
    IReadOnlyList<BranchEdge> targetPath,
    IReadOnlyList<BranchEdge> comparePath,
    IReadOnlyList<BranchCandidate> candidates,
    int inspectNode,
    int? compareNode)
{
    List<InspectPoint> allPoints = perimeter
        .Concat(targetPath.SelectMany(edge => new[] { edge.A, edge.B }))
        .Concat(comparePath.SelectMany(edge => new[] { edge.A, edge.B }))
        .Concat(candidates
            .Where(candidate => candidate.Target is not null)
            .Select(candidate => candidate.Target!.Value))
        .ToList();

    double minX = allPoints.Min(point => point.X) - 0.35;
    double minY = allPoints.Min(point => point.Y) - 0.35;
    double maxX = allPoints.Max(point => point.X) + 0.35;
    double maxY = allPoints.Max(point => point.Y) + 0.35;

    var builder = new StringBuilder();
    builder.AppendLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
    builder.AppendLine(
        FormattableString.Invariant(
            $"<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"{minX} {minY} {maxX - minX} {maxY - minY}\" data-role=\"branch-inspector\" data-node=\"{inspectNode}\">"));
    builder.AppendLine(
        "<defs><marker id=\"arrow-green\" viewBox=\"0 0 10 10\" refX=\"9\" refY=\"5\" markerWidth=\"5\" markerHeight=\"5\" orient=\"auto-start-reverse\"><path d=\"M 0 0 L 10 5 L 0 10 z\" fill=\"#16823a\"/></marker><marker id=\"arrow-red\" viewBox=\"0 0 10 10\" refX=\"9\" refY=\"5\" markerWidth=\"5\" markerHeight=\"5\" orient=\"auto-start-reverse\"><path d=\"M 0 0 L 10 5 L 0 10 z\" fill=\"#c62828\"/></marker></defs>");

    string perimeterPoints = string.Join(
        " ",
        perimeter.Select(point =>
            $"{FmtInspect(point.X)},{FmtInspect(point.Y)}"));
    builder.AppendLine(
        $"<polyline points=\"{perimeterPoints}\" fill=\"none\" stroke=\"black\" stroke-width=\"0.025\"/>");

    foreach (BranchEdge edge in targetPath)
    {
        builder.AppendLine(
            $"<line x1=\"{FmtInspect(edge.A.X)}\" y1=\"{FmtInspect(edge.A.Y)}\" x2=\"{FmtInspect(edge.B.X)}\" y2=\"{FmtInspect(edge.B.Y)}\" stroke=\"#d7191c\" stroke-width=\"0.035\"/>");
        builder.AppendLine(
            $"<text x=\"{FmtInspect(edge.B.X)}\" y=\"{FmtInspect(edge.B.Y)}\" font-size=\"0.09\" fill=\"#6a006a\">{edge.ChildNodeId}</text>");
    }

    HashSet<int> targetNodes = targetPath
        .Select(edge => edge.ChildNodeId)
        .ToHashSet();

    foreach (BranchEdge edge in comparePath.Where(edge =>
                 !targetNodes.Contains(edge.ChildNodeId)))
    {
        builder.AppendLine(
            $"<line x1=\"{FmtInspect(edge.A.X)}\" y1=\"{FmtInspect(edge.A.Y)}\" x2=\"{FmtInspect(edge.B.X)}\" y2=\"{FmtInspect(edge.B.Y)}\" stroke=\"#e67e22\" stroke-width=\"0.035\"/>");
        builder.AppendLine(
            $"<text x=\"{FmtInspect(edge.B.X)}\" y=\"{FmtInspect(edge.B.Y)}\" font-size=\"0.09\" fill=\"#9a4d00\">{edge.ChildNodeId}</text>");
    }

    InspectPoint targetPoint = targetPath[^1].B;
    builder.AppendLine(
        $"<circle cx=\"{FmtInspect(targetPoint.X)}\" cy=\"{FmtInspect(targetPoint.Y)}\" r=\"0.06\" fill=\"#ffd700\" stroke=\"black\" stroke-width=\"0.015\"/>");

    int labelIndex = 0;
    foreach (BranchCandidate candidate in candidates)
    {
        labelIndex++;
        if (candidate.Target is not InspectPoint target)
            continue;

        bool accepted =
            candidate.Status.Equals(
                "ACCEPT",
                StringComparison.OrdinalIgnoreCase);
        string stroke = accepted ? "#16823a" : "#c62828";
        string dash = accepted ? string.Empty : " stroke-dasharray=\"0.08 0.05\"";
        string marker = accepted ? "arrow-green" : "arrow-red";

        builder.AppendLine(
            $"<line x1=\"{FmtInspect(candidate.Start.X)}\" y1=\"{FmtInspect(candidate.Start.Y)}\" x2=\"{FmtInspect(target.X)}\" y2=\"{FmtInspect(target.Y)}\" stroke=\"{stroke}\" stroke-width=\"0.025\"{dash} marker-end=\"url(#{marker})\"/>");

        double lx = (candidate.Start.X + target.X) / 2.0 + 0.03;
        double ly = (candidate.Start.Y + target.Y) / 2.0 + (0.08 * labelIndex);
        string label =
            $"{EscapeXml(candidate.Kind)} {EscapeXml(candidate.Status)}" +
            (string.IsNullOrWhiteSpace(candidate.Reason)
                ? string.Empty
                : $" | {EscapeXml(candidate.Reason!)}");
        builder.AppendLine(
            $"<text x=\"{FmtInspect(lx)}\" y=\"{FmtInspect(ly)}\" font-size=\"0.075\" fill=\"{stroke}\">{label}</text>");
    }

    builder.AppendLine(
        $"<text x=\"{FmtInspect(minX + 0.05)}\" y=\"{FmtInspect(minY + 0.12)}\" font-size=\"0.10\" fill=\"#111\">node {inspectNode} | red=path | orange=compare {compareNode?.ToString() ?? "-"} | green=accepted | dashed red=rejected</text>");
    builder.AppendLine("</svg>");
    return builder.ToString();
}

static InspectPoint ParseInspectPoint(string raw)
{
    Match match = Regex.Match(
        raw,
        @"\((?<x>[-0-9.Ee+]+),(?<y>[-0-9.Ee+]+)\)");
    if (!match.Success)
        throw new FormatException(
            $"Punto log non valido: {raw}");

    return new InspectPoint(
        ParseInvariantDouble(match.Groups["x"].Value),
        ParseInvariantDouble(match.Groups["y"].Value));
}

static double ParseInvariantDouble(string raw) =>
    double.Parse(
        raw,
        NumberStyles.Float,
        CultureInfo.InvariantCulture);

static string FormatInspectPoint(InspectPoint point) =>
    $"({FmtInspect(point.X)},{FmtInspect(point.Y)})";

static string FmtInspect(double value) =>
    value.ToString(
        "0.######",
        CultureInfo.InvariantCulture);

static string EscapeXml(string value) =>
    System.Security.SecurityElement.Escape(value) ?? string.Empty;

static int RunRankedSolutionExplorer(
    string localeXml,
    double stepMeters,
    string caseId,
    string outputDir,
    int skipTop,
    int count)
{
    StrategiaDiegoRankedSolutionExplorerSample explorer =
        StrategiaDiegoBenchmark.ExploreRankedSolutions(
            localeXml,
            stepMeters,
            skipTop,
            count);

    if (explorer.Items.Count == 0)
        throw new InvalidDataException(
            $"Nessuna soluzione disponibile dopo skipTop={skipTop}; terminali={explorer.SupplyTerminals}.");

    string explorerDir = Path.Combine(
        outputDir,
        caseId + ".solution-explorer");
    Directory.CreateDirectory(explorerDir);

    foreach (StrategiaDiegoRankedSolutionExplorerEntry entry in explorer.Items)
    {
        string svgPath = Path.Combine(
            explorerDir,
            $"solution-rank-{entry.SupplyRank:000}.svg");
        File.WriteAllText(
            svgPath,
            entry.Svg,
            new UTF8Encoding(false));
    }

    var manifest = new
    {
        caseId,
        explorer.LocaleId,
        explorer.StepMeters,
        explorer.SupplyNodes,
        explorer.SupplyTerminals,
        explorer.SkipTop,
        requestedCount = count,
        solutions = explorer.Items.Select(entry => new
        {
            supplyRank = entry.SupplyRank,
            supplyTerminalNodeId = entry.SupplyTerminalNodeId,
            supplyActiveLengthMeters = entry.SupplyActiveLengthMeters,
            supplyGoodness = entry.SupplyGoodness,
            supplyTotalLengthMeters = entry.SupplyTotalLengthMeters,
            supplyNodeIds = entry.SupplyNodeIds,
            contains47To48 = ContainsEdge(entry.SupplyNodeIds, 47, 48),
            returnFeasible = entry.ReturnFeasible,
            returnTerminalNodeId = entry.ReturnTerminalNodeId,
            returnActiveLengthMeters = entry.ReturnActiveLengthMeters,
            returnGoodness = entry.ReturnGoodness,
            returnTotalLengthMeters = entry.ReturnTotalLengthMeters,
            closureLengthMeters = entry.ClosureLengthMeters,
            combinedMeritMeters = entry.CombinedMeritMeters,
            returnRootSide = entry.ReturnRootSide,
            returnNodeIds = entry.ReturnNodeIds,
            returnNodesExplored = entry.ReturnNodesExplored,
            combinedTerminals = entry.CombinedTerminals,
            acceptedTerminals = entry.AcceptedTerminals,
            returnError = entry.ReturnError,
            svg = $"solution-rank-{entry.SupplyRank:000}.svg"
        }).ToArray()
    };

    string manifestPath = Path.Combine(explorerDir, "solutions.json");
    File.WriteAllText(
        manifestPath,
        JsonSerializer.Serialize(
            manifest,
            new JsonSerializerOptions { WriteIndented = true }),
        new UTF8Encoding(false));

    string html = BuildRankedSolutionExplorerHtml(
        caseId,
        explorer);
    string htmlPath = Path.Combine(explorerDir, "index.html");
    File.WriteAllText(
        htmlPath,
        html,
        new UTF8Encoding(false));

    Console.WriteLine("RADIANT_HARNESS_SOLUTION_EXPLORER_OK");
    Console.WriteLine($"case={caseId}");
    Console.WriteLine($"supplyNodes={explorer.SupplyNodes}");
    Console.WriteLine($"supplyTerminals={explorer.SupplyTerminals}");
    Console.WriteLine($"skipTop={explorer.SkipTop}");
    Console.WriteLine($"exported={explorer.Items.Count}");
    Console.WriteLine($"manifest={manifestPath}");
    Console.WriteLine($"index={htmlPath}");

    foreach (StrategiaDiegoRankedSolutionExplorerEntry entry in explorer.Items)
    {
        string returnText = entry.ReturnFeasible
            ? $"returnActive={entry.ReturnActiveLengthMeters?.ToString("0.###", CultureInfo.InvariantCulture)} " +
              $"returnGoodness={entry.ReturnGoodness?.ToString("0.###", CultureInfo.InvariantCulture)} " +
              $"returnNode={entry.ReturnTerminalNodeId} " +
              $"returnExplored={entry.ReturnNodesExplored}"
            : $"RETURN_NOT_FEASIBLE error={entry.ReturnError ?? "-"}";

        Console.WriteLine(
            $"SOLUTION_RANK supplyRank={entry.SupplyRank} supplyNode={entry.SupplyTerminalNodeId} " +
            $"supplyActive={entry.SupplyActiveLengthMeters.ToString("0.###", CultureInfo.InvariantCulture)} " +
            $"supplyGoodness={entry.SupplyGoodness.ToString("0.###", CultureInfo.InvariantCulture)} " +
            $"contains47To48={ContainsEdge(entry.SupplyNodeIds, 47, 48)} {returnText}");
    }

    return 0;
}

static string BuildRankedSolutionExplorerHtml(
    string caseId,
    StrategiaDiegoRankedSolutionExplorerSample explorer)
{
    var builder = new StringBuilder();
    builder.AppendLine("<!doctype html><html><head><meta charset=\"utf-8\">");
    builder.AppendLine("<title>StrategiaDiego Solution Explorer</title>");
    builder.AppendLine("<style>body{font-family:Arial,sans-serif;margin:20px}.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(360px,1fr));gap:16px}.card{border:1px solid #bbb;padding:10px;border-radius:8px}.card img{width:100%;height:auto;border:1px solid #ddd}.meta{font-family:monospace;white-space:pre-wrap}.bad{color:#a00;font-weight:bold}</style></head><body>");
    builder.AppendLine($"<h1>{System.Net.WebUtility.HtmlEncode(caseId)} — Supply rank + Best Return</h1>");
    builder.AppendLine($"<p>Supply nodes: {explorer.SupplyNodes} | terminals: {explorer.SupplyTerminals} | p={explorer.StepMeters.ToString("0.###", CultureInfo.InvariantCulture)} m | skipTop={explorer.SkipTop}</p>");
    builder.AppendLine("<div class=\"grid\">");

    foreach (StrategiaDiegoRankedSolutionExplorerEntry entry in explorer.Items)
    {
        string svg = $"solution-rank-{entry.SupplyRank:000}.svg";
        builder.AppendLine("<div class=\"card\">");
        builder.AppendLine($"<h2>Supply rank #{entry.SupplyRank}</h2>");
        builder.AppendLine($"<a href=\"{svg}\"><img src=\"{svg}\" alt=\"rank {entry.SupplyRank}\"></a>");
        builder.AppendLine("<div class=\"meta\">");
        builder.AppendLine($"Supply node={entry.SupplyTerminalNodeId}<br>");
        builder.AppendLine($"Supply active={entry.SupplyActiveLengthMeters.ToString("0.###", CultureInfo.InvariantCulture)} m<br>");
        builder.AppendLine($"Supply goodness={entry.SupplyGoodness.ToString("0.###", CultureInfo.InvariantCulture)}<br>");
        builder.AppendLine($"contains 47→48={ContainsEdge(entry.SupplyNodeIds,47,48)}<br>");

        if (entry.ReturnFeasible)
        {
            builder.AppendLine($"Best Return node={entry.ReturnTerminalNodeId}<br>");
            builder.AppendLine($"Return active={entry.ReturnActiveLengthMeters?.ToString("0.###", CultureInfo.InvariantCulture)} m<br>");
            builder.AppendLine($"Return goodness={entry.ReturnGoodness?.ToString("0.###", CultureInfo.InvariantCulture)}<br>");
            builder.AppendLine($"Closure={entry.ClosureLengthMeters?.ToString("0.###", CultureInfo.InvariantCulture)} m<br>");
            builder.AppendLine($"Combined merit={entry.CombinedMeritMeters?.ToString("0.###", CultureInfo.InvariantCulture)} m<br>");
            builder.AppendLine($"Return explored nodes={entry.ReturnNodesExplored}");
        }
        else
        {
            builder.AppendLine($"<span class=\"bad\">RETURN NON FATTIBILE</span><br>{System.Net.WebUtility.HtmlEncode(entry.ReturnError ?? string.Empty)}");
        }

        builder.AppendLine("</div></div>");
    }

    builder.AppendLine("</div></body></html>");
    return builder.ToString();
}
static int RunSupplyExplorer(
    string localeXml,
    double stepMeters,
    string caseId,
    string outputDir,
    int topCount,
    int? selectedRank,
    int skipTop,
    int exportCount)
{
    StrategiaDiegoSupplyExplorerSample explorer =
        StrategiaDiegoBenchmark.ExploreSupply(
            localeXml,
            stepMeters,
            topCount);

    string explorerDir = Path.Combine(
        outputDir,
        caseId + ".supply-explorer");
    Directory.CreateDirectory(explorerDir);

    IEnumerable<StrategiaDiegoSupplyExplorerEntry> entries =
        selectedRank is null
            ? explorer.Items
                .Skip(skipTop)
                .Take(exportCount)
            : explorer.Items.Where(item => item.Rank == selectedRank.Value);

    StrategiaDiegoSupplyExplorerEntry[] selected = entries.ToArray();
    if (selected.Length == 0)
        throw new InvalidDataException(
            $"Supply rank {selectedRank} non disponibile; terminali={explorer.SupplyTerminals}.");

    foreach (StrategiaDiegoSupplyExplorerEntry entry in selected)
    {
        string svgPath = Path.Combine(
            explorerDir,
            $"supply-rank-{entry.Rank:000}.svg");
        File.WriteAllText(
            svgPath,
            entry.Svg,
            new UTF8Encoding(false));
    }

    var manifest = new
    {
        caseId,
        explorer.LocaleId,
        explorer.StepMeters,
        explorer.SupplyNodes,
        explorer.SupplyTerminals,
        requestedTop = topCount,
        skipTop,
        exportCount,
        selectedRank,
        solutions = selected.Select(entry => new
        {
            entry.Rank,
            entry.TerminalNodeId,
            entry.Depth,
            entry.ActiveLengthMeters,
            entry.Goodness,
            entry.TotalLengthMeters,
            nodeIds = entry.NodeIds,
            contains47To48 = ContainsEdge(entry.NodeIds, 47, 48),
            svg = $"supply-rank-{entry.Rank:000}.svg"
        }).ToArray()
    };

    string manifestPath = Path.Combine(explorerDir, "solutions.json");
    File.WriteAllText(
        manifestPath,
        JsonSerializer.Serialize(
            manifest,
            new JsonSerializerOptions { WriteIndented = true }),
        new UTF8Encoding(false));

    string html = BuildSupplyExplorerHtml(
        caseId,
        explorer,
        selected);
    string htmlPath = Path.Combine(explorerDir, "index.html");
    File.WriteAllText(
        htmlPath,
        html,
        new UTF8Encoding(false));

    Console.WriteLine("RADIANT_HARNESS_SUPPLY_EXPLORER_OK");
    Console.WriteLine($"case={caseId}");
    Console.WriteLine($"supplyNodes={explorer.SupplyNodes}");
    Console.WriteLine($"supplyTerminals={explorer.SupplyTerminals}");
    Console.WriteLine($"skipTop={skipTop}");
    Console.WriteLine($"exported={selected.Length}");
    Console.WriteLine($"manifest={manifestPath}");
    Console.WriteLine($"index={htmlPath}");

    foreach (StrategiaDiegoSupplyExplorerEntry entry in selected)
    {
        Console.WriteLine(
            $"SUPPLY_RANK rank={entry.Rank} node={entry.TerminalNodeId} " +
            $"active={entry.ActiveLengthMeters.ToString("0.###", CultureInfo.InvariantCulture)} " +
            $"goodness={entry.Goodness.ToString("0.###", CultureInfo.InvariantCulture)} " +
            $"total={entry.TotalLengthMeters.ToString("0.###", CultureInfo.InvariantCulture)} " +
            $"contains47To48={ContainsEdge(entry.NodeIds, 47, 48)}");
    }

    return 0;
}

static bool ContainsEdge(
    IReadOnlyList<int> nodeIds,
    int from,
    int to)
{
    for (int i = 0; i < nodeIds.Count - 1; i++)
    {
        if (nodeIds[i] == from && nodeIds[i + 1] == to)
            return true;
    }
    return false;
}

static string BuildSupplyExplorerHtml(
    string caseId,
    StrategiaDiegoSupplyExplorerSample explorer,
    IReadOnlyList<StrategiaDiegoSupplyExplorerEntry> entries)
{
    var builder = new StringBuilder();
    builder.AppendLine("<!doctype html><html><head><meta charset=\"utf-8\">");
    builder.AppendLine("<title>StrategiaDiego Supply Explorer</title>");
    builder.AppendLine("<style>body{font-family:Arial,sans-serif;margin:20px} .grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(320px,1fr));gap:16px}.card{border:1px solid #bbb;padding:10px;border-radius:8px}.card img{width:100%;height:auto;border:1px solid #ddd}.meta{font-family:monospace;white-space:pre-wrap}</style></head><body>");
    builder.AppendLine($"<h1>{System.Net.WebUtility.HtmlEncode(caseId)} — Supply Explorer</h1>");
    builder.AppendLine($"<p>Supply nodes: {explorer.SupplyNodes} | terminals: {explorer.SupplyTerminals} | p={explorer.StepMeters.ToString("0.###", CultureInfo.InvariantCulture)} m</p>");
    builder.AppendLine("<div class=\"grid\">");

    foreach (StrategiaDiegoSupplyExplorerEntry entry in entries)
    {
        string svg = $"supply-rank-{entry.Rank:000}.svg";
        builder.AppendLine("<div class=\"card\">");
        builder.AppendLine($"<h2>Rank #{entry.Rank}</h2>");
        builder.AppendLine($"<a href=\"{svg}\"><img src=\"{svg}\" alt=\"rank {entry.Rank}\"></a>");
        builder.AppendLine("<div class=\"meta\">");
        builder.AppendLine($"terminal={entry.TerminalNodeId}<br>");
        builder.AppendLine($"active={entry.ActiveLengthMeters.ToString("0.###", CultureInfo.InvariantCulture)} m<br>");
        builder.AppendLine($"goodness={entry.Goodness.ToString("0.###", CultureInfo.InvariantCulture)}<br>");
        builder.AppendLine($"total={entry.TotalLengthMeters.ToString("0.###", CultureInfo.InvariantCulture)} m<br>");
        builder.AppendLine($"contains 47→48={ContainsEdge(entry.NodeIds, 47, 48)}");
        builder.AppendLine("</div></div>");
    }

    builder.AppendLine("</div></body></html>");
    return builder.ToString();
}

static int? NonNegativeIntArg(string[] args, string name)
{
    string? raw = Arg(args, name);
    if (raw is null)
        return null;
    if (!int.TryParse(raw, NumberStyles.Integer, CultureInfo.InvariantCulture, out int value) || value < 0)
        throw new ArgumentException($"{name} deve essere un intero >= 0.");
    return value;
}
static int? PositiveIntArg(string[] args, string name)
{
    string? raw = Arg(args, name);
    if (raw is null)
        return null;
    if (!int.TryParse(raw, NumberStyles.Integer, CultureInfo.InvariantCulture, out int value) || value <= 0)
        throw new ArgumentException($"{name} deve essere un intero positivo.");
    return value;
}
static async Task<int> PrepareAsync(string[] args)
{
    try
    {
        string? projectPath = Arg(args, "--project");
        string? outputPath = Arg(args, "--output");
        if (string.IsNullOrWhiteSpace(projectPath) ||
            string.IsNullOrWhiteSpace(outputPath))
        {
            throw new ArgumentException("prepare richiede --project e --output.");
        }

        string fullProjectPath = Path.GetFullPath(projectPath);
        string fullOutputPath = Path.GetFullPath(outputPath);
        string projectText = await File.ReadAllTextAsync(fullProjectPath, Encoding.UTF8);
        projectText = CanonicalizeProjectSvg(projectText);

        Model3DGenerationResult result =
            await new GeneraModello().GeneraAsync(projectText);
        string panelInput = result.RadiantPanelInputXml
            ?? throw new InvalidDataException(
                "Il progetto non ha prodotto input pannelli.");

        Directory.CreateDirectory(Path.GetDirectoryName(fullOutputPath)!);
        await File.WriteAllTextAsync(
            fullOutputPath,
            panelInput,
            new UTF8Encoding(false));

        Console.WriteLine("RADIANT_HARNESS_PREPARE_OK");
        Console.WriteLine($"project={fullProjectPath}");
        Console.WriteLine($"output={fullOutputPath}");
        Console.WriteLine($"bytes={Encoding.UTF8.GetByteCount(panelInput)}");
        Console.WriteLine($"sha256={Sha256(panelInput)}");
        return 0;
    }
    catch (Exception ex)
    {
        Console.Error.WriteLine("RADIANT_HARNESS_PREPARE_FAILED");
        Console.Error.WriteLine(ex);
        return 3;
    }
}

static string? Arg(string[] args, string name)
{
    for (int i = 0; i < args.Length - 1; i++)
    {
        if (args[i].Equals(name, StringComparison.OrdinalIgnoreCase))
            return args[i + 1];
    }
    return null;
}

static string SanitizeFileName(string value)
{
    foreach (char invalid in Path.GetInvalidFileNameChars())
        value = value.Replace(invalid, '_');
    return value;
}

static string Sha256(string text)
{
    byte[] bytes = Encoding.UTF8.GetBytes(text);
    return Convert.ToHexString(SHA256.HashData(bytes)).ToLowerInvariant();
}

static string CanonicalizeProjectSvg(string projectText)
{
    ProjectTextDocument project = ProjectTextDocument.Parse(projectText);
    string sourceSvg = project.GetRequiredSection("geometry/project.svg");
    XDocument source = XDocument.Parse(sourceSvg, LoadOptions.PreserveWhitespace);
    XNamespace svgNs = "http://www.w3.org/2000/svg";
    XElement sourceRoot = source.Root
        ?? throw new InvalidDataException("geometry/project.svg privo di radice.");

    bool alreadyCanonical =
        string.Equals((string?)sourceRoot.Attribute("data-termodel-units"), "cm", StringComparison.OrdinalIgnoreCase) &&
        sourceRoot.Elements(svgNs + "g").Any(g => g.Attribute("data-termodel-floor-id") is not null);
    if (alreadyCanonical)
        return projectText;

    JsonNode manifestNode = JsonNode.Parse(project.GetRequiredSection("manifest.json"))
        ?? throw new InvalidDataException("manifest.json non valido.");
    JsonObject manifest = manifestNode.AsObject();
    JsonArray floors = manifest["floors"]?.AsArray()
        ?? throw new InvalidDataException("manifest.json privo di floors.");

    XElement[] legacyGroups = sourceRoot
        .Elements(svgNs + "g")
        .Where(g =>
        {
            string id = ((string?)g.Attribute("id") ?? string.Empty).Trim();
            return id.Equals("calpestabile", StringComparison.OrdinalIgnoreCase) ||
                   id.Equals("copertura", StringComparison.OrdinalIgnoreCase);
        })
        .ToArray();

    var outputRoot = new XElement(
        svgNs + "svg",
        new XAttribute("version", "1.1"),
        new XAttribute("data-termodel-format", "TERMODEL-PROJECT-SVG-V1"),
        new XAttribute("data-termodel-units", "cm"));

    foreach (JsonObject floor in floors
                 .OfType<JsonObject>()
                 .OrderBy(f => f["order"]?.GetValue<int>() ?? 0))
    {
        string id = floor["id"]?.GetValue<string>() ?? throw new InvalidDataException("floor.id mancante.");
        string name = floor["name"]?.GetValue<string>() ?? throw new InvalidDataException("floor.name mancante.");
        string type = floor["type"]?.GetValue<string>() ?? "Calpestabile";
        string fileName = floor["fileName"]?.GetValue<string>() ?? "DisegnoInput";
        string layer = floor["cadLayer"]?.GetValue<string>() ?? name;
        int order = floor["order"]?.GetValue<int>() ?? 0;
        string role = type.Equals("Copertura", StringComparison.OrdinalIgnoreCase)
            ? "copertura"
            : "calpestabile";

        var group = new XElement(
            svgNs + "g",
            new XAttribute("id", "floor-" + Regex.Replace(id, "[^A-Za-z0-9_-]+", "_")),
            new XAttribute("data-termodel-floor-id", id),
            new XAttribute("data-termodel-name", name),
            new XAttribute("data-termodel-role", role),
            new XAttribute("data-termodel-file", fileName),
            new XAttribute("data-termodel-layer", layer),
            new XAttribute("data-termodel-order", order.ToString(CultureInfo.InvariantCulture)));

        foreach (XElement legacyGroup in legacyGroups)
        {
            foreach (XElement node in legacyGroup.Elements())
            {
                if (node.Name != svgNs + "line" && node.Name != svgNs + "text")
                    continue;

                string plane = ((string?)node.Attribute("data-termodel-piano") ?? string.Empty).Trim();
                if (plane.Length > 0 &&
                    !plane.Equals(name, StringComparison.OrdinalIgnoreCase) &&
                    !plane.Equals(id, StringComparison.OrdinalIgnoreCase))
                {
                    continue;
                }

                if (node.Name == svgNs + "text")
                {
                    string firstRow = node.Elements(svgNs + "tspan").FirstOrDefault()?.Value ?? string.Empty;
                    if (!Regex.IsMatch(firstRow, "^\\s*BLOCCO\\s*,", RegexOptions.IgnoreCase))
                        continue;
                }

                var clone = new XElement(node);
                if (clone.Attribute("data-termodel-layer") is null ||
                    string.IsNullOrWhiteSpace((string?)clone.Attribute("data-termodel-layer")))
                {
                    clone.SetAttributeValue("data-termodel-layer", layer);
                }

                if (clone.Name == svgNs + "line")
                {
                    if (string.IsNullOrWhiteSpace((string?)clone.Attribute("data-termodel-linetype")))
                    {
                        string localType = ((string?)clone.Attribute("data-termodel-tipo-linea") ?? string.Empty).Trim();
                        if (localType.Length > 0)
                            clone.SetAttributeValue("data-termodel-linetype", localType);
                    }

                    if (string.IsNullOrWhiteSpace((string?)clone.Attribute("data-termodel-color")))
                    {
                        string localColor = ((string?)clone.Attribute("data-termodel-colore") ?? string.Empty).Trim();
                        Match match = Regex.Match(localColor, "^\\s*(\\d+)");
                        if (match.Success)
                            clone.SetAttributeValue("data-termodel-color", match.Groups[1].Value);
                    }
                }

                group.Add(clone);
            }
        }

        outputRoot.Add(group);
    }

    string canonicalSvg = new XDocument(
        new XDeclaration("1.0", "utf-8", null),
        outputRoot).ToString(SaveOptions.DisableFormatting);

    if (manifest["geometry"] is JsonObject geometry)
        geometry["units"] = "cm";

    if (manifest["sections"] is JsonArray sections)
    {
        foreach (JsonObject section in sections.OfType<JsonObject>())
        {
            if (string.Equals(
                    section["name"]?.GetValue<string>(),
                    "geometry/project.svg",
                    StringComparison.Ordinal))
            {
                section["sha256"] = Sha256(canonicalSvg);
            }
        }
    }

    string manifestText = manifest.ToJsonString(
        new JsonSerializerOptions { WriteIndented = true });
    string updated = ReplaceProjectSection(projectText, "geometry/project.svg", canonicalSvg);
    updated = ReplaceProjectSection(updated, "manifest.json", manifestText);
    return updated;
}

static string ReplaceProjectSection(string projectText, string name, string content)
{
    string escaped = Regex.Escape(name);
    var pattern = new Regex(
        $"---BEGIN:{escaped}---\\s*\\n[\\s\\S]*?\\n---END:{escaped}---",
        RegexOptions.CultureInvariant);
    string replacement = $"---BEGIN:{name}---\n{content.TrimEnd()}\n---END:{name}---";
    if (!pattern.IsMatch(projectText))
        throw new InvalidDataException($"Sezione progetto '{name}' non trovata.");
    return pattern.Replace(projectText, _ => replacement, 1);
}


internal sealed record BranchEdge(
    int? ParentNodeId,
    int ChildNodeId,
    string Choice,
    InspectPoint A,
    InspectPoint B);

internal sealed class BranchCandidate
{
    public BranchCandidate(
        string kind,
        string status,
        InspectPoint start,
        InspectPoint? target,
        InspectPoint? intersection,
        string? reference,
        string? referenceFamily,
        string? referenceType,
        double? respectMeters,
        string? reason)
    {
        Kind = kind;
        Status = status;
        Start = start;
        Target = target;
        Intersection = intersection;
        Reference = reference;
        ReferenceFamily = referenceFamily;
        ReferenceType = referenceType;
        RespectMeters = respectMeters;
        Reason = reason;
    }

    public string Kind { get; }
    public string Status { get; set; }
    public InspectPoint Start { get; }
    public InspectPoint? Target { get; }
    public InspectPoint? Intersection { get; }
    public string? Reference { get; }
    public string? ReferenceFamily { get; }
    public string? ReferenceType { get; }
    public double? RespectMeters { get; }
    public string? Reason { get; set; }
}

internal readonly record struct InspectPoint(
    double X,
    double Y);

internal sealed class HarnessCase
{
    public string Id { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string PreparedInput { get; set; } = string.Empty;
    public double StepMeters { get; set; } = 0.30;
}
