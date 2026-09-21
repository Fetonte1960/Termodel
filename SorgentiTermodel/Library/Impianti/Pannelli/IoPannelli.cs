using NetTopologySuite.Geometries;
using System;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Linq;
using Termodel.utilities;
using netDxf;                      // tipo DxfDocument
using SpiralHeating; //vittorio
using HelixViewport3D = HelixToolkit.Wpf.HelixViewport3D;
using LinesVisual3D = HelixToolkit.Wpf.LinesVisual3D;
using Point3D = System.Windows.Media.Media3D.Point3D;
using Colors = System.Windows.Media.Colors;

using System.Collections.Generic;
// Modifiche nei files di Vittorio
//linea 28 private const double DistanzaRitorno = PassoTubi / 2.0;
//
namespace Termodel.Impianti.Pannelli
{
    internal enum MotoreSpirali
    {
        Vittorio,
        GPT
    }

    internal static class IoPannelli
    {
        private const string Versione = "1.0";

        private static XDocument _doc;

        // Modificato da Codex per realizzare: rendere SpiraliGPT il motore predefinito,
        // conservando il motore originale di Vittorio selezionabile per i confronti.
        public static MotoreSpirali MotoreCorrente { get; private set; } = MotoreSpirali.GPT;
        public static string NomeMotoreCorrente => MotoreCorrente.ToString();

        // Funzione realizzata da Codex in autonomia
        public static void SelezionaMotore(string nomeMotore)
        {
            if (!Enum.TryParse(nomeMotore, ignoreCase: true, out MotoreSpirali motore))
                throw new ArgumentException($"Motore spirali non riconosciuto: {nomeMotore}", nameof(nomeMotore));

            MotoreCorrente = motore;
            TermodelLog.LogOperation($"Motore spirali selezionato: {NomeMotoreCorrente}");
        }

        public static void InitClass()
        {
            _doc = new XDocument(
                new XDeclaration("1.0", "utf-8", "yes"),
                new XElement("Locali",
                    new XAttribute("Versione", Versione))
            );
        }

        /// <summary>
        /// Calcola il poligono parallelizzato e lo scrive nell'XML in memoria sotto:
        /// <Locali><Locale Id="..."><PerimetroParallelo>...</PerimetroParallelo></Locale></Locali>
        /// </summary>
        public static void AddParalleloLocale(
            Polygon p,
            string idLocale,
            string nomePiano = null,
            bool versoEsterno = true)
        {
            if (_doc == null)
                throw new InvalidOperationException("IoPannelli.InitClass() non è stato chiamato.");

            if (string.IsNullOrWhiteSpace(idLocale)) return;
            if (p == null || p.IsEmpty) return;

            // 1) Calcolo parallelo (safe)
            Polygon parallelo = CalcolaParalleloSafe(p, versoEsterno);
            if (parallelo == null || parallelo.IsEmpty) return;

            // 2) Scrittura XML
            var root = _doc.Root;
            if (root == null) return;

            var xLocale = new XElement("Locale",
                new XAttribute("Id", idLocale));

            if (!string.IsNullOrWhiteSpace(nomePiano))
                xLocale.SetAttributeValue("Piano", nomePiano);

            var xPerimetro = new XElement("PerimetroInterno");

            var coords = parallelo.ExteriorRing.Coordinates;
            int n = coords.Length;
            int last = (n > 1 && coords[0].Equals2D(coords[n - 1])) ? n - 1 : n;

            for (int i = 0; i < last; i++)
            {
                xPerimetro.Add(new XElement("Punto",
                    new XAttribute("X", coords[i].X.ToString(CultureInfo.InvariantCulture)),
                    new XAttribute("Y", coords[i].Y.ToString(CultureInfo.InvariantCulture))));
            }

            // chiusura esplicita
            xPerimetro.Add(new XElement("Punto",
                new XAttribute("X", coords[0].X.ToString(CultureInfo.InvariantCulture)),
                new XAttribute("Y", coords[0].Y.ToString(CultureInfo.InvariantCulture))));

            xLocale.Add(xPerimetro);
            root.Add(xLocale);
        }

        private static Polygon CalcolaParalleloSafe(Polygon p, bool versoEsterno)
        {
            Geometry g;
            try
            {
                g = GeometriaHelper.ParalleloPoligono(p, versoEsterno);
            }
            catch
            {
                return null;
            }

            if (g == null || g.IsEmpty) return null;

            if (g is Polygon pg)
                return new Polygon((LinearRing)pg.ExteriorRing);

            Polygon best = null;
            for (int i = 0; i < g.NumGeometries; i++)
            {
                if (g.GetGeometryN(i) is Polygon pi)
                    if (best == null || pi.Area > best.Area) best = pi;
            }

            return best == null ? null : new Polygon((LinearRing)best.ExteriorRing);
        }
        public static void EsportaTubiPannelli(string nomePiano, double quotaPiano, IList<LineString> lineeTubi)
        {
            if (_doc == null)
                throw new InvalidOperationException("IoPannelli.InitClass() non è stato chiamato.");

            if (string.IsNullOrWhiteSpace(nomePiano)) return;
            if (lineeTubi == null || lineeTubi.Count == 0) return;

            var root = _doc.Root;
            if (root == null) return;

            // cerca (o crea) il nodo piano
            var xPiano = root.Elements("Piano")
                .FirstOrDefault(x => string.Equals((string)x.Attribute("Nome"), nomePiano, StringComparison.OrdinalIgnoreCase));

            if (xPiano == null)
            {
                xPiano = new XElement("Piano",
                    new XAttribute("Nome", nomePiano),
                    new XAttribute("Quota", quotaPiano.ToString(CultureInfo.InvariantCulture)));
                root.Add(xPiano);
            }
            else
            {
                // aggiorna quota se cambia
                xPiano.SetAttributeValue("Quota", quotaPiano.ToString(CultureInfo.InvariantCulture));
            }

            // ricrea il nodo Tubi (minimale e pulito)
            xPiano.Element("Tubi")?.Remove();
            var xTubi = new XElement("Tubi");
            xPiano.Add(xTubi);

            int id = 1;
            foreach (var ls in lineeTubi)
            {
                if (ls == null || ls.IsEmpty) continue;
                if (ls.NumPoints < 2) continue;

                var p0 = ls.GetCoordinateN(0);
                var p1 = ls.GetCoordinateN(ls.NumPoints - 1);

                var xLinea = new XElement("Linea",
                    new XAttribute("Id", $"T{id}"));

                xLinea.Add(new XElement("P0",
                    new XAttribute("X", p0.X.ToString(CultureInfo.InvariantCulture)),
                    new XAttribute("Y", p0.Y.ToString(CultureInfo.InvariantCulture)),
                    new XAttribute("Z", quotaPiano.ToString(CultureInfo.InvariantCulture))));

                xLinea.Add(new XElement("P1",
                    new XAttribute("X", p1.X.ToString(CultureInfo.InvariantCulture)),
                    new XAttribute("Y", p1.Y.ToString(CultureInfo.InvariantCulture)),
                    new XAttribute("Z", quotaPiano.ToString(CultureInfo.InvariantCulture))));

                xTubi.Add(xLinea);
                id++;
            }
        }
  
            /// <summary>
            /// Legge le linee tubi dal layer "{nomePiano}_tubi" e le esporta in XML tramite IoPannelli.
            /// Coordinate trasformate come il resto del modello: (X-origX, Y-origY) e Z = quotaPiano.
            /// </summary>
            public static void LeggiTubiDXF(
                DxfDocument dxf,
                string nomePiano,
                double quotaPiano,
                double origX,
                double origY
            )
            {
                if (dxf == null)
                {
                    TermodelLog.LogError("LeggiTubiDXF: dxf null.");
                    return;
                }

                if (string.IsNullOrWhiteSpace(nomePiano))
                {
                    TermodelLog.LogError("LeggiTubiDXF: nomePiano vuoto.");
                    return;
                }

                string layerTubi = $"{nomePiano}_tubipannelli";

            List<LineString> lineeTubi = dxf.Lines
               .Where(e => e.Layer != null &&
                           e.Layer.Name.Equals(layerTubi, StringComparison.OrdinalIgnoreCase))
               .Select(e =>
               {
                   var p0 = new Coordinate(e.StartPoint.X - origX, e.StartPoint.Y - origY);
                   var p1 = new Coordinate(e.EndPoint.X - origX, e.EndPoint.Y - origY);
                   return new LineString(new[] { p0, p1 });
               })
               .ToList();


            if (lineeTubi.Count > 0)
                {
                    // NOTA: IoPannelli.InitClass() va chiamata UNA VOLTA a monte nel flusso (es. in avvio impianto)
                    IoPannelli.EsportaTubiPannelli(nomePiano, quotaPiano, lineeTubi);
                    TermodelLog.WriteLog($"Letti {lineeTubi.Count} tubi dal layer {layerTubi}.");
                }
                else
                {
                    TermodelLog.WriteLog($"Nessuna linea trovata su layer {layerTubi}.");
                }
            }
      

        public static void SaveToFile(string pathFile)
        {
            if (string.IsNullOrWhiteSpace(pathFile))
                throw new ArgumentException("Path XML non valido.", nameof(pathFile));

            if (_doc == null)
                throw new InvalidOperationException("IoPannelli.InitClass() non è stato chiamato.");

            var dir = Path.GetDirectoryName(pathFile);
            if (!string.IsNullOrWhiteSpace(dir) && !Directory.Exists(dir))
                Directory.CreateDirectory(dir);

            _doc.Save(pathFile);

            // Modificato da Codex per realizzare: eseguire il generatore di Vittorio nella cartella
            // del file locale.xml, affinché locale.svg sia prodotto nel progetto corrente.
            string cartellaGenerazione =
                Path.GetDirectoryName(Path.GetFullPath(pathFile)) ?? Environment.CurrentDirectory;
            string cartellaCorrente = Environment.CurrentDirectory;
            double passoTubi;
            try
            {
                Directory.SetCurrentDirectory(cartellaGenerazione);
                if (MotoreCorrente == MotoreSpirali.GPT)
                {
                    SpiralHeatingGPT.Program.AggiornaSpirali();
                    passoTubi = SpiralHeatingGPT.Program.PassoTubi;
                }
                else
                {
                    SpiralHeating.Program.AggiornaSpirali();
                    passoTubi = SpiralHeating.Program.PassoTubi;
                }
            }
            finally
            {
                Directory.SetCurrentDirectory(cartellaCorrente);
            }
            GrafoRete(
                pathFile,
                Path.Combine(
                    Path.GetDirectoryName(pathFile) ?? Environment.CurrentDirectory,
                    "retePannelli.xml"));
            TubiCollegamento(
                pathFile,
                Path.Combine(
                    Path.GetDirectoryName(pathFile) ?? Environment.CurrentDirectory,
                    "locale.svg"),
                // Modificato da Codex per realizzare: il generatore del
                // parallelo riceve il passo completo P; dimezza internamente
                // soltanto il primo tratto. Passare già P/2 produceva P/4.
                passoTubi);

            // Modificato da Codex per realizzare: conservare gli output dei due motori
            // senza cambiare i nomi canonici consumati dal resto di Termodel.
            string suffissoMotore = NomeMotoreCorrente.ToLowerInvariant();
            string cartellaOutput = Path.GetDirectoryName(pathFile) ?? Environment.CurrentDirectory;
            string svgCorrente = Path.Combine(cartellaOutput, "locale.svg");
            if (File.Exists(svgCorrente))
                File.Copy(svgCorrente, Path.Combine(cartellaOutput, $"locale-{suffissoMotore}.svg"), true);
            File.Copy(pathFile, Path.Combine(cartellaOutput, $"locale-{suffissoMotore}.xml"), true);

            _doc = XDocument.Load(pathFile);

            string svgPath = Path.Combine(
                Path.GetDirectoryName(pathFile) ?? Environment.CurrentDirectory,
                "locale.svg");
            List<string> piani = _doc
                .Descendants("Piano")
                .Select(p => (string)p.Attribute("Nome"))
                .Where(n => !string.IsNullOrWhiteSpace(n))
                .Distinct(StringComparer.OrdinalIgnoreCase)
                .ToList();

            // L'SVG corrente non distingue ancora le geometrie per piano.
            // Per ora genera l'esecutivo soltanto nel caso già supportato
            // di un singolo piano.
            if (piani.Count == 1)
            {
                string nomePiano = piani[0];
                EsecutivoPannelli(
                    Path.Combine(GestProg.PathProg, $"{nomePiano}.dxf"),
                    pathFile,
                    svgPath,
                    Path.Combine(
                        GestProg.PathProg,
                        $"{nomePiano}_PannelliRadianti_Output.dxf"),
                    nomePiano);
            }
            else if (piani.Count > 1)
            {
                TermodelLog.WriteLog(
                    "Esecutivo pannelli non generato: locale.svg contiene più piani non ancora separati.");
            }
        }

        /// <summary>
        /// Costruisce il grafo geometrico della rete a partire dai tubi presenti
        /// nel file dei locali e lo salva in un XML dedicato.
        /// I punti P3 diventano nodi di ingresso e dividono il tratto terminale.
        /// </summary>
        public static void GrafoRete(string xmlPath, string outputPath)
        {
            const double tolleranza = 0.001;

            if (string.IsNullOrWhiteSpace(xmlPath))
                throw new ArgumentException("Path XML dei locali non valido.", nameof(xmlPath));

            if (string.IsNullOrWhiteSpace(outputPath))
                throw new ArgumentException("Path XML del grafo non valido.", nameof(outputPath));

            if (!File.Exists(xmlPath))
                throw new FileNotFoundException("File XML dei locali non trovato.", xmlPath);

            XDocument locali = XDocument.Load(xmlPath);
            var rete = new XElement(
                "RetePannelli",
                new XAttribute("Versione", "1"));

            foreach (XElement piano in locali.Descendants("Piano"))
            {
                string nomePiano =
                    (string)piano.Attribute("Nome") ?? string.Empty;
                string quota =
                    (string)piano.Attribute("Quota") ?? "0";

                var nodi = new List<GrafoNodo>();
                var tratti = new List<GrafoTratto>();

                GrafoNodo TrovaOCreaNodo(Coordinate punto, bool ingresso)
                {
                    GrafoNodo nodo = nodi.FirstOrDefault(
                        n => n.Punto.Distance(punto) <= tolleranza);

                    if (nodo == null)
                    {
                        nodo = new GrafoNodo
                        {
                            Id = $"N{nodi.Count + 1}",
                            Punto = new Coordinate(punto)
                        };
                        nodi.Add(nodo);
                    }

                    if (ingresso)
                        nodo.IngressoLocale = true;

                    return nodo;
                }

                void AggiungiTratto(
                    string idOriginale,
                    string suffisso,
                    Coordinate da,
                    Coordinate a,
                    bool terminale)
                {
                    if (da == null ||
                        a == null ||
                        da.Distance(a) <= tolleranza)
                    {
                        return;
                    }

                    GrafoNodo nodoDa = TrovaOCreaNodo(da, false);
                    GrafoNodo nodoA = TrovaOCreaNodo(a, false);

                    tratti.Add(new GrafoTratto
                    {
                        Id = string.IsNullOrWhiteSpace(suffisso)
                            ? idOriginale
                            : $"{idOriginale}_{suffisso}",
                        IdOriginale = idOriginale,
                        Da = nodoDa,
                        A = nodoA,
                        Terminale = terminale
                    });
                }

                foreach (XElement linea in
                    piano.Element("Tubi")?.Elements("Linea") ??
                    Enumerable.Empty<XElement>())
                {
                    string id =
                        (string)linea.Attribute("Id") ??
                        $"T{tratti.Count + 1}";
                    Coordinate p0 = LeggiCoordinata(linea.Element("P0"));
                    Coordinate p1 = LeggiCoordinata(linea.Element("P1"));
                    Coordinate p3 = LeggiCoordinata(linea.Element("P3"));

                    if (p0 == null || p1 == null)
                        continue;

                    if (p3 != null &&
                        p3.Distance(p0) > tolleranza &&
                        p3.Distance(p1) > tolleranza)
                    {
                        GrafoNodo ingresso = TrovaOCreaNodo(p3, true);
                        AggiungiTratto(id, "A", p0, ingresso.Punto, true);
                        AggiungiTratto(id, "B", ingresso.Punto, p1, true);
                    }
                    else
                    {
                        if (p3 != null)
                            TrovaOCreaNodo(
                                p3.Distance(p0) <= p3.Distance(p1) ? p0 : p1,
                                true);

                        AggiungiTratto(id, string.Empty, p0, p1, p3 != null);
                    }
                }

                foreach (GrafoNodo nodo in nodi)
                {
                    nodo.Grado = tratti.Count(
                        t => ReferenceEquals(t.Da, nodo) ||
                             ReferenceEquals(t.A, nodo));
                }

                var xPiano = new XElement(
                    "Piano",
                    new XAttribute("Nome", nomePiano),
                    new XAttribute("Quota", quota));
                var xNodi = new XElement("Nodi");
                var xTratti = new XElement("Tratti");

                foreach (GrafoNodo nodo in nodi)
                {
                    string tipo = nodo.IngressoLocale
                        ? "IngressoLocale"
                        : nodo.Grado >= 3
                            ? "Diramazione"
                            : nodo.Grado == 1
                                ? "Estremita"
                                : "Raccordo";

                    xNodi.Add(new XElement(
                        "Nodo",
                        new XAttribute("Id", nodo.Id),
                        new XAttribute("Tipo", tipo),
                        new XAttribute(
                            "X",
                            nodo.Punto.X.ToString(CultureInfo.InvariantCulture)),
                        new XAttribute(
                            "Y",
                            nodo.Punto.Y.ToString(CultureInfo.InvariantCulture)),
                        new XAttribute("Grado", nodo.Grado)));
                }

                foreach (GrafoTratto tratto in tratti)
                {
                    xTratti.Add(new XElement(
                        "Tratto",
                        new XAttribute("Id", tratto.Id),
                        new XAttribute("Origine", tratto.IdOriginale),
                        new XAttribute("Da", tratto.Da.Id),
                        new XAttribute("A", tratto.A.Id),
                        new XAttribute(
                            "Lunghezza",
                            tratto.Da.Punto
                                .Distance(tratto.A.Punto)
                                .ToString(CultureInfo.InvariantCulture)),
                        new XAttribute("Terminale", tratto.Terminale)));
                }

                xPiano.Add(xNodi, xTratti);
                rete.Add(xPiano);
            }

            string cartellaOutput = Path.GetDirectoryName(outputPath);
            if (!string.IsNullOrWhiteSpace(cartellaOutput) &&
                !Directory.Exists(cartellaOutput))
            {
                Directory.CreateDirectory(cartellaOutput);
            }

            new XDocument(
                new XDeclaration("1.0", "utf-8", "yes"),
                rete)
                .Save(outputPath);
        }

        private sealed class GrafoNodo
        {
            public string Id { get; init; }
            public Coordinate Punto { get; init; }
            public bool IngressoLocale { get; set; }
            public int Grado { get; set; }
        }

        private sealed class GrafoTratto
        {
            public string Id { get; init; }
            public string IdOriginale { get; init; }
            public GrafoNodo Da { get; init; }
            public GrafoNodo A { get; init; }
            public bool Terminale { get; init; }
        }

        /// <summary>
        /// Genera nell'SVG il ritorno parallelo dei tubi di collegamento.
        /// Ogni percorso parte dal terminale P3 del locale e viene ricostruito
        /// a ritroso fino al primo nodo di diramazione, assunto come collettore.
        /// </summary>
        public static void TubiCollegamento(
            string xmlPath,
            string svgPath,
            double distanzaRitorno)
        {
            if (string.IsNullOrWhiteSpace(xmlPath) ||
                string.IsNullOrWhiteSpace(svgPath) ||
                distanzaRitorno <= 0 ||
                !File.Exists(xmlPath) ||
                !File.Exists(svgPath))
            {
                return;
            }

            string grafoPath = Path.Combine(
                Path.GetDirectoryName(xmlPath) ?? Environment.CurrentDirectory,
                "retePannelli.xml");
            if (!File.Exists(grafoPath))
                GrafoRete(xmlPath, grafoPath);

            XDocument grafo = XDocument.Load(grafoPath);

            XDocument svg = XDocument.Load(svgPath);
            XNamespace ns = "http://www.w3.org/2000/svg";
            XElement gruppo = svg.Descendants(ns + "g").FirstOrDefault();
            if (gruppo == null)
                return;

            gruppo.Elements(ns + "polyline")
                .Where(e => (string)e.Attribute("data-termodel") == "ritorno-collegamento")
                .Remove();

            // Modificato da Codex per realizzare: i due lati candidati del
            // collegamento di ritorno devono essere verificati anche contro
            // le spirali già disegnate. La sola rete rossa non intercettava
            // la diagonale che attraversava il locale quando mancava spazio.
            List<List<Coordinate>> ostacoliSpirali = svg
                .Descendants(ns + "polyline")
                .Where(e =>
                    (string)e.Attribute("data-termodel") !=
                        "ritorno-collegamento")
                .Select(e => LeggiPuntiSvg(
                    (string)e.Attribute("points")))
                .Where(punti => punti.Count >= 2)
                .ToList();

            var estremiRientroUsati = new HashSet<XElement>();

            foreach (XElement xPiano in
                grafo.Root?.Elements("Piano") ??
                Enumerable.Empty<XElement>())
            {
                Dictionary<string, GrafoNodoPercorso> nodi = (
                    xPiano.Element("Nodi")?.Elements("Nodo") ??
                    Enumerable.Empty<XElement>())
                    .Select(LeggiNodoGrafo)
                    .Where(n => n != null)
                    .ToDictionary(n => n.Id, StringComparer.OrdinalIgnoreCase);

                List<GrafoArcoPercorso> archi = (
                    xPiano.Element("Tratti")?.Elements("Tratto") ??
                    Enumerable.Empty<XElement>())
                    .Select(t => LeggiArcoGrafo(t, nodi))
                    .Where(t => t != null)
                    .ToList();

                if (nodi.Count == 0 || archi.Count == 0)
                    continue;

                GrafoNodoPercorso collettore = nodi.Values
                    .Where(n => !n.IngressoLocale)
                    .OrderByDescending(n => n.Grado)
                    .ThenBy(n => n.Id, StringComparer.OrdinalIgnoreCase)
                    .FirstOrDefault();

                if (collettore == null)
                    continue;

                foreach (GrafoNodoPercorso ingresso in nodi.Values
                    .Where(n => n.IngressoLocale))
                {
                    List<Coordinate> mandata = TrovaPercorsoGrafo(
                        collettore,
                        ingresso,
                        archi);
                    // Modificato da Codex per realizzare: ricercare l'estremo
                    // blu anche alla fine interna del collegamento assunto
                    // come margine, non soltanto in prossimità della parete.
                    Coordinate fineRientro = TrovaFineRientroSpirale(
                        svg,
                        ns,
                        ingresso.Punto,
                        estremiRientroUsati,
                        CalcolaDistanzaRicercaRientro(
                            xPiano,
                            ingresso.Punto,
                            distanzaRitorno));

                    // Modificato da Codex per realizzare: il lato del
                    // parallelo non dipende più dal solo verso della mandata.
                    // Si generano destra e sinistra e si sceglie quella che
                    // prosegue correttamente dall'estremo blu della spirale.
                    List<Coordinate> ritornoDestra =
                        CreaRitornoCollegamento(
                            mandata,
                            distanzaRitorno);
                    List<Coordinate> ritornoSinistra =
                        CreaRitornoCollegamento(
                            mandata,
                            -distanzaRitorno);
                    List<Coordinate> ritorno =
                        ScegliLatoRitornoCollegamento(
                            mandata,
                            ritornoDestra,
                            ritornoSinistra,
                            fineRientro,
                            archi,
                            ostacoliSpirali);

                    if (ritorno.Count < 2)
                        continue;

                    if (fineRientro != null &&
                        fineRientro.Distance(ritorno[0]) > 0.001)
                    {
                        ritorno.Insert(0, fineRientro);
                    }

                    string punti = string.Join(
                        " ",
                        ritorno.Select(p =>
                            $"{p.X.ToString(CultureInfo.InvariantCulture)}," +
                            $"{p.Y.ToString(CultureInfo.InvariantCulture)}"));

                    gruppo.Add(new XElement(
                        ns + "polyline",
                        new XAttribute("points", punti),
                        new XAttribute("fill", "none"),
                        new XAttribute("stroke", "blue"),
                        new XAttribute("stroke-width", "0.015"),
                        new XAttribute("stroke-dasharray", "0.05,0.05"),
                        new XAttribute(
                            "data-piano",
                            (string)xPiano.Attribute("Nome") ?? string.Empty),
                        new XAttribute(
                            "data-ingresso",
                            ingresso.Id),
                        new XAttribute(
                            "data-termodel",
                            "ritorno-collegamento")));
                }
            }

            svg.Save(svgPath);
        }

        private sealed class GrafoNodoPercorso
        {
            public string Id { get; init; }
            public Coordinate Punto { get; init; }
            public bool IngressoLocale { get; init; }
            public int Grado { get; init; }
        }

        private sealed class GrafoArcoPercorso
        {
            public GrafoNodoPercorso Da { get; init; }
            public GrafoNodoPercorso A { get; init; }
            public double Lunghezza { get; init; }

            public GrafoNodoPercorso Altro(GrafoNodoPercorso nodo)
            {
                return ReferenceEquals(Da, nodo) ? A : Da;
            }
        }

        private static GrafoNodoPercorso LeggiNodoGrafo(XElement elemento)
        {
            if (elemento == null)
                return null;

            bool xValida = double.TryParse(
                (string)elemento.Attribute("X"),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out double x);
            bool yValida = double.TryParse(
                (string)elemento.Attribute("Y"),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out double y);
            bool gradoValido = int.TryParse(
                (string)elemento.Attribute("Grado"),
                NumberStyles.Integer,
                CultureInfo.InvariantCulture,
                out int grado);

            if (!xValida || !yValida)
                return null;

            return new GrafoNodoPercorso
            {
                Id = (string)elemento.Attribute("Id") ?? string.Empty,
                Punto = new Coordinate(x, y),
                IngressoLocale = string.Equals(
                    (string)elemento.Attribute("Tipo"),
                    "IngressoLocale",
                    StringComparison.OrdinalIgnoreCase),
                Grado = gradoValido ? grado : 0
            };
        }

        private static GrafoArcoPercorso LeggiArcoGrafo(
            XElement elemento,
            Dictionary<string, GrafoNodoPercorso> nodi)
        {
            if (elemento == null || nodi == null)
                return null;

            string idDa = (string)elemento.Attribute("Da");
            string idA = (string)elemento.Attribute("A");
            if (string.IsNullOrWhiteSpace(idDa) ||
                string.IsNullOrWhiteSpace(idA) ||
                !nodi.TryGetValue(idDa, out GrafoNodoPercorso da) ||
                !nodi.TryGetValue(idA, out GrafoNodoPercorso a))
            {
                return null;
            }

            return new GrafoArcoPercorso
            {
                Da = da,
                A = a,
                Lunghezza = da.Punto.Distance(a.Punto)
            };
        }

        private static List<Coordinate> TrovaPercorsoGrafo(
            GrafoNodoPercorso partenza,
            GrafoNodoPercorso arrivo,
            List<GrafoArcoPercorso> archi)
        {
            if (partenza == null || arrivo == null || archi == null)
                return new List<Coordinate>();

            var nodi = archi
                .SelectMany(a => new[] { a.Da, a.A })
                .Distinct()
                .ToList();
            var distanze = nodi.ToDictionary(n => n, _ => double.PositiveInfinity);
            var precedenti = new Dictionary<GrafoNodoPercorso, GrafoNodoPercorso>();
            var nonVisitati = new HashSet<GrafoNodoPercorso>(nodi);

            distanze[partenza] = 0;

            while (nonVisitati.Count > 0)
            {
                GrafoNodoPercorso corrente = nonVisitati
                    .OrderBy(n => distanze[n])
                    .First();

                if (double.IsPositiveInfinity(distanze[corrente]))
                    break;

                nonVisitati.Remove(corrente);
                if (ReferenceEquals(corrente, arrivo))
                    break;

                foreach (GrafoArcoPercorso arco in archi.Where(
                    a => ReferenceEquals(a.Da, corrente) ||
                         ReferenceEquals(a.A, corrente)))
                {
                    GrafoNodoPercorso vicino = arco.Altro(corrente);
                    if (!nonVisitati.Contains(vicino))
                        continue;

                    double nuovaDistanza =
                        distanze[corrente] + arco.Lunghezza;
                    if (nuovaDistanza < distanze[vicino])
                    {
                        distanze[vicino] = nuovaDistanza;
                        precedenti[vicino] = corrente;
                    }
                }
            }

            if (!ReferenceEquals(partenza, arrivo) &&
                !precedenti.ContainsKey(arrivo))
            {
                return new List<Coordinate>();
            }

            var percorso = new List<GrafoNodoPercorso> { arrivo };
            GrafoNodoPercorso nodoPercorso = arrivo;
            while (!ReferenceEquals(nodoPercorso, partenza))
            {
                nodoPercorso = precedenti[nodoPercorso];
                percorso.Add(nodoPercorso);
            }

            percorso.Reverse();
            return percorso
                .Select(n => new Coordinate(n.Punto))
                .ToList();
        }

        private static Coordinate TrovaFineRientroSpirale(
            XDocument svg,
            XNamespace ns,
            Coordinate ingresso,
            HashSet<XElement> elementiUsati,
            double distanzaMassima)
        {
            XElement elementoMigliore = null;
            Coordinate puntoMigliore = null;
            double distanzaMigliore = double.PositiveInfinity;

            foreach (XElement elemento in svg.Descendants(ns + "polyline")
                .Where(e =>
                    string.Equals(
                        (string)e.Attribute("stroke"),
                        "blue",
                        StringComparison.OrdinalIgnoreCase) &&
                    (string)e.Attribute("data-termodel") !=
                        "ritorno-collegamento" &&
                    !elementiUsati.Contains(e)))
            {
                List<Coordinate> punti = LeggiPuntiSvg(
                    (string)elemento.Attribute("points"));
                if (punti.Count == 0)
                    continue;

                foreach (Coordinate estremo in new[]
                {
                    punti[0],
                    punti[punti.Count - 1]
                })
                {
                    double distanza = estremo.Distance(ingresso);
                    if (distanza < distanzaMigliore)
                    {
                        distanzaMigliore = distanza;
                        puntoMigliore = estremo;
                        elementoMigliore = elemento;
                    }
                }
            }

            if (elementoMigliore == null ||
                distanzaMigliore > distanzaMassima)
            {
                return null;
            }

            elementiUsati.Add(elementoMigliore);
            return new Coordinate(puntoMigliore);
        }

        // Funzione realizzata da Codex in autonomia
        private static double CalcolaDistanzaRicercaRientro(
            XElement piano,
            Coordinate ingresso,
            double distanzaRitorno)
        {
            double distanzaMinima = distanzaRitorno * 4.0;
            if (piano == null || ingresso == null)
                return distanzaMinima;

            double estensioneTerminale = (
                piano.Element("Tubi")?.Elements("Linea") ??
                Enumerable.Empty<XElement>())
                .Select(LeggiTuboCollegamento)
                .Where(t =>
                    t?.P3 != null &&
                    t.P3.Distance(ingresso) <= 0.001)
                .Select(t => Math.Max(
                    t.P0.Distance(t.P3),
                    t.P1.Distance(t.P3)))
                .DefaultIfEmpty(0.0)
                .Max();

            // Modificato da Codex per realizzare: il ritorno può ora
            // terminare alla fine interna del tubo, non più soltanto sulla
            // parete; la ricerca deve quindi coprire l'intero tratto terminale.
            return Math.Max(
                distanzaMinima,
                estensioneTerminale + distanzaRitorno * 2.0);
        }

        private static List<Coordinate> LeggiPuntiSvg(string points)
        {
            var risultato = new List<Coordinate>();
            if (string.IsNullOrWhiteSpace(points))
                return risultato;

            foreach (string coppia in points.Split(
                new[] { ' ', '\t', '\r', '\n' },
                StringSplitOptions.RemoveEmptyEntries))
            {
                string[] valori = coppia.Split(',');
                if (valori.Length != 2)
                    continue;

                bool xValida = double.TryParse(
                    valori[0],
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double x);
                bool yValida = double.TryParse(
                    valori[1],
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double y);

                if (xValida && yValida)
                    risultato.Add(new Coordinate(x, y));
            }

            return risultato;
        }

        private sealed class TuboCollegamentoXml
        {
            public string Id { get; init; }
            public Coordinate P0 { get; init; }
            public Coordinate P1 { get; init; }
            public Coordinate P3 { get; init; }
        }

        private static TuboCollegamentoXml LeggiTuboCollegamento(XElement linea)
        {
            Coordinate p0 = LeggiCoordinata(linea.Element("P0"));
            Coordinate p1 = LeggiCoordinata(linea.Element("P1"));

            if (p0 == null || p1 == null)
                return null;

            return new TuboCollegamentoXml
            {
                Id = (string)linea.Attribute("Id") ?? string.Empty,
                P0 = p0,
                P1 = p1,
                P3 = LeggiCoordinata(linea.Element("P3"))
            };
        }

        private static Coordinate LeggiCoordinata(XElement elemento)
        {
            if (elemento == null)
                return null;

            bool xValida = double.TryParse(
                (string)elemento.Attribute("X"),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out double x);
            bool yValida = double.TryParse(
                (string)elemento.Attribute("Y"),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out double y);

            return xValida && yValida ? new Coordinate(x, y) : null;
        }

        private static List<Coordinate> RicostruisciMandataCollegamento(
            TuboCollegamentoXml terminale,
            List<TuboCollegamentoXml> tubi)
        {
            const double tolleranza = 0.001;

            Coordinate puntoEsterno =
                terminale.P0.Distance(terminale.P3) >= terminale.P1.Distance(terminale.P3)
                    ? terminale.P0
                    : terminale.P1;

            var percorsoInverso = new List<Coordinate>
            {
                new Coordinate(terminale.P3),
                new Coordinate(puntoEsterno)
            };
            var usati = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
            {
                terminale.Id
            };

            Coordinate corrente = puntoEsterno;

            while (true)
            {
                var candidati = tubi
                    .Where(t => !usati.Contains(t.Id))
                    .Where(t =>
                        t.P0.Distance(corrente) <= tolleranza ||
                        t.P1.Distance(corrente) <= tolleranza)
                    .ToList();

                // Nessun seguito oppure diramazione: il percorso termina qui.
                if (candidati.Count != 1)
                    break;

                TuboCollegamentoXml successivo = candidati[0];
                usati.Add(successivo.Id);

                corrente = successivo.P0.Distance(corrente) <= tolleranza
                    ? successivo.P1
                    : successivo.P0;

                percorsoInverso.Add(new Coordinate(corrente));
            }

            percorsoInverso.Reverse();
            return EliminaCoordinateConsecutiveDuplicate(percorsoInverso, tolleranza);
        }

        private static List<Coordinate> CreaRitornoCollegamento(
            List<Coordinate> mandata,
            double distanza)
        {
            if (mandata == null || mandata.Count < 2)
                return new List<Coordinate>();

            List<Coordinate> percorso =
                EliminaCoordinateConsecutiveDuplicate(mandata, 0.001);
            if (percorso.Count < 2)
                return new List<Coordinate>();

            var parallela = new List<Coordinate>
            {
                // Modificato da Codex per realizzare: dimezzare la distanza
                // mandata-ritorno soltanto alla partenza dal collettore. Dal
                // primo vertice successivo resta valida la distanza normale.
                SpostaADestra(
                    percorso[0],
                    percorso[1],
                    percorso[0],
                    distanza / 2.0)
            };

            // Modificato da Codex per realizzare: mantenere P/2 lungo tutto il
            // primo tratto in uscita dal collettore. Il precedente secondo
            // punto era già a P e trasformava l'intero tratto in una diagonale
            // a distanza variabile.
            parallela.Add(SpostaADestra(
                percorso[0],
                percorso[1],
                percorso[1],
                distanza / 2.0));

            for (int i = 1; i < percorso.Count - 1; i++)
            {
                Coordinate precedente = percorso[i - 1];
                Coordinate vertice = percorso[i];
                Coordinate successivo = percorso[i + 1];

                Coordinate a0 = SpostaADestra(
                    precedente,
                    vertice,
                    precedente,
                    distanza);
                Coordinate a1 = SpostaADestra(
                    precedente,
                    vertice,
                    vertice,
                    distanza);
                Coordinate b0 = SpostaADestra(
                    vertice,
                    successivo,
                    vertice,
                    distanza);
                Coordinate b1 = SpostaADestra(
                    vertice,
                    successivo,
                    successivo,
                    distanza);

                Coordinate intersezione = IntersezioneRette(a0, a1, b0, b1);
                // Modificato da Codex per realizzare: consentire la costruzione
                // simmetrica anche sul lato sinistro (distanza negativa).
                if (intersezione == null ||
                    intersezione.Distance(vertice) > Math.Abs(distanza) * 8.0)
                {
                    Coordinate tangenteEntrante =
                        VettoreUnitario(precedente, vertice);
                    Coordinate tangenteUscente =
                        VettoreUnitario(vertice, successivo);
                    Coordinate normaleMedia = Normalizza(new Coordinate(
                        tangenteEntrante.Y + tangenteUscente.Y,
                        -tangenteEntrante.X - tangenteUscente.X));

                    intersezione = new Coordinate(
                        vertice.X + normaleMedia.X * distanza,
                        vertice.Y + normaleMedia.Y * distanza);
                }

                if (parallela[parallela.Count - 1]
                    .Distance(intersezione) > 0.001)
                {
                    parallela.Add(intersezione);
                }
            }

            // Modificato da Codex per realizzare: se esiste soltanto il primo
            // tratto, anche il suo estremo resta a P/2; dal secondo tratto in
            // poi l'estremo terminale mantiene invece la distanza completa P.
            Coordinate estremoFinale = SpostaADestra(
                percorso[percorso.Count - 2],
                percorso[percorso.Count - 1],
                percorso[percorso.Count - 1],
                percorso.Count == 2 ? distanza / 2.0 : distanza);
            if (parallela[parallela.Count - 1]
                .Distance(estremoFinale) > 0.001)
            {
                parallela.Add(estremoFinale);
            }

            parallela.Reverse();
            return parallela;
        }

        // Funzione realizzata da Codex in autonomia
        private static List<Coordinate> ScegliLatoRitornoCollegamento(
            List<Coordinate> mandata,
            List<Coordinate> ritornoDestra,
            List<Coordinate> ritornoSinistra,
            Coordinate fineRientro,
            IReadOnlyList<GrafoArcoPercorso> reteMandata,
            IReadOnlyList<List<Coordinate>> ostacoliSpirali)
        {
            bool destraValida = ritornoDestra != null && ritornoDestra.Count >= 2;
            bool sinistraValida = ritornoSinistra != null && ritornoSinistra.Count >= 2;

            if (!destraValida)
                return sinistraValida
                    ? ritornoSinistra
                    : new List<Coordinate>();

            if (!sinistraValida || fineRientro == null)
                return ritornoDestra;

            double punteggioDestra = PunteggioLatoRitornoCollegamento(
                mandata,
                ritornoDestra,
                fineRientro,
                reteMandata,
                ostacoliSpirali);
            double punteggioSinistra = PunteggioLatoRitornoCollegamento(
                mandata,
                ritornoSinistra,
                fineRientro,
                reteMandata,
                ostacoliSpirali);

            // A parità si conserva il comportamento storico (lato destro).
            return punteggioSinistra < punteggioDestra
                ? ritornoSinistra
                : ritornoDestra;
        }

        // Funzione realizzata da Codex in autonomia
        private static double PunteggioLatoRitornoCollegamento(
            IReadOnlyList<Coordinate> mandata,
            IReadOnlyList<Coordinate> ritorno,
            Coordinate fineRientro,
            IReadOnlyList<GrafoArcoPercorso> reteMandata,
            IReadOnlyList<List<Coordinate>> ostacoliSpirali)
        {
            var percorsoCompleto = ritorno
                .Select(p => new Coordinate(p))
                .ToList();

            double distanzaAggancio = fineRientro.Distance(percorsoCompleto[0]);
            if (distanzaAggancio > 0.001)
                percorsoCompleto.Insert(0, new Coordinate(fineRientro));

            int incrociMandata = ContaIntersezioniProprie(
                percorsoCompleto,
                mandata);
            int autoIntersezioni = ContaAutoIntersezioniProprie(
                percorsoCompleto);
            // Modificato da Codex per realizzare: valutare il candidato contro
            // l'intera rete rossa e non soltanto contro la mandata del proprio
            // circuito. In questo modo il parallelo evita anche i rami vicini.
            int incrociRete = ContaIntersezioniConReteMandata(
                percorsoCompleto,
                reteMandata);
            int incrociSpirali = ostacoliSpirali == null
                ? 0
                : ostacoliSpirali.Sum(spirale =>
                    ContaIntersezioniProprie(
                        percorsoCompleto,
                        spirale));

            // Gli incroci rendono il lato geometricamente non ammissibile;
            // fra candidati equivalenti prevale l'aggancio più corto.
            return
                incrociMandata * 1000000.0 +
                autoIntersezioni * 1000000.0 +
                incrociRete * 1000000.0 +
                incrociSpirali * 1000000.0 +
                distanzaAggancio;
        }

        // Funzione realizzata da Codex in autonomia
        private static int ContaIntersezioniConReteMandata(
            IReadOnlyList<Coordinate> percorso,
            IReadOnlyList<GrafoArcoPercorso> reteMandata)
        {
            if (percorso == null || reteMandata == null)
                return 0;

            int totale = 0;
            for (int i = 0; i < percorso.Count - 1; i++)
            {
                foreach (GrafoArcoPercorso arco in reteMandata)
                {
                    if (arco?.Da?.Punto == null || arco.A?.Punto == null)
                        continue;

                    if (SegmentiSiIntersecanoInternamente(
                        percorso[i],
                        percorso[i + 1],
                        arco.Da.Punto,
                        arco.A.Punto))
                    {
                        totale++;
                    }
                }
            }

            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static int ContaIntersezioniProprie(
            IReadOnlyList<Coordinate> primo,
            IReadOnlyList<Coordinate> secondo)
        {
            if (primo == null || secondo == null)
                return 0;

            int totale = 0;
            for (int i = 0; i < primo.Count - 1; i++)
            {
                for (int j = 0; j < secondo.Count - 1; j++)
                {
                    if (SegmentiSiIntersecanoInternamente(
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
        private static int ContaAutoIntersezioniProprie(
            IReadOnlyList<Coordinate> percorso)
        {
            if (percorso == null)
                return 0;

            int totale = 0;
            for (int i = 0; i < percorso.Count - 1; i++)
            {
                for (int j = i + 2; j < percorso.Count - 1; j++)
                {
                    if (SegmentiSiIntersecanoInternamente(
                        percorso[i],
                        percorso[i + 1],
                        percorso[j],
                        percorso[j + 1]))
                    {
                        totale++;
                    }
                }
            }

            return totale;
        }

        // Funzione realizzata da Codex in autonomia
        private static bool SegmentiSiIntersecanoInternamente(
            Coordinate a0,
            Coordinate a1,
            Coordinate b0,
            Coordinate b1)
        {
            const double tolleranza = 0.000000001;

            double latoB0 = ProdottoVettoriale(a0, a1, b0);
            double latoB1 = ProdottoVettoriale(a0, a1, b1);
            double latoA0 = ProdottoVettoriale(b0, b1, a0);
            double latoA1 = ProdottoVettoriale(b0, b1, a1);

            // Si contano soltanto gli attraversamenti interni: contatti sugli
            // estremi e segmenti collineari sono giunzioni ammesse.
            return
                latoB0 * latoB1 < -tolleranza &&
                latoA0 * latoA1 < -tolleranza;
        }

        // Funzione realizzata da Codex in autonomia
        private static double ProdottoVettoriale(
            Coordinate a,
            Coordinate b,
            Coordinate punto)
        {
            return
                (b.X - a.X) * (punto.Y - a.Y) -
                (b.Y - a.Y) * (punto.X - a.X);
        }

        private static Coordinate SpostaADestra(
            Coordinate inizioSegmento,
            Coordinate fineSegmento,
            Coordinate punto,
            double distanza)
        {
            Coordinate tangente =
                VettoreUnitario(inizioSegmento, fineSegmento);
            return new Coordinate(
                punto.X + tangente.Y * distanza,
                punto.Y - tangente.X * distanza);
        }

        private static Coordinate IntersezioneRette(
            Coordinate a0,
            Coordinate a1,
            Coordinate b0,
            Coordinate b1)
        {
            double ax = a1.X - a0.X;
            double ay = a1.Y - a0.Y;
            double bx = b1.X - b0.X;
            double by = b1.Y - b0.Y;
            double denominatore = ax * by - ay * bx;

            if (Math.Abs(denominatore) <= 0.000000001)
                return null;

            double cx = b0.X - a0.X;
            double cy = b0.Y - a0.Y;
            double parametro = (cx * by - cy * bx) / denominatore;

            return new Coordinate(
                a0.X + parametro * ax,
                a0.Y + parametro * ay);
        }

        private static Coordinate VettoreUnitario(Coordinate da, Coordinate a)
        {
            return Normalizza(new Coordinate(a.X - da.X, a.Y - da.Y));
        }

        private static Coordinate Normalizza(Coordinate vettore)
        {
            double lunghezza = Math.Sqrt(
                vettore.X * vettore.X +
                vettore.Y * vettore.Y);

            return lunghezza <= 0.000001
                ? new Coordinate(0, 0)
                : new Coordinate(vettore.X / lunghezza, vettore.Y / lunghezza);
        }

        private static List<Coordinate> EliminaCoordinateConsecutiveDuplicate(
            IEnumerable<Coordinate> punti,
            double tolleranza)
        {
            var risultato = new List<Coordinate>();

            foreach (Coordinate punto in punti)
            {
                if (risultato.Count == 0 ||
                    risultato[risultato.Count - 1].Distance(punto) > tolleranza)
                {
                    risultato.Add(punto);
                }
            }

            return risultato;
        }

        /// <summary>
        /// Crea il DXF esecutivo dei pannelli partendo dalla pianta pulita.
        /// La pianta base non viene modificata: il risultato è salvato in un
        /// file separato e completamente rigenerabile.
        /// </summary>
        public static void EsecutivoPannelli(
            string pathPiantaBase,
            string pathLocaleXml,
            string pathSvg,
            string pathOutputDxf,
            string nomePiano)
        {
            if (string.IsNullOrWhiteSpace(pathPiantaBase) ||
                string.IsNullOrWhiteSpace(pathLocaleXml) ||
                string.IsNullOrWhiteSpace(pathSvg) ||
                string.IsNullOrWhiteSpace(pathOutputDxf) ||
                string.IsNullOrWhiteSpace(nomePiano) ||
                !File.Exists(pathPiantaBase) ||
                !File.Exists(pathLocaleXml) ||
                !File.Exists(pathSvg))
            {
                TermodelLog.WriteLog(
                    $"Esecutivo pannelli non generato per il piano '{nomePiano}': file di base mancanti.");
                return;
            }

            DxfDocument esecutivo = DxfDocument.Load(pathPiantaBase);
            if (esecutivo == null)
            {
                TermodelLog.WriteLog(
                    $"Esecutivo pannelli non generato: impossibile leggere '{pathPiantaBase}'.");
                return;
            }

            var layerEdificio = OttieniOCreaLayer(
                esecutivo,
                $"{nomePiano}_Edificio_Output");
            var layerMandata = OttieniOCreaLayer(
                esecutivo,
                $"{nomePiano}_PannelliMandata_Output");
            var layerRitorno = OttieniOCreaLayer(
                esecutivo,
                $"{nomePiano}_PannelliRitorno_Output");
            // Modificato da Codex per realizzare: layer esclusivo delle
            // marcature numerate generate da ChiusuraGPT di Vittorio.
            var layerNumeriCircuiti = OttieniOCreaLayer(
                esecutivo,
                $"{nomePiano}_NumeriCircuiti_Output");

            foreach (netDxf.Entities.LwPolyline polilinea in esecutivo.LwPolylines)
                polilinea.Layer = layerEdificio;
            foreach (netDxf.Entities.Line linea in esecutivo.Lines)
                linea.Layer = layerEdificio;

            XDocument svg = XDocument.Load(pathSvg);
            XNamespace ns = "http://www.w3.org/2000/svg";
            IoTubi.DisponiTubiSulCollettore(
                esecutivo,
                svg,
                Path.Combine(
                    Path.GetDirectoryName(pathLocaleXml) ??
                        Environment.CurrentDirectory,
                    "retePannelli.xml"),
                nomePiano);

            foreach (XElement elemento in svg.Descendants(ns + "polyline"))
            {
                string pointsText = (string)elemento.Attribute("points");
                if (string.IsNullOrWhiteSpace(pointsText))
                    continue;

                var vertici = new List<netDxf.Entities.LwPolylineVertex>();

                foreach (string coppia in pointsText.Split(
                    new[] { ' ', '\r', '\n', '\t' },
                    StringSplitOptions.RemoveEmptyEntries))
                {
                    string[] coordinate = coppia.Split(',');
                    if (coordinate.Length != 2)
                        continue;

                    bool xValida = double.TryParse(
                        coordinate[0],
                        NumberStyles.Float,
                        CultureInfo.InvariantCulture,
                        out double x);
                    bool yValida = double.TryParse(
                        coordinate[1],
                        NumberStyles.Float,
                        CultureInfo.InvariantCulture,
                        out double y);

                    if (xValida && yValida)
                        vertici.Add(new netDxf.Entities.LwPolylineVertex(x, y));
                }

                if (vertici.Count < 2)
                    continue;

                bool ritorno = string.Equals(
                    (string)elemento.Attribute("stroke"),
                    "blue",
                    StringComparison.OrdinalIgnoreCase);

                var polilinea = new netDxf.Entities.LwPolyline(vertici)
                {
                    IsClosed = false,
                    Layer = ritorno ? layerRitorno : layerMandata,
                    Color = ritorno ? AciColor.Blue : AciColor.Red,
                    Linetype = netDxf.Tables.Linetype.Continuous
                };

                esecutivo.AddEntity(polilinea);
            }

            foreach (XElement elemento in svg.Descendants(ns + "line"))
            {
                if (!TryLeggiAttributoSvg(elemento, "x1", out double x1) ||
                    !TryLeggiAttributoSvg(elemento, "y1", out double y1) ||
                    !TryLeggiAttributoSvg(elemento, "x2", out double x2) ||
                    !TryLeggiAttributoSvg(elemento, "y2", out double y2))
                {
                    continue;
                }

                bool ritorno = string.Equals(
                    (string)elemento.Attribute("stroke"),
                    "blue",
                    StringComparison.OrdinalIgnoreCase);

                var linea = new netDxf.Entities.Line(
                    new Vector2(x1, y1),
                    new Vector2(x2, y2))
                {
                    Layer = ritorno ? layerRitorno : layerMandata,
                    Color = ritorno ? AciColor.Blue : AciColor.Red,
                    Linetype = netDxf.Tables.Linetype.Continuous
                };

                esecutivo.AddEntity(linea);
            }

            // Modificato da Codex per realizzare: conversione dei box SVG
            // prodotti da ChiusuraGPT in rettangoli del solo DXF esecutivo.
            foreach (XElement elemento in svg
                .Descendants(ns + "rect")
                .Where(e => string.Equals(
                    (string)e.Attribute("data-termodel"),
                    "chiusura-gpt",
                    StringComparison.OrdinalIgnoreCase)))
            {
                if (!TryLeggiAttributoSvg(elemento, "x", out double x) ||
                    !TryLeggiAttributoSvg(elemento, "y", out double y) ||
                    !TryLeggiAttributoSvg(
                        elemento,
                        "width",
                        out double larghezza) ||
                    !TryLeggiAttributoSvg(
                        elemento,
                        "height",
                        out double altezza))
                {
                    continue;
                }

                var box = new netDxf.Entities.LwPolyline(
                    new List<netDxf.Entities.LwPolylineVertex>
                    {
                        new netDxf.Entities.LwPolylineVertex(x, y),
                        new netDxf.Entities.LwPolylineVertex(
                            x + larghezza,
                            y),
                        new netDxf.Entities.LwPolylineVertex(
                            x + larghezza,
                            y + altezza),
                        new netDxf.Entities.LwPolylineVertex(
                            x,
                            y + altezza)
                    })
                {
                    IsClosed = true,
                    Layer = layerNumeriCircuiti,
                    Color = AciColor.Green,
                    Linetype = netDxf.Tables.Linetype.Continuous
                };
                esecutivo.AddEntity(box);
            }

            // Modificato da Codex per realizzare: conversione del numero SVG
            // prodotto da ChiusuraGPT in testo centrato nel box esecutivo.
            foreach (XElement elemento in svg
                .Descendants(ns + "text")
                .Where(e => string.Equals(
                    (string)e.Attribute("data-termodel"),
                    "chiusura-gpt",
                    StringComparison.OrdinalIgnoreCase)))
            {
                if (!TryLeggiAttributoSvg(
                        elemento,
                        "data-x",
                        out double x) ||
                    !TryLeggiAttributoSvg(
                        elemento,
                        "data-y",
                        out double y) ||
                    !TryLeggiAttributoSvg(
                        elemento,
                        "data-altezza",
                        out double altezza) ||
                    string.IsNullOrWhiteSpace(elemento.Value))
                {
                    continue;
                }

                var numero = new netDxf.Entities.Text(
                    elemento.Value.Trim(),
                    new Vector2(x, y),
                    altezza)
                {
                    Alignment =
                        netDxf.Entities.TextAlignment.MiddleCenter,
                    Layer = layerNumeriCircuiti,
                    Color = AciColor.Green
                };
                esecutivo.AddEntity(numero);
            }

            IoTubi.DisegnaCollettore(
                esecutivo,
                Path.Combine(
                    Path.GetDirectoryName(pathLocaleXml) ??
                        Environment.CurrentDirectory,
                    "retePannelli.xml"),
                nomePiano);

            string cartellaOutput = Path.GetDirectoryName(pathOutputDxf);
            if (!string.IsNullOrWhiteSpace(cartellaOutput))
                Directory.CreateDirectory(cartellaOutput);

            esecutivo.Save(pathOutputDxf);
            TermodelLog.WriteLog(
                $"Esecutivo pannelli generato: {pathOutputDxf}");
        }

        private static netDxf.Tables.Layer OttieniOCreaLayer(
            DxfDocument documento,
            string nomeLayer)
        {
            if (documento.Layers.Contains(nomeLayer))
                return documento.Layers[nomeLayer];

            var layer = new netDxf.Tables.Layer(nomeLayer)
            {
                Linetype = netDxf.Tables.Linetype.Continuous
            };
            documento.Layers.Add(layer);
            return layer;
        }

        private static bool TryLeggiAttributoSvg(
            XElement elemento,
            string nomeAttributo,
            out double valore)
        {
            return double.TryParse(
                (string)elemento.Attribute(nomeAttributo),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out valore);
        }

        public static XDocument GetDocument()
        {
            return _doc == null ? null : new XDocument(_doc);
        }

        public static void DisegnaSvgSpirali(
    HelixViewport3D viewport,
    string svgPath,
    double quotaPiano = 0)
        {
            if (viewport == null || !File.Exists(svgPath))
                return;

            const double sollevamento = 0.02;

            XDocument svg = XDocument.Load(svgPath);
            XNamespace ns = "http://www.w3.org/2000/svg";

            foreach (XElement polyline in svg.Descendants(ns + "polyline"))
            {
                string pointsText = (string)polyline.Attribute("points");
                if (string.IsNullOrWhiteSpace(pointsText))
                    continue;

                string stroke = ((string)polyline.Attribute("stroke") ?? "")
                    .ToLowerInvariant();

                var colore = stroke switch
                {
                    "red" => Colors.Red,
                    "blue" => Colors.Blue,
                    _ => Colors.Gray
                };

                var punti = new List<Point3D>();

                string[] coppie = pointsText.Split(
                    new[] { ' ', '\r', '\n', '\t' },
                    StringSplitOptions.RemoveEmptyEntries);

                foreach (string coppia in coppie)
                {
                    string[] coordinate = coppia.Split(',');

                    if (coordinate.Length != 2)
                        continue;

                    bool xValida = double.TryParse(
                        coordinate[0],
                        NumberStyles.Float,
                        CultureInfo.InvariantCulture,
                        out double x);

                    bool yValida = double.TryParse(
                        coordinate[1],
                        NumberStyles.Float,
                        CultureInfo.InvariantCulture,
                        out double y);

                    if (xValida && yValida)
                    {
                        punti.Add(new Point3D(
                            x,
                            y,
                            quotaPiano + sollevamento));
                    }
                }

                if (punti.Count < 2)
                    continue;

                var grafica = new LinesVisual3D
                {
                    Color = colore,
                    Thickness = 2
                };

                for (int i = 0; i < punti.Count - 1; i++)
                {
                    if ((punti[i] - punti[i + 1]).Length < 0.000001)
                        continue;

                    grafica.Points.Add(punti[i]);
                    grafica.Points.Add(punti[i + 1]);
                }

                if (grafica.Points.Count >= 2)
                    viewport.Children.Add(grafica);
            }

            // I tubi di collegamento disegnati dall'utente sono salvati
            // da Vittorio come elementi SVG <line>, non come <polyline>.
            foreach (XElement linea in svg.Descendants(ns + "line"))
            {
                bool x1Valida = double.TryParse(
                    (string)linea.Attribute("x1"),
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double x1);
                bool y1Valida = double.TryParse(
                    (string)linea.Attribute("y1"),
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double y1);
                bool x2Valida = double.TryParse(
                    (string)linea.Attribute("x2"),
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double x2);
                bool y2Valida = double.TryParse(
                    (string)linea.Attribute("y2"),
                    NumberStyles.Float,
                    CultureInfo.InvariantCulture,
                    out double y2);

                if (!x1Valida || !y1Valida || !x2Valida || !y2Valida)
                    continue;

                var inizio = new Point3D(x1, y1, quotaPiano + sollevamento);
                var fine = new Point3D(x2, y2, quotaPiano + sollevamento);

                if ((inizio - fine).Length < 0.000001)
                    continue;

                string stroke = ((string)linea.Attribute("stroke") ?? "")
                    .ToLowerInvariant();

                var graficaLinea = new LinesVisual3D
                {
                    Color = stroke switch
                    {
                        "blue" => Colors.Blue,
                        "red" => Colors.Red,
                        _ => Colors.Gray
                    },
                    Thickness = 2
                };

                graficaLinea.Points.Add(inizio);
                graficaLinea.Points.Add(fine);
                viewport.Children.Add(graficaLinea);
            }
        }
        public static void DisegnaSpirali(
       HelixViewport3D viewport,
       double quotaPiano = 0)
        {
            if (viewport == null || _doc == null)
                return;

            const double sollevamento = 0.02;

            foreach (XElement xSpirale in _doc.Descendants("Spirale"))
            {
                var punti = new List<Point3D>();

                foreach (XElement xPunto in xSpirale.Elements("Punto"))
                {
                    bool xValida = double.TryParse(
                        (string)xPunto.Attribute("X"),
                        NumberStyles.Float,
                        CultureInfo.InvariantCulture,
                        out double x);

                    bool yValida = double.TryParse(
                        (string)xPunto.Attribute("Y"),
                        NumberStyles.Float,
                        CultureInfo.InvariantCulture,
                        out double y);

                    if (xValida && yValida)
                    {
                        punti.Add(new Point3D(
                            x,
                            y,
                            quotaPiano + sollevamento));
                    }
                }

                if (punti.Count < 2)
                    continue;

                var graficaSpirale = new LinesVisual3D
                {
                    Color = Colors.Blue,
                    Thickness = 2
                };

                for (int i = 0; i < punti.Count - 1; i++)
                {
                    // Evita segmenti nulli dovuti a punti consecutivi duplicati.
                    if ((punti[i] - punti[i + 1]).Length < 0.000001)
                        continue;

                    graficaSpirale.Points.Add(punti[i]);
                    graficaSpirale.Points.Add(punti[i + 1]);
                }

                if (graficaSpirale.Points.Count >= 2)
                    viewport.Children.Add(graficaSpirale);
            }
        }
    }
}
