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

    // Copiato semanticamente dal Desktop: aggiorna soltanto le azioni ponte
    // conseguenti alla suddivisione già effettuata da Polig3D.
    public static void GestisciPontiDopoSovrapposizione(
        global::Polig3D.ElementoAssociato par1,
        global::Polig3D.ElementoAssociato par2,
        bool sdoppiato1,
        bool sdoppiato2)
    {
        if (sdoppiato1 && sdoppiato2)
        {
            global::Polig3D.nuoviPoligoni[^2].AzionePonti = global::Polig3D.AzionePontiPostConfine.RielaboraPonti;
            global::Polig3D.nuoviPoligoni[^1].AzionePonti = global::Polig3D.AzionePontiPostConfine.RielaboraPonti;
        }
        else if (sdoppiato1)
        {
            global::Polig3D.nuoviPoligoni[^1].AzionePonti = global::Polig3D.AzionePontiPostConfine.RielaboraPonti;
            par2.AzionePonti = global::Polig3D.AzionePontiPostConfine.EliminaTuttiIPonti;
        }
        else if (sdoppiato2)
        {
            global::Polig3D.nuoviPoligoni[^1].AzionePonti = global::Polig3D.AzionePontiPostConfine.RielaboraPonti;
            par1.AzionePonti = global::Polig3D.AzionePontiPostConfine.EliminaTuttiIPonti;
        }
        else
        {
            par1.AzionePonti = global::Polig3D.AzionePontiPostConfine.EliminaTuttiIPonti;
            par2.AzionePonti = global::Polig3D.AzionePontiPostConfine.EliminaTuttiIPonti;
        }
    }
}
