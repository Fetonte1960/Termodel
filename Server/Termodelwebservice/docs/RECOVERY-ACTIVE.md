# RECOVERY ACTIVE — Termodel Service

Checkpoint: 2026-09-28 12:26 Europe/Rome
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
- Nessuna modifica frontend.
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
