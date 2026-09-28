# RECOVERY ACTIVE — Termodel Service

Checkpoint: 2026-09-28 13:35 Europe/Rome
Stato: ATTIVITÀ IN CORSO / RIPRESA DOPO SOSPENSIONE
Branch: `main`
Repository: `Fetonte1960/Termodel`
HEAD tecnico validato prima del presente checkpoint: `a4f478c9a44c7764df45b8ce8b2801938c96fde7`

## Attività corrente

**DV-TEST-002 — Pannelli radianti pubblico: locali rettangolari uno per uno**

Origine della richiesta utente:
- il quadrato base dell'esempio 1 è corretto e deve restare invariato;
- il progetto pubblico **Pannelli radianti** produce geometrie molto errate/non ripetibili su più locali;
- indagare i locali separatamente, iniziando dai rettangolari, usando il Fast Harness;
- applicare soltanto correzioni circoscritte;
- nessuna modifica strutturale o cambio strategia senza accordo umano;
- ogni correzione deve conservare byte/geometricamente il quadrato base.

## Riferimenti autorevoli

- `Server/Termodelwebservice/PROJECT-SUMMARY-SERVICE.md`
- `Server/Termodelwebservice/docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`
- `Server/Termodelwebservice/docs/LOCAL-RADIANT-HARNESS.md`
- `Server/Termodelwebservice/docs/ISTRUZIONI-SOSPENSIONE-CHAT.md`
- fixture condivisa:
  `Server/Termodelwebservice/tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml`

## Vincolo protetto

Quadrato pubblico approvato:
- case: `DV-PUBLIC-SQUARE-LEFT-P030-DIEGO-VITTORIO`
- SVG SHA-256:
  `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`
- punti baseline: 16
- una correzione che modifica questa baseline non può essere consolidata senza nuova approvazione umana.

## Casi rettangolari reali

- `locale_1` — T6 — 3,09 × 5,50 m
- `locale_5` — T1 — 5,43 × 4,24 m
- `locale_8` — T3 — 3,91 × 4,24 m
- `locale_9` — T5 — 2,57 × 4,41 m

Input pubblico estratto dal vero `GeneraModello`:
SHA-256 `15E9F73DEB570F4E17385FF3CD7335916DD8023C69A630925CF083C24A41109A`.

## Fasi

### FASE 1 — estrazione casi reali
Stato: **COMPLETATA**

Risultato:
- estratto il vero `RadiantPanelInputXml`;
- 9 locali classificati, 6 con pannello, 4 rettangolari con pannello;
- aggiunto filtro `localeId/--locale` all'Harness;
- creati i quattro case rettangolari;
- quadrato base protetto da baseline esatta.

Commit principali:
- `3b1193fbdd814af6598a4bf08ba8fd800b7cff1c`
- baseline/test consolidati fino al Fast Harness run `36385818334` SUCCESS.

### FASE 2 — locale_1
Stato: **COMPLETATA TECNICAMENTE**

Causa Return:
- corridoio Supply largo esattamente `2p = 0,60 m`;
- campionamento storico a `p/2` non colpiva l'unica mezzeria valida.

Correzione:
- fallback deterministico sulle coordinate critiche
  `estremo mandata ± distanzaCondizionamento`,
  attivo soltanto se la ricerca precedente fallisce.
- commit `9c0aa251250fd2058e34189b225aa96c3bbd1601`.

Esito Return:
- 6 → 18 punti;
- offset 2 e 3 completati.

Causa chiusura:
- tutte le 35 configurazioni LG-048 dirette fallivano realmente;
- esisteva proiezione ortogonale naturale lunga `2p`.

Correzione:
- fallback di chiusura proiettata solo dopo il fallimento delle configurazioni dirette;
- accettato `M4/RP3`, lunghezza 0,60 m;
- commit finale `401bd0c7e018553800a0378ecdf9a4516a69ccca`.

Regression:
- Fast Harness run `36402218998` SUCCESS;
- `DIEGO_VITTORIO_PUBLIC_PANELS_LOCALE1_OK`;
- `DIEGO_VITTORIO_APPROVED_SQUARE_BASELINE_OK`.

Nota:
- tecnicamente risolto e SVG Harness ispezionato;
- conferma visiva utente nel progetto completo ancora da effettuare.

### FASE 3 — locale_5
Stato: **COMPLETATA TECNICAMENTE**

Causa e correzione Return:
- il collegamento raggiungeva il varco `2p`, ma sovrapponeva all'indietro il terminale Return già occupato;
- commit `ab09475b8afb482b6fa948aebb828f7356ad225e`: trim/sostituzione del solo terminale Return come fallback, senza rilassare autointersezioni o distanze;
- risultato: Return **16 punti**, 3 offset utili completati.

Problema residuo di chiusura:
- LG-048 storico sceglieva `M3/R5`, obliquo, **2,454 m**, rimozione 3,75 m;
- diagnostica completa ha trovato anche `M2/RP3`, ortogonale, **1,24 m**.

Decisione e implementazione:
- l'utente ha autorizzato il cambio circoscritto del criterio LG-048;
- prima prova `aedf756a44beb9039e4faed76fdfda071a031e4f`: preferenza assoluta per la chiusura ortogonale più corta;
- Fast Harness `36405315739`: **FAILED correttamente** sul Golden del quadrato, perché una variazione marginale 0,753 -> 0,740 m ne cambiava l'SVG;
- criterio ristretto nel commit `fb26ed054149a222c54cf706c099af9c066837ea`: il primo candidato storico resta invariato salvo che sia obliquo e una chiusura ortogonale valida riduca la lunghezza di almeno un passo `p`; nessun vincolo geometrico viene rilassato;
- regression `locale_5` aggiunta al Fast Harness nel commit `a6507361ef69fa8dcb7e3520888814abeb2396ec`.

Verifica finale:
- Fast Harness run `36405693422`: **SUCCESS**;
- build Harness + Core: SUCCESS;
- quadrato pubblico byte-identico, SHA-256 `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`;
- `locale_1`: regression SUCCESS, `M4/RP3` 0,60 m invariata;
- `locale_5`: Return 16 punti, `M2/RP3` ortogonale **1,24 m**, regression SUCCESS;
- SVG artifact ispezionato: la precedente diagonale centrale da 2,454 m non è più presente e i livelli interni risultano ordinati.

### FASE 4 — locale_8
Stato: **COMPLETATA TECNICAMENTE**

Causa:
- il Return iniziale conteneva dogleg locali A-B -> B-C -> C-D;
- `SegmentoRispettaSpirale` trattava A-B come ramo remoto rispetto a C-D,
  imponendo `p` anche quando la distanza minima coincideva soltanto con la
  lunghezza del raccordo B-C;
- nel primo dogleg il raccordo è 0,22 m: i rami A-B e C-D non hanno sviluppo
  parallelo sovrapposto e divergono sui lati opposti del raccordo;
- lo stesso schema ricompare fra primo e secondo livello;
- lato Destro e verso di costruzione opposto erano già stati provati e
  peggioravano il risultato.

Diagnostica:
- commit `d10e31d2b02b39b504dcde8db9e0d92f94e09619`: riconoscimento dogleg
  solo sotto flag;
- Fast Harness diagnostico `36406990692`: SUCCESS;
- `locale_8`: 3 -> **18 punti** Return; due dogleg locali riconosciuti;
- SVG ispezionato: percorso ordinato, nessun ramo remoto sovrapposto;
- chiusura `M3/R5`, obliqua, 0,971 m.

Correzione consolidata:
- commit `18cd798a22c72d39d5dfbbfaba647e1e91fdcf5a`: classificazione dogleg
  locale attiva per default;
- rollback: `TERMODEL_DIEGO_VITTORIO_LOCAL_DOGLEG_ADJACENCY=false`;
- la regola si applica soltanto al penultimo ostacolo separato da un unico
  raccordo, quando la distanza minima coincide con la lunghezza del raccordo
  e i due rami divergono sui lati opposti;
- tutti gli altri segmenti mantengono integralmente la distanza minima.

Regression:
- commit `109dac86a8703f8d21b04b6486e00cda0fd49a01`: regression `locale_8`;
- Fast Harness run `36407499506`: **SUCCESS** senza flag diagnostici;
- quadrato approvato byte-identico;
- `locale_1`, `locale_5`, `locale_8` e fitting regression tutti SUCCESS;
- `locale_8`: Return 18 punti, chiusura presente 0,971 m.

### FASE 5 — locale_9
Stato: **COMPLETATA TECNICAMENTE**

Verifica:
- workflow inspection commit `6f4abb6a56ed515ddae776c4ed08c27e9f2dd28b`;
- Fast Harness run `36407962757`: SUCCESS;
- `locale_9`: Return **13 punti**, 2 offset utili, nessun arresto;
- la selezione LG-048 già consolidata usa `M3/RP2`, ortogonale, **0,77 m**
  invece della precedente `M3/R5` obliqua 1,875 m;
- SVG ispezionato: geometria ordinata e chiusura locale;
- nessuna nuova modifica al motore necessaria.

Regression:
- commit `3f055f37132643e4e09b9ec0bc3dc3615b122b75`: regression `locale_9`;
- Fast Harness run `36408292815`: **SUCCESS**;
- quadrato approvato + `locale_1` + `locale_5` + `locale_8` + `locale_9` +
  fitting regression tutti verdi.

### FASE 6 — ricomposizione progetto completo
Stato: **VALIDATA TECNICAMENTE — IN ATTESA DI CONFERMA VISIVA UTENTE**

Verifica completa eseguita:
- commit workflow `a4f478c9a44c7764df45b8ce8b2801938c96fde7`;
- Room Extraction run `36408840730`: **SUCCESS**;
- build Harness + Core: 0 errori;
- vero progetto pubblico ricostruito attraverso `GeneraModello`;
- input estratto SHA-256:
  `15E9F73DEB570F4E17385FF3CD7335916DD8023C69A630925CF083C24A41109A`,
  identico alla fixture reale già consolidata;
- verifiche sul progetto reale:
  - `locale_1`: Return 18 punti, `M4/RP3` ortogonale 0,60 m;
  - `locale_5`: Return 16 punti, `M2/RP3` ortogonale 1,24 m;
  - `locale_8`: Return 18 punti, `M3/R5` obliqua 0,971 m;
  - `locale_9`: Return 13 punti, `M3/RP2` ortogonale 0,77 m;
- marker workflow `FULL_PROJECT_RECTANGULAR_REGRESSION_OK`;
- artifact finale `diego-vittorio-room-extraction` prodotto e ispezionato;
- SVG dei quattro rettangolari ispezionati: geometrie ordinate, nessuna
  ricomparsa della diagonale patologica di `locale_5`.

Anomalia esterna alla presente campagna:
- durante `GeneraModello` compaiono messaggi
  `Il valore 'Solaio piano' non è un numero intero valido per il colore della copertura`;
- il workflow e le regression pannelli restano SUCCESS;
- non viene corretta in DV-TEST-002 perché non riguarda il motore spirali.

**PROSSIMO PASSO ESATTO:**
1. l'utente apre il progetto pubblico `Pannelli radianti` sul frontend aggiornato;
2. esegue `Aggiorna Modello` e visualizza l'esecutivo pannelli;
3. conferma se il risultato complessivo è visivamente corretto;
4. solo dopo conferma positiva aggiornare registri permanenti finali,
   notificare la conclusione sulla issue #1 e rimuovere
   `RECOVERY-ACTIVE.md`;
5. in caso di anomalia, conservare screenshot/caso e riaprire soltanto il
   locale o la geometria effettivamente difettosa.

## Sottofase FASE 6A — provenienza visibile dell'esecutivo CAD2D
Stato: **COMPLETATA TECNICAMENTE — ATTESA SOLA VERIFICA VISIVA UTENTE**

Origine richiesta utente:
- prima del collaudo finale, rendere immediatamente visibile nel CAD2D / Disegno esecutivo chi ha generato il disegno;
- indicare se l'esecutivo è consolidato nell'esempio oppure calcolato dal Service corrente;
- mostrare motore spirali e versione/commit del Service;
- mantenere la zona informativa discreta e non interferente con il disegno.

Provenienza storica verificata:
- gli esecutivi statici degli esempi furono generati dal vero Termodel WebService nel workflow run `36301010185`, sul commit sorgente `aba9bd293936396c9861f521d5ffebdb0fe8b769`;
- il motore usato era `GPT / SpiraliGPT`;
- i file furono consolidati nel catalogo pubblico dal commit `9a4c0b7d982ea42c1b73a4a5a36975935d1bfece` del 27/09/2026;
- per gli esecutivi runtime la fonte autorevole è `GET /health` del Service corrente (`serviceCommit`, `spiralEngine`).

Implementazione:
- frontend portato a **v1.34**;
- commit funzionale `b33ffcc9f505c3dc9ac06c1d405f7b7e732b57e0`;
- fix cache-busting `e694e191542bbdc133d552b879b35d1fb933998d`;
- allineamento regression identità Service `90bb914e7bcdb0cff17d9bd19d1bf2701ccf8424`;
- aggiunto box discreto `cadExecutiveProvenance`, esterno all'SVG e quindi senza modificare la geometria;
- esempio statico: mostra `CONSOLIDATO NELL'ESEMPIO`, generatore, motore, commit Service di generazione, commit/data di consolidamento;
- artifact runtime: mostra `CALCOLO CORRENTE · NON CONSOLIDATO`, generatore, motore e commit reali del Service letti da `/health`, oltre al projectId e allo stato stale;
- metadata storici aggiunti a `examples/catalog.json`;
- nessuna modifica a Core, motore spirali, SVG esecutivi o `definizionedati.json`.

Verifica:
- run finale `36411206078`:
  - JavaScript syntax: **SUCCESS**;
  - `CAD_EXECUTIVE_PROVENANCE_OK`: **SUCCESS**;
  - build Service: **SUCCESS**, 0 errori;
  - smoke progetto pubblico Pannelli radianti: **SUCCESS**;
- il workflow complessivo termina rosso soltanto sul Golden Darcy sintetico già noto e indipendente: dP corrente 1,313675 Pa contro golden storico 1,343675 Pa; non è causato né toccato dalla FASE 6A;
- GitHub Pages run `36411205191`: build + deploy **SUCCESS**;
- verifica HTTP diretta del dominio non disponibile dallo strumento di questa sessione: la prova visuale browser resta umana.

Vincoli rispettati:
- nessuna modifica al motore geometrico;
- nessuna modifica a `definizionedati.json`;
- nessuna alterazione dell'SVG esecutivo;
- la FASE 6 principale resta tecnicamente validata e in attesa del collaudo visivo utente.

**PROSSIMO PASSO ESATTO:**
1. aprire il frontend v1.34 e l'esempio `Pannelli radianti`;
2. in `Disegno esecutivo` verificare che il box indichi chiaramente lo statico consolidato GPT/SpiraliGPT;
3. eseguire `Aggiorna Modello` e verificare che lo stesso box passi a `CALCOLO CORRENTE · NON CONSOLIDATO` mostrando il motore e commit Service correnti;
4. proseguire quindi con la conferma visiva finale della FASE 6.

## Sottofase FASE 6B — congelamento esecutivi Diego_Vittorio negli esempi
Stato: **COMPLETATA**

Decisione utente 28/09/2026:
- il nuovo esecutivo `Pannelli radianti` mostrato dal Service corrente è giudicato sicuramente migliorativo;
- congelati gli esecutivi dei due esempi pubblici:
  - `Pannelli radianti`;
  - `Quadrato con pannelli`;
- l'ispezione degli esempi non richiede più un calcolo Service;
- `Aggiorna Modello` resta disponibile per produrre un nuovo esecutivo runtime e confrontarlo col consolidato.

Asset congelati:
- commit asset `e0121145ca88014edb6204e2d97bf99366497989`;
- `Pannelli radianti`:
  - sorgente artifact run `36411641717`;
  - Service/head `e23f3a6698f0166a6752fbdd3aac5fd6346cada7`;
  - motore `Diego_Vittorio`;
  - SHA-256 statico `6a1c79ed23b8dcfde6fcffb484a029f54d5355793b32422e30c6e19cca0f2a3d`;
- `Quadrato con pannelli`:
  - sorgente workflow pubblico run `36383027266`;
  - Service/head `5de2ccab955dd3146ee23089afe41fb9040eb3ac`;
  - motore `Diego_Vittorio`;
  - SHA-256 statico `1cd73beba29edb1c44adc7dd4719123872ed58de5f9f5c901a88f39a3f52f8f6`;
  - baseline Harness umana protetta `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`.

Frontend:
- versione portata a **v1.35** nel commit `ed87c6ad59cd60d008e7ffe2ed13885bea3dcaf3`;
- `loadProjectBrowserExamples()` trasferisce ora anche `executiveProvenance`;
- il badge dello statico mostra quindi correttamente `CONSOLIDATO NELL'ESEMPIO`, motore Diego_Vittorio, commit Service sorgente e commit di consolidamento;
- catalogo aggiornato con provenance separata per i due esempi;
- il workflow temporaneo usato esclusivamente per trasferire gli artifact è stato rimosso nello stesso commit v1.35.

Verifica:
- workflow di trasferimento `36414320457`: **SUCCESS**, inclusa verifica SHA-256 dei due artifact prima del commit;
- TermodelService Build `36414512616`:
  - sintassi JavaScript: **SUCCESS**;
  - `CAD_EXECUTIVE_PROVENANCE_OK`: **SUCCESS**;
  - `RADIANT_STATIC_EXECUTIVES_OK`: **SUCCESS**;
  - `RADIANT_PUBLIC_EXAMPLE_OK`: **SUCCESS**;
  - build: **SUCCESS**, 0 errori;
  - smoke progetto pubblico `Pannelli radianti`: **SUCCESS**;
  - `RADIANT_REFERENCE_PROJECT_OK`: **SUCCESS**;
  - il workflow termina poi rosso esclusivamente sul Golden Darcy sintetico già noto e indipendente: dP corrente 1,3136749 Pa contro golden storico 1,343675 Pa;
- GitHub Pages run `36414512118`: build + deploy **SUCCESS**.

Vincoli rispettati:
- nessuna modifica a Termodel.Core o al motore;
- nessuna modifica a `definizionedati.json`;
- nessuna modifica ai progetti di input;
- modificati solo gli output SVG statici, catalogo/provenienza e wiring frontend necessario a mostrarla.

**PROSSIMO PASSO ESATTO:**
1. aprire `Quadrato con pannelli` e `Pannelli radianti` dal catalogo senza premere `Aggiorna Modello`;
2. verificare che `Disegno esecutivo` sia subito disponibile e che il badge riporti `CONSOLIDATO NELL'ESEMPIO` + `Diego_Vittorio`;
3. riprendere quindi il collaudo geometrico della FASE 6 usando questi due statici come riferimenti rapidi.

## Sottofase FASE 6C — diagnosi mandata Supply prima di Return/chiusura
Stato: **IN CORSO — 6C.1/6C.2 COMPLETATE, 6C.3 IN CORSO**

Origine utente 28/09/2026:
- partendo dall'esecutivo `Pannelli radianti` congelato e approvato come migliorativo,
  si osserva un'anomalia quasi generalizzata: l'evoluzione della spirale di
  **mandata rossa** sembra arrestarsi prima del previsto;
- indagare in modalità Harness;
- ignorare esplicitamente Return e chiusura LG-048 durante la diagnosi;
- seguire il protocollo recovery e registrare ogni checkpoint.

Obiettivo tecnico:
- osservare la polilinea Supply grezza nel punto immediatamente precedente alla
  costruzione del Return e alla chiusura;
- misurare locale per locale quanti offset/livelli Supply vengono costruiti;
- per ogni arresto identificare il primo livello non prodotto e la causa
  concreta di rifiuto/assenza geometrica;
- distinguere errore di generazione Supply da effetti successivi di Return o
  LG-048, che in questa fase non devono influenzare la diagnosi.

### 6C.1 — strumentazione diagnostica Supply
Stato: **COMPLETATA**

Commit:
- `b2d9511a2721637bddeb838272163ca15e255513`.

Implementazione diagnostica:
- aggiunto `Program.AggiornaSoloMandata(p)`, che esegue esclusivamente
  `GeneraSpirale` e non richiama `ChiudiSpiraleFiles`;
- Harness: nuova opzione `--supply-only`, valida soltanto per
  `Diego_Vittorio`;
- benchmark: `StrategiaDiegoVittorioBenchmark.RunSupplyOnly`;
- trace non invasivo `DV_SUPPLY_*` per generazione offset e percorrenza;
- nessun criterio geometrico produttivo modificato.

Verifica:
- Fast Harness run `36416240750`, job `108907958748`: **SUCCESS**;
- build Harness + Core SUCCESS;
- tutte le regression preesistenti SUCCESS;
- quadrato approvato byte-identico:
  `fa8e61061050a1f18026b3d2150270c013d2b4ca1d72e1f72f5fb7c21375fa39`.

### 6C.2 — matrice locale-per-locale
Stato: **COMPLETATA**

Input condiviso:
`tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml`.

Risultati Supply-only, prima di Return/LG-048:

- **quadrato pubblico di controllo**
  - offset utili: 3;
  - minEdge: 3,44 -> 2,24 -> 1,04 m;
  - livello 4: `invalid-offset`, 0 punti;
  - Supply: 16 punti;
  - tutti gli offset ammessi vengono percorsi e finalizzati correttamente.

- **locale_1**
  - offset utili: 2;
  - minEdge: 2,79 -> 1,59 m;
  - livello 3: `invalid-offset`, 0 punti;
  - Supply: 13 punti;
  - SVG SHA-256:
    `c4abe23db71675c15c17d2322a081020e54b54215390fed8b03302bf45d2ee46`.

- **locale_2**
  - offset utile: 1;
  - livello 2 calcolato con 6 punti e minEdge **0,36 m**;
  - rifiuto: `min-edge-below-step`, soglia 0,60 m;
  - Supply: 8 punti;
  - SVG SHA-256:
    `a8d8dfa2f5888a96e574502f38f241e278653909b73cf3863861ba8f3eb888c0`.

- **locale_5**
  - offset utili: 3;
  - minEdge: 3,94 -> 2,74 -> 1,54 m;
  - livello 4: `invalid-offset`, 0 punti;
  - Supply: 17 punti;
  - SVG SHA-256:
    `1ec390739cfeed733746ff4846492e2ae73428775a18a557ef7066190a2e0a59`.

- **locale_6**
  - offset utile: 1;
  - livello 2 calcolato con 6 punti e minEdge **0,29 m**;
  - rifiuto: `min-edge-below-step`, soglia 0,60 m;
  - Supply: 8 punti;
  - SVG SHA-256:
    `0130cb668972ec9be246343f2c44eb731508a681539984d9f7ad6e86b250d260`.

- **locale_8**
  - offset utili: 3;
  - minEdge: 3,61 -> 2,41 -> 1,21 m;
  - livello 4: `invalid-offset`, 0 punti;
  - Supply: 18 punti;
  - SVG SHA-256:
    `4a777551785a46e5504d4fcc71cc50926dae38d7b131fe5d8e0f7b90ebd06d00`.

- **locale_9**
  - offset utili: 2;
  - minEdge: 2,27 -> 1,07 m;
  - livello 3: `invalid-offset`, 0 punti;
  - Supply: 13 punti;
  - SVG SHA-256:
    `91911b1160a8f91f5af560f9caa554e97c0af3dbbd999d20ab0c401616469454`.

Conclusioni accertate:
- l'arresto osservato dall'utente **esiste già nella Supply grezza**:
  Return e LG-048 sono esclusi come causa;
- non si osservano fallimenti di collegamento/percorrenza sugli offset ammessi:
  tutti i livelli accettati vengono percorsi e finalizzati;
- l'arresto avviene nella **generazione/ammissione del livello interno successivo**;
- per `locale_2` e `locale_6` il livello successivo esiste come poligono
  a 6 vertici, ma viene respinto globalmente perché un singolo lato misura
  rispettivamente 0,36 m e 0,29 m contro `passoMandata = 0,60 m`;
- per i rettangolari `locale_1/5/8/9` il livello successivo collassa già in
  `ComputeOffset` e torna nullo/vuoto;
- anche il quadrato approvato termina con un successivo offset invalido:
  quindi il solo fatto che non esista un altro **anello chiuso completo** non
  implica automaticamente un errore; va verificato se resta invece un
  avanzamento Supply parziale utile verso il centro;
- ipotesi corrente: il generatore Supply è quantizzato per anelli chiusi
  completi e manca un percorso terminale/parziale dopo l'ultimo anello valido;
  nei concavi 2/6 il filtro `minEdgeLength < passoMandata` dimostra già che
  un intero offset viene scartato per un solo lato corto;
- inoltre la finalizzazione di ogni offset arretra il terminale di un intero
  `passoMandata`; questo può contribuire alla sensazione di Supply corta e
  deve essere misurato separatamente.

### 6C.3 — causa comune
Stato: **IN CORSO**

Prossima diagnostica:
1. strumentare `ComputeOffset` / `FixIntersections` per distinguere perché
   i rettangolari producono `invalid-offset`;
2. sui concavi 2/6 identificare esattamente il lato corto che provoca il
   rifiuto globale e verificare quale porzione del livello resterebbe
   geometricamente percorribile;
3. misurare la finalizzazione dell'ultimo offset:
   terminale prima del rientro, terminale dopo il rientro, distanza sottratta;
4. verificare, senza applicarlo, se dopo l'ultimo offset completo esiste un
   segmento/percorso Supply parziale valido verso l'interno.

### 6C.4 — proposta circoscritta
Stato: **BLOCCATA FINO ALLA DIAGNOSI**

Nessuna modifica strategica viene applicata senza evidenza Harness e nuova
autorizzazione umana.

### 6C.5 — regression e ricomposizione
Stato: **NON INIZIATA**

Vincoli:
- durante 6C.3 non modificare la geometria produttiva;
- non usare Return o LG-048 per spiegare/arbitrare l'arresto Supply;
- `SpiraliVittorio` invariata;
- quadrato approvato invariato;
- nessuna modifica frontend;
- nessuna modifica a `definizionedati.json`;
- usare il Fast/Local Harness come percorso primario;
- ogni nuova evidenza significativa aggiorna questo recovery e issue #1.

**PROSSIMO PASSO ESATTO:** aggiungere esclusivamente diagnostica a
`ComputeOffset`/finalizzazione Supply e rieseguire la matrice per determinare
se l'assenza di un anello completo sta nascondendo un percorso terminale
parziale ancora valido.

## File/componenti attualmente coinvolti

- `src/Termodel.Core/CopiedFromTermodel/SpiraliDiegoVittorio/Spiralgenerator.cs`
- `src/Termodel.Core/CopiedFromTermodel/SpiraliDiegoVittorio/ChiudiSpirale.cs`
- `tools/Termodel.RadiantPanels.Harness/`
- `tests/radiant-harness/`
- `.github/workflows/termodel-diego-vittorio-fast.yml`
- `.github/workflows/termodel-diego-vittorio-room-extraction.yml`
- linee guida spirali e Summary Service.

## Vincoli da non violare

- `SpiraliVittorio` invariata.
- `StrategiaDiego` resta PARKED.
- Nessuna ulteriore modifica frontend, salvo interventi esplicitamente autorizzati come FASE 6A.
- Nessuna modifica a `definizionedati.json`.
- Nessun refactoring strutturale durante questa campagna.
- Nessuna strategia globale di fuga/backtracking senza consenso umano.
- Ogni correzione deve attivarsi solo nei casi non risolti dal percorso
  precedente, quando tecnicamente possibile.
- Il quadrato base deve restare byte/geometricamente invariato.
- Procedere **un locale alla volta**.

## Criteri di conclusione dell'attività

- i quattro locali rettangolari con pannello sono stati analizzati uno per uno;
- ogni locale ritenuto risolto ha una regression dedicata;
- il quadrato base resta invariato;
- Fast Harness complessivo verde;
- linee guida e Summary aggiornati con cause/correzioni realmente verificate;
- progetto completo rieseguito e sottoposto a conferma visiva utente;
- Issue #1 notificata con esito finale;
- solo allora eliminare questo file `RECOVERY-ACTIVE.md`.
