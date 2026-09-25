# StrategiaDiego — banco prova corrente appartamento

Data consolidamento: **25/09/2026**

## Ruolo

Il file:

```text
StrategiaDiegoCurrentApartment.project.tmdl
```

è il **banco prova operativo corrente e autorevole** per lo sviluppo e il
debug della StrategiaDiego su un progetto reale.

Non sostituisce le fixture sintetiche:

- `StrategiaDiegoSquare4x4.locale.xml`;
- `StrategiaDiegoConcaveL.locale.xml`.

Queste restano regression rapide e isolate. Il progetto appartamento corrente
è invece la fixture primaria per trovare e correggere problemi strategici reali
locale per locale.

## Provenienza e integrità

Il file è la copia **non modificata** del `TERMODEL-PROJECT-TEXT-V1`
fornito dall'utente il 25/09/2026.

Dati identificativi del manifest originale:

```text
projectId:      07bf8dca-dc86-41ea-8844-1aaca58888f0
piano:          Unico
generatedAtUtc: 2026-09-25T06:16:04.350Z
```

SHA-256 del file originale UTF-8:

```text
1a5855490adcbac25e5585f9ba89c624eb2381874eb2de8bdc74821a40d2a9a5
```

Il contenuto interno, incluso `definition/definizionedati.json`, non deve
essere corretto o normalizzato dentro la fixture. Qualunque adattamento
necessario per un test deve avvenire nella harness e deve essere esplicito.

## Uso GitHub Actions

La harness dedicata è:

```text
tools/smoke-strategia-diego-current-apartment.ps1
```

La prova:

1. verifica l'hash della fixture;
2. forza `TERMODEL_SPIRAL_ENGINE=Diego`;
3. avvia `Termodel.WebService` in un workspace temporaneo;
4. invia la fixture a `POST /api/calculations?responseArtifact=pannelli-esecutivo-svg`;
5. salva direttamente l'SVG restituito;
6. raccoglie catalogo `generated-files`, pannelli, DXF e log disponibili;
7. pubblica il pacchetto diagnostico Action `strategia-diego-current-apartment`.

## Ciclo di sviluppo autorizzato

```text
screenshot + numero locale
        ↓
riproduzione sulla fixture corrente
        ↓
prima decisione strategica errata
        ↓
LG esistente violata?
  sì -> correggere implementazione
  no -> definire nuova LG
        ↓
correzione minima e tracciabile
        ↓
GitHub Action sulla stessa fixture
        ↓
confronto prima/dopo + regression
```

Non aggiornare automaticamente un Golden Result. Al 25/09/2026 non esiste
ancora un Golden geometrico approvato dell'intero appartamento.

Un futuro aggiornamento del banco prova deve essere esplicitamente
commissionato: questa snapshot non va modificata silenziosamente.
