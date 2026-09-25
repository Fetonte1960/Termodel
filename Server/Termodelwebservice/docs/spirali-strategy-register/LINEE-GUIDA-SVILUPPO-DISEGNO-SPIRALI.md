# Linee guida per lo sviluppo del disegno spirali

Classificazione: **SPECIFICA VIVA — IN DEFINIZIONE**  
Ambito: Termodel / pannelli radianti / generazione geometrica spirali  
Destinazione prevista: futura strategia/classe **StrategiaDiego**

## Stato operativo corrente — 25/09/2026

> **Questa sezione è autorevole sullo stato runtime corrente.**
> Le frasi "non ancora implementata" presenti nelle sezioni storiche delle
> singole LG descrivono lo stato al momento in cui la regola fu definita e non
> devono essere interpretate come stato attuale del motore.

### Stato dell'algoritmo

StrategiaDiego è oggi:

- **progettata:** sì, specifica viva LG-001..LG-036;
- **implementata:** sì, come terzo motore headless distinto da Vittorio e GPT;
- **selezionabile:** sì, tramite `TERMODEL_SPIRAL_ENGINE=Vittorio|GPT|Diego`;
- **default Service:** Diego quando la variabile non è impostata; per i test
  dedicati viene comunque forzato esplicitamente `Diego`;
- **compilata:** sì, build Release GitHub Actions verificata;
- **testata sinteticamente:** sì, quadrato 4x4/un ingresso e concavo a L;
- **inseguimento LG-033..LG-035:** implementato tramite sequenza `S_k -> S_k+1`;
- **sostenibilità computazionale sintetica:** verificata sui casi correnti;
- **Golden geometrico completo:** non ancora approvato;
- **validazione su progetto reale complesso:** **in corso**.

### Direttiva permanente — banco prova operativo corrente

Dal 25/09/2026 il banco prova primario dello sviluppo spirali è:

```text
tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl
```

SHA-256 della snapshot originale:

```text
1a5855490adcbac25e5585f9ba89c624eb2381874eb2de8bdc74821a40d2a9a5
```

Il quadrato 4x4 e il locale concavo a L restano regression sintetiche rapide,
ma **non sono più il banco operativo principale**.

La fixture appartamento deve essere usata con GitHub Actions richiedendo
direttamente:

```http
POST /api/calculations?responseArtifact=pannelli-esecutivo-svg
```

e forzando `TERMODEL_SPIRAL_ENGINE=Diego`.

Verifica operativa iniziale del banco:

- Action #474, run `36103622680`, job `107971255939`: **SUCCESS**;
- la fixture locale viene verificata col suo SHA-256 originale e resta immutata;
- una copia temporanea viene canonicalizzata come il normale `Aggiorna Modello`
  prima di essere inviata al Service;
- risposta `pannelli-esecutivo-svg`: HTTP 200;
- artifact diagnostico `strategia-diego-current-apartment`, id `10850671585`;
- SVG iniziale SHA-256
  `71921972d16085fab3071e56cd53a0695661536436678b2c64e7051f1312ecb8`;
- output corrente del banco: 1 circuito, 6 primitive esecutivo, 1 piano;
- questo SUCCESS verifica la **riproducibilità tecnica del banco**, non
  l'approvazione geometrica dell'intero output.

### Lavoro in corso

Il ciclo di sviluppo corrente è locale-per-locale:

```text
screenshot utente + numero locale
        ↓
riproduzione sulla fixture appartamento corrente
        ↓
individuazione della PRIMA decisione strategica errata
        ↓
regola LG esistente violata?
  sì -> correggere il codice affinché la rispetti
  no -> definire e consolidare una nuova LG
        ↓
correzione minima
        ↓
GitHub Action sulla stessa fixture
        ↓
confronto prima/dopo e nuovo regression
```

Ogni caso reale significativo deve quindi diventare progressivamente una
verifica riproducibile. Non si aggiorna un Golden Result per far sparire una
differenza: prima si comprende e si approva la causa.

La fixture corrente è una snapshot: non va modificata silenziosamente.
Un nuovo progetto corrente può sostituirla solo su direttiva esplicita,
mantenendo tracciabilità della versione precedente quando necessario.

---

## Scopo

Questo documento viene costruito progressivamente durante il confronto tecnico
con Diego. Ogni punto viene:

1. proposto dall'utente;
2. commentato dal punto di vista geometrico/algoritmico;
3. trasformato in una regola verificabile;
4. consolidato su Git;
5. usato, quando possibile, come futuro criterio di regression test.

Il documento non modifica automaticamente gli algoritmi esistenti. Finché non
viene commissionata l'implementazione, descrive il comportamento richiesto alla
futura **StrategiaDiego**.

Le schede puntuali in `docs/spirali-strategy-register/` restano il registro
dei casi geometrici reali e dei vincoli strategici. Le presenti Linee guida
hanno invece funzione più generale: definiscono la filosofia e le regole di
costruzione della StrategiaDiego.

---

## LG-001 — Strategie concorrenti e selezionabili

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Il nuovo sviluppo deve condurre a una strategia denominata **StrategiaDiego**,
concorrente con le strategie/motori **Vittorio** e **GPT** già presenti nel
progetto. Le tre alternative devono poter essere usate a richiesta.

### Commento tecnico

StrategiaDiego non deve essere costruita come una modifica irreversibile di
Vittorio o GPT. Deve essere una terza implementazione isolata, in modo che lo
stesso caso geometrico possa essere elaborato con strategie differenti e che
il confronto fra risultati rimanga possibile.

Il riferimento Git attuale conserva già due linee indipendenti:

- motore Vittorio in
  `SorgentiTermodel/Library/Impianti/Pannelli/Termodel-Vittorio-main/Termodel_new/`;
- motore GPT in
  `SorgentiTermodel/Library/Impianti/Pannelli/SpiraliGPT/`.

La documentazione di SpiraliGPT prevede già la selezione
`Vittorio | GPT`. La futura estensione naturale dovrà diventare
`Vittorio | GPT | Diego`.

### Regola

Le tre strategie devono essere trattate come **concorrenti**, non come versioni
che si sovrascrivono reciprocamente:

```text
stesso input geometrico
        |
        +--> StrategiaVittorio
        |
        +--> StrategiaGPT
        |
        +--> StrategiaDiego
        |
        v
stesso tipo di risultato confrontabile
```

La scelta della strategia deve essere **esplicita**. Nessuna strategia deve
sostituirne silenziosamente un'altra.

### Vincoli per la futura implementazione

- StrategiaDiego avrà propria identità e proprio codice;
- Vittorio e GPT non devono essere modificati per far apparire Diego;
- l'input necessario al confronto deve essere equivalente;
- l'output deve essere trasformabile nello stesso modello grafico/esecutivo;
- il nome della strategia usata deve essere registrabile nei risultati e nei
  test;
- eventuali fallback automatici fra strategie dovranno essere oggetto di una
  decisione esplicita successiva: non sono autorizzati da questa linea guida.

### Criterio futuro di verifica

Dato lo stesso locale/progetto di regression, il sistema deve poter eseguire
separatamente Vittorio, GPT e Diego, identificare chiaramente la strategia
selezionata e produrre risultati confrontabili senza che l'esecuzione di una
modifichi il comportamento delle altre.

### Stato implementativo corrente

Questa linea guida è **documentale**. Non viene ancora creata
`StrategiaDiego` e non viene ancora esteso il selettore runtime del Service.
L'implementazione partirà soltanto quando le regole sufficienti della strategia
saranno state definite e verrà commissionata esplicitamente.


---

## LG-002 — StrategiaDiego come albero decisionale

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026, rettificata da grafo ad **albero**

### Proposta

La struttura fondamentale della **StrategiaDiego** è un **albero decisionale**.

- i **nodi** rappresentano situazioni in cui esiste una scelta strategica;
- i **rami** rappresentano le alternative possibili a partire da quella scelta;
- le **foglie/terminali** rappresentano situazioni in cui non esiste più una
  scelta strategica da compiere.

### Commento tecnico

La rettifica da grafo ad albero è sostanziale.

Ogni esecuzione parte da una radice e procede soltanto verso il basso,
attraversando una sequenza di decisioni. Due rami distinti non si
ricongiungono successivamente nello stesso nodo e non sono ammessi cicli.

Questo rende la strategia leggibile come una sequenza gerarchica di scelte:

```text
                 [RADICE]
                    |
                 [NODO]
                /      \
          scelta A      scelta B
             |             |
          [NODO]         [NODO]
          /   \             \
       ...    ...         [TERMINALE]
        |
   [TERMINALE]
```

Ogni percorso completo dall'origine a una foglia descrive una strategia
concreta applicata a quella situazione geometrica.

### Regola

Un elemento della StrategiaDiego appartiene a una delle due categorie
strategiche fondamentali:

**Nodo decisionale**
- descrive una situazione riconoscibile;
- dispone di almeno due alternative strategiche ammissibili;
- ogni alternativa apre un ramo distinto dell'albero;
- la scelta deve essere motivabile usando dati geometrici e stato disponibili.

**Foglia / terminale**
- descrive una situazione riconoscibile;
- non presenta ulteriori alternative strategiche;
- non apre nuovi rami;
- determina l'azione finale o una prosecuzione obbligata e priva di scelta.

La domanda che separa nodo e terminale è:

```text
"In questa situazione esistono almeno due comportamenti strategicamente
ammissibili fra cui scegliere?"

SI  -> nodo
NO  -> foglia / terminale
```

### Vincoli per la futura implementazione

- deve esistere una radice riconoscibile dell'albero;
- ogni nodo deve avere un'identità stabile e leggibile;
- ogni ramo deve corrispondere a una scelta esplicita e descrivibile;
- ogni nodo non radice deve avere un solo padre;
- due rami differenti non devono ricongiungersi in uno stesso nodo;
- non sono ammessi cicli;
- la condizione che porta a un nodo o a una foglia deve essere verificabile;
- la decisione presa deve poter essere registrata in diagnostica;
- le funzioni geometriche possono misurare, verificare e costruire, ma non
  devono nascondere decisioni strategiche che appartengono all'albero.

### Criterio futuro di verifica

Durante l'esecuzione di StrategiaDiego deve essere possibile ricostruire
integralmente il percorso:

```text
radice
-> nodo visitato
-> ramo selezionato
-> nodo successivo
-> ...
-> foglia / terminale
-> esito deterministico
```

Per uno stesso input e gli stessi parametri, il percorso radice-foglia deve
essere riproducibile e diagnosticabile.

### Punti ancora da definire

LG-002 non stabilisce ancora:

- quale sia il contenuto concreto della radice;
- quali siano i primi nodi decisionali;
- quali dati compongano lo stato trasmesso lungo i rami;
- la regola con cui una scelta viene preferita alle altre;
- quali tipi di foglia/terminale debbano essere formalizzati.

Questi elementi verranno definiti con le successive linee guida.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna struttura dati dell'albero e
nessuna classe StrategiaDiego sono ancora implementate.


---

## LG-003 — Fattore di merito dei terminali e scelta della soluzione

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Ogni foglia/terminale dell'albero StrategiaDiego possiede un **fattore di
merito**.

Il fattore di merito è definito come:

```text
fattore_di_merito(terminale) = lunghezza totale di tubo prodotta
```

Al termine della costruzione/esplorazione dell'albero, l'algoritmo sceglie il
terminale valido con il fattore di merito maggiore.

La spirale definitiva viene quindi prodotta percorrendo l'albero dalla radice
al terminale selezionato e applicando, nell'ordine, le scelte registrate nei
nodi attraversati.

### Commento tecnico

Questa regola separa nettamente due fasi:

1. **fase di ricerca/valutazione**
   - si costruiscono i rami candidati;
   - si raggiungono uno o più terminali;
   - per ogni terminale si determina la lunghezza di tubo ottenibile;
   - si registra il percorso decisionale che ha portato al terminale;

2. **fase di materializzazione**
   - si sceglie il terminale con merito massimo;
   - si risale logicamente al percorso radice -> terminale;
   - si riapplicano in ordine le scelte dei nodi;
   - si produce la geometria definitiva delle spirali.

Il criterio di merito non sostituisce i vincoli di validità geometrica.
Un terminale può partecipare al confronto soltanto se il percorso che lo ha
generato è considerato valido dalle regole StrategiaDiego applicabili.

### Regola

Dato l'insieme dei terminali validi:

```text
T = { t1, t2, ..., tn }
```

per ciascun terminale:

```text
M(ti) = lunghezza_tubo(ti)
```

il terminale selezionato è:

```text
t* = arg max M(ti)
```

La soluzione finale è il percorso unico:

```text
radice -> nodo1 -> ramo scelto -> nodo2 -> ... -> t*
```

e la geometria finale deve derivare dall'applicazione ordinata delle scelte
contenute in quel percorso.

### Vincoli per la futura implementazione

- il fattore di merito deve essere espresso in una unità di lunghezza coerente
  e non dipendente dalla visualizzazione;
- la lunghezza deve riferirsi alla geometria di tubo effettivamente producibile,
  non a una stima puramente grafica priva di corrispondenza con il risultato;
- terminali invalidi non partecipano alla massimizzazione;
- ogni terminale deve conservare il riferimento al proprio percorso
  radice -> foglia;
- ogni scelta effettuata in un nodo deve essere registrabile e riapplicabile;
- la fase finale non deve inventare nuove decisioni: deve soltanto riprodurre
  quelle del percorso vincente;
- il risultato finale deve poter indicare almeno il terminale selezionato, il
  suo fattore di merito e la sequenza dei nodi/rami attraversati;
- il comportamento in caso di parità fra due o più terminali con identico
  fattore di merito non è ancora definito e richiederà una linea guida
  successiva.

### Criterio futuro di verifica

Per un caso di regression con più terminali validi, la diagnostica deve
permettere di verificare:

```text
terminale A -> lunghezza A
terminale B -> lunghezza B
...
terminale selezionato -> massima lunghezza valida
percorso selezionato -> radice ... terminale
spirale finale -> ottenuta applicando esattamente quel percorso
```

A parità di input e parametri, sia la selezione del terminale sia la geometria
finale devono essere riproducibili.

### Punti ancora da definire

LG-003 non stabilisce ancora:

- come risolvere le parità di fattore di merito;
- se in futuro il fattore di merito potrà diventare composito o includere
  penalità/premi oltre alla lunghezza;
- il dettaglio esatto con cui viene calcolata la lunghezza in presenza di
  raccordi, arrotondamenti o tratti tecnici.

Finché queste regole non verranno estese, il principio base resta:
**massimizzare la lunghezza di tubo fra i terminali validi**.

### Stato implementativo corrente

Principio documentale consolidato. Nessun algoritmo di esplorazione,
valutazione dei terminali o replay del percorso vincente è ancora implementato
in StrategiaDiego.


---

## LG-004 — Struttura geometrica di contenimento

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

La StrategiaDiego opera all'interno di una **struttura geometrica di
contenimento** composta da tre famiglie di linee:

1. **linee architettoniche della stanza**;
2. **linee della mandata**;
3. **linee del ritorno**.

Queste tre famiglie costituiscono il riferimento geometrico rispetto al quale
vengono riconosciute le situazioni, costruiti i nodi dell'albero e valutate le
alternative.

### Commento tecnico

La struttura di contenimento rappresenta lo **stato geometrico fisico** entro
cui si sviluppano le decisioni di StrategiaDiego.

Le tre famiglie devono restare semanticamente distinte anche se, dal punto di
vista matematico, possono essere rappresentate con primitive geometriche
simili o identiche.

In particolare:

- le **linee architettoniche** descrivono i limiti e gli ostacoli derivati
  dalla geometria della stanza;
- le **linee di mandata** descrivono la geometria già appartenente al percorso
  di mandata;
- le **linee di ritorno** descrivono la geometria già appartenente al percorso
  di ritorno.

LG-004 definisce soltanto la composizione della struttura geometrica. Non
stabilisce ancora quali linee possano essere attraversate, affiancate,
aggirate o usate come vincolo nei singoli nodi decisionali.

### Regola

Lo stato geometrico minimo della StrategiaDiego deve poter essere espresso come:

```text
ContenimentoGeometrico =
{
    LineeArchitettoniche,
    LineeMandata,
    LineeRitorno
}
```

Ogni linea deve conservare almeno l'informazione necessaria a distinguere la
famiglia cui appartiene.

Le decisioni dell'albero non devono trattare implicitamente tutte le linee come
un unico insieme indistinto: il ruolo geometrico della linea deve essere
conoscibile quando un nodo valuta una scelta.

### Vincoli per la futura implementazione

- le tre famiglie devono essere mantenute distinguibili nello stato;
- la classificazione di una linea deve essere esplicita e diagnosticabile;
- un nodo deve poter interrogare separatamente linee architettoniche, mandata e
  ritorno;
- l'aggiunta progressiva di nuovi tratti di mandata o ritorno deve aggiornare
  la corrispondente famiglia della struttura di contenimento;
- le linee architettoniche non devono essere confuse con le linee generate
  dalla spirale;
- LG-004 non autorizza ancora alcuna regola di collisione, attraversamento,
  distanza minima o precedenza fra le tre famiglie: tali comportamenti saranno
  definiti separatamente.

### Criterio futuro di verifica

Per ogni nodo della StrategiaDiego deve essere possibile diagnosticare la
struttura geometrica ricevuta distinguendo almeno:

```text
numero/insieme linee architettoniche
numero/insieme linee mandata
numero/insieme linee ritorno
```

Dopo l'applicazione di una scelta che genera nuovi tratti, il nodo successivo
deve ricevere una struttura coerentemente aggiornata.

### Punti ancora da definire

LG-004 non stabilisce ancora:

- la rappresentazione concreta di una linea o polilinea;
- se le linee architettoniche coincidano sempre con il contorno netto del
  locale o includano anche ostacoli interni;
- le distanze di rispetto;
- le regole di intersezione o attraversamento;
- le differenti proprietà strategiche di mandata e ritorno;
- il modo in cui la struttura viene copiata o derivata lungo i rami
  dell'albero.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna nuova struttura dati geometrica è
ancora implementata in StrategiaDiego.


---

## LG-005 — Concetto di tratto possibile

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Si definisce **tratto possibile** un tratto che:

1. rispetta tutte le regole di tracciamento applicabili;
2. genera un segmento di lunghezza strettamente maggiore di zero.

### Commento tecnico

Il concetto di tratto possibile diventa il filtro elementare usato dai nodi
dell'albero quando devono stabilire quali alternative possano realmente essere
aperte.

Non basta che due punti definiscano matematicamente un segmento: quel segmento
deve anche rispettare le regole geometriche e strategiche di tracciamento
valide nello stato corrente.

La condizione di lunghezza positiva evita di considerare come alternative
effettive segmenti degeneri, coincidenti o ridotti a un punto.

LG-005 non definisce ancora l'elenco completo delle regole di tracciamento:
stabilisce soltanto il criterio generale con cui un candidato viene
classificato come possibile o non possibile.

### Regola

Dato un segmento candidato `s`:

```text
TrattoPossibile(s) =
    RispettaRegoleDiTracciamento(s)
    AND
    Lunghezza(s) > 0
```

Se una delle due condizioni è falsa, il tratto non è possibile.

### Conseguenza sull'albero decisionale

Un nodo può aprire un ramo associato a un nuovo tratto soltanto se quel tratto
è possibile secondo LG-005.

Quindi:

```text
tratto candidato
      |
      v
rispetta regole di tracciamento?
      |
   NO +--> ramo non ammissibile
      |
     SI
      |
lunghezza > 0?
      |
   NO +--> ramo non ammissibile
      |
     SI
      |
      v
tratto possibile
```

### Vincoli per la futura implementazione

- il controllo di possibilità deve essere eseguibile in modo deterministico;
- la lunghezza deve essere calcolata nella stessa unità geometrica usata dalla
  StrategiaDiego;
- un segmento di lunghezza zero non deve generare un ramo dell'albero;
- un segmento che viola anche una sola regola di tracciamento applicabile non
  deve generare un ramo valido;
- la diagnostica dovrebbe poter indicare perché un tratto è stato rifiutato:
  lunghezza nulla oppure violazione di una specifica regola di tracciamento;
- le regole di tracciamento dovranno essere definite separatamente e potranno
  dipendere dalla famiglia geometrica coinvolta
  (architettura, mandata, ritorno).

### Criterio futuro di verifica

Per ogni tratto candidato deve essere possibile verificare almeno:

```text
lunghezza segmento
regole di tracciamento controllate
esito di ciascun controllo
TrattoPossibile = SI / NO
```

Un tratto con lunghezza nulla deve risultare sempre non possibile.

Un tratto di lunghezza positiva deve risultare possibile soltanto se supera
tutte le regole di tracciamento applicabili.

### Punti ancora da definire

LG-005 non stabilisce ancora:

- quali siano tutte le regole di tracciamento;
- se esista una tolleranza numerica sotto la quale una lunghezza positiva venga
  comunque considerata nulla;
- se il concetto debba estendersi in futuro a polilinee o curve oltre al
  singolo segmento.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna funzione `TrattoPossibile` è
ancora implementata in StrategiaDiego.


---

## LG-006 — Passo p e distanze minime di tracciamento

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Si definisce il **passo `p`** come distanza minima di riferimento tubo-tubo.

Le distanze minime di tracciamento sono:

- distanza minima da una linea architettonica: `p / 2`;
- distanza minima fra tubi dello stesso colore: `2p`;
- distanza minima fra tubi di colore diverso: `p`.

Nel modello corrente, i due colori corrispondono alle due famiglie di tubo:

- mandata;
- ritorno.

### Commento tecnico

Il passo `p` diventa l'unità geometrica fondamentale con cui StrategiaDiego
valuta la possibilità di tracciare nuovi segmenti.

Le tre regole non sono equivalenti:

1. la parete architettonica impone un margine minimo pari a metà passo;
2. due tratti appartenenti alla stessa famiglia/colore richiedono una
   separazione più ampia, pari a due passi;
3. mandata e ritorno possono avvicinarsi fino a un passo.

Questa asimmetria è intenzionale e deve essere mantenuta esplicitamente nelle
regole di `TrattoPossibile`.

Per evitare ambiguità implementative, salvo diversa futura decisione, le
distanze vengono intese fra le linee geometriche/assi con cui i tubi sono
rappresentati nella StrategiaDiego, non fra le superfici fisiche esterne del
tubo.

### Regola

Per un nuovo tratto candidato `s`:

```text
dist(s, LineeArchitettoniche) >= p/2

dist(s, tubi stesso colore)   >= 2p

dist(s, tubi colore diverso)  >= p
```

dove `dist` indica la distanza geometrica minima fra il segmento candidato e
la geometria già presente nella corrispondente famiglia.

Un tratto che non rispetta anche una sola delle distanze minime applicabili
non è un `TrattoPossibile` ai sensi di LG-005.

### Relazione con la struttura di contenimento

Le tre famiglie di LG-004 vengono quindi usate con regole differenti:

```text
LineeArchitettoniche  -> distanza minima p/2
LineeMandata          -> 2p rispetto a nuova mandata
                       p  rispetto a nuovo ritorno
LineeRitorno          -> 2p rispetto a nuovo ritorno
                       p  rispetto a nuova mandata
```

### Vincoli per la futura implementazione

- `p` deve essere un parametro geometrico esplicito della strategia;
- il valore di `p` deve essere positivo;
- tutte le verifiche devono usare la stessa unità geometrica;
- il colore/famiglia del tratto candidato deve essere noto prima della
  verifica delle distanze tubo-tubo;
- le verifiche devono considerare la distanza minima lungo tutto il segmento,
  non soltanto agli estremi;
- il rispetto di `p/2`, `p` o `2p` deve entrare direttamente nelle regole di
  `TrattoPossibile`;
- eventuali eccezioni locali a queste distanze dovranno essere autorizzate da
  una linea guida successiva e non possono essere introdotte implicitamente.

### Criterio futuro di verifica

Per ogni tratto candidato devono poter essere diagnosticati almeno:

```text
colore/famiglia del tratto
valore di p
distanza minima da architettura
distanza minima da tubi dello stesso colore
distanza minima da tubi di colore diverso
esito TrattoPossibile
```

Devono essere presenti casi di regression almeno sulle soglie:

```text
architettura:  < p/2, = p/2, > p/2
stesso colore: < 2p,  = 2p,  > 2p
colore diverso:< p,   = p,   > p
```

### Stato implementativo corrente

Principio documentale consolidato. Le distanze minime definite da LG-006 non
sono ancora implementate nella futura StrategiaDiego.


---

## LG-007 — Scelta di nodo possibile

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Si definisce **scelta di nodo possibile** un tratto che:

1. è un `TrattoPossibile` secondo LG-005;
2. non interseca altre linee già generate;
3. genera una linea parallela a un'altra linea già esistente;
4. mantiene rispetto alla linea di riferimento la distanza minima di
   tracciamento applicabile secondo LG-006.

### Commento tecnico

La nozione di `SceltaNodoPossibile` è più restrittiva di `TrattoPossibile`.

`TrattoPossibile` risponde alla domanda:

```text
questo segmento può esistere senza violare le regole generali di tracciamento?
```

`SceltaNodoPossibile` risponde invece alla domanda:

```text
questo segmento può costituire una concreta alternativa di costruzione
all'interno di un nodo dell'albero?
```

Per essere una scelta di nodo, il segmento deve quindi essere costruito in
relazione esplicita a una linea di riferimento già presente e deve svilupparsi
parallelamente ad essa alla distanza minima prevista.

La condizione di non intersezione impedisce che una scelta candidata attraversi
tratti già costruiti della spirale.

### Regola

Dato un segmento candidato `s` e una linea di riferimento esistente `r`:

```text
SceltaNodoPossibile(s, r) =
    TrattoPossibile(s)
    AND NonIntersecaLineeGenerate(s)
    AND Parallelo(s, r)
    AND Distanza(s, r) = DistanzaMinimaApplicabile
```

dove `DistanzaMinimaApplicabile` deriva da LG-006 in funzione delle famiglie
coinvolte:

```text
r architettonica                -> p/2
r tubo stesso colore di s       -> 2p
r tubo colore diverso da s      -> p
```

### Conseguenza sull'albero decisionale

Un ramo di un nodo può essere creato soltanto a partire da una
`SceltaNodoPossibile`.

Quindi:

```text
linea di riferimento esistente
          |
          v
costruisci candidata parallela alla distanza minima
          |
          v
interseca linee già generate?
     |              |
    SI             NO
     |              |
 scarta      TrattoPossibile?
                    |
               NO   |   SI
                |   |    |
              scarta    ramo del nodo
```

### Vincoli per la futura implementazione

- ogni scelta deve conservare il riferimento alla linea rispetto alla quale è
  stata generata;
- il parallelismo deve essere verificato geometricamente e non dedotto soltanto
  da come il segmento è stato costruito;
- la distanza dalla linea di riferimento deve corrispondere alla distanza
  minima applicabile di LG-006;
- il controllo di intersezione deve considerare le linee già generate prima
  dell'apertura del nuovo ramo;
- una scelta che interseca una linea già generata non può essere ammessa come
  ramo del nodo;
- una scelta ammessa deve essere diagnosticabile indicando almeno linea di
  riferimento, famiglia/colore, distanza applicata e risultato dei controlli.

### Criterio futuro di verifica

Per ogni scelta candidata deve essere possibile verificare:

```text
segmento candidato
linea di riferimento
parallelismo
distanza richiesta
distanza effettiva
intersezioni con linee già generate
TrattoPossibile
SceltaNodoPossibile = SI / NO
```

Un candidato che sia geometricamente valido ma non parallelo a una linea
esistente non è una scelta di nodo possibile.

Un candidato parallelo e alla distanza corretta ma che interseca una linea
già generata non è una scelta di nodo possibile.

### Punti ancora da definire

LG-007 non stabilisce ancora:

- quale linea esistente debba essere scelta come riferimento quando ve ne sono
  più di una;
- come ordinare più scelte di nodo possibili;
- quali tolleranze numeriche usare per parallelismo e distanza;
- se e come i punti di contatto agli estremi vengano trattati come
  intersezioni proibite.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna funzione
`SceltaNodoPossibile` è ancora implementata in StrategiaDiego.


---

## LG-008 — Terminale accettabile

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Si definisce **terminale accettabile** un terminale dell'albero nel quale
l'estremo della mandata e l'estremo della ripresa/ritorno possono essere
collegati fra loro senza che il collegamento intersechi altre linee.

### Commento tecnico

LG-008 distingue quindi fra:

- **terminale dell'albero**: una foglia nella quale non esistono ulteriori
  scelte strategiche;
- **terminale accettabile**: una foglia che consente anche la chiusura
  geometrica fra mandata e ripresa senza intersezioni.

La sola condizione definita in questa linea guida è la non-intersezione del
collegamento finale con le altre linee già presenti. Non vengono introdotti
implicitamente ulteriori vincoli di distanza o parallelismo: se necessari,
dovranno essere definiti esplicitamente in una linea guida successiva.

### Regola

Siano:

- `M` = estremo corrente della mandata;
- `R` = estremo corrente della ripresa/ritorno;
- `c(M,R)` = collegamento fra i due estremi.

Il terminale è accettabile se e solo se:

```text
TerminaleAccettabile =
    Terminale
    AND
    EsisteCollegamento(M, R)
    AND
    NonIntersecaAltreLinee(c(M,R))
```

### Momento della valutazione

La valutazione di accettabilità dei terminali viene eseguita **soltanto alla
fine della costruzione completa dell'albero decisionale**.

La sequenza logica è quindi:

```text
costruzione completa dell'albero
        |
        v
raccolta di tutte le foglie / terminali
        |
        v
valutazione TerminaleAccettabile per ogni terminale
        |
        v
insieme dei terminali accettabili
        |
        v
confronto del fattore di merito
        |
        v
scelta del terminale vincente
```

L'accettabilità non deve quindi essere usata anticipatamente per decidere quale
ramo costruire o per interrompere la costruzione dell'albero.

### Relazione con LG-003

Il fattore di merito e la selezione finale devono essere applicati soltanto ai
terminali accettabili, **dopo che l'albero è stato costruito completamente**.

Quindi l'insieme dei candidati alla massimizzazione diventa:

```text
T_acc = { terminali accettabili valutati a fine costruzione }

t* = arg max LunghezzaTubo(t),  con t appartenente a T_acc
```

Un terminale non accettabile non può essere scelto come soluzione finale,
indipendentemente dalla lunghezza di tubo prodotta.

### Vincoli per la futura implementazione

- ogni terminale deve conoscere l'estremo corrente della mandata e quello
  della ripresa/ritorno;
- il collegamento finale candidato deve essere geometricamente costruibile;
- il controllo di intersezione deve essere effettuato contro le altre linee
  già presenti nello stato del terminale;
- un terminale con collegamento finale intersecante è non accettabile;
- l'accettabilità deve essere diagnosticabile separatamente dal fattore di
  merito;
- la verifica di accettabilità deve essere differita fino al completamento
  della costruzione dell'albero;
- l'accettabilità non deve essere usata per potare anticipatamente i rami;
- la fase di selezione di LG-003 deve ignorare i terminali non accettabili.

### Criterio futuro di verifica

Per ogni terminale deve essere possibile diagnosticare almeno:

```text
estremo mandata
estremo ripresa/ritorno
collegamento finale candidato
intersezioni rilevate
TerminaleAccettabile = SI / NO
```

Devono essere presenti casi di regression con almeno:

- collegamento finale libero -> terminale accettabile;
- collegamento finale che interseca una linea -> terminale non accettabile.

### Punti ancora da definire

LG-008 non stabilisce ancora:

- la forma geometrica del collegamento finale se non fosse un singolo
  segmento;
- eventuali distanze minime da rispettare durante la chiusura;
- il trattamento dei contatti esatti agli estremi;
- il comportamento nel caso in cui nessun terminale dell'albero risulti
  accettabile.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna funzione
`TerminaleAccettabile` è ancora implementata in StrategiaDiego.


---

## LG-009 — Configurazione iniziale e direzione principe

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

La costruzione dell'albero StrategiaDiego parte da un **tubo di collegamento**
che entra nella stanza.

Il tubo di collegamento di partenza appartiene alla **mandata**.

Sono previste almeno due configurazioni iniziali:

- ritorno a sinistra;
- ritorno a destra.

Per la configurazione **ritorno a sinistra**, la costruzione dell'albero inizia
dall'estremo del tubo di collegamento di mandata e assume come
**direzione principe** il tratto parallelo disposto verso destra.

### Commento tecnico

Per rendere la regola non ambigua, destra e sinistra sono definite rispetto
alla **direzione del tubo di collegamento dall'esterno verso la stanza**. Questo
verso `esterno -> stanza` costituisce il riferimento locale convenzionale della
StrategiaDiego.

Quindi il riferimento locale è:

```text
direzione tubo di collegamento: esterno -> stanza
lato destro di questo verso              -> destra
lato sinistro di questo verso            -> sinistra
```

Nella configurazione definita da LG-009:

```text
ritorno = lato sinistro
partenza costruzione = estremo interno della mandata
direzione principe = tratto parallelo sul lato destro
```

La nozione di direzione principe identifica l'orientamento prioritario con cui
vengono generate/considerate le prime scelte dell'albero. Non implica ancora
che eventuali altre scelte geometricamente ammissibili debbano essere escluse:
la relazione fra direzione principe e rami alternativi sarà definita da regole
successive.

### Regola

Data una mandata di collegamento orientata verso l'interno della stanza:

```text
se Configurazione = RitornoSinistra:
    Radice = estremo interno della mandata
    DirezionePrincipe = parallela sul lato destro
```

Il tratto generato nella direzione principe deve comunque soddisfare tutte le
regole già consolidate di `TrattoPossibile` e `SceltaNodoPossibile`.

### Relazione con LG-007

La direzione principe non crea automaticamente un ramo valido.

Il tratto candidato verso destra deve essere verificato come:

```text
TrattoPossibile
AND
SceltaNodoPossibile
```

prima di diventare un ramo effettivo dell'albero.

### Vincoli per la futura implementazione

- il tubo di collegamento deve avere un verso definito verso l'interno della
  stanza;
- la configurazione iniziale deve identificare esplicitamente il lato del
  ritorno;
- destra/sinistra devono essere calcolate esclusivamente rispetto alla
  direzione convenzionale del tubo di collegamento `esterno -> stanza` e non
  rispetto agli assi globali del disegno;
- la radice dell'albero deve essere associata all'estremo interno della
  mandata;
- la direzione principe deve essere registrabile nella diagnostica;
- la direzione principe non deve bypassare le verifiche geometriche di LG-005,
  LG-006 e LG-007.

### Criterio futuro di verifica

Per un caso con ritorno a sinistra devono essere diagnosticabili almeno:

```text
verso tubo di collegamento mandata
lato identificato come sinistro
lato identificato come destro
configurazione = RitornoSinistra
radice = estremo interno mandata
direzione principe = destra
```

Ruotando geometricamente l'intero locale, la definizione di destra/sinistra
deve seguire sempre la direzione convenzionale del tubo di collegamento
`esterno -> stanza` e non cambiare per effetto degli assi globali.

### Punti ancora da definire

LG-009 non stabilisce ancora:

- la regola esplicita per la configurazione `RitornoDestra`;
- se la direzione principe abbia precedenza assoluta o solo priorità di
  esplorazione;
- come venga identificato geometricamente il primo tratto parallelo quando
  più linee possano fungere da riferimento;
- cosa accada se nessun tratto verso la direzione principe è possibile.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna logica di orientamento iniziale
della futura StrategiaDiego è ancora implementata.


---

## LG-010 — Lato di ritorno associato al singolo tubo di collegamento

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Ogni tubo di collegamento di entrata possiede un proprio **lato di ritorno**.

Il lato di ritorno non è una proprietà globale della stanza o del progetto:
è associato al singolo tubo di collegamento.

Di conseguenza, due tubi di collegamento differenti possono avere
configurazioni differenti, per esempio:

```text
TuboIngresso A -> RitornoSinistra
TuboIngresso B -> RitornoDestra
```

### Commento tecnico

Questa regola rende la configurazione iniziale locale a ciascun ingresso.

La StrategiaDiego deve quindi determinare destra/sinistra e direzione principe
separatamente per ogni tubo di collegamento, usando per ciascuno:

1. il proprio verso convenzionale `esterno -> stanza`;
2. il proprio lato di ritorno associato.

Non è ammesso dedurre il lato di ritorno di un ingresso da quello usato da un
altro ingresso.

### Regola

Per ogni tubo di collegamento `i` deve esistere una proprietà:

```text
LatoRitorno(i) = Sinistra | Destra
```

e tutte le decisioni iniziali relative a quell'ingresso devono usare
esclusivamente `LatoRitorno(i)`.

### Relazione con LG-009

LG-009 continua a definire il sistema locale destra/sinistra rispetto al verso
`esterno -> stanza`.

LG-010 precisa che la configurazione:

```text
RitornoSinistra
oppure
RitornoDestra
```

deve essere valutata **per ogni singolo tubo di collegamento**.

### Vincoli per la futura implementazione

- ogni tubo di collegamento deve conservare esplicitamente il proprio lato di
  ritorno;
- il lato di ritorno deve essere leggibile dalla logica StrategiaDiego prima
  della costruzione dell'albero relativo a quell'ingresso;
- ingressi differenti devono poter usare lati di ritorno differenti nello
  stesso progetto;
- nessuna variabile globale deve imporre un unico lato di ritorno a tutti gli
  ingressi;
- la diagnostica deve riportare, per ogni ingresso, almeno identificativo del
  tubo, verso `esterno -> stanza` e lato di ritorno associato.

### Criterio futuro di verifica

Un caso di regression con almeno due tubi di ingresso deve poter verificare:

```text
Ingresso A -> RitornoSinistra
Ingresso B -> RitornoDestra
```

senza che la configurazione del primo modifichi o sovrascriva quella del
secondo.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna proprietà runtime del lato di
ritorno per singolo ingresso è ancora implementata nella futura
StrategiaDiego.


---

## LG-011 — Albero di collegamento idraulico collettore-ingressi

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Il primo passo reale della costruzione delle spirali è la costruzione della
rete dei tubi di collegamento dal **collettore** fino ai **tratti di entrata**
nelle stanze.

Questa rete viene trattata come un **albero di collegamento idraulico**,
distinto dall'albero decisionale di StrategiaDiego definito in LG-002.

La rete di collegamento è composta da due parti con origine differente:

- **rete/albero di mandata**: fornita come input dall'utente;
- **rete/albero di ritorno**: costruita dall'algoritmo.

### Commento tecnico

Questa regola stabilisce che StrategiaDiego non parte direttamente dal primo
segmento interno della spirale.

Prima deve esistere una struttura di collegamento coerente fra collettore e
ingressi dei circuiti. La mandata costituisce un vincolo geometrico già dato,
mentre il ritorno è una geometria da determinare algoritmicamente.

Per evitare ambiguità terminologiche:

```text
AlberoDecisionale
    = struttura delle scelte StrategiaDiego (LG-002)

AlberoCollegamentoIdraulico
    = struttura fisica dei tubi collettore -> ingressi / ritorni
```

Le due strutture sono concettualmente diverse anche se entrambe possono essere
rappresentate come alberi.

### Sequenza generale

```text
input utente: rete di mandata dal collettore
        |
        v
identificazione dei tratti di entrata
        |
        v
costruzione algoritmica dell'albero di ritorno
        |
        v
rete di collegamento idraulico completa
        |
        v
costruzione degli alberi decisionali delle spirali
```

### Regola

La rete di mandata è **autorevole come input utente** e non deve essere
ridisegnata o ottimizzata implicitamente da StrategiaDiego.

L'algoritmo deve invece costruire l'albero di ritorno necessario a collegare
i ritorni dei circuiti al collettore, nel rispetto delle regole geometriche e
strategiche che verranno definite.

Il risultato di questa fase deve rendere disponibili, per ciascun tubo/tratto
di ingresso, almeno:

```text
- tratto di mandata di ingresso
- direzione convenzionale esterno -> stanza
- lato di ritorno associato (LG-010)
- collegamento di ritorno determinato dall'algoritmo
```

### Relazione con LG-004

Una volta costruita la rete di collegamento idraulico:

- la mandata entra nelle `LineeMandata` della struttura geometrica;
- il ritorno generato entra nelle `LineeRitorno`;
- entrambe diventano vincoli geometrici per la successiva costruzione delle
  spirali.

### Vincoli per la futura implementazione

- la rete di mandata deve essere acquisita senza modificarne arbitrariamente
  la topologia definita dall'utente;
- l'albero di ritorno deve essere prodotto dall'algoritmo e mantenuto distinto
  dalla mandata;
- ogni tratto di entrata deve essere riconducibile al proprio percorso di
  mandata dal collettore;
- ogni ritorno generato deve essere riconducibile al collettore;
- la costruzione dell'albero di ritorno deve precedere la generazione vera e
  propria delle spirali interne;
- la diagnostica deve distinguere chiaramente geometria di mandata fornita
  dall'utente e geometria di ritorno generata dall'algoritmo.

### Criterio futuro di verifica

Un caso di regression con più ingressi deve permettere di verificare:

```text
mandata input utente: invariata
tratti di entrata: identificati
ritorno: generato dall'algoritmo
ogni ingresso: collegato logicamente al collettore
rete di collegamento completa prima della costruzione spirali
```

### Punti ancora da definire

LG-011 non stabilisce ancora:

- l'algoritmo concreto di costruzione dell'albero di ritorno;
- i criteri di diramazione/condivisione dei tratti di ritorno;
- le priorità con cui più ritorni vengono instradati;
- il modo con cui il lato di ritorno LG-010 condiziona la topologia
  dell'albero di ritorno;
- eventuali vincoli di lunghezza o bilanciamento della rete di collegamento.

### Stato implementativo corrente

Principio documentale consolidato. L'albero di ritorno StrategiaDiego non è
ancora implementato.


---

## LG-012 — Radice dell'albero di ritorno

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Per ogni tubo/nodo di mandata d'ingresso, l'algoritmo costruisce il **nodo
radice dell'albero di ritorno** a una distanza di **0,50 m** dal nodo di
mandata.

Il vettore che unisce il nodo di mandata al nodo radice del ritorno deve essere
**parallelo alla parete architettonica più vicina**.

### Commento tecnico

La posizione iniziale del ritorno non è quindi arbitraria e non viene ricavata
da un offset globale rispetto agli assi del disegno.

Per ogni ingresso la procedura geometrica è locale:

1. si identifica il nodo di mandata di ingresso;
2. si individua la parete architettonica più vicina;
3. si costruisce una direzione parallela a tale parete;
4. lungo tale direzione si colloca la radice del ritorno a 0,50 m dal nodo di
   mandata;
5. il verso concreto della traslazione deve essere coerente con il
   `LatoRitorno` associato a quell'ingresso secondo LG-010.

### Regola

Siano:

- `M` = nodo di mandata dell'ingresso;
- `P` = parete architettonica più vicina a `M`;
- `R0` = nodo radice dell'albero di ritorno.

Deve valere:

```text
|M R0| = 0,50 m

vettore(M -> R0) // P

verso(M -> R0) coerente con LatoRitorno(M)
```

dove `//` indica parallelismo geometrico.

### Relazione con LG-010 e LG-011

LG-010 stabilisce che ogni ingresso possiede un proprio lato di ritorno.

LG-011 stabilisce che l'albero di ritorno è costruito dall'algoritmo.

LG-012 definisce la prima costruzione geometrica concreta dell'albero di
ritorno: la posizione della sua radice rispetto al nodo di mandata.

### Vincoli per la futura implementazione

- la distanza 0,50 m deve essere misurata nelle unità geometriche reali del
  modello;
- la parete di riferimento deve essere selezionata fra le linee
  architettoniche della struttura LG-004;
- il parallelismo deve essere calcolato geometricamente;
- il verso scelto deve rispettare il `LatoRitorno` del singolo ingresso;
- ingressi differenti possono quindi produrre radici del ritorno su lati
  differenti;
- la parete più vicina e la radice ottenuta devono essere diagnosticabili.

### Criterio futuro di verifica

Per ogni ingresso devono poter essere verificati almeno:

```text
nodo mandata M
parete architettonica più vicina P
LatoRitorno
nodo radice ritorno R0
distanza(M,R0) = 0,50 m
parallelismo(M->R0, P) = vero
```

Ruotando l'intera geometria del locale, la costruzione deve restare invariata
dal punto di vista geometrico relativo.

### Punti ancora da definire

LG-012 non stabilisce ancora:

- come risolvere il caso di due o più pareti equidistanti dal nodo di mandata;
- quale punto o distanza dalla parete usare per definire 'parete più vicina'
  quando la parete è un segmento finito;
- se la distanza fissa di 0,50 m debba in futuro essere parametrica;
- cosa fare se la posizione teorica di `R0` viola altre regole geometriche.

### Stato implementativo corrente

Principio documentale consolidato. La costruzione della radice dell'albero di
ritorno non è ancora implementata in StrategiaDiego.


---


## LG-013 — Primo tratto nella direzione del tubo di collegamento

**Stato:** CONSOLIDATA — RETTIFICATA 25/09/2026  
**Origine:** decisione utente del 25/09/2026; rettifica durante audit pre-sviluppo

### Proposta

Il **primo tratto** della spirale, sia di mandata sia di ritorno, non ha
inclinazione libera.

La sua direzione coincide con la direzione del rispettivo **tubo di
collegamento entrante**.

Il suo punto finale interno è inizialmente **libero** e viene determinato dalla
prima condizione geometrica di arresto utile secondo le regole di tracciamento.

### Regola

Per entrambe le famiglie:

```text
DirezionePrimoTrattoMandata = DirezioneTuboCollegamentoMandata
DirezionePrimoTrattoRitorno = DirezioneTuboCollegamentoRitorno
```

L'estremo finale del primo tratto non è fissato a priori:

```text
PuntoFinalePrimoTratto = libero
```

Il primo tratto viene quindi prolungato nella direzione del tubo entrante fino
alla linea frontale che ne determina il troncamento alla distanza di rispetto
applicabile.

### Commento tecnico

La precedente formulazione di LG-013, che ammetteva una **inclinazione libera**
del primo tratto, è superata.

L'ingresso nella spirale è una prosecuzione direzionale del tubo di
collegamento. La libertà iniziale riguarda il **punto finale**, non la
direzione.

Questo rende simmetrici mandata e ritorno e fornisce una condizione iniziale
deterministica alla costruzione dell'albero.

### Relazione con LG-016 e LG-017

Il primo tratto può essere visto come una prosecuzione nella
`DirezioneProvenienza`, coerente con il principio di `PROSEGUI_DRITTO`.

La sua estensione viene determinata applicando LG-017:

```text
direzione nota
-> ricerca prima linea frontale
-> troncamento alla distanza di rispetto
-> determinazione del punto finale
```

### Vincoli per la futura implementazione

- la direzione del tubo di collegamento entrante deve essere nota e orientata;
- la stessa regola vale per mandata e ritorno;
- il punto finale del primo tratto non deve essere preassegnato;
- il primo tratto deve rispettare intersezioni, distanze e tutte le altre
  regole di `TrattoPossibile`;
- la diagnostica deve distinguere chiaramente:
  `DirezionePrimoTratto` e `PuntoFinalePrimoTratto`.

### Precisazione runtime 25/09/2026 — prima svolta dopo il collegamento

Sul banco appartamento reale è emersa una precisazione operativa fondamentale.

Il tratto di ingresso porta il percorso sulla **prima evoluzione geometrica**
alla distanza prevista dalla parete di ingresso. Quando questa evoluzione
effettua la **prima svolta** e diventa parallela alla parete, il tratto appena
generato non deve essere prolungato fino al solo minimo generale `p/2` dalla
parete successiva.

Deve invece essere **accorciato conservando l'offset della prima evoluzione**:

```text
dIngresso = distanza raggiunta dal tratto entrante rispetto alla parete
prima svolta -> stessa distanza dIngresso dalla parete successiva
```

Nel banco corrente con `p = 0,30 m`:

```text
mandata: dIngresso = 1,5p = 0,45 m
parete destra interna x = 8,13148 m
terminale corretto prima svolta x = 8,13148 - 0,45 = 7,68148 m
```

La precedente terminazione a `x = 7,98148 m` corrispondeva invece a soli
`p/2 = 0,15 m` ed era errata per questa prima evoluzione.

Il confronto con Vittorio e GPT conferma il principio geometrico: i loro
generatori costruiscono gli offset e determinano il cambio di lato tramite la
geometria dell'offset/intersezione, ottenendo quindi l'accorciamento del tratto
prima della parete successiva. StrategiaDiego applica lo stesso **principio**,
senza copiare i loro algoritmi.

Questa eccezione è attualmente limitata alla **prima svolta dopo il tubo di
collegamento**. Estenderla automaticamente a tutte le evoluzioni ha reso
troppo restrittivi locali complessi e ha fallito la regression reale; le
evoluzioni successive continuano quindi a seguire LG-006/LG-017/LG-034.

### Criterio futuro di verifica

Un caso di regression deve verificare che:

```text
primo tratto non allineato al tubo entrante -> non ammesso
primo tratto allineato al tubo entrante     -> candidato valido
prima svolta                                -> conserva offset iniziale
punto finale                                -> determinato dal troncamento
```

### Stato implementativo corrente

Principio documentale rettificato durante l'audit pre-sviluppo. Nessuna logica
specifica della futura StrategiaDiego è ancora implementata.

---

## LG-014 — Il ritorno segue la mandata nel corridoio quando possibile

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

L'utente può usare il tubo di collegamento di mandata per coprire anche aree
del **corridoio**, cioè della stanza nella quale è collocato il nodo radice
del sistema/collettore.

Nelle evoluzioni geometriche della mandata all'interno del corridoio,
l'algoritmo del ritorno deve tentare di **seguire la mandata**.

Il ritorno segue una determinata evoluzione soltanto se il corrispondente
tratto può essere costruito senza intersecare altre linee e nel rispetto delle
regole geometriche applicabili.

Se un'evoluzione della mandata non può essere seguita, quella linea viene
**saltata** e l'algoritmo prosegue la ricerca lungo le evoluzioni successive
della mandata, riprendendo a seguirla dalla prima linea successiva per la
quale esiste un tratto possibile.

### Commento tecnico

Questa regola permette alla mandata utente di svolgere una doppia funzione:

1. collegare il collettore agli ingressi dei circuiti;
2. contribuire alla copertura termica del corridoio mediante il proprio
   percorso.

Il ritorno non deve però replicare meccanicamente tutta la mandata.
Ogni evoluzione della mandata è un riferimento candidato che deve essere
verificato rispetto allo stato geometrico corrente.

La logica è quindi:

```text
segmento/evoluzione mandata
        |
        v
esiste tratto di ritorno possibile che la segue?
        |
     SI +--> genera il tratto di ritorno corrispondente
        |
     NO +--> non forza il tratto
               |
               v
          salta questa evoluzione
               |
               v
          prova la successiva
```

Il concetto di 'seguire la mandata' deve essere letto insieme alle regole di
parallelismo e distanza già definite: il ritorno cerca un tratto parallelo
alla geometria della mandata alla distanza applicabile, senza creare
intersezioni.

### Regola

Data la sequenza ordinata delle evoluzioni della mandata nel corridoio:

```text
M1, M2, M3, ... Mn
```

per ciascuna `Mi` l'algoritmo valuta un tratto candidato di ritorno `Ri`.

```text
se Ri è possibile:
    Ri viene accettato come evoluzione del ritorno

se Ri non è possibile:
    Mi viene saltata per il ritorno
    la ricerca prosegue con Mi+1
```

Il fallimento su una singola evoluzione della mandata **non interrompe** la
costruzione dell'albero/rete di ritorno e non rende automaticamente impossibili
le evoluzioni successive.

### Relazione con LG-005, LG-006, LG-007 e LG-011

- LG-005 definisce quando un tratto è possibile;
- LG-006 definisce le distanze minime;
- LG-007 definisce le condizioni ordinarie di una scelta di nodo;
- LG-011 stabilisce che la mandata è input utente mentre il ritorno viene
  costruito dall'algoritmo.

LG-014 aggiunge la strategia di **follow-if-possible / skip-if-impossible**
per le evoluzioni della mandata nel corridoio.

### Vincoli per la futura implementazione

- l'ordine delle evoluzioni della mandata deve essere noto e percorribile dal
  collettore verso gli ingressi;
- ogni evoluzione deve essere valutata separatamente;
- un tratto di ritorno che interseca altre linee non deve essere forzato;
- il fallimento di una singola evoluzione non deve arrestare la scansione
  delle evoluzioni successive;
- la diagnostica deve indicare per ogni evoluzione almeno:
  `seguita`, `saltata`, e il motivo dell'eventuale impossibilità;
- una linea saltata non deve essere considerata implicitamente coperta da un
  tratto di ritorno inesistente.

### Criterio futuro di verifica

Un caso di regression nel corridoio deve includere una sequenza del tipo:

```text
M1 -> seguibile
M2 -> impossibile per intersezione
M3 -> seguibile
```

e verificare che il ritorno:

```text
segua M1
salti M2
riprenda da M3
```

senza forzare il tratto corrispondente a M2.

### Punti ancora da definire

LG-014 non stabilisce ancora:

- come venga realizzata geometricamente la continuità del ritorno fra due
  evoluzioni seguibili separate da una o più evoluzioni saltate;
- se un salto possa richiedere un tratto a inclinazione libera;
- come scegliere fra più possibili modalità di ricongiungimento;
- come trattare una sequenza finale nella quale nessuna delle evoluzioni
  successive risulti più seguibile.

### Stato implementativo corrente

Principio documentale consolidato. La strategia di inseguimento selettivo
della mandata nel corridoio non è ancora implementata in StrategiaDiego.


---

## LG-015 — Configurazione terminale mandata/ritorno e scelta iniziale della spirale

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Una volta completata la costruzione della **rete di ritorno**, per ogni tubo di
collegamento terminale è nota la configurazione geometrica della coppia:

- mandata;
- ritorno.

Rispetto alla direzione convenzionale del tubo di collegamento
`esterno -> stanza`, sarà quindi possibile determinare se la **mandata si trova
a destra oppure a sinistra**.

Questa informazione viene usata per determinare la **scelta iniziale** della
costruzione della spirale relativa a quell'ingresso.

### Commento tecnico

LG-015 stabilisce il punto di passaggio fra le due fasi principali:

```text
costruzione rete di collegamento idraulico
        |
        v
rete di ritorno completata
        |
        v
configurazione locale mandata/ritorno nota
        |
        v
MandataDestra oppure MandataSinistra
        |
        v
determinazione della scelta iniziale della spirale
        |
        v
costruzione albero decisionale della spirale
```

La configurazione non deve quindi essere ipotizzata in anticipo quando ancora
la rete di ritorno non è stata costruita. È la geometria risultante della rete
di collegamento a rendere nota la posizione relativa dei due tubi terminali.

### Regola

Per ogni ingresso terminale `i`, dopo il completamento della rete di ritorno:

```text
ConfigurazioneTerminale(i) =
    MandataDestra
    oppure
    MandataSinistra
```

dove destra/sinistra sono definite secondo LG-009 rispetto al verso
`esterno -> stanza`.

La `ConfigurazioneTerminale(i)` costituisce un dato di ingresso per la
determinazione del primo orientamento/scelta della spirale associata a `i`.

### Relazione con LG-009, LG-010 e LG-011

- LG-009 definisce il riferimento locale `esterno -> stanza` e il concetto di
  destra/sinistra;
- LG-010 stabilisce che ogni ingresso possiede una configurazione locale
  indipendente dagli altri;
- LG-011 stabilisce che il ritorno viene costruito dall'algoritmo;
- LG-015 precisa che, **a costruzione del ritorno terminata**, la geometria
  effettiva della coppia terminale permette di determinare il lato della
  mandata e quindi la scelta iniziale della spirale.

Le descrizioni `MandataDestra/MandataSinistra` e
`RitornoSinistra/RitornoDestra` sono complementari per la stessa coppia
terminale:

```text
MandataDestra  <=> RitornoSinistra
MandataSinistra <=> RitornoDestra
```

### Vincoli per la futura implementazione

- la configurazione terminale deve essere calcolata soltanto dopo che il
  ritorno relativo all'ingresso è geometricamente definito;
- la configurazione deve essere determinata separatamente per ogni ingresso;
- il calcolo deve usare il riferimento locale `esterno -> stanza` e non gli
  assi globali del disegno;
- la scelta iniziale della spirale deve usare la configurazione geometrica
  effettivamente ottenuta, non un valore globale o presunto;
- la diagnostica deve riportare per ogni ingresso almeno:
  identificativo, lato mandata, lato ritorno e scelta iniziale derivata.

### Criterio futuro di verifica

Per un caso con più ingressi deve essere possibile ottenere, per esempio:

```text
Ingresso A:
  MandataDestra
  RitornoSinistra
  -> scelta iniziale A

Ingresso B:
  MandataSinistra
  RitornoDestra
  -> scelta iniziale B
```

senza che la configurazione di un ingresso influenzi quella degli altri.

### Punti ancora da definire

LG-015 non stabilisce ancora la tabella completa che traduce
`MandataDestra/MandataSinistra` nella concreta prima scelta geometrica della
spirale. Tale corrispondenza sarà definita dalle successive linee guida.

### Stato implementativo corrente

Principio documentale consolidato. La derivazione della scelta iniziale dalla
configurazione terminale mandata/ritorno non è ancora implementata in
StrategiaDiego.


---

## LG-016 — Scelta di prosecuzione nella direzione di provenienza

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Tra le scelte possibili di un nodo deve essere considerata anche la
**prosecuzione nella stessa direzione di provenienza**.

Il nuovo tratto candidato parte dal nodo corrente e prosegue lungo la stessa
direzione del tratto con cui si è arrivati al nodo, fino a incontrare
frontalmente un'altra linea/tratto della struttura geometrica.

### Commento tecnico

Questa scelta rappresenta il caso naturale di avanzamento rettilineo:

```text
tratto precedente ---> [NODO] -------------------->
                          stessa direzione
```

La direzione del candidato è quindi determinata dal vettore del tratto
precedente e non richiede la ricerca di un nuovo orientamento.

Per coerenza con LG-005, LG-006 e LG-007, il termine 'incontrare frontalmente'
non autorizza l'intersezione geometrica con la linea incontrata. La linea
frontale individua il limite geometrico del candidato; il segmento prodotto
deve arrestarsi alla distanza minima applicabile rispetto alla linea
incontrata.

### Regola

Siano:

- `N` = nodo corrente;
- `v` = direzione orientata del tratto con cui si è arrivati a `N`;
- `F` = prima linea/tratto incontrato frontalmente lungo la semiretta
  `N + t*v`, con `t > 0`.

Si costruisce un candidato:

```text
StraightCandidate(N,v,F)
```

con:

```text
direzione(StraightCandidate) = v
```

e con estremo finale posto prima di `F` alla distanza minima di tracciamento
applicabile secondo la famiglia geometrica di `F` e LG-006.

Il candidato diventa ramo dell'albero soltanto se il segmento risultante è
un `TrattoPossibile` e soddisfa le condizioni applicabili di
`SceltaNodoPossibile`, **con deroga esplicita al requisito di parallelismo
con un'altra linea esistente**.

### Conseguenza sull'albero decisionale

Ad ogni nodo non terminale, quando esiste una direzione di provenienza,
StrategiaDiego deve valutare almeno la possibilità:

```text
PROSEGUI_DRITTO
```

oltre alle altre scelte che verranno definite.

Se il tratto rettilineo risultante ha lunghezza nulla, interseca linee già
generate o viola una distanza minima, questa alternativa non genera un ramo.

La scelta `PROSEGUI_DRITTO` costituisce quindi una deroga specifica alla
regola generale di parallelismo di LG-007: la sua ammissibilità deriva dalla
continuità della direzione di provenienza, non dal parallelismo con una diversa
linea di riferimento già esistente.

### Vincoli per la futura implementazione

- la direzione di provenienza deve essere conservata nello stato del nodo;
- deve essere individuata la prima geometria effettivamente frontale lungo
  tale direzione;
- la ricerca frontale deve ignorare geometrie che non intersecano la
  semiretta orientata dal nodo;
- il segmento deve terminare prima della geometria frontale alla distanza
  minima corretta (`p/2`, `p` o `2p` secondo LG-006);
- `PROSEGUI_DRITTO` non richiede il parallelismo con un'altra linea esistente;
- il candidato resta soggetto a tutte le regole di non-intersezione;
- la diagnostica deve indicare almeno nodo, direzione di provenienza,
  geometria frontale trovata, distanza applicata e lunghezza del candidato.

### Criterio futuro di verifica

Devono essere presenti casi di regression in cui:

```text
1. esiste spazio frontale sufficiente
   -> PROSEGUI_DRITTO genera un ramo;

2. la geometria frontale è già alla distanza minima
   -> lunghezza prodotta = 0
   -> nessun ramo;

3. il candidato violerebbe un'altra linea laterale/intermedia
   -> tratto non possibile
   -> nessun ramo.
```

### Punti ancora da definire

LG-016 non stabilisce ancora:

- quali altre scelte debbano essere valutate nello stesso nodo;
- l'ordine con cui le scelte vengono enumerate;
- come risolvere eventuali casi con più geometrie frontali alla stessa
  distanza;
- le tolleranze numeriche per la ricerca della geometria frontale.

### Stato implementativo corrente

Principio documentale consolidato. La scelta `PROSEGUI_DRITTO` non è ancora
implementata nella futura StrategiaDiego.


---

## LG-017 — Ogni nuovo tratto deve avere una linea frontale di arresto

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Ogni nuovo tratto candidato deve essere orientato in modo tale che la sua
**direzione teorica** incontri un'altra linea della struttura geometrica.

Il tratto reale non deve però intersecare tale linea: deve essere **troncato**
prima dell'intersezione, alla distanza di rispetto applicabile.

### Commento tecnico

LG-017 distingue due oggetti geometrici diversi:

1. **semiretta/direzione teorica** del candidato;
2. **segmento realmente generato**.

La semiretta deve intersecare una linea frontale. Questa intersezione teorica
fornisce il limite verso cui il tratto si sviluppa.

Il segmento reale termina invece prima della linea frontale:

```text
NODO ---------------------- X  linea frontale
       tratto reale      |
                         | distanza di rispetto

direzione teorica ---------------------------->
                         intersezione teorica X
```

Quindi non vi è contraddizione con le precedenti regole di non-intersezione:
l'intersezione è richiesta alla **direzione prolungata**, non al segmento
fisicamente prodotto.

### Regola

Siano:

- `N` = nodo di partenza;
- `v` = direzione candidata;
- `r(t) = N + t*v`, con `t > 0` = semiretta teorica;
- `F` = prima linea incontrata dalla semiretta nella direzione `v`;
- `dRispetto(F)` = distanza minima applicabile secondo LG-006.

Un nuovo tratto può essere generato soltanto se:

```text
esiste F tale che r interseca F frontalmente
```

e il segmento reale `S` viene costruito lungo `v` con estremo finale posto
prima di `F` alla distanza:

```text
distanza(S, F) = dRispetto(F)
```

Il segmento `S` deve poi superare tutte le altre verifiche di
`TrattoPossibile`.

### Conseguenza generale

La costruzione di un nuovo tratto segue quindi sempre lo schema:

```text
scegli direzione
      |
      v
cerca prima linea frontale
      |
   nessuna
      +--> nessun tratto generabile in quella direzione
      |
   trovata
      |
      v
calcola punto teorico di intersezione
      |
      v
arretra alla distanza di rispetto
      |
      v
costruisci segmento reale
      |
      v
verifica TrattoPossibile
```

### Relazione con LG-016

`PROSEGUI_DRITTO` è un caso particolare di LG-017:

- la direzione `v` coincide con quella di provenienza;
- non è richiesto il parallelismo con un'altra linea;
- deve comunque esistere una linea frontale;
- il tratto viene troncato alla distanza di rispetto.

LG-017 estende lo stesso principio di arresto anche alle altre scelte di nodo.

### Vincoli per la futura implementazione

- nessun nuovo tratto può estendersi indefinitamente senza una linea frontale
  di arresto;
- deve essere identificata la prima linea incontrata lungo la semiretta;
- il punto teorico di intersezione deve essere distinto dall'estremo reale del
  segmento;
- la distanza di rispetto deve dipendere dalla famiglia della linea frontale
  e dal colore/famiglia del tratto candidato, secondo LG-006;
- se l'arretramento alla distanza di rispetto produce lunghezza <= 0, il
  tratto non è possibile;
- il segmento reale non deve attraversare la linea frontale né altre linee;
- la diagnostica deve riportare direzione, linea frontale, intersezione
  teorica, distanza di rispetto ed estremo reale.

### Criterio futuro di verifica

Devono essere verificati almeno i casi:

```text
direzione con linea frontale e spazio sufficiente
-> segmento generato e troncato alla distanza corretta

direzione senza alcuna linea frontale
-> nessun tratto

linea frontale troppo vicina
-> arretramento produce lunghezza <= 0
-> nessun tratto
```

### Stato implementativo corrente

Principio documentale consolidato. La regola generale di linea frontale e
troncamento non è ancora implementata nella futura StrategiaDiego.


---

## LG-018 — Flusso generale della StrategiaDiego

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Il flusso generale di costruzione deve seguire queste fasi:

1. costruzione del **ritorno dei tubi di collegamento**;
2. costruzione delle **spirali di mandata**;
3. costruzione delle **spirali di ritorno**;
4. **potatura dei rami non ammissibili** dell'albero;
5. **generazione definitiva** della soluzione scelta.

### Commento tecnico

Il termine corretto, secondo LG-002, è **albero decisionale** e non grafo.

Le fasi sono concettualmente separate:

```text
rete mandata utente
      |
      v
[1] costruzione ritorno tubi di collegamento
      |
      v
[2] costruzione candidati spirale di mandata
      |
      v
[3] costruzione candidati spirale di ritorno
      |
      v
[4] potatura rami non ammissibili
      |
      v
valutazione terminali accettabili
      |
      v
scelta terminale a massimo fattore di merito
      |
      v
[5] generazione definitiva
```

La fase di generazione definitiva non deve introdurre nuove decisioni:
riproduce il percorso radice -> terminale vincente già determinato.

### Regola

#### Fase 1 — Ritorno dei tubi di collegamento

Partendo dalla rete di mandata fornita dall'utente, l'algoritmo costruisce
l'albero/rete di ritorno secondo LG-011, LG-012 e LG-014.

Al termine di questa fase sono note le configurazioni terminali mandata/ritorno
necessarie per iniziare le spirali (LG-015).

#### Fase 2 — Spirali di mandata

Per ogni ingresso vengono costruiti i possibili sviluppi della mandata
secondo le regole di nodo già definite:

- tratti possibili;
- distanze minime;
- scelte di nodo;
- primo tratto libero;
- prosecuzione dritta;
- linea frontale e troncamento.

Le alternative ammissibili generano i rami dell'albero.

#### Fase 3 — Spirali di ritorno

Sui rami costruiti per la mandata vengono sviluppati i corrispondenti
possibili percorsi di ritorno, mantenendo separata la geometria di ritorno
da quella di mandata e rispettando i vincoli geometrici consolidati.

LG-018 fissa l'esistenza e l'ordine di questa fase, ma non introduce ancora
regole ulteriori specifiche per il tracciamento interno del ritorno oltre a
quelle già consolidate o che saranno definite successivamente.

#### Fase 4 — Potatura

Una volta costruite le alternative geometriche previste, vengono eliminati
i rami che risultano non ammissibili.

Un ramo può essere potato quando viola una regola geometrica o strategica
consolidata oppure conduce a una configurazione che non può costituire una
soluzione valida secondo le regole applicabili.

La potatura deve essere diagnosticabile: per ogni ramo eliminato deve essere
possibile conoscere il motivo dell'esclusione.

#### Valutazione finale dei terminali

Dopo la costruzione dell'albero e la potatura, si applica LG-008:

```text
terminali rimasti
      |
      v
valutazione TerminaleAccettabile
      |
      v
filtro terminali accettabili
```

Fra i terminali accettabili si applica quindi LG-003:

```text
terminale vincente = massimo fattore di merito
```

#### Fase 5 — Generazione definitiva

Individuato il terminale vincente, la geometria definitiva viene prodotta
ripercorrendo il cammino unico:

```text
radice -> ... -> terminale vincente
```

e applicando nell'ordine le scelte memorizzate nei nodi.

### Vincoli per la futura implementazione

- le cinque fasi devono essere riconoscibili e diagnosticabili;
- la rete di ritorno dei collegamenti deve essere completata prima della
  costruzione delle spirali;
- mandata e ritorno della spirale devono restare geometricamente distinguibili;
- la potatura non deve modificare retroattivamente le regole con cui i rami
  sono stati generati;
- la valutazione dei terminali accettabili avviene dopo la costruzione
  dell'albero, secondo LG-008;
- la generazione definitiva deve essere un replay deterministico del percorso
  vincente e non una nuova ricerca.

### Criterio futuro di verifica

Per ogni elaborazione deve essere possibile produrre una diagnostica del tipo:

```text
FASE 1  ritorno collegamenti       -> completata
FASE 2  spirali mandata            -> N rami/candidati
FASE 3  spirali ritorno            -> N sviluppi
FASE 4  potatura                   -> X rami eliminati, motivazioni
        terminali accettabili      -> Y
        terminale vincente         -> id + fattore di merito
FASE 5  generazione definitiva     -> percorso radice/terminale riprodotto
```

### Punti ancora da definire

LG-018 non stabilisce ancora:

- le regole specifiche complete di costruzione della spirale di ritorno;
- tutti i criteri che rendono un ramo non ammissibile in fase di potatura;
- l'eventuale momento esatto in cui alcune invalidità manifeste possano essere
  riconosciute prima della potatura finale senza alterare l'esplorazione
  richiesta dall'albero.

### Stato implementativo corrente

Flusso generale documentale consolidato. Le fasi StrategiaDiego non sono
ancora implementate come nuovo motore runtime.


---

## LG-019 — Evoluzione delle linee guida attraverso i casi di test

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Il presente documento è una specifica viva e verrà progressivamente
**migliorato, corretto e aggiornato attraverso la valutazione dei casi di test**.

I casi reali e di regression non servono soltanto a verificare
l'implementazione: possono evidenziare limiti, ambiguità o regole mancanti
della stessa StrategiaDiego.

### Regola

Per ogni caso di test significativo:

```text
caso geometrico
      |
      v
applicazione delle linee guida correnti
      |
      v
valutazione del risultato
      |
      +--> comportamento corretto
      |       -> il caso diventa regression test
      |
      +--> comportamento incompleto/errato/ambiguo
              -> analisi della causa
              -> modifica o nuova linea guida
              -> nuovo test
```

Le linee guida devono quindi precedere e governare le modifiche algoritmiche:
se un caso richiede un nuovo comportamento strategico, la regola deve essere
prima esplicitata o corretta nel documento e poi implementata.

### Collegamento con il registro dei casi

I casi geometrici concreti continuano a essere registrati in:

`docs/spirali-strategy-register/`

Le schede `STRATEGY-NNN` costituiscono esempi verificabili delle situazioni
reali; le regole `LG-NNN` estraggono e consolidano i principi generali che
StrategiaDiego deve rispettare.

Un singolo caso può quindi:

- confermare una linea guida esistente;
- richiedere una precisazione;
- produrre una nuova linea guida;
- dimostrare che una regola precedente deve essere corretta.

### Vincoli

- non aggiornare automaticamente un risultato atteso solo perché cambia
  l'algoritmo;
- prima comprendere la differenza osservata;
- distinguere sempre difetto dell'implementazione da difetto/incompletezza
  della strategia documentata;
- mantenere tracciabili le rettifiche delle linee guida;
- trasformare i casi significativi in regression test riproducibili quando
  possibile;
- un caso di test non deve modificare silenziosamente una regola consolidata:
  la modifica deve essere registrata esplicitamente.

### Stato implementativo corrente

Principio metodologico consolidato. Il documento resta intenzionalmente
**SPECIFICA VIVA — IN DEFINIZIONE** e continuerà a evolvere insieme ai casi
di test della StrategiaDiego.


---

## LG-020 — Riferimento sussidiario a Spirali Vittorio e Spirali GPT

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Per tutti gli aspetti della StrategiaDiego **non ancora definiti
esplicitamente** nelle presenti linee guida, si assumono come riferimento i
comportamenti già esistenti nei motori:

- **Spirali Vittorio**;
- **Spirali GPT**.

### Commento tecnico

Questa regola evita vuoti interpretativi durante la fase di definizione
progressiva della StrategiaDiego.

Il riferimento a Vittorio e GPT è però **sussidiario**:

- una regola Diego esplicita prevale sempre;
- Vittorio/GPT servono solo dove Diego non ha ancora definito il
  comportamento;
- il riferimento non implica che i due motori debbano essere copiati o
  modificati;
- se Vittorio e GPT si comportano in modo diverso sullo stesso punto non
  definito, la differenza deve essere resa esplicita e risolta con una nuova
  linea guida Diego.

### Regola

```text
se esiste una regola LG-NNN applicabile:
    usare StrategiaDiego

altrimenti:
    consultare Spirali Vittorio e Spirali GPT come riferimento

se Vittorio e GPT concordano:
    usare quel comportamento come riferimento provvisorio

se Vittorio e GPT divergono:
    non scegliere implicitamente
    documentare il caso
    definire una nuova regola StrategiaDiego
```

### Gerarchia delle fonti

La priorità interpretativa è:

```text
1. regole esplicite StrategiaDiego LG-NNN
2. casi attivi STRATEGY-NNN collegati
3. riferimento Spirali Vittorio / Spirali GPT
4. nuova decisione da consolidare se permane ambiguità
```

### Vincoli

- Vittorio e GPT restano strategie concorrenti e indipendenti;
- nessun comportamento non definito deve essere inventato senza prima
  verificare i due riferimenti esistenti;
- una divergenza fra Vittorio e GPT deve produrre una decisione esplicita
  prima di essere consolidata in StrategiaDiego;
- il riferimento sussidiario non deve introdurre modifiche silenziose alle
  regole Diego già consolidate;
- quando un comportamento provvisorio viene successivamente formalizzato in
  una LG-NNN, la nuova regola sostituisce il riferimento sussidiario per quel
  punto.

### Stato implementativo corrente

Principio documentale consolidato. Questa regola governa l'interpretazione
della specifica durante la fase di definizione e futura implementazione della
StrategiaDiego.


---

## LG-021 — Enumerazione completa delle linee di riferimento a ogni nodo [SUPERATA DA LG-023]

**Stato:** RETTIFICATA DA LG-023  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

Ad ogni nodo dell'albero decisionale, StrategiaDiego deve considerare come
possibili riferimenti **tutte le linee presenti nella struttura geometrica di
contenimento**.

Per ciascuna linea candidata si applica la distanza di rispetto prevista dalla
sua famiglia e dal colore/famiglia del nuovo tratto.

### Regola

Per ogni nodo `N`:

```text
per ogni linea L in LineeArchitettoniche:
    genera/valuta candidato alla distanza p/2

per ogni linea L in LineeMandata:
    se nuovo tratto = mandata -> distanza 2p
    se nuovo tratto = ritorno -> distanza p

per ogni linea L in LineeRitorno:
    se nuovo tratto = ritorno -> distanza 2p
    se nuovo tratto = mandata -> distanza p
```

Ogni candidato viene poi sottoposto alle restanti regole di
`TrattoPossibile`, `SceltaNodoPossibile`, linea frontale e non-intersezione.

### Commento tecnico

Non viene quindi applicato un filtro preliminare del tipo 'solo linea più
vicina' o 'solo linee locali'. L'enumerazione dei riferimenti è completa;
sono le verifiche geometriche successive a eliminare le alternative non
ammissibili.

Questo rende l'albero esaustivo rispetto alle linee disponibili nello stato
corrente e riduce il rischio di perdere una soluzione valida per una scelta
locale troppo anticipata.

### Vincoli

- la struttura di contenimento del nodo deve esporre tutte le linee correnti;
- ogni linea deve mantenere la propria famiglia semantica;
- la distanza di rispetto deve essere calcolata per ogni coppia
  candidato/riferimento;
- candidati equivalenti generati da riferimenti diversi potranno richiedere in
  futuro una regola di deduplicazione, non ancora definita;
- l'enumerazione completa non autorizza la generazione di rami che violano le
  altre regole consolidate.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. La logica di
enumerazione completa non è ancora implementata.


---


## LG-022 — Direzione di provenienza ed estremo libero del primo tratto

**Stato:** CONSOLIDATA — RETTIFICATA 25/09/2026  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

Ogni stato/nodo della StrategiaDiego dispone di un parametro esplicito:

```text
DirezioneProvenienza
```

che rappresenta la direzione orientata con cui il percorso corrente arriva al
nodo.

Nella condizione iniziale, sia per mandata sia per ritorno, il **primo tratto**
mantiene la stessa direzione del rispettivo tubo di collegamento entrante.

Il suo punto finale interno è invece **libero** e viene determinato soltanto
dalla successiva condizione geometrica di arresto.

### Regola

```text
DirezionePrimoTratto = DirezioneProvenienza
PuntoFinalePrimoTratto = non ancora fissato
```

Il punto finale viene determinato quando la semiretta orientata incontra la
prima linea frontale valida e il tratto viene troncato alla distanza di rispetto
applicabile.

### Commento tecnico

Questa regola separa nettamente:

1. **direzione**, già determinata dal tubo di collegamento;
2. **lunghezza/punto finale**, ancora da determinare geometricamente.

Non è quindi necessario scegliere una nuova inclinazione per entrare nella
spirale.

### Relazione con LG-013, LG-016 e LG-017

- LG-013 stabilisce che il primo tratto prosegue nella direzione del tubo
  entrante;
- LG-016 descrive la prosecuzione nella direzione di provenienza;
- LG-017 determina il punto finale tramite linea frontale e troncamento.

### Vincoli per la futura implementazione

- `DirezioneProvenienza` deve essere un dato orientato;
- mandata e ritorno seguono la stessa regola iniziale;
- il primo tratto deve poter esistere con punto finale non ancora determinato;
- il punto finale viene materializzato solo dopo l'individuazione della linea
  frontale e del relativo troncamento;
- la diagnostica deve distinguere direzione nota ed estremo ancora libero.

### Stato implementativo corrente

Principio documentale rettificato durante l'audit pre-sviluppo. La gestione
runtime non è ancora implementata.

---

## LG-023 — Linea di riferimento determinata dal troncamento del tratto precedente

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026; rettifica LG-021

### Proposta

Una nuova linea non ha un vincolo di orientamento rispetto alla
`DirezioneProvenienza`.

Per le scelte ordinarie basate sul parallelismo, però, non devono essere
provate tutte le linee della struttura geometrica.

Sono candidabili soltanto le linee che possono generare, alla distanza di
rispetto applicabile, una parallela che abbia come **punto di partenza il
terminale del tratto precedente**.

Da questa condizione consegue che, salvo il caso `PROSEGUI_DRITTO`, la linea
di riferimento possibile è normalmente una sola: **la linea che ha troncato
il tratto precedente**.

### Commento tecnico

Il terminale del tratto precedente nasce precisamente perché la sua direzione
teorica ha incontrato una linea frontale ed è stata arrestata alla distanza
di rispetto da quella linea (LG-017).

Quella stessa linea frontale diventa quindi il riferimento naturale per la
scelta successiva: la nuova parallela alla distanza richiesta passa per il
terminale già determinato.

Non è necessario, né corretto, enumerare tutte le altre linee della struttura
alla ricerca di parallele arbitrarie.

### Regola

Siano:

- `Sprev` = tratto precedente;
- `Tprev` = terminale di `Sprev`;
- `Fprev` = linea frontale che ha troncato `Sprev`;
- `d` = distanza di rispetto applicabile rispetto a `Fprev`.

Per una scelta ordinaria con cambio direzione:

```text
NuovaLinea = parallela(Fprev, distanza d) passante per Tprev
```

Se tale costruzione geometrica non è possibile o non produce un
`TrattoPossibile`, non si apre il ramo corrispondente.

Non esiste una scelta fra due parallele arbitrarie: il fatto che la nuova
linea debba passare per `Tprev` determina il lato corretto rispetto a
`Fprev`.

### Eccezione — PROSEGUI_DRITTO

La scelta `PROSEGUI_DRITTO` non usa `Fprev` come riferimento di parallelismo.

In quel caso:

```text
NuovaDirezione = DirezioneProvenienza
```

e si applica la deroga al parallelismo già consolidata in LG-016.

### Relazione con LG-021

LG-023 **rettifica LG-021**.

La precedente formulazione che prevedeva di considerare tutte le linee della
struttura come riferimenti di parallelismo non è più valida.

La struttura completa resta comunque necessaria per:

- individuare la prima linea frontale;
- verificare distanze e intersezioni;
- determinare se il nuovo tratto è possibile.

Ma il riferimento per il cambio di direzione è vincolato dalla geometria del
troncamento precedente.

### Vincoli per la futura implementazione

- ogni tratto deve conservare quale linea frontale lo ha troncato;
- il terminale del tratto precedente deve essere noto prima di costruire la
  scelta successiva;
- la nuova parallela deve passare per tale terminale;
- non si devono generare parallele rispetto a linee che non soddisfano questa
  condizione;
- `PROSEGUI_DRITTO` resta l'unica scelta corrente che deroga a questa regola
  di riferimento;
- la diagnostica deve riportare almeno `Fprev`, `Tprev`, distanza applicata e
  nuova linea generata.

### Criterio futuro di verifica

Per un nodo successivo a un tratto troncato da una linea `Fprev`, deve essere
verificabile che:

```text
riferimento del cambio direzione = Fprev
nuova parallela passa per Tprev
nessun'altra linea viene usata come riferimento alternativo
```

salvo il ramo `PROSEGUI_DRITTO`.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. LG-021 è
rettificata su questo punto; la logica runtime non è ancora implementata.


---

## LG-024 — Entrambi i versi della nuova parallela generano rami

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

Una volta determinata la nuova linea parallela passante per il terminale del
tratto precedente, StrategiaDiego deve considerare **entrambi i versi** lungo
tale linea.

I due versi generano due alternative distinte dell'albero decisionale, purché
il tratto risultante soddisfi le condizioni geometriche minime applicabili.

### Commento tecnico

La strategia non deve eliminare anticipatamente un verso soltanto perché
appare sfavorevole o perché si prevede che possa bloccare successivamente lo
sviluppo del ritorno.

Anche una scelta potenzialmente 'catastrofica' deve essere esplorata come ramo
se, nel momento in cui viene generata, è geometricamente ammissibile.

L'eventuale impossibilità futura viene rilevata nelle fasi successive:

- sviluppo della spirale di ritorno;
- potatura dei rami non ammissibili;
- valutazione dei terminali accettabili.

### Regola

Siano:

- `Tprev` = terminale del tratto precedente;
- `Lnew` = nuova parallela determinata secondo LG-023;
- `v` e `-v` = i due versi possibili lungo `Lnew`.

StrategiaDiego genera e valuta:

```text
candidato A = da Tprev lungo +v
candidato B = da Tprev lungo -v
```

Per ciascun candidato si applicano indipendentemente:

- ricerca della linea frontale;
- troncamento alla distanza di rispetto;
- controllo `TrattoPossibile`;
- controllo di non-intersezione.

Ogni candidato che supera i controlli correnti genera un ramo distinto.

### Divieto di potatura anticipata per previsione

Non è ammesso eliminare un ramo soltanto perché:

```text
'probabilmente il ritorno non passerà'
```

oppure perché una euristica prevede un esito sfavorevole.

La potatura deve basarsi su una condizione geometrica/strategica realmente
verificata nelle fasi previste dal flusso LG-018.

### Relazione con LG-018

LG-024 rafforza il carattere esplorativo della fase di costruzione della
mandata:

```text
costruzione mandata
-> conserva tutti i rami attualmente ammissibili
-> costruzione ritorno
-> emergono eventuali blocchi
-> potatura
-> terminali accettabili
-> scelta per fattore di merito
```

### Vincoli per la futura implementazione

- i due versi devono essere rappresentati come alternative indipendenti;
- nessuna euristica di convenienza può sostituire i controlli geometrici
  effettivi;
- se entrambi i versi sono possibili devono sopravvivere entrambi fino alle
  fasi successive;
- se uno dei due versi è immediatamente impossibile secondo le regole già
  consolidate, soltanto quello viene scartato;
- la diagnostica deve riportare entrambi i candidati e il motivo dell'eventuale
  esclusione di ciascuno.

### Criterio futuro di verifica

Un caso di regression deve includere almeno una situazione in cui:

```text
verso A -> mandata geometricamente possibile ma ritorno successivamente bloccato
verso B -> mandata e ritorno completabili
```

e verificare che il ramo A venga inizialmente costruito e venga eliminato solo
nella fase corretta, non anticipatamente.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. La generazione
dei due versi non è ancora implementata nella futura StrategiaDiego.


---

## LG-025 — Condizione di terminale dell'albero di mandata

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

Un nodo dell'albero di mandata diventa **terminale** quando, dopo aver
valutato tutte le alternative previste per quel nodo, nessuna genera un nuovo
`TrattoPossibile`.

Le alternative da valutare sono:

1. `PROSEGUI_DRITTO` secondo LG-016;
2. primo verso della nuova parallela determinata da LG-023;
3. secondo verso della stessa parallela secondo LG-024.

### Regola

Per un nodo `N`:

```text
Candidati(N) = {
    PROSEGUI_DRITTO,
    PARALLELA_VERSO_A,
    PARALLELA_VERSO_B
}
```

Dopo l'applicazione delle regole geometriche:

```text
se esiste almeno un candidato che produce un TrattoPossibile:
    N non è terminale
    ogni candidato valido genera un ramo

se nessun candidato produce un TrattoPossibile:
    N è terminale dell'albero di mandata
```

### Commento tecnico

Il terminale non viene deciso per euristica, convenienza o previsione sul
ritorno. È la completa assenza di prosecuzioni geometricamente ammissibili
secondo le scelte previste a rendere terminale il nodo.

Questa regola mantiene separati:

- arresto naturale della costruzione della mandata;
- successiva costruzione della spirale di ritorno;
- potatura dei rami non ammissibili;
- valutazione finale dei terminali accettabili.

### Vincoli per la futura implementazione

- tutte e tre le categorie di scelta devono essere valutate prima di
  dichiarare il nodo terminale;
- l'ordine di valutazione non deve cambiare il fatto che tutte le alternative
  ammissibili vengano conservate;
- un candidato escluso deve avere una motivazione diagnostica;
- un nodo con almeno un candidato valido non può essere classificato come
  terminale;
- la classificazione terminale deve essere riproducibile a parità di stato
  geometrico.

### Criterio futuro di verifica

Devono essere presenti casi di regression in cui:

```text
1. solo PROSEGUI_DRITTO è possibile
   -> nodo non terminale

2. solo uno dei due versi paralleli è possibile
   -> nodo non terminale

3. più alternative sono possibili
   -> più rami

4. nessuna alternativa è possibile
   -> nodo terminale della mandata
```

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. La condizione
di terminale dell'albero di mandata non è ancora implementata.


---

## LG-026 — Origine della costruzione della spirale di ritorno

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

La costruzione della **spirale di ritorno** non parte dal terminale raggiunto
dalla spirale di mandata.

Essa parte invece dal **tubo di collegamento di ritorno** già generato nella
fase iniziale di costruzione della rete dei tubi di collegamento.

### Commento tecnico

Questa regola mantiene separate le due origini fisiche del circuito:

```text
mandata  -> parte dal tubo di collegamento di mandata
ritorno  -> parte dal tubo di collegamento di ritorno
```

Il tubo di collegamento di ritorno è quindi la condizione iniziale autorevole
per lo sviluppo della spirale di ritorno interna alla stanza.

Il terminale della mandata non è il punto di partenza del ritorno: resta una
geometria già costruita con cui la successiva evoluzione del ritorno dovrà
risultare compatibile e, nella soluzione finale, richiudibile secondo le
regole dei terminali accettabili.

### Regola

Per ogni ingresso/circuito `i`:

```text
OrigineMandata(i) = tubo di collegamento mandata(i)

OrigineRitorno(i) = tubo di collegamento ritorno(i)
                    generato nella fase LG-011/LG-012/LG-014
```

La costruzione della spirale di ritorno deve quindi iniziare dalla geometria
terminale del tubo di collegamento di ritorno già disponibile dopo la fase 1
del flusso generale LG-018.

### Relazione con LG-018

La sequenza viene precisata come:

```text
FASE 1  costruzione ritorno tubi di collegamento
        -> definisce OrigineRitorno

FASE 2  costruzione spirale di mandata
        -> produce i rami/terminali della mandata

FASE 3  costruzione spirale di ritorno
        -> parte da OrigineRitorno
        -> si sviluppa rispetto alla geometria già presente
```

### Vincoli per la futura implementazione

- ogni circuito deve mantenere il riferimento al proprio tubo di collegamento
  di ritorno;
- l'estremo interno di tale tubo costituisce l'origine geometrica della
  spirale di ritorno;
- la spirale di ritorno non deve essere inizializzata dal terminale della
  mandata;
- geometria di mandata e ritorno devono restare distinte durante la
  costruzione;
- la diagnostica deve riportare per ogni circuito l'origine della mandata e
  l'origine del ritorno.

### Punti ancora da definire

LG-026 non stabilisce ancora:

- le scelte di nodo specifiche della spirale di ritorno;
- il criterio con cui il ritorno si avvicina e si richiude verso la mandata;
- se le stesse regole di esplorazione della mandata si applichino integralmente
  anche alla costruzione del ritorno.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. La costruzione
della spirale di ritorno dalla propria origine non è ancora implementata.


---

## LG-027 — Mandata e ritorno usano la stessa strategia di nodo

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

La costruzione della spirale di ritorno usa la **stessa strategia di nodo**
della spirale di mandata.

Le due costruzioni differiscono per:

- origine geometrica;
- famiglia/colore del tubo;
- geometria già presente nello stato;

ma non per il meccanismo con cui vengono generate le alternative di ciascun
nodo.

### Regola

Per mandata e ritorno, a ogni nodo vengono considerate le stesse categorie di
scelta:

```text
1. PROSEGUI_DRITTO
2. PARALLELA_VERSO_A
3. PARALLELA_VERSO_B
```

con le stesse regole generali già consolidate:

- direzione di provenienza esplicita;
- linea frontale di arresto;
- troncamento alla distanza di rispetto;
- riferimento di parallelismo determinato dalla linea che ha troncato il
  tratto precedente;
- entrambi i versi della nuova parallela;
- nessuna potatura predittiva;
- terminale quando nessuna alternativa produce un `TrattoPossibile`.

### Commento tecnico

Il comportamento geometrico resta quindi simmetrico a livello di algoritmo.

Le differenze emergono automaticamente dalla struttura di contenimento:

```text
nuovo tratto mandata:
  stessa famiglia -> 2p
  ritorno         -> p

nuovo tratto ritorno:
  stessa famiglia -> 2p
  mandata         -> p
```

Non serve quindi introdurre un secondo algoritmo decisionale specifico per il
ritorno.

### Relazione con LG-026

LG-026 stabilisce che il ritorno parte dal proprio tubo di collegamento.

LG-027 stabilisce che, una volta definita tale origine, lo sviluppo successivo
usa la stessa logica della mandata.

### Vincoli per la futura implementazione

- la logica di generazione delle scelte di nodo deve essere condivisibile fra
  mandata e ritorno;
- il tipo/famiglia del tubo corrente deve essere un parametro dello stato;
- le distanze di rispetto devono essere calcolate in funzione della famiglia
  corrente, non mediante due algoritmi separati;
- eventuali future eccezioni specifiche del ritorno dovranno essere dichiarate
  esplicitamente da una nuova linea guida.

### Criterio futuro di verifica

Uno stesso stato geometrico equivalente, scambiando coerentemente i ruoli
mandata/ritorno, deve produrre la stessa struttura di scelte di nodo, salvo le
differenze di distanza derivanti dalla famiglia delle linee presenti.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. La logica
condivisa mandata/ritorno non è ancora implementata.


---

## LG-028 — Ogni terminale della mandata prosegue con il proprio albero dei ritorni

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

Ogni terminale dell'albero di mandata non conclude l'esplorazione complessiva.

Da ciascun terminale di mandata deve proseguire la costruzione di un
**albero dei possibili ritorni**, usando come geometria già presente e vincolo
fisico il ramo di mandata che ha condotto a quel terminale.

### Regola

Siano:

- `Tm1, Tm2, ... Tmn` = terminali dell'albero di mandata;
- `Path(Tmi)` = percorso di mandata radice -> Tmi.

Per ogni terminale:

```text
Tm_i
  -> mantiene fissa la geometria Path(Tm_i)
  -> inizializza il ritorno dalla OrigineRitorno del circuito (LG-026)
  -> costruisce tutte le prosecuzioni di ritorno con la strategia LG-027
  -> produce uno o più terminali complessivi mandata+ritorno
```

L'albero complessivo può quindi essere visto come:

```text
albero mandata
   |
   +-- terminale mandata A
   |      +-- albero ritorno A
   |
   +-- terminale mandata B
   |      +-- albero ritorno B
   |
   +-- ...
```

### Commento tecnico

Questa scelta rende la StrategiaDiego esaustiva rispetto alle combinazioni
mandata/ritorno: una mandata apparentemente buona può produrre ritorni
impossibili, mentre una mandata meno intuitiva può consentire un ritorno più
lungo o più completo.

Il costo computazionale può crescere rapidamente, perché il numero totale di
soluzioni candidate è approssimativamente il prodotto fra:

```text
numero di terminali mandata
x
numero medio di sviluppi del ritorno per terminale
```

e ciascuna delle due fasi può a sua volta avere crescita combinatoria per
effetto dei rami multipli.

### Sostenibilità computazionale

La strategia resta considerata corretta e da implementare in forma esaustiva.
Non vengono introdotte potature predittive o euristiche solo per ridurre il
calcolo, perché violerebbero LG-024.

Durante lo sviluppo dovranno però essere misurati almeno:

```text
numero nodi mandata
numero terminali mandata
numero nodi ritorno per terminale mandata
numero terminali complessivi
profondità massima
tempo di calcolo
memoria utilizzata
```

Se i casi di test dimostreranno una crescita non sostenibile, l'ottimizzazione
dovrà preservare esattamente lo spazio delle soluzioni ammissibili oppure
essere prima definita come nuova regola StrategiaDiego.

### Vincoli per la futura implementazione

- ogni terminale mandata deve mantenere il proprio stato geometrico completo;
- il ritorno relativo a un terminale non deve usare la geometria di un altro
  ramo di mandata;
- ogni albero di ritorno parte dalla stessa OrigineRitorno del circuito, ma
  viene valutato contro la specifica geometria del ramo mandata associato;
- nessun terminale mandata può essere escluso solo per ridurre il numero di
  combinazioni;
- la diagnostica deve permettere di ricondurre ogni terminale complessivo al
  terminale mandata da cui deriva.

### Criterio futuro di verifica

Un regression test con almeno due terminali mandata deve verificare che:

```text
terminale mandata A -> proprio insieme di ritorni
terminale mandata B -> proprio insieme di ritorni
```

e che nessuno dei due venga saltato per ragioni di ottimizzazione preventiva.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. La sostenibilità
computazionale dovrà essere misurata sui casi di test prima di introdurre
eventuali ottimizzazioni.


---

## LG-029 — Valutazione preliminare della chiusura e verifica avanzata successiva

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

In fase preliminare, l'accettabilità della chiusura fra estremo mandata ed
estremo ritorno viene valutata con un criterio semplice e rapido.

Il test preliminare usa il **collegamento rettilineo diretto** fra i due
estremi e verifica che tale segmento non intersechi altre linee.

In una fase successiva verrà definita una valutazione più approfondita delle
chiusure possibili, distinguendo quelle realmente realizzabili da quelle che
devono essere considerate irrealizzabili.

### Regola preliminare

Siano:

- `Mend` = estremo terminale della mandata;
- `Rend` = estremo terminale del ritorno;
- `C0` = segmento rettilineo diretto `Mend -> Rend`.

In fase preliminare:

```text
ChiusuraPreliminarePossibile =
    EsisteSegmento(Mend, Rend)
    AND
    NonIntersecaAltreLinee(C0)
```

Se il test è positivo, il terminale può essere considerato preliminarmente
accettabile ai fini dell'audit e della prima implementazione.

### Valutazione avanzata futura

La futura verifica avanzata potrà considerare, tra l'altro:

- forme di chiusura non rettilinee;
- raccordi geometrici;
- raggi minimi o curvature;
- distanze di rispetto lungo tutta la chiusura;
- interferenze locali;
- fattibilità costruttiva reale;
- casi in cui il segmento diretto fallisce ma esiste una chiusura alternativa;
- casi in cui il segmento diretto passa ma la chiusura reale non è comunque
  realizzabile.

Questi criteri non sono ancora definiti e non devono essere inventati
implicitamente nella prima implementazione.

### Relazione con LG-008

LG-029 precisa che la definizione corrente di `TerminaleAccettabile` di LG-008
va interpretata, nella prima implementazione, come **valutazione preliminare**.

La classificazione definitiva delle chiusure verrà raffinata quando saranno
definite le regole avanzate.

### Vincoli

- la prima implementazione deve mantenere separati il test preliminare e la
  futura verifica avanzata;
- il risultato diagnostico deve indicare che l'accettabilità è preliminare;
- un esito negativo del test diretto non deve essere considerato per sempre
  una prova assoluta di irrealizzabilità: potrà essere rivalutato quando
  esisteranno le regole avanzate;
- allo stesso modo, un esito positivo preliminare non sostituisce la futura
  verifica costruttiva dettagliata.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. La verifica
avanzata delle chiusure resta da progettare.


---

## LG-030 — StrategiaDiego come strategia computazionalmente pesante e selezionabile

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

StrategiaDiego viene classificata come strategia **computazionalmente
pesante**, perché esplora in modo esteso l'albero delle alternative di mandata
e, per ogni terminale di mandata, i relativi alberi di ritorno.

Non deve quindi essere necessariamente la strategia predefinita per ogni
progetto.

### Modalità di selezione

StrategiaDiego può essere attivata in almeno due casi:

1. **scelta esplicita dell'utente**;
2. **progetto compatibile**, quando una valutazione preliminare della
   complessità indica che l'esplorazione completa è sostenibile.

### Regola

```text
se utente seleziona Diego:
    usa StrategiaDiego

altrimenti se progetto è classificato compatibile con StrategiaDiego:
    StrategiaDiego può essere resa disponibile/proposta secondo la politica
    di selezione dell'applicazione

altrimenti:
    usare una strategia alternativa più leggera (Vittorio o GPT)
    secondo la scelta/configurazione disponibile
```

### Commento tecnico

La classificazione 'pesante' non modifica le regole geometriche della
StrategiaDiego e non autorizza potature euristiche interne.

Serve invece a governare **quando** conviene usare questo motore rispetto alle
strategie alternative.

In particolare, la selezione esterna della strategia deve restare separata
dalla logica interna dell'albero decisionale.

### Metriche candidate per la compatibilità del progetto

La soglia concreta non è ancora definita. La futura valutazione potrà
considerare, ad esempio:

- numero di circuiti;
- numero di locali;
- complessità geometrica della pianta;
- numero di segmenti architettonici;
- numero stimato di nodi/rami;
- limiti di tempo e memoria disponibili;
- storico misurato sui regression test.

Queste metriche sono candidate e non costituiscono ancora una regola di
selezione automatica.

### Vincoli per la futura implementazione

- `Vittorio`, `GPT` e `Diego` devono restare strategie selezionabili in modo
  esplicito;
- l'utente deve poter forzare `Diego` anche quando il progetto è stimato
  pesante, salvo eventuali limiti tecnici assoluti da definire;
- la classificazione automatica del progetto non deve cambiare il risultato
  di StrategiaDiego, ma solo la sua disponibilità/proposta;
- eventuali limiti assoluti di sicurezza computazionale devono essere
  documentati separatamente e non introdotti implicitamente;
- le decisioni automatiche di selezione devono essere diagnostiche e
  tracciabili.

### Punti ancora da definire

- soglia concreta che distingue un progetto compatibile/non compatibile;
- comportamento dell'interfaccia quando Diego è stimata troppo onerosa;
- eventuale fallback automatico oppure richiesta di scelta utente;
- limiti massimi di nodi, tempo o memoria.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. Nessuna logica
di stima automatica della complessità è ancora implementata.


---

## LG-031 — Geometria vincolante durante la costruzione del ritorno

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

Durante la costruzione dell'albero di ritorno associato a uno specifico
terminale della mandata, la geometria vincolante è costituita da:

- tutte le linee architettoniche;
- l'intero ramo di mandata che conduce a quel terminale;
- tutti i tratti di ritorno già generati lungo il ramo di ritorno corrente.

### Regola

Per un dato terminale mandata `Tm` e per un nodo corrente del ritorno:

```text
GeometriaVincolanteRitorno =
    LineeArchitettoniche
    + PathMandata(Tm)
    + PathRitornoCorrente
```

Ogni nuovo candidato di ritorno deve essere verificato rispetto a questa
geometria completa, applicando le distanze di rispetto previste dalle regole
già consolidate.

### Commento tecnico

Il ramo di mandata selezionato per quel terminale viene quindi congelato come
geometria fisica già costruita durante l'intera esplorazione dei possibili
ritorni.

Analogamente, ogni nuovo tratto di ritorno diventa immediatamente parte della
geometria vincolante dei nodi successivi dello stesso ramo.

Non devono invece essere considerate come ostacoli le geometrie appartenenti
a rami alternativi della mandata o del ritorno che non fanno parte del
percorso corrente.

### Distanze applicabili

Per un nuovo tratto di ritorno:

```text
rispetto a linea architettonica -> p/2
rispetto a linea di mandata     -> p
rispetto a linea di ritorno     -> 2p
```

oltre alle verifiche di intersezione, linea frontale e `TrattoPossibile`.

### Vincoli per la futura implementazione

- ogni stato del ritorno deve mantenere il riferimento al proprio
  `PathMandata(Tm)`;
- ogni ramo di ritorno deve possedere il proprio `PathRitornoCorrente`;
- la verifica geometrica deve essere locale allo stato del ramo corrente;
- geometrie appartenenti a rami alternativi non devono contaminare il ramo
  in esame;
- la diagnostica deve permettere di ricostruire quali linee erano vincolanti
  per ogni candidato valutato.

### Criterio futuro di verifica

Un regression test deve verificare che due alberi di ritorno derivati da due
terminali mandata differenti vedano geometrie vincolanti differenti, ciascuna
coerente con il proprio ramo di mandata.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. La gestione
dello stato geometrico per ramo non è ancora implementata.


---

## LG-032 — Geometria vincolante durante la costruzione della mandata

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026

### Proposta

Durante la costruzione di uno specifico ramo dell'albero di mandata, la
geometria vincolante è costituita da:

- tutte le linee architettoniche;
- i soli tratti di mandata già generati lungo il ramo corrente.

I rami alternativi dell'albero di mandata non devono essere considerati come
ostacoli reciproci.

### Regola

Per un nodo corrente della mandata:

```text
GeometriaVincolanteMandata =
    LineeArchitettoniche
    + PathMandataCorrente
```

Ogni nuovo candidato di mandata viene verificato rispetto a tale geometria
locale di ramo.

### Commento tecnico

Ogni ramo dell'albero rappresenta una soluzione alternativa e indipendente.

Le geometrie appartenenti a rami fratelli non esistono nello stesso scenario
fisico e quindi non devono influenzare collisioni, distanze o linee frontali
del ramo in esame.

Ogni nuovo tratto valido entra immediatamente nel `PathMandataCorrente` del
proprio ramo e diventa vincolante per i nodi successivi di quel ramo.

### Distanze applicabili

Per un nuovo tratto di mandata:

```text
rispetto a linea architettonica -> p/2
rispetto a linea di mandata     -> 2p
```

Il ritorno non è ancora presente nella fase di costruzione della mandata e
quindi non entra nella geometria vincolante di questa fase.

### Relazione con LG-031

LG-032 è la regola simmetrica di LG-031:

```text
mandata -> architettura + PathMandataCorrente
ritorno -> architettura + PathMandata(Tm) + PathRitornoCorrente
```

### Vincoli per la futura implementazione

- ogni nodo di mandata deve possedere il proprio stato geometrico di ramo;
- rami alternativi non devono condividere mutazioni geometriche;
- collisioni e distanze devono essere calcolate solo contro la geometria
  appartenente allo scenario corrente;
- la diagnostica deve identificare il percorso di mandata associato a ogni
  nodo/candidato.

### Criterio futuro di verifica

Un regression test con biforcazione della mandata deve verificare che un
segmento generato nel ramo A non impedisca una scelta geometricamente valida
nel ramo B.

### Stato implementativo corrente

Principio documentale consolidato durante l'audit pre-sviluppo. Lo stato
geometrico isolato per ramo di mandata non è ancora implementato.


---
## LG-033 — Inseguimento progressivo dell'evoluzione precedente nei percorsi convessi

**Stato:** CONSOLIDATA NEL PRINCIPIO — DETTAGLIO IN AUDIT  
**Origine:** audit pre-sviluppo del 25/09/2026

### Caso fondamentale

Nei percorsi convessi, dopo che la spirale ha compiuto il primo giro può
raggiungere nuovamente la propria evoluzione iniziale.

Esempio concettuale:

```text
tubo di collegamento
    -> S1
    -> S2
    -> S3
    -> ...

dopo il primo giro:
    il nuovo tratto raggiunge S1
    -> segue S1 alla distanza prevista
    -> successivamente deve inseguire S2
    -> poi S3
    -> ...
```

Il comportamento corretto non è quindi un semplice inseguimento dell'ostacolo
geometricamente più vicino, ma un **inseguimento progressivo dei tratti della
precedente evoluzione della spirale**.

### Principio

Quando un ramo convesso rientra verso una propria evoluzione precedente:

1. individua il tratto precedente raggiunto, eventualmente anche tramite il
   prolungamento geometrico della sua retta;
2. genera il nuovo tratto parallelo a quello raggiunto, alla distanza di
   rispetto applicabile;
3. durante l'avanzamento, il successivo riferimento atteso è il tratto che
   segue quello appena inseguito nella sequenza della precedente evoluzione;
4. il processo può continuare progressivamente sui tratti successivi
   `S1 -> S2 -> S3 -> ...`.

### Significato della troncatura

La linea che determina la troncatura non rappresenta soltanto un ostacolo
fisico. Nei percorsi convessi può anche rappresentare un **marcatore geometrico
di aggancio** alla precedente evoluzione della spirale.

Per questo la ricerca può utilizzare:

```text
segmento reale
+
prolungamento della retta del segmento
```

mentre la verifica finale di collisione continua a usare la geometria fisica
reale.

### Relazione con LG-023

LG-023 resta valida per il cambio direzione locale: il nuovo tratto parallelo
nasce dal riferimento che ha determinato il troncamento.

LG-033 aggiunge però una nozione di **sequenza dei riferimenti** nei percorsi
convessi: una volta agganciata una precedente evoluzione, il tracciamento deve
poter inseguire ordinatamente i suoi tratti successivi.

### Conseguenza per il modello dati

La futura implementazione dovrà poter conservare, oltre alla sola geometria,
anche l'identità/sequenza dei tratti del percorso già costruito, ad esempio:

```text
SegmentId
PrecedenteSegmentId
SuccessivoSegmentId
ordine nel Path corrente
```

in modo da sapere quale tratto viene inseguito e quale rappresenta il
successivo riferimento naturale.

### Punto ancora da definire

Resta da fissare durante l'audit se, una volta entrati in modalità di
inseguimento convesso, il **successivo tratto della sequenza precedente** debba
avere priorità assoluta come riferimento oppure se debba restare una delle
alternative dell'albero decisionale insieme alle altre scelte geometricamente
possibili.

### Stato implementativo corrente

Principio strategico consolidato; la regola operativa completa
dell'inseguimento convesso non è ancora implementata.


---

## LG-034 — Troncatura concava/convessa: regola ortogonale e generalizzazione geometrica

**Stato:** CONSOLIDATA — PRECISATA DOPO CONFRONTO VITTORIO/GPT  
**Origine:** audit pre-sviluppo del 25/09/2026

### Principio iniziale

Nel caso ortogonale, dato:

- `I` = intersezione teorica con la linea di riferimento, anche ottenuta tramite
  il suo prolungamento;
- `d` = distanza di rispetto;
- verso positivo = `DirezioneProvenienza`;

vale:

```text
caso concavo  -> T = I - d
caso convesso -> T = I + d
```

Questa resta la regola intuitiva e il caso di test fondamentale a 90 gradi.

### Precisazione derivata dai motori esistenti

Il confronto con i motori esistenti mostra che `I ± d` non deve essere usato
come formula universale per angoli arbitrari.

**Vittorio** costruisce i vertici degli offset usando normali ai segmenti e
bisettrice del vertice. La distanza del vertice offset dipende quindi
dall'angolo fra i segmenti e non coincide in generale con un semplice
spostamento `d` lungo il tratto entrante.

**SpiraliGPT** rende questo principio più robusto costruendo gli offset tramite
buffer negativo NetTopologySuite con `JoinStyle.Mitre`. Il vertice di cambio
è quindi ottenuto geometricamente dall'incontro delle linee parallele offset,
anche in presenza di lati inclinati e concavità.

StrategiaDiego adotta questa proprietà geometrica come principio, senza copiare
l'algoritmo di nessuno dei due motori.

### Regola generale

Nel caso di inseguimento di una precedente evoluzione:

- `S_k` = segmento precedente attualmente inseguito;
- `S_{k+1}` = segmento successivo della stessa evoluzione;
- `Lcur` = retta del tratto Diego corrente, parallela a `S_k`;
- `LnextOffset` = retta parallela a `S_{k+1}` posta alla distanza di
  rispetto applicabile sul lato coerente con l'offset corrente.

Il punto reale di cambio è:

```text
T = Intersezione(Lcur, LnextOffset)
```

Il punto teorico senza offset è:

```text
I = Intersezione(Lcur, Retta(S_{k+1}))
```

La classificazione rispetto al verso corrente è determinata da:

```text
delta = dot(T - I, DirezioneProvenienzaNormalizzata)

delta < 0 -> CONCAVO
delta > 0 -> CONVESSO
|delta| <= tolleranza -> NEUTRO / DEGENERE
```

Quindi la proprietà fondamentale è il **segno** dello spostamento rispetto a
`I`, non il fatto che il suo modulo sia sempre uguale a `d`.

### Caso ortogonale

Se `S_k` e `S_{k+1}` sono ortogonali, la costruzione geometrica si riduce
esattamente a:

```text
CONCAVO  -> delta = -d
CONVESSO -> delta = +d
```

e quindi recupera integralmente la formulazione originaria.

### Angoli non ortogonali

Per angoli diversi da 90 gradi il modulo di `delta` dipende dall'angolo.

Non deve essere forzato a `d`: il punto corretto è sempre l'intersezione
delle parallele offset. Questo preserva la distanza normale `d` dai segmenti
di riferimento ed evita errori sui tratti inclinati.

### Relazione con LG-017 e LG-033

LG-017 viene precisata: la linea di troncamento può essere individuata anche
tramite il prolungamento geometrico della linea di riferimento.

LG-033 fornisce l'ordine `S_k -> S_{k+1}` della precedente evoluzione da
inseguire.

LG-034 stabilisce dove collocare il terminale del tratto corrente quando si
passa dal riferimento `S_k` al riferimento `S_{k+1}`.

### Vincoli per la futura implementazione

- non usare un semplice `I ± d` per geometrie oblique;
- costruire la parallela offset del segmento successivo alla distanza corretta;
- usare segmenti e loro prolungamenti per la costruzione teorica;
- usare la geometria fisica reale per collisioni e intersezioni vietate;
- classificare concavo/convesso rispetto alla `DirezioneProvenienza`;
- mantenere una tolleranza esplicita per casi quasi paralleli o degeneri;
- la diagnostica deve registrare almeno `S_k`, `S_{k+1}`, `I`, `T`,
  `delta`, distanza di rispetto e classificazione.

### Stato implementativo corrente

Principio geometrico consolidato durante l'audit pre-sviluppo dopo confronto
con i motori Vittorio e GPT. Nessuna logica runtime StrategiaDiego è ancora
implementata.


---
## LG-035 — Criterio computabile di inseguimento concavo/convesso

**Stato:** CONSOLIDATA  
**Origine:** audit pre-sviluppo del 25/09/2026, confronto diretto con Spirali Vittorio e Spirali GPT

### Conclusioni del confronto

Il motore Vittorio e il motore GPT non espongono una variabile esplicita
`Concavo/Convesso`, ma entrambi contengono il principio geometrico necessario:

- **Vittorio** genera offset tramite normali e bisettrici e percorre in sequenza
  i vertici dell'offset;
- **GPT** genera offset robusti tramite buffer negativo con giunzione
  `Mitre`, conserva la continuità della componente e sceglie raccordi
  geometricamente validi;
- entrambi confermano che il cambio fra due evoluzioni deve essere definito
  dalla geometria delle **parallele offset**, non da una correzione cartesiana
  fissa;
- GPT conferma inoltre la necessità di trattare correttamente lati inclinati,
  concavità, strettoie e raccordi senza introdurre diagonali arbitrarie.

StrategiaDiego rende esplicito e tracciabile questo principio all'interno
dell'albero decisionale.

### Dati necessari

Per un inseguimento della precedente evoluzione devono essere noti:

```text
S_k          segmento di riferimento attualmente seguito
S_k+1        successivo segmento della stessa precedente evoluzione
Ucur         DirezioneProvenienza normalizzata del nuovo tratto
d            distanza di rispetto applicabile
latoOffset   lato geometrico sul quale corre il nuovo tratto rispetto a S_k
```

L'identità di `S_k` e `S_k+1` deriva dalla sequenza del path richiesta da
LG-033.

### Costruzione code-ready

1. Costruire la retta infinita di `S_k+1`.
2. Costruire la sua parallela alla distanza `d`, scegliendo il lato coerente
   con l'offset sul quale il nuovo tubo sta già inseguendo `S_k`.
3. Intersecare tale parallela con la retta corrente `Lcur`.
4. Il risultato è il punto reale di cambio `T`.
5. Intersecare `Lcur` anche con la retta non offset di `S_k+1`, ottenendo
   il punto teorico `I`.
6. Calcolare:

```text
delta = dot(T - I, Ucur)
```

7. Classificare:

```text
delta < -eps -> CONCAVO
delta > +eps -> CONVESSO
altrimenti   -> NEUTRO/DEGENERE
```

### Criterio equivalente tramite orientamento

Quando serve diagnosticare il motivo della classificazione, si può usare anche
il prodotto vettoriale 2D.

Siano:

- `Uk` = verso orientato di `S_k` nella precedente evoluzione;
- `Uk1` = verso orientato di `S_k+1`;
- `q = sign(dot(Ucur, Uk))` = indica se il nuovo tubo sta seguendo `S_k`
  nello stesso verso oppure nel verso opposto;
- `side` = segno del lato sul quale il nuovo tubo si trova rispetto a
  `S_k`;
- `turn = sign(cross(Uk, Uk1))`.

Allora, fuori dai casi degeneri:

```text
q * side * turn > 0 -> CONCAVO
q * side * turn < 0 -> CONVESSO
```

La costruzione tramite intersezione delle parallele resta comunque la fonte
geometrica autorevole per il punto `T`.

### Perché non basta la linea più vicina

Nel percorso convesso il prossimo riferimento non è scelto solo per distanza.
Una volta agganciato `S_k`, il riferimento naturale è `S_k+1`, cioè il
segmento successivo della precedente evoluzione.

Il suo prolungamento può determinare il cambio anche se il segmento fisico non
raggiunge ancora la retta corrente.

Questa distinzione è indispensabile per il caso:

```text
ingresso -> primo giro -> riaggancio S1 -> inseguimento S1
         -> cambio su S2 -> inseguimento S2 -> cambio su S3 -> ...
```

### Geometria teorica e geometria fisica

Devono essere mantenuti due ruoli distinti:

```text
geometria teorica:
    segmenti + prolungamenti
    serve a determinare I, T e il riferimento successivo

geometria fisica:
    soli segmenti realmente presenti
    serve per collisioni, distanze e validità del TrattoPossibile
```

Una intersezione con un prolungamento può quindi creare un nodo strategico
senza rappresentare una collisione fisica.

### Casi degeneri da gestire

La futura implementazione deve trattare esplicitamente:

- `S_k` e `S_k+1` quasi collineari;
- parallela offset di `S_k+1` parallela a `Lcur`;
- distanza nulla o inferiore alla tolleranza;
- cambio che produce `T` dietro il punto corrente;
- miter geometricamente molto lungo per angoli prossimi a 180 gradi;
- punto `T` geometricamente definito ma tratto reale non valido per
  collisioni/distanze.

Questi casi non autorizzano correzioni euristiche silenziose: devono essere
diagnosticati e sottoposti alle normali regole dell'albero.

### Riferimento ai motori esistenti

Per questa specifica regola:

- da **Vittorio** si conserva il principio delle normali/bisettrici e della
  sequenza ordinata dell'offset;
- da **GPT** si assume come riferimento preferibile la geometria robusta
  dell'offset mitrato e la validazione dei raccordi;
- StrategiaDiego non riusa i loro algoritmi di scelta locale: rende invece
  esplicite tutte le alternative nell'albero e conserva la tracciabilità del
  riferimento `S_k -> S_k+1`.

### Stato implementativo corrente

Definizione sufficientemente precisa per progettare le primitive geometriche
della futura StrategiaDiego. Non ancora implementata, compilata o testata.

---

## LG-036 — Verifica visuale obbligatoria delle modifiche che cambiano il disegno

**Stato:** CONSOLIDATA  
**Origine:** direttiva operativa utente del 25/09/2026

### Proposta

Ogni modifica a StrategiaDiego che possa alterare il disegno prodotto deve
essere verificata sul banco prova corrente tramite GitHub Actions e deve
produrre un SVG reale che l'utente possa esaminare visivamente.

### Commento tecnico

Per StrategiaDiego la sola riuscita della compilazione o dei test numerici non
è sufficiente a dimostrare che una modifica geometrica sia corretta.

Una modifica può rispettare invarianti, limiti computazionali e validazioni
automatiche e produrre comunque un percorso geometricamente indesiderato.
Per questo motivo l'output grafico costituisce una prova obbligatoria aggiuntiva
ogni volta che il cambiamento può influire su mandata, ritorno, troncature,
inseguimenti, raccordi, scelta dei rami, distanze o disposizione finale dei
tubi.

### Regola consolidata

Il banco prova operativo autorevole è:

```text
tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl
```

Ogni modifica che **può cambiare il disegno** deve seguire il ciclo:

```text
modifica
  ↓
GitHub Actions
  ↓
fixture StrategiaDiegoCurrentApartment.project.tmdl
  ↓
TERMODEL_SPIRAL_ENGINE=Diego
  ↓
POST /api/calculations?responseArtifact=pannelli-esecutivo-svg
  ↓
pannelli-esecutivo.svg reale
  ↓
restituzione dell'SVG all'utente per verifica visuale
```

La chat non deve limitarsi a comunicare SUCCESS, hash, numero di primitive,
metriche o log: deve recuperare l'**SVG effettivamente prodotto dalla Action**
e renderlo disponibile all'utente in forma visualizzabile.

### Vincoli

- la fixture autorevole non viene modificata dal test;
- l'eventuale canonicalizzazione viene applicata soltanto alla copia temporanea
  preparata dall'harness;
- il test deve usare esplicitamente StrategiaDiego;
- se la Action fallisce, la modifica non è verificata;
- se la Action riesce ma l'SVG non è recuperabile, la verifica visuale non è
  completata;
- quando esiste una baseline precedente pertinente, il nuovo SVG deve poter
  essere confrontato con il precedente;
- il nuovo SVG **non diventa automaticamente un Golden geometrico**: la sua
  approvazione visuale resta distinta dalla semplice riuscita tecnica;
- modifiche esclusivamente documentali o tecniche che non possono cambiare il
  disegno non richiedono l'esecuzione di questo ciclo.

### Criterio di verifica

Per ogni futuro incarico con impatto possibile sul disegno devono risultare
tutti presenti:

1. commit della modifica;
2. GitHub Action conclusa con successo sul banco prova corrente;
3. esecuzione con `TERMODEL_SPIRAL_ENGINE=Diego`;
4. produzione reale di `pannelli-esecutivo.svg`;
5. recupero dell'SVG prodotto dalla stessa Action;
6. restituzione dell'SVG all'utente per l'esame visuale;
7. eventuale confronto prima/dopo quando utile alla diagnosi.

In assenza di uno di questi elementi la modifica non va dichiarata
**verificata visualmente**.

### Stato implementativo corrente

La procedura tecnica necessaria esiste già: il banco prova appartamento,
l'harness `tools/smoke-strategia-diego-current-apartment.ps1`, la risposta
diretta `responseArtifact=pannelli-esecutivo-svg` e l'artifact CI
`strategia-diego-current-apartment` sono operativi.

LG-036 rende obbligatorio usare tale percorso e restituire l'SVG all'utente
per ogni successiva modifica con possibile effetto sul disegno.

---

## Collegamento con il registro dei casi

La futura StrategiaDiego dovrà rispettare tutte le schede del registro con
stato **ATTIVA**, a partire da:

- `STRATEGY-001 — Imbottigliamento selettivo mandata/ritorno`.

Un caso del registro può quindi diventare un test specifico della
StrategiaDiego senza obbligare Vittorio o GPT a essere riscritti secondo la
stessa soluzione algoritmica.

---

## Punti successivi

Questa sezione viene aggiornata durante il confronto. I prossimi principi
saranno aggiunti come `LG-037`, `LG-038`, ecc., mantenendo per ciascuno:

- proposta;
- commento tecnico;
- regola consolidata;
- vincoli;
- criterio di verifica;
- stato implementativo.
