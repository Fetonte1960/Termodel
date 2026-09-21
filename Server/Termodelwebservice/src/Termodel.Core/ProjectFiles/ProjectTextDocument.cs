using System.Text.RegularExpressions;

namespace Termodel.Core.ProjectFiles;

public sealed class ProjectTextDocument
{
    private const string StartMarker = "[TERMODEL-PROJECT-TEXT-V1]";
    private const string EndMarker = "[END-TERMODEL-PROJECT-TEXT-V1]";
    private static readonly Regex SectionPattern = new(
        "---BEGIN:(?<name>[^\\r\\n]+)---\\s*\\n(?<content>[\\s\\S]*?)\\n---END:\\k<name>---",
        RegexOptions.Compiled | RegexOptions.CultureInvariant);

    private ProjectTextDocument(IReadOnlyDictionary<string, string> sections)
    {
        Sections = sections;
    }

    public IReadOnlyDictionary<string, string> Sections { get; }

    // Funzione realizzata da Codex in autonomia
    public static ProjectTextDocument Parse(string projectText)
    {
        if (string.IsNullOrWhiteSpace(projectText))
            throw new InvalidDataException("Il file unico di progetto è vuoto.");

        string normalized = NormalizeLineEndings(projectText).Trim();
        if (!normalized.StartsWith(StartMarker, StringComparison.Ordinal) ||
            !normalized.EndsWith(EndMarker, StringComparison.Ordinal))
        {
            throw new InvalidDataException("Marcatori TERMODEL-PROJECT-TEXT-V1 mancanti o non validi.");
        }

        var sections = new Dictionary<string, string>(StringComparer.Ordinal);
        foreach (Match match in SectionPattern.Matches(normalized))
        {
            string name = match.Groups["name"].Value.Trim();
            if (!sections.TryAdd(name, match.Groups["content"].Value.TrimEnd('\n')))
                throw new InvalidDataException($"La sezione '{name}' è duplicata.");
        }

        if (!sections.ContainsKey("manifest.json"))
            throw new InvalidDataException("La sezione manifest.json è obbligatoria.");
        if (!sections.ContainsKey("geometry/project.svg"))
            throw new InvalidDataException("La sezione geometry/project.svg è obbligatoria.");

        return new ProjectTextDocument(sections);
    }

    // Funzione realizzata da Codex in autonomia
    public string GetRequiredSection(string name) =>
        Sections.TryGetValue(name, out string? content)
            ? content
            : throw new InvalidDataException($"La sezione obbligatoria '{name}' non è presente.");

    private static string NormalizeLineEndings(string value) =>
        value.Replace("\r\n", "\n", StringComparison.Ordinal).Replace('\r', '\n');
}
