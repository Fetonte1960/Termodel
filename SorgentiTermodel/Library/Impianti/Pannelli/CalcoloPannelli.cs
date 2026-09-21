using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Xml.Linq;

namespace Termodel.Impianti.Pannelli
{
    internal enum LivelloSegnalazionePannelli
    {
        Errore,
        Warning,
        Informazione
    }

    internal sealed class SegnalazionePannelli
    {
        public LivelloSegnalazionePannelli Livello { get; init; }
        public string Codice { get; init; }
        public string Piano { get; init; }
        public string Locale { get; init; }
        public string Circuito { get; init; }
        public string Messaggio { get; init; }
    }

    internal sealed class DatiProgettoPannelli
    {
        // Valori iniziali provvisori: in seguito saranno caricati dai dati di progetto.
        public double PassoTubi { get; init; } = SpiralHeating.Program.PassoTubi;
        public double DiametroEsternoTuboMm { get; init; } = 16;
        public double SpessoreTuboMm { get; init; } = 2;
        public double TemperaturaMandata { get; init; } = 35;
        public double TemperaturaRitorno { get; init; } = 30;
        public double TemperaturaAmbiente { get; init; } = 20;
        public double TemperaturaEsternaProgetto { get; init; } = 5;
        public double LunghezzaMatassa { get; init; } = 600;
        public double LunghezzaMassimaCircuito { get; init; } = 100;
        public double PerditaCaricoMassimaCircuitoPa { get; init; } = 25000;
        public double CoefficienteResaWm2K { get; init; } = 5;

        public double DiametroInternoTuboMm =>
            DiametroEsternoTuboMm - 2 * SpessoreTuboMm;

        public double SaltoTermico =>
            TemperaturaMandata - TemperaturaRitorno;

        public double TemperaturaMediaAcqua =>
            (TemperaturaMandata + TemperaturaRitorno) / 2.0;
    }

    internal sealed class RisultatoCalcoloPannelli
    {
        public DatiProgettoPannelli DatiProgetto { get; init; }
        public int NumeroPiani { get; init; }
        public int NumeroLocali { get; init; }
        public int NumeroCircuiti { get; init; }
        public int NumeroTubi { get; init; }
        public double SuperficieTotaleLocali { get; init; }
        public double LunghezzaTotaleSpirali { get; init; }
        public IReadOnlyList<SegnalazionePannelli> Segnalazioni { get; init; } =
            Array.Empty<SegnalazionePannelli>();
        public IReadOnlyList<PianoCalcoloPannelli> Piani { get; init; } =
            Array.Empty<PianoCalcoloPannelli>();
    }

    internal sealed class PianoCalcoloPannelli
    {
        public string Nome { get; init; }
        public List<LocaleCalcoloPannelli> Locali { get; } = new();
    }

    internal sealed class LocaleCalcoloPannelli
    {
        public string Id { get; init; }
        public double Superficie { get; init; }
        public double PotenzaRichiesta { get; set; }
        public double PotenzaErogabile =>
            Circuiti.Sum(circuito => circuito.PotenzaErogabile);
        public List<CircuitoCalcoloPannelli> Circuiti { get; } = new();
    }

    internal sealed class CircuitoCalcoloPannelli
    {
        public string Id { get; init; }
        public double PassoTubi { get; init; }
        public double LunghezzaCircuito { get; init; }
        public double SuperficieServita { get; init; }
        public double PotenzaSpecifica { get; init; }
        public double PotenzaRichiesta { get; init; }
        public double PotenzaErogabile { get; init; }
    }

    internal static class CalcoloPannelli
    {
        private static readonly DatiProgettoPannelli DatiProgetto = new();

        /// <summary>
        /// Punto principale di ingresso per il calcolo dei pannelli radianti.
        /// </summary>
        public static RisultatoCalcoloPannelli EseguiCalcoloPannelli(
            XDocument modello,
            XDocument datiPannelli)
        {
            _ = modello;

            if (datiPannelli?.Root == null)
                return new RisultatoCalcoloPannelli
                {
                    DatiProgetto = DatiProgetto
                };

            var locali = datiPannelli.Root.Elements("Locale").ToList();
            var spirali = locali.SelectMany(locale => locale.Elements("Spirale")).ToList();
            var potenzeRichieste = CalcolaPotenzeRichiesteLocali(modello);
            var nomiPiani = datiPannelli.Root.Elements("Piano")
                .Select(piano => (string)piano.Attribute("Nome"))
                .Where(nome => !string.IsNullOrWhiteSpace(nome))
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .ToList();

            string pianoUnico = nomiPiani.Count == 1 ? nomiPiani[0] : null;
            var distintaPiani = new List<PianoCalcoloPannelli>();

            foreach (XElement xLocale in locali)
            {
                string nomePiano = (string)xLocale.Attribute("Piano");
                if (string.IsNullOrWhiteSpace(nomePiano))
                    nomePiano = pianoUnico ?? "Piano non associato";

                var piano = distintaPiani.FirstOrDefault(elemento =>
                    string.Equals(elemento.Nome, nomePiano, StringComparison.OrdinalIgnoreCase));

                if (piano == null)
                {
                    piano = new PianoCalcoloPannelli { Nome = nomePiano };
                    distintaPiani.Add(piano);
                }

                var locale = new LocaleCalcoloPannelli
                {
                    Id = (string)xLocale.Attribute("Id") ?? "Locale senza ID",
                    Superficie = CalcolaAreaLocale(xLocale)
                };

                string idTermico = $"{nomePiano}-{locale.Id}";
                if (!potenzeRichieste.TryGetValue(idTermico, out double potenzaRichiesta))
                    potenzeRichieste.TryGetValue(locale.Id, out potenzaRichiesta);

                locale.PotenzaRichiesta = potenzaRichiesta;

                var xSpiraliLocale = xLocale.Elements("Spirale").ToList();
                double potenzaRichiestaCircuito = xSpiraliLocale.Count > 0
                    ? potenzaRichiesta / xSpiraliLocale.Count
                    : 0;
                double superficieServitaCircuito = xSpiraliLocale.Count > 0
                    ? locale.Superficie / xSpiraliLocale.Count
                    : 0;
                double potenzaSpecifica = CalcolaPotenzaSpecifica(DatiProgetto);
                double potenzaErogabileCircuito = CalcolaPotenzaErogabile(
                    superficieServitaCircuito,
                    DatiProgetto);

                int numeroCircuito = 1;
                foreach (XElement xSpirale in xSpiraliLocale)
                {
                    locale.Circuiti.Add(new CircuitoCalcoloPannelli
                    {
                        Id = $"Circuito {numeroCircuito}",
                        PassoTubi = DatiProgetto.PassoTubi,
                        LunghezzaCircuito = CalcolaLunghezza(xSpirale),
                        SuperficieServita = superficieServitaCircuito,
                        PotenzaSpecifica = potenzaSpecifica,
                        PotenzaRichiesta = potenzaRichiestaCircuito,
                        PotenzaErogabile = potenzaErogabileCircuito
                    });
                    numeroCircuito++;
                }

                piano.Locali.Add(locale);
            }

            var segnalazioni = GeneraSegnalazioni(
                distintaPiani,
                DatiProgetto);

            return new RisultatoCalcoloPannelli
            {
                DatiProgetto = DatiProgetto,
                NumeroPiani = distintaPiani.Count,
                NumeroLocali = locali.Count,
                NumeroCircuiti = spirali.Count,
                NumeroTubi = datiPannelli.Descendants("Tubi").Elements("Linea").Count(),
                SuperficieTotaleLocali = locali.Sum(CalcolaAreaLocale),
                LunghezzaTotaleSpirali = spirali.Sum(CalcolaLunghezza),
                Segnalazioni = segnalazioni,
                Piani = distintaPiani
            };
        }

        private static IReadOnlyList<SegnalazionePannelli> GeneraSegnalazioni(
            IEnumerable<PianoCalcoloPannelli> piani,
            DatiProgettoPannelli dati)
        {
            var segnalazioni = new List<SegnalazionePannelli>();

            // TODO PUBBLICAZIONE:
            // - sostituire il coefficiente preliminare di resa con il calcolo normativo;
            // - determinare la superficie realmente pannellabile invece di
            //   assimilarla alla superficie geometrica del locale.
            // Queste attività appartengono al check-up generale precedente
            // alla pubblicazione e non devono comparire come warning operativi.

            foreach (PianoCalcoloPannelli piano in piani)
            {
                foreach (LocaleCalcoloPannelli locale in piano.Locali)
                {
                    if (locale.Superficie <= 0)
                    {
                        segnalazioni.Add(new SegnalazionePannelli
                        {
                            Livello = LivelloSegnalazionePannelli.Errore,
                            Codice = "PAN-101",
                            Piano = piano.Nome,
                            Locale = locale.Id,
                            Messaggio = "La superficie del locale è nulla o non valida."
                        });
                    }

                    if (locale.PotenzaRichiesta <= 0)
                    {
                        segnalazioni.Add(new SegnalazionePannelli
                        {
                            Livello = LivelloSegnalazionePannelli.Warning,
                            Codice = "PAN-102",
                            Piano = piano.Nome,
                            Locale = locale.Id,
                            Messaggio =
                                "La potenza richiesta del locale non è stata trovata oppure non è valida."
                        });
                    }
                    else if (locale.Circuiti.Count == 0)
                    {
                        segnalazioni.Add(new SegnalazionePannelli
                        {
                            Livello = LivelloSegnalazionePannelli.Warning,
                            Codice = "PAN-103",
                            Piano = piano.Nome,
                            Locale = locale.Id,
                            Messaggio =
                                "Il locale ha una potenza richiesta ma non possiede circuiti generati."
                        });
                    }
                    else if (locale.PotenzaErogabile < locale.PotenzaRichiesta)
                    {
                        segnalazioni.Add(new SegnalazionePannelli
                        {
                            Livello = LivelloSegnalazionePannelli.Errore,
                            Codice = "PAN-104",
                            Piano = piano.Nome,
                            Locale = locale.Id,
                            Messaggio =
                                $"Potenza erogabile preliminare insufficiente: " +
                                $"{locale.PotenzaErogabile:0.##} W rispetto a " +
                                $"{locale.PotenzaRichiesta:0.##} W richiesti."
                        });
                    }
                    else if (locale.PotenzaRichiesta > 0 &&
                             locale.PotenzaErogabile <
                             locale.PotenzaRichiesta * 1.10)
                    {
                        segnalazioni.Add(new SegnalazionePannelli
                        {
                            Livello = LivelloSegnalazionePannelli.Warning,
                            Codice = "PAN-105",
                            Piano = piano.Nome,
                            Locale = locale.Id,
                            Messaggio =
                                "Il margine preliminare tra potenza erogabile e richiesta è inferiore al 10%."
                        });
                    }

                    foreach (CircuitoCalcoloPannelli circuito in locale.Circuiti)
                    {
                        if (circuito.LunghezzaCircuito <= 0)
                        {
                            segnalazioni.Add(new SegnalazionePannelli
                            {
                                Livello = LivelloSegnalazionePannelli.Errore,
                                Codice = "PAN-201",
                                Piano = piano.Nome,
                                Locale = locale.Id,
                                Circuito = circuito.Id,
                                Messaggio =
                                    "La lunghezza del circuito è nulla o non valida."
                            });
                        }
                        else if (circuito.LunghezzaCircuito >
                                 dati.LunghezzaMassimaCircuito)
                        {
                            segnalazioni.Add(new SegnalazionePannelli
                            {
                                Livello = LivelloSegnalazionePannelli.Errore,
                                Codice = "PAN-202",
                                Piano = piano.Nome,
                                Locale = locale.Id,
                                Circuito = circuito.Id,
                                Messaggio =
                                    $"Lunghezza circuito {circuito.LunghezzaCircuito:0.##} m " +
                                    $"superiore al limite provvisorio di " +
                                    $"{dati.LunghezzaMassimaCircuito:0.##} m."
                            });
                        }
                        else if (circuito.LunghezzaCircuito >=
                                 dati.LunghezzaMassimaCircuito * 0.90)
                        {
                            segnalazioni.Add(new SegnalazionePannelli
                            {
                                Livello = LivelloSegnalazionePannelli.Warning,
                                Codice = "PAN-203",
                                Piano = piano.Nome,
                                Locale = locale.Id,
                                Circuito = circuito.Id,
                                Messaggio =
                                    $"Lunghezza circuito {circuito.LunghezzaCircuito:0.##} m " +
                                    "prossima al limite massimo."
                            });
                        }
                    }
                }
            }

            return segnalazioni;
        }

        private static Dictionary<string, double> CalcolaPotenzeRichiesteLocali(
            XDocument modello)
        {
            var potenze = new Dictionary<string, double>(
                StringComparer.OrdinalIgnoreCase);

            if (modello?.Root == null)
                return potenze;

            CalcoliXML.XMLInput = modello;
            CalcoliXML.datiClimatici.TemperaturaInternaStandard =
                DatiProgetto.TemperaturaAmbiente;
            CalcoliXML.datiClimatici.TemperaturaEsterna =
                DatiProgetto.TemperaturaEsternaProgetto;

            var dispersioni = CalcoliXML.DispersioniXML();

            foreach (var locale in dispersioni.Zone.SelectMany(zona => zona.Locali))
                potenze[locale.Id] = locale.TotaleDispersioniLocale;

            return potenze;
        }

        private static double CalcolaPotenzaErogabile(
            double superficieServita,
            DatiProgettoPannelli dati)
        {
            if (superficieServita <= 0)
                return 0;

            return superficieServita * CalcolaPotenzaSpecifica(dati);
        }

        private static double CalcolaPotenzaSpecifica(
            DatiProgettoPannelli dati)
        {
            double differenzaTemperatura =
                dati.TemperaturaMediaAcqua - dati.TemperaturaAmbiente;

            if (differenzaTemperatura <= 0)
                return 0;

            return dati.CoefficienteResaWm2K * differenzaTemperatura;
        }

        private static double CalcolaAreaLocale(XElement locale)
        {
            var punti = locale.Element("PerimetroInterno")?
                .Elements("Punto")
                .Select(LeggiPunto)
                .Where(punto => punto.HasValue)
                .Select(punto => punto.Value)
                .ToList();

            if (punti == null || punti.Count < 3)
                return 0;

            double areaDoppia = 0;
            for (int i = 0; i < punti.Count; i++)
            {
                var corrente = punti[i];
                var successivo = punti[(i + 1) % punti.Count];
                areaDoppia += corrente.X * successivo.Y - successivo.X * corrente.Y;
            }

            return Math.Abs(areaDoppia) / 2.0;
        }

        private static double CalcolaLunghezza(XElement linea)
        {
            var punti = linea.Elements("Punto")
                .Select(LeggiPunto)
                .Where(punto => punto.HasValue)
                .Select(punto => punto.Value)
                .ToList();

            double lunghezza = 0;
            for (int i = 1; i < punti.Count; i++)
            {
                double dx = punti[i].X - punti[i - 1].X;
                double dy = punti[i].Y - punti[i - 1].Y;
                lunghezza += Math.Sqrt(dx * dx + dy * dy);
            }

            return lunghezza;
        }

        private static (double X, double Y)? LeggiPunto(XElement punto)
        {
            bool xValida = double.TryParse(
                (string)punto.Attribute("X"),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out double x);

            bool yValida = double.TryParse(
                (string)punto.Attribute("Y"),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out double y);

            return xValida && yValida ? (x, y) : null;
        }
    }
}
