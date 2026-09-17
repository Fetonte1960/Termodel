using HelixToolkit.Wpf;
using netDxf;
using System;
using System.Collections.Generic;
using System.Windows.Media;
using System.Windows.Media.Media3D;
using netDxf.Entities;
using netDxf.Tables;
using System.Windows.Forms;
using NetTopologySuite.Geometries;

namespace Termodel.utilities
{
    // da usare quando c'è una sola istanza
    // Singleton access point
    public static class HelixDXF
    {
        public static HelixDXF_class I { get; private set; }

        public static void InitClass()
        {
            I = new HelixDXF_class();
        }
    }

    public class HelixDXF_class
    {
        // === ENTITÀ LINEA ===
        public class LineaDXF
        {
            public string Layer { get; set; }
            public Color Colore { get; set; }
            public string TipoLinea { get; set; }
            public Point3D Inizio { get; set; }
            public Point3D Fine { get; set; }
            public double Spessore { get; set; } = 1.0; // valore predefinito
        }


        // === ENTITÀ BLOCCO ===
        public class BloccoDXF
        {
            public string Nome { get; set; }
            public int DimSfera { get; set; }
            public Brush ColoreSfera { get; set; }

            public Point3D PuntoInserimento { get; set; }
            public Dictionary<string, string> Attributi { get; set; } = new();
        }

        // === BUFFER ENTITÀ ===
        private readonly List<LineaDXF> _linee = new();
        private readonly List<BloccoDXF> _blocchi = new();

        // === METODO: SVUOTA ===
        public void Svuota()
        {
            _linee.Clear();
            _blocchi.Clear();
        }

        // === METODO: AGGIUNGI LINEA ===
        public void AggiungiLinea(string layer, Color colore, string tipoLinea, Point3D inizio, Point3D fine, double spessore = 1.0)
        {
            _linee.Add(new LineaDXF
            {
                Layer = layer,
                Colore = colore,
                TipoLinea = tipoLinea,
                Inizio = inizio,
                Fine = fine,
                Spessore = spessore
            });
        }


        // === METODO: AGGIUNGI BLOCCO ===
        public void AggiungiBlocco(string nome, Point3D inserimento, Dictionary<string, string> attributi, int dimSfera, Brush coloreSfera)
        {
            _blocchi.Add(new BloccoDXF
            {
                Nome = nome,
                PuntoInserimento = inserimento,
                Attributi = attributi ?? new(),
                DimSfera = dimSfera,
                ColoreSfera = coloreSfera
            });
        }



        // === GETTERS PER IL RENDERING ===
        public IEnumerable<LineaDXF> GetLinee() => _linee;
        public IEnumerable<BloccoDXF> GetBlocchi() => _blocchi;


public void RenderFiltrato(HelixViewport3D viewport, FiltriGrafici filtri, bool visualizzaTutto = false)
    {
        if (viewport == null || filtri == null) return;

 
            // 3. Disegna tutte le linee che passano i filtri
            foreach (var linea in _linee)
        {
            // Se visualizzaTutto è true, mostra tutto indipendentemente dai filtri
            if (visualizzaTutto || filtri.ComponenteFiltrato(linea.Layer))
            {
                    var linea3D = new LinesVisual3D
                    {
                        Color = linea.Colore,
                        Thickness = 1.0
                    };


                    linea3D.Points.Add(linea.Inizio);
                linea3D.Points.Add(linea.Fine);

                viewport.Children.Add(linea3D);
            }
        }

        // 4. Disegna i blocchi, se filtrati (usa Layer anche qui per semplicità)
        foreach (var blocco in _blocchi)
        {
            if (visualizzaTutto || filtri.ComponenteFiltrato(blocco.Nome))
            {
                    // Rappresentazione semplificata: una sfera nel punto di inserimento
                    var sphere = new SphereVisual3D
                    {
                        Center = blocco.PuntoInserimento,
                        Radius = blocco.DimSfera * 0.01, // Ad esempio: DimSfera = 7 → Radius = 0.07
                        Fill = blocco.ColoreSfera
                    };

                    viewport.Children.Add(sphere);
                    /*
                    double offsetY = 0.2;
                    double altezzaTesto = 0.2; // Altezza del testo in unità modello (es. metri)
                    int index = 0;

                    foreach (var attr in blocco.Attributi)
                    {
                        var posizione = blocco.PuntoInserimento + new Vector3D(0, offsetY * (++index), 0);

                        var testo3D = new TextVisual3D
                        {
                            Text = $"{attr.Key}: {attr.Value}",
                            Position = posizione,
                            Height = altezzaTesto,
                            Foreground = Brushes.Black
                        };

                        // Ruota il testo affinché sia "sdraiato" sull'XY (asse Z verticale)
                        testo3D.Transform = new RotateTransform3D(
                            new AxisAngleRotation3D(new Vector3D(1, 0, 0), -90)
                        );

                        viewport.Children.Add(testo3D);
                    
                    }
                    */


                }
            }
    }
        private Color ConvertiColore(AciColor dxfColor)
        {
            // Se colore non specificato, usa nero
            if (dxfColor == null || dxfColor.IsByLayer)
                return Colors.Black;

            return Color.FromRgb(dxfColor.R, dxfColor.G, dxfColor.B);
        }

        public static int spessoreErrate = 7;
        public static int spessoreCorrette = 3;
        public static int DimsferaErrate = 16;
        public static int DimsferaCorrette = 8;
        public static Brush ColoresferaErrate = Brushes.Red;
        public static Brush ColoresferaCorrette = Brushes.Orange;

        public static List<LineString> EstraiLinee2DdaPoligono(NetTopologySuite.Geometries.Polygon poligono)
        {
            var risultato = new List<LineString>();

            if (poligono == null)
                return risultato;

            // Funzione locale per spezzare LineString in segmenti
            static void SpezzaInLinee(LineString linea, List<LineString> output)
            {
                for (int i = 1; i < linea.NumPoints; i++)
                {
                    var p1 = linea.GetCoordinateN(i - 1);
                    var p2 = linea.GetCoordinateN(i);

                    output.Add(new LineString(new[]
                    {
                new CoordinateZ(p1.X, p1.Y, 0),
                new CoordinateZ(p2.X, p2.Y, 0)
            }));
                }
            }

            // 1. Shell esterno
            SpezzaInLinee(poligono.Shell, risultato);
            //
            // 2. Eventuali buchi (interior rings)
            for (int i = 0; i < poligono.NumInteriorRings; i++)
            {
                SpezzaInLinee(poligono.GetInteriorRingN(i), risultato);
            }
            //
            return risultato;
        }

        public void ErroreConGrafica(
           string messaggio,
           List<NetTopologySuite.Geometries.LineString> lineeErrore,
           double quota,
           Dictionary<string, object>? bloccoErrato = null)
        {
            Vector3D traslazione = new Vector3D(0, 0, quota);

            if (lineeErrore != null || bloccoErrato != null)
                ErroriNelDxf(lineeErrore ?? new List<NetTopologySuite.Geometries.LineString>(), traslazione, bloccoErrato);

            TermodelLog.LogError(messaggio);
        }


        public void ImportaDaDxf(DxfDocument dxf, string layerName, Vector3D traslazione)
        {
            if (dxf == null || string.IsNullOrWhiteSpace(layerName))
                return;

            // === GESTIONE LINEE ===
            foreach (var linea in dxf.Lines)
            {
                if (linea.Layer?.Name == layerName)
                {
                    var colore = ConvertiColore(linea.Color);

                    AggiungiLinea(
               layer: linea.Layer.Name,
               colore: Colors.Green,  // ✅ Colore fisso verde per linee corrette
               tipoLinea: linea.Linetype?.Name ?? "Continuous",
               inizio: new Point3D(
                   linea.StartPoint.X + traslazione.X,
                   linea.StartPoint.Y + traslazione.Y,
                   linea.StartPoint.Z + traslazione.Z),
               fine: new Point3D(
                   linea.EndPoint.X + traslazione.X,
                   linea.EndPoint.Y + traslazione.Y,
                   linea.EndPoint.Z + traslazione.Z),
               spessore: spessoreCorrette  // ✅ Spessore impostato
                );
                }
            }

            // === GESTIONE INSERT (BLOCCHI) ===
            foreach (var insert in dxf.Inserts)
            {
                if (insert.Layer?.Name == layerName)
                {
                    var attributi = new Dictionary<string, string>();
                    foreach (var att in insert.Attributes)
                    {
                        attributi[att.Tag] = att.Value?.ToString() ?? "";
                    }
                    if (insert.Block.Name.ToString().ToLower() != "nord"&& insert.Block.Name.ToString().ToLower() != "allinea")
                        AggiungiBlocco(
                        nome: insert.Block.Name,
                        inserimento: new Point3D(
                        insert.Position.X + traslazione.X,
                        insert.Position.Y + traslazione.Y,
                        insert.Position.Z + traslazione.Z),
                        attributi: attributi,
                        dimSfera:DimsferaCorrette,
                        coloreSfera:ColoresferaCorrette
);

                }
            }

            // === Altre entità in futuro ===
        }

        public record Limiti3D(double MinX, double MaxX, double MinY, double MaxY, double MinZ, double MaxZ);

        public Limiti3D CalcolaLimitiDxf()
        {
            double minX = double.MaxValue;
            double minY = double.MaxValue;
            double minZ = double.MaxValue;
            double maxX = double.MinValue;
            double maxY = double.MinValue;
            double maxZ = double.MinValue;

            void Aggiorna(Point3D p)
            {
                if (p.X < minX) minX = p.X;
                if (p.Y < minY) minY = p.Y;
                if (p.Z < minZ) minZ = p.Z;
                if (p.X > maxX) maxX = p.X;
                if (p.Y > maxY) maxY = p.Y;
                if (p.Z > maxZ) maxZ = p.Z;
            }

            foreach (var linea in _linee)
            {
                Aggiorna(linea.Inizio);
                Aggiorna(linea.Fine);
            }

            foreach (var blocco in _blocchi)
            {
                Aggiorna(blocco.PuntoInserimento);
            }

            return new Limiti3D(minX, maxX, minY, maxY, minZ, maxZ);
        }
        public void ErroriNelDxf(
           List<LineString> lineeErrore,
           Vector3D traslazione,
           Dictionary<string, object>? bloccoErrato = null)
        {
            const double zOffset = 0;

            // Linee rosse
            foreach (var lineaErrore in lineeErrore)
            {
                if (lineaErrore.NumPoints != 2)
                    continue;

                var p1 = lineaErrore.GetCoordinateN(0);
                var p2 = lineaErrore.GetCoordinateN(1);

                var inizio = new Point3D(p1.X, p1.Y, traslazione.Z + zOffset);
                var fine = new Point3D(p2.X, p2.Y, traslazione.Z + zOffset);

                AggiungiLinea(
                    layer: "DEBUG",
                    colore: Colors.Red,
                    tipoLinea: "Continuous",
                    inizio: inizio,
                    fine: fine,
                    spessore: spessoreErrate
                );
            }

            // Sfera rossa per il blocco errato (se presente)
            if (bloccoErrato != null &&
                bloccoErrato.ContainsKey("xins") &&
                bloccoErrato.ContainsKey("yins") )
            {
                double x = Convert.ToDouble(bloccoErrato["xins"]);
                double y = Convert.ToDouble(bloccoErrato["yins"]);
                double z = 0;

                AggiungiBlocco(
                    nome: "Errore",
                    inserimento: new Point3D(x + traslazione.X, y + traslazione.Y, z + traslazione.Z),
                    attributi: null,
                    dimSfera:DimsferaErrate,
                    coloreSfera: ColoresferaErrate
                );
            }
        }


        public void ErroriNelDxfold(List<NetTopologySuite.Geometries.LineString> lineeErrore, Vector3D traslazione)
        {
            const double zOffset = 0;

            foreach (var lineaErrore in lineeErrore)
            {
                if (lineaErrore.NumPoints != 2)
                    continue; // ignora se non è una linea semplice

                var p1 = lineaErrore.GetCoordinateN(0);
                var p2 = lineaErrore.GetCoordinateN(1);

                var inizio = new Point3D(
                    p1.X, //+ traslazione.X,
                    p1.Y, //+ traslazione.Y,
                    traslazione.Z + zOffset);

                var fine = new Point3D(
                    p2.X, //+ traslazione.X,
                    p2.Y, //+ traslazione.Y,
                    traslazione.Z + zOffset);

                // Linea rossa di debug visivo
                AggiungiLinea(
                    layer: "DEBUG",
                    colore: Colors.Red,
                    tipoLinea: "Continuous",
                    inizio: inizio,
                    fine: fine,
                    spessore: spessoreErrate  // ✅ spessore più visibile
                );
            }
        }

        public void ErroriNelDxf_colora(List<NetTopologySuite.Geometries.LineString> lineeErrore, Vector3D traslazione)
        {
            foreach (var lineaErrore in lineeErrore)
            {
                // Coordinate originali (non traslate)
                var p1 = lineaErrore.GetCoordinateN(0);
                var p2 = lineaErrore.GetCoordinateN(1);

                // Applichiamo la traslazione
                var x1 = p1.X + traslazione.X;
                var y1 = p1.Y + traslazione.Y;
                var z1 = p1.Z + traslazione.Z;

                var x2 = p2.X + traslazione.X;
                var y2 = p2.Y + traslazione.Y;
                var z2 = p2.Z + traslazione.Z;

                // Cerchiamo nel database
                foreach (var lineaDxf in _linee)
                {
                    bool match1 = CoordinateUguali(lineaDxf.Inizio, x1, y1, z1) && CoordinateUguali(lineaDxf.Fine, x2, y2, z2);
                    bool match2 = CoordinateUguali(lineaDxf.Inizio, x2, y2, z2) && CoordinateUguali(lineaDxf.Fine, x1, y1, z1);

                    if (match1 || match2)
                    {
                        lineaDxf.Colore = Colors.Red;
                        break; // passa alla prossima lineaErrore
                    }
                }
            }
        }

        // Funzione di confronto con tolleranza
        private bool CoordinateUguali(Point3D p, double x, double y, double z, double toll = 0.1)
        {
            return Math.Abs(p.X - x) < toll &&
                   Math.Abs(p.Y - y) < toll &&
                   Math.Abs(p.Z - z) < toll;
        }

        public string GeneraSVGLST()
        {
            var sb = new System.Text.StringBuilder();

            // === INTESTAZIONE SVG ===
            sb.AppendLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
            sb.AppendLine("<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\">");

            // === RAGGRUPPA LINEE PER LAYER ===
            var lineePerLayer = _linee.GroupBy(l => l.Layer);
            foreach (var gruppo in lineePerLayer)
            {
                sb.AppendLine($"  <g id=\"{gruppo.Key}\">");
                foreach (var linea in gruppo)
                {
                    sb.AppendLine($"    <line x1=\"{linea.Inizio.X.ToString("F2", System.Globalization.CultureInfo.InvariantCulture)}\" " +
              $"y1=\"{(-linea.Inizio.Y).ToString("F2", System.Globalization.CultureInfo.InvariantCulture)}\" " +
              $"x2=\"{linea.Fine.X.ToString("F2", System.Globalization.CultureInfo.InvariantCulture)}\" " +
              $"y2=\"{(-linea.Fine.Y).ToString("F2", System.Globalization.CultureInfo.InvariantCulture)}\" " +
              $"stroke=\"rgb({linea.Colore.R},{linea.Colore.G},{linea.Colore.B})\" " +
              $"stroke-width=\"{linea.Spessore.ToString("F2", System.Globalization.CultureInfo.InvariantCulture)}\" />");

                }
                sb.AppendLine("  </g>");
            }

            // === BLOCCHI COME TESTI FORMATTI ===
            foreach (var blocco in _blocchi)
            {
                double x = blocco.PuntoInserimento.X;
                double y = -blocco.PuntoInserimento.Y; // Y negativa per coerenza SVG

                sb.AppendLine($"  <text x=\"{x.ToString("F2", System.Globalization.CultureInfo.InvariantCulture)}\" " +
                              $"y=\"{y.ToString("F2", System.Globalization.CultureInfo.InvariantCulture)}\" " +
                              $"font-size=\"3\" fill=\"black\">");

                sb.AppendLine($"    BLOCCO,{blocco.Nome}");

                if (blocco.Attributi != null)
                {
                    foreach (var attr in blocco.Attributi)
                        sb.AppendLine($"    {attr.Key},{attr.Value}");
                }

                sb.AppendLine("  </text>");
            }

            // === CHIUSURA SVG ===
            sb.AppendLine("</svg>");

            return sb.ToString();
        }

    }
}

