using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NetTopologySuite.Geometries;
using NetTopologySuite.Geometries.Implementation;

namespace Termodel.Leggidxf
{
    public static class Geometria
    {
        // Proprietà statica per l'approssimazione
        public static double Appros { get; private set; } = 0.05;
        public static double CalcolaDistanzaPuntoSegmento(Coordinate punto, Coordinate start, Coordinate end)
        {
            var segment = new LineSegment(start, end);
            return segment.Distance(punto);
        }
 
    }
}
