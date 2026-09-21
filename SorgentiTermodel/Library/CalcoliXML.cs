using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Xml.Linq;
using Termodel.utilities;

namespace Termodel
{
    public static class CalcoliXML
    {
        public static XDocument XMLInput { get; set; }

        public class DatiClimatici
        {
            public double TemperaturaEsterna { get; set; } = 5.0;
            public double TemperaturaInternaStandard { get; set; } = 20.0;
        }
        public static DatiClimatici datiClimatici = new DatiClimatici();

        public class RisultatiCalcolo
        {
            public double TotaleDispersioniEdificio { get; set; }
            public List<ZonaRisultato> Zone { get; set; } = new List<ZonaRisultato>();

            public class ZonaRisultato
            {
                public string Id { get; set; }
                public string Descrizione { get; set; }
                public double TotaleDispersioniZona { get; set; }
                public List<LocaleRisultato> Locali { get; set; } = new List<LocaleRisultato>();
            }

            public class LocaleRisultato
            {
                public string Id { get; set; }
                public string Descrizione { get; set; }
                public double TotaleDispersioniLocale { get; set; }
            }
        }

        public static RisultatiCalcolo DispersioniXML()
        {
            var risultati = new RisultatiCalcolo();
            var subEdifici = XMLInput.Descendants("subEdificio");

            if (!subEdifici.Any())
            {
                TermodelLog.LogError("Nessun nodo 'subEdificio' trovato nell'XML.");
                return risultati;
            }

            foreach (var subEdificio in subEdifici)
            {
                var zonaID = subEdificio.Element("identificativo")?.Element("id")?.Value;
                var descrizioneZona = subEdificio.Element("identificativo")?.Element("descrizione")?.Value;
                var temperaturaInternaStr = subEdificio.Element("temperaturaInterna")?.Value;

                if (zonaID == null || descrizioneZona == null)
                {
                    TermodelLog.LogError("Dati della zona mancanti: 'id' o 'descrizione' non trovati.");
                    continue;
                }

                if (temperaturaInternaStr == null || !double.TryParse(temperaturaInternaStr, NumberStyles.Any, CultureInfo.InvariantCulture, out double temperaturaInterna))
                {
                    TermodelLog.WriteLog(
                        $"Temperatura interna non presente per la zona {descrizioneZona}. " +
                        $"Uso il valore di progetto {datiClimatici.TemperaturaInternaStandard:F2} °C.");
                    temperaturaInterna = datiClimatici.TemperaturaInternaStandard;
                }

                var zonaRisultato = new RisultatiCalcolo.ZonaRisultato
                {
                    Id = zonaID,
                    Descrizione = descrizioneZona
                };

                TermodelLog.LogOperation($"=====================> Elaborazione della zona: {descrizioneZona}");

                var listaLocali = subEdificio.Element("listaLocali");
                if (listaLocali == null)
                {
                    TermodelLog.LogError($"Nessun locale trovato nella zona {descrizioneZona}.");
                    continue;
                }

                foreach (var locale in listaLocali.Elements("locale"))
                {
                    var localeID = locale.Element("identificativo")?.Element("id")?.Value;
                    var superficieNettaStr = locale.Element("superficieNetta")?.Value;

                    if (localeID == null)
                    {
                        TermodelLog.LogError("ID del locale mancante.");
                        continue;
                    }

                    TermodelLog.LogOperation($"Elaborazione locale: {localeID}");

                    // Calcolo delle dispersioni per ogni tipo di confine e somma delle dispersioni per locale
                    double totaleDispersioniLocale = 0.0;
                    totaleDispersioniLocale += CalcolaDispersionePerConfine(locale, "Esterno", temperaturaInterna);
                    totaleDispersioniLocale += CalcolaDispersionePerConfine(locale, "AmbienteNonClimatizzato", temperaturaInterna);
                    totaleDispersioniLocale += CalcolaDispersionePerConfine(locale, "AmbienteClimatizzato", temperaturaInterna);
                    totaleDispersioniLocale += CalcolaDispersionePerConfine(locale, "Terreno", temperaturaInterna);
                    totaleDispersioniLocale += CalcolaDispersionePerConfine(locale, "Interno", temperaturaInterna);

                    TermodelLog.LogOperation($"Totale dispersioni per locale {localeID}: {totaleDispersioniLocale.ToString("F2", CultureInfo.InvariantCulture)} W");

                    // Aggiunge il risultato del locale alla zona
                    zonaRisultato.TotaleDispersioniZona += totaleDispersioniLocale;
                    zonaRisultato.Locali.Add(new RisultatiCalcolo.LocaleRisultato
                    {
                        Id = localeID,
                        Descrizione = locale.Element("identificativo")?.Element("descrizione")?.Value ?? "Locale senza descrizione",
                        TotaleDispersioniLocale = totaleDispersioniLocale
                    });
                }

                TermodelLog.LogOperation($"Totale dispersioni per zona {descrizioneZona}: {zonaRisultato.TotaleDispersioniZona.ToString("F2", CultureInfo.InvariantCulture)} W");

                // Aggiunge il risultato della zona ai risultati complessivi
                risultati.TotaleDispersioniEdificio += zonaRisultato.TotaleDispersioniZona;
                risultati.Zone.Add(zonaRisultato);
            }

            TermodelLog.LogOperation($"Totale dispersioni per edificio: {risultati.TotaleDispersioniEdificio.ToString("F2", CultureInfo.InvariantCulture)} W");
            return risultati;
        }

        private static double CalcolaDispersionePerConfine(XElement localeNode, string tipoConfine, double temperaturaInterna)
        {
            double dispersioneTotale = 0.0;
            double deltaT = temperaturaInterna - datiClimatici.TemperaturaEsterna;
            XElement trasmissioneNode = localeNode.Element("trasmissione") ?? localeNode;

            foreach (var confineNode in trasmissioneNode.Elements($"confine{tipoConfine}"))
            {
                foreach (var superficieNode in confineNode.Elements("superficieOpaca"))
                {
                    var descrizione = superficieNode.Element("descrizione")?.Value ?? "Parete opaca";
                    var superficieDisperdenteStr = superficieNode.Element("superficieDisperdente")?.Value;
                    var trasmittanzaStr = superficieNode.Element("trasmittanza")?.Value;

                    if (superficieDisperdenteStr == null || trasmittanzaStr == null)
                    {
                        TermodelLog.LogError($"Dati mancanti per la parete {descrizione} nel locale {localeNode.Element("identificativo")?.Element("id")?.Value}.");
                        continue;
                    }

                    if (double.TryParse(superficieDisperdenteStr, NumberStyles.Any, CultureInfo.InvariantCulture, out double superficieDisperdente) &&
                        double.TryParse(trasmittanzaStr, NumberStyles.Any, CultureInfo.InvariantCulture, out double trasmittanza))
                    {
                        double dispersione = trasmittanza * superficieDisperdente * deltaT;
                        dispersioneTotale += dispersione;
                        TermodelLog.LogOperation($"Calcolo dispersione per {descrizione} - Parete opaca: S = {superficieDisperdente.ToString("F2", CultureInfo.InvariantCulture)}, U = {trasmittanza.ToString("F2", CultureInfo.InvariantCulture)}, ΔT = {deltaT.ToString("F2", CultureInfo.InvariantCulture)}, Risultato = {dispersione.ToString("F2", CultureInfo.InvariantCulture)}");
                    }
                }

                foreach (var finestraNode in confineNode.Elements("superficieVetrata"))
                {
                    var descrizione = finestraNode.Element("descrizione")?.Value ?? "Finestra";
                    var superficieDisperdenteStr = finestraNode.Element("superficieDisperdente")?.Value;
                    var trasmittanzaInfissoStr = finestraNode.Element("trasmittanzaInfisso")?.Value;

                    if (superficieDisperdenteStr == null || trasmittanzaInfissoStr == null)
                    {
                        TermodelLog.LogError($"Dati mancanti per la finestra {descrizione} nel locale {localeNode.Element("identificativo")?.Element("id")?.Value}.");
                        continue;
                    }

                    if (double.TryParse(superficieDisperdenteStr, NumberStyles.Any, CultureInfo.InvariantCulture, out double superficieDisperdente) &&
                        double.TryParse(trasmittanzaInfissoStr, NumberStyles.Any, CultureInfo.InvariantCulture, out double trasmittanzaInfisso))
                    {
                        double dispersione = trasmittanzaInfisso * superficieDisperdente * deltaT;
                        dispersioneTotale += dispersione;
                        TermodelLog.LogOperation($"Calcolo dispersione per {descrizione} - Finestra: S = {superficieDisperdente.ToString("F2", CultureInfo.InvariantCulture)}, U = {trasmittanzaInfisso.ToString("F2", CultureInfo.InvariantCulture)}, ΔT = {deltaT.ToString("F2", CultureInfo.InvariantCulture)}, Risultato = {dispersione.ToString("F2", CultureInfo.InvariantCulture)}");
                    }
                }

                foreach (var ponteTermicoNode in confineNode.Elements("PonteTermico"))
                {
                    var descrizione = ponteTermicoNode.Element("descrizione")?.Value ?? "Ponte termico";
                    var lunghezzaStr = ponteTermicoNode.Element("lunghezza")?.Value;
                    var trasmittanzaLineareStr = ponteTermicoNode.Element("trasmittanzaLineare")?.Value;

                    if (lunghezzaStr == null || trasmittanzaLineareStr == null)
                    {
                        TermodelLog.LogError($"Dati mancanti per il ponte termico {descrizione} nel locale {localeNode.Element("identificativo")?.Element("id")?.Value}.");
                        continue;
                    }

                    if (double.TryParse(lunghezzaStr, NumberStyles.Any, CultureInfo.InvariantCulture, out double lunghezza) &&
                        double.TryParse(trasmittanzaLineareStr, NumberStyles.Any, CultureInfo.InvariantCulture, out double trasmittanzaLineare))
                    {
                        double dispersione = trasmittanzaLineare * lunghezza * deltaT;
                        dispersioneTotale += dispersione;
                        TermodelLog.LogOperation($"Calcolo dispersione per {descrizione} - Ponte termico: L = {lunghezza.ToString("F2", CultureInfo.InvariantCulture)}, Ψ = {trasmittanzaLineare.ToString("F2", CultureInfo.InvariantCulture)}, ΔT = {deltaT.ToString("F2", CultureInfo.InvariantCulture)}, Risultato = {dispersione.ToString("F2", CultureInfo.InvariantCulture)}");
                    }
                }
            }

            return dispersioneTotale;
        }
        public static void ConfrontaCalcoli(RisultatiCalcolo risultati1, RisultatiCalcolo risultati2, double percentualeTolleranza)
        {
            double CalcolaDifferenzaPercentuale(double valore1, double valore2)
            {
                return Math.Abs((valore1 - valore2) / ((valore1 + valore2) / 2.0)) * 100.0;
            }

            // Confronto delle dispersioni totali dell'edificio
            double diffTotaleEdificio = CalcolaDifferenzaPercentuale(risultati1.TotaleDispersioniEdificio, risultati2.TotaleDispersioniEdificio);
            if (diffTotaleEdificio > percentualeTolleranza)
            {
                Console.WriteLine($"Differenza nelle dispersioni totali dell'edificio eccede la tolleranza: {diffTotaleEdificio:F2}%");
            }

            // Confronto delle dispersioni per ciascuna zona
            foreach (var zona1 in risultati1.Zone)
            {
                var zona2 = risultati2.Zone.FirstOrDefault(z => z.Descrizione == zona1.Descrizione);
                if (zona2 == null)
                {
                    Console.WriteLine($"Zona '{zona1.Descrizione}' presente in risultati1 non trovata in risultati2.");
                    continue;
                }

                double diffTotaleZona = CalcolaDifferenzaPercentuale(zona1.TotaleDispersioniZona, zona2.TotaleDispersioniZona);
                if (diffTotaleZona > percentualeTolleranza)
                {
                    Console.WriteLine($"Differenza nelle dispersioni totali della zona '{zona1.Descrizione}' eccede la tolleranza: {diffTotaleZona:F2}%");
                }

                // Confronto delle dispersioni per ciascun locale all'interno della zona
                foreach (var locale1 in zona1.Locali)
                {
                    var locale2 = zona2.Locali.FirstOrDefault(l => l.Descrizione == locale1.Descrizione);
                    if (locale2 == null)
                    {
                        Console.WriteLine($"Locale '{locale1.Descrizione}' nella zona '{zona1.Descrizione}' presente in risultati1 non trovato in risultati2.");
                        continue;
                    }

                    double diffTotaleLocale = CalcolaDifferenzaPercentuale(locale1.TotaleDispersioniLocale, locale2.TotaleDispersioniLocale);
                    if (diffTotaleLocale > percentualeTolleranza)
                    {
                        Console.WriteLine($"Differenza nelle dispersioni del locale '{locale1.Descrizione}' nella zona '{zona1.Descrizione}' eccede la tolleranza: {diffTotaleLocale:F2}%");
                    }
                }

                // Segnalazione di eventuali locali presenti in risultati2 ma non in risultati1
                foreach (var locale2 in zona2.Locali)
                {
                    if (!zona1.Locali.Any(l => l.Descrizione == locale2.Descrizione))
                    {
                        Console.WriteLine($"Locale '{locale2.Descrizione}' nella zona '{zona2.Descrizione}' presente in risultati2 non trovato in risultati1.");
                    }
                }
            }

            // Segnalazione di eventuali zone presenti in risultati2 ma non in risultati1
            foreach (var zona2 in risultati2.Zone)
            {
                if (!risultati1.Zone.Any(z => z.Descrizione == zona2.Descrizione))
                {
                    Console.WriteLine($"Zona '{zona2.Descrizione}' presente in risultati2 non trovata in risultati1.");
                }
            }
        }

    }
}
