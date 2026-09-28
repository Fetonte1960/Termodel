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

Il banco predefinito è il quadrato storico consolidato 4x4 m, ingresso T1:
`LG041-SQUARE4X4-T1-P030-DIEGO-VITTORIO`. Il JSON conserva `p=0,30 m`, ma
`-StepMeters` consente di provare un passo diverso senza duplicare la fixture.

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
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action run -Closure
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action run -Fillets -Closure
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action run -ReturnSide right
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action run -StepMeters 0.20
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action run -LegacyReturn
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action snapshot -SnapshotLabel prima-della-prova
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action status
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action serve -Port 5081 -OpenBrowser
tools\local-radiant-harness\LocalRadiantHarness.ps1 -Action restore -SnapshotId ID_ESATTO -ConfirmRestore
```

Il ripristino va eseguito soltanto su richiesta. L'opzione `-Rebuild` forza
l'aggiornamento del mirror e la ricompilazione; `-Fillets` riattiva i raccordi
grafici adattivi e `-Closure` riattiva preparazione, collegamento e marcatore della
chiusura. Entrambi sono disabilitati per default nella modalità di debug rapido.
`-ReturnSide left|right` seleziona lato e verso del ritorno autonomo;
`-StepMeters` imposta `p` per la singola esecuzione e il motore ricava
automaticamente `p/2`, `p` e `2p`; `-LegacyReturn` riattiva temporaneamente
il precedente ritorno derivato.

## Regression distanze sul quadrato Git

Dopo avere generato il case
`LG041-SQUARE4X4-T1-P030-DIEGO-VITTORIO.json`, verificare l'SVG reale con:

```powershell
tools\local-radiant-harness\Test-DiegoVittorioDistances.ps1 `
  -SvgPath <percorso-svg-prodotto-dall-harness> `
  -StepMeters 0.20
```

La regression controlla sul quadrato canonico le tracce `p/2`, `2p`, `p`, la
quota del ritorno a `1,5p` dalla parete e la distanza Return-Return osservata,
che nella geometria derivata corrente è `2p` e quindi superiore al minimo
LG-046 pari a `p`.

## Regression della chiusura ottimizzata

Dopo un'esecuzione con `-Closure`, verificare il segmento prodotto con:

```powershell
tools\local-radiant-harness\Test-DiegoVittorioClosure.ps1 `
  -SvgPath <percorso-svg-prodotto-dall-harness> `
  -StepMeters 0.20
```

Il test vincolante controlla coincidenza con i terminali, lunghezza minima
`2p`, assenza di angoli acuti e assenza di intersezioni con tratti non
adiacenti. Riporta anche distanze positive da tubi e pareti come metriche
diagnostiche, senza usarle per respingere il primo risultato accettabile. La
ricerca prova al massimo 35 configurazioni ordinate: cinque
livelli di riespansione della mandata per sette riduzioni progressive del
ritorno. Se nessuna configurazione supera i due criteri, il comportamento
conforme è lasciare il circuito aperto e registrarlo nel log.

La regression sintetica degli archi si esegue sul binario Harness con:

```powershell
dotnet Termodel.RadiantPanels.Harness.dll fillet-check
```

Verifica deviazioni di 30°, 90° e 150°, estremi conservati, coordinate finite
e frammentazione compresa nel limite adattivo. Il test della chiusura accetta
una polilinea raccordata, verifica le tangenti ai due innesti e impone al
massimo nove punti per la Bézier centrale.
