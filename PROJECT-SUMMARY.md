# TERMODEL — PROJECT SUMMARY

> **Documento primario di continuità del progetto**
>
> Ogni nuova chat o sessione che lavora sul repository Termodel deve leggere **questo file per primo**, prima di proporre o modificare codice.
>
> Questo documento serve a evitare la perdita di contesto quando una chat diventa troppo lunga. Deve essere mantenuto breve, operativo e aggiornato dopo ogni intervento che cambia architettura, stato, file importanti, contratti o prossimi passi.

Ultimo aggiornamento: **2026-09-20**  
Branch di riferimento: **main**  
Ultimo commit di codice verificato al momento della creazione di questo documento:  
`eadb72430a1f585bf542f50403cbb494c869dcc4` — `Connect complete project import and ArchivioWeb v0.22`  
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
Termodel Web v0.35
```

Commit frontend di riferimento per la v0.35:

```text
3f83edca56c5b1171c2296d348d806a91564a801  Activate symbol properties after insertion
```

Ultima versione pubblica verificata manualmente dall'utente:

```text
Termodel Web v0.30
```

La v0.34 è stata verificata manualmente dall'utente il 2026-09-20: i comandi di inserimento simboli si attivano correttamente e Porta/Finestra inserisce il simbolo. La v0.35 è su `main` e deve essere verificata pubblicamente.

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

Il bridge `ArchivioWeb → CAD` è attualmente di lettura dei record in memoria; la persistenza unificata del contenitore progetto resta da completare.

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

Quando l'utente importa in Termodel Web una **pianta generata o modificata dall'AI**, Termodel Web deve verificare se esiste già una struttura progetto completa e utilizzabile come base dati.

Se tale struttura **non è stata ancora creata**, Termodel Web avvia la strutturazione del progetto chiedendo al server un **progetto vuoto** tramite il contratto già esistente:

```text
POST /api/projects/new
```

Flusso concettuale:

```text
AI
  ↓
pianta importata
  ↓
Termodel Web
  ↓
verifica presenza progetto strutturato
  ↓
se manca
  ↓
richiede progetto vuoto al WebService
  ↓
usa il progetto vuoto come base dati editabile
  ↓
integra la pianta importata nella struttura progetto
```

Il progetto vuoto restituito dal server diventa quindi la **base strutturata ed editabile** su cui Termodel Web può lavorare con archivi, dati e successive funzioni di editing.

Questo passaggio è importante perché una semplice pianta proveniente dall'AI non deve essere trattata come se fosse già, da sola, un progetto Termodel completo.

Principio operativo:

```text
pianta AI
    ≠ progetto Termodel completo

pianta AI + progetto vuoto server
    → progetto strutturabile/editabile in Termodel Web
```

Se invece una struttura progetto completa è già presente, Termodel Web non deve crearne inutilmente un'altra: deve utilizzare quella esistente come base per l'importazione/modifica.

### Attivazione della modalità editabile

Una volta che la pianta proveniente dall'AI è stata associata a una **struttura progetto completa**, Termodel Web può attivare le funzioni di editing.

A questo punto diventano disponibili entrambe le modalità di modifica:

```text
PROGETTO STRUTTURATO
        │
        ├── EDITING TESTUALE / DATI
        │      ↓
        │   menu archivi
        │   griglie e form
        │   modifica dei dati Termodel
        │
        └── EDITING GRAFICO
               ↓
            "Edita nel CAD"
            CAD/BIM 2D JavaScript
            modifica geometrica della pianta
```

Quindi il passaggio chiave è:

```text
semplice pianta AI
    → strutturazione tramite progetto server
    → progetto Termodel editabile
    → archivi attivi
    → CAD/BIM 2D attivo
```

La disponibilità dell'editing non deve dipendere dal solo fatto che una geometria sia visibile: deve dipendere dalla presenza di una **base progetto strutturata e coerente**.

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
    │   progetto vuoto server
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
POST /api/projects/new
      ↓
progetto Termodel strutturato
      ↓
archivi + CAD attivi
```

Questo flusso è già stato verificato con successo nella v0.24.

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

Finestre, ponti termici e locali devono progressivamente essere gestiti come simboli CAD collegati ai dati del progetto secondo la sezione 12.3.

### 6. Modello coerente — accesso alle funzioni avanzate server

Quando geometria, simboli e dati del progetto sono coerenti, Termodel Web deve poter interrogare **Termodel.Core / Termodel.WebService** per le funzioni avanzate che non devono essere duplicate nel browser.

Direzione prevista:

```text
progetto Web coerente
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

### Verifica dello stato reale alla v0.30

Confronto fra flusso desiderato e programma attuale:

| Passaggio | Stato v0.30 | Nota |
| --- | --- | --- |
| Apertura con modello demo 3D | **REALIZZATO** | `loadModel()` carica automaticamente `TermodelWebModel.json` |
| Esplorazione del modello demo | **REALIZZATO** | viewer e menu dimostrativi disponibili |
| Accesso archivi senza progetto → guida alla creazione | **REALIZZATO** | apre la finestra guidata con `Disegna da zero / Istruisci AI / Importa da AI` |
| `Istruisci AI` | **REALIZZATO** | copia il prompt di collegamento e mostra la procedura |
| `Importa da AI` | **REALIZZATO** | import SVG/progetto completo |
| AI → progetto vuoto server → progetto strutturato | **REALIZZATO E VERIFICATO** | v0.24, archivi attivati correttamente dopo l'importazione |
| Editing archivi | **REALIZZATO IN FORMA LOCALE** | form/griglie/CRUD in memoria; persistenza unificata ancora da completare |
| `Edita nel CAD` su progetto strutturato | **REALIZZATO E ESTESO IN v0.27** | modifica pareti E/W, snap, undo/redo, nuova linea; toolbar laterale collegata a Piani/Pareti/Confini con colore e tipo linea correlati |
| CAD come partenza di un progetto da zero | **REALIZZATO IN v0.25** | crea un progetto vuoto via WebService, prepara uno SVG vuoto e apre il CAD con `Nuova linea` disponibile |
| `Edita nel CAD` senza progetto | **REALIZZATO IN v0.26** | inizializza direttamente un progetto vuoto via WebService e apre il CAD 2D, senza finestra intermedia |
| Simboli FIN/PON/LOC editabili e collegati agli archivi | **DA SVILUPPARE** | definito il flusso nella sezione 12.3 |
| Calcoli server reali | **NON ANCORA REALIZZATI** | pagina Calcoli è esplicitamente dimostrativa |
| Aggiornamento modello 3D completo dal server | **NON ANCORA REALIZZATO** | il WebService documentato espone oggi solo gli endpoint base; `Aggiorna modello` non è ancora presente |
| BIM/IFC via server | **SOLO DIREZIONE PREVISTA / UI DIMOSTRATIVA** | esistono voci di menu e output pianificati, non un flusso server completo verificato |

### Conseguenza per la UX

Il prossimo frontend non deve aggiungere funzioni isolate senza considerare questo percorso.

Priorità UX dopo la v0.25:

1. completare FIN/PON/LOC e collegamento disegno ↔ archivi;
2. consolidare lo stato unico del progetto tra CAD e ArchivioWeb;
3. introdurre uno stato di **progetto coerente/pronto**;
4. soltanto allora collegare progressivamente le funzioni avanzate Core/WebService.

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

### Stato

**IMPLEMENTATO IN v0.30 E RIFINITO IN v0.31/v0.32**.

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

### Stato

**PARZIALMENTE IMPLEMENTATO IN v0.35 — INSERIMENTO + SELEZIONE + PANNELLO ATTRIBUTI ATTIVI; SPOSTAMENTO DA COMPLETARE.**

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

**ArchivioWeb v0.22 esiste già e non deve essere riscritto da zero. Il frontend complessivo su main è ora v0.35.**

Stato operativo corrente:

- JSON grafico desktop → viewer 3D, editing disabilitato;
- progetto completo `TERMODEL-PROJECT-TEXT-V1` → archivi e CAD abilitati;
- semplice SVG AI senza progetto → richiesta automatica di progetto vuoto al WebService, innesto della geometria, quindi attivazione archivi/CAD;
- semplice SVG AI con progetto già strutturato → riusa il progetto esistente;
- controllo `GET /api/model/capabilities` collegato al WebService locale;
- `POST /api/projects/new` collegata sperimentalmente con richiesta minima `{}`, in attesa della documentazione formale del DTO;
- v0.35 presente su `main`;
- v0.25 ha introdotto l'avvio guidato da Archivi/File→Nuovo;
- v0.26 rende `Edita nel Cad` sempre attivo e diretto: se manca il progetto, lo inizializza via WebService e apre subito il CAD 2D;
- v0.27 collega nuova linea ed editazione parete agli archivi Piani/Pareti/Confini tramite la toolbar laterale conforme a `MainWindow.xaml`; colore e tipo linea sono correlati readonly;
- v0.28 rende il CAD 2D multipiano per le pareti E/W: piano corrente, filtro canvas, nuove entità assegnate al piano corrente, ID globali e GeneraPianta limitato al piano visibile mantenendo completo lo SVG di progetto;
- v0.29 corregge il canvas vuoto dopo importazione AI monopiano legacy: dopo la creazione del progetto strutturato il CAD ricarica lo SVG, assegna le entità al piano corrente e consolida `data-termodel-piano`;
- v0.30 introduce il simbolo Nord di progetto: persistente nello SVG, unico tra i piani, modificabile dal CAD e visualizzato automaticamente nel 3D con freccia o `N ?`;
- v0.31 rifinisce la presentazione del Nord: simbolo in pianta più discreto e distanziato, `?` laterale nascosto quando definito, freccia della bussola corretta verso l'esterno;
- v0.32 aumenta ulteriormente il margine del simbolo Nord rispetto alla geometria, spostandolo verso il bordo esterno alto-destra.
- v0.33 attiva i pulsanti di inserimento simboli CAD `Allinea / Porta-Finestra / Ponte / Locale`, usando automaticamente Piano corrente e `Piani.LayerCad`, con FIN/PON agganciati alla parete.
- v0.34 rende visibile e robusta l'attivazione dei comandi simbolo: pulsante in stato attivo, cursore crosshair e messaggio operativo immediato; il refresh del pannello laterale non può più annullare il feedback del comando.
- v0.35 seleziona automaticamente il simbolo appena inserito e attiva il pannello laterale contestuale; FIN/PON/LOC espongono e modificano gli attributi presenti nei tspan SVG, Allinea resta minimale.

Il flusso AI → progetto strutturato v0.24 è stato verificato manualmente dall'utente: dopo l'importazione AI gli archivi risultano attivi e compilati dal progetto server.

Il prossimo lavoro frontend deve rispettare il flusso utente della sezione 12.4.

Le prime due priorità UX della sezione 12.4 sono state realizzate in v0.25.

Priorità immediate:

> 1. verificare manualmente la v0.29 pubblicata ripetendo il caso reale: `Importa da AI` con SVG monopiano privo di `data-termodel-piano` → progetto strutturato → `Edita nel Cad` → pareti e LOC visibili sul piano `Unico`; quindi provare anche un progetto con almeno due record in `Piani`;  
> 2. verificare manualmente la v0.32: simbolo Nord in pianta sufficientemente distanziato dalla geometria → `?` laterale assente quando l'orientamento è definito → freccia della bussola rivolta verso l'esterno;  
> 3. verificare manualmente la v0.35: inserimento FIN/PON/LOC → simbolo automaticamente selezionato → pannello laterale contestuale con attributi SVG → modifica/Applica; verificare anche il clic successivo sul simbolo già presente; quindi completare trascinamento, snap in spostamento e vincolo LOC;  
> 4. unificare progressivamente stato CAD e stato archivi nel contenitore progetto;  
> 5. successivamente portare nel Core/WebService la generazione/aggiornamento del modello 3D completo multipiano.

Prima di iniziare questo refactoring, ricontrollare `main` perché potrebbero essere arrivati nuovi commit dopo `eadb72430a1f585bf542f50403cbb494c869dcc4`.
