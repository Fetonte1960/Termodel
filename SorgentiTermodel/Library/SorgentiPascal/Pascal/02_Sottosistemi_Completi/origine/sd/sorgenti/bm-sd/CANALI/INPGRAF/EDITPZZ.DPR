program EDITPZZ;

uses
  Forms,
  MainEdit in 'MAINEDIT.PAS' {Editapezzo};

{$R *.RES}

begin
  Application.CreateForm(TEditapezzo, Editapezzo);
  application.run;
end.
