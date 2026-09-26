# StrategiaDiego — Debug dell'albero e Decision Reject Replay

Data consolidamento: **26/09/2026**

Questo documento definisce il sistema unico di debug della StrategiaDiego.
Lo scopo non è costruire SVG alternativi né forzare a mano una geometria:
si osserva e si guida il **vero albero di ricerca** del motore, lasciando che
StrategiaDiego continui a valutare autonomamente tutte le alternative residue.

## 1. Modello mentale

Il motore esplora una rete ad albero. Ogni nodo rappresenta uno stato
geometrico raggiunto; ogni arco figlio rappresenta una decisione reale del
motore (PROSEGUI_DRITTO, PARALLELA_A, PARALLELA_B o scelta equivalente sul
ramo Supply/Return).

Per ogni decisione accettabile il motore produce una **Decision Key canonica**.
La chiave descrive geometria e semantica stabili e non dipende da timestamp,
GUID o numeri progressivi di nodo. Il numero di nodo resta utile per leggere
un singolo run, ma non è un identificatore persistente di una scelta.

## 2. Strumenti complementari

**Supply Explorer** ordina le mandate pure con la stessa funzione usata dal
motore ed esporta rank, metriche, percorso, Decision Key e SVG.

**Solution Explorer** mantiene il Supply rank richiesto e cerca il miglior
Return compatibile; esporta SVG rosso+blu, metriche e Decision Key di entrambi
i rami.

**Branch Inspector** mostra il percorso fino a un nodo e le continuazioni
realmente tentate, accettate o respinte dal motore.

**Decision Reject Replay** modifica solo il set delle decisioni ammesse nel
debug. Una Decision Key presente nel file di replay viene rifiutata prima
della creazione del figlio; il resto dell'albero continua normalmente.

## 3. Invarianti obbligatorie

1. Senza reject, risultato e ranking devono rimanere invariati.
2. Il rifiuto avviene prima di creare il figlio.
3. Ogni rifiuto produce DIEGO_DECISION_REPLAY REJECT_BY_INPUT.
4. Se un nodo perde tutti i figli solo per replay, non diventa un falso
   terminale: PRUNED_BY_REPLAY ... terminalCreated=false.
5. Più Decision Key possono essere accumulate nello stesso file.
6. Lo stesso meccanismo vale per Supply e Return.
7. Il risultato da osservare è sempre lo SVG standard del motore reale.
8. Explorer, Inspector e Replay non devono introdurre una seconda geometria.
9. Un Golden Result non va aggiornato per nascondere differenze prodotte dal
   replay.
10. Le Decision Key importanti vanno conservate insieme al caso di test.

## 4. Replay

Formato: file UTF-8, una Decision Key per riga.

Opzione Harness:

    --reject-decisions <file.txt>

Scorciatoia per il setup Supply attualmente migliore tra quelli residui:

    --reject-current-supply

La scorciatoia può essere usata insieme a un file esistente: carica i reject
già accumulati, individua il nuovo setup corrente, aggiunge la sua Decision Key
terminale e riesegue il vero motore.

## 5. Workflow operativo standard

    RUN NORMALE
       |
       v
    Supply/Solution Explorer oppure Branch Inspector
       |
       v
    individua la decisione da contestare
       |
       v
    copia Decision Key
       |
       v
    aggiungi al reject file
       |
       v
    riesegui stesso input con Decision Reject Replay
       |
       v
    verifica REJECT_BY_INPUT / PRUNED_BY_REPLAY
       |
       v
    osserva SVG standard della migliore soluzione residua
       |
       +--> soddisfacente: conserva fotografia del test
       |
       +--> non soddisfacente: aggiungi un'altra Decision Key e ripeti

Solo dopo aver confrontato più rami reali si decide se esiste una regola
geometrica generale da modificare nel motore.

## 6. Comando umano convenuto

Quando l'utente dice **scarta questo setup mandata**, la chat deve:

1. prendere la Decision Key terminale del setup Supply attualmente mostrato;
2. aggiungerla ai reject già attivi;
3. rieseguire lo stesso caso;
4. presentare il nuovo top della classifica residua;
5. mantenere i reject precedenti per le richieste successive.

Due richieste consecutive significano quindi: elimina il rank 1; poi, senza
perdere il primo rifiuto, elimina anche il nuovo top residuo.

## 7. Collaudi di riferimento

### Replay singolo

Sul quadrato LG041 il rank 1 è stato escluso tramite Decision Key terminale e
il nuovo top è risultato esattamente il precedente rank 2. Il log contiene
REJECT_BY_INPUT e PRUNED_BY_REPLAY. Replay automatico e replay da file hanno
prodotto SVG byte-identico, mentre la baseline senza reject è rimasta invariata.

### Replay cumulativo

Il collaudo finale deve verificare:

- baseline con almeno tre setup;
- esclusione rank 1;
- con il primo reject ancora attivo, esclusione del nuovo setup corrente
  (precedente rank 2);
- nuovo top uguale al precedente rank 3;
- file cumulativo con due Decision Key distinte;
- riesecuzione del solo file cumulativo con SVG byte-identico al secondo
  rifiuto interattivo.

Il risultato reale viene registrato nel registro StrategiaDiego e nel Summary
Service.

## 8. Confini

Questa infrastruttura è **debug**, non una nuova strategia. Non modifica
Vittorio o GPT e non autorizza automaticamente merge della StrategiaDiego in
main. Il branch sperimentale della PR #8 resta il luogo di collaudo algoritmico
fino a un'autorizzazione separata.
