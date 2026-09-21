using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using NetTopologySuite.Geometries;
using NetTopologySuite.Operation.Polygonize;
using Termodel.Leggidxf;
using Xbim.Common;
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
using System.Xml.Linq;
using Termodel.utilities;
using System.Windows;
using System.Globalization;
using System.Windows.Shapes;
using NetTopologySuite.Triangulate;
using NetTopologySuite.Algorithm;
using System.Collections.Generic;  // Per la lista List<Linea3D>
using Termodel.Leggidxf;  // Per la classe Linea3D e DXFLineCheck
using Termodel.utilities;  // Per la classe Linea3D (supponendo che sia definita qui)
using System.Numerics;
using static Polig3D;
using static Termodel.utilities.TermodelLog;
using Termodel.Impianti.Pannelli;

namespace Termodel
{
    public static class Modellostatic
    {
         public static Modello mod;
        public static void Initclass(Modello Mod) 
        {
            mod = Mod;
        }
    }
    
    public class Modello
    {
        public Modello(DrawBim drawBimWindow_par)
        {
            drawBimWindow = drawBimWindow_par;
            Tettocor = new(this);
            Piani = new List<Piano>();
        }
        public class Line
        {
            public Coordinate Start { get; set; }
            public Coordinate End { get; set; }
            // Costruttore che accetta due coordinate
            public Line(Coordinate start, Coordinate end)
            {
                Start = start;
                End = end;
            }
        }
        public List<LineString> ListaLinee3D { get; set; }
        // Costruttore della classe Modello
       
        
        // Funzione per inizializzare il modello
        public IfcStore model;
        public int elementIdentifier = 1;
        public int LocCounter = 1;
        public double QuotaCorrente = 0;
        public int CountFalde = 0;
        public int CountOggetti = 0;
        public int countpareti = 0;
        public int countpavimenti = 0;
        public int countsoffitti = 0;
        public int countPonti = 0;
        public string TriangoloCor = "";
        public string FaldaCor = "";
        public Tetti Tettocor;
        public int ColoreTettoCor=0;
        public double QuotaGrondaCor = 0;
        public bool CreaModello = true;
        public double direzNord = double.NaN;
        public static bool netto = true;
        public static int numeropiani= 0;
        public static double SpesPonte=0.1;
        public string NomePianoCor = "";
        public static bool GeneraXml = true;
        public static bool GeneraBim = false;
        // Proprietà solo leggibile dall'esterno (private set)
        public DXFLineCheck Lines2DCor { get; private set; }

        // Metodo pubblico per impostare il valore di Lines2DCor
        public void SetLines2DCor(DXFLineCheck newLines2DCor)
        {
            // Imposta la proprietà
            Lines2DCor = newLines2DCor;
            Tettocor.Linee2D= newLines2DCor;
        }
        public DXFLineCheck Lines2DCor_temp;
        public List<FaldaTetto> Tetti3dCor ;
        public void SetLines2DCor_provvisorioo(DXFLineCheck lines2DCor_provvisorio)
        {
            Lines2DCor_temp = Lines2DCor;
            Lines2DCor = lines2DCor_provvisorio;
        }
        public void RestoreLines2DCor()
        {
            Lines2DCor = Lines2DCor_temp;  // Ripristina Lines2DCor
            Lines2DCor_temp = null;  // Pulisce il valore temporaneo dopo il ripristino, se necessario
        }

        public int ModoCor = 3;
        public Piano PianoCor ;
        public DrawBim drawBimWindow ;
        public const string C_calpestabile = "Calpestabile";
        public const string C_copertura = "Copertura";
        public List<(double X, double Y, double Z, double? Z2)> ListaVerticiTetti { get;  set; }
        //public List<(Coordinate punto1, Coordinate punto2, double Z1, double Z2, Color coloreLinea)> ListaShed { get;  set; }
        public IfcBuildingStorey ModelloPianoCorrente { get; private set; }
        public IfcSpace LocaleCorrente { get; private set; }
        public TDatilocale DatiLocaleCorrente { get; private set; }
        public IfcBuildingElementProxy PareteCorrente { get; set; }

        public IfcBuildingElementProxy EstrudePolygonCor { get; set; }

        public IfcGeometricRepresentationContext GeometricRepresentationContext { get; private set; }
        // Classe per contenere le informazioni di ogni piano
        public class FaldaTetto
        {
            public int Colore;
            public IfcPolyline Falda;
            public FaldaTetto(IfcPolyline falda, int colore)
            {
                Colore = colore;
                Falda = falda;
            }

        }
            public class Piano
        {
            public string Nomepiano { get; set; }
            public string Tipo { get; set; } // Campo che definisce il tipo (tetto, piano normale, altro)
            public DXFLineCheck LineCheck { get; set; }
            public List<FaldaTetto> Tetti3d { get; set; }
            // Proprietà per mantenere il riferimento al modello
            public Modello Modello { get; set; }

            // Costruttore che inizializza Nomepiano, Tipo e una istanza vuota di DXFLineCheck
            public Piano(Modello modello,string nomepiano, string tipo,List<LineString> lineStrings)
            {
                Nomepiano = nomepiano;
                Tipo = tipo;
                LineCheck = new DXFLineCheck(lineStrings);
                Tetti3d = new List<FaldaTetto>();
                Modello = modello; // Assegna il riferimento al modello
                modello.PianoCor = this;
            }
            
        }
        public Piano CercaTetto()
        {
            // Usa la costante C_calpestabile definita nel Modello
            string tipoTetto = C_copertura;

            // Cerca nella lista di piani del Modello il primo piano con Tipo uguale a C_copertura
            Piano tetto = Piani.FirstOrDefault(p => p.Tipo == tipoTetto);
            if (tetto!=null)  Tetti3dCor = tetto.Tetti3d;
            return tetto;
        }
        public void SettaLines2DCor(string NomePiano)
        {
           
            Piano piano = Piani.FirstOrDefault(p => p.Nomepiano == NomePiano);
            Lines2DCor = piano.LineCheck;        
        }
        // Lista che contiene tutti i piani dell'edificio
        public List<Piano> Piani { get; set; }

        public void CreaRecordLineePiano(Modello modello, string nomepiano, string tipo)
        {
            Piani.Add(new Piano(modello, nomepiano, tipo, null));
        }
        public void AggiungiLineePiano(Modello modello, string nomepiano, string tipo,List<LineString> lineStrings)
        {
            Piano piano = Piani.FirstOrDefault(p => p.Nomepiano == nomepiano);
            if (piano != null) piano.LineCheck = new DXFLineCheck(lineStrings); 
           
            //Piani.Add(new Piano(modello, nomepiano, tipo,lineStrings));
        }
        public static class IfcPolylineHelper
        {
            // Funzione per trasformare un IfcPolyline in una lista leggibile
            public static List<(double X, double Y, double Z)> TrasformaIfcPolylineInLista(IfcPolyline polyline)
            {
                var listaPunti = new List<(double X, double Y, double Z)>();

                // Itera attraverso tutti i punti della IfcPolyline
                foreach (var punto in polyline.Points)
                {
                    if (punto is IIfcCartesianPoint cartesianPoint)
                    {
                        // Ottieni le coordinate X, Y e Z (Z può essere opzionale)
                        double x = cartesianPoint.Coordinates[0];
                        double y = cartesianPoint.Coordinates[1];
                        double z = cartesianPoint.Coordinates.Count > 2 ? cartesianPoint.Coordinates[2] : 0; // Se Z non è presente, impostala a 0

                        // Aggiungi le coordinate alla lista come una tupla
                        listaPunti.Add((x, y, z));
                    }
                }

                return listaPunti;
            }
            public static List<string> TrasformaIfcPoligoniInListaDebug(List<IfcPolyline> listaPoligoniIfc)
            {
                // Lista per memorizzare le rappresentazioni in formato leggibile dei poligoni
                List<string> listaDebug = new List<string>();

                // Itera su ogni poligono nella lista
                foreach (var polyline in listaPoligoniIfc)
                {
                    StringBuilder sb = new StringBuilder();
                    sb.Append("Poligono: ");

                    // Itera su ogni punto nella polilinea
                    foreach (var point in polyline.Points)
                    {
                        var cartesianPoint = point as IIfcCartesianPoint;
                        if (cartesianPoint != null)
                        {
                            double x = cartesianPoint.Coordinates[0];
                            double y = cartesianPoint.Coordinates[1];
                            double z = cartesianPoint.Coordinates.Count > 2 ? cartesianPoint.Coordinates[2] : 0;

                            // Aggiungi le coordinate alla stringa
                            sb.AppendFormat("({0}, {1}, {2}) ", x, y, z);
                        }
                    }

                    // Aggiungi il poligono alla lista di debug
                    listaDebug.Add(sb.ToString());
                }

                return listaDebug;  // Restituisce la lista di poligoni in formato leggibile
            }
        }
        public void Init_modello()
        {
            
            QuotaCorrente = 0;
            CountFalde = 0;
            CountOggetti = 0;
            countpareti = 0;
            countsoffitti = 0;
            countpavimenti = 0;
            countPonti = 0;
            direzNord = double.NaN;
            HelixDXF.I.Svuota();
            //Polig3D.ClearAll();
            IoPannelli.InitClass();
            if (Tettocor != null) Tettocor.scedList.Clear();

            // Crea un nuovo modello IFC in memoria
            model = IfcStore.Create(null, XbimSchemaVersion.Ifc4, XbimStoreType.InMemoryModel);
            
            // Inizia una transazione per creare il modello
            using (var txn = model.BeginTransaction("Creazione Modello"))
            {
                // Crea un nuovo progetto
                var project = model.Instances.New<IfcProject>(p =>
                {
                    p.Name = "Progetto Termodel";
                    p.UnitsInContext = model.Instances.New<IfcUnitAssignment>(ua =>
                    {
                        ua.Units.Add(model.Instances.New<IfcSIUnit>(u =>
                        {
                            u.UnitType = IfcUnitEnum.LENGTHUNIT;
                            u.Name = IfcSIUnitName.METRE;
                        }));
                    });
                });

                // Crea un nuovo sito
                var site = model.Instances.New<IfcSite>(s =>
                {
                    s.Name = "Sito";
                });

                // Collega il sito al progetto
                model.Instances.New<IfcRelAggregates>(a =>
                {
                    a.RelatingObject = project;
                    a.RelatedObjects.Add(site);
                });

                // Crea un nuovo edificio
                var building = model.Instances.New<IfcBuilding>(b =>
                {
                    b.Name = "Edificio";
                });

                // Collega l'edificio al sito
                model.Instances.New<IfcRelAggregates>(a =>
                {
                    a.RelatingObject = site;
                    a.RelatedObjects.Add(building);
                });

                // Crea il contesto geometrico del modello
                var context = model.Instances.New<IfcGeometricRepresentationContext>(c =>
                {
                    c.ContextType = "Model";
                    c.ContextIdentifier = "Body";
                    c.CoordinateSpaceDimension = 3;
                    c.Precision = 1.0e-5;
                    c.WorldCoordinateSystem = model.Instances.New<IfcAxis2Placement3D>(wcs =>
                    {
                        wcs.Location = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(0, 0, 0));
                    });
                });

                // Salva il contesto geometrico come proprietà della classe per l'uso successivo
                this.GeometricRepresentationContext = context;
                // Conferma la transazione
                txn.Commit();
            }
        }

        public void Modello_piano(string pianoNome, double elevazione,Polig3D.TipoPiano TipoDelPiano)
        {
            if (model == null)
            {
                throw new InvalidOperationException("Il modello IFC non è stato inizializzato. Assicurati di chiamare Init_modello prima di Modello_piano.");
            }
            QuotaCorrente = elevazione;
            NomePianoCor = pianoNome;
            // Inizia una transazione per modificare il modello
            using (var txn = model.BeginTransaction("Aggiungi Piano"))
            {
                // Trova l'oggetto IfcBuilding esistente
                var building = model.Instances.OfType<IfcBuilding>().FirstOrDefault();
                if (building == null)
                {
                    throw new InvalidOperationException("Nessun edificio trovato nel modello. Assicurati di avere chiamato Init_modello.");
                }

                // Crea un nuovo piano (IfcBuildingStorey)
                ModelloPianoCorrente = model.Instances.New<IfcBuildingStorey>(bs =>
                {
                    bs.Name = pianoNome;
                    bs.Elevation = elevazione;
                });

                // Collega il piano all'edificio
                model.Instances.New<IfcRelAggregates>(a =>
                {
                    a.RelatingObject = building;
                    a.RelatedObjects.Add(ModelloPianoCorrente);
                });

                // Aggiungi il nome del piano e l'elevazione all'elenco dei piani di Polig3D
                Polig3D.AggiungiPiano(pianoNome, elevazione,  TipoDelPiano);

                // Completa la transazione
                txn.Commit();
            }
        }
        public int localeCounter = 0;
        public void ModelloLocale(string nomeLocale,TDatilocale datilocale)
        {
            if (ModelloPianoCorrente == null)
            {
                throw new InvalidOperationException("ModelloPianoCorrente non è stato impostato.");
            }
            DatiLocaleCorrente= datilocale;
            using (var txn = model.BeginTransaction("Crea Locale"))
            {
                LocaleCorrente = model.Instances.New<IfcSpace>(s =>
                {
                    s.Name = nomeLocale;

                    // Crea il posizionamento del locale
                    s.ObjectPlacement = model.Instances.New<IfcLocalPlacement>(lp =>
                    {
                        lp.RelativePlacement = model.Instances.New<IfcAxis2Placement3D>(rp =>
                        {
                            rp.Location = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(0, 0, 0));
                        });
                    });
                });

                // Connette il locale al piano corrente
                model.Instances.New<IfcRelContainedInSpatialStructure>(rciss =>
                {
                    rciss.RelatingStructure = ModelloPianoCorrente;
                    rciss.RelatedElements.Add(LocaleCorrente);
                });
                // Aggiunge il locale all'elenco dei locali in Polig3D
                Polig3D.AggiungiLocale(nomeLocale, ModelloPianoCorrente.Name, datilocale);
                txn.Commit();
            }
        }
        private List<Coordinate> RimuoviLineeDiLunghezzaZero(Coordinate[] coordinates)
        {
            var coordinateFiltrate = new List<Coordinate>();

            for (int i = 0; i < coordinates.Length; i++)
            {
                var puntoIniziale = coordinates[i];
                var puntoFinale = coordinates[(i + 1) % coordinates.Length]; // Per chiudere il poligono
                double lunghezzaLinea = puntoIniziale.Distance(puntoFinale);

                if (lunghezzaLinea > 0)
                {
                    coordinateFiltrate.Add(puntoIniziale);
                }
            }

            return coordinateFiltrate;
        }
        /*
        public IfcArbitraryClosedProfileDef TrasformaTriangoloInIfcProfilo(Geometry triangleGeometry, List<Coordinate> coordinates)
        {
            IfcArbitraryClosedProfileDef profileDef = null;

            // Ottieni i dati Z dalle coordinate
            var zData = GetUserDataByCoordinates(coordinates);

            using (var txn = model.BeginTransaction("Trasforma Triangolo in Ifc Profilo"))
            {
                // Verifica che la geometria sia un triangolo valido (NetTopologySuite Polygon)
                if (triangleGeometry is NetTopologySuite.Geometries.Polygon trianglePolygon)
                {
                    // Creazione del profilo chiuso arbitrario (IfcArbitraryClosedProfileDef)
                    profileDef = model.Instances.New<IfcArbitraryClosedProfileDef>(profile =>
                    {
                        profile.ProfileType = IfcProfileTypeEnum.AREA; // Tipo di profilo: AREA
                        profile.OuterCurve = model.Instances.New<IfcPolyline>(polyline =>
                        {
                            // Itera attraverso le coordinate del triangolo
                            for (int i = 0; i < trianglePolygon.Coordinates.Length; i++)
                            {
                                var coord = trianglePolygon.Coordinates[i];

                                // Ottieni la Z per la coordinata corrente
                                double z = Convert.ToDouble(zData.Split(',')[i]);

                                // Aggiungi ogni punto del triangolo come punto IFC, inclusa la Z
                                polyline.Points.Add(model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(coord.X, coord.Y, z)));
                            }
                        });
                    });
                }

                txn.Commit();
            }

            return profileDef; // Restituisce il profilo chiuso (IfcArbitraryClosedProfileDef)
        }
        */

 
        public IfcPolyline TrasformaPoligono2DInIfcPolyline3(NetTopologySuite.Geometries.Geometry poligono2D)
        {
            IfcPolyline polyline3D = null;

            // Inizia la transazione IFC
            using (var txn = model.BeginTransaction("Genera Triangolo IFC fisso"))
            {
                try
                {
                    // Crea una nuova IfcPolyline
                    polyline3D = model.Instances.New<IfcPolyline>();

                    // Definisci i punti del triangolo con coordinate fisse
                    var puntiTriangolo = new List<(double X, double Y, double Z)>
            {
                (0.0, 0.0, 0.0),    // Primo punto (origine)
                (10.0, 0.0, 0.0),   // Secondo punto
                (5.0, 5.0, 10.0),    // Terzo punto
                (0.0, 0.0, 0.0)     // Ritorno al primo punto per chiudere il triangolo
            };

                    // Itera sui punti del triangolo e crea i punti 3D IFC
                    foreach (var (x, y, z) in puntiTriangolo)
                    {
                        // Crea un nuovo punto 3D
                        var punto3D = model.Instances.New<IfcCartesianPoint>(p =>
                        {
                            p.SetXYZ(x, y, z);
                        });

                        // Aggiungi il punto 3D alla IfcPolyline
                        polyline3D.Points.Add(punto3D);
                    }

                    // Verifica che la polilinea contenga almeno 3 punti
                    if (polyline3D.Points == null || polyline3D.Points.Count < 3)
                    {
                        throw new InvalidOperationException("La IfcPolyline non contiene abbastanza punti per formare un triangolo.");
                    }

                    // Commit della transazione
                    txn.Commit();
                }
                catch (Exception ex)
                {
                    // In caso di errore, annulla la transazione
                    txn.RollBack();
                    Console.WriteLine($"Errore durante la generazione del triangolo IFC: {ex.Message}");
                    throw;
                }
            }

            return polyline3D; // Restituisci la polilinea 3D
        }
        public IfcPolyline TrasformaPoligono2DInIfcPolyline2(NetTopologySuite.Geometries.Geometry poligono2D)
        {
            IfcPolyline polyline3D = null;

            // Inizia la transazione IFC
            using (var txn = model.BeginTransaction("Trasformazione Poligono 2D in 3D"))
            {
                try
                {
                    // Crea una nuova IfcPolyline
                    polyline3D = model.Instances.New<IfcPolyline>();

                    // Itera su tutti i vertici del poligono 2D
                    foreach (var coord in poligono2D.Coordinates)
                    {
                        // Recupera la quota Z utilizzando la funzione RecuperaZValida
                        var (z1, _) = RecuperaZValida(coord, ListaVerticiTetti);

                        // Se la Z non è valida, puoi gestire il caso come preferisci, ad esempio impostarla a 0
                        if (double.IsNaN(z1))
                        {
                            z1 = 0.0; // Valore di fallback
                        }

                        // Crea un nuovo punto 3D con la coordinata X, Y e Z
                        var punto3D = model.Instances.New<IfcCartesianPoint>(p =>
                        {
                            p.SetXYZ(coord.X, coord.Y, z1); // Utilizza z1 per creare la coordinata 3D
                        });

                        // Verifica che il punto sia stato creato correttamente
                        if (punto3D == null)
                        {
                            throw new InvalidOperationException($"Il punto 3D non può essere null. Coordinate: ({coord.X}, {coord.Y}, {z1})");
                        }

                        // Aggiungi il punto 3D alla IfcPolyline
                        polyline3D.Points.Add(punto3D);
                    }

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
        //-----------------------------------------------------------   nuova versione --------------------------------------
        public class LineaQuotata
        {
            public Coordinate StartCoordinate { get; set; }
            public Coordinate EndCoordinate { get; set; }
            public double StartZ { get; set; }
            public double EndZ { get; set; }
        }
        public class Sced
        {
            public string Triangolo;

            public string CodiceParete="";
            public Coordinate StartCoordinate { get; set; }
            public Coordinate EndCoordinate { get; set; }
            public double BaseSced { get; set; }  // Z minore (base del SCED)
            public double AltezzaSced { get; set; } // Differenza tra le Z (altezza del SCED)
        }
        public List<Sced> scedList { get; set; } = new List<Sced>();
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
                    if (l1z1 != l1z2) // Se le z delle due coordinate non coincidono
                    {
                        C2z1 = l1z1; // Correggi la z della prima linea con la z valida
                        C2z2 = l1z1;
                       

                    }
                    if (l2z1 != l2z2) // Se le z delle due coordinate finali non coincidono
                    {
                        C1z1 = l2z1; // Correggi la z della prima linea con la z valida
                        C1z2 = l2z1;
                    }
                    break;

                case 2: // StartEnd
                        // Linea1 StartCoordinate coincide con Linea2 EndCoordinate
                    if (l1z1 != l1z2) // Se le z delle due coordinate non coincidono
                    {
                        C2z1 = l1z1; // Correggi la z della prima linea con la z valida
                        C2z2 = l1z1;
                     }
                    if (l2z1 != l2z2) // Se le z delle due coordinate finali non coincidono
                    {
                        C1z1 = l2z2; // Correggi la z della prima linea con la z valida
                        C1z2 = l2z2;
                    }
                    break;

                case 3: // EndStart
                        // Linea1 EndCoordinate coincide con Linea2 StartCoordinate
                    if (l1z1 != l1z2) // Se le z delle due coordinate finali non coincidono
                    {
                        C2z1 = l1z2; // Correggi la z della seconda linea con la z valida
                        C2z2 = l1z2;
                    }
                    if (l2z2 != l2z1) // Se le z delle due coordinate non coincidono
                    {
                        C1z1 = l2z2; // Correggi la z della seconda linea con la z valida
                        C1z2 = l2z2;
                    }
                   
                    break;

                case 4: // EndEnd
                        // Linea1 EndCoordinate coincide con Linea2 EndCoordinate
                    if (l1z2 != l1z1) // Se le z delle due coordinate non coincidono
                    {
                        C2z2 = l1z2; // Correggi la z della seconda linea con la z valida
                        C2z1 = l1z2;
                    }
                    if (l2z1 != l2z2) // Se le z delle due coordinate iniziali non coincidono
                    {
                        C1z2 = l2z2; // Correggi la z della seconda linea con la z valida
                        C1z1 = l2z2;
                    }
                    break;
            }
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

                    if (coincideStartStart || coincideStartEnd || coincideEndStart || coincideEndEnd)
                    {
                        // Trova i vertici coincidenti e le quote Z corrispondenti
                        double baseSced = double.NaN;
                        double altezzaSced = double.NaN;
                        int caso=0;
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
                            StartCoordinate = (coincideStartStart || coincideStartEnd) ? linea1.StartCoordinate : linea1.EndCoordinate,
                            EndCoordinate = (coincideStartStart || coincideEndStart) ? linea1.EndCoordinate : linea1.StartCoordinate,
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
        public void QuotaLineeNonQuotate(List<LineaQuotata> lineeNonQuotate, List<LineaQuotata> databaseLineeQuotate)
        {
            foreach (var lineaNonQuotata in lineeNonQuotate)
            {
                // Trova la Z per l'inizio e la fine della linea non quotata
                var (startZ, endZ) = TrovaZPerLinea(lineaNonQuotata.StartCoordinate, lineaNonQuotata.EndCoordinate);

                if (double.IsNaN(startZ) || double.IsNaN(endZ))
                {
                    // Se non trovi le Z, cerca nel database delle linee quotate
                    var zStart = TrovaZDaDatabase(lineaNonQuotata.StartCoordinate, databaseLineeQuotate);
                    var zEnd = TrovaZDaDatabase(lineaNonQuotata.EndCoordinate, databaseLineeQuotate);

                    // Se trovi la Z, aggiorna la linea non quotata
                    if (!double.IsNaN(zStart))
                    {
                        lineaNonQuotata.StartZ = zStart;
                    }
                    else
                    {
                        lineaNonQuotata.StartZ = double.NaN; // O un altro valore di fallback
                    }

                    if (!double.IsNaN(zEnd))
                    {
                        lineaNonQuotata.EndZ = zEnd;
                    }
                    else
                    {
                        lineaNonQuotata.EndZ = double.NaN; // O un altro valore di fallback
                    }
                }
                else
                {
                    // Se le Z sono state trovate, applicale direttamente
                    lineaNonQuotata.StartZ = startZ;
                    lineaNonQuotata.EndZ = endZ;
                }
            }
        }

        private double TrovaZDaDatabase(Coordinate coordinate, List<LineaQuotata> databaseLineeQuotate)
        {
            // Cerca la Z per una coordinata nel database delle linee quotate
            foreach (var linea in databaseLineeQuotate)
            {
                if (coordinate.Equals(linea.StartCoordinate))
                {
                    return linea.StartZ;
                }
                else if (coordinate.Equals(linea.EndCoordinate))
                {
                    return linea.EndZ;
                }
            }

            // Se non viene trovata, restituisce NaN
            return double.NaN;
        }
        public List<LineaQuotata> GeneraLineeNonQuotateDaPoligono(NetTopologySuite.Geometries.Geometry poligono2D)
        {
            // Verifica se il poligono2D è valido
            if (poligono2D == null || poligono2D.Coordinates == null || !poligono2D.Coordinates.Any())
            {
                throw new ArgumentNullException(nameof(poligono2D), "Il poligono 2D o le sue coordinate sono null.");
            }

            var lineeNonQuotate = new List<LineaQuotata>();

            // Itera attraverso le linee del poligono 2D
            for (int i = 0; i < poligono2D.Coordinates.Length; i++)
            {
                var start = poligono2D.Coordinates[i];
                var end = poligono2D.Coordinates[(i + 1) % poligono2D.Coordinates.Length]; // Chiusura del poligono

                // Trova le quote Z per la linea corrente
                var (zStart, zEnd) = TrovaZPerLinea(start, end);

                // Aggiungi la linea al database solo se almeno una delle quote è valida
                if (!double.IsNaN(zStart) || !double.IsNaN(zEnd))
                {
                    lineeNonQuotate.Add(new LineaQuotata
                    {
                        StartCoordinate = start,
                        EndCoordinate = end,
                        StartZ = double.IsNaN(zStart) ? 0.0 : zStart,
                        EndZ = double.IsNaN(zEnd) ? 0.0 : zEnd
                    });
                }
            }

            return lineeNonQuotate;
        }
        // Funzione per creare il database di linee quotate a partire dal poligono
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

            // Restituisci la lista di linee quotate
            return lineeQuotate;
        }
        private (double ZStart, double ZEnd) TrovaZPerLinea(Coordinate start, Coordinate end)
        {
            var coordinateCoppiaOriginali = new List<Coordinate> { start, end };

            // Prova a trovare la Z per la coppia originale di coordinate
            var zStartOriginale = Lines2DCor.GetUZByCoordinates1Way(coordinateCoppiaOriginali, 1); // Indice 0 per start
            var zEndOriginale = Lines2DCor.GetUZByCoordinates1Way(coordinateCoppiaOriginali, 2);   // Indice 1 per end

            // Se la Z non è valida, prova con le coordinate invertite
            if (double.IsNaN(zStartOriginale) || double.IsNaN(zEndOriginale))
            {
                var coordinateCoppiaInvertita = new List<Coordinate> { end, start };
                zStartOriginale = Lines2DCor.GetUZByCoordinates1Way(coordinateCoppiaInvertita, 2); // Indice 1 per start
                zEndOriginale = Lines2DCor.GetUZByCoordinates1Way(coordinateCoppiaInvertita, 1);   // Indice 0 per end
            }
            // Restituisci le Z trovate per le due estremità
           return (zStartOriginale, zEndOriginale);
        }

 
        public IfcPolyline TrasformaPoligono2DInIfcPolyline(NetTopologySuite.Geometries.Geometry poligono2D)
        {
            IfcPolyline polyline3D = null;

            // Controlla che poligono2D non sia null
            if (poligono2D == null || poligono2D.Coordinates == null || !poligono2D.Coordinates.Any())
            {
                throw new ArgumentNullException(nameof(poligono2D), "Il poligono 2D o le sue coordinate sono null.");
            }

            // 1. Ottieni le linee quotate
            var lineeQuotate = CreaDatabaseLineeDaPoligono(poligono2D);

            // 2. Trova e gestisci SCED
            //var lineeCorrette = TrovaSced(lineeQuotate);
            var (scedList, lineeCorrette) = TrovaSced(lineeQuotate);

            // Inizia la transazione IFC
            using (var txn = model.BeginTransaction("Trasformazione Poligono 2D in 3D"))
            {
                try
                {
                    // Crea una nuova IfcPolyline
                    polyline3D = model.Instances.New<IfcPolyline>();

                    // 3. Itera attraverso tutti i vertici del poligono 2D
                    foreach (var coord in poligono2D.Coordinates)
                    {
                        // Recupera la quota Z utilizzando la funzione ZVertice
                        double z = ZVertice(coord, lineeCorrette);

                        // Se la Z non è valida, puoi gestire il caso come preferisci, ad esempio impostarla a 0
                        if (double.IsNaN(z))
                        {
                            z = 0.0; // Valore di fallback
                        }

                        // Crea un nuovo punto 3D con la coordinata X, Y e Z
                        var punto3D = model.Instances.New<IfcCartesianPoint>(p =>
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
        //-----------------------------------------------------------   vecchia versione --------------------------------------
        public IfcPolyline TrasformaPoligono2DInIfcPolylineNoshed(NetTopologySuite.Geometries.Geometry poligono2D)
        {
            IfcPolyline polyline3D = null;

            // Controlla che poligono2D non sia null
            if (poligono2D == null || poligono2D.Coordinates == null || !poligono2D.Coordinates.Any())
            {
                throw new ArgumentNullException(nameof(poligono2D), "Il poligono 2D o le sue coordinate sono null.");
            }

            // Controlla che la lista dei vertici tetti non sia null
            if (ListaVerticiTetti == null || !ListaVerticiTetti.Any())
            {
                throw new InvalidOperationException("La lista dei vertici tetti è vuota o non valida.");
            }

            // Inizia la transazione IFC
            using (var txn = model.BeginTransaction("Trasformazione Poligono 2D in 3D"))
            {
                try
                {
                    // Crea una nuova IfcPolyline
                    polyline3D = model.Instances.New<IfcPolyline>();

                    // Itera su tutti i vertici del poligono 2D
                    foreach (var coord in poligono2D.Coordinates)
                    {
                        // Recupera la quota Z utilizzando la funzione RecuperaZValida
                        var (z1, _) = RecuperaZValida(coord, ListaVerticiTetti);

                        // Se la Z non è valida, puoi gestire il caso come preferisci, ad esempio impostarla a 0
                        if (double.IsNaN(z1))
                        {
                            z1 = 0.0; // Valore di fallback
                        }

                        // Crea un nuovo punto 3D con la coordinata X, Y e Z
                        var punto3D = model.Instances.New<IfcCartesianPoint>(p =>
                        {
                            p.SetXYZ(coord.X, coord.Y, z1); // Utilizza z1 per creare la coordinata 3D
                        });

                        // Verifica che il punto sia stato creato correttamente
                        if (punto3D == null)
                        {
                            throw new InvalidOperationException($"Il punto 3D non può essere null. Coordinate: ({coord.X}, {coord.Y}, {z1})");
                        }

                        // Aggiungi il punto 3D alla IfcPolyline
                        polyline3D.Points.Add(punto3D);
                    }

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
        public (double Z, double? Z2) RecuperaZlineaValida(Coordinate coord1, Coordinate coord2)
        {
            // Costruisci la lista delle coordinate per la linea
            var coordinates = new List<Coordinate> { coord1, coord2 };

            // Tentativo 1: Ottieni la Z per entrambe le coordinate nell'ordine originale
            double Z1 = Lines2DCor.GetUZByCoordinates1Way(coordinates, 1);
            double Z2 = Lines2DCor.GetUZByCoordinates1Way(coordinates, 2);

            // Se almeno una delle Z è valida, restituisci il risultato
            if (!double.IsNaN(Z1) || !double.IsNaN(Z2))
            {
                return (Z1, Z2 == double.NaN ? (double?)null : Z2);
            }

            // Tentativo 2: Inverti le coordinate e le Z corrispondenti
            var coordinatesInverted = new List<Coordinate> { coord2, coord1 };
            Z1 = Lines2DCor.GetUZByCoordinates1Way(coordinatesInverted, 2);  // Inverti Z1 con Z2
            Z2 = Lines2DCor.GetUZByCoordinates1Way(coordinatesInverted, 1);  // Inverti Z2 con Z1

            // Se almeno una delle Z invertite è valida, restituisci il risultato
            if (!double.IsNaN(Z1) || !double.IsNaN(Z2))
            {
                return (Z1, Z2 == double.NaN ? (double?)null : Z2);
            }

            // Tentativo finale: Cerca la Z del singolo vertice del primo punto
            Z1 = Lines2DCor.RecuperaZSingolaCoordinata(coord1);

            // Se la Z del primo vertice è trovata, restituiscila
            if (!double.IsNaN(Z1))
            {
                return (Z1, null);
            }

            // Se nessuna Z valida è trovata, restituisci NaN e null
            return (double.NaN, null);
        }

        public (double Z, double? Z2) RecuperaZValida(Coordinate coord, List<(double X, double Y, double Z, double? Z2)> listaVerticiTetti)
        {
            // Cerca nella lista dei vertici per trovare una corrispondenza con le coordinate X e Y
            var vertice = listaVerticiTetti.FirstOrDefault(v => v.X == coord.X && v.Y == coord.Y);

            // Se il vertice esiste, restituisci la coppia Z e Z2
            if (vertice != default)
            {
                return (vertice.Z, vertice.Z2);
            }

            // Se il vertice non è trovato, restituisci NaN per Z e null per Z2
            return (double.NaN, null);
        }
        // Funzione che aggiunge i vertici alla lista evitando duplicati
        public void AggiungiVerticeAllaLista(double x, double y, double z)
        {
            var verticeEsistente = ListaVerticiTetti.FirstOrDefault(v => v.X == x && v.Y == y);

            if (verticeEsistente != default)
            {
                if (verticeEsistente.Z != z)
                {
                    if (verticeEsistente.Z2 == null)
                    {
                        // Se Z2 non è ancora occupato, assegnalo
                        ListaVerticiTetti.Remove(verticeEsistente);
                        ListaVerticiTetti.Add((x, y, verticeEsistente.Z, z));
                    }
                    else
                    {
                        // Se Z2 è già occupato, solleva un'eccezione
                        throw new InvalidOperationException($"Più di due quote Z trovate per il punto ({x}, {y}).");
                    }
                }
            }
            else
            {
                // Aggiungi il nuovo vertice
                ListaVerticiTetti.Add((x, y, z, null));
            }
        }
        private List<(double X, double Y, double Z, double? Z2)> GeneraListaVerticiDisegno(Coordinate[] coordinate2D)
        {
            var listaVertici = new List<(double X, double Y, double Z, double? Z2)>();

            // Cicla attraverso le coordinate e genera i punti con Z e Z2
            for (int i = 0; i < coordinate2D.Length; i++)
            {
                // Prendi le due coordinate che formano il lato
                List<Coordinate> lato = new List<Coordinate> { coordinate2D[i], coordinate2D[(i + 1) % coordinate2D.Length] };

                // Chiama la funzione GetUZByCoordinates per la prima e la seconda coordinata
                double altezzaZ1 = Lines2DCor.GetUZByCoordinates(lato, 1);
                double altezzaZ2 = Lines2DCor.GetUZByCoordinates(lato, 2);

                // Verifica se la Z è valida prima di aggiungere il vertice
                if (!double.IsNaN(altezzaZ1))
                {
                    AggiungiVertice(listaVertici, coordinate2D[i].X, coordinate2D[i].Y, altezzaZ1);
                }

                if (!double.IsNaN(altezzaZ2))
                {
                    AggiungiVertice(listaVertici, coordinate2D[(i + 1) % coordinate2D.Length].X, coordinate2D[(i + 1) % coordinate2D.Length].Y, altezzaZ2);
                }
            }

            return listaVertici;
        }
        private void AggiungiVertice(List<(double X, double Y, double Z, double? Z2)> listaVertici, double x, double y, double z)
        {
            // Cerca se il vertice (X, Y) è già presente
            var verticeEsistente = listaVertici.FirstOrDefault(v => v.X == x && v.Y == y);

            if (verticeEsistente != default)
            {
                // Se lo stesso vertice esiste già, confronta le Z
                if (verticeEsistente.Z != z)
                {
                    if (verticeEsistente.Z2 == null)
                    {
                        // Memorizza il valore di Z esistente
                        var zEsistente = verticeEsistente.Z;

                        // Rimuovi il vertice esistente dalla lista
                        listaVertici.Remove(verticeEsistente);

                        // Aggiungi il vertice con la Z esistente e la nuova Z in Z2
                        listaVertici.Add((x, y, zEsistente, z));
                    }
                    else
                    {
                        // Se Z2 è già occupata, solleva un'eccezione
                        throw new InvalidOperationException($"Più di due quote Z trovate per il punto ({x}, {y}).");
                    }
                }
            }
            else
            {
                // Se il vertice non esiste, aggiungilo con la quota Z
                listaVertici.Add((x, y, z, null));
            }
        }
        public static bool IsTriangleInsidePolygonBorder(Geometry originalPolygon, Geometry triangle)
        {
            // Estrai i vertici del triangolo
            Coordinate[] triangleCoords = triangle.Coordinates;

            // Calcola i punti medi dei lati
            Coordinate midPoint1 = new Coordinate((triangleCoords[0].X + triangleCoords[1].X) / 2.0, (triangleCoords[0].Y + triangleCoords[1].Y) / 2.0);
            Coordinate midPoint2 = new Coordinate((triangleCoords[1].X + triangleCoords[2].X) / 2.0, (triangleCoords[1].Y + triangleCoords[2].Y) / 2.0);
            Coordinate midPoint3 = new Coordinate((triangleCoords[2].X + triangleCoords[0].X) / 2.0, (triangleCoords[2].Y + triangleCoords[0].Y) / 2.0);

            // Controlla se i punti medi sono all'interno del poligono
            if (!originalPolygon.Contains(new NetTopologySuite.Geometries.Point(midPoint1)) ||
                !originalPolygon.Contains(new NetTopologySuite.Geometries.Point(midPoint2)) ||
                !originalPolygon.Contains(new NetTopologySuite.Geometries.Point(midPoint3)))
            {
                return false; // Se uno dei punti medi è fuori, il triangolo non è dentro
            }

            // Se tutti i punti medi sono dentro, il triangolo è dentro
            return true;
        }
        public static bool IsTriangleInsidePolygonNew(Geometry originalPolygon, Geometry triangle)
        {
          // 1. Calcola il baricentro del triangolo
            Coordinate[] triangleCoords = triangle.Coordinates;
            double centerX = (triangleCoords[0].X + triangleCoords[1].X + triangleCoords[2].X) / 3.0;
            double centerY = (triangleCoords[0].Y + triangleCoords[1].Y + triangleCoords[2].Y) / 3.0;
            Coordinate centroid = new Coordinate(centerX, centerY);

            // 2. Controlla se il baricentro è interno al poligono originale
            return GeometriaHelper.ContainsPoint(originalPolygon, centroid);
        }
        public static bool IsTriangleInsidePolygonSafe(Geometry originalPolygon, Geometry triangle)
        {
            // Prendi solo i primi 3 vertici (evita eventuale duplicato finale)
            var triangleCoords = triangle.Coordinates.Take(3);

            foreach (var coord in triangleCoords)
            {
                var point = new NetTopologySuite.Geometries.Point(coord);

                // Usa Covers per includere anche i bordi
                if (!originalPolygon.Covers(point))
                {
                    return false;
                }
            }

            return true;
        }

        /// <summary>
        /// Funzione hub che permette di selezionare quale metodo usare per determinare
        /// se un triangolo è contenuto all'interno di un poligono.
        /// Commenta/scommenta la riga desiderata.
        /// </summary>
        public static bool IsTriangleInsidePolygon(Geometry originalPolygon, Geometry triangle)
        {
            // ✅ Versione base (classica): controlla se il baricentro del triangolo è dentro il poligono
            //return IsTriangleInsidePolygonClassic(originalPolygon, triangle);

            // ✅ Versione "New": baricentro + metodo personalizzato di GeometriaHelper.ContainsPoint
             return IsTriangleInsidePolygonNew(originalPolygon, triangle);

            // ✅ Versione "Safe": controlla se tutti i vertici del triangolo sono coperti dal poligono (anche sui bordi)
            // return IsTriangleInsidePolygonSafe(originalPolygon, triangle);

            // ✅ Versione "Border": controlla se i punti medi dei lati del triangolo sono contenuti nel poligono
            // return IsTriangleInsidePolygonBorder(originalPolygon, triangle);
        }


        public static bool IsTriangleInsidePolygonClassic(Geometry originalPolygon, Geometry triangle)
        {
            // 1. Calcola il baricentro del triangolo
            Coordinate[] triangleCoords = triangle.Coordinates;
            double centerX = (triangleCoords[0].X + triangleCoords[1].X + triangleCoords[2].X) / 3.0;
            double centerY = (triangleCoords[0].Y + triangleCoords[1].Y + triangleCoords[2].Y) / 3.0;
            Coordinate centroid = new Coordinate(centerX, centerY);

            // 2. Controlla se il baricentro è interno al poligono originale
            return originalPolygon.Contains(new NetTopologySuite.Geometries.Point(centroid));
        }
        public void AggiungiEstrudePolygon3D(Geometry poly, double spessore, string elementIdentifier, IfcCartesianPoint puntoInserimento, IfcDirection direzione, string descrizione, string tipo,bool falde,TipoElemento tipoElemento, TDatiSuperficieOpaca DatiOpaca)
        {
            //ListaVerticiTetti =GeneraListaVerticiDisegno(poly.Coordinates);  // Genera la lista dei vertici del poligono
            // Triangolazione della geometria
            var triangulationBuilder = new DelaunayTriangulationBuilder();
            triangulationBuilder.SetSites(poly);

            // Ottieni i triangoli risultanti dalla triangolazione
            var triangles = triangulationBuilder.GetTriangles(new GeometryFactory());
            int triangoliComplessivi = triangles.Count();

            // Visualizza il numero di triangoli generati
            Console.WriteLine($"Numero di triangoli generati: {triangles.NumGeometries}");
            int count = 0;
            foreach (var triangle in triangles)
            {
                // Ogni triangolo è una geometria di tipo poligono
                if (triangle is NetTopologySuite.Geometries.Polygon trianglePolygon)
                if(IsTriangleInsidePolygon(poly,triangle))
                {
                    count += 1;
                    // Converti il triangolo in una NetTopologySuite Geometry compatibile con AggiungiEstrudePolygon
                    Geometry triangleGeometry = trianglePolygon;
                    IfcCartesianPoint puntoInserimentoLoc = null;
                    // Chiamata a AggiungiEstrudePolygon per ogni triangolo
                    using (var txn = model.BeginTransaction("Variabile locale"))
                    {
                        IfcCartesianPoint puntoInserimentoLocTemp = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(puntoInserimento.X, puntoInserimento.Y, puntoInserimento.Z));
                        puntoInserimentoLoc = puntoInserimentoLocTemp;
                        txn.Commit(); // Completa la transazione
                    }
                    TriangoloCor = $"Subtriangolo:{count}";
                    TermodelLog.LogOperation($"Generazione {TriangoloCor}/{triangoliComplessivi}({elementIdentifier})");
                    AggiungiEstrudePolygon(triangleGeometry, spessore, elementIdentifier, puntoInserimentoLoc, direzione, $"Subtriangolo:{count}", "Elemento poligonale tetto",true,falde,false, tipoElemento, DatiOpaca);
                    if (!Polig3D.enabled)
                    using (var txn = model.BeginTransaction("Aggiungi Elemento copertura 3d"))
                        {

                            if (EstrudePolygonCor == null) // Verifica che l'estrusione sia andata a buon fine
                            {
                                TermodelLog.LogOperation($"Errore durante l'inserimento nel modello");
                                Console.WriteLine("Errore durante la creazione dell'estrusione del poligono per il solaio.");
                                txn.RollBack();
                                return;
                            }

                            // Collega il solaio al locale corrente
                            var relContainedInSpatialStructure = model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                            {
                                TermodelLog.LogOperation($"Falda triangolare inserita nel modello");
                                r.RelatingStructure = LocaleCorrente;
                                r.RelatedElements.Add(EstrudePolygonCor);
                            });

                            txn.Commit(); // Completa la transazione se tutto va bene
                        }
                }
            }
        }
 
        private Vector3 CalcolaNormaleDaDirezione(IfcDirection direzione)
        {
            // Ottieni le coordinate X, Y, Z della direzione
            double dirX = direzione.DirectionRatios[0];
            double dirY = direzione.DirectionRatios[1];
            double dirZ = direzione.DirectionRatios.Count > 2 ? direzione.DirectionRatios[2] : 0;

            // Vettore ausiliario per il calcolo (per semplicità, possiamo usare un vettore che punta lungo l'asse Z)
            Vector3 vettoreAusiliario = new Vector3(0, 0, 1);

            // Crea il vettore parallelo dato da IfcDirection
            Vector3 direzioneVettore = new Vector3((float)dirX, (float)dirY, (float)dirZ);

            // Calcola il prodotto vettoriale per ottenere la normale
            Vector3 normale = Vector3.Cross(direzioneVettore, vettoreAusiliario);

            // Normalizza il vettore risultante
            Vector3.Normalize(normale); // Non restituisce, modifica il vettore originale
            return Vector3.Normalize(normale); // Restituisci il vettore normalizzato
        }
        public  IfcPolyline TrasformaPoligono2DInIfc(NetTopologySuite.Geometries.Geometry poly,bool verticale)
        {
            IfcPolyline polylineIfc = null;

            // Inizia una nuova transazione
            using (var txn = model.BeginTransaction("Trasforma Poligono in IfcPolyline"))
            {
                try
                {
                    // Crea un nuovo IfcPolyline
                    polylineIfc = model.Instances.New<IfcPolyline>();
                   
                    // Itera su ciascuna coordinata del poligono
                    foreach (var coord in poly.Coordinates)
                    {
                        // Verifica che nessuna delle coordinate sia NaN
                        if (!double.IsNaN(coord.X) && !double.IsNaN(coord.Y))
                        {
                            var puntoIfc = model.Instances.New<IfcCartesianPoint>(punto =>
                            {
                                if (verticale)
                                    punto.SetXYZ(coord.X, 0, coord.Y); // Poligono verticale
                                else
                                    punto.SetXYZ(coord.X, coord.Y, 0); // Imposta Z = 0
                            });

                            // Aggiungi il punto alla polilinea IFC
                            polylineIfc.Points.Add(puntoIfc);
                        }
                        else
                        {
                            // Gestisci il caso in cui X o Y siano NaN
                            Console.WriteLine($"Coordinata non valida rilevata: X={coord.X}, Y={coord.Y}. Punto saltato.");
                        }
                    }

                    // Commit della transazione
                    txn.Commit();
                }
                catch (Exception ex)
                {
                    // Rollback in caso di errore
                    txn.RollBack();
                    Console.WriteLine($"Errore durante la trasformazione del poligono: {ex.Message}");
                }
            }

            return polylineIfc;
        }
        public void AggiungiEstrudePolygon(NetTopologySuite.Geometries.Geometry poly,  double spessore, string elementIdentifier, IfcCartesianPoint puntoInserimento, IfcDirection direzione, string descrizione,string tipo,bool Poly3D,bool falde,bool verticale, TipoElemento TipoElemento, TDatiSuperficieOpaca DatiOpaca)
        {

            if (puntoInserimento.X == double.NaN || puntoInserimento.Y == double.NaN || puntoInserimento.Z == double.NaN)
                TermodelLog.LogError($"Il puto di inserimento del {tipo},{elementIdentifier},{descrizione} non sono definite correttamente");

            try
            {

                CountOggetti += 1;
                IfcPolyline polyifc = null;
                if (Poly3D)
                {
                    polyifc = Tettocor.TrasformaPoligono2DInIfcPolyline(poly, falde);
                    //var polyDeb= IfcPolylineHelper.TrasformaIfcPolylineInLista(polyifc);
                    if (falde) 
                        PianoCor.Tetti3d.Add(new FaldaTetto(polyifc,ColoreTettoCor));

                }
                //if (drawBimWindow!=null&& !Poly3D) drawBimWindow.lineManager.AggiungiPolilineaNettopology(poly, puntoInserimento, QuotaCorrente);
                //if (drawBimWindow != null && Poly3D) drawBimWindow.lineManager.AggiungiIFCpoly(polyifc, puntoInserimento, QuotaCorrente);

                if (Polig3D.enabled)
                {
                    double QuotaC = QuotaCorrente;
                    // per le falde la quota è espressa in valore assoluto
                    if (Poly3D) QuotaC = 0;

                    if (!Poly3D) polyifc=TrasformaPoligono2DInIfc(poly,verticale);
                        // Creazione di un nuovo poligono estruso
                        var poligonoEstruso = new PoligonoEstrusoIfc(
                        polyifc,  // IfcPolyline generato dal poligono
                        spessore, // Spessore dell'estrusione
                        elementIdentifier, // Identificatore dell'elemento
                        puntoInserimento, // Punto di inserimento
                        direzione, // Direzione dell'estrusione
                        descrizione, // Descrizione dell'elemento
                        tipo, // Tipo dell'elemento
                        QuotaC, // Quota corrente
                        Poly3D,
                        falde,verticale
                    );

                    Polig3D.ElementoAssociato.AggiungiElemento(poligonoEstruso, locale: LocaleCorrente, datilocale: DatiLocaleCorrente, pareteBase: PareteCorrente, tipoElemento: TipoElemento, DatiOpaca: DatiOpaca, _NomePiano: NomePianoCor);
                    
                    return;
                }

                using (var txn = model.BeginTransaction("Aggiungi Poligono Estruso"))
                {
                   
                    puntoInserimento.Z += QuotaCorrente;
                    EstrudePolygonCor = model.Instances.New<IfcBuildingElementProxy>(bep =>
                    {
                        bep.Name = $"{elementIdentifier}";
                        //bep.Description = $"{poly.Area:F1} (mq)";
                        bep.Description = descrizione;
                        // bep.ObjectType = tipo;
                        
                        bep.ObjectType = $"Oggetto n:{CountOggetti}";
                        bep.ObjectPlacement = model.Instances.New<IfcLocalPlacement>(lp =>
                        {
                            lp.RelativePlacement = model.Instances.New<IfcAxis2Placement3D>(rp =>
                            {
                                rp.Location = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(0, 0, 0));
                            });
                        });

                        // Inizio rappresentazione geometrica del poligono
                        bep.Representation = model.Instances.New<IfcProductDefinitionShape>(pds =>
                        {
                            pds.Representations.Add(model.Instances.New<IfcShapeRepresentation>(sr =>
                            {
                                sr.ContextOfItems = GeometricRepresentationContext;
                                sr.RepresentationIdentifier = "Body";
                                sr.RepresentationType = "SweptSolid";
                                sr.Items.Add(model.Instances.New<IfcExtrudedAreaSolid>(eas =>
                                {
                                    eas.Depth = spessore; // Profondità dell'estrusione

                                    
                                        var polygonProfile = model.Instances.New<IfcArbitraryClosedProfileDef>(profile =>
                                        {
                                           profile.ProfileType = IfcProfileTypeEnum.AREA;
                                           if (Poly3D) profile.OuterCurve  = polyifc;
                                           else
                                           {
                                            profile.OuterCurve = model.Instances.New<IfcPolyline>(polyline =>
                                            {

                                                foreach (var coord in poly.Boundary.Coordinates)
                                                {
                                                    if (verticale) polyline.Points.Add(model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(coord.X, 0, coord.Y)));
                                                    else polyline.Points.Add(model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(coord.X, coord.Y, 0)));
                                                }
                                            });
                                           }
                                        });

                                        eas.SweptArea = polygonProfile;

                                    if (verticale)
                                    {
                                        //var normal = CalcolaNormaleDaDirezione(direzione);
                                        //eas.ExtrudedDirection = model.Instances.New<IfcDirection>(d => d.SetXYZ(normal.X, normal.Y, normal.Z));
                                        eas.ExtrudedDirection = model.Instances.New<IfcDirection>(d => d.SetXYZ(0, 1, 0));
                                    }
                                    else eas.ExtrudedDirection = model.Instances.New<IfcDirection>(d => d.SetXYZ(0, 0, 1)); // Direzione dell'estrusione
                                    
                                    eas.Position = model.Instances.New<IfcAxis2Placement3D>(a2p3d =>
                                    {
                                        //a2p3d.Location = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(0, 0, 0)); // Posizione dell'oggetto tridimensionale
                                        a2p3d.Location = puntoInserimento;
                                        //a2p3d.RefDirection = model.Instances.New<IfcDirection>(d => d.SetXYZ(1, 0, 0)); // Direzione di riferimento sull'asse X
                                        a2p3d.RefDirection = direzione;
                                        a2p3d.Axis = model.Instances.New<IfcDirection>(d => d.SetXYZ(0, 0, 1)); // Asse principale dell'oggetto
                                    });
                                }));
                            }));
                        });
                        // Fine rappresentazione geometrica del poligono
                    });

                    txn.Commit(); // Completa la transazione
                }
            }
            catch (Exception ex)
            {
                TermodelLog.LogError($"Errore durante la generazione del poligono estruso: {ex.Message}");
                Console.WriteLine($"Errore durante l'aggiunta del poligono estruso: {ex.Message}");
                EstrudePolygonCor = null; // Resetta in caso di errore
            }
        }
        public void AggiungiSolaio(NetTopologySuite.Geometries.Geometry poligono, double spessore, double quota, string elementIdentifier, string descrizione,bool Solaio3D,bool falde,TipoElemento tipoElemento, TDatiSuperficieOpaca DatiOpaca)
        {
            //return;
            TermodelLog.LogOperation("Aggiunge un solaio/pavimento al modello con opzioni 2D o 3D");
            if (Solaio3D && falde) TermodelLog.LogOperation($"-> Copertura di locale mansardato");
            if (!Solaio3D && falde) TermodelLog.LogOperation($"-> Superficie del tetto modellante");
            if (!Solaio3D && !falde) TermodelLog.LogOperation($"-> Solaio/pavimento piano");
            //TermodelLog.LogOperation($"  Parametri:");
            int numeroLati = poligono.Coordinates.Length - 1;  // Numero di vertici meno 1 per ottenere il numero di lati
            //TermodelLog.LogOperation($"    - poligono: Numero di lati: {numeroLati}"); TermodelLog.LogOperation($"    - spessore: Definisce lo spessore del solaio. Valore: {spessore}");
            //TermodelLog.LogOperation($"    - quota: Definisce la quota di posizionamento del solaio.: {quota}");
            //TermodelLog.LogOperation($"    - elementIdentifier:  {elementIdentifier}");
            //TermodelLog.LogOperation($"    - tipoElemento:  {tipoElemento}");

            //AggiungiCubo();
            //return;
            try
            {
                IfcCartesianPoint puntoInserimento;
                IfcDirection direzione;
                using (var txn = model.BeginTransaction("Crea Punto Cartesiano"))
                {
                    // Crea il punto cartesiano all'interno della transazione
                    puntoInserimento = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(0, 0, quota));
                    direzione = model.Instances.New<IfcDirection>(d => d.SetXYZ(1, 0, 0));

                    // Completa la transazione
                    txn.Commit();
                }
                // Aggiungi l'estrusione del poligono per il solaio e le falde
                if (Solaio3D||falde)  
                    // passa il controllo al triangolatore
                    AggiungiEstrudePolygon3D(poligono, spessore, elementIdentifier, puntoInserimento, direzione, descrizione, "Solaio/Pavimento",falde, tipoElemento, DatiOpaca);
                else AggiungiEstrudePolygon(poligono,spessore, elementIdentifier, puntoInserimento, direzione, descrizione,"Solaio/Pavimento", Solaio3D,false, false, tipoElemento, DatiOpaca);

                if (!Solaio3D)
                using (var txn = model.BeginTransaction("Aggiungi Solaio"))
                {
                
                    if (EstrudePolygonCor == null) // Verifica che l'estrusione sia andata a buon fine
                    {
                        Console.WriteLine("Errore durante la creazione dell'estrusione del poligono per il solaio.");
                        txn.RollBack();
                        return;
                    }
                    if (!Polig3D.enabled)
                    {
                        // Collega il solaio al locale corrente
                        var relContainedInSpatialStructure = model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                        {
                           r.RelatingStructure = LocaleCorrente;
                           r.RelatedElements.Add(EstrudePolygonCor);
                        });

                        txn.Commit(); // Completa la transazione se tutto va bene
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore durante l'aggiunta del solaio: {ex.Message}");
            }
        }
        /// <summary>
        /// Crea un parallelepipedo estruso a partire da un rettangolo definito dalle dimensioni specificate, con una data altezza di estrusione.
        /// Il rettangolo è centrato nel punto di inserimento specificato e orientato secondo la direzione definita.
        /// </summary>
        /// <param name="larghezza">La larghezza del rettangolo di base (dy), lungo l'asse Y locale. Questo valore rappresenta la dimensione verticale del rettangolo.</param>
        /// <param name="lunghezza">La lunghezza del rettangolo di base (dx), lungo l'asse X locale. Questo valore rappresenta la dimensione orizzontale del rettangolo.</param>
        /// <param name="altezzaEstrusione">L'altezza di estrusione (dz) del parallelepipedo lungo l'asse Z locale. Questo parametro specifica quanto il rettangolo viene estruso per creare il solido tridimensionale.</param>
        /// <param name="puntoInserimento">Le coordinate (x, y, z) del punto di inserimento del centro del rettangolo di base. Questo punto definisce la posizione centrale della base del parallelepipedo nello spazio 3D.</param>
        /// <param name="direzione">Una terna (IfcDirection) che definisce la direzione dell'asse X locale del rettangolo di base. Questa direzione orienta il parallelepipedo nello spazio.</param>

        public void CreaParallelepipedoEstrusoH2(double larghezza, double lunghezza, double h1, double h2, IfcCartesianPoint puntoInserimentoIfc, IfcDirection direzione, string elementIdentifier, string descrizione, string tipo ,TipoElemento tipoElemento, TDatiSuperficieOpaca DatiOpaca)
        {
            if (h1 == double.NaN || h2 == double.NaN || puntoInserimentoIfc.Z == double.NaN)
                TermodelLog.LogError($"Le altezze del {tipo},{elementIdentifier},{descrizione} non sono definite correttamente" );
            // Definisci un rettangolo con due altezze distinte
            double h1p = 0;
            double h2p = 0;
            if (tipoElemento == TipoElemento.Ponte)  
            {
            //puntoInserimentoIfc.Z = 0;
            h1p = h1-larghezza;
            h2p = h2 - larghezza;
            }
            var polygonCoords = new[]
            {
        // Usa h1 per un lato del rettangolo e h2 per l'altro lato
        new NetTopologySuite.Geometries.Coordinate(-lunghezza / 2,h1p), // Inizio con h1
        new NetTopologySuite.Geometries.Coordinate(-lunghezza / 2,h1),  // Continuazione con h1
        new NetTopologySuite.Geometries.Coordinate(lunghezza / 2 ,h2),   // Usa h2 per questo lato
        new NetTopologySuite.Geometries.Coordinate(lunghezza / 2, h2p),  // Chiudi con h2
        new NetTopologySuite.Geometries.Coordinate(-lunghezza / 2,h1p)  // Chiusura del rettangolo
            };

            // Crea il poligono 3D con NetTopologySuite
            var rectangle = new NetTopologySuite.Geometries.Polygon(new NetTopologySuite.Geometries.LinearRing(polygonCoords));

            // Definisci il punto di inserimento e la direzione
            var direzioneIfc = direzione;

            // Utilizza la funzione generica per aggiungere l'estrusione del rettangolo
            AggiungiEstrudePolygon(
                poly: rectangle,
                spessore: larghezza, // In questo caso, la differenza tra h1 e h2 definisce l'estrusione
                elementIdentifier: elementIdentifier, // Identificatore dell'elemento
                puntoInserimento: puntoInserimentoIfc,
                direzione: direzioneIfc,
                descrizione: descrizione,
                tipo: tipo,
                Poly3D: false,
                falde: false,
                verticale: true ,// Usa il parametro verticale per gestire le differenze di altezza
                TipoElemento: tipoElemento,
                DatiOpaca: DatiOpaca
            );
        }
        public void CreaParallelepipedoEstruso(double larghezza, double lunghezza, double altezzaEstrusione, IfcCartesianPoint puntoInserimentoIfc, IfcDirection direzione, string elementIdentifier, string descrizione, string tipo, TipoElemento tipoElemento,TDatiSuperficieOpaca DatiOpaca)
        {
            if (altezzaEstrusione == double.NaN||puntoInserimentoIfc.Z==double.NaN)
                TermodelLog.LogError($"Le altezze del {tipo},{elementIdentifier},{descrizione} non sono definite correttamente");

            // Definisci un rettangolo come poligono
            var rectangle = new NetTopologySuite.Geometries.Polygon(
                new NetTopologySuite.Geometries.LinearRing(new[]
                {
            new NetTopologySuite.Geometries.Coordinate(-lunghezza / 2, -larghezza / 2),
            new NetTopologySuite.Geometries.Coordinate(lunghezza / 2, -larghezza / 2),
            new NetTopologySuite.Geometries.Coordinate(lunghezza / 2, larghezza / 2),
            new NetTopologySuite.Geometries.Coordinate(-lunghezza / 2, larghezza / 2),
            new NetTopologySuite.Geometries.Coordinate(-lunghezza / 2, -larghezza / 2) // Chiusura del rettangolo
                })
            );

            // Definisci il punto di inserimento e la direzione
            var direzioneIfc = direzione;

            // Utilizza la funzione generica per aggiungere l'estrusione del rettangolo
            AggiungiEstrudePolygon(
                poly: rectangle,
                spessore: altezzaEstrusione,
                elementIdentifier: elementIdentifier, // Identificatore dell'elemento
                puntoInserimento: puntoInserimentoIfc,
                direzione: direzioneIfc,
                descrizione: descrizione,
                tipo: tipo,
                Poly3D: false,
                falde: false,
                verticale: false,
                TipoElemento: tipoElemento,
                DatiOpaca: DatiOpaca
            );
        }
        public void AggiungiCubo()
        {
            // Verifica se il modello e il locale corrente sono stati inizializzati
            if (model == null || LocaleCorrente == null)
            {
                MessageBox.Show("Il modello o il locale corrente non sono inizializzati.", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            try
            {
                // Imposta le dimensioni del cubo
                double dimensioneCubo = 10; // Dimensione del cubo

                IfcCartesianPoint puntoInserimento;
                IfcDirection direzione;
                using (var txn = model.BeginTransaction("Crea Punto Cartesiano"))
                {
                    // Crea il punto cartesiano all'interno della transazione
                     puntoInserimento = model.Instances.New<IfcCartesianPoint>(cp =>
                    {
                        cp.SetXYZ(0, 0, 0); // Imposta le coordinate X, Y, Z per il punto
                    });
                    direzione = model.Instances.New<IfcDirection>(d => d.SetXYZ(1, 0, 0));
                    // Completa la transazione
                    txn.Commit();
                }
                
                var puntiQuadrato = new Coordinate[]
               {
               new Coordinate(0, 0),                       // Punto A (0,0)
               new Coordinate(dimensioneCubo, 0),          // Punto B (dimensioneCubo, 0)
               new Coordinate(dimensioneCubo, dimensioneCubo), // Punto C (dimensioneCubo, dimensioneCubo)
               new Coordinate(0, dimensioneCubo),          // Punto D (0, dimensioneCubo)
               new Coordinate(0, 0)                        // Chiudi il quadrato ritornando al punto A
               };

                // Crea un poligono
                var poligono = new NetTopologySuite.Geometries.Polygon(new LinearRing(puntiQuadrato));                                                                          // Aggiungi l'estrusione del poligono per il solaio
                AggiungiEstrudePolygon(poligono, dimensioneCubo, "cubo prova", puntoInserimento, direzione, "cubo prova","cubo prova",false,false, false, TipoElemento.Parete,null);


                // Inizia una transazione
                using (var txn = model.BeginTransaction("Aggiungi Cubo"))
                {
                    if (EstrudePolygonCor != null)
                    {
                        MessageBox.Show("Cubo aggiunto con successo.", "Successo", MessageBoxButton.OK, MessageBoxImage.Information);
                        var relContainedInSpatialStructure = model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                        {
                            r.RelatingStructure = LocaleCorrente;
                            r.RelatedElements.Add(EstrudePolygonCor);
                        });
                    }

                    // Commetti la transazione
                    txn.Commit();
                  
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Errore durante l'aggiunta del cubo: {ex.Message}", "Errore", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }
        public void AggiungiParete(Line line,double quotapav, double altezza1, double altezza2, double spessore, string elementIdentifier, string descrizione,TDatiSuperficieOpaca DatiOpaca)
        {
            if (drawBimWindow != null) drawBimWindow.enabled = false;
            if (LocaleCorrente == null || GeometricRepresentationContext == null)
            {
                Console.WriteLine("Errore: LocaleCorrente o GeometricRepresentationContext non inizializzati.");
                return;
            }

            try
            {
                // Calcola la lunghezza della parete
                double lunghezza = Math.Sqrt(Math.Pow(line.End.X - line.Start.X, 2) + Math.Pow(line.End.Y - line.Start.Y, 2));

                // Calcola la superficie della parete
                double superficie = lunghezza *(altezza1+ altezza2)/2;
                // bep.Name = $"Vert. {elementIdentifier}";
                //bep.Description = $"Superficie: {superficie:F1} mq, Lunghezza: {lunghezza:F1} m";
                IfcCartesianPoint puntoInserimento;
                IfcDirection direzione;
                using (var txn = model.BeginTransaction("Crea Punto Cartesiano"))
                {
                    // Crea il punto cartesiano all'interno della transazione
                    puntoInserimento = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ((line.Start.X+line.End.X)/2, (line.Start.Y+line.End.Y)/2, quotapav));

                    double deltaX = line.End.X - line.Start.X;
                    double deltaY = line.End.Y - line.Start.Y;
                    double magnitude = Math.Sqrt(deltaX * deltaX + deltaY * deltaY);
                    double dirX = deltaX / magnitude;
                    double dirY = deltaY / magnitude;

                    // Crea la direzione sulla base del calcolo
                    direzione = model.Instances.New<IfcDirection>(d => d.SetXYZ(dirX, dirY, 0));

                    // Completa la transazione
                    txn.Commit();
                }
                //if (altezza1==altezza2)
                //CreaParallelepipedoEstruso(spessore, lunghezza, altezza1, puntoInserimento, direzione, elementIdentifier, descrizione, "Parete", TipoElemento.Parete);
                //else
                CreaParallelepipedoEstrusoH2(spessore, lunghezza, altezza1,altezza2, puntoInserimento, direzione, elementIdentifier, descrizione, "Parete", TipoElemento.Parete, DatiOpaca);
                
                if (!Polig3D.enabled)
                using (var txn = model.BeginTransaction("Aggiungi Parete"))
                {
                    

                    // Associa il proxy alla stanza
                    var relContainedInSpatialStructure = model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                    {
                        r.RelatingStructure = LocaleCorrente; // Usa LocaleCorrente
                        r.RelatedElements.Add(EstrudePolygonCor);
                    });
                    PareteCorrente = EstrudePolygonCor;

                    txn.Commit();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore durante l'aggiunta della parete: {ex.Message}");
            }
            if (drawBimWindow != null) drawBimWindow.enabled = true;
        }
        public void AggiungiPonteOriz(Line line, double quota, double quota2, double spessore, string elementIdentifier, string descrizione,double Altezza=0, EnumOriginePonte OriginePonte = EnumOriginePonte.Parete)
        {
            //return;
            if (drawBimWindow != null) drawBimWindow.enabled = false;
            if ((!Polig3D.enabled) && (PareteCorrente == null || LocaleCorrente == null || GeometricRepresentationContext == null))
            {
                Console.WriteLine("Errore: PareteCorrente, LocaleCorrente o GeometricRepresentationContext non inizializzati.");
                return;
            }

            try
            {
                // Calcola la lunghezza della parete
                double lunghezza = Math.Sqrt(Math.Pow(line.End.X - line.Start.X, 2) + Math.Pow(line.End.Y - line.Start.Y, 2));

                // Calcola la superficie della parete
                double superficie = lunghezza * spessore;
                // bep.Name = $"Vert. {elementIdentifier}";
                //bep.Description = $"Superficie: {superficie:F1} mq, Lunghezza: {lunghezza:F1} m";
                IfcCartesianPoint puntoInserimento;
                IfcDirection direzione;
                using (var txn = model.BeginTransaction("Crea Punto Cartesiano"))
                {
                    // Crea il punto cartesiano all'interno della transazione
                    //puntoInserimento = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ((line.Start.X + line.End.X) / 2, (line.Start.Y + line.End.Y) / 2, quota- spessore/2));
                    //puntoInserimento = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ((line.Start.X + line.End.X) / 2, (line.Start.Y + line.End.Y) / 2, quota-SpesPonte/2));
                    puntoInserimento = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ((line.Start.X + line.End.X) / 2, (line.Start.Y + line.End.Y) / 2,0));

                    double deltaX = line.End.X - line.Start.X;
                    double deltaY = line.End.Y - line.Start.Y;
                    double magnitude = Math.Sqrt(deltaX * deltaX + deltaY * deltaY);
                    double dirX = deltaX / magnitude;
                    double dirY = deltaY / magnitude;

                    // Crea la direzione sulla base del calcolo
                    direzione = model.Instances.New<IfcDirection>(d => d.SetXYZ(dirX, dirY, 0));

                    // Completa la transazione
                    txn.Commit();
                }
                //CreaParallelepipedoEstruso(spessore, lunghezza, spessore, puntoInserimento, direzione, elementIdentifier, descrizione, "Parete", TipoElemento.Ponte, new TDatiSuperficieOpaca(descrizione, lunghezza));
                //CreaParallelepipedoEstrusoH2(double larghezza, double lunghezza, double h1, double h2, IfcCartesianPoint puntoInserimentoIfc, IfcDirection direzione, string elementIdentifier, string descrizione, string tipo, TDatiSuperficieOpaca DatiOpaca)
                //CreaParallelepipedoEstruso(SpesPonte, lunghezza, SpesPonte, puntoInserimento, direzione, elementIdentifier, descrizione, "Parete", TipoElemento.Ponte, new TDatiSuperficieOpaca(descrizione, lunghezza));
                
                void LogPonti()
                {
                    // --- LOG ********************************* ---

                    var start3D = new Coordinate3D(line.Start.X, line.Start.Y, quota);
                    var end3D = new Coordinate3D(line.End.X, line.End.Y, quota2);
                    var centro = new Coordinate3D(
                        (start3D.X + end3D.X) * 0.5,
                        (start3D.Y + end3D.Y) * 0.5,
                        (start3D.Z + end3D.Z) * 0.5
                    );
                    double dx = end3D.X - start3D.X, dy = end3D.Y - start3D.Y, dz = end3D.Z - start3D.Z;
                    double len3D = Math.Sqrt(dx * dx + dy * dy + dz * dz);

                    TermodelLog.WriteLog(
                        $"POnte:{countPonti} '{descrizione}' " +
                        $"Start=({start3D.X:0.###},{start3D.Y:0.###},{start3D.Z:0.###}) " +
                        $"End=({end3D.X:0.###},{end3D.Y:0.###},{end3D.Z:0.###}) " 
                        //+$"C=({centro.X:0.###},{centro.Y:0.###},{centro.Z:0.###}) " 
                        //+$"len3D={len3D:0.###} sp={SpesPonte:0.###} H=({quota:0.###}→{quota2:0.###})"
                        ,
                        LogCategory.PontiAutomatici
                    );
                    // --- FINELOG ********************************* ---
                }
                LogPonti();

                countPonti += 1;
                CreaParallelepipedoEstrusoH2(SpesPonte, lunghezza,quota,quota2, puntoInserimento, direzione, $"Ponte {countPonti}", descrizione, "Ponte", TipoElemento.Ponte, 
                    new TDatiSuperficieOpaca(descrizione, lunghezza, Altezza,
                    new Coordinate3D(line.Start.X, line.Start.Y, quota),
                    new Coordinate3D(line.End.X, line.End.Y, quota2), false));
                //CreaParallelepipedoEstrusoH2(double larghezza, double lunghezza, double h1, double h2, IfcCartesianPoint puntoInserimentoIfc, IfcDirection direzione, string elementIdentifier, string descrizione, string tipo, TDatiSuperficieOpaca DatiOpaca)
                if (!Polig3D.enabled)
                using (var txn = model.BeginTransaction("Aggiungi Parete"))
                {


                    // Associa il proxy alla stanza
                    var relContainedInSpatialStructure = model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                    {
                        r.RelatingStructure = LocaleCorrente; // Usa LocaleCorrente
                        r.RelatedElements.Add(EstrudePolygonCor);
                    });
                    PareteCorrente = EstrudePolygonCor;

                    txn.Commit();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore durante l'aggiunta della parete: {ex.Message}");
            }
            if (drawBimWindow != null) drawBimWindow.enabled = true;
        }
        //public void AggiungiFinestra(TDatiFinestra datiFinestra, Coordinate start, Coordinate end, Coordinate puntoInserimento, double spessoreParete)
        public void AggiungiPonteVert(double quota, Coordinate puntoInserimento, Coordinate start, Coordinate end,  double spessore,double hparete, string elementIdentifier, string descrizione,EnumOriginePonte OriginePonte= EnumOriginePonte.Parete)
        {
            //return;
            if (drawBimWindow != null) drawBimWindow.enabled = false;
            if ((!Polig3D.enabled) && (PareteCorrente == null || LocaleCorrente == null || GeometricRepresentationContext == null))
            {
                Console.WriteLine("Errore: PareteCorrente, LocaleCorrente o GeometricRepresentationContext non inizializzati.");
                return;
            }

            try
            {   /*
                TermodelLog.WriteLog(
                $"[AggiungiPonteVert] Quota: {quota:0.###}, " +
                $"PuntoInserimento=({puntoInserimento.X:0.###},{puntoInserimento.Y:0.###}), " +
                $"Start=({start.X:0.###},{start.Y:0.###}) → End=({end.X:0.###},{end.Y:0.###}), " +
                $"Spessore={spessore:0.##}, Altezza parete={hparete:0.##}, " +
                $"Elemento='{elementIdentifier}', Descrizione='{descrizione}'"
                );
                */
                //double quota = 0;
                // Calcola la lunghezza della parete
                double lunghezza = Math.Sqrt(Math.Pow(end.X - start.X, 2) + Math.Pow(end.Y - start.Y, 2));

                // Calcola la superficie della parete
                double superficie = lunghezza * spessore;
                // bep.Name = $"Vert. {elementIdentifier}";
                //bep.Description = $"Superficie: {superficie:F1} mq, Lunghezza: {lunghezza:F1} m";
                // IfcCartesianPoint puntoInserimento;
                IfcCartesianPoint puntoInserimentoIfc = null;
                IfcDirection direzione;
                using (var txn = model.BeginTransaction("Crea Punto Cartesiano"))
                {
                    // Crea il punto cartesiano all'interno della transazione
                    // puntoInserimento = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ((line.Start.X + line.End.X) / 2, (line.Start.Y + line.End.Y) / 2, quota));
                    puntoInserimentoIfc = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(puntoInserimento.X, puntoInserimento.Y, quota));
                    double deltaX = end.X - start.X;
                    double deltaY = end.Y - start.Y;
                    double magnitude = Math.Sqrt(deltaX * deltaX + deltaY * deltaY);
                    double dirX = deltaX / magnitude;
                    double dirY = deltaY / magnitude;

                    // Crea la direzione sulla base del calcolo
                    direzione = model.Instances.New<IfcDirection>(d => d.SetXYZ(dirX, dirY, 0));

                    // Completa la transazione
                    txn.Commit();
                }
                //CreaParallelepipedoEstruso(spessore, spessore, hparete, puntoInserimentoIfc, direzione, elementIdentifier, descrizione, "Ponte Termico", TipoElemento.Ponte, new TDatiSuperficieOpaca(descrizione, lunghezza));
                countPonti += 1;
                var start3D = new Coordinate3D(puntoInserimentoIfc.X, puntoInserimentoIfc.Y, quota);
                var end3D = new Coordinate3D(puntoInserimentoIfc.X, puntoInserimentoIfc.Y, quota+hparete);

                void LogPonti()
                {
                    // LOG *********************
                    var centro = new Coordinate3D(
                        (start3D.X + end3D.X) * 0.5,
                        (start3D.Y + end3D.Y) * 0.5,
                        (start3D.Z + end3D.Z) * 0.5
                    );
                    double dx = end3D.X - start3D.X, dy = end3D.Y - start3D.Y, dz = end3D.Z - start3D.Z;
                    double len3D = Math.Sqrt(dx * dx + dy * dy + dz * dz);

                    // opzionale: check atteso per un ponte verticale (Z finale ≈ quota + hparete)
                    double zExpectedEnd = quota + hparete;
                    double dzExpected = zExpectedEnd - start3D.Z;

                    // tolleranze locali (se hai già APR globali, usa quelle)
                    const double APR = 0.01; // XY
                    const double APRz = 0.01; // Z

                    // log informativo
                    TermodelLog.WriteLog(
                        $"Ponte:{countPonti} '{descrizione}' " +
                        $"Start=({start3D.X:0.###},{start3D.Y:0.###},{start3D.Z:0.###}) " +
                        $"End=({end3D.X:0.###},{end3D.Y:0.###},{end3D.Z:0.###}) " 
                        //+$"C=({centro.X:0.###},{centro.Y:0.###},{centro.Z:0.###}) " 
                        //+$"len3D={len3D:0.###} sp=({SpesPonte:0.###},{SpesPonte:0.###}) h={hparete:0.###}"
                        ,
                        LogCategory.PontiAutomatici
                    );

                    /* warning diagnostici utili a capire disallineamenti
                    if (Math.Sqrt(dx * dx + dy * dy) > APR)
                        TermodelLog.WriteLog($"[Ponti][WARN] Ponte VERT con XY≠0 (dx={dx:0.###}, dy={dy:0.###})", LogCategory.PontiAutomatici);

                    if (Math.Abs(dzExpected - dz) > APRz)
                        TermodelLog.WriteLog($"[Ponti][WARN] ΔZ atteso={dzExpected:0.###} diverso da ΔZ attuale={dz:0.###} (end.Z atteso={zExpectedEnd:0.###})", LogCategory.PontiAutomatici);
                    */ 
                    // LOG *********************
                }
                LogPonti();

                CreaParallelepipedoEstruso(SpesPonte, SpesPonte, hparete, puntoInserimentoIfc, direzione, $"Ponte {countPonti}", descrizione, "Ponte Termico", TipoElemento.Ponte, new TDatiSuperficieOpaca(descrizione, lunghezza,0, start3D, end3D,true));

                if (!Polig3D.enabled)
                using (var txn = model.BeginTransaction("Aggiungi Parete"))
                {


                    // Associa il proxy alla stanza
                    var relContainedInSpatialStructure = model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                    {
                        r.RelatingStructure = LocaleCorrente; // Usa LocaleCorrente
                        r.RelatedElements.Add(EstrudePolygonCor);
                    });
                    PareteCorrente = EstrudePolygonCor;

                    txn.Commit();
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine($"Errore durante l'aggiunta della parete: {ex.Message}");
            }
            if (drawBimWindow != null) drawBimWindow.enabled = true;
        }
        public void AggiungiFinestra(TDatiFinestra datiFinestra, Coordinate start, Coordinate end, Coordinate puntoInserimento, double spessoreParete)
        {
            //return;
            if (drawBimWindow != null) drawBimWindow.enabled = false;
            // Assicurati che PareteCorrente, LocaleCorrente e GeometricRepresentationContext siano inizializzati

            if ((!Polig3D.enabled)&&(PareteCorrente == null || LocaleCorrente == null || GeometricRepresentationContext == null))
            {
                Console.WriteLine("Errore: PareteCorrente, LocaleCorrente o GeometricRepresentationContext non inizializzati.");
                return;
            }
            
            
            try
            {
                // Converti le dimensioni della finestra da stringhe a double
                double larghezzaFinestra = Convert.ToDouble(datiFinestra.Larghezza, CultureInfo.InvariantCulture);
                double altezzaFinestra = Convert.ToDouble(datiFinestra.Altezza, CultureInfo.InvariantCulture);
                double sottofinestra = datiFinestra.Sottofinestra;

                //puntoInserimento.Z = sottofinestra;
                IfcCartesianPoint puntoInserimentoIfc = null;
                //double spessore = spessoreParete * 1.2;
                double spessore = SpesPonte;
                // Calcola la lunghezza della parete
                double lunghezza = Math.Sqrt(Math.Pow(end.X - start.X, 2) + Math.Pow(end.Y - start.Y, 2));

                // Calcola la superficie della parete
                double superficie = lunghezza * altezzaFinestra;
                // bep.Name = $"Vert. {elementIdentifier}";
                //bep.Description = $"Superficie: {superficie:F1} mq, Lunghezza: {lunghezza:F1} m";
                //IfcCartesianPoint puntoInserimento;
                IfcDirection direzione;
                using (var txn = model.BeginTransaction("Crea Punto Cartesiano"))
                {
                    // Crea il punto cartesiano all'interno della transazione
                    //puntoInserimento = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ((line.Start.X + line.End.X) / 2, (line.Start.Y + line.End.Y) / 2, 0));
                    puntoInserimentoIfc = model.Instances.New<IfcCartesianPoint>(cp => cp.SetXYZ(puntoInserimento.X, puntoInserimento.Y, sottofinestra));
                    double deltaX = end.X - start.X;
                    double deltaY = end.Y - start.Y;
                    double magnitude = Math.Sqrt(deltaX * deltaX + deltaY * deltaY);
                    double dirX = deltaX / magnitude;
                    double dirY = deltaY / magnitude;

                    // Crea la direzione sulla base del calcolo
                    direzione = model.Instances.New<IfcDirection>(d => d.SetXYZ(dirX, dirY, 0));

                    // Completa la transazione
                    txn.Commit();
                }

                CreaParallelepipedoEstruso(spessore, larghezzaFinestra, altezzaFinestra, puntoInserimentoIfc, direzione, $"Finestra {datiFinestra.Tipo}", datiFinestra.Descrizione, "Finestra", TipoElemento.Finestra,new TDatiSuperficieOpaca(datiFinestra.Id, datiFinestra.Tipo, datiFinestra.Altezza, datiFinestra.Larghezza,datiFinestra.Sottofinestra,datiFinestra.NumeroAnte, datiFinestra.Sopraluce));

                if (!Polig3D.enabled)
                using (var txn = model.BeginTransaction("Aggiungi Parete"))
                {

                    //PareteCorrente = EstrudePolygonCor;
                    // Associa il proxy alla parete
                    /*
                    var relContainedInSpatialStructure = model.Instances.New<IfcRelContainedInSpatialStructure>(r =>
                     {
                        r.RelatingStructure = LocaleCorrente; // Usa LocaleCorrente
                        r.RelatedElements.Add(EstrudePolygonCor);
                    });
                   */
                    /* 
                    var relVoidsElement = model.Instances.New<IfcRelVoidsElement>(r =>
                    {
                     r.RelatingBuildingElement = PareteCorrente; // Usa PareteCorrente
                      r.RelatedOpeningElement = EstrudePolygonCor; // Utilizza 'opening' (la finestra appena creata)
                    });
                    */


                    var relAggregates = model.Instances.New<IfcRelAggregates>(rel =>
                        {
                        rel.RelatingObject = PareteCorrente; // L'elemento principale è la parete
                        rel.RelatedObjects.Add(EstrudePolygonCor); // La finestra è un componente della parete
                         });

                        txn.Commit();
                    
                }
            }
            catch (Exception ex)
            {
                TermodelLog.LogError($"Errore durante l'aggiunta della parete: {ex.Message}");
                Console.WriteLine($"Errore durante l'aggiunta della parete: {ex.Message}");
            }
            // Associa la finestra alla parete con IfcRelVoidsElement (relazione sottrattiva)
            /*

            var relVoidsElement = model.Instances.New<IfcRelVoidsElement>(r =>
            {
                r.RelatingBuildingElement = PareteCorrente; // Usa PareteCorrente
                r.RelatedOpeningElement = opening; // Utilizza 'opening' (la finestra appena creata)
            });
            */
            if (drawBimWindow != null) drawBimWindow.enabled = true;
        }
  
        public void Close_modello(string outputPath,string PathXMLBase,string PathXMlOut)
        {
            if (drawBimWindow != null) drawBimWindow.lineManager.VisualizzaLineeBIM();
            Polig3D.InitClass();
            Polig3D.TrovaConfini(model, GeometricRepresentationContext);
            Confini.CorreggiPonti();
            //if (GeneraBim)
                Polig3D.RedrawBim(model, GeometricRepresentationContext);
           
            if (Polig3D.enabled && GeneraXml) GestXml.GeneraXml(PathXMLBase, PathXMlOut, direzNord);

            Polig3D.GrafRedraw(true);
            
            
            //if (GeneraBim) 
                model.SaveAs(outputPath);
            
            model.Dispose();
        }
    }
}
