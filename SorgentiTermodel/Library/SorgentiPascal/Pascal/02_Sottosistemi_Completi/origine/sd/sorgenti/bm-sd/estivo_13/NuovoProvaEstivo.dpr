program NuovoProvaEstivo;

uses
  Forms,
  MainForm in 'P:\PRJS\CPI WIN CLIMA\VERSIONE_10\CARICHI\calcoli\estivo' {FMainEstivo},
  Libreriagenerale;

{$R *.res}

begin
  Application.Initialize;
  PercorsoDrive:='c:\sd\progettoptova';
  Application.CreateForm(TFMainEstivo, FMainEstivo);
  Application.Run;
end.
