using System.Text.Json.Serialization;

namespace Termodel.Core.Model3D;

public sealed class TermodelWebModel
{
    [JsonPropertyName("format")]
    public string Format { get; init; } = "TermodelWebModel";

    [JsonPropertyName("version")]
    public int Version { get; init; } = 3;

    [JsonPropertyName("coordinateSystem")]
    public string CoordinateSystem { get; init; } = "Z-up";

    [JsonPropertyName("generatedAtUtc")]
    public DateTimeOffset GeneratedAtUtc { get; init; } = DateTimeOffset.UtcNow;

    [JsonPropertyName("primitiveCount")]
    public int PrimitiveCount => Primitives.Count;

    [JsonPropertyName("primitives")]
    public List<TermodelWebPrimitive> Primitives { get; } = [];
}

public sealed class TermodelWebPrimitive
{
    [JsonPropertyName("kind")]
    public string Kind { get; init; } = "mesh";

    [JsonPropertyName("source")]
    public string Source { get; init; } = "TermodelCore3D";

    [JsonPropertyName("parte")]
    public string Parte { get; init; } = "completo";

    [JsonPropertyName("numero")]
    public int Numero { get; init; }

    [JsonPropertyName("id")]
    public string Id { get; init; } = string.Empty;

    [JsonPropertyName("tipo")]
    public string Tipo { get; init; } = string.Empty;

    [JsonPropertyName("descrizione")]
    public string Descrizione { get; init; } = string.Empty;

    [JsonPropertyName("color")]
    public string Color { get; init; } = "#A0522D";

    [JsonPropertyName("opacity")]
    public double Opacity { get; init; } = 1;

    [JsonPropertyName("lineWidth")]
    public double LineWidth { get; init; } = 1;

    [JsonPropertyName("text")]
    public string Text { get; init; } = string.Empty;

    [JsonPropertyName("vertices")]
    public List<double[]> Vertices { get; init; } = [];

    [JsonPropertyName("indices")]
    public List<int> Indices { get; init; } = [];

    [JsonExtensionData]
    public Dictionary<string, object?> Metadata { get; init; } = new(StringComparer.Ordinal);
}
