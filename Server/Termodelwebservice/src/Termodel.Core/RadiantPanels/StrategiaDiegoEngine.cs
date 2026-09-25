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
    private const double ReturnConnectionOffsetMeters = 0.50;
    private const double Epsilon = 1e-7;
    private const double GeometryTolerance = 1e-5;
    private const int DefaultMaxNodes = 250_000;
    private const int DefaultMaxDepth = 128;

    public static StrategiaDiegoResult Generate(
        XDocument floorInput,
        double stepMeters = DefaultStepMeters)
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
                $"merit={solution.MeritMeters.ToString("0.###", CultureInfo.InvariantCulture)} m.");

            LogDiego(
                $"LOCALE {locale.Id} SELECT merit={Fmt(solution.MeritMeters)}m " +
                $"supplyPoints={solution.SupplyPoints.Count} " +
                $"returnPoints={solution.ReturnPoints.Count} " +
                $"returnRoot={solution.ReturnRoot.Side}");
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
            WriteSvg(solutions, metrics),
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
        // La rete di mandata fornita dall'utente resta geometria vincolante
        // durante il tracciamento; il collegamento assegnato al locale
        // definisce invece il proprio varco.
        IReadOnlyList<GeoSegment> connectionConstraints =
            BuildConnectionConstraints(connections, connection.Id);

        // LG-024/LG-028: la mandata va esplorata senza potatura predittiva
        // basata sul futuro ritorno. Ogni suo terminale viene poi proseguito
        // con il proprio albero dei ritorni.
        SearchTree supplyTree = BuildTree(
            locale,
            GeoFamily.Supply,
            directed.EntryPoint,
            directed.Direction,
            architecture,
            connectionConstraints,
            Array.Empty<GeoSegment>(),
            directed.EntryWall,
            step,
            counters,
            countAsSupply: true);

        LogDiego(
            $"LOCALE {locale.Id} SUPPLY tree terminals={supplyTree.Terminals.Count}");

        if (supplyTree.Terminals.Count == 0)
        {
            throw new InvalidDataException(
                $"StrategiaDiego/{locale.Id}: nessun terminale mandata.");
        }

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

        foreach (SearchNode supplyTerminal in supplyTree.Terminals)
        {
            List<GeoSegment> supplySegments =
                ReconstructSegments(supplyTerminal);

            foreach (ReturnRoot returnRoot in returnRoots)
            {
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
                    countAsSupply: false);

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
                            $"supplyDepth={supplyTerminal.Depth} returnDepth={returnTerminal.Depth} " +
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

        return new LocaleSolution(
            locale,
            ReconstructPoints(best.SupplyTerminal),
            ReconstructPoints(best.ReturnTerminal)
                .Append(best.Closure.B)
                .ToList(),
            best.ReturnRoot,
            best.MeritMeters,
            counters.SnapshotLocale());
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
        bool countAsSupply)
    {
        var terminals = new List<SearchNode>();
        var stack = new Stack<SearchNode>();

        List<GeoSegment> initialConstraints =
            CombineConstraints(
                architecture,
                connectionConstraints,
                fixedPath,
                Array.Empty<GeoSegment>());

        ExtensionResult? first = TryBuildInitialSegment(
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

        LogDiego(
            $"TREE {family} initial ACCEPT {Fmt(first.Segment.A)}->{Fmt(first.Segment.B)} " +
            $"front={first.Front.Id}");

        SearchNode root = new(
            parent: null,
            segment: first.Segment,
            front: first.Front,
            direction: initialDirection,
            depth: 1,
            lengthMeters: first.Segment.Length);

        counters.AddNode(countAsSupply, root.Depth);
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
                $"TREE {family} NODE depth={node.Depth} end={Fmt(node.End)} " +
                $"dir={Fmt(node.Direction)} front={node.Front.Id} " +
                $"pathLen={Fmt(node.LengthMeters)}m");

            var directions = new List<(
                string Name,
                DVector Direction,
                string? ExcludedFrontId,
                string? RequiredFrontId)>();

            // Il segmento iniziale e' soltanto il raccordo ingresso -> maglia.
            // Non puo' diventare la prima traccia utile proseguendo diritto,
            // altrimenti la quota dell'ingresso determina direttamente una
            // linea della spirale. Dal seed iniziale si entra nella maglia
            // esclusivamente girando paralleli alla parete di ingresso.
            if (node.Depth > 1)
            {
                directions.Add(
                    ("PROSEGUI_DRITTO", node.Direction, node.Front.Id, null));
            }
            else
            {
                LogDiego(
                    $"TREE {family} INITIAL-CONNECTOR suppress-straight " +
                    $"at={Fmt(node.End)}; first-useful-trace=parallel-to-entry-wall");
            }

            DVector parallel = node.Front.Direction.Normalize();
            GeoSegment? continuationA =
                FindSequenceContinuation(
                    node.End,
                    node.Front,
                    constraints,
                    family,
                    parallel);
            GeoSegment? continuationB =
                FindSequenceContinuation(
                    node.End,
                    node.Front,
                    constraints,
                    family,
                    -parallel);

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
                    allowStartOnBoundary: false);

                if (extension is null)
                {
                    LogDiego(
                        $"TREE {family} CHOICE {choiceName} REJECT start={Fmt(node.End)} " +
                        $"dir={Fmt(direction)} requiredFront={requiredFront ?? "-"}");
                    continue;
                }

                LogDiego(
                    $"TREE {family} CHOICE {choiceName} ACCEPT " +
                    $"{Fmt(extension.Segment.A)}->{Fmt(extension.Segment.B)} " +
                    $"front={extension.Front.Id}");

                if (children.Any(existing =>
                    SegmentsEquivalent(existing.Segment, extension.Segment)))
                {
                    continue;
                }

                SearchNode child = new(
                    node,
                    extension.Segment,
                    extension.Front,
                    direction,
                    node.Depth + 1,
                    node.LengthMeters + extension.Segment.Length);

                counters.AddNode(countAsSupply, child.Depth);
                children.Add(child);
            }

            if (children.Count == 0)
            {
                terminals.Add(node);
                counters.AddTerminal(countAsSupply);
                LogDiego(
                    $"TREE {family} TERMINAL depth={node.Depth} end={Fmt(node.End)} " +
                    $"length={Fmt(node.LengthMeters)}m");
                continue;
            }

            foreach (SearchNode child in children)
                stack.Push(child);
        }

        return new SearchTree(terminals);
    }

    private static ExtensionResult? TryBuildInitialSegment(
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
            $"INITIAL-SEED {family} entry={Fmt(start)} entryDir={Fmt(unit)} " +
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
                $"INITIAL-SEED {family} REJECT candidate={Fmt(candidate.A)}->{Fmt(candidate.B)}");
            return null;
        }

        LogDiego(
            $"INITIAL-SEED {family} ACCEPT candidate={Fmt(candidate.A)}->{Fmt(candidate.B)} " +
            $"note=entry-to-offset-segment");
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
        bool allowStartOnBoundary)
    {
        DVector unit = direction.Normalize();
        if (unit.Length <= Epsilon)
            return null;

        ExtensionResult? best = null;

        foreach (GeoSegment reference in constraints)
        {
            // Modificato da Codex per realizzare: i tubi di collegamento sono
            // ostacoli fisici, non linee strategiche sulle quali svoltare.
            if (reference.Family == GeoFamily.Connection)
                continue;

            if (requiredFrontId is not null &&
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
            if (tIntersection <= Epsilon)
                continue;

            double uReference =
                DVector.Cross(delta, unit) /
                DVector.Cross(unit, refDirection);

            bool physicalHit =
                uReference >= -GeometryTolerance &&
                uReference <= 1.0 + GeometryTolerance;

            // Le estensioni architettoniche non sono ostacoli fisici.
            // Le estensioni dei tubi possono invece essere marcatori strategici
            // per l'inseguimento convesso (LG-033..LG-035).
            if (!physicalHit && reference.Family == GeoFamily.Architecture)
                continue;

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
                    allowStartOnBoundary))
            {
                continue;
            }

            if (best is null ||
                candidate.Length < best.Segment.Length - GeometryTolerance)
            {
                best = new ExtensionResult(candidate, reference);
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
        bool allowStartOnBoundary)
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
                tangent * (ReturnConnectionOffsetMeters * sign);

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
        double step) =>
        referenceFamily switch
        {
            GeoFamily.Architecture => step / 2.0,
            // Modificato da Codex per realizzare: la rete di collegamento e'
            // un ostacolo anti-attraversamento; le distanze LG-006 restano
            // definite fra architettura, mandata e ritorno interni.
            GeoFamily.Connection => 0.0,
            _ when newFamily == referenceFamily => step * 2.0,
            _ => step
        };

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
        DVector travelDirection)
    {
        if (front.Family == GeoFamily.Architecture ||
            front.SequenceIndex < 0)
        {
            return null;
        }

        // Per i casi diversi dal ritorno che insegue la mandata conserva la
        // semantica storica: il successore e' SequenceIndex+1.
        if (pathFamily != GeoFamily.Return ||
            front.Family != GeoFamily.Supply)
        {
            return constraints.FirstOrDefault(candidate =>
                candidate.Family == front.Family &&
                candidate.SequenceIndex == front.SequenceIndex + 1);
        }

        DVector travel = travelDirection.Normalize();
        if (travel.Length <= Epsilon)
            return null;

        // Il ritorno e' una curva parallela alla mandata: la prossima svolta
        // non si deduce dal verso A->B del segmento di mandata, perche' il
        // ritorno puo' trovarsi sul suo prolungamento. Si sceglie quindi il
        // primo segmento della stessa mandata la cui retta viene incontrata
        // DAVANTI lungo la direzione corrente. Questo realizza l'inseguimento
        // geometrico della traccia invece di forzare +1/-1 dall'orientamento.
        GeoSegment? best = null;
        double bestTravel = double.PositiveInfinity;

        foreach (GeoSegment candidate in constraints.Where(candidate =>
                     candidate.Family == GeoFamily.Supply &&
                     candidate.SequenceIndex >= 0 &&
                     candidate.SequenceIndex != front.SequenceIndex))
        {
            DVector candidateDirection = candidate.Direction.Normalize();
            if (candidateDirection.Length <= Epsilon)
                continue;

            double denominator = DVector.Cross(travel, candidateDirection);
            if (Math.Abs(denominator) <= GeometryTolerance)
                continue;

            DVector delta = candidate.A - start;
            double rayTravel =
                DVector.Cross(delta, candidateDirection) / denominator;

            if (rayTravel <= GeometryTolerance)
                continue;

            if (rayTravel < bestTravel - GeometryTolerance)
            {
                bestTravel = rayTravel;
                best = candidate;
            }
        }

        if (best is null)
        {
            LogDiego(
                $"SEQUENCE return-follows-supply no-forward-front " +
                $"from={front.SequenceIndex} start={Fmt(start)} dir={Fmt(travel)}");
            return null;
        }

        LogDiego(
            $"SEQUENCE return-follows-supply geometric-continuation " +
            $"from={front.SequenceIndex} next={best.Value.SequenceIndex} " +
            $"start={Fmt(start)} dir={Fmt(travel)} rayTravel={Fmt(bestTravel)}m");
        return best;
    }

    private static List<GeoSegment> ReconstructSegments(SearchNode node)
    {
        var stack = new Stack<GeoSegment>();
        SearchNode? current = node;
        while (current is not null)
        {
            stack.Push(current.Segment);
            current = current.Parent;
        }

        var result = new List<GeoSegment>(stack.Count);
        int index = 0;
        while (stack.Count > 0)
        {
            GeoSegment segment = stack.Pop();
            result.Add(segment with { SequenceIndex = index++ });
        }
        return result;
    }

    private static List<DPoint> ReconstructPoints(SearchNode node)
    {
        List<GeoSegment> segments = ReconstructSegments(node);
        var points = new List<DPoint>();
        if (segments.Count == 0)
            return points;

        points.Add(segments[0].A);
        points.AddRange(segments.Select(segment => segment.B));
        return points;
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
        StrategiaDiegoMetrics metrics)
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

        public void AddNode(bool supply, int depth)
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
            double lengthMeters)
        {
            Parent = parent;
            Segment = segment;
            Front = front;
            Direction = direction.Normalize();
            Depth = depth;
            LengthMeters = lengthMeters;
        }

        public SearchNode? Parent { get; }
        public GeoSegment Segment { get; }
        public GeoSegment Front { get; }
        public DVector Direction { get; }
        public int Depth { get; }
        public double LengthMeters { get; }
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
        ReturnRoot ReturnRoot,
        double MeritMeters,
        LocaleMetrics Metrics);

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
