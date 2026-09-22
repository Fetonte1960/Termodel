# Registro commissioni — Termodel Cened

Regola: ogni incarico viene registrato prima dell'esecuzione come `COMMISSIONATO` e, a lavoro completato e verificato, aggiornato a `ESEGUITO`.

## CENED-0001 — 2026-09-22

**Stato:** COMMISSIONATO

**Oggetto:** creare la struttura Git iniziale del preprocessore Cened nel branch dedicato `TermodelCened`.

**Decisioni già consolidate:**
- il preprocessore Cened è un prodotto con identità propria, distinto da Termodel;
- sviluppo parallelo in due versioni: Web JavaScript pubblicabile online e Desktop destinata al percorso reale di certificazione;
- le due versioni devono condividere specifiche, casi prova e risultati attesi;
- il preprocessore deve trasformare un modello termico strutturato in input idoneo al motore Cened, senza rendere Termodel parte del perimetro di certificazione;
- ogni versione software avrà numero di versione esplicito e coerente nelle caption;
- tutte le decisioni e commissioni significative devono essere tracciate nel repository.

**Ambito di questa commissione:**
1. creare la struttura base del progetto;
2. creare il Project Summary specifico Cened;
3. predisporre cartelle per specifiche, WebJS, Desktop, test, golden results, esempi e documentazione di certificazione;
4. non implementare ancora funzioni applicative.
