using System.Collections.Concurrent;
using System.Net.Http.Headers;
using System.Net.Http.Json;
using System.Text.Json;

namespace Termodel.WebService.Feedback;

public sealed class FeedbackOptions
{
    public FeedbackOptions()
    {
        GitHubToken =
            Environment.GetEnvironmentVariable("TERMODEL_FEEDBACK_GITHUB_TOKEN")?.Trim() ?? string.Empty;

        Repository =
            Environment.GetEnvironmentVariable("TERMODEL_FEEDBACK_REPOSITORY")?.Trim()
            ?? "Fetonte1960/Termodel";

        AllowedOrigin =
            Environment.GetEnvironmentVariable("TERMODEL_FEEDBACK_ALLOWED_ORIGIN")?.Trim()
            ?? "https://www.termodel.it";

        GitHubApiBaseUrl =
            Environment.GetEnvironmentVariable("TERMODEL_FEEDBACK_GITHUB_API_BASE_URL")?.Trim()
            ?? "https://api.github.com";
    }

    public string GitHubToken { get; }
    public string Repository { get; }
    public string AllowedOrigin { get; }
    public string GitHubApiBaseUrl { get; }

    public bool IsConfigured =>
        !string.IsNullOrWhiteSpace(GitHubToken) &&
        Repository.Split('/', StringSplitOptions.RemoveEmptyEntries).Length == 2 &&
        Uri.TryCreate(GitHubApiBaseUrl, UriKind.Absolute, out Uri? apiUri) &&
        (apiUri.Scheme == Uri.UriSchemeHttps ||
         apiUri.IsLoopback && apiUri.Scheme == Uri.UriSchemeHttp);
}

public sealed record UserFeedbackRequest(
    string? Message,
    string? Category,
    string? Title,
    string? Page,
    string? AppVersion);

public sealed record UserFeedbackSubmission(
    string Message,
    string Category,
    string Title,
    string Page,
    string AppVersion)
{
    private static readonly HashSet<string> AllowedCategories =
        new(StringComparer.OrdinalIgnoreCase)
        {
            "suggestion",
            "bug",
            "question",
            "other"
        };

    public static bool TryCreate(
        UserFeedbackRequest? request,
        out UserFeedbackSubmission? submission,
        out Dictionary<string, string[]> errors)
    {
        errors = new Dictionary<string, string[]>(StringComparer.OrdinalIgnoreCase);
        submission = null;

        if (request is null)
        {
            errors["feedback"] = ["Payload JSON mancante."];
            return false;
        }

        string message = (request.Message ?? string.Empty).Trim();
        string category = (request.Category ?? "suggestion").Trim().ToLowerInvariant();
        string title = string.Join(
            " ",
            (request.Title ?? string.Empty)
                .Split(
                    ['\r', '\n'],
                    StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries));
        string page = SanitizePage(request.Page);
        string appVersion = (request.AppVersion ?? string.Empty).Trim();

        if (message.Length < 3)
            errors["message"] = ["Il messaggio deve contenere almeno 3 caratteri."];
        else if (message.Length > 6000)
            errors["message"] = ["Il messaggio non può superare 6000 caratteri."];

        if (!AllowedCategories.Contains(category))
            errors["category"] = ["Categoria ammessa: suggestion, bug, question oppure other."];

        if (title.Length > 120)
            errors["title"] = ["Il titolo non può superare 120 caratteri."];

        if (page.Length > 300)
            errors["page"] = ["La pagina non può superare 300 caratteri."];

        if (appVersion.Length > 40)
            errors["appVersion"] = ["La versione app non può superare 40 caratteri."];

        if (errors.Count > 0)
            return false;

        if (title.Length == 0)
        {
            string firstLine = message
                .Split(['\r', '\n'], StringSplitOptions.RemoveEmptyEntries)
                .FirstOrDefault()?.Trim() ?? message;

            title = firstLine.Length <= 80
                ? firstLine
                : firstLine[..77].TrimEnd() + "...";
        }

        submission = new UserFeedbackSubmission(
            message,
            category,
            title,
            page,
            appVersion);

        return true;
    }

    private static string SanitizePage(string? value)
    {
        string page = (value ?? string.Empty).Trim();
        if (page.Length == 0)
            return string.Empty;

        int query = page.IndexOf('?');
        if (query >= 0)
            page = page[..query];

        int fragment = page.IndexOf('#');
        if (fragment >= 0)
            page = page[..fragment];

        return page.Trim();
    }
}

public sealed class FeedbackRateLimiter
{
    private static readonly TimeSpan ClientWindow = TimeSpan.FromMinutes(10);
    private static readonly TimeSpan GlobalWindow = TimeSpan.FromHours(1);
    private const int ClientLimit = 5;
    private const int GlobalLimit = 100;

    private readonly ConcurrentDictionary<string, Queue<DateTimeOffset>> _clients =
        new(StringComparer.Ordinal);
    private readonly Queue<DateTimeOffset> _global = new();
    private readonly object _globalGate = new();

    public bool TryConsume(string clientKey, out int retryAfterSeconds)
    {
        DateTimeOffset now = DateTimeOffset.UtcNow;

        lock (_globalGate)
        {
            Trim(_global, now - GlobalWindow);
            if (_global.Count >= GlobalLimit)
            {
                retryAfterSeconds = SecondsUntilAvailable(
                    _global.Peek() + GlobalWindow,
                    now);
                return false;
            }
        }

        Queue<DateTimeOffset> clientQueue =
            _clients.GetOrAdd(clientKey, static _ => new Queue<DateTimeOffset>());

        lock (clientQueue)
        {
            Trim(clientQueue, now - ClientWindow);
            if (clientQueue.Count >= ClientLimit)
            {
                retryAfterSeconds = SecondsUntilAvailable(
                    clientQueue.Peek() + ClientWindow,
                    now);
                return false;
            }

            clientQueue.Enqueue(now);
        }

        lock (_globalGate)
        {
            Trim(_global, now - GlobalWindow);
            _global.Enqueue(now);
        }

        retryAfterSeconds = 0;
        return true;
    }

    private static void Trim(
        Queue<DateTimeOffset> queue,
        DateTimeOffset threshold)
    {
        while (queue.Count > 0 && queue.Peek() <= threshold)
            queue.Dequeue();
    }

    private static int SecondsUntilAvailable(
        DateTimeOffset availableAt,
        DateTimeOffset now)
    {
        double seconds = Math.Ceiling((availableAt - now).TotalSeconds);
        return Math.Max(1, (int)seconds);
    }
}

public sealed class GitHubFeedbackPublisher(
    HttpClient httpClient,
    FeedbackOptions options,
    ILogger<GitHubFeedbackPublisher> logger)
{
    public async Task<GitHubIssueResult> PublishAsync(
        UserFeedbackSubmission feedback,
        CancellationToken cancellationToken)
    {
        if (!options.IsConfigured)
        {
            throw new FeedbackNotConfiguredException(
                "Il servizio suggerimenti GitHub non è configurato.");
        }

        string[] repositoryParts =
            options.Repository.Split('/', StringSplitOptions.RemoveEmptyEntries);

        string requestUrl =
            $"{options.GitHubApiBaseUrl.TrimEnd('/')}/repos/" +
            $"{Uri.EscapeDataString(repositoryParts[0])}/" +
            $"{Uri.EscapeDataString(repositoryParts[1])}/issues";

        string issueTitle =
            $"[Termodel Feedback/{CategoryLabel(feedback.Category)}] {feedback.Title}";

        var issueRequest = new
        {
            title = issueTitle,
            body = BuildIssueBody(feedback)
        };

        using var request = new HttpRequestMessage(HttpMethod.Post, requestUrl)
        {
            Content = JsonContent.Create(issueRequest)
        };

        request.Headers.Authorization =
            new AuthenticationHeaderValue("Bearer", options.GitHubToken);
        request.Headers.UserAgent.ParseAdd("Termodel-WebService/1.0");
        request.Headers.Accept.ParseAdd("application/vnd.github+json");
        request.Headers.TryAddWithoutValidation(
            "X-GitHub-Api-Version",
            "2022-11-28");

        using HttpResponseMessage response =
            await httpClient.SendAsync(request, cancellationToken);

        string responseText =
            await response.Content.ReadAsStringAsync(cancellationToken);

        if (!response.IsSuccessStatusCode)
        {
            logger.LogWarning(
                "GitHub feedback publish failed with status {StatusCode}. Response: {Response}",
                (int)response.StatusCode,
                Truncate(responseText, 800));

            throw new FeedbackPublishException(
                $"GitHub non ha accettato il feedback (HTTP {(int)response.StatusCode}).");
        }

        try
        {
            using JsonDocument document = JsonDocument.Parse(responseText);
            JsonElement root = document.RootElement;

            int issueNumber = root.GetProperty("number").GetInt32();
            string issueUrl = root.GetProperty("html_url").GetString() ?? string.Empty;

            if (issueNumber <= 0 || issueUrl.Length == 0)
                throw new JsonException("Risposta GitHub incompleta.");

            return new GitHubIssueResult(issueNumber, issueUrl);
        }
        catch (Exception exception) when (
            exception is JsonException or
            KeyNotFoundException or
            InvalidOperationException or
            FormatException)
        {
            logger.LogWarning(
                exception,
                "GitHub feedback response could not be parsed.");

            throw new FeedbackPublishException(
                "GitHub ha creato una risposta non riconosciuta.");
        }
    }

    private static string BuildIssueBody(UserFeedbackSubmission feedback)
    {
        var lines = new List<string>
        {
            "### Segnalazione utente",
            string.Empty,
            DisarmMentions(feedback.Message),
            string.Empty,
            "---",
            string.Empty,
            "### Contesto client",
            string.Empty,
            $"- Categoria: `{feedback.Category}`",
            $"- Ricevuto UTC: `{DateTimeOffset.UtcNow:O}`"
        };

        if (feedback.Page.Length > 0)
            lines.Add($"- Pagina: `{EscapeInlineCode(feedback.Page)}`");

        if (feedback.AppVersion.Length > 0)
            lines.Add($"- Versione app: `{EscapeInlineCode(feedback.AppVersion)}`");

        lines.Add(string.Empty);
        lines.Add(
            "_Creato automaticamente da Termodel.WebService. " +
            "Nessun file progetto, projectId, email o IP è stato allegato automaticamente._");

        return string.Join(Environment.NewLine, lines);
    }

    private static string CategoryLabel(string category) =>
        category switch
        {
            "bug" => "Bug",
            "question" => "Question",
            "other" => "Other",
            _ => "Suggestion"
        };

    private static string DisarmMentions(string value) =>
        value.Replace("@", "@\u200B", StringComparison.Ordinal);

    private static string EscapeInlineCode(string value) =>
        value.Replace("`", "'", StringComparison.Ordinal);

    private static string Truncate(string value, int maxLength) =>
        value.Length <= maxLength ? value : value[..maxLength];
}

public sealed record GitHubIssueResult(
    int IssueNumber,
    string IssueUrl);

public sealed class FeedbackNotConfiguredException(string message)
    : Exception(message);

public sealed class FeedbackPublishException(string message)
    : Exception(message);
