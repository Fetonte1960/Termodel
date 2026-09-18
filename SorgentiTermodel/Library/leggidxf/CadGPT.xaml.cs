using netDxf.Entities;
using netDxf;
using netDxf.Header;
using netDxf.Tables;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.Text.RegularExpressions;
using Termodel.utilities;
using System.Globalization;
using System.IO;
using System.Xml.Linq;
namespace Termodel.Leggidxf
{
    /// <summary>
    /// Logica di interazione per CadGPT.xaml
    /// </summary>
    public partial class CadGPT : Window
    {
        public CadGPT()
        {
            InitializeComponent();
        }
        private void CopiaContesto_Click(object sender, RoutedEventArgs e)
        {
            string contesto = @"#ISTRUZIONI PER GPT:
#SCOPO Creare un disegno in formato svg formato da linee e testi , risultato della descrizione
di una pianta architettonica descritta verbalmente dall'utente
FORMATO OUTPUT: SVG (solo linee Linee e Testo)
REGOLE:
1:Le linee SVG rappresentano le pareti e devono costruire un grafo chiuso con all'interno il testo che descrive ogni locale
1A:ad ogni tipologia di parete è associato un colore differente es: rosso > Parete esterna isolata verde > divisorio interno
1B: ad ogni tipo di linea corrisponde un confine es: continua >> esterno  tratteggiata >> locale non riscaldato
2:Il testo può descrivere Finestre o informazioni sui locali
il testo è formattato come segue , inizia con una riga che identifica un tipo di infomazione
preceduto dal prefisso BLOCCO
la formattazione dei parametri segue il seguente schema ( i valori sono indicativi
<text x=""10"" y=""20"" font-size=""12"" fill=""black"">
  <tspan x=""10"" dy=""0"">Prima riga</tspan>
  <tspan x=""10"" dy=""1.2em"">Seconda riga</tspan>
  <tspan x=""10"" dy=""1.2em"">Terza riga</tspan>
</text>
BLOCCO,LOC
##Locale
2A:Nel caso di locali il punto di inserimento del testo va collocato al centro dei locali.
#REGOLA IMPORTANTE nel caso di locali con forme complesse verificare che  effettivamente il simbolo loc si trovi allinterno del perimetro del locale
esempio di testo locale il primo campo è un'identificatore fisso
BLOCCO,LOC
DESCR.,(Descrizione del locale)
ZONA,(Zona di appartenenza)default:Zona riscaldata
CPAV,(confine del pavimento) default:Automatico
CSOF,(confine del soffitto) default:Automatico
CCOPERTURA,(si tratta di un mansardato) default:Solaio piano
TPAV,(Tipologia costruttiva del pavimento) default:?
TSOF,(Tipologia costruttiva del soffitto) default:?
ALTEZZALORDA,(altezza lorda se differenziata dagli altri locali) default:Da piano
ALTEZZANETTA,(altezza netta  se differenziata dagli altri locali) default:Da piano
QUOTAPAVIMENTO,(Quota pavimento se differenziata dagli altri locali) default:Da piano

## Finestre
1B: Ogni finestra deve essere rappresentata da un blocco testuale (BLOCCO,FIN) posizionato **esattamente sulla linea della parete** a cui appartiene.

- Il punto (x,y) di inserimento del testo deve **coincidere con la linea** della parete (nessuno scostamento verticale o orizzontale).
- Se una parete contiene **più finestre**, queste devono essere **distribuite equamente** lungo la parete, mantenendo:
  - stesso valore `y` per pareti orizzontali
  - stesso valore `x` per pareti verticali.
formattazione del testo
BLOCCO,FIN
TIPO,(tipologia costruttiva della finestra)
LARGHEZZA,(Larghezza)
ALTEZZA,(altezza)
NUMEROANTE,(Numero ante)
SOTTOFINESTRA,(altezza sottofinesta 0=porta finestra) default:0
SOPRALUCE,(altezza sopraluce) default:0
__________________________________________________________________________________

Tetti e locali mansardati
___________________________________________________________________________________
## Tetti e locali mansardati
I locali mansardati si realizzano implementando due gruppi <g id=""calpestabile""> e <g id=""copertura""> , uno contenente 
i locali veri e propri (Calpestabile), l'altro (Copertura) contenente la pianta del tetto
### Copertura
la pianta del tetto si realizza mediante un grafo chiuso per ogni tetto realizzate con linee colorate
#REGOLA IMPORTANTE la pianta del tetto deve eccedere di 0.5 metri la pianta dell'edificio sottostante
Per dare la tridimensionalità al tetto bisogna posizionare al centro della linea di colmo (la linea più alta)
un BLOCCO,Colmo
QUOTACOLMO,quota del colmo
QUOTAGRONDA,quota della gronda
Il programma si comporterà nel seguente modo
1: assegnera la quota del colmo ad entrambi i vertici della linea su cui è collocata
2: assegnerà la quota del colmo a tutti vertici delle linee collegate alla linea del colmo
3: Assegnerà la quota della gronda a tutti gli altri vertici non collegati alla linea di colmo
### Piano calpestabile
Nel piano calpestabile contenente la pianta del fabbricato verranno estrusi da TERMODEL solo i locali che scontengono
settata una proprità ben precisa nel 
BLOCCO,LOC
DESCR.,Appartamento
ZONA,Zona Termica 1
CPAV,Automatico
CSOF,Automatico
CCOPERTURA,Solaio piano
TPAV,Muratura a cassa vuota in laterizio forato (26.5 cm)
TSOF,Muratura a cassa vuota in laterizio forato (26.5 cm)
ALTEZZALORDA,Da piano
ALTEZZANETTA,Da piano
QUOTAPAVIMENTO,Da piano
>>CCOPERTURA,Solaio piano >> il solaio non verrà estruso
CCOPERTURA >> 1 - Rosso >> il solaio verrà estruso sino a raggiungere il tetto di colore rosso nel Layer copertura
__________________________________________________________________________________

#REGOLA IMPORTANTE Le entità SVG devono essere collocate all’interno di due gruppi <g> distinti,
dal nome fisso: ""calpestabile"" e ""copertura"".

#REGOLA IMPORTANTE Entrambi i gruppi <g id=""calpestabile""> e <g id=""copertura""> devono essere sempre presenti,
anche nei casi in cui il piano non è mansardato.

#REGOLA IMPORTANTE Il gruppo <g id=""copertura""> può essere vuoto (senza blocchi COLMO) per indicare che si tratta di un solaio piano.#REGOLA IMPORTANTE tutti i  parametri del testo devono essere indicati anche se non specificati dall'utente. separati da ;
#REGOLA IMPORTANTE oltre a generare l'svg genererai una anteprima in finestra txt in modo che l'utente possa copiare ed incollare
#REGOLA IMPORTANTE come messaggio di benvenuto :Spiega che si tratta di un contesto che aiuta a realizzare un modello tridimensionale con TERMODEL , che interpreterà i dati che tu produrrai,Racconterai sinteticamente cosa puoi fare, e darai indicazioni sulle unità di misura e convenzioni su informazioni topologiche, dovra descriverti il fabbricato come guardasse un foglio da disegno
#REGOLA IMPORTANTE i testi dell'SVG  devono essere molto piccoli >> font-size=""1""
#REGOLA IMPORTANTE Le unità di misura svg saranno ( 1 unita= 1 cm ) quindi se ti dico 4 X 4 (si intenderanno metri) e le trasformerai in unita SVG 400 x 400
#REGOLA IMPORTANTE dammi sempre l'svg in una finestra di testo o su file con estensione *.TXT
#REGOLA IMPORTANTE in caso l'utente fornisca l'altezza inserirla il LOC parametri ALTEZZANETTA per ALTEZZALORDA aumentare di 0,6 metri
#REGOLA IMPORTANTE quando l'utente indica dei locali ADIACENTI , le linee di separazione devono essere esattamente sovrapposte e non distanziate
#REGOLA IMPORTANTE nelle informazioni riassuntive indica sempre la superficie totale in mq
#REGOLA IMPORTANTE nelle informazioni riassuntive indica sempre la superficie totale delle finestre in mq
#REGOLA IMPORTANTE nel caso l'utente indichi le altezze ,nelle informazioni riassuntive indica sempre il volume totale totale in mc
#REGOLA IMPORTANTE  dialogo con l'utente sul posizionamento
""In alto"" = direzione nord = verso il basso delle coordinate SVG (cioè coordinate y più piccole, vicino allo zero).
""In basso"" = direzione sud = coordinate y più grandi.
""A sinistra"" = direzione ovest = coordinate x più piccole.
""A destra"" = direzione est = coordinate x più grandi.
";

            Clipboard.SetText(contesto );
            MessageBox.Show("Contesto invisibile copiato negli appunti!", "CadGPT", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        // Funzione realizzata da Codex in autonomia
        private void CopiaContestoRaster_Click(object sender, RoutedEventArgs e)
        {
            // Modificato da Codex per realizzare: overlay diagnostico fedele al raster e alla geometria destinata a Termodel.
            string contestoRaster = @"# ISTRUZIONI PER GPT - LETTURA DI UNA PIANTA RASTER PER TERMODEL

SCOPO
Interpreta una pianta architettonica fornita come immagine raster (fotografia, scansione, screenshot o PDF convertito in immagine) e genera un SVG-LFT importabile in Termodel.

DIALOGO OBBLIGATORIO - SEQUENZA ESATTA
1. PIANTA: chiedi all'utente di allegare la pianta, se non è già presente. Non chiedere ancora misure.
2. PRIMA INTERPRETAZIONE: interpreta subito la pianta e restituisci una prima pianta vettoriale di lavoro. Numera tutte le pareti E001, E002... per i fili interni esterni e W001, W002... per i divisori. Numera tutti i locali chiusi R001, R002... La numerazione deve essere chiaramente visibile accanto agli elementi e non deve coprire la geometria.
3. CALIBRAZIONE: soltanto dopo avere mostrato l'overlay diagnostico sul raster originale e chiarito con l'utente gli errori e le incertezze geometriche chiedi la lunghezza reale di una parete numerata, per esempio: 'Quanto misura E002?'. Usa quella parete per trasformare tutte le coordinate in centimetri senza alterare le proporzioni.
4. EDITING INTERATTIVO: usa sempre i codici per ricevere correzioni sintetiche, per esempio: 'elimina W003', 'collega E005 ed E013', 'sposta R004', 'fondi R009 e R010 eliminando il divisorio'. Se una parete, un'apertura o una chiusura è incerta, non inventare: indicala con il suo codice e chiedi conferma.
5. A ogni modifica rigenera e presenta entrambi gli elaborati descritti nella sezione OUTPUT PARALLELO. Non cambiare i codici degli elementi non interessati dalla modifica.
6. Quando non rimangono dubbi, dichiara esplicitamente quale dei due SVG è quello definitivo da importare in Termodel.

OUTPUT PARALLELO OBBLIGATORIO
A. PIANTA DI LAVORO PER L'EDITING
- Mostra direttamente nella conversazione la pianta numerata usata per il dialogo e l'editing.
- Conserva senza modifiche l'impostazione della prima interpretazione approvata dall'utente: stessa pianta raster, stessi colori, stessi codici, stessa posizione delle etichette e stesso aspetto grafico.
- Non sostituire mai la pianta numerata con l'anteprima dello SVG pulito destinato a Termodel.
- Applica alla pianta numerata soltanto le correzioni geometriche richieste dall'utente, mantenendo stabile tutto il resto.
- Può contenere etichette, colori, cerchi e legenda fuori dai gruppi importabili.
- Deve essere ripresentata dopo ogni correzione, mantenendo stabile la numerazione.

B. SVG DEFINITIVO PER TERMODEL
- SVG-LFT pulito, calibrato in centimetri e sempre aggiornato in parallelo alla pianta di lavoro.
- Deve contenere la stessa geometria della pianta di lavoro ma nessuna etichetta grafica di servizio nei gruppi importabili.
- Crea un file separato chiamato esattamente DisegnoInput.svg e presentalo come allegato o collegamento cliccabile nella conversazione.
- Questo secondo SVG è distinto dalla pianta numerata: può essere visualizzato cliccando il file, ma non deve prendere il posto della pianta numerata nella conversazione.
- Immediatamente sotto il collegamento DisegnoInput.svg, presenta anche il contenuto completo dello SVG DEFINITIVO PER TERMODEL in un unico blocco di codice delimitato con ```xml, così l'interfaccia GPT visualizza il proprio pulsante nativo Copia negli appunti.
- Il file allegato e il blocco di codice devono essere identici; non generare due versioni diverse dello SVG definitivo.
- Introduci il blocco con la dicitura esatta: 'CODICE SVG DEFINITIVO — copia negli appunti e incolla in Termodel'.
- Non stampare il codice dello SVG dentro l'immagine di anteprima e non incorporare lo SVG definitivo in una tavola composita.
- Quando l'utente clicca DisegnoInput.svg deve poter visualizzare la pianta vettoriale: aggiungi sfondo bianco e uno stile visibile alle linee, con stroke scuro e stroke-width sufficiente, senza cambiare le coordinate importabili.
- Mantieni i blocchi testuali LOC con font-size=""1"", affinché non coprano il disegno; Termodel continuerà a leggerli.
- Se l'interfaccia GPT non consente di allegare direttamente un file, il blocco di codice con pulsante Copia diventa l'output principale; spiega di incollarlo in Termodel o salvarlo come DisegnoInput.svg.
- È questo il file che l'utente deve scaricare o copiare nella casella di Termodel.

DIVIETO DI COMPOSIZIONE
- Non creare un'unica immagine contenente affiancati pianta di lavoro, pianta definitiva, codice XML, istruzioni, legenda e calibrazione.
- Presenta sempre tre elementi distinti e in quest'ordine: 1) pianta numerata invariata per l'editing; 2) collegamento cliccabile a DisegnoInput.svg; 3) codice del medesimo SVG definitivo nel blocco con pulsante Copia.

OVERLAY DIAGNOSTICO DELLA GEOMETRIA RICONOSCIUTA - IMPORTANTE
- L'overlay non è un'illustrazione: rappresenta esattamente lo scheletro geometrico candidato a DisegnoInput.svg.
- Lascia il raster originale graficamente invariato e visibile come sfondo: non ridisegnarlo, reinterpretarlo, sostituirlo, attenuarlo o cancellarne dettagli. Ignorare arredi e retini nel riconoscimento non significa rimuoverli dallo sfondo.
- Pareti esterne E001…: UNA SOLA linea sul bordo INTERNO della muratura, lato ambiente. Mai sull'asse, sul bordo esterno o su entrambe le facce.
- Divisori W001…: UNA SOLA linea sull'ASSE della muratura, non sui due bordi.
- Sovrapponi soltanto lo scheletro candidato e i codici E001…, W001…, R001… necessari al dialogo. Usa linee colorate leggermente più spesse ma senza nascondere i bordi sottostanti; colloca i codici accanto alla geometria.
- Controllo del filo interno: lo spessore della muratura deve essere ancora visibile all'esterno della linea E; verso il locale la linea E coincide con il limite della superficie interna. Controlla soprattutto angoli e cambi di direzione: una linea nel mezzo della fascia muraria è errata.
- Se bordo interno o asse non sono leggibili, indica il codice e chiedi conferma o un dettaglio ingrandito. Non usare silenziosamente il centro della muratura come filo interno.
- Mostra l'overlay e correggi con l'utente le entità dubbie prima della calibrazione o della generazione dello SVG pulito. Ripresentalo dopo ogni modifica, conservando raster e identificativi non interessati.
- Overlay e SVG pulito devono derivare dalla stessa geometria numerica. Non ricostruire il definitivo separatamente dall'immagine approvata. La calibrazione cambia le unità, non la posizione delle linee rispetto al raster: usa la corrispondenza inversa di scala e origine solo nella vista di editing.
- Prima della consegna confronta per identificativo estremi dei segmenti e posizioni dei locali, tenendo conto di scala e origine. Se differiscono, correggi e ripresenta l'overlay prima dell'importazione; non dichiarare verifiche non eseguite.

INTERPRETAZIONE GRAFICA
- Ricava il filo interno delle pareti esterne.
- Ricava l'asse dei divisori interni.
- Ignora arredi, sanitari, elettrodomestici, automobili, quote, retini, testi, simboli e decorazioni.
- Le linee devono costituire un grafo chiuso; aggancia ogni estremità alla parete vicina anche quando l'incontro cade nel mezzo di una linea.
- Non duplicare pareti condivise tra due locali.
- Colloca un blocco LOC realmente all'interno di ogni locale chiuso.
- Non dedurre con certezza la destinazione d'uso dal solo arredo: usa descrizioni neutre Locale R001, Locale R002, ecc., salvo conferma dell'utente.
- Le unità SVG sono centimetri: 1 unità SVG = 1 cm.

FORMATO DELLO SVG DEFINITIVO OBBLIGATORIO
- Restituisci un SVG XML completo, copiabile nella casella di Termodel, separato e chiaramente distinto dalla pianta di lavoro.
- Devono esistere sempre i gruppi diretti <g id=""calpestabile""> e <g id=""copertura"">.
- Se il tetto non è descritto, il gruppo copertura deve essere vuoto.
- Dentro calpestabile usa soltanto elementi <line> e <text> come figli diretti: non creare sottogruppi.
- Ogni parete deve essere una <line x1=""..."" y1=""..."" x2=""..."" y2=""..."" />.
- Gli stili grafici sono facoltativi e non devono modificare le coordinate.

BLOCCO LOCALE
Ogni locale deve essere un elemento text diretto di calpestabile. Ogni informazione deve stare in un tspan separato, nel seguente ordine:

<text id=""R001"" x=""100"" y=""100"" font-size=""1"">
  <tspan x=""100"" dy=""0"">BLOCCO,LOC</tspan>
  <tspan x=""100"" dy=""1.2em"">DESCR.,Locale R001</tspan>
  <tspan x=""100"" dy=""1.2em"">ZONA,Zona climatizzata</tspan>
  <tspan x=""100"" dy=""1.2em"">CPAV,Automatico</tspan>
  <tspan x=""100"" dy=""1.2em"">CSOF,Automatico</tspan>
  <tspan x=""100"" dy=""1.2em"">CCOPERTURA,Solaio piano</tspan>
  <tspan x=""100"" dy=""1.2em"">TPAV,Pavimento su terreno</tspan>
  <tspan x=""100"" dy=""1.2em"">TSOF,Solaio Esterno in laterocemento</tspan>
  <tspan x=""100"" dy=""1.2em"">ALTEZZALORDA,Da piano</tspan>
  <tspan x=""100"" dy=""1.2em"">ALTEZZANETTA,Da piano</tspan>
  <tspan x=""100"" dy=""1.2em"">QUOTAPAVIMENTO,Da piano</tspan>
</text>

FINESTRE
Inserisci blocchi FIN soltanto quando posizione e dimensioni sono riconoscibili o confermate. Il punto x,y deve cadere esattamente sulla linea della parete. Se i dati non sono sufficienti, chiedili prima di generare il blocco.

CONTROLLO A OGNI ITERAZIONE
- Verifica che calpestabile e copertura esistano.
- Verifica che linee e text siano figli diretti dei rispettivi gruppi.
- Prima della calibrazione dichiara che le coordinate sono provvisorie; dopo la calibrazione verifica la scala usando la misura fornita dall'utente.
- Verifica che ogni LOC sia interno a un locale chiuso.
- Verifica che non esistano estremità volanti.
- Indica separatamente scala adottata, parete usata per la calibrazione, numero di linee, numero di locali e dubbi ancora aperti.

Inizia chiedendo soltanto all'utente di allegare la pianta. La misura di calibrazione deve essere chiesta dopo la prima interpretazione numerata.";

            Clipboard.SetText(contestoRaster);
            MessageBox.Show(
                "Istruzioni per la lettura della pianta raster copiate negli appunti!",
                "CadGPT",
                MessageBoxButton.OK,
                MessageBoxImage.Information);
        }


        private void ImportaSvg_Click(object sender, RoutedEventArgs e)
        {
            // Modificato da Codex per realizzare: riuso dello stesso flusso sia dalla form sia dall'interfaccia AdvancedAI.
            ImportaSvg(txtSVG.Text);

            MessageBox.Show("SVG importato e convertito in DXF!", "CadGPT", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        // Funzione realizzata da Codex in autonomia
        public void ImportaSvgDaFile(string percorsoSvg)
        {
            ArgumentException.ThrowIfNullOrWhiteSpace(percorsoSvg);
            if (!File.Exists(percorsoSvg))
            {
                throw new FileNotFoundException("Il file SVG da importare non esiste.", percorsoSvg);
            }

            ImportaSvg(File.ReadAllText(percorsoSvg));
        }

        // Funzione realizzata da Codex in autonomia
        private void ImportaSvg(string svgContent)
        {
            if (string.IsNullOrWhiteSpace(svgContent))
            {
                throw new InvalidDataException("Il contenuto SVG da importare è vuoto.");
            }

            string layer = "Unico";

            string pathModello = System.IO.Path.Combine(GestProg.ProgramPath, "modello.dxf");
            string pathOutput = System.IO.Path.Combine(GestProg.PathProg, "DisegnoInput.dxf");

            PianiSVG(ConvertiSvgInDxf(svgContent, layer, pathModello, pathOutput)!="", layer);
        }

        // Funzione realizzata da Codex in autonomia
        public void CreaDxfMancanteDaSvg(string percorsoSvg, string percorsoDxf, string layer)
        {
            if (File.Exists(percorsoDxf)) return;
            string contenuto = File.ReadAllText(percorsoSvg);
            var gruppi = ExtractSvgGroups(contenuto);
            if (!gruppi.TryGetValue("calpestabile", out var elementi) || ExtractSvgLines(elementi).Count == 0)
                throw new InvalidDataException("SVG automatico: nessuna linea nel gruppo calpestabile.");
            string temporaneo = percorsoDxf + "." + Guid.NewGuid().ToString("N") + ".dxf";
            try
            {
                ConvertiSvgInDxf(contenuto, layer, System.IO.Path.Combine(GestProg.ProgramPath, "modello.dxf"), temporaneo, salvaSvg: false);
                File.Move(temporaneo, percorsoDxf, overwrite: false);
            }
            finally { if (File.Exists(temporaneo)) File.Delete(temporaneo); }
        }

        private void Chiudi_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        string ValidaTPAV_TSOF(string nomeArchivio, string valoreInput, out bool eraValido)
        {
            var archivio = Database.DB.GetCollection(nomeArchivio);

            var valido = archivio.Any(r =>
                r.ContainsKey("DescBreve") &&
                r["DescBreve"].ToString().Trim().Equals(valoreInput.Trim(), StringComparison.OrdinalIgnoreCase));

            eraValido = valido;

            if (valido)
                return valoreInput;

            var fallback = archivio.FirstOrDefault();
            if (fallback != null && fallback.ContainsKey("DescBreve"))
                return fallback["DescBreve"].ToString();

            return valoreInput; // fallback estremo, da loggare
        }
        string ValidaTipoFinestra(string valoreInput, out bool eraValido)
        {
            var archivio = Database.DB.GetCollection("Finestre");

            var valido = archivio.Any(r =>
                r.ContainsKey("DescBreve") &&
                r["DescBreve"].ToString().Trim().Equals(valoreInput.Trim(), StringComparison.OrdinalIgnoreCase));

            eraValido = valido;

            if (valido)
                return valoreInput;

            var fallback = archivio.FirstOrDefault();
            if (fallback != null && fallback.ContainsKey("DescBreve"))
                return fallback["DescBreve"].ToString();

            return valoreInput; // fallback estremo, da loggare eventualmente
        }
        string ValidaZonaLocale(string valoreInput, out bool eraValido)
        {
            var archivio = Database.DB.GetCollection("Zone");

            var valido = archivio.Any(r =>
                r.ContainsKey("Codice") &&
                r["Codice"].ToString().Trim().Equals(valoreInput.Trim(), StringComparison.OrdinalIgnoreCase));

            eraValido = valido;

            if (valido)
                return valoreInput;

            var fallback = archivio.FirstOrDefault();
            if (fallback != null && fallback.ContainsKey("Codice"))
                return fallback["Codice"].ToString();

            return valoreInput; // fallback estremo, da loggare
        }
        string ValidaConfine(string valoreInput, out bool eraValido)
        {
            var archivio = Database.DB.GetCollection("Confini");

            var valido = archivio.Any(r =>
                r.ContainsKey("Codice") &&
                r["Codice"].ToString().Trim().Equals(valoreInput.Trim(), StringComparison.OrdinalIgnoreCase));

            eraValido = valido;

            if (valido)
                return valoreInput;

            var fallback = archivio.FirstOrDefault();
            if (fallback != null && fallback.ContainsKey("Codice"))
                return fallback["Codice"].ToString();

            return valoreInput; // fallback estremo da loggare
        }
        public string ValidaAltezzeloc(string valore)
        {
            double reale = Utigen.CVStrToDouble(valore);
            if (!double.IsNaN(reale))
            {
                TermodelLog.WriteLog($"[ValidaAltezzeloc] Valore numerico valido: '{valore}' => {reale} m");
                return valore;
            }
            else
            {
                TermodelLog.WriteLog($"[ValidaAltezzeloc] Valore NON numerico o assente ('{valore}'), usato fallback: 'Da piano'");
                return "Da piano";
            }
        }

        void ConvalidaAttributi(SvgBlock blocco)
        {
            string ValidaPerArchivio(string valore, string archivio, string campoIndice)
            {
                var lista = Database.DB.GetCollection(archivio);
                valore = valore?.Trim();

                if (string.IsNullOrEmpty(valore) || valore == "?")
                {
                    TermodelLog.WriteLog($"[ValidaPerArchivio] Valore vuoto o '?', archivio: {archivio}, campo: {campoIndice}");
                    valore = "";
                }

                var valido = lista.Any(r =>
                    r.ContainsKey(campoIndice) &&
                    r[campoIndice].ToString().Trim().Equals(valore, StringComparison.OrdinalIgnoreCase));

                if (valido)
                {
                    TermodelLog.WriteLog($"[ValidaPerArchivio] Valore valido trovato: '{valore}' in archivio: {archivio}");
                    return valore;
                }

                var fallback = lista.FirstOrDefault();
                if (fallback != null && fallback.ContainsKey(campoIndice))
                {
                    string fallbackValore = fallback[campoIndice].ToString();
                    TermodelLog.WriteLog($"[ValidaPerArchivio] Valore '{valore}' NON trovato in archivio '{archivio}', usato fallback: '{fallbackValore}'");
                    return fallbackValore;
                }

                TermodelLog.WriteLog($"[ValidaPerArchivio] Valore '{valore}' NON trovato e archivio '{archivio}' vuoto o campo '{campoIndice}' mancante. Usato: 'NON DEFINITO'");
                return "NON DEFINITO";
            }

            if (blocco.Tipo == "LOC")
            {
                TermodelLog.WriteLog($"[ConvalidaAttributi] BLOCCO LOC: {blocco.Attributi.GetValueOrDefault("DESCR.")}");

                blocco.Attributi["ZONA"] = ValidaPerArchivio(blocco.Attributi.GetValueOrDefault("ZONA"), "Zone", "Codice");

                string tpavOrig = blocco.Attributi.GetValueOrDefault("TPAV");
                blocco.Attributi["TPAV"] = ValidaPerArchivio(tpavOrig, "Pareti", "DescBreve");
                TermodelLog.WriteLog($"[ConvalidaAttributi] TPAV: '{tpavOrig}' => '{blocco.Attributi["TPAV"]}'");

                string tsofOrig = blocco.Attributi.GetValueOrDefault("TSOF");
                blocco.Attributi["TSOF"] = ValidaPerArchivio(tsofOrig, "Pareti", "DescBreve");
                TermodelLog.WriteLog($"[ConvalidaAttributi] TSOF: '{tsofOrig}' => '{blocco.Attributi["TSOF"]}'");

                blocco.Attributi["CPAV"] = ValidaPerArchivio(blocco.Attributi.GetValueOrDefault("CPAV"), "Confini", "Codice");
                blocco.Attributi["CSOF"] = ValidaPerArchivio(blocco.Attributi.GetValueOrDefault("CSOF"), "Confini", "Codice");

                string altLorda = blocco.Attributi.GetValueOrDefault("ALTEZZALORDA");
                string altNetta = blocco.Attributi.GetValueOrDefault("ALTEZZANETTA");
                string quotaPav = blocco.Attributi.GetValueOrDefault("QUOTAPAVIMENTO");

                blocco.Attributi["ALTEZZALORDA"] = ValidaAltezzeloc(altLorda);
                blocco.Attributi["ALTEZZANETTA"] = ValidaAltezzeloc(altNetta);
                blocco.Attributi["QUOTAPAVIMENTO"] = ValidaAltezzeloc(quotaPav);

                TermodelLog.WriteLog($"[ConvalidaAttributi] ALTEZZALORDA: '{altLorda}' => '{blocco.Attributi["ALTEZZALORDA"]}'");
                TermodelLog.WriteLog($"[ConvalidaAttributi] ALTEZZANETTA: '{altNetta}' => '{blocco.Attributi["ALTEZZANETTA"]}'");
                TermodelLog.WriteLog($"[ConvalidaAttributi] QUOTAPAVIMENTO: '{quotaPav}' => '{blocco.Attributi["QUOTAPAVIMENTO"]}'");
            }

            if (blocco.Tipo == "FIN")
            {
                string tipoOrig = blocco.Attributi.GetValueOrDefault("TIPO");
                blocco.Attributi["TIPO"] = ValidaPerArchivio(tipoOrig, "Finestre", "DescBreve");
                TermodelLog.WriteLog($"[ConvalidaAttributi] TIPO finestra: '{tipoOrig}' => '{blocco.Attributi["TIPO"]}'");

                string anteOrig = blocco.Attributi.GetValueOrDefault("NUMEROANTE");
                if (string.IsNullOrWhiteSpace(anteOrig) ||
                anteOrig.Contains("?") ||
                anteOrig.Contains(";") ||
                anteOrig.Contains("Da definire", StringComparison.OrdinalIgnoreCase))

                {
                    blocco.Attributi["NUMEROANTE"] = "2";
                    TermodelLog.WriteLog($"[ConvalidaAttributi] NUMEROANTE non valido ('{anteOrig}'), usato fallback: 2");
                }
                else
                {
                    TermodelLog.WriteLog($"[ConvalidaAttributi] NUMEROANTE valido: '{anteOrig}'");
                }

                string[] campiCm = { "LARGHEZZA", "ALTEZZA", "SOTTOFINESTRA", "SOPRALUCE" };

                foreach (var campo in campiCm)
                {
                    string val = blocco.Attributi.GetValueOrDefault(campo)?.TrimEnd(';');
                    double cm = Utigen.CVStrToDouble(val);

                    if (!double.IsNaN(cm))
                    {
                        double metri = cm / 100.0;
                        blocco.Attributi[campo] = metri.ToString("0.##", CultureInfo.InvariantCulture);
                        TermodelLog.WriteLog($"[ConvalidaAttributi] {campo}: {cm} cm => {blocco.Attributi[campo]} m");
                    }
                    else
                    {
                        blocco.Attributi[campo] = "0";
                        TermodelLog.WriteLog($"[ConvalidaAttributi] {campo}: valore non numerico ('{val}'), usato fallback: 0");
                    }
                }
            }
            if (blocco.Tipo.Equals("COLMO", StringComparison.OrdinalIgnoreCase))
            {
                string valColmo = blocco.Attributi.GetValueOrDefault("QUOTACOLMO");
                string valGronda = blocco.Attributi.GetValueOrDefault("QUOTAGRONDA");

                double colmo = Utigen.CVStrToDouble(valColmo);
                double gronda = Utigen.CVStrToDouble(valGronda);

                bool colmoValido = !double.IsNaN(colmo) && colmo > 0;
                bool grondaValida = !double.IsNaN(gronda) && gronda > 0;

                if (!colmoValido)
                {
                    colmo = 4;
                    blocco.Attributi["QUOTACOLMO"] = colmo.ToString("0.##", CultureInfo.InvariantCulture);
                    TermodelLog.WriteLog($"[ConvalidaAttributi] QUOTACOLMO non valido o NaN ('{valColmo}'), impostato a default: 4");
                }
                else colmo = colmo / 100;

                if (!grondaValida)
                {
                    gronda = 2.5;
                    blocco.Attributi["QUOTAGRONDA"] = gronda.ToString("0.##", CultureInfo.InvariantCulture);
                    TermodelLog.WriteLog($"[ConvalidaAttributi] QUOTAGRONDA non valida o NaN ('{valGronda}'), impostato a default: 2.5");
                }

                if (colmo <= gronda)
                {
                    colmo = gronda + 0.5;
                    blocco.Attributi["QUOTACOLMO"] = colmo.ToString("0.##", CultureInfo.InvariantCulture);
                    TermodelLog.WriteLog($"[ConvalidaAttributi] QUOTACOLMO ({colmo}) non maggiore di QUOTAGRONDA ({gronda}), corretto a: {colmo}");
                }
            }

        }
        bool ContieneAncoraPlaceholder(SvgBlock blocco)
        {
            foreach (var kvp in blocco.Attributi)
            {
                string chiave = kvp.Key;
                string valore = kvp.Value?.Trim();

                if (string.IsNullOrEmpty(valore) ||
                  valore.Contains("?") ||
                  valore.Contains(";") ||
                  valore.Trim().Equals("Da definire", StringComparison.OrdinalIgnoreCase) ||
                  valore.Trim().Equals("Non definito", StringComparison.OrdinalIgnoreCase))
                {
                    TermodelLog.WriteLog($"[ContieneAncoraPlaceholder] Attributo '{chiave}' contiene valore sospetto: '{valore}'");
                    return true;
                }

            }

            return false;
        }

        public static double Distanza(Vector2 a, Vector2 b)
        {
            double dx = a.X - b.X;
            double dy = a.Y - b.Y;
            return Math.Sqrt(dx * dx + dy * dy);
        }
        void SpostaBlocchiFinestreSuLinea(List<SvgBlock> blocchi, List<SvgLine> linee)
        {
            foreach (var blocco in blocchi.Where(b => b.Tipo == "FIN"))
            {
                double minDistanza = double.MaxValue;
                Vector2 puntoPiùVicino = new Vector2((float)blocco.X, (float)blocco.Y);
                Vector2 puntoBlocco = puntoPiùVicino;

                foreach (var linea in linee)
                {
                    var p1 = new Vector2((float)linea.X1, (float)linea.Y1);
                    var p2 = new Vector2((float)linea.X2, (float)linea.Y2);

                    var proiettato = ProiettaPuntoSuSegmento(puntoBlocco, p1, p2);

                    double distanza = Distanza(proiettato, puntoBlocco);

                    if (distanza < minDistanza)
                    {
                        minDistanza = distanza;
                        puntoPiùVicino = proiettato;
                    }
                }

                blocco.X = puntoPiùVicino.X;
                blocco.Y = puntoPiùVicino.Y;
            }
        }
        Vector2 ProiettaPuntoSuSegmento(Vector2 p, Vector2 a, Vector2 b)
        {
            double abX = b.X - a.X;
            double abY = b.Y - a.Y;
            double apX = p.X - a.X;
            double apY = p.Y - a.Y;

            double abLengthSquared = abX * abX + abY * abY;
            if (abLengthSquared == 0) return a; // segmento nullo

            double t = (apX * abX + apY * abY) / abLengthSquared;
            t = Math.Max(0, Math.Min(1, t)); // clamp t

            double x = a.X + t * abX;
            double y = a.Y + t * abY;

            return new Vector2(x, y);
        }


        Dictionary<string, List<XElement>> ExtractSvgGroups(string svgContent)
        {
            var doc = XDocument.Parse(svgContent);

            // Namespace SVG
            XNamespace ns = "http://www.w3.org/2000/svg";

            var result = new Dictionary<string, List<XElement>>(StringComparer.OrdinalIgnoreCase)
    {
        { "calpestabile", new List<XElement>() },
        { "copertura", new List<XElement>() }
    };

            // Cerca tutti i gruppi <g>
            var gruppi = doc.Descendants(ns + "g");

            foreach (var g in gruppi)
            {
                var id = g.Attribute("id")?.Value?.Trim().ToLower();

                if (id == "calpestabile" || id == "copertura")
                {
                    // ✅ Usa il namespace SVG per accedere correttamente agli elementi dentro <g>
                    var elementi = g.Elements().ToList();
                    result[id] = elementi;
                }
            }

            return result;
        }

        /// <summary>
        /// Converte un contenuto SVG in un file DXF, assegnando correttamente i layer "calpestabile" e "copertura".
        /// I blocchi vengono inseriti con i relativi attributi. La quota Z è lasciata a 0.
        /// La funzione restituisce il nome del layer "copertura" se contiene blocchi COLMO, altrimenti stringa vuota.
        /// </summary>
        // Modificato da Codex per realizzare: recupero DXF senza riscrivere lo SVG originale.
        string ConvertiSvgInDxf(string svgContent, string layerCalpestabileNome, string pathDxfModello, string pathOutput, bool salvaSvg = true)
        {
            TermodelLog.InitializeLog();
            // 1. Salva il file SVG per riferimento/debug
            string pathSvg =System.IO.Path.ChangeExtension(pathOutput, ".svg");
            if (salvaSvg) File.WriteAllText(pathSvg, svgContent);

            // 2. Estrazione logica SVG
            var gruppi = ExtractSvgGroups(svgContent); // Dictionary<string, List<XElement>>

            // Estrazione calpestabile
            List<XElement> elementiCalpestabile;
            if (!gruppi.TryGetValue("calpestabile", out elementiCalpestabile))
                elementiCalpestabile = new List<XElement>();

            var lineeCalpestabile = ExtractSvgLines(elementiCalpestabile);
            var blocchiCalpestabile = ExtractSvgBlocks(elementiCalpestabile);

            // Estrazione copertura
            List<XElement> elementiCopertura;
            if (!gruppi.TryGetValue("copertura", out elementiCopertura))
                elementiCopertura = new List<XElement>();

            var lineeCopertura = ExtractSvgLines(elementiCopertura);
            var blocchiCopertura = ExtractSvgBlocks(elementiCopertura);


            SpostaBlocchiFinestreSuLinea(blocchiCalpestabile, lineeCalpestabile);

            double fattc = 0.01;

            DxfDocument modello = DxfDocument.Load(pathDxfModello);
            DxfDocument nuovo = new DxfDocument();
            //nuovo.DrawingVariables.CodePage = "ANSI_1252";

            // 3. Layer fissi
            var layerCalpestabile = new netDxf.Tables.Layer(layerCalpestabileNome) { Linetype = netDxf.Tables.Linetype.Continuous };
            var layerCopertura = new netDxf.Tables.Layer("copertura") { Linetype = netDxf.Tables.Linetype.Continuous };

            nuovo.Layers.Add(layerCalpestabile);
            nuovo.Layers.Add(layerCopertura);

            // 4. Blocchi da modello
            var blocchiUnificati = blocchiCalpestabile.Concat(blocchiCopertura).ToList();
            foreach (var nomeBlocco in blocchiUnificati.Select(b => b.Tipo).Distinct())
            {
                if (!nuovo.Blocks.Contains(nomeBlocco) && modello.Blocks.Contains(nomeBlocco))
                {
                    nuovo.Blocks.Add(modello.Blocks[nomeBlocco]);
                }
            }

            // 5. Inserimento blocco NORD se presente
            if (modello.Blocks.Contains("NORD") && !nuovo.Blocks.Contains("NORD"))
            {
                nuovo.Blocks.Add(modello.Blocks["NORD"]);
                var insertNord = new Insert(modello.Blocks["NORD"], new Vector3(0, 0, 0)) { Layer = layerCalpestabile };
                nuovo.AddEntity(insertNord);
            }

            // 6. Inserimento linee calpestabile
            foreach (var l in lineeCalpestabile)
            {
                var linea = new netDxf.Entities.Line(
                    new Vector2(l.X1 * fattc, l.Y1 * fattc),
                    new Vector2(l.X2 * fattc, l.Y2 * fattc))
                {
                    Color = AciColor.Red,
                    Layer = layerCalpestabile,
                    Linetype = netDxf.Tables.Linetype.Continuous
                };
                nuovo.AddEntity(linea);
            }

            // 7. Inserimento linee copertura
            foreach (var l in lineeCopertura)
            {
                var linea = new netDxf.Entities.Line(
                    new Vector2(l.X1 * fattc, l.Y1 * fattc),
                    new Vector2(l.X2 * fattc, l.Y2 * fattc))
                {
                    Color = AciColor.Red,
                    Layer = layerCopertura,
                    Linetype = netDxf.Tables.Linetype.Continuous
                };
                nuovo.AddEntity(linea);
            }

            // 8. Inserimento blocchi calpestabile
            foreach (var blocco in blocchiCalpestabile)
            {
                ConvalidaAttributi(blocco);
                if (ContieneAncoraPlaceholder(blocco))
                {
                    TermodelLog.WriteLog($"[ConvalidaAttributi] Attenzione: il blocco '{blocco.Tipo}' contiene ancora valori non validi.");
                }
                var insert = new Insert(nuovo.Blocks[blocco.Tipo], new Vector3(blocco.X * fattc, blocco.Y * fattc, 0))
                {
                    Layer = layerCalpestabile
                };

                foreach (var att in blocco.Attributi)
                {
                    var attr = insert.Attributes.FirstOrDefault(a =>
                        a.Tag.Equals(att.Key, StringComparison.OrdinalIgnoreCase));
                    if (attr != null) attr.Value = att.Value;
                }

                nuovo.AddEntity(insert);
            }

            // 9. Inserimento blocchi copertura
            foreach (var blocco in blocchiCopertura)
            {
                ConvalidaAttributi(blocco);
                if (ContieneAncoraPlaceholder(blocco))
                {
                    TermodelLog.WriteLog($"[ConvalidaAttributi] Attenzione: il blocco '{blocco.Tipo}' contiene ancora valori non validi.");
                }
                var insert = new Insert(nuovo.Blocks[blocco.Tipo], new Vector3(blocco.X * fattc, blocco.Y * fattc, 0))
                {
                    Layer = layerCopertura
                };

                foreach (var att in blocco.Attributi)
                {
                    var attr = insert.Attributes.FirstOrDefault(a =>
                        a.Tag.Equals(att.Key, StringComparison.OrdinalIgnoreCase));
                    if (attr != null) attr.Value = att.Value;
                }

                nuovo.AddEntity(insert);
            }
            // per utilizzarlo bisogna aggiornare netdxf
            //nuovo.DrawingVariables.DwgCodePage = DwgCodePage.Windows1252; // Imposta la code page a ANSI_1252

            // 10. Salvataggio DXF
            nuovo.Save(pathOutput);
            CambiaCodePageModello_Veloce(pathOutput);
            // 11. Ritorno: layer "copertura" se contiene COLMO, altrimenti stringa vuota
            return blocchiCopertura.Any(b => b.Tipo.Equals("COLMO", StringComparison.OrdinalIgnoreCase))
                ? "copertura"
                : "";
        }
        void CambiaCodePageModello_Veloce(string pathDxf)
        {
            var righe = File.ReadAllLines(pathDxf).ToList();

            for (int i = 0; i < righe.Count - 2; i++)
            {
                if (righe[i].Trim() == "$DWGCODEPAGE" && righe[i + 1].Trim() == "3")
                {
                    if (righe[i + 2].Trim() != "ANSI_1252")
                    {
                        Console.WriteLine($"Codepage sostituita: {righe[i + 2].Trim()} → ANSI_1252");
                        righe[i + 2] = "ANSI_1252";
                        File.WriteAllLines(pathDxf, righe); // ⚠️ salva direttamente, con encoding predefinito
                    }
                    else
                    {
                        Console.WriteLine("Codepage già corretta.");
                    }
                    return;
                }
            }

            Console.WriteLine("Sezione $DWGCODEPAGE non trovata.");
        }

        void CambiaCodePageModello(string pathDxf, string nuovaCodePage = "ANSI_1252")
        {
            // Legge tutto il contenuto del file
            var righe = File.ReadAllLines(pathDxf).ToList();

            // Cerca l'indice della riga "$DWGCODEPAGE"
            int idx = righe.FindIndex(r => r.Trim().Equals("$DWGCODEPAGE", StringComparison.OrdinalIgnoreCase));

            if (idx >= 0 && idx + 2 < righe.Count)
            {
                string valoreCorrente = righe[idx + 2].Trim();

                if (!valoreCorrente.Equals(nuovaCodePage, StringComparison.OrdinalIgnoreCase))
                {
                    Console.WriteLine($"Sostituzione code page: {valoreCorrente} → {nuovaCodePage}");
                    righe[idx + 2] = nuovaCodePage;

                    // Sovrascrive il file originale
                    File.WriteAllLines(pathDxf, righe);
                }
                else
                {
                    Console.WriteLine("La code page è già corretta.");
                }
            }
            else
            {
                Console.WriteLine("La sezione $DWGCODEPAGE non è stata trovata nel file.");
            }
        }


        void PianiSVG(bool copertura, string nomelayercalpestabile)
        {
            var arch = Database.DB.GetCollection("Piani");

            // 1. Mantieni solo la prima riga (se c'è), usata per il piano calpestabile
            var primo = arch.FirstOrDefault();
            arch.Clear();

            if (primo == null)
            {
                primo = new Dictionary<string, object>();
            }

            primo["Nome"] = "Unico";
            primo["Tipo"] = "Calpestabile";
            primo["Attivo"] = "Attivo";
            primo["LayerCad"] = nomelayercalpestabile;
            primo["NomeFile"] = "DisegnoInput";
            primo["AltezzaNetta"] = 3.0;
            primo["AltezzaLorda"] = 3.3;
            primo["PianiUguali"] = 1;
            primo["TipoFinestre"] = "Nessuno";

            arch.Add(primo);

            // 2. Se c'è copertura, aggiungi una seconda riga
            if (copertura)
            {
                var cop = new Dictionary<string, object>
                {
                    ["Nome"] = "copertura",
                    ["Tipo"] = "Copertura",
                    ["Attivo"] = "Attivo",
                    ["LayerCad"] = "copertura",
                    ["NomeFile"] = "DisegnoInput",
                    ["AltezzaNetta"] = 3.0,
                    ["AltezzaLorda"] = 3.3,
                    ["PianiUguali"] = 1,
                    ["TipoFinestre"] = "Nessuno"
                };

                arch.Add(cop);
            }

            Database.DB.SaveData("Piani");
        }



        /*
        void ConvertiSvgInDxfOLD(string svgContent, string layer, string pathDxfModello, string pathOutput)
        {
            // 1. Salva il file SVG per riferimento o debug
            string pathSvg = System.IO.Path.ChangeExtension(pathOutput, ".svg");
            File.WriteAllText(pathSvg, svgContent);
            var linee = ExtractSvgLines(svgContent); // List<SvgLine>
            var blocchi = ExtractSvgBlocks(svgContent); // List<SvgBlock>
            SpostaBlocchiFinestreSuLinea(blocchi, linee);
            double fattc = 0.01;
            DxfDocument modello = DxfDocument.Load(pathDxfModello);
            DxfDocument nuovo = new DxfDocument();

            var dxfLayer = new netDxf.Tables.Layer(layer)
            {
                Linetype = netDxf.Tables.Linetype.Continuous
            };
            nuovo.Layers.Add(dxfLayer);

            // Inserisci il blocco NORD se presente nel modello
            if (modello.Blocks.Contains("NORD"))
            {
                var bloccoNord = modello.Blocks["NORD"];
                if (!nuovo.Blocks.Contains("NORD"))
                    nuovo.Blocks.Add(bloccoNord);

                // Inserisci il blocco NORD nel punto (0, 0, 0) — puoi cambiarlo a piacere
                var insertNord = new Insert(bloccoNord, new Vector3(0, 0, 0))
                {
                    Layer = dxfLayer
                };
                nuovo.AddEntity(insertNord);
            }

            foreach (var nomeBlocco in blocchi.Select(b => b.Tipo).Distinct())
            {
                if (modello.Blocks.Contains(nomeBlocco))
                {
                    nuovo.Blocks.Add(modello.Blocks[nomeBlocco]);
                }
            }

            foreach (var l in linee)
            {
                var linea = new netDxf.Entities.Line(new Vector2(l.X1 * fattc, l.Y1*fattc), new Vector2(l.X2 * fattc, l.Y2 * fattc))
                {
                    Color = AciColor.Red,
                    Layer = dxfLayer,
                    Linetype = new netDxf.Tables.Linetype("Continuous")
                };
                nuovo.AddEntity(linea);
            }

            foreach (var blocco in blocchi)
            {
                ConvalidaAttributi(blocco);

                var insert = new Insert(nuovo.Blocks[blocco.Tipo], new Vector3(blocco.X * fattc, blocco.Y * fattc, 0))
                {
                    Layer = dxfLayer
                };

                foreach (var att in blocco.Attributi)
                {
                    var attributo = insert.Attributes.FirstOrDefault(a =>
                        a.Tag.Equals(att.Key, StringComparison.OrdinalIgnoreCase));

                    if (attributo != null)
                    {
                        attributo.Value = att.Value;
                    }
                }

                nuovo.AddEntity(insert);
            }

            nuovo.Save(pathOutput);
        }

*/

        public class SvgLine
        {
            public double X1, Y1, X2, Y2;
        }

        public static List<SvgLine> ExtractSvgLines(List<XElement> elementi)
        {
            var lines = new List<SvgLine>();

            foreach (var el in elementi)
            {
                if (el.Name.LocalName != "line") continue;

                double x1 = double.Parse(el.Attribute("x1")?.Value ?? "0");
                double y1 = double.Parse(el.Attribute("y1")?.Value ?? "0");
                double x2 = double.Parse(el.Attribute("x2")?.Value ?? "0");
                double y2 = double.Parse(el.Attribute("y2")?.Value ?? "0");

                lines.Add(new SvgLine
                {
                    X1 = x1,
                    Y1 = y1,
                    X2 = x2,
                    Y2 = y2
                });
            }

            return lines;
        }

        public class SvgBlock
        {
            public string Tipo;
            public double X, Y;
            public Dictionary<string, string> Attributi = new();
        }

        public static List<SvgBlock> ExtractSvgBlocks(List<XElement> elementi)
        {
            var result = new List<SvgBlock>();

            foreach (var el in elementi)
            {
                if (el.Name.LocalName != "text") continue;

                // Coordinate del blocco
                double x = double.Parse(el.Attribute("x")?.Value ?? "0");
                double y = double.Parse(el.Attribute("y")?.Value ?? "0");

                // Estrai tutte le righe <tspan>
                var righe = el.Elements()
                              .Where(t => t.Name.LocalName == "tspan")
                              .Select(t => t.Value.Trim())
                              .ToList();

                if (righe.Count == 0 || !righe[0].StartsWith("BLOCCO", StringComparison.OrdinalIgnoreCase))
                    continue;

                var tipo = righe[0].Split(',')[1].Trim().ToUpper();

                // Estrai gli attributi riga per riga
                var attributi = righe
                    .Skip(1)
                    .Select(linea => linea.Split(','))
                    .Where(p => p.Length == 2)
                    .ToDictionary(p => p[0].Trim(), p => p[1].Trim(), StringComparer.OrdinalIgnoreCase);

                result.Add(new SvgBlock
                {
                    Tipo = tipo,
                    X = x,
                    Y = y,
                    Attributi = attributi
                });
            }

            return result;
        }


    }

}
