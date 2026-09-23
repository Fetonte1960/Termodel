# TERMODEL-SYNC — copie desktop temporanee

Stato generale: `PENDING`.

Questa directory contiene copie selettive e adattate del motore Termodel
desktop. Non costituisce una seconda Library autorevole. Ogni modifica deve
restare minima, commentata e confrontabile con il riferimento indicato.

| Copia Service | Riferimento desktop GitHub | Stato |
|---|---|---|
| `Leggidxf/Confini.cs` | `SorgentiTermodel/Library/leggidxf/Confini.cs` | PENDING |
| `Leggidxf/DXFLineCheck.cs` | `SorgentiTermodel/Library/leggidxf/DXFLineCheck.cs` | PENDING |
| `Leggidxf/GeneraModello.cs` | `SorgentiTermodel/Library/leggidxf/GeneraModello.cs` | PENDING |
| `Leggidxf/GeneraPianta.cs` | `SorgentiTermodel/Library/leggidxf/GeneraPianta.cs` | PENDING |
| `Leggidxf/LeggiDxf.cs` | `SorgentiTermodel/Library/leggidxf/LeggiDxf.cs` | PENDING |
| `Leggidxf/Tetti.cs` | `SorgentiTermodel/Library/leggidxf/Tetti.cs` | PENDING |
| `Model/Polig3D.cs` | `SorgentiTermodel/Library/leggidxf/Polig3D.cs` | PENDING — BYTE-IDENTICAL, Git blob `d7d835a8a39febb3c3b26bcb88a8cc5cebb19411` |
| `Model/Modello.cs` | `SorgentiTermodel/Library/Modello.cs` | PENDING |

Il sorgente autorevole Desktop di `TermodelLog` è ora disponibile come copia
non adattata in `SorgentiTermodel/Library/utilities/TermodelLog.cs`:

```text
origine locale: utilities/TermodelLog.cs
SHA-256: 79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218
```

Il Service continua a usare
`Compatibility/LegacyCoreAdapters.cs::TermodelLog`. Il confronto conferma che
non è una copia mancante da inserire nel runtime, ma un adattatore necessario:
il Desktop scrive file globali sotto `GestProg.ProgramPath`, usa WPF per
mostrare il primo errore e contiene diagnostica grafica dipendente da xBIM/NTS;
il Service deve invece isolare la richiesta con `AsyncLocal`, restituire la
diagnostica a `GeneraModello` e pubblicarla transazionalmente nel workspace del
`projectId`.

Le categorie Desktop autorevoli sono `Sempre`, `colmi`, `spezza`, `Error`,
`Svg`, `RedrawHelix`, `GeneraModello`, `Performance` e `PontiAutomatici`.
I flag costanti del Desktop corrente abilitano soltanto
`PontiAutomatici`.

L'adattatore headless usa ora gli stessi nomi categoria ma mantiene una
semantica server compatibile con il comportamento già pubblicato:

- senza opzioni esplicite di calcolo, tutte le scritture dirette vengono
  raccolte e `IsEnabled(...)` resta falso;
- con `logCategories` esplicito, la configurazione è per-request tramite
  `AsyncLocal`: `IsEnabled(...)` e le scritture dirette rispettano
  esclusivamente le categorie selezionate;
- `LogOperation` è associato a `Sempre`, `LogError` a `Error`;
- `logEnabled=false` spegne la raccolta soltanto per la richiesta corrente.

Questa configurazione non viene riportata nel file progetto e non modifica il
riferimento Desktop: è un adattamento di hosting/diagnostica del Service.

Il supporto desktop `SorgentiTermodel/Library/utilities/ErrorManager.cs` è
sostituito nel Service da un sink diagnostico headless in
`Compatibility/LegacyUiDummies.cs`.

La Library rimane la sola raccolta consultiva: può essere integrata soltanto con
copie non adattate di sorgenti desktop selezionati, dopo autorizzazione esplicita
e verifica SHA-256. Gli adattamenti continuano a vivere nel Service o in Work.

Riferimenti integrati il 21 settembre 2026:

- `Modello.cs`: `7B201DA17781CB2682EC9AF25D798B753EC590850031572A4A07E63975B125F0`;
- `utilities/ErrorManager.cs`: `6A7E93D009526D4DA5ED0F800B6155AB0B90C52237C13E76CEC52C4204863ECD`.

Riferimento integrato il 23 settembre 2026:

- `utilities/TermodelLog.cs`: `79C4143C34407575C70DD22E8279F1FFE0F078B55CA095549A31A4E6174B4218`.

Obiettivo progressivo: eliminare le copie quando il codice cruciale potrà essere
condiviso realmente fra desktop e Service senza dipendenze WPF, Helix o IFC.
