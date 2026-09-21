using Xbim.Ifc4.GeometryResource;
using Termodel.Core.Model3D;
using Termodel.Leggidxf;

namespace System.Windows
{
    public enum Visibility { Visible, Hidden, Collapsed }

    public sealed class Application
    {
        private static readonly Application Instance = new();
        private Application() { MainWindow = global::Termodel.MainWindow.Instance; }
        public static Application Current => Instance;
        public object? MainWindow { get; set; }
    }
}

namespace System.Windows.Media
{
    internal static class HeadlessMediaNamespace { }
}

namespace System.Windows.Media.Media3D
{
    public readonly struct Point3D(double x, double y, double z)
    {
        public double X { get; } = x;
        public double Y { get; } = y;
        public double Z { get; } = z;
    }
}

namespace Termodel
{
    public sealed class MainWindow
    {
        internal static MainWindow Instance { get; } = new();
        public static HeadlessGraphicFilters FiltriGraficiControlStatic { get; } = new();

        public HeadlessContentControl LabPrimoErrore { get; } = new();
        public HeadlessVisibilityControl PrimoErrore { get; } = new();

        public utilities.DrawBim GetDrawBimControl() => utilities.DrawBim.Instance;
    }

    public sealed class HeadlessContentControl
    {
        public object? Content { get; set; }
    }

    public sealed class HeadlessVisibilityControl
    {
        public System.Windows.Visibility Visibility { get; set; }
    }

    public sealed class HeadlessGraphicFilters
    {
        private readonly HashSet<string> _floors = new(StringComparer.OrdinalIgnoreCase);

        public void CancellaPiani() => _floors.Clear();
        public void AddPiano(string? floor)
        {
            if (!string.IsNullOrWhiteSpace(floor)) _floors.Add(floor);
        }

        public bool PianoFiltrato(string? floor) => true;

        // "Pannelli" nel Desktop è una modalità speciale di visualizzazione.
        // Il server produce invece sempre il modello completo; le view filtrano dopo.
        public bool ComponenteFiltrato(string? component) =>
            !string.Equals(component, "Pannelli", StringComparison.OrdinalIgnoreCase);

        public bool ConfineFiltrato(string? boundary) => true;
        public bool SeparatoreFiltrato(string? separator) => true;
        public bool Lineeiltrate(string? line) => true;
    }
}

namespace Termodel.utilities
{
    public sealed class LineManager
    {
        public void SvuotaListaLinee() { }
        public void VisualizzaLinee3D() { }
        public void VisualizzaLineeBIM() { }
    }

    /// <summary>
    /// Superficie headless compatibile con il DrawBim usato da Polig3D.
    /// La geometria Web verrà raccolta qui senza dipendere da WPF/Helix.
    /// </summary>
    public sealed class DrawBim
    {
        internal static DrawBim Instance { get; } = new();

        private TermodelWebModel? _model;

        public object viewport { get; } = new();
        public LineManager lineManager { get; } = new();
        public bool enabled { get; set; } = true;

        public void Bind(TermodelWebModel model) => _model = model;

        public void SvuotaBuffer()
        {
            _model?.Primitives.Clear();
            lineManager.SvuotaListaLinee();
        }

        public void CalcolaLimitiInputDXF() { }
        public void Redraw(bool recalcView) { }

        public void DrawPolyEstruso(
            int NumeroElemento,
            IfcPolyline polyifc,
            double baseHeight,
            double extrusionHeight,
            bool verticale,
            IfcCartesianPoint IFCinsertionPoint,
            System.Windows.Media.Media3D.Point3D insertionPoint,
            global::Polig3D.TipoElemento Tipo,
            string ID,
            string Descrizione,
            Coordinate3D Start,
            Coordinate3D end,
            double rotationAngle = 0)
        {
            if (_model is null || polyifc is null || polyifc.Points.Count < 3)
                return;

            List<Vec3> baseRing = BuildBaseRing(
                polyifc,
                insertionPoint,
                Tipo,
                verticale,
                rotationAngle);

            RemoveClosingDuplicate(baseRing);
            if (baseRing.Count < 3) return;

            Vec3 extrusion = BuildExtrusion(baseRing, Tipo, verticale, extrusionHeight, rotationAngle);
            List<Vec3> topRing = baseRing.Select(p => p + extrusion).ToList();

            PrimitiveMetadata metadata = ReadMetadata(NumeroElemento, Tipo);
            string color = ColorFor(Tipo);

            var sidesVertices = new List<double[]>();
            var sidesIndices = new List<int>();
            for (int i = 0; i < baseRing.Count; i++)
            {
                int next = (i + 1) % baseRing.Count;
                int k = sidesVertices.Count;
                AddPoint(sidesVertices, baseRing[i]);
                AddPoint(sidesVertices, baseRing[next]);
                AddPoint(sidesVertices, topRing[next]);
                AddPoint(sidesVertices, topRing[i]);
                sidesIndices.AddRange([k, k + 1, k + 2, k, k + 2, k + 3]);
            }

            _model.Primitives.Add(CreatePrimitive(
                NumeroElemento, Tipo, ID, Descrizione, color,
                "ExtrudedVisual3D", "lati", metadata, sidesVertices, sidesIndices));

            List<int[]> triangles = Triangulate(baseRing, Tipo, verticale);
            var capVertices = new List<double[]>();
            var capIndices = new List<int>();
            foreach (int[] triangle in triangles)
            {
                int k = capVertices.Count;
                AddPoint(capVertices, baseRing[triangle[0]]);
                AddPoint(capVertices, baseRing[triangle[1]]);
                AddPoint(capVertices, baseRing[triangle[2]]);
                capIndices.AddRange([k, k + 1, k + 2]);

                k = capVertices.Count;
                AddPoint(capVertices, topRing[triangle[2]]);
                AddPoint(capVertices, topRing[triangle[1]]);
                AddPoint(capVertices, topRing[triangle[0]]);
                capIndices.AddRange([k, k + 1, k + 2]);
            }

            _model.Primitives.Add(CreatePrimitive(
                NumeroElemento, Tipo, ID, Descrizione, color,
                "MeshGeometry3D", "tappi", metadata, capVertices, capIndices));
        }

        private static TermodelWebPrimitive CreatePrimitive(
            int numero,
            global::Polig3D.TipoElemento tipo,
            string id,
            string descrizione,
            string color,
            string source,
            string parte,
            PrimitiveMetadata metadata,
            List<double[]> vertices,
            List<int> indices) =>
            new()
            {
                Kind = "mesh",
                Source = source,
                Parte = parte,
                Numero = numero,
                Id = id ?? string.Empty,
                Tipo = tipo.ToString(),
                Descrizione = descrizione ?? string.Empty,
                FilterMetadata = metadata.Available,
                Piano = metadata.Piano,
                Confine = metadata.Confine,
                Separatore = metadata.Separatore,
                StessaZona = metadata.StessaZona,
                Fittizia = metadata.Fittizia,
                Falda = metadata.Falda,
                Color = color,
                Opacity = 1,
                LineWidth = 1,
                Text = string.Empty,
                Vertices = vertices,
                Indices = indices,
                Metadata = new Dictionary<string, object?>(StringComparer.Ordinal)
                {
                    ["zona"] = metadata.Zona
                }
            };

        private static PrimitiveMetadata ReadMetadata(int numero, global::Polig3D.TipoElemento tipo)
        {
            if (numero <= 0 || numero > global::Polig3D.ElementiAssociati.Count)
                return PrimitiveMetadata.Empty;

            try
            {
                global::Polig3D.ElementoAssociato elemento =
                    global::Polig3D.ElementiAssociati[numero - 1];

                bool falda = elemento.Poligono?.Falda == true;
                string confine = string.Empty;
                if (tipo == global::Polig3D.TipoElemento.Mansardato)
                    confine = "Esterno";
                else if (!falda)
                    confine = global::GestXml.DeterminaTipoConfine(elemento).ToString();

                bool fittizia = elemento.Separatore && global::Polig3D.IsFittizia(elemento);
                string zona = global::Polig3D.DatiLocaleACuiAssociato(elemento)?.Zona ?? string.Empty;

                return new PrimitiveMetadata(
                    true,
                    elemento.NomePiano ?? string.Empty,
                    confine,
                    elemento.Separatore,
                    elemento.StessaZona,
                    fittizia,
                    falda,
                    zona);
            }
            catch
            {
                return PrimitiveMetadata.Empty;
            }
        }

        private static List<Vec3> BuildBaseRing(
            IfcPolyline polyifc,
            System.Windows.Media.Media3D.Point3D insertionPoint,
            global::Polig3D.TipoElemento tipo,
            bool verticale,
            double rotationAngle)
        {
            var result = new List<Vec3>();
            double angle = rotationAngle * Math.PI / 180.0;
            double cos = Math.Cos(angle);
            double sin = Math.Sin(angle);

            foreach (var raw in polyifc.Points)
            {
                double x = raw.Coordinates.Count > 0 ? raw.Coordinates[0] : 0;
                double y = raw.Coordinates.Count > 1 ? raw.Coordinates[1] : 0;
                double z = raw.Coordinates.Count > 2 ? raw.Coordinates[2] : 0;

                if (tipo is global::Polig3D.TipoElemento.Falda or global::Polig3D.TipoElemento.Mansardato)
                {
                    result.Add(new Vec3(
                        x + insertionPoint.X,
                        y + insertionPoint.Y,
                        z + insertionPoint.Z));
                }
                else if (verticale)
                {
                    // Nel Desktop il profilo verticale è memorizzato come X/Z
                    // e orientato in pianta dalla direzione della parete.
                    result.Add(new Vec3(
                        insertionPoint.X + x * cos,
                        insertionPoint.Y + x * sin,
                        insertionPoint.Z + z));
                }
                else
                {
                    result.Add(new Vec3(
                        insertionPoint.X + x,
                        insertionPoint.Y + y,
                        insertionPoint.Z + z));
                }
            }

            return result;
        }

        private static Vec3 BuildExtrusion(
            IReadOnlyList<Vec3> ring,
            global::Polig3D.TipoElemento tipo,
            bool verticale,
            double depth,
            double rotationAngle)
        {
            depth = Math.Abs(depth);
            if (depth <= 1e-12) depth = 0.001;

            if (tipo is global::Polig3D.TipoElemento.Falda or global::Polig3D.TipoElemento.Mansardato)
            {
                for (int i = 1; i + 1 < ring.Count; i++)
                {
                    Vec3 a = ring[i] - ring[0];
                    Vec3 b = ring[i + 1] - ring[0];
                    Vec3 normal = Cross(a, b);
                    double length = normal.Length;
                    if (length <= 1e-12) continue;
                    normal /= length;
                    if (normal.Z < 0) normal = -normal;
                    return normal * depth;
                }
                return new Vec3(0, 0, depth);
            }

            if (verticale)
            {
                double angle = rotationAngle * Math.PI / 180.0;
                return new Vec3(-Math.Sin(angle) * depth, Math.Cos(angle) * depth, 0);
            }

            return new Vec3(0, 0, depth);
        }

        private static List<int[]> Triangulate(
            IReadOnlyList<Vec3> ring,
            global::Polig3D.TipoElemento tipo,
            bool verticale)
        {
            int count = ring.Count;
            var triangles = new List<int[]>();
            if (count == 3)
            {
                triangles.Add([0, 1, 2]);
                return triangles;
            }

            // Ear clipping 2D sul piano naturale del profilo.
            var points = ring.Select(p =>
                verticale
                    ? new Vec2(p.X, p.Z)
                    : new Vec2(p.X, p.Y)).ToList();

            double area = SignedArea(points);
            var remaining = Enumerable.Range(0, count).ToList();
            bool ccw = area >= 0;
            int guard = 0;

            while (remaining.Count > 3 && guard++ < count * count)
            {
                bool clipped = false;
                for (int r = 0; r < remaining.Count; r++)
                {
                    int ia = remaining[(r - 1 + remaining.Count) % remaining.Count];
                    int ib = remaining[r];
                    int ic = remaining[(r + 1) % remaining.Count];

                    if (!IsConvex(points[ia], points[ib], points[ic], ccw))
                        continue;

                    bool contains = false;
                    foreach (int candidate in remaining)
                    {
                        if (candidate == ia || candidate == ib || candidate == ic) continue;
                        if (PointInTriangle(points[candidate], points[ia], points[ib], points[ic]))
                        {
                            contains = true;
                            break;
                        }
                    }
                    if (contains) continue;

                    triangles.Add([ia, ib, ic]);
                    remaining.RemoveAt(r);
                    clipped = true;
                    break;
                }

                if (!clipped) break;
            }

            if (remaining.Count == 3)
                triangles.Add([remaining[0], remaining[1], remaining[2]]);

            // Fallback sicuro per profili degeneri: fan come MeshBuilder storico
            // piuttosto che perdere completamente i tappi.
            if (triangles.Count == 0)
                for (int i = 1; i < count - 1; i++)
                    triangles.Add([0, i, i + 1]);

            return triangles;
        }

        private static double SignedArea(IReadOnlyList<Vec2> p)
        {
            double area = 0;
            for (int i = 0; i < p.Count; i++)
            {
                Vec2 a = p[i], b = p[(i + 1) % p.Count];
                area += a.X * b.Y - b.X * a.Y;
            }
            return area * 0.5;
        }

        private static bool IsConvex(Vec2 a, Vec2 b, Vec2 c, bool ccw)
        {
            double cross = (b.X - a.X) * (c.Y - b.Y) - (b.Y - a.Y) * (c.X - b.X);
            return ccw ? cross > 1e-12 : cross < -1e-12;
        }

        private static bool PointInTriangle(Vec2 p, Vec2 a, Vec2 b, Vec2 c)
        {
            double d1 = Sign(p, a, b);
            double d2 = Sign(p, b, c);
            double d3 = Sign(p, c, a);
            bool hasNeg = d1 < -1e-12 || d2 < -1e-12 || d3 < -1e-12;
            bool hasPos = d1 > 1e-12 || d2 > 1e-12 || d3 > 1e-12;
            return !(hasNeg && hasPos);
        }

        private static double Sign(Vec2 p1, Vec2 p2, Vec2 p3) =>
            (p1.X - p3.X) * (p2.Y - p3.Y) - (p2.X - p3.X) * (p1.Y - p3.Y);

        private static void RemoveClosingDuplicate(List<Vec3> ring)
        {
            if (ring.Count > 1 && DistanceSquared(ring[0], ring[^1]) < 1e-18)
                ring.RemoveAt(ring.Count - 1);
        }

        private static double DistanceSquared(Vec3 a, Vec3 b)
        {
            Vec3 d = a - b;
            return d.X * d.X + d.Y * d.Y + d.Z * d.Z;
        }

        private static Vec3 Cross(Vec3 a, Vec3 b) =>
            new(a.Y * b.Z - a.Z * b.Y,
                a.Z * b.X - a.X * b.Z,
                a.X * b.Y - a.Y * b.X);

        private static void AddPoint(List<double[]> destination, Vec3 p) =>
            destination.Add([Safe(p.X), Safe(p.Y), Safe(p.Z)]);

        private static double Safe(double value) =>
            double.IsFinite(value) ? value : 0;

        private static string ColorFor(global::Polig3D.TipoElemento tipo) => tipo switch
        {
            global::Polig3D.TipoElemento.Parete => "#A0522D",
            global::Polig3D.TipoElemento.Finestra => "#556B2F",
            global::Polig3D.TipoElemento.Ponte => "#00FF7F",
            global::Polig3D.TipoElemento.Falda => "#A52A2A",
            _ => "#BDB76B"
        };

        private readonly record struct PrimitiveMetadata(
            bool Available,
            string Piano,
            string Confine,
            bool Separatore,
            bool StessaZona,
            bool Fittizia,
            bool Falda,
            string Zona)
        {
            public static PrimitiveMetadata Empty { get; } =
                new(false, string.Empty, string.Empty, false, false, false, false, string.Empty);
        }

        private readonly record struct Vec2(double X, double Y);

        private readonly record struct Vec3(double X, double Y, double Z)
        {
            public double Length => Math.Sqrt(X * X + Y * Y + Z * Z);
            public static Vec3 operator +(Vec3 a, Vec3 b) => new(a.X + b.X, a.Y + b.Y, a.Z + b.Z);
            public static Vec3 operator -(Vec3 a, Vec3 b) => new(a.X - b.X, a.Y - b.Y, a.Z - b.Z);
            public static Vec3 operator -(Vec3 a) => new(-a.X, -a.Y, -a.Z);
            public static Vec3 operator *(Vec3 a, double scale) => new(a.X * scale, a.Y * scale, a.Z * scale);
            public static Vec3 operator /(Vec3 a, double scale) => new(a.X / scale, a.Y / scale, a.Z / scale);
        }
    }
}

/// <summary>
/// Parte headless della semantica GestXml richiesta da Polig3D.
/// La generazione XML completa verrà collegata separatamente.
/// </summary>
public static class GestXml
{
    public enum TipoConfine
    {
        Esterno,
        Interno,
        AmbienteNonClimatizzato,
        AmbienteClimatizzato,
        Terreno,
        Fittizia,
        Dividi,
        Sconosciuto
    }

    public static TipoConfine StrTipoConfineToEnum(string? tipoConfine)
    {
        if (tipoConfine is null) return TipoConfine.Sconosciuto;
        if (tipoConfine.Equals("Fittizia", StringComparison.OrdinalIgnoreCase)) return TipoConfine.Fittizia;
        if (tipoConfine.Equals("DIVIDI", StringComparison.OrdinalIgnoreCase)) return TipoConfine.Dividi;

        string? typed = tipoConfine.Equals("Esterno", StringComparison.Ordinal)
            ? "Esterno"
            : Database.DB.GetDataDB(
                "Codice",
                tipoConfine,
                "Tipo",
                Database.DB.GetCollection("Confini"));

        if (typed is null) return TipoConfine.Sconosciuto;

        return typed.ToLowerInvariant() switch
        {
            "automatico" => TipoConfine.Esterno,
            "esterno" => TipoConfine.Esterno,
            "interno" => TipoConfine.Interno,
            "ambientenonclimatizzato" => TipoConfine.AmbienteNonClimatizzato,
            "ambienteclimatizzato" => TipoConfine.AmbienteClimatizzato,
            "terreno" => TipoConfine.Terreno,
            _ => TipoConfine.Sconosciuto
        };
    }

    public static TipoConfine DeterminaTipoConfine(global::Polig3D.ElementoAssociato componente)
    {
        if (componente.Locale is null)
        {
            if (componente.PareteACuiAssociata?.datiopaca is not null)
                return StrTipoConfineToEnum(componente.PareteACuiAssociata.datiopaca.Confine);
        }
        else if (componente.datiopaca?.Confine is not null)
        {
            return StrTipoConfineToEnum(componente.datiopaca.Confine);
        }

        Termodel.utilities.TermodelLog.LogError(
            $"{Termodel.utilities.TermodelLog.LogContesto}, confine sconosciuto");
        return TipoConfine.Sconosciuto;
    }
}
