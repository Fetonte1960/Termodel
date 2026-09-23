# TERMODEL SERVICE — PROCEDURA SNAPSHOT DIAGNOSTICO AI

Aggiornamento: 23 settembre 2026

## Scopo

Questa procedura è una parte **fondamentale e permanente** del flusso di
sviluppo TermodelService.

Serve a trasferire in modo persistente su GitHub gli elaborati realmente
prodotti dal Service su Render, così che una chat AI successiva possa
esaminare gli stessi file senza chiedere all'utente copie manuali di SVG,
DXF, JSON, report o log.

Il meccanismo non sostituisce il repository sorgente su `main`: usa il
branch separato:

```text
service-snapshots
```

## Flusso operativo utente

Quando l'utente vuole far analizzare alla chat una sessione reale:

```text
1. Aggiorna Modello
2. Pubblica snapshot
3. Scrivi alla chat: "esamina l'ultimo snapshot"
```

### 1. Aggiorna Modello

Il frontend invia il progetto al Service con `POST /api/calculations`.
L'elaborazione valida crea/aggiorna nel workspace Render:

```text
SavedProjects/{projectId}/
  artifacts/**
  logs/**
```

Lo snapshot **non viene pubblicato automaticamente** a ogni calcolo.

### 2. Pubblica snapshot

Endpoint:

```http
POST /api/projects/{projectId}/publish-session-snapshot
X-Termodel-Snapshot-Key: <TERMODEL_SNAPSHOT_ADMIN_KEY>
```

Fino a quando non esisterà un comando locale/pulsante sicuro dedicato,
l'utente può usare PowerShell:

```powershell
$projectId = "PROJECT-ID"
$key = "LA-CHIAVE-CONFIGURATA-SU-RENDER"

Invoke-RestMethod -Uri "https://termodel.onrender.com/api/projects/$projectId/publish-session-snapshot" -Method Post -Headers @{ "X-Termodel-Snapshot-Key" = $key }
```

La chiave amministrativa e il token GitHub **non devono essere incollati in
chat, salvati nel frontend o versionati nel repository**.

Una risposta corretta contiene almeno:

```text
status      : published
snapshotId  : ...
repository  : Fetonte1960/Termodel
branch      : service-snapshots
commitSha   : ...
treeUrl     : ...
```

### 3. Richiesta alla chat

L'utente può limitarsi a scrivere:

```text
esamina l'ultimo snapshot
```

Non deve:
- cercare i singoli file;
- scaricare SVG/DXF/JSON/log;
- comunicare lo snapshotId;
- copiare manualmente i risultati;
- fornire token o secret.

## Procedura obbligatoria per una nuova chat AI

Quando l'utente chiede di analizzare l'ultima esecuzione reale del Service,
la chat deve:

1. accedere a `Fetonte1960/Termodel`;
2. leggere questo documento e il
   `Server/Termodelwebservice/PROJECT-SUMMARY-SERVICE.md`;
3. leggere dal branch `service-snapshots`:
   ```text
   service-snapshots/LATEST.json
   ```
4. ricavare da `rootPath` la cartella dell'ultimo snapshot;
5. leggere:
   ```text
   <rootPath>/manifest.json
   ```
6. usare il manifest per conoscere esattamente i file realmente pubblicati;
7. leggere gli artifact/log necessari direttamente dal branch
   `service-snapshots`;
8. distinguere sempre:
   - ciò che risulta dal file reale;
   - ciò che è una deduzione;
   - ciò che resta da provare sul PC/Visual Studio/browser dell'utente.

La chat **non deve chiedere all'utente di ricopiare file** già presenti nello
snapshot, salvo che GitHub non sia raggiungibile o lo snapshot richiesto non
li contenga.

## Struttura GitHub

Ogni pubblicazione crea un commit atomico sul branch
`service-snapshots`.

Struttura:

```text
service-snapshots/LATEST.json
service-snapshots/<snapshotId>/
  manifest.json
  artifacts/
    ...
  logs/
    ...
```

`LATEST.json` usa:

```text
TERMODEL-SERVICE-SNAPSHOT-LATEST-V1
```

e punta allo snapshot più recente.

`manifest.json` usa:

```text
TERMODEL-SERVICE-SNAPSHOT-V1
```

e contiene almeno:
- projectId;
- timestamp UTC;
- commit Service quando disponibile;
- stato stale;
- elenco file;
- content type;
- dimensione;
- SHA-256.

## File pubblicabili

Il publisher può trasferire esclusivamente:

```text
artifacts/**
logs/**
```

Non pubblica:
- `project.tmdl`;
- secret;
- configurazioni server;
- file arbitrari del container.

Limiti correnti:
- 20 MiB per singolo file;
- 50 MiB complessivi per snapshot.

## Persistenza e pulizia

Il filesystem Render Free è effimero: workspace e file locali possono
scomparire dopo redeploy/riavvio.

Gli snapshot GitHub sono invece **persistenti**.

Stato corrente della retention:

```text
pulizia automatica snapshot: NO
LATEST.json: punta solo all'ultimo snapshot
snapshot precedenti: conservati
```

Non cancellare automaticamente snapshot storici finché non viene approvata
una policy di retention. Una futura policy potrà, per esempio, conservare gli
ultimi N snapshot e quelli marcati come importanti.

## Configurazione Render

Secret necessari:

```text
TERMODEL_SNAPSHOT_GITHUB_TOKEN
TERMODEL_SNAPSHOT_ADMIN_KEY
```

Default già incorporati:

```text
TERMODEL_SNAPSHOT_REPOSITORY=Fetonte1960/Termodel
TERMODEL_SNAPSHOT_BRANCH=service-snapshots
TERMODEL_SNAPSHOT_BASE_BRANCH=main
TERMODEL_SNAPSHOT_GITHUB_API_BASE_URL=https://api.github.com
TERMODEL_SNAPSHOT_ROOT=service-snapshots
```

Il token GitHub deve essere fine-grained, limitato al repository Termodel,
con:

```text
Contents: Read and write
Metadata: Read-only (obbligatorio GitHub)
```

Il token snapshot deve restare separato dal token usato dal servizio feedback
GitHub Issues.

## Verifica reale eseguita

Il collegamento reale:

```text
Render -> GitHub service-snapshots -> lettura AI
```

è stato provato il 23 settembre 2026 con il progetto:

```text
b38f622b-6411-48ea-ba57-0b07862f4046
```

Snapshot pubblicato:

```text
20260923T162958425Z_b38f622b
```

Lo snapshot reale è stato poi letto dalla chat tramite
`service-snapshots/LATEST.json` e relativo `manifest.json`.

La prova ha confermato che il meccanismo permette di diagnosticare anche
l'assenza di un risultato: in quel caso `pannelli.json` riportava
`circuitCount=0` e l'assenza di un Tubo CAD associato alla rete, quindi non
erano presenti gli artifact esecutivi SVG/DXF.

## Regola sintetica da ricordare

```text
UTENTE:
Aggiorna Modello -> Pubblica snapshot -> "esamina l'ultimo snapshot"

CHAT:
service-snapshots/LATEST.json -> manifest.json -> artifact/log reali
```
