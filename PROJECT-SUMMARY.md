# TERMODEL — PROJECT SUMMARY

> **Documento primario di continuità del progetto**
>
> Ogni nuova chat o sessione che lavora sul repository Termodel deve leggere **questo file per primo**, prima di proporre o modificare codice.
>
> Questo documento serve a evitare la perdita di contesto quando una chat diventa troppo lunga. Deve essere mantenuto breve, operativo e aggiornato dopo ogni intervento che cambia architettura, stato, file importanti, contratti o prossimi passi.

Ultimo aggiornamento: **2026-09-21**  
Branch di riferimento: **main**  
Ultimo commit di codice verificato:  
`952b605637dc44095639e3b0b4d41fa7d06347ce` — `Add vector background endpoint snap v0.63`  
Commit che ha creato questo summary:  
`39433b20c90bd7a2ff3b5976d0a007180d96fc71` — `Add project continuity summary`

---

## 1. Regola obbligatoria per nuove chat

Prima di lavorare:

1. leggere questo `PROJECT-SUMMARY.md`;
2. sincronizzare/verificare il branch `main`;
3. controllare i commit successivi all'ultimo commit indicato qui;
4. leggere soltanto i documenti specialistici indicati nella sezione relativa al lavoro da svolgere;
5. non assumere che lo stato ricordato da una chat precedente sia ancora corrente;
6. prima di modificare codice, comunicare sinteticamente cosa si vuole cambiare e quali file sono coinvolti;
7. non fare commit o push se l'utente non ha autorizzato l'intervento.

Dopo un intervento significativo:

1. verificare i file modificati e il diff;
2. eseguire i test disponibili;
3. aggiornare **questo documento** se sono cambiati stato, architettura, contratti, versioni, responsabilità o prossimi passi;
4. indicare nel riepilogo finale il commit corrente o il commit creato.

Quando una chat sta diventando molto lunga, deve aggiornare questo file **prima** di perdere il contesto, in modo che una nuova chat possa continuare da qui.

---

## 2. Repository e obiettivo generale

Repository:

```text
https://github.com/Fetonte1960/Termodel
```

### Obiettivo primario del progetto

**Stiamo sviluppando la versione Web di Termodel.**

Il programma Termodel desktop esistente è il riferimento funzionale e tecnico da cui ricavare comportamenti, regole, archivi e funzioni. Il lavoro corrente consiste nel trasferire progressivamente queste capacità in una architettura Web moderna, mantenendo separati frontend, servizi server e logica Core.

Architettura di riferimento:

```text
Termodel desktop esistente
        │
        ├── riferimento funzionale
        ├── definizione dati autorevole
        ├── archivi / XML
        └── funzioni e logica storica
             │
             ▼
Termodel.Core
logica riutilizzabile / funzioni del motore
             │
             ▼
Termodel.WebService
server ASP.NET Core / API / contratti
             │
             ▼
Termodel Web
HTML / CSS / JavaScript browser
```

Il progetto non consiste semplicemente nel creare una demo Web: l'obiettivo è arrivare a una **vera versione Web di Termodel**, riutilizzando e portando sul lato Core/server le funzioni del Termodel esistente invece di duplicarle arbitrariamente nel browser.

Principio fondamentale:

> Il frontend presenta e interagisce con i dati; Core e server implementano progressivamente le funzioni autorevoli di Termodel.

### Ragione d'essere di Termodel Web: interazione con l'AI

Il principale punto di forza e la ragione d'essere di **Termodel Web** non è soltanto portare Termodel nel browser.

Il valore distintivo del progetto è l'integrazione profonda con l'AI e, soprattutto, la capacità dell'AI di **comprendere, generare e manipolare progetti Termodel reali**.

Il flusso strategico è quindi:

```text
utente
  ↓ linguaggio naturale / immagini / richieste
AI
  ↓ interpreta e modifica la rappresentazione del progetto
Termodel Web
  ↓ visualizza e permette il controllo/interazione
Termodel.Core / WebService
  ↓ valida, elabora e persiste
progetto Termodel reale
```

L'AI non deve essere considerata un semplice help o chatbot laterale.

Deve diventare un vero strumento operativo capace, attraverso protocolli e dati strutturati, di:

- creare nuovi progetti Termodel;
- leggere e comprendere progetti esistenti;
- modificare geometrie e dati tecnici;
- aggiungere o correggere elementi;
- guidare l'utente attraverso operazioni complesse;
- restituire un progetto completo e nuovamente utilizzabile da Termodel.

Questo principio deve orientare le decisioni architetturali future: viewer 3D, frontend, formato progetto, WebService e Core devono essere progettati anche per rendere naturale e affidabile l'interazione AI ↔ progetto Termodel.


---

## 2.1 Istruzioni AI di Termodel — fonte e reperimento

Le istruzioni operative destinate all'AI **non devono essere duplicate dentro questo PROJECT-SUMMARY**. Il PS deve indicare dove si trovano e come reperirle.

### Fonte autorevole di lavoro

La sorgente madre delle istruzioni AI è:

```text
SorgentiTermodel/Work/IstruzioniAI/
```

Al 2026-09-19 contiene:

```text
IndiceAI.md
TermodelGenerale.md
CreaPianoTermodelDaRaster.md
```

Il punto di ingresso obbligatorio è:

```text
SorgentiTermodel/Work/IstruzioniAI/IndiceAI.md
```

Una chat o un agente AI che deve usare le istruzioni Termodel non deve cercare file casualmente nel repository e non deve caricare tutto indiscriminatamente.

Procedura corretta:

```text
IndiceAI.md
    ↓
capire cosa vuole fare l'utente
    ↓
caricare TermodelGenerale.md
    ↓
caricare soltanto le eventuali istruzioni specifiche indicate dall'indice
```

Stato corrente dell'indice:

```text
1 — Informazioni su Termodel
    → TermodelGenerale.md

2 — Lavorare su un progetto Termodel
    → TermodelGenerale.md
    → ProgettoTermodel.md è previsto come possibile file futuro ma non è attualmente disponibile

3 — Creare un piano da una pianta raster
    → TermodelGenerale.md
    → CreaPianoTermodelDaRaster.md
```

Regole:

- `TermodelGenerale.md` contiene le regole comuni;
- le istruzioni specifiche si aggiungono dopo quelle generali;
- non inventare nomi di file non presenti nell'indice;
- se l'indice cita un file futuro non ancora disponibile, non fingere che esista;
- se cambia il tipo di attività durante una conversazione, caricare soltanto l'istruzione specifica necessaria.

### Copia pubblicata per AI esterne e Termodel Web

La copia destinata alla pubblicazione Web si trova in:

```text
docs/termodel-ui-demo/
```

Il punto di ingresso pubblico corrente è:

```text
https://www.termodel.it/termodel-ui-demo/IndiceAI.html?v=0.21
```

Da lì l'AI può reperire, secondo la scelta effettuata, i file pubblicati come:

```text
https://www.termodel.it/termodel-ui-demo/TermodelGenerale.md
https://www.termodel.it/termodel-ui-demo/CreaPianoTermodelDaRaster.md
```

La directory `SorgentiTermodel/Work/IstruzioniAI/` è la **sorgente di lavoro autorevole**; `docs/termodel-ui-demo/` è la **copia pubblicata**. Quando le istruzioni vengono modificate, evitare divergenze tra sorgente e copia pubblicata e verificare esplicitamente la propagazione.



---

## 2.2 Storico essenziale dello sviluppo Web

### Fase 1 — Verifica delle capacità 3D nel browser

Il primo passo concreto verso Termodel Web è stato verificare se un viewer 3D realizzato in JavaScript fosse sufficientemente potente per rappresentare progetti Termodel reali.

La prova iniziale è partita da un caso semplice:

```text
progetto creato con Termodel desktop
        ↓
esportazione in file JSON
        ↓
viewer 3D JavaScript nel browser
```

Questa fase aveva uno scopo esplorativo: capire se il browser potesse sostituire in modo credibile la visualizzazione 3D desktop almeno per la parte di consultazione grafica.

Il risultato è stato molto positivo: le capacità del viewer 3D JavaScript si sono rivelate notevoli e sufficienti a giustificare il proseguimento dello sviluppo della versione Web di Termodel.

Da questa verifica è nata la decisione di non limitarsi a una semplice pagina informativa, ma di procedere progressivamente verso una vera applicazione Termodel Web.

Il primo viewer lavorava quindi su progetti già realizzati nel programma desktop e trasferiti al browser tramite JSON.

### Fase 2 — Demo esplorabile di Termodel desktop

Visto il successo della prova 3D, il passo successivo è stato costruire una **demo esplorabile di Termodel desktop** direttamente nel browser.

L'idea era riprodurre progressivamente l'esperienza del programma desktop, mantenendo al centro dell'interfaccia il viewer 3D già collaudato e affiancandogli una struttura di menu e comandi ispirata a Termodel.

La demo è stata organizzata attorno a un **progetto di esempio**, in modo da poter esplorare concretamente l'interfaccia e verificare come le funzioni desktop potessero essere trasferite sul Web.

Schema concettuale della fase:

```text
interfaccia Termodel esplorabile nel browser
        │
        ├── menu e comandi ispirati al desktop
        │
        ├── viewer 3D al centro
        │
        └── progetto di esempio già caricato
```

Questa fase ha trasformato il viewer isolato in un primo prototipo di applicazione Web completa e ha fornito la base su cui sono poi state aggiunte le funzioni operative.

### Fase 3 — Progettazione dell'architettura completa Web

Con l'evoluzione della demo, Termodel Web è apparso progressivamente sempre più realizzabile come applicazione completa.

A quel punto il progetto ha superato la fase puramente esplorativa e si è iniziato a progettare l'insieme come un sistema composto da due parti coordinate:

```text
FRONTEND WEB
HTML / CSS / JavaScript
interfaccia, viewer, interazione utente
        │
        │ API / contratti
        ▼
SERVER
Termodel.WebService + Termodel.Core
funzioni autorevoli, dati, calcoli, persistenza
```

Da questa fase nasce l'architettura attuale: il browser non deve diventare una copia indipendente del programma desktop, ma deve occuparsi principalmente di presentazione e interazione; il server e il Core devono invece accogliere progressivamente le funzioni provenienti dal Termodel desktop.

Questa decisione ha segnato il passaggio da una demo navigabile a un vero progetto software Web strutturato.

### Fase 4 — Nascita di MyHome3D e doppia identità sperimentale

Il progetto è apparso troppo interessante per essere limitato al solo pubblico tecnico legato ad APE, progettazione energetica e uso professionale di Termodel.

Da qui è nata una seconda idea di presentazione, chiamata **MyHome3D**, pensata per un pubblico molto più ampio e non necessariamente tecnico.

Le due identità attualmente convivono:

```text
TERMODEL WEB
│
├── identità tecnica/professionale
│   ├── continuità con Termodel desktop
│   ├── APE e progettazione energetica
│   ├── archivi tecnici
│   ├── funzioni specialistiche
│   └── utenti professionali
│
└── identità MyHome3D
    ├── presentazione più semplice e accessibile
    ├── utilizzo rivolto anche a non tecnici
    ├── valorizzazione del viewer 3D
    ├── esplorazione della propria abitazione/progetto
    └── possibile accesso alle stesse capacità di base con una UX diversa
```

Questa situazione è intenzionalmente ancora **sperimentale**.

Nel progetto esiste quindi una sorta di "schizofrenia" progettuale, nel senso di una **doppia identità ancora non risolta**:

- da una parte Termodel Web come evoluzione professionale del software Termodel;
- dall'altra MyHome3D come possibile interfaccia/prodotto rivolto al grande pubblico.

Non bisogna forzare prematuramente una fusione o scegliere una sola identità.

Per adesso le due direzioni possono condividere motore, viewer, dati e infrastruttura, mentre presentazione, workflow e livello di complessità dell'interfaccia possono divergere.

Ogni nuova decisione di frontend deve quindi verificare esplicitamente se riguarda:

```text
A) Termodel Web professionale
B) MyHome3D consumer
C) componenti comuni ad entrambe le identità
```

Finché la fase sperimentale non sarà conclusa, evitare di assumere che MyHome3D sia soltanto un nome alternativo di Termodel Web o che Termodel Web debba necessariamente adottare l'interfaccia consumer.

### Fase 5 — File progetto unico per la comunicazione con l'AI

Per agevolare la comunicazione tra Termodel Web, Termodel desktop, WebService e AI è stato definito un **formato progetto unico e autocontenuto**.

L'obiettivo principale è permettere che un intero progetto Termodel possa essere trasferito all'AI anche con una modalità estremamente semplice:

```text
Termodel / Termodel Web
        ↓
genera un unico testo progetto
        ↓
COPIA
        ↓
incolla nella chat AI
        ↓
AI legge / genera / modifica il progetto
        ↓
restituisce il progetto completo
        ↓
Termodel / Termodel Web lo reimporta
```

Questa scelta nasce direttamente dalla centralità dell'AI nel progetto: il formato di scambio non deve richiedere accesso diretto ai file interni del programma né manipolazione degli archivi nativi da parte dell'AI.

Il file/testo unico deve quindi raccogliere in una sola rappresentazione portabile tutto ciò che serve per comprendere e ricostruire il progetto, inclusi progressivamente geometria, manifest e archivi.

Il copia-incolla è considerato un canale di comunicazione valido e strategico perché:

- funziona con una normale chat AI;
- non richiede integrazioni proprietarie per iniziare;
- rende facile provare e collaudare il protocollo;
- mantiene il progetto autocontenuto;
- permette all'AI di restituire un risultato completo e nuovamente importabile.

Il protocollo corrente di questa idea è `TERMODEL-PROJECT-TEXT-V1`.

### Fase 6 — Prototipo CAD 2D JavaScript e convergenza CAD/BIM

È stato poi abbozzato anche un **CAD 2D in JavaScript** per consentire modifiche dirette del progetto nel browser.

L'esperimento si è rivelato particolarmente interessante perché non si limita a riprodurre un CAD tradizionale: l'idea emersa è quella di un ambiente ibrido **CAD + BIM**, nel quale la geometria 2D e gli oggetti del progetto Termodel restano collegati ai relativi dati e significati tecnici.

Schema concettuale:

```text
progetto Termodel
        │
        ├── vista / editing CAD 2D nel browser
        │
        ├── dati e oggetti BIM/Termodel
        │
        └── viewer 3D
```

Questo prototipo è apparso come il possibile **anello mancante** dell'architettura Web: non soltanto visualizzare il progetto in 3D o modificarlo tramite AI, ma offrire anche un editing manuale diretto nel browser.

L'obiettivo sperimentale è arrivare a un'alternativa di editing che riduca la dipendenza da AutoCAD per le normali modifiche del progetto Termodel, mantenendo però una logica più ricca di un semplice disegno CAD grazie alla conoscenza degli oggetti e dei dati del modello.

Il CAD/BIM 2D JavaScript è ancora in fase sperimentale e non va considerato un sostituto completo di AutoCAD già realizzato. Va però trattato come una direzione strategica importante del frontend Termodel Web.

### Fase 7 — Editing degli archivi basato sul comportamento di Termodel desktop

Dopo i risultati positivi ottenuti con viewer 3D, demo Web e CAD/BIM 2D, è iniziata l'attivazione della parte di **editing degli archivi Termodel** nel browser.

Anche in questa fase il progetto **non parte da zero**.

Il comportamento del frontend Web deve ispirarsi al Termodel desktop esistente, del quale sono stati condivisi nel repository, sotto `SorgentiTermodel/Library/`, sorgenti e materiali di riferimento da consultare **in sola lettura**.

Nel Termodel desktop la gestione degli archivi si basa già su un insieme consolidato di utilities che comprendono:

- gestione degli archivi/database XML;
- inizializzazione dei record;
- lettura e scrittura dei dati;
- generazione automatica di griglie e form;
- combo statiche e dinamiche;
- campi readonly;
- correlazioni tra archivi;
- formattazione e metadati dei campi.

Una parte fondamentale di questo meccanismo è la generazione automatica delle form a partire dal documento di definizione del database:

```text
definizionedati.json
```

Il principio da conservare anche sul Web è quindi:

```text
definizionedati.json
        ↓
metadati degli archivi e dei campi
        ↓
motore generico di gestione archivi
        ↓
griglia + form + combo + inizializzazione + CRUD
```

Non devono essere create manualmente una form JavaScript diversa per ogni archivio se il comportamento può essere derivato dai metadati, come già avviene nel Termodel desktop.

I sorgenti presenti in `SorgentiTermodel/Library/` sono **riferimenti comportamentali e tecnici in sola lettura**: servono per capire come Termodel lavora oggi e per riprodurne sul Web la logica corretta senza modificare il codice desktop durante il normale sviluppo frontend.

Riferimenti principali già condivisi:

```text
SorgentiTermodel/Library/ARCHIVI-WEB-RIFERIMENTO.md
SorgentiTermodel/Library/utilities/Utidb.cs
SorgentiTermodel/Library/definizionedati/AutoForm.cs
SorgentiTermodel/Library/definizionedati/FormArchivio.xaml
SorgentiTermodel/Library/definizionedati/FormArchivio.xaml.cs
SorgentiTermodel/Library/definizionedati/Form dettaglio.xaml
SorgentiTermodel/Library/definizionedati/Form dettaglio.xaml.cs
SorgentiTermodel/Library/examples/dbtempfiles/
```

`definizionedati.json` è un documento fondamentale e deve essere trattato come **definizione autorevole/di riferimento, non come file da adattare arbitrariamente alle esigenze del frontend**.

L'obiettivo di questa fase è trasferire nel Web il modello generico già collaudato nel desktop, non reinventare la gestione degli archivi.


---

## 2.3 Generazione modello 3D — provvisoria nel frontend, definitiva sul server

Decisione architetturale registrata il **2026-09-20**.

La generazione del modello 3D attualmente presente nel frontend Web deve essere considerata **provvisoria**, utile come anteprima e supporto durante lo sviluppo del CAD/browser.

Stato noto della generazione 3D provvisoria:

- non implementa tutte le entità e tutte le regole del modello Termodel;
- dalla v0.56 i simboli **FIN sono rappresentati visivamente** nel 3D provvisorio come parallelepipedi autonomi;
- questa rappresentazione **non crea un vero foro nella massa muraria** e non sostituisce la futura logica server;
- il parallelepipedo usa posizione, `LARGHEZZA`, `ALTEZZA` e `SOTTOFINESTRA` del FIN, viene orientato come la parete associata e ha uno spessore leggermente maggiore della parete per risultare visibile sui due lati;
- questa semplificazione non deve portare a trasformare il frontend in una seconda logica autorevole di costruzione del modello.

Direzione definitiva:

```text
progetto Termodel strutturato
        ↓
Termodel.Core
logica autorevole proveniente dal Termodel desktop
        ↓
Termodel.WebService
generazione / aggiornamento modello 3D completo
        ↓
frontend Web
visualizzazione del modello prodotto dal server
```

La generazione 3D definitiva dovrà quindi essere prodotta dal **Core/WebService** e dovrà gestire correttamente, tra le altre entità, pareti, aperture/finestre FIN e comportamento multipiano secondo le regole autorevoli di Termodel.

Conseguenza operativa:

> Non usare l'attuale generatore 3D frontend come riferimento funzionale definitivo e non espanderlo automaticamente per colmare ogni mancanza. Eventuali miglioramenti provvisori devono restare chiaramente separati dalla futura generazione server autorevole.

---

## 3. Responsabilità e confini

La divisione operativa corrente è esplicita:

```text
QUESTA CHAT
    ↓
Frontend della versione Web di Termodel
HTML / CSS / JavaScript / UI browser

CODEX
    ↓
Termodel.WebService + Termodel.Core
+ porting/implementazione delle funzioni del Termodel esistente
```

Le due aree devono essere sviluppate in modo coordinato: quando il frontend richiede una funzione che appartiene al motore o al server, questa chat deve definire il requisito/contratto e passarlo a Codex, senza reimplementare la logica autorevole nel browser.

### Questa chat — frontend Termodel Web

Responsabile di:

- HTML;
- CSS;
- JavaScript browser;
- rendering;
- griglie;
- form;
- navigazione;
- stato UI;
- BIM/CAD Web;
- Three.js / JSTS lato browser;
- workflow AI lato browser;
- motore generico `ArchivioWeb`;
- uso di provider astratti per accedere ai dati.

Non deve modificare senza coordinamento:

- Termodel desktop;
- Termodel.Core;
- Termodel.WebService;
- definizione dati autorevole;
- copie consultive della Library.

### Codex — server, Core e funzioni Termodel

Codex è responsabile principalmente di:

- Termodel.WebService;
- Termodel.Core;
- porting e implementazione delle funzioni provenienti dal Termodel desktop;
- contratti frontend/backend;
- schema autorevole lato server;
- validazione;
- DTO;
- manifest;
- protocollo progetto;
- persistenza;
- concorrenza;
- XML/JSON;
- endpoint ASP.NET Core;
- diagnostica server;
- logica applicativa che non deve essere duplicata nel JavaScript del browser.

Codex può consultare il Termodel desktop come riferimento per riportare funzioni e comportamenti nel Core/server, ma deve mantenere separati i componenti ed evitare modifiche non coordinate al frontend.

Questa chat e Codex devono lavorare in modo armonico: il frontend definisce ciò di cui ha bisogno dall'interfaccia/server; Codex realizza o espone le funzioni Core/server necessarie; il frontend le consuma attraverso contratti reali e verificati.

---

## 3.1 Direttiva obbligatoria — conformità delle view Web agli XAML desktop

Tutte le **view di Termodel Web** che corrispondono a funzioni già presenti nel Termodel desktop devono essere progettate e verificate prendendo come riferimento autorevole i relativi file **XAML presenti in `SorgentiTermodel/Library/`**.

Principio:

```text
VIEW XAML TERMODEL DESKTOP
        ↓
riferimento funzionale e visuale autorevole
        ↓
VIEW TERMODEL WEB
HTML / CSS / JavaScript
```

La view Web non deve essere inventata autonomamente quando esiste già una view desktop equivalente.

La conformità riguarda almeno:

- struttura generale della schermata;
- suddivisione in pannelli/sezioni;
- campi mostrati;
- ordine logico dei campi;
- etichette e significato dei controlli;
- controlli editabili / readonly;
- combo e relative sorgenti dati;
- pulsanti e azioni disponibili;
- modalità di selezione e modifica;
- dipendenze/correlazioni tra campi;
- comportamento operativo percepito dall'utente.

È ammesso adattare il **layout tecnico** alle caratteristiche del browser e alle dimensioni disponibili, ma senza cambiare arbitrariamente la logica della view desktop.

### Deroga esplicita CAD Web — Piano corrente nella toolbar comandi

Decisione approvata il 2026-09-20.

Per il **CAD 2D Web** è autorizzata una deroga mirata alla collocazione prevista da `MainWindow.xaml / Grid_DatiCad`, motivata dal recupero di spazio verticale nel pannello laterale.

Il box laterale generale:

```text
Dati CAD
├── Entità
├── Piano corrente + Arc
└── Layer
```

non deve essere riprodotto nel Web.

Nel CAD Web:

- il campo fisso `Entità` viene eliminato: l'entità selezionata resta identificata dall'intestazione contestuale del pannello e dallo stato CAD;
- il campo fisso `Layer` viene eliminato dalla view: il layer continua a essere derivato automaticamente da `Piani.LayerCad` e resta parte della logica interna/persistenza;
- **Piano corrente** resta obbligatorio e mantiene integralmente la semantica `Piani.Nome`;
- il combo **Piano corrente** e il relativo pulsante **Arc → Piani** vengono spostati dalla toolbar laterale al **pannello comandi superiore del CAD**;
- il cambio piano continua a filtrare il canvas e a determinare il `LayerCad` corrente come prima.

Questa è una **deroga di layout esplicitamente approvata**, non una deroga ai contratti dati o al comportamento desktop.

Restano quindi autorevoli e conformi allo XAML:

- significato di `Piano`;
- sorgente dati `Piani.Nome`;
- relazione `Piano → Piani.LayerCad`;
- funzione del pulsante `Arc`;
- regole multipiano;
- campi/Combo/readonly/correlazioni specifiche di pareti, FIN, PON, LOC e archivi.

La deroga non autorizza future rimozioni o spostamenti di controlli XAML senza una nuova decisione esplicita.

Regola pratica:

> prima di creare o modificare una view Termodel Web, individuare e leggere la view XAML desktop corrispondente e, quando necessario, il relativo `.xaml.cs`.

XAML di riferimento attualmente presenti nella Library:

```text
SorgentiTermodel/Library/MainWindow.xaml
SorgentiTermodel/Library/AI/CreaPianoDaRaster.xaml
SorgentiTermodel/Library/definizionedati/FormArchivio.xaml
SorgentiTermodel/Library/definizionedati/Form dettaglio.xaml
SorgentiTermodel/Library/leggidxf/CadGPT.xaml
SorgentiTermodel/Library/utilities/DrawBim.xaml
SorgentiTermodel/Library/utilities/FiltriGrafici.xaml
```

Esempi applicativi:

- schermata principale Web → confrontare con `MainWindow.xaml`;
- gestione archivi → `FormArchivio.xaml` e `Form dettaglio.xaml`;
- CAD Web / toolbar laterale proprietà → `MainWindow.xaml`, in particolare `Grid_DatiCad` / `Grid_pareti`;
- `leggidxf/CadGPT.xaml` → finestra storica di scambio SVG/GPT, non riferimento della toolbar CAD operativa;
- creazione piano da raster → `AI/CreaPianoDaRaster.xaml`;
- viewer/modello BIM → `utilities/DrawBim.xaml`;
- filtri grafici → `utilities/FiltriGrafici.xaml`.

I file XAML e i relativi code-behind nella Library sono **riferimenti in sola lettura** per il frontend Web, salvo interventi desktop esplicitamente coordinati.

Se una funzione Web non ha una view XAML corrispondente:

1. verificare che non esista una view equivalente con altro nome;
2. usare il comportamento desktop più vicino come riferimento;
3. documentare nel PS o nel file specialistico la nuova view e il motivo della differenza;
4. non introdurre un nuovo paradigma UI incompatibile con Termodel senza decisione esplicita.

Questa direttiva si applica anche alle view già realizzate: durante i prossimi interventi devono essere progressivamente controllate e riallineate agli XAML corrispondenti.

---

## 4. Stato corrente del frontend Web

Frontend principale:

```text
docs/termodel-ui-demo/
```

Indirizzo pubblico di esposizione del frontend:

```text
https://www.termodel.it/termodel-ui-demo/
```

Questo è l'indirizzo Web di riferimento da usare per aprire e provare Termodel Web pubblicato.

Versione corrente su `main`:

```text
Termodel Web v0.63
```

Commit frontend di riferimento per la v0.63:

```text
952b605637dc44095639e3b0b4d41fa7d06347ce  Add vector background endpoint snap v0.63
```

Ultima versione pubblica verificata manualmente dall'utente:

```text
Termodel Web v0.30
```

La v0.35 è stata verificata manualmente dall'utente il 2026-09-20: dopo l'inserimento il simbolo viene selezionato e il pannello proprietà si attiva. La v0.56 è stata verificata parzialmente nel viewer: i FIN compaiono nel 3D, ma sulle pareti esterne è emerso un problema di allineamento/profondità da correggere. Le revisioni successive fino alla v0.63 sono su `main`; v0.57-v0.63 devono essere verificate pubblicamente.

La v0.24 ha completato il primo collegamento automatico del flusso AI → progetto strutturato.

La v0.25 ha aggiunto il primo **avvio guidato del progetto personale**:

- i pulsanti Archivio e `Edita nel Cad` non sono più disabilitati nella demo;
- senza progetto strutturato aprono la finestra `Crea il tuo progetto Termodel`;
- la finestra offre `Edita nel Cad`, `Istruisci AI`, `Importa da AI`;
- `File → Nuovo` apre la stessa finestra;
- `Edita nel Cad` usa `POST /api/projects/new` per inizializzare progetto e archivi;
- il frontend sostituisce `geometry/project.svg` con uno SVG vuoto valido e apre il CAD Web;
- il CAD da zero parte con una tavola vuota e abilita `＋ Nuova linea`;
- se l'ingresso proveniva da un archivio, dopo la creazione del progetto vuoto viene aperto l'archivio richiesto;
- il browser non inventa archivi o valori tecnici: la base dati continua a provenire dal WebService.

La v0.26 rende diretto il comando **Edita nel Cad**:

```text
Edita nel Cad
    ↓
se progetto già strutturato
    → apre CAD 2D

se progetto non inizializzato
    ↓
POST /api/projects/new
    ↓
progetto strutturato vuoto
    ↓
geometry/project.svg vuoto
    ↓
apertura immediata CAD 2D
```

Il pulsante resta sempre attivo. Non deve aprire una scelta intermedia quando viene premuto direttamente.

La v0.27 collega la toolbar laterale delle pareti agli archivi del progetto, seguendo `MainWindow.xaml → Grid_DatiCad / Grid_pareti`.

Flusso:

```text
Piano
  → Piani.Nome
  → Layer readonly da Piani.LayerCad

Tipo parete
  → Pareti.DescBreve
  → Colore readonly da Pareti.Colore

Confine parete
  → Confini.Codice
  → Tipo linea readonly da Confini.Tipolinea
```

Per **Nuova linea** i valori correnti della toolbar vengono consolidati nella linea SVG tramite metadati Termodel e il colore visualizzato deriva dall'archivio Pareti.

Per **editazione linea esistente**:

- se sono presenti i metadati Termodel, vengono caricati nella toolbar;
- se il tipo parete non è ancora esplicito, il CAD prova a riconoscerlo dal colore della linea come fa il desktop con il colore DXF;
- modificando Tipo parete / Confine, la linea viene aggiornata e la resa grafica si riallinea a colore e tipo linea correlati; il selettore Piano è invece il selettore del **piano corrente** e non trasferisce implicitamente la linea tra piani;
- i pulsanti `Arc` aprono gli archivi Piani, Pareti e Confini;
- modifiche agli archivi notificano il CAD, che ricarica combo e resa grafica.

Storico v0.27: il bridge `ArchivioWeb → CAD` era inizialmente solo di lettura dei record in memoria. Dalla v0.58 la persistenza nel contenitore progetto unico è implementata tramite `buildCurrentProjectText()`.

La v0.28 rende operativo il primo **CAD 2D multipiano** sul file progetto unico:

- `Piano corrente` deriva da `Piani.Nome`;
- `Layer` resta readonly e deriva da `Piani.LayerCad`;
- il canvas mostra e rende editabili solo le entità del piano corrente;
- le nuove linee ereditano automaticamente `data-termodel-piano="<Piani.Nome>"`;
- cambiare Piano rifiltra la vista senza spostare le entità tra piani;
- gli ID E/W restano univoci nell'intero `geometry/project.svg`, non soltanto nel piano visibile;
- le entità legacy prive di `data-termodel-piano` vengono assegnate in memoria al piano corrente/default all'apertura del CAD, per mantenere la compatibilità con i progetti monopiano precedenti;
- i simboli testuali già presenti vengono filtrati per piano quando possiedono/ereditano `data-termodel-piano`, pur non essendo ancora editabili;
- `GeneraPianta.js` riceve una copia filtrata del solo piano corrente, mentre `validatedSvg` / `geometry/project.svg` continuano a conservare tutte le entità di tutti i piani;
- la pianta architettonica pulita viene mantenuta separatamente per piano quando viene rigenerata.

Questa è una separazione di **vista**, non di progetto:

```text
un solo progetto / un solo geometry/project.svg
        ↓
più piani
        ↓
CAD 2D = filtro del piano corrente
```

La generazione del **modello 3D completo multipiano** non è ancora implementata in questa revisione: il GeneraPianta/preview browser continua a lavorare sul piano corrente; il modello completo resterà una funzione da portare progressivamente nel Core/WebService.

La v0.29 corregge un difetto di inizializzazione emerso nella prova reale **Importa da AI → semplice TERMODEL-SVG-TEXT-V1 → nuovo progetto strutturato**.

Caso osservato:

```text
SVG AI monopiano senza data-termodel-piano
        ↓
processSvgText() inizializza il CAD prima che Piani sia disponibile
        ↓
nessun piano assegnato alle entità
        ↓
POST /api/projects/new
        ↓
Piani.Nome = Unico
        ↓
filtro multipiano nasconde tutte le entità
        ↓
canvas CAD vuoto
```

Correzione v0.29:

```text
processSvgText()
        ↓
creazione progetto strutturato
        ↓
loadTermodelProjectText()
        ↓
Piani disponibile
        ↓
cadSetWorkingSvg(validatedSvg) eseguito di nuovo
        ↓
cadNormalizePlaneAssignments()
        ↓
entità legacy → data-termodel-piano="<piano corrente>"
        ↓
validatedSvg aggiornato con lo SVG normalizzato
        ↓
CAD visibile sul piano corrente
```

Il formato AI legacy non viene quindi reso più rigido: per un progetto monopiano può continuare a non specificare `data-termodel-piano`; Termodel Web consolida automaticamente il piano dopo l'inizializzazione del progetto strutturato.

La v0.24 completa il primo collegamento automatico del flusso AI → progetto strutturato:

- il JSON grafico 3D desktop resta in modalità viewer-only;
- archivi e comando `Edita nel Cad` restano disabilitati finché non esiste un progetto completo;
- l'importazione di `TERMODEL-PROJECT-TEXT-V1` abilita direttamente editing archivi e CAD;
- una semplice pianta SVG AI, se non esiste ancora un progetto strutturato e il WebService dichiara `newProjectAvailable=true`, provoca automaticamente `POST http://localhost:5080/api/projects/new`;
- la risposta viene cercata in forma testuale o JSON e deve contenere `TERMODEL-PROJECT-TEXT-V1`;
- la sezione `geometry/project.svg` del progetto restituito viene sostituita con la pianta AI;
- il progetto risultante viene caricato con `loadTermodelProjectText(...)` e solo allora archivi e CAD vengono abilitati;
- se esiste già un progetto strutturato, una nuova pianta AI non crea un secondo progetto e mantiene attivo quello esistente;
- poiché il DTO esatto della POST non è ancora documentato nel repository, la v0.24 invia la richiesta minima JSON `{}` senza inventare campi. Un eventuale rifiuto HTTP viene mostrato come diagnostica e non abilita falsamente l'editing.

File centrali:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
docs/termodel-ui-demo/archivio-web.js
docs/termodel-ui-demo/definizionedati.json
docs/termodel-ui-demo/info_termodelwebservice.md
```

Dopo il commit di riferimento:

```text
d730074328f23048c913c6d3d332144f987b9a82
Add ArchivioWeb reference sources and sample archives
```

sono arrivati quattro commit:

```text
27df196  Add read-only Termodel archive schema for Web UI
d48c263  Implement generic ArchivioWeb engine v0.22
e6b623d  Activate archive menus and bump Termodel Web to v0.22
eadb724  Connect complete project import and ArchivioWeb v0.22
```

Questi commit hanno introdotto una prima implementazione reale di `ArchivioWeb`.

---

## 5. ArchivioWeb — stato attuale

File corrente:

```text
docs/termodel-ui-demo/archivio-web.js
```

È già un motore unico, non esistono form JavaScript separate per Pareti, Finestre, Zone ecc.

Attualmente contiene insieme:

```text
lettura schema
parsing TERMODEL-PROJECT-TEXT-V1
archivi in memoria
risoluzione combo
inizializzazione record
Correlato
CRUD locale
rendering HTML
stato UI
```

Funzioni già presenti:

- caricamento `definizionedati.json`;
- lettura archivi JSON dal file progetto completo;
- griglia dinamica;
- form dinamica;
- `Descr`;
- `ReadOnly`;
- combo statiche;
- `auto_combo`;
- inizializzazione tramite `Ini`;
- quarto valore opzionale di `auto_combo`;
- formattazione numerica;
- inserimento/modifica locale;
- restrizioni desktop su aggiunta/cancellazione di alcuni archivi;
- collegamento dei menu principali tramite `data-archive`.

Archivi protetti nella implementazione attuale:

```text
Finestre
Pareti
Ponti
Zone
```

La regola deriva dal comportamento attuale di `FormArchivio.xaml.cs`.

---

## 6. Problema architetturale aperto: manca ArchiveProvider

La v0.22 funziona come primo prototipo, ma la UI conosce ancora direttamente schema e dati.

Non risultano ancora implementati:

```text
ArchiveProvider
LocalArchiveProvider
TermodelWebServiceProvider
```

Architettura obiettivo:

```text
Menu archivio
      │
      ▼
  ArchivioWeb
 rendering + UI
      │
      ▼
 ArchiveProvider
   /        \
  /          \
Local       WebService
Provider    Provider futuro
```

Il frontend deve dipendere soltanto dal provider.

Contratto concettuale previsto:

```text
getSchema()
getArchiveNames()
loadArchive(name)
getRecord(name, index oppure id)
createInitializedRecord(name)
addRecord(name, record)
insertRecord(name, index, record)
updateRecord(name, index oppure id, record)
deleteRecord(name, index oppure id)
resolveCombo(name, field)
saveArchive(name, records)
```

Possibile estensione utile:

```text
getCapabilities(name)
```

per evitare regole UI hardcoded come l'elenco degli archivi nei quali aggiunta/cancellazione sono vietate.

---

## 7. Prossimo intervento frontend concordato

**Il primo flusso AI → progetto strutturato è ora implementato in v0.24.**

Flusso corrente:

```text
pianta SVG AI
      ↓
verifica WebService / newProjectAvailable
      ↓
POST /api/projects/new
      ↓
TERMODEL-PROJECT-TEXT-V1 vuoto/inizializzato
      ↓
sostituzione geometry/project.svg
      ↓
loadTermodelProjectText(...)
      ↓
archivi + CAD abilitati
```

Da verificare nel browser reale:

1. propagazione pubblica della v0.24;
2. accettazione della richiesta minima `{}` da parte del WebService;
3. risposta contenente effettivamente `TERMODEL-PROJECT-TEXT-V1`;
4. attivazione archivi/CAD dopo l'importazione AI.

Se il server rifiuta `{}`, non inventare campi: usare la diagnostica HTTP per ottenere/documentare il DTO reale lato Core/WebService.

Dopo questa verifica resta valido il refactoring di ArchivioWeb:

**Non ricominciare ArchivioWeb da zero.**

Primo refactoring consigliato:

```text
TERMODEL-PROJECT-TEXT-V1
          │
          ▼
termodel-project-text.js
          │
          ▼
LocalArchiveProvider
          │
          ▼
ArchivioWeb
```

Obiettivo del primo passo:

- mantenere il comportamento visivo corrente;
- separare parsing progetto, dati e UI;
- introdurre un provider locale sostituibile;
- nessuna API WebService inventata;
- nessuna modifica allo schema;
- nessuna modifica a Termodel desktop/Core/WebService.

File candidati:

```text
NUOVO    docs/termodel-ui-demo/archive-provider.js
NUOVO    docs/termodel-ui-demo/local-archive-provider.js
NUOVO    docs/termodel-ui-demo/termodel-project-text.js
MODIFICA docs/termodel-ui-demo/archivio-web.js
MODIFICA docs/termodel-ui-demo/app.js
```

`index.html` non dovrebbe richiedere modifiche nel primo refactoring salvo necessità emersa dai test.

---

## 8. Punti da correggere dopo/se durante il refactoring

Stato rilevato nella v0.22:

1. `Form` non viene realmente interpretato; la form usa principalmente i campi con `Descr`.
2. Se nessun campo ha `Grid:["Archivio"]`, il codice inventa un fallback di colonne: da rivalutare/eliminare.
3. `DatiCad` è nello schema ma non nell'ordine degli archivi della UI corrente.
4. `NonClimatizzati` e `DatiCad` hanno metadati insufficienti per una normale form archivio: non inventare campi frontend.
5. La cancellazione Web non chiede ancora conferma.
6. `Applica` modifica solo lo stato in memoria; non è persistenza server.
7. `Correlato` è oggi gestito dentro `archivio-web.js`; è preferibile spostare le regole dati fuori dal renderer.
8. I controlli HTML restituiscono principalmente stringhe; la tipizzazione definitiva deve restare responsabilità del livello dati/server.
9. L'hash dello schema è attualmente hardcoded nel frontend.
10. Il motore deve arrivare a gestire ogni archivio descritto dallo schema senza creare form specifiche duplicate.

---

## 9. Definizione dati — regola inderogabile

`definizionedati.json` è uno dei documenti fondamentali dell'architettura Termodel: descrive struttura, metadati e comportamento dei campi usati dalla gestione automatica degli archivi e delle form.

Nel frontend deve essere **letto e interpretato**, non alterato per semplificare la programmazione JavaScript.

La fonte autorevole originale è dichiarata come:

```text
definizionedati/definizionedati.json
```

La copia consultiva disponibile nel repository è:

```text
SorgentiTermodel/Library/definizionedati/definizionedati.json
```

La copia pubblicata per il frontend è:

```text
docs/termodel-ui-demo/definizionedati.json
```

Le due copie Git verificate al 2026-09-19 risultano identiche e corrispondono all'impronta documentata:

```text
SHA-256
29E30DE64C7D45E4613F145AC485F573DB34F4328C6CE0BC7367EB92D83AAD0B
```

Regole:

- non modificare la copia frontend per aggiungere metadati Web;
- non creare uno schema concorrente nel JavaScript;
- ogni modifica dello schema deve nascere dalla fonte autorevole ed essere autorizzata;
- le copie devono essere propagate e verificate.

Nota di stato: nel clone GitHub corrente il percorso autorevole dichiarato non è esposto direttamente; sono presenti le copie di distribuzione/consultazione. Non assumere quindi che una copia sia automaticamente aggiornata solo perché è nel repository.

---

## 10. Metadati da supportare

`ArchivioWeb` deve comprendere almeno:

```text
Descr
Ini
ReadOnly
Grid
Form
LunghezzaMassima
NumeroCifre
NumeroDecimali
Combo
Correlato
```

Combo statica:

```json
"Combo": ["Valore 1", "Valore 2"]
```

Combo dinamica:

```json
"Combo": ["auto_combo", "NomeArchivio", "NomeCampo", "ValoreInizialeOpzionale"]
```

Regola di inizializzazione derivata da `UtiDb.CreaRigaInizializzata`:

```text
1. se esiste Ini → usare Ini
2. altrimenti se è auto_combo con quarto elemento → usare il quarto elemento
3. altrimenti → null
```

Non inventare valori termotecnici mancanti.

---

## 11. Riferimenti desktop obbligatori per ArchivioWeb

I materiali presenti in `SorgentiTermodel/Library/` condividono parti significative del Termodel desktop per consentire al lavoro Web di capire e riprodurre il comportamento esistente. Per il frontend sono **materiali di sola lettura** e non un'area da modificare.

Prima di cambiare il comportamento degli archivi leggere:

```text
SorgentiTermodel/Library/ARCHIVI-WEB-RIFERIMENTO.md
SorgentiTermodel/Library/definizionedati/definizionedati.json
SorgentiTermodel/Library/utilities/Utidb.cs
SorgentiTermodel/Library/definizionedati/AutoForm.cs
SorgentiTermodel/Library/definizionedati/FormArchivio.xaml
SorgentiTermodel/Library/definizionedati/FormArchivio.xaml.cs
SorgentiTermodel/Library/definizionedati/Form dettaglio.xaml
SorgentiTermodel/Library/definizionedati/Form dettaglio.xaml.cs
SorgentiTermodel/Library/examples/dbtempfiles/
```

Gli XML di esempio servono a capire la serializzazione desktop; il browser deve continuare a lavorare internamente con:

```javascript
Array<Object>
```

e non con la struttura XML `DataContractSerializer`.

---

## 12. Stato WebService

Documento di coordinamento:

```text
docs/termodel-ui-demo/info_termodelwebservice.md
```

Endpoint verificati/documentati attualmente:

```text
GET  /
GET  /health
GET  /api/model/capabilities
POST /api/projects/new
```

`POST /api/projects/new` crea il contenitore progetto completo con SVG multipiano e archivi XML/JSON.

Dalla **v0.57** il frontend non usa più `GET /api/model/capabilities` né `POST /api/projects/new` per inizializzare un progetto durante i test browser: `Nuovo` e l'importazione di un semplice SVG usano il template statico locale derivato dal progetto base reale. Gli endpoint restano disponibili lato WebService per usi server e integrazione futura.

**Non esistono ancora API CRUD ufficiali per gli archivi.**

Il frontend non deve inventare endpoint come se fossero disponibili.

Quando servirà il provider server:

1. definire il requisito frontend;
2. proporre un contratto;
3. consegnarlo alla chat Core/WebService;
4. attendere l'implementazione/approvazione;
5. creare `TermodelWebServiceProvider` soltanto sul contratto reale.

---

## 12.1 Flusso Web — modalità progetto proveniente da JSON grafico 3D desktop

Una delle modalità di ingresso in Termodel Web parte da un **JSON grafico 3D generato da Termodel desktop**.

Flusso:

```text
Termodel desktop
        ↓
genera JSON grafico 3D
        ↓
Termodel Web
        ↓
viewer 3D
```

Questa modalità è da considerare **visualizzazione grafica** del progetto.

Con il solo JSON grafico 3D:

- il viewer 3D può essere utilizzato;
- **non si attiva la visualizzazione degli archivi Termodel**;
- **non si attiva l'editing degli archivi**;
- **non si attiva l'editing CAD/BIM 2D**.

Il motivo è architetturale: il JSON grafico contiene la rappresentazione necessaria al viewer, ma non costituisce il progetto Termodel completo con tutte le informazioni strutturate necessarie per archivi ed editing.

Quindi non bisogna dedurre dal semplice caricamento del JSON 3D che il progetto sia completamente editabile.

Questa distinzione deve restare esplicita nel frontend:

```text
JSON grafico 3D
    → VISUALIZZA 3D
    → NO archivi
    → NO editing archivi
    → NO CAD/BIM 2D
```

Le funzioni di consultazione archivi e di editing appartengono invece alla modalità in cui Termodel Web dispone di una rappresentazione progetto più completa, come il contenitore `TERMODEL-PROJECT-TEXT-V1` o futuri contratti server equivalenti.

---

## 12.2 Flusso Web — importazione di una pianta proveniente dall'AI

Quando l'utente importa in Termodel Web una **pianta generata o modificata dall'AI**, Termodel Web verifica se esiste già una struttura progetto completa e utilizzabile come base dati.

Dalla v0.57, se tale struttura **non esiste ancora**, il browser non richiede più un progetto vuoto al WebService.

Fonte del progetto base:

```text
SorgentiTermodel/Library/projects/ProgettoVuoto/
    ProgettoVuoto.termodel.txt
```

La risorsa è stata introdotta dal commit:

```text
f58a9725d0129da9809be64013e6c15ce1dd5b06
Add static empty Termodel project
```

Il file è un progetto completo reale nel formato `TERMODEL-PROJECT-TEXT-V1`, generato dal contratto effettivo del WebService e dal template `ProgettoBase`.

Per l'uso browser la v0.57 ne mantiene una copia JavaScript generata:

```text
docs/termodel-ui-demo/progetto-vuoto.js
```

Il modulo è caricato dinamicamente solo quando serve e contiene esattamente il testo della risorsa sorgente.

Flusso corrente:

```text
AI
  ↓
pianta SVG importata
  ↓
Termodel Web
  ↓
verifica presenza progetto strutturato
  ↓
se manca
  ↓
carica progetto-vuoto.js
  ↓
TERMODEL-PROJECT-TEXT-V1 base
  ↓
sostituisce geometry/project.svg con la pianta importata
  ↓
loadTermodelProjectText(...)
  ↓
archivi + CAD abilitati
```

Lo stesso template locale viene usato da `File → Nuovo` / `Edita nel Cad` quando deve essere creato un progetto vuoto.

Conseguenze operative:

- il WebService può restare spento durante i test del frontend;
- nessuna `POST /api/projects/new` viene eseguita dal frontend per questa funzione;
- nessun probe `GET /api/model/capabilities` viene eseguito all'avvio solo per decidere se Nuovo è disponibile;
- il browser non inventa archivi o campi: usa una copia verificata del progetto base reale;
- se cambia intenzionalmente il progetto base o la definizione dati autorizzata, bisogna rigenerare prima `ProgettoVuoto.termodel.txt` e poi la copia `progetto-vuoto.js`;
- il template JavaScript è un artefatto frontend di bootstrap/test, non un nuovo contratto backend.

Se esiste già un progetto strutturato, una nuova pianta AI continua a riusare quello esistente senza creare un secondo progetto.

---

## 12.3 Flusso simboli CAD — descrizione semantica e associazione agli archivi

Decisione del 2026-09-19 per **Termodel Web**:

Finestre e ponti termici provenienti dall'AI non devono essere costretti subito dentro una tipologia d'archivio se l'associazione non è ancora certa.

Gli archivi `Finestre` e `Ponti` rappresentano **tipologie**, mentre i singoli simboli `FIN` e `PON` rappresentano le **istanze disegnate**.

Flusso:

```text
utente / raster / AI
        ↓
descrizione generica dell'istanza
+ tutti i dati disponibili
        ↓
simbolo FIN / PON nello SVG
        ↓
data-termodel-descrizione="..."
        ↓
CAD Web
        ↓
confronto con archivio Finestre / Ponti
        ↓
associazione alla tipologia corretta
        ↓
TIPO = DescBreve dell'archivio
```

Regole:

- la descrizione semantica è consolidata nel simbolo SVG tramite `data-termodel-descrizione`;
- la descrizione contiene, se disponibili, tutti i dati che l'utente vuole fornire e gli elementi affidabili ricavati dall'AI;
- `data-termodel-descrizione` è un metadato del simbolo Web, **non un campo del database**;
- il collegamento formale all'archivio resta il campo `TIPO`;
- per `FIN`: `TIPO → Finestre.DescBreve`;
- per `PON`: `TIPO → Ponti.DescBreve`;
- se l'associazione è già certa, l'AI può compilare direttamente `TIPO`;
- se non è certa, nel flusso Web si usa `TIPO,Da associare` senza inventare nomi di archivio;
- il CAD Web deve usare descrizione semantica + campi standard del simbolo per proporre/completare il mapping;
- dopo il mapping la descrizione resta nel simbolo come informazione semantica e tracciabilità;
- questa regola non implica la creazione automatica di nuove righe negli archivi.

Campi standard istanza finestra `FIN`:

```text
PORTA
TIPO
LARGHEZZA
ALTEZZA
NUMEROANTE
SOTTOFINESTRA
SOPRALUCE
```

Campi standard istanza ponte `PON`:

```text
TIPO
ORIENTAMENTO
LUNGHEZZA
```

I locali `LOC` non hanno un archivio proprio. I dati dell'istanza restano direttamente nel simbolo LOC; i suoi campi possono riferirsi agli archivi `Zone`, `Pareti` e `Confini`.

Implicazione per il prossimo sviluppo CAD:

1. parser dei simboli `FIN/PON/LOC` nel `geometry/project.svg`;
2. visualizzazione e selezione dei simboli nel CAD;
3. lettura di `data-termodel-descrizione`;
4. accesso agli stessi archivi usati da ArchivioWeb;
5. proposta/assegnazione di `TIPO` a partire dalla descrizione e dai campi disponibili;
6. editing dei campi dell'istanza senza duplicare i record d'archivio.

Le istruzioni AI autorevoli sono state aggiornate in:

```text
SorgentiTermodel/Work/IstruzioniAI/TermodelGenerale.md
SorgentiTermodel/Work/IstruzioniAI/CreaPianoTermodelDaRaster.md
```

e le relative copie pubblicate in `docs/termodel-ui-demo/` devono restare allineate.

---

## 12.4 Flusso utente tipico di Termodel Web

Questo è il **percorso utente di riferimento** che deve guidare la UX e le prossime implementazioni del frontend.

### 1. Ingresso — modello dimostrativo proposto di default

Quando l'utente apre Termodel Web deve vedere subito un **modello Termodel reale di esempio** già caricato nel viewer 3D.

Scopo:

- mostrare immediatamente cosa può fare Termodel;
- permettere di esplorare viewer, menu e struttura dell'applicazione;
- non costringere l'utente a creare un progetto prima di capire il prodotto.

Il modello proposto di default è quindi una **demo esplorabile**, non ancora il progetto personale dell'utente.

### 2. Esplorazione degli archivi — invito a creare il proprio progetto

Se l'utente, mentre sta ancora guardando il modello demo, prova ad accedere agli archivi tecnici, Termodel Web deve spiegare che gli archivi appartengono a un **progetto Termodel strutturato personale**.

Non deve essere un vicolo cieco.

Il messaggio deve accompagnare l'utente verso i percorsi base disponibili:

```text
Vuoi lavorare su un tuo progetto?

A — Disegna/modifica nel CAD Web
B — Istruisci AI
C — Importa da AI
```

La demo deve quindi servire come ingresso e scoperta, mentre l'accesso ai dati editabili porta naturalmente alla creazione del progetto personale.

### 3. Edita nel CAD — punto di ingresso operativo

Il comando **Edita nel CAD** deve diventare uno dei principali punti di ingresso alla creazione/modifica del progetto.

Da qui l'utente deve poter scegliere almeno due percorsi:

```text
EDITA NEL CAD
    │
    ├── DISEGNO DA ZERO
    │      ↓
    │   template progetto vuoto locale
    │   (v0.57, nessun WebService richiesto)
    │      ↓
    │   CAD/BIM 2D Web
    │
    └── AI
           ├── Istruisci AI
           └── Importa da AI
                  ↓
              progetto strutturato
                  ↓
              CAD/BIM 2D Web
```

Il CAD non deve essere soltanto un editor di correzione successivo all'AI: deve poter diventare anche il punto di partenza manuale per un progetto nuovo.

### 4. Percorso AI

Nel percorso AI:

```text
Istruisci AI
      ↓
utente lavora con l'AI
      ↓
AI genera/modifica la pianta
      ↓
Importa da AI
      ↓
se manca un progetto strutturato
      ↓
template locale progetto-vuoto.js
      ↓
TERMODEL-PROJECT-TEXT-V1 strutturato
      ↓
archivi + CAD attivi
```

Storico: nella v0.24 il bootstrap passava da `POST /api/projects/new` ed era stato verificato con successo. Dalla v0.57 quel passaggio è stato sostituito dal template locale; il WebService non è più necessario per creare il progetto durante i test frontend.

### 5. Editing base del progetto

Una volta esistente il progetto strutturato, l'utente lavora sulle due viste complementari:

```text
PROGETTO TERMODEL
      │
      ├── editing dati
      │      ↓
      │   archivi / form / griglie
      │
      └── editing grafico
             ↓
          CAD/BIM 2D
```

Archivi e disegno devono convergere sullo stesso stato progetto.

Dalla v0.58 questa convergenza è implementata nel round-trip `TERMODEL-PROJECT-TEXT-V1 ↔ frontend`: il CAD aggiorna `geometry/project.svg`, ArchivioWeb fornisce i record correnti e `buildCurrentProjectText()` ricompone il progetto unico. Il round-trip è testato strutturalmente ma resta da collaudare manualmente nel browser con Salva → Apri.

Finestre, ponti termici e locali sono già inseribili/editabili nei limiti descritti nelle sezioni v0.33–v0.55; restano aperti trascinamento simboli, snap durante lo spostamento e vincolo LOC.

### 6. Modello coerente — accesso alle funzioni avanzate server

Quando geometria, simboli e dati del progetto sono coerenti, Termodel Web deve poter interrogare **Termodel.Core / Termodel.WebService** per le funzioni avanzate che non devono essere duplicate nel browser.

Direzione prevista:

```text
progetto Web coerente
        ↓
buildCurrentProjectText()
        ↓
TERMODEL-PROJECT-TEXT-V1 aggiornato
        ↓
Termodel.WebService / Core
        │
        ├── calcoli Termodel
        ├── generazione / aggiornamento modello 3D completo
        ├── elaborazioni BIM
        ├── IFC
        ├── XML nazionale
        └── altre funzioni tecniche portate dal desktop
        ↓
risultato restituito a Termodel Web
```

Il frontend non deve simulare come realmente disponibili funzioni server che il Core non espone ancora.

### Verifica dello stato reale alla v0.58

Confronto fra flusso desiderato e programma attuale:

| Passaggio | Stato corrente | Nota |
| --- | --- | --- |
| Apertura con modello demo 3D | **REALIZZATO** | `loadModel()` carica `TermodelWebModel.json` |
| Accesso archivi/CAD senza progetto → creazione guidata | **REALIZZATO** | progetto vuoto locale dalla v0.57, senza WebService |
| `Istruisci AI` / `Importa da AI` | **REALIZZATO** | compatibili SVG e progetto completo |
| Bootstrap progetto strutturato | **REALIZZATO LOCALMENTE** | `progetto-vuoto.js` deriva dal vero `ProgettoVuoto.termodel.txt`; v0.57 da verificare manualmente con server spento |
| Editing archivi | **REALIZZATO** | form/griglie/CRUD in memoria; dalla v0.58 le modifiche confluiscono nel progetto unico al Salva |
| CAD 2D multipiano | **REALIZZATO / IN EVOLUZIONE** | pareti, Snap/Orto, multilinea, sfondo/calibrazione, FIN/PON/LOC e pannelli contestuali |
| FIN/PON/LOC | **PARZIALMENTE COMPLETI** | inserimento e proprietà realizzati; restano trascinamento, snap in spostamento e vincolo LOC |
| Progetto unico → frontend | **REALIZZATO** | `loadTermodelProjectText(...)` + orchestrazione `loadProjectTextIntoFrontend(...)` |
| Frontend → progetto unico | **REALIZZATO IN v0.58** | `buildCurrentProjectText()` aggiorna geometria, archivi JSON/XML e manifest; test browser Salva→Apri ancora pendente |
| `File → Apri / Salva / Salva con nome` | **COLLEGATI IN v0.58** | salvataggio locale tramite download browser; non sovrascrive direttamente il file originale |
| Calcoli server reali | **NON ANCORA REALIZZATI** | pagina Calcoli resta dimostrativa |
| Modello 3D definitivo dal server | **NON ANCORA REALIZZATO** | il 3D browser è provvisorio; Core/WebService saranno autorevoli |
| BIM/IFC via server | **SOLO DIREZIONE PREVISTA / UI DIMOSTRATIVA** | nessun flusso server completo verificato |

### Conseguenza per la UX e l'architettura

Il consolidamento del progetto unico non è più un obiettivo futuro: dalla v0.58 esiste il round-trip di base.

Le priorità ora sono:

1. collaudare realmente Apri/Salva del progetto unico nel browser con WebService spento;
2. usare **la stessa** `buildCurrentProjectText()` come sorgente del futuro invio al WebService;
3. correggere i limiti visivi noti del 3D provvisorio senza trasformarlo nel motore definitivo;
4. completare le interazioni mancanti dei simboli CAD;
5. soltanto dopo collegare progressivamente le funzioni autorevoli Core/WebService.

---

## 12.5 File unico e CAD 2D multipiano

Decisione architetturale del 2026-09-20.

Il **file progetto unico** rappresenta l'intero progetto Termodel e può contenere **più piani fisici**.

Il CAD 2D Web deve riflettere la stessa filosofia: non deve essere pensato come un editor separato di un singolo disegno isolato, ma come una vista/editazione filtrata del progetto multipiano.

Principio:

```text
TERMODEL-PROJECT-TEXT-V1
        ↓
progetto unico
        ↓
archivio Piani
        │
        ├── Piano 1
        ├── Piano 2
        ├── Piano 3
        └── Copertura
        ↓
CAD 2D
        ↓
visualizza / modifica il PIANO CORRENTE
```

### Significato di Piano e Layer

Nel Termodel desktop il campo `LayerCad` dell'archivio `Piani` deriva dalla filosofia di editing nativo AutoCAD/DXF.

Il desktop usa infatti:

```text
Piani.Nome
        ↓
Piani.LayerCad
        ↓
LeggiFileDxf(..., layerCad, ...)
        ↓
filtro delle linee e dei blocchi sul layer fisico del piano
```

Questa relazione è verificata nei sorgenti desktop:

- `GeneraModello.cs` passa `LayerCad` a `LeggiFileDxf`;
- `LeggiDxf.cs` seleziona linee e blocchi appartenenti al layer richiesto.

Nel Web la stessa semantica deve essere conservata.

`Piano` è la scelta logica corrente dell'utente e deriva da:

```text
Piani.Nome
```

Il campo `Layer` della toolbar CAD resta **readonly** e deriva da:

```text
Piani.Nome
    ↓
Piani.LayerCad
```

Il layer non deve diventare un secondo selettore indipendente del piano: è la rappresentazione CAD nativa associata al piano fisico.

### Regola del piano corrente

Il CAD Web deve mantenere uno stato esplicito di **piano corrente**.

Quando l'utente seleziona un piano:

1. la toolbar imposta `Piano = Piani.Nome`;
2. `Layer` mostra il relativo `Piani.LayerCad`;
3. il canvas filtra e rende editabili le entità appartenenti a quel piano;
4. le entità degli altri piani restano nel progetto unico ma non appartengono alla vista corrente;
5. l'utente può cambiare piano senza caricare un altro progetto.

Flusso:

```text
selettore Piano
      ↓
Piano corrente
      ↓
filtro CAD 2D
      ↓
solo entità del piano corrente
      ↓
modifica
      ↓
il file progetto unico conserva tutti i piani
```

### Nuove entità

Ogni nuova entità creata nel CAD deve ereditare automaticamente il **piano corrente**.

Per le entità SVG Web il riferimento semantico corrente è:

```text
data-termodel-piano="<Piani.Nome>"
```

Il valore non deve essere scelto separatamente durante il disegno: deriva dal piano attivo nella toolbar.

La correlazione con il layer è:

```text
data-termodel-piano
        ↓
Piani.Nome
        ↓
Piani.LayerCad
```

Questa regola deve valere progressivamente per tutte le entità CAD:

- pareti `E/W`;
- finestre/porte `FIN`;
- ponti termici `PON`;
- locali `LOC`;
- altre future entità grafiche Termodel.

### Editazione di entità esistenti

Quando viene selezionata una entità già presente:

- il CAD deve riconoscere il piano a cui appartiene;
- la toolbar deve mostrare quel piano e il relativo LayerCad;
- una entità appartenente a un altro piano non deve essere normalmente editabile nella vista del piano corrente;
- il cambio di piano deve avvenire tramite il selettore del piano corrente, non spostando casualmente entità tra layer.

L'eventuale trasferimento esplicito di una entità da un piano a un altro deve essere trattato come una modifica semantica del suo `data-termodel-piano`, non come semplice cambio grafico di colore/layer.

### Stato reale della v0.29

La v0.28 realizza il primo comportamento multipiano effettivo; la v0.29 corregge l'ordine di inizializzazione dell'import AI legacy così che le entità senza piano vengano consolidate dopo il caricamento dell'archivio Piani:

- la toolbar `Piano corrente` legge `Piani.Nome`;
- `Layer` è readonly e deriva da `Piani.LayerCad`;
- `cadEditableSourceLines()` restituisce soltanto le E/W del piano corrente;
- il rendering del canvas filtra linee e simboli testuali sul piano corrente;
- le nuove linee ricevono automaticamente `data-termodel-piano`;
- il cambio Piano deseleziona l'entità corrente e rifiltra il canvas senza modificare il progetto;
- gli ID delle nuove E/W vengono calcolati sull'intero progetto per evitare duplicati tra piani;
- le entità di vecchi progetti monopiano prive dell'attributo Piano vengono normalizzate sul piano default all'apertura;
- la rigenerazione architettonica usa soltanto una copia del piano corrente ma conserva intatto il documento SVG multipiano completo.

Restano da completare:

- editing multipiano reale di `FIN/PON/LOC`;
- eventuale comando esplicito per trasferire una entità da un piano a un altro;
- persistenza unificata CAD + archivi nel contenitore `TERMODEL-PROJECT-TEXT-V1`;
- generazione/aggiornamento del modello 3D completo multipiano tramite Core/WebService.

### Comportamento multipiano di riferimento

```text
apertura CAD
    ↓
leggi Piani
    ↓
scegli / ripristina piano corrente
    ↓
mostra solo entità di quel piano
    ↓
Nuova linea
    ↓
assegna automaticamente data-termodel-piano
    ↓
cambio Piano
    ↓
canvas rifiltrato
    ↓
stesso file progetto unico
```

Questo comportamento è implementato per le pareti E/W nella v0.28 e deve essere esteso senza cambiare filosofia a `FIN/PON/LOC`.

Questo principio multipiano ha precedenza sulle implementazioni CAD che assumono implicitamente un solo piano.

---

## 12.6 Simbolo accessorio Nord — orientamento della pianta e del modello 3D

Decisione architetturale del 2026-09-20.

Il simbolo **Nord** è un simbolo accessorio permanente del progetto Termodel e rappresenta l'orientamento della pianta rispetto al Nord geografico positivo.

Non è un elemento edilizio e non appartiene agli archivi Pareti/Finestre/Ponti/Locali.

### Scopo

Il Nord serve come riferimento stabile per:

- orientamento dell'edificio;
- lettura corretta delle esposizioni;
- collegamento con il percorso del sole;
- future funzioni solari, energetiche e di ombreggiamento;
- coerenza tra CAD 2D e modello 3D.

### Persistenza

Il simbolo deve essere registrato in almeno uno SVG del progetto e deve sopravvivere a:

- salvataggio;
- ricarica;
- import/export;
- editing CAD;
- passaggio tra viste;
- rigenerazione del modello.

La rappresentazione SVG concreta deve essere definita in una implementazione successiva senza inventare contratti incompatibili con il progetto esistente.

### Presenza obbligatoria nel modello 3D

Il viewer/modello 3D deve mostrare il simbolo Nord **d'ufficio**, anche quando il progetto non contiene ancora una definizione esplicita.

Regola:

```text
orientamento Nord definito
        ↓
simbolo Nord nel 3D
ruotato nella direzione corretta

orientamento Nord NON definito
        ↓
simbolo Nord comunque presente nel 3D
        +
indicatore "?"
        ↓
orientamento sconosciuto / da confermare
```

Il sistema **non deve inventare un orientamento convenzionale** quando il dato manca.

Il simbolo con `?` significa esplicitamente:

> Nord presente come riferimento grafico, ma orientamento reale non ancora definito o confermato.

Quando l'utente definisce l'orientamento:

- il `?` scompare;
- il simbolo assume la direzione corretta;
- CAD 2D e modello 3D devono utilizzare lo stesso valore di orientamento.

### Editing

Prima implementazione accettabile:

- campo numerico/testuale dell'angolo di orientamento;
- aggiornamento immediato del simbolo.

Evoluzione UX preferibile:

- controllo grafico più intuitivo, ad esempio rotazione diretta/ghiera/bussola;
- mantenendo comunque disponibile il valore numerico preciso.

### Relazione con il CAD multipiano

Il Nord è un riferimento di **progetto/edificio**, non una normale entità appartenente a un singolo piano.

Pertanto il suo orientamento deve restare coerente quando l'utente cambia piano nel CAD 2D.

Il simbolo può essere rappresentato graficamente nella vista del piano corrente, ma il valore di orientamento non deve cambiare passando da un piano all'altro salvo decisione futura esplicita di supportare orientamenti indipendenti, che oggi non è prevista.

### Implementazione v0.30

La v0.30 introduce la prima implementazione reale del simbolo Nord.

Contratto SVG frontend corrente:

```xml
<g id="termodel-north"
   data-termodel-accessorio="NORD"
   data-termodel-orientamento="?" />
```

oppure, quando definito:

```xml
<g id="termodel-north"
   data-termodel-accessorio="NORD"
   data-termodel-orientamento="45" />
```

Il gruppo è salvato a livello radice dello SVG di progetto, quindi:

- non appartiene a un singolo piano;
- non viene filtrato dal cambio Piano;
- è presente anche nei nuovi progetti;
- viene aggiunto automaticamente agli SVG legacy che non lo contengono.

Convenzione:

```text
0°   = Nord verso l'alto della pianta
90°  = Nord verso destra
180° = Nord verso il basso
270° = Nord verso sinistra
angoli positivi = senso orario
```

CAD 2D:

- bussola permanente visibile sulla tavola;
- controllo laterale `Orientamento edificio · Nord`;
- checkbox `Orientamento definito`;
- slider 0–359°;
- valore numerico modificabile;
- se non definito, viene mostrato `N ?`.

Viewer 3D:

- il Nord viene aggiunto d'ufficio ad ogni modello visualizzato;
- se definito, una freccia 3D indica la direzione coerente con lo stesso angolo del CAD;
- se non definito, compare `N ?` senza freccia orientata;
- il simbolo non partecipa ai filtri grafici del modello edilizio.

Persistenza:

- la creazione di un nuovo progetto normalizza `geometry/project.svg` aggiungendo il simbolo Nord;
- l'importazione di SVG legacy aggiunge il simbolo e aggiorna lo SVG di lavoro;
- la modifica del Nord aggiorna lo SVG corrente/esportabile;
- la persistenza unificata nel contenitore progetto completo resta legata al futuro consolidamento dello stato progetto unico.

### Rifinitura v0.31

La v0.31 migliora esclusivamente la resa grafica del Nord senza cambiare il contratto SVG o la convenzione angolare:

- simbolo Nord in pianta ridotto e spostato con maggiore margine di rispetto per evitare di coprire la geometria;
- il `?` della bussola laterale viene nascosto esplicitamente appena l'orientamento è definito;
- la punta della freccia della bussola laterale è orientata verso l'esterno;
- nessuna modifica alla persistenza `data-termodel-orientamento`.

### Rifinitura v0.32

La v0.32 aumenta ulteriormente il margine di rispetto del simbolo Nord in pianta: il simbolo viene spostato più verso il bordo esterno alto-destra, mantenendo invariati dimensione, contratto SVG e orientamento.

### Rifinitura v0.37 — pannello Nord contestuale

Per recuperare spazio nella colonna proprietà, il pannello Nord non è più sempre visibile.

Comportamento:

- il pannello `Orientamento edificio · Nord` è chiuso di default;
- il simbolo Nord nel canvas CAD è cliccabile;
- cliccando il simbolo Nord si apre il pannello contestuale;
- quando il Nord è aperto, le sezioni proprietà parete/simbolo vengono nascoste;
- l'intestazione diventa `Dati CAD · Nord`;
- il pannello contiene un pulsante `×` per richiuderlo;
- selezionando una parete o un altro simbolo, iniziando un nuovo inserimento o cambiando piano, il pannello Nord si richiude automaticamente;
- chiudendo il pannello torna il normale contesto proprietà CAD;
- la persistenza e il contratto SVG del Nord restano invariati.

### Stato

**IMPLEMENTATO IN v0.30 E RIFINITO IN v0.31/v0.32/v0.37**.

---

## 12.7 Simboli CAD spostabili con attributi — eredità dei blocchi AutoCAD

Decisione architetturale del 2026-09-20.

Una parte fondamentale del CAD Termodel deriva dalla logica storica dei **blocchi AutoCAD con attributi**.

Nel Web questa filosofia non deve essere ridotta a semplici etichette grafiche: i simboli devono diventare **entità strutturali dello SVG**, selezionabili, spostabili e, quando previsto, dotate di attributi editabili.

Principio:

```text
blocco AutoCAD
    ↓
simbolo semantico SVG
    ↓
posizione grafica
+ eventuali attributi Termodel
    ↓
selezione nel CAD 2D
    ↓
pannello laterale
    ↓
spostamento / modifica attributi
    ↓
persistenza nello SVG di progetto
```

### Categorie di simboli

#### 1. Simbolo di allineamento

Il simbolo di allineamento è un simbolo grafico **senza attributi tecnici propri**.

Deve comunque essere:

- parte permanente dello SVG;
- selezionabile;
- spostabile nel CAD 2D;
- associato al piano a cui appartiene, quando il suo significato è legato a uno specifico piano;
- persistente dopo salvataggio, import/export e riapertura.

La sua editazione riguarda principalmente la **posizione**, non un insieme di campi tecnici.

#### 2. Porte e finestre

Porte e finestre sono simboli spostabili con attributi.

Nel protocollo SVG corrente rientrano nella famiglia `BLOCCO,FIN`, con distinzione semantica tramite gli attributi già previsti, compreso `PORTA`.

Devono poter essere:

- selezionate;
- spostate lungo la parete/nel punto corretto;
- mantenute agganciate geometricamente alla parete;
- modificate tramite il pannello laterale;
- collegate all'archivio Finestre attraverso `TIPO → Finestre.DescBreve`;
- corredate dalla descrizione semantica persistente `data-termodel-descrizione` quando disponibile.

Gli attributi di istanza, ad esempio larghezza, altezza, numero ante, sottofinestra e sopraluce, appartengono al simbolo e non devono essere confusi con la tipologia di archivio.

#### 3. Ponti termici

I ponti termici `BLOCCO,PON` sono simboli spostabili con attributi.

Devono poter essere:

- selezionati;
- spostati mantenendo il corretto rapporto geometrico con la parete;
- modificati dal pannello laterale;
- collegati all'archivio Ponti attraverso `TIPO → Ponti.DescBreve`;
- corredati da `data-termodel-descrizione` quando disponibile.

Attributi correnti già definiti:

```text
TIPO
ORIENTAMENTO
LUNGHEZZA
```

#### 4. Locali

I locali `BLOCCO,LOC` sono simboli spostabili con attributi.

Non esiste un archivio `Locali`: i dati del locale restano direttamente sul simbolo.

Il simbolo LOC deve:

- essere selezionabile;
- essere spostabile;
- restare geometricamente **dentro il poligono del locale**;
- mostrare/modificare i propri attributi nel pannello laterale;
- continuare a riferire gli archivi Zone/Pareti/Confini dove previsto.

Lo spostamento manuale non deve permettere di lasciare il simbolo LOC fuori dal locale a cui appartiene senza segnalazione/correzione.

### Selezione e pannello laterale

La toolbar/pannello laterale del CAD deve diventare contestuale all'entità selezionata.

Schema:

```text
nessuna entità selezionata
    ↓
dati correnti per nuova entità

parete E/W selezionata
    ↓
pannello proprietà parete

FIN selezionato
    ↓
pannello porta/finestra

PON selezionato
    ↓
pannello ponte termico

LOC selezionato
    ↓
pannello locale

simbolo allineamento selezionato
    ↓
pannello minimale / posizione
```

La view Web deve restare conforme alle view XAML desktop disponibili; quando manca una view dedicata, usare il comportamento desktop equivalente senza inventare nuovi contratti dati.

### Spostamento

I simboli accessori devono poter essere trascinati nel CAD 2D.

Lo spostamento deve modificare la **posizione dell'istanza SVG**, non la tipologia di archivio associata.

Regole geometriche:

- FIN → resta/snap sulla parete;
- PON → resta/snap sulla parete;
- LOC → resta all'interno del locale;
- allineamento → posizione libera secondo il significato del simbolo;
- Nord → resta un simbolo di progetto separato e segue le regole della sezione 12.6, non questa logica di istanza di piano.

### Attributi e persistenza SVG

Gli attributi modificabili devono restare parte della rappresentazione SVG del progetto.

Il CAD Web non deve mantenere proprietà dei simboli soltanto in variabili JavaScript temporanee.

Principio:

```text
simbolo SVG
    ├── posizione
    ├── piano
    ├── tipo semantico
    └── attributi Termodel
         ↓
fonte persistente per editing CAD
```

Per i simboli derivati dai blocchi AutoCAD, lo SVG è quindi contemporaneamente:

- rappresentazione grafica;
- contenitore delle proprietà di istanza;
- collegamento alle tipologie degli archivi;
- formato leggibile/modificabile dall'AI.

Non devono essere inventati campi database per memorizzare proprietà che appartengono naturalmente all'istanza grafica.

### Multipiano

FIN, PON, LOC e gli altri simboli di piano devono ereditare automaticamente:

```text
data-termodel-piano="<Piani.Nome>"
```

del piano corrente quando vengono creati.

Il cambio del piano corrente deve:

- filtrare i simboli visibili/editabili come già avviene per le pareti;
- lasciare intatti i simboli degli altri piani nel file progetto unico;
- non trasferire implicitamente un simbolo da un piano a un altro.

### Obiettivo di implementazione

La prossima evoluzione del CAD 2D deve introdurre un **parser/editor generico dei simboli SVG** capace di:

1. riconoscere il simbolo dal contenuto `BLOCCO,<tipo>`, non soltanto dal prefisso dell'ID;
2. selezionarlo nel canvas;
3. caricare posizione e attributi nel pannello laterale;
4. consentire lo spostamento con le regole geometriche specifiche;
5. modificare gli attributi;
6. aggiornare lo SVG di progetto;
7. mantenere il collegamento con gli archivi;
8. supportare undo/redo e rigenerazione come per le pareti.

Questa logica deve essere condivisa e non implementata con codice separato e incompatibile per ogni singolo simbolo.

### Implementazione v0.33 — inserimento simboli

La v0.33 attiva nella toolbar CAD i primi comandi di inserimento:

```text
＋ Allinea
＋ Porta/Finestra
＋ Ponte
＋ Locale
```

Il comando `Porta/Finestra` segue la filosofia desktop: entrambi sono istanze del blocco `FIN`; il campo `PORTA` nei DatiCad distingue la struttura trasparente dall'eventuale porta/superficie opaca.

Flusso operativo:

```text
Piano corrente
    ↓
Piani.Nome
    ↓
Piani.LayerCad
    ↓
selezione comando simbolo
    ↓
clic nel CAD
    ↓
simbolo inserito nello SVG
    ↓
data-termodel-piano = Piano corrente
data-termodel-layer = LayerCad corrente
```

Regole implementate:

- il layer non viene chiesto all'utente: viene derivato da `Piani.LayerCad` del piano corrente;
- anche le nuove pareti E/W ricevono ora `data-termodel-layer` derivato;
- le entità legacy normalizzate dal CAD ricevono, quando disponibile, il layer coerente con il proprio `data-termodel-piano`;
- `Allinea` crea un simbolo `BLOCCO,ALLINEA` senza attributi tecnici;
- `Porta/Finestra` crea un `BLOCCO,FIN` usando i valori correnti di `DatiCad`;
- le dimensioni FIN provenienti da DatiCad desktop in metri vengono consolidate nello SVG in centimetri, coerentemente con il contratto AI corrente;
- `Ponte` crea un `BLOCCO,PON` con i valori correnti di `DatiCad`;
- `Locale` crea un `BLOCCO,LOC` con i valori correnti di `DatiCad`;
- FIN e PON vengono inseriti soltanto vicino a una parete e proiettati sulla parete del piano corrente;
- Allinea e LOC vengono inseriti nel punto scelto;
- l'inserimento partecipa a undo/redo;
- il rendering CAD riconosce ora i simboli dal contenuto `BLOCCO,<tipo>`, non dal solo prefisso dell'ID.

Restano da sviluppare nella sezione 12.7:

- selezione diretta dei simboli nel canvas;
- trascinamento/spostamento;
- snap durante lo spostamento di FIN/PON;
- vincolo LOC dentro il locale;
- pannello laterale contestuale per FIN/PON/LOC;
- modifica e consolidamento degli attributi dopo la selezione;
- eliminazione del simbolo selezionato.

### Correzione v0.34 — feedback e attivazione comando simbolo

La prova utente della v0.33 ha evidenziato che la pressione di `＋ Porta/Finestra` poteva apparire senza effetto.

La v0.34 rende l'attivazione del comando indipendente dall'aggiornamento del pannello laterale e introduce feedback immediato:

- il pulsante attivo cambia in `× Porta/Finestra` (analogamente per gli altri simboli);
- il canvas passa a cursore a mirino;
- la barra di stato indica immediatamente `clicca vicino a una parete` per FIN/PON;
- per Allinea/Locale indica `clicca il punto di inserimento`;
- eventuali problemi nel refresh del pannello laterale non interrompono più l'attivazione del comando;
- `Esc` o una seconda pressione sul pulsante annullano la modalità inserimento.

### Implementazione v0.35 — selezione e pannello proprietà simbolo

La v0.35 collega l'inserimento dei simboli al pannello laterale contestuale.

Dopo l'inserimento:

```text
simbolo creato
    ↓
diventa automaticamente selezionato
    ↓
pannello laterale cambia contesto
    ↓
mostra proprietà del simbolo
```

Comportamento:

- il simbolo appena inserito diventa l'entità selezionata;
- le sezioni specifiche delle pareti vengono nascoste;
- FIN/PON/LOC mostrano nel pannello le coppie `CHIAVE,VALORE` presenti nei propri `tspan`;
- Allinea mostra il pannello minimale e non inventa attributi tecnici;
- gli attributi del simbolo possono essere modificati e applicati direttamente allo SVG;
- un simbolo già presente può essere ricliccato nel canvas per riaprire lo stesso pannello;
- la selezione di una parete deseleziona il simbolo e viceversa;
- il pannello mostra anche posizione, Piano corrente e LayerCad del contesto;
- la modifica degli attributi partecipa a undo/redo attraverso lo stesso SVG di lavoro.

Restano da completare:

- trascinamento/spostamento dei simboli;
- snap durante lo spostamento FIN/PON;
- vincolo LOC dentro il locale;
- eliminazione simbolo selezionato;
- sostituzione progressiva dei campi testuali generici con controlli archivio-aware dove previsto.

### Implementazione v0.36 — pannelli simbolo conformi a MainWindow.xaml / DatiCad

La v0.36 sostituisce il pannello testuale generico della v0.35 con controlli coerenti con i sorgenti desktop consultati in sola lettura:

```text
MainWindow.xaml
        +
definizionedati.json / DatiCad
        +
ScriptCad.cs
        ↓
pannello simbolo Web
```

Regole implementate:

- se il campo DatiCad possiede `Combo`, il Web usa una select come il ComboBox desktop;
- le combo `auto_combo` leggono i valori dall'archivio del progetto indicato in `definizionedati.json`;
- i valori extra definiti dopo `auto_combo,Archivio,Campo` vengono conservati;
- i campi numerici usano `NumeroDecimali` per lo step;
- i campi `ReadOnly` restano readonly/disabilitati;
- i pulsanti `Arc` sono presenti sui campi che MainWindow.xaml collega a un archivio;
- `Arc` apre l'ArchivioWeb corrispondente senza inventare nuovi contratti;
- il pannello viene rigenerato quando gli archivi cambiano.

Collegamenti Arc verificati dai riferimenti desktop:

```text
FIN
Porta o sup. opaca → Pareti.DescBreve → Arc Pareti
Tipo finestra      → Finestre.DescBreve → Arc Finestre

PON
Tipo ponte         → Ponti.DescBreve → Arc Ponti

LOC
Zona               → Zone.Descrizione → Arc Zone
Tipo Soffitto      → Pareti.DescBreve → Arc Pareti
Confine Soffitto   → Confini.Codice → Arc Confini
Tipo Pavimento     → Pareti.DescBreve → Arc Pareti
Confine Pavimento  → Confini.Codice → Arc Confini
```

La v0.36 riproduce anche i campi sorgente usati dal desktop:

- PON: `FonteLunghezzaPonte` determina se `LUNGHEZZA` è valore imposto oppure `Lunghezza parete / Altezza parete`;
- LOC: `FonteAltezza` determina se `ALTEZZALORDA/ALTEZZANETTA` sono `Da piano` oppure valori imposti;
- LOC: `FonteQuotaPavimento` determina se `QUOTAPAVIMENTO` è `Da piano` oppure valore imposto.

Per FIN le misure continuano a essere mostrate nel pannello in metri come in XAML ma persistite nello SVG in centimetri come richiesto dal contratto AI corrente.

I campi mostrati sono quelli del pannello XAML necessari a rappresentare gli attributi realmente consolidati nei blocchi SVG; non vengono aggiunti al simbolo campi database non presenti nel contratto.

### Stato

**PARZIALMENTE IMPLEMENTATO IN v0.36 — INSERIMENTO + SELEZIONE + PANNELLI XAML/ARCHIVI ATTIVI; SPOSTAMENTO DA COMPLETARE.**

---

## 12.8 Sfondo CAD per piano — raster o vettoriale

Decisione architetturale del 2026-09-20.

Ogni piano del progetto può avere **un proprio disegno di sfondo** utilizzato come riferimento visivo durante l'editing CAD 2D.

Lo sfondo:

- non è un elemento edilizio;
- non appartiene agli archivi Pareti/Finestre/Ponti/Locali;
- è un accessorio grafico del piano;
- viene mostrato sotto le entità CAD semantiche;
- non deve essere interpretato come geometria Termodel da GeneraPianta.

### Implementazione v0.40

La toolbar CAD introduce:

```text
＋ Aggiungi sfondo
```

Formati inizialmente supportati:

```text
SVG vettoriale
PNG
JPEG
WebP
GIF
BMP
```

Flusso:

```text
Piano corrente
    ↓
Aggiungi sfondo
    ↓
scelta file raster / SVG
    ↓
incorporazione nello SVG progetto
    ↓
associazione data-termodel-piano
    ↓
visualizzazione sotto il Disegno input
```

### Contratto SVG frontend

Gli sfondi sono raccolti in un gruppo radice:

```xml
<g id="termodel-backgrounds"
   data-termodel-accessorio="SFONDI">
   ...
</g>
```

Ogni piano può contenere al massimo uno sfondo corrente, rappresentato come elemento `image` con almeno:

```text
data-termodel-sfondo="1"
data-termodel-piano="<Piani.Nome>"
data-termodel-layer="<Piani.LayerCad>"
data-termodel-sfondo-tipo="raster | vector"
data-termodel-nome-file="..."
```

Il contenuto del file viene incorporato tramite data URL nell'attributo `href`.

Per uno SVG importato questo mantiene la natura vettoriale durante la visualizzazione/zoom anche se viene trattato come immagine di riferimento non editabile.

### Multipiano

- lo sfondo mostrato è soltanto quello del piano corrente;
- cambiando piano cambia automaticamente lo sfondo;
- l'importazione di un nuovo sfondo sullo stesso piano sostituisce il precedente;
- il filtro multipiano usato per `generaPiantaDaSvg()` mantiene soltanto lo sfondo del piano corrente;
- lo sfondo non viene trasferito implicitamente tra piani.

### Pianta pulita

La precedente modalità CAD che mostrava come sfondo la **Pianta pulita** generata da `GeneraPianta/JSTS` è **sospesa dalla visualizzazione CAD a partire dalla v0.40**.

Importante:

- `plan.svgPulito` continua a essere generato e mantenuto dove serve al motore;
- non viene eliminata la funzione;
- semplicemente non viene più usata come layer di fondo del CAD;
- la funzione potrà essere riattivata in futuro se necessaria.

### Posizionamento iniziale

Nella v0.40 lo sfondo importato viene adattato al `viewBox` corrente della pianta con:

```text
preserveAspectRatio = xMidYMid meet
```

Questa è una prima implementazione.

Sono esplicitamente rinviati:

- traslazione manuale dello sfondo;
- scala/calibrazione;
- rotazione;
- opacità regolabile;
- aggancio a punti di riferimento;
- eventuale gestione separata degli asset raster nel contenitore progetto.

### Persistenza e dimensione progetto

Nella v0.40 il file viene incorporato direttamente nello SVG tramite data URL.

Questo rende lo sfondo autosufficiente e persistente, ma un raster di grandi dimensioni può aumentare molto la dimensione di `geometry/project.svg` e quindi del contenitore progetto destinato anche all'AI.

Questa scelta è accettata **solo come prima implementazione frontend**.

Non viene introdotto per ora un nuovo contratto backend o una sezione asset del progetto senza una decisione architetturale specifica.

### Undo / redo

L'aggiunta o sostituzione dello sfondo partecipa allo stesso stack undo/redo del CAD.

### Implementazione v0.41 — visibilità e calibrazione geometrica

La v0.41 aggiunge due funzioni:

1. checkbox `Sfondo` nella toolbar CAD per mostrare/nascondere lo sfondo importato del piano corrente;
2. calibrazione geometrica dello sfondo e del disegno del piano corrente usando una parete ortogonale come riferimento.

Non è stato trovato nei sorgenti desktop consultati (`MainWindow.xaml`, `MainWindow.xaml.cs`, `leggidxf/ScriptCad.cs`) un comando di calibrazione equivalente. La calibrazione è quindi una **nuova funzione specifica del CAD Web**, senza modifica dello schema dati o dei sorgenti desktop.

#### Attivazione

Quando viene selezionata una parete E/W:

- se è orizzontale → compare il box laterale `Calibrazione sfondo`;
- se è verticale → compare il box laterale `Calibrazione sfondo`;
- se è inclinata → il box non viene attivato;
- se il piano corrente non ha uno sfondo → il box può mostrare il riferimento ma `Calibra` resta disabilitato.

La tolleranza ortogonale frontend iniziale è:

```text
CAD_CALIBRATION_ORTHO_EPSILON = 0.05 cm
```

#### Flusso

```text
seleziona parete orizzontale/verticale
        ↓
leggi lunghezza SVG corrente
        ↓
inserisci Misura reale (m)
        ↓
Calibra
        ↓
targetCm = misura_m × 100
        ↓
fattore = targetCm / lunghezzaCorrenteCm
        ↓
ridimensiona geometria del piano corrente
+ sfondo del piano corrente
```

Il **primo estremo della parete selezionata** viene usato come punto fisso/pivot della trasformazione.

#### Cosa viene scalato

Sul solo piano corrente vengono scalati:

- tutti gli elementi SVG `line` del disegno;
- le posizioni grafiche dei simboli testuali Termodel, per mantenerli allineati alla geometria;
- posizione, larghezza e altezza dello sfondo importato.

Non vengono moltiplicati gli attributi tecnici dei simboli FIN/PON/LOC: la calibrazione modifica la geometria/posizione, non la tipologia di archivio o i dati tecnici di istanza.

Gli altri piani non vengono geometricamente scalati.

Dopo la calibrazione:

- il `viewBox` di progetto viene ricalcolato sull'estensione complessiva;
- il viewport CAD viene centrato sul piano corrente;
- il simbolo Nord viene rigenerato sul nuovo `viewBox` mantenendo invariato il proprio orientamento;
- la parete di riferimento resta selezionata;
- l'operazione partecipa a undo/redo;
- il progetto resta dirty fino a `Rigenera pianta`.

### Stato

**IMPLEMENTATO IN v0.40/v0.41 — DA VERIFICARE MANUALMENTE.**

---

## 12.9 Modalità Orto CAD — v0.42

La v0.42 aggiunge nella toolbar CAD il check:

```text
Orto
```

posizionato accanto a `Snap`.

Scopo immediato: consentire di disegnare rapidamente pareti perfettamente orizzontali o verticali, utile anche per creare un riferimento affidabile per la calibrazione sfondo della v0.41.

Comportamento corrente:

- `Orto` agisce sulla creazione delle **nuove linee E/W**;
- il primo punto viene scelto normalmente e può usare `Snap`;
- dopo il primo punto, l'estremo mobile viene vincolato automaticamente:
  - orizzontale se prevale lo spostamento X;
  - verticale se prevale lo spostamento Y;
- la preview rossa mostra già la linea ortogonale;
- il secondo clic consolida nello SVG una linea con coordinate esattamente orizzontali o verticali;
- `Snap` e `Orto` possono restare entrambi attivi;
- uno Snap viene accettato soltanto se il punto agganciato rispetta l'asse ortogonale corrente; in caso contrario prevale `Orto`;
- lo stato CAD mostra `ORTO` durante la costruzione e dopo la creazione della linea.

La v0.42 **non raddrizza automaticamente linee esistenti** e non applica ancora il vincolo Orto al trascinamento degli estremi di una parete già disegnata.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
8a22f57fa50a1100d20bddba258c9495fd816da7
Add orthogonal CAD drawing mode v0.42
```

### Stato

**IMPLEMENTATO IN v0.42 — DA VERIFICARE MANUALMENTE INSIEME ALLA CALIBRAZIONE v0.41.**

---

## 12.10 Layout dedicato CAD 2D — v0.43

La v0.43 semplifica l'interfaccia generale quando è attiva la pagina CAD 2D, senza eliminare i controlli dal resto di Termodel Web.

In modalità CAD:

- la caption diventa esattamente `Termodel Cad 2d Versione 0.43`;
- la barra menu generale viene nascosta;
- le tab generali vengono nascoste;
- la barra inferiore del modello/3D viene nascosta;
- restano visibili la toolbar CAD, il canvas e il pannello proprietà;
- il pulsante di uscita dalla toolbar CAD è rinominato `Torna al modello 3d`.

La modifica è solo di layout frontend. Menu, tab e barra inferiore non vengono rimossi dall'applicazione: entrando nel CAD viene applicata la classe `cad-layout-mode`; tornando al modello 3D la classe viene rimossa e il layout generale viene ripristinato.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
8096a7bac2c606d3df2c71454814584b34c57e8e
Simplify CAD 2D layout v0.43
```

### Stato

**IMPLEMENTATO IN v0.43 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.11 Disegno pareti multilinea — v0.44

La v0.44 trasforma il comando `Nuova linea` del CAD in una sequenza continua di segmenti.

Flusso:

```text
Nuova linea
    ↓
clic punto iniziale
    ↓
clic punto successivo
    ↓
creazione segmento
    ↓
il punto finale diventa automaticamente
il punto iniziale del segmento successivo
    ↓
continua finché l'utente interrompe la sequenza
```

Regole:

- ogni segmento continua a essere una normale entità E/W autonoma con ID globale;
- `Orto` e `Snap` vengono applicati a ogni nuovo segmento;
- dopo la creazione di un segmento il comando resta attivo;
- il pulsante attivo mostra `Interrompi sequenza`;
- il tasto destro sul canvas, durante il comando, apre un menu contestuale CAD con `Interrompi sequenza`;
- `Esc` continua a interrompere la sequenza come scorciatoia;
- i segmenti già creati non vengono cancellati quando si interrompe;
- dopo la chiusura della sequenza, Undo continua a poter annullare i segmenti uno alla volta.

Il menu contestuale è specifico del CAD Web e viene intercettato soltanto mentre è attivo il comando linea; fuori dalla modalità linea il normale comportamento del tasto destro non viene sostituito.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
8dd5e048474c4f09618f113f9a2d8b37c039ee5e
Add multiline wall drawing v0.44
```

### Stato

**IMPLEMENTATO IN v0.44 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.12 Menu toolbar CAD e terminologia Parete — v0.45

La v0.45 riorganizza la toolbar superiore del CAD 2D in tre menu compatti:

```text
Sfondo
Disegna
Snap
```

Contenuto:

- `Sfondo`:
  - `Aggiungi sfondo`;
  - `Mostra sfondo`;
  - `Mostra disegno input`.
- `Disegna`:
  - scelta tipo parete `W interna / E esterna`;
  - `Nuova parete`;
  - `Allinea`;
  - `Porta/Finestra`;
  - `Ponte`;
  - `Locale`.
- `Snap`:
  - `Attiva Snap`;
  - `Orto`.

Il selettore `Piano` e il relativo pulsante `Arc` restano espliciti e sempre visibili nella toolbar, come richiesto.

Restano espliciti anche i comandi operativi generali:

```text
Undo
Redo
Elimina
Rigenera pianta
Esporta pianta CAD
Torna al modello 3d
```

I menu sono mutuamente esclusivi: aprirne uno chiude gli altri; un clic esterno li chiude. I pulsanti contenuti nei menu chiudono il menu dopo l'attivazione.

Terminologia UI:

- il comando utente `Nuova linea` è stato rinominato `Nuova parete`;
- messaggi e suggerimenti operativi relativi alla costruzione usano `Parete`;
- i nomi tecnici interni JavaScript/SVG basati su `line` non vengono rinominati, perché rappresentano l'implementazione geometrica e non il linguaggio dell'interfaccia;
- `Tipo linea` resta invariato perché è una proprietà tecnica di stile, non il comando di costruzione della parete.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
86ad934edd65174db04a9f52237b7a7903dcac8b
Reorganize CAD toolbar menus v0.45
```

### Stato

**IMPLEMENTATO IN v0.45 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.13 Cursore attivo per inserimento parete — v0.46

La v0.46 aggiunge un feedback immediato quando è attivo il comando `Nuova parete`.

Comportamento:

- appena il comando parete viene attivato, prima ancora del primo punto, il canvas usa un cursore `crosshair`;
- il cursore resta attivo per tutta la sequenza multilinea;
- alla chiusura della sequenza con pulsante, tasto destro → `Interrompi sequenza` o `Esc`, il cursore torna normale;
- durante il pan con tasto centrale il cursore `grabbing` mantiene la priorità sul crosshair.

La modifica è puramente frontend e non cambia geometria, Snap, Orto, archivi o protocollo progetto.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
00014782bb48433518e4930f34c7402225af9ffe
Add wall drawing cursor v0.46
```

### Stato

**IMPLEMENTATO IN v0.46 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.14 Chiusura automatica sequenza pareti — v0.47

La v0.47 estende il comando multilinea delle pareti memorizzando per ogni sequenza attiva:

- punto iniziale assoluto della sequenza;
- ID della prima parete creata;
- numero di pareti già confermate;
- ultimo punto confermato, già rappresentato dal punto iniziale del tratto successivo.

Dal momento in cui sono state confermate almeno **3 pareti**, il menu contestuale del tasto destro mostra:

```text
Chiudi
Interrompi sequenza
```

`Chiudi`:

1. prende l'ultimo punto confermato;
2. lo collega direttamente al punto iniziale della sequenza;
3. crea una nuova parete E/W autonoma con ID globale;
4. eredita tipo parete, confine, colore/tipo linea e piano dalla **prima parete memorizzata** della sequenza;
5. non applica Orto o Snap al tratto finale, perché la priorità è chiudere geometricamente esattamente sul vertice iniziale;
6. termina automaticamente la sequenza.

Se l'ultimo punto coincide già con il punto iniziale, non viene creata una parete a lunghezza nulla: la sequenza viene semplicemente terminata.

La parete generata da `Chiudi` entra nell'Undo come modifica autonoma.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
35942a324167ceb6474e098c11282b39ce9bf424
Add wall sequence close command v0.47
```

### Stato

**IMPLEMENTATO IN v0.47 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.15 Chiusura ortogonale sequenza pareti — v0.48

La v0.48 aggiunge al menu contestuale della sequenza pareti, quando `Chiudi` è disponibile:

```text
Chiudi
Chiudi ortogonale
Interrompi sequenza
```

La sequenza memorizza ora anche l'ID dell'ultima parete confermata.

`Chiudi ortogonale` opera sul vertice finale condiviso tra:

- il punto di partenza della parete ancora in costruzione;
- il punto di arrivo dell'ultima parete confermata.

Per rendere ortogonale la parete di chiusura verso il punto iniziale della sequenza, vengono valutate due possibilità:

- chiusura verticale: il vertice finale viene portato sulla stessa X del punto iniziale;
- chiusura orizzontale: il vertice finale viene portato sulla stessa Y del punto iniziale.

Viene scelta la soluzione che richiede lo **spostamento minore del vertice finale**. Se tale soluzione annullerebbe la lunghezza della parete precedente, viene usata l'altra soluzione valida.

La modifica del vertice e la creazione della parete finale costituiscono **un'unica operazione Undo**.

La parete di chiusura continua a ereditare i dati semantici dalla prima parete della sequenza. `Chiudi` normale resta invariato e continua a collegare direttamente ultimo e primo punto senza correggere il vertice.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
67f5aa496e6ab5eb65932205576cad2862cb1054
Add orthogonal wall sequence close v0.48
```

### Stato

**IMPLEMENTATO IN v0.48 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.16 Ripristino feedback Snap sul primo punto — v0.49

La v0.49 corregge il feedback dello Snap sul **primo punto** del comando `Nuova parete`.

Il calcolo dello Snap sul primo clic era ancora presente, ma dopo l'introduzione del cursore/preview il movimento del mouse prima del primo punto non mostrava più il marcatore di aggancio. Questo rendeva il comportamento apparentemente privo di Snap.

Ora, prima del primo clic:

- il puntatore viene già valutato con `cadSnapPoint`;
- quando è entro la distanza di Snap da una parete o da un suo estremo, compare il consueto marcatore verde;
- lo stato CAD mostra `SNAP`;
- il primo clic usa lo stesso punto agganciato visualizzato in anteprima.

Il comportamento dei punti successivi, di Orto e delle chiusure v0.47/v0.48 resta invariato.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
a296e635b9d99d4e3b788ae4c79bf313ad01eda1
Restore first-point wall snap feedback v0.49
```

### Stato

**IMPLEMENTATO IN v0.49 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.17 Orto attivo di default — v0.50

La v0.50 modifica soltanto lo stato iniziale del controllo `Orto` nel menu `Snap` del CAD 2D.

All'apertura:

```text
Snap = ON
Orto = ON
```

L'utente può comunque disattivare `Orto` manualmente in qualsiasi momento.

Non cambia la logica di Snap, multilinea, Chiudi o Chiudi ortogonale.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
3a8ec7eae6e4b0821a180b72084edb046d52e735
Enable Ortho by default v0.50
```

### Stato

**IMPLEMENTATO IN v0.50 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.18 Fine automatica multilinea su Snap ad altra parete — v0.51

La v0.51 rende naturale la conclusione di una sequenza multilinea quando il nuovo segmento raggiunge una parete già esistente.

Lo Snap restituisce ora anche l'ID della parete bersaglio:

```text
point
snapped
targetLineId
```

Regola operativa:

- il segmento viene creato normalmente;
- se il suo punto finale è in Snap su una parete;
- e la parete bersaglio è diversa dall'ultima parete della sequenza;
- la sequenza multilinea termina automaticamente subito dopo la creazione.

Questo evita di interrompere la sequenza quando lo Snap ricade sull'ultima parete appena tracciata, cioè sul normale vertice di prosecuzione.

È invece considerata una vera connessione finale:

- una parete preesistente;
- una parete precedente della stessa sequenza diversa dall'ultima;
- anche la prima parete della sequenza, se il percorso torna ad agganciarsi ad essa.

Il messaggio CAD indica esplicitamente la parete bersaglio:

```text
SNAP su Wxxx · sequenza terminata
```

Il comportamento del primo punto, Orto, Chiudi e Chiudi ortogonale resta invariato.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
77e8100d23b55dc8033ded738c907c7aa9f413d1
Stop multiline walls on external snap v0.51
```

### Stato

**IMPLEMENTATO IN v0.51 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.19 Ripeti ultimo comando dal tasto destro — v0.52

La v0.52 estende il menu contestuale CAD quando non è in corso alcun comando.

In stato neutro (`cadToolMode = select`) il tasto destro mostra:

```text
Ripeti ultimo comando
```

Sono memorizzati come comandi ripetibili:

- `Nuova parete`;
- `Allinea`;
- `Porta/Finestra`;
- `Ponte`;
- `Locale`.

Undo, Redo, Elimina, Rigenera ed altri comandi operativi non vengono memorizzati come "ultimo comando".

Regole:

- il comando viene memorizzato quando viene attivato;
- dopo la conclusione/interruzione resta disponibile come ultimo comando della sessione CAD;
- `Ripeti ultimo comando` lo riattiva con i valori e le impostazioni correnti;
- prima che esista un comando ripetibile, la voce è visibile ma disabilitata;
- durante una sequenza pareti il menu destro resta quello già previsto con `Chiudi / Chiudi ortogonale / Interrompi sequenza`;
- durante un comando simbolo attivo non viene sostituito il comportamento con il menu neutro.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
a398b94138604e1601c22a68c641aff4d5bd503d
Add repeat last CAD command v0.52
```

### Stato

**IMPLEMENTATO IN v0.52 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.20 Snap Vicino / Estremo alternativi — v0.53

La v0.53 separa lo Snap CAD in due modalità mutuamente esclusive:

```text
Vicino   ← default
Estremo
```

Nel menu `Snap` i due controlli sono radio button con lo stesso gruppo, quindi una sola modalità può essere attiva.

Comportamento:

- `Vicino`: aggancia al punto geometricamente più vicino lungo il tratto di parete entro la distanza di Snap;
- `Estremo`: considera esclusivamente i due estremi delle pareti;
- `Orto` resta un controllo indipendente e continua a essere attivo di default;
- il vecchio checkbox generale `Attiva Snap` viene sostituito dalle due modalità alternative;
- lo Snap continua a restituire l'ID della parete bersaglio, quindi la conclusione automatica della multilinea introdotta in v0.51 funziona con entrambe le modalità.

Il feedback testuale distingue chiaramente:

```text
SNAP VICINO
SNAP ESTREMO
```

La distinzione viene mostrata durante il primo punto, i punti successivi, la modifica degli estremi e la chiusura automatica per aggancio ad altra parete.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
c9372b4f655f3278a5df90dcf97be33e467d7363
Split Snap into Near and Endpoint v0.53
```

### Stato

**IMPLEMENTATO IN v0.53 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.21 Inserimento continuo Porta/Finestra — v0.54

La v0.54 trasforma il comando `Porta/Finestra` (simbolo `FIN`) in una modalità di inserimento continuo analoga alla multilinea delle pareti.

Comportamento:

- attivando `Porta/Finestra`, il comando resta attivo;
- ogni clic valido vicino a una parete inserisce un nuovo simbolo FIN;
- dopo l'inserimento il comando non torna in modalità selezione;
- il cursore e lo stato di inserimento restano attivi per la finestra successiva;
- ogni FIN resta un'entità autonoma e genera la propria voce Undo;
- il comando termina con:
  - `Esc`;
  - tasto destro → `Interrompi sequenza`;
  - pressione del pulsante attivo `Interrompi sequenza`.

Durante la sequenza FIN il menu destro mostra soltanto:

```text
Interrompi sequenza
```

Gli altri comandi simbolo restano a inserimento singolo:

```text
Allinea
Ponte
Locale
```

Il normale menu destro delle pareti con `Chiudi / Chiudi ortogonale / Interrompi sequenza` resta invariato.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
c66f04b24626bded1780735a4d8066124982fb17
Make window insertion continuous v0.54
```

### Stato

**IMPLEMENTATO IN v0.54 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.22 Finestra a due punti — v0.55

La v0.55 aggiunge un nuovo comando separato:

```text
Finestra 2 punti
```

Il comando storico `Porta/Finestra` a un punto della v0.54 resta invariato e continua a essere disponibile.

Flusso del nuovo comando:

1. primo clic vicino a una parete → il punto viene proiettato sulla parete e viene memorizzato l'ID della parete;
2. movimento del mouse → viene mostrata una linea provvisoria dal primo punto al secondo;
3. secondo clic → deve essere vicino alla **stessa parete** del primo punto;
4. la posizione del simbolo FIN è il **punto medio** dei due estremi;
5. la distanza tra i due estremi, nelle unità SVG già usate dal CAD, viene salvata nel normale attributo FIN `LARGHEZZA`;
6. gli altri dati FIN (`PORTA`, `TIPO`, `ALTEZZA`, `NUMEROANTE`, `SOTTOFINESTRA`, `SOPRALUCE`) continuano a provenire dai DatiCad correnti.

Non vengono introdotti nuovi campi o nuovi contratti.

Il comando è continuo come il comando finestra a un punto:

- dopo ogni FIN a due punti torna in attesa del primo punto della finestra successiva;
- ogni finestra è un'entità autonoma con il proprio Undo;
- `Esc`, pulsante attivo o tasto destro → `Interrompi sequenza` terminano il comando.

Il menu `Disegna` contiene quindi entrambe le alternative:

```text
Porta/Finestra
Finestra 2 punti
```

`Ripeti ultimo comando` riconosce anche `Finestra 2 punti`.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
```

Commit:

```text
aebc9898833291b03ff20a380807c27e0aeb14cd
Add two-point window drawing v0.55
```

### Stato

**IMPLEMENTATO IN v0.55 — DA VERIFICARE MANUALMENTE NEL BROWSER.**

---

## 12.23 FIN visibili nel 3D provvisorio — v0.56

La v0.56 aggiunge una rappresentazione volutamente semplice delle finestre/porte `FIN` nel modello 3D provvisorio del browser.

Non viene eseguita alcuna sottrazione booleana della massa muraria.

Ogni FIN viene rappresentato come un parallelepipedo autonomo:

- centro derivato dalla posizione `x/y` del simbolo FIN;
- orientamento ricavato dalla parete E/W più vicina;
- `LARGHEZZA` e `ALTEZZA` lette direttamente dalle proprietà FIN;
- quota inferiore ricavata da `SOTTOFINESTRA`;
- colore distinto dalla massa muraria;
- spessore pari allo spessore della parete + **4 cm totali**, cioè circa 2 cm visibili per faccia.

Per le pareti interne W il parallelepipedo è centrato sull'asse della parete.

Per le pareti esterne E, che nel GeneraPianta provvisorio rappresentano il filo interno, il centro del parallelepipedo viene spostato di metà spessore nella direzione esterna, così il FIN attraversa visivamente tutta la parete e sporge solo leggermente da entrambe le facce.

`genera-pianta.js` v0.6 legge ora i simboli FIN dallo SVG, li associa alla parete più vicina e restituisce al preview:

```text
finestre[]
  id
  x / y
  larghezzaCm
  altezzaCm
  sottofinestraCm
  wallLineId
  wallClass
  wallThicknessCm
  wallDirection
  wallNormal
```

Questi dati sono esclusivamente di supporto all'anteprima browser e non costituiscono un nuovo contratto backend.

La generazione 3D definitiva resta responsabilità di **Termodel.Core / Termodel.WebService** e dovrà creare aperture reali secondo la logica autorevole del desktop.

File modificati:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
docs/termodel-ui-demo/genera-pianta.js
```

Commit:

```text
bad04231587386ff9e592ab15c0deb7e647974b2
Show FIN blocks in provisional 3D v0.56
```

### Stato

**VERIFICATO PARZIALMENTE IN v0.56 — i FIN sono visibili nel 3D; sulle pareti esterne è emerso un difetto di allineamento/profondità: alcuni risultano visibili soprattutto dall'interno. Correzione ancora da eseguire.**

---

## 12.24 Progetto vuoto locale senza WebService — v0.57

La v0.57 elimina la dipendenza dal WebService per l'inizializzazione del progetto durante lo sviluppo e i test del frontend.

Risorsa sorgente reale:

```text
SorgentiTermodel/Library/projects/ProgettoVuoto/ProgettoVuoto.termodel.txt
```

Commit che ha introdotto la risorsa:

```text
f58a9725d0129da9809be64013e6c15ce1dd5b06
Add static empty Termodel project
```

Copia browser consolidata in JavaScript:

```text
docs/termodel-ui-demo/progetto-vuoto.js
```

La copia è generata dal file sorgente e nella verifica v0.57 il testo esportato dal modulo coincide esattamente con la sorgente: **857.520 caratteri**.

Il caricamento usa `import()` dinamico, quindi il modulo di circa 0,9 MB non viene scaricato all'apertura normale dell'applicazione ma soltanto quando serve creare una base progetto.

`createStructuredProjectFromSvg(...)` ora:

```text
carica progetto-vuoto.js
      ↓
valida TERMODEL-PROJECT-TEXT-V1
      ↓
sostituisce geometry/project.svg
      ↓
loadTermodelProjectText(...)
      ↓
progetto strutturato + archivi + CAD
```

Sono stati rimossi dal frontend per questo flusso:

```text
POST /api/projects/new
GET  /api/model/capabilities
probe automatico del WebService all'avvio
```

Il WebService resta parte dell'architettura definitiva e conserva i suoi endpoint reali; questa modifica riguarda soltanto il bootstrap locale del progetto nel frontend.

File frontend modificati/aggiunti:

```text
docs/termodel-ui-demo/index.html
docs/termodel-ui-demo/app.js
docs/termodel-ui-demo/progetto-vuoto.js
```

Commit frontend:

```text
da7c4f70cdc3aa3b5e9c6e541b3725b9f9c44711
Use local empty project template v0.57
```

### Stato

**IMPLEMENTATO IN v0.57 — sintassi verificata; copia JS del progetto vuoto verificata identica alla sorgente; DA VERIFICARE MANUALMENTE NEL BROWSER CON WEBSERVICE SPENTO.**

---

## 12.25 Conversione bidirezionale progetto unico / frontend — v0.58

La v0.58 introduce il primo **round-trip completo** del progetto unico nel frontend.

Nuovo modulo:

```text
docs/termodel-ui-demo/termodel-project-text.js
```

Le due direzioni concettuali sono:

```text
TERMODEL-PROJECT-TEXT-V1
        ↓
loadProjectTextIntoFrontend(...)
        ↓
stato frontend
CAD + ArchivioWeb

stato frontend
CAD + ArchivioWeb
        ↓
buildCurrentProjectText(...)
        ↓
TERMODEL-PROJECT-TEXT-V1 aggiornato
```

Il convertitore conserva il progetto unico come contenitore e aggiorna soltanto le parti modificate dal frontend.

Per il salvataggio corrente:

- `geometry/project.svg` viene sostituito con lo SVG multipiano corrente del CAD;
- tutti gli archivi presenti in ArchivioWeb vengono riscritti nelle sezioni `archives/json/*.json`;
- le corrispondenti sezioni `archives/xml/*.xml` vengono rigenerate mantenendo ordine e tipi del progetto/XML di origine;
- per i campi già presenti, il tipo XML reale del progetto ha precedenza sulle deduzioni da `definizionedati.json`;
- le sezioni non gestite/modificate dal frontend, ad esempio DXF e input termici, restano nel contenitore;
- `manifest.json` aggiorna `generatedAtUtc`, dati noti dei piani e SHA-256 delle sezioni;
- il file risultante resta un normale `TERMODEL-PROJECT-TEXT-V1`.

Test strutturale eseguito sul vero `ProgettoVuoto.termodel.txt`:

```text
sezioni prima = 26
sezioni dopo  = 26

Piani.AltezzaNetta:
JSON  -> numero 3.2
XML   -> d4p1:double 3.2
manifest floors[0].netHeightMeters -> 3.2

hash manifest -> 64 caratteri
END marker    -> presente
```

La sintassi è stata verificata per:

```text
app.js
archivio-web.js
termodel-project-text.js
```

### File → Apri / Salva

I comandi già presenti nel menu `File` sono ora collegati al progetto unico:

- `Apri...` → seleziona un file testuale `TERMODEL-PROJECT-TEXT-V1` e lo converte nello stato frontend;
- `Salva` → converte lo stato frontend corrente nel progetto unico e scarica il file;
- `Salva con nome` → stessa conversione, con scelta del nome del file.

Il salvataggio è completamente locale e non usa il WebService.

### Precondizione obbligatoria per il futuro WebService

Prima di qualsiasi futura richiesta autorevole al server, il frontend deve costruire il progetto unico aggiornato tramite la stessa conversione usata da `Salva`.

È stabilita una distinzione obbligatoria fra **progetto locale completo** e **payload destinato al server**:

- il progetto locale può conservare gli sfondi necessari al CAD/browser;
- gli **sfondi non devono essere trasmessi a Termodel.Core / Termodel.WebService**;
- prima dell'invio server deve essere generata una variante del progetto unico priva dei contenuti raster/SVG usati come sfondo;
- devono essere esclusi anche Data URL/Base64 ed eventuali future sezioni o asset dedicati agli sfondi;
- il server non deve dipendere dagli sfondi per ricostruire, validare o calcolare il progetto.

Flusso obbligatorio:

```text
utente modifica CAD / archivi
        ↓
buildCurrentProjectText()
        ↓
TERMODEL-PROJECT-TEXT-V1 locale aggiornato
        ├── Salva locale
        │      └── può conservare gli sfondi
        │
        ├── invio AI
        │      └── politica da definire separatamente
        │
        └── futura richiesta WebService
               ↓
          filtro payload server
               ↓
          rimuove tutti gli sfondi
               ↓
          progetto unico per Core/WebService
```

Non introdurre API server operative che ricevano copie parziali o stato frontend sparso quando la funzione richiede il progetto corrente completo.

**Salva locale e futuro invio server partono dallo stesso progetto aggiornato, ma il payload server deve essere filtrato: gli sfondi non vengono mai trasmessi al server.**

Commit frontend:

```text
15c6f284a7970beb1d82865995e49f55e3f38054
Add bidirectional project round-trip v0.58
```

### Stato

**IMPLEMENTATO IN v0.58 — TEST STRUTTURALE SUPERATO; DA VERIFICARE MANUALMENTE NEL BROWSER CON APRI → MODIFICA CAD/ARCHIVIO → SALVA → RIAPRI.**

---

## 12.26 Sfondi consolidati nel progetto unico — v0.59

La v0.59 completa il primo ciclo locale `File → Salva / Apri` anche per gli sfondi del CAD.

Principio:

> Nel CAD lo sfondo resta un normale `<image href="data:...">` per semplicità operativa; nel file progetto salvato il contenuto dell'immagine viene separato da `geometry/project.svg` e memorizzato come asset del progetto.

Formato locale introdotto:

```text
geometry/project.svg
    → posizione, scala, piano, layer
    → data-termodel-background-id="BG001"
    → nessun Data URL incorporato

assets/backgrounds/index.json
    → indice degli sfondi

assets/backgrounds/BG001.data
    → Data URL completo dell'immagine
```

L'indice usa il formato:

```text
TERMODEL-BACKGROUNDS-V1
```

e conserva per ogni asset:

- ID;
- piano;
- layer;
- nome file originale;
- tipo raster/vettoriale;
- MIME type;
- nome della sezione dati.

### Salva

`buildCurrentProjectText()` passa lo SVG corrente a `consolidateTermodelBackgrounds(...)`.

La funzione:

1. trova gli `image[data-termodel-sfondo="1"]`;
2. assegna/preserva un ID `BGxxx`;
3. estrae il Data URL dall'`href`;
4. rimuove l'`href` dal solo SVG destinato al file progetto;
5. crea `assets/backgrounds/index.json` e una sezione dati per ogni sfondo;
6. aggiorna `manifest.sections` e SHA-256 anche per le nuove sezioni.

Il CAD in memoria non viene privato dell'immagine: continua a lavorare con il Data URL reidratato.

Se uno sfondo viene eliminato/sostituito, al successivo salvataggio le vecchie sezioni `assets/backgrounds/*` vengono rimosse e il manifest viene riallineato.

### Apri

`loadProjectTextIntoFrontend(...)` usa `hydrateTermodelBackgrounds(...)` prima di consegnare `geometry/project.svg` al CAD/viewer.

La funzione:

1. legge `assets/backgrounds/index.json`;
2. trova l'immagine SVG tramite `data-termodel-background-id`;
3. legge il Data URL dalla relativa sezione asset;
4. ripristina temporaneamente l'`href`;
5. consegna al CAD uno SVG completo e visivamente equivalente a quello precedente al salvataggio.

### Compatibilità

I vecchi progetti v0.40-v0.58 che contengono ancora il Data URL direttamente nello SVG restano apribili.

Alla prima operazione `Salva` in v0.59 vengono automaticamente migrati alla nuova struttura asset.

### Menu File

Sul modello demo iniziale:

```text
Salva            DISABILITATO
Salva con nome   DISABILITATO
```

I due comandi vengono abilitati soltanto quando esiste un progetto strutturato dell'utente.

`Apri...` resta disponibile dalla schermata iniziale.

### Test automatici eseguiti

Test di struttura sul vero `ProgettoVuoto.termodel.txt` con uno sfondo sintetico:

```text
sezioni iniziali           26
con 1 sfondo               28
  + assets/backgrounds/index.json
  + assets/backgrounds/BG001.data

manifest index             presente + SHA-256
manifest asset             presente + SHA-256

rimozione sfondo:
sezioni finali             26
index rimosso              sì
asset rimosso              sì
entry manifest rimosse     sì
```

Sintassi JavaScript verificata per `app.js` e `termodel-project-text.js`.

### Vincolo server confermato

Gli asset `assets/backgrounds/*` sono esclusivamente locali/frontend.

**Non devono essere trasmessi a Termodel.Core / Termodel.WebService.**

Il futuro payload server dovrà essere derivato dal progetto unico aggiornato eliminando:

- le sezioni `assets/backgrounds/*`;
- i riferimenti puramente locali agli sfondi;
- qualunque Data URL/Base64 residuo di sfondo.

Commit frontend:

```text
9b828a4ac412273b6e6f9d9be0e9dc356d73b024
Consolidate background assets in project files v0.59
```

### Stato

**IMPLEMENTATO IN v0.59 — TEST STRUTTURALE SUPERATO; DA VERIFICARE MANUALMENTE NEL BROWSER CON AGGIUNGI SFONDO → SALVA → APRI.**

---

## 12.27 Sfondo DXF con conversore tipo plotter — v0.60

La v0.60 estende `Sfondo → Aggiungi sfondo` ai file `.dxf`.

Flusso:

```text
Aggiungi sfondo
    ↓
file raster / SVG
    → percorso esistente

file DXF
    ↓
parser DXF 2D locale
    ↓
dialog Importa sfondo DXF
    ↓
dxf-plotter.js
    ↓
SVG semplificato
    ↓
normale sfondo vettoriale Termodel
```

Nuovo modulo:

```text
docs/termodel-ui-demo/dxf-plotter.js
```

Il modulo è autonomo e non richiede CDN/npm: legge DXF ASCII sufficiente per l'uso come sfondo e produce un SVG tipo "plotter a penna". Non crea entità Termodel e non modifica Core/WebService.

### Dialog DXF

Prima della conversione viene mostrato un dialog con:

- elenco layer con checkbox;
- pulsanti `Tutti` / `Nessuno`;
- `Solo linee / polilinee`;
- `Linee + curve`;
- `Converti testo`;
- `Esplodi blocchi`;
- riepilogo del numero di entità previste.

Default approvati:

```text
tutti i layer     selezionati
solo linee        attivo
converti testo    disattivo
esplodi blocchi   disattivo
```

Per "solo linee" la v0.60 comprende:

```text
LINE
POLYLINE
LWPOLYLINE
```

Con `Linee + curve` aggiunge:

```text
ARC
CIRCLE
ELLIPSE
SPLINE
```

Le curve vengono discretizzate in tratti SVG.

Con `Converti testo`:

```text
TEXT
MTEXT
```

vengono resi come testo SVG.

Con `Esplodi blocchi` gli `INSERT` vengono percorsi ricorsivamente applicando posizione, scala e rotazione del BLOCK.

### Integrazione con sfondi/progetto unico

Il DXF viene convertito **prima** di entrare nel normale sistema sfondi.

Il CAD riceve quindi un normale SVG/Data URL e tutto il comportamento v0.59 resta valido:

- un solo sfondo per piano;
- visibilità Sfondo on/off;
- calibrazione;
- undo/redo;
- Salva/Apri progetto unico;
- consolidamento in `assets/backgrounds/*`;
- esclusione degli sfondi dal futuro payload WebService.

Il nome originale `.dxf` viene conservato nei metadati dello sfondo anche se il contenuto usato dal CAD è SVG.

### Test eseguiti

Test sintetico con:

- due layer;
- LINE;
- LWPOLYLINE;
- TEXT;
- BLOCK + INSERT;
- `$INSUNITS = mm`.

Risultato:

```text
default:
  tutti i layer
  solo linee
  testo NO
  blocchi NO

2 entità convertite
testo ignorato
INSERT ignorato

opzioni complete:
  testo SI
  blocchi SI

4 entità convertite
testo presente
blocco esploso
```

Sintassi verificata per `app.js` e `dxf-plotter.js`.

È stato inoltre provato il parser sul `project/DisegnoInput.dxf` del progetto vuoto. Quel DXF contiene principalmente definizioni BLOCK e due TEXT nell'ENTITIES principale, quindi con il default "solo linee / blocchi non esplosi" non produce geometria visibile: il convertitore segnala correttamente che le opzioni selezionate non producono geometria.

### Stato

**IMPLEMENTATO IN v0.60 — TEST SINTETICO SUPERATO; DA VERIFICARE MANUALMENTE NEL BROWSER CON UN DXF ARCHITETTONICO REALE.**

Commit:

```text
2c178090d70a94cc834e5ed3e3ad1a1f8d56ca75
Add DXF background converter v0.60

752e5fda8c10206246bbe1d306c822233353ad2a
Fix DXF text rendering v0.60
```

---

## 12.28 Unità reali per lo sfondo DXF — v0.61

La v0.61 definisce formalmente la scala tra DXF e CAD Web Termodel.

Convenzione autorevole frontend:

```text
unità interna CAD Termodel Web = centimetri
```

Nel dialog `Importa sfondo DXF` è presente la combo:

```text
Unità del disegno:
m
cm
mm
```

La scelta iniziale viene proposta leggendo `$INSUNITS`:

```text
4 → mm
5 → cm
6 → m
```

Se `$INSUNITS` è assente, zero o non corrisponde a una delle tre unità gestite, la combo parte da `cm` e resta correggibile dall'utente.

Fattori verso Termodel:

```text
DXF mm × 0,1 = cm Termodel
DXF cm × 1   = cm Termodel
DXF m  × 100 = cm Termodel
```

Il fattore viene applicato dal plotter a tutte le coordinate convertite e, quando il testo è attivo, anche all'altezza del testo. Poiché BLOCK/INSERT vengono trasformati prima della normalizzazione finale, anche traslazioni/scale dei blocchi confluiscono correttamente nelle coordinate in centimetri.

### Inserimento dello sfondo

Per un DXF convertito non si usa più la dimensione del viewBox del progetto come larghezza/altezza dello sfondo.

Il render SVG DXF contiene un viewBox espresso in centimetri Termodel e viene inserito con la propria dimensione reale.

Esempio verificato:

```text
4000 unità con mm → 400 cm → 4,000 m
400  unità con cm → 400 cm → 4,000 m
4    unità con m  → 400 cm → 4,000 m
```

Dopo l'inserimento il viewBox del CAD viene ampliato per comprendere lo sfondo reale, senza stirarlo.

Gli attributi SVG dello sfondo conservano inoltre:

```text
data-termodel-dxf-unita
data-termodel-dxf-fattore-cm
```

La calibrazione v0.41 resta disponibile come correzione manuale successiva nel caso il DXF dichiari unità errate o l'utente scelga un'unità non corretta.

### Test automatici v0.61

Test numerico su una linea di 4 metri:

```text
4000 mm → bounds.width = 400 cm → 4 m
400 cm  → bounds.width = 400 cm → 4 m
4 m     → bounds.width = 400 cm → 4 m
```

Verificati anche:

- sintassi `app.js`;
- sintassi `dxf-plotter.js`;
- cache/versione v0.61 coerente;
- rilevamento automatico `$INSUNITS` per mm/cm/m;
- SVG DXF con dimensioni fisiche in cm;
- nessuna occorrenza operativa residua `v=0.60` in `app.js`.

### Stato

**IMPLEMENTATO IN v0.61 — TEST NUMERICO SUPERATO; DA VERIFICARE MANUALMENTE NEL BROWSER CON UN DXF REALE DI DIMENSIONE NOTA.**

Commit:

```text
cab56e06fe38060a835990681482f65549a41d22
Add real DXF drawing units v0.61
```

---

## 12.29 Scala automatica DXF e normalizzazione coordinate — v0.62

Decisione architetturale definitiva:

> **Per uno sfondo DXF, l'unità scelta nel dialog di importazione costituisce la calibrazione automatica del disegno. Se il DXF e l'unità sono corretti, non è richiesta alcuna calibrazione manuale successiva.**

La trasformazione verso il CAD Web Termodel è:

```text
mm → cm : × 0,1
cm → cm : × 1
m  → cm : × 100
```

Dopo la conversione metrica, il plotter può adattare il sistema di coordinate al CAD Termodel mediante:

- traslazione dell'origine;
- inversione dell'asse Y necessaria per SVG;
- ampliamento del viewBox.

Queste operazioni sono **rigide rispetto alle distanze** e non introducono fattori di scala ulteriori.

In v0.62 `dxf-plotter.js` normalizza l'origine della geometria convertita a `0,0` mediante una traslazione SVG, mantenendo la geometria già espressa in centimetri Termodel.

Lo SVG risultante è marcato con:

```text
data-termodel-coordinate-normalization="origin"
data-termodel-source-unit
data-termodel-unit-scale-cm
```

e lo sfondo nel CAD conserva:

```text
data-termodel-dxf-scala-automatica="1"
data-termodel-dxf-unita
data-termodel-dxf-fattore-cm
data-termodel-dxf-origine-x-cm
data-termodel-dxf-origine-y-cm
```

Il pannello di calibrazione, quando lo sfondo corrente è DXF in scala automatica, informa esplicitamente che `Calibra` deve essere usato soltanto come correzione di un DXF o di un'unità dichiarata erroneamente.

### Test di invarianza delle distanze

Test sintetico con DXF in metri e coordinate lontane dall'origine:

```text
punto iniziale X = 1000,0000 m
punto finale   X = 1013,0977 m

distanza DXF = 13,0977 m
```

Dopo:

```text
m → cm
normalizzazione origine
inversione Y SVG
```

risultato verificato:

```text
1309,77 cm Termodel
= 13,0977 m
```

Errore numerico misurato:

```text
~9×10^-13 cm
```

quindi trascurabile e dovuto esclusivamente alla rappresentazione floating-point.

### Regola operativa per i test reali

Per verificare la scala di un DXF reale:

1. misurare in AutoCAD due punti geometrici precisi con `DIST`;
2. importare il DXF scegliendo l'unità corretta;
3. verificare la stessa distanza nel CAD Termodel;
4. **non usare Calibra** prima del confronto;
5. se la distanza differisce sugli stessi punti, trattare la differenza come errore del percorso di importazione e non come normale necessità di calibrazione.

La calibrazione manuale resta prevista solo per:

- DXF con unità errata o assente;
- disegni già scalati in modo anomalo;
- correzioni volontarie dell'utente.

### Stato

**IMPLEMENTATO IN v0.62 — INVARIANZA DELLA SCALA VERIFICATA AUTOMATICAMENTE; DA CONTINUARE IL COLLAUDO VISIVO SUL DXF REALE FARMACIA.**

Commit:

```text
254b77d30d7238e148a3aeda4f50d9637bbe502c
Formalize automatic DXF scaling v0.62
```

---

## 12.30 Snap agli endpoint dello sfondo vettoriale — v0.63

La v0.63 aggiunge al menu `Snap` del CAD:

```text
[x] Sfondo vettoriale
```

Il check è **attivo di default**.

Questa funzione è additiva:

- non sostituisce `Vicino` / `Estremo`;
- non cambia il significato dello Snap normale sulle pareti Termodel;
- aggiunge soltanto gli endpoint/vertici dello sfondo SVG vettoriale come candidati di snap;
- tra tutti i candidati validi entro la tolleranza vince quello geometricamente più vicino.

Schema:

```text
Snap pareti Termodel
    +
Snap endpoint sfondo vettoriale
    ↓
candidato più vicino
```

Lo snap sfondo viene applicato solo se:

- esiste uno sfondo sul piano corrente;
- lo sfondo è di tipo `vector`;
- il check `Sfondo vettoriale` è attivo;
- lo sfondo è visibile.

Per gli SVG vengono estratti come candidati:

- estremi di `<line>`;
- vertici di `<polyline>`;
- vertici di `<polygon>`;
- vertici lineari dei `<path>` con comandi `M/L/H/V/Z`;
- vertici dei `<rect>`.

Le trasformazioni SVG `translate / scale / rotate / matrix`, il `viewBox` interno e il `preserveAspectRatio` dell'immagine di sfondo vengono riportati nelle coordinate CAD prima di costruire i punti di snap.

Per lo sfondo DXF convertito dal plotter questo significa che i vertici prodotti dal DXF diventano direttamente utilizzabili per ricalcare la pianta.

### Compatibilità con lo Snap Termodel

Quando vince uno snap allo sfondo il risultato è marcato:

```text
snapSource = background
targetLineId = ""
```

e il feedback utente è:

```text
SNAP SFONDO
```

La scelta `targetLineId=""` è intenzionale: uno spigolo dello sfondo non deve essere interpretato come una parete Termodel e non deve attivare la logica di arresto/chiusura automatica della sequenza pareti.

### Prestazioni

Gli endpoint dello SVG non vengono ricalcolati a ogni movimento del mouse.

La v0.63 usa:

- cache per sfondo/piano;
- invalidazione automatica quando cambiano `href / x / y / width / height / preserveAspectRatio`;
- deduplicazione dei vertici;
- griglia spaziale con cella pari alla tolleranza di Snap.

Durante il movimento vengono quindi controllati solo i punti nelle celle vicine al cursore.

### Test automatici v0.63

Verificati:

- sintassi `app.js`;
- trasformazione SVG `translate`;
- mapping da viewBox SVG alle coordinate CAD;
- parsing di vertici da path lineari;
- default UI `Sfondo vettoriale = ON`;
- caso in cui vince lo snap sfondo:
  - `snapSource = background`;
  - `targetLineId = ""`;
  - label `SNAP SFONDO`.

### Stato

**IMPLEMENTATO IN v0.63 — TEST AUTOMATICI SUPERATI; DA VERIFICARE MANUALMENTE SULLO SFONDO DXF `Farmacia.dxf`.**

Test manuale consigliato:

```text
Farmacia.dxf importato come sfondo vettoriale
→ Snap → Sfondo vettoriale ON
→ Nuova parete
→ avvicinare il cursore a uno spigolo DXF
→ verificare marcatore verde + "SNAP SFONDO"
→ cliccare
→ verificare che l'estremo della parete cada esattamente sul vertice dello sfondo
```

Commit:

```text
952b605637dc44095639e3b0b4d41fa7d06347ce
Add vector background endpoint snap v0.63
```

---

## 13. Protocollo progetto

Il protocollo progetto nasce come **standard di comunicazione con l'AI**: un singolo contenitore testuale deve poter rappresentare il progetto completo, **comprensivo di più piani fisici**, ed essere trasmesso anche tramite normale copia-incolla in una chat. Il contenitore è quindi a livello di progetto e non a livello del singolo piano.

Non è quindi soltanto un formato tecnico interno, ma un elemento centrale dell'architettura AI di Termodel Web.

Il protocollo completo sperimentale corrente è:

```text
[TERMODEL-PROJECT-TEXT-V1]

---BEGIN:manifest.json---
...
---END:manifest.json---

---BEGIN:geometry/project.svg---
...
---END:geometry/project.svg---

---BEGIN:archives/xml/Piani.xml---
...
---END:archives/xml/Piani.xml---

---BEGIN:archives/json/Piani.json---
...
---END:archives/json/Piani.json---

[END-TERMODEL-PROJECT-TEXT-V1]
```

Il frontend v0.22 sa già importare le sezioni JSON degli archivi dal file completo.

Dalla v0.58 il frontend dispone anche della conversione inversa: lo stato corrente di CAD + ArchivioWeb può essere ricomposto nel medesimo `TERMODEL-PROJECT-TEXT-V1`, mantenendo sincronizzate geometria, archivi JSON/XML e manifest. Il progetto unico è quindi il **formato di ingresso e di uscita** del frontend, non soltanto un formato di importazione.

Il protocollo precedente:

```text
[TERMODEL-SVG-TEXT-V1]
```

deve continuare a funzionare finché la migrazione non è approvata e collaudata.

---

## 14. Menu Web già collegati ad ArchivioWeb

Nella v0.22 risultano già collegati tramite `data-archive`:

```text
Gestione Piani
Archivio Pareti
Archivio Finestre
Archivio Ponti termici
Archivio Confini
Archivio Zone
Visualizza → Archivi
```

La migrazione dei menu deve restare progressiva. Non sostituire tutto in un'unica modifica.

---

## 15. Regole Git per questo progetto

Prima di intervenire:

```text
git/main aggiornato
→ verifica commit corrente
→ verifica eventuali modifiche concorrenti
→ modifica piccola
→ test
→ diff
→ riepilogo
```

Non sovrascrivere lavoro recente di altre chat.

Frontend e Core/WebService non devono essere modificati contemporaneamente sugli stessi file.

Per modifiche GitHub eseguite direttamente da una chat:

- leggere sempre la versione corrente del file immediatamente prima della modifica;
- non assumere SHA vecchi;
- creare commit piccoli e descrittivi;
- aggiornare questo summary quando cambia lo stato operativo.

---

## 15.1 Direttiva obbligatoria di versionamento Termodel Web

Ogni modifica funzionale del frontend Termodel Web che viene considerata una nuova revisione deve aggiornare la versione in modo **coerente e completo**.

La versione non deve comparire in punti diversi con numeri differenti.

Quando si incrementa la versione Web verificare e aggiornare almeno:

```text
docs/termodel-ui-demo/index.html
    ├── <title> della pagina
    ├── intestazione visibile della finestra Termodel Web
    └── query di cache-busting degli script/moduli, es. app.js?v=0.xx

PROJECT-SUMMARY.md
    └── versione corrente e commit frontend di riferimento
```

Se altri file pubblicati usano esplicitamente il numero di versione per cache-busting o identificazione della release, devono essere allineati nello stesso intervento.

Prima del commit:

1. cercare nel frontend tutte le occorrenze della versione precedente;
2. distinguere le occorrenze storiche/documentali, che possono restare, da quelle operative o visibili, che devono essere aggiornate;
3. verificare che il numero mostrato nell'interfaccia coincida con quello dichiarato nel PS.

Dopo il commit distinguere sempre:

```text
VERSIONE SU MAIN
    = versione presente nel repository

VERSIONE PUBBLICA VERIFICATA
    = versione effettivamente visibile su
      https://www.termodel.it/termodel-ui-demo/
```

**Non dichiarare una versione come "esposta/pubblicata" finché non è stata verificata sull'indirizzo pubblico.**

Se GitHub Pages o la cache stanno ancora mostrando una versione precedente, riportare esplicitamente entrambe le situazioni, ad esempio:

```text
main: v0.24
pubblico verificato: v0.23
```

Dopo la propagazione verificare nuovamente la pagina pubblica, preferibilmente anche con hard refresh/cache-busting.

Non saltare numeri di versione senza una decisione esplicita e non aumentare la versione per modifiche esclusivamente documentali che non cambiano il frontend eseguibile.

---

## 16. Come aggiornare questo documento

Aggiornare solo ciò che serve. Non trasformarlo in un diario completo.

Aggiornare sempre:

- data ultimo aggiornamento;
- commit corrente rilevante;
- stato della funzione in lavorazione;
- decisioni architetturali nuove;
- file nuovi/eliminati/rinominati importanti;
- contratti frontend/backend approvati;
- blocchi o rischi aperti;
- prossimo passo concreto.

Le informazioni storiche ormai superate possono essere rimosse o sintetizzate.

L'obiettivo è che una nuova chat possa leggere questo file in pochi minuti e rispondere correttamente a:

```text
Dove siamo?
Come è organizzato il progetto?
Cosa è già stato fatto?
Quali decisioni sono già state prese?
Cosa non devo toccare?
Qual è il prossimo passo?
Quali file devo leggere?
```

---

## 17. Stato operativo al momento della creazione

**ArchivioWeb v0.22 esiste già e non deve essere riscritto da zero. Il frontend complessivo su main è ora v0.63.**

Stato operativo corrente:

- JSON grafico desktop → viewer 3D, editing disabilitato;
- progetto completo `TERMODEL-PROJECT-TEXT-V1` → archivi e CAD abilitati;
- semplice SVG AI senza progetto → usa il progetto base locale `progetto-vuoto.js`, innesta la geometria e attiva archivi/CAD senza WebService;
- semplice SVG AI con progetto già strutturato → riusa il progetto esistente;
- `File → Nuovo` / avvio CAD da zero → usa lo stesso template locale;
- il frontend v0.57 non esegue più il probe automatico `GET /api/model/capabilities` e non usa `POST /api/projects/new` per il bootstrap del progetto;
- v0.63 presente su `main`;
- v0.25 ha introdotto l'avvio guidato da Archivi/File→Nuovo;
- v0.26 ha reso `Edita nel Cad` sempre attivo e diretto; **storicamente** inizializzava il progetto via WebService, ma dalla v0.57 lo stesso flusso usa il template locale `progetto-vuoto.js` e apre il CAD senza server;
- v0.27 collega nuova linea ed editazione parete agli archivi Piani/Pareti/Confini tramite la toolbar laterale conforme a `MainWindow.xaml`; colore e tipo linea sono correlati readonly;
- v0.28 rende il CAD 2D multipiano per le pareti E/W: piano corrente, filtro canvas, nuove entità assegnate al piano corrente, ID globali e GeneraPianta limitato al piano visibile mantenendo completo lo SVG di progetto;
- v0.29 corregge il canvas vuoto dopo importazione AI monopiano legacy: dopo la creazione del progetto strutturato il CAD ricarica lo SVG, assegna le entità al piano corrente e consolida `data-termodel-piano`;
- v0.30 introduce il simbolo Nord di progetto: persistente nello SVG, unico tra i piani, modificabile dal CAD e visualizzato automaticamente nel 3D con freccia o `N ?`;
- v0.31 rifinisce la presentazione del Nord: simbolo in pianta più discreto e distanziato, `?` laterale nascosto quando definito, freccia della bussola corretta verso l'esterno;
- v0.32 aumenta ulteriormente il margine del simbolo Nord rispetto alla geometria, spostandolo verso il bordo esterno alto-destra.
- v0.33 attiva i pulsanti di inserimento simboli CAD `Allinea / Porta-Finestra / Ponte / Locale`, usando automaticamente Piano corrente e `Piani.LayerCad`, con FIN/PON agganciati alla parete.
- v0.34 rende visibile e robusta l'attivazione dei comandi simbolo: pulsante in stato attivo, cursore crosshair e messaggio operativo immediato; il refresh del pannello laterale non può più annullare il feedback del comando.
- v0.35 seleziona automaticamente il simbolo appena inserito e attiva il pannello laterale contestuale; FIN/PON/LOC espongono e modificano gli attributi presenti nei tspan SVG, Allinea resta minimale.
- v0.36 sostituisce il pannello generico con controlli conformi a `MainWindow.xaml` e `DatiCad`: combo metadata-driven, valori dagli archivi, pulsanti Arc verso gli archivi correlati e gestione delle fonti ponte/altezza/quota come in `ScriptCad.cs`.
- v0.37 rende il pannello Nord contestuale: chiuso di default, apertura cliccando il simbolo Nord nel CAD, chiusura con × o cambio di contesto, liberando spazio nella colonna proprietà.
- v0.38 elimina il box generale `Dati CAD` dal pannello laterale; mantiene `Piano corrente` e `Arc Piani` spostandoli nella toolbar comandi. `Entità` è rappresentata dall'intestazione contestuale; `Layer` resta derivato internamente da `Piani.LayerCad`. Questa disposizione è una deroga esplicita alla direttiva XAML, limitata al layout CAD Web.
- v0.39 aggiunge navigazione CAD senza pulsanti UI: rotella mouse = zoom centrato sul cursore; tasto centrale + trascinamento = pan. Il tasto centrale ha priorità sugli strumenti di inserimento/selezione, lo stato viewport sopravvive ai ridisegni del canvas e viene azzerato quando si carica un nuovo SVG di lavoro.
- v0.40 aggiunge uno sfondo raster/SVG specifico per ogni piano tramite `Aggiungi sfondo`; lo sfondo viene incorporato nello SVG progetto, filtrato per `data-termodel-piano` e visualizzato sotto il Disegno input. La precedente visualizzazione `Pianta pulita` è sospesa nel CAD ma resta disponibile al motore.
- v0.41 ripristina il check `Sfondo` e introduce la calibrazione per-piano: selezione di parete orizzontale/verticale → misura reale in metri → fattore di scala applicato a sfondo, linee e posizioni dei simboli del piano corrente; pareti inclinate escluse; viewBox/Nord ricalcolati; undo/redo attivo.
- v0.42 aggiunge il check `Orto` accanto a `Snap`: durante la creazione di nuove linee E/W il secondo punto viene vincolato automaticamente all'orizzontale o alla verticale; preview e coordinate SVG rispettano il vincolo, mentre Snap viene accettato solo se non rompe l'ortogonalità.
- v0.43 introduce il layout dedicato CAD 2D: caption `Termodel Cad 2d Versione 0.43`, menu/tab/barra inferiore nascosti solo durante il CAD, pulsante `Torna al modello 3d`; tornando al modello viene ripristinato il layout generale.
- v0.44 rende il comando parete una modalità multilinea continua: ogni punto finale diventa l'inizio del segmento successivo; Orto/Snap restano attivi su ogni tratto; tasto destro apre il menu `Interrompi sequenza`, con Esc come scorciatoia.
- v0.45 compatta la toolbar CAD nei menu `Sfondo / Disegna / Snap`, lasciando `Piano + Arc` espliciti; rinomina nell'interfaccia il comando `Nuova linea` in `Nuova parete` senza modificare la rappresentazione geometrica interna.
- v0.46 aggiunge il cursore crosshair durante il comando `Nuova parete`, già prima del primo punto e per tutta la sequenza; il pan mantiene priorità con cursore grabbing.
- v0.47 memorizza origine/prima parete/conteggio della sequenza; da 3 pareti confermate il tasto destro offre `Chiudi`, che collega l'ultimo punto all'origine con una nuova parete basata sui dati della prima parete e termina la sequenza.
- v0.48 aggiunge `Chiudi ortogonale`: corregge il vertice finale condiviso con l'ultima parete per allinearlo in X o Y al punto iniziale, scegliendo lo spostamento minore valido, quindi crea una chiusura perfettamente orizzontale/verticale; correzione + chiusura sono un solo Undo.
- v0.49 ripristina il feedback visivo dello Snap sul primo punto della nuova parete: marcatore verde e stato `SNAP` compaiono già prima del primo clic, che usa lo stesso punto agganciato.
- v0.50 imposta `Orto` attivo di default all'apertura del CAD, mantenendo la possibilità di disattivarlo manualmente.
- v0.51 termina automaticamente la multilinea quando il punto finale del nuovo segmento fa Snap su una parete diversa dall'ultima parete della sequenza; lo Snap ora espone anche l'ID della parete bersaglio.
- v0.52 aggiunge nel menu del tasto destro, quando il CAD è neutro, `Ripeti ultimo comando`; memorizza Nuova parete e i quattro comandi simbolo e li riattiva con lo stato corrente.
- v0.53 divide lo Snap in `Vicino` e `Estremo` come modalità radio alternative, con `Vicino` default; Orto resta indipendente e attivo di default, mentre lo stop multilinea su parete bersaglio continua a funzionare in entrambe le modalità.
- v0.54 rende `Porta/Finestra` un comando continuo: ogni FIN inserito lascia il comando attivo per il successivo; Esc, pulsante attivo o tasto destro → `Interrompi sequenza` terminano la sequenza. Allinea/Ponte/Locale restano singoli.
- v0.55 aggiunge `Finestra 2 punti` senza sostituire il FIN a un punto: due estremi sulla stessa parete definiscono una linea provvisoria, il punto medio diventa la posizione del FIN e la distanza diventa `LARGHEZZA`; anche questo comando resta continuo fino a Esc/interruzione.
- v0.56 mostra i FIN nel 3D provvisorio come parallelepipedi orientati sulla parete, dimensionati da `LARGHEZZA / ALTEZZA / SOTTOFINESTRA` e leggermente più profondi della parete; la prova reale ha evidenziato un difetto di allineamento/profondità sulle E ancora da correggere.
- v0.57 usa un progetto vuoto locale consolidato in JavaScript per `Nuovo` e per strutturare un semplice SVG AI, eliminando la necessità di tenere acceso il WebService durante i test frontend.
- v0.58 implementa il round-trip bidirezionale `progetto unico ↔ frontend`: `Apri`, `Salva` e `Salva con nome` usano `TERMODEL-PROJECT-TEXT-V1`; geometria e archivi JSON/XML vengono ricomposti e il manifest aggiorna le impronte. Questa serializzazione è la base prima di future richieste al WebService.
- decisione architetturale: gli sfondi sono risorse locali/frontend e **non devono essere trasmessi a Termodel.Core / Termodel.WebService**; il futuro payload server deve derivare dal progetto unico aggiornato filtrando completamente raster/SVG, Data URL/Base64 e relativi asset di sfondo.
- v0.59 consolida gli sfondi nel progetto locale come `assets/backgrounds/index.json` + `assets/backgrounds/BGxxx.data`: `geometry/project.svg` resta leggero e contiene solo il riferimento; `Apri` reidrata il Data URL nel CAD. I vecchi sfondi incorporati vengono migrati automaticamente al primo Salva.
- v0.60 aggiunge lo sfondo DXF: `Aggiungi sfondo` riconosce `.dxf`, apre un dialog layer/opzioni e converte il contenuto 2D in SVG con `dxf-plotter.js`; default tutti i layer + solo LINE/POLYLINE/LWPOLYLINE.
- v0.61 stabilisce `cm` come unità interna del CAD Web e aggiunge nel dialog DXF la combo `m / cm / mm`, proposta da `$INSUNITS`; il plotter normalizza la geometria in cm e lo sfondo DXF entra alla dimensione reale 1:1 senza essere adattato al viewBox esistente.
- v0.62 formalizza che la scelta dell'unità DXF è la **calibrazione automatica**: il plotter converte in cm, normalizza l'origine e inverte Y senza alterare le distanze. `Calibra` resta solo una correzione eccezionale per DXF/unità errati.
- v0.63 aggiunge lo **Snap sfondo vettoriale** attivo di default: endpoint/vertici dello SVG si sommano allo Snap normale; il candidato più vicino vince, ma lo snap sfondo non restituisce `targetLineId` e quindi non viene scambiato per una parete Termodel.
- la generazione 3D corrente nel frontend resta **provvisoria**; la generazione 3D completa e autorevole, con aperture reali, sarà responsabilità di Termodel.Core / Termodel.WebService.

Il flusso AI → progetto strutturato, introdotto originariamente in v0.24 tramite progetto server, è stato mantenuto ma il bootstrap è stato sostituito in v0.57 dal progetto base locale consolidato in JavaScript. Dalla v0.58 lo stesso `TERMODEL-PROJECT-TEXT-V1` è anche ricostruibile dal frontend dopo le modifiche e costituisce la fotografia completa da salvare o, in futuro, inviare al server.

Il prossimo lavoro frontend deve rispettare il flusso utente della sezione 12.4.

Le prime due priorità UX della sezione 12.4 sono state realizzate in v0.25.

Priorità immediate:

> 1. collaudare manualmente la v0.63 sul DXF reale `Farmacia.dxf`: `Snap → Sfondo vettoriale` deve essere attivo di default; durante `Nuova parete` il cursore vicino a un vertice DXF deve mostrare `SNAP SFONDO` e fissare il punto esattamente sul vertice;  
> 2. dopo il collaudo del round-trip, usare `buildCurrentProjectText()` come base obbligatoria di qualsiasi futura chiamata WebService; prima dell'invio produrre però un payload server filtrato, **senza sfondi raster/SVG, Data URL/Base64 o relativi asset**;  
> 3. correggere il difetto osservato nella v0.56 sui FIN 3D delle pareti esterne: alcuni parallelepipedi risultano male centrati nello spessore e visibili soprattutto dal lato interno; mantenere la soluzione provvisoria senza CSG/fori;  
> 4. completare trascinamento simboli, snap in spostamento e vincolo LOC;  
> 5. portare nel Core/WebService la generazione/aggiornamento del modello 3D completo multipiano, includendo correttamente le aperture/finestre FIN; l'attuale generazione 3D frontend resta provvisoria e non è il riferimento funzionale definitivo.

### Handoff rapido per una nuova chat

Se questa conversazione termina, una nuova chat deve poter riprendere senza ricostruire il lavoro precedente.

**Stato da cui ripartire:**

```text
branch: main
frontend: Termodel Web v0.63
ultimo commit funzionale frontend:
952b605637dc44095639e3b0b4d41fa7d06347ce
Add vector background endpoint snap v0.63
```

**File da leggere per il lavoro immediato sul progetto unico:**

```text
PROJECT-SUMMARY.md
docs/termodel-ui-demo/app.js
docs/termodel-ui-demo/archivio-web.js
docs/termodel-ui-demo/termodel-project-text.js
docs/termodel-ui-demo/progetto-vuoto.js
SorgentiTermodel/Library/projects/ProgettoVuoto/ProgettoVuoto.termodel.txt
```

Fonte del template vuoto:

```text
f58a9725d0129da9809be64013e6c15ce1dd5b06
Add static empty Termodel project
```

**Funzioni chiave v0.58:**

```text
loadProjectTextIntoFrontend(text, options)
    progetto unico → ArchivioWeb + geometry/project.svg → CAD/viewer

buildCurrentProjectText()
    CAD corrente + tutti gli archivi ArchivioWeb
    → buildTermodelProjectText(...)
    → TERMODEL-PROJECT-TEXT-V1 aggiornato

buildTermodelProjectText(source, options)
    conserva sezioni non modificate
    aggiorna geometry/project.svg
    aggiorna archives/json/*.json
    aggiorna archives/xml/*.xml
    sincronizza assets/backgrounds/*
    aggiorna manifest + SHA-256

consolidateTermodelBackgrounds(svg)
    Data URL CAD → asset progetto + riferimento BGxxx

hydrateTermodelBackgrounds(projectText, svg)
    asset progetto → Data URL temporaneo nel CAD

parseDxfPlotSource(text)
    DXF ASCII → modello 2D per dialog/conversore

convertDxfToSvg(model, options)
    layer/opzioni/unità DXF → SVG semplificato in centimetri Termodel

dxfUnitFromInsUnits(insUnits)
    $INSUNITS 4/5/6 → mm/cm/m

dxfUnitScaleToCm(unit)
    mm=0,1 · cm=1 · m=100

cadBackgroundSnapCandidates(point)
    sfondo SVG vettoriale → endpoint vicini al cursore

cadSnapPoint(point, movingLineId)
    Snap pareti + endpoint sfondo → candidato più vicino
```

**Nota importante sulla struttura del codice:** l'import degli archivi è ancora implementato da `loadTermodelProjectText(...)` in `archivio-web.js`; `app.js` orchestra la conversione verso lo stato CAD; `termodel-project-text.js` centralizza parsing/sostituzione delle sezioni e soprattutto la ricostruzione del progetto unico. Non riscrivere ArchivioWeb da zero.

**Test già eseguiti sulla v0.58-v0.63:**

- sintassi JavaScript valida per `app.js`, `archivio-web.js` e `termodel-project-text.js`;
- round-trip strutturale sul vero `ProgettoVuoto.termodel.txt`: 26 sezioni prima e dopo;
- modifica di prova `Piani.AltezzaNetta 3 → 3.2` mantenuta coerente in JSON, XML e `manifest.floors`;
- struttura hash del manifest verificata a 64 caratteri;
- v0.59: aggiunta di uno sfondo sintetico porta le sezioni 26 → 28, con indice + asset presenti nel manifest; rimuovendo lo sfondo il progetto torna a 26 sezioni e le entry vengono eliminate;
- v0.60: test DXF sintetico superato per layer, linee/polilinee, testo opzionale e BLOCK/INSERT opzionale;
- v0.61: test scala reale superato: `4000 mm`, `400 cm` e `4 m` producono tutti `400 cm = 4 m` nel CAD Termodel;
- v0.62: test con coordinate lontane dall'origine superato: `1000 → 1013,0977 m` resta esattamente `13,0977 m` dopo conversione in cm e normalizzazione origine;
- v0.63: test Snap sfondo superato: mapping SVG→CAD corretto, `SNAP SFONDO`, `snapSource=background` e `targetLineId=""`.

**Limite del test automatico:** l'ambiente usato per il controllo non esponeva Web Crypto; il percorso è stato esercitato con un digest simulato per controllare la ricomposizione. Nel browser reale `buildTermodelProjectText()` usa `crypto.subtle.digest('SHA-256', ...)`. È quindi obbligatorio il test manuale reale di Salva.

**Test manuale prioritario, WebService spento:**

```text
modello demo
→ Salva / Salva con nome devono essere disabilitati

Nuovo
→ Aggiungi sfondo
→ scegliere Farmacia.dxf
→ importare in scala automatica
→ Snap → Sfondo vettoriale deve essere ON
→ Nuova parete
→ avvicinarsi a un endpoint/vertice del DXF
→ verificare SNAP SFONDO
→ cliccare e controllare che l'estremo cada esattamente sul vertice
→ verificare che lo snap sfondo non interrompa la sequenza come se fosse una parete
→ Salva
→ Apri... e verificare persistenza dello sfondo
```

Nota UX: `Salva` in v0.58 genera un download del browser; non scrive direttamente sopra il file precedentemente aperto. `Salva con nome` chiede il nome e genera anch'esso un download.

**Precondizione per il futuro server:** qualsiasi API che lavori sul progetto corrente deve partire dal risultato di `buildCurrentProjectText()`. Prima della chiamata deve però essere prodotta una variante del progetto unico che **esclude tutti gli sfondi raster/SVG e gli eventuali asset di sfondo**. Non inviare geometria o archivi come stati separati se l'operazione richiede il progetto completo.

**Problema aperto indipendente dal round-trip — FIN nel 3D provvisorio v0.56:**

- i FIN sono presenti come parallelepipedi autonomi;
- su alcune pareti esterne E risultano male centrati nello spessore e visibili soprattutto dall'interno;
- non introdurre CSG o veri fori nel frontend;
- correzione proposta ma **non ancora implementata**: rendere più robusta la determinazione del lato esterno nel punto della finestra, centrare il FIN a metà dello spessore E e aumentare l'eccedenza visiva da 4 cm totali a circa 10 cm totali (≈5 cm per faccia);
- il 3D definitivo resta responsabilità di Termodel.Core / Termodel.WebService.

**Altri lavori aperti CAD:** trascinamento simboli, snap durante lo spostamento e vincolo LOC.

Prima di iniziare il prossimo intervento, ricontrollare `main` perché potrebbero essere arrivati nuovi commit dopo `952b605637dc44095639e3b0b4d41fa7d06347ce`.
