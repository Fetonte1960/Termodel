using System.Text.Json;

namespace Termodel.Core.ProjectFiles;

public sealed class NuovoProgettoRequest
{
    public string NomeProgetto { get; init; } = "Nuovo progetto";
    public IReadOnlyList<PianoProgettoRequest>? Piani { get; init; }
    public Dictionary<string, List<Dictionary<string, JsonElement>>>? Archivi { get; init; }
}

public sealed class PianoProgettoRequest
{
    public string Id { get; init; } = "F001";
    public string Nome { get; init; } = "Unico";
    public string Tipo { get; init; } = "Calpestabile";
    public string NomeFile { get; init; } = "DisegnoInput";
    public string LayerCad { get; init; } = "Unico";
    public double AltezzaNetta { get; init; } = 3.0;
    public double AltezzaLorda { get; init; } = 3.3;
    public int PianiUguali { get; init; } = 1;
    public string? TipoFinestre { get; init; }
    public string? Svg { get; init; }
}

public sealed record NuovoProgettoResult(
    string Contenuto,
    string DefinitionSha256,
    IReadOnlyList<string> Diagnostica);

public sealed class ProgFileUnicoValidationException : Exception
{
    // Funzione realizzata da Codex in autonomia
    public ProgFileUnicoValidationException(IEnumerable<string> errors)
        : base("La richiesta NuovoProgetto non è valida.")
    {
        Errors = errors.ToArray();
    }

    public IReadOnlyList<string> Errors { get; }
}
