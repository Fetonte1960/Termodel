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

## LG-002 — StrategiaDiego come grafo decisionale

**Stato:** CONSOLIDATA  
**Origine:** decisione utente del 25/09/2026

### Proposta

La struttura fondamentale della **StrategiaDiego** è un **grafo**.

- i **nodi** rappresentano situazioni in cui esiste una scelta strategica;
- i **terminali** rappresentano situazioni in cui non esiste più una scelta
  strategica da compiere.

### Commento tecnico

Questa impostazione separa in modo netto due concetti:

1. **riconoscere lo stato geometrico corrente**;
2. **decidere fra alternative ammissibili**.

La StrategiaDiego non deve quindi diventare una sequenza opaca di condizioni
annidate. Le decisioni devono essere rappresentabili come nodi espliciti del
grafo, con archi che descrivono le alternative selezionabili a partire da
quella situazione.

Un terminale non significa necessariamente soltanto "spirale completata".
Significa più precisamente **assenza di scelta strategica**. Una volta
raggiunto un terminale, l'esito o l'azione successiva è deterministica: per
esempio completamento del percorso, applicazione di una costruzione obbligata
oppure dichiarazione che non esiste una prosecuzione valida.

Non viene ancora imposto che il grafo sia un albero. La forma a grafo permette,
se utile, che decisioni differenti confluiscano successivamente nella stessa
situazione strategica. L'eventuale ammissibilità di cicli verrà definita in una
linea guida successiva e non è stabilita da LG-002.

### Modello concettuale

```text
                [stato geometrico]
                        |
                 scelta necessaria
                        |
                    [NODO]
                   /  |   \
                  /   |    \
             scelta A | scelta C
                /     |       \
             [...]  [...]     [...]
                \     |       /
                 \    |      /
                 [nuovo stato]
                        |
               scelta necessaria?
                  /           \
                SI             NO
                |               |
             [NODO]       [TERMINALE]
```

### Regola

Un elemento della StrategiaDiego appartiene a una delle due categorie
strategiche fondamentali:

**Nodo decisionale**
- descrive una situazione riconoscibile;
- dispone di almeno due alternative strategiche ammissibili;
- ogni alternativa è rappresentata da un arco del grafo;
- la scelta deve essere motivabile usando dati geometrici/stato disponibili.

**Terminale**
- descrive una situazione riconoscibile;
- non presenta alternative strategiche da confrontare;
- non possiede archi di scelta in uscita;
- attiva un comportamento deterministico o produce un esito determinato.

La domanda che separa le due categorie è:

```text
"In questa situazione esistono almeno due comportamenti strategicamente
ammissibili fra cui scegliere?"

SI  -> nodo
NO  -> terminale
```

### Vincoli per la futura implementazione

- ogni nodo deve avere un'identità stabile e leggibile;
- ogni arco deve corrispondere a una scelta esplicita e descrivibile;
- la condizione che porta a un nodo o a un terminale deve essere verificabile;
- la decisione presa deve poter essere registrata in diagnostica;
- la stessa situazione strategica non deve essere implementata in più punti
  nascosti del codice se può essere rappresentata da un unico nodo;
- i terminali non devono introdurre nuove scelte non dichiarate internamente:
  ciò che accade dopo il terminale deve essere deterministico rispetto allo
  stato ricevuto;
- il grafo decisionale deve essere separato dalla geometria di basso livello:
  le funzioni geometriche possono misurare, verificare e costruire, ma non
  devono nascondere decisioni strategiche che appartengono al grafo.

### Criterio futuro di verifica

Durante l'esecuzione di StrategiaDiego deve essere possibile ricostruire almeno
la sequenza:

```text
stato iniziale
-> nodo visitato
-> scelta/arco selezionato
-> ...
-> terminale raggiunto
-> esito deterministico
```

Per un caso di regression, a parità di input e parametri, il percorso nel grafo
deve essere riproducibile e diagnosticabile.

### Punti ancora da definire

LG-002 non stabilisce ancora:

- quali siano i primi nodi concreti;
- quali dati compongano lo "stato" passato fra i nodi;
- la regola con cui una scelta viene preferita alle altre;
- se il grafo possa contenere cicli;
- quali tipi di terminale debbano essere formalizzati.

Questi elementi verranno definiti con le successive linee guida.

### Stato implementativo corrente

Principio documentale consolidato. Nessuna struttura dati del grafo e nessuna
classe StrategiaDiego sono ancora implementate.

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
