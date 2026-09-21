using NetTopologySuite.Geometries;
using Termodel.Core.Model3D;
using Termodel.Leggidxf;
using static Polig3D;

namespace Termodel;

// Modificato da Codex per realizzare: facciata Modello headless compatibile con
// LeggiDxf. È dummy soltanto per IFC; costruzione semantica e mesh sono reali.
public sealed class Modello
{
    public Modello(object? renderer = null)
    {
        Tettocor = new Tetti(this);
    }

    public sealed class Line(Coordinate start, Coordinate end)
    {
        public Coordinate Start { get; set; } = start;
        public Coordinate End { get; set; } = end;
    }

    public sealed class FaldaTetto(ModelPolyline3D falda, int colore)
    {
        public int Colore { get; } = colore;
        public ModelPolyline3D Falda { get; } = falda;
    }

    public sealed class Piano(Modello model, string nome, string tipo)
    {
        public string Nomepiano { get; } = nome;
        public string Tipo { get; } = tipo;
        public DXFLineCheck? LineCheck { get; set; }
        public List<FaldaTetto> Tetti3d { get; } = [];
        public Modello Model { get; } = model;
    }

    public static bool netto = true;
    public static int numeropiani;
    public static double SpesPonte = 0.1;

    public TermodelWebModel WebModel { get; } = new();
    public Tetti Tettocor { get; }
    public List<Piano> Piani { get; } = [];
    public List<FaldaTetto>? Tetti3dCor { get; set; }
    public DXFLineCheck? Lines2DCor { get; private set; }
    public List<(double X, double Y, double Z, double? Z2)> ListaVerticiTetti { get; set; } = [];
    public List<Sced> scedList => Tettocor.scedList;

    public int CountFalde;
    public int countpareti;
    public int countpavimenti;
    public int countsoffitti;
    public int countPonti;
    public int localeCounter;
    public int ColoreTettoCor;
    public int ModoCor = 3;
    public double QuotaCorrente;
    public double QuotaGrondaCor;
    public double direzNord = double.NaN;
    public string FaldaCor = string.Empty;
    public string NomePianoCor = string.Empty;
    public TDatilocale? DatiLocaleCorrente { get; private set; }

    private DXFLineCheck? _temporaryLines;

    // Funzione realizzata da Codex in autonomia
    public void Init_modello()
    {
        WebModel.Primitives.Clear();
        Piani.Clear();
        Tettocor.scedList.Clear();
        ListaVerticiTetti.Clear();
        CountFalde = countpareti = countpavimenti = countsoffitti = countPonti = localeCounter = 0;
        direzNord = double.NaN;
        Polig3D.ClearAll();
    }

    // Funzione realizzata da Codex in autonomia
    public void Modello_piano(string pianoNome, double elevazione, TipoPiano tipo)
    {
        QuotaCorrente = elevazione;
        NomePianoCor = pianoNome;
        if (Piani.All(item => !item.Nomepiano.Equals(pianoNome, StringComparison.OrdinalIgnoreCase)))
            Piani.Add(new Piano(this, pianoNome, tipo.ToString()));
        Polig3D.AggiungiPiano(pianoNome, elevazione, tipo);
    }

    // Funzione realizzata da Codex in autonomia
    public void ModelloLocale(string nomeLocale, TDatilocale dati)
    {
        DatiLocaleCorrente = dati;
        Polig3D.AggiungiLocale(nomeLocale, NomePianoCor, dati);
    }

    public void SetLines2DCor(DXFLineCheck lines)
    {
        Lines2DCor = lines;
        Tettocor.Linee2D = lines;
    }

    public void SetLines2DCor_provvisorioo(DXFLineCheck lines)
    {
        _temporaryLines = Lines2DCor;
        Lines2DCor = lines;
    }

    public void RestoreLines2DCor()
    {
        Lines2DCor = _temporaryLines;
        _temporaryLines = null;
    }

    public void CreaRecordLineePiano(Modello model, string nomePiano, string tipo)
    {
        if (Piani.All(item => !item.Nomepiano.Equals(nomePiano, StringComparison.OrdinalIgnoreCase)))
            Piani.Add(new Piano(model, nomePiano, tipo));
    }

    public void AggiungiLineePiano(Modello model, string nomePiano, string tipo, List<LineString> lines)
    {
        Piano? piano = Piani.FirstOrDefault(item => item.Nomepiano.Equals(nomePiano, StringComparison.OrdinalIgnoreCase));
        if (piano is null)
        {
            piano = new Piano(model, nomePiano, tipo);
            Piani.Add(piano);
        }
        piano.LineCheck = new DXFLineCheck(lines);
    }

    public void SettaLines2DCor(string nomePiano) =>
        Lines2DCor = Piani.First(item => item.Nomepiano.Equals(nomePiano, StringComparison.OrdinalIgnoreCase)).LineCheck;

    public Piano? CercaTetto()
    {
        Piano? roof = Piani.FirstOrDefault(item => item.Tipo.Equals("Copertura", StringComparison.OrdinalIgnoreCase));
        Tetti3dCor = roof?.Tetti3d;
        return roof;
    }

    // Funzione realizzata da Codex in autonomia
    public void AggiungiParete(Line line, double quota, double altezza1, double altezza2, double spessore,
        string id, string descrizione, TDatiSuperficieOpaca? dati)
    {
        countpareti++;
        AddLinePrism(line.Start, line.End, quota, altezza1, altezza2, spessore, id, "Parete", descrizione, "#A0522D", dati);
    }

    // Funzione realizzata da Codex in autonomia
    public void AggiungiFinestra(TDatiFinestra finestra, Coordinate start, Coordinate end,
        Coordinate puntoInserimento, double spessoreParete)
    {
        var baseLine = new Line(start, end);
        Line opening = CreateCenteredSegment(baseLine, puntoInserimento, finestra.Larghezza);
        AddLinePrism(opening.Start, opening.End, finestra.Sottofinestra, finestra.Altezza,
            finestra.Altezza, Math.Max(spessoreParete, 0.02), finestra.Id ?? $"Finestra {WebModel.PrimitiveCount + 1}",
            "Finestra", finestra.Tipo ?? finestra.Descrizione ?? string.Empty, "#87CEEB", null);
    }

    // Funzione realizzata da Codex in autonomia
    public void AggiungiSolaio(Geometry polygon, double spessore, double quota, string id,
        string descrizione, bool Solaio3D, bool falde, TipoElemento tipoElemento, TDatiSuperficieOpaca? dati)
    {
        if (tipoElemento == TipoElemento.Falda) CountFalde++;
        else if (tipoElemento == TipoElemento.Pavimento) countpavimenti++;
        else countsoffitti++;

        ModelPolyline3D profile = Tettocor.TrasformaPoligono2DInPolyline3D(polygon, falde);
        if (!Solaio3D && !falde)
        {
            profile = new ModelPolyline3D();
            foreach (Coordinate coordinate in polygon.Coordinates)
                profile.Points.Add(new ModelPoint3D(coordinate.X, coordinate.Y, quota));
        }

        if (falde)
        {
            Piano? current = Piani.LastOrDefault();
            current?.Tetti3d.Add(new FaldaTetto(profile, ColoreTettoCor));
            Tetti3dCor = current?.Tetti3d;
        }

        AddExtrudedPolygon(profile.Points, Math.Max(spessore, 0.001), id, tipoElemento.ToString(), descrizione,
            tipoElemento == TipoElemento.Falda ? "#A52A2A" : "#BDB76B", dati);
    }

    public void AggiungiPonteOriz(Line line, double quota, double quota2, double spessore,
        string id, string descrizione, double Altezza = 0, EnumOriginePonte OriginePonte = EnumOriginePonte.Parete)
    {
        countPonti++;
        double height = Altezza > 0 ? Altezza : Math.Max(Math.Abs(quota - quota2), 0.1);
        AddLinePrism(line.Start, line.End, Math.Min(quota, quota2), height, height, Math.Max(spessore, 0.02),
            $"{id} {countPonti}", "Ponte", descrizione, "#00FF7F", null);
    }

    public void AggiungiPonteVert(double quota, Coordinate puntoInserimento, Coordinate start, Coordinate end,
        double spessore, double altezza, string id, string descrizione,
        EnumOriginePonte OriginePonte = EnumOriginePonte.Parete)
    {
        countPonti++;
        var point2 = new Coordinate(puntoInserimento.X + Math.Max(spessore, 0.02), puntoInserimento.Y);
        AddLinePrism(puntoInserimento, point2, quota, altezza, altezza, Math.Max(spessore, 0.02),
            $"{id} {countPonti}", "Ponte", descrizione, "#00FF7F", null);
    }

    internal void AggiungiPareteSced(Sced sced, string id) =>
        AddLinePrism(sced.StartCoordinate, sced.EndCoordinate, sced.BaseSced, sced.AltezzaSced,
            sced.AltezzaSced, 0.3, id, "Sced", sced.Triangolo, "#A0522D", null);

    public void Close_modello(string outputPath, string xmlBase, string xmlOut)
    {
        // Modificato da Codex per realizzare: nessun file IFC viene prodotto.
        // Il risultato autorevole della versione Web è la proprietà WebModel.
    }

    private void AddLinePrism(Coordinate start, Coordinate end, double baseZ, double height1, double height2,
        double thickness, string id, string type, string description, string color, TDatiSuperficieOpaca? data)
    {
        double dx = end.X - start.X, dy = end.Y - start.Y;
        double length = Math.Sqrt(dx * dx + dy * dy);
        if (length <= 1e-9) return;
        double ox = -dy / length * thickness / 2;
        double oy = dx / length * thickness / 2;
        var bottom = new[]
        {
            new ModelPoint3D(start.X + ox, start.Y + oy, baseZ),
            new ModelPoint3D(end.X + ox, end.Y + oy, baseZ),
            new ModelPoint3D(end.X - ox, end.Y - oy, baseZ),
            new ModelPoint3D(start.X - ox, start.Y - oy, baseZ)
        };
        var top = new[]
        {
            bottom[0] with { Z = baseZ + height1 }, bottom[1] with { Z = baseZ + height2 },
            bottom[2] with { Z = baseZ + height2 }, bottom[3] with { Z = baseZ + height1 }
        };
        AddBoxPrimitive(bottom.Concat(top).ToArray(), id, type, description, color, data);
    }

    private void AddBoxPrimitive(ModelPoint3D[] vertices, string id, string type, string description,
        string color, TDatiSuperficieOpaca? data)
    {
        int[] indices =
        [
            0,1,2, 0,2,3, 4,6,5, 4,7,6,
            0,4,5, 0,5,1, 1,5,6, 1,6,2,
            2,6,7, 2,7,3, 3,7,4, 3,4,0
        ];
        AddPrimitive(vertices, indices, id, type, description, color, data);
    }

    private void AddExtrudedPolygon(IList<ModelPoint3D> source, double thickness, string id, string type,
        string description, string color, TDatiSuperficieOpaca? data)
    {
        List<ModelPoint3D> ring = source.ToList();
        if (ring.Count > 1 && ring[0] == ring[^1]) ring.RemoveAt(ring.Count - 1);
        if (ring.Count < 3) return;
        var vertices = ring.Concat(ring.Select(point => point with { Z = point.Z + thickness })).ToArray();
        var indices = new List<int>();
        for (int i = 1; i < ring.Count - 1; i++)
        {
            indices.AddRange([0, i + 1, i]);
            indices.AddRange([ring.Count, ring.Count + i, ring.Count + i + 1]);
        }
        for (int i = 0; i < ring.Count; i++)
        {
            int next = (i + 1) % ring.Count;
            indices.AddRange([i, next, ring.Count + next, i, ring.Count + next, ring.Count + i]);
        }
        AddPrimitive(vertices, indices, id, type, description, color, data);
    }

    private void AddPrimitive(IEnumerable<ModelPoint3D> vertices, IEnumerable<int> indices, string id,
        string type, string description, string color, TDatiSuperficieOpaca? data)
    {
        var metadata = new Dictionary<string, object?>(StringComparer.Ordinal)
        {
            ["piano"] = NomePianoCor,
            ["zona"] = DatiLocaleCorrente?.Zona ?? string.Empty,
            ["confine"] = data?.Confine ?? string.Empty
        };
        WebModel.Primitives.Add(new TermodelWebPrimitive
        {
            Numero = WebModel.Primitives.Count + 1,
            Id = id,
            Tipo = type,
            Descrizione = description,
            Color = color,
            Vertices = vertices.Select(point => new[] { point.X, point.Y, point.Z }).ToList(),
            Indices = indices.ToList(),
            Metadata = metadata
        });
    }

    private static Line CreateCenteredSegment(Line baseLine, Coordinate center, double length)
    {
        double dx = baseLine.End.X - baseLine.Start.X, dy = baseLine.End.Y - baseLine.Start.Y;
        double magnitude = Math.Sqrt(dx * dx + dy * dy);
        if (magnitude <= 1e-9) return new Line(center, center);
        double hx = dx / magnitude * length / 2, hy = dy / magnitude * length / 2;
        return new Line(new Coordinate(center.X - hx, center.Y - hy), new Coordinate(center.X + hx, center.Y + hy));
    }
}

public static class Modellostatic
{
    public static Modello? mod;
    public static void Initclass(Modello model) => mod = model;
}
