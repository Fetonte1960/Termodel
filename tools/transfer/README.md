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
