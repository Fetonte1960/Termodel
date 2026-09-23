program PUtilityzeta;

uses
  Forms,
  UtilityZeta in 'UtilityZeta.pas' {Form1},
  LibreriaGenerale in '..\comuni\LibreriaGenerale.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
