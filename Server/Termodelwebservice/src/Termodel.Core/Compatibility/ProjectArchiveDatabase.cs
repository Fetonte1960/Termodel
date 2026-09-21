using System.Collections.ObjectModel;
using System.Globalization;
using System.Runtime.Serialization;
using System.Xml;
using Termodel.Core.ProjectFiles;

namespace Termodel.Core.Compatibility;

public sealed class ProjectArchiveDatabase
{
    private readonly Dictionary<string, ObservableCollection<Dictionary<string, object>>> _collections;

    private ProjectArchiveDatabase(
        Dictionary<string, ObservableCollection<Dictionary<string, object>>> collections)
    {
        _collections = collections;
    }

    // Funzione realizzata da Codex in autonomia
    public static ProjectArchiveDatabase Load(ProjectTextDocument project)
    {
        var collections = new Dictionary<string, ObservableCollection<Dictionary<string, object>>>(
            StringComparer.Ordinal);

        foreach ((string name, string content) in project.Sections)
        {
            const string prefix = "archives/xml/";
            if (!name.StartsWith(prefix, StringComparison.Ordinal) ||
                !name.EndsWith(".xml", StringComparison.Ordinal))
                continue;

            string archiveName = name[prefix.Length..^4];
            try
            {
                var serializer = new DataContractSerializer(
                    typeof(ObservableCollection<Dictionary<string, object>>));
                using var stringReader = new StringReader(content);
                using XmlReader xmlReader = XmlReader.Create(stringReader);
                var rows = serializer.ReadObject(xmlReader)
                    as ObservableCollection<Dictionary<string, object>>;
                collections.Add(archiveName, rows ?? []);
            }
            catch (Exception exception) when (exception is SerializationException or XmlException)
            {
                throw new InvalidDataException($"Archivio XML '{archiveName}' non valido.", exception);
            }
        }

        if (collections.Count == 0)
            throw new InvalidDataException("Il file unico non contiene archivi XML.");
        return new ProjectArchiveDatabase(collections);
    }

    // Funzione realizzata da Codex in autonomia
    public ObservableCollection<Dictionary<string, object>> GetCollection(string archiveName) =>
        _collections.TryGetValue(archiveName, out ObservableCollection<Dictionary<string, object>>? rows)
            ? rows
            : throw new InvalidDataException($"Archivio '{archiveName}' non presente nel file unico.");

    // Funzione realizzata da Codex in autonomia
    public string GetDataDB(
        string searchField,
        object? searchValue,
        string resultField,
        IEnumerable<Dictionary<string, object>> rows)
    {
        string expected = Convert.ToString(searchValue, CultureInfo.InvariantCulture)?.Trim() ?? string.Empty;
        Dictionary<string, object>? row = rows.FirstOrDefault(candidate =>
            candidate.TryGetValue(searchField, out object? actual) &&
            string.Equals(Convert.ToString(actual, CultureInfo.InvariantCulture)?.Trim(), expected, StringComparison.OrdinalIgnoreCase));

        return row is not null && row.TryGetValue(resultField, out object? value)
            ? Convert.ToString(value, CultureInfo.InvariantCulture) ?? string.Empty
            : string.Empty;
    }

    // Funzione realizzata da Codex in autonomia
    public string GetDataDBSingleRow(
        string field,
        IEnumerable<Dictionary<string, object>> rows)
    {
        Dictionary<string, object>? row = rows.FirstOrDefault();
        return row is not null && row.TryGetValue(field, out object? value)
            ? Convert.ToString(value, CultureInfo.InvariantCulture) ?? string.Empty
            : string.Empty;
    }

    // Funzione realizzata da Codex in autonomia
    public bool ItemNessuno(object? value)
    {
        string text = Convert.ToString(value, CultureInfo.InvariantCulture)?.Trim() ?? string.Empty;
        return text.Length == 0 ||
               text.Equals("Nessuno", StringComparison.OrdinalIgnoreCase) ||
               text.Equals("NON DEFINITO", StringComparison.OrdinalIgnoreCase);
    }

    // Funzione realizzata da Codex in autonomia
    public void RequireReferencedValue(
        string sourceDescription,
        object? value,
        string archiveName,
        string field)
    {
        if (ItemNessuno(value)) return;
        string expected = Convert.ToString(value, CultureInfo.InvariantCulture)?.Trim() ?? string.Empty;
        bool exists = GetCollection(archiveName).Any(row =>
            row.TryGetValue(field, out object? actual) &&
            string.Equals(Convert.ToString(actual, CultureInfo.InvariantCulture)?.Trim(), expected, StringComparison.OrdinalIgnoreCase));
        if (!exists)
            throw new InvalidDataException(
                $"{sourceDescription}: valore '{expected}' non presente in {archiveName}.{field}.");
    }
}
