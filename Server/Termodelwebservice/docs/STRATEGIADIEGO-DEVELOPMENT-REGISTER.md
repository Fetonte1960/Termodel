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
Stato: **COMMISSIONATO**

Obiettivo:
- aggiungere Diego nel Core;
- preservare GPT e Vittorio come motori distinti;
- selezione esplicita senza cambio silenzioso del default.

## F3 — Build reale
Stato: **COMMISSIONATO**

Obiettivo:
- compilazione Release della soluzione tramite GitHub Actions;
- applicazione protocollo `Termodel/job RUNNING -> SUCCESS/FAILED` e notifica telefono.

## F4 — Fixture quadrato 4x4 m / unico tubo entrante
Stato: **COMMISSIONATO**

Obiettivo:
- fixture minima riproducibile e leggibile;
- input unico e risultato Diego diagnosticabile.

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
