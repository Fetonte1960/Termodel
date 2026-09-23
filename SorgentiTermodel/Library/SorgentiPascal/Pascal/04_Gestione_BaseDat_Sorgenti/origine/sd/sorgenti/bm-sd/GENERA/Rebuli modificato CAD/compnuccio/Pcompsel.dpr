program Pcompsel;

uses
  Forms,
  Ucompsel in 'Ucompsel.pas' {FProgcomp},
  URunComp in 'URunComp.pas' {FRunComp};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFProgcomp, FProgcomp);
  Application.CreateForm(TFRunComp, FRunComp);
  Application.Run;
end.
