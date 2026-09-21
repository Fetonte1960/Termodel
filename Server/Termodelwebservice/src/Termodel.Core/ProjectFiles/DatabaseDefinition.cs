using System.Security.Cryptography;
using System.Text;
using System.Text.Json;

namespace Termodel.Core.ProjectFiles;

internal sealed class DatabaseDefinition
{
    private readonly JsonElement _root;

    private DatabaseDefinition(string rawText, JsonElement root)
    {
        RawText = NormalizeLineEndings(rawText);
        _root = root;
        Sha256 = Convert.ToHexString(SHA256.HashData(Encoding.UTF8.GetBytes(RawText))).ToLowerInvariant();
    }

    public string RawText { get; }
    public string Sha256 { get; }

    public IEnumerable<string> ArchiveNames => _root.EnumerateObject().Select(property => property.Name);

    // Funzione realizzata da Codex in autonomia
    public static DatabaseDefinition Load(string path)
    {
        if (!File.Exists(path))
            throw new FileNotFoundException("Il file autorevole definizionedati.json non è disponibile.", path);

        string rawText = File.ReadAllText(path, Encoding.UTF8);
        using JsonDocument document = JsonDocument.Parse(rawText);
        if (document.RootElement.ValueKind != JsonValueKind.Object)
            throw new InvalidDataException("definizionedati.json deve avere un oggetto JSON come radice.");

        return new DatabaseDefinition(rawText, document.RootElement.Clone());
    }

    // Funzione realizzata da Codex in autonomia
    public Dictionary<string, object?> CreateInitializedRow(string archiveName)
    {
        if (!_root.TryGetProperty(archiveName, out JsonElement archive) || archive.ValueKind != JsonValueKind.Object)
            throw new InvalidDataException($"Archivio '{archiveName}' non presente in definizionedati.json.");

        var row = new Dictionary<string, object?>(StringComparer.Ordinal);
        foreach (JsonProperty field in archive.EnumerateObject())
        {
            JsonElement metadata = field.Value;
            object? value = null;

            if (metadata.ValueKind == JsonValueKind.Object && metadata.TryGetProperty("Ini", out JsonElement initialValue))
            {
                value = ConvertValue(initialValue);
            }
            else if (metadata.ValueKind == JsonValueKind.Object &&
                     metadata.TryGetProperty("Combo", out JsonElement combo) &&
                     combo.ValueKind == JsonValueKind.Array)
            {
                JsonElement[] choices = combo.EnumerateArray().ToArray();
                if (choices.Length > 3 &&
                    choices[0].ValueKind == JsonValueKind.String &&
                    string.Equals(choices[0].GetString(), "auto_combo", StringComparison.OrdinalIgnoreCase))
                {
                    value = ConvertValue(choices[3]);
                }
            }

            row[field.Name] = value;
        }

        return row;
    }

    // Funzione realizzata da Codex in autonomia
    public Dictionary<string, object?> ValidateAndCompleteRow(
        string archiveName,
        IReadOnlyDictionary<string, JsonElement> suppliedRow,
        ICollection<string> errors)
    {
        if (!_root.TryGetProperty(archiveName, out JsonElement archive) || archive.ValueKind != JsonValueKind.Object)
        {
            errors.Add($"Archivio sconosciuto: {archiveName}.");
            return new Dictionary<string, object?>();
        }

        var row = CreateInitializedRow(archiveName);
        foreach ((string fieldName, JsonElement value) in suppliedRow)
        {
            if (!archive.TryGetProperty(fieldName, out _))
            {
                errors.Add($"Campo sconosciuto '{archiveName}.{fieldName}'.");
                continue;
            }

            row[fieldName] = ConvertValue(value);
        }

        return row;
    }

    // Funzione realizzata da Codex in autonomia
    private static object? ConvertValue(JsonElement value)
    {
        return value.ValueKind switch
        {
            JsonValueKind.String => value.GetString(),
            JsonValueKind.Number when value.TryGetInt64(out long integer) => integer,
            JsonValueKind.Number => value.GetDouble(),
            JsonValueKind.True => true,
            JsonValueKind.False => false,
            JsonValueKind.Null or JsonValueKind.Undefined => null,
            _ => value.GetRawText()
        };
    }

    // Funzione realizzata da Codex in autonomia
    private static string NormalizeLineEndings(string value) =>
        value.Replace("\r\n", "\n", StringComparison.Ordinal).Replace('\r', '\n');
}
