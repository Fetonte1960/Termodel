# StrategiaDiegoConnectionTerminal

Regression della rete di collegamento LG-011.

- `T-A` attraversa il perimetro ma il suo estremo interno prosegue in
  `T-A-PROSEGUE`: non è un terminale di ingresso;
- `T-B` attraversa il perimetro e termina nel locale senza altri rami;
- la root dichiara `ExpectedConnectionId="T-B"`;
- il benchmark fallisce se la diagnostica Diego non conferma `T-B`;
- tutte le linee restano inoltre vincoli anti-attraversamento per la spirale.

La fixture verifica la selezione topologica, non costruisce ancora l'intero
albero esterno dei ritorni.
