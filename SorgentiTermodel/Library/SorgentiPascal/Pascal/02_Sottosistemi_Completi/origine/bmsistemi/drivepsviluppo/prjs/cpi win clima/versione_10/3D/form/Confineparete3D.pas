unit Confineparete3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Gest_form, StdCtrls, Mask, DBCtrls,udatalink,Udbt, jpeg, ExtCtrls,
  LbSpeedButton,libreriagenerale;

type
  TFConfineparete3D = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DBETInv: TDBEdit;
    Label2: TLabel;
    GroupBox3: TGroupBox;
    DBCheckBox1: TDBCheckBox;
    GroupBox4: TGroupBox;
    Image1: TImage;
    Label16: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label8: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label14: TLabel;
    DBEdit8: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit15: TDBEdit;
    DBComboBox3: TDBComboBox;
    Label7: TLabel;
    DBEdit3: TDBEdit;
    Label9: TLabel;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    Image2: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Image3: TImage;
    Label10: TLabel;
    DBEdit1: TDBEdit;
    DB_AngIncl: TDBEdit;
    DBEdit_QuotaColmo: TDBEdit;
    Button1: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    DBCheckBox2: TDBCheckBox;
    GroupBox7: TGroupBox;
    DBCheckBox3: TDBCheckBox;
    GroupBox8: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit2: TDBEdit;
    GroupBox9: TGroupBox;
    GroupBox10: TGroupBox;
    DBCheckBox4: TDBCheckBox;
    GroupBox11: TGroupBox;
    Label13: TLabel;
    Label18: TLabel;
    DBEdit4: TDBEdit;
    GroupBox12: TGroupBox;
    GroupBoxTerreno1: TGroupBox;
    Label24: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    DBComboBox1: TDBComboBox;
    DBEdit17: TDBEdit;
    DBEdit14: TDBEdit;
    GroupBox13: TGroupBox;
    Image4: TImage;
    Label21: TLabel;
    DBEdit6: TDBEdit;
    GroupBox14: TGroupBox;
    Image5: TImage;
    Label20: TLabel;
    DBEdit5: TDBEdit;
    BtnKLegge10: TLbSpeedButton;
    Label22: TLabel;
    DBEdit7: TDBEdit;
    Label25: TLabel;
    GroupBox15: TGroupBox;
    Image6: TImage;
    Label23: TLabel;
    DBEdit11: TDBEdit;
    Label26: TLabel;
    Label27: TLabel;
    DBEdit9: TDBEdit;
    SpeedButton2: TLbSpeedButton;
    DBEdit10: TDBEdit;
    Label28: TLabel;
    LbSpeedButton1: TLbSpeedButton;
    Label29: TLabel;
    DBEdit16: TDBEdit;
    Label34: TLabel;
    Label35: TLabel;
    DBEdit18: TDBEdit;
    Label36: TLabel;
    Label37: TLabel;
    DBEdit19: TDBEdit;
    LbSpeedButton2: TLbSpeedButton;
    GroupBox16: TGroupBox;
    Image7: TImage;
    Label38: TLabel;
    DBEdit20: TDBEdit;
    LbSpeedButton3: TLbSpeedButton;
    Label39: TLabel;
    DBEdit21: TDBEdit;
    Label40: TLabel;
    Label41: TLabel;
    DBEdit22: TDBEdit;
    Label42: TLabel;
    Label43: TLabel;
    DBEdit23: TDBEdit;
    LbSpeedButton4: TLbSpeedButton;
    GroupBox17: TGroupBox;
    Image8: TImage;
    Label49: TLabel;
    DBEdit27: TDBEdit;
    LB_mqm: TLabel;
    Label50: TLabel;
    DBEdit28: TDBEdit;
    SpeedButton3: TLbSpeedButton;
    LbSpeedButton6: TLbSpeedButton;
    Lb_H: TLabel;
    DBE_H: TDBEdit;
    LB29_m: TLabel;
    Label44: TLabel;
    DBEdit24: TDBEdit;
    LbSpeedButton5: TLbSpeedButton;
    GroupBox18: TGroupBox;
    Image9: TImage;
    Label45: TLabel;
    DBEdit25: TDBEdit;
    LbSpeedButton7: TLbSpeedButton;
    Label46: TLabel;
    DBEdit26: TDBEdit;
    Label47: TLabel;
    GroupBox19: TGroupBox;
    Image10: TImage;
    Label48: TLabel;
    DBEdit29: TDBEdit;
    LbSpeedButton8: TLbSpeedButton;
    Label51: TLabel;
    DBEdit30: TDBEdit;
    LbSpeedButton9: TLbSpeedButton;
    LB_N: TLabel;
    DB_EditN: TDBEdit;
    LB_VH: TLabel;
    Label52: TLabel;
    DBEdit31: TDBEdit;
    Label53: TLabel;
    Label54: TLabel;
    DBEdit32: TDBEdit;
    Label55: TLabel;
    procedure DBCheckBox1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type TGestconfini=(TGCparete,TgcSoffitto,TgcPavim);
var
  FConfineparete3D: TFConfineparete3D;

Procedure Gest_ConfineParete3d(tipoform:TGestconfini);
Procedure AggiornaformTerreno;

implementation
Var FGestform:TFGestForm=nil;
    TipoF:TGestconfini;
{$R *.dfm}
Procedure Nuovarigaconfine;
begin
case TipoF of
TGCparete:
  begin
  V_recconf.Set_TipoConfine('INTERNO');
  V_recconf.Set_Inclin(90);
  end;
  TGCSoffitto:
  begin
  V_recconf.Set_TipoConfine('INTERNO');
  V_recconf.Set_Inclin(0);
  end;
  TGCPavim:
  begin
  V_recconf.Set_TipoConfine('TERRENO');
  V_recconf.Set_Inclin(180);
  end;

end;
end;

Procedure AggiornaFormConfineParete;
begin
if dmtutti.T_confine.RecordCount=0 then
  begin
  FConfineparete3D.GroupBox1.visible:=false;
  FConfineparete3D.GroupBox5.visible:=false;
  FConfineparete3D.GroupBox9.visible:=false;
  exit;
  end;
  case Tipof of
  TGCparete:FConfineparete3D.GroupBox1.visible:=true;
  TGCSoffitto:FConfineparete3D.GroupBox5.visible:=true;
  TGCPavim:FConfineparete3D.GroupBox9.visible:=true;
  end;


dmtutti.T_confine.edit;
dmtutti.T_confine.Post;
dmtutti.T_confine.edit;
with FConfineparete3D do
if V_recconf.TipoConfine='INTERNO' then
  begin
  groupbox2.visible:=true;
  groupbox4.visible:=false;
  groupbox8.visible:=true;
  groupbox6.visible:=false;
  groupbox11.visible:=true;
  groupbox12.visible:=false;
  end
else
  begin
  groupbox2.visible:=false;
  groupbox4.visible:=true;
  groupbox8.visible:=false;
  groupbox6.visible:=true;
  groupbox11.visible:=false;
  groupbox12.visible:=true;
  end;
Aggiornaformterreno;
end;

Procedure Gest_ConfineParete3d(tipoform:TGestconfini);
begin
TipoF:=TipoForm;
//if FGestform=Nil then
  begin
  FConfineparete3D:=TFConfineparete3D.create(nil);
  case tipoform of
  TgcParete:FConfineparete3D.caption:='Pareti confinanti con spazi a temperatura prefissata  oppure ombreggiate';
  TgcSoffitto:FConfineparete3D.caption:='Soffitti confinanti con spazi a temperatura prefissata  oppure falde inclinate';
  TgcPavim:FConfineparete3D.caption:='Pavimenti confinanti con spazi a temperatura prefissata  oppure con il terreno';
  end;
  FGestform:=Nuova_formDB(FConfineparete3D,'CONFINE','Codice',2);
  with FGestform do
    begin
    nuova_riga:=Nuovarigaconfine;
    Aggiornaform:=AggiornaFormConfineParete;
    case tipoform of
    TgcParete:
      begin
      FConfineparete3D.groupbox1.visible:=true;
      FConfineparete3D.groupbox5.visible:=false;
      FConfineparete3D.groupbox1.align:=alclient;
      FConfineparete3D.groupbox9.visible:=false;
      tipofiltro:='PARETE';
      end;
    TgcSoffitto:
      begin
      FConfineparete3D.groupbox5.visible:=true;
      FConfineparete3D.groupbox1.visible:=false;
      FConfineparete3D.groupbox5.align:=alclient;
      FConfineparete3D.groupbox9.visible:=false;
      tipofiltro:='SOFFITTO';
      end;
    TgcPavim:
      begin
      FConfineparete3D.groupbox5.visible:=false;
      FConfineparete3D.groupbox1.visible:=false;
      FConfineparete3D.groupbox9.visible:=true;
      FConfineparete3D.groupbox9.align:=alclient;
      tipofiltro:='PAVIMENTO';
      end;
    end;
    dmtutti.T_confine.filtered:=true;
    AggiornaFormConfineParete;
    end;
  end;
FGestform.Showmodal;
end;
procedure TFConfineparete3D.DBCheckBox1Click(Sender: TObject);
begin
AggiornaFormConfineParete;
end;

procedure TFConfineparete3D.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dmtutti.T_confine.filtered:=false;
end;

procedure TFConfineparete3D.Button1Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Orient(0);
dmtutti.T_Confine.POst;
end;

procedure TFConfineparete3D.Button6Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Orient(90);
dmtutti.T_Confine.POst;
end;

procedure TFConfineparete3D.Button5Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Orient(180);
dmtutti.T_Confine.POst;
end;

procedure TFConfineparete3D.Button7Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Orient(270);
dmtutti.T_Confine.POst;
end;

Procedure AggiornaformTerreno;
begin
with Fconfineparete3d do
  begin
  groupbox13.Visible:=false;
  groupbox14.Visible:=false;
  groupbox15.Visible:=false;
  groupbox16.Visible:=false;
  groupbox17.Visible:=false;
  groupbox18.Visible:=false;
  groupbox19.Visible:=false;

     Case DbComboBox1.ItemIndex of
       0 : begin //  PAVIMENTO. SU TERR. SENZA ISOLAM./CON ISOLAM. UNIFORME
           groupbox13.Visible:=true;
           groupbox13.align:=alclient;
           end;
       1 : begin //PAV. CON ISOLAM. PERIMETRALE ORIZZONTALE
           groupbox14.Visible:=true;
           groupbox14.align:=alclient;
           end;
       2 : begin //- PAV. CON ISOLAM. PERIMETR. VERTICALE E ASSIMILABILI
                 //- 13370 PAV. CON ISOLAM. PERIMETR. VERTICALE (strato Isolante)
           groupbox15.Visible:=true;
           groupbox15.align:=alclient;
           end;
       3 : begin //- 13370 PAV. CON ISOLAM. PERIMETR. VERTICALE (fondazione a bassa densità)
           groupbox16.Visible:=true;
           groupbox16.align:=alclient;
           end;
       4 : begin //PAVIMENTO SU SPAZIO AERATO
           groupbox17.Visible:=true;
           groupbox17.align:=alclient;
           end;
       5 : begin //PAVIMENTO INTERRATO RISCALDATO
           groupbox18.Visible:=true;
           groupbox18.align:=alclient;
           end;
        6 :begin //PAVIMENTO INTERRATO NON RISCALDATO O PARZIALMENTE RISCALDATO
           groupbox19.Visible:=true;
           groupbox19.align:=alclient;
           end;
     end;

  end;
end;
procedure TFConfineparete3D.DBComboBox1Change(Sender: TObject);
begin
aggiornaformTerreno;
end;

end.
