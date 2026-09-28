# ISTRUZIONI DEBUG — Termodel Service

Documento operativo permanente per le attività di diagnostica del progetto
`Fetonte1960/Termodel`.

Questo documento non sostituisce:
- `PROJECT-SUMMARY-SERVICE.md`;
- `docs/RECOVERY-ACTIVE.md`, quando esiste una lavorazione sospesa o riprendibile;
- `docs/LOCAL-RADIANT-HARNESS.md`;
- `docs/ADVANCED-GITHUB-ACTIONS-DEBUG.md`.

Serve a registrare setup di debug riutilizzabili con una chiave stabile.

---

## Debug_Avanzato_harness_rapido

### Scopo

Usare l'Harness rapido come equivalente remoto e ripetibile di una sessione
Visual Studio con breakpoint, Watch e Locals, evitando di introdurre sistemi
diagnostici paralleli quando esiste già `TermodelLog`.

Il metodo deve permettere di:
- eseguire un caso reale o una fixture strettamente derivata dal reale;
- abilitare soltanto la diagnostica necessaria;
- raccogliere il log nello stesso ciclo Harness;
- esaminare il log dopo ogni elaborazione;
- aggiungere esclusivamente i punti di log mancanti;
- rieseguire fino a individuare il primo evento causale verificabile.

### Principio fondamentale

**Non creare un secondo logger se `TermodelLog` è sufficiente.**

La diagnostica deve essere:
- permanente quando descrive variabili o decisioni utili anche in futuro;
- parametrizzata per categoria;
- normalmente disattivabile;
- non invasiva;
- priva di effetti sulla geometria, sulle tolleranze e sui criteri di
  accettazione;
- riutilizzabile da Service, Harness e GitHub Actions.

### Logger autorevole

Nel Service/Core usare:

`Termodel.utilities.TermodelLog`

Le categorie sono controllate dal contratto generale già esistente:

```http
POST /api/calculations?logEnabled=true&logCategories=<categorie>
```

Parametri:
- `logEnabled=true|false`;
- `logCategories=all`;
- `logCategories=none`;
- `logCategories=Categoria1,Categoria2,...`.

Il debug avanzato non deve bypassare questi parametri con meccanismi paralleli.

### Categoria Diego_Vittorio

Per il motore spirali `Diego_Vittorio` la categoria permanente Service/Core è:

```text
SpiraliDiegoVittorio
```

È un'estensione dell'adattatore headless e non modifica
`SorgentiTermodel/Library/utilities/TermodelLog.cs`.

La categoria è stata introdotta per consentire la diagnostica fine del motore
senza lasciare attivi log pesanti durante il funzionamento normale.

### Sottotag stabili

All'interno della categoria `SpiraliDiegoVittorio` usare sottotag stabili,
anziché creare una categoria pubblica per ogni singola variabile.

Esempi correnti:

```text
Supply.Context
Supply.Generate.Begin

Supply.Offset.Begin
Supply.Offset.Candidate
Supply.Offset.Accept
Supply.Offset.Stop

Supply.ComputeOffset.Edge
Supply.ComputeOffset.Vertex
Supply.ComputeOffset.Result
Supply.ComputeOffset.Raw

Supply.Traverse.Connection
Supply.Traverse.Candidate
Supply.Traverse.Accept
Supply.Traverse.End

Supply.Finalize.Plan
Supply.Finalize.Result

Supply.Result
```

Nuovi sottotag devono essere:
- descrittivi;
- stabili;
- legati a una fase algoritmica precisa;
- aggiunti solo quando il dato richiesto non è già disponibile nel log.

### Harness rapido

Il comando `run` dell'Harness accetta gli equivalenti locali:

```text
--log-enabled true|false
--log-categories <categoria1,categoria2|all|none>
```

Esempio mirato sul caso `locale_1`:

```powershell
dotnet run --project tools/Termodel.RadiantPanels.Harness/Termodel.RadiantPanels.Harness.csproj -c Release -- run \
  --input tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml \
  --locale locale_1 \
  --engine Diego_Vittorio \
  --p 0.30 \
  --supply-only \
  --log-enabled true \
  --log-categories SpiraliDiegoVittorio \
  --out <cartella-output>
```

Il risultato principale dell'analisi è:

```text
<case-id>.log.txt
```

Il file può contenere sia diagnostica storica ancora presente sia i messaggi
strutturati provenienti da `TermodelLog.Messages`.

### Ciclo operativo obbligatorio

Per un problema complesso procedere così:

1. scegliere **un solo caso**;
2. definire il punto esatto dell'algoritmo che si vuole comprendere;
3. abilitare soltanto la categoria necessaria;
4. eseguire l'Harness;
5. leggere il log prodotto;
6. ricostruire la sequenza reale delle decisioni;
7. verificare se i dati presenti sono sufficienti;
8. se manca un dato, aggiungere **solo** il punto di log necessario;
9. rieseguire lo stesso caso;
10. ripetere fino a identificare il primo evento causale;
11. solo dopo proporre una modifica algoritmica;
12. qualunque correzione deve avere regression dedicata e non rompere i casi
    già consolidati.

### Regola: prima osservare, poi modificare

Durante la fase diagnostica:
- non rilassare tolleranze;
- non bypassare controlli;
- non modificare la strategia;
- non cambiare il risultato solo per vedere "se funziona";
- non usare altri locali per compensare l'incertezza sul caso corrente.

È consentito aggiungere log che leggono:
- coordinate;
- distanze;
- indici;
- vertici;
- flag booleani;
- risultati intermedi;
- cause di rifiuto;
- stato prima/dopo una funzione.

I log non devono modificare lo stato osservato.

### Regola: niente log enorme senza necessità

Il log avanzato deve essere molto ricco **solo nella categoria esplicitamente
attivata**.

In produzione o nei test ordinari la categoria può restare spenta.

Se un singolo blocco produce troppe righe:
- mantenere il punto di log permanente;
- renderlo dipendente dalla categoria;
- preferire sottotag filtrabili;
- evitare dump globali dell'intero progetto se bastano pochi dati locali.

### Relazione con GitHub Actions

GitHub Actions serve per:
- compilare il vero Core/Harness;
- eseguire il caso in ambiente ripetibile;
- produrre log e artifact;
- verificare le regression;
- consolidare il risultato.

Non deve sostituire il ragionamento sul log.

Per ogni run significativo:
- leggere prima l'esito del build;
- leggere il log del caso;
- distinguere eventuali errori indipendenti dal problema analizzato;
- non dichiarare fallito il debug se il caso mirato è verde ma un test
  estraneo noto resta rosso;
- registrare commit, run e conclusione nel Recovery quando l'attività è lunga.

### Distinzione Service / Harness

Il Service usa:

```text
logEnabled
logCategories
```

L'Harness usa:

```text
--log-enabled
--log-categories
```

Entrambi devono governare lo stesso `TermodelLog`.

Non creare due tassonomie diverse per lo stesso algoritmo.

### Setup attualmente verificato

Implementazione iniziale:
- commit `e35f05099179aae5f1af6df80527c00d0704c1c5`;
- categoria `SpiraliDiegoVittorio`;
- wiring Service/Core/Harness;
- Fast Harness run `36422697579`: SUCCESS.

Completamento log di percorrenza dopo la prima ispezione:
- commit `49f28610128096e87db27fbea58f5d7f73f9d27d`;
- aggiunti solo i dati realmente mancanti;
- Fast Harness run `36423105809`: SUCCESS;
- regression Diego_Vittorio rimaste verdi.

Build Service sul secondo commit:
- build: 0 errori;
- smoke pubblico Pannelli radianti: SUCCESS;
- workflow complessivo successivamente rosso sul Golden Darcy sintetico già
  noto e indipendente dalla diagnostica spirali.

### Esempio metodologico verificato: locale_1

Il metodo ha permesso di stabilire, senza modificare la geometria, che:
- il terzo offset teorico raw sarebbe 0,39 × 2,80 m;
- come anello chiuso completo non è valido per distanza Supply-Supply 0,60 m;
- il secondo offset reale è invece percorso correttamente;
- il terminale reale è `(0,82 ; 3,54316)`;
- resta un varco reale di 0,60 m;
- il punto da indagare non è "rimuovere il controllo", ma comprendere la
  transizione fra lo stato reale della spirale aperta e la generazione
  preventiva del successivo poligono chiuso.

Questo esempio è importante perché mostra il principio operativo:
**il log deve prima dimostrare dove avviene il fallimento; la correzione viene
discussa solo dopo.**

### Quando usare questa chiave

Quando una chat o un incarico richiede:

```text
Debug_Avanzato_harness_rapido
```

la chat deve:
1. leggere questo documento;
2. individuare il caso reale corrente;
3. verificare quali categorie/log esistono già;
4. usare il logger esistente;
5. eseguire l'Harness mirato;
6. leggere il log;
7. aggiungere solo la diagnostica mancante;
8. non cambiare l'algoritmo finché la causa non è sufficientemente provata;
9. consolidare con regression e documentazione;
10. aggiornare Recovery e Issue #1 quando richiesto dal protocollo del progetto.
