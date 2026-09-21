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
    public string Source { get; init; } = string.Empty;

    [JsonPropertyName("parte")]
    public string Parte { get; init; } = string.Empty;

    [JsonPropertyName("numero")]
    public int Numero { get; init; }

    [JsonPropertyName("id")]
    public string Id { get; init; } = string.Empty;

    [JsonPropertyName("tipo")]
    public string Tipo { get; init; } = string.Empty;

    [JsonPropertyName("descrizione")]
    public string Descrizione { get; init; } = string.Empty;

    [JsonPropertyName("filterMetadata")]
    public bool FilterMetadata { get; init; }

    [JsonPropertyName("piano")]
    public string Piano { get; init; } = string.Empty;

    [JsonPropertyName("confine")]
    public string Confine { get; init; } = string.Empty;

    [JsonPropertyName("separatore")]
    public bool Separatore { get; init; }

    [JsonPropertyName("stessaZona")]
    public bool StessaZona { get; init; }

    [JsonPropertyName("fittizia")]
    public bool Fittizia { get; init; }

    [JsonPropertyName("falda")]
    public bool Falda { get; init; }

    [JsonPropertyName("color")]
    public string Color { get; init; } = "#FFFFFF";

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

    // Metadati aggiuntivi compatibili (es. zona) che non fanno parte del
    // contratto grafico minimo ma possono essere utili ai client futuri.
    [JsonExtensionData]
    public Dictionary<string, object?> Metadata { get; init; } = new(StringComparer.Ordinal);
}
