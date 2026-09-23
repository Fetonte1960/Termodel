unit Generatore3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LbSpeedButton, ExtCtrls,UCompilaForm,UdBT, Mask,
  DBCtrls, ComCtrls,{ cxControls, cxContainer, cxEdit, cxCheckBox,}udatalink,sceltaA;

type
  TFGeneratore3D = class(TForm)
    Panel6: TPanel;
    LbSpeedButton1: TLbSpeedButton;
    GBGeneratore3D: TGroupBox;
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    DBComboBox1: TDBComboBox;
    DBEdit2: TDBEdit;
    DBEdit16: TDBEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    Label20: TLabel;
    Label18: TLabel;
    Label8: TLabel;
    DBComboBox3: TDBComboBox;
    DBEdit3: TDBEdit;
    DBEdit9: TDBEdit;
    GroupBox11: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label17: TLabel;
    Label22: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    GBPel: TGroupBox;
    Label10: TLabel;
    Label15: TLabel;
    Label26: TLabel;
    Label34: TLabel;
    DBEdit5: TDBEdit;
    DBEdit11: TDBEdit;
    TabSheet4: TTabSheet;
    GBPmot: TGroupBox;
    Label75: TLabel;
    Label80: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    DBEdit34: TDBEdit;
    DBEdit38: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit6: TDBEdit;
    GroupBox3: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    SpeedButton5: TLbSpeedButton;
    Label44: TLabel;
    Label45: TLabel;
    Label37: TLabel;
    Label19: TLabel;
    DBComboBox5: TDBComboBox;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit17: TDBEdit;
    Label43: TLabel;
    DBComboBox2: TDBComboBox;
    DBCheckBox1: TDBCheckBox;
    LbSpeedButton2: TLbSpeedButton;
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
   
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGeneratore3D: TFGeneratore3D=nil;

Procedure GestGeneratore3D;

implementation
{$R *.dfm}
Procedure GestGeneratore3D;
begin
if FGeneratore3D=nil then FGeneratore3D:=TFGeneratore3D.Create(nil);
FGeneratore3D.ShowModal;
end;
Procedure Aggiornacontrols;
begin
compilaform(FGeneratore3D.GBGeneratore3D,'Generatori',dmtutti.ds_Generatori);
compilaform(FGeneratore3D.GBPmot,'Generatori',dmtutti.ds_Generatori);
compilaform(FGeneratore3D.GBPel,'Generatori',dmtutti.ds_Generatori);
//Dmtutti.T_Generatori.Edit;
//Dmtutti.T_Generatori.POst;
//Dmtutti.T_Generatori.Edit;
FGeneratore3D.DBComboBox1Change(nil);
end;
procedure TFGeneratore3D.LbSpeedButton1Click(Sender: TObject);
begin
Dmtutti.T_Generatori.Edit;
Dmtutti.T_Generatori.POst;
Dmtutti.T_Generatori.Edit;
Close;
end;

procedure TFGeneratore3D.FormActivate(Sender: TObject);
begin
Aggiornacontrols;
end;

procedure TFGeneratore3D.DBComboBox1Change(Sender: TObject);
begin
Dmtutti.T_Generatori.Edit;
Dmtutti.T_Generatori.POst;
Dmtutti.T_Generatori.Edit;
if Uppercase(V_recgenerat.Tipo)='CALDAIA' then
  begin
  groupbox3.Visible:=true;
  groupbox11.Visible:=false;
  end
else
  begin
  groupbox3.Visible:=false;
  groupbox11.Visible:=true;
  end;
end;

procedure TFGeneratore3D.LbSpeedButton2Click(Sender: TObject);
begin
Salva_in_archivio('Generatori','Modello');
end;

end.
