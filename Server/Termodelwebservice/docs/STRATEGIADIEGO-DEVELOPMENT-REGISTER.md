# STRATEGIADIEGO — REGISTRO DI SVILUPPO

Data avvio: **25/09/2026**  
Stato generale: **IN CORSO**

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
Stato: **COMMISSIONATO**

Obiettivo:
- quando un nodo Diego sta seguendo un segmento di tubo gia' appartenente al
  path, usare il suo `SequenceIndex` per individuare il successore
  `S_k+1`;
- per i rami paralleli, il successore deve essere il riferimento di troncatura
  strategico quando esiste;
- `PROSEGUI_DRITTO` resta un'alternativa separata e continua a escludere la
  linea che ha appena troncato il tratto precedente;
- nessuna modifica ai motori Vittorio/GPT.

## F5 — Batteria benchmark GitHub Actions
Stato: **COMMISSIONATO**

Obiettivo:
- test funzionali e ripetuti;
- metriche: nodi mandata, terminali mandata, nodi ritorno, terminali complessivi,
  profondità, tempo, memoria;
- giudizio di sostenibilità basato su misure, non ipotesi.

## F6 — Consolidamento finale
Stato: **COMMISSIONATO**

Obiettivo:
- aggiornare Summary, linee guida, registro e risultati;
- distinguere implementato/compilato/eseguito/testato.
