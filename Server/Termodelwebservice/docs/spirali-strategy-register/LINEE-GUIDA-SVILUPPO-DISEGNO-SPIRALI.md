# Linee guida per lo sviluppo del disegno spirali

Classificazione: **SPECIFICA VIVA — IN DEFINIZIONE**  
Ambito: Termodel / pannelli radianti / generazione geometrica spirali  
Destinazione prevista: futura strategia/classe **StrategiaDiego**

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

## LG-013 — Primo tratto a inclinazione libera

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

Nella costruzione della spirale, il **primo tratto** può avere
**inclinazione libera**.

A partire dal **secondo tratto**, le nuove scelte devono invece rispettare le
regole di parallelismo previste dalla StrategiaDiego.

### Commento tecnico

LG-013 introduce un'eccezione esplicita alla regola generale di LG-007.

Il primo tratto serve a portare la costruzione dalla condizione iniziale verso
la geometria utile alla spirale e non è obbligato a essere parallelo a una
linea esistente.

Dal secondo tratto in poi, invece, ogni scelta torna nel regime ordinario:

```text
tratto n = 1  -> inclinazione libera
tratto n >= 2 -> parallelismo obbligatorio secondo LG-007
```

L'inclinazione libera del primo tratto non significa assenza di regole:
il segmento deve comunque rispettare tutte le altre condizioni applicabili,
in particolare validità geometrica, non intersezione e distanze minime.

### Regola

Per il tratto candidato `s_n` in posizione `n` lungo il percorso:

```text
se n = 1:
    parallelismo non obbligatorio
    restano obbligatorie le altre regole di tracciamento

se n >= 2:
    parallelismo obbligatorio
    SceltaNodoPossibile secondo LG-007
```

### Relazione con LG-005, LG-006 e LG-007

Il primo tratto deve comunque essere un `TrattoPossibile` secondo LG-005 e
rispettare le distanze minime di LG-006.

L'unica deroga introdotta da LG-013 riguarda il requisito di parallelismo di
LG-007.

Dal secondo tratto in poi LG-007 torna applicabile integralmente.

### Vincoli per la futura implementazione

- la posizione del tratto nella sequenza deve essere nota;
- soltanto il primo tratto può essere esentato dal requisito di parallelismo;
- il primo tratto non può bypassare controlli di intersezione o distanze;
- dal secondo tratto in poi ogni ramo deve essere generato rispetto a una
  linea di riferimento valida;
- la diagnostica deve indicare esplicitamente quando viene applicata
  l'eccezione `PrimoTrattoInclinazioneLibera`.

### Criterio futuro di verifica

Un caso di regression deve verificare almeno:

```text
tratto 1 non parallelo ma geometricamente valido -> ammesso
tratto 2 non parallelo                         -> non ammesso
tratto 2 parallelo e conforme                  -> ammesso
```

### Punti ancora da definire

LG-013 non stabilisce ancora:

- come venga scelta l'inclinazione concreta del primo tratto;
- se esistano direzioni preferenziali per il primo tratto;
- come l'inclinazione iniziale interagisca con la direzione principe LG-009.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna logica specifica per il primo
tratto a inclinazione libera è ancora implementata in StrategiaDiego.


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
un `TrattoPossibile` e soddisfa le altre condizioni di
`SceltaNodoPossibile`.

### Conseguenza sull'albero decisionale

Ad ogni nodo non terminale, quando esiste una direzione di provenienza,
StrategiaDiego deve valutare almeno la possibilità:

```text
PROSEGUI_DRITTO
```

oltre alle altre scelte che verranno definite.

Se il tratto rettilineo risultante ha lunghezza nulla, interseca linee già
generate o viola una distanza minima, questa alternativa non genera un ramo.

### Vincoli per la futura implementazione

- la direzione di provenienza deve essere conservata nello stato del nodo;
- deve essere individuata la prima geometria effettivamente frontale lungo
  tale direzione;
- la ricerca frontale deve ignorare geometrie che non intersecano la
  semiretta orientata dal nodo;
- il segmento deve terminare prima della geometria frontale alla distanza
  minima corretta (`p/2`, `p` o `2p` secondo LG-006);
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
saranno aggiunti come `LG-017`, `LG-018`, ecc., mantenendo per ciascuno:

- proposta;
- commento tecnico;
- regola consolidata;
- vincoli;
- criterio di verifica;
- stato implementativo.
