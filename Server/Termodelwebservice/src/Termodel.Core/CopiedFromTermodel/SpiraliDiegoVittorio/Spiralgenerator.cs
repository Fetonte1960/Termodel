// SpiralGenerator.cs
using System;
using System.Collections.Generic;
using System.Linq;

// Modificato da Codex per realizzare: isolare la copia sperimentale Diego_Vittorio mantenendo intatto il motore Vittorio.
namespace SpiralHeatingDiegoVittorio
{
	public enum LatoCollegamentoRitorno
	{
		Destro,
		Sinistro
	}

	public enum VersoRivoluzioneRitorno
	{
		Orario,
		Antiorario
	}

	public enum DirezioneSviluppoSpirale
	{
		EsternoVersoInterno,
		InternoVersoEsterno
	}

	public sealed class CollegamentoRitorno
	{
		public CollegamentoRitorno(
			Punto origine,
			Punto puntoInizialeRitorno,
			LatoCollegamentoRitorno lato,
			VersoRivoluzioneRitorno versoRivoluzione)
		{
			Origine = origine;
			PuntoInizialeRitorno = puntoInizialeRitorno;
			Lato = lato;
			VersoRivoluzione = versoRivoluzione;
		}

		public Punto Origine { get; }
		public Punto PuntoInizialeRitorno { get; }
		public LatoCollegamentoRitorno Lato { get; }
		public VersoRivoluzioneRitorno VersoRivoluzione { get; }

		public List<Punto> Punti => new List<Punto>
		{
			Origine,
			PuntoInizialeRitorno
		};
	}

	public static class SpiralGenerator
	{
		private const string TraceReturnEnvironmentVariable =
			"TERMODEL_DIEGO_VITTORIO_TRACE_RETURN";
		private const string CollinearAdjacencyEnvironmentVariable =
			"TERMODEL_DIEGO_VITTORIO_COLLINEAR_ADJACENCY";

		// Diagnostica pura: non modifica accettazione, tolleranze o geometria.
		private static bool TraceReturnEnabled
		{
			get
			{
				string value = Environment.GetEnvironmentVariable(
					TraceReturnEnvironmentVariable) ?? string.Empty;
				return value.Equals("true", StringComparison.OrdinalIgnoreCase) ||
					value.Equals("1", StringComparison.OrdinalIgnoreCase) ||
					value.Equals("yes", StringComparison.OrdinalIgnoreCase) ||
					value.Equals("on", StringComparison.OrdinalIgnoreCase);
			}
		}

		private static bool CollinearAdjacencyEnabled
		{
			get
			{
				string value = Environment.GetEnvironmentVariable(
					CollinearAdjacencyEnvironmentVariable) ?? string.Empty;
				if (string.IsNullOrWhiteSpace(value))
					return true;

				return !value.Equals("false", StringComparison.OrdinalIgnoreCase) &&
					!value.Equals("0", StringComparison.OrdinalIgnoreCase) &&
					!value.Equals("no", StringComparison.OrdinalIgnoreCase) &&
					!value.Equals("off", StringComparison.OrdinalIgnoreCase);
			}
		}

		// Funzione realizzata da Codex in autonomia
		public static CollegamentoRitorno GeneraCollegamentoRitorno(
			Punto puntoIngressoMandata,
			Punto primoPuntoInternoMandata,
			double distanzaTraIngressi,
			double profonditaCollegamento,
			LatoCollegamentoRitorno lato)
		{
			if (puntoIngressoMandata == null)
				throw new ArgumentNullException(nameof(puntoIngressoMandata));
			if (primoPuntoInternoMandata == null)
				throw new ArgumentNullException(nameof(primoPuntoInternoMandata));
			if (distanzaTraIngressi <= 0)
				throw new ArgumentOutOfRangeException(nameof(distanzaTraIngressi));
			if (profonditaCollegamento <= 0)
				throw new ArgumentOutOfRangeException(nameof(profonditaCollegamento));
			if (!Enum.IsDefined(typeof(LatoCollegamentoRitorno), lato))
				throw new ArgumentOutOfRangeException(nameof(lato));

			double dx = primoPuntoInternoMandata.X - puntoIngressoMandata.X;
			double dy = primoPuntoInternoMandata.Y - puntoIngressoMandata.Y;
			double lunghezzaDirezione = Math.Sqrt(dx * dx + dy * dy);
			if (lunghezzaDirezione <= 0.000001)
				throw new ArgumentException(
					"Il tratto d'ingresso della mandata deve definire una direzione valida.",
					nameof(primoPuntoInternoMandata));

			dx /= lunghezzaDirezione;
			dy /= lunghezzaDirezione;

			// Modificato da Codex per realizzare: costruire il tubo di ritorno
			// come parallelo gemello del tubo d'ingresso della mandata. Il lato
			// è riferito al verso esterno->interno del tratto d'ingresso.
			double normaleX = lato == LatoCollegamentoRitorno.Destro
				? dy
				: -dy;
			double normaleY = lato == LatoCollegamentoRitorno.Destro
				? -dx
				: dx;

			var radiceRitorno = new Punto(
				puntoIngressoMandata.X + normaleX * distanzaTraIngressi,
				puntoIngressoMandata.Y + normaleY * distanzaTraIngressi);
			var puntoInizialeRitorno = new Punto(
				radiceRitorno.X + dx * profonditaCollegamento,
				radiceRitorno.Y + dy * profonditaCollegamento);
			var verso = lato == LatoCollegamentoRitorno.Destro
				? VersoRivoluzioneRitorno.Antiorario
				: VersoRivoluzioneRitorno.Orario;

			return new CollegamentoRitorno(
				radiceRitorno,
				puntoInizialeRitorno,
				lato,
				verso);
		}

		// Funzione realizzata da Codex in autonomia
		public static (List<Punto> spiral, List<List<Punto>> offsets, CollegamentoRitorno collegamento) GenerateReturn(
			List<Punto> perimetro,
			List<Punto> mandata,
			double distanzaPareteMandata,
			double passo,
			LatoCollegamentoRitorno lato)
		{
			if (mandata == null || mandata.Count < 2)
				throw new ArgumentException(
					"La mandata deve contenere almeno due punti.",
					nameof(mandata));

			// Modificato da Codex per realizzare: il ritorno nasce dal parallelo
			// gemello del tubo d'ingresso della mandata, non dal suo terminale.
			// La radice è spostata lungo la parete di p; il raccordo parallelo
			// raggiunge la prima traccia a distanza parete p/2+p = 1,5p.
			CollegamentoRitorno collegamento = GeneraCollegamentoRitorno(
				mandata[0],
				mandata[1],
				passo,
				distanzaPareteMandata + passo,
				lato);
			// Modificato da Codex per realizzare: la geometria viene costruita
			// dall'ingresso verso il centro, cioè nel verso opposto al flusso
			// idraulico del ritorno (centro->uscita). La specifica pubblica del
			// verso resta quindi riferita al flusso reale.
			VersoRivoluzioneRitorno versoCostruzione =
				collegamento.VersoRivoluzione == VersoRivoluzioneRitorno.Orario
					? VersoRivoluzioneRitorno.Antiorario
					: VersoRivoluzioneRitorno.Orario;

			var perimetroNormalizzato = GeometryUtils.RoundAndSnapVertices(
				new List<Punto>(perimetro),
				2);
			if (perimetroNormalizzato.Count > 1 &&
				perimetroNormalizzato[0].DistanceTo(perimetroNormalizzato[^1]) < 0.001)
			{
				perimetroNormalizzato.RemoveAt(perimetroNormalizzato.Count - 1);
			}
			perimetroNormalizzato = GeometryUtils.RemoveCollinearVertices(
				perimetroNormalizzato);

			var risultato = Generate(
				perimetroNormalizzato,
				collegamento.PuntoInizialeRitorno,
				distanzaPareteMandata + passo,
				passo,
				true,
				versoCostruzione,
				DirezioneSviluppoSpirale.EsternoVersoInterno,
				collegamento.Punti,
				mandata,
				passo);

			// Modificato da Codex per realizzare: rendere verificabile la
			// parametrizzazione del ritorno nei test a passo diverso dal default.
			Console.WriteLine(
				$"  Ritorno parametrico: p={passo:0.###}; " +
				$"parete={distanzaPareteMandata + passo:0.###}; " +
				$"offset-utili={Math.Max(0, risultato.offsets.Count - 1)}; " +
				$"punti={risultato.spiral.Count}.");

			return (
				GeometryUtils.EliminaDuplicati(risultato.spiral),
				risultato.offsets,
				collegamento);
		}

		// Modificato da Codex per realizzare: separare il distacco iniziale
		// tubo-parete p/2 dal passo Supply-Supply 2p previsto dalle linee guida.
		public static (List<Punto> spiral, List<List<Punto>> offsets) Generate(
			List<Punto> perimetro,
			Punto startPoint,
			double distanzaParete,
			double passoMandata,
			bool drawSpiral = true,
			VersoRivoluzioneRitorno versoRivoluzione = VersoRivoluzioneRitorno.Antiorario,
			DirezioneSviluppoSpirale direzioneSviluppo = DirezioneSviluppoSpirale.EsternoVersoInterno,
			List<Punto> trattoIniziale = null,
			List<Punto> lineeCondizionamento = null,
			double distanzaCondizionamento = 0.0)
		{
			if (distanzaParete <= 0)
				throw new ArgumentOutOfRangeException(nameof(distanzaParete));
			if (passoMandata <= 0)
				throw new ArgumentOutOfRangeException(nameof(passoMandata));
			if (lineeCondizionamento != null &&
				lineeCondizionamento.Count >= 2 &&
				distanzaCondizionamento <= 0)
			{
				throw new ArgumentOutOfRangeException(nameof(distanzaCondizionamento));
			}

			List<Punto> spiral = new List<Punto>();
			
			// Verifica e correggi il senso di rotazione (deve essere antiorario)
			perimetro = GeometryUtils.EnsureCounterClockwise(perimetro);

			List<List<Punto>> offsets = new List<List<Punto>>();
			var offsetCalcoloCorrente =
				GeometryUtils.NormalizePolygon(new List<Punto>(perimetro));
			var offsetCalcoloPrecedente = new List<Punto>(perimetro);
			offsets.Add(offsetCalcoloCorrente);

			// Genera offset successivi
			for (int i = 0; i < 100; i++)
			{
				// Il primo offset nasce dall'architettura a p/2; tutti i
				// successivi appartengono alla mandata e avanzano di 2p.
				double distanzaOffset = i == 0
					? distanzaParete
					: passoMandata;
				var nextOffset = ComputeOffset(
					offsetCalcoloCorrente,
					offsetCalcoloPrecedente,
					distanzaOffset);

				if (nextOffset == null || nextOffset.Count < 3)
					break;
				
				// Correggi vertici che intersecano il perimetro precedente
				nextOffset = FixIntersections(
					nextOffset,
					offsetCalcoloCorrente,
					distanzaOffset);
				
				double minEdgeLength = double.MaxValue;
				for (int j = 0; j < nextOffset.Count - 1; j++)
				{
					double edgeLen = nextOffset[j].DistanceTo(nextOffset[j + 1]);
					if (edgeLen < minEdgeLength)
						minEdgeLength = edgeLen;
				}
				if (minEdgeLength < passoMandata && minEdgeLength > 0.2)
					break;
				if (minEdgeLength < passoMandata * 1.2 && nextOffset.Count < 5)
					break;
					
				var nextOffsetNormalizzato =
					GeometryUtils.NormalizePolygon(nextOffset);
				offsetCalcoloPrecedente = offsetCalcoloCorrente;
				offsetCalcoloCorrente = nextOffsetNormalizzato;

				// Modificato da Codex per realizzare: gli offset del ritorno
				// quasi coincidenti e paralleli alla mandata vengono scartati;
				// gli attraversamenti puntuali restano invece varchi da gestire
				// durante la percorrenza della polilinea.
				if (!OffsetHaTrattoParalleloTroppoVicino(
					nextOffsetNormalizzato,
					lineeCondizionamento,
					distanzaCondizionamento))
				{
					offsets.Add(nextOffsetNormalizzato);
				}
				//offsets.Add(nextOffset);

			}

			// Se non si deve disegnare la spirale, restituisci solo gli offset
			if (!drawSpiral)
				return (spiral, offsets);

			if (trattoIniziale != null && trattoIniziale.Count > 0)
				spiral.AddRange(GeometryUtils.EliminaDuplicati(trattoIniziale));
			else
				spiral.Add(startPoint);
			int puntiInizialiProtetti = spiral.Count;
			double distanzaAutocondizionamento =
				lineeCondizionamento != null && lineeCondizionamento.Count >= 2
					? passoMandata
					: 0.0;
			
			// Avanza perpendicolarmente fino al primo offset
			Punto puntoEsterno = startPoint;
			
			if (offsets.Count < 2)
				return (spiral, offsets);
			
			// Modificato da Codex per realizzare: la mandata percorre gli
			// offset dall'esterno all'interno; il ritorno autonomo li percorre
			// nell'ordine inverso partendo dal collegamento appena generato.
			var offsetsUtili = offsets.Skip(1).ToList();
			IEnumerable<List<Punto>> offsetsDaPercorrere = offsetsUtili;
			if (direzioneSviluppo == DirezioneSviluppoSpirale.InternoVersoEsterno)
			{
				int indiceIniziale = 0;
				double distanzaMigliore = double.MaxValue;
				for (int i = 0; i < offsetsUtili.Count; i++)
				{
					double distanza = DistanzaPuntoDaOffset(
						spiral[^1],
						offsetsUtili[i]);
					if (distanza < distanzaMigliore)
					{
						distanzaMigliore = distanza;
						indiceIniziale = i;
					}
				}

				offsetsDaPercorrere = offsetsUtili
					.Take(indiceIniziale + 1)
					.Reverse();
			}

			List<List<Punto>> offsetsPercorso = offsetsDaPercorrere.ToList();
			int indiceOffsetPercorso = 0;
			foreach (var currentOffset in offsetsPercorso)
			{
				indiceOffsetPercorso++;
				bool ultimoOffset = indiceOffsetPercorso == offsetsPercorso.Count;
				int puntiPrimaOffset = spiral.Count;
				// Trova un collegamento valido con l'offset corrente dall'ultimo punto della spirale.
				var ultimoPuntoSpiral = spiral[spiral.Count - 1];
				var (percorsoConnessione, puntoIntersezione, startVertexIndex) = FindConnectionWithOffset(
					ultimoPuntoSpiral,
					currentOffset,
					versoRivoluzione,
					passoMandata,
					lineeCondizionamento,
					distanzaCondizionamento,
					spiral,
					distanzaAutocondizionamento);
				
				if (percorsoConnessione == null || puntoIntersezione == null)
				{
					// Modificato da Codex per realizzare: diagnosticare un arresto
					// del ritorno parametrico senza alterare la geometria prodotta.
					if (lineeCondizionamento != null)
						Console.WriteLine($"  Ritorno: offset {indiceOffsetPercorso} senza collegamento valido.");
					continue;
				}

				foreach (Punto puntoConnessione in percorsoConnessione)
				{
					if (spiral[^1].DistanceTo(puntoConnessione) > 0.000001)
						spiral.Add(puntoConnessione);
				}
				int puntiDopoIntersezione = spiral.Count;
				
				// Segue i vertici nel verso richiesto e si arresta prima di un
				// tratto che violerebbe le linee di condizionamento.
				Punto candidatoTerminaleRespinto = null;
				for (int i = 0; i < currentOffset.Count; i++)
				{
					int delta = versoRivoluzione == VersoRivoluzioneRitorno.Antiorario
						? i
						: -i;
					int vertexIndex =
						(startVertexIndex + delta + currentOffset.Count) %
						currentOffset.Count;
					Punto candidato = currentOffset[vertexIndex];

					// Correzione locale DV-TEST-001: quando l'intersezione di
					// collegamento coincide già con il primo vertice dell'offset,
					// non esiste un nuovo segmento da validare. Trattare il punto
					// coincidente come un segmento di lunghezza zero può produrre
					// un falso rifiuto per autocondizionamento e far dichiarare
					// erroneamente l'offset "senza tratto percorribile".
					if (spiral[^1].DistanceTo(candidato) <= 0.000001)
					{
						if (TraceReturnEnabled)
						{
							Console.WriteLine(
								$"  DV_RETURN_SKIP_ZERO candidate=({candidato.X:R},{candidato.Y:R}).");
						}
						continue;
					}

					if (!SegmentoRispettaCondizionamento(
						spiral[^1],
						candidato,
						lineeCondizionamento,
						distanzaCondizionamento) ||
						!SegmentoRispettaSpirale(
							spiral[^1],
							candidato,
							spiral,
							distanzaAutocondizionamento))
					{
						// Modificato da Codex per realizzare: non perdere l'ultima
						// parte lecita del lato quando soltanto la sua estremità
						// invaderebbe la fascia di rispetto della mandata/ritorno.
						if (ultimoOffset)
							candidatoTerminaleRespinto = candidato;
						break;
					}
					spiral.Add(candidato);
				}

				// Modificato da Codex per realizzare: se sull'offset non è stato
				// accettato alcun tratto, ripristinare lo stato precedente. Senza
				// questa protezione il calcolo finale aggiungeva un falso segmento
				// all'indietro lungo il raccordo d'ingresso.
				if (spiral.Count == puntiDopoIntersezione)
				{
					if (lineeCondizionamento != null)
						Console.WriteLine($"  Ritorno: offset {indiceOffsetPercorso} senza tratto percorribile.");
					if (spiral.Count > puntiPrimaOffset)
						spiral.RemoveRange(
							puntiPrimaOffset,
							spiral.Count - puntiPrimaOffset);
					continue;
				}

				if (spiral.Count < 2)
					continue;
				
				// Calcola punto finale
				Punto ultimoPunto;
				Punto penultimoPunto;

				double distanzaSegmento = puntoIntersezione.DistanceTo(spiral[spiral.Count - 1]);
				bool sostituisceUltimoPunto = false;
				if (distanzaSegmento > 2 * passoMandata) {
					ultimoPunto = puntoIntersezione;
					penultimoPunto = spiral[spiral.Count - 1];
				}
				else {
					ultimoPunto = spiral[spiral.Count - 1];
					penultimoPunto = spiral[spiral.Count - 2];
					sostituisceUltimoPunto = true;
				}

				// Torna indietro di un passo mandata lungo l'ultimo segmento.
				var direzione = GeometryUtils.Normalize(new Punto(
					penultimoPunto.X - ultimoPunto.X,
					penultimoPunto.Y - ultimoPunto.Y
				));
				var puntoFinale = new Punto(
					ultimoPunto.X + direzione.X * passoMandata,
					ultimoPunto.Y + direzione.Y * passoMandata
				);
				bool finaleOriginaleAggiunto = false;
				if (SegmentoRispettaCondizionamento(
					penultimoPunto,
					puntoFinale,
					lineeCondizionamento,
					distanzaCondizionamento) &&
					SegmentoRispettaSpirale(
						penultimoPunto,
						puntoFinale,
						spiral,
						distanzaAutocondizionamento))
				{
					if (sostituisceUltimoPunto &&
						spiral.Count - 1 >= puntiInizialiProtetti)
						spiral.RemoveAt(spiral.Count - 1);
					spiral.Add(puntoFinale);
					finaleOriginaleAggiunto = true;
				}

				// Modificato da Codex per realizzare: prolungare l'ultimo lato
				// soltanto quando la finalizzazione storica non ha prodotto un
				// punto, preservando byte per byte i casi già validi.
				if (!finaleOriginaleAggiunto &&
					candidatoTerminaleRespinto != null)
				{
					Punto terminaleParziale = TrovaMassimoPrefissoValido(
						spiral[^1],
						candidatoTerminaleRespinto,
						lineeCondizionamento,
						distanzaCondizionamento,
						spiral,
						distanzaAutocondizionamento);
					if (terminaleParziale != null &&
						spiral[^1].DistanceTo(terminaleParziale) > 0.000001)
					{
						spiral.Add(terminaleParziale);
					}
				}
			}

			return (spiral, offsets);
		}

		// Funzione realizzata da Codex in autonomia
		private static double DistanzaPuntoDaOffset(
			Punto punto,
			List<Punto> offset)
		{
			double distanzaMinima = double.MaxValue;
			for (int i = 0; i < offset.Count; i++)
			{
				double distanza = GeometryUtils.DistancePointToSegment(
					punto,
					offset[i],
					offset[(i + 1) % offset.Count]);
				if (distanza < distanzaMinima)
					distanzaMinima = distanza;
			}

			return distanzaMinima;
		}

		// Funzione realizzata da Codex in autonomia
		private static (List<Punto> path, Punto intersection, int nextVertexIndex) FindConnectionWithOffset(
			Punto start,
			List<Punto> offset,
			VersoRivoluzioneRitorno versoRivoluzione,
			double passo,
			List<Punto> lineeCondizionamento,
			double distanzaCondizionamento,
			List<Punto> spiraleCorrente,
			double distanzaAutocondizionamento)
		{
			List<Punto> bestPath = null;
			Punto bestIntersection = null;
			int bestSegmentIndex = -1;
			double bestLength = double.MaxValue;
			const double tolleranza = 0.000001;
			
			// Modificato da Codex per realizzare: centralizzare la valutazione
			// dei collegamenti e consentire un fallback nei varchi della mandata.
			void ValutaPuntoOffset(Punto intersection, int segmentIndex)
			{
				var candidatePaths = new List<List<Punto>>();
				double directDistance = start.DistanceTo(intersection);
				if (directDistance <= passo + tolleranza)
				{
					candidatePaths.Add(new List<Punto> { intersection });
				}
				else
				{
					// Modificato da Codex per realizzare: esplorare entrambe le
					// connessioni ortogonali. Una diagonale può attraversare la
					// mandata anche quando esiste un percorso valido nel suo varco.
					candidatePaths.Add(new List<Punto>
					{
						new Punto(intersection.X, start.Y),
						intersection
					});
					candidatePaths.Add(new List<Punto>
					{
						new Punto(start.X, intersection.Y),
						intersection
					});

					// Modificato da Codex per realizzare: esplorare anche un
					// corridoio ortogonale a due gomiti quando i varchi della
					// mandata sono sfalsati. Il campionamento deriva da p/2.
					double passoCorridoio = Math.Max(passo / 2.0, tolleranza * 10.0);
					double minX = Math.Min(start.X, intersection.X);
					double maxX = Math.Max(start.X, intersection.X);
					for (double x = minX + passoCorridoio;
						x < maxX - tolleranza;
						x += passoCorridoio)
					{
						candidatePaths.Add(new List<Punto>
						{
							new Punto(x, start.Y),
							new Punto(x, intersection.Y),
							intersection
						});
					}

					double minY = Math.Min(start.Y, intersection.Y);
					double maxY = Math.Max(start.Y, intersection.Y);
					for (double y = minY + passoCorridoio;
						y < maxY - tolleranza;
						y += passoCorridoio)
					{
						candidatePaths.Add(new List<Punto>
						{
							new Punto(start.X, y),
							new Punto(intersection.X, y),
							intersection
						});
					}
				}

				foreach (List<Punto> rawPath in candidatePaths)
				{
					var path = new List<Punto>();
					Punto previous = start;
					foreach (Punto point in rawPath)
					{
						if (previous.DistanceTo(point) <= tolleranza)
							continue;
						path.Add(point);
						previous = point;
					}

					if (!ConnectionPathIsValid(
						start,
						path,
						lineeCondizionamento,
						distanzaCondizionamento,
						spiraleCorrente,
						distanzaAutocondizionamento))
					{
						continue;
					}

					double length = 0.0;
					previous = start;
					foreach (Punto point in path)
					{
						length += previous.DistanceTo(point);
						previous = point;
					}

					if (length < bestLength - tolleranza)
					{
						bestLength = length;
						bestPath = path;
						bestIntersection = intersection;
						bestSegmentIndex = segmentIndex;
					}
				}
			}

			for (int i = 0; i < offset.Count; i++)
			{
				var p1 = offset[i];
				var p2 = offset[(i + 1) % offset.Count];
				Punto intersection = GeometryUtils.ProjectPointOnSegment(start, p1, p2);
				if (intersection != null)
					ValutaPuntoOffset(intersection, i);
			}

			if (bestPath == null)
			{
				// Modificato da Codex per realizzare: se la proiezione più vicina
				// è ostruita, campionare l'offset ogni p/2 per trovare il varco
				// lasciato dalla mandata senza introdurre un albero combinatorio.
				double passoRicerca = Math.Max(passo / 2.0, tolleranza * 10.0);
				for (int i = 0; i < offset.Count; i++)
				{
					Punto p1 = offset[i];
					Punto p2 = offset[(i + 1) % offset.Count];
					double lunghezza = p1.DistanceTo(p2);
					if (lunghezza <= tolleranza)
						continue;

					double dx = (p2.X - p1.X) / lunghezza;
					double dy = (p2.Y - p1.Y) / lunghezza;
					for (double distanza = passoRicerca;
						distanza < lunghezza - tolleranza;
						distanza += passoRicerca)
					{
						ValutaPuntoOffset(
							new Punto(
								p1.X + dx * distanza,
								p1.Y + dy * distanza),
							i);
					}
				}
			}
			
			int nextVertex = bestSegmentIndex < 0
				? 0
				: versoRivoluzione == VersoRivoluzioneRitorno.Antiorario
					? (bestSegmentIndex + 1) % offset.Count
					: bestSegmentIndex;
			return (bestPath, bestIntersection, nextVertex);
		}

		// Funzione realizzata da Codex in autonomia
		private static bool ConnectionPathIsValid(
			Punto start,
			List<Punto> path,
			List<Punto> lineeCondizionamento,
			double distanzaCondizionamento,
			List<Punto> spiraleCorrente,
			double distanzaAutocondizionamento)
		{
			var temporarySpiral = spiraleCorrente == null
				? new List<Punto>()
				: new List<Punto>(spiraleCorrente);
			Punto previous = start;
			foreach (Punto point in path)
			{
				if (!SegmentoRispettaCondizionamento(
					previous,
					point,
					lineeCondizionamento,
					distanzaCondizionamento) ||
					!SegmentoRispettaSpirale(
						previous,
						point,
						temporarySpiral,
						distanzaAutocondizionamento))
				{
					return false;
				}

				if (temporarySpiral.Count == 0 ||
					temporarySpiral[^1].DistanceTo(point) > 0.000001)
				{
					temporarySpiral.Add(point);
				}
				previous = point;
			}

			return true;
		}

		// Funzione realizzata da Codex in autonomia
		private static bool SegmentoRispettaSpirale(
			Punto inizio,
			Punto fine,
			List<Punto> spiraleCorrente,
			double distanzaMinima)
		{
			if (spiraleCorrente == null ||
				spiraleCorrente.Count < 3 ||
				distanzaMinima <= 0)
			{
				return true;
			}

			const double tolleranza = 0.000001;
			// L'ultimo segmento è adiacente al candidato e condivide l'inizio.
			for (int i = 0; i < spiraleCorrente.Count - 2; i++)
			{
				// Correzione locale DV-TEST-001. Se il nuovo tratto prosegue
				// esattamente il tratto corrente, il segmento immediatamente
				// precedente resta topologicamente adiacente al gomito dopo la
				// fusione dei due segmenti collineari. Non deve quindi essere
				// trattato come ramo remoto del Return. Il comportamento è attivo
				// per default e resta disattivabile via flag per confronto/debug.
				if (CollinearAdjacencyEnabled &&
					i == spiraleCorrente.Count - 3 &&
					CandidatoProsegueUltimoSegmento(
						spiraleCorrente[^2],
						spiraleCorrente[^1],
						fine))
				{
					if (TraceReturnEnabled)
					{
						Console.WriteLine(
							$"  DV_RETURN_SKIP_COLLINEAR_ADJACENT obstacle={i} " +
							$"candidate=({inizio.X:R},{inizio.Y:R})->({fine.X:R},{fine.Y:R}).");
					}
					continue;
				}

				double distanza = DistanzaSegmenti(
					inizio,
					fine,
					spiraleCorrente[i],
					spiraleCorrente[i + 1]);
				if (distanza < distanzaMinima - tolleranza)
				{
					if (TraceReturnEnabled)
					{
						Console.WriteLine(
							$"  DV_RETURN_REJECT source=Self " +
							$"candidate=({inizio.X:R},{inizio.Y:R})->({fine.X:R},{fine.Y:R}) " +
							$"obstacle={i} " +
							$"segment=({spiraleCorrente[i].X:R},{spiraleCorrente[i].Y:R})->" +
							$"({spiraleCorrente[i + 1].X:R},{spiraleCorrente[i + 1].Y:R}) " +
							$"distance={distanza:R} required={distanzaMinima:R} " +
							$"tolerance={tolleranza:R} deficit={(distanzaMinima - distanza):R}.");
					}
					return false;
				}
			}

			return true;
		}

		private static bool CandidatoProsegueUltimoSegmento(
			Punto precedente,
			Punto corrente,
			Punto candidato)
		{
			const double tolleranza = 0.000001;
			double ax = corrente.X - precedente.X;
			double ay = corrente.Y - precedente.Y;
			double bx = candidato.X - corrente.X;
			double by = candidato.Y - corrente.Y;
			double lenA = Math.Sqrt(ax * ax + ay * ay);
			double lenB = Math.Sqrt(bx * bx + by * by);
			if (lenA <= tolleranza || lenB <= tolleranza)
				return false;

			double crossNormalizzato = Math.Abs(ax * by - ay * bx) / (lenA * lenB);
			double dot = ax * bx + ay * by;
			return crossNormalizzato <= tolleranza && dot > 0;
		}

		// Funzione realizzata da Codex in autonomia
		private static Punto TrovaMassimoPrefissoValido(
			Punto inizio,
			Punto fine,
			List<Punto> lineeCondizionamento,
			double distanzaCondizionamento,
			List<Punto> spiraleCorrente,
			double distanzaAutocondizionamento)
		{
			if (inizio == null || fine == null ||
				inizio.DistanceTo(fine) <= 0.000001)
			{
				return null;
			}

			double valido = 0.0;
			double nonValido = 1.0;
			for (int i = 0; i < 48; i++)
			{
				double t = (valido + nonValido) / 2.0;
				var candidato = new Punto(
					inizio.X + (fine.X - inizio.X) * t,
					inizio.Y + (fine.Y - inizio.Y) * t);
				bool accettato = SegmentoRispettaCondizionamento(
					inizio,
					candidato,
					lineeCondizionamento,
					distanzaCondizionamento) &&
					SegmentoRispettaSpirale(
						inizio,
						candidato,
						spiraleCorrente,
						distanzaAutocondizionamento);
				if (accettato)
					valido = t;
				else
					nonValido = t;
			}

			if (valido <= 0.000001)
				return null;

			return new Punto(
				inizio.X + (fine.X - inizio.X) * valido,
				inizio.Y + (fine.Y - inizio.Y) * valido);
		}

		// Funzione realizzata da Codex in autonomia
		private static bool OffsetHaTrattoParalleloTroppoVicino(
			List<Punto> offset,
			List<Punto> lineeCondizionamento,
			double distanzaMinima)
		{
			if (lineeCondizionamento == null ||
				lineeCondizionamento.Count < 2 ||
				distanzaMinima <= 0)
			{
				return false;
			}

			const double tolleranza = 0.000001;
			for (int i = 0; i < offset.Count; i++)
			{
				Punto a = offset[i];
				Punto b = offset[(i + 1) % offset.Count];
				double adx = b.X - a.X;
				double ady = b.Y - a.Y;
				double alen = Math.Sqrt(adx * adx + ady * ady);
				if (alen <= tolleranza)
					continue;

				Punto medio = new Punto(
					(a.X + b.X) / 2.0,
					(a.Y + b.Y) / 2.0);
				for (int j = 0; j < lineeCondizionamento.Count - 1; j++)
				{
					Punto c = lineeCondizionamento[j];
					Punto d = lineeCondizionamento[j + 1];
					double bdx = d.X - c.X;
					double bdy = d.Y - c.Y;
					double blen = Math.Sqrt(bdx * bdx + bdy * bdy);
					if (blen <= tolleranza)
						continue;

					double prodottoVettorialeNormalizzato =
						Math.Abs(adx * bdy - ady * bdx) /
						(alen * blen);
					if (prodottoVettorialeNormalizzato > 0.001)
						continue;

					double distanza = GeometryUtils.DistancePointToSegment(
						medio,
						c,
						d);
					if (distanza < distanzaMinima - tolleranza)
						return true;
				}
			}

			return false;
		}

		// Funzione realizzata da Codex in autonomia
		private static bool SegmentoRispettaCondizionamento(
			Punto inizio,
			Punto fine,
			List<Punto> lineeCondizionamento,
			double distanzaMinima)
		{
			if (lineeCondizionamento == null ||
				lineeCondizionamento.Count < 2 ||
				distanzaMinima <= 0)
			{
				return true;
			}

			const double tolleranza = 0.000001;
			for (int i = 0; i < lineeCondizionamento.Count - 1; i++)
			{
				double distanza = DistanzaSegmenti(
					inizio,
					fine,
					lineeCondizionamento[i],
					lineeCondizionamento[i + 1]);
				if (distanza < distanzaMinima - tolleranza)
				{
					if (TraceReturnEnabled)
					{
						Console.WriteLine(
							$"  DV_RETURN_REJECT source=Supply " +
							$"candidate=({inizio.X:R},{inizio.Y:R})->({fine.X:R},{fine.Y:R}) " +
							$"obstacle={i} " +
							$"segment=({lineeCondizionamento[i].X:R},{lineeCondizionamento[i].Y:R})->" +
							$"({lineeCondizionamento[i + 1].X:R},{lineeCondizionamento[i + 1].Y:R}) " +
							$"distance={distanza:R} required={distanzaMinima:R} " +
							$"tolerance={tolleranza:R} deficit={(distanzaMinima - distanza):R}.");
					}
					return false;
				}
			}

			return true;
		}

		// Funzione realizzata da Codex in autonomia
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

		// Funzione realizzata da Codex in autonomia
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

			return Math.Abs(o1) <= tolleranza && PuntoSulSegmento(b0, a0, a1) ||
				Math.Abs(o2) <= tolleranza && PuntoSulSegmento(b1, a0, a1) ||
				Math.Abs(o3) <= tolleranza && PuntoSulSegmento(a0, b0, b1) ||
				Math.Abs(o4) <= tolleranza && PuntoSulSegmento(a1, b0, b1);
		}

		// Funzione realizzata da Codex in autonomia
		private static double Orientamento(Punto a, Punto b, Punto c) =>
			(b.X - a.X) * (c.Y - a.Y) -
			(b.Y - a.Y) * (c.X - a.X);

		// Funzione realizzata da Codex in autonomia
		private static bool PuntoSulSegmento(Punto p, Punto a, Punto b)
		{
			const double tolleranza = 0.000001;
			return p.X >= Math.Min(a.X, b.X) - tolleranza &&
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
