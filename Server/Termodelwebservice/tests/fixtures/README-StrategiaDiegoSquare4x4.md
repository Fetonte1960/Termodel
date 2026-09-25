# StrategiaDiegoSquare4x4

Fixture minima per lo sviluppo e il benchmark della StrategiaDiego.

File:
`StrategiaDiegoSquare4x4.locale.xml`

Geometria:
- locale quadrato 4,00 x 4,00 m;
- perimetro: (0,0) -> (4,0) -> (4,4) -> (0,4);
- unico tubo di collegamento `T1`;
- `T1`: da (2,-1) esterno a (2,1) interno;
- direzione entrante: +Y;
- intersezione con il perimetro: (2,0);
- passo Diego di riferimento: 0,30 m;
- radici teoriche del ritorno a 0,50 m lungo la parete di ingresso:
  (1,50,0) e (2,50,0), prima delle verifiche geometriche.

Scopo:
1. verificare la costruzione deterministica dell'albero mandata;
2. verificare un sottoalbero ritorno per ogni terminale mandata;
3. misurare nodi, terminali, profondita, tempo e memoria;
4. confrontare in seguito Vittorio/GPT/Diego sullo stesso contratto
   `locale.xml`.

La fixture non e' un Golden Result: i risultati prodotti da Diego devono essere
prima compresi e approvati prima di fissare valori golden.
