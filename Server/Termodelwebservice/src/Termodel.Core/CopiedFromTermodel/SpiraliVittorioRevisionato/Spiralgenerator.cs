// SpiralGenerator.cs
using System;
using System.Collections.Generic;
using System.Linq;

namespace SpiralHeatingVittorioRevisionato
{
	/// <summary>
	/// Ingresso neutro rispetto al ruolo: lo stesso generatore Vittorio può
	/// essere invocato per un percorso di mandata o di ritorno.
	/// Il condizionamento è volutamente un hard gate post-generazione:
	/// non introduce ricerca di percorsi, fallback o euristiche nuove.
	/// </summary>
	public sealed class SpiralGenerationInput
	{
		public List<Punto> Perimetro { get; set; } = new List<Punto>();
		public Punto StartPoint { get; set; }
		// Distanza e' mantenuta per compatibilita' con i benchmark storici:
		// se le due distanze esplicite non sono impostate, vale per entrambe.
		public double Distanza { get; set; }
		public double DistanzaParete { get; set; }
		public double DistanzaMandataMandata { get; set; }
		public bool DrawSpiral { get; set; } = true;
		public List<Punto> LineeCondizionamento { get; set; } = new List<Punto>();
		public double DistanzaCondizionamento { get; set; }
		public bool TerminalCenterline { get; set; }
	}

	public static class SpiralGenerator
	{
		/// <summary>
		/// Astrazione strutturale iniziale di Vittorio.
		/// Esegue prima il generatore storico INVARIATO; se sono presenti linee
		/// condizionanti tronca il percorso al primo segmento che violerebbe la
		/// distanza richiesta. Non cerca alternative e non cambia le decisioni
		/// geometriche di Vittorio.
		/// </summary>
		public static (List<Punto> spiral, List<List<Punto>> offsets) Generate(
			SpiralGenerationInput input)
		{
			if (input == null)
				throw new ArgumentNullException(nameof(input));
			if (input.Perimetro == null)
				throw new ArgumentException("Perimetro mancante.", nameof(input));
			if (input.StartPoint == null)
				throw new ArgumentException("StartPoint mancante.", nameof(input));
			double distanzaParete =
				input.DistanzaParete > 0 ? input.DistanzaParete : input.Distanza;
			double distanzaMandataMandata =
				input.DistanzaMandataMandata > 0
					? input.DistanzaMandataMandata
					: input.Distanza;
			if (distanzaParete <= 0)
				throw new ArgumentOutOfRangeException(nameof(input.DistanzaParete));
			if (distanzaMandataMandata <= 0)
				throw new ArgumentOutOfRangeException(nameof(input.DistanzaMandataMandata));
			if (input.DistanzaCondizionamento < 0)
				throw new ArgumentOutOfRangeException(nameof(input.DistanzaCondizionamento));

			return GenerateCore(
				new List<Punto>(input.Perimetro),
				input.StartPoint,
				distanzaParete,
				distanzaMandataMandata,
				input.DrawSpiral,
				input.LineeCondizionamento,
				input.DistanzaCondizionamento,
				input.TerminalCenterline);
		}

		public static (List<Punto> spiral, List<List<Punto>> offsets) Generate(
			List<Punto> perimetro,
			Punto startPoint,
			double distanza,
			bool drawSpiral = true) =>
			GenerateCore(
				perimetro,
				startPoint,
				distanza,
				distanza,
				drawSpiral,
				null,
				0.0,
				false);

		private static (List<Punto> spiral, List<List<Punto>> offsets) GenerateCore(
			List<Punto> perimetro,
			Punto startPoint,
			double distanzaParete,
			double distanzaMandataMandata,
			bool drawSpiral,
			List<Punto> lineeCondizionamento,
			double distanzaCondizionamento,
			bool terminalCenterline)
		{
			List<Punto> spiral = new List<Punto>();
			bool usaCondizionamento =
				lineeCondizionamento != null &&
				lineeCondizionamento.Count >= 2 &&
				distanzaCondizionamento > 0;
			
			// Verifica e correggi il senso di rotazione (deve essere antiorario)
			perimetro = GeometryUtils.EnsureCounterClockwise(perimetro);

			List<List<Punto>> offsets = new List<List<Punto>>();
			offsets.Add(GeometryUtils.NormalizePolygon(new List<Punto>(perimetro)));

			// Genera offset successivi: il primo distacca la mandata dalla parete
			// di P/2; i successivi distanziano due mandate di 2P.
			for (int i = 0; i < 100; i++)
			{
				double distanzaOffset = i == 0
					? distanzaParete
					: distanzaMandataMandata;
				var previousOffset = i > 0 ? offsets[offsets.Count - 2] : perimetro;
				var nextOffset = ComputeOffset(offsets.Last(), previousOffset, distanzaOffset);

				if (nextOffset == null || nextOffset.Count < 3)
					break;
				
				// Correggi vertici che intersecano il perimetro precedente
				nextOffset = FixIntersections(nextOffset, offsets.Last(), distanzaOffset);
				
				double minEdgeLength = double.MaxValue;
				for (int j = 0; j < nextOffset.Count - 1; j++)
				{
					double edgeLen = nextOffset[j].DistanceTo(nextOffset[j + 1]);
					if (edgeLen < minEdgeLength)
						minEdgeLength = edgeLen;
				}
				if (minEdgeLength < distanzaMandataMandata && minEdgeLength > 0.2)
					break;
				if (minEdgeLength < distanzaMandataMandata * 1.2 && nextOffset.Count < 5)
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
			
			// Itera su tutti gli offset generati (dal primo all'ultimo).
			// La sequenza e la geometria restano quelle originali di Vittorio.
			bool stopPerCondizionamento = false;
			for (int offsetIdx = 1; offsetIdx < offsets.Count; offsetIdx++)
			{
				var currentOffset = offsets[offsetIdx];
				int puntiPrimaOffset = spiral.Count;
				
				// Trova intersezione con l'offset corrente dall'ultimo punto della spirale
				var ultimoPuntoSpiral = spiral[spiral.Count - 1];
				var (puntoIntersezione, startVertexIndex) = FindIntersectionWithOffset(ultimoPuntoSpiral, currentOffset);
				
				if (puntoIntersezione == null)
					break;	

				spiral.Add(puntoIntersezione);
				
				double distPuntoIntersezione = ultimoPuntoSpiral.DistanceTo(puntoIntersezione);
				
				if (distPuntoIntersezione > distanzaMandataMandata)
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
							if (dist < distanzaMandataMandata * 0.8 && dist > 0.01)
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
				
				// Se il raccordo storico verso l'offset attraversa la geometria
				// condizionante, il percorso indipendente si arresta qui.
				// Non si prova un gomito alternativo: quella sarebbe già una
				// strategia nuova, da discutere separatamente.
				if (usaCondizionamento &&
					!NuoviSegmentiRispettanoCondizionamento(
						spiral,
						puntiPrimaOffset,
						lineeCondizionamento,
						distanzaCondizionamento))
				{
					if (spiral.Count > puntiPrimaOffset)
						spiral.RemoveRange(
							puntiPrimaOffset,
							spiral.Count - puntiPrimaOffset);
					break;
				}

				// Segue tutti i vertici dell'offset corrente in ordine (senso antiorario)
				for (int i = 0; i < currentOffset.Count; i++)
				{
					int vertexIndex = (startVertexIndex + i) % currentOffset.Count;
					Punto candidato = currentOffset[vertexIndex];
					if (usaCondizionamento &&
						!SegmentoRispettaCondizionamento(
							spiral[spiral.Count - 1],
							candidato,
							lineeCondizionamento,
							distanzaCondizionamento))
					{
						stopPerCondizionamento = true;
						break;
					}
					spiral.Add(candidato);
				}

				if (stopPerCondizionamento)
					break;
				
				// Calcola punto finale
				Punto ultimoPunto;
				Punto penultimoPunto;

				double distanzaSegmento = puntoIntersezione.DistanceTo(spiral[spiral.Count - 1]);
				if (distanzaSegmento > 2 * distanzaMandataMandata) {
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
					ultimoPunto.X + direzione.X * distanzaMandataMandata,
					ultimoPunto.Y + direzione.Y * distanzaMandataMandata
				);
				if (usaCondizionamento &&
					!SegmentoRispettaCondizionamento(
						penultimoPunto,
						puntoFinale,
						lineeCondizionamento,
						distanzaCondizionamento))
				{
					// Nel ramo storico "corto" l'ultimo vertice era già stato
					// rimosso per essere sostituito da puntoFinale: se il gate lo
					// rifiuta lo ripristiniamo, senza inventare nuova geometria.
					if (spiral.Count > 0 &&
						spiral[spiral.Count - 1].DistanceTo(ultimoPunto) > 0.000001 &&
						ultimoPunto != puntoIntersezione)
					{
						spiral.Add(ultimoPunto);
					}
					break;
				}
				spiral.Add(puntoFinale);
			}

			// Estensione terminale sperimentale e ripristinabile: quando Vittorio
			// termina su un ultimo anello rettangolare lasciando ancora una fascia
			// centrale sfruttabile, prolunga la sola mandata con una piega a p e
			// un asse centrale. Non altera la generazione degli offset storici.
			if (terminalCenterline)
				TryAppendTerminalCenterline(spiral, offsets, distanzaMandataMandata);

			return (spiral, offsets);
		}

		private static void TryAppendTerminalCenterline(
			List<Punto> spiral,
			List<List<Punto>> offsets,
			double distanza)
		{
			if (spiral == null || spiral.Count < 2 || offsets == null || offsets.Count < 2)
				return;

			var ring = offsets[offsets.Count - 1];
			if (ring == null || ring.Count != 4)
				return;

			// Prima versione volutamente stretta: solo rettangoli ortogonali.
			const double tol = 0.001;
			for (int i = 0; i < 4; i++)
			{
				var a = ring[i];
				var b = ring[(i + 1) % 4];
				if (Math.Abs(a.X - b.X) > tol && Math.Abs(a.Y - b.Y) > tol)
					return;
			}

			double minX = ring.Min(p => p.X), maxX = ring.Max(p => p.X);
			double minY = ring.Min(p => p.Y), maxY = ring.Max(p => p.Y);
			double width = maxX - minX, height = maxY - minY;
			double shortSide = Math.Min(width, height);

			// Serve spazio per un asse centrale distante almeno p dai due rami
			// opposti; oltre 4p dovrebbe esistere un ulteriore anello completo e
			// non interveniamo per non mascherare altri problemi.
			if (shortSide < 2.0 * distanza - tol || shortSide >= 4.0 * distanza + tol)
				return;

			var last = spiral[spiral.Count - 1];
			var prev = spiral[spiral.Count - 2];
			bool lastVertical = Math.Abs(last.X - prev.X) < tol;
			bool lastHorizontal = Math.Abs(last.Y - prev.Y) < tol;
			if (!lastVertical && !lastHorizontal)
				return;

			double cx = (minX + maxX) / 2.0;
			double cy = (minY + maxY) / 2.0;
			Punto elbow;
			Punto terminal;

			if (lastVertical && width >= 2.0 * distanza - tol)
			{
				elbow = new Punto(cx, last.Y);
				double targetY = Math.Abs(last.Y - minY) < Math.Abs(last.Y - maxY)
					? maxY - distanza
					: minY + distanza;
				terminal = new Punto(cx, targetY);
			}
			else if (lastHorizontal && height >= 2.0 * distanza - tol)
			{
				elbow = new Punto(last.X, cy);
				double targetX = Math.Abs(last.X - minX) < Math.Abs(last.X - maxX)
					? maxX - distanza
					: minX + distanza;
				terminal = new Punto(targetX, cy);
			}
			else
				return;

			if (last.DistanceTo(elbow) < tol || elbow.DistanceTo(terminal) < tol)
				return;

			spiral.Add(elbow);
			spiral.Add(terminal);
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

		// Verifica i segmenti aggiunti dal raccordo storico verso un nuovo
		// offset. Il primo segmento parte dall'ultimo punto già esistente.
		private static bool NuoviSegmentiRispettanoCondizionamento(
			List<Punto> percorso,
			int puntiPrimaOffset,
			List<Punto> lineeCondizionamento,
			double distanzaMinima)
		{
			int primoIndiceNuovo = Math.Max(1, puntiPrimaOffset);
			for (int i = primoIndiceNuovo; i < percorso.Count; i++)
			{
				if (!SegmentoRispettaCondizionamento(
					percorso[i - 1],
					percorso[i],
					lineeCondizionamento,
					distanzaMinima))
				{
					return false;
				}
			}
			return true;
		}

		private static bool SegmentoRispettaCondizionamento(
			Punto inizio,
			Punto fine,
			List<Punto> lineeCondizionamento,
			double distanzaMinima)
		{
			const double tolleranza = 0.000001;
			for (int i = 0; i < lineeCondizionamento.Count - 1; i++)
			{
				if (DistanzaSegmenti(
					inizio,
					fine,
					lineeCondizionamento[i],
					lineeCondizionamento[i + 1]) <
					distanzaMinima - tolleranza)
				{
					return false;
				}
			}
			return true;
		}

		private static double DistanzaSegmenti(
			Punto a0,
			Punto a1,
			Punto b0,
			Punto b1)
		{
			if (SegmentiIntersecano(a0, a1, b0, b1))
				return 0.0;

			return Math.Min(
				Math.Min(
					GeometryUtils.DistancePointToSegment(a0, b0, b1),
					GeometryUtils.DistancePointToSegment(a1, b0, b1)),
				Math.Min(
					GeometryUtils.DistancePointToSegment(b0, a0, a1),
					GeometryUtils.DistancePointToSegment(b1, a0, a1)));
		}

		private static bool SegmentiIntersecano(
			Punto a0,
			Punto a1,
			Punto b0,
			Punto b1)
		{
			double o1 = Orientamento(a0, a1, b0);
			double o2 = Orientamento(a0, a1, b1);
			double o3 = Orientamento(b0, b1, a0);
			double o4 = Orientamento(b0, b1, a1);
			const double tolleranza = 0.000001;

			if (((o1 > tolleranza && o2 < -tolleranza) ||
				 (o1 < -tolleranza && o2 > tolleranza)) &&
				((o3 > tolleranza && o4 < -tolleranza) ||
				 (o3 < -tolleranza && o4 > tolleranza)))
			{
				return true;
			}

			return
				Math.Abs(o1) <= tolleranza && PuntoSulSegmento(b0, a0, a1) ||
				Math.Abs(o2) <= tolleranza && PuntoSulSegmento(b1, a0, a1) ||
				Math.Abs(o3) <= tolleranza && PuntoSulSegmento(a0, b0, b1) ||
				Math.Abs(o4) <= tolleranza && PuntoSulSegmento(a1, b0, b1);
		}

		private static double Orientamento(Punto a, Punto b, Punto c) =>
			(b.X - a.X) * (c.Y - a.Y) -
			(b.Y - a.Y) * (c.X - a.X);

		private static bool PuntoSulSegmento(Punto p, Punto a, Punto b)
		{
			const double tolleranza = 0.000001;
			return
				p.X >= Math.Min(a.X, b.X) - tolleranza &&
				p.X <= Math.Max(a.X, b.X) + tolleranza &&
				p.Y >= Math.Min(a.Y, b.Y) - tolleranza &&
				p.Y <= Math.Max(a.Y, b.Y) + tolleranza;
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