using System;
using System.Collections.Generic;
using System.Globalization;
using Termodel.utilities;
using System.IO;
using System.Windows.Forms;
using System.Xml.Linq;
using System.Text;
using static Termodel.Calcoli.CalcoloAPE;
using System.Xml.Serialization;

namespace Termodel.Calcoli;
public class SuperficieOpaca
{
    public string Orientamento { get; set; }
    public double AreaNetta { get; set; }
    public double AreaLorda { get; set; }
    public double Trasmittanza { get; set; }
    public string Confine { get; set; }
    public string Stratigrafia { get; set; }
    public string Tipo { get; set; } // Parete, Pavimento, Soffitto
}

public class ComponenteTermico
{
    public string Tipo { get; set; }                // Parete, Pavimento, Soffitto
    public string Stratigrafia { get; set; }
    public string Confine { get; set; }
    public double Superficie { get; set; }          // [m²]
    public double Trasmittanza { get; set; }        // [W/m²K]
    public double FattoreCorrezione { get; set; }   // ad es. 1.0 o 0.8
}

public class Finestra
{
    public double Superficie { get; set; } = 0.0;               // [m²]
    public double Trasmittanza { get; set; } = 1.5;             // [W/m²K]
    public double FattoreSolare { get; set; } = 0.8;            // default
    public double FattoreOmbreggiamento { get; set; } = 0.9;    // default
    public double IrradianzaStagionale { get; set; } = 350.0;   // [kWh/m² anno]
    public string Confine { get; set; }
}
public class PonteTermico
{
    public double Lunghezza { get; set; }             // [m]
    public double TrasmittanzaLineica { get; set; }   // [W/mK]
    public string Confine { get; set; }               // Per btr
}
public class DatiIrraggiamento
{
    public string Localita { get; set; }
    public string Provincia { get; set; }
    public Dictionary<string, double> Orizzontale { get; set; } = new();
    public Dictionary<string, Dictionary<string, double>> Verticale { get; set; } = new();

    public int? GradiGiorno { get; set; }  // Campo opzionale

    private readonly string[] mesi = new[]
    {
        "gennaio", "febbraio", "marzo", "aprile", "maggio", "giugno",
        "luglio", "agosto", "settembre", "ottobre", "novembre", "dicembre"
    };

    /// <summary>
    /// Restituisce l'irraggiamento mensile interpolato in base all'orientamento angolare.
    /// 
    /// Convenzioni angolari (secondo UNI/TS 11300):
    /// - Sud: 0°
    /// - Ovest: +90°
    /// - Nord: ±180°
    /// - Est: -90°
    /// Gli angoli intermedi devono essere interpolati linearmente.
    /// </summary>
    /// <param name="orientamento">Angolo azimutale della superficie (in gradi)</param>
    /// <param name="mese">Mese in italiano (es: gennaio)</param>
    /// <returns>Valore interpolato mensile (in MJ/m²)</returns>
    public double interpola_irraggiamento(double orientamento, string mese)
    {
        // Normalizzazione dell'orientamento tra -180° e +180°
        orientamento = ((orientamento + 180) % 360) - 180;

        string orientamento1 = "";
        string orientamento2 = "";
        double angolo1 = 0;
        double angolo2 = 0;

        if (orientamento >= -180 && orientamento < -90)
        {
            orientamento1 = "nord";
            orientamento2 = "est";
            angolo1 = -180;
            angolo2 = -90;
        }
        else if (orientamento >= -90 && orientamento < 0)
        {
            orientamento1 = "est";
            orientamento2 = "sud";
            angolo1 = -90;
            angolo2 = 0;
        }
        else if (orientamento >= 0 && orientamento < 90)
        {
            orientamento1 = "sud";
            orientamento2 = "ovest";
            angolo1 = 0;
            angolo2 = 90;
        }
        else if (orientamento >= 90 && orientamento <= 180)
        {
            orientamento1 = "ovest";
            orientamento2 = "nord";
            angolo1 = 90;
            angolo2 = 180;
        }

        double val1 = Verticale[orientamento1][mese];
        double val2 = Verticale[orientamento2][mese];

        return val1 + (orientamento - angolo1) / (angolo2 - angolo1) * (val2 - val1);
    }
}


public class DatiRisultatoAPE
{
    public DatiTermodel RisultatiTermodelDaModello { get; set; }

    // Componenti opachi
    public double HT_Opaco { get; set; }

    // Finestre
    public double HT_Finestra { get; set; }

    // Ponti termici
    public double HT_PontiTermici { get; set; }

    // Totali
    public double HT_Totale { get; set; }
    public double HV { get; set; }

    // Fabbisogno energetico
    public double QhDisp { get; set; }
    public double Qi { get; set; }
    public double Qs { get; set; }
    public double QhNetto { get; set; }
    public double EnergiaFinale { get; set; }
    public double EPglNren { get; set; }
}

    public class RisultatoAPE
{
    public DatiTermodel RisultatiTermodelDaModello = new();

    public DatiRisultatoAPE EdificioReale = new();
    public DatiRisultatoAPE EdificioRiferimento = new();

    // Componenti opachi
    public int NumeroComponentiOpachi { get; set; }

    public int NumeroFinestre { get; set; }
    public int NumeroPontiTermici { get; set; }
    public int GradiGiorno { get; set; }

    // === METODO DI SALVATAGGIO XML ===
    public void SalvaXml(string path)
    {
        try
        {
            var serializer = new XmlSerializer(typeof(RisultatoAPE));
            using var writer = new StreamWriter(path);
            serializer.Serialize(writer, this);
        }
        catch (Exception ex)
        {
            throw new Exception("Errore nel salvataggio del file XML: " + ex.Message);
        }
    }

    // === METODO DI LETTURA XML ===
    public static RisultatoAPE LeggiXml(string path)
    {
        try
        {
            var serializer = new XmlSerializer(typeof(RisultatoAPE));
            using var reader = new StreamReader(path);
            return (RisultatoAPE)serializer.Deserialize(reader);
        }
        catch (Exception ex)
        {
            throw new Exception("Errore nella lettura del file XML: " + ex.Message);
        }
    }
}


public class CalcoloAPE
{
    public List<ComponenteTermico> componenti = new();
    public List<Finestra> finestre = new();
    public RisultatoAPE Risultato = new();
    private string confineUltimaParete = "";
    public class DatiTermodel
    {
        public double SuperficieNettaClimatizzata { get; set; }
        public int ElementiCensiti { get; set; }
        public double SuperficieDisperdente { get; set; }
        public double SuperficieTotaleInfissi { get; set; }
        public double TrasmittanzaMediaInfissi { get; set; }
        public double VolumeNettoClimatizzato { get; set; }
        public double VolumeLordoClimatizzato { get; set; }
    }
    public DatiTermodel DatiGenerali { get; private set; } = new();
    public List<PonteTermico> pontiTermici = new();
    public DatiIrraggiamento Dati_Irraggiamento = new();
    public static class ParserDatiTermodel
    {
        public static DatiTermodel DatiGeneraliTermodel()
        {
            string path = Path.Combine(GestProg.ProgramPath, "reportApe.txt");

            if (!File.Exists(path))
                throw new FileNotFoundException("File non trovato: " + path);

            var dati = new DatiTermodel();
            var righe = File.ReadAllLines(path);

            foreach (var riga in righe)
            {
                var line = riga.Trim().Replace("[B]", "").Trim(':').Trim();

                if (line.StartsWith("Superficie netta climatizzata"))
                    dati.SuperficieNettaClimatizzata = EstraiNumero(line);
                else if (line.StartsWith("Elementi censiti"))
                    dati.ElementiCensiti = (int)EstraiNumero(line);
                else if (line.StartsWith("Superficie Disperdente"))
                    dati.SuperficieDisperdente = EstraiNumero(line);
                else if (line.StartsWith("Superficie totale infissi"))
                    dati.SuperficieTotaleInfissi = EstraiNumero(line);
                else if (line.StartsWith("Trasmittanza media infissi"))
                    dati.TrasmittanzaMediaInfissi = EstraiNumero(line);
                else if (line.StartsWith("Volume netto climatizzato"))
                    dati.VolumeNettoClimatizzato = EstraiNumero(line);
                else if (line.StartsWith("Volume lordo climatizzato"))
                    dati.VolumeLordoClimatizzato = EstraiNumero(line);
            }

            return dati;
        }

        private static double EstraiNumero(string line)
        {
            string[] parti = line.Split(':');
            if (parti.Length < 2) return 0.0;

            string numero = parti[1].Trim().Split(' ')[0].Replace(",", "."); // gestisce virgola
            double.TryParse(numero, NumberStyles.Any, CultureInfo.InvariantCulture, out double valore);
            return valore;
        }
    }
    /*
    string path = Path.Combine(GestProg.PathProgDB, "Daticlimatici.cli");

        if (!File.Exists(path))
            throw new FileNotFoundException($"Il file dei dati climatici non è stato trovato: {path}");
    string input = File.ReadAllText(path);
    */
    public static DatiIrraggiamento ParseIrraggiamento(string input)
    {
        var dati = new DatiIrraggiamento
        {
            Orizzontale = new Dictionary<string, double>(),
            Verticale = new Dictionary<string, Dictionary<string, double>>()
        };

        var lines = input.Split(new[] { "\r\n", "\n" }, StringSplitOptions.RemoveEmptyEntries);
        string currentSection = null;
        string currentSubsection = null;

        var mesiMap = new Dictionary<string, string>
    {
        { "january", "gennaio" }, { "february", "febbraio" }, { "march", "marzo" },
        { "april", "aprile" }, { "may", "maggio" }, { "june", "giugno" },
        { "july", "luglio" }, { "august", "agosto" }, { "september", "settembre" },
        { "october", "ottobre" }, { "november", "novembre" }, { "december", "dicembre" }
    };

        foreach (var rawLine in lines)
        {
            var line = rawLine.Trim();
            if (string.IsNullOrWhiteSpace(line) || line.StartsWith("#")) continue;

            try
            {
                if (line.StartsWith("localita:"))
                    dati.Localita = line.Split(':', 2)[1].Trim();

                else if (line.StartsWith("provincia:"))
                    dati.Provincia = line.Split(':', 2)[1].Trim();

                else if (line.StartsWith("gradigiorno:"))
                {
                    if (int.TryParse(line.Split(':', 2)[1].Trim(), out int gg))
                        dati.GradiGiorno = gg;
                    else
                        throw new FormatException("Il valore dei gradi giorno non è un intero valido.");
                }

                else if (line.StartsWith("orizzontale:"))
                    currentSection = "orizzontale";

                else if (line.StartsWith("verticale:"))
                    currentSection = "verticale";

                else if (currentSection == "orizzontale" && line.Contains(":"))
                {
                    var parts = line.Split(':', 2);
                    var meseRaw = parts[0].Trim().ToLower();
                    var mese = mesiMap.ContainsKey(meseRaw) ? mesiMap[meseRaw] : meseRaw;

                    if (double.TryParse(parts[1].Trim().Replace(',', '.'), System.Globalization.NumberStyles.Any,
                        System.Globalization.CultureInfo.InvariantCulture, out double valore))
                    {
                        dati.Orizzontale[mese] = valore;
                    }
                }

                else if (currentSection == "verticale" && line.EndsWith(":"))
                {
                    currentSubsection = line.Replace(":", "").Trim().ToLower();
                    if (!dati.Verticale.ContainsKey(currentSubsection))
                        dati.Verticale[currentSubsection] = new();
                }

                else if (currentSection == "verticale" && line.Contains(":"))
                {
                    var parts = line.Split(':', 2);
                    if (currentSubsection == null) continue;

                    var meseRaw = parts[0].Trim().ToLower();
                    var mese = mesiMap.ContainsKey(meseRaw) ? mesiMap[meseRaw] : meseRaw;

                    if (double.TryParse(parts[1].Trim().Replace(',', '.'), System.Globalization.NumberStyles.Any,
                        System.Globalization.CultureInfo.InvariantCulture, out double valore))
                    {
                        dati.Verticale[currentSubsection][mese] = valore;
                    }
                }
            }
            catch (Exception exRiga)
            {
                throw new FormatException(
                    $"❌ Errore nel parsing della riga:\n\"{line}\"\n\n" +
                    "👉 Dettagli tecnici: " + exRiga.Message + "\n\n" +
                    "✅ Attenzione: il parser accetta **solo numeri** (es: `18.2`), **senza formule** come `7.7*31` o `(...)*0.5`.\n" +
                    "🔧 Modifica la riga inserendo direttamente il valore numerico già calcolato.\n\n" +
                    "💡 Se la riga proviene da una risposta di ChatGPT, chiedi di riformattare usando **numeri espliciti** anziché espressioni."
                );
            }

        }

        // ⚠️ Controllo finale dei dati climatici
        string messaggioErrore = ControlloFinaleClimatici(dati);
        if (!string.IsNullOrEmpty(messaggioErrore))
            throw new FormatException(messaggioErrore);

        return dati;
    }


    public static string ControlloFinaleClimatici(DatiIrraggiamento dati)
    {
        var mesiAttesi = new[]
        {
        "gennaio", "febbraio", "marzo", "aprile", "maggio", "giugno",
        "luglio", "agosto", "settembre", "ottobre", "novembre", "dicembre"
    };

        var report = new StringBuilder();
        bool tuttoOK = true;

        // Controllo località e provincia
        if (string.IsNullOrWhiteSpace(dati.Localita))
        {
            report.AppendLine("- Errore: il campo 'località' è mancante.");
            tuttoOK = false;
        }
        if (string.IsNullOrWhiteSpace(dati.Provincia))
        {
            report.AppendLine("- Errore: il campo 'provincia' è mancante.");
            tuttoOK = false;
        }

        // Controllo gradi giorno
        if (dati.GradiGiorno == null || dati.GradiGiorno <= 0)
        {
            report.AppendLine("- Errore: il campo 'gradigiorno' è mancante o non valido.");
            tuttoOK = false;
        }

        // Controllo orizzontale
        var mancantiOrizzontale = mesiAttesi.Except(dati.Orizzontale.Keys).ToList();
        if (mancantiOrizzontale.Any())
        {
            tuttoOK = false;
            report.AppendLine("- Errore: nella sezione 'orizzontale' mancano i seguenti mesi: " +
                              string.Join(", ", mancantiOrizzontale));
        }

        // Controllo verticale
        foreach (var esposizione in dati.Verticale)
        {
            var mancantiVerticale = mesiAttesi.Except(esposizione.Value.Keys).ToList();
            if (mancantiVerticale.Any())
            {
                tuttoOK = false;
                report.AppendLine($"- Errore: nella sezione 'verticale:{esposizione.Key}' mancano i mesi: " +
                                  string.Join(", ", mancantiVerticale));
            }
        }

        if (tuttoOK)
        {
            return string.Empty;
        }

        // Se ci sono errori, ritorna un report leggibile
        report.Insert(0, "❌ Sono stati rilevati problemi nei dati climatici:\n\n");
        report.AppendLine("\nSuggerimento per GPT: riformatta i dati correttamente, o chiedi all'utente se ha copiato tutto il testo correttamente.");
        return report.ToString();
    }




    public void CaricaDatiDaTermodel()
    {
        DatiGenerali = ParserDatiTermodel.DatiGeneraliTermodel();
        string percorso = Path.Combine(GestProg.ProgramPath, "reportApe.txt");
        if (!File.Exists(percorso))
            return;

        string[] righe = File.ReadAllLines(percorso);

        for (int i = 0; i < righe.Length; i++)
        {
            var line = righe[i].Trim().Replace("[B]", "").Trim(':').Trim();

            if (line.StartsWith("Confine"))
            {
                confineUltimaParete = EstraiValore(line);
            }
            else if (line.StartsWith("Tipologia"))
            {
                string stratigrafia = EstraiValore(line);
                string tipo = "Parete"; // migliorabile con logica specifica

                double superficie = EstraiNumeroSuccessivo(righe, i, "superficie netta");
                double trasmittanza = EstraiNumeroSuccessivo(righe, i, "trasmittanza");

                componenti.Add(new ComponenteTermico
                {
                    Tipo = tipo,
                    Superficie = superficie,
                    Trasmittanza = trasmittanza,
                    FattoreCorrezione = CalcolaFattoreCorrezione(confineUltimaParete),
                    Confine = confineUltimaParete,
                    Stratigrafia = stratigrafia
                });
            }
            else if (line.StartsWith("Finestra"))
            {
                double superficie = EstraiNumeroSuccessivo(righe, i, "superficie");
                double trasmittanza = EstraiNumeroSuccessivo(righe, i, "trasmittanza");

                finestre.Add(new Finestra
                {
                    Superficie = superficie,
                    Trasmittanza = trasmittanza,
                    FattoreSolare = 0.8,
                    FattoreOmbreggiamento = 0.9,
                    IrradianzaStagionale = 350.0,
                    Confine = confineUltimaParete // fondamentale
                });
            }
            else if (line.StartsWith("Ponte termico"))
            {
                double lunghezza = EstraiNumeroSuccessivo(righe, i, "lunghezza");
                double trasmittanzaLineare = EstraiNumeroSuccessivo(righe, i, "trasmittanza lineare");

                pontiTermici.Add(new PonteTermico
                {
                    Lunghezza = lunghezza,
                    TrasmittanzaLineica = trasmittanzaLineare,
                    Confine = confineUltimaParete // associato alla parete precedente
                });
            }
        }
    }




    private string EstraiValore(string riga)
    {
        int idx = riga.IndexOf(":");
        return idx >= 0 ? riga.Substring(idx + 1).Trim() : "";
    }

    private double EstraiNumeroSuccessivo(string[] righe, int indicePartenza, string keyword)
    {
        for (int i = indicePartenza + 1; i < righe.Length; i++)
        {
            if (righe[i].Contains(keyword, StringComparison.OrdinalIgnoreCase))
            {
                var v = EstraiValore(righe[i]);
                v = v.Replace("m²", "").Replace("W/m²K", "").Trim();
                if (double.TryParse(v.Replace(",", "."), NumberStyles.Any, CultureInfo.InvariantCulture, out double val))
                    return val;
            }
        }
        return 0.0;
    }


    private double CalcolaFattoreCorrezione(string confine)
    {
        if (confine.ToLower().Contains("esterno")) return 1.0;
        if (confine.ToLower().Contains("non")) return 0.3;
        return 0.5;
    }
    public static double RecuperaTrasmittanzaStandard(string tipoElemento, string zonaClimatica)
    {
        // Mappa semplificata: (zona climatica) -> (tipo elemento) -> valore di trasmittanza [W/m²K]
        // I valori sono da aggiornare se cambiano le norme.
        var valoriStandard = new Dictionary<string, Dictionary<string, double>>
        {
            ["E"] = new Dictionary<string, double>
            {
                ["PareteOpacaVerticale"] = 0.26,
                ["Copertura"] = 0.22,
                ["Pavimento"] = 0.30,
                ["Serramento"] = 1.60  // vetro + telaio
            },
            ["D"] = new Dictionary<string, double>
            {
                ["PareteOpacaVerticale"] = 0.32,
                ["Copertura"] = 0.26,
                ["Pavimento"] = 0.36,
                ["Serramento"] = 1.80
            },
            ["F"] = new Dictionary<string, double>
            {
                ["PareteOpacaVerticale"] = 0.22,
                ["Copertura"] = 0.20,
                ["Pavimento"] = 0.28,
                ["Serramento"] = 1.40
            }
            // ... altre zone climatiche A-B-C se necessario
        };

        zonaClimatica = zonaClimatica.ToUpperInvariant();

        if (!valoriStandard.ContainsKey(zonaClimatica))
            throw new ArgumentException($"Zona climatica non gestita: {zonaClimatica}");

        var zona = valoriStandard[zonaClimatica];

        if (!zona.ContainsKey(tipoElemento))
            throw new ArgumentException($"Tipo elemento non gestito per zona {zonaClimatica}: {tipoElemento}");

        return zona[tipoElemento];
    }
    public static double RecuperaTrasmittanzaLineicaStandard(string tipoNodo)
    {
        // Valori indicativi basati su normative come UNI/TS 11300-1 e DM 26/06/2015
        // Nota: in una versione reale, sarebbe meglio caricare questi valori da un file XML o JSON
        tipoNodo = tipoNodo.ToLowerInvariant();

        switch (tipoNodo)
        {
            case "attacco solaio-parete":
                return 0.40; // [W/mK] valore medio di riferimento

            case "angolo pareti":
                return 0.30;

            case "giunto serramento":
                return 0.05;

            case "attacco a terra":
                return 0.35;

            case "attacco copertura":
                return 0.30;

            case "pilastro in parete":
                return 0.20;

            default:
                return 0.30; // valore prudenziale se tipo nodo non riconosciuto
        }
    }

    public double CalcolaHT(bool riferimento)
    {
        double HT_opaco = 0.0;
        double HT_finestra = 0.0;
        double HT_pontiTermici = 0.0;

        int numeroOpachi = 0;
        int numeroFinestre = 0;
        int numeroPonti = 0;

        // Componenti opachi
        foreach (var c in componenti)
        {
            double trasmittanza = riferimento
                ? RecuperaTrasmittanzaStandard("PareteOpacaVerticale", "D")
                : c.Trasmittanza;

            double btr = riferimento
                ? 1.0  // nell'edificio di riferimento NON si applicano correzioni
                : CalcolaFattoreCorrezione(c.Confine);

            HT_opaco += c.Superficie * trasmittanza * btr;
            numeroOpachi++;
        }

        // Finestre
        foreach (var f in finestre)
        {
            double btr = CalcolaFattoreCorrezione(f.Confine);

            double trasmittanza;
            if (riferimento)
            {
                // Usa valori standard per serramenti (vetro + telaio) secondo la zona climatica
                trasmittanza = RecuperaTrasmittanzaStandard("Serramento", "D");
            }
            else
            {
                trasmittanza = f.Trasmittanza;
            }

            HT_finestra += f.Superficie * trasmittanza * btr;
            numeroFinestre++;
        }

        // Ponti termici
        if (pontiTermici != null)
        {
            foreach (var p in pontiTermici)
            {
                double psi;
                if (riferimento)
                {
                    psi = RecuperaTrasmittanzaLineicaStandard("attacco solaio-parete");
                }
                else
                {
                    psi = p.TrasmittanzaLineica;
                }

                HT_pontiTermici += psi * p.Lunghezza;
                numeroPonti++;
            }
        }


        double HT_totale = HT_opaco + HT_finestra + HT_pontiTermici;
        DatiRisultatoAPE risape = Risultato.EdificioReale;
        if (riferimento) risape = Risultato.EdificioRiferimento;// Salvataggio nei risultati
        risape.HT_Opaco = HT_opaco;
        risape.HT_Finestra = HT_finestra;
        risape.HT_PontiTermici = HT_pontiTermici;
        risape.HT_Totale = HT_totale;

        Risultato.NumeroComponentiOpachi = numeroOpachi;
        Risultato.NumeroFinestre = numeroFinestre;
        Risultato.NumeroPontiTermici = numeroPonti;

        return HT_totale;
    }

    public double CalcolaHV(double volumeNetto, bool riferimento, double ricambioAriaUtente = 0.3)
    {
        double ricambioAria = riferimento ? 0.5 : ricambioAriaUtente;
        return 0.34 * ricambioAria * volumeNetto;
    }




    public double CalcolaQsConIrraggiamento(DatiIrraggiamento dati,bool riferimento)
    {
        double qsTotale = 0.0;

        var mesi = new[]
        {
        "gennaio", "febbraio", "marzo", "aprile", "maggio", "giugno",
        "luglio", "agosto", "settembre", "ottobre", "novembre", "dicembre"
    };

        var giorniPerMese = new Dictionary<string, int>
    {
        { "gennaio", 31 }, { "febbraio", 28 }, { "marzo", 31 },
        { "aprile", 30 }, { "maggio", 31 }, { "giugno", 30 },
        { "luglio", 31 }, { "agosto", 31 }, { "settembre", 30 },
        { "ottobre", 31 }, { "novembre", 30 }, { "dicembre", 31 }
    };

        const double FattoreTelaio = 0.87;       // riduzione per superficie effettiva vetrata
        const double FattoreInclinazione = 0.85; // correzione per esposizione verticale

        foreach (var finestra in finestre)
        {
            /* da definire
            string orientamento = finestra.Confine?.ToLower().Trim();
            if (string.IsNullOrEmpty(orientamento)) continue;

            if (!dati.Verticale.TryGetValue(orientamento, out var valoriMensili))
                continue;
            */
            foreach (var mese in mesi)
            {
                var Hs_j=dati.interpola_irraggiamento(0, mese);
                //if (!valoriMensili.TryGetValue(mese, out var Hs_j)) continue;

                int giorni = giorniPerMese[mese];

                double g = 0.63;// riferimento ? 0.63 : finestra.Trasmittanza; // oppure finestra.g se esiste
                double F_S = 1.0;//riferimento ? 1.0 : finestra.FattoreOmbreggiamento;

                double qsMese =
                    //giorni *è già un valore mensile
                    Hs_j *
                    finestra.Superficie *
                    FattoreTelaio *
                    g *
                    F_S *
                    FattoreInclinazione;

                qsTotale += qsMese;
            }
        }

        return qsTotale/3.6;//Mj to kw
    }



 
    public static string CalcolaClasseEnergetica(double EPglNren)
    {
        if (EPglNren <= 35.37) return "A4";
        else if (EPglNren <= 53.05) return "A3";
        else if (EPglNren <= 70.73) return "A2";
        else if (EPglNren <= 88.42) return "A1";
        else if (EPglNren <= 106.10) return "B";
        else if (EPglNren <= 132.63) return "C";
        else if (EPglNren <= 176.84) return "D";
        else if (EPglNren <= 229.89) return "E";
        else if (EPglNren <= 309.46) return "F";
        else return "G";
    }

    public string CalcolaClasseEnergeticaold(double EPglNren, double epRif = 80.0)
    {
        double rapporto = EPglNren / epRif;

        if (rapporto <= 0.40) return "A4";
        else if (rapporto <= 0.60) return "A3";
        else if (rapporto <= 0.80) return "A2";
        else if (rapporto <= 1.00) return "A1";
        else if (rapporto <= 1.20) return "B";
        else if (rapporto <= 1.50) return "C";
        else if (rapporto <= 2.00) return "D";
        else if (rapporto <= 2.60) return "E";
        else if (rapporto <= 3.50) return "F";
        else return "G";
    }
    public double CalcolaAPE(int gradiGiorno, double rendimento, double fattorePrimarioNren, bool riferimento)
    {
        double EP = 0;
        if (riferimento)
        {

        }
        else
        {
            CaricaDatiDaTermodel();
        }    
            double superficiePavimento = DatiGenerali.SuperficieNettaClimatizzata;
            double volumeNetto = DatiGenerali.VolumeNettoClimatizzato;

            // Calcolo HT (HT_Opaco, HT_Finestra, HT_Totale vengono salvati in Risultato)
            double HT = CalcolaHT(riferimento);

            double HV = CalcolaHV(volumeNetto, riferimento);
            double HTotale = HT + HV;

            double Qdisp = 0.024 * gradiGiorno * HTotale;
            
            double potenzaInterna = 4.0;
            int oreStagione = 3960;
            double Qi=potenzaInterna* superficiePavimento * oreStagione / 1000.0;

        
            double Qs = CalcolaQsConIrraggiamento(Dati_Irraggiamento, riferimento);

            double fx = 0.96;
            double QhUtile = Math.Max(Qdisp - fx * (Qi + Qs), 0.0);
            double energiaFinale = QhUtile / rendimento;
            EP = (energiaFinale * fattorePrimarioNren) / superficiePavimento;

          Risultato.RisultatiTermodelDaModello = DatiGenerali;

        DatiRisultatoAPE risape = Risultato.EdificioReale;
        if (riferimento) risape = Risultato.EdificioRiferimento;
        // Compilazione risultati
            risape.HV = HV;
            risape.QhDisp = Qdisp;
            risape.Qi = Qi;
            risape.Qs = Qs;
            risape.QhNetto = QhUtile;
            risape.EnergiaFinale = energiaFinale;
            risape.EPglNren = EP;
       
        return EP;
    }

    // Funzione realizzata da Codex in autonomia
    public void EseguiCalcoloDispersioni(XDocument doc)
    {
        if (doc == null)
            throw new ArgumentNullException(nameof(doc));

        componenti.Clear();
        finestre.Clear();
        pontiTermici.Clear();
        CaricaDatiDaTermodel();

        int gradiGiorno = 2000;
        int.TryParse(
            doc.Descendants("gradiGiorno").FirstOrDefault()?.Value,
            NumberStyles.Integer,
            CultureInfo.InvariantCulture,
            out gradiGiorno);
        if (gradiGiorno <= 0)
            gradiGiorno = 2000;

        double ht = CalcolaHT(riferimento: false);
        double hv = CalcolaHV(DatiGenerali.VolumeNettoClimatizzato, riferimento: false);

        Risultato.GradiGiorno = gradiGiorno;
        Risultato.RisultatiTermodelDaModello = DatiGenerali;
        Risultato.EdificioReale.HV = hv;
        Risultato.EdificioReale.QhDisp = 0.024 * gradiGiorno * (ht + hv);
    }


    public void EseguiCalcoloAPE(XDocument doc)
    {
  
    
    //var ape = new CalcoloAPE();

        // Parametri plausibili per il calcolo
        //int gradiGiorno = 2000;                // Zona climatica tipica (es. zona D)
        int gradiGiorno = int.Parse(
        doc.Descendants("gradiGiorno").FirstOrDefault()?.Value ?? "2000");
        
        
        //double rendimentoMedio = 0.94;nell'xml         // Rendimento medio impianto
        

        // Estrai rendimento di produzione (efficienza annuale del generatore)
        double rendimentoProduzione = double.Parse(
            (from generatore in doc.Descendants("generatore")
             let eff = generatore
                 .Element("datiGeneratore")?
                 .Element("risultati")?
                 .Element("valoriAnnuali")?
                 .Element("efficienza")
             where eff != null
             select eff.Value
            ).FirstOrDefault() ?? "0.85", // fallback se mancante
            CultureInfo.InvariantCulture);

        // Estrai rendimento medio di distribuzione (media su tutti i circuiti)
        var rendimentiDistribuzione = from circuito in doc.Descendants("circuito")
                                      let rendimento = circuito
                                          .Element("circuitoIdraulico")?
                                          .Element("rendimento")
                                      where rendimento != null
                                      select double.Parse(rendimento.Value, CultureInfo.InvariantCulture);

        double rendimentoDistribuzione = rendimentiDistribuzione.Any()
            ? rendimentiDistribuzione.Average()
            : 1.0; // fallback neutro se nessun circuito

        // Calcolo finale
        double rendimentoMedio = rendimentoProduzione * rendimentoDistribuzione;

        double fattorePrimarioNren = 1.95;     // Fattore conversione energia finale → primaria non rinnovabile
        
        //dati climatici e irraggiamento
        string path = Path.Combine(GestProg.PathProgDB, "Daticlimatici.cli");
        if (!File.Exists(path))
        throw new FileNotFoundException($"Il file dei dati climatici non è stato trovato: {path}");
        string input = File.ReadAllText(path);
        Dati_Irraggiamento =ParseIrraggiamento(input);
        //------------------------------

        // Calcolo APE
        double rendimentoRif = 0.95;
        double fattorePrimarioNrenRif = 1.95;
       CaricaDatiDaTermodel();
       double EPglRif = CalcolaAPE(gradiGiorno, rendimentoRif, fattorePrimarioNrenRif, riferimento: true);


        double EPglNren = CalcolaAPE(gradiGiorno, rendimentoMedio, fattorePrimarioNren, riferimento: false);
        
        string classe = CalcolaClasseEnergetica(EPglNren);
        //Salvataggio
        path = System.IO.Path.Combine(GestProg.PathProgDB, "RisultatiCalcoloAPE.xml");
        Risultato.SalvaXml(path);


        /* Recupero dati
       double HT_opaco = ape.Risultato.HT_Opaco;
       double HT_finestra = ape.Risultato.HT_Finestra;
       double HT_ponte = ape.Risultato.HT_PontiTermici;
       double HT_totale = ape.Risultato.HT_Totale;

       double superficie = ape.DatiGenerali.SuperficieNettaClimatizzata;
       double volume = ape.DatiGenerali.VolumeNettoClimatizzato;

       Messaggio dettagliato
       string messaggio = $"=== RISULTATI CALCOLO APE ===\n\n" +
                          $"Dati di base:\n" +
                          $"Superficie climatizzata = {superficie:F2} m²\n" +
                          $"Volume netto climatizzato = {volume:F2} m³\n\n" +
                          $"Numero componenti opachi = {ape.componenti.Count}\n" +
                          $"HT opaco      = {HT_opaco:F2} W/K\n" +
                          $"Numero finestre           = {ape.finestre.Count}\n" +
                          $"HT finestre   = {HT_finestra:F2} W/K\n" +
                          $"Numero ponti          = {ape.pontiTermici.Count}\n" +
                          $"HT ponti   = {HT_ponte:F2} W/K\n" +
                          $"HT totale     = {HT_totale:F2} W/K\n\n" +
                          $"HV ventilazione = {ape.Risultato.HV:F2} W/K\n\n" +
                          $"Qh,disp        = {ape.Risultato.QhDisp:F2} kWh/anno\n" +
                          $"Qi (interni)   = {ape.Risultato.Qi:F2} kWh/anno\n" +
                          $"Qs (solare)    = {ape.Risultato.Qs:F2} kWh/anno\n" +
                          $"Qh,netto       = {ape.Risultato.QhNetto:F2} kWh/anno\n" +
                          $"Energia finale = {ape.Risultato.EnergiaFinale:F2} kWh/anno\n" +
                          $"EPgl,nren      = {EPglNren:F2} kWh/m² anno\n\n" +
                          $"Classe Energetica: {classe}";

       // Output a video
       //MessageBox.Show(messaggio, "Risultato APE", MessageBoxButtons.OK, MessageBoxIcon.Information);
       */
    }


}
