using System.Collections.Concurrent;
using System.Globalization;
using System.Text;
using System.Text.Json;

namespace Termodel.WebService.Projects;

public sealed class ProjectLockManager : IDisposable
{
    public const string LockHeaderName = "X-Termodel-Project-Lock";

    private static readonly UTF8Encoding Utf8WithoutBom = new(false);
    private readonly ConcurrentDictionary<Guid, SemaphoreSlim> _gates = new();
    private readonly ConcurrentDictionary<Guid, ProjectLockEntry> _active = new();
    private readonly ProjectStore _projects;
    private readonly string _locksDirectory;
    private readonly Guid _serviceInstanceId = Guid.NewGuid();
    private readonly TimeSpan _leaseDuration;
    private bool _disposed;

    public ProjectLockManager(ProjectStore projects)
    {
        _projects = projects;
        _locksDirectory = Path.Combine(projects.RootDirectory, ".locks");

        int leaseSeconds = 120;
        string? configured = Environment.GetEnvironmentVariable(
            "TERMODEL_PROJECT_LOCK_LEASE_SECONDS");

        if (int.TryParse(configured, NumberStyles.Integer, CultureInfo.InvariantCulture, out int parsed))
            leaseSeconds = Math.Clamp(parsed, 15, 3600);

        _leaseDuration = TimeSpan.FromSeconds(leaseSeconds);
    }

    public TimeSpan LeaseDuration => _leaseDuration;

    public async Task<ProjectLockLease> AcquireAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        ThrowIfDisposed();

        if (!_projects.IsReserved(projectId))
            throw new ProjectNotFoundException(projectId);

        SemaphoreSlim gate = _gates.GetOrAdd(projectId, static _ => new SemaphoreSlim(1, 1));
        await gate.WaitAsync(cancellationToken);

        try
        {
            DateTimeOffset now = DateTimeOffset.UtcNow;

            if (_active.TryGetValue(projectId, out ProjectLockEntry? existing))
            {
                if (existing.ExpiresAtUtc > now)
                    throw new ProjectLockedException(projectId, existing.ExpiresAtUtc);

                ReleaseEntry(projectId, existing);
            }

            Directory.CreateDirectory(_locksDirectory);
            string lockPath = GetLockPath(projectId);

            while (true)
            {
                cancellationToken.ThrowIfCancellationRequested();

                FileStream stream;
                try
                {
                    stream = new FileStream(
                        lockPath,
                        FileMode.CreateNew,
                        FileAccess.ReadWrite,
                        FileShare.Read,
                        bufferSize: 4096,
                        useAsync: true);
                }
                catch (IOException) when (File.Exists(lockPath))
                {
                    // Un file lock rimasto dopo crash/riavvio è eliminabile.
                    // Un lock realmente posseduto da un altro processo Windows
                    // mantiene invece il file aperto senza FileShare.Delete.
                    try
                    {
                        File.Delete(lockPath);
                        continue;
                    }
                    catch (IOException)
                    {
                        ProjectLockMetadata? metadata =
                            await TryReadMetadataAsync(lockPath, cancellationToken);

                        throw new ProjectLockedException(
                            projectId,
                            metadata?.ExpiresAtUtc);
                    }
                    catch (UnauthorizedAccessException)
                    {
                        throw new ProjectLockedException(projectId, null);
                    }
                }

                Guid token = Guid.NewGuid();
                DateTimeOffset openedAtUtc = now;
                DateTimeOffset expiresAtUtc = now + _leaseDuration;

                var entry = new ProjectLockEntry(
                    token,
                    stream,
                    openedAtUtc,
                    now,
                    expiresAtUtc);

                try
                {
                    await WriteMetadataAsync(
                        projectId,
                        entry,
                        cancellationToken);

                    if (!_active.TryAdd(projectId, entry))
                        throw new InvalidOperationException(
                            $"Impossibile registrare il lock del progetto '{projectId:D}'.");

                    return ToLease(projectId, entry);
                }
                catch
                {
                    stream.Dispose();
                    TryDeleteLockFile(lockPath);
                    throw;
                }
            }
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task<ProjectLockLease> ValidateAndRenewAsync(
        Guid projectId,
        Guid token,
        CancellationToken cancellationToken)
    {
        ThrowIfDisposed();

        SemaphoreSlim gate = _gates.GetOrAdd(projectId, static _ => new SemaphoreSlim(1, 1));
        await gate.WaitAsync(cancellationToken);

        try
        {
            if (!_active.TryGetValue(projectId, out ProjectLockEntry? entry) ||
                entry.Token != token)
            {
                throw new ProjectLockRequiredException(projectId);
            }

            DateTimeOffset now = DateTimeOffset.UtcNow;
            if (entry.ExpiresAtUtc <= now)
            {
                ReleaseEntry(projectId, entry);
                throw new ProjectLockRequiredException(
                    projectId,
                    "Il lock del progetto è scaduto. Riaprire il progetto.");
            }

            entry.LastActivityUtc = now;
            entry.ExpiresAtUtc = now + _leaseDuration;
            await WriteMetadataAsync(projectId, entry, cancellationToken);
            return ToLease(projectId, entry);
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task ReleaseAsync(
        Guid projectId,
        Guid token,
        CancellationToken cancellationToken)
    {
        ThrowIfDisposed();

        SemaphoreSlim gate = _gates.GetOrAdd(projectId, static _ => new SemaphoreSlim(1, 1));
        await gate.WaitAsync(cancellationToken);

        try
        {
            if (!_active.TryGetValue(projectId, out ProjectLockEntry? entry) ||
                entry.Token != token)
            {
                throw new ProjectLockRequiredException(projectId);
            }

            ReleaseEntry(projectId, entry);
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task<ProjectUnlockResult> UnlockAsync(
        Guid projectId,
        bool force,
        CancellationToken cancellationToken)
    {
        ThrowIfDisposed();

        SemaphoreSlim gate = _gates.GetOrAdd(projectId, static _ => new SemaphoreSlim(1, 1));
        await gate.WaitAsync(cancellationToken);

        try
        {
            DateTimeOffset now = DateTimeOffset.UtcNow;

            if (_active.TryGetValue(projectId, out ProjectLockEntry? entry))
            {
                if (entry.ExpiresAtUtc > now && !force)
                {
                    return new ProjectUnlockResult(
                        Unlocked: false,
                        WasActive: true,
                        RequiredForce: true);
                }

                ReleaseEntry(projectId, entry);
                return new ProjectUnlockResult(
                    Unlocked: true,
                    WasActive: entry.ExpiresAtUtc > now,
                    RequiredForce: false);
            }

            string lockPath = GetLockPath(projectId);
            if (!File.Exists(lockPath))
            {
                return new ProjectUnlockResult(
                    Unlocked: true,
                    WasActive: false,
                    RequiredForce: false);
            }

            try
            {
                File.Delete(lockPath);
                return new ProjectUnlockResult(
                    Unlocked: true,
                    WasActive: false,
                    RequiredForce: false);
            }
            catch (IOException)
            {
                return new ProjectUnlockResult(
                    Unlocked: false,
                    WasActive: true,
                    RequiredForce: true);
            }
            catch (UnauthorizedAccessException)
            {
                return new ProjectUnlockResult(
                    Unlocked: false,
                    WasActive: true,
                    RequiredForce: true);
            }
        }
        finally
        {
            gate.Release();
        }
    }

    public async Task<bool> IsLockedAsync(
        Guid projectId,
        CancellationToken cancellationToken)
    {
        ThrowIfDisposed();

        SemaphoreSlim gate = _gates.GetOrAdd(projectId, static _ => new SemaphoreSlim(1, 1));
        await gate.WaitAsync(cancellationToken);

        try
        {
            DateTimeOffset now = DateTimeOffset.UtcNow;

            if (_active.TryGetValue(projectId, out ProjectLockEntry? entry))
            {
                if (entry.ExpiresAtUtc > now)
                    return true;

                ReleaseEntry(projectId, entry);
                return false;
            }

            string lockPath = GetLockPath(projectId);
            if (!File.Exists(lockPath))
                return false;

            try
            {
                File.Delete(lockPath);
                return false;
            }
            catch (IOException)
            {
                return true;
            }
            catch (UnauthorizedAccessException)
            {
                return true;
            }
        }
        finally
        {
            gate.Release();
        }
    }

    public static Guid ReadRequiredToken(HttpRequest request)
    {
        if (!request.Headers.TryGetValue(LockHeaderName, out var values) ||
            !Guid.TryParse(values.ToString(), out Guid token) ||
            token == Guid.Empty)
        {
            throw new ProjectLockRequiredException(
                Guid.Empty,
                $"Header {LockHeaderName} mancante o non valido.");
        }

        return token;
    }

    private async Task WriteMetadataAsync(
        Guid projectId,
        ProjectLockEntry entry,
        CancellationToken cancellationToken)
    {
        var metadata = new ProjectLockMetadata(
            projectId,
            entry.Token,
            _serviceInstanceId,
            entry.OpenedAtUtc,
            entry.LastActivityUtc,
            entry.ExpiresAtUtc);

        byte[] json = JsonSerializer.SerializeToUtf8Bytes(
            metadata,
            new JsonSerializerOptions(JsonSerializerDefaults.Web)
            {
                WriteIndented = true
            });

        entry.Stream.Position = 0;
        entry.Stream.SetLength(0);
        await entry.Stream.WriteAsync(json, cancellationToken);
        await entry.Stream.FlushAsync(cancellationToken);
    }

    private static async Task<ProjectLockMetadata?> TryReadMetadataAsync(
        string lockPath,
        CancellationToken cancellationToken)
    {
        try
        {
            await using var stream = new FileStream(
                lockPath,
                FileMode.Open,
                FileAccess.Read,
                FileShare.ReadWrite);

            return await JsonSerializer.DeserializeAsync<ProjectLockMetadata>(
                stream,
                cancellationToken: cancellationToken);
        }
        catch
        {
            return null;
        }
    }

    private ProjectLockLease ToLease(Guid projectId, ProjectLockEntry entry) =>
        new(projectId, entry.Token, entry.OpenedAtUtc, entry.ExpiresAtUtc);

    private void ReleaseEntry(Guid projectId, ProjectLockEntry entry)
    {
        _active.TryRemove(projectId, out _);
        entry.Stream.Dispose();
        TryDeleteLockFile(GetLockPath(projectId));
    }

    private string GetLockPath(Guid projectId) =>
        Path.Combine(_locksDirectory, $"{projectId:D}.lock");

    private static void TryDeleteLockFile(string path)
    {
        try
        {
            if (File.Exists(path))
                File.Delete(path);
        }
        catch
        {
            // Il rilascio in memoria non deve cancellare o corrompere il progetto.
            // Un eventuale lock file residuo verrà recuperato alla prossima apertura.
        }
    }

    private void ThrowIfDisposed()
    {
        if (_disposed)\n            throw new ObjectDisposedException(nameof(ProjectLockManager));
    }

    public void Dispose()
    {
        if (_disposed)
            return;

        _disposed = true;

        foreach ((Guid projectId, ProjectLockEntry entry) in _active.ToArray())
            ReleaseEntry(projectId, entry);
    }

    private sealed class ProjectLockEntry(
        Guid token,
        FileStream stream,
        DateTimeOffset openedAtUtc,
        DateTimeOffset lastActivityUtc,
        DateTimeOffset expiresAtUtc)
    {
        public Guid Token { get; } = token;
        public FileStream Stream { get; } = stream;
        public DateTimeOffset OpenedAtUtc { get; } = openedAtUtc;
        public DateTimeOffset LastActivityUtc { get; set; } = lastActivityUtc;
        public DateTimeOffset ExpiresAtUtc { get; set; } = expiresAtUtc;
    }
}

public sealed record ProjectLockLease(
    Guid ProjectId,
    Guid Token,
    DateTimeOffset OpenedAtUtc,
    DateTimeOffset ExpiresAtUtc);

public sealed record ProjectUnlockResult(
    bool Unlocked,
    bool WasActive,
    bool RequiredForce);

public sealed record ProjectLockMetadata(
    Guid ProjectId,
    Guid Token,
    Guid ServiceInstanceId,
    DateTimeOffset OpenedAtUtc,
    DateTimeOffset LastActivityUtc,
    DateTimeOffset ExpiresAtUtc);

public sealed class ProjectLockedException(
    Guid projectId,
    DateTimeOffset? expiresAtUtc = null)
    : Exception($"Il progetto '{projectId:D}' è già in uso.")
{
    public Guid ProjectId { get; } = projectId;
    public DateTimeOffset? ExpiresAtUtc { get; } = expiresAtUtc;
}

public sealed class ProjectLockRequiredException : Exception
{
    public ProjectLockRequiredException(Guid projectId, string? message = null)
        : base(message ?? $"Il progetto '{projectId:D}' non è aperto dalla sessione corrente.")
    {
        ProjectId = projectId;
    }

    public Guid ProjectId { get; }
}

public sealed class ProjectNotFoundException(Guid projectId)
    : Exception($"Il progetto '{projectId:D}' non esiste.")
{
    public Guid ProjectId { get; } = projectId;
}
