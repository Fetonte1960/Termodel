using System.Collections.Concurrent;
using System.Globalization;
using System.Text;
using System.Text.Json;

namespace Termodel.WebService.Projects;

public sealed class ProjectStore
{
    private static readonly UTF8Encoding Utf8WithoutBom = new(false);
    private static readonly JsonSerializerOptions JsonOptions = new(JsonSerializerDefaults.Web)
    {
        WriteIndented = true
    };

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
            catch (IOException) when (File.Exists(reservationPath))
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

    public async Task<IReadOnlyList<ProjectListEntry>> ListProjectsAsync(
        CancellationToken cancellationToken)
    {
        if (!Directory.Exists(RootDirectory))
            return [];

        var result = new List<ProjectListEntry>();

        foreach (string directory in Directory.EnumerateDirectories(RootDirectory))
        {
            cancellationToken.ThrowIfCancellationRequested();

            string directoryName = Path.GetFileName(directory);
            if (!Guid.TryParse(directoryName, out Guid projectId))
                continue;

            string projectPath = Path.Combine(directory, "project.tmdl");
            if (!File.Exists(projectPath))
                continue;

            string projectText = await File.ReadAllTextAsync(
                projectPath,
                Encoding.UTF8,
                cancellationToken);

            string projectName;
            try
            {
                projectName = ProjectRequestIdentity.ReadProjectName(projectText);
            }
            catch
            {
                projectName = projectId.ToString("D");
            }

            ProjectState state = await ReadStateUnlockedAsync(
                projectId,
                cancellationToken);

            result.Add(new ProjectListEntry(
                projectId,
                projectName,
                File.GetLastWriteTimeUtc(projectPath),
                state.ArtifactsStale));
        }

        return result
            .OrderBy(entry => entry.ProjectName, StringComparer.CurrentCultureIgnoreCase)
            .ThenBy(entry => entry.ProjectId)
            .ToArray();
    }

    public async Task<string?> ReadProjectAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        SemaphoreSlim gate = GetGate(projectId);
        await gate.WaitAsync(cancellationToken);

        try
        {
            string projectPath = GetProjectPath(projectId);
            if (!File.Exists(projectPath))
                return null;

            return await File.ReadAllTextAsync(
                projectPath,
                Encoding.UTF8,
                cancellationToken);
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task SaveProjectAsync(
        Guid projectId,
        string projectText,
        CancellationToken cancellationToken)
    {
        if (!IsReserved(projectId))
        {
            throw new InvalidDataException(
                $"Il projectId '{projectId:D}' non è stato allocato dal Service.");
        }

        SemaphoreSlim gate = GetGate(projectId);
        await gate.WaitAsync(cancellationToken);

        try
        {
            string projectDirectory = GetProjectDirectory(projectId);
            Directory.CreateDirectory(projectDirectory);

            await WriteTextAtomicallyAsync(
                GetProjectPath(projectId),
                projectText,
                cancellationToken);

            ProjectState previous = await ReadStateUnlockedAsync(
                projectId,
                cancellationToken);

            var state = new ProjectState(
                ArtifactsStale: true,
                LastSavedAtUtc: DateTimeOffset.UtcNow,
                LastCalculatedAtUtc: previous.LastCalculatedAtUtc);

            await WriteJsonAtomicallyAsync(
                GetStatePath(projectId),
                state,
                cancellationToken);

            TryDeleteReservation(projectId);
        }
        finally
        {
            gate.Release();
        }
    }

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

        SemaphoreSlim gate = GetGate(projectId);
        await gate.WaitAsync(cancellationToken);

        try
        {
            ProjectCalculationData data = await calculate(cancellationToken);
            await PublishCurrentAsync(projectId, projectText, data, cancellationToken);
            TryDeleteReservation(projectId);
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
        SemaphoreSlim gate = GetGate(projectId);
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

    public async Task<byte[]?> ReadRadiantPanelsAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        SemaphoreSlim gate = GetGate(projectId);
        await gate.WaitAsync(cancellationToken);

        try
        {
            string artifactPath = Path.Combine(
                GetProjectDirectory(projectId),
                "artifacts",
                "pannelli.json");

            if (!File.Exists(artifactPath))
                return null;

            return await File.ReadAllBytesAsync(artifactPath, cancellationToken);
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task<byte[]?> ReadRadiantExecutiveSvgAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        return await ReadArtifactAsync(
            projectId,
            "pannelli-esecutivo.svg",
            cancellationToken);
    }

    public async Task<byte[]?> ReadRadiantExecutiveDxfAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        return await ReadArtifactAsync(
            projectId,
            "pannelli-esecutivo.dxf",
            cancellationToken);
    }

    private async Task<byte[]?> ReadArtifactAsync(
        Guid projectId,
        string fileName,
        CancellationToken cancellationToken)
    {
        SemaphoreSlim gate = GetGate(projectId);
        await gate.WaitAsync(cancellationToken);

        try
        {
            string artifactPath = Path.Combine(
                GetProjectDirectory(projectId),
                "artifacts",
                fileName);

            if (!File.Exists(artifactPath))
                return null;

            return await File.ReadAllBytesAsync(
                artifactPath,
                cancellationToken);
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task<byte[]?> ReadTermodelLogAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        SemaphoreSlim gate = GetGate(projectId);
        await gate.WaitAsync(cancellationToken);

        try
        {
            string logPath = Path.Combine(
                GetProjectDirectory(projectId),
                "logs",
                "TermodelLog.md");

            if (!File.Exists(logPath))
                return null;

            return await File.ReadAllBytesAsync(logPath, cancellationToken);
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task<bool> AreArtifactsStaleAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        SemaphoreSlim gate = GetGate(projectId);
        await gate.WaitAsync(cancellationToken);

        try
        {
            ProjectState state = await ReadStateUnlockedAsync(
                projectId,
                cancellationToken);

            return state.ArtifactsStale;
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

            DateTimeOffset completedAtUtc = DateTimeOffset.UtcNow;

            await File.WriteAllTextAsync(
                Path.Combine(stagingDirectory, "project.tmdl"),
                projectText,
                Utf8WithoutBom,
                cancellationToken);

            await File.WriteAllBytesAsync(
                Path.Combine(artifactsDirectory, "model3d.json"),
                data.Model3DJson,
                cancellationToken);

            if (data.RadiantPanelsJson is not null)
            {
                await File.WriteAllBytesAsync(
                    Path.Combine(artifactsDirectory, "pannelli.json"),
                    data.RadiantPanelsJson,
                    cancellationToken);
            }

            if (data.RadiantExecutiveSvg is not null)
            {
                await File.WriteAllBytesAsync(
                    Path.Combine(artifactsDirectory, "pannelli-esecutivo.svg"),
                    data.RadiantExecutiveSvg,
                    cancellationToken);
            }

            if (data.RadiantExecutiveDxf is not null)
            {
                await File.WriteAllBytesAsync(
                    Path.Combine(artifactsDirectory, "pannelli-esecutivo.dxf"),
                    data.RadiantExecutiveDxf,
                    cancellationToken);
            }

            string termodelLog =
                string.Join(Environment.NewLine, data.Diagnostics);

            await File.WriteAllTextAsync(
                Path.Combine(logsDirectory, "diagnostics.txt"),
                termodelLog,
                Utf8WithoutBom,
                cancellationToken);

            await File.WriteAllTextAsync(
                Path.Combine(logsDirectory, "TermodelLog.md"),
                termodelLog,
                Utf8WithoutBom,
                cancellationToken);

            string calculationLog =
                $"projectId={projectId:D}{Environment.NewLine}" +
                $"completedAtUtc={completedAtUtc:O}{Environment.NewLine}" +
                $"status=completed{Environment.NewLine}" +
                $"primitiveCount={data.PrimitiveCount}{Environment.NewLine}" +
                $"radiantPanelCircuitCount={data.RadiantPanelCircuitCount}{Environment.NewLine}" +
                $"radiantExecutivePrimitiveCount={data.RadiantExecutivePrimitiveCount}{Environment.NewLine}" +
                $"radiantExecutiveFloorCount={data.RadiantExecutiveFloorCount}{Environment.NewLine}" +
                $"diagnosticCount={data.Diagnostics.Count}{Environment.NewLine}" +
                $"logEnabled={data.LogEnabled.ToString().ToLowerInvariant()}{Environment.NewLine}" +
                $"logMode={data.LogMode}{Environment.NewLine}" +
                $"logCategories={string.Join(',', data.LogCategories)}{Environment.NewLine}";

            await File.WriteAllTextAsync(
                Path.Combine(logsDirectory, "calculation.log"),
                calculationLog,
                Utf8WithoutBom,
                cancellationToken);

            var state = new ProjectState(
                ArtifactsStale: false,
                LastSavedAtUtc: completedAtUtc,
                LastCalculatedAtUtc: completedAtUtc);

            await File.WriteAllTextAsync(
                Path.Combine(stagingDirectory, "project-state.json"),
                JsonSerializer.Serialize(state, JsonOptions),
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

    private async Task<ProjectState> ReadStateUnlockedAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        string statePath = GetStatePath(projectId);
        if (!File.Exists(statePath))
        {
            string projectPath = GetProjectPath(projectId);
            string modelPath = Path.Combine(
                GetProjectDirectory(projectId),
                "artifacts",
                "model3d.json");

            bool stale = File.Exists(projectPath) &&
                (!File.Exists(modelPath) ||
                 File.GetLastWriteTimeUtc(projectPath) > File.GetLastWriteTimeUtc(modelPath));

            return new ProjectState(stale, null, null);
        }

        try
        {
            await using var stream = new FileStream(
                statePath,
                FileMode.Open,
                FileAccess.Read,
                FileShare.Read);

            ProjectState? state = await JsonSerializer.DeserializeAsync<ProjectState>(
                stream,
                JsonOptions,
                cancellationToken);

            return state ?? new ProjectState(true, null, null);
        }
        catch
        {
            return new ProjectState(true, null, null);
        }
    }

    private static async Task WriteTextAtomicallyAsync(
        string path,
        string content,
        CancellationToken cancellationToken)
    {
        string tempPath = path + $".tmp-{Guid.NewGuid():N}";

        try
        {
            await File.WriteAllTextAsync(
                tempPath,
                content,
                Utf8WithoutBom,
                cancellationToken);

            File.Move(tempPath, path, overwrite: true);
        }
        finally
        {
            if (File.Exists(tempPath))
                File.Delete(tempPath);
        }
    }

    private static async Task WriteJsonAtomicallyAsync<T>(
        string path,
        T value,
        CancellationToken cancellationToken)
    {
        string tempPath = path + $".tmp-{Guid.NewGuid():N}";

        try
        {
            await File.WriteAllTextAsync(
                tempPath,
                JsonSerializer.Serialize(value, JsonOptions),
                Utf8WithoutBom,
                cancellationToken);

            File.Move(tempPath, path, overwrite: true);
        }
        finally
        {
            if (File.Exists(tempPath))
                File.Delete(tempPath);
        }
    }

    private SemaphoreSlim GetGate(Guid projectId) =>
        _projectLocks.GetOrAdd(projectId, static _ => new SemaphoreSlim(1, 1));

    private string GetProjectDirectory(Guid projectId) =>
        Path.Combine(RootDirectory, projectId.ToString("D"));

    private string GetProjectPath(Guid projectId) =>
        Path.Combine(GetProjectDirectory(projectId), "project.tmdl");

    private string GetStatePath(Guid projectId) =>
        Path.Combine(GetProjectDirectory(projectId), "project-state.json");

    private string GetReservationPath(Guid projectId) =>
        Path.Combine(_reservationsDirectory, $"{projectId:D}.reserve");

    private void TryDeleteReservation(Guid projectId)
    {
        string reservationPath = GetReservationPath(projectId);
        try
        {
            if (File.Exists(reservationPath))
                File.Delete(reservationPath);
        }
        catch
        {
            // La directory progetto ormai garantisce l'unicità del projectId.
        }
    }
}

public sealed record ProjectCalculationData(
    byte[] Model3DJson,
    byte[]? RadiantPanelsJson,
    byte[]? RadiantExecutiveSvg,
    byte[]? RadiantExecutiveDxf,
    IReadOnlyList<string> Diagnostics,
    int PrimitiveCount,
    int RadiantPanelCircuitCount,
    int RadiantExecutivePrimitiveCount,
    int RadiantExecutiveFloorCount,
    bool LogEnabled,
    string LogMode,
    IReadOnlyList<string> LogCategories);

public sealed record ProjectListEntry(
    Guid ProjectId,
    string ProjectName,
    DateTime LastWriteTimeUtc,
    bool ArtifactsStale);

public sealed record ProjectState(
    bool ArtifactsStale,
    DateTimeOffset? LastSavedAtUtc,
    DateTimeOffset? LastCalculatedAtUtc);
