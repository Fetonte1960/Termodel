using System.Collections.ObjectModel;
using System.Globalization;
// Modificato da Codex per realizzare: collegare l'adattatore UtiDb al database del file unico.
using Termodel.Core.Compatibility;
using Termodel.Core.ProjectFiles;

namespace Termodel.utilities
{
    // Modificato da Codex per realizzare: compatibilità minima del formato UserData
    // usato dalla copia selettiva di LeggiDxf, senza dipendenze desktop.
    public enum PUserdata { colore = 1, tlinea = 2, Z1 = 3, Z2 = 4, ColDeb = 5 }

    public static class Utigen
    {
        // Funzione realizzata da Codex in autonomia
        public static string Get_Z(object? userData, int vertex) =>
            GetItemFromCommaSeparatedString(userData?.ToString(), vertex == 1 ? (int)PUserdata.Z1 : (int)PUserdata.Z2);

        // Funzione realizzata da Codex in autonomia
        public static string SetUserdataValue(string? userData, string value, PUserdata position)
        {
            Dictionary<PUserdata, string> values = UserdataToDict(userData);
            values[position] = value;
            return DictToUserdata(values);
        }

        // Funzione realizzata da Codex in autonomia
        public static Dictionary<PUserdata, string> UserdataToDict(string? userData) =>
            Enum.GetValues<PUserdata>().ToDictionary(item => item, item => GetItemFromCommaSeparatedString(userData, (int)item));

        // Funzione realizzata da Codex in autonomia
        public static string DictToUserdata(IReadOnlyDictionary<PUserdata, string> values) =>
            string.Join('|', Enum.GetValues<PUserdata>().Select(item => values.TryGetValue(item, out string? value) ? value : string.Empty));

        // Funzione realizzata da Codex in autonomia
        public static string GetItemFromCommaSeparatedString(string? value, int oneBasedIndex)
        {
            if (string.IsNullOrEmpty(value) || oneBasedIndex < 1) return string.Empty;
            string[] items = value.Split('|');
            return oneBasedIndex <= items.Length ? items[oneBasedIndex - 1].Trim() : string.Empty;
        }

        // Funzione realizzata da Codex in autonomia
        public static double CVStrToDouble(string? value)
        {
            if (string.IsNullOrWhiteSpace(value)) return double.NaN;
            return double.TryParse(value.Replace(',', '.'), NumberStyles.Float, CultureInfo.InvariantCulture, out double result)
                ? result
                : double.NaN;
        }

        public static double CVStrToDouble_attrib(string? value) => CVStrToDouble(value);
        public static string DoubleToStrPunto(double value) => value.ToString(CultureInfo.InvariantCulture);

        // Modificato da Codex per realizzare: nel Core headless un attributo numerico
        // non valido genera un errore esplicito invece di una segnalazione grafica.
        public static void VerificaAttributoNumero(
            string blockName, string attributeName, Dictionary<string, object> block, string? value, double floorElevation)
        {
            if (!double.IsFinite(CVStrToDouble(value)))
                throw new InvalidDataException(
                    $"Blocco '{blockName}', attributo '{attributeName}' non numerico al piano {floorElevation.ToString(CultureInfo.InvariantCulture)}.");
        }
    }

    // Modificato da Codex per realizzare: adattatore UtiDb sugli archivi XML
    // realmente caricati dal TERMODEL-PROJECT-TEXT-V1.
    public sealed class UtiDb
    {
        public enum CategoriaZona { DaCalcolare, Balcone, PozzoLuce, Adiacente, Unclassified }

        public UtiDb(ProjectArchiveDatabase database) => Database = database;
        public ProjectArchiveDatabase Database { get; }
        public ObservableCollection<Dictionary<string, object>> GetCollection(string name) => Database.GetCollection(name);
        public string GetDataDB(string keyField, object? findData, string returnField,
            IEnumerable<Dictionary<string, object>> rows) => Database.GetDataDB(keyField, findData, returnField, rows);
        public string GetDataDBSingleRow(string returnField, IEnumerable<Dictionary<string, object>> rows) =>
            Database.GetDataDBSingleRow(returnField, rows);
        public bool ItemNessuno(object? value) => Database.ItemNessuno(value);

        // Modificato da Codex per realizzare: validazione archivio headless con errore strutturato.
        public void VerificaAttributoArchivio(string blockName, string attributeName,
            Dictionary<string, object> block, string value, string archive, string key, double floorElevation) =>
            Database.RequireReferencedValue($"Blocco '{blockName}', attributo '{attributeName}'", value, archive, key);
    }

    // Modificato da Codex per realizzare: diagnostica in memoria priva di UI.
    public static class TermodelLog
    {
        public enum LogCategory { generale, colmi, spezza }
        private static readonly AsyncLocal<List<string>?> CurrentMessages = new();
        public static string LogContesto { get; set; } = string.Empty;
        public static IReadOnlyList<string> Messages => CurrentMessages.Value ?? [];
        public static void Reset() => CurrentMessages.Value = [];
        public static bool IsEnabled(LogCategory category) => false;
        public static void WriteLog(string message, LogCategory category = LogCategory.generale) => Add("info", message);
        public static void LogOperation(string message) => Add("operation", message);
        public static void LogError(string message) => Add("error", message);
        private static void Add(string level, string message) => (CurrentMessages.Value ??= []).Add($"{level}: {LogContesto}{message}");
    }
}

namespace Database
{
    using static Termodel.utilities.UtiDb;

    // Modificato da Codex per realizzare: ponte statico circoscritto alla singola
    // generazione serializzata, necessario finché LeggiDxf usa Database.DB.
    public static class DB
    {
        private static readonly AsyncLocal<Termodel.utilities.UtiDb?> Current = new();
        public static void Use(Termodel.utilities.UtiDb database) => Current.Value = database;
        public static void Clear() => Current.Value = null;
        private static Termodel.utilities.UtiDb Active => Current.Value ??
            throw new InvalidOperationException("Database del progetto non inizializzato per la generazione 3D.");
        public static ObservableCollection<Dictionary<string, object>> GetCollection(string name) => Active.GetCollection(name);
        public static string GetDataDB(string keyField, object? findData, string returnField,
            IEnumerable<Dictionary<string, object>> rows) => Active.GetDataDB(keyField, findData, returnField, rows);

        // Funzione realizzata da Codex in autonomia
        public static bool TipoZona(CategoriaZona category, string code)
        {
            Dictionary<string, object>? row = Active.GetCollection("Zone").FirstOrDefault(candidate =>
                candidate.TryGetValue("Codice", out object? value) &&
                string.Equals(Convert.ToString(value, CultureInfo.InvariantCulture), code, StringComparison.Ordinal));
            if (row is null) return false;
            string type = row.TryGetValue("Tipo", out object? raw) ? Convert.ToString(raw, CultureInfo.InvariantCulture) ?? string.Empty : string.Empty;
            return category switch
            {
                CategoriaZona.DaCalcolare => type == "AmbienteClimatizzato",
                CategoriaZona.Balcone => type == "Balcone",
                CategoriaZona.PozzoLuce => type == "Pozzo luce",
                CategoriaZona.Adiacente => type == "Adiacente",
                _ => false
            };
        }
    }
}
