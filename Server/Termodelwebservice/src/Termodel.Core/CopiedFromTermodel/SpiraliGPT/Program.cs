// Program.cs
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using NetTopologySuite;
using NetTopologySuite.Geometries;
using NetTopologySuite.Operation.Buffer;

// Modificato da Codex per realizzare: copia indipendente del motore destinata alla sfida e alle evoluzioni GPT.
namespace SpiralHeatingGPT
{
    class Linea
    {
        public string Id { get; set; }
        public Punto P0 { get; set; }
        public Punto P1 { get; set; }
        public Punto PuntoInterno { get; set; }
        public Punto PuntoEsterno { get; set; }
    }

    // Funzione realizzata da Codex in autonomia
    class CandidatoRitorno
    {
        public List<Punto> GuidaPareteCentro { get; init; }
        public bool Antiorario { get; init; }
        public double Lunghezza { get; init; }
        public bool LatoPreferito { get; init; }
    }
    
    class Program
    {
        // Parametri di posa
        // Modificato da Codex per realizzare: PassoTubi indica la distanza
        // fisica fra due assi adiacenti, uno di mandata e uno di ritorno.
        public const double PassoTubi = 0.30;
        // Modificato da Codex per realizzare: il ritorno esterno dista mezza
        // passo dalla parete; la prima mandata è un passo più interna e gli
        // anelli dello stesso colore si ripetono ogni due passi.
        private const double DistanzaRitorno = PassoTubi / 2.0;
        private const double DistanzaMandataParete =
            DistanzaRitorno + PassoTubi;
        private const double PassoAnelliStessoTubo = PassoTubi * 2.0;
        // Modificato da Codex per realizzare: esplorare abbastanza aperture da
        // trovare anche il raccordo assiale posto dopo i due lati del varco.
        private const int NumeroVariantiTaglio = 8;
        
        // Parametri chiusura spirale
        private const double RaggioCurvatura = 0.10;
        private const double DistanzaRotazioneUltimoPunto = 0.20;

        // Modificato da Codex per realizzare: spessore tecnico minimo usato
        // per trasformare l'asse del collegamento in un bordo geometrico.
        // Modificato da Codex per realizzare: il tubo di collegamento è una
        // frontiera interna sottile, non una fascia piena larga mezzo passo.
        // Saranno gli offset della spirale a mantenere la distanza richiesta;
        // una fascia di 0,15 m per lato chiudeva artificialmente i colli da
        // 0,70 m e rendeva irraggiungibili locali ancora posabili.
        private const double MargineGeometricoCollegamento = 0.005;
        
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

#if SPIRALI_GPT_AUTOTEST
        // Funzione realizzata da Codex in autonomia
        public static int Main(string[] args)
        {
            // Modificato da Codex per realizzare: eseguire il solo motore GPT
            // come programma headless durante gli autotest. Nelle build normali
            // il simbolo non è definito e Program resta una libreria integrata.
            try
            {
                AggiornaSpirali();
                return 0;
            }
            catch (Exception ex)
            {
                Console.Error.WriteLine(
                    $"Autotest SpiraliGPT non completato: {ex}");
                return 2;
            }
        }
#endif

        public static void AggiornaSpirali()
        {
            // Modificato da Codex per realizzare: generare prima le alternative
            // del ritorno e poi quelle della mandata. Le due coperture restano
            // indipendenti e vengono accoppiate solo nelle verifiche finali.
            var candidatiRitorno = GeneraCandidatiRitorno();
            var ritorniPrecalcolati = GeneraSpirale(candidatiRitorno);
            ChiudiSpiraleFiles(ritorniPrecalcolati);
        }

        // Funzione realizzata da Codex in autonomia
        private static Dictionary<string, List<CandidatoRitorno>>
            GeneraCandidatiRitorno()
        {
            const string xmlFile = "locale.xml";
            var ritorni = new Dictionary<string, List<CandidatoRitorno>>();
            if (!File.Exists(xmlFile))
            {
                Console.WriteLine($"File {xmlFile} non trovato!");
                return ritorni;
            }

            XDocument doc = XDocument.Load(xmlFile);
            CultureInfo ci = CultureInfo.InvariantCulture;
            var linee = doc.Descendants("Linea")
                .Select(l => new Linea
                {
                    Id = l.Attribute("Id").Value,
                    P0 = new Punto(
                        double.Parse(l.Element("P0").Attribute("X").Value, ci),
                        double.Parse(l.Element("P0").Attribute("Y").Value, ci)),
                    P1 = new Punto(
                        double.Parse(l.Element("P1").Attribute("X").Value, ci),
                        double.Parse(l.Element("P1").Attribute("Y").Value, ci))
                })
                .ToList();

            foreach (XElement locale in doc.Descendants("Locale"))
            {
                string localeId = locale.Attribute("Id").Value;
                var perimetro = locale.Descendants("PerimetroInterno")
                    .Elements("Punto")
                    .Select(p => new Punto(
                        double.Parse(p.Attribute("X").Value, ci),
                        double.Parse(p.Attribute("Y").Value, ci)))
                    .ToList();

                perimetro = GeometryUtils.RoundAndSnapVertices(perimetro, 2);
                if (perimetro.Count > 1 &&
                    DistanzaPunti(perimetro[0], perimetro[perimetro.Count - 1]) <
                    Tolleranza)
                {
                    perimetro.RemoveAt(perimetro.Count - 1);
                }
                perimetro = GeometryUtils.RemoveCollinearVertices(perimetro);
                if (perimetro.Count < 3)
                    continue;

                Linea lineaIngresso = TrovaLineaIngressoPerLocale(
                    linee,
                    perimetro);
                if (lineaIngresso == null)
                {
                    Console.WriteLine(
                        $"  Ritorno: nessuna linea di ingresso in {localeId}");
                    continue;
                }

                // Modificato da Codex per realizzare: il tratto del tubo che
                // entra nel locale diventa un intaglio collegato all'esterno.
                // Gli offset del ritorno lo trattano quindi come una parete.
                List<Punto> perimetroGenerazione =
                    CreaPerimetroConMargineCollegamenti(
                        perimetro,
                        linee,
                        // Modificato da Codex per realizzare: il collegamento
                        // assegnato al locale determina l'ingresso, ma non deve
                        // scavare nel perimetro il cappuccio che genera l'ansa.
                        lineaIngresso.Id);

                Punto ingressoMandata = CalcolaIntersezioneConPerimetro(
                    lineaIngresso.P0,
                    lineaIngresso.P1,
                    perimetro);
                if (ingressoMandata == null)
                    continue;

                List<Punto> ingressiRitorno =
                    CreaIngressiRitornoDaParallelo(
                        lineaIngresso,
                        ingressoMandata,
                        perimetroGenerazione,
                        // Modificato da Codex per realizzare: qui serve la
                        // distanza fra i due tubi, non il mezzo passo che vale
                        // fra ritorno e parete.
                        PassoTubi);

                var candidati = new List<CandidatoRitorno>();
                for (int indiceIngresso = 0;
                     indiceIngresso < ingressiRitorno.Count;
                     indiceIngresso++)
                {
                    Punto ingressoRitorno = ingressiRitorno[indiceIngresso];
                    foreach (bool antiorario in new[] { true, false })
                    {
                        // Modificato da Codex per realizzare: provare più fasi
                        // di apertura degli anelli del ritorno, mantenendo
                        // invariati passo, distanza dalle pareti e copertura.
                        for (int varianteTaglio = 0;
                             varianteTaglio < NumeroVariantiTaglio;
                             varianteTaglio++)
                        {
                            var risultato =
                                SpiralGenerator.GenerateGuidaRitorno(
                                    perimetroGenerazione,
                                    ingressoRitorno,
                                    DistanzaRitorno,
                                    PassoAnelliStessoTubo,
                                    true,
                                    antiorario,
                                    varianteTaglio);
                            List<Punto> guida =
                                GeometryUtils.EliminaDuplicati(
                                    risultato.spiral);
                            double direzioneX =
                                lineaIngresso.PuntoInterno.X -
                                lineaIngresso.PuntoEsterno.X;
                            double direzioneY =
                                lineaIngresso.PuntoInterno.Y -
                                lineaIngresso.PuntoEsterno.Y;
                            double lunghezzaDirezione = Math.Sqrt(
                                direzioneX * direzioneX +
                                direzioneY * direzioneY);
                            if (lunghezzaDirezione <= Tolleranza)
                                continue;
                            double normaleX =
                                -direzioneY / lunghezzaDirezione;
                            double normaleY =
                                direzioneX / lunghezzaDirezione;
                            double lato =
                                (ingressoRitorno.X - ingressoMandata.X) *
                                    normaleX +
                                (ingressoRitorno.Y - ingressoMandata.Y) *
                                    normaleY;
                            var versoSvolta = new Punto(
                                normaleX * Math.Sign(lato),
                                normaleY * Math.Sign(lato));
                            // Modificato da Codex per realizzare: una guida del
                            // ritorno non è valida se attraversa il collegamento
                            // interno; il contatto terminale non è intersezione
                            // propria e resta quindi consentito. La prima
                            // svolta deve inoltre proseguire verso il lato del
                            // parallelo, senza uncini o inversioni.
                            if (guida.Count < 2 ||
                                !SvoltaInizialeCoerente(
                                    guida,
                                    versoSvolta) ||
                                ContaIntersezioniTubi(
                                    GeometryUtils.ArrotondaSpirale(
                                        guida,
                                        RaggioCurvatura),
                                    linee) > 0 ||
                                candidati.Any(c =>
                                PolilineeEquivalenti(
                                    c.GuidaPareteCentro,
                                    guida)))
                            {
                                continue;
                            }

                            candidati.Add(new CandidatoRitorno
                            {
                                GuidaPareteCentro = guida,
                                Antiorario = antiorario,
                                Lunghezza = LunghezzaPolilinea(guida),
                                LatoPreferito = indiceIngresso == 0
                            });
                        }
                    }
                }

                if (candidati.Count == 0)
                {
                    Console.WriteLine(
                        $"  Ritorno non generabile in {localeId}");
                    continue;
                }

                ritorni[localeId] = candidati;
                Console.WriteLine(
                    $"Ritorno generato prima della mandata: {localeId} " +
                    $"({candidati.Count} alternative)");
            }

            return ritorni;
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Punto> CreaPerimetroConMargineCollegamenti(
            List<Punto> perimetro,
            IReadOnlyList<Linea> linee,
            string idLineaIngressoDaEscludere)
        {
            List<Punto> originale = perimetro?
                .Select(p => new Punto(p.X, p.Y))
                .ToList() ?? new List<Punto>();

            if (originale.Count < 3 ||
                linee == null ||
                linee.Count == 0)
            {
                return originale;
            }

            try
            {
                var factory =
                    NtsGeometryServices.Instance.CreateGeometryFactory();
                var coordinatePerimetro = originale
                    .Select(p => new Coordinate(p.X, p.Y))
                    .ToList();
                if (!coordinatePerimetro[0].Equals2D(
                        coordinatePerimetro[coordinatePerimetro.Count - 1]))
                {
                    coordinatePerimetro.Add(
                        new Coordinate(coordinatePerimetro[0]));
                }

                Geometry areaLocale = factory.CreatePolygon(
                    coordinatePerimetro.ToArray());
                if (!areaLocale.IsValid)
                    areaLocale = areaLocale.Buffer(0);

                LineString[] assiCollegamenti = linee
                    // Modificato da Codex per realizzare: gli altri tubi
                    // restano frontiere interne, mentre il tubo proprio è un
                    // varco di accesso. Includerlo produceva un vicolo cieco
                    // con testata piatta, seguito integralmente dalla mandata.
                    .Where(l => l?.P0 != null &&
                        l.P1 != null &&
                        !string.Equals(
                            l.Id,
                            idLineaIngressoDaEscludere,
                            StringComparison.Ordinal))
                    .Select(l => factory.CreateLineString(new[]
                    {
                        new Coordinate(l.P0.X, l.P0.Y),
                        new Coordinate(l.P1.X, l.P1.Y)
                    }))
                    .ToArray();
                if (assiCollegamenti.Length == 0)
                    return originale;

                Geometry insiemeCollegamenti =
                    assiCollegamenti.Length == 1
                        ? assiCollegamenti[0]
                        : factory.CreateMultiLineString(assiCollegamenti);
                var parametriFascia = new BufferParameters(
                    4,
                    // Modificato da Codex per realizzare: conservare il
                    // corridoio largo mezzo passo sui lati, ma terminare
                    // l'intaglio sul punto interno del collegamento. La
                    // testata tonda inglobava il punto iniziale e impediva
                    // alla mandata di raggiungere il primo offset.
                    EndCapStyle.Flat,
                    JoinStyle.Round,
                    5.0);
                Geometry fasciaCollegamento = BufferOp.Buffer(
                    insiemeCollegamenti,
                    MargineGeometricoCollegamento,
                    parametriFascia);
                Geometry areaDisponibile = areaLocale.Difference(
                    fasciaCollegamento);

                Polygon componentePrincipale = null;
                for (int i = 0; i < areaDisponibile.NumGeometries; i++)
                {
                    if (!(areaDisponibile.GetGeometryN(i) is Polygon candidato))
                        continue;
                    if (componentePrincipale == null ||
                        candidato.Area > componentePrincipale.Area)
                    {
                        componentePrincipale = candidato;
                    }
                }

                if (componentePrincipale == null ||
                    componentePrincipale.IsEmpty)
                {
                    return originale;
                }

                List<Punto> risultato = componentePrincipale.ExteriorRing
                    .Coordinates
                    .Take(componentePrincipale.ExteriorRing.Coordinates.Length - 1)
                    .Select(c => new Punto(c.X, c.Y))
                    .ToList();
                risultato = GeometryUtils.RemoveCollinearVertices(
                    risultato,
                    0.000001);
                if (risultato.Count < 3)
                    return originale;

                Console.WriteLine(
                    "  Tubi di collegamento applicati come margine esterno");
                return GeometryUtils.EnsureCounterClockwise(risultato);
            }
            catch (Exception ex)
            {
                Console.WriteLine(
                    $"  Margine tubo non applicato: {ex.Message}");
                return originale;
            }
        }

        // Funzione realizzata da Codex in autonomia
        /// <summary>
        /// Libera soltanto la zona centrale provando brevi arretramenti degli
        /// ultimi vertici. Gli anelli esterni e la copertura delle pareti non
        /// vengono modificati.
        /// </summary>
        private static void OttimizzaTerminaliCoppia(
            List<Punto> mandataOriginale,
            List<Punto> ritornoPareteCentroOriginale,
            List<Punto> perimetro,
            out List<Punto> mandataOttimizzata,
            out List<Punto> ritornoPareteCentroOttimizzato,
            out int incrociMigliori,
            out bool chiusuraValidaMigliore,
            out string motivoChiusuraMigliore,
            out double lunghezzaRimossaMigliore)
        {
            mandataOttimizzata = new List<Punto>(mandataOriginale);
            ritornoPareteCentroOttimizzato =
                new List<Punto>(ritornoPareteCentroOriginale);
            incrociMigliori = int.MaxValue;
            chiusuraValidaMigliore = false;
            motivoChiusuraMigliore = "nessuna configurazione terminale";
            lunghezzaRimossaMigliore = 0.0;
            double punteggioMigliore = double.PositiveInfinity;
            double lunghezzaMandataOriginale =
                LunghezzaPolilinea(mandataOriginale);
            double lunghezzaRitornoOriginale =
                LunghezzaPolilinea(ritornoPareteCentroOriginale);
            int massimoTaglioMandata = Math.Min(
                12,
                Math.Max(0, mandataOriginale.Count - 2));
            int massimoTaglioRitorno = Math.Min(
                12,
                Math.Max(0, ritornoPareteCentroOriginale.Count - 2));

            for (int taglioMandata = 0;
                 taglioMandata <= massimoTaglioMandata;
                 taglioMandata++)
            {
                List<Punto> mandataCandidata = mandataOriginale
                    .Take(mandataOriginale.Count - taglioMandata)
                    .ToList();
                List<Punto> mandataArrotondata =
                    GeometryUtils.ArrotondaSpirale(
                        mandataCandidata,
                        RaggioCurvatura);

                for (int taglioRitorno = 0;
                     taglioRitorno <= massimoTaglioRitorno;
                     taglioRitorno++)
                {
                    List<Punto> ritornoCandidato =
                        ritornoPareteCentroOriginale
                            .Take(ritornoPareteCentroOriginale.Count -
                                taglioRitorno)
                            .ToList();
                    List<Punto> ritornoFisico =
                        new List<Punto>(ritornoCandidato);
                    ritornoFisico.Reverse();
                    double lunghezzaRimossa =
                        lunghezzaMandataOriginale -
                            LunghezzaPolilinea(mandataCandidata) +
                        lunghezzaRitornoOriginale -
                            LunghezzaPolilinea(ritornoCandidato);
                    // Modificato da Codex per realizzare: applicare il limite
                    // estetico prima delle verifiche geometriche costose. Le
                    // configurazioni che eliminerebbero interi anelli non
                    // vengono più arrotondate né sottoposte alla forcina.
                    if (lunghezzaRimossa > PassoTubi * 4.0 + Tolleranza)
                        continue;
                    List<Punto> ritornoArrotondato =
                        GeometryUtils.ArrotondaSpirale(
                            ritornoFisico,
                            RaggioCurvatura);
                    int incroci = ContaIntersezioniProprie(
                        mandataArrotondata,
                        ritornoArrotondato);
                    // Modificato da Codex per realizzare: la forcina viene
                    // provata soltanto dopo aver eliminato gli incroci fra i
                    // due percorsi, evitando ricerche geometriche inutili.
                    string motivoChiusura = "intersezioni residue";
                    bool chiusuraValida = incroci == 0 &&
                        ChiudiSpirale.VerificaChiusuraCandidata(
                            mandataCandidata,
                            ritornoCandidato,
                            perimetro,
                            RaggioCurvatura,
                            DistanzaRitorno,
                            out motivoChiusura);
                    double distanzaEstremi =
                        mandataCandidata[mandataCandidata.Count - 1]
                            .DistanceTo(ritornoFisico[0]);
                    bool circuitoCompleto =
                        chiusuraValida && incroci == 0;
                    double punteggio =
                        (circuitoCompleto ? 0.0 : 1000000000.0) +
                        incroci * 100000000.0 +
                        lunghezzaRimossa * 10000.0 +
                        distanzaEstremi;
                    if (punteggio >= punteggioMigliore)
                        continue;

                    punteggioMigliore = punteggio;
                    mandataOttimizzata = mandataCandidata;
                    ritornoPareteCentroOttimizzato = ritornoCandidato;
                    incrociMigliori = incroci;
                    chiusuraValidaMigliore = chiusuraValida;
                    motivoChiusuraMigliore = motivoChiusura;
                    lunghezzaRimossaMigliore = lunghezzaRimossa;
                }
            }
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Punto> CreaIngressiRitornoDaParallelo(
            Linea lineaIngresso,
            Punto ingressoMandata,
            List<Punto> perimetro,
            double distanza)
        {
            var risultati = new List<Punto>();
            Punto esterno = lineaIngresso.PuntoEsterno;
            Punto interno = lineaIngresso.PuntoInterno;
            double dx = interno.X - esterno.X;
            double dy = interno.Y - esterno.Y;
            double lunghezza = Math.Sqrt(dx * dx + dy * dy);
            if (lunghezza <= Tolleranza)
                return risultati;

            dx /= lunghezza;
            dy /= lunghezza;
            double normaleX = -dy;
            double normaleY = dx;
            double estensione = Math.Max(
                1.0,
                DiametroPerimetro(perimetro) * 2.0);

            // Guardando dal collettore verso il locale si prova prima il lato
            // sinistro, poi quello destro; a parità viene mantenuto il primo.
            foreach (double segno in new[] { 1.0, -1.0 })
            {
                // Modificato da Codex per realizzare: il ritorno parte dal
                // parallelo costruito sull'intersezione reale con la parete.
                // Usare l'estremo interno faceva oltrepassare il primo offset
                // e costringeva il tubo a tornare indietro con un uncino.
                var terminaleParallelo = new Punto(
                    ingressoMandata.X + normaleX * distanza * segno,
                    ingressoMandata.Y + normaleY * distanza * segno);
                if (GeometryUtils.IsInsidePolygon(
                        terminaleParallelo,
                        perimetro))
                {
                    risultati.Add(terminaleParallelo);
                    continue;
                }

                // Fallback per terminali molto vicini a spigoli o pareti.
                var inizioParallelo = new Punto(
                    terminaleParallelo.X - dx * estensione,
                    terminaleParallelo.Y - dy * estensione);
                var fineParallelo = new Punto(
                    terminaleParallelo.X + dx * estensione,
                    terminaleParallelo.Y + dy * estensione);
                Punto intersezione = TrovaIntersezionePiuVicina(
                    inizioParallelo,
                    fineParallelo,
                    terminaleParallelo,
                    perimetro);

                if (intersezione != null && !risultati.Any(
                    p => DistanzaPunti(p, intersezione) < Tolleranza))
                {
                    risultati.Add(intersezione);
                }
            }

            return risultati;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool PrimoTrattoCoerenteConIngresso(
            IReadOnlyList<Punto> percorso,
            Linea lineaIngresso)
        {
            if (percorso == null || percorso.Count < 2 ||
                lineaIngresso?.PuntoInterno == null ||
                lineaIngresso.PuntoEsterno == null)
            {
                return false;
            }

            double ingressoX =
                lineaIngresso.PuntoInterno.X - lineaIngresso.PuntoEsterno.X;
            double ingressoY =
                lineaIngresso.PuntoInterno.Y - lineaIngresso.PuntoEsterno.Y;
            double lunghezzaIngresso = Math.Sqrt(
                ingressoX * ingressoX + ingressoY * ingressoY);
            if (lunghezzaIngresso <= Tolleranza)
                return false;

            for (int i = 1; i < percorso.Count; i++)
            {
                double dx = percorso[i].X - percorso[i - 1].X;
                double dy = percorso[i].Y - percorso[i - 1].Y;
                double lunghezza = Math.Sqrt(dx * dx + dy * dy);
                if (lunghezza <= Tolleranza)
                    continue;

                // Modificato da Codex per realizzare: la mandata deve
                // proseguire dentro il locale sullo stesso asse con cui arriva
                // alla parete; un aggancio laterale ricreerebbe la diagonale.
                double allineamento =
                    (dx * ingressoX + dy * ingressoY) /
                    (lunghezza * lunghezzaIngresso);
                return allineamento >= 0.90;
            }

            return false;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool SvoltaInizialeCoerente(
            IReadOnlyList<Punto> guida,
            Punto versoSvolta)
        {
            if (guida == null || guida.Count < 3 || versoSvolta == null)
                return false;

            double lunghezzaVerso = Math.Sqrt(
                versoSvolta.X * versoSvolta.X +
                versoSvolta.Y * versoSvolta.Y);
            if (lunghezzaVerso <= Tolleranza)
                return false;

            double vx = versoSvolta.X / lunghezzaVerso;
            double vy = versoSvolta.Y / lunghezzaVerso;
            for (int i = 1; i < guida.Count; i++)
            {
                double dx = guida[i].X - guida[i - 1].X;
                double dy = guida[i].Y - guida[i - 1].Y;
                double lunghezza = Math.Sqrt(dx * dx + dy * dy);
                if (lunghezza <= Tolleranza)
                    continue;

                double componenteLaterale =
                    dx / lunghezza * vx + dy / lunghezza * vy;
                if (Math.Abs(componenteLaterale) < 0.50)
                    continue;

                return componenteLaterale > 0.0;
            }

            return false;
        }

        // Funzione realizzata da Codex in autonomia
        private static Punto TrovaIntersezionePiuVicina(
            Punto p0,
            Punto p1,
            Punto riferimento,
            List<Punto> perimetro)
        {
            Punto migliore = null;
            double distanzaMigliore = double.PositiveInfinity;
            for (int i = 0; i < perimetro.Count; i++)
            {
                Punto intersezione = CalcolaIntersezioneSegmenti(
                    p0,
                    p1,
                    perimetro[i],
                    perimetro[(i + 1) % perimetro.Count]);
                if (intersezione == null)
                    continue;

                double distanza = DistanzaPunti(intersezione, riferimento);
                if (distanza < distanzaMigliore)
                {
                    migliore = intersezione;
                    distanzaMigliore = distanza;
                }
            }
            return migliore;
        }

        // Funzione realizzata da Codex in autonomia
        private static double DiametroPerimetro(List<Punto> perimetro)
        {
            double minX = perimetro.Min(p => p.X);
            double maxX = perimetro.Max(p => p.X);
            double minY = perimetro.Min(p => p.Y);
            double maxY = perimetro.Max(p => p.Y);
            double dx = maxX - minX;
            double dy = maxY - minY;
            return Math.Sqrt(dx * dx + dy * dy);
        }

        // Funzione realizzata da Codex in autonomia
        private static double LunghezzaPolilinea(List<Punto> punti)
        {
            double totale = 0.0;
            for (int i = 0; i < punti.Count - 1; i++)
                totale += DistanzaPunti(punti[i], punti[i + 1]);
            return totale;
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
                        punti[i], punti[i + 1],
                        punti[j], punti[j + 1]))
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
                        primo[i], primo[i + 1],
                        secondo[j], secondo[j + 1]))
                    {
                        totale++;
                    }
                }
            }
            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static int ContaIntersezioniTubi(
            IReadOnlyList<Punto> percorso,
            IReadOnlyList<Linea> linee)
        {
            if (percorso == null || linee == null)
                return 0;

            int totale = 0;
            foreach (Linea linea in linee.Where(
                l => l?.P0 != null && l.P1 != null))
            {
                totale += ContaIntersezioniProprie(
                    percorso,
                    new[] { linea.P0, linea.P1 });
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
            const double epsilon = 0.00000001;
            double o1 = Orientamento(a, b, c);
            double o2 = Orientamento(a, b, d);
            double o3 = Orientamento(c, d, a);
            double o4 = Orientamento(c, d, b);
            return ((o1 > epsilon && o2 < -epsilon) ||
                    (o1 < -epsilon && o2 > epsilon)) &&
                   ((o3 > epsilon && o4 < -epsilon) ||
                    (o3 < -epsilon && o4 > epsilon));
        }

        // Funzione realizzata da Codex in autonomia
        private static double Orientamento(Punto a, Punto b, Punto c)
        {
            return (b.X - a.X) * (c.Y - a.Y) -
                   (b.Y - a.Y) * (c.X - a.X);
        }

        // Funzione realizzata da Codex in autonomia
        private static bool PolilineeEquivalenti(
            IReadOnlyList<Punto> prima,
            IReadOnlyList<Punto> seconda)
        {
            if (prima == null || seconda == null ||
                prima.Count != seconda.Count)
            {
                return false;
            }

            for (int i = 0; i < prima.Count; i++)
            {
                if (DistanzaPunti(prima[i], seconda[i]) > Tolleranza)
                    return false;
            }
            return true;
        }

        // Modificato da Codex per realizzare: scegliere congiuntamente le
        // alternative di mandata e ritorno che minimizzano gli incroci.
        static Dictionary<string, List<Punto>> GeneraSpirale(
            IReadOnlyDictionary<string, List<CandidatoRitorno>>
                candidatiRitorno)
        {
            string xmlFile = "locale.xml";
            var ritorniScelti = new Dictionary<string, List<Punto>>();
            
            if (!File.Exists(xmlFile))
            {
                Console.WriteLine($"File {xmlFile} non trovato!");
                return ritorniScelti;
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

                // Modificato da Codex per realizzare: usare lo stesso bordo
                // virtuale già applicato al ritorno anche per la mandata.
                // Il perimetro originale resta invariato per XML e disegno.
                List<Punto> perimetroGenerazione =
                    CreaPerimetroConMargineCollegamenti(
                        perimetro,
                        linee,
                        // Modificato da Codex per realizzare: il primo offset
                        // della mandata deve riferirsi alla parete del locale,
                        // non alla testata artificiale del proprio tubo.
                        lineaIngresso.Id);
                
                // Calcola punto di intersezione (nuovo PuntoInterno)
                Punto nuovoPuntoInterno = CalcolaIntersezioneConPerimetro(lineaIngresso.P0, lineaIngresso.P1, perimetro);
                
                if (nuovoPuntoInterno == null)
                {
                    Console.WriteLine($"  Errore: nessuna intersezione trovata per {localeId}");
                    continue;
                }

                // Aggiorna PuntoInterno con l'intersezione
                lineaIngresso.PuntoInterno = nuovoPuntoInterno;
                // Modificato da Codex per realizzare: anche la mandata parte
                // dalla parete reale. Il vecchio estremo interno poteva essere
                // già oltre il primo offset e generare un raccordo obliquo.
                Punto terminaleMandata = new Punto(
                    nuovoPuntoInterno.X,
                    nuovoPuntoInterno.Y);
                
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
                
                // Modificato da Codex per realizzare: il ritorno viene sempre
                // generato per primo, ma la scelta definitiva avviene dopo
                // aver provato tutte le mandata indipendenti. In questo modo
                // non si congela una guida lunga ma incompatibile con la
                // chiusura e con il percorso rosso.
                List<Punto> spiral = null;
                List<List<Punto>> offsets = null;
                double punteggioMigliore = double.PositiveInfinity;
                var alternativeRitorno = candidatiRitorno != null &&
                    candidatiRitorno.TryGetValue(
                        localeId,
                        out List<CandidatoRitorno> candidateLocale)
                        ? candidateLocale
                        : new List<CandidatoRitorno>();

                var alternativeMandata = new List<(
                    List<Punto> Percorso,
                    List<List<Punto>> Offsets,
                    bool Antiorario)>();
                foreach (bool antiorarioMandata in new[] { true, false })
                {
                    // Modificato da Codex per realizzare: anche la mandata
                    // valuta indipendentemente più fasi di apertura; soltanto
                    // dopo vengono formate e confrontate le coppie.
                    for (int varianteTaglio = 0;
                         varianteTaglio < NumeroVariantiTaglio;
                         varianteTaglio++)
                    {
                        var alternativaMandata =
                            SpiralGenerator.GenerateConPassoAnelli(
                            perimetroGenerazione,
                            terminaleMandata,
                            DistanzaMandataParete,
                            PassoAnelliStessoTubo,
                            true,
                            antiorarioMandata,
                            // Modificato da Codex per realizzare: mandata e
                            // ritorno valutano indipendentemente la copertura.
                            null,
                            varianteTaglio,
                            // Modificato da Codex per realizzare: il primo
                            // raccordo percorre il varco del proprio tubo di
                            // collegamento; l'eccezione termina al primo anello.
                            true,
                            // Modificato da Codex per realizzare: conservare
                            // esattamente la direzione del tubo entrante fino
                            // all'intersezione con il primo offset.
                            new Punto(
                                lineaIngresso.PuntoInterno.X -
                                    lineaIngresso.PuntoEsterno.X,
                                lineaIngresso.PuntoInterno.Y -
                                    lineaIngresso.PuntoEsterno.Y));
                        List<Punto> mandata =
                            GeometryUtils.EliminaDuplicati(
                                alternativaMandata.spiral);
                        bool ingressoCoerente = mandata.Count >= 2 &&
                            PrimoTrattoCoerenteConIngresso(
                                mandata,
                                lineaIngresso);
                        if (!ingressoCoerente)
                            continue;

                        List<Punto> mandataArrotondata =
                            GeometryUtils.ArrotondaSpirale(
                                mandata,
                                RaggioCurvatura);
                        int incrociTubiMandata = ContaIntersezioniTubi(
                            mandataArrotondata,
                            linee);
#if SPIRALI_GPT_AUTOTEST
                        // Modificato da Codex per realizzare: dettaglio della
                        // selezione disponibile soltanto nell'autotest.
                        string tubiIntersecati = string.Join(",", linee
                            .Where(l => ContaIntersezioniProprie(
                                mandataArrotondata,
                                new[] { l.P0, l.P1 }) > 0)
                            .Select(l => l.Id));
                        Console.WriteLine(
                            $"    Mandata candidata: {mandata.Count} punti, " +
                            $"incroci tubi={incrociTubiMandata} " +
                            $"[{tubiIntersecati}]");
#endif
                        // Modificato da Codex per realizzare: scartare qualsiasi
                        // alternativa che attraversi il tubo assunto come bordo.
                        if (incrociTubiMandata > 0 ||
                            alternativeMandata.Any(m =>
                                PolilineeEquivalenti(
                                    m.Percorso,
                                    mandata)))
                        {
                            continue;
                        }
                        alternativeMandata.Add((
                            mandata,
                            alternativaMandata.offsets,
                            antiorarioMandata));
                    }
                }

                if (alternativeMandata.Count == 0)
                {
                    Console.WriteLine(
                        $"  Nessuna spirale valida generata per {localeId}");
                    continue;
                }

                CandidatoRitorno ritornoScelto = null;
                List<Punto> ritornoFisico = null;
                int incrociScelti = 0;
                bool chiusuraSceltaValida = false;
                string motivoChiusuraScelta = "ritorno non disponibile";
                double lunghezzaRimossaScelta = 0.0;
                IEnumerable<CandidatoRitorno> ritorniDaProvare =
                    alternativeRitorno.Count > 0
                        ? alternativeRitorno
                        : new CandidatoRitorno[] { null };

                foreach (CandidatoRitorno candidatoRitorno in ritorniDaProvare)
                {
                    List<Punto> fisicoCandidato = null;
                    List<Punto> ritornoArrotondato = null;
                    int autoIntersezioniRitorno = 0;
                    if (candidatoRitorno != null)
                    {
                        fisicoCandidato = new List<Punto>(
                            candidatoRitorno.GuidaPareteCentro);
                        fisicoCandidato.Reverse();
                        ritornoArrotondato = GeometryUtils.ArrotondaSpirale(
                            fisicoCandidato,
                            RaggioCurvatura);
                        autoIntersezioniRitorno =
                            ContaAutoIntersezioniProprie(ritornoArrotondato);
                    }

                    // Modificato da Codex per realizzare: mandata e ritorno
                    // verificano indipendentemente la copertura; la selezione
                    // successiva sceglie la coppia meno interferente.
                    var mandateDaProvare = new List<(
                        List<Punto> Percorso,
                        List<List<Punto>> Offsets,
                        bool Antiorario)>(alternativeMandata);

                    foreach (var candidatoMandata in mandateDaProvare)
                    {
                        List<Punto> mandataCandidata =
                            candidatoMandata.Percorso;
                        List<Punto> ritornoGuidaCandidato =
                            candidatoRitorno?.GuidaPareteCentro;
                        int incrociRitorno = 0;
                        bool chiusuraValida = false;
                        string motivoChiusura =
                            "ritorno non disponibile";
                        double lunghezzaRimossa = 0.0;
                        if (candidatoRitorno != null)
                        {
                            OttimizzaTerminaliCoppia(
                                candidatoMandata.Percorso,
                                candidatoRitorno.GuidaPareteCentro,
                                perimetro,
                                out mandataCandidata,
                                out ritornoGuidaCandidato,
                                out incrociRitorno,
                                out chiusuraValida,
                                out motivoChiusura,
                                out lunghezzaRimossa);
                            fisicoCandidato = new List<Punto>(
                                ritornoGuidaCandidato);
                            fisicoCandidato.Reverse();
                            ritornoArrotondato =
                                GeometryUtils.ArrotondaSpirale(
                                    fisicoCandidato,
                                    RaggioCurvatura);
                        }

                        List<Punto> mandataArrotondata =
                            GeometryUtils.ArrotondaSpirale(
                                mandataCandidata,
                                RaggioCurvatura);
                        int autoIntersezioniMandata =
                            ContaAutoIntersezioniProprie(mandataArrotondata);
                        double distanzaEstremi = fisicoCandidato != null
                            ? mandataCandidata[
                                mandataCandidata.Count - 1]
                                .DistanceTo(fisicoCandidato[0])
                            : PassoTubi * 100.0;
                        double copertura =
                            LunghezzaPolilinea(mandataCandidata) +
                            (ritornoGuidaCandidato != null
                                ? LunghezzaPolilinea(
                                    ritornoGuidaCandidato)
                                : 0.0);
                        double punteggio =
                            (chiusuraValida ? 0.0 : 1000000000.0) +
                            (autoIntersezioniMandata +
                                autoIntersezioniRitorno) * 100000000.0 +
                            incrociRitorno * 10000000.0 +
                            // Modificato da Codex per realizzare: a parità di
                            // validità si conserva il parallelo sul lato
                            // sinistro guardando dal collettore verso il locale.
                            (candidatoRitorno != null &&
                                !candidatoRitorno.LatoPreferito
                                    ? 1000000.0
                                    : 0.0) +
                            distanzaEstremi * 1000.0 -
                            copertura;
                        if (punteggio >= punteggioMigliore)
                            continue;

                        punteggioMigliore = punteggio;
                        spiral = mandataCandidata;
                        offsets = candidatoMandata.Offsets;
                        ritornoScelto = candidatoRitorno == null
                            ? null
                            : new CandidatoRitorno
                            {
                                GuidaPareteCentro =
                                    ritornoGuidaCandidato,
                                Antiorario = candidatoRitorno.Antiorario,
                                Lunghezza = LunghezzaPolilinea(
                                    ritornoGuidaCandidato),
                                LatoPreferito =
                                    candidatoRitorno.LatoPreferito
                            };
                        ritornoFisico = fisicoCandidato;
                        incrociScelti = incrociRitorno;
                        chiusuraSceltaValida = chiusuraValida;
                        motivoChiusuraScelta = motivoChiusura;
                        lunghezzaRimossaScelta = lunghezzaRimossa;
                    }
                }

                if (ritornoScelto != null)
                {
                    ritorniScelti[localeId] =
                        ritornoScelto.GuidaPareteCentro;
                    Console.WriteLine(
                        $"  Coppia scelta: " +
                        $"{LunghezzaPolilinea(spiral):F2} m, " +
                        $"ritorno {ritornoScelto.Lunghezza:F2} m, " +
                        $"{incrociScelti} incroci, " +
                        $"chiusura " +
                        (chiusuraSceltaValida
                            ? "verificata"
                            : $"non verificata ({motivoChiusuraScelta})") +
                        $", arretramento {lunghezzaRimossaScelta:F2} m");
                }
                
                // Salva spirale nel locale XML
                SalvaSpiralInLocale(locale, spiral);
                
                // Aggiungi alla lista per SVG combinato
                tutteLeSpirali.Add((
                    localeId,
                    perimetro,
                    spiral,
                    terminaleMandata,
                    offsets));
                
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
            return ritorniScelti;
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
        
        static void ChiudiSpiraleFiles(
            IReadOnlyDictionary<string, List<Punto>> ritorniPrecalcolati)
        {
            string xmlFile = "locale.xml";
            
            if (!File.Exists(xmlFile))
            {
                Console.WriteLine($"File {xmlFile} non trovato!");
                return;
            }
            
            // Modificato da Codex per realizzare: consegnare alla chiusura i
            // ritorni già generati prima della mandata.
            ChiudiSpirale.Chiudi(
                xmlFile,
                RaggioCurvatura,
                DistanzaRitorno,
                DistanzaRotazioneUltimoPunto,
                Debug,
                ritorniPrecalcolati);
        }
    }
}
