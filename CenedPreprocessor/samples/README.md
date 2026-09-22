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


## GBXML-SHADING-001

File: `GBXML-SHADING-001.xml`

Fixture avanzata per lo studio di fattibilità degli ombreggiamenti geometrici.

Base edificio:
- 1 stanza 4,00 × 4,00 × 3,00 m;
- 2 finestre sulla facciata Sud;
- sistema di riferimento: +X Est, +Y Nord, +Z alto;
- facciata Sud sul piano `y = 0`.

Elementi ombreggianti, tutti rappresentati con `Surface surfaceType="Shade"`:
- balcone/aggetto orizzontale profondo 1,20 m a quota 2,50 m;
- setto verticale Ovest profondo 0,80 m;
- setto verticale Est profondo 0,80 m;
- palazzo di fronte rappresentato dalla facciata ombreggiante a 8,00 m, larga 12,00 m e alta 10,00 m.

Scopo: verificare che il Bridge possa leggere dal formato pubblico gbXML le **cause geometriche** dell'ombreggiamento, mantenendole distinte dai fattori/risultati derivati presenti nell'XML nazionale.

Caso di test associato: `../tests/GBXML-SHADING-001.md`.


## BRIDGE-COMPLETION-001

File: `BRIDGE-COMPLETION-001.xml`

Sample del terzo file opzionale di completamento, validato contro:

`../spec/bridge-completion-1.0.xsd`

Il sample è collegato alle fixture:
- `GBXML-SHADING-001.xml`;
- `BLUMATICA-XML-001-SANITIZED.xml`.

Contiene volutamente un binding e un campo `PROVISIONAL.*` dimostrativi: non sono requisiti CENED ufficiali.
