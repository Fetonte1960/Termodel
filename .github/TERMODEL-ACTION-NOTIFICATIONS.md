# TERMODEL — STATO GITHUB ACTIONS E NOTIFICHE TELEFONO

Classificazione: **IMPORTANTE — REGOLA PERMANENTE DI PROGETTO**  
Introduzione: **24 settembre 2026**  
Stato: **IMPLEMENTATO E VERIFICATO END-TO-END**

Questa specifica è il riferimento canonico per lo stato degli incarichi eseguiti
con GitHub Actions e per la notifica push sul telefono al termine del lavoro.

## Regola obbligatoria

Per ogni GitHub Action usata come incarico operativo, debug avanzato, build/test
significativo o altra elaborazione la cui conclusione interessa l'utente:

1. all'avvio pubblicare lo stato logico **RUNNING**;
2. a conclusione pubblicare **SUCCESS** oppure **FAILED**;
3. negli stati terminali inviare **una notifica push al telefono**;
4. non usare polling periodico: è la Action stessa a produrre stato e notifica;
5. lo step finale deve usare `always()`, così viene eseguito anche dopo un
   fallimento del lavoro precedente.

## Stato GitHub canonico

Usare un **Commit Status nativo GitHub**:

```text
context: Termodel/job

RUNNING -> state: pending
SUCCESS -> state: success
FAILED  -> state: failure
```

Il `target_url` deve puntare alla GitHub Action che esegue l'incarico.
RUNNING non deve generare push sul telefono: il push è riservato a
SUCCESS/FAILED.

## Notifica push e sicurezza

Il canale attuale usa **ntfy**. Il topic è conservato esclusivamente nel
repository secret:

```text
TERMODEL_NTFY_TOPIC
```

Regole obbligatorie:

- non scrivere mai il valore del topic nei documenti del repository;
- non stampare mai il valore del secret nei log;
- non trasformarlo in una repository variable in chiaro;
- non includerlo in commit, artifact o snapshot diagnostici;
- se i secrets non sono disponibili (per esempio alcuni contesti PR), saltare
  la notifica senza esporre o simulare il secret.

La notifica terminale deve contenere almeno workflow/incarico, numero run,
SUCCESS/FAILED, commit e collegamento alla Action. Priorità consigliata:
`high` per SUCCESS, `urgent` per FAILED.

## Errori e retry

La notifica non deve falsificare il risultato tecnico: un errore ntfy va
registrato chiaramente, ma non deve trasformare un lavoro riuscito in FAILED.

Ogni retry è un nuovo tentativo operativo:

```text
RUNNING -> SUCCESS/FAILED -> una notifica terminale
```

Non inviare notifiche duplicate per lo stesso tentativo.

## Implementazione di riferimento

```text
.github/workflows/termodel-service-build.yml
```

Il workflow usa `statuses: write`, Commit Status `Termodel/job`, step
iniziale RUNNING, step finale `always()`, secret `TERMODEL_NTFY_TOPIC` e
push ntfy solo allo stato terminale.

Ogni nuovo workflow che svolge un incarico per l'utente deve riutilizzare
questa procedura o richiamarla esplicitamente. Non creare protocolli paralleli
senza aggiornare prima questa specifica.

## Verifica reale

Verifica end-to-end del **24 settembre 2026** su
`TermodelService Build`, run **35958607012**, job **107509968862**:

```text
TERMODEL_JOB_STATUS=RUNNING
...
TERMODEL_JOB_STATUS=SUCCESS
PHONE_NOTIFICATION_SENT status=SUCCESS
```

La notifica è stata ricevuta sul telefono Android configurato dall'utente.
Il sistema è quindi **operativo**, non sperimentale.


## Resilienza della chat

Per gli incarichi lunghi questa specifica va usata insieme a
`.github/TERMODEL-CHAT-ANTI-TIMEOUT.md`.

La notifica terminale e il Commit Status sono parte del checkpoint persistente:
un timeout o una sospensione della pagina ChatGPT non cambia l'esito tecnico
dell'Action e non deve obbligare a rifare il lavoro già registrato su GitHub.
