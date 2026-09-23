using System.Net;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json;
using Termodel.WebService.Projects;

namespace Termodel.WebService.Snapshots;

public sealed class SnapshotOptions
{
    public SnapshotOptions()
    {
        GitHubToken =
            Environment.GetEnvironmentVariable("TERMODEL_SNAPSHOT_GITHUB_TOKEN")?.Trim()
            ?? string.Empty;
        AdminKey =
            Environment.GetEnvironmentVariable("TERMODEL_SNAPSHOT_ADMIN_KEY")?.Trim()
            ?? string.Empty;
        Repository =
            Environment.GetEnvironmentVariable("TERMODEL_SNAPSHOT_REPOSITORY")?.Trim()
            ?? "Fetonte1960/Termodel";
        Branch =
            Environment.GetEnvironmentVariable("TERMODEL_SNAPSHOT_BRANCH")?.Trim()
            ?? "service-snapshots";
        BaseBranch =
            Environment.GetEnvironmentVariable("TERMODEL_SNAPSHOT_BASE_BRANCH")?.Trim()
            ?? "main";
        GitHubApiBaseUrl =
            Environment.GetEnvironmentVariable("TERMODEL_SNAPSHOT_GITHUB_API_BASE_URL")?.Trim()
            ?? "https://api.github.com";
        RootPath =
            Environment.GetEnvironmentVariable("TERMODEL_SNAPSHOT_ROOT")?.Trim().Trim('/')
            ?? "service-snapshots";
    }

    public string GitHubToken { get; }
    public string AdminKey { get; }
    public string Repository { get; }
    public string Branch { get; }
    public string BaseBranch { get; }
    public string GitHubApiBaseUrl { get; }
    public string RootPath { get; }

    public bool IsConfigured =>
        GitHubToken.Length > 0 &&
        AdminKey.Length >= 12 &&
        Repository.Split('/', StringSplitOptions.RemoveEmptyEntries).Length == 2 &&
        Branch.Length > 0 &&
        BaseBranch.Length > 0 &&
        RootPath.Length > 0 &&
        Uri.TryCreate(GitHubApiBaseUrl, UriKind.Absolute, out Uri? apiUri) &&
        (apiUri.Scheme == Uri.UriSchemeHttps ||
         apiUri.IsLoopback && apiUri.Scheme == Uri.UriSchemeHttp);

    public bool IsAuthorized(string? suppliedKey)
    {
        if (AdminKey.Length == 0 || string.IsNullOrEmpty(suppliedKey))
            return false;

        byte[] expected = Encoding.UTF8.GetBytes(AdminKey);
        byte[] supplied = Encoding.UTF8.GetBytes(suppliedKey);
        return expected.Length == supplied.Length &&
               CryptographicOperations.FixedTimeEquals(expected, supplied);
    }
}

public sealed class GitHubSnapshotPublisher(
    HttpClient httpClient,
    SnapshotOptions options,
    ILogger<GitHubSnapshotPublisher> logger)
{
    private const long MaxFileBytes = 20L * 1024 * 1024;
    private const long MaxSnapshotBytes = 50L * 1024 * 1024;
    private readonly SemaphoreSlim _publishGate = new(1, 1);

    public async Task<SnapshotPublishResult> PublishAsync(
        Guid projectId,
        IReadOnlyList<ProjectGeneratedFileContent> files,
        CancellationToken cancellationToken)
    {
        if (!options.IsConfigured)
            throw new SnapshotNotConfiguredException(
                "Il publisher snapshot GitHub non è configurato.");

        if (files.Count == 0)
            throw new SnapshotPublishException(
                "Nessun file generato disponibile da pubblicare.");

        long totalBytes = 0;
        foreach (ProjectGeneratedFileContent file in files)
        {
            if (file.Content.LongLength > MaxFileBytes)
            {
                throw new SnapshotPublishException(
                    $"Il file '{file.RelativePath}' supera il limite snapshot di {MaxFileBytes} byte.");
            }

            totalBytes += file.Content.LongLength;
            if (totalBytes > MaxSnapshotBytes)
            {
                throw new SnapshotPublishException(
                    $"Lo snapshot supera il limite complessivo di {MaxSnapshotBytes} byte.");
            }

            if (!file.RelativePath.StartsWith(
                    "artifacts/",
                    StringComparison.OrdinalIgnoreCase) &&
                !file.RelativePath.StartsWith(
                    "logs/",
                    StringComparison.OrdinalIgnoreCase))
            {
                throw new SnapshotPublishException(
                    $"Il file '{file.RelativePath}' non appartiene a artifacts/ o logs/.");
            }
        }

        await _publishGate.WaitAsync(cancellationToken);
        try
        {
            DateTimeOffset now = DateTimeOffset.UtcNow;
            string snapshotId =
                $"{now:yyyyMMddTHHmmssfffZ}_{projectId.ToString("N")[..8]}";
            string snapshotRoot =
                $"{options.RootPath}/{snapshotId}";

            SnapshotManifest manifest = BuildManifest(
                projectId,
                snapshotId,
                now,
                files);

            var jsonOptions =
                new JsonSerializerOptions(JsonSerializerDefaults.Web)
                {
                    WriteIndented = true
                };

            byte[] manifestBytes = JsonSerializer.SerializeToUtf8Bytes(
                manifest,
                jsonOptions);

            byte[] latestBytes = JsonSerializer.SerializeToUtf8Bytes(
                new
                {
                    format = "TERMODEL-SERVICE-SNAPSHOT-LATEST-V1",
                    snapshotId,
                    projectId,
                    generatedAtUtc = now,
                    rootPath = snapshotRoot
                },
                jsonOptions);

            string headSha = await EnsureBranchAsync(cancellationToken);
            string baseTreeSha = await GetCommitTreeShaAsync(
                headSha,
                cancellationToken);

            var entries = new List<object>(files.Count + 2);

            foreach (ProjectGeneratedFileContent file in files)
            {
                string blobSha = await CreateBlobAsync(
                    file.Content,
                    cancellationToken);

                entries.Add(new
                {
                    path = $"{snapshotRoot}/{file.RelativePath}",
                    mode = "100644",
                    type = "blob",
                    sha = blobSha
                });
            }

            string manifestBlobSha = await CreateBlobAsync(
                manifestBytes,
                cancellationToken);

            entries.Add(new
            {
                path = $"{snapshotRoot}/manifest.json",
                mode = "100644",
                type = "blob",
                sha = manifestBlobSha
            });

            string latestBlobSha = await CreateBlobAsync(
                latestBytes,
                cancellationToken);

            entries.Add(new
            {
                path = $"{options.RootPath}/LATEST.json",
                mode = "100644",
                type = "blob",
                sha = latestBlobSha
            });

            string treeSha = await CreateTreeAsync(
                baseTreeSha,
                entries,
                cancellationToken);

            string commitSha = await CreateCommitAsync(
                projectId,
                snapshotId,
                treeSha,
                headSha,
                cancellationToken);

            await UpdateBranchAsync(
                commitSha,
                cancellationToken);

            string treeUrl =
                $"https://github.com/{options.Repository}/tree/" +
                $"{Uri.EscapeDataString(options.Branch)}/" +
                $"{snapshotRoot}";

            return new SnapshotPublishResult(
                snapshotId,
                options.Repository,
                options.Branch,
                snapshotRoot,
                commitSha,
                files.Count,
                totalBytes,
                treeUrl);
        }
        finally
        {
            _publishGate.Release();
        }
    }

    private SnapshotManifest BuildManifest(
        Guid projectId,
        string snapshotId,
        DateTimeOffset generatedAtUtc,
        IReadOnlyList<ProjectGeneratedFileContent> files)
    {
        string serviceCommit =
            Environment.GetEnvironmentVariable("RENDER_GIT_COMMIT")?.Trim()
            ?? Environment.GetEnvironmentVariable("GITHUB_SHA")?.Trim()
            ?? Environment.GetEnvironmentVariable("SOURCE_VERSION")?.Trim()
            ?? string.Empty;

        SnapshotManifestFile[] manifestFiles = files
            .OrderBy(
                file => file.RelativePath,
                StringComparer.OrdinalIgnoreCase)
            .Select(file => new SnapshotManifestFile(
                file.RelativePath,
                file.FileName,
                file.Category,
                file.ContentType,
                file.Content.LongLength,
                file.LastWriteTimeUtc,
                file.Stale,
                Convert.ToHexString(
                    SHA256.HashData(file.Content))
                    .ToLowerInvariant()))
            .ToArray();

        return new SnapshotManifest(
            "TERMODEL-SERVICE-SNAPSHOT-V1",
            snapshotId,
            projectId,
            generatedAtUtc,
            serviceCommit,
            files.FirstOrDefault()?.Stale ?? false,
            manifestFiles.Length,
            manifestFiles.Sum(file => file.Size),
            manifestFiles);
    }

    private async Task<string> EnsureBranchAsync(
        CancellationToken cancellationToken)
    {
        string branchPath = Uri.EscapeDataString(options.Branch);
        string refPath = RepoPath(
            $"/git/ref/heads/{branchPath}");

        using HttpResponseMessage existing =
            await SendAsync(
                HttpMethod.Get,
                refPath,
                content: null,
                cancellationToken);

        if (existing.IsSuccessStatusCode)
            return await ReadNestedShaAsync(existing, "object", cancellationToken);

        if (existing.StatusCode != HttpStatusCode.NotFound)
            await ThrowGitHubErrorAsync(existing, "lettura branch snapshot", cancellationToken);

        using HttpResponseMessage baseRef =
            await SendAsync(
                HttpMethod.Get,
                RepoPath(
                    $"/git/ref/heads/{Uri.EscapeDataString(options.BaseBranch)}"),
                content: null,
                cancellationToken);

        if (!baseRef.IsSuccessStatusCode)
            await ThrowGitHubErrorAsync(baseRef, "lettura branch base", cancellationToken);

        string baseSha =
            await ReadNestedShaAsync(baseRef, "object", cancellationToken);

        using HttpResponseMessage create =
            await SendAsync(
                HttpMethod.Post,
                RepoPath("/git/refs"),
                JsonContent.Create(new
                {
                    @ref = $"refs/heads/{options.Branch}",
                    sha = baseSha
                }),
                cancellationToken);

        if (!create.IsSuccessStatusCode)
            await ThrowGitHubErrorAsync(create, "creazione branch snapshot", cancellationToken);

        return baseSha;
    }

    private async Task<string> GetCommitTreeShaAsync(
        string commitSha,
        CancellationToken cancellationToken)
    {
        using HttpResponseMessage response =
            await SendAsync(
                HttpMethod.Get,
                RepoPath(
                    $"/git/commits/{Uri.EscapeDataString(commitSha)}"),
                content: null,
                cancellationToken);

        if (!response.IsSuccessStatusCode)
            await ThrowGitHubErrorAsync(response, "lettura commit base", cancellationToken);

        return await ReadNestedShaAsync(
            response,
            "tree",
            cancellationToken);
    }

    private async Task<string> CreateBlobAsync(
        byte[] content,
        CancellationToken cancellationToken)
    {
        using HttpResponseMessage response =
            await SendAsync(
                HttpMethod.Post,
                RepoPath("/git/blobs"),
                JsonContent.Create(new
                {
                    content = Convert.ToBase64String(content),
                    encoding = "base64"
                }),
                cancellationToken);

        if (!response.IsSuccessStatusCode)
            await ThrowGitHubErrorAsync(response, "creazione blob snapshot", cancellationToken);

        return await ReadShaAsync(response, cancellationToken);
    }

    private async Task<string> CreateTreeAsync(
        string baseTreeSha,
        IReadOnlyList<object> entries,
        CancellationToken cancellationToken)
    {
        using HttpResponseMessage response =
            await SendAsync(
                HttpMethod.Post,
                RepoPath("/git/trees"),
                JsonContent.Create(new
                {
                    base_tree = baseTreeSha,
                    tree = entries
                }),
                cancellationToken);

        if (!response.IsSuccessStatusCode)
            await ThrowGitHubErrorAsync(response, "creazione tree snapshot", cancellationToken);

        return await ReadShaAsync(response, cancellationToken);
    }

    private async Task<string> CreateCommitAsync(
        Guid projectId,
        string snapshotId,
        string treeSha,
        string parentSha,
        CancellationToken cancellationToken)
    {
        using HttpResponseMessage response =
            await SendAsync(
                HttpMethod.Post,
                RepoPath("/git/commits"),
                JsonContent.Create(new
                {
                    message =
                        $"Service snapshot {snapshotId} for project {projectId:D}",
                    tree = treeSha,
                    parents = new[] { parentSha }
                }),
                cancellationToken);

        if (!response.IsSuccessStatusCode)
            await ThrowGitHubErrorAsync(response, "creazione commit snapshot", cancellationToken);

        return await ReadShaAsync(response, cancellationToken);
    }

    private async Task UpdateBranchAsync(
        string commitSha,
        CancellationToken cancellationToken)
    {
        using HttpResponseMessage response =
            await SendAsync(
                HttpMethod.Patch,
                RepoPath(
                    $"/git/refs/heads/{Uri.EscapeDataString(options.Branch)}"),
                JsonContent.Create(new
                {
                    sha = commitSha,
                    force = false
                }),
                cancellationToken);

        if (!response.IsSuccessStatusCode)
            await ThrowGitHubErrorAsync(response, "aggiornamento branch snapshot", cancellationToken);
    }

    private string RepoPath(string suffix)
    {
        string[] repositoryParts =
            options.Repository.Split(
                '/',
                StringSplitOptions.RemoveEmptyEntries);

        return
            $"/repos/{Uri.EscapeDataString(repositoryParts[0])}/" +
            $"{Uri.EscapeDataString(repositoryParts[1])}{suffix}";
    }

    private async Task<HttpResponseMessage> SendAsync(
        HttpMethod method,
        string path,
        HttpContent? content,
        CancellationToken cancellationToken)
    {
        string requestUrl =
            options.GitHubApiBaseUrl.TrimEnd('/') + path;

        using var request = new HttpRequestMessage(method, requestUrl)
        {
            Content = content
        };

        request.Headers.Authorization =
            new AuthenticationHeaderValue(
                "Bearer",
                options.GitHubToken);
        request.Headers.UserAgent.ParseAdd(
            "Termodel-WebService-Snapshot/1.0");
        request.Headers.Accept.ParseAdd(
            "application/vnd.github+json");
        request.Headers.TryAddWithoutValidation(
            "X-GitHub-Api-Version",
            "2022-11-28");

        try
        {
            return await httpClient.SendAsync(
                request,
                HttpCompletionOption.ResponseHeadersRead,
                cancellationToken);
        }
        catch (Exception exception) when (
            exception is HttpRequestException or
            TaskCanceledException)
        {
            logger.LogWarning(
                exception,
                "GitHub snapshot endpoint could not be reached.");

            throw new SnapshotPublishException(
                "Impossibile raggiungere GitHub per pubblicare lo snapshot.");
        }
    }

    private static async Task<string> ReadShaAsync(
        HttpResponseMessage response,
        CancellationToken cancellationToken)
    {
        using JsonDocument document =
            JsonDocument.Parse(
                await response.Content.ReadAsStringAsync(
                    cancellationToken));

        string sha =
            document.RootElement.GetProperty("sha").GetString()
            ?? string.Empty;

        if (sha.Length == 0)
            throw new SnapshotPublishException(
                "Risposta GitHub priva di SHA.");

        return sha;
    }

    private static async Task<string> ReadNestedShaAsync(
        HttpResponseMessage response,
        string property,
        CancellationToken cancellationToken)
    {
        using JsonDocument document =
            JsonDocument.Parse(
                await response.Content.ReadAsStringAsync(
                    cancellationToken));

        string sha =
            document.RootElement
                .GetProperty(property)
                .GetProperty("sha")
                .GetString()
            ?? string.Empty;

        if (sha.Length == 0)
            throw new SnapshotPublishException(
                "Risposta GitHub priva di SHA.");

        return sha;
    }

    private async Task ThrowGitHubErrorAsync(
        HttpResponseMessage response,
        string operation,
        CancellationToken cancellationToken)
    {
        string responseText =
            await response.Content.ReadAsStringAsync(
                cancellationToken);

        logger.LogWarning(
            "GitHub snapshot {Operation} failed with status {StatusCode}. Response: {Response}",
            operation,
            (int)response.StatusCode,
            responseText.Length <= 1200
                ? responseText
                : responseText[..1200]);

        throw new SnapshotPublishException(
            $"GitHub non ha completato {operation} (HTTP {(int)response.StatusCode}).");
    }
}

public sealed record SnapshotPublishResult(
    string SnapshotId,
    string Repository,
    string Branch,
    string RootPath,
    string CommitSha,
    int FileCount,
    long TotalBytes,
    string TreeUrl);

public sealed record SnapshotManifest(
    string Format,
    string SnapshotId,
    Guid ProjectId,
    DateTimeOffset GeneratedAtUtc,
    string ServiceCommit,
    bool ArtifactsStale,
    int FileCount,
    long TotalBytes,
    IReadOnlyList<SnapshotManifestFile> Files);

public sealed record SnapshotManifestFile(
    string Path,
    string FileName,
    string Category,
    string ContentType,
    long Size,
    DateTime LastWriteTimeUtc,
    bool Stale,
    string Sha256);

public sealed class SnapshotNotConfiguredException(string message)
    : Exception(message);

public sealed class SnapshotPublishException(string message)
    : Exception(message);
