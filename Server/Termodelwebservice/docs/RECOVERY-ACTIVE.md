# RECOVERY ACTIVE — Termodel Service

Checkpoint: 2026-09-28 14:43 Europe/Rome
Stato: ATTIVITÀ IN CORSO / RIPRESA DOPO SOSPENSIONE
Branch: `main`
Repository: `Fetonte1960/Termodel`
HEAD tecnico validato: `49f28610128096e87db27fbea58f5d7f73f9d27d`
HEAD documentale prima del presente checkpoint: `4c79d1ad8bad407d9998bc2605f4e943cf5ffffa`

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
Stato: **DIAGNOSI GENERALE COMPLETATA — PROPOSTA 6C.4 RESPINTA — INDAGINE LOCALE_1 IN CORSO**

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
Stato: **COMPLETATA**

Diagnostica aggiuntiva:
- commit `466da9d141799ec2bcd548a83c1293ccd86b4543`: trace `ComputeOffset` + finalizzazione Supply; prima esecuzione non compilata esclusivamente per `CultureInfo` mancante nel codice diagnostico;
- fix solo diagnostico `3bc7fae41e643a3baa1273a5cc3694da04d7ebb7`;
- Fast Harness run `36417080491`, job `108910674388`: **SUCCESS**;
- tutte le regression preesistenti, incluso il quadrato approvato, SUCCESS.
- Summary Service aggiornato nel commit `4e0ff119c744aa87ff07b04a7a6393f34d5e3004`;
- linee guida spirali aggiornate nel commit `4c79d1ad8bad407d9998bc2605f4e943cf5ffffa`.

Confronto col riferimento Desktop:
- `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Spiralgenerator.cs` contiene sia la stessa logica `ComputeOffset` con `skipIndices`, sia la stessa finalizzazione storica del giro;
- l'anomalia è quindi **ereditata dalla strategia storica** e non introdotta dalle recenti correzioni Return/LG-048 di `Diego_Vittorio`.

Causa comune accertata:
- la Supply storica evolve esclusivamente per **anelli chiusi completi**;
- quando il successivo anello completo non è più ammissibile, non esiste una fase terminale che trasformi lo spazio residuo in un asse/ramo parziale verso il centro;
- per i rettangoli `ComputeOffset` marca un lato come corto quando `edgeLength <= 3 * passoMandata` e il lato si è ridotto di oltre un passo; i due vertici del lato vengono esclusi;
- se i due lati opposti corti soddisfano la condizione, gli `skipIndices` eliminano tutti e quattro i vertici e `ComputeOffset` restituisce `null`, anche se può esistere un singolo asse centrale ancora rispettoso della distanza Supply-Supply.

Con `passoMandata = 0,60 m`:
- un solo asse centrale richiede lato corto dell'ultimo anello >= `2 * passoMandata = 1,20 m`;
- un ulteriore anello completo richiede invece spazio per due nuovi lati paralleli e viene escluso dal criterio storico prima del collasso.

Matrice ultimo anello completo:
- quadrato approvato: lato corto **1,04 m**, semilarghezza 0,52 m -> asse centrale **non ammissibile**;
- `locale_1`: lato corto **1,59 m**, semilarghezza 0,795 m -> asse centrale possibile; residuo teorico **2,80 m**;
- `locale_5`: lato corto **1,54 m**, semilarghezza 0,77 m -> asse centrale possibile; residuo teorico **1,53 m**;
- `locale_8`: lato corto **1,21 m**, semilarghezza 0,605 m -> asse centrale appena possibile; residuo teorico **0,34 m**;
- `locale_9`: lato corto **1,07 m**, semilarghezza 0,535 m -> asse centrale non ammissibile.

Manifestazione concava dello stesso limite tutto-o-niente:
- `locale_2`: il livello successivo ha 6 vertici; dopo `FixIntersections` conserva più lati lunghi ma contiene un lato da **0,36 m** e il lato di chiusura collassa a **0,00 m**; il filtro globale scarta l'intero livello;
- `locale_6`: il livello successivo ha 6 vertici e cinque lati >= 0,60 m, ma un solo lato da **0,29 m** fa scartare l'intero livello;
- per i concavi è dimostrato il rifiuto globale di una geometria parzialmente ancora sviluppabile, ma non è ancora autorizzata né definita una strategia locale di riduzione/scheletro.

Secondaria anomalia diagnostica:
- il calcolo storico `minEdgeLength` usa `j < nextOffset.Count - 1` e quindi non misura il lato di chiusura ultimo->primo;
- in `locale_2` quel lato vale 0 dopo `FixIntersections`;
- il caso viene comunque scartato per il lato da 0,36 m, quindi questa omissione non causa l'arresto corrente ma resta registrata.

Finalizzazione Supply chiarita:
- la regola storica lascia un'apertura di `passoMandata = 0,60 m` rispetto al punto di ingresso del giro, per permettere il passaggio al livello successivo;
- i grandi valori misurati come spostamento del terminale non sono metri di percorso cancellati: il tratto di chiusura viene percorso fino al nuovo terminale e resta un'apertura finale di 0,60 m;
- sull'ultimo anello l'apertura resta inutilizzata perché manca la fase terminale/parziale; è quindi un punto naturale da cui innestare una futura prosecuzione centrale, non una causa primaria separata.

Conclusione 6C.3:
- Return e LG-048 restano esclusi;
- la causa primaria della mandata corta è la strategia **anelli chiusi completi oppure stop**, senza terminale mediale/parziale;
- per i rettangoli esiste un criterio locale misurabile che può migliorare `locale_1/5/8` senza attivarsi sul quadrato approvato o su `locale_9`;
- i concavi 2/6 richiedono una seconda strategia e non devono essere inclusi implicitamente nella prima correzione.
### 6C.4 — proposta circoscritta
Stato: **RESPINTA DALL'UTENTE — NON IMPLEMENTARE**

Decisione utente 28/09/2026:
- esclusa esplicitamente la scorciatoia dell'asse terminale centrale;
- non correggere l'effetto dopo l'aborto;
- indagare invece le cause dell'**aborto spontaneo della mandata**;
- lavorare step by step;
- discutere **un solo caso alla volta**;
- primo e unico caso corrente: `locale_1`;
- per ogni passo documentare quale codice ha lavorato, in quale contesto, quale decisione ha preso e perché ha fallito.

Conseguenza:
- ogni ipotesi/prototipo di asse centrale terminale è archiviato come **non autorizzato**;
- nessuna modifica geometrica verrà introdotta finché non sarà compreso il fallimento interno di `locale_1`.
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

**PROSSIMO PASSO ESATTO:** FASE 6D su `locale_1` soltanto; ricostruire il percorso di chiamata e il calcolo del livello 3 in `ComputeOffset`, senza alcuna modifica geometrica.

## FASE 6D — autopsia Supply `locale_1`
Stato: **IN CORSO — STEP 1/2/3 COMPLETATI**

Ambito rigidamente limitato:
- unico caso: `locale_1` della fixture reale
  `tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml`;
- ingresso reale: `T6`;
- geometria locale XML: 5 vertici utili + chiusura, con un vertice intermedio
  collineare sul lato destro;
- geometria usata dal generatore dopo normalizzazione: rettangolo 3,09 × 5,50 m;
- passo `p = 0,30 m`;
- `distanzaParete = p/2 = 0,15 m`;
- `passoMandata = 2p = 0,60 m`;
- Return, LG-048, raccordi finali e altri locali sono fuori discussione.

### STEP 1 — percorso di chiamata reale
Stato: **COMPLETATO**

Catena verificata:
1. Harness `Run` legge l'intera fixture reale.
2. `SelectSingleLocale` elimina soltanto gli altri elementi `<Locale>`;
   **non elimina né ricostruisce le linee T1..T12**.
3. per `--engine Diego_Vittorio --supply-only` il banco chiama
   `RunCopiedSpiralStrategy`.
4. `StrategiaDiegoVittorioBenchmark.RunSupplyOnly` crea il workspace
   temporaneo e chiama `Program.AggiornaSoloMandata(0.30)`.
5. `AggiornaSoloMandata` deriva:
   - parete = 0,15 m;
   - Supply-Supply = 0,60 m;
   - Return = 0,30 m, non usato in supply-only;
   e chiama `GeneraSpirale(... traceSupply:true)` senza `ChiudiSpiraleFiles`.
6. `GeneraSpirale` seleziona realmente `T6`, calcola l'intersezione col
   perimetro e passa a `SpiralGenerator.Generate`:
   - start = `(1,5700000000000003 ; 4,74316)`;
   - distanzaParete = 0,15;
   - passoMandata = 0,60;
   - `lineeCondizionamento = null`, quindi nessun Return condiziona la Supply.

Conclusione STEP 1:
- il caso Harness riproduce il percorso Supply produttivo;
- non è una geometria sintetica né ricostruita;
- Return e LG-048 sono effettivamente esclusi.

### STEP 2 — normalizzazione del perimetro
Stato: **COMPLETATO**

Input XML `locale_1` dopo arrotondamento a 2 decimali:
- `(-1,52 ; -0,08)`;
- `(-1,52 ; 5,42)`;
- `(1,57 ; 5,42)`;
- `(1,57 ; 4,29)`;
- `(1,57 ; -0,08)`;
- chiusura sul primo punto.

`RoundAndSnapVertices` arrotonda e allinea coordinate quasi uguali.
Il duplicato finale viene rimosso.
`RemoveCollinearVertices` elimina `(1,57 ; 4,29)` perché è esattamente
collineare fra `(1,57 ; 5,42)` e `(1,57 ; -0,08)`.
`EnsureCounterClockwise` inverte solo l'ordine di percorrenza.

Perimetro effettivamente passato agli offset:
- A `(1,57 ; -0,08)`;
- B `(1,57 ; 5,42)`;
- C `(-1,52 ; 5,42)`;
- D `(-1,52 ; -0,08)`.

Conclusione STEP 2:
- nessuna geometria significativa viene persa prima dell'aborto;
- `locale_1` arriva a `ComputeOffset` come rettangolo ortogonale regolare
  3,09 × 5,50 m.

### STEP 3 — ricostruzione dell'aborto in `ComputeOffset`
Stato: **COMPLETATO**

Codice coinvolto:
`SpiraliDiegoVittorio/Spiralgenerator.cs`, ciclo offset e
`ComputeOffset(polygon, polygon_pre, offset, ...)`.

Livello 1:
- offset richiesto 0,15 m;
- nessun lato viene marcato `skip`;
- risultato 4 vertici, rettangolo 2,79 × 5,20 m;
- livello accettato.

Livello 2:
- offset richiesto 0,60 m;
- rettangolo corrente 2,79 × 5,20 m;
- confronto col precedente 3,09 × 5,50 m;
- shrink osservato 0,30 m;
- nessun lato soddisfa la soglia di skip;
- risultato 4 vertici, rettangolo 1,59 × 4,00 m;
- livello accettato.

Livello 3 — punto esatto dell'aborto:
- offset richiesto 0,60 m;
- poligono corrente:
  - edge 0 = 4,00 m;
  - edge 1 = 1,59 m;
  - edge 2 = 4,00 m;
  - edge 3 = 1,59 m;
- poligono precedente:
  - lati corrispondenti 5,20 / 2,79 / 5,20 / 2,79 m;
- shrink = circa 1,20 m su tutti i lati.

Regola storica:
`skip = edgeLength <= offset * 3 && (edgeLength_pre - edgeLength) > offset`.

Con `offset = 0,60`:
- soglia `offset * 3 = 1,80 m`;
- edge 1: 1,59 <= 1,80 e shrink 1,20 > 0,60 -> `skip=true`;
  vengono aggiunti `skipIndices {1,2}`;
- edge 3: 1,59 <= 1,80 e shrink 1,20 > 0,60 -> `skip=true`;
  vengono aggiunti `skipIndices {3,0}`;
- unione: `{0,1,2,3}`;
- seconda passata: **tutti i vertici vengono saltati**;
- `result.Count = 0` -> `ComputeOffset` restituisce `null`;
- ciclo superiore emette `reason=invalid-offset` e interrompe la generazione.

Fatto nuovo importante:
- il trace diagnostico calcola anche i candidati che il codice produttivo
  evita di creare;
- senza applicare gli skip, il livello 3 sarebbe ancora un rettangolo
  geometricamente finito **0,39 × 2,80 m**;
- coordinate teoriche:
  - `(0,22 ; 1,27)`;
  - `(0,22 ; 4,07)`;
  - `(-0,17 ; 4,07)`;
  - `(-0,17 ; 1,27)`.

Quindi:
- l'aborto **non deriva da un fallimento numerico di ComputeOffset**;
- l'aborto è causato intenzionalmente dalla regola preventiva dei
  `skipIndices`, prima che `FixIntersections`, `NormalizePolygon` o la
  percorrenza possano esaminare il terzo offset;
- il codice non prova a validare il poligono 0,39 × 2,80: lo sopprime a monte.

### Decisione metodo diagnostico — logging categorizzato
Stato: **IMPLEMENTATA E VERIFICATA**

Decisione 28/09/2026:
- non introdurre snapshot JSON o un secondo sistema di debug;
- riusare `Termodel.utilities.TermodelLog`, già adottato dal Service;
- categoria permanente Service/Core `SpiraliDiegoVittorio`, controllabile
  con gli stessi parametri generali `logEnabled/logCategories`;
- sottotag testuali stabili per il contesto Supply;
- l'Harness abilita la stessa categoria con
  `--log-enabled true --log-categories SpiraliDiegoVittorio` e riversa
  `TermodelLog.Messages` nel consueto `.log.txt`;
- dopo ogni elaborazione si legge il log; se manca una variabile necessaria,
  si aggiunge esclusivamente quel punto di log e si riesegue;
- unico caso corrente sempre `locale_1`.

Implementazione:
- commit `e35f05099179aae5f1af6df80527c00d0704c1c5`:
  - aggiunta `LogCategory.SpiraliDiegoVittorio` nell'adattatore headless;
  - collegato `Program` / `SpiralGenerator` a `TermodelLog` senza modificare
    la Library Desktop;
  - benchmark/Harness accettano la configurazione log;
  - eventi permanenti iniziali: `Supply.Context`, `Supply.Generate.Begin`,
    `Supply.Offset.Begin`, `Supply.ComputeOffset.Edge`,
    `Supply.ComputeOffset.Vertex`, `Supply.ComputeOffset.Result`,
    `Supply.ComputeOffset.Raw`, `Supply.Offset.Candidate`,
    `Supply.Offset.Accept`, `Supply.Offset.Stop`, `Supply.Result`;
  - `logCategories=all` del Service aggiornato da 10 a 11 categorie;
- Fast Harness run `36422697579`, job `108929052555`: **SUCCESS**;
  il log categorizzato di `locale_1` riproduce integralmente l'aborto L3;
- dopo lettura del primo log mancava il percorso reale dell'ultimo offset;
  come da protocollo è stato aggiunto soltanto quel dettaglio;
- commit `49f28610128096e87db27fbea58f5d7f73f9d27d`:
  `Supply.Traverse.Connection`, `Supply.Traverse.Candidate`,
  `Supply.Traverse.Accept`, `Supply.Finalize.Plan`,
  `Supply.Finalize.Result`, `Supply.Traverse.End`;
- Fast Harness run `36423105809`, job `108930409465`: **SUCCESS**;
- tutte le regression Fast Diego_Vittorio sono rimaste verdi.

Verifica Service:
- TermodelService Build run `36423105927`: build **0 errori**,
  public Pannelli radianti model3d SUCCESS;
- il nuovo `logCategories=all` con 11 categorie viene eseguito nel medesimo
  smoke; il workflow si arresta successivamente sul Golden Darcy sintetico
  già noto e indipendente:
  `dP=1,31367490344266 Pa` contro golden `1,343675 Pa`;
- nessuna geometria, tolleranza o regola del motore è stata modificata.

Obiettivo metodologico raggiunto:
il log esistente è ora il corrispettivo remoto e ripetibile della sessione
Watch/Locals di Visual Studio per `Diego_Vittorio`, senza infrastruttura
diagnostica parallela.

### STEP 4 — significato del limite e stato reale dell'ultimo anello
Stato: **IN CORSO — PRIMA PARTE CHIARITA**

#### 4A — cosa protegge `3 * offset`

Sul solo `locale_1`:
- ultimo rettangolo accettato: 1,59 × 4,00 m;
- tentativo successivo a `offset=0,60`: raw 0,39 × 2,80 m;
- per un rettangolo vale `nuova_larghezza = larghezza_corrente - 2*offset`;
- chiedere `larghezza_corrente > 3*offset` equivale a chiedere che la
  nuova larghezza resti maggiore di `offset`;
- il raw L3 avrebbe due rami Supply paralleli distanti **0,39 m**, quindi
  meno dei **0,60 m** richiesti.

Conclusione 4A:
- il fattore `3*offset` non è casuale nel rettangolo;
- un **anello chiuso completo** L3 da 0,39 × 2,80 m non è ammissibile come
  nuovo giro Supply completo;
- anche bypassando `skipIndices`, il successivo controllo storico
  `minEdgeLength < passoMandata` respingerebbe indipendentemente il lato
  da 0,39 m;
- pertanto non va rimossa semplicemente la protezione e non va forzato il
  rettangolo L3.

#### 4B — limite strutturale da indagare

Il codice genera la lista degli offset chiusi **prima** di costruire la
polilinea reale:
- `SpiralGenerator.Generate`, blocco pre-generazione offset circa righe
  333–452;
- solo dopo, da circa riga 464, `FindConnectionWithOffset` e la percorrenza
  costruiscono la spirale aperta.

Quindi l'aborto L3 viene deciso quando `ComputeOffset` non conosce ancora:
- il punto reale di ingresso nel giro;
- la sequenza già percorsa;
- il varco lasciato dalla finalizzazione;
- il terminale reale della mandata.

Il nuovo log categorizzato ha ricostruito l'offset 2 reale:
- connessione da `(1,42 ; 4,14316)` a `(0,82 ; 4,14316)`;
- percorso:
  `(0,82;4,14316) -> (0,82;4,67) -> (-0,77;4,67) ->`
  `(-0,77;0,67) -> (0,82;0,67) -> (0,82;3,54316)`;
- tutti i candidati sono `respectConditioning=true` e `respectSelf=true`;
- terminale reale `(0,82 ; 3,54316)`;
- sul lato destro resta un'apertura esatta di **0,60 m** rispetto al punto
  di connessione `(0,82 ; 4,14316)`.

Conclusione provvisoria 4B:
- il percorso effettivamente accettato non fallisce;
- l'unico aborto avviene nella rappresentazione preventiva del *prossimo*
  livello come poligono chiuso completo;
- non è ancora dimostrato che esista una prosecuzione corretta;
- va ora individuato il **primo tratto geometricamente illegale** di una
  eventuale evoluzione successiva, partendo dallo stato reale della spirale
  e non dall'ipotesi di anello intero.

**PROSSIMO PASSO ESATTO — SOLO `locale_1`:** usare il log categorizzato per
diagnosticare, senza applicarla, la transizione dal terminale reale
`(0,82 ; 3,54316)` verso la geometria raw L3. Per ogni segmento candidato
registrare raggiungibilità e distanza minima dalla Supply già costruita,
finché si identifica il primo segmento che viola realmente `0,60 m`.
Nessun bypass, nessuna modifica geometrica e nessun altro locale.


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


### STEP 4C — identificazione visiva del punto reale da indagare
Stato: **IN CORSO — TARGET CONFERMATO DALL'UTENTE**

Conferma utente 28/09/2026:
- nel disegno pubblico il caso in esame è il locale visibile **R001**;
- nel payload/Harness corrente questo locale corrisponde a **locale_1**;
- il difetto da seguire non va cercato genericamente nel centro del locale:
  il punto visivamente significativo è la zona di **scavalcamento del punto di accesso** mostrata nel dettaglio fornito dall'utente;
- i punti di accesso/innesto sono storicamente una zona critica perché introducono una discontinuità/convessità nel percorso.

Chiarimento sugli identificatori:
- `R001` è l'identificatore/nome del locale nel disegno CAD;
- `locale_1` è l'identificatore interno sequenziale generato nel payload pannelli;
- nel progetto pubblico corrente la corrispondenza verificata è `R001 <-> locale_1`, ma i due nomi appartengono a livelli diversi e non devono essere assunti equivalenti per convenzione generale.

Nuova evidenza dal codice reale:
- `Program.GeneraSpirale` seleziona la linea di ingresso `T6` e ne calcola l'intersezione col perimetro:
  circa `(1,5693 ; 4,74316)`;
- subito dopo chiama `SpiralGenerator.Generate(perimetro, startPoint, ...)`;
- la geometria completa di `T6` **non viene passata** al generatore Supply: dentro `Generate` resta soltanto il punto di intersezione `startPoint`;
- quindi la fase Supply non possiede esplicitamente il segmento di accesso come geometria/ostacolo. Questa è ora un'ipotesi diagnostica prioritaria, non ancora una causa provata.

**PROSSIMO PASSO ESATTO — SOLO locale_1/R001:** usare `Debug_Avanzato_harness_rapido` per tracciare dal primo ingresso T6 la sequenza reale di connessione/percorrenza degli offset nella zona del punto di accesso. Registrare per ogni tratto candidato: origine, destinazione, offset, relazione col punto/segmento T6 e decisione presa. Nessuna modifica geometrica finché non viene identificata la prima decisione errata.


#### STEP 4C.1 — strumentazione accesso T6
Stato: **IMPLEMENTATA — TEST GITHUB ACTION IN CODA**

Implementazione solo diagnostica, nessuna modifica geometrica:
- commit `9923b5edad744249c47bc62284e3ae9f9d38adc2`:
  `Program.GeneraSpirale` passa al logger Supply i due estremi reali della linea di ingresso selezionata;
- commit `c3c8b254b0388588671671f152ef21ff4736cfb3`:
  `SpiralGenerator.Generate` riceve i due estremi solo come parametri diagnostici opzionali;
  registra `Supply.Access.Context`, `Supply.Access.Connection`,
  distanza/intersezione T6 su ogni `Supply.Traverse.Candidate` e
  `Supply.Access.Finalize`;
- il controllo distingue la distanza dal segmento T6 completo e dal solo tratto interno
  `startPoint -> endpoint interno`;
- i valori osservati non entrano in nessuna decisione del motore.
- commit `68e11f56acc4e83a1c100a8350f71468107bba36`:
  Fast Harness richiede i nuovi marker diagnostici nel caso categorizzato `locale_1`.

Test avviato:
- workflow `Termodel Diego_Vittorio Fast Harness` run `36438139064`, run #46;
- stato al checkpoint: **pending/in coda**.

**PROSSIMO PASSO ESATTO:** attendere il run 36438139064; se compila e il caso categorizzato passa,
leggere il log `locale_1` e isolare i segmenti che toccano/intersecano o passano vicino al tratto interno T6.
Se il run fallisce, leggere il primo errore e correggere esclusivamente la strumentazione.


#### STEP 4C.2 — primo errore causale nella zona T6
Stato: **COMPLETATO — PRIMA DECISIONE ERRATA IDENTIFICATA**

Verifica reale:
- Fast Harness run `36438139064` (#46), job `108981900699`: **SUCCESS**;
- build Harness + Core: SUCCESS;
- matrice Supply-only: SUCCESS;
- log categorizzato `locale_1`: SUCCESS;
- quadrato approvato e tutte le regression Diego_Vittorio: SUCCESS;
- nessuna geometria produttiva modificata.

Geometria accesso reale `R001 / locale_1 / T6`:
- punto sul perimetro/start Supply: `(1,57000 ; 4,74316)`;
- endpoint T6 interno al locale: `(1,31155 ; 4,74316)`;
- tratto interno fisico T6: orizzontale, lungo circa 0,25845 m.

Sequenza osservata:
1. connessione iniziale Supply:
   `(1,57000;4,74316) -> (1,42000;4,74316)`;
   coincide con T6: è il tratto iniziale comune, quindi non è un ramo remoto;
2. primo candidato:
   `(1,42000;4,74316) -> (1,42000;5,27000)`;
   parte dal tratto T6 ed è topologicamente adiacente;
3. **primo ramo non adiacente**:
   `(1,42000;5,27000) -> (-1,37000;5,27000)`;
   distanza minima dal tratto T6 = **0,52684 m**;
   distanza Supply-Supply richiesta = **0,60 m**;
   deficit = **0,07316 m**;
   il logger registra tuttavia `respectSelf=true` e il segmento viene accettato.

Causa della decisione errata:
- `SegmentoRispettaSpirale` controlla soltanto i segmenti già presenti in `spiral`;
- il tratto fisico T6 non viene inserito in `spiral`: `Generate` riceveva storicamente solo lo `startPoint`;
- quindi il ramo superiore viene accettato senza confrontarlo con il tubo di accesso reale;
- geometricamente il corridoio disponibile fra T6 e il primo offset superiore misura
  soltanto 0,52684 m, meno di 0,60 m: il problema nasce già al primo giro nella zona
  indicata dall'utente come scavalcamento del punto di accesso.

Conferma downstream:
- offset 2, primo tratto verticale e successivo orizzontale arrivano a
  **0,496964574 m** dal terminale interno T6, ancora sotto 0,60 m;
- anche questi vengono accettati perché T6 non partecipa al controllo di autocondizionamento.

Conclusione:
- il collasso preventivo L3 resta un fatto reale per un anello rettangolare completo,
  ma non è più corretto considerarlo il primo errore della Supply di `locale_1`;
- la prima decisione geometricamente incoerente col vincolo Supply-Supply è già nel
  primo giro, quando il motore percorre il lato superiore a 0,52684 m da T6;
- l'indicazione visiva dell'utente sullo scavalcamento dell'accesso è quindi confermata
  dal log numerico.

Nessuna correzione applicata.
Il prossimo intervento è una decisione algoritmica e richiede accordo umano:
trattare il tratto interno T6 come parte della Supply esistente durante la validazione,
definendo l'eccezione topologica per i segmenti iniziali realmente adiacenti e il
comportamento quando il verso iniziale non dispone dei 0,60 m richiesti.


### STEP 4D — SVG completo senza chiusura
Stato: **COMMISSIONATO / IN CORSO**

Decisione utente 28/09/2026:
- per il solo test diagnostico `R001 / locale_1 / T6`, mantenere Supply + Return autonomo;
- sospendere la chiusura centrale perché può tagliare/sostituire segmenti terminali e nascondere il difetto;
- generare uno SVG Harness pre-chiusura.

Implementazione prevista:
- non modificare l'algoritmo produttivo;
- riusare il flag già esistente `TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE=false`;
- esporlo nell'Harness con un'opzione diagnostica dedicata;
- generare artifact SVG e log del solo `locale_1`;
- confrontare visivamente e numericamente lo stato prima della chiusura.

**PROSSIMO PASSO ESATTO:** aggiungere il flag Harness, lanciare il Fast Harness sul caso `locale_1`, recuperare lo SVG pre-chiusura e renderlo disponibile all'utente.


#### STEP 4D.1 — SVG pre-chiusura generato e confronto eseguito
Stato: **COMPLETATO**

Implementazione:
- commit `50e8808769343f5500af095a5f62fd656e045173`:
  Harness Diego_Vittorio espone `--skip-close`;
- il flag è valido solo per `Diego_Vittorio`, è incompatibile con `--supply-only`
  e riusa esclusivamente `TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE=false`;
- il valore precedente della variabile d'ambiente viene ripristinato a fine run;
- nessuna modifica alla geometria produttiva del motore;
- commit `39c83fd1194acacbb5a9e129418c2f4eb828d8ac`:
  workflow Fast aggiunge il caso `DV-LOCALE1-T6-PRECLOSE` e pubblica lo SVG.

Verifica:
- GitHub Actions Fast Harness run `36441043047`, job `108991866603`: **SUCCESS**;
- build Harness + Core: SUCCESS;
- step `Generate locale_1 pre-closure SVG`: SUCCESS;
- tutte le regression Diego_Vittorio successive: SUCCESS;
- SVG SHA-256:
  `8620835cf47f6b47f55942f55ae5b628db53033557beb0eb862aaa0104bec5db`;
- SVG dichiara:
  `data-termodel-closure="disabled"`,
  `data-termodel-autonomous-return="enabled"`;
- Return autonomo mantenuto: **18 punti** prima dell'arrotondamento.

Confronto con l'esecutivo chiuso dello stesso locale:
- pre-chiusura: mandata rossa arrotondata 46 punti SVG, Return blu 66 punti SVG;
- chiuso: mandata rossa principale 46 punti SVG + collegamento rosso di chiusura 9 punti,
  Return blu ridotto a 54 punti SVG;
- log della chiusura normale:
  `M4/RP3`, lunghezza 0,60 m, `tagli=0/3`, **3,81 m rimossi dal Return**;
- quindi l'osservazione utente è confermata: la chiusura modifica effettivamente la
  geometria terminale e rimuove segmenti; il nuovo SVG pre-chiusura è il riferimento
  corretto per proseguire il debug del punto di accesso T6.

Artifact generato:
- `DV-LOCALE1-T6-PRECLOSE.svg`;
- artifact workflow `diego-vittorio-fast`, id `10979495282`.

**PROSSIMO PASSO ESATTO:** usare lo SVG pre-chiusura come riferimento visivo per
analizzare il tratto di scavalcamento T6 senza l'interferenza della chiusura.


### STEP 4E — focus decisionale sulla strettoia di scavalcamento T6
Stato: **CONTESTO DEFINITO DALL'UTENTE — ANALISI DA AVVIARE**

Contestualizzazione utente 28/09/2026, da assumere come riferimento per il debug:
- il tratto evidenziato si è posizionato correttamente alla distanza imposta dal tratto frontale a destra;
- nel punto critico l'algoritmo dovrebbe poi decidere se **girare a sinistra**;
- la situazione è particolare perché lo scavalcamento dell'accesso genera una **curva convessa** e quindi una **strettoia geometrica**;
- il problema centrale non è soltanto una distanza locale, ma la decisione fondamentale dell'algoritmo: **entrare o non entrare nella strettoia**;
- questa decisione rappresenta il cuore della valutazione di bontà del percorso.

Confronti obbligatori richiesti prima di qualsiasi correzione:
1. ricostruire cosa decide **Diego_Vittorio** nella strettoia;
2. ricostruire cosa decide **Vittorio** nella stessa situazione;
3. produrre due diagrammi decisionali separati;
4. confrontare il caso reale `R001 / locale_1 / T6` con il **progetto quadrato**, dove una situazione apparentemente equivalente funziona;
5. ancora prima, spiegare perché nel caso reale il **primo giro funziona** e il **secondo no**, pur con contesto topologico apparentemente identico;
6. verificare esplicitamente se la differenza dipende da:
   - arrotondamenti/raccordi;
   - geometria rettilinea pre-arrotondamento;
   - soglie/tolleranze numeriche;
   - ordine di costruzione e disponibilità dei segmenti nel controllo;
   - differenze fra offset 1 e offset 2;
   - differenze fra motore Vittorio e copia Diego_Vittorio.

Vincolo:
- usare come riferimento visivo lo SVG **pre-chiusura** `DV-LOCALE1-T6-PRECLOSE.svg`;
- nessuna modifica algoritmica finché i quattro confronti sopra non sono ricostruiti.

**PROSSIMO PASSO ESATTO:** leggere e confrontare i rami decisionali di Vittorio e Diego_Vittorio nelle funzioni di generazione Supply/offset/percorrenza, poi confrontare numericamente `locale_1` con il quadrato e con offset 1 vs offset 2; produrre due diagrammi decisionali e una tabella delle differenze causali.


#### STEP 4E.1 — confronto decisionale completato
Stato: **ANALISI COMPLETATA — NESSUNA CORREZIONE APPLICATA**

Verifica reale:
- Fast Harness run `36443765112` (#49): **SUCCESS**;
- commit diagnostico workflow `d391ca359906865e9289e7e6236f732cb1591aca`;
- trace Return Diego_Vittorio eseguito su `locale_1` e sul quadrato pubblico;
- riferimento Vittorio eseguito sugli stessi due casi;
- tutte le regression Diego_Vittorio successive sono rimaste verdi.

### 1. Differenza strutturale Vittorio / Diego_Vittorio

**Vittorio originale**
- genera la mandata con offset chiusi e percorrenza deterministica;
- in `ChiudiSpirale` arrotonda PRIMA la mandata con `ArrotondaSpirale`;
- il Return viene poi DERIVATO dalla mandata arrotondata tramite `CreaRientro`;
- `CreaRientro` percorre i campioni della mandata all'indietro e li trasla di
  `distanzaRitorno` lungo la normale locale;
- non esistono ricerca di corridoi, scelta entra/non entra nella strettoia,
  `SegmentoRispettaCondizionamento` o autocondizionamento Return-Return.

Conclusione: in Vittorio la strettoia non è una decisione esplicita; il Return
eredita la forma della mandata (già arrotondata).

**Diego_Vittorio**
- il Return è autonomo e viene generato sulla geometria RETTILINEA, prima
  dell'arrotondamento;
- costruisce un collegamento iniziale esplicito;
- calcola offset Return, scarta quelli paralleli troppo vicini alla Supply;
- per collegarsi all'offset successivo `FindConnectionWithOffset` prova:
  diretto, due L ortogonali, corridoi a due gomiti campionati p/2 e infine
  coordinate critiche Supply +/- p;
- ogni tratto è validato a distanza p dalla Supply e p dal Return già costruito;
- sceglie il percorso valido più corto;
- solo dopo la generazione completa `ChiudiSpirale` arrotonda Supply e Return
  per l'esecutivo SVG.

Conclusione: in Diego_Vittorio la domanda **entrare o non entrare nella
strettoia** è realmente una decisione geometrica del motore.

### 2. Perché NON è un problema di arrotondamento in Diego_Vittorio

L'arrotondamento avviene DOPO `GenerateReturn`.
Quindi le curve convesse visibili nello SVG non partecipano alla decisione:
la decisione viene presa sui segmenti ortogonali raw.

L'arrotondamento può rendere meno evidente il punto di decisione nel disegno,
ma non può essere la causa del rifiuto/accettazione in Diego_Vittorio.

In Vittorio, invece, l'arrotondamento è parte della costruzione del Return,
perché `CreaRientro` riceve la mandata già arrotondata.

### 3. Perché il primo scavalcamento funziona e il secondo è diverso

Sul `locale_1` la mandata lascia due varchi verticali destri larghi esattamente
`2p = 0,60 m`.

Primo varco:
- Supply esterna x=1,42, apertura y=4,14..4,74;
- il Return non deve scoprirlo;
- `GeneraCollegamentoRitorno` costruisce direttamente la radice
  `(1,57;4,44) -> (1,12;4,44)`, cioè sulla mezzeria esatta del varco;
- quindi il primo ingresso è **prescritto**, non selezionato dalla ricerca.

Secondo varco:
- Supply interna x=0,82, apertura y=3,54..4,14;
- mezzeria geometrica esatta: y=3,84;
- qui il Return deve invece **ritrovare** il corridoio con
  `FindConnectionWithOffset`;
- il campionamento p/2 produce, fra gli altri, y=3,82: viene respinto perché
  resta a 0,28 m dal tratto Supply (deficit 0,02 m);
- il fallback sulle coordinate critiche individua y=3,84 e consente il
  collegamento raw `(1,12;3,84) -> (0,52;3,84)`.

Quindi il contesto visivo è simile ma il contesto algoritmico NON è identico:
**primo varco = collegamento costruito a priori; secondo varco = corridoio
cercato e validato**.

Dopo il secondo scavalcamento il segmento
`(1,12;3,84) -> (0,52;3,84)` entra inoltre nella storia del Return e diventa
a sua volta ostacolo di autocondizionamento per le evoluzioni successive.
Il trace mostra, per esempio, candidati verticali successivi respinti perché
intersecano o passano a meno di p da quel segmento.

### 4. Perché il quadrato pubblico funziona

Il quadrato pubblico aveva un difetto diverso già isolato come DV-TEST-001:
- il raccordo arriva a circa `(1,18;2,82)`;
- il passo successivo è una prosecuzione COLLINEARE nello stesso verso;
- il vecchio controllo la scambiava per un ramo remoto e la respingeva;
- Diego_Vittorio ora riconosce la continuità topologica con
  `CandidatoProsegueUltimoSegmento` e applica
  `DV_RETURN_SKIP_COLLINEAR_ADJACENT`;
- trace run #49 conferma:
  `DV_RETURN_SKIP_ZERO candidate=(1.18,2.82)`
  e
  `DV_RETURN_SKIP_COLLINEAR_ADJACENT ... (1.18,2.82)->(1.18,1.18)`.

Nel `locale_1`, invece, lo scavalcamento richiesto è una svolta/corridoio
ortogonale attraverso un'apertura esatta 2p; non è una semplice prosecuzione
collineare e quindi la regola che salva il quadrato non descrive questo caso.

### 5. Esito riferimenti Vittorio

Run #49, stesso input:
- Vittorio `locale_1`: 28 punti, SVG SHA
  `50a67c7cf7958c966381a399139c23c9ebaef7fb46761f0aea6a3753db83feae`;
- Vittorio quadrato pubblico: 33 punti, SVG SHA
  `0688a4e4bed2a7e07ad84174f1862c6a95df544d52853a6ecbcd2742e3cfdb1a`.

Questi risultati non sono direttamente comparabili punto-per-punto col Return
autonomo Diego_Vittorio perché Vittorio costruisce il rientro per offset dei
campioni della mandata arrotondata, non mediante la stessa macchina decisionale.

**CONCLUSIONE OPERATIVA:** prima di correggere, il focus deve restare sulla
macchina decisionale Diego_Vittorio nel passaggio fra offset: riconoscere la
strettoia 2p, distinguere adiacenza topologica da ostacolo remoto e decidere se
il corridoio è realmente percorribile. L'arrotondamento non è la causa nel
motore Diego_Vittorio.


### STEP 4F — mappa del codice che valuta le strettoie
Stato: **COMPLETATO — ANALISI FUNZIONALE, NESSUNA MODIFICA AL MOTORE**

Incarico utente:
- identificare prima di ogni correzione quali porzioni di codice valutano le
  strettoie in Vittorio e Diego_Vittorio;
- confrontare i due flussi decisionali.

Verifiche:
- `SpiraliVittorio/Spiralgenerator.cs` Service è byte-per-byte identico al
  riferimento Desktop
  `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Spiralgenerator.cs`;
- anche `SpiraliVittorio/ChiudiSpirale.cs` è identico al Desktop.

Esito Vittorio:
- `ComputeOffset`: filtro locale su lato corto + contrazione;
- soglie `minEdgeLength`: arresto locale di un nuovo anello;
- `FindIntersectionWithOffset` + controllo `isTooCloseToSpiral`: sola
  euristica sul gomito di connessione;
- una volta entrato nell'offset, percorre tutti i vertici senza valutare
  conseguenze future;
- `CreaRientro` deriva il Return dalla mandata già arrotondata: nessuna
  decisione autonoma entra/non entra nella strettoia.

Esito Diego_Vittorio:
- eredita i filtri Supply di Vittorio;
- il Return autonomo decide localmente con:
  `OffsetHaTrattoParalleloTroppoVicino`,
  `FindConnectionWithOffset`,
  `ConnectionPathIsValid`,
  `SegmentoRispettaCondizionamento`,
  `SegmentoRispettaSpirale`,
  `FindConnectionWithTerminalTrim`,
  `TrovaMassimoPrefissoValido`;
- `FindConnectionWithOffset` è oggi il cuore della decisione di ingresso:
  genera una famiglia finita di corridoi e sceglie il percorso valido più
  corto, ma non valuta cosa succede dopo l'ingresso;
- `ProvaPortaleAnticipato` con `TracePortalsEnabled` è già un look-ahead
  diagnostico di un offset, ma oggi non influenza la geometria.

Conclusione:
- Vittorio non possiede una vera macchina decisionale di strettoia per il
  Return;
- Diego_Vittorio possiede una macchina locale di ricerca/validazione, ma non
  ancora una funzione di convenienza a medio raggio;
- il punto di estensione naturale è
  `FindConnectionWithOffset + traversal`, non l'arrotondamento.

Linee guida aggiornate:
- `LG-050 — Strettoie: decisione a visione media, non solo locale`;
- commit `b4c948582094f072d93f0014eee0a3f3d054c266`.

**PROSSIMO PASSO ESATTO:** fase interattiva: scegliere un singolo punto di
strettoia nel `locale_1` e seguire, chiamata per chiamata, quali candidati
`FindConnectionWithOffset` costruisce, quali vengono respinti, quale viene
premiato e quale informazione sul futuro manca al momento della scelta.


## CONSAPEVOLEZZA OPERATIVA OBBLIGATORIA PER LA CHAT SUCCESSIVA

Questa sezione è intenzionalmente ridondante rispetto ai checkpoint precedenti:
serve a riportare rapidamente una nuova chat allo stesso livello di comprensione
raggiunto nell'analisi corrente, senza ricostruzioni interpretative.

### Modello mentale del problema

Il problema da risolvere NON è:
- “questo singolo segmento passa oppure no?”;
- “la curva arrotondata è troppo vicina?”;
- “il secondo giro è uguale al primo e quindi dovrebbe comportarsi uguale?”.

Il problema corretto è:
> **quando Diego_Vittorio incontra una strettoia, una scelta può essere
> localmente valida ma strategicamente cattiva perché compromette i passi
> successivi. Serve quindi distinguere validità locale e convenienza a medio
> raggio.**

La StrategiaDiego completa avrebbe risolto il problema esplorando un albero di
rami alternativi e premiando la soluzione globalmente migliore, soprattutto
per lunghezza utile di tubazione. Questo approccio è stato sospeso perché troppo
costoso computazionalmente.

Diego_Vittorio deve quindi restare una strategia intermedia:
- più intelligente di Vittorio nelle strettoie;
- visione più ampia del solo prossimo segmento;
- niente tree-search combinatorio completo;
- euristiche finite, deterministiche e a costo controllato.

### Cosa fa Vittorio

Vittorio NON possiede una vera decisione “entro/non entro nella strettoia” sul
Return:
- `ComputeOffset` e `minEdgeLength` filtrano localmente la formazione degli
  anelli;
- `FindIntersectionWithOffset` usa una connessione semplice e una piccola
  euristica sul gomito;
- una volta raggiunto un offset, lo percorre;
- `CreaRientro` deriva il Return dalla Supply già arrotondata.

Quindi Vittorio è un riferimento geometrico/storico, non un motore con ricerca
autonoma della miglior scelta nella strettoia.

### Cosa fa Diego_Vittorio

La macchina decisionale corrente del Return è:
1. `FindConnectionWithOffset` genera percorsi candidati finiti;
2. `ConnectionPathIsValid` li verifica;
3. `SegmentoRispettaCondizionamento` controlla Supply;
4. `SegmentoRispettaSpirale` controlla Return già costruito;
5. tra i candidati validi `FindConnectionWithOffset` sceglie oggi il
   **più corto**;
6. la successiva percorrenza dell'offset continua finché il prossimo tratto è
   localmente valido;
7. non viene ancora premiato o penalizzato il candidato in base a ciò che
   succederà 1-N decisioni dopo.

`ProvaPortaleAnticipato`, sotto `TracePortalsEnabled`, è già un embrione di
look-ahead: verifica se dal punto corrente esiste un collegamento al prossimo
offset, ma oggi produce solo diagnostica e NON modifica la scelta.

### Caso R001 / locale_1 / T6 da non reinterpretare

Riferimento visivo:
- usare lo SVG `DV-LOCALE1-T6-PRECLOSE.svg`;
- chiusura centrale disabilitata perché rimuove segmenti e maschera il fenomeno.

Punti già stabiliti:
- il primo scavalcamento e il secondo sono simili visivamente ma NON equivalenti
  algoritmicamente;
- primo scavalcamento: la mezzeria del varco viene costruita direttamente da
  `GeneraCollegamentoRitorno`;
- secondo scavalcamento: deve essere scoperto da `FindConnectionWithOffset`;
- sul secondo varco il campione y=3,82 è invalido (0,28 m < p=0,30), mentre la
  coordinata critica y=3,84 è valida;
- il passaggio raw valido è
  `(1,12;3,84) -> (0,52;3,84)`;
- dopo essere stato aggiunto, questo stesso segmento entra nella storia del
  Return e può diventare ostacolo per le decisioni successive;
- il quadrato pubblico è un caso diverso: lì il problema era una prosecuzione
  collineare risolta da `CandidatoProsegueUltimoSegmento` /
  `DV_RETURN_SKIP_COLLINEAR_ADJACENT`;
- l'arrotondamento NON causa la decisione Diego_Vittorio perché avviene dopo
  `GenerateReturn`.

### Ipotesi di lavoro corrente — NON ancora regola

Il limite probabile non è che Diego_Vittorio non trovi il varco: nel caso
`locale_1` il secondo varco viene trovato. Il limite da verificare è che la
scelta viene premiata con criteri troppo locali (validità + lunghezza del
collegamento) senza valutare abbastanza ciò che rimarrà percorribile dopo.

NON trasformare questa ipotesi in una correzione senza trace causale.

### Prossimo debug esatto

Sul singolo punto di strettoia del `locale_1`:
1. enumerare TUTTI i candidati prodotti da `FindConnectionWithOffset`;
2. per ciascuno registrare:
   - geometria completa del path;
   - lunghezza;
   - validità Supply;
   - validità Self;
   - motivo preciso di eventuale rigetto;
3. identificare il candidato oggi vincente e il criterio con cui viene premiato;
4. per ogni candidato localmente valido eseguire SOLO diagnosticamente una
   previsione finita:
   - esiste un portale verso l'offset successivo?
   - quanti segmenti/vertici successivi risultano immediatamente percorribili?
   - quale margine minimo resta rispetto a Supply e Return?
5. confrontare il vincitore locale con almeno un'alternativa valida;
6. NON cambiare ancora il motore;
7. solo dopo questi numeri proporre un'euristica di “media visione”.

Obiettivo del debug:
> capire quale informazione sul futuro manca esattamente nel momento in cui
> `FindConnectionWithOffset` sceglie il percorso più corto.

Questa è la conoscenza minima che una chat di recovery deve possedere prima di
toccare il codice.
