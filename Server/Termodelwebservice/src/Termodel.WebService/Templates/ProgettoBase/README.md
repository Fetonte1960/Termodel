# Progetto base incorporato

Snapshot consolidato del progetto iniziale proposto da Termodel desktop al 19 settembre 2026.

Provenienza:

- base: `Documenti/Termodel/Modelli/Unico piano non mansardato`;
- `Ponti.xml`, `PontiAutomatici.xml` e `PontiAutomaticiFinestre.xml`: modello `Ponti termici per edificio senza isolamento`;
- `thermal/input.xml`: esempio `1 Zona Caldaia e componenti edilizi.xml`;
- `thermal/input.json`: rappresentazione derivata già distribuita con il modello base.

Sono inclusi gli archivi dichiarati da `definizionedati.json`, `DisegnoInput.dxf` e l'input termico. Sono esclusi backup `.bak`, `output.xml`, `output.json` e risultati calcolati perché derivati e non necessari alla creazione iniziale.

Il template è una copia di distribuzione: non sostituisce le fonti desktop e deve essere aggiornato soltanto mediante una nuova copia verificata.

## Archivi estesi pannelli radianti

Dal 23 settembre 2026 il template incorpora anche gli archivi progetto estesi in `extended-archives/`:

- `Reti.json`;
- `TipologiePannelli.json`.

Sono archivi tecnici del progetto e vengono inseriti da `ProgFileUnico` nel `TERMODEL-PROJECT-TEXT-V1` sia in JSON sia in XML. I relativi metadata sono mantenuti separatamente in `Definitions/reti-pannelli-definizionedati.json`, senza modificare `definizionedati.json`.


### Revisione struttura 23 settembre 2026

La prima suddivisione `TipologiePannelli / Tubazioni / Fluidi` è stata superata.
Il template autorevole usa ora due soli archivi estesi:
`Reti` per tipo rete e parametri di esercizio/progetto indipendenti dal
costruttore, e `TipologiePannelli` per dati del prodotto, caratteristiche
della tubazione e passi ammessi. Le vecchie sezioni `Tubazioni` e `Fluidi`
restano compatibilità storica di eventuali progetti già creati, ma non vengono
più generate nei nuovi progetti.
