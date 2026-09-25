using System.Text;
using System.Text.Json;
using Termodel.Core;
using Termodel.Core.Cad;
using Termodel.Core.ProjectFiles;
using Termodel.Core.RadiantPanels;
using Termodel.Leggidxf;
using Termodel.utilities;
using Termodel.WebService.Projects;
using Termodel.WebService.Feedback;
using Termodel.WebService.Snapshots;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<ProjectStore>();
builder.Services.AddSingleton<ProjectLockManager>();
builder.Services.AddSingleton<FeedbackOptions>();
builder.Services.AddSingleton<FeedbackRateLimiter>();
builder.Services.AddHttpClient<GitHubFeedbackPublisher>(client =>
{
    client.Timeout = TimeSpan.FromSeconds(15);
});
builder.Services.AddSingleton<SnapshotOptions>();
builder.Services.AddHttpClient<GitHubSnapshotPublisher>(client =>
{
    client.Timeout = TimeSpan.FromSeconds(30);
});

const string TermodelWebCorsPolicy = "TermodelWeb";

// Modificato da Codex per realizzare: consentire al frontend pubblico Termodel Web di chiamare il WebService locale con preflight CORS esplicito.
builder.Services.AddCors(options =>
{
    options.AddPolicy(TermodelWebCorsPolicy, policy =>
    {
        policy
            .WithOrigins("https://www.termodel.it")
            .WithMethods("GET", "POST", "PUT", "OPTIONS")
            .AllowAnyHeader()
            .SetPreflightMaxAge(TimeSpan.FromHours(1));
    });
});

var app = builder.Build();

// Funzione realizzata da Codex in autonomia
app.Use(async (context, next) =>
{
    bool isAllowedOrigin = string.Equals(
        context.Request.Headers.Origin,
        "https://www.termodel.it",
        StringComparison.OrdinalIgnoreCase);
    bool requestsPrivateNetwork = string.Equals(
        context.Request.Headers["Access-Control-Request-Private-Network"],
        "true",
        StringComparison.OrdinalIgnoreCase);

    if (HttpMethods.IsOptions(context.Request.Method) && isAllowedOrigin && requestsPrivateNetwork)
        context.Response.Headers["Access-Control-Allow-Private-Network"] = "true";

    await next();
});

app.UseCors(TermodelWebCorsPolicy);

string definitionPath = Path.Combine(
    AppContext.BaseDirectory,
    "Definitions",
    "definizionedati.json");

string baseProjectPath = Path.Combine(
    AppContext.BaseDirectory,
    "Templates",
    "ProgettoBase");

// Funzione realizzata da Codex in autonomia
app.MapGet("/", () => Results.Ok(new
{
    service = "Termodel WebService",
    status = "experimental"
}));

// Funzione realizzata da Codex in autonomia
app.MapGet("/health", () =>
{
    string serviceCommit = ServiceRuntimeInfo.ResolveCommit();
    return Results.Ok(new
    {
        status = "ok",
        serviceCommit,
        serviceCommitShort = ServiceRuntimeInfo.ShortCommit(serviceCommit),
        spiralEngine = RadiantExecutiveGenerator.GetSelectedSpiralEngineName()
    });
});

// Funzione realizzata da Codex in autonomia
app.MapGet("/api/model/capabilities", () => Results.Ok(CoreInformation.GetCapabilities()));


// Conversione DXF ASCII 2D -> SVG di sfondo. La logica vive nel Core;
 // il WebService espone soltanto il contratto HTTP.
app.MapPost("/api/dxf/to-svg", (DxfToSvgRequest request) =>
{
    try
    {
        if (string.IsNullOrWhiteSpace(request.DxfText))
        {
            return Results.Problem(
                title: "DXF non valido",
                detail: "Il contenuto DXF è vuoto.",
                statusCode: StatusCodes.Status422UnprocessableEntity);
        }

        DxfSvgConversionResult result = DxfSvgConverter.Convert(
            request.DxfText,
            new DxfSvgConversionOptions(
                request.Layers,
                request.Unit,
                request.Curves,
                request.ConvertText,
                request.ExplodeBlocks,
                request.Profile));

        return Results.Json(result);
    }
    catch (InvalidDataException exception)
    {
        return Results.Problem(
            title: "DXF non convertibile",
            detail: exception.Message,
            statusCode: StatusCodes.Status422UnprocessableEntity);
    }
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/feedback", async (
    UserFeedbackRequest request,
    HttpContext context,
    FeedbackOptions feedbackOptions,
    FeedbackRateLimiter feedbackRateLimiter,
    GitHubFeedbackPublisher feedbackPublisher,
    CancellationToken cancellationToken) =>
{
    string origin = context.Request.Headers.Origin.ToString();

    if (!string.Equals(
        origin,
        feedbackOptions.AllowedOrigin,
        StringComparison.OrdinalIgnoreCase))
    {
        return Results.Problem(
            title: "Origine non autorizzata",
            detail: "I suggerimenti possono essere inviati soltanto dall'applicazione Termodel autorizzata.",
            statusCode: StatusCodes.Status403Forbidden);
    }

    if (!UserFeedbackSubmission.TryCreate(
        request,
        out UserFeedbackSubmission? feedback,
        out Dictionary<string, string[]> errors) ||
        feedback is null)
    {
        return Results.ValidationProblem(errors);
    }

    string clientKey = FeedbackClientKey(context);
    if (!feedbackRateLimiter.TryConsume(
        clientKey,
        out int retryAfterSeconds))
    {
        context.Response.Headers.RetryAfter =
            retryAfterSeconds.ToString(System.Globalization.CultureInfo.InvariantCulture);

        return Results.Problem(
            title: "Troppi suggerimenti inviati",
            detail: "Attendere prima di inviare un nuovo suggerimento.",
            statusCode: StatusCodes.Status429TooManyRequests);
    }

    try
    {
        GitHubIssueResult issue = await feedbackPublisher.PublishAsync(
            feedback,
            cancellationToken);

        return Results.Json(
            new
            {
                status = "created",
                issueNumber = issue.IssueNumber,
                issueUrl = issue.IssueUrl
            },
            statusCode: StatusCodes.Status201Created);
    }
    catch (FeedbackNotConfiguredException exception)
    {
        return Results.Problem(
            title: "Servizio suggerimenti non configurato",
            detail: exception.Message,
            statusCode: StatusCodes.Status503ServiceUnavailable);
    }
    catch (FeedbackPublishException exception)
    {
        return Results.Problem(
            title: "GitHub temporaneamente non disponibile",
            detail: exception.Message,
            statusCode: StatusCodes.Status502BadGateway);
    }
});

// Pubblicazione amministrativa dello snapshot diagnostico corrente su GitHub.
app.MapPost(
    "/api/projects/{projectId:guid}/publish-session-snapshot",
    async (
        Guid projectId,
        HttpContext context,
        ProjectStore projects,
        SnapshotOptions snapshotOptions,
        GitHubSnapshotPublisher snapshotPublisher,
        CancellationToken cancellationToken) =>
{
    if (!snapshotOptions.IsConfigured)
    {
        return Results.Problem(
            title: "Publisher snapshot non configurato",
            detail:
                "Configurare TERMODEL_SNAPSHOT_GITHUB_TOKEN e " +
                "TERMODEL_SNAPSHOT_ADMIN_KEY sul server.",
            statusCode: StatusCodes.Status503ServiceUnavailable);
    }

    string suppliedKey =
        context.Request.Headers["X-Termodel-Snapshot-Key"].ToString();

    if (!snapshotOptions.IsAuthorized(suppliedKey))
    {
        return Results.Problem(
            title: "Pubblicazione snapshot non autorizzata",
            detail: "Chiave amministrativa snapshot non valida.",
            statusCode: StatusCodes.Status403Forbidden);
    }

    if (!projects.HasProjectWorkspace(projectId))
    {
        return Results.Problem(
            title: "Progetto non disponibile",
            detail:
                $"Il projectId '{projectId:D}' non dispone di un workspace corrente.",
            statusCode: StatusCodes.Status404NotFound);
    }

    IReadOnlyList<ProjectGeneratedFileContent> files =
        await projects.ReadGeneratedFilesSnapshotAsync(
            projectId,
            cancellationToken);

    if (files.Count == 0)
    {
        return Results.Problem(
            title: "Nessun file generato",
            detail:
                "Il progetto non dispone ancora di artifacts/logs da pubblicare.",
            statusCode: StatusCodes.Status409Conflict);
    }

    try
    {
        SnapshotPublishResult published =
            await snapshotPublisher.PublishAsync(
                projectId,
                files,
                cancellationToken);

        return Results.Json(
            new
            {
                status = "published",
                projectId,
                snapshotId = published.SnapshotId,
                repository = published.Repository,
                branch = published.Branch,
                rootPath = published.RootPath,
                commitSha = published.CommitSha,
                fileCount = published.FileCount,
                totalBytes = published.TotalBytes,
                treeUrl = published.TreeUrl
            },
            statusCode: StatusCodes.Status201Created);
    }
    catch (SnapshotNotConfiguredException exception)
    {
        return Results.Problem(
            title: "Publisher snapshot non configurato",
            detail: exception.Message,
            statusCode: StatusCodes.Status503ServiceUnavailable);
    }
    catch (SnapshotPublishException exception)
    {
        return Results.Problem(
            title: "Pubblicazione snapshot fallita",
            detail: exception.Message,
            statusCode: StatusCodes.Status502BadGateway);
    }
});

// Funzione realizzata da Codex in autonomia
app.MapGet("/api/projects", async (
    ProjectStore projects,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    IReadOnlyList<ProjectListEntry> stored =
        await projects.ListProjectsAsync(cancellationToken);

    var result = new List<object>(stored.Count);
    foreach (ProjectListEntry project in stored)
    {
        bool locked = await projectLocks.IsLockedAsync(
            project.ProjectId,
            cancellationToken);

        result.Add(new
        {
            projectId = project.ProjectId,
            projectName = project.ProjectName,
            lastWriteTimeUtc = project.LastWriteTimeUtc,
            artifactsStale = project.ArtifactsStale,
            locked
        });
    }

    return Results.Json(new
    {
        contractVersion = "TERMODEL-FRONT-SERVICE-V1",
        projects = result
    });
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/projects/allocate-id", async (
    ProjectStore projects,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    Guid projectId = await projects.AllocateProjectIdAsync(cancellationToken);
    ProjectLockLease lease = await projectLocks.AcquireAsync(
        projectId,
        cancellationToken);

    return Results.Ok(new
    {
        contractVersion = "TERMODEL-FRONT-SERVICE-V1",
        projectId,
        projectLockToken = lease.Token,
        leaseExpiresAtUtc = lease.ExpiresAtUtc
    });
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/projects/{projectId:guid}/open", async (
    Guid projectId,
    ProjectStore projects,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    ProjectLockLease? lease = null;

    try
    {
        lease = await projectLocks.AcquireAsync(projectId, cancellationToken);

        string? projectText = await projects.ReadProjectAsync(
            projectId,
            cancellationToken);

        if (projectText is null)
        {
            await projectLocks.ReleaseAsync(
                projectId,
                lease.Token,
                cancellationToken);

            return Results.Problem(
                title: "Progetto non disponibile",
                detail: $"Il progetto '{projectId:D}' non contiene project.tmdl.",
                statusCode: StatusCodes.Status404NotFound);
        }

        bool artifactsStale =
            await projects.AreArtifactsStaleAsync(projectId, cancellationToken);

        return Results.Json(new
        {
            contractVersion = "TERMODEL-FRONT-SERVICE-V1",
            projectId,
            projectName = ProjectRequestIdentity.ReadProjectName(projectText),
            projectLockToken = lease.Token,
            leaseExpiresAtUtc = lease.ExpiresAtUtc,
            artifactsStale,
            projectText
        });
    }
    catch (ProjectNotFoundException exception)
    {
        return Results.Problem(
            title: "Progetto non disponibile",
            detail: exception.Message,
            statusCode: StatusCodes.Status404NotFound);
    }
    catch (ProjectLockedException exception)
    {
        return Results.Problem(
            title: "Il progetto è già in uso",
            detail: exception.Message,
            statusCode: 423);
    }
    catch
    {
        if (lease is not null)
        {
            try
            {
                await projectLocks.ReleaseAsync(
                    projectId,
                    lease.Token,
                    cancellationToken);
            }
            catch
            {
                // Il recovery del lock residuo è demandato al lock manager.
            }
        }

        throw;
    }
});

// Funzione realizzata da Codex in autonomia
app.MapPut("/api/projects/{projectId:guid}/save", async (
    Guid projectId,
    HttpRequest request,
    ProjectStore projects,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    if (!IsTextProjectRequest(request))
        return UnsupportedProjectContentType();

    try
    {
        Guid lockToken = ProjectLockManager.ReadRequiredToken(request);
        ProjectLockLease lease = await projectLocks.ValidateAndRenewAsync(
            projectId,
            lockToken,
            cancellationToken);

        string projectText = await ReadProjectTextAsync(request, cancellationToken);
        EnsureRouteProjectId(projectId, projectText);

        await projects.SaveProjectAsync(
            projectId,
            projectText,
            cancellationToken);

        return Results.Json(new
        {
            contractVersion = "TERMODEL-FRONT-SERVICE-V1",
            projectId,
            projectName = ProjectRequestIdentity.ReadProjectName(projectText),
            status = "saved",
            artifactsStale = true,
            leaseExpiresAtUtc = lease.ExpiresAtUtc
        });
    }
    catch (InvalidDataException exception)
    {
        return InvalidProjectProblem(exception.Message);
    }
});

// Funzione realizzata da Codex in autonomia
app.MapPut("/api/projects/{projectId:guid}/save-as", async (
    Guid projectId,
    string projectName,
    HttpRequest request,
    ProjectStore projects,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    if (!IsTextProjectRequest(request))
        return UnsupportedProjectContentType();

    try
    {
        Guid lockToken = ProjectLockManager.ReadRequiredToken(request);
        ProjectLockLease lease = await projectLocks.ValidateAndRenewAsync(
            projectId,
            lockToken,
            cancellationToken);

        string projectText = await ReadProjectTextAsync(request, cancellationToken);
        EnsureRouteProjectId(projectId, projectText);

        string renamedProject =
            ProjectRequestIdentity.SetProjectName(projectText, projectName);

        EnsureRouteProjectId(projectId, renamedProject);

        await projects.SaveProjectAsync(
            projectId,
            renamedProject,
            cancellationToken);

        return Results.Json(new
        {
            contractVersion = "TERMODEL-FRONT-SERVICE-V1",
            projectId,
            projectName = ProjectRequestIdentity.ReadProjectName(renamedProject),
            status = "saved",
            artifactsStale = true,
            leaseExpiresAtUtc = lease.ExpiresAtUtc
        });
    }
    catch (ProjectLockRequiredException exception)
    {
        return LockedProblem(exception.Message);
    }
    catch (InvalidDataException exception)
    {
        return InvalidProjectProblem(exception.Message);
    }
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/projects/{projectId:guid}/heartbeat", async (
    Guid projectId,
    HttpRequest request,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    try
    {
        Guid lockToken = ProjectLockManager.ReadRequiredToken(request);
        ProjectLockLease lease = await projectLocks.ValidateAndRenewAsync(
            projectId,
            lockToken,
            cancellationToken);

        return Results.Ok(new
        {
            contractVersion = "TERMODEL-FRONT-SERVICE-V1",
            projectId,
            status = "locked",
            leaseExpiresAtUtc = lease.ExpiresAtUtc
        });
    }
    catch (ProjectLockRequiredException exception)
    {
        return LockedProblem(exception.Message);
    }
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/projects/{projectId:guid}/close", async (
    Guid projectId,
    HttpRequest request,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    try
    {
        Guid lockToken = ProjectLockManager.ReadRequiredToken(request);
        await projectLocks.ReleaseAsync(
            projectId,
            lockToken,
            cancellationToken);

        return Results.Ok(new
        {
            contractVersion = "TERMODEL-FRONT-SERVICE-V1",
            projectId,
            status = "closed"
        });
    }
    catch (ProjectLockRequiredException exception)
    {
        return LockedProblem(exception.Message);
    }
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/projects/{projectId:guid}/unlock", async (
    Guid projectId,
    bool? force,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    ProjectUnlockResult result = await projectLocks.UnlockAsync(
        projectId,
        force ?? false,
        cancellationToken);

    if (!result.Unlocked)
    {
        return Results.Problem(
            title: "Conferma sblocco richiesta",
            detail: result.WasActive
                ? "Il progetto risulta ancora in uso. Ripetere lo sblocco con force=true soltanto dopo conferma esplicita dell'utente."
                : "Il lock del progetto non può essere rimosso in questo momento.",
            statusCode: result.RequiredForce ? StatusCodes.Status409Conflict : 423);
    }

    return Results.Ok(new
    {
        contractVersion = "TERMODEL-FRONT-SERVICE-V1",
        projectId,
        status = "unlocked",
        forced = force ?? false
    });
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/calculations", async (
    HttpRequest request,
    HttpResponse response,
    ProjectStore projects,
    CancellationToken cancellationToken) =>
{
    if (!IsTextProjectRequest(request))
        return UnsupportedProjectContentType();

    if (!TryReadCalculationLogConfiguration(
            request,
            out TermodelLog.LogConfiguration logConfiguration,
            out string? logConfigurationError))
    {
        return Results.ValidationProblem(new Dictionary<string, string[]>
        {
            ["log"] = [logConfigurationError ?? "Configurazione log non valida."]
        });
    }

    if (!TryReadCalculationResponseArtifact(
            request,
            out string? responseArtifact,
            out string? responseFloor,
            out string? responseArtifactError))
    {
        return Results.ValidationProblem(new Dictionary<string, string[]>
        {
            ["responseArtifact"] =
                [responseArtifactError ?? "Artifact di risposta non valido."]
        });
    }

    try
    {
        string projectText = await ReadProjectTextAsync(request, cancellationToken);
        Guid projectId = ProjectRequestIdentity.ReadProjectId(projectText);

        // Il file progetto inviato dal frontend è autorevole per questa
        // elaborazione. Il workspace Render è ricreabile e può non esistere
        // dopo un redeploy: AggiornaCalcolo non richiede open/lock preventivi.
        ProjectCalculationData data = await projects.UpdateCurrentAsync(
            projectId,
            projectText,
            async token =>
            {
                Model3DGenerationResult result =
                    await new GeneraModello().GeneraAsync(
                        projectText,
                        token,
                        logConfiguration);

                RadiantPanelsArtifact panels =
                    RadiantPanelCalculator.Calculate(projectText);

                RadiantExecutiveArtifacts? executive =
                    RadiantExecutiveGenerator.Generate(
                        projectText,
                        result.RadiantPanelInputXml,
                        result.CleanFloorPlans);

                string logMode = GetLogMode(logConfiguration);
                string[] logCategories = GetLogCategoryNames(logConfiguration);

                // Le diagnostiche idrauliche appartengono all'artifact pannelli.
                // Il campo top-level diagnostics segue TermodelLog e viene letto
                // DOPO la generazione dell'esecutivo, così include anche
                // l'instrumentazione StrategiaDiego della stessa richiesta.
                IReadOnlyList<string> combinedDiagnostics =
                    TermodelLog.Messages.ToArray();

                var artifactJsonOptions =
                    new JsonSerializerOptions(JsonSerializerDefaults.Web)
                    {
                        WriteIndented = true
                    };

                return new ProjectCalculationData(
                    JsonSerializer.SerializeToUtf8Bytes(result.Model),
                    result.CleanFloorPlans,
                    JsonSerializer.SerializeToUtf8Bytes(panels, artifactJsonOptions),
                    executive?.Svg,
                    executive?.Dxf,
                    combinedDiagnostics,
                    result.Model.PrimitiveCount,
                    panels.CircuitCount,
                    executive?.PrimitiveCount ?? 0,
                    executive?.FloorCount ?? 0,
                    logConfiguration.Enabled,
                    logMode,
                    logCategories);
            },
            cancellationToken);

        if (responseArtifact is not null)
        {
            return BuildCalculationArtifactResponse(
                data,
                projectId,
                responseArtifact,
                responseFloor,
                response);
        }

        string generatedFilesHref =
            $"/api/projects/{projectId:D}/generated-files";
        string model3DHref =
            $"/api/projects/{projectId:D}/artifacts/model3d";
        string panelsHref =
            $"/api/projects/{projectId:D}/artifacts/pannelli";
        string executiveSvgHref =
            $"/api/projects/{projectId:D}/artifacts/pannelli-esecutivo-svg";
        string executiveDxfHref =
            $"/api/projects/{projectId:D}/artifacts/pannelli-esecutivo-dxf";

        var artifacts = new List<object>
        {
            new
            {
                name = "model3d",
                contentType = "application/json",
                href = model3DHref
            },
            new
            {
                name = "pannelli",
                contentType = "application/json",
                href = panelsHref
            }
        };

        foreach (string floorName in data.CleanFloorPlans.Keys.OrderBy(
                     name => name,
                     StringComparer.OrdinalIgnoreCase))
        {
            artifacts.Add(new
            {
                name = "pianta-pulita",
                floorName,
                contentType = "image/svg+xml",
                href =
                    $"/api/projects/{projectId:D}/artifacts/pianta-pulita/" +
                    Uri.EscapeDataString(floorName)
            });
        }

        if (data.RadiantExecutiveSvg is not null &&
            data.RadiantExecutiveDxf is not null)
        {
            artifacts.Add(new
            {
                name = "pannelli-esecutivo-svg",
                contentType = "image/svg+xml",
                href = executiveSvgHref
            });
            artifacts.Add(new
            {
                name = "pannelli-esecutivo-dxf",
                contentType = "application/dxf",
                href = executiveDxfHref
            });
        }

        return Results.Json(new
        {
            contractVersion = "TERMODEL-FRONT-SERVICE-V1",
            projectId,
            status = "completed",
            savedProject = new
            {
                fileName = "project.tmdl"
            },
            generatedFilesHref,
            artifacts,
            diagnostics = data.Diagnostics,
            logging = new
            {
                enabled = data.LogEnabled,
                mode = data.LogMode,
                categories = data.LogCategories
            }
        });
    }
    catch (ProjectLockRequiredException exception)
    {
        return LockedProblem(exception.Message);
    }
    catch (InvalidDataException exception)
    {
        return InvalidProjectProblem(exception.Message);
    }
    catch (NotSupportedException exception)
    {
        return Results.Problem(
            title: "Funzione del progetto non ancora supportata",
            detail: exception.Message,
            statusCode: StatusCodes.Status422UnprocessableEntity);
    }
});

// Canale universale read-only dei file generati dal Service.
// Espone soltanto artifacts/* e logs/* del workspace progetto.
app.MapGet(
    "/api/projects/{projectId:guid}/generated-files",
    async (
        Guid projectId,
        ProjectStore projects,
        CancellationToken cancellationToken) =>
{
    if (!projects.HasProjectWorkspace(projectId))
    {
        return Results.Problem(
            title: "Progetto non disponibile",
            detail: $"Il projectId '{projectId:D}' non dispone di un workspace corrente.",
            statusCode: StatusCodes.Status404NotFound);
    }

    IReadOnlyList<ProjectGeneratedFileEntry> files =
        await projects.ListGeneratedFilesAsync(
            projectId,
            cancellationToken);

    return Results.Json(new
    {
        contractVersion = "TERMODEL-GENERATED-FILES-V1",
        projectId,
        artifactsStale = files.FirstOrDefault()?.Stale ??
            await projects.AreArtifactsStaleAsync(projectId, cancellationToken),
        files = files.Select(file => new
        {
            path = file.RelativePath,
            fileName = file.FileName,
            category = file.Category,
            contentType = file.ContentType,
            size = file.Size,
            lastWriteTimeUtc = file.LastWriteTimeUtc,
            inline = file.Inline,
            stale = file.Stale,
            href =
                $"/api/projects/{projectId:D}/generated-files/" +
                string.Join(
                    "/",
                    file.RelativePath
                        .Split('/', StringSplitOptions.RemoveEmptyEntries)
                        .Select(Uri.EscapeDataString))
        })
    });
});

app.MapGet(
    "/api/projects/{projectId:guid}/generated-files/{**relativePath}",
    async (
        Guid projectId,
        string relativePath,
        HttpResponse response,
        ProjectStore projects,
        CancellationToken cancellationToken) =>
{
    ProjectGeneratedFileContent? file =
        await projects.ReadGeneratedFileAsync(
            projectId,
            relativePath,
            cancellationToken);

    if (file is null)
    {
        return Results.Problem(
            title: "File generato non disponibile",
            detail:
                $"Il file generato '{relativePath}' non è disponibile per " +
                $"il projectId '{projectId:D}'.",
            statusCode: StatusCodes.Status404NotFound);
    }

    response.Headers["X-Termodel-Artifact-Stale"] =
        file.Stale ? "true" : "false";
    response.Headers["X-Termodel-Generated-File"] =
        file.RelativePath;
    response.Headers["X-Content-Type-Options"] = "nosniff";
    response.Headers["Cache-Control"] = "no-store";
    response.Headers["Last-Modified"] =
        file.LastWriteTimeUtc.ToUniversalTime().ToString("R");

    string safeFileName = file.FileName.Replace("\"", string.Empty);
    string disposition = file.Inline ? "inline" : "attachment";
    response.Headers["Content-Disposition"] =
        $"{disposition}; filename=\"{safeFileName}\"; " +
        $"filename*=UTF-8''{Uri.EscapeDataString(file.FileName)}";

    if (file.ContentType.StartsWith(
            "image/svg+xml",
            StringComparison.OrdinalIgnoreCase) ||
        file.ContentType.StartsWith(
            "text/html",
            StringComparison.OrdinalIgnoreCase))
    {
        response.Headers["Content-Security-Policy"] =
            "sandbox; default-src 'none'; style-src 'unsafe-inline'; img-src data:";
    }

    return Results.Bytes(
        file.Content,
        contentType: file.ContentType);
});

// Funzione realizzata da Codex in autonomia
app.MapGet(
    "/api/projects/{projectId:guid}/artifacts/model3d",
    async (
        Guid projectId,
        HttpResponse response,
        ProjectStore projects,
        CancellationToken cancellationToken) =>
{
    byte[]? model3DJson =
        await projects.ReadModel3DAsync(projectId, cancellationToken);

    if (model3DJson is null)
    {
        return Results.Problem(
            title: "Artifact model3d non disponibile",
            detail: $"Il projectId '{projectId:D}' non esiste o non dispone ancora di model3d.",
            statusCode: StatusCodes.Status404NotFound);
    }

    bool stale = await projects.AreArtifactsStaleAsync(
        projectId,
        cancellationToken);

    response.Headers["X-Termodel-Artifact-Stale"] = stale ? "true" : "false";

    return Results.Bytes(
        model3DJson,
        contentType: "application/json; charset=utf-8");
});

// Pianta pulita persistita per projectId. La lettura è read-only e non
// riesegue LeggiDxf/GeneraPianta.
app.MapGet(
    "/api/projects/{projectId:guid}/artifacts/pianta-pulita/{**piano}",
    async (
        Guid projectId,
        string piano,
        HttpResponse response,
        ProjectStore projects,
        CancellationToken cancellationToken) =>
{
    byte[]? svg =
        await projects.ReadCleanFloorPlanAsync(
            projectId,
            piano,
            cancellationToken);

    if (svg is null)
    {
        return Results.Problem(
            title: "Pianta pulita non disponibile",
            detail:
                $"Il projectId '{projectId:D}' non dispone della Pianta pulita " +
                $"del piano '{piano}'.",
            statusCode: StatusCodes.Status404NotFound);
    }

    bool stale = await projects.AreArtifactsStaleAsync(
        projectId,
        cancellationToken);

    response.Headers["X-Termodel-Artifact-Stale"] = stale ? "true" : "false";
    response.Headers["Content-Disposition"] =
        "inline; filename=\"pianta-pulita.svg\"";
    response.Headers["X-Content-Type-Options"] = "nosniff";
    response.Headers["Cache-Control"] = "no-store";
    response.Headers["Content-Security-Policy"] =
        "sandbox; default-src 'none'; style-src 'unsafe-inline'; img-src data:";

    return Results.Bytes(
        svg,
        contentType: "image/svg+xml; charset=utf-8");
});

// Funzione realizzata da Codex in autonomia
app.MapGet(
    "/api/projects/{projectId:guid}/artifacts/pannelli-esecutivo-svg",
    async (
        Guid projectId,
        HttpResponse response,
        ProjectStore projects,
        CancellationToken cancellationToken) =>
{
    byte[]? svg =
        await projects.ReadRadiantExecutiveSvgAsync(
            projectId,
            cancellationToken);

    if (svg is null)
    {
        return Results.Problem(
            title: "Esecutivo pannelli SVG non disponibile",
            detail: $"Il projectId '{projectId:D}' non dispone ancora di pannelli-esecutivo.svg.",
            statusCode: StatusCodes.Status404NotFound);
    }

    bool stale = await projects.AreArtifactsStaleAsync(
        projectId,
        cancellationToken);

    response.Headers["X-Termodel-Artifact-Stale"] = stale ? "true" : "false";
    response.Headers["Content-Disposition"] =
        "inline; filename=\"pannelli-esecutivo.svg\"";

    return Results.Bytes(
        svg,
        contentType: "image/svg+xml; charset=utf-8");
});

// Funzione realizzata da Codex in autonomia
app.MapGet(
    "/api/projects/{projectId:guid}/artifacts/pannelli-esecutivo-dxf",
    async (
        Guid projectId,
        HttpResponse response,
        ProjectStore projects,
        CancellationToken cancellationToken) =>
{
    byte[]? dxf =
        await projects.ReadRadiantExecutiveDxfAsync(
            projectId,
            cancellationToken);

    if (dxf is null)
    {
        return Results.Problem(
            title: "Esecutivo pannelli DXF non disponibile",
            detail: $"Il projectId '{projectId:D}' non dispone ancora di pannelli-esecutivo.dxf.",
            statusCode: StatusCodes.Status404NotFound);
    }

    bool stale = await projects.AreArtifactsStaleAsync(
        projectId,
        cancellationToken);

    response.Headers["X-Termodel-Artifact-Stale"] = stale ? "true" : "false";
    response.Headers["Content-Disposition"] =
        "attachment; filename=\"pannelli-esecutivo.dxf\"";

    return Results.Bytes(
        dxf,
        contentType: "application/dxf");
});

// Funzione realizzata da Codex in autonomia
app.MapGet(
    "/api/projects/{projectId:guid}/artifacts/pannelli",
    async (
        Guid projectId,
        HttpResponse response,
        ProjectStore projects,
        CancellationToken cancellationToken) =>
{
    byte[]? panelsJson =
        await projects.ReadRadiantPanelsAsync(projectId, cancellationToken);

    if (panelsJson is null)
    {
        return Results.Problem(
            title: "Artifact pannelli non disponibile",
            detail: $"Il projectId '{projectId:D}' non esiste o non dispone ancora di pannelli.json.",
            statusCode: StatusCodes.Status404NotFound);
    }

    bool stale = await projects.AreArtifactsStaleAsync(
        projectId,
        cancellationToken);

    response.Headers["X-Termodel-Artifact-Stale"] = stale ? "true" : "false";

    return Results.Bytes(
        panelsJson,
        contentType: "application/json; charset=utf-8");
});

// Funzione realizzata da Codex in autonomia
app.MapGet(
    "/api/projects/{projectId:guid}/logs/termodel",
    async (
        Guid projectId,
        HttpResponse response,
        ProjectStore projects,
        CancellationToken cancellationToken) =>
{
    byte[]? termodelLog =
        await projects.ReadTermodelLogAsync(projectId, cancellationToken);

    if (termodelLog is null)
    {
        return Results.Problem(
            title: "TermodelLog non disponibile",
            detail: $"Il projectId '{projectId:D}' non esiste o non dispone ancora di TermodelLog.md.",
            statusCode: StatusCodes.Status404NotFound);
    }

    bool stale = await projects.AreArtifactsStaleAsync(
        projectId,
        cancellationToken);

    response.Headers["X-Termodel-Artifact-Stale"] = stale ? "true" : "false";
    response.Headers["Content-Disposition"] = "inline; filename=\"TermodelLog.md\"";

    return Results.Bytes(
        termodelLog,
        contentType: "text/markdown; charset=utf-8");
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/model/3d", async (
    HttpRequest request,
    CancellationToken cancellationToken) =>
{
    if (!IsTextProjectRequest(request))
        return UnsupportedProjectContentType();

    try
    {
        string projectText = await ReadProjectTextAsync(request, cancellationToken);
        Model3DGenerationResult result =
            await new GeneraModello().GeneraAsync(projectText, cancellationToken);

        return Results.Json(result.Model);
    }
    catch (InvalidDataException exception)
    {
        return Results.Problem(
            title: "File unico o geometria non validi",
            detail: exception.Message,
            statusCode: StatusCodes.Status422UnprocessableEntity);
    }
    catch (NotSupportedException exception)
    {
        return Results.Problem(
            title: "Funzione del progetto non ancora supportata",
            detail: exception.Message,
            statusCode: StatusCodes.Status422UnprocessableEntity);
    }
});

// Funzione realizzata da Codex in autonomia
app.MapGet("/api/model/clean-floor/{floorName}", (string floorName) =>
{
    try
    {
        string svg = GeneraPianta.PiantaArchitettonicaPulita(floorName);
        return Results.Text(
            svg,
            contentType: "image/svg+xml; charset=utf-8",
            contentEncoding: Encoding.UTF8,
            statusCode: StatusCodes.Status200OK);
    }
    catch (KeyNotFoundException exception)
    {
        return Results.NotFound(new
        {
            title = "Pianta architettonica pulita non disponibile",
            detail = exception.Message
        });
    }
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/projects/new", (NuovoProgettoRequest request) =>
{
    try
    {
        NuovoProgettoResult result = ProgFileUnico.CreaNuovoProgetto(
            request,
            definitionPath,
            baseProjectPath);

        return Results.Text(
            result.Contenuto,
            contentType: "text/plain; charset=utf-8",
            contentEncoding: Encoding.UTF8,
            statusCode: StatusCodes.Status201Created);
    }
    catch (ProgFileUnicoValidationException exception)
    {
        return Results.ValidationProblem(new Dictionary<string, string[]>
        {
            ["project"] = exception.Errors.ToArray()
        });
    }
    catch (FileNotFoundException exception)
    {
        return Results.Problem(
            title: "Definizione database non disponibile",
            detail: exception.Message,
            statusCode: StatusCodes.Status503ServiceUnavailable);
    }
    catch (InvalidDataException exception)
    {
        return Results.Problem(
            title: "Definizione o progetto non valido",
            detail: exception.Message,
            statusCode: StatusCodes.Status500InternalServerError);
    }
});

app.Run();

static bool TryReadCalculationLogConfiguration(
    HttpRequest request,
    out TermodelLog.LogConfiguration configuration,
    out string? error)
{
    bool enabled = true;
    error = null;

    if (request.Query.TryGetValue("logEnabled", out var enabledValues))
    {
        string rawEnabled = enabledValues.ToString().Trim();
        if (!bool.TryParse(rawEnabled, out enabled))
        {
            configuration = new TermodelLog.LogConfiguration(true, null);
            error = "logEnabled deve essere true oppure false.";
            return false;
        }
    }

    if (!request.Query.TryGetValue("logCategories", out var categoryValues))
    {
        configuration = new TermodelLog.LogConfiguration(enabled, null);
        return true;
    }

    string rawCategories = categoryValues.ToString();
    string[] tokens = rawCategories
        .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries);

    if (tokens.Length == 0)
    {
        configuration = new TermodelLog.LogConfiguration(enabled, new HashSet<TermodelLog.LogCategory>());
        error = "logCategories non può essere vuoto; usare 'none' per disabilitare tutte le categorie.";
        return false;
    }

    if (tokens.Any(token => token.Equals("all", StringComparison.OrdinalIgnoreCase)))
    {
        if (tokens.Length != 1)
        {
            configuration = new TermodelLog.LogConfiguration(enabled, new HashSet<TermodelLog.LogCategory>());
            error = "L'alias 'all' deve essere usato da solo.";
            return false;
        }

        configuration = new TermodelLog.LogConfiguration(
            enabled,
            Enum.GetValues<TermodelLog.LogCategory>().ToHashSet());
        return true;
    }

    if (tokens.Any(token => token.Equals("none", StringComparison.OrdinalIgnoreCase)))
    {
        if (tokens.Length != 1)
        {
            configuration = new TermodelLog.LogConfiguration(enabled, new HashSet<TermodelLog.LogCategory>());
            error = "L'alias 'none' deve essere usato da solo.";
            return false;
        }

        configuration = new TermodelLog.LogConfiguration(
            enabled,
            new HashSet<TermodelLog.LogCategory>());
        return true;
    }

    var categories = new HashSet<TermodelLog.LogCategory>();
    foreach (string token in tokens)
    {
        if (!Enum.TryParse(token, ignoreCase: true, out TermodelLog.LogCategory category) ||
            !Enum.IsDefined(category))
        {
            configuration = new TermodelLog.LogConfiguration(enabled, categories);
            error =
                $"Categoria log sconosciuta '{token}'. Valori ammessi: " +
                string.Join(", ", Enum.GetNames<TermodelLog.LogCategory>()) +
                ", all, none.";
            return false;
        }

        categories.Add(category);
    }

    configuration = new TermodelLog.LogConfiguration(enabled, categories);
    return true;
}

static string GetLogMode(TermodelLog.LogConfiguration configuration) =>
    !configuration.Enabled
        ? "disabled"
        : configuration.UsesCategoryFilter
            ? "filtered"
            : "service-default";

static string[] GetLogCategoryNames(TermodelLog.LogConfiguration configuration) =>
    configuration.EnabledCategories?
        .OrderBy(category => (int)category)
        .Select(category => category.ToString())
        .ToArray() ?? [];

static bool TryReadCalculationResponseArtifact(
    HttpRequest request,
    out string? artifact,
    out string? floor,
    out string? error)
{
    artifact = null;
    floor = null;
    error = null;

    if (!request.Query.TryGetValue("responseArtifact", out var artifactValues))
        return true;

    string rawArtifact = artifactValues.ToString().Trim();
    if (rawArtifact.Length == 0)
    {
        error = "responseArtifact non può essere vuoto.";
        return false;
    }

    artifact = rawArtifact.ToLowerInvariant() switch
    {
        "model3d" => "model3d",
        "pannelli" => "pannelli",
        "pannelli-esecutivo-svg" => "pannelli-esecutivo-svg",
        "pannelli-esecutivo-dxf" => "pannelli-esecutivo-dxf",
        "pianta-pulita" => "pianta-pulita",
        _ => null
    };

    if (artifact is null)
    {
        error =
            $"responseArtifact non riconosciuto: '{rawArtifact}'. " +
            "Valori ammessi: model3d, pannelli, pannelli-esecutivo-svg, " +
            "pannelli-esecutivo-dxf, pianta-pulita.";
        return false;
    }

    if (!artifact.Equals("pianta-pulita", StringComparison.Ordinal))
        return true;

    if (!request.Query.TryGetValue("responseFloor", out var floorValues) ||
        string.IsNullOrWhiteSpace(floorValues.ToString()))
    {
        error =
            "responseFloor è obbligatorio quando responseArtifact=pianta-pulita.";
        return false;
    }

    floor = floorValues.ToString().Trim();
    return true;
}

static IResult BuildCalculationArtifactResponse(
    ProjectCalculationData data,
    Guid projectId,
    string artifact,
    string? floor,
    HttpResponse response)
{
    byte[]? content = null;
    string contentType;
    string? fileName = null;

    switch (artifact)
    {
        case "model3d":
            content = data.Model3DJson;
            contentType = "application/json; charset=utf-8";
            break;

        case "pannelli":
            content = data.RadiantPanelsJson;
            contentType = "application/json; charset=utf-8";
            break;

        case "pannelli-esecutivo-svg":
            content = data.RadiantExecutiveSvg;
            contentType = "image/svg+xml; charset=utf-8";
            fileName = "pannelli-esecutivo.svg";
            break;

        case "pannelli-esecutivo-dxf":
            content = data.RadiantExecutiveDxf;
            contentType = "application/dxf";
            fileName = "pannelli-esecutivo.dxf";
            break;

        case "pianta-pulita":
            contentType = "image/svg+xml; charset=utf-8";
            fileName = "pianta-pulita.svg";
            if (floor is not null &&
                data.CleanFloorPlans.TryGetValue(floor, out string? cleanSvg))
            {
                content = Encoding.UTF8.GetBytes(cleanSvg);
            }
            break;

        default:
            throw new InvalidOperationException(
                $"Artifact di risposta validato ma non gestito: {artifact}.");
    }

    if (content is null)
    {
        string floorDetail =
            floor is null ? string.Empty : $" del piano '{floor}'";
        return Results.Problem(
            title: "Artifact richiesto non disponibile",
            detail:
                $"Il calcolo del projectId '{projectId:D}' non ha prodotto " +
                $"l'artifact '{artifact}'{floorDetail}.",
            statusCode: StatusCodes.Status404NotFound);
    }

    response.Headers["X-Termodel-Project-Id"] = projectId.ToString("D");
    response.Headers["X-Termodel-Response-Artifact"] = artifact;
    response.Headers["X-Termodel-Artifact-Stale"] = "false";
    response.Headers["Cache-Control"] = "no-store";
    response.Headers["X-Content-Type-Options"] = "nosniff";

    if (floor is not null)
        response.Headers["X-Termodel-Response-Floor"] = floor;

    if (fileName is not null)
    {
        string disposition = artifact.EndsWith(
            "-dxf",
            StringComparison.OrdinalIgnoreCase)
            ? "attachment"
            : "inline";
        response.Headers["Content-Disposition"] =
            $"{disposition}; filename=\"{fileName}\"";
    }

    if (contentType.StartsWith(
            "image/svg+xml",
            StringComparison.OrdinalIgnoreCase))
    {
        response.Headers["Content-Security-Policy"] =
            "sandbox; default-src 'none'; style-src 'unsafe-inline'; img-src data:";
    }

    return Results.Bytes(content, contentType: contentType);
}

static bool IsTextProjectRequest(HttpRequest request) =>
    request.ContentType is not null &&
    request.ContentType.StartsWith("text/plain", StringComparison.OrdinalIgnoreCase);

static IResult UnsupportedProjectContentType() =>
    Results.Problem(
        title: "Content-Type non supportato",
        detail: "Inviare il file unico TERMODEL-PROJECT-TEXT-V1 come text/plain; charset=utf-8.",
        statusCode: StatusCodes.Status415UnsupportedMediaType);

static async Task<string> ReadProjectTextAsync(
    HttpRequest request,
    CancellationToken cancellationToken)
{
    using var reader = new StreamReader(
        request.Body,
        Encoding.UTF8,
        detectEncodingFromByteOrderMarks: true);

    return await reader.ReadToEndAsync(cancellationToken);
}

static void EnsureRouteProjectId(Guid projectId, string projectText)
{
    Guid manifestProjectId = ProjectRequestIdentity.ReadProjectId(projectText);
    if (manifestProjectId != projectId)
    {
        throw new InvalidDataException(
            $"manifest.projectId '{manifestProjectId:D}' non corrisponde al projectId della route '{projectId:D}'.");
    }
}

static IResult LockedProblem(string detail) =>
    Results.Problem(
        title: "Il progetto è già in uso",
        detail: detail,
        statusCode: 423);

static string FeedbackClientKey(HttpContext context)
{
    string forwardedFor = context.Request.Headers["X-Forwarded-For"].ToString();
    if (!string.IsNullOrWhiteSpace(forwardedFor))
    {
        string first = forwardedFor
            .Split(',', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .FirstOrDefault() ?? string.Empty;

        if (first.Length > 0)
            return "xff:" + first;
    }

    return "ip:" + (context.Connection.RemoteIpAddress?.ToString() ?? "unknown");
}

static IResult InvalidProjectProblem(string detail) =>
    Results.Problem(
        title: "File unico, projectId o geometria non validi",
        detail: detail,
        statusCode: StatusCodes.Status422UnprocessableEntity);


public sealed record DxfToSvgRequest(
    string DxfText,
    IReadOnlyCollection<string>? Layers = null,
    string? Unit = null,
    bool Curves = false,
    bool ConvertText = false,
    bool ExplodeBlocks = false,
    string? Profile = null);

internal static class ServiceRuntimeInfo
{
    public static string ResolveCommit()
    {
        return
            Environment.GetEnvironmentVariable("RENDER_GIT_COMMIT")?.Trim()
            ?? Environment.GetEnvironmentVariable("GITHUB_SHA")?.Trim()
            ?? Environment.GetEnvironmentVariable("SOURCE_VERSION")?.Trim()
            ?? string.Empty;
    }

    public static string ShortCommit(string commit)
    {
        if (string.IsNullOrWhiteSpace(commit))
            return string.Empty;

        string trimmed = commit.Trim();
        return trimmed.Length <= 8
            ? trimmed
            : trimmed[..8];
    }
}
