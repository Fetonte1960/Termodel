using NetTopologySuite.Geometries;

public static class NetTopologyPrime
{
    public static Geometry IntersezioneSicura(Geometry first, Geometry second)
    {
        ArgumentNullException.ThrowIfNull(first);
        ArgumentNullException.ThrowIfNull(second);
        try
        {
            return first.Intersection(second);
        }
        catch (TopologyException)
        {
            return first.Buffer(0).Intersection(second.Buffer(0));
        }
    }

    public static Geometry DifferenzaSicura(Geometry first, Geometry second, string? contesto = null)
    {
        ArgumentNullException.ThrowIfNull(first);
        ArgumentNullException.ThrowIfNull(second);
        try
        {
            return first.Difference(second);
        }
        catch (TopologyException)
        {
            return first.Buffer(0).Difference(second.Buffer(0));
        }
    }
}
