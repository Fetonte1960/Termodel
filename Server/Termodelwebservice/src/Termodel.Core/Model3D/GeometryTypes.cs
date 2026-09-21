namespace Termodel.Core.Model3D;

public readonly record struct ModelPoint3D(double X, double Y, double Z);

// Funzione realizzata da Codex in autonomia
public readonly record struct ModelVector3D(double X, double Y, double Z);
public readonly record struct ModelDirection3D(double X, double Y, double Z);

public sealed class ModelPolyline3D
{
    public IList<ModelPoint3D> Points { get; } = new List<ModelPoint3D>();
}

public sealed class ModelMesh
{
    public IList<ModelPoint3D> Vertices { get; } = new List<ModelPoint3D>();
    public IList<int> Indices { get; } = new List<int>();
}
