# Test

Area comune per la verifica delle due implementazioni.

Ogni funzione significativa dovrà poter essere provata con:
1. stesso input;
2. stesso identificativo di caso;
3. risultato WebJS;
4. risultato Desktop;
5. confronto con il Golden Result previsto.

Le differenze ammesse, incluse eventuali tolleranze numeriche, dovranno essere esplicitate e versionate.


## Primo caso gbXML

Il primo caso di regressione geometrica è:

`GBXML-ROOM-2WINDOWS-001.md`

Input associato:

`../samples/GBXML-ROOM-2WINDOWS-001.xml`

Il caso fissa già conteggi, riferimenti, superfici, volume e aree delle due finestre che il futuro adapter gbXML dovrà restituire.


## Caso ombreggiamenti gbXML

`GBXML-SHADING-001.md`

Input:

`../samples/GBXML-SHADING-001.xml`

Questo caso è il gate dello studio di fattibilità per dimostrare che il Bridge può conservare e interpretare balconi/aggetti, setti verticali e ostruzioni esterne remote come geometrie gbXML, prima di qualunque conversione verso parametri CENED.
