# StrategiaDiegoConcaveL

Prima fixture non convessa per la regressione di StrategiaDiego.

File:
`StrategiaDiegoConcaveL.locale.xml`

Geometria:
- locale a L inscritto in un rettangolo 6,00 x 5,00 m;
- perimetro: (0,0) -> (6,0) -> (6,2) -> (3,2) -> (3,5) -> (0,5);
- rientranza concava nel punto (3,2);
- unico tubo di collegamento `T1`;
- `T1`: da (1,5;-1) esterno a (1,5;1) interno;
- direzione entrante: +Y;
- intersezione con il perimetro: (1,5;0);
- passo Diego di riferimento: 0,30 m.

Scopo:
1. verificare che l'albero possa essere costruito in una geometria concava;
2. verificare determinismo di struttura e SVG su esecuzioni ripetute;
3. misurare nodi, terminali, profondità, tempo e memoria con gli stessi budget
   del caso quadrato 4x4;
4. conservare un artifact SVG ispezionabile.

Questa fixture isola la concavità con un solo locale e un solo ingresso. Non
rappresenta ancora la strettoia reale di `STRATEGY-001` e non costituisce un
Golden Result geometrico approvato.
