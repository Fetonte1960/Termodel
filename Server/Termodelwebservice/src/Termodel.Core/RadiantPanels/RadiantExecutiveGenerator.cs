using System.Globalization;
using System.Text;
using System.Xml.Linq;
using Termodel.Core.NetDxfCompat;
using Termodel.Core.ProjectFiles;
using Termodel.Impianti.Pannelli;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Genera l'esecutivo pannelli con un motore selezionabile
/// Vittorio | GPT | Diego. Il default resta GPT per compatibilita.
/// DXF e SVG vengono serializzati dallo stesso modello grafico neutro.
/// Il grafo/collettore resta intenzionalmente fuori scope: senza
/// retePannelli.xml le corrispondenti routine Desktop sono no-op.
/// </summary>
public static class RadiantExecutiveGenerator
{
    private static readonly object SpiralEngineGate = new();

    public static RadiantExecutiveArtifacts? Generate(
        string projectText,
        string? panelInputXml)
    {
        if (string.IsNullOrWhiteSpace(panelInputXml))
            return null;

        XDocument panelDocument;
        try
        {
            panelDocument = XDocument.Parse(
                panelInputXml,
                LoadOptions.PreserveWhitespace);
        }
        catch (Exception exception)
        {
            throw new InvalidDataException(
                $"Input pannelli headless non valido: {exception.Message}",
                exception);
        }

        if (panelDocument.Root is null)
            return null;

        List<XElement> floorNodes = panelDocument.Root
            .Elements("Piano")
            .Where(floor =>
                floor.Element("Tubi")?.Elements("Linea").Any() == true)
            .ToList();

        if (floorNodes.Count == 0)
            return null;

        ProjectTextDocument project = ProjectTextDocument.Parse(projectText);
        IReadOnlyList<SvgDxfFloor> sourceFloors = SvgDxfReader.ParseProjectSvg(
            project.GetRequiredSection("geometry/project.svg"));

        var drawing = new RadiantExecutiveDrawing();
        var diagnostics = new List<string>();
        RadiantSpiralEngine selectedEngine = ResolveSpiralEngine();
        double selectedStepMeters = SpiralHeatingGPT.Program.PassoTubi;
        int generatedFloors = 0;

        diagnostics.Add($"Motore spirali selezionato: {selectedEngine}.");

        foreach (XElement floorNode in floorNodes)
        {
            string floorName =
                ((string?)floorNode.Attribute("Nome") ?? string.Empty).Trim();
            if (floorName.Length == 0)
                continue;

            XDocument floorInput = BuildFloorInput(
                panelDocument,
                floorNode,
                floorName);

            int localeCount = floorInput
                .Descendants("Locale")
                .Count();
            if (localeCount == 0)
            {
                diagnostics.Add(
                    $"Piano {floorName}: nessun locale disponibile per il motore spirali.");
                continue;
            }

            SpiralEngineOutput engineOutput = RunSpiralEngine(
                floorInput,
                floorName,
                selectedEngine);
            string generatedSvg = engineOutput.Svg;
            selectedStepMeters = engineOutput.StepMeters;

            AddBuildingGeometry(
                drawing,
                sourceFloors,
                floorName);

            int before = drawing.Primitives.Count;
            AddSpiralSvgGeometry(
                drawing,
                generatedSvg,
                floorName);
            int generatedPrimitives =
                drawing.Primitives.Count - before;

            if (generatedPrimitives == 0)
            {
                throw new InvalidDataException(
                    $"Piano {floorName}: il motore {selectedEngine} non ha prodotto primitive esecutive.");
            }

            generatedFloors++;
            diagnostics.Add(
                $"Piano {floorName}: esecutivo generato con {selectedEngine}, " +
                $"passo {engineOutput.StepMeters:0.###} m, " +
                $"{generatedPrimitives} primitive pannelli.");
            diagnostics.AddRange(engineOutput.Diagnostics);
        }

        if (generatedFloors == 0)
            return null;

        byte[] svg = Encoding.UTF8.GetBytes(
            RadiantExecutiveSvgWriter.Write(drawing));
        byte[] dxf = Encoding.UTF8.GetBytes(
            RadiantExecutiveDxfWriter.Write(drawing));

        return new RadiantExecutiveArtifacts(
            svg,
            dxf,
            drawing.Primitives.Count,
            generatedFloors,
            selectedStepMeters,
            diagnostics);
    }

    private static XDocument BuildFloorInput(
        XDocument source,
        XElement floorNode,
        string floorName)
    {
        XElement sourceRoot = source.Root
            ?? throw new InvalidDataException(
                "Documento pannelli privo di root Locali.");

        var root = new XElement(
            "Locali",
            sourceRoot.Attributes().Select(attribute =>
                new XAttribute(attribute)));

        List<XElement> allFloors = sourceRoot
            .Elements("Piano")
            .ToList();
        bool singleFloor = allFloors.Count == 1;

        foreach (XElement locale in sourceRoot.Elements("Locale"))
        {
            string localeFloor =
                ((string?)locale.Attribute("Piano") ?? string.Empty).Trim();

            if (localeFloor.Equals(
                    floorName,
                    StringComparison.OrdinalIgnoreCase) ||
                (singleFloor && localeFloor.Length == 0))
            {
                root.Add(new XElement(locale));
            }
        }

        root.Add(new XElement(floorNode));
        return new XDocument(
            new XDeclaration("1.0", "utf-8", "yes"),
            root);
    }

    private static RadiantSpiralEngine ResolveSpiralEngine()
    {
        string? configured =
            Environment.GetEnvironmentVariable("TERMODEL_SPIRAL_ENGINE");

        if (string.IsNullOrWhiteSpace(configured))
            return RadiantSpiralEngine.GPT;

        if (Enum.TryParse(
                configured.Trim(),
                ignoreCase: true,
                out RadiantSpiralEngine engine))
        {
            return engine;
        }

        throw new InvalidDataException(
            $"TERMODEL_SPIRAL_ENGINE non riconosciuto: '{configured}'. " +
            "Valori ammessi: Vittorio, GPT, Diego.");
    }

    private static SpiralEngineOutput RunSpiralEngine(
        XDocument floorInput,
        string floorName,
        RadiantSpiralEngine engine)
    {
        if (engine == RadiantSpiralEngine.Diego)
        {
            StrategiaDiegoResult result =
                StrategiaDiegoEngine.Generate(floorInput);

            return new SpiralEngineOutput(
                result.Svg,
                result.StepMeters,
                result.Diagnostics);
        }

        string tempRoot = Path.Combine(
            Path.GetTempPath(),
            "TermodelRadiantExecutive",
            Guid.NewGuid().ToString("N"));

        Directory.CreateDirectory(tempRoot);
        string localeXmlPath = Path.Combine(tempRoot, "locale.xml");
        string localeSvgPath = Path.Combine(tempRoot, "locale.svg");

        try
        {
            floorInput.Save(localeXmlPath);

            lock (SpiralEngineGate)
            {
                string previousDirectory =
                    Environment.CurrentDirectory;
                try
                {
                    Directory.SetCurrentDirectory(tempRoot);

                    if (engine == RadiantSpiralEngine.Vittorio)
                        SpiralHeating.Program.AggiornaSpirali();
                    else
                        SpiralHeatingGPT.Program.AggiornaSpirali();
                }
                finally
                {
                    Directory.SetCurrentDirectory(previousDirectory);
                }
            }

            if (!File.Exists(localeSvgPath))
            {
                throw new InvalidDataException(
                    $"Piano {floorName}: {engine} non ha prodotto locale.svg.");
            }

            double step = engine == RadiantSpiralEngine.Vittorio
                ? SpiralHeating.Program.PassoTubi
                : SpiralHeatingGPT.Program.PassoTubi;

            return new SpiralEngineOutput(
                File.ReadAllText(localeSvgPath, Encoding.UTF8),
                step,
                Array.Empty<string>());
        }
        catch (InvalidDataException)
        {
            throw;
        }
        catch (Exception exception)
        {
            throw new InvalidDataException(
                $"Piano {floorName}: generazione spirali {engine} non completata: {exception.Message}",
                exception);
        }
        finally
        {
            try
            {
                if (Directory.Exists(tempRoot))
                    Directory.Delete(tempRoot, recursive: true);
            }
            catch
            {
                // La pulizia del workspace temporaneo non cambia il risultato.
            }
        }
    }

    private static void AddBuildingGeometry(
        RadiantExecutiveDrawing drawing,
        IReadOnlyList<SvgDxfFloor> sourceFloors,
        string floorName)
    {
        SvgDxfFloor? floor = sourceFloors
            .Where(candidate =>
                candidate.Name.Equals(
                    floorName,
                    StringComparison.OrdinalIgnoreCase) &&
                candidate.Role.Equals(
                    "calpestabile",
                    StringComparison.OrdinalIgnoreCase))
            .GroupBy(candidate => candidate.Id)
            .Select(group => group.First())
            .FirstOrDefault();

        if (floor is null)
            return;

        string layer = $"{floorName}_Edificio_Output";

        foreach (netDxf.Entities.Line line in floor.Document.Lines
            .Where(line =>
                line.Layer is not null &&
                line.Layer.Name.Equals(
                    floor.Layer,
                    StringComparison.OrdinalIgnoreCase)))
        {
            drawing.Primitives.Add(
                RadiantExecutivePrimitive.Line(
                    floorName,
                    layer,
                    NormalizeColor(line.Color?.Index ?? 7),
                    new ExecutivePoint(
                        line.StartPoint.X,
                        line.StartPoint.Y),
                    new ExecutivePoint(
                        line.EndPoint.X,
                        line.EndPoint.Y)));
        }
    }

    private static void AddSpiralSvgGeometry(
        RadiantExecutiveDrawing drawing,
        string svgText,
        string floorName)
    {
        XDocument svg;
        try
        {
            svg = XDocument.Parse(
                svgText,
                LoadOptions.PreserveWhitespace);
        }
        catch (Exception exception)
        {
            throw new InvalidDataException(
                $"Piano {floorName}: locale.svg non valido: {exception.Message}",
                exception);
        }

        IEnumerable<XElement> elements =
            svg.Descendants();

        foreach (XElement element in elements.Where(e =>
            e.Name.LocalName.Equals(
                "polyline",
                StringComparison.OrdinalIgnoreCase)))
        {
            List<ExecutivePoint> points = ParsePoints(
                (string?)element.Attribute("points"));
            if (points.Count < 2)
                continue;

            bool returnLine = IsBlue(element);
            drawing.Primitives.Add(
                RadiantExecutivePrimitive.Polyline(
                    floorName,
                    returnLine
                        ? $"{floorName}_PannelliRitorno_Output"
                        : $"{floorName}_PannelliMandata_Output",
                    returnLine ? 5 : 1,
                    points,
                    closed: false));
        }

        foreach (XElement element in elements.Where(e =>
            e.Name.LocalName.Equals(
                "line",
                StringComparison.OrdinalIgnoreCase)))
        {
            if (!TryNumber(element, "x1", out double x1) ||
                !TryNumber(element, "y1", out double y1) ||
                !TryNumber(element, "x2", out double x2) ||
                !TryNumber(element, "y2", out double y2))
            {
                continue;
            }

            bool returnLine = IsBlue(element);
            drawing.Primitives.Add(
                RadiantExecutivePrimitive.Line(
                    floorName,
                    returnLine
                        ? $"{floorName}_PannelliRitorno_Output"
                        : $"{floorName}_PannelliMandata_Output",
                    returnLine ? 5 : 1,
                    new ExecutivePoint(x1, y1),
                    new ExecutivePoint(x2, y2)));
        }

        foreach (XElement element in elements.Where(e =>
            e.Name.LocalName.Equals(
                "rect",
                StringComparison.OrdinalIgnoreCase) &&
            string.Equals(
                (string?)e.Attribute("data-termodel"),
                "chiusura-gpt",
                StringComparison.OrdinalIgnoreCase)))
        {
            if (!TryNumber(element, "x", out double x) ||
                !TryNumber(element, "y", out double y) ||
                !TryNumber(element, "width", out double width) ||
                !TryNumber(element, "height", out double height))
            {
                continue;
            }

            drawing.Primitives.Add(
                RadiantExecutivePrimitive.Polyline(
                    floorName,
                    $"{floorName}_NumeriCircuiti_Output",
                    3,
                    [
                        new ExecutivePoint(x, y),
                        new ExecutivePoint(x + width, y),
                        new ExecutivePoint(x + width, y + height),
                        new ExecutivePoint(x, y + height)
                    ],
                    closed: true));
        }

        foreach (XElement element in elements.Where(e =>
            e.Name.LocalName.Equals(
                "text",
                StringComparison.OrdinalIgnoreCase) &&
            string.Equals(
                (string?)e.Attribute("data-termodel"),
                "chiusura-gpt",
                StringComparison.OrdinalIgnoreCase)))
        {
            if (!TryNumber(element, "data-x", out double x) ||
                !TryNumber(element, "data-y", out double y) ||
                !TryNumber(element, "data-altezza", out double height))
            {
                continue;
            }

            string text = element.Value.Trim();
            if (text.Length == 0)
                continue;

            drawing.Primitives.Add(
                RadiantExecutivePrimitive.Text(
                    floorName,
                    $"{floorName}_NumeriCircuiti_Output",
                    3,
                    new ExecutivePoint(x, y),
                    text,
                    height));
        }
    }

    private static List<ExecutivePoint> ParsePoints(
        string? pointsText)
    {
        var points = new List<ExecutivePoint>();
        if (string.IsNullOrWhiteSpace(pointsText))
            return points;

        foreach (string token in pointsText.Split(
            [' ', '\r', '\n', '\t'],
            StringSplitOptions.RemoveEmptyEntries))
        {
            string[] pair = token.Split(',');
            if (pair.Length != 2)
                continue;

            if (double.TryParse(
                    pair[0],
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double x) &&
                double.TryParse(
                    pair[1],
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double y))
            {
                points.Add(new ExecutivePoint(x, y));
            }
        }

        return points;
    }

    private static bool TryNumber(
        XElement element,
        string attributeName,
        out double value)
    {
        value = 0;
        string? text =
            (string?)element.Attribute(attributeName);
        return !string.IsNullOrWhiteSpace(text) &&
               double.TryParse(
                   text,
                   NumberStyles.Float,
                   CultureInfo.InvariantCulture,
                   out value) &&
               double.IsFinite(value);
    }

    private static bool IsBlue(XElement element) =>
        string.Equals(
            (string?)element.Attribute("stroke"),
            "blue",
            StringComparison.OrdinalIgnoreCase) ||
        string.Equals(
            (string?)element.Attribute("stroke"),
            "#0000ff",
            StringComparison.OrdinalIgnoreCase);

    private static int NormalizeColor(int color) =>
        color is >= 1 and <= 255 ? color : 7;
}


internal enum RadiantSpiralEngine
{
    Vittorio,
    GPT,
    Diego
}

internal sealed record SpiralEngineOutput(
    string Svg,
    double StepMeters,
    IReadOnlyList<string> Diagnostics);


public sealed record RadiantExecutiveArtifacts(
    byte[] Svg,
    byte[] Dxf,
    int PrimitiveCount,
    int FloorCount,
    double DefaultStepMeters,
    IReadOnlyList<string> Diagnostics);

internal sealed class RadiantExecutiveDrawing
{
    public List<RadiantExecutivePrimitive> Primitives { get; } = [];
}

internal enum RadiantExecutivePrimitiveKind
{
    Line,
    Polyline,
    Text
}

internal readonly record struct ExecutivePoint(
    double X,
    double Y);

internal sealed record RadiantExecutivePrimitive(
    RadiantExecutivePrimitiveKind Kind,
    string FloorName,
    string Layer,
    int AciColor,
    IReadOnlyList<ExecutivePoint> Points,
    bool Closed,
    string TextValue,
    double TextHeight)
{
    public static RadiantExecutivePrimitive Line(
        string floor,
        string layer,
        int color,
        ExecutivePoint start,
        ExecutivePoint end) =>
        new(
            RadiantExecutivePrimitiveKind.Line,
            floor,
            layer,
            color,
            [start, end],
            false,
            string.Empty,
            0);

    public static RadiantExecutivePrimitive Polyline(
        string floor,
        string layer,
        int color,
        IReadOnlyList<ExecutivePoint> points,
        bool closed) =>
        new(
            RadiantExecutivePrimitiveKind.Polyline,
            floor,
            layer,
            color,
            points,
            closed,
            string.Empty,
            0);

    public static RadiantExecutivePrimitive Text(
        string floor,
        string layer,
        int color,
        ExecutivePoint position,
        string value,
        double height) =>
        new(
            RadiantExecutivePrimitiveKind.Text,
            floor,
            layer,
            color,
            [position],
            false,
            value,
            height);
}

internal static class RadiantExecutiveSvgWriter
{
    public static string Write(
        RadiantExecutiveDrawing drawing)
    {
        IReadOnlyList<RadiantExecutivePrimitive> primitives =
            drawing.Primitives;

        (double minX, double minY, double maxX, double maxY) =
            Bounds(primitives);
        double width = Math.Max(0.1, maxX - minX);
        double height = Math.Max(0.1, maxY - minY);
        double margin = Math.Max(width, height) * 0.03 + 0.05;

        double viewMinX = minX - margin;
        double viewMinY = -margin;
        double viewWidth = width + margin * 2;
        double viewHeight = height + margin * 2;

        var root = new XElement(
            XName.Get("svg", "http://www.w3.org/2000/svg"),
            new XAttribute(
                "viewBox",
                FormattableString.Invariant(
                    $"{viewMinX} {viewMinY} {viewWidth} {viewHeight}")),
            new XAttribute(
                "data-termodel-format",
                "TERMODEL-PANNELLI-ESECUTIVO-SVG-V1"),
            new XAttribute(
                "data-coordinate-unit",
                "m"),
            new XAttribute(
                "data-termodel-max-y",
                F(maxY)),
            new XAttribute(
                "data-termodel-min-y",
                F(minY)),
            new XAttribute(
                "data-primitive-count",
                primitives.Count));

        foreach (IGrouping<string, RadiantExecutivePrimitive> layerGroup in
            primitives.GroupBy(
                primitive => primitive.Layer,
                StringComparer.OrdinalIgnoreCase))
        {
            var group = new XElement(
                XName.Get("g", root.Name.NamespaceName),
                new XAttribute("data-layer", layerGroup.Key));

            foreach (RadiantExecutivePrimitive primitive in layerGroup)
            {
                string color = ColorCss(primitive.AciColor);

                if (primitive.Kind == RadiantExecutivePrimitiveKind.Line &&
                    primitive.Points.Count >= 2)
                {
                    group.Add(new XElement(
                        XName.Get("line", root.Name.NamespaceName),
                        new XAttribute("x1", F(primitive.Points[0].X)),
                        new XAttribute("y1", F(maxY - primitive.Points[0].Y)),
                        new XAttribute("x2", F(primitive.Points[1].X)),
                        new XAttribute("y2", F(maxY - primitive.Points[1].Y)),
                        new XAttribute("fill", "none"),
                        new XAttribute("stroke", color),
                        new XAttribute("stroke-width", "0.01"),
                        new XAttribute("data-aci-color", primitive.AciColor),
                        new XAttribute("data-piano", primitive.FloorName)));
                }
                else if (
                    primitive.Kind == RadiantExecutivePrimitiveKind.Polyline &&
                    primitive.Points.Count >= 2)
                {
                    string points = string.Join(
                        " ",
                        primitive.Points.Select(point =>
                            $"{F(point.X)},{F(maxY - point.Y)}"));

                    group.Add(new XElement(
                        XName.Get(
                            primitive.Closed ? "polygon" : "polyline",
                            root.Name.NamespaceName),
                        new XAttribute("points", points),
                        new XAttribute("fill", "none"),
                        new XAttribute("stroke", color),
                        new XAttribute("stroke-width", "0.01"),
                        new XAttribute("data-aci-color", primitive.AciColor),
                        new XAttribute("data-piano", primitive.FloorName)));
                }
                else if (
                    primitive.Kind == RadiantExecutivePrimitiveKind.Text &&
                    primitive.Points.Count == 1)
                {
                    group.Add(new XElement(
                        XName.Get("text", root.Name.NamespaceName),
                        new XAttribute("x", F(primitive.Points[0].X)),
                        new XAttribute("y", F(maxY - primitive.Points[0].Y)),
                        new XAttribute(
                            "font-size",
                            F(Math.Max(0.02, primitive.TextHeight))),
                        new XAttribute("text-anchor", "middle"),
                        new XAttribute("dominant-baseline", "middle"),
                        new XAttribute("fill", color),
                        new XAttribute("data-aci-color", primitive.AciColor),
                        new XAttribute("data-piano", primitive.FloorName),
                        primitive.TextValue));
                }
            }

            root.Add(group);
        }

        return new XDocument(
            new XDeclaration("1.0", "utf-8", "yes"),
            root).ToString(SaveOptions.DisableFormatting);
    }

    private static (
        double MinX,
        double MinY,
        double MaxX,
        double MaxY)
        Bounds(IReadOnlyList<RadiantExecutivePrimitive> primitives)
    {
        List<ExecutivePoint> points = primitives
            .SelectMany(primitive => primitive.Points)
            .ToList();

        if (points.Count == 0)
            return (0, 0, 1, 1);

        return (
            points.Min(point => point.X),
            points.Min(point => point.Y),
            points.Max(point => point.X),
            points.Max(point => point.Y));
    }

    private static string ColorCss(int aci) =>
        aci switch
        {
            1 => "#ff0000",
            2 => "#ffff00",
            3 => "#00aa00",
            4 => "#00ffff",
            5 => "#0000ff",
            6 => "#ff00ff",
            7 => "#000000",
            _ => "#404040"
        };

    private static string F(double value) =>
        value.ToString("0.######", CultureInfo.InvariantCulture);
}

internal static class RadiantExecutiveDxfWriter
{
    public static string Write(
        RadiantExecutiveDrawing drawing)
    {
        var builder = new StringBuilder();
        void Pair(int code, object value)
        {
            builder.Append(code.ToString(CultureInfo.InvariantCulture));
            builder.Append('\n');
            builder.Append(
                Convert.ToString(
                    value,
                    CultureInfo.InvariantCulture));
            builder.Append('\n');
        }

        Pair(0, "SECTION");
        Pair(2, "HEADER");
        Pair(9, "$ACADVER");
        Pair(1, "AC1027");
        Pair(0, "ENDSEC");

        List<(string Name, int Color)> layers = drawing.Primitives
            .GroupBy(
                primitive => primitive.Layer,
                StringComparer.OrdinalIgnoreCase)
            .Select(group => (
                Name: group.Key,
                Color: group.First().AciColor))
            .OrderBy(
                layer => layer.Name,
                StringComparer.OrdinalIgnoreCase)
            .ToList();

        Pair(0, "SECTION");
        Pair(2, "TABLES");
        Pair(0, "TABLE");
        Pair(2, "LAYER");
        Pair(70, layers.Count);

        foreach ((string name, int color) in layers)
        {
            Pair(0, "LAYER");
            Pair(2, name);
            Pair(70, 0);
            Pair(62, color);
            Pair(6, "CONTINUOUS");
        }

        Pair(0, "ENDTAB");
        Pair(0, "ENDSEC");
        Pair(0, "SECTION");
        Pair(2, "ENTITIES");

        foreach (RadiantExecutivePrimitive primitive in drawing.Primitives)
        {
            if (primitive.Kind == RadiantExecutivePrimitiveKind.Line &&
                primitive.Points.Count >= 2)
            {
                Pair(0, "LINE");
                Common(primitive);
                Pair(10, F(primitive.Points[0].X));
                Pair(20, F(primitive.Points[0].Y));
                Pair(30, "0");
                Pair(11, F(primitive.Points[1].X));
                Pair(21, F(primitive.Points[1].Y));
                Pair(31, "0");
            }
            else if (
                primitive.Kind == RadiantExecutivePrimitiveKind.Polyline &&
                primitive.Points.Count >= 2)
            {
                Pair(0, "LWPOLYLINE");
                Common(primitive);
                Pair(90, primitive.Points.Count);
                Pair(70, primitive.Closed ? 1 : 0);
                foreach (ExecutivePoint point in primitive.Points)
                {
                    Pair(10, F(point.X));
                    Pair(20, F(point.Y));
                }
            }
            else if (
                primitive.Kind == RadiantExecutivePrimitiveKind.Text &&
                primitive.Points.Count == 1)
            {
                ExecutivePoint point = primitive.Points[0];
                Pair(0, "TEXT");
                Common(primitive);
                Pair(10, F(point.X));
                Pair(20, F(point.Y));
                Pair(30, "0");
                Pair(40, F(Math.Max(0.02, primitive.TextHeight)));
                Pair(1, DxfText(primitive.TextValue));
                Pair(72, 1);
                Pair(73, 2);
                Pair(11, F(point.X));
                Pair(21, F(point.Y));
                Pair(31, "0");
            }
        }

        Pair(0, "ENDSEC");
        Pair(0, "EOF");
        return builder.ToString();

        void Common(RadiantExecutivePrimitive primitive)
        {
            Pair(8, primitive.Layer);
            Pair(62, primitive.AciColor);
            Pair(6, "CONTINUOUS");
        }
    }

    private static string DxfText(string value) =>
        value
            .Replace("\r", " ", StringComparison.Ordinal)
            .Replace("\n", " ", StringComparison.Ordinal);

    private static string F(double value) =>
        value.ToString("0.######", CultureInfo.InvariantCulture);
}
