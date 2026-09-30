// UtilityFunctions.cs
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace SpiralHeatingVittorioRevisionato
{
    public class Punto
    {
        public double X { get; set; }
        public double Y { get; set; }

        public Punto(double x, double y)
        {
            X = x;
            Y = y;
        }

        public double DistanceTo(Punto other)
        {
            return Math.Sqrt(Math.Pow(X - other.X, 2) + Math.Pow(Y - other.Y, 2));
        }
    }

    public class LocaleData
    {
        public List<Punto> Perimetro { get; set; }
        public Punto StartPoint { get; set; }
        public double DistanzaPareti { get; set; }
    }

    public static class GeometryUtils
    {
        private const double TolleranzaDuplicati = 0.0001;
        
        public static List<Punto> EnsureCounterClockwise(List<Punto> polygon)
        {
            double signedArea = 0;
            for (int i = 0; i < polygon.Count; i++)
            {
                var p1 = polygon[i];
                var p2 = polygon[(i + 1) % polygon.Count];
                signedArea += (p1.X * p2.Y) - (p2.X * p1.Y);
            }
            
            if (signedArea < 0)
            {
                var reversed = new List<Punto>(polygon);
                reversed.Reverse();
                return reversed;
            }
            
            return polygon;
        }
		
		public static List<Punto> RoundAndSnapVertices(
			List<Punto> polygon,
			int decimals = 2,
			double snapTolerance = 0.001)
		{
			double multiplier = Math.Pow(10, decimals);

			//Console.WriteLine("=== RoundAndSnapVertices START ===");
			//Console.WriteLine($"Decimali: {decimals}, SnapTolerance: {snapTolerance}");
			//Console.WriteLine($"Vertici iniziali: {polygon.Count}");

			// 1️⃣ Arrotondamento
			var rounded = polygon.Select((p, idx) =>
			{
				double rx = Math.Round(p.X * multiplier) / multiplier;
				double ry = Math.Round(p.Y * multiplier) / multiplier;



				return new Punto(rx, ry);
			}).ToList();

			// 2️⃣ Snap primo-ultimo
			if (rounded.Count > 1)
			{
				var first = rounded[0];
				var last = rounded[rounded.Count - 1];

				double dx = Math.Abs(first.X - last.X);
				double dy = Math.Abs(first.Y - last.Y);

				if (dx < snapTolerance && dy < snapTolerance)
				{
					//Console.WriteLine($"[SNAP CLOSE] First-Last: ΔX={dx}, ΔY={dy} → snapping last to first");
					rounded[rounded.Count - 1] = new Punto(first.X, first.Y);
				}
			}

			// 3️⃣ Snap coordinate quasi identiche
			for (int i = 0; i < rounded.Count; i++)
			{
				for (int j = i + 1; j < rounded.Count; j++)
				{
					double dx = Math.Abs(rounded[i].X - rounded[j].X);
					double dy = Math.Abs(rounded[i].Y - rounded[j].Y);

					if (dx < snapTolerance)
					{
						//Console.WriteLine($"[SNAP X] i={i}, j={j} | {rounded[j].X} -> {rounded[i].X} (Δ={dx})");

						rounded[j] = new Punto(rounded[i].X, rounded[j].Y);
					}

					if (dy < snapTolerance)
					{
						//Console.WriteLine($"[SNAP Y] i={i}, j={j} | {rounded[j].Y} -> {rounded[i].Y} (Δ={dy})");

						rounded[j] = new Punto(rounded[j].X, rounded[i].Y);
					}
				}
			}

			//Console.WriteLine("=== RoundAndSnapVertices END ===");
			return rounded;
		}
		
		
		
		public static List<Punto> RemoveCollinearVertices(List<Punto> polygon, double tolerance = 0.001)
		{
			//Console.WriteLine("=== RemoveCollinearVertices START ===");
			//Console.WriteLine($"Tolerance: {tolerance}");
			//Console.WriteLine($"Vertici iniziali: {polygon.Count}");
			
			if (polygon.Count < 3) return polygon;
			
			var result = new List<Punto>();
			
			for (int i = 0; i < polygon.Count; i++)
			{
				var prev = polygon[(i - 1 + polygon.Count) % polygon.Count];
				var curr = polygon[i];
				var next = polygon[(i + 1) % polygon.Count];
				
				// Calcola prodotto vettoriale per verificare se sono collineari
				double crossProduct = Math.Abs(
					(curr.X - prev.X) * (next.Y - curr.Y) - 
					(curr.Y - prev.Y) * (next.X - curr.X)
				);
				
				//Console.WriteLine($"[VERTEX {i}] ({curr.X}, {curr.Y}) | CrossProduct={crossProduct:F6}");
				
				// Se non sono collineari, mantieni il vertice
				if (crossProduct > tolerance)
				{
					//Console.WriteLine($"  → KEPT (non-collinear)");
					result.Add(curr);
				}
				else
				{
					//Console.WriteLine($"  → REMOVED (collinear)");
				}
			}
			
			//Console.WriteLine($"Vertici finali: {result.Count}");
			//Console.WriteLine("=== RemoveCollinearVertices END ===\n");
			
			return result.Count >= 3 ? result : polygon;
		}
		
		
		
		
		
        public static double ComputeArea(List<Punto> polygon)
        {
            double area = 0;
            for (int i = 0; i < polygon.Count; i++)
            {
                var p1 = polygon[i];
                var p2 = polygon[(i + 1) % polygon.Count];
                area += (p1.X * p2.Y) - (p2.X * p1.Y);
            }
            return Math.Abs(area) / 2.0;
        }

        public static Punto ProjectPointOnSegment(Punto point, Punto segmentStart, Punto segmentEnd)
        {
            double dx = segmentEnd.X - segmentStart.X;
            double dy = segmentEnd.Y - segmentStart.Y;
            
            if (Math.Abs(dx) < 0.001 && Math.Abs(dy) < 0.001)
                return null;
            
            double t = ((point.X - segmentStart.X) * dx + (point.Y - segmentStart.Y) * dy) / (dx * dx + dy * dy);
            t = Math.Max(0, Math.Min(1, t));
            
            return new Punto(segmentStart.X + t * dx, segmentStart.Y + t * dy);
        }

        public static Punto Normalize(Punto v)
        {
            double len = Math.Sqrt(v.X * v.X + v.Y * v.Y);
            return len > 0 ? new Punto(v.X / len, v.Y / len) : new Punto(0, 0);
        }

        public static bool IsInsidePolygon(Punto point, List<Punto> polygon)
        {
            int intersections = 0;
            for (int i = 0; i < polygon.Count; i++)
            {
                var p1 = polygon[i];
                var p2 = polygon[(i + 1) % polygon.Count];

                if ((p1.Y > point.Y) != (p2.Y > point.Y))
                {
                    double xIntersect = (p2.X - p1.X) * (point.Y - p1.Y) / (p2.Y - p1.Y) + p1.X;
                    if (point.X < xIntersect)
                        intersections++;
                }
            }
            return (intersections % 2) == 1;
        }

        public static bool IsTooCloseToSpiral(Punto point, List<Punto> spiral, double minDistance)
        {
            return spiral.Any(p => p.DistanceTo(point) < minDistance * 0.9);
        }

        public static List<Punto> NormalizePolygon(List<Punto> polygon)
        {
            for (int i = 1; i < polygon.Count; i++)
            {
                var prev = polygon[i - 1];
                var curr = polygon[i];
                
                double dx = Math.Abs(curr.X - prev.X);
                double dy = Math.Abs(curr.Y - prev.Y);
                
                if (dx > 0.001 && dy > 0.001)
                {
                    if (dx < dy)
                        polygon[i] = new Punto(prev.X, curr.Y);
                    else
                        polygon[i] = new Punto(curr.X, prev.Y);
                }
            }
            
            if (polygon.Count > 1)
            {
                var first = polygon[0];
                var last = polygon[polygon.Count - 1];
                
                double dx = Math.Abs(last.X - first.X);
                double dy = Math.Abs(last.Y - first.Y);
                
                if (dx > 0.01 && dy > 0.01)
                {
                    if (dx < dy)
                        polygon[polygon.Count - 1] = new Punto(first.X, last.Y);
                    else
                        polygon[polygon.Count - 1] = new Punto(last.X, first.Y);
                }
            }
            return polygon;
        }

        public static double DistancePointToSegment(Punto point, Punto segStart, Punto segEnd)
        {
            var projected = ProjectPointOnSegment(point, segStart, segEnd);
            if (projected == null)
                return double.MaxValue;
            return point.DistanceTo(projected);
        }
        
        public static List<Punto> EliminaDuplicati(List<Punto> punti)
        {
            if (punti.Count == 0) return punti;
            
            List<Punto> risultato = new List<Punto>();
            risultato.Add(punti[0]);
            
            for (int i = 1; i < punti.Count; i++)
            {
                var ultimo = risultato[risultato.Count - 1];
                var corrente = punti[i];
                
                double dx = corrente.X - ultimo.X;
                double dy = corrente.Y - ultimo.Y;
                double distanza = Math.Sqrt(dx * dx + dy * dy);
                
                if (distanza > TolleranzaDuplicati)
                {
                    risultato.Add(corrente);
                }
            }
            
            return risultato;
        }
        
        public static List<Punto> ArrotondaSpirale(List<Punto> spirale, double raggio)
        {
            List<Punto> risultato = new List<Punto>();
            risultato.Add(spirale[0]);
            
            for (int i = 1; i < spirale.Count - 1; i++)
            {
                var p0 = spirale[i - 1];
                var p1 = spirale[i];
                var p2 = spirale[i + 1];
                
                var v1 = new Punto(p1.X - p0.X, p1.Y - p0.Y);
                var v2 = new Punto(p2.X - p1.X, p2.Y - p1.Y);
                
                double len1 = Math.Sqrt(v1.X * v1.X + v1.Y * v1.Y);
                double len2 = Math.Sqrt(v2.X * v2.X + v2.Y * v2.Y);
                
                if (len1 < 0.001 || len2 < 0.001)
                {
                    risultato.Add(p1);
                    continue;
                }
                
                v1 = new Punto(v1.X / len1, v1.Y / len1);
                v2 = new Punto(v2.X / len2, v2.Y / len2);
                
                double distMax = Math.Min(len1, len2) / 2.0;
                double dist = Math.Min(raggio, distMax);
                
                var pStart = new Punto(p1.X - v1.X * dist, p1.Y - v1.Y * dist);
                var pEnd = new Punto(p1.X + v2.X * dist, p1.Y + v2.Y * dist);
                
                risultato.Add(pStart);
                
                for (int j = 1; j < 10; j++)
                {
                    double t = (double)j / 10;
                    double x = (1 - t) * (1 - t) * pStart.X + 2 * (1 - t) * t * p1.X + t * t * pEnd.X;
                    double y = (1 - t) * (1 - t) * pStart.Y + 2 * (1 - t) * t * p1.Y + t * t * pEnd.Y;
                    risultato.Add(new Punto(x, y));
                }
                
                risultato.Add(pEnd);
            }
            
            risultato.Add(spirale[spirale.Count - 1]);
            return risultato;
        }

        // LG-051: archi circolari tangenti a raggio fisso. Se il raggio non
        // entra nei tratti disponibili lo spigolo resta vivo.
        public static List<Punto> ArrotondaSpiraleCircolareLg051(
            List<Punto> spirale,
            double raggio,
            double tolleranzaDiscretizzazione,
            out Dictionary<int, int> indiceTransizionePerVertice)
        {
            const double epsilon = 0.000001;
            indiceTransizionePerVertice = new Dictionary<int, int>();
            if (spirale == null || spirale.Count == 0)
                return new List<Punto>();

            if (spirale.Count < 3 ||
                raggio <= epsilon ||
                !double.IsFinite(raggio) ||
                tolleranzaDiscretizzazione <= epsilon ||
                !double.IsFinite(tolleranzaDiscretizzazione))
            {
                var copia = spirale.ToList();
                for (int i = 1; i < copia.Count - 1; i++)
                    indiceTransizionePerVertice[i] = i;
                return copia;
            }

            int count = spirale.Count;
            var lunghezze = new double[count - 1];
            for (int i = 0; i < count - 1; i++)
                lunghezze[i] = spirale[i].DistanceTo(spirale[i + 1]);

            var raccordabile = new bool[count];
            var distanzeTangenti = new double[count];

            for (int i = 1; i < count - 1; i++)
            {
                double len1 = lunghezze[i - 1];
                double len2 = lunghezze[i];
                if (len1 <= epsilon || len2 <= epsilon)
                    continue;

                var u1 = new Punto(
                    (spirale[i].X - spirale[i - 1].X) / len1,
                    (spirale[i].Y - spirale[i - 1].Y) / len1);
                var u2 = new Punto(
                    (spirale[i + 1].X - spirale[i].X) / len2,
                    (spirale[i + 1].Y - spirale[i].Y) / len2);

                double prodotto = Math.Max(
                    -1.0,
                    Math.Min(1.0, u1.X * u2.X + u1.Y * u2.Y));
                double deviazione = Math.Acos(prodotto);
                double verso = u1.X * u2.Y - u1.Y * u2.X;
                if (deviazione <= epsilon ||
                    deviazione >= Math.PI - epsilon ||
                    Math.Abs(verso) <= epsilon)
                {
                    continue;
                }

                double distanzaTangente =
                    raggio * Math.Tan(deviazione / 2.0);
                if (!double.IsFinite(distanzaTangente) ||
                    distanzaTangente <= epsilon ||
                    distanzaTangente > len1 + epsilon ||
                    distanzaTangente > len2 + epsilon)
                {
                    continue;
                }
                raccordabile[i] = true;
                distanzeTangenti[i] = distanzaTangente;
            }

            // Evita sovrapposizioni fra raccordi adiacenti senza scegliere
            // arbitrariamente quale raggio ridurre: in conflitto restano vivi.
            for (int segmento = 0; segmento < count - 1; segmento++)
            {
                int a = segmento;
                int b = segmento + 1;
                double usoA =
                    a > 0 && a < count - 1 && raccordabile[a]
                        ? distanzeTangenti[a]
                        : 0.0;
                double usoB =
                    b > 0 && b < count - 1 && raccordabile[b]
                        ? distanzeTangenti[b]
                        : 0.0;
                if (usoA + usoB > lunghezze[segmento] + epsilon)
                {
                    if (a > 0 && a < count - 1)
                        raccordabile[a] = false;
                    if (b > 0 && b < count - 1)
                        raccordabile[b] = false;
                }
            }

            var risultato = new List<Punto>();
            AggiungiSeDistinto(risultato, spirale[0]);

            for (int i = 1; i < count - 1; i++)
            {
                Punto p0 = spirale[i - 1];
                Punto p1 = spirale[i];
                Punto p2 = spirale[i + 1];

                if (!raccordabile[i])
                {
                    AggiungiSeDistinto(risultato, p1);
                    indiceTransizionePerVertice[i] = risultato.Count - 1;
                    continue;
                }

                double len1 = lunghezze[i - 1];
                double len2 = lunghezze[i];
                var u1 = new Punto((p1.X - p0.X) / len1, (p1.Y - p0.Y) / len1);
                var u2 = new Punto((p2.X - p1.X) / len2, (p2.Y - p1.Y) / len2);
                double distanzaTangente = distanzeTangenti[i];

                var pStart = new Punto(
                    p1.X - u1.X * distanzaTangente,
                    p1.Y - u1.Y * distanzaTangente);
                var pEnd = new Punto(
                    p1.X + u2.X * distanzaTangente,
                    p1.Y + u2.Y * distanzaTangente);

                double verso = u1.X * u2.Y - u1.Y * u2.X;
                Punto normale = verso > 0
                    ? new Punto(-u1.Y, u1.X)
                    : new Punto(u1.Y, -u1.X);
                var centro = new Punto(
                    pStart.X + normale.X * raggio,
                    pStart.Y + normale.Y * raggio);

                double angoloInizio = Math.Atan2(
                    pStart.Y - centro.Y,
                    pStart.X - centro.X);
                double angoloFine = Math.Atan2(
                    pEnd.Y - centro.Y,
                    pEnd.X - centro.X);
                double sviluppo = angoloFine - angoloInizio;
                if (verso > 0)
                {
                    while (sviluppo < 0)
                        sviluppo += 2.0 * Math.PI;
                }
                else
                {
                    while (sviluppo > 0)
                        sviluppo -= 2.0 * Math.PI;
                }

                double rapportoErrore =
                    Math.Min(1.0, tolleranzaDiscretizzazione / raggio);
                double angoloMassimo =
                    rapportoErrore >= 1.0
                        ? Math.PI
                        : 2.0 * Math.Acos(1.0 - rapportoErrore);
                if (!double.IsFinite(angoloMassimo) || angoloMassimo <= epsilon)
                    angoloMassimo = Math.PI / 180.0;

                int segmenti = Math.Max(
                    1,
                    (int)Math.Ceiling(Math.Abs(sviluppo) / angoloMassimo));
                int segmentoTransizione =
                    (int)Math.Ceiling(segmenti / 2.0);

                AggiungiSeDistinto(risultato, pStart);
                for (int j = 1; j <= segmenti; j++)
                {
                    double angolo =
                        angoloInizio + sviluppo * j / segmenti;
                    AggiungiSeDistinto(
                        risultato,
                        new Punto(
                            centro.X + raggio * Math.Cos(angolo),
                            centro.Y + raggio * Math.Sin(angolo)));
                    if (j == segmentoTransizione)
                        indiceTransizionePerVertice[i] = risultato.Count - 1;
                }
                if (!indiceTransizionePerVertice.ContainsKey(i))
                    indiceTransizionePerVertice[i] = risultato.Count - 1;
            }

            AggiungiSeDistinto(risultato, spirale[^1]);
            return risultato;
        }

        public static List<Punto> ArrotondaSpiraleCircolareLg051(
            List<Punto> spirale,
            double raggio,
            double tolleranzaDiscretizzazione)
        {
            return ArrotondaSpiraleCircolareLg051(
                spirale,
                raggio,
                tolleranzaDiscretizzazione,
                out _);
        }
    }

    public static class UtilityFunctions
    {
        public static LocaleData LoadFromXml(string filePath)
        {
            XDocument doc = XDocument.Load(filePath);
            CultureInfo ci = CultureInfo.InvariantCulture;

            var perimetro = doc.Descendants("Perimetro")
                .Elements("Punto")
                .Select(p => new Punto(
                    double.Parse(p.Attribute("X").Value, ci),
                    double.Parse(p.Attribute("Y").Value, ci)
                ))
                .ToList();

            var entryPoint = doc.Descendants("EntryLine")
                .Elements("Punto")
                .Where(p => p.Attribute("Ruolo")?.Value == "IngressoLocale")
                .Select(p => new Punto(
                    double.Parse(p.Attribute("X").Value, ci),
                    double.Parse(p.Attribute("Y").Value, ci)
                ))
                .First();

            var distanzaPareti = double.Parse(
                doc.Descendants("ParametriPosa")
                    .First()
                    .Attribute("DistanzaPareti").Value,
                ci
            );

            return new LocaleData
            {
                Perimetro = perimetro,
                StartPoint = entryPoint,
                DistanzaPareti = distanzaPareti
            };
        }

        public static void SaveSpiralToXml(string filePath, List<Punto> spiral)
        {
            XDocument doc = XDocument.Load(filePath);
            CultureInfo ci = CultureInfo.InvariantCulture;

            doc.Descendants("Spirale").Remove();

            var spiraleElement = new XElement("Spirale");
            foreach (var punto in spiral)
            {
                spiraleElement.Add(new XElement("Punto",
                    new XAttribute("X", punto.X.ToString("F2", ci)),
                    new XAttribute("Y", punto.Y.ToString("F2", ci))
                ));
            }

            doc.Descendants("Locale").First().Add(spiraleElement);
            
            doc.Save(filePath);
        }

        public static void SaveToSvg(string filePath, List<Punto> perimetro, List<Punto> spiral, 
                                    Punto startPoint = null, List<List<Punto>> offsets = null)
        {
            var allPoints = perimetro.Concat(spiral).ToList();
            if (startPoint != null) allPoints.Add(startPoint);
            if (offsets != null)
                foreach (var offset in offsets)
                    allPoints.AddRange(offset);

            double minX = allPoints.Min(p => p.X) - 0.5;
            double minY = allPoints.Min(p => p.Y) - 0.5;
            double maxX = allPoints.Max(p => p.X) + 0.5;
            double maxY = allPoints.Max(p => p.Y) + 0.5;

            double width = maxX - minX;
            double height = maxY - minY;
            double scale = 100;

            using (StreamWriter sw = new StreamWriter(filePath))
            {
                sw.WriteLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                sw.WriteLine($"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"{width * scale}\" height=\"{height * scale}\" viewBox=\"{minX} {minY} {width} {height}\">");
                sw.WriteLine("<g transform=\"scale(1,-1) translate(0," + (-(minY + maxY)) + ")\">");

                sw.Write("<polygon points=\"");
                foreach (var p in perimetro)
                    sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                sw.WriteLine("\" fill=\"none\" stroke=\"red\" stroke-width=\"0.02\"/>");

                if (offsets != null)
                {
                    foreach (var offset in offsets)
                    {
                        if (offset.Count > 2)
                        {
                            sw.Write("<polygon points=\"");
                            foreach (var p in offset)
                                sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                            sw.WriteLine("\" fill=\"none\" stroke=\"yellow\" stroke-width=\"0.015\"/>");
                        }
                    }
                }

                if (spiral.Count > 1)
                {
                    sw.Write("<polyline points=\"");
                    foreach (var p in spiral)
                        sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                    sw.WriteLine("\" fill=\"none\" stroke=\"blue\" stroke-width=\"0.015\"/>");
                }

                if (startPoint != null)
                {
                    sw.WriteLine($"<circle cx=\"{startPoint.X.ToString(CultureInfo.InvariantCulture)}\" cy=\"{startPoint.Y.ToString(CultureInfo.InvariantCulture)}\" r=\"0.05\" fill=\"green\"/>");
                }

                sw.WriteLine("</g>");
                sw.WriteLine("</svg>");
            }
        }
        
        public static void SalvaSvgArrotondato(string filePath, List<Punto> perimetro, 
                                                 List<Punto> spirale, List<Punto> rientro, List<Punto> curvaCollegamento)
        {
            var allPoints = new List<Punto>();
            allPoints.AddRange(perimetro);
            allPoints.AddRange(spirale);
            if (rientro != null) allPoints.AddRange(rientro);
            if (curvaCollegamento != null) allPoints.AddRange(curvaCollegamento);
            
            if (allPoints.Count == 0) return;
            
            double minX = allPoints.Min(p => p.X) - 0.5;
            double minY = allPoints.Min(p => p.Y) - 0.5;
            double maxX = allPoints.Max(p => p.X) + 0.5;
            double maxY = allPoints.Max(p => p.Y) + 0.5;
            
            double width = maxX - minX;
            double height = maxY - minY;
            double scale = 100;
            
            using (StreamWriter sw = new StreamWriter(filePath))
            {
                sw.WriteLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                sw.WriteLine($"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"{width * scale}\" height=\"{height * scale}\" viewBox=\"{minX} {minY} {width} {height}\">");
                sw.WriteLine("<g transform=\"scale(1,-1) translate(0," + (-(minY + maxY)) + ")\">");
                
                if (perimetro.Count > 0)
                {
                    sw.Write("<polygon points=\"");
                    foreach (var p in perimetro)
                        sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                    sw.WriteLine("\" fill=\"none\" stroke=\"green\" stroke-width=\"0.02\"/>");
                }
                
                if (spirale.Count > 1)
                {
                    sw.Write("<polyline points=\"");
                    foreach (var p in spirale)
                        sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                    sw.WriteLine("\" fill=\"none\" stroke=\"red\" stroke-width=\"0.015\"/>");
                }
                
                if (curvaCollegamento != null && curvaCollegamento.Count > 1)
                {
                    sw.Write("<polyline points=\"");
                    foreach (var p in curvaCollegamento)
                        sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                    sw.WriteLine("\" fill=\"none\" stroke=\"red\" stroke-width=\"0.015\"/>");
                }
                
                if (rientro != null && rientro.Count > 1)
                {
                    sw.Write("<polyline points=\"");
                    foreach (var p in rientro)
                        sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                    sw.WriteLine("\" fill=\"none\" stroke=\"blue\" stroke-width=\"0.015\" stroke-dasharray=\"0.1,0.02\"/>");
                }
                
                sw.WriteLine("</g>");
                sw.WriteLine("</svg>");
            }
        }		

    }
}