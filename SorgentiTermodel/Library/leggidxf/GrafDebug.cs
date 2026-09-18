using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System;
using System.Collections.Generic;
using System.IO;
using NetTopologySuite.Geometries;
using System.Globalization;
using Termodel.utilities;
using System.Windows.Controls;
using System.Windows.Media;


namespace Termodel.Leggidxf
{
    public static class SVGHelper
    {

        // Percorso del file fisso
               private static string PathBase = @"C:\DOCUMENTI\termomodel\";
               //private static string filePath = @"C:\DOCUMENTI\termomodel\output.svg";
        // Fattore di scala per ingrandire le coordinate
        private static readonly double scaleFactor = 100;  // Aumentato a 500

        // Funzione che converte LineString in una lista di coordinate (x, y)
        public static void Init_class()
        {
            PathBase = PathBase = Path.Combine(GestProg.ProgramPath, "svg");
            // PathBase = @"C:\DOCUMENTI\termomodel\";
            //filePath = @"C:\DOCUMENTI\termomodel\output.svg";
        }
        public static List<(double x1, double y1, double x2, double y2,string userData)> ConvertLineStringToIndependentLines(List<LineString> lineStrings)
        {
            var coordinatesList = new List<(double x1, double y1, double x2, double y2, string userData)>();

            foreach (var lineString in lineStrings)
            {
                if (lineString.Coordinates.Length >= 2)
                {
                    var start = lineString.Coordinates[0];
                    var end = lineString.Coordinates[1];

                    // Applica un fattore di scala alle coordinate
                    string userData = lineString.UserData?.ToString() ?? string.Empty;
                    coordinatesList.Add((start.X * scaleFactor, start.Y * scaleFactor, end.X * scaleFactor, end.Y * scaleFactor, userData));
                }
            }

            return coordinatesList;
        }
        public static void DrawInCanvas(Canvas drawingCanvas, List<netDxf.Entities.Line> filteredLines)
        {
            // Inizializza i valori di minimo e massimo per X e Y
            double maxX = double.MinValue;
            double minX = double.MaxValue;
            double maxY = double.MinValue;
            double minY = double.MaxValue;

            // Trova i valori di estensione dell'area da disegnare
            foreach (var entity in filteredLines)
            {
                maxX = Math.Max(maxX, Math.Max(entity.StartPoint.X, entity.EndPoint.X));
                minX = Math.Min(minX, Math.Min(entity.StartPoint.X, entity.EndPoint.X));
                maxY = Math.Max(maxY, Math.Max(entity.StartPoint.Y, entity.EndPoint.Y));
                minY = Math.Min(minY, Math.Min(entity.StartPoint.Y, entity.EndPoint.Y));
            }

            // Calcola le dimensioni in millimetri
            double dxfWidthInMillimeters = maxX - minX;
            double dxfHeightInMillimeters = maxY - minY;
            double canvasWidth = drawingCanvas.ActualWidth;
            double canvasHeight = drawingCanvas.ActualHeight;

            // Calcola il fattore di scala
            double scale = Math.Min(canvasWidth / dxfWidthInMillimeters, canvasHeight / dxfHeightInMillimeters);
            double offsetX = (canvasWidth - (dxfWidthInMillimeters * scale)) / 2;
            double offsetY = (canvasHeight - (dxfHeightInMillimeters * scale)) / 2;

            // Pulisce il Canvas prima di disegnare nuove linee
            drawingCanvas.Children.Clear();

            // Disegna ciascuna linea sul Canvas
            foreach (var entity in filteredLines)
            {
                System.Windows.Shapes.Line line = new System.Windows.Shapes.Line
                {
                    X1 = offsetX + (entity.StartPoint.X - minX) * scale,
                    Y1 = offsetY + (maxY - entity.StartPoint.Y) * scale,
                    X2 = offsetX + (entity.EndPoint.X - minX) * scale,
                    Y2 = offsetY + (maxY - entity.EndPoint.Y) * scale,
                    Stroke = new SolidColorBrush(System.Windows.Media.Color.FromRgb(entity.Color.R, entity.Color.G, entity.Color.B)),
                    StrokeThickness = 2
                };

                // Aggiunge la linea al Canvas
                drawingCanvas.Children.Add(line);
            }
        }
        public static void SVGAddPolygon(Polygon poligono, List<NetTopologySuite.Geometries.LineString> lineePoligoni)
        {
            // Ottieni l'anello esterno del poligono (ExteriorRing)
            var exteriorRing = poligono.ExteriorRing;

            // Estrai le coordinate dell'anello esterno
            var coordinates = exteriorRing.Coordinates;

            // Trasforma l'anello esterno del poligono in singole linee
            for (int i = 0; i < coordinates.Length - 1; i++)
            {
                // Crea una linea tra due punti consecutivi
                var line = new LineString(new Coordinate[] { coordinates[i], coordinates[i + 1] });

                // Aggiungi la linea alla lista passata per la visualizzazione SVG
                lineePoligoni.Add(line);
            }
        }
        public static List<NetTopologySuite.Geometries.LineString> SVGPolygons(List<NetTopologySuite.Geometries.Geometry> geometrie)
        {
            // Lista che conterrà le linee per la visualizzazione in SVG
            var lineePoligoni = new List<NetTopologySuite.Geometries.LineString>();

            // Itera solo sui poligoni nella lista di geometrie
            foreach (var poligono in geometrie.OfType<Polygon>())
            {
                // Usa la funzione esistente SVGAddPolygon per ogni singolo poligono
                SVGAddPolygon(poligono, lineePoligoni);
            }

            // Ritorna la lista di linee costruita
            return lineePoligoni;
        }
        public static List<NetTopologySuite.Geometries.LineString> SVGPolyNTS(NetTopologySuite.Geometries.Polygon poligono)
        {
            // Lista che conterrà le linee per la visualizzazione in SVG
            var lineePoligoni = new List<NetTopologySuite.Geometries.LineString>();

            // Itera solo sui poligoni nella lista di geometrie
            //foreach (var poligono in geometrie.OfType<Polygon>())
            {
                // Usa la funzione esistente SVGAddPolygon per ogni singolo poligono
                SVGAddPolygon(poligono, lineePoligoni);
            }

            // Ritorna la lista di linee costruita
            return lineePoligoni;
        }
        // Funzione che converte NetTopologySuite Geometry in una lista di coordinate (x, y)
        public static List<(double x, double y)> ConvertGeometryToPolyline(NetTopologySuite.Geometries.Geometry geometry)
        {
            // Controlla se geometry è null e ritorna una lista vuota
            if (geometry == null)
            {
                return new List<(double x, double y)>();  // Lista vuota se geometry è null
            }
            var coordinatesList = new List<(double x, double y)>();

            foreach (var coord in geometry.Coordinates)
            {
                // Applica un fattore di scala alle coordinate
                coordinatesList.Add((coord.X * scaleFactor, coord.Y * scaleFactor));
            }

            return coordinatesList;
        }
        
        // Funzione per calcolare il viewBox
        private static string CalcolaViewBoxAnomalie(List<(double x1, double y1, double x2, double y2)> listaVerde, List<(double x1, double y1, double x2, double y2)> listaRossa)
        {
            double minX = double.MaxValue, minY = double.MaxValue;
            double maxX = double.MinValue, maxY = double.MinValue;

            // Cerca i limiti per la lista verde
            foreach (var (x1, y1, x2, y2) in listaVerde)
            {
                minX = Math.Min(minX, Math.Min(x1, x2));
                minY = Math.Min(minY, Math.Min(y1, y2));
                maxX = Math.Max(maxX, Math.Max(x1, x2));
                maxY = Math.Max(maxY, Math.Max(y1, y2));
            }

            // Cerca i limiti per la lista rossa
            foreach (var (x1, y1, x2, y2) in listaRossa)
            {
                minX = Math.Min(minX, Math.Min(x1, x2));
                minY = Math.Min(minY, Math.Min(y1, y2));
                maxX = Math.Max(maxX, Math.Max(x1, x2));
                maxY = Math.Max(maxY, Math.Max(y1, y2));
            }

            // Calcola il viewBox con un piccolo margine
            double margin = 10.0;
            return $"{minX - margin} {minY - margin} {maxX - minX + 2 * margin} {maxY - minY + 2 * margin}";
        }
        private static string CalcolaViewBox(List<(double x1, double y1, double x2, double y2, string userData)> listaVerde, List<(double x, double y)> listaRossa)
        {
            double minX = double.MaxValue, minY = double.MaxValue;
            double maxX = double.MinValue, maxY = double.MinValue;

            // Cerca i limiti per la lista verde
            foreach (var (x1, y1, x2, y2, userData) in listaVerde)
            {
                minX = Math.Min(minX, Math.Min(x1, x2));
                minY = Math.Min(minY, Math.Min(y1, y2));
                maxX = Math.Max(maxX, Math.Max(x1, x2));
                maxY = Math.Max(maxY, Math.Max(y1, y2));
            }

            // Cerca i limiti per la lista rossa
            foreach (var (x, y) in listaRossa)
            {
                minX = Math.Min(minX, x);
                minY = Math.Min(minY, y);
                maxX = Math.Max(maxX, x);
                maxY = Math.Max(maxY, y);
            }

            // Calcola il viewBox con un piccolo margine
            // Calcola la larghezza e l'altezza del disegno
            double width = maxX - minX;
            double height = maxY - minY;

            // Determina la maggiore delle due dimensioni e calcola il margine come il 10%
            double maggioreDimensione = Math.Max(width, height);
            double margin = 0.1 * maggioreDimensione;
            //return $"{minX} {minY} {100} {100}";
            //return $"{minX - margin} {minY - margin} {maxX - minX + 2 * margin} {maxY - minY + 2 * margin}";
            return $"{Utigen.DoubleToStrPunto(minX - margin)} {Utigen.DoubleToStrPunto(minY - margin)} {Utigen.DoubleToStrPunto(maxX - minX + 2 * margin)} {Utigen.DoubleToStrPunto(maxY - minY + 2 * margin)}";
        }
        // Funzione che crea il file SVG con colori verde (linee indipendenti) e rosso (polilinea)
        //public static void CreaFileSVG(List<(double x1, double y1, double x2, double y2)> listaVerde, List<(double x, double y)> listaRossa)

        public static string Get_Color(object userdata, string coloreDef)
        {
            // Controlla se userdata è null o vuoto
            if (userdata == null || string.IsNullOrEmpty(userdata.ToString()))
            {
                return coloreDef;  // Restituisce il colore di default se userdata è inconsistente
            }

            // Ottieni il quarto parametro (indice 4) da userdata
            string colorIndexStr = Utigen.GetItemFromCommaSeparatedString(userdata.ToString(), 4);

            // Controlla che il quarto parametro sia valido (non null o vuoto)
            if (string.IsNullOrEmpty(colorIndexStr))
            {
                return coloreDef;  // Se il quarto parametro non è presente o non valido, restituisce il colore di default
            }

            // Prova a convertire l'indice in intero
            if (int.TryParse(colorIndexStr, out int colorCode))
            {
                // Restituisci il colore in base al codice
                switch (colorCode)
                {
                    case 1:
                        return "blue";  // Se 1, restituisci blu
                    case 2:
                        return "yellow";  // Se 2, restituisci giallo
                    default:
                        return coloreDef;  // Se non è né 1 né 2, restituisci il colore di default
                }
            }
            else
            {
                // Se la conversione fallisce, restituisci il colore di default
                return coloreDef;
            }
        }
        
        public static void CreaFileSVG(
        List<(double x1, double y1, double x2, double y2, string userData)> listaVerde,  // Aggiungiamo il colore
        List<(double x, double y)> listaRossa)
        {
            // Calcolare il viewBox in base alle coordinate
            string viewBox = CalcolaViewBox(listaVerde, listaRossa);

            var sb = new StringBuilder();

            // Intestazione del file SVG con dimensioni e viewBox
            sb.AppendLine($"<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"1280\" height=\"768\" viewBox=\"{viewBox}\">");

            // Aggiungere le linee verdi indipendenti
            int contatore = 1; // Inizializza il contatore
            foreach (var (x1, y1, x2, y2,userData) in listaVerde)
            {
                // Usa la funzione Get_Color per determinare il colore da usare
                string colore = Get_Color(userData, "green"); // "green" è il colore di default

                

                sb.AppendLine($"<line x1=\"{x1.ToString(CultureInfo.InvariantCulture)}\" y1=\"{y1.ToString(CultureInfo.InvariantCulture)}\" x2=\"{x2.ToString(CultureInfo.InvariantCulture)}\" y2=\"{y2.ToString(CultureInfo.InvariantCulture)}\" style=\"stroke:{colore};stroke-width:2\" />");


                // Aggiungi il numerino al centro della linea
                // Calcola il punto medio
                var midX = (x1 + x2) / 2;
                var midY = (y1 + y2) / 2;
                string  colorepar = Utigen.GetItemFromCommaSeparatedString(userData.ToString(), (int)PUserdata.colore);
                sb.AppendLine($"<text x=\"{midX.ToString(CultureInfo.InvariantCulture)}\" y=\"{midY.ToString(CultureInfo.InvariantCulture)}\" fill=\"black\" font-size=\"10\" text-anchor=\"middle\">{contatore}--{colorepar}</text>");

                // Ottieni Z1 e Z2 usando la funzione Get_Z
                string z1 = Utigen.Get_Z(userData, 1); // Z1 del primo vertice
                string z2 = Utigen.Get_Z(userData, 2); // Z2 del secondo vertice

                // Definisci gli offset per Z1 e Z2 per evitare sovrapposizioni
                var z1OffsetY = 0;  // Sposta Z1 leggermente verso l'alto
                var z2OffsetY = 0;   // Sposta Z2 leggermente verso il basso

                // Calcola le nuove posizioni al 25% e 75% lungo il tratto
                var z1PosX = x1 + (x2 - x1) * 0.25;  // 25% della distanza lungo l'asse X
                var z1PosY = y1 + (y2 - y1) * 0.25 + z1OffsetY;  // 25% della distanza lungo l'asse Y con offset
                var z2PosX = x1 + (x2 - x1) * 0.75;  // 75% della distanza lungo l'asse X
                var z2PosY = y1 + (y2 - y1) * 0.75 + z2OffsetY;  // 75% della distanza lungo l'asse Y con offset

                // Aggiungi i valori Z1 e Z2 con l'indice della linea (contatore) vicino ai rispettivi vertici con offset differenziati
                sb.AppendLine($"<text x=\"{z1PosX.ToString(CultureInfo.InvariantCulture)}\" y=\"{z1PosY.ToString(CultureInfo.InvariantCulture)}\" fill=\"red\" font-size=\"10\" text-anchor=\"middle\">Z1({contatore})={z1}</text>");
                sb.AppendLine($"<text x=\"{z2PosX.ToString(CultureInfo.InvariantCulture)}\" y=\"{z2PosY.ToString(CultureInfo.InvariantCulture)}\" fill=\"red\" font-size=\"10\" text-anchor=\"middle\">Z2({contatore})={z2}</text>");
                // Incrementa il contatore
                contatore++;
            }

            // Aggiungere la polilinea rossa
            sb.Append("<polyline points=\"");
            foreach (var (x, y) in listaRossa)
            {
                sb.Append($"{x.ToString(CultureInfo.InvariantCulture)},{y.ToString(CultureInfo.InvariantCulture)} ");
            }
            sb.AppendLine("\" style=\"fill:none;stroke:red;stroke-width:2\" />");

            // Chiusura del file SVG
            sb.AppendLine("</svg>");

            // Salva il file nel percorso fisso
            File.WriteAllText(filePath, sb.ToString());
        }
        private static string filePath = "";
        // Funzione principale che converte le geometrie e chiama la creazione del file SVG
        public static void GeneraSVG(string nomefile, List<LineString> lineStrings, NetTopologySuite.Geometries.Geometry geometry)
        {
            filePath = Path.Combine(PathBase, $"{nomefile}.svg");

            // Converte la lista di LineString in linee indipendenti
            var listaVerde = ConvertLineStringToIndependentLines(lineStrings);

            // Converte la geometria in polilinea
            var listaRossa = ConvertGeometryToPolyline(geometry);

            // Chiama la funzione CreaFileSVG
            CreaFileSVG(listaVerde, listaRossa);
        }

        //private static double scaleFactor = 100.0;

        public static void AnomalieLinee(List<LineString> listaVerde, List<LineString> listaRossa, string nomefile)
        {
            // Genera il percorso del file SVG con il nomefile
            string filePath = $"{PathBase}{nomefile}.svg";

            // Calcolare il viewBox in base alle coordinate
            string viewBox = CalcolaViewBoxAnomalie(listaVerde, listaRossa);

            var sb = new StringBuilder();

            // Intestazione del file SVG con dimensioni e viewBox
            sb.AppendLine($"<svg xmlns=\"http://www.w3.org/2000/svg\" version=\"1.1\" width=\"1000\" height=\"1000\" viewBox=\"{viewBox}\">");

            // Aggiungere le linee verdi, applicando il fattore di scala
            int contatore = 1; // Inizializza il contatore
            foreach (var line in listaVerde)
            {
                // Calcola il punto medio
                var midX = (line.StartPoint.X + line.EndPoint.X) / 2;
                var midY = (line.StartPoint.Y + line.EndPoint.Y) / 2;
                sb.AppendLine($"<line x1=\"{(line.StartPoint.X * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" y1=\"{(line.StartPoint.Y * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" x2=\"{(line.EndPoint.X * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" y2=\"{(line.EndPoint.Y * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" style=\"stroke:green;stroke-width:2\" />");
                // Aggiungi il numerino al centro della linea
                sb.AppendLine($"<text x=\"{(midX * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" y=\"{(midY * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" fill=\"black\" font-size=\"10\" text-anchor=\"middle\">{contatore}</text>");

                // Incrementa il contatore
                contatore++;
            }

            // Aggiungere le linee rosse, applicando il fattore di scala
            foreach (var line in listaRossa)
            {
                sb.AppendLine($"<line x1=\"{(line.StartPoint.X * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" y1=\"{(line.StartPoint.Y * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" x2=\"{(line.EndPoint.X * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" y2=\"{(line.EndPoint.Y * scaleFactor).ToString(CultureInfo.InvariantCulture)}\" style=\"stroke:red;stroke-width:2\" />");
            }

            // Chiusura del file SVG
            sb.AppendLine("</svg>");

            // Salva il file nel percorso generato
            File.WriteAllText(filePath, sb.ToString());
        }

        // Funzione per calcolare il viewBox in base alle coordinate
        private static string CalcolaViewBoxAnomalie(List<LineString> listaVerde, List<LineString> listaRossa)
        {
            double minX = double.MaxValue, minY = double.MaxValue;
            double maxX = double.MinValue, maxY = double.MinValue;

            // Cerca i limiti per la lista verde
            foreach (var line in listaVerde)
            {
                minX = Math.Min(minX, Math.Min(line.StartPoint.X, line.EndPoint.X));
                minY = Math.Min(minY, Math.Min(line.StartPoint.Y, line.EndPoint.Y));
                maxX = Math.Max(maxX, Math.Max(line.StartPoint.X, line.EndPoint.X));
                maxY = Math.Max(maxY, Math.Max(line.StartPoint.Y, line.EndPoint.Y));
            }

            // Cerca i limiti per la lista rossa
            foreach (var line in listaRossa)
            {
                minX = Math.Min(minX, Math.Min(line.StartPoint.X, line.EndPoint.X));
                minY = Math.Min(minY, Math.Min(line.StartPoint.Y, line.EndPoint.Y));
                maxX = Math.Max(maxX, Math.Max(line.StartPoint.X, line.EndPoint.X));
                maxY = Math.Max(maxY, Math.Max(line.StartPoint.Y, line.EndPoint.Y));
            }

            // Calcola il viewBox con un piccolo margine
            double margin = 10.0;
            return $"{minX - margin} {minY - margin} {maxX - minX + 2 * margin} {maxY - minY + 2 * margin}";
        }
    }

}
