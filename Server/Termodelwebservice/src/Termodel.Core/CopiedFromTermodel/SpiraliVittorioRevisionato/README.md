## Rollback 01/10/2026

Il candidato con:
- Mandata-parete = 1,5P;
- Mandata-Mandata = 2P;
- Mandata-Return = P;

è stato respinto dal collaudo visivo.

Il runtime corrente è stato ripristinato byte-per-byte, per i file interessati,
al restore point:

`0b541f92cf74412a33d68ffc0603e3f319c4a82f`.

Da questo punto in avanti le modifiche alla geometria delle distanze devono
essere introdotte **una alla volta** e verificate visivamente prima della
successiva.

---

## Candidato 01/10/2026 — Mandata 1,5P / 2P, Return a P

Il percorso pubblico `Vittorio_revisionato` separa ora i ruoli geometrici
prima unificati nella singola distanza Vittorio:

```text
P = 0,30 m
Mandata-Parete = 0,45 m = 1,5P
Mandata-Mandata = 0,60 m = 2P
Mandata-Return = 0,30 m = P
Return-Parete risultante = 0,15 m = P/2
Finalizzazione Mandata = 0,30 m = P
```

Il Return continua a essere costruito da
`funzioni_diego.ritorno_Parallelo_diego`, ma l'offset passa da P/2 a P.
La Mandata usa la struttura Vittorio con un overload revisionato che applica
1,5P al solo primo offset e 2P agli offset successivi. La soglia
`ComputeOffset` resta `edgeLength <= offset`.

Recovery precedente:
`0b541f92cf74412a33d68ffc0603e3f319c4a82f`,
branch
`recovery/vittorio-revisionato-before-split-wall-supply-20261001`.

---

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

## Chiusura configurabile dal Service — 30/09/2026

Il percorso pubblico conserva `AggiornaSpirali()` con comportamento chiuso
per compatibilità. È disponibile anche:

```csharp
Program.AggiornaSpiraliConChiusura(bool chiudiCircuito)
```

Con `chiudiCircuito=false` vengono mantenuti sia Mandata sia Return, ma viene
saltato il collegamento finale tra le due estremità e non viene prodotta
l'etichetta grafica di chiusura. Non viene creato alcun nuovo motore e
`SpiraliVittorio` resta invariata.

Dal Service il controllo è per-request:

```http
POST /api/calculations?spiralEngine=Vittorio_revisionato&spiralClosure=false
```

Il default di `spiralClosure` è `true`.



## Milestone 5 — Generate P/2-2P con recovery storico (01/10/2026)

Il percorso pubblico di `Vittorio_revisionato` adotta ora la convenzione
geometrica già consolidata in `Diego_Vittorio`:

```text
P = 0,30 m
parete-Mandata = P/2 = 0,15 m
Mandata-Mandata = 2P = 0,60 m
Mandata-Ripresa = P = 0,30 m
chiusura minima = 2P = 0,60 m
```

Per evitare rollback globali sono mantenuti due ingressi distinti:
- `SpiralGenerator.Generate(...)`: contratto storico Vittorio a distanza
  unica, baseline di recovery;
- `SpiralGenerator.GenerateRevisionato(...)`: percorso P/2-2P usato dal
  revisionato pubblico.

`AggiornaSpiraliConChiusura` accetta inoltre
`usaGenerateStoricoRecovery=true`, che ripristina soltanto la Supply storica
lasciando invariati Return parallelo Diego, combinatoria e raccordatura.

La finalizzazione topologica interna al generatore revisionato resta a `P`;
non decide la chiusura finale. L'autorità sui tagli/normalizzazioni terminali
resta `funzioni_diego.chiusura_diego(...)` con matrice
`0I,0P,1I,1P,2I,2P`.

Commit funzionali:
- `2d6dc35f58541f4a5c32e17d74a7f749659a1dd6`;
- `4228c4b9e8a78eb4305af3a391c82815f688e1ee`.


## Milestone 6 — recovery pubblico al Generate storico (01/10/2026)

Il candidato P/2-2P introdotto nella Milestone 5 ha compilato e superato i gate
tecnici dedicati, ma ha fallito il successivo controllo visivo reale
dell'utente: la spirale pubblica risultante non è accettabile.

Per questo il default pubblico è stato immediatamente riportato al
`SpiralGenerator.Generate(...)` storico a distanza unica, usando il meccanismo
di recovery progettato nella milestone precedente.

Il candidato `GenerateRevisionato(...)` resta nel sorgente per future analisi,
ma non è attivo per default. Il ripristino riguarda soltanto la Supply e non
annulla il lavoro su Return, combinatoria o raccordatura.

Commit recovery pubblico:
`dd7d411ab3de9223ec7d927aed407d59c60aa62e`.



## Milestone 7 — rollback completo alla baseline funzionante (01/10/2026)

Il recovery parziale della sola Supply non era sufficiente: aveva lasciato
`DistanzaRitorno=P=0,30` e la nuova semantica della chiusura, creando una
configurazione ibrida mai approvata.

Su richiesta dell'utente sono stati quindi riportati byte-per-byte alla
fotografia `b71931e6ccb3761b05b21abd07f6d73154b13b3f`:
`Program.cs`, `Spiralgenerator.cs`, benchmark, Harness e workflow Fast.

Configurazione attiva:
- `PassoTubi=0,30`;
- `DistanzaPareti=0,30`;
- `DistanzaRitorno=0,15`;
- Generate storico;
- Return parallelo Diego;
- combinatoria `chiusura_diego(...,0,15)`;
- log istituzionale `SpiraliDiego` mantenuto.

Fast Harness `36839123030`: equivalenza iniziale e multi-progetto (6 casi)
SUCCESS; quadrato pubblico SUCCESS con `0,40 >= 0,30`.
Il candidato P/2-2P resta una sperimentazione fallita e non è il percorso
corrente.


## Milestone 8 — vero SpiralGenerator Vittorio puro (01/10/2026)

Per rimuovere definitivamente l'ambiguità creata dalle estensioni successive,
`Spiralgenerator.cs` è stato sostituito con la copia originale creata nel
revisionato al commit `5b8ddc11b4e23046bda1e1c5824af4d4bc084326`.

Il file corrente:
- ha blob SHA `95e99c7e420dab6b102f69a16a919c2ce0856bf3`;
- ha 270 righe;
- è identico al generatore Vittorio salvo namespace;
- non contiene `SpiralGenerationInput`, `GenerateCore`, condizionamento o
  `TerminalCenterline`.

`Program.cs` richiama ora direttamente la firma storica:

```csharp
SpiralGenerator.Generate(perimetro, startPoint, DistanzaPareti, true)
```

Return, chiusura combinatoria e log istituzionale restano invariati.

Return point dell'intero stato precedente:
`45bff4b4d016bcd60aa0c18d26aefdcf51ad8a21`, branch
`recovery/vittorio-revisionato-before-pure-vittorio-20261001`.

Fast Harness `36847338021`: equivalenza Vittorio su 6 casi e
`VITTORIO_REVISIONATO_PURE_GENERATOR_OK`.
Service Build `36847235975`: build e smoke revisionato SUCCESS.

La promozione definitiva resta subordinata al controllo visivo reale.


## Milestone 9 — soglia ComputeOffset 3P -> P (01/10/2026)

Su prova locale Visual Studio è stata pubblicata una sola deviazione rispetto
al generatore Vittorio puro:

```csharp
edgeLength <= offset
```

al posto di:

```csharp
edgeLength <= offset * 3
```

Con `offset=0,30 m` lo skip dei vertici non parte più a 0,90 m ma a 0,30 m.
I due stop su `minEdgeLength` restano invariati.

Commit funzionale:
`6132430e7907699cbf577c2ef869ffd03117f216`.

Return point precedente:
`f1544135c303abb8296ef784c86b3cca6d627e6c`,
branch
`recovery/vittorio-revisionato-before-offset-threshold-20261001`.

Fast Harness `36861645040`: quadrato pubblico SUCCESS; la vecchia equivalenza
multi-progetto con Vittorio diverge su `concave-l`, effetto atteso da una
modifica deliberata del generatore revisionato.
Service Build `36861644983`: build, smoke chiuso/aperto e deploy pubblico
SUCCESS.


## Milestone 10 — restore point offset-P approvato visivamente (01/10/2026)

Il collaudo reale sul progetto multi-locale ha approvato come base di
ripristino la versione con soglia `ComputeOffset` ridotta da `3P` a `P`.

Restore point approvato:
- runtime funzionale:
  `6132430e7907699cbf577c2ef869ffd03117f216`;
- snapshot documentale:
  `edc1fc4cff0edad0700a9c9c2582b80c205efb57`;
- branch:
  `recovery/vittorio-revisionato-approved-offset-p-20261001`.

Il generatore va descritto quindi come **Vittorio puro + deviazione
`ComputeOffset 3P -> P`**, non più come copia byte-identica di Vittorio.

### Difetto residuo noto

Nel test multi-locale resta un difetto nelle strettoie, evidenziato nel locale
4. Il comportamento non soddisfacente nella zona ristretta è accettato come
**problema aperto** e non come comportamento corretto.

L'utente riferisce che questo difetto era stato tamponato in una precedente
iterazione. Prima di reintrodurre qualunque soluzione va ricostruito quale
intervento fosse effettivamente responsabile e va creato un nuovo return point.

Nessuna correzione strettoie è stata eseguita in questa milestone.


Verifica automatica richiesta dopo rollback: questo aggiornamento documentale
serve anche a rieseguire i workflow sul runtime già ripristinato, senza
modificare i sorgenti geometrici.
