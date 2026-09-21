// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/Tetti.cs
// Temporary copy. Align/move to shared source when possible.
// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/Tetti.cs
// Temporary copy. Align/move to shared source when possible.
using NetTopologySuite.Geometries;
using Termodel.Core.Model3D;

namespace Termodel.Leggidxf;

// Modificato da Codex per realizzare: mantenere reale la matematica delle
// coperture eliminando transazioni e contenitori IFC.
public sealed class Tetti
{
    private readonly Modello _model;
    public Tetti(Modello model) => _model = model;
    public DXFLineCheck? Linee2D { get; set; }
    public List<Sced> scedList { get; } = [];
    public DXFLineCheck? Lines2DCor() => Linee2D ?? _model.Lines2DCor;

    // Funzione realizzata da Codex in autonomia
    public double CalcZ(double x, double y, List<Modello.FaldaTetto>? falde)
    {
        if (falde is null) return double.NaN;
        foreach (Modello.FaldaTetto falda in falde.Where(item => item.Colore == _model.ColoreTettoCor))
        {
            IReadOnlyList<ModelPoint3D> points = falda.Falda.Points.ToArray();
            if (points.Count < 3 || !PointInTriangle(x, y, points[0], points[1], points[2])) continue;
            return InterpolateZ(x, y, points[0], points[1], points[2]);
        }
        return double.NaN;
    }

    // Funzione realizzata da Codex in autonomia
    public ModelPolyline3D TrasformaPoligono2DInPolyline3D(Geometry polygon, bool falda)
    {
        ArgumentNullException.ThrowIfNull(polygon);
        var result = new ModelPolyline3D();
        foreach (Coordinate coordinate in polygon.Coordinates)
        {
            double z = falda ? ResolveDxfZ(coordinate) : CalcZ(coordinate.X, coordinate.Y, _model.Tetti3dCor);
            if (!double.IsFinite(z)) z = _model.QuotaGrondaCor;
            result.Points.Add(new ModelPoint3D(coordinate.X, coordinate.Y, z));
        }
        return result;
    }

    // Modificato da Codex per realizzare: conserva il nome usato da LeggiDxf
    // ma genera elementi headless invece di relazioni IFC.
    public void DisegnaSceds()
    {
        int index = 0;
        foreach (Sced sced in scedList)
        {
            if (sced.StartCoordinate.Equals2D(sced.EndCoordinate)) continue;
            _model.AggiungiPareteSced(sced, $"SCED_{++index}");
        }
    }

    private double ResolveDxfZ(Coordinate coordinate)
    {
        DXFLineCheck? lines = Lines2DCor();
        if (lines is null) return coordinate.Z;
        double z = lines.RecuperaZSingolaCoordinata(coordinate);
        return double.IsFinite(z) ? z : coordinate.Z;
    }

    private static bool PointInTriangle(double x, double y, ModelPoint3D a, ModelPoint3D b, ModelPoint3D c)
    {
        double denominator = (b.Y - c.Y) * (a.X - c.X) + (c.X - b.X) * (a.Y - c.Y);
        if (Math.Abs(denominator) < 1e-12) return false;
        double u = ((b.Y - c.Y) * (x - c.X) + (c.X - b.X) * (y - c.Y)) / denominator;
        double v = ((c.Y - a.Y) * (x - c.X) + (a.X - c.X) * (y - c.Y)) / denominator;
        double w = 1 - u - v;
        const double tolerance = -0.001;
        return u >= tolerance && v >= tolerance && w >= tolerance;
    }

    private static double InterpolateZ(double x, double y, ModelPoint3D a, ModelPoint3D b, ModelPoint3D c)
    {
        double ux = b.X - a.X, uy = b.Y - a.Y, uz = b.Z - a.Z;
        double vx = c.X - a.X, vy = c.Y - a.Y, vz = c.Z - a.Z;
        double nx = uy * vz - uz * vy;
        double ny = uz * vx - ux * vz;
        double nz = ux * vy - uy * vx;
        return Math.Abs(nz) < 1e-12 ? double.NaN : a.Z - (nx * (x - a.X) + ny * (y - a.Y)) / nz;
    }
}

// Modificato da Codex per realizzare: mantenere il modello mutabile usato dalla copia di LeggiDxf.
public sealed class Sced
{
    public Coordinate StartCoordinate { get; set; } = new();
    public Coordinate EndCoordinate { get; set; } = new();
    public double BaseSced { get; set; }
    public double AltezzaSced { get; set; }
    public string Triangolo { get; set; } = string.Empty;
}
