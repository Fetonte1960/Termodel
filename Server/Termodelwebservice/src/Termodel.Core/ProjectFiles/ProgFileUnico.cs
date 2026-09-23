using System.Collections.ObjectModel;
using System.Globalization;
using System.Runtime.Serialization;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using System.Xml;
using System.Xml.Linq;

namespace Termodel.Core.ProjectFiles;

public static class ProgFileUnico
{
    private const string StartMarker = "[TERMODEL-PROJECT-TEXT-V1]";
    private const string EndMarker = "[END-TERMODEL-PROJECT-TEXT-V1]";
    private static readonly XNamespace SvgNamespace = "http://www.w3.org/2000/svg";
    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web)
    {
        WriteIndented = true
    };

    // Funzione realizzata da Codex in autonomia
    public static NuovoProgettoResult CreaNuovoProgetto(
        NuovoProgettoRequest request,
        string definitionPath,
        string baseProjectPath)
    {
        ArgumentNullException.ThrowIfNull(request);

        DatabaseDefinition definition = DatabaseDefinition.Load(definitionPath);
        var errors = new List<string>();
        var diagnostics = new List<string>();
        List<PianoProgettoRequest> floors = NormalizeAndValidateFloors(request, errors);

        Dictionary<string, List<Dictionary<string, object?>>> archives =
            CreateArchives(request, floors, definition, baseProjectPath, errors, diagnostics);
        Dictionary<string, List<Dictionary<string, object?>>> extendedArchives =
            LoadExtendedTemplateArchives(baseProjectPath, errors);

        string svg = CreateMultiFloorSvg(floors, errors);

        if (errors.Count > 0)
            throw new ProgFileUnicoValidationException(errors);

        string extendedDefinitionPath = Path.Combine(
            Path.GetDirectoryName(definitionPath) ?? string.Empty,
            "pannelli-tubazioni-definizionedati.json");

        var sections = new List<ProjectSection>
        {
            CreateSection("definition/definizionedati.json", "application/json", definition.RawText),
            CreateSection(
                "definition/pannelli-tubazioni-definizionedati.json",
                "application/json",
                ReadRequiredText(extendedDefinitionPath)),
            CreateSection("geometry/project.svg", "image/svg+xml", svg),
            CreateSection(
                "project/DisegnoInput.dxf",
                "application/dxf",
                ReadRequiredTemplateText(baseProjectPath, "DisegnoInput.dxf")),
            CreateSection(
                "thermal/input.xml",
                "application/xml",
                ReadRequiredTemplateText(baseProjectPath, "thermal", "input.xml")),
            CreateSection(
                "thermal/input.json",
                "application/json",
                ReadRequiredTemplateText(baseProjectPath, "thermal", "input.json"))
        };

        foreach ((string archiveName, List<Dictionary<string, object?>> rows) in archives)
        {
            AddArchiveSections(sections, archiveName, rows);
        }

        foreach ((string archiveName, List<Dictionary<string, object?>> rows) in extendedArchives)
        {
            if (archives.ContainsKey(archiveName))
                throw new InvalidDataException($"Archivio esteso duplicato: {archiveName}.");
            AddArchiveSections(sections, archiveName, rows);
        }

        diagnostics.Add(
            "Il progetto include gli archivi estesi TipologiePannelli, Tubazioni e Fluidi per il completamento del calcolo pannelli radianti.");

        var manifest = new
        {
            format = "TERMODEL-PROJECT-TEXT-V1",
            formatVersion = 1,
            projectName = request.NomeProgetto.Trim(),
            generatedAtUtc = DateTimeOffset.UtcNow,
            databaseDefinition = new
            {
                path = "definition/definizionedati.json",
                sha256 = definition.Sha256
            },
            geometry = new
            {
                path = "geometry/project.svg",
                units = "cm",
                floorCount = floors.Count
            },
            baseProject = new
            {
                template = "ProgettoBase",
                dxfPath = "project/DisegnoInput.dxf",
                thermalXmlPath = "thermal/input.xml",
                thermalJsonPath = "thermal/input.json"
            },
            floors = floors.Select((floor, index) => new
            {
                order = index,
                id = floor.Id,
                name = floor.Nome,
                type = floor.Tipo,
                fileName = floor.NomeFile,
                cadLayer = floor.LayerCad,
                netHeightMeters = floor.AltezzaNetta,
                grossHeightMeters = floor.AltezzaLorda,
                repetitions = floor.PianiUguali
            }),
            sections = sections.Select(section => new
            {
                section.Name,
                section.ContentType,
                section.Sha256
            }),
            diagnostics
        };

        string manifestText = JsonSerializer.Serialize(manifest, JsonOptions);
        sections.Insert(0, CreateSection("manifest.json", "application/json", manifestText));

        return new NuovoProgettoResult(
            BuildContainer(sections),
            definition.Sha256,
            diagnostics);
    }

    // Funzione realizzata da Codex in autonomia
    private static List<PianoProgettoRequest> NormalizeAndValidateFloors(
        NuovoProgettoRequest request,
        ICollection<string> errors)
    {
        if (string.IsNullOrWhiteSpace(request.NomeProgetto))
            errors.Add("NomeProgetto è obbligatorio.");

        List<PianoProgettoRequest> floors = request.Piani?.ToList() ?? [];
        if (floors.Count == 0)
            floors.Add(new PianoProgettoRequest());

        var ids = new HashSet<string>(StringComparer.OrdinalIgnoreCase);
        for (int index = 0; index < floors.Count; index++)
        {
            PianoProgettoRequest floor = floors[index];
            string prefix = $"Piani[{index}]";

            if (string.IsNullOrWhiteSpace(floor.Id))
                errors.Add($"{prefix}.Id è obbligatorio.");
            else if (!ids.Add(floor.Id.Trim()))
                errors.Add($"{prefix}.Id '{floor.Id}' è duplicato.");

            if (string.IsNullOrWhiteSpace(floor.Nome))
                errors.Add($"{prefix}.Nome è obbligatorio.");
            if (!string.Equals(floor.Tipo, "Calpestabile", StringComparison.OrdinalIgnoreCase) &&
                !string.Equals(floor.Tipo, "Copertura", StringComparison.OrdinalIgnoreCase))
                errors.Add($"{prefix}.Tipo deve essere 'Calpestabile' oppure 'Copertura'.");
            if (string.IsNullOrWhiteSpace(floor.NomeFile))
                errors.Add($"{prefix}.NomeFile è obbligatorio.");
            if (string.IsNullOrWhiteSpace(floor.LayerCad))
                errors.Add($"{prefix}.LayerCad è obbligatorio.");
            if (floor.AltezzaNetta <= 0)
                errors.Add($"{prefix}.AltezzaNetta deve essere maggiore di zero.");
            if (floor.AltezzaLorda <= floor.AltezzaNetta)
                errors.Add($"{prefix}.AltezzaLorda deve essere maggiore di AltezzaNetta.");
            if (floor.PianiUguali < 1)
                errors.Add($"{prefix}.PianiUguali deve essere almeno 1.");
        }

        return floors;
    }

    // Funzione realizzata da Codex in autonomia
    private static Dictionary<string, List<Dictionary<string, object?>>> CreateArchives(
        NuovoProgettoRequest request,
        IReadOnlyList<PianoProgettoRequest> floors,
        DatabaseDefinition definition,
        string baseProjectPath,
        ICollection<string> errors,
        ICollection<string> diagnostics)
    {
        Dictionary<string, List<Dictionary<string, object?>>> archives =
            LoadTemplateArchives(baseProjectPath, definition, errors);
        Dictionary<string, List<Dictionary<string, JsonElement>>> suppliedArchives =
            request.Archivi ?? new Dictionary<string, List<Dictionary<string, JsonElement>>>(StringComparer.OrdinalIgnoreCase);

        foreach (string suppliedName in suppliedArchives.Keys)
        {
            if (!definition.ArchiveNames.Contains(suppliedName, StringComparer.Ordinal))
                errors.Add($"Archivio sconosciuto: {suppliedName}.");
            if (string.Equals(suppliedName, "Piani", StringComparison.Ordinal))
                errors.Add("L'archivio Piani viene generato dalla proprietà Piani e non può essere fornito separatamente.");
        }

        foreach (string archiveName in definition.ArchiveNames)
        {
            if (string.Equals(archiveName, "Piani", StringComparison.Ordinal))
            {
                archives[archiveName] = floors.Select(floor => CreateFloorRow(definition, floor)).ToList();
                continue;
            }

            if (suppliedArchives.TryGetValue(archiveName, out List<Dictionary<string, JsonElement>>? suppliedRows))
            {
                archives[archiveName] = suppliedRows
                    .Select(row => definition.ValidateAndCompleteRow(archiveName, row, errors))
                    .ToList();
                continue;
            }

        }

        diagnostics.Add("Gli archivi iniziali sono clonati dal progetto base realmente proposto da Termodel desktop.");
        diagnostics.Add("L'archivio Piani è rigenerato dalla richiesta; gli eventuali archivi forniti sostituiscono quelli omonimi del progetto base.");
        return archives;
    }

    // Funzione realizzata da Codex in autonomia
    private static Dictionary<string, List<Dictionary<string, object?>>> LoadTemplateArchives(
        string baseProjectPath,
        DatabaseDefinition definition,
        ICollection<string> errors)
    {
        var archives = new Dictionary<string, List<Dictionary<string, object?>>>(StringComparer.Ordinal);
        foreach (string archiveName in definition.ArchiveNames)
        {
            string path = Path.Combine(baseProjectPath, "dbtempfiles", $"{archiveName}.xml");
            if (!File.Exists(path))
            {
                errors.Add($"Il progetto base non contiene l'archivio obbligatorio '{archiveName}.xml'.");
                archives[archiveName] = [];
                continue;
            }

            try
            {
                var serializer = new DataContractSerializer(
                    typeof(ObservableCollection<Dictionary<string, object?>>));
                using XmlReader reader = XmlReader.Create(path);
                var collection = serializer.ReadObject(reader)
                    as ObservableCollection<Dictionary<string, object?>>;
                archives[archiveName] = collection?.ToList() ?? [];
            }
            catch (Exception exception) when (exception is SerializationException or XmlException)
            {
                errors.Add($"Archivio base '{archiveName}.xml' non valido: {exception.Message}");
                archives[archiveName] = [];
            }
        }

        return archives;
    }

    private static Dictionary<string, List<Dictionary<string, object?>>> LoadExtendedTemplateArchives(
        string baseProjectPath,
        ICollection<string> errors)
    {
        string directory = Path.Combine(baseProjectPath, "extended-archives");
        string[] requiredArchives = ["TipologiePannelli", "Tubazioni", "Fluidi"];
        var result = new Dictionary<string, List<Dictionary<string, object?>>>(StringComparer.Ordinal);

        foreach (string archiveName in requiredArchives)
        {
            string path = Path.Combine(directory, $"{archiveName}.json");
            if (!File.Exists(path))
            {
                errors.Add($"Il progetto base non contiene l'archivio esteso obbligatorio '{archiveName}.json'.");
                result[archiveName] = [];
                continue;
            }

            try
            {
                using JsonDocument document = JsonDocument.Parse(
                    File.ReadAllText(path, Encoding.UTF8));
                if (document.RootElement.ValueKind != JsonValueKind.Array)
                    throw new JsonException("La radice deve essere un array di record.");

                result[archiveName] = document.RootElement
                    .EnumerateArray()
                    .Select(element => ConvertJsonRecord(element, archiveName))
                    .ToList();
            }
            catch (JsonException exception)
            {
                errors.Add($"Archivio esteso '{archiveName}.json' non valido: {exception.Message}");
                result[archiveName] = [];
            }
        }

        return result;
    }

    private static Dictionary<string, object?> ConvertJsonRecord(
        JsonElement element,
        string archiveName)
    {
        if (element.ValueKind != JsonValueKind.Object)
            throw new JsonException($"L'archivio '{archiveName}' contiene una riga che non è un oggetto.");

        var row = new Dictionary<string, object?>(StringComparer.Ordinal);
        foreach (JsonProperty property in element.EnumerateObject())
        {
            row[property.Name] = property.Value.ValueKind switch
            {
                JsonValueKind.String => property.Value.GetString(),
                JsonValueKind.Number when property.Value.TryGetInt32(out int integer) => integer,
                JsonValueKind.Number => property.Value.GetDouble(),
                JsonValueKind.True => true,
                JsonValueKind.False => false,
                JsonValueKind.Null => null,
                _ => throw new JsonException(
                    $"Campo '{property.Name}' dell'archivio '{archiveName}' usa un tipo JSON non supportato.")
            };
        }

        return row;
    }

    private static void AddArchiveSections(
        ICollection<ProjectSection> sections,
        string archiveName,
        List<Dictionary<string, object?>> rows)
    {
        sections.Add(CreateSection(
            $"archives/xml/{archiveName}.xml",
            "application/xml",
            SerializeArchiveXml(rows)));
        sections.Add(CreateSection(
            $"archives/json/{archiveName}.json",
            "application/json",
            JsonSerializer.Serialize(rows, JsonOptions)));
    }

    private static string ReadRequiredText(string path)
    {
        if (!File.Exists(path))
            throw new FileNotFoundException("Definizione estesa pannelli/tubazioni non disponibile.", path);
        return File.ReadAllText(path, Encoding.UTF8);
    }

    // Funzione realizzata da Codex in autonomia
    private static string ReadRequiredTemplateText(string baseProjectPath, params string[] relativeParts)
    {
        string path = relativeParts.Aggregate(baseProjectPath, Path.Combine);
        if (!File.Exists(path))
            throw new FileNotFoundException("Il progetto base incorporato non è completo.", path);
        return File.ReadAllText(path, Encoding.UTF8);
    }

    // Funzione realizzata da Codex in autonomia
    private static Dictionary<string, object?> CreateFloorRow(
        DatabaseDefinition definition,
        PianoProgettoRequest floor)
    {
        Dictionary<string, object?> row = definition.CreateInitializedRow("Piani");
        row["Attivo"] = "Attivo";
        row["Nome"] = floor.Nome;
        row["Tipo"] = NormalizeFloorType(floor.Tipo);
        row["NomeFile"] = floor.NomeFile;
        row["LayerCad"] = floor.LayerCad;
        row["AltezzaNetta"] = floor.AltezzaNetta;
        row["AltezzaLorda"] = floor.AltezzaLorda;
        row["PianiUguali"] = floor.PianiUguali;
        if (!string.IsNullOrWhiteSpace(floor.TipoFinestre))
            row["TipoFinestre"] = floor.TipoFinestre;
        return row;
    }

    // Funzione realizzata da Codex in autonomia
    private static string CreateMultiFloorSvg(
        IReadOnlyList<PianoProgettoRequest> floors,
        ICollection<string> errors)
    {
        var root = new XElement(
            SvgNamespace + "svg",
            new XAttribute("version", "1.1"),
            new XAttribute("data-termodel-format", "TERMODEL-PROJECT-SVG-V1"),
            new XAttribute("data-termodel-units", "cm"));

        foreach ((PianoProgettoRequest floor, int index) in floors.Select((floor, index) => (floor, index)))
        {
            string role = NormalizeFloorType(floor.Tipo).ToLowerInvariant();
            var group = new XElement(
                SvgNamespace + "g",
                new XAttribute("id", $"floor-{SanitizeId(floor.Id)}"),
                new XAttribute("data-termodel-floor-id", floor.Id.Trim()),
                new XAttribute("data-termodel-name", floor.Nome.Trim()),
                new XAttribute("data-termodel-role", role),
                new XAttribute("data-termodel-file", floor.NomeFile.Trim()),
                new XAttribute("data-termodel-layer", floor.LayerCad.Trim()),
                new XAttribute("data-termodel-order", index));

            if (!string.IsNullOrWhiteSpace(floor.Svg))
            {
                foreach (XElement element in ExtractImportableElements(floor.Svg, role, floor.Id, errors))
                    group.Add(element);
            }

            root.Add(group);
        }

        return new XDocument(new XDeclaration("1.0", "utf-8", null), root)
            .ToString(SaveOptions.DisableFormatting);
    }

    // Funzione realizzata da Codex in autonomia
    private static IEnumerable<XElement> ExtractImportableElements(
        string svgText,
        string role,
        string floorId,
        ICollection<string> errors)
    {
        string rawSvg = ExtractLegacySvgPayload(svgText);
        XDocument document;
        try
        {
            document = XDocument.Parse(rawSvg, LoadOptions.PreserveWhitespace);
        }
        catch (Exception exception)
        {
            errors.Add($"Piano '{floorId}': SVG non valido ({exception.Message}).");
            return [];
        }

        XElement? root = document.Root;
        if (root is null || root.Name != SvgNamespace + "svg")
        {
            errors.Add($"Piano '{floorId}': radice SVG o namespace non validi.");
            return [];
        }

        if (root.Attribute("transform") is not null)
            errors.Add($"Piano '{floorId}': transform sulla radice SVG non supportato.");

        XElement? sourceGroup = root
            .Descendants(SvgNamespace + "g")
            .FirstOrDefault(group => string.Equals(
                group.Attribute("id")?.Value?.Trim(),
                role,
                StringComparison.OrdinalIgnoreCase));

        if (sourceGroup is null)
        {
            errors.Add($"Piano '{floorId}': gruppo SVG '{role}' non trovato.");
            return [];
        }

        if (sourceGroup.Attribute("transform") is not null)
            errors.Add($"Piano '{floorId}': transform sul gruppo '{role}' non supportato.");

        var result = new List<XElement>();
        foreach (XElement element in sourceGroup.Elements())
        {
            bool allowed = element.Name == SvgNamespace + "line" || element.Name == SvgNamespace + "text";
            if (!allowed)
            {
                errors.Add($"Piano '{floorId}': elemento diretto '{element.Name.LocalName}' non supportato; sono ammessi line e text.");
                continue;
            }

            if (element.Attribute("transform") is not null)
            {
                errors.Add($"Piano '{floorId}': transform su '{element.Name.LocalName}' non supportato.");
                continue;
            }

            ValidateCoordinates(element, floorId, errors);
            result.Add(new XElement(element));
        }

        return result;
    }

    // Funzione realizzata da Codex in autonomia
    private static void ValidateCoordinates(XElement element, string floorId, ICollection<string> errors)
    {
        string[] attributes = element.Name.LocalName == "line"
            ? ["x1", "y1", "x2", "y2"]
            : ["x", "y"];

        foreach (string attributeName in attributes)
        {
            string? value = element.Attribute(attributeName)?.Value;
            if (string.IsNullOrWhiteSpace(value) ||
                !double.TryParse(value, NumberStyles.Float, CultureInfo.InvariantCulture, out _))
            {
                errors.Add($"Piano '{floorId}': attributo numerico '{attributeName}' non valido su '{element.Name.LocalName}'.");
            }
        }
    }

    // Funzione realizzata da Codex in autonomia
    private static string ExtractLegacySvgPayload(string text)
    {
        const string legacyStart = "[TERMODEL-SVG-TEXT-V1]";
        const string legacyEnd = "[/TERMODEL-SVG-TEXT-V1]";
        int start = text.IndexOf(legacyStart, StringComparison.Ordinal);
        if (start < 0)
            return text;

        int contentStart = start + legacyStart.Length;
        int end = text.IndexOf(legacyEnd, contentStart, StringComparison.Ordinal);
        return end < 0 ? text : text[contentStart..end].Trim();
    }

    // Funzione realizzata da Codex in autonomia
    private static string SerializeArchiveXml(List<Dictionary<string, object?>> rows)
    {
        var collection = new ObservableCollection<Dictionary<string, object?>>(rows);
        var serializer = new DataContractSerializer(typeof(ObservableCollection<Dictionary<string, object?>>));
        var settings = new XmlWriterSettings
        {
            Indent = true,
            OmitXmlDeclaration = false,
            Encoding = new UTF8Encoding(encoderShouldEmitUTF8Identifier: false)
        };

        using var writerText = new Utf8StringWriter(CultureInfo.InvariantCulture);
        using (XmlWriter writer = XmlWriter.Create(writerText, settings))
            serializer.WriteObject(writer, collection);
        return writerText.ToString();
    }

    // Funzione realizzata da Codex in autonomia
    private static ProjectSection CreateSection(string name, string contentType, string content)
    {
        string normalized = NormalizeLineEndings(content).TrimEnd('\n');
        string forbiddenMarker = $"---END:{name}---";
        if (normalized.Contains(forbiddenMarker, StringComparison.Ordinal))
            throw new InvalidDataException($"Il contenuto della sezione '{name}' contiene il marcatore riservato di chiusura.");

        string hash = Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(normalized)))
            .ToLowerInvariant();
        return new ProjectSection(name, contentType, normalized, hash);
    }

    // Funzione realizzata da Codex in autonomia
    private static string BuildContainer(IEnumerable<ProjectSection> sections)
    {
        var builder = new StringBuilder();
        builder.AppendLine(StartMarker);
        foreach (ProjectSection section in sections)
        {
            builder.AppendLine();
            builder.Append("---BEGIN:").Append(section.Name).AppendLine("---");
            builder.AppendLine(section.Content);
            builder.Append("---END:").Append(section.Name).AppendLine("---");
        }

        builder.AppendLine();
        builder.AppendLine(EndMarker);
        return NormalizeLineEndings(builder.ToString());
    }

    // Funzione realizzata da Codex in autonomia
    private static string NormalizeFloorType(string value) =>
        string.Equals(value, "Copertura", StringComparison.OrdinalIgnoreCase)
            ? "Copertura"
            : "Calpestabile";

    // Funzione realizzata da Codex in autonomia
    private static string SanitizeId(string value)
    {
        var builder = new StringBuilder();
        foreach (char character in value.Trim())
            builder.Append(char.IsLetterOrDigit(character) || character is '-' or '_' ? character : '-');
        return builder.Length == 0 ? "floor" : builder.ToString();
    }

    // Funzione realizzata da Codex in autonomia
    private static string NormalizeLineEndings(string value) =>
        value.Replace("\r\n", "\n", StringComparison.Ordinal).Replace('\r', '\n');

    private sealed record ProjectSection(
        string Name,
        string ContentType,
        string Content,
        string Sha256);

    private sealed class Utf8StringWriter(IFormatProvider formatProvider) : StringWriter(formatProvider)
    {
        public override Encoding Encoding => new UTF8Encoding(encoderShouldEmitUTF8Identifier: false);
    }
}
