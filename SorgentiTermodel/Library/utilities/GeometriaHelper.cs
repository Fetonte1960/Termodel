using NetTopologySuite.Algorithm;
using NetTopologySuite.Geometries;
using System.Collections.Generic;
using Termodel.Leggidxf;
using Termodel.utilities;
using NetTopologySuite.Geometries;
using System.Globalization;

public static class GeometriaHelper
{
    public static DXFLineCheck Lines2DCor;
    // Classe Line per rappresentare un segmento di linea con inizio e fine
    public class Line
    {
        public Coordinate Start { get; set; }
        public Coordinate End { get; set; }

        // Costruttore che accetta due coordinate
        public Line(Coordinate start, Coordinate end)
        {
            Start = start;
            End = end;
        }
    }
    public static List<LineString> NtsPolyToLinestring(Geometry polygonizerGeometry)
    {
        var lines = new List<LineString>();

        // Se la geometry è nulla, restituisci subito lista vuota
        if (polygonizerGeometry == null)
            return lines;

        // Estraiamo i LineString ricorsivamente
        lines.AddRange(ExtractLineStrings(polygonizerGeometry));

        return lines;
    }

    /// <summary>
    /// Funzione ricorsiva che estrae tutti i LineString (o LinearRing)
    /// da qualunque Geometry (Polygon, MultiPolygon, GeometryCollection, ecc.).
    /// </summary>
    private static List<LineString> ExtractLineStrings(Geometry geometry)
    {
        var result = new List<LineString>();

        if (geometry is null)
            return result;

        // CASO 1: GeometryCollection (es. MultiPolygon, MultiLineString, ecc.)
        if (geometry is GeometryCollection gc)
        {
            for (int i = 0; i < gc.NumGeometries; i++)
            {
                var geomN = gc.GetGeometryN(i);
                result.AddRange(ExtractLineStrings(geomN));
            }
        }
        // CASO 2: Polygon (estraiamo anello esterno + anelli interni)
        else if (geometry is Polygon poly)
        {
            // Anello esterno
            if (poly.ExteriorRing is LineString extRing)
                result.Add(extRing);

            // Anelli interni (buchi)
            for (int j = 0; j < poly.NumInteriorRings; j++)
            {
                var intRing = poly.GetInteriorRingN(j);
                if (intRing is LineString lsHole)
                    result.Add(lsHole);
            }
        }
        // CASO 3: LineString semplice
        else if (geometry is LineString ls)
        {
            result.Add(ls);
        }
        // Altri casi (Point, ecc.) non estraggono linee.

        return result;
    }
    public static bool IsOrto(Line linea)
    {
        // Calcola la variazione tra le coordinate x e y del punto iniziale e finale
        double deltaX = Math.Abs(linea.Start.X - linea.End.X);
        double deltaY = Math.Abs(linea.Start.Y - linea.End.Y);

        // Se una delle variazioni è minore o uguale alla tolleranza, la linea è ortogonale
        double tolleranza = 0.001;
        return deltaX <= tolleranza || deltaY <= tolleranza;
    }
    public static string logLinea(Coordinate start, Coordinate end)
    {
        // Determina se la linea è ortogonale
        bool ortogonale = IsOrto(new Line(start, end));
        string stato = ortogonale ? "Ortogonale" : "Non ortogonale";

        // Crea una stringa di log con lo stato e le coordinate della linea, formattate a due decimali
        return $"{stato}: Start({start.X:F2}, {start.Y:F2}) - End({end.X:F2}, {end.Y:F2})";
    }

    public static Polygon ParalleloPoligono(Polygon poligono, bool esterno)
    {
        // Lista per le linee spostate
        List<Line> lineeSpostate = new List<Line>();

        // Ottieni le coordinate dell'exterior ring del poligono
        var exteriorCoordinates = poligono.ExteriorRing.Coordinates;

        // Sposta ogni lato del poligono
        for (int i = 0; i < exteriorCoordinates.Length - 1; i++)
        {
            var start = exteriorCoordinates[i];
            var end = exteriorCoordinates[i + 1];
            var logorig = logLinea(start, end);
            // Ogni lato ha un proprio userdata che determina lo spessore
            
            var coordinatesToSearch = new List<Coordinate> { start, end }; 
            double spessore= Lines2DCor.SpessoreParete(coordinatesToSearch);
            if (spessore == double.NaN) spessore = 0.5;
            

            // Determina la distanza per lo spostamento (positiva per esterno, negativa per interno)
            double distanza = esterno ? spessore : -spessore;

            // Calcola il vettore perpendicolare per spostare il lato
            var dx = end.Y - start.Y;
            var dy = start.X - end.X;
            var length = System.Math.Sqrt(dx * dx + dy * dy);

            // Calcola l'offset perpendicolare per spostare la linea
            var offsetX = (dx / length) * distanza;
            var offsetY = (dy / length) * distanza;

            // Crea nuove coordinate per il lato spostato
            var nuovoStart = new Coordinate(start.X + offsetX, start.Y + offsetY);
            var nuovoEnd = new Coordinate(end.X + offsetX, end.Y + offsetY);
            var lognuovo = logLinea(nuovoStart, nuovoEnd);
            // Log dell'offset e delle nuove coordinate per ogni lato
            TermodelLog.WriteLog($"Lato {i + 1}: {logorig})");
            TermodelLog.WriteLog($"OffsetX: {offsetX}, OffsetY: {offsetY}, Distanza: {distanza}");
            TermodelLog.WriteLog($"Nuovo Lato {i + 1}:{lognuovo})");

            // Aggiungi la linea spostata alla lista
            lineeSpostate.Add(new Line(nuovoStart, nuovoEnd));
        }

        // Lista per le linee raccordate
        List<Coordinate> coordinateRaccordate = new List<Coordinate>();

        // Raccorda le linee spostate
        for (int i = 0; i < lineeSpostate.Count; i++)
        {
            var lineaCorrente = lineeSpostate[i];
            var lineaSuccessiva = lineeSpostate[(i + 1) % lineeSpostate.Count];

            // Raccorda le linee e ottieni le linee raccordate
            var (raccordataCorrente, raccordataSuccessiva) = RaccordaLinee(lineaCorrente, lineaSuccessiva);

            var logCorrente = logLinea(raccordataCorrente.Start, raccordataCorrente.End);
            var logSuccessiva = logLinea(raccordataSuccessiva.Start, raccordataSuccessiva.End);
            // Log delle linee raccordate
            //TermodelLog.WriteLog($"Raccordo tra Linea {i+1} e Linea {(i + 1) % lineeSpostate.Count+1}");
            //TermodelLog.WriteLog($"RaccordataCorrente:{logCorrente} )");
            //TermodelLog.WriteLog($"RaccordataSuccessiva:{logSuccessiva} )");

            // Aggiungi il punto iniziale della linea raccordata alla lista di coordinate
            coordinateRaccordate.Add(raccordataCorrente.End);
        }

        // Chiudi il poligono aggiungendo il primo punto alla fine
        coordinateRaccordate.Add(coordinateRaccordate[0]);

        // Log per verificare la chiusura del poligono
        //TermodelLog.WriteLog("Verifica della chiusura del poligono:");
        foreach (var coord in coordinateRaccordate)
        {
            //TermodelLog.WriteLog($"Punto: ({coord.X:F2}, {coord.Y:F2})");
        }

        // Crea un nuovo poligono con le coordinate raccordate
        var ring = new LinearRing(coordinateRaccordate.ToArray());
        return new Polygon(ring);
    }

    public static (Line, Line) RaccordaLinee(Line linea1, Line linea2)
    {
       // TermodelLog.WriteLog($"Raccordo delle linee:");
        //TermodelLog.WriteLog($"Linea1: Start({linea1.Start.X}, {linea1.Start.Y}) - End({linea1.End.X}, {linea1.End.Y})");
        //TermodelLog.WriteLog($"Linea2: Start({linea2.Start.X}, {linea2.Start.Y}) - End({linea2.End.X}, {linea2.End.Y})");

        if (SonoAllineate(linea1, linea2))
        {
            TermodelLog.WriteLog("Le linee sono parallele, restituisco le linee originali.");
            return (linea1, linea2);
        }

        var puntoIntersezione = TrovaIntersezione(linea1, linea2);

        if (puntoIntersezione != null && puntoIntersezione is Point point)
        {
            Coordinate intersezione = point.Coordinate;
            //TermodelLog.WriteLog($"Punto di intersezione trovato: ({intersezione.X}, {intersezione.Y})");

            var nuovaLinea1 = new Line(linea1.Start, intersezione);
            var nuovaLinea2 = new Line(intersezione, linea2.End);

            //TermodelLog.WriteLog($"Nuova Linea1: Start({nuovaLinea1.Start.X}, {nuovaLinea1.Start.Y}) - End({nuovaLinea1.End.X}, {nuovaLinea1.End.Y})");
            //TermodelLog.WriteLog($"Nuova Linea2: Start({nuovaLinea2.Start.X}, {nuovaLinea2.Start.Y}) - End({nuovaLinea2.End.X}, {nuovaLinea2.End.Y})");

            return (nuovaLinea1, nuovaLinea2);
        }

        //TermodelLog.WriteLog("Nessun punto di intersezione trovato, restituisco le linee originali.");
        return (linea1, linea2);
    }



    private static Geometry TrovaIntersezione(Line linea1, Line linea2)
    {
        // Log delle coordinate di ingresso delle linee
        //TermodelLog.WriteLog($"Calcolo intersezione tra le linee:");
        //TermodelLog.WriteLog($"Linea1: Start({linea1.Start.X}, {linea1.Start.Y}) - End({linea1.End.X}, {linea1.End.Y})");
       // TermodelLog.WriteLog($"Linea2: Start({linea2.Start.X}, {linea2.Start.Y}) - End({linea2.End.X}, {linea2.End.Y})");

        // Converti le linee in LineString per calcolare l'intersezione reale
        var lineString1 = new LineString(new[] { linea1.Start, linea1.End });
        var lineString2 = new LineString(new[] { linea2.Start, linea2.End });
        var intersezione = lineString1.Intersection(lineString2);

        // Se esiste un'intersezione reale, loggala e restituiscila
        if (intersezione is Point point)
        {
           // TermodelLog.WriteLog($"Intersezione reale trovata: ({point.X}, {point.Y})");
            return point;
        }

        // Calcola l'intersezione delle estensioni se non esiste una intersezione reale
        //TermodelLog.WriteLog("Nessuna intersezione reale trovata. Calcolo dell'intersezione delle estensioni...");
        var projectedIntersection = CalcolaIntersezioneProiettata(linea1, linea2);

        if (projectedIntersection != null)
        {
            //TermodelLog.WriteLog($"Intersezione proiettata (esterna alle linee): ({projectedIntersection.X}, {projectedIntersection.Y})");
            return new Point(projectedIntersection);
        }

        //TermodelLog.WriteLog("Nessuna intersezione trovata, né reale né proiettata.");
        return null;
    }
    private static Coordinate CalcolaIntersezioneProiettata(Line linea1, Line linea2)
    {
        // Ottieni le coordinate delle linee
        double x1 = linea1.Start.X, y1 = linea1.Start.Y;
        double x2 = linea1.End.X, y2 = linea1.End.Y;
        double x3 = linea2.Start.X, y3 = linea2.Start.Y;
        double x4 = linea2.End.X, y4 = linea2.End.Y;

        // Calcola i denominatori per trovare il punto di intersezione delle estensioni
        double denom = (y4 - y3) * (x2 - x1) - (x4 - x3) * (y2 - y1);

        // Se denom è zero, le linee sono parallele o collineari
        if (denom == 0)
        {
            TermodelLog.WriteLog("Le linee sono parallele o collineari, nessuna intersezione proiettata.");
            return null;
        }

        // Calcola i parametri di intersezione
        double ua = ((x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3)) / denom;
        double ub = ((x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3)) / denom;

        // Calcola il punto di intersezione
        double intersectionX = x1 + ua * (x2 - x1);
        double intersectionY = y1 + ua * (y2 - y1);

        return new Coordinate(intersectionX, intersectionY);
    }


    private static bool SonoAllineate(Line linea1, Line linea2)
    {
        // Verifica se due linee sono allineate calcolando i vettori direzionali e confrontandoli

        var dx1 = linea1.End.X - linea1.Start.X;
        var dy1 = linea1.End.Y - linea1.Start.Y;
        var dx2 = linea2.End.X - linea2.Start.X;
        var dy2 = linea2.End.Y - linea2.Start.Y;

        // Verifica se i vettori sono paralleli usando il prodotto incrociato
        return Math.Abs(dx1 * dy2 - dy1 * dx2) < 0.001; // Consideriamo un margine di tolleranza per il confronto
    }
    public static bool IntersecaIVertici(List<Coordinate> poligono, Coordinate lineaStart, Coordinate lineaEnd)
    {
        var testLine = new LineString(new[] { lineaStart, lineaEnd });

        foreach (var vertice in poligono)
        {
            var point = new Point(vertice);
            if (testLine.Distance(point) < 0.001)  // Distanza "quasi nulla"
            {
                TermodelLog.WriteLog($"⚠️ Linea di test troppo vicina al vertice: {vertice}",
                    category: Termodel.utilities.TermodelLog.LogCategory.RedrawHelix);
                return true;
            }
        }

        return false;
    }

    private static Coordinate TrovaPuntoEsternoSicuro(List<Coordinate> poligono, Coordinate punto)
    {
        double delta = 1.0;  // incremento su X e Y
        int maxTentativi = 1000;
        int tentativi = 0;

        Coordinate externalPoint;

        do
        {
            double xCorrente = punto.X + 1000 + (tentativi * delta);
            double yCorrente = punto.Y + (tentativi * delta);  // anche la Y cresce!
            externalPoint = new Coordinate(xCorrente, yCorrente);
            tentativi++;

            if (tentativi > maxTentativi)
            {
                TermodelLog.WriteLog("❌ Impossibile trovare un punto esterno sicuro per il test di contenimento (intersezione continua con vertici).",
                    category: Termodel.utilities.TermodelLog.LogCategory.RedrawHelix);
                break;
            }

        } while (IntersecaIVertici(poligono, punto, externalPoint));

        return externalPoint;
    }


    public static bool ContainsPoint(Geometry originalPolygon, Coordinate point)
    {
        var nPoint = new NetTopologySuite.Geometries.Point(point);
        var puntiPoligono = originalPolygon.Coordinates.ToList();

        // Log: controllo chiusura poligono
        if (!originalPolygon.Coordinates.First().Equals2D(originalPolygon.Coordinates.Last()))
        {
            TermodelLog.WriteLog("⚠️ Profilo non chiuso. Il primo e l’ultimo punto non coincidono.",
                category: Termodel.utilities.TermodelLog.LogCategory.RedrawHelix);
        }

        // Log: controllo validità geometria
        if (!originalPolygon.IsValid)
        {
            TermodelLog.WriteLog("❗ ATTENZIONE: Poligono non valido. Potrebbe avere self-intersections o punti duplicati.",
                category: Termodel.utilities.TermodelLog.LogCategory.RedrawHelix);
        }

        // Log: stampa in WKT
        TermodelLog.WriteLog("📌 Poligono WKT:\n" + originalPolygon.AsText(),
            category: Termodel.utilities.TermodelLog.LogCategory.RedrawHelix);

        // Calcolo del punto esterno "sicuro"
        var externalPoint = TrovaPuntoEsternoSicuro(puntiPoligono, point);
        var testLine = new LineString(new[] { point, externalPoint });

        int intersectionCount = 0;
        int intersectionVertex = 0;

        List<string> edgeLogs = new List<string>();

        foreach (var edge in GetEdges(originalPolygon.Coordinates))
        {
            bool intersects = testLine.Intersects(edge);
            bool onVertex = IsPointOnVertex(edge, point);

            if (intersects)
            {
                if (onVertex)
                {
                    intersectionVertex++;
                }
                intersectionCount++;

                edgeLogs.Add($"✔️ Intersezione con edge: ({FormatCoord(edge.Coordinates[0])}) - ({FormatCoord(edge.Coordinates[1])})" +
                             (onVertex ? " (su vertice)" : ""));
            }
            else
            {
                edgeLogs.Add($"✖️ Nessuna intersezione con edge: ({FormatCoord(edge.Coordinates[0])}) - ({FormatCoord(edge.Coordinates[1])})");
            }
        }

        int adjusted = intersectionCount - intersectionVertex / 2;
        bool inside = (adjusted % 2 != 0);

        if (!inside)
        {
            string logMsg =
                $"ContainsPoint: baricentro rifiutato\n" +
                $"Baricentro: {FormatCoord(point)}\n" +
                $"Intersezioni: {intersectionCount}, Vertici coincidenti: {intersectionVertex}, Intersezioni corrette: {adjusted}\n" +
                $"📏 Linea di test: ({FormatCoord(point)}) → ({FormatCoord(externalPoint)})\n" +
                string.Join("\n", edgeLogs);

            TermodelLog.WriteLog(logMsg, category: Termodel.utilities.TermodelLog.LogCategory.RedrawHelix);
        }

        if (inside)
        {
            return true;
        }

        foreach (var coord in originalPolygon.Coordinates)
        {
            if (coord.Equals(point))
            {
                return true;
            }
        }

        return false;
    }

    private static string FormatCoord(Coordinate c)
    {
        return $"X={c.X.ToString("0.###", CultureInfo.InvariantCulture)}, Y={c.Y.ToString("0.###", CultureInfo.InvariantCulture)}";
    }




    // Funzione per verificare se il punto è esattamente su uno dei vertici del lato
    private static bool IsPointOnVertex(LineString edge, Coordinate point)
    {
        var edgeCoords = edge.Coordinates;
        // Verifica se il punto è esattamente uno dei due vertici del lato
        return edgeCoords[0].Equals(point) || edgeCoords[1].Equals(point);
    }

    // Funzione per ottenere i lati del triangolo
    private static List<LineString> GetEdges(Coordinate[] coordinates)
    {
        var edges = new List<LineString>();
        for (int i = 0; i < coordinates.Length - 1; i++)
        {
            edges.Add(new LineString(new[] { coordinates[i], coordinates[i + 1] }));
        }
        // Aggiungi l'ultimo lato (tra l'ultimo e il primo punto)
        edges.Add(new LineString(new[] { coordinates[coordinates.Length - 1], coordinates[0] }));
        return edges;
    }
    ////Intersezione con approssimazione
   

    public static bool Intersects(LineString l1, LineString l2, double apr)
    {
        return TryIntersection(l1, l2, out _, apr);
    }

    public static Geometry Intersection(LineString l1, LineString l2, double apr)
    {
        if (TryIntersection(l1, l2, out var inter, apr))
            return new Point(inter); // oppure crea una GeometryCollection se vuoi
        return null;
    }

    private static bool TryIntersection(LineString l1, LineString l2, out Coordinate intersezione, double apr)
    {
        intersezione = null;
        var a1 = l1.GetCoordinateN(0);
        var a2 = l1.GetCoordinateN(1);
        var b1 = l2.GetCoordinateN(0);
        var b2 = l2.GetCoordinateN(1);

        return IntersezioneSegmenti(a1, a2, b1, b2, out intersezione, apr);
    }

    private static bool IntersezioneSegmenti(Coordinate a1, Coordinate a2, Coordinate b1, Coordinate b2, out Coordinate inter, double apr)
    {
        inter = null;
        double dxA = a2.X - a1.X;
        double dyA = a2.Y - a1.Y;
        double dxB = b2.X - b1.X;
        double dyB = b2.Y - b1.Y;
        double denom = dxA * dyB - dyA * dxB;

        if (Math.Abs(denom) < apr)
            return false; // paralleli

        double dx = b1.X - a1.X;
        double dy = b1.Y - a1.Y;

        double s = (dx * dyB - dy * dxB) / denom;
        double t = (dx * dyA - dy * dxA) / denom;

        if (s < -apr || s > 1 + apr || t < -apr || t > 1 + apr)
            return false;

        inter = new Coordinate(a1.X + s * dxA, a1.Y + s * dyA);
        return true;
    }



}
