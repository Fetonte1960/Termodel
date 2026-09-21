using NetTopologySuite.Geometries;
using Termodel.utilities;

namespace Termodel.Leggidxf
{
    // Modificato da Codex per realizzare: sostituire il vettore WPF con il solo
    // comportamento matematico richiesto dal lettore geometrico headless.
    public struct Vector(double x, double y)
    {
        public double X { get; private set; } = x;
        public double Y { get; private set; } = y;

        public void Normalize()
        {
            double length = Math.Sqrt(X * X + Y * Y);
            if (length <= 1e-12) return;
            X /= length;
            Y /= length;
        }

        public static double Multiply(Vector first, Vector second) =>
            first.X * second.X + first.Y * second.Y;
    }

    // Modificato da Codex per realizzare: conservare la tolleranza geometrica
    // originale senza importare altre utility desktop.
    public static class Geometria
    {
        public static double Appros { get; } = 0.05;
    }

    // Modificato da Codex per realizzare: le esportazioni SVG diagnostiche non
    // fanno parte del motore Web; i dati geometrici restano invariati.
    public static class SVGHelper
    {
        public static void GeneraSVG(string name, object? geometry, object? errors) { }
        public static List<LineString> SVGPolygons(IEnumerable<Geometry> polygons) =>
            polygons.OfType<Polygon>().SelectMany(polygon => polygon.ExteriorRing.Coordinates
                .Zip(polygon.ExteriorRing.Coordinates.Skip(1),
                    (start, end) => new LineString([start, end])))
                .ToList();
    }

    public partial class LeggiDxf
    {
        // Modificato da Codex per realizzare: sostituire l'inizializzazione XAML,
        // assente e non necessaria nel Core headless.
        private void InitializeComponent() { }
    }
}

namespace Termodel.utilities
{
    // Modificato da Codex per realizzare: convertire gli errori UI in diagnostica
    // strutturata consumabile dal WebService.
    public static class ErrorManager
    {
        private static readonly AsyncLocal<string?> CurrentError = new();

        public static string ErrorMessage
        {
            get => CurrentError.Value ?? string.Empty;
            set => CurrentError.Value = value;
        }

        public static bool EsisteErrore()
        {
            if (string.IsNullOrWhiteSpace(ErrorMessage)) return false;
            TermodelLog.LogError(ErrorMessage);
            ErrorMessage = string.Empty;
            return true;
        }

        public static void VisualizzaErrori()
        {
            if (!string.IsNullOrWhiteSpace(ErrorMessage))
                TermodelLog.LogError(ErrorMessage);
        }
    }
}
