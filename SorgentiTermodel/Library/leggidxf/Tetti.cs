using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Xbim.Ifc;
using Xbim.Ifc4.Interfaces;
using Xbim.Ifc4.Kernel;
using Xbim.Ifc4.MeasureResource;
using Xbim.Ifc4.ProductExtension;
using Xbim.Ifc4.RepresentationResource;
using Xbim.Ifc4.GeometryResource;
using Xbim.Ifc4.GeometricConstraintResource;
using Xbim.Common.Step21;
using Xbim.Ifc4.SharedBldgElements;
using Xbim.Ifc4.ProfileResource;
using Xbim.Ifc4.GeometricModelResource;
using Xbim.Common.Geometry;
using Xbim.Ifc4.PresentationAppearanceResource;
using Xbim.Ifc4.PresentationDefinitionResource;
using Xbim.IO;
using static Termodel.Modello;
using NetTopologySuite.Geometries;
using System.Numerics;
using System.Diagnostics;
using static Polig3D;
using Termodel.utilities;
using System.Globalization;
using Microsoft.VisualBasic.Logging;

namespace Termodel.Leggidxf
{
    public class Tetti
    {
        public Tetti(Modello IstanzaModello)
        {
            //model = modello;
            ModelIstance = IstanzaModello;
            Linee2D = null;
        }
        public Tetti(Modello IstanzaModello,DXFLineCheck Linee_2D)
        {
            Linee2D = Linee_2D;
            ModelIstance = IstanzaModello;
        }
        public Modello ModelIstance;

        // Proprietà per memorizzare le linee 2D
        public DXFLineCheck Linee2D { get; set; }

        // Metodo per accedere a Lines2DCor dal Modello
        public DXFLineCheck Lines2DCor()
        {
            // Se Linee2D è stato già impostato, restituisce quello
            if (Linee2D != null)
            {
                return Linee2D;
            }

            // Altrimenti, restituisce Lines2DCor dall'istanza del modello, se disponibile
            return ModelIstance?.Lines2DCor;
        }
        //public IfcStore model;
        // public DXFLineCheck Lines2DCor;
        public List<Sced> scedList { get; set; } = new List<Sced>();

        public List<(double X, double Y, double Z)> ConvertIfcPolylineToCoordinateList3D(IfcPolyline polyline)
        {
            var coordinates = new List<(double X, double Y, double Z)>();

            // Verifica che la polilinea non sia nulla
            if (polyline != null && polyline.Points != null)
            {
                foreach (var point in polyline.Points)
                {
                    coordinates.Add((point.X, point.Y, point.Z));
                }
            }

            return coordinates;
        }
 
        public List<(double X, double Y)> ConvertToCoordinateList2D(NetTopologySuite.Geometries.Geometry geometry)
        {
            var coordinates = new List<(double X, double Y)>();

            // Verifica se la geometria è di tipo Polygon o LineString
            if (geometry is Polygon polygon)
            {
                foreach (var coordinate in polygon.Coordinates)
                {
                    coordinates.Add((coordinate.X, coordinate.Y));
                }
            }
            else if (geometry is LineString lineString)
            {
                foreach (var coordinate in lineString.Coordinates)
                {
                    coordinates.Add((coordinate.X, coordinate.Y));
                }
            }
            else if (geometry is MultiPolygon multiPolygon)
            {
                foreach (var poly in multiPolygon.Geometries)
                {
                    foreach (var coordinate in poly.Coordinates)
                    {
                        coordinates.Add((coordinate.X, coordinate.Y));
                    }
                }
            }
            else if (geometry is MultiLineString multiLineString)
            {
                foreach (var line in multiLineString.Geometries)
                {
                    foreach (var coordinate in line.Coordinates)
                    {
                        coordinates.Add((coordinate.X, coordinate.Y));
                    }
                }
            }

            return coordinates;
        }
        public double ZVertice(Coordinate verticeXY, List<LineaQuotata> lineeQuotate)
        {
            if (lineeQuotate.Count == 0) return double.NaN;
            // Cerca la linea quotata che contiene il vertice XY
            foreach (var linea in lineeQuotate)
            {
                // Verifica se il vertice XY coincide con uno dei due estremi della linea quotata usando UG_APR
                if ((UG_APR(linea.StartCoordinate.X, verticeXY.X) && UG_APR(linea.StartCoordinate.Y, verticeXY.Y)) ||
                    (UG_APR(linea.EndCoordinate.X, verticeXY.X) && UG_APR(linea.EndCoordinate.Y, verticeXY.Y)))
                {
                    // Se il vertice coincide con l'inizio della linea, restituisci la Z di inizio
                    if (UG_APR(linea.StartCoordinate.X, verticeXY.X) && UG_APR(linea.StartCoordinate.Y, verticeXY.Y))
                    {
                        return linea.StartZ;
                    }
                    // Se il vertice coincide con la fine della linea, restituisci la Z di fine
                    else if (UG_APR(linea.EndCoordinate.X, verticeXY.X) && UG_APR(linea.EndCoordinate.Y, verticeXY.Y))
                    {
                        return linea.EndZ;
                    }
                }
            }
           // Se non viene trovata alcuna corrispondenza, restituisci un valore che indichi errore o assenza di Z
            throw new InvalidOperationException("Vertice non trovato nelle linee quotate.");
        }
        /*
        public double ZVertice(Coordinate verticeXY, List<LineaQuotata> lineeQuotate)
        {
            // Cerca la linea quotata che contiene il vertice XY
            foreach (var linea in lineeQuotate)
            {
                // Verifica se il vertice XY coincide con uno dei due estremi della linea quotata
                if ((linea.StartCoordinate.X == verticeXY.X && linea.StartCoordinate.Y == verticeXY.Y) ||
                    (linea.EndCoordinate.X == verticeXY.X && linea.EndCoordinate.Y == verticeXY.Y))
                {
                    // Se il vertice coincide con l'inizio della linea, restituisci la Z di inizio
                    if (linea.StartCoordinate.X == verticeXY.X && linea.StartCoordinate.Y == verticeXY.Y)
                    {
                        return linea.StartZ;
                    }
                    // Se il vertice coincide con la fine della linea, restituisci la Z di fine
                    else if (linea.EndCoordinate.X == verticeXY.X && linea.EndCoordinate.Y == verticeXY.Y)
                    {
                        return linea.EndZ;
                    }
                }
            }

            // Se il vertice non è trovato nelle linee quotate, restituisci NaN
            return double.NaN;
        }
        */
        public void CorreggiSced(
        double l1z1, double l1z2,
        double l2z1, double l2z2,
        ref double C1z1, ref double C1z2,
        ref double C2z1, ref double C2z2,
        int caso)
        {
            switch (caso)
            {
                case 1: // StartStart
                        // Linea1 StartCoordinate coincide con Linea2 StartCoordinate
                    if (!UG_APR(l1z1 , l1z2)) // Se le z delle due coordinate non coincidono
                    {
                        C2z1 = l1z1; // Correggi la z della prima linea con la z valida
                        C2z2 = l1z1;


                    }
                    if (!UG_APR(l2z1 , l2z2)) // Se le z delle due coordinate finali non coincidono
                    {
                        C1z1 = l2z1; // Correggi la z della prima linea con la z valida
                        C1z2 = l2z1;
                    }
                    break;

                case 2: // StartEnd
                        // Linea1 StartCoordinate coincide con Linea2 EndCoordinate
                    if (!UG_APR(l1z1 , l1z2)) // Se le z delle due coordinate non coincidono
                    {
                        C2z1 = l1z1; // Correggi la z della prima linea con la z valida
                        C2z2 = l1z1;
                    }
                    if (!UG_APR(l2z1 , l2z2) )// Se le z delle due coordinate finali non coincidono
                    {
                        C1z1 = l2z2; // Correggi la z della prima linea con la z valida
                        C1z2 = l2z2;
                    }
                    break;

                case 3: // EndStart
                        // Linea1 EndCoordinate coincide con Linea2 StartCoordinate
                    if (!UG_APR(l1z1 , l1z2)) // Se le z delle due coordinate finali non coincidono
                    {
                        C2z1 = l1z2; // Correggi la z della seconda linea con la z valida
                        C2z2 = l1z2;
                    }
                    if (!UG_APR(l2z2 , l2z1) )// Se le z delle due coordinate non coincidono
                    {
                        C1z1 = l2z1; // Correggi la z della seconda linea con la z valida
                        C1z2 = l2z1;
                    }

                    break;

                case 4: // EndEnd
                        // Linea1 EndCoordinate coincide con Linea2 EndCoordinate
                    if (!UG_APR(l1z2 , l1z1)) // Se le z delle due coordinate non coincidono
                    {
                        C2z2 = l1z2; // Correggi la z della seconda linea con la z valida
                        C2z1 = l1z2;
                    }
                    if (!UG_APR(l2z1 , l2z2)) // Se le z delle due coordinate iniziali non coincidono
                    {
                        C1z2 = l2z2; // Correggi la z della seconda linea con la z valida
                        C1z1 = l2z2;
                    }
                    break;
            }
        }
        public bool UG_APR(double a, double b, double apr = 0.1)
        {
            return Math.Abs(a - b) <= apr;
        }
        public (List<Sced> scedList, List<LineaQuotata> lineeRettificate) TrovaSced(List<LineaQuotata> lineeQuotate)
        {
            //var scedList = new List<Sced>(); // Lista per memorizzare gli SCED identificati
            var lineeRettificate = new List<LineaQuotata>(lineeQuotate); // Crea una copia della lista di linee quotate

            // Cicla attraverso tutte le coppie di linee quotate
            for (int i = 0; i < lineeQuotate.Count; i++)
            {
                for (int j = i + 1; j < lineeQuotate.Count; j++)
                {
                    var linea1 = lineeQuotate[i];
                    var linea2 = lineeQuotate[j];

                    // Verifica se c'è almeno un vertice di linea1 che coincide con un vertice di linea2
                    /*
                    bool coincideStartStart = linea1.StartCoordinate.X == linea2.StartCoordinate.X &&
                                              linea1.StartCoordinate.Y == linea2.StartCoordinate.Y &&
                                              linea1.StartZ != linea2.StartZ;

                    bool coincideStartEnd = linea1.StartCoordinate.X == linea2.EndCoordinate.X &&
                                            linea1.StartCoordinate.Y == linea2.EndCoordinate.Y &&
                                            linea1.StartZ != linea2.EndZ;

                    bool coincideEndStart = linea1.EndCoordinate.X == linea2.StartCoordinate.X &&
                                            linea1.EndCoordinate.Y == linea2.StartCoordinate.Y &&
                                            linea1.EndZ != linea2.StartZ;

                    bool coincideEndEnd = linea1.EndCoordinate.X == linea2.EndCoordinate.X &&
                                          linea1.EndCoordinate.Y == linea2.EndCoordinate.Y &&
                                          linea1.EndZ != linea2.EndZ;
                    */
                    bool coincideStartStart = UG_APR(linea1.StartCoordinate.X, linea2.StartCoordinate.X) &&
                          UG_APR(linea1.StartCoordinate.Y, linea2.StartCoordinate.Y) &&
                          !UG_APR(linea1.StartZ, linea2.StartZ);

                    bool coincideStartEnd = UG_APR(linea1.StartCoordinate.X, linea2.EndCoordinate.X) &&
                                            UG_APR(linea1.StartCoordinate.Y, linea2.EndCoordinate.Y) &&
                                            !UG_APR(linea1.StartZ, linea2.EndZ);

                    bool coincideEndStart = UG_APR(linea1.EndCoordinate.X, linea2.StartCoordinate.X) &&
                                            UG_APR(linea1.EndCoordinate.Y, linea2.StartCoordinate.Y) &&
                                            !UG_APR(linea1.EndZ, linea2.StartZ);

                    bool coincideEndEnd = UG_APR(linea1.EndCoordinate.X, linea2.EndCoordinate.X) &&
                                          UG_APR(linea1.EndCoordinate.Y, linea2.EndCoordinate.Y) &&
                                          !UG_APR(linea1.EndZ, linea2.EndZ);


                    if (coincideStartStart || coincideStartEnd || coincideEndStart || coincideEndEnd)
                    {
                        // Trova i vertici coincidenti e le quote Z corrispondenti
                        double baseSced = double.NaN;
                        double altezzaSced = double.NaN;
                        // Definizione delle variabili con prefisso 'linea'
                        Coordinate lineaStartCoordinate = new Coordinate(0, 0);
                        Coordinate lineaEndCoordinate = new Coordinate(0, 0);

                        // Determina quale coordinata della linea ha una Z costante
                        if (UG_APR(linea1.StartZ ,linea1.EndZ))
                        {
                            // La Z non varia per linea1, carica le sue coordinate
                            lineaStartCoordinate = linea1.StartCoordinate;
                            lineaEndCoordinate = linea1.EndCoordinate;
                        }
                        else if (UG_APR(linea2.StartZ , linea2.EndZ))
                        {
                            // La Z non varia per linea2, carica le sue coordinate
                            lineaStartCoordinate = linea2.StartCoordinate;
                            lineaEndCoordinate = linea2.EndCoordinate;
                        }
                        int caso = 0;
                        if (coincideStartStart)
                        {
                            caso = 1;
                            baseSced = Math.Min(linea1.StartZ, linea2.StartZ);
                            altezzaSced = Math.Abs(linea1.StartZ - linea2.StartZ);
                        }
                        else if (coincideStartEnd)
                        {
                            caso = 2;
                            baseSced = Math.Min(linea1.StartZ, linea2.EndZ);
                            altezzaSced = Math.Abs(linea1.StartZ - linea2.EndZ);
                        }
                        else if (coincideEndStart)
                        {
                            caso = 3;
                            baseSced = Math.Min(linea1.EndZ, linea2.StartZ);
                            altezzaSced = Math.Abs(linea1.EndZ - linea2.StartZ);
                        }
                        else if (coincideEndEnd)
                        {
                            caso = 4;
                            baseSced = Math.Min(linea1.EndZ, linea2.EndZ);
                            altezzaSced = Math.Abs(linea1.EndZ - linea2.EndZ);
                        }

                        double C1z1 = lineeRettificate[i].StartZ;
                        double C1z2 = lineeRettificate[i].EndZ;
                        double C2z1 = lineeRettificate[j].StartZ;
                        double C2z2 = lineeRettificate[j].EndZ;
                        CorreggiSced(
                        lineeQuotate[i].StartZ, lineeQuotate[i].EndZ,
                        lineeQuotate[j].StartZ, lineeQuotate[j].EndZ,
                        ref C1z1, ref C1z2,
                        ref C2z1, ref C2z2,
                        caso);

                        // Aggiorna le z delle linee rettificate con le nuove valori
                        lineeRettificate[i].StartZ = C1z1;
                        lineeRettificate[i].EndZ = C1z2;
                        lineeRettificate[j].StartZ = C2z1;
                        lineeRettificate[j].EndZ = C2z2;
                        // Crea un nuovo oggetto Sced per rappresentare la discontinuità
                        var sced = new Sced
                        {
                            StartCoordinate = lineaStartCoordinate,
                            EndCoordinate = lineaEndCoordinate,
                            Triangolo = $"Oggetto n:{ModelIstance.CountOggetti}",
                            BaseSced = baseSced,
                            AltezzaSced = altezzaSced
                        };

                        // Aggiungi lo sced alla lista
                        scedList.Add(sced);
                        /*
                        // Correggi la Z del lato SCED (base sced)
                        if (coincideStartStart || coincideStartEnd)
                        {
                            var linea = lineeRettificate.Find(l => l.StartCoordinate == linea1.StartCoordinate && l.EndCoordinate == linea1.EndCoordinate);
                            if (linea != null)
                            {
                                linea.StartZ = baseSced;
                                linea.EndZ = baseSced;
                            }
                        }
                        if (coincideEndStart || coincideEndEnd)
                        {
                            var linea = lineeRettificate.Find(l => l.StartCoordinate == linea1.StartCoordinate && l.EndCoordinate == linea1.EndCoordinate);
                            if (linea != null)
                            {
                                linea.EndZ = baseSced;
                            }
                        }
                        */
                    }
                }
            }

            return (scedList, lineeRettificate); // Restituisce sia la lista degli SCED trovati che le linee rettificate
        }
        private (double ZStart, double ZEnd) TrovaZPerLinea(Coordinate start, Coordinate end)
        {
            var coordinateCoppiaOriginali = new List<Coordinate> { start, end };

            // Prova a trovare la Z per la coppia originale di coordinate
            var zStartOriginale = Lines2DCor().GetUZByCoordinates1Way(coordinateCoppiaOriginali, 1); // Indice 0 per start
            var zEndOriginale = Lines2DCor().GetUZByCoordinates1Way(coordinateCoppiaOriginali, 2);   // Indice 1 per end

            // Se la Z non è valida, prova con le coordinate invertite
            if (double.IsNaN(zStartOriginale) || double.IsNaN(zEndOriginale))
            {
                var coordinateCoppiaInvertita = new List<Coordinate> { end, start };
                zStartOriginale = Lines2DCor().GetUZByCoordinates1Way(coordinateCoppiaInvertita, 2); // Indice 1 per start
                zEndOriginale = Lines2DCor().GetUZByCoordinates1Way(coordinateCoppiaInvertita, 1);   // Indice 0 per end
                /*
                 eliminato in quanto le linee aggiunte dal triangolatore sono in questa situazione
                if (double.IsNaN(zStartOriginale) || double.IsNaN(zEndOriginale))
                {
                    ErroreManager.AddErroreDXF(ModelIstance.NomePianoCor,0,"(interno):Linea 2d elaborata  non trova corrispondenza", Lines2DCor().lineStrings, UtiBimNTS.ListaLineaNTS(start,end,""));
                }
                */
            }
            // Restituisci le Z trovate per le due estremità
            return (zStartOriginale, zEndOriginale);
        }
        public List<LineaQuotata> CreaDatabaseLineeDaPoligono(NetTopologySuite.Geometries.Geometry poligono2D)
        {
            var lineeQuotate = new List<LineaQuotata>();

            // Controlla che poligono2D non sia null
            if (poligono2D == null || poligono2D.Coordinates == null || !poligono2D.Coordinates.Any())
            {
                throw new ArgumentNullException(nameof(poligono2D), "Il poligono 2D o le sue coordinate sono null.");
            }

            // Verifica che ci siano abbastanza coordinate per creare linee
            if (poligono2D.Coordinates.Length < 2)
            {
                throw new InvalidOperationException("Il poligono 2D deve avere almeno due coordinate per creare linee.");
            }

            // Itera attraverso i segmenti del poligono
            for (int i = 0; i < poligono2D.Coordinates.Length - 1; i++)
            {
                var start = poligono2D.Coordinates[i];
                var end = poligono2D.Coordinates[i + 1];

                // Trova le Z per la linea
                var (zStart, zEnd) = TrovaZPerLinea(start, end);

                // Verifica che le Z siano valide
                if (double.IsNaN(zStart) || double.IsNaN(zEnd))
                {
                    // Se la Z non è valida, non aggiungere la linea al database
                    continue;
                }

                // Aggiungi la linea quotata alla lista
                var lineaQuotata = new LineaQuotata
                {
                    StartCoordinate = start,
                    EndCoordinate = end,
                    StartZ = zStart,
                    EndZ = zEnd
                };

                lineeQuotate.Add(lineaQuotata);
            }
            // Crea la lista di tutte le Z (start e end) su una singola linea
            var tutteLeZ = lineeQuotate
                .SelectMany(l => new[] { l.StartZ, l.EndZ })
                .Select(z => z.ToString("0.###", CultureInfo.InvariantCulture));

            string logZ = "Quote Z del triangolo: " + string.Join(", ", tutteLeZ);
            TermodelLog.WriteLog(logZ);
            // Restituisci la lista di linee quotate
            return lineeQuotate;
        }
        //-------------------------------------------------------------------------------------------------------------

        //                             TrasformaPoligono2DInIfcPolyline3_falde

        //-------------------------------------------------------------------------------------------------------------
        // Quota i vertici di una polilinea 2d usando le falde e proiettando XY
        public List<IfcPolyline> GetPolylinesByColor(List<FaldaTetto> tetti_3d, int ColoreTettoCor)
        {
            // Filtra le falde con il colore specificato e seleziona solo le IfcPolyline
            return tetti_3d
                .Where(tetto => tetto.Colore == ColoreTettoCor) // Filtra per colore
                .Select(tetto => tetto.Falda) // Seleziona solo le IfcPolyline
                .Where(falda => falda != null) // Assicura che non ci siano elementi nulli
                .ToList(); // Converte il risultato in una lista
        }
        public double CalcZ(double x, double y, List<FaldaTetto> tetti_3d)
        {
            var tetti3d = GetPolylinesByColor(tetti_3d, ModelIstance.ColoreTettoCor);
            foreach (var polyline in tetti3d)
            {
                if (polyline.Points.Count > 2) // Supponiamo che le falde siano triangoli anche con chiusura
                {
                    var p1 = polyline.Points[0] as IIfcCartesianPoint;
                    var p2 = polyline.Points[1] as IIfcCartesianPoint;
                    var p3 = polyline.Points[2] as IIfcCartesianPoint;

                    if (p1 != null && p2 != null && p3 != null)
                    {
                        // Proietta il punto XY nel piano del triangolo e verifica se si trova all'interno
                        if (PointInTriangle(new Vector2((float)x, (float)y),
                                            new Vector2((float)p1.Coordinates[0], (float)p1.Coordinates[1]),
                                            new Vector2((float)p2.Coordinates[0], (float)p2.Coordinates[1]),
                                            new Vector2((float)p3.Coordinates[0], (float)p3.Coordinates[1])))
                        {
                            // Se il punto è all'interno del triangolo, calcola la Z usando i tre vertici del triangolo
                            return CalcolaZDalPiano(p1, p2, p3, x, y);
                        }
                    }
                }
            }

            // Restituisce NaN se non è riuscito a calcolare la Z
            return double.NaN;
        }

        // Metodo per verificare se un punto è all'interno di un triangolo 2D
        private bool PointInTriangle(Vector2 p, Vector2 p0, Vector2 p1, Vector2 p2)
        {
            double APR = 0.1;
            // Calcola i vettori del triangolo
            var v0 = p2 - p0;
            var v1 = p1 - p0;
            var v2 = p - p0;

            // Calcola i prodotti scalari
            var dot00 = Vector2.Dot(v0, v0);
            var dot01 = Vector2.Dot(v0, v1);
            var dot02 = Vector2.Dot(v0, v2);
            var dot11 = Vector2.Dot(v1, v1);
            var dot12 = Vector2.Dot(v1, v2);

            // Calcola i parametri u e v per il test del punto nel triangolo
            var invDenom = 1 / (dot00 * dot11 - dot01 * dot01);
            var u = (dot11 * dot02 - dot01 * dot12) * invDenom;
            var v = (dot00 * dot12 - dot01 * dot02) * invDenom;

            // Controlla se il punto è all'interno del triangolo (test di u e v)
            bool inside = (u >= 0) && (v >= 0) && (u + v < 1);

            // Se il punto è dentro, restituisci subito true
            if (inside)
                return true;

            // Se il punto non è dentro, verifica se si trova vicino ai lati del triangolo
            bool nearEdge = IsPointNearEdge(p, p0, p1, APR) || IsPointNearEdge(p, p1, p2, APR) || IsPointNearEdge(p, p2, p0, APR);

            // Restituisce true se il punto è vicino a un bordo, false altrimenti
            return nearEdge;
        }

        // Funzione di supporto per verificare se il punto è vicino a un lato del triangolo
        private bool IsPointNearEdge(Vector2 p, Vector2 a, Vector2 b, double APR)
        {
            // Vettore tra i due vertici del lato
            var ab = b - a;
            var ap = p - a;

            // Proietta il vettore ap lungo il lato ab per trovare il punto più vicino sul lato
            var dotProduct = Vector2.Dot(ap, ab);
            var abLengthSquared = Vector2.Dot(ab, ab);
            var t = dotProduct / abLengthSquared;

            // Limita t all'intervallo [0, 1] per ottenere il punto più vicino sul lato
            t = Math.Max(0, Math.Min(1, t));

            // Trova il punto più vicino sul lato
            var closestPoint = a + t * ab;

            // Calcola la distanza tra il punto p e il punto più vicino sul lato
            var distanceToEdge = Vector2.Distance(p, closestPoint);

            // Restituisce true se la distanza è inferiore o uguale alla soglia APR
            return distanceToEdge <= APR;
        }

        // Metodo per calcolare la Z dato un triangolo 3D
        private double CalcolaZDalPiano(IIfcCartesianPoint p1, IIfcCartesianPoint p2, IIfcCartesianPoint p3, double x, double y)
        {
            var x1 = p1.Coordinates[0];
            var y1 = p1.Coordinates[1];
            var z1 = p1.Coordinates[2];

            var x2 = p2.Coordinates[0];
            var y2 = p2.Coordinates[1];
            var z2 = p2.Coordinates[2];

            var x3 = p3.Coordinates[0];
            var y3 = p3.Coordinates[1];
            var z3 = p3.Coordinates[2];

            var v1 = new Vector3((float)(x2 - x1), (float)(y2 - y1), (float)(z2 - z1));
            var v2 = new Vector3((float)(x3 - x1), (float)(y3 - y1), (float)(z3 - z1));

            var normale = Vector3.Cross(v1, v2);

            var A = normale.X;
            var B = normale.Y;
            var C = normale.Z;
            var D = -(A * x1 + B * y1 + C * z1);
            double quota= -(A * x + B * y + D) / C;
            double debug;
            if (quota < 0)
            debug = quota;

            return quota;
        }
        public IfcPolyline TrasformaPoligono2DInIfcPolyline3_falde(NetTopologySuite.Geometries.Geometry poligono2D, List<FaldaTetto> tetti3d)
        {
            if (poligono2D == null || poligono2D.Coordinates == null || !poligono2D.Coordinates.Any())
            {
                throw new ArgumentNullException(nameof(poligono2D), "Il poligono 2D o le sue coordinate sono null.");
            }

            // Crea una nuova IfcPolyline che sarà restituita
            IfcPolyline polyline3D = null;

            // Inizia la transazione IFC
            using (var txn = ModelIstance.model.BeginTransaction("Trasformazione Poligono 2D in 3D"))
            {
                try
                {
                    // Crea una nuova IfcPolyline
                    polyline3D = ModelIstance.model.Instances.New<IfcPolyline>();

                    // Itera sui vertici del poligono 2D
                    for (int i = 0; i < poligono2D.Coordinates.Length; i++)
                    {
                        var coord2D = poligono2D.Coordinates[i];
                        double x = coord2D.X;
                        double y = coord2D.Y;

                        // Usa la funzione CalcZ per calcolare la Z del punto in base ai triangoli delle falde (tetti3d)
                        double z = CalcZ(x, y, tetti3d);

                        // Se la Z non è valida, impostiamo un valore di default (0)
                        if (double.IsNaN(z))
                        {
                            z = 0;
                        }

                        // Crea un punto cartesiano IFC con le coordinate X, Y, Z
                        var ifcPoint = ModelIstance.model.Instances.New<Xbim.Ifc4.GeometryResource.IfcCartesianPoint>();
                        ifcPoint.SetXYZ(x, y, z);

                        // Aggiungi il punto alla IfcPolyline
                        polyline3D.Points.Add(ifcPoint);
                    }

                    // Conferma la transazione
                    txn.Commit();
                }
                catch (Exception ex)
                {
                    // In caso di errore, annulla la transazione
                    txn.RollBack();
                    Console.WriteLine($"Errore: {ex.Message}");
                    throw;
                }
            }

            return polyline3D; // Restituisci la polilinea 3D
        }

        //-------------------------------------------------------------------------------------------------------------

        //                         TrasformaPoligono2DInIfcPolyline

        //-------------------------------------------------------------------------------------------------------------
        // Funzione che quota i vertici di una polilinea 2d usando le Z presenti nel DXF


        public IfcPolyline TrasformaPoligono2DInIfcPolyline(NetTopologySuite.Geometries.Geometry poligono2D,bool falde)
        {
            if (!falde)
            {
                var returnvar= TrasformaPoligono2DInIfcPolyline3_falde(poligono2D, ModelIstance.Tetti3dCor);
                //var debugvar =Modello.IfcPolylineHelper.TrasformaIfcPoligoniInListaDebug(ModelIstance.Tetti3dCor);
                return returnvar;
            }
            TermodelLog.LogOperation($"(Falda) quotatura tridimensionale del triangolo:{ModelIstance.CountOggetti} usando le Z del DXF");
            //TermodelLog.LogDisegnoSVG(Linee2D.lineStrings,poligono2D);
            // Debug ModelIstance.CountOggetti==66
            IfcPolyline polyline3D = null;
            //var Debugg2d = ConvertToCoordinateList2D(poligono2D);
            //var Debugg2dbb = ModelIstance.Lines2DCor.lineStrings;
            //if (ModelIstance.CountOggetti == 66) 
            //SVGHelper.GeneraSVG("Triangolo",ModelIstance.Lines2DCor.lineStrings, poligono2D);
            // Controlla che poligono2D non sia null
            if (poligono2D == null || poligono2D.Coordinates == null || !poligono2D.Coordinates.Any())
            {
                throw new ArgumentNullException(nameof(poligono2D), "Il poligono 2D o le sue coordinate sono null.");
            }

            // 1. Ottieni le linee quotate
            var lineeQuotate = CreaDatabaseLineeDaPoligono(poligono2D);

            // 2. Trova e gestisci SCED
            //var lineeCorrette = TrovaSced(lineeQuotate);
            List<Sced> scedList = new List<Sced>(); // Inizializzazione a una lista vuota
            List<LineaQuotata> lineeCorrette = new List<LineaQuotata>();
            if (lineeQuotate.Count > 0)
            {
                (scedList, lineeCorrette) = TrovaSced(lineeQuotate);
            }
            // Inizia la transazione IFC
            using (var txn = ModelIstance.model.BeginTransaction("Trasformazione Poligono 2D in 3D"))
            {
                try
                {
                    // Crea una nuova IfcPolyline
                    polyline3D = ModelIstance.model.Instances.New<IfcPolyline>();

                    // 3. Itera attraverso tutti i vertici del poligono 2D
                    var listaZ = new List<double>();
                    foreach (var coord in poligono2D.Coordinates)
                    {
                        // Recupera la quota Z utilizzando la funzione ZVertice
                       
                        double z = ZVertice(coord, lineeCorrette);
                        listaZ.Add(z);

                        // Se la Z non è valida, puoi gestire il caso come preferisci, ad esempio impostarla a 0
                        if (double.IsNaN(z))
                        {
                            z = 0.0; // Valore di fallback
                        }

                        // Crea un nuovo punto 3D con la coordinata X, Y e Z
                        var punto3D = ModelIstance.model.Instances.New<IfcCartesianPoint>(p =>
                        {
                            p.SetXYZ(coord.X, coord.Y, z); // Utilizza z per creare la coordinata 3D
                        });

                        // Verifica che il punto sia stato creato correttamente
                        if (punto3D == null)
                        {
                            throw new InvalidOperationException($"Il punto 3D non può essere null. Coordinate: ({coord.X}, {coord.Y}, {z})");
                        }

                        // Aggiungi il punto 3D alla IfcPolyline
                        polyline3D.Points.Add(punto3D);
                    }
                    string logZ = UtiBimNTS.IFCToString(polyline3D);
                    //string logZ = "Quote Z del poligono IFC: " + string.Join(", ", listaZ.Select(val => val.ToString("0.###", CultureInfo.InvariantCulture)));
                    TermodelLog.WriteLog("Triangolo IFC:"+ logZ);

                    // Verifica che ci siano punti nella IfcPolyline
                    if (polyline3D.Points == null || !polyline3D.Points.Any())
                    {
                        throw new InvalidOperationException("La IfcPolyline non contiene alcun punto.");
                    }

                    // Commit della transazione
                    txn.Commit();
                }
                catch (Exception ex)
                {
                    // In caso di errore, annulla la transazione
                    txn.RollBack();
                    Console.WriteLine($"Errore: {ex.Message}");
                    throw;
                }
            }

            return polyline3D; // Restituisci la polilinea 3D
        }
        public void DisegnaSceds()
        {
            if (ModelIstance.drawBimWindow != null) ModelIstance.drawBimWindow.enabled = false;
            int _scedCounter = 0;
            IfcCartesianPoint puntoInserimentoIfc;
            IfcDirection direzione;
            double magnitude;

            // Itera attraverso la lista degli SCED
            foreach (var sced in scedList)
            {
                if (sced.StartCoordinate.X == sced.EndCoordinate.X &&
                sced.StartCoordinate.Y == sced.EndCoordinate.Y )
                {
                    // Le coordinate sono coincidenti, salta questo SCED
                    continue;
                }
                try
                {
                    // Incrementa il contatore e usa il valore per creare un identificatore unico
                    _scedCounter++;
                    string elementIdentifier = "SCED_" + _scedCounter.ToString();

                    // Inizia una transazione per la creazione del punto e della direzione
                    using (var transaction = ModelIstance.model.BeginTransaction())
                    {
                        try
                        {
                            // Crea un punto di inserimento per l'elemento IFC
                            //puntoInserimentoIfc = ModelIstance.model.Instances.New<IfcCartesianPoint>(cp =>
                            //    cp.SetXYZ(sced.StartCoordinate.X, sced.StartCoordinate.Y, sced.BaseSced));
                            double puntoMedioX = (sced.StartCoordinate.X + sced.EndCoordinate.X) / 2;
                            double puntoMedioY = (sced.StartCoordinate.Y + sced.EndCoordinate.Y) / 2;

                            // Crea un punto di inserimento IFC usando il punto medio e la quota Z da BaseSced
                            puntoInserimentoIfc = ModelIstance.model.Instances.New<IfcCartesianPoint>(cp =>
                                cp.SetXYZ(puntoMedioX, puntoMedioY, sced.BaseSced));
                            // Calcola la direzione sul piano XY
                            double deltaX = sced.EndCoordinate.X - sced.StartCoordinate.X;
                            double deltaY = sced.EndCoordinate.Y - sced.StartCoordinate.Y;

                            // Normalizza la direzione
                            magnitude = Math.Sqrt(deltaX * deltaX + deltaY * deltaY);
                            double directionX = deltaX / magnitude;
                            double directionY = deltaY / magnitude;

                            // Crea la direzione per l'estrusione sul piano XY
                            direzione = ModelIstance.model.Instances.New<IfcDirection>(d => d.SetXYZ(directionX, directionY, 0));

                            // Conferma la transazione
                            transaction.Commit();
                        }
                        catch (Exception ex)
                        {
                            // Annulla la transazione in caso di errore
                            transaction.RollBack();
                            throw new InvalidOperationException("Errore durante la creazione del punto e della direzione: " + ex.Message, ex);
                        }
                    }

                    // Crea il parallelepipedo estruso (gestisce la sua transazione)
                    ModelIstance.CreaParallelepipedoEstruso(
                        larghezza: 0.3, // Valore fisso per la larghezza
                        lunghezza: magnitude, // Usa la lunghezza calcolata (magnitude)
                        altezzaEstrusione: sced.AltezzaSced,
                        puntoInserimentoIfc: puntoInserimentoIfc,
                        direzione: direzione,
                        elementIdentifier: elementIdentifier,
                        descrizione: $"Derivante da :{sced.Triangolo}",
                        tipo: "Tipo di SCED",
                        tipoElemento: TipoElemento.Parete,
                        DatiOpaca: null
                    );
                    using (var txn = ModelIstance.model.BeginTransaction("Aggiungi Parete"))
                    {


                        // Associa il proxy alla stanza
                        var relContainedInSpatialStructure = ModelIstance.model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                        {
                            r.RelatingStructure = ModelIstance.LocaleCorrente; // Usa LocaleCorrente
                            r.RelatedElements.Add(ModelIstance.EstrudePolygonCor);
                        });
                        ModelIstance.PareteCorrente = ModelIstance.EstrudePolygonCor;

                        txn.Commit();
                    }
                }
                catch (Exception ex)
                {
                    // Gestisce l'errore
                    throw new InvalidOperationException("Errore durante il disegno degli SCED: " + ex.Message, ex);
                }
            }
            if (ModelIstance.drawBimWindow != null) ModelIstance.drawBimWindow.enabled = true;
        }
    }
}
