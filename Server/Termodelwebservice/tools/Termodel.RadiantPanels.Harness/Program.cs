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

internal sealed class HarnessCase
{
    public string Id { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public string PreparedInput { get; set; } = string.Empty;
    public double StepMeters { get; set; } = 0.30;
}
