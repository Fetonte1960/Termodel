using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Reflection;
using System.Text;

namespace Termodel.utilities
{
    /// <summary>
    /// Renderer parallelo a DrawBim: non disegna nulla.
    /// Registra gli stessi elementi 3D passati al renderer desktop e genera
    /// un file JSON consumabile da Termodel Web / Three.js.
    ///
    /// Obiettivo: modificare il meno possibile Termodel.
    /// Il punto di aggancio consigliato e' UNA SOLA chiamata dentro
    /// DrawBim.DrawPolyEstruso(...), dopo il rendering desktop:
    ///
    /// DrawBimJson.RegistraPolyEstruso(
    ///     NumeroElemento, polyifc, baseHeight, spessore, verticale,
    ///     puntoInserimento, origine, Tipo, elementIdentifier,
    ///     descrizione, Start, End, rotationAngle);
    ///
    /// Tutta la logica JSON rimane qui.
    /// </summary>
    public static class DrawBimJson
    {
        private static readonly object SyncRoot = new object();
        private static readonly List<ElementoWeb3D> Elementi = new List<ElementoWeb3D>();
        private static int UltimoNumeroElemento = -1;

        /// <summary>
        /// Se true, il JSON viene riscritto ad ogni elemento registrato.
        /// Per la prima demo e' comodo: il file e' sempre aggiornato.
        /// In seguito potremo salvare una sola volta a fine generazione.
        /// </summary>
        public static bool SalvataggioAutomatico { get; set; } = true;

        /// <summary>
        /// Percorso di default del file di comunicazione.
        /// Non dipende dalla cartella GitHub e non tocca gli archivi nativi.
        /// </summary>
        public static string PercorsoOutput { get; set; } = Path.Combine(
            Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
            "Termodel",
            "WebBridge",
            "TermodelWebModel.json");

        public static void ImpostaPercorsoOutput(string percorso)
        {
            if (string.IsNullOrWhiteSpace(percorso))
                throw new ArgumentException("Percorso JSON non valido.", nameof(percorso));

            lock (SyncRoot)
            {
                PercorsoOutput = percorso;
            }
        }

        /// <summary>
        /// Svuota il modello Web corrente.
        /// Puo' essere chiamato esplicitamente all'inizio della generazione.
        /// Non e' obbligatorio per la demo: la classe prova anche a riconoscere
        /// automaticamente la ripartenza della numerazione elementi.
        /// </summary>
        public static void Reset()
        {
            lock (SyncRoot)
            {
                Elementi.Clear();
                UltimoNumeroElemento = -1;

                if (SalvataggioAutomatico)
                    SalvaJsonInternal();
            }
        }

        /// <summary>
        /// Firma volutamente molto permissiva per non introdurre dipendenze
        /// aggiuntive da Helix/Xbim nella classe di comunicazione.
        /// Gli oggetti complessi vengono letti per riflessione.
        /// </summary>
        public static void RegistraPolyEstruso(
            int numeroElemento,
            object polyifc,
            double baseHeight,
            double spessore,
            bool verticale,
            object puntoInserimento,
            object origine,
            object tipo,
            string elementIdentifier,
            string descrizione,
            object start,
            object end,
            double rotationAngle)
        {
            lock (SyncRoot)
            {
                // Se la numerazione riparte, consideriamo iniziato un nuovo modello.
                if (Elementi.Count > 0 && numeroElemento < UltimoNumeroElemento)
                    Elementi.Clear();

                UltimoNumeroElemento = numeroElemento;

                var elemento = new ElementoWeb3D
                {
                    NumeroElemento = numeroElemento,
                    Id = elementIdentifier ?? string.Empty,
                    Tipo = tipo != null ? tipo.ToString() : string.Empty,
                    Descrizione = descrizione ?? string.Empty,
                    BaseHeight = SafeNumber(baseHeight),
                    Spessore = SafeNumber(spessore),
                    Verticale = verticale,
                    RotazioneGradi = SafeNumber(rotationAngle),
                    PuntoInserimento = LeggiPunto(puntoInserimento),
                    Origine = LeggiPunto(origine),
                    Start = LeggiPunto(start),
                    End = LeggiPunto(end),
                    Profilo = LeggiPolyline(polyifc)
                };

                // Evita doppioni se lo stesso oggetto viene rigenerato.
                int indice = Elementi.FindIndex(e =>
                    e.NumeroElemento == numeroElemento &&
                    string.Equals(e.Id, elemento.Id, StringComparison.Ordinal));

                if (indice >= 0)
                    Elementi[indice] = elemento;
                else
                    Elementi.Add(elemento);

                if (SalvataggioAutomatico)
                    SalvaJsonInternal();
            }
        }

        public static void SalvaJson()
        {
            lock (SyncRoot)
            {
                SalvaJsonInternal();
            }
        }

        private static void SalvaJsonInternal()
        {
            string directory = Path.GetDirectoryName(PercorsoOutput);
            if (!string.IsNullOrEmpty(directory))
                Directory.CreateDirectory(directory);

            string temp = PercorsoOutput + ".tmp";
            File.WriteAllText(temp, CreaJson(), new UTF8Encoding(false));

            if (File.Exists(PercorsoOutput))
                File.Delete(PercorsoOutput);

            File.Move(temp, PercorsoOutput);
        }

        private static string CreaJson()
        {
            var sb = new StringBuilder(32 * 1024);
            sb.Append("{\n");
            sb.Append("  \"format\": \"TermodelWebModel\",\n");
            sb.Append("  \"version\": 1,\n");
            sb.Append("  \"generatedAtUtc\": ").Append(JsonString(DateTime.UtcNow.ToString("o", CultureInfo.InvariantCulture))).Append(",\n");
            sb.Append("  \"elements\": [\n");

            for (int i = 0; i < Elementi.Count; i++)
            {
                ScriviElemento(sb, Elementi[i], "    ");
                if (i < Elementi.Count - 1)
                    sb.Append(',');
                sb.Append('\n');
            }

            sb.Append("  ]\n");
            sb.Append("}\n");
            return sb.ToString();
        }

        private static void ScriviElemento(StringBuilder sb, ElementoWeb3D e, string ind)
        {
            sb.Append(ind).Append("{\n");
            Riga(sb, ind, "numero", e.NumeroElemento.ToString(CultureInfo.InvariantCulture), false, true);
            Riga(sb, ind, "id", JsonString(e.Id), false, true);
            Riga(sb, ind, "tipo", JsonString(e.Tipo), false, true);
            Riga(sb, ind, "descrizione", JsonString(e.Descrizione), false, true);
            Riga(sb, ind, "baseHeight", Num(e.BaseHeight), false, true);
            Riga(sb, ind, "spessore", Num(e.Spessore), false, true);
            Riga(sb, ind, "verticale", e.Verticale ? "true" : "false", false, true);
            Riga(sb, ind, "rotazioneGradi", Num(e.RotazioneGradi), false, true);
            Riga(sb, ind, "puntoInserimento", PuntoJson(e.PuntoInserimento), false, true);
            Riga(sb, ind, "origine", PuntoJson(e.Origine), false, true);
            Riga(sb, ind, "start", PuntoJson(e.Start), false, true);
            Riga(sb, ind, "end", PuntoJson(e.End), false, true);

            sb.Append(ind).Append("  \"profilo\": [");
            for (int i = 0; i < e.Profilo.Count; i++)
            {
                if (i > 0) sb.Append(',');
                sb.Append(PuntoJson(e.Profilo[i]));
            }
            sb.Append("]\n");
            sb.Append(ind).Append('}');
        }

        private static void Riga(StringBuilder sb, string ind, string nome, string valore, bool quoted, bool virgola)
        {
            sb.Append(ind).Append("  ").Append(JsonString(nome)).Append(": ");
            sb.Append(quoted ? JsonString(valore) : valore);
            if (virgola) sb.Append(',');
            sb.Append('\n');
        }

        private static string PuntoJson(PuntoWeb p)
        {
            if (p == null) return "null";
            return "{\"x\":" + Num(p.X) + ",\"y\":" + Num(p.Y) + ",\"z\":" + Num(p.Z) + "}";
        }

        private static string Num(double value)
        {
            return SafeNumber(value).ToString("0.##########", CultureInfo.InvariantCulture);
        }

        private static double SafeNumber(double value)
        {
            return double.IsNaN(value) || double.IsInfinity(value) ? 0.0 : value;
        }

        private static string JsonString(string text)
        {
            if (text == null) return "null";
            return "\"" + text
                .Replace("\\", "\\\\")
                .Replace("\"", "\\\"")
                .Replace("\r", "\\r")
                .Replace("\n", "\\n")
                .Replace("\t", "\\t") + "\"";
        }

        private static List<PuntoWeb> LeggiPolyline(object polyline)
        {
            var result = new List<PuntoWeb>();
            if (polyline == null) return result;

            try
            {
                PropertyInfo prop = polyline.GetType().GetProperty("Points");
                object points = prop != null ? prop.GetValue(polyline, null) : null;
                var enumerable = points as IEnumerable;
                if (enumerable == null) return result;

                foreach (object p in enumerable)
                {
                    PuntoWeb punto = LeggiPunto(p);
                    if (punto != null)
                        result.Add(punto);
                }
            }
            catch
            {
                // Il renderer Web non deve mai interrompere il rendering desktop.
            }

            return result;
        }

        private static PuntoWeb LeggiPunto(object source)
        {
            if (source == null) return null;

            try
            {
                Type t = source.GetType();

                double? x = LeggiNumero(t, source, "X");
                double? y = LeggiNumero(t, source, "Y");
                double? z = LeggiNumero(t, source, "Z");

                if (x.HasValue || y.HasValue || z.HasValue)
                {
                    return new PuntoWeb
                    {
                        X = SafeNumber(x ?? 0),
                        Y = SafeNumber(y ?? 0),
                        Z = SafeNumber(z ?? 0)
                    };
                }

                // Fallback per tipi IFC che espongono Coordinates.
                PropertyInfo coordsProp = t.GetProperty("Coordinates");
                object coordsObj = coordsProp != null ? coordsProp.GetValue(source, null) : null;
                var coords = coordsObj as IEnumerable;
                if (coords != null)
                {
                    var valori = new List<double>();
                    foreach (object c in coords)
                    {
                        double valore;
                        if (TryConvertDouble(c, out valore))
                            valori.Add(valore);
                    }

                    return new PuntoWeb
                    {
                        X = valori.Count > 0 ? SafeNumber(valori[0]) : 0,
                        Y = valori.Count > 1 ? SafeNumber(valori[1]) : 0,
                        Z = valori.Count > 2 ? SafeNumber(valori[2]) : 0
                    };
                }
            }
            catch
            {
                // Mai bloccare Termodel per un problema del bridge Web.
            }

            return null;
        }

        private static double? LeggiNumero(Type tipo, object source, string propertyName)
        {
            PropertyInfo p = tipo.GetProperty(propertyName);
            if (p == null) return null;

            object value = p.GetValue(source, null);
            double result;
            return TryConvertDouble(value, out result) ? (double?)result : null;
        }

        private static bool TryConvertDouble(object value, out double result)
        {
            result = 0;
            if (value == null) return false;

            try
            {
                if (value is IConvertible)
                {
                    result = Convert.ToDouble(value, CultureInfo.InvariantCulture);
                    return true;
                }

                PropertyInfo valueProp = value.GetType().GetProperty("Value");
                if (valueProp != null)
                {
                    object inner = valueProp.GetValue(value, null);
                    if (inner is IConvertible)
                    {
                        result = Convert.ToDouble(inner, CultureInfo.InvariantCulture);
                        return true;
                    }
                }
            }
            catch
            {
                return false;
            }

            return false;
        }

        private sealed class ElementoWeb3D
        {
            public int NumeroElemento;
            public string Id;
            public string Tipo;
            public string Descrizione;
            public double BaseHeight;
            public double Spessore;
            public bool Verticale;
            public double RotazioneGradi;
            public PuntoWeb PuntoInserimento;
            public PuntoWeb Origine;
            public PuntoWeb Start;
            public PuntoWeb End;
            public List<PuntoWeb> Profilo = new List<PuntoWeb>();
        }

        private sealed class PuntoWeb
        {
            public double X;
            public double Y;
            public double Z;
        }
    }
}
