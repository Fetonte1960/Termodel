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

Lo stato attuale è parziale: il 3D usa già `SvgDxfReader` e un `DxfDocument`
compatibile, ma oggi il documento viene costruito principalmente per singolo
gruppo/piano. Va evoluto verso il documento logico multi-layer per `NomeFile`
senza trasformare `netDxf` compatibile in un lettore DXF generale.

### Virtual DB

Gli archivi autorevoli per il motore nel file unico sono
`archives/xml/*.xml`. `ProjectArchiveDatabase` li carica in memoria e
l'adattatore `UtiDb` / `Database.DB` deve replicare la semantica Desktop,
non solo le firme necessarie alla compilazione.

Prima di collegare `GestXml` devono essere allineati almeno:

- comportamento dei lookup non trovati (`null` dove il Desktop restituisce
  `null`, non stringa vuota);
- `TipoZona` e valori testuali esattamente coerenti col Desktop;
- `AggiungiZoneStandard`;
- ulteriori metodi richiesti dai moduli migrati, aggiunti alla facciata invece
  di modificare i chiamanti storici.

Il JSON parallelo degli archivi è una rappresentazione utile al Web/AI; il
motore Core continua a usare come riferimento runtime gli XML del file unico,
finché il contratto non stabilirà diversamente.

### Virtual Project

I moduli Desktop file-based (`GestXml`, `CalcoloAPE`, `Cened`,
`IoPannelli` e successivi) devono poter lavorare in un workspace temporaneo
isolato per elaborazione/`calculationId`, che materializzi soltanto i file
necessari con percorsi simili al progetto Desktop.

Il workspace è un adattatore interno, non il formato autorevole del progetto.
Il file unico resta l'input autorevole; gli output del workspace diventano
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

## 9. Compilazione ed esecuzione locale

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
- parser SVG → compatibilità netDxf;
- archivi XML in memoria;
- motore 3D headless senza IFC;
- endpoint Modello3D e pianta pulita;
- build con 0 errori e test HTTP minimo.

Incompleto:

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
