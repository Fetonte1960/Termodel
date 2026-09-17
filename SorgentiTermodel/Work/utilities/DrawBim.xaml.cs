using System;
using System.Windows;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Media3D;
using System.Collections.Generic;
using NetTopologySuite.Geometries;
using System.Windows.Controls;
using Xbim.Common.Geometry;
using HelixToolkit.Wpf;
using Xbim.Ifc4.Interfaces;
using Xbim.Ifc4.GeometryResource;
using Xbim.Ifc4;
using NetTopologySuite.Index.HPRtree;
using Xbim.Common.Model;
using static Polig3D;
using static Termodel.Modello;
using static Termodel.utilities.UtiBimNTS;
using Termodel.Leggidxf;
using NetTopologySuite.Algorithm;
//using System.Windows.Forms;
using System.Windows.Shapes;
using NetTopologySuite.Utilities;
using Termodel.utilities;
using static System.Windows.Forms.DataFormats;
using NetTopologySuite.Triangulate;
using netDxf;
using netDxf.Entities;
using static Termodel.utilities.TermodelLog;
using System.Globalization;
using System.Xml.Linq;

namespace Termodel.utilities
{
 public static class DrBim
    {
        public static HelixViewport3D WP = null;
        public static DrawBim Class = null;
    }
    public partial class DrawBim : UserControl
    {
        private PerspectiveCamera camera;
        private PerspectiveCamera tempcamera;
        private bool isRotating = false;
        private System.Windows.Point previousMousePosition;
        private Point3D centerOfRotation;
        public LineManager lineManager;
        public bool enabled = true;
        public MaterialGroup materialGroup;
        // Proprietà della classe per i limiti
        private double MinX { get; set; } = double.MaxValue;
        private double MinY { get; set; } = double.MaxValue;
        private double MinZ { get; set; } = double.MaxValue;
        private double MaxX { get; set; } = double.MinValue;
        private double MaxY { get; set; } = double.MinValue;
        private double MaxZ { get; set; } = double.MinValue;
        public void LimitiModelloPunto(Point3D point)
        {
            double x = point.X ;
            double y = point.Y ;
            double z = point.Z ;


            MinX = Math.Min(MinX, x);
            MinY = Math.Min(MinY, y);
            MinZ = Math.Min(MinZ, z);

            MaxX = Math.Max(MaxX, x);
            MaxY = Math.Max(MaxY, y);
            MaxZ = Math.Max(MaxZ, z);
        }
        public void CalcolaLimitiInputDXF()
        {
            var limiti =HelixDXF.I.CalcolaLimitiDxf();

            MinX = limiti.MinX;
            MaxX = limiti.MaxX;
            MinY = limiti.MinY;
            MaxY = limiti.MaxY;
            MinZ = limiti.MinZ;
            MaxZ = limiti.MaxZ;
        }

        public void LimitiModello(IfcPolyline polyifc, double baseHeight, Point3D insertionPoint)
        {
            if (polyifc == null || polyifc.Points.Count == 0)
            {
                Console.WriteLine("Poligono non valido.");
                return;
            }

            // Itera sui punti del poligono per aggiornare i limiti
            foreach (var point in polyifc.Points)
            {
                double x = point.X + insertionPoint.X;
                double y = point.Y + insertionPoint.Y;
                double z = baseHeight + point.Z + insertionPoint.Z;
                

                MinX = Math.Min(MinX, x);
                MinY = Math.Min(MinY, y);
                MinZ = Math.Min(MinZ, z);

                MaxX = Math.Max(MaxX, x);
                MaxY = Math.Max(MaxY, y);
                MaxZ = Math.Max(MaxZ, z);
            }

           // Console.WriteLine($"Limiti aggiornati: MinX={MinX}, MinY={MinY}, MinZ={MinZ}, MaxX={MaxX}, MaxY={MaxY}, MaxZ={MaxZ}");
        }
        public void ResetLimits()
        {
            // Imposta i minimi al massimo valore possibile
            MinX = double.MaxValue;
            MinY = double.MaxValue;
            MinZ = double.MaxValue;

            // Imposta i massimi al minimo valore possibile
            MaxX = double.MinValue;
            MaxY = double.MinValue;
            MaxZ = double.MinValue;
        }
        public void SetCamera()
        {
            // Calcola il centro del modello
            double centerX = (MinX + MaxX) / 2;
            double centerY = (MinY + MaxY) / 2;
            double centerZ = (MinZ + MaxZ) / 2;

            // Calcola la dimensione massima del modello (per determinare la distanza della camera)
            double sizeX = MaxX - MinX;
            double sizeY = MaxY - MinY;
            double sizeZ = MaxZ - MinZ;
            double maxSize = Math.Max(sizeX, Math.Max(sizeY, sizeZ));

            // Imposta il centro di rotazione al centro del modello
            Point3D centerOfRotation = new Point3D(centerX, centerY, centerZ);

            // Imposta la posizione della camera sull'asse X, abbastanza lontano per inquadrare tutto il modello
            double distance = maxSize * 2; // Regola il fattore di distanza per adattare lo zoom iniziale
            Point3D cameraPosition = new Point3D(0,centerX + distance, centerZ);

            // Calcola la direzione di visuale (dalla posizione della camera verso il centro del modello)
            Vector3D lookDirection = centerOfRotation - cameraPosition;
            lookDirection.Normalize();

            // Crea e imposta la fotocamera
            var camera = new PerspectiveCamera
            {
                Position = cameraPosition,
                LookDirection = lookDirection,
                UpDirection = new Vector3D(0, 0, 1), // L'asse Z è l'alto
                FieldOfView = 45 // Campo visivo
            };

            // Assegna la fotocamera al viewport
            viewport.Camera = camera;

            // Imposta il centro di rotazione
            viewport.CameraController.CameraTarget = centerOfRotation;
        }
 
        public DrawBim()
        {
            InitializeComponent();
            InitializeScene();
            DrBim.WP =this.viewport;
            DrBim.Class = this;
        }
        //------------------------------ Derivato dal form
        private void AddLights(HelixViewport3D viewport)
        {
            // Luce direzionale
            var directionalLight = new DirectionalLight(Colors.White, new Vector3D(-1, -1, -1));
            viewport.Children.Add(new ModelVisual3D { Content = directionalLight });

            // Luce ambientale
            var ambientLight = new AmbientLight(Colors.Gray);
            viewport.Children.Add(new ModelVisual3D { Content = ambientLight });
        }

        private void AddCube(HelixViewport3D viewport)
        {
            // Crea il materiale del cubo
            var material = new DiffuseMaterial(new SolidColorBrush(Colors.Blue));

            // Crea le posizioni dei vertici del cubo
            var positions = new Point3DCollection
            {
                // Faccia anteriore
                new Point3D(-1, -1, 1),
                new Point3D(1, -1, 1),
                new Point3D(1, 1, 1),
                new Point3D(-1, 1, 1),

                // Faccia posteriore
                new Point3D(-1, -1, -1),
                new Point3D(1, -1, -1),
                new Point3D(1, 1, -1),
                new Point3D(-1, 1, -1)
            };

            // Indici per triangolazione
            var triangleIndices = new Int32Collection
            {
                // Faccia anteriore
                0, 1, 2, 2, 3, 0,
                // Faccia posteriore
                4, 5, 6, 6, 7, 4,
                // Faccia superiore
                3, 2, 6, 6, 7, 3,
                // Faccia inferiore
                0, 1, 5, 5, 4, 0,
                // Faccia sinistra
                0, 3, 7, 7, 4, 0,
                // Faccia destra
                1, 2, 6, 6, 5, 1
            };

            // Normali per ogni faccia
            var normals = new Vector3DCollection
            {
                new Vector3D(0, 0, 1), new Vector3D(0, 0, 1), new Vector3D(0, 0, 1), new Vector3D(0, 0, 1),
                new Vector3D(0, 0, -1), new Vector3D(0, 0, -1), new Vector3D(0, 0, -1), new Vector3D(0, 0, -1),
                new Vector3D(0, 1, 0), new Vector3D(0, 1, 0), new Vector3D(0, 1, 0), new Vector3D(0, 1, 0),
                new Vector3D(0, -1, 0), new Vector3D(0, -1, 0), new Vector3D(0, -1, 0), new Vector3D(0, -1, 0),
                new Vector3D(-1, 0, 0), new Vector3D(-1, 0, 0), new Vector3D(-1, 0, 0), new Vector3D(-1, 0, 0),
                new Vector3D(1, 0, 0), new Vector3D(1, 0, 0), new Vector3D(1, 0, 0), new Vector3D(1, 0, 0)
            };

            // Crea la geometria del cubo
            var mesh = new MeshGeometry3D
            {
                Positions = positions,
                TriangleIndices = triangleIndices,
                Normals = normals
            };

            // Crea il modello 3D
            var geometryModel = new GeometryModel3D(mesh, material);

            // Aggiungi il modello al Viewport
            viewport.Children.Add(new ModelVisual3D { Content = geometryModel });
        }
        //-------------------------------------------------------------------------
        private void InitializeSceneOld()
        {
            // Inizializza la camera
            camera = new PerspectiveCamera
            {
                Position = new Point3D(0, 0, 30),
                LookDirection = new Vector3D(0, 0, -1),
                UpDirection = new Vector3D(0, 1, 0),
                FieldOfView = 45
            };
            tempcamera = new PerspectiveCamera
            {
                Position = new Point3D(0, 0, 30),
                LookDirection = new Vector3D(0, 0, -1),
                UpDirection = new Vector3D(0, 1, 0),
                FieldOfView = 45
            };
            viewport.Camera = camera;

            // Inizializza il gestore delle linee
            lineManager = new LineManager(this);

            // Aggiungi una luce direzionale
            var light = new DirectionalLight(Colors.Red, new Vector3D(1, -1, -1));
            // Direzione allineata con la camera

            var lightModel = new ModelVisual3D { Content = light };
            viewport.Children.Add(lightModel);
            var ambientLight = new AmbientLight(Colors.Red);
            var ambientLightModel = new ModelVisual3D { Content = ambientLight };
            viewport.Children.Add(ambientLightModel);
            var pointLight = new PointLight
            {
                Color = Colors.Red,
                Position = new Point3D(0, 10, 0), // Posizione della luce
                Range = 100                        // Distanza entro cui la luce è visibile
            };
            var pointLightModel = new ModelVisual3D { Content = pointLight };
            viewport.Children.Add(pointLightModel);
            // Centro di rotazione (default: origine)
            centerOfRotation = new Point3D(0, 0, 0);
            DiffuseMaterial diffuseMaterial = new DiffuseMaterial(new SolidColorBrush(Colors.Blue));
            SpecularMaterial specularMaterial = new SpecularMaterial(new SolidColorBrush(Colors.White), 30);

            materialGroup = new MaterialGroup();
            materialGroup.Children.Add(diffuseMaterial);
            materialGroup.Children.Add(specularMaterial);
            

        }
        public void SetCamera(HelixViewport3D viewport, Point3D lookAtPoint, Point3D observationPoint)
        {
            // Controllo dell'input
            if (viewport.Camera == null)
            {
                throw new InvalidOperationException("La viewport non contiene una fotocamera valida.");
            }

            // Calcola la direzione di osservazione
            Vector3D lookDirection = lookAtPoint - observationPoint;
            lookDirection.Normalize(); // Normalizza la direzione

            // Imposta la fotocamera come prospettica
            if (viewport.Camera is PerspectiveCamera perspectiveCamera)
            {
                perspectiveCamera.Position = observationPoint; // Posizione della fotocamera
                perspectiveCamera.LookDirection = lookDirection; // Direzione di osservazione
                perspectiveCamera.UpDirection = new Vector3D(0, 1, 0); // Direzione "Up" (asse Y)
            }
            else if (viewport.Camera is OrthographicCamera orthographicCamera)
            {
                orthographicCamera.Position = observationPoint; // Posizione della fotocamera
                orthographicCamera.LookDirection = lookDirection; // Direzione di osservazione
                orthographicCamera.UpDirection = new Vector3D(0, 1, 0); // Direzione "Up" (asse Y)
            }
            else
            {
                throw new NotSupportedException("Tipo di fotocamera non supportato.");
            }

            // Facoltativo: centra il punto di mira nella viewport
           // viewport.CameraController?.LookAt(lookAtPoint, (lookAtPoint - observationPoint).Length, 500);
        }
        private void InitializeScene()
        {
            centerOfRotation = new Point3D(0, 0, 0);
           
            Point3D poscamera = new Point3D(25, 0, 10); // Più vicino alla scena
                                                      // Calcola la direzione di visuale
                                                      // Aggiungi una fotocamera
            Vector3D lookdirection = centerOfRotation - poscamera;
            lookdirection.Normalize(); // Normalizza la direzione
            //Vector3D lookdirection = new Vector3D(-1, 0, 0);
            var camera = new PerspectiveCamera
            {
                Position =  poscamera,
                LookDirection = lookdirection,
                UpDirection = new Vector3D(0, 0,1),
                FieldOfView = 45
            };
            viewport.Camera = camera;
            

            // Aggiungi luci
            AddLights(viewport);
            DiffuseMaterial diffuseMaterial = new DiffuseMaterial(new SolidColorBrush(Colors.Blue));
            SpecularMaterial specularMaterial = new SpecularMaterial(new SolidColorBrush(Colors.White), 30);

            materialGroup = new MaterialGroup();
            materialGroup.Children.Add(diffuseMaterial);
            materialGroup.Children.Add(specularMaterial);


            // Aggiungi un cubo
            //AddCube(viewport);


        }
        public void SvuotaBuffer()
        {
            viewport.Children.Clear();
            DrawBimJson.Clear();
            ResetLimits();
            AddLights(viewport);
            return;
            // Controlla che il viewport esista
            if (viewport != null && viewport.Children != null)
            {
                // Crea una lista temporanea per evitare modifiche alla collezione durante l'iterazione
                var itemsToRemove = new List<Visual3D>();

                // Filtra gli elementi da rimuovere
                foreach (var child in viewport.Children)
                {
                    // Rimuovi solo le geometrie (ModelVisual3D)
                    if (child is ModelVisual3D && !(child is LightVisual3D))
                    {
                        itemsToRemove.Add(child);
                    }
                }

                // Rimuovi gli elementi identificati
                foreach (var item in itemsToRemove)
                {
                    viewport.Children.Remove(item);
                }
            }
        }
        public void Redraw(bool RecalcView)
        {        
            if (viewport != null)
            {
                if (RecalcView) SetCamera();
                viewport.InvalidateVisual(); // Forza il ridisegno del Viewport3D
                DrawBimJson.SalvaJson();
            }
        }
        public void CreateExtrudedObject(HelixViewport3D viewport)
        {
            // 1. Creare un profilo 2D (ad esempio, un rettangolo)
            var profilo = new PointCollection
    {
        new System.Windows.Point(0, 0), // Punto in basso a sinistra
        new System.Windows.Point(1, 0), // Punto in basso a destra
        new System.Windows.Point(1, 1), // Punto in alto a destra
        new System.Windows.Point(0, 1), // Punto in alto a sinistra
        new System.Windows.Point(0, 0)  // Tornare al punto di partenza
    };

            // 2. Creare un oggetto ExtrudedVisual3D
            var estruso = new ExtrudedVisual3D
            {
                Section = profilo,                // Profilo da estrudere
                Path = new Point3DCollection      // Percorso dell'estrusione
        {
            new Point3D(0, 0, 0),         // Punto iniziale
            new Point3D(0, 0, 2)          // Punto finale (altezza di 2 unità)
        },
                Fill = Brushes.Blue               // Colore di riempimento
            };

            // 3. Aggiungere l'oggetto estruso al viewport
            viewport.Children.Add(estruso);

            // Altezza dell'estrusione
            double extrusionHeight = 2.0;

            // Creazione del MeshBuilder per il corpo principale
            var builder = new MeshBuilder();
            // Aggiungere il tappo inferiore
            AddCap(builder, profilo, new Point3D(0, 0, 0), true);

            // Aggiungere il tappo superiore
            AddCap(builder, profilo, new Point3D(0, 0, extrusionHeight), false);
            // Creare la mesh
            var mesh = builder.ToMesh();

            // Materiale
            var material = new DiffuseMaterial(new SolidColorBrush(Colors.Blue));

            // Creare il modello 3D
            var geometryModel = new GeometryModel3D(mesh, material);

            // Aggiungere al viewport
            viewport.Children.Add(new ModelVisual3D { Content = geometryModel });
        }
        private bool IsConvex(System.Windows.Point a, System.Windows.Point b, System.Windows.Point c)
        {
            double cross = (b.X - a.X) * (c.Y - a.Y) - (b.Y - a.Y) * (c.X - a.X);
            return cross < 0; // assume winding antiorario
        }

        private bool PointInTriangle(System.Windows.Point p, System.Windows.Point a, System.Windows.Point b, System.Windows.Point c)
        {
            double area = 0.5 * (-b.Y * c.X + a.Y * (-b.X + c.X) + a.X * (b.Y - c.Y) + b.X * c.Y);
            double s = 1.0 / (2.0 * area) * (a.Y * c.X - a.X * c.Y + (c.Y - a.Y) * p.X + (a.X - c.X) * p.Y);
            double t = 1.0 / (2.0 * area) * (a.X * b.Y - a.Y * b.X + (a.Y - b.Y) * p.X + (b.X - a.X) * p.Y);

            return s >= 0 && t >= 0 && (s + t) <= 1;
        }


        private List<int[]> TriangulatePolygon_alternativa(PointCollection profile)
        {
            var triangles = new List<int[]>();

            if (profile == null || profile.Count < 3)
                return triangles;

            // Copia lista originale
            var points = profile.ToList();
            var indices = Enumerable.Range(0, points.Count).ToList();

            int n = points.Count;
            int count = 0;

            while (indices.Count > 3 && count < 1000)
            {
                count++;

                bool earFound = false;
                for (int i = 0; i < indices.Count; i++)
                {
                    int i0 = indices[(i + indices.Count - 1) % indices.Count];
                    int i1 = indices[i];
                    int i2 = indices[(i + 1) % indices.Count];

                    var a = points[i0];
                    var b = points[i1];
                    var c = points[i2];

                    if (!IsConvex(a, b, c))
                        continue;

                    bool contains = false;
                    for (int j = 0; j < indices.Count; j++)
                    {
                        int idx = indices[j];
                        if (idx == i0 || idx == i1 || idx == i2)
                            continue;

                        if (PointInTriangle(points[idx], a, b, c))
                        {
                            contains = true;
                            break;
                        }
                    }

                    if (!contains)
                    {
                        triangles.Add(new[] { i0, i1, i2 });
                        indices.RemoveAt(i);
                        earFound = true;
                        break;
                    }
                }

                if (!earFound)
                    break; // Poligono malformato
            }

            // Triangolo finale
            if (indices.Count == 3)
                triangles.Add(indices.ToArray());

            return triangles;
        }
        private List<int[]> TriangulatePolygon(PointCollection profile)
        {
            var triangles = new List<int[]>();

            if (profile.Count < 3)
                return triangles;

            var coordinates = profile.Select(p => new Coordinate(p.X, p.Y)).ToList();
            if (!coordinates[0].Equals2D(coordinates[^1]))
                coordinates.Add(coordinates[0]); // chiusura

            var geometryFactory = new GeometryFactory();
            var polygon = geometryFactory.CreatePolygon(coordinates.ToArray());

            var triangulationBuilder = new DelaunayTriangulationBuilder();
            triangulationBuilder.SetSites(polygon);
            var triangulated = triangulationBuilder.GetTriangles(geometryFactory);

            var coordToIndex = new Dictionary<string, int>();
            for (int i = 0; i < coordinates.Count - 1; i++) // Ignora duplicato finale
            {
                var key = $"{coordinates[i].X:F6}_{coordinates[i].Y:F6}";
                coordToIndex[key] = i;
            }

            var scartati = new List<string>();
            var validi = new List<string>();

            foreach (NetTopologySuite.Geometries.Polygon triangle in triangulated.Geometries)
            {
                var triCoords = triangle.Coordinates.Take(3).ToList();
                var triIndices = new List<int>();

                foreach (var c in triCoords)
                {
                    var key = $"{c.X:F6}_{c.Y:F6}";
                    if (coordToIndex.TryGetValue(key, out var index))
                        triIndices.Add(index);
                }

                if (IsTriangleInsidePolygon(polygon, triangle) && triIndices.Count == 3)
                {
                    triangles.Add(triIndices.ToArray());
                    validi.Add($"✔️ ({triIndices[0]},{triIndices[1]},{triIndices[2]})");
                }
                else
                {
                    var coords = triCoords.Select(tc => $"({tc.X:F2},{tc.Y:F2})");
                    scartati.Add($"❌ {string.Join(" - ", coords)}");
                }
            }

            // 🔎 Log finale
            var logMsg = $"🔺 Triangolazione completata: {triangles.Count} triangoli validi su {triangulated.NumGeometries} totali.\n";

            if (validi.Count > 0)
                logMsg += "\n✅ Triangoli validi:\n" + string.Join("\n", validi);

            if (scartati.Count > 0)
                logMsg += "\n\n⛔ Triangoli scartati (fuori dal poligono):\n" + string.Join("\n", scartati);

            Termodel.utilities.TermodelLog.WriteLog(logMsg, category: Termodel.utilities.TermodelLog.LogCategory.RedrawHelix);

            return triangles;
        }

        private List<int[]> TriangulatePolygonsenzalog(PointCollection profile)
        {
            var triangles = new List<int[]>();

            if (profile.Count < 3)
                return triangles;

            // 1. Converti il profilo in Coordinate[]
            var coordinates = profile.Select(p => new Coordinate(p.X, p.Y)).ToList();
            if (!coordinates[0].Equals2D(coordinates[^1]))
                coordinates.Add(coordinates[0]); // chiusura

            var geometryFactory = new GeometryFactory();
            var polygon = geometryFactory.CreatePolygon(coordinates.ToArray());

            // 2. Costruisci la triangolazione NTS
            var triangulationBuilder = new DelaunayTriangulationBuilder();
            triangulationBuilder.SetSites(polygon);
            var triangulated = triangulationBuilder.GetTriangles(geometryFactory);

            // 3. Mappa coordinate → indice
            var coordToIndex = new Dictionary<string, int>();
            for (int i = 0; i < coordinates.Count - 1; i++) // Ignora ultimo punto (duplicato)
            {
                var key = $"{coordinates[i].X:F6}_{coordinates[i].Y:F6}";
                coordToIndex[key] = i;
            }

            // 4. Filtro triangoli validi
            foreach (NetTopologySuite.Geometries.Polygon triangle in triangulated.Geometries)
            {
                if (!IsTriangleInsidePolygon(polygon, triangle))
                    continue;

                var triCoords = triangle.Coordinates.Take(3).ToList();
                var triIndices = new List<int>();

                foreach (var c in triCoords)
                {
                    var key = $"{c.X:F6}_{c.Y:F6}";
                    if (coordToIndex.TryGetValue(key, out var index))
                        triIndices.Add(index);
                }TermodelLog.WriteLog("", category: TermodelLog.LogCategory.RedrawHelix);

                if (triIndices.Count == 3)
                    triangles.Add(triIndices.ToArray());
            }

            return triangles;
        }


        private void AddCap(MeshBuilder builder, PointCollection profile, Point3D origin, bool isBottom)
        {
            // Offset per creare il tappo sul piano specificato (base o top)
            var points = new List<Point3D>();
            foreach (var point in profile)
            {
                points.Add(new Point3D(origin.X + point.X, origin.Y + point.Y, origin.Z));
            }

            // Triangolazione per il tappo
            var indices = TriangulatePolygon(profile);

            // Aggiungere i triangoli alla mesh
            foreach (var triangle in indices)
            {
                if (!isBottom)
                //if (false)
                {
                    // Tappo inferiore
                    builder.AddTriangle(points[triangle[2]], points[triangle[1]], points[triangle[0]]);
                }
                else
                {
                    // Tappo superiore
                    builder.AddTriangle(points[triangle[0]], points[triangle[1]], points[triangle[2]]);
                }
            }
        }

        private List<int[]> TriangulatePolygonOld(PointCollection profile)
        {
            // Algoritmo di triangolazione semplificato
            // Restituisce una lista di indici che rappresentano i triangoli
            var indices = new List<int[]>();
            for (int i = 1; i < profile.Count - 1; i++)
            {
                indices.Add(new[] { 0, i, i + 1 });
            }
            return indices;
        }
        public MeshGeometry3D AddPolygonExample()
        {
            // 1. Definizione del profilo del poligono (un quadrato)
            var points = new List<System.Windows.Point>
    {
        new System.Windows.Point(0, 0), // Vertice in basso a sinistra
        new System.Windows.Point(1, 0), // Vertice in basso a destra
        new System.Windows.Point(1, 1), // Vertice in alto a destra
        new System.Windows.Point(0, 1),  // Vertice in alto a sinistra
        new System.Windows.Point(0, 0)
    };

            // 2. Definizione degli assi del piano
            var axisX = new Vector3D(1, 0, 0); // Asse X locale
            var axisY = new Vector3D(0, 1, 0); // Asse Y locale inclinato

            // 3. Punto di origine del poligono
            var origin = new Point3D(0, 0, 0);

            // 4. Creazione della mesh
            var builder = new MeshBuilder();

            // Aggiunta del poligono alla mesh
            builder.AddPolygon(points, axisX, axisY, origin);

            // 5. Generazione della mesh
            var mesh = builder.ToMesh();

            return mesh;
        }
        /// <summary>
        /// Converte un triangolo 3D in un triangolo 2D proiettato sul piano XY, calcolando:
        /// - La proiezione 2D del triangolo
        /// - Gli angoli di rotazione sugli assi X e Y necessari per ricostruire il triangolo 3D
        /// - Lo spostamento verticale (zIns) per portare il triangolo alla quota minima (Z=0)
        /// Input: Array 3x3 di coordinate 3D (tre vertici del triangolo).
        /// Output: Triangolo 2D, angoli di rotazione e zIns.
        /// </summary>

        /*--------------------------------------------------------------------
        viene facile calcolare ce coordinate della falda in 3d (cartesiano), ma per rappresentare in
            helix abbiamo a disposizione solo un poligono estruso sul piano xy a cui possiamo applicare rotazioni varie(sistema polare) 
        per cui dobbiamo adattare le indormazioni disponibili al sistema grafico HelixToolkyt
        */
        public static (PointCollection amplified2D, Vector3D translationPoint) TriangoloDaCartesianoAPolare(IfcPolyline polyifc, ref double rotZ, ref double rotY,
            string ID, string Descrizione)
        {
            // Rimuovi il punto duplicato, se presente
            var points = polyifc.Points.ToList();
            if (points.Count > 3 &&
                points[0].X == points[points.Count - 1].X &&
                points[0].Y == points[points.Count - 1].Y &&
                points[0].Z == points[points.Count - 1].Z)
            {
                points.RemoveAt(points.Count - 1); // Rimuovi l'ultimo punto duplicato
            }

            if (points.Count != 3)
            {
                throw new ArgumentException("Il triangolo deve avere esattamente 3 punti.");
            }

            PointCollection amplified2D = null;

            // Caso speciale: piano orizzontale
            if (Math.Abs(points[0].Z - points[1].Z) < 1e-6 && Math.Abs(points[0].Z - points[2].Z) < 1e-6)
            {
                //TermodelLog.WriteLog($"[DEBUG] Triangolo ID {ID} rilevato come piano orizzontale. Z = {points[0].Z:F4}");

                amplified2D = new PointCollection
        {
            new System.Windows.Point(points[0].X, points[0].Y),
            new System.Windows.Point(points[1].X, points[1].Y),
            new System.Windows.Point(points[2].X, points[2].Y)
        };

                // Non serve traslazione in questo caso
                return (amplified2D, new Vector3D(0, 0, points[0].Z));
            }

            // Step 1: Calcola la normale
            var p1 = points[0];
            var p2 = points[1];
            var p3 = points[2];

            var v1 = new Vector3D(p2.X - p1.X, p2.Y - p1.Y, p2.Z - p1.Z);
            var v2 = new Vector3D(p3.X - p1.X, p3.Y - p1.Y, p3.Z - p1.Z);
            var normal = Vector3D.CrossProduct(v1, v2);
            normal.Normalize();

            // Calcola l'equazione del piano
            double A = normal.X, B = normal.Y, C = normal.Z;
            double D = -(A * p1.X + B * p1.Y + C * p1.Z);
            string risolviamoper;
            Vector3D FindPointOnPlane(double A, double B, double C, double D)
            {
                double x, y, z = 0; // Impostiamo Z = 0

                if (Math.Abs(A) > 1e-6 || Math.Abs(B) > 1e-6)
                {
                    if (Math.Abs(A) > Math.Abs(B)) // Se A è più significativo, scegliamo Y = 0 e risolviamo per X
                    {
                        y = 0;
                        x = -D / A; // Risolviamo per X
                        risolviamoper = "Risolviamo per X";
                    }
                    else 
                    {
                        x = 0;
                        y = -D / B; // Risolviamo per Y
                        risolviamoper = "Risolviamo per Y";
                    }
                }
                else
                {
                    throw new InvalidOperationException("Il piano è parallelo all'asse Z e non interseca Z = 0.");
                }

                // Restituiamo il punto trovato
                return new Vector3D(x, y, z);
            }

            // Step 2: Scegliamo un punto sulla retta come punto di riferimento per la traslazione
            var translationPoint = FindPointOnPlane(A, B, C, D);
            var translatedP1 = new Vector3D(p1.X - translationPoint.X, p1.Y - translationPoint.Y, p1.Z - translationPoint.Z);
            var translatedP2 = new Vector3D(p2.X - translationPoint.X, p2.Y - translationPoint.Y, p2.Z - translationPoint.Z);
            var translatedP3 = new Vector3D(p3.X - translationPoint.X, p3.Y - translationPoint.Y, p3.Z - translationPoint.Z);

            // Step 3: Calcola le rotazioni
            rotZ = Math.Atan2(normal.Y, normal.X); // Rotazione sull'asse Z
            rotY = Math.Acos(normal.Z);           // Rotazione sull'asse Y
            double rotz1 = rotZ;
            if (
               //Descrizione == "Subtriangolo:11" && 
               ID == "S. mansardato:2, falda:1")
            {
                //rotz1 = -rotZ;
            }
 
            // Step 4: Applica le rotazioni per riallineare
            var rotationZMatrix = new RotateTransform3D(
            //new AxisAngleRotation3D(new Vector3D(0, 0, 1), rotZ * (180 / Math.PI))
            //correzione per tetti ortogonali
            new AxisAngleRotation3D(new Vector3D(0, 0, 1), -rotZ * (180 / Math.PI))
        );
            var transformGroup = new Transform3DGroup();
            transformGroup.Children.Add(rotationZMatrix);

            var rotatedP1 = transformGroup.Transform(new Point3D(translatedP1.X, translatedP1.Y, translatedP1.Z));
            var rotatedP2 = transformGroup.Transform(new Point3D(translatedP2.X, translatedP2.Y, translatedP2.Z));
            var rotatedP3 = transformGroup.Transform(new Point3D(translatedP3.X, translatedP3.Y, translatedP3.Z));

            // Step 5: Calcola amplificazione
            double cosRotY = Math.Cos(rotY);
            double amplification = (1 / cosRotY);
            //double amplification = 1;
            //yproiezione=yinpiano*cosRotY rot
            // Step 6: Genera il poligono 2D amplificato
            amplified2D = new PointCollection
    {
        new System.Windows.Point(rotatedP1.X* amplification, rotatedP1.Y ),
        new System.Windows.Point(rotatedP2.X * amplification, rotatedP2.Y),
        new System.Windows.Point(rotatedP3.X* amplification, rotatedP3.Y )
    };
            /*
            amplified2D = new PointCollection
    {
        new System.Windows.Point(rotatedP1.X, rotatedP1.Y * amplification),
        new System.Windows.Point(rotatedP2.X, rotatedP2.Y * amplification),
        new System.Windows.Point(rotatedP3.X, rotatedP3.Y * amplification)
    };
*/
            // Converti angoli in gradi
            rotZ = rotZ * (180 / Math.PI);
            rotY = rotY * (180 / Math.PI);
            if (
                //Descrizione == "Subtriangolo:11" && 
                ID == "S. mansardato:1, falda:2")
            {
                TermodelLog.WriteLog($"----------------------------------------------------");
                TermodelLog.WriteLog($"Debug superficie mansardata {ID},{Descrizione} ");
                TermodelLog.WriteLog($"Triangolo {points[0]}||{points[1]}||{points[2]} ");
                TermodelLog.WriteLog($"Normale {normal} ");
                TermodelLog.WriteLog($" {risolviamoper} ");
                TermodelLog.WriteLog($"P (z=0) {translationPoint} ");
                TermodelLog.WriteLog($"Triangolo traslato {translatedP1}||{translatedP2}||{translatedP3} ");
                TermodelLog.WriteLog($"Amplificazione: {amplification} ");
                TermodelLog.WriteLog($"rotZ: {rotZ} ");
                TermodelLog.WriteLog($"rotY: {rotY} ");
                TermodelLog.WriteLog($"Triangolo ruotato {amplified2D[0]}||{amplified2D[1]}||{amplified2D[2]} ");
            }
            // Restituisci il poligono amplificato e la traslazione
            return (amplified2D, translationPoint);
        }



        //--------------------------------------------------------------------
        public static void LogProfilo(IfcPolyline polyifc)
        {
            if (polyifc == null || polyifc.Points == null || polyifc.Points.Count == 0)
            {
                TermodelLog.WriteLog("⚠️ LogProfilo: polilinea nulla o vuota.");
                return;
            }

            TermodelLog.WriteLog($"📋 Log profilo IfcPolyline con {polyifc.Points.Count} punti:");

            for (int i = 0; i < polyifc.Points.Count; i++)
            {
                var p = polyifc.Points[i];
                TermodelLog.WriteLog($"    Punto[{i}]: X={p.X:F3}, Y={p.Y:F3}, Z={p.Z:F3}");
            }
        }
        private static bool IsClockwise(PointCollection pts)
        {
            double sum = 0;
            for (int i = 0; i < pts.Count; i++)
            {
                var p1 = pts[i];
                var p2 = pts[(i + 1) % pts.Count];
                sum += (p2.X - p1.X) * (p2.Y + p1.Y);
            }
            return sum > 0;
        }

        public static PointCollection PurificaPoligonoOrizzontale(IfcPolyline polyifc)
        {
            var profilo = new PointCollection();

            if (polyifc == null || polyifc.Points == null || polyifc.Points.Count < 3)
            {
                TermodelLog.WriteLog("⚠️ Poligono non valido: meno di 3 punti.");
                return profilo;
            }

            // Estrae solo XY (Z costante, per poligoni orizzontali)
            foreach (var p in polyifc.Points)
            {
                profilo.Add(new System.Windows.Point(p.X, p.Y));
            }

            // Rimuove punto finale se duplicato
            if (profilo.Count > 1 && profilo[0].Equals(profilo[profilo.Count - 1]))
            {
                TermodelLog.WriteLog("🔁 Rimosso punto duplicato finale dal profilo orizzontale.");
                profilo.RemoveAt(profilo.Count - 1);
            }

            // Verifica e corregge winding (Helix richiede senso antiorario per i tappi)
            if (IsClockwise(profilo))
            {
                TermodelLog.WriteLog("↩️ Inversione winding: da orario a antiorario.");
                profilo = new PointCollection(profilo.Reverse());
            }

            return profilo;
        }
        /*
        private void Viewport_MouseDown(object sender, MouseButtonEventArgs e)
        {
            var hits = viewport.Viewport.FindHits(e.GetPosition(viewport));
            if (hits.Count > 0)
            {
                var hit = hits[0];
                if (hit.Visual is BillboardTextVisual3D label && labelsDictionary.ContainsKey(label))
                {
                    int ponteId = labelsDictionary[label];
                    // 👉 Qui richiami la logica: apri pannello, logga, ecc.
                    TermodelLog.LogOperation($"[Ponti] Cliccato ponte {ponteId}");
                }
            }
        }
        */
        private void DrawHelixTest(
           int NumeroElemento,
           IfcPolyline polyifc,
           double baseHeight,
           double extrusionHeight,
           bool verticale,
           IfcCartesianPoint IFCinsertionPoint,
           Point3D insertionPoint,
           TipoElemento Tipo,
           string ID,
           string Descrizione,
           double rotationAngle = 0,
           Coordinate3D Centroponte = null
       )
            
        {
            if (Tipo != TipoElemento.Ponte) return;
            if (polyifc?.Points == null || polyifc.Points.Count == 0) return;

            // 1. Calcolo baricentro in coordinate locali IFC
            double cx = 0, cy = 0, cz = 0;
            foreach (var pt in polyifc.Points)
            {
                var c = pt.Coordinates;
                cx += (c.Count > 0) ? (double)c[0] : 0.0;
                cy += (c.Count > 1) ? (double)c[1] : 0.0;
                cz += (c.Count > 2) ? (double)c[2] : 0.0;
            }
            int n = polyifc.Points.Count;
            double lx = cx / n;
            double ly = cy / n;
            double lz = cz / n + baseHeight;

            // 2. Offset di disassamento costante
            const double offset = 0.20; // 20 cm, regolabile

            if (verticale)
            {
                // Per pareti/ponti verticali: sposta verso l’esterno in Z
                lz += offset;
            }
            else
            {
                // Per elementi orizzontali: sposta verso l’alto
                lz += offset;
            }

            // Punto locale finale per la label
            var centroLocale = new Point3D(lx, ly, lz); 
             if (Centroponte!=null)
            {
                centroLocale.X = Centroponte.X+offset;
                centroLocale.Y = Centroponte.Y+offset;
                centroLocale.Z = Centroponte.Z+offset;

            }
            


            // 2. Creazione Billboard con numero
            var label = new BillboardTextVisual3D
            {
                Text = Descrizione,
                Position = centroLocale,       // resta in locale
                Foreground = Brushes.Black,
                FontSize = 22,              // più grande del default
                Background = Brushes.White
            };

            // 3. Costruzione del gruppo di trasformazioni (stessa logica dei solidi)
            var transformGroup = new Transform3DGroup();

            // Rotazione in pianta
            transformGroup.Children.Add(new RotateTransform3D(
                new AxisAngleRotation3D(new Vector3D(0, 0, 1), rotationAngle)
            ));

            // Traslazione globale
            transformGroup.Children.Add(new TranslateTransform3D(
                insertionPoint.X, insertionPoint.Y, insertionPoint.Z
            ));
            if (Centroponte == null)
            label.Transform = transformGroup;

                // 4. Aggiunta al viewport
  //              viewport.Children.Add(label);
            //labelsDictionary[label] = NumeroElemento;
        }


        public void DrawPolyEstruso(
           int NumeroElemento,
           IfcPolyline polyifc,
           double baseHeight,
           double extrusionHeight,
           bool verticale,
           IfcCartesianPoint IFCinsertionPoint,
           Point3D insertionPoint,      // Punto di inserimento
           TipoElemento Tipo,
           string ID,
           string Descrizione,
           Coordinate3D Start,
           Coordinate3D end,
           double rotationAngle = 0    // Rotazione sull'asse XY in gradi

       )

        {
            Coordinate3D? Centroponte = null;
            if (Tipo == TipoElemento.Ponte)
            {
                // --- CentroPonte calcolato dagli estremi (se presenti) ---
                

                // midpoint XY tra gli estremi
                double cx = (Start.X + end.X) * 0.5;
                double cy = (Start.Y + end.Y) * 0.5;
                double cz = (Start.Z + end.Z) * 0.5;

                Centroponte = new Coordinate3D(cx, cy, cz);


                // ... usa 'Centroponte' per etichetta/disegno ...
            }
            else Centroponte = new Coordinate3D(0,0, 0);

            void LogEtichette()
            {
                if (Tipo != TipoElemento.Ponte) return;

                    var line = new LinesVisual3D
                {
                    Color = Colors.Red,
                    Thickness = 15
                };

                
                line.Points.Add(new Point3D(Start.X, Start.Y, Start.Z));
                line.Points.Add(new Point3D(end.X, end.Y, end.Z));
               
                //viewport.Children.Add(line);
                // Log ************************************************
                string F3(double v) => v.ToString("0.###", CultureInfo.InvariantCulture);
                string P3Helix(Point3D p) => $"({F3(p.X)},{F3(p.Y)},{F3(p.Z)})";
                string P3C3D(Coordinate3D p) => $"({F3(p.X)},{F3(p.Y)},{F3(p.Z)})";

                // --- IFC insertion point (IfxLengthMeasure.Value) ---
                double ifcX = 0, ifcY = 0, ifcZ = 0;
                var coords = IFCinsertionPoint?.Coordinates;
                if (coords != null)
                {
                    if (coords.Count > 0 && coords[0] != null) ifcX = coords[0];
                    if (coords.Count > 1 && coords[1] != null) ifcY = coords[1];
                    if (coords.Count > 2 && coords[2] != null) ifcZ = coords[2];
                }
                var pIFC = $"({F3(ifcX)},{F3(ifcY)},{F3(ifcZ)})";

                // --- metriche da Start/End ---
                var mid = new Coordinate3D((Start.X + end.X) * 0.5, (Start.Y + end.Y) * 0.5, (Start.Z + end.Z) * 0.5);
                double dx = end.X - Start.X, dy = end.Y - Start.Y, dz = end.Z - Start.Z;
                double lenXY = Math.Sqrt(dx * dx + dy * dy);
                double len3D = Math.Sqrt(dx * dx + dy * dy + dz * dz);

                // delta rispetto a Helix insertion (utile a capire disallineamenti)
                double dSx = Start.X - insertionPoint.X, dSy = Start.Y - insertionPoint.Y, dSz = Start.Z - insertionPoint.Z;
                double dEx = end.X - insertionPoint.X, dEy = end.Y - insertionPoint.Y, dEz = end.Z - insertionPoint.Z;

                TermodelLog.WriteLog(
                    $"Ponte finale:{Descrizione}"+
                    $" Start={P3C3D(Start)} End={P3C3D(end)}", 
                    LogCategory.PontiAutomatici
                );
                //Log ************************************************
            }
            LogEtichette();
            DrawHelixTest(
               NumeroElemento,
               polyifc,
               baseHeight,
               extrusionHeight,
               verticale,
               IFCinsertionPoint,
               insertionPoint,
               Tipo,
               ID,
               Descrizione,
               rotationAngle,
               Centroponte
           );
            
            double extrusionBase = 0;
            //baseHeight = 0;
            // Imposta il centro di rotazione (CameraController)
            //viewport.CameraController.CameraTarget = centerOfRotation;
            // Aggiorna i limiti del modello in base alla polilinea
            LimitiModello(polyifc, baseHeight, insertionPoint);
            //AddHelixCube();
            //return;
            bool tapposopra = true;
            Color color = Colors.DarkKhaki;
            Brush brush = Brushes.Tomato;
            if (Tipo != TipoElemento.Ponte&& Tipo != TipoElemento.Falda)
            LineeCostruzione.AggiungiIFCpoly(polyifc, IFCinsertionPoint, 0,rotationAngle);

            double AlzaFin = 0;
            if (Tipo == TipoElemento.Pavimento || Tipo == TipoElemento.Soffitto)
            {
                 tapposopra = true;
                color = Colors.DarkKhaki;
                brush = Brushes.Tomato;
                PurificaPoligonoOrizzontale(polyifc);
                //LogProfilo(polyifc);
            }
            //if (Tipo != TipoElemento.Pavimento && Tipo != TipoElemento.Soffitto && Tipo != TipoElemento.Finestra) return;
            if (Tipo == TipoElemento.Finestra)
            {
                AlzaFin = 0.3;
                tapposopra = false;
                color = Colors.DarkOliveGreen;
                brush = Brushes.OliveDrab;
            }
            if (Tipo == TipoElemento.Parete)
            {              
                color = Colors.Sienna;
                brush = Brushes.SandyBrown;
                verticale = true;      
            }
            if (Tipo == TipoElemento.Ponte)
            {
                tapposopra = false;
                color = Colors.SpringGreen;
                brush = Brushes.SpringGreen;
                if (verticale)
                {
                    extrusionBase = - extrusionHeight / 2;
                    tapposopra = true;
                }
            }

            var profilo = new PointCollection();
            // Matrice di trasformazione per la rotazione e traslazione
            var transformGroup = new Transform3DGroup();
            TranslateTransform3D translationTransform = null;
            if (polyifc.Points.Count < 3)
            {
                Console.WriteLine("Il poligono non è valido per l'estrusione.");
                return;
            }
            if (Tipo == TipoElemento.Falda|| Tipo == TipoElemento.Mansardato)
            {
                double difZfalde = 0;
                if (Tipo == TipoElemento.Falda)
                {
                    tapposopra = true;
                    color = Colors.Brown;
                    brush = Brushes.Brown;
                    difZfalde += GestProg.Rivestimenti ? 0.02 : 0.50;

                }
                else
                {
                    tapposopra = true;
                    color = Colors.DarkKhaki;
                    brush = Brushes.Tomato;
                }
                // Usa la funzione ConvertiTriangolo per calcolare i parametri
                double rotY = 0;
                Vector3D translationPoint;
                (profilo, translationPoint) = TriangoloDaCartesianoAPolare(polyifc, ref rotationAngle, ref rotY,ID,Descrizione);

                /*
                if (rotationAngle != 0)
                {
                    color = Colors.SpringGreen;
                    brush = Brushes.SpringGreen;
                }
                */
                translationTransform = new TranslateTransform3D(
                    translationPoint.X,
                    translationPoint.Y,
                    translationPoint.Z + difZfalde 
                );
                // Aggiungi rotazione
                if (
                     //Descrizione == "Subtriangolo:11" && 
                     ID == "S. mansardato:2, falda:1")
                {
                   //rotY = -rotY;
               }
                bool IsAngleApproximatelyBetween90And270(double angle, double tolerance)
                {
                    // Normalizza l'angolo nell'intervallo [0, 360)
                    double normalized = angle % 360;
                    if (normalized < 0)
                    {
                        normalized += 360;
                    }
                return (Math.Abs(normalized-90) <=tolerance || Math.Abs(normalized - 270) <= tolerance);
                }
                //if (IsAngleApproximatelyBetween90And270(rotationAngle,10)) 
                //    rotY = -rotY;

                var rotationTransformY = new RotateTransform3D(
                new AxisAngleRotation3D(new Vector3D(0, 1, 0), rotY)); // Rotazione sull'asse Z (XY)
                var rotationTransformZ = new RotateTransform3D(
                          new AxisAngleRotation3D(new Vector3D(0, 0, 1), rotationAngle) // Rotazione sull'asse Z (XY)
                      );
                if (
                     //Descrizione == "Subtriangolo:11" && 
                     ID == "S. mansardato:1, falda:2")
                {
                    TermodelLog.WriteLog($"----------------------------------------------------");
                    TermodelLog.WriteLog($"Debug superficie mansardata redraw {ID},{Descrizione} ");
                    //TermodelLog.WriteLog($"Triangolo {points[0]}----{points[1]}----{points[2]} ");
                    TermodelLog.WriteLog($"Triangolo modificato {profilo[0]}||{profilo[1]}||{profilo[2]}");
                    TermodelLog.WriteLog($"translationTransform {translationPoint} ");
                    //TermodelLog.WriteLog($"Amplificazione: {amplification} ");
                    TermodelLog.WriteLog($"rotationTransform rotZ: {-rotationAngle} ");
                    TermodelLog.WriteLog($"rotationTransform rotY: {-rotY} ");
                    //TermodelLog.WriteLog($"Triangolo ruotato {amplified2D[0]}----{amplified2D[1]}----{amplified2D[2]} ");

 
                }
 
                transformGroup.Children.Add(rotationTransformY);

                if (rotationAngle != 0)
                   {
                   transformGroup.Children.Add(rotationTransformZ);
                   }
                transformGroup.Children.Add(translationTransform);
  
            }
            else
            {
                for (int i = 0; i < polyifc.Points.Count; i++)
                {
                    var point = polyifc.Points[i];
                    // Supponendo che point.X e point.Y siano le coordinate bidimensionali
                    if (!verticale)
                        profilo.Add(new System.Windows.Point(point.X , point.Y ));
                    else profilo.Add(new System.Windows.Point(point.X, point.Z ));
                }
                if (verticale)
                {
                    var rotationTransform = new RotateTransform3D(
                        new AxisAngleRotation3D(new Vector3D(1, 0, 0), 90) // Rotazione sull'asse Z (XY)
                    );
                    transformGroup.Children.Add(rotationTransform);
                }
                // Aggiungi rotazione
                if (rotationAngle != 0)
                {
                    var rotationTransform = new RotateTransform3D(
                        new AxisAngleRotation3D(new Vector3D(0, 0, 1), rotationAngle) // Rotazione sull'asse Z (XY)
                    );
                    transformGroup.Children.Add(rotationTransform);
                }
               
            
            }
            if (!profilo[0].Equals(profilo[profilo.Count - 1]))
            {
                profilo.Add(profilo[0]);
            }

            //CreateExtrudedObject(viewport);
            //return;
            //if (verticale) return; 
            // Verifica che il poligono abbia almeno 3 punti
            
            
            // Calcolo del vettore di estrusione
            var estrusione = verticale ? new Vector3D(0,extrusionHeight,0) : new Vector3D(0,0, extrusionHeight);

            // Creazione delle facce laterali
           
            // Chiudere il profilo se non è già chiuso

            // Aggiungi traslazione
            translationTransform = new TranslateTransform3D(insertionPoint.X, insertionPoint.Y, insertionPoint.Z);
            transformGroup.Children.Add(translationTransform);
           
            

            // 2. Creare un oggetto ExtrudedVisual3D
            var estruso = new ExtrudedVisual3D
            {
                Section = profilo,                // Profilo da estrudere
                Path = new Point3DCollection      // Percorso dell'estrusione
        {
            new Point3D(0, 0, extrusionBase),         // Punto iniziale
            new Point3D(0, 0, extrusionBase+extrusionHeight)          // Punto finale (altezza di 2 unità)
        },
                Fill = brush              // Colore di riempimento
            };
            estruso.Transform = transformGroup;
            viewport.Children.Add(estruso);

            // Renderer parallelo Web: usa esattamente profilo, path e trasformazioni
            // gia' calcolati per Helix. Con Enabled=false questa chiamata esce subito.
            DrawBimJson.AddExtruded(
                profilo,
                estruso.Path,
                transformGroup,
                color,
                Tipo,
                ID,
                Descrizione,
                NumeroElemento,
                "lati");

            // Creazione del MeshBuilder per il corpo principale
            var builder = new MeshBuilder();
            // Aggiungere il tappo inferiore
            AddCap(builder, profilo, new Point3D(0, 0, extrusionBase), !tapposopra);

            // Aggiungere il tappo superiore
            AddCap(builder, profilo, new Point3D(0, 0, extrusionBase+extrusionHeight), tapposopra);
            // Creare la mesh
            var mesh = builder.ToMesh();

            // Materiale
            var material = new DiffuseMaterial(new SolidColorBrush(color));

            // Creare il modello 3D
            var geometryModel = new GeometryModel3D(mesh, material);
            geometryModel.Transform = transformGroup;
            // Aggiungere al viewport
            viewport.Children.Add(new ModelVisual3D { Content = geometryModel });

            // I tappi sono gia' triangolati nel MeshBuilder: il JSON riceve la
            // stessa mesh finale e la stessa trasformazione usate da Helix.
            DrawBimJson.AddMesh(
                mesh,
                transformGroup,
                color,
                Tipo,
                ID,
                Descrizione,
                NumeroElemento,
                "tappi");
        }

        public void DrawDebugCube(Point3D center, double size, Color color)
        {
            // Creazione del materiale del cubo
            var material = new DiffuseMaterial(new SolidColorBrush(color));

            // Creazione delle posizioni dei vertici del cubo
            double halfSize = size / 2;
            var positions = new Point3DCollection
    {
        // Faccia anteriore
        new Point3D(center.X - halfSize, center.Y - halfSize, center.Z + halfSize),
        new Point3D(center.X + halfSize, center.Y - halfSize, center.Z + halfSize),
        new Point3D(center.X + halfSize, center.Y + halfSize, center.Z + halfSize),
        new Point3D(center.X - halfSize, center.Y + halfSize, center.Z + halfSize),
        
        // Faccia posteriore
        new Point3D(center.X - halfSize, center.Y - halfSize, center.Z - halfSize),
        new Point3D(center.X + halfSize, center.Y - halfSize, center.Z - halfSize),
        new Point3D(center.X + halfSize, center.Y + halfSize, center.Z - halfSize),
        new Point3D(center.X - halfSize, center.Y + halfSize, center.Z - halfSize)
    };

            // Indici per creare i triangoli (triangolazione delle facce)
            var triangleIndices = new Int32Collection
    {
        // Faccia anteriore
        0, 1, 2, 2, 3, 0,
        // Faccia posteriore
        4, 5, 6, 6, 7, 4,
        // Faccia superiore
        3, 2, 6, 6, 7, 3,
        // Faccia inferiore
        0, 1, 5, 5, 4, 0,
        // Faccia sinistra
        0, 3, 7, 7, 4, 0,
        // Faccia destra
        1, 2, 6, 6, 5, 1
    };

            // Normali per ogni vertice
            var normals = new Vector3DCollection
    {
        // Faccia anteriore
        new Vector3D(0, 0, 1), new Vector3D(0, 0, 1),
        new Vector3D(0, 0, 1), new Vector3D(0, 0, 1),
        // Faccia posteriore
        new Vector3D(0, 0, -1), new Vector3D(0, 0, -1),
        new Vector3D(0, 0, -1), new Vector3D(0, 0, -1),
        // Faccia superiore
        new Vector3D(0, 1, 0), new Vector3D(0, 1, 0),
        new Vector3D(0, 1, 0), new Vector3D(0, 1, 0),
        // Faccia inferiore
        new Vector3D(0, -1, 0), new Vector3D(0, -1, 0),
        new Vector3D(0, -1, 0), new Vector3D(0, -1, 0),
        // Faccia sinistra
        new Vector3D(-1, 0, 0), new Vector3D(-1, 0, 0),
        new Vector3D(-1, 0, 0), new Vector3D(-1, 0, 0),
        // Faccia destra
        new Vector3D(1, 0, 0), new Vector3D(1, 0, 0),
        new Vector3D(1, 0, 0), new Vector3D(1, 0, 0)
    };

            // Creazione della mesh del cubo
            var mesh = new MeshGeometry3D
            {
                Positions = positions,
                TriangleIndices = triangleIndices,
                Normals = normals
            };

            // Creazione del modello 3D
            var geometryModel = new GeometryModel3D(mesh, materialGroup);

            // Aggiunta al viewport
            var modelVisual = new ModelVisual3D { Content = geometryModel };
            viewport.Children.Add(modelVisual);
        }

        private void UpdateLookDirection()
        {
            camera.LookDirection = new Vector3D(
                centerOfRotation.X - camera.Position.X,
                centerOfRotation.Y - camera.Position.Y,
                centerOfRotation.Z - camera.Position.Z
            );
        }
        public void AddHelixCube()
        {
            // Creazione del modello
            var builder = new MeshBuilder();
            builder.AddBox(new Point3D(0, 0, 0), 1, 1, 1); // Aggiungi un cubo

            var mesh = builder.ToMesh();
            //var material = PhongMaterials.Red; // Usa un materiale predefinito (supporta riflessi)

            var geometryModel = new GeometryModel3D(mesh, materialGroup);
            var modelVisual = new ModelVisual3D { Content = geometryModel };

            // Aggiungi al viewport
            viewport.Children.Add(modelVisual);
        }
 
    }

    public class LineManager
    {
        private readonly List<(XbimPoint3D Start, XbimPoint3D End)> linee3D = new();
        private readonly DrawBim parent;

        public LineManager(DrawBim parentInstance)
        {
            parent = parentInstance;
        }

        public void AggiungiLinea(XbimPoint3D start, XbimPoint3D end)
        {
            //linee3D.Add((start, end));
        }

        public void SvuotaListaLinee() => linee3D.Clear();

        public void VisualizzaLinee3D()
        {
            //viewport.Children.Clear();
            if (parent == null || parent.viewport == null)
                return;

            var viewport = parent.viewport;

            var line = new LinesVisual3D
            {
                Color = Colors.Red,
                Thickness = 2
            };

            foreach (var (start, end) in linee3D)
            {
                line.Points.Add(new Point3D(start.X, start.Y, start.Z));
                line.Points.Add(new Point3D(end.X, end.Y, end.Z));
            }

            viewport.Children.Add(line);

           // var light = new DirectionalLight(Colors.White, new Vector3D(-1, -1, -1));
           // var lightModel = new ModelVisual3D { Content = light };
           // viewport.Children.Add(lightModel);
        }
        public void AggiungiPolilineaNettopology(NetTopologySuite.Geometries.Geometry poly, IIfcCartesianPoint puntoInserimento, double zcor)
        {
            if (!parent.enabled) return;
            // Ottieni le coordinate del punto di inserimento
            double inserimentoX = puntoInserimento.Coordinates[0];
            double inserimentoY = puntoInserimento.Coordinates[1];
            double inserimentoZ = puntoInserimento.Coordinates.Count > 2 ? puntoInserimento.Coordinates[2] : 0; // Gestisci il caso 2D

            // Ottieni le coordinate della geometria
            var coordinates = poly.Coordinates;  // Usa direttamente le coordinate dalla geometria

            // Itera sui segmenti della geometria
            for (int i = 0; i < coordinates.Length - 1; i++)
            {
                // Ottieni i punti del segmento
                var startPoint = coordinates[i];
                var endPoint = coordinates[i + 1];

                // Gestisci il caso in cui Z sia NaN, trattandola come 0
                double startZ = double.IsNaN(startPoint.Z) ? 0 : startPoint.Z;
                double endZ = double.IsNaN(endPoint.Z) ? 0 : endPoint.Z;

                // Sposta i punti in base al punto di inserimento
                var startShifted = new XbimPoint3D(
                    startPoint.X + inserimentoX,
                    startPoint.Y + inserimentoY,
                    startZ + inserimentoZ + zcor
                );

                var endShifted = new XbimPoint3D(
                    endPoint.X + inserimentoX,
                    endPoint.Y + inserimentoY,
                    endZ + inserimentoZ + zcor
                );

                // Aggiungi il segmento spostato alla lista delle linee
                AggiungiLinea(startShifted, endShifted);
            }
        }
        public void AggiungiIFCpolyold(IIfcPolyline polyline, IIfcCartesianPoint puntoInserimento, double zcor)
        {
            if (!parent.enabled) return;
            // Controlla che la polilinea abbia almeno due punti
            if (polyline.Points.Count < 2)
            {
                return; // Non è possibile creare una linea con meno di due punti
            }

            // Ottieni le coordinate del punto di inserimento
            double inserimentoX = puntoInserimento.Coordinates[0];
            double inserimentoY = puntoInserimento.Coordinates[1];
            double inserimentoZ = puntoInserimento.Coordinates.Count > 2 ? puntoInserimento.Coordinates[2] : 0; // Gestisci il caso 2D

            // Itera attraverso i punti della polilinea e aggiungi i segmenti alla lista
            for (int i = 0; i < polyline.Points.Count - 1; i++)
            {
                var startPoint = polyline.Points[i] as IIfcCartesianPoint;
                var endPoint = polyline.Points[i + 1] as IIfcCartesianPoint;

                if (startPoint != null && endPoint != null)
                {
                    // Ottieni le coordinate X, Y, Z dei punti iniziale e finale, spostandole in base al punto di inserimento
                    var start = new XbimPoint3D(
                        startPoint.Coordinates[0] + inserimentoX,
                        startPoint.Coordinates[1] + inserimentoY,
                        startPoint.Coordinates.Count > 2 ? startPoint.Coordinates[2] + inserimentoZ + zcor : inserimentoZ + zcor);

                    var end = new XbimPoint3D(
                        endPoint.Coordinates[0] + inserimentoX,
                        endPoint.Coordinates[1] + inserimentoY,
                        endPoint.Coordinates.Count > 2 ? endPoint.Coordinates[2] + inserimentoZ + zcor : inserimentoZ + zcor);

                    // Aggiungi il segmento alla lista delle linee
                    AggiungiLinea(start, end);
                }
            }
        }
        public void AggiungiPoligonoNTS2D(double quotaZ, NetTopologySuite.Geometries.Geometry poligono2D)
        {
            if (!parent.enabled|| poligono2D==null) return;

            var coordinate2D = poligono2D.Coordinates;

            for (int i = 0; i < coordinate2D.Length - 1; i++)
            {
                var p1 = coordinate2D[i];
                var p2 = coordinate2D[i + 1];

                var start = new XbimPoint3D(p1.X, p1.Y, quotaZ);
                var end = new XbimPoint3D(p2.X, p2.Y, quotaZ);

                AggiungiLinea(start, end);
            }
        }

        public void AggiungiIFCpoly(IIfcPolyline polyline, IIfcCartesianPoint puntoInserimento, double zcor, double rotationAngle)
 {
            if (!parent.enabled) return;

            if (polyline.Points.Count < 2)
                return;

            double inserimentoX = puntoInserimento.Coordinates[0];
            double inserimentoY = puntoInserimento.Coordinates[1];
            double inserimentoZ = puntoInserimento.Coordinates.Count > 2 ? puntoInserimento.Coordinates[2] : 0;

            // Calcolo coseno e seno dell’angolo per rotazione 2D attorno a Z
            double angoloRad = rotationAngle * Math.PI / 180.0;
            double cos = Math.Cos(angoloRad);
            double sin = Math.Sin(angoloRad);

            for (int i = 0; i < polyline.Points.Count - 1; i++)
            {
                var startPoint = polyline.Points[i] as IIfcCartesianPoint;
                var endPoint = polyline.Points[i + 1] as IIfcCartesianPoint;

                if (startPoint != null && endPoint != null)
                {
                    var start = RuotaETrasla(startPoint, inserimentoX, inserimentoY, inserimentoZ, zcor, cos, sin);
                    var end = RuotaETrasla(endPoint, inserimentoX, inserimentoY, inserimentoZ, zcor, cos, sin);

                    AggiungiLinea(start, end);
                }
            }
        }
        private XbimPoint3D RuotaETrasla(IIfcCartesianPoint punto, double offsetX, double offsetY, double offsetZ, double zcor, double cos, double sin)
        {
            double x = punto.Coordinates[0];
            double y = punto.Coordinates[1];
            double z = punto.Coordinates.Count > 2 ? punto.Coordinates[2] : 0;

            // Applica rotazione attorno all'origine (poi traslazione)
            double xRot = x * cos - y * sin;
            double yRot = x * sin + y * cos;

            return new XbimPoint3D(
                xRot + offsetX,
                yRot + offsetY,
                z + offsetZ + zcor
            );
        }
        public void VisualizzaLineeBIM()
        {
            //VisualizzaLinee3D(parent.viewport);
        }
    }
        public static class ErroreManager
        {
            // Classe interna per rappresentare un errore
            private class ErroreDXF
            {
                public List<UtiBimNTS.Linea3D> Linee { get; set; }
                public string Descrizione { get; set; }
                public string Piano { get; set; }
                public Color Colore { get; set; }
            }

            // Lista per memorizzare tutti gli errori
            private static readonly List<ErroreDXF> errori = new();

            // Metodo per aggiungere un errore con linee multiple
            public static void AggiungiErroreDXF(List<UtiBimNTS.Linea3D> linee, string descrizione, string piano, bool regolare)
            {
                // Determina il colore in base alla regolarità delle linee
                Color coloreLinea = regolare ? Colors.Green : Colors.Red;

                // Crea un nuovo errore e aggiungilo alla lista
                errori.Add(new ErroreDXF
                {
                    Linee = linee,
                    Descrizione = descrizione,
                    Piano = piano,
                    Colore = coloreLinea
                });
            }

            // Metodo per visualizzare gli errori nel Viewport3D
            public static void VisualizzaErrori()
            {
            HelixViewport3D viewport = DrBim.WP;
                viewport.Children.Clear(); // Pulisci il contenuto del viewport

                foreach (var errore in errori)
                {
                    foreach (var linea in errore.Linee)
                    {
                        var lineVisual = new LinesVisual3D
                        {
                            Color = errore.Colore,
                            Thickness = 2
                        };

                    // Aggiungi i punti della linea
                    DrBim.Class.LimitiModelloPunto(linea.Start);
                    DrBim.Class.LimitiModelloPunto(linea.End);

                    lineVisual.Points.Add(new System.Windows.Media.Media3D.Point3D(
                            linea.Start.X,
                            linea.Start.Y,
                            linea.Start.Z));

                        lineVisual.Points.Add(new System.Windows.Media.Media3D.Point3D(
                            linea.End.X,
                            linea.End.Y,
                            linea.End.Z));

                        // Aggiungi la linea al viewport
                        viewport.Children.Add(lineVisual);
                    }
                }
                /*
                // Aggiungi una luce per migliorare la visualizzazione
                var light = new DirectionalLight(Colors.White, new System.Windows.Media.Media3D.Vector3D(-1, -1, -1));
                var lightModel = new ModelVisual3D { Content = light };
                viewport.Children.Add(lightModel);
                */
            }

            // Metodo per ottenere una lista di errori associati a un piano
            public static List<string> GetErroriByPiano(string piano)
            {
                return errori.FindAll(e => e.Piano == piano).ConvertAll(e => e.Descrizione);
            }

            // Metodo per svuotare gli errori
            public static void SvuotaErrori()
            {
                errori.Clear();
            }
            public static void AddErroreDXF(string Piano, double quotapiano, string errore, List<NetTopologySuite.Geometries.LineString> listacorrette, List<NetTopologySuite.Geometries.LineString> listaerrate,bool Dis3D=true )
            {
                if (!GeneraModello.Errore($"Errore nel piano : {Piano} , {errore}")) return;

               
              
                var listaCorretteIfc = new List<UtiBimNTS.Linea3D>();
                var listaErrateIfc = new List<UtiBimNTS.Linea3D>();
                

                foreach (var linea in listacorrette)
                {
                if (linea.UserData != ""&& Dis3D)
                {
                    if (linea.UserData is string userData)
                    {
                        var userDataParts = userData.Split('|');
                        if (userDataParts.Length >= 4 &&
                            double.TryParse(userDataParts[2], out var startZ) &&
                            double.TryParse(userDataParts[3], out var endZ))
                        {
                            var start = new Point3D(linea.StartPoint.X, linea.StartPoint.Y, startZ + quotapiano);
                            var end = new Point3D(linea.EndPoint.X, linea.EndPoint.Y, endZ + quotapiano);
                            listaCorretteIfc.Add(new UtiBimNTS.Linea3D(start, end));
                        }
                    }
                }
                else
                {
                    if (!Dis3D) quotapiano = 0;
                    var start = new Point3D(linea.StartPoint.X, linea.StartPoint.Y, -1 + quotapiano);
                    var end = new Point3D(linea.EndPoint.X, linea.EndPoint.Y, -1 + quotapiano);
                    listaCorretteIfc.Add(new UtiBimNTS.Linea3D(start, end));
                }

                }

                foreach (var linea in listaerrate)
                {
                if (linea.UserData != "" && Dis3D)
                {
                    if (linea.UserData is string userData)
                    {
                        var userDataParts = userData.Split('|');
                        if (userDataParts.Length >= 4 &&
                            double.TryParse(userDataParts[2], out var startZ) &&
                            double.TryParse(userDataParts[3], out var endZ))
                        {
                            var start = new Point3D(linea.StartPoint.X, linea.StartPoint.Y, startZ + quotapiano);
                            var end = new Point3D(linea.EndPoint.X, linea.EndPoint.Y, endZ + quotapiano);
                            listaErrateIfc.Add(new UtiBimNTS.Linea3D(start, end));
                        }
                    }
                }
                else 
                {
                    if (!Dis3D) quotapiano = 1;
                    var start = new Point3D(linea.StartPoint.X, linea.StartPoint.Y, -1 + quotapiano);
                    var end = new Point3D(linea.EndPoint.X, linea.EndPoint.Y,-1 + quotapiano);
                    listaErrateIfc.Add(new UtiBimNTS.Linea3D(start, end));
                }
                }
                // Rimuovi linee errate dalla lista delle corrette  
                listaCorretteIfc.RemoveAll(lineaCorrettaIfc => listaErrateIfc.Any(lineaErrataIfc => lineaCorrettaIfc.Equals(lineaErrataIfc)));

                AggiungiErroreDXF(listaCorretteIfc, errore, Piano, true);
                AggiungiErroreDXF(listaErrateIfc, errore, Piano, false);
            }
        
    }
}
