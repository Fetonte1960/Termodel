# StrategiaDiego / SpiraliGPT — audit dei fondamentali geometrici

Data: 25/09/2026  
Stato: audit R3, documento operativo

## Criterio di confronto

Le linee guida `LG-001..LG-036` restano l'autorità. SpiraliGPT viene usata
come riferimento sussidiario secondo LG-020: si recuperano le garanzie
geometriche, non le sue euristiche locali di scelta.

Classificazione usata:

- **fondamentale**: garanzia geometrica necessaria anche a Diego;
- **differenza intenzionale**: comportamento che deve restare diverso;
- **ancora da definire**: comportamento utile di GPT non autorizzato dalle LG
  correnti o rinviato esplicitamente.

## Inventario

| Tema | SpiraliGPT | StrategiaDiego prima di R3 | Classificazione | Azione R3 |
|---|---|---|---|---|
| Contenimento nel locale | offset NTS e controlli di segmento nel perimetro | 24 campioni equidistanti per segmento | fondamentale, LG-005/LG-032 | verifica deterministica di estremi, intersezioni col bordo e punto medio |
| Lato dell'offset nei cambi obliqui/concavi | offset mitrato sul lato geometrico coerente | scelta `-d` o `+d` derivata dalla sola intersezione fisica | fondamentale, LG-034/LG-035 | tentativo R3 ritirato: lo stato del nodo deve prima conservare esplicitamente `S_k` orientato; usare `node.Front` come sostituto elimina terminali validi |
| Rete di collegamento come ostacolo | intaglio/margine e rifiuto degli incroci con tutti i tubi | le `Linea` servivano solo a trovare il primo ingresso | fondamentale, LG-011 | tutte le linee diventano vincoli anti-attraversamento, senza diventare fronti strategici |
| Tratto terminale d'ingresso | scarta un tratto se il suo estremo interno prosegue in un altro ramo | prima linea che attraversa il perimetro | fondamentale, LG-011 | stessa proprietà topologica, reimplementata in Diego |
| Esplorazione delle scelte | varianti locali ordinate da un punteggio composito | albero completo e merito massimo di lunghezza | differenza intenzionale, LG-002/LG-003 | nessuna modifica |
| Versi di percorrenza | prova orario/antiorario | rami `PARALLELA_A/B` | differenza intenzionale equivalente, LG-024 | nessuna modifica |
| Distanze parete/colore | distanze incorporate negli offset e nelle verifiche della coppia | `p/2`, `p`, `2p` espliciti | differenza intenzionale conforme, LG-006 | nessuna modifica |
| Offset concentrici precomputati | buffer negativo NTS con continuità fra componenti | costruzione incrementale dei tratti nell'albero | differenza intenzionale | non trasformare Diego in GPT |
| Arrotondamento delle curve | `ArrotondaSpirale` e raggio di curvatura | polilinee a spigoli | ancora da definire | nessuna modifica: richiede regola dedicata e verifica delle distanze dopo arrotondamento |
| Forcina/chiusura avanzata | curva tangente validata e ottimizzazione terminali | chiusura retta preliminare | ancora da definire, rinviato da LG-029 | nessuna modifica in R3 |
| Separazione topologica/strettoia | offset intermedi e continuità della componente | nessun nodo topologico esplicito | ancora da definire per Diego, collegato a `STRATEGY-001` | non introdurre una scelta implicita copiata da GPT |
| Diagnostica degli scarti | contatori per proiezione, corridoio, incroci e ostacoli | metriche aggregate dell'albero | fondamentale ma non bloccante | mantenere le metriche correnti; dettaglio dei rifiuti candidato da aggiungere in una fase dedicata |

## Correzioni R3

Le correzioni applicate in R3 sono volutamente inferiori al livello di scelta
dell'albero:

1. rendono più affidabile la domanda `TrattoPossibile?`;
2. impediscono alla spirale di attraversare la rete utente;
3. selezionano il vero tratto terminale di ingresso;
4. non cambiano il fattore di merito, il numero concettuale delle alternative
   o la ricostruzione radice-terminale.

## Limiti che restano espliciti

R3 non dichiara completate:

- la chiusura avanzata LG-029;
- la strettoia selettiva `STRATEGY-001`;
- l'arrotondamento idraulico delle curve;
- la costruzione completa dell'albero esterno dei ritorni LG-011;
- un Golden geometrico dell'appartamento.

Questi punti richiedono decisioni e regression proprie; copiarli implicitamente
da GPT violerebbe la separazione delle strategie stabilita da LG-001 e LG-020.
