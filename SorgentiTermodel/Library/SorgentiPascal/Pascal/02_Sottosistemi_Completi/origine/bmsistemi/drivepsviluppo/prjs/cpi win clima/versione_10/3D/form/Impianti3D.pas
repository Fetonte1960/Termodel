unit Impianti3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, ExtCtrls, StdCtrls, Grids, DBGrids,dbtables,udbt,db,libreriagenerale,Ucompilaform,
  dateutils, Mask, DBCtrls,gest_form,Udatalink, Buttons, ComCtrls,generatori3D;

type
  TFImpianti3d = class(TForm)
    PageControl3: TPageControl;
    TabSheet3: TTabSheet;
    GroupBox2: TGroupBox;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBComboBox2: TDBComboBox;
    DBComboBox4: TDBComboBox;
    DBComboBox5: TDBComboBox;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label27: TLabel;
    Label46: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton9: TSpeedButton;
    DBEdit1: TDBEdit;
    DBEdit4: TDBEdit;
    DBComboBox9: TDBComboBox;
    DBComboBox14: TDBComboBox;
    GroupBox6: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label28: TLabel;
    Label47: TLabel;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    DBEdit5: TDBEdit;
    DBEdit7: TDBEdit;
    DBComboBox10: TDBComboBox;
    DBComboBox15: TDBComboBox;
    TabSheet1: TTabSheet;
    GroupBox_DatiImpianto: TGroupBox;
    Label21: TLabel;
    Label4: TLabel;
    Label49: TLabel;
    DBComboBox3: TDBComboBox;
    DBComboBox1: TDBComboBox;
    DBEdit2: TDBEdit;
    GroupBox_VentMecInv: TGroupBox;
    Label73: TLabel;
    Label120: TLabel;
    Label121: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label124: TLabel;
    Label51: TLabel;
    Label1: TLabel;
    SpeedButton8: TSpeedButton;
    SpeedButton10: TSpeedButton;
    DBEdit48: TDBEdit;
    DBEdit66: TDBEdit;
    DBEdit67: TDBEdit;
    DBComboBox6: TDBComboBox;
    DBComboBox8: TDBComboBox;
    GroupBox_VentMecImpEst: TGroupBox;
    Label22: TLabel;
    Label32: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label31: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label30: TLabel;
    Label29: TLabel;
    Label70: TLabel;
    Label74: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label7: TLabel;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    DBComboBox7: TDBComboBox;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit47: TDBEdit;
    DBEdit50: TDBEdit;
    DBEdit14: TDBEdit;
    DBComboBox11: TDBComboBox;
    GroupBox_Tuttaria: TGroupBox;
    Label3: TLabel;
    Label18: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label37: TLabel;
    Label40: TLabel;
    Label181: TLabel;
    Label182: TLabel;
    Label183: TLabel;
    Label184: TLabel;
    DBComboBox21: TDBComboBox;
    DBEditN1: TDBEdit;
    DBEditN2: TDBEdit;
    DBEditN3: TDBEdit;
    DBEditN4: TDBEdit;
    DBEditN5: TDBEdit;
    DBEditN6: TDBEdit;
    DBEditN7: TDBEdit;
    DBEditN8: TDBEdit;
    DBEditN9: TDBEdit;
    TabSheet2: TTabSheet;
    GroupBox10: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label11: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label174: TLabel;
    Label178: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    Label48: TLabel;
    SB_Help: TLbSpeedButton;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit18: TDBEdit;
    DBComboBox12: TDBComboBox;
    DBComboBox13: TDBComboBox;
    DBComboBox37: TDBComboBox;
    GB_legge10Vent: TGroupBox;
    Label57: TLabel;
    Label59: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label10: TLabel;
    DBComboBox20: TDBComboBox;
    DBEdit42: TDBEdit;
    DBEdit43: TDBEdit;
    DBEdit44: TDBEdit;
    procedure SpeedButton9Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FImpianti3d: TFImpianti3d;

Var FGestform:TFGestForm=nil;
Procedure Gest_Impianti3d;


implementation

{$R *.dfm}


Procedure Gest_Impianti3d;
begin
  begin
  FImpianti3D:=TFImpianti3d.Create(Nil);
  FGestform:=Nuova_formDB(FImpianti3d,'Impianti','Codice',2);
  with FGestform do
    begin
    //chiudi_form:=chiusura;
    end;
  end;
FGestform.Showmodal;
end;


procedure TFImpianti3d.SpeedButton9Click(Sender: TObject);
begin
Gest_Generatori3d;
Compilaform(Groupbox3,'IMPIANTI',Dmtutti.DS_Impianti);
end;

end.
