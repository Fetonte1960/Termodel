# STRATEGY-001 — Imbottigliamento selettivo mandata/ritorno

Stato: **ATTIVA**  
Data: **2026-09-24**  
Motore interessato: `SpiraliGPT`  
Progetto di riferimento: `RadiantPanelsReference`  
Tipo: **regola strategica geometrica**

## Immagine di riferimento

![Dettaglio del collo di bottiglia selettivo](images/STRATEGY-001-imbottigliamento-selettivo.png)

File conservato:
`images/STRATEGY-001-imbottigliamento-selettivo.png`.

## Osservazione che definisce la strategia

Il caso nasce dal **superamento di un imbottigliamento**.

Nel comportamento atteso i due rami non sono equivalenti:

- il **ritorno blu** può superare l'imbottigliamento quando può entrare nella
  zona oltre il collo e successivamente uscirne;
- la **mandata rossa** deve invece evitare l'imbottigliamento creato dal
  ritorno quando, una volta entrata, non avrebbe spazio/topologia utile per
  entrare e uscire e completare correttamente la copertura.

Questa differenza è intenzionale e deve essere conservata dalle future
strategie.

## Principio strategico

> La raggiungibilità geometrica di una regione non è sufficiente per
> autorizzare la mandata a coprirla.

Una regione oltre un collo di bottiglia deve essere valutata anche rispetto
alla possibilità di **ingresso, prosecuzione e uscita** dei due rami.

Il ritorno può attraversare il collo se il suo percorso resta continuo e può
entrare e uscire rispettando i vincoli geometrici.

La mandata non deve occupare quella regione quando il ritorno già definisce
l'imbottigliamento e l'ingresso della mandata produrrebbe un percorso senza
uscita/prosecuzione compatibile.

## Interpretazione topologica

Il caso va trattato come **imbottigliamento selettivo**, non come semplice
riduzione locale della larghezza e non come semplice errore di proiezione fra
offset.

La strategia deve distinguere:

1. area geometricamente interna al locale;
2. area raggiungibile da un singolo ramo;
3. area effettivamente copribile dalla coppia mandata/ritorno senza perdere la
   possibilità di proseguire e chiudere il circuito.

Una zona può quindi essere:

- percorribile dal ritorno;
- non utilizzabile dalla mandata per ulteriore copertura.

## Comportamento ammesso

È ammesso che il ritorno blu attraversi il collo e sviluppi il proprio
percorso oltre l'imbottigliamento quando:

- esiste una continuità geometrica di ingresso;
- esiste una continuità geometrica di uscita/prosecuzione;
- non vengono violati interasse, perimetro, raggi di curvatura o vincoli di
  intersezione.

## Comportamento vietato

La mandata rossa non deve essere fatta entrare oltre il collo soltanto perché
un offset interno esiste ancora geometricamente.

In particolare è vietata una strategia che:

- massimizzi la superficie coperta senza considerare la possibilità di uscita;
- faccia attraversare alla mandata il passaggio già reso selettivo dal ritorno;
- crei una mandata intrappolata oltre il collo;
- produca una chiusura artificiale o un attraversamento successivo soltanto per
  recuperare una scelta topologicamente sbagliata.

## Conseguenza per l'algoritmo

Questa scheda **non prescrive ancora un algoritmo numerico specifico** e non
stabilisce una soglia universale di larghezza del collo.

Qualunque algoritmo futuro è accettabile soltanto se riproduce la strategia:

- il ritorno può usare il collo quando possiede un percorso ingresso/uscita;
- la mandata deve riconoscere il ritorno come vincolo che può rendere la zona
  oltre il collo non più copribile;
- la decisione deve dipendere dalla topologia disponibile, non soltanto dalla
  presenza di un offset successivo.

## Relazione con il difetto osservato

Sul progetto regression pannelli il motore corrente può arrestarsi durante il
passaggio fra offset e lasciare una grande area centrale senza spirali.

La correzione futura non deve limitarsi a "far entrare più anelli". Prima deve
rispettare questa regola: **l'eventuale prosecuzione oltre l'imbottigliamento
può essere corretta per il ritorno e contemporaneamente scorretta per la
mandata**.

Questa scheda serve quindi anche a impedire una correzione eccessiva che
riempia indiscriminatamente la zona centrale.

## Criteri di verifica per nuove strategie

Una nuova strategia geometrica deve essere considerata compatibile con
STRATEGY-001 soltanto se, sul caso di riferimento:

1. identifica il collo di bottiglia come vincolo topologico;
2. consente al ritorno di attraversarlo quando esiste un percorso valido di
   ingresso e uscita;
3. non forza la mandata oltre il collo quando questa non dispone della stessa
   libertà topologica;
4. mantiene interasse, perimetro e raggi di curvatura;
5. non introduce auto-intersezioni o incroci mandata/ritorno;
6. non risolve il caso riducendo arbitrariamente il passo;
7. non considera "migliore" una soluzione soltanto perché aumenta la superficie
   coperta;
8. conserva un esecutivo coerente con l'immagine e con la strategia descritta
   in questa scheda.

## Collegamento al regression test

Il progetto reale consolidato resta:

`Server/Termodelwebservice/tests/fixtures/RadiantPanelsReference.original.part01..04.txt`

con runner:

`Server/Termodelwebservice/tools/smoke-radiant-reference.ps1`.

I futuri regression test geometrici dovranno poter associare esplicitamente
questo caso a `STRATEGY-001`, così una nuova soluzione non potrà essere
considerata corretta soltanto perché compila o produce un SVG.
