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
  ↓ impronta SHA-256 cambiata
mirror locale + build incrementale in %LOCALAPPDATA%
  ↓ esecuzione diretta Harness
Latest: SVG + XML + metriche + log
  ↓ server loopback 5081
browser con aggiornamento automatico
```

Le copie ripristinabili sono separate dal mirror di build. Ogni snapshot ha
un manifest con SHA-256; il ripristino è sempre esplicito, salva prima lo
stato corrente e non elimina file estranei al manifest.

I quattro comandi operativi sono nella radice di `Termodelwebservice` e hanno
nomi descrittivi:

1. `HARNESS_LOCALE__1_CREA_SNAPSHOT_RIPRISTINABILE.cmd`;
2. `HARNESS_LOCALE__2_ESEGUI_E_AGGIORNA_PREVIEW.cmd`;
3. `HARNESS_LOCALE__3_AVVIA_SERVER_PREVIEW_5081.cmd`;
4. `HARNESS_LOCALE__4_RIPRISTINA_SNAPSHOT_SCELTO.cmd`.

Tutti mantengono aperta la finestra al termine. La strategia originale
`Vittorio`, il frontend Web e `definizionedati.json` non sono coinvolti.
