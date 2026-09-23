# Copie selettive da Termodel desktop

Documento di tracciamento per il motore `Modello3D` del WebService.

Le copie presenti sotto `src/Termodel.Core/CopiedFromTermodel` sono una fase
temporanea di migrazione. Gli originali Termodel desktop non vengono modificati.
Ogni adattamento deve essere minimo, commentato e classificato come modifica
riportabile nel Core condiviso oppure esclusiva del server.

## Regole

- `definizionedati/definizionedati.json` resta la fonte autorevole e non viene modificato.
- WPF e Helix non sono dipendenze runtime del percorso Web; xBIM Essentials è
  usato soltanto come modello dati IFC in memoria per conservare invariato
  `Polig3D`, senza esportare file IFC.
- Le funzioni database, geometriche e di validazione usate dal modello sono reali.
- Le sole funzioni di UI o diagnostica grafica possono essere no-op controllati.
- Una funzione funzionale non supportata genera `NotSupportedException`; non restituisce successo fittizio.
- La chiusura statica delle dipendenze è completata; la soluzione è stata compilata
  su copia temporanea il 21 settembre 2026 con 0 errori.

## Inventario iniziale

| Copia WebService | Originale desktop | Trattamento previsto |
|---|---|---|
| `CopiedFromTermodel/Leggidxf/GeneraModello.cs` | `Leggidxf/GeneraModello.cs` | orchestratore completo ridotto, a istanza e headless |
| `CopiedFromTermodel/Leggidxf/GeneraPianta.cs` | `Leggidxf/GeneraPianta.cs` | geometria pulita reale; serializzazione SVG al posto del DXF |
| `CopiedFromTermodel/Leggidxf/LeggiDxf.cs` | `Leggidxf/LeggiDxf.cs` | logica principale, modifiche minime |
| `CopiedFromTermodel/Leggidxf/DXFLineCheck.cs` | `Leggidxf/DXFLineCheck.cs` | geometria/topologia reale |
| `CopiedFromTermodel/Leggidxf/Tetti.cs` | `Leggidxf/Tetti.cs` | geometria reale, contenitori IFC sostituiti |
| `CopiedFromTermodel/Leggidxf/Confini.cs` | `Leggidxf/Confini.cs` | regole reali, geometria neutra |
| `CopiedFromTermodel/Model/Polig3D.cs` | `Leggidxf/Polig3D.cs` | copia byte-per-byte invariata; dipendenze soddisfatte da facciate headless/xBIM in memoria |
| `CopiedFromTermodel/Model/Modello.cs` | `Modello.cs` | adattatore headless che materializza le strutture xBIM in memoria e alimenta `ElementoAssociato` |

## Dipendenze sostitutive

| Dipendenza desktop | Sostituzione WebService |
|---|---|
| `netDxf` | Virtual CAD: documento logico multi-layer per `NomeFile`, popolato dallo SVG e risolto da `DxfDocument.Load` |
| `UtiDb` / `Database.DB` | Virtual DB: archivi XML del file unico in memoria con semantica Desktop per i metodi migrati |
| `GestProg` | Virtual Project: `ProjectWorkspace` temporaneo con percorsi Desktop-like |
| `TermodelLog` | diagnostica strutturata per la risposta HTTP |
| WPF / Helix | facciate/no-op controllati e renderer headless `DrawBim` |
| Xbim / IFC | `Xbim.Essentials 6.1.605` come modello dati in memoria; nessun file IFC prodotto |

## Provenienza verificata

| File | SHA-256 |
|---|---|
| Desktop `Leggidxf/GeneraModello.cs` | `2D2B607EDD9680945C9195BAF5205005DFE9DD6C3BB7ED31E14D71509BF7C504` |
| Copia ridotta `CopiedFromTermodel/Leggidxf/GeneraModello.cs` | `937C1F2B418AB454FF1D60BBCF0B26D09F87AF15065A4DF6E967084A0710D4CE` |
| Desktop `Leggidxf/GeneraPianta.cs` | `26715FA5E614504DBD1B3D7DDA08717E161AC7F485AF074368104DA1AB4ED407` |
| Copia SVG `CopiedFromTermodel/Leggidxf/GeneraPianta.cs` | `2978BB3A1B3EA0006924E0A80161698C247BBF0133D8C3C91FD510A0F51A97EA` |
| Desktop `utilities/TermodelLog.cs` | `79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218` |

Gli hash differenti sono intenzionali: la copia conserva l'algoritmo di
orchestrazione ma sostituisce UI, filesystem DXF e chiusura IFC con gli adattatori
headless del file unico.

## Confronto TermodelLog Desktop / headless

Il riferimento Desktop completo è stato acquisito, senza adattamenti, in
`SorgentiTermodel/Library/utilities/TermodelLog.cs`. La copia ha lo stesso
SHA-256 dell'originale locale `utilities/TermodelLog.cs`:

```text
79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218
```

### Contratto comune conservato

Entrambe le implementazioni espongono il nucleo usato dalle classi migrate:

- `InitializeLog()` inizializza un nuovo ciclo di log;
- `WriteLog(...)`, `LogOperation(...)` e `LogError(...)` ricevono i messaggi;
- `LogContesto` aggiunge il contesto del chiamante;
- `IsEnabled(...)` governa i blocchi diagnostici condizionati;
- `erroreDaMostrare` conserva il concetto Desktop del primo errore destinato
  all'interfaccia, pur non essendo usato dal contratto HTTP.

### Comportamento autorevole Desktop

- persistenza globale in `GestProg.ProgramPath/TermodelLog.md` e
  `LogError.md`;
- `InitializeLog()` tronca e reinizializza i file e azzera il contatore SVG;
- categorie: `Sempre`, `colmi`, `spezza`, `Error`, `Svg`, `RedrawHelix`,
  `GeneraModello`, `Performance`, `PontiAutomatici`;
- configurazione corrente a costanti: soltanto `PontiAutomatici=true`; tutte
  le altre categorie sono `false`, compresa `Sempre`, categoria predefinita;
- `MostraErrore(...)` usa WPF (`Application.Current.MainWindow`, `HelpGPT`,
  `MessageBox`) per presentare il primo errore;
- `LogDisegnoSVG`, `LogIfcPoly` e `LogNtsPolygon` dipendono rispettivamente da
  filesystem/SVGHelper, xBIM e NetTopologySuite;
- il sorgente contiene rami legacy attualmente irraggiungibili: ritorno
  immediato in `IsFileLocked`, `CisonoErrori`, `LogError` dopo la cattura del
  primo errore e `LogDisegnoSVG`. La Library li conserva invariati e non li
  interpreta come comportamento da replicare ciecamente sul server.

### Adattamento headless preservato

- nessun file globale e nessuna dipendenza WPF/UI;
- `InitializeLog()` delega a `Reset()` e crea un buffer nuovo per
  elaborazione;
- `AsyncLocal<List<string>?>` isola i messaggi della richiesta corrente;
- `WriteLog`, `LogOperation` e `LogError` producono rispettivamente prefissi
  `info`, `operation` ed `error` e confluiscono nella diagnostica restituita da
  `GeneraModello`;
- `ProjectStore` persiste il risultato valido in
  `SavedProjects/{projectId}/logs/TermodelLog.md`; l'endpoint
  `GET /api/projects/{projectId}/logs/termodel` legge quel file senza
  rieseguire il calcolo;
- `IsEnabled(...)` resta `false` per i blocchi condizionati di debug. Il
  parametro categoria delle chiamate dirette non filtra il buffer headless:
  questa scelta conserva la diagnostica utile al server e non replica i flag
  compile-time del Desktop;
- il buffer per-request e il publish transazionale sono requisiti server e non
  devono essere sostituiti dalla persistenza globale Desktop.

Conclusione: il riferimento acquisito chiude la lacuna documentale, ma non
giustifica la sostituzione dell'adattatore. L'equivalenza richiesta è di
contratto per i chiamanti, non di filesystem, UI o configurazione diagnostica.

`GeneraPianta` conserva temporaneamente il nome storico `SalvaDXF` per ridurre
il delta con il desktop, ma nel percorso Web non legge né scrive DXF: pubblica
uno SVG `TERMODEL-CLEAN-FLOOR-SVG-V1` per nome piano. Il WebService lo espone
con `GET /api/model/clean-floor/{floorName}`.

## Virtual CAD / DB / Project

Dal 21 settembre 2026 il percorso Web non passa più direttamente un
`DxfDocument` già pronto a un metodo speciale di `LeggiDxf` come via
principale. `GeneraModello` crea un `ProjectWorkspace`, registra il documento
CAD virtuale sotto un percorso DXF materializzato e richiama il metodo storico
`LeggiFileDxf`. `DxfDocument.Load` intercetta quel percorso tramite un
registro scoped alla richiesta.

`SvgDxfReader` crea un documento condiviso per `NomeFile`, quindi conserva la
semantica Desktop "stesso DXF, più piani distinti dai layer". Gli elementi SVG
possono dichiarare anche layer ausiliari tramite `data-termodel-layer`.

Il Virtual DB continua a deserializzare `archives/xml/*.xml` e ora allinea
`GetDataDB`, `TipoZona` e `AggiungiZoneStandard` al comportamento Desktop
rilevante. Gli archivi mancanti restano errori strutturati lato Service.

`ProjectWorkspace` replica inoltre gli XML archivio in `dbtempfiles/`, gli
input termici in `xml/` e i percorsi CAD in `project/`, predisponendo
l'ambiente per la futura integrazione di `GestXml`, `CalcoloAPE` e pannelli.

Verifica di compilazione: GitHub Actions run #2 sul commit
`2753e468c7d1da6b9fb4602152b3fabb0abec17c` completata con 0 errori e
108 warning. Il runtime HTTP dopo questo refactoring non è ancora stato
rieseguito.

## Invarianza Polig3D e JSON v3

Dal 21 settembre 2026
`CopiedFromTermodel/Model/Polig3D.cs` e
`SorgentiTermodel/Library/leggidxf/Polig3D.cs` hanno lo stesso Git blob SHA:

```text
d7d835a8a39febb3c3b26bcb88a8cc5cebb19411
```

Il file è quindi byte-per-byte invariato. Il Core soddisfa le sue dipendenze
tramite `Xbim.Essentials` in memoria e le facciate di
`Compatibility/HeadlessDesktopUi.cs`.

Il renderer `DrawBim` headless produce `TermodelWebModel v3` dal medesimo
`Polig3D.ElementiAssociati` usato dal Desktop e valorizza
`filterMetadata`, `piano`, `confine`, `separatore`, `stessaZona`,
`fittizia` e `falda`. Per le estrusioni conserva inoltre
`ExtrudedVisual3D/lati` e `MeshGeometry3D/tappi`, con `numero` uguale
all'indice 1-based dell'elemento nel redraw.

`Modello.Close_modello` chiama prima `Polig3D.TrovaConfini` e poi
`Polig3D.GrafRedraw`, quindi i metadati sono letti dopo l'elaborazione
semantica dei confini.

Verifica GitHub Actions sul commit
`297d593be6b7e205e3dcb9052d8f6a13cf2878e6`: build Release con 0 errori
(154 warning) e smoke HTTP riuscito per
`/api/projects/new -> /api/model/3d` sul progetto vuoto.

Resta separato il golden test del progetto mansardato da 546 primitive: non
può essere dichiarato confrontato finché non è disponibile il corrispondente
file unico SVG multipiano per il Service.

## Endpoint Modello3D

`POST /api/model/3d` accetta il file unico come `text/plain; charset=utf-8` e
restituisce direttamente `TermodelWebModel` v3 come `application/json`. Il
percorso usa `GeneraModello.GeneraAsync`, protetto da un gate seriale, quindi
carica archivi XML, converte lo SVG nella compatibilità `netDxf` minima ed
esegue `LeggiDxf` e le classi geometriche collegate senza produrre IFC.

Verifica del 21 settembre 2026: build con 0 errori; richiesta con
`ProgettoVuoto` risolta con HTTP 200 e modello valido a 0 primitive; richiesta
con Content-Type errato risolta con HTTP 415. Il golden test del progetto
mansardato resta aperto perché la cartella desktop contiene DXF e il precedente
`TermodelWebModel.json` (546 primitive), ma non ancora lo SVG multipiano nel
file unico richiesto dal nuovo endpoint.
