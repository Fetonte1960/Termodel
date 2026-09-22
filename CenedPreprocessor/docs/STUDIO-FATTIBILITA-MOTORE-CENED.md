# Studio di fattibilità — integrazione CENED+2 Motore headless

Data: 2026-09-22  
Commissione: CENED-0003  
Stato del documento: studio in sola lettura, nessuna implementazione eseguita.

## 1. Scopo

Valutare la possibilità di integrare CENED+2 Motore con Termodel senza dipendere dalla GUI JavaFX, mantenendo il motore proprietario esterno al repository e separando nettamente il codice C# dal processo Java.

Architettura obiettivo preliminare:

```text
Termodel.Core
    ↓
genera / prepara XML CENED
    ↓
Termodel.WebService - orchestrazione
    ↓
processo Java isolato
    ↓
CENED+2 Motore installato/autorizzato
    ↓
XML risultato / report / diagnostica
    ↓
parser C# e artifact normalizzati
```

Questo documento non dichiara che il Motore funzioni headless: tale proprietà potrà essere affermata solo dopo una prova reale.

---

## 2. Evidenze disponibili

### 2.1 Installazione locale comunicata

Sul PC di sviluppo è stata rilevata l'installazione CENED+2:

- prodotto: CenedPlus2;
- versione installata: 1.1.14.10;
- editore: ARIA S.p.A.;
- runtime incluso: OpenJDK 11.0.2 64 bit e JavaFX 11.0.2;
- motore individuato in `lib/cened2-lib-1.1.14-full.jar`;
- libreria applicativa `dev_cenedplus_mockup-1.1.14.jar`;
- licenza `lib/licenza_1114-PROD.jar`.

API dichiarate come rilevate nell'installazione:

`it.finlombarda.cened2.engine.CenedPlus2Engine`

con accesso a:
- istanza del motore;
- servizi;
- evaluation;
- configurazione;
- XML serializzato;
- XML report;
- servizi di trasformazione/interventi migliorativi;
- versione.

L'interfaccia `EvaluationInvocation` espone `execute(javax.xml.transform.Source)`.

Queste informazioni sono considerate **evidenze dell'ispezione locale comunicata**, ma non sono state rieseguite da questa sessione sul filesystem del PC.

### 2.2 Stato ufficiale ARIA corrente

Alla data dello studio ARIA pubblica come versione corrente:
- Client 1.1.15;
- Motore 1.1.15;
- aggiornamento 03/06/2026.

ARIA indica che dal 03/06/2026, ai fini della redazione dell'APE, è necessario utilizzare la versione 1.1.15.

Nell'Area riservata per gli Utenti Motore risultano disponibili:
- Motore di calcolo 1.1.15, pubblicato il 18/05/2026;
- documentazione tecnica aggiornata;
- precedente Motore 1.1.14.

**Decisione di studio:** la 1.1.14 installata è valida per esplorazione e prove preliminari, ma il riferimento della futura integrazione/autorizzazione deve essere il kit ufficiale Motore 1.1.15 e le relative specifiche per Utenti Motore.

---

## 3. Stato Termodel rilevato

Nel repository corrente:

`SorgentiTermodel/Library/output/Cened.cs`

contiene già supporto per:
- riconoscimento di XML CENED;
- estrazione di `calcolo.xml` da pacchetti ZIP;
- copia del file come `inputCened.xml`;
- lettura di pareti/opache;
- lettura serramenti;
- lettura ponti termici;
- lettura subalterni e zone;
- conversione di parte degli archivi CENED verso il formato nazionale;
- ricostruzione/salvataggio di pacchetti CENED.

Namespace esplicitamente usati:
- `http://www.cened.it/cenedplus2/calcolo`;
- `http://www.cened.it/cenedplus2/datiCalcolo`.

Nodi già letti dal codice:
- `d:opache`;
- `d:serramenti`;
- `d:ponti`;
- `d:subalterni/d:subalterno/d:zona`;
- nodi `d:input` e `d:output`;
- `d:ambienti`;
- `d:dispersioni`.

In `GestXml.GeneraXml(...)` la modalità CENED è attualmente disabilitata esplicitamente:

```text
Cened.IsCened = false; // in attesa di certificazione
```

e il salvataggio del pacchetto CENED è anch'esso lasciato disattivato/commentato.

Conclusione: Termodel contiene già una base utile di interoperabilità XML CENED, ma non contiene ancora un adapter runtime verso CENED+2 Motore.

---

## 4. Formato XML di input

### 4.1 Quello che è già dimostrato

Il codice Termodel dimostra l'esistenza e l'uso di un `calcolo.xml` con namespace CENED+2 e una struttura comprendente elementi di involucro, zone, input e output.

ARIA documenta inoltre pubblicamente un flusso per XML prodotti da Client/software di terze parti: il file deve essere costruito secondo le specifiche funzionali fornite alle software house e deve superare il meccanismo di validazione/autenticità previsto da CENED+2 Motore.

### 4.2 Quello che NON è ancora dimostrato

Non è ancora noto, con evidenza sufficiente:
- quale sia il documento XML minimo accettato da `EvaluationInvocation.execute(Source)`;
- quali sezioni possano essere omesse;
- quali campi vengano completati automaticamente dal Motore;
- quali attributi siano obbligatori in funzione delle configurazioni;
- se `execute(Source)` accetti direttamente lo stesso `calcolo.xml` estratto dai pacchetti del Client ufficiale o una variante/contratto differente;
- quali elementi di autenticità/validazione siano necessari per XML di terze parti.

**Regola:** non ricavare il "minimo XML" eliminando campi empiricamente da un file valido. Il riferimento deve essere la specifica tecnica ufficiale corrente più un caso studio noto e una prova reale.

---

## 5. Formato XML di output

Dalle API comunicate risultano almeno tre possibili superfici di uscita:
- risultato di `EvaluationInvocation.execute(Source)`;
- `CenedPlus2Engine.getXmlSerialized()`;
- `CenedPlus2Engine.getXmlReport()`;
- oggetto modello `it.finlombarda.cened2.engine.xml.Calcolo`.

Non è ancora verificato:
- quale output rappresenti il documento calcolato completo;
- quale rappresenti il file destinabile al CEER;
- quale contenga il report;
- se gli output dipendano da una configurazione specifica;
- se siano prodotti file accessori o CSV;
- se vi siano differenze tra XML di calcolo, XML serializzato e XML di deposito CEER.

La prima prova reale dovrà conservare separatamente tutti questi output, senza normalizzarli prematuramente.

---

## 6. Dipendenze del Motore

### 6.1 Dipendenze certe o direttamente indicate

- Java 11 nell'installazione 1.1.14;
- API XML/JAXP Java (`javax.xml.transform.Source`);
- libreria motore proprietaria CENED+2;
- presenza di integrazione Spring, evidenziata dall'overload `getInstance(ApplicationContext)`;
- presenza nell'installazione di un JAR licenza;
- presenza di un mockup applicativo;
- JavaFX richiesto dalla GUI ufficiale.

### 6.2 Dipendenze NON ancora inventariate

Non è disponibile in questo studio un accesso diretto al filesystem Windows, quindi non è possibile certificare:
- elenco completo dei JAR caricati dal Motore;
- dipendenze transitive;
- risorse Spring;
- file properties;
- database/archivi incorporati o esterni;
- dipendenze native;
- uso effettivo o meno di JavaFX da parte del solo Motore.

L'inventario deve essere fatto **in sola lettura** sulla distribuzione ufficiale Motore, preferibilmente 1.1.15, senza copiare i JAR nel repository.

### 6.3 Inventario read-only da produrre sul PC

Output da acquisire in un file di studio:
- elenco ricorsivo dei file del kit Motore;
- hash SHA-256 dei JAR;
- `META-INF/MANIFEST.MF`;
- eventuale `Class-Path` dichiarato;
- elenco delle risorse `META-INF/spring*`;
- file `applicationContext*.xml`, `*context*.xml`, `*.properties`, `*.yml`, `*.yaml`;
- risorse XSD;
- eventuali file di logging;
- eventuali librerie native.

Questa attività è ispezione di packaging e configurazione, non decompilazione del motore.

---

## 7. Configurazione Spring

La presenza di:
- `getInstance()`;
- `getInstance(String)`;
- `getInstance(ApplicationContext)`;

indica più modalità di inizializzazione, ma il significato dell'overload String e i bean richiesti non sono ancora documentati nello studio.

### Strategia raccomandata

Per il primo runner:
1. non costruire manualmente un ApplicationContext;
2. tentare esclusivamente la modalità pubblica più semplice documentata dalle specifiche ARIA, presumibilmente l'inizializzazione autonoma del Motore;
3. usare la configurazione Spring installata/distribuita con il kit Motore;
4. ricorrere all'iniezione di un `ApplicationContext` soltanto se le specifiche ufficiali lo richiedono.

Motivo: ricostruire manualmente il grafo Spring renderebbe il Bridge dipendente da dettagli interni e aumenterebbe drasticamente il rischio di rottura a ogni release.

---

## 8. Runner Java headless minimo

### 8.1 Obiettivo

Creare in una commissione successiva un piccolo eseguibile Java indipendente, senza GUI, che abbia un solo compito:

```text
input XML + configurazione
       ↓
CENED+2 Motore
       ↓
raw output XML + report + log + exit code
```

### 8.2 Confine del runner

Il runner non deve:
- contenere logica termotecnica Termodel;
- modificare il modello Termodel;
- contenere una copia dei JAR CENED;
- contenere credenziali/licenze;
- emulare o riscrivere CENED+2 Motore;
- dipendere da JavaFX se il Motore non lo richiede.

Deve:
- ricevere il percorso del file XML;
- ricevere il percorso esterno dell'installazione/kit CENED;
- inizializzare il Motore secondo specifica ufficiale;
- eseguire una singola valutazione;
- scrivere output grezzi in una directory di lavoro;
- riportare errori, stack trace controllato e codice di uscita;
- terminare.

### 8.3 Scelta di isolamento iniziale

Per la prima implementazione si raccomanda **un processo JVM per ogni elaborazione CENED**, non un singleton Java residente.

Motivi:
- `CenedPlus2Engine.getInstance()` suggerisce stato globale/singleton;
- thread safety non dimostrata;
- eventuali cache, configurazioni e archivi condivisi non sono ancora noti;
- un crash o leak Java non deve compromettere il WebService;
- timeout e kill del processo sono più semplici da gestire;
- isolamento fra progetti è più verificabile.

Una JVM persistente/pool potrà essere valutata soltanto dopo test di concorrenza e stato globale.

---

## 9. Working directory e stato utente

Il Client ufficiale CENED+2 utilizza storicamente cartelle del profilo utente come `.cened2` e `.cened2C` per edifici e archivi.

Questo introduce un rischio importante: anche eseguendo un processo per calcolo, il Motore potrebbe accedere a stato condiviso nel profilo Windows.

Prima di parlare di vera esecuzione server/headless occorre verificare:
- quali directory usa il solo Motore;
- se gli archivi sono read-only durante il calcolo;
- se vengono scritti file nel profilo;
- se il working directory influenza il caricamento risorse;
- se è supportata ufficialmente una directory dati configurabile;
- comportamento con due processi simultanei.

Non forzare `user.home` o spostare cartelle CENED senza prova e senza supporto documentale.

---

## 10. Timeout, concorrenza e robustezza

Configurazioni iniziali consigliate per un futuro prototipo:
- timeout esterno configurabile dal WebService;
- cattura separata di stdout e stderr;
- kill dell'intero process tree in caso di timeout;
- workspace separato per `projectId`;
- nessun output parziale pubblicato come artifact valido;
- conservazione del raw input e raw output associati alla versione del Motore;
- serializzazione temporanea delle elaborazioni CENED finché la thread/process safety non viene dimostrata.

Il valore del timeout non va fissato ora: deve derivare dai tempi misurati sui casi studio.

---

## 11. Licenza e condizioni d'uso

Le condizioni pubbliche ARIA stabiliscono che:
- CENED+2 Motore è proprietà intellettuale dell'O.d.A.;
- è prevista l'integrazione con Client di terze parti;
- l'utilizzo da parte di terzi è subordinato all'autorizzazione dell'O.d.A.;
- il Client deve essere conforme alle specifiche tecniche;
- l'autorizzazione richiede l'invio del software sviluppato e delle istruzioni di installazione;
- le major release richiedono nuova autodichiarazione;
- gli aggiornamenti delle specifiche vengono resi disponibili agli Utenti Motore.

### Conseguenze per Termodel

Consentito come direzione di progetto:
- sviluppare un Client/Bridge separato;
- integrare il Motore secondo le specifiche ARIA;
- mantenere i JAR come dipendenza esterna installata/autorizzata.

Da NON assumere senza conferma ARIA:
- diritto di redistribuire i JAR proprietari;
- diritto di redistribuire il JAR licenza;
- possibilità di incorporare il Motore in container/cloud pubblici;
- possibilità di offrire un Motore centralizzato multiutente/SaaS;
- possibilità di spostare liberamente componenti del Client ufficiale in un server.

La documentazione pubblica conferma l'integrazione con Client di terzi, ma non è sufficiente da sola per concludere che sia autorizzato un deployment SaaS remoto centralizzato.

Per questo motivo la prima architettura autorizzabile deve essere compatibile con **Motore installato localmente**. L'eventuale uso remoto/server dovrà essere chiarito per iscritto con ARIA/O.d.A.

---

## 12. Versione 1.1.14 vs 1.1.15

La presenza della 1.1.14 sul PC non invalida lo studio.

Uso corretto:
- 1.1.14: esplorazione read-only, prova concettuale delle API e comprensione dei vecchi progetti CENED;
- 1.1.15: riferimento per nuove prove di conformità, runner destinato al prodotto e futura autorizzazione.

Non progettare contratti permanenti su nomi di file versionati come `cened2-lib-1.1.14-full.jar`.

La configurazione futura dovrà individuare/versionare il kit Motore esterno e rifiutare versioni non supportate.

---

## 13. Modifiche minime future a Termodel.Core / WebService

### Termodel.Core

Modifiche minime raccomandate:
- componente puro che produce il documento CENED di input a partire dal modello Termodel;
- validatore strutturale lato Termodel, senza duplicare le regole proprietarie del Motore;
- parser dei raw output CENED in DTO/artifact neutrali;
- nessun riferimento diretto a Java, Process o JAR proprietari.

### Termodel.WebService

Modifiche minime raccomandate:
- configurazione esterna del percorso del Motore/Java;
- servizio infrastrutturale `CenedEngineRunner` che avvia il processo Java;
- workspace per projectId;
- timeout/cancellation;
- acquisizione stdout/stderr/log;
- pubblicazione atomica degli artifact solo a elaborazione riuscita;
- endpoint/artifact CENED da aggiungere soltanto dopo il prototipo validato.

### Runner Java

Nuovo componente separato:
- sorgente nostro, versionabile;
- nessun JAR ARIA nel repository;
- compilazione contro il kit locale/autorizzato;
- output semplice e stabile verso il WebService.

Questa separazione evita di contaminare Termodel.Core con dipendenze proprietarie e conserva la possibilità di sostituire/aggiornare il Motore.

---

## 14. Valutazione di fattibilità

### Tecnica

**Fattibilità alta**, perché:
- ARIA progetta esplicitamente CENED+2 Motore per l'integrazione con Client di terze parti;
- l'installazione comunicata espone API Java di valutazione XML;
- Termodel possiede già una base di lettura/conversione XML CENED;
- un boundary di processo Java è naturale fra .NET e Java.

### Punti ancora bloccanti prima dell'implementazione

1. acquisire la documentazione tecnica ufficiale corrente per Utente Motore;
2. ottenere/identificare il kit Motore 1.1.15;
3. inventariare packaging e configurazione in sola lettura;
4. scegliere un XML CENED 1.1.15 noto e valido come Golden Input;
5. verificare l'esatta inizializzazione Spring documentata;
6. eseguire una prima valutazione reale fuori dal WebService;
7. confrontare input/output con CENED+2 Client;
8. chiarire con ARIA il perimetro locale/server/cloud;
9. solo dopo progettare l'integrazione nel Service.

---

## 15. Prima prova raccomandata — NON eseguita

La prima prova successiva deve essere intenzionalmente minimale:

```text
XML CENED 1.1.15 noto e valido
        ↓
runner Java standalone
        ↓
una sola chiamata EvaluationInvocation
        ↓
raw XML restituito
+ getXmlSerialized
+ getXmlReport
+ stdout/stderr
+ exit code
        ↓
confronto con lo stesso caso eseguito nel Client ufficiale
```

Criterio di successo della prova:
- nessuna finestra JavaFX aperta;
- processo terminato autonomamente;
- risultato ripetibile;
- output interpretabile;
- nessuna modifica al Client ufficiale;
- nessun JAR copiato nel repository.

Solo a quel punto il Motore potrà essere definito **utilizzabile headless nel nostro scenario**.

---

## 16. Fonti ufficiali consultate

- ARIA/CENED, pagina Software CENED+2.0, versione corrente 1.1.15.
- ARIA/CENED, Autorizzazione all'uso di CENED+2 Motore.
- ARIA/CENED, Area riservata - Specifiche tecniche per Utenti Motore.
- ARIA/CENED, Importazione file XML di terze parti in CENED+2.0.
- ARIA/CENED, Condizioni d'uso e modalità di adesione ai servizi CENED.
- Repository Termodel: `SorgentiTermodel/Library/output/Cened.cs`.
- Repository Termodel: `SorgentiTermodel/Library/GestXml.cs`.
- Repository Termodel: `Server/Termodelwebservice/PROJECT-SUMMARY-SERVICE.md`.

## 17. Esito

Lo studio non evidenzia ostacoli architetturali che rendano irrealistica l'integrazione.

La soluzione raccomandata è:

**Core C# puro → WebService orchestratore → runner Java isolato → kit ufficiale CENED+2 Motore esterno.**

Il prossimo passo non è modificare il Service: è acquisire il kit/spec 1.1.15 e produrre l'inventario read-only, quindi autorizzare eventualmente un runner Java standalone di prova.
