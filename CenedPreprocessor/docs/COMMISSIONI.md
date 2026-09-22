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

**Stato:** ESEGUITO

**Oggetto:** verificare la definizione del prodotto rispetto alle condizioni e regole ARIA/CENED correnti e consolidarne la formulazione nel progetto.

**Definizione consolidata:** software bridge tra formati standard di modelli termici e CENED+2 Motore; importa e normalizza i dati, li presenta mediante UI originale, avvia il calcolo attraverso il Motore, produce XML conforme per CEER e genera un'anteprima APE chiaramente non ufficiale.

**Esito della verifica ARIA:**
- il posizionamento commerciale come `Software Bridge` è compatibile;
- quando integra realmente CENED+2 Motore, per ARIA il prodotto è un **Client di terze parti** e deve seguire il relativo percorso di autorizzazione;
- la riproduzione grafica del CENED+2 Client non viene adottata, poiché le Condizioni d'uso vigenti la consentono esclusivamente a fini didattici;
- l'interfaccia sarà originale ma potrà organizzare i dati in modo funzionalmente familiare al certificatore;
- l'anteprima APE è distinta dall'APE ufficiale del flusso CEER;
- il versionamento deve tenere conto degli obblighi ARIA sulle major release e degli aggiornamenti del Motore.

**Documenti aggiornati:**
- `docs/DECISIONI.md`;
- `docs/ARCHITETTURA.md`;
- `docs/CERTIFICAZIONE.md`;
- `PROJECT-SUMMARY-CENED.md`.

**Fonti ufficiali verificate:** Condizioni d'uso CENED revisione 01/09/2026 e pagine ufficiali ARIA/CENED relative a CENED+2 Motore e ai Client di terze parti.

**Codice applicativo:** nessuna modifica.


## CENED-0003 — 2026-09-22

**Stato:** COMMISSIONATO

**Oggetto:** studio di fattibilità in sola lettura per l'integrazione headless di CENED+2 Motore con Termodel.Core / Termodel.WebService mediante runner Java separato.

**Vincoli:**
- nessuna modifica a Termodel.Core, Termodel.WebService, frontend o `definizionedati.json`;
- nessun JAR proprietario copiato o pubblicato nel repository;
- nessuna decompilazione o riscrittura del motore proprietario;
- nessuna dichiarazione di funzionamento headless senza prova reale;
- runner Java, se successivamente autorizzato, separato dal Core C#;
- percorsi locali del software CENED configurati esternamente;
- distinguere evidenze documentali, analisi statica, prototipo, compilazione, esecuzione e validazione.

**Studio richiesto:**
1. dipendenze del motore;
2. configurazione Spring richiesta;
3. classi/API pubbliche utili;
4. struttura XML input/output;
5. schema del runner Java headless minimo;
6. rischi tecnici e di licenza;
7. modifiche minime future a Core/WebService;
8. piano di prova reale successivo, non eseguito in questa commissione.
