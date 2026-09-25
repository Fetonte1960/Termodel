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
saranno aggiunti come `LG-003`, `LG-004`, ecc., mantenendo per ciascuno:

- proposta;
- commento tecnico;
- regola consolidata;
- vincoli;
- criterio di verifica;
- stato implementativo.
