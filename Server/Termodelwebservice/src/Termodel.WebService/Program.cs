using System.Text;
using System.Text.Json;
using Termodel.Core;
using Termodel.Core.ProjectFiles;
using Termodel.Leggidxf;
using Termodel.WebService.Projects;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<ProjectStore>();
builder.Services.AddSingleton<ProjectLockManager>();

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
app.MapGet("/health", () => Results.Ok(new
{
    status = "ok"
}));

// Funzione realizzata da Codex in autonomia
app.MapGet("/api/model/capabilities", () => Results.Ok(CoreInformation.GetCapabilities()));

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
    ProjectStore projects,
    ProjectLockManager projectLocks,
    CancellationToken cancellationToken) =>
{
    if (!IsTextProjectRequest(request))
        return UnsupportedProjectContentType();

    try
    {
        string projectText = await ReadProjectTextAsync(request, cancellationToken);
        Guid projectId = ProjectRequestIdentity.ReadProjectId(projectText);
        Guid lockToken = ProjectLockManager.ReadRequiredToken(request);

        ProjectLockLease lease = await projectLocks.ValidateAndRenewAsync(
            projectId,
            lockToken,
            cancellationToken);

        ProjectCalculationData data = await projects.UpdateCurrentAsync(
            projectId,
            projectText,
            async token =>
            {
                Model3DGenerationResult result =
                    await new GeneraModello().GeneraAsync(projectText, token);

                return new ProjectCalculationData(
                    JsonSerializer.SerializeToUtf8Bytes(result.Model),
                    result.Diagnostics,
                    result.Model.PrimitiveCount);
            },
            cancellationToken);

        string model3DHref =
            $"/api/projects/{projectId:D}/artifacts/model3d";

        return Results.Json(new
        {
            contractVersion = "TERMODEL-FRONT-SERVICE-V1",
            projectId,
            status = "completed",
            savedProject = new
            {
                fileName = "project.tmdl"
            },
            artifacts = new[]
            {
                new
                {
                    name = "model3d",
                    contentType = "application/json",
                    href = model3DHref
                }
            },
            diagnostics = data.Diagnostics,
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
    catch (NotSupportedException exception)
    {
        return Results.Problem(
            title: "Funzione del progetto non ancora supportata",
            detail: exception.Message,
            statusCode: StatusCodes.Status422UnprocessableEntity);
    }
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

static IResult InvalidProjectProblem(string detail) =>
    Results.Problem(
        title: "File unico, projectId o geometria non validi",
        detail: detail,
        statusCode: StatusCodes.Status422UnprocessableEntity);
