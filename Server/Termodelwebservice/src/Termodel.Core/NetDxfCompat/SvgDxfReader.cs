using System.Globalization;
using System.Xml.Linq;
using netDxf;
using netDxf.Blocks;
using netDxf.Entities;
using netDxf.Tables;

namespace Termodel.Core.NetDxfCompat;

public sealed record SvgDxfFloor(
    string Id,
    string Name,
    string Role,
    string FileName,
    string Layer,
    int Order,
    DxfDocument Document);

public static class SvgDxfReader
{
    private const double CentimetersToMeters = 0.01;
    private static readonly XNamespace SvgNamespace = "http://www.w3.org/2000/svg";

    // Funzione realizzata da Codex in autonomia
    public static IReadOnlyList<SvgDxfFloor> ParseProjectSvg(string svg)
    {
        XDocument document;
        try
        {
            document = XDocument.Parse(svg, LoadOptions.SetLineInfo);
        }
        catch (Exception exception) when (exception is System.Xml.XmlException or ArgumentException)
        {
            throw new InvalidDataException("Lo SVG del progetto non è XML valido.", exception);
        }

        XElement root = document.Root ?? throw new InvalidDataException("Lo SVG non contiene una radice.");
        if (root.Name != SvgNamespace + "svg")
            throw new InvalidDataException("La radice della geometria deve essere svg con namespace SVG.");
        if (!string.Equals(root.Attribute("data-termodel-units")?.Value, "cm", StringComparison.OrdinalIgnoreCase))
            throw new InvalidDataException("Lo SVG deve dichiarare data-termodel-units='cm'.");

        var floors = new List<SvgDxfFloor>();
        foreach (XElement group in root.Elements(SvgNamespace + "g"))
            floors.Add(ParseFloor(group));

        if (floors.Count == 0)
            throw new InvalidDataException("Lo SVG non contiene gruppi di piano Termodel.");
        if (floors.Select(floor => floor.Id).Distinct(StringComparer.OrdinalIgnoreCase).Count() != floors.Count)
            throw new InvalidDataException("Lo SVG contiene identificativi di piano duplicati.");

        return floors.OrderBy(floor => floor.Order).ToArray();
    }

    private static SvgDxfFloor ParseFloor(XElement group)
    {
        string id = Required(group, "data-termodel-floor-id");
        string name = Required(group, "data-termodel-name");
        string role = Required(group, "data-termodel-role");
        string fileName = Required(group, "data-termodel-file");
        string layerName = Required(group, "data-termodel-layer");
        int order = ParseInt(Required(group, "data-termodel-order"), "data-termodel-order");
        if (role is not ("calpestabile" or "copertura"))
            throw new InvalidDataException($"Piano '{id}': ruolo '{role}' non supportato.");

        var result = new DxfDocument();
        var layer = new Layer(layerName);
        result.Layers.Add(layer);

        foreach (XElement element in group.Elements())
        {
            if (element.Name == SvgNamespace + "line")
                result.AddEntity(ParseLine(element, layer));
            else if (element.Name == SvgNamespace + "text")
                result.AddEntity(ParseBlock(element, layer, result));
            else
                throw new InvalidDataException($"Piano '{id}': elemento SVG '{element.Name.LocalName}' non supportato.");
        }

        return new SvgDxfFloor(id, name, role, fileName, layerName, order, result);
    }

    private static Line ParseLine(XElement element, Layer layer)
    {
        var line = new Line(
            new Vector3(ParseNumber(element, "x1") * CentimetersToMeters, ParseNumber(element, "y1") * CentimetersToMeters, ParseOptionalNumber(element, "data-z1") * CentimetersToMeters),
            new Vector3(ParseNumber(element, "x2") * CentimetersToMeters, ParseNumber(element, "y2") * CentimetersToMeters, ParseOptionalNumber(element, "data-z2") * CentimetersToMeters))
        {
            Layer = layer,
            Linetype = new Linetype(element.Attribute("data-termodel-linetype")?.Value?.Trim() ?? "Continuous"),
            Color = new AciColor(ParseOptionalInt(element, "data-termodel-color", 1))
        };
        return line;
    }

    private static Insert ParseBlock(XElement element, Layer layer, DxfDocument document)
    {
        List<string> rows = element.Elements(SvgNamespace + "tspan")
            .Select(child => child.Value.Trim())
            .Where(value => value.Length > 0)
            .ToList();
        if (rows.Count == 0)
            rows.Add(element.Value.Trim());
        if (rows.Count == 0 || !rows[0].StartsWith("BLOCCO,", StringComparison.OrdinalIgnoreCase))
            throw new InvalidDataException("Un elemento text non contiene una dichiarazione BLOCCO valida.");

        string blockName = rows[0].Split(',', 2)[1].Trim().ToUpperInvariant();
        if (blockName.Length == 0)
            throw new InvalidDataException("Nome BLOCCO mancante nello SVG.");

        var values = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
        foreach (string row in rows.Skip(1))
        {
            string[] pair = row.Split(',', 2);
            if (pair.Length != 2 || string.IsNullOrWhiteSpace(pair[0]))
                throw new InvalidDataException($"Attributo non valido nel blocco '{blockName}': '{row}'.");
            values[pair[0].Trim()] = pair[1].Trim();
        }

        if (!document.Blocks.Contains(blockName))
        {
            var definition = new Block(blockName);
            foreach (string tag in values.Keys)
                definition.AttributeTags.Add(tag);
            document.Blocks.Add(definition);
        }

        var insert = new Insert(
            document.Blocks[blockName],
            new Vector3(ParseNumber(element, "x") * CentimetersToMeters, ParseNumber(element, "y") * CentimetersToMeters, 0))
        {
            Layer = layer,
            Rotation = ParseOptionalNumber(element, "data-termodel-rotation")
        };
        foreach (netDxf.Entities.Attribute attribute in insert.Attributes)
            if (values.TryGetValue(attribute.Tag, out string? value))
                attribute.Value = value;
        return insert;
    }

    private static string Required(XElement element, string attribute) =>
        !string.IsNullOrWhiteSpace(element.Attribute(attribute)?.Value)
            ? element.Attribute(attribute)!.Value.Trim()
            : throw new InvalidDataException($"Attributo SVG obbligatorio '{attribute}' mancante.");

    private static double ParseNumber(XElement element, string attribute) =>
        double.TryParse(Required(element, attribute), NumberStyles.Float, CultureInfo.InvariantCulture, out double value) && double.IsFinite(value)
            ? value
            : throw new InvalidDataException($"Attributo SVG '{attribute}' non numerico.");

    private static double ParseOptionalNumber(XElement element, string attribute)
    {
        string? raw = element.Attribute(attribute)?.Value;
        if (string.IsNullOrWhiteSpace(raw)) return 0;
        return double.TryParse(raw, NumberStyles.Float, CultureInfo.InvariantCulture, out double value) && double.IsFinite(value)
            ? value
            : throw new InvalidDataException($"Attributo SVG '{attribute}' non numerico.");
    }

    private static int ParseOptionalInt(XElement element, string attribute, int fallback)
    {
        string? raw = element.Attribute(attribute)?.Value;
        if (string.IsNullOrWhiteSpace(raw)) return fallback;
        return ParseInt(raw, attribute);
    }

    private static int ParseInt(string raw, string name) =>
        int.TryParse(raw, NumberStyles.Integer, CultureInfo.InvariantCulture, out int value)
            ? value
            : throw new InvalidDataException($"Attributo SVG '{name}' non intero.");
}
