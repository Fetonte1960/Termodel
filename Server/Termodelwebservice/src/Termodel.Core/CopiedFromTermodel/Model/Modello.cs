using NetTopologySuite.Geometries;
using Termodel.Core.Model3D;
using Termodel.Leggidxf;
using Termodel.utilities;
using Xbim.Common.Step21;
using Xbim.Ifc;
using Xbim.Ifc4.GeometryResource;
using Xbim.Ifc4.GeometricConstraintResource;
using Xbim.Ifc4.Kernel;
using Xbim.Ifc4.Interfaces;
using Xbim.Ifc4.MeasureResource;
using Xbim.Ifc4.ProductExtension;
using Xbim.Ifc4.RepresentationResource;
using Xbim.Ifc4.SharedBldgElements;
using Xbim.IO;
using static Polig3D;

namespace Termodel;

// Modello headless: conserva la superficie storica usata da LeggiDxf e
// materializza in xBIM in-memory le strutture semantiche richieste dal Polig3D
// Desktop. Il JSON viene ricostruito a fine elaborazione da Polig3D.GrafRedraw
// tramite il DrawBim headless, non durante la lettura del DXF.
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

    public IfcStore model { get; private set; } = null!;
    public IfcGeometricRepresentationContext GeometricRepresentationContext { get; private set; } = null!;
    public IfcBuildingStorey? ModelloPianoCorrente { get; private set; }
    public IfcSpace? LocaleCorrente { get; private set; }
    public IfcBuildingElementProxy? PareteCorrente { get; set; }

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

    public void Init_modello()
    {
        WebModel.Primitives.Clear();
        Piani.Clear();
        Tettocor.scedList.Clear();
        ListaVerticiTetti.Clear();
        CountFalde = countpareti = countpavimenti = countsoffitti = countPonti = localeCounter = 0;
        direzNord = double.NaN;

        Polig3D.ClearAll();
        Polig3D.LineeCostruzione = new LineManager();
        DrawBim.Instance.Bind(WebModel);

        model?.Dispose();
        model = IfcStore.Create(null, XbimSchemaVersion.Ifc4, XbimStoreType.InMemoryModel);

        using var txn = model.BeginTransaction("Creazione Modello headless");

        var project = model.Instances.New<IfcProject>(p =>
        {
            p.Name = "Progetto Termodel";
            p.UnitsInContext = model.Instances.New<IfcUnitAssignment>(ua =>
            {
                ua.Units.Add(model.Instances.New<IfcSIUnit>(u =>
                {
                    u.UnitType = IfcUnitEnum.LENGTHUNIT;
                    u.Name = IfcSIUnitName.METRE;
                }));
            });
        });

        var site = model.Instances.New<IfcSite>(s => s.Name = "Sito");
        model.Instances.New<IfcRelAggregates>(a =>
        {
            a.RelatingObject = project;
            a.RelatedObjects.Add(site);
        });

        var building = model.Instances.New<IfcBuilding>(b => b.Name = "Edificio");
        model.Instances.New<IfcRelAggregates>(a =>
        {
            a.RelatingObject = site;
            a.RelatedObjects.Add(building);
        });

        GeometricRepresentationContext = model.Instances.New<IfcGeometricRepresentationContext>(c =>
        {
            c.ContextType = "Model";
            c.ContextIdentifier = "Body";
            c.CoordinateSpaceDimension = 3;
            c.Precision = 1.0e-5;
            c.WorldCoordinateSystem = model.Instances.New<IfcAxis2Placement3D>(wcs =>
            {
                wcs.Location = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(0, 0, 0));
            });
        });

        txn.Commit();
    }

    public void Modello_piano(string pianoNome, double elevazione, TipoPiano tipo)
    {
        QuotaCorrente = elevazione;
        NomePianoCor = pianoNome;

        if (Piani.All(item => !item.Nomepiano.Equals(pianoNome, StringComparison.OrdinalIgnoreCase)))
            Piani.Add(new Piano(this, pianoNome, tipo.ToString()));

        using var txn = model.BeginTransaction("Aggiungi Piano");
        IfcBuilding building = model.Instances.OfType<IfcBuilding>().First();

        ModelloPianoCorrente = model.Instances.New<IfcBuildingStorey>(storey =>
        {
            storey.Name = pianoNome;
            storey.Elevation = elevazione;
        });

        model.Instances.New<IfcRelAggregates>(relation =>
        {
            relation.RelatingObject = building;
            relation.RelatedObjects.Add(ModelloPianoCorrente);
        });

        txn.Commit();
        Polig3D.AggiungiPiano(pianoNome, elevazione, tipo);
    }

    public void ModelloLocale(string nomeLocale, TDatilocale dati)
    {
        if (ModelloPianoCorrente is null)
            throw new InvalidOperationException("ModelloPianoCorrente non inizializzato.");

        DatiLocaleCorrente = dati;

        using var txn = model.BeginTransaction("Crea Locale");
        LocaleCorrente = model.Instances.New<IfcSpace>(space =>
        {
            space.Name = nomeLocale;
            space.ObjectPlacement = model.Instances.New<IfcLocalPlacement>(placement =>
            {
                placement.RelativePlacement = model.Instances.New<IfcAxis2Placement3D>(axis =>
                {
                    axis.Location = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(0, 0, 0));
                });
            });
        });

        model.Instances.New<IfcRelContainedInSpatialStructure>(relation =>
        {
            relation.RelatingStructure = ModelloPianoCorrente;
            relation.RelatedElements.Add(LocaleCorrente);
        });

        txn.Commit();
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

    public void CreaRecordLineePiano(Modello modelInstance, string nomePiano, string tipo)
    {
        if (Piani.All(item => !item.Nomepiano.Equals(nomePiano, StringComparison.OrdinalIgnoreCase)))
            Piani.Add(new Piano(modelInstance, nomePiano, tipo));
    }

    public void AggiungiLineePiano(Modello modelInstance, string nomePiano, string tipo, List<LineString> lines)
    {
        Piano? piano = Piani.FirstOrDefault(item =>
            item.Nomepiano.Equals(nomePiano, StringComparison.OrdinalIgnoreCase));
        if (piano is null)
        {
            piano = new Piano(modelInstance, nomePiano, tipo);
            Piani.Add(piano);
        }

        piano.LineCheck = new DXFLineCheck(lines);
    }

    public void SettaLines2DCor(string nomePiano) =>
        Lines2DCor = Piani.First(item =>
            item.Nomepiano.Equals(nomePiano, StringComparison.OrdinalIgnoreCase)).LineCheck;

    public Piano? CercaTetto()
    {
        Piano? roof = Piani.FirstOrDefault(item =>
            item.Tipo.Equals("Copertura", StringComparison.OrdinalIgnoreCase));
        Tetti3dCor = roof?.Tetti3d;
        return roof;
    }

    public void AggiungiParete(
        Line line,
        double quota,
        double altezza1,
        double altezza2,
        double spessore,
        string id,
        string descrizione,
        TDatiSuperficieOpaca? dati)
    {
        countpareti++;

        double dx = line.End.X - line.Start.X;
        double dy = line.End.Y - line.Start.Y;
        double length = Math.Sqrt(dx * dx + dy * dy);
        if (length <= 1e-12) return;

        (IfcCartesianPoint insertion, IfcDirection direction) =
            CreatePlacement(
                (line.Start.X + line.End.X) * 0.5,
                (line.Start.Y + line.End.Y) * 0.5,
                quota,
                dx / length,
                dy / length,
                0);

        Geometry rectangle = CreateVerticalTrapezoid(length, altezza1, altezza2, false, spessore);
        IfcPolyline polyline = CreateIfcPolyline(rectangle.Coordinates, vertical: true);

        RegisterElement(
            polyline, spessore, id, insertion, direction, descrizione, "Parete",
            QuotaCorrente, tetto3D: false, falda: false, verticale: true,
            TipoElemento.Parete, dati);
    }

    public void AggiungiFinestra(
        TDatiFinestra finestra,
        Coordinate start,
        Coordinate end,
        Coordinate puntoInserimento,
        double spessoreParete)
    {
        double dx = end.X - start.X;
        double dy = end.Y - start.Y;
        double length = Math.Sqrt(dx * dx + dy * dy);
        if (length <= 1e-12) return;

        (IfcCartesianPoint insertion, IfcDirection direction) =
            CreatePlacement(
                puntoInserimento.X,
                puntoInserimento.Y,
                finestra.Sottofinestra,
                dx / length,
                dy / length,
                0);

        double width = finestra.Larghezza;
        Geometry rectangle = CreateHorizontalRectangle(width, SpesPonte);
        IfcPolyline polyline = CreateIfcPolyline(rectangle.Coordinates, vertical: false);

        var dati = new TDatiSuperficieOpaca(
            finestra.Id,
            finestra.Tipo,
            finestra.Altezza,
            finestra.Larghezza,
            finestra.Sottofinestra,
            finestra.NumeroAnte,
            finestra.Sopraluce);

        RegisterElement(
            polyline, finestra.Altezza,
            $"Finestra {finestra.Tipo}",
            insertion, direction, finestra.Descrizione, "Finestra",
            QuotaCorrente, tetto3D: false, falda: false, verticale: false,
            TipoElemento.Finestra, dati);
    }

    public void AggiungiSolaio(
        Geometry polygon,
        double spessore,
        double quota,
        string id,
        string descrizione,
        bool Solaio3D,
        bool falde,
        TipoElemento tipoElemento,
        TDatiSuperficieOpaca? dati)
    {
        if (tipoElemento == TipoElemento.Falda) CountFalde++;
        else if (tipoElemento == TipoElemento.Pavimento) countpavimenti++;
        else countsoffitti++;

        ModelPolyline3D profile = Tettocor.TrasformaPoligono2DInPolyline3D(polygon, falde);
        if (!Solaio3D && !falde)
        {
            profile = new ModelPolyline3D();
            foreach (Coordinate coordinate in polygon.Coordinates)
                profile.Points.Add(new ModelPoint3D(coordinate.X, coordinate.Y, 0));
        }

        if (falde)
        {
            Piano? current = Piani.LastOrDefault();
            current?.Tetti3d.Add(new FaldaTetto(profile, ColoreTettoCor));
            Tetti3dCor = current?.Tetti3d;
        }

        bool spatial3D = Solaio3D || falde;
        IfcPolyline polyline = spatial3D
            ? CreateIfcPolyline(profile.Points)
            : CreateIfcPolyline(polygon.Coordinates, vertical: false);

        (IfcCartesianPoint insertion, IfcDirection direction) = spatial3D
            ? CreatePlacement(0, 0, 0, 1, 0, 0)
            : CreatePlacement(0, 0, quota, 1, 0, 0);

        RegisterElement(
            polyline, Math.Max(spessore, 0.001), id,
            insertion, direction, descrizione, "Solaio/Pavimento",
            spatial3D ? 0 : QuotaCorrente,
            tetto3D: spatial3D,
            falda: falde,
            verticale: false,
            tipoElemento,
            dati);
    }

    public void AggiungiPonteOriz(
        Line line,
        double quota,
        double quota2,
        double spessore,
        string id,
        string descrizione,
        double Altezza = 0,
        EnumOriginePonte OriginePonte = EnumOriginePonte.Parete)
    {
        double dx = line.End.X - line.Start.X;
        double dy = line.End.Y - line.Start.Y;
        double length = Math.Sqrt(dx * dx + dy * dy);
        if (length <= 1e-12) return;

        countPonti++;

        (IfcCartesianPoint insertion, IfcDirection direction) =
            CreatePlacement(
                (line.Start.X + line.End.X) * 0.5,
                (line.Start.Y + line.End.Y) * 0.5,
                0,
                dx / length,
                dy / length,
                0);

        Geometry rectangle = CreateVerticalTrapezoid(length, quota, quota2, true, SpesPonte);
        IfcPolyline polyline = CreateIfcPolyline(rectangle.Coordinates, vertical: true);

        var start3D = new Coordinate3D(line.Start.X, line.Start.Y, quota);
        var end3D = new Coordinate3D(line.End.X, line.End.Y, quota2);
        var dati = new TDatiSuperficieOpaca(
            descrizione,
            length,
            Altezza,
            start3D,
            end3D,
            false,
            originePonte: OriginePonte);

        RegisterElement(
            polyline, SpesPonte, $"Ponte {countPonti}",
            insertion, direction, descrizione, "Ponte",
            QuotaCorrente, tetto3D: false, falda: false, verticale: true,
            TipoElemento.Ponte, dati);
    }

    public void AggiungiPonteVert(
        double quota,
        Coordinate puntoInserimento,
        Coordinate start,
        Coordinate end,
        double spessore,
        double altezza,
        string id,
        string descrizione,
        EnumOriginePonte OriginePonte = EnumOriginePonte.Parete)
    {
        double dx = end.X - start.X;
        double dy = end.Y - start.Y;
        double length = Math.Sqrt(dx * dx + dy * dy);
        if (length <= 1e-12) return;

        countPonti++;

        (IfcCartesianPoint insertion, IfcDirection direction) =
            CreatePlacement(
                puntoInserimento.X,
                puntoInserimento.Y,
                quota,
                dx / length,
                dy / length,
                0);

        Geometry rectangle = CreateHorizontalRectangle(SpesPonte, SpesPonte);
        IfcPolyline polyline = CreateIfcPolyline(rectangle.Coordinates, vertical: false);

        var start3D = new Coordinate3D(puntoInserimento.X, puntoInserimento.Y, quota);
        var end3D = new Coordinate3D(puntoInserimento.X, puntoInserimento.Y, quota + altezza);
        var dati = new TDatiSuperficieOpaca(
            descrizione,
            length,
            0,
            start3D,
            end3D,
            true,
            originePonte: OriginePonte);

        RegisterElement(
            polyline, altezza, $"Ponte {countPonti}",
            insertion, direction, descrizione, "Ponte Termico",
            QuotaCorrente, tetto3D: false, falda: false, verticale: false,
            TipoElemento.Ponte, dati);
    }

    internal void AggiungiPareteSced(Sced sced, string id)
    {
        Coordinate start = sced.StartCoordinate;
        Coordinate end = sced.EndCoordinate;
        double dx = end.X - start.X;
        double dy = end.Y - start.Y;
        double length = Math.Sqrt(dx * dx + dy * dy);
        if (length <= 1e-12) return;

        (IfcCartesianPoint insertion, IfcDirection direction) =
            CreatePlacement(
                (start.X + end.X) * 0.5,
                (start.Y + end.Y) * 0.5,
                sced.BaseSced,
                dx / length,
                dy / length,
                0);

        Geometry rectangle = CreateVerticalTrapezoid(
            length, sced.AltezzaSced, sced.AltezzaSced, false, 0.3);
        IfcPolyline polyline = CreateIfcPolyline(rectangle.Coordinates, vertical: true);

        RegisterElement(
            polyline, 0.3, id, insertion, direction, sced.Triangolo, "Parete",
            QuotaCorrente, tetto3D: false, falda: false, verticale: true,
            TipoElemento.Parete,
            new TDatiSuperficieOpaca("SCED", "Esterno"));
    }

    public void Close_modello(string outputPath, string xmlBase, string xmlOut)
    {
        // Il modello Web deve derivare dallo stesso catalogo ElementiAssociati
        // usato dal Desktop per confini e filtri, non dalle mesh provvisorie.
        Polig3D.InitClass();
        Polig3D.TrovaConfini(model, GeometricRepresentationContext);

        DrawBim.Instance.Bind(WebModel);
        Polig3D.GrafRedraw(true, forzaModello3D: true);

        model.Dispose();
    }

    private void RegisterElement(
        IfcPolyline polyline,
        double thickness,
        string id,
        IfcCartesianPoint insertion,
        IfcDirection direction,
        string description,
        string type,
        double currentElevation,
        bool tetto3D,
        bool falda,
        bool verticale,
        TipoElemento tipoElemento,
        TDatiSuperficieOpaca? data)
    {
        if (LocaleCorrente is null && tipoElemento != TipoElemento.Falda)
            TermodelLog.LogError($"Elemento '{id}' creato senza locale corrente.");

        var extruded = new PoligonoEstrusoIfc(
            polyline,
            thickness,
            id,
            insertion,
            direction,
            description,
            type,
            currentElevation,
            tetto3D,
            falda,
            verticale);

        Polig3D.ElementoAssociato.AggiungiElemento(
            extruded,
            tipoElemento,
            data!,
            LocaleCorrente!,
            DatiLocaleCorrente!,
            PareteCorrente!,
            NomePianoCor);
    }

    private (IfcCartesianPoint Point, IfcDirection Direction) CreatePlacement(
        double x, double y, double z,
        double dx, double dy, double dz)
    {
        using var txn = model.BeginTransaction("Crea posizionamento elemento");
        IfcCartesianPoint point = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(x, y, z));
        IfcDirection direction = model.Instances.New<IfcDirection>(d => d.SetXYZ(dx, dy, dz));
        txn.Commit();
        return (point, direction);
    }

    private IfcPolyline CreateIfcPolyline(IEnumerable<Coordinate> coordinates, bool vertical)
    {
        using var txn = model.BeginTransaction("Crea IfcPolyline");
        IfcPolyline polyline = model.Instances.New<IfcPolyline>();

        foreach (Coordinate coordinate in coordinates)
        {
            if (!double.IsFinite(coordinate.X) || !double.IsFinite(coordinate.Y))
                continue;

            polyline.Points.Add(model.Instances.New<IfcCartesianPoint>(point =>
            {
                if (vertical)
                    point.SetXYZ(coordinate.X, 0, coordinate.Y);
                else
                    point.SetXYZ(coordinate.X, coordinate.Y, 0);
            }));
        }

        txn.Commit();
        return polyline;
    }

    private IfcPolyline CreateIfcPolyline(IEnumerable<ModelPoint3D> points)
    {
        using var txn = model.BeginTransaction("Crea IfcPolyline 3D");
        IfcPolyline polyline = model.Instances.New<IfcPolyline>();

        foreach (ModelPoint3D source in points)
        {
            polyline.Points.Add(model.Instances.New<IfcCartesianPoint>(point =>
                point.SetXYZ(source.X, source.Y, source.Z)));
        }

        txn.Commit();
        return polyline;
    }

    private static Geometry CreateVerticalTrapezoid(
        double length,
        double h1,
        double h2,
        bool bridge,
        double width)
    {
        double h1p = bridge ? h1 - width : 0;
        double h2p = bridge ? h2 - width : 0;

        Coordinate[] coordinates =
        [
            new(-length / 2, h1p),
            new(-length / 2, h1),
            new(length / 2, h2),
            new(length / 2, h2p),
            new(-length / 2, h1p)
        ];

        return new Polygon(new LinearRing(coordinates));
    }

    private static Geometry CreateHorizontalRectangle(double length, double width)
    {
        Coordinate[] coordinates =
        [
            new(-length / 2, -width / 2),
            new(length / 2, -width / 2),
            new(length / 2, width / 2),
            new(-length / 2, width / 2),
            new(-length / 2, -width / 2)
        ];

        return new Polygon(new LinearRing(coordinates));
    }
}

public static class Modellostatic
{
    public static Modello? mod;
    public static void Initclass(Modello model) => mod = model;
}
