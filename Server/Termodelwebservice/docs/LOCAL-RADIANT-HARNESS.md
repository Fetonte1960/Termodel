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
