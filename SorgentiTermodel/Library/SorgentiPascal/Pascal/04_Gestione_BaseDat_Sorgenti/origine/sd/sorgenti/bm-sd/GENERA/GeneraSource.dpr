program GeneraSource;

uses
  Forms,
  UMainGenera in 'UMainGenera.pas' {Form1},
  UFunzGenera in 'UFunzGenera.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
