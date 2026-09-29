// ChiudiSpirale.cs
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Linq;

// Modificato da Codex per realizzare: isolare la copia sperimentale Diego_Vittorio mantenendo intatto il motore Vittorio.
namespace SpiralHeatingDiegoVittorio
{
    public static class ChiudiSpirale
    {
        private const int MaxTrattiTerminaliChiusura = 3;

        // Funzione realizzata da Codex in autonomia
        private sealed class CandidatoChiusura
        {
            public List<Punto> Mandata { get; init; }
            public List<Punto> Ritorno { get; init; }
            public Punto Inizio { get; init; }
            public Punto Fine { get; init; }
            public string LivelloMandata { get; init; }
            public string TentativoRitorno { get; init; }
            public int NumeroTentativo { get; init; }
            public int TrattiRimossiMandata { get; init; }
            public int TrattiRimossiRitorno { get; init; }
            public double LunghezzaRimossa { get; init; }
            public double LunghezzaChiusura { get; init; }
            public double QualitaMandata { get; init; }
            public double QualitaRitorno { get; init; }
            public double QualitaAngolare { get; init; }
            public bool Ortogonale { get; init; }
        }

        // Funzione realizzata da Codex in autonomia
        private sealed class ConfigurazioneTerminale
        {
            public List<Punto> Punti { get; init; }
            public string Codice { get; init; }
            public int TrattiRimossi { get; init; }
            public double LunghezzaRimossa { get; init; }
        }

        private const string DrawFilletsEnvironmentVariable =
            "TERMODEL_DIEGO_VITTORIO_DRAW_FILLETS";
        private const string DrawClosureEnvironmentVariable =
            "TERMODEL_DIEGO_VITTORIO_DRAW_CLOSURE";
        private const string AutonomousReturnEnvironmentVariable =
            "TERMODEL_DIEGO_VITTORIO_AUTONOMOUS_RETURN";
        private const string ReturnSideEnvironmentVariable =
            "TERMODEL_DIEGO_VITTORIO_RETURN_SIDE";
        private const string TraceClosureEnvironmentVariable =
            "TERMODEL_DIEGO_VITTORIO_TRACE_CLOSURE";

        public static void Chiudi(
            string xmlFile,
            double raggioCurvatura,
            double distanzaPareteMandata,
            double distanzaRitorno,
            double distanzaRotazioneUltimoPunto,
            bool debug)
        {
            try
            {
                XDocument doc = XDocument.Load(xmlFile);
                CultureInfo ci = CultureInfo.InvariantCulture;
                bool drawFillets = ShouldDrawFillets();
                bool drawClosure = ShouldDrawClosure();
                bool autonomousReturn = ShouldUseAutonomousReturn();
                LatoCollegamentoRitorno returnSide = ReadReturnSide();
                Console.WriteLine(
                    drawFillets
                        ? "Raccordi SVG Diego_Vittorio: ATTIVI."
                        : $"Raccordi SVG Diego_Vittorio: DISATTIVATI; riattivare con {DrawFilletsEnvironmentVariable}=true.");
                Console.WriteLine(
                    drawClosure
                        ? "Chiusura SVG Diego_Vittorio: ATTIVA."
                        : $"Chiusura SVG Diego_Vittorio: DISATTIVATA; riattivare con {DrawClosureEnvironmentVariable}=true.");
                Console.WriteLine(
                    autonomousReturn
                        ? $"Ritorno autonomo Diego_Vittorio: ATTIVO; lato {returnSide}."
                        : $"Ritorno autonomo Diego_Vittorio: DISATTIVATO; fallback derivato attivo tramite {AutonomousReturnEnvironmentVariable}=false.");
                
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
                // Modificato da Codex per realizzare: conservare il perimetro
                // architettonico fino alla serializzazione SVG finale.
                var tutteLeSpiraliChiuse = new List<(string localeId, List<Punto> perimetro, List<Punto> spiraleArrotondata, List<Punto> rientro, List<Punto> curvaCollegamento, Punto fineRientro, string chiusuraGptSvg)>();
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

                    var perimetro = locale.Descendants("PerimetroInterno")
                        .Elements("Punto")
                        .Select(p => new Punto(
                            double.Parse(p.Attribute("X").Value, ci),
                            double.Parse(p.Attribute("Y").Value, ci)
                        ))
                        .ToList();

                    // Modificato da Codex per realizzare: il nuovo ritorno
                    // esegue per prima la generazione del collegamento e poi
                    // riusa SpiralGenerator dall'ingresso verso l'interno,
                    // passo p e mandata come condizionamento a distanza p.
                    List<Punto> rientroRettilineo = null;
                    if (autonomousReturn)
                    {
                        var risultatoRitorno = SpiralGenerator.GenerateReturn(
                            perimetro,
                            spirale,
                            distanzaPareteMandata,
                            distanzaRitorno,
                            returnSide);
                        rientroRettilineo = risultatoRitorno.spiral;

						// Modificato da Codex per realizzare: il flag di chiusura
						// riguarda soltanto la connessione centrale. Il raccordo
						// d'ingresso del ritorno è geometria fisica e resta sempre.

                        if (rientroRettilineo.Count < 2)
                        {
                            throw new InvalidDataException(
                                $"Ritorno autonomo insufficiente in {localeId}.");
                        }

                        Console.WriteLine(
                            $"  Ritorno autonomo: lato={risultatoRitorno.collegamento.Lato}; " +
                            $"verso={risultatoRitorno.collegamento.VersoRivoluzione}; " +
                            $"punti={rientroRettilineo.Count}.");
                    }

                    CandidatoChiusura chiusuraOttimizzata = null;
                    if (drawClosure && autonomousReturn)
                    {
                        // DV-TEST-002: enumerare i candidati validi mantenendo
                        // invariati i controlli geometrici; se esistono chiusure
                        // ortogonali scegliere la più corta, altrimenti conservare
                        // il primo candidato valido secondo l'ordine storico.
                        chiusuraOttimizzata = GeneraPrimaChiusuraAccettabile(
                            spirale,
                            rientroRettilineo,
                            distanzaRitorno);
                        if (chiusuraOttimizzata == null)
                        {
                            Console.WriteLine(
                                "  Chiusura rapida: nessuna configurazione diretta o proiezione ortogonale è accettabile; circuito lasciato aperto.");
                        }
                        else
                        {
                            spirale = chiusuraOttimizzata.Mandata;
                            rientroRettilineo = chiusuraOttimizzata.Ritorno;
                            Console.WriteLine(
                                "  Chiusura rapida: " +
                                $"tentativo={chiusuraOttimizzata.NumeroTentativo}; " +
                                $"sequenza={chiusuraOttimizzata.LivelloMandata}/{chiusuraOttimizzata.TentativoRitorno}; " +
                                $"tipo={(chiusuraOttimizzata.Ortogonale ? "ortogonale" : "obliqua")}; " +
                                $"lunghezza={chiusuraOttimizzata.LunghezzaChiusura.ToString("0.###", ci)} m; " +
                                $"coseni={chiusuraOttimizzata.QualitaMandata.ToString("0.###", ci)}/" +
                                $"{chiusuraOttimizzata.QualitaRitorno.ToString("0.###", ci)}; " +
                                $"tagli={chiusuraOttimizzata.TrattiRimossiMandata}/{chiusuraOttimizzata.TrattiRimossiRitorno}; " +
                                $"rimosso={chiusuraOttimizzata.LunghezzaRimossa.ToString("0.###", ci)} m.");
                        }
                    }

                    // Modificato da Codex per realizzare: sospendere con flag
                    // anche la preparazione geometrica della chiusura, così
                    // mandata e ritorno restano due polilinee indipendenti.
                    if (drawClosure && !autonomousReturn)
                    {
                        spirale = SpostaUltimoPuntoASinistra(
                            spirale,
                            distanzaRotazioneUltimoPunto);
                        spirale = AggiungiPuntoIntermedio(spirale);
                    }

                    var spiraleArrotondataCalcolo =
                        GeometryUtils.ArrotondaSpirale(
                            spirale,
                            raggioCurvatura);
                    var rientroCalcolo = autonomousReturn
                        ? GeometryUtils.ArrotondaSpirale(
                            rientroRettilineo,
                            raggioCurvatura)
                        : CreaRientro(
                            spiraleArrotondataCalcolo,
                            distanzaRitorno);
                    var spiraleArrotondata = drawFillets
                        ? spiraleArrotondataCalcolo
                        : spirale;
                    var rientro = drawFillets
                        ? rientroCalcolo
                        : autonomousReturn
                            ? rientroRettilineo
                            : CreaRientroRettilineo(
                                spirale,
                                rientroCalcolo,
                                distanzaRitorno);
                    // Modificato da Codex per realizzare: rendere opzionali
                    // collegamento finale e box numerato ChiusuraGPT.
                    var curvaCollegamento = autonomousReturn
                        ? drawClosure && chiusuraOttimizzata != null
                            ? drawFillets
                                ? CreaCurvaCollegamentoAdattiva(
                                    spirale,
                                    rientroRettilineo,
                                    raggioCurvatura)
                                : new List<Punto>
                                {
                                    spiraleArrotondata[^1],
                                    rientro[^1]
                                }
                            : new List<Punto>()
                        : !drawClosure
                            ? new List<Punto>()
                            : drawFillets
                            ? CreaCurvaCollegamento(
                                spiraleArrotondata,
                                rientro)
                            : CreaCollegamentoDritto(
                                spiraleArrotondata,
                                rientro);
                    
                    // Punto finale del rientro (per collegare la linea di ritorno del tubo)
                    Punto fineRientro = rientro.Count > 0 ? rientro[rientro.Count - 1] : null;

                    string chiusuraGptSvg = drawClosure &&
                                             curvaCollegamento.Count > 1
                        ? ChiusuraGPT(
                            perimetro,
                            spiraleArrotondata,
                            rientro,
                            curvaCollegamento,
                            numeroCircuito++)
                        : string.Empty;

                    tutteLeSpiraliChiuse.Add((localeId, perimetro, spiraleArrotondata, rientro, curvaCollegamento, fineRientro, chiusuraGptSvg));
                    
                    // Se debug, salva SVG singolo
                    if (debug)
                    {
                        string svgFileName = Path.Combine("svg_2", $"{localeId}.svg");
                        UtilityFunctions.SalvaSvgArrotondato(svgFileName, perimetro, spiraleArrotondata, rientro, curvaCollegamento);
                        Console.WriteLine($"  Salvato: {svgFileName}");
                    }
                }
                
                // Salva SVG combinato
                SalvaSvgCombinato(
                    "locale.svg",
                    tutteLeSpiraliChiuse,
                    linee,
                    drawFillets,
                    drawClosure,
                    autonomousReturn,
                    returnSide);
                Console.WriteLine($"Salvato: locale.svg");
                
                Console.WriteLine("Completato!");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"ERRORE: {ex.Message}");
            }
        }
        
        private static void SalvaSvgCombinato<T>(string filePath, 
            List<(string localeId, List<Punto> perimetro, List<Punto> spiraleArrotondata, List<Punto> rientro, List<Punto> curvaCollegamento, Punto fineRientro, string chiusuraGptSvg)> spirali,
            List<T> linee,
            bool drawFillets,
            bool drawClosure,
            bool autonomousReturn,
            LatoCollegamentoRitorno returnSide) where T : class
        {
            if (spirali.Count == 0) return;
            
            var allPoints = new List<Punto>();
            
            // Raccogli tutti i punti per calcolare bounding box
            // Modificato da Codex per realizzare: includere il contorno
            // architettonico nel riquadro di presentazione.
            foreach (var (_, perimetro, spiraleArrotondata, rientro, curvaCollegamento, fineRientro, _) in spirali)
            {
                allPoints.AddRange(perimetro);
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
            string minXSvg = SvgNumber(minX);
            string minYSvg = SvgNumber(minY);
            string widthSvg = SvgNumber(width);
            string heightSvg = SvgNumber(height);
            string flipTranslateSvg = SvgNumber(-(minY + maxY));
            string filletsSvg = drawFillets ? "enabled" : "disabled";
            string closureSvg = drawClosure ? "enabled" : "disabled";
            string autonomousReturnSvg = autonomousReturn ? "enabled" : "disabled";
            string returnSideSvg = returnSide == LatoCollegamentoRitorno.Destro
                ? "right"
                : "left";

            using (StreamWriter sw = new StreamWriter(filePath))
            {
                sw.WriteLine("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
                // Modificato da Codex per realizzare: SVG responsivo, non
                // deformato e numericamente valido anche con cultura italiana.
                sw.WriteLine($"<svg xmlns=\"http://www.w3.org/2000/svg\" width=\"100%\" height=\"100%\" viewBox=\"{minXSvg} {minYSvg} {widthSvg} {heightSvg}\" preserveAspectRatio=\"xMidYMid meet\" style=\"display:block;width:100%;height:100%;background:#ffffff\" role=\"img\" aria-labelledby=\"termodel-svg-title\" data-termodel-fittings=\"{filletsSvg}\" data-termodel-closure=\"{closureSvg}\" data-termodel-autonomous-return=\"{autonomousReturnSvg}\" data-termodel-return-side=\"{returnSideSvg}\">");
                sw.WriteLine("<title id=\"termodel-svg-title\">Esecutivo pannelli Diego_Vittorio</title>");
                sw.WriteLine($"<g transform=\"scale(1,-1) translate(0,{flipTranslateSvg})\" shape-rendering=\"geometricPrecision\">");

                // Modificato da Codex per realizzare: mostrare il contorno
                // architettonico sotto mandata, ritorno e collegamenti.
                sw.WriteLine("<g id=\"architecture\" data-termodel-layer=\"architecture\">");
                foreach (var (_, perimetro, _, _, _, _, _) in spirali)
                {
                    if (perimetro.Count < 3) continue;

                    sw.Write("<polygon class=\"architectural-contour\" points=\"");
                    foreach (var p in perimetro)
                        sw.Write($"{SvgNumber(p.X)},{SvgNumber(p.Y)} ");
                    sw.WriteLine("\" fill=\"#f8fafc\" fill-opacity=\"0.72\" stroke=\"#111827\" stroke-width=\"0.025\" stroke-linejoin=\"round\"/>");
                }
                sw.WriteLine("</g>");
                sw.WriteLine("<g id=\"radiant-system\" data-termodel-layer=\"radiant-system\">");
                
                // Disegna spirali arrotondate e chiuse
                foreach (var (localeId, _, spiraleArrotondata, rientro, curvaCollegamento, fineRientro, chiusuraGptSvg) in spirali)
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
                sw.WriteLine("</g>");
                sw.WriteLine("</svg>");
            }
        }

        // Funzione realizzata da Codex in autonomia
        private static string SvgNumber(double value) =>
            value.ToString("0.###############", CultureInfo.InvariantCulture);

        // Funzione realizzata da Codex in autonomia
        private static bool ShouldDrawFillets()
        {
            // Modificato da Codex per realizzare: raccordi adattivi nuovamente
            // attivi per default; il flag false conserva il debug rettilineo.
            return ReadBooleanFlag(
                DrawFilletsEnvironmentVariable,
                defaultValue: true);
        }

        // Funzione realizzata da Codex in autonomia
        private static bool ShouldDrawClosure()
        {
            // Modificato da Codex per realizzare: nel motore Service corrente
            // il circuito viene chiuso; false resta disponibile per il debug.
            return ReadBooleanFlag(
                DrawClosureEnvironmentVariable,
                defaultValue: true);
        }

        // Funzione realizzata da Codex in autonomia
        private static bool ShouldUseAutonomousReturn()
        {
            return ReadBooleanFlag(
                AutonomousReturnEnvironmentVariable,
                defaultValue: true);
        }

        // Funzione realizzata da Codex in autonomia
        private static LatoCollegamentoRitorno ReadReturnSide()
        {
            string value = (
                Environment.GetEnvironmentVariable(
                    ReturnSideEnvironmentVariable) ?? "sinistro")
                .Trim()
                .ToLowerInvariant();

            return value switch
            {
                "left" or "sinistro" => LatoCollegamentoRitorno.Sinistro,
                "right" or "destro" => LatoCollegamentoRitorno.Destro,
                _ => throw new InvalidDataException(
                    $"{ReturnSideEnvironmentVariable} non riconosciuto: '{value}'. Valori ammessi: left/sinistro, right/destro.")
            };
        }

        // Funzione realizzata da Codex in autonomia
        private static bool ReadBooleanFlag(
            string variableName,
            bool defaultValue = false)
        {
            string value = (
                Environment.GetEnvironmentVariable(
                    variableName) ?? string.Empty)
                .Trim();

            if (value.Length == 0)
                return defaultValue;

            return value.ToLowerInvariant() switch
            {
                "1" or "true" or "yes" or "on" => true,
                "0" or "false" or "no" or "off" => false,
                _ => throw new InvalidDataException(
                    $"{variableName} non riconosciuto: '{value}'. Valori ammessi: true/false, 1/0, yes/no, on/off.")
            };
        }

        public static (List<Punto> Mandata, List<Punto> Ritorno, bool Applicata) ApplicaChiusuraOttimizzata(
            List<Punto> mandata,
            List<Punto> ritorno,
            double distanzaRitorno)
        {
            var candidato = GeneraPrimaChiusuraAccettabile(
                mandata,
                ritorno,
                distanzaRitorno);
            if (candidato == null)
                return (mandata, ritorno, false);

            return (candidato.Mandata, candidato.Ritorno, true);
        }

        // Funzione realizzata da Codex in autonomia
        private static CandidatoChiusura GeneraPrimaChiusuraAccettabile(
            List<Punto> mandataOriginale,
            List<Punto> ritornoOriginale,
            double passo)
        {
            if (mandataOriginale == null || mandataOriginale.Count < 2 ||
                ritornoOriginale == null || ritornoOriginale.Count < 2 ||
                passo <= 0)
            {
                return null;
            }

            var livelliMandata = new (string codice, int rimossi, double? lunghezzaFinale)[]
            {
                ("M0", 3, null),
                ("M1", 2, 2.0 * passo),
                ("M2", 1, 2.0 * passo),
                ("M3", 0, 2.0 * passo),
                ("M4", 0, null)
            };
            var tentativiRitorno = new (string codice, int rimossi, double? lunghezzaFinale)[]
            {
                ("R0", 0, null),
                ("R1", 0, passo),
                ("R2", 1, null),
                ("R3", 1, passo),
                ("R4", 2, null),
                ("R5", 2, passo),
                ("R6", 3, null)
            };

            int numeroTentativo = 0;
            CandidatoChiusura primoAccettabile = null;
            var candidatiAccettabili = new List<CandidatoChiusura>();
            var configurazioniGiaProvate = new HashSet<string>(
                StringComparer.Ordinal);

            foreach (var livelloMandata in livelliMandata)
            {
                ConfigurazioneTerminale mandata =
                    CreaConfigurazioneTerminale(
                        mandataOriginale,
                        livelloMandata.codice,
                        livelloMandata.rimossi,
                        livelloMandata.lunghezzaFinale);
                if (mandata == null)
                    continue;

                foreach (var tentativoRitorno in tentativiRitorno)
                {
                    ConfigurazioneTerminale ritorno =
                        CreaConfigurazioneTerminale(
                            ritornoOriginale,
                            tentativoRitorno.codice,
                            tentativoRitorno.rimossi,
                            tentativoRitorno.lunghezzaFinale);
                    if (ritorno == null)
                        continue;

                    string chiave = CreaChiaveConfigurazione(
                        mandata.Punti,
                        ritorno.Punti);
                    if (!configurazioniGiaProvate.Add(chiave))
                        continue;

                    numeroTentativo++;
                    CandidatoChiusura candidato = ValutaChiusura(
                        mandata,
                        ritorno,
                        passo,
                        numeroTentativo);
                    if (candidato == null)
                        continue;

                    primoAccettabile ??= candidato;
                    candidatiAccettabili.Add(candidato);
                }
            }

            // DV-TEST-002 — le proiezioni ortogonali non sono più soltanto
            // un fallback successivo al fallimento delle configurazioni dirette:
            // vengono enumerate insieme agli altri candidati già validi, senza
            // rilassare alcun criterio geometrico.
            foreach (var livelloMandata in livelliMandata.Reverse())
            {
                ConfigurazioneTerminale mandata =
                    CreaConfigurazioneTerminale(
                        mandataOriginale,
                        livelloMandata.codice,
                        livelloMandata.rimossi,
                        livelloMandata.lunghezzaFinale);
                if (mandata == null)
                    continue;

                for (int rimossiRitorno = 0;
                    rimossiRitorno <= MaxTrattiTerminaliChiusura;
                    rimossiRitorno++)
                {
                    ConfigurazioneTerminale ritorno =
                        CreaConfigurazioneTerminaleProiettata(
                            ritornoOriginale,
                            $"RP{rimossiRitorno}",
                            rimossiRitorno,
                            mandata.Punti[^1]);
                    if (ritorno == null)
                        continue;

                    string chiave = CreaChiaveConfigurazione(
                        mandata.Punti,
                        ritorno.Punti);
                    if (!configurazioniGiaProvate.Add(chiave))
                        continue;

                    numeroTentativo++;
                    CandidatoChiusura candidato = ValutaChiusura(
                        mandata,
                        ritorno,
                        passo,
                        numeroTentativo);
                    if (candidato == null)
                        continue;

                    if (TraceClosureEnabled)
                    {
                        Console.WriteLine(
                            $"  DV_CLOSURE_PROJECTION_ACCEPT attempt={numeroTentativo} " +
                            $"seq={mandata.Codice}/{ritorno.Codice}.");
                    }

                    primoAccettabile ??= candidato;
                    candidatiAccettabili.Add(candidato);
                }
            }

            if (candidatiAccettabili.Count == 0)
                return null;

            // Criterio autorizzato e raffinato dopo regression DV-TEST-002:
            // conservare il primo candidato storico salvo che sia obliquo e
            // una chiusura ortogonale valida lo accorci di almeno un passo p.
            // Questo evita variazioni marginali dei casi già approvati e
            // consente la correzione circoscritta di locale_5.
            CandidatoChiusura miglioreOrtogonale = candidatiAccettabili
                .Where(c => c.Ortogonale)
                .OrderBy(c => c.LunghezzaChiusura)
                .ThenBy(c => c.LunghezzaRimossa)
                .ThenBy(c => c.NumeroTentativo)
                .FirstOrDefault();

            const double tolleranzaSelezione = 0.000001;
            bool usaOrtogonaleMigliorativa =
                primoAccettabile != null &&
                !primoAccettabile.Ortogonale &&
                miglioreOrtogonale != null &&
                primoAccettabile.LunghezzaChiusura -
                    miglioreOrtogonale.LunghezzaChiusura >=
                    passo - tolleranzaSelezione;

            CandidatoChiusura selezionato = usaOrtogonaleMigliorativa
                ? miglioreOrtogonale
                : primoAccettabile;

            if (TraceClosureEnabled)
            {
                Console.WriteLine(
                    $"  DV_CLOSURE_SELECTED attempt={selezionato.NumeroTentativo} " +
                    $"seq={selezionato.LivelloMandata}/{selezionato.TentativoRitorno} " +
                    $"type={(usaOrtogonaleMigliorativa ? "orthogonal-improvement" : "historical-first")} " +
                    $"length={selezionato.LunghezzaChiusura:R} " +
                    $"removed={selezionato.LunghezzaRimossa:R}.");
            }

            return selezionato;
        }

        private static ConfigurazioneTerminale CreaConfigurazioneTerminaleProiettata(
            List<Punto> originale,
            string codice,
            int trattiRimossi,
            Punto origineProiezione)
        {
            const double tolleranza = 0.000001;
            if (originale == null ||
                origineProiezione == null ||
                trattiRimossi < 0 ||
                trattiRimossi > MaxTrattiTerminaliChiusura ||
                originale.Count - trattiRimossi < 2)
            {
                return null;
            }

            var punti = originale
                .Take(originale.Count - trattiRimossi)
                .ToList();
            Punto a = punti[^2];
            Punto b = punti[^1];
            Punto proiezione = GeometryUtils.ProjectPointOnSegment(
                origineProiezione,
                a,
                b);
            if (proiezione == null ||
                a.DistanceTo(proiezione) <= tolleranza)
            {
                return null;
            }

            double lunghezzaRimossa =
                LunghezzaCodaRimossa(originale, trattiRimossi) +
                b.DistanceTo(proiezione);
            punti[^1] = proiezione;

            return new ConfigurazioneTerminale
            {
                Punti = punti,
                Codice = codice,
                TrattiRimossi = trattiRimossi,
                LunghezzaRimossa = lunghezzaRimossa
            };
        }

        // Funzione realizzata da Codex in autonomia
        private static ConfigurazioneTerminale CreaConfigurazioneTerminale(
            List<Punto> originale,
            string codice,
            int trattiRimossi,
            double? lunghezzaFinale)
        {
            if (trattiRimossi < 0 ||
                trattiRimossi > MaxTrattiTerminaliChiusura ||
                originale.Count - trattiRimossi < 2)
            {
                return null;
            }

            var punti = originale
                .Take(originale.Count - trattiRimossi)
                .ToList();
            double lunghezzaRimossa = LunghezzaCodaRimossa(
                originale,
                trattiRimossi);

            if (lunghezzaFinale.HasValue)
            {
                Punto inizio = punti[^2];
                Punto fine = punti[^1];
                double lunghezza = inizio.DistanceTo(fine);
                if (lunghezza <= 0.000001)
                    return null;

                double obiettivo = lunghezzaFinale.Value;
                if (lunghezza > obiettivo + 0.000001)
                {
                    double rapporto = obiettivo / lunghezza;
                    punti[^1] = new Punto(
                        inizio.X + (fine.X - inizio.X) * rapporto,
                        inizio.Y + (fine.Y - inizio.Y) * rapporto);
                    lunghezzaRimossa += lunghezza - obiettivo;
                }
            }

            return new ConfigurazioneTerminale
            {
                Punti = punti,
                Codice = codice,
                TrattiRimossi = trattiRimossi,
                LunghezzaRimossa = lunghezzaRimossa
            };
        }

        private static bool TraceClosureEnabled =>
            ReadBooleanFlag(
                TraceClosureEnvironmentVariable,
                defaultValue: false);

        // Funzione realizzata da Codex in autonomia
        private static CandidatoChiusura ValutaChiusura(
            ConfigurazioneTerminale mandata,
            ConfigurazioneTerminale ritorno,
            double passo,
            int numeroTentativo)
        {
            const double tolleranza = 0.000001;
            Punto inizio = mandata.Punti[^1];
            Punto fine = ritorno.Punti[^1];
            double lunghezza = inizio.DistanceTo(fine);
            if (lunghezza < 2.0 * passo - tolleranza)
            {
                if (TraceClosureEnabled)
                {
                    Console.WriteLine(
                        $"  DV_CLOSURE_REJECT attempt={numeroTentativo} " +
                        $"seq={mandata.Codice}/{ritorno.Codice} reason=length " +
                        $"length={lunghezza:R} required={(2.0 * passo):R} " +
                        $"start=({inizio.X:R},{inizio.Y:R}) end=({fine.X:R},{fine.Y:R}).");
                }
                return null;
            }

            Punto ingressoMandata = new Punto(
                inizio.X - mandata.Punti[^2].X,
                inizio.Y - mandata.Punti[^2].Y);
            Punto uscitaRitorno = new Punto(
                ritorno.Punti[^2].X - fine.X,
                ritorno.Punti[^2].Y - fine.Y);
            Punto direzioneChiusura = new Punto(
                fine.X - inizio.X,
                fine.Y - inizio.Y);
            double qualitaMandata = CosenoDirezioni(
                ingressoMandata,
                direzioneChiusura);
            double qualitaRitorno = CosenoDirezioni(
                direzioneChiusura,
                uscitaRitorno);
            if (qualitaMandata < -tolleranza ||
                qualitaRitorno < -tolleranza)
            {
                if (TraceClosureEnabled)
                {
                    Console.WriteLine(
                        $"  DV_CLOSURE_REJECT attempt={numeroTentativo} " +
                        $"seq={mandata.Codice}/{ritorno.Codice} reason=acute " +
                        $"cosSupply={qualitaMandata:R} cosReturn={qualitaRitorno:R} " +
                        $"start=({inizio.X:R},{inizio.Y:R}) end=({fine.X:R},{fine.Y:R}).");
                }
                return null;
            }

            // Modificato da Codex per realizzare: scartare una chiusura che
            // attraversa tubi già conservati. I soli segmenti esclusi sono i
            // due terminali adiacenti ai rispettivi innesti.
            bool intersecaMandata = IntersecaTrattiNonAdiacenti(
                inizio,
                fine,
                mandata.Punti);
            bool intersecaRitorno = IntersecaTrattiNonAdiacenti(
                inizio,
                fine,
                ritorno.Punti);
            if (intersecaMandata || intersecaRitorno)
            {
                if (TraceClosureEnabled)
                {
                    Console.WriteLine(
                        $"  DV_CLOSURE_REJECT attempt={numeroTentativo} " +
                        $"seq={mandata.Codice}/{ritorno.Codice} reason=intersection " +
                        $"supply={intersecaMandata} return={intersecaRitorno} " +
                        $"start=({inizio.X:R},{inizio.Y:R}) end=({fine.X:R},{fine.Y:R}) " +
                        $"length={lunghezza:R}.");
                }
                return null;
            }

            if (TraceClosureEnabled)
            {
                Console.WriteLine(
                    $"  DV_CLOSURE_ACCEPT attempt={numeroTentativo} " +
                    $"seq={mandata.Codice}/{ritorno.Codice} " +
                    $"start=({inizio.X:R},{inizio.Y:R}) end=({fine.X:R},{fine.Y:R}) " +
                    $"length={lunghezza:R} cosSupply={qualitaMandata:R} " +
                    $"cosReturn={qualitaRitorno:R}.");
            }

            bool ortogonale = Math.Abs(inizio.X - fine.X) <= tolleranza ||
                              Math.Abs(inizio.Y - fine.Y) <= tolleranza;
            return new CandidatoChiusura
            {
                Mandata = mandata.Punti,
                Ritorno = ritorno.Punti,
                Inizio = inizio,
                Fine = fine,
                LivelloMandata = mandata.Codice,
                TentativoRitorno = ritorno.Codice,
                NumeroTentativo = numeroTentativo,
                TrattiRimossiMandata = mandata.TrattiRimossi,
                TrattiRimossiRitorno = ritorno.TrattiRimossi,
                LunghezzaRimossa = mandata.LunghezzaRimossa +
                                    ritorno.LunghezzaRimossa,
                LunghezzaChiusura = lunghezza,
                QualitaMandata = qualitaMandata,
                QualitaRitorno = qualitaRitorno,
                QualitaAngolare = Math.Min(
                    qualitaMandata,
                    qualitaRitorno),
                Ortogonale = ortogonale
            };
        }

        // Funzione realizzata da Codex in autonomia
        private static bool IntersecaTrattiNonAdiacenti(
            Punto inizioChiusura,
            Punto fineChiusura,
            List<Punto> polilinea)
        {
            for (int i = 0; i < polilinea.Count - 2; i++)
            {
                if (SegmentiIntersecano(
                    inizioChiusura,
                    fineChiusura,
                    polilinea[i],
                    polilinea[i + 1]))
                {
                    return true;
                }
            }

            return false;
        }

        // Funzione realizzata da Codex in autonomia
        private static string CreaChiaveConfigurazione(
            List<Punto> mandata,
            List<Punto> ritorno)
        {
            Punto m0 = mandata[^2];
            Punto m1 = mandata[^1];
            Punto r0 = ritorno[^2];
            Punto r1 = ritorno[^1];
            return string.Join(
                "|",
                mandata.Count,
                m0.X.ToString("R", CultureInfo.InvariantCulture),
                m0.Y.ToString("R", CultureInfo.InvariantCulture),
                m1.X.ToString("R", CultureInfo.InvariantCulture),
                m1.Y.ToString("R", CultureInfo.InvariantCulture),
                ritorno.Count,
                r0.X.ToString("R", CultureInfo.InvariantCulture),
                r0.Y.ToString("R", CultureInfo.InvariantCulture),
                r1.X.ToString("R", CultureInfo.InvariantCulture),
                r1.Y.ToString("R", CultureInfo.InvariantCulture));
        }

        // Funzione realizzata da Codex in autonomia
        private static double LunghezzaCodaRimossa(
            List<Punto> polilinea,
            int trattiRimossi)
        {
            double risultato = 0.0;
            for (int i = 0; i < trattiRimossi; i++)
            {
                int fine = polilinea.Count - 1 - i;
                risultato += polilinea[fine - 1].DistanceTo(polilinea[fine]);
            }
            return risultato;
        }

        // Funzione realizzata da Codex in autonomia
        private static double CosenoDirezioni(Punto a, Punto b)
        {
            double lunghezzaA = Math.Sqrt(a.X * a.X + a.Y * a.Y);
            double lunghezzaB = Math.Sqrt(b.X * b.X + b.Y * b.Y);
            if (lunghezzaA <= 0.000001 || lunghezzaB <= 0.000001)
                return -1.0;
            return (a.X * b.X + a.Y * b.Y) /
                   (lunghezzaA * lunghezzaB);
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Punto> CreaCollegamentoDritto(
            List<Punto> andata,
            List<Punto> rientro)
        {
            if (andata.Count == 0 || rientro.Count == 0)
                return new List<Punto>();

            return new List<Punto>
            {
                andata[^1],
                rientro[0]
            };
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Punto> SemplificaPolilinea(
            List<Punto> punti,
            double tolleranza)
        {
            if (punti.Count <= 2)
                return punti.ToList();

            var conserva = new bool[punti.Count];
            conserva[0] = true;
            conserva[^1] = true;

            var sezioni = new Stack<(int Inizio, int Fine)>();
            sezioni.Push((0, punti.Count - 1));

            while (sezioni.Count > 0)
            {
                (int inizio, int fine) = sezioni.Pop();
                double distanzaMassima = 0.0;
                int indiceMassimo = -1;

                for (int i = inizio + 1; i < fine; i++)
                {
                    double distanza = DistanzaPuntoSegmento(
                        punti[i],
                        punti[inizio],
                        punti[fine]);
                    if (distanza <= distanzaMassima)
                        continue;

                    distanzaMassima = distanza;
                    indiceMassimo = i;
                }

                if (indiceMassimo < 0 || distanzaMassima <= tolleranza)
                    continue;

                conserva[indiceMassimo] = true;
                sezioni.Push((inizio, indiceMassimo));
                sezioni.Push((indiceMassimo, fine));
            }

            return punti
                .Where((_, indice) => conserva[indice])
                .ToList();
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Punto> CreaRientroRettilineo(
            List<Punto> andataRettilinea,
            List<Punto> rientroConRaccordi,
            double distanza)
        {
            if (andataRettilinea.Count < 2)
                return new List<Punto>();

            // Modificato da Codex per realizzare: quando il flag raccordi è
            // disattivato, il ritorno nasce dai tratti rettilinei della
            // mandata e non dai campioni delle curve arrotondate.
            var offset = CreaOffsetRettilineo(andataRettilinea, distanza);
            if (offset.Count < 2)
                return offset;

            Punto riferimento = rientroConRaccordi.Count > 0
                ? rientroConRaccordi[0]
                : offset[^1];
            int segmentoMigliore = offset.Count - 2;
            Punto proiezioneMigliore = offset[^1];
            double distanzaMigliore = double.MaxValue;

            for (int i = 0; i < offset.Count - 1; i++)
            {
                Punto proiezione = ProiettaSulSegmento(
                    riferimento,
                    offset[i],
                    offset[i + 1]);
                double dx = riferimento.X - proiezione.X;
                double dy = riferimento.Y - proiezione.Y;
                double distanzaQuadrata = dx * dx + dy * dy;
                if (distanzaQuadrata >= distanzaMigliore)
                    continue;

                distanzaMigliore = distanzaQuadrata;
                segmentoMigliore = i;
                proiezioneMigliore = proiezione;
            }

            var rientro = new List<Punto> { proiezioneMigliore };
            for (int i = segmentoMigliore; i >= 0; i--)
            {
                Punto ultimo = rientro[^1];
                Punto candidato = offset[i];
                if (Math.Abs(ultimo.X - candidato.X) > 0.000001 ||
                    Math.Abs(ultimo.Y - candidato.Y) > 0.000001)
                {
                    rientro.Add(candidato);
                }
            }

            return rientro;
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Punto> CreaOffsetRettilineo(
            List<Punto> punti,
            double distanza)
        {
            punti = GeometryUtils.EliminaDuplicati(punti);
            if (punti.Count < 2)
                return new List<Punto>();

            var segmenti = new List<(Punto Origine, Punto Direzione, Punto Normale)>();
            for (int i = 0; i < punti.Count - 1; i++)
            {
                double dx = punti[i + 1].X - punti[i].X;
                double dy = punti[i + 1].Y - punti[i].Y;
                double lunghezza = Math.Sqrt(dx * dx + dy * dy);
                if (lunghezza <= 0.000001)
                    continue;

                var direzione = new Punto(dx / lunghezza, dy / lunghezza);
                var normale = new Punto(-direzione.Y, direzione.X);
                segmenti.Add((punti[i], direzione, normale));
            }

            if (segmenti.Count == 0)
                return new List<Punto>();

            var offset = new List<Punto>
            {
                Sposta(punti[0], segmenti[0].Normale, distanza)
            };

            for (int i = 1; i < punti.Count - 1; i++)
            {
                var precedente = segmenti[Math.Min(i - 1, segmenti.Count - 1)];
                var successivo = segmenti[Math.Min(i, segmenti.Count - 1)];
                Punto originePrecedente = Sposta(
                    punti[i],
                    precedente.Normale,
                    distanza);
                Punto origineSuccessiva = Sposta(
                    punti[i],
                    successivo.Normale,
                    distanza);

                if (IntersecaRette(
                    originePrecedente,
                    precedente.Direzione,
                    origineSuccessiva,
                    successivo.Direzione,
                    out Punto intersezione))
                {
                    offset.Add(intersezione);
                }
                else
                {
                    offset.Add(originePrecedente);
                }
            }

            offset.Add(Sposta(
                punti[^1],
                segmenti[^1].Normale,
                distanza));
            return GeometryUtils.EliminaDuplicati(offset);
        }

        // Funzione realizzata da Codex in autonomia
        private static Punto Sposta(
            Punto punto,
            Punto direzione,
            double distanza) =>
            new Punto(
                punto.X + direzione.X * distanza,
                punto.Y + direzione.Y * distanza);

        // Funzione realizzata da Codex in autonomia
        private static bool IntersecaRette(
            Punto origineA,
            Punto direzioneA,
            Punto origineB,
            Punto direzioneB,
            out Punto intersezione)
        {
            double determinante =
                direzioneA.X * direzioneB.Y -
                direzioneA.Y * direzioneB.X;
            if (Math.Abs(determinante) <= 0.000001)
            {
                intersezione = origineA;
                return false;
            }

            double deltaX = origineB.X - origineA.X;
            double deltaY = origineB.Y - origineA.Y;
            double t =
                (deltaX * direzioneB.Y - deltaY * direzioneB.X) /
                determinante;
            intersezione = new Punto(
                origineA.X + t * direzioneA.X,
                origineA.Y + t * direzioneA.Y);
            return true;
        }

        // Funzione realizzata da Codex in autonomia
        private static Punto ProiettaSulSegmento(
            Punto punto,
            Punto inizio,
            Punto fine)
        {
            double dx = fine.X - inizio.X;
            double dy = fine.Y - inizio.Y;
            double lunghezzaQuadrata = dx * dx + dy * dy;
            if (lunghezzaQuadrata <= 0.000000000001)
                return inizio;

            double t =
                ((punto.X - inizio.X) * dx +
                 (punto.Y - inizio.Y) * dy) /
                lunghezzaQuadrata;
            t = Math.Max(0.0, Math.Min(1.0, t));
            return new Punto(
                inizio.X + t * dx,
                inizio.Y + t * dy);
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

            // Modificato da Codex per realizzare: escludere soltanto gli
            // ultimi due tratti della mandata anziché gli ultimi tre. Ogni
            // raccordo interno contiene 11 campioni; 13 conserva il vertice
            // precedente ai due tratti finali. Il ciclo decrescente mantiene
            // il vincolo di verso del ritorno, opposto alla mandata.
            const int campioniFinaliEsclusi = 13;
            for (int i = andata.Count - campioniFinaliEsclusi; i >= 0; i--)
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
                        
                        // Modificato da Codex per realizzare: collocare il ritorno
                        // a distanza p sul lato interno della mandata CCW. Il vecchio
                        // verso lo spostava all'esterno, verso la parete, a p/2.
                        double normX = -dirY;
                        double normY = dirX;
                        
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

        // Funzione realizzata da Codex in autonomia
        public static List<Punto> CreaCurvaCollegamentoAdattiva(
            List<Punto> mandata,
            List<Punto> ritorno,
            double raggio)
        {
            if (mandata.Count < 2 || ritorno.Count < 2)
                return new List<Punto>();

            Punto inizio = mandata[^1];
            Punto fine = ritorno[^1];
            Punto precedenteMandata = mandata[^2];
            Punto precedenteRitorno = ritorno[^2];
            double lunghezzaMandata = precedenteMandata.DistanceTo(inizio);
            double lunghezzaRitorno = fine.DistanceTo(precedenteRitorno);
            double lunghezzaChiusura = inizio.DistanceTo(fine);
            if (lunghezzaMandata <= 0.000001 ||
                lunghezzaRitorno <= 0.000001 ||
                lunghezzaChiusura <= 0.000001)
            {
                return new List<Punto> { inizio, fine };
            }

            var tangenteMandata = new Punto(
                (inizio.X - precedenteMandata.X) / lunghezzaMandata,
                (inizio.Y - precedenteMandata.Y) / lunghezzaMandata);
            var tangenteRitorno = new Punto(
                (precedenteRitorno.X - fine.X) / lunghezzaRitorno,
                (precedenteRitorno.Y - fine.Y) / lunghezzaRitorno);
            double manigliaMassima = Math.Min(
                Math.Min(raggio, lunghezzaChiusura / 3.0),
                0.45 * Math.Min(lunghezzaMandata, lunghezzaRitorno));

            foreach (double fattore in new[] { 1.0, 0.75, 0.5, 0.25 })
            {
                List<Punto> curva = CreaBezierCubicaAdattiva(
                    inizio,
                    fine,
                    tangenteMandata,
                    tangenteRitorno,
                    manigliaMassima * fattore);
                if (!CurvaIntersecaTrattiNonAdiacenti(curva, mandata) &&
                    !CurvaIntersecaTrattiNonAdiacenti(curva, ritorno))
                {
                    return curva;
                }
            }

            // Caso tipico del Return Vittorio: i due terminali centrali
            // sono paralleli e percorsi in verso opposto. Per una vera U a
            // 180 gradi la Bézier cubica richiede una maniglia maggiore del
            // limite generico distanza/3 (circa 2/3 della distanza fra gli
            // estremi per una semicirconferenza). Proviamo questa famiglia
            // dedicata mantenendo integralmente il filtro anti-intersezione.
            double prodottoTangenti =
                tangenteMandata.X * tangenteRitorno.X +
                tangenteMandata.Y * tangenteRitorno.Y;
            if (prodottoTangenti <= -0.90)
            {
                double manigliaUBase = Math.Min(
                    (2.0 / 3.0) * lunghezzaChiusura,
                    0.90 * Math.Min(lunghezzaMandata, lunghezzaRitorno));
                foreach (double fattoreU in new[] { 1.0, 0.85, 0.70, 0.55, 0.40 })
                {
                    List<Punto> curvaU = CreaBezierCubicaAdattiva(
                        inizio,
                        fine,
                        tangenteMandata,
                        tangenteRitorno,
                        manigliaUBase * fattoreU);
                    if (!CurvaIntersecaTrattiNonAdiacenti(curvaU, mandata) &&
                        !CurvaIntersecaTrattiNonAdiacenti(curvaU, ritorno))
                    {
                        return curvaU;
                    }
                }
            }

            // Non forzare mai una chiusura che interseca il circuito.
            // Nel percorso ibrido Vittorio_revisionato la geometria ricevuta
            // può essere stata arrotondata/adattata dopo la selezione LG-048:
            // l'assunzione storica che la retta sia ancora sicuramente libera
            // non è quindi valida. Se anche la retta finale interseca mandata
            // o ritorno, la soluzione viene esclusa come in Diego_Vittorio.
            var retta = new List<Punto> { inizio, fine };
            if (!CurvaIntersecaTrattiNonAdiacenti(retta, mandata) &&
                !CurvaIntersecaTrattiNonAdiacenti(retta, ritorno))
            {
                return retta;
            }

            return new List<Punto>();
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Punto> CreaBezierCubicaAdattiva(
            Punto inizio,
            Punto fine,
            Punto tangenteInizio,
            Punto tangenteFine,
            double maniglia)
        {
            if (maniglia <= 0.000001)
                return new List<Punto> { inizio, fine };

            var controllo1 = new Punto(
                inizio.X + tangenteInizio.X * maniglia,
                inizio.Y + tangenteInizio.Y * maniglia);
            var controllo2 = new Punto(
                fine.X - tangenteFine.X * maniglia,
                fine.Y - tangenteFine.Y * maniglia);
            double prodotto = Math.Max(
                -1.0,
                Math.Min(
                    1.0,
                    tangenteInizio.X * tangenteFine.X +
                    tangenteInizio.Y * tangenteFine.Y));
            double variazione = Math.Acos(prodotto);
            int segmenti = Math.Max(
                6,
                Math.Min(
                    8,
                    4 + (int)Math.Ceiling(
                        variazione / (Math.PI / 6.0))));
            var curva = new List<Punto>();
            for (int i = 0; i <= segmenti; i++)
            {
                double frazione = (double)i / segmenti;
                // Modificato da Codex per realizzare: concentrare i campioni
                // presso gli innesti, dove una Bézier lunga cambia direzione
                // più rapidamente e la tangenza deve restare visibile.
                double t = frazione <= 0.5
                    ? 0.5 * Math.Pow(2.0 * frazione, 3.0)
                    : 1.0 - 0.5 * Math.Pow(
                        2.0 * (1.0 - frazione),
                        3.0);
                double unoMenoT = 1.0 - t;
                curva.Add(new Punto(
                    unoMenoT * unoMenoT * unoMenoT * inizio.X +
                    3.0 * unoMenoT * unoMenoT * t * controllo1.X +
                    3.0 * unoMenoT * t * t * controllo2.X +
                    t * t * t * fine.X,
                    unoMenoT * unoMenoT * unoMenoT * inizio.Y +
                    3.0 * unoMenoT * unoMenoT * t * controllo1.Y +
                    3.0 * unoMenoT * t * t * controllo2.Y +
                    t * t * t * fine.Y));
            }

            return curva;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool CurvaIntersecaTrattiNonAdiacenti(
            List<Punto> curva,
            List<Punto> polilinea)
        {
            for (int i = 0; i < curva.Count - 1; i++)
            {
                if (IntersecaTrattiNonAdiacenti(
                    curva[i],
                    curva[i + 1],
                    polilinea))
                {
                    return true;
                }
            }

            return false;
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
