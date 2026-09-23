// SpiralGenerator.cs
using System;
using System.Collections.Generic;
using System.Linq;
using NetTopologySuite;
using NetTopologySuite.Geometries;
using NetTopologySuite.Operation.Buffer;

// Modificato da Codex per realizzare: separare il motore GPT dal sorgente originale di Vittorio.
namespace SpiralHeatingGPT
{
	public static class SpiralGenerator
	{
		public static (List<Punto> spiral, List<List<Punto>> offsets) Generate(
			List<Punto> perimetro,
			Punto startPoint,
			double distanza,
			bool drawSpiral = true,
			bool antiorario = true,
			IReadOnlyList<Punto> ostacolo = null,
			int varianteTaglio = 0)
		{
			// Modificato da Codex per realizzare: provare entrambe le direzioni
			// di percorrenza quando mandata e ritorno vengono accoppiati.
			return GenerateConParametri(
				perimetro,
				startPoint,
				distanza,
				distanza,
				drawSpiral,
				antiorario,
				ostacolo,
				varianteTaglio,
				false,
				null);
		}

		// Funzione realizzata da Codex in autonomia
		/// <summary>
		/// Genera una famiglia di anelli distinguendo la distanza del primo
		/// asse dalla parete dal passo fra due anelli dello stesso tubo.
		/// </summary>
		public static (List<Punto> spiral, List<List<Punto>> offsets)
			GenerateConPassoAnelli(
				List<Punto> perimetro,
				Punto startPoint,
				double distanzaParete,
				double passoAnelli,
				bool drawSpiral = true,
				bool antiorario = true,
				IReadOnlyList<Punto> ostacolo = null,
				int varianteTaglio = 0,
				bool consentiPrimoRaccordoNelVarco = false,
				Punto direzionePrimoRaccordo = null)
		{
			// Modificato da Codex per realizzare: il solo tubo di mandata può
			// attraversare al primo passo l'intaglio prodotto dal proprio asse
			// di collegamento. Gli anelli successivi restano sempre confinati.
			return GenerateConParametri(
				perimetro,
				startPoint,
				distanzaParete,
				passoAnelli,
				drawSpiral,
				antiorario,
				ostacolo,
				varianteTaglio,
				consentiPrimoRaccordoNelVarco,
				direzionePrimoRaccordo);
		}

		// Funzione realizzata da Codex in autonomia
		/// <summary>
		/// Genera la guida del ritorno con il primo asse tubo a metà
		/// passo dalla parete e con gli anelli successivi distanziati del
		/// passo fra anelli dello stesso tubo.
		/// Il percorso restituito parte dalla parete e procede verso il
		/// centro; il chiamante lo inverte per ottenere il verso di ritorno.
		/// </summary>
		public static (List<Punto> spiral, List<List<Punto>> offsets)
			GenerateGuidaRitorno(
				List<Punto> perimetro,
				Punto startPoint,
				double distanzaParete,
				double passo,
				bool drawSpiral = true,
				bool antiorario = true,
				int varianteTaglio = 0)
		{
			return GenerateConParametri(
				perimetro,
				startPoint,
				distanzaParete,
				passo,
				drawSpiral,
				antiorario,
				null,
				varianteTaglio,
				false,
				null);
		}

		// Funzione realizzata da Codex in autonomia
		private static (List<Punto> spiral, List<List<Punto>> offsets)
			GenerateConParametri(
				List<Punto> perimetro,
				Punto startPoint,
				double distanzaParete,
				double passo,
			bool drawSpiral,
			bool antiorario,
			IReadOnlyList<Punto> ostacolo,
			int varianteTaglio,
			bool consentiPrimoRaccordoNelVarco,
			Punto direzionePrimoRaccordo)
		{
			List<Punto> spiral = new List<Punto>();
			
			// Verifica e correggi il senso di rotazione (deve essere antiorario)
			perimetro = GeometryUtils.EnsureCounterClockwise(perimetro);

			List<List<Punto>> offsets = new List<List<Punto>>();
			// Modificato da Codex per realizzare: conservare anche i lati inclinati
			// del locale nel motore GPT, senza forzarli sugli assi cartesiani.
			offsets.Add(GeometryUtils.EnsureCounterClockwise(
				new List<Punto>(perimetro)));

			double minArea = passo * passo;
			List<Punto> offsetPrecedente = offsets[0];
			double distanzaPrecedente = 0.0;

			// Genera offset successivi
			for (int i = 0; i < 100; i++)
			{
				double distanzaCorrente = distanzaParete + i * passo;
				// Modificato da Codex per realizzare: campionare gli offset
				// intermedi per rilevare una separazione topologica anche quando
				// cade fra due passi nominali; il chiamante si arresta prima della
				// strettoia invece di scegliere silenziosamente una delle isole.
				var nextOffset = ComputeOffsetConContinuita(
					perimetro,
					offsetPrecedente,
					distanzaPrecedente,
					distanzaCorrente,
					passo / 4.0,
					out bool separazioneRilevata);

				if (nextOffset == null || nextOffset.Count < 3)
					break;

				if (GeometryUtils.ComputeArea(nextOffset) < minArea)
					break;

				// Modificato da Codex per realizzare: una separazione topologica
				// non arresta globalmente il tubo. ComputeOffsetConContinuita ha
				// già scelto la componente annidata e continua; il successivo
				// raccordo decide in modo indipendente se quel tubo può entrarvi.
				if (separazioneRilevata)
				{
					Console.WriteLine(
						$"  Strettoia topologica a {distanzaCorrente:F2} m: " +
						"prosegue la componente continua");
				}
					
				offsets.Add(nextOffset);
				offsetPrecedente = nextOffset;
				distanzaPrecedente = distanzaCorrente;

			}

			// Modificato da Codex per realizzare: percorrere gli stessi offset
			// anche in senso inverso senza alterarne la costruzione geometrica.
			if (!antiorario)
			{
				foreach (List<Punto> offset in offsets)
					offset.Reverse();
			}

			// Se non si deve disegnare la spirale, restituisci solo gli offset
			if (!drawSpiral)
				return (spiral, offsets);

			spiral.Add(startPoint);
			
			if (offsets.Count < 2)
				return (spiral, offsets);
			
			// Modificato da Codex per realizzare: aprire ciascun offset con un
			// taglio misurato lungo tutto il contorno. Il precedente arretramento
			// sul solo ultimo lato, unito ai raccordi cartesiani a L, produceva
			// doppie S e attraversamenti nei profili concavi e obliqui.
			for (int offsetIdx = 1; offsetIdx < offsets.Count; offsetIdx++)
			{
				var currentOffset = offsets[offsetIdx];
				var ultimoPuntoSpiral = spiral[spiral.Count - 1];
				double distanzaOffsetCorrente =
					distanzaParete + (offsetIdx - 1) * passo;
				var (puntoIntersezione, startVertexIndex, puntoGomito) =
					ScegliTaglioOffset(
						ultimoPuntoSpiral,
						currentOffset,
						spiral,
						perimetro,
						ostacolo,
						passo,
						distanzaOffsetCorrente,
						offsetIdx == 1 ? distanzaParete : passo,
						varianteTaglio,
						offsetIdx == 1 &&
							consentiPrimoRaccordoNelVarco,
						offsetIdx == 1
							? direzionePrimoRaccordo
							: null);
				
				if (puntoIntersezione == null)
				{
					// Modificato da Codex per realizzare: una strozzatura
					// non superabile arresta soltanto questo percorso; gli
					// offset già coperti restano validi e vengono conservati.
					Console.WriteLine(
						$"  Strozzatura: arresto prima dell'offset {offsetIdx}");
					break;
				}

				if (puntoGomito != null &&
					ultimoPuntoSpiral.DistanceTo(puntoGomito) > 0.000001)
				{
					spiral.Add(puntoGomito);
				}

				if (spiral[spiral.Count - 1]
					.DistanceTo(puntoIntersezione) > 0.000001)
					spiral.Add(puntoIntersezione);

				AggiungiOffsetAperto(
					spiral,
					currentOffset,
					puntoIntersezione,
					startVertexIndex,
					passo);
			}

			return (spiral, offsets);
		}

		// Funzione realizzata da Codex in autonomia
		private static void AggiungiOffsetAperto(
			List<Punto> spirale,
			List<Punto> offset,
			Punto taglio,
			int primoVertice,
			double apertura)
		{
			if (spirale == null || offset == null || offset.Count < 3 ||
				taglio == null)
			{
				return;
			}

			var ciclo = new List<Punto> { taglio };
			for (int i = 0; i < offset.Count; i++)
				ciclo.Add(offset[(primoVertice + i) % offset.Count]);
			ciclo.Add(taglio);

			double lunghezza = 0.0;
			for (int i = 0; i < ciclo.Count - 1; i++)
				lunghezza += ciclo[i].DistanceTo(ciclo[i + 1]);

			double obiettivo = Math.Max(
				0.0,
				lunghezza - Math.Min(apertura, lunghezza * 0.35));
			double percorsa = 0.0;

			for (int i = 0; i < ciclo.Count - 1; i++)
			{
				Punto a = ciclo[i];
				Punto b = ciclo[i + 1];
				double tratto = a.DistanceTo(b);
				if (tratto <= 0.000001)
					continue;

				if (percorsa + tratto <= obiettivo + 0.000001)
				{
					if (spirale[spirale.Count - 1].DistanceTo(b) > 0.000001)
						spirale.Add(b);
					percorsa += tratto;
					continue;
				}

				double residuo = Math.Max(0.0, obiettivo - percorsa);
				double frazione = Math.Min(1.0, residuo / tratto);
				var finale = new Punto(
					a.X + (b.X - a.X) * frazione,
					a.Y + (b.Y - a.Y) * frazione);
				if (spirale[spirale.Count - 1].DistanceTo(finale) > 0.000001)
					spirale.Add(finale);
				break;
			}
		}

		// Funzione realizzata da Codex in autonomia
		/// <summary>
		/// Segue per continuità una componente dell'offset tra due distanze.
		/// Campiona anche le distanze intermedie per rilevare separazioni che non
		/// coincidono col passo nominale della spirale.
		/// </summary>
		private static List<Punto> ComputeOffsetConContinuita(
			List<Punto> perimetro,
			List<Punto> componentePrecedente,
			double distanzaIniziale,
			double distanzaFinale,
			double passoCampionamento,
			out bool separazioneRilevata)
		{
			separazioneRilevata = false;
			if (componentePrecedente == null ||
				componentePrecedente.Count < 3 ||
				distanzaFinale <= distanzaIniziale)
			{
				return null;
			}

			double intervallo = distanzaFinale - distanzaIniziale;
			int campioni = Math.Max(
				1,
				(int)Math.Ceiling(intervallo /
					Math.Max(0.01, passoCampionamento)));
			List<Punto> componenteCorrente = componentePrecedente;

			for (int i = 1; i <= campioni; i++)
			{
				double distanza = distanzaIniziale +
					intervallo * i / campioni;
				List<List<Punto>> componenti = ComputeOffsetRobusti(
					perimetro,
					distanza);
				if (componenti.Count == 0)
					return null;

				if (componenti.Count > 1)
					separazioneRilevata = true;

				List<Punto> scelta = SelezionaComponenteContinua(
					componenti,
					componenteCorrente);
				if (scelta == null)
					return null;

				componenteCorrente = scelta;
			}

			return componenteCorrente;
		}

		// Funzione realizzata da Codex in autonomia
		private static List<Punto> SelezionaComponenteContinua(
			List<List<Punto>> componenti,
			List<Punto> componentePrecedente)
		{
			// Modificato da Codex per realizzare: dopo una biforcazione si
			// conserva il ramo continuo con superficie utile maggiore. Un
			// collo troppo piccolo viene attraversato come tratto di transito
			// e non scelto come zona di copertura.
			return componenti
				.Where(c => c != null && c.Count >= 3)
				.Where(c => ComponenteContenutaInPrecedente(
					c,
					componentePrecedente))
				.OrderByDescending(GeometryUtils.ComputeArea)
				.FirstOrDefault();
		}

		// Funzione realizzata da Codex in autonomia
		private static bool ComponenteContenutaInPrecedente(
			List<Punto> componente,
			List<Punto> precedente)
		{
			if (precedente == null || precedente.Count < 3)
				return false;

			// Gli offset interni sono geometricamente annidati. Si provano più
			// vertici per non dipendere da un singolo punto quasi sul bordo.
			int passo = Math.Max(1, componente.Count / 4);
			for (int i = 0; i < componente.Count; i += passo)
			{
				if (GeometryUtils.IsInsidePolygon(componente[i], precedente))
					return true;
			}
			return false;
		}

		// Funzione realizzata da Codex in autonomia
		/// <summary>
		/// Calcola tutte le componenti polygonali dell'offset interno. Le isole
		/// non vengono più confuse con un errore geometrico: la scelta della
		/// componente continua è demandata al tracciamento progressivo.
		/// </summary>
		private static List<List<Punto>> ComputeOffsetRobusti(
			List<Punto> perimetro,
			double distanzaTotale)
		{
			var risultati = new List<List<Punto>>();
			if (perimetro == null || perimetro.Count < 3 || distanzaTotale <= 0)
				return risultati;

			var coordinate = perimetro
				.Select(p => new Coordinate(p.X, p.Y))
				.ToList();

			if (!coordinate[0].Equals2D(coordinate[coordinate.Count - 1]))
				coordinate.Add(new Coordinate(coordinate[0]));

			var factory = NtsGeometryServices.Instance.CreateGeometryFactory();
			Geometry geometria = factory.CreatePolygon(
				factory.CreateLinearRing(coordinate.ToArray()));

			if (!geometria.IsValid)
				geometria = geometria.Buffer(0);

			var parametri = new BufferParameters(
				1,
				EndCapStyle.Flat,
				JoinStyle.Mitre,
				5.0);
			Geometry offset = BufferOp.Buffer(
				geometria,
				-distanzaTotale,
				parametri);

			if (offset == null || offset.IsEmpty)
				return risultati;

			if (offset is Polygon poligono)
			{
				AggiungiComponenteOffset(risultati, poligono);
			}
			else if (offset is MultiPolygon multipoligono)
			{
				for (int i = 0; i < multipoligono.NumGeometries; i++)
				{
					if (multipoligono.GetGeometryN(i) is Polygon componente)
						AggiungiComponenteOffset(risultati, componente);
				}
			}

			return risultati;
		}

		// Funzione realizzata da Codex in autonomia
		private static void AggiungiComponenteOffset(
			List<List<Punto>> risultati,
			Polygon poligono)
		{
			var punti = poligono.ExteriorRing.Coordinates
				.Take(poligono.ExteriorRing.Coordinates.Length - 1)
				.Select(c => new Punto(c.X, c.Y))
				.ToList();
			punti = GeometryUtils.RemoveCollinearVertices(punti, 0.000001);
			if (punti.Count >= 3)
			{
				risultati.Add(
					GeometryUtils.EnsureCounterClockwise(punti));
			}
		}

		// Funzione realizzata da Codex in autonomia
		private static (
			Punto intersection,
			int nextVertexIndex,
			Punto intermediate)
			ScegliTaglioOffset(
				Punto partenza,
				List<Punto> offset,
				List<Punto> percorsoEsistente,
				List<Punto> perimetro,
			IReadOnlyList<Punto> ostacolo,
			double passo,
			double distanzaOffsetCorrente,
			double distanzaMinimaRaccordo,
			int varianteTaglio,
			bool consentiRaccordoNelVarco,
			Punto direzioneRaccordo)
		{
			// Modificato da Codex per realizzare: conservare tutti i tagli
			// geometricamente validi. Il chiamante può così cambiare fase agli
			// anelli interni senza accorciarli o rinunciare alla copertura.
			var candidatiValidi = new List<(
				Punto Punto,
				int Vertice,
				Punto Gomito,
				double Punteggio)>();
			// Modificato da Codex per realizzare: rendere diagnosticabile lo
			// scarto di tutti i passaggi candidati nelle strettoie.
			int scartiProiezione = 0;
			int scartiPerimetro = 0;
			int scartiCorridoio = 0;
			int scartiAutoIntersezione = 0;
			int scartiOstacolo = 0;
			int scartiSviluppo = 0;
			List<Punto> ostacoloArrotondato =
				ostacolo != null && ostacolo.Count >= 2
					? GeometryUtils.ArrotondaSpirale(
						new List<Punto>(ostacolo),
						Math.Min(0.10, passo / 3.0))
					: null;

			for (int i = 0; i < offset.Count; i++)
			{
				// Modificato da Codex per realizzare: nel varco d'ingresso la
				// mandata deve proseguire lungo il proprio asse fino all'offset.
				// Sugli anelli interni resta invece obbligatoria la proiezione
				// ortogonale locale già usata per evitare raccordi diagonali.
				Punto candidato;
				Punto gomito = null;
				if (consentiRaccordoNelVarco && direzioneRaccordo != null)
				{
					candidato = IntersezioneRaggioSegmento(
						partenza,
						direzioneRaccordo,
						offset[i],
						offset[(i + 1) % offset.Count]);
					if (candidato == null)
					{
						// Modificato da Codex per realizzare: se la linguetta
						// d'ingresso scompare prima dell'offset, si raggiunge il
						// punto più vicino con due tratti ortogonali e non con una
						// diagonale.
						candidato = PuntoPiuVicinoSulSegmento(
							partenza,
							offset[i],
							offset[(i + 1) % offset.Count]);
						gomito = CreaGomitoSuRaggio(
							partenza,
							direzioneRaccordo,
							candidato);
					}
				}
				else
				{
					candidato = ProiettaSulSegmento(
						partenza,
						offset[i],
						offset[(i + 1) % offset.Count]);
				}
				if (candidato == null)
				{
					scartiProiezione++;
					continue;
				}
				// Modificato da Codex per realizzare: il tratto radiale deve
				// raggiungere interamente il nuovo offset. Un tratto più corto
				// non supera la corsia del tubo alternato e genera una successiva
				// diagonale di recupero.
				double tolleranzaSviluppo = Math.Max(0.01, passo * 0.04);
				double sviluppoAssiale = gomito != null
					? partenza.DistanceTo(gomito)
					: partenza.DistanceTo(candidato);
				if (sviluppoAssiale <
					distanzaMinimaRaccordo - tolleranzaSviluppo)
				{
					scartiSviluppo++;
					continue;
				}
				// Modificato da Codex per realizzare: nessun limite metrico
				// arbitrario sul tratto di transito attraverso una strettoia.
				// I controlli seguenti ne verificano interamente la geometria.
				// Modificato da Codex per realizzare: il primo tratto della
				// mandata nasce sulla parete reale e percorre il varco scavato dal
				// proprio collegamento. Solo in quel tratto l'esterno del perimetro
				// tecnico è quindi ammesso intenzionalmente.
				if (!consentiRaccordoNelVarco &&
					!SegmentoInternoAlPerimetro(
					partenza,
					candidato,
					perimetro))
				{
					scartiPerimetro++;
					continue;
				}
				if (!consentiRaccordoNelVarco &&
					!SegmentoNelCorridoioOffset(
						partenza,
						candidato,
						perimetro,
						distanzaOffsetCorrente,
						passo))
				{
					scartiCorridoio++;
					continue;
				}

				var prova = new List<Punto>(percorsoEsistente);
				if (gomito != null &&
					prova[prova.Count - 1].DistanceTo(gomito) > 0.000001)
				{
					prova.Add(gomito);
				}
				if (prova[prova.Count - 1].DistanceTo(candidato) > 0.000001)
					prova.Add(candidato);
				AggiungiOffsetAperto(
					prova,
					offset,
					candidato,
					(i + 1) % offset.Count,
					passo);

				double raggioVerifica = Math.Min(0.10, passo / 3.0);
				List<Punto> provaArrotondata =
					GeometryUtils.ArrotondaSpirale(
						prova,
						raggioVerifica);
				int autoIntersezioni = ContaAutoIntersezioniProprie(
					provaArrotondata);
				if (autoIntersezioni > 0)
				{
					scartiAutoIntersezione++;
					continue;
				}

				double distanzaOstacolo = double.PositiveInfinity;
				if (ostacoloArrotondato != null)
				{
					int incrociOstacolo = ContaIntersezioniProprie(
						provaArrotondata,
						ostacoloArrotondato);
					if (incrociOstacolo > 0)
					{
						scartiOstacolo++;
						continue;
					}

					distanzaOstacolo = DistanzaMinimaPolilinee(
						provaArrotondata,
						ostacoloArrotondato);
					double spazioRichiesto = passo / 2.0;
					double tolleranza = Math.Max(0.005, passo * 0.02);
					if (distanzaOstacolo < spazioRichiesto - tolleranza)
					{
						scartiOstacolo++;
						continue;
					}
				}

				// La copertura è indipendente: fra i soli passaggi validi
				// viene preferita la transizione locale più corta. Se non
				// esiste alcun candidato, il chiamante arresta questa spirale.
				double punteggio = sviluppoAssiale +
					(gomito != null ? gomito.DistanceTo(candidato) : 0.0);
				if (!double.IsPositiveInfinity(distanzaOstacolo))
					punteggio -= Math.Min(distanzaOstacolo, passo) * 0.01;

				candidatiValidi.Add((
					candidato,
					(i + 1) % offset.Count,
					gomito,
					punteggio));
			}

			if (candidatiValidi.Count == 0)
			{
#if SPIRALI_GPT_AUTOTEST
				// Modificato da Codex per realizzare: diagnostica disponibile solo
				// nell'eseguibile di autotest per analizzare il varco iniziale.
				if (consentiRaccordoNelVarco && direzioneRaccordo != null)
				{
					Console.WriteLine(
						$"    Varco: origine=({partenza.X:F3},{partenza.Y:F3}), " +
						$"direzione=({direzioneRaccordo.X:F3},{direzioneRaccordo.Y:F3}), " +
						$"offset X=[{offset.Min(p => p.X):F3},{offset.Max(p => p.X):F3}] " +
						$"Y=[{offset.Min(p => p.Y):F3},{offset.Max(p => p.Y):F3}]");
				}
#endif
				Console.WriteLine(
					$"    Taglio rifiutato: proiezione={scartiProiezione}, " +
					$"perimetro={scartiPerimetro}, " +
					$"corridoio={scartiCorridoio}, " +
					$"sviluppo={scartiSviluppo}, " +
					$"autoIntersezione={scartiAutoIntersezione}, " +
					$"ostacolo={scartiOstacolo}");
				return (null, -1, null);
			}

			var ordinati = candidatiValidi
				.OrderBy(c => c.Punteggio)
				.ThenBy(c => c.Vertice)
				.ToList();
			int indiceVariante = Math.Min(
				Math.Max(0, varianteTaglio),
				ordinati.Count - 1);
			var scelto = ordinati[indiceVariante];
			return (scelto.Punto, scelto.Vertice, scelto.Gomito);
		}

		// Funzione realizzata da Codex in autonomia
		private static Punto PuntoPiuVicinoSulSegmento(
			Punto punto,
			Punto inizio,
			Punto fine)
		{
			if (punto == null || inizio == null || fine == null)
				return null;

			double dx = fine.X - inizio.X;
			double dy = fine.Y - inizio.Y;
			double lunghezzaQuadrata = dx * dx + dy * dy;
			if (lunghezzaQuadrata <= 0.000000001)
				return null;

			double parametro =
				((punto.X - inizio.X) * dx +
				 (punto.Y - inizio.Y) * dy) /
				lunghezzaQuadrata;
			parametro = Math.Max(0.0, Math.Min(1.0, parametro));
			return new Punto(
				inizio.X + parametro * dx,
				inizio.Y + parametro * dy);
		}

		// Funzione realizzata da Codex in autonomia
		private static Punto CreaGomitoSuRaggio(
			Punto origine,
			Punto direzione,
			Punto destinazione)
		{
			if (origine == null || direzione == null || destinazione == null)
				return null;

			double lunghezzaQuadrata =
				direzione.X * direzione.X +
				direzione.Y * direzione.Y;
			if (lunghezzaQuadrata <= 0.000000001)
				return null;

			double parametro =
				((destinazione.X - origine.X) * direzione.X +
				 (destinazione.Y - origine.Y) * direzione.Y) /
				lunghezzaQuadrata;
			if (parametro < -0.000001)
				return null;

			parametro = Math.Max(0.0, parametro);
			return new Punto(
				origine.X + parametro * direzione.X,
				origine.Y + parametro * direzione.Y);
		}

		// Funzione realizzata da Codex in autonomia
		private static Punto IntersezioneRaggioSegmento(
			Punto origine,
			Punto direzione,
			Punto inizio,
			Punto fine)
		{
			if (origine == null || direzione == null ||
				inizio == null || fine == null)
			{
				return null;
			}

			double rx = direzione.X;
			double ry = direzione.Y;
			double sx = fine.X - inizio.X;
			double sy = fine.Y - inizio.Y;
			double denominatore = rx * sy - ry * sx;
			if (Math.Abs(denominatore) <= 0.000000001)
				return null;

			double qx = inizio.X - origine.X;
			double qy = inizio.Y - origine.Y;
			double parametroRaggio = (qx * sy - qy * sx) / denominatore;
			double parametroSegmento = (qx * ry - qy * rx) / denominatore;
			const double tolleranza = 0.000001;
			if (parametroRaggio < -tolleranza ||
				parametroSegmento < -tolleranza ||
				parametroSegmento > 1.0 + tolleranza)
			{
				return null;
			}

			parametroRaggio = Math.Max(0.0, parametroRaggio);
			return new Punto(
				origine.X + parametroRaggio * rx,
				origine.Y + parametroRaggio * ry);
		}

		// Funzione realizzata da Codex in autonomia
		private static Punto ProiettaSulSegmento(
			Punto punto,
			Punto inizio,
			Punto fine)
		{
			double dx = fine.X - inizio.X;
			double dy = fine.Y - inizio.Y;
			double lunghezzaQuadrata = dx * dx + dy * dy;
			if (lunghezzaQuadrata <= 0.000000001)
				return null;

			double parametro =
				((punto.X - inizio.X) * dx +
				 (punto.Y - inizio.Y) * dy) /
				lunghezzaQuadrata;
			// Modificato da Codex per realizzare: il raccordo fra due anelli
			// deve raggiungere ortogonalmente il segmento successivo. Bloccare
			// la proiezione su un estremo produceva i tratti inclinati visibili
			// nel rettangolo standard; quel caso ora viene rifiutato.
			const double tolleranzaParametro = 0.000001;
			if (parametro < -tolleranzaParametro ||
				parametro > 1.0 + tolleranzaParametro)
			{
				return null;
			}
			parametro = Math.Max(0.0, Math.Min(1.0, parametro));
			return new Punto(
				inizio.X + parametro * dx,
				inizio.Y + parametro * dy);
		}

		// Funzione realizzata da Codex in autonomia
		private static bool SegmentoNelCorridoioOffset(
			Punto inizio,
			Punto fine,
			IReadOnlyList<Punto> perimetro,
			double distanzaOffsetCorrente,
			double passo)
		{
			if (perimetro == null || perimetro.Count < 3)
				return false;

			const int campioni = 16;
			double tolleranza = Math.Max(0.01, passo * 0.08);
			for (int i = 1; i < campioni; i++)
			{
				double t = (double)i / campioni;
				var punto = new Punto(
					inizio.X + (fine.X - inizio.X) * t,
					inizio.Y + (fine.Y - inizio.Y) * t);
				double distanzaParete = DistanzaDalPerimetro(
					punto,
					perimetro);
				if (distanzaParete >
					distanzaOffsetCorrente + tolleranza)
				{
					return false;
				}
			}

			return true;
		}

		// Funzione realizzata da Codex in autonomia
		private static double DistanzaDalPerimetro(
			Punto punto,
			IReadOnlyList<Punto> perimetro)
		{
			double minima = double.PositiveInfinity;
			for (int i = 0; i < perimetro.Count; i++)
			{
				minima = Math.Min(
					minima,
					GeometryUtils.DistancePointToSegment(
						punto,
						perimetro[i],
						perimetro[(i + 1) % perimetro.Count]));
			}
			return minima;
		}

		// Funzione realizzata da Codex in autonomia
		private static bool SegmentoInternoAlPerimetro(
			Punto a,
			Punto b,
			List<Punto> perimetro)
		{
			if (perimetro == null || perimetro.Count < 3)
				return false;

			const int campioni = 12;
			for (int i = 1; i < campioni; i++)
			{
				double t = (double)i / campioni;
				var punto = new Punto(
					a.X + (b.X - a.X) * t,
					a.Y + (b.Y - a.Y) * t);
				if (!GeometryUtils.IsInsidePolygon(punto, perimetro))
					return false;
			}
			return true;
		}

		// Funzione realizzata da Codex in autonomia
		private static double DistanzaMinimaPolilinee(
			IReadOnlyList<Punto> prima,
			IReadOnlyList<Punto> seconda)
		{
			if (prima == null || seconda == null ||
				prima.Count < 2 || seconda.Count < 2)
			{
				return double.PositiveInfinity;
			}

			double minima = double.PositiveInfinity;
			for (int i = 0; i < prima.Count - 1; i++)
			{
				for (int j = 0; j < seconda.Count - 1; j++)
				{
					if (IntersezionePropria(
						prima[i], prima[i + 1],
						seconda[j], seconda[j + 1]))
					{
						return 0.0;
					}

					double distanza = Math.Min(
						Math.Min(
							GeometryUtils.DistancePointToSegment(
								prima[i], seconda[j], seconda[j + 1]),
							GeometryUtils.DistancePointToSegment(
								prima[i + 1], seconda[j], seconda[j + 1])),
						Math.Min(
							GeometryUtils.DistancePointToSegment(
								seconda[j], prima[i], prima[i + 1]),
							GeometryUtils.DistancePointToSegment(
								seconda[j + 1], prima[i], prima[i + 1])));
					minima = Math.Min(minima, distanza);
				}
			}
			return minima;
		}

		// Funzione realizzata da Codex in autonomia
		private static int ContaAutoIntersezioniProprie(
			IReadOnlyList<Punto> punti)
		{
			if (punti == null || punti.Count < 4)
				return 0;

			int totale = 0;
			for (int i = 0; i < punti.Count - 1; i++)
			{
				for (int j = i + 2; j < punti.Count - 1; j++)
				{
					if (IntersezionePropria(
						punti[i], punti[i + 1],
						punti[j], punti[j + 1]))
					{
						totale++;
					}
				}
			}
			return totale;
		}

		// Funzione realizzata da Codex in autonomia
		private static int ContaIntersezioniProprie(
			IReadOnlyList<Punto> primo,
			IReadOnlyList<Punto> secondo)
		{
			int totale = 0;
			for (int i = 0; i < primo.Count - 1; i++)
			{
				for (int j = 0; j < secondo.Count - 1; j++)
				{
					if (IntersezionePropria(
						primo[i], primo[i + 1],
						secondo[j], secondo[j + 1]))
					{
						totale++;
					}
				}
			}
			return totale;
		}

		// Funzione realizzata da Codex in autonomia
		private static bool IntersezionePropria(
			Punto a, Punto b, Punto c, Punto d)
		{
			const double epsilon = 0.00000001;
			double o1 = Orientamento(a, b, c);
			double o2 = Orientamento(a, b, d);
			double o3 = Orientamento(c, d, a);
			double o4 = Orientamento(c, d, b);
			return ((o1 > epsilon && o2 < -epsilon) ||
					(o1 < -epsilon && o2 > epsilon)) &&
				   ((o3 > epsilon && o4 < -epsilon) ||
					(o3 < -epsilon && o4 > epsilon));
		}

		// Funzione realizzata da Codex in autonomia
		private static double Orientamento(Punto a, Punto b, Punto c)
		{
			return (b.X - a.X) * (c.Y - a.Y) -
				   (b.Y - a.Y) * (c.X - a.X);
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
