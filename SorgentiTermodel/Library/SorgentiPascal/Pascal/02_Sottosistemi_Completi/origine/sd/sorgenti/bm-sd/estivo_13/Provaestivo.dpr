program Provaestivo;

uses
  Forms,
  UTabellare in 'UTabellare.pas' {Form1},
  LibreriaGenerale in '..\..\..\comuni\LibreriaGenerale.pas',
  VariabiliGenerali in '..\..\..\comuni\VariabiliGenerali.pas',
  calcoli in 'CALCOLI.PAS',
  F1 in 'F1.PAS',
  VarCarichi in 'VarCarichi.pas',
  CALCFUN in 'CALCFUN.PAS',
  F2 in 'F2.PAS',
  F3 in 'F3.PAS',
  UDB in '..\..\database\UDB.pas',
  FunztrasfMuri in 'FunztrasfMuri.pas',
  UDataLink in 'UDataLink.pas',
  ULeggiscriviDati in 'ULeggiscriviDati.pas',
  Risultati in 'Risultati.pas',
  Master in '..\..\..\comuni\report\Master.pas' {FormMaster},
  UMaskgen in '..\..\..\comuni\UMaskgen.pas' {FMaskgen};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TFormMaster, FormMaster);
  {Application.CreateForm(TFMaskgen, FMaskgen);}
  Application.Run;
end.
