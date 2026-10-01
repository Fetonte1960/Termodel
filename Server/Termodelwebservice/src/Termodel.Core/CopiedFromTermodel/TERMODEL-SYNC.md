# TERMODEL-SYNC — copie desktop temporanee

Stato generale: `PENDING`.

Questa directory contiene copie selettive e adattate del motore Termodel
desktop. Non costituisce una seconda Library autorevole. Ogni modifica deve
restare minima, commentata e confrontabile con il riferimento indicato.

| Copia Service | Riferimento desktop GitHub | Stato |
|---|---|---|
| `Leggidxf/Confini.cs` | `SorgentiTermodel/Library/leggidxf/Confini.cs` | PENDING |
| `Leggidxf/DXFLineCheck.cs` | `SorgentiTermodel/Library/leggidxf/DXFLineCheck.cs` | PENDING |
| `Leggidxf/GeneraModello.cs` | `SorgentiTermodel/Library/leggidxf/GeneraModello.cs` | PENDING |
| `Leggidxf/GeneraPianta.cs` | `SorgentiTermodel/Library/leggidxf/GeneraPianta.cs` | PENDING |
| `Leggidxf/LeggiDxf.cs` | `SorgentiTermodel/Library/leggidxf/LeggiDxf.cs` | PENDING |
| `Leggidxf/Tetti.cs` | `SorgentiTermodel/Library/leggidxf/Tetti.cs` | PENDING |
| `Model/Polig3D.cs` | `SorgentiTermodel/Library/leggidxf/Polig3D.cs` | PENDING — BYTE-IDENTICAL, Git blob `d7d835a8a39febb3c3b26bcb88a8cc5cebb19411` |
| `Model/Modello.cs` | `SorgentiTermodel/Library/Modello.cs` | PENDING — adattamento headless FIN: usa `spessoreParete` per profondità/centratura così il serramento attraversa la mesh opaca ospite; Desktop Library non modificata |
| `SpiraliGPT/ChiudiSpirale.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/ChiudiSpirale.cs` | PENDING — BYTE-IDENTICAL, Git blob `e7e02e07fc5a5c6c1271a565e4dca115ed4ad9c4` |
| `SpiraliGPT/Program.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/Program.cs` | PENDING — BYTE-IDENTICAL, Git blob `60bb4ff3ed9d323fd3437a107c0c0e7db3d07f79` |
| `SpiraliGPT/SpiralDiagnostics.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/SpiralDiagnostics.cs` | PENDING — BYTE-IDENTICAL, Git blob `a26424a41bd42e516c086678e8e1c1d460afeb1f` |
| `SpiraliGPT/Spiralgenerator.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/Spiralgenerator.cs` | PENDING — BYTE-IDENTICAL, Git blob `1c890127b32591bf33c253f0135222313be6dab3` |
| `SpiraliGPT/Utilityfunctions.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/Utilityfunctions.cs` | PENDING — BYTE-IDENTICAL, Git blob `99c4d2487e7fe590736a39eb3e824300d0ed1b92` |

| `SpiraliVittorio/Program.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Program.cs` | PENDING — BYTE-IDENTICAL, Git blob `6adf6b75c0e41ffe29d4bd1b30a5957def51b019` |
| `SpiraliVittorio/Spiralgenerator.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Spiralgenerator.cs` | PENDING — BYTE-IDENTICAL, Git blob `d80d13b535581030f1bd6a3599cee96d203681a4` |
| `SpiraliVittorio/Utilityfunctions.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/Utilityfunctions.cs` | PENDING — BYTE-IDENTICAL, Git blob `fc233a9d72a3a93326dbb00ddd3ecde9157d984e` |
| `SpiraliVittorio/ChiudiSpirale.cs` | `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/ChiudiSpirale.cs` | PENDING — BYTE-IDENTICAL, Git blob `765b08c3edb90f14a2bbee5255a911b509b01774` |

`SpiraliDiegoVittorio/` è invece un ramo derivato interno al Service, non una
seconda copia Desktop da sincronizzare. Nasce dai quattro file
`SpiraliVittorio` al commit `d7bc36c`; nella fotografia iniziale cambia
esclusivamente il namespace in `SpiralHeatingDiegoVittorio`. Provenienza e
SHA-256 dei sorgenti di partenza sono registrati nel relativo `README.md`.
Qualsiasi futura sperimentazione deve avvenire in questa cartella, lasciando
`SpiraliVittorio` byte-per-byte intatto come riferimento e ripristino.

Il sorgente autorevole Desktop di `TermodelLog` è ora disponibile come copia
non adattata in `SorgentiTermodel/Library/utilities/TermodelLog.cs`:

```text
origine locale: utilities/TermodelLog.cs
SHA-256: 79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218
```

Il Service continua a usare
`Compatibility/LegacyCoreAdapters.cs::TermodelLog`. Il confronto conferma che
non è una copia mancante da inserire nel runtime, ma un adattatore necessario:
il Desktop scrive file globali sotto `GestProg.ProgramPath`, usa WPF per
mostrare il primo errore e contiene diagnostica grafica dipendente da xBIM/NTS;
il Service deve invece isolare la richiesta con `AsyncLocal`, restituire la
diagnostica a `GeneraModello` e pubblicarla transazionalmente nel workspace del
`projectId`.

Le categorie Desktop autorevoli sono `Sempre`, `colmi`, `spezza`, `Error`,
`Svg`, `RedrawHelix`, `GeneraModello`, `Performance` e `PontiAutomatici`.
I flag costanti del Desktop corrente abilitano soltanto
`PontiAutomatici`.

L'adattatore headless usa ora gli stessi nomi categoria ma mantiene una
semantica server compatibile con il comportamento già pubblicato:

- senza opzioni esplicite di calcolo, tutte le scritture dirette vengono
  raccolte e `IsEnabled(...)` resta falso;
- con `logCategories` esplicito, la configurazione è per-request tramite
  `AsyncLocal`: `IsEnabled(...)` e le scritture dirette rispettano
  esclusivamente le categorie selezionate;
- `LogOperation` è associato a `Sempre`, `LogError` a `Error`;
- `logEnabled=false` spegne la raccolta soltanto per la richiesta corrente.

Questa configurazione non viene riportata nel file progetto e non modifica il
riferimento Desktop: è un adattamento di hosting/diagnostica del Service.

Il supporto desktop `SorgentiTermodel/Library/utilities/ErrorManager.cs` è
sostituito nel Service da un sink diagnostico headless in
`Compatibility/LegacyUiDummies.cs`.

La Library rimane la sola raccolta consultiva: può essere integrata soltanto con
copie non adattate di sorgenti desktop selezionati, dopo autorizzazione esplicita
e verifica SHA-256. Gli adattamenti continuano a vivere nel Service o in Work.

Riferimenti integrati il 21 settembre 2026:

- `Modello.cs`: `7B201DA17781CB2682EC9AF25D798B753EC590850031572A4A07E63975B125F0`;
- `utilities/ErrorManager.cs`: `6A7E93D009526D4DA5ED0F800B6155AB0B90C52237C13E76CEC52C4204863ECD`.

Riferimento integrato il 23 settembre 2026:

- `utilities/TermodelLog.cs`: `79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218`.

Copie temporanee integrate il 25 settembre 2026 per rendere selezionabile il motore Vittorio nel Service senza modificare la Library Desktop:
- `SpiraliVittorio/*.cs`: copie byte-identical dei quattro sorgenti necessari (`Program.cs`, `Spiralgenerator.cs`, `Utilityfunctions.cs`, `ChiudiSpirale.cs`); nessun adattamento applicato. La duplicazione e' temporanea e resta `PENDING`.

Ramo sperimentale creato il 27 settembre 2026:
- `SpiraliDiegoVittorio/*.cs`: copia iniziale di `SpiraliVittorio` con il solo namespace indipendente; selettore `Diego_Vittorio`. Non sostituisce né modifica la copia Vittorio e non deve essere ricopiato nella Library Desktop senza una successiva decisione esplicita.
- 30/09/2026: le personalizzazioni Diego sono centralizzate in `SpiraliDiegoVittorio/funzioni_diego.cs`, sorgente sperimentale **Service-only**, senza corrispondente Desktop e quindi senza target di sincronizzazione. Espone `ritorno_Parallelo_diego(...)`, `chiusura_diego(...)` e `raccorda_diego(...)`. `ritorno_Parallelo_diego` costruisce l'offset rettilineo segmento-per-segmento; `raccorda_diego` contiene la raccordatura circolare finale LG-051 con raggio non ridotto e discretizzazione adattiva. `Vittorio_revisionato` usa direttamente queste tre funzioni nel percorso pubblico; il vecchio bridge `PreparaRitornoRettilineoVittorio` non è più richiamato da `Vittorio_revisionato`.
- 01/10/2026: `chiusura_diego(...)` contiene ora anche l'**implementazione autorevole** della combinatoria rettilinea finale `0I,0P,1I,1P,2I,2P` simmetrica su Mandata/Ripresa, normalizzazione esatta a `P`, filtro `>=2P`, esclusione angoli acuti, controllo del solo tratto di chiusura contro i tratti non adiacenti del setup risultante e arresto al primo successo. La vecchia implementazione privata (`GeneraPrimaChiusuraAccettabile`, proiezioni `RP*`, preferenza `P/I` e relativi helper combinatori) è stata rimossa da `SpiraliDiegoVittorio/ChiudiSpirale.cs`; i bridge compatibilità delegano a `funzioni_diego.chiusura_diego(...)`.

Copie temporanee integrate il 23 settembre 2026 per attivare l'esecutivo pannelli con il motore GPT Desktop corrente:
- `SpiraliGPT/*.cs`: copie byte-identical dei cinque sorgenti elencati nella tabella; nessuna modifica al motore in questa milestone. Il Service li usa con il default Desktop corrente `PassoTubi=0,30 m`. La duplicazione resta `PENDING` e dovrà essere eliminata quando il motore condiviso avrà un ingresso headless stabile.

Obiettivo progressivo: eliminare le copie quando il codice cruciale potrà essere
condiviso realmente fra desktop e Service senza dipendenze WPF, Helix o IFC.


Ramo sperimentale creato il 28 settembre 2026:
- `SpiraliVittorioRevisionato/*.cs`: nuova copia di `SpiraliVittorio` usata
  esclusivamente per ricostruire in modo controllato l'astrazione Supply/Return.
  La fotografia iniziale differiva dal riferimento Vittorio soltanto per il
  namespace `SpiralHeatingVittorioRevisionato`.
- selettore Harness: `Vittorio_revisionato`;
- parità iniziale sul quadrato verificata nel run `36465582271`: SVG e XML
  byte-identici al riferimento Vittorio;
- prima astrazione controllata introdotta in `Spiralgenerator.cs`:
  `SpiralGenerationInput` + linee/distanza di condizionamento opzionali;
- il core mantiene l'ordine geometrico di Vittorio e il condizionamento agisce
  soltanto come gate: arresta il percorso al primo segmento non ammesso, senza
  rerouting, corridoi, trim o fallback;
- run `36466606034` SUCCESS: parità Vittorio ancora conservata;
  probe neutro equivalente, Supply 37 punti, secondo percorso non condizionato
  38 punti, percorso condizionato dalla Supply a 0,15 m fermo a 1 punto;
- collaudo multi-progetto run `36503404032`: SVG + XML byte-identici a
  Vittorio su 6 casi (quadrato, concavo, trapezio, connection-terminal,
  appartamento corrente, progetto pubblico pannelli);
- dal 29/09/2026 è selezionabile nel Service **solo per-request** tramite
  `spiralEngine=Vittorio_revisionato`; il default resta `Diego_Vittorio`;
- frontend pubblico v1.36 espone la scelta in Help per il collaudo
  collaborativo; il file progetto non viene modificato;
- smoke locale override e verifica deploy pubblico: SUCCESS nel Service Build
  `36504429395`;
- dal 29/09/2026 il percorso pubblico `Vittorio_revisionato` è
  temporaneamente in modalità **solo mandata** per esame visivo:
  `Program.SoloMandataPerEsameVisivo = true`;
- in questa modalità `AggiornaSpirali()` genera la mandata ma non richiama
  `ChiudiSpiraleFiles()`; chiusura e Return restano presenti nel sorgente e
  sono soltanto sospesi;
- lo SVG pre-chiusura viene riclassificato graficamente come mandata rossa per
  essere pubblicato nel layer `*_PannelliMandata_Output`;
- il benchmark di equivalenza usa `AggiornaSpirali(false)`, quindi continua
  a testare il flusso completo storico contro Vittorio;
- Service Build #1076: build SUCCESS, smoke override
  `Vittorio_revisionato` SUCCESS con
  `VITTORIO_REVISIONATO_SUPPLY_ONLY_OK`, verifica deploy pubblico SUCCESS;
- questa pubblicazione NON promuove la copia a motore default e NON genera
  ancora un Return autonomo utilizzabile; serve a raccogliere casi reali prima
  della prossima decisione algoritmica;
- vietato importare euristiche da `SpiraliDiegoVittorio` senza test e
  decisione esplicita;
- stato duplicazione: PENDING.


### 2026-09-29 — deviazione sperimentale ripristinabile Vittorio_revisionato
- `SpiraliVittorioRevisionato/Spiralgenerator.cs`: aggiunto supporto opzionale `TerminalCenterline` per completare la fascia centrale dei rettangoli dopo l'ultimo anello chiuso valido.
- `SpiraliVittorioRevisionato/Program.cs`: la modalità pubblica SOLO MANDATA abilita l'opzione; `AggiornaSpirali(false)`/benchmark storico la mantiene disabilitata.
- Rollback: impostare `TerminalCenterline=false`; nessuna modifica necessaria ai sorgenti Vittorio originali.
- Fast Harness `36510946051`: SUCCESS, equivalenza multi-progetto storica preservata.
- Commit finale: `514bb71add522115dfb8358514ce712aa1d8bdf2`.


### 2026-09-29 — riuso diretto chiusura Diego_Vittorio in Vittorio_revisionato
- Il percorso pubblico di `SpiraliVittorioRevisionato/Program.cs` non duplica la chiusura Diego: dopo la propria Supply richiama direttamente `SpiralHeatingDiegoVittorio.ChiudiSpirale.Chiudi` con gli stessi parametri di posa.
- `AggiornaSpirali(false)` conserva il percorso storico per i benchmark di equivalenza.
- Fast Harness #75 SUCCESS; smoke pubblico revisionato completo SUCCESS nel Service Build #1089.
- Commit funzionale: `d86a96cc1dcc3cd4293a99da4712184088175b57`.


### 2026-09-29 — correzione: Return Vittorio, solo raccordo Diego
Correzione esplicita della precedente interpretazione: il percorso pubblico `Vittorio_revisionato` mantiene mandata approvata + `TerminalCenterline`, genera il **Return con la duplicazione/offset storica Vittorio** e NON usa il Return autonomo Diego. Da `Diego_Vittorio` viene riusata direttamente soltanto `CreaCurvaCollegamentoAdattiva` per il raccordo finale migliorato; la chiusura/etichetta resta nel post-processore revisionato. Il benchmark storico resta isolato col raccordo Vittorio originale. Commit finale `8117c6e6629c61eaec0baade6f904ce90cb3f9b5`. Fast Harness #82: build, equivalenze Vittorio, regression pubbliche e fitting: SUCCESS. Service Build #1099: build + smoke pannelli + smoke pubblico Vittorio_revisionato + verifica deploy: SUCCESS; rosso globale solo nello smoke storage/lock indipendente.


### 2026-09-29 — adattamento verso Return Vittorio per chiusura Diego
Il collaudo visivo sul commit cb93b674 ha mostrato diagonali rosse ancora presenti. Causa individuata: incompatibilità di **verso della lista Return**. `CreaCurvaCollegamentoAdattiva` Diego usa `ritorno[^1]` come terminale centrale, mentre `CreaRientro` Vittorio memorizza il terminale centrale in `rientro[0]`. L'adattatore ora inverte temporaneamente il Return solo all'ingresso delle routine Diego (chiusura + raccordo) e lo reinverte in uscita; la geometria del Return Vittorio non viene rigenerata né modificata come algoritmo. Commit `2205e2427a27b925c209bd38019d3af030b7d5d6`. Pubblicato su main; CI #85 / Service #1105 avviate. Necessaria conferma visiva sul progetto reale per dichiarare risolta la diagonale.


### 2026-09-29 — ripristino esclusione raccordi con intersezione
Il controllo visivo ha evidenziato raccordi centrali che attraversavano tratti della serpentina. È stata ripristinata in modo esplicito la regola Diego_Vittorio: `CreaCurvaCollegamentoAdattiva` prova le Bézier candidate e, se nessuna è libera, valida anche la retta finale contro mandata e ritorno; se interseca, restituisce nessun raccordo invece di forzare il segmento. `Vittorio_revisionato` rispetta l'esclusione senza introdurre fallback propri. Return Vittorio e mandata approvata restano invariati. Commit finale `e588acabf00274b2550efcda668415102a33dd9c`; CI #87 / Service #1110 avviate.


### 2026-09-29 — chiusura U per Return Vittorio parallelo
Caso quadrato reale: terminali centrali mandata/Return paralleli e in verso opposto restavano aperti. Il raccordo generico Diego limitava la maniglia Bézier a distanza/3, insufficiente per una inversione a U di 180°. Aggiunta in `CreaCurvaCollegamentoAdattiva` una famiglia candidata U-turn quando il prodotto scalare delle tangenti <= -0.90, con maniglia base 2/3 della distanza tra terminali e tentativi decrescenti. Ogni candidata resta obbligatoriamente soggetta ai filtri anti-intersezione contro mandata e Return; nessun fallback intersecante. Mandata e Return Vittorio invariati. Commit `252022fff9b1f15205fddfcbb7481422e0826ad4`; Fast Harness #88 / Service #1114 avviati.


### 2026-09-29 — uso integrale procedura combinatoria Diego_Vittorio
Il test quadrato ha confermato che non va introdotta una nuova euristica U-turn. Rimossa la strategia aggiunta nel commit 252022f. Il percorso pubblico ora passa mandata revisionata + Return Vittorio duplicato, orientato soltanto come richiesto dall'API Diego, a un unico wrapper della procedura già esistente `GeneraPrimaChiusuraAccettabile`: enumerazione M0..M4, R0..R6 e RP, cancellazione/accorciamento terminali, test lunghezza/angoli/intersezioni, selezione candidato; solo sulla configurazione selezionata viene chiamato il raccordo adattivo esistente. Nessuna seconda chiamata indipendente che perda il candidato combinatorio. Commit integrazione `436de80eb7d1b657e37f92ce3a891174913e9499`; Fast Harness #90 / Service #1119 avviati.


### 2026-09-29 — quadrato pubblico chiuso in Harness
Correzione verificata dal gate dedicato Harness #100. Causa finale: l'adattamento del Return Vittorio alla combinatoria Diego richiedeva (1) lavorare sulle polilinee rettilinee prima dei fillet, (2) conservare il lato/segno dell'offset Vittorio e (3) usare la scala coerente col Return a metà passo. La procedura di chiusura interna Diego_Vittorio è stata ripristinata al riferimento umano consolidato `fb26ed0`; sono presenti soltanto bridge/adattatori esterni. Gate `Harness quadrato Vittorio_revisionato public closure`: SUCCESS; equivalenze, square Diego, public square, locale_1/5/8/9 e fitting regression: tutti SUCCESS. Commit funzionale corrente `8dc095b323b811ad97c30bcfd7794d51ce3acc50`. Nessuna nuova euristica di chiusura sostituisce Diego_Vittorio.


### 2026-09-29 — vincolo chiusura minimo 2P ripristinato
Corretto l'adattatore Vittorio/Diego: la scala geometrica del Return resta P/2, ma il criterio di accettazione della chiusura resta quello originale umano `lunghezza >= 2P` riferito al passo nominale. Prima il passaggio di P/2 alla combinatoria riduceva involontariamente la soglia a P. Commit `9f178819b9412d212fa06091c25c66b62216583d`. Harness #101: build SUCCESS e gate quadrato pubblico con vincolo corretto SUCCESS; suite restante in esecuzione al momento della pubblicazione.

### 2026-09-29 — convenzione P corretta e limite chiusura Vittorio_revisionato
Questa nota prevale sulle descrizioni storiche sopra che parlano di Return a "meta passo". Convenzione vincolante: `P` = Mandata-Ripresa, `2P` = Mandata-Mandata, `P/2` = Mandata-Parete. L'adattatore Vittorio_revisionato passa ora `P` direttamente alla combinatoria Diego_Vittorio; la soglia di chiusura resta `>= 2P`. La ricerca e' limitata a 0..2 tratti rimossi per lato e il terminale in modalita' `P` viene portato esattamente a `P`, anche allungandolo quando necessario. Fast Harness non eseguito per disposizione utente.

### 2026-09-29 — Vittorio_revisionato: chiusura quadrato M2P/R0P
Correzione verificata e pubblicata nel commit `e60d9ed9c5536852dbb60c146cdb6abb72957e87`. Nel quadrato `P=0,15 m`, la configurazione corretta e' `M2P/R0P`: Mandata elimina due tratti e porta il nuovo terminale a P; Return non elimina tratti e porta il proprio terminale a P. Il vecchio bridge la scartava prima del raccordo perche' confrontava la corda fra gli estremi (`0,212132 m`) con `2P=0,30 m` e applicava anche un filtro angolare alla stessa corda. Per il solo bridge Vittorio_revisionato questi filtri rettilinei sono ora rinviati e la validita' e' decisa sul raccordo curvo finale e sulle intersezioni; le varianti P vengono provate prima delle invarianti. I default del percorso Diego_Vittorio restano separati. Gate quadrato dedicato: SUCCESS con selezione esplicita `M2P/R0P` e terminali entrambi a `0,15 m`.

### 2026-09-29 — vincolo finale 2P sulla curva di raccordo
Ulteriore chiarimento alla chiusura M2P/R0P: `2P` non e' il minimo della corda rettilinea fra gli estremi, ma il minimo della **lunghezza reale del raccordo curvo finale**. Il bridge Vittorio_revisionato passa ora `2P` a `CreaCurvaCollegamentoAdattiva`; la Bezier viene estesa progressivamente entro la lunghezza dei terminali e accettata solo se la sua polilinea misura almeno `2P` e resta priva di intersezioni. Sul quadrato P=0,15 il gate ha misurato `0,300501402127749 m >= 0,30 m`, mantenendo la selezione `M2P/R0P`. Commit funzionale `d0fd8c372792998a16bb3c78c998d86498a7872c`, diagnostica finale `633acf94f27c797580402c24de762592bb9c7af7`, Harness run `36553567099` SUCCESS sul gate mirato.

### 2026-09-29 — rollback alla geometria pre-P030 per regressione blu esterno
Il collaudo server ha mostrato il Return blu all'esterno della stanza dopo la
normalizzazione runtime P=0,30; il successivo gate "no acute angles" non ha
risolto la cuspide. Su richiesta utente main e' stato riportato con un normale
commit (nessun force-push) al tree esatto di
`c4c7f1ff2b621090a74ec258b3e730377006a728`.
Commit rollback: `db13de55c3589a2d6ef8ad5380944295758d7570`.
Sono quindi inattive le modifiche `699359e`, `17403b4`, `cfae98d`,
`0080202` e `10e77fa`. Il baseline torna a `PassoTubi=0,30`,
distanza parete Supply `0,30` e distanza Return/chiusura `0,15`.
La conferma che il blu esterno sia scomparso resta una prova visiva manuale
successiva al deploy.

### 2026-09-30 — LG-051 Vittorio_revisionato
- `SpiraliVittorio` resta invariata.
- `SpiraliVittorioRevisionato` separa scelta della chiusura rettilinea e
  raccordatura successiva.
- Il bridge riusa la combinatoria Diego con filtri rettilinei >=2P, angoli e
  intersezioni, senza Bézier nella decisione.
- La raccordatura finale è locale a Vittorio_revisionato: archi circolari
  tangenti, raggio default 0,10 m non riducibile e discretizzazione adattiva
  con tolleranza default 5 mm.
- Il benchmark `AggiornaSpirali(false)` conserva il percorso storico.
- Duplicazione ancora `PENDING`; nessuna modifica alla Library Desktop.

### 2026-09-30 — chiusura configurabile Vittorio_revisionato
- Nessun nuovo motore `Vittorio_modificata` è stato creato: la richiesta è stata corretta dall'utente prima di qualunque sorgente con quel nome.
- `SpiraliVittorio` resta intoccabile.
- `SpiraliVittorioRevisionato/Program.cs` espone `AggiornaSpiraliConChiusura(bool)`; `AggiornaSpirali()` conserva il default chiuso.
- `SpiraliVittorioRevisionato/ChiudiSpirale.cs` accetta `chiudiCircuito`: quando è `false`, mantiene Mandata e Return ma salta la combinatoria di chiusura, la curva finale e l'etichetta `ChiusuraGPT`.
- Il Service espone il parametro per-request `spiralClosure=true|false`, inoltrato soltanto al comportamento pubblico di `Vittorio_revisionato`.
- Il frontend v1.38 espone **Help → Motore spirali — test pubblico → Chiudi circuito**; la scelta non viene salvata nel progetto.
- Stato duplicazione: invariato `PENDING`; nessuna modifica alla Library Desktop.



### 2026-10-01 — Vittorio_revisionato: Generate storico preservato come recovery

Decisione consolidata e implementata:
- `SpiralGenerator.Generate(...)` mantiene il contratto storico Vittorio a
  distanza unica ed è la baseline di recovery della sola Mandata;
- `SpiralGenerator.GenerateRevisionato(...)` è il nuovo percorso Service-only
  per `Vittorio_revisionato` con ruoli geometrici separati:
  `DistanzaParete=P/2`, `DistanzaMandataMandata=2P`,
  `DistanzaFinalizzazione=P`;
- `Program.DistanzaRitorno=P`;
- `Program.AggiornaSpiraliConChiusura(..., usaGenerateStoricoRecovery:true)`
  permette il ripristino circoscritto della Supply storica senza revert globale;
- il recovery non modifica `ritorno_Parallelo_diego`, `chiusura_diego` o
  `raccorda_diego`;
- `SpiraliVittorio` e la Library Desktop restano invariati;
- la divergenza di `SpiraliVittorioRevisionato` rispetto alla copia Desktop è
  intenzionale, Service-only e resta `PENDING` finché la logica non sarà
  condivisa nel Core senza duplicazione.

Commit funzionali principali:
- `2d6dc35f58541f4a5c32e17d74a7f749659a1dd6`;
- `4228c4b9e8a78eb4305af3a391c82815f688e1ee`.



### 2026-10-01 — recovery pubblico dopo fallimento visivo del candidato P/2-2P
- Il percorso pubblico `Vittorio_revisionato` usa nuovamente per default il
  `SpiralGenerator.Generate(...)` storico a distanza unica.
- `GenerateRevisionato(...)` resta presente ma disattivato dal default; è
  richiamabile solo esplicitamente per analisi future.
- La decisione nasce dal controllo visivo reale dell'utente, che ha giudicato
  non accettabile la geometria P/2-2P pubblicata.
- Commit recovery: `dd7d411ab3de9223ec7d927aed407d59c60aa62e`.
- Nessuna modifica al riferimento `SpiraliVittorio` o alla Library Desktop.

