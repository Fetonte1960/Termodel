using System;
using System.Windows;
using System.Windows.Controls;
using Xbim.IO.Xml.BsConf;

namespace Termodel.utilities
{
    public partial class FiltriGrafici : UserControl
    {
        public FiltriGrafici()
        {
            InitializeComponent();
            FiltroComponentiItem.Items.Add(CreaCheckBox("Parete"));
            FiltroComponentiItem.Items.Add(CreaCheckBox("Pavimento"));
            FiltroComponentiItem.Items.Add(CreaCheckBox("Soffitto"));
            FiltroComponentiItem.Items.Add(CreaCheckBox("Finestra"));
            FiltroComponentiItem.Items.Add(CreaCheckBox("Ponte"));
            FiltroComponentiItem.Items.Add(CreaCheckBox("Falda"));
            FiltroComponentiItem.Items.Add(CreaCheckBox("Mansardato"));
            // Modificato da Codex per realizzare: attivare a comando la vista fil di ferro di spirali e ponti termici.
            FiltroComponentiItem.Items.Add(CreaCheckBox("Pannelli", false));
            FiltroConfiniItem.Items.Add(CreaCheckBox("Esterno"));
            FiltroConfiniItem.Items.Add(CreaCheckBox("Terreno"));
            FiltroConfiniItem.Items.Add(CreaCheckBox("AmbienteNonClimatizzato"));
            FiltroConfiniItem.Items.Add(CreaCheckBox("AmbienteClimatizzato"));
            FiltroConfiniItem.Items.Add(CreaCheckBox("StessaZona"));
            FiltroSeparazioneItem.Items.Add(CreaCheckBox("Separatori"));
            FiltroSeparazioneItem.Items.Add(CreaCheckBox("NonSeparatori"));
            FiltroSeparazioneItem.Items.Add(CreaCheckBox("Fittizie", false));
         //   FiltroLineeCotruzioneItem.Items.Add(CreaCheckBox("Linee di costruzione", false));
        }

        // Evento pubblico unico che viene sollevato quando cambia lo stato di qualsiasi filtro
        public event EventHandler<FiltriChangedEventArgs> FiltriChanged;

        /// <summary>
        /// Aggiunge un nuovo piano al filtro "Piani".
        /// </summary>
        /// <param name="nomePiano">Nome del piano da aggiungere.</param>
        /// 
        public TreeViewItem CreaCheckBox(string _Content,bool check=true)
        {
            // Crea un nuovo CheckBox per rappresentare il piano
            CheckBox checkBox = new CheckBox
            {
                Content = _Content,
                Margin = new Thickness(5, 0, 0, 0),
                IsChecked = check // Imposta il CheckBox come selezionato
            };
            checkBox.Checked += CheckBoxFiltro_Changed;
            checkBox.Unchecked += CheckBoxFiltro_Changed;

            // Crea un nuovo TreeViewItem e aggiunge il CheckBox al suo Header
            TreeViewItem nuovoItem = new TreeViewItem
            {
                Header = new StackPanel
                {
                    Orientation = Orientation.Horizontal,
                    Children = { checkBox }
                }
            };
            return nuovoItem;
        }
        public void AddPiano(string nomePiano)
        {
            /*
            // Crea un nuovo CheckBox per rappresentare il piano
            CheckBox checkBoxPiano = new CheckBox
            {
                Content = nomePiano,
                Margin = new Thickness(5, 0, 0, 0),
                IsChecked = true // Imposta il CheckBox come selezionato
            };
            checkBoxPiano.Checked += CheckBoxFiltro_Changed;
            checkBoxPiano.Unchecked += CheckBoxFiltro_Changed;

            // Crea un nuovo TreeViewItem e aggiunge il CheckBox al suo Header
            TreeViewItem nuovoPianoItem = new TreeViewItem
            {
                Header = new StackPanel
                {
                    Orientation = Orientation.Horizontal,
                    Children = { checkBoxPiano }
                }
            };
            */
            // Aggiungi il nuovo piano al filtro "Piani"
            FiltroPianiItem.Items.Add(CreaCheckBox(nomePiano));
        }

        /// <summary>
        /// Rimuove tutti i piani dal filtro "Piani".
        /// </summary>
        public void CancellaPiani()
        {
            // Rimuovi tutti gli elementi figlio del filtro "Piani"
            FiltroPianiItem.Items.Clear();
        }
        
        /// <summary>
        /// Verifica se il piano specificato è stato filtrato (attivato).
        /// </summary>
        /// <param name="nomePiano">Nome del piano da verificare.</param>
        /// <returns>True se il piano è filtrato (CheckBox selezionato), false altrimenti.</returns>
        public bool PianoFiltrato(string nomePiano)
        {
            // Itera sugli elementi di FiltroPianiItem per cercare il piano
            foreach (TreeViewItem item in FiltroPianiItem.Items)
            {
                if (item.Header is StackPanel stackPanel)
                {
                    // Cerca il CheckBox all'interno dello StackPanel
                    foreach (var child in stackPanel.Children)
                    {
                        if (child is CheckBox checkBox && checkBox.Content.ToString() == nomePiano)
                        {
                            // Restituisce true se il CheckBox è selezionato, altrimenti false
                            return checkBox.IsChecked == true;
                        }
                    }
                }
            }

            // Se non è stato trovato, ritorna false
            return false;
        }
        public bool ComponenteFiltrato(string NomeComponente)
        {
            // Itera sugli elementi di FiltroPianiItem per cercare il piano
            foreach (TreeViewItem item in FiltroComponentiItem.Items)
            {
                if (item.Header is StackPanel stackPanel)
                {
                    // Cerca il CheckBox all'interno dello StackPanel
                    foreach (var child in stackPanel.Children)
                    {
                        if (child is CheckBox checkBox && checkBox.Content.ToString() == NomeComponente)
                        {
                            // Restituisce true se il CheckBox è selezionato, altrimenti false
                            return checkBox.IsChecked == true;
                        }
                    }
                }
            }


            // Se non è stato trovato, ritorna false
            return false;
        }
        public bool Lineeiltrate(string NomeComponente)
        {
            // Itera sugli elementi di FiltroPianiItem per cercare il piano
            foreach (TreeViewItem item in FiltroLineeCotruzioneItem.Items)
            {
                if (item.Header is StackPanel stackPanel)
                {
                    // Cerca il CheckBox all'interno dello StackPanel
                    foreach (var child in stackPanel.Children)
                    {
                        if (child is CheckBox checkBox && checkBox.Content.ToString() == NomeComponente)
                        {
                            // Restituisce true se il CheckBox è selezionato, altrimenti false
                            return checkBox.IsChecked == true;
                        }
                    }
                }
            }


            // Se non è stato trovato, ritorna false
            return false;
        }
        public bool ConfineFiltrato(string NomeComponente)
        {
            // Itera sugli elementi di FiltroPianiItem per cercare il piano
            foreach (TreeViewItem item in FiltroConfiniItem.Items)
            {
                if (item.Header is StackPanel stackPanel)
                {
                    // Cerca il CheckBox all'interno dello StackPanel
                    foreach (var child in stackPanel.Children)
                    {
                        if (child is CheckBox checkBox && checkBox.Content.ToString() == NomeComponente)
                        {
                            // Restituisce true se il CheckBox è selezionato, altrimenti false
                            return checkBox.IsChecked == true;
                        }
                    }
                }
            }

            // Se non è stato trovato, ritorna false
            return false;
        }
        public bool SeparatoreFiltrato(string NomeComponente)
        {
            // Itera sugli elementi di FiltroPianiItem per cercare il piano
            foreach (TreeViewItem item in FiltroSeparazioneItem.Items)
            {
                if (item.Header is StackPanel stackPanel)
                {
                    // Cerca il CheckBox all'interno dello StackPanel
                    foreach (var child in stackPanel.Children)
                    {
                        if (child is CheckBox checkBox && checkBox.Content.ToString() == NomeComponente)
                        {
                            // Restituisce true se il CheckBox è selezionato, altrimenti false
                            return checkBox.IsChecked == true;
                        }
                    }
                }
            }

            // Se non è stato trovato, ritorna false
            return false;
        }
        /// <summary>
        /// Gestisce il cambiamento di stato dei CheckBox di tutti i filtri.
        /// </summary>
        private void CheckBoxFiltro_Changed(object sender, RoutedEventArgs e)
        {
            if (sender is CheckBox checkBox)
            {
                // Solleva l'evento FiltriChanged per notificare l'esterno del cambiamento
                FiltriChanged?.Invoke(this, new FiltriChangedEventArgs(checkBox.Content.ToString(), checkBox.IsChecked == true));
            }
        }
    }

    /// <summary>
    /// Classe per contenere i dati dell'evento FiltriChanged.
    /// </summary>
    public class FiltriChangedEventArgs : EventArgs
    {
        public string NomeFiltro { get; }
        public bool IsChecked { get; }

        public FiltriChangedEventArgs(string nomeFiltro, bool isChecked)
        {
            NomeFiltro = nomeFiltro;
            IsChecked = isChecked;
        }
    }
}
