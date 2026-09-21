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
| `Model/Modello.cs` | originale desktop `Modello.cs`; riferimento Library ancora mancante | PENDING |

Il supporto desktop `utilities/ErrorManager.cs` è sostituito nel Service da un
sink diagnostico headless in `Compatibility/LegacyUiDummies.cs`; anche questo
riferimento manca attualmente dalla Library GitHub. La Library è in sola lettura:
le integrazioni vanno preparate in `SorgentiTermodel/Work` e pubblicate nella
Library soltanto attraverso un intervento specificamente autorizzato che ne
rispetti le regole di manutenzione.

Obiettivo progressivo: eliminare le copie quando il codice cruciale potrà essere
condiviso realmente fra desktop e Service senza dipendenze WPF, Helix o IFC.
