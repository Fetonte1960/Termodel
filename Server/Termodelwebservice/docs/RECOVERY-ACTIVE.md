# RECOVERY ACTIVE — Termodel Service

Checkpoint: 2026-09-28 12:06 Europe/Rome
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
Stato: **IN CORSO**

Diagnostica già disponibile e da non ripetere:
- run `36404366848`: lato Sinistro -> Return 3 punti, offset 2/3 bloccati, nessuna chiusura;
- lato Destro -> peggiora a 2 punti, offset 1/2/3 bloccati;
- esperimento `TERMODEL_DIEGO_VITTORIO_DIAG_LOCAL_ROOT_ADJACENCY=true` non cambia il risultato;
- trace completo mostra due ostacoli dominanti:
  - Supply `(8,49;4,01)->(8,49;3,41)`, che intercetta o resta troppo vicino ai candidati orizzontali;
  - radice Return `(8,19;4,16)->(8,19;3,71)`, a 0,22 m dai candidati verticali su x=7,97 contro minimo 0,30 m.

Diagnosi topologica:
- il flag local-root precedente non poteva intercettare il rifiuto principale:
  era collocato nel ciclo di percorrenza dell'offset, mentre il rifiuto a
  0,22 m nasce già dentro `FindConnectionWithOffset`;
- geometria grezza locale:
  radice Return `A=(8,19;4,16) -> B=(8,19;3,71)`,
  raccordo `B -> C=(7,97;3,71)`,
  candidato `C -> D` verso il basso;
- il segmento A-B e il candidato C-D non hanno sviluppo parallelo
  sovrapposto: terminano/partono ai due estremi del raccordo B-C e divergono
  sui due lati opposti della sua retta;
- la distanza minima 0,22 m coincide con la lunghezza del solo raccordo B-C;
  quindi il controllo sta classificando come ramo remoto un segmento locale
  separato da un unico raccordo;
- lato Destro e verso di costruzione opposto sono già stati provati e
  peggiorano il caso (2 punti).

Prova diagnostica dogleg completata:
- commit diagnostico `d10e31d2b02b39b504dcde8db9e0d92f94e09619`;
- workflow diagnostico Fast `c1c25c61c802ce994e51cc17d5df6d427f92e17d`;
- Fast Harness run `36406990692`: **SUCCESS**;
- quadrato base, `locale_1`, `locale_5` e fitting regression tutti verdi;
- sotto il solo flag diagnostico `locale_8` passa da 3 a **18 punti** Return;
- il trace riconosce due dogleg locali:
  1. obstacle 0, raccordo 0,22 m all'ingresso;
  2. obstacle 6, analogo raccordo 0,22 m fra primo e secondo livello;
- entrambi sono stati verificati sull'SVG: i segmenti non hanno sviluppo
  parallelo sovrapposto, ma divergono ai lati opposti del raccordo;
- chiusura risultante: `M3/R5`, obliqua, 0,971 m; circuito completo.

**PROSSIMO PASSO ESATTO:**
1. promuovere la sola classificazione dogleg locale a comportamento normale,
   con flag di rollback separato e default ON;
2. rimuovere la dipendenza dal vecchio flag diagnostico local-root per questa
   regola e trasformare il test `locale_8` in regression ordinaria;
3. rieseguire Fast Harness con quadrato + `locale_1` + `locale_5` +
   `locale_8`;
4. se tutto resta verde, consolidare FASE 4 e passare a `locale_9`.

### FASE 5 — locale_9
Stato: **NON INIZIATA**
Dipendenza: completamento FASE 4.

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
