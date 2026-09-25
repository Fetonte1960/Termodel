# TERMODEL CORE + WEBSERVICE — PROJECT SUMMARY

> **IMPORTANTE — notifica obbligatoria degli incarichi GitHub Actions**
>
> Per ogni incarico significativo eseguito via GitHub Actions applicare
> `.github/TERMODEL-ACTION-NOTIFICATIONS.md`: Commit Status
> `Termodel/job` con `RUNNING -> SUCCESS/FAILED` e push telefono a
> SUCCESS/FAILED. La regola è permanente e già verificata end-to-end.

Ultimo aggiornamento: **2026-09-25**  
Branch GitHub di riferimento: **main**  
Repository: `https://github.com/Fetonte1960/Termodel`

Questo è il documento autorevole di continuità per **Termodel.Core** e
**Termodel.WebService**. Non sostituisce né deve modificare il
`PROJECT-SUMMARY.md` della linea Web JavaScript.

Il contratto condiviso con il frontend è mantenuto separatamente in:

```text
docs/TERMODEL-FRONT-SERVICE-CONTRACT.md
```

Endpoint, artifact e orchestrazione comuni devono essere definiti lì; questo
Summary registra invece lo stato di implementazione del Service.

Il contratto condiviso formalizza inoltre i due file principali della
comunicazione: il payload tecnico `TERMODEL-PROJECT-TEXT-V1`, filtrato delle
risorse esclusivamente frontend prima di `POST /api/calculations`, e
`TermodelWebModel v3` come artifact `model3d` destinato al redraw 3D. Lo
schema dettagliato e le regole di compatibilità sono mantenuti esclusivamente
in `docs/TERMODEL-FRONT-SERVICE-CONTRACT.md`.


## 1. Regole per una nuova chat AI

Prima di intervenire:

1. leggere integralmente questo documento;
2. verificare branch, stato Git e commit successivi all'ultimo stato registrato;
3. leggere `README.md`, `docs/copied-from-termodel.md` e i documenti desktop
   pertinenti in `SorgentiTermodel/Library`;
4. proporre l'intervento e attendere autorizzazione;
5. non modificare `definizionedati/definizionedati.json` né la sua copia senza
   autorizzazione specificamente riferita a quel file;
6. non modificare il frontend `docs/termodel-ui-demo` salvo richiesta esplicita;
7. non introdurre refactoring estesi durante la migrazione selettiva;
8. distinguere sempre proposta, implementazione, compilazione, prova HTTP e
   confronto golden;
9. aggiornare questo summary quando cambiano contratti, stato o prossimi passi.
10. **Regola permanente di autorizzazione:** quando l'utente autorizza modifiche al progetto, registrare prima in questo Summary (e nel contratto condiviso se pertinente) le decisioni/lo stato concordati, quindi applicare le modifiche al codice; al termine aggiornare nuovamente lo stato reale se implementazione, build o test cambiano.
11. **Registro incarichi obbligatorio:** ogni autorizzazione esplicita a procedere deve creare, prima delle modifiche, una voce nel registro incarichi con `Stato: COMMISSIONATO`, descrizione concreta del lavoro e criteri di completamento. Quando il lavoro è terminato, la stessa voce deve essere aggiornata a `Stato: ESEGUITO`, indicando risultato reale, build/test effettuati e commit. Se la chat termina durante il lavoro, la voce deve restare `COMMISSIONATO`: la chat successiva deve considerarla lavoro affidato ma non ancora concluso e riprenderla prima di dichiararla eseguita.
12. **Snapshot diagnostico permanente:** quando l'utente chiede di esaminare una sessione reale del Service, prima di chiedere copie manuali di SVG/DXF/JSON/report/log leggere
   `Server/Termodelwebservice/docs/SERVICE-SNAPSHOT-DIAGNOSTIC.md` e il branch
   `service-snapshots`. La sequenza standard è
   `service-snapshots/LATEST.json -> manifest.json -> artifact/log reali`.
   L'utente deve normalmente fare soltanto `Aggiorna Modello`, pubblicare
   lo snapshot e dire `esamina l'ultimo snapshot`.
13. **Debug avanzato permanente con GitHub Actions:** per problemi complessi che richiedono riproduzione reale leggere
   `Server/Termodelwebservice/docs/ADVANCED-GITHUB-ACTIONS-DEBUG.md`.
   Se la natura del problema non è già nota, chiedere quale anomalia va
   riprodotta; se serve un progetto reale e non è già disponibile, chiedere
   il `TERMODEL-PROJECT-TEXT-V1`. Usare GitHub Actions per compilare e
   avviare il Service, inviare il progetto, raccogliere response/artifact/log,
   aggiungere se necessario strumentazione diagnostica temporanea e ripetere
   il ciclo test -> analisi -> correzione -> nuovo test fino alla soluzione
   o a un impedimento concreto. Al termine rimuovere la strumentazione
   occasionale e lasciare solo correzioni/regression test utili.
14. **Notifica GitHub Actions — IMPORTANTE:** ogni Action usata per un incarico operativo o debug deve seguire `.github/TERMODEL-ACTION-NOTIFICATIONS.md`. All'avvio pubblicare `RUNNING` nel Commit Status `Termodel/job`; nello step finale `always()` pubblicare `SUCCESS` o `FAILED` e inviare una sola notifica push tramite il secret `TERMODEL_NTFY_TOPIC`. Non usare polling e non esporre mai il valore del secret.

## 1.1 Registro incarichi autorizzati

### INCARICO 2026-09-25 — Correzione selezione closure StrategiaDiego sul quadrato
Stato: COMMISSIONATO

Commissionato:
- usare il log reale `SpiraliDiego` del quadrato 4x4 per individuare perché
  le soluzioni più sviluppate vengono scartate mentre sopravvive una closure
  prematura con pochi punti;
- correggere esclusivamente `StrategiaDiego`, mantenendo invariati GPT e
  Vittorio;
- non introdurre euristiche specifiche del solo quadrato se il difetto può
  essere corretto con una regola generale di terminale/closure;
- preservare le linee guida già consolidate, inclusi vincoli geometrici,
  troncature e comportamento concavo/convesso;
- eseguire GitHub Actions sul banco quadrato con categoria
  `SpiraliDiego` attiva;
- recuperare e confrontare `pannelli-esecutivo.svg` e
  `TermodelLog-SpiraliDiego.md` reali prima/dopo.

Criteri di completamento:
- Action SUCCESS;
- SVG quadrato realmente recuperato;
- la soluzione finale non deve più essere la closure prematura da 4+4 punti
  se esiste una soluzione geometricamente valida più sviluppata;
- log sufficiente a spiegare la nuova selezione;
- verificare e, se necessario, correggere il seed iniziale: il tubo di ingresso deve restare connessione al locale e non determinare direttamente la posizione della prima traccia parallela; la prima traccia utile deve essere agganciata alla maglia `distacco iniziale + n*passo`; aggiungere log più dettagliati se necessari per provarlo;
- Summary aggiornato e Issue #1 chiusa Completed.


### INCARICO 2026-09-25 — Logging diagnostico SpiraliDiego + Copia log
Stato: ESEGUITO

Commissionato:
- introdurre una categoria log dedicata **SpiraliDiego** nei punti strategici di `StrategiaDiegoEngine`;
- registrare almeno: ingresso locale, radice mandata/ritorno, espansione nodo, scelte candidate, rifiuti geometrici principali, terminali, closure preliminari, scelta finale;
- integrare la categoria `SpiraliDiego` nelle opzioni log già esposte dal Service;
- aggiornare il frontend affinché mostri la nuova voce nel menu Help > LOG AGGIORNA MODELLO;
- aggiungere al frontend il comando **Copia log negli appunti**, abilitato quando è disponibile un log aggiornato;
- preservare le categorie log esistenti e la retrocompatibilità del contratto;
- usare GitHub Actions per eseguire un test con log SpiraliDiego attivo sul caso quadrato e recuperare l'artefatto log reale;
- non modificare gli algoritmi Vittorio/GPT/Diego in questa attività oltre all'instrumentazione diagnostica.

Criteri di completamento:
- categoria SpiraliDiego selezionabile dal frontend;
- log Diego realmente scritto dal Service;
- Copia log negli appunti operativa;
- GitHub Actions SUCCESS;
- artifact log recuperato e ispezionato;
- Summary aggiornato e Issue #1 chiusa Completed.



Risultato reale:
- aggiunta nel Core headless la categoria Service-only `SpiraliDiego`;
- la Library Desktop resta invariata con le nove categorie storiche;
- `StrategiaDiegoEngine` registra, quando la categoria è attiva:
  - START e parametri ricerca;
  - locale e tubo di collegamento;
  - ENTRY con punto/direzione/parete;
  - radice iniziale mandata e ritorno;
  - espansione nodi e scelte `PROSEGUI_DRITTO/PARALLELA_A/PARALLELA_B`;
  - candidati accettati/rifiutati;
  - motivi geometrici principali di rifiuto;
  - terminali;
  - closure accettate/rifiutate;
  - aggiornamenti BEST;
  - soluzione SELECT finale;
- scoperto durante la prima Action che il buffer AsyncLocal di
  `GeneraModello` non può essere riletto dal chiamante dopo l'await:
  corretto il wiring inizializzando un secondo buffer, con la stessa
  configurazione, esclusivamente per l'esecutivo/StrategiaDiego e concatenando
  poi `result.Diagnostics + executiveDiagnostics`;
- `logCategories=all` abilita ora 10 categorie headless:
  9 Desktop + `SpiraliDiego`;
- frontend portato a **v1.19**:
  - checkbox Help > LOG AGGIORNA MODELLO > `spiralidiego`;
  - comando `Copia log negli appunti`;
  - il comando resta disabilitato finché non esiste un log aggiornato per il
    projectId corrente;
  - dopo `Aggiorna Modello` con almeno una categoria selezionata, il frontend
    legge `GET /api/projects/{projectId}/logs/termodel`, conserva il testo in
    cache e abilita il comando;
  - il click copia il buffer già recuperato, senza richiedere una nuova fetch
    asincrona prima dell'accesso clipboard;
- contratto Frontend-Service aggiornato a v1.26;
- documentata esplicitamente in `docs/copied-from-termodel.md` la natura
  Service-only della categoria.

Verifica reale:
- GitHub Actions finale run `36153837051`, job `108134090327`:
  **SUCCESS**;
- SUCCESS: frontend syntax/wiring, build Release, benchmark StrategiaDiego,
  smoke HTTP/log, feedback bridge, esecutivo quadrato, progetto radiante reale,
  appartamento corrente, snapshot e notifica terminale;
- smoke quadrato eseguito con
  `logEnabled=true&logCategories=SpiraliDiego`;
- artifact `strategia-diego-square-executive`, id `10872328670`,
  retention 90 giorni;
- artifact contiene:
  `StrategiaDiegoSquare4x4.project.tmdl`,
  `pannelli-esecutivo.svg`,
  `pannelli-esecutivo.dxf`,
  `TermodelLog-SpiraliDiego.md`,
  `test-metadata.json`;
- log reale recuperato: 1493 righe, 190239 byte,
  SHA-256 `58f705155feacc02564011393b7db2cb0531125fc20afd405f20831214e66a08`;
- marker reali del quadrato:
  90 scelte mandata, 222 scelte ritorno, 38 terminali,
  28 closure rifiutate, 2 closure accettate, 1 BEST update, 1 SELECT finale;
- il log rende immediatamente visibile la causa del risultato geometrico
  corrente: la soluzione finale scelta ha
  `merit=3.84m supplyPoints=4 returnPoints=4`, nonostante l'albero esplori
  percorsi molto più estesi; questo dato sarà il punto di partenza del prossimo
  audit della selezione/closure, senza modifiche algoritmiche in questo incarico.

Commit principali:
- `b4f7724df5a4f3604e3afc9f41c1c24e4b72fd3f` — categoria;
- `891148d3f1fbe7e2549cbdfcb5e4052595fddb14` — instrumentazione Diego;
- `8dcd1855ca40454b7465cdd80c9d84267ba6e64d` — buffer log esecutivo;
- `e4263cb7908f4223eb233729c434b6120085784f` /
  `dc64d3d2d8e3fa0a4cf84d7678a9bd00cd82f07a` — frontend v1.19;
- `6c5704ce01c5f8a99b2e5f7d5c9410452cf60d03` /
  `9e053ebc20d9afad5bdc66ada5ec86e547625a29` — smoke/artifact quadrato;
- `61a04038d3336bf9d87d0c1264d731d59a49f6a6` — all=10 categorie;
- `7e011b74b4b136ff4ae17a9058d868aa51159d25` — contratto v1.26.

### INCARICO 2026-09-25 — Secondo esempio frontend “Quadrato con pannelli”
Stato: ESEGUITO

Commissionato:
- consolidare il quadrato 4x4 già usato come test pannelli come esempio frontend stabile;
- esporlo nell'elenco `Apri esempio` con nome **Quadrato con pannelli**;
- posizionarlo come **secondo esempio** dell'elenco;
- riutilizzare il progetto/test autorevole esistente, evitando di creare un modello divergente;
- preservare il primo esempio esistente e la compatibilità degli altri esempi;
- verificare tramite GitHub Actions che il catalogo esempi e il caricamento frontend restino validi;
- non modificare `definizionedati.json` né la Library Desktop.

Criteri di completamento:
- “Quadrato con pannelli” compare come secondo elemento;
- il progetto si apre rapidamente dal frontend;
- il progetto contiene la geometria 4x4 e il tubo/rete pannelli necessari al calcolo;
- frontend build/smoke SUCCESS;
- Summary aggiornato;
- Issue #1 chiusa `Completed` per notifica ntfy.



Risultato reale:
- aggiunto `docs/termodel-ui-demo/examples/quadrato-con-pannelli.svg`;
- la geometria coincide con il banco rapido 4x4:
  - pareti E001..E004, quadrato 400×400 cm;
  - tubo T001 da (-50,200) a (50,200) cm;
  - layer `Unico_tubipannelli`;
  - rete `RAD-DEFAULT`;
  - locale R001 `Quadrato con pannelli`;
- il catalogo `docs/termodel-ui-demo/examples/catalog.json` espone ora:
  1. `Pannelli radianti`;
  2. **`Quadrato con pannelli`**;
- il secondo esempio usa `geometry: ./examples/quadrato-con-pannelli.svg`
  ed `executive: true`, quindi viene aperto dal percorso frontend
  `createStructuredProjectFromSvg()` e può richiedere l'esecutivo pannelli;
- nessuna copia concorrente della logica pannelli è stata introdotta;
- `definizionedati.json` e Library Desktop invariati.

Verifica reale:
- GitHub Actions run `36148860861`, job `108117367303`: **SUCCESS**;
- frontend JavaScript syntax: SUCCESS;
- regression catalogo: SUCCESS, inclusa posizione esatta come secondo esempio;
- build Release: SUCCESS;
- benchmark StrategiaDiego: SUCCESS;
- smoke esecutivo SVG/DXF: SUCCESS;
- progetto radiante reale: SUCCESS;
- banco appartamento corrente: SUCCESS;
- snapshot e notifica terminale: SUCCESS.

Commit principali:
- `e4e7d4e8809891640699bb448d4510cd01fe0576` — SVG esempio;
- `ee6ef269bf51ea6fa34d2aa67087b6c585420fc0` — secondo elemento catalogo;
- `1477c454f56cb0bf79db974f0dd4aed1426e85e4` — regression CI.

### INCARICO 2026-09-25 — Status bar Server <commit> · <strategia>
Stato: ESEGUITO

Commissionato:
- esporre dal Service l'identificativo breve del commit realmente in esecuzione;
- esporre dal Service il motore spirali effettivamente selezionato;
- far leggere questi dati al frontend all'avvio;
- mostrare nella status bar, quando il Service è pronto, il formato:
  `Server fc287c9b · Diego`;
- preferire il commit runtime fornito dall'ambiente Render quando disponibile;
- mantenere fallback locale/CI senza inventare un commit;
- non modificare il contratto dei calcoli né gli algoritmi Vittorio/GPT/Diego.

Criteri di completamento:
- endpoint/metadata Service espone commit e strategia effettiva;
- frontend mostra il testo richiesto;
- GitHub Actions SUCCESS;
- compatibilità con ambiente locale/CI verificata;
- Summary aggiornato e Issue #1 chiusa Completed.



Risultato reale:
- `GET /health` espone ora:
  `serviceCommit`, `serviceCommitShort` e `spiralEngine`;
- il commit runtime viene risolto nell'ordine
  `RENDER_GIT_COMMIT -> GITHUB_SHA -> SOURCE_VERSION`;
- il motore spirali è letto dal resolver autorevole del Core tramite
  `RadiantExecutiveGenerator.GetSelectedSpiralEngineName()`;
- il frontend è stato portato a **v1.18** e, dopo il collegamento al Service,
  mostra nella status bar il formato:
  `Server <8-char-commit> · <strategia>`;
- in ambiente senza commit runtime il fallback visuale è
  `Server locale · <strategia>`;
- contratto Frontend↔Service aggiornato a v1.25.

Verifica reale:
- GitHub Actions run `36138057522`, job `108080839413`: **SUCCESS**;
- build Release: SUCCESS;
- regression frontend: SUCCESS;
- smoke runtime identity: SUCCESS;
- output smoke:
  `service=20c9057a engine=Diego`;
- benchmark StrategiaDiego, smoke HTTP/storage, esecutivo SVG/DXF,
  progetto radiante reale, banco appartamento e snapshot: tutti SUCCESS;
- notifica terminale GitHub Actions: SUCCESS.

Commit principali:
- `1e0d7b3aef98c4fa6348f0b9ab7e8ba603c030e7` — espone strategia runtime;
- `aa168760340313c00b12d8cb065f2a450b37774a` — health commit + strategia;
- `049cdc6a8bb2955c0514a566908de27361c401a8` — status bar frontend;
- `200053dcd181e9726043a7692a9e013bfc397bbc` — frontend v1.18;
- `73128b8df4e37344ddd80da415e7c354098154c0` e
  `20c9057a9d2b2f5d4fb056b452b38ab57c7910dd` — regression CI finale;
- `bdad003838c391c0ecf38153ebafa66dc3eed182` — contratto v1.25.

Nota deploy pubblico:
- la modifica è consolidata su `main`;
- il comportamento runtime è verificato in GitHub Actions;
- il redeploy Render/GitHub Pages resta dipendente dai rispettivi sistemi di
  deploy e non viene dichiarato verificato dal solo CI.

### INCARICO 2026-09-25 — Verifica ottimizzazioni Codex StrategiaDiego su quadrato
Stato: ESEGUITO

Commissionato:
- verificare le ottimizzazioni realizzate da Codex su `StrategiaDiego`;
- usare come caso di riscontro il quadrato 4x4 già presente nelle fixture;
- verificare metriche, determinismo e geometria prodotta;
- recuperare l'SVG realmente prodotto dalla GitHub Action e mostrarlo all'utente;
- fornire feedback tecnico distinguendo ciò che è verificato da ciò che resta da validare;
- non modificare Vittorio/GPT, frontend, fixture autorevoli o `definizionedati.json`.

Criteri di completamento:
- ultime modifiche Codex identificate e confrontate col Summary/audit;
- Action reale verificata sul quadrato;
- `StrategiaDiegoSquare4x4.svg` recuperato dall'artifact;
- feedback tecnico conclusivo registrato.



Risultato reale:
- confrontato il delta Codex da `845bdcdd63e8c3f17979c517653fd643f329aea2`
  a `fc287c9b7ae9cfe30f8bfa1c7a8818962e54d392`: 7 commit, con modifiche
  concentrate su `StrategiaDiegoEngine`, benchmark, nuove fixture e workflow;
- audit `STRATEGIADIEGO-GPT-FUNDAMENTALS-AUDIT.md` verificato coerente con
  il codice: controllo segmento deterministico al posto dei 24 campioni,
  selezione del tratto terminale della rete di ingresso, linee di collegamento
  non assegnate come vincoli anti-attraversamento;
- confermata come scelta corretta la rinuncia ad applicare LG-035 tramite
  `node.Front`: senza uno stato orientato esplicito `S_k`, i run intermedi
  eliminavano terminali validi;
- l'albero Diego e il criterio di merito massimo LG-003 non sono stati
  sostituiti da euristiche GPT.

Verifica benchmark quadrato:
- rerun reale della build #495, run `36133802860`, nuovo job
  `108073316238`: **SUCCESS**;
- artifact nuovo `strategia-diego-benchmark`, id `10865175059`;
- fixture `StrategiaDiegoSquare4x4.locale.xml`, 20/20 iterazioni;
- 104 nodi massimi, 2 terminali accettati, profondità massima 10;
- p95 8 ms, memoria massima circa 508 kB;
- output deterministico e dentro tutti i budget;
- SHA-256 SVG motore:
  `257a97a5e831a5a56827dec6dd0ba3a22d26a20ca61aee76f40f99a314043df7`;
- hash identico alla precedente esecuzione #495: nessuna regressione
  geometrica sul quadrato causata dalle ottimizzazioni Codex.

Verifica esecutivo Service quadrato:
- esteso esclusivamente il test harness, senza modificare l'algoritmo, per
  pubblicare il vero `pannelli-esecutivo.svg` del progetto quadrato 4x4;
- commit harness `b8cd3f7589ac25db1ac52248bd410da435065ecb`;
- commit workflow `a2eec9074de9161e76b743531f6a7e6265cb5a99`;
- GitHub Actions run `36136180456`, job `108075400109`: **SUCCESS** su
  tutta la suite;
- artifact `strategia-diego-square-executive`, id `10865521237`, contiene
  il progetto TMDL realmente usato, SVG e DXF esecutivi;
- SVG esecutivo SHA-256:
  `26b202d7c9e923b542574499d46b06511f007e3ae324de71efca8da9cedf6aed`;
- l'esecutivo contiene 4 primitive: 2 contorni pianta pulita + mandata +
  ritorno; parete esterna 13 cm visibile;
- verifica distanze sul risultato reale:
  - prima evoluzione mandata: 0,45 m dalla faccia interna di ingresso;
  - arresto rosso rispetto alla parete frontale: 0,15 m = p/2;
  - ritorno blu rispetto alla parete laterale: 0,15 m = p/2.

Feedback tecnico:
- le ottimizzazioni Codex sui fondamentali geometrici sono confermate come
  miglioramenti di robustezza e non introducono regressioni sul quadrato;
- il quadrato a singolo ingresso non esercita da solo le due novità sulla rete
  ramificata; queste restano coperte dalle fixture
  `StrategiaDiegoConnectionTerminal` e dal progetto reale, entrambi SUCCESS;
- il disegno 4x4 mostra però chiaramente che **la strategia di copertura non è
  ancora completa**: la soluzione selezionata percorre soltanto una zona
  laterale del locale e chiude presto mandata/ritorno, lasciando gran parte
  del quadrato senza spirale;
- questo non è un difetto delle ottimizzazioni R3, che agiscono su
  `TrattoPossibile?` e vincoli geometrici; è un limite residuo del livello
  strategico/terminale/chiusura e non va trasformato in Golden Result;
- prossima analisi consigliata: capire perché sul quadrato il criterio
  terminale + chiusura preliminare accetta una soluzione con merito 4,1 m
  invece di proseguire nella copertura dell'intero locale.

Nessuna modifica a Vittorio/GPT, frontend, fixture autorevoli o
`definizionedati.json`.

### INCARICO 2026-09-25 — Riallineamento fondamentali geometrici GPT in StrategiaDiego
Stato: ESEGUITO

Commissionato:
- confrontare sistematicamente il motore `SpiraliGPT` con
  `StrategiaDiegoEngine` usando LG-001..LG-036 come specifica autorevole;
- distinguere i fondamentali geometrici riutilizzabili dalle euristiche di
  scelta che devono restare proprie dell'albero Diego;
- correggere esclusivamente StrategiaDiego affinché ogni ramo operi su
  geometria interna robusta, raccordi validi, distanze reali e continuità
  topologica, senza sostituire il criterio di merito massimo LG-003;
- aggiungere regression automatiche per ogni differenza corretta;
- non modificare i motori Vittorio/GPT, il frontend, la fixture appartamento o
  `definizionedati.json`;
- eseguire la suite GitHub Actions e la verifica visuale obbligatoria LG-036
  sul banco appartamento corrente.

Criteri di completamento:
- inventario differenze documentato con classificazione
  `fondamentale | differenza intenzionale | ancora da definire`;
- correzioni conformi alle LG e commentate secondo le regole del repository;
- benchmark quadrato/concavo e banco appartamento conclusi con successo;
- SVG reale prodotto dalla Action recuperato e condiviso con l'utente;
- stato `ESEGUITO` soltanto dopo verifica tecnica e visuale disponibile.

Risultato:
- creato `docs/STRATEGIADIEGO-GPT-FUNDAMENTALS-AUDIT.md` con classificazione
  `fondamentale | differenza intenzionale | ancora da definire`;
- sostituito il campionamento fisso a 24 punti con controllo deterministico di
  estremi, intersezioni col bordo e punto medio del segmento;
- la selezione dell'ingresso scarta ora i tratti che proseguono in un altro
  ramo e sceglie il terminale della rete LG-011;
- i tubi diversi dal collegamento assegnato sono vincoli
  anti-attraversamento; il collegamento assegnato resta il varco del locale;
- mantenuti invariati albero Diego, merito massimo LG-003, Vittorio e GPT;
- aggiunte fixture `StrategiaDiegoObliqueTrapezoid.locale.xml` e
  `StrategiaDiegoConnectionTerminal.locale.xml`;
- il benchmark verifica anche `ExpectedConnectionId` e il workflow fallisce
  realmente quando un `dotnet run` restituisce exit code non zero;
- nessuna modifica a frontend, fixture appartamento o
  `definizionedati.json`.

Verifica reale finale:
- GitHub Actions `TermodelService Build` run `36133802860`, build #495, job
  `108066963980`: **SUCCESS**;
- quadrato 4x4: 20 iterazioni, 104 nodi, 2 terminali, p95 8 ms,
  deterministico;
- concavo a L: 20 iterazioni, 183 nodi, 2 terminali, p95 21 ms,
  deterministico;
- trapezio obliquo: 20 iterazioni, 104 nodi, 2 terminali, p95 9 ms,
  deterministico;
- rete ramificata: 20 iterazioni, 56 nodi, 4 terminali, p95 5 ms,
  `T-B` selezionato come ingresso terminale, deterministico;
- build, smoke HTTP, esecutivo SVG/DXF, progetto radiante reale e banco
  appartamento StrategiaDiego: SUCCESS;
- artifact visuale `strategia-diego-current-apartment`, id `10862238283`,
  contenente il `pannelli-esecutivo.svg` realmente prodotto.

Diagnostica e correzioni intermedie:
- run #491 ha rivelato che PowerShell non propagava il fallimento dei
  benchmark nativi; il workflow è stato reso bloccante;
- run #492 ha quindi esposto correttamente la perdita dei terminali;
- run #493/#494 hanno dimostrato che applicare LG-035 usando `node.Front` come
  sostituto di `S_k` orientato è scorretto;
- il criterio offset precedente è stato conservato finché il nodo non
  memorizzerà esplicitamente lo stato orientato richiesto da LG-035;
- run #495 ha validato la correzione del varco di ingresso e l'intera suite.

Limiti dichiarati:
- R3 non copia da GPT arrotondamento, punteggio composito, offset concentrici
  o forcina avanzata, perché violerebbe LG-001/LG-003 o anticiperebbe LG-029;
- `STRATEGY-001`, chiusura avanzata e stato orientato completo LG-035 restano
  incarichi successivi dedicati.

### INCARICO 2026-09-25 — Rettifica arresto frontale Diego: 15 cm; quota ingresso mandata 45 cm
Stato: ESEGUITO

Rettifica utente consolidata dopo verifica:
- **0,45 m = 1,5p** resta la quota della prima evoluzione di mandata rispetto
  alla parete d'ingresso; serve a lasciare all'esterno la guida del ritorno;
- **0,15 m = p/2** è invece la distanza corretta di arresto del primo tratto
  quando questo arriva frontalmente a una parete architettonica;
- il bug introdotto nella correzione precedente consisteva nell'ereditare
  erroneamente i 0,45 m anche rispetto alla parete frontale successiva;
- rimossa quindi la logica speciale di "offset ereditato" alla prima svolta;
- il normale troncamento LG-006/LG-017 torna ad arrestare il tratto a p/2.

Criterio di completamento:
- ingresso mandata sul banco appartamento: circa 0,45 m dalla parete d'ingresso;
- primo tratto verso la parete destra: arresto a circa 0,15 m dalla parete;
- nessuna propagazione dei 0,45 m alla parete frontale;
- suite completa GitHub Actions SUCCESS;
- SVG reale del banco appartamento recuperato.

Risultato reale:
- codice finale: `d7c90f6b44d8153322548a37c115e0555bc46b4c`;
- regression finale: `c3f9409dd63169d4176c67dedeeb693668d2566b`;
- documentazione LG-013 rettificata in
  `bdf9e4b9bf350e3200d8d780ac00b03e27113744`;
- GitHub Actions run `36124421565`, job `108037147214`: **SUCCESS**;
- SUCCESS: build Release, benchmark StrategiaDiego, smoke HTTP, smoke
  esecutivo SVG/DXF, progetto radiante reale, banco appartamento corrente,
  snapshot e notifica finale;
- SVG reale: SHA-256
  `cd7d3d3c110c5f8f93c9f22b3b0323a483710aa46468c4e1002353bdcb83a28b`;
- artifact `strategia-diego-current-apartment`, id `10859711767`;
- geometria verificata nell'SVG reale:
  - parete destra interna: `x=8,13148`;
  - terminale rosso del primo tratto verso destra: `x=7,98148`;
  - distanza reale dalla parete destra: **0,15 m**;
  - tratto d'ingresso rosso: da `y=2,70628` a `y=2,25628`,
    quindi lunghezza **0,45 m**;
- fixture autorevole invariata; nessuna modifica a frontend, Library Desktop o
  `definizionedati.json`.


### INCARICO 2026-09-25 — Correzione primo tratto StrategiaDiego secondo LG-013/LG-017
Stato: SUPERATO — rettificato dall'incarico successivo sui 15 cm

**NOTA AUTOREVOLE DI RETTIFICA:** le conclusioni di questo blocco che indicano 0,45 m come distanza corretta dalla parete frontale sono errate e non devono più essere usate. Il valore corretto di arresto dalla parete frontale è `p/2 = 0,15 m`; i 0,45 m restano soltanto la quota della prima evoluzione di mandata rispetto alla parete d'ingresso.

Commissionato:
- correggere StrategiaDiego sul primo tratto che prosegue dal tubo di collegamento dentro il locale;
- applicare la regola già consolidata in LG-013: direzione uguale al tubo entrante, **estremo finale non preassegnato**;
- il primo tratto deve essere prolungato fino alla prima geometria frontale e poi troncato alla distanza di rispetto applicabile secondo LG-017/LG-006, invece di usare una lunghezza fissa;
- confrontare i motori GPT e Vittorio come riferimento algoritmico per il principio intersezione/offset + accorciamento, senza modificarli;
- aggiungere regression sul banco appartamento corrente affinché il primo tratto non torni a una lunghezza fissa `1,5p`;
- eseguire GitHub Actions con StrategiaDiego e restituire l'SVG reale prodotto dal Service.

Criteri di completamento:
- eliminata dal primo tratto la lunghezza iniziale preassegnata;
- prima linea frontale realmente ricercata nella direzione del collegamento;
- estremo reale arretrato della distanza prevista;
- build e smoke GitHub Actions SUCCESS;
- banco appartamento corrente SUCCESS;
- SVG reale recuperato e mostrato all'utente.



Risultato reale:
- l'anomalia è stata localizzata nel **primo tratto tracciato dopo il tubo di
  collegamento**, non nella pianta pulita;
- sul banco appartamento la mandata entra portandosi a `1,5p = 0,45 m`
  dalla parete superiore, ma alla prima svolta Diego usava il minimo
  architettonico generale `p/2 = 0,15 m` anche verso la parete destra;
- il tratto orizzontale terminava quindi a `x=7,98148 m`, cioè 0,15 m dalla
  parete interna destra `x=8,13148 m`;
- confrontati i motori Vittorio e GPT: entrambi ottengono il cambio di lato
  attraverso la geometria degli offset/intersezioni e quindi accorciano il
  tratto mantenendo l'offset dell'evoluzione;
- StrategiaDiego ora, **soltanto sulla prima svolta dopo il collegamento**,
  eredita la distanza architettonica raggiunta dal tratto di ingresso e la
  usa come distanza di troncamento rispetto alla parete successiva;
- sul banco corrente il terminale della prima svolta passa quindi a
  `x=7,68148 m`, pari a `8,13148 - 0,45`, mantenendo 45 cm dalla parete;
- l'estensione iniziale della stessa regola a tutte le evoluzioni è stata
  provata e scartata perché rendeva troppo restrittivo il progetto radiante
  reale (`locale_8` senza terminale accettabile);
- la correzione finale è pertanto minima e specifica della prima svolta;
- LG-013 è stata precisata con questo comportamento runtime e con il confronto
  concettuale Vittorio/GPT;
- nessuna modifica a fixture autorevole, frontend, Library Desktop o
  `definizionedati.json`.

Verifica reale:
- build Release GitHub Actions: SUCCESS;
- benchmark sintetici StrategiaDiego: SUCCESS;
- smoke esecutivo SVG/DXF: SUCCESS;
- progetto radiante reale: SUCCESS;
- banco appartamento corrente StrategiaDiego: SUCCESS;
- GitHub Actions finale run `36121714784`, job `108028934122`:
  **SUCCESS**;
- regression banco appartamento verifica:
  - primo ingresso mandata circa `0,45 m`;
  - primo tratto dopo la svolta termina a `x≈7,68148 m`, quindi a 0,45 m
    dalla parete destra;
- artifact `strategia-diego-current-apartment`, id `10857442717`;
- SVG reale prodotto dal Service:
  SHA-256 `af73fe2fda67423339b62df5d55f2c50d7d0e327f8a3ffad197c0889f31c1515`;
- Commit Status finale e notifica telefono: SUCCESS.

Iterazioni diagnostiche:
- `83d87dd1f6d04489fda78b3c02db54f65b883c71`:
  prima interpretazione troppo estesa del primo tratto, regression sintetiche
  fallite;
- `f9c49f1076c5e5ab743099f7edf6ad83099e3369`:
  conservazione offset su tutte le svolte, sintetiche riuscite ma progetto
  radiante reale fallito su `locale_8`;
- `cd208c8c629c018bd34794c2ec722343b5edb877`:
  correzione finale limitata alla prima svolta, suite completa SUCCESS;
- `08cc65df25ce89f8553a3dcd0640c2363cf952a2`:
  precisazione documentale LG-013.

### INCARICO 2026-09-25 — Esecutivo pannelli con pianta pulita spessorata
Stato: ESEGUITO

Commissionato:
- modificare il Service/Core affinché l'artifact `pannelli-esecutivo.svg` non contenga più soltanto spirali e geometria edilizia a linee, ma inglobi come sfondo la **pianta pulita reale** prodotta dal percorso headless `GeneraPianta`;
- la pianta pulita incorporata deve conservare gli **spessori reali delle pareti** ricavati dai dati del progetto/archivi, così l'esecutivo consente di valutare direttamente i distacchi delle tubazioni dai muri;
- mantenere spirali e pianta pulita nello stesso sistema di coordinate, senza ricostruzioni grafiche occasionali esterne al Service;
- non modificare la fixture autorevole dell'appartamento, `definizionedati.json`, frontend o Library Desktop;
- mantenere invariato il nome/contratto dell'artifact `pannelli-esecutivo-svg`; cambia soltanto il suo contenuto, che diventa composito;
- eseguire GitHub Actions sul banco prova corrente StrategiaDiego e recuperare l'SVG realmente restituito dal Service, da mostrare all'utente come verifica visuale.

Criteri di completamento:
- `pannelli-esecutivo.svg` contiene la pianta pulita spessorata sotto le spirali;
- gli spessori derivano dal progetto e non da valori grafici inventati nell'esecutivo;
- build e smoke GitHub Actions SUCCESS;
- test appartamento corrente con `TERMODEL_SPIRAL_ENGINE=Diego` SUCCESS;
- SVG prodotto dalla Action recuperato e restituito all'utente.




Risultato reale:
- `RadiantExecutiveGenerator.Generate(...)` riceve ora le
  `CleanFloorPlans` prodotte dalla stessa elaborazione `GeneraModello`;
- per ogni piano l'esecutivo importa l'SVG canonico
  `TERMODEL-CLEAN-FLOOR-SVG-V1` prima delle spirali, convertendo le unità
  della pianta pulita in metri e mantenendo lo stesso modello grafico neutro
  usato sia dall'SVG sia dal DXF;
- i contorni architettonici sono pubblicati su
  `<Piano>_PiantaPulita_Output` e gli eventuali simboli lineari su
  `<Piano>_PiantaPulitaSimboli_Output`;
- `<Piano>_Edificio_Output` resta esclusivamente fallback per progetti
  legacy nei quali la pianta pulita non sia disponibile;
- lo spessore non viene inventato nell'esecutivo: la pianta pulita deriva dal
  percorso headless `GeneraPianta -> GeometriaHelper.ParalleloPoligono ->
  DXFLineCheck.SpessoreParete`, che legge il valore dell'archivio Pareti
  associato alle linee del progetto;
- la fixture autorevole non è stata modificata e non sono stati modificati
  frontend, Library Desktop o `definizionedati.json`;
- sul banco prova corrente la parete `Parete esterna isolata` dell'archivio
  operativo risulta spessa 13 cm; l'SVG finale contiene due contorni della
  pianta pulita separati coerentemente di 0,13 m, quindi lo spessore è
  effettivamente visibile sotto le spirali.

Verifica reale:
- le prime Action hanno evidenziato due aspettative obsolete nei regression
  test (richiesta del vecchio layer `Edificio_Output` e soglia fissa di
  primitive); i test sono stati aggiornati alla nuova semantica composita;
- GitHub Actions finale run `36115694955`, job `108009152767`:
  **SUCCESS**;
- SUCCESS: restore, build Release, benchmark StrategiaDiego, smoke esecutivo
  SVG/DXF, progetto radiante reale, banco appartamento corrente StrategiaDiego
  e snapshot;
- il banco appartamento verifica esplicitamente la presenza di
  `Unico_PiantaPulita_Output`, l'assenza del fallback
  `Unico_Edificio_Output` e almeno due contorni distinti della pianta pulita;
- artifact CI `strategia-diego-current-apartment`, id `10854544021`;
- SVG reale `pannelli-esecutivo.svg` recuperato dall'Action, SHA-256
  `cd7d3d3c110c5f8f93c9f22b3b0323a483710aa46468c4e1002353bdcb83a28b`;
- Commit Status finale e notifica telefono: SUCCESS.

Commit principali:
- `7a2a46f0aad16950f82428fb657c06cb80e60a6e` — commissione;
- `92e327001597813370fbbf4c554295e0a0d44514` — contratto;
- `d957fa371b5ea9d9a13960968785485654eaaa95` — import pianta pulita nel Core;
- `e5b61b8cca935e82edc7f0e070f4c1137f1a6071` — wiring WebService;
- `e64e9f7fc89b15e7de49443627f447e2b40e6eaf` — regression banco appartamento;
- `1256c6ab202105937d765a17328c2c1e9a564485` e
  `f189a3dae9d846fcef24452ea98be794d7839316` — adeguamento regression
  esecutivo composito.

### INCARICO 2026-09-25 — Direttiva verifica visuale obbligatoria StrategiaDiego
Stato: ESEGUITO

Commissionato:
- aggiungere alle **Linee guida per lo sviluppo del disegno spirali** una
  direttiva permanente per tutte le modifiche che possono cambiare il disegno
  prodotto da StrategiaDiego;
- ogni modifica a codice, regole strategiche, geometria, troncature, distanze,
  selezione dei rami o altri parametri capaci di alterare l'esecutivo deve
  essere verificata tramite **GitHub Actions** sul banco prova operativo
  corrente `tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl`;
- la verifica deve forzare `TERMODEL_SPIRAL_ENGINE=Diego` e produrre la
  risposta/artifact reale `pannelli-esecutivo.svg` usando
  `responseArtifact=pannelli-esecutivo-svg`;
- al termine della modifica la chat deve recuperare e **restituire all'utente
  un SVG visualizzabile** del risultato, non limitarsi a hash, metriche o log;
- una modifica che può cambiare il disegno non può essere dichiarata
  verificata/completata se la relativa Action non è riuscita oppure se l'SVG
  reale non è stato recuperato;
- quando utile, conservare e confrontare SVG prima/dopo; l'SVG prodotto è
  evidenza visuale del test ma non diventa automaticamente un Golden
  geometrico approvato;
- le sole modifiche documentali o tecniche che non possono alterare il disegno
  non richiedono questo ciclo visuale;
- la fixture autorevole resta immutabile: eventuale canonicalizzazione avviene
  soltanto sulla copia temporanea già prevista dall'harness.

Criteri di completamento:
- nuova regola consolidata come `LG-036`;
- documento operativo aggiornato da `LG-001..LG-035` a
  `LG-001..LG-036`;
- banco prova, Action e restituzione SVG esplicitamente vincolanti per i
  futuri cambiamenti visuali;
- nessuna modifica a motore, frontend, Library Desktop o
  `definizionedati.json` in questo incarico esclusivamente documentale.



Risultato:
- consolidata `LG-036 — Verifica visuale obbligatoria delle modifiche che
  cambiano il disegno` in
  `docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`;
- lo stato operativo della specifica è aggiornato a `LG-001..LG-036`;
- per ogni futura modifica con possibile impatto geometrico sono ora
  obbligatori: GitHub Actions sul banco appartamento corrente, motore Diego,
  produzione/retrieval di `pannelli-esecutivo.svg` e restituzione
  dell'SVG visualizzabile all'utente;
- esplicitato che SUCCESS, hash, metriche e log non sostituiscono la verifica
  visuale del disegno;
- esplicitato che un SVG di test non diventa automaticamente Golden geometrico;
- le modifiche esclusivamente documentali o tecniche senza possibile impatto
  sul disegno sono escluse dal ciclo Action+SVG;
- nessuna modifica a Core, WebService runtime, frontend, Library Desktop o
  `definizionedati.json`.

Verifica:
- file Linee guida riletto da `main` dopo il commit e LG-036 presente con
  stato `CONSOLIDATA`;
- questa commissione è esclusivamente documentale e **non modifica il
  disegno**, quindi non è stata eseguita una GitHub Action: LG-036 si applica
  dalla prossima modifica capace di alterare l'output grafico;
- commit Linee guida:
  `2461d63de20e6c2bd777f8ed63b67982ca1ab40b`.

### INCARICO 2026-09-25 — Banco prova corrente StrategiaDiego: appartamento reale
Stato: ESEGUITO

Commissionato:
- consolidare su GitHub **senza modificarlo** il progetto
  `TERMODEL-PROJECT-TEXT-V1` fornito dall'utente il 25/09/2026 come
  **banco prova corrente autorevole** per lo sviluppo di StrategiaDiego;
- conservarne una copia immutabile sotto `Server/Termodelwebservice/tests/fixtures/`,
  con SHA-256 del file originale;
- usarlo come fixture primaria dei successivi test GitHub Actions delle
  spirali con risposta diretta `pannelli-esecutivo-svg`;
- mantenere quadrato 4x4 e concavo a L come regression sintetiche rapide,
  non più come banco operativo principale;
- registrare direttiva, stato algoritmo e lavoro corrente nelle Linee guida
  spirali e nel registro sviluppo StrategiaDiego;
- non modificare frontend, Library Desktop o `definition/definizionedati.json`.

Risultato consolidato:
- fixture autorevole:
  `tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl`;
- snapshot originale conservata senza modifiche; confronto testo sorgente/GitHub
  verificato identico;
- SHA-256 originale:
  `1a5855490adcbac25e5585f9ba89c624eb2381874eb2de8bdc74821a40d2a9a5`;
- projectId originale:
  `07bf8dca-dc86-41ea-8844-1aaca58888f0`;
- piano: `Unico`; timestamp manifest: `2026-09-25T06:16:04.350Z`;
- README dedicato:
  `tests/fixtures/README-StrategiaDiegoCurrentApartment.md`;
- harness dedicata:
  `tools/smoke-strategia-diego-current-apartment.ps1`;
- workflow standard pubblica l'artifact
  `strategia-diego-current-apartment` con retention 90 giorni;
- harness forza `TERMODEL_SPIRAL_ENGINE=Diego` e usa
  `responseArtifact=pannelli-esecutivo-svg`;
- la fixture locale resta immutata; soltanto una copia temporanea viene
  canonicalizzata come `buildTermodelServerPayload()` prima del Service;
- le Linee guida Spirali contengono ora una sezione autorevole
  `Stato operativo corrente — 25/09/2026` con stato algoritmo, banco prova e
  ciclo locale-per-locale;
- il registro StrategiaDiego è passato allo stato generale
  `IN SVILUPPO — BANCO PROVA APPARTAMENTO REALE CORRENTE` e contiene R2
  ancora `IN CORSO`, perché la validazione geometrica continua.

Verifica reale:
- Action #468, run `36102716657`: SUCCESS sulla fixture consolidata;
- Action #473, run `36103180758`: primo collaudo harness FAILED con HTTP 422
  perché la snapshot locale era stata inviata direttamente e mancava la
  canonicalizzazione `TERMODEL-PROJECT-SVG-V1`; nessun difetto Diego dimostrato;
- correzione harness commit
  `a789f85f433959dddeeff9e60a65a180d69416f5`, senza modificare fixture;
- GitHub Actions **#474**, run `36103622680`, job `107971255939`: **SUCCESS**;
- build Release, benchmark sintetici, smoke Service precedenti e banco
  appartamento: SUCCESS;
- marker: `STRATEGIA_DIEGO_CURRENT_APARTMENT_OK`;
- fixture SHA verificato uguale all'originale;
- `spiralEngine=Diego`; risposta diretta SVG HTTP 200;
- SVG baseline SHA-256:
  `71921972d16085fab3071e56cd53a0695661536436678b2c64e7051f1312ecb8`;
- `generatedFileCount=8`; calculation: 1 circuito pannelli, 6 primitive
  esecutivo, 1 piano;
- artifact CI `strategia-diego-current-apartment`, id `10850671585`,
  dimensione archivio 163.814 byte, ispezionato: contiene
  `server-payload.tmdl`, `pannelli-esecutivo.svg`, DXF, `pannelli.json`,
  `generated-files.json`, `test-metadata.json`, TermodelLog/diagnostics,
  calculation log e stdout/stderr Service;
- Commit Status finale `SUCCESS` e notifica telefono `SUCCESS`.

Direttiva operativa da proseguire:
1. screenshot utente + numero locale;
2. riproduzione sulla fixture corrente;
3. individuazione della prima decisione strategica errata;
4. distinguere violazione di una LG esistente da regola mancante;
5. se manca, consolidare LG-036 o successiva prima della correzione;
6. correzione minima soltanto su StrategiaDiego salvo diversa decisione;
7. rieseguire la stessa Action e confrontare prima/dopo;
8. trasformare i casi significativi in regression permanenti.

Nota: l'SVG della #474 è una **baseline tecnica**, non un Golden geometrico
approvato dell'intero progetto.

Commit principali:
- `997356301df3bff63a73118dd778c8d479f0a72d` — commissione;
- `7110bec407d1d3426483c4bc05747b8f7a253ac8` — fixture;
- `3fd40ddf849d9b895792374907babb374d3a4786` — README fixture;
- `7d74c5dcc3888468a5ba7e339fb8ae6b7c094e55` — harness iniziale;
- `6c5c8664b7e1298dc0f26d50a1eda4fcaea5704a` — integrazione workflow;
- `ebf749cb41622a23451bfb0244bd7692d9d61107` — Linee guida;
- `3a5ca15c02ff48ac2c7b11278fcb4494b33132f8` — apertura R2;
- `a789f85f433959dddeeff9e60a65a180d69416f5` — canonicalizzazione harness.


### INCARICO 2026-09-25 — Risposta artifact diretta da Aggiorna Modello
Stato: ESEGUITO

Commissionato:
- estendere `POST /api/calculations` con il parametro query opzionale
  `responseArtifact`;
- in assenza di `responseArtifact` mantenere **identica** la risposta corrente:
  manifest JSON `TERMODEL-FRONT-SERVICE-V1` con `projectId`, artifact e href;
- se `responseArtifact` è presente, eseguire comunque una sola elaborazione
  completa e atomica del progetto, quindi restituire direttamente nel body
  l'artifact richiesto;
- supportare almeno `model3d`, `pannelli`,
  `pannelli-esecutivo-svg`, `pannelli-esecutivo-dxf` e
  `pianta-pulita`; per `pianta-pulita` usare anche `responseFloor`;
- restituire HTTP 400 per nomi artifact non riconosciuti e HTTP 404 quando
  l'artifact richiesto è riconosciuto ma non prodotto da quel progetto;
- aggiungere header di correlazione con projectId e nome artifact;
- usare questa modalità nei regression GitHub Actions dei pannelli/spirali e
  conservare come artifact CI almeno la risposta SVG diretta, così le chat
  successive possono esaminare l'esecutivo prodotto senza una seconda GET;
- non modificare frontend, `definizionedati.json` o Library Desktop.

Risultato:
- contratto condiviso aggiornato a **v1.24**;
- implementato `responseArtifact` su `POST /api/calculations`;
- valori correnti:
  `model3d | pannelli | pannelli-esecutivo-svg | pannelli-esecutivo-dxf | pianta-pulita`;
- `pianta-pulita` richiede anche `responseFloor=<nomePiano>`;
- senza parametro la risposta resta il manifest JSON
  `TERMODEL-FRONT-SERVICE-V1`, quindi il frontend corrente è retrocompatibile
  e non è stato modificato;
- con parametro il Service completa e pubblica comunque l'intero workspace
  atomico, poi restituisce direttamente il body dell'artifact selezionato;
- le risposte dirette espongono `X-Termodel-Project-Id`,
  `X-Termodel-Response-Artifact` e `X-Termodel-Artifact-Stale: false`;
- artifact sconosciuto: HTTP 400; artifact conosciuto ma non prodotto: HTTP 404;
- il regression reale pannelli salva la risposta diretta come
  `response-pannelli-esecutivo.svg` nell'artifact CI
  `radiant-reference-regression`.

Verifica reale:
- GitHub Actions **#466**, run `36100728060`, job `107962873006`:
  **SUCCESS**;
- build .NET: SUCCESS;
- benchmark StrategiaDiego: SUCCESS;
- smoke HTTP/storage, feedback, esecutivo SVG/DXF, progetto radiante reale e
  snapshot: SUCCESS;
- chiamata diretta
  `POST /api/calculations?responseArtifact=pannelli-esecutivo-svg`: SUCCESS;
- marker CI: `CALCULATION_DIRECT_ARTIFACT_OK`;
- SHA-256 della risposta SVG:
  `A51BB21F38293D4E6538FEE241C8AFE7A225D7A126A2978FE101320D46D1A9D3`;
- lo SHA-256 coincide byte-per-byte con
  `artifacts/pannelli-esecutivo.svg` persistito dalla stessa elaborazione;
- richiesta `responseArtifact=artifact-inesistente`: HTTP 400 verificato;
- artifact Actions `radiant-reference-regression`, id `10848733383`,
  contiene realmente `response-pannelli-esecutivo.svg` (5.921 byte);
- Commit Status finale `SUCCESS` e notifica telefono `SUCCESS`.

Commit operativi:
- `d46bd3945c6c12a7f669e9cddcf296c685b18f67` — registrazione incarico;
- `2446cace1620e2f33772a7615dceb8e21a92ca9c` — contratto v1.24;
- `6de84b2af2f700ab1c2eafd10704f1ae8eeb01b4` — implementazione endpoint;
- `2e6085ede366ce62b1a85e24da311917443cd48c` — documentazione README;
- `66a5e2d2724f7006fa47613461e91c0f54bd43e2` — regression risposta SVG diretta.



### INCARICO 2026-09-25 — Forzatura StrategiaDiego e stato attesa Service nel frontend
Stato: ESEGUITO

Commissionato:
- rendere **StrategiaDiego** il motore spirali usato dal Service quando
  `TERMODEL_SPIRAL_ENGINE` non è configurata;
- mantenere l'override esplicito `Vittorio | GPT | Diego` tramite variabile
  d'ambiente, così la scelta resta reversibile;
- aggiornare la documentazione Service che descrive ancora GPT come default;
- nel frontend `docs/termodel-ui-demo`, mostrare nella status bar CAD il
  testo esatto **"In Attesa di una risposta del server"** mentre è pendente
  una chiamata al Termodel Service;
- applicare il feedback di attesa in modo centralizzato alle chiamate Service
  e gestire correttamente eventuali richieste concorrenti;
- non modificare `definizionedati.json`, Library Desktop o il contratto
  `TERMODEL-PROJECT-TEXT-V1`.

Criteri di completamento:
- fallback del dispatcher verificato nel sorgente come `Diego`;
- chiamate Service del frontend instradate attraverso il feedback di attesa;
- build/check automatici GitHub Actions conclusi con successo;
- diagnostica interna dell'esecutivo continua a costruire il messaggio con il
  motore selezionato;
- incarico marcato `ESEGUITO` soltanto dopo verifica reale dell'Action.

Risultato:
- `RadiantExecutiveGenerator.ResolveSpiralEngine()` restituisce ora
  `RadiantSpiralEngine.Diego` quando `TERMODEL_SPIRAL_ENGINE` è assente o
  vuota;
- l'override esplicito `Vittorio | GPT | Diego` resta disponibile;
- README Service aggiornato al nuovo default operativo;
- frontend portato a **v1.17**;
- tutte le chiamate al Termodel Service nel flusso principale usano il wrapper
  `fetchTermodelService(...)`;
- durante una o più richieste pendenti la status bar CAD e lo stato della vista
  mostrano esattamente **"In Attesa di una risposta del server"**;
- il wrapper usa un contatore delle richieste pendenti e ripristina lo stato
  precedente soltanto dopo l'ultima risposta, senza sovrascrivere messaggi più
  recenti;
- il workflow protegge con regression statica i marker del nuovo feedback di
  attesa.

Verifica reale:
- prima Action #461, run `36099815059`: FAILED nel solo controllo statico
  frontend perché il cache-busting era stato portato a v1.17 mentre
  `APP_VERSION`/workflow attendevano ancora v1.16; sintassi JavaScript già
  SUCCESS; notifica terminale FAILED eseguita;
- correzione di coerenza versione nel commit
  `452d8b26b8b2a279a2185d5d2aefdce12165c322`;
- GitHub Actions **#462**, run `36100018101`, job `107960320636`:
  **SUCCESS**;
- SUCCESS: restore, sintassi frontend, wiring frontend, build .NET, benchmark
  StrategiaDiego, smoke HTTP/storage, feedback, esecutivo pannelli SVG/DXF,
  progetto radiante reale e snapshot GitHub;
- il workflow non imposta `TERMODEL_SPIRAL_ENGINE`, quindi gli smoke del
  Service hanno esercitato il nuovo fallback Diego;
- step finale Commit Status/notifica telefono: SUCCESS;
- GitHub Pages run `36100017851`: **SUCCESS** per il frontend v1.17.

Commit operativi:
- `4cd5cbf22c718f7b8f7e9a7c560f8569e1712716` — registrazione incarico;
- `9e96b43ce70af9082c3ba3ccdcfb73fad8f5f9e8` — Diego default + wrapper
  attesa Service + frontend v1.17;
- `452d8b26b8b2a279a2185d5d2aefdce12165c322` — allineamento APP_VERSION e
  regression CI del feedback attesa.



### INCARICO 2026-09-25 — Visualizzazione esecutivo StrategiaDiego quadrato 4x4
Stato: SUPERATO

Nota:
- l'utente ha cambiato strategia di verifica: i test proseguono sul corrente
  esempio appartamento, analizzando screenshot e numero locale;
- l'eventuale Action già avviata per il quadrato resta una prova tecnica, ma
  non costituisce più il criterio operativo richiesto dall'utente.

Commissionato:
- rieseguire tramite GitHub Actions il caso test `StrategiaDiegoSquare4x4.locale.xml`;
- usare la StrategiaDiego corrente senza modificare Vittorio/GPT;
- recuperare l'SVG prodotto dalla Action per il quadrato 4x4 con unico tubo entrante;
- mostrare all'utente il disegno prodotto, insieme all'esito reale del benchmark;
- non modificare frontend, `definizionedati.json` o Library Desktop.

Criteri di completamento:
- GitHub Action conclusa;
- artifact `strategia-diego-benchmark` recuperato;
- `StrategiaDiegoSquare4x4.svg` estratto e visualizzato;
- metriche della nuova esecuzione registrate;
- incarico marcato `ESEGUITO` soltanto dopo verifica reale dell'Action.



### INCARICO 2026-09-25 — StrategiaDiego regressione geometrie complesse R1
Stato: ESEGUITO

Commissionato:
- riprendere lo sviluppo di StrategiaDiego dal limite residuo registrato dopo
  F6;
- introdurre una fixture minima riproducibile con locale concavo a L e un
  unico ingresso;
- eseguire sulla nuova fixture lo stesso benchmark ripetuto, deterministico e
  soggetto ai budget già adottati per il caso quadrato 4x4;
- integrare la regressione nel workflow GitHub Actions senza modificare i
  motori Vittorio/GPT, il frontend o `definizionedati.json`;
- mantenere distinta questa prova di concavità dalla futura regressione reale
  di strettoia/imbottigliamento collegata a `STRATEGY-001`.

Criteri di completamento:
- fixture e relativa scheda documentale presenti nel repository;
- benchmark capace di produrre artifact distinguibili per più fixture;
- build e benchmark quadrato + concavo conclusi con successo in GitHub
  Actions;
- metriche reali della nuova fixture registrate nel Summary e nel registro di
  sviluppo;
- commissione marcata `ESEGUITO` soltanto dopo la verifica dell'Action.

Risultato:
- aggiunte la fixture `tests/fixtures/StrategiaDiegoConcaveL.locale.xml` e la
  relativa scheda `README-StrategiaDiegoConcaveL.md`;
- il benchmark genera ora report JSON e SVG nominati in base alla fixture,
  evitando collisioni fra casi diversi;
- il workflow esegue 20 iterazioni sia sul quadrato 4x4 sia sul locale concavo
  e pubblica metriche nel Job Summary e come annotazioni `notice` consultabili
  senza scaricare artifact autenticati;
- GitHub Actions `TermodelService Build` run `36097485997`, build #458, job
  `107952701779`: **SUCCESS**;
- quadrato 4x4: 104 nodi, 2 terminali accettati, p95 23 ms, 360.576 byte,
  deterministico;
- locale concavo a L: 183 nodi, 2 terminali accettati, p95 48 ms,
  720.896 byte, deterministico;
- entrambe le fixture rispettano i budget F5 (50.000 nodi, p95 2.000 ms,
  memoria 128 MiB);
- nessuna modifica ai motori Vittorio/GPT, al frontend o a
  `definizionedati.json`.

Valutazione:
- la sostenibilità di StrategiaDiego è ora verificata anche su una prima
  geometria concava, oltre al quadrato 4x4;
- non è ancora dimostrata la gestione selettiva della strettoia di
  `STRATEGY-001`, né sono coperti più ingressi/circuiti o più locali.

Commit operativi:
- `78f9f3a5b27e2472fee7686d0ac163eec25aa19b` — registrazione R1;
- `78b0529ecbbcbe2eda5baa763e74844a9c4ec60e` — fixture concava e doppio
  benchmark;
- `cabacac1715c97adf01c22596dfd08032e615c10` — metriche pubbliche nel
  workflow.


### INCARICO 2026-09-25 — Implementazione, attivazione e benchmark StrategiaDiego
Stato: ESEGUITO

Risultato consolidato:
- completato audit comparativo sui sorgenti Vittorio/GPT e specifica code-ready;
- implementato nel Core il terzo motore headless `StrategiaDiegoEngine`;
- mantenute disponibili le alternative `Vittorio | GPT | Diego`;
- selezione Service tramite `TERMODEL_SPIRAL_ENGINE`; dal commit `9e96b43ce70af9082c3ba3ccdcfb73fad8f5f9e8` il default operativo è `Diego`, con override esplicito `Vittorio | GPT | Diego` ancora disponibile;
- Vittorio copiato temporaneamente byte-identical nel Core e tracciato in
  `CopiedFromTermodel/TERMODEL-SYNC.md`; Library Desktop non modificata;
- aggiunta fixture `tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`
  (quadrato 4x4 m, unico tubo entrante);
- aggiunto benchmark ripetuto e integrato nel workflow GitHub Actions;
- completato allineamento LG-033..LG-035: i rami paralleli che inseguono un
  tratto precedente usano il successore `S_k+1` tramite `SequenceIndex`;
  `PROSEGUI_DRITTO` resta alternativa separata;
- nessuna modifica a frontend o `definizionedati.json`.

Fasi:
- F0 — registrazione incarico e registro di sviluppo: ESEGUITO;
- F1 — audit finale Vittorio/GPT e specifica code-ready: ESEGUITO;
- F1B — audit implementazione vs LG-033..LG-035: ESEGUITO;
- F2 — implementazione/dispatcher `Vittorio|GPT|Diego`: ESEGUITO;
- F2B — allineamento inseguimento sequenziale `S_k -> S_k+1`: ESEGUITO
  (`90f76ff47e4822b00d7ba3d57b524017e377f092`);
- F3 — build reale della soluzione: ESEGUITO;
- F4 — fixture quadrato 4x4 m / un ingresso: ESEGUITO;
- F5 — batteria benchmark GitHub Actions e metriche: ESEGUITO
  (`64177c1651ef36dfddd6eb92c1973ea7c16691a5`);
- F6 — consolidamento Summary e stato finale: ESEGUITO.

Verifica reale finale:
- GitHub Actions `TermodelService Build` run `36096201896`, build #453;
- job build `107949117086`: SUCCESS;
- Commit Status `Termodel/job=SUCCESS`;
- notifica telefono finale: SUCCESS;
- benchmark: 20 iterazioni sulla fixture 4x4;
- nodi totali massimi: **104**;
- terminali preliminarmente accettati: **2**;
- p95: **22 ms**;
- max memory delta: **368.800 byte**;
- output deterministico verificato;
- budget benchmark rispettati (50.000 nodi, p95 2.000 ms, memoria 128 MiB).

Baseline precedente all'allineamento sequenziale:
- run #450: 1176 nodi, p95 98 ms, 7.408.856 byte, 2 terminali;
- il passaggio a `S_k -> S_k+1` riduce fortemente lo spazio di ricerca senza
  introdurre potatura predittiva.

Valutazione:
- StrategiaDiego è **implementata, compilata, eseguita e testata** sul caso
  campione 4x4/un ingresso;
- la sostenibilità è verificata per questo caso, non ancora generalizzabile a
  geometrie complesse;
- prossimi regression necessari: concavità, strettoie/imbottigliamenti,
  più ingressi/circuiti e più locali.



### INCARICO 2026-09-25 — Linee guida sviluppo disegno spirali / futura StrategiaDiego
Stato: COMMISSIONATO

Commissionato:
- creare un documento vivo denominato **Linee guida per lo sviluppo del disegno spirali**, costruito progressivamente durante il confronto con l'utente;
- per ogni nuovo punto proposto dall'utente, aggiungere commento tecnico, formulazione verificabile e registrazione Git;
- usare il documento come specifica funzionale della futura classe/strategia **StrategiaDiego**;
- mantenere StrategiaDiego concorrente, e non sostitutiva, rispetto ai motori/strategie **Vittorio** e **GPT** già conservati nel progetto;
- prevedere come obiettivo architetturale una selezione esplicita della strategia richiesta: `Vittorio | GPT | Diego`, con input/output confrontabili;
- non implementare ancora StrategiaDiego né modificare gli algoritmi Vittorio/GPT in questa fase documentale;
- collegare le linee guida al registro strategie geometriche già presente in `docs/spirali-strategy-register/`;
- non modificare Library Desktop, frontend, `definizionedati.json` o contratto HTTP finché la discussione non produce una richiesta esplicita di implementazione.

Criteri di avanzamento:
- il documento deve distinguere chiaramente principi consolidati, commenti tecnici e punti ancora da definire;
- ogni principio dovrà essere traducibile in un criterio di test/regressione per la futura StrategiaDiego;
- le tre strategie dovranno restare confrontabili sullo stesso caso geometrico senza alterarsi reciprocamente.

Avanzamento iniziale:
- creato `docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md` come specifica viva;
- consolidata `LG-001 — Strategie concorrenti e selezionabili`;
- definito l'obiettivo futuro `Vittorio | GPT | Diego` con selezione esplicita e output confrontabile;
- registrato che StrategiaDiego non deve sovrascrivere né modificare silenziosamente Vittorio/GPT;
- collegato il documento all'indice `docs/spirali-strategy-register/README.md`;
- nessuna classe StrategiaDiego o modifica algoritmica implementata in questa fase;
- incarico mantenuto **COMMISSIONATO** perché il documento deve continuare a ricevere i punti successivi dall'utente.
- consolidata e successivamente rettificata `LG-002 — StrategiaDiego come albero decisionale`: nodi = situazioni con scelta strategica, rami = alternative esplicite, foglie/terminali = situazioni senza ulteriori scelte strategiche e con esito/comportamento deterministico;
- la rettifica esclude il modello a grafo generico: ogni nodo non radice ha un solo padre, rami distinti non si ricongiungono e non sono ammessi cicli;
- richiesto che il percorso radice -> nodi -> rami -> foglia sia diagnosticabile e riproducibile nei regression test.
- consolidata `LG-003 — Fattore di merito dei terminali e scelta della soluzione`: per ogni terminale valido il merito è la lunghezza totale di tubo producibile; viene selezionato il terminale con lunghezza massima;
- separata concettualmente la fase di esplorazione/valutazione dell'albero dalla materializzazione finale: la spirale definitiva viene prodotta ripercorrendo dalla radice il cammino del terminale vincente e applicando nell'ordine le scelte registrate nei nodi;
- esclusi dal confronto i terminali geometricamente invalidi; parità di merito e dettaglio di misura di raccordi/tratti tecnici restano da definire.
- consolidata `LG-004 — Struttura geometrica di contenimento`: lo stato geometrico minimo di StrategiaDiego è composto da tre famiglie semanticamente distinte, `LineeArchitettoniche`, `LineeMandata` e `LineeRitorno`;
- registrato che i nodi devono poter interrogare separatamente le tre famiglie e che i nuovi tratti generati aggiornano la famiglia mandata/ritorno corrispondente;
- non ancora definite in LG-004 regole di collisione, attraversamento, distanze di rispetto o precedenze fra le tre famiglie.
- consolidata `LG-005 — Concetto di tratto possibile`: un tratto è possibile solo se rispetta tutte le regole di tracciamento applicabili e genera un segmento con lunghezza strettamente maggiore di zero;
- un tratto non possibile non deve aprire un ramo valido dell'albero; diagnostica futura distinta fra lunghezza nulla e violazione di una regola di tracciamento;
- elenco completo delle regole di tracciamento e tolleranza numerica sulla lunghezza restano da definire.
- consolidata `LG-006 — Passo p e distanze minime di tracciamento`: `p` è la distanza minima tubo-tubo di riferimento; distanza minima da linee architettoniche `p/2`, fra tubi dello stesso colore `2p`, fra tubi di colore diverso `p`;
- interpretazione corrente: colori = famiglie mandata/ritorno e distanze misurate fra le linee/assi geometrici rappresentativi dei tubi;
- queste soglie diventano regole applicabili a `TrattoPossibile`; previste regression sulle condizioni `<`, `=` e `>` rispetto a `p/2`, `p`, `2p`.
- consolidata `LG-007 — Scelta di nodo possibile`: una scelta di nodo è un `TrattoPossibile` che non interseca linee già generate, è parallelo a una linea esistente di riferimento e si trova alla distanza minima applicabile di LG-006;
- distinto esplicitamente `TrattoPossibile` da `SceltaNodoPossibile`: non ogni tratto geometricamente ammesso costituisce automaticamente un ramo dell'albero;
- restano da definire selezione della linea di riferimento, ordinamento di più scelte ammissibili e tolleranze su parallelismo/distanza/intersezioni agli estremi.
- consolidata `LG-008 — Terminale accettabile`: un terminale è accettabile quando l'estremo della mandata e l'estremo della ripresa/ritorno possono essere collegati senza intersecare altre linee già presenti;
- distinto il semplice terminale dell'albero dal terminale accettabile; solo i terminali accettabili partecipano alla selezione per massimo fattore di merito di LG-003;
- LG-008 introduce soltanto il vincolo di non-intersezione del collegamento finale; forma del collegamento, eventuali distanze minime e caso senza terminali accettabili restano da definire.
- precisata LG-008: la valutazione `TerminaleAccettabile` avviene soltanto dopo il completamento dell'intero albero decisionale; l'accettabilità non viene usata per scegliere o potare anticipatamente i rami;
- sequenza consolidata: costruzione completa albero -> raccolta terminali -> valutazione accettabilità -> filtro terminali accettabili -> confronto fattore di merito -> scelta terminale vincente.
- consolidata `LG-009 — Configurazione iniziale e direzione principe`: l'albero parte dall'estremo interno del tubo di collegamento di mandata che entra nella stanza; sono previste configurazioni ritorno a sinistra/destra;
- per `RitornoSinistra`, destra/sinistra sono definite esclusivamente rispetto alla direzione convenzionale del tubo di collegamento `esterno -> stanza`; la direzione principe è il tratto parallelo sul lato destro di tale verso;
- non ancora definita per deduzione la regola `RitornoDestra`; resta da stabilire anche se la direzione principe sia solo priorità di esplorazione o vincolo più forte.
- consolidata `LG-010 — Lato di ritorno associato al singolo tubo di collegamento`: ogni ingresso conserva il proprio `LatoRitorno = Sinistra | Destra`, indipendente dagli altri ingressi dello stesso progetto;
- esclusa una configurazione globale unica del lato di ritorno: verso `esterno -> stanza` e lato di ritorno vengono valutati separatamente per ogni tubo di collegamento.
- consolidata `LG-011 — Albero di collegamento idraulico collettore-ingressi`: prima della costruzione delle spirali interne viene definita la rete fisica di collegamento dal collettore ai tratti di entrata;
- distinta tale rete dall'albero decisionale LG-002: la rete/albero di mandata è input autorevole dell'utente, mentre l'albero di ritorno viene costruito dall'algoritmo;
- la rete di collegamento completa alimenterà `LineeMandata` e `LineeRitorno` della struttura geometrica LG-004; algoritmo concreto del ritorno, diramazioni e priorità restano da definire.
- consolidata `LG-012 — Radice dell'albero di ritorno`: per ogni nodo di mandata d'ingresso, l'algoritmo colloca la radice del ritorno a `0,50 m`; il vettore mandata->ritorno è parallelo alla parete architettonica più vicina e il verso è coerente con il `LatoRitorno` dell'ingresso;
- restano da definire gestione di pareti equidistanti, dettaglio della distanza da segmenti finiti e comportamento se la posizione teorica della radice viola altri vincoli geometrici.
- consolidata `LG-013 — Primo tratto a inclinazione libera`: il primo tratto della costruzione può avere inclinazione libera e costituisce deroga al solo requisito di parallelismo; dal secondo tratto in poi si applicano integralmente le regole di parallelismo di LG-007;
- il primo tratto resta comunque soggetto a validità geometrica, non-intersezione e distanze minime LG-005/LG-006; direzione concreta del primo tratto e rapporto con la direzione principe restano da definire.
- consolidata `LG-014 — Il ritorno segue la mandata nel corridoio quando possibile`: la mandata utente può coprire aree del corridoio; il ritorno tenta di seguirne ordinatamente le evoluzioni con tratti paralleli ammessi;
- se una specifica evoluzione della mandata non può essere seguita senza intersezioni o viola le regole geometriche, il ritorno non viene forzato: quella evoluzione viene saltata e la ricerca riprende dalla successiva evoluzione seguibile;
- il fallimento su una singola evoluzione non interrompe l'intera costruzione del ritorno; resta da definire come assicurare geometricamente la continuità fra due tratti seguibili separati da evoluzioni saltate.
- consolidata `LG-015 — Configurazione terminale mandata/ritorno e scelta iniziale della spirale`: solo dopo il completamento della rete di ritorno, per ogni ingresso terminale viene determinato se la mandata è a destra o a sinistra nel riferimento locale `esterno -> stanza`;
- tale configurazione terminale costituisce l'input per la scelta iniziale della spirale; `MandataDestra <=> RitornoSinistra` e `MandataSinistra <=> RitornoDestra` descrivono la stessa coppia geometrica;
- la tabella completa che traduce il lato della mandata nella concreta prima scelta geometrica della spirale resta da definire.
- consolidata `LG-016 — Scelta di prosecuzione nella direzione di provenienza`: ad ogni nodo con direzione entrante viene valutata l'alternativa `PROSEGUI_DRITTO`, cioè continuare lungo la stessa direzione fino alla prima geometria frontale;
- il tratto non interseca la geometria frontale ma si arresta alla distanza minima applicabile secondo LG-006 e genera un ramo solo se resta `TrattoPossibile`/`SceltaNodoPossibile`;
- restano da definire le altre scelte concorrenti del nodo e l'ordine con cui verranno enumerate.
- precisata LG-016: `PROSEGUI_DRITTO` deroga esplicitamente al requisito di parallelismo con un'altra linea esistente; la sua ammissibilità deriva dalla continuità della direzione di provenienza, restando soggetta a lunghezza positiva, distanze minime e non-intersezione.
- consolidata `LG-017 — Ogni nuovo tratto deve avere una linea frontale di arresto`: la semiretta teorica della direzione candidata deve incontrare un'altra linea della struttura geometrica; il segmento reale viene troncato prima dell'intersezione alla distanza di rispetto applicabile;
- distinta esplicitamente l'intersezione della direzione teorica dalla non-intersezione del segmento costruito; senza linea frontale o con arretramento che produce lunghezza <= 0, il tratto non viene generato.
- consolidata `LG-018 — Flusso generale della StrategiaDiego`: 1) costruzione ritorno dei tubi di collegamento, 2) costruzione spirali di mandata, 3) costruzione spirali di ritorno, 4) potatura dei rami non ammissibili dell'albero, 5) generazione definitiva;
- dopo la potatura si valutano i terminali accettabili (LG-008), quindi si seleziona quello con massimo fattore di merito (LG-003), infine si genera la soluzione definitiva ripercorrendo deterministicamente il cammino radice->terminale vincente;
- il termine operativo resta `albero decisionale` secondo LG-002; criteri completi di potatura e regole specifiche della spirale di ritorno restano da definire.
- consolidata `LG-019 — Evoluzione delle linee guida attraverso i casi di test`: il documento resta una specifica viva, da correggere/estendere quando i casi reali o di regression evidenziano ambiguità, limiti o regole mancanti;
- i casi `STRATEGY-NNN` devono alimentare le regole generali `LG-NNN`; una differenza osservata va compresa prima di aggiornare risultati attesi o comportamento;
- le rettifiche strategiche devono essere documentate esplicitamente prima dell'implementazione, mantenendo tracciabilità e trasformando i casi significativi in regression test quando possibile.
- consolidata `LG-020 — Riferimento sussidiario a Spirali Vittorio e Spirali GPT`: per gli aspetti non ancora definiti esplicitamente da StrategiaDiego si consultano entrambi i motori esistenti come riferimento;
- una regola Diego esplicita prevale sempre; se Vittorio e GPT concordano il comportamento vale come riferimento provvisorio, se divergono la differenza deve essere documentata e risolta con una nuova LG-NNN senza scelta implicita;
- il fallback documentale non autorizza copie o modifiche dei motori Vittorio/GPT e decade sul singolo punto quando StrategiaDiego lo formalizza esplicitamente.
- audit pre-sviluppo avviato un quesito alla volta; consolidata `LG-021 — Enumerazione completa delle linee di riferimento a ogni nodo`: ogni nodo considera tutte le linee architettoniche, di mandata e di ritorno come riferimenti candidati, applicando rispettivamente le distanze `p/2`, `2p` o `p` secondo famiglia/colore del nuovo tratto;
- nessun filtro preliminare per sola vicinanza: le alternative vengono eliminate dalle successive verifiche geometriche; resta aperta la gestione di candidati equivalenti generati da riferimenti diversi.
- consolidata `LG-022 — Direzione di provenienza ed estremo libero del tubo di collegamento`: ogni nodo dispone di `DirezioneProvenienza`; nel caso iniziale il tubo di collegamento ha direzione nota ma estremo interno libero, determinato dall'intersezione con la direzione del prossimo tratto scelto;
- resta da definire la gestione dei casi in cui direzione di provenienza e nuovo tratto risultino paralleli, dell'intersezione posta dietro al verso orientato e di eventuali correzioni/raccordi sul punto geometrico di intersezione.
- audit: rettificata `LG-021` tramite `LG-023 — Linea di riferimento determinata dal troncamento del tratto precedente`; per un cambio di direzione ordinario non si enumerano più tutte le linee come riferimenti di parallelismo;
- la nuova linea deve essere la parallela alla linea frontale che ha troncato il tratto precedente e deve passare per il terminale di quel tratto; questo determina univocamente il lato della parallela;
- `PROSEGUI_DRITTO` resta l'eccezione: usa `DirezioneProvenienza` e non richiede parallelismo con la linea di troncamento; la struttura geometrica completa resta comunque usata per trovare ostacolo frontale, distanze e intersezioni.
- audit: consolidata `LG-024 — Entrambi i versi della nuova parallela generano rami`: una volta determinata la parallela di LG-023, vengono esplorati entrambi i versi come rami distinti se immediatamente geometricamente ammissibili;
- vietata la potatura anticipata basata sulla previsione che un ramo possa bloccare il ritorno: anche scelte potenzialmente catastrofiche devono essere costruite e potranno essere eliminate solo quando il blocco viene realmente verificato nella costruzione del ritorno/potatura/accettabilità terminale;
- previsto regression case con un ramo di mandata inizialmente valido ma successivamente incompatibile con il ritorno, che deve sopravvivere fino alla fase corretta di esclusione.
- audit: consolidata `LG-025 — Condizione di terminale dell'albero di mandata`: un nodo è terminale solo quando, dopo aver valutato `PROSEGUI_DRITTO` e i due versi della parallela di LG-023/LG-024, nessuna alternativa produce un `TrattoPossibile`;
- la terminalità deriva quindi dall'assenza completa di prosecuzioni ammissibili, non da euristiche o previsioni sul ritorno; se almeno un candidato è valido il nodo resta non terminale e ogni candidato valido genera un ramo.
- audit: consolidata `LG-026 — Origine della costruzione della spirale di ritorno`: la spirale di ritorno non parte dal terminale della mandata ma dall'estremo interno del tubo di collegamento di ritorno già generato nella fase iniziale della rete di collegamento;
- per ogni circuito restano quindi distinte `OrigineMandata` e `OrigineRitorno`; il terminale della mandata rimane geometria da raggiungere/chiudere compatibilmente nelle fasi successive, non origine del ritorno;
- audit: consolidata `LG-027 — Mandata e ritorno usano la stessa strategia di nodo`: una volta definita la rispettiva origine, entrambe le famiglie valutano `PROSEGUI_DRITTO` e i due versi della parallela determinata dal troncamento precedente;
- la logica decisionale deve essere condivisa; cambiano soltanto origine, famiglia/colore e quindi le distanze applicabili rispetto alla geometria presente;
- eventuali future eccezioni specifiche del ritorno dovranno essere introdotte esplicitamente con nuove linee guida.
- audit: consolidata `LG-028 — Ogni terminale della mandata prosegue con il proprio albero dei ritorni`: ciascun terminale mandata conserva il proprio percorso/geometria e avvia una distinta esplorazione del ritorno dalla stessa `OrigineRitorno` del circuito;
- nessun terminale mandata viene escluso per motivi di ottimizzazione preventiva; il costo computazionale potrà crescere combinatoriamente e dovrà essere misurato sui casi di test tramite numero nodi/terminali, profondità, tempo e memoria;
- eventuali ottimizzazioni future dovranno preservare lo spazio delle soluzioni ammissibili oppure essere prima formalizzate come nuova regola StrategiaDiego.
- audit: consolidata `LG-029 — Valutazione preliminare della chiusura e verifica avanzata successiva`: nella prima implementazione la chiusura mandata/ritorno viene valutata tramite segmento rettilineo diretto e non-intersezione;
- tale esito è solo preliminare: in seguito verrà definita una verifica avanzata delle chiusure realmente realizzabili/irrealizzabili, eventualmente con forme non rettilinee, raccordi e vincoli costruttivi;
- il test preliminare positivo o negativo non va confuso con una certificazione definitiva della fattibilità della chiusura.
- audit: consolidata `LG-030 — StrategiaDiego come strategia computazionalmente pesante e selezionabile`: Diego viene classificata come motore esplorativo pesante, selezionabile esplicitamente dall'utente o utilizzabile/proponibile quando la complessità del progetto è stimata sostenibile;
- la classificazione di pesantezza governa la selezione del motore, non introduce potature euristiche interne e non modifica le regole geometriche di Diego;
- restano da definire soglie/metriche concrete di compatibilità, comportamento UI/fallback ed eventuali limiti assoluti di nodi, tempo o memoria.
- audit: consolidata `LG-031 — Geometria vincolante durante la costruzione del ritorno`: per ogni terminale mandata, il relativo ritorno viene valutato contro `LineeArchitettoniche + intero PathMandata del terminale + PathRitornoCorrente`;
- geometrie appartenenti a rami alternativi non contaminano lo stato corrente; per il ritorno valgono distanze `p/2` da architettura, `p` da mandata e `2p` da ritorno.
- audit: consolidata `LG-032 — Geometria vincolante durante la costruzione della mandata`: ogni ramo mandata vede soltanto `LineeArchitettoniche + PathMandataCorrente`; i rami alternativi sono scenari indipendenti e non costituiscono ostacoli reciproci;
- ogni nuovo tratto valido entra subito nello stato geometrico del proprio ramo; per la mandata valgono `p/2` da architettura e `2p` da mandata già presente.
- audit: rettificate `LG-013` e `LG-022`: il primo tratto, sia di mandata sia di ritorno, **non ha inclinazione libera** ma mantiene la direzione del rispettivo tubo di collegamento entrante; è libero il punto finale, non la direzione;
- il punto finale del primo tratto viene determinato dalla prima linea frontale utile e dal conseguente troncamento alla distanza di rispetto; la regola vale simmetricamente per mandata e ritorno.
- audit: consolidato il principio `LG-033 — Inseguimento progressivo dell'evoluzione precedente nei percorsi convessi`: dopo il primo giro, la spirale può riagganciarsi alla propria evoluzione precedente e seguirne ordinatamente i tratti `S1 -> S2 -> S3 -> ...`;
- la troncatura può usare anche il prolungamento geometrico di un tratto precedente come marcatore di aggancio, mentre le collisioni restano verificate sulla geometria fisica reale;
- per supportare l'inseguimento convesso la futura implementazione dovrà mantenere identità e sequenza dei segmenti del path; resta da definire se il successivo segmento della sequenza precedente abbia priorità assoluta o resti una delle alternative dell'albero.
- audit: consolidata `LG-034 — Troncatura con segno opposto nei casi concavi e convessi`: rispetto all'intersezione teorica `I`, misurando lungo `DirezioneProvenienza`, il terminale vale `I - d` nei casi concavi e `I + d` nei casi convessi;
- LG-017 viene quindi precisata: il troncamento non è sempre un arretramento; nei percorsi convessi l'avanzamento oltre l'intersezione permette l'inseguimento progressivo della precedente evoluzione definito in LG-033;
- audit: confronto diretto eseguito sui motori Desktop `Termodel-Vittorio-main/Termodel_new/Spiralgenerator.cs` e `SpiraliGPT/Spiralgenerator.cs`; Vittorio costruisce gli offset mediante normali/bisettrici, GPT mediante buffer negativo NetTopologySuite con `JoinStyle.Mitre` e validazione dei raccordi;
- precisata `LG-034`: la formula `I-d` concavo / `I+d` convesso resta esatta nel caso ortogonale, ma per angoli arbitrari il terminale va ottenuto come intersezione fra la linea corrente e la parallela offset del segmento successivo della precedente evoluzione; il modulo dello spostamento non è in generale `d`;
- consolidata `LG-035 — Criterio computabile di inseguimento concavo/convesso`: dato `S_k -> S_k+1`, si costruiscono `I` (intersezione con la retta non offset) e `T` (intersezione con la parallela offset), quindi `delta = dot(T-I, DirezioneProvenienza)`; `delta<0` concavo, `delta>0` convesso, con criterio equivalente `q*side*turn` per diagnostica;
- separati esplicitamente geometria teorica (segmenti + prolungamenti per aggancio/troncatura) e geometria fisica (segmenti reali per collisioni e validità); la sequenza ordinata `S_k -> S_k+1` è autorevole nell'inseguimento convesso.

Commit iniziali:
- `4b7be0d6762fec6baad84fda2d7fe9f226684042` — registrazione incarico;
- `a7d1b5f0558bd4d4f4ed03f392a6866d305ce0ea` — creazione Linee guida e LG-001;
- `8866e03763010c1c003f524e1e4239375eca748c` — collegamento dal registro strategie.
- `3d7ed48b8259b03d6ad959552e7521b951aeefb3` — LG-002, struttura a grafo decisionale.
- `ca6d8e6999496f6c4b03e4d27556039dc2ce7854` — rettifica LG-002 da grafo ad albero decisionale.
- `a9bede514fba3016caa33662d4e21eb0ac40c0e8` — LG-003, fattore di merito dei terminali e selezione per massima lunghezza tubo valida.
- `e420174d26b232c6ee6c7f170a7de2bd47ee0a32` — LG-004, struttura geometrica di contenimento con linee architettoniche, mandata e ritorno.
- `484a961e977505d703b7e3f67a99c553e919bd8f` — LG-005, definizione di tratto possibile.
- `9020b095e11b1c5dfda2ccbcb7d56ab838008b0c` — LG-006, passo `p` e distanze minime architettura/stesso colore/colore diverso.
- `75723ee7b6b08a5f278fd488d7ecbaf59ca89dd6` — LG-007, definizione di scelta di nodo possibile.
- `d4df535a993a5c2c03773f408b4f33c1f7e99de5` — LG-008, definizione di terminale accettabile.
- `3dd72b08db5fff5e9a9f3ca1bf29bc6a098c16a4` — precisazione LG-008: valutazione dei terminali accettabili solo a fine costruzione dell'albero.
- `58dc4cfbe7890a66170f5f03afba05b804c1f3ff` — LG-009, configurazione iniziale e direzione principe per ritorno a sinistra.
- `7a77cc8fae70d79fcccd1359fbd555fd439f5be7` — precisazione LG-009: destra/sinistra riferite al verso del tubo di collegamento `esterno -> stanza`.
- `0620f934f4b183f514e8e80ffd436a2008533df1` — LG-010, lato di ritorno indipendente per ogni tubo di collegamento di ingresso.
- `ae5cab7d3b4581ac652718cb44dc5416c75c7b7e` — LG-011, albero di collegamento idraulico: mandata input utente, ritorno generato dall'algoritmo.
- `d235a60b89d26dbdaf6198716822659ef1c613e5` — LG-012, radice del ritorno a 0,50 m e parallela alla parete architettonica più vicina.
- `34a82b9e885a230623509e17fa395d4bd8e2275a` — LG-013, primo tratto nella direzione del tubo di collegamento (rettifica LG-013); parallelismo obbligatorio dal secondo tratto.
- `ed9ae3ce976969623b3dae9ecd33540ff1589cb1` — LG-014, ritorno nel corridoio segue la mandata quando possibile e salta le evoluzioni impossibili.
- `e5a25a64eb7b5c1e637c6921ad4362da1834efc3` — LG-015, configurazione terminale mandata/ritorno e derivazione della scelta iniziale della spirale.
- `1b28cef915a91a19f5a35aeab08c6a86e049211e` — LG-016, scelta di prosecuzione rettilinea nella direzione di provenienza fino al primo ostacolo frontale.
- `d4918352f17733af8cae7b6d2ff86dea55a7791a` — precisazione LG-016: `PROSEGUI_DRITTO` è deroga esplicita al parallelismo con altre linee.
- `613dddd87fe4c980378046eaa685276d07aef7c6` — LG-017, linea frontale obbligatoria e troncamento del nuovo tratto alla distanza di rispetto.
- `d56f19c963a0a2fd350f019df7f7189f4d06e64d` — LG-018, flusso generale StrategiaDiego dalla rete di ritorno alla generazione definitiva.
- `f998d9a814cbc018c2ea5bcf64d25cd840af9226` — LG-019, evoluzione test-driven delle linee guida StrategiaDiego.
- `6d799d813e48a7d3871f3e5c7e995caacc62fe8e` — LG-020, riferimento sussidiario a Spirali Vittorio e Spirali GPT per aspetti non ancora definiti.
- `9da82a4b2ebe7da71913dd8d862a86414744352b` — LG-021, enumerazione completa delle linee di riferimento a ogni nodo.
- `0b001e6d3ca2c8b4122523fffb5023fb059822bf` — LG-022, direzione di provenienza ed estremo libero del tubo di collegamento.
- `fa8fc74265bbebc95b4416578bcda2ffd530b8e2` — LG-023, riferimento di parallelismo vincolato alla linea che ha troncato il tratto precedente; LG-021 rettificata.
- `ac362fc3ac48e038d919e9d368382cef22085115` — LG-024, generazione di entrambi i versi della nuova parallela senza potatura predittiva.
- `1ddaa84f865d1c3db1a0096a1b66bc901f9a8a4b` — LG-025, condizione di terminale dell'albero di mandata.
- `a680230894848e9c4b1777a0d63b959b863fc7f0` — LG-026, origine della spirale di ritorno dal tubo di collegamento di ritorno già generato.
- `ff8a1912882d1fa76e4e93db5ad614b094ff3c0a` — LG-027, stessa strategia di nodo condivisa da mandata e ritorno.
- `837a3148ce97d34d1e97207383fa3da159ed1a74` — LG-028, sottoalbero di ritorno distinto per ogni terminale della mandata e metriche di sostenibilità computazionale.
- `487553ad051c94f975045c94ced5b14c9920b37d` — LG-029, valutazione preliminare della chiusura tramite segmento diretto e futura verifica avanzata.
- `52f42a221bda4f479285d2e6d0654c29c85d0533` — LG-030, classificazione di StrategiaDiego come strategia computazionalmente pesante e selezionabile.
- `6c209c4db9c44ac8db05cfafb9eb9992fe6b6e76` — LG-031, geometria vincolante per ciascun ramo di ritorno.
- `34f691165cfd6a0e9f6509162e51ad455cf78013` — LG-032, geometria vincolante isolata per ciascun ramo di mandata.
- `6d14e0f98141f97a08fabd1401bd5ea1302ece17` — rettifica LG-013/LG-022: primo tratto allineato al tubo di collegamento entrante, con punto finale libero, per mandata e ritorno.
- `b21f2810bcb2fe2cf941539dc7c7c9f9fec6dd21` — LG-033, principio di inseguimento progressivo dei tratti della precedente evoluzione nei percorsi convessi.
- `3d2f21e49fae63ba36c5f60625d79089dfea4ce3` — prima formulazione LG-034, troncatura `-d/+d` per concavo/convesso; successivamente precisata per geometrie non ortogonali.
- `f51c468fc58cd42a48a18f5dc6696322ebcf07b0` — precisazione LG-034 e nuova LG-035 dopo confronto Vittorio/GPT: costruzione esatta tramite parallele offset e classificazione code-ready concavo/convesso.


### INCARICO 2026-09-24 — Pianta pulita persistente come artifact di progetto
Stato: ESEGUITO

Commissionato:
- verificare e mantenere attivo il percorso storico `LeggiDxf -> GeneraPianta` che, in modalità 2 sui piani calpestabili, produce la pianta architettonica derivata dal modello;
- denominare funzionalmente questo elaborato **Pianta pulita**;
- conservare nel Core l'output SVG già equivalente alla pianta DXF storica, formato `TERMODEL-CLEAN-FLOOR-SVG-V1`;
- trasferire tutte le piante pulite prodotte da una elaborazione nel `ProjectCalculationData` e pubblicarle atomicamente nel workspace del relativo `projectId`;
- esporre ogni piano tramite `GET /api/projects/{projectId}/artifacts/pianta-pulita/{piano}`, senza rieseguire il calcolo;
- rendere gli SVG reperibili anche dal catalogo universale `generated-files`;
- mantenere compatibile il legacy `GET /api/model/clean-floor/{floorName}`;
- aggiungere regression HTTP automatica che verifichi generazione, persistenza, catalogo e lettura dell'SVG;
- non modificare frontend, Library Desktop o `definizionedati.json`.

Risultato:
- verificato il percorso reale `GeneraModello -> LeggiDxf.LeggiFileDxf(..., modo 2, ...) -> GeneraPianta` sui piani calpestabili;
- la copia headless di `GeneraPianta.SalvaDXF()` continua a produrre l'SVG canonico `TERMODEL-CLEAN-FLOOR-SVG-V1`, unità cm, senza modificare la Library Desktop;
- `Model3DGenerationResult.CleanFloorPlans` viene ora trasferito in `ProjectCalculationData`;
- `ProjectStore` salva atomicamente ogni SVG sotto `artifacts/pianta-pulita/`, con nome fisico deterministico derivato dal nome logico del piano;
- `POST /api/calculations` elenca le Piante pulite tra gli artifact della risposta, con `floorName` e href projectId-scoped;
- implementato `GET /api/projects/{projectId}/artifacts/pianta-pulita/{piano}`, che restituisce `image/svg+xml`, header stale coerente e non riesegue il calcolo;
- gli stessi SVG sono automaticamente visibili nel canale universale `GET /api/projects/{projectId}/generated-files`;
- il legacy `GET /api/model/clean-floor/{floorName}` è rimasto invariato e compatibile;
- `calculation.log` registra `cleanFloorPlanCount`;
- contratto condiviso aggiornato a **v1.23**;
- frontend, Library Desktop e `definizionedati.json` non modificati.

Verifica:
- progetto regression reale `RadiantPanelsReference`, piano `Unico`;
- GitHub Actions run **#343**, id `36012889814`, job `107677835677`: **SUCCESS**;
- build Release: SUCCESS;
- smoke HTTP/storage/lock, feedback, esecutivo SVG/DXF e snapshot: SUCCESS;
- marker `CLEAN_FLOOR_ARTIFACT_OK`: SUCCESS;
- marker `RADIANT_REFERENCE_PROJECT_OK`: SUCCESS;
- verificati persistenza del file, catalogo `generated-files`, endpoint HTTP 200, `Content-Type: image/svg+xml`, marker SVG canonici e identità del contenuto;
- verificato che i GET non cambino i timestamp di `calculation.log` o dell'SVG: nessun ricalcolo/riscrittura in lettura;
- stato finale `TERMODEL_JOB_STATUS=SUCCESS`;
- notifica telefono `PHONE_NOTIFICATION_SENT status=SUCCESS`;
- prova manuale Visual Studio/browser locale: non eseguita in questa sessione.

Commit principali:
- `16279e6239ab7d22b9c0c9d0b153d652115256ff` — registrazione incarico;
- `149ce02891900adfbe48373833ddcfc48abce629` — contratto v1.23;
- `ef4cd8073a184ef1d87c470a97c4150983d9a507` — persistenza artifact + endpoint + regression;
- `11c6091ec653571dbe10e2b3a849db2f6603582b` — correzione header HTTP;
- `8efdb3329eb30eb2ac962ed6e1dd8a3d2001e71f` — regression finale valida.


### INCARICO 2026-09-24 — registro strategie geometriche SpiraliGPT
Stato: ESEGUITO

Commissionato:
- creare un registro Git dedicato alle decisioni strategiche geometriche per pannelli/SpiraliGPT, distinto dal catalogo storico dei pattern difettosi;
- registrare come prima regola il caso osservato sul progetto regression pannelli: **imbottigliamento / collo di bottiglia selettivo**;
- conservare per ogni regola testo, immagine di riferimento, motivazione e criteri di verifica;
- formalizzare la strategia indicata dall'utente: il ritorno blu può superare il collo quando può entrare e uscire; la mandata rossa deve evitare di impegnare una regione oltre il collo quando, una volta entrata, non può proseguire e richiudersi correttamente;
- usare il registro come vincolo di regressione per future strategie geometriche;
- non modificare in questo incarico l'algoritmo SpiraliGPT, la Library Desktop o `definizionedati.json`.

Risultato:
- creato `Server/Termodelwebservice/docs/spirali-strategy-register/README.md` come indice autorevole;
- creata `STRATEGY-001-imbottigliamento-selettivo.md` con stato **ATTIVA**;
- conservato lo screenshot utente in `images/STRATEGY-001-imbottigliamento-selettivo.png`;
- creato `TEMPLATE.md` per le future decisioni strategiche;
- formalizzata la distinzione tra area geometricamente raggiungibile e area validamente copribile dalla mandata;
- formalizzato che il ritorno può attraversare il collo quando dispone di continuità di ingresso/uscita, mentre la mandata deve evitare la regione oltre il collo quando l'ingresso la renderebbe topologicamente intrappolata;
- specificato che la scheda non impone ancora una soglia numerica o un algoritmo particolare: impone il comportamento da preservare;
- collegato STRATEGY-001 al progetto regression `RadiantPanelsReference` e al runner `smoke-radiant-reference.ps1`;
- mantenuto separato il registro strategico dal catalogo consultivo `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/PatternDifettosi/`.

Verifica:
- file Markdown riletti da `main`;
- immagine PNG riletta da GitHub come blob base64 valido;
- nessuna modifica a Core, WebService runtime, frontend, Library Desktop o `definizionedati.json`;
- non è stato modificato l'algoritmo: questo incarico consolida soltanto la strategia che i successivi interventi dovranno rispettare.

Commit:
- `99c270f5de712309888631fd07ef2e5544eb79ef` — registrazione incarico;
- `5911d0977c119b0540851efe8380e98271f0cc8f` — registro, STRATEGY-001, template e immagine.



### INCARICO 2026-09-24 — ritorno apertura/salvataggio progetti al frontend
Stato: ESEGUITO

Commissionato:
- rendere nuovamente `File → Apri`, `Salva` e `Salva con nome` completamente locali al frontend, usando il file unico `TERMODEL-PROJECT-TEXT-V1`;
- eliminare dal frontend corrente la dipendenza da elenco progetti, open/save server, lock, heartbeat e allocate-id;
- mantenere Render/Termodel.WebService come motore di calcolo e sorgente degli artifact, non come archivio autorevole dei progetti;
- rendere `POST /api/calculations` autosufficiente anche quando il `projectId` non esiste ancora nel filesystem del Service o è stato perso dopo redeploy;
- generare localmente un UUID nel frontend quando il manifest non contiene `projectId`;
- mantenere compatibili gli endpoint legacy di gestione progetto senza usarli nel flusso frontend corrente;
- non modificare `definizionedati.json` né la Library Desktop.

Risultato:
- frontend portato a **v1.12**: `Apri...` usa il file picker locale; `Salva` e `Salva con nome` scaricano localmente il file unico;
- rimossi dal frontend corrente lock token, heartbeat, close, open/save server e `allocate-id`;
- il `projectId` viene letto dal manifest oppure generato localmente come UUID tecnico;
- `Aggiorna Modello` invia direttamente il progetto completo senza header lock;
- `POST /api/calculations` non richiede più `ProjectLockManager` e `ProjectStore.UpdateCurrentAsync` crea/ricrea il workspace anche per un projectId mai allocato;
- gli endpoint server legacy di open/save/lock restano disponibili e i relativi smoke test continuano a passare;
- caricando/creando un progetto locale vengono invalidati soltanto manifest/overlay transienti degli artifact server;
- il comando CAD per caricare l'esecutivo server resta disabilitato finché la sessione corrente non ha completato un nuovo calcolo;
- contratto condiviso aggiornato a **v1.21** con file locale come copia autorevole e workspace Render ricreabile.

Verifica:
- GitHub Actions run `35980223478`, job `107570267161`: **SUCCESS**;
- `node --check docs/termodel-ui-demo/app.js`: SUCCESS;
- build Release `Termodel.WebService.sln`: SUCCESS;
- smoke `LOCAL_PROJECT_CALCULATION_SMOKE_OK`: un projectId locale non allocato, senza open/lock, crea il workspace e rende disponibile `model3d`;
- smoke legacy `PROJECT_LOCK_SMOKE_OK`: SUCCESS, quindi compatibilità endpoint storici conservata;
- smoke feedback, esecutivo pannelli SVG/DXF, progetto reale pannelli e snapshot GitHub: SUCCESS;
- stato finale workflow: `TERMODEL_JOB_STATUS=SUCCESS`; notifica telefono: `PHONE_NOTIFICATION_SENT status=SUCCESS`;
- prova manuale interattiva Apri/Salva nel browser non eseguita da questa sessione: la verifica raggiunta è sorgente + CI + smoke HTTP.

Commit principali dell'intervento:
- `c1a0cfcd982e6be4b8569cbee564807820f0766b` — Restore local project open and save;
- `c6bf70ceefbc8d3662af31230f20ec9859914050` — Make calculations independent of project locks;
- `c797a5ad3b8c560b60e05b2ee2a0dd8a66a28a3d` — Allow calculations to recreate missing workspaces;
- `bad21112326440570823f26d41112c1107ed2e5c` — frontend v1.12;
- `f521c0a04567747046af581e9ba80ce1a8c800c4` / `166189e558a17bd0a50b4b2c5b9970bdd46d5534` — regression CI lock-free e correzione lista legacy;
- `7a99c29438fd996f9c780b6dd80e7ba242fb9bbe` — contratto v1.21 coerente con autorità locale.


### INCARICO 2026-09-24 — progetto regression reale pannelli radianti
Stato: ESEGUITO

Commissionato:
- consolidare su GitHub il progetto reale `TERMODEL-PROJECT-TEXT-V1` fornito dall'utente come fixture permanente per il calcolo pannelli radianti;
- analizzare integralmente progetto, archivi Reti/TipologiePannelli, geometria edificio e rete Tubo Txxx;
- eseguire il progetto reale contro il Service tramite GitHub Actions, raccogliendo `pannelli.json`, esecutivo SVG/DXF e log;
- correggere eventuali difetti del progetto fixture quando i dati risultano incoerenti o corrotti;
- correggere il CAD/frontend se il progetto dimostra che il disegno generato dal CAD 2D è difettoso;
- introdurre un regression test permanente sul progetto reale, senza modificare `definizionedati.json` né la Library Desktop;
- seguire le notifiche obbligatorie GitHub Actions tramite `Termodel/job`.

Analisi del progetto reale:
- file ricevuto: 987.311 byte, 34.125 righe, 33 sezioni;
- SHA-256 byte-per-byte CRLF ricevuto: `a2b5ddce40059ecae852ca572491bca230a1a95ecce376f8d2e69a43c0196411`;
- SHA-256 dello stesso contenuto normalizzato LF: `4af2675d670ed039f00d36e9c3fc82061db27a3c19cb4e5451faa69f3ebfe87a`;
- le impronte di tutte le sezioni dichiarate nel manifest coincidono con il contenuto normalizzato LF: il contenitore non risulta corrotto;
- rete `RAD-DEFAULT`: PannelliRadianti, tipologia `GEN-DEFAULT`, passo 300 mm, acqua 35/30 °C, ambiente 20 °C, diametro interno 12 mm, limite 100 m / 25.000 Pa;
- geometria Tubo: 12 segmenti `T002..T013`, layer `Unico_tubipannelli`, tutti associati a `RAD-DEFAULT`;
- la mancanza di `T001` è compatibile con una cancellazione CAD ed è stata classificata come non errore: gli ID non devono essere contigui;
- lunghezza centerline complessiva misurata: **19,599780842518 m**.

Difetto reale individuato:
- sei sequenze Tubo distinte condividono il punto di collettore `(583.349, 474.316) cm`;
- il CAD precedente salvava rete/piano/layer, ma non l'identità della sequenza/circuito;
- il Core precedente raggruppava esclusivamente per connettività geometrica entro 1 mm, quindi i 12 segmenti diventavano **un solo componente ramificato** invece di sei circuiti;
- il difetto è di contratto CAD→Core, non delle coordinate disegnate: spostare artificialmente i punti del collettore sarebbe stata una correzione geometrica sbagliata.

Correzione progetto/fixture:
- fixture permanente conservata in quattro parti UTF-8 LF sotto `tests/fixtures/RadiantPanelsReference.original.part01..04.txt`, con entrambe le impronte CRLF/LF documentate;
- `RadiantPanelsReference.circuit-map.json` registra la correzione semantica autorevole del progetto reale:
  - C001 = T002;
  - C002 = T003,T004;
  - C003 = T005,T006;
  - C004 = T007;
  - C005 = T008,T009;
  - C006 = T010,T011,T012,T013;
- la correzione non modifica coordinate o lunghezze del progetto; aggiunge soltanto l'identità circuito mancante;
- `README-RadiantPanelsReference.md` documenta provenienza, hash, topologia, distinzione progetto locale/payload Service e criteri regression.

Correzione CAD/frontend:
- frontend portato a **v1.11**;
- ogni nuova sequenza `Tubo` riceve ora `data-termodel-circuito="Cnnn"`;
- tutti i segmenti della stessa sequenza mantengono lo stesso circuito, inclusa la chiusura;
- una nuova sequenza ottiene un nuovo circuito anche quando parte con Snap Vicino/Estremo da un tubo/punto collettore già esistente;
- il metadato viene conservato dal normale `buildTermodelServerPayload()`; non è stato introdotto un formato progetto parallelo.

Correzione Core:
- `SvgDxfLineMetadata` conserva ora anche `CircuitCode` letto da `data-termodel-circuito`;
- `RadiantPanelCalculator` dà precedenza al circuito dichiarato dal CAD;
- circuiti dichiarati distinti possono condividere geometricamente il punto collettore senza essere fusi;
- se uno stesso circuito dichiarato contiene componenti disconnesse, il Core le separa e produce diagnostica;
- per i progetti legacy senza `data-termodel-circuito` resta il fallback storico per connettività geometrica;
- non è stato anticipato il grafo generalista Tubi: collettore topologico, percorso sfavorito, sizing, equilibratura e perdite concentrate restano nella futura fase Tubi universale.

Regression permanente:
- aggiunto `tools/smoke-radiant-reference.ps1` e collegato a `.github/workflows/termodel-service-build.yml`;
- il test ricompone la fixture, applica la mappa di correzione al progetto legacy, riproduce la canonicalizzazione frontend `TERMODEL-PROJECT-SVG-V1`, avvia realmente il Service e chiama `POST /api/calculations`;
- verifica 1 rete, **6 circuiti**, segment count per circuito, assenza di ramificazioni, lunghezze golden, valori idraulici positivi e lunghezza totale 19,599780842518 m;
- raccoglie come artifact CI progetto corretto, payload Service, `pannelli.json`, `pannelli-esecutivo.svg`, `pannelli-esecutivo.dxf`, `TermodelLog.md`, diagnostics e calculation.log;
- artifact reale del run verde: esecutivo SVG 25.991 byte, DXF 28.843 byte, **58 primitive**; calculation.log registra `radiantPanelCircuitCount=6`, `radiantExecutivePrimitiveCount=58`, `radiantExecutiveFloorCount=1`.

Verifica reale:
- primo run con nuovo regression, GitHub Actions **#318**, id `35978711969`: build e smoke preesistenti riusciti; regression nuovo fermato da un errore sintattico PowerShell nel solo script di test (`$wantedId:`), corretto senza modificare l'algoritmo; stato/notifica terminale FAILED eseguiti;
- GitHub Actions **#320**, id `35979205131`, commit `90baf12...`: **SUCCESS**;
- Build Release: **SUCCESS, 0 errori**;
- smoke HTTP/storage/lock preesistenti: SUCCESS;
- smoke esecutivo pannelli sintetico: SUCCESS;
- regression progetto reale: `RADIANT_REFERENCE_PROJECT_OK`;
- risultato reale: `networkCount=1`, `circuitCount=6`, `totalLengthM=19.599780842518`;
- artifact diagnostico `radiant-reference-regression` pubblicato con 10 file e ispezionato;
- Commit Status `Termodel/job=SUCCESS` e `PHONE_NOTIFICATION_SENT status=SUCCESS` verificati nello stesso run;
- compilazione/esecuzione Visual Studio locale dell'utente: NON ancora eseguita in questa chat;
- confronto con riferimento: SI per la topologia ricostruita dal progetto reale e le lunghezze centerline; NON è dichiarata equivalenza completa col futuro solver Tubi universale.

Contratto/documentazione:
- `docs/TERMODEL-FRONT-SERVICE-CONTRACT.md` aggiornato a **v1.20** con `data-termodel-circuito`, precedenza circuito esplicito e fallback legacy;
- `docs/TUBAZIONI-DEVELOPMENT-REGISTER.md` registra la milestone e mantiene separato il futuro grafo generalista.

Vincoli rispettati:
- `definizionedati.json` non modificato;
- Library Desktop non modificata;
- nessun nuovo formato concorrente a `TERMODEL-PROJECT-TEXT-V1`;
- geometria T002..T013 non alterata per mascherare il difetto topologico.

Commit principali:
- `c6de98a1...` — registrazione incarico;
- `bc7d2445...`, `0e09f92f...`, `2274cd5d...`, `ccc21870...` — fixture reale consolidata;
- `1eb7d026...` — CircuitCode nel Virtual CAD;
- `ac095f3b...` — solver per circuito dichiarato + fallback legacy;
- `4494a142...`, `20c0681c...` — CAD v1.11 con identità circuito;
- `b9f8df62...` — contratto v1.20;
- `3d177282...`, `db075dc1...` — mappa/README fixture;
- `c964e36d...`, `cc1b6a3f...` — regression reale e workflow;
- `90baf12b...` — fix sintassi regression, run #320 verde;
- `c36b7505...` — registro Tubazioni;
- `6f890661...`, `6a5836db...` — robustezza hash fixture e documentazione hash CRLF/LF.

### INCARICO 2026-09-24 — selezione e cancellazione Tubo CAD 2D
Stato: ESEGUITO

Commissionato:
- in modalità `Rete` rendere selezionabili con click le entità `Tubo` Txxx già disegnate sul piano corrente;
- abilitare il pulsante `Elimina` quando è selezionato un tubo e cancellare soltanto quel segmento dal `geometry/project.svg`;
- mantenere invariata la selezione/cancellazione delle pareti E/W in modalità `Edificio`;
- non estendere implicitamente ai tubi il drag/modifica geometrica delle pareti: l'obiettivo corrente è selezione + cancellazione;
- preservare undo/redo e il normale flusso `Consolida rete`;
- modifica limitata al frontend `docs/termodel-ui-demo`, senza toccare Service/Core, contratto API, `definizionedati.json` o Library Desktop;
- incrementare versione/cache busting frontend e verificare staticamente il percorso.

Risultato:
- individuata la causa: il renderer marcava come editabili/selezionabili soltanto le linee E/W; inoltre `cadSelectLine`, `cadUpdateControls`, `cadSyncOverlay` e `cadDeleteSelected` usavano `cadFindSourceLine()`, che rifiuta correttamente le entità Txxx;
- aggiunta `cadFindSelectableLine()`: in modalità `Rete` accetta soltanto i tubi del piano corrente, in modalità `Edificio` continua ad accettare soltanto le pareti E/W;
- il renderer rende cliccabili i Txxx soltanto quando `Modalità=Rete`; le pareti restano non selezionabili in tale modalità;
- il click su un tubo imposta `cadSelectedLineId`, applica l'evidenziazione `selected` e abilita `× Elimina`;
- la cancellazione rimuove soltanto il segmento selezionato dal documento SVG, mantiene undo/redo e mostra `Tubo Txxx eliminato · premi Consolida rete`;
- il drag geometrico delle pareti non è stato esteso ai tubi: dopo la selezione Txxx il percorso drag continua intenzionalmente a richiedere `cadFindSourceLine()`;
- tooltip del comando Elimina reso contestuale: tubo in modalità Rete, parete in modalità Edificio;
- frontend portato a **v1.10** con titolo e `app.js?v=1.10` per cache busting;
- Service/Core, contratto API, `definizionedati.json` e Library Desktop non modificati.

Verifica:
- sorgente GitHub ricontrollato dopo le modifiche;
- verificato staticamente che `cadFindSelectableLine()` accetti Txxx soltanto in modalità Rete;
- verificato che il renderer usi `cadIsPipeLine(line)` per rendere i tubi selezionabili in Rete e E/W in Edificio;
- verificato che `cadUpdateControls()` abiliti Elimina usando la selezione contestuale;
- verificato che `cadDeleteSelected()` rimuova la linea contestuale selezionata e produca feedback specifico Tubo/Parete;
- verificato che il drag dei tubi resti disattivato perché la routine di trascinamento continua a richiedere una parete E/W;
- verificati `APP_VERSION='1.10'`, titolo v1.10 e cache busting v1.10;
- compilazione: non applicabile al frontend statico JavaScript;
- esecuzione/test browser reale: NON ancora eseguito in questa chat.

Commit:
- `96996394...` — registrazione incarico;
- `0001127c...` — selezione/cancellazione tubo + versione app 1.10;
- `06384767...` — titolo/cache busting frontend 1.10;
- `b8d40583...` — tooltip Elimina contestuale.

### INCARICO 2026-09-24 — snap Vicino/Estremo sui tubi CAD 2D
Stato: ESEGUITO

Commissionato:
- correggere il CAD 2D in modalità `Rete`: durante il disegno `Tubo`, gli snap `Vicino` e `Estremo` devono agganciarsi ai tubi già disegnati sul piano corrente;
- mantenere invariata la modalità `Edificio`, dove gli snap continuano a usare le pareti E/W;
- mantenere invariato lo snap allo sfondo vettoriale;
- applicare la modifica minima al frontend `docs/termodel-ui-demo`, senza toccare Service/Core, contratto API, `definizionedati.json` o Library Desktop;
- incrementare la versione/cache busting frontend e verificare staticamente il percorso di snap.

Risultato:
- individuata la causa: `cadSnapPoint()` iterava esclusivamente su `cadEditableSourceLines()`, che contiene solo pareti E/W; le entità `Tubo` Txxx erano quindi escluse dallo snap;
- aggiunta `cadSnapSourceLines()`: in modalità `Edificio` restituisce le pareti E/W del piano corrente, in modalità `Rete` restituisce i tubi Txxx del piano corrente;
- `cadSnapPoint()` usa ora la sorgente contestuale e distingue internamente `wall` / `pipe`, mantenendo lo snap allo sfondo vettoriale invariato;
- `Snap Estremo` può agganciare gli endpoint dei tubi già disegnati;
- `Snap Vicino` può agganciare la proiezione sul segmento tubo già disegnato;
- il normale vincolo `Orto` resta invariato: quando attivo, uno snap incompatibile con l'asse ortogonale continua correttamente a non prevalere;
- frontend portato a **v1.09**; titolo e query `app.js?v=1.09` aggiornati per cache busting;
- Service/Core, contratto API, `definizionedati.json` e Library Desktop non modificati.

Verifica:
- sorgente GitHub ricontrollato dopo la modifica;
- verificato staticamente che in modalità Rete la sorgente snap sia `cadAllPipeLines().filter(cadEntityBelongsToCurrentPlane)`;
- verificato staticamente che in modalità Edificio resti `cadEditableSourceLines()`;
- verificato che `targetLineId` accetti sia sorgenti `wall` sia `pipe`;
- verificati `APP_VERSION='1.09'`, titolo v1.09 e cache busting v1.09;
- compilazione: non applicabile al frontend statico JavaScript;
- esecuzione/test browser reale: NON ancora eseguito in questa chat;
- deploy GitHub Pages associato al commit: non ancora osservato al momento della chiusura dell'incarico.

Commit:
- `646321df...` — registrazione incarico;
- `810fbac1...` — correzione snap contestuale pareti/tubi + versione app 1.09;
- `73a58e1f...` — titolo/cache busting frontend 1.09.

### INCARICO 2026-09-24 — pulsante versione desktop completa dalla main mobile
Stato: ESEGUITO

Commissionato:
- nella main Android/mobile aggiungere accanto al pulsante `Esplora` un piccolo pulsante con icona monitor per passare volontariamente alla versione completa desktop;
- il comando deve disattivare la modalità immersiva Android esistente, mostrare barre/menu/pannelli desktop reali e usare una viewport logica desktop, senza duplicare l'interfaccia;
- la modifica riguarda soltanto `docs/termodel-ui-demo`; non modificare Service, Core, contratto API, `definizionedati.json` o Library Desktop;
- preservare il comportamento mobile attuale finché l'utente non preme il nuovo pulsante.

Risultato:
- `docs/termodel-ui-demo/app.js`: aggiunto accanto a `Esplora` il pulsante compatto `androidFullDesktop` con icona SVG monitor e descrizione accessibile “Versione completa desktop”;
- il click chiude l'eventuale menu Esplora e chiama `enableTermodelFullDesktopLayout()`;
- il passaggio rimuove la classe `termodel-android`, mantiene un flag che impedisce ai successivi eventi resize/orientation di riapplicare gli override immersivi e pulisce le altezze/grid inline impostate dalla modalità Android;
- la meta viewport viene portata a **1100 px logici**, oltre tutte le breakpoint responsive correnti (massimo 900/820 px), così il tablet usa la UI desktop completa invece delle regole mobile;
- nessuna UI desktop è stata duplicata: vengono semplicemente rese nuovamente visibili titlebar, menubar, tabs, bottom bar e pannelli già esistenti;
- frontend portato a **v1.08**, titolo statico e `app.js?v=1.08` aggiornati.

Verifica:
- sorgente GitHub ricontrollato dopo i commit: pulsante presente subito dopo `Esplora`, listener presente e collegato alla funzione di passaggio desktop;
- controllo statico delle breakpoint: viewport 1100 px supera le soglie responsive presenti in `index.html`;
- compilazione: non applicabile al frontend statico JavaScript;
- esecuzione browser/tablet reale: NON ancora verificata in questa chat;
- test visuale su dispositivo Android/tablet: NON ancora eseguito;
- Service/Core/contratto API/`definizionedati.json`/Library Desktop: non modificati.

Commit:
- `91f456d6...` — registrazione incarico;
- `d2e6db82...` — pulsante e logica passaggio alla UI desktop completa;
- `a10a56af...` — versione/cache busting frontend 1.08.

### INCARICO 2026-09-24 — feedback DXF non deve deformare la toolbar CAD 2D
Stato: ESEGUITO

Segnalazione reale:
- screenshot utente con Termodel CAD 2D v1.06 dopo importazione DXF;
- il messaggio arancione completo `DXF convertito dal Service ...` occupava
  larghezza propria nella toolbar e invadeva visivamente i comandi successivi
  (`Esporta pianta CAD` / `Torna al modello 3d`).

Causa:
- `.cad-toolbar .cad-status` aveva `white-space: nowrap` e una
  `min-width`, ma nessun limite desktop di larghezza/overflow;
- un feedback diagnostico lungo poteva quindi diventare il principale elemento
  flessibile della barra.

Correzione:
- `docs/termodel-ui-demo/index.html`:
  - status CAD: `flex: 0 1 340px`;
  - `min-width: 120px`, `max-width: 340px`;
  - `overflow: hidden` e `text-overflow: ellipsis`;
  - resta `white-space: nowrap`, quindi la toolbar mantiene una sola riga;
- `docs/termodel-ui-demo/app.js`:
  - `cadSetStatus()` normalizza il testo e copia sempre il messaggio completo
    in `title`, quindi l'ellissi non perde l'informazione;
- versione frontend portata da **1.06 a 1.07** e query
  `app.js?v=1.07` per cache busting;
- nessuna modifica all'algoritmo DXF→SVG, al contratto API, ai dati progetto o
  a `definizionedati.json`.

Commit:
- `2d7a9a99...` — limite/ellissi dello status + cache busting;
- `bc40549a...` — tooltip completo e versione frontend 1.07.

Verifica:
- diagnosi effettuata sullo screenshot reale dell'utente;
- sorgente GitHub ricontrollato dopo la modifica: il feedback lungo non può più
  superare 340 px su desktop ed è troncato con ellissi;
- messaggio integrale resta disponibile nel tooltip;
- GitHub Actions Service dell'incarico preliminare: run `35968135152`,
  `Termodel/job = SUCCESS`;
- verifica visuale finale sul browser dell'utente dopo aggiornamento GitHub
  Pages/cache: NON ancora eseguita in questa chat.


### INCARICO 2026-09-24 — Farmacia.dxf come regression fixture e ottimizzazione pianta architettonica
Stato: ESEGUITO

Commissionato:
- consolidare nel repository GitHub il DXF reale fornito dall'utente, `Farmacia.dxf`, come fixture permanente per i test DXF→SVG;
- usare il file reale per misurare layer, entità, unità, bounding box e qualità dello SVG prodotto;
- ottimizzare `Termodel.Core.Cad.DxfSvgConverter` affinché produca un profilo automatico di pianta architettonica intellegibile, preservando la modalità manuale;
- aggiungere regression test GitHub Actions basati sul DXF reale;
- non modificare `definizionedati.json` né la Library Desktop.

Fixture consolidata:
- originale ricevuto: `Farmacia.dxf`, **3.225.548 byte**, SHA-256
  `81b7e14c361b0b5de94a877c715091b77a42f599c6a757ca1fc2906251496adc`;
- per limitare il peso Git senza perdere un solo byte, la fixture è conservata
  lossless come
  `Server/Termodelwebservice/tests/fixtures/Farmacia.dxf.gz.b64`;
- il workflow esegue Base64 decode + gzip decompress e verifica lo SHA-256
  dell'originale prima di ogni test;
- documentazione fixture:
  `Server/Termodelwebservice/tests/fixtures/README-Farmacia.md`;
- il file originale dichiara `$INSUNITS=6` (metri), contiene 382 entità
  principali e i layer operativi `0`, `01-SEZIONI`,
  `02-PROIEZIONI`, `03-QUOTE`, `04-RETINI`.

Ottimizzazione implementata:
- `DxfSvgConversionOptions` supporta ora `Profile` con valori
  `manual` e `architectural`; default API storico: `manual`;
- nel profilo `architectural` il Core seleziona automaticamente i layer
  geometrici utili e filtra nomi tipicamente annotativi/non architettonici
  (quote/dimensioni, retini/hatch, testi/scritte, arredi/furniture,
  figure, Defpoints);
- viene filtrato anche un layer in cui quote/testi/retini prevalgono
  numericamente sulla geometria utile;
- il profilo architettonico abilita automaticamente curve e bulge anche se
  `curves=false`, così porte, archi e aperture restano leggibili;
- i gruppi SVG dichiarano `data-dxf-role=section|projection|base` e usano una
  lieve gerarchia di spessore: sezioni/muri/strutture più marcati,
  proiezioni/infissi più leggeri;
- la radice SVG dichiara `data-termodel-dxf-profile`;
- la risposta API aggiunge `profile` e `appliedLayers`;
- `DxfToSvgRequest` espone il nuovo campo `profile`;
- modalità manuale invariata: se il frontend passa `manual`, il Core
  rispetta la selezione esplicita.

Frontend:
- import DXF apre ora di default in profilo **pianta architettonica automatica**;
- curve abilitate di default;
- layer con nomi evidentemente annotativi/arredo vengono deselezionati nel
  dialog;
- se l'utente cambia layer o opzioni grafiche il frontend passa a
  `profile=manual`, preservando il controllo esplicito;
- nessuna conversione SVG è stata reintrodotta nel browser.

Regression reale `Farmacia.dxf`:
- GitHub Actions run `35966250710`, commit `c74604da...`:
  **SUCCESS**, build **0 errori** e
  `FARMACIA_DXF_ARCHITECTURAL_SMOKE_OK`;
- risultato reale Service/Core:
  `appliedLayers = 0, 01-SEZIONI, 02-PROIEZIONI`;
- `03-QUOTE` e `04-RETINI` assenti dall'SVG architettonico;
- **227 entità convertite**;
- unità riconosciuta: metri, `unitScaleToCm=100`;
- ingombro architettonico: **19,050 × 17,153 m**;
- SVG verificato con metadata di profilo e ruoli grafici;
- GitHub Actions run `35966314257`, commit `0e916722...`:
  **SUCCESS**, build **0 errori**, regression Farmacia positiva e artifact
  `dxf-svg-regression` pubblicato;
- artifact reale scaricato e ispezionato dalla chat:
  `Farmacia.architectural.svg`, 23.284 byte, con planimetria chiaramente
  leggibile su fondo bianco: muri, partizioni, porte e archi conservati,
  senza l'espansione del viewBox causata dalle quote/retini;
- metadata artifact:
  `converted=227`, `ignored=155`, `unsupported=0`,
  `widthMeters=19.04993883792071`,
  `heightMeters=17.153186825263063`.

Documentazione:
- contratto Frontend↔Service aggiornato a **v1.19**;
- README Service documenta profilo architettonico e fixture reale;
- `definizionedati.json`, Library Desktop e algoritmo Desktop non modificati.

Stato di verifica:
- **progettato:** SI;
- **implementato:** SI;
- **fixture reale consolidata:** SI, con hash dell'originale verificato;
- **compilato GitHub Actions:** SI, 0 errori;
- **eseguito/testato via HTTP:** SI;
- **regression sul DXF Farmacia reale:** SI;
- **output SVG reale ispezionato visivamente:** SI;
- **compilato/eseguito in Visual Studio locale dell'utente:** NON ancora
  verificato in questa chat.

Commit principali:
- `06c4a4b0...` — registrazione incarico;
- `10f7104e...` — fixture Farmacia lossless;
- `564d80e0...` — documentazione fixture;
- `6cc63b01...` — profilo architettonico nel Core;
- `2f4e47ef...` — esposizione profilo nell'API;
- `7d155abf...` — default frontend architettonico;
- `c74604da...` — regression Farmacia;
- `0e916722...` — artifact SVG di regression;
- `6abcc42d...` — contratto v1.19;
- `ff2c3e27...` — README Service.


### INCARICO 2026-09-24 — spostamento conversione DXF→SVG dal frontend al Service
Stato: ESEGUITO

Commissionato:
- spostare la conversione DXF→SVG attualmente implementata in `docs/termodel-ui-demo/dxf-plotter.js` dal browser al backend;
- collocare la logica di conversione headless e riutilizzabile in `Termodel.Core`, lasciando in `Termodel.WebService` soltanto il contratto HTTP/adattatore;
- mantenere nel frontend soltanto l'interfaccia utente e la chiamata al Service, preservando layer selezionati, unità, curve, testi e blocchi;
- non introdurre WPF/Helix nel Core e non modificare `definizionedati.json`.

Implementato:
- nuovo motore headless `Termodel.Core.Cad.DxfSvgConverter` in
  `src/Termodel.Core/Cad/DxfSvgConverter.cs`;
- parser/converter server-side per DXF ASCII 2D con LINE,
  LWPOLYLINE/POLYLINE e, su opzione, ARC/CIRCLE/ELLIPSE/SPLINE,
  TEXT/MTEXT e INSERT/blocchi;
- conservate le convenzioni del precedente converter Web: scelta layer,
  `$INSUNITS`, unità `mm/cm/m`, scala in centimetri Termodel, origine
  normalizzata, `data-dxf-layer`, statistiche, bounds e viewBox;
- nuovo endpoint `POST /api/dxf/to-svg`; payload JSON con DXF originale,
  layer e opzioni; input non convertibile restituisce HTTP 422;
- CORS già globale del Service rende l'endpoint disponibile al frontend
  pubblico autorizzato;
- `docs/termodel-ui-demo/dxf-plotter.js` non esporta più
  `convertDxfToSvg`: resta soltanto l'analizzatore leggero necessario al
  dialog e alla stima preventiva;
- `docs/termodel-ui-demo/app.js` dopo la conferma del dialog chiama il
  Service e usa lo `svgText` restituito per lo sfondo CAD;
- contratto condiviso aggiornato a v1.18 e README Service aggiornato;
- `definizionedati.json` non modificato; nessuna dipendenza WPF/Helix
  introdotta nel Core.

Verifiche reali:
- prima build del porting, commit `5d0f7618...`: FALLITA correttamente in
  GitHub Actions per tre usi di `Math.Hypot` non disponibili nel target;
- correzione distanza con `Math.Sqrt(x*x+y*y)`, commit `1c6cc5e7...`:
  GitHub Actions SUCCESS;
- endpoint WebService, commit `de79f22a...`: build e smoke esistenti
  SUCCESS;
- workflow specifico DXF→SVG corretto nel commit `ba03a748...`;
- GitHub Actions run `35964233556`: **SUCCESS**, build Release
  **0 errori** e smoke HTTP specifico `DXF_TO_SVG_SMOKE_OK`;
- lo smoke invia un DXF ASCII con una LINE sul layer `WALL`, lunga
  `1000 mm`, e verifica risposta server con una entità convertita,
  `drawingUnit=mm`, `unitScaleToCm=0.1`, metadata layer/unità nello SVG
  e `realWidthMeters=1.0`;
- notifica/stato permanente `Termodel/job`: SUCCESS sul run
  `35964233556`.

Stato di verifica:
- **progettato:** SI;
- **implementato:** SI;
- **compilato in GitHub Actions:** SI, 0 errori;
- **eseguito nel runner Windows:** SI;
- **testato via HTTP:** SI, DXF→SVG smoke positivo;
- **frontend privo della conversione SVG locale:** SI;
- **compilato/eseguito nel Visual Studio locale dell'utente:** NON ancora
  verificato in questa chat;
- **confronto golden su DXF reale complesso:** NON ancora eseguito.

Commit principali:
- `67a34f1c...` — registrazione commissione;
- `5d0f7618...` / `1c6cc5e7...` — porting Core e fix .NET;
- `de79f22a...` — endpoint HTTP;
- `c6b2eae9...` / `245a1a66...` — rimozione conversione JS e chiamata Service;
- `0acec410...` — contratto Frontend↔Service v1.18;
- `163ecc67...` / `ba03a748...` — smoke DXF→SVG e correzione workflow;
- `649a510f...` — README Service.

### INCARICO 2026-09-24 — FIN visibili solo dal lato interno
Stato: ESEGUITO

Commissionato:
- riprodurre e correggere il difetto residuo dell'esempio pubblico `Appartamento`: dopo la precedente correzione di orientamento e profondità, le finestre risultano visibili dal lato interno ma ancora coperte/non visibili dal lato esterno;
- verificare congiuntamente offset lungo la normale della parete, verso dell'estrusione, profondità effettiva della FIN e orientamento/facce della mesh headless rispetto al riferimento Desktop;
- intervenire con modifica minima in Core/renderer, senza modificare frontend, `definizionedati.json` o Library Desktop salvo necessità dimostrata;
- verificare con GitHub Actions sull'Appartamento reale e distinguere build, esecuzione HTTP, regressione geometrica e verifica visiva.

Risultato:
- confrontati gli artifact reali GitHub Actions prima e dopo la correzione dello spessore, non soltanto il codice;
- artifact precedente alla correzione (run #259 / id `35955220418`): per F001 la parete E001 occupa lungo la normale circa `-0,34117..-0,21117 m`, mentre la FIN occupa solo `-0,26117..-0,16117 m`; la finestra sporge quindi sul lato interno ma resta circa 8 cm corta rispetto alla faccia esterna. Questo riproduce esattamente il sintomo riferito dall'utente;
- artifact successivo alla correzione (run #270 / id `35956863374`): la stessa FIN occupa `-0,35117..-0,20117 m`; attraversa l'intero spessore della parete e sporge circa 1 cm da entrambe le facce;
- verificato anche il renderer frontend corrente: `docs/termodel-ui-demo/app.js` usa `THREE.DoubleSide`, quindi il difetto non deriva dal back-face culling;
- nessuna ulteriore modifica geometrica è stata applicata: il codice corrente di `main` contiene già la correzione corretta in `Modello.AggiungiFinestra(...)`; aumentare arbitrariamente la profondità avrebbe mascherato un problema di deploy/artifact senza correggerne la causa;
- commit di registrazione incarico: `a6611fc252543ea2a84d72f79b26f14c1b185643`; GitHub Actions su tale stato, run `35961835080`, job `build`: **SUCCESS**;
- diagnosi residua: se nel browser pubblico la FIN è ancora visibile soltanto dall'interno, il modello visualizzato è compatibile con un artifact generato prima del commit `eb2f5479ed986259c0caf6ec312306954c3024ee` oppure con un Service Render non ancora allineato a quel commit; serve rigenerare l'artifact con `Aggiorna Modello` dopo il redeploy corrente;
- verifica diretta del runtime Render pubblico non ottenuta dagli strumenti di questa sessione; pertanto il deploy Render resta distinto dalla build GitHub verificata.

### INCARICO 2026-09-24 — visibilità FIN attraverso lo spessore parete
Stato: ESEGUITO

Commissionato:
- correggere l'esempio pubblico `Appartamento` perché le finestre, pur correttamente dimensionate e orientate nel piano, risultano coperte dalla parete ospite nel rendering 3D;
- verificare spessore e centratura della geometria FIN lungo la normale alla parete, confrontando il comportamento headless con il Desktop autorevole;
- correggere direttamente la causa nel Core/renderer senza modificare frontend, `definizionedati.json` o Library Desktop;
- verificare la correzione con build ed esecuzione reale GitHub Actions sull'Appartamento e controllare numericamente che ogni FIN attraversi lo spessore della parete associata.

Risultato:
- causa isolata in `Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/Model/Modello.cs`, metodo `AggiungiFinestra(..., spessoreParete)`: il parametro con lo spessore reale della parete arrivava correttamente da `LeggiDxf` ma veniva ignorato; la FIN veniva sempre costruita con profondità fissa `SpesPonte = 0,10 m` e centrata sulla linea CAD della parete;
- il renderer headless costruisce invece la parete a partire dalla linea CAD ed estrude lo spessore tutto lungo una normale. Nell'Appartamento reale la parete finestrata misura `0,13 m`: prima della correzione l'intervallo normale della parete era circa `-0,13..0,00 m`, mentre quello della FIN era `-0,05..+0,05 m`; il serramento non raggiungeva quindi la faccia opposta della parete e poteva risultare completamente coperto dalla mesh opaca osservando quel lato;
- correzione headless: `AggiungiFinestra` usa ora `abs(spessoreParete)`, calcola la stessa normale usata dall'estrusione parete, sposta il centro FIN di metà spessore nella parete e assegna profondità `max(0,10 m, spessoreParete + 0,02 m)`; il centimetro aggiuntivo per faccia evita z-fighting/copertura esatta;
- sull'Appartamento la FIN risultante è profonda `0,15 m` e occupa circa `-0,14..+0,01 m` rispetto alla linea della parete: è centrata sui `0,13 m` della parete e sporge di `0,01 m` su entrambe le facce;
- commit codice su `main`: `eb2f5479ed986259c0caf6ec312306954c3024ee` — `Expose FIN meshes through host wall thickness`;
- tracciatura della divergenza temporanea aggiornata in `CopiedFromTermodel/TERMODEL-SYNC.md`, commit `77acd802511425d2772892b433b9eeb4a32930df` — `Track headless FIN wall-thickness adaptation`; la Library Desktop non è stata modificata;
- GitHub Actions standard su `main`, run **#266**, id `35956352931`: **SUCCESS**;
- verifica dedicata definitiva su branch `ai-debug-fin-thickness-20260924`, run **#270**, id `35956863374`: **SUCCESS** sia per il job diagnostico sia per il job standard; build reale, avvio reale del Service, `POST /api/model/3d = 200`, `POST /api/calculations = 200`, artifact `model3d` con **438 primitive**;
- regression geometrica: **9 FIN controllate, 0 errori**. F001..F009 restano parallele alla parete associata con allineamento `1.000000`; per tutte il volume FIN contiene l'intero intervallo di spessore della parete e lascia circa `0,01 m` di sormonto su ciascuna faccia;
- confronto con artifact precedente alla correzione (run #259) conferma numericamente il difetto: parete `0,13 m` contro FIN `0,10 m`, centrata sulla linea e non sullo spessore della parete;
- strumentazione diagnostica temporanea rimossa dal branch al termine della prova; frontend, `definizionedati.json`, contratto Frontend↔Service e Library Desktop invariati;
- livello distinto non dichiarato: verifica visiva nel browser pubblico dopo il successivo redeploy Render.

### INCARICO 2026-09-24 — allineamento FIN alla parete nell'Appartamento
Stato: ESEGUITO

Commissionato:
- correggere il secondo difetto osservato nell'esempio pubblico `Appartamento`: finestre di dimensioni corrette ma ruotate/disallineate rispetto alla parete;
- confrontare il renderer headless Web con il `DrawBim` Desktop autorevole;
- intervenire soltanto sul punto responsabile dell'orientamento, senza modificare frontend, `definizionedati.json`, Library Desktop o algoritmi di associazione FIN-parete;
- verificare con GitHub Actions lo stesso Appartamento reale e controllare numericamente l'asse di ciascun FIN rispetto alla parete associata.

Risultato:
- causa isolata in `Server/Termodelwebservice/src/Termodel.Core/Compatibility/HeadlessDesktopUi.cs`, metodo `DrawBim.BuildBaseRing()`;
- `Modello.AggiungiFinestra()` calcolava già correttamente la direzione della parete e la passava come `rotationAngle`; il renderer headless applicava però tale rotazione soltanto ai profili con `verticale=true`;
- le finestre sono costruite con `verticale=false`, quindi il loro rettangolo base rimaneva parallelo agli assi globali. Il riferimento Desktop `SorgentiTermodel/Library/utilities/DrawBim.xaml.cs` applica invece la rotazione Z anche ai profili non verticali;
- correzione: nel ramo non verticale di `BuildBaseRing()` le coordinate locali X/Y vengono ruotate con la stessa matrice `cos/sin` prima della traslazione; non sono stati modificati `Modello.AggiungiFinestra`, `LeggiDxf`, frontend o Desktop;
- branch diagnostico: `ai-debug-fin-orientation-20260924`; strumentazione temporanea rimossa al termine;
- GitHub Actions run **#259**, id `35955220418`: build e Service reali riusciti; `POST /api/calculations = 200`, artifact `model3d` con **438 primitive**;
- regression check specifico: **9 FIN controllati, 0 errori**. Per F001..F009 il prodotto scalare assoluto tra asse larghezza della finestra e direzione della parete associata è `1.000000`; distanza centro finestra/punto FIN `0.000000` m;
- pareti associate verificate: F001/F002 -> E001, F003/F004 -> E002, F005/F006/F007 -> E003, F008/F009 -> E004;
- bounding box dopo la correzione: X `-1.77823..11.68775` m, Y `-0.34117..9.09104` m, Z `-0.1..3.89` m;
- commit su `main`: `d91e13acaf0c4a2447085bb4559bad51710383c9` — `Align Web FIN profiles with wall rotation`;
- GitHub Actions standard su `main`, run **#260**, id `35955388392`: **SUCCESS**; restore/build, storage+lock HTTP, feedback GitHub, pannelli SVG/DXF e snapshot publisher tutti riusciti;
- contratto Frontend↔Service invariato: il formato `TermodelWebModel v3` non cambia, si tratta di correzione del renderer headless per parità con Desktop;
- livello ancora distinto: prova visiva del nuovo commit sul Render pubblico/browser dopo redeploy.

### INCARICO 2026-09-24 — debug avanzato esempio Appartamento con GitHub Actions
Stato: ESEGUITO

Commissionato:
- riprodurre con GitHub Actions il difetto corrente per cui l'esempio pubblico `Appartamento` arriva a una vista 3D vuota;
- usare come input i file correnti di `main`, in particolare `docs/termodel-ui-demo/examples/catalog.json`, `appartamento.svg` e il template `ProgettoVuoto`;
- ricostruire il payload tecnico equivalente a `buildTermodelServerPayload()`, avviare realmente `Termodel.WebService`, chiamare `POST /api/calculations` e leggere l'artifact `model3d` senza rieseguire il calcolo;
- raccogliere response HTTP, `generated-files`, `model3d.json`, `TermodelLog.md`, diagnostica, workspace e stdout/stderr del Service;
- usare un branch diagnostico separato e strumentazione temporanea; non modificare `definizionedati.json` né la Library Desktop;
- distinguere se il vuoto nasce nell'input/canonicalizzazione frontend, nel Core/WebService, nell'artifact o nel redraw frontend;
- correggere soltanto la causa dimostrata dal test e ripetere l'Action prima di dichiarare il problema risolto.

Risultato:
- branch diagnostico usato: `ai-debug-appartamento-20260924`; la strumentazione temporanea è stata rimossa al termine;
- input reale: `docs/termodel-ui-demo/examples/appartamento.svg`, con 17 linee parete, 9 blocchi LOC e 9 blocchi FIN; i FIN Web memorizzano le dimensioni in centimetri, per esempio `LARGHEZZA=207.55`, `ALTEZZA=140`, `SOTTOFINESTRA=100`;
- **riproduzione prima della correzione:** GitHub Actions run **#251**, id `35947608742`, build + Service + POST `/api/calculations` riusciti; l'artifact non era vuoto ma conteneva **438 primitive**. Bounding box complessivo: X `-128.20225..151.31775` m, Y `-0.34117..9.09104` m, Z `-0.1..240` m;
- analisi per tipo: pareti/pavimenti/soffitti/ponti restavano entro circa 13,5 x 9,4 x 4 m; soltanto le 18 primitive `Finestra` arrivavano a X `-128.20225..151.31775` m e Z `100..240` m. Il frontend `fitView()` inquadra il bounding box completo, quindi l'edificio normale diventava visivamente quasi nullo: questa era la causa della vista 3D apparentemente vuota;
- **causa dimostrata:** `SvgDxfReader` convertiva correttamente coordinate e inserimenti SVG da cm a m, ma trasferiva senza conversione gli attributi testuali FIN `LARGHEZZA`, `ALTEZZA`, `SOTTOFINESTRA`, `SOPRALUCE`. Il Desktop autorevole dichiara esplicitamente questi quattro campi in metri in `MainWindow.xaml`; il CAD Web li serializza invece in cm, come confermato da `cadMetersToSvgCm(...)` e da `Finestra 2 punti`;
- **correzione:** `Server/Termodelwebservice/src/Termodel.Core/NetDxfCompat/SvgDxfReader.cs` normalizza ora esclusivamente quei quattro attributi del blocco `FIN` da cm a m al confine Virtual CAD; `NUMEROANTE` e gli altri attributi restano invariati. Il motore Desktop copiato `LeggiDxf/Modello` non è stato modificato;
- **verifica dopo la correzione:** GitHub Actions run **#252**, id `35947969346`, riuscito. Stesso esempio, stesso flusso HTTP, ancora **438 primitive**, ma bounding box complessivo corretto: X `-2.45163..12.95535` m, Y `-0.34117..9.09104` m, Z `-0.1..3.89` m; le finestre risultano Z `1.0..2.4` m e la prima finestra larga `2.0755` m;
- contratto Frontend↔Service aggiornato a **v1.16**: nel `TERMODEL-PROJECT-SVG-V1` Web gli attributi dimensionali FIN sono cm e `SvgDxfReader` li converte nei metri attesi dal Desktop;
- **main:** correzione codice commit `4663054cb7b337e242f6a12ed8864c3ba168a93e` — `Fix Web FIN dimensions at SVG-DXF boundary`; contratto commit `152b4d70a8bd51f898ad421d9341b0f9e2e518d7` — `Document FIN units across Web-Service boundary`;
- **build/smoke main:** GitHub Actions run **#253**, id `35948090552`, completato con successo: restore/build, storage+lock HTTP, feedback GitHub, pannelli SVG/DXF e snapshot publisher tutti verdi;
- `definizionedati.json`, Library Desktop e frontend operativo non sono stati modificati;
- **livello non ancora verificato:** il redeploy Render e la prova visiva sul browser pubblico dopo il nuovo commit; non vengono dichiarati verificati dal solo Action.

### INCARICO 2026-09-23 — debug Action sul progetto copiato dagli appunti
Stato: ESEGUITO

Commissionato:
- usare il `TERMODEL-PROJECT-TEXT-V1` reale copiato dal frontend e fornito dall'utente;
- eseguire il Service realmente in GitHub Actions, senza Render;
- raccogliere risposta HTTP, `generated-files`, artifact, workspace e log;
- esaminare i file di ritorno e isolare le anomalie;
- usare un branch diagnostico separato e non modificare `definizionedati.json`, Library Desktop o frontend operativo durante la diagnosi.

Risultato:
- branch diagnostico: `ai-debug-action-20260923`;
- input utente verificato tramite SHA-256: `geometry/project.svg = bda76910a15d4206f018d733d621f427ffb269c3fa4526f89bc0e3a23f17dd06`;
- tutte le sezioni tecniche diverse da `geometry/project.svg` coincidono con il fixture versionato `SorgentiTermodel/Library/projects/ProgettoVuoto/ProgettoVuoto.termodel.txt`;
- run diagnostico #236 / id `35905600774`: build ed esecuzione riuscite; inviando direttamente il progetto copiato, `POST /api/model/3d` e `POST /api/calculations` restituiscono HTTP 422 perché lo SVG locale non dichiara `data-termodel-units="cm"`;
- chiarito che il comando Help copia correttamente il progetto locale completo, mentre il percorso normale `Aggiorna Modello` applica prima `buildTermodelServerPayload()`; pertanto un futuro bridge clipboard -> Action deve eseguire la stessa canonicalizzazione prima di chiamare il Service;
- run diagnostico #241 / id `35906187985`: payload canonico equivalente al frontend, `/api/model/3d = 200`, `/api/calculations = 200`, `generated-files = 200`;
- artifact reali raccolti: `artifacts/model3d.json` (31.939 byte), `artifacts/pannelli.json` (932 byte), `logs/TermodelLog.md`, `logs/diagnostics.txt`, `logs/calculation.log`, progetto materializzato e stdout/stderr Service;
- `model3d.json`: 36 primitive = 2 Soffitto + 2 Pavimento + 8 Parete + 24 Ponte; i 24 mesh Ponte corrispondono a 12 ponti termici automatici, ciascuno esportato come lati+tappi;
- bounding box complessivo delle primitive: X 1,8276..6,65768 m, Y 1,59438..5,37853 m, Z -0,1..3,89 m; nessun vertice fuori scala o oggetto remoto è presente nell'artifact Service;
- il rettangolo edilizio derivato dalle quattro linee utente misura circa 4,57008 x 3,52415 m, coerente con le coordinate SVG; il file di ritorno non spiega quindi da solo una visualizzazione del modello molto piccola;
- i ponti automatici sono coerenti con gli archivi del progetto base: la parete `Parete esterna isolata` usa il gruppo `PontiAutomatici= Parete`;
- individuata una perdita del Nord nel trasporto frontend -> Service: il progetto locale contiene l'accessorio `NORD` con orientamento 71°, ma la canonicalizzazione corrente conserva solo linee e blocchi tecnici di piano; il contratto prescrive invece di non eliminare i simboli tecnici;
- il Core storico rileva il Nord come blocco CAD `NORD` e calcola `DirezNord = (Insert.Rotation + 90) % 360`;
- run diagnostico #243 / id `35906729046`: traduzione temporanea del Nord 71° nel blocco tecnico `NORD` con rotation 341°; build completa e job standard GitHub Actions entrambi SUCCESS; `/api/model/3d = 200`, `/api/calculations = 200`, `generated-files = 200`; l'errore `Il simbolo NORD non è stato trovato` scompare;
- il `model3d.json` del run #243 è identico al run #241 ignorando solo `generatedAtUtc`: il Nord mancante è quindi un difetto reale del contratto/adapter di trasporto, ma non genera le primitive aggiuntive e non altera la scala geometrica del modello;
- resta un messaggio stdout `Errore: Il valore 'Solaio piano' non è un numero intero valido per il colore della copertura.`; non interrompe il calcolo e il codice identico è presente sia nella Library Desktop sia nella copia Core: `Solaio piano` ricade nel valore storico `ColoreCopertura=0`. È una diagnostica fuorviante da correggere eventualmente nel sorgente condiviso, non una causa del fallimento corrente;
- `pannelli.json`: una rete standard, zero circuiti; diagnostica coerente con l'assenza di linee tubo CAD;
- nessuna correzione di prodotto applicata durante questo incarico: sono stati isolati i punti di intervento e verificati con Action reali;
- commit diagnostici principali sul branch:
  `cc03138bb75c13592b34e0a71edeb96aba1f7003`,
  `6b7b8682dd8918c5aff1d1af2e33e29bed02f519`,
  `fb719fbdf648984e22176beb73d88adf2d85f9b8`.

### INCARICO 2026-09-23 — collaudo generico protocollo "Debug avanzato"
Stato: ESEGUITO

Commissionato:
- verificare la fattibilità pratica del protocollo permanente di debug avanzato senza inseguire alcun bug applicativo specifico;
- eseguire il collaudo su branch diagnostico separato;
- far compilare e avviare realmente Termodel.WebService in GitHub Actions;
- eseguire soltanto sonde innocue (/health e /api/model/capabilities);
- produrre un artifact diagnostico di ritorno contenente risposta delle sonde e log stdout/stderr del Service;
- leggere e analizzare l'artifact dalla chat;
- rimuovere dal branch la strumentazione temporanea a collaudo concluso;
- non modificare Core, runtime WebService, frontend, definizionedati.json o Library Desktop.

Risultato:
- branch diagnostico usato: ai-debug-protocol-test-20260923;
- workflow temporaneo: .github/workflows/advanced-debug-protocol-test.yml;
- commit diagnostico: 4d2c4477400461185432221e1ab7f2f80460f998;
- GitHub Actions run #1, run id 35906599732: COMPLETATO CON SUCCESSO;
- restore: success;
- build Release: success;
- avvio reale di Termodel.WebService nel runner Windows: success;
- sonda GET /health: HTTP 200, risposta status=ok;
- sonda GET /api/model/capabilities: HTTP 200;
- capabilities osservate: Termodel Core 0.3.0-experimental, updateModelAvailable=true, newProjectAvailable=true, formato TERMODEL-PROJECT-TEXT-V1 disponibile;
- artifact advanced-debug-protocol-return creato e scaricato dalla chat;
- contenuto artifact verificato:
  - probe.json (537 byte);
  - service.stdout.log (2583 byte);
  - service.stderr.log (0 byte);
- stdout conferma ascolto su http://127.0.0.1:5082 e richieste HTTP 200;
- stderr vuoto;
- dimostrato end-to-end il canale:
  chat -> branch diagnostico -> GitHub Action -> build -> avvio Service -> richiesta HTTP -> artifact/log -> download -> analisi chat;
- nessun bug applicativo specifico è stato investigato durante questo collaudo;
- nessuna modifica a Core, runtime WebService, frontend, definizionedati.json o Library Desktop;
- la strumentazione temporanea viene rimossa dal branch al termine del collaudo.

### INCARICO 2026-09-23 — contratto permanente "Debug avanzato"
Stato: ESEGUITO

Commissionato:
- registrare una procedura permanente per la risoluzione dei problemi complessi del TermodelService tramite GitHub Actions;
- se la natura del problema non è già nota, chiedere prima all'utente quale anomalia deve essere riprodotta;
- chiedere il progetto reale necessario alla riproduzione quando non è già disponibile;
- avviare il ciclo di test sul Service in GitHub Actions, preferibilmente su branch diagnostico separato quando servono modifiche temporanee;
- quando necessario, inserire log/strumentazione diagnostica speciale esclusivamente per il problema corrente;
- raccogliere e analizzare output, log, artifact e file di ritorno dell'Action;
- ripetere autonomamente il ciclo modifica temporanea -> Action -> analisi fino alla risoluzione del problema o fino a quando emerga un impedimento concreto che renda impossibile proseguire;
- al termine rimuovere log e strumentazione temporanei non destinati al prodotto;
- lasciare nel codice solo le correzioni realmente necessarie e documentare separatamente progettato, implementato, compilato, eseguito e testato;
- non modificare `definizionedati.json`, Library Desktop o frontend salvo che il problema richieda esplicitamente tali componenti.

Risultato:
- creata la specifica permanente
  `Server/Termodelwebservice/docs/ADVANCED-GITHUB-ACTIONS-DEBUG.md`;
- aggiunta alle regole iniziali del Summary la regola permanente n. 13;
- formalizzato il ciclo:
  `problema -> progetto -> strumentazione -> GitHub Action -> file di ritorno -> analisi -> correzione -> nuova Action`;
- formalizzato l'uso di branch diagnostici separati per script/log/fixture temporanei;
- formalizzato che i log speciali possono essere aggiunti durante il debug ma devono essere rimossi alla chiusura, salvo promozione esplicita a diagnostica permanente;
- formalizzato che il ciclo continua fino a soluzione verificata oppure a impedimento concreto documentato;
- nessuna modifica a Core, WebService runtime, frontend, `definizionedati.json` o Library Desktop;
- **compilazione:** non richiesta, modifica esclusivamente documentale;
- **esecuzione/test:** non richiesti per la registrazione della procedura;
- commit:
  `7eecab0f95b3e26bd5def072a6ac8bfdc9f50c74` (commissione),
  `34df28d14a35374cdb041867fa301187d173d736` (specifica operativa).

### INCARICO 2026-09-23 — comando Help "Copia progetto negli appunti"
Stato: ESEGUITO

Commissionato:
- aggiungere nel menu `Help` del frontend operativo
  `docs/termodel-ui-demo/` il comando:
  `Copia progetto negli appunti`;
- il comando deve copiare negli appunti il progetto tecnico corrente nel
  formato canonico `TERMODEL-PROJECT-TEXT-V1`, riusando la funzione di
  serializzazione già esistente nel frontend e senza introdurre un formato
  parallelo;
- il comando deve servire al flusso di test rapido:
  `frontend -> clipboard -> chat AI -> GitHub Action/Service temporaneo`;
- non deve modificare il progetto, non deve chiamare Render e non deve
  pubblicare snapshot;
- deve mostrare un riscontro chiaro di successo/errore all'utente;
- non inserire secret o credenziali negli appunti;
- non modificare `definizionedati.json`, Core, WebService o Library Desktop.

Risultato:
- frontend portato a **v1.06**;
- aggiunta nel menu `Help` la voce
  `Copia progetto negli appunti`, disabilitata quando non esiste un progetto
  strutturato aperto;
- il comando richiama `buildCurrentProjectText()`, quindi usa la stessa
  serializzazione canonica già usata da salvataggio/calcolo e copia il
  `TERMODEL-PROJECT-TEXT-V1` completo corrente;
- nessuna chiamata a Render e nessuna pubblicazione snapshot vengono eseguite;
- introdotto un helper clipboard comune riusato anche dalla diagnostica
  Service, con fallback `document.execCommand('copy')`;
- feedback utente:
  `✓ Progetto TERMODEL-PROJECT-TEXT-V1 copiato negli appunti.`;
- aggiunto help contestuale del nuovo comando;
- **controllo sintattico JavaScript:** ESEGUITO con parser V8 sul contenuto
  corrente di `app.js` (rimosso soltanto il blocco import per il parse):
  ```text
  APP_JS_SYNTAX_OK
  HELP_COPY_PROJECT_STATIC_OK
  ```;
- **esecuzione browser reale:** NON ancora verificata manualmente;
- nessuna modifica a `definizionedati.json`, Core, WebService,
  `SorgentiTermodel/Library/` o `PROJECT-SUMMARY.md` Web JS;
- commit:
  `e73c6acce2ba1e538a44fed4ddf9593f68a68444` (commissione),
  `f32f078053d85d56595ed913ec092805c6a2b618` (menu/versione),
  `2c08c89a10e3a4a1940d288ab2af2caa0ef965bc` (logica clipboard).

### INCARICO 2026-09-23 — procedura permanente snapshot per diagnostica AI
Stato: ESEGUITO

Decisione:
- la procedura `Aggiorna Modello -> pubblica snapshot -> esamina l'ultimo snapshot`
  diventa una **procedura operativa fondamentale e permanente** del progetto;
- qualsiasi nuova chat Service deve conoscere il meccanismo prima di chiedere
  all'utente copie manuali di SVG, DXF, JSON, report o log già prodotti dal
  Service;
- quando serve analizzare una sessione reale Render, la chat deve cercare sul
  branch `service-snapshots` il file
  `service-snapshots/LATEST.json`, quindi leggere il relativo
  `manifest.json` e gli artifact/log dello snapshot;
- lo snapshot viene creato **solo su richiesta**, non ad ogni
  `Aggiorna Modello`;
- istruzione utente corrente:
  1. eseguire `Aggiorna Modello`;
  2. pubblicare la sessione con
     `POST /api/projects/{projectId}/publish-session-snapshot`;
  3. dire alla chat `esamina l'ultimo snapshot`;
- fino a quando non esisterà un comando locale/pulsante sicuro che automatizzi
  il punto 2, l'utente usa PowerShell con la propria
  `TERMODEL_SNAPSHOT_ADMIN_KEY`; la chiave e il token GitHub non devono
  essere incollati in chat;
- la chat deve distinguere chiaramente lo snapshot da GitHub dal workspace
  effimero Render: GitHub è la copia diagnostica persistente;
- gli snapshot non vengono puliti automaticamente allo stato attuale;
  `LATEST.json` indica soltanto l'ultimo. Una futura policy di retention
  dovrà essere deliberata prima di cancellare snapshot storici;
- registrare questa procedura nel Summary Service, nel contratto
  Front↔Service, nel README Service e nella nota frontend sul WebService;
- non modificare il `PROJECT-SUMMARY.md` Web JS alla radice.

Risultato:
- creata la specifica operativa autorevole:
  ```text
  Server/Termodelwebservice/docs/SERVICE-SNAPSHOT-DIAGNOSTIC.md
  ```
  con istruzioni separate per utente e nuova chat AI;
- aggiunta alle regole iniziali di questo Summary la regola permanente n. 12:
  una chat deve tentare prima la lettura dello snapshot GitHub e non chiedere
  copie manuali di file già disponibili;
- contratto Front↔Service aggiornato alla **v1.15** con la procedura normativa
  Render → GitHub → AI;
- README Service aggiornato con la sequenza pratica:
  ```text
  Aggiorna Modello
  -> Pubblica snapshot
  -> "esamina l'ultimo snapshot"
  ```
- aggiornata anche
  `docs/termodel-ui-demo/info_termodelwebservice.md`, così una chat/frontend
  developer conosce il meccanismo e sa che la chiave amministrativa non deve
  essere inserita nel JavaScript;
- documentato che:
  - la pubblicazione snapshot è manuale/on-demand;
  - Render Free è effimero;
  - GitHub è la copia diagnostica persistente;
  - `LATEST.json` individua automaticamente l'ultima sessione;
  - non esiste ancora retention/pulizia automatica;
  - token GitHub e admin key non devono essere incollati in chat;
- aggiornato anche lo stato storico della funzione snapshot: la pubblicazione
  reale Render → GitHub è stata **verificata** sul progetto
  `b38f622b-6411-48ea-ba57-0b07862f4046`, snapshot
  `20260923T162958425Z_b38f622b`;
- nessuna modifica funzionale a Core, WebService o frontend;
- nessuna modifica a `PROJECT-SUMMARY.md` della linea Web JS;
- commit:
  `8ebc751d900ffea2a650df05e52b170c69ef3471`,
  `ca726b10b8809eaad0cd09ebfea8b6e488908e62`,
  `3312435bb12ff6eb25f5f67282ce63f965213cc8`,
  `6f2af534a9820ced47fd5f71a894686616e4c14b`,
  `f4615154b2e15f9aea5159a5df3d8d61a481810e`.

### INCARICO 2026-09-23 — pubblicazione snapshot diagnostico Service → GitHub
Stato: ESEGUITO

Commissionato:
- aggiungere un servizio amministrativo che, **solo su richiesta esplicita**,
  pubblichi su GitHub uno snapshot diagnostico dell'ultima elaborazione valida
  del progetto;
- riusare il catalogo universale `generated-files` come sorgente dei file
  pubblicabili, senza accesso arbitrario al filesystem;
- pubblicare per default soltanto `artifacts/**` e `logs/**`;
- non pubblicare `project.tmdl`, credenziali, configurazioni server o altri
  file interni;
- usare un token GitHub distinto dal token feedback:
  `TERMODEL_SNAPSHOT_GITHUB_TOKEN`;
- proteggere l'endpoint con una chiave amministrativa separata:
  `TERMODEL_SNAPSHOT_ADMIN_KEY`, inviata tramite header
  `X-Termodel-Snapshot-Key`;
- usare per default il repository `Fetonte1960/Termodel` e un branch
  dedicato `service-snapshots`, configurabili via environment;
- creare per ogni pubblicazione una cartella autonoma sotto
  `service-snapshots/<snapshotId>/`;
- includere un `manifest.json` con projectId, timestamp UTC, commit Service
  quando disponibile, elenco file, dimensioni, content type e SHA-256;
- creare **un solo commit GitHub atomico** per snapshot tramite Git Data API;
- aggiungere endpoint:
  `POST /api/projects/{projectId}/publish-session-snapshot`;
- aggiungere smoke test con stub GitHub API che verifichi autenticazione,
  branch/commit/tree/blob, esclusione di `project.tmdl` e manifest;
- documentare la configurazione Render necessaria;
- non modificare `definizionedati.json`, protocollo progetto o Library
  Desktop.

Risultato:
- aggiunto
  `src/Termodel.WebService/Snapshots/GitHubSnapshotPublisher.cs`;
- introdotte opzioni server separate:
  ```text
  TERMODEL_SNAPSHOT_GITHUB_TOKEN
  TERMODEL_SNAPSHOT_ADMIN_KEY
  TERMODEL_SNAPSHOT_REPOSITORY=Fetonte1960/Termodel
  TERMODEL_SNAPSHOT_BRANCH=service-snapshots
  TERMODEL_SNAPSHOT_BASE_BRANCH=main
  TERMODEL_SNAPSHOT_GITHUB_API_BASE_URL=https://api.github.com
  TERMODEL_SNAPSHOT_ROOT=service-snapshots
  ```
- il token snapshot è volutamente distinto da
  `TERMODEL_FEEDBACK_GITHUB_TOKEN`; il primo richiede
  `Contents: read/write`, mentre il feedback può restare limitato alle
  Issues;
- aggiunto endpoint amministrativo:
  ```http
  POST /api/projects/{projectId}/publish-session-snapshot
  X-Termodel-Snapshot-Key: <secret>
  ```
- endpoint non configurato -> HTTP 503;
- chiave amministrativa errata -> HTTP 403;
- progetto inesistente -> HTTP 404;
- workspace senza file generati -> HTTP 409;
- `ProjectStore.ReadGeneratedFilesSnapshotAsync` legge atomicamente,
  sotto lo stesso gate progetto, esclusivamente i file di
  `artifacts/**` e `logs/**`;
- limite corrente per sicurezza:
  - 20 MiB per singolo file;
  - 50 MiB complessivi per snapshot;
- pubblicazione GitHub realizzata con Git Data API:
  1. verifica/creazione branch `service-snapshots`;
  2. creazione blob;
  3. creazione tree con base tree del branch;
  4. creazione commit;
  5. aggiornamento non-forzato della ref;
  quindi ogni snapshot corrisponde a **un solo commit atomico**;
- ogni snapshot viene scritto sotto:
  ```text
  service-snapshots/LATEST.json
  service-snapshots/<timestamp>_<project-prefix>/
    manifest.json
    artifacts/...
    logs/...
  ```
- `LATEST.json` usa il formato
  `TERMODEL-SERVICE-SNAPSHOT-LATEST-V1` e punta sempre allo snapshot più
  recente; una chat successiva può quindi leggere direttamente
  `service-snapshots/LATEST.json` sul branch `service-snapshots` senza
  conoscere prima lo snapshotId;
- `manifest.json` usa il formato
  `TERMODEL-SERVICE-SNAPSHOT-V1` e registra:
  projectId, timestamp UTC, eventuale commit Service
  (`RENDER_GIT_COMMIT`/`GITHUB_SHA`/`SOURCE_VERSION`), stale,
  content type, dimensione, data file e SHA-256;
- `project.tmdl` non è incluso e il publisher rifiuta qualsiasi path non
  appartenente ad `artifacts/` o `logs/`;
- aggiunti:
  `tests/github_snapshot_stub.py` e
  `tools/smoke-github-snapshot.ps1`;
- lo smoke verifica:
  - 503 senza configurazione;
  - 403 con chiave errata;
  - 201 con configurazione valida;
  - header Bearer e User-Agent verso GitHub;
  - creazione branch, blob, tree, commit e update ref non forzato;
  - quattro file generati + manifest;
  - esclusione reale di un `project.tmdl` presente nel workspace;
  - manifest con SHA-256 validi;
- **compilato/eseguito/testato:** SI — GitHub Actions
  `TermodelService Build` run **#219**
  (run id `35884001322`) completato con **success**;
- marker verificato:
  ```text
  GITHUB_SESSION_SNAPSHOT_SMOKE_OK
  ```
  insieme agli smoke preesistenti project/lock, feedback ed esecutivo
  pannelli;
- README Service aggiornato con endpoint, formato snapshot e configurazione
  Render;
- **GitHub reale da Render:** SI — i due secret sono stati configurati su
  Render e il 23/09/2026 è stata eseguita una pubblicazione reale del progetto
  `b38f622b-6411-48ea-ba57-0b07862f4046`; lo snapshot
  `20260923T162958425Z_b38f622b` è stato letto successivamente dalla chat
  tramite `service-snapshots/LATEST.json` e `manifest.json`;
- non sono stati modificati `definizionedati.json`,
  `TERMODEL-PROJECT-TEXT-V1` o la Library Desktop;
- commit principali:
  `ea602424cecaf6af075c4a46ff7dc273c85e2a68`,
  `53c5b822aeabf16d9bbb7bb8770b325065d115b6`,
  `6ccb94de5553a53e301f597ba9bb8e7d0601ca44`,
  `c7c39917e8062a96ffa01d3b955681c53ed33b1d`,
  `4456c69817332d83fc211cbff9d0260e65e5fbfa`,
  `6809503da66566b53a8ddd4d0020fa0f22f17add`,
  `2b07cba1cae7ecad3992e8dbe38dd12b195df432`,
  `d3f8586af2aed9d8f391ea50ab1d11d3625dda3f`,
  `4f18e69fa6ee98c990d68d59eecf7b51bd0788c0`,
  `00cd332adb89c794a3cdea065388cb4c50e753aa`,
  `a4c75c5b9b83c790fbf869f7ef349bb1c3c046ca`,
  `2d4d1c53258997cd3f669938ff02f31077996517`.

### INCARICO 2026-09-23 — canale universale file generati + test SVG spirali al frontend
Stato: ESEGUITO

Commissionato:
- verificare end-to-end il disegno esecutivo spirali SVG già prodotto dal
  Service e renderlo realmente raggiungibile dal frontend;
- verificare se esiste già un servizio universale per trasmettere file
  generati (disegni, report, JSON, CSV, PDF, DXF, SVG, log); se manca,
  introdurre un canale generico **read-only** e sicuro;
- il canale universale deve pubblicare soltanto file generati autorizzati
  del workspace progetto, senza esporre `project.tmdl`, file arbitrari o
  path traversal;
- aggiungere un catalogo/manifest dei file generati con nome, percorso
  logico, categoria, content type, dimensione, stale e href;
- aggiungere un endpoint generico di lettura che rispetti content type e
  disposizione inline/attachment;
- mantenere gli endpoint specifici esistenti per retrocompatibilità;
- collegare il frontend operativo `docs/termodel-ui-demo` al catalogo
  generico e aggiungere un comando per caricare l'esecutivo pannelli SVG
  come **sfondo/overlay di riferimento del CAD2D**, senza alterare la
  geometria tecnica del progetto;
- lo sfondo esecutivo deve poter essere rimosso/ripristinato senza
  modificare `TERMODEL-PROJECT-TEXT-V1`;
- aggiungere smoke automatico del catalogo, del GET generico e del contenuto
  SVG spirali;
- aggiornare contratto Front↔Service, README e Summary;
- non modificare `definizionedati.json` né la Library Desktop.

Risultato:
- non esisteva un canale universale: erano presenti soltanto endpoint
  specifici per `model3d`, `pannelli`, esecutivo SVG/DXF e TermodelLog;
- implementato in `ProjectStore` il catalogo read-only ricorsivo dei soli
  alberi:
  ```text
  artifacts/**
  logs/**
  ```
  con normalizzazione del path e rifiuto di traversal/file esterni;
- introdotto il contratto:
  ```text
  TERMODEL-GENERATED-FILES-V1
  ```
- nuovi endpoint:
  ```http
  GET /api/projects/{projectId}/generated-files
  GET /api/projects/{projectId}/generated-files/{relativePath}
  ```
- ogni record del catalogo espone:
  `path`, `fileName`, `category`, `contentType`, `size`,
  `lastWriteTimeUtc`, `inline`, `stale`, `href`;
- il GET generico riconosce già JSON, SVG, DXF, PDF, CSV, TXT, Markdown,
  XML, immagini e ZIP; mantiene `X-Termodel-Artifact-Stale`, usa
  `X-Content-Type-Options: nosniff` e sandbox CSP per SVG/HTML;
- `project.tmdl` non è pubblicabile tramite questo canale;
- `POST /api/calculations` espone anche `generatedFilesHref`;
- gli endpoint specifici esistenti sono rimasti invariati per
  retrocompatibilità;
- l'SVG esecutivo pannelli dichiara ora metadata metrici:
  ```text
  data-coordinate-unit="m"
  data-termodel-max-y="..."
  data-termodel-min-y="..."
  ```
  per consentire al CAD2D di riallineare correttamente le coordinate;
- frontend portato a **v1.05**;
- nel menu CAD2D `Sfondo` sono stati aggiunti:
  ```text
  ↻ Esecutivo pannelli SVG
  Mostra esecutivo calcolato
  ```
- il frontend recupera il catalogo universale, individua
  `artifacts/pannelli-esecutivo.svg` e lo legge tramite il relativo
  `href`;
- l'esecutivo viene visualizzato in un layer runtime separato
  `cadGeneratedExecutiveLayer`, filtrato per `data-piano`, convertendo
  metri→centimetri e annullando la sola inversione Y del writer SVG;
- l'overlay non entra in `cadWorkingDoc`, non modifica
  `TERMODEL-PROJECT-TEXT-V1`, non entra in Undo/Redo e non viene reinviato
  al Service;
- lo stesso overlay può essere mostrato/nascosto indipendentemente dagli
  sfondi importati tradizionali;
- **test SVG spirali reale:** lo smoke crea un locale sintetico 4×4 m con
  ingresso Tubo e verifica nell'SVG:
  - formato `TERMODEL-PANNELLI-ESECUTIVO-SVG-V1`;
  - metadata metrici;
  - layer edificio/mandata/ritorno;
  - presenza effettiva di geometria mandata e ritorno;
  - bounding box dell'edificio 0..4 m × 0..4 m;
  - equivalenza del numero di primitive tecniche SVG/DXF;
- **test canale universale:** lo smoke verifica catalogo, content type di
  SVG/DXF/JSON/Markdown, GET dell'SVG tramite `href`, stale=false e
  rifiuto di `project.tmdl`;
- marker automatici verificati:
  ```text
  GENERATED_FILES_CHANNEL_SMOKE_OK
  RADIANT_EXECUTIVE_SVG_GEOMETRY_SMOKE_OK
  RADIANT_EXECUTIVE_SVG_DXF_SMOKE_OK
  ```
- **compilato/eseguito/testato:** SI — GitHub Actions
  `TermodelService Build` run **#206** (run id `35881202382`) completato
  con successo, inclusi build Release, smoke project/lock, feedback e smoke
  esecutivo;
- **frontend verificato staticamente:** `APP_JS_SYNTAX_OK` e
  `GENERATED_EXECUTIVE_FRONT_STATIC_OK`;
- **frontend pubblicato:** GitHub Pages run **#834**
  (run id `35881201564`) completato con **success**;
- contratto Front↔Service aggiornato alla **v1.14**;
- README Service aggiornato con il canale universale;
- non sono stati modificati `definizionedati.json`,
  `TERMODEL-PROJECT-TEXT-V1` o la Library Desktop;
- prova browser manuale del nuovo pulsante CAD non ancora eseguita
  dall'utente: build, deploy e percorso HTTP/geometry sono verificati, ma
  l'interazione visuale finale nel browser resta da confermare sul front
  pubblico;
- commit principali:
  `15ccc03845bcc27e86ad65a393defc3211114cad`,
  `39be9e54e17e4593fd3c970ce859e08007246ae7`,
  `8b84672234453a1fa1344472b7700393585fe6ac`,
  `5e91b257c26a8bf80931013e86f9e23d43ac4b46`,
  `6bbaa3a7081adef0335d3a3c7740d34a6c05392e`,
  `7bbea9dcc8b5cb0ea4abf380588202baf3572b16`,
  `bf5d65915c1659748485bd92a5881424aa0b5231`,
  `2337aaef7264eef941bd1cf817d27b2934d9276b`,
  `095ab077b6727323f86ead5da194372cf08d4e58`.

### INCARICO 2026-09-23 — attivazione esecutivo pannelli SVG/DXF
Stato: ESEGUITO

Commissionato:
- attivare il disegno esecutivo pannelli usando i **default attuali** già
  consolidati nel ramo Desktop/pannelli;
- produrre nel Service sia l'esecutivo DXF sia un esecutivo SVG
  **graficamente equivalente al DXF OUT**;
- DXF e SVG devono derivare dallo **stesso modello grafico esecutivo** nel
  Core: non creare due algoritmi di disegno indipendenti;
- consultare e riusare come riferimento funzionale
  `SorgentiTermodel/Library/Impianti/Pannelli/IoPannelli.cs` e
  `IoTubi.cs`, in particolare `EsecutivoPannelli`;
- mantenere fuori scope il grafo universale, il percorso sfavorito,
  l'equilibratura e le perdite concentrate, già rimandati alla fase
  **Tubi universale**;
- per questa milestone è ammesso il comportamento grafico con i default
  correnti; non rendere ancora parametrico il motore spirali se ciò
  richiederebbe duplicazione o modifica della Library Desktop;
- persistire gli artifact esecutivi nello stesso
  `SavedProjects/{projectId}/artifacts/` dell'ultima elaborazione valida e
  renderli leggibili senza nuovo calcolo;
- aggiornare il manifest artifact di `POST /api/calculations`, gli endpoint
  GET, il contratto Front↔Service e la documentazione;
- aggiungere smoke automatico che verifichi presenza e coerenza strutturale
  DXF/SVG;
- non modificare `definizionedati.json`, `TERMODEL-PROJECT-TEXT-V1` o
  la Library Desktop.

Risultato:
- implementato `RadiantExecutiveGenerator` nel Core;
- il motore grafico usa il `SpiraliGPT` Desktop corrente con default
  `PassoTubi=0,30 m`, coerente con `RAD-DEFAULT`;
- i cinque sorgenti `SpiraliGPT` necessari sono copie temporanee
  byte-identical della Library e sono tracciati in
  `Termodel.Core/CopiedFromTermodel/TERMODEL-SYNC.md`;
- DXF e SVG derivano dallo stesso modello neutro
  `RadiantExecutiveDrawing`;
- artifact persistiti:
  ```text
  artifacts/pannelli-esecutivo.svg
  artifacts/pannelli-esecutivo.dxf
  ```
- endpoint disponibili senza ricalcolo:
  ```http
  GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-svg
  GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-dxf
  ```
- contenuto equivalente verificato per i layer:
  `<Piano>_Edificio_Output`,
  `<Piano>_PannelliMandata_Output`,
  `<Piano>_PannelliRitorno_Output`,
  `<Piano>_NumeriCircuiti_Output` quando presente;
- il grafo/collettore resta intenzionalmente fuori scope e rimandato a
  **Tubi universale**;
- contratto Front↔Service aggiornato alla **v1.13**;
- README e registro Tubazioni aggiornati;
- **compilato:** SI — GitHub Actions `TermodelService Build` run **#195**
  (run id `35878924866`), Build completata con successo;
- **eseguito/testato:** SI — smoke dedicato
  `RADIANT_EXECUTIVE_SVG_DXF_SMOKE_OK`, locale sintetico 4×4 m con
  ingresso Tubo, persistenza di entrambi gli artifact, GET senza ricalcolo
  con `X-Termodel-Artifact-Stale=false` e uguaglianza del numero di
  primitive tecniche fra SVG e DXF;
- **confrontato con riferimento:** SI per il comportamento grafico
  `IoPannelli.EsecutivoPannelli` nel perimetro supportato dalla milestone;
  non viene dichiarata equivalenza per il futuro grafo universale;
- commit principali:
  `41998b8c63a7c06b10818320ab9e5323ca3c3746`,
  `2e2b711f733f925aa5c04f8b6b4516575259d68a`,
  `f346ded263dffef95e7c9588379573643c218efc`,
  `51c0ca3cc288d00284983b08990424a1d1dc64de`,
  `b9ac3c2ed83a2b8c35adc6c4e1b6bb40da1df38c`,
  `502da9f5cf63264c7ab39fe4373f771ea4fe5d25`,
  `a412bd5d5cdd79e28e9e8c18fd8eea2c024ea9fe`,
  `0b5472e538b962311d791c452bf9df964ec521e6`,
  `d30493eb28e76afb6357afe92dfe567003cdbbb5`,
  `c9a584d6254493552672b19e24b1fb400500639a`,
  `5680af2d093e604509e01820d1edffc80aadd57b`,
  `ca9f6c39a1b4bd755dc42e8d6eca79c32797349a`,
  `4cb2349ebaf0d102875c521b305af05aa55f9d48`,
  `10e87f688cc0a3f0d0b4009e44a3a6df24c780ea`,
  `bc6c2cc5b3966c5acaf820def1aa450a9bda3c23`,
  `8f929a1709677cff126c45f3c220185a2313e68c`.

### INCARICO 2026-09-23 — rinvio grafo alla fase Tubi universale
Stato: ESEGUITO

Decisione:
- il grafo generale della rete, il riconoscimento/scomposizione
  collettore→rami→terminali e il relativo percorso sfavorito vengono
  **rimandati alla futura fase Tubi universale**;
- questa fase PannelliRadianti non deve essere bloccata dall'assenza del
  grafo universale;
- per il ramo pannelli corrente è sufficiente il **calcolo delle perdite di
  carico per singolo circuito**, usando la geometria del circuito già
  identificato e i dati di `Reti`/`TipologiePannelli`;
- non introdurre adesso una seconda implementazione del grafo specifica dei
  pannelli che poi dovrebbe essere sostituita dal motore Tubi universale;
- mantenere il kernel Darcy già implementato come componente riusabile della
  futura fase Tubi universale;
- aggiornare Summary, registro Calcolo Tubazioni e contratto Front↔Service
  per evitare che il grafo venga indicato come requisito pendente della fase
  pannelli attuale.

Risultato:
- decisione registrata nel
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`;
- roadmap T2/T4 e le parti di T3/T5 relative a grafo, sizing, percorso
  sfavorito ed equilibratura sono state classificate come lavoro futuro della
  fase **Tubi universale**;
- il perimetro della fase pannelli corrente termina al calcolo della perdita
  distribuita del singolo circuito già identificato;
- convenzione operativa fino al grafo universale:
  ```text
  un circuito = una componente geometrica connessa indipendente
  ```
- circuiti diversi non devono quindi condividere un nodo geometrico comune
  nel disegno destinato al calcolo corrente; se condividono un punto vengono
  riconosciuti come un unico componente ramificato e diagnosticati, senza
  scomposizione automatica;
- il collettore topologico non viene introdotto in questa fase e sarà
  responsabilità del modulo Tubi universale;
- contratto Front↔Service aggiornato alla **v1.12** con questo confine
  funzionale;
- nessuna modifica al codice di calcolo, al frontend operativo, al protocollo
  `TERMODEL-PROJECT-TEXT-V1`, a `definizionedati.json` o alla Library
  Desktop;
- commit:
  `7d56df6d70df0b4daeb28bcb7fc77166891c7933`,
  `122977c9959e1d9aff389bec43db4ae636dbe798`,
  `74cc540fc71bb3cee400e8583ef94010a53ffa1f`.

### INCARICO 2026-09-23 — completamento ramo pannelli radianti Service
Stato: ESEGUITO

Commissionato:
- completare il passo successivo al trasporto CAD Tubo già verificato;
- riusare prima di tutto il comportamento Desktop documentato in
  `SorgentiTermodel/Library/Impianti/Pannelli/*`, evitando un motore
  pannelli parallelo nel WebService;
- collegare runtime gli archivi progetto `Reti` e
  `TipologiePannelli` al calcolo pannelli, eliminando per il ramo Web i
  default hard-coded quando gli archivi contengono i dati equivalenti;
- validare `PassoSelezionatoMm` rispetto a `PassiDisponibiliMm`;
- implementare nel Core un primo kernel idraulico puro Darcy-Weisbach per i
  circuiti radianti, con proprietà acqua derivate dalla temperatura media,
  fattore Darcy e diagnostica esplicita;
- usare la geometria Tubo già trasportata nel Virtual CAD e il grafo/DTO
  pannelli Desktop quando disponibili, senza inventare protocolli alternativi;
- produrre nel workspace projectId almeno un artifact dati pannelli JSON
  persistente e leggibile senza ricalcolo; aggiungere SVG spirali per piano
  soltanto se il percorso Desktop headless è realmente integrabile in questa
  milestone senza dipendenze UI;
- aggiungere endpoint GET degli artifact correnti mantenendo
  `POST /api/calculations` come unica elaborazione autorevole;
- aggiungere smoke automatici su progetto sintetico che verifichino:
  archivi -> solver -> artifact -> persistenza -> GET;
- non modificare `definizionedati.json`;
- non modificare la Library Desktop;
- aggiornare contratto Front↔Service, registro Tubazioni e questo Summary
  secondo lo stato reale;
- distinguere esplicitamente ciò che è progettato, implementato, compilato,
  eseguito e confrontato col riferimento Desktop.

Risultato:
- aggiunto in `Termodel.Core`
  `RadiantPanels/RadiantPanelCalculator.cs`;
- il solver legge **a runtime** gli archivi XML del file unico
  `Reti` e `TipologiePannelli`, seleziona le reti attive
  `TipoRete=PannelliRadianti`, risolve
  `CodiceTipologiaPannello` e usa passo, temperature, limiti,
  `KLayout`, diametro interno, rugosità e coefficiente resa;
- `PassoSelezionatoMm` viene realmente validato contro
  `PassiDisponibiliMm`; un passo 333 mm non ammesso produce HTTP 422 e
  non sostituisce l'ultimo artifact valido;
- `SvgDxfReader` conserva ora sulle linee del Virtual CAD un
  `SvgDxfLineMetadata` con id, piano, entità, rete e layer. Il normale
  layer/colore/linetype netDxf usato dal codice Desktop resta invariato;
- i segmenti `Tubo` della stessa rete/piano vengono raggruppati per
  connettività geometrica (tolleranza 1 mm) in circuiti; vengono rilevate e
  diagnosticate topologie aperte/chiuse/ramificate;
- implementato il primo kernel idraulico:
  densità e viscosità acqua dalla temperatura media, velocità, Reynolds,
  fattore Darcy `64/Re` in laminare, Colebrook in turbolento e transizione
  interpolata/diagnosticata 2300–4000;
- perdita distribuita:
  `DeltaP = f * (L/D) * rho*v²/2`, con output Pa/m, Pa e kPa;
- la resa preliminare mantiene la stessa relazione del Desktop
  `CalcoloPannelli.CalcolaPotenzaSpecifica`:
  `CoefficienteResaWm2K * (TmediaAcqua - Tambiente)`;
- finché il calcolo pannelli completo non fornisce una portata circuito
  autorevole, la prima versione ricava esplicitamente una **portata
  preliminare** da potenza, `cp=4180 J/(kg K)` e salto mandata/ritorno;
- per il CAD manuale la centerline Tubo è trattata come lunghezza idraulica
  effettiva. L'area servita è stimata inversamente dal fattore
  superficie/passo e `KLayout`; questa assunzione è dichiarata
  nell'artifact e non viene confusa con una spirale generata;
- i fattori passo implementati sono quelli registrati nella specifica:
  50→20; 100→10; 125→8; 150→6,7; 175→5,8; 200→5; 300→3,4 m/m²,
  con fallback `1000/passo_mm`;
- `POST /api/calculations` continua a essere l'unica elaborazione
  autorevole e pubblica anche:
  ```text
  SavedProjects/{projectId}/artifacts/pannelli.json
  ```
  formato `TermodelRadiantPanels v1`;
- aggiunto:
  ```http
  GET /api/projects/{projectId}/artifacts/pannelli
  ```
  che legge il JSON persistito senza rilanciare il calcolo e restituisce
  `X-Termodel-Artifact-Stale` coerente con lo stato progetto;
- la response di `POST /api/calculations` include ora gli artifact
  `model3d` e `pannelli`;
- le diagnostiche idrauliche restano dentro `pannelli.json`; il campo
  top-level `diagnostics` continua a rispettare esattamente
  `logEnabled/logCategories`, preservando il contratto TermodelLog;
- `logs/calculation.log` registra anche
  `radiantPanelCircuitCount`;
- test sintetico end-to-end: un `T001` di 1,000 m, rete
  `RAD-DEFAULT`, passo 300 mm, PE-Xa D interno 12 mm, acqua 35/30 °C
  produce, entro tolleranze definite:
  ```text
  portata derivata ~= 3,1826793 L/h
  Reynolds         ~= 123,4017
  perdita          ~= 1,313675 Pa
  ```
- lo smoke verifica anche rete/tipologia, passo, diametro, fattore 3,4,
  lunghezze 1 m, persistenza di `pannelli.json`, GET senza ricalcolo,
  validazione passo 333 -> 422 e conservazione dell'ultimo artifact valido;
- **compilato:** SI — GitHub Actions `TermodelService Build` run **#165**
  (run id `35871205144`), Build Release riuscita con **0 Error(s)**;
- **eseguito/testato:** SI — nello stesso run sono verdi
  `RADIANT_NETWORK_ARCHIVES_SMOKE_OK`,
  `RADIANT_INVALID_STEP_STATUS_422`,
  `RADIANT_PANEL_DARCY_SMOKE_OK`,
  `RADIANT_PIPE_FILE_UNIQUE_SMOKE_OK`,
  `TERMODEL_LOG_OPTIONS_SMOKE_OK`,
  `PROJECT_LOCK_SMOKE_OK` e `GITHUB_FEEDBACK_SMOKE_OK`;
- **confrontato con riferimento Desktop:** SI per convenzione layer Tubo,
  dati progetto precedentemente hard-coded e formula preliminare di resa;
  NO per equivalenza numerica completa del generatore spirali/collettori,
  che non è ancora nel Service;
- **stato storico di questa commissione:** il generatore grafico non era
  ancora integrato. Questa limitazione è stata successivamente superata dalla
  commissione “attivazione esecutivo pannelli SVG/DXF” per il solo default
  corrente `PassoTubi=0,30 m`; resta da rendere parametrico il motore
  condiviso per passi diversi da 300 mm;
- non sono ancora incluse perdita collettore, valvole, flussimetri, perdite
  concentrate, distribuzione primaria, sizing automatico o equilibratura;
  per decisione del 23/09/2026 questi aspetti, insieme al grafo generale e al
  percorso sfavorito, sono **fuori dal completamento pannelli corrente** e
  appartengono alla futura fase Tubi universale;
- contratto Front↔Service aggiornato allora alla **v1.11**; stato corrente del contratto dopo l'esecutivo: **v1.13**;
- registro
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`
  aggiornato alla milestone 15.3;
- `Server/Termodelwebservice/README.md` documenta il nuovo endpoint;
- `definizionedati.json`, `TERMODEL-PROJECT-TEXT-V1` e la Library
  Desktop non sono stati modificati;
- principali commit dell'incarico:
  `ea7be8d2a03e848d16e2c8ac5a26e8ebae05be04`,
  `1c1b4eae87fdb5a63669fd9ac8af2aa1e1a3d009`,
  `ccfeaf5d42d74f84cb07d3c1c63cfdf56b6b3e13`,
  `59bd736f7141430a8760e215fbe4769e748d76f2`,
  `f96091fe9cc3c62f38a6da184e542f788530276a`,
  `f6bf6ce3034f546064a5e22546049d38843a7b1a`,
  `cd90e16ede425dbc5945fd079e0d5852623cdb1c`,
  `e871fb4f742eb03c4ba51af654cace2115ba6c48`,
  `cf7f3efb636ed09601017c1cbc925651a413b92b`,
  `1c1486e817087aa849edd705263058868f212e6a`,
  `b7f1cab0c889a7673a8b0baa5072b15fef58f3fb`,
  `232c970088d88b64e9aa96c2c4ee44a076f79438`,
  `459e07f4a06a65c865a2b91c61595db5d8a39805`.

### INCARICO 2026-09-23 — entità Tubo in modalità Rete CAD 2D
Stato: ESEGUITO

Commissionato:
- in modalità `Rete` il CAD 2D deve esporre una sola entità disegnabile:
  `Tubo`;
- il comando `Tubo` deve usare una modalità di disegno sequenziale analoga
  alla parete: ogni segmento termina dove inizia il successivo e il comando
  resta attivo fino a interruzione;
- per `Tubo` resta disponibile la chiusura diretta `Chiudi` della
  sequenza multipla, mentre **non** deve essere disponibile
  `Chiudi ortogonale`; resta disponibile l'interruzione della sequenza e,
  se compatibile, la ripetizione dell'ultimo comando;
- la modalità `Edificio` deve conservare integralmente i comandi correnti;
- consultare il riferimento Desktop in
  `SorgentiTermodel/Library/leggidxf/LeggiDxf.cs` e
  `SorgentiTermodel/Library/Impianti/Pannelli/IoPannelli.cs`, oltre agli
  adattatori Virtual CAD del Core, per determinare la formattazione corretta
  delle linee tubo, il layer atteso e il percorso di ingresso al calcolo;
- le linee tubo devono essere incluse nello SVG tecnico
  `geometry/project.svg` del `TERMODEL-PROJECT-TEXT-V1` con metadati tali
  da permettere al Virtual CAD di ricostruire il layer DXF atteso dal codice
  Desktop, senza introdurre un formato parallelo;
- la rete selezionata nel combo `Reti` deve essere associata alle nuove
  entità tubo con metadato tecnico, mantenendo il piano corrente;
- preservare il supporto multipiano: una stessa rete può avere segmenti tubo
  su più piani;
- non modificare `definizionedati.json` né la Library Desktop;
- modificare Core/Virtual CAD soltanto se l'analisi dimostra che il formato
  frontend corretto non è già trasportabile dal lettore SVG corrente;
- aggiornare contratto Front↔Service se vengono formalizzati nuovi metadati
  tecnici nello SVG del file unico.

Risultato:
- frontend portato a **v1.04**;
- in `Modalità=Rete` il menu Disegna nasconde Parete E/W, Allinea,
  Finestra 1/2 punti, Ponte, Locale e Colmo: la sola entità nuova disponibile
  è **Tubo**;
- `Tubo` riusa il motore sequenziale della parete: il punto finale di un
  segmento diventa il punto iniziale del successivo; `Interrompi sequenza`
  resta disponibile;
- dopo almeno tre segmenti il menu contestuale permette `Chiudi` diretto;
  `Chiudi ortogonale` è nascosto e comunque rifiutato dalla routine quando
  la sequenza è di tipo pipe;
- il cambio di Rete o Modalità interrompe una sequenza in corso, evitando che
  una stessa multilinea venga accidentalmente divisa fra due reti;
- gli ID delle primitive sono `T001`, `T002`, ... e vengono calcolati
  sull'intero SVG per evitare collisioni;
- ogni Tubo conserva:
  ```text
  data-termodel-piano    = Piani.Nome
  data-termodel-layer    = <Piani.Nome>_tubipannelli
  data-termodel-entity   = Tubo
  data-termodel-rete     = Reti.Codice
  data-termodel-linetype = Continuous
  data-termodel-color    = 1
  stroke                 = #ff0000
  ```
- la convenzione è stata ricavata dal riferimento Desktop:
  `ScriptCad.TipoComandoEnum.Tubo` imposta layer `*_tubipannelli`,
  colore ACI 1 e `Continuous`; `IoPannelli.LeggiTubiDXF` cerca
  esattamente `<NomePiano>_tubipannelli`;
- il piano resta indipendente dalla rete: la stessa `Reti.Codice` può
  quindi avere Tubi su più `Piani.Nome`;
- `GeneraPianta.js` considera ora esclusivamente le linee E/W nella
  polygonizzazione architettonica, quindi le linee T non alterano locali,
  pareti o anteprima edificio;
- il comando `Rigenera pianta` diventa `Consolida rete` in modalità Rete:
  consolida lo SVG tecnico senza passarlo a GeneraPianta locale;
- il normale `buildTermodelProjectText/buildTermodelServerPayload` conserva
  le linee Tubo nel `geometry/project.svg` del file unico; non è stato
  introdotto alcun nuovo formato progetto;
- `SvgDxfReader` era già in grado di conservare il layer ausiliario e
  tradurre `data-termodel-linetype/data-termodel-color` nel
  `DxfDocument` virtuale: non è stato necessario modificarlo;
- corretto il solo adattatore headless
  `Compatibility/HeadlessLegacyServices.cs`: in precedenza rifiutava
  qualsiasi layer tubi; ora acquisisce e conta le linee del layer
  `<NomePiano>_tubipannelli` al confine
  `LeggiDxf -> IoPannelli.LeggiTubiDXF`;
- questa modifica **non implementa ancora il solver pannelli**, non genera
  `retePannelli.xml`, spirali o perdite di carico e non sostituisce
  l'adapter Pannelli futuro;
- contratto Front↔Service aggiornato alla **v1.10** con la convenzione
  normativa dell'entità Tubo;
- registro `docs/TUBAZIONI-DEVELOPMENT-REGISTER.md` aggiornato con la
  milestone CAD Rete/Tubo;
- verifica sintattica frontend:
  `APP_JS_SYNTAX_OK`, `PIPE_FRONT_STATIC_OK`,
  `GENERA_PIANTA_SYNTAX_OK`,
  `GENERA_PIANTA_NETWORK_FILTER_OK`;
- durante la verifica è stata individuata e corretta una duplicazione
  accidentale del tail di `app.js`; la versione finale contiene una sola
  definizione delle routine CAD interessate;
- **compilato:** SI — GitHub Actions `TermodelService Build` run **#153**
  (run id `35867097104`), Build Release riuscita con **0 Error(s)**;
- **eseguito/testato:** SI — nello stesso run #153 uno smoke end-to-end ha
  inserito `T001` nel file unico, lo ha inviato a
  `POST /api/calculations`, verificato nel log
  `Letti 1 tubi dal layer <Piano>_tubipannelli` e verificato che
  `project.tmdl` persistesse layer, `entity=Tubo` e
  `rete=RAD-DEFAULT`; marker
  `RADIANT_PIPE_FILE_UNIQUE_SMOKE_OK`;
- nello stesso run sono rimasti verdi
  `RADIANT_NETWORK_ARCHIVES_SMOKE_OK`,
  `TERMODEL_LOG_OPTIONS_SMOKE_OK`, `PROJECT_LOCK_SMOKE_OK` e
  `GITHUB_FEEDBACK_SMOKE_OK`;
- il primo smoke dedicato, run #151, era fallito soltanto perché il test
  presumeva un gruppo SVG `<g>...</g>`; il ProgettoVuoto usa correttamente
  `<g ... />`. Il test è stato corretto per entrambe le forme e il run #153
  ha superato l'intero percorso;
- **frontend pubblicato:** GitHub Pages run **#776**
  (run id `35867394600`) completato con **success** dopo build, deploy e
  report build status;
- **confrontato con riferimento:** SI per formato CAD/layer/colore/linetype e
  punto di ingresso `LeggiDxf/IoPannelli`; NO per equivalenza del solver
  pannelli, che non è ancora implementato nel Service;
- `definizionedati.json`, `TERMODEL-PROJECT-TEXT-V1` e Library Desktop
  non sono stati modificati;
- commit principali:
  `e30ce3a5d2fe5922e73d03b358d992715a54ed7d`,
  `fffc48e3df745479dcc7aea4a85a9cfb5a82437b`,
  `22aa7f9156812db8754f8dc64deb381bcbca6ef5`,
  `dc31494825f6e284b37dd966a8d30d8a100e8d45`,
  `5534d9112b4ad598d7f55ca46bd24279373fff7e`,
  `e02fdc678b51a02c076407a9240c14a78da9e5a9`,
  `8991dc475f960e4b077f63c7ae633b6def27331c`,
  `6a11a381a73c42db5919d5029803f4a01d2b81b6`,
  `237bfa37cdc9aba24d76b095a3cdee6953c44848`,
  `abed0c44ccdecc6d931d63d1579be984b0a31ce2`,
  `31db33473429660afdb7489b9fe17601043ead4f`.

### INCARICO 2026-09-23 — modalità Edificio/Rete nel pannello CAD 2D
Stato: ESEGUITO

Commissionato:
- modificare esplicitamente il frontend `docs/termodel-ui-demo` nel pannello
  principale del CAD 2D;
- aggiungere un combo `Modalità` con almeno `Edificio` e `Rete`, con
  `Edificio` come modalità iniziale compatibile col comportamento corrente;
- quando `Modalità=Rete`, mostrare un secondo combo `Rete` alimentato
  dall'archivio progetto `Reti`, usando il codice della riga come
  identificatore e una descrizione leggibile per l'utente;
- mantenere il combo `Piano` sempre attivo sia in modalità `Edificio` sia
  in modalità `Rete`, perché una stessa rete può svilupparsi su più piani;
- quando si torna a `Edificio`, nascondere/disattivare il selettore della
  rete senza alterare il piano corrente;
- aggiornare il combo Rete quando cambia/carica il progetto e quando viene
  aggiornato lo stato degli archivi, gestendo in modo leggibile anche
  l'assenza di righe `Reti`;
- in questo incarico la selezione `Rete` è stato operativo del CAD/frontend:
  non implementare ancora la semantica di disegno delle reti, il tagging delle
  entità CAD o il calcolo pannelli;
- non modificare Service API, `TERMODEL-PROJECT-TEXT-V1`,
  `definizionedati.json`, Termodel.Core o Library Desktop.

Risultato:
- frontend portato a **v1.03**;
- aggiunto nella toolbar principale del CAD 2D il combo
  `Modalità = Edificio | Rete`, con `Edificio` come default;
- in modalità `Rete` compare il combo `Rete`, alimentato direttamente da
  `getArchivioWebRecords('Reti')`;
- il valore selezionato è `Reti.Codice`; la voce mostrata è
  `Codice — Descrizione` e le righe con `Attivo=NO` sono marcate
  `non attiva`;
- la scelta iniziale privilegia la prima rete attiva; se la rete precedentemente
  selezionata viene rimossa dall'archivio, la selezione viene riallineata alla
  prima rete attiva disponibile oppure alla prima riga;
- archivio `Reti` vuoto: il combo mostra `Nessuna rete in archivio` ed è
  disabilitato senza generare errori;
- tornando a `Edificio`, etichetta e combo Rete vengono nascosti e
  disabilitati;
- il combo `Piano` resta sempre visibile e attivo: il cambio piano modifica
  soltanto `cadToolbarState.piano` e conserva `modalita` e
  `rete`, quindi la stessa rete resta selezionata passando da un piano
  all'altro;
- l'evento esistente `termodel:archives-updated` richiama
  `cadRefreshToolbarControls()`, quindi il combo Rete viene riallineato dopo
  le modifiche tramite ArchivioWeb;
- la selezione Modalità/Rete è per ora **solo stato operativo del frontend**:
  non viene ancora scritta sulle entità SVG e non modifica il formato progetto;
- nessuna modifica a Service API, contratto Front↔Service,
  `TERMODEL-PROJECT-TEXT-V1`, `definizionedati.json`, Core o Library;
- verifica sintattica completa di `app.js` con parser V8:
  `APP_JS_SYNTAX_OK`; verifica statica dei nuovi elementi:
  `CAD_NETWORK_SELECTOR_STATIC_OK`;
- GitHub Pages run **#762**, run id `35863001579`, head
  `39760155b14ff4b3e0857faa453efedcef74a6cf`:
  **completed / success**;
- prova manuale dei combo nel browser dell'utente: non ancora eseguita;
- commit principali:
  `c00069fc6597225a4f7dcb7bb7935b6db2645158`,
  `a50e5a98c0b1403a0695d41275983dc05e26bb38`,
  `39760155b14ff4b3e0857faa453efedcef74a6cf`.

### INCARICO 2026-09-23 — revisione archivi pannelli radianti: Reti + TipologiePannelli
Stato: ESEGUITO

Commissionato:
- correggere la struttura dati introdotta negli incarichi precedenti:
  per il completamento pannelli radianti gli archivi autorevoli diventano due,
  `Reti` e `TipologiePannelli`;
- `Reti` descrive la tipologia di rete e i parametri di esercizio indipendenti
  dal costruttore; deve essere pensato anche per future reti
  `PannelliRadianti`, `Tubazioni`, `Canali`, pur precompilando ora solo
  il caso pannelli radianti;
- `Reti` contiene, per il caso pannelli, le temperature acqua e gli altri
  parametri di progetto/esercizio che non dipendono dalla casa produttrice;
- `TipologiePannelli` è codificato per casa produttrice/modello e contiene le
  caratteristiche costruttive dipendenti dal prodotto, comprese tubazione,
  diametri/materiale/rugosità e l'elenco dei passi/interassi disponibili
  (necessario in particolare per sistemi a funghetti);
- eliminare dal nuovo template/progetto vuoto la necessità di archivi separati
  `Tubazioni` e `Fluidi` per questa prima fase;
- aggiornare metadata estesi, template Service, ProgettoVuoto frontend,
  ArchivioWeb/menu e contratto Front↔Service coerentemente;
- mantenere `TERMODEL-PROJECT-TEXT-V1` invariato e non modificare
  `definizionedati.json`;
- registrare che in futuro il CAD 2D avrà una combo che seleziona una riga
  dell'archivio `Reti` e determina il tipo di rete che si sta disegnando;
  la combo CAD non viene implementata in questo incarico;
- non modificare ancora gli algoritmi del calcolo pannelli o Darcy.

Risultato:
- la precedente struttura
  `TipologiePannelli / Tubazioni / Fluidi` è dichiarata **SUPERATA**;
- nuovo modello autorevole:
  ```text
  Reti
  TipologiePannelli
  ```
- creato metadata:
  `Server/Termodelwebservice/src/Termodel.WebService/Definitions/reti-pannelli-definizionedati.json`;
- eliminato dal Service il precedente
  `pannelli-tubazioni-definizionedati.json`;
- `Reti` è predisposto per futuri tipi rete, ma oggi ammette soltanto
  `PannelliRadianti`;
- prima riga `Reti`:
  `RAD-DEFAULT`, tipologia `GEN-DEFAULT`, passo 300 mm, acqua,
  35/30 °C, ambiente 20 °C, esterna progetto 5 °C, limite circuito 100 m,
  perdita massima 25.000 Pa, `KLayout=1`,
  `FormulaPerdita=Darcy-Weisbach`;
- `Fluido` e `FormulaPerdita` sono vincolati nel metadata corrente alle
  sole scelte implementate `Acqua` e `Darcy-Weisbach`;
- le proprietà fisiche dell'acqua non sono più archiviate in un archivio
  `Fluidi`: il futuro kernel dovrà ricavarle dalla temperatura media;
- `TipologiePannelli` contiene esclusivamente dati del prodotto/sistema:
  casa produttrice, modello, descrizione, PE-Xa 16x2, D interno 12 mm,
  rugosità 0.0007 mm, barriera ossigeno, matassa 600 m,
  coefficiente resa 5 W/m²K e passi ammessi
  `50;100;150;200;250;300` mm;
- il passo **scelto** appartiene a `Reti`; l'elenco dei passi **ammessi**
  appartiene alla tipologia pannello. La validazione dinamica fra i due è
  registrata ma non ancora implementata;
- i nuovi progetti Service generano soltanto:
  `archives/json|xml/Reti` e
  `archives/json|xml/TipologiePannelli`;
- i template estesi `Tubazioni.json` e `Fluidi.json` sono stati rimossi;
- `ProgFileUnico` usa il nuovo metadata e i due archivi estesi;
- `Termodel.WebService.csproj` distribuisce il nuovo metadata;
- `ProgettoVuoto.termodel.txt` è stato rigenerato:
  contiene `Reti` e `TipologiePannelli`, non contiene
  `Tubazioni` o `Fluidi`, e il manifest contiene hash aggiornati;
- `docs/termodel-ui-demo/progetto-vuoto.js` è stato rigenerato dalla
  stessa risorsa; verifica diretta:
  metadata embedded = metadata Service, `Reti=true`,
  `TipologiePannelli=true`, `Tubazioni=false`, `Fluidi=false`;
- frontend portato a **v1.02**:
  menu `Modifica -> Archivio Reti / Archivio Tipologie pannelli`;
- `ArchivioWeb` mostra i due archivi nelle tab e legge prioritariamente
  `definition/reti-pannelli-definizionedati.json`;
- compatibilità transitoria: se un vecchio progetto contiene
  `definition/pannelli-tubazioni-definizionedati.json`, ArchivioWeb può
  ancora leggerlo; eventuali sezioni legacy `Tubazioni`/`Fluidi` non
  vengono cancellate automaticamente al semplice caricamento/salvataggio;
- contratto Front↔Service aggiornato alla **v1.9**;
- registro
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`
  revisionato: niente database `Tubazioni/Fluidi` separato per il ramo
  pannelli; il vecchio `base.dat` resta fonte di studio per il futuro
  programma generalista;
- decisione CAD registrata:
  futura combo `Rete` -> `Reti.Codice` -> `TipoRete` determina il
  tipo di rete disegnata; **NON IMPLEMENTATA** in questa fase;
- algoritmi pannelli, Darcy, geometria spirali, `definizionedati.json` e
  `TERMODEL-PROJECT-TEXT-V1` non modificati;
- **compilato:** SI, GitHub Actions Service run **#144**
  (run id `35854123945`), Build Release con **0 Error(s)**;
- **eseguito/testato:** SI per generazione progetto nuovo e smoke HTTP;
  marker `RADIANT_NETWORK_ARCHIVES_SMOKE_OK`,
  `TERMODEL_LOG_OPTIONS_SMOKE_OK`,
  `PROJECT_LOCK_SMOKE_OK`, `GITHUB_FEEDBACK_SMOKE_OK`;
- **frontend pubblicato:** GitHub Pages run **#758**
  (run id `35854209496`) completato con successo;
- **confrontato con riferimento:** i valori iniziali sono stati ricollocati
  rispetto agli hard-coded correnti di `DatiProgettoPannelli` senza
  modificare gli algoritmi; la lettura runtime da parte del solver resta il
  prossimo passo;
- commit chiave:
  `bedc754e51f02f4468283e77a4671e24db26617e`,
  `f1a522aeb275e775631ac91c68863bbffc13005d`,
  `2835851dacb46e02a30da9827af5c8eecf005afd`,
  `fc5f4b3ae09b1a29a140e4fe3e2d33ed0980723e`,
  `90cc9cd8cd3b074ef5e5fa574ae19fced62287dd`,
  `06910829a433bf5d935af8c3ba6bd42d95fc6bd2`,
  `66aac096b985048b8f0e7c302cff7c69701e98f3`,
  `a57f8805e4dff0c91c0b8fdc4fb7dcf825fc3445`,
  `9491b89a10dcad8a00a4fc7f3d63e698ace03366`.

### INCARICO 2026-09-23 — voci archivi pannelli nel menu frontend
Stato: ESEGUITO — **SUPERATO dalla successiva revisione Reti + TipologiePannelli**

Commissionato:
- aggiungere al menu frontend le voci per gli archivi progetto
  `TipologiePannelli`, `Tubazioni` e `Fluidi`;
- collegare le voci al motore unico `ArchivioWeb` esistente tramite
  `data-archive`;
- rendere effettivamente apribili i tre archivi usando i metadata estesi già
  trasportati nel `TERMODEL-PROJECT-TEXT-V1`, senza modificare o duplicare
  `definizionedati.json`;
- aggiungere i tre archivi alle tab interne della finestra Archivi;
- non modificare algoritmi pannelli, Service API o formato progetto.

Criteri di completamento:
- tre voci visibili nel menu frontend;
- apertura corretta di griglia/form per i tre archivi nel progetto vuoto;
- metadata caricati dalla sezione progetto
  `definition/pannelli-tubazioni-definizionedati.json`;
- progetti precedenti senza i nuovi archivi restano caricabili;
- verifica frontend e pubblicazione GitHub Pages;
- Summary aggiornato allo stato reale.

Risultato:
- aggiunte in `docs/termodel-ui-demo/index.html`, menu `Modifica`, le voci:
  `Archivio Tipologie pannelli`, `Archivio Tubazioni`,
  `Archivio Fluidi`, tutte collegate tramite `data-archive`;
- `ARCHIVE_ORDER` di `archivio-web.js` esteso con
  `TipologiePannelli`, `Tubazioni`, `Fluidi`, quindi i tre archivi
  compaiono anche nelle tab interne della finestra Archivi;
- `ArchivioWeb` mantiene una copia dello schema storico base e, ad ogni
  progetto caricato, integra i metadata presenti nella sezione
  `definition/pannelli-tubazioni-definizionedati.json`;
- nessuna modifica e nessuna duplicazione del file storico
  `definizionedati.json`;
- i metadata estesi sono quindi realmente quelli trasportati dal progetto;
- sui progetti precedenti senza metadata/archivio esteso il caricamento del
  progetto resta compatibile; la richiesta esplicita di una nuova voce assente
  produce ora un errore chiaro invece di aprire silenziosamente un altro
  archivio;
- versione frontend portata a **1.01** e import `archivio-web.js` portato a
  cache key **0.81**;
- contratto Front↔Service aggiornato alla **v1.8**: le tre voci archivio sono
  ora parte della UI implementata; il futuro sottomenu generalista
  `Tubazioni` con funzioni di calcolo resta distinto e sospeso;
- registro `TUBAZIONI-DEVELOPMENT-REGISTER.md` aggiornato:
  `voci archivio frontend = IMPLEMENTATE`,
  `sottomenu generalista Tubazioni = SOSPESO`;
- GitHub Pages run **#725**, run id `35851842080`, commit frontend
  `4216a670ca78def2f0e7754a0c887bba96b803ad`:
  build Jekyll **success**, deploy Pages **success**, report build status
  **success**;
- il precedente Service build avviato dalla registrazione dell'incarico,
  run **#125**, è terminato con successo; nessuna modifica Service runtime è
  stata necessaria;
- verifica del percorso logico frontend eseguita sul codice:
  menu `data-archive` -> `openArchivioWeb(name)` -> schema esteso del
  progetto -> records `archives/json/<name>.json` -> form/griglia
  `ArchivioWeb`;
- **compilato:** non applicabile come binario per il frontend statico; build
  GitHub Pages riuscita;
- **eseguito:** pubblicazione GitHub Pages riuscita;
- **testato:** struttura/menu/schema e deploy automatico verificati; il click
  manuale nel browser dell'utente resta una verifica reale separata;
- **confrontato con riferimento:** coerente con il motore unico ArchivioWeb e
  con gli archivi progetto introdotti nell'incarico precedente;
- algoritmi pannelli, Service API, protocollo progetto e
  `definizionedati.json` non modificati;
- commit principali:
  `a065bde25e3ae1ec3084c6d36b0e69a49960bccc`,
  `e49d9a1774b69e2462e2c6c4e2479a0d1588926c`,
  `356cb28449f6926a3c46af452c65f5ab065a7451`,
  `be6ef9340ee1f64205f6ec4a4cf9cf6780ff9939`,
  `d33e2241652749c03a37bacedbdfc1f85d49dd46`,
  `a15ec69165a0d29a876475da9d5f22ef101d97f3`,
  `4216a670ca78def2f0e7754a0c887bba96b803ad`,
  `1e70bc65625a65638040f43716c20116a8aec13d`,
  `838926d57b5a48f3178ddc4be88c61cbebeafc95`.

### INCARICO 2026-09-23 — completamento calcolo pannelli radianti: archivi progetto
Stato: ESEGUITO — **SUPERATO dalla successiva revisione Reti + TipologiePannelli**

Commissionato:
- classificare l'intervento come **completamento calcolo pannelli radianti**;
- creare tre archivi progetto indipendenti e precompilati:
  `TipologiePannelli`, `Tubazioni`, `Fluidi`;
- `TipologiePannelli` deve essere identificato per casa produttrice/modello e
  contenere inizialmente tutti i parametri oggi hard-coded come default in
  `SorgentiTermodel/Library/Impianti/Pannelli/CalcoloPannelli.cs`;
- `Tubazioni` deve contenere almeno il tubo radiante default già specificato
  per il primo calcolo idraulico;
- `Fluidi` deve contenere almeno acqua con proprietà necessarie al calcolo
  Darcy in funzione della temperatura;
- i tre archivi devono essere dati di progetto reali e devono comparire nel
  `TERMODEL-PROJECT-TEXT-V1` consolidato;
- il `ProgettoVuoto` usato dal frontend deve contenerli già precompilati;
- il Service e il frontend devono leggere/conservare gli archivi senza creare
  formati concorrenti;
- mantenere separato `definizionedati.json` Termodel esistente: introdurre
  metadata Tubazioni/Pannelli separati se necessario;
- preparare la struttura perché il successivo calcolo pannelli legga i default
  dall'archivio `TipologiePannelli` invece che da costanti C#;
- non implementare in questo incarico il futuro sottomenu generale
  `Tubazioni`, che resta sospeso salvo quanto strettamente necessario a
  conservare/mostrare i dati progetto;
- non alterare algoritmi geometrici delle spirali.

Criteri di completamento:
- tre archivi presenti nel template autorevole e nel progetto vuoto consolidato;
- frontend conserva i tre archivi in apertura/modifica/ricostruzione del file
  unico;
- schema di `TipologiePannelli` copre tutti gli attuali default
  `DatiProgettoPannelli`;
- almeno una riga default coerente con gli attuali valori C#;
- `Tubazioni` precaricato con PE-Xa 16x2 per pannelli;
- `Fluidi` precaricato con acqua e proprietà sufficienti al futuro Darcy;
- contratto Front↔Service aggiornato se il contenuto obbligatorio del progetto
  cambia;
- build Release e smoke del progetto nuovo;
- verifica che il progetto vuoto frontend contenga realmente le tre sezioni;
- registro `TUBAZIONI-DEVELOPMENT-REGISTER.md` e Summary aggiornati allo
  stato reale.

Risultato:
- creato metadata separato
  `Server/Termodelwebservice/src/Termodel.WebService/Definitions/pannelli-tubazioni-definizionedati.json`;
  `definizionedati.json` storico non modificato;
- creati nel template Service gli archivi precompilati
  `extended-archives/TipologiePannelli.json`,
  `Tubazioni.json`, `Fluidi.json`;
- `TipologiePannelli` contiene la riga `GEN-DEFAULT`,
  `CasaProduttrice=Generico`, `Modello=Default Termodel`, con tutti gli
  11 valori precedentemente hard-coded in `DatiProgettoPannelli`:
  passo 0,30 m, tubo 16x2, temperature 35/30/20/5 °C, matassa 600 m,
  lunghezza massima circuito 100 m, perdita massima 25.000 Pa e coefficiente
  resa 5 W/m²K;
- la tipologia default referenzia inoltre
  `CodiceTubazione=PEXA-O2-16X2` e `CodiceFluido=H2O`;
- `Tubazioni` contiene PE-Xa 16x2 mm, D interno 12 mm, rugosità
  0,0007 mm, barriera ossigeno e Darcy-Weisbach;
- `Fluidi` contiene acqua H2O con punti proprietà 30/35/40 °C;
- `ProgFileUnico` carica automaticamente gli archivi estesi dal template e
  li inserisce nel progetto nuovo sia come `archives/json/*.json` sia come
  `archives/xml/*.xml`; aggiunge anche
  `definition/pannelli-tubazioni-definizionedati.json`;
- corretta la normalizzazione dei valori JSON estesi in tipi CLR primitivi
  prima della serializzazione XML, evitando `JsonElement` nel
  `DataContractSerializer`;
- il nuovo metadata viene copiato in output/publish dal
  `Termodel.WebService.csproj`;
- aggiornato il progetto vuoto consolidato
  `SorgentiTermodel/Library/projects/ProgettoVuoto/ProgettoVuoto.termodel.txt`
  con metadata e sezioni XML/JSON dei tre archivi;
- rigenerato
  `docs/termodel-ui-demo/progetto-vuoto.js` dalla risorsa consolidata;
- verificato il percorso frontend esistente: `archivio-web.js` acquisisce
  tutte le sezioni `archives/json/*`, `getArchivioWebState()` espone tutte
  le chiavi archivio e `app.js` ricostruisce il file unico passando tutte le
  collection a `buildTermodelProjectText`; pertanto i tre archivi vengono
  conservati anche se non sono ancora esposti in `ARCHIVE_ORDER`;
- il futuro menu/sottomenu `Tubazioni` resta **SOSPESO** e non è stato
  implementato;
- contratto Front↔Service aggiornato alla **v1.7**, sezione
  `2.0.1 Archivi di progetto per completamento pannelli radianti`;
- registro autonomo Tubazioni aggiornato con la milestone
  `completamento dati di base pannelli radianti`;
- README template Service e ProgettoVuoto aggiornati;
- GitHub Pages relativo al commit frontend
  `dd2ed57029bbfbe672840e2dfa78c8c972532582`: run
  **#711**, completato con successo;
- GitHub Actions Service run **#121** ha dato:
  Build Release **153 warning, 0 errori** e smoke progetto/log riuscito,
  incluso `RADIANT_PROJECT_ARCHIVES_SMOKE_OK`; lo smoke feedback separato è
  fallito per una race preesistente all'avvio dello stub locale (porta 5099
  non ancora in ascolto);
- stabilizzato lo smoke feedback sostituendo il ritardo fisso con retry
  esplicito fino a disponibilità dello stub;
- GitHub Actions Service run **#123**, commit
  `2c6f477287744131dec381b9ee26666716222299`: **successo completo**;
  Build Release 0 errori, smoke progetto/lock/log success, nuovo marker
  `RADIANT_PROJECT_ARCHIVES_SMOKE_OK`, e smoke feedback
  `GITHUB_FEEDBACK_SMOKE_OK`;
- **compilato:** SI, GitHub Actions Release;
- **eseguito:** SI, generazione reale via `POST /api/projects/new` nello
  smoke HTTP;
- **testato:** SI per presenza/sezioni/contenuto iniziale dei tre archivi nel
  progetto Service, presenza nel ProgettoVuoto statico, regressioni project
  lock/log e feedback;
- **confrontato con riferimento:** valori della tipologia default confrontati
  con gli hard-coded correnti di `CalcoloPannelli.cs`; la lettura runtime di
  tali archivi da parte del solver pannelli è predisposta ma resta il prossimo
  intervento;
- non modificati algoritmi geometrici delle spirali;
- commit principali:
  `bf12ba9d3c58ac7c198e4787867074d0e4e31b54`,
  `615cfbea94159bf9faa6a17f30af43d0792ee165`,
  `94c23c28bde49167bf04dd9efef78340789f49ff`,
  `30ef99605037b81f732c0d808b458f046fab0a52`,
  `beeaf415422ad909d97d1c6d6682ed74af596d84`,
  `f87f1cd160cd9329fb1ba1471666a0e7e2eeced6`,
  `09ea1f8794ef2baa8c520a2d7a993c7f7ac14601`,
  `47bc4d314ef9ab8314048a45833e248b871a5f21`,
  `dd2ed57029bbfbe672840e2dfa78c8c972532582`,
  `439cb7215323812b4295245c15ca787e6a12dcbb`,
  `2e155845fca706a2373894ff6db46c43fcae8297`,
  `6ce39bba2db38a89d8b6771d627e56e63566519c`,
  `2c6f477287744131dec381b9ee26666716222299`.

### INCARICO 2026-09-23 — specifica perdite di carico pannelli radianti
Stato: ESEGUITO

Commissionato:
- definire e registrare le specifiche della prima funzione operativa della nuova
  linea Calcolo Tubazioni: calcolo delle perdite di carico dei circuiti dei
  pannelli radianti;
- NON usare come sorgente autorevole la lunghezza delle spirali già generata,
  perché può risultare corrotta;
- ricavare una lunghezza idraulica della spirale da superficie servita e passo
  tubo mediante una relazione empirica/documentata, da verificare su fonti
  tecniche esterne;
- sommare alla lunghezza stimata della spirale la lunghezza reale dei tubi di
  collegamento fra collettore e circuito;
- usare portata, lunghezza totale, diametro/proprietà della tubazione e fluido
  per il calcolo delle perdite di carico tramite la nuova libreria Tubazioni;
- usare come formula predefinita Darcy-Weisbach, con fattore d'attrito
  determinato in modo coerente col regime di moto e con la rugosità;
- progettare contestualmente gli archivi indipendenti Tubazioni e Fluidi,
  predisposti per il futuro programma generalista;
- caricare almeno una famiglia di tubazione idonea ai pannelli radianti e il
  fluido acqua, dopo verifica tecnica del materiale/nomenclatura corretta;
- prevedere una futura gestione UI tramite sottomenu "Tubazioni", ma lasciarla
  esplicitamente IN SOSPESO in questa fase;
- mantenere l'obiettivo di questa fase limitato alla produzione del dato
  "perdita di carico del circuito"; il completamento del programma generalista
  verrà affrontato successivamente.

Vincoli:
- aggiornare il registro autonomo
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`;
- non implementare ancora solver, archivi runtime, menu, frontend o integrazione
  in `Aggiorna Modello`;
- non modificare `definizionedati.json`, Library Pascal o protocollo progetto;
- distinguere chiaramente dati derivati empiricamente, dati geometrici reali e
  parametri idraulici di archivio.

Criteri di completamento:
- relazione superficie/passo -> lunghezza registrata con ipotesi e coefficiente
  di correzione separato/configurabile;
- definito il contributo dei tubi di collegamento;
- definito il set minimo di input/output del calcolo Darcy;
- definiti gli archivi minimi Tubazioni e Fluidi e i dati iniziali da
  precaricare;
- annotato il materiale corretto per tubi radianti sulla base delle fonti;
- sottomenu Tubazioni registrato come sospeso;
- Summary aggiornato con lo stato reale.

Risultato:
- aggiornato
  `docs/TUBAZIONI-DEVELOPMENT-REGISTER.md` con la specifica completa della
  prima funzione operativa;
- la lunghezza grafica della spirale è stata esplicitamente esclusa dagli input
  autorevoli del calcolo idraulico;
- adottata la relazione
  `L_spirale = AreaServita * F_passo * K_layout`, con fattori Uponor
  verificati: 100 mm -> 10.0 m/m², 150 mm -> 6.7 m/m²,
  200 mm -> 5.0 m/m², oltre alla tabella 50/125/175/300 mm;
- `K_layout` registrato a 1.000 di default e modificabile soltanto dopo
  regression test; esclusa qualunque maggiorazione commerciale 5-10% dalla
  lunghezza idraulica;
- i collegamenti mandata+ritorno fra collettore e spirale sono sommati usando
  la loro lunghezza geometrica reale;
- confine prima versione definito da uscita collettore a ingresso collettore;
  collettore, flussimetri, valvole e altre perdite concentrate sono rinviati al
  programma generalista;
- definito il set minimo input:
  superficie, passo, lunghezza collegamenti, portata, codice tubo, codice
  fluido e temperatura media;
- formula default registrata: Darcy-Weisbach; velocità e Reynolds in SI,
  `f=64/Re` in laminare, Colebrook-White in turbolento; transizione da
  trattare con diagnostica e regola numerica da fissare nel kernel;
- definito output minimo comprendente lunghezze stimate/reali, velocità,
  Reynolds, fattore Darcy, perdita lineare e perdita circuito Pa/kPa;
- progettati gli archivi minimi `Tubazioni`/`DiametriTubazioni` e
  `Fluidi`/`ProprietaFluidi`;
- la richiesta iniziale "PVC" è stata verificata contro documentazione
  produttori: per pannelli radianti il default corretto è PE-X/PEX o PE-RT;
  registrato come prima famiglia `PEXA-O2`, PE-Xa con barriera ossigeno,
  16x2 mm, diametro interno 12 mm;
- il PPI 2024 indica per PEX rugosità assoluta 0.0005-0.0007 mm:
  registrato 0.0007 mm come valore iniziale conservativo/modificabile;
- primo fluido registrato: `H2O / Acqua`, liquido Newtoniano con proprietà
  tabellate/interpolate in funzione della temperatura; riportati riferimenti
  30/35/40 °C per densità e viscosità;
- futura UI registrata:
  `Tubazioni -> Archivio tubazioni / Archivio fluidi`;
  **stato UI: IN SOSPESO**;
- T1 resta IN CORSO: è definito il nucleo minimo per pannelli, mentre il
  mapping generalista completo di `base.dat` resta successivo;
- nessun solver, archivio runtime, menu, frontend o integrazione
  `Aggiorna Modello` implementati;
- `definizionedati.json`, Library Pascal e protocollo progetto non modificati;
- **compilazione:** non eseguita/non applicabile, modifica documentale;
- **esecuzione:** non eseguita;
- **test numerici:** non eseguiti; specifiche da validare nella futura
  implementazione con casi sintetici e regression test;
- commit specifica:
  `fe12046b4d1f193399b1d73bba640d48187594df`.

### INCARICO 2026-09-23 — registro sviluppo autonomo Calcolo Tubazioni
Stato: ESEGUITO

Commissionato:
- studiare i sorgenti Pascal storici presenti in
  `SorgentiTermodel/Library/SorgentiPascal/` relativi al calcolo reti/tubazioni,
  ai pannelli radianti, alla gestione DXF, alle definizioni `base.dat` e al
  generatore database/form;
- usare tali sorgenti come **fonte di ispirazione funzionale e algoritmica**,
  non come codice da portare ciecamente;
- definire una nuova linea di sviluppo autonoma **Calcolo Tubazioni**, concepita
  come libreria di supporto ai pannelli radianti e futura fase richiamata da
  `Aggiorna Modello`;
- progettare un database JSON indipendente per Tubazioni, ma con la stessa
  impostazione strutturale/di metadati degli archivi JSON Termodel, evitando di
  modificare `definizionedati.json`;
- prevedere generazione/automazione dei form basata sui metadati, secondo il
  principio già usato da Termodel per gli archivi, evitando form codificati a
  mano per ogni tabella;
- studiare la vecchia libreria DXF Pascal per identificare soltanto le
  responsabilità geometriche/di rete riutilizzabili; il nuovo motore non deve
  dipendere obbligatoriamente da AutoCAD o dal filesystem storico;
- creare un registro di sviluppo dedicato in
  `Server/Termodelwebservice/docs/TUBAZIONI-DEVELOPMENT-REGISTER.md` con
  fonti studiate, architettura target, dati, fasi, decisioni, rischi, test e
  stato di avanzamento;
- in questo incarico non implementare ancora il motore Tubazioni e non
  modificare frontend, Library Pascal, `TERMODEL-PROJECT-TEXT-V1` o
  `definizionedati.json`.

Criteri di completamento:
- individuare e classificare i sorgenti Pascal realmente rilevanti;
- descrivere il flusso storico dati → grafo/rete → calcolo → risultati/DXF;
- definire il confine fra nuovo Core Tubazioni, database JSON, generatore form
  e adattatore futuro per `Aggiorna Modello`;
- registrare una roadmap autonoma con fasi verificabili e strategia di
  regression test contro i programmi Pascal storici;
- aggiornare il Summary con il percorso del nuovo registro e lo stato reale
  dell'analisi.

Risultato:
- creato il registro autonomo
  `docs/TUBAZIONI-DEVELOPMENT-REGISTER.md`;
- studiato il nucleo storico
  `SorgentiPascal/Pascal/02_Sottosistemi_Completi/.../versione_10/Tubi/`,
  con particolare attenzione a `Calcolo_Tubi.pas`, `PERDCONC.PAS`,
  `EQUIL.PAS`, `UGrafoDXF.pas`, `RITORNO.PAS`, `collettori.pas`,
  `iotubi.pas`, `DATITUBI.PAS`, `OutDXFBM.pas`,
  `UMain_CalcTubi.pas` e `CalcTubiDll.dpr`;
- ricostruito il flusso storico: entità CAD → grafo → controllo topologico →
  propagazione portate → dimensionamento → perdite distribuite/concentrate →
  percorso sfavorito → eventuale equilibratura/valvole/portate effettive →
  risultati e output grafico;
- identificato nel Pascal il nucleo fisico da reimplementare come funzioni
  pure: propagazione portate, Darcy/Colebrook, perdite concentrate,
  dimensionamento per limiti di velocità/perdita, percorso critico ed
  equilibratura;
- studiato il `base.dat` Tubazioni storico: tre copie della versione 10
  risultano sullo stesso Git blob
  `a643c307657969b756d53cbeca484a20463596dc`; mappati i principali
  archivi `Reti`, `Tubazioni`, `Diametri`, `MatTubi`, `Perdite`,
  `TipiRete`, terminali e perdite concentrate;
- studiato il generatore storico `GENERA`: i token `INI`, `CMB`,
  `LKK`, `GRD`, `DEC` e le relazioni master/slave pilotavano
  generazione di record, DB, form, combo, lookup e griglie;
- confrontato il precedente con l'attuale automazione Termodel
  `AutoForm.cs` / `FormArchivio.xaml.cs` e
  `definizionedati.json`: registrata la decisione di creare un
  `tubazioni-definizionedati.json` indipendente ma compatibile nelle
  convenzioni metadata e un database operativo JSON autonomo;
- chiarito che il Desktop Termodel corrente usa il JSON soprattutto come
  metadata mentre molti dati archivio sono persistiti in XML; il nuovo
  database Tubazioni sarà invece esplicitamente JSON senza modificare il
  formato degli archivi Termodel esistenti;
- studiata la vecchia gestione DXF/AutoCAD: le convenzioni geometriche,
  terminali, valvole, collettori, curve e diramazioni restano riferimenti,
  mentre script AutoCAD, `WinExec` e file temporanei non entreranno nel
  nuovo Core;
- verificato il collegamento moderno con i pannelli:
  `CalcoloPannelli.cs` possiede già DTO di circuiti/lunghezze/potenze,
  `IoPannelli` genera `retePannelli.xml` con nodi/tratti e `IoTubi`
  usa il grafo per collettore e collegamenti; il nuovo solver riceverà quindi
  un `TubazioniNetwork` neutro tramite adapter Pannelli, senza dipendere
  direttamente dal DXF;
- definita roadmap T0–T9: dati/schema, dominio grafo, kernel idraulico,
  equilibratura, adapter Pannelli, regression Pascal/golden, drawing result,
  integrazione `Aggiorna Modello`, UI metadata-driven;
- **compilazione:** non eseguita e non richiesta, perché questo incarico ha
  modificato soltanto documentazione/registro;
- **esecuzione/test:** non applicabili in questa fase; nessun motore Tubazioni
  è stato dichiarato implementato;
- **confronto riferimento:** studio statico Pascal/C# completato a livello
  architetturale; regression test numerici Pascal ancora da creare;
- frontend, Library Pascal, `TERMODEL-PROJECT-TEXT-V1` e
  `definizionedati.json` non modificati;
- commit registro:
  `c40b6b5f264a49c94df3dff6b97185b83764c178`.

### INCARICO 2026-09-23 — configurazione log per Aggiorna Modello
Stato: ESEGUITO

Commissionato:
- estendere `POST /api/calculations` (Aggiorna Modello) con parametri opzionali
  per configurare il logging della singola elaborazione;
- usare come categorie autorevoli quelle del Desktop appena acquisite:
  `Sempre`, `colmi`, `spezza`, `Error`, `Svg`, `RedrawHelix`,
  `GeneraModello`, `Performance`, `PontiAutomatici`;
- mantenere piena retrocompatibilità: se non vengono passati parametri di log,
  il Service deve conservare il comportamento headless corrente già verificato;
- introdurre i parametri query opzionali `logEnabled` e `logCategories`;
  `logCategories` accetta elenco separato da virgole, case-insensitive, oltre
  agli alias `all` e `none`;
- quando `logCategories` è specificato, `IsEnabled(...)` deve riflettere
  esattamente le categorie selezionate e le scritture dirette devono essere
  filtrate per categoria; `LogOperation` usa la categoria Desktop `Sempre`
  e `LogError` la categoria `Error`;
- `logEnabled=false` disabilita completamente la raccolta log per quella sola
  elaborazione;
- le opzioni devono essere isolate per richiesta tramite lo stesso meccanismo
  `AsyncLocal`, senza stato globale condiviso fra progetti;
- non modificare `TERMODEL-PROJECT-TEXT-V1`: le opzioni di log sono parametri
  di esecuzione e non dati persistenti del progetto;
- aggiungere alla risposta di `POST /api/calculations` il riepilogo della
  configurazione log effettivamente applicata e registrarla anche in
  `logs/calculation.log`;
- preservare `TermodelLog.md`, `diagnostics.txt`, endpoint
  `GET /api/projects/{projectId}/logs/termodel`, publish transazionale e
  protezione dell'ultimo risultato valido;
- non modificare frontend, Library Desktop o `definizionedati.json`.

Criteri di completamento:
- build Release con 0 errori;
- smoke HTTP del comportamento predefinito invariato;
- smoke con `logEnabled=false`;
- smoke con filtro di categoria e con `logCategories=all`;
- verifica rifiuto di categoria sconosciuta con errore client strutturato;
- verifica isolamento fra elaborazioni successive con configurazioni diverse;
- aggiornare README, contratto condiviso e questa voce a `Stato: ESEGUITO`
  soltanto dopo build e smoke riusciti.

Risultato:
- **API implementata:** `POST /api/calculations` accetta
  `logEnabled=true|false` e `logCategories=<elenco>` come query parameter;
  il body resta il normale `TERMODEL-PROJECT-TEXT-V1`;
- **categorie:** l'adattatore headless usa ora gli stessi nomi del riferimento
  Desktop: `Sempre`, `colmi`, `spezza`, `Error`, `Svg`,
  `RedrawHelix`, `GeneraModello`, `Performance`,
  `PontiAutomatici`;
- **retrocompatibilità:** senza parametri resta la modalità
  `service-default`: tutte le scritture dirette già raccolte dal Service
  continuano a essere raccolte, mentre i blocchi protetti da
  `IsEnabled(...)` restano disattivati;
- **modalità filtrata:** se `logCategories` è presente,
  `IsEnabled(category)` e le scritture dirette rispettano esclusivamente le
  categorie selezionate; `LogOperation` è associato a `Sempre` e
  `LogError` a `Error`;
- supportati alias `all` e `none`; i nomi categoria sono
  case-insensitive; categoria sconosciuta o lista vuota → HTTP 400 con
  validation problem e calcolo non avviato;
- `logEnabled=false` produce modalità `disabled` e nessuna diagnostica
  raccolta per quella elaborazione;
- configurazione e messaggi sono isolati per elaborazione con `AsyncLocal`;
  `GeneraModello.GeneraAsync` riceve la configurazione senza introdurre
  stato persistente nel progetto;
- la risposta di `POST /api/calculations` include il nuovo oggetto additivo
  `logging { enabled, mode, categories }`;
- `logs/calculation.log` registra ora anche `logEnabled`, `logMode` e
  `logCategories`; `TermodelLog.md` e `diagnostics.txt` continuano a
  contenere i messaggi effettivamente raccolti;
- preservati publish transazionale, ultimo log valido su errore, endpoint
  `GET /api/projects/{projectId}/logs/termodel` e header stale;
- README, contratto condiviso **v1.6**, `TERMODEL-SYNC.md` e
  `docs/copied-from-termodel.md` aggiornati;
- **compilazione:** GitHub Actions `TermodelService Build` run **#101**,
  commit `d3ee3afa7d40dd30c2235c5729f882090d20ced4`: Build Release riuscita
  con **153 warning, 0 errori**;
- **smoke HTTP:** nello stesso run #101 lo step
  `Smoke test HTTP project storage and exclusive locks` è riuscito e i log
  del job riportano esplicitamente `TERMODEL_LOG_OPTIONS_SMOKE_OK`,
  `TERMODEL_LOG_SMOKE_OK` e `PROJECT_LOCK_SMOKE_OK`;
- lo smoke verifica realmente: comportamento predefinito non vuoto,
  `logEnabled=false` con zero diagnostiche e file log vuoto, filtro
  `Error` senza messaggi `info/operation`, `logCategories=all` con tutte
  le 9 categorie, categoria sconosciuta → HTTP 400 senza sostituire il log
  precedente e assenza di contaminazione del log del progetto A durante le
  elaborazioni configurate del progetto B;
- **verifica tree documentato:** GitHub Actions run **#104**, commit
  `e5438f8155b16ae3ce6f780f3e7b48f3c94c50c7`, completato con successo
  per Build, smoke project/log e smoke feedback;
- **frontend:** non modificato;
- **Library Desktop:** non modificata;
- **definizionedati.json:** non modificato;
- commit principali:
  `dc71fd329ea1eb00a09d20e7d185b8f814b02585`,
  `a367321570ef2abdc7871463977ffce2ac679955`,
  `b8fc9a4ec3477fce068963c365ce02894b8380ff`,
  `0d5fe4f33ee92d885c4363160a9d6a89745cfcb7`,
  `d3ee3afa7d40dd30c2235c5729f882090d20ced4`,
  `8023cbf6e0af0b562cf0c553afa034eb91f68a06`,
  `8fa3d1c935e5baa419b0b51144f6b1e1d774fc33`,
  `e5438f8155b16ae3ce6f780f3e7b48f3c94c50c7`,
  `dcdbdd4b37d021d3b131375444a75d9dfe6cba87`.

### INCARICO 2026-09-23 — acquisizione sorgente Desktop autorevole TermodelLog
Stato: ESEGUITO

Commissionato:
- individuare nel sorgente Desktop locale reale l'implementazione autorevole
  di `TermodelLog` e verificarne provenienza e SHA-256;
- integrare in `SorgentiTermodel/Library/utilities/TermodelLog.cs` una copia
  non adattata e byte-per-byte identica all'originale Desktop;
- confrontare il comportamento Desktop con l'adattatore headless già presente
  in `Compatibility/LegacyCoreAdapters.cs`, preservando lifecycle per-request,
  isolamento `AsyncLocal`, persistenza per progetto ed endpoint già verificati;
- aggiornare `TERMODEL-SYNC.md`, `docs/copied-from-termodel.md` e questo
  Summary eliminando il precedente limite documentale dovuto all'assenza del
  sorgente Desktop nella Library;
- non modificare l'adattatore headless salvo una necessità dimostrata dal
  confronto; non copiare nel runtime server dipendenze WPF, filesystem Desktop,
  finestre di errore o diagnostica grafica IFC/NTS;
- non modificare frontend, `PROJECT-SUMMARY.md` alla radice o
  `definizionedati.json`.

Criteri di completamento:
- copia Library con SHA-256 identico all'originale locale;
- confronto funzionale Desktop/headless documentato per API, categorie,
  lifecycle, persistenza, concorrenza e dipendenze non portabili;
- verifica statica che il sistema headless e il suo contratto pubblico siano
  rimasti invariati;
- stato aggiornato a `ESEGUITO` soltanto dopo le verifiche finali, riportando
  distintamente build, esecuzione e test realmente effettuati.

Risultato:
- **sorgente recuperato:** individuato l'originale Desktop locale
  `utilities/TermodelLog.cs`, 378 righe, SHA-256
  `79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218`;
- **Library integrata:** aggiunto
  `SorgentiTermodel/Library/utilities/TermodelLog.cs` come copia non adattata;
  SHA-256 e confronto byte-per-byte coincidono con l'originale locale; la
  regola `.gitattributes` specifica `-text` impedisce a Git di normalizzare i
  fine riga del solo file copiato e conserva identico anche il blob versionato;
- **confronto Desktop:** il logger Desktop usa file globali
  `TermodelLog.md`/`LogError.md` sotto `GestProg.ProgramPath`, categorie a
  costanti (solo `PontiAutomatici=true`), presentazione errori WPF e funzioni
  diagnostiche dipendenti da SVGHelper, xBIM e NetTopologySuite; conserva
  inoltre rami legacy resi inattivi da ritorni anticipati;
- **confronto headless:** `InitializeLog()`/`Reset()`, buffer `AsyncLocal`,
  raccolta `WriteLog`/`LogOperation`/`LogError`, publish transazionale per
  `projectId` ed endpoint persistente sono requisiti server corretti e restano
  invariati. `IsEnabled(...)` continua a disabilitare i blocchi condizionati di
  debug, mentre le chiamate dirette restano raccolte nel buffer diagnostico;
- **decisione:** il file Desktop acquisito chiude la lacuna della Library ma
  non deve sostituire l'adattatore headless, perché reintrodurrebbe filesystem
  globale, UI e dipendenze non portabili e perderebbe l'isolamento per richiesta;
- aggiornati `TERMODEL-SYNC.md` e `docs/copied-from-termodel.md` con
  provenienza, hash, categorie, differenze e responsabilità delle due versioni;
- **verifica statica:** `LegacyCoreAdapters.cs` è invariato rispetto a
  `origin/main`; frontend, `PROJECT-SUMMARY.md` radice e
  `definizionedati.json` non sono stati modificati;
- **compilazione:** GitHub Actions `TermodelService Build` run **#94**, commit
  `62797e05ad109b957200f8097310daf0ba04a453`: restore e Build completati con
  successo; nessuna build locale eseguita;
- **esecuzione/test HTTP:** nello stesso run #94 sono completati con successo
  `Smoke test HTTP project storage and exclusive locks` e
  `Smoke test GitHub feedback bridge`; il runtime headless e il contratto log
  già verificato dal run #91 restano quindi operativi dopo l'integrazione
  consultiva;
- **commit di integrazione:**
  `d080b8c96657f5fa564f008d967a337c46dae1a1` —
  `Add authoritative desktop TermodelLog reference`.

### INCARICO 2026-09-23 — correzione validazione attributi numerici FIN
Stato: ESEGUITO

Commissionato:
- correggere in `Termodel.Core` la routine `CaricaDatiFinestra(...)` che valida
  gli attributi numerici dei blocchi FIN usando erroneamente
  `DatiFinestra.Tipo` invece del valore corrente dell'attributo;
- applicare la correzione a `ALTEZZA`, `LARGHEZZA`, `NUMEROANTE`,
  `SOTTOFINESTRA` e `SOPRALUCE`;
- per `NUMEROANTE` validare il testo prima della conversione intera, evitando
  eccezioni generiche su input non numerico;
- inserire nel sorgente Core un commento esplicito **DA RIPORTARE NEL DESKTOP**,
  indicando l'originale
  `SorgentiTermodel/Library/leggidxf/LeggiDxf.cs`, dove è presente lo stesso
  difetto storico;
- non modificare la Library Desktop in questo incarico: resta sorgente di
  riferimento in sola lettura;
- non modificare frontend, contratto Frontend↔Service o
  `definizionedati.json`.

Risultato:
- corretto
  `src/Termodel.Core/CopiedFromTermodel/Leggidxf/LeggiDxf.cs`: i cinque
  attributi numerici FIN `ALTEZZA`, `LARGHEZZA`, `NUMEROANTE`,
  `SOTTOFINESTRA` e `SOPRALUCE` passano ora il vero `valore` a
  `Utigen.VerificaAttributoNumero(...)`;
- `NUMEROANTE` viene validato prima della conversione con
  `int.TryParse(..., CultureInfo.InvariantCulture)` e produce
  `InvalidDataException` leggibile se non è un intero;
- inserito nel punto della correzione il commento
  `TERMODEL-WEB FIX — DA RIPORTARE NEL DESKTOP`, con riferimento esplicito a
  `SorgentiTermodel/Library/leggidxf/LeggiDxf.cs`;
- la Library Desktop **non è stata modificata**: conserva intenzionalmente il
  difetto come riferimento storico finché la correzione non verrà riportata
  nella versione Desktop;
- verifica statica: 0 chiamate FIN residue che passano
  `DatiFinestra.Tipo`; 5 chiamate corrette che passano `valore`;
- **compilazione:** GitHub Actions `TermodelService Build` run **#69** sul
  commit `fa71bd4cee4968a7f57ad3458ba883f0d6c4e262`: Build Release
  completata con successo;
- **smoke HTTP:** nello stesso run #69 lo step
  `Smoke test HTTP project storage and exclusive locks` è completato con
  successo;
- l'SVG consolidato dell'esempio `Appartamento` è stato verificato: i FIN
  contengono valori numerici reali (ad es. `LARGHEZZA,207.55`,
  `LARGHEZZA,209.22`, ecc.); il precedente HTTP 422 dipendeva quindi dal
  bug Core e non dal dato dell'esempio;
- **test pubblico Appartamento:** non ancora dichiarato verificato dopo il fix;
  va rifatto dal frontend dopo il deploy Render;
- frontend, contratto Frontend↔Service e `definizionedati.json` non sono stati
  modificati in questo incarico;
- commit di codice:
  `fa71bd4cee4968a7f57ad3458ba883f0d6c4e262` —
  `Fix FIN numeric validation in Termodel Core`.

### INCARICO 2026-09-23 — esposizione TermodelLog per progetto
Stato: ESEGUITO

Commissionato:
- verificare il comportamento del logging del Desktop attraverso i sorgenti disponibili in `SorgentiTermodel/Library` e confrontarlo con l'adattatore headless corrente;
- non introdurre un secondo motore di log: riusare `TermodelLog` già chiamato dal codice Desktop/Core e la diagnostica prodotta da `GeneraModello`;
- persistere, a ogni `Aggiorna Modello` riuscito, il log applicativo corrente come `SavedProjects/{projectId}/logs/TermodelLog.md`, mantenendo `diagnostics.txt` e `calculation.log` per retrocompatibilità e metadati tecnici;
- aggiungere `GET /api/projects/{projectId}/logs/termodel` che restituisce il file di log corrente senza rieseguire il calcolo;
- il log deve essere isolato per projectId, sostituito atomicamente insieme al workspace corrente e sopravvivere al riavvio del Service finché persiste lo storage;
- verificare che `TermodelLog.Reset()` avvenga a inizio elaborazione e che `WriteLog`, `LogOperation` e `LogError` siano catturati;
- verificare le differenze residue rispetto al Desktop, in particolare la gestione delle categorie tramite `IsEnabled(...)`; non inventare configurazioni Desktop non presenti nella Library;
- non modificare frontend, `definizionedati.json` o Library Desktop in questo incarico.

Criteri di completamento:
- documentare cosa fa realmente il Desktop sulla base dei sorgenti disponibili e quali parti del logger Desktop non sono ancora presenti nella Library;
- build Release con 0 errori;
- smoke HTTP reale: calcolo di progetto, presenza fisica di `logs/TermodelLog.md`, GET del log con contenuto identico al file, 404 per progetto/log assente e lettura ancora riuscita dopo riavvio Service;
- verificare che una elaborazione fallita non sostituisca il log dell'ultimo calcolo riuscito;
- aggiornare contratto condiviso, README e questa voce a `Stato: ESEGUITO` soltanto dopo build e smoke riusciti.

Risultato:
- **verifica Desktop:** `SorgentiTermodel/Library/MainWindow.xaml.cs` chiama
  `TermodelLog.InitializeLog()` all'avvio e nuovamente prima di
  `Genera_modello()`; i sorgenti del motore usano diffusamente
  `WriteLog`, `LogOperation`, `LogError`, `LogContesto` e categorie
  specifiche. La documentazione Desktop identifica inoltre il file
  `Documenti\\Termodel\\TermodelLog.md` come log da analizzare;
- **limite di confronto:** l'implementazione sorgente Desktop della classe
  `TermodelLog` non è presente in `SorgentiTermodel/Library`: sono presenti
  i chiamanti, ma non il file che definisce persistenza e configurazione delle
  categorie. Non è quindi corretto dichiarare ancora equivalenza completa
  delle categorie verbose;
- **Core headless:** aggiunto `TermodelLog.InitializeLog()` come equivalente
  per-request di `Reset()`; `GeneraModello` lo chiama all'inizio di ogni
  elaborazione. `WriteLog`, `LogOperation` e `LogError` confluiscono
  nello stesso buffer `AsyncLocal`, isolato dalla richiesta corrente;
- `IsEnabled(...)` resta intenzionalmente `false` per i blocchi di debug
  condizionati (`colmi`, `spezza`, ecc.) finché non viene acquisita la
  configurazione Desktop autorevole; le normali chiamate di log restano attive;
- **persistenza:** `ProjectStore` scrive ora
  `SavedProjects/{projectId}/logs/TermodelLog.md` durante il publish
  transazionale dello stesso workspace; `diagnostics.txt` conserva lo stesso
  contenuto per retrocompatibilità, mentre `calculation.log` resta il log
  sintetico con projectId, data, stato e conteggi;
- **endpoint implementato:**
  `GET /api/projects/{projectId}/logs/termodel`; restituisce
  `text/markdown; charset=utf-8`, nome logico `TermodelLog.md` e header
  `X-Termodel-Artifact-Stale`; 404 se il progetto non dispone ancora del log;
- il GET legge esclusivamente il file persistito e non rilancia
  `GeneraModello`;
- un Salva/Salva con nome successivo mantiene il log dell'ultimo calcolo valido
  ma lo espone come stale; un nuovo calcolo riuscito lo sostituisce insieme al
  workspace corrente;
- una elaborazione fallita non pubblica lo staging e quindi conserva il
  `TermodelLog.md` dell'ultimo calcolo riuscito;
- README, contratto condiviso **v1.5** e `TERMODEL-SYNC.md` aggiornati;
- **compilato:** GitHub Actions `TermodelService Build` run **#91**, commit
  `72910f25ed86e6aeacb09b69bc88aa2f25768302`: step Build completato con
  successo;
- **eseguito/testato:** nello stesso run #91 lo smoke HTTP
  `Smoke test HTTP project storage and exclusive locks` è completato con
  successo e verifica: file fisico `TermodelLog.md` presente e non vuoto,
  uguaglianza con `diagnostics.txt`, GET 200 con contenuto identico,
  Content-Type markdown, stale=false subito dopo calcolo, 404 su log
  inesistente, calcolo volutamente invalido HTTP 422 senza modifica SHA-256 del
  log, stale=true dopo Salva con nome e lettura identica dopo riavvio del
  Service; anche lo smoke feedback GitHub è rimasto verde;
- **frontend:** non modificato;
- **Library Desktop:** non modificata;
- **definizionedati.json:** non modificato;
- commit principali:
  `3804348899c9af20448570532fd88ee8fb25f6d8`,
  `437e0d5e70c2292e7fdabe1b50994a3f58266e1f`,
  `deca7c459d3c4b0b6c1a9f724f58cf0477f14194`,
  `3f5f9a45bf69158895cb10bd817930bc03f7938a`,
  `c486e6d25db71e87b75fa6ca9eac09aad5371fa7`,
  `72910f25ed86e6aeacb09b69bc88aa2f25768302`,
  `9f1db6bf227549d699fc89e4234e735955b0ddd6`,
  `3e45258f546d48bfa00aacabddd060f3d2d51ec9`.

### INCARICO 2026-09-23 — inoltro suggerimenti utenti a GitHub
Stato: ESEGUITO

Commissionato:
- progettare e implementare in `Termodel.WebService` un servizio pubblico
  minimale che riceva suggerimenti/bug degli utenti e li inoltri a GitHub;
- usare **GitHub Issues** del repository `Fetonte1960/Termodel` come
  destinazione, evitando commit automatici nel branch `main` e senza
  richiedere un clone Git nel container Render;
- aggiungere `POST /api/feedback` con payload JSON limitato a testo, categoria,
  titolo opzionale e metadati client non sensibili;
- mantenere il token GitHub esclusivamente lato server tramite variabile
  d'ambiente/secret; il browser non deve mai ricevere credenziali GitHub;
- usare un token fine-grained con permesso minimo `Issues: Read and write`
  sul solo repository Termodel;
- accettare feedback soltanto dall'origine Web Termodel configurata, con
  validazione lunghezze/categorie e nessun invio automatico del file progetto,
  projectId, email, IP o altri dati personali nel corpo dell'Issue;
- prevedere protezione antispam/rate-limit in memoria adatta al pretest;
- rendere repository, API base GitHub e origine consentita configurabili per
  test/deploy, mantenendo default `Fetonte1960/Termodel` e
  `https://www.termodel.it`;
- il Service deve restare Linux/container compatible e non dipendere dal
  filesystem persistente Render;
- non modificare frontend in questo incarico: l'endpoint sarà pronto per una
  successiva UI `Invia suggerimento`.

Criteri di completamento:
- build Release con 0 errori;
- test HTTP reale dell'endpoint con GitHub API stub, verificando request issue
  e response `201 Created` senza usare credenziali reali;
- verifica rifiuto origine non autorizzata e payload non valido;
- verifica configurazione mancante → errore strutturato senza crash;
- documentare variabili ambiente e configurazione Render;
- aggiornare contratto condiviso e questa voce a `Stato: ESEGUITO` solo dopo
  build e smoke riusciti.

Risultato:
- **progettato/implementato:** aggiunto
  `src/Termodel.WebService/Feedback/GitHubFeedbackService.cs` e
  `POST /api/feedback`; il Service crea una GitHub Issue nel repository
  configurato, senza eseguire commit, `git push` o richiedere un clone Git;
- il payload accetta `message/category/title/page/appVersion`; categorie:
  `suggestion`, `bug`, `question`, `other`; sono applicati limiti di
  lunghezza e titolo automatico quando manca;
- il campo `page` perde query string e fragment prima dell'invio; il testo
  disarma le mention `@`; non vengono aggiunti automaticamente file progetto,
  `projectId`, email, cookie o IP al corpo dell'Issue;
- il token GitHub resta esclusivamente lato server tramite
  `TERMODEL_FEEDBACK_GITHUB_TOKEN`; repository, origine autorizzata e API base
  sono configurabili con `TERMODEL_FEEDBACK_REPOSITORY`,
  `TERMODEL_FEEDBACK_ALLOWED_ORIGIN` e
  `TERMODEL_FEEDBACK_GITHUB_API_BASE_URL`;
- default: repository `Fetonte1960/Termodel`, origine
  `https://www.termodel.it`, API `https://api.github.com`;
- previsto fine-grained PAT limitato al solo repository con permesso minimo
  **Issues: Read and write**; nessuna credenziale è presente nel repository;
- origine diversa da quella configurata → 403; payload non valido → 400;
  configurazione/token assenti → 503; errore/rete GitHub → 502;
- rate-limit in memoria: massimo 5 feedback per client/10 minuti e 100 globali/
  ora; superamento → 429 con `Retry-After`;
- README e contratto condiviso **v1.4** documentano endpoint, errori,
  configurazione Render e regole di privacy/sicurezza;
- aggiunto `tests/github_feedback_stub.py` e nuovo smoke end-to-end nel
  workflow GitHub Actions; lo stub simula la REST API Issues senza usare
  credenziali reali;
- **compilato:** GitHub Actions run **#82**, commit
  `0989c0e967bcc86edb909a3cbb73498be4b2c658`: build Release riuscita,
  **153 warning, 0 errori**;
- **eseguito/testato:** nello stesso run il WebService ASP.NET è stato avviato
  realmente e lo smoke ha concluso con `GITHUB_FEEDBACK_SMOKE_OK`,
  `issueNumber=4242`; verificati anche il precedente
  `PROJECT_LOCK_SMOKE_OK`, origine non autorizzata 403, payload invalido 400,
  creazione Issue simulata 201, path/API/header GitHub, rimozione query dalla
  pagina, rate-limit 429 e configurazione senza token 503;
- **GitHub reale/Render:** non è stata ancora creata una Issue reale tramite
  Render, perché il secret `TERMODEL_FEEDBACK_GITHUB_TOKEN` deve essere
  configurato esplicitamente nell'hosting; non dichiarare questo livello come
  verificato finché non viene eseguita una prova reale;
- **frontend:** non modificato in questo incarico; la futura UI
  `Invia suggerimento` dovrà limitarsi a chiamare `POST /api/feedback`;
- **confronto con riferimento Desktop:** non applicabile, perché questa è una
  funzione di trasporto/WebService senza algoritmo Desktop;
- commit principali:
  `3351bd74540dfe43c79a881ad5fe6288af77d84a`,
  `9d68b0f05499973cc3e9ea3b363d2b5d613c9d43`,
  `01f9899cffa590bc9a9647e675b057589c3a9ca9`,
  `aaf0444d77ecce930307d35419e9203798507ae9`,
  `52b6460a3e745940a019aae37ddb7d289bb120b0`,
  `0989c0e967bcc86edb909a3cbb73498be4b2c658`.
### INCARICO 2026-09-22 — gestione progetti server e apertura esclusiva
Stato: ESEGUITO

Commissionato:
- implementare lato Termodel.WebService le operazioni server per elenco/apertura,
  Salva, Salva con nome, heartbeat, chiusura e sblocco controllato dei progetti;
- i file persistenti del progetto devono restare sotto
  `SavedProjects/{projectId}/`; il frontend non deve conoscere il path fisico;
- impedire la doppia apertura in modifica dello stesso projectId con lock
  esclusivo e risposta HTTP 423 `Il progetto è già in uso.`;
- consentire contemporaneamente l'apertura di projectId differenti;
- usare un token di lock temporaneo, non persistente nel manifest e non
  assimilabile a calculationId;
- implementare lease/heartbeat e recovery dei lock impropri dovuti a chiusura
  browser, crash, rete o riavvio Service;
- prevedere sblocco controllato: automatico per lock stale, esplicito/forzato
  solo su richiesta confermata per lock ancora vivo;
- proteggere Salva, Salva con nome e Aggiorna Modello con il lock del progetto;
- `Salva con nome` conserva projectId e modifica soltanto il nome leggibile;
- mantenere separati Salva e Aggiorna Modello, marcando gli artifact come
  stale dopo un salvataggio non seguito da ricalcolo;
- non modificare frontend, Termodel.Core, Library o `definizionedati.json`
  durante questo incarico server.

Criteri di completamento:
- build Release della soluzione con 0 errori;
- test HTTP reale di due aperture concorrenti dello stesso progetto con una
  sola riuscita e seconda risposta 423;
- test di apertura simultanea di due projectId differenti;
- test Salva e Salva con nome con verifica del file `project.tmdl` su disco;
- test che Salva con nome conservi il projectId;
- test heartbeat e chiusura/rilascio lock;
- test recovery di lock stale/improprio e riapertura successiva;
- test sblocco controllato e protezione dei file validi;
- test che `POST /api/calculations` rifiuti un token non valido e accetti il
  possessore del lock;
- aggiornare contratto condiviso con endpoint definitivi e questa stessa voce
  a `Stato: ESEGUITO` soltanto dopo i test reali.

Risultato:
- **implementato** lato `Termodel.WebService` con `ProjectStore`,
  `ProjectLockManager` e API server-owned per elenco/apertura, Salva, Salva con
  nome, heartbeat, close, unlock e `POST /api/calculations` protetto dal lock;
- aggiunti endpoint:
  `GET /api/projects`,
  `POST /api/projects/{projectId}/open`,
  `PUT /api/projects/{projectId}/save`,
  `PUT /api/projects/{projectId}/save-as`,
  `POST /api/projects/{projectId}/heartbeat`,
  `POST /api/projects/{projectId}/close`,
  `POST /api/projects/{projectId}/unlock`;
- `POST /api/projects/allocate-id` restituisce anche il lock iniziale;
- token lock trasmesso tramite header `X-Termodel-Project-Lock`; non entra nel
  manifest e non sostituisce `projectId`;
- doppia apertura dello stesso progetto → HTTP 423; progetti differenti possono
  essere aperti contemporaneamente;
- lease lock configurabile con `TERMODEL_PROJECT_LOCK_LEASE_SECONDS`, heartbeat,
  scadenza automatica e recupero dei lock residui dopo crash/riavvio;
- `Salva` e `Salva con nome` persistono `project.tmdl` nella cartella progetto;
  `Salva con nome` conserva il projectId e modifica il nome leggibile;
- salvataggi senza ricalcolo marcano gli artifact come stale tramite
  `project-state.json`; il GET model3d espone `X-Termodel-Artifact-Stale`;
- `POST /api/calculations` richiede un lock valido e pubblica di nuovo artifact
  coerenti/non stale;
- **compilato/eseguito/testato:** GitHub Actions run #62 sul commit
  `cee1343106d2c09864d3c45161701c737d809447` completato con successo;
- verifica nuovamente superata nel run #63 del commit
  `a6aada8df28347cc3d753be86c3a26bf8146638c` con
  `PROJECT_LOCK_SMOKE_OK`; build e smoke HTTP completi riusciti;
- lo smoke verifica realmente doppia apertura 423, apertura simultanea A/B,
  lock errato su calcolo, Salva, Salva con nome, stale artifact, heartbeat,
  sblocco con conferma/force, scadenza lease e recovery dopo restart;
- frontend, Core, Library e `definizionedati.json` non sono stati modificati
  durante l'incarico server;
- confronto Desktop non applicabile alla gestione lock/filesystem; il motore
  algoritmico Core non è stato modificato.

### INCARICO 2026-09-23 — pretest remoto Render e collegamento frontend
Stato: ESEGUITO

Commissionato:
- registrare il nuovo Termodel.WebService pubblico di pretest su
  `https://termodel.onrender.com`, repository `Fetonte1960/Termodel`, branch
  `main`, deploy Docker/Linux/.NET 8;
- considerare Render Free esclusivamente ambiente di collaudo: filesystem
  effimero, `SavedProjects` non definitivo e cold-start dopo inattività;
- mantenere `projectId` come unico identificatore persistente dominante e non
  reintrodurre `calculationId`;
- adeguare il frontend pubblico `https://www.termodel.it` a usare come base URL
  primaria il Service HTTPS Render, mantenendo la possibilità di override per
  sviluppo locale;
- adeguare `Aggiorna Modello` al contratto corrente projectId +
  `X-Termodel-Project-Lock`, rimuovendo le aspettative frontend sul vecchio
  `calculationId`;
- collegare almeno creazione/allocazione projectId, elenco/apertura progetto,
  Salva, Salva con nome, heartbeat/close lock e recupero model3d alle API
  server già implementate;
- PC e Web mobile devono usare lo stesso endpoint pubblico; non introdurre
  dipendenze da un PC locale per il pretest remoto;
- preservare CORS per `https://www.termodel.it`, compatibilità Linux/container
  e porta dinamica `PORT`; non introdurre percorsi Windows;
- non trasformare la persistenza effimera Render Free in una nuova architettura
  di storage.

Criteri di completamento:
- frontend su main usa `https://termodel.onrender.com` come default Service;
- codice frontend non usa più `calculationId` nel workflow corrente;
- chiamate mutanti inviano il lock token corretto;
- apertura e salvataggio progetto passano dalle API Service;
- heartbeat e rilascio lock sono gestiti dal frontend;
- build/smoke Service continuano a riuscire;
- aggiornare contratto e Summary con distinzione fra implementato e verificato
  realmente sul frontend pubblico/mobile.

Risultato:
- **deploy Service:** aggiunto `Server/Termodelwebservice/Dockerfile` nel commit
  `a6aada8df28347cc3d753be86c3a26bf8146638c`; usa immagini .NET 8 Linux,
  publish Release e `ASPNETCORE_URLS=http://0.0.0.0:${PORT:-10000}`, quindi
  non fissa una porta incompatibile con Render;
- **pretest remoto:** l'utente ha verificato il deploy Render pubblico
  `https://termodel.onrender.com`, con `/` e `/health` rispondenti; region
  Frankfurt, piano Free. Questa istanza resta esplicitamente non produttiva;
- filesystem Render Free registrato come effimero: `SavedProjects` serve solo
  al collaudo e non è archivio definitivo dei progetti clienti;
- contratto condiviso aggiornato a **v1.3** con base URL remota, endpoint di
  progetto/lock, vincoli Linux/container, `PORT`, CORS e cold-start Render;
- **frontend implementato:** Termodel Web **v0.95** usa
  `https://termodel.onrender.com` come base URL predefinita mantenendo
  `globalThis.TERMODEL_SERVICE_BASE_URL` come override;
- rimosso `calculationId` dal workflow frontend corrente; il redraw Service
  usa `projectId` e l'href `model3d` restituito da `POST /api/calculations`;
- Nuovo progetto alloca `projectId`/lock e salva il progetto sul Service;
- `File → Apri` usa `GET /api/projects` + `POST /api/projects/{projectId}/open`;
- `Salva` e `Salva con nome` usano le API server e non il download browser come
  storage operativo; Save As conserva lo stesso projectId;
- il frontend mantiene `projectLockToken` solo in memoria, invia
  `X-Termodel-Project-Lock`, esegue heartbeat ogni 45 s e tenta close con
  `keepalive` su `pagehide`;
- `Aggiorna Modello` richiede/riusa il lock, invia il payload tecnico filtrato
  e recupera l'artifact `model3d` corrente;
- il badge 3D mostra `projectId` invece del vecchio calculationId;
- **GitHub Actions Service run #64:** build + smoke completi riusciti, con
  `PROJECT_LOCK_SMOKE_OK`; conferma che le modifiche documentali/frontend non
  hanno rotto il Service;
- **GitHub Pages run #629:** deploy del frontend v0.95 riuscito;
- **non ancora verificato manualmente:** intero round-trip sul sito pubblico,
  Android/mobile reale, doppia apertura da due pagine reali e comportamento
  sleep/wakeup Render. Questi restano test di collaudo utente, non condizioni
  già dichiarate superate;
- nessuna dipendenza da percorsi Windows introdotta; Core, Library e
  `definizionedati.json` non sono stati modificati;
- commit frontend principali:
  `4c9f9e2e591d78f6fd8073096bf734b224409e85` e
  `92664a593846456bcf89065b0001de2807392227`.
- **completamento frontend v0.96:** aggiunto preflight
  `GET /health → GET /api/model/capabilities` prima delle operazioni server,
  con progress di wake-up Render, timeout 90 s e cache readiness 60 s;
- il messaggio di cold start è comune a PC/mobile e scompare al completamento;
- un projectId presente nel file ma non più disponibile sul filesystem
  effimero Render genera un errore esplicito e non viene sostituito
  automaticamente;
- verifica statica JavaScript superata; il round-trip pubblico/mobile e il
  vero sleep/wakeup restano prove runtime da eseguire e non sono dichiarati
  verificati.
### INCARICO 2026-09-22 — projectId unico, persistenza corrente e rimozione calculationId
Stato: ESEGUITO

Questa commissione **sostituisce integralmente** le due precedenti proposte
2026-09-22 sulla persistenza per elaborazione e sulla coesistenza
`projectId`/`calculationId`.

Decisione definitiva:
- `projectId` è l'unico identificatore operativo e persistente del progetto;
- il concetto `calculationId` deve essere eliminato dal nuovo contratto, dalla
  response di `AggiornaCalcolo`, dalle route artifact e dalla persistenza;
- ogni nuova elaborazione riuscita dello stesso `projectId` ricopre i dati
  prodotti dall'elaborazione precedente;
- non viene mantenuto automaticamente uno storico delle elaborazioni.

Commissionato:
- implementare `POST /api/projects/allocate-id` per generare e riservare un
  nuovo `projectId` univoco rispetto ai progetti già presenti, con sicurezza
  anche in caso di richieste concorrenti;
- il Service restituisce il nuovo ID ma non modifica implicitamente il file
  progetto; il frontend lo consoliderà come `manifest.projectId` top-level del
  `TERMODEL-PROJECT-TEXT-V1`;
- `POST /api/calculations` deve leggere e validare `manifest.projectId`; nel
  nuovo flusso un progetto senza ID deve essere prima consolidato dal
  frontend tramite `allocate-id`; non assegnare ID silenziosamente durante il
  calcolo;
- eliminare dalla response di `POST /api/calculations` il riferimento
  `calculationId`; restituire `projectId`, stato, artifact disponibili e
  diagnostica;
- eliminare il modello pubblico di artifact basato su
  `/api/calculations/{calculationId}/artifacts/...` e introdurre le route
  correnti basate sul progetto, a partire da
  `GET /api/projects/{projectId}/artifacts/model3d`;
- il GET artifact deve leggere il file/risultato già prodotto e non deve
  rieseguire `GeneraModello`;
- sostituire o rimuovere `CalculationSnapshotStore` e gli altri componenti
  introdotti esclusivamente per la gestione del `calculationId`, salvo
  eventuali dettagli interni temporanei che non espongano né mantengano il
  concetto nel contratto e che risultino realmente necessari durante la
  migrazione; l'obiettivo finale è non avere un secondo identificatore;
- usare una sola directory persistente per progetto:
  ```text
  SavedProjects/
  └── {projectId}/
      ├── project.tmdl
      ├── artifacts/
      │   ├── model3d.json
      │   └── ... artifact correnti
      └── logs/
          └── ... diagnostica/log correnti
  ```
- ogni `AggiornaCalcolo` riuscito dello stesso projectId deve aggiornare
  atomicamente quella stessa cartella, sostituendo progetto, artifact e log
  precedenti con i nuovi valori;
- l'elaborazione fallita non deve distruggere l'ultimo stato valido. Può
  aggiornare un log di ultimo errore separato, ma non deve pubblicare output
  parziali come stato corrente;
- materializzare almeno `artifacts/model3d.json` e predisporre la stessa
  struttura per piante pulite, XML nazionale, dispersioni, pannelli, spirali,
  DXF e altri artifact futuri;
- `project.tmdl` deve restare la copia UTF-8 del projectText tecnico realmente
  ricevuto ed elaborato con successo, senza sfondi esclusivamente frontend;
- mantenere la root configurabile tramite `TERMODEL_SAVED_PROJECTS_DIR`;
- non modificare `definizionedati.json` e non spostare nel WebService logica
  appartenente al Core.

Criteri di completamento:
- build completa della soluzione riuscita;
- due richieste anche concorrenti a `POST /api/projects/allocate-id` producono
  due projectId differenti e già riservati;
- un progetto con `manifest.projectId=A` produce/aggiorna soltanto
  `SavedProjects/A/`;
- due `POST /api/calculations` successivi con lo stesso projectId non creano
  alcun secondo identificatore e non creano cartelle storiche: la seconda
  elaborazione ricopre i valori persistiti dalla prima;
- la response di `POST /api/calculations` non contiene `calculationId`;
- `GET /api/projects/A/artifacts/model3d` restituisce il `model3d.json`
  corrente senza ricalcolo;
- un secondo progetto con `projectId=B` resta isolato in `SavedProjects/B/`;
- riavviando il WebService gli artifact persistiti restano leggibili tramite
  projectId;
- una elaborazione fallita non sostituisce `project.tmdl` e artifact
  dell'ultima elaborazione riuscita;
- verificare che non restino dipendenze funzionali necessarie dal precedente
  `calculationId` nei nuovi endpoint/DTO/manifest di risposta;
- aggiornare/adeguare i test HTTP e automatici al contratto projectId;
- documentare separatamente compilazione, test, endpoint realmente eseguiti,
  filesystem verificato, artifact e log;
- a lavoro concluso aggiornare questa stessa voce a `Stato: ESEGUITO` con
  risultato reale e commit.

Risultato:
- **implementato:** aggiunti
  `src/Termodel.WebService/Projects/ProjectStore.cs` e
  `ProjectRequestIdentity.cs`; il WebService legge
  `manifest.projectId` dal file unico tramite `ProjectTextDocument` senza
  modificare Termodel.Core;
- implementato `POST /api/projects/allocate-id`: genera GUID, ne riserva
  l'unicità su filesystem e usa `FileMode.CreateNew` per rendere la
  prenotazione sicura anche fra richieste concorrenti; gli ID già persistiti o
  già riservati vengono esclusi;
- `POST /api/calculations` rifiuta con HTTP 422 un progetto senza
  `manifest.projectId` o con ID non allocato dal Service; non assegna ID
  implicitamente;
- la response di `POST /api/calculations` contiene `projectId`,
  `status`, `savedProject.fileName = project.tmdl`, artifact e diagnostica;
  **non contiene più `calculationId`**;
- il workspace corrente è
  `SavedProjects/{projectId}/` con
  `project.tmdl`, `artifacts/model3d.json`,
  `logs/calculation.log` e `logs/diagnostics.txt`;
- ogni aggiornamento riuscito prepara una directory staging e poi sostituisce
  la directory corrente con swap staging/backup; il backup non è storico e
  viene eliminato dopo il commit;
- due elaborazioni dello stesso projectId sono serializzate nel processo
  Service tramite lock per-project, evitando scritture concorrenti sullo
  stesso workspace;
- se `GeneraModello` fallisce, il publish non parte e l'ultimo workspace
  valido resta intatto; lo smoke ha verificato hash invariati di progetto,
  model3d e log dopo un calcolo volutamente fallito;
- implementato
  `GET /api/projects/{projectId}/artifacts/model3d`: legge esclusivamente
  `artifacts/model3d.json` dal disco e non richiama `GeneraModello`;
- rimossi `CalculationSnapshotStore.cs` e il precedente
  `SavedProjectStore.cs`; rimossa la route
  `/api/calculations/{id}/artifacts/model3d`;
- gli endpoint legacy indipendenti dal nuovo modello
  `POST /api/model/3d` e `GET /api/model/clean-floor/{floorName}`
  restano disponibili;
- nessuna modifica a frontend, Termodel.Core, Library o
  `definizionedati.json`;
- **compilato:** GitHub Actions TermodelService Build run **#50**, commit
  `8e29e9a2f988a7d0ff24f111727f89f2aee75c07`: build Release riuscita,
  **154 warning, 0 errori**;
- **eseguito/testato:** nello stesso run il WebService è stato avviato
  realmente e lo smoke `PROJECTID_SMOKE_OK` ha verificato:
  12 `allocate-id` concorrenti tutti distinti, rifiuto di ID non riservato,
  progetto A V1 → A V2 nella stessa singola cartella, sostituzione effettiva
  di `project.tmdl`, `model3d.json` e `calculation.log`, assenza di
  directory staging/backup residue, protezione dell'ultimo stato valido su
  elaborazione fallita, isolamento del progetto B, rimozione della vecchia
  route per-elaborazione e lettura identica degli artifact A/B dopo riavvio
  del Service;
- projectId reali esercitati nello smoke run #50:
  `ceb9463f-3635-4f22-8fb1-aa7902eac931` e
  `4b2a336c-a00f-4dd2-ab3e-115168a4a36c`;
- **confronto con riferimento Desktop:** non applicabile alla persistenza;
  il motore `GeneraModello` non è stato modificato e il confronto golden
  geometrico resta un'attività separata;
- contratto projectId-only aggiornato a versione documento **1.0** nel commit
  `9c70c2b8b454b0d6ebe9a8276eff7cc6dacd6400`; le successive regole
  Apri/Salva server-owned e mobile open-only sono registrate nel contratto **1.1**; la successiva apertura esclusiva e il recovery dei lock impropri sono registrati nel contratto **1.2**;
- commit tecnici principali:
  `f26de11c61ba2815a6ae9e7609e942ff6fb771b2`,
  `039f228039e85f79315b6126f84fe770f5c1f501`,
  `20a86414b690b0f76014a3d14f5c5f8483f8ac9b`,
  `c3c448505ce662a54ff36f3128e9105ad0ffad74`,
  `5700a7c9f1bd02bb74cbc0c67ca94e5bf1aaff68`,
  `211c47b4e00a8dacc1ea851d0425f51f564cafcf`,
  `fe1dc32909d7124b31bec7247084724b8cb49d5f`,
  `8e29e9a2f988a7d0ff24f111727f89f2aee75c07`.

### DECISIONE 2026-09-22 — Apri/Salva progetto gestiti dal Service; mobile open-only

Registrato nel contratto condiviso v1.1:
- nel profilo Web/PC con Termodel.WebService, `Apri progetto`,
  `Salva progetto` e `Salva progetto con nome` sono operazioni di
  persistenza del **Service**, non accessi diretti al filesystem dal frontend;
- il frontend presenta selezione/nome e scambia il
  `TERMODEL-PROJECT-TEXT-V1`, mentre il Service enumera, legge e scrive i
  progetti sul proprio storage;
- `Salva progetto` conserva il `projectId`;
- `Salva progetto con nome` conserva anch'esso il `projectId` e modifica il
  nome/collocazione logica; non equivale a duplicare un progetto;
- una futura `Duplica come nuovo progetto` dovrà ottenere un nuovo
  `projectId`;
- salvataggio del progetto e `Aggiorna Modello` restano operazioni distinte:
  dopo un salvataggio successivo all'ultimo calcolo gli artifact precedenti
  devono essere considerati **stale** finché non vengono rigenerati;
- nella versione mobile/serverless, per questa fase, resta soltanto
  `Apri progetto` tramite host/app e file picker locale; `Salva progetto`,
  `Salva con nome` e catalogo/cartelle server non sono esposti;
- i nomi definitivi delle nuove route HTTP Apri/Salva/Salva con nome non sono
  ancora fissati: questa voce registra il contratto di responsabilità, non
  dichiara tali API implementate;
- nessuna modifica a frontend, Core, Library o `definizionedati.json` in
  questa registrazione.

### DECISIONE 2026-09-22 — cartella progetto, apertura esclusiva e recovery lock

Registrato nel contratto condiviso v1.2:
- tutti i file persistenti del progetto restano reperibili sotto
  `SavedProjects/{projectId}/`; eventuali workspace/staging sono tecnici,
  temporanei e non costituiscono una seconda copia autorevole;
- nel profilo Web/PC con Service, lo stesso `projectId` può essere aperto in
  modifica da una sola pagina/sessione alla volta;
- una seconda apertura concorrente dello stesso progetto deve essere rifiutata
  con HTTP `423 Locked` e messaggio utente `Il progetto è già in uso.`;
- progetti diversi possono restare aperti contemporaneamente;
- l'apertura può restituire un `projectLockToken` opaco e temporaneo, che non
  entra nel manifest e non costituisce un secondo identificatore persistente;
- Salva, Salva con nome, Aggiorna Modello e Chiudi progetto dovranno essere
  autorizzati soltanto dalla sessione che possiede il lock valido;
- il lock deve essere una lease rinnovabile con heartbeat/ultima attività,
  non un flag permanente senza scadenza;
- lock scaduti o abbandonati devono essere recuperabili automaticamente dal
  Service; un riavvio del Service deve poter riconoscere lock non più validi
  senza alterare i file del progetto;
- nei casi dubbi è prevista una futura funzione controllata `Sblocca progetto`;
  se il lock appare ancora vivo/recente, lo sblocco forzato richiede conferma
  esplicita;
- lo sblocco può rimuovere soltanto lock e workspace temporanei abbandonati,
  mai `project.tmdl`, artifact validi o log correnti;
- questa è una decisione di contratto; le API di apertura/heartbeat/chiusura
  e sblocco non sono ancora dichiarate implementate.
### INCARICO 2026-09-21 — Invarianza Polig3D e TermodelWebModel v3 completo
Stato: ESEGUITO

Commissionato:
- riportare `Polig3D` del Core verso il comportamento e la struttura del
  Desktop, evitando la versione semplificata che perde
  `ElementoAssociato/ElementiAssociati`;
- conservare nel Core i metadati semantici necessari a filtri, XML e calcoli:
  piano, confine, separatore, stessaZona, fittizia e falda;
- usare la stessa strategia già adottata per `LeggiDxf`: mantenere il più
  possibile invariata la classe strategica e sostituire solo le dipendenze
  UI/rendering con facciate headless;
- usare xBIM reale come supporto dati IFC in memoria se necessario, senza
  introdurre un secondo motore geometrico o un falso xBIM esteso;
- fare produrre al Core un unico `TermodelWebModel v3` semanticamente
  compatibile con `SorgentiTermodel/Work/Web/DrawBimJson.cs`, senza creare
  formati JSON alternativi;
- mantenere compatibili gli endpoint legacy durante l'intervento;
- non modificare frontend né contratto condiviso salvo necessità esplicita.

Criteri di completamento:
- soluzione Service compilata da GitHub Actions con 0 errori;
- DTO/artifact `TermodelWebModel v3` con i metadati avanzati espliciti;
- semantica di `numero/source/parte` riallineata al riferimento Desktop per
  quanto esercitato dal motore Core;
- stato e limiti reali documentati, distinguendo build, esecuzione HTTP e
  confronto golden;
- aggiornamento della stessa voce a `ESEGUITO` solo a lavoro concluso.

Risultato:
- `CopiedFromTermodel/Model/Polig3D.cs` è ora una copia **byte-per-byte
  identica** a `SorgentiTermodel/Library/leggidxf/Polig3D.cs`; entrambi hanno
  Git blob SHA `d7d835a8a39febb3c3b26bcb88a8cc5cebb19411`;
- il Core usa `Xbim.Essentials 6.1.605` come struttura IFC in memoria richiesta
  dal codice Desktop; non viene prodotto né richiesto un file IFC come artifact;
- WPF/MainWindow/filtri/DrawBim sono sostituiti da facciate headless limitate
  alla superficie richiesta da `Polig3D`;
- `Polig3D.ElementiAssociati`, `Separatore`, `StessaZona`, `Falda`,
  `NomePiano` e le relazioni semantiche Desktop sono conservati e alimentano
  il renderer headless;
- `TermodelWebModel v3` espone campi espliciti
  `filterMetadata/piano/confine/separatore/stessaZona/fittizia/falda`;
- il renderer headless conserva per le primitive generate da
  `DrawPolyEstruso` la semantica Desktop `source=ExtrudedVisual3D,
  parte=lati` e `source=MeshGeometry3D, parte=tappi`, mantenendo
  `numero` uguale all'indice 1-based dell'ElementoAssociato usato dal redraw
  Desktop;
- `Modello.Close_modello` esegue `Polig3D.TrovaConfini` e poi
  `Polig3D.GrafRedraw(... forzaModello3D:true)`, quindi il JSON deriva dal
  catalogo semantico dopo l'analisi confini;
- build GitHub Actions sul commit
  `9eb3ddfccb09d0d610e531c21495456924b2107b`: **0 errori, 154 warning**;
- workflow esteso con smoke HTTP nel commit
  `297d593be6b7e205e3dcb9052d8f6a13cf2878e6`: build riuscita e percorso
  `POST /api/projects/new -> POST /api/model/3d` eseguito con successo sul
  progetto vuoto, verificando `TermodelWebModel v3`, `Z-up` e 0 primitive;
- confronto golden avanzato con le 546 primitive del progetto mansardato:
  **non ancora eseguito**, perché manca ancora il corrispondente file unico SVG
  multipiano utilizzabile dal Service.



### INCARICO 2026-09-21 — Prova AggiornaCalcolo e artifact model3d v3
Stato: ESEGUITO

Commissionato:
- esporre il primo ciclo reale del contratto `AggiornaCalcolo` senza ancora
  integrare XML nazionale, dispersioni o pannelli;
- implementare `POST /api/calculations` con body
  `TERMODEL-PROJECT-TEXT-V1` in `text/plain; charset=utf-8`;
- eseguire una sola volta il motore corrente `GeneraModello`, creare un
  `calculationId` e catturare nello snapshot il `TermodelWebModel v3`
  avanzato già prodotto dal Core;
- esporre
  `GET /api/calculations/{calculationId}/artifacts/model3d` in modo che
  restituisca il JSON già catturato senza rieseguire il calcolo;
- restituire da `POST /api/calculations` almeno
  `contractVersion/calculationId/status/artifacts/diagnostics`;
- mantenere invariati e funzionanti gli endpoint legacy
  `POST /api/model/3d` e `GET /api/model/clean-floor/{floorName}`;
- usare storage temporaneo in memoria per questa prima prova, isolato per
  `calculationId`, senza introdurre persistenza prematura;
- aggiungere uno smoke test HTTP automatico che verifichi creazione progetto,
  aggiornamento, manifest e doppia lettura dell'artifact model3d dallo stesso
  snapshot.

Criteri di completamento:
- build GitHub Actions con 0 errori;
- `POST /api/calculations` eseguito realmente nello smoke test;
- risposta contenente un `calculationId` e href `model3d`;
- `GET .../artifacts/model3d` eseguito almeno due volte sullo stesso id con
  JSON v3 valido e senza nuova elaborazione;
- stato, limiti e commit registrati qui prima di passare a `ESEGUITO`.

Risultato:
- implementato `CalculationSnapshotStore` nel WebService come storage
  temporaneo in memoria, indicizzato per `Guid calculationId`;
- `POST /api/calculations` esegue `GeneraModello.GeneraAsync` una sola volta,
  serializza immediatamente il `TermodelWebModel v3` in byte JSON e registra
  quei byte nello snapshot;
- la risposta di `POST /api/calculations` contiene
  `contractVersion = TERMODEL-FRONT-SERVICE-V1`, `calculationId`,
  `status = completed`, manifest dell'artifact `model3d` e diagnostica;
- implementato
  `GET /api/calculations/{calculationId}/artifacts/model3d`: legge soltanto
  i byte JSON già catturati e non richiama `GeneraModello`;
- snapshot inesistente restituisce Problem Details HTTP 404;
- gli endpoint legacy `POST /api/model/3d` e
  `GET /api/model/clean-floor/{floorName}` sono rimasti disponibili;
- il workflow GitHub Actions è stato esteso per esercitare sia il percorso
  legacy sia il nuovo ciclo
  `/api/projects/new -> /api/calculations -> GET model3d -> GET model3d`;
- GitHub Actions run #23 sul commit
  `2cb8b15860f39e475ada2fda3d61c9dbd6dfa600`: **build riuscita,
  0 errori, 154 warning; smoke HTTP riuscito**;
- lo smoke verifica un `calculationId` reale, un manifest con href
  `model3d`, `TermodelWebModel v3`, coordinate `Z-up`, 0 primitive sul
  `ProgettoVuoto` e identità byte-per-byte delle due letture successive
  dello stesso artifact;
- il primo tentativo sul commit
  `ee02243a2e8b4c7b38d6ad4cc41b20f356b0eecc` aveva un solo errore di
  overload `Results.Bytes`; corretto nel commit `2cb8b158...`;
- contratto condiviso aggiornato alla versione documento 0.3 nel commit
  `70647ecd502e843bff7944ae125c29c0d67a51a2` per indicare che il ciclo
  `model3d` è ora operativo;
- **non ancora eseguito** il test con un progetto geometrico non vuoto né il
  confronto golden da 546 primitive; il JSON avanzato è compilato ed esposto,
  ma i metadati per primitive reali devono ancora essere esercitati con un
  file unico di prova rappresentativo;
- esecuzione locale Visual Studio/browser: **effettuata il 21 settembre 2026**.
  `GET /api/model/capabilities` ha risposto su `http://localhost:5080`;
  il frontend pubblico ha poi completato
  `POST /api/calculations -> calculationId -> GET artifact model3d`.
  Il primo progetto reale provato ha restituito **0 primitive e 19
  diagnostiche**: comunicazione e snapshot sono quindi raggiunti realmente,
  ma la correttezza geometrica non è ancora verificata e le diagnostiche
  devono essere analizzate.


### INCARICO 2026-09-21 — SVG tecnico canonico frontend per AggiornaCalcolo
Stato: ESEGUITO

Commissionato:
- correggere la prima anomalia runtime reale di `POST /api/calculations`,
  dove `SvgDxfReader` rifiutava `geometry/project.svg` perché il frontend
  aveva sostituito lo SVG tecnico del progetto con lo SVG operativo CAD/AI;
- mantenere invariato lo SVG locale del CAD;
- generare per il solo payload server uno SVG `TERMODEL-PROJECT-SVG-V1`
  canonico in centimetri, con gruppi piano e metadati richiesti dal Core;
- non rilassare la validazione del server.

Risultato:
- prima prova locale reale: `GET /api/model/capabilities` raggiunto con
  successo e `POST /api/calculations` arrivato fino a `SvgDxfReader`;
- l'errore runtime osservato era
  `Lo SVG deve dichiarare data-termodel-units='cm'.`;
- Termodel Web v0.73 costruisce ora il solo payload server in forma canonica,
  lasciando invariato lo SVG operativo del CAD;
- radice SVG: `TERMODEL-PROJECT-SVG-V1`, namespace SVG, unità `cm`;
- gruppi piano: `floor-id/name/role/file/layer/order` derivati da
  manifest/archivio Piani;
- entità trasferite: `line` e blocchi `text` tecnici; sfondi/accessori
  frontend esclusi;
- adattati anche, se presenti, tipo linea e colore locali ai nomi letti da
  `SvgDxfReader`;
- manifest/hash rigenerati sul payload finale;
- sintassi JavaScript verificata;
- commit principali frontend:
  `753d12050f73e91a3134000400927bfadfe5e960`,
  `07f460deeb6a96b69ec5df08a055665fd4fcebe2`,
  `ce3ed27f08a6a466a12e4a9721ceecf91b574cb5`,
  `cf90174307eda011fc78aa568917b369d810f63c`;
- nuova prova runtime v0.73 sul PC: **non ancora eseguita**; non dichiarare
  ancora superata la validazione HTTP finché l'utente non ripete il test.



### INCARICO 2026-09-22 — Salvataggio automatico progetto ricevuto da Aggiorna Modello
Stato: ESEGUITO

Commissionato:
- a ogni `POST /api/calculations` elaborato con successo salvare su disco una
  copia UTF-8 del `projectText` `TERMODEL-PROJECT-TEXT-V1` ricevuto,
  senza rigenerarlo e senza aggiungere sfondi frontend;
- associare senza ambiguità il file allo stesso `calculationId` dello
  snapshot, usando un nome con data/ora e GUID;
- usare una directory dedicata e determinabile `SavedProjects/` del
  WebService, mantenendo distinta questa persistenza operativa dallo
  `CalculationSnapshotStore` in memoria;
- preferire un piccolo servizio dedicato `SavedProjectStore` e non modificare
  frontend, Termodel.Core, Library o `definizionedati.json`;
- mantenere invariati gli endpoint legacy e il formato
  `TERMODEL-PROJECT-TEXT-V1`;
- aggiungere alla risposta di `POST /api/calculations`, se resta
  retrocompatibile e minimale, il solo nome logico del file salvato, senza
  esporre il path fisico; in tal caso aggiornare il contratto condiviso;
- estendere lo smoke HTTP per verificare file realmente creato, contenuto
  letto, corrispondenza del `calculationId`, due richieste → due file distinti
  e nessun file presentato come successo per una richiesta non valida.

Criteri di completamento:
- build Service con 0 errori;
- `POST /api/calculations` e artifact `model3d` ancora funzionanti;
- file fisico `.tmdl` creato in `SavedProjects/` dopo elaborazione riuscita;
- contenuto del file equivalente al `projectText` ricevuto;
- nome contenente data/ora e lo stesso `calculationId`;
- due richieste riuscite producono due file distinti;
- richiesta non valida non produce un progetto consolidabile;
- endpoint legacy invariati;
- diff finale limitato al WebService, test e documentazione pertinente;
- questa stessa voce aggiornata a `ESEGUITO` riportando separatamente
  implementazione, compilazione, esecuzione, test, confronto e commit.

Risultato:
- **implementato:** aggiunto
  `src/Termodel.WebService/Calculations/SavedProjectStore.cs`; salva
  direttamente il `projectText` ricevuto come UTF-8 senza BOM, con scrittura
  temporanea + rename finale, senza ricostruire il progetto;
- directory predefinita:
  `<ContentRootPath>/SavedProjects/`; per test/deployment può essere
  sovrascritta con `TERMODEL_SAVED_PROJECTS_DIR`;
- nome file:
  `TermodelProject-yyyyMMdd-HHmmssfff-<calculationId>.tmdl`, con timestamp UTC
  dello stesso snapshot;
- `POST /api/calculations` crea lo snapshot solo dopo `GeneraAsync`
  riuscito, salva il progetto con lo stesso `calculationId` e, se il
  salvataggio fallisce, rimuove lo snapshot appena creato prima di propagare
  l'errore;
- risposta pubblica estesa in modo additivo con
  `savedProject.fileName`; non viene esposto il path fisico e il progetto
  salvato non è inserito nel manifest degli artifact;
- contratto condiviso aggiornato a versione documento **0.9** nel commit
  `db6c81d53a57b439e0375e014b6cbc1bf800f919`;
- `.gitignore` esclude la cartella locale
  `Server/Termodelwebservice/src/Termodel.WebService/SavedProjects/`;
- **compilato:** GitHub Actions run **#35**, commit
  `a52c3a11c50d08d148e749f71f25def0a325ac58`: build Release riuscita,
  **154 warning, 0 errori**;
- **eseguito:** nello stesso run il WebService è stato avviato realmente su
  `127.0.0.1:5080` e lo smoke HTTP ha completato gli endpoint legacy e il
  ciclo `POST /api/calculations -> GET model3d`;
- **testato:** lo smoke ha verificato fisicamente un file `.tmdl` creato,
  nome contenente lo stesso `calculationId`, contenuto letto da disco e
  logicamente identico al `projectText`; due POST consecutivi hanno prodotto
  due GUID e due file distinti; un POST con progetto non valido ha restituito
  HTTP 422 senza aumentare il numero dei file `.tmdl`;
- **endpoint legacy:** `POST /api/model/3d` continua a essere esercitato con
  successo nello smoke; nessuna modifica a frontend, Termodel.Core, Library o
  `definizionedati.json`;
- **confronto con riferimento:** non applicabile a questa persistenza; non è
  stato introdotto alcun nuovo formato e il contenuto è confrontato con il
  testo ricevuto, non rigenerato;
- **test locale Visual Studio dopo questa modifica:** non ancora eseguito sul
  PC dell'utente; la verifica corrente è build + esecuzione HTTP + filesystem
  reali su runner Windows GitHub Actions;
- commit tecnici principali:
  `1af4a0bb9876de49b01fc2ab6c5e55640a5b33b3`,
  `a0a0f7325da81d030fbaa27facf86ea513dac520`,
  `0e5261f0cdacc3242ce06a146568484c80f8dc82`,
  `885942d2bb7538fdfc5d40c96332fe79e0422b9f`,
  `db6c81d53a57b439e0375e014b6cbc1bf800f919`,
  `a52c3a11c50d08d148e749f71f25def0a325ac58`.


### PROSSIMA PROVA — tetti e locali mansardati da Termodel Web v0.75

Il frontend dispone ora di uno strumento di test multipiano: `＋ Copertura`
crea un record `Piani` con `Tipo=Copertura`, stesso `NomeFile` del piano
sorgente e `LayerCad` distinto. Lo sfondo viene duplicato solo localmente,
mentre la geometria tecnica della copertura entra nel payload canonico
`TERMODEL-PROJECT-SVG-V1`.

Il frontend non genera un tetto 3D locale per i piani `Copertura`: la prossima
prova deve quindi verificare realmente la catena
`GeneraModello -> Tetti -> Polig3D -> TermodelWebModel v3` e il comportamento
dei locali mansardati. Nessun codice Service è stato modificato per questa
funzione frontend.

### FRONTEND TEST TOOLING — modalità Copertura v0.77

Il frontend Web dispone ora dei comandi minimi per esercitare realmente la
logica tetti del Service senza duplicarla nel browser. In un piano
`Tipo=Copertura` vengono disegnate linee perimetrali di falda e possono essere
inseriti blocchi `Colmo` con gli attributi già letti dal Core:
`QUOTACOLMO`, `QUOTAGRONDA`, `QUOTASHED`, `LATOPARTEBASSA`,
`PARETESHED`.

Il riferimento implementativo resta `LeggiDxf.AssociaBlocchiAParete("Colmo",...)`:
il prossimo test deve verificare sul runtime locale che il Colmo venga
associato alla linea corretta, che le quote Z vengano propagate e che il
`TermodelWebModel v3` contenga le falde/mansardati attesi. Nessun sorgente
Service/Core è stato modificato da questo intervento.

## 2. Posizioni e struttura

Sorgente locale compilato e avviato da Visual Studio:

```text
C:\DOCUMENTI\termomodel\codec\Termodelwebservice\
```

Copia di lavoro GitHub per AI:

```text
Server/Termodelwebservice/
```

Struttura reale, mantenuta senza riorganizzazioni:

```text
Termodelwebservice/
├── PROJECT-SUMMARY-SERVICE.md
├── Termodel.WebService.sln
├── Directory.Build.props
├── README.md
├── docs/
│   └── copied-from-termodel.md
└── src/
    ├── Termodel.Core/
    └── Termodel.WebService/
```

`Termodel.Core` è una libreria .NET 8 headless: contiene contratti, file unico,
archivi in memoria, geometria e motore 3D. `Termodel.WebService` è la Web API
ASP.NET Core che ospita il Core, CORS, template e endpoint HTTP.

## 3. Relazione con Termodel desktop e Library

Il desktop resta il riferimento funzionale e algoritmico. La Library GitHub
unica è:

```text
SorgentiTermodel/Library/
```

È consultiva e non va duplicata dentro `Server`. Durante il normale sviluppo
non viene adattata; può essere aggiornata o integrata, dopo autorizzazione
esplicita, con copie non modificate di sorgenti desktop selezionati. Provenienza
e SHA-256 devono essere verificati. Nuovi adattamenti si preparano nel Service
o in `SorgentiTermodel/Work`; l'obiettivo è duplicare il meno possibile e
convergere verso un Core realmente condiviso.

Il 21 settembre 2026 la Library è stata completata, come riferimento Desktop,
anche per la generazione XML APE nazionale e per pannelli radianti/spirali. Sono
stati aggiunti senza modifiche `GestXml`, `CalcoliXML`, `CalcoloAPE`, `Cened`,
`PannelliRadianti`, `IoPannelli`, `IoTubi`, `CalcoloPannelli` e i sorgenti dei
motori `SpiraliGPT` e `SpiralHeating` di Vittorio. Percorsi, dipendenze,
esclusioni e SHA-256 sono registrati in
`SorgentiTermodel/Library/RIFERIMENTI-DESKTOP-APE-PANNELLI.md`. Tutte le 21
copie sono risultate byte-per-byte uguali agli originali locali.

Il 23 settembre 2026 è stato inoltre acquisito il sorgente Desktop autorevole
`utilities/TermodelLog.cs`, fino ad allora assente dalla Library. La copia è
invariata e ha SHA-256
`79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218`.
Il confronto conferma che l'adattatore headless deve restare distinto per
isolamento `AsyncLocal`, diagnostica HTTP e persistenza per `projectId`.

Questa integrazione non implementa XML APE o pannelli nel WebService: rende
soltanto disponibile il riferimento autorevole per una futura estrazione
headless. Restano da isolare dipendenze WPF/MainWindow, Helix, IFC/Xbim,
netDxf, Windows Forms e altre librerie Desktop.

Le copie temporanee sono sotto:

```text
src/Termodel.Core/CopiedFromTermodel/
```

La mappa `TERMODEL-SYNC: PENDING` e le origini sono in
`CopiedFromTermodel/TERMODEL-SYNC.md`. Il 21 settembre 2026 sono stati integrati
nella Library unica `Modello.cs` e `utilities/ErrorManager.cs`, copiati senza
modifiche dagli originali desktop e verificati mediante SHA-256.

```text
Modello.cs
7B201DA17781CB2682EC9AF25D798B753EC590850031572A4A07E63975B125F0

utilities/ErrorManager.cs
6A7E93D009526D4DA5ED0F800B6155AB0B90C52237C13E76CEC52C4204863ECD

utilities/TermodelLog.cs
79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218
```

## 3.1 Strategia permanente di compatibilità Desktop

Decisione architetturale consolidata il 21 settembre 2026.

Per migrare il motore storico senza riscriverne inutilmente gli algoritmi, il
Service deve preferire **facciate di compatibilità** che presentino al codice
Desktop gli stessi concetti che esso si aspetta, pur ricavandoli dal file unico.

Architettura di riferimento:

```text
TERMODEL-PROJECT-TEXT-V1
        |
        +--> Virtual CAD
        |      SVG multipiano -> API netDxf compatibile
        |      file/layer/blocchi/linetype/colori/Z
        |
        +--> Virtual DB
        |      archives/xml/*.xml -> UtiDb / Database.DB compatibili
        |
        +--> Virtual Project
               workspace temporaneo per elaborazione
               percorsi/file attesi da GestProg e moduli file-based
        |
        v
codice Desktop/Core riusato
LeggiDxf / GestXml / CalcoloAPE / pannelli / ecc.
```

Principio permanente:

> quando il codice Desktop richiede una risorsa, preferire che il Core gliela
> presenti nel formato/comportamento già atteso invece di modificare
> l'algoritmo storico per adattarlo al Web.

### Virtual CAD

Il Desktop può usare lo stesso DXF per più piani, distinguendoli tramite
`Piani.NomeFile` + `Piani.LayerCad`. Il file unico usa invece SVG multipiano,
ma deve conservare la stessa semantica logica.

Lo strato compatibile deve quindi poter ricostruire un documento CAD virtuale
per nome file contenente più layer, inclusi progressivamente layer ausiliari
(es. tubi pannelli), in modo che il codice storico continui a filtrare
`dxf.Lines`, blocchi e layer senza conoscere la sorgente SVG.

Stato implementato al 21 settembre 2026: `SvgDxfReader` costruisce un solo
`DxfDocument` logico per `NomeFile`; i gruppi/piani che condividono il file
condividono quindi anche il documento e restano distinti tramite `LayerCad`.
Gli elementi SVG possono inoltre dichiarare un `data-termodel-layer` specifico,
permettendo di rappresentare layer ausiliari nello stesso documento.

`DxfDocument.Load(path)` consulta un registro CAD scoped alla richiesta.
`GeneraModello` materializza nel Virtual Project un percorso DXF reale,
registra sotto quel percorso il documento virtuale e richiama nuovamente il
metodo storico `LeggiFileDxf(...)`. Di conseguenza `LeggiDxf` continua a
passare da `File.Exists` e `DxfDocument.Load` come nel Desktop senza sapere
che geometria e layer provengono dallo SVG.

Il supporto geometrico dei layer ausiliari è operativo anche per l'input
`Tubo` dei pannelli: il Virtual CAD ricostruisce
`<NomePiano>_tubipannelli`, conserva `data-termodel-rete` nei metadata
della linea e l'adattatore headless `IoPannelli.LeggiTubiDXF` continua a
vedere la convenzione Desktop. Il primo solver idraulico pannelli è integrato
in `POST /api/calculations` e produce `artifacts/pannelli.json`.
Dal 23 settembre 2026 è inoltre attivo l'esecutivo grafico con il default
corrente `PassoTubi=0,30 m`, che produce
`pannelli-esecutivo.svg` e `pannelli-esecutivo.dxf` dallo stesso modello
grafico neutro. Resta futura soltanto la parametrizzazione del motore spirali
per passi diversi da 300 mm; grafo e collettore restano alla fase Tubi
universale.

### Virtual DB

Gli archivi autorevoli per il motore nel file unico sono
`archives/xml/*.xml`. `ProjectArchiveDatabase` li carica in memoria e
l'adattatore `UtiDb` / `Database.DB` deve replicare la semantica Desktop,
non solo le firme necessarie alla compilazione.

Allineamento implementato al 21 settembre 2026:

- `GetDataDB` replica il comportamento Desktop rilevante: confronto trimmed
  case-sensitive e `null` a runtime quando il dato non viene trovato o è
  vuoto;
- `TipoZona` usa i valori Desktop, incluso `Edificio adiacente`, e conserva
  il comportamento per campo `Tipo` mancante;
- `AggiungiZoneStandard` è disponibile attraverso `UtiDb` e
  `Database.DB`;
- la validazione server mantiene intenzionalmente errore strutturato quando un
  archivio richiesto è assente dal file unico, invece di reintrodurre UI o
  MessageBox.

Ulteriori metodi verranno aggiunti alla facciata quando richiesti da
`GestXml`, `CalcoloAPE`, pannelli o altri moduli, evitando modifiche ai
chiamanti storici.

Il JSON parallelo degli archivi è una rappresentazione utile al Web/AI; il
motore Core continua a usare come riferimento runtime gli XML del file unico,
finché il contratto non stabilirà diversamente.

### Virtual Project

È stato implementato `Compatibility/ProjectWorkspace.cs`. Per ogni
elaborazione corrente esso materializza il file unico in una directory
temporanea isolata, crea le sezioni del contenitore, replica
`archives/xml/*.xml` sotto `dbtempfiles/`, espone `xml/input.xml` e
`xml/output.xml` e fornisce i percorsi CAD logici usati dal Virtual CAD.

La facciata `GestProg` espone ora `PathProg`, `PathProgDB`,
`FileXMLPath`, `FileXMLOutPath` e `FileDXFPath(...)` sul workspace
corrente. Il workspace viene eliminato al termine della generazione corrente.

Questa è la base per i moduli Desktop file-based (`GestXml`, `CalcoloAPE`,
`Cened`, `IoPannelli` e successivi). Non è lo storage persistente pubblico:
la nuova commissione 2026-09-22 introduce invece il workspace stabile
`SavedProjects/{projectId}/`, aggiornato ad ogni elaborazione riuscita.

Il workspace temporaneo Core resta un adattatore interno, non il formato
autorevole del progetto. Il file unico resta l'input autorevole; gli output
dell'elaborazione diventano artifact correnti del `projectId` e non devono
essere reinseriti implicitamente nel progetto.

## 4. Storia consolidata dello sviluppo Service

### Studio di fattibilità

Il lavoro è iniziato valutando un motore Termodel eseguibile su server ASP.NET
Core con modifiche minime ai sorgenti desktop. Form, WPF e visualizzazione 3D
desktop sono stati esclusi dal runtime. Per la comunicazione col frontend resta
scelto un modello 3D JSON diretto. La decisione è stata successivamente
affinata: `Xbim.Essentials` viene usato come modello dati IFC **in memoria**
per mantenere invariato `Polig3D`, ma il Service non esporta IFC e non usa il
renderer geometrico xBIM.

### Soluzione separata

È stata creata la soluzione gemella `Termodelwebservice`, apribile in Visual
Studio 2022, con una libreria Core e una Web API. Il server locale usa HTTP
durante lo sviluppo per evitare la dipendenza dal certificato HTTPS developer.

### File unico di progetto

È stato definito `TERMODEL-PROJECT-TEXT-V1`, contenitore testuale UTF-8 pensato
anche per copia/incolla verso e da AI. Contiene manifest, impronta della
definizione dati, SVG multipiano, archivi XML/JSON, input termici e risorse del
progetto. `ProjectTextDocument` lo legge; `ProgFileUnico` lo produce.

La funzione Nuovo progetto non fabbrica più archivi vuoti dal solo JSON:
`POST /api/projects/new` clona il progetto base realmente proposto da Termodel,
incorporato in `Templates/ProgettoBase`. La copia di
`Definitions/definizionedati.json` elimina la dipendenza dalla cartella desktop
ma resta derivata dall'originale autorevole e non deve divergere.

Il progetto vuoto statico è anche pubblicato per il frontend in
`SorgentiTermodel/Library/projects/ProgettoVuoto/` (commit `f58a972`).

### Comunicazione browser → localhost

È stato configurato CORS per `https://www.termodel.it`, metodi GET/POST/OPTIONS,
header di preflight e `Access-Control-Allow-Private-Network` quando richiesto da
Chrome. Il browser può richiedere anche il permesso Local Network Access, che
non può essere aggirato dal server.

### Motore Modello3D headless

Sono state selezionate le classi strategiche `LeggiDxf`, `DXFLineCheck`,
`GeneraModello`, `GeneraPianta`, `Tetti`, `Confini`, `Polig3D` e
`Modello`. `Polig3D` è ora identico byte-per-byte al sorgente Desktop; la
compatibilità headless è ottenuta sotto la classe tramite xBIM in memoria e
facciate WPF/MainWindow/DrawBim. Una compatibilità `netDxf` minima viene
popolata dallo SVG del file unico; non è un lettore DXF generale. `UtiDb` e
`Database.DB` lavorano sugli archivi XML in memoria. La geometria topologica
continua a usare NetTopologySuite e lo stato storico resta protetto da un gate
seriale.

`POST /api/model/3d` riceve `text/plain; charset=utf-8` e restituisce direttamente
`TermodelWebModel` v3 JSON. Non produce IFC. `GET
/api/model/clean-floor/{floorName}` restituisce lo SVG architettonico pulito
dell'ultima generazione.

Verifica storica del 21 settembre 2026: GitHub Actions aveva build Release
con 0 errori e 154 warning e lo smoke HTTP verificava il precedente percorso
snapshot per-elaborazione. Questa implementazione è ora **legacy e destinata
alla sostituzione** dalla commissione projectId-only del 22 settembre 2026.
La prova con geometria reale e il confronto golden restano aperti.

## 5. API implementate

```text
GET  /
GET  /health
GET  /api/model/capabilities
GET  /api/model/clean-floor/{floorName}
GET  /api/projects
POST /api/projects/new
POST /api/projects/allocate-id
POST /api/projects/{projectId}/open
PUT  /api/projects/{projectId}/save
PUT  /api/projects/{projectId}/save-as
POST /api/projects/{projectId}/heartbeat
POST /api/projects/{projectId}/close
POST /api/projects/{projectId}/unlock
POST /api/model/3d
POST /api/dxf/to-svg
POST /api/calculations
GET  /api/projects/{projectId}/artifacts/model3d
GET  /api/projects/{projectId}/artifacts/pannelli
GET  /api/projects/{projectId}/artifacts/pannelli-esecutivo-svg
GET  /api/projects/{projectId}/artifacts/pannelli-esecutivo-dxf
GET  /api/projects/{projectId}/logs/termodel
POST /api/feedback
```

`POST /api/dxf/to-svg` è un servizio stateless di conversione degli sfondi:
riceve il DXF ASCII originale e le opzioni di importazione, delega la
trasformazione a `Termodel.Core.Cad.DxfSvgConverter` e restituisce SVG,
statistiche, bounds/viewBox e metadati di unità. Non crea né modifica un
workspace progetto e non contiene logica algoritmica duplicata nel WebService.

`POST /api/projects/new` continua a creare il file unico base e non assegna
silenziosamente un'identità persistente. Il frontend richiede il projectId una
sola volta con `POST /api/projects/allocate-id` e lo consolida come proprietà
top-level `manifest.projectId`.

`POST /api/calculations` usa esclusivamente quel `projectId`, ricostruisce il
modello una sola volta e, solo a elaborazione riuscita, sostituisce il workspace
corrente:

```text
SavedProjects/{projectId}/
├── project.tmdl
├── artifacts/
│   ├── model3d.json
│   ├── pannelli.json
│   ├── pannelli-esecutivo.svg   (quando generabile)
│   └── pannelli-esecutivo.dxf   (quando generabile)
└── logs/
    ├── calculation.log
    ├── diagnostics.txt
    └── TermodelLog.md
```

La root resta configurabile tramite `TERMODEL_SAVED_PROJECTS_DIR`.
`project.tmdl` è la copia UTF-8 del projectText realmente ricevuto; non viene
rigenerato dal Service e non acquisisce gli sfondi esclusivamente frontend.

Gli endpoint `GET /api/projects/{projectId}/artifacts/*` leggono gli artifact
persistiti e non eseguono un nuovo calcolo. Questo vale per `model3d`,
`pannelli` e per i due esecutivi pannelli SVG/DXF quando presenti. Gli
artifact restano quindi leggibili dopo il riavvio del Service.

Il precedente modello per-elaborazione è stato rimosso dal runtime:
non esistono più `CalculationSnapshotStore`, response `calculationId` o
route `/api/calculations/{id}/artifacts/model3d`.

Errori di progetto, projectId mancante/non riservato o funzioni non supportate
sono restituiti come Problem Details; Content-Type non valido produce 415.
Un calcolo fallito non sostituisce l'ultimo workspace valido.

### Workflow server concordato: AggiornaCalcolo

Decisione consolidata del 22 settembre 2026: **un progetto, un projectId, una
cartella corrente**.

```text
Frontend
  -> TERMODEL-PROJECT-TEXT-V1 con manifest.projectId
  -> POST /api/calculations
  -> Termodel.Core ricostruisce il progetto una sola volta
  -> genera gli elaborati disponibili
  -> WebService sostituisce SavedProjects/{projectId}/
  -> restituisce projectId + manifest degli artifact correnti
```

Le view non devono rilanciare i calcoli. Devono leggere gli elaborati correnti
dello stesso progetto tramite route del tipo:

```text
GET /api/projects/{projectId}/artifacts/model3d
GET /api/projects/{projectId}/artifacts/pannelli
GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-svg
GET /api/projects/{projectId}/artifacts/pannelli-esecutivo-dxf
GET /api/projects/{projectId}/artifacts/xml-nazionale                 (futuro)
GET /api/projects/{projectId}/artifacts/report-dispersioni            (futuro)
GET /api/projects/{projectId}/artifacts/pianta-pulita/{piano}         (futuro)
```

Al momento sono implementati e persistiti `model3d`, `pannelli` e, quando
il progetto dispone di locali/tubi idonei, `pannelli-esecutivo.svg` e
`pannelli-esecutivo.dxf`. XML nazionale, report dispersioni e pianta pulita
persistente restano estensioni successive dello stesso workspace e non devono
introdurre storage paralleli o identificatori per-elaborazione.

Formati indicativi degli artifact:

- modello 3D: JSON;
- XML nazionale: `application/xml`;
- report dispersioni: dati JSON, non HTML generato dal Core;
- report pannelli: dati JSON;
- esecutivo pannelli corrente: SVG `image/svg+xml` e DXF
  `application/dxf`, derivati dallo stesso modello grafico neutro;
- pianta pulita: SVG per piano (futuro artifact persistente).

Compatibilità: gli endpoint legacy `POST /api/model/3d` e
`GET /api/model/clean-floor/{floorName}` restano disponibili finché non
saranno deprecati esplicitamente.

Regola di efficienza: `AggiornaCalcolo` ricostruisce il modello **una sola
volta**. Leggere un artifact non deve provocare una nuova elaborazione completa.


## 6. EnergyPlus, gbXML e IDF

EnergyPlus fa parte della direzione futura del Service, non dello stato già
implementato. Il desktop contiene un'integrazione storica avviata da UI e un
percorso macchina-specifico verso l'eseguibile EnergyPlus. Questo legame non è
portabile sul server e non va copiato alla cieca.

Direzione consolidata:

```text
Termodel.Core
  → modello energetico validato
  → esportatore gbXML e/o IDF
  → runner EnergyPlus isolato
  → risultati normalizzati e confrontabili
```

Decisioni ancora da prendere: versione EnergyPlus supportata, scelta primaria
gbXML/IDF, mapping completo degli archivi, gestione meteo EPW, sandbox del
processo, limiti di tempo/risorse e formato dei risultati. Nessun endpoint
EnergyPlus, gbXML o IDF è attualmente implementato.

## 7. Regression test, progetti campione e Golden Results

La strategia prevista è versionare input, output attesi, tolleranze numeriche e
versione del motore. I confronti non devono limitarsi al testo JSON: occorrono
conteggi per tipo, identificativi, vertici/indici, quote, superfici, volumi,
orientamenti e diagnostica, con tolleranze esplicite per i numeri floating point.

Campioni correnti:

- `ProgettoVuoto`: test del contenitore e del contratto, 0 primitive attese;
- `Fabbricato con tetto a due falde e piano mansardato`: golden test avanzato
  perché esercita piani, falde, colmi, mansarda e funzioni 3D. La cartella
  desktop contiene un precedente `WebBridge/TermodelWebModel.json` con 546
  primitive, ma manca ancora il corrispondente file unico SVG multipiano.

Non esiste ancora una suite automatica di regressione né una directory Golden
Results formalizzata. Il confronto avanzato non è quindi completato.

## 8. Sincronizzazione locale ↔ GitHub

Configurazione: `transfer-map.json`. Motore:
`tools/transfer/TermodelTransfer.ps1`. Il mapping `TermodelWebService` collega:

```text
locale: C:\DOCUMENTI\termomodel\codec\Termodelwebservice
GitHub: Server/Termodelwebservice
```

Sono esclusi `.git`, `.vs`, `bin`, `obj`, `packages`, `*.user`, `*.suo` e
`*.tmp`. Prima di ogni copia eseguire sempre `status`.

Da sorgente locale a GitHub:

```powershell
tools\transfer\TermodelTransfer.ps1 -Action status -Name TermodelWebService
tools\transfer\TermodelTransfer.ps1 -Action export -Name TermodelWebService
```

Da GitHub a sorgente locale:

```powershell
tools\transfer\TermodelTransfer.ps1 -Action status -Name TermodelWebService
tools\transfer\TermodelTransfer.ps1 -Action import -Name TermodelWebService
```

L'export è speculare soltanto sulla copia GitHub. L'import è non distruttivo e
crea prima un backup in `_backups/<data-ora>/TermodelWebService`.
`COPIA_TERMODEL_SERVICE_LOCALE_NEL_CLONE_GITHUB.cmd` resta disponibile per
copiare il Service locale nella cartella versionata del clone; non crea commit
e non esegue push. Per scaricare `origin/main` e poi predisporre il Service
locale alla compilazione usare
`SCARICA_GITHUB_E_PREPARA_TERMODEL_SERVICE_LOCALE.cmd` nella radice del
repository: richiede un working tree pulito, usa esclusivamente fast-forward e
non esegue build o avvio. Per pubblicare modifiche locali sul remoto usare il
distinto `PUBBLICA_MODIFICHE_LOCALI_NEL_GITHUB_REMOTO.cmd`.

Git pull/push restano operazioni separate. Non pubblicare automaticamente
modifiche frontend preesistenti o non pertinenti.

## 9. Compilazione ed esecuzione

### Build automatica GitHub

È presente:

```text
.github/workflows/termodel-service-build.yml
```

Il workflow viene avviato automaticamente dai push che modificano il Service
(o il workflow stesso) e può essere avviato anche manualmente. Su runner
Windows esegue:

```text
dotnet restore Termodel.WebService.sln
dotnet build Termodel.WebService.sln --configuration Release --no-restore
```

Prima esecuzione dopo l'introduzione del Virtual CAD/DB/Project: fallita con
3 errori tutti in `ProjectWorkspace.cs` per chiamata di metodo statico tramite
istanza; corretti nel commit `2753e468c7d1da6b9fb4602152b3fabb0abec17c`.

Seconda esecuzione GitHub Actions, run #2: **Build succeeded, 0 errori,
108 warning**. Questo certifica la compilazione cloud del codice corrente, non
l'esecuzione funzionale degli endpoint.

### Esecuzione locale

1. sincronizzare GitHub → locale e verificare le differenze;
2. aprire `C:\DOCUMENTI\termomodel\codec\Termodelwebservice\Termodel.WebService.sln`;
3. impostare `Termodel.WebService` come progetto di avvio;
4. scegliere il profilo HTTP;
5. compilare e avviare con Visual Studio;
6. verificare `http://localhost:5080/health` e
   `http://localhost:5080/api/model/capabilities`.

Non avviare direttamente `Termodel.Core`: è una libreria di classi.

## 10. Stato corrente e problemi aperti

Implementato e verificato:

- soluzione .NET 8 separata;
- progetto base incorporato e copia verificata della definizione dati;
- file unico e endpoint Nuovo progetto;
- CORS/PNA per il frontend pubblico;
- Virtual CAD: SVG multipiano → documento netDxf virtuale multi-layer per
  `NomeFile`, registro per `DxfDocument.Load` e riuso di `LeggiFileDxf`;
- Virtual DB: archivi XML in memoria, `GetDataDB`/ `TipoZona` allineati e
  `AggiungiZoneStandard`;
- Virtual Project: workspace temporaneo e facciata `GestProg` per percorsi
  Desktop-like;
- `Polig3D` Core byte-per-byte identico al riferimento Desktop;
- xBIM Essentials usato solo come struttura IFC in memoria, senza artifact IFC;
- facciate headless per WPF/MainWindow/filtri/DrawBim;
- `TermodelWebModel v3` completo dei metadati avanzati dei filtri;
- endpoint Modello3D e pianta pulita;
- GitHub Actions per restore/build automatico e smoke HTTP;
- build Release corrente verificata con 0 errori e 154 warning;
- smoke HTTP corrente: `/health`, `POST /api/projects/new` e
  `POST /api/model/3d` riusciti sul `ProgettoVuoto`, con v3 Z-up e 0
  primitive.

Incompleto:

- esecuzione locale Visual Studio del nuovo percorso xBIM/Polig3D (lo smoke
  HTTP cloud è già riuscito);
- file unico/golden test del progetto mansardato e confronto delle 546
  primitive;
- regression test automatici e Golden Results versionati;
- completamento del workspace projectId con `pianta-pulita/{piano}` e successivi artifact per le view;
- API CRUD archivi e concorrenza multiutente/autenticata;
- autenticazione e autorizzazione;
- EnergyPlus, gbXML e IDF;
- eliminazione progressiva delle copie `TERMODEL-SYNC`;
- gestione e riduzione dei 108 avvisi di nullabilità;
- pubblicazione su hosting remoto/container dopo i test Docker locali.

## 11. Prossimi passi consigliati

1. adeguare separatamente il frontend al flusso
   `allocate-id -> manifest.projectId -> POST /api/calculations`;
2. aggiungere `pianta-pulita/{piano}` e gli artifact successivi nello stesso
   workspace `SavedProjects/{projectId}/`;
3. generare lo SVG multipiano e il file unico del progetto mansardato;
4. confrontare il risultato con le 546 primitive del JSON desktop, definendo
   tolleranze e report;
5. creare una suite automatica di regression test e `GoldenResults/`;
6. integrare progressivamente XML nazionale/dispersioni e poi pannelli/spirali
   nel nuovo workflow projectId-only;
7. definire API autorevoli per schema, archivi, validazione e CRUD;
8. progettare il contratto energetico prima di scegliere gbXML o IDF;
9. provare build e runtime in Docker locale;
10. ridurre gradualmente `CopiedFromTermodel` spostando la logica condivisibile
    in un unico Core compatibile anche col desktop.

## 12. Vincoli permanenti

- `definizionedati.json` è il riferimento inderogabile e non si modifica senza
  autorizzazione specifica;
- il frontend Web resta funzionante e separato;
- `PROJECT-SUMMARY.md` Web e questo summary Service non si fondono;
- `SorgentiTermodel/Library` non si duplica e non si adatta durante il normale
  sviluppo Service; può essere integrata con copie desktop non modificate solo
  dopo autorizzazione esplicita e verifica SHA-256;
- nessun risultato proposto è dichiarato verificato senza build/test reali;
- compatibilità e reversibilità prevalgono sui refactoring opportunistici.
