// ChiudiSpirale.cs
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Linq;

// Modificato da Codex per realizzare: separare il motore GPT dal sorgente originale di Vittorio.
namespace SpiralHeatingGPT
{
    public static class ChiudiSpirale
    {
        public static void Chiudi(
            string xmlFile,
            double raggioCurvatura,
            double distanzaRitorno,
            double distanzaRotazioneUltimoPunto,
            bool debug,
            IReadOnlyDictionary<string, List<Punto>> ritorniPrecalcolati)
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
                // Modificato da Codex per realizzare: raccogliere geometrie
                // per il report automatico indipendente dall'SVG.
                var diagnostica = new List<SpiralDiagnosticInput>();
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
                    // Modificato da Codex per realizzare: non ruotare
                    // artificialmente l'ultimo tratto. Nei locali piccoli la
                    // rotazione rientrava sulla spira precedente; la curva di
                    // collegamento usa già le tangenti reali dei due percorsi.
                    // Modificato da Codex per realizzare: non appendere il
                    // punto medio dopo l'estremo della mandata. Quel punto
                    // tornava indietro sulla polilinea e creava una piccola
                    // auto-intersezione prima della curva di collegamento.
                    
                    var perimetro = locale.Descendants("PerimetroInterno")
                        .Elements("Punto")
                        .Select(p => new Punto(
                            double.Parse(p.Attribute("X").Value, ci),
                            double.Parse(p.Attribute("Y").Value, ci)
                        ))
                        .ToList();
                    
                    var spiraleArrotondata = GeometryUtils.ArrotondaSpirale(spirale, raggioCurvatura);
                    // Modificato da Codex per realizzare: usare il ritorno già
                    // generato parete-centro prima della mandata e invertirlo
                    // soltanto ora nel verso fisico centro-parete.
                    var rientroBase = new List<Punto>();
                    if (ritorniPrecalcolati != null &&
                        ritorniPrecalcolati.TryGetValue(
                            localeId,
                            out List<Punto> ritornoPareteCentro))
                    {
                        rientroBase = GeometryUtils.EliminaDuplicati(
                            new List<Punto>(ritornoPareteCentro));
                        rientroBase.Reverse();
                    }
                    List<Punto> curvaCollegamento;
                    List<Punto> rientro;
                    if (rientroBase.Count >= 2)
                    {
                        // Modificato da Codex per realizzare: collegare
                        // mandata e ripresa con una inversione tangente a
                        // raggio controllato e un ramo di riavvicinamento.
                        curvaCollegamento = CreaCurvaCollegamento(
                            spiraleArrotondata,
                            rientroBase,
                            perimetro,
                            raggioCurvatura,
                            distanzaRitorno,
                            out var rientroAdattato,
                            out string motivoForcina);
                        if (curvaCollegamento.Count >= 2)
                        {
                            rientro = GeometryUtils.ArrotondaSpirale(
                                rientroAdattato,
                                raggioCurvatura);
                        }
                        else
                        {
                            // Modificato da Codex per realizzare: mantenere
                            // visibile il ritorno già generato anche quando la
                            // forcina fallisce. La diagnostica conserva la
                            // condizione di circuito non valido e scollegato.
                            rientro = GeometryUtils.ArrotondaSpirale(
                                rientroBase,
                                raggioCurvatura);
                            Console.WriteLine(
                                $"  Forcina non generabile in {localeId}: " +
                                motivoForcina +
                                "; ritorno visualizzato senza chiusura");
                        }
                    }
                    else
                    {
                        curvaCollegamento = new List<Punto>();
                        rientro = new List<Punto>();
                        Console.WriteLine(
                            $"  Ritorno non generabile in {localeId}");
                    }
                    
                    // Punto finale del rientro (per collegare la linea di ritorno del tubo)
                    Punto fineRientro = rientro.Count > 0 ? rientro[rientro.Count - 1] : null;
                    double? distanzaPareteRitornoEffettiva =
                        rientroBase.Count >= 2
                            ? DistanzaMinimaDaiSegmenti(
                                rientroBase[rientroBase.Count - 2],
                                perimetro,
                                true)
                            : null;

                    string chiusuraGptSvg = ChiusuraGPT(
                        perimetro,
                        spiraleArrotondata,
                        rientro,
                        curvaCollegamento,
                        numeroCircuito++);

                    tutteLeSpiraliChiuse.Add((localeId, spiraleArrotondata, rientro, curvaCollegamento, fineRientro, chiusuraGptSvg));
                    diagnostica.Add(new SpiralDiagnosticInput
                    {
                        LocaleId = localeId,
                        Perimetro = perimetro,
                        Mandata = spiraleArrotondata,
                        Ritorno = rientro,
                        Collegamento = curvaCollegamento,
                        RaggioMinimoRichiesto = raggioCurvatura,
                        DistanzaPareteRitornoRichiesta = distanzaRitorno,
                        DistanzaPareteRitornoEffettiva =
                            distanzaPareteRitornoEffettiva
                    });
                    
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
                SpiralDiagnostics.ScriviReport(
                    "spirali-gpt-report.json",
                    diagnostica,
                    Program.PassoTubi,
                    raggioCurvatura,
                    distanzaRitorno);
                Console.WriteLine("Salvato: spirali-gpt-report.json");
                
                Console.WriteLine("Completato!");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ERRORE: {ex.Message}");
            }
        }

        // Funzione realizzata da Codex in autonomia
        /// <summary>
        /// Prova la stessa forcina usata dalla chiusura definitiva senza
        /// modificare XML o percorsi. Serve alla selezione congiunta delle
        /// alternative mandata-ritorno.
        /// </summary>
        internal static bool VerificaChiusuraCandidata(
            List<Punto> mandata,
            List<Punto> ritornoPareteCentro,
            List<Punto> perimetro,
            double raggioCurvatura,
            double distanzaRitorno,
            out string motivoFallimento)
        {
            motivoFallimento = "geometria insufficiente";
            if (mandata == null || mandata.Count < 2 ||
                ritornoPareteCentro == null ||
                ritornoPareteCentro.Count < 2)
            {
                return false;
            }

            List<Punto> andataArrotondata =
                GeometryUtils.ArrotondaSpirale(
                    new List<Punto>(mandata),
                    raggioCurvatura);
            List<Punto> rientroFisico = GeometryUtils.EliminaDuplicati(
                new List<Punto>(ritornoPareteCentro));
            rientroFisico.Reverse();
            List<Punto> curva = CreaCurvaCollegamento(
                andataArrotondata,
                rientroFisico,
                perimetro,
                raggioCurvatura,
                distanzaRitorno,
                out _,
                out motivoFallimento);
            return curva.Count >= 2;
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
        
        // Funzione realizzata da Codex in autonomia
        /// <summary>
        /// Costruisce il ritorno dal perimetro del locale, anziché traslare
        /// punto per punto la mandata. La guida nasce sulla parete a mezzo
        /// passo dall'ingresso, percorre anelli distanti un passo intero e
        /// viene infine invertita per procedere dal centro verso la parete.
        /// Fra le due direzioni possibili lungo la parete sceglie quella con
        /// meno incroci e con la migliore continuità nella zona centrale.
        /// </summary>
        private static List<Punto> CreaRientroDaPerimetro(
            List<Punto> perimetro,
            List<Punto> andata,
            double distanzaParete,
            double passo)
        {
            if (perimetro == null || perimetro.Count < 3 ||
                andata == null || andata.Count < 2 ||
                distanzaParete <= 0 || passo <= 0)
            {
                return new List<Punto>();
            }

            List<Punto> puntiUscita = TrovaPuntiUscitaRitorno(
                perimetro,
                andata[0],
                distanzaParete);

            List<Punto> migliore = null;
            double punteggioMigliore = double.PositiveInfinity;

            foreach (Punto puntoUscita in puntiUscita)
            {
                var risultato = SpiralGenerator.GenerateGuidaRitorno(
                    perimetro,
                    puntoUscita,
                    distanzaParete,
                    passo,
                    true);
                List<Punto> guida = GeometryUtils.EliminaDuplicati(
                    risultato.spiral);
                if (guida.Count < 2)
                    continue;

                guida.Reverse();

                int incroci = ContaIntersezioniProprie(andata, guida);
                int autoIntersezioni = ContaAutoIntersezioniProprie(guida);
                double distanzaCentro =
                    andata[andata.Count - 1].DistanceTo(guida[0]);
                double penalitaTangente = PenalitaTangenteCentrale(
                    andata,
                    guida);

                double punteggio =
                    incroci * 100000.0 +
                    autoIntersezioni * 100000.0 +
                    distanzaCentro +
                    penalitaTangente * passo;

                if (punteggio < punteggioMigliore)
                {
                    punteggioMigliore = punteggio;
                    migliore = guida;
                }
            }

            return migliore ?? new List<Punto>();
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Punto> TrovaPuntiUscitaRitorno(
            List<Punto> perimetro,
            Punto ingressoMandata,
            double distanza)
        {
            var profilo = GeometryUtils.EliminaDuplicati(
                new List<Punto>(perimetro));
            if (profilo.Count > 1 &&
                profilo[0].DistanceTo(profilo[profilo.Count - 1]) <= 0.0001)
            {
                profilo.RemoveAt(profilo.Count - 1);
            }

            if (profilo.Count < 3)
                return new List<Punto>();

            var progressive = new double[profilo.Count + 1];
            double lunghezzaTotale = 0.0;
            double ascissaIngresso = 0.0;
            double distanzaMinima = double.PositiveInfinity;

            for (int i = 0; i < profilo.Count; i++)
            {
                Punto a = profilo[i];
                Punto b = profilo[(i + 1) % profilo.Count];
                double lunghezza = a.DistanceTo(b);
                progressive[i] = lunghezzaTotale;

                Punto proiezione = GeometryUtils.ProjectPointOnSegment(
                    ingressoMandata,
                    a,
                    b);
                if (proiezione != null)
                {
                    double distanzaProiezione =
                        ingressoMandata.DistanceTo(proiezione);
                    if (distanzaProiezione < distanzaMinima)
                    {
                        distanzaMinima = distanzaProiezione;
                        ascissaIngresso =
                            lunghezzaTotale + a.DistanceTo(proiezione);
                    }
                }

                lunghezzaTotale += lunghezza;
            }
            progressive[profilo.Count] = lunghezzaTotale;

            if (lunghezzaTotale <= distanza * 2.0)
                return new List<Punto>();

            Punto avanti = PuntoAllaDistanzaSulPerimetro(
                profilo,
                progressive,
                lunghezzaTotale,
                ascissaIngresso + distanza);
            Punto indietro = PuntoAllaDistanzaSulPerimetro(
                profilo,
                progressive,
                lunghezzaTotale,
                ascissaIngresso - distanza);

            var risultato = new List<Punto>();
            if (avanti != null)
                risultato.Add(avanti);
            if (indietro != null &&
                risultato.All(p => p.DistanceTo(indietro) > 0.0001))
            {
                risultato.Add(indietro);
            }
            return risultato;
        }

        // Funzione realizzata da Codex in autonomia
        private static Punto PuntoAllaDistanzaSulPerimetro(
            List<Punto> perimetro,
            double[] progressive,
            double lunghezzaTotale,
            double ascissa)
        {
            if (perimetro == null || perimetro.Count < 2 ||
                progressive == null ||
                progressive.Length != perimetro.Count + 1 ||
                lunghezzaTotale <= 0)
            {
                return null;
            }

            ascissa %= lunghezzaTotale;
            if (ascissa < 0)
                ascissa += lunghezzaTotale;

            for (int i = 0; i < perimetro.Count; i++)
            {
                if (ascissa > progressive[i + 1] + 0.0000001)
                    continue;

                Punto a = perimetro[i];
                Punto b = perimetro[(i + 1) % perimetro.Count];
                double lunghezza = a.DistanceTo(b);
                if (lunghezza <= 0.0000001)
                    continue;

                double frazione =
                    (ascissa - progressive[i]) / lunghezza;
                frazione = Math.Max(0.0, Math.Min(1.0, frazione));
                return new Punto(
                    a.X + (b.X - a.X) * frazione,
                    a.Y + (b.Y - a.Y) * frazione);
            }

            return new Punto(perimetro[0].X, perimetro[0].Y);
        }

        // Funzione realizzata da Codex in autonomia
        private static double PenalitaTangenteCentrale(
            List<Punto> andata,
            List<Punto> ritorno)
        {
            if (andata == null || andata.Count < 2 ||
                ritorno == null || ritorno.Count < 2)
            {
                return 2.0;
            }

            Punto direzioneAndata = GeometryUtils.Normalize(new Punto(
                andata[andata.Count - 1].X - andata[andata.Count - 2].X,
                andata[andata.Count - 1].Y - andata[andata.Count - 2].Y));
            Punto direzioneRitorno = GeometryUtils.Normalize(new Punto(
                ritorno[1].X - ritorno[0].X,
                ritorno[1].Y - ritorno[0].Y));

            double prodotto =
                -direzioneAndata.X * direzioneRitorno.X -
                direzioneAndata.Y * direzioneRitorno.Y;
            prodotto = Math.Max(-1.0, Math.Min(1.0, prodotto));
            return 1.0 - prodotto;
        }

        // Funzione realizzata da Codex in autonomia
        private static int ContaAutoIntersezioniProprie(
            IReadOnlyList<Punto> punti)
        {
            if (punti == null || punti.Count < 4)
                return 0;

            int totale = 0;
            for (int i = 0; i < punti.Count - 1; i++)
            {
                for (int j = i + 2; j < punti.Count - 1; j++)
                {
                    if (IntersezionePropria(
                            punti[i],
                            punti[i + 1],
                            punti[j],
                            punti[j + 1]))
                    {
                        totale++;
                    }
                }
            }
            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static int ContaIntersezioniProprie(
            IReadOnlyList<Punto> primo,
            IReadOnlyList<Punto> secondo)
        {
            if (primo == null || secondo == null)
                return 0;

            int totale = 0;
            for (int i = 0; i < primo.Count - 1; i++)
            {
                for (int j = 0; j < secondo.Count - 1; j++)
                {
                    if (IntersezionePropria(
                            primo[i],
                            primo[i + 1],
                            secondo[j],
                            secondo[j + 1]))
                    {
                        totale++;
                    }
                }
            }
            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool IntersezionePropria(
            Punto a,
            Punto b,
            Punto c,
            Punto d)
        {
            double o1 = Orientamento(a, b, c);
            double o2 = Orientamento(a, b, d);
            double o3 = Orientamento(c, d, a);
            double o4 = Orientamento(c, d, b);
            const double epsilon = 0.00000001;

            return ((o1 > epsilon && o2 < -epsilon) ||
                    (o1 < -epsilon && o2 > epsilon)) &&
                   ((o3 > epsilon && o4 < -epsilon) ||
                    (o3 < -epsilon && o4 > epsilon));
        }

        // Modificato da Codex per realizzare: pianificare la chiusura come
        // forcina centrale con ramo parallelo e aggancio al futuro ritorno.
        // Funzione realizzata da Codex in autonomia
        private static List<Punto> CreaCurvaCollegamento(
            List<Punto> andata,
            List<Punto> rientro,
            List<Punto> perimetro,
            double raggioMinimo,
            double distanzaRitorno,
            out List<Punto> rientroAdattato,
            out string motivoFallimento)
        {
            // Modificato da Codex per realizzare: rendere esplicito il vincolo
            // che impedisce la forcina durante gli autotest geometrici.
            motivoFallimento = "parametri geometrici non validi";
            rientroAdattato = rientro == null
                ? new List<Punto>()
                : new List<Punto>(rientro);

            if (andata == null || andata.Count < 2 ||
                rientro == null || rientro.Count < 2 ||
                perimetro == null || perimetro.Count < 3 ||
                raggioMinimo <= 0 || distanzaRitorno <= 0)
            {
                return new List<Punto>();
            }

            var p0 = andata[andata.Count - 1];
            Punto p0Originale = p0;
            var p0prev = andata[andata.Count - 2];
            double dx0 = p0.X - p0prev.X;
            double dy0 = p0.Y - p0prev.Y;
            double len0 = Math.Sqrt(dx0 * dx0 + dy0 * dy0);
            if (len0 <= 0.001)
                return new List<Punto>();

            dx0 /= len0;
            dy0 /= len0;

            // Modificato da Codex per realizzare: la forcina deve sostituire
            // la parte terminale eccedente della mandata, non aggiungere un
            // ramo parallelo dopo il semicerchio. Si arretra quindi l'estremo
            // rosso fino alla sezione ortogonale dell'inizio del ritorno blu.
            double proiezioneRitorno =
                (rientro[0].X - p0.X) * dx0 +
                (rientro[0].Y - p0.Y) * dy0;
            double arretramentoRichiesto = -proiezioneRitorno;
            double trattoResiduoMinimo = Math.Max(0.02, raggioMinimo);
            if (arretramentoRichiesto > 0.001 &&
                arretramentoRichiesto < len0 - trattoResiduoMinimo)
            {
                p0 = new Punto(
                    p0.X - dx0 * arretramentoRichiesto,
                    p0.Y - dy0 * arretramentoRichiesto);
                andata[andata.Count - 1] = p0;
                dx0 = p0.X - p0prev.X;
                dy0 = p0.Y - p0prev.Y;
                len0 = Math.Sqrt(dx0 * dx0 + dy0 * dy0);
                dx0 /= len0;
                dy0 /= len0;
            }

            double normalePreferitaX = dy0;
            double normalePreferitaY = -dx0;
            double versoRientroX = rientro[0].X - p0.X;
            double versoRientroY = rientro[0].Y - p0.Y;
            if (normalePreferitaX * versoRientroX +
                normalePreferitaY * versoRientroY < 0)
            {
                normalePreferitaX = -normalePreferitaX;
                normalePreferitaY = -normalePreferitaY;
            }

            // Modificato da Codex per realizzare: cercare la forcina col
            // raggio più ampio disponibile. Con mezzo passo 0,15 m si prova
            // prima R=0,15 m e si scende a passi di 1 cm fino al minimo.
            double raggioMassimo = Math.Max(
                raggioMinimo,
                distanzaRitorno);
            var motiviFallimento = new HashSet<string>();
            for (double raggio = raggioMassimo;
                 raggio >= raggioMinimo - 0.0001;
                 raggio -= 0.01)
            {
                foreach (double segno in new[] { 1.0, -1.0 })
                {
                    if (ProvaCreaForcina(
                            andata,
                            rientro,
                            perimetro,
                            p0,
                            dx0,
                            dy0,
                            normalePreferitaX * segno,
                            normalePreferitaY * segno,
                            raggio,
                            raggioMinimo,
                            distanzaRitorno,
                            out List<Punto> curva,
                            out List<Punto> rientroCandidato,
                            out string motivoCandidato))
                    {
                        rientroAdattato = rientroCandidato;
                        motivoFallimento = string.Empty;
                        return curva;
                    }

                    if (!string.IsNullOrWhiteSpace(motivoCandidato))
                        motiviFallimento.Add(motivoCandidato);
                }
            }

            motivoFallimento = motiviFallimento.Count == 0
                ? "nessuna configurazione valida"
                : string.Join(", ", motiviFallimento);
            // Modificato da Codex per realizzare: se nessuna forcina è valida,
            // ripristinare la mandata ricevuta senza lasciare un arretramento.
            andata[andata.Count - 1] = p0Originale;
            return new List<Punto>();
        }

        // Funzione realizzata da Codex in autonomia
        private static bool ProvaCreaForcina(
            List<Punto> andata,
            List<Punto> rientro,
            List<Punto> perimetro,
            Punto fineMandata,
            double direzioneX,
            double direzioneY,
            double normaleX,
            double normaleY,
            double raggio,
            double raggioMinimoRichiesto,
            double distanzaRitorno,
            out List<Punto> curva,
            out List<Punto> rientroAdattato,
            out string motivoFallimento)
        {
            motivoFallimento = string.Empty;
            curva = new List<Punto>();
            rientroAdattato = new List<Punto>(rientro);

            var centro = new Punto(
                fineMandata.X + normaleX * raggio,
                fineMandata.Y + normaleY * raggio);

            // Modificato da Codex per realizzare: otto segmenti mantengono
            // l'errore grafico sotto 3 mm anche col raggio massimo di 15 cm.
            const int campioniSemicerchio = 8;
            for (int i = 0; i <= campioniSemicerchio; i++)
            {
                double t = (double)i / campioniSemicerchio;
                double angolo = Math.PI * t;
                curva.Add(new Punto(
                    centro.X + raggio *
                        (-normaleX * Math.Cos(angolo) +
                         direzioneX * Math.Sin(angolo)),
                    centro.Y + raggio *
                        (-normaleY * Math.Cos(angolo) +
                         direzioneY * Math.Sin(angolo))));
            }

            Punto fineInversione = curva[curva.Count - 1];
            double direzioneRamoX = -direzioneX;
            double direzioneRamoY = -direzioneY;
            // Modificato da Codex per realizzare: il ramo parallelo cresce
            // soltanto quanto serve. Se la guida del ritorno è già vicina
            // alla forcina, non si impone un arretramento artificiale.
            const double lunghezzaMinimaRamo = 0.0;
            double lunghezzaMassimaRamo = Math.Max(
                lunghezzaMinimaRamo,
                Program.PassoTubi * 8.0);

            if (!TrovaAggancioRitorno(
                rientro,
                fineInversione,
                direzioneRamoX,
                direzioneRamoY,
                lunghezzaMinimaRamo,
                lunghezzaMassimaRamo,
                distanzaRitorno,
                out Punto fineRamo,
                out rientroAdattato))
            {
                motivoFallimento = "nessun aggancio alla guida di ritorno";
                return false;
            }

            if (fineInversione.DistanceTo(fineRamo) > 0.001)
                curva.Add(fineRamo);

            Punto inizioTransizione = curva[curva.Count - 1];
            var fineTransizione = rientroAdattato[0];
            var prossimoRientro = rientroAdattato[1];
            double dirFineX = prossimoRientro.X - fineTransizione.X;
            double dirFineY = prossimoRientro.Y - fineTransizione.Y;
            double lenFine = Math.Sqrt(
                dirFineX * dirFineX + dirFineY * dirFineY);
            if (lenFine <= 0.001)
            {
                motivoFallimento = "tangente del ritorno non definita";
                return false;
            }

            dirFineX /= lenFine;
            dirFineY /= lenFine;
            double corda = inizioTransizione.DistanceTo(fineTransizione);
            // Modificato da Codex per realizzare: quando il ramo della forcina
            // termina già sul ritorno, la Bézier avrebbe estremi coincidenti e
            // produrrebbe il piccolo ricciolo privo di funzione geometrica.
            if (corda <= 0.001)
            {
                if (!CurvaForcinaValida(
                        curva,
                        andata,
                        rientroAdattato,
                        perimetro,
                        raggioMinimoRichiesto,
                        out motivoFallimento))
                {
                    curva.Clear();
                    rientroAdattato = new List<Punto>(rientro);
                    return false;
                }

                return true;
            }

            double controllo = Math.Max(raggio, corda / 3.0);
            var controllo1 = new Punto(
                inizioTransizione.X + direzioneRamoX * controllo,
                inizioTransizione.Y + direzioneRamoY * controllo);
            var controllo2 = new Punto(
                fineTransizione.X - dirFineX * controllo,
                fineTransizione.Y - dirFineY * controllo);

            // Modificato da Codex per realizzare: usare lo stesso compromesso
            // grafico nella transizione, dimezzando i vertici della chiusura.
            const int campioniTransizione = 8;
            for (int i = 1; i <= campioniTransizione; i++)
            {
                double t = (double)i / campioniTransizione;
                double mt = 1.0 - t;
                double x = mt * mt * mt * inizioTransizione.X +
                    3.0 * mt * mt * t * controllo1.X +
                    3.0 * mt * t * t * controllo2.X +
                    t * t * t * fineTransizione.X;
                double y = mt * mt * mt * inizioTransizione.Y +
                    3.0 * mt * mt * t * controllo1.Y +
                    3.0 * mt * t * t * controllo2.Y +
                    t * t * t * fineTransizione.Y;
                curva.Add(new Punto(x, y));
            }

            if (!CurvaForcinaValida(
                    curva,
                    andata,
                    rientroAdattato,
                    perimetro,
                    raggioMinimoRichiesto,
                    out motivoFallimento))
            {
                curva.Clear();
                rientroAdattato = new List<Punto>(rientro);
                return false;
            }

            return true;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool TrovaAggancioRitorno(
            List<Punto> rientro,
            Punto origineRamo,
            double direzioneRamoX,
            double direzioneRamoY,
            double lunghezzaMinima,
            double lunghezzaMassima,
            double distanzaRitorno,
            out Punto fineRamo,
            out List<Punto> rientroAdattato)
        {
            fineRamo = null;
            rientroAdattato = new List<Punto>();
            if (rientro == null || rientro.Count < 2)
                return false;

            double punteggioMigliore = double.PositiveInfinity;
            double accumulata = 0.0;
            for (int i = 0; i < rientro.Count - 1; i++)
            {
                Punto a = rientro[i];
                Punto b = rientro[i + 1];
                double lunghezza = a.DistanceTo(b);
                if (lunghezza <= 0.000001)
                    continue;

                double dirRientroX = (b.X - a.X) / lunghezza;
                double dirRientroY = (b.Y - a.Y) / lunghezza;
                const int campioniSegmento = 4;
                for (int j = 0; j <= campioniSegmento; j++)
                {
                    double frazione = (double)j / campioniSegmento;
                    var puntoRientro = new Punto(
                        a.X + (b.X - a.X) * frazione,
                        a.Y + (b.Y - a.Y) * frazione);
                    double vx = puntoRientro.X - origineRamo.X;
                    double vy = puntoRientro.Y - origineRamo.Y;
                    double sviluppo =
                        vx * direzioneRamoX + vy * direzioneRamoY;
                    if (sviluppo < lunghezzaMinima ||
                        sviluppo > lunghezzaMassima)
                    {
                        continue;
                    }

                    var puntoRamo = new Punto(
                        origineRamo.X + direzioneRamoX * sviluppo,
                        origineRamo.Y + direzioneRamoY * sviluppo);
                    double distanza = puntoRamo.DistanceTo(puntoRientro);
                    if (distanza > distanzaRitorno * 2.0)
                        continue;

                    double prodottoTangenti =
                        direzioneRamoX * dirRientroX +
                        direzioneRamoY * dirRientroY;
                    prodottoTangenti = Math.Max(
                        -1.0,
                        Math.Min(1.0, prodottoTangenti));
                    double penalitaTangente = 1.0 - prodottoTangenti;
                    double punteggio =
                        distanza +
                        penalitaTangente * distanzaRitorno +
                        (accumulata + lunghezza * frazione) * 0.001;

                    if (punteggio >= punteggioMigliore)
                        continue;

                    punteggioMigliore = punteggio;
                    fineRamo = puntoRamo;
                    rientroAdattato = new List<Punto> { puntoRientro };
                    rientroAdattato.AddRange(rientro.Skip(i + 1));
                }

                accumulata += lunghezza;
            }

            return fineRamo != null && rientroAdattato.Count >= 2;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool CurvaForcinaValida(
            List<Punto> curva,
            List<Punto> andata,
            List<Punto> rientro,
            List<Punto> perimetro,
            double raggioMinimo,
            out string motivoFallimento)
        {
            motivoFallimento = string.Empty;
            if (curva == null || curva.Count < 3)
            {
                motivoFallimento = "curva incompleta";
                return false;
            }

            if (curva.Skip(1).Any(
                    p => !GeometryUtils.IsInsidePolygon(p, perimetro)))
            {
                motivoFallimento = "curva fuori dal locale";
                return false;
            }

            if (ContaAutoIntersezioniProprie(curva) > 0)
            {
                motivoFallimento = "auto-intersezione della curva";
                return false;
            }

            if (ContaIntersezioniProprie(curva, andata) > 0)
            {
                motivoFallimento = "intersezione con la mandata";
                return false;
            }

            if (ContaIntersezioniProprie(curva, rientro) > 0)
            {
                motivoFallimento = "intersezione con il ritorno";
                return false;
            }

            double? raggioEffettivo = CalcolaRaggioMinimoLocale(curva);
            if (raggioEffettivo.HasValue &&
                raggioEffettivo.Value + 0.001 < raggioMinimo)
            {
                motivoFallimento = "raggio locale inferiore al minimo";
                return false;
            }

            return true;
        }

        // Funzione realizzata da Codex in autonomia
        private static double? CalcolaRaggioMinimoLocale(
            IReadOnlyList<Punto> punti)
        {
            if (punti == null || punti.Count < 3)
                return null;

            double minimo = double.PositiveInfinity;
            for (int i = 1; i < punti.Count - 1; i++)
            {
                Punto a = punti[i - 1];
                Punto b = punti[i];
                Punto c = punti[i + 1];
                double ab = a.DistanceTo(b);
                double bc = b.DistanceTo(c);
                double ac = a.DistanceTo(c);
                double doppiaArea = Math.Abs(Orientamento(a, b, c));
                if (ab <= 0.000001 || bc <= 0.000001 ||
                    ac <= 0.000001 || doppiaArea <= 0.00000001)
                {
                    continue;
                }

                double raggio = ab * bc * ac / (2.0 * doppiaArea);
                minimo = Math.Min(minimo, raggio);
            }

            return double.IsPositiveInfinity(minimo) ? null : minimo;
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
