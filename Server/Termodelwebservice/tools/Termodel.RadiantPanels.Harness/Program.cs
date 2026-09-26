using System.Globalization;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using Termodel.Core.RadiantPanels;
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
    Console.Error.WriteLine("  run --case <case.json> [--out <dir>]");
    Console.Error.WriteLine("  run --input <locale.xml> [--id <case-id>] [--p <metri>] [--out <dir>]");
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
        StrategiaDiegoBenchmarkSample sample =
            StrategiaDiegoBenchmark.Run(localeXml, stepMeters);

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

internal sealed class HarnessCase
{
    public string Id { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string PreparedInput { get; set; } = string.Empty;
    public double StepMeters { get; set; } = 0.30;
}
