unit Zone3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, ExtCtrls, StdCtrls, Grids, DBGrids,dbtables,udbt,db,libreriagenerale,Ucompilaform,
  dateutils, Mask, DBCtrls,gest_form,Udatalink, Buttons, ComCtrls,generatori3D;

type
  TFZone3d = class(TForm)
    GBEdifZone: TGroupBox;
    Label38: TLabel;
    Label42: TLabel;
    Label83: TLabel;
    Label103: TLabel;
    Label84: TLabel;
    Label102: TLabel;
    Label115: TLabel;
    Label117: TLabel;
    LbSpeedButton3: TLbSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit53: TDBEdit;
    DBEdit51: TDBEdit;
    DBEdit52: TDBEdit;
    DBEdit46: TDBEdit;
    DBEdit6: TDBEdit;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FZone3d: TFZone3d;

Var FGestform:TFGestForm=nil;
Procedure Gest_Zone3d;


implementation

{$R *.dfm}


Procedure Gest_Zone3d;
begin
  begin
  FZone3D:=TFZone3d.Create(Nil);
  FGestform:=Nuova_formDB(FZone3d,'Zone','Codice',4);
  with FGestform do
    begin
    //chiudi_form:=chiusura;
    end;
  end;
FGestform.Showmodal;
end;




end.
