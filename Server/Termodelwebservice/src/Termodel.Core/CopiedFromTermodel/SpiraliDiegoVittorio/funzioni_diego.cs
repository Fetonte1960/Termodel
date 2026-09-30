using System;
using System.Collections.Generic;

namespace SpiralHeatingDiegoVittorio
{
    /// <summary>
    /// Raccolta riutilizzabile delle funzioni sviluppate da Diego rispetto
    /// al motore Vittorio: ritorno parallelo, chiusura e raccordo.
    /// </summary>
    public static class funzioni_diego
    {
        private const double Tolleranza = 1e-9;

        // Facciata unica per la chiusura Diego.
        // L'implementazione consolidata resta temporaneamente in ChiudiSpirale
        // per non introdurre cambiamenti geometrici durante questo riordino.
        public static (
            List<Punto> Mandata,
            List<Punto> Ritorno,
            List<Punto> Chiusura,
            bool Applicata)
            chiusura_diego(
                List<Punto> mandataRettilinea,
                List<Punto> ritornoVersoCentro,
                double passo) =>
            ChiudiSpirale.ApplicaChiusuraCombinatoriaRettilineaVittorio(
                mandataRettilinea,
                ritornoVersoCentro,
                passo);

        /// <summary>
        /// Raccorda una polilinea definitiva con archi circolari tangenti.
        /// La funzione lavora dopo Return e chiusura: non partecipa alla
        /// scelta della geometria. Se il raggio non entra nei due tratti
        /// adiacenti lo spigolo resta vivo; il raggio non viene ridotto.
        /// La discretizzazione e' adattiva sulla sagitta massima.
        /// </summary>
        public static List<Punto> raccorda_diego(
            IReadOnlyList<Punto> spezzata,
            double raggio,
            double tolleranzaDiscretizzazione,
            out Dictionary<int, int> indiceTransizionePerVertice)
        {
            const double epsilon = 0.000001;
            const double tolleranzaDuplicatiRaccordo = 0.0001;

            indiceTransizionePerVertice = new Dictionary<int, int>();

            if (spezzata == null || spezzata.Count == 0)
                return new List<Punto>();

            if (spezzata.Count < 3 ||
                raggio <= epsilon ||
                !double.IsFinite(raggio) ||
                tolleranzaDiscretizzazione <= epsilon ||
                !double.IsFinite(tolleranzaDiscretizzazione))
            {
                List<Punto> copia = Copia(spezzata);
                for (int i = 1; i < copia.Count - 1; i++)
                    indiceTransizionePerVertice[i] = i;
                return copia;
            }

            int count = spezzata.Count;
            var lunghezze = new double[count - 1];
            for (int i = 0; i < count - 1; i++)
                lunghezze[i] = spezzata[i].DistanceTo(spezzata[i + 1]);

            var raccordabile = new bool[count];
            var distanzeTangenti = new double[count];

            for (int i = 1; i < count - 1; i++)
            {
                double len1 = lunghezze[i - 1];
                double len2 = lunghezze[i];
                if (len1 <= epsilon || len2 <= epsilon)
                    continue;

                var u1 = new Punto(
                    (spezzata[i].X - spezzata[i - 1].X) / len1,
                    (spezzata[i].Y - spezzata[i - 1].Y) / len1);
                var u2 = new Punto(
                    (spezzata[i + 1].X - spezzata[i].X) / len2,
                    (spezzata[i + 1].Y - spezzata[i].Y) / len2);

                double prodotto = Math.Max(
                    -1.0,
                    Math.Min(1.0, u1.X * u2.X + u1.Y * u2.Y));
                double deviazione = Math.Acos(prodotto);
                double verso = Cross(u1, u2);

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

            // Due raccordi adiacenti non possono consumare piu' del segmento
            // comune. In caso di conflitto entrambi gli spigoli restano vivi:
            // non si riduce arbitrariamente il raggio.
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
            AggiungiSeDistintoRaccordo(
                risultato,
                spezzata[0],
                tolleranzaDuplicatiRaccordo);

            for (int i = 1; i < count - 1; i++)
            {
                Punto p0 = spezzata[i - 1];
                Punto p1 = spezzata[i];
                Punto p2 = spezzata[i + 1];

                if (!raccordabile[i])
                {
                    AggiungiSeDistintoRaccordo(
                        risultato,
                        p1,
                        tolleranzaDuplicatiRaccordo);
                    indiceTransizionePerVertice[i] = risultato.Count - 1;
                    continue;
                }

                double len1 = lunghezze[i - 1];
                double len2 = lunghezze[i];
                var u1 = new Punto(
                    (p1.X - p0.X) / len1,
                    (p1.Y - p0.Y) / len1);
                var u2 = new Punto(
                    (p2.X - p1.X) / len2,
                    (p2.Y - p1.Y) / len2);
                double distanzaTangente = distanzeTangenti[i];

                var pStart = new Punto(
                    p1.X - u1.X * distanzaTangente,
                    p1.Y - u1.Y * distanzaTangente);
                var pEnd = new Punto(
                    p1.X + u2.X * distanzaTangente,
                    p1.Y + u2.Y * distanzaTangente);

                double verso = Cross(u1, u2);
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
                if (!double.IsFinite(angoloMassimo) ||
                    angoloMassimo <= epsilon)
                {
                    angoloMassimo = Math.PI / 180.0;
                }

                int segmenti = Math.Max(
                    1,
                    (int)Math.Ceiling(
                        Math.Abs(sviluppo) / angoloMassimo));
                int segmentoTransizione =
                    (int)Math.Ceiling(segmenti / 2.0);

                AggiungiSeDistintoRaccordo(
                    risultato,
                    pStart,
                    tolleranzaDuplicatiRaccordo);

                for (int j = 1; j <= segmenti; j++)
                {
                    double angolo =
                        angoloInizio + sviluppo * j / segmenti;
                    AggiungiSeDistintoRaccordo(
                        risultato,
                        new Punto(
                            centro.X + raggio * Math.Cos(angolo),
                            centro.Y + raggio * Math.Sin(angolo)),
                        tolleranzaDuplicatiRaccordo);

                    if (j == segmentoTransizione)
                        indiceTransizionePerVertice[i] =
                            risultato.Count - 1;
                }

                if (!indiceTransizionePerVertice.ContainsKey(i))
                    indiceTransizionePerVertice[i] = risultato.Count - 1;
            }

            AggiungiSeDistintoRaccordo(
                risultato,
                spezzata[^1],
                tolleranzaDuplicatiRaccordo);

            return risultato;
        }

        public static List<Punto> raccorda_diego(
            IReadOnlyList<Punto> spezzata,
            double raggio,
            double tolleranzaDiscretizzazione)
        {
            return raccorda_diego(
                spezzata,
                raggio,
                tolleranzaDiscretizzazione,
                out _);
        }

        /// <summary>
        /// Costruisce l'offset parallelo di una spezzata rettilinea senza usare
        /// raccordi o campionamenti curvi.
        /// Distanza positiva = lato sinistro rispetto al verso della spezzata;
        /// negativa = lato destro. Agli spigoli concavi e convessi usa
        /// l'intersezione delle due rette offset adiacenti.
        /// </summary>

        public static List<Punto> ritorno_Parallelo_diego(
            IReadOnlyList<Punto> spezzata,
            double distanza)
        {
            if (spezzata == null)
                throw new ArgumentNullException(nameof(spezzata));

            if (!double.IsFinite(distanza))
                throw new ArgumentOutOfRangeException(
                    nameof(distanza),
                    "La distanza deve essere finita.");

            List<Punto> punti = EliminaDuplicatiConsecutivi(spezzata);
            if (punti.Count < 2)
                throw new ArgumentException(
                    "La spezzata deve contenere almeno due punti distinti.",
                    nameof(spezzata));

            if (Math.Abs(distanza) <= Tolleranza)
                return Copia(punti);

            var segmenti = new List<SegmentoOffset>(punti.Count - 1);
            for (int i = 0; i < punti.Count - 1; i++)
            {
                Punto a = punti[i];
                Punto b = punti[i + 1];
                double dx = b.X - a.X;
                double dy = b.Y - a.Y;
                double lunghezza = Math.Sqrt(dx * dx + dy * dy);

                if (lunghezza <= Tolleranza)
                    continue;

                double ux = dx / lunghezza;
                double uy = dy / lunghezza;

                // Normale sinistra rispetto al verso del segmento.
                double nx = -uy;
                double ny = ux;

                segmenti.Add(new SegmentoOffset(
                    new Punto(
                        a.X + nx * distanza,
                        a.Y + ny * distanza),
                    new Punto(ux, uy),
                    new Punto(nx, ny)));
            }

            if (segmenti.Count == 0)
                throw new ArgumentException(
                    "La spezzata non contiene segmenti validi.",
                    nameof(spezzata));

            var risultato = new List<Punto>
            {
                new Punto(
                    punti[0].X + segmenti[0].Normale.X * distanza,
                    punti[0].Y + segmenti[0].Normale.Y * distanza)
            };

            for (int i = 1; i < punti.Count - 1; i++)
            {
                SegmentoOffset precedente = segmenti[i - 1];
                SegmentoOffset successivo = segmenti[i];

                double cross = Cross(
                    precedente.Direzione,
                    successivo.Direzione);
                double dot =
                    precedente.Direzione.X * successivo.Direzione.X +
                    precedente.Direzione.Y * successivo.Direzione.Y;

                Punto verticeOffset;

                if (Math.Abs(cross) <= Tolleranza)
                {
                    if (dot < 0.0)
                    {
                        throw new InvalidOperationException(
                            $"Offset non definito sul vertice {i}: " +
                            "inversione di direzione prossima a 180 gradi.");
                    }

                    // Segmenti collineari nello stesso verso.
                    verticeOffset = new Punto(
                        punti[i].X + precedente.Normale.X * distanza,
                        punti[i].Y + precedente.Normale.Y * distanza);
                }
                else
                {
                    verticeOffset = IntersezioneRette(
                        precedente.OrigineOffset,
                        precedente.Direzione,
                        successivo.OrigineOffset,
                        successivo.Direzione);
                }

                AggiungiSeDistinto(risultato, verticeOffset);
            }

            SegmentoOffset ultimo = segmenti[^1];
            Punto finale = punti[^1];
            AggiungiSeDistinto(
                risultato,
                new Punto(
                    finale.X + ultimo.Normale.X * distanza,
                    finale.Y + ultimo.Normale.Y * distanza));

            return risultato;
        }

        private static Punto IntersezioneRette(
            Punto origineA,
            Punto direzioneA,
            Punto origineB,
            Punto direzioneB)
        {
            double determinante = Cross(direzioneA, direzioneB);
            if (Math.Abs(determinante) <= Tolleranza)
                throw new InvalidOperationException(
                    "Impossibile intersecare due rette parallele.");

            double deltaX = origineB.X - origineA.X;
            double deltaY = origineB.Y - origineA.Y;

            double t =
                (deltaX * direzioneB.Y - deltaY * direzioneB.X) /
                determinante;

            return new Punto(
                origineA.X + t * direzioneA.X,
                origineA.Y + t * direzioneA.Y);
        }

        private static double Cross(Punto a, Punto b) =>
            a.X * b.Y - a.Y * b.X;

        private static List<Punto> EliminaDuplicatiConsecutivi(
            IReadOnlyList<Punto> punti)
        {
            var risultato = new List<Punto>();
            foreach (Punto punto in punti)
            {
                if (punto == null ||
                    !double.IsFinite(punto.X) ||
                    !double.IsFinite(punto.Y))
                {
                    throw new ArgumentException(
                        "La spezzata contiene un punto nullo o non finito.",
                        nameof(punti));
                }

                if (risultato.Count == 0 ||
                    DistanzaQuadrata(risultato[^1], punto) >
                        Tolleranza * Tolleranza)
                {
                    risultato.Add(new Punto(punto.X, punto.Y));
                }
            }

            return risultato;
        }

        private static List<Punto> Copia(IReadOnlyList<Punto> punti)
        {
            var risultato = new List<Punto>(punti.Count);
            foreach (Punto punto in punti)
                risultato.Add(new Punto(punto.X, punto.Y));
            return risultato;
        }

        private static void AggiungiSeDistinto(
            List<Punto> punti,
            Punto candidato)
        {
            if (punti.Count == 0 ||
                DistanzaQuadrata(punti[^1], candidato) >
                    Tolleranza * Tolleranza)
            {
                punti.Add(candidato);
            }
        }

        private static double DistanzaQuadrata(Punto a, Punto b)
        {
            double dx = a.X - b.X;
            double dy = a.Y - b.Y;
            return dx * dx + dy * dy;
        }

        private static void AggiungiSeDistintoRaccordo(
            List<Punto> punti,
            Punto candidato,
            double tolleranza)
        {
            if (punti.Count == 0 ||
                punti[^1].DistanceTo(candidato) > tolleranza)
            {
                punti.Add(new Punto(candidato.X, candidato.Y));
            }
        }

        private sealed record SegmentoOffset(
            Punto OrigineOffset,
            Punto Direzione,
            Punto Normale);
    }
}
