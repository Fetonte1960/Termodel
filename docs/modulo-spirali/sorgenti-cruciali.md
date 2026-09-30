# Modulo Spirali — Sorgenti cruciali

Questa pagina raccoglie i punti di ingresso essenziali per il collaudo e lo sviluppo del **Modulo Spirali** di TermodelService.

Ogni path è collegato direttamente al repository GitHub, così è possibile consultare sorgenti, casi di test e linee guida dal browser senza clonare l'intero repository.

## Indice

- [Mappa dei sorgenti](#mappa-dei-sorgenti)
- [Harness e test](#harness-e-test)
- [Motori spirali](#motori-spirali)
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
| Motore | [`Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato/`](https://github.com/Fetonte1960/Termodel/tree/main/Server/Termodelwebservice/src/Termodel.Core/CopiedFromTermodel/SpiraliVittorioRevisionato) | Strategia **Vittorio_revisionato**, attualmente basata su LG-051: chiusura rettilinea completa prima della raccordatura, poi archi circolari tangenti con parametri locali. È la linea in collaudo per la chiusura finale. |
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
