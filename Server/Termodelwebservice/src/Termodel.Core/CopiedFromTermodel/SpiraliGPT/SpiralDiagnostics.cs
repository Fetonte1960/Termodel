using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Text.Json;
using NetTopologySuite;
using NetTopologySuite.Geometries;

// Modificato da Codex per realizzare: diagnostica indipendente del motore SpiraliGPT.
namespace SpiralHeatingGPT
{
    // Funzione realizzata da Codex in autonomia
    public sealed class SpiralDiagnosticInput
    {
        public string LocaleId { get; init; }
        public List<Punto> Perimetro { get; init; }
        public List<Punto> Mandata { get; init; }
        public List<Punto> Ritorno { get; init; }
        public List<Punto> Collegamento { get; init; }
        public double RaggioMinimoRichiesto { get; init; }
        // Modificato da Codex per realizzare: verificare il vincolo del
        // ritorno esterno posto a metà passo dal perimetro interno.
        public double DistanzaPareteRitornoRichiesta { get; init; }
        public double? DistanzaPareteRitornoEffettiva { get; init; }
    }

    // Funzione realizzata da Codex in autonomia
    public static class SpiralDiagnostics
    {
        public static void ScriviReport(
            string filePath,
            IEnumerable<SpiralDiagnosticInput> circuiti,
            double passoTubi,
            double raggioMinimoRichiesto,
            double distanzaPareteRitornoRichiesta)
        {
            var risultati = circuiti.Select(AnalizzaCircuito).ToList();
            var report = new
            {
                schemaVersion = 1,
                engine = "GPT",
                generatedAtUtc = DateTime.UtcNow.ToString("O", CultureInfo.InvariantCulture),
                pitchMeters = passoTubi,
                minimumRequiredBendRadiusMeters = raggioMinimoRichiesto,
                requiredReturnWallDistanceMeters =
                    distanzaPareteRitornoRichiesta,
                // Modificato da Codex per realizzare: un report senza alcun
                // circuito non può essere considerato valido per vacuità.
                valid = risultati.Count > 0 && risultati.All(r => r.Valid),
                circuits = risultati
            };

            File.WriteAllText(
                filePath,
                JsonSerializer.Serialize(
                    report,
                    new JsonSerializerOptions { WriteIndented = true }));
        }

        // Funzione realizzata da Codex in autonomia
        private static SpiralDiagnosticResult AnalizzaCircuito(
            SpiralDiagnosticInput input)
        {
            int incrociMandata = ContaAutoIntersezioni(input.Mandata);
            int incrociRitorno = ContaAutoIntersezioni(input.Ritorno);
            int incrociFraPercorsi =
                ContaIntersezioni(input.Mandata, input.Ritorno);
            // Modificato da Codex per realizzare: intercettare una chiusura
            // che attraversa mandata o ripresa anche se queste, singolarmente,
            // non presentano auto-intersezioni.
            int incrociChiusura =
                ContaIntersezioni(input.Collegamento, input.Mandata) +
                ContaIntersezioni(input.Collegamento, input.Ritorno);
            double? raggioMinimoChiusura =
                CalcolaRaggioMinimo(input.Collegamento);
            int segmentiFuori =
                ContaSegmentiFuori(input.Perimetro, input.Mandata) +
                ContaSegmentiFuori(input.Perimetro, input.Ritorno) +
                ContaSegmentiFuori(input.Perimetro, input.Collegamento);
            bool chiusuraContinua =
                SonoCollegati(input.Mandata, input.Collegamento) &&
                SonoCollegati(input.Collegamento, input.Ritorno);

            var avvisi = new List<string>();
            if (incrociMandata > 0)
                avvisi.Add($"Mandata: {incrociMandata} auto-intersezioni proprie.");
            if (incrociRitorno > 0)
                avvisi.Add($"Ritorno: {incrociRitorno} auto-intersezioni proprie.");
            if (incrociFraPercorsi > 0)
                avvisi.Add($"Mandata/ritorno: {incrociFraPercorsi} incroci propri.");
            if (incrociChiusura > 0)
                avvisi.Add($"Chiusura: {incrociChiusura} incroci con mandata o ripresa.");
            if (raggioMinimoChiusura.HasValue &&
                raggioMinimoChiusura.Value + 0.001 < input.RaggioMinimoRichiesto)
            {
                avvisi.Add(
                    $"Chiusura: raggio minimo {raggioMinimoChiusura.Value:F3} m " +
                    $"inferiore a {input.RaggioMinimoRichiesto:F3} m.");
            }
            if (segmentiFuori > 0)
                avvisi.Add($"{segmentiFuori} segmenti non completamente confinati nel locale.");
            if (!chiusuraContinua)
                avvisi.Add("La curva terminale non collega in modo continuo mandata e ritorno.");
            if (!input.DistanzaPareteRitornoEffettiva.HasValue)
            {
                avvisi.Add(
                    "Distanza del ritorno dalla parete non verificabile.");
            }
            else if (Math.Abs(
                         input.DistanzaPareteRitornoEffettiva.Value -
                         input.DistanzaPareteRitornoRichiesta) > 0.005)
            {
                avvisi.Add(
                    $"Ritorno esterno a " +
                    $"{input.DistanzaPareteRitornoEffettiva.Value:F3} m " +
                    $"dalla parete anziché " +
                    $"{input.DistanzaPareteRitornoRichiesta:F3} m.");
            }

            return new SpiralDiagnosticResult
            {
                LocaleId = input.LocaleId,
                Valid = avvisi.Count == 0,
                FeedLengthMeters = Arrotonda(Lunghezza(input.Mandata)),
                ReturnLengthMeters = Arrotonda(Lunghezza(input.Ritorno)),
                ClosureLengthMeters = Arrotonda(Lunghezza(input.Collegamento)),
                FeedSelfIntersections = incrociMandata,
                ReturnSelfIntersections = incrociRitorno,
                FeedReturnIntersections = incrociFraPercorsi,
                ClosureIntersections = incrociChiusura,
                MinimumClosureRadiusMeters = raggioMinimoChiusura.HasValue
                    ? Arrotonda(raggioMinimoChiusura.Value)
                    : null,
                ReturnWallDistanceMeters =
                    input.DistanzaPareteRitornoEffettiva.HasValue
                        ? Arrotonda(
                            input.DistanzaPareteRitornoEffettiva.Value)
                        : null,
                OutsideSegments = segmentiFuori,
                ClosureContinuous = chiusuraContinua,
                MaxFeedSegmentMeters = Arrotonda(SegmentoMassimo(input.Mandata)),
                MaxReturnSegmentMeters = Arrotonda(SegmentoMassimo(input.Ritorno)),
                Warnings = avvisi
            };
        }

        // Funzione realizzata da Codex in autonomia
        private static double Lunghezza(IReadOnlyList<Punto> punti)
        {
            double totale = 0.0;
            if (punti == null)
                return totale;

            for (int i = 1; i < punti.Count; i++)
                totale += punti[i - 1].DistanceTo(punti[i]);
            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static double SegmentoMassimo(IReadOnlyList<Punto> punti)
        {
            double massimo = 0.0;
            if (punti == null)
                return massimo;

            for (int i = 1; i < punti.Count; i++)
                massimo = Math.Max(massimo, punti[i - 1].DistanceTo(punti[i]));
            return massimo;
        }

        // Funzione realizzata da Codex in autonomia
        private static double? CalcolaRaggioMinimo(IReadOnlyList<Punto> punti)
        {
            if (punti == null || punti.Count < 3)
                return null;

            double minimo = double.PositiveInfinity;
            for (int i = 1; i < punti.Count - 1; i++)
            {
                Punto a = punti[i - 1];
                Punto b = punti[i];
                Punto c = punti[i + 1];
                double ab = a.DistanceTo(b);
                double bc = b.DistanceTo(c);
                double ac = a.DistanceTo(c);
                double doppiaArea = Math.Abs(Orientamento(a, b, c));
                if (ab <= 0.000001 || bc <= 0.000001 ||
                    ac <= 0.000001 || doppiaArea <= 0.00000001)
                {
                    continue;
                }

                double raggio = ab * bc * ac / (2.0 * doppiaArea);
                minimo = Math.Min(minimo, raggio);
            }

            return double.IsPositiveInfinity(minimo) ? null : minimo;
        }

        // Funzione realizzata da Codex in autonomia
        private static int ContaAutoIntersezioni(IReadOnlyList<Punto> punti)
        {
            if (punti == null || punti.Count < 4)
                return 0;

            int totale = 0;
            for (int i = 0; i < punti.Count - 1; i++)
            {
                for (int j = i + 2; j < punti.Count - 1; j++)
                {
                    if (IntersezionePropria(
                            punti[i],
                            punti[i + 1],
                            punti[j],
                            punti[j + 1]))
                    {
                        totale++;
                    }
                }
            }
            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static int ContaIntersezioni(
            IReadOnlyList<Punto> primo,
            IReadOnlyList<Punto> secondo)
        {
            if (primo == null || secondo == null)
                return 0;

            int totale = 0;
            for (int i = 0; i < primo.Count - 1; i++)
            {
                for (int j = 0; j < secondo.Count - 1; j++)
                {
                    if (IntersezionePropria(
                            primo[i],
                            primo[i + 1],
                            secondo[j],
                            secondo[j + 1]))
                    {
                        totale++;
                    }
                }
            }
            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool IntersezionePropria(
            Punto a,
            Punto b,
            Punto c,
            Punto d)
        {
            double o1 = Orientamento(a, b, c);
            double o2 = Orientamento(a, b, d);
            double o3 = Orientamento(c, d, a);
            double o4 = Orientamento(c, d, b);
            const double epsilon = 0.00000001;

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

        // Funzione realizzata da Codex in autonomia
        private static int ContaSegmentiFuori(
            IReadOnlyList<Punto> perimetro,
            IReadOnlyList<Punto> percorso)
        {
            if (perimetro == null || perimetro.Count < 3 ||
                percorso == null || percorso.Count < 2)
            {
                return 0;
            }

            var factory = NtsGeometryServices.Instance.CreateGeometryFactory();
            var coordinate = perimetro
                .Select(p => new Coordinate(p.X, p.Y))
                .ToList();
            if (!coordinate[0].Equals2D(coordinate[coordinate.Count - 1]))
                coordinate.Add(new Coordinate(coordinate[0]));

            Geometry area = factory.CreatePolygon(
                factory.CreateLinearRing(coordinate.ToArray()));
            if (!area.IsValid)
                area = area.Buffer(0);
            // Modificato da Codex per realizzare: tollerare l'arrotondamento
            // centimetrico di P3 applicato dal generatore agli ingressi.
            area = area.Buffer(0.001);

            int totale = 0;
            for (int i = 0; i < percorso.Count - 1; i++)
            {
                // Modificato da Codex per realizzare: ignorare i duplicati
                // numerici prodotti dallo snap/arrotondamento; non sono
                // segmenti fisici e non devono generare falsi fuori-area.
                if (percorso[i].DistanceTo(percorso[i + 1]) <= 0.00000001)
                    continue;

                var segmento = factory.CreateLineString(new[]
                {
                    new Coordinate(percorso[i].X, percorso[i].Y),
                    new Coordinate(percorso[i + 1].X, percorso[i + 1].Y)
                });
                if (!area.Covers(segmento))
                    totale++;
            }
            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool SonoCollegati(
            IReadOnlyList<Punto> primo,
            IReadOnlyList<Punto> secondo)
        {
            return primo != null && primo.Count > 0 &&
                   secondo != null && secondo.Count > 0 &&
                   primo[primo.Count - 1].DistanceTo(secondo[0]) <= 0.001;
        }

        // Funzione realizzata da Codex in autonomia
        private static double Arrotonda(double valore)
        {
            return Math.Round(valore, 4, MidpointRounding.AwayFromZero);
        }

        private sealed class SpiralDiagnosticResult
        {
            public string LocaleId { get; init; }
            public bool Valid { get; init; }
            public double FeedLengthMeters { get; init; }
            public double ReturnLengthMeters { get; init; }
            public double ClosureLengthMeters { get; init; }
            public int FeedSelfIntersections { get; init; }
            public int ReturnSelfIntersections { get; init; }
            public int FeedReturnIntersections { get; init; }
            public int ClosureIntersections { get; init; }
            public double? MinimumClosureRadiusMeters { get; init; }
            public double? ReturnWallDistanceMeters { get; init; }
            public int OutsideSegments { get; init; }
            public bool ClosureContinuous { get; init; }
            public double MaxFeedSegmentMeters { get; init; }
            public double MaxReturnSegmentMeters { get; init; }
            public List<string> Warnings { get; init; }
        }
    }
}
