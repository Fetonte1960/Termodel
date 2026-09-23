using System.Collections.ObjectModel;
using System.Globalization;
using Termodel.Core.Compatibility;
using Termodel.Core.NetDxfCompat;
using Termodel.Core.ProjectFiles;
using netDxf.Entities;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Primo solver headless dei circuiti radianti.
/// La geometria arriva dal Virtual CAD; configurazione rete e prodotto
/// arrivano dagli archivi autorevoli Reti e TipologiePannelli del file unico.
/// </summary>
public static class RadiantPanelCalculator
{
    private const double NodeToleranceMeters = 0.001;
    private const double WaterSpecificHeatJkgK = 4180.0;

    private static readonly IReadOnlyDictionary<int, double> StepFactors =
        new Dictionary<int, double>
        {
            [50] = 20.0,
            [100] = 10.0,
            [125] = 8.0,
            [150] = 6.7,
            [175] = 5.8,
            [200] = 5.0,
            [300] = 3.4
        };

    public static RadiantPanelsArtifact Calculate(string projectText)
    {
        ProjectTextDocument project = ProjectTextDocument.Parse(projectText);

        if (!project.Sections.ContainsKey("archives/xml/Reti.xml") ||
            !project.Sections.ContainsKey("archives/xml/TipologiePannelli.xml"))
        {
            return new RadiantPanelsArtifact(
                "TermodelRadiantPanels",
                1,
                "not-configured",
                0,
                0,
                [],
                ["Archivi Reti/TipologiePannelli non presenti: calcolo pannelli non eseguito."]);
        }

        ProjectArchiveDatabase database = ProjectArchiveDatabase.Load(project);
        ObservableCollection<Dictionary<string, object>> networkRows =
            database.GetCollection("Reti");
        ObservableCollection<Dictionary<string, object>> panelRows =
            database.GetCollection("TipologiePannelli");

        IReadOnlyList<SvgDxfFloor> floors = SvgDxfReader.ParseProjectSvg(
            project.GetRequiredSection("geometry/project.svg"));

        List<Dictionary<string, object>> activeNetworks = networkRows
            .Where(IsActive)
            .Where(row => Text(row, "TipoRete")
                .Equals("PannelliRadianti", StringComparison.OrdinalIgnoreCase))
            .ToList();

        var diagnostics = new List<string>();
        var results = new List<RadiantNetworkResult>();

        if (activeNetworks.Count == 0)
        {
            diagnostics.Add("Nessuna rete PannelliRadianti attiva.");
            return new RadiantPanelsArtifact(
                "TermodelRadiantPanels",
                1,
                "completed",
                0,
                0,
                [],
                diagnostics);
        }

        HashSet<string> codes = new(StringComparer.OrdinalIgnoreCase);
        foreach (Dictionary<string, object> networkRow in activeNetworks)
        {
            string networkCode = RequiredText(networkRow, "Codice", "Reti");
            if (!codes.Add(networkCode))
                throw new InvalidDataException($"Reti: Codice duplicato '{networkCode}'.");

            string panelCode = RequiredText(
                networkRow,
                "CodiceTipologiaPannello",
                $"Rete {networkCode}");

            Dictionary<string, object> panelRow = panelRows.FirstOrDefault(row =>
                IsActive(row) &&
                Text(row, "Codice").Equals(panelCode, StringComparison.OrdinalIgnoreCase))
                ?? throw new InvalidDataException(
                    $"Rete {networkCode}: TipologiaPannello '{panelCode}' non trovata o non attiva.");

            NetworkSettings settings = ReadSettings(networkRow, panelRow);
            ValidateStep(settings);

            List<RadiantCircuitResult> circuits = CalculateCircuits(
                floors,
                settings,
                activeNetworks.Count == 1,
                diagnostics);

            List<string> networkDiagnostics = circuits
                .SelectMany(circuit => circuit.Diagnostics)
                .Distinct(StringComparer.Ordinal)
                .ToList();

            if (circuits.Count == 0)
                networkDiagnostics.Add(
                    $"Rete {networkCode}: nessun Tubo CAD associato alla rete.");

            results.Add(new RadiantNetworkResult(
                settings.NetworkCode,
                settings.Description,
                settings.PanelCode,
                settings.Manufacturer,
                settings.Model,
                settings.Material,
                settings.StepMm,
                settings.SupplyTemperatureC,
                settings.ReturnTemperatureC,
                settings.MeanWaterTemperatureC,
                settings.RoomTemperatureC,
                settings.InternalDiameterMm,
                settings.AbsoluteRoughnessMm,
                settings.MaxCircuitLengthM,
                settings.MaxCircuitPressureLossPa,
                circuits.Count,
                circuits,
                networkDiagnostics));
        }

        diagnostics.Add(
            $"Calcolo pannelli completato: {results.Count} reti, " +
            $"{results.Sum(result => result.CircuitCount)} circuiti CAD.");

        return new RadiantPanelsArtifact(
            "TermodelRadiantPanels",
            1,
            "completed",
            results.Count,
            results.Sum(result => result.CircuitCount),
            results,
            diagnostics);
    }

    private static List<RadiantCircuitResult> CalculateCircuits(
        IReadOnlyList<SvgDxfFloor> floors,
        NetworkSettings settings,
        bool acceptLegacyUnassignedNetwork,
        List<string> artifactDiagnostics)
    {
        var results = new List<RadiantCircuitResult>();

        foreach (SvgDxfFloor floor in floors
            .Where(f => f.Role.Equals("calpestabile", StringComparison.OrdinalIgnoreCase))
            .GroupBy(f => f.Id, StringComparer.OrdinalIgnoreCase)
            .Select(group => group.First()))
        {
            string expectedLayer = floor.Name + "_tubipannelli";

            List<Line> lines = floor.Document.Lines
                .Where(line =>
                    line.Layer is not null &&
                    line.Layer.Name.Equals(expectedLayer, StringComparison.OrdinalIgnoreCase))
                .Where(line =>
                {
                    if (line.UserData is not SvgDxfLineMetadata metadata)
                        return acceptLegacyUnassignedNetwork;

                    if (!string.IsNullOrWhiteSpace(metadata.FloorName) &&
                        !metadata.FloorName.Equals(floor.Name, StringComparison.OrdinalIgnoreCase))
                        return false;

                    if (metadata.NetworkCode.Length == 0)
                        return acceptLegacyUnassignedNetwork;

                    return metadata.NetworkCode.Equals(
                        settings.NetworkCode,
                        StringComparison.OrdinalIgnoreCase);
                })
                .ToList();

            if (lines.Count == 0)
                continue;

            IReadOnlyList<CadCircuitComponent> components = SplitIntoComponents(lines);

            int ordinal = 1;
            foreach (CadCircuitComponent component in components)
            {
                string circuitId =
                    $"{settings.NetworkCode}/{floor.Name}/C{ordinal:000}";
                RadiantCircuitResult result = CalculateCircuit(
                    circuitId,
                    floor.Name,
                    component,
                    settings);
                results.Add(result);
                ordinal++;
            }

            artifactDiagnostics.Add(
                $"Rete {settings.NetworkCode}, piano {floor.Name}: " +
                $"{lines.Count} segmenti Tubo -> {components.Count} circuiti connessi.");
        }

        return results;
    }

    private static RadiantCircuitResult CalculateCircuit(
        string circuitId,
        string floorName,
        CadCircuitComponent component,
        NetworkSettings settings)
    {
        double lengthM = component.Segments.Sum(SegmentLength);
        double stepFactor = StepFactor(settings.StepMm);
        double estimatedAreaM2 =
            stepFactor > 0 && settings.KLayout > 0
                ? lengthM / (stepFactor * settings.KLayout)
                : 0;
        double estimatedSpiralLengthM =
            estimatedAreaM2 * stepFactor * settings.KLayout;

        double meanTemperatureC = settings.MeanWaterTemperatureC;
        double density = WaterDensityKgM3(meanTemperatureC);
        double viscosity = WaterDynamicViscosityPaS(meanTemperatureC);
        double temperatureDifference =
            settings.SupplyTemperatureC - settings.ReturnTemperatureC;
        double powerSpecificWm2 = Math.Max(
            0,
            settings.OutputCoefficientWm2K *
            (meanTemperatureC - settings.RoomTemperatureC));
        double estimatedPowerW = estimatedAreaM2 * powerSpecificWm2;

        double massFlowKgS =
            temperatureDifference > 0 && estimatedPowerW > 0
                ? estimatedPowerW /
                  (WaterSpecificHeatJkgK * temperatureDifference)
                : 0;
        double flowM3S = density > 0 ? massFlowKgS / density : 0;

        double diameterM = settings.InternalDiameterMm / 1000.0;
        double areaM2 = Math.PI * diameterM * diameterM / 4.0;
        double velocityMS = areaM2 > 0 ? flowM3S / areaM2 : 0;
        double reynolds =
            viscosity > 0
                ? density * velocityMS * diameterM / viscosity
                : 0;

        var diagnostics = new List<string>
        {
            "Portata derivata dalla potenza preliminare del pannello e dal salto termico; non è una portata misurata/imposta.",
            "Perdita distribuita Darcy-Weisbach; componenti locali, collettore, valvole e flussimetri non ancora modellati.",
            "Nel CAD manuale la centerline Tubo è usata come lunghezza idraulica; la separazione spirale/collegamenti sarà disponibile con il generatore pannelli."
        };

        double friction = DarcyFrictionFactor(
            reynolds,
            settings.AbsoluteRoughnessMm / 1000.0,
            diameterM,
            diagnostics);

        double dynamicPressurePa = density * velocityMS * velocityMS / 2.0;
        double pressureLossPaM =
            diameterM > 0
                ? friction / diameterM * dynamicPressurePa
                : 0;
        double pressureLossPa = pressureLossPaM * lengthM;

        if (component.Branched)
            diagnostics.Add(
                "Topologia ramificata: il componente connesso è trattato come singolo circuito equivalente; verificare il disegno.");

        if (!component.Closed)
            diagnostics.Add(
                "Circuito CAD aperto: ammesso come percorso collettore→circuito→collettore non ancora richiuso graficamente.");

        if (lengthM > settings.MaxCircuitLengthM)
            diagnostics.Add(
                $"Lunghezza {lengthM:0.###} m superiore al limite rete {settings.MaxCircuitLengthM:0.###} m.");

        if (pressureLossPa > settings.MaxCircuitPressureLossPa)
            diagnostics.Add(
                $"Perdita {pressureLossPa:0} Pa superiore al limite rete {settings.MaxCircuitPressureLossPa:0} Pa.");

        if (estimatedPowerW <= 0)
            diagnostics.Add(
                "Potenza preliminare nulla: temperatura media acqua non superiore alla temperatura ambiente o geometria nulla.");

        return new RadiantCircuitResult(
            circuitId,
            settings.NetworkCode,
            floorName,
            component.Segments.Count,
            component.Closed,
            component.Branched,
            lengthM,
            estimatedAreaM2,
            settings.StepMm,
            stepFactor,
            settings.KLayout,
            estimatedSpiralLengthM,
            0,
            lengthM,
            powerSpecificWm2,
            estimatedPowerW,
            flowM3S,
            flowM3S * 3_600_000.0,
            settings.InternalDiameterMm,
            density,
            viscosity,
            velocityMS,
            reynolds,
            friction,
            pressureLossPaM,
            pressureLossPa,
            pressureLossPa / 1000.0,
            pressureLossPa > settings.MaxCircuitPressureLossPa,
            lengthM > settings.MaxCircuitLengthM,
            diagnostics);
    }

    private static IReadOnlyList<CadCircuitComponent> SplitIntoComponents(
        IReadOnlyList<Line> lines)
    {
        var nodes = new List<netDxf.Vector3>();
        var degree = new List<int>();
        var segments = new List<CadSegment>(lines.Count);

        int GetNode(netDxf.Vector3 point)
        {
            for (int index = 0; index < nodes.Count; index++)
            {
                if (Distance(nodes[index], point) <= NodeToleranceMeters)
                    return index;
            }

            nodes.Add(point);
            degree.Add(0);
            return nodes.Count - 1;
        }

        foreach (Line line in lines)
        {
            int a = GetNode(line.StartPoint);
            int b = GetNode(line.EndPoint);
            degree[a]++;
            degree[b]++;
            segments.Add(new CadSegment(line, a, b));
        }

        var nodeToSegments = new Dictionary<int, List<int>>();
        for (int index = 0; index < segments.Count; index++)
        {
            Add(nodeToSegments, segments[index].NodeA, index);
            Add(nodeToSegments, segments[index].NodeB, index);
        }

        var visited = new bool[segments.Count];
        var components = new List<CadCircuitComponent>();

        for (int seed = 0; seed < segments.Count; seed++)
        {
            if (visited[seed])
                continue;

            var queue = new Queue<int>();
            var componentSegments = new List<Line>();
            var componentNodes = new HashSet<int>();
            queue.Enqueue(seed);
            visited[seed] = true;

            while (queue.Count > 0)
            {
                int current = queue.Dequeue();
                CadSegment segment = segments[current];
                componentSegments.Add(segment.Line);
                componentNodes.Add(segment.NodeA);
                componentNodes.Add(segment.NodeB);

                foreach (int node in new[] { segment.NodeA, segment.NodeB })
                {
                    foreach (int neighbor in nodeToSegments[node])
                    {
                        if (visited[neighbor])
                            continue;
                        visited[neighbor] = true;
                        queue.Enqueue(neighbor);
                    }
                }
            }

            bool branched = componentNodes.Any(node => degree[node] > 2);
            int degreeOne = componentNodes.Count(node => degree[node] == 1);
            bool closed =
                componentNodes.Count > 1 &&
                componentNodes.All(node => degree[node] == 2);

            // Un percorso semplice aperto deve avere esattamente due estremi.
            // Qualsiasi altra topologia resta calcolabile ma viene marcata ramificata.
            if (!closed && degreeOne != 2)
                branched = true;

            components.Add(new CadCircuitComponent(
                componentSegments,
                closed,
                branched));
        }

        return components;
    }

    private static NetworkSettings ReadSettings(
        Dictionary<string, object> network,
        Dictionary<string, object> panel)
    {
        string networkCode = RequiredText(network, "Codice", "Reti");
        string fluid = RequiredText(network, "Fluido", $"Rete {networkCode}");
        string formula = RequiredText(network, "FormulaPerdita", $"Rete {networkCode}");

        if (!fluid.Equals("Acqua", StringComparison.OrdinalIgnoreCase))
            throw new InvalidDataException(
                $"Rete {networkCode}: fluido '{fluid}' non ancora supportato.");

        if (!formula.Equals("Darcy-Weisbach", StringComparison.OrdinalIgnoreCase))
            throw new InvalidDataException(
                $"Rete {networkCode}: formula '{formula}' non ancora supportata.");

        double stepMm = PositiveNumber(network, "PassoSelezionatoMm", $"Rete {networkCode}");
        double supply = Number(network, "TemperaturaMandataC", $"Rete {networkCode}");
        double ret = Number(network, "TemperaturaRitornoC", $"Rete {networkCode}");
        if (supply <= ret)
            throw new InvalidDataException(
                $"Rete {networkCode}: TemperaturaMandataC deve essere maggiore di TemperaturaRitornoC.");

        return new NetworkSettings(
            networkCode,
            Text(network, "Descrizione"),
            RequiredText(panel, "Codice", "TipologiePannelli"),
            Text(panel, "CasaProduttrice"),
            Text(panel, "Modello"),
            Text(panel, "MaterialeTubo"),
            stepMm,
            Text(panel, "PassiDisponibiliMm"),
            supply,
            ret,
            Number(network, "TemperaturaAmbienteC", $"Rete {networkCode}"),
            PositiveNumber(network, "LunghezzaMassimaCircuitoM", $"Rete {networkCode}"),
            PositiveNumber(network, "PerditaCaricoMassimaCircuitoPa", $"Rete {networkCode}"),
            PositiveNumber(network, "KLayout", $"Rete {networkCode}"),
            PositiveNumber(panel, "DiametroInternoTuboMm", $"Tipologia {Text(panel, "Codice")}"),
            NonNegativeNumber(panel, "RugositaAssolutaMm", $"Tipologia {Text(panel, "Codice")}"),
            PositiveNumber(panel, "CoefficienteResaWm2K", $"Tipologia {Text(panel, "Codice")}"));
    }

    private static void ValidateStep(NetworkSettings settings)
    {
        double[] allowed = settings.AllowedSteps
            .Split(';', StringSplitOptions.RemoveEmptyEntries | StringSplitOptions.TrimEntries)
            .Select(value =>
                double.TryParse(
                    value.Replace(',', '.'),
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double parsed)
                    ? parsed
                    : double.NaN)
            .Where(double.IsFinite)
            .ToArray();

        if (allowed.Length == 0)
            throw new InvalidDataException(
                $"Tipologia {settings.PanelCode}: PassiDisponibiliMm vuoto o non valido.");

        if (!allowed.Any(value => Math.Abs(value - settings.StepMm) <= 0.001))
            throw new InvalidDataException(
                $"Rete {settings.NetworkCode}: passo {settings.StepMm:0.###} mm non ammesso " +
                $"dalla tipologia {settings.PanelCode} ({settings.AllowedSteps}).");
    }

    private static double StepFactor(double stepMm)
    {
        int rounded = (int)Math.Round(stepMm);
        if (Math.Abs(stepMm - rounded) <= 0.001 &&
            StepFactors.TryGetValue(rounded, out double factor))
            return factor;

        return 1000.0 / stepMm;
    }

    private static double WaterDensityKgM3(double temperatureC)
    {
        double t = Math.Clamp(temperatureC, 0, 100);
        double numerator =
            999.83952 +
            16.945176 * t -
            0.0079870401 * t * t -
            0.000046170461 * t * t * t +
            0.00000010556302 * Math.Pow(t, 4) -
            0.00000000028054253 * Math.Pow(t, 5);
        return numerator / (1 + 0.01687985 * t);
    }

    private static double WaterDynamicViscosityPaS(double temperatureC)
    {
        double t = Math.Clamp(temperatureC, 0, 100);
        return 2.414e-5 * Math.Pow(10, 247.8 / (t + 133.15));
    }

    private static double DarcyFrictionFactor(
        double reynolds,
        double absoluteRoughnessM,
        double diameterM,
        List<string> diagnostics)
    {
        if (reynolds <= 0 || diameterM <= 0)
            return 0;

        if (reynolds < 2300)
            return 64.0 / reynolds;

        double turbulentAt4000 = ColebrookFactor(
            4000,
            absoluteRoughnessM,
            diameterM);

        if (reynolds < 4000)
        {
            diagnostics.Add(
                $"Reynolds {reynolds:0}: regime di transizione; fattore Darcy interpolato fra Re=2300 e Re=4000.");
            double laminarAt2300 = 64.0 / 2300.0;
            double fraction = (reynolds - 2300.0) / 1700.0;
            return laminarAt2300 +
                   fraction * (turbulentAt4000 - laminarAt2300);
        }

        return ColebrookFactor(reynolds, absoluteRoughnessM, diameterM);
    }

    private static double ColebrookFactor(
        double reynolds,
        double absoluteRoughnessM,
        double diameterM)
    {
        double relativeRoughness =
            diameterM > 0 ? Math.Max(0, absoluteRoughnessM) / diameterM : 0;
        double factor = 0.02;

        for (int i = 0; i < 40; i++)
        {
            double inverseSqrt =
                -2.0 * Math.Log10(
                    relativeRoughness / 3.7 +
                    2.51 / (reynolds * Math.Sqrt(factor)));
            double next = 1.0 / (inverseSqrt * inverseSqrt);
            if (Math.Abs(next - factor) < 1e-10)
                return next;
            factor = next;
        }

        return factor;
    }

    private static double SegmentLength(Line line) =>
        Distance(line.StartPoint, line.EndPoint);

    private static double Distance(netDxf.Vector3 a, netDxf.Vector3 b)
    {
        double dx = a.X - b.X;
        double dy = a.Y - b.Y;
        double dz = a.Z - b.Z;
        return Math.Sqrt(dx * dx + dy * dy + dz * dz);
    }

    private static void Add(
        Dictionary<int, List<int>> lookup,
        int node,
        int segment)
    {
        if (!lookup.TryGetValue(node, out List<int>? items))
        {
            items = [];
            lookup.Add(node, items);
        }
        items.Add(segment);
    }

    private static bool IsActive(Dictionary<string, object> row)
    {
        string value = Text(row, "Attivo");
        return value.Length == 0 ||
               value.Equals("SI", StringComparison.OrdinalIgnoreCase) ||
               value.Equals("SÌ", StringComparison.OrdinalIgnoreCase) ||
               value.Equals("ATTIVO", StringComparison.OrdinalIgnoreCase) ||
               value.Equals("TRUE", StringComparison.OrdinalIgnoreCase) ||
               value.Equals("1", StringComparison.OrdinalIgnoreCase);
    }

    private static string RequiredText(
        Dictionary<string, object> row,
        string field,
        string source)
    {
        string value = Text(row, field);
        return value.Length > 0
            ? value
            : throw new InvalidDataException($"{source}: campo '{field}' obbligatorio mancante.");
    }

    private static string Text(Dictionary<string, object> row, string field) =>
        row.TryGetValue(field, out object? value)
            ? Convert.ToString(value, CultureInfo.InvariantCulture)?.Trim() ?? string.Empty
            : string.Empty;

    private static double PositiveNumber(
        Dictionary<string, object> row,
        string field,
        string source)
    {
        double value = Number(row, field, source);
        if (value <= 0)
            throw new InvalidDataException(
                $"{source}: campo '{field}' deve essere maggiore di zero.");
        return value;
    }

    private static double NonNegativeNumber(
        Dictionary<string, object> row,
        string field,
        string source)
    {
        double value = Number(row, field, source);
        if (value < 0)
            throw new InvalidDataException(
                $"{source}: campo '{field}' non può essere negativo.");
        return value;
    }

    private static double Number(
        Dictionary<string, object> row,
        string field,
        string source)
    {
        if (!row.TryGetValue(field, out object? raw) || raw is null)
            throw new InvalidDataException($"{source}: campo numerico '{field}' mancante.");

        if (raw is double d && double.IsFinite(d))
            return d;
        if (raw is float f && float.IsFinite(f))
            return f;
        if (raw is int i)
            return i;
        if (raw is long l)
            return l;
        if (raw is decimal dec)
            return (double)dec;

        string text = Convert.ToString(raw, CultureInfo.InvariantCulture)?.Trim() ?? string.Empty;
        if (double.TryParse(
            text.Replace(',', '.'),
            NumberStyles.Float,
            CultureInfo.InvariantCulture,
            out double value) &&
            double.IsFinite(value))
            return value;

        throw new InvalidDataException(
            $"{source}: campo '{field}' non numerico ('{text}').");
    }

    private sealed record NetworkSettings(
        string NetworkCode,
        string Description,
        string PanelCode,
        string Manufacturer,
        string Model,
        string Material,
        double StepMm,
        string AllowedSteps,
        double SupplyTemperatureC,
        double ReturnTemperatureC,
        double RoomTemperatureC,
        double MaxCircuitLengthM,
        double MaxCircuitPressureLossPa,
        double KLayout,
        double InternalDiameterMm,
        double AbsoluteRoughnessMm,
        double OutputCoefficientWm2K)
    {
        public double MeanWaterTemperatureC =>
            (SupplyTemperatureC + ReturnTemperatureC) / 2.0;
    }

    private sealed record CadSegment(Line Line, int NodeA, int NodeB);

    private sealed record CadCircuitComponent(
        IReadOnlyList<Line> Segments,
        bool Closed,
        bool Branched);
}

public sealed record RadiantPanelsArtifact(
    string Format,
    int Version,
    string Status,
    int NetworkCount,
    int CircuitCount,
    IReadOnlyList<RadiantNetworkResult> Networks,
    IReadOnlyList<string> Diagnostics);

public sealed record RadiantNetworkResult(
    string NetworkCode,
    string Description,
    string PanelCode,
    string Manufacturer,
    string Model,
    string Material,
    double StepMm,
    double SupplyTemperatureC,
    double ReturnTemperatureC,
    double MeanWaterTemperatureC,
    double RoomTemperatureC,
    double InternalDiameterMm,
    double AbsoluteRoughnessMm,
    double MaxCircuitLengthM,
    double MaxCircuitPressureLossPa,
    int CircuitCount,
    IReadOnlyList<RadiantCircuitResult> Circuits,
    IReadOnlyList<string> Diagnostics);

public sealed record RadiantCircuitResult(
    string CircuitId,
    string NetworkCode,
    string FloorName,
    int SegmentCount,
    bool Closed,
    bool Branched,
    double GeometricLengthM,
    double AreaServedEstimatedM2,
    double StepMm,
    double StepFactorMPerM2,
    double KLayout,
    double EstimatedSpiralLengthM,
    double ConnectionLengthM,
    double HydraulicLengthM,
    double PowerSpecificWm2,
    double EstimatedPowerW,
    double FlowM3S,
    double FlowLitersHour,
    double InternalDiameterMm,
    double WaterDensityKgM3,
    double WaterDynamicViscosityPaS,
    double VelocityMS,
    double Reynolds,
    double DarcyFrictionFactor,
    double PressureLossPaM,
    double PressureLossPa,
    double PressureLossKPa,
    bool ExceedsPressureLossLimit,
    bool ExceedsLengthLimit,
    IReadOnlyList<string> Diagnostics);
