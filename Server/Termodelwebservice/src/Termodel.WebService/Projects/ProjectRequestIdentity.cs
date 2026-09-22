using System.Text.Json;
using System.Text.Json.Nodes;
using Termodel.Core.ProjectFiles;

namespace Termodel.WebService.Projects;

public static class ProjectRequestIdentity
{
    public static Guid ReadProjectId(string projectText)
    {
        JsonObject manifest = ReadManifest(projectText);

        if (!manifest.TryGetPropertyValue("projectId", out JsonNode? projectIdNode) ||
            projectIdNode is null ||
            !Guid.TryParse(projectIdNode.GetValue<string?>(), out Guid projectId) ||
            projectId == Guid.Empty)
        {
            throw new InvalidDataException(
                "manifest.projectId è obbligatorio e deve contenere un GUID valido. Richiedere prima POST /api/projects/allocate-id e consolidare l'ID nel progetto.");
        }

        return projectId;
    }

    public static string ReadProjectName(string projectText)
    {
        JsonObject manifest = ReadManifest(projectText);

        if (!manifest.TryGetPropertyValue("projectName", out JsonNode? projectNameNode) ||
            projectNameNode is null)
        {
            return string.Empty;
        }

        return projectNameNode.GetValue<string?>()?.Trim() ?? string.Empty;
    }

    public static string SetProjectName(string projectText, string projectName)
    {
        string normalizedName = projectName.Trim();
        if (normalizedName.Length == 0)
            throw new InvalidDataException("Il nome del progetto non può essere vuoto.");

        const string beginMarker = "---BEGIN:manifest.json---";
        const string endMarker = "---END:manifest.json---";

        string normalized = NormalizeLineEndings(projectText);
        int beginIndex = normalized.IndexOf(beginMarker, StringComparison.Ordinal);
        if (beginIndex < 0)
            throw new InvalidDataException("La sezione manifest.json non è presente.");

        int contentStart = beginIndex + beginMarker.Length;
        if (contentStart < normalized.Length && normalized[contentStart] == '\n')
            contentStart++;

        int endIndex = normalized.IndexOf(
            endMarker,
            contentStart,
            StringComparison.Ordinal);

        if (endIndex < 0)
            throw new InvalidDataException("La chiusura della sezione manifest.json non è presente.");

        string manifestText = normalized[contentStart..endIndex].TrimEnd('\n');
        JsonObject manifest = ParseManifest(manifestText);
        manifest["projectName"] = normalizedName;

        string newManifest = manifest.ToJsonString(new JsonSerializerOptions
        {
            WriteIndented = true
        });

        return normalized[..contentStart] +
            newManifest +
            "\n" +
            normalized[endIndex..];
    }

    private static JsonObject ReadManifest(string projectText)
    {
        ProjectTextDocument project = ProjectTextDocument.Parse(projectText);
        return ParseManifest(project.GetRequiredSection("manifest.json"));
    }

    private static JsonObject ParseManifest(string manifestText)
    {
        try
        {
            JsonNode? node = JsonNode.Parse(manifestText);
            if (node is not JsonObject manifest)
                throw new InvalidDataException("manifest.json deve contenere un oggetto JSON.");

            return manifest;
        }
        catch (JsonException exception)
        {
            throw new InvalidDataException(
                $"manifest.json non è un JSON valido: {exception.Message}",
                exception);
        }
    }

    private static string NormalizeLineEndings(string value) =>
        value.Replace("\r\n", "\n", StringComparison.Ordinal).Replace('\r', '\n');
}
