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
            // Implementazione geometrica v3 inserita nel passo successivo.
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
