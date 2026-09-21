using NetTopologySuite.Geometries;
using netDxf;
using Termodel.Core.Model3D;
using Termodel.Core.Compatibility;

// Modificato da Codex per realizzare: sola porzione geometrica realmente usata
// da DXFLineCheck; non viene copiata l'intera utility desktop.
public static class GeometriaHelper
{
    public static Termodel.Leggidxf.DXFLineCheck? Lines2DCor { get; set; }

    public sealed class OffsetLine(Coordinate start, Coordinate end)
    {
        public Coordinate Start { get; set; } = start;
        public Coordinate End { get; set; } = end;
    }

    // Funzione realizzata da Codex in autonomia
    public static bool Intersects(LineString first, LineString second, double tolerance) =>
        TryIntersection(first, second, tolerance, out _);

    // Funzione realizzata da Codex in autonomia
    public static Geometry? Intersection(LineString first, LineString second, double tolerance) =>
        TryIntersection(first, second, tolerance, out Coordinate? point) ? new Point(point) : null;

    private static bool TryIntersection(LineString first, LineString second, double tolerance, out Coordinate? result)
    {
        result = null;
        Coordinate a1 = first.GetCoordinateN(0), a2 = first.GetCoordinateN(1);
        Coordinate b1 = second.GetCoordinateN(0), b2 = second.GetCoordinateN(1);
        double adx = a2.X - a1.X, ady = a2.Y - a1.Y;
        double bdx = b2.X - b1.X, bdy = b2.Y - b1.Y;
        double denominator = adx * bdy - ady * bdx;
        if (Math.Abs(denominator) < tolerance) return false;
        double dx = b1.X - a1.X, dy = b1.Y - a1.Y;
        double s = (dx * bdy - dy * bdx) / denominator;
        double t = (dx * ady - dy * adx) / denominator;
        if (s < -tolerance || s > 1 + tolerance || t < -tolerance || t > 1 + tolerance) return false;
        result = new Coordinate(a1.X + s * adx, a1.Y + s * ady);
        return true;
    }

    // Modificato da Codex per realizzare: copia selettiva della geometria usata
    // da GeneraPianta per ricostruire il profilo architettonico pulito.
    public static Polygon ParalleloPoligono(Polygon polygon, bool external)
    {
        ArgumentNullException.ThrowIfNull(polygon);
        if (Lines2DCor is null)
            throw new InvalidOperationException("DXFLineCheck non inizializzato per GeneraPianta.");

        Coordinate[] coordinates = polygon.ExteriorRing.Coordinates;
        var shifted = new List<OffsetLine>();
        for (int index = 0; index + 1 < coordinates.Length; index++)
        {
            Coordinate start = coordinates[index], end = coordinates[index + 1];
            double thickness = Lines2DCor.SpessoreParete([start, end]);
            if (!double.IsFinite(thickness)) thickness = 0.5;
            double distance = external ? thickness : -thickness;
            double dx = end.Y - start.Y, dy = start.X - end.X;
            double length = Math.Sqrt(dx * dx + dy * dy);
            if (length <= 1e-12) continue;
            double offsetX = dx / length * distance, offsetY = dy / length * distance;
            shifted.Add(new OffsetLine(
                new Coordinate(start.X + offsetX, start.Y + offsetY),
                new Coordinate(end.X + offsetX, end.Y + offsetY)));
        }

        if (shifted.Count < 3)
            throw new InvalidDataException("Il poligono non contiene lati sufficienti per il parallelo.");
        var joined = new List<Coordinate>();
        for (int index = 0; index < shifted.Count; index++)
        {
            (OffsetLine current, _) = JoinLines(shifted[index], shifted[(index + 1) % shifted.Count]);
            joined.Add(current.End);
        }
        joined.Add(joined[0]);
        return new Polygon(new LinearRing(joined.ToArray()));
    }

    private static (OffsetLine Current, OffsetLine Next) JoinLines(OffsetLine first, OffsetLine second)
    {
        Coordinate? intersection = ProjectedIntersection(first, second);
        return intersection is null
            ? (first, second)
            : (new OffsetLine(first.Start, intersection), new OffsetLine(intersection, second.End));
    }

    private static Coordinate? ProjectedIntersection(OffsetLine first, OffsetLine second)
    {
        double x1 = first.Start.X, y1 = first.Start.Y, x2 = first.End.X, y2 = first.End.Y;
        double x3 = second.Start.X, y3 = second.Start.Y, x4 = second.End.X, y4 = second.End.Y;
        double denominator = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);
        if (Math.Abs(denominator) < 0.001) return null;
        double factor = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / denominator;
        return new Coordinate(x1 + factor * (x2 - x1), y1 + factor * (y2 - y1));
    }
}

namespace Termodel.utilities
{
    // Facciata del progetto Desktop sul workspace temporaneo della richiesta.
    public static class GestProg
    {
        private static readonly AsyncLocal<ProjectWorkspace?> CurrentWorkspace = new();
        private static readonly AsyncLocal<string?> LegacyPath = new();

        public static string PathProg
        {
            get => CurrentWorkspace.Value?.RootPath ?? LegacyPath.Value ?? string.Empty;
            set => LegacyPath.Value = value;
        }

        public static string PathProgDB =>
            CurrentWorkspace.Value?.DatabasePath ??
            (string.IsNullOrWhiteSpace(PathProg) ? string.Empty : Path.Combine(PathProg, "dbtempfiles"));

        public static string FileXMLPath =>
            CurrentWorkspace.Value?.XmlInputPath ??
            (string.IsNullOrWhiteSpace(PathProg) ? string.Empty : Path.Combine(PathProg, "xml", "input.xml"));

        public static string FileXMLOutPath =>
            CurrentWorkspace.Value?.XmlOutputPath ??
            (string.IsNullOrWhiteSpace(PathProg) ? string.Empty : Path.Combine(PathProg, "xml", "output.xml"));

        public static bool Rivestimenti { get; set; }

        public static void UseWorkspace(ProjectWorkspace workspace)
        {
            ArgumentNullException.ThrowIfNull(workspace);
            CurrentWorkspace.Value = workspace;
            LegacyPath.Value = workspace.RootPath;
        }

        public static void ClearWorkspace()
        {
            CurrentWorkspace.Value = null;
            LegacyPath.Value = null;
        }

        public static string FileDXFPath(string logicalName) =>
            CurrentWorkspace.Value?.GetCadFilePath(logicalName) ??
            throw new InvalidOperationException("Workspace progetto non inizializzato.");
    }

    // Modificato da Codex per realizzare: diagnostica grafica sostituita da
    // diagnostica strutturata; l'importazione Helix è intenzionalmente assente.
    public static class HelixDXF
    {
        public static HelixDXF_class I { get; } = new();
    }

    public sealed class HelixDXF_class
    {
        public void ErroreConGrafica(string message, object? geometry, double elevation, object? source = null) =>
            TermodelLog.LogError(message);

        public void ErroriNelDxf(object? geometry, ModelVector3D translation) =>
            TermodelLog.LogError("Il disegno contiene entità non connesse.");

        public void ImportaDaDxf(DxfDocument document, string layer, ModelVector3D translation)
        {
            // UI/Helix esclusa dal percorso Web: il documento è già consumato dal Core.
        }

        // Funzione realizzata da Codex in autonomia
        public static List<LineString> EstraiLinee2DdaPoligono(Geometry polygon)
        {
            var result = new List<LineString>();
            Coordinate[] coordinates = polygon.Coordinates;
            for (int index = 0; index + 1 < coordinates.Length; index++)
                result.Add(new LineString([coordinates[index], coordinates[index + 1]]));
            return result;
        }
    }
}

namespace Termodel.Impianti.Pannelli
{
    using Termodel.utilities;

    // Modificato da Codex per realizzare: conserva il confine semantico dei locali;
    // i circuiti radianti restano esclusi e vengono rifiutati se presenti nel CAD.
    internal static class IoPannelli
    {
        public static void AddParalleloLocale(Geometry polygon, string localeId, string floorName)
        {
            // Il modello 3D usa direttamente il poligono del locale; nessun duplicato globale.
        }

        public static void LeggiTubiDXF(DxfDocument document, string floorName, double elevation, double originX, double originY)
        {
            if (document.Layers.Any(layer => layer.Name.Contains("TUB", StringComparison.OrdinalIgnoreCase)))
                throw new NotSupportedException("Il file unico contiene circuiti radianti CAD non ancora supportati dal Core 3D Web.");
        }
    }
}
