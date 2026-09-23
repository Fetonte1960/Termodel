program GeneraSource;

uses
  Forms,
  UMainGenera in 'UMainGenera.pas' {Form1},
  UFunzGenera in 'UFunzGenera.pas',
  assembla in 'assembla.pas';

//Datamodule in 'C:\assistenza\kbmtable\progettotest\database\GENERATI\Datamodule.pas' {DataModule1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
