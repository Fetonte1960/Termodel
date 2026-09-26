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

Output: SVG, log diagnostico e JSON metriche.
