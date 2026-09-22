using System.Collections.Concurrent;
using System.Globalization;
using System.Text;

namespace Termodel.WebService.Projects;

public sealed class ProjectStore
{
    private static readonly UTF8Encoding Utf8WithoutBom = new(false);
    private readonly ConcurrentDictionary<Guid, SemaphoreSlim> _projectLocks = new();
    private readonly string _reservationsDirectory;

    public ProjectStore(IHostEnvironment environment)
    {
        string? configuredDirectory =
            Environment.GetEnvironmentVariable("TERMODEL_SAVED_PROJECTS_DIR");

        RootDirectory = string.IsNullOrWhiteSpace(configuredDirectory)
            ? Path.Combine(environment.ContentRootPath, "SavedProjects")
            : Path.GetFullPath(configuredDirectory);

        _reservationsDirectory = Path.Combine(RootDirectory, ".reservations");
    }

    public string RootDirectory { get; }

    public async Task<Guid> AllocateProjectIdAsync(CancellationToken cancellationToken)
    {
        Directory.CreateDirectory(RootDirectory);
        Directory.CreateDirectory(_reservationsDirectory);

        while (true)
        {
            cancellationToken.ThrowIfCancellationRequested();

            Guid projectId = Guid.NewGuid();
            string projectDirectory = GetProjectDirectory(projectId);
            string reservationPath = GetReservationPath(projectId);

            if (Directory.Exists(projectDirectory) || File.Exists(reservationPath))
                continue;

            try
            {
                await using var stream = new FileStream(
                    reservationPath,
                    FileMode.CreateNew,
                    FileAccess.Write,
                    FileShare.None,
                    bufferSize: 4096,
                    useAsync: true);

                byte[] reservation = Utf8WithoutBom.GetBytes(
                    DateTimeOffset.UtcNow.ToString("O", CultureInfo.InvariantCulture));

                await stream.WriteAsync(reservation, cancellationToken);
                await stream.FlushAsync(cancellationToken);

                if (Directory.Exists(projectDirectory))
                {
                    File.Delete(reservationPath);
                    continue;
                }

                return projectId;
            }
            catch (IOException)
            {
                // Un'altra richiesta/processo ha riservato lo stesso ID.
                // Con un GUID è un caso estremamente raro, ma CreateNew rende
                // comunque la prenotazione esclusiva.
            }
        }
    }

    public bool IsReserved(Guid projectId) =>
        File.Exists(GetReservationPath(projectId)) ||
        Directory.Exists(GetProjectDirectory(projectId));

    public async Task<ProjectCalculationData> UpdateCurrentAsync(
        Guid projectId,
        string projectText,
        Func<CancellationToken, Task<ProjectCalculationData>> calculate,
        CancellationToken cancellationToken)
    {
        if (!IsReserved(projectId))
        {
            throw new InvalidDataException(
                $"Il projectId '{projectId:D}' non è stato allocato dal Service.");
        }

        SemaphoreSlim gate = _projectLocks.GetOrAdd(projectId, static _ => new SemaphoreSlim(1, 1));
        await gate.WaitAsync(cancellationToken);

        try
        {
            ProjectCalculationData data = await calculate(cancellationToken);
            await PublishCurrentAsync(projectId, projectText, data, cancellationToken);
            return data;
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task<byte[]?> ReadModel3DAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        SemaphoreSlim gate = _projectLocks.GetOrAdd(projectId, static _ => new SemaphoreSlim(1, 1));
        await gate.WaitAsync(cancellationToken);

        try
        {
            string modelPath = Path.Combine(
                GetProjectDirectory(projectId),
                "artifacts",
                "model3d.json");

            if (!File.Exists(modelPath))
                return null;

            return await File.ReadAllBytesAsync(modelPath, cancellationToken);
        }
        finally
        {
            gate.Release();
        }
    }

    private async Task PublishCurrentAsync(
        Guid projectId,
        string projectText,
        ProjectCalculationData data,
        CancellationToken cancellationToken)
    {
        Directory.CreateDirectory(RootDirectory);

        string projectDirectory = GetProjectDirectory(projectId);
        string stagingDirectory = Path.Combine(
            RootDirectory,
            $".staging-{projectId:N}-{Guid.NewGuid():N}");
        string backupDirectory = Path.Combine(
            RootDirectory,
            $".backup-{projectId:N}-{Guid.NewGuid():N}");

        Directory.CreateDirectory(stagingDirectory);

        try
        {
            string artifactsDirectory = Path.Combine(stagingDirectory, "artifacts");
            string logsDirectory = Path.Combine(stagingDirectory, "logs");
            Directory.CreateDirectory(artifactsDirectory);
            Directory.CreateDirectory(logsDirectory);

            await File.WriteAllTextAsync(
                Path.Combine(stagingDirectory, "project.tmdl"),
                projectText,
                Utf8WithoutBom,
                cancellationToken);

            await File.WriteAllBytesAsync(
                Path.Combine(artifactsDirectory, "model3d.json"),
                data.Model3DJson,
                cancellationToken);

            await File.WriteAllTextAsync(
                Path.Combine(logsDirectory, "diagnostics.txt"),
                string.Join(Environment.NewLine, data.Diagnostics),
                Utf8WithoutBom,
                cancellationToken);

            string calculationLog =
                $"projectId={projectId:D}{Environment.NewLine}" +
                $"completedAtUtc={DateTimeOffset.UtcNow:O}{Environment.NewLine}" +
                $"status=completed{Environment.NewLine}" +
                $"primitiveCount={data.PrimitiveCount}{Environment.NewLine}" +
                $"diagnosticCount={data.Diagnostics.Count}{Environment.NewLine}";

            await File.WriteAllTextAsync(
                Path.Combine(logsDirectory, "calculation.log"),
                calculationLog,
                Utf8WithoutBom,
                cancellationToken);

            bool previousMoved = false;
            try
            {
                if (Directory.Exists(projectDirectory))
                {
                    Directory.Move(projectDirectory, backupDirectory);
                    previousMoved = true;
                }

                Directory.Move(stagingDirectory, projectDirectory);

                if (previousMoved && Directory.Exists(backupDirectory))
                    Directory.Delete(backupDirectory, recursive: true);
            }
            catch
            {
                if (!Directory.Exists(projectDirectory) &&
                    previousMoved &&
                    Directory.Exists(backupDirectory))
                {
                    Directory.Move(backupDirectory, projectDirectory);
                }

                throw;
            }
        }
        finally
        {
            if (Directory.Exists(stagingDirectory))
                Directory.Delete(stagingDirectory, recursive: true);

            // Il backup non è uno storico: se il nuovo stato è già stato
            // pubblicato, tenta sempre di eliminarlo.
            if (Directory.Exists(projectDirectory) && Directory.Exists(backupDirectory))
            {
                try
                {
                    Directory.Delete(backupDirectory, recursive: true);
                }
                catch
                {
                    // Non trasformare un aggiornamento già pubblicato con
                    // successo in errore solo per un cleanup filesystem.
                }
            }
        }
    }

    private string GetProjectDirectory(Guid projectId) =>
        Path.Combine(RootDirectory, projectId.ToString("D"));

    private string GetReservationPath(Guid projectId) =>
        Path.Combine(_reservationsDirectory, $"{projectId:D}.reserve");
}

public sealed record ProjectCalculationData(
    byte[] Model3DJson,
    IReadOnlyList<string> Diagnostics,
    int PrimitiveCount);
