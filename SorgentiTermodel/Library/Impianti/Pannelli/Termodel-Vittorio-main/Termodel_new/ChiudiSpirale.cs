// ChiudiSpirale.cs
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace SpiralHeating
{
    public static class ChiudiSpirale
    {
        public static void Chiudi(string xmlFile, double raggioCurvatura, double distanzaRitorno, double distanzaRotazioneUltimoPunto, bool debug)
        {
            try
            {
                XDocument doc = XDocument.Load(xmlFile);
                CultureInfo ci = CultureInfo.InvariantCulture;
                
                // Leggi tutte le linee (tubi)
                var linee = doc.Descendants("Linea")
                    .Select(l => new
                    {
                        Id = l.Attribute("Id").Value,
                        P0 = new Punto(
                            double.Parse(l.Element("P0").Attribute("X").Value, ci),
                            double.Parse(l.Element("P0").Attribute("Y").Value, ci)
                        ),
                        P1 = new Punto(
                            double.Parse(l.Element("P1").Attribute("X").Value, ci),
                            double.Parse(l.Element("P1").Attribute("Y").Value, ci)
                        ),
                        P3 = l.Element("P3") != null ? new Punto(
                            double.Parse(l.Element("P3").Attribute("X").Value, ci),
                            double.Parse(l.Element("P3").Attribute("Y").Value, ci)
                        ) : null
                    })
                    .ToList();
                
                var locali = doc.Descendants("Locale").ToList();
                
                // Lista per tutte le spirali chiuse
                // Modificato da Codex per realizzare: marcatura numerata della
                // chiusura dei circuiti senza alterare la geometria di Vittorio.
                var tutteLeSpiraliChiuse = new List<(string localeId, List<Punto> spiraleArrotondata, List<Punto> rientro, List<Punto> curvaCollegamento, Punto fineRientro, string chiusuraGptSvg)>();
                int numeroCircuito = 1;
                
                if (debug && !Directory.Exists("svg_2"))
                    Directory.CreateDirectory("svg_2");
                
                foreach (var locale in locali)
                {
                    string localeId = locale.Attribute("Id").Value;
                    var spiraleElement = locale.Element("Spirale");
                    
                    if (spiraleElement == null)
                    {
                        Console.WriteLine($"  Nessuna spirale in {localeId}");
                        continue;
                    }
                    
                    Console.WriteLine($"Chiusura spirale: {localeId}");
                    
                    var spirale = spiraleElement.Elements("Punto")
                        .Select(p => new Punto(
                            double.Parse(p.Attribute("X").Value, ci),
                            double.Parse(p.Attribute("Y").Value, ci)
                        ))
                        .ToList();
                    
                    spirale = GeometryUtils.EliminaDuplicati(spirale);
                    
                    if (spirale.Count < 3)
                    {
                        Console.WriteLine($"  Spirale troppo corta in {localeId}");
                        continue;
                    }
                    
                    // Modificato da Codex per realizzare: ripristino delle
                    // preparazioni geometriche necessarie al corretto sviluppo
                    // del ritorno; viene disattivata più sotto soltanto la curva
                    // di chiusura originale di Vittorio.
                    spirale = SpostaUltimoPuntoASinistra(
                        spirale,
                        distanzaRotazioneUltimoPunto);
                    spirale = AggiungiPuntoIntermedio(spirale);
                    
                    var perimetro = locale.Descendants("PerimetroInterno")
                        .Elements("Punto")
                        .Select(p => new Punto(
                            double.Parse(p.Attribute("X").Value, ci),
                            double.Parse(p.Attribute("Y").Value, ci)
                        ))
                        .ToList();
                    
                    var spiraleArrotondata = GeometryUtils.ArrotondaSpirale(spirale, raggioCurvatura);
                    var rientro = CreaRientro(spiraleArrotondata, distanzaRitorno);
                    // Modificato da Codex per realizzare: ripristino integrale
                    // della chiusura geometrica originale di Vittorio,
                    // mantenendo anche il box numerato ChiusuraGPT.
                    var curvaCollegamento = CreaCurvaCollegamento(
                        spiraleArrotondata,
                        rientro);
                    
                    // Punto finale del rientro (per collegare la linea di ritorno del tubo)
                    Punto fineRientro = rientro.Count > 0 ? rientro[rientro.Count - 1] : null;

                    string chiusuraGptSvg = ChiusuraGPT(
                        perimetro,
                        spiraleArrotondata,
                        rientro,
                        curvaCollegamento,
                        numeroCircuito++);

                    tutteLeSpiraliChiuse.Add((localeId, spiraleArrotondata, rientro, curvaCollegamento, fineRientro, chiusuraGptSvg));
                    
                    // Se debug, salva SVG singolo
                    if (debug)
                    {
                        string svgFileName = Path.Combine("svg_2", $"{localeId}.svg");
                        UtilityFunctions.SalvaSvgArrotondato(svgFileName, perimetro, spiraleArrotondata, rientro, curvaCollegamento);
                        Console.WriteLine($"  Salvato: {svgFileName}");
                    }
                }
                
                // Salva SVG combinato
                SalvaSvgCombinato("locale.svg", tutteLeSpiraliChiuse, linee);
                Console.WriteLine($"Salvato: locale.svg");
                
                Console.WriteLine("Completato!");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ERRORE: {ex.Message}");
            }
        }
        
        private static void SalvaSvgCombinato<T>(string filePath, 
            List<(string localeId, List<Punto> spiraleArrotondata, List<Punto> rientro, List<Punto> curvaCollegamento, Punto fineRientro, string chiusuraGptSvg)> spirali,
            List<T> linee) where T : class
        {
            if (spirali.Count == 0) return;
            
            var allPoints = new List<Punto>();
            
            // Raccogli tutti i punti per calcolare bounding box
            foreach (var (_, spiraleArrotondata, rientro, curvaCollegamento, fineRientro, _) in spirali)
            {
                allPoints.AddRange(spiraleArrotondata);
                allPoints.AddRange(rientro);
                allPoints.AddRange(curvaCollegamento);
                if (fineRientro != null) allPoints.Add(fineRientro);
            }
            
            foreach (var linea in linee)
            {
                allPoints.Add((Punto)linea.GetType().GetProperty("P0").GetValue(linea));
                allPoints.Add((Punto)linea.GetType().GetProperty("P1").GetValue(linea));
                var p3 = linea.GetType().GetProperty("P3").GetValue(linea) as Punto;
                if (p3 != null) allPoints.Add(p3);
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
                
                // Disegna spirali arrotondate e chiuse
                foreach (var (localeId, spiraleArrotondata, rientro, curvaCollegamento, fineRientro, chiusuraGptSvg) in spirali)
                {
                    // Spirale andata (rossa)
                    if (spiraleArrotondata.Count > 1)
                    {
                        sw.Write("<polyline points=\"");
                        foreach (var p in spiraleArrotondata)
                            sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                        sw.WriteLine("\" fill=\"none\" stroke=\"red\" stroke-width=\"0.015\"/>");
                    }
                    
                    // Curva collegamento (rossa)
                    if (curvaCollegamento.Count > 1)
                    {
                        sw.Write("<polyline points=\"");
                        foreach (var p in curvaCollegamento)
                            sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                        sw.WriteLine("\" fill=\"none\" stroke=\"red\" stroke-width=\"0.015\"/>");
                    }
                    
                    // Rientro (blu tratteggiato)
                    if (rientro.Count > 1)
                    {
                        sw.Write("<polyline points=\"");
                        foreach (var p in rientro)
                            sw.Write($"{p.X.ToString(CultureInfo.InvariantCulture)},{p.Y.ToString(CultureInfo.InvariantCulture)} ");
                        sw.WriteLine("\" fill=\"none\" stroke=\"blue\" stroke-width=\"0.015\" stroke-dasharray=\"0.05,0.05\"/>");
                    }

                    // Modificato da Codex per realizzare: scrittura del box
                    // verde numerato prodotto esclusivamente da ChiusuraGPT.
                    if (!string.IsNullOrWhiteSpace(chiusuraGptSvg))
                        sw.WriteLine(chiusuraGptSvg);
                }
                
                // Disegna tutti i tubi in rosso
                foreach (var linea in linee)
                {
                    var p0 = (Punto)linea.GetType().GetProperty("P0").GetValue(linea);
                    var p1 = (Punto)linea.GetType().GetProperty("P1").GetValue(linea);
                    var p3 = linea.GetType().GetProperty("P3").GetValue(linea) as Punto;
                    
                    Punto puntoFinale = p3 ?? p1;
                    
                    // Linea tubo (rosso)
                    sw.WriteLine($"<line x1=\"{p0.X.ToString(CultureInfo.InvariantCulture)}\" y1=\"{p0.Y.ToString(CultureInfo.InvariantCulture)}\" x2=\"{puntoFinale.X.ToString(CultureInfo.InvariantCulture)}\" y2=\"{puntoFinale.Y.ToString(CultureInfo.InvariantCulture)}\" stroke=\"red\" stroke-width=\"0.02\"/>");
                }
                
                sw.WriteLine("</g>");
                sw.WriteLine("</svg>");
            }
        }

        // Funzione realizzata da Codex in autonomia
        /// <summary>
        /// Crea la sola annotazione grafica della chiusura del circuito.
        /// Il centro è il punto medio fra la fine della mandata e l'inizio
        /// del rientro. La funzione non modifica le liste geometriche create
        /// da Vittorio e restituisce gli elementi SVG rect/text già completi.
        /// Gli attributi data-x e data-y conservano le coordinate CAD reali
        /// per la successiva conversione dell'annotazione nel DXF esecutivo.
        /// </summary>
        private static string ChiusuraGPT(
            List<Punto> perimetro,
            List<Punto> spiraleArrotondata,
            List<Punto> rientro,
            List<Punto> curvaCollegamento,
            int numeroCircuito)
        {
            if (spiraleArrotondata == null ||
                spiraleArrotondata.Count == 0 ||
                rientro == null ||
                rientro.Count == 0 ||
                numeroCircuito <= 0)
            {
                return string.Empty;
            }

            Punto fineMandata =
                spiraleArrotondata[spiraleArrotondata.Count - 1];
            Punto inizioRientro = rientro[0];
            double centroX = (fineMandata.X + inizioRientro.X) / 2.0;
            double centroY = (fineMandata.Y + inizioRientro.Y) / 2.0;
            // Modificato da Codex per realizzare: dimensioni statiche minime
            // dell'etichetta, mantenendo la leggibilità prevista a scala 1:50.
            const double altezza = 0.14;
            const double larghezza = 0.20;

            // Modificato da Codex per realizzare: collocazione dell'etichetta
            // nella zona libera più ampia del locale, evitando tubi e pareti.
            Punto posizioneEtichetta = BaricentroZonaVuota(
                perimetro,
                spiraleArrotondata,
                rientro,
                curvaCollegamento,
                larghezza,
                altezza);
            if (posizioneEtichetta != null)
            {
                centroX = posizioneEtichetta.X;
                centroY = posizioneEtichetta.Y;
            }

            double x = centroX - larghezza / 2.0;
            double y = centroY - altezza / 2.0;

            string sx = x.ToString(CultureInfo.InvariantCulture);
            string sy = y.ToString(CultureInfo.InvariantCulture);
            string scx = centroX.ToString(CultureInfo.InvariantCulture);
            string scy = centroY.ToString(CultureInfo.InvariantCulture);
            string swidth =
                larghezza.ToString(CultureInfo.InvariantCulture);
            string sheight =
                altezza.ToString(CultureInfo.InvariantCulture);
            string numero =
                numeroCircuito.ToString(CultureInfo.InvariantCulture);

            return
                $"<rect x=\"{sx}\" y=\"{sy}\" width=\"{swidth}\" " +
                $"height=\"{sheight}\" fill=\"none\" stroke=\"green\" " +
                $"stroke-width=\"0.02\" data-termodel=\"chiusura-gpt\" " +
                $"data-circuito=\"{numero}\"/>" +
                Environment.NewLine +
                $"<text x=\"0\" y=\"0\" data-x=\"{scx}\" " +
                $"data-y=\"{scy}\" data-altezza=\"0.10\" " +
                $"data-termodel=\"chiusura-gpt\" " +
                $"data-circuito=\"{numero}\" fill=\"green\" " +
                $"font-size=\"0.10\" text-anchor=\"middle\" " +
                $"dominant-baseline=\"middle\" " +
                $"transform=\"translate({scx} {scy}) scale(1,-1)\">" +
                $"{numero}</text>";
        }

        // Funzione realizzata da Codex in autonomia
        /// <summary>
        /// Cerca una posizione libera per il rettangolo dell'etichetta.
        /// Esegue prima una scansione a griglia grossolana e poi raffina
        /// localmente il candidato più distante da tubazioni e perimetro.
        /// Restituisce null quando non esiste una posizione completamente
        /// contenuta nel locale e priva di interferenze.
        /// </summary>
        private static Punto BaricentroZonaVuota(
            List<Punto> perimetro,
            List<Punto> spiraleAndata,
            List<Punto> rientro,
            List<Punto> curvaCollegamento,
            double larghezzaEtichetta,
            double altezzaEtichetta)
        {
            if (perimetro == null ||
                perimetro.Count < 3 ||
                larghezzaEtichetta <= 0 ||
                altezzaEtichetta <= 0)
            {
                return null;
            }

            var tubazioni = new List<List<Punto>>();
            if (spiraleAndata != null && spiraleAndata.Count > 1)
                tubazioni.Add(spiraleAndata);
            if (rientro != null && rientro.Count > 1)
                tubazioni.Add(rientro);
            if (curvaCollegamento != null &&
                curvaCollegamento.Count > 1)
            {
                tubazioni.Add(curvaCollegamento);
            }

            double minX = perimetro.Min(p => p.X);
            double maxX = perimetro.Max(p => p.X);
            double minY = perimetro.Min(p => p.Y);
            double maxY = perimetro.Max(p => p.Y);
            double estensione = Math.Max(maxX - minX, maxY - minY);
            double passoGrossolano = Math.Max(0.10, estensione / 200.0);
            const double margineTubazioni = 0.03;

            Punto migliore = null;
            double punteggioMigliore = double.NegativeInfinity;

            CercaCandidatoZonaVuota(
                perimetro,
                tubazioni,
                larghezzaEtichetta,
                altezzaEtichetta,
                margineTubazioni,
                minX,
                maxX,
                minY,
                maxY,
                passoGrossolano,
                ref migliore,
                ref punteggioMigliore);

            if (migliore == null)
                return null;

            double raggioRaffinamento = passoGrossolano;
            Punto raffinato = migliore;
            double punteggioRaffinato = punteggioMigliore;
            CercaCandidatoZonaVuota(
                perimetro,
                tubazioni,
                larghezzaEtichetta,
                altezzaEtichetta,
                margineTubazioni,
                migliore.X - raggioRaffinamento,
                migliore.X + raggioRaffinamento,
                migliore.Y - raggioRaffinamento,
                migliore.Y + raggioRaffinamento,
                0.01,
                ref raffinato,
                ref punteggioRaffinato);

            return raffinato;
        }

        // Funzione realizzata da Codex in autonomia
        private static void CercaCandidatoZonaVuota(
            List<Punto> perimetro,
            List<List<Punto>> tubazioni,
            double larghezza,
            double altezza,
            double margine,
            double minX,
            double maxX,
            double minY,
            double maxY,
            double passo,
            ref Punto migliore,
            ref double punteggioMigliore)
        {
            double mezzoL = larghezza / 2.0;
            double mezzoH = altezza / 2.0;

            for (double y = minY + mezzoH;
                 y <= maxY - mezzoH;
                 y += passo)
            {
                for (double x = minX + mezzoL;
                     x <= maxX - mezzoL;
                     x += passo)
                {
                    var candidato = new Punto(x, y);
                    if (!RettangoloContenutoNelPoligono(
                            candidato,
                            mezzoL,
                            mezzoH,
                            perimetro))
                    {
                        continue;
                    }

                    if (RettangoloIntersecaTubazioni(
                            candidato,
                            mezzoL + margine,
                            mezzoH + margine,
                            tubazioni))
                    {
                        continue;
                    }

                    double punteggio = DistanzaMinimaDaiSegmenti(
                        candidato,
                        perimetro,
                        true);
                    foreach (var tubazione in tubazioni)
                    {
                        punteggio = Math.Min(
                            punteggio,
                            DistanzaMinimaDaiSegmenti(
                                candidato,
                                tubazione,
                                false));
                    }

                    if (punteggio > punteggioMigliore)
                    {
                        migliore = candidato;
                        punteggioMigliore = punteggio;
                    }
                }
            }
        }

        // Funzione realizzata da Codex in autonomia
        private static bool RettangoloContenutoNelPoligono(
            Punto centro,
            double mezzoL,
            double mezzoH,
            List<Punto> perimetro)
        {
            var puntiControllo = new[]
            {
                new Punto(centro.X, centro.Y),
                new Punto(centro.X - mezzoL, centro.Y - mezzoH),
                new Punto(centro.X + mezzoL, centro.Y - mezzoH),
                new Punto(centro.X + mezzoL, centro.Y + mezzoH),
                new Punto(centro.X - mezzoL, centro.Y + mezzoH),
                new Punto(centro.X, centro.Y - mezzoH),
                new Punto(centro.X + mezzoL, centro.Y),
                new Punto(centro.X, centro.Y + mezzoH),
                new Punto(centro.X - mezzoL, centro.Y)
            };

            if (puntiControllo.Any(
                    p => !GeometryUtils.IsInsidePolygon(p, perimetro)))
            {
                return false;
            }

            return !RettangoloIntersecaPolilinea(
                centro,
                mezzoL,
                mezzoH,
                perimetro,
                true);
        }

        // Funzione realizzata da Codex in autonomia
        private static bool RettangoloIntersecaTubazioni(
            Punto centro,
            double mezzoL,
            double mezzoH,
            List<List<Punto>> tubazioni)
        {
            return tubazioni.Any(
                t => RettangoloIntersecaPolilinea(
                    centro,
                    mezzoL,
                    mezzoH,
                    t,
                    false));
        }

        // Funzione realizzata da Codex in autonomia
        private static bool RettangoloIntersecaPolilinea(
            Punto centro,
            double mezzoL,
            double mezzoH,
            List<Punto> punti,
            bool chiusa)
        {
            if (punti == null || punti.Count < 2)
                return false;

            int segmenti = chiusa ? punti.Count : punti.Count - 1;
            for (int i = 0; i < segmenti; i++)
            {
                Punto a = punti[i];
                Punto b = punti[(i + 1) % punti.Count];
                if (SegmentoIntersecaRettangolo(
                        a,
                        b,
                        centro.X - mezzoL,
                        centro.X + mezzoL,
                        centro.Y - mezzoH,
                        centro.Y + mezzoH))
                {
                    return true;
                }
            }

            return false;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool SegmentoIntersecaRettangolo(
            Punto a,
            Punto b,
            double minX,
            double maxX,
            double minY,
            double maxY)
        {
            if (PuntoNelRettangolo(a, minX, maxX, minY, maxY) ||
                PuntoNelRettangolo(b, minX, maxX, minY, maxY))
            {
                return true;
            }

            var bassoSinistra = new Punto(minX, minY);
            var bassoDestra = new Punto(maxX, minY);
            var altoDestra = new Punto(maxX, maxY);
            var altoSinistra = new Punto(minX, maxY);

            return SegmentiIntersecano(a, b, bassoSinistra, bassoDestra) ||
                   SegmentiIntersecano(a, b, bassoDestra, altoDestra) ||
                   SegmentiIntersecano(a, b, altoDestra, altoSinistra) ||
                   SegmentiIntersecano(a, b, altoSinistra, bassoSinistra);
        }

        // Funzione realizzata da Codex in autonomia
        private static bool PuntoNelRettangolo(
            Punto punto,
            double minX,
            double maxX,
            double minY,
            double maxY)
        {
            return punto.X >= minX &&
                   punto.X <= maxX &&
                   punto.Y >= minY &&
                   punto.Y <= maxY;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool SegmentiIntersecano(
            Punto a,
            Punto b,
            Punto c,
            Punto d)
        {
            double o1 = Orientamento(a, b, c);
            double o2 = Orientamento(a, b, d);
            double o3 = Orientamento(c, d, a);
            double o4 = Orientamento(c, d, b);
            const double epsilon = 1e-9;

            if (((o1 > epsilon && o2 < -epsilon) ||
                 (o1 < -epsilon && o2 > epsilon)) &&
                ((o3 > epsilon && o4 < -epsilon) ||
                 (o3 < -epsilon && o4 > epsilon)))
            {
                return true;
            }

            return Math.Abs(o1) <= epsilon && PuntoSulSegmento(a, b, c) ||
                   Math.Abs(o2) <= epsilon && PuntoSulSegmento(a, b, d) ||
                   Math.Abs(o3) <= epsilon && PuntoSulSegmento(c, d, a) ||
                   Math.Abs(o4) <= epsilon && PuntoSulSegmento(c, d, b);
        }

        // Funzione realizzata da Codex in autonomia
        private static double Orientamento(Punto a, Punto b, Punto c)
        {
            return (b.X - a.X) * (c.Y - a.Y) -
                   (b.Y - a.Y) * (c.X - a.X);
        }

        // Funzione realizzata da Codex in autonomia
        private static bool PuntoSulSegmento(Punto a, Punto b, Punto p)
        {
            const double epsilon = 1e-9;
            return p.X >= Math.Min(a.X, b.X) - epsilon &&
                   p.X <= Math.Max(a.X, b.X) + epsilon &&
                   p.Y >= Math.Min(a.Y, b.Y) - epsilon &&
                   p.Y <= Math.Max(a.Y, b.Y) + epsilon;
        }

        // Funzione realizzata da Codex in autonomia
        private static double DistanzaMinimaDaiSegmenti(
            Punto punto,
            List<Punto> polilinea,
            bool chiusa)
        {
            if (polilinea == null || polilinea.Count < 2)
                return double.PositiveInfinity;

            double distanzaMinima = double.PositiveInfinity;
            int segmenti = chiusa
                ? polilinea.Count
                : polilinea.Count - 1;

            for (int i = 0; i < segmenti; i++)
            {
                distanzaMinima = Math.Min(
                    distanzaMinima,
                    DistanzaPuntoSegmento(
                        punto,
                        polilinea[i],
                        polilinea[(i + 1) % polilinea.Count]));
            }

            return distanzaMinima;
        }

        // Funzione realizzata da Codex in autonomia
        private static double DistanzaPuntoSegmento(
            Punto punto,
            Punto a,
            Punto b)
        {
            double dx = b.X - a.X;
            double dy = b.Y - a.Y;
            double lunghezzaQuadrata = dx * dx + dy * dy;
            if (lunghezzaQuadrata <= 1e-12)
                return punto.DistanceTo(a);

            double t = ((punto.X - a.X) * dx +
                        (punto.Y - a.Y) * dy) /
                       lunghezzaQuadrata;
            t = Math.Max(0.0, Math.Min(1.0, t));
            var proiezione = new Punto(
                a.X + t * dx,
                a.Y + t * dy);
            return punto.DistanceTo(proiezione);
        }
        
        private static List<Punto> SpostaUltimoPuntoASinistra(List<Punto> spirale, double distanzaArco)
        {
            if (spirale.Count < 2) return spirale;
            
            var penultimo = spirale[spirale.Count - 2];
            var ultimo = spirale[spirale.Count - 1];
            
            double dx = ultimo.X - penultimo.X;
            double dy = ultimo.Y - penultimo.Y;
            double raggio = Math.Sqrt(dx * dx + dy * dy);
            
            if (raggio < 0.0001) return spirale;
            
            double angoloCorrente = Math.Atan2(dy, dx);
            double angoloRotazione = distanzaArco / raggio;
            double nuovoAngolo = angoloCorrente + angoloRotazione;
            
            var nuovoUltimo = new Punto(
                penultimo.X + raggio * Math.Cos(nuovoAngolo),
                penultimo.Y + raggio * Math.Sin(nuovoAngolo)
            );
            
            var risultato = spirale.Take(spirale.Count - 1).ToList();
            risultato.Add(nuovoUltimo);
            risultato.Add(ultimo);
            
            return risultato;
        }
        
        private static List<Punto> CreaRientro(List<Punto> andata, double distanza)
        {
            List<Punto> rientro = new List<Punto>();
                       
            for (int i = andata.Count - 24; i >= 0; i--)
            {
                var p = andata[i];
                
                double dirX = 0, dirY = 0;
                int count = 0;
                
                if (i > 0)
                {
                    dirX += andata[i].X - andata[i - 1].X;
                    dirY += andata[i].Y - andata[i - 1].Y;
                    count++;
                }
                if (i < andata.Count - 1)
                {
                    dirX += andata[i + 1].X - andata[i].X;
                    dirY += andata[i + 1].Y - andata[i].Y;
                    count++;
                }
                
                if (count > 0)
                {
                    dirX /= count;
                    dirY /= count;
                    
                    double dirLen = Math.Sqrt(dirX * dirX + dirY * dirY);
                    if (dirLen > 0.001)
                    {
                        dirX /= dirLen;
                        dirY /= dirLen;
                        
                        double normX = dirY;
                        double normY = -dirX;
                        
                        rientro.Add(new Punto(
                            p.X + normX * distanza,
                            p.Y + normY * distanza
                        ));
                    }
                    else
                    {
                        rientro.Add(p);
                    }
                }
                else
                {
                    rientro.Add(p);
                }
            }
            
            return rientro;
        }
        
        private static List<Punto> CreaCurvaCollegamento(List<Punto> andata, List<Punto> rientro)
        {
            List<Punto> curva = new List<Punto>();
            
            if (andata.Count < 2 || rientro.Count < 1) return curva;
            
            var p0 = andata[andata.Count - 1];
            var p0prev = andata[andata.Count - 2];
            var p2 = rientro[0];
            var p2next = rientro.Count > 1 ? rientro[1] : rientro[0];
            
            double dx0 = p0.X - p0prev.X;
            double dy0 = p0.Y - p0prev.Y;
            double len0 = Math.Sqrt(dx0 * dx0 + dy0 * dy0);
            if (len0 > 0.001)
            {
                dx0 /= len0;
                dy0 /= len0;
            }
            
            double dx2 = p2next.X - p2.X;
            double dy2 = p2next.Y - p2.Y;
            double len2 = Math.Sqrt(dx2 * dx2 + dy2 * dy2);
            if (len2 > 0.001)
            {
                dx2 /= len2;
                dy2 /= len2;
            }
            dx2 = -dx2;
            dy2 = -dy2;
            
            double dist = Math.Sqrt((p2.X - p0.X) * (p2.X - p0.X) + (p2.Y - p0.Y) * (p2.Y - p0.Y));
            double controlDist = dist / 2.0;
            
            var p1 = new Punto(
                (p0.X + dx0 * controlDist + p2.X + dx2 * controlDist) / 2.0,
                (p0.Y + dy0 * controlDist + p2.Y + dy2 * controlDist) / 2.0
            );
            
            int numPunti = 15;
            for (int i = 0; i <= numPunti; i++)
            {
                double t = (double)i / numPunti;
                double x = (1 - t) * (1 - t) * p0.X + 2 * (1 - t) * t * p1.X + t * t * p2.X;
                double y = (1 - t) * (1 - t) * p0.Y + 2 * (1 - t) * t * p1.Y + t * t * p2.Y;
                curva.Add(new Punto(x, y));
            }
            
            return curva;
        }
        
        private static List<Punto> AggiungiPuntoIntermedio(List<Punto> spirale)
        {
            if (spirale.Count < 3) return spirale;
            
            var terzultimo = spirale[spirale.Count - 3];
            var ultimo = spirale[spirale.Count - 1];
            
            var puntoMedio = new Punto(
                (terzultimo.X + ultimo.X) / 2.0,
                (terzultimo.Y + ultimo.Y) / 2.0
            );
            
            var risultato = spirale.Take(spirale.Count).ToList();
            risultato.Add(puntoMedio);
            
            return risultato;
        }
    }
}
