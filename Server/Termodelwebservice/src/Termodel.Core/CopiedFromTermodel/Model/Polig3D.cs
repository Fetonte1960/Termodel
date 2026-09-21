using Termodel.Leggidxf;

// Modificato da Codex per realizzare: sostituzione del contenitore IFC con il
// catalogo semantico headless richiesto dal WebService. L'originale e il suo
// hash sono registrati in docs/copied-from-termodel.md.
public static class Polig3D
{
    public enum TipoPiano { Nessuno, Calpestabile, Copertura }
    public enum TipoElemento { Nessuno, Parete, Finestra, Pavimento, Soffitto, Falda, Mansardato, Ponte, Sced }

    public sealed record PianoInfo(string Nome, double Elevazione, TipoPiano Tipo);
    public sealed record LocaleInfo(string Nome, string Piano, TDatilocale Dati);

    public static List<PianoInfo> Piani { get; } = [];
    public static List<LocaleInfo> Locali { get; } = [];

    // Funzione realizzata da Codex in autonomia
    public static void ClearAll()
    {
        Piani.Clear();
        Locali.Clear();
    }

    // Funzione realizzata da Codex in autonomia
    public static void AggiungiPiano(string nome, double elevazione, TipoPiano tipo) =>
        Piani.Add(new PianoInfo(nome, elevazione, tipo));

    // Funzione realizzata da Codex in autonomia
    public static void AggiungiLocale(string nome, string piano, TDatilocale dati) =>
        Locali.Add(new LocaleInfo(nome, piano, dati));

    // Funzione realizzata da Codex in autonomia
    public static TipoPiano StringToInTipoPiano(string value) =>
        string.Equals(value, "Copertura", StringComparison.OrdinalIgnoreCase)
            ? TipoPiano.Copertura
            : TipoPiano.Calpestabile;
}
