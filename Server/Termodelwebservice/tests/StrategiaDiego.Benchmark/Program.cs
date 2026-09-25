using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using Termodel.Core.RadiantPanels;

if (args.Length < 1)
{
    Console.Error.WriteLine(
        "Uso: StrategiaDiego.Benchmark <fixture.locale.xml> [outputDir] [iterations]");
    return 64;
}

string fixturePath = Path.GetFullPath(args[0]);
string outputDir = args.Length >= 2
    ? Path.GetFullPath(args[1])
    : Path.Combine(Path.GetDirectoryName(fixturePath)!, "StrategiaDiegoBenchmark");
int iterations = args.Length >= 3 &&
                 int.TryParse(args[2], NumberStyles.Integer, CultureInfo.InvariantCulture, out int parsedIterations) &&
                 parsedIterations > 0
    ? parsedIterations
    : 20;

int nodeBudget = ReadPositiveInt("TERMODEL_DIEGO_BENCH_NODE_BUDGET", 50_000);
long p95BudgetMs = ReadPositiveLong("TERMODEL_DIEGO_BENCH_P95_MS", 2_000);
long memoryBudgetBytes = ReadPositiveLong(
    "TERMODEL_DIEGO_BENCH_MEMORY_BYTES",
    128L * 1024 * 1024);

Directory.CreateDirectory(outputDir);
string reportPath = Path.Combine(outputDir, "strategia-diego-benchmark.json");
string svgPath = Path.Combine(outputDir, "strategia-diego-square4x4.svg");

var report = new BenchmarkReport
{
    Fixture = fixturePath,
    IterationsRequested = iterations,
    NodeBudget = nodeBudget,
    P95BudgetMs = p95BudgetMs,
    MemoryBudgetBytes = memoryBudgetBytes
};

try
{
    string fixture = File.ReadAllText(fixturePath, Encoding.UTF8);

    // Warm-up JIT: escluso dalle statistiche.
    StrategiaDiegoBenchmarkSample warmup =
        StrategiaDiegoBenchmark.Run(fixture);
    report.Warmup = ToIteration(0, warmup);

    string? expectedSignature = null;
    string? expectedSvgHash = null;

    for (int i = 1; i <= iterations; i++)
    {
        StrategiaDiegoBenchmarkSample sample =
            StrategiaDiegoBenchmark.Run(fixture);

        BenchmarkIteration iteration = ToIteration(i, sample);
        report.Iterations.Add(iteration);

        string signature = StructuralSignature(sample);
        string svgHash = Sha256(sample.Svg);

        expectedSignature ??= signature;
        expectedSvgHash ??= svgHash;

        if (!string.Equals(
                signature,
                expectedSignature,
                StringComparison.Ordinal))
        {
            report.Errors.Add(
                $"Iterazione {i}: struttura albero non deterministica.");
        }

        if (!string.Equals(
                svgHash,
                expectedSvgHash,
                StringComparison.Ordinal))
        {
            report.Errors.Add(
                $"Iterazione {i}: output SVG non deterministico.");
        }

        if (i == 1)
        {
            File.WriteAllText(
                svgPath,
                sample.Svg,
                new UTF8Encoding(false));
            report.SvgSha256 = svgHash;
            report.Diagnostics = sample.Diagnostics.ToList();
        }
    }

    long[] elapsed = report.Iterations
        .Select(item => item.ElapsedMilliseconds)
        .Order()
        .ToArray();

    report.IterationsCompleted = report.Iterations.Count;
    report.MinElapsedMs = elapsed.FirstOrDefault();
    report.MedianElapsedMs = Percentile(elapsed, 0.50);
    report.P95ElapsedMs = Percentile(elapsed, 0.95);
    report.MaxElapsedMs = elapsed.LastOrDefault();
    report.MaxMemoryDeltaBytes = report.Iterations.Count == 0
        ? 0
        : report.Iterations.Max(item => item.MemoryDeltaBytes);
    report.MaxTotalNodes = report.Iterations.Count == 0
        ? 0
        : report.Iterations.Max(item => item.TotalNodes);
    report.AcceptedTerminals = report.Iterations.Count == 0
        ? 0
        : report.Iterations.Min(item => item.AcceptedTerminals);

    report.Deterministic = report.Errors.Count == 0;
    report.WithinNodeBudget =
        report.MaxTotalNodes <= nodeBudget;
    report.WithinTimeBudget =
        report.P95ElapsedMs <= p95BudgetMs;
    report.WithinMemoryBudget =
        report.MaxMemoryDeltaBytes <= memoryBudgetBytes;
    report.HasAcceptedTerminal =
        report.AcceptedTerminals > 0;

    report.Sustainable =
        report.Deterministic &&
        report.WithinNodeBudget &&
        report.WithinTimeBudget &&
        report.WithinMemoryBudget &&
        report.HasAcceptedTerminal &&
        report.IterationsCompleted == iterations;

    report.Status = report.Sustainable ? "sustainable" : "not-sustainable";

    if (!report.WithinNodeBudget)
        report.Errors.Add(
            $"Nodi {report.MaxTotalNodes} oltre budget {nodeBudget}.");
    if (!report.WithinTimeBudget)
        report.Errors.Add(
            $"P95 {report.P95ElapsedMs} ms oltre budget {p95BudgetMs} ms.");
    if (!report.WithinMemoryBudget)
        report.Errors.Add(
            $"Memoria delta {report.MaxMemoryDeltaBytes} oltre budget {memoryBudgetBytes}.");
    if (!report.HasAcceptedTerminal)
        report.Errors.Add("Nessun terminale preliminarmente accettabile.");

    WriteReport(reportPath, report);

    Console.WriteLine("STRATEGIADIEGO_BENCHMARK_COMPLETED");
    Console.WriteLine($"status={report.Status}");
    Console.WriteLine($"iterations={report.IterationsCompleted}");
    Console.WriteLine($"nodes={report.MaxTotalNodes}");
    Console.WriteLine($"p95Ms={report.P95ElapsedMs}");
    Console.WriteLine($"maxMemoryDeltaBytes={report.MaxMemoryDeltaBytes}");
    Console.WriteLine($"acceptedTerminals={report.AcceptedTerminals}");
    Console.WriteLine($"svgSha256={report.SvgSha256}");

    return report.Sustainable ? 0 : 2;
}
catch (Exception exception)
{
    report.Status = "failed";
    report.Sustainable = false;
    report.Errors.Add(exception.ToString());
    WriteReport(reportPath, report);

    Console.Error.WriteLine("STRATEGIADIEGO_BENCHMARK_FAILED");
    Console.Error.WriteLine(exception);
    return 3;
}

static BenchmarkIteration ToIteration(
    int index,
    StrategiaDiegoBenchmarkSample sample) =>
    new()
    {
        Index = index,
        SupplyNodes = sample.SupplyNodes,
        SupplyTerminals = sample.SupplyTerminals,
        ReturnNodes = sample.ReturnNodes,
        CombinedTerminals = sample.CombinedTerminals,
        AcceptedTerminals = sample.AcceptedTerminals,
        MaxDepth = sample.MaxDepth,
        TotalNodes = sample.TotalNodes,
        ElapsedMilliseconds = sample.ElapsedMilliseconds,
        MemoryDeltaBytes = sample.MemoryDeltaBytes
    };

static string StructuralSignature(
    StrategiaDiegoBenchmarkSample sample) =>
    string.Join(
        "|",
        sample.SupplyNodes,
        sample.SupplyTerminals,
        sample.ReturnNodes,
        sample.CombinedTerminals,
        sample.AcceptedTerminals,
        sample.MaxDepth,
        sample.TotalNodes);

static string Sha256(string text)
{
    byte[] bytes = Encoding.UTF8.GetBytes(text);
    return Convert.ToHexString(SHA256.HashData(bytes))
        .ToLowerInvariant();
}

static long Percentile(
    IReadOnlyList<long> sorted,
    double percentile)
{
    if (sorted.Count == 0)
        return 0;

    int index = (int)Math.Ceiling(percentile * sorted.Count) - 1;
    index = Math.Clamp(index, 0, sorted.Count - 1);
    return sorted[index];
}

static int ReadPositiveInt(
    string name,
    int fallback) =>
    int.TryParse(
        Environment.GetEnvironmentVariable(name),
        NumberStyles.Integer,
        CultureInfo.InvariantCulture,
        out int value) &&
    value > 0
        ? value
        : fallback;

static long ReadPositiveLong(
    string name,
    long fallback) =>
    long.TryParse(
        Environment.GetEnvironmentVariable(name),
        NumberStyles.Integer,
        CultureInfo.InvariantCulture,
        out long value) &&
    value > 0
        ? value
        : fallback;

static void WriteReport(
    string path,
    BenchmarkReport report)
{
    string json = JsonSerializer.Serialize(
        report,
        new JsonSerializerOptions
        {
            WriteIndented = true
        });
    File.WriteAllText(
        path,
        json,
        new UTF8Encoding(false));
}

internal sealed class BenchmarkReport
{
    public string Status { get; set; } = "running";
    public bool Sustainable { get; set; }
    public string Fixture { get; set; } = string.Empty;
    public int IterationsRequested { get; set; }
    public int IterationsCompleted { get; set; }
    public int NodeBudget { get; set; }
    public long P95BudgetMs { get; set; }
    public long MemoryBudgetBytes { get; set; }
    public bool Deterministic { get; set; }
    public bool WithinNodeBudget { get; set; }
    public bool WithinTimeBudget { get; set; }
    public bool WithinMemoryBudget { get; set; }
    public bool HasAcceptedTerminal { get; set; }
    public int AcceptedTerminals { get; set; }
    public int MaxTotalNodes { get; set; }
    public long MinElapsedMs { get; set; }
    public long MedianElapsedMs { get; set; }
    public long P95ElapsedMs { get; set; }
    public long MaxElapsedMs { get; set; }
    public long MaxMemoryDeltaBytes { get; set; }
    public string? SvgSha256 { get; set; }
    public BenchmarkIteration? Warmup { get; set; }
    public List<BenchmarkIteration> Iterations { get; } = [];
    public List<string> Diagnostics { get; set; } = [];
    public List<string> Errors { get; } = [];
}

internal sealed class BenchmarkIteration
{
    public int Index { get; set; }
    public int SupplyNodes { get; set; }
    public int SupplyTerminals { get; set; }
    public int ReturnNodes { get; set; }
    public int CombinedTerminals { get; set; }
    public int AcceptedTerminals { get; set; }
    public int MaxDepth { get; set; }
    public int TotalNodes { get; set; }
    public long ElapsedMilliseconds { get; set; }
    public long MemoryDeltaBytes { get; set; }
}
