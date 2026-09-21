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

    public ObservableCollection<Dictionary<string, object>> GetCollection(string archiveName) =>
        _collections.TryGetValue(archiveName, out ObservableCollection<Dictionary<string, object>>? rows)
            ? rows
            : throw new InvalidDataException(
                $"Archivio '{archiveName}' non presente nel file unico.");

    /// <summary>
    /// Replica la semantica Desktop: confronto testuale trimmed e case-sensitive;
    /// se non esiste una corrispondenza o il risultato è vuoto ritorna null a runtime.
    /// </summary>
    public string GetDataDB(
        string searchField,
        object? searchValue,
        string resultField,
        IEnumerable<Dictionary<string, object>> rows)
    {
        string? expected = Convert.ToString(searchValue, CultureInfo.InvariantCulture);
        if (expected is null)
            return null!;

        foreach (Dictionary<string, object> candidate in rows)
        {
            if (!candidate.TryGetValue(searchField, out object? actual))
                continue;

            string? keyValue = Convert.ToString(actual, CultureInfo.InvariantCulture);
            if (keyValue is null ||
                !string.Equals(keyValue.Trim(), expected.Trim(), StringComparison.Ordinal))
                continue;

            if (!candidate.TryGetValue(resultField, out object? value))
                return null!;

            string? result = value is double numericValue
                ? numericValue.ToString(CultureInfo.InvariantCulture)
                : value?.ToString();

            return string.IsNullOrEmpty(result) ? null! : result;
        }

        return null!;
    }

    public string GetDataDBSingleRow(
        string field,
        IEnumerable<Dictionary<string, object>> rows)
    {
        Dictionary<string, object>? row = rows.FirstOrDefault();
        if (row is null)
            return "La collezione è vuota o null.";

        return row.TryGetValue(field, out object? value)
            ? value?.ToString() ?? string.Empty
            : $"Il campo '{field}' non è stato trovato nella prima riga della collezione.";
    }

    public bool ItemNessuno(object? value)
    {
        string text = Convert.ToString(value, CultureInfo.InvariantCulture)?.Trim() ?? string.Empty;
        return text.Length == 0 ||
               text.Equals("Nessuno", StringComparison.OrdinalIgnoreCase) ||
               text.Equals("NON DEFINITO", StringComparison.OrdinalIgnoreCase);
    }

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
            string.Equals(
                Convert.ToString(actual, CultureInfo.InvariantCulture)?.Trim(),
                expected,
                StringComparison.Ordinal));

        if (!exists)
            throw new InvalidDataException(
                $"{sourceDescription}: valore '{expected}' non presente in {archiveName}.{field}.");
    }
}
