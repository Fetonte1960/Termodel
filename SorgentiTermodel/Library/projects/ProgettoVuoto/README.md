# ProgettoVuoto

Risorsa statica consultiva destinata a Termodel Web.

`ProgettoVuoto.termodel.txt` contiene un progetto iniziale completo nel formato
testuale `TERMODEL-PROJECT-TEXT-V1`. È stato generato dal contratto reale di
`POST /api/projects/new` usando il template `ProgettoBase` incorporato nel
WebService e può essere scaricato direttamente dal frontend senza interrogare
il server per la funzione Nuovo progetto.

## Contenuto

- manifest versione 1;
- copia verificata di `definizionedati.json` con impronta SHA-256;
- SVG multipiano iniziale;
- archivi del progetto base in XML e JSON;
- `DisegnoInput.dxf` del progetto base;
- input termico XML e JSON.

La copia della definizione è un artefatto di distribuzione in sola lettura. La
fonte autorevole rimane `Termodel/definizionedati/definizionedati.json`, che non
deve essere modificata attraverso questo progetto statico.

## Uso frontend

Il frontend deve trattare il file come testo UTF-8 e passarlo al caricatore
`TERMODEL-PROJECT-TEXT-V1` già previsto. Non deve modificare separatamente le
rappresentazioni XML e JSON dello stesso archivio.

## Aggiornamento

Rigenerare il file soltanto quando cambia intenzionalmente il progetto base o
la definizione dati autorizzata. Dopo ogni rigenerazione verificare marcatori,
sezioni, impronte e coerenza fra archivi XML e JSON.

Aggiornamento 23 settembre 2026: il progetto vuoto consolidato contiene anche `TipologiePannelli`, `Tubazioni` e `Fluidi`, con metadata separati in `definition/pannelli-tubazioni-definizionedati.json`. Queste sezioni preparano il completamento del calcolo pannelli radianti e devono essere conservate dal frontend anche se il relativo menu di gestione è ancora sospeso.
