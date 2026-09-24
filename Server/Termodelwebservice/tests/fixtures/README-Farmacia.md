# Farmacia.dxf — regression fixture DXF → SVG

Fixture reale fornita dall'utente il 24/09/2026 per verificare la conversione
DXF ASCII 2D in SVG architettonico.

Il file originale non è stato normalizzato né semplificato. Per evitare di
versionare 3,2 MiB di testo DXF verboso, Git conserva la copia lossless:

```text
Farmacia.dxf.gz.b64
```

Ricostruzione:

```text
Base64 decode
→ gzip decompress
→ Farmacia.dxf
```

Impronte:

```text
Farmacia.dxf
SHA-256 81b7e14c361b0b5de94a877c715091b77a42f599c6a757ca1fc2906251496adc
byte     3225548

Farmacia.dxf.gz (gzip deterministico mtime=0)
SHA-256 20e43dd2b9123b5ec7534ab3e910c65bfcd50c51c51709be6e8b89fe944166b4
byte     403078
```

Caratteristiche osservate del DXF originale:

- AutoCAD `AC1032`;
- `$INSUNITS=6` → metri;
- 382 entità principali nella sezione ENTITIES;
- layer principali realmente popolati: `0`, `01-SEZIONI`,
  `02-PROIEZIONI`, `03-QUOTE`, `04-RETINI`;
- la pianta architettonica utile è concentrata sui layer `0`,
  `01-SEZIONI`, `02-PROIEZIONI`;
- `03-QUOTE` contiene soprattutto quote/testi e geometria annotativa;
- `04-RETINI` contiene retini;
- porte/aperture richiedono ARC/bulge, quindi il profilo architettonico deve
  conservare le curve.

Questa fixture è un riferimento di regressione. Non sostituirla con un DXF
ridotto quando un test fallisce: prima va compresa la differenza.
