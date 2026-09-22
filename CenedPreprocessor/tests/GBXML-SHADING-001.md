# GBXML-SHADING-001 — studio di fattibilità ombreggiamenti

## Obiettivo

Verificare che un file gbXML pubblico possa trasportare, in forma geometrica e non precalcolata, le informazioni necessarie per riconoscere tre famiglie di ombreggiamento rilevanti per il futuro mapping CENED:

1. aggetto/balcone orizzontale;
2. setti/aggetti verticali laterali;
3. ostruzione esterna remota, rappresentativa di un edificio di fronte.

Input:

`../samples/GBXML-SHADING-001.xml`

## Sistema di riferimento

- +X = Est;
- +Y = Nord;
- +Z = alto;
- facciata finestrata Sud = piano `y = 0`;
- spazio esterno Sud = valori `y < 0`.

## Edificio base atteso

- 1 Campus;
- 1 Building;
- 1 Zone;
- 1 Space;
- stanza 4,00 × 4,00 × 3,00 m;
- area = 16,00 m²;
- volume = 48,00 m³;
- 6 superfici di involucro;
- 2 Opening sulla parete Sud;
- ciascuna finestra = 1,00 × 1,20 m.

## Ombreggiamenti attesi

### Shade-Balcony

Tipo: `Shade`.

Coordinate:
- X da 0,25 a 3,75 m;
- Y da 0,00 a -1,20 m;
- Z = 2,50 m.

Valori geometrici:
- larghezza = 3,50 m;
- profondità = 1,20 m;
- area geometrica = 4,20 m²;
- distanza verticale dal bordo superiore delle finestre = 0,30 m.

Classificazione attesa dal futuro adapter: **aggetto orizzontale / balcone**.

### Shade-Fin-West

Tipo: `Shade`.

Coordinate:
- X = 0,35 m;
- Y da 0,00 a -0,80 m;
- Z da 0,80 a 2,70 m.

Valori geometrici:
- profondità = 0,80 m;
- altezza = 1,90 m;
- area = 1,52 m².

Classificazione attesa: **setto/aggetto verticale laterale**.

### Shade-Fin-East

Tipo: `Shade`.

Coordinate:
- X = 3,65 m;
- Y da 0,00 a -0,80 m;
- Z da 0,80 a 2,70 m.

Valori geometrici:
- profondità = 0,80 m;
- altezza = 1,90 m;
- area = 1,52 m².

Classificazione attesa: **setto/aggetto verticale laterale**.

### Shade-Opposite-Building

Tipo: `Shade`.

Coordinate:
- Y = -8,00 m;
- X da -4,00 a 8,00 m;
- Z da 0,00 a 10,00 m.

Valori geometrici:
- distanza dalla facciata Sud = 8,00 m;
- larghezza = 12,00 m;
- altezza = 10,00 m;
- area = 120,00 m².

Classificazione attesa: **ostruzione esterna remota**.

## Conteggi attesi

Il parser deve rilevare:
- 10 `Surface` totali;
- di cui 6 superfici di involucro;
- 4 superfici `surfaceType="Shade"`;
- 2 `Opening`;
- 4 `Construction`;
- 1 `Zone`;
- 1 `Space`.

Tutti i riferimenti `zoneIdRef`, `spaceIdRef` e `constructionIdRef` devono risolversi.

## Criterio di fattibilità

La fattibilità **non** è dimostrata semplicemente perché il file contiene quattro superfici Shade.

Il futuro adapter gbXML deve essere in grado di:

1. importare senza perdita tutte le coordinate;
2. associare gli elementi ombreggianti alla facciata/finestra interessata tramite geometria;
3. distinguere geometria locale (balcone/setti) da ostacolo remoto;
4. riconoscere l'orientamento del piano ombreggiante;
5. ricavare profondità, distanze e quote necessarie al successivo mapping;
6. non sostituire la geometria con un fattore di ombreggiamento precalcolato;
7. conservare la provenienza `gbXML` per i dati geometrici.

Il successivo studio CENED dovrà verificare quali di questi parametri geometrici possono essere trasferiti direttamente e quali devono essere trasformati negli specifici parametri richiesti dal Motore.

## Riferimento gbXML

I test pubblici ASHRAE/gbXML includono esplicitamente:
- Test Case 13 — Balcony: il balcone deve essere esportato come superficie `Shade`;
- Test Case 14 — Roof With Extended Overhang: l'aggetto deve essere separato dalla copertura ed esportato come `Shade`.

Questa fixture estende lo stesso principio aggiungendo setti verticali e un ostacolo remoto.

## Stato

La struttura usa elementi e enumerazioni presenti nello schema pubblico gbXML 8.01.

La validazione completa con il validator gbXML ufficiale deve restare un gate della futura pipeline automatica; non viene considerata sostitutiva del test semantico del Bridge.
