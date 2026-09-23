using System.Globalization;
using System.Xml.Linq;
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

        public static string FileLocaleSvgPath =>
            string.IsNullOrWhiteSpace(PathProg) ? string.Empty : Path.Combine(PathProg, "locale.svg");

        public static string FileLocaleXmlPath =>
            string.IsNullOrWhiteSpace(PathProg) ? string.Empty : Path.Combine(PathProg, "locale.xml");

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

        public void RenderFiltrato(object? viewport, object? filters, bool visualizzaTutto = false)
        {
            // Diagnostica grafica Desktop non materializzata nel Service.
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

    // Modificato da Codex per realizzare: conserva il confine semantico dei locali
    // e accetta dal Virtual CAD le linee Tubo secondo la convenzione Desktop.
    // Il solver pannelli Web non viene eseguito qui: questo adattatore consente
    // al normale GeneraModello di acquisire l'input senza rifiutare il progetto.
    internal static class IoPannelli
    {
        private const string Versione = "1.0";
        private static readonly AsyncLocal<XDocument?> CurrentDocument = new();

        public static void InitClass()
        {
            CurrentDocument.Value = new XDocument(
                new XDeclaration("1.0", "utf-8", "yes"),
                new XElement(
                    "Locali",
                    new XAttribute("Versione", Versione)));
        }

        public static XDocument? GetDocumentSnapshot()
        {
            XDocument? document = CurrentDocument.Value;
            return document is null ? null : new XDocument(document);
        }

        public static void AddParalleloLocale(
            Geometry polygon,
            string localeId,
            string floorName,
            bool versoEsterno = true)
        {
            XDocument? document = CurrentDocument.Value;
            if (document is null)
                throw new InvalidOperationException("IoPannelli.InitClass() non è stato chiamato.");

            if (string.IsNullOrWhiteSpace(localeId) ||
                polygon is null ||
                polygon.IsEmpty)
            {
                return;
            }

            Polygon? parallelo = CalcolaParalleloSafe(
                polygon as Polygon,
                versoEsterno);
            if (parallelo is null || parallelo.IsEmpty)
                return;

            XElement? root = document.Root;
            if (root is null)
                return;

            var xLocale = new XElement(
                "Locale",
                new XAttribute("Id", localeId));

            if (!string.IsNullOrWhiteSpace(floorName))
                xLocale.SetAttributeValue("Piano", floorName);

            var xPerimetro = new XElement("PerimetroInterno");
            Coordinate[] coordinates = parallelo.ExteriorRing.Coordinates;
            int count = coordinates.Length;
            int last =
                count > 1 && coordinates[0].Equals2D(coordinates[count - 1])
                    ? count - 1
                    : count;

            for (int index = 0; index < last; index++)
            {
                xPerimetro.Add(new XElement(
                    "Punto",
                    new XAttribute(
                        "X",
                        coordinates[index].X.ToString(CultureInfo.InvariantCulture)),
                    new XAttribute(
                        "Y",
                        coordinates[index].Y.ToString(CultureInfo.InvariantCulture))));
            }

            if (last > 0)
            {
                xPerimetro.Add(new XElement(
                    "Punto",
                    new XAttribute(
                        "X",
                        coordinates[0].X.ToString(CultureInfo.InvariantCulture)),
                    new XAttribute(
                        "Y",
                        coordinates[0].Y.ToString(CultureInfo.InvariantCulture))));
            }

            xLocale.Add(xPerimetro);
            root.Add(xLocale);
        }

        private static Polygon? CalcolaParalleloSafe(
            Polygon? polygon,
            bool versoEsterno)
        {
            if (polygon is null)
                return null;

            Geometry geometry;
            try
            {
                geometry = GeometriaHelper.ParalleloPoligono(
                    polygon,
                    versoEsterno);
            }
            catch
            {
                return null;
            }

            if (geometry is null || geometry.IsEmpty)
                return null;

            if (geometry is Polygon direct)
                return new Polygon((LinearRing)direct.ExteriorRing);

            Polygon? best = null;
            for (int index = 0; index < geometry.NumGeometries; index++)
            {
                if (geometry.GetGeometryN(index) is Polygon candidate &&
                    (best is null || candidate.Area > best.Area))
                {
                    best = candidate;
                }
            }

            return best is null
                ? null
                : new Polygon((LinearRing)best.ExteriorRing);
        }

        private static void EsportaTubiPannelli(
            string floorName,
            double elevation,
            IList<LineString> lines)
        {
            XDocument? document = CurrentDocument.Value;
            if (document is null)
                throw new InvalidOperationException("IoPannelli.InitClass() non è stato chiamato.");

            if (string.IsNullOrWhiteSpace(floorName) ||
                lines is null ||
                lines.Count == 0)
            {
                return;
            }

            XElement? root = document.Root;
            if (root is null)
                return;

            XElement? xFloor = root
                .Elements("Piano")
                .FirstOrDefault(element => string.Equals(
                    (string?)element.Attribute("Nome"),
                    floorName,
                    StringComparison.OrdinalIgnoreCase));

            if (xFloor is null)
            {
                xFloor = new XElement(
                    "Piano",
                    new XAttribute("Nome", floorName),
                    new XAttribute(
                        "Quota",
                        elevation.ToString(CultureInfo.InvariantCulture)));
                root.Add(xFloor);
            }
            else
            {
                xFloor.SetAttributeValue(
                    "Quota",
                    elevation.ToString(CultureInfo.InvariantCulture));
            }

            xFloor.Element("Tubi")?.Remove();
            var xTubes = new XElement("Tubi");
            xFloor.Add(xTubes);

            int id = 1;
            foreach (LineString line in lines)
            {
                if (line is null ||
                    line.IsEmpty ||
                    line.NumPoints < 2)
                {
                    continue;
                }

                Coordinate p0 = line.GetCoordinateN(0);
                Coordinate p1 = line.GetCoordinateN(line.NumPoints - 1);

                xTubes.Add(new XElement(
                    "Linea",
                    new XAttribute("Id", $"T{id}"),
                    new XElement(
                        "P0",
                        new XAttribute("X", p0.X.ToString(CultureInfo.InvariantCulture)),
                        new XAttribute("Y", p0.Y.ToString(CultureInfo.InvariantCulture)),
                        new XAttribute("Z", elevation.ToString(CultureInfo.InvariantCulture))),
                    new XElement(
                        "P1",
                        new XAttribute("X", p1.X.ToString(CultureInfo.InvariantCulture)),
                        new XAttribute("Y", p1.Y.ToString(CultureInfo.InvariantCulture)),
                        new XAttribute("Z", elevation.ToString(CultureInfo.InvariantCulture)))));
                id++;
            }
        }

        public static void LeggiTubiDXF(
            DxfDocument document,
            string floorName,
            double elevation,
            double originX,
            double originY)
        {
            ArgumentNullException.ThrowIfNull(document);
            if (string.IsNullOrWhiteSpace(floorName))
                return;

            string layerTubi = $"{floorName}_tubipannelli";
            List<LineString> lines = document.Lines
                .Where(line =>
                    line.Layer is not null &&
                    line.Layer.Name.Equals(
                        layerTubi,
                        StringComparison.OrdinalIgnoreCase))
                .Select(line =>
                    new LineString(
                    [
                        new Coordinate(
                            line.StartPoint.X - originX,
                            line.StartPoint.Y - originY),
                        new Coordinate(
                            line.EndPoint.X - originX,
                            line.EndPoint.Y - originY)
                    ]))
                .ToList();

            if (lines.Count == 0)
            {
                TermodelLog.WriteLog(
                    $"Nessuna linea trovata su layer {layerTubi}.");
                return;
            }

            EsportaTubiPannelli(
                floorName,
                elevation,
                lines);

            TermodelLog.WriteLog(
                $"Letti {lines.Count} tubi dal layer {layerTubi}. " +
                "Input CAD acquisito per calcolo ed esecutivo pannelli.");
        }

        public static void DisegnaSvgSpirali(
            object? viewport,
            string svgPath,
            double quotaPiano = 0)
        {
            // Nel Service l'esecutivo SVG è un artifact headless separato.
        }
    }
}
