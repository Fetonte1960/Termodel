# Strategia `Diego_Vittorio`

Questa cartella è la copia sperimentale indipendente di
`../SpiraliVittorio`, creata il 27 settembre 2026 dal commit sorgente
`d7bc36c`.

La copia iniziale conserva integralmente l'algoritmo Vittorio. Le sole
variazioni intenzionali nei quattro file C# sono il namespace, cambiato da
`SpiralHeating` a `SpiralHeatingDiegoVittorio`, e il commento di tracciabilità
richiesto dal progetto. Questo permette evoluzioni e confronti senza modificare
l'originale.

Il selettore pubblico del motore è `Diego_Vittorio`.

## Impronte SHA-256 dei sorgenti Vittorio copiati

| File | SHA-256 sorgente |
| --- | --- |
| `ChiudiSpirale.cs` | `1BF60B22E097A7E374F278A9362521681F9CCB07843A49CA4160BF11C81D4BBE` |
| `Program.cs` | `6948B7CEDD6C2533C795F9164C33BFE81BC00C76C91533A53718825C1188185F` |
| `Spiralgenerator.cs` | `1821CD8CEE0BE75BA283F0FD2DFE19D62DD95CDA5CA91F9B2136B01D926E034E` |
| `Utilityfunctions.cs` | `A7D27DB7E2F0A0109B6F61A7B9E7B19BAD81A1AC18CFE0CD531919E29EB4AA3D` |

`SpiraliVittorio` resta la base di confronto e ripristino e non deve essere
adattata durante lo sviluppo di `Diego_Vittorio`.

## Presentazione SVG

Dal 27 settembre 2026 l'SVG finale `Diego_Vittorio` include il contorno
architettonico reale dei locali come gruppo `architecture`. La radice usa
dimensioni percentuali, `viewBox` calcolato sull'intera geometria e
`preserveAspectRatio="xMidYMid meet"`, così il disegno si adatta alla finestra
senza deformazioni. Dimensioni, trasformazione e `viewBox` sono serializzati
con cultura invariant. Questa estensione è soltanto grafica: non modifica XML,
mandata, ritorno o sorgenti `SpiraliVittorio`.

### Flag raccordi durante il debug

Nell'attuale fase di debug i raccordi arrotondati sono disattivati per default:
l'SVG usa mandata, ritorno e collegamento a segmenti rettilinei, evitando la
generazione dei punti intermedi delle curve. La radice dichiara
`data-termodel-fittings="disabled"`.

Per riattivare integralmente i raccordi originali prima di eseguire Harness o
Service:

```powershell
$env:TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS = "true"
```

Valori veri ammessi: `true`, `1`, `yes`, `on`. Valori falsi: `false`, `0`,
`no`, `off`. Con raccordi attivi la radice SVG dichiara
`data-termodel-fittings="enabled"`.

## Matrice delle distanze

Dal 27 settembre 2026 la derivazione applica le distanze geometriche delle
linee guida spirali, con `p = 0,30 m`:

```text
tubo - architettura = p/2 = 0,15 m
Supply - Supply     = 2p  = 0,60 m
Supply - Return     = p   = 0,30 m
Return - Return     = p   = 0,30 m (LG-046)
```

Il primo offset della mandata è distinto dai successivi: nasce a `p/2` dalla
parete, mentre le evoluzioni Supply avanzano di `2p`. Il ritorno derivato viene
collocato sul lato interno della mandata a distanza `p`.

Il ritorno resta ancora derivato dalla mandata: rispetta la distanza minima
Return-Return ma non possiede ancora una ricerca autonoma capace di sfruttare
tutti i corridoi a passo `p` previsti da LG-046.

Il confronto prestazionale canonico usa la fixture Git
`tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`, SHA-256
`9EC497979E89D87C9145B9527D171A23CDA691454DDB86B53B84FAB8B2165516`,
tramite il case
`tests/radiant-harness/cases/LG041-SQUARE4X4-T1-P030-DIEGO-VITTORIO.json`.
