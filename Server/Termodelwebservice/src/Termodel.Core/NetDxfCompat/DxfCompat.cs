using System.Collections;

// Funzione realizzata da Codex in autonomia
// Compatibilità minima con i soli membri netDxf usati dalle copie di LeggiDxf.
// Non è un lettore o scrittore DXF generale.
namespace netDxf
{
    public readonly record struct Vector2(double X, double Y);

    public readonly record struct Vector3(double X, double Y, double Z)
    {
        public Vector3(double x, double y) : this(x, y, 0) { }

        // Modificato da Codex per realizzare: membro minimo usato dalla copia di LeggiDxf.
        // Modificato da Codex per realizzare: preservare la quota Z con il tipo NTS dedicato.
        public NetTopologySuite.Geometries.Coordinate Coordinate => new NetTopologySuite.Geometries.CoordinateZ(X, Y, Z);
    }

    public sealed class DxfDocument
    {
        public IList<Entities.Line> Lines { get; } = new List<Entities.Line>();
        public IList<Entities.Insert> Inserts { get; } = new List<Entities.Insert>();
        public Blocks.BlockCollection Blocks { get; } = new();
        public Tables.LayerCollection Layers { get; } = new();

        public static DxfDocument Load(string fileName) =>
            throw new NotSupportedException(
                $"La compatibilità Web non legge file DXF ('{fileName}'). Usare SvgDxfReader sullo SVG del file unico.");

        public void AddEntity(object entity)
        {
            switch (entity)
            {
                case Entities.Line line:
                    Lines.Add(line);
                    break;
                case Entities.Insert insert:
                    Inserts.Add(insert);
                    break;
                default:
                    throw new NotSupportedException($"Entità CAD non supportata: {entity.GetType().Name}.");
            }
        }

        public void Save(string fileName) =>
            throw new NotSupportedException(
                $"La compatibilità Web non produce file DXF ('{fileName}').");
    }
}

namespace netDxf.Tables
{
    public sealed class AciColor : IEquatable<AciColor>
    {
        public AciColor(int index) => Index = index;
        public int Index { get; }
        public static AciColor Red { get; } = new(1);
        public bool Equals(AciColor? other) => other is not null && Index == other.Index;
        public override bool Equals(object? obj) => obj is AciColor other && Equals(other);
        public override int GetHashCode() => Index;
        public override string ToString() => Index.ToString(System.Globalization.CultureInfo.InvariantCulture);
    }

    public sealed class Linetype
    {
        public Linetype(string name) => Name = name;
        public string Name { get; }
        public static Linetype Continuous { get; } = new("Continuous");
        public override string ToString() => Name;
    }

    public sealed class Layer
    {
        public Layer(string name) => Name = name;
        public string Name { get; }
        public Linetype Linetype { get; set; } = Linetype.Continuous;
    }

    public sealed class LayerCollection : IEnumerable<Layer>
    {
        private readonly Dictionary<string, Layer> _items = new(StringComparer.OrdinalIgnoreCase);
        public void Add(Layer layer) => _items[layer.Name] = layer;
        public bool Contains(string name) => _items.ContainsKey(name);
        public Layer this[string name] => _items[name];
        public IEnumerator<Layer> GetEnumerator() => _items.Values.GetEnumerator();
        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
    }
}

namespace netDxf.Blocks
{
    public sealed class Block
    {
        public Block(string name) => Name = name;
        public string Name { get; }
        public IList<string> AttributeTags { get; } = new List<string>();
    }

    public sealed class BlockCollection : IEnumerable<Block>
    {
        private readonly Dictionary<string, Block> _items = new(StringComparer.OrdinalIgnoreCase);
        public void Add(Block block) => _items[block.Name] = block;
        public bool Contains(string name) => _items.ContainsKey(name);
        public Block this[string name] => _items[name];
        public IEnumerator<Block> GetEnumerator() => _items.Values.GetEnumerator();
        IEnumerator IEnumerable.GetEnumerator() => GetEnumerator();
    }
}

namespace netDxf.Entities
{
    public abstract class EntityObject
    {
        public Tables.Layer Layer { get; set; } = new("0");
        public Tables.Linetype Linetype { get; set; } = Tables.Linetype.Continuous;
        public Tables.AciColor Color { get; set; } = Tables.AciColor.Red;
    }

    public sealed class Line : EntityObject
    {
        public Line(netDxf.Vector2 startPoint, netDxf.Vector2 endPoint)
            : this(new netDxf.Vector3(startPoint.X, startPoint.Y, 0),
                   new netDxf.Vector3(endPoint.X, endPoint.Y, 0)) { }

        public Line(netDxf.Vector3 startPoint, netDxf.Vector3 endPoint)
        {
            StartPoint = startPoint;
            EndPoint = endPoint;
        }

        public netDxf.Vector3 StartPoint { get; set; }
        public netDxf.Vector3 EndPoint { get; set; }
        public object? UserData { get; set; }
    }

    public sealed class Attribute
    {
        public Attribute(string tag, object? value = null)
        {
            Tag = tag;
            Value = value;
        }

        public string Tag { get; }
        public object? Value { get; set; }
    }

    public sealed class Insert : EntityObject
    {
        public Insert(Blocks.Block block, netDxf.Vector3 position)
        {
            Block = block;
            Position = position;
            foreach (string tag in block.AttributeTags)
                Attributes.Add(new Attribute(tag));
        }

        public Blocks.Block Block { get; }
        public netDxf.Vector3 Position { get; set; }
        public double Rotation { get; set; }
        public IList<Attribute> Attributes { get; } = new List<Attribute>();
    }

    public static class HatchBoundaryPath
    {
    }
}

namespace netDxf.Collections
{
    // Namespace compatibile intenzionalmente vuoto: le collezioni necessarie
    // sono esposte direttamente da DxfDocument.
}

namespace netDxf.Header
{
    // Namespace compatibile intenzionalmente vuoto.
}
