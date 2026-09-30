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

        // Facciata unica per il raccordo Diego.
        public static List<Punto> raccorda_diego(
            List<Punto> mandata,
            List<Punto> ritorno,
            double raggio,
            double? lunghezzaMinima = null) =>
            ChiudiSpirale.RaccordaDiego(
                mandata,
                ritorno,
                raggio,
                lunghezzaMinima);

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

        private sealed record SegmentoOffset(
            Punto OrigineOffset,
            Punto Direzione,
            Punto Normale);
    }
}
