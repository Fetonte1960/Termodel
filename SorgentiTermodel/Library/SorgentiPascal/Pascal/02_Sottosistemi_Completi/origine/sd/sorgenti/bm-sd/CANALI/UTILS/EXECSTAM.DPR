(*library execstam;

uses
  Forms,
  Mainst in 'MAINST.PAS' {MainForm}
  ;

{$R *.RES}
  exports faistampa;

begin
end.
*)
program execstam;

uses
  Forms,
  Mainst in 'MAINST.PAS' {MainForm};

(*{$R *.RES}*)

begin
  faistampa;
  {Application.CreateForm(TMainForm, MainForm);
  Application.Run;}

end.

