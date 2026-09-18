using netDxf.Entities;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using Termodel.utilities;
using static Polig3D;
using static System.Runtime.InteropServices.JavaScript.JSType;

namespace Termodel.Leggidxf
{
    public static class GeneraModello
    {
        public static UtiDb utiDb;
        public static Modello modello_edificio ;
        public static Canvas drawingCanvas;
        public static ListBox coordinateListBox;
        public static string PrimoErrore = "";
        public static void initclass(UtiDb UtiDb,Canvas DrawingCanvas,ListBox CoordinateListBox)
        {
        utiDb=UtiDb;
        drawingCanvas=DrawingCanvas;
        coordinateListBox= CoordinateListBox;
        }
            public static int Numeropiani()
        {
            // Recupera la collezione "Piani" dal database
            var pianicollection = utiDb.GetCollection("Piani");

            int numeroTotalePiani = 0;

            foreach (var piano in pianicollection)
            {
                // Verifica se il piano soddisfa i criteri
                if (piano.ContainsKey("Attivo") && piano["Attivo"].ToString() == "Attivo" &&
                    piano.ContainsKey("Tipo") && piano["Tipo"].ToString() == "Calpestabile")
                {
                    // Recupera il valore di "PianiUguali" e moltiplica
                    int pianiUguali = piano.ContainsKey("PianiUguali")
                        ? Convert.ToInt32(piano["PianiUguali"])
                        : 1; // Valore predefinito 1 se manca "PianiUguali"

                    numeroTotalePiani += pianiUguali;
                }
            }

            return numeroTotalePiani;
        }
        public static class GestOpenGL
        {
            public static DrawBim OpenGL = null;
            public static bool enabled = false;
            public static void show()
            {
                OpenGL = new DrawBim();
                //OpenGL.Show();        
            }
        }
        public static bool Errore(string errore)
        { 
            if (PrimoErrore =="") 
            {PrimoErrore = errore;
                return true;
            }
            return false;
        }
        public static LeggiDxf.PosizionePiano Tipopiano(int indicepiano, int ciclo)
        {
            var pianicollection = utiDb.GetCollection("Piani");
            if (pianicollection == null || pianicollection.Count == 0)
                return LeggiDxf.PosizionePiano.Errore;

            int contatore = 0;            // Conta tutti i piani
            int contatorevalidi = 0;      // Conta solo i non-copertura
            int IndicePianoValidi = -1;   // Posizione tra i validi
            int pianiuguali = 1;          // Default se nullo o vuoto

            foreach (var item in pianicollection)
            {
                if (item is Dictionary<string, object> row &&
                    row.TryGetValue("Tipo", out var TipoObj))
                {
                    string tipo = TipoObj?.ToString();

                    if (tipo == "Copertura")
                    {
                        if (contatore == indicepiano)
                            return LeggiDxf.PosizionePiano.Copertura;
                    }
                    else
                    {
                        if (contatore == indicepiano)
                        {
                            if (contatorevalidi == 0 && ciclo == 1)
                                return LeggiDxf.PosizionePiano.PianoTerra;

                            if (row.TryGetValue("PianiUguali", out var cicliObj))
                            {
                                string cicliStr = cicliObj?.ToString()?.Trim();
                                if (!string.IsNullOrEmpty(cicliStr) &&
                                    int.TryParse(cicliStr, out int n))
                                    pianiuguali = n;
                            }

                            IndicePianoValidi = contatorevalidi;
                        }

                        contatorevalidi++;
                    }
                }

                contatore++;
            }

            if (IndicePianoValidi == contatorevalidi - 1 && ciclo == pianiuguali)
                return LeggiDxf.PosizionePiano.Ultimo;

            return LeggiDxf.PosizionePiano.PianoIntermedio;
        }





        public static void LeggituttiiPiani(string PathXMLBase, string PathXMlOut)
        {
 
            try
            {
                bool Almenouno = false;
                ErroreManager.SvuotaErrori();//Grafica 3d
                DrawBim drawBimWindow = null;
                //DrawBim drawBimWindow = new DrawBim();
                //drawBimWindow.Show();
                //modello_edificio = new Modello(drawBimWindow);
                modello_edificio = new Modello(drawBimWindow);
                Modellostatic.Initclass(modello_edificio);
                ErrorManager.ErrorMessage = "";
                utiDb.LoadAllData();
               
                // Inizializza la classe LeggiDxf
                LeggiDxf leggiDxf = new LeggiDxf(drawingCanvas, coordinateListBox, utiDb, modello_edificio);
                Polig3D.ClearAll();


                // Controlla se ci sono errori nell'inizializzazione
                if (!string.IsNullOrEmpty(ErrorManager.ErrorMessage))
                {
                    TermodelLog.LogError($"{ErrorManager.ErrorMessage}");
                    //MessageBox.Show($"Errore: {ErrorManager.ErrorMessage}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                    return;
                }

                // Legge il file DXF
                //String fileName = @"C:\DOCUMENTI\termomodel\prova2.DXF";
                //leggiDxf.LeggiFileDxf(fileName, "0", utiDb.GetCollection("Pareti"));
                /*
                Il programma genera il modello in due passaggi:

                1. Fase 1: Vengono generate le superfici dei tetti e del terreno.
                2. Fase 2: Vengono generati i volumi estrudendo i poligoni che rappresentano i locali.

                Ogni fase è eseguita iterativamente sui dati dei piani, partendo dalla lettura
                delle informazioni nei file DXF e XML.
                */
                //TermodelLog.InitializeLog();
                var pianicollection = utiDb.GetCollection("Piani");
                if (pianicollection == null || pianicollection.Count == 0)
                {
                    TermodelLog.LogError($"Non ci sono piani da elaborare. Esaminare gestione piani ( in basso a sinistra )");
                    //MessageBox.Show("Non ci sono piani da elaborare.", "Termodel - Avviso", MessageBoxButton.OK, MessageBoxImage.Information);
                    //return;
                }
                modello_edificio.Init_modello();
                for (int fase = 1; fase < 3; fase++)
                {
                    TermodelLog.LogOperation($"=====================================================================");
                    TermodelLog.LogOperation($"");
                    TermodelLog.LogOperation($"Inizio della Fase {fase}: {(fase == 1 ? "Generazione delle superfici di tetti e terreno" : "Generazione dei volumi dei locali")}");
                    TermodelLog.LogOperation($"");
                    TermodelLog.LogOperation($"=====================================================================");

                    modello_edificio.localeCounter = 1;
                    Modello.netto = utiDb.GetDataDBSingleRow("LordoNetto", utiDb.GetCollection("DatiCad"))== "Netto";
                    Modello.numeropiani = Numeropiani();
                    double QuotaPiano = 0;
                    string NomePianoModello = "";
                    int indicePianoGlobale = 0;
                    foreach (var item in pianicollection)
                    //foreach (var item in DbGridCor.Items)
                    {
                        // Verifica che l'elemento non sia null e che sia del tipo Dictionary<string, object>
                        if (item is Dictionary<string, object> currentRow)
                        {
                            // Ottieni i valori necessari dalle colonne specificate
                            if (currentRow.TryGetValue("Attivo", out var AttivoObj) &&
                               (AttivoObj?.ToString() == "Attivo") &&
                                currentRow.TryGetValue("NomeFile", out var nomeFileObj) &&
                                currentRow.TryGetValue("LayerCad", out var layerCadObj) &&
                                currentRow.TryGetValue("Nome", out var NomePianoObj) &&
                                currentRow.TryGetValue("Tipo", out var TipoPianoObj) &&
                                currentRow.TryGetValue("AltezzaLorda", out var AltezzaLordaObj) &&
                                currentRow.TryGetValue("AltezzaNetta", out var AltezzaNettaObj)
                                )

                            {
                                string Attivo = AttivoObj?.ToString();
                                string nomeFile = nomeFileObj?.ToString();
                                string layerCad = layerCadObj?.ToString();
                                string NomePiano = NomePianoObj?.ToString();
                                string TipoPiano = TipoPianoObj?.ToString();
                                double AltezzaNetta;

                                double AltezzaLorda;
                                bool Calpestabile = TipoPiano == "Calpestabile";
                                //bool success = Double.TryParse(AltezzaLordaObj?.ToString(), NumberStyles.Any, CultureInfo.InvariantCulture, out AltezzaLorda);
                                AltezzaLorda=Utigen.CVStrToDouble(AltezzaLordaObj?.ToString());
                                bool success = true;
                                if (!success)
                                {
                                    // Gestisci l'errore, ad esempio, impostando un valore di default o lanciando un'eccezione
                                    AltezzaLorda = 3.3; // Imposta un valore predefinito se necessario
                                }
                                AltezzaNetta = Utigen.CVStrToDouble(AltezzaNettaObj?.ToString());
                                bool success1 = true;

                                //bool success1 = Double.TryParse(AltezzaNettaObj?.ToString(), NumberStyles.Any, CultureInfo.InvariantCulture, out AltezzaNetta);
                                if (!success1)
                                {
                                    // Gestisci l'errore, ad esempio, impostando un valore di default o lanciando un'eccezione
                                    AltezzaNetta = 3; // Imposta un valore predefinito se necessario
                                }
                               
                                if(Attivo=="Attivo")
                                if ((Calpestabile && fase == 2) || (!Calpestabile && fase == 1))
                                {
                                        TermodelLog.LogOperation($"----------------------------------------------------------------------");
                                        TermodelLog.LogOperation($"");
                                        TermodelLog.LogOperation($"Processando il piano: {NomePiano}, File DXF: {nomeFile}, Layer: {layerCad}, Altezza Lorda: {AltezzaLorda}, Tipo: {TipoPiano}");
                                        TermodelLog.LogOperation($"");
                                        TermodelLog.LogOperation($"----------------------------------------------------------------------");
                                        TermodelLog.LogOperation($"");
                                        if (!string.IsNullOrEmpty(nomeFile) && !string.IsNullOrEmpty(layerCad))
                                    {
                                        string numeroIterazioniStr;
                                        if (!currentRow.TryGetValue("PianiUguali", out var valore))
                                        {
                                            numeroIterazioniStr = "";
                                        }
                                        else
                                        {
                                            numeroIterazioniStr = valore?.ToString() ?? "";
                                        }
                                        // Default per il numero di iterazioni
                                        int numeroIterazioni = 1;

                                        // Controlla se la stringa non è vuota e può essere convertita in un intero
                                        if (!string.IsNullOrEmpty(numeroIterazioniStr) && int.TryParse(numeroIterazioniStr, out int iterazioni))
                                        {
                                            numeroIterazioni = iterazioni;
                                        }

                                        // Itera per il numero di volte definito
                                        for (int i = 0; i < numeroIterazioni; i++)
                                        {
                                            // Costruisci il nome del file per la iterazione corrente
                                            NomePianoModello = NomePiano;
                                            if (numeroIterazioni > 1) NomePianoModello = $"{NomePiano}({i + 1})";
                                            TermodelLog.LogOperation($"Piani Uguali {i + 1} per il piano: {NomePianoModello}");
                                            // Chiama la funzione LeggiFileDxf per la riga corrente
                                            modello_edificio.Modello_piano(NomePianoModello, QuotaPiano, Polig3D.StringToInTipoPiano(TipoPiano));
                                                if (Calpestabile) Almenouno = true;
                                            leggiDxf.LeggiFileDxf(NomePiano, AltezzaNetta, AltezzaLorda, GestProg.FileDXFPath(nomeFile), layerCad, TipoPiano, utiDb.GetCollection("Pareti"), fase, QuotaPiano, Tipopiano(indicePianoGlobale, i));
                                                if (Calpestabile) QuotaPiano += AltezzaLorda;
                                        }
                                    }
                                    else
                                    {
                                        // Gestisci eventuali errori (ad esempio, nomeFile o layerCad è null o vuoto)
                                        ErrorManager.ErrorMessage = "NomeFile o LayerCad è mancante nella riga.";
                                    }
                                }else if ((Attivo == "Attivo") && Calpestabile) QuotaPiano += AltezzaLorda;
                            }
                            else
                            {
                                // Gestisci il caso in cui una delle chiavi non esista nella riga corrente
                                //ErrorManager.ErrorMessage = "NomeFile o LayerCad non trovati nella riga.";
                            }
                        }
                        else
                        {
                            // Gestisci il caso in cui l'elemento non sia un Dictionary<string, object>
                            //ErrorManager.ErrorMessage = "L'elemento della griglia non è del tipo atteso.";
                        }
                        indicePianoGlobale++;
                    }
                }

                // Salva il documento XML nel percorso specificato

                //leggiDxf.SaveXLMOut(PathXMlOut);

                modello_edificio.Close_modello(System.IO.Path.Combine(GestProg.ProgramPath, "outbim.ifc"), PathXMLBase, PathXMlOut);

                // Messaggio di conferma
                
                if (!Almenouno) 
                TermodelLog.LogError($"Non ci sono piani calpestabili attivi. Esaminare gestione piani ( in basso a sinistra )");
                
                if (double.IsNaN(modello_edificio.direzNord))
                    TermodelLog.LogError("Il simbolo NORD necessario per l'orientamento dell'edificio non è stato trovato in nessun piano");

                if (!TermodelLog.CisonoErrori())
                {
                    //MessageBox.Show("Generazione del modello completata con successo!", "Successo", MessageBoxButton.OK, MessageBoxImage.Information); TermodelLog.LogOperation($"----------------------------------------------------------------------");
                    TermodelLog.LogOperation($"");
                    TermodelLog.LogOperation($"               Generazione del modello completata con successo");
                    TermodelLog.LogOperation($"");
                    TermodelLog.LogOperation($"----------------------------------------------------------------------");
                    TermodelLog.LogOperation($"");
                    //MessageBox.Show("Operazione completata con successo.", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);
                }
                    modello_edificio = null;
            }
            catch (Exception ex)
            {
                // Gestione degli errori
                ErrorManager.ErrorMessage = $"Errore durante il processo: {ex.Message}";
                MessageBox.Show($"Errore: {ErrorManager.ErrorMessage}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            
        }
    }
}
