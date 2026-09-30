# Modulo Spirali — Sorgenti cruciali

Questa pagina raccoglie i punti di ingresso essenziali per il collaudo e lo sviluppo del **Modulo Spirali** di TermodelService.

Ogni path è collegato direttamente al repository GitHub, così è possibile consultare sorgenti, casi di test e linee guida dal browser senza clonare l'intero repository.

## Indice

- [Mappa dei sorgenti](#mappa-dei-sorgenti)
- [Harness e test](#harness-e-test)
- [Motori spirali](#motori-spirali)
- [Verifica architetturale Vittorio_revisionato — 30/09/2026](#verifica-architetturale-vittorio_revisionato--30092026)
- [Linee guida](#linee-guida)
- [Regression e Golden](#regression-e-golden)
- [Regola sui Golden](#regola-sui-golden)

## Mappa dei sorgenti

| Area | Path Repo | Ruolo |
|---|---|---|
| Harness | [`Server/Termodelwebservice/tools/Termodel.RadiantPanels.Harness/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/tools/Termodel.RadiantPanels.Harness) | Eseguibile di collaudo rapido delle spirali. Permette di lanciare casi sintetici o reali, scegliere il motore, produrre SVG, log e metriche e isolare Supply, Return, chiusura e raccordatura senza passare dal frontend. |
| Harness | [`Server/Termodelwebservice/tests/radiant-harness/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/tests/radiant-harness) | Banco di test dell'Harness: casi, input preparati, baseline e materiali di regression. Contiene i casi principali usati per verificare che una modifica geometrica non rompa risultati già approvati. |
| Harness / CI | [`.github/workflows/termodel-diego-vittorio-fast.yml`](https://github.com/Fetonte1960/Termodel/blob/main/.github/workflows/termodel-diego-vittorio-fast.yml) | Workflow GitHub Actions rapido per compilazione Harness/Core e regression delle strategie spirali. È il gate automatico principale per i controlli veloci su Diego_Vittorio e Vittorio_revisionato. |
| Motore | [`Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorio/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorio) | **Riferimento storico intoccabile.** Rappresenta il comportamento Vittorio originale e viene usato come confronto funzionale. Non va modificato durante gli interventi sulle strategie evolutive. |
| Motore | [`Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliDiegoVittorio/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliDiegoVittorio) | Strategia evolutiva con logica Supply, Return autonomo, chiusura combinatoria e raccordatura. È il motore con il banco di regression più esteso e contiene diversi criteri geometrici già consolidati. |
| Motore | [`Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato) | Strategia **Vittorio_revisionato**. Obiettivo architetturale: copia stretta di Vittorio con Return parallelo e sola correzione LG-051 della chiusura/raccordatura. La verifica del 30/09/2026 ha rilevato astrazioni e dipendenze Diego_Vittorio da rimuovere prima di considerarla nuovamente una derivazione stretta. |
| Linee guida | [`Server/Termodelwebservice/docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md) | Registro delle decisioni geometriche consolidate. Per chiusura e raccordatura sono particolarmente importanti **LG-048**, **LG-049** e **LG-051**. |
| Regression | [`Server/Termodelwebservice/tests/radiant-harness/cases/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/tests/radiant-harness/cases) | Casi eseguibili dal banco test. Fra quelli cruciali: `locale_1`, `locale_5`, `locale_8`, `locale_9`, quadrato pubblico Diego_Vittorio e quadrato Vittorio_revisionato. |
| Regression / Golden | [`Server/Termodelwebservice/tests/radiant-harness/baselines/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/tests/radiant-harness/baselines) | Baseline approvate usate come Golden di confronto. Nel repository corrente la directory effettiva si chiama **`baselines`**: non esiste una directory `goldens/`. Il Golden Diego_Vittorio non va aggiornato automaticamente quando cambia l'output. |

## Harness e test

Il punto di ingresso eseguibile è:

[`tools/Termodel.RadiantPanels.Harness/Program.cs`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tools/Termodel.RadiantPanels.Harness/Program.cs)

Il progetto .NET dell'Harness è:

[`tools/Termodel.RadiantPanels.Harness/Termodel.RadiantPanels.Harness.csproj`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tools/Termodel.RadiantPanels.Harness/Termodel.RadiantPanels.Harness.csproj)

Il banco di test è organizzato principalmente in:

- [`cases/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/tests/radiant-harness/cases) — casi eseguibili;
- [`prepared/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/tests/radiant-harness/prepared) — input reali o preparati;
- [`baselines/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/tests/radiant-harness/baselines) — risultati di riferimento approvati.

## Motori spirali

### Vittorio

[`SpiraliVittorio/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorio)

È il riferimento storico. Va usato per capire il comportamento originale e per confrontare le strategie successive. Durante il collaudo delle strategie evolutive deve rimanere invariato.

### Diego_Vittorio

[`SpiraliDiegoVittorio/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliDiegoVittorio)

Contiene la strategia evolutiva con Supply, Return autonomo, chiusura e raccordatura. I casi reali già consolidati costituiscono una protezione importante contro regressioni involontarie.

### Vittorio_revisionato

[`SpiraliVittorioRevisionato/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato)

La regola attuale di riferimento è **LG-051**:

```text
Mandata rettilinea + Ritorno rettilineo
        ↓
chiusura combinatoria rettilinea
        ↓
percorso rettilineo definitivo
        ↓
raccordatura con archi circolari
        ↓
SVG finale
```

La scelta della chiusura e la raccordatura sono due fasi separate.

## Verifica architetturale Vittorio_revisionato — 30/09/2026

**Esito della richiesta pubblica: confermata una contaminazione architetturale da Diego_Vittorio, con una precisazione importante.**

Il percorso pubblico corrente di `Vittorio_revisionato` **non esegue un secondo lancio autonomo del generatore per costruire il Return**. Il Return pubblico nasce ancora dal metodo parallelo di Vittorio:

- in `SpiraliVittorioRevisionato/ChiudiSpirale.cs` viene chiamato `CreaRientro(spiraleRiferimentoVittorio, distanzaRitorno)`;
- il corpo di `CreaRientro(...)` è uguale a quello presente in `SpiraliVittorio/ChiudiSpirale.cs`;
- quindi l'origine del Return del percorso pubblico resta **parallela alla Mandata**, non un vero doppio lancio indipendente.

Tuttavia `Vittorio_revisionato` **non è più una copia stretta di Vittorio**, per quattro ragioni verificabili.

1. **Astrazione neutra del generatore.**  
   [`SpiraliVittorioRevisionato/Spiralgenerator.cs`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato/Spiralgenerator.cs) introduce `SpiralGenerationInput`, `LineeCondizionamento`, `DistanzaCondizionamento` e `TerminalCenterline`, assenti dal generatore Vittorio.

2. **Il percorso pubblico modifica anche la Mandata prima della chiusura.**  
   [`SpiraliVittorioRevisionato/Program.cs`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato/Program.cs) esegue `GeneraSpirale(terminalCenterline: true)`. Quindi la derivazione pubblica non differisce da Vittorio soltanto nella chiusura: abilita anche l'estensione terminale sperimentale `TerminalCenterline`.

3. **L'astrazione supporta davvero un Return generato autonomamente, anche se non è usato dal percorso pubblico.**  
   [`StrategiaVittorioRevisionatoBenchmark.cs`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/src/Termodel.Core/RadiantPanels/StrategiaVittorioRevisionatoBenchmark.cs) contiene `CheckAbstraction()`, che effettua chiamate separate a `SpiralGenerator.Generate(...)` per `unconditionedReturn` e `conditionedReturn`, con la Supply passata come `LineeCondizionamento`. Questa è l'astrazione di doppio lancio che non appartiene all'architettura desiderata di Vittorio_revisionato.

4. **La chiusura pubblica dipende direttamente dal motore Diego_Vittorio.**  
   In [`SpiraliVittorioRevisionato/ChiudiSpirale.cs`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato/ChiudiSpirale.cs) il Return parallelo di Vittorio viene trasformato e passato a:
   - `SpiralHeatingDiegoVittorio.ChiudiSpirale.PreparaRitornoRettilineoVittorio(...)`;
   - `SpiralHeatingDiegoVittorio.ChiudiSpirale.ApplicaChiusuraCombinatoriaRettilineaVittorio(...)`.

   Inoltre `Program.cs` conserva il metodo `ChiudiSpiraleFilesDiegoVittorio()`, non richiamato dal percorso pubblico corrente ma ulteriore segno della dipendenza architetturale.

### Conclusione architetturale

La descrizione più precisa dello stato attuale è:

```text
Vittorio_revisionato pubblico
    Mandata: derivata da Vittorio MA con TerminalCenterline
    Return:  CreaRientro Vittorio parallelo
    Chiusura: helper presi direttamente da Diego_Vittorio
    Generatore: contiene anche astrazione neutra/condizionata per doppio lancio
```

Quindi:

- **corretto:** `Vittorio_revisionato` ha incorporato astrazioni Diego che non dovrebbero far parte della derivazione stretta;
- **da precisare:** il Return del percorso pubblico corrente è ancora costruito con `CreaRientro` parallelo; il doppio lancio esiste come astrazione/capacità e nel benchmark, non come sequenza effettiva del percorso pubblico;
- **obiettivo da ripristinare:** `Vittorio_revisionato = Vittorio invariato per Mandata + Return parallelo Vittorio + sola correzione LG-051 della chiusura/raccordatura`;
- la futura correzione dovrà quindi eliminare dal percorso revisionato `TerminalCenterline`, l'astrazione Return neutra/condizionata e la dipendenza diretta dal namespace `SpiralHeatingDiegoVittorio`, preservando invece `CreaRientro` Vittorio.

**Stato di questa verifica:** sola analisi. Nessun motore, Golden, Harness o frontend è stato modificato.

## Aggiornamento operativo — chiusura configurabile Vittorio_revisionato

Su indicazione dell'utente **non è stato creato alcun motore `Vittorio_modificata`**. La richiesta corretta è stata applicata direttamente a `Vittorio_revisionato`.

Implementazione pubblicata su `main`:

- `Vittorio` resta intoccabile;
- `Vittorio_revisionato` espone ora una modalità di chiusura per-request;
- `spiralClosure=true` conserva il comportamento di chiusura corrente;
- `spiralClosure=false` mantiene Mandata e Return ma lascia aperte le due estremità, senza applicare il collegamento finale e senza etichetta di chiusura;
- il frontend v1.38 espone in **Help → Motore spirali — test pubblico** il checkbox **Chiudi circuito**;
- la scelta è runtime e non viene salvata nel progetto.

Richiesta Service:

```http
POST /api/calculations?spiralEngine=Vittorio_revisionato&spiralClosure=false
```

È stata aggiunta una regression CI dedicata che richiede esplicitamente la modalità aperta e verifica la presenza dei layer Mandata/Return e l'assenza del layer di chiusura/numerazione.

**Verifica reale:** TermodelService Build #1196 / run `36705902144`: restore, JavaScript frontend, build .NET, smoke `Vittorio_revisionato` chiuso e smoke `spiralClosure=false` tutti **SUCCESS**. Il test aperto ha emesso `VITTORIO_REVISIONATO_OPEN_CIRCUITS_OK`. La verifica pubblica ha rilevato Render al commit `9c045895ef2f447bcde0f16729618794d7c56b3b` e frontend pubblico v1.38. Il workflow complessivo resta rosso per uno smoke separato di storage/lock che non è riuscito ad avviare il Service sulla propria porta di test; non riguarda il motore spirali.

Nota diagnostica: sul progetto pubblico usato nello smoke, l'SVG chiuso e quello aperto hanno lo stesso hash perché la geometria corrente non produceva comunque una chiusura applicata; il test conferma quindi il trasporto del flag e la modalità aperta, non una differenza geometrica su quel caso specifico.

## Linee guida

Documento autorevole:

[`LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/docs/spirali-strategy-register/LINEE-GUIDA-SVILUPPO-DISEGNO-SPIRALI.md)

Riferimenti principali:

- **LG-048** — chiusura rapida terminale Diego_Vittorio;
- **LG-049** — raccordi adattivi a frammentazione limitata Diego_Vittorio;
- **LG-051** — Vittorio_revisionato: chiusura rettilinea completa prima della raccordatura.

## Regression e Golden

I casi reali rettangolari principali sono:

- [`DV-PUBLIC-PANELS-RECT-01-P030-DIEGO-VITTORIO.json`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tests/radiant-harness/cases/DV-PUBLIC-PANELS-RECT-01-P030-DIEGO-VITTORIO.json) — `locale_1`;
- [`DV-PUBLIC-PANELS-RECT-05-P030-DIEGO-VITTORIO.json`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tests/radiant-harness/cases/DV-PUBLIC-PANELS-RECT-05-P030-DIEGO-VITTORIO.json) — `locale_5`;
- [`DV-PUBLIC-PANELS-RECT-08-P030-DIEGO-VITTORIO.json`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tests/radiant-harness/cases/DV-PUBLIC-PANELS-RECT-08-P030-DIEGO-VITTORIO.json) — `locale_8`;
- [`DV-PUBLIC-PANELS-RECT-09-P030-DIEGO-VITTORIO.json`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tests/radiant-harness/cases/DV-PUBLIC-PANELS-RECT-09-P030-DIEGO-VITTORIO.json) — `locale_9`;
- [`DV-PUBLIC-SQUARE-LEFT-P030-DIEGO-VITTORIO.json`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tests/radiant-harness/cases/DV-PUBLIC-SQUARE-LEFT-P030-DIEGO-VITTORIO.json) — quadrato pubblico Diego_Vittorio;
- [`LG041-SQUARE4X4-T1-P030-VITTORIO-REVISIONATO.json`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tests/radiant-harness/cases/LG041-SQUARE4X4-T1-P030-VITTORIO-REVISIONATO.json) — quadrato di controllo Vittorio_revisionato.

Il Golden attivo del quadrato pubblico Diego_Vittorio è:

[`baselines/DV-PUBLIC-SQUARE-LEFT-P030-DIEGO-VITTORIO.json`](https://github.com/Fetonte1960/Termodel/blob/main/Server/Termodelwebservice/tests/radiant-harness/baselines/DV-PUBLIC-SQUARE-LEFT-P030-DIEGO-VITTORIO.json)

## Regola sui Golden

> **Non aggiornare il Golden Diego_Vittorio alla cieca.**
>
> Se il risultato geometrico cambia, la differenza deve essere prima riprodotta, compresa e verificata. Un Golden va aggiornato solo dopo aver stabilito che il nuovo risultato è quello corretto e approvato; non va mai usato l'aggiornamento del Golden per trasformare automaticamente una regressione in un test verde.

---

Repository: [Fetonte1960/Termodel](https://github.com/Fetonte1960/Termodel)
