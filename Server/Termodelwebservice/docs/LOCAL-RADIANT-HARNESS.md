# Modalità operativa Harness locale

La modalità locale `Diego_Vittorio` è il ciclo rapido di sviluppo delle
spirali. Esegue il vero `Termodel.Core` attraverso
`Termodel.RadiantPanels.Harness`, ma non richiede push, GitHub Actions o avvio
di ASP.NET per ogni prova.

Il WebService resta su `http://localhost:5080`. Il visualizzatore Harness usa
`http://127.0.0.1:5081` ed è accessibile esclusivamente dal PC locale.

Sorgenti, build e risultati hanno ruoli distinti:

```text
repository di lavoro
  ↓ stamp leggero percorso/dimensione/data
build incrementale diretta Harness + Core (solo se cambia)
  ↓ esecuzione diretta Harness
Latest: SVG + XML + metriche + log
  ↓ server loopback 5081
browser con aggiornamento automatico
```

Le copie ripristinabili restano separate dalla build. Ogni snapshot ha un
manifest con SHA-256; il ripristino è sempre esplicito, salva prima lo stato
corrente e non elimina file estranei al manifest. Il precedente mirror di build
resta disponibile con `-UseMirror`, ma non è più il percorso predefinito del
ciclo rapido.

I quattro comandi operativi sono nella radice di `Termodelwebservice` e hanno
nomi descrittivi:

1. `HARNESS_LOCALE__1_CREA_SNAPSHOT_RIPRISTINABILE.cmd`;
2. `HARNESS_LOCALE__2_ESEGUI_E_AGGIORNA_PREVIEW.cmd`;
3. `HARNESS_LOCALE__3_AVVIA_SERVER_PREVIEW_5081.cmd`;
4. `HARNESS_LOCALE__4_RIPRISTINA_SNAPSHOT_SCELTO.cmd`.

Tutti mantengono aperta la finestra al termine. La strategia originale
`Vittorio`, il frontend Web e `definizionedati.json` non sono coinvolti.


## Direttiva corrente — quadrato pubblico

Per l'indagine `DV-TEST-001` il banco principale non è la vecchia fixture
quadrata sintetica: va usato l'input pannelli realmente estratto dal progetto
Web **Quadrato con pannelli**. L'estrazione si esegue una volta tramite il vero
`GeneraModello`; le iterazioni geometriche successive riusano direttamente
quell'XML e non richiedono frontend, WebService o push Git.

Comando di preparazione:

```powershell
tools\generate-public-square-executive.ps1 -Engine Diego_Vittorio -CaptureHarnessInput -CompareHarness
```

Poi il loop veloce usa
`LocalRadiantHarness.ps1 -PreparedInput <quadrato-con-pannelli.radiant-input.xml>`.

Il passaggio a GitHub Actions avviene quando una fase o una correzione candidata
deve essere consolidata. Non va usato come sostituto del loop locale
modifica → build incrementale → SVG/log → controllo umano.


## Logging categorizzato Diego_Vittorio

Per le indagini mirate il banco riusa il `TermodelLog` del Core invece di
creare file diagnostici paralleli. Il comando `run` accetta:

```text
--log-enabled true|false
--log-categories <categoria1,categoria2|all|none>
```

Per la diagnostica Supply di `Diego_Vittorio`:

```powershell
dotnet run --project tools/Termodel.RadiantPanels.Harness/Termodel.RadiantPanels.Harness.csproj -c Release -- run `
  --input tests/radiant-harness/prepared/PannelliRadiantiPublic.pannelli.xml `
  --locale locale_1 `
  --engine Diego_Vittorio `
  --p 0.30 `
  --supply-only `
  --log-enabled true `
  --log-categories SpiraliDiegoVittorio `
  --out <cartella-output>
```

Il file `<case-id>.log.txt` contiene sia la diagnostica storica ancora
presente sia i messaggi strutturati `TermodelLog` della categoria selezionata.
I sottotag principali sono:
- `Supply.Context`;
- `Supply.Generate.Begin`;
- `Supply.Offset.Begin/Candidate/Accept/Stop`;
- `Supply.ComputeOffset.Edge/Vertex/Result/Raw`;
- `Supply.Traverse.Connection/Candidate/Accept/End`;
- `Supply.Finalize.Plan/Result`;
- `Supply.Result`.

Regola operativa della FASE 6D: eseguire **un solo locale alla volta**,
leggere il log dopo ogni prova e aggiungere un nuovo punto diagnostico solo
quando il dato necessario non è già presente. I log devono osservare il
motore; non devono cambiare geometria, tolleranze o criteri di accettazione.

Verifica iniziale:
- categoria/wiring: commit `e35f05099179aae5f1af6df80527c00d0704c1c5`,
  Fast Harness `36422697579` SUCCESS;
- percorrenza/finalizzazione: commit
  `49f28610128096e87db27fbea58f5d7f73f9d27d`,
  Fast Harness `36423105809` SUCCESS.
