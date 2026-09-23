# TERMODEL CORE + WEBSERVICE — PROJECT SUMMARY

Ultimo aggiornamento: **2026-09-23**  
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

## 1.1 Registro incarichi autorizzati

Questo registro serve a garantire continuità anche se una chat termina durante
un intervento.

Formato obbligatorio per ogni nuovo incarico autorizzato:

```text
### INCARICO <data/identificativo breve>
Stato: COMMISSIONATO | ESEGUITO

Commissionato:
- obiettivo concreto;
- file/componenti previsti;
- vincoli da rispettare;
- criteri di completamento.

Risultato:
- compilazione;
- esecuzione;
- test;
- confronto con riferimento;
- commit finali.
```

Regole:

- `COMMISSIONATO` significa che l'utente ha autorizzato il lavoro ma il
  risultato non è ancora stato completato/verificato;
- `ESEGUITO` si usa soltanto quando il lavoro commissionato è terminato;
- compilazione, esecuzione, test e confronto devono essere descritti
  separatamente e non dedotti dal solo stato `ESEGUITO`;
- non creare una nuova voce per ogni commit tecnico dello stesso incarico:
  aggiornare la voce originaria;
- una chat nuova deve controllare prima di tutto se esistono incarichi ancora
  `COMMISSIONATO` e considerarli lavoro pendente autorizzato.

Al momento dell'introduzione di questa regola non risultano incarichi tecnici
già autorizzati e lasciati incompleti da registrare retroattivamente.

### INCARICO 2026-09-23 — revisione archivi pannelli radianti: Reti + TipologiePannelli
Stato: COMMISSIONATO

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
  `Tubazioni` e `Fluidi` per questa prima fase; i dati necessari al
  calcolo pannelli devono confluire nei due archivi sopra secondo la loro
  responsabilità;
- aggiornare metadata estesi, template Service, ProgettoVuoto frontend,
  ArchivioWeb/menu e contratto Front↔Service coerentemente;
- mantenere `TERMODEL-PROJECT-TEXT-V1` invariato e non modificare
  `definizionedati.json`;
- registrare che in futuro il CAD 2D avrà una combo che seleziona una riga
  dell'archivio `Reti` e quindi determina il tipo di rete che si sta
  disegnando; **la combo CAD non viene implementata in questo incarico**,
  perché campo grafico, semantica e workflow verranno definiti in seguito;
- non modificare ancora gli algoritmi del calcolo pannelli o Darcy.

Criteri di completamento:
- nuovo progetto e ProgettoVuoto contengono `Reti` e
  `TipologiePannelli` precompilati;
- `Reti` contiene una prima riga pannelli radianti con dati di esercizio non
  legati al produttore;
- `TipologiePannelli` contiene il default Generico/Default Termodel con
  caratteristiche tubo e lista passi disponibili;
- menu frontend espone soltanto le due voci coerenti con la nuova struttura;
- ArchivioWeb carica i nuovi metadata estesi senza duplicare
  `definizionedati.json`;
- gli archivi separati `Tubazioni` e `Fluidi` non sono più generati dal
  template autorevole;
- compatibilità di lettura dei progetti creati nella breve fase precedente
  documentata e, per quanto ragionevole, preservata;
- build/smoke Service e deploy GitHub Pages verificati;
- registro Tubazioni, contratto e Summary aggiornati allo stato reale.

Risultato:
- implementazione in corso.

### INCARICO 2026-09-23 — voci archivi pannelli nel menu frontend
Stato: ESEGUITO

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
Stato: ESEGUITO

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

Il supporto geometrico dei layer ausiliari è predisposto; i circuiti pannelli
restano però intenzionalmente non supportati dal percorso 3D corrente e
`IoPannelli.LeggiTubiDXF` continua a segnalarli come funzione non ancora
integrata.

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
POST /api/calculations
GET  /api/projects/{projectId}/artifacts/model3d
GET  /api/projects/{projectId}/logs/termodel
POST /api/feedback
```

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
│   └── model3d.json
└── logs/
    ├── calculation.log
    └── diagnostics.txt
```

La root resta configurabile tramite `TERMODEL_SAVED_PROJECTS_DIR`.
`project.tmdl` è la copia UTF-8 del projectText realmente ricevuto; non viene
rigenerato dal Service e non acquisisce gli sfondi esclusivamente frontend.

`GET /api/projects/{projectId}/artifacts/model3d` legge il JSON persistito e
non esegue un nuovo calcolo. Gli artifact restano quindi leggibili dopo il
riavvio del Service.

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
GET /api/projects/{projectId}/artifacts/xml-nazionale
GET /api/projects/{projectId}/artifacts/report-dispersioni
GET /api/projects/{projectId}/artifacts/pannelli
GET /api/projects/{projectId}/artifacts/spirali/{piano}
GET /api/projects/{projectId}/artifacts/pianta-pulita/{piano}
```

Al momento è implementato e persistito `model3d`; gli altri artifact sono le
estensioni successive dello stesso workspace e non devono introdurre storage
paralleli o identificatori per-elaborazione.

Formati indicativi degli artifact:

- modello 3D: JSON;
- XML nazionale: `application/xml`;
- report dispersioni: dati JSON, non HTML generato dal Core;
- report pannelli: dati JSON;
- spirali: SVG per piano;
- pianta pulita: SVG per piano;
- eventuali esecutivi DXF: `application/dxf`.

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
