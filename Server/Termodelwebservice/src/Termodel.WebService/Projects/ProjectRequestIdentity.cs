using System.Text.Json;
using Termodel.Core.ProjectFiles;

namespace Termodel.WebService.Projects;

public static class ProjectRequestIdentity
{
    public static Guid ReadProjectId(string projectText)
    {
        ProjectTextDocument project = ProjectTextDocument.Parse(projectText);
        string manifestText = project.GetRequiredSection("manifest.json");

        try
        {
            using JsonDocument manifest = JsonDocument.Parse(manifestText);
            JsonElement root = manifest.RootElement;

            if (root.ValueKind != JsonValueKind.Object ||
                !root.TryGetProperty("projectId", out JsonElement projectIdElement) ||
                projectIdElement.ValueKind != JsonValueKind.String)
            {
                throw new InvalidDataException(
                    "manifest.projectId è obbligatorio. Richiedere prima POST /api/projects/allocate-id e consolidare l'ID nel progetto.");
            }

            string? projectIdText = projectIdElement.GetString();
            if (!Guid.TryParse(projectIdText, out Guid projectId) || projectId == Guid.Empty)
            {
                throw new InvalidDataException(
                    "manifest.projectId non contiene un identificatore GUID valido.");
            }

            return projectId;
        }
        catch (JsonException exception)
        {
            throw new InvalidDataException(
                $"manifest.json non è un JSON valido: {exception.Message}",
                exception);
        }
    }
}
