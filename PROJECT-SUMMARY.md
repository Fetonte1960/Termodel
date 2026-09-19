# TERMODEL — PROJECT SUMMARY

> **Documento primario di continuità del progetto**
>
> Ogni nuova chat o sessione che lavora sul repository Termodel deve leggere **questo file per primo**, prima di proporre o modificare codice.
>
> Questo documento serve a evitare la perdita di contesto quando una chat diventa troppo lunga. Deve essere mantenuto breve, operativo e aggiornato dopo ogni intervento che cambia architettura, stato, file importanti, contratti o prossimi passi.

Ultimo aggiornamento: **2026-09-19**  
Branch di riferimento: **main**  
Ultimo commit verificato al momento della creazione di questo documento:  
`eadb72430a1f585bf542f50403cbb494c869dcc4` — `Connect complete project import and ArchivioWeb v0.22`

---

## 1. Regola obbligatoria per nuove chat

Prima di lavorare:

1. leggere questo `PROJECT-SUMMARY.md`;
2. sincronizzare/verificare il branch `main`;
3. controllare i commit successivi all'ultimo commit indicato qui;
4. leggere soltanto i documenti specialistici indicati nella sezione relativa al lavoro da svolgere;
5. non assumere che lo stato ricordato da una chat precedente sia ancora corrente;
6. prima di modificare codice, comunicare sinteticamente cosa si vuole cambiare e quali file sono coinvolti;
7. non fare commit o push se l'utente non ha autorizzato l'intervento.

Dopo un intervento significativo:

1. verificare i file modificati e il diff;
2. eseguire i test disponibili;
3. aggiornare **questo documento** se sono cambiati stato, architettura, contratti, versioni, responsabilità o prossimi passi;
4. indicare nel riepilogo finale il commit corrente o il commit creato.

Quando una chat sta diventando molto lunga, deve aggiornare questo file **prima** di perdere il contesto, in modo che una nuova chat possa continuare da qui.

---

## 2. Repository e obiettivo generale

Repository:

```text
https://github.com/Fetonte1960/Termodel
```

Termodel comprende attualmente tre aree che devono restare coordinate ma separate:

```text
Termodel desktop
        │
        ├── definizione dati autorevole
        ├── archivi desktop / XML
        └── motore storico
             │
             ▼
Termodel.Core / Termodel.WebService
             │
             ▼
Termodel Web HTML/CSS/JavaScript
```

Obiettivo progressivo: portare sul Web funzioni di Termodel senza trasformare il browser in una seconda implementazione indipendente del motore desktop.

---

## 3. Responsabilità e confini

### Chat/frontend Termodel Web

Responsabile di:

- HTML;
- CSS;
- JavaScript browser;
- rendering;
- griglie;
- form;
- navigazione;
- stato UI;
- BIM/CAD Web;
- Three.js / JSTS lato browser;
- workflow AI lato browser;
- motore generico `ArchivioWeb`;
- uso di provider astratti per accedere ai dati.

Non deve modificare senza coordinamento:

- Termodel desktop;
- Termodel.Core;
- Termodel.WebService;
- definizione dati autorevole;
- copie consultive della Library.

### Chat Core/WebService

Responsabile di:

- contratti frontend/backend;
- schema autorevole lato server;
- validazione;
- DTO;
- manifest;
- protocollo progetto;
- persistenza;
- concorrenza;
- XML/JSON;
- endpoint ASP.NET Core;
- diagnostica server.

Non deve modificare il frontend in parallelo senza avvisare l'utente.

---

## 4. Stato corrente del frontend Web

Frontend principale:

```text
docs/termodel-ui-demo/
```

Versione corrente verificata:

```text
Termodel Web v0.22
```

File centrali:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
docs/termodel-ui-demo/archivio-web.js
docs/termodel-ui-demo/definizionedati.json
docs/termodel-ui-demo/info_termodelwebservice.md
```

Dopo il commit di riferimento:

```text
d730074328f23048c913c6d3d332144f987b9a82
Add ArchivioWeb reference sources and sample archives
```

sono arrivati quattro commit:

```text
27df196  Add read-only Termodel archive schema for Web UI
d48c263  Implement generic ArchivioWeb engine v0.22
e6b623d  Activate archive menus and bump Termodel Web to v0.22
eadb724  Connect complete project import and ArchivioWeb v0.22
```

Questi commit hanno introdotto una prima implementazione reale di `ArchivioWeb`.

---

## 5. ArchivioWeb — stato attuale

File corrente:

```text
docs/termodel-ui-demo/archivio-web.js
```

È già un motore unico, non esistono form JavaScript separate per Pareti, Finestre, Zone ecc.

Attualmente contiene insieme:

```text
lettura schema
parsing TERMODEL-PROJECT-TEXT-V1
archivi in memoria
risoluzione combo
inizializzazione record
Correlato
CRUD locale
rendering HTML
stato UI
```

Funzioni già presenti:

- caricamento `definizionedati.json`;
- lettura archivi JSON dal file progetto completo;
- griglia dinamica;
- form dinamica;
- `Descr`;
- `ReadOnly`;
- combo statiche;
- `auto_combo`;
- inizializzazione tramite `Ini`;
- quarto valore opzionale di `auto_combo`;
- formattazione numerica;
- inserimento/modifica locale;
- restrizioni desktop su aggiunta/cancellazione di alcuni archivi;
- collegamento dei menu principali tramite `data-archive`.

Archivi protetti nella implementazione attuale:

```text
Finestre
Pareti
Ponti
Zone
```

La regola deriva dal comportamento attuale di `FormArchivio.xaml.cs`.

---

## 6. Problema architetturale aperto: manca ArchiveProvider

La v0.22 funziona come primo prototipo, ma la UI conosce ancora direttamente schema e dati.

Non risultano ancora implementati:

```text
ArchiveProvider
LocalArchiveProvider
TermodelWebServiceProvider
```

Architettura obiettivo:

```text
Menu archivio
      │
      ▼
  ArchivioWeb
 rendering + UI
      │
      ▼
 ArchiveProvider
   /        \
  /          \
Local       WebService
Provider    Provider futuro
```

Il frontend deve dipendere soltanto dal provider.

Contratto concettuale previsto:

```text
getSchema()
getArchiveNames()
loadArchive(name)
getRecord(name, index oppure id)
createInitializedRecord(name)
addRecord(name, record)
insertRecord(name, index, record)
updateRecord(name, index oppure id, record)
deleteRecord(name, index oppure id)
resolveCombo(name, field)
saveArchive(name, records)
```

Possibile estensione utile:

```text
getCapabilities(name)
```

per evitare regole UI hardcoded come l'elenco degli archivi nei quali aggiunta/cancellazione sono vietate.

---

## 7. Prossimo intervento frontend concordato

**Non ricominciare ArchivioWeb da zero.**

Primo refactoring consigliato:

```text
TERMODEL-PROJECT-TEXT-V1
          │
          ▼
termodel-project-text.js
          │
          ▼
LocalArchiveProvider
          │
          ▼
ArchivioWeb
```

Obiettivo del primo passo:

- mantenere il comportamento visivo corrente;
- separare parsing progetto, dati e UI;
- introdurre un provider locale sostituibile;
- nessuna API WebService inventata;
- nessuna modifica allo schema;
- nessuna modifica a Termodel desktop/Core/WebService.

File candidati:

```text
NUOVO    docs/termodel-ui-demo/archive-provider.js
NUOVO    docs/termodel-ui-demo/local-archive-provider.js
NUOVO    docs/termodel-ui-demo/termodel-project-text.js
MODIFICA docs/termodel-ui-demo/archivio-web.js
MODIFICA docs/termodel-ui-demo/app.js
```

`index.html` non dovrebbe richiedere modifiche nel primo refactoring salvo necessità emersa dai test.

---

## 8. Punti da correggere dopo/se durante il refactoring

Stato rilevato nella v0.22:

1. `Form` non viene realmente interpretato; la form usa principalmente i campi con `Descr`.
2. Se nessun campo ha `Grid:["Archivio"]`, il codice inventa un fallback di colonne: da rivalutare/eliminare.
3. `DatiCad` è nello schema ma non nell'ordine degli archivi della UI corrente.
4. `NonClimatizzati` e `DatiCad` hanno metadati insufficienti per una normale form archivio: non inventare campi frontend.
5. La cancellazione Web non chiede ancora conferma.
6. `Applica` modifica solo lo stato in memoria; non è persistenza server.
7. `Correlato` è oggi gestito dentro `archivio-web.js`; è preferibile spostare le regole dati fuori dal renderer.
8. I controlli HTML restituiscono principalmente stringhe; la tipizzazione definitiva deve restare responsabilità del livello dati/server.
9. L'hash dello schema è attualmente hardcoded nel frontend.
10. Il motore deve arrivare a gestire ogni archivio descritto dallo schema senza creare form specifiche duplicate.

---

## 9. Definizione dati — regola inderogabile

La fonte autorevole originale è dichiarata come:

```text
definizionedati/definizionedati.json
```

La copia consultiva disponibile nel repository è:

```text
SorgentiTermodel/Library/definizionedati/definizionedati.json
```

La copia pubblicata per il frontend è:

```text
docs/termodel-ui-demo/definizionedati.json
```

Le due copie Git verificate al 2026-09-19 risultano identiche e corrispondono all'impronta documentata:

```text
SHA-256
29E30DE64C7D45E4613F145AC485F573DB34F4328C6CE0BC7367EB92D83AAD0B
```

Regole:

- non modificare la copia frontend per aggiungere metadati Web;
- non creare uno schema concorrente nel JavaScript;
- ogni modifica dello schema deve nascere dalla fonte autorevole ed essere autorizzata;
- le copie devono essere propagate e verificate.

Nota di stato: nel clone GitHub corrente il percorso autorevole dichiarato non è esposto direttamente; sono presenti le copie di distribuzione/consultazione. Non assumere quindi che una copia sia automaticamente aggiornata solo perché è nel repository.

---

## 10. Metadati da supportare

`ArchivioWeb` deve comprendere almeno:

```text
Descr
Ini
ReadOnly
Grid
Form
LunghezzaMassima
NumeroCifre
NumeroDecimali
Combo
Correlato
```

Combo statica:

```json
"Combo": ["Valore 1", "Valore 2"]
```

Combo dinamica:

```json
"Combo": ["auto_combo", "NomeArchivio", "NomeCampo", "ValoreInizialeOpzionale"]
```

Regola di inizializzazione derivata da `UtiDb.CreaRigaInizializzata`:

```text
1. se esiste Ini → usare Ini
2. altrimenti se è auto_combo con quarto elemento → usare il quarto elemento
3. altrimenti → null
```

Non inventare valori termotecnici mancanti.

---

## 11. Riferimenti desktop obbligatori per ArchivioWeb

Prima di cambiare il comportamento degli archivi leggere:

```text
SorgentiTermodel/Library/ARCHIVI-WEB-RIFERIMENTO.md
SorgentiTermodel/Library/definizionedati/definizionedati.json
SorgentiTermodel/Library/utilities/Utidb.cs
SorgentiTermodel/Library/definizionedati/AutoForm.cs
SorgentiTermodel/Library/definizionedati/FormArchivio.xaml
SorgentiTermodel/Library/definizionedati/FormArchivio.xaml.cs
SorgentiTermodel/Library/definizionedati/Form dettaglio.xaml
SorgentiTermodel/Library/definizionedati/Form dettaglio.xaml.cs
SorgentiTermodel/Library/examples/dbtempfiles/
```

Gli XML di esempio servono a capire la serializzazione desktop; il browser deve continuare a lavorare internamente con:

```javascript
Array<Object>
```

e non con la struttura XML `DataContractSerializer`.

---

## 12. Stato WebService

Documento di coordinamento:

```text
docs/termodel-ui-demo/info_termodelwebservice.md
```

Endpoint verificati/documentati attualmente:

```text
GET  /
GET  /health
GET  /api/model/capabilities
POST /api/projects/new
```

`POST /api/projects/new` crea il contenitore progetto completo con SVG multipiano e archivi XML/JSON.

**Non esistono ancora API CRUD ufficiali per gli archivi.**

Il frontend non deve inventare endpoint come se fossero disponibili.

Quando servirà il provider server:

1. definire il requisito frontend;
2. proporre un contratto;
3. consegnarlo alla chat Core/WebService;
4. attendere l'implementazione/approvazione;
5. creare `TermodelWebServiceProvider` soltanto sul contratto reale.

---

## 13. Protocollo progetto

Il protocollo completo sperimentale corrente è:

```text
[TERMODEL-PROJECT-TEXT-V1]

---BEGIN:manifest.json---
...
---END:manifest.json---

---BEGIN:geometry/project.svg---
...
---END:geometry/project.svg---

---BEGIN:archives/xml/Piani.xml---
...
---END:archives/xml/Piani.xml---

---BEGIN:archives/json/Piani.json---
...
---END:archives/json/Piani.json---

[END-TERMODEL-PROJECT-TEXT-V1]
```

Il frontend v0.22 sa già importare le sezioni JSON degli archivi dal file completo.

Il protocollo precedente:

```text
[TERMODEL-SVG-TEXT-V1]
```

deve continuare a funzionare finché la migrazione non è approvata e collaudata.

---

## 14. Menu Web già collegati ad ArchivioWeb

Nella v0.22 risultano già collegati tramite `data-archive`:

```text
Gestione Piani
Archivio Pareti
Archivio Finestre
Archivio Ponti termici
Archivio Confini
Archivio Zone
Visualizza → Archivi
```

La migrazione dei menu deve restare progressiva. Non sostituire tutto in un'unica modifica.

---

## 15. Regole Git per questo progetto

Prima di intervenire:

```text
git/main aggiornato
→ verifica commit corrente
→ verifica eventuali modifiche concorrenti
→ modifica piccola
→ test
→ diff
→ riepilogo
```

Non sovrascrivere lavoro recente di altre chat.

Frontend e Core/WebService non devono essere modificati contemporaneamente sugli stessi file.

Per modifiche GitHub eseguite direttamente da una chat:

- leggere sempre la versione corrente del file immediatamente prima della modifica;
- non assumere SHA vecchi;
- creare commit piccoli e descrittivi;
- aggiornare questo summary quando cambia lo stato operativo.

---

## 16. Come aggiornare questo documento

Aggiornare solo ciò che serve. Non trasformarlo in un diario completo.

Aggiornare sempre:

- data ultimo aggiornamento;
- commit corrente rilevante;
- stato della funzione in lavorazione;
- decisioni architetturali nuove;
- file nuovi/eliminati/rinominati importanti;
- contratti frontend/backend approvati;
- blocchi o rischi aperti;
- prossimo passo concreto.

Le informazioni storiche ormai superate possono essere rimosse o sintetizzate.

L'obiettivo è che una nuova chat possa leggere questo file in pochi minuti e rispondere correttamente a:

```text
Dove siamo?
Come è organizzato il progetto?
Cosa è già stato fatto?
Quali decisioni sono già state prese?
Cosa non devo toccare?
Qual è il prossimo passo?
Quali file devo leggere?
```

---

## 17. Stato operativo al momento della creazione

**ArchivioWeb v0.22 esiste già e non deve essere riscritto da zero.**

Il prossimo lavoro frontend, salvo nuove istruzioni dell'utente, è:

> estrarre dalla v0.22 un livello `ArchiveProvider` e un `LocalArchiveProvider`, separando parsing del file progetto, accesso ai dati e rendering, preservando il funzionamento corrente.

Prima di iniziare questo refactoring, ricontrollare `main` perché potrebbero essere arrivati nuovi commit dopo `eadb72430a1f585bf542f50403cbb494c869dcc4`.
