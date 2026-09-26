# StrategiaDiego — base dati Harness rapido

Questa cartella contiene i casi preconfezionati usati dal
`Termodel.RadiantPanels.Harness`.

Il Harness non duplica StrategiaDiego: richiama direttamente
`Termodel.Core.RadiantPanels.StrategiaDiegoBenchmark`, che esegue il vero
`StrategiaDiegoEngine`.

## Caso corrente

`cases/LG041-SQUARE4X4-T1-P030.json` punta alla fixture canonica
`tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`, senza duplicarla.

Il passo è `p=0,30 m`.

Il secondo caso rapido è `cases/CURRENT-APARTMENT-P030.json`, che usa direttamente
`prepared/StrategiaDiegoCurrentApartment.pannelli.xml`.

Origine del preconfezionato:

- progetto: `tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl`;
- SHA-256 progetto sorgente: `1a5855490adcbac25e5585f9ba89c624eb2381874eb2de8bdc74821a40d2a9a5`;
- generatore: vero `Termodel.Leggidxf.GeneraModello` tramite comando `prepare` del Harness;
- SHA-256 input pannelli prodotto: `b31b5c2bac4dbd8a13507daef4022c5ad2301fb6503ff6d666e427a2eb5d4a80`.

Il file preconfezionato è una **base dati di test**, non un nuovo formato di progetto.
Va rigenerato esplicitamente con `prepare` quando cambia il progetto sorgente o
la logica che costruisce `RadiantPanelInputXml`.

## Input preconfezionato da progetto reale

Il comando `prepare` estrae dal progetto completo il solo
`RadiantPanelInputXml` prodotto dal vero `GeneraModello`. L XML risultante
può essere conservato in `prepared/` e usato poi dal comando `run` senza
ripetere parsing del progetto, ASP.NET o generazione 3D.

Esempio:

```powershell
dotnet run --project tools/Termodel.RadiantPanels.Harness -- prepare `
  --project tests/fixtures/StrategiaDiegoCurrentApartment.project.tmdl `
  --output tests/radiant-harness/prepared/StrategiaDiegoCurrentApartment.pannelli.xml
```

Esecuzione rapida:

```powershell
dotnet run --project tools/Termodel.RadiantPanels.Harness -- run `
  --case tests/radiant-harness/cases/LG041-SQUARE4X4-T1-P030.json `
  --out .tmp/radiant-harness
```

Per il progetto appartamento preconfezionato:

```powershell
dotnet run --project tools/Termodel.RadiantPanels.Harness -- run `
  --case tests/radiant-harness/cases/CURRENT-APARTMENT-P030.json `
  --out .tmp/radiant-harness
```

Output: SVG, log diagnostico e JSON metriche.

La workflow focalizzata usa direttamente i due case preconfezionati e quindi
**non rigenera il progetto completo ad ogni test**. Il comando `prepare` resta
lo strumento di manutenzione della base dati quando il progetto sorgente cambia.
