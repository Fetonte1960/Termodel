program Ppdll;

uses
  Forms,
  Prdll in 'PRDLL.PAS' {Form1};

{$R *.RES}

begin
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
