// SpiralGenerator.cs
using System;
using System.Collections.Generic;
using System.Linq;

namespace SpiralHeating
{
	public static class SpiralGenerator
	{
		public static (List<Punto> spiral, List<List<Punto>> offsets) Generate(List<Punto> perimetro, Punto startPoint, double distanza, bool drawSpiral = true)
		{
			List<Punto> spiral = new List<Punto>();
			
			// Verifica e correggi il senso di rotazione (deve essere antiorario)
			perimetro = GeometryUtils.EnsureCounterClockwise(perimetro);

			List<List<Punto>> offsets = new List<List<Punto>>();
			offsets.Add(GeometryUtils.NormalizePolygon(new List<Punto>(perimetro)));

			double minArea = distanza * distanza;

			// Genera offset successivi
			for (int i = 0; i < 100; i++)
			{
				var previousOffset = i > 0 ? offsets[offsets.Count - 2] : perimetro;
				var nextOffset = ComputeOffset(offsets.Last(), previousOffset, distanza);

				if (nextOffset == null || nextOffset.Count < 3)
					break;
				
				// Correggi vertici che intersecano il perimetro precedente
				nextOffset = FixIntersections(nextOffset, offsets.Last(), distanza);
				
				double minEdgeLength = double.MaxValue;
				for (int j = 0; j < nextOffset.Count - 1; j++)
				{
					double edgeLen = nextOffset[j].DistanceTo(nextOffset[j + 1]);
					if (edgeLen < minEdgeLength)
						minEdgeLength = edgeLen;
				}
				if (minEdgeLength < distanza && minEdgeLength > 0.2)
					break;
				if (minEdgeLength < distanza * 1.2 && nextOffset.Count < 5)
					break;
					
				offsets.Add(GeometryUtils.NormalizePolygon(nextOffset));
				//offsets.Add(nextOffset);

			}

			// Se non si deve disegnare la spirale, restituisci solo gli offset
			if (!drawSpiral)
				return (spiral, offsets);

			spiral.Add(startPoint);
			
			// Avanza perpendicolarmente fino al primo offset
			Punto puntoEsterno = startPoint;
			
			if (offsets.Count < 2)
				return (spiral, offsets);
			
			// Itera su tutti gli offset generati (dal primo all'ultimo)
			for (int offsetIdx = 1; offsetIdx < offsets.Count; offsetIdx++)
			{
				var currentOffset = offsets[offsetIdx];
				
				// Trova intersezione con l'offset corrente dall'ultimo punto della spirale
				var ultimoPuntoSpiral = spiral[spiral.Count - 1];
				var (puntoIntersezione, startVertexIndex) = FindIntersectionWithOffset(ultimoPuntoSpiral, currentOffset);
				
				if (puntoIntersezione == null)
					break;	

				spiral.Add(puntoIntersezione);
				
				double distPuntoIntersezione = ultimoPuntoSpiral.DistanceTo(puntoIntersezione);
				
				if (distPuntoIntersezione > distanza)
				{
					double dx = Math.Abs(puntoIntersezione.X - ultimoPuntoSpiral.X);
					double dy = Math.Abs(puntoIntersezione.Y - ultimoPuntoSpiral.Y);
					bool areCollinear = false;
					
					// Controlla se i tre punti sono allineati
					if (spiral.Count >= 3)
					{
						var penultimoPuntoSpiral = spiral[spiral.Count - 3];
						areCollinear = Math.Abs((puntoIntersezione.Y - penultimoPuntoSpiral.Y) * (ultimoPuntoSpiral.X - penultimoPuntoSpiral.X) - 
													  (ultimoPuntoSpiral.Y - penultimoPuntoSpiral.Y) * (puntoIntersezione.X - penultimoPuntoSpiral.X)) < 0.001;
					}
					
					if (areCollinear)
					{
						spiral.RemoveAt(spiral.Count - 2);
					}
					
					else {
					
						Punto puntoIntermedio;
						if (dy > dx)
							puntoIntermedio = new Punto(puntoIntersezione.X, ultimoPuntoSpiral.Y);
						else
							puntoIntermedio = new Punto(ultimoPuntoSpiral.X, puntoIntersezione.Y);
						
						
						bool isTooCloseToSpiral = false;
						for (int j = 0; j < spiral.Count - 1; j++)
						{
							double dist = GeometryUtils.DistancePointToSegment(puntoIntermedio, spiral[j], spiral[j + 1]);
							if (dist < distanza * 0.8 && dist > 0.01)
							{
								isTooCloseToSpiral = true;
								break;
							}
						}
						
						if (isTooCloseToSpiral)
						{
							if (dy > dx)
								puntoIntermedio = new Punto(ultimoPuntoSpiral.X, puntoIntersezione.Y);
							else
								puntoIntermedio = new Punto(puntoIntersezione.X, ultimoPuntoSpiral.Y);
							
							spiral.RemoveAt(spiral.Count - 2);
						}
						
						spiral.Insert(spiral.Count - 1, puntoIntermedio);
					}
					
				}
				
				// Segue tutti i vertici dell'offset corrente in ordine (senso antiorario)
				for (int i = 0; i < currentOffset.Count; i++)
				{
					int vertexIndex = (startVertexIndex + i) % currentOffset.Count;
					spiral.Add(currentOffset[vertexIndex]);
				}
				
				// Calcola punto finale
				Punto ultimoPunto;
				Punto penultimoPunto;

				double distanzaSegmento = puntoIntersezione.DistanceTo(spiral[spiral.Count - 1]);
				if (distanzaSegmento > 2 * distanza) {
					ultimoPunto = puntoIntersezione;
					penultimoPunto = spiral[spiral.Count - 1];
				}
				else {
					ultimoPunto = spiral[spiral.Count - 1];
					penultimoPunto = spiral[spiral.Count - 2];
					spiral.RemoveAt(spiral.Count - 1);
				}

				// Torna indietro di una distanza lungo l'ultimo segmento
				var direzione = GeometryUtils.Normalize(new Punto(
					penultimoPunto.X - ultimoPunto.X,
					penultimoPunto.Y - ultimoPunto.Y
				));
				var puntoFinale = new Punto(
					ultimoPunto.X + direzione.X * distanza,
					ultimoPunto.Y + direzione.Y * distanza
				);
				spiral.Add(puntoFinale);
			}

			return (spiral, offsets);
		}

		private static (Punto intersection, int nextVertexIndex) FindIntersectionWithOffset(Punto start, List<Punto> offset)
		{
			Punto bestIntersection = null;
			int bestSegmentIndex = -1;
			double minDist = double.MaxValue;
			
			for (int i = 0; i < offset.Count; i++)
			{
				var p1 = offset[i];
				var p2 = offset[(i + 1) % offset.Count];
				
				Punto intersection = GeometryUtils.ProjectPointOnSegment(start, p1, p2);
				
				if (intersection != null)
				{
					double dist = start.DistanceTo(intersection);
					if (dist < minDist)
					{
						minDist = dist;
						bestIntersection = intersection;
						bestSegmentIndex = i;
					}
				}
			}
			
			int nextVertex = bestSegmentIndex >= 0 ? (bestSegmentIndex + 1) % offset.Count : 0;
			return (bestIntersection, nextVertex);
		}

		private static List<Punto> ComputeOffset(List<Punto> polygon, List<Punto> polygon_pre, double offset)
		{
			var result = new List<Punto>();
			var skipIndices = new HashSet<int>();
			
			// Prima passata: identifica i lati troppo corti
			for (int i = 0; i < polygon.Count; i++)
			{
				var p1 = polygon[i];
				var p2 = polygon[(i + 1) % polygon.Count];
				double edgeLength = p1.DistanceTo(p2);

				var p1_pre = polygon_pre[i];
				var p2_pre = polygon_pre[(i + 1) % polygon_pre.Count];
				double edgeLength_pre = p1_pre.DistanceTo(p2_pre);
				
				if (edgeLength <= offset * 3 && edgeLength_pre - edgeLength > offset)
				{
					skipIndices.Add(i);
					skipIndices.Add((i+1) % polygon.Count);
				}
			}
			
			// Seconda passata: calcola offset solo per vertici non skippati
			for (int i = 0; i < polygon.Count; i++)
			{
				if (skipIndices.Contains(i)) 
					continue;
					
				var p1 = polygon[i];
				var p2 = polygon[(i + 1) % polygon.Count];
				var p0 = polygon[(i - 1 + polygon.Count) % polygon.Count];

				var v1 = GeometryUtils.Normalize(new Punto(p1.X - p0.X, p1.Y - p0.Y));
				var v2 = GeometryUtils.Normalize(new Punto(p2.X - p1.X, p2.Y - p1.Y));

				var n1 = new Punto(-v1.Y, v1.X);
				var n2 = new Punto(-v2.Y, v2.X);

				var bisector = GeometryUtils.Normalize(new Punto(n1.X + n2.X, n1.Y + n2.Y));				
				
				double offsetDist = (offset * Math.Sqrt(2)) / Math.Max(0.1, Math.Sqrt(1 + (n1.X * n2.X + n1.Y * n2.Y)));
				
				result.Add(new Punto(p1.X + bisector.X * offsetDist, p1.Y + bisector.Y * offsetDist));
			}

			return result.Count >= 3 ? result : null;
		}

		private static List<Punto> FixIntersections(List<Punto> newOffset, List<Punto> prevOffset, double minDist)
		{
			for (int i = 0; i < newOffset.Count; i++)
			{
				for (int j = 0; j < prevOffset.Count; j++)
				{
					var p1 = prevOffset[j];
					var p2 = prevOffset[(j + 1) % prevOffset.Count];
					
					double dist = GeometryUtils.DistancePointToSegment(newOffset[i], p1, p2);
					if (dist < minDist)
					{
						var projected = GeometryUtils.ProjectPointOnSegment(newOffset[i], p1, p2);
						var segDir = GeometryUtils.Normalize(new Punto(p2.X - p1.X, p2.Y - p1.Y));
						var normal = new Punto(-segDir.Y, segDir.X);
						newOffset[i] = new Punto(projected.X + normal.X * minDist, projected.Y + normal.Y * minDist);
					}
				}
			}
			return newOffset;
		}
	}
}