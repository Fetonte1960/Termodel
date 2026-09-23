program Gestionedati;

uses
  Forms,
  MainGestionegenera in '..\gestione\MainGestionegenera.pas' {FGestioneGenera};

{$R *.res}

begin
  Application.Initialize;
  InitPuntatori;
  Application.CreateForm(TFGestioneGenera, FGestioneGenera);
  Application.Run;
end.
