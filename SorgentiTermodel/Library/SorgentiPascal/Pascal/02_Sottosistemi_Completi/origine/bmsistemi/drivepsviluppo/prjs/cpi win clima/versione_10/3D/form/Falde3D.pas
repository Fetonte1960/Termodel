unit Falde3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, LbSpeedButton, ExtCtrls,Ucompilaform,udbt,
  DBCtrls, Mask, jpeg,db,udatalink;

type
  TFFalde3D = class(TForm)
    Panel6: TPanel;
    Button2: TLbSpeedButton;
    Button3: TLbSpeedButton;
    Button4: TLbSpeedButton;
    LbSpeedButton1: TLbSpeedButton;
    LbSpeedButton3: TLbSpeedButton;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DB_AngIncl: TDBEdit;
    DBEdit_QuotaColmo: TDBEdit;
    Label2: TLabel;
    Image1: TImage;
    Button1: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Label3: TLabel;
    Image2: TImage;
    DBCheckBox1: TDBCheckBox;
    Edit1: TEdit;
    Label4: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
  Procedure Filtroconfini(Sender:  Tdataset);
    { Public declarations }
  end;
Function GestFalde3d:string;
var
  FFalde3D: TFFalde3D=nil;

implementation

{$R *.dfm}
Var codsel:string;
Procedure TFFalde3D.Filtroconfini(Sender: Tdataset);
begin
end;
Function GestFalde3d:string;
begin
codsel:='';
if FFalde3d=Nil then FFalde3d:=TFFalde3d.Create(Nil);
FFalde3d.ShowModal;
result:=codsel;
end;

procedure TFFalde3D.FormActivate(Sender: TObject);
begin
edit1.Text:='';
compilaform(groupbox2,'Confine',dmtutti.ds_Confine);
tipofiltro:='CONFINE';
ValF1:='PARETE INCLINATA';
dmtutti.T_confine.filtered:=true;
end;

procedure TFFalde3D.LbSpeedButton1Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
dmtutti.T_Confine.POst;
codsel:=V_recconf.Codice;
Close;
end;

procedure TFFalde3D.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dmtutti.T_confine.filtered:=false;
end;

procedure TFFalde3D.Button2Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Denom('Tetto inclinato ( '+V_recconf.Codice+' )');
dmtutti.T_Confine.POst;
end;

procedure TFFalde3D.Button4Click(Sender: TObject);
begin
if edit1.Text<>'' then
  begin
  dmtutti.T_Confine.append;
  dmtutti.T_Confine.Edit;
  V_recconf.set_Codice(edit1.Text);
  V_recconf.Set_Denom('Tetto inclinato ( '+V_recconf.Codice+' )');
  V_recconf.Set_TipoConfine('PARETE INCLINATA');
  dmtutti.T_Confine.POst;
  edit1.Text:='';
  end
else showmessage('Inserire un codice valido ');
end;

procedure TFFalde3D.Button3Click(Sender: TObject);
begin
dmtutti.T_Confine.delete;
end;

procedure TFFalde3D.LbSpeedButton3Click(Sender: TObject);
begin
if edit1.Text<>'' then
  begin
  dmtutti.T_Confine.insert;
  dmtutti.T_Confine.Edit;
  V_recconf.set_Codice(edit1.Text);
  V_recconf.Set_Denom('Tetto inclinato ( '+V_recconf.Codice+' )');
  V_recconf.Set_TipoConfine('PARETE INCLINATA');
  dmtutti.T_Confine.POst;
  edit1.Text:=''
  end
else showmessage('Inserire un codice valido ');
end;

procedure TFFalde3D.Button1Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Orient(0);
dmtutti.T_Confine.POst;
end;

procedure TFFalde3D.Button6Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Orient(90);
dmtutti.T_Confine.POst;
end;

procedure TFFalde3D.Button5Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Orient(180);
dmtutti.T_Confine.POst;
end;

procedure TFFalde3D.Button7Click(Sender: TObject);
begin
dmtutti.T_Confine.Edit;
V_recconf.Set_Orient(270);
dmtutti.T_Confine.POst;
end;

procedure TFFalde3D.FormCreate(Sender: TObject);
begin
compilaGriglia(dbgrid1,'Confine',dmtutti.ds_Confine);
end;

end.
