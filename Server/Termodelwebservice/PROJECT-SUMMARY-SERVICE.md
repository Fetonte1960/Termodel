# TERMODEL CORE + WEBSERVICE — PROJECT SUMMARY

Ultimo aggiornamento: **2026-09-21**  
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

### INCARICO 2026-09-21 — Invarianza Polig3D e TermodelWebModel v3 completo
Stato: COMMISSIONATO

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
- in corso.



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
`Cened`, `IoPannelli` e successivi). Non è ancora lo storage persistente
degli snapshot `calculationId`: quel lifecycle verrà introdotto con
`POST /api/calculations`.

Il workspace è un adattatore interno, non il formato autorevole del progetto.
Il file unico resta l'input autorevole; gli output del workspace diventeranno
artifact dello snapshot e non devono essere reinseriti implicitamente nel
progetto.

## 4. Storia consolidata dello sviluppo Service

### Studio di fattibilità

Il lavoro è iniziato valutando un motore Termodel eseguibile su server ASP.NET
Core con modifiche minime ai sorgenti desktop. Form, WPF e visualizzazione 3D
desktop sono stati esclusi dal motore. È stata valutata inizialmente anche la
generazione IFC, ma per la comunicazione col frontend è stato scelto un modello
3D JSON diretto: evita Xbim e semplifica distribuzione e hosting.

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

Sono state selezionate e adattate con modifiche minime le classi `LeggiDxf`,
`DXFLineCheck`, `GeneraModello`, `GeneraPianta`, `Tetti`, `Confini`, `Polig3D` e
`Modello`. Una compatibilità `netDxf` minima viene popolata dallo SVG del file
unico; non è un lettore DXF generale. `UtiDb` e `Database.DB` lavorano sugli
archivi XML in memoria. WPF/Helix sono sostituiti esclusivamente nei punti UI o
diagnostici; la geometria usa NetTopologySuite. Lo stato storico viene protetto
da un gate seriale.

`POST /api/model/3d` riceve `text/plain; charset=utf-8` e restituisce direttamente
`TermodelWebModel` v3 JSON. Non produce IFC. `GET
/api/model/clean-floor/{floorName}` restituisce lo SVG architettonico pulito
dell'ultima generazione.

Il 21 settembre 2026 la soluzione è stata compilata su copia temporanea con
0 errori e 108 avvisi di nullabilità ereditati. Il test HTTP con `ProgettoVuoto`
ha restituito 200 e un modello valido con 0 primitive; un Content-Type errato
ha restituito 415. Il server di prova è stato arrestato.

## 5. API implementate

```text
GET  /
GET  /health
GET  /api/model/capabilities
GET  /api/model/clean-floor/{floorName}
POST /api/projects/new
POST /api/model/3d
```

`POST /api/projects/new` accetta JSON/DTO e restituisce il file unico come testo
UTF-8 con HTTP 201. `POST /api/model/3d` accetta il file unico testuale e
restituisce `TermodelWebModel` v3. Errori di progetto o funzioni non supportate
sono restituiti come Problem Details; Content-Type non valido produce 415.

### Workflow server concordato: AggiornaCalcolo

Decisione architetturale consolidata del 21 settembre 2026, **progettata ma non
ancora implementata**.

Il frontend dovrà inviare il file unico `TERMODEL-PROJECT-TEXT-V1` con una sola
operazione di aggiornamento generale, concettualmente `AggiornaCalcolo`. Il
server dovrà eseguire una sola ricostruzione coerente del progetto e produrre
gli elaborati derivati, replicando progressivamente il flusso del Desktop senza
duplicarne il motore.

Contratto previsto:

```text
Frontend
  -> POST /api/calculations
       body: file unico TERMODEL-PROJECT-TEXT-V1
  -> Termodel.Core ricostruisce il progetto una sola volta
  -> genera gli elaborati disponibili
  -> restituisce calculationId + manifest degli artifact
```

Ogni elaborazione deve essere identificata da un `calculationId`. Non bisogna
basare le nuove API sul concetto di "ultimo calcolo globale", perché due
browser, due progetti o più utenti potrebbero altrimenti leggere risultati
incrociati.

Le view del frontend non devono rilanciare i calcoli. Devono leggere gli
elaborati dello snapshot già prodotto, mediante richieste specifiche del tipo:

```text
GET /api/calculations/{id}/artifacts/model3d
GET /api/calculations/{id}/artifacts/xml-nazionale
GET /api/calculations/{id}/artifacts/report-dispersioni
GET /api/calculations/{id}/artifacts/pannelli
GET /api/calculations/{id}/artifacts/spirali/{piano}
GET /api/calculations/{id}/artifacts/pianta-pulita/{piano}
```

Nomi e dettagli definitivi degli endpoint potranno essere affinati durante
l'implementazione, ma il principio è consolidato: **una elaborazione produce
uno snapshot coerente; le view leggono gli artifact dello snapshot**.

Formati indicativi degli artifact:

- modello 3D: JSON;
- XML nazionale: `application/xml`;
- report dispersioni: dati JSON, non HTML generato dal Core;
- report pannelli: dati JSON;
- spirali: SVG per piano;
- pianta pulita: SVG per piano;
- eventuali esecutivi DXF: `application/dxf`.

Per la prima implementazione è ammesso un workspace temporaneo per
`calculationId`, vicino al comportamento file-based del Desktop. Questo
consente di migrare con modifiche minime `GestXml`, `IoPannelli` e le altre
classi storiche; in seguito gli artifact potranno essere gestiti con uno storage
più evoluto senza cambiare il contratto concettuale.

Compatibilità: gli endpoint correnti `POST /api/model/3d` e
`GET /api/model/clean-floor/{floorName}` non vanno eliminati nella prima fase.
La migrazione al nuovo workflow deve essere progressiva e retrocompatibile.

Sequenza di implementazione concordata:

1. **Fase 1:** `POST /api/calculations`, `calculationId`, storage dello
   snapshot, modello 3D e piante pulite;
2. **Fase 2:** XML nazionale e report dispersioni;
3. **Fase 3:** calcolo pannelli radianti e spirali SVG;
4. estensioni successive: ulteriori elaborati Desktop, regression test e
   persistenza/multiutente.

Regola di efficienza: `AggiornaCalcolo` deve ricostruire il modello **una sola
volta**. Richiedere XML, spirali, report o 3D non deve provocare una nuova
elaborazione completa del progetto.

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
crea prima un backup in `_backups/<data-ora>/TermodelWebService`. Usare anche i
wrapper `SERVICE_A_GITHUB.cmd` e `SERVICE_DA_GITHUB.cmd`, che mostrano lo stato
e chiedono conferma prima della copia.

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
- motore 3D headless senza IFC;
- endpoint Modello3D e pianta pulita;
- GitHub Actions per restore/build automatico;
- build Release corrente su GitHub Actions con 0 errori e 108 warning;
- test HTTP minimo storico sul `ProgettoVuoto` eseguito prima dell'ultimo
  refactoring di compatibilità.

Incompleto:

- riesecuzione HTTP locale del `ProgettoVuoto` dopo il nuovo strato Virtual
  CAD/DB/Project;
- file unico/golden test del progetto mansardato;
- regression test automatici e Golden Results versionati;
- workflow `AggiornaCalcolo`/`calculationId` e artifact per le view, concordato ma non ancora implementato;
- API CRUD archivi, persistenza e concorrenza multiutente;
- autenticazione e autorizzazione;
- EnergyPlus, gbXML e IDF;
- eliminazione progressiva delle copie `TERMODEL-SYNC`;
- gestione e riduzione dei 108 avvisi di nullabilità;
- pubblicazione su hosting remoto/container dopo i test Docker locali.

## 11. Prossimi passi consigliati

1. implementare la Fase 1 del workflow `AggiornaCalcolo`: `calculationId`,
   snapshot, modello 3D e piante pulite, mantenendo gli endpoint esistenti;
2. generare lo SVG multipiano e il file unico del progetto mansardato;
3. eseguire `POST /api/model/3d` e confrontare il risultato con le 546 primitive
   del JSON desktop, definendo tolleranze e report;
4. creare una suite automatica di regression test e `GoldenResults/`;
5. integrare progressivamente XML nazionale/dispersioni e poi pannelli/spirali
   nel nuovo workflow;
6. definire API autorevoli per schema, archivi, validazione e CRUD;
7. progettare il contratto energetico prima di scegliere gbXML o IDF;
8. provare build e runtime in Docker locale;
9. ridurre gradualmente `CopiedFromTermodel` spostando la logica condivisibile
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
