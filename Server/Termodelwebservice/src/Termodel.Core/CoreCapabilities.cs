namespace Termodel.Core;

public sealed record CoreCapabilities(
    string Name,
    string Version,
    bool UpdateModelAvailable,
    bool NewProjectAvailable,
    IReadOnlyList<string> PlannedOutputs,
    IReadOnlyList<string> AvailableProjectFormats);

public static class CoreInformation
{
    // Funzione realizzata da Codex in autonomia
    public static CoreCapabilities GetCapabilities()
    {
        return new CoreCapabilities(
            Name: "Termodel Core",
            Version: "0.3.0-experimental",
            // Modificato da Codex per realizzare: dichiarare disponibile la generazione Modello3D headless.
            UpdateModelAvailable: true,
            NewProjectAvailable: true,
            PlannedOutputs: ["JSON"],
            AvailableProjectFormats: ["TERMODEL-PROJECT-TEXT-V1"]);
    }
}
