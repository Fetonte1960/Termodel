// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/Confini.cs
// Temporary copy. Align/move to shared source when possible.
// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/Confini.cs
// Temporary copy. Align/move to shared source when possible.
// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/Confini.cs
// Temporary copy. Align/move to shared source when possible.
// TERMODEL-SYNC: PENDING
// Source: SorgentiTermodel/Library/leggidxf/Confini.cs
// Temporary copy. Align/move to shared source when possible.
namespace Termodel.Leggidxf;

// Modificato da Codex per realizzare: punto di compatibilità headless. Le
// associazioni lette da LeggiDxf restano nei metadati; la suddivisione avanzata
// sarà portata senza simulare risultati fittizi.
internal static class Confini
{
    public static void EnsureAdvancedProcessingIsAvailable() =>
        throw new NotSupportedException("La suddivisione avanzata dei confini 3D non è ancora portata nel motore Web.");
}
