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
| `Model/Polig3D.cs` | `SorgentiTermodel/Library/leggidxf/Polig3D.cs` | PENDING |
| `Model/Modello.cs` | `SorgentiTermodel/Library/Modello.cs` | PENDING |

Il supporto desktop `SorgentiTermodel/Library/utilities/ErrorManager.cs` è
sostituito nel Service da un sink diagnostico headless in
`Compatibility/LegacyUiDummies.cs`.

La Library rimane la sola raccolta consultiva: può essere integrata soltanto con
copie non adattate di sorgenti desktop selezionati, dopo autorizzazione esplicita
e verifica SHA-256. Gli adattamenti continuano a vivere nel Service o in Work.

Riferimenti integrati il 21 settembre 2026:

- `Modello.cs`: `7B201DA17781CB2682EC9AF25D798B753EC590850031572A4A07E63975B125F0`;
- `utilities/ErrorManager.cs`: `6A7E93D009526D4DA5ED0F800B6155AB0B90C52237C13E76CEC52C4204863ECD`.

Obiettivo progressivo: eliminare le copie quando il codice cruciale potrà essere
condiviso realmente fra desktop e Service senza dipendenze WPF, Helix o IFC.
