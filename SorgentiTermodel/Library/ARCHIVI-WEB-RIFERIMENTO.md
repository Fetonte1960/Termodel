# Riferimento per ArchivioWeb

## Stato e provenienza

Questa Library contiene copie consultive, non adattate, dei sorgenti desktop attualmente usati da Termodel. Non è una seconda base di sviluppo e non deve divergere dagli originali. La fonte autorevole dello schema resta `Termodel/definizionedati/definizionedati.json`.

## Sorgenti effettivamente usati

- `utilities/Utidb.cs`: contiene `Database`, `Data_Collection` e `UtiDb`. Gestisce metadati, collezioni in memoria, inizializzazione, caricamento/salvataggio XML, griglie, form, combo e correlazioni.
- `definizionedati/AutoForm.cs`: genera controlli WPF da schema, trasferisce i valori fra controlli e record e apre il dettaglio di una riga.
- `definizionedati/FormArchivio.xaml` e `.xaml.cs`: finestra archivio realmente aperta da `MainWindow.GestArchivio`; genera griglia e form dettaglio dallo stesso schema.
- `definizionedati/Form dettaglio.xaml` e `.xaml.cs`: finestra usata da `AutoForm.DettaglioArchivio`.
- `MainWindow.xaml.cs`: contiene `SetArchivio`, `MenuArchivio` e `GestArchivio` e mostra quali menu usano oggi la griglia principale o `FormArchivio`.
- `utilities/GestProg.cs`: risolve il percorso operativo dello schema e di `dbtempfiles`.
- `leggidxf/ComunicazioneAutoCad.cs`: esempio di lettura della definizione, compreso `auto_combo`.

## Contratto dei metadati

Il JSON radice è un oggetto le cui proprietà sono i nomi degli archivi. Ogni archivio è un oggetto ordinato di campi; ogni campo contiene zero o più metadati:

- `Descr`: etichetta leggibile;
- `LunghezzaMassima`: larghezza usata dalla colonna desktop, non validazione Web sufficiente;
- `NumeroCifre` e `NumeroDecimali`: indicazioni di formato numerico;
- `Ini`: valore iniziale;
- `ReadOnly`: impedisce la modifica nel controllo;
- `Grid`: elenco dei tipi di vista nei quali mostrare il campo;
- `Form`: elenco dei tipi di form nei quali mostrare il campo;
- `Combo`: elenco statico oppure `['auto_combo', archivio, campo, valoreInizialeOpzionale]`;
- `Correlato`: relazione desktop fra archivio e campi correlati, da analizzare separatamente prima di riprodurla sul Web.

Gli archivi definiti oggi sono `Piani`, `Pareti`, `Finestre`, `Ponti`, `PontiAutomatici`, `PontiAutomaticiFinestre`, `Confini`, `NonClimatizzati`, `Zone` e `DatiCad`.

## Contratto delle righe e degli XML

In memoria ogni archivio è una `ObservableCollection<Dictionary<string, object>>`. Una riga è quindi una mappa `nomeCampo -> valore`. Il file `{NomeArchivio}.xml` è prodotto da `DataContractSerializer` su tale collezione e ha radice `ArrayOfArrayOfKeyValueOfstringanyType`; ogni record contiene elementi `KeyValueOfstringanyType` con `Key` e `Value`, e `Value` dichiara il tipo XML tramite `i:type`.

Il browser non dovrebbe interpretare direttamente questo XML come propria struttura interna: il WebService dovrà convertirlo in un DTO JSON stabile. I file in `examples/dbtempfiles` mostrano il formato desktop effettivo.

## Comportamento da riprodurre in ArchivioWeb

1. Caricare lo schema e selezionare la sezione con nome archivio esatto.
2. Caricare i record come array di oggetti JSON.
3. Generare le colonne usando `Grid` e le form usando `Form`; usare `Descr` come etichetta quando presente.
4. Per `Combo` statica usare i valori dichiarati.
5. Per `auto_combo` leggere il campo indicato dall'archivio sorgente, anteponendo l'eventuale quarto elemento.
6. Per una nuova riga assegnare `Ini`; per `auto_combo` usare l'eventuale quarto elemento; negli altri casi usare `null`.
7. Validare nomi archivio e campi sul server prima di salvare.
8. Non modificare mai lo schema come conseguenza di dati ricevuti dal browser.

## Dipendenze non portabili direttamente

`UtiDb`, `AutoForm` e `FormArchivio` dipendono da WPF (`Grid`, `DataGrid`, `ComboBox`, binding e finestre), `ObservableCollection`, filesystem locale, `DataContractSerializer`, stato globale `Database.DB`, `GestProg`, finestre specialistiche Pareti/Finestre e altre funzioni desktop. Sono riferimenti comportamentali: non devono essere copiati integralmente nel JavaScript.

## WebService disponibile oggi

Sono implementati:

```text
GET  /
GET  /health
GET  /api/model/capabilities
POST /api/projects/new
```

`POST /api/projects/new` usa lo schema per creare gli archivi iniziali e restituisce sia XML sia JSON nel file unico. Non esistono ancora endpoint CRUD per elencare schema/record, aggiungere, inserire, modificare, cancellare o salvare un archivio. Tali endpoint vanno progettati prima di eliminare la modalità demo, includendo identificazione del progetto, concorrenza, validazione e persistenza.

## Separazione consigliata

Il frontend realizza un solo motore `ArchivioWeb` per rendering e interazione. Il WebService conserva autorità su schema, valori iniziali, validazione, risoluzione delle combo dinamiche e persistenza. In questo modo il browser non diventa una seconda implementazione autonoma di `UtiDb`.
