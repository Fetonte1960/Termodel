# Sottosistemi Pascal completi — carichi, canali e tubazioni

## Scopo

Questa cartella amplia la precedente selezione di quattro file. Contiene la copia consultiva dei tre alberi funzionali storici e delle unità Pascal raggiunte ricorsivamente dalle clausole `uses`.

Gli originali non sono stati modificati. I percorsi sotto `origine` riproducono fedelmente la struttura successiva a `C:\DOCUMENTI`, mantenendo distinti gli alberi `sd` e `bmsistemi`.

## Nuclei copiati

- carichi termici: `sd\sorgenti\bm-sd\estivo_13`;
- calcolo e disegno canali: `sd\sorgenti\bm-sd\CANALI`;
- calcolo e disegno tubazioni: `bmsistemi\drivepsviluppo\prjs\cpi win clima\versione_10\Tubi`.

La copia include sorgenti Pascal/Delphi, form, risorse di progetto, configurazioni storiche e dati tecnici associati. Sono esclusi intenzionalmente eseguibili, DLL, DCU, OBJ, mappe di compilazione e copie di backup (`~*`, `.BAK`, `.OLD`).

## Dipendenze incluse

L'analisi parte da tutti i `.pas`, `.dpr` e `.dpk` nei tre nuclei e segue ricorsivamente le unità risolvibili in `C:\DOCUMENTI\sd\sorgenti` e `C:\DOCUMENTI\bmsistemi`.

Risultato della scansione:

| Sottosistema | Sorgenti selezionati | Fuori dal nucleo | Riferimenti risolti | Riferimenti non risolti |
|---|---:|---:|---:|---:|
| Carichi termici | 60 | 17 | 86 | 208 |
| Canali aria | 443 | 11 | 1.196 | 923 |
| Tubazioni | 247 | 204 | 1.113 | 1.395 |

I riferimenti non risolti non equivalgono tutti a file mancanti: comprendono unità Delphi/Turbo Pascal, componenti di terze parti, nomi con più copie storiche e alcuni percorsi assoluti non più disponibili. La classificazione analitica è nei CSV di `documentazione`.

## Struttura

- `origine\sd\...`: copia con struttura originale dei file provenienti da SD;
- `origine\bmsistemi\...`: copia con struttura originale dei file provenienti da BMSistemi;
- `documentazione\DIPENDENZE-RISOLTE.csv`: ogni relazione `uses` risolta;
- `documentazione\DIPENDENZE-NON-RISOLTE.csv`: riferimenti non risolti, con sorgente chiamante;
- `documentazione\UNITA-NON-RISOLTE-RIEPILOGO.csv`: classificazione per unità, numero di riferimenti e copie candidate;
- `documentazione\SORGENTI-SELEZIONATI.csv`: chiusura ricorsiva selezionata per sottosistema;
- `PROVENIENZA.csv`: corrispondenza fra copia e file originale;
- `MANIFEST-SHA256.csv`: dimensione e impronta SHA-256 della raccolta.

## Limiti

La raccolta documenta il codice storico e le sue dipendenze locali, ma non costituisce un progetto immediatamente compilabile. I tre alberi mescolano generazioni diverse di Turbo Pascal e Delphi, componenti commerciali o non presenti, BDE, TeeChart, GLScene e riferimenti a vecchi dischi di rete. Le unità omonime non sono state fuse né scelte arbitrariamente quando il contesto non consentiva una selezione univoca.

## Regole d'uso

- usare i file solo come riferimento tecnico e comportamentale;
- non sviluppare direttamente nella copia;
- mantenere i percorsi e i contenuti invariati;
- verificare licenze e titolarità prima di qualsiasi pubblicazione;
- validare formule e dati tecnici rispetto alle norme attuali prima del riuso.
