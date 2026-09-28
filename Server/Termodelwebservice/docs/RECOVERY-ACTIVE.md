# RECOVERY ACTIVE — Termodel Service

Checkpoint: 2026-09-28 12:12 Europe/Rome
Stato: ATTIVITÀ IN CORSO / RIPRESA DOPO SOSPENSIONE
Branch: `main`
Repository: `Fetonte1960/Termodel`
HEAD verificato prima del presente checkpoint: `56b9a03002633a8e3454a854a9d7ad2f23adc744`

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
Stato: **IN CORSO**

Stato noto dai run di estrazione precedenti, da verificare sul codice corrente:
- inizialmente la fixture aveva Return 6 punti e offset 2 bloccato;
- dopo le correzioni circoscritte delle fasi precedenti, il run
  `36405131885` mostrava già Return **13 punti**, 2 offset utili e chiusura
  `M3/R5` obliqua da 1,875 m;
- questo miglioramento è incidentale e non è ancora una regression dedicata.

**PROSSIMO PASSO ESATTO:**
1. eseguire `locale_9` sul codice corrente nel Fast Harness;
2. ispezionare log/SVG e verificare se Return 13 punti e chiusura 1,875 m
   costituiscono una geometria coerente;
3. se coerente, aggiungere regression dedicata senza cambiare il motore;
4. se emerge un'anomalia reale, isolarla senza modificare i casi già
   consolidati.

### FASE 6 — ricomposizione progetto completo
Stato: **NON INIZIATA**
Obiettivo:
- rieseguire il progetto pubblico completo;
- verificare che i locali risolti mantengano i propri regression;
- chiedere conferma visiva utente prima di dichiarare conclusa la campagna.

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
