program Provacanali;

uses
  Forms,
  UProvacanali in 'UProvacanali.pas' {Form1},
  Print in 'Print.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
