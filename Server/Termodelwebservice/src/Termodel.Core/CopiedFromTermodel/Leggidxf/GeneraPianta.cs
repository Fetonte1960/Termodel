// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/GeneraPianta.cs
// Temporary copy. Align/move to shared source when possible.
// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/GeneraPianta.cs
// Temporary copy. Align/move to shared source when possible.
using System.Collections.Concurrent;
using System.Globalization;
using System.Xml.Linq;
using NetTopologySuite.Geometries;
using NetTopologySuite.Operation.Union;

namespace Termodel.Leggidxf;

// Modificato da Codex per realizzare: copia con modifiche minime di
// Leggidxf/GeneraPianta.cs. La geometria resta NetTopologySuite; l'output DXF
// viene sostituito da SVG in memoria richiamabile per nome piano.
public static class GeneraPianta
{
    private const double MetersToCentimeters = 100;
    private static readonly AsyncLocal<GenerationState?> Current = new();
    private static readonly ConcurrentDictionary<string, string> LatestPlans =
        new(StringComparer.OrdinalIgnoreCase);

    public static string nomepianta = string.Empty;
    public static List<LineString> ListaLinee => State.Lines;
    public static List<Geometry> ListaPolilinee => State.Polylines;
    public static bool PercorsoEsterno { get; private set; }

    private static GenerationState State => Current.Value ??=
        new GenerationState([], []);

    // Funzione realizzata da Codex in autonomia
    public static void IniziaGenerazione()
    {
        Current.Value = new GenerationState([], []);
        LatestPlans.Clear();
    }

    // Modificato da Codex per realizzare: mantiene la firma desktop; il percorso
    // di output non viene usato perché il risultato Web resta in memoria.
    public static void InitClass(string outputPath, bool percorsoEsterno)
    {
        PercorsoEsterno = percorsoEsterno;
        State.Lines.Clear();
        State.Polylines.Clear();
    }

    // Modificato da Codex per realizzare: nome storico conservato per ridurre il
    // delta con il desktop; nel Web pubblica SVG e non produce alcun DXF.
    public static void SalvaDXF()
    {
        if (string.IsNullOrWhiteSpace(nomepianta))
            throw new InvalidOperationException("Nome del piano non inizializzato in GeneraPianta.");
        LatestPlans[nomepianta] = CreateSvg(nomepianta, ListaPolilinee, ListaLinee);
    }

    // Funzione realizzata da Codex in autonomia
    public static string PiantaArchitettonicaPulita(string nomePiano) =>
        LatestPlans.TryGetValue(nomePiano, out string? svg)
            ? svg
            : throw new KeyNotFoundException(
                $"La pianta architettonica pulita '{nomePiano}' non è disponibile nell'ultima generazione.");

    // Funzione realizzata da Codex in autonomia
    public static IReadOnlyDictionary<string, string> PianteDisponibili() =>
        new Dictionary<string, string>(LatestPlans, StringComparer.OrdinalIgnoreCase);

    public static double SpessoreParete(string userData) => 0.4;

    public static Polygon? PerimetroEsterno(List<Geometry> polygons)
    {
        if (polygons is null || polygons.Count == 0) return null;
        var flattened = new List<Geometry>();
        foreach (Geometry geometry in polygons)
        {
            if (geometry is null || geometry.IsEmpty) continue;
            if (geometry is Polygon polygon) flattened.Add(polygon);
            else
                for (int index = 0; index < geometry.NumGeometries; index++)
                    if (geometry.GetGeometryN(index) is Polygon item) flattened.Add(item);
        }

        if (flattened.Count == 0) return null;
        Geometry union = UnaryUnionOp.Union(flattened);
        if (union is null || union.IsEmpty) return null;
        Polygon? best = union as Polygon;
        if (best is null)
            for (int index = 0; index < union.NumGeometries; index++)
                if (union.GetGeometryN(index) is Polygon candidate &&
                    (best is null || candidate.Area > best.Area))
                    best = candidate;
        return best is null ? null : new Polygon((LinearRing)best.ExteriorRing);
    }

    private static Polygon? SafeParalleloLocale(Polygon polygon, bool versoEsterno)
    {
        if (polygon is null || polygon.IsEmpty) return null;
        try
        {
            Polygon parallel = GeometriaHelper.ParalleloPoligono(polygon, versoEsterno);
            return new Polygon((LinearRing)parallel.ExteriorRing);
        }
        catch (Exception exception) when (exception is InvalidDataException or InvalidOperationException)
        {
            return null;
        }
    }

    public static void GeneraLocali(List<Geometry> polygons)
    {
        Polygon outer = PerimetroEsterno(polygons) ??
            throw new InvalidDataException("Impossibile determinare il perimetro esterno della pianta.");
        ListaPolilinee.Add(outer);
        _ = GeometriaHelper.ParalleloPoligono(outer, PercorsoEsterno);

        foreach (Geometry geometry in polygons)
            if (geometry is Polygon room)
            {
                Polygon? parallel = SafeParalleloLocale(room, versoEsterno: true);
                if (parallel is not null) ListaPolilinee.Add(parallel);
            }
    }

    public static void GeneraPiantaPiano(
        DXFLineCheck lines2DCor,
        string outputPath,
        string nomePiano,
        List<Geometry> polygons,
        bool percorsoEsterno)
    {
        GeometriaHelper.Lines2DCor = lines2DCor;
        InitClass(outputPath, percorsoEsterno);
        GeneraLocali(polygons);
        nomepianta = nomePiano;
    }

    public static void InsertSymb(
        List<LineString> lines,
        Coordinate insertionPoint,
        double rotation)
    {
        foreach (LineString line in lines)
            ListaLinee.Add(TrasformaLinea(line, insertionPoint, rotation));
    }

    private static LineString TrasformaLinea(
        LineString line,
        Coordinate insertionPoint,
        double rotation)
    {
        double cosine = Math.Cos(rotation), sine = Math.Sin(rotation);
        Coordinate[] transformed = line.Coordinates.Select(coordinate =>
            new Coordinate(
                coordinate.X * cosine - coordinate.Y * sine + insertionPoint.X,
                coordinate.X * sine + coordinate.Y * cosine + insertionPoint.Y)).ToArray();
        return new LineString(transformed);
    }

    public static List<LineString> DisegnaFinestra(
        double width,
        double thickness,
        bool wallSide)
    {
        double halfWidth = width / 2;
        double frameY = wallSide ? thickness / 2 : -thickness / 2;
        const double frameThickness = 0.03;
        return
        [
            new LineString([new Coordinate(-halfWidth, frameY - thickness / 2), new Coordinate(-halfWidth, frameY + thickness / 2)]),
            new LineString([new Coordinate(halfWidth, frameY - thickness / 2), new Coordinate(halfWidth, frameY + thickness / 2)]),
            new LineString([new Coordinate(-halfWidth, frameY + frameThickness), new Coordinate(halfWidth, frameY + frameThickness)]),
            new LineString([new Coordinate(-halfWidth, frameY - frameThickness), new Coordinate(halfWidth, frameY - frameThickness)])
        ];
    }

    public static void AggiungiFinestra2D(
        double width,
        Coordinate start,
        Coordinate end,
        Coordinate insertionPoint,
        double wallThickness)
    {
        double rotation = Math.Atan2(end.Y - start.Y, end.X - start.X);
        // Modificato da Codex per realizzare: il simbolo finestra viene conservato
        // nell'SVG; nel desktop l'inserimento era temporaneamente disattivato.
        InsertSymb(DisegnaFinestra(width, wallThickness, wallSide: false), insertionPoint, rotation);
    }

    private static string CreateSvg(
        string floorName,
        IEnumerable<Geometry> polylines,
        IEnumerable<LineString> lines)
    {
        List<Coordinate> allCoordinates = polylines.SelectMany(item => item.Coordinates)
            .Concat(lines.SelectMany(item => item.Coordinates)).ToList();
        if (allCoordinates.Count == 0)
            throw new InvalidDataException($"La pianta '{floorName}' non contiene geometria SVG.");

        double minX = allCoordinates.Min(item => item.X) * MetersToCentimeters;
        double minY = allCoordinates.Min(item => item.Y) * MetersToCentimeters;
        double maxX = allCoordinates.Max(item => item.X) * MetersToCentimeters;
        double maxY = allCoordinates.Max(item => item.Y) * MetersToCentimeters;
        const double margin = 20;
        XNamespace svg = "http://www.w3.org/2000/svg";
        var root = new XElement(svg + "svg",
            new XAttribute("viewBox", FormattableString.Invariant(
                $"{minX - margin} {minY - margin} {maxX - minX + margin * 2} {maxY - minY + margin * 2}")),
            new XAttribute("data-termodel-format", "TERMODEL-CLEAN-FLOOR-SVG-V1"),
            new XAttribute("data-termodel-units", "cm"),
            new XAttribute("data-termodel-floor-name", floorName));
        var group = new XElement(svg + "g", new XAttribute("id", "pianta-architettonica-pulita"));
        root.Add(group);

        foreach (Geometry geometry in polylines)
            group.Add(new XElement(svg + "polyline",
                new XAttribute("class", "clean-boundary"),
                new XAttribute("fill", "none"),
                new XAttribute("stroke", "#111111"),
                new XAttribute("points", Points(geometry.Coordinates))));
        foreach (LineString line in lines)
            group.Add(new XElement(svg + "line",
                new XAttribute("class", "window-symbol"),
                new XAttribute("x1", Number(line.StartPoint.X)),
                new XAttribute("y1", Number(line.StartPoint.Y)),
                new XAttribute("x2", Number(line.EndPoint.X)),
                new XAttribute("y2", Number(line.EndPoint.Y)),
                new XAttribute("stroke", "#2563eb")));

        return new XDocument(new XDeclaration("1.0", "utf-8", null), root).ToString(SaveOptions.DisableFormatting);
    }

    private static string Points(IEnumerable<Coordinate> coordinates) =>
        string.Join(' ', coordinates.Select(item => $"{Number(item.X)},{Number(item.Y)}"));
    private static string Number(double meters) =>
        (meters * MetersToCentimeters).ToString("0.########", CultureInfo.InvariantCulture);

    private sealed record GenerationState(
        List<LineString> Lines,
        List<Geometry> Polylines);
}
