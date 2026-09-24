# TermodelService — Debug avanzato con GitHub Actions

Data introduzione: 2026-09-23

> **IMPORTANTE — notifica di fine incarico**
>
> Ogni debug avanzato eseguito con GitHub Actions deve applicare
> `.github/TERMODEL-ACTION-NOTIFICATIONS.md`: stato `RUNNING` all'avvio e
> `SUCCESS`/`FAILED` alla fine, con una notifica push sul telefono nello
> stato terminale. Non usare polling per attendere il completamento.

Questa procedura è il metodo permanente da usare quando un problema del
TermodelService non può essere risolto in modo affidabile con la sola lettura
statica del codice.

## 1. Obiettivo

Usare GitHub Actions come ambiente temporaneo reale di compilazione ed
esecuzione del Service, riprodurre il problema su un progetto concreto,
raccogliere i file prodotti e ripetere il ciclo diagnostico fino alla
correzione oppure fino all'identificazione di un impedimento concreto.

La procedura non sostituisce Visual Studio sul PC dell'utente come verifica
finale locale, ma consente alla chat AI di compilare, eseguire e diagnosticare
il Service senza dipendere da Render.

## 2. Informazioni iniziali

Quando viene richiesto un "debug avanzato":

1. se la natura del problema non è già chiara dalla conversazione, chiedere
   quale comportamento è errato e quale comportamento è atteso;
2. se per riprodurre il problema serve un progetto reale e non è già
   disponibile, chiedere all'utente il progetto
   `TERMODEL-PROJECT-TEXT-V1`;
3. usare le informazioni già presenti nella conversazione senza richiederle
   nuovamente;
4. prima di intervenire leggere il Summary Service e verificare i commit
   recenti, come previsto dalle regole generali del progetto.

Se il progetto contiene dati riservati, non inserirlo stabilmente nel branch
`main` di un repository pubblico. Usare, a seconda del caso, un campione
ridotto/sanitizzato, uno snapshot diagnostico già autorizzato o un supporto
temporaneo dedicato.

## 3. Ciclo operativo

Il ciclo standard è:

```text
problema reale
    ↓
progetto di riproduzione
    ↓
strumentazione diagnostica necessaria
    ↓
GitHub Actions
    ↓
build del Service
    ↓
avvio del Service nel runner
    ↓
invio del progetto all'API reale
    ↓
raccolta response + artifact + log
    ↓
analisi
    ↓
correzione / nuova ipotesi
    ↓
nuova GitHub Action
```

Ripetere il ciclo fino a:

- problema risolto e verificato;
- oppure impossibilità concreta di proseguire, da descrivere precisamente.

Non interrompere il lavoro dopo la prima ipotesi se gli output dell'Action
consentono ulteriori verifiche.

## 4. Branch diagnostico

Quando il debug richiede file, script o log temporanei, preferire un branch
diagnostico separato da `main`.

Il branch può contenere:

- fixture di test non sensibili;
- script di invocazione del Service;
- workflow temporaneo;
- log aggiuntivi;
- dump diagnostici;
- raccolta di artifact del runner.

Le modifiche temporanee non devono essere confuse con la correzione finale.

## 5. Log e strumentazione speciale

Durante il debug è consentito aggiungere strumentazione specifica per il
problema corrente, per esempio:

- log prima/dopo una trasformazione;
- conteggi di entità;
- coordinate e bounding box;
- hash dei file;
- parametri ricevuti dall'API;
- elenco delle sezioni del progetto;
- file intermedi;
- eccezioni complete;
- confronto fra input e output;
- marker diagnostici univoci.

Questa strumentazione deve essere:

1. mirata al problema;
2. chiaramente riconoscibile come diagnostica temporanea;
3. rimossa al termine, salvo che venga deliberato di conservarla come log
   generale del prodotto.

Non lasciare nel prodotto dump verbosi, fixture private o log diagnostici
occasionali.

## 6. File di ritorno da raccogliere

Quando utili, l'Action deve restituire o rendere ispezionabili almeno:

- risposta HTTP del calcolo;
- status code e headers rilevanti;
- `generated-files`;
- `artifacts/model3d.json`;
- `artifacts/pannelli.json`;
- `artifacts/pannelli-esecutivo.svg`;
- `artifacts/pannelli-esecutivo.dxf`;
- `logs/TermodelLog.md`;
- `logs/diagnostics.txt`;
- `logs/calculation.log`;
- stdout/stderr del Service;
- eventuali file intermedi aggiunti appositamente per il debug.

Il set effettivo dipende dal problema e non deve essere limitato a questa
lista.

## 7. Analisi

L'analisi deve confrontare, quando possibile:

- input originale;
- file materializzato dal Service;
- output del Core;
- artifact finale;
- comportamento atteso Desktop o contratto Front↔Service.

Separare sempre:

```text
progettato
implementato
compilato
eseguito
testato
confrontato con riferimento
```

Una build riuscita non equivale a problema risolto.

## 8. Chiusura del debug

Prima di dichiarare concluso il debug:

1. ottenere una GitHub Action riuscita sul caso che prima falliva;
2. verificare gli artifact/log rilevanti;
3. rimuovere log, dump, fixture e workflow temporanei non più necessari;
4. mantenere solo la correzione definitiva e gli eventuali regression test
   utili;
5. aggiornare `PROJECT-SUMMARY-SERVICE.md`;
6. indicare commit finali e verifiche realmente eseguite;
7. se opportuno, far ripetere all'utente la verifica in Visual Studio.

Se il problema non può essere risolto, documentare il punto esatto in cui il
processo si blocca, quali prove sono state eseguite e quale informazione o
dipendenza manca.

## 9. Vincoli permanenti

- non modificare `definizionedati.json` senza autorizzazione esplicita;
- non modificare la Library Desktop come scorciatoia diagnostica;
- non modificare il frontend salvo che il problema riguardi realmente il
  frontend o il contratto;
- non introdurre formati progetto alternativi;
- non usare Render quando GitHub Actions è sufficiente per riprodurre il
  problema;
- non dichiarare risolto un problema senza un test che riproduca il caso
  reale o un equivalente controllato.
