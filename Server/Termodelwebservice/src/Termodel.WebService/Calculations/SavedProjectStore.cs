using System.Text;

namespace Termodel.WebService.Calculations;

/// <summary>
/// Persistenza operativa dei progetti tecnici ricevuti da POST /api/calculations.
/// Il contenuto salvato è il projectText già letto dalla richiesta, senza
/// ricostruzioni e senza aggiunta di risorse frontend.
/// </summary>
public sealed class SavedProjectStore
{
    private static readonly UTF8Encoding Utf8WithoutBom = new(false);

    public SavedProjectStore(IHostEnvironment environment)
    {
        string? configuredDirectory =
            Environment.GetEnvironmentVariable("TERMODEL_SAVED_PROJECTS_DIR");

        RootDirectory = string.IsNullOrWhiteSpace(configuredDirectory)
            ? Path.Combine(environment.ContentRootPath, "SavedProjects")
            : Path.GetFullPath(configuredDirectory);
    }

    public string RootDirectory { get; }

    public async Task<string> SaveAsync(
        Guid calculationId,
        DateTimeOffset createdAtUtc,
        string projectText,
        CancellationToken cancellationToken)
    {
        Directory.CreateDirectory(RootDirectory);

        string fileName =
            $"TermodelProject-{createdAtUtc.UtcDateTime:yyyyMMdd-HHmmssfff}-{calculationId:D}.tmdl";
        string fullPath = Path.Combine(RootDirectory, fileName);
        string temporaryPath = fullPath + ".tmp";

        try
        {
            await File.WriteAllTextAsync(
                temporaryPath,
                projectText,
                Utf8WithoutBom,
                cancellationToken);

            File.Move(temporaryPath, fullPath);
            return fileName;
        }
        finally
        {
            if (File.Exists(temporaryPath))
                File.Delete(temporaryPath);
        }
    }
}
