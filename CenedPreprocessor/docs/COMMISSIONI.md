# Registro commissioni — Termodel Cened

Regola: ogni incarico viene registrato prima dell'esecuzione come `COMMISSIONATO` e, a lavoro completato e verificato, aggiornato a `ESEGUITO`.

## CENED-0001 — 2026-09-22

**Stato:** ESEGUITO

**Oggetto:** creare la struttura Git iniziale del preprocessore Cened nel branch dedicato `TermodelCened`.

**Decisioni già consolidate:**
- il preprocessore Cened è un prodotto con identità propria, distinto da Termodel;
- sviluppo parallelo in due versioni: Web JavaScript pubblicabile online e Desktop destinata al percorso reale di certificazione;
- le due versioni devono condividere specifiche, casi prova e risultati attesi;
- il preprocessore deve trasformare un modello termico strutturato in input idoneo al motore Cened, senza rendere Termodel parte del perimetro di certificazione;
- ogni versione software avrà numero di versione esplicito e coerente nelle caption;
- tutte le decisioni e commissioni significative devono essere tracciate nel repository.

**Ambito eseguito:**
1. creato il branch `TermodelCened` da `main`;
2. creata la struttura base in `CenedPreprocessor/`;
3. creato `PROJECT-SUMMARY-CENED.md`;
4. creati registro commissioni e storico decisioni;
5. predisposte le aree `spec`, `src/WebJS`, `src/Desktop`, `tests`, `GoldenResults`, `samples`;
6. predisposta la documentazione iniziale di architettura e certificazione;
7. inizializzata la versione `0.1.0-dev`;
8. nessuna funzione applicativa Cened è stata ancora implementata.

**Verifica:** presenza e contenuto dei file principali riletti sul branch `TermodelCened`; Project Summary aggiornato allo stato effettivo.

## CENED-0002 — 2026-09-22

**Stato:** COMMISSIONATO

**Oggetto:** verificare la definizione del prodotto rispetto alle condizioni e regole ARIA/CENED correnti e consolidarne la formulazione nel progetto.

**Definizione proposta dall'utente:** software bridge tra formati standard di modelli termici e CENED+2 Motore; dopo l'importazione presenta/organizza i dati, avvia il calcolo, prepara l'XML e produce un'anteprima APE.

**Ambito:**
1. verificare la compatibilità concettuale con le Condizioni d'uso ARIA/CENED vigenti;
2. distinguere il posizionamento commerciale "bridge" dalla qualificazione regolatoria di Client di terze parti;
3. chiarire i limiti relativi alla riproduzione dell'interfaccia grafica CENED+2 Client;
4. chiarire il ruolo dell'anteprima APE rispetto all'APE ufficiale/CEER;
5. aggiornare lo storico decisioni e l'architettura senza implementare codice.
