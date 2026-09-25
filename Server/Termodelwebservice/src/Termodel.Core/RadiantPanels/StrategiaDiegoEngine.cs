using System.Diagnostics;
using System.Globalization;
using System.Text;
using System.Xml.Linq;

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

        foreach (XElement localeElement in floorInput.Descendants("Locale"))
        {
            LocaleGeometry? locale = ParseLocale(localeElement);
            if (locale is null)
                continue;

            InputLine? connection = FindConnection(locale, connections);
            if (connection is null)
            {
                diagnostics.Add(
                    $"Diego/{locale.Id}: nessun tubo di collegamento entrante.");
                continue;
            }

            LocaleSolution solution = GenerateLocale(
                locale,
                connection,
                stepMeters,
                counters);
            solutions.Add(solution);

            diagnostics.Add(
                $"Diego/{locale.Id}: supplyNodes={solution.Metrics.SupplyNodes}, " +
                $"supplyTerminals={solution.Metrics.SupplyTerminals}, " +
                $"returnNodes={solution.Metrics.ReturnNodes}, " +
                $"combinedTerminals={solution.Metrics.CombinedTerminals}, " +
                $"accepted={solution.Metrics.AcceptedTerminals}, " +
                $"maxDepth={solution.Metrics.MaxDepth}, " +
                $"merit={solution.MeritMeters.ToString("0.###", CultureInfo.InvariantCulture)} m.");
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
        double step,
        SearchCounters counters)
    {
        DirectedConnection directed = DirectConnection(locale, connection);

        IReadOnlyList<GeoSegment> architecture =
            BuildArchitecture(locale);

        SearchTree supplyTree = BuildTree(
            locale,
            GeoFamily.Supply,
            directed.EntryPoint,
            directed.Direction,
            architecture,
            Array.Empty<GeoSegment>(),
            step,
            counters,
            countAsSupply: true);

        if (supplyTree.Terminals.Count == 0)
        {
            throw new InvalidDataException(
                $"StrategiaDiego/{locale.Id}: nessun terminale mandata.");
        }

        List<ReturnRoot> returnRoots = BuildReturnRoots(
            locale,
            directed,
            step);

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
                    supplySegments,
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
                        continue;
                    }

                    counters.AcceptedTerminals++;

                    double merit =
                        supplyTerminal.LengthMeters +
                        returnTerminal.LengthMeters +
                        closure.Length;

                    if (best is null || merit > best.MeritMeters + Epsilon)
                    {
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
        IReadOnlyList<GeoSegment> fixedPath,
        double step,
        SearchCounters counters,
        bool countAsSupply)
    {
        var terminals = new List<SearchNode>();
        var stack = new Stack<SearchNode>();

        List<GeoSegment> initialConstraints =
            CombineConstraints(architecture, fixedPath, Array.Empty<GeoSegment>());

        ExtensionResult? first = TryExtend(
            locale,
            family,
            start,
            initialDirection,
            initialConstraints,
            previousSegment: null,
            excludedFrontId: null,
            step,
            allowStartOnBoundary: true);

        if (first is null)
            return new SearchTree(terminals);

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
                CombineConstraints(architecture, fixedPath, currentPath);

            var directions = new List<(string Name, DVector Direction, string? ExcludedFrontId)>
            {
                ("PROSEGUI_DRITTO", node.Direction, node.Front.Id)
            };

            DVector parallel = node.Front.Direction.Normalize();
            directions.Add(("PARALLELA_A", parallel, null));
            directions.Add(("PARALLELA_B", -parallel, null));

            var children = new List<SearchNode>();
            foreach ((string _, DVector direction, string? excludedFront) in directions)
            {
                ExtensionResult? extension = TryExtend(
                    locale,
                    family,
                    node.End,
                    direction,
                    constraints,
                    node.Segment,
                    excludedFront,
                    step,
                    allowStartOnBoundary: false);

                if (extension is null)
                    continue;

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
                continue;
            }

            foreach (SearchNode child in children)
                stack.Push(child);
        }

        return new SearchTree(terminals);
    }

    private static ExtensionResult? TryExtend(
        LocaleGeometry locale,
        GeoFamily family,
        DPoint start,
        DVector direction,
        IReadOnlyList<GeoSegment> constraints,
        GeoSegment? previousSegment,
        string? excludedFrontId,
        double step,
        bool allowStartOnBoundary)
    {
        DVector unit = direction.Normalize();
        if (unit.Length <= Epsilon)
            return null;

        ExtensionResult? best = null;

        foreach (GeoSegment reference in constraints)
        {
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
                return false;

            double required = RequiredDistance(
                candidate.Family,
                other.Family,
                step);

            double distance = SegmentDistance(candidate, other);

            if (isFront)
            {
                if (distance < required - GeometryTolerance)
                    return false;
                continue;
            }

            if (distance < required - GeometryTolerance)
                return false;
        }

        return true;
    }

    private static bool SegmentInsideLocale(
        LocaleGeometry locale,
        GeoSegment segment,
        bool allowStartOnBoundary)
    {
        const int Samples = 24;
        for (int i = 0; i <= Samples; i++)
        {
            if (i == 0 && allowStartOnBoundary)
                continue;

            double t = (double)i / Samples;
            DPoint point = DPoint.Lerp(segment.A, segment.B, t);
            if (!PointInOrOnPolygon(point, locale.Perimeter))
                return false;
        }
        return true;
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
                return false;
        }
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

            if (p0Inside != p1Inside)
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

    private static double RequiredDistance(
        GeoFamily newFamily,
        GeoFamily referenceFamily,
        double step) =>
        referenceFamily switch
        {
            GeoFamily.Architecture => step / 2.0,
            _ when newFamily == referenceFamily => step * 2.0,
            _ => step
        };

    private static List<GeoSegment> CombineConstraints(
        IReadOnlyList<GeoSegment> architecture,
        IReadOnlyList<GeoSegment> fixedPath,
        IReadOnlyList<GeoSegment> currentPath)
    {
        var result = new List<GeoSegment>(
            architecture.Count + fixedPath.Count + currentPath.Count);
        result.AddRange(architecture);
        result.AddRange(fixedPath);
        result.AddRange(currentPath);
        return result;
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
                $"<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"{minX} {minY} {maxX - minX} {maxY - minY}\" data-termodel-engine=\"Diego\" data-diego-nodes=\"{metrics.TotalNodes}\" data-diego-elapsed-ms=\"{metrics.ElapsedMilliseconds}\">"));

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
