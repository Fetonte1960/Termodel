using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Termodel.utilities;
using System.Windows;
using Termodel.definizionedati;
using System.Windows.Controls;
using Xbim.IO.Xml.BsConf;
using Newtonsoft.Json.Linq;
using System.IO;

namespace Termodel.definizionedati
{
    public static class AutoForm
    {
        public static void GeneraForm(Grid target, Dictionary<string, CampoMeta> schema, string tipoform, string nomeArchivio,int etichetta=220, int dato=320)
        {
            target.Children.Clear();
            target.RowDefinitions.Clear();

            int row = 0;

            foreach (var campo in schema)
            {
                if (string.IsNullOrWhiteSpace(campo.Value.Descr))
                    continue;

                target.RowDefinitions.Add(new RowDefinition { Height = GridLength.Auto });

                var stack = new StackPanel
                {
                    Orientation = Orientation.Horizontal,
                    Margin = new Thickness(5)
                };

                Grid.SetRow(stack, row++);

                var label = new Label
                {
                    Content = campo.Value.Descr,
                    Width = etichetta,
                    VerticalAlignment = VerticalAlignment.Center
                };
                stack.Children.Add(label);

                string controlName = $"{nomeArchivio}_{campo.Key}";
                if (target.FindName(controlName) != null)
                    target.UnregisterName(controlName);

                FrameworkElement input;

                if (campo.Value.Combo != null && campo.Value.Combo.Count > 0)
                {
                    var combo = new ComboBox
                    {
                        Width = dato,
                        Margin = new Thickness(5)
                    };

                    combo.Name = controlName;
                    combo.Tag = campo.Key;
                    target.RegisterName(controlName, combo);

                    input = combo;
                }
                else
                {
                    var textbox = new TextBox
                    {
                        Width = dato,
                        Margin = new Thickness(5),
                        IsReadOnly = campo.Value.ReadOnly ?? false
                    };

                    textbox.Name = controlName;
                    textbox.Tag = campo.Key;
                    target.RegisterName(controlName, textbox);

                    input = textbox;
                }

                stack.Children.Add(input);
                target.Children.Add(stack);
            }
        }


        public static void SalvaAutoForm(Grid grid, string nomeArchivio, int indiceRiga)
        {
            if (!Database.DB.DataCollections.ContainsKey(nomeArchivio))
            {
                Console.WriteLine($"Archivio \"{nomeArchivio}\" non trovato.");
                return;
            }

            var dataCollection = Database.DB.DataCollections[nomeArchivio].DataCollection;
            if (indiceRiga < 0 || indiceRiga >= dataCollection.Count)
            {
                Console.WriteLine($"Indice riga {indiceRiga} non valido.");
                return;
            }

            var riga = dataCollection[indiceRiga];

            // 🔹 Carica metadati
            var schema = Database.DB.GetRecordMetadata(nomeArchivio);
            if (schema == null)
            {
                Console.WriteLine($"Metadati per \"{nomeArchivio}\" non trovati.");
                return;
            }

            // 🔄 Cicla sui campi dello schema
            foreach (var campo in schema)
            {
                string fieldKey = campo.Key;
                string controlName = $"{nomeArchivio}_{fieldKey}";

                var control = grid.FindName(controlName);
                if (control == null)
                {
                    Console.WriteLine($"❌ Controllo non trovato: {controlName}");
                }
                if (control is TextBox textbox)
                {
                    riga[fieldKey] = textbox.Text;
                }
                else if (control is ComboBox comboBox)
                {
                    // 🔒 Forza la commit esplicita
                    var selectedItem = comboBox.SelectedItem;
                    if (selectedItem != null)
                        riga[fieldKey] = selectedItem.ToString();
                    else
                        riga[fieldKey] = null;
                }
                // TODO: Aggiungi altri tipi di controllo se necessario
                // else if (control is CheckBox chk) { ... }
                // else if (control is DatePicker dp) { ... }
            }
        }



        public class CampoMeta
        {
            public int? LunghezzaMassima { get; set; }
            public List<string> Combo { get; set; }
            public bool? ReadOnly { get; set; }
            public string Ini { get; set; }
            public string Descr { get; set; } // ✅ questa è la proprietà mancante

            // 🔧 Nuove proprietà per controllo visibilità dinamica
            public List<string> Grid { get; set; }
            public List<string> Form { get; set; }
        }
        public static void DettaglioArchivio(string nomeArchivio, int indice)
        {
            // 🔹 Recupera la collection dall'istanza DB
            var archivio = Database.DB.GetCollection(nomeArchivio);
            if (archivio == null)
            {
                MessageBox.Show($"Archivio \"{nomeArchivio}\" non trovato.");
                return;
            }

            if (indice < 0 || indice >= archivio.Count)
            {
                MessageBox.Show("Indice fuori range.");
                return;
            }

            // 🔹 Estrai la riga dell'archivio
            var riga = archivio[indice];

            // 🔹 Carica lo schema JSON (metadati)
            var jsonPath =(GestProg.metadataFilePath);
            var json = File.ReadAllText(jsonPath);
            var root = JObject.Parse(json);

            // 🔹 Converte lo schema in Dictionary<string, CampoMeta>
            var schema = root[nomeArchivio].ToObject<Dictionary<string, AutoForm.CampoMeta>>();

            // 🔹 Crea la form e genera dinamicamente i controlli
            var form = new Form_dettaglio();
            AutoForm.GeneraForm(form.AutoFormGrid,schema,"Archivio", nomeArchivio);

            form.Title = $"Modifica {nomeArchivio}";
            
            if (form.ShowDialog() == true)
            Database.DB.SaveData(nomeArchivio); 
            else Database.DB.LoadData(nomeArchivio); 
        }
    }

}
