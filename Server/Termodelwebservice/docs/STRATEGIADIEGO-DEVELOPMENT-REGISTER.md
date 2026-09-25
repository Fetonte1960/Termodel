# STRATEGIADIEGO — REGISTRO DI SVILUPPO

Data avvio: **25/09/2026**  
Stato generale: **IN CORSO**

Scopo: registrare fasi indipendenti e recuperabili dell'implementazione,
attivazione e benchmark della StrategiaDiego.

## F0 — Registrazione incarico e registro di sviluppo
Stato: **ESEGUITO**

Risultato:
- incarico registrato in `PROJECT-SUMMARY-SERVICE.md`;
- definite le fasi F0..F6;
- questo registro diventa checkpoint operativo per il recupero da crash/chat interrotta.

Commit incarico:
- `885f375cb92dee96e8764af051b9d798159cc6f3`

## F1 — Audit finale Vittorio/GPT e specifica code-ready
Stato: **COMMISSIONATO**

Obiettivo:
- confrontare i sorgenti paralleli Vittorio/GPT rilevanti per generazione,
  offset, raccordi, ingresso e chiusura;
- fissare ciò che StrategiaDiego riusa come principio e ciò che deve differire.

## F2 — Implementazione e dispatcher Vittorio|GPT|Diego
Stato: **COMMISSIONATO**

Obiettivo:
- aggiungere Diego nel Core;
- preservare GPT e Vittorio come motori distinti;
- selezione esplicita senza cambio silenzioso del default.

## F3 — Build reale
Stato: **COMMISSIONATO**

Obiettivo:
- compilazione Release della soluzione tramite GitHub Actions;
- applicazione protocollo `Termodel/job RUNNING -> SUCCESS/FAILED` e notifica telefono.

## F4 — Fixture quadrato 4x4 m / unico tubo entrante
Stato: **COMMISSIONATO**

Obiettivo:
- fixture minima riproducibile e leggibile;
- input unico e risultato Diego diagnosticabile.

## F5 — Batteria benchmark GitHub Actions
Stato: **COMMISSIONATO**

Obiettivo:
- test funzionali e ripetuti;
- metriche: nodi mandata, terminali mandata, nodi ritorno, terminali complessivi,
  profondità, tempo, memoria;
- giudizio di sostenibilità basato su misure, non ipotesi.

## F6 — Consolidamento finale
Stato: **COMMISSIONATO**

Obiettivo:
- aggiornare Summary, linee guida, registro e risultati;
- distinguere implementato/compilato/eseguito/testato.
