# RECOVERY ACTIVE — Termodel Service

Checkpoint: 2026-09-28 11:00 Europe/Rome
Stato: ATTIVITÀ IN CORSO / RIPRESA DOPO SOSPENSIONE
Branch: `main`
Repository: `Fetonte1960/Termodel`
HEAD verificato all'avvio recovery: `f3f9be2e2785229fd20be7bda05c5e3b1f21aac7`

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
Stato: **IN CORSO — correzione candidata già eseguita e testata, da consolidare/valutare**

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
  eventuali configurazioni successive più locali/naturali;
- prima di modificare la selezione della chiusura bisogna enumerare in pura
  diagnostica tutti i candidati diretti/proiettati che sarebbero accettabili.

**PROSSIMO PASSO ESATTO:**
1. aggiungere diagnostica non invasiva che, solo sotto flag trace, enumeri
   tutti i candidati LG-048 accettabili senza cambiare quello restituito;
2. includere anche le chiusure proiettate diagnostiche, anche quando una
   chiusura diretta precedente è già valida;
3. rieseguire `locale_5` e verificare se esiste una chiusura più corta/localizzata;
4. mantenere obbligatoriamente verde e byte-identica la baseline del quadrato;
5. se una migliore selezione richiede cambio di strategia/criterio, fermarsi
   e chiedere consenso umano prima di renderla comportamento di produzione.

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
