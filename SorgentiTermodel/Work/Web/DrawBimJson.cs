using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Text;
using System.Windows;
using System.Windows.Media;
using System.Windows.Media.Media3D;

namespace Termodel.utilities
{
    /// <summary>
    /// Renderer JSON parallelo alle primitive finali usate da DrawBim/Helix.
    /// Riceve geometria gia' elaborata da DrawBim e la salva in coordinate finali
    /// per Three.js. Quando Enabled=false ogni ingresso termina immediatamente.
    /// </summary>
    public static class DrawBimJson
    {
        private static readonly object SyncRoot = new object();
        private static readonly List<PrimitiveWeb3D> Primitive = new List<PrimitiveWeb3D>();
        private static bool Dirty;
        private static string PercorsoOutputPersonalizzato;

        /// <summary>
        /// Switch generale. False = nessuna costruzione JSON e nessun I/O.
        /// </summary>
        public static bool Enabled { get; set; } = false;

        /// <summary>
        /// Normalmente false: il file viene scritto una volta a fine Redraw().
        /// </summary>
        public static bool SalvataggioAutomatico { get; set; } = false;

        /// <summary>
        /// Per default il JSON appartiene al progetto Termodel corrente.
        /// Se GestProg.PathProg cambia, cambia automaticamente anche la destinazione.
        /// </summary>
        public static string PercorsoOutput
        {
            get
            {
                if (!string.IsNullOrWhiteSpace(PercorsoOutputPersonalizzato))
                    return PercorsoOutputPersonalizzato;

                string basePath = GestProg.PathProg;
                if (string.IsNullOrWhiteSpace(basePath))
                {
                    basePath = Path.Combine(
                        Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments),
                        "Termodel");
                }

                return Path.Combine(basePath, "WebBridge", "TermodelWebModel.json");
            }
        }

        public static void ImpostaPercorsoOutput(string percorso)
        {
            if (string.IsNullOrWhiteSpace(percorso))
                throw new ArgumentException("Percorso JSON non valido.", nameof(percorso));

            lock (SyncRoot)
            {
                PercorsoOutputPersonalizzato = percorso;
            }
        }

        public static void UsaPercorsoProgetto()
        {
            lock (SyncRoot)
            {
                PercorsoOutputPersonalizzato = null;
            }
        }

        public static void SetEnabled(bool enabled, bool clearOnEnable = true)
        {
            if (enabled && !Enabled && clearOnEnable)
            {
                Enabled = true;
                Clear();
                return;
            }

            Enabled = enabled;
        }

        /// <summary>
        /// Parallelo concettuale di viewport.Children.Clear().
        /// </summary>
        public static void Clear()
        {
            if (!Enabled) return;

            lock (SyncRoot)
            {
                Primitive.Clear();
                Dirty = true;
                SalvaSeRichiesto();
            }
        }

        /// <summary>
        /// Parallelo di ExtrudedVisual3D. Registra solo le superfici laterali;
        /// i tappi vengono registrati separatamente con AddMesh().
        /// </summary>
        public static void AddExtruded(
            PointCollection section,
            Point3DCollection path,
            Transform3D transform,
            Color color,
            object tipo,
            string id,
            string descrizione,
            int numeroElemento = -1,
            string parte = "lati")
        {
            if (!Enabled) return;
            if (section == null || path == null || section.Count < 2 || path.Count < 2) return;

            var primitive = CreaBase(
                "mesh", "ExtrudedVisual3D", parte, color,
                tipo, id, descrizione, numeroElemento);

            int n = section.Count;
            if (n > 1 && StessoPunto2D(section[0], section[n - 1]))
                n--;

            if (n < 2) return;

            Point3D p0 = path[0];
            Point3D p1 = path[path.Count - 1];

            for (int i = 0; i < n; i++)
            {
                int j = (i + 1) % n;

                Point3D a0 = new Point3D(section[i].X + p0.X, section[i].Y + p0.Y, p0.Z);
                Point3D b0 = new Point3D(section[j].X + p0.X, section[j].Y + p0.Y, p0.Z);
                Point3D b1 = new Point3D(section[j].X + p1.X, section[j].Y + p1.Y, p1.Z);
                Point3D a1 = new Point3D(section[i].X + p1.X, section[i].Y + p1.Y, p1.Z);

                a0 = ApplicaTrasformazione(a0, transform);
                b0 = ApplicaTrasformazione(b0, transform);
                b1 = ApplicaTrasformazione(b1, transform);
                a1 = ApplicaTrasformazione(a1, transform);

                int k = primitive.Vertices.Count;
                primitive.Vertices.Add(Punto(a0));
                primitive.Vertices.Add(Punto(b0));
                primitive.Vertices.Add(Punto(b1));
                primitive.Vertices.Add(Punto(a1));

                primitive.Indices.Add(k + 0);
                primitive.Indices.Add(k + 1);
                primitive.Indices.Add(k + 2);
                primitive.Indices.Add(k + 0);
                primitive.Indices.Add(k + 2);
                primitive.Indices.Add(k + 3);
            }

            AggiungiPrimitive(primitive);
        }

        /// <summary>
        /// Parallelo di GeometryModel3D/MeshGeometry3D.
        /// </summary>
        public static void AddMesh(
            MeshGeometry3D mesh,
            Transform3D transform,
            Color color,
            object tipo,
            string id,
            string descrizione,
            int numeroElemento = -1,
            string parte = "mesh")
        {
            if (!Enabled) return;
            if (mesh == null || mesh.Positions == null || mesh.Positions.Count == 0) return;

            var primitive = CreaBase(
                "mesh", "MeshGeometry3D", parte, color,
                tipo, id, descrizione, numeroElemento);

            foreach (Point3D p in mesh.Positions)
                primitive.Vertices.Add(Punto(ApplicaTrasformazione(p, transform)));

            if (mesh.TriangleIndices != null && mesh.TriangleIndices.Count > 0)
            {
                foreach (int index in mesh.TriangleIndices)
                    primitive.Indices.Add(index);
            }
            else
            {
                for (int i = 0; i + 2 < mesh.Positions.Count; i += 3)
                {
                    primitive.Indices.Add(i);
                    primitive.Indices.Add(i + 1);
                    primitive.Indices.Add(i + 2);
                }
            }

            AggiungiPrimitive(primitive);
        }

        public static void AddLine(
            Point3DCollection points,
            Transform3D transform,
            Color color,
            double spessore,
            object tipo = null,
            string id = null,
            string descrizione = null,
            int numeroElemento = -1,
            string parte = "linea")
        {
            if (!Enabled) return;
            if (points == null || points.Count < 2) return;

            var primitive = CreaBase(
                "lineSegments", "LinesVisual3D", parte, color,
                tipo, id, descrizione, numeroElemento);

            primitive.LineWidth = SafeNumber(spessore);

            foreach (Point3D p in points)
                primitive.Vertices.Add(Punto(ApplicaTrasformazione(p, transform)));

            for (int i = 0; i + 1 < points.Count; i += 2)
            {
                primitive.Indices.Add(i);
                primitive.Indices.Add(i + 1);
            }

            AggiungiPrimitive(primitive);
        }

        public static void AddLabel(
            string testo,
            Point3D posizione,
            Transform3D transform,
            Color color,
            object tipo = null,
            string id = null,
            string descrizione = null,
            int numeroElemento = -1)
        {
            if (!Enabled) return;

            var primitive = CreaBase(
                "label", "BillboardTextVisual3D", "etichetta", color,
                tipo, id, descrizione, numeroElemento);

            primitive.Text = testo ?? string.Empty;
            primitive.Vertices.Add(Punto(ApplicaTrasformazione(posizione, transform)));
            AggiungiPrimitive(primitive);
        }

        public static void SalvaJson()
        {
            if (!Enabled) return;

            lock (SyncRoot)
            {
                if (!Dirty && File.Exists(PercorsoOutput))
                    return;

                SalvaJsonInternal();
            }
        }

        public static int NumeroPrimitive
        {
            get
            {
                if (!Enabled) return 0;
                lock (SyncRoot) return Primitive.Count;
            }
        }

        private static void AggiungiPrimitive(PrimitiveWeb3D primitive)
        {
            if (!Enabled || primitive == null) return;

            lock (SyncRoot)
            {
                Primitive.Add(primitive);
                Dirty = true;
                SalvaSeRichiesto();
            }
        }

        private static void SalvaSeRichiesto()
        {
            if (Enabled && SalvataggioAutomatico)
                SalvaJsonInternal();
        }

        private static PrimitiveWeb3D CreaBase(
            string kind,
            string source,
            string parte,
            Color color,
            object tipo,
            string id,
            string descrizione,
            int numeroElemento)
        {
            var primitive = new PrimitiveWeb3D
            {
                Kind = kind ?? string.Empty,
                Source = source ?? string.Empty,
                Parte = parte ?? string.Empty,
                NumeroElemento = numeroElemento,
                Id = id ?? string.Empty,
                Tipo = tipo != null ? tipo.ToString() : string.Empty,
                Descrizione = descrizione ?? string.Empty,
                Color = ColorHex(color),
                Opacity = SafeNumber(color.A / 255.0)
            };

            ArricchisciFiltriDaElemento(primitive, numeroElemento);
            return primitive;
        }

        /// <summary>
        /// NumeroElemento e' l'indice 1-based usato da Polig3D nel foreach di
        /// ElementiAssociati. In questo modo non dobbiamo cambiare la firma di
        /// DrawBim.DrawPolyEstruso e non duplichiamo logica geometrica.
        /// </summary>
        private static void ArricchisciFiltriDaElemento(PrimitiveWeb3D primitive, int numeroElemento)
        {
            if (!Enabled || primitive == null || numeroElemento <= 0)
                return;

            try
            {
                var elementi = global::Polig3D.ElementiAssociati;
                int indice = numeroElemento - 1;

                if (elementi == null || indice < 0 || indice >= elementi.Count)
                    return;

                var elemento = elementi[indice];
                if (elemento == null)
                    return;

                primitive.Piano = elemento.NomePiano ?? string.Empty;
                primitive.Separatore = elemento.Separatore;
                primitive.StessaZona = elemento.StessaZona;
                primitive.Falda = elemento.Poligono != null && elemento.Poligono.Falda;

                // Il desktop tratta il Mansardato come Esterno indipendentemente
                // dalla determinazione generica del confine.
                if (elemento.Tipo == global::Polig3D.TipoElemento.Mansardato)
                {
                    primitive.Confine = "Esterno";
                }
                else if (!primitive.Falda)
                {
                    try
                    {
                        primitive.Confine = global::GestXml.DeterminaTipoConfine(elemento).ToString();
                    }
                    catch
                    {
                        primitive.Confine = string.Empty;
                    }
                }

                if (elemento.Separatore)
                {
                    try
                    {
                        primitive.Fittizia = global::Polig3D.IsFittizia(elemento);
                    }
                    catch
                    {
                        primitive.Fittizia = false;
                    }
                }

                primitive.FilterMetadata = true;
            }
            catch
            {
                // Il bridge Web non deve mai interrompere il rendering desktop.
                primitive.FilterMetadata = false;
            }
        }

        private static Point3D ApplicaTrasformazione(Point3D p, Transform3D transform)
        {
            if (transform == null)
                return p;

            try
            {
                return transform.Transform(p);
            }
            catch
            {
                return p;
            }
        }

        private static bool StessoPunto2D(Point a, Point b)
        {
            return Math.Abs(a.X - b.X) < 1e-9 && Math.Abs(a.Y - b.Y) < 1e-9;
        }

        private static PuntoWeb Punto(Point3D p)
        {
            return new PuntoWeb
            {
                X = SafeNumber(p.X),
                Y = SafeNumber(p.Y),
                Z = SafeNumber(p.Z)
            };
        }

        private static string ColorHex(Color color)
        {
            return string.Format(
                CultureInfo.InvariantCulture,
                "#{0:X2}{1:X2}{2:X2}",
                color.R, color.G, color.B);
        }

        private static void SalvaJsonInternal()
        {
            string percorso = PercorsoOutput;
            string directory = Path.GetDirectoryName(percorso);
            if (!string.IsNullOrEmpty(directory))
                Directory.CreateDirectory(directory);

            string temp = percorso + ".tmp";
            File.WriteAllText(temp, CreaJson(), new UTF8Encoding(false));

            if (File.Exists(percorso))
                File.Delete(percorso);

            File.Move(temp, percorso);
            Dirty = false;
        }

        private static string CreaJson()
        {
            var sb = new StringBuilder(Math.Max(32 * 1024, Primitive.Count * 640));

            sb.Append("{\n");
            Riga(sb, 1, "format", JsonString("TermodelWebModel"), true);
            Riga(sb, 1, "version", "3", true);
            Riga(sb, 1, "coordinateSystem", JsonString("Z-up"), true);
            Riga(sb, 1, "generatedAtUtc", JsonString(DateTime.UtcNow.ToString("o", CultureInfo.InvariantCulture)), true);
            Riga(sb, 1, "primitiveCount", Primitive.Count.ToString(CultureInfo.InvariantCulture), true);
            sb.Append("  \"primitives\": [\n");

            for (int i = 0; i < Primitive.Count; i++)
            {
                ScriviPrimitive(sb, Primitive[i], "    ");
                if (i < Primitive.Count - 1)
                    sb.Append(',');
                sb.Append('\n');
            }

            sb.Append("  ]\n");
            sb.Append("}\n");
            return sb.ToString();
        }

        private static void ScriviPrimitive(StringBuilder sb, PrimitiveWeb3D p, string ind)
        {
            int livello = ind.Length / 2 + 1;

            sb.Append(ind).Append("{\n");
            Riga(sb, livello, "kind", JsonString(p.Kind), true);
            Riga(sb, livello, "source", JsonString(p.Source), true);
            Riga(sb, livello, "parte", JsonString(p.Parte), true);
            Riga(sb, livello, "numero", p.NumeroElemento.ToString(CultureInfo.InvariantCulture), true);
            Riga(sb, livello, "id", JsonString(p.Id), true);
            Riga(sb, livello, "tipo", JsonString(p.Tipo), true);
            Riga(sb, livello, "descrizione", JsonString(p.Descrizione), true);

            // Metadati usati dal pannello Filtri Grafici Web.
            Riga(sb, livello, "filterMetadata", Bool(p.FilterMetadata), true);
            Riga(sb, livello, "piano", JsonString(p.Piano), true);
            Riga(sb, livello, "confine", JsonString(p.Confine), true);
            Riga(sb, livello, "separatore", Bool(p.Separatore), true);
            Riga(sb, livello, "stessaZona", Bool(p.StessaZona), true);
            Riga(sb, livello, "fittizia", Bool(p.Fittizia), true);
            Riga(sb, livello, "falda", Bool(p.Falda), true);

            Riga(sb, livello, "color", JsonString(p.Color), true);
            Riga(sb, livello, "opacity", Num(p.Opacity), true);
            Riga(sb, livello, "lineWidth", Num(p.LineWidth), true);
            Riga(sb, livello, "text", JsonString(p.Text), true);

            sb.Append(ind).Append("  \"vertices\": [");
            for (int i = 0; i < p.Vertices.Count; i++)
            {
                if (i > 0) sb.Append(',');
                PuntoJson(sb, p.Vertices[i]);
            }
            sb.Append("],\n");

            sb.Append(ind).Append("  \"indices\": [");
            for (int i = 0; i < p.Indices.Count; i++)
            {
                if (i > 0) sb.Append(',');
                sb.Append(p.Indices[i].ToString(CultureInfo.InvariantCulture));
            }
            sb.Append("]\n");
            sb.Append(ind).Append('}');
        }

        private static void Riga(StringBuilder sb, int livello, string nome, string valore, bool virgola)
        {
            sb.Append(new string(' ', livello * 2));
            sb.Append(JsonString(nome)).Append(": ").Append(valore);
            if (virgola) sb.Append(',');
            sb.Append('\n');
        }

        private static void PuntoJson(StringBuilder sb, PuntoWeb p)
        {
            sb.Append('[')
              .Append(Num(p.X)).Append(',')
              .Append(Num(p.Y)).Append(',')
              .Append(Num(p.Z)).Append(']');
        }

        private static string Num(double value)
        {
            return SafeNumber(value).ToString("0.##########", CultureInfo.InvariantCulture);
        }

        private static string Bool(bool value)
        {
            return value ? "true" : "false";
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

        private sealed class PrimitiveWeb3D
        {
            public string Kind = string.Empty;
            public string Source = string.Empty;
            public string Parte = string.Empty;
            public int NumeroElemento = -1;
            public string Id = string.Empty;
            public string Tipo = string.Empty;
            public string Descrizione = string.Empty;

            public bool FilterMetadata;
            public string Piano = string.Empty;
            public string Confine = string.Empty;
            public bool Separatore;
            public bool StessaZona;
            public bool Fittizia;
            public bool Falda;

            public string Color = "#FFFFFF";
            public double Opacity = 1.0;
            public double LineWidth = 1.0;
            public string Text = string.Empty;
            public readonly List<PuntoWeb> Vertices = new List<PuntoWeb>();
            public readonly List<int> Indices = new List<int>();
        }

        private sealed class PuntoWeb
        {
            public double X;
            public double Y;
            public double Z;
        }
    }
}
