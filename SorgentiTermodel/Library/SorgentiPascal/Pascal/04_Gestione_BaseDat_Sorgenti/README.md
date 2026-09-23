# Gestione automatizzata di `base.dat` — sorgenti e dipendenze

## Contenuto

Questa sezione conserva il nucleo storico `C:\DOCUMENTI\sd\sorgenti\bm-sd\GENERA`, che contiene i programmi e le unità usati per generare, leggere, modificare e distribuire le definizioni dichiarative `base.dat`.

Sono incluse le varianti progettuali presenti nell'albero originale, fra cui `GeneraSource.dpr`, `Gestionedati.dpr` ed `EasyProgram.dpr`, insieme a form, risorse, tabelle Paradox e file di configurazione utili a comprenderne il funzionamento.

## Struttura e dipendenze

- `origine` riproduce il percorso originale successivo a `C:\DOCUMENTI`;
- l'intero nucleo sorgente `GENERA` è conservato, escluse unità compilate, eseguibili e backup;
- le unità Pascal risolte ricorsivamente fuori da `GENERA` sono copiate nel loro percorso originale;
- `documentazione` contiene le relazioni `uses` risolte e non risolte e l'elenco dei sorgenti selezionati;
- `PROVENIENZA.csv` collega ogni copia al file originale;
- `MANIFEST-SHA256.csv` permette la verifica d'integrità.

## Ruoli principali osservati

- `Genera.pas`, `UMainGenera.pas`, `UFunzGenera.pas`: generazione e coordinamento;
- `assembla.pas`, `CompilaLista.pas`, `Creadb.pas`: composizione delle definizioni e creazione delle strutture;
- `UDB.pas`, `UDataLink.pas`, `DataIn*.pas`, `DataOut*.pas`: accesso e trasformazione dati;
- `Mappadb*.pas`, `typedef*.pas`, `Proc.pas`: mappatura, tipi e procedure dichiarative;
- `gestione` e `distribuzione`: gestione dei nomi database, compilazione delle frontiere e distribuzione delle definizioni.

## Limiti

La raccolta è consultiva e non garantisce compilabilità immediata. Il codice dipende da vecchie versioni Delphi, BDE/Paradox, kbmMemTable e altre librerie storiche. Le dipendenze ambigue o non disponibili restano esplicitamente elencate anziché essere sostituite arbitrariamente.
