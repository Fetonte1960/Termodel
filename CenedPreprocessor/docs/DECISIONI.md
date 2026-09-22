# Storico decisioni — Termodel Cened

Questo file registra le decisioni architetturali e di prodotto consolidate. Non sostituisce il registro commissioni.

## 2026-09-22 — D-0001 — Prodotto autonomo

Il preprocessore Cened ha identità propria. Termodel è una possibile sorgente dati ma non fa parte del perimetro iniziale di certificazione.

## 2026-09-22 — D-0002 — Due implementazioni parallele

Si sviluppano:
- WebJS online su termodel.it;
- Desktop destinata alla certificazione.

Le due versioni devono condividere specifica semantica, casi prova e Golden Results.

## 2026-09-22 — D-0003 — Modello intermedio

Il preprocessore deve ricevere un modello termico strutturato e indipendente dalla UI. Il mapping verso Cened deve essere documentato nella specifica comune.

## 2026-09-22 — D-0004 — Versionamento visibile

Ogni versione software deve avere un identificativo incrementale e tale versione deve essere visibile nelle caption/interfacce delle applicazioni.

## 2026-09-22 — D-0005 — Tracciabilità

Ogni incarico viene registrato come COMMISSIONATO prima del lavoro e trasformato in ESEGUITO solo dopo verifica. Le decisioni architetturali vengono registrate in questo storico.

## 2026-09-22 — D-0006 — Identità del prodotto: Software Bridge / Client CENED+2

Il prodotto viene presentato funzionalmente come **software bridge** tra formati standard di modelli termici e CENED+2 Motore.

Dal punto di vista delle regole ARIA/CENED, quando integra e utilizza CENED+2 Motore il prodotto ricade nella categoria di **Client di terze parti integrato con CENED+2 Motore** e deve rispettare le specifiche tecniche e il percorso di autorizzazione previsto dall'O.d.A.

Flusso di prodotto consolidato:

```text
formati standard di modelli termici
        ↓
importazione / normalizzazione
        ↓
modello intermedio del Bridge
        ↓
presentazione e verifica dei dati
        ↓
CENED+2 Motore
        ↓
calcolo
        ↓
XML conforme per CEER
        ↓
anteprima APE non ufficiale
```

L'interfaccia può organizzare i dati secondo una logica funzionale vicina alle sezioni necessarie a CENED+2, ma deve avere una grafica originale: non viene adottata la riproduzione dell'interfaccia grafica del CENED+2 Client.

L'anteprima APE prodotta dal Bridge è uno strumento di controllo e stampa preliminare e deve essere chiaramente distinta dall'APE ufficiale prodotto/depositato attraverso il CEER.

## 2026-09-22 — D-0007 — Comunicazione commerciale prima dell'autorizzazione

Prima del rilascio dell'autorizzazione ARIA/O.d.A. il prodotto può essere descritto come **progettato per l'integrazione con CENED+2 Motore** o **in fase di autorizzazione** quando tale fase sarà effettivamente avviata.

Non deve essere presentato come Client CENED+2 autorizzato/accreditato né come integrazione già autorizzata fino al rilascio formale dell'autorizzazione.


## 2026-09-22 — D-0008 — Fase attiva esclusivamente WebJS

Da questa data il progetto entra in una fase di sviluppo e discussione **esclusivamente WebJS**.

Regole:
- `src/WebJS/` è l'unica implementazione attiva;
- `src/Desktop/` resta sospesa e non deve essere modificata o sviluppata fino a nuova decisione esplicita;
- il percorso Desktop/certificazione resta documentato come obiettivo futuro, ma non guida le attività implementative correnti;
- specifiche, modelli dati, riferimenti CENED, test e Golden Results devono essere progettati in modo riutilizzabile, senza obbligare a implementare contemporaneamente una versione Desktop;
- nessuna integrazione operativa con runner Java, Termodel.Core o Termodel.WebService viene avviata nell'ambito di questa fase salvo nuova autorizzazione esplicita;
- la WebJS è usata come ambiente di studio, prototipazione, verifica dell'interfaccia, discussione del mapping dati e consolidamento del prodotto.

Questa decisione sospende operativamente la precedente D-0002 relativa allo sviluppo parallelo di WebJS e Desktop, senza cancellarla dallo storico.


## 2026-09-22 — D-0009 — XML Blumatica come Golden Reference nazionale

Il file XML `output.xml` fornito dall'utente e dichiarato importato con successo in Blumatica viene assunto come **Golden Reference strutturale** dell'XML nazionale/interoperabile che la WebJS dovrà essere in grado di produrre.

Regole:
- identificativo del riferimento: `BLUMATICA-XML-001`;
- il file originale è identificato dal digest SHA-256 `4988a0700ad1aeb60ef6906235411a176baee514f7a902533dfcc1ad86980647`;
- il file grezzo non viene pubblicato nel repository perché contiene dati personali reali e il repository è pubblico;
- il riferimento viene usato per struttura, gerarchie, mapping e test di serializzazione dell'output XML WebJS;
- il fatto che Blumatica lo importi non dimostra automaticamente conformità con CENED+2 Motore;
- ogni futura copia anonimizzata o modificata non può essere chiamata "testata con Blumatica" finché non venga nuovamente verificata con un'importazione reale.


## 2026-09-22 — D-0010 — GestXml Termodel come riferimento non vincolante

Il sorgente Termodel `SorgentiTermodel/Library/GestXml.cs`, identificato nello snapshot fornito dall'utente con SHA-256 `906cde73c919fa90359daae0df0c00a1a088e318e3c2b9130b293ab1e51c0736`, viene acquisito come **fonte di ispirazione tecnica** per la WebJS.

Non è una specifica normativa né un vincolo implementativo.

Ordine di autorità:
1. specifiche ufficiali ARIA/formato ufficiale;
2. Golden Reference validati;
3. specifica propria del Software Bridge;
4. `GestXml.cs` come riferimento concettuale.

Sono riutilizzabili concettualmente gerarchie, mapping, classificazione dei confini, calcoli geometrici e principi di serializzazione. Non devono essere trasferiti automaticamente coupling Desktop/WPF/Xbim, stato globale, valori hard-coded, fallback o formule non verificate.


## 2026-09-22 — D-0011 — Anteprima APE Blumatica come Golden Reference di presentazione

Il documento RTF fornito dall'utente e prodotto da Blumatica viene assunto come **Golden Reference di presentazione e contenuto** per la futura funzione WebJS di anteprima APE.

Identificativo: `BLUMATICA-APE-PREVIEW-001`.

SHA-256 del file originale: `59e0300d1210a92cd31d5fe4e1e730797fa6d9ff0df6aabb61b41872de982e5f`.

Regole:
- usare il documento per sezioni, ordine logico, completezza e leggibilità;
- non copiarne automaticamente grafica, loghi, font o impaginazione proprietaria;
- la futura stampa WebJS deve essere chiaramente marcata come **ANTEPRIMA APE — NON UFFICIALE**;
- il file originale non viene pubblicato nel repository pubblico perché contiene dati personali;
- l'anteprima deve derivare dallo stesso modello dati normalizzato usato per l'XML, evitando mapping duplicati e divergenti.


## 2026-09-22 — D-0012 — Ingresso duale obbligatorio: gbXML + XML nazionale

Il Software Bridge adotta come contratto di ingresso una **coppia di file complementari**:

1. **gbXML** — fonte primaria del modello geometrico/termico;
2. **XML nazionale** — fonte complementare per i dati non presenti o non sufficientemente rappresentati nel gbXML.

Flusso consolidato:

```text
gbXML
  ├─ geometria
  ├─ spazi
  ├─ superfici
  ├─ aperture
  ├─ orientamenti
  ├─ relazioni termiche
  └─ geometrie/ostruzioni di ombreggiamento quando disponibili
        \
         \ 
          > IMPORT + CONTROLLO DI COERENZA
         /
        /
XML nazionale
  ├─ dati generali/APE
  ├─ dati italiani specifici
  ├─ archivi/codifiche non presenti nel gbXML
  ├─ dati impianti o altri dati mancanti
  └─ risultati già disponibili, usati solo come confronto
        ↓
MODELLO INTERMEDIO UNICO DEL BRIDGE
        ↓
validazione / diagnostica
        ↓
futuro mapping CENED
```

### Autorità dei dati

- **Geometria e cause fisiche:** prevale il gbXML.
- **Dati specifici nazionali/APE e campi non rappresentati dal gbXML:** prevale l'XML nazionale.
- **Dati duplicati:** il Bridge confronta i valori; una discordanza significativa viene segnalata e non corretta silenziosamente.
- **Risultati energetici dell'XML nazionale:** sono dati di confronto e non possono sostituire informazioni causali mancanti, ad esempio la geometria di un aggetto con un semplice fattore mensile di ombreggiamento.

### Principio di funzionamento

Il Bridge è un componente di **fusione, normalizzazione e controllo**, non un editor del modello tecnico.

Le correzioni devono essere eseguite nel software sorgente che ha prodotto uno dei due file e poi riesportate.

Questa decisione supera l'idea di usare l'XML nazionale come input unico: l'XML nazionale rimane indispensabile, ma viene affiancato dal gbXML per conservare il modello fisico necessario alle trasformazioni successive.


## 2026-09-22 — D-0013 — Formati pubblici riconosciuti separati per dominio

Il Software Bridge adotta come principio di interoperabilità l'uso di **formati pubblici, documentati e riconosciuti**, mantenuti separati quando descrivono domini differenti.

Il Bridge non introduce un unico formato proprietario esterno destinato a sostituire gli standard esistenti.

Applicazione iniziale:
- `gbXML` per il modello geometrico/termico fisico;
- XML nazionale per i dati specifici nazionali/APE e per integrare quanto non rappresentato dal gbXML.

Principi:
- ogni formato importato deve avere schema/versione/provenienza identificabili;
- ogni adapter deve documentare il mapping verso il modello intermedio;
- i file restano separati fino alla fase di import/fusione;
- la fusione avviene solo nel modello interno del Bridge;
- il modello intermedio può avere una struttura proprietaria interna, ma non viene imposto come formato di scambio esterno;
- nuovi formati pubblici riconosciuti potranno essere aggiunti in futuro tramite adapter dedicati senza cambiare l'architettura generale;
- la presenza di più formati non autorizza correzioni silenziose delle incongruenze tra sorgenti.


## 2026-09-22 — D-0014 — Gate di fattibilità sugli ombreggiamenti geometrici

Lo studio di fattibilità del Bridge non può considerarsi sufficiente usando soltanto geometrie edilizie semplici.

Viene introdotto il caso `GBXML-SHADING-001` come gate specifico per verificare che il formato pubblico gbXML e il futuro adapter del Bridge conservino le **cause geometriche dell'ombreggiamento**.

Il caso deve comprendere almeno:
- balcone/aggetto orizzontale;
- setti/aggetti verticali;
- ostruzione esterna remota, ad esempio un edificio di fronte.

Gli elementi vengono rappresentati con superfici gbXML di tipo `Shade`, coerentemente con lo schema e con i test pubblici ASHRAE/gbXML per balconi e overhang.

La fattibilità sarà considerata dimostrata sul dominio ombreggiamenti soltanto quando il parser sarà in grado di:
- leggere senza perdita la geometria;
- associare le superfici ombreggianti alle aperture/facciate interessate;
- distinguere aggetti orizzontali, setti verticali e ostacoli remoti;
- estrarre distanze, profondità e quote necessarie al mapping CENED.

Non è sufficiente leggere un fattore di ombreggiamento già calcolato dall'XML nazionale.


## 2026-09-22 — D-0015 — Viewer 3D read-only come strumento di validazione

La WebJS integra un viewer 3D derivato selettivamente dal renderer Three.js di Termodel Web.

Il viewer ha funzione esclusivamente di **controllo e validazione** del modello importato e non modifica il principio di Bridge puro.

Regole:
- nessun CAD o editing geometrico;
- nessuno snap o comando di disegno;
- geometria 3D esclusivamente dal gbXML;
- l'XML nazionale non viene usato per inventare coordinate, forme o ostruzioni mancanti;
- superfici `Shade` visualizzate e classificabili come aggetti/balconi, setti verticali o ostruzioni remote;
- selezione degli oggetti con visualizzazione di proprietà, associazioni e provenienza;
- import gbXML e import XML nazionale sono indipendenti e non si sovrascrivono;
- il viewer serve anche come gate umano per verificare che il parser abbia interpretato correttamente le cause geometriche dell'ombreggiamento.

Il riuso da Termodel Web è limitato ai concetti generici del renderer browser: Three.js, OrbitControls, camera, fit scena, spigoli e raycasting.


## 2026-09-22 — D-0016 — Fixture di prova consolidate e autocaricate

La WebJS deve essere immediatamente verificabile senza richiedere all'utente di ricaricare ogni volta i file di prova.

Vengono quindi consolidate due fixture runtime:
- `GBXML-SHADING-001.xml` come sorgente geometrica;
- `BLUMATICA-XML-001-SANITIZED.xml` come sorgente nazionale complementare.

La fixture XML nazionale è derivata dal Golden Reference BLUMATICA-XML-001 ma **non è il file originale**:
- i dati personali/identificativi sono rimossi o sostituiti;
- i valori tecnici e i conteggi necessari ai test sono preservati;
- lo stato resta `DERIVATO-NON-VALIDATO` finché non venga sottoposta a una nuova validazione esterna.

All'avvio della modalità prova la WebJS carica automaticamente entrambe le fixture e apre il Viewer 3D.

Gli import manuali restano disponibili per sostituire una singola sorgente durante prove specifiche.
