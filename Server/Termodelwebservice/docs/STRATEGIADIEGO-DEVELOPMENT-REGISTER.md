# STRATEGIADIEGO — REGISTRO DI SVILUPPO

Data avvio: **25/09/2026**  
Stato generale: **COMPLETATO PER IL CASO 4x4 / UN INGRESSO**

Scopo: registrare fasi indipendenti e recuperabili dell'implementazione,
attivazione e benchmark della StrategiaDiego.

## F0 — Registrazione incarico e registro di sviluppo
Stato: **ESEGUITO**

Risultato:
- incarico registrato in `PROJECT-SUMMARY-SERVICE.md`;
- definite le fasi F0..F6;
- questo registro diventa checkpoint operativo per il recupero da crash/chat interrotta.

Commit incarico:
- `885f375cb92dee96e8764af051b9d798159cc6f3`

## F1 — Audit finale Vittorio/GPT e specifica code-ready
Stato: **ESEGUITO**

Sorgenti esaminati:
- `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Program.cs`;
- `.../Spiralgenerator.cs`;
- `.../ChiudiSpirale.cs`;
- `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/Program.cs`;
- `.../Spiralgenerator.cs`;
- `.../ChiudiSpirale.cs`;
- `SorgentiTermodel/Library/Impianti/Pannelli/IoPannelli.cs`.

Conclusioni:
- Desktop possiede già il selettore `Vittorio|GPT`, con GPT default;
- Vittorio genera anelli successivi mediante offset con normali/bisettrici,
  aggancio al segmento dell'offset e chiusura separata;
- GPT mantiene lo stesso contratto `locale.xml -> locale.svg`, ma usa offset
  robusti NetTopologySuite, conserva più candidati di raccordo, controlla
  strettoie/intersezioni e costruisce il ritorno in modo più esplicito;
- StrategiaDiego non deve essere una variante interna di GPT: deve essere un
  terzo motore headless con proprio albero decisionale e proprie metriche;
- il punto comune da riusare è il **contratto geometrico**, non l'euristica di
  scelta: input locale/perimetro/tubi, output mandata+ritorno e diagnostica;
- la geometria offset mitrata di GPT è il riferimento preferibile per la
  robustezza numerica, mentre la semantica Diego resta quella consolidata nelle
  LG-001..LG-035;
- il Service oggi incorpora solo copie temporanee GPT; per rendere realmente
  selezionabile Vittorio senza modificare la Library, la sua implementazione
  Desktop verrà copiata byte-identical nel Core e tracciata in
  `CopiedFromTermodel/TERMODEL-SYNC.md` finché non esisterà un package/core
  condiviso stabile.

Esito:
- audit sufficiente per passare all'implementazione;
- nessuna modifica ai sorgenti Desktop Vittorio/GPT.

## F2 — Implementazione e dispatcher Vittorio|GPT|Diego
Stato: **ESEGUITO — IMPLEMENTATO, NON ANCORA COMPILATO**

Risultato:
- aggiunto `RadiantPanels/StrategiaDiegoEngine.cs` con albero mandata, sottoalberi
  ritorno, metriche e limiti tecnici espliciti;
- aggiunto dispatcher nel `RadiantExecutiveGenerator` con selezione tramite
  `TERMODEL_SPIRAL_ENGINE=Vittorio|GPT|Diego`;
- default lasciato a `GPT` per retrocompatibilita;
- aggiunte nel Core copie temporanee **byte-identical** del motore Vittorio,
  senza modificare la Library Desktop;
- aggiornato `CopiedFromTermodel/TERMODEL-SYNC.md`.

Commit principali:
- `79ad50c9ce9720219d2c05e2814fbafed2ad4534` — motore Diego;
- `8c34e10b2db8a07ca8342097122d2cc67480540c` — dispatcher;
- `e665f9d4`, `d7987644`, `475b998f`, `c51f481e` — copie Vittorio;
- `23a2d6ee9fdd8d7c592f26d358a333621b0c760b` — tracciatura sync.

Verifica:
- implementato su Git;
- compilazione reale demandata alla fase F3.

## F3 — Build reale
Stato: **ESEGUITO — COMPILAZIONE RELEASE RIUSCITA**

Tentativo 1:
- commit `49e9a61f566e4d05d78de3fff6ab23379d7bedb5`;
- GitHub Actions run `36086188268`, job `107918524934`, run number 438;
- `Termodel/job=RUNNING` pubblicato correttamente;
- build FALLITA con 6 errori C# locali a `StrategiaDiegoEngine.cs`
  (named argument `SequenceIndex`, accesso nullable `GeoSegment?`,
  conversione nullable e formattazione SVG);
- step finale: `TERMODEL_JOB_STATUS=FAILED`;
- `PHONE_NOTIFICATION_SENT status=FAILED`.

Correzione:
- commit `32937f99e27342dc53cd8a71c8d40b3363c0f7b4`;
- corretti esclusivamente errori di tipizzazione/compilazione, senza cambiare
  le regole geometriche.

Tentativo 2:
- GitHub Actions run `36086401306`, job `107919165262`, run number 439;
- restore, controlli frontend e **Build Release completati con successo**;
- compilazione reale quindi verificata;
- gli smoke generali della stessa run possono proseguire indipendentemente e
  non sono usati per dichiarare la sola fase di compilazione.

## F4 — Fixture quadrato 4x4 m / unico tubo entrante
Stato: **ESEGUITO**

Risultato:
- creata `tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`;
- locale `R001` quadrato 4,00 x 4,00 m;
- unico tubo `T1` da `(2,-1)` a `(2,1)`, quindi ingresso centrato
  sulla parete inferiore e direzione entrante `+Y`;
- creata `tests/fixtures/README-StrategiaDiegoSquare4x4.md` con geometria,
  radici teoriche ritorno e obiettivi del test;
- la fixture non contiene Golden Result prematuri.

Commit:
- `4bf2e2b3696b51a04e7d9b964ac4f96fc9cd01ac` — XML caso 4x4;
- `e07bc1db5e3d2c9b968136913f5b853089c3fba0` — documentazione fixture.

## F1B — Audit di allineamento implementazione vs LG-033..LG-035
Stato: **ESEGUITO**

Verifica eseguita sul codice corrente dopo la prima implementazione:
- riesaminati i generatori paralleli Vittorio e GPT e il nuovo `StrategiaDiegoEngine`;
- confermato che Diego mantiene il proprio albero esplorativo e non modifica semanticamente Vittorio/GPT;
- confermato che la formula corrente `respect / |cross|` e' la generalizzazione geometrica corretta dello spostamento `±d` nel caso ortogonale;
- individuato uno scarto rispetto a LG-033/LG-035: quando il ramo sta inseguendo un tratto precedente, il motore corrente cerca ancora la prossima linea frontale fra **tutti** i vincoli; non privilegia/vincola ancora il successore `S_k+1` della stessa evoluzione;
- il benchmark corrente e' quindi una **baseline pre-allineamento**, non ancora il benchmark finale della specifica completa.

Baseline Action verificata:
- commit `0a6e58658382e806f80ef975760c2e4b83ab88ff`;
- run GitHub Actions `36087631862` / build #450: SUCCESS;
- 20 iterazioni: 1176 nodi, 2 terminali accettati, p95 98 ms,
  max memory delta 7.408.856 byte;
- notifica finale telefono: SUCCESS.

Decisione:
- introdurre una sottofase F2B minima e reversibile che renda esplicito
  l'inseguimento `S_k -> S_k+1` senza alterare Vittorio/GPT;
- rieseguire poi build e benchmark prima di chiudere F5.

## F2B — Allineamento inseguimento sequenziale LG-033..LG-035
Stato: **ESEGUITO — IMPLEMENTATO, DA RIVERIFICARE IN BUILD/BENCHMARK**

Obiettivo:
- quando un nodo Diego sta seguendo un segmento di tubo gia' appartenente al
  path, usare il suo `SequenceIndex` per individuare il successore
  `S_k+1`;
- per i rami paralleli, il successore deve essere il riferimento di troncatura
  strategico quando esiste;
- `PROSEGUI_DRITTO` resta un'alternativa separata e continua a escludere la
  linea che ha appena troncato il tratto precedente;
- nessuna modifica ai motori Vittorio/GPT.

Risultato:
- aggiunta ricerca del successore geometrico `S_k+1` tramite `SequenceIndex`;
- i rami `PARALLELA_A/B` usano `S_k+1` come frontale richiesta quando disponibile;
- `PROSEGUI_DRITTO` resta separato ed esclude la frontale appena usata;
- Vittorio/GPT non modificati.

Commit:
- `90f76ff47e4822b00d7ba3d57b524017e377f092`.

## F5 — Batteria benchmark GitHub Actions
Stato: **ESEGUITO — SOSTENIBILE SUL CASO 4x4**

Verifica finale:
- commit HEAD testato: `77c7d44f1b089dc302b49bbd6f86af4f2a330863`;
- GitHub Actions `TermodelService Build` run `36096201896`, build #453;
- job build `107949117086`: SUCCESS;
- `Termodel/job=SUCCESS`;
- notifica telefono: `PHONE_NOTIFICATION_SENT status=SUCCESS`;
- build Release completata con successo;
- benchmark eseguito per 20 iterazioni sulla fixture
  `tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`.

Metriche finali:
- nodi totali massimi: **104**;
- terminali preliminarmente accettati: **2**;
- p95: **22 ms**;
- max memory delta: **368.800 byte**;
- output deterministico verificato dal benchmark tramite firma strutturale e
  SHA-256 SVG costante fra le iterazioni;
- budget benchmark rispettati: 50.000 nodi, p95 2.000 ms, memoria 128 MiB.

Confronto con baseline pre-F2B:
- baseline run #450: 1176 nodi, p95 98 ms, 7.408.856 byte, 2 terminali;
- dopo inseguimento sequenziale LG-033..LG-035: 104 nodi, p95 22 ms,
  368.800 byte, 2 terminali;
- la riduzione deriva dall'eliminazione di frontali non appartenenti alla
  sequenza `S_k -> S_k+1`, non da potatura euristica predittiva.

Giudizio:
- **sostenibile sul caso campione 4x4 / un ingresso**;
- il giudizio non viene esteso automaticamente a progetti più complessi:
  servono fixture aggiuntive con concavità, strettoie, più locali/circuiti.

## F6 — Consolidamento finale
Stato: **ESEGUITO**

Risultato:
- Summary Service aggiornato con stato finale dell'incarico;
- mantenuto distinto il documento vivo delle linee guida StrategiaDiego;
- registrata separatamente la baseline pre-allineamento e la misura finale;
- stato reale distinto:
  - progettato: SI;
  - implementato: SI;
  - compilato: SI, GitHub Actions build #453;
  - eseguito: SI, fixture 4x4/un ingresso;
  - testato: SI, 20 iterazioni benchmark;
  - confrontato con riferimento: confronto architetturale/algoritmico con
    Vittorio e GPT eseguito; non esiste ancora un Golden Result approvato per
    l'output geometrico Diego.

Commit consolidamento Summary:
- `0936dcb6a35ea7fd449ee9a98a780893bb51073c`.

Limiti residui:
- sostenibilità verificata soltanto sul caso quadrato 4x4 con un ingresso;
- mancano regression dedicati a concavità, strettoie, più circuiti e più locali;
- la chiusura avanzata resta successiva alla valutazione preliminare LG-029.

## R1 — Regressione locale concavo a L
Stato: **ESEGUITO**

Obiettivo:
- verificare il motore su una prima geometria non convessa, mantenendo un solo
  locale e un solo ingresso per isolare l'effetto della concavità;
- riutilizzare i controlli di determinismo e i budget del benchmark F5;
- produrre artifact con nomi distinti da quelli del quadrato 4x4;
- non assimilare questa prova alla strettoia reale di `STRATEGY-001`, che
  richiederà una regressione dedicata successiva.

Criteri di completamento:
- fixture concava e README tracciati;
- benchmark quadrato e concavo eseguiti dal workflow;
- Action riuscita e metriche del caso concavo registrate;
- nessuna modifica ai motori Vittorio/GPT, al frontend o allo schema dati.

Implementazione:
- aggiunti `tests/fixtures/StrategiaDiegoConcaveL.locale.xml` e
  `tests/fixtures/README-StrategiaDiegoConcaveL.md`;
- il perimetro a L introduce una rientranza concava in (3,2), mantenendo un
  solo ingresso dal lato inferiore;
- il benchmark nomina report e SVG in base alla fixture;
- GitHub Actions esegue in sequenza quadrato 4x4 e locale concavo e rende le
  metriche disponibili nel Job Summary e nelle annotazioni del Check Run.

Verifica reale:
- run `36097485997`, build #458, job `107952701779`: **SUCCESS**;
- quadrato 4x4, 20 iterazioni: 104 nodi, 2 terminali accettati, p95 23 ms,
  360.576 byte, deterministico;
- locale concavo a L, 20 iterazioni: 183 nodi, 2 terminali accettati, p95
  48 ms, 720.896 byte, deterministico;
- build e tutti gli smoke test del Service: SUCCESS;
- budget F5 rispettati da entrambe le fixture.

Commit:
- `78f9f3a5b27e2472fee7686d0ac163eec25aa19b` — commissione R1;
- `78b0529ecbbcbe2eda5baa763e74844a9c4ec60e` — fixture e regressione;
- `cabacac1715c97adf01c22596dfd08032e615c10` — esposizione metriche.

Limite successivo:
- costruire una regressione dedicata alla strettoia/imbottigliamento di
  `STRATEGY-001`, senza confonderla con la sola concavità validata in R1.
