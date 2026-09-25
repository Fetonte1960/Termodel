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
saranno aggiunti come `LG-005`, `LG-006`, ecc., mantenendo per ciascuno:

- proposta;
- commento tecnico;
- regola consolidata;
- vincoli;
- criterio di verifica;
- stato implementativo.
