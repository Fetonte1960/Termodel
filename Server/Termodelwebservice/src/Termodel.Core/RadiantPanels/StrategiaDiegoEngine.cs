using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Xml.Linq;
using Termodel.utilities;

namespace Termodel.Core.RadiantPanels;

/// <summary>
/// Prima implementazione headless della StrategiaDiego.
/// La strategia e' intenzionalmente esplorativa: costruisce l'albero della
/// mandata e, da ogni terminale, i possibili alberi del ritorno.
/// </summary>
internal static class StrategiaDiegoEngine
{
    public const double DefaultStepMeters = 0.30;
    private const double Epsilon = 1e-7;
    private const double GeometryTolerance = 1e-5;
    private const int DefaultMaxNodes = 250_000;
    private const int DefaultMaxDepth = 128;

    public static StrategiaDiegoResult Generate(
        XDocument floorInput,
        double stepMeters = DefaultStepMeters,
        bool numberSpiralNodes = true)
    {
        if (floorInput.Root is null)
            throw new InvalidDataException("StrategiaDiego: documento locale privo di root.");
        if (!double.IsFinite(stepMeters) || stepMeters <= 0)
            throw new ArgumentOutOfRangeException(nameof(stepMeters));

        int maxNodes = ReadPositiveEnvironmentInt(
            "TERMODEL_DIEGO_MAX_NODES",
            DefaultMaxNodes);
        int maxDepth = ReadPositiveEnvironmentInt(
            "TERMODEL_DIEGO_MAX_DEPTH",
            DefaultMaxDepth);

        long memoryBefore = GC.GetTotalMemory(false);
        var stopwatch = Stopwatch.StartNew();
        var counters = new SearchCounters(maxNodes, maxDepth);
        var diagnostics = new List<string>();
        var solutions = new List<LocaleSolution>();

        List<InputLine> connections = floorInput
            .Descendants("Linea")
            .Select(ParseInputLine)
            .Where(line => line is not null)
            .Cast<InputLine>()
            .ToList();

        LogDiego(
            $"START step={Fmt(stepMeters)}m maxNodes={maxNodes} maxDepth={maxDepth} " +
            $"connections={connections.Count}");

        foreach (XElement localeElement in floorInput.Descendants("Locale"))
        {
            LocaleGeometry? locale = ParseLocale(localeElement);
            if (locale is null)
                continue;

            LogDiego(
                $"LOCALE {locale.Id} perimeterPoints={locale.Perimeter.Count}");

            InputLine? connection = FindConnection(locale, connections);
            if (connection is null)
            {
                LogDiego($"LOCALE {locale.Id} REJECT no incoming connection");
                diagnostics.Add(
                    $"Diego/{locale.Id}: nessun tubo di collegamento entrante.");
                continue;
            }

            LogDiego(
                $"LOCALE {locale.Id} connection={connection.Id} " +
                $"p0={Fmt(connection.P0)} p1={Fmt(connection.P1)}");

            LocaleSolution solution = GenerateLocale(
                locale,
                connection,
                connections,
                stepMeters,
                counters);
            solutions.Add(solution);

            // Modificato da Codex per realizzare: rendere diagnosticabile il
            // tratto terminale scelto nella rete di collegamento LG-011.
            diagnostics.Add(
                $"Diego/{locale.Id}: connection={connection.Id}, " +
                $"connectionConstraints={connections.Count}.");

            diagnostics.Add(
                $"Diego/{locale.Id}: supplyNodes={solution.Metrics.SupplyNodes}, " +
                $"supplyTerminals={solution.Metrics.SupplyTerminals}, " +
                $"returnNodes={solution.Metrics.ReturnNodes}, " +
                $"combinedTerminals={solution.Metrics.CombinedTerminals}, " +
                $"accepted={solution.Metrics.AcceptedTerminals}, " +
                $"maxDepth={solution.Metrics.MaxDepth}, " +
                $"merit={solution.MeritMeters.ToString("0.###", CultureInfo.InvariantCulture)} m, " +
                $"supplyGoodness={Fmt(solution.SupplyGoodness)}, " +
                $"returnGoodness={Fmt(solution.ReturnGoodness)}.");

            LogDiego(
                $"LOCALE {locale.Id} SELECT merit={Fmt(solution.MeritMeters)}m " +
                $"supplyPoints={solution.SupplyPoints.Count} " +
                $"returnPoints={solution.ReturnPoints.Count} " +
                $"returnRoot={solution.ReturnRoot.Side} " +
                $"supplyNodeIds={string.Join(",", solution.SupplyNodeLabels.Select(label => label.NodeId))} " +
                $"returnNodeIds={string.Join(",", solution.ReturnNodeLabels.Select(label => label.NodeId))}");
        }

        if (solutions.Count == 0)
        {
            throw new InvalidDataException(
                "StrategiaDiego non ha prodotto alcuna soluzione di locale.");
        }

        stopwatch.Stop();
        long memoryAfter = GC.GetTotalMemory(false);

        StrategiaDiegoMetrics metrics = new(
            counters.SupplyNodes,
            counters.SupplyTerminals,
            counters.ReturnNodes,
            counters.CombinedTerminals,
            counters.AcceptedTerminals,
            counters.MaxObservedDepth,
            stopwatch.ElapsedMilliseconds,
            Math.Max(0, memoryAfter - memoryBefore),
            counters.TotalNodes,
            maxNodes,
            maxDepth);

        diagnostics.Add(
            $"Diego/TOTALE: nodes={metrics.TotalNodes}, " +
            $"elapsedMs={metrics.ElapsedMilliseconds}, " +
            $"memoryDeltaBytes={metrics.MemoryDeltaBytes}, " +
            $"maxNodes={metrics.MaxNodes}, maxDepthLimit={metrics.MaxDepthLimit}.");

        return new StrategiaDiegoResult(
            WriteSvg(solutions, metrics, numberSpiralNodes),
            stepMeters,
            diagnostics,
            metrics);
    }

    private static LocaleSolution GenerateLocale(
        LocaleGeometry locale,
        InputLine connection,
        IReadOnlyList<InputLine> connections,
        double step,
        SearchCounters counters)
    {
        DirectedConnection directed = DirectConnection(locale, connection);
        LogDiego(
            $"LOCALE {locale.Id} ENTRY point={Fmt(directed.EntryPoint)} " +
            $"dir={Fmt(directed.Direction)} wall={directed.EntryWall.Id}");

        IReadOnlyList<GeoSegment> architecture =
            BuildArchitecture(locale);
        IReadOnlyList<GeoSegment> connectionConstraints =
            BuildConnectionConstraints(connections, connection.Id);

        // LG-011/LG-012: il ritorno di collegamento deve esistere prima
        // dell'esplorazione della mandata. Le due configurazioni laterali
        // restano alternative indipendenti dello stesso ingresso.
        List<ReturnRoot> returnRoots = BuildReturnRoots(
            locale,
            directed,
            step);

        LogDiego(
            $"LOCALE {locale.Id} RETURN roots=" +
            string.Join(",", returnRoots.Select(root => $"{root.Side}:{Fmt(root.EntryPoint)}")));

        if (returnRoots.Count == 0)
        {
            throw new InvalidDataException(
                $"StrategiaDiego/{locale.Id}: impossibile costruire la radice del ritorno.");
        }

        CombinedCandidate? best = null;

        foreach (ReturnRoot returnRoot in returnRoots)
        {
            List<GeoSegment> preliminaryConstraints =
                CombineConstraints(
                    architecture,
                    connectionConstraints,
                    Array.Empty<GeoSegment>(),
                    Array.Empty<GeoSegment>());

            ExtensionResult? rawReturnConnector =
                TryBuildEntryConnector(
                    locale,
                    GeoFamily.Return,
                    returnRoot.EntryPoint,
                    directed.Direction,
                    directed.EntryWall,
                    preliminaryConstraints,
                    step);

            if (rawReturnConnector is null)
            {
                LogDiego(
                    $"LOCALE {locale.Id} RETURN-CONNECTION reject " +
                    $"config={returnRoot.Side} root={Fmt(returnRoot.EntryPoint)}");
                continue;
            }

            // Il raccordo entrante del ritorno e' un tubo fisico limitante:
            // impone le distanze mandata/ritorno ma non e' una linea strategica
            // sulla quale aprire automaticamente una nuova evoluzione.
            GeoSegment returnLimitingSegment =
                rawReturnConnector.Segment with
                {
                    Id =
                        $"D-RETURN-CONNECTION-{locale.Id}-{returnRoot.Side}-" +
                        Guid.NewGuid().ToString("N"),
                    Family = GeoFamily.ReturnConnection
                };

            ExtensionResult returnConnector = new(
                returnLimitingSegment,
                rawReturnConnector.Front);

            LogDiego(
                $"LOCALE {locale.Id} RETURN-CONNECTION accept " +
                $"config={returnRoot.Side} " +
                $"{Fmt(returnLimitingSegment.A)}->{Fmt(returnLimitingSegment.B)} " +
                $"limit=true strategicFront=false");

            // La mandata viene esplorata separatamente per ogni lato del
            // ritorno, perche' il raccordo blu preliminare fa gia' parte della
            // geometria fisica limitante di questo scenario.
            SearchTree supplyTree = BuildTree(
                locale,
                GeoFamily.Supply,
                directed.EntryPoint,
                directed.Direction,
                architecture,
                connectionConstraints,
                new[] { returnLimitingSegment },
                directed.EntryWall,
                step,
                counters,
                countAsSupply: true);

            LogDiego(
                $"LOCALE {locale.Id} SUPPLY tree config={returnRoot.Side} " +
                $"terminals={supplyTree.Terminals.Count}");

            if (supplyTree.Terminals.Count == 0)
                continue;

            SearchNode bestSupplyByGoodness = supplyTree.Terminals
                .OrderByDescending(terminal =>
                    TerminalGoodness(locale, terminal, step))
                .ThenByDescending(ActiveSpiralLength)
                .First();

            LogTerminalGoodness(
                locale,
                GeoFamily.Supply,
                bestSupplyByGoodness,
                step,
                prefix: $"SUPPLY-BEST-GOODNESS config={returnRoot.Side}");

            foreach (SearchNode supplyTerminal in supplyTree.Terminals)
            {
                List<GeoSegment> supplySegments =
                    ReconstructSegments(supplyTerminal);

                SearchTree returnTree = BuildTree(
                    locale,
                    GeoFamily.Return,
                    returnRoot.EntryPoint,
                    directed.Direction,
                    architecture,
                    connectionConstraints,
                    supplySegments,
                    directed.EntryWall,
                    step,
                    counters,
                    countAsSupply: false,
                    initialConnector: returnConnector);

                foreach (SearchNode returnTerminal in returnTree.Terminals)
                {
                    counters.CombinedTerminals++;

                    List<GeoSegment> returnSegments =
                        ReconstructSegments(returnTerminal);

                    GeoSegment closure = new(
                        "CHIUSURA",
                        returnTerminal.End,
                        supplyTerminal.End,
                        GeoFamily.Return,
                        SequenceIndex: returnSegments.Count);

                    if (!IsPreliminaryClosureAcceptable(
                            closure,
                            architecture,
                            supplySegments,
                            returnSegments))
                    {
                        LogDiego(
                            $"LOCALE {locale.Id} CLOSURE reject " +
                            $"{Fmt(closure.A)}->{Fmt(closure.B)}");
                        continue;
                    }

                    counters.AcceptedTerminals++;
                    LogDiego(
                        $"LOCALE {locale.Id} CLOSURE accept " +
                        $"{Fmt(closure.A)}->{Fmt(closure.B)}");

                    double merit =
                        supplyTerminal.LengthMeters +
                        returnTerminal.LengthMeters +
                        closure.Length;

                    if (best is null || merit > best.MeritMeters + Epsilon)
                    {
                        LogDiego(
                            $"LOCALE {locale.Id} BEST update merit={Fmt(merit)}m " +
                            $"supplyNode={supplyTerminal.NodeId} " +
                            $"returnNode={returnTerminal.NodeId} " +
                            $"supplyDepth={supplyTerminal.Depth} " +
                            $"returnDepth={returnTerminal.Depth} " +
                            $"config={returnRoot.Side}");
                        best = new CombinedCandidate(
                            supplyTerminal,
                            returnTerminal,
                            returnRoot,
                            closure,
                            merit);
                    }
                }
            }
        }

        if (best is null)
        {
            throw new InvalidDataException(
                $"StrategiaDiego/{locale.Id}: nessun terminale preliminarmente accettabile.");
        }

        double localeArea = PolygonArea(locale.Perimeter);
        double supplyActiveLength = ActiveSpiralLength(best.SupplyTerminal);
        double returnActiveLength = ActiveSpiralLength(best.ReturnTerminal);
        double supplyGoodness =
            GoodnessFactor(supplyActiveLength, step, localeArea);
        double returnGoodness =
            GoodnessFactor(returnActiveLength, step, localeArea);

        LogDiego(
            $"LOCALE {locale.Id} SELECT-GOODNESS " +
            $"area={Fmt(localeArea)}m2 " +
            $"supplyActive={Fmt(supplyActiveLength)}m " +
            $"supplyFactor={Fmt(supplyGoodness)} " +
            $"returnActive={Fmt(returnActiveLength)}m " +
            $"returnFactor={Fmt(returnGoodness)}");

        return new LocaleSolution(
            locale,
            ReconstructPoints(best.SupplyTerminal),
            ReconstructPoints(best.ReturnTerminal)
                .Append(best.Closure.B)
                .ToList(),
            ReconstructNodeLabels(best.SupplyTerminal),
            ReconstructNodeLabels(best.ReturnTerminal),
            best.ReturnRoot,
            best.MeritMeters,
            counters.SnapshotLocale(),
            supplyActiveLength,
            returnActiveLength,
            supplyGoodness,
            returnGoodness);
    }

    private static SearchTree BuildTree(
        LocaleGeometry locale,
        GeoFamily family,
        DPoint start,
        DVector initialDirection,
        IReadOnlyList<GeoSegment> architecture,
        IReadOnlyList<GeoSegment> connectionConstraints,
        IReadOnlyList<GeoSegment> fixedPath,
        GeoSegment initialFront,
        double step,
        SearchCounters counters,
        bool countAsSupply,
        ExtensionResult? initialConnector = null)
    {
        var terminals = new List<SearchNode>();
        var stack = new Stack<SearchNode>();

        List<GeoSegment> initialConstraints =
            CombineConstraints(
                architecture,
                connectionConstraints,
                fixedPath,
                Array.Empty<GeoSegment>());

        ExtensionResult? first = initialConnector ??
            TryBuildEntryConnector(
                locale,
                family,
                start,
                initialDirection,
                initialFront,
                initialConstraints,
                step);

        if (first is null)
        {
            LogDiego(
                $"TREE {family} initial REJECT start={Fmt(start)} dir={Fmt(initialDirection)}");
            return new SearchTree(terminals);
        }

        int rootNodeId = counters.AddNode(countAsSupply, depth: 1);
        SearchNode root = new(
            parent: null,
            segment: first.Segment,
            front: first.Front,
            direction: initialDirection,
            depth: 1,
            lengthMeters: first.Segment.Length,
            nodeId: rootNodeId);

        LogDiego(
            $"TREE {family} initial ACCEPT node={root.NodeId} " +
            $"{Fmt(first.Segment.A)}->{Fmt(first.Segment.B)} " +
            $"front={first.Front.Id}");

        stack.Push(root);

        while (stack.Count > 0)
        {
            SearchNode node = stack.Pop();
            if (node.Depth >= counters.MaxDepth)
            {
                throw new InvalidOperationException(
                    $"StrategiaDiego: superata profondita massima {counters.MaxDepth}; " +
                    "nessuna potatura euristica applicata.");
            }

            List<GeoSegment> currentPath = ReconstructSegments(node);
            List<GeoSegment> constraints =
                CombineConstraints(
                    architecture,
                    connectionConstraints,
                    fixedPath,
                    currentPath);

            LogDiego(
                $"TREE {family} NODE node={node.NodeId} depth={node.Depth} " +
                $"end={Fmt(node.End)} dir={Fmt(node.Direction)} " +
                $"front={node.Front.Id} pathLen={Fmt(node.LengthMeters)}m");

            var directions = new List<(
                string Name,
                DVector Direction,
                string? ExcludedFrontId,
                string? RequiredFrontId)>();

            // Procedura di scavalcamento del tubo entrante e successivi.
            // Se il nodo precedente e' stato fermato dal raccordo entrante
            // del ritorno e il nodo corrente ha appena agganciato una
            // precedente mandata/ritorno come corsia a 2p, il primo tratto
            // sulla corsia deve seguire il riferimento orientato nel verso
            // opposto. La fase resta un ramo dell'albero e non modifica le
            // regole ordinarie degli altri nodi.
            bool scavalcamentoLaneNode =
                node.Parent is not null &&
                node.Parent.Front.Family == GeoFamily.ReturnConnection &&
                node.Front.Family == family;

            bool afterScavalcamentoOpposite =
                node.Parent is not null &&
                node.Parent.Parent is not null &&
                node.Parent.Parent.Front.Family ==
                    GeoFamily.ReturnConnection &&
                node.Parent.Front.Family == family;

            if (scavalcamentoLaneNode)
            {
                DVector opposite =
                    -node.Front.Direction.Normalize();

                // Il primo tratto sulla corsia usa il verso opposto al
                // riferimento orientato, ma non forza ancora S_k+1:
                // il front successivo viene scelto dalle normali intersezioni
                // fisiche/strategiche. Forzare FindSequenceContinuation qui
                // farebbe riagganciare il segmento appena percorso, che fa
                // parte di currentPath ma non e' il successore della vecchia
                // evoluzione da inseguire.
                directions.Add((
                    "SCAVALCAMENTO_OPPOSTA",
                    opposite,
                    null,
                    null));

                LogDiego(
                    $"SCAVALCAMENTO opposite-lane node={node.NodeId} " +
                    $"family={family} reference={node.Front.Id} " +
                    $"referenceDir={Fmt(node.Front.Direction.Normalize())} " +
                    $"travelDir={Fmt(opposite)} requiredFront=-");
            }
            else
            {
                // Il raccordo tecnico non e' una evoluzione e non introduce
                // eccezioni nel nodo che segue: PROSEGUI_DRITTO viene valutato
                // come qualunque altra alternativa e puo' essere scartato solo
                // dalle normali verifiche geometriche.
                directions.Add(
                    ("PROSEGUI_DRITTO", node.Direction, node.Front.Id, null));

                DVector parallel = node.Front.Direction.Normalize();
                GeoSegment? continuationA =
                    FindSequenceContinuation(
                        node.End,
                        node.Front,
                        constraints,
                        family,
                        parallel,
                        afterScavalcamentoOpposite
                            ? node.Segment.Id
                            : null);
                GeoSegment? continuationB =
                    FindSequenceContinuation(
                        node.End,
                        node.Front,
                        constraints,
                        family,
                        -parallel,
                        afterScavalcamentoOpposite
                            ? node.Segment.Id
                            : null);

                directions.Add((
                    "PARALLELA_A",
                    parallel,
                    null,
                    continuationA?.Id));
                directions.Add((
                    "PARALLELA_B",
                    -parallel,
                    null,
                    continuationB?.Id));
            }

            var children = new List<SearchNode>();
            foreach ((
                string choiceName,
                DVector direction,
                string? excludedFront,
                string? requiredFront) in directions)
            {
                ExtensionResult? extension = TryExtend(
                    locale,
                    family,
                    node.End,
                    direction,
                    constraints,
                    node.Segment,
                    excludedFront,
                    requiredFront,
                    step,
                    allowStartOnBoundary: false,
                    relaxedDistanceConstraintId:
                        afterScavalcamentoOpposite
                            ? node.Parent!.Segment.Id
                            : null);

                if (extension is null)
                {
                    LogDiego(
                        $"TREE {family} CHOICE {choiceName} REJECT " +
                        $"parentNode={node.NodeId} start={Fmt(node.End)} " +
                        $"dir={Fmt(direction)} requiredFront={requiredFront ?? "-"}");
                    continue;
                }

                if (children.Any(existing =>
                    SegmentsEquivalent(existing.Segment, extension.Segment)))
                {
                    continue;
                }

                int childNodeId =
                    counters.AddNode(countAsSupply, node.Depth + 1);
                SearchNode child = new(
                    node,
                    extension.Segment,
                    extension.Front,
                    direction,
                    node.Depth + 1,
                    node.LengthMeters + extension.Segment.Length,
                    childNodeId);

                LogDiego(
                    $"TREE {family} CHOICE {choiceName} ACCEPT " +
                    $"parentNode={node.NodeId} childNode={child.NodeId} " +
                    $"{Fmt(extension.Segment.A)}->{Fmt(extension.Segment.B)} " +
                    $"front={extension.Front.Id}");

                if (node.Front.Family == GeoFamily.ReturnConnection &&
                    extension.Front.Family == family)
                {
                    LogDiego(
                        $"SCAVALCAMENTO lane-attach parentNode={node.NodeId} " +
                        $"childNode={child.NodeId} family={family} " +
                        $"limitingFront={node.Front.Id} " +
                        $"strategicReference={extension.Front.Id} " +
                        $"segment={Fmt(extension.Segment.A)}->{Fmt(extension.Segment.B)}");
                }

                children.Add(child);
            }

            if (children.Count == 0)
            {
                terminals.Add(node);
                counters.AddTerminal(countAsSupply);
                LogDiego(
                    $"TREE {family} TERMINAL node={node.NodeId} " +
                    $"depth={node.Depth} end={Fmt(node.End)} " +
                    $"length={Fmt(node.LengthMeters)}m");
                LogTerminalGoodness(
                    locale,
                    family,
                    node,
                    step,
                    prefix: "TERMINAL-GOODNESS");
                continue;
            }

            foreach (SearchNode child in children)
                stack.Push(child);
        }

        return new SearchTree(terminals);
    }

    private static ExtensionResult? TryBuildEntryConnector(
        LocaleGeometry locale,
        GeoFamily family,
        DPoint start,
        DVector direction,
        GeoSegment entryWall,
        IReadOnlyList<GeoSegment> constraints,
        double step)
    {
        DVector unit = direction.Normalize();
        DVector wallUnit = entryWall.Direction.Normalize();
        double sine = Math.Abs(DVector.Cross(unit, wallUnit));

        // Il raccordo iniziale non e' una "prima evoluzione" speciale.
        // Serve soltanto a portare il tubo entrante sulla prima traccia utile,
        // la cui quota deriva dalle normali distanze LG-006:
        // mandata = p/2 dalla parete; ritorno = p oltre la mandata,
        // quindi 1,5p dalla parete nel corridoio iniziale ordinario.
        double offsetDistance =
            EntryConnectorTargetDistance(family, step);

        if (unit.Length <= Epsilon ||
            wallUnit.Length <= Epsilon ||
            sine <= Epsilon ||
            offsetDistance <= GeometryTolerance)
        {
            return null;
        }

        double travel = offsetDistance / sine;
        DPoint end = start + unit * travel;

        LogDiego(
            $"ENTRY-CONNECTOR {family} entry={Fmt(start)} entryDir={Fmt(unit)} " +
            $"wall={entryWall.Id} wallA={Fmt(entryWall.A)} wallB={Fmt(entryWall.B)} " +
            $"offset={Fmt(offsetDistance)}m sine={Fmt(sine)} travel={Fmt(travel)}m " +
            $"computedEnd={Fmt(end)} step={Fmt(step)}m");

        var candidate = new GeoSegment(
            $"D-INITIAL-{family}-{Guid.NewGuid():N}",
            start,
            end,
            family,
            SequenceIndex: 0);

        if (!IsSegmentValid(
                locale,
                candidate,
                constraints,
                previousSegment: null,
                entryWall,
                step,
                allowStartOnBoundary: true))
        {
            LogDiego(
                $"ENTRY-CONNECTOR {family} REJECT candidate={Fmt(candidate.A)}->{Fmt(candidate.B)}");
            return null;
        }

        LogDiego(
            $"ENTRY-CONNECTOR {family} ACCEPT candidate={Fmt(candidate.A)}->{Fmt(candidate.B)} " +
            $"note=technical-entry-connector");
        return new ExtensionResult(candidate, entryWall);
    }

    private static ExtensionResult? TryExtend(
        LocaleGeometry locale,
        GeoFamily family,
        DPoint start,
        DVector direction,
        IReadOnlyList<GeoSegment> constraints,
        GeoSegment? previousSegment,
        string? excludedFrontId,
        string? requiredFrontId,
        double step,
        bool allowStartOnBoundary,
        string? relaxedDistanceConstraintId = null)
    {
        DVector unit = direction.Normalize();
        if (unit.Length <= Epsilon)
            return null;

        ExtensionResult? best = null;
        bool bestIsReturnConnectionLimiter = false;

        foreach (GeoSegment reference in constraints)
        {
            if (relaxedDistanceConstraintId is not null &&
                reference.Id.Equals(
                    relaxedDistanceConstraintId,
                    StringComparison.Ordinal))
            {
                continue;
            }

            // I normali tubi di collegamento restano soli ostacoli
            // anti-attraversamento. Il raccordo entrante del ritorno, invece,
            // partecipa anche al troncamento fisico della procedura di
            // scavalcamento, senza diventare riferimento strategico LG-033.
            if (reference.Family == GeoFamily.Connection)
                continue;

            bool isReturnConnection =
                reference.Family == GeoFamily.ReturnConnection;

            if (requiredFrontId is not null &&
                !isReturnConnection &&
                !reference.Id.Equals(requiredFrontId, StringComparison.Ordinal))
            {
                continue;
            }

            if (excludedFrontId is not null &&
                reference.Id.Equals(excludedFrontId, StringComparison.Ordinal))
            {
                continue;
            }

            if (previousSegment is GeoSegment previous &&
                reference.Id.Equals(previous.Id, StringComparison.Ordinal))
            {
                continue;
            }

            DVector refDirection = reference.Direction;
            double refLength = refDirection.Length;
            if (refLength <= Epsilon)
                continue;

            DVector refUnit = refDirection / refLength;
            double cross = DVector.Cross(unit, refUnit);
            if (Math.Abs(cross) <= Epsilon)
                continue;

            DVector delta = reference.A - start;
            double tIntersection = DVector.Cross(delta, refUnit) / cross;

            // Una intersezione teorica appena dietro resta inammissibile.
            // L'intersezione a distanza zero, invece, e' ammessa: se cade
            // soltanto sul prolungamento di un tubo, LG-034/LG-035 richiede
            // di poter valutare il punto convesso I+d oltre la linea estesa.
            if (tIntersection < -GeometryTolerance)
                continue;

            if (Math.Abs(tIntersection) <= GeometryTolerance)
                tIntersection = 0.0;

            double uReference =
                DVector.Cross(delta, unit) /
                DVector.Cross(unit, refDirection);

            bool physicalHit =
                uReference >= -GeometryTolerance &&
                uReference <= 1.0 + GeometryTolerance;

            // Le estensioni architettoniche non sono ostacoli fisici.
            // Anche ReturnConnection vale esclusivamente sul proprio segmento
            // fisico: non deve mai diventare una linea strategica estesa.
            // Le estensioni di Supply/Return possono invece essere marcatori
            // strategici per l'inseguimento convesso (LG-033..LG-035).
            if (!physicalHit &&
                reference.Family is
                    GeoFamily.Architecture or GeoFamily.ReturnConnection)
            {
                continue;
            }

            double respect = RequiredDistance(
                family,
                reference.Family,
                step);

            double alongRay = respect / Math.Abs(cross);
            // Modificato da Codex per realizzare: non applicare LG-035 finche'
            // il nodo non conserva esplicitamente S_k orientato. Usare
            // node.Front come sostituto ha eliminato le chiusure del quadrato.
            double tEnd = physicalHit
                ? tIntersection - alongRay
                : tIntersection + alongRay;

            if (!physicalHit &&
                tIntersection <= GeometryTolerance &&
                reference.Family is GeoFamily.Supply or GeoFamily.Return)
            {
                LogDiego(
                    $"EXTEND beyond-extended-front family={family} " +
                    $"reference={reference.Id} refFamily={reference.Family} " +
                    $"start={Fmt(start)} dir={Fmt(unit)} I={Fmt(tIntersection)}m " +
                    $"respect={Fmt(respect)}m alongRay={Fmt(alongRay)}m " +
                    $"targetTravel={Fmt(tEnd)}m");
            }

            if (tEnd <= GeometryTolerance)
                continue;

            DPoint end = start + unit * tEnd;
            var candidate = new GeoSegment(
                $"D-{family}-{Guid.NewGuid():N}",
                start,
                end,
                family,
                SequenceIndex: -1);

            if (candidate.Length <= GeometryTolerance)
                continue;

            if (!IsSegmentValid(
                    locale,
                    candidate,
                    constraints,
                    previousSegment,
                    reference,
                    step,
                    allowStartOnBoundary,
                    relaxedDistanceConstraintId))
            {
                continue;
            }

            bool isReturnConnectionLimiter =
                physicalHit &&
                reference.Family == GeoFamily.ReturnConnection;

            if (isReturnConnectionLimiter)
            {
                LogDiego(
                    $"SCAVALCAMENTO physical-limit family={family} " +
                    $"reference={reference.Id} start={Fmt(start)} " +
                    $"dir={Fmt(unit)} respect={Fmt(respect)}m " +
                    $"target={Fmt(candidate.B)}");
            }

            // Durante lo scavalcamento il raccordo entrante del ritorno e'
            // un limite fisico prioritario rispetto a un marcatore virtuale
            // I+2p sul prolungamento di una tubazione. Le normali validazioni
            // hanno gia' escluso eventuali ostacoli fisici piu' vicini.
            if (best is null ||
                (isReturnConnectionLimiter &&
                 !bestIsReturnConnectionLimiter) ||
                (isReturnConnectionLimiter ==
                     bestIsReturnConnectionLimiter &&
                 candidate.Length <
                     best.Segment.Length - GeometryTolerance))
            {
                best = new ExtensionResult(candidate, reference);
                bestIsReturnConnectionLimiter =
                    isReturnConnectionLimiter;
            }
        }

        return best;
    }

    private static bool IsSegmentValid(
        LocaleGeometry locale,
        GeoSegment candidate,
        IReadOnlyList<GeoSegment> constraints,
        GeoSegment? previousSegment,
        GeoSegment front,
        double step,
        bool allowStartOnBoundary,
        string? relaxedDistanceConstraintId = null)
    {
        if (!SegmentInsideLocale(
                locale,
                candidate,
                allowStartOnBoundary))
        {
            LogDiego(
                $"VALIDATE {candidate.Family} REJECT outside locale={locale.Id} " +
                $"{Fmt(candidate.A)}->{Fmt(candidate.B)}");
            return false;
        }

        foreach (GeoSegment other in constraints)
        {
            if (previousSegment is GeoSegment previous &&
                other.Id.Equals(previous.Id, StringComparison.Ordinal))
            {
                continue;
            }

            bool isFront =
                other.Id.Equals(front.Id, StringComparison.Ordinal);

            if (allowStartOnBoundary &&
                other.Family == GeoFamily.Architecture &&
                Distance(candidate.A, other.A, other.B) <= GeometryTolerance)
            {
                // Il tubo di collegamento entra dalla parete: il solo contatto
                // iniziale e' ammesso. Questa eccezione deve precedere il test
                // di intersezione, perche il punto d'ingresso appartiene
                // all'interno del segmento parete e non a un suo estremo.
                continue;
            }

            if (SegmentsProperlyIntersect(candidate, other))
            {
                LogDiego(
                    $"VALIDATE {candidate.Family} REJECT intersection other={other.Id} " +
                    $"{Fmt(candidate.A)}->{Fmt(candidate.B)}");
                return false;
            }

            if (relaxedDistanceConstraintId is not null &&
                other.Id.Equals(
                    relaxedDistanceConstraintId,
                    StringComparison.Ordinal))
            {
                LogDiego(
                    $"SCAVALCAMENTO transition-distance-exempt " +
                    $"family={candidate.Family} other={other.Id} " +
                    $"candidate={Fmt(candidate.A)}->{Fmt(candidate.B)}");
                continue;
            }

            double required = RequiredDistance(
                candidate.Family,
                other.Family,
                step);

            double distance = SegmentDistance(candidate, other);

            if (isFront)
            {
                if (distance < required - GeometryTolerance)
                {
                    LogDiego(
                        $"VALIDATE {candidate.Family} REJECT frontDistance={Fmt(distance)} " +
                        $"required={Fmt(required)} other={other.Id}");
                    return false;
                }
                continue;
            }

            if (distance < required - GeometryTolerance)
            {
                LogDiego(
                    $"VALIDATE {candidate.Family} REJECT distance={Fmt(distance)} " +
                    $"required={Fmt(required)} other={other.Id} family={other.Family}");
                return false;
            }
        }

        return true;
    }

    private static bool SegmentInsideLocale(
        LocaleGeometry locale,
        GeoSegment segment,
        bool allowStartOnBoundary)
    {
        // Modificato da Codex per realizzare: sostituire il campionamento a
        // 24 punti con una verifica geometrica deterministica. Un segmento
        // poteva uscire e rientrare da una concavita' stretta fra due campioni.
        if (!allowStartOnBoundary &&
            !PointInOrOnPolygon(segment.A, locale.Perimeter))
        {
            return false;
        }

        if (!PointInOrOnPolygon(segment.B, locale.Perimeter))
            return false;

        IReadOnlyList<GeoSegment> walls = BuildArchitecture(locale);
        foreach (GeoSegment wall in walls)
        {
            if (allowStartOnBoundary &&
                Distance(segment.A, wall.A, wall.B) <= GeometryTolerance)
            {
                continue;
            }

            if (SegmentsProperlyIntersect(segment, wall))
                return false;
        }

        return PointInOrOnPolygon(
            DPoint.Lerp(segment.A, segment.B, 0.5),
            locale.Perimeter);
    }

    private static bool IsPreliminaryClosureAcceptable(
        GeoSegment closure,
        IReadOnlyList<GeoSegment> architecture,
        IReadOnlyList<GeoSegment> supply,
        IReadOnlyList<GeoSegment> returns)
    {
        foreach (GeoSegment obstacle in architecture.Concat(supply).Concat(returns))
        {
            if (SharesEndpoint(closure, obstacle))
                continue;
            if (SegmentsProperlyIntersect(closure, obstacle))
            {
                LogDiego(
                    $"CLOSURE-DETAIL reject crossing obstacle={obstacle.Id} " +
                    $"family={obstacle.Family} seq={obstacle.SequenceIndex} " +
                    $"obstacle={Fmt(obstacle.A)}->{Fmt(obstacle.B)} " +
                    $"closure={Fmt(closure.A)}->{Fmt(closure.B)}");
                return false;
            }
        }

        LogDiego(
            $"CLOSURE-DETAIL accept no-proper-crossing " +
            $"closure={Fmt(closure.A)}->{Fmt(closure.B)}");
        return true;
    }

    private static List<ReturnRoot> BuildReturnRoots(
        LocaleGeometry locale,
        DirectedConnection connection,
        double step)
    {
        GeoSegment wall = connection.EntryWall;
        DVector tangent = wall.Direction.Normalize();
        var result = new List<ReturnRoot>();

        foreach (double sign in new[] { -1.0, 1.0 })
        {
            DPoint entry =
                connection.EntryPoint +
                tangent * (step * sign);

            if (Distance(entry, wall.A, wall.B) > GeometryTolerance * 10)
                continue;

            // Un minimo margine dal vertice evita una radice numericamente
            // coincidente con un angolo.
            if (entry.DistanceTo(wall.A) < step / 4.0 ||
                entry.DistanceTo(wall.B) < step / 4.0)
            {
                continue;
            }

            result.Add(new ReturnRoot(
                sign < 0 ? "Sinistra" : "Destra",
                entry));
        }

        return result;
    }

    private static DirectedConnection DirectConnection(
        LocaleGeometry locale,
        InputLine line)
    {
        bool p0Inside = PointStrictlyInsidePolygon(line.P0, locale.Perimeter);
        bool p1Inside = PointStrictlyInsidePolygon(line.P1, locale.Perimeter);

        DPoint outside;
        DPoint inside;
        if (p0Inside && !p1Inside)
        {
            inside = line.P0;
            outside = line.P1;
        }
        else if (p1Inside && !p0Inside)
        {
            inside = line.P1;
            outside = line.P0;
        }
        else
        {
            throw new InvalidDataException(
                $"StrategiaDiego/{locale.Id}: tubo {line.Id} non definisce un ingresso univoco.");
        }

        DVector direction = (inside - outside).Normalize();
        (DPoint entry, GeoSegment wall) =
            FindBoundaryEntry(locale, outside, inside);

        return new DirectedConnection(
            line.Id,
            outside,
            inside,
            entry,
            direction,
            wall);
    }

    private static (DPoint Entry, GeoSegment Wall) FindBoundaryEntry(
        LocaleGeometry locale,
        DPoint outside,
        DPoint inside)
    {
        GeoSegment travel = new(
            "INGRESSO",
            outside,
            inside,
            GeoFamily.Supply,
            -1);

        DPoint? bestPoint = null;
        GeoSegment? bestWall = null;
        double bestDistance = double.PositiveInfinity;

        IReadOnlyList<GeoSegment> walls = BuildArchitecture(locale);
        foreach (GeoSegment wall in walls)
        {
            if (!TrySegmentIntersection(
                    travel.A,
                    travel.B,
                    wall.A,
                    wall.B,
                    out DPoint intersection,
                    out _,
                    out _))
            {
                continue;
            }

            double distance = outside.DistanceTo(intersection);
            if (distance < bestDistance)
            {
                bestDistance = distance;
                bestPoint = intersection;
                bestWall = wall;
            }
        }

        if (bestPoint is null || bestWall is null)
        {
            throw new InvalidDataException(
                $"StrategiaDiego/{locale.Id}: ingresso non interseca il perimetro.");
        }

        return (bestPoint.Value, bestWall.Value);
    }

    private static IReadOnlyList<GeoSegment> BuildArchitecture(
        LocaleGeometry locale)
    {
        var result = new List<GeoSegment>();
        for (int i = 0; i < locale.Perimeter.Count; i++)
        {
            result.Add(new GeoSegment(
                $"A-{locale.Id}-{i}",
                locale.Perimeter[i],
                locale.Perimeter[(i + 1) % locale.Perimeter.Count],
                GeoFamily.Architecture,
                i));
        }
        return result;
    }

    // Funzione realizzata da Codex in autonomia
    private static IReadOnlyList<GeoSegment> BuildConnectionConstraints(
        IReadOnlyList<InputLine> connections,
        string selectedConnectionId)
    {
        var result = new List<GeoSegment>(connections.Count);
        for (int i = 0; i < connections.Count; i++)
        {
            InputLine line = connections[i];
            if (line.Id.Equals(
                    selectedConnectionId,
                    StringComparison.Ordinal))
            {
                continue;
            }

            result.Add(new GeoSegment(
                $"C-{line.Id}-{i}",
                line.P0,
                line.P1,
                GeoFamily.Connection,
                i));
        }
        return result;
    }

    private static InputLine? FindConnection(
        LocaleGeometry locale,
        IReadOnlyList<InputLine> lines)
    {
        foreach (InputLine line in lines)
        {
            bool p0Inside =
                PointStrictlyInsidePolygon(line.P0, locale.Perimeter);
            bool p1Inside =
                PointStrictlyInsidePolygon(line.P1, locale.Perimeter);

            if (p0Inside == p1Inside)
                continue;

            DPoint innerPoint = p0Inside ? line.P0 : line.P1;
            // Modificato da Codex per realizzare: come nel riferimento GPT,
            // un tratto che prosegue in un altro ramo non e' ancora il tratto
            // terminale d'ingresso del circuito LG-011.
            bool sharedInnerPoint = lines.Any(other =>
                !ReferenceEquals(other, line) &&
                (innerPoint.DistanceTo(other.P0) <= GeometryTolerance ||
                 innerPoint.DistanceTo(other.P1) <= GeometryTolerance));

            if (!sharedInnerPoint)
                return line;
        }

        return null;
    }

    private static LocaleGeometry? ParseLocale(XElement element)
    {
        string id =
            ((string?)element.Attribute("Id") ?? string.Empty).Trim();
        if (id.Length == 0)
            return null;

        List<DPoint> points = element
            .Descendants("PerimetroInterno")
            .Elements("Punto")
            .Select(ParsePoint)
            .Where(point => point.HasValue)
            .Select(point => point!.Value)
            .ToList();

        if (points.Count > 1 &&
            points[0].DistanceTo(points[^1]) <= GeometryTolerance)
        {
            points.RemoveAt(points.Count - 1);
        }

        points = RemoveCollinear(points);
        return points.Count >= 3
            ? new LocaleGeometry(id, points)
            : null;
    }

    private static InputLine? ParseInputLine(XElement element)
    {
        DPoint? p0 = ParsePoint(element.Element("P0"));
        DPoint? p1 = ParsePoint(element.Element("P1"));
        if (p0 is null || p1 is null)
            return null;

        string id =
            ((string?)element.Attribute("Id") ?? Guid.NewGuid().ToString("N"));
        return new InputLine(id, p0.Value, p1.Value);
    }

    private static DPoint? ParsePoint(XElement? element)
    {
        if (element is null)
            return null;

        if (!double.TryParse(
                (string?)element.Attribute("X"),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out double x) ||
            !double.TryParse(
                (string?)element.Attribute("Y"),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out double y))
        {
            return null;
        }

        return new DPoint(x, y);
    }

    private static List<DPoint> RemoveCollinear(List<DPoint> source)
    {
        if (source.Count < 3)
            return source;

        var result = new List<DPoint>();
        for (int i = 0; i < source.Count; i++)
        {
            DPoint prev = source[(i - 1 + source.Count) % source.Count];
            DPoint current = source[i];
            DPoint next = source[(i + 1) % source.Count];

            DVector a = current - prev;
            DVector b = next - current;
            if (Math.Abs(DVector.Cross(a, b)) <= GeometryTolerance &&
                DVector.Dot(a, b) >= 0)
            {
                continue;
            }
            result.Add(current);
        }

        return result;
    }

    private static double EntryConnectorTargetDistance(
        GeoFamily family,
        double step)
    {
        // Nessuna evoluzione riceve una quota speciale perche' e' "prima".
        // Questa funzione determina esclusivamente quanto deve avanzare il
        // raccordo tecnico d'ingresso per raggiungere la prima traccia utile.
        // Le quote sono derivate dalla stessa matrice di distanze usata per
        // tutte le altre evoluzioni.
        double wallDistance =
            RequiredDistance(family, GeoFamily.Architecture, step);

        if (family == GeoFamily.Return)
        {
            return wallDistance +
                   RequiredDistance(
                       GeoFamily.Return,
                       GeoFamily.Supply,
                       step);
        }

        return wallDistance;
    }

    private static double RequiredDistance(
        GeoFamily newFamily,
        GeoFamily referenceFamily,
        double step)
    {
        if (referenceFamily == GeoFamily.Architecture)
            return step / 2.0;

        // Gli altri tubi della rete utente restano ostacoli anti-attraversamento.
        if (referenceFamily == GeoFamily.Connection)
            return 0.0;

        // Il tratto entrante del ritorno e' fisicamente un ritorno ma non e'
        // una linea strategica. Rispetta quindi p rispetto alla mandata e 2p
        // rispetto agli altri tratti di ritorno.
        if (referenceFamily == GeoFamily.ReturnConnection)
        {
            return newFamily == GeoFamily.Supply
                ? step
                : step * 2.0;
        }

        return newFamily == referenceFamily
            ? step * 2.0
            : step;
    }

    private static List<GeoSegment> CombineConstraints(
        IReadOnlyList<GeoSegment> architecture,
        IReadOnlyList<GeoSegment> connectionConstraints,
        IReadOnlyList<GeoSegment> fixedPath,
        IReadOnlyList<GeoSegment> currentPath)
    {
        var result = new List<GeoSegment>(
            architecture.Count + connectionConstraints.Count +
            fixedPath.Count + currentPath.Count);
        result.AddRange(architecture);
        result.AddRange(connectionConstraints);
        result.AddRange(fixedPath);
        result.AddRange(currentPath);
        return result;
    }

    private static GeoSegment? FindSequenceContinuation(
        DPoint start,
        GeoSegment front,
        IReadOnlyList<GeoSegment> constraints,
        GeoFamily pathFamily,
        DVector travelDirection,
        string? excludedSegmentId = null)
    {
        if (front.Family == GeoFamily.Architecture ||
            front.SequenceIndex < 0)
        {
            return null;
        }

        bool followsOwnFamily =
            pathFamily == front.Family;
        bool returnFollowsSupply =
            pathFamily == GeoFamily.Return &&
            front.Family == GeoFamily.Supply;

        // LG-033/LG-035: quando il tubo sta inseguendo una propria evoluzione
        // precedente, il "successivo" riferimento non e' definito dal solo
        // SequenceIndex+1. Il riferimento corretto e' la prima retta
        // pertinente incontrata DAVANTI nella direzione corrente.
        //
        // La stessa costruzione resta valida per il ritorno che insegue la
        // mandata. Gli altri casi mantengono la semantica sequenziale storica.
        if (!followsOwnFamily &&
            !returnFollowsSupply)
        {
            return constraints.FirstOrDefault(candidate =>
                candidate.Family == front.Family &&
                candidate.SequenceIndex == front.SequenceIndex + 1 &&
                (excludedSegmentId is null ||
                 !candidate.Id.Equals(
                     excludedSegmentId,
                     StringComparison.Ordinal)));
        }

        DVector travel = travelDirection.Normalize();
        if (travel.Length <= Epsilon)
            return null;

        GeoSegment? best = null;
        double bestTravel = double.PositiveInfinity;
        bool bestPhysicalHit = false;

        foreach (GeoSegment candidate in constraints.Where(candidate =>
                     candidate.Family == front.Family &&
                     candidate.SequenceIndex >= 0 &&
                     candidate.SequenceIndex != front.SequenceIndex &&
                     (excludedSegmentId is null ||
                      !candidate.Id.Equals(
                          excludedSegmentId,
                          StringComparison.Ordinal))))
        {
            DVector candidateDirection = candidate.Direction.Normalize();
            if (candidateDirection.Length <= Epsilon)
                continue;

            double denominator =
                DVector.Cross(travel, candidateDirection);
            if (Math.Abs(denominator) <= GeometryTolerance)
                continue;

            DVector delta = candidate.A - start;
            double rayTravel =
                DVector.Cross(delta, candidateDirection) /
                denominator;

            // LG-034/LG-035: un riferimento puo' essere valido anche
            // quando la sua retta/prolungamento passa esattamente per il
            // nodo corrente. In quel caso rayTravel ~= 0 non significa
            // "dietro": la costruzione convessa I+d puo' produrre un punto
            // reale DAVANTI alla distanza di rispetto.
            if (rayTravel < -GeometryTolerance)
                continue;

            if (Math.Abs(rayTravel) <= GeometryTolerance)
                rayTravel = 0.0;

            DPoint theoreticalHit =
                start + travel * rayTravel;
            bool candidatePhysicalHit =
                Distance(
                    theoreticalHit,
                    candidate.A,
                    candidate.B) <= GeometryTolerance;

            // Due segmenti successivi possono appartenere alla stessa retta
            // (per esempio i due tratti verticali separati dal raccordo di
            // ingresso). Se la loro intersezione teorica cade alla stessa
            // distanza, preferire quello realmente presente nel punto di
            // incontro: il segmento fisico richiede I-d, mentre il solo
            // prolungamento produrrebbe I+d e puo' portare fuori locale.
            if (rayTravel < bestTravel - GeometryTolerance ||
                (Math.Abs(rayTravel - bestTravel) <=
                     GeometryTolerance &&
                 candidatePhysicalHit &&
                 !bestPhysicalHit))
            {
                bestTravel = rayTravel;
                best = candidate;
                bestPhysicalHit = candidatePhysicalHit;
            }
        }

        string mode = followsOwnFamily
            ? "own-family"
            : "return-follows-supply";

        if (best is null)
        {
            LogDiego(
                $"SEQUENCE {mode} no-forward-front " +
                $"pathFamily={pathFamily} frontFamily={front.Family} " +
                $"from={front.SequenceIndex} start={Fmt(start)} " +
                $"dir={Fmt(travel)}");
            return null;
        }

        string intersectionMode =
            bestTravel <= GeometryTolerance
                ? "at-node"
                : "ahead";

        LogDiego(
            $"SEQUENCE {mode} geometric-continuation " +
            $"pathFamily={pathFamily} frontFamily={front.Family} " +
            $"from={front.SequenceIndex} next={best.Value.SequenceIndex} " +
            $"excluded={excludedSegmentId ?? "-"} " +
            $"start={Fmt(start)} dir={Fmt(travel)} " +
            $"rayTravel={Fmt(bestTravel)}m intersection={intersectionMode} " +
            $"physical={bestPhysicalHit}");
        return best;
    }

    private static List<SearchNode> ReconstructNodes(
        SearchNode node)
    {
        var stack = new Stack<SearchNode>();
        SearchNode? current = node;
        while (current is not null)
        {
            stack.Push(current);
            current = current.Parent;
        }

        return stack.ToList();
    }

    private static List<GeoSegment> ReconstructSegments(
        SearchNode node)
    {
        List<SearchNode> nodes = ReconstructNodes(node);
        var result = new List<GeoSegment>(nodes.Count);
        for (int index = 0; index < nodes.Count; index++)
        {
            result.Add(
                nodes[index].Segment with
                {
                    SequenceIndex = index
                });
        }
        return result;
    }

    private static List<DPoint> ReconstructPoints(
        SearchNode node)
    {
        List<GeoSegment> segments = ReconstructSegments(node);
        var points = new List<DPoint>();
        if (segments.Count == 0)
            return points;

        points.Add(segments[0].A);
        points.AddRange(segments.Select(segment => segment.B));
        return points;
    }

    private static List<NodeLabel> ReconstructNodeLabels(
        SearchNode node) =>
        ReconstructNodes(node)
            .Select(current => new NodeLabel(
                current.NodeId,
                current.End))
            .ToList();

    private static double ActiveSpiralLength(
        SearchNode node) =>
        ReconstructSegments(node)
            .Skip(1)
            .Sum(segment => segment.Length);

    private static int ActiveSpiralSegmentCount(
        SearchNode node) =>
        Math.Max(0, ReconstructSegments(node).Count - 1);

    private static double PolygonArea(
        IReadOnlyList<DPoint> polygon)
    {
        if (polygon.Count < 3)
            return 0;

        double twiceArea = 0;
        for (int index = 0; index < polygon.Count; index++)
        {
            DPoint current = polygon[index];
            DPoint next = polygon[(index + 1) % polygon.Count];
            twiceArea += current.X * next.Y - next.X * current.Y;
        }

        return Math.Abs(twiceArea) / 2.0;
    }

    private static double GoodnessFactor(
        double activeLength,
        double step,
        double localeArea) =>
        localeArea <= Epsilon
            ? 0
            : (2.0 * activeLength * step) / localeArea;

    private static double TerminalGoodness(
        LocaleGeometry locale,
        SearchNode node,
        double step) =>
        GoodnessFactor(
            ActiveSpiralLength(node),
            step,
            PolygonArea(locale.Perimeter));

    private static void LogTerminalGoodness(
        LocaleGeometry locale,
        GeoFamily family,
        SearchNode node,
        double step,
        string prefix)
    {
        double activeLength = ActiveSpiralLength(node);
        int activeSegments = ActiveSpiralSegmentCount(node);
        double localeArea = PolygonArea(locale.Perimeter);
        double coveredArea = 2.0 * activeLength * step;
        double factor =
            GoodnessFactor(activeLength, step, localeArea);

        LogDiego(
            $"{prefix} family={family} node={node.NodeId} " +
            $"activeSegments={activeSegments} " +
            $"activeLength={Fmt(activeLength)}m " +
            $"coveredArea={Fmt(coveredArea)}m2 " +
            $"localeArea={Fmt(localeArea)}m2 factor={Fmt(factor)}");
    }

    private static bool SegmentsEquivalent(
        GeoSegment a,
        GeoSegment b) =>
        (a.A.DistanceTo(b.A) <= GeometryTolerance &&
         a.B.DistanceTo(b.B) <= GeometryTolerance) ||
        (a.A.DistanceTo(b.B) <= GeometryTolerance &&
         a.B.DistanceTo(b.A) <= GeometryTolerance);

    private static bool SharesEndpoint(
        GeoSegment a,
        GeoSegment b) =>
        a.A.DistanceTo(b.A) <= GeometryTolerance ||
        a.A.DistanceTo(b.B) <= GeometryTolerance ||
        a.B.DistanceTo(b.A) <= GeometryTolerance ||
        a.B.DistanceTo(b.B) <= GeometryTolerance;

    private static bool SegmentsProperlyIntersect(
        GeoSegment a,
        GeoSegment b)
    {
        if (!TrySegmentIntersection(
                a.A,
                a.B,
                b.A,
                b.B,
                out _,
                out double ta,
                out double tb))
        {
            return false;
        }

        bool aEndpoint =
            ta <= GeometryTolerance ||
            ta >= 1.0 - GeometryTolerance;
        bool bEndpoint =
            tb <= GeometryTolerance ||
            tb >= 1.0 - GeometryTolerance;

        return !(aEndpoint && bEndpoint);
    }

    private static bool TrySegmentIntersection(
        DPoint a0,
        DPoint a1,
        DPoint b0,
        DPoint b1,
        out DPoint intersection,
        out double ta,
        out double tb)
    {
        intersection = default;
        ta = 0;
        tb = 0;

        DVector r = a1 - a0;
        DVector s = b1 - b0;
        double denominator = DVector.Cross(r, s);
        if (Math.Abs(denominator) <= Epsilon)
            return false;

        DVector delta = b0 - a0;
        ta = DVector.Cross(delta, s) / denominator;
        tb = DVector.Cross(delta, r) / denominator;

        if (ta < -GeometryTolerance ||
            ta > 1.0 + GeometryTolerance ||
            tb < -GeometryTolerance ||
            tb > 1.0 + GeometryTolerance)
        {
            return false;
        }

        intersection = a0 + r * ta;
        return true;
    }

    private static double SegmentDistance(
        GeoSegment a,
        GeoSegment b)
    {
        if (TrySegmentIntersection(
                a.A,
                a.B,
                b.A,
                b.B,
                out _,
                out _,
                out _))
        {
            return 0;
        }

        return Math.Min(
            Math.Min(
                Distance(a.A, b.A, b.B),
                Distance(a.B, b.A, b.B)),
            Math.Min(
                Distance(b.A, a.A, a.B),
                Distance(b.B, a.A, a.B)));
    }

    private static double Distance(
        DPoint point,
        DPoint a,
        DPoint b)
    {
        DVector ab = b - a;
        double lengthSquared = DVector.Dot(ab, ab);
        if (lengthSquared <= Epsilon)
            return point.DistanceTo(a);

        double t = DVector.Dot(point - a, ab) / lengthSquared;
        t = Math.Clamp(t, 0, 1);
        DPoint projection = a + ab * t;
        return point.DistanceTo(projection);
    }

    private static bool PointStrictlyInsidePolygon(
        DPoint point,
        IReadOnlyList<DPoint> polygon)
    {
        if (PointOnPolygonBoundary(point, polygon))
            return false;
        return PointInPolygonCore(point, polygon);
    }

    private static bool PointInOrOnPolygon(
        DPoint point,
        IReadOnlyList<DPoint> polygon) =>
        PointOnPolygonBoundary(point, polygon) ||
        PointInPolygonCore(point, polygon);

    private static bool PointOnPolygonBoundary(
        DPoint point,
        IReadOnlyList<DPoint> polygon)
    {
        for (int i = 0; i < polygon.Count; i++)
        {
            if (Distance(
                    point,
                    polygon[i],
                    polygon[(i + 1) % polygon.Count]) <= GeometryTolerance)
            {
                return true;
            }
        }
        return false;
    }

    private static bool PointInPolygonCore(
        DPoint point,
        IReadOnlyList<DPoint> polygon)
    {
        bool inside = false;
        for (int i = 0, j = polygon.Count - 1;
             i < polygon.Count;
             j = i++)
        {
            DPoint pi = polygon[i];
            DPoint pj = polygon[j];

            bool intersects =
                ((pi.Y > point.Y) != (pj.Y > point.Y)) &&
                point.X <
                (pj.X - pi.X) *
                (point.Y - pi.Y) /
                ((pj.Y - pi.Y) + double.Epsilon) +
                pi.X;

            if (intersects)
                inside = !inside;
        }

        return inside;
    }

    private static string WriteSvg(
        IReadOnlyList<LocaleSolution> solutions,
        StrategiaDiegoMetrics metrics,
        bool numberSpiralNodes)
    {
        IEnumerable<DPoint> allPoints = solutions
            .SelectMany(solution =>
                solution.SupplyPoints.Concat(solution.ReturnPoints));

        double minX = allPoints.Min(point => point.X) - 0.25;
        double minY = allPoints.Min(point => point.Y) - 0.25;
        double maxX = allPoints.Max(point => point.X) + 0.25;
        double maxY = allPoints.Max(point => point.Y) + 0.25;

        var builder = new StringBuilder();
        builder.AppendLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        builder.AppendLine(
            string.Create(
                CultureInfo.InvariantCulture,
                $"<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"{minX} {minY} {maxX - minX} {maxY - minY}\" data-termodel-engine=\"Diego\" data-diego-nodes=\"{metrics.TotalNodes}\">"));

        foreach (LocaleSolution solution in solutions)
        {
            AppendPolyline(
                builder,
                solution.SupplyPoints,
                "red",
                solution.Locale.Id,
                "mandata");

            AppendPolyline(
                builder,
                solution.ReturnPoints,
                "blue",
                solution.Locale.Id,
                "ritorno");

            if (numberSpiralNodes)
            {
                AppendNodeLabels(
                    builder,
                    solution.SupplyNodeLabels,
                    solution.Locale.Id,
                    "mandata");
                AppendNodeLabels(
                    builder,
                    solution.ReturnNodeLabels,
                    solution.Locale.Id,
                    "ritorno");
            }
        }

        builder.AppendLine("</svg>");
        return builder.ToString();
    }

    private static void AppendPolyline(
        StringBuilder builder,
        IReadOnlyList<DPoint> points,
        string stroke,
        string localeId,
        string role)
    {
        builder.Append(
            $"<polyline data-termodel-engine=\"Diego\" data-locale=\"{Escape(localeId)}\" " +
            $"data-role=\"{role}\" fill=\"none\" stroke=\"{stroke}\" stroke-width=\"0.015\" points=\"");

        foreach (DPoint point in points)
        {
            builder.Append(
                point.X.ToString("0.######", CultureInfo.InvariantCulture));
            builder.Append(',');
            builder.Append(
                point.Y.ToString("0.######", CultureInfo.InvariantCulture));
            builder.Append(' ');
        }

        builder.AppendLine("\"/>");
    }

    private static void AppendNodeLabels(
        StringBuilder builder,
        IReadOnlyList<NodeLabel> labels,
        string localeId,
        string role)
    {
        foreach (NodeLabel label in labels)
        {
            string x =
                label.Point.X.ToString("0.######", CultureInfo.InvariantCulture);
            string y =
                label.Point.Y.ToString("0.######", CultureInfo.InvariantCulture);

            builder.AppendLine(
                $"<text data-termodel=\"spirale-node\" " +
                $"data-locale=\"{Escape(localeId)}\" data-role=\"{role}\" " +
                $"data-node-id=\"{label.NodeId}\" " +
                $"data-x=\"{x}\" data-y=\"{y}\" data-altezza=\"0.08\" " +
                $"x=\"{x}\" y=\"{y}\" font-size=\"0.08\" " +
                $"text-anchor=\"middle\" fill=\"#660066\">" +
                $"{label.NodeId}</text>");
        }
    }

    private static string Escape(string value) =>
        System.Security.SecurityElement.Escape(value) ?? string.Empty;

    private static void LogDiego(string message)
    {
        if (!TermodelLog.IsEnabled(TermodelLog.LogCategory.SpiraliDiego))
            return;

        TermodelLog.WriteLog(
            "[SpiraliDiego] " + message,
            TermodelLog.LogCategory.SpiraliDiego);
    }

    private static string Fmt(double value) =>
        value.ToString("0.###", CultureInfo.InvariantCulture);

    private static string Fmt(DPoint point) =>
        $"({Fmt(point.X)},{Fmt(point.Y)})";

    private static string Fmt(DVector vector) =>
        $"({Fmt(vector.X)},{Fmt(vector.Y)})";

    private static int ReadPositiveEnvironmentInt(
        string name,
        int fallback)
    {
        string? raw = Environment.GetEnvironmentVariable(name);
        return int.TryParse(
                   raw,
                   NumberStyles.Integer,
                   CultureInfo.InvariantCulture,
                   out int value) &&
               value > 0
            ? value
            : fallback;
    }

    private sealed class SearchCounters
    {
        private int _localeSupplyNodes;
        private int _localeSupplyTerminals;
        private int _localeReturnNodes;
        private int _localeCombinedTerminals;
        private int _localeAcceptedTerminals;
        private int _localeMaxDepth;

        public SearchCounters(int maxNodes, int maxDepth)
        {
            MaxNodes = maxNodes;
            MaxDepth = maxDepth;
        }

        public int SupplyNodes { get; private set; }
        public int SupplyTerminals { get; private set; }
        public int ReturnNodes { get; private set; }
        public int CombinedTerminals { get; set; }
        public int AcceptedTerminals { get; set; }
        public int MaxObservedDepth { get; private set; }
        public int MaxNodes { get; }
        public int MaxDepth { get; }
        public int TotalNodes => SupplyNodes + ReturnNodes;

        private int _nodeSerial;

        public int AddNode(bool supply, int depth)
        {
            if (TotalNodes >= MaxNodes)
            {
                throw new InvalidOperationException(
                    $"StrategiaDiego: superato limite tecnico di {MaxNodes} nodi. " +
                    "Ricerca interrotta senza scegliere una soluzione parziale.");
            }

            if (supply)
            {
                SupplyNodes++;
                _localeSupplyNodes++;
            }
            else
            {
                ReturnNodes++;
                _localeReturnNodes++;
            }

            MaxObservedDepth = Math.Max(MaxObservedDepth, depth);
            _localeMaxDepth = Math.Max(_localeMaxDepth, depth);
            _nodeSerial++;
            return _nodeSerial;
        }

        public void AddTerminal(bool supply)
        {
            if (supply)
            {
                SupplyTerminals++;
                _localeSupplyTerminals++;
            }
        }

        public LocaleMetrics SnapshotLocale()
        {
            int combinedDelta = CombinedTerminals - _localeCombinedTerminals;
            int acceptedDelta = AcceptedTerminals - _localeAcceptedTerminals;

            var result = new LocaleMetrics(
                _localeSupplyNodes,
                _localeSupplyTerminals,
                _localeReturnNodes,
                combinedDelta,
                acceptedDelta,
                _localeMaxDepth);

            _localeSupplyNodes = 0;
            _localeSupplyTerminals = 0;
            _localeReturnNodes = 0;
            _localeCombinedTerminals = CombinedTerminals;
            _localeAcceptedTerminals = AcceptedTerminals;
            _localeMaxDepth = 0;
            return result;
        }
    }

    private sealed record LocaleGeometry(
        string Id,
        IReadOnlyList<DPoint> Perimeter);

    private sealed record InputLine(
        string Id,
        DPoint P0,
        DPoint P1);

    private sealed record DirectedConnection(
        string Id,
        DPoint Outside,
        DPoint Inside,
        DPoint EntryPoint,
        DVector Direction,
        GeoSegment EntryWall);

    private sealed record ReturnRoot(
        string Side,
        DPoint EntryPoint);

    private sealed record ExtensionResult(
        GeoSegment Segment,
        GeoSegment Front);

    private sealed record SearchTree(
        IReadOnlyList<SearchNode> Terminals);

    private sealed class SearchNode
    {
        public SearchNode(
            SearchNode? parent,
            GeoSegment segment,
            GeoSegment front,
            DVector direction,
            int depth,
            double lengthMeters,
            int nodeId)
        {
            Parent = parent;
            Segment = segment;
            Front = front;
            Direction = direction.Normalize();
            Depth = depth;
            LengthMeters = lengthMeters;
            NodeId = nodeId;
        }

        public SearchNode? Parent { get; }
        public GeoSegment Segment { get; }
        public GeoSegment Front { get; }
        public DVector Direction { get; }
        public int Depth { get; }
        public double LengthMeters { get; }
        public int NodeId { get; }
        public DPoint End => Segment.B;
    }

    private sealed record CombinedCandidate(
        SearchNode SupplyTerminal,
        SearchNode ReturnTerminal,
        ReturnRoot ReturnRoot,
        GeoSegment Closure,
        double MeritMeters);

    private sealed record LocaleSolution(
        LocaleGeometry Locale,
        IReadOnlyList<DPoint> SupplyPoints,
        IReadOnlyList<DPoint> ReturnPoints,
        IReadOnlyList<NodeLabel> SupplyNodeLabels,
        IReadOnlyList<NodeLabel> ReturnNodeLabels,
        ReturnRoot ReturnRoot,
        double MeritMeters,
        LocaleMetrics Metrics,
        double SupplyActiveLengthMeters,
        double ReturnActiveLengthMeters,
        double SupplyGoodness,
        double ReturnGoodness);

    private sealed record NodeLabel(
        int NodeId,
        DPoint Point);

    private sealed record LocaleMetrics(
        int SupplyNodes,
        int SupplyTerminals,
        int ReturnNodes,
        int CombinedTerminals,
        int AcceptedTerminals,
        int MaxDepth);

    private enum GeoFamily
    {
        Architecture,
        Connection,
        ReturnConnection,
        Supply,
        Return
    }

    private readonly record struct GeoSegment(
        string Id,
        DPoint A,
        DPoint B,
        GeoFamily Family,
        int SequenceIndex)
    {
        public DVector Direction => B - A;
        public double Length => A.DistanceTo(B);
    }

    private readonly record struct DPoint(
        double X,
        double Y)
    {
        public double DistanceTo(DPoint other)
        {
            double dx = X - other.X;
            double dy = Y - other.Y;
            return Math.Sqrt(dx * dx + dy * dy);
        }

        public static DPoint Lerp(
            DPoint a,
            DPoint b,
            double t) =>
            new(
                a.X + (b.X - a.X) * t,
                a.Y + (b.Y - a.Y) * t);

        public static DVector operator -(
            DPoint a,
            DPoint b) =>
            new(a.X - b.X, a.Y - b.Y);

        public static DPoint operator +(
            DPoint point,
            DVector vector) =>
            new(point.X + vector.X, point.Y + vector.Y);
    }

    private readonly record struct DVector(
        double X,
        double Y)
    {
        public double Length => Math.Sqrt(X * X + Y * Y);

        public DVector Normalize()
        {
            double length = Length;
            return length <= Epsilon
                ? new DVector(0, 0)
                : new DVector(X / length, Y / length);
        }

        public static double Dot(DVector a, DVector b) =>
            a.X * b.X + a.Y * b.Y;

        public static double Cross(DVector a, DVector b) =>
            a.X * b.Y - a.Y * b.X;

        public static DVector operator -(
            DVector vector) =>
            new(-vector.X, -vector.Y);

        public static DVector operator /(
            DVector vector,
            double divisor) =>
            new(vector.X / divisor, vector.Y / divisor);

        public static DVector operator *(
            DVector vector,
            double factor) =>
            new(vector.X * factor, vector.Y * factor);
    }
}

internal sealed record StrategiaDiegoResult(
    string Svg,
    double StepMeters,
    IReadOnlyList<string> Diagnostics,
    StrategiaDiegoMetrics Metrics);

internal sealed record StrategiaDiegoMetrics(
    int SupplyNodes,
    int SupplyTerminals,
    int ReturnNodes,
    int CombinedTerminals,
    int AcceptedTerminals,
    int MaxDepth,
    long ElapsedMilliseconds,
    long MemoryDeltaBytes,
    int TotalNodes,
    int MaxNodes,
    int MaxDepthLimit);
