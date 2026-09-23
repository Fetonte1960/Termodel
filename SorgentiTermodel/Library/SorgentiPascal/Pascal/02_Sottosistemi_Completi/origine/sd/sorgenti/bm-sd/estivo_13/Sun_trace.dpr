program Sun_trace;

uses
  Forms,
  F1,
  f2,
  f3,
  toted,
  funztrasfmuri,
  psicrometrico,
  varcarichi in 'P:\prjs\cpi win clima\VERSIONE_10\CARICHI\VarCarichi.pas',
  Main_suntrace in 'Main_suntrace.pas' {FMain_suntrace};

{$R *.res}

begin
  Application.Initialize;
  Init_puntatori;
  //Fase1;
  //Fase2;
  //Fase3;
  //Calcedif;
  Application.CreateForm(TFMain_suntrace, FMain_suntrace);
  Application.Run;
end.
