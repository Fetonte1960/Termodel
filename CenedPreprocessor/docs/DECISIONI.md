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


## 2026-09-22 — D-0008 — Fase attiva esclusivamente WebJS

Da questa data il progetto entra in una fase di sviluppo e discussione **esclusivamente WebJS**.

Regole:
- `src/WebJS/` è l'unica implementazione attiva;
- `src/Desktop/` resta sospesa e non deve essere modificata o sviluppata fino a nuova decisione esplicita;
- il percorso Desktop/certificazione resta documentato come obiettivo futuro, ma non guida le attività implementative correnti;
- specifiche, modelli dati, riferimenti CENED, test e Golden Results devono essere progettati in modo riutilizzabile, senza obbligare a implementare contemporaneamente una versione Desktop;
- nessuna integrazione operativa con runner Java, Termodel.Core o Termodel.WebService viene avviata nell'ambito di questa fase salvo nuova autorizzazione esplicita;
- la WebJS è usata come ambiente di studio, prototipazione, verifica dell'interfaccia, discussione del mapping dati e consolidamento del prodotto.

Questa decisione sospende operativamente la precedente D-0002 relativa allo sviluppo parallelo di WebJS e Desktop, senza cancellarla dallo storico.


## 2026-09-22 — D-0009 — XML Blumatica come Golden Reference nazionale

Il file XML `output.xml` fornito dall'utente e dichiarato importato con successo in Blumatica viene assunto come **Golden Reference strutturale** dell'XML nazionale/interoperabile che la WebJS dovrà essere in grado di produrre.

Regole:
- identificativo del riferimento: `BLUMATICA-XML-001`;
- il file originale è identificato dal digest SHA-256 `4988a0700ad1aeb60ef6906235411a176baee514f7a902533dfcc1ad86980647`;
- il file grezzo non viene pubblicato nel repository perché contiene dati personali reali e il repository è pubblico;
- il riferimento viene usato per struttura, gerarchie, mapping e test di serializzazione dell'output XML WebJS;
- il fatto che Blumatica lo importi non dimostra automaticamente conformità con CENED+2 Motore;
- ogni futura copia anonimizzata o modificata non può essere chiamata "testata con Blumatica" finché non venga nuovamente verificata con un'importazione reale.


## 2026-09-22 — D-0010 — GestXml Termodel come riferimento non vincolante

Il sorgente Termodel `SorgentiTermodel/Library/GestXml.cs`, identificato nello snapshot fornito dall'utente con SHA-256 `906cde73c919fa90359daae0df0c00a1a088e318e3c2b9130b293ab1e51c0736`, viene acquisito come **fonte di ispirazione tecnica** per la WebJS.

Non è una specifica normativa né un vincolo implementativo.

Ordine di autorità:
1. specifiche ufficiali ARIA/formato ufficiale;
2. Golden Reference validati;
3. specifica propria del Software Bridge;
4. `GestXml.cs` come riferimento concettuale.

Sono riutilizzabili concettualmente gerarchie, mapping, classificazione dei confini, calcoli geometrici e principi di serializzazione. Non devono essere trasferiti automaticamente coupling Desktop/WPF/Xbim, stato globale, valori hard-coded, fallback o formule non verificate.
