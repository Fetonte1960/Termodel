# Copie selettive da Termodel desktop

Documento di tracciamento per il motore `Modello3D` del WebService.

Le copie presenti sotto `src/Termodel.Core/CopiedFromTermodel` sono una fase
temporanea di migrazione. Gli originali Termodel desktop non vengono modificati.
Ogni adattamento deve essere minimo, commentato e classificato come modifica
riportabile nel Core condiviso oppure esclusiva del server.

## Regole

- `definizionedati/definizionedati.json` resta la fonte autorevole e non viene modificato.
- WPF, Helix e IFC non fanno parte del percorso Web.
- Le funzioni database, geometriche e di validazione usate dal modello sono reali.
- Le sole funzioni di UI o diagnostica grafica possono essere no-op controllati.
- Una funzione funzionale non supportata genera `NotSupportedException`; non restituisce successo fittizio.
- La chiusura statica delle dipendenze è completata; la soluzione è stata compilata
  su copia temporanea il 21 settembre 2026 con 0 errori.

## Inventario iniziale

| Copia WebService | Originale desktop | Trattamento previsto |
|---|---|---|
| `CopiedFromTermodel/Leggidxf/GeneraModello.cs` | `Leggidxf/GeneraModello.cs` | orchestratore completo ridotto, a istanza e headless |
| `CopiedFromTermodel/Leggidxf/GeneraPianta.cs` | `Leggidxf/GeneraPianta.cs` | geometria pulita reale; serializzazione SVG al posto del DXF |
| `CopiedFromTermodel/Leggidxf/LeggiDxf.cs` | `Leggidxf/LeggiDxf.cs` | logica principale, modifiche minime |
| `CopiedFromTermodel/Leggidxf/DXFLineCheck.cs` | `Leggidxf/DXFLineCheck.cs` | geometria/topologia reale |
| `CopiedFromTermodel/Leggidxf/Tetti.cs` | `Leggidxf/Tetti.cs` | geometria reale, contenitori IFC sostituiti |
| `CopiedFromTermodel/Leggidxf/Confini.cs` | `Leggidxf/Confini.cs` | regole reali, geometria neutra |
| `CopiedFromTermodel/Model/Polig3D.cs` | `Leggidxf/Polig3D.cs` | semantica reale, output IFC escluso |
| `CopiedFromTermodel/Model/Modello.cs` | `Modello.cs` | facciata compatibile headless |

## Dipendenze sostitutive

| Dipendenza desktop | Sostituzione WebService |
|---|---|
| `netDxf` | `Termodel.NetDxfCompat`, popolato dallo SVG del file unico |
| `UtiDb` / `Database.DB` | archivi XML del file unico in memoria |
| `GestProg` | contesto isolato della richiesta |
| `TermodelLog` | diagnostica strutturata per la risposta HTTP |
| WPF / Helix | no-op controllati o sink diagnostico |
| Xbim / IFC | tipi geometrici neutrali e `TermodelWebModel` JSON |

## Provenienza verificata

| File | SHA-256 |
|---|---|
| Desktop `Leggidxf/GeneraModello.cs` | `2D2B607EDD9680945C9195BAF5205005DFE9DD6C3BB7ED31E14D71509BF7C504` |
| Copia ridotta `CopiedFromTermodel/Leggidxf/GeneraModello.cs` | `937C1F2B418AB454FF1D60BBCF0B26D09F87AF15065A4DF6E967084A0710D4CE` |
| Desktop `Leggidxf/GeneraPianta.cs` | `26715FA5E614504DBD1B3D7DDA08717E161AC7F485AF074368104DA1AB4ED407` |
| Copia SVG `CopiedFromTermodel/Leggidxf/GeneraPianta.cs` | `2978BB3A1B3EA0006924E0A80161698C247BBF0133D8C3C91FD510A0F51A97EA` |

Gli hash differenti sono intenzionali: la copia conserva l'algoritmo di
orchestrazione ma sostituisce UI, filesystem DXF e chiusura IFC con gli adattatori
headless del file unico.

`GeneraPianta` conserva temporaneamente il nome storico `SalvaDXF` per ridurre
il delta con il desktop, ma nel percorso Web non legge né scrive DXF: pubblica
uno SVG `TERMODEL-CLEAN-FLOOR-SVG-V1` per nome piano. Il WebService lo espone
con `GET /api/model/clean-floor/{floorName}`.

## Endpoint Modello3D

`POST /api/model/3d` accetta il file unico come `text/plain; charset=utf-8` e
restituisce direttamente `TermodelWebModel` v3 come `application/json`. Il
percorso usa `GeneraModello.GeneraAsync`, protetto da un gate seriale, quindi
carica archivi XML, converte lo SVG nella compatibilità `netDxf` minima ed
esegue `LeggiDxf` e le classi geometriche collegate senza produrre IFC.

Verifica del 21 settembre 2026: build con 0 errori; richiesta con
`ProgettoVuoto` risolta con HTTP 200 e modello valido a 0 primitive; richiesta
con Content-Type errato risolta con HTTP 415. Il golden test del progetto
mansardato resta aperto perché la cartella desktop contiene DXF e il precedente
`TermodelWebModel.json` (546 primitive), ma non ancora lo SVG multipiano nel
file unico richiesto dal nuovo endpoint.
