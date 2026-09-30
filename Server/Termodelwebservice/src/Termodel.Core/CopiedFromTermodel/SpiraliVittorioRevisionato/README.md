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

`Vittorio_revisionato` resta sperimentale: non è il default di produzione.
Il comportamento completo continua intenzionalmente a riprodurre Vittorio
quando non viene usato l'ingresso condizionato.


## Milestone 3 — collaudo multi-progetto e pubblicazione

Correzione procedurale del 29/09/2026: il solo quadrato non è più considerato
un collaudo sufficiente.

Fast Harness run `36503404032` (#64): **SUCCESS**.
`Vittorio_revisionato` è risultato byte-identico a `Vittorio`, sia nello
SVG sia nell'XML risultante, su sei casi:
- quadrato 4x4;
- concavo L;
- trapezio obliquo;
- connection-terminal;
- appartamento corrente preparato;
- progetto pubblico Pannelli radianti completo.

Dopo il banco multi-progetto, il motore è stato esposto nel Service come scelta
**per singola elaborazione**:
`POST /api/calculations?spiralEngine=Vittorio_revisionato`.
Il default del Service resta `Diego_Vittorio` e la selezione non viene salvata
nel file progetto.

Service Build run `36504429395` (#1067):
- JavaScript frontend: SUCCESS;
- build soluzione: SUCCESS;
- smoke progetto pubblico: SUCCESS;
- smoke override per-request `Vittorio_revisionato`: SUCCESS;
- verifica deploy pubblico Render + Pages: SUCCESS;
- workflow complessivo ancora rosso esclusivamente per il golden Darcy
  sintetico già noto e indipendente dalle spirali.

Verifica pubblica registrata dal runner:
- Render espone `Vittorio_revisionato` fra i motori disponibili;
- default pubblico: `Diego_Vittorio`;
- frontend pubblico: v1.36.

La pubblicazione serve al collaudo collaborativo. Non autorizza ancora
l'integrazione del Return autonomo né l'importazione di euristiche da
`SpiraliDiegoVittorio`.


## Modalità pubblica temporanea — solo mandata (STORICO 29/09/2026)

Per agevolare il collaudo visivo richiesto dall'utente, il percorso pubblico
`Vittorio_revisionato` è temporaneamente configurato con:

- generazione della mandata invariata;
- **chiusura non eseguita**;
- **ritorno non generato/visualizzato**;
- SVG pre-chiusura riclassificato graficamente come mandata rossa, così il
  Service lo espone nel layer `*_PannelliMandata_Output`;
- nessuna modifica a `SpiralGenerator` o alla geometria della mandata.

La modalità è controllata da:

```text
Program.SoloMandataPerEsameVisivo = true
```

`AggiornaSpirali()` usa questo valore nel percorso pubblico. L'overload
`AggiornaSpirali(false)` conserva invece il flusso completo storico
mandata + chiusura + ritorno ed è usato dal benchmark di equivalenza, in modo
che le regression Vittorio/Vittorio_revisionato restino confrontabili.

Questa è una modalità **temporanea di collaudo**, non una nuova strategia.

## Milestone 4 — LG-051: chiusura rettilinea e raccordatura separata (30/09/2026)

La direttiva LG-051 sostituisce il percorso pubblico sperimentale basato sul
raccordo Bézier, senza modificare il benchmark storico Vittorio.

- la combinatoria lavora soltanto su Supply/Return rettilinei;
- il segmento di chiusura deve essere >=2P, non produrre angoli acuti e non
  intersecare la geometria risultante;
- ci si ferma al primo candidato valido;
- se nessun candidato è valido, Supply e Return restano separati;
- soltanto dopo la scelta si raccorda l'intero percorso con archi circolari;
- raggio locale default 0,10 m, non ridotto per adattarsi a tratti corti;
- tolleranza locale di discretizzazione default 5 mm;
- uno spigolo non raccordabile resta vivo ed è accettabile;
- nessuna Bézier partecipa alla decisione di chiusura.

Il Fast Harness è stato riallineato, ma il commit di pubblicazione non lo
esegue automaticamente per rispettare la richiesta esplicita di non inviare
notifiche.
