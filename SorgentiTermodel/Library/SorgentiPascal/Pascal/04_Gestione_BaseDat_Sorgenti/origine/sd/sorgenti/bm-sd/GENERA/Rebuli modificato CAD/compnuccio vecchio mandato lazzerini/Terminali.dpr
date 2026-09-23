program Terminali;

uses
  Forms,
  USemplicesel in 'USemplicesel.pas' {Fterminale},
  URunComp in 'URunComp.pas' {FRunComp},
  UDB in 'UDB.pas' {DM1: TDataModule};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFterminale, Fterminale);
  Application.CreateForm(TFRunComp, FRunComp);
  Application.CreateForm(TDM1, DM1);
  Application.Run;
end.
