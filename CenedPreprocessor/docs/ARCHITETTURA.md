# Architettura iniziale

## Principio

Il prodotto è un **Software Bridge per modelli termici**. Importa dati da formati standard, li normalizza in un modello intermedio proprio e li rende utilizzabili dal flusso CENED.

Dal punto di vista ARIA/CENED, la versione che integra realmente CENED+2 Motore è un **Client di terze parti**.

```text
Sorgenti dati
        ↓
coppia obbligatoria di ingresso
gbXML + XML nazionale
        ↓
IMPORT / FUSIONE / NORMALIZZAZIONE
        ↓
SPECIFICA INTERMEDIA CENED
(tabellare, documentata, indipendente dalla UI)
        ↓
PRESENTAZIONE E VALIDAZIONE DATI
(interfaccia originale del Bridge)
        ↓
CENED+2 MOTORE
        ↓
CALCOLO
        ↓
XML CONFORME PER CEER
        ↓
ANTEPRIMA APE
(non sostitutiva dell'APE ufficiale)
```

## Fase implementativa corrente

Dal 22/09/2026 l'unica implementazione attiva è **WebJS**. La linea Desktop resta sospesa fino a nuova decisione esplicita.

## Contratto di ingresso duale

Il Bridge richiede due file complementari:

- **gbXML**: fonte primaria per geometria, spazi, superfici, aperture, orientamenti, relazioni termiche e geometrie/ostruzioni di ombreggiamento quando disponibili;
- **XML nazionale**: fonte complementare per dati generali/APE, codifiche e dati italiani specifici, dati impianto o altri campi che il gbXML non rappresenta con sufficiente completezza.

I due file vengono letti insieme e fusi nel modello intermedio.

Regole:
- geometria e cause fisiche → autorità gbXML;
- dati specifici nazionali non presenti nel gbXML → autorità XML nazionale;
- dati duplicati discordanti → segnalazione, nessuna correzione silenziosa;
- risultati già presenti nell'XML nazionale → confronto, non sostituzione delle cause fisiche;
- nessun editing tecnico nel Bridge: le correzioni si eseguono nel software sorgente e si riesportano i file.

## Interfaccia

Il Bridge può organizzare campi, sezioni e workflow in modo da rendere immediatamente comprensibile la corrispondenza con i dati richiesti da CENED+2.

Non deve però riprodurre graficamente CENED+2 Client: le Condizioni d'uso ARIA vigenti consentono la riproduzione delle interfacce CENED+2 Client esclusivamente a fini didattici.

La UI del Bridge sarà quindi originale pur mantenendo una struttura funzionale familiare al certificatore.

## Output

Output principali previsti:
- risultati e diagnostica restituiti dal CENED+2 Motore;
- file XML configurato secondo le specifiche ARIA per il deposito nel CEER;
- anteprima/fac-simile APE per controllo e stampa preliminare.

L'anteprima APE non viene qualificata come APE ufficiale. La produzione/deposito dell'APE ufficiale resta nel flusso CEER previsto dalle regole ARIA.

## Dipendenze

- `spec/` definisce dati, tipi, obbligatorietà, vincoli e mapping.
- `src/WebJS/` implementa l'esecuzione browser.
- `src/Desktop/` implementa la versione destinata all'autorizzazione.
- `tests/` contiene test e fixture.
- `GoldenResults/` contiene risultati di riferimento approvati.
- `samples/` contiene progetti/casi dimostrativi non usati come unica prova di conformità.

## Vincolo

Non copiare alla cieca il comportamento del preprocessore Cened esistente. Prima va rilevato, documentato e trasformato in una specifica verificabile.


## Principio di interoperabilità

Il Bridge accetta formati di scambio **pubblici, documentati e riconosciuti**.

Quando due formati descrivono domini diversi, vengono mantenuti come file separati e fusi soltanto all'interno del modello intermedio.

Prima applicazione:
- `gbXML` → geometria e modello termico fisico;
- XML nazionale → dati nazionali/APE e completamento dei campi mancanti.

L'architettura deve quindi essere basata su adapter:

```text
gbXML adapter ───────┐
                     ├─→ modello intermedio unico
XML nazionale adapter┘
```

Futuri formati pubblici potranno essere aggiunti con nuovi adapter, senza imporre un formato proprietario esterno del Bridge.
