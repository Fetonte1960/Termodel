# RECOVERY ACTIVE — Termodel Service

Checkpoint: 2026-09-28 11:46 Europe/Rome
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
Stato: **IN CORSO — cambio circoscritto del criterio LG-048 autorizzato dall'utente**

Stato prima del trim:
- Return 6 punti;
- offset 2/3 non collegati;
- fallback sulle coordinate critiche raggiungeva il varco;
- rifiuto residuo `Self`: il collegamento tentava di rientrare all'indietro sul terminale Return già occupato.

Decisione già presa:
- non rilassare l'autointersezione;
- verificare un accorciamento/sostituzione del solo terminale Return, come fallback successivo al fallimento della ricerca normale.

Implementazione candidata:
- commit `ab09475b8afb482b6fa948aebb828f7356ad225e`
  (`fix(radiant): consente trim terminale Return nei varchi`);
- se il collegamento ordinario fallisce, prova punti critici interni all'ultimo segmento Return, sostituisce temporaneamente il terminale e riusa `FindConnectionWithOffset`;
- se il nuovo offset non produce tratto, il terminale originale viene ripristinato;
- nessun rilassamento delle distanze/autointersezioni.

Verifiche già concluse:
- Fast Harness run `36402929306`: **SUCCESS**; quadrato base e regression esistenti non regrediti.
- Room Extraction run `36402954805`: **SUCCESS**.
- `locale_5` dopo il trim:
  - Return **16 punti**;
  - offset-utili 3 completati;
  - chiusura accettata: tentativo 27, `M3/R5`, obliqua,
    lunghezza 2,454 m, coseni 0,139/0,139,
    tagli 0/2, rimosso 3,75 m.

Verifica visiva eseguita sul vero artifact del run `36402954805`:
- artifact `diego-vittorio-room-extraction` recuperato e ispezionato;
- il Return a 16 punti percorre i tre livelli in modo ordinato;
- la chiusura accettata `M3/R5` produce però una diagonale centrale lunga
  **2,454 m** e rimuove **3,75 m** di Return;
- questa chiusura non viene ancora considerata comportamento corretto da
  congelare in regression: il locale resta **IN CORSO**.

Ipotesi corrente:
- il problema residuo non è più l'intrappolamento del Return;
- LG-048 si ferma al **primo candidato valido** e può quindi non osservare
  configurazioni successive più locali/naturali.

Diagnostica già eseguita dopo il precedente checkpoint:
- commit `2afc42b87fc2d90826d9e8f79a6e75c0c703dda3`:
  sotto `TERMODEL_DIEGO_VITTORIO_TRACE_CLOSURE=true` enumera tutti i
  candidati validi ma continua a restituire il **primo** accettabile, quindi
  non cambia il comportamento di produzione;
- commit `25a562e9a93ab2b40003493691e7af67878a159f`:
  aggiunge il trace completo di `locale_5`;
- Fast Harness run `36403714418`: **SUCCESS**, inclusa baseline quadrato
  approvato invariata;
- Room Extraction run `36403744027`: **SUCCESS**.

Risultato enumerazione `locale_5`:
- primo candidato valido e ancora scelto in produzione:
  `M3/R5`, attempt 27, obliquo, lunghezza **2,45367 m**,
  rimozione **3,75 m**;
- altri candidati diretti validi:
  `M4/R5`, attempt 34, lunghezza **2,43 m**;
- candidati proiettati validi:
  `M4/RP2`, attempt 37, ortogonale, lunghezza **2,43 m**;
  `M3/RP2`, attempt 38, ortogonale, lunghezza **2,43 m**;
  `M2/RP3`, attempt 40, ortogonale, lunghezza **1,24 m**.
- quindi è confermato che esistono chiusure successive più corte e più locali,
  ma sceglierle richiederebbe cambiare il criterio `prima accettabile`
  di LG-048.

Decisione utente ricevuta:
- l'utente ha autorizzato il cambio circoscritto del criterio LG-048;
- prima implementazione `aedf756a44beb9039e4faed76fdfda071a031e4f`:
  enumerazione dei candidati validi e preferenza assoluta per l'ortogonale
  più corta;
- regression Fast Harness run `36405315739`: **FAILED correttamente sul
  vincolo del quadrato base**. Build Core/Harness SUCCESS, ma il quadrato
  pubblico passava dalla chiusura storica `M2/R6` obliqua 0,753 m alla
  `M3/R3` ortogonale 0,740 m; SVG hash cambiato, quindi la correzione non
  può essere consolidata in questa forma;
- criterio raffinato per rispettare il vincolo di non regressione:
  1. enumerare i candidati già validi senza rilassare alcun vincolo;
  2. conservare come riferimento il primo candidato valido storico;
  3. cercare la chiusura ortogonale più corta;
  4. sostituire il candidato storico **solo se** l'ortogonale riduce la
     lunghezza della chiusura di almeno un passo `p`;
  5. tra ortogonali equivalenti scegliere minore lunghezza, poi minore
     lunghezza rimossa e infine numero tentativo più basso;
  6. in tutti gli altri casi conservare il primo candidato valido storico;
- motivazione: sul quadrato il vantaggio era solo 0,013 m (< p=0,30 m), mentre
  su `locale_5` il candidato atteso riduce 2,454 m a 1,240 m (> p);
- vincolo di non regressione invariato: quadrato base byte-identico e
  `locale_1` valido; nessun rilassamento di lunghezze, angoli o intersezioni.

Nota di coerenza repository:
- il commit successivo `d231bdf8c8c01354d5b54f34e7c4997f2fb17303`
  aggiunge soltanto una diagnostica lato Return opposto su `locale_8`;
- run `36403952397` conferma che lato Destro peggiora `locale_8`
  (2 punti, offset 1/2/3 non collegati);
- questo **non chiude FASE 3 e non avvia formalmente FASE 4**: è sola
  diagnostica anticipata e non contiene modifiche al motore.
- dopo quel checkpoint sono presenti anche:
  - `5320ad392abc9a010010d3d9ac4a3111529b3a80`, esperimento
    `TERMODEL_DIEGO_VITTORIO_DIAG_LOCAL_ROOT_ADJACENCY` su `locale_8`,
    spento di default e quindi senza effetto sul comportamento di produzione;
  - `56b9a03002633a8e3454a854a9d7ad2f23adc744`, solo workflow diagnostico
    che abilita il flag precedente per `locale_8`;
- Fast Harness run `36404331770`: **SUCCESS** sul commit diagnostico;
- Room Extraction run `36404366848`: **SUCCESS**;
- i due commit non modificano il blocco di FASE 3: il prossimo passo resta
  la decisione umana sul criterio LG-048 di `locale_5`.

**PROSSIMO PASSO ESATTO:**
1. restringere LG-048 alla soglia di miglioramento >= `p`;
2. rieseguire Fast Harness con quadrato base + `locale_1` + `locale_5`;
3. verificare che il quadrato torni byte-identico e che `locale_5` scelga
   `M2/RP3` ortogonale da 1,24 m;
4. ispezionare l'output di `locale_5` e consolidare FASE 3 solo se tutte le
   regression restano verdi.

### FASE 4 — locale_8
Stato: **NON INIZIATA**
Dipendenza: completamento FASE 3.

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
