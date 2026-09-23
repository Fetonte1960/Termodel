unit Cambiaelab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, StdCtrls, ExtCtrls, ComCtrls,gestudb,Ucompilaform,
  Mask, DBCtrls, Buttons,Piani3d,Reti3d,udbt,libreriagenerale,ugest_cad,config_var,udatalink;

type
  TFCambiaelab3d = class(TForm)
    Panel1: TPanel;
    LbSpeedButton1: TLbSpeedButton;
    GroupBox1: TGroupBox;
    Label8: TLabel;
    DBComboBox1: TDBComboBox;
    SpeedButton4: TSpeedButton;
    PageControl24: TPageControl;
    TabSheet82: TTabSheet;
    GB2D: TGroupBox;
    Label240: TLabel;
    Label237: TLabel;
    DBEdit41: TDBEdit;
    TabSheet83: TTabSheet;
    GroupBox56: TGroupBox;
    SpeedButton21: TSpeedButton;
    DBComboBox2: TDBComboBox;
    CheckBox11: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCambiaelab3d: TFCambiaelab3d;

Procedure GestCambiaelab;

implementation
uses u3dsd,interfdll,init_Cad3d;
{$R *.dfm}

Procedure GestCambiaelab;
begin
openudbt;
copyfile(pchar(disegnocorrente),pchar(percorsodrive+'disegno.dxf'),false);
passaalcad;
FCambiaelab3d:=TFCambiaelab3d.Create(nil);
with FCambiaelab3d do
 begin
 tabsheet83.TabVisible:=false;
 compilaform(groupbox1,'CONFCAD',dmtutti.ds_confcad);
 compilaform(groupbox56,'CONFCAD',dmtutti.ds_confcad);
 end;
FCambiaelab3d.showmodal;
end;

procedure TFCambiaelab3d.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
form1.PageControl24.ActivePageIndex:=PageControl24.ActivePageIndex;
Tubi_edif(1);
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.post;
dmtutti.T_ConfCad.Edit;
passaalcad;
Set_disegnocorrente;
Scriptriprendi;
nocambia:=true;
action:=cafree;
end;

procedure TFCambiaelab3d.LbSpeedButton1Click(Sender: TObject);
Var Pdis:string;
begin
with form1 do
  begin
  //hide;
  PassaAlCad;
  PageControl1.visible:=true;
  PageControl2.Tabheight:=0;
  PageControl2.Tabwidth:=0;
  panel28.Visible:=false;
  Pdis:=leggi_var('DISEGNOCORRENTE');
  Pdis:=extractfilePath(Pdis);
  Pdis:=I_sl(Pdis)+V_recconfcad.PIANOCOR+'.dxf';
  Salva_var('DISEGNOCORRENTE',Pdis);
  copyfile(Pchar(i_sl(percorsodrive)+'disegno.dxf'),pchar(Pdis),false);
  visualizza_disegno(Pdis);
  show;
  end;
close;
end;

procedure TFCambiaelab3d.SpeedButton4Click(Sender: TObject);
begin
GestPiani3d;
compilaform(groupbox1,'CONFCAD',dmtutti.ds_confcad);
end;

procedure TFCambiaelab3d.SpeedButton21Click(Sender: TObject);
begin
Gest_Reti3d;
end;

end.
