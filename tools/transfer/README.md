# Termodel Git Transfer

Questo strumento presuppone che il repository `Fetonte1960/Termodel` sia clonato nella cartella `GitHub` posta direttamente dentro la radice dei sorgenti Termodel.

Struttura prevista:

```text
TermodelSorgenti/
├─ Finestre/
├─ Impianti/
│  └─ Pannelli/
│     └─ SpiraliGPT/
└─ GitHub/                 <- clone del repository Fetonte1960/Termodel
   ├─ docs/
   ├─ workspace/
   ├─ transfer-map.json
   └─ tools/transfer/
```

## Uso rapido

Avvia con doppio clic:

```text
tools\transfer\TermodelGit.cmd
```

Le operazioni principali sono:

- **Esporta**: copia i moduli abilitati dai sorgenti reali a `GitHub\workspace`. Per il workspace usa una copia speculare, quindi anche le cancellazioni locali vengono riflesse soltanto nel workspace.
- **Importa**: copia dal workspace ai sorgenti Termodel. Prima salva una copia del contenuto locale in `GitHub\_backups`. L'importazione e volutamente non distruttiva: non cancella dai sorgenti reali file assenti nel workspace.
- **Stato**: confronta i file tramite hash SHA-256.
- **Pull**: recupera le modifiche dal repository remoto.
- **Push**: pubblica soltanto `workspace`, `transfer-map.json`, gli strumenti di transfer e `.gitignore`.
- **Ricevi completo**: `git pull` seguito da importazione nei sorgenti reali.
- **Pubblica completo**: esportazione dai sorgenti reali seguita da commit e push.

## Mapping

I moduli condivisi sono definiti in `transfer-map.json`.

Esempio:

```json
{
  "name": "SpiraliGPT",
  "source": "Impianti\\Pannelli\\SpiraliGPT",
  "target": "Impianti\\Pannelli\\SpiraliGPT",
  "enabled": true
}
```

`source` e relativo alla radice dei sorgenti Termodel; `target` e relativo a `GitHub\workspace`.

Per affidare un nuovo modulo a GPT basta aggiungere un mapping. Non e necessario mettere l'intera soluzione su GitHub.

## Termodel WebService

### Comando consigliato dopo un lavoro locale Codex / Visual Studio

Per pubblicare **solo TermodelService** dopo che Codex o Visual Studio hanno
modificato il sorgente locale usare, dalla radice del clone:

```text
PUBBLICA_TERMODEL_SERVICE_LOCALE_SICURO.cmd
```

È il percorso consigliato perché esegue automaticamente tutta la sequenza:

1. richiede il clone Git pulito e il branch `main`;
2. aggiorna il clone con `origin/main` in fast-forward;
3. esporta il solo mapping `TermodelWebService`;
4. rifiuta modifiche comparse fuori da `Server/Termodelwebservice`;
5. compila `Server/Termodelwebservice/Termodel.WebService.sln`;
6. mostra i soli file Service pronti per il commit;
7. chiede una sola conferma finale `S/N`;
8. crea commit e push senza force-push.

Se copia o build falliscono prima del commit, il CMD ripulisce esclusivamente
la copia nel clone: i sorgenti locali modificati da Codex/Visual Studio
rimangono intatti. Se invece nasce un conflitto dopo il commit, il CMD non
forza il remoto e chiede di mostrare la schermata a ChatGPT.

**Quando usarlo:** ogni volta che il lavoro corretto esiste nel
`Termodelwebservice` locale e deve essere trasferito su GitHub.

**Quando non usarlo:** per portare GitHub verso il PC. In quel caso usare il
flusso di download/import dedicato.

Il precedente `PUBBLICA_MODIFICHE_LOCALI_NEL_GITHUB_REMOTO.cmd` rimane uno
strumento generico dell'intero clone; per il normale lavoro sul Service è
preferibile il CMD sicuro dedicato sopra.


Il mapping `TermodelWebService` usa direttamente la destinazione versionata
`Server/Termodelwebservice`, invece del precedente `workspace`. Per limitare le
operazioni a questo modulo usare:

```powershell
tools\transfer\TermodelTransfer.ps1 -Action status -Name TermodelWebService
tools\transfer\TermodelTransfer.ps1 -Action export -Name TermodelWebService
tools\transfer\TermodelTransfer.ps1 -Action import -Name TermodelWebService
```

Eseguire sempre `status` prima di una copia. `export` rende la copia GitHub
speculare al sorgente locale; `import` non cancella file locali e crea prima un
backup sotto `_backups`.

- `COPIA_TERMODEL_SERVICE_LOCALE_NEL_CLONE_GITHUB.cmd` copia il Service locale
  nella cartella versionata del clone, ma non crea commit e non esegue push;
- `SCARICA_GITHUB_E_PREPARA_TERMODEL_SERVICE_LOCALE.cmd`, nella radice del
  repository, controlla che Git sia pulito, scarica `origin/main` soltanto in
  fast-forward e copia con backup i sorgenti del Service nel workspace locale,
  pronti per essere ricompilati manualmente con Visual Studio;
- `PUBBLICA_MODIFICHE_LOCALI_NEL_GITHUB_REMOTO.cmd`, nella radice, crea il
  commit delle modifiche locali autorizzate e le pubblica sul remoto, escludendo
  `SorgentiTermodel/Work`.


#### Nota dopo il primo test Windows del publisher sicuro

Il wrapper `PUBBLICA_TERMODEL_SERVICE_LOCALE_SICURO.cmd` gestisce anche il
caso in cui il clone contenga gia' modifiche pregresse del solo Service:

- salva automaticamente tali modifiche in uno stash Git di sicurezza;
- aggiorna il clone da `origin/main`;
- esporta il Service locale;
- compila prima della pubblicazione;
- esclude automaticamente dalla pubblicazione tutti i file Markdown e ogni
  `definizionedati.json`;
- continua a fermarsi se trova modifiche fuori da
  `Server/Termodelwebservice`;
- non usa force-push.

La sorgente locale Codex/Visual Studio non viene mai modificata dal wrapper.


#### Esclusioni locali permanenti del publisher Service

Il publisher sicuro esclude inoltre, sia dalla build di verifica del clone sia
dallo staging/push, questi due sorgenti locali:

- `src/Termodel.WebService/Calculations/CalculationSnapshotStore.cs`;
- `src/Termodel.WebService/Calculations/SavedProjectStore.cs`.

I file restano intatti nel sorgente locale Codex/Visual Studio. Dopo l'export
vengono rimossi soltanto dalla copia GitHub quando non sono versionati; se in
futuro esistessero gia' nel repository, viene mantenuta la versione GitHub.
