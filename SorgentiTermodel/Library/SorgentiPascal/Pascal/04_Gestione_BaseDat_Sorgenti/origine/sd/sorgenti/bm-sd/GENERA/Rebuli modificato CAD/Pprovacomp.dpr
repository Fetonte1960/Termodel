program Pprovacomp;

uses
  Forms,
  Uprovacomp in 'Uprovacomp.pas' {Form1},
  USceltaPann in 'USceltaPann.pas' {Fsceltapann};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFsceltapann, Fsceltapann);
  Application.Run;
end.
