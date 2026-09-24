# Termodel WebService

> **IMPORTANTE — GitHub Actions**
>
> Gli incarichi eseguiti tramite GitHub Actions devono seguire
> `.github/TERMODEL-ACTION-NOTIFICATIONS.md`: `RUNNING -> SUCCESS/FAILED`
> nel Commit Status `Termodel/job` e notifica push telefono allo stato
> terminale.

Soluzione sperimentale e autonoma per estrarre progressivamente il motore Termodel in un Core C# utilizzabile da ASP.NET Core.

## Progetti

- `Termodel.Core`: libreria `.NET 8` senza WPF, form o visualizzazione 3D.
- `Termodel.WebService`: Web API ASP.NET Core che espone il Core.

## Funzioni disponibili

```text
GET  /
GET  /health
GET  /api/model/capabilities
GET  /api/projects
POST /api/projects/new
POST /api/projects/allocate-id
POST /api/projects/{projectId}/open
PUT  /api/projects/{projectId}/save
PUT  /api/projects/{projectId}/save-as
POST /api/projects/{projectId}/heartbeat
POST /api/projects/{projectId}/close
POST /api/projects/{projectId}/unlock
POST /api/calculations
GET  /api/projects/{projectId}/artifacts/model3d
GET  /api/projects/{projectId}/artifacts/pannelli
GET  /api/projects/{projectId}/artifacts/pannelli-esecutivo-svg
GET  /api/projects/{projectId}/artifacts/pannelli-esecutivo-dxf
GET  /api/projects/{projectId}/generated-files
GET  /api/projects/{projectId}/generated-files/{relativePath}
POST /api/projects/{projectId}/publish-session-snapshot
GET  /api/projects/{projectId}/logs/termodel
POST /api/model/3d
POST /api/dxf/to-svg
POST /api/feedback
```

`POST /api/model/3d` riceve nel body il file unico completo
`TERMODEL-PROJECT-TEXT-V1` con `Content-Type: text/plain; charset=utf-8` e
restituisce direttamente `TermodelWebModel` versione 3 in JSON. La generazione
legge lo SVG multipiano e gli archivi XML incorporati, è serializzata per
isolare lo stato storico del motore e non produce IFC. Un formato non valido o
una funzione CAD non supportata restituisce `422`; un Content-Type diverso da
`text/plain` restituisce `415`.

`POST /api/projects/new` genera il contenitore testuale UTF-8 `TERMODEL-PROJECT-TEXT-V1`. Il progetto iniziale viene clonato da `src/Termodel.WebService/Templates/ProgettoBase`, snapshot consolidato del progetto realmente proposto da Termodel desktop. La copia di distribuzione `Definitions/definizionedati.json` rimane il riferimento per controllo e validazione dello schema; non viene più usata per fabbricare archivi vuoti.

La copia inclusa rende la soluzione compilabile senza una cartella Termodel gemella. Non deve essere modificata autonomamente: ogni aggiornamento deve partire dall'originale autorevole, essere autorizzato espressamente e concludersi con il confronto delle impronte SHA-256.

Richiesta minima:

```json
{
  "nomeProgetto": "Prova",
  "piani": [
    {
      "id": "F001",
      "nome": "Piano terra",
      "tipo": "Calpestabile",
      "nomeFile": "DisegnoInput",
      "layerCad": "Piano terra",
      "altezzaNetta": 3.0,
      "altezzaLorda": 3.3,
      "pianiUguali": 1,
      "svg": "<svg xmlns=\"http://www.w3.org/2000/svg\"><g id=\"calpestabile\"><line x1=\"0\" y1=\"0\" x2=\"400\" y2=\"0\" /></g></svg>"
    }
  ]
}
```

Se `piani` è omesso viene creato il piano calpestabile predefinito. Gli altri archivi sono clonati dal progetto base incorporato; eventuali archivi forniti nella richiesta sostituiscono quelli omonimi dopo validazione. Il contenitore comprende anche `project/DisegnoInput.dxf`, `thermal/input.xml` e `thermal/input.json`.

## Conversione DXF → SVG lato server

La conversione dei DXF usati come sfondo del CAD Web non viene più eseguita
dal JavaScript del browser. Il frontend mantiene soltanto l'analisi leggera
necessaria al dialog di importazione e invia DXF originale + opzioni a:

```http
POST /api/dxf/to-svg
Content-Type: application/json
```

Esempio:

```json
{
  "dxfText": "0\nSECTION\n...",
  "layers": ["MURI"],
  "unit": "mm",
  "curves": true,
  "convertText": false,
  "explodeBlocks": false
}
```

L'algoritmo headless è in
`src/Termodel.Core/Cad/DxfSvgConverter.cs`; il WebService espone soltanto
l'adattatore HTTP. Sono gestiti LINE, LWPOLYLINE/POLYLINE e, su opzione,
ARC/CIRCLE/ELLIPSE/SPLINE, TEXT/MTEXT e INSERT. L'output è uno SVG
normalizzato in centimetri Termodel con statistiche, bounding box, viewBox e
informazioni sull'unità di origine. Un DXF non convertibile restituisce HTTP
`422`.

## Artifact pannelli radianti

`POST /api/calculations` produce anche il primo risultato idraulico dei
pannelli radianti quando il progetto contiene gli archivi estesi
`Reti` e `TipologiePannelli`.

Il risultato viene persistito in:

```text
SavedProjects/{projectId}/artifacts/pannelli.json
```

e si legge senza nuovo calcolo con:

```http
GET /api/projects/{projectId}/artifacts/pannelli
```

Formato corrente: `TermodelRadiantPanels v1`. Il primo kernel supporta
acqua, Darcy-Weisbach, fattore laminare `64/Re`, Colebrook in turbolento,
transizione diagnosticata, limiti lunghezza/perdita e validazione del passo
contro la tipologia pannello. I segmenti CAD `Tubo` sono associati alla rete
tramite `data-termodel-rete`.

Questa prima versione usa la centerline Tubo manuale come lunghezza idraulica
e una portata preliminare derivata dalla resa/temperature. Collettore,
perdite concentrate e generazione grafica parametrica delle spirali restano
fuori da questo artifact finché il motore condiviso delle spirali non avrà un
ingresso headless governato da `Reti.PassoSelezionatoMm`.

## Esecutivo pannelli SVG/DXF

Con il default pannelli corrente a passo 300 mm, `POST /api/calculations`
può produrre anche:

```text
SavedProjects/{projectId}/artifacts/pannelli-esecutivo.svg
SavedProjects/{projectId}/artifacts/pannelli-esecutivo.dxf
```

lettura senza nuovo calcolo:

```http
GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-svg
GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-dxf
```

DXF e SVG derivano dallo **stesso modello grafico esecutivo** del Core. Il
motore geometrico è il `SpiraliGPT` Desktop corrente, usato con il default
storico `PassoTubi=0,30 m`. Il grafo/collettore resta fuori scope e viene
rimandato a Tubi universale.

## Canale universale file generati

Per evitare un endpoint dedicato per ogni futuro elaborato, il Service espone:

```http
GET /api/projects/{projectId}/generated-files
GET /api/projects/{projectId}/generated-files/{relativePath}
```

Il primo endpoint restituisce il catalogo `TERMODEL-GENERATED-FILES-V1`
con nome, path logico, categoria, content type, dimensione, stale e `href`.
Il secondo restituisce il contenuto.

Il perimetro è volutamente read-only e limitato a:

```text
artifacts/**
logs/**
```

`project.tmdl` e altri file del workspace non sono pubblicabili tramite
questo canale. Il path viene normalizzato e controllato contro traversal.
Gli endpoint specifici `artifacts/*` e `logs/termodel` restano disponibili
per retrocompatibilità.

Il canale è destinato ai futuri disegni, report, CSV, PDF, SVG/DXF, JSON e
log prodotti dai calcoli.

## Procedura fondamentale per la diagnostica AI

Quando una chat deve controllare una sessione realmente eseguita dal Service,
il flusso operativo standard è:

```text
UTENTE:
Aggiorna Modello
→ Pubblica snapshot
→ scrive: "esamina l'ultimo snapshot"

CHAT:
branch service-snapshots
→ service-snapshots/LATEST.json
→ manifest.json
→ artifact/log reali
```

La pubblicazione non è automatica ad ogni calcolo. L'utente la richiede solo
quando serve conservare e far analizzare una sessione.

Documento operativo autorevole:

```text
Server/Termodelwebservice/docs/SERVICE-SNAPSHOT-DIAGNOSTIC.md
```

Una nuova chat deve leggere quel documento prima di chiedere copie manuali di
file già presenti nello snapshot.

## Snapshot diagnostico verso GitHub

Il Service può pubblicare **su richiesta esplicita** i file generati
dell'ultima elaborazione valida del progetto su un branch GitHub dedicato.

Endpoint amministrativo:

```http
POST /api/projects/{projectId}/publish-session-snapshot
X-Termodel-Snapshot-Key: <chiave amministrativa>
```

La pubblicazione usa esclusivamente i file già visibili attraverso il
catalogo `generated-files`:

```text
artifacts/**
logs/**
```

`project.tmdl` non viene pubblicato. Ogni snapshot viene scritto con un solo
commit atomico sotto:

```text
service-snapshots/LATEST.json
service-snapshots/<snapshotId>/
  manifest.json
  artifacts/...
  logs/...
```

`LATEST.json` usa il formato
`TERMODEL-SERVICE-SNAPSHOT-LATEST-V1` e punta sempre allo snapshot più
recente. Questo permette a una chat successiva di trovare l'ultima sessione
senza conoscere in anticipo lo `snapshotId`.

Il manifest usa il formato `TERMODEL-SERVICE-SNAPSHOT-V1` e contiene
projectId, timestamp UTC, eventuale commit del Service, stale, content type,
dimensione e SHA-256 di ogni file.

Configurazione server:

```text
TERMODEL_SNAPSHOT_GITHUB_TOKEN=<fine-grained PAT con Contents: read/write>
TERMODEL_SNAPSHOT_ADMIN_KEY=<secret amministrativo lungo e casuale>
TERMODEL_SNAPSHOT_REPOSITORY=Fetonte1960/Termodel
TERMODEL_SNAPSHOT_BRANCH=service-snapshots
TERMODEL_SNAPSHOT_BASE_BRANCH=main
TERMODEL_SNAPSHOT_GITHUB_API_BASE_URL=https://api.github.com
TERMODEL_SNAPSHOT_ROOT=service-snapshots
```

Le ultime cinque variabili hanno già i valori predefiniti mostrati; in Render
sono quindi indispensabili soltanto `TERMODEL_SNAPSHOT_GITHUB_TOKEN` e
`TERMODEL_SNAPSHOT_ADMIN_KEY`.

Il token snapshot è volutamente separato dal token feedback: il token feedback
può avere permessi Issues, mentre questo richiede accesso `Contents: write`.
Non memorizzare né token né chiave amministrativa nel repository o nel
frontend e non incollarli nelle chat.

### Persistenza e retention snapshot

Il filesystem Render Free è effimero, mentre gli snapshot GitHub sono
persistenti.

Stato corrente:

```text
pubblicazione automatica ad ogni calcolo: NO
pulizia automatica snapshot GitHub:       NO
LATEST.json:                              punta solo all'ultimo
snapshot precedenti:                      conservati
```

Non introdurre cancellazione automatica senza una decisione esplicita sulla
retention.

### Verifica reale

Il 23 settembre 2026 è stata eseguita con successo una pubblicazione reale:

```text
Render
→ POST publish-session-snapshot
→ branch GitHub service-snapshots
→ LATEST.json
→ manifest.json
→ lettura degli artifact/log da parte della chat
```

Il progetto usato nella prima prova reale era
`b38f622b-6411-48ea-ba57-0b07862f4046`.

## TermodelLog del progetto

Dopo un `POST /api/calculations` riuscito il Service conserva il log
applicativo prodotto dal `TermodelLog` del Core in:

```text
SavedProjects/{projectId}/logs/TermodelLog.md
```

Lo stesso contenuto resta duplicato in `logs/diagnostics.txt` per
retrocompatibilità; `logs/calculation.log` contiene invece soltanto metadati
tecnici del calcolo.

Il log corrente si legge senza rilanciare il motore:

```http
GET /api/projects/{projectId}/logs/termodel
```

La risposta usa `text/markdown; charset=utf-8`, nome logico
`TermodelLog.md` e l'header `X-Termodel-Artifact-Stale`, coerente con lo
stato del progetto. Se il progetto è stato salvato dopo l'ultimo calcolo il log
resta quello dell'ultima elaborazione valida ed è marcato stale.

Nel Core headless l'inizio di ogni elaborazione chiama
`TermodelLog.InitializeLog(...)`, equivalente al reset per-request. Il
riferimento Desktop autorevole è ora disponibile in
`SorgentiTermodel/Library/utilities/TermodelLog.cs`; le sue categorie sono
`Sempre`, `colmi`, `spezza`, `Error`, `Svg`, `RedrawHelix`,
`GeneraModello`, `Performance` e `PontiAutomatici`.

`POST /api/calculations` accetta opzioni di log per la singola elaborazione:

```http
POST /api/calculations?logCategories=colmi,spezza
POST /api/calculations?logCategories=all
POST /api/calculations?logEnabled=false
```

Se i parametri sono omessi resta il comportamento Service precedente:
`WriteLog`, `LogOperation` e `LogError` vengono raccolti, mentre i blocchi
condizionati da `IsEnabled(...)` restano spenti. Se `logCategories` è
presente, il filtro vale sia per le scritture dirette sia per
`IsEnabled(...)`; `LogOperation` usa `Sempre` e `LogError` usa
`Error`. Sono accettati i nomi categoria senza distinzione maiuscole/minuscole
e gli alias `all` e `none`. Una categoria sconosciuta restituisce HTTP 400
e non avvia il calcolo.

La risposta del calcolo include inoltre:

```json
{
  "logging": {
    "enabled": true,
    "mode": "filtered",
    "categories": ["colmi", "spezza"]
  }
}
```

La configurazione effettiva viene registrata anche in
`logs/calculation.log`. Le opzioni non vengono salvate nel
`TERMODEL-PROJECT-TEXT-V1`: sono parametri temporanei di esecuzione.

## Suggerimenti utenti → GitHub Issues

Il WebService espone:

```http
POST /api/feedback
Content-Type: application/json
Origin: https://www.termodel.it
```

Esempio:

```json
{
  "message": "Vorrei poter confrontare due varianti del progetto.",
  "category": "suggestion",
  "title": "Confronto varianti",
  "page": "/termodel-ui-demo/",
  "appVersion": "0.98"
}
```

Il Service crea una Issue nel repository GitHub configurato. Il token GitHub
non deve mai essere inserito nel frontend o versionato nel repository.

Configurazione:

```text
TERMODEL_FEEDBACK_GITHUB_TOKEN=<secret fine-grained PAT>
TERMODEL_FEEDBACK_REPOSITORY=Fetonte1960/Termodel
TERMODEL_FEEDBACK_ALLOWED_ORIGIN=https://www.termodel.it
TERMODEL_FEEDBACK_GITHUB_API_BASE_URL=https://api.github.com
```

Per il token usare il permesso minimo **Issues: Read and write** limitato al
solo repository Termodel. Su Render il token va configurato come secret
environment variable.

L'endpoint:
- non esegue `git push` e non crea commit automatici;
- non richiede un clone Git nel container;
- non allega automaticamente progetto, projectId, email o IP alla Issue;
- elimina query string e fragment dal campo `page`;
- applica validazione e rate-limit in memoria;
- rifiuta origini diverse da quella configurata;
- restituisce `503` se il token/configurazione non è disponibile.

## Regole iniziali

- Termodel desktop resta il riferimento funzionale e algoritmico.
- `definizionedati/definizionedati.json` non deve essere modificato senza autorizzazione specifica.
- Le migrazioni saranno selettive e progressive.
- Non introdurre WPF, HelixToolkit o form nel Core.
- Registrare origine e adattamenti di ogni sorgente importato.
- Confrontare gli output del Core con quelli del desktop prima di considerare una fase verificata.

La soluzione è stata compilata su copia temporanea il 21 settembre 2026 con
0 errori. Il contratto HTTP di `POST /api/model/3d` è stato provato con
`ProgettoVuoto`; il confronto golden del progetto mansardato avanzato rimane da
eseguire dopo la produzione del relativo file unico SVG.

Aprire `Termodel.WebService.sln` con Visual Studio 2022.

## Collegamento dal frontend pubblico

Il WebService autorizza tramite CORS l'origine `https://www.termodel.it` per `GET`, `POST` e `OPTIONS`, inclusi gli header richiesti dal preflight. Per compatibilità con richieste Chrome Private Network Access, un preflight autorizzato che invia `Access-Control-Request-Private-Network: true` riceve `Access-Control-Allow-Private-Network: true`.

Chrome applica inoltre il permesso Local Network Access alle chiamate da un sito pubblico verso `localhost`; l'utente deve concedere tale permesso al sito. La configurazione server non può superare un rifiuto espresso nel browser.
