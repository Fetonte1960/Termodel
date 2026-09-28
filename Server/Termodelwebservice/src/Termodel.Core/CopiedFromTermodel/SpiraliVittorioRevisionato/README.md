# Strategia `Vittorio_revisionato`

Nuova derivazione sperimentale creata il 28/09/2026 a partire dalla copia
stabile `CopiedFromTermodel/SpiraliVittorio/`.

## Regola di sviluppo

1. la fotografia iniziale deve differire da Vittorio esclusivamente per il
   namespace `SpiralHeatingVittorioRevisionato`;
2. prima di qualunque modifica strutturale va verificata la parità di risultato
   sul quadrato di riferimento;
3. la prima modifica ammessa è soltanto l'astrazione necessaria per applicare
   lo stesso algoritmo in modo indipendente a Supply e Return;
4. il Return deve poter ricevere la Supply come geometria condizionante;
5. non importare euristiche, fallback o correzioni da
   `SpiraliDiegoVittorio` senza una decisione successiva esplicita.

Questa cartella non è sorgente Desktop autorevole e resta tracciata in
`CopiedFromTermodel/TERMODEL-SYNC.md`.


## Milestone 1 — parità iniziale

Verificata con Fast Harness run `36465582271`:
- build Core + Harness: SUCCESS;
- quadrato storico 4x4/T1/p=0,30:
  - SVG identico a Vittorio, SHA-256
    `9673CD8D77A9963EC425FA69F54B8DCFF4C162312336D08D74AC722A2E0122A4`;
  - XML risultato identico a Vittorio, SHA-256
    `9517A5BFFE56F7CCB2419F173A0020FAC0EEBF6B2FD3706C02CD29D32C0DDCA6`.

## Milestone 2 — astrazione strutturale

Implementata senza importare euristiche da `SpiraliDiegoVittorio`.

- `SpiralGenerationInput` rende neutro il ruolo del generatore:
  perimetro, start, distanza e opzionali linee/distanza di condizionamento.
- la firma storica `Generate(List<Punto>, Punto, double, bool)` continua a
  produrre il comportamento Vittorio; il test di equivalenza completo resta
  obbligatorio a ogni modifica;
- il condizionamento è un **gate**: verifica i segmenti prodotti nello stesso
  ordine da Vittorio e arresta il percorso al primo segmento che viola la
  distanza dalle linee condizionanti;
- il gate non cerca gomiti alternativi, corridoi, trim, fallback o eccezioni
  topologiche.

Fast Harness run `36466606034` (#62): SUCCESS.
- parità completa Vittorio/Vittorio_revisionato sul quadrato: ancora SUCCESS;
- probe astrazione:
  - `neutralEquivalent=true`;
  - Supply: 37 punti;
  - secondo percorso indipendente senza condizionamento: 38 punti;
  - stesso percorso con Supply condizionante a 0,15 m: 1 punto.

Interpretazione:
la sola generalizzazione del generatore Vittorio più un vincolo hard Supply
non produce ancora un Return autonomo utile. Questo è un risultato diagnostico,
non un bug corretto né una nuova strategia. Prima di introdurre qualunque
rerouting va deciso esplicitamente quale minima differenza strutturale debba
avere il Return (radice, lato/verso, offset/distanze o altra regola).

`Vittorio_revisionato` non è ancora un motore di produzione e il normale
flusso completo continua intenzionalmente a usare il comportamento Vittorio
stabile.
