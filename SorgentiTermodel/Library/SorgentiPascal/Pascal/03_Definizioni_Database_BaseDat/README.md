# Definizioni storiche automatizzate del database — `base.dat`

## Finalità

Questa sezione conserva tutte le versioni di `base.dat` individuate negli alberi storici `C:\DOCUMENTI\sd` e `C:\DOCUMENTI\bmsistemi`.

`base.dat` è un file di testo dichiarativo usato dal sistema storico per descrivere record, campi, tipi, relazioni, lookup e valori iniziali. È quindi un riferimento essenziale per comprendere la generazione automatizzata delle strutture database e delle interfacce collegate.

## Risultato della ricerca

- collocazioni originali trovate: **45**;
- contenuti SHA-256 distinti: **25**;
- tutte le collocazioni sono conservate, comprese le copie byte-identiche, perché cartella e variante progettuale documentano il contesto di utilizzo;
- nessun originale è stato modificato.

## Struttura

La cartella `origine` riproduce integralmente il percorso successivo a `C:\DOCUMENTI`:

- `origine\sd\...` per i file provenienti dall'albero SD;
- `origine\bmsistemi\...` per i file provenienti dall'albero BMSistemi.

## File di controllo

- `INDICE-VERSIONI.csv`: percorso della copia, origine, dimensione, data originale, SHA-256 e numero del gruppo di contenuto;
- `RIEPILOGO-CONTENUTI-DISTINTI.csv`: una riga per ciascuna delle 25 versioni effettivamente differenti;
- `MANIFEST-SHA256.csv`: impronta di tutti i file della sezione.

## Avvertenze

- La numerazione dei gruppi identifica uguaglianza byte-per-byte, non una successione cronologica o semantica.
- File con la stessa dimensione possono comunque avere contenuto differente.
- Le definizioni appartengono a varianti diverse: carichi, tubazioni, 3D, ClimaCAD, ClimaEnergia, gestione clienti, Sun-Trace e generatori sperimentali.
- Prima di reinterpretare la sintassi occorre confrontarla con i generatori e i lettori Pascal presenti nella raccolta dei sorgenti.
- La raccolta è esclusivamente consultiva e non va usata come database operativo.
