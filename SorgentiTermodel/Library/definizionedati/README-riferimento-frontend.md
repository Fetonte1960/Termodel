# Riferimento per database dinamico e form automatiche

Questa cartella contiene copie di consultazione dei sorgenti desktop Termodel. Servono al developer frontend per comprendere il comportamento esistente; non costituiscono componenti Web riutilizzabili direttamente.

## File principali

- `definizionedati.json`: definizione dati distribuita. L'originale nel progetto Termodel rimane l'unica fonte autorevole.
- `AutoForm.cs`: crea dinamicamente controlli WPF in base ai metadati `Descr`, `Combo`, `ReadOnly`, `Grid` e `Form`.
- `FormArchivio.xaml` e `FormArchivio.xaml.cs`: esempio completo di elenco archivio, dettaglio dinamico, lettura, modifica e salvataggio.
- `Form dettaglio.xaml` e `Form dettaglio.xaml.cs`: finestra WPF di dettaglio generata dallo schema.
- `../utilities/Utidb.cs`: caricamento dei metadati, gestione delle collezioni, inizializzazione delle righe, XML, JSON, DataGrid e collegamento delle combo.

## Indicazioni per il frontend

Il frontend può ispirarsi alle regole e al flusso, ma deve tradurre i controlli WPF in componenti HTML/JavaScript senza copiare dipendenze desktop. In particolare:

1. legge lo schema senza alterarlo;
2. genera campi visibili usando `Descr`, `Grid` e `Form`;
3. usa `Combo` per le scelte ammesse e rispetta `ReadOnly`;
4. inizializza i valori secondo le stesse regole di `UtiDb.CreaRigaInizializzata`;
5. invia e riceve i dati attraverso i contratti del WebService;
6. non scrive mai modifiche nella copia di `definizionedati.json`.

`Utidb.cs` contiene anche funzioni specialistiche e dipendenze WPF/desktop non necessarie al browser. È quindi un riferimento comportamentale, non una libreria frontend e non va portato integralmente nel JavaScript.

Per lo stato dell'integrazione consultare `../../../docs/termodel-ui-demo/info_termodelwebservice.md`.
