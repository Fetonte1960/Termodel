program Provapsicro;

uses
  Forms,
  UProvapsicro in 'UProvapsicro.pas' {FProvaPsicro};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFProvaPsicro, FProvaPsicro);
  Application.Run;
end.
