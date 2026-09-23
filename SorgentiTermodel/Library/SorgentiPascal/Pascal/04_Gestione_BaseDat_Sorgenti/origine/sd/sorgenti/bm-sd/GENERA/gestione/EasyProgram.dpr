program EasyProgram;

uses
  Forms,
  MainGestionegenera in '..\distribuzione\MainGestionegenera.pas' {FGestioneGenera},
  Init_easy in 'Init_easy.pas',
  GestDB in 'GestDB.pas' {FGestDb},
  Gest_form in '..\..\librerie_generali\Gest_form.pas' {FGestForm},
  Varcarichi in '..\distribuzione\Varcarichi.pas',
  UMainGenera in '..\modifica kbmtable\UMainGenera.pas' {Form1},
  UCalc in '..\modifica kbmtable\UCalc.pas',
  UFunzGenera in '..\modifica kbmtable\UFunzGenera.pas',
  calcolo in '..\distribuzione\calcolo.pas',
  Messaggi_easy in '..\distribuzione\Messaggi_easy.pas';

{$R *.res}

begin
  Application.Initialize;
  InitPuntatori;
  Application.CreateForm(TFGestioneGenera, FGestioneGenera);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
