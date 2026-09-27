# Harness locale rapido — Diego_Vittorio

Questa modalità riduce il ciclo modifica → prova senza dipendere da GitHub o
GitHub Actions. Non sostituisce i test finali del repository.

## Separazione delle porte

- `http://localhost:5080`: WebService Termodel ordinario;
- `http://127.0.0.1:5081`: sola anteprima locale Harness, vincolata al
  loopback e non esposta in rete.

## Flusso consigliato

1. eseguire una volta `HARNESS_LOCALE__1_CREA_SNAPSHOT_RIPRISTINABILE.cmd`;
2. avviare `HARNESS_LOCALE__3_AVVIA_SERVER_PREVIEW_5081.cmd` e lasciare
   aperta quella finestra;
3. dopo ogni modifica eseguire
   `HARNESS_LOCALE__2_ESEGUI_E_AGGIORNA_PREVIEW.cmd`;
4. il browser ricarica automaticamente l'SVG quando cambia;
5. usare GitHub soltanto per il consolidamento e le verifiche finali.

La prima esecuzione crea e compila un mirror sotto
`%LOCALAPPDATA%\Termodel\RadiantHarness\SourceMirror`. Le successive saltano
la build se l'impronta dei sorgenti non è cambiata. `Latest` contiene SVG,
XML, metriche e log dell'ultima prova.

## Snapshot e ripristino

Gli snapshot sono conservati fuori dal repository in
`%LOCALAPPDATA%\Termodel\RadiantHarness\Snapshots`. Ogni snapshot ha un
`manifest.json` con commit Git, percorsi, dimensioni e SHA-256.

Il ripristino:

- richiede lo `SnapshotId` esatto e una conferma esplicita;
- crea prima uno snapshot `pre-restore-*` dello stato corrente;
- sovrascrive soltanto i file elencati nel manifest;
- non cancella file aggiuntivi;
- verifica gli SHA-256 prima e dopo la copia.

`SpiraliVittorio` non fa parte della selezione ripristinabile e resta il
riferimento intoccabile. Il frontend Web non è coinvolto.

## Comando PowerShell diretto

```powershell
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action run
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action run -Fillets
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action snapshot -SnapshotLabel prima-della-prova
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action status
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action serve -Port 5081 -OpenBrowser
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action restore -SnapshotId ID_ESATTO -ConfirmRestore
```

Il ripristino va eseguito soltanto su richiesta. L'opzione `-Rebuild` forza
l'aggiornamento del mirror e la ricompilazione; `-Fillets` riattiva i raccordi
grafici, disabilitati per default nella modalità di debug rapido.
