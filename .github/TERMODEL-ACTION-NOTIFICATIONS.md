# TERMODEL — STATO GITHUB ACTIONS E NOTIFICHE TELEFONO

Classificazione: **IMPORTANTE — REGOLA PERMANENTE DI PROGETTO**  
Introduzione: **24 settembre 2026**  
Aggiornamento operativo: **29 settembre 2026**  
Stato: **NOTIFICHE BUILD SOSPESE — RESTA SOLO ISSUE #1**

Questa specifica è il riferimento canonico per lo stato degli incarichi eseguiti
con GitHub Actions e per la notifica push sul telefono.

## Regola corrente

Le GitHub Actions possono continuare a pubblicare lo stato tecnico tramite
Commit Status GitHub, ma **non devono più inviare notifiche ntfy per build,
test, deploy, harness, retry o verifiche automatiche**.

L'unica notifica telefonica Termodel autorizzata è la chiusura della
**GitHub Issue #1**, che rappresenta la fine reale dell'incarico.

Quindi:

1. gli workflow tecnici possono pubblicare `RUNNING`, `SUCCESS` o `FAILED`
   come Commit Status;
2. nessuno workflow tecnico/build deve usare `TERMODEL_NTFY_TOPIC`;
3. nessuno workflow tecnico/build deve chiamare `https://ntfy.sh/`;
4. la Issue #1 viene aggiornata durante il lavoro e chiusa a fine incarico;
5. la chiusura della Issue #1 genera l'unica notifica telefonica;
6. `completed` significa incarico concluso con successo;
7. `not_planned` significa incarico terminato senza successo.

## Stato GitHub canonico

È consentito e raccomandato continuare a usare il Commit Status nativo GitHub:

```text
context: Termodel/job

RUNNING -> state: pending
SUCCESS -> state: success
FAILED  -> state: failure
```

Il Commit Status è solo stato tecnico su GitHub e **non deve produrre push sul
telefono**.

## Unica notifica telefonica

Il solo workflow autorizzato a usare ntfy è:

```text
.github/workflows/issue-work-notify.yml
```

Il workflow deve eseguire la notifica **solo quando viene chiusa la Issue #1**.
La condizione esplicita è:

```yaml
if: ${{ github.event.issue.number == 1 }}
```

Il topic resta nel repository secret:

```text
TERMODEL_NTFY_TOPIC
```

Regole di sicurezza:
- non scrivere mai il valore del topic nei documenti del repository;
- non stamparlo nei log;
- non trasformarlo in repository variable in chiaro;
- non includerlo in commit, artifact o snapshot diagnostici.

La notifica Issue #1 mantiene priorità ntfy `urgent`:
- `completed` -> “Incarico completato con successo”;
- qualsiasi altra chiusura prevista dal protocollo, in particolare
  `not_planned` -> “Incarico completato con insuccesso”.

## Workflow tecnici

Dal 29/09/2026 le notifiche ntfy sono sospese nei workflow:
- `termodel-service-build.yml`;
- `termodel-radiant-harness.yml`;
- `termodel-render-verify.yml`;
- `termodel-diego-vittorio-public-square.yml`;
- `termodel-diego-vittorio-fast.yml`;
- `termodel-diego-vittorio-room-extraction.yml`.

Questi workflow possono continuare ad aggiornare `Termodel/job` e a produrre
artifact/log, ma non devono notificare il telefono.

Ogni nuovo workflow deve rispettare la stessa regola: **nessuna notifica ntfy
di build** salvo nuova decisione esplicita dell'utente e aggiornamento di
questo documento.

## Fine incarico

A fine job l'assistente deve:
1. aggiornare Issue #1 con l'esito;
2. chiuderla `completed` se il lavoro è riuscito;
3. chiuderla `not_planned` se il lavoro è fallito.

La chiusura di Issue #1 è quindi l'unico evento che deve produrre la notifica
ntfy sul telefono.

## Resilienza della chat

Per incarichi lunghi questa specifica va usata insieme a
`.github/TERMODEL-CHAT-ANTI-TIMEOUT.md`.

I Commit Status e i checkpoint su GitHub restano persistenti anche se la chat
si sospende; la notifica telefonica resta riservata esclusivamente alla
chiusura della Issue #1.
