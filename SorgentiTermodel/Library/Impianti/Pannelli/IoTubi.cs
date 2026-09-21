using netDxf;
using netDxf.Entities;
using netDxf.Tables;
using System;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Xml.Linq;

namespace Termodel.Impianti.Pannelli
{
    internal static class IoTubi
    {
        /// <summary>
        /// Disegna nell'esecutivo DXF un collettore rettangolare con il centro
        /// del frontale sul nodo del grafo con grado maggiore. La larghezza
        /// dipende dai tubi e il retro si sviluppa in direzione opposta alle
        /// partenze. Non modifica i file di input.
        /// </summary>
        public static void DisegnaCollettore(
            DxfDocument esecutivo,
            string pathGrafoRete,
            string nomePiano,
            double profondita = 0.10,
            double interasseTubi = 0.05,
            double margineLaterale = 0.05,
            double distanzaMandataRitornoPrimoTratto = 0.075)
        {
            if (esecutivo == null ||
                string.IsNullOrWhiteSpace(pathGrafoRete) ||
                string.IsNullOrWhiteSpace(nomePiano) ||
                profondita <= 0 ||
                interasseTubi <= 0 ||
                margineLaterale < 0 ||
                distanzaMandataRitornoPrimoTratto <= 0 ||
                !File.Exists(pathGrafoRete))
            {
                return;
            }

            XDocument grafo = XDocument.Load(pathGrafoRete);
            XElement piano = (
                grafo.Root?.Elements("Piano") ??
                Enumerable.Empty<XElement>())
                .FirstOrDefault(p => string.Equals(
                    (string)p.Attribute("Nome"),
                    nomePiano,
                    StringComparison.OrdinalIgnoreCase));
            if (piano == null)
                return;

            List<XElement> nodi = (
                piano.Element("Nodi")?.Elements("Nodo") ??
                Enumerable.Empty<XElement>())
                .ToList();
            int numeroCircuiti = nodi.Count(n => string.Equals(
                (string)n.Attribute("Tipo"),
                "IngressoLocale",
                StringComparison.OrdinalIgnoreCase));
            if (numeroCircuiti == 0)
                return;

            XElement nodoCollettore = nodi
                .Where(n => !string.Equals(
                    (string)n.Attribute("Tipo"),
                    "IngressoLocale",
                    StringComparison.OrdinalIgnoreCase))
                .OrderByDescending(n => LeggiIntero(n, "Grado"))
                .ThenBy(n => (string)n.Attribute("Id"))
                .FirstOrDefault();
            if (nodoCollettore == null ||
                !TryLeggiDouble(nodoCollettore, "X", out double x) ||
                !TryLeggiDouble(nodoCollettore, "Y", out double y))
            {
                return;
            }

            // Modificato da Codex per realizzare: dimensionare il frontale
            // con la distanza dimezzata propria del primo tratto di ciascuna
            // coppia, conservando l'interasse esistente fra i circuiti.
            double larghezza =
                (numeroCircuiti - 1) * 2.0 * interasseTubi +
                distanzaMandataRitornoPrimoTratto +
                margineLaterale * 2.0;
            (double direzioneX, double direzioneY) =
                CalcolaDirezioneFrontale(
                    esecutivo,
                    piano,
                    nodi,
                    nodoCollettore,
                    x,
                    y,
                    nomePiano);
            double tangenteX = -direzioneY;
            double tangenteY = direzioneX;

            string nomeLayer = $"{nomePiano}_Collettore_Output";
            Layer layer;
            if (esecutivo.Layers.Contains(nomeLayer))
            {
                layer = esecutivo.Layers[nomeLayer];
            }
            else
            {
                layer = new Layer(nomeLayer)
                {
                    Color = AciColor.Yellow,
                    Linetype = Linetype.Continuous
                };
                esecutivo.Layers.Add(layer);
            }

            double semiLarghezza = larghezza / 2.0;
            double fronteSinistroX = x + tangenteX * semiLarghezza;
            double fronteSinistroY = y + tangenteY * semiLarghezza;
            double fronteDestroX = x - tangenteX * semiLarghezza;
            double fronteDestroY = y - tangenteY * semiLarghezza;
            double retroSinistroX =
                fronteSinistroX - direzioneX * profondita;
            double retroSinistroY =
                fronteSinistroY - direzioneY * profondita;
            double retroDestroX =
                fronteDestroX - direzioneX * profondita;
            double retroDestroY =
                fronteDestroY - direzioneY * profondita;

            var vertici = new List<LwPolylineVertex>
            {
                new LwPolylineVertex(fronteSinistroX, fronteSinistroY),
                new LwPolylineVertex(fronteDestroX, fronteDestroY),
                new LwPolylineVertex(retroDestroX, retroDestroY),
                new LwPolylineVertex(retroSinistroX, retroSinistroY)
            };

            var rettangolo = new LwPolyline(vertici)
            {
                IsClosed = true,
                Layer = layer,
                Color = AciColor.Yellow,
                Linetype = Linetype.Continuous
            };

            esecutivo.AddEntity(rettangolo);
        }

        /// <summary>
        /// Sposta, esclusivamente nell'SVG in memoria usato dall'esecutivo,
        /// le partenze di mandata e ritorno su attacchi ordinati del frontale.
        /// </summary>
        public static void DisponiTubiSulCollettore(
            DxfDocument esecutivo,
            XDocument svg,
            string pathGrafoRete,
            string nomePiano,
            double interasseTubi = 0.05,
            double margineLaterale = 0.05,
            double distanzaRitornoPrimoTratto = 0.075,
            double distanzaRitornoNormale = 0.15)
        {
            if (esecutivo == null ||
                svg == null ||
                string.IsNullOrWhiteSpace(pathGrafoRete) ||
                string.IsNullOrWhiteSpace(nomePiano) ||
                interasseTubi <= 0 ||
                margineLaterale < 0 ||
                distanzaRitornoPrimoTratto <= 0 ||
                distanzaRitornoNormale <= 0 ||
                !File.Exists(pathGrafoRete))
            {
                return;
            }

            XDocument grafo = XDocument.Load(pathGrafoRete);
            XElement piano = (
                grafo.Root?.Elements("Piano") ??
                Enumerable.Empty<XElement>())
                .FirstOrDefault(p => string.Equals(
                    (string)p.Attribute("Nome"),
                    nomePiano,
                    StringComparison.OrdinalIgnoreCase));
            if (piano == null)
                return;

            List<XElement> nodi = (
                piano.Element("Nodi")?.Elements("Nodo") ??
                Enumerable.Empty<XElement>())
                .ToList();
            int numeroCircuiti = nodi.Count(n => string.Equals(
                (string)n.Attribute("Tipo"),
                "IngressoLocale",
                StringComparison.OrdinalIgnoreCase));
            XElement nodoCollettore = nodi
                .Where(n => !string.Equals(
                    (string)n.Attribute("Tipo"),
                    "IngressoLocale",
                    StringComparison.OrdinalIgnoreCase))
                .OrderByDescending(n => LeggiIntero(n, "Grado"))
                .ThenBy(n => (string)n.Attribute("Id"))
                .FirstOrDefault();

            if (numeroCircuiti == 0 ||
                nodoCollettore == null ||
                !TryLeggiDouble(nodoCollettore, "X", out double x) ||
                !TryLeggiDouble(nodoCollettore, "Y", out double y))
            {
                return;
            }

            (double direzioneX, double direzioneY) =
                CalcolaDirezioneFrontale(
                    esecutivo,
                    piano,
                    nodi,
                    nodoCollettore,
                    x,
                    y,
                    nomePiano);
            double tangenteX = -direzioneY;
            double tangenteY = direzioneX;
            // Modificato da Codex per realizzare: ogni coppia parte dal
            // collettore a metà della distanza normale; i centri dei circuiti
            // mantengono l'interasse già adottato.
            double larghezza =
                (numeroCircuiti - 1) * 2.0 * interasseTubi +
                distanzaRitornoPrimoTratto +
                margineLaterale * 2.0;
            double primoAttacco = -larghezza / 2.0 + margineLaterale;

            XNamespace ns = "http://www.w3.org/2000/svg";
            var mandate = new List<(
                XElement Elemento,
                bool SpostaPrimo,
                double DirezioneX,
                double DirezioneY,
                double PuntoSuccessivoX,
                double PuntoSuccessivoY,
                string IngressoId,
                double Ordine)>();

            foreach (XElement linea in svg.Descendants(ns + "line")
                .Where(e => string.Equals(
                    (string)e.Attribute("stroke"),
                    "red",
                    StringComparison.OrdinalIgnoreCase)))
            {
                if (!TryLeggiDouble(linea, "x1", out double x1) ||
                    !TryLeggiDouble(linea, "y1", out double y1) ||
                    !TryLeggiDouble(linea, "x2", out double x2) ||
                    !TryLeggiDouble(linea, "y2", out double y2))
                {
                    continue;
                }

                bool primoSulCollettore =
                    Distanza(x1, y1, x, y) <= 0.001;
                bool secondoSulCollettore =
                    Distanza(x2, y2, x, y) <= 0.001;
                if (!primoSulCollettore && !secondoSulCollettore)
                    continue;

                double altroX = primoSulCollettore ? x2 : x1;
                double altroY = primoSulCollettore ? y2 : y1;
                double dx = altroX - x;
                double dy = altroY - y;
                double modulo = Math.Sqrt(dx * dx + dy * dy);
                if (modulo <= 0.000001)
                    continue;

                dx /= modulo;
                dy /= modulo;
                string ingressoId = TrovaIngressoDelRamo(
                    piano,
                    nodi,
                    nodoCollettore,
                    altroX,
                    altroY);
                mandate.Add((
                    linea,
                    primoSulCollettore,
                    dx,
                    dy,
                    altroX,
                    altroY,
                    ingressoId,
                    dx * tangenteX + dy * tangenteY));
            }

            var ritorni = svg.Descendants(ns + "polyline")
                .Where(e =>
                    string.Equals(
                        (string)e.Attribute("stroke"),
                        "blue",
                        StringComparison.OrdinalIgnoreCase) &&
                    string.Equals(
                        (string)e.Attribute("data-termodel"),
                        "ritorno-collegamento",
                        StringComparison.OrdinalIgnoreCase))
                .Select(e => (
                    Elemento: e,
                    IngressoId:
                        (string)e.Attribute("data-ingresso") ?? string.Empty,
                    Punti: LeggiPunti((string)e.Attribute("points"))))
                .Where(r => r.Punti.Count >= 2)
                .ToList();
            var ritorniUsati = new HashSet<XElement>();

            List<(XElement Elemento, bool SpostaPrimo,
                double DirezioneX, double DirezioneY,
                double PuntoSuccessivoX, double PuntoSuccessivoY,
                string IngressoId,
                double Ordine)>
                mandateOrdinate = mandate
                    .OrderBy(m => m.Ordine)
                    .Take(numeroCircuiti)
                    .ToList();

            for (int i = 0; i < mandateOrdinate.Count; i++)
            {
                var mandata = mandateOrdinate[i];
                double posizioneBassa =
                    primoAttacco + i * 2 * interasseTubi;
                double posizioneAlta =
                    posizioneBassa + distanzaRitornoPrimoTratto;
                double normaleDestraX = mandata.DirezioneY;
                double normaleDestraY = -mandata.DirezioneX;
                bool ritornoVersoTangentePositiva =
                    normaleDestraX * tangenteX +
                    normaleDestraY * tangenteY >= 0;
                double posizioneMandata = ritornoVersoTangentePositiva
                    ? posizioneBassa
                    : posizioneAlta;
                double posizioneRitorno = ritornoVersoTangentePositiva
                    ? posizioneAlta
                    : posizioneBassa;
                double xMandata = x + tangenteX * posizioneMandata;
                double yMandata = y + tangenteY * posizioneMandata;
                double xRitorno = x + tangenteX * posizioneRitorno;
                double yRitorno = y + tangenteY * posizioneRitorno;

                if (mandata.SpostaPrimo)
                {
                    ImpostaDouble(mandata.Elemento, "x1", xMandata);
                    ImpostaDouble(mandata.Elemento, "y1", yMandata);
                }
                else
                {
                    ImpostaDouble(mandata.Elemento, "x2", xMandata);
                    ImpostaDouble(mandata.Elemento, "y2", yMandata);
                }

                double nuovaDirezioneX =
                    mandata.PuntoSuccessivoX - xMandata;
                double nuovaDirezioneY =
                    mandata.PuntoSuccessivoY - yMandata;
                double moduloNuovaDirezione = Math.Sqrt(
                    nuovaDirezioneX * nuovaDirezioneX +
                    nuovaDirezioneY * nuovaDirezioneY);
                if (moduloNuovaDirezione > 0.000001)
                {
                    nuovaDirezioneX /= moduloNuovaDirezione;
                    nuovaDirezioneY /= moduloNuovaDirezione;
                }
                else
                {
                    nuovaDirezioneX = mandata.DirezioneX;
                    nuovaDirezioneY = mandata.DirezioneY;
                }

                double attesoX =
                    xMandata +
                    nuovaDirezioneY * distanzaRitornoPrimoTratto;
                double attesoY =
                    yMandata -
                    nuovaDirezioneX * distanzaRitornoPrimoTratto;
                var ritorniDisponibili = ritorni
                    .Where(r => !ritorniUsati.Contains(r.Elemento))
                    .ToList();
                var ritorniStessoIngresso = ritorniDisponibili
                    .Where(r =>
                        !string.IsNullOrWhiteSpace(mandata.IngressoId) &&
                        string.Equals(
                            r.IngressoId,
                            mandata.IngressoId,
                            StringComparison.OrdinalIgnoreCase))
                    .ToList();
                var ritorno = (
                    ritorniStessoIngresso.Count > 0
                        ? ritorniStessoIngresso
                        : ritorniDisponibili)
                    .Select(r =>
                    {
                        double distanzaPrimo = Distanza(
                            r.Punti[0].X,
                            r.Punti[0].Y,
                            attesoX,
                            attesoY);
                        int ultimo = r.Punti.Count - 1;
                        double distanzaUltimo = Distanza(
                            r.Punti[ultimo].X,
                            r.Punti[ultimo].Y,
                            attesoX,
                            attesoY);
                        return (
                            r.Elemento,
                            r.Punti,
                            SpostaPrimo: distanzaPrimo <= distanzaUltimo,
                            Distanza: Math.Min(
                                distanzaPrimo,
                                distanzaUltimo));
                    })
                    .OrderBy(r => r.Distanza)
                    .FirstOrDefault();

                if (ritorno.Elemento == null)
                    continue;

                List<(double X, double Y)> percorsoMandata =
                    TrovaPercorsoCircuito(
                        piano,
                        nodi,
                        nodoCollettore,
                        mandata.IngressoId);

                // Modificato da Codex per realizzare: conservare anche
                // nell'esecutivo il lato del ritorno scelto da
                // TubiCollegamento. La ricostruzione precedente imponeva
                // sempre il lato destro e poteva attraversare altri rami.
                double segnoLatoRitorno = DeterminaSegnoLatoRitorno(
                    percorsoMandata,
                    ritorno.Punti);
                if (segnoLatoRitorno < 0)
                {
                    double scambioX = xMandata;
                    double scambioY = yMandata;
                    xMandata = xRitorno;
                    yMandata = yRitorno;
                    xRitorno = scambioX;
                    yRitorno = scambioY;

                    if (mandata.SpostaPrimo)
                    {
                        ImpostaDouble(mandata.Elemento, "x1", xMandata);
                        ImpostaDouble(mandata.Elemento, "y1", yMandata);
                    }
                    else
                    {
                        ImpostaDouble(mandata.Elemento, "x2", xMandata);
                        ImpostaDouble(mandata.Elemento, "y2", yMandata);
                    }
                }

                ritorniUsati.Add(ritorno.Elemento);

                if (percorsoMandata.Count >= 2)
                {
                    percorsoMandata[0] = (xMandata, yMandata);
                    List<(double X, double Y)> nuovoRitorno =
                        CreaRitornoParallelo(
                            percorsoMandata,
                            (xRitorno, yRitorno),
                            distanzaRitornoNormale * segnoLatoRitorno);

                    // Quando presente, il primo punto appartiene al rientro
                    // della spirale di Vittorio e deve essere conservato.
                    if (ritorno.Punti.Count > percorsoMandata.Count)
                        nuovoRitorno.Insert(0, ritorno.Punti[0]);

                    ritorno.Punti.Clear();
                    ritorno.Punti.AddRange(nuovoRitorno);
                }
                ritorno.Elemento.SetAttributeValue(
                    "points",
                    ScriviPunti(ritorno.Punti));
            }
        }

        private static string TrovaIngressoDelRamo(
            XElement piano,
            List<XElement> nodi,
            XElement nodoCollettore,
            double xRamo,
            double yRamo)
        {
            string idCollettore =
                (string)nodoCollettore.Attribute("Id") ?? string.Empty;
            var nodiValidi = nodi
                .Where(n => !string.IsNullOrWhiteSpace(
                    (string)n.Attribute("Id")))
                .ToList();
            XElement nodoRamo = nodiValidi
                .Where(n =>
                    TryLeggiDouble(n, "X", out _) &&
                    TryLeggiDouble(n, "Y", out _))
                .OrderBy(n =>
                {
                    TryLeggiDouble(n, "X", out double nx);
                    TryLeggiDouble(n, "Y", out double ny);
                    return Distanza(nx, ny, xRamo, yRamo);
                })
                .FirstOrDefault();
            string idRamo = (string)nodoRamo?.Attribute("Id");
            if (string.IsNullOrWhiteSpace(idRamo))
                return string.Empty;

            var adiacenze = new Dictionary<string, List<string>>(
                StringComparer.OrdinalIgnoreCase);
            foreach (XElement tratto in
                piano.Element("Tratti")?.Elements("Tratto") ??
                Enumerable.Empty<XElement>())
            {
                string da = (string)tratto.Attribute("Da");
                string a = (string)tratto.Attribute("A");
                if (string.IsNullOrWhiteSpace(da) ||
                    string.IsNullOrWhiteSpace(a))
                {
                    continue;
                }

                if (!adiacenze.TryGetValue(da, out List<string> daVicini))
                {
                    daVicini = new List<string>();
                    adiacenze[da] = daVicini;
                }
                if (!adiacenze.TryGetValue(a, out List<string> aVicini))
                {
                    aVicini = new List<string>();
                    adiacenze[a] = aVicini;
                }
                daVicini.Add(a);
                aVicini.Add(da);
            }

            var coda = new Queue<string>();
            var visitati = new HashSet<string>(
                StringComparer.OrdinalIgnoreCase)
            {
                idCollettore
            };
            coda.Enqueue(idRamo);

            while (coda.Count > 0)
            {
                string corrente = coda.Dequeue();
                if (!visitati.Add(corrente))
                    continue;

                XElement nodo = nodiValidi.FirstOrDefault(n =>
                    string.Equals(
                        (string)n.Attribute("Id"),
                        corrente,
                        StringComparison.OrdinalIgnoreCase));
                if (nodo != null &&
                    string.Equals(
                        (string)nodo.Attribute("Tipo"),
                        "IngressoLocale",
                        StringComparison.OrdinalIgnoreCase))
                {
                    return corrente;
                }

                if (!adiacenze.TryGetValue(
                    corrente,
                    out List<string> vicini))
                {
                    continue;
                }

                foreach (string vicino in vicini)
                {
                    if (!visitati.Contains(vicino))
                        coda.Enqueue(vicino);
                }
            }

            return string.Empty;
        }

        private static List<(double X, double Y)> TrovaPercorsoCircuito(
            XElement piano,
            List<XElement> nodi,
            XElement nodoCollettore,
            string ingressoId)
        {
            string collettoreId =
                (string)nodoCollettore.Attribute("Id") ?? string.Empty;
            if (string.IsNullOrWhiteSpace(collettoreId) ||
                string.IsNullOrWhiteSpace(ingressoId))
            {
                return new List<(double X, double Y)>();
            }

            var nodiPerId = nodi
                .Where(n => !string.IsNullOrWhiteSpace(
                    (string)n.Attribute("Id")))
                .ToDictionary(
                    n => (string)n.Attribute("Id"),
                    StringComparer.OrdinalIgnoreCase);
            var adiacenze = new Dictionary<string, List<string>>(
                StringComparer.OrdinalIgnoreCase);

            foreach (XElement tratto in
                piano.Element("Tratti")?.Elements("Tratto") ??
                Enumerable.Empty<XElement>())
            {
                string da = (string)tratto.Attribute("Da");
                string a = (string)tratto.Attribute("A");
                if (string.IsNullOrWhiteSpace(da) ||
                    string.IsNullOrWhiteSpace(a))
                {
                    continue;
                }

                if (!adiacenze.TryGetValue(da, out List<string> daVicini))
                    adiacenze[da] = daVicini = new List<string>();
                if (!adiacenze.TryGetValue(a, out List<string> aVicini))
                    adiacenze[a] = aVicini = new List<string>();
                daVicini.Add(a);
                aVicini.Add(da);
            }

            var coda = new Queue<string>();
            var visitati = new HashSet<string>(
                StringComparer.OrdinalIgnoreCase);
            var precedente = new Dictionary<string, string>(
                StringComparer.OrdinalIgnoreCase);
            coda.Enqueue(collettoreId);
            visitati.Add(collettoreId);

            while (coda.Count > 0)
            {
                string corrente = coda.Dequeue();
                if (string.Equals(
                    corrente,
                    ingressoId,
                    StringComparison.OrdinalIgnoreCase))
                {
                    break;
                }

                if (!adiacenze.TryGetValue(
                    corrente,
                    out List<string> vicini))
                {
                    continue;
                }

                foreach (string vicino in vicini)
                {
                    if (!visitati.Add(vicino))
                        continue;

                    precedente[vicino] = corrente;
                    coda.Enqueue(vicino);
                }
            }

            if (!visitati.Contains(ingressoId))
                return new List<(double X, double Y)>();

            var ids = new List<string> { ingressoId };
            string id = ingressoId;
            while (!string.Equals(
                id,
                collettoreId,
                StringComparison.OrdinalIgnoreCase))
            {
                id = precedente[id];
                ids.Add(id);
            }
            ids.Reverse();

            var risultato = new List<(double X, double Y)>();
            foreach (string nodoId in ids)
            {
                if (!nodiPerId.TryGetValue(
                    nodoId,
                    out XElement nodo) ||
                    !TryLeggiDouble(nodo, "X", out double x) ||
                    !TryLeggiDouble(nodo, "Y", out double y))
                {
                    return new List<(double X, double Y)>();
                }
                risultato.Add((x, y));
            }

            return risultato;
        }

        private static List<(double X, double Y)> CreaRitornoParallelo(
            List<(double X, double Y)> mandata,
            (double X, double Y) attaccoRitorno,
            double distanzaRitorno)
        {
            var segmenti = new List<(
                double X0,
                double Y0,
                double X1,
                double Y1)>();

            for (int i = 0; i < mandata.Count - 1; i++)
            {
                double dx = mandata[i + 1].X - mandata[i].X;
                double dy = mandata[i + 1].Y - mandata[i].Y;
                double lunghezza = Math.Sqrt(dx * dx + dy * dy);
                if (lunghezza <= 0.000001)
                    continue;

                if (i == 0)
                {
                    segmenti.Add((
                        attaccoRitorno.X,
                        attaccoRitorno.Y,
                        attaccoRitorno.X + dx,
                        attaccoRitorno.Y + dy));
                }
                else
                {
                    double normaleX = dy / lunghezza;
                    double normaleY = -dx / lunghezza;
                    segmenti.Add((
                        mandata[i].X + normaleX * distanzaRitorno,
                        mandata[i].Y + normaleY * distanzaRitorno,
                        mandata[i + 1].X + normaleX * distanzaRitorno,
                        mandata[i + 1].Y + normaleY * distanzaRitorno));
                }
            }

            if (segmenti.Count == 0)
                return new List<(double X, double Y)>();

            var parallela = new List<(double X, double Y)>
            {
                (segmenti[0].X0, segmenti[0].Y0)
            };

            for (int i = 1; i < segmenti.Count; i++)
            {
                parallela.Add(IntersezioneRette(
                    segmenti[i - 1],
                    segmenti[i]));
            }

            var ultimo = segmenti[segmenti.Count - 1];
            parallela.Add((ultimo.X1, ultimo.Y1));
            parallela.Reverse();
            return parallela;
        }

        // Funzione realizzata da Codex in autonomia
        private static double DeterminaSegnoLatoRitorno(
            IReadOnlyList<(double X, double Y)> mandata,
            IReadOnlyList<(double X, double Y)> ritorno)
        {
            if (mandata == null ||
                mandata.Count < 2 ||
                ritorno == null ||
                ritorno.Count < 2)
            {
                return 1.0;
            }

            (double X, double Y) origine = mandata[0];
            int indiceSuccessivo = 1;
            while (indiceSuccessivo < mandata.Count &&
                Distanza(
                    origine.X,
                    origine.Y,
                    mandata[indiceSuccessivo].X,
                    mandata[indiceSuccessivo].Y) <= 0.000001)
            {
                indiceSuccessivo++;
            }

            if (indiceSuccessivo >= mandata.Count)
                return 1.0;

            (double X, double Y) estremoPrimo = ritorno[0];
            (double X, double Y) estremoUltimo = ritorno[ritorno.Count - 1];
            (double X, double Y) estremoCollettore =
                Distanza(
                    origine.X,
                    origine.Y,
                    estremoPrimo.X,
                    estremoPrimo.Y) <=
                Distanza(
                    origine.X,
                    origine.Y,
                    estremoUltimo.X,
                    estremoUltimo.Y)
                    ? estremoPrimo
                    : estremoUltimo;

            double direzioneX =
                mandata[indiceSuccessivo].X - origine.X;
            double direzioneY =
                mandata[indiceSuccessivo].Y - origine.Y;
            double scostamentoX = estremoCollettore.X - origine.X;
            double scostamentoY = estremoCollettore.Y - origine.Y;
            double prodottoVettoriale =
                direzioneX * scostamentoY -
                direzioneY * scostamentoX;

            // SpostaADestra usa la normale (dy, -dx): il prodotto
            // vettoriale negativo identifica quindi il lato destro.
            return prodottoVettoriale > 0.000000001 ? -1.0 : 1.0;
        }

        private static (double X, double Y) IntersezioneRette(
            (double X0, double Y0, double X1, double Y1) a,
            (double X0, double Y0, double X1, double Y1) b)
        {
            double ax = a.X1 - a.X0;
            double ay = a.Y1 - a.Y0;
            double bx = b.X1 - b.X0;
            double by = b.Y1 - b.Y0;
            double denominatore = ax * by - ay * bx;
            if (Math.Abs(denominatore) <= 0.000000001)
                return (b.X0, b.Y0);

            double cx = b.X0 - a.X0;
            double cy = b.Y0 - a.Y0;
            double parametro = (cx * by - cy * bx) / denominatore;
            return (
                a.X0 + parametro * ax,
                a.Y0 + parametro * ay);
        }

        private static (double X, double Y) CalcolaDirezioneFrontale(
            DxfDocument esecutivo,
            XElement piano,
            List<XElement> nodi,
            XElement nodoCollettore,
            double xCollettore,
            double yCollettore,
            string nomePiano)
        {
            string idCollettore =
                (string)nodoCollettore.Attribute("Id") ?? string.Empty;
            Dictionary<string, XElement> nodiPerId = nodi
                .Where(n => !string.IsNullOrWhiteSpace(
                    (string)n.Attribute("Id")))
                .ToDictionary(
                    n => (string)n.Attribute("Id"),
                    StringComparer.OrdinalIgnoreCase);

            var direzioniTubi = new List<(double X, double Y)>();

            foreach (XElement tratto in
                piano.Element("Tratti")?.Elements("Tratto") ??
                Enumerable.Empty<XElement>())
            {
                string idDa = (string)tratto.Attribute("Da");
                string idA = (string)tratto.Attribute("A");
                string idAltro = string.Equals(
                    idDa,
                    idCollettore,
                    StringComparison.OrdinalIgnoreCase)
                    ? idA
                    : string.Equals(
                        idA,
                        idCollettore,
                        StringComparison.OrdinalIgnoreCase)
                        ? idDa
                        : null;

                if (string.IsNullOrWhiteSpace(idAltro) ||
                    !nodiPerId.TryGetValue(idAltro, out XElement altro) ||
                    !TryLeggiDouble(altro, "X", out double xAltro) ||
                    !TryLeggiDouble(altro, "Y", out double yAltro))
                {
                    continue;
                }

                double dx = xAltro - xCollettore;
                double dy = yAltro - yCollettore;
                double lunghezza = Math.Sqrt(dx * dx + dy * dy);
                if (lunghezza <= 0.000001)
                    continue;

                direzioniTubi.Add((dx / lunghezza, dy / lunghezza));
            }

            (double tangenteX, double tangenteY) =
                TrovaTangenteParetePiuVicina(
                    esecutivo,
                    xCollettore,
                    yCollettore,
                    $"{nomePiano}_Edificio_Output");
            double normaleX = -tangenteY;
            double normaleY = tangenteX;

            int latoPositivo = direzioniTubi.Count(d =>
                d.X * normaleX + d.Y * normaleY >= 0);
            int latoNegativo = direzioniTubi.Count - latoPositivo;

            if (latoPositivo == latoNegativo)
            {
                double sommaProiezioni = direzioniTubi.Sum(d =>
                    d.X * normaleX + d.Y * normaleY);
                if (sommaProiezioni < 0)
                {
                    normaleX = -normaleX;
                    normaleY = -normaleY;
                }
            }
            else if (latoNegativo > latoPositivo)
            {
                normaleX = -normaleX;
                normaleY = -normaleY;
            }

            return (normaleX, normaleY);
        }

        private static (double X, double Y) TrovaTangenteParetePiuVicina(
            DxfDocument documento,
            double x,
            double y,
            string nomeLayerEdificio)
        {
            double distanzaMigliore = double.PositiveInfinity;
            double tangenteX = 1;
            double tangenteY = 0;

            void ValutaSegmento(double x0, double y0, double x1, double y1)
            {
                double dx = x1 - x0;
                double dy = y1 - y0;
                double lunghezzaQuadrata = dx * dx + dy * dy;
                if (lunghezzaQuadrata <= 0.000000000001)
                    return;

                double parametro =
                    ((x - x0) * dx + (y - y0) * dy) /
                    lunghezzaQuadrata;
                parametro = Math.Max(0, Math.Min(1, parametro));
                double proiezioneX = x0 + parametro * dx;
                double proiezioneY = y0 + parametro * dy;
                double distanza = Distanza(
                    x,
                    y,
                    proiezioneX,
                    proiezioneY);
                if (distanza >= distanzaMigliore)
                    return;

                double lunghezza = Math.Sqrt(lunghezzaQuadrata);
                tangenteX = dx / lunghezza;
                tangenteY = dy / lunghezza;
                if (tangenteX < 0 ||
                    (Math.Abs(tangenteX) <= 0.000001 && tangenteY < 0))
                {
                    tangenteX = -tangenteX;
                    tangenteY = -tangenteY;
                }

                distanzaMigliore = distanza;
            }

            foreach (Line linea in documento.Lines.Where(l =>
                string.Equals(
                    l.Layer?.Name,
                    nomeLayerEdificio,
                    StringComparison.OrdinalIgnoreCase)))
            {
                ValutaSegmento(
                    linea.StartPoint.X,
                    linea.StartPoint.Y,
                    linea.EndPoint.X,
                    linea.EndPoint.Y);
            }

            foreach (LwPolyline polilinea in documento.LwPolylines.Where(p =>
                string.Equals(
                    p.Layer?.Name,
                    nomeLayerEdificio,
                    StringComparison.OrdinalIgnoreCase)))
            {
                int numeroVertici = polilinea.Vertexes.Count;
                int numeroSegmenti = polilinea.IsClosed
                    ? numeroVertici
                    : numeroVertici - 1;
                for (int i = 0; i < numeroSegmenti; i++)
                {
                    LwPolylineVertex p0 = polilinea.Vertexes[i];
                    LwPolylineVertex p1 =
                        polilinea.Vertexes[(i + 1) % numeroVertici];
                    ValutaSegmento(
                        p0.Position.X,
                        p0.Position.Y,
                        p1.Position.X,
                        p1.Position.Y);
                }
            }

            return (tangenteX, tangenteY);
        }

        private static List<(double X, double Y)> LeggiPunti(string points)
        {
            var risultato = new List<(double X, double Y)>();
            if (string.IsNullOrWhiteSpace(points))
                return risultato;

            foreach (string coppia in points.Split(
                new[] { ' ', '\t', '\r', '\n' },
                StringSplitOptions.RemoveEmptyEntries))
            {
                string[] coordinate = coppia.Split(',');
                if (coordinate.Length == 2 &&
                    double.TryParse(
                        coordinate[0],
                        NumberStyles.Float,
                        CultureInfo.InvariantCulture,
                        out double x) &&
                    double.TryParse(
                        coordinate[1],
                        NumberStyles.Float,
                        CultureInfo.InvariantCulture,
                        out double y))
                {
                    risultato.Add((x, y));
                }
            }

            return risultato;
        }

        private static string ScriviPunti(
            IEnumerable<(double X, double Y)> punti)
        {
            return string.Join(
                " ",
                punti.Select(p =>
                    $"{p.X.ToString(CultureInfo.InvariantCulture)}," +
                    $"{p.Y.ToString(CultureInfo.InvariantCulture)}"));
        }

        private static double Distanza(
            double x1,
            double y1,
            double x2,
            double y2)
        {
            double dx = x2 - x1;
            double dy = y2 - y1;
            return Math.Sqrt(dx * dx + dy * dy);
        }

        private static void ImpostaDouble(
            XElement elemento,
            string attributo,
            double valore)
        {
            elemento.SetAttributeValue(
                attributo,
                valore.ToString(CultureInfo.InvariantCulture));
        }

        private static bool TryLeggiDouble(
            XElement elemento,
            string attributo,
            out double valore)
        {
            return double.TryParse(
                (string)elemento.Attribute(attributo),
                NumberStyles.Float,
                CultureInfo.InvariantCulture,
                out valore);
        }

        private static int LeggiIntero(XElement elemento, string attributo)
        {
            return int.TryParse(
                (string)elemento.Attribute(attributo),
                NumberStyles.Integer,
                CultureInfo.InvariantCulture,
                out int valore)
                ? valore
                : 0;
        }
    }
}
