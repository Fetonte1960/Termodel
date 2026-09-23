program PsicroDia;

uses
  Forms,
  Diagramma in 'Diagramma.pas' {FDiagramma},
  Psicrometrico in 'Psicrometrico.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFDiagramma, FDiagramma);
  Application.Run;
end.
