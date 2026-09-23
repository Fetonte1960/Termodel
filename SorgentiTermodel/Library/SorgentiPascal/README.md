# Appendice consultiva — sorgenti Pascal e biblioteca simboli DXF

## Finalità

Questa raccolta è una copia classificata del materiale storico individuato in `C:\DOCUMENTI\sd` e `C:\DOCUMENTI\bmsistemi`. È predisposta per un futuro trasferimento come appendice della Library Termodel, nella sezione di sola consultazione dedicata ai sorgenti Pascal.

I file servono esclusivamente come riferimento storico e comportamentale. La raccolta non è un progetto compilabile autonomamente e non sostituisce i sorgenti originali.

## Struttura

- `DXF/01_Biblioteche_aggregate`: raccolte contenenti numerosi blocchi;
- `DXF/02_Template_operativi`: intestazioni e prototipi operativi;
- `DXF/03_Master_parametrici`: master `H_*.dxf` usati per generare simboli;
- `DXF/04_Istanze_generate`: simboli con parametri codificati nel nome;
- `DXF/05_Simboli_elementari`: elementi singoli e collettori;
- `Pascal/01_Gestione_DXF`: prima selezione minima sulla gestione DXF;
- `Pascal/02_Sottosistemi_Completi`: carichi termici, canali e tubazioni con struttura originale e dipendenze ricorsive;
- `Pascal/03_Definizioni_Database_BaseDat`: tutte le versioni reperite di `base.dat`, con struttura originale e raggruppamento per hash;
- `Pascal/04_Gestione_BaseDat_Sorgenti`: programmi `GENERA`, form, risorse, dati di supporto e dipendenze Pascal;
- `MANIFEST-SHA256.csv` e `PROVENIENZA.csv`: manifest e provenienza della prima raccolta.

Le sezioni dalla `02` alla `04` possiedono manifest, provenienza o indici autonomi.

## Riferimenti principali

La biblioteca DXF più completa è `DXF/01_Biblioteche_aggregate/definizione_simboli_2012.dxf`. Per lo studio dei motori Pascal usare `02_Sottosistemi_Completi`; per le definizioni database usare `03_Definizioni_Database_BaseDat`; per comprenderne generazione, lettura e gestione usare `04_Gestione_BaseDat_Sorgenti`.

## Esclusioni intenzionali

Non sono stati copiati nelle sezioni ampliate eseguibili, DLL, unità compilate, oggetti, mappe di compilazione e backup. Componenti di piattaforma o di terze parti non disponibili sono elencati nei rapporti, non ricostruiti artificialmente.

## Regole di utilizzo

- area di sola consultazione: non sviluppare direttamente dentro questa copia;
- conservare nomi, struttura e contenuti originali;
- verificare unità, formati, norme tecniche e dipendenze prima del riuso;
- usare i manifest SHA-256 per controllare l'integrità;
- verificare titolarità e licenze prima della pubblicazione su un repository pubblico.
