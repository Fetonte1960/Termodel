using System.Text;
using System.Text.Json;
using Termodel.Core;
using Termodel.Core.ProjectFiles;
using Termodel.Leggidxf;
using Termodel.WebService.Calculations;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddSingleton<CalculationSnapshotStore>();
builder.Services.AddSingleton<SavedProjectStore>();

const string TermodelWebCorsPolicy = "TermodelWeb";

// Modificato da Codex per realizzare: consentire al frontend pubblico Termodel Web di chiamare il WebService locale con preflight CORS esplicito.
builder.Services.AddCors(options =>
{
    options.AddPolicy(TermodelWebCorsPolicy, policy =>
    {
        policy
            .WithOrigins("https://www.termodel.it")
            .WithMethods("GET", "POST", "OPTIONS")
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
app.MapPost("/api/calculations", async (
    HttpRequest request,
    CalculationSnapshotStore snapshots,
    SavedProjectStore savedProjects,
    CancellationToken cancellationToken) =>
{
    if (request.ContentType is null ||
        !request.ContentType.StartsWith("text/plain", StringComparison.OrdinalIgnoreCase))
    {
        return Results.Problem(
            title: "Content-Type non supportato",
            detail: "Inviare il file unico TERMODEL-PROJECT-TEXT-V1 come text/plain; charset=utf-8.",
            statusCode: StatusCodes.Status415UnsupportedMediaType);
    }

    try
    {
        using var reader = new StreamReader(
            request.Body,
            Encoding.UTF8,
            detectEncodingFromByteOrderMarks: true);

        string projectText = await reader.ReadToEndAsync(cancellationToken);

        Model3DGenerationResult result =
            await new GeneraModello().GeneraAsync(projectText, cancellationToken);

        byte[] model3DJson = JsonSerializer.SerializeToUtf8Bytes(result.Model);
        CalculationSnapshot snapshot = snapshots.Create(model3DJson, result.Diagnostics);

        string savedProjectFileName;
        try
        {
            savedProjectFileName = await savedProjects.SaveAsync(
                snapshot.Id,
                snapshot.CreatedAtUtc,
                projectText,
                cancellationToken);
        }
        catch
        {
            snapshots.Remove(snapshot.Id);
            throw;
        }

        string model3DHref =
            $"/api/calculations/{snapshot.Id:D}/artifacts/model3d";

        return Results.Json(new
        {
            contractVersion = "TERMODEL-FRONT-SERVICE-V1",
            calculationId = snapshot.Id,
            status = "completed",
            savedProject = new
            {
                fileName = savedProjectFileName
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
            diagnostics = snapshot.Diagnostics
        });
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
app.MapGet(
    "/api/calculations/{calculationId:guid}/artifacts/model3d",
    (Guid calculationId, CalculationSnapshotStore snapshots) =>
{
    if (!snapshots.TryGet(calculationId, out CalculationSnapshot? snapshot) ||
        snapshot is null)
    {
        return Results.Problem(
            title: "Snapshot di calcolo non disponibile",
            detail: $"Il calculationId '{calculationId:D}' non esiste o non è più disponibile.",
            statusCode: StatusCodes.Status404NotFound);
    }

    return Results.Bytes(
        snapshot.CopyModel3DJson(),
        contentType: "application/json; charset=utf-8");
});

// Funzione realizzata da Codex in autonomia
app.MapPost("/api/model/3d", async (HttpRequest request, CancellationToken cancellationToken) =>
{
    if (request.ContentType is null ||
        !request.ContentType.StartsWith("text/plain", StringComparison.OrdinalIgnoreCase))
    {
        return Results.Problem(
            title: "Content-Type non supportato",
            detail: "Inviare il file unico TERMODEL-PROJECT-TEXT-V1 come text/plain; charset=utf-8.",
            statusCode: StatusCodes.Status415UnsupportedMediaType);
    }

    try
    {
        using var reader = new StreamReader(request.Body, Encoding.UTF8, detectEncodingFromByteOrderMarks: true);
        string projectText = await reader.ReadToEndAsync(cancellationToken);
        Model3DGenerationResult result = await new GeneraModello().GeneraAsync(projectText, cancellationToken);
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
