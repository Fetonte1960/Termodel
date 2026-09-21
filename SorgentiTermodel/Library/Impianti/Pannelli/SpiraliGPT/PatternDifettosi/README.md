# Catalogo pattern difettosi SpiraliGPT

Questo catalogo conserva i casi geometrici sospesi durante lo sviluppo del
motore `SpiraliGPT`. Le strategie annotate sono ipotesi di lavoro e non
decisioni vincolanti: verranno confrontate con altri pattern prima di
intervenire nuovamente sull'algoritmo.

## SPGPT-PAT-001 — raccordo in rientranza concava obliqua

Stato: **sospeso**  
Progetto di origine: `Workbanch spirali`  
Ambito osservato: locale/circuito 3  
Motore: `SpiraliGPT`

### Screenshot conservato

![Dettaglio del raccordo anomalo](SPGPT-PAT-001-raccordo-concavo.png)

File originale memorizzato nel catalogo:
`SPGPT-PAT-001-raccordo-concavo.png`.

### Descrizione fornita dall'utente

Il pattern «produce ancora una reazione anomala» e il risultato non è ancora
accettabile. Nel dettaglio il ritorno blu, incontrando una rientranza concava,
abbandona il percorso parallelo atteso e crea una scorciatoia diagonale a
punta. La mandata rossa prosegue verticalmente: i due percorsi non presentano
una transizione coordinata.

### Stato dell'ultimo risultato realmente provato

- la precedente anomalia estesa a doppia `S` è stata ridotta;
- gli anelli principali e la parte obliqua risultano più ordinati;
- resta il raccordo locale triangolare mostrato nello screenshot;
- diagnostica dell'ultimo test: 1 incrocio nel locale 1, 2 nel locale 2 e 2
  nel locale 3 dopo l'arrotondamento;
- le chiusure centrali non risultano ancora valide.

### Causa tecnica ipotizzata

La connessione fra due offset consecutivi viene scelta ancora troppo vicino
al criterio di minima distanza. Quando il profilo si restringe o cambia
topologia, il punto geometricamente più vicino può appartenere al ramo
sbagliato della rientranza. Il raccordo taglia allora la zona concava invece
di seguirne il corridoio disponibile.

Nel sorgente esiste una prima funzione `ScegliTaglioOffset` per valutare più
punti di taglio. Al momento della sospensione non è ancora collegata
completamente dal programma al ritorno usato come ostacolo e non costituisce
quindi una soluzione verificata.

### Strategie candidate da confrontare con altri pattern

1. Generare più raccordi candidati fra offset consecutivi.
2. Accettare soltanto raccordi interamente contenuti nel corridoio compreso
   fra i due offset e nel perimetro del locale.
3. Scartare i candidati che intersecano mandata, ritorno o spire già fissate,
   verificando la geometria dopo l'arrotondamento.
4. Imporre il raggio minimo di curvatura di `0,10 m` e la distanza prevista
   fra i tubi.
5. Preferire un percorso che segua la rientranza con curve tangenti; se non
   esiste, arrestare la spirale all'offset precedente invece di creare una
   scorciatoia diagonale.
6. Generare prima il ritorno, bloccarlo, quindi sviluppare la mandata usandolo
   come ostacolo e tentare infine la chiusura centrale.

### Criteri per considerare risolto il pattern

- nessuna auto-intersezione;
- nessun incrocio mandata/ritorno;
- nessun segmento esterno al locale;
- nessuna scorciatoia attraverso la rientranza;
- distanza dalla parete e interasse rispettati;
- raggi di curvatura validi;
- estremità centrali affiancate e chiusura continua, oppure arresto esplicito
  su un offset precedente senza produrre geometria ingannevole.

