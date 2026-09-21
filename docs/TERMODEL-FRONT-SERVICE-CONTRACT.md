# TERMODEL — CONTRATTO FRONTEND ↔ SERVICE

Versione documento: **0.6**  
Aggiornamento: **21 settembre 2026**  
Stato: **architettura concordata; implementazione progressiva**

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
- questo JSON è un risultato derivato dello snapshot: non deve essere usato per
  ricostruire o sostituire il `TERMODEL-PROJECT-TEXT-V1`;
- leggere nuovamente `model3d` per lo stesso `calculationId` non deve
  provocare una nuova elaborazione.

Le fonti implementative correnti del formato sono
`SorgentiTermodel/Work/Web/DrawBimJson.cs`,
`Server/Termodelwebservice/src/Termodel.Core/Model3D/TermodelWebModel.cs` e il
renderer di `docs/termodel-ui-demo/app.js`. Il contratto resta comunque il
riferimento comune fra frontend e server.

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

**Stato implementazione 21 settembre 2026:** il primo ciclo è operativo lato
Service. La chiamata esegue il motore una sola volta, genera un
`calculationId`, serializza il `TermodelWebModel v3` e lo conserva nello
snapshot. In questa prima implementazione il manifest contiene soltanto
l'artifact `model3d`; XML nazionale, dispersioni, pannelli, spirali e piante
pulite nello snapshot restano fasi successive.

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
- `calculationId`, manifest e diagnostica presenti nella risposta POST;
- URL, status HTTP e corpo di `GET .../artifacts/model3d`;
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
- `RENDERING ELABORATO DA TERMODEL SERVICE · calculationId ...` per
  l'artifact `model3d` recuperato dallo snapshot server.

Per il rendering server viene mostrata una forma abbreviata del
`calculationId` e l'identificativo completo resta disponibile nel tooltip.
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
    -> riceve calculationId + manifest
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

## 4. calculationId e snapshot

Ogni chiamata ad `AggiornaCalcolo` genera un identificativo opaco:

```text
calculationId
```

Esempio:

```text
7d2d09e6-...
```

Il `calculationId` identifica uno **snapshot immutabile degli elaborati**
ottenuti da uno specifico file unico.

Questo evita l'uso del concetto pericoloso di:

```text
"ultimo calcolo globale del server"
```

che non funzionerebbe correttamente con:

- due schede browser;
- due progetti;
- due utenti;
- richieste contemporanee.

Regola:

> Ogni richiesta di un artifact deve indicare il `calculationId` a cui
> appartiene.

Il frontend non deve usare il `calculationId` come identificatore permanente
del progetto. È l'identificatore di una **elaborazione**, non del progetto
autorevole.

---

## 5. Risposta di AggiornaCalcolo

La prima versione può essere sincrona: il server risponde quando lo snapshot è
pronto.

Risposta indicativa:

```json
{
  "contractVersion": "TERMODEL-FRONT-SERVICE-V1",
  "calculationId": "7d2d09e6-...",
  "status": "completed",
  "artifacts": [
    {
      "name": "model3d",
      "contentType": "application/json",
      "href": "/api/calculations/7d2d09e6-.../artifacts/model3d"
    },
    {
      "name": "xml-nazionale",
      "contentType": "application/xml",
      "href": "/api/calculations/7d2d09e6-.../artifacts/xml-nazionale"
    }
  ],
  "diagnostics": []
}
```

Stati previsti:

- `completed`: elaborazione conclusa;
- `completed_with_warnings`: artifact prodotti ma con diagnostica;
- `failed`: elaborazione non valida e nessuno snapshot utilizzabile.

Uno stato `processing` potrà essere introdotto in futuro se il calcolo diventerà
asincrono. Non è necessario nella prima versione.

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

Il manifest deve descrivere ciò che è stato prodotto dallo snapshot, non ciò che
il server potrebbe teoricamente produrre.

---

## 7. Lettura degli artifact

Stato implementazione corrente:

```http
GET /api/calculations/{calculationId}/artifacts/model3d
```

Questo endpoint legge il JSON già serializzato nello snapshot in memoria e non
richiama `GeneraModello`. Letture ripetute dello stesso `calculationId`
restituiscono quindi lo stesso artifact finché lo snapshot esiste.

Schema API complessivo previsto nelle fasi successive:

```http
GET /api/calculations/{calculationId}/artifacts/model3d
GET /api/calculations/{calculationId}/artifacts/xml-nazionale
GET /api/calculations/{calculationId}/artifacts/report-dispersioni
GET /api/calculations/{calculationId}/artifacts/pannelli
GET /api/calculations/{calculationId}/artifacts/spirali/{piano}
GET /api/calculations/{calculationId}/artifacts/pianta-pulita/{piano}
```

Nomi e dettagli possono essere affinati durante l'implementazione, ma deve
restare stabile il principio:

> leggere un artifact non deve rieseguire il calcolo.

Quando possibile, il manifest deve fornire direttamente l'`href` corretto,
così il frontend non deve costruire URL sulla base di convenzioni implicite.

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
utente modifica il progetto
        |
        v
frontend aggiorna il proprio stato
        |
        v
il precedente calculationId diventa STALE
        |
        v
utente/comando richiede AggiornaCalcolo
        |
        v
frontend costruisce TERMODEL-PROJECT-TEXT-V1 corrente
        |
        v
filtra le sole risorse locali/frontend (es. sfondi)
        |
        v
POST /api/calculations
        |
        v
riceve calculationId + manifest
        |
        +--> aggiorna viewer 3D
        +--> abilita view dispersioni
        +--> abilita XML nazionale
        +--> abilita pannelli
        +--> abilita spirali
```

Una modifica del progetto dopo il calcolo **non modifica** lo snapshot precedente:
semplicemente lo rende non più rappresentativo dello stato corrente.

Il frontend può continuare a mostrarlo temporaneamente, ma deve sapere che è
`stale` finché non viene eseguito un nuovo `AggiornaCalcolo`.

---

## 10. Orchestrazione interna lato server

La pipeline concettuale è:

```text
1. ricezione file unico
2. parsing TERMODEL-PROJECT-TEXT-V1
3. validazione manifest e sezioni
4. caricamento archivi
5. ricostruzione geometrica/modello
6. produzione degli artifact geometrici
7. produzione XML termico/nazionale
8. calcolo dispersioni
9. calcolo pannelli
10. generazione spirali/esecutivi
11. raccolta diagnostica
12. creazione manifest artifact
13. pubblicazione snapshot tramite calculationId
```

L'ordine interno potrà evolvere in base alle dipendenze reali del Desktop.

Il requisito fondamentale è che tutti gli artifact dello snapshot derivino
dalla **stessa elaborazione del progetto**.

---

## 11. Workspace temporaneo

Nella prima versione è ammesso un workspace temporaneo per ogni
`calculationId`.

**Implementazione iniziale attuale:** per il solo artifact `model3d` lo
snapshot è mantenuto in memoria dal WebService come byte JSON immutabili
indicizzati per `calculationId`. Si perde quindi al riavvio del processo.
Questo è intenzionale per la prima prova e non modifica il contratto HTTP.

Esempio concettuale:

```text
calculations/
└── {calculationId}/
    ├── model/
    │   └── model3d.json
    ├── plans/
    │   └── PianoTerra.svg
    ├── xml/
    │   ├── output.xml
    │   └── output.json
    ├── reports/
    │   ├── dispersioni.json
    │   └── pannelli.json
    └── panels/
        └── PianoTerra.svg
```

Questa scelta facilita il riuso delle classi Desktop storicamente file-based.

Non è un vincolo permanente. In futuro gli artifact potranno essere conservati
in memoria, database, object storage o cache, purché il contratto HTTP non
dipenda dalla posizione fisica dei file.

---

## 12. Durata dello snapshot

Nella prima fase gli snapshot sono temporanei.

Il frontend non deve assumere che un `calculationId` continui a essere valido
dopo:

- riavvio del server;
- pulizia del workspace;
- scadenza futura della cache.

Se uno snapshot non esiste più, il server restituisce `404 Not Found` e il
frontend deve poter eseguire nuovamente `AggiornaCalcolo` usando il file unico
corrente.

Una politica definitiva di retention sarà definita quando verranno affrontati
persistenza, autenticazione e multiutente.

---

## 13. Diagnostica ed errori

Gli errori HTTP devono essere strutturati e leggibili dal frontend.

Indicativamente:

| HTTP | Significato |
|---|---|
| 400 | richiesta malformata |
| 404 | calculationId o artifact non disponibile |
| 415 | Content-Type non supportato |
| 422 | progetto valido come richiesta HTTP ma non elaborabile da Termodel |
| 500 | errore interno inatteso |
| 503 | risorsa o dipendenza necessaria non disponibile |

Per gli errori strutturati usare, dove appropriato, Problem Details.

Il frontend non deve fare fallback silenziosi che nascondano errori di
compatibilità o di calcolo.

Warning e diagnostica non bloccante devono essere associati allo snapshot e
restituiti nel manifest.

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

Attualmente esistono già:

```text
GET  /
GET  /health
GET  /api/model/capabilities
GET  /api/model/clean-floor/{floorName}
POST /api/projects/new
POST /api/model/3d
```

Durante l'introduzione del nuovo workflow non devono essere rimossi
immediatamente:

```text
POST /api/model/3d
GET  /api/model/clean-floor/{floorName}
```

Il nuovo flusso `/api/calculations` deve essere introdotto in modo additivo.

Gli endpoint precedenti potranno essere deprecati soltanto dopo che il frontend
avrà adottato e collaudato il nuovo contratto.

---

## 16. Nuovo progetto

`NuovoProgetto` resta concettualmente distinto da `AggiornaCalcolo`.

```text
POST /api/projects/new
        |
        v
crea TERMODEL-PROJECT-TEXT-V1
```

Successivamente:

```text
TERMODEL-PROJECT-TEXT-V1
        |
        v
POST /api/calculations
        |
        v
artifact derivati
```

Quindi:

- `NuovoProgetto` crea uno stato di progetto;
- `AggiornaCalcolo` elabora uno stato di progetto;
- le API artifact leggono i risultati dell'elaborazione.

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
- creazione e gestione `calculationId`;
- esposizione degli artifact;
- mapping errori HTTP;
- gestione lifecycle dello snapshot.

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

Ogni `calculationId` deve avere il proprio stato.

Non devono esistere nuovi endpoint basati su variabili statiche equivalenti a:

```text
LatestModel
LatestPlan
LatestReport
```

come contratto pubblico definitivo.

Durante la migrazione possono esistere internamente componenti legacy con stato
globale, ma il WebService deve serializzarne/proteggerne l'uso e catturarne gli
output nello snapshot corretto.

L'obiettivo è eliminare progressivamente queste dipendenze.

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

### Fase 1 — snapshot base

Implementare:

- `POST /api/calculations`;
- `calculationId`;
- manifest artifact;
- storage temporaneo;
- modello 3D;
- piante pulite;
- lettura degli artifact;
- mantenimento degli endpoint legacy.

### Fase 2 — termico

Integrare:

- XML nazionale;
- report dispersioni;
- diagnostica relativa.

### Fase 3 — pannelli radianti

Integrare:

- calcolo pannelli;
- report pannelli;
- spirali SVG;
- eventuali esecutivi DXF.

### Fasi successive

- regression test automatici;
- Golden Results;
- persistenza;
- autenticazione;
- multiutente;
- EnergyPlus / gbXML / IDF;
- gestione asincrona se realmente necessaria.

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
- nomi definitivi degli endpoint;
- retention degli snapshot;
- eventuale endpoint per leggere solo il manifest;
- eventuale cancellazione esplicita di uno snapshot;
- strategia futura asincrona;
- autenticazione e associazione snapshot/utente;
- persistenza server;
- eventuale export esplicito di un progetto con risultati incorporati.

Queste questioni non devono bloccare la Fase 1 se possono essere aggiunte in
modo retrocompatibile.
