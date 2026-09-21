// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/GeneraModello.cs
// Temporary copy. Align/move to shared source when possible.
// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/GeneraModello.cs
// Temporary copy. Align/move to shared source when possible.
using System.Collections.ObjectModel;
using System.Globalization;
using Termodel.Core.Compatibility;
using Termodel.Core.Model3D;
using Termodel.Core.NetDxfCompat;
using Termodel.Core.ProjectFiles;
using Termodel.utilities;
using static Polig3D;

namespace Termodel.Leggidxf;

// Modificato da Codex per realizzare: copia ridotta e headless dell'orchestratore
// desktop Leggidxf/GeneraModello.cs. Conserva fasi, quote, piani ripetuti e
// classificazione dei piani; elimina WPF, Helix, filesystem DXF e output IFC.
public sealed class GeneraModello
{
    private static readonly SemaphoreSlim GenerationGate = new(1, 1);

    // Funzione realizzata da Codex in autonomia
    public async Task<Model3DGenerationResult> GeneraAsync(
        string projectText,
        CancellationToken cancellationToken = default)
    {
        await GenerationGate.WaitAsync(cancellationToken).ConfigureAwait(false);
        try
        {
            return GeneraSerializzato(projectText);
        }
        finally
        {
            Database.DB.Clear();
            GenerationGate.Release();
        }
    }

    private static Model3DGenerationResult GeneraSerializzato(string projectText)
    {
        ProjectTextDocument project = ProjectTextDocument.Parse(projectText);
        ProjectArchiveDatabase archiveDatabase = ProjectArchiveDatabase.Load(project);
        var utiDb = new UtiDb(archiveDatabase);
        Database.DB.Use(utiDb);
        TermodelLog.Reset();
        GeneraPianta.IniziaGenerazione();

        IReadOnlyList<SvgDxfFloor> svgFloors = SvgDxfReader.ParseProjectSvg(
            project.GetRequiredSection("geometry/project.svg"));
        ObservableCollection<Dictionary<string, object>> floorArchive = utiDb.GetCollection("Piani");
        List<FloorWorkItem> floors = CreateFloorPlan(floorArchive, svgFloors);
        if (floors.Count == 0)
            throw new InvalidDataException("L'archivio Piani non contiene piani attivi elaborabili.");

        var model = new Modello();
        Modellostatic.Initclass(model);
        model.Init_modello();
        Polig3D.ClearAll();
        Modello.netto = string.Equals(
            utiDb.GetDataDBSingleRow("LordoNetto", utiDb.GetCollection("DatiCad")),
            "Netto",
            StringComparison.OrdinalIgnoreCase);
        Modello.numeropiani = CountWalkableFloors(floors);

        var reader = new LeggiDxf(null, null, utiDb, model);
        bool hasWalkableFloor = false;

        // Vecchio flusso conservato: fase 1 coperture, fase 2 piani calpestabili.
        for (int phase = 1; phase <= 2; phase++)
        {
            model.localeCounter = 1;
            double floorElevation = 0;
            for (int floorIndex = 0; floorIndex < floors.Count; floorIndex++)
            {
                FloorWorkItem floor = floors[floorIndex];
                bool processInPhase = floor.IsWalkable ? phase == 2 : phase == 1;
                if (!processInPhase)
                {
                    if (floor.IsWalkable) floorElevation += floor.GrossHeight * floor.Repetitions;
                    continue;
                }

                for (int repetition = 0; repetition < floor.Repetitions; repetition++)
                {
                    string modelFloorName = floor.Repetitions > 1
                        ? $"{floor.Name}({repetition + 1})"
                        : floor.Name;
                    model.Modello_piano(modelFloorName, floorElevation, StringToInTipoPiano(floor.Type));
                    if (floor.IsWalkable) hasWalkableFloor = true;

                    reader.LeggiDocumentoDxf(
                        floor.Cad.Document,
                        $"svg:{floor.Cad.Id}",
                        floor.Name,
                        floor.NetHeight,
                        floor.GrossHeight,
                        floor.Layer,
                        floor.Type,
                        utiDb.GetCollection("Pareti"),
                        phase,
                        floorElevation,
                        GetFloorPosition(floors, floorIndex, repetition));

                    if (floor.IsWalkable) floorElevation += floor.GrossHeight;
                }
            }
        }

        model.Close_modello(string.Empty, string.Empty, string.Empty);
        if (!hasWalkableFloor)
            throw new InvalidDataException("Non sono presenti piani calpestabili attivi.");
        if (double.IsNaN(model.direzNord))
            TermodelLog.LogError("Il simbolo NORD non è stato trovato in nessun piano.");

        return new Model3DGenerationResult(
            model.WebModel,
            TermodelLog.Messages.ToArray(),
            GeneraPianta.PianteDisponibili());
    }

    // Modificato da Codex per realizzare: equivalente headless di Numeropiani.
    private static int CountWalkableFloors(IEnumerable<FloorWorkItem> floors) =>
        floors.Where(floor => floor.IsWalkable).Sum(floor => floor.Repetitions);

    // Modificato da Codex per realizzare: conserva la logica Tipopiano della copia
    // desktop, compresa la numerazione del ciclo usata dal chiamante storico.
    private static LeggiDxf.PosizionePiano GetFloorPosition(
        IReadOnlyList<FloorWorkItem> floors,
        int floorIndex,
        int repetition)
    {
        if (!floors[floorIndex].IsWalkable) return LeggiDxf.PosizionePiano.Copertura;
        int firstWalkableIndex = floors.FindIndex(floor => floor.IsWalkable);
        if (floorIndex == firstWalkableIndex && repetition == 1)
            return LeggiDxf.PosizionePiano.PianoTerra;
        int lastWalkableIndex = floors.FindLastIndex(floor => floor.IsWalkable);
        if (floorIndex == lastWalkableIndex && repetition == floors[floorIndex].Repetitions)
            return LeggiDxf.PosizionePiano.Ultimo;
        return LeggiDxf.PosizionePiano.PianoIntermedio;
    }

    // Funzione realizzata da Codex in autonomia
    private static List<FloorWorkItem> CreateFloorPlan(
        IEnumerable<Dictionary<string, object>> rows,
        IReadOnlyList<SvgDxfFloor> svgFloors)
    {
        var result = new List<FloorWorkItem>();
        foreach (Dictionary<string, object> row in rows)
        {
            if (!string.Equals(GetOptional(row, "Attivo"), "Attivo", StringComparison.OrdinalIgnoreCase))
                continue;

            string name = GetRequired(row, "Nome");
            string type = GetRequired(row, "Tipo");
            string fileName = GetRequired(row, "NomeFile");
            string layer = GetRequired(row, "LayerCad");
            double netHeight = GetFiniteDouble(row, "AltezzaNetta");
            double grossHeight = GetFiniteDouble(row, "AltezzaLorda");
            int repetitions = GetPositiveInt(row, "PianiUguali", 1);
            SvgDxfFloor cad = FindCadFloor(svgFloors, name, fileName, layer, type);
            result.Add(new FloorWorkItem(name, type, layer, netHeight, grossHeight, repetitions, cad));
        }
        return result;
    }

    private static SvgDxfFloor FindCadFloor(
        IReadOnlyList<SvgDxfFloor> floors,
        string name,
        string fileName,
        string layer,
        string type)
    {
        string expectedRole = type.Equals("Copertura", StringComparison.OrdinalIgnoreCase)
            ? "copertura"
            : "calpestabile";
        SvgDxfFloor[] matches = floors.Where(candidate =>
            candidate.Role.Equals(expectedRole, StringComparison.OrdinalIgnoreCase) &&
            candidate.Layer.Equals(layer, StringComparison.OrdinalIgnoreCase) &&
            (candidate.Name.Equals(name, StringComparison.OrdinalIgnoreCase) ||
             candidate.FileName.Equals(fileName, StringComparison.OrdinalIgnoreCase))).ToArray();
        return matches.Length switch
        {
            1 => matches[0],
            0 => throw new InvalidDataException(
                $"Piano '{name}': gruppo SVG non trovato per file '{fileName}', layer '{layer}', ruolo '{expectedRole}'."),
            _ => throw new InvalidDataException($"Piano '{name}': corrispondenza SVG ambigua.")
        };
    }

    private static string GetRequired(IReadOnlyDictionary<string, object> row, string field) =>
        !string.IsNullOrWhiteSpace(GetOptional(row, field))
            ? GetOptional(row, field)
            : throw new InvalidDataException($"Piani.{field} è obbligatorio.");

    private static string GetOptional(IReadOnlyDictionary<string, object> row, string field) =>
        row.TryGetValue(field, out object? value)
            ? Convert.ToString(value, CultureInfo.InvariantCulture)?.Trim() ?? string.Empty
            : string.Empty;

    private static double GetFiniteDouble(IReadOnlyDictionary<string, object> row, string field)
    {
        double value = Utigen.CVStrToDouble(GetRequired(row, field));
        return double.IsFinite(value)
            ? value
            : throw new InvalidDataException($"Piani.{field} non è numerico.");
    }

    private static int GetPositiveInt(IReadOnlyDictionary<string, object> row, string field, int fallback)
    {
        string raw = GetOptional(row, field);
        if (raw.Length == 0) return fallback;
        return int.TryParse(raw, NumberStyles.Integer, CultureInfo.InvariantCulture, out int value) && value > 0
            ? value
            : throw new InvalidDataException($"Piani.{field} deve essere un intero positivo.");
    }

    private sealed record FloorWorkItem(
        string Name,
        string Type,
        string Layer,
        double NetHeight,
        double GrossHeight,
        int Repetitions,
        SvgDxfFloor Cad)
    {
        public bool IsWalkable => Type.Equals("Calpestabile", StringComparison.OrdinalIgnoreCase);
    }
}

public sealed record Model3DGenerationResult(
    TermodelWebModel Model,
    IReadOnlyList<string> Diagnostics,
    IReadOnlyDictionary<string, string> CleanFloorPlans);

internal static class FloorWorkItemListExtensions
{
    public static int FindIndex<T>(this IReadOnlyList<T> items, Func<T, bool> predicate)
    {
        for (int index = 0; index < items.Count; index++)
            if (predicate(items[index])) return index;
        return -1;
    }

    public static int FindLastIndex<T>(this IReadOnlyList<T> items, Func<T, bool> predicate)
    {
        for (int index = items.Count - 1; index >= 0; index--)
            if (predicate(items[index])) return index;
        return -1;
    }
}
