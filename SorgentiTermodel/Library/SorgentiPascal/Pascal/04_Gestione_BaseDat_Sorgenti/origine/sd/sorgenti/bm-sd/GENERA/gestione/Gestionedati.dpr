program Gestionedati;

uses
  Forms,
  MainGestionegenera in 'MainGestionegenera.pas' {FGestioneGenera};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFGestioneGenera, FGestioneGenera);
  Application.Run;
end.
