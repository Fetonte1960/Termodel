using System.Globalization;
using System.Security;
using System.Text;
using System.Text.RegularExpressions;

namespace Termodel.Core.Cad;

public sealed record DxfSvgConversionOptions(
    IReadOnlyCollection<string>? Layers = null,
    string? Unit = null,
    bool Curves = false,
    bool ConvertText = false,
    bool ExplodeBlocks = false);

public sealed record DxfSvgConversionStats(
    int Converted,
    int Ignored,
    int Unsupported,
    int ExplodedBlocks);

public sealed record DxfSvgBounds(
    double MinX,
    double MinY,
    double MaxX,
    double MaxY,
    double Width,
    double Height);

public sealed record DxfSvgPoint(double X, double Y);

public sealed record DxfSvgConversionResult(
    string SvgText,
    DxfSvgConversionStats Stats,
    DxfSvgBounds Bounds,
    IReadOnlyList<double> ViewBox,
    string DrawingUnit,
    double UnitScaleToCm,
    double RealWidthMeters,
    double RealHeightMeters,
    DxfSvgPoint OriginOffsetCm,
    int UnitsCode,
    string UnitsLabel);

/// <summary>
/// Conversione headless del DXF ASCII 2D usato come sfondo del CAD Web.
/// Porta nel Core la conversione precedentemente eseguita dal browser.
/// Non crea entità Termodel: produce esclusivamente lo SVG di sfondo.
/// </summary>
public static class DxfSvgConverter
{
    private static readonly IReadOnlyDictionary<int, string> UnitNames =
        new Dictionary<int, string>
        {
            [0] = "senza unità",
            [1] = "pollici",
            [2] = "piedi",
            [4] = "mm",
            [5] = "cm",
            [6] = "m",
            [10] = "yard"
        };

    public static DxfSvgConversionResult Convert(
        string dxfText,
        DxfSvgConversionOptions? options = null)
    {
        DxfModel model = Parse(dxfText);
        NormalizedOptions normalized = NormalizeOptions(model, options);
        var layerPaths = new Dictionary<string, List<string>>(StringComparer.Ordinal);
        var textItems = new List<TextItem>();
        int converted = 0;
        int ignored = 0;
        int unsupported = 0;
        int explodedBlocks = 0;

        double minX = double.PositiveInfinity;
        double minY = double.PositiveInfinity;
        double maxX = double.NegativeInfinity;
        double maxY = double.NegativeInfinity;

        void UpdateBounds(DxfPoint point)
        {
            if (!double.IsFinite(point.X) || !double.IsFinite(point.Y))
                return;

            double svgY = -point.Y;
            minX = Math.Min(minX, point.X);
            maxX = Math.Max(maxX, point.X);
            minY = Math.Min(minY, svgY);
            maxY = Math.Max(maxY, svgY);
        }

        List<string> PathForLayer(string layer)
        {
            string key = string.IsNullOrWhiteSpace(layer) ? "0" : layer;
            if (!layerPaths.TryGetValue(key, out List<string>? paths))
            {
                paths = [];
                layerPaths[key] = paths;
            }

            return paths;
        }

        DxfPoint ScalePointToCm(DxfPoint point) =>
            new(point.X * normalized.UnitScaleToCm, point.Y * normalized.UnitScaleToCm);

        bool EmitPolyline(
            IReadOnlyList<DxfPoint> points,
            double[] matrix,
            string layer)
        {
            if (points.Count < 2)
                return false;

            var transformed = points
                .Select(point => ScalePointToCm(TransformPoint(matrix, point)))
                .ToArray();

            foreach (DxfPoint point in transformed)
                UpdateBounds(point);

            string commands = string.Join(
                " ",
                transformed.Select((point, index) =>
                    (index == 0 ? "M " : "L ") +
                    F5(point.X) + " " + F5(-point.Y)));

            PathForLayer(layer).Add(commands);
            return true;
        }

        void RenderEntity(
            DxfEntity? entity,
            double[]? matrix = null,
            string inheritedLayer = "",
            int depth = 0)
        {
            matrix ??= Identity();

            if (entity is null || depth > 8)
            {
                ignored++;
                return;
            }

            string layer =
                entity.Layer == "0" && !string.IsNullOrWhiteSpace(inheritedLayer)
                    ? inheritedLayer
                    : (string.IsNullOrWhiteSpace(entity.Layer) ? "0" : entity.Layer);

            if (!normalized.Layers.Contains(layer))
            {
                ignored++;
                return;
            }

            if (entity.Type == "INSERT")
            {
                if (!normalized.ExplodeBlocks)
                {
                    ignored++;
                    return;
                }

                if (string.IsNullOrWhiteSpace(entity.Block) ||
                    !model.Blocks.TryGetValue(entity.Block, out DxfBlock? block))
                {
                    unsupported++;
                    return;
                }

                double[] local = InsertMatrix(entity, block);
                double[] combined = Multiply(matrix, local);
                explodedBlocks++;

                foreach (DxfEntity child in block.Entities)
                    RenderEntity(child, combined, layer, depth + 1);

                return;
            }

            bool emitted = false;

            if (entity.Type == "LINE")
            {
                emitted = EmitPolyline(
                    [entity.Start, entity.End],
                    matrix,
                    layer);
            }
            else if (entity.Type is "LWPOLYLINE" or "POLYLINE")
            {
                emitted = EmitPolyline(
                    PolylinePoints(entity, normalized.Curves),
                    matrix,
                    layer);
            }
            else if (normalized.Curves && entity.Type == "ARC")
            {
                emitted = EmitPolyline(
                    ArcPoints(entity, false),
                    matrix,
                    layer);
            }
            else if (normalized.Curves && entity.Type == "CIRCLE")
            {
                emitted = EmitPolyline(
                    ArcPoints(entity, true),
                    matrix,
                    layer);
            }
            else if (normalized.Curves && entity.Type == "ELLIPSE")
            {
                emitted = EmitPolyline(
                    EllipsePoints(entity),
                    matrix,
                    layer);
            }
            else if (normalized.Curves && entity.Type == "SPLINE")
            {
                emitted = EmitPolyline(
                    entity.ControlPoints,
                    matrix,
                    layer);
            }
            else if (
                normalized.ConvertText &&
                entity.Type is "TEXT" or "MTEXT")
            {
                DxfPoint point =
                    ScalePointToCm(TransformPoint(matrix, entity.Point));
                UpdateBounds(point);

                string text = CleanMText(entity.Text);
                if (!string.IsNullOrWhiteSpace(text))
                {
                    textItems.Add(new TextItem(
                        layer,
                        point.X,
                        -point.Y,
                        Math.Max(
                            0.1,
                            (entity.Height <= 0 ? 2.5 : entity.Height) *
                            normalized.UnitScaleToCm),
                        -entity.Rotation,
                        text));
                    emitted = true;
                }
            }
            else
            {
                ignored++;
                return;
            }

            if (emitted)
                converted++;
            else
                unsupported++;
        }

        foreach (DxfEntity entity in model.Entities)
            RenderEntity(entity);

        if (!double.IsFinite(minX) ||
            !double.IsFinite(minY) ||
            !double.IsFinite(maxX) ||
            !double.IsFinite(maxY))
        {
            throw new InvalidDataException(
                "Le opzioni selezionate non producono geometria DXF visibile.");
        }

        double width = Math.Max(1e-6, maxX - minX);
        double height = Math.Max(1e-6, maxY - minY);
        double originShiftX = -minX;
        double originShiftY = -minY;
        double margin = Math.Max(width, height) * 0.02;
        if (margin == 0)
            margin = 1;

        double[] viewBox =
        [
            -margin,
            -margin,
            width + margin * 2,
            height + margin * 2
        ];

        var groups = new List<string>();

        foreach ((string layer, List<string> paths) in layerPaths)
        {
            if (paths.Count == 0)
                continue;

            groups.Add(
                "<g data-dxf-layer=\"" + EscapeXml(layer) + "\">" +
                "<path d=\"" + string.Join(" ", paths) + "\" />" +
                "</g>");
        }

        foreach (TextItem item in textItems)
        {
            string transform = item.Rotation == 0
                ? string.Empty
                : " transform=\"rotate(" +
                  F3(item.Rotation) + " " +
                  F5(item.X) + " " +
                  F5(item.Y) + ")\"";

            groups.Add(
                "<text data-dxf-layer=\"" + EscapeXml(item.Layer) + "\"" +
                " x=\"" + F5(item.X) + "\"" +
                " y=\"" + F5(item.Y) + "\"" +
                " font-family=\"Arial, sans-serif\"" +
                " font-size=\"" + F5(item.Height) + "\"" +
                " fill=\"#222\" stroke=\"none\"" +
                transform + ">" +
                EscapeXml(item.Text) +
                "</text>");
        }

        string svgText =
            "<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
            "<svg xmlns=\"http://www.w3.org/2000/svg\"" +
            " viewBox=\"" +
            string.Join(" ", viewBox.Select(F5)) + "\"" +
            " width=\"" + F5(viewBox[2]) + "cm\"" +
            " height=\"" + F5(viewBox[3]) + "cm\"" +
            " fill=\"none\" stroke=\"#222\" stroke-width=\"" +
            G17(Math.Max(width, height) / 1800.0) + "\"" +
            " stroke-linecap=\"round\" stroke-linejoin=\"round\"" +
            " data-termodel-dxf-plotter=\"1\"" +
            " data-termodel-source-unit=\"" + normalized.Unit + "\"" +
            " data-termodel-unit-scale-cm=\"" +
            G17(normalized.UnitScaleToCm) + "\"" +
            " data-termodel-coordinate-normalization=\"origin\">" +
            "<g transform=\"translate(" +
            F5(originShiftX) + " " + F5(originShiftY) + ")\">" +
            string.Join(string.Empty, groups) +
            "</g></svg>";

        return new DxfSvgConversionResult(
            SvgText: svgText,
            Stats: new DxfSvgConversionStats(
                converted,
                ignored,
                unsupported,
                explodedBlocks),
            Bounds: new DxfSvgBounds(
                minX,
                minY,
                maxX,
                maxY,
                width,
                height),
            ViewBox: viewBox,
            DrawingUnit: normalized.Unit,
            UnitScaleToCm: normalized.UnitScaleToCm,
            RealWidthMeters: width / 100.0,
            RealHeightMeters: height / 100.0,
            OriginOffsetCm: new DxfSvgPoint(minX, minY),
            UnitsCode: model.InsUnits,
            UnitsLabel: model.UnitsLabel);
    }

    private static DxfModel Parse(string? text)
    {
        IReadOnlyList<DxfPair> pairs = DxfPairs(text);
        if (pairs.Count == 0)
        {
            throw new InvalidDataException(
                "Il file DXF non contiene coppie group-code leggibili.");
        }

        IReadOnlyList<DxfPair> header = FindSection(pairs, "HEADER");
        IReadOnlyList<DxfPair> tables = FindSection(pairs, "TABLES");
        IReadOnlyList<DxfPair> blocksSection = FindSection(pairs, "BLOCKS");
        IReadOnlyList<DxfPair> entitiesSection = FindSection(pairs, "ENTITIES");

        int insUnits = ParseInsUnits(header);
        HashSet<string> tableLayers = ParseLayerTable(tables);
        Dictionary<string, DxfBlock> blocks = ParseBlocks(blocksSection);
        List<DxfEntity> entities = ParseEntities(entitiesSection);

        if (entities.Count == 0 && blocks.Count == 0)
        {
            throw new InvalidDataException(
                "Il DXF non contiene entità 2D convertibili.");
        }

        var layerCounts =
            new Dictionary<string, int>(StringComparer.Ordinal);

        foreach (string layer in tableLayers)
            layerCounts.TryAdd(layer, 0);

        void AddLayer(string? layer)
        {
            string key = string.IsNullOrWhiteSpace(layer)
                ? "0"
                : layer.Trim();

            layerCounts.TryGetValue(key, out int count);
            layerCounts[key] = count + 1;
        }

        foreach (DxfEntity entity in entities)
            AddLayer(entity.Layer);

        foreach (DxfBlock block in blocks.Values)
        {
            foreach (DxfEntity entity in block.Entities)
                AddLayer(entity.Layer);
        }

        string unitsLabel =
            UnitNames.TryGetValue(insUnits, out string? name)
                ? name
                : "codice " + insUnits.ToString(CultureInfo.InvariantCulture);

        return new DxfModel(
            insUnits,
            unitsLabel,
            blocks,
            entities,
            layerCounts.Keys.ToArray());
    }

    private static IReadOnlyList<DxfPair> DxfPairs(string? text)
    {
        string normalized = (text ?? string.Empty)
            .Replace("\r", string.Empty, StringComparison.Ordinal);
        string[] lines = normalized.Split('\n');
        var pairs = new List<DxfPair>();

        for (int i = 0; i + 1 < lines.Length; i += 2)
        {
            string rawCode = lines[i]
                .TrimStart('\uFEFF')
                .Trim();

            if (rawCode.Length == 0 ||
                !int.TryParse(
                    rawCode,
                    NumberStyles.Integer,
                    CultureInfo.InvariantCulture,
                    out int code))
            {
                continue;
            }

            pairs.Add(new DxfPair(code, lines[i + 1].TrimEnd()));
        }

        return pairs;
    }

    private static IReadOnlyList<DxfPair> FindSection(
        IReadOnlyList<DxfPair> pairs,
        string name)
    {
        for (int i = 0; i < pairs.Count - 1; i++)
        {
            if (pairs[i].Code == 0 &&
                pairs[i].Value == "SECTION" &&
                pairs[i + 1].Code == 2 &&
                pairs[i + 1].Value == name)
            {
                int start = i + 2;
                for (int j = start; j < pairs.Count; j++)
                {
                    if (pairs[j].Code == 0 &&
                        pairs[j].Value == "ENDSEC")
                    {
                        return pairs
                            .Skip(start)
                            .Take(j - start)
                            .ToArray();
                    }
                }
            }
        }

        return [];
    }

    private static int ParseInsUnits(IReadOnlyList<DxfPair> section)
    {
        for (int i = 0; i < section.Count; i++)
        {
            if (section[i].Code != 9 ||
                section[i].Value != "$INSUNITS")
            {
                continue;
            }

            for (int j = i + 1;
                 j < section.Count && section[j].Code != 9;
                 j++)
            {
                if (section[j].Code == 70)
                    return IntValue(section[j].Value);
            }
        }

        return 0;
    }

    private static HashSet<string> ParseLayerTable(
        IReadOnlyList<DxfPair> section)
    {
        var layers = new HashSet<string>(StringComparer.Ordinal);

        for (int i = 0; i < section.Count; i++)
        {
            if (section[i].Code != 0 ||
                section[i].Value != "LAYER")
            {
                continue;
            }

            var fields = new List<DxfPair>();
            for (i = i + 1;
                 i < section.Count && section[i].Code != 0;
                 i++)
            {
                fields.Add(section[i]);
            }

            i--;
            string name = First(fields, 2, "0").Trim();
            layers.Add(name.Length == 0 ? "0" : name);
        }

        return layers;
    }

    private static List<DxfEntity> ParseEntities(
        IReadOnlyList<DxfPair> section)
    {
        var entities = new List<DxfEntity>();
        int i = 0;

        while (i < section.Count)
        {
            if (section[i].Code != 0)
            {
                i++;
                continue;
            }

            (DxfEntity? entity, int nextIndex) =
                ParseEntityAt(section, i);

            if (entity is not null &&
                entity.Type.Length > 0 &&
                entity.Type is not "ENDSEC" and not "SEQEND")
            {
                entities.Add(entity);
            }

            i = Math.Max(nextIndex, i + 1);
        }

        return entities;
    }

    private static Dictionary<string, DxfBlock> ParseBlocks(
        IReadOnlyList<DxfPair> section)
    {
        var blocks =
            new Dictionary<string, DxfBlock>(StringComparer.Ordinal);
        int i = 0;

        while (i < section.Count)
        {
            if (section[i].Code != 0 ||
                section[i].Value != "BLOCK")
            {
                i++;
                continue;
            }

            var header = new List<DxfPair>();
            i++;
            while (i < section.Count && section[i].Code != 0)
            {
                header.Add(section[i]);
                i++;
            }

            string name = First(
                header,
                2,
                First(header, 3, string.Empty)).Trim();
            DxfPoint basePoint = PointFrom(header, 10, 20);
            var entities = new List<DxfEntity>();

            while (i < section.Count)
            {
                if (section[i].Code == 0 &&
                    section[i].Value == "ENDBLK")
                {
                    i++;
                    break;
                }

                if (section[i].Code != 0)
                {
                    i++;
                    continue;
                }

                (DxfEntity? entity, int nextIndex) =
                    ParseEntityAt(section, i);

                if (entity is not null)
                    entities.Add(entity);

                i = Math.Max(nextIndex, i + 1);
            }

            if (name.Length > 0)
                blocks[name] = new DxfBlock(name, basePoint, entities);
        }

        return blocks;
    }

    private static (DxfEntity? Entity, int NextIndex) ParseEntityAt(
        IReadOnlyList<DxfPair> section,
        int startIndex)
    {
        if (startIndex < 0 ||
            startIndex >= section.Count ||
            section[startIndex].Code != 0)
        {
            return (null, startIndex + 1);
        }

        string type = section[startIndex].Value;
        var headerFields = new List<DxfPair>();
        int i = startIndex + 1;

        while (i < section.Count && section[i].Code != 0)
        {
            headerFields.Add(section[i]);
            i++;
        }

        if (type != "POLYLINE")
            return (ParseSimpleEntity(type, headerFields), i);

        string layer = First(headerFields, 8, "0").Trim();
        if (layer.Length == 0)
            layer = "0";

        var polyline = new DxfEntity(type, layer)
        {
            Closed = (IntValue(First(headerFields, 70, "0")) & 1) != 0
        };

        while (i < section.Count)
        {
            if (section[i].Code != 0)
            {
                i++;
                continue;
            }

            string childType = section[i].Value;
            if (childType == "SEQEND")
            {
                i++;
                break;
            }

            if (childType != "VERTEX")
                break;

            var vertexFields = new List<DxfPair>();
            i++;

            while (i < section.Count && section[i].Code != 0)
            {
                vertexFields.Add(section[i]);
                i++;
            }

            polyline.Vertices.Add(new DxfVertex(
                Number(First(vertexFields, 10, "0")),
                Number(First(vertexFields, 20, "0")),
                Number(First(vertexFields, 42, "0"))));
        }

        return (polyline, i);
    }

    private static DxfEntity ParseSimpleEntity(
        string type,
        IReadOnlyList<DxfPair> fields)
    {
        string layer = First(fields, 8, "0").Trim();
        if (layer.Length == 0)
            layer = "0";

        var entity = new DxfEntity(type, layer);

        switch (type)
        {
            case "LINE":
                entity.Start = PointFrom(fields, 10, 20);
                entity.End = PointFrom(fields, 11, 21);
                break;

            case "LWPOLYLINE":
                entity.Vertices.AddRange(ParsePolylineVertices(fields));
                entity.Closed =
                    (IntValue(First(fields, 70, "0")) & 1) != 0;
                break;

            case "ARC":
                entity.Center = PointFrom(fields, 10, 20);
                entity.Radius =
                    Math.Abs(Number(First(fields, 40, "0")));
                entity.StartAngle =
                    Number(First(fields, 50, "0"));
                entity.EndAngle =
                    Number(First(fields, 51, "0"));
                break;

            case "CIRCLE":
                entity.Center = PointFrom(fields, 10, 20);
                entity.Radius =
                    Math.Abs(Number(First(fields, 40, "0")));
                break;

            case "ELLIPSE":
                entity.Center = PointFrom(fields, 10, 20);
                entity.Major = PointFrom(fields, 11, 21);
                entity.Ratio =
                    Math.Abs(Number(First(fields, 40, "1"), 1));
                entity.StartParam =
                    Number(First(fields, 41, "0"));
                entity.EndParam =
                    Number(
                        First(
                            fields,
                            42,
                            (Math.PI * 2).ToString(
                                CultureInfo.InvariantCulture)),
                        Math.PI * 2);
                break;

            case "SPLINE":
            {
                DxfPoint? current = null;
                foreach (DxfPair pair in fields)
                {
                    if (pair.Code == 10)
                    {
                        current = new DxfPoint(Number(pair.Value), 0);
                        entity.ControlPoints.Add(current.Value);
                    }
                    else if (pair.Code == 20 &&
                             current.HasValue &&
                             entity.ControlPoints.Count > 0)
                    {
                        DxfPoint updated =
                            new(current.Value.X, Number(pair.Value));
                        entity.ControlPoints[^1] = updated;
                        current = updated;
                    }
                }

                break;
            }

            case "TEXT":
                entity.Point = PointFrom(fields, 10, 20);
                entity.Height =
                    Math.Abs(Number(First(fields, 40, "2.5"), 2.5));
                entity.Rotation =
                    Number(First(fields, 50, "0"));
                entity.Text = First(fields, 1, string.Empty);
                break;

            case "MTEXT":
                entity.Point = PointFrom(fields, 10, 20);
                entity.Height =
                    Math.Abs(Number(First(fields, 40, "2.5"), 2.5));
                entity.Rotation =
                    Number(First(fields, 50, "0"));
                entity.Text = string.Concat(
                    All(fields, 3).Concat(All(fields, 1)));
                break;

            case "INSERT":
                entity.Block = First(fields, 2, string.Empty).Trim();
                entity.Point = PointFrom(fields, 10, 20);
                entity.ScaleX =
                    Number(First(fields, 41, "1"), 1);
                entity.ScaleY =
                    Number(First(fields, 42, "1"), 1);
                entity.Rotation =
                    Number(First(fields, 50, "0"));
                break;
        }

        return entity;
    }

    private static IReadOnlyList<DxfVertex> ParsePolylineVertices(
        IReadOnlyList<DxfPair> fields)
    {
        var vertices = new List<DxfVertex>();
        int currentIndex = -1;

        foreach (DxfPair pair in fields)
        {
            if (pair.Code == 10)
            {
                vertices.Add(new DxfVertex(Number(pair.Value), 0, 0));
                currentIndex = vertices.Count - 1;
            }
            else if (pair.Code == 20 && currentIndex >= 0)
            {
                DxfVertex current = vertices[currentIndex];
                vertices[currentIndex] =
                    current with { Y = Number(pair.Value) };
            }
            else if (pair.Code == 42 && currentIndex >= 0)
            {
                DxfVertex current = vertices[currentIndex];
                vertices[currentIndex] =
                    current with { Bulge = Number(pair.Value) };
            }
        }

        return vertices;
    }

    private static NormalizedOptions NormalizeOptions(
        DxfModel model,
        DxfSvgConversionOptions? options)
    {
        options ??= new DxfSvgConversionOptions();

        var selectedLayers =
            options.Layers is { Count: > 0 }
                ? new HashSet<string>(
                    options.Layers
                        .Where(layer => !string.IsNullOrWhiteSpace(layer))
                        .Select(layer => layer.Trim()),
                    StringComparer.Ordinal)
                : new HashSet<string>(
                    model.Layers,
                    StringComparer.Ordinal);

        string unit =
            options.Unit is "m" or "cm" or "mm"
                ? options.Unit
                : UnitFromInsUnits(model.InsUnits);

        return new NormalizedOptions(
            selectedLayers,
            options.Curves,
            options.ConvertText,
            options.ExplodeBlocks,
            unit,
            UnitScaleToCm(unit));
    }

    private static string UnitFromInsUnits(int insUnits) =>
        insUnits switch
        {
            4 => "mm",
            5 => "cm",
            6 => "m",
            _ => "cm"
        };

    private static double UnitScaleToCm(string unit) =>
        unit switch
        {
            "mm" => 0.1,
            "m" => 100,
            _ => 1
        };

    private static IReadOnlyList<DxfPoint> PolylinePoints(
        DxfEntity entity,
        bool includeCurves)
    {
        if (entity.Vertices.Count < 2)
            return [];

        var result = new List<DxfPoint>
        {
            entity.Vertices[0].Point
        };

        int count =
            entity.Closed
                ? entity.Vertices.Count
                : entity.Vertices.Count - 1;

        for (int i = 0; i < count; i++)
        {
            DxfVertex a = entity.Vertices[i];
            DxfVertex b =
                entity.Vertices[(i + 1) % entity.Vertices.Count];

            IReadOnlyList<DxfPoint> segment =
                includeCurves && a.Bulge != 0
                    ? BulgeSegment(a.Point, b.Point, a.Bulge)
                    : [a.Point, b.Point];

            result.AddRange(segment.Skip(1));
        }

        return result;
    }

    private static IReadOnlyList<DxfPoint> BulgeSegment(
        DxfPoint a,
        DxfPoint b,
        double bulge)
    {
        if (Math.Abs(bulge) < 1e-9)
            return [a, b];

        double dx = b.X - a.X;
        double dy = b.Y - a.Y;
        double chord = Math.Hypot(dx, dy);

        if (chord < 1e-9)
            return [a, b];

        double theta = 4 * Math.Atan(bulge);
        double offset = chord / (2 * Math.Tan(theta / 2));
        double mx = (a.X + b.X) / 2;
        double my = (a.Y + b.Y) / 2;
        double nx = -dy / chord;
        double ny = dx / chord;
        DxfPoint center =
            new(mx + nx * offset, my + ny * offset);
        double radius =
            Math.Hypot(a.X - center.X, a.Y - center.Y);
        double start =
            Math.Atan2(a.Y - center.Y, a.X - center.X);
        int segments =
            Math.Max(
                4,
                (int)Math.Ceiling(
                    Math.Abs(theta) / (Math.PI / 18)));

        var points = new List<DxfPoint>(segments + 1);
        for (int i = 0; i <= segments; i++)
        {
            double t = start + theta * (i / (double)segments);
            points.Add(new DxfPoint(
                center.X + radius * Math.Cos(t),
                center.Y + radius * Math.Sin(t)));
        }

        return points;
    }

    private static IReadOnlyList<DxfPoint> ArcPoints(
        DxfEntity entity,
        bool fullCircle)
    {
        if (entity.Radius == 0)
            return [];

        double start =
            fullCircle
                ? 0
                : entity.StartAngle * Math.PI / 180;
        double end =
            fullCircle
                ? Math.PI * 2
                : entity.EndAngle * Math.PI / 180;

        if (!fullCircle)
        {
            while (end <= start)
                end += Math.PI * 2;
        }

        double sweep = end - start;
        int segments =
            Math.Max(
                12,
                (int)Math.Ceiling(
                    Math.Abs(sweep) / (Math.PI / 36)));

        var points = new List<DxfPoint>(segments + 1);
        for (int i = 0; i <= segments; i++)
        {
            double t = start + sweep * (i / (double)segments);
            points.Add(new DxfPoint(
                entity.Center.X + entity.Radius * Math.Cos(t),
                entity.Center.Y + entity.Radius * Math.Sin(t)));
        }

        return points;
    }

    private static IReadOnlyList<DxfPoint> EllipsePoints(
        DxfEntity entity)
    {
        double majorLength =
            Math.Hypot(entity.Major.X, entity.Major.Y);

        if (majorLength == 0)
            return [];

        double majorAngle =
            Math.Atan2(entity.Major.Y, entity.Major.X);
        double minorLength =
            majorLength * (entity.Ratio == 0 ? 1 : entity.Ratio);
        double start = entity.StartParam;
        double end = entity.EndParam;

        while (end <= start)
            end += Math.PI * 2;

        double sweep = end - start;
        int segments =
            Math.Max(
                18,
                (int)Math.Ceiling(
                    Math.Abs(sweep) / (Math.PI / 36)));
        double c = Math.Cos(majorAngle);
        double s = Math.Sin(majorAngle);

        var points = new List<DxfPoint>(segments + 1);
        for (int i = 0; i <= segments; i++)
        {
            double t = start + sweep * (i / (double)segments);
            double lx = majorLength * Math.Cos(t);
            double ly = minorLength * Math.Sin(t);
            points.Add(new DxfPoint(
                entity.Center.X + lx * c - ly * s,
                entity.Center.Y + lx * s + ly * c));
        }

        return points;
    }

    private static double[] InsertMatrix(
        DxfEntity entity,
        DxfBlock block) =>
        Multiply(
            Translation(entity.Point.X, entity.Point.Y),
            Multiply(
                Rotation(entity.Rotation),
                Multiply(
                    Scaling(entity.ScaleX, entity.ScaleY),
                    Translation(-block.Base.X, -block.Base.Y))));

    private static double[] Identity() =>
        [1, 0, 0, 1, 0, 0];

    private static double[] Multiply(
        IReadOnlyList<double> a,
        IReadOnlyList<double> b) =>
        [
            a[0] * b[0] + a[2] * b[1],
            a[1] * b[0] + a[3] * b[1],
            a[0] * b[2] + a[2] * b[3],
            a[1] * b[2] + a[3] * b[3],
            a[0] * b[4] + a[2] * b[5] + a[4],
            a[1] * b[4] + a[3] * b[5] + a[5]
        ];

    private static double[] Translation(double x, double y) =>
        [1, 0, 0, 1, x, y];

    private static double[] Scaling(double x, double y) =>
        [x, 0, 0, y, 0, 0];

    private static double[] Rotation(double degrees)
    {
        double radians = degrees * Math.PI / 180;
        double c = Math.Cos(radians);
        double s = Math.Sin(radians);
        return [c, s, -s, c, 0, 0];
    }

    private static DxfPoint TransformPoint(
        IReadOnlyList<double> matrix,
        DxfPoint point) =>
        new(
            matrix[0] * point.X +
            matrix[2] * point.Y +
            matrix[4],
            matrix[1] * point.X +
            matrix[3] * point.Y +
            matrix[5]);

    private static DxfPoint PointFrom(
        IReadOnlyList<DxfPair> fields,
        int xCode,
        int yCode) =>
        new(
            Number(First(fields, xCode, "0")),
            Number(First(fields, yCode, "0")));

    private static string First(
        IReadOnlyList<DxfPair> fields,
        int code,
        string fallback)
    {
        foreach (DxfPair pair in fields)
        {
            if (pair.Code == code)
                return pair.Value;
        }

        return fallback;
    }

    private static IReadOnlyList<string> All(
        IReadOnlyList<DxfPair> fields,
        int code) =>
        fields
            .Where(pair => pair.Code == code)
            .Select(pair => pair.Value)
            .ToArray();

    private static double Number(
        string? value,
        double fallback = 0) =>
        double.TryParse(
            value,
            NumberStyles.Float,
            CultureInfo.InvariantCulture,
            out double parsed)
                ? parsed
                : fallback;

    private static int IntValue(string? value) =>
        int.TryParse(
            value,
            NumberStyles.Integer,
            CultureInfo.InvariantCulture,
            out int parsed)
                ? parsed
                : (int)Number(value);

    private static string CleanMText(string? value)
    {
        string text = value ?? string.Empty;
        text = Regex.Replace(
            text,
            @"\\P",
            " ",
            RegexOptions.IgnoreCase);
        text = Regex.Replace(text, @"\{\\[^;]+;", string.Empty);
        text = Regex.Replace(text, @"[{}]", string.Empty);
        text = Regex.Replace(
            text,
            @"\\[A-Za-z][^;]*;",
            string.Empty);
        return text.Trim();
    }

    private static string EscapeXml(string? value) =>
        SecurityElement.Escape(value ?? string.Empty) ??
        string.Empty;

    private static string F5(double value) =>
        value.ToString("F5", CultureInfo.InvariantCulture);

    private static string F3(double value) =>
        value.ToString("F3", CultureInfo.InvariantCulture);

    private static string G17(double value) =>
        value.ToString("G17", CultureInfo.InvariantCulture);

    private sealed record DxfPair(int Code, string Value);

    private readonly record struct DxfPoint(double X, double Y);

    private sealed record DxfVertex(
        double X,
        double Y,
        double Bulge)
    {
        public DxfPoint Point => new(X, Y);
    }

    private sealed class DxfEntity
    {
        public DxfEntity(string type, string layer)
        {
            Type = type;
            Layer = layer;
        }

        public string Type { get; }
        public string Layer { get; }
        public DxfPoint Start { get; set; }
        public DxfPoint End { get; set; }
        public DxfPoint Center { get; set; }
        public DxfPoint Major { get; set; }
        public DxfPoint Point { get; set; }
        public double Radius { get; set; }
        public double StartAngle { get; set; }
        public double EndAngle { get; set; }
        public double Ratio { get; set; } = 1;
        public double StartParam { get; set; }
        public double EndParam { get; set; } = Math.PI * 2;
        public double Height { get; set; } = 2.5;
        public double Rotation { get; set; }
        public string Text { get; set; } = string.Empty;
        public string Block { get; set; } = string.Empty;
        public double ScaleX { get; set; } = 1;
        public double ScaleY { get; set; } = 1;
        public bool Closed { get; set; }
        public List<DxfVertex> Vertices { get; } = [];
        public List<DxfPoint> ControlPoints { get; } = [];
    }

    private sealed record DxfBlock(
        string Name,
        DxfPoint Base,
        IReadOnlyList<DxfEntity> Entities);

    private sealed record DxfModel(
        int InsUnits,
        string UnitsLabel,
        IReadOnlyDictionary<string, DxfBlock> Blocks,
        IReadOnlyList<DxfEntity> Entities,
        IReadOnlyList<string> Layers);

    private sealed record NormalizedOptions(
        HashSet<string> Layers,
        bool Curves,
        bool ConvertText,
        bool ExplodeBlocks,
        string Unit,
        double UnitScaleToCm);

    private sealed record TextItem(
        string Layer,
        double X,
        double Y,
        double Height,
        double Rotation,
        string Text);
}
