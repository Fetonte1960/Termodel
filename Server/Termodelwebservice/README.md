# Termodel WebService

Soluzione sperimentale e autonoma per estrarre progressivamente il motore Termodel in un Core C# utilizzabile da ASP.NET Core.

## Progetti

- `Termodel.Core`: libreria `.NET 8` senza WPF, form o visualizzazione 3D.
- `Termodel.WebService`: Web API ASP.NET Core che espone il Core.

## Funzioni disponibili

```text
GET  /
GET  /health
GET  /api/model/capabilities
POST /api/model/3d
POST /api/projects/new
```

`POST /api/model/3d` riceve nel body il file unico completo
`TERMODEL-PROJECT-TEXT-V1` con `Content-Type: text/plain; charset=utf-8` e
restituisce direttamente `TermodelWebModel` versione 3 in JSON. La generazione
legge lo SVG multipiano e gli archivi XML incorporati, è serializzata per
isolare lo stato storico del motore e non produce IFC. Un formato non valido o
una funzione CAD non supportata restituisce `422`; un Content-Type diverso da
`text/plain` restituisce `415`.

`POST /api/projects/new` genera il contenitore testuale UTF-8 `TERMODEL-PROJECT-TEXT-V1`. Il progetto iniziale viene clonato da `src/Termodel.WebService/Templates/ProgettoBase`, snapshot consolidato del progetto realmente proposto da Termodel desktop. La copia di distribuzione `Definitions/definizionedati.json` rimane il riferimento per controllo e validazione dello schema; non viene più usata per fabbricare archivi vuoti.

La copia inclusa rende la soluzione compilabile senza una cartella Termodel gemella. Non deve essere modificata autonomamente: ogni aggiornamento deve partire dall'originale autorevole, essere autorizzato espressamente e concludersi con il confronto delle impronte SHA-256.

Richiesta minima:

```json
{
  "nomeProgetto": "Prova",
  "piani": [
    {
      "id": "F001",
      "nome": "Piano terra",
      "tipo": "Calpestabile",
      "nomeFile": "DisegnoInput",
      "layerCad": "Piano terra",
      "altezzaNetta": 3.0,
      "altezzaLorda": 3.3,
      "pianiUguali": 1,
      "svg": "<svg xmlns=\"http://www.w3.org/2000/svg\"><g id=\"calpestabile\"><line x1=\"0\" y1=\"0\" x2=\"400\" y2=\"0\" /></g></svg>"
    }
  ]
}
```

Se `piani` è omesso viene creato il piano calpestabile predefinito. Gli altri archivi sono clonati dal progetto base incorporato; eventuali archivi forniti nella richiesta sostituiscono quelli omonimi dopo validazione. Il contenitore comprende anche `project/DisegnoInput.dxf`, `thermal/input.xml` e `thermal/input.json`.

## Regole iniziali

- Termodel desktop resta il riferimento funzionale e algoritmico.
- `definizionedati/definizionedati.json` non deve essere modificato senza autorizzazione specifica.
- Le migrazioni saranno selettive e progressive.
- Non introdurre WPF, HelixToolkit o form nel Core.
- Registrare origine e adattamenti di ogni sorgente importato.
- Confrontare gli output del Core con quelli del desktop prima di considerare una fase verificata.

La soluzione è stata compilata su copia temporanea il 21 settembre 2026 con
0 errori. Il contratto HTTP di `POST /api/model/3d` è stato provato con
`ProgettoVuoto`; il confronto golden del progetto mansardato avanzato rimane da
eseguire dopo la produzione del relativo file unico SVG.

Aprire `Termodel.WebService.sln` con Visual Studio 2022.

## Collegamento dal frontend pubblico

Il WebService autorizza tramite CORS l'origine `https://www.termodel.it` per `GET`, `POST` e `OPTIONS`, inclusi gli header richiesti dal preflight. Per compatibilità con richieste Chrome Private Network Access, un preflight autorizzato che invia `Access-Control-Request-Private-Network: true` riceve `Access-Control-Allow-Private-Network: true`.

Chrome applica inoltre il permesso Local Network Access alle chiamate da un sito pubblico verso `localhost`; l'utente deve concedere tale permesso al sito. La configurazione server non può superare un rifiuto espresso nel browser.
