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

public sealed record SvgDxfLineMetadata(
    string Id,
    string FloorName,
    string Entity,
    string NetworkCode,
    string LayerName);

public static class SvgDxfReader
{
    private const double CentimetersToMeters = 0.01;
    private static readonly XNamespace SvgNamespace = "http://www.w3.org/2000/svg";

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

        List<FloorSource> sources = root.Elements(SvgNamespace + "g")
            .Select(ParseFloorSource)
            .OrderBy(source => source.Order)
            .ToList();

        if (sources.Count == 0)
            throw new InvalidDataException("Lo SVG non contiene gruppi di piano Termodel.");
        if (sources.Select(source => source.Id).Distinct(StringComparer.OrdinalIgnoreCase).Count() != sources.Count)
            throw new InvalidDataException("Lo SVG contiene identificativi di piano duplicati.");

        // Un solo DxfDocument logico per NomeFile, come nel Desktop:
        // più piani possono quindi continuare a essere distinti tramite LayerCad.
        var documents = new Dictionary<string, DxfDocument>(StringComparer.OrdinalIgnoreCase);
        var floors = new List<SvgDxfFloor>(sources.Count);

        foreach (FloorSource source in sources)
        {
            if (!documents.TryGetValue(source.FileName, out DxfDocument? cad))
            {
                cad = new DxfDocument();
                documents.Add(source.FileName, cad);
            }

            GetOrCreateLayer(cad, source.Layer);

            foreach (XElement element in source.Group.Elements())
            {
                Layer layer = ResolveLayer(cad, element, source.Layer);
                if (element.Name == SvgNamespace + "line")
                    cad.AddEntity(ParseLine(element, layer));
                else if (element.Name == SvgNamespace + "text")
                    cad.AddEntity(ParseBlock(element, layer, cad));
                else
                    throw new InvalidDataException(
                        $"Piano '{source.Id}': elemento SVG '{element.Name.LocalName}' non supportato.");
            }

            floors.Add(new SvgDxfFloor(
                source.Id,
                source.Name,
                source.Role,
                source.FileName,
                source.Layer,
                source.Order,
                cad));
        }

        return floors;
    }

    private static FloorSource ParseFloorSource(XElement group)
    {
        string id = Required(group, "data-termodel-floor-id");
        string name = Required(group, "data-termodel-name");
        string role = Required(group, "data-termodel-role").ToLowerInvariant();
        string fileName = Required(group, "data-termodel-file");
        string layerName = Required(group, "data-termodel-layer");
        int order = ParseInt(Required(group, "data-termodel-order"), "data-termodel-order");

        if (role is not ("calpestabile" or "copertura"))
            throw new InvalidDataException($"Piano '{id}': ruolo '{role}' non supportato.");

        return new FloorSource(group, id, name, role, fileName, layerName, order);
    }

    private static Layer ResolveLayer(DxfDocument document, XElement element, string defaultLayer)
    {
        string layerName = element.Attribute("data-termodel-layer")?.Value?.Trim() ?? string.Empty;
        return GetOrCreateLayer(document, layerName.Length > 0 ? layerName : defaultLayer);
    }

    private static Layer GetOrCreateLayer(DxfDocument document, string layerName)
    {
        if (!document.Layers.Contains(layerName))
            document.Layers.Add(new Layer(layerName));
        return document.Layers[layerName];
    }

    private static Line ParseLine(XElement element, Layer layer)
    {
        var line = new Line(
            new Vector3(
                ParseNumber(element, "x1") * CentimetersToMeters,
                ParseNumber(element, "y1") * CentimetersToMeters,
                ParseOptionalNumber(element, "data-z1") * CentimetersToMeters),
            new Vector3(
                ParseNumber(element, "x2") * CentimetersToMeters,
                ParseNumber(element, "y2") * CentimetersToMeters,
                ParseOptionalNumber(element, "data-z2") * CentimetersToMeters))
        {
            Layer = layer,
            Linetype = new Linetype(element.Attribute("data-termodel-linetype")?.Value?.Trim() ?? "Continuous"),
            Color = new AciColor(ParseOptionalInt(element, "data-termodel-color", 1))
        };

        // Conserva nel Virtual CAD anche i metadati di progetto che netDxf
        // storico non conosce. I chiamanti Desktop continuano a vedere layer,
        // colore e linetype; i nuovi adapter Core possono inoltre recuperare
        // rete, piano ed entità senza riparsare lo SVG.
        line.UserData = new SvgDxfLineMetadata(
            element.Attribute("id")?.Value?.Trim() ?? string.Empty,
            element.Attribute("data-termodel-piano")?.Value?.Trim() ?? string.Empty,
            element.Attribute("data-termodel-entity")?.Value?.Trim() ?? string.Empty,
            element.Attribute("data-termodel-rete")?.Value?.Trim() ?? string.Empty,
            layer.Name);

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
            document.Blocks.Add(new Block(blockName));

        Block definition = document.Blocks[blockName];
        foreach (string tag in values.Keys)
            if (!definition.AttributeTags.Contains(tag, StringComparer.OrdinalIgnoreCase))
                definition.AttributeTags.Add(tag);

        var insert = new Insert(
            definition,
            new Vector3(
                ParseNumber(element, "x") * CentimetersToMeters,
                ParseNumber(element, "y") * CentimetersToMeters,
                ParseOptionalNumber(element, "data-z") * CentimetersToMeters))
        {
            Layer = layer,
            Rotation = ParseOptionalNumber(element, "data-termodel-rotation")
        };

        foreach (netDxf.Entities.Attribute attribute in insert.Attributes)
            if (values.TryGetValue(attribute.Tag, out string? value))
                attribute.Value = NormalizeBlockAttributeValue(blockName, attribute.Tag, value);

        return insert;
    }

    private static string NormalizeBlockAttributeValue(string blockName, string tag, string value)
    {
        // Il CAD Web usa centimetri (data-termodel-units="cm"), mentre i blocchi
        // FIN del Desktop memorizzano LARGHEZZA/ALTEZZA/SOTTOFINESTRA/SOPRALUCE
        // in metri. Le coordinate erano gia convertite cm -> m, ma gli attributi
        // testuali FIN no: questo produceva finestre 100x fuori scala.
        if (!string.Equals(blockName, "FIN", StringComparison.OrdinalIgnoreCase))
            return value;

        if (!tag.Equals("LARGHEZZA", StringComparison.OrdinalIgnoreCase) &&
            !tag.Equals("ALTEZZA", StringComparison.OrdinalIgnoreCase) &&
            !tag.Equals("SOTTOFINESTRA", StringComparison.OrdinalIgnoreCase) &&
            !tag.Equals("SOPRALUCE", StringComparison.OrdinalIgnoreCase))
            return value;

        if (!double.TryParse(value, NumberStyles.Float, CultureInfo.InvariantCulture, out double centimeters) ||
            !double.IsFinite(centimeters))
            return value;

        return (centimeters * CentimetersToMeters)
            .ToString("G17", CultureInfo.InvariantCulture);
    }

    private static string Required(XElement element, string attribute) =>
        !string.IsNullOrWhiteSpace(element.Attribute(attribute)?.Value)
            ? element.Attribute(attribute)!.Value.Trim()
            : throw new InvalidDataException($"Attributo SVG obbligatorio '{attribute}' mancante.");

    private static double ParseNumber(XElement element, string attribute) =>
        double.TryParse(Required(element, attribute), NumberStyles.Float, CultureInfo.InvariantCulture, out double value) &&
        double.IsFinite(value)
            ? value
            : throw new InvalidDataException($"Attributo SVG '{attribute}' non numerico.");

    private static double ParseOptionalNumber(XElement element, string attribute)
    {
        string? raw = element.Attribute(attribute)?.Value;
        if (string.IsNullOrWhiteSpace(raw)) return 0;
        return double.TryParse(raw, NumberStyles.Float, CultureInfo.InvariantCulture, out double value) &&
               double.IsFinite(value)
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

    private sealed record FloorSource(
        XElement Group,
        string Id,
        string Name,
        string Role,
        string FileName,
        string Layer,
        int Order);
}
