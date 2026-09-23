unit formpezzi;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,u3dsd,uoggetti, ComCtrls, StdCtrls,
  ExtCtrls;

type
  TFpezzi = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    TrackBar1: TTrackBar;
    RBVista: TRadioButton;
    RBLuci: TRadioButton;
    TrackBar3: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    RBscheletro: TCheckBox;
    CheckBox1: TCheckBox;
    CBLocale: TComboBox;
    CB_Reti: TCheckBox;
    CBdentro: TCheckBox;
    CbAssi: TCheckBox;
    CBVetri: TCheckBox;
    CBPIano: TComboBox;
    CBHmedia: TCheckBox;
    Test1: TTrackBar;
    BSalva: TButton;
    BRichiama: TButton;
    Test2: TTrackBar;
    Test3: TTrackBar;
    HostPanel: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure HostPanelResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure FormDestroy(Sender: TObject);
    procedure Panel1Click(Sender: TObject);
    procedure RBscheletroClick(Sender: TObject);
    procedure CB_RetiClick(Sender: TObject);
    procedure CBLocaleChange(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure TrackBar5Change(Sender: TObject);
    procedure CBdentroClick(Sender: TObject);
    procedure CbAssiClick(Sender: TObject);
    procedure CBPIanoChange(Sender: TObject);
  private
    { Private declarations }
  public
  procedure display(ac:boolean);
    { Public declarations }
  end;

var
  Fpezzi: TFpezzi;


implementation

{$R *.dfm}
procedure TFpezzi.display(ac:boolean);
Var xcor,ycor,zcor,acor,bcor,hcor,r1,r2,r3,xx1,yy1,xx2,yy2:real;
begin
cancellatutto;
InitVariabili;
//Disegnaedificio(percorsoDrive,ac);
settaIngr;
end;

procedure TFpezzi.FormCreate(Sender: TObject);
begin
form1a:=Tform1.Create(nil);
//form1a:=Tform1.Create(nil);
form1a.Show;
//form1a.Show;
end;

procedure TFpezzi.FormShow(Sender: TObject);
begin
//manualdock(Form1.pagecontrol1,F3d,alnone);
end;

procedure TFpezzi.HostPanelResize(Sender: TObject);
begin
//form1.top:=f3d.top-HostPanel.top+(f3d.height-f3d.Clientheight);
//form1.left:=f3d.left+HostPanel.left+(f3d.width-f3d.clientwidth);
//form1.width:=HostPanel.Width;
//form1.height:=HostPanel.height;
//form1.Show;
end;

procedure TFpezzi.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 form1a.Close;
 action:=cafree;
end;

procedure TFpezzi.FormPaint(Sender: TObject);
begin
(*
form1.top:=f3d.top-HostPanel.top+(f3d.height-f3d.Clientheight);
form1.left:=f3d.left+HostPanel.left+(f3d.width-f3d.clientwidth);
form1.width:=HostPanel.Width;
form1.height:=HostPanel.height;
form1.Show;
*)
end;

procedure TFpezzi.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
form1a.top:=fpezzi.top-HostPanel.top+(fpezzi.height-fpezzi.Clientheight);
form1a.left:=fpezzi.left+HostPanel.left+(fPezzi.width-fpezzi.clientwidth);
form1a.width:=HostPanel.Width-(fpezzi.width-fpezzi.clientwidth);
form1a.height:=HostPanel.height-(fpezzi.width-fpezzi.clientwidth);
form1a.Show;
end;

procedure TFpezzi.FormDestroy(Sender: TObject);
begin
fPezzi:=nil;
end;

procedure TFpezzi.Panel1Click(Sender: TObject);
begin
//panel1.Visible:=not(panel1.Visible);
end;

procedure TFpezzi.RBscheletroClick(Sender: TObject);
begin
display(false);
end;

procedure TFpezzi.CB_RetiClick(Sender: TObject);
begin
display(false);
end;

procedure TFpezzi.CBLocaleChange(Sender: TObject);
begin
display(false);
end;

procedure TFpezzi.TrackBar1Change(Sender: TObject);
begin
form1a.TrackBar1.position:=TrackBar1.position;
end;

procedure TFpezzi.TrackBar3Change(Sender: TObject);
begin
form1a.TrackBar3.position:=TrackBar3.position;
end;

procedure TFpezzi.TrackBar2Change(Sender: TObject);
begin
form1a.TrackBar2.position:=TrackBar2.position;
end;

procedure TFpezzi.TrackBar4Change(Sender: TObject);
begin
form1a.TrackBar4.position:=TrackBar4.position;
end;

procedure TFpezzi.TrackBar5Change(Sender: TObject);
begin
form1a.TrackBar5.position:=TrackBar5.position;
end;

procedure TFpezzi.CBdentroClick(Sender: TObject);
begin
form1a.cbdentro.Checked:=cbdentro.Checked;
display(false);
end;

procedure TFpezzi.CbAssiClick(Sender: TObject);
begin
form1a.cbassi.Checked:=cbassi.Checked;
display(false);
end;

procedure TFpezzi.CBPIanoChange(Sender: TObject);
begin
display(false);
end;

end.
