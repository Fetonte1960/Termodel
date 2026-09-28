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

### Raccordi adattivi e flag durante il debug

I raccordi adattivi sono attivi per default nel motore `Diego_Vittorio`. Il
calcolo geometrico del circuito resta sulle polilinee rettilinee; la
presentazione SVG usa archi circolari tangenti con passo angolare di circa 30°,
da 2 a 6 segmenti per vertice. Ogni raccordo occupa al massimo il 45% dei due
tratti adiacenti, evitando sovrapposizioni nei segmenti corti. La stessa
routine gestisce deviazioni acute, rette, ottuse e oblique.

La chiusura usa una Bézier cubica tangente ai due circuiti, da 6 a 8 segmenti,
con campioni concentrati presso gli innesti per conservare la tangenza anche
nell'SVG discretizzato. Se la curva rischia di intersecare tubi conservati, la
maniglia viene ridotta progressivamente; come ultima sicurezza resta la retta
già validata da LG-048.

Per forzare l'attivazione o disattivare temporaneamente i raccordi:

```powershell
$env:TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS = "true"
$env:TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS = "false" # debug rettilineo
```

Valori veri ammessi: `true`, `1`, `yes`, `on`. Valori falsi: `false`, `0`,
`no`, `off`. Con raccordi attivi la radice SVG dichiara
`data-termodel-fittings="enabled"`. L'Harness locale conserva il default
rettilineo per il ciclo rapido e li attiva esplicitamente con `-Fillets`.

### Flag chiusura durante il debug

La procedura di chiusura è attiva per default nel motore. Per sospenderla
temporaneamente durante il debug, mantenendo mandata e ritorno separati:

```powershell
$env:TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE = "false"
```

La radice SVG dichiara lo stato con `data-termodel-closure`. Nell'Harness
locale il ciclo rapido resta aperto salvo l'opzione esplicita `-Closure`.

La chiusura è un solo segmento fra i terminali di mandata e ritorno. La
ricerca rapida è locale, deterministica e si arresta al primo candidato con
entrambi gli innesti non acuti e lunghezza almeno `2p`. Parte eliminando i tre
tratti terminali della mandata, come nell'euristica Vittorio, e la riespande
progressivamente accorciando il nuovo terminale a `2p`; per ogni livello prova
il ritorno integro, accorciato a `p` ed eliminato progressivamente fino a tre
tratti. Le configurazioni massime sono 5 × 7 = 35 e quelle geometricamente
duplicate vengono saltate. Una soluzione che interseca un tratto non adiacente
della mandata o del ritorno viene scartata; pareti e distanze positive restano
invece diagnostiche e non sono vincoli di accettazione. Se nessuna
configurazione è accettabile, il circuito resta aperto e il log lo dichiara.

### Collegamento iniziale del ritorno autonomo

`SpiralGenerator.GeneraCollegamentoRitorno(...)` prepara il tratto iniziale
prima della generazione autonoma del ritorno. Il ritorno nasce dal parallelo
gemello del tubo d'ingresso della mandata: la radice sulla parete è spostata
lateralmente di `p`, mentre il raccordo raggiunge la prima traccia a `1,5p`
dalla parete. Il lato è riferito al verso esterno→interno dell'ingresso:

```text
Destro   -> normale destra   -> rivoluzione antioraria
Sinistro -> normale sinistra -> rivoluzione oraria
```

Il verso indicato è quello del flusso idraulico reale, dal centro verso
l'uscita. Poiché il calcolo costruisce la geometria in ordine inverso,
dall'ingresso verso il centro, la percorrenza tecnica degli offset usa il verso
opposto senza cambiare la semantica della configurazione.

Il risultato contiene radice del ritorno, punto interno raggiunto dal raccordo,
lato, verso di rivoluzione e i due punti del collegamento. `GenerateReturn(...)`
lo esegue per primo e poi riusa `Generate(...)` dall'ingresso verso l'interno.
Il primo offset è la traccia esterna raggiunta dal raccordo; la mandata condiziona ogni
tratto a distanza minima `p` e il ritorno condiziona sé stesso alla stessa
distanza. La disattivazione della chiusura centrale non elimina il raccordo
d'ingresso del ritorno.

Nel passaggio fra offset il generatore valuta entrambe le connessioni
ortogonali possibili verso ogni lato candidato. Ogni tratto viene verificato
separatamente rispetto a mandata e ritorno; fra i percorsi validi viene scelto
quello più corto. Questo consente di attraversare un varco quando la proiezione
diretta verso l'offset successivo risulta invece bloccata.

Il ritorno autonomo è attivo per default. Configurazione:

```powershell
$env:TERMODEL_DIEGO_VITTORIO_RETURN_SIDE = "left"  # oppure right
$env:TERMODEL_DIEGO_VITTORIO_AUTONOMOUS_RETURN = "false" # fallback derivato
```

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
parete, mentre le evoluzioni Supply avanzano di `2p`. Il ritorno autonomo usa
passo richiesto `p`, scarta gli offset sovrapposti alla mandata, percorre gli
offset ammessi nel verso stabilito dal lato e verifica le distanze minime fra
segmenti. Il vecchio ritorno derivato resta disponibile solo come fallback.

Il confronto prestazionale canonico usa la fixture Git
`tests/fixtures/StrategiaDiegoSquare4x4.locale.xml`, SHA-256
`9EC497979E89D87C9145B9527D171A23CDA691454DDB86B53B84FAB8B2165516`,
tramite il case
`tests/radiant-harness/cases/LG041-SQUARE4X4-T1-P030-DIEGO-VITTORIO.json`.
