program Compiladcuestivo_14;

uses
  Forms,
  F1,
  f2,
  f3,
  toted,
  funztrasfmuri,
  psicrometrico,
  varcarichi in 'P:\prjs\cpi win clima\VERSIONE_10\CARICHI\varcarichi.pas',
  Varcarichi_estivo_14 in 'P:\prjs\cpi win clima\VERSIONE_10\CARICHI\Varcarichi_estivo_14.pas';

{$R *.res}

begin
  Application.Initialize;
  Init_puntatori;
  Fase1;
  Fase2;
  Fase3;
  Calcedif;
  Application.Run;
end.
