using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.IO;
using System.Linq;
using System.Threading;
using System.Windows;
using Termodel.utilities;

namespace Termodel.Leggidxf
{
    public static class ComunicazioneAutoCad
    {
        private const int VersioneSchema = 1;
        private const string NomeCartella = "Plugin";
        private const string NomeFile = "form.json";
        private const string NomeFileRichiesta = "richiesta.json";
        private const string NomeFileCorrelati = "correlati.json";
        private static readonly object WatcherLock = new object();
        private static FileSystemWatcher? _watcher;
        private static Timer? _debounceTimer;
        private static UtiDb? _utiDb;
        private static ScriptCad? _scriptCad;
        private static long _ultimaRevisioneRichiesta;

        public static void AvviaGestoreRichieste(UtiDb utiDb, ScriptCad scriptCad)
        {
            ArrestaGestoreRichieste();

            _utiDb = utiDb;
            _scriptCad = scriptCad;

            string cartella = Path.Combine(GestProg.ProgramPath, NomeCartella);
            Directory.CreateDirectory(cartella);

            _watcher = new FileSystemWatcher(cartella, NomeFileRichiesta)
            {
                NotifyFilter =
                    NotifyFilters.FileName |
                    NotifyFilters.LastWrite |
                    NotifyFilters.CreationTime,
                EnableRaisingEvents = true
            };
            _watcher.Created += RichiestaModificata;
            _watcher.Changed += RichiestaModificata;
            _watcher.Renamed += RichiestaRinominata;
        }

        public static void ArrestaGestoreRichieste()
        {
            lock (WatcherLock)
            {
                _debounceTimer?.Dispose();
                _debounceTimer = null;

                if (_watcher != null)
                {
                    _watcher.EnableRaisingEvents = false;
                    _watcher.Created -= RichiestaModificata;
                    _watcher.Changed -= RichiestaModificata;
                    _watcher.Renamed -= RichiestaRinominata;
                    _watcher.Dispose();
                    _watcher = null;
                }
            }
        }

        public static bool AggiornaJsonAutocad(
            ObservableCollection<Dictionary<string, object>> datiCad)
        {
            try
            {
                JObject definizione = LeggiDefinizioneDatiCad();
                JObject valori = CreaValoriCorrenti(datiCad);
                JObject opzioni = CreaOpzioniRisolte(definizione);

                JObject documento = new JObject
                {
                    ["versioneSchema"] = VersioneSchema,
                    ["revisione"] = DateTime.UtcNow.Ticks,
                    ["generatoUtc"] = DateTime.UtcNow.ToString("O"),
                    ["progetto"] = new JObject
                    {
                        ["nome"] = GestProg.NomeProg ?? string.Empty,
                        ["percorso"] = PercorsoProgettoCorrente()
                    },
                    ["valori"] = valori,
                    ["definizione"] = definizione,
                    ["opzioni"] = opzioni
                };

                string cartella = Path.Combine(GestProg.ProgramPath, NomeCartella);
                string destinazione = Path.Combine(cartella, NomeFile);
                Directory.CreateDirectory(cartella);
                ScriviJsonAtomico(destinazione, documento);
                return true;
            }
            catch (Exception ex)
            {
                TermodelLog.LogError(
                    $"AggiornaJsonAutocad: impossibile aggiornare il JSON del plugin. {ex.Message}");
                return false;
            }
        }

        private static JObject LeggiDefinizioneDatiCad()
        {
            if (string.IsNullOrWhiteSpace(GestProg.metadataFilePath) ||
                !File.Exists(GestProg.metadataFilePath))
            {
                throw new FileNotFoundException(
                    "File definizionedati.json non trovato.",
                    GestProg.metadataFilePath);
            }

            JObject definizioni = JObject.Parse(
                File.ReadAllText(GestProg.metadataFilePath));

            return definizioni["DatiCad"] as JObject
                ?? throw new InvalidDataException(
                    "La sezione DatiCad non è presente in definizionedati.json.");
        }

        private static JObject CreaValoriCorrenti(
            ObservableCollection<Dictionary<string, object>> datiCad)
        {
            Dictionary<string, object> record =
                datiCad.FirstOrDefault() ?? new Dictionary<string, object>();

            return JObject.FromObject(record);
        }

        private static JObject CreaOpzioniRisolte(JObject definizione)
        {
            JObject risultato = new JObject();

            foreach (JProperty campo in definizione.Properties())
            {
                JArray combo = campo.Value["Combo"] as JArray;
                if (combo == null || combo.Count == 0)
                {
                    continue;
                }

                IEnumerable<string> valori;
                if (string.Equals(
                    combo[0]?.ToString(),
                    "auto_combo",
                    StringComparison.OrdinalIgnoreCase))
                {
                    valori = RisolviComboDaArchivio(combo);
                }
                else
                {
                    valori = combo
                        .Select(elemento => elemento?.ToString())
                        .Where(valore => !string.IsNullOrWhiteSpace(valore))
                        .Select(valore => valore!);
                }

                risultato[campo.Name] = new JArray(
                    valori.Distinct(StringComparer.OrdinalIgnoreCase));
            }

            return risultato;
        }

        private static IEnumerable<string> RisolviComboDaArchivio(JArray combo)
        {
            if (combo.Count < 3 || Database.DB == null)
            {
                return Enumerable.Empty<string>();
            }

            string nomeArchivio = combo[1]?.ToString() ?? string.Empty;
            string nomeCampo = combo[2]?.ToString() ?? string.Empty;

            if (string.IsNullOrWhiteSpace(nomeArchivio) ||
                string.IsNullOrWhiteSpace(nomeCampo))
            {
                return Enumerable.Empty<string>();
            }

            return Database.DB
                .GetCollection(nomeArchivio)
                .Where(record => record.ContainsKey(nomeCampo))
                .Select(record => record[nomeCampo]?.ToString())
                .Where(valore => !string.IsNullOrWhiteSpace(valore))
                .Select(valore => valore!);
        }

        private static string PercorsoProgettoCorrente()
        {
            if (string.IsNullOrWhiteSpace(GestProg.ProgettiPath) ||
                string.IsNullOrWhiteSpace(GestProg.NomeProg))
            {
                return string.Empty;
            }

            return GestProg.PathProg;
        }

        private static void ScriviJsonAtomico(string destinazione, JObject documento)
        {
            string temporaneo = destinazione + ".tmp";
            File.WriteAllText(
                temporaneo,
                documento.ToString(Formatting.Indented));
            File.Move(temporaneo, destinazione, true);
        }

        private static void RichiestaModificata(object sender, FileSystemEventArgs e)
        {
            PianificaElaborazioneRichiesta();
        }

        private static void RichiestaRinominata(object sender, RenamedEventArgs e)
        {
            PianificaElaborazioneRichiesta();
        }

        private static void PianificaElaborazioneRichiesta()
        {
            lock (WatcherLock)
            {
                _debounceTimer?.Dispose();
                _debounceTimer = new Timer(
                    _ => ElaboraRichiestaSulThreadPrincipale(),
                    null,
                    250,
                    Timeout.Infinite);
            }
        }

        private static void ElaboraRichiestaSulThreadPrincipale()
        {
            if (Application.Current?.Dispatcher == null)
            {
                TermodelLog.LogError(
                    "AggiornaScript da plugin: dispatcher WPF non disponibile.");
                return;
            }

            Application.Current.Dispatcher.BeginInvoke(
                new Action(ElaboraRichiesta));
        }

        private static void ElaboraRichiesta()
        {
            if (_utiDb == null || _scriptCad == null)
            {
                return;
            }

            string richiestaPath = Path.Combine(
                GestProg.ProgramPath,
                NomeCartella,
                NomeFileRichiesta);

            try
            {
                if (!File.Exists(richiestaPath))
                {
                    return;
                }

                JObject richiesta = JObject.Parse(File.ReadAllText(richiestaPath));
                string azione = richiesta["azione"]?.ToString() ?? string.Empty;
                long revisione = richiesta["revisione"]?.Value<long>() ?? 0;
                if (revisione <= _ultimaRevisioneRichiesta)
                {
                    return;
                }

                JObject valori = richiesta["valori"] as JObject
                    ?? throw new InvalidDataException(
                        $"La richiesta {azione} non contiene l'oggetto valori.");

                if (string.Equals(
                    azione,
                    "AggiornaCorrelati",
                    StringComparison.OrdinalIgnoreCase))
                {
                    AggiornaCorrelati(valori, revisione);
                    _ultimaRevisioneRichiesta = revisione;
                    File.Delete(richiestaPath);
                    return;
                }

                if (!string.Equals(
                    azione,
                    "AggiornaScript",
                    StringComparison.OrdinalIgnoreCase))
                {
                    TermodelLog.LogError(
                        $"Richiesta plugin ignorata: azione '{azione}' non supportata.");
                    return;
                }

                ObservableCollection<Dictionary<string, object>> datiCad =
                    _utiDb.GetCollection("DatiCad");
                if (datiCad.Count == 0)
                {
                    throw new InvalidDataException(
                        "La collezione DatiCad è vuota.");
                }

                Dictionary<string, object> record = datiCad[0];
                foreach (JProperty valore in valori.Properties())
                {
                    if (record.ContainsKey(valore.Name))
                    {
                        record[valore.Name] =
                            valore.Value.Type == JTokenType.Null
                                ? string.Empty
                                : valore.Value.ToString();
                    }
                }

                _utiDb.CompilaCorrelati("DatiCad");
                _utiDb.SaveData("DatiCad");
                _scriptCad.Script_Disegna(datiCad);
                _ultimaRevisioneRichiesta = revisione;
                File.Delete(richiestaPath);
            }
            catch (Exception ex)
            {
                TermodelLog.LogError(
                    $"AggiornaScript da plugin: richiesta non elaborata. {ex.Message}");
            }
        }

        private static void AggiornaCorrelati(JObject valori, long revisione)
        {
            if (_utiDb == null)
            {
                return;
            }

            JObject definizione = LeggiDefinizioneDatiCad();
            JObject correlati = new JObject();

            foreach (JProperty campo in definizione.Properties())
            {
                JArray relazione = campo.Value["Correlato"] as JArray;
                if (relazione == null || relazione.Count < 4)
                {
                    continue;
                }

                string archivio = relazione[0]?.ToString() ?? string.Empty;
                string campoSelezione = relazione[1]?.ToString() ?? string.Empty;
                string chiaveArchivio = relazione[2]?.ToString() ?? string.Empty;
                string campoRisultato = relazione[3]?.ToString() ?? string.Empty;
                string selezione = valori[campoSelezione]?.ToString() ?? string.Empty;

                Dictionary<string, object>? record = _utiDb
                    .GetCollection(archivio)
                    .FirstOrDefault(item =>
                        item.TryGetValue(chiaveArchivio, out object? chiave) &&
                        string.Equals(
                            chiave?.ToString(),
                            selezione,
                            StringComparison.Ordinal));

                correlati[campo.Name] =
                    record != null &&
                    record.TryGetValue(campoRisultato, out object? risultato)
                        ? risultato?.ToString() ?? string.Empty
                        : string.Empty;
            }

            JObject risposta = new JObject
            {
                ["versioneSchema"] = VersioneSchema,
                ["revisione"] = revisione,
                ["valori"] = correlati
            };

            string destinazione = Path.Combine(
                GestProg.ProgramPath,
                NomeCartella,
                NomeFileCorrelati);
            ScriviJsonAtomico(destinazione, risposta);
        }
    }
}
