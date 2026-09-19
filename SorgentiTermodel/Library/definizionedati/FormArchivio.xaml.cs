using System.Collections.Generic;
using System.Windows;
using System.Windows.Controls;
using Newtonsoft.Json.Linq;
using Termodel.utilities;
using System.Collections.ObjectModel;
using System.IO;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Dynamic;
using System.IO;
using System.Linq;
using System.Windows;
using System.Windows.Controls;
using Newtonsoft.Json.Linq;
using Termodel.utilities;
using System.Security.Cryptography.X509Certificates;
using System.Windows.Data;
using System.Windows.Media;
using System.Windows.Input;
using System.Windows.Markup;
using static System.Windows.Forms.VisualStyles.VisualStyleElement;
using System.Globalization;
using Termodel.Pareti.Editor.Views;
using Termodel.Finestre.Editor.Views;

namespace Termodel.definizionedati
{
    public partial class FormArchivio : System.Windows.Window 
    {
        private ObservableCollection<Dictionary<string, object>> archivio;
        private Dictionary<string, AutoForm.CampoMeta> schema;

        // ✅ Proprietà pubbliche
        public string NomeArchivio { get; private set; }
        public string TipoForm { get; private set; }
        private int indiceCorrente = -1;
        public bool Modifiche { get; private set; } = false;
        public bool Datimodificati { get; private set; } = false;
        public FormArchivio(string nomeArchivio, string tipoform)
        {
            InitializeComponent();
            WindowPositionManager.CentroSchermo(this);
            // Modificato da Codex per realizzare: mostrare l'accesso al nuovo compositore soltanto nell'archivio Pareti.
            BtnCreaStratigrafia.Visibility = nomeArchivio == "Pareti" ? Visibility.Visible : Visibility.Collapsed;
            // Modificato da Codex per realizzare: mostrare l'accesso al ModelSpace Finestre soltanto nell'archivio Finestre.
            BtnCreaFinestra.Visibility = nomeArchivio == "Finestre" ? Visibility.Visible : Visibility.Collapsed;
            // Lista degli archivi in cui i comandi di modifica riga sono disattivati
            // 👇 ARCHIVI CON RESTRIZIONI
            var archiviProtetti = new[] { "Finestre", "Pareti", "Ponti", "Zone" };
            if (archiviProtetti.Contains(nomeArchivio))
            {
                BtnAggiungi.Visibility = Visibility.Collapsed;
                BtnAggiungiPrima.Visibility = Visibility.Collapsed;
                BtnCancella.Visibility = Visibility.Collapsed;
            }
            else
            {
                LabelXmlInfo.Visibility = Visibility.Collapsed;
                BtnCaricaDaXml.Visibility = Visibility.Collapsed;
            }


            NomeArchivio = nomeArchivio;
            TipoForm = tipoform;
            this.Title = $"Gestione archivio \"{nomeArchivio}\""; // ✅ Titolo finestra

            archivio = Database.DB.GetCollection(NomeArchivio);

            // 1. Carica schema
            var json = File.ReadAllText(GestProg.metadataFilePath);
            var root = JObject.Parse(json);
            schema = root[NomeArchivio].ToObject<Dictionary<string, AutoForm.CampoMeta>>();

            // 2. Crea form dettagliata
            AutoForm.GeneraForm(AutoFormGrid, schema, TipoForm, NomeArchivio);

            // 3. Configura ComboBox dinamici
            Database.DB.ConfigureForm(AutoFormGrid, NomeArchivio);

            // 4. Genera intestazioni DataGrid
            CreaColonneGrid();

            // 5. Mostra la prima riga
            indiceCorrente = 0;
            Database.DB.LeggiForm(NomeArchivio, AutoFormGrid, indiceCorrente);
            AggiornaForm();
        }

        private void CreaColonneGrid()
        {
            ArchivioGrid.Columns.Clear();

            var colonneDaVisualizzare = schema
                .Where(kvp => kvp.Value.Grid != null && kvp.Value.Grid.Contains(TipoForm))
                .Select(kvp => kvp.Key)
                .ToList();

            foreach (var col in colonneDaVisualizzare)
            {
                ArchivioGrid.Columns.Add(new DataGridTextColumn
                {
                    Header = schema[col].Descr ?? col,
                    Binding = new Binding(col)
                });
            }
        }

        public void AggiornaForm()
            { 
            // 🔹 Carica metadati dallo schema JSON
            var json = File.ReadAllText(GestProg.metadataFilePath);
            var root = JObject.Parse(json);
            schema = root[NomeArchivio].ToObject<Dictionary<string, AutoForm.CampoMeta>>();

            // 🔍 Estrai i nomi dei campi da visualizzare nel tipoform richiesto
            var colonneDaVisualizzare = schema
                .Where(kvp => kvp.Value.Grid != null && kvp.Value.Grid.Contains(TipoForm))
                .Select(kvp => kvp.Key)
                .ToList();

            // 🔄 Crea vista dinamica usando ExpandoObject per il DataGrid
            var filteredView = new ObservableCollection<ExpandoObject>();

            foreach (var riga in archivio)
            {
                dynamic nuova = new ExpandoObject();
                var dict = (IDictionary<string, object>)nuova;

                foreach (var col in colonneDaVisualizzare)
                {
                    if (riga.ContainsKey(col))
                        dict[col] = riga[col];
                }

                // 🔁 Collegamento alla riga originale per il dettaglio
                dict["_rigaOriginale"] = riga;

                filteredView.Add(nuova);
            }
            ArchivioGrid.Columns.Clear();

            foreach (var col in colonneDaVisualizzare)
            {
                ArchivioGrid.Columns.Add(new DataGridTextColumn
                {
                    Header = schema.ContainsKey(col) ? schema[col].Descr ?? col : col,
                    Binding = new System.Windows.Data.Binding(col)
                });
            }
            ArchivioGrid.ItemsSource = filteredView;
            ArchivioGrid.SelectedIndex = 0; // ✅ evidenzia la prima riga visivamente
        }
        private void AggiornaRigheGriglia()
        {
            var colonneDaVisualizzare = schema
                .Where(kvp => kvp.Value.Grid != null && kvp.Value.Grid.Contains(TipoForm))
                .Select(kvp => kvp.Key)
                .ToList();

            var filteredView = new ObservableCollection<ExpandoObject>();

            foreach (var riga in archivio)
            {
                dynamic nuova = new ExpandoObject();
                var dict = (IDictionary<string, object>)nuova;

                foreach (var col in colonneDaVisualizzare)
                {
                    if (riga.ContainsKey(col))
                        dict[col] = riga[col];
                }

                dict["_rigaOriginale"] = riga;
                filteredView.Add(nuova);
            }

            ArchivioGrid.ItemsSource = filteredView;
        }

        private void AggiornaRigaVisuale(int indice)
        {
            if (indice < 0 || indice >= archivio.Count)
                return;

            var rigaOriginale = archivio[indice];

            // Trova l'oggetto visuale corrispondente nel DataGrid
            foreach (ExpandoObject item in ArchivioGrid.ItemsSource)
            {
                var dict = (IDictionary<string, object>)item;
                if (dict.TryGetValue("_rigaOriginale", out object obj) && obj == rigaOriginale)
                {
                    foreach (var col in schema.Keys)
                    {
                        if (schema[col].Grid != null && schema[col].Grid.Contains(TipoForm))
                        {
                            if (rigaOriginale.ContainsKey(col))
                                dict[col] = rigaOriginale[col];
                        }
                    }

                    // Forza aggiornamento visivo
                    CollectionViewSource.GetDefaultView(ArchivioGrid.ItemsSource).Refresh();
                    break;
                }
            }
        }

 

        private void ArchivioGrid_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {
            // 🔸 Forza la perdita del focus per registrare l'ultima modifica
            Keyboard.ClearFocus();
            // 🔸 Salva la riga precedente prima di cambiare selezione
            if (indiceCorrente >= 0 && indiceCorrente < archivio.Count)
            {
                AutoForm.SalvaAutoForm(AutoFormGrid, NomeArchivio, indiceCorrente);
                AggiornaRigaVisuale(indiceCorrente); // 🔁 refresh
            }

            // 🔸 Carica nuova riga
            if (ArchivioGrid.SelectedItem is ExpandoObject expando)
            {
                var dict = (IDictionary<string, object>)expando;
                if (dict.TryGetValue("_rigaOriginale", out object rigaOriginale) &&
                    rigaOriginale is Dictionary<string, object> riga)
                {
                    indiceCorrente = archivio.IndexOf(riga);
                    Database.DB.LeggiForm(NomeArchivio, AutoFormGrid, indiceCorrente);// compila la form
                }
            }
        }



        private void Salva_Click(object sender, RoutedEventArgs e)
        {
            if (indiceCorrente >= 0 && indiceCorrente < archivio.Count)
            {
                AutoForm.SalvaAutoForm(AutoFormGrid, NomeArchivio, indiceCorrente);
                AggiornaRigaVisuale(indiceCorrente);
            }
            Database.DB.SaveData(NomeArchivio);
            MessageBox.Show("Modifiche all'archivio salvati sulla memoria esterna.");
            Datimodificati = true;
            Modifiche=false;
        }
        private void InserisciRigaPrima_Click(object sender, RoutedEventArgs e)
        {
            if (ArchivioGrid.SelectedItem is ExpandoObject expando)
            {
                var dict = (IDictionary<string, object>)expando;
                if (dict.TryGetValue("_rigaOriginale", out object rigaOriginale) &&
                    rigaOriginale is Dictionary<string, object> selectedRiga)
                {
                    int selectedIndex = archivio.IndexOf(selectedRiga);
                    if (selectedIndex == -1)
                    {
                        MessageBox.Show("Indice non trovato.");
                        return;
                    }

                    var newRow = Database.DB.CreaRigaInizializzata(NomeArchivio);
                    if (newRow == null)
                    {
                        MessageBox.Show("Impossibile creare la riga inizializzata.");
                        return;
                    }
                    Modifiche = true;
                    archivio.Insert(selectedIndex, newRow);
                    AggiornaForm();
                    ArchivioGrid.SelectedIndex = selectedIndex;
                }
            }
            else
            {
                MessageBox.Show("Seleziona una riga nella griglia.");
            }
        }


        public void Aggiungi_Click(object sender, RoutedEventArgs e)
        {
            Database.DB.AddEmptyRowToCollection(NomeArchivio);
            AggiornaForm();
            Modifiche = true;
        }
        private void Cancella_Click(object sender, RoutedEventArgs e)
        {
            if (ArchivioGrid.SelectedItem is ExpandoObject expando)
            {
                var dict = (IDictionary<string, object>)expando;
                if (dict.TryGetValue("_rigaOriginale", out object rigaOriginale) &&
                    rigaOriginale is Dictionary<string, object> riga)
                {
                    int index = archivio.IndexOf(riga);
                    if (index >= 0)
                    {
                        var result = MessageBox.Show("Confermi l'eliminazione della riga selezionata?", "Conferma", MessageBoxButton.YesNo);
                        if (result == MessageBoxResult.Yes)
                        {
                            archivio.RemoveAt(index);
                            Modifiche = true;
                            AggiornaForm();
                        }
                    }
                }
            }
            else
            {
                MessageBox.Show("Seleziona una riga da eliminare.");
            }
        }

        private void XML_Click(object sender, RoutedEventArgs e)
        {
            var risultato = MessageBox.Show(
                "⚠️ Tutte le modifiche dopo l'ultimo aggiornamento da XML verranno perse.\nVuoi continuare?",
                "Conferma caricamento da XML",
                MessageBoxButton.YesNo,
                MessageBoxImage.Warning
            );

            if (risultato == MessageBoxResult.Yes)
            {
                try
                {
                    if(NomeArchivio=="Zone")
                    GestXml.LoadZoneFromXML(GestProg.FileXMLPath, Database.DB.GetCollection("Zone"));
                    if (NomeArchivio == "Pareti")
                        GestXml.LoadParetiCollectionFromXml(GestProg.FileXMLPath, Database.DB.GetCollection("Pareti"));
                    if (NomeArchivio == "Finestre")
                        GestXml.LoadFinestreCollectionFromXml(GestProg.FileXMLPath, Database.DB.GetCollection("Finestre"));
                    if (NomeArchivio == "Ponti")
                        GestXml.LoadPontiCollectionFromXml_file(Database.DB.GetCollection("Ponti"));

                    MessageBox.Show("Caricamento da XML completato con successo.", "OK", MessageBoxButton.OK, MessageBoxImage.Information);

                    // 🔁 Ricarica l'interfaccia
                    indiceCorrente = 0;
                    Database.DB.LeggiForm(NomeArchivio, AutoFormGrid, indiceCorrente);
                    AggiornaForm();
                }
                catch (Exception ex)
                {
                    MessageBox.Show($"Errore durante il caricamento da XML:\n{ex.Message}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                }
            }
        }

        // Funzione realizzata da Codex in autonomia
        private void CreaStratigrafia_Click(object sender, RoutedEventArgs e)
        {
            var editor = new ParetiEditorWindow
            {
                Owner = this
            };

            if (editor.ShowDialog() != true || editor.Risultato is null)
            {
                return;
            }

            var risultato = editor.Risultato;
            var nuovaParete = Database.DB.CreaRigaInizializzata("Pareti");
            if (nuovaParete is null)
            {
                MessageBox.Show("Impossibile inizializzare la nuova parete.", "Crea stratigrafia", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            nuovaParete["Codice"] = GeneraCodiceParete();
            nuovaParete["DescBreve"] = risultato.Nome;
            nuovaParete["Colore"] = TrovaColoreCadDisponibile();
            nuovaParete["Spessore"] = risultato.SpessoreMetri.ToString("0.000", CultureInfo.InvariantCulture);
            nuovaParete["Trasmittanza"] = risultato.Trasmittanza.ToString("0.000", CultureInfo.InvariantCulture);
            nuovaParete["Descrizione"] = risultato.Descrizione;
            nuovaParete["PontiAutomatici"] = "Parete";
            nuovaParete["StratigrafiaJson"] = risultato.StratigrafiaJson;

            archivio.Add(nuovaParete);
            Modifiche = true;
            AggiornaForm();
            ArchivioGrid.SelectedIndex = archivio.Count - 1;
            ArchivioGrid.ScrollIntoView(ArchivioGrid.SelectedItem);

            MessageBox.Show(
                "La nuova stratigrafia è stata aggiunta all'archivio. Premi Salva per scriverla nel file Pareti.xml.",
                "Crea stratigrafia",
                MessageBoxButton.OK,
                MessageBoxImage.Information);
        }

        // Funzione realizzata da Codex in autonomia
        private string GeneraCodiceParete()
        {
            int progressivo = 1;
            while (archivio.Any(riga =>
                       riga.TryGetValue("Codice", out var valore) &&
                       string.Equals(valore?.ToString(), $"USR-{progressivo:000}", StringComparison.OrdinalIgnoreCase)))
            {
                progressivo++;
            }

            return $"USR-{progressivo:000}";
        }

        // Funzione realizzata da Codex in autonomia
        private void CreaFinestra_Click(object sender, RoutedEventArgs e)
        {
            var editor = new FinestreEditorWindow
            {
                Owner = this
            };

            if (editor.ShowDialog() != true || editor.Risultato is null)
            {
                return;
            }

            var risultato = editor.Risultato;
            var nuovaFinestra = Database.DB.CreaRigaInizializzata("Finestre");
            if (nuovaFinestra is null)
            {
                MessageBox.Show("Impossibile inizializzare la nuova finestra.", "Crea finestra", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            nuovaFinestra["Codice"] = GeneraCodiceFinestra();
            nuovaFinestra["DescBreve"] = risultato.Nome;
            nuovaFinestra["Descrizione"] = risultato.Descrizione;
            nuovaFinestra["Finestrata"] = "Finestra semplice";
            nuovaFinestra["RipetizioneVerticaleIntervallo"] = "0";
            nuovaFinestra["RipetizioneVerticaleQuota"] = "0";
            nuovaFinestra["LarghezzaProfiloTelaio"] = risultato.LarghezzaProfiloMetri.ToString("0.000", CultureInfo.InvariantCulture);
            nuovaFinestra["PontiAutomatici"] = "Nessuno";
            nuovaFinestra["FinestraJson"] = risultato.FinestraJson;
            nuovaFinestra["TrasmittanzaTelaio"] = risultato.TrasmittanzaTelaio.ToString("0.000", CultureInfo.InvariantCulture);
            nuovaFinestra["TrasmittanzaVetro"] = risultato.TrasmittanzaVetro.ToString("0.000", CultureInfo.InvariantCulture);
            nuovaFinestra["TrasmittanzaDistanziatore"] = risultato.TrasmittanzaDistanziatore.ToString("0.000", CultureInfo.InvariantCulture);
            nuovaFinestra["TrasmittanzaFinestra"] = risultato.TrasmittanzaFinestra.ToString("0.000", CultureInfo.InvariantCulture);

            archivio.Add(nuovaFinestra);
            Modifiche = true;
            AggiornaForm();
            ArchivioGrid.SelectedIndex = archivio.Count - 1;
            ArchivioGrid.ScrollIntoView(ArchivioGrid.SelectedItem);

            MessageBox.Show(
                "La nuova finestra è stata aggiunta all'archivio. Premi Salva per scriverla nel file Finestre.xml.",
                "Crea finestra",
                MessageBoxButton.OK,
                MessageBoxImage.Information);
        }

        // Funzione realizzata da Codex in autonomia
        private string GeneraCodiceFinestra()
        {
            int progressivo = 1;
            while (archivio.Any(riga =>
                       riga.TryGetValue("Codice", out var valore) &&
                       string.Equals(valore?.ToString(), $"USR-FN-{progressivo:000}", StringComparison.OrdinalIgnoreCase)))
            {
                progressivo++;
            }

            return $"USR-FN-{progressivo:000}";
        }

        // Funzione realizzata da Codex in autonomia
        private string TrovaColoreCadDisponibile()
        {
            string[] colori =
            {
                "1 - Rosso", "2 - Giallo", "3 - Verde", "4 - Ciano", "5 - Blu",
                "6 - Magenta", "7 - Bianco/Nero", "8 - Grigio", "9 - Grigio Scuro"
            };

            var coloriUsati = archivio
                .Where(riga => riga.TryGetValue("Colore", out _))
                .Select(riga => riga["Colore"]?.ToString())
                .Where(valore => !string.IsNullOrWhiteSpace(valore))
                .ToHashSet(StringComparer.OrdinalIgnoreCase);

            return colori.FirstOrDefault(colore => !coloriUsati.Contains(colore)) ?? "7 - Bianco/Nero";
        }

 
        private void Chiudi_Click(object sender, RoutedEventArgs e)
        {
            if (Modifiche)
            {
                var result = MessageBox.Show(
                "Sicuri di non voler salvare le modifiche?",
                "Conferma chiusura",
                MessageBoxButton.YesNo,
                MessageBoxImage.Warning
                );

                if (result == MessageBoxResult.Yes)
                {
                    this.DialogResult = Datimodificati;
                    this.Close();
                }
            }
            else
            {
                this.DialogResult = Datimodificati;
                this.Close();
            }
            
        }
    }
}

