# WEBJS-DUAL-INPUT-001 — gbXML + XML nazionale

## Scopo

Verificare il comportamento della WebJS con le due sorgenti separate previste dal contratto del Bridge:

1. gbXML per la geometria fisica;
2. XML nazionale per i dati complementari e i risultati già disponibili.

## Input A — geometria

`../samples/GBXML-SHADING-001.xml`

Risultati attesi del parser gbXML:
- 6 superfici di involucro;
- 2 aperture;
- 4 superfici `Shade`;
- 1 `Shade` classificata `Aggetto orizzontale / balcone`;
- 2 `Shade` classificate `Setto verticale`;
- 1 `Shade` classificata `Ostruzione esterna remota`;
- distanza dell'ostacolo remoto dall'involucro = 8,00 m;
- profondità balcone = 1,20 m;
- profondità setti = 0,80 m;
- nessuna geometria deve essere generata dall'XML nazionale.

## Input B — dati complementari

Golden Reference esterno: `BLUMATICA-XML-001`.

Il file originale è quello fornito dall'utente ed è identificato da SHA-256:

`4988a0700ad1aeb60ef6906235411a176baee514f7a902533dfcc1ad86980647`

Il file grezzo non è committato perché contiene dati personali.

Aspettative già consolidate per il parser WebJS:
- comune: Reggio di Calabria;
- zona climatica: B;
- superficie utile riscaldata: 43,3 m²;
- volume lordo riscaldato: 148,41 m³;
- classe energetica: F;
- EPgl,nren: 217,04;
- 1 subEdificio;
- 5 locali;
- 39 superfici opache;
- 25 superfici vetrate;
- 184 ponti termici;
- 2 impianti letti dal selettore WebJS `impianti > impianto`.

Nota: il Golden Reference contiene in totale più nodi `impianto` in sezioni diverse; il valore 2 qui è l'aspettativa specifica del parser WebJS corrente, non il conteggio globale del documento.

## Sequenza di prova

1. aprire la WebJS;
2. importare `BLUMATICA-XML-001`;
3. verificare i dati nazionali attesi;
4. aprire Viewer 3D prima del gbXML: deve comparire il messaggio che l'XML nazionale non fornisce geometria 3D ricostruibile;
5. importare `GBXML-SHADING-001.xml`;
6. verificare che i dati nazionali precedentemente importati restino invariati;
7. verificare nel Viewer 3D involucro, due finestre, balcone, due setti e palazzo di fronte;
8. selezionare gli elementi Shade e controllare classificazione, dimensioni e provenienza `gbXML`;
9. eseguire `Verifica modello`: entrambi gli input devono risultare presenti.

## Principio verificato

L'import del secondo file non deve sovrascrivere il primo.

La fusione del Bridge avviene nel modello interno mantenendo la provenienza:
- geometria → gbXML;
- dati nazionali/complementari → XML nazionale.

Il viewer è read-only e non corregge né modifica nessuno dei due file.
