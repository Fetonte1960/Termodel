program PSofrad;

uses
  Forms,
  SofRad in 'SofRad.pas' {Form1},
  Grafica in 'Grafica.pas',
  Unit1 in 'Unit1.pas',
  UDati in 'UDati.pas',
  UtilsGen in 'UtilsGen.pas',
  UDB in 'UDB.pas' {DM1: TDataModule},
  UCacoli in 'Calcoli\UCacoli.pas',
  UDatigen in 'Calcoli\UDatigen.pas' {Datigen},
  UStampe in 'UStampe.pas' {Stampa1: TQuickRep},
  UPrepStampe in 'UPrepStampe.pas' {PrepStampa},
  Ustampa2 in 'Ustampa2.pas' {stampa2: TQuickRep},
  UCalcoli in 'UCalcoli.pas',
  UFormgen in 'UFormgen.pas' {FGenerale},
  UListbox1 in 'UListbox1.pas' {FListbox},
  UListbox in 'UListbox.pas' {Frame3: TFrame},
  UMaskgen in 'UMaskgen.pas' {FMaskgen},
  URunComp in 'compnuccio\URunComp.pas' {FRunComp},
  Ucompsel in 'compnuccio\Ucompsel.pas' {FProgcomp},
  disegnoinscala in 'disegnoinscala.pas',
  FunzionifinestraGrafica in 'FunzionifinestraGrafica.pas',
  UInterattiva in 'UInterattiva.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDM1, DM1);
  Application.CreateForm(TDatigen, Datigen);
  Application.CreateForm(TStampa1, Stampa1);
  Application.CreateForm(TPrepStampa, PrepStampa);
  Application.CreateForm(Tstampa2, stampa2);
  Application.CreateForm(TFGenerale, FGenerale);
  Application.CreateForm(TFListbox, FListbox);
  Application.CreateForm(TFMaskgen, FMaskgen);
  Application.CreateForm(TFRunComp, FRunComp);
  Application.CreateForm(TFProgcomp, FProgcomp);
  Application.Run;
end.
