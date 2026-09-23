unit tipirete;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, DBCtrls,varcarichi;

type
  TFtipirete = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBComboBox1: TDBComboBox;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    DBComboBox2: TDBComboBox;
    DBCheckBox1: TDBCheckBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    DBComboBox3: TDBComboBox;
    DBCheckBox2: TDBCheckBox;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    DBComboBox4: TDBComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ftipirete: TFtipirete;

Procedure Gest_Tipirete3d;

implementation

uses Gest_form;

Var FGestform:TFGestForm=nil;

{$R *.dfm}
Procedure Gest_Tipirete3d;
begin
TipiRete_in_memoria:= false;
  begin
  Ftipirete:=TFtipirete.Create(Nil);
  FGestform:=Nuova_formDB(Ftipirete,'tipirete','codice',2);
  with FGestform do
    begin
    //chiudi_form:=chiusura;
    end;
  end;
FGestform.Showmodal;
end;

end.
