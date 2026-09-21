using System;

using System.Collections.Generic;
using System.Globalization;
using System.Xml.Linq;
using NetTopologySuite;
using NetTopologySuite.Geometries;

public static class Pannelli_Radianti
{
    /// <summary>
    /// Dati minimi per descrivere un locale ai fini dei pannelli radianti.
    /// Adatta/collega questa classe alle tue strutture esistenti.
    /// </summary>
    public class LocalePannelli
    {
        public string Id { get; set; }              // es: "L01"
        public string Nome { get; set; }            // es: "Soggiorno"

        /// <summary>
        /// Perimetro interno del locale (poligono 2D in pianta).
        /// Si usa l'ExteriorRing; eventuali fori si possono aggiungere più avanti.
        /// </summary>
        public Polygon PerimetroInterno { get; set; }

        public int NumeroCircuiti { get; set; }     // es: 1, 2, 3...
        public double DiametroTubo_mm { get; set; } // es: 16.0
    }

    /// <summary>
    /// Crea l'XDocument XML da passare alla DLL di Vittorio
    /// partendo dall'elenco dei locali.
    /// </summary>
    public static XDocument OutputXmlPerPannelli(IEnumerable<LocalePannelli> locali, string versione = "1.0")
    {
        if (locali == null) throw new ArgumentNullException(nameof(locali));

        var inv = CultureInfo.InvariantCulture;

        var root = new XElement("ImpiantoPannelli",
            new XAttribute("Versione", versione)
        );

        foreach (var locale in locali)
        {
            if (locale == null) continue;

            var xLocale = new XElement("Locale",
                new XAttribute("Id", locale.Id ?? string.Empty),
                new XAttribute("Nome", locale.Nome ?? string.Empty)
            );

            // --- Geometria: perimetro interno ---
            var xGeometria = new XElement("Geometria");
            var xPerimetro = new XElement("Perimetro");

            if (locale.PerimetroInterno != null)
            {
                // ExteriorRing contiene la spezzata del perimetro (ultimo punto = primo)
                var coords = locale.PerimetroInterno.ExteriorRing.Coordinates;

                foreach (var c in coords)
                {
                    xPerimetro.Add(
                        new XElement("Punto",
                            new XAttribute("X", c.X.ToString(inv)),
                            new XAttribute("Y", c.Y.ToString(inv))
                        )
                    );
                }
            }

            xGeometria.Add(xPerimetro);
            xLocale.Add(xGeometria);

            // --- Dati impiantistici di base ---
            var xDatiImpianto = new XElement("DatiImpianto",
                new XAttribute("NumeroCircuiti", locale.NumeroCircuiti),
                new XAttribute("DiametroTubo_mm", locale.DiametroTubo_mm.ToString(inv))
            );

            xLocale.Add(xDatiImpianto);

            root.Add(xLocale);
        }

        var doc = new XDocument(
            new XDeclaration("1.0", "utf-8", "yes"),
            root
        );

        return doc;
    }

    /// <summary>
    /// Comodo wrapper per salvare direttamente su file.
    /// </summary>
    public static void SalvaXmlPerPannelli(IEnumerable<LocalePannelli> locali, string filePath, string versione = "1.0")
    {
        var doc = OutputXmlPerPannelli(locali, versione);
        doc.Save(filePath);
    }
    /// <summary>
    /// Da condividere con Vittorio
    /// </summary>
    public static class LeggiXMLPannelli
    {
        // GeometryFactory riutilizzabile per tutti i poligoni
        private static readonly GeometryFactory _geomFactory =
            NtsGeometryServices.Instance.CreateGeometryFactory();

        /// <summary>
        /// Legge il file XML dei pannelli radianti e ricostruisce
        /// la lista di LocalePannelli con perimetro come Polygon NTS.
        /// </summary>
        public static List<Pannelli_Radianti.LocalePannelli> CaricaDaFile(string filePath)
        {
            if (filePath == null) throw new ArgumentNullException(nameof(filePath));

            var inv = CultureInfo.InvariantCulture;
            var doc = XDocument.Load(filePath);

            var result = new List<Pannelli_Radianti.LocalePannelli>();

            var root = doc.Root;
            if (root == null || root.Name != "ImpiantoPannelli")
                throw new InvalidOperationException("XML non valido: nodo radice 'ImpiantoPannelli' mancante.");

            foreach (var xLocale in root.Elements("Locale"))
            {
                var locale = new Pannelli_Radianti.LocalePannelli();

                // Attributi del locale
                locale.Id = (string)xLocale.Attribute("Id") ?? string.Empty;
                locale.Nome = (string)xLocale.Attribute("Nome") ?? string.Empty;

                // --- Geometria / Perimetro ---
                var xGeometria = xLocale.Element("Geometria");
                var xPerimetro = xGeometria?.Element("Perimetro");

                Polygon poligono = null;

                if (xPerimetro != null)
                {
                    var coordList = new List<Coordinate>();

                    foreach (var xPunto in xPerimetro.Elements("Punto"))
                    {
                        var attrX = xPunto.Attribute("X")?.Value;
                        var attrY = xPunto.Attribute("Y")?.Value;

                        if (attrX == null || attrY == null)
                            continue; // oppure lanciare eccezione se vuoi XML “rigido”

                        var x = double.Parse(attrX, inv);
                        var y = double.Parse(attrY, inv);

                        coordList.Add(new Coordinate(x, y));
                    }

                    // Per fare un Polygon servono almeno 4 coordinate,
                    // con la prima uguale all'ultima.
                    if (coordList.Count >= 3)
                    {
                        // Chiude l'anello se non è già chiuso
                        var first = coordList[0];
                        var last = coordList[coordList.Count - 1];

                        if (!first.Equals2D(last))
                        {
                            coordList.Add(new Coordinate(first.X, first.Y));
                        }

                        var ring = new LinearRing(coordList.ToArray());
                        poligono = new Polygon(ring);
                    }
                }

                locale.PerimetroInterno = poligono;

                // --- Dati impiantistici ---
                var xDatiImpianto = xLocale.Element("DatiImpianto");
                if (xDatiImpianto != null)
                {
                    // NumeroCircuiti (int)
                    var attrNumCirc = xDatiImpianto.Attribute("NumeroCircuiti")?.Value;
                    if (!string.IsNullOrWhiteSpace(attrNumCirc))
                    {
                        if (int.TryParse(attrNumCirc, NumberStyles.Integer, inv, out var numCirc))
                            locale.NumeroCircuiti = numCirc;
                    }

                    // DiametroTubo_mm (double)
                    var attrDiam = xDatiImpianto.Attribute("DiametroTubo_mm")?.Value;
                    if (!string.IsNullOrWhiteSpace(attrDiam))
                    {
                        if (double.TryParse(attrDiam, NumberStyles.Float | NumberStyles.AllowThousands, inv, out var diam))
                            locale.DiametroTubo_mm = diam;
                    }
                }

                result.Add(locale);
            }

            return result;
        }

        /// <summary>
        /// Comodo helper: restituisce solo la lista di Polygon NTS (perimetri),
        /// nell'ordine in cui compaiono nel file.
        /// </summary>
        public static List<Polygon> CaricaPerimetriDaFile(string filePath)
        {
            var locali = CaricaDaFile(filePath);
            var list = new List<Polygon>();

            foreach (var loc in locali)
            {
                if (loc.PerimetroInterno != null)
                    list.Add(loc.PerimetroInterno);
            }

            return list;
        }
    }
    /// <summary>
    /// Da condividere con Vittorio
    /// </summary>

}
