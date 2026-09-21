using System.Text;
using Termodel.Core.ProjectFiles;

namespace Termodel.Core.Compatibility;

/// <summary>
/// Materializza temporaneamente il file unico in una struttura simile al progetto Desktop.
/// È un adattatore interno: il TERMODEL-PROJECT-TEXT-V1 resta la sorgente autorevole.
/// </summary>
public sealed class ProjectWorkspace : IDisposable
{
    private bool _disposed;

    private ProjectWorkspace(string rootPath)
    {
        RootPath = rootPath;
        ProjectPath = Path.Combine(rootPath, "project");
        DatabasePath = Path.Combine(rootPath, "dbtempfiles");
        XmlPath = Path.Combine(rootPath, "xml");
    }

    public string RootPath { get; }
    public string ProjectPath { get; }
    public string DatabasePath { get; }
    public string XmlPath { get; }
    public string XmlInputPath => Path.Combine(XmlPath, "input.xml");
    public string XmlOutputPath => Path.Combine(XmlPath, "output.xml");

    public static ProjectWorkspace Create(ProjectTextDocument project)
    {
        ArgumentNullException.ThrowIfNull(project);

        string root = Path.Combine(
            Path.GetTempPath(),
            "TermodelService",
            Guid.NewGuid().ToString("N"));

        var workspace = new ProjectWorkspace(root);
        Directory.CreateDirectory(workspace.RootPath);
        Directory.CreateDirectory(workspace.ProjectPath);
        Directory.CreateDirectory(workspace.DatabasePath);
        Directory.CreateDirectory(workspace.XmlPath);

        foreach ((string name, string content) in project.Sections)
        {
            workspace.WriteSection(name, content);

            const string archivePrefix = "archives/xml/";
            if (name.StartsWith(archivePrefix, StringComparison.Ordinal) &&
                name.EndsWith(".xml", StringComparison.Ordinal))
            {
                string archiveName = name[archivePrefix.Length..];
                workspace.WriteText(Path.Combine(workspace.DatabasePath, archiveName), content);
            }

            if (name.Equals("thermal/input.xml", StringComparison.Ordinal))
                workspace.WriteText(workspace.XmlInputPath, content);
            else if (name.Equals("thermal/input.json", StringComparison.Ordinal))
                workspace.WriteText(Path.Combine(workspace.XmlPath, "input.json"), content);
        }

        return workspace;
    }

    public string GetCadFilePath(string logicalName)
    {
        ThrowIfDisposed();
        if (string.IsNullOrWhiteSpace(logicalName))
            throw new InvalidDataException("NomeFile CAD mancante.");

        string fileName = Path.GetFileName(logicalName.Trim());
        if (Path.GetExtension(fileName).Length == 0)
            fileName += ".dxf";

        string path = Path.Combine(ProjectPath, fileName);
        if (!File.Exists(path))
            File.WriteAllText(path, string.Empty, new UTF8Encoding(false));

        return path;
    }

    private void WriteSection(string sectionName, string content)
    {
        string relative = sectionName.Replace('/', Path.DirectorySeparatorChar);
        string path = Path.GetFullPath(Path.Combine(RootPath, relative));
        string rootWithSeparator = Path.GetFullPath(RootPath)
            .TrimEnd(Path.DirectorySeparatorChar, Path.AltDirectorySeparatorChar) +
            Path.DirectorySeparatorChar;

        if (!path.StartsWith(rootWithSeparator, StringComparison.OrdinalIgnoreCase))
            throw new InvalidDataException($"Sezione con percorso non valido: '{sectionName}'.");

        WriteText(path, content);
    }

    private static void WriteText(string path, string content)
    {
        string? directory = Path.GetDirectoryName(path);
        if (!string.IsNullOrWhiteSpace(directory))
            Directory.CreateDirectory(directory);
        File.WriteAllText(path, content, new UTF8Encoding(false));
    }

    private void ThrowIfDisposed()
    {
        ObjectDisposedException.ThrowIf(_disposed, this);
    }

    public void Dispose()
    {
        if (_disposed) return;
        _disposed = true;
        try
        {
            if (Directory.Exists(RootPath))
                Directory.Delete(RootPath, recursive: true);
        }
        catch
        {
            // Il cleanup del workspace non deve trasformare un calcolo riuscito in errore.
        }
    }
}
