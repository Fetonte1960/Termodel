using System.Collections.ObjectModel;
using System.Globalization;
using Termodel.Core.Compatibility;
using Termodel.Core.ProjectFiles;

namespace Termodel.utilities
{
    public enum PUserdata { colore = 1, tlinea = 2, Z1 = 3, Z2 = 4, ColDeb = 5 }

    public static class Utigen
    {
        public static string Get_Z(object? userData, int vertex) =>
            GetItemFromCommaSeparatedString(userData?.ToString(), vertex == 1 ? (int)PUserdata.Z1 : (int)PUserdata.Z2);

        public static string SetUserdataValue(string? userData, string value, PUserdata position)
        {
            Dictionary<PUserdata, string> values = UserdataToDict(userData);
            values[position] = value;
            return DictToUserdata(values);
        }

        public static Dictionary<PUserdata, string> UserdataToDict(string? userData) =>
            Enum.GetValues<PUserdata>()
                .ToDictionary(item => item, item => GetItemFromCommaSeparatedString(userData, (int)item));

        public static string DictToUserdata(IReadOnlyDictionary<PUserdata, string> values) =>
            string.Join('|', Enum.GetValues<PUserdata>()
                .Select(item => values.TryGetValue(item, out string? value) ? value : string.Empty));

        public static string GetItemFromCommaSeparatedString(string? value, int oneBasedIndex)
        {
            if (string.IsNullOrEmpty(value) || oneBasedIndex < 1) return string.Empty;
            string[] items = value.Split('|');
            return oneBasedIndex <= items.Length ? items[oneBasedIndex - 1].Trim() : string.Empty;
        }

        public static double CVStrToDouble(string? value)
        {
            if (string.IsNullOrWhiteSpace(value)) return double.NaN;
            return double.TryParse(
                    value.Replace(',', '.'),
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double result)
                ? result
                : double.NaN;
        }

        public static double CVStrToDouble_attrib(string? value) => CVStrToDouble(value);
        public static string DoubleToStrPunto(double value) => value.ToString(CultureInfo.InvariantCulture);

        public static void VerificaAttributoNumero(
            string blockName,
            string attributeName,
            Dictionary<string, object> block,
            string? value,
            double floorElevation)
        {
            if (!double.IsFinite(CVStrToDouble(value)))
                throw new InvalidDataException(
                    $"Blocco '{blockName}', attributo '{attributeName}' non numerico al piano " +
                    $"{floorElevation.ToString(CultureInfo.InvariantCulture)}.");
        }
    }

    /// <summary>
    /// Facciata headless di UtiDb. Le collection provengono dagli XML incorporati
    /// nel TERMODEL-PROJECT-TEXT-V1, ma i metodi funzionali mantengono la semantica Desktop.
    /// </summary>
    public sealed class UtiDb
    {
        public enum CategoriaZona { DaCalcolare, Balcone, PozzoLuce, Adiacente, Unclassified }

        public UtiDb(ProjectArchiveDatabase database) => Database = database;

        public ProjectArchiveDatabase Database { get; }

        public ObservableCollection<Dictionary<string, object>> GetCollection(string name) =>
            Database.GetCollection(name);

        public string GetDataDB(
            string keyField,
            object? findData,
            string returnField,
            IEnumerable<Dictionary<string, object>> rows) =>
            Database.GetDataDB(keyField, findData, returnField, rows);

        public string GetDataDBSingleRow(
            string returnField,
            IEnumerable<Dictionary<string, object>> rows) =>
            Database.GetDataDBSingleRow(returnField, rows);

        public bool ItemNessuno(object? value) => Database.ItemNessuno(value);

        public void VerificaAttributoArchivio(
            string blockName,
            string attributeName,
            Dictionary<string, object> block,
            string value,
            string archive,
            string key,
            double floorElevation) =>
            Database.RequireReferencedValue(
                $"Blocco '{blockName}', attributo '{attributeName}'",
                value,
                archive,
                key);

        public void AggiungiZoneStandard()
        {
            ObservableCollection<Dictionary<string, object>> zone = GetCollection("Zone");
            string[] tipiStandard =
            [
                "AmbienteNonClimatizzato",
                "Edificio adiacente",
                "Pozzo luce",
                "Balcone"
            ];

            foreach (string tipo in tipiStandard)
            {
                zone.Add(new Dictionary<string, object>
                {
                    ["Codice"] = tipo,
                    ["Descrizione"] = tipo,
                    ["Tipo"] = tipo,
                    ["IDXML"] = string.Empty,
                    ["TipoNonClimatizzato"] =
                        "Ambiente senza serramenti esterni e con almeno due pareti esterne"
                });
            }
        }

        public bool TipoZona(CategoriaZona categoria, string codice)
        {
            Dictionary<string, object>? zona = GetCollection("Zone").FirstOrDefault(z =>
                z.TryGetValue("Codice", out object? raw) &&
                string.Equals(raw?.ToString(), codice, StringComparison.Ordinal));

            if (zona is null)
            {
                TermodelLog.LogError(
                    $"Zona con codice \"{codice}\" non trovata. Considerata come 'DaCalcolare' per compatibilità.");
                return false;
            }

            if (!zona.TryGetValue("Tipo", out object? rawTipo))
            {
                TermodelLog.WriteLog(
                    $"Zona con codice \"{codice}\" trovata ma senza campo 'Tipo'. Considerata come 'DaCalcolare'.");
                return categoria == CategoriaZona.DaCalcolare;
            }

            string tipo = rawTipo?.ToString() ?? string.Empty;
            return categoria switch
            {
                CategoriaZona.DaCalcolare => tipo == "AmbienteClimatizzato",
                CategoriaZona.Balcone => tipo == "Balcone",
                CategoriaZona.PozzoLuce => tipo == "Pozzo luce",
                CategoriaZona.Adiacente => tipo == "Edificio adiacente",
                CategoriaZona.Unclassified =>
                    tipo != "AmbienteClimatizzato" &&
                    tipo != "Balcone" &&
                    tipo != "Pozzo luce" &&
                    tipo != "Edificio adiacente",
                _ => categoria == CategoriaZona.DaCalcolare
            };
        }
    }

    public static class TermodelLog
    {
        public enum LogCategory { generale, colmi, spezza, GeneraModello, PontiAutomatici }

        private static readonly AsyncLocal<List<string>?> CurrentMessages = new();

        public static string LogContesto { get; set; } = string.Empty;
        public static string? erroreDaMostrare { get; set; }
        public static IReadOnlyList<string> Messages => CurrentMessages.Value ?? [];
        public static void Reset()
        {
            CurrentMessages.Value = [];
            erroreDaMostrare = null;
        }
        public static bool IsEnabled(LogCategory category) => false;
        public static void WriteLog(string message, LogCategory category = LogCategory.generale) => Add("info", message);
        public static void LogOperation(string message) => Add("operation", message);
        public static void LogError(string message) => Add("error", message);

        private static void Add(string level, string message) =>
            (CurrentMessages.Value ??= []).Add($"{level}: {LogContesto}{message}");
    }
}

namespace Database
{
    using static Termodel.utilities.UtiDb;

    /// <summary>
    /// Ponte statico compatibile con il Desktop. Lo stato reale è scoped alla
    /// elaborazione tramite AsyncLocal e punta agli archivi del file unico.
    /// </summary>
    public static class DB
    {
        private static readonly AsyncLocal<Termodel.utilities.UtiDb?> Current = new();

        public static void Use(Termodel.utilities.UtiDb database) => Current.Value = database;
        public static void Clear() => Current.Value = null;

        private static Termodel.utilities.UtiDb Active => Current.Value ??
            throw new InvalidOperationException(
                "Database del progetto non inizializzato per l'elaborazione corrente.");

        public static ObservableCollection<Dictionary<string, object>> GetCollection(string name) =>
            Active.GetCollection(name);

        public static string GetDataDB(
            string keyField,
            object? findData,
            string returnField,
            IEnumerable<Dictionary<string, object>> rows) =>
            Active.GetDataDB(keyField, findData, returnField, rows);

        public static bool TipoZona(CategoriaZona category, string code) =>
            Active.TipoZona(category, code);

        public static void AggiungiZoneStandard() =>
            Active.AggiungiZoneStandard();
    }
}
