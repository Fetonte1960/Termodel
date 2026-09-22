# GBXML-ROOM-2WINDOWS-001 — aspettative di test

## Scopo

Verificare il primo adapter gbXML del Software Bridge su una geometria minima, deterministica e facilmente controllabile a mano.

Input:

`../samples/GBXML-ROOM-2WINDOWS-001.xml`

## Aspettative strutturali

L'importatore deve rilevare:

- versione gbXML: `8.01`;
- unità lunghezza: metri;
- unità area: m²;
- unità volume: m³;
- 1 `Campus`;
- 1 `Building`;
- 1 `Zone`;
- 1 `Space`;
- 6 `Surface`;
- 2 `Opening`;
- 3 `Construction`.

Tutti i riferimenti `zoneIdRef`, `spaceIdRef` e `constructionIdRef` devono risolversi.

## Aspettative geometriche

Spazio:
- larghezza X = 4,00 m;
- profondità Y = 4,00 m;
- altezza Z = 3,00 m;
- area pavimento = 16,00 m²;
- volume = 48,00 m³.

Superfici:
- quattro pareti verticali da 12,00 m² lorde ciascuna;
- pavimento = 16,00 m²;
- copertura = 16,00 m².

Parete Sud:
- ID `Surface-South`;
- piano geometrico `y = 0`;
- due aperture.

Finestre:
- `Window-South-01`;
- `Window-South-02`;
- dimensione geometrica di ciascuna = 1,00 × 1,20 m;
- area di ciascuna = 1,20 m²;
- area vetrata totale = 2,40 m²;
- area opaca netta della parete Sud = 12,00 - 2,40 = 9,60 m².

## Aspettative semantiche

- le quattro pareti devono essere classificate `ExteriorWall`;
- il pavimento deve essere `SlabOnGrade`;
- la copertura deve essere `Roof`;
- le due aperture devono essere `FixedWindow`;
- lo spazio deve risultare associato a `Zone-001`;
- il Bridge non deve modificare il file durante l'importazione;
- ogni dato importato deve conservare la provenienza `gbXML`.

## Stato della fixture

Il file è costruito sulla struttura pubblica dello schema gbXML 8.01 e usa enumerazioni/campi verificati contro lo XSD ufficiale.

Controlli eseguiti al momento dell'acquisizione:
- struttura radice presente;
- versione 8.01 presente;
- 1 Space;
- 6 Surface;
- 2 Opening;
- 3 Construction;
- 1 Zone;
- nessun riferimento ID dichiarato risulta privo del relativo ID nel file.

La validazione completa mediante il validator ufficiale gbXML resta un controllo aggiuntivo da automatizzare quando verrà implementata la pipeline di test.
