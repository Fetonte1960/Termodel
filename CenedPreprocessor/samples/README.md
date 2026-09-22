# Samples

Progetti ed esempi leggibili dall'utente, separati dai Golden Results di conformità.

Gli esempi serviranno per:
- sviluppo UI;
- dimostrazioni;
- import/export;
- casi semplici di riferimento.

Quando un esempio viene promosso a caso di regressione, deve essere copiato o referenziato formalmente dal sistema di test con output atteso versionato.


## GBXML-ROOM-2WINDOWS-001

File: `GBXML-ROOM-2WINDOWS-001.xml`

Fixture gbXML minimale per il primo adapter geometrico del Bridge.

Geometria attesa:
- 1 edificio;
- 1 zona termica;
- 1 spazio;
- pianta 4,00 × 4,00 m;
- altezza 3,00 m;
- area 16,00 m²;
- volume 48,00 m³;
- 4 pareti esterne;
- 1 pavimento su terreno;
- 1 copertura;
- 2 finestre sulla parete Sud;
- ogni finestra 1,00 × 1,20 m = 1,20 m²;
- area vetrata totale 2,40 m²;
- parete Sud lorda 12,00 m²;
- parete Sud opaca netta attesa 9,60 m².

Il file dichiara gbXML **8.01**, unità SI e utilizza `PlanarGeometry/PolyLoop` per superfici e aperture.

Le costruzioni sono volutamente schematiche e i dati sono interamente fittizi.

Caso di test associato: `../tests/GBXML-ROOM-2WINDOWS-001.md`.
