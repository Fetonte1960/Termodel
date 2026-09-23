library arkpzz;

uses
  Forms,
  Main in 'MAIN.PAS' {MainForm};

{$R *.RES}

exports
  usaforma;

begin
end.

begin
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
