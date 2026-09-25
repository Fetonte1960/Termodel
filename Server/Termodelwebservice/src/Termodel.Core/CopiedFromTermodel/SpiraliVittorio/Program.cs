// Program.cs
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace SpiralHeating
{
    class Linea
    {
        public string Id { get; set; }
        public Punto P0 { get; set; }
        public Punto P1 { get; set; }
        public Punto PuntoInterno { get; set; }
        public Punto PuntoEsterno { get; set; }
    }
    
    class Program
    {
        // Parametri di posa
        // Modificato da Codex per realizzare: passo della spirale rossa pari
        // a 0,30 m e ritorno collocato a metà passo.
        public const double PassoTubi = 0.30;
        private const double DistanzaPareti = PassoTubi;
        
        // Parametri chiusura spirale
        private const double RaggioCurvatura = 0.10;
        private const double DistanzaRitorno = PassoTubi / 2.0;
        private const double DistanzaRotazioneUltimoPunto = 0.20;
        
        // Modalità debug
        private const bool Debug = false;
        
        // Tolleranza per confronto punti
        private const double Tolleranza = 0.001;
        /*
        static void Main(string[] args)
        {
            if (Debug)
            {
                Console.WriteLine("Scegli operazione:");
                Console.WriteLine("1. Genera spirale");
                Console.WriteLine("2. Chiudi spirale");
                Console.Write("Scelta: ");
                
                string scelta = Console.ReadLine();
                
                if (scelta == "1")
                {
                    GeneraSpirale();
                }
                else if (scelta == "2")
                {
                    ChiudiSpiraleFiles();
                }
                else
                {
                    Console.WriteLine("Scelta non valida");
                }
            }
            else
            {
                // Esecuzione automatica
                GeneraSpirale();
                ChiudiSpiraleFiles();
            }
        }
        */
        public static void AggiornaSpirali()
        {
            GeneraSpirale();
            ChiudiSpiraleFiles();
        }
        static void GeneraSpirale()
        {
            string xmlFile = "locale.xml";
            
            if (!File.Exists(xmlFile))
            {
                Console.WriteLine($"File {xmlFile} non trovato!");
                return;
            }
            
            XDocument doc = XDocument.Load(xmlFile);
            CultureInfo ci = CultureInfo.InvariantCulture;
            
            // Leggi tutte le linee (tubi)
            var linee = doc.Descendants("Linea")
                .Select(l => new Linea
                {
                    Id = l.Attribute("Id").Value,
                    P0 = new Punto(
                        double.Parse(l.Element("P0").Attribute("X").Value, ci),
                        double.Parse(l.Element("P0").Attribute("Y").Value, ci)
                    ),
                    P1 = new Punto(
                        double.Parse(l.Element("P1").Attribute("X").Value, ci),
                        double.Parse(l.Element("P1").Attribute("Y").Value, ci)
                    )
                })
                .ToList();
            
            // Leggi tutti i locali
            var locali = doc.Descendants("Locale").ToList();
            
            // Lista per SVG combinato
            var tutteLeSpirali = new List<(string localeId, List<Punto> perimetro, List<Punto> spirale, Punto startPoint, List<List<Punto>> offsets)>();
            
            if (Debug && !Directory.Exists("svg"))
                Directory.CreateDirectory("svg");
            
            // Se debug, genera SVG vuoto con tubi e perimetri
            if (Debug)
            {
                SalvaSvgVuoto("locale_vuoto.svg", locali, linee, doc);
                Console.WriteLine("Salvato: locale_vuoto.svg");
            }
            
            foreach (var locale in locali)
            {
                string localeId = locale.Attribute("Id").Value;
                Console.WriteLine($"Elaborazione: {localeId}");
                
                // Leggi perimetro
                var perimetro = locale.Descendants("PerimetroInterno")
                    .Elements("Punto")
                    .Select(p => new Punto(
                        double.Parse(p.Attribute("X").Value, ci),
                        double.Parse(p.Attribute("Y").Value, ci)
                    ))
                    .ToList();
                
				perimetro = GeometryUtils.RoundAndSnapVertices(perimetro, 2);
				
				// Rimuovi ultimo vertice se duplicato del primo
				if (perimetro.Count > 1 && 
					Math.Abs(perimetro[0].X - perimetro[perimetro.Count - 1].X) < 0.001 &&
					Math.Abs(perimetro[0].Y - perimetro[perimetro.Count - 1].Y) < 0.001)
				{
					perimetro.RemoveAt(perimetro.Count - 1);
					Console.WriteLine("Rimosso ultimo vertice duplicato");
				}
				
				
				perimetro = GeometryUtils.RemoveCollinearVertices(perimetro);

				
                if (perimetro.Count < 3)
                {
                    Console.WriteLine($"  Perimetro non valido per {localeId}");
                    continue;
                }
                
                // Trova linea di ingresso per questo locale
                var lineaIngresso = TrovaLineaIngressoPerLocale(linee, perimetro);
                
                if (lineaIngresso == null)
                {
                    Console.WriteLine($"  Nessuna linea di ingresso trovata per {localeId}");
                    continue;
                }
                
                // Calcola punto di intersezione (nuovo PuntoInterno)
                Punto nuovoPuntoInterno = CalcolaIntersezioneConPerimetro(lineaIngresso.P0, lineaIngresso.P1, perimetro);
                
                if (nuovoPuntoInterno == null)
                {
                    Console.WriteLine($"  Errore: nessuna intersezione trovata per {localeId}");
                    continue;
                }
                
                // Aggiorna PuntoInterno con l'intersezione
                lineaIngresso.PuntoInterno = nuovoPuntoInterno;
                
                Console.WriteLine($"  Linea ingresso: {lineaIngresso.Id}");
                Console.WriteLine($"  Punto interno (intersezione): ({lineaIngresso.PuntoInterno.X:F2}, {lineaIngresso.PuntoInterno.Y:F2})");
                
                // Salva P3 nel XML
                var lineaXml = doc.Descendants("Linea")
                    .FirstOrDefault(l => l.Attribute("Id").Value == lineaIngresso.Id);
                
                if (lineaXml != null)
                {
                    // Rimuovi P3 esistente se presente
                    lineaXml.Elements("P3").Remove();
                    
                    // Aggiungi nuovo P3
                    lineaXml.Add(new XElement("P3",
                        new XAttribute("X", nuovoPuntoInterno.X.ToString("F2", ci)),
                        new XAttribute("Y", nuovoPuntoInterno.Y.ToString("F2", ci))
                    ));
                }
                
                // Genera spirale (sempre generata per salvarla nell'XML)
                List<Punto> spiral;
                List<List<Punto>> offsets;
                (spiral, offsets) = SpiralGenerator.Generate(
                    perimetro,
                    lineaIngresso.PuntoInterno,
                    DistanzaPareti,
                    true  // writeSvg non usato in SpiralGenerator
                );
                
                // Salva spirale nel locale XML
                SalvaSpiralInLocale(locale, spiral);
                
                // Aggiungi alla lista per SVG combinato
                tutteLeSpirali.Add((localeId, perimetro, spiral, lineaIngresso.PuntoInterno, offsets));
                
                // Se debug, salva anche SVG singolo
                if (Debug)
                {
                    string svgFileName = Path.Combine("svg", $"{localeId}.svg");
                    UtilityFunctions.SaveToSvg(svgFileName, perimetro, spiral, lineaIngresso.PuntoInterno, offsets);
                    Console.WriteLine($"  Salvato: {svgFileName}");
                }
            }
            
            // Salva XML aggiornato
            doc.Save(xmlFile);
            Console.WriteLine($"Aggiornato: {xmlFile}");
            
            // Salva SVG combinato
            SalvaSvgCombinato("locale.svg", tutteLeSpirali);
            Console.WriteLine($"Salvato: locale.svg");
            
            Console.WriteLine("Completato!");
        }
        
        static Linea TrovaLineaIngressoPerLocale(List<Linea> linee, List<Punto> perimetro)
        {
            foreach (var linea in linee)
            {
                // Verifica se P0 è dentro il perimetro
                bool p0Interno = GeometryUtils.IsInsidePolygon(linea.P0, perimetro);
                bool p1Interno = GeometryUtils.IsInsidePolygon(linea.P1, perimetro);
                
                Punto puntoInterno = null;
                Punto puntoEsterno = null;
                
                // Uno deve essere dentro, l'altro fuori
                if (p0Interno && !p1Interno)
                {
                    puntoInterno = linea.P0;
                    puntoEsterno = linea.P1;
                }
                else if (p1Interno && !p0Interno)
                {
                    puntoInterno = linea.P1;
                    puntoEsterno = linea.P0;
                }
                else
                {
                    // Entrambi dentro o entrambi fuori - non valida
                    continue;
                }
                
                // Verifica che il punto interno NON coincida con punti di altre linee
                bool puntoCondiviso = false;
                foreach (var altraLinea in linee)
                {
                    if (altraLinea.Id == linea.Id) continue;
                    
                    if (DistanzaPunti(puntoInterno, altraLinea.P0) < Tolleranza ||
                        DistanzaPunti(puntoInterno, altraLinea.P1) < Tolleranza)
                    {
                        puntoCondiviso = true;
                        break;
                    }
                }
                
                // Se il punto interno non è condiviso, questa è una linea valida
                if (!puntoCondiviso)
                {
                    linea.PuntoInterno = puntoInterno;
                    linea.PuntoEsterno = puntoEsterno;
                    return linea;
                }
            }
            
            return null;
        }
        
        static double DistanzaPunti(Punto p1, Punto p2)
        {
            return Math.Sqrt(Math.Pow(p1.X - p2.X, 2) + Math.Pow(p1.Y - p2.Y, 2));
        }
        
        static Punto CalcolaIntersezioneConPerimetro(Punto p0, Punto p1, List<Punto> perimetro)
        {
            for (int i = 0; i < perimetro.Count; i++)
            {
                Punto a = perimetro[i];
                Punto b = perimetro[(i + 1) % perimetro.Count];
                
                Punto intersezione = CalcolaIntersezioneSegmenti(p0, p1, a, b);
                if (intersezione != null)
                {
                    return intersezione;
                }
            }
            return null;
        }
        
        static Punto CalcolaIntersezioneSegmenti(Punto p1, Punto p2, Punto p3, Punto p4)
        {
            double x1 = p1.X, y1 = p1.Y;
            double x2 = p2.X, y2 = p2.Y;
            double x3 = p3.X, y3 = p3.Y;
            double x4 = p4.X, y4 = p4.Y;
            
            double denom = (x1 - x2) * (y3 - y4) - (y1 - y2) * (x3 - x4);
            
            if (Math.Abs(denom) < 1e-10)
                return null; // Paralleli
            
            double t = ((x1 - x3) * (y3 - y4) - (y1 - y3) * (x3 - x4)) / denom;
            double u = -((x1 - x2) * (y1 - y3) - (y1 - y2) * (x1 - x3)) / denom;
            
            if (t >= 0 && t <= 1 && u >= 0 && u <= 1)
            {
                double x = x1 + t * (x2 - x1);
                double y = y1 + t * (y2 - y1);
                return new Punto(x, y);
            }
            
            return null;
        }
        
        static void SalvaSpiralInLocale(XElement locale, List<Punto> spiral)
        {
            CultureInfo ci = CultureInfo.InvariantCulture;
            
            // Rimuovi spirale esistente
            locale.Elements("Spirale").Remove();
            
            // Crea nuova spirale
            var spiraleElement = new XElement("Spirale");
            foreach (var punto in spiral)
            {
                spiraleElement.Add(new XElement("Punto",
                    new XAttribute("X", punto.X.ToString("F2", ci)),
                    new XAttribute("Y", punto.Y.ToString("F2", ci))
                ));
            }
            
            locale.Add(spiraleElement);
        }
        
        static void SalvaSvgCombinato(string filePath, 
            List<(string localeId, List<Punto> perimetro, List<Punto> spirale, Punto startPoint, List<List<Punto>> offsets)> spirali)
        {
            if (spirali.Count == 0) return;
            
            var allPoints = new List<Punto>();
            foreach (var (_, perimetro, spirale, startPoint, offsets) in spirali)
            {
                allPoints.AddRange(perimetro);
                allPoints.AddRange(spirale);
                if (startPoint != null) allPoints.Add(startPoint);
                if (offsets != null)
                    foreach (var offset in offsets)
                        allPoints.AddRange(offset);
            }
            
            double minX = allPoints.Min(p => p.X) - 0.5;
            double minY = allPoints.Min(p => p.Y) - 0.5;
            double maxX = allPoints.Max(p => p.X) + 0.5;
            double maxY = allPoints.Max(p => p.Y) + 0.5;
            
            double width = maxX - minX;
            double height = maxY - minY;
            double scale = 100;
            
            using (StreamWriter sw = new StreamWriter(filePath))
            {
                sw.WriteLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                sw.WriteLine($"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"{width * scale}\" height=\"{height * scale}\" viewBox=\"{minX} {minY} {width} {height}\">");
                sw.WriteLine("<g transform=\"scale(1,-1) translate(0," + (-(minY + maxY)) + ")\">");
                
                foreach (var (localeId, perimetro, spirale, startPoint, offsets) in spirali)
                {
                    // Perimetro rosso
                    sw.Write("<polygon points=\"");
                    foreach (var p in perimetro)
                        sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                    sw.WriteLine("\" fill=\"none\" stroke=\"red\" stroke-width=\"0.02\"/>");
                    
                    // Spirale blu
                    if (spirale.Count > 1)
                    {
                        sw.Write("<polyline points=\"");
                        foreach (var p in spirale)
                            sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                        sw.WriteLine("\" fill=\"none\" stroke=\"blue\" stroke-width=\"0.015\"/>");
                    }
                    
                    // Punto ingresso verde
                    if (startPoint != null)
                    {
                        sw.WriteLine($"<circle cx=\"{startPoint.X.ToString(CultureInfo.InvariantCulture)}\" cy=\"{startPoint.Y.ToString(CultureInfo.InvariantCulture)}\" r=\"0.05\" fill=\"green\"/>");
                    }
                }
                
                sw.WriteLine("</g>");
                sw.WriteLine("</svg>");
            }
        }
        
        static void SalvaSvgVuoto(string filePath, List<XElement> locali, List<Linea> linee, XDocument doc)
        {
            CultureInfo ci = CultureInfo.InvariantCulture;
            
            // Raccogli tutti i perimetri
            var tuttiPerimetri = new List<List<Punto>>();
            foreach (var locale in locali)
            {
                var perimetro = locale.Descendants("PerimetroInterno")
                    .Elements("Punto")
                    .Select(p => new Punto(
                        double.Parse(p.Attribute("X").Value, ci),
                        double.Parse(p.Attribute("Y").Value, ci)
                    ))
                    .ToList();
                
                if (perimetro.Count >= 3)
                    tuttiPerimetri.Add(perimetro);
            }
            
            // Calcola bounding box
            var allPoints = new List<Punto>();
            foreach (var perimetro in tuttiPerimetri)
                allPoints.AddRange(perimetro);
            foreach (var linea in linee)
            {
                allPoints.Add(linea.P0);
                allPoints.Add(linea.P1);
            }
            
            if (allPoints.Count == 0) return;
            
            double minX = allPoints.Min(p => p.X) - 0.5;
            double minY = allPoints.Min(p => p.Y) - 0.5;
            double maxX = allPoints.Max(p => p.X) + 0.5;
            double maxY = allPoints.Max(p => p.Y) + 0.5;
            
            double width = maxX - minX;
            double height = maxY - minY;
            double scale = 100;
            
            using (StreamWriter sw = new StreamWriter(filePath))
            {
                sw.WriteLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                sw.WriteLine($"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"{width * scale}\" height=\"{height * scale}\" viewBox=\"{minX} {minY} {width} {height}\">");
                sw.WriteLine("<g transform=\"scale(1,-1) translate(0," + (-(minY + maxY)) + ")\">");
                
                // Disegna perimetri in nero
                foreach (var perimetro in tuttiPerimetri)
                {
                    sw.Write("<polygon points=\"");
                    foreach (var p in perimetro)
                        sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                    sw.WriteLine("\" fill=\"none\" stroke=\"black\" stroke-width=\"0.02\"/>");
                }
                
                // Disegna tubi in rosso
                foreach (var linea in linee)
                {
                    sw.WriteLine($"<line x1=\"{linea.P0.X.ToString(CultureInfo.InvariantCulture)}\" y1=\"{linea.P0.Y.ToString(CultureInfo.InvariantCulture)}\" x2=\"{linea.P1.X.ToString(CultureInfo.InvariantCulture)}\" y2=\"{linea.P1.Y.ToString(CultureInfo.InvariantCulture)}\" stroke=\"red\" stroke-width=\"0.02\"/>");
                }
                
                sw.WriteLine("</g>");
                sw.WriteLine("</svg>");
            }
        }
        
        static void ChiudiSpiraleFiles()
        {
            string xmlFile = "locale.xml";
            
            if (!File.Exists(xmlFile))
            {
                Console.WriteLine($"File {xmlFile} non trovato!");
                return;
            }
            
            ChiudiSpirale.Chiudi(xmlFile, RaggioCurvatura, DistanzaRitorno, DistanzaRotazioneUltimoPunto, Debug);
        }
    }
}
