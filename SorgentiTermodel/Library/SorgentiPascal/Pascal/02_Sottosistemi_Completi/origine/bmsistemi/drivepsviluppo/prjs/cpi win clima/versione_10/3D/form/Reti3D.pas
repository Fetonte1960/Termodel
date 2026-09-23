unit Reti3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Gest_Form, StdCtrls,udbt,ucompilaform,udatalink,gestudb,varcarichi,
  Mask, DBCtrls, LbSpeedButton, ExtCtrls,
  {$IfNdef  Isolato}  copialetturadisegno3d,{$Endif}funz_reti,
  {DBCtrls,LbSpeedButton, ExtCtrls, Mask,}utility_dll,libreriagenerale,
  Spin,setta_config_user,uleggiscrividati,tipirete;

type
  TFReti3d = class(TForm)
    GroupBox1: TGroupBox;
    DBMemo1: TDBMemo;
    Panel1: TPanel;
    LbSpeedButton1: TLbSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    LbSpeedButton2: TLbSpeedButton;
    Edit1: TEdit;
    Label5: TLabel;
    LbSpeedButton3: TLbSpeedButton;
    LbSpeedButton4: TLbSpeedButton;
    Edit2: TEdit;
    Label6: TLabel;
    SpinButton1: TSpinButton;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    DBComboBox1: TDBComboBox;
    Label7: TLabel;
    LbSpeedButton5: TLbSpeedButton;
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LbSpeedButton4Click(Sender: TObject);
    procedure SpinButton1UpClick(Sender: TObject);
    procedure SpinButton1DownClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LbSpeedButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FReti3d: TFReti3d;
  Gest_Reti3d_isolato:boolean=false;
Procedure Gest_Reti3d;

Var FGestform:TFGestForm=nil;
implementation
{$IfNdef  Isolato}
uses U3dsd;
{$Endif}
{$R *.dfm}



Procedure Chiusura;
begin
if Gest_Reti3d_isolato then exit;
{$IfNdef  Isolato}
dmtutti.T_Reti.edit;;
dmtutti.T_Reti.Post;
compilaform(Form1.groupbox56,'ConfCad',dmtutti.ds_confcad);
compilaform(Form1.groupbox2,'ConfCad',dmtutti.ds_confcad);
if V_RecConfcad.ColoreTipoReteIRR='' then
  begin
  SalvaPiano(form1.DBCombobox1.text,form1.RadioButton1.Checked,true);
  if V_recgen.Codice<>'' then
    begin
    dmtutti.T_ConfCad.Edit;
    V_RecConfcad.Set_ColoreTipoReteIRR(V_recgen.Codice);
    dmtutti.T_ConfCad.Post;
    end;
  Apripiano(form1.RadioButton1.Checked,form1.DBCombobox1.text);
  ridisegna;
  end;
{$Endif}
end;
Procedure Gest_Reti3d;
begin
  begin
  FReti3d:=TFReti3d.Create(Nil);
  FGestform:=Nuova_formDB(FReti3d,'Reti','codice',11);
  with FGestform do
    begin
    chiudi_form:=chiusura;
    end;
  end;
FGestform.Showmodal;
end;
procedure TFReti3d.LbSpeedButton1Click(Sender: TObject);
begin
count_deb:=0;
attiva_pannelli:=true;
count_deb1:=str_toint(edit2.text);
dmtutti.T_Reti.edit;
dmtutti.T_Reti.Post;
dmtutti.T_Reti.edit;
Aggiorna_Calc_reti(V_Recgen.Codice);
end;

procedure TFReti3d.LbSpeedButton2Click(Sender: TObject);
begin
Controlla_rete(V_recgen.Codice,edit1.text);
end;

procedure TFReti3d.LbSpeedButton3Click(Sender: TObject);
var piano,rete:string;
    i:integer;
begin
rete:=V_recgen.Codice;
closeudbt;
leggi_mem_piani;
for i:=1 to Npiani do
with piani_d^[i] do
if copiadi='' then
deletefile(i_sl(percorsodrive)+rete+'-'+cod+'.U2d');
Procedura_dll('CalcolaRete'  ,'Projectbrowserdll',1,rete,'','','');
openudbt;
end;

procedure TFReti3d.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Procedura_dll('ChiudiPJB','Projectbrowserdll',0,'','','','');
end;

procedure TFReti3d.LbSpeedButton4Click(Sender: TObject);
begin
closeudbt;
Procedura_dll('ShowPJB','Projectbrowserdll',0,'','','','');
openudbt;
end;

procedure TFReti3d.SpinButton1UpClick(Sender: TObject);
begin
edit2.Text:=inttostr(strtoint(edit2.Text)+1);
end;

procedure TFReti3d.SpinButton1DownClick(Sender: TObject);
begin
edit2.Text:=inttostr(strtoint(edit2.Text)-1);
end;

procedure TFReti3d.Button1Click(Sender: TObject);
begin
opendialog1.Execute;
if not fileexists(opendialog1.FileName) then exit;
closeudbt;
Procedura_dll('ApriProgettoPJB','Projectbrowserdll',1,opendialog1.FileName,'','','');
openudbt;
end;

procedure TFReti3d.LbSpeedButton5Click(Sender: TObject);
begin
Gest_tipirete3D;
end;

end.
