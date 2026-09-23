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

- `TipologiePannelli.json`;
- `Tubazioni.json`;
- `Fluidi.json`.

Sono archivi tecnici del progetto e vengono inseriti da `ProgFileUnico` nel `TERMODEL-PROJECT-TEXT-V1` sia in JSON sia in XML. I relativi metadata sono mantenuti separatamente in `Definitions/pannelli-tubazioni-definizionedati.json`, senza modificare `definizionedati.json`.
