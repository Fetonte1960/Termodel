# TERMODEL — CONTRATTO FRONTEND ↔ SERVICE

Versione documento: **1.9**  
Aggiornamento: **23 settembre 2026**  
Stato: **projectId-only e lock progetto implementati; pretest Render attivo; feedback utenti verso GitHub Issues implementato; artifact TermodelLog per progetto implementato; configurazione log per Aggiorna Modello implementata; archivi progetto Reti/TipologiePannelli implementati**

Questo documento è il riferimento condiviso tra **Termodel Web** e
**Termodel.Core / Termodel.WebService** per orchestrare la comunicazione fra
browser e server.

Non sostituisce:

- `PROJECT-SUMMARY.md`, che resta il Summary della linea Web JavaScript;
- `Server/Termodelwebservice/PROJECT-SUMMARY-SERVICE.md`, che resta il Summary
  della linea Core/WebService;
- `SorgentiTermodel/Library/`, che resta il riferimento dei sorgenti Desktop.

Quando frontend e server devono concordare endpoint, formati, sequenze,
versionamento o comportamento della comunicazione, **questo documento è il
punto comune da aggiornare**.

---

## 1. Obiettivo dell'architettura

Il frontend deve occuparsi principalmente di:

- interazione utente;
- CAD 2D;
- viewer e rappresentazione grafica;
- editing del progetto;
- composizione del file unico;
- visualizzazione degli elaborati restituiti dal server.

Il server deve occuparsi principalmente di:

- validazione del progetto;
- ricostruzione del modello Termodel;
- esecuzione dei calcoli;
- utilizzo della logica condivisibile proveniente dal Desktop;
- produzione degli elaborati derivati;
- esposizione degli elaborati tramite API.

Principio:

```text
FRONTEND
   |
   | file unico di progetto
   v
TERMODEL.WEBSERVICE
   |
   v
TERMODEL.CORE
   |
   | logica Termodel
   v
ARTIFACT DI CALCOLO
   |
   v
FRONTEND / VIEW
```

Il browser non deve diventare un secondo motore Termodel e il WebService non
deve contenere logica algoritmica che può vivere in `Termodel.Core`.

---

## 2. Input autorevole: file unico di progetto

Il formato di scambio principale è:

```text
TERMODEL-PROJECT-TEXT-V1
```

Il frontend invia al server l'intero **progetto tecnico necessario al calcolo**.

Questo non significa che il payload server debba essere identico byte-per-byte
al file locale salvato dal browser.

È già stabilita una distinzione fra:

```text
progetto locale completo
    può contenere risorse puramente frontend

payload server
    contiene il progetto tecnico necessario al calcolo
```

In particolare, gli **sfondi locali del CAD non devono essere trasmessi a
Termodel.Core / Termodel.WebService**.

Prima di `POST /api/calculations`, il frontend dovrà quindi derivare il payload
server dal `TERMODEL-PROJECT-TEXT-V1` corrente eliminando:

- sezioni `assets/backgrounds/*`;
- Data URL/Base64 appartenenti agli sfondi;
- riferimenti SVG usati esclusivamente per ricollegare gli sfondi locali;
- eventuali future risorse equivalenti dichiarate come locali/frontend.

Questa esclusione non riguarda sezioni tecniche del progetto necessarie al
motore, ad esempio `project/DisegnoInput.dxf` quando fa parte del progetto
Termodel e non è soltanto una risorsa grafica locale di sfondo.

Il file unico filtrato inviato al server rappresenta lo **stato autorevole del
progetto tecnico inviato**.

Gli elaborati prodotti dal server sono invece **derivati** da quello stato.

Esempi di sezioni già previste nel file unico:

```text
manifest.json
definition/definizionedati.json
definition/reti-pannelli-definizionedati.json
geometry/project.svg
archives/xml/*.xml
archives/json/*.json
project/DisegnoInput.dxf
thermal/input.xml
thermal/input.json
```

Il server non deve modificare implicitamente il file unico ricevuto mentre
calcola. Un eventuale futuro "progetto aggiornato dal server" dovrà essere
definito come operazione esplicita e separata.

## 2.0.1 Archivi di progetto per completamento pannelli radianti

Revisione del 23 settembre 2026: il modello dati autorevole per il
completamento pannelli radianti usa **due archivi estesi**, non tre:

```text
archives/json/Reti.json
archives/json/TipologiePannelli.json
```

con le corrispondenti sezioni XML:

```text
archives/xml/Reti.xml
archives/xml/TipologiePannelli.xml
```

I metadata sono separati dalla definizione Desktop storica:

```text
definition/reti-pannelli-definizionedati.json
```

### Responsabilità di `Reti`

`Reti` descrive la rete che il progettista sta definendo e raccoglie dati
**indipendenti dal costruttore del pannello**.

La struttura è predisposta per distinguere in futuro tipi di rete quali:

```text
PannelliRadianti
Tubazioni
Canali
...
```

ma nella fase corrente è implementato e precompilato soltanto
`PannelliRadianti`.

La prima riga è:

```text
Codice = RAD-DEFAULT
TipoRete = PannelliRadianti
CodiceTipologiaPannello = GEN-DEFAULT
```

Per la rete pannelli contiene almeno:

- tipologia pannello selezionata;
- passo scelto per quella rete;
- fluido, attualmente `Acqua`;
- temperatura mandata;
- temperatura ritorno;
- temperatura ambiente;
- temperatura esterna di progetto;
- lunghezza massima circuito;
- perdita di carico massima circuito;
- coefficiente `KLayout` per la stima lunghezza spirale;
- formula di perdita, inizialmente `Darcy-Weisbach`;
- stato attivo.

Il passo scelto è un **dato della rete/progetto**. Deve appartenere ai passi
ammessi dalla tipologia pannello selezionata. La validazione/combo dipendente
dei passi sarà completata quando verrà definita la gestione CAD della rete.

Le proprietà fisiche dell'acqua non vengono più replicate in un archivio
`Fluidi`: per il primo solver saranno derivate dalla temperatura media
dell'acqua. Eventuali fluidi diversi dall'acqua saranno una futura estensione
del programma generalista.

### Responsabilità di `TipologiePannelli`

`TipologiePannelli` è codificato per:

```text
CasaProduttrice + Modello
```

e contiene dati dipendenti dal prodotto/sistema:

- codice;
- casa produttrice;
- modello e descrizione;
- materiale tubo;
- diametro esterno;
- spessore;
- diametro interno;
- rugosità assoluta;
- presenza barriera ossigeno;
- elenco dei passi disponibili;
- lunghezza matassa;
- coefficiente di resa usato dal modello pannelli corrente;
- stato attivo.

L'elenco dei passi è necessario in particolare per sistemi con geometria
vincolata, per esempio pannelli a funghetti. Nella prima riga
`Generico / Default Termodel` è memorizzato come elenco separato da `;`:

```text
50;100;150;200;250;300
```

Il progetto default seleziona 300 mm per mantenere il precedente valore
hard-coded `PassoTubi = 0,30 m`.

### Regole di contratto

- `definizionedati.json` storico non viene modificato;
- `POST /api/projects/new` deve creare `Reti` e
  `TipologiePannelli` già precompilati;
- il `ProgettoVuoto` consolidato del frontend deve contenere gli stessi due
  archivi;
- i nuovi progetti **non devono più generare** gli archivi separati
  `Tubazioni` e `Fluidi`;
- apertura, modifica e ricostruzione del file unico devono conservare i due
  archivi;
- il frontend espone nel menu `Modifica`:
  `Archivio Reti` e `Archivio Tipologie pannelli`;
- `ArchivioWeb` legge i metadata da
  `definition/reti-pannelli-definizionedati.json`;
- per compatibilità transitoria, il caricatore frontend può ancora leggere la
  precedente sezione
  `definition/pannelli-tubazioni-definizionedati.json` se presente in un
  progetto già creato, senza però rigenerarla nei nuovi progetti;
- le vecchie sezioni `Tubazioni` e `Fluidi` presenti in un progetto
  precedente non vanno eliminate automaticamente al solo caricamento/salvataggio:
  sono dati legacy da preservare finché non viene definita una migrazione;
- `Reti` e `TipologiePannelli` sono dati tecnici del progetto e non devono
  essere filtrati dal payload inviato a `POST /api/calculations`;
- il contenitore resta `TERMODEL-PROJECT-TEXT-V1`.

### Selezione rete nel CAD 2D — decisione registrata, non ancora implementata

Il CAD 2D avrà una combo che seleziona una riga di `Reti`. La selezione
determinerà il **tipo di rete che si sta disegnando** e le proprietà di
progetto associate.

In questa fase non vengono ancora definiti:

- posizione e comportamento della combo;
- campo/attributo con cui le primitive CAD saranno associate alla rete;
- comandi grafici specifici per PannelliRadianti/Tubazioni/Canali;
- regole di cambio rete durante una sequenza di disegno.

Questi aspetti richiederanno un incarico separato.

## 2.1 Standard del payload Frontend → Service

Il file trasmesso dal frontend a `POST /api/calculations` mantiene il formato:

```text
TERMODEL-PROJECT-TEXT-V1
```

Non viene introdotta una seconda versione del progetto soltanto per il server:
si tratta dello stesso contenitore, derivato dallo stato corrente del progetto
e filtrato delle sole risorse locali/frontend.

Trasporto:

```http
Content-Type: text/plain; charset=utf-8
```

Struttura del contenitore:

```text
[TERMODEL-PROJECT-TEXT-V1]
---BEGIN:manifest.json---
...
---END:manifest.json---
---BEGIN:geometry/project.svg---
...
---END:geometry/project.svg---
...
[END-TERMODEL-PROJECT-TEXT-V1]
```

Regole normative del payload server:

- `manifest.json` e `geometry/project.svg` devono essere presenti;
- le sezioni tecniche del progetto devono essere conservate, comprese quelle
  necessarie al motore come archivi, input termici e
  `project/DisegnoInput.dxf` quando previsto dal progetto;
- tutte le sezioni `assets/backgrounds/*` devono essere escluse;
- il payload non deve contenere Data URL/Base64 appartenenti agli sfondi CAD;
- da `geometry/project.svg` devono essere eliminati gli elementi/riferimenti
  usati esclusivamente per visualizzare o reidratare tali sfondi;
- geometria tecnica, simboli, attributi Termodel e dati necessari al calcolo non
  devono essere eliminati;
- dopo il filtraggio, l'eventuale elenco delle sezioni e i relativi hash nel
  `manifest.json` devono descrivere il payload realmente trasmesso, non il file
  locale completo;
- il server tratta il testo ricevuto come input immutabile della specifica
  elaborazione;
- `geometry/project.svg` nel payload server deve usare il formato tecnico
  `TERMODEL-PROJECT-SVG-V1`, con namespace SVG e
  `data-termodel-units="cm"`;
- i piani devono essere figli diretti `g` della radice SVG e dichiarare
  `data-termodel-floor-id`, `data-termodel-name`,
  `data-termodel-role`, `data-termodel-file`,
  `data-termodel-layer` e `data-termodel-order`;
- dentro ogni gruppo di piano il reader corrente accetta come entità tecniche
  dirette `line` e `text`/blocchi; lo SVG operativo locale del CAD può
  avere una struttura diversa, ma deve essere trasformato nella forma tecnica
  canonica prima del POST senza alterare il progetto locale.

Il file locale completo può quindi continuare a contenere sfondi e altre
risorse di lavoro del browser, mentre il payload server contiene soltanto il
progetto tecnico.

## 2.2 Standard dell'artifact grafico Server → Frontend

L'artifact logico:

```text
model3d
```

usa come formato grafico condiviso:

```text
TermodelWebModel v3
```

e viene restituito come:

```http
Content-Type: application/json
```

Questo JSON è il formato destinato al redraw 3D dopo l'elaborazione autorevole
del progetto da parte del server. Deriva dalle primitive finali del motore
Termodel/DrawBim e non è una copia del progetto né un formato di editing.

Struttura radice:

```json
{
  "format": "TermodelWebModel",
  "version": 3,
  "coordinateSystem": "Z-up",
  "generatedAtUtc": "2026-09-21T00:00:00Z",
  "primitiveCount": 1,
  "primitives": []
}
```

Campi radice:

- `format`: deve essere `TermodelWebModel`;
- `version`: versione del formato, attualmente `3`;
- `coordinateSystem`: coordinate Termodel finali, attualmente `Z-up`;
- `generatedAtUtc`: istante di generazione in formato temporale ISO;
- `primitiveCount`: numero delle primitive;
- `primitives`: elenco delle primitive grafiche.

Ogni primitiva può contenere:

```json
{
  "kind": "mesh",
  "source": "MeshGeometry3D",
  "parte": "mesh",
  "numero": 1,
  "id": "elemento",
  "tipo": "Parete",
  "descrizione": "",
  "filterMetadata": true,
  "piano": "Piano Terra",
  "confine": "Esterno",
  "separatore": false,
  "stessaZona": false,
  "fittizia": false,
  "falda": false,
  "color": "#A0522D",
  "opacity": 1.0,
  "lineWidth": 1.0,
  "text": "",
  "vertices": [[0,0,0],[1,0,0],[1,1,0]],
  "indices": [0,1,2]
}
```

Significato:

- `kind`: tipo grafico; i valori correnti comprendono `mesh`,
  `lineSegments` e `label`;
- `source` e `parte`: provenienza e porzione grafica della primitiva;
- `numero`, `id`, `tipo`, `descrizione`: collegamento informativo con
  l'elemento Termodel;
- `filterMetadata`: indica se sono disponibili metadati completi per i filtri;
- `piano`, `confine`, `separatore`, `stessaZona`, `fittizia`, `falda`:
  metadati necessari a riprodurre i Filtri Grafici del Desktop;
- `color`: colore RGB `#RRGGBB`;
- `opacity`: opacità numerica;
- `lineWidth`: spessore logico per primitive lineari;
- `text`: testo delle eventuali label;
- `vertices`: coordinate finali `[x,y,z]` nel sistema `Z-up`;
- `indices`: indici dei vertici; triangoli per le mesh e coppie per i segmenti.

Regole di consumo frontend:

- il redraw 3D deve ricostruire la scena dall'artifact senza ricalcolare il
  modello Termodel nel browser;
- la conversione dal sistema `Z-up` di Termodel al sistema grafico usato dal
  viewer è responsabilità del frontend e non modifica il JSON;
- se `filterMetadata=false`, il frontend non deve inventare piano, confine o
  altri metadati mancanti;
- campi aggiuntivi compatibili possono essere ignorati dai client che non li
  conoscono;
- un `kind` non ancora supportato dal viewer non deve rendere inutilizzabile
  l'intero artifact;
- questo JSON è un risultato derivato del workspace corrente del progetto: non deve essere usato per
  ricostruire o sostituire il `TERMODEL-PROJECT-TEXT-V1`;
- leggere nuovamente `model3d` per lo stesso `projectId` non deve
  provocare una nuova elaborazione.

Le fonti implementative correnti del formato sono
`SorgentiTermodel/Work/Web/DrawBimJson.cs`,
`Server/Termodelwebservice/src/Termodel.Core/Model3D/TermodelWebModel.cs` e il
renderer di `docs/termodel-ui-demo/app.js`. Il contratto resta comunque il
riferimento comune fra frontend e server.

---

## 2.5 projectId persistente del progetto

Decisione architetturale aggiornata il **2026-09-22**.

Il contratto corrente usa un solo identificatore operativo e persistente:

```text
projectId
```

Il precedente concetto di identificatore separato per la singola elaborazione è
**superato** e non deve essere usato nelle nuove implementazioni. Eventuali
riferimenti storici a `calculationId` presenti in sezioni che descrivono
versioni precedenti del software non fanno più parte dell'architettura target.

Il `projectId`:

- identifica stabilmente il progetto;
- è assegnato dal **Termodel.WebService**;
- è opaco per il frontend;
- deve essere univoco rispetto ai progetti già registrati dal Service;
- viene consolidato nel `TERMODEL-PROJECT-TEXT-V1` come proprietà top-level
  di `manifest.json`;
- non cambia tra elaborazioni successive dello stesso progetto;
- è la chiave dominante per salvataggio, artifact, log e lettura dei risultati.

Esempio:

```json
{
  "format": "TERMODEL-PROJECT-TEXT-V1",
  "formatVersion": 1,
  "projectId": "7b30f4f4-...",
  "projectName": "Appartamento"
}
```

### Log Termodel corrente del progetto

Decisione del **2026-09-23**: il log applicativo prodotto dal motore Termodel
durante `Aggiorna Modello` è un risultato derivato del progetto corrente e
deve essere conservato nello stesso workspace del `projectId`.

Percorso logico:

```text
SavedProjects/{projectId}/logs/TermodelLog.md
```

Endpoint implementato:

```http
GET /api/projects/{projectId}/logs/termodel
```

Regole:

- il contenuto deriva dal `TermodelLog` usato dal Core e non da un secondo
  logger indipendente nel WebService;
- ogni elaborazione riuscita sostituisce il log corrente insieme agli altri
  output del workspace;
- una elaborazione fallita non deve sostituire il log dell'ultimo calcolo
  riuscito;
- la lettura del log non deve rilanciare il calcolo;
- la risposta usa `text/markdown; charset=utf-8`, nome logico
  `TermodelLog.md` e `X-Termodel-Artifact-Stale` per indicare se un
  salvataggio successivo ha reso il log riferito a uno stato precedente;
- `diagnostics.txt` e `calculation.log` restano disponibili internamente
  per retrocompatibilità e metadati tecnici;
- il frontend potrà consumare l'endpoint in una fase successiva, ma non è
  richiesto modificarlo per l'implementazione server.

### Configurazione log di Aggiorna Modello

`POST /api/calculations` mantiene il body tecnico
`TERMODEL-PROJECT-TEXT-V1` invariato. Le opzioni di log sono parametri di
esecuzione della singola elaborazione e non vengono inserite nel progetto.

Parametri query implementati:

```text
logEnabled=true|false
logCategories=Sempre,colmi,spezza,Error,Svg,RedrawHelix,GeneraModello,Performance,PontiAutomatici
```

Regole di compatibilità:

- se entrambi i parametri sono omessi, resta attivo il comportamento Service
  precedente: tutte le chiamate dirette `WriteLog`, `LogOperation` e
  `LogError` vengono raccolte, mentre i blocchi diagnostici protetti da
  `IsEnabled(...)` restano disattivati;
- `logEnabled=false` disabilita completamente la raccolta del log per quella
  elaborazione;
- quando `logCategories` è presente, passa a modalità filtrata:
  `IsEnabled(category)` è vero soltanto per le categorie selezionate e anche
  le scritture dirette vengono filtrate;
- `LogOperation` appartiene alla categoria Desktop `Sempre`;
- `LogError` appartiene alla categoria Desktop `Error`;
- i nomi categoria sono case-insensitive;
- `logCategories=all` abilita tutte le categorie;
- `logCategories=none` abilita nessuna categoria;
- una categoria sconosciuta è un errore della richiesta e non deve avviare il
  calcolo;
- la configurazione deve essere isolata per richiesta/progetto e non deve
  modificare flag globali condivisi fra utenti.

Esempi:

```http
POST /api/calculations?logCategories=colmi,spezza
POST /api/calculations?logCategories=all
POST /api/calculations?logEnabled=false
```

La risposta di `POST /api/calculations` riporta in modo additivo la
configurazione log effettivamente applicata; la stessa configurazione viene
registrata in `logs/calculation.log`.

**Implementazione frontend v0.99 (PC/Desktop):**

- il menu `Help` espone le nove categorie contrattuali come checkbox;
- tutte le categorie sono **disattivate di default**;
- nessuna categoria selezionata → il frontend invia
  `POST /api/calculations?logEnabled=false`;
- una o più categorie selezionate → il frontend invia
  `logEnabled=true` e `logCategories=<elenco>`;
- la configurazione resta un parametro della singola elaborazione e non entra
  nel `TERMODEL-PROJECT-TEXT-V1`;
- nello stesso menu `Help` è disponibile la **Modalità esplorazione**,
  disattivata di default: questa è esclusivamente una funzione UI e non cambia
  il contratto Service.

### Assegnazione di un nuovo projectId

Operazione:

```http
POST /api/projects/allocate-id
```

La richiesta assegna e riserva soltanto un nuovo identificatore. Non crea un
progetto Termodel e non modifica implicitamente un file progetto.

Risposta corrente:

```json
{
  "contractVersion": "TERMODEL-FRONT-SERVICE-V1",
  "projectId": "7b30f4f4-...",
  "projectLockToken": "token-opaco-temporaneo",
  "leaseExpiresAtUtc": "..."
}
```

Nel workflow implementato l'allocazione apre anche la lease iniziale del nuovo
progetto, così il client può salvarlo o calcolarlo senza una seconda apertura.

Il Service deve verificare/riservare l'unicità rispetto ai projectId già
presenti e deve gestire correttamente richieste concorrenti.

Flusso frontend:

```text
apri/crea progetto
        ↓
manifest.projectId presente?
   ├── sì → usa quello esistente
   └── no
        ↓
POST /api/projects/allocate-id
        ↓
riceve projectId
        ↓
consolida projectId in manifest.json
        ↓
ricostruisce TERMODEL-PROJECT-TEXT-V1
        ↓
POST /api/calculations
```

Il Service non deve assegnare silenziosamente un nuovo projectId dentro
`POST /api/calculations`.

### Persistenza fisica

La persistenza permanente è per progetto:

```text
SavedProjects/
└── {projectId}/
    ├── project.tmdl
    ├── artifacts/
    │   ├── model3d.json
    │   └── ... artifact disponibili
    └── logs/
        └── ... diagnostica/log correnti
```

Ogni nuova elaborazione riuscita dello stesso progetto **sovrascrive
atomicamente** i valori persistiti dalla precedente elaborazione. Non viene
mantenuto automaticamente uno storico per-elaborazione.

Il progetto persistito, gli artifact e i log della cartella devono quindi
rappresentare sempre l'ultima elaborazione riuscita del `projectId`.

Un'elaborazione fallita non deve distruggere l'ultimo stato valido. Può
aggiornare una diagnostica di errore separata, ma non deve sostituire
`project.tmdl` e artifact validi con output parziali.

---

> **Regola di prevalenza 2026-09-22:** qualunque riferimento storico a `calculationId` nelle note di implementazioni precedenti è superato. La nuova implementazione deve usare `projectId` come unico riferimento pubblico e persistente.

## 2.6 Operazioni progetto: Apri, Salva, Salva con nome

Decisione architetturale del **22 settembre 2026**.

Nel funzionamento con Termodel.WebService, le operazioni di persistenza del
progetto non devono essere realizzate dal frontend mediante accesso diretto al
filesystem o download/upload usati come storage operativo.

Le tre operazioni utente:

```text
Apri progetto
Salva progetto
Salva progetto con nome
```

sono responsabilità del **WebService**.

Il frontend deve limitarsi a:
- mostrare la UI di selezione/nome;
- inviare al Service la richiesta;
- ricevere il `TERMODEL-PROJECT-TEXT-V1` o l'esito dell'operazione;
- mantenere in memoria lo stato della pagina.

Il Service è responsabile di:
- enumerare/selezionare i progetti disponibili sul proprio storage;
- leggere il progetto richiesto;
- scrivere il progetto corrente;
- gestire nome e collocazione logica;
- applicare controlli sul `projectId`;
- impedire che due progetti indipendenti condividano accidentalmente la stessa
  identità.

### Apri progetto

Nel profilo con Service, il progetto viene scelto tramite dati forniti dal
Service e il file viene letto dal filesystem dal Service stesso.

Il frontend non deve dipendere dal path fisico del server.

Concettualmente:

```text
Frontend
   ↓
Apri progetto(projectId)
   ↓
WebService
   ↓
SavedProjects/{projectId}/project.tmdl
   ↓
TERMODEL-PROJECT-TEXT-V1
   ↓
Frontend
```

### Salva progetto

`Salva progetto` mantiene lo stesso `projectId` e aggiorna il
`TERMODEL-PROJECT-TEXT-V1` persistente del progetto.

Il salvataggio del sorgente progetto e il calcolo degli artifact restano due
operazioni distinte:

```text
Salva progetto
    → aggiorna il progetto persistente

Aggiorna Modello
    → esegue Termodel.Core e aggiorna gli artifact
```

Se il progetto viene salvato dopo l'ultimo calcolo, gli artifact esistenti
devono essere considerati **stale** fino al successivo `Aggiorna Modello`.
Non devono essere presentati come corrispondenti al nuovo contenuto solo perché
sono ancora presenti sul filesystem.

### Salva progetto con nome

`Salva progetto con nome` **conserva il projectId**.

Serve a cambiare il nome leggibile e, quando verrà introdotta la gestione di
cartelle logiche, eventualmente la collocazione mostrata nel ProjectBrowser.
Non crea automaticamente una seconda identità di progetto.

Un'eventuale futura operazione:

```text
Duplica come nuovo progetto
```

sarà distinta e dovrà richiedere un nuovo `projectId`.

### Mobile senza WebService

Per la versione mobile/serverless viene mantenuta, per questa fase, soltanto:

```text
Apri progetto
```

L'apertura locale è responsabilità dell'host/app mobile (ad esempio tramite
file picker nativo) e non del JavaScript mediante accesso libero al filesystem.

Nel profilo mobile senza Service non vengono esposte, per ora:

```text
Salva progetto
Salva progetto con nome
gestione catalogo/cartelle server
```

Questa limitazione riguarda la persistenza dei progetti e non implica che il
motore locale o le altre funzioni mobile debbano usare il WebService.

Le route implementate sono `GET /api/projects`,
`POST /api/projects/{projectId}/open`,
`PUT /api/projects/{projectId}/save` e
`PUT /api/projects/{projectId}/save-as?projectName=...`.
Heartbeat, chiusura e sblocco usano rispettivamente `/heartbeat`, `/close` e
`/unlock` sullo stesso projectId.

---

## 2.7 Cartella progetto e apertura esclusiva

Decisione architetturale del **22 settembre 2026**.

I file persistenti appartenenti a un progetto devono essere reperibili nella
**cartella del progetto** gestita dal Service. La struttura di riferimento
resta:

```text
SavedProjects/
└── {projectId}/
    ├── project.tmdl
    ├── artifacts/
    ├── logs/
    └── ... eventuali metadati tecnici del Service
```

Il Service può usare workspace/staging temporanei per garantire aggiornamenti
sicuri, ma tali directory non costituiscono una seconda copia autorevole del
progetto e devono essere ripulibili. Il contenuto persistente ufficiale del
progetto resta sotto `SavedProjects/{projectId}/`.

### Un solo utilizzo in modifica per projectId

Nel profilo Web/PC con Service, un progetto può essere aperto in modifica da
**una sola pagina/sessione alla volta**.

Alla prima apertura il Service acquisisce un lock esclusivo logico sul
`projectId`. Una seconda richiesta di apertura dello stesso progetto, finché
il lock è valido, deve essere rifiutata.

Comportamento utente previsto:

```text
pagina A apre P123
        ↓
lock P123 acquisito

pagina B tenta di aprire P123
        ↓
rifiuto
        ↓
"Il progetto è già in uso."
```

L'errore HTTP previsto per un progetto correttamente bloccato è:

```http
423 Locked
```

Il lock serve a impedire che due pagine modifichino e salvino contemporaneamente
lo stesso progetto, evitando la perdita silenziosa delle modifiche dell'una o
dell'altra.

Progetti differenti restano invece indipendenti e possono essere aperti
contemporaneamente:

```text
P123 → pagina A   consentito
P456 → pagina B   consentito
P789 → pagina C   consentito
```

### Token di apertura

L'apertura riuscita può restituire un token temporaneo/opaco di possesso del
lock, indicato concettualmente come `projectLockToken`.

Questo token:
- è valido solo per la sessione di apertura;
- non viene scritto in `manifest.json`;
- non modifica il `projectId`;
- non è un nuovo identificatore del progetto né un `calculationId`;
- serve esclusivamente a dimostrare al Service che la pagina che salva,
  rinomina, aggiorna o chiude il progetto è quella che ne possiede il lock.

Le future operazioni mutanti del progetto dovranno essere accettate soltanto
dal possessore del lock valido.

### Chiusura normale

Quando la pagina chiude correttamente il progetto:

```text
Chiudi progetto
      ↓
Service rilascia il lock
      ↓
P123 torna apribile
```

La chiusura del lock non deve modificare `project.tmdl`, artifact o log.

### Blocco improprio

Il lock non deve poter rendere un progetto inutilizzabile indefinitamente.

Situazioni da gestire:

```text
browser chiuso brutalmente
scheda terminata
PC client spento
rete interrotta
WebService terminato durante l'uso
riavvio del WebService
```

Per questo il lock deve essere una **lease rinnovabile**, non un flag
permanente senza scadenza.

Il Service deve mantenere almeno:
- identificativo/token del lock;
- istante di apertura;
- ultima attività/heartbeat;
- stato del lock.

La pagina attiva rinnova periodicamente la lease. Se gli heartbeat cessano per
un tempo superiore alla soglia configurata, il lock viene classificato
**stale** e può essere rimosso automaticamente dal Service.

La durata esatta della lease/timeout sarà una configurazione implementativa;
non deve essere codificata nel formato `TERMODEL-PROJECT-TEXT-V1`.

### Riavvio del Service

Al riavvio, il Service deve riconoscere i lock non più associati a una sessione
valida e recuperarli senza toccare i file del progetto.

Un lock residuo non è prova che il progetto sia ancora realmente in uso.

La procedura di recovery deve quindi distinguere:

```text
lock vivo
    → non aprire
    → 423 "Il progetto è già in uso"

lock scaduto/abbandonato
    → rimuovere il lock
    → consentire apertura

stato dubbio
    → non cancellare dati progetto
    → richiedere sblocco esplicito
```

### Sblocco esplicito

Il ProjectBrowser potrà esporre una funzione controllata:

```text
Sblocca progetto
```

destinata ai casi di lock improprio.

Regole:
- il frontend non elimina direttamente file di lock;
- decide sempre il Service;
- se il lock risulta attivo e recente, lo sblocco forzato deve richiedere una
  conferma esplicita dell'utente;
- lo sblocco elimina soltanto lo stato di occupazione e gli eventuali workspace
  temporanei abbandonati;
- non deve cancellare né modificare `project.tmdl`, gli artifact validi o i
  log correnti del progetto.

Finché non sarà introdotta autenticazione multiutente, questa funzione è
pensata per il Service locale controllato dall'utente. In futuro
l'autorizzazione allo sblocco dovrà rispettare proprietario/ruoli.

### Relazione con Salva e Aggiorna Modello

Con un progetto aperto e bloccato a favore della pagina corrente:

```text
Apri P123
   ↓
lock P123

Salva
Salva con nome
Aggiorna Modello
   ↓
consentiti solo alla sessione che possiede il lock
```

`Salva con nome` conserva lo stesso `projectId` e quindi anche la stessa
occupazione logica del progetto.

Una futura `Duplica come nuovo progetto` produrrà invece un nuovo projectId e
un lock indipendente.

---
## 2.8 Profilo di pretest remoto Render

Decisione operativa del **23 settembre 2026**.

Per il pretest remoto il Termodel.WebService pubblico è raggiungibile a:

```text
https://termodel.onrender.com
```

Il frontend pubblico resta:

```text
https://www.termodel.it
```

Il percorso principale di collaudo frontend ↔ Service usa quindi HTTPS pubblico.
Il supporto localhost/PNA può restare disponibile per sviluppo e compatibilità,
ma non è più necessario per il pretest remoto.

Endpoint minimi del pretest:

```http
GET  /health
GET  /api/model/capabilities
GET  /api/projects
POST /api/projects/allocate-id
POST /api/projects/{projectId}/open
PUT  /api/projects/{projectId}/save
PUT  /api/projects/{projectId}/save-as?projectName=...
POST /api/projects/{projectId}/heartbeat
POST /api/projects/{projectId}/close
POST /api/projects/{projectId}/unlock
POST /api/calculations
GET  /api/projects/{projectId}/artifacts/model3d
```

Il client che possiede il lock invia il token nell'header:

```text
X-Termodel-Project-Lock: <projectLockToken>
```

Il Service autorizza il frontend pubblico `https://www.termodel.it` tramite CORS.
Il precedente supporto localhost/PNA può restare per sviluppo locale.

### Hosting indipendente

L'API Termodel non deve dipendere da Render. Il Service deve restare compatibile
con Linux/.NET 8 in container e non introdurre percorsi Windows locali.

La porta HTTP non deve essere fissata nel codice applicativo. Nel container
Render la porta viene fornita dalla variabile `PORT`; il Dockerfile deve
continuare ad adattarsi alla porta assegnata dall'hosting.

### Persistenza nel pretest Free

L'istanza Render Free usa filesystem effimero. Di conseguenza:
- `SavedProjects` è valido per test funzionali durante la vita dell'istanza;
- non è storage definitivo dei progetti clienti;
- restart, redeploy o ricreazione possono eliminare progetto, artifact, lock
  e altri file locali;
- questa limitazione non modifica il contratto projectId-only e non giustifica
  l'introduzione di un nuovo identificatore o di storage alternativi nel frontend.

Un hosting/storage persistente verrà scelto separatamente prima dell'uso
produttivo.

### Sleep/wakeup Render Free

Dopo inattività l'istanza Free può essere sospesa. La prima richiesta successiva
può richiedere circa 50 secondi o più. Nel pretest il frontend deve presentare
uno stato di attesa/connessione e non trattare automaticamente questa latenza
come errore Termodel.

**Implementazione frontend v0.96:** prima della prima operazione server il
browser verifica nell'ordine:

```text
GET /health
    ↓
GET /api/model/capabilities
    ↓
operazione progetto / Aggiorna Modello
```

Durante l'attesa mostra una barra di avanzamento con la descrizione
`Sto avviando Termodel Service…`. Per il wake-up del piano Free il client usa
un timeout di **90 secondi**; la verifica capabilities successiva usa 30
secondi. Dopo una verifica riuscita il risultato viene riutilizzato per una
breve finestra (60 secondi), evitando richieste di readiness ripetitive.

La base URL predefinita è `https://termodel.onrender.com`; resta configurabile
tramite `globalThis.TERMODEL_SERVICE_BASE_URL`, quindi localhost e altri
ambienti non richiedono modifiche al contratto.

### Client desktop e mobile

PC, Android, tablet, iPhone e altri client Web che usano il Service remoto
devono poter utilizzare la stessa base URL HTTPS pubblica. La precedente variante
mobile completamente serverless può restare una modalità separata, ma il
ProjectBrowser Web mobile del pretest non deve dipendere dalla presenza di un
PC locale per raggiungere Termodel.WebService.

---
## 2.9 Feedback utenti verso GitHub

Decisione architetturale del **23 settembre 2026**.

I suggerimenti/bug inviati dagli utenti non devono produrre commit automatici
nel branch `main` e il container Render non deve eseguire `git push`.

La destinazione scelta è **GitHub Issues** del repository:

```text
Fetonte1960/Termodel
```

Il browser invia il feedback esclusivamente al Termodel.WebService:

```http
POST /api/feedback
Content-Type: application/json
Origin: https://www.termodel.it
```

Payload previsto:

```json
{
  "message": "Testo del suggerimento o problema",
  "category": "suggestion",
  "title": "Titolo opzionale",
  "page": "/termodel-ui-demo/",
  "appVersion": "0.98"
}
```

Campi:
- `message`: obbligatorio;
- `category`: `suggestion`, `bug`, `question` oppure `other`;
- `title`: opzionale;
- `page`: opzionale, percorso/pagina applicativa senza dati personali;
- `appVersion`: opzionale.

Il Service crea una GitHub Issue e restituisce, a creazione riuscita:

```json
{
  "status": "created",
  "issueNumber": 123,
  "issueUrl": "https://github.com/Fetonte1960/Termodel/issues/123"
}
```

Regole di sicurezza/privacy:
- il token GitHub resta **solo sul server** e non viene mai inviato al frontend;
- usare un fine-grained token con accesso al solo repository Termodel e
  permesso minimo `Issues: Read and write`;
- il Service non allega automaticamente file progetto, `projectId`, email, IP,
  cookie o contenuti tecnici del progetto alla Issue;
- il body utente è validato per lunghezza e categoria;
- l'endpoint accetta soltanto l'origine Web Termodel configurata;
- è previsto un rate-limit server-side per limitare abusi/spam;
- se la configurazione GitHub non è disponibile l'endpoint restituisce un
  errore strutturato e non salva il feedback nel filesystem effimero Render.

Configurazione prevista lato Service/Render:

```text
TERMODEL_FEEDBACK_GITHUB_TOKEN=<secret>
TERMODEL_FEEDBACK_REPOSITORY=Fetonte1960/Termodel
TERMODEL_FEEDBACK_ALLOWED_ORIGIN=https://www.termodel.it
TERMODEL_FEEDBACK_GITHUB_API_BASE_URL=https://api.github.com
```

`TERMODEL_FEEDBACK_GITHUB_TOKEN` deve essere configurato come secret
dell'hosting, mai nel repository.

Il frontend `Invia suggerimento` sarà un intervento separato; questa sezione
definisce il contratto dell'endpoint server.

---
## 3. Operazione principale: AggiornaCalcolo

L'azione concettuale principale fra frontend e server è:

```text
AggiornaCalcolo
```

Endpoint:

```http
POST /api/calculations
Content-Type: text/plain; charset=utf-8
```

**Stato implementazione 22 settembre 2026:** il Service usa ora il modello
projectId-only. `POST /api/projects/allocate-id` assegna e riserva il
`projectId`; `POST /api/calculations` legge `manifest.projectId`, aggiorna
`SavedProjects/{projectId}/` e restituisce `projectId` senza un secondo
identificatore per-elaborazione. `model3d` viene persistito su disco e letto
tramite `GET /api/projects/{projectId}/artifacts/model3d` senza ricalcolo.
Il precedente snapshot RAM per-elaborazione e la relativa route artifact sono
stati rimossi dal WebService.

### Commissione frontend — modalità Copertura e simbolo Colmo

Stato: **ESEGUITO** — 21 settembre 2026.

Riferimenti usati:

- `docs/infotermodelGPT.html`;
- `SorgentiTermodel/Library/leggidxf/CadGPT.xaml.cs`;
- `SorgentiTermodel/Library/leggidxf/ScriptCad.cs`;
- `SorgentiTermodel/Library/MainWindow.xaml`;
- `Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/Leggidxf/LeggiDxf.cs`;
- `Server/Termodelwebservice/src/Termodel.Core/NetDxfCompat/SvgDxfReader.cs`.

Termodel Web v0.77 implementa la modalità CAD specifica per
`Piani.Tipo=Copertura`:

- lo sfondo locale duplicato o derivato dal DisegnoInput viene visualizzato
  in grigio e con opacità ridotta;
- i comandi Porta/Finestra, Finestra 2 punti e Ponte vengono nascosti;
- il comando di linea resta disponibile con dicitura
  `Linea perimetro falde`;
- il blocco tecnico `LOC` resta invariato ma nel CAD viene presentato come
  `Centrofalda`;
- compare il comando `Colmo` soltanto in modalità Copertura;
- il punto di inserimento del Colmo viene agganciato alla linea più vicina;
- il simbolo viene serializzato secondo lo standard Desktop/Core:

```text
BLOCCO,Colmo
QUOTACOLMO,...
QUOTAGRONDA,...
LATOPARTEBASSA,...
QUOTASHED,...
PARETESHED,...
```

- il pannello proprietà del Colmo modifica i cinque attributi usando i campi
  `DatiCad` già esistenti: `QuotaColmo`, `QuotaGronda`,
  `LatoParteBassaShed`, `QuotaShed`, `PareteShed`;
- `PareteShed` riusa la combo/archivio Pareti prevista da
  `definizionedati.json`;
- il pannello linee cambia intestazione in
  `Copertura · Linee perimetro falde`;
- il frontend continua a non generare il tetto 3D: i blocchi e le linee sono
  input per il Service/Core.

Il comportamento corrisponde al Core corrente: `LeggiDxf` legge i blocchi
`Colmo`, associa il simbolo alla linea più vicina, assegna
`QUOTACOLMO` ai vertici della linea, registra `QUOTAGRONDA` e gestisce
`QUOTASHED/LATOPARTEBASSA/PARETESHED` per gli shed.

Verifica eseguita: sintassi JavaScript valida e presenza dei comandi/formati
controllata nei sorgenti. Test funzionale browser → Service ancora da eseguire.

### Commissione frontend — fallback sfondo Copertura da DisegnoInput

Stato: **ESEGUITO** — 21 settembre 2026.

Termodel Web v0.76 completa `＋ Copertura` con questo fallback:

- se il piano corrente possiede già uno sfondo locale, lo duplica sul nuovo
  piano come nella v0.75;
- se non esiste uno sfondo, costruisce una fotografia vettoriale SVG del
  DisegnoInput del piano corrente e la incorpora come sfondo locale della
  nuova copertura;
- dalla copia SVG usata come sfondo vengono rimossi gli accessori locali
  (Nord, contenitore sfondi, ecc.);
- lo sfondo conserva lo stesso viewBox/allineamento del disegno sorgente ed è
  marcato come `data-termodel-sfondo-tipo="vector"`;
- pareti e simboli sorgenti non vengono duplicati come geometria tecnica della
  copertura: compaiono soltanto dentro l'immagine SVG di riferimento;
- il fallback resta risorsa frontend e viene escluso dal payload Service dalle
  regole già vigenti sugli sfondi.

Verifica eseguita: sintassi JavaScript valida e pubblicazione v0.76 coerente.
La prova funzionale browser resta da eseguire.

### Commissione frontend — nuovo piano Copertura per test Service avanzato

Stato: **ESEGUITO** — 21 settembre 2026.

Termodel Web v0.75 aggiunge il comando `＋ Copertura` accanto ad `Arc`
nella selezione del piano.

Il comando:

- crea un vero record `Piani` inizializzato secondo
  `definizionedati.json`, senza modificare lo schema;
- imposta `Tipo = Copertura`;
- genera `Nome` e `LayerCad` univoci (`Copertura`,
  `Copertura 2`, ...);
- mantiene il `NomeFile` del piano sorgente;
- duplica esclusivamente lo sfondo locale, mantenendo trasformazioni,
  dimensioni e calibrazione, e lo associa al nuovo piano/layer;
- non duplica pareti, simboli o altra geometria tecnica;
- commuta immediatamente il CAD sul nuovo piano;
- consolida la geometria 2D di un piano `Copertura` senza invocare
  `GeneraPianta.js` e senza produrre un tetto 3D locale;
- lascia invariata l'anteprima locale dei piani `Calpestabile`.

La trasformazione verso `TERMODEL-PROJECT-SVG-V1` è stata inoltre resa
multipiano: nello SVG operativo Web le entità possono restare nel contenitore
storico comune, mentre `data-termodel-piano` e `LayerCad` determinano il
gruppo tecnico corretto inviato al Service. Il piano `Copertura` e le sue
entità tecniche vengono quindi trasmessi a `AggiornaCalcolo`; lo sfondo
resta esclusivamente frontend.

Verifica eseguita: sintassi JavaScript dei moduli modificati valida e diff
limitato a frontend/contratto. La prova funzionale reale di tetti e locali
mansardati sul Service è il passo successivo e non è ancora dichiarata
verificata.

### Commissione frontend — copia diagnostica risposte Service

Stato: **ESEGUITO** — 21 settembre 2026.

Termodel Web v0.74 prepara automaticamente negli appunti, dopo
`Aggiorna Modello`, un blocco diagnostico `TERMODEL-SERVICE-EXCHANGE-V1`
contenente le risposte effettivamente ricevute dal Service:

- status HTTP e corpo della risposta di `POST /api/calculations`;
- `projectId`, manifest e diagnostica presenti nella risposta POST;
- URL, status HTTP e corpo del GET artifact corrente;
- in caso di errore, la risposta disponibile e il messaggio client.

Il testo copiato contiene le risposte del server, non il payload progetto
inviato. Viene inoltre mantenuto in
`globalThis.TERMODEL_LAST_SERVER_EXCHANGE` come supporto diagnostico.

La Clipboard API viene tentata per prima; esiste un fallback browser basato su
selezione/copia. L'eventuale impossibilità di copiare non deve far fallire il
calcolo o il rendering e viene indicata nella barra di stato.

### Commissione frontend — indicatore origine rendering

Stato: **ESEGUITO** — 21 settembre 2026.

Termodel Web v0.72 mostra nel viewer un indicatore persistente dell'origine del
modello visualizzato:

- `ANTEPRIMA LOCALE · nessuna elaborazione server` per JSON demo e preview
  prodotte nel browser;
- `RENDERING ELABORATO DA TERMODEL SERVICE · projectId ...` per
  l'artifact `model3d` corrente del progetto.

Per il rendering server viene mostrata una forma abbreviata del
`projectId` e l'identificativo completo resta disponibile nel tooltip.
L'indicatore descrive il modello attualmente visualizzato e non viene usato come
prova autonoma della correttezza del calcolo.

### Commissione frontend — SVG tecnico canonico per AggiornaCalcolo

Stato: **ESEGUITO** — 21 settembre 2026.

Anomalia osservata nella prima prova reale browser → Service:

```text
Errore Aggiorna Modello: AggiornaCalcolo:
Lo SVG deve dichiarare data-termodel-units='cm'.
```

La prova ha confermato che browser, CORS, `POST /api/calculations` e Core
erano raggiunti; l'errore proveniva dalla validazione `SvgDxfReader`.

Termodel Web v0.73 corregge il payload senza modificare il WebService/Core:

- lo SVG locale CAD/AI resta invariato;
- `buildTermodelServerPayload(...)` ricostruisce per il solo POST un
  `geometry/project.svg` con radice
  `data-termodel-format="TERMODEL-PROJECT-SVG-V1"` e
  `data-termodel-units="cm"`;
- i gruppi piano vengono ricavati dal manifest/archivio `Piani` e riportano
  `floor-id/name/role/file/layer/order`;
- vengono trasferite soltanto le entità tecniche dirette `line` e i
  `text` che dichiarano `BLOCCO,...`, assegnandole al piano tramite
  `data-termodel-piano`/layer;
- gli attributi locali `data-termodel-tipo-linea` e
  `data-termodel-colore` vengono tradotti, quando disponibili, nei campi
  `data-termodel-linetype` e `data-termodel-color` letti dal Core;
- sfondi e accessori grafici frontend non entrano nello SVG tecnico;
- manifest e SHA-256 vengono rigenerati sul payload finale.

Verifica eseguita: sintassi JavaScript di `app.js` e
`termodel-project-text.js` valida e presenza dei metadati canonici
controllata sui sorgenti. La nuova esecuzione runtime sul PC dopo v0.73 è
ancora da effettuare e resta un livello di verifica separato.

### Commissione frontend — pulsante Aggiorna Modello

Stato: **ESEGUITO** — 21 settembre 2026.

Implementazione frontend: Termodel Web v0.71. Il pulsante mantiene il JSON demo
quando non esiste un progetto strutturato; con progetto corrente costruisce un
payload tecnico temporaneo tramite `buildTermodelServerPayload(...)`, chiama
`POST /api/calculations`, segue l'`href` dell'artifact `model3d` e passa il
`TermodelWebModel v3` ricevuto al renderer esistente.

Il payload temporaneo rimuove `assets/backgrounds/*` e gli elementi SVG
marcati come sfondo, quindi rigenera l'elenco sezioni e gli SHA-256 del
`manifest.json`. Il progetto locale completo non viene privato degli sfondi.

Stato di verifica: sintassi JavaScript controllata; il ciclo browser pubblico
→ WebService locale → artifact 3D deve ancora essere provato sul PC reale.

Il pulsante `Aggiorna Modello` del frontend deve applicare il seguente
comportamento senza introdurre endpoint alternativi:

```text
nessun progetto strutturato
    -> carica il TermodelWebModel.json di esempio

progetto strutturato corrente
    -> costruisce TERMODEL-PROJECT-TEXT-V1 corrente
    -> deriva il payload tecnico senza sfondi locali/frontend
    -> POST /api/calculations
    -> riceve projectId + manifest
    -> segue l'href dell'artifact model3d
    -> GET artifact model3d
    -> renderizza TermodelWebModel v3 nel viewer
```

Il file progetto locale completo deve restare invariato rispetto alle proprie
risorse frontend: il filtraggio degli sfondi produce soltanto il payload
temporaneo destinato al Service.

Body:

```text
[TERMODEL-PROJECT-TEXT-V1]
...
[END-TERMODEL-PROJECT-TEXT-V1]
```

La richiesta deve provocare **una sola elaborazione coerente** del progetto.

Non deve accadere:

```text
richiesta XML        -> ricalcola tutto
richiesta spirali    -> ricalcola tutto
richiesta report     -> ricalcola tutto
richiesta modello 3D -> ricalcola tutto
```

Deve accadere:

```text
AggiornaCalcolo
      |
      v
una ricostruzione del modello
      |
      +--> modello 3D
      +--> piante pulite
      +--> XML nazionale
      +--> dispersioni
      +--> pannelli
      +--> spirali
      +--> altri elaborati futuri
```

Le view leggono successivamente gli elaborati già prodotti.

---

## 4. projectId come riferimento unico del progetto

Il `projectId` è il riferimento dominante sia per la persistenza sia per la
lettura degli artifact.

Non esiste nel contratto corrente un identificatore separato per la singola
elaborazione.

Ogni `AggiornaCalcolo` dello stesso progetto sostituisce il risultato
precedente:

```text
projectId P123
    ↓
AggiornaCalcolo #1
    ↓
SavedProjects/P123/ = risultato 1

projectId P123
    ↓
AggiornaCalcolo #2
    ↓
SavedProjects/P123/ = risultato 2
```

Il risultato 2 sostituisce il risultato 1 come stato corrente del progetto.

Se in futuro sarà necessaria una cronologia dei calcoli, dovrà essere
introdotta come funzione esplicita separata.

---

## 5. Risposta di AggiornaCalcolo

Il server risponde quando il nuovo stato del progetto è stato elaborato e
persistito con successo.

Risposta indicativa:

```json
{
  "contractVersion": "TERMODEL-FRONT-SERVICE-V1",
  "projectId": "7b30f4f4-...",
  "status": "completed",
  "savedProject": {
    "fileName": "project.tmdl"
  },
  "artifacts": [
    {
      "name": "model3d",
      "contentType": "application/json",
      "href": "/api/projects/7b30f4f4-.../artifacts/model3d"
    }
  ],
  "diagnostics": []
}
```

La risposta non deve introdurre un identificatore per-elaborazione.

Il Service legge `manifest.projectId` dal `TERMODEL-PROJECT-TEXT-V1`.
Se manca, il nuovo flusso frontend deve prima usare
`POST /api/projects/allocate-id` e consolidare l'ID nel manifest.

Stati previsti:

- `completed`: nuova elaborazione completata e workspace aggiornato;
- `completed_with_warnings`: workspace aggiornato con diagnostica non bloccante;
- errore HTTP: elaborazione non consolidata; l'ultimo workspace valido resta
  disponibile.

---

## 6. Manifest degli artifact

La risposta a `AggiornaCalcolo` contiene il manifest degli elaborati realmente
disponibili.

Il frontend **non deve supporre** che tutti gli artifact esistano sempre.

Esempi:

| Artifact logico | Formato previsto | Uso principale |
|---|---|---|
| `model3d` | JSON | viewer 3D |
| `pianta-pulita/{piano}` | SVG | viste di pianta |
| `xml-nazionale` | XML | export APE nazionale |
| `report-dispersioni` | JSON | view dispersioni |
| `pannelli` | JSON | view calcolo pannelli |
| `spirali/{piano}` | SVG | view pannelli radianti |
| `esecutivo-dxf/{piano}` | DXF | eventuale download/esecutivo futuro |

Il manifest deve descrivere ciò che è presente nel workspace corrente del progetto,
non ciò che il server potrebbe teoricamente produrre.

---

## 7. Lettura degli artifact

Gli artifact correnti sono letti tramite `projectId`.

Endpoint di riferimento:

```http
GET /api/projects/{projectId}/artifacts/model3d
```

Schema previsto:

```http
GET /api/projects/{projectId}/artifacts/model3d
GET /api/projects/{projectId}/artifacts/xml-nazionale
GET /api/projects/{projectId}/artifacts/report-dispersioni
GET /api/projects/{projectId}/artifacts/pannelli
GET /api/projects/{projectId}/artifacts/spirali/{piano}
GET /api/projects/{projectId}/artifacts/pianta-pulita/{piano}
```

Regola fondamentale:

> leggere un artifact non deve rieseguire il calcolo.

Dopo un nuovo `AggiornaCalcolo` riuscito, lo stesso URL del progetto restituisce
il nuovo artifact corrente perché la precedente elaborazione è stata
sostituita.

Il manifest della risposta deve fornire gli `href` correnti.

---

## 8. Formato dei dati per le view

Il Core deve restituire **dati**, non UI.

Per esempio il report dispersioni non deve arrivare come HTML già impaginato.

Preferibile:

```json
{
  "totaleDispersioni": 4823.5,
  "zone": [
    {
      "id": "Z1",
      "descrizione": "Zona principale",
      "totaleDispersioni": 4823.5,
      "locali": []
    }
  ]
}
```

Il frontend decide:

- tabella;
- card;
- grafico;
- pannello laterale;
- stampa;
- formattazione.

Lo stesso principio vale per il calcolo pannelli.

Gli SVG, invece, sono adatti a essere restituiti direttamente quando
rappresentano elaborati grafici 2D come pianta pulita o spirali.

---

## 9. Orchestrazione lato frontend

Flusso previsto:

```text
utente apre/crea progetto
        ↓
projectId presente nel manifest?
   ├── no → POST /api/projects/allocate-id
   │        ↓
   │      consolida projectId nel progetto
   └── sì
        ↓
utente modifica il progetto
        ↓
frontend marca i risultati server come STALE
        ↓
AggiornaCalcolo
        ↓
frontend costruisce TERMODEL-PROJECT-TEXT-V1 corrente
        ↓
filtra le sole risorse locali/frontend
        ↓
POST /api/calculations
        ↓
Service aggiorna SavedProjects/{projectId}/
        ↓
riceve projectId + manifest artifact
        ↓
segue href degli artifact correnti
        ↓
aggiorna viewer e view
```

Il `projectId` resta invariato quando il progetto viene salvato o ricalcolato.

---

## 10. Orchestrazione interna lato server

Pipeline concettuale:

```text
1. ricezione file unico
2. parsing TERMODEL-PROJECT-TEXT-V1
3. lettura e validazione manifest.projectId
4. validazione manifest e sezioni
5. caricamento archivi
6. ricostruzione geometrica/modello
7. produzione model3d
8. produzione progressiva degli altri artifact
9. raccolta diagnostica/log
10. preparazione workspace temporaneo
11. sostituzione atomica di SavedProjects/{projectId}/
12. risposta con projectId + manifest artifact
```

Tutti gli artifact devono derivare dalla stessa elaborazione corrente.

Se un passaggio fallisce, il Service non deve pubblicare output parziali come
nuovo stato valido del progetto.

---

## 11. Workspace persistente per progetto

Il workspace permanente è unico per `projectId`.

```text
SavedProjects/
└── {projectId}/
    ├── project.tmdl
    ├── artifacts/
    └── logs/
```

La variabile operativa `TERMODEL_SAVED_PROJECTS_DIR` può continuare a
configurare la root.

Per aggiornare in sicurezza il progetto è ammesso usare una directory
temporanea durante l'elaborazione, ma al termine deve restare una sola
directory corrente per il `projectId`.

Dopo il successo, il nuovo workspace sostituisce atomicamente il precedente.
Dopo un fallimento, il precedente resta integro.

Non creare automaticamente cartelle storiche per ogni elaborazione.

---

## 12. Durata dei risultati

Il workspace di un progetto è persistente finché non viene esplicitamente
rimosso da una futura politica di gestione progetti.

Un riavvio del WebService non deve rendere indisponibili gli artifact già
persistiti per il `projectId`.

Non è prevista una retention automatica delle singole elaborazioni, perché
ogni nuova elaborazione riuscita sostituisce la precedente.

---

## 13. Diagnostica ed errori

Gli errori HTTP devono essere strutturati e leggibili dal frontend.

| HTTP | Significato |
|---|---|
| 400 | richiesta malformata o feedback non valido |
| 403 | origine non autorizzata per l'invio feedback |
| 404 | projectId o artifact non disponibile |
| 409 | conflitto nella registrazione/allocazione del projectId |
| 415 | Content-Type non supportato |
| 422 | progetto valido come richiesta HTTP ma non elaborabile da Termodel |
| 429 | rate-limit feedback superato |
| 500 | errore interno inatteso |
| 502 | dipendenza GitHub feedback raggiunta ma non utilizzabile |
| 503 | risorsa/dipendenza necessaria non configurata o non disponibile |

Warning e diagnostica dell'ultima elaborazione riuscita devono essere associati
al workspace del `projectId`.

Un errore durante un nuovo calcolo non deve distruggere gli artifact validi
precedenti.

---

## 14. Versionamento

Devono essere distinti almeno:

```text
formato progetto:
TERMODEL-PROJECT-TEXT-V1

contratto frontend/server:
TERMODEL-FRONT-SERVICE-V1

formato eventuale modello 3D:
TermodelWebModel v3
```

Una variazione compatibile può aggiungere campi senza rompere i client.

Una variazione incompatibile richiede una nuova versione esplicita del
contratto o dell'artifact interessato.

Frontend e server non devono dedurre la compatibilità soltanto dalla versione
grafica dell'applicazione Web.

---

## 15. Compatibilità con le API esistenti

La nuova architettura stabilisce come riferimento pubblico:

```http
POST /api/projects/allocate-id
POST /api/calculations
GET  /api/projects/{projectId}/artifacts/model3d
```

e progressivamente gli altri artifact sotto:

```http
GET /api/projects/{projectId}/artifacts/...
```

Le route basate su un identificatore per-elaborazione sono superate dal
contratto corrente e devono essere rimosse durante questa migrazione.

Gli endpoint legacy non correlati a questo cambio, come
`POST /api/model/3d` e `GET /api/model/clean-floor/{floorName}`, restano
compatibili finché non verranno deprecati esplicitamente.

---

## 16. Nuovo progetto

`NuovoProgetto` resta distinto da `AggiornaCalcolo`.

La creazione del contenuto base può continuare tramite:

```http
POST /api/projects/new
```

ma l'identità persistente è gestita tramite:

```http
POST /api/projects/allocate-id
```

Flusso previsto:

```text
crea/apri TERMODEL-PROJECT-TEXT-V1
        ↓
projectId mancante?
        ↓
allocate-id
        ↓
consolida projectId nel manifest
        ↓
POST /api/calculations
        ↓
SavedProjects/{projectId}/ aggiornato
```

`Salva con nome` conserva il projectId. Un eventuale futuro comando
`Duplica come nuovo progetto` dovrà richiederne esplicitamente uno nuovo.

---

## 17. Separazione delle responsabilità

### Frontend

Responsabile di:

- UI/UX;
- editing;
- CAD 2D;
- stato del progetto lato browser;
- costruzione/lettura del file unico;
- richiesta di aggiornamento;
- scelta di quali artifact caricare;
- rendering degli artifact nelle view.

### Termodel.WebService

Responsabile di:

- API HTTP;
- Content-Type;
- CORS;
- validazione di trasporto;
- allocazione e validazione `projectId`;
- persistenza del workspace corrente per progetto;
- esposizione degli artifact;
- mapping errori HTTP.

### Termodel.Core

Responsabile di:

- logica Termodel indipendente dalla UI;
- parsing/validazione funzionale;
- ricostruzione modello;
- calcoli;
- produzione dati/artifact.

### Desktop / Library

Responsabile come riferimento di:

- comportamento storico;
- algoritmi;
- formati;
- risultati da confrontare.

La Library non viene usata come seconda implementazione runtime del server:
serve a trasferire progressivamente la logica condivisibile nel Core.

---

## 18. Concorrenza e isolamento

Ogni `projectId` deve avere il proprio workspace e il proprio aggiornamento
isolato.

Due progetti distinti possono essere elaborati contemporaneamente.

Due elaborazioni concorrenti dello stesso `projectId` devono essere
serializzate o coordinate dal Service in modo deterministico, evitando
scritture parziali o corruzione.

Non devono esistere endpoint basati su variabili globali equivalenti a:

```text
LatestModel
LatestPlan
LatestReport
```

Il concetto corretto è:

```text
SavedProjects/{projectId}/artifacts/...
```

dove il contenuto rappresenta l'ultimo risultato riuscito di quel progetto.

---

## 19. CORS, localhost e sicurezza

Durante lo sviluppo il frontend pubblico può interrogare il server locale,
attualmente con origine autorizzata:

```text
https://www.termodel.it
```

Il Termodel WebService locale opera attualmente tramite HTTP sulla porta
`5080`. La base URL predefinita dell'ambiente di sviluppo è quindi:

```text
http://localhost:5080
```

Tutti i percorsi API descritti in questo documento sono relativi a questa base
URL durante le prove locali. Per esempio, l'endpoint di stato completo è
`http://localhost:5080/health`.

Il browser può richiedere autorizzazione Local Network Access / Private Network
Access.

Il contratto funzionale non deve dipendere dalla porta locale `5080`: la base
URL è configurazione dell'ambiente.

Autenticazione e autorizzazione non sono ancora implementate e saranno aggiunte
prima dell'uso multiutente su server pubblico.

---

## 20. Sequenza di implementazione concordata

### Fase corrente — identità e persistenza per progetto

**Implementata lato Service il 22 settembre 2026** per il progetto tecnico,
`model3d` e i log correnti:

- `POST /api/projects/allocate-id`;
- lettura e validazione di `manifest.projectId` in `POST /api/calculations`;
- workspace `SavedProjects/{projectId}/`;
- persistenza `project.tmdl`;
- persistenza `artifacts/model3d.json`;
- persistenza `logs/calculation.log` e `logs/diagnostics.txt`;
- lettura artifact tramite `projectId`;
- sostituzione transazionale del workspace corrente mediante directory
  staging/backup, con conservazione dell'ultimo stato valido se il calcolo
  fallisce;
- serializzazione delle elaborazioni concorrenti dello stesso projectId nel
  processo Service;
- eliminazione del precedente storage RAM e delle route pubbliche basate su
  identificatore per-elaborazione.

La fase frontend che richiede l'ID una sola volta e lo consolida nel manifest
resta un adeguamento separato.

### Fase successiva — artifact aggiuntivi

Integrare nello stesso workspace:

- piante pulite;
- XML nazionale;
- report dispersioni;
- pannelli;
- spirali SVG;
- esecutivi DXF;
- altri elaborati.

### Fasi successive

- regression test automatici;
- Golden Results;
- autenticazione;
- multiutente;
- eventuale storico versionato dei calcoli solo se richiesto esplicitamente;
- EnergyPlus / gbXML / IDF.

---

## 21. Test del contratto

Ogni funzione aggiunta al contratto deve essere verificata almeno a questi
livelli:

```text
progettata
implementata
compilata
endpoint eseguito
artifact ricevuto
visualizzato dal frontend
confrontato con Desktop/golden quando applicabile
```

Il fatto che un endpoint compili non significa che il risultato sia stato
confrontato con Termodel Desktop.

Gli artifact importanti devono diventare progressivamente parte dei regression
test.

---

## 22. Regola di modifica di questo documento

Questo file è il contratto condiviso.

Quando una modifica riguarda:

- endpoint;
- request/response;
- nomi artifact;
- versioni;
- lifecycle del calcolo;
- formati;
- errori;
- orchestrazione;
- responsabilità frontend/server;

la modifica deve essere registrata qui **prima o insieme all'implementazione**.

Non duplicare il contratto completo nei due Summary.

I Summary devono soltanto indicare:

- stato della rispettiva linea;
- cosa è implementato;
- riferimento a questo documento per il contratto comune.

---

## 23. Decisioni ancora aperte

Da definire durante l'implementazione:

- formato definitivo del manifest artifact;
- politica di cancellazione/archiviazione dei workspace per projectId;
- autenticazione e associazione projectId/utente;
- eventuale endpoint per leggere il manifest degli artifact correnti;
- eventuale comando esplicito di duplicazione progetto con nuovo projectId;
- eventuale storico versionato delle elaborazioni, non attivo di default;
- persistenza multiutente/server pubblico.

Il principio non aperto è già deciso:

> il `projectId` è l'unico riferimento operativo del progetto e ogni nuova
> elaborazione riuscita sostituisce i risultati precedenti di quel progetto.
