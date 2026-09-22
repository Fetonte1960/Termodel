# Storico decisioni — Termodel Cened

Questo file registra le decisioni architetturali e di prodotto consolidate. Non sostituisce il registro commissioni.

## 2026-09-22 — D-0001 — Prodotto autonomo

Il preprocessore Cened ha identità propria. Termodel è una possibile sorgente dati ma non fa parte del perimetro iniziale di certificazione.

## 2026-09-22 — D-0002 — Due implementazioni parallele

Si sviluppano:
- WebJS online su termodel.it;
- Desktop destinata alla certificazione.

Le due versioni devono condividere specifica semantica, casi prova e Golden Results.

## 2026-09-22 — D-0003 — Modello intermedio

Il preprocessore deve ricevere un modello termico strutturato e indipendente dalla UI. Il mapping verso Cened deve essere documentato nella specifica comune.

## 2026-09-22 — D-0004 — Versionamento visibile

Ogni versione software deve avere un identificativo incrementale e tale versione deve essere visibile nelle caption/interfacce delle applicazioni.

## 2026-09-22 — D-0005 — Tracciabilità

Ogni incarico viene registrato come COMMISSIONATO prima del lavoro e trasformato in ESEGUITO solo dopo verifica. Le decisioni architetturali vengono registrate in questo storico.

## 2026-09-22 — D-0006 — Identità del prodotto: Software Bridge / Client CENED+2

Il prodotto viene presentato funzionalmente come **software bridge** tra formati standard di modelli termici e CENED+2 Motore.

Dal punto di vista delle regole ARIA/CENED, quando integra e utilizza CENED+2 Motore il prodotto ricade nella categoria di **Client di terze parti integrato con CENED+2 Motore** e deve rispettare le specifiche tecniche e il percorso di autorizzazione previsto dall'O.d.A.

Flusso di prodotto consolidato:

```text
formati standard di modelli termici
        ↓
importazione / normalizzazione
        ↓
modello intermedio del Bridge
        ↓
presentazione e verifica dei dati
        ↓
CENED+2 Motore
        ↓
calcolo
        ↓
XML conforme per CEER
        ↓
anteprima APE non ufficiale
```

L'interfaccia può organizzare i dati secondo una logica funzionale vicina alle sezioni necessarie a CENED+2, ma deve avere una grafica originale: non viene adottata la riproduzione dell'interfaccia grafica del CENED+2 Client.

L'anteprima APE prodotta dal Bridge è uno strumento di controllo e stampa preliminare e deve essere chiaramente distinta dall'APE ufficiale prodotto/depositato attraverso il CEER.

## 2026-09-22 — D-0007 — Comunicazione commerciale prima dell'autorizzazione

Prima del rilascio dell'autorizzazione ARIA/O.d.A. il prodotto può essere descritto come **progettato per l'integrazione con CENED+2 Motore** o **in fase di autorizzazione** quando tale fase sarà effettivamente avviata.

Non deve essere presentato come Client CENED+2 autorizzato/accreditato né come integrazione già autorizzata fino al rilascio formale dell'autorizzazione.
