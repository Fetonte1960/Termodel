using System.Collections.Concurrent;

namespace Termodel.WebService.Calculations;

/// <summary>
/// Storage temporaneo degli snapshot di calcolo.
/// La prima implementazione è volutamente in memoria: il contratto HTTP usa
/// calculationId e non dipende dal supporto fisico scelto per la persistenza.
/// </summary>
public sealed class CalculationSnapshotStore
{
    private readonly ConcurrentDictionary<Guid, CalculationSnapshot> _snapshots = new();

    public CalculationSnapshot Create(
        ReadOnlyMemory<byte> model3DJson,
        IReadOnlyList<string> diagnostics)
    {
        var snapshot = new CalculationSnapshot(
            Guid.NewGuid(),
            DateTimeOffset.UtcNow,
            model3DJson.ToArray(),
            diagnostics.ToArray());

        if (!_snapshots.TryAdd(snapshot.Id, snapshot))
            throw new InvalidOperationException("Impossibile registrare lo snapshot di calcolo.");

        return snapshot;
    }

    public bool TryGet(Guid calculationId, out CalculationSnapshot? snapshot) =>
        _snapshots.TryGetValue(calculationId, out snapshot);
}

public sealed class CalculationSnapshot
{
    private readonly byte[] _model3DJson;
    private readonly string[] _diagnostics;

    internal CalculationSnapshot(
        Guid id,
        DateTimeOffset createdAtUtc,
        byte[] model3DJson,
        string[] diagnostics)
    {
        Id = id;
        CreatedAtUtc = createdAtUtc;
        _model3DJson = model3DJson;
        _diagnostics = diagnostics;
    }

    public Guid Id { get; }

    public DateTimeOffset CreatedAtUtc { get; }

    public IReadOnlyList<string> Diagnostics => Array.AsReadOnly(_diagnostics);

    public byte[] CopyModel3DJson() => (byte[])_model3DJson.Clone();
}
