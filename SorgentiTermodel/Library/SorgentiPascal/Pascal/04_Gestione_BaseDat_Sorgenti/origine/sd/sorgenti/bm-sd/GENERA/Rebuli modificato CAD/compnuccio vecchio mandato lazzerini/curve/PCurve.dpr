program PCurve;

uses
  Forms,
  UCurve in 'UCurve.pas' {Fprovacurve},
  Uusacurve in 'Uusacurve.pas' {Usacurve};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFprovacurve, Fprovacurve);
  Application.CreateForm(TUsacurve, Usacurve);
  Application.Run;
end.
