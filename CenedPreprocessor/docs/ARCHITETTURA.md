# Architettura iniziale

## Principio

Il progetto viene separato in tre livelli concettuali:

```text
Sorgenti dati
(Termodel, import standard, compilazione manuale)
        ↓
SPECIFICA INTERMEDIA CENED
(tabellare, documentata, indipendente dalla UI)
        ↓
IMPLEMENTAZIONI
├── WebJS
└── Desktop certificabile
        ↓
adattatore/export verso motore Cened
```

## Regola di equivalenza

WebJS e Desktop non devono evolvere come due programmi indipendenti.

Ogni funzione che trasforma dati deve essere descritta prima nella specifica comune e verificata con gli stessi casi prova e gli stessi risultati attesi.

## Dipendenze

- `spec/` definisce dati, tipi, obbligatorietà, vincoli e mapping.
- `src/WebJS/` implementa l'esecuzione browser.
- `src/Desktop/` implementa la versione destinata alla certificazione.
- `tests/` contiene test e fixture.
- `GoldenResults/` contiene risultati di riferimento approvati.
- `samples/` contiene progetti/casi dimostrativi non usati come unica prova di conformità.

## Vincolo

Non copiare alla cieca il comportamento del preprocessore Cened esistente. Prima va rilevato, documentato e trasformato in una specifica verificabile.
