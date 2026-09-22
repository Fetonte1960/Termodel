# Architettura iniziale

## Principio

Il prodotto è un **Software Bridge per modelli termici**. Importa dati da formati standard, li normalizza in un modello intermedio proprio e li rende utilizzabili dal flusso CENED.

Dal punto di vista ARIA/CENED, la versione che integra realmente CENED+2 Motore è un **Client di terze parti**.

```text
Sorgenti dati
(Termodel, formati standard, compilazione manuale)
        ↓
IMPORT / NORMALIZZAZIONE
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

## Due implementazioni

```text
Specifica comune
├── WebJS
└── Desktop
```

La versione Desktop è quella destinata al percorso di autorizzazione/certificazione. La versione WebJS resta parallela per sviluppo, verifica e dimostrazione salvo successive decisioni sul suo perimetro.

## Regola di equivalenza

WebJS e Desktop non devono evolvere come due programmi indipendenti.

Ogni funzione che trasforma dati deve essere descritta prima nella specifica comune e verificata con gli stessi casi prova e gli stessi risultati attesi.

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
