unit U3dsd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLWin32Viewer, ExtCtrls, GLScene, GLObjects, GLMisc, StdCtrls,
  ComCtrls, MPlayer,UOggetti,gltexture, GLSkydome, GLParticles,
  GLCadencer,GLBehaviours, GLSpaceText,glmovement,uarchpezzi, Spin;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    GLSceneViewer1: TGLSceneViewer;
    GLScene1: TGLScene;
    GLCamera1: TGLCamera;
    DCOggetti: TDummyCube;
    TrackBar1: TTrackBar;
    Label1: TLabel;
    DCLuci: TDummyCube;
    Label2: TLabel;
    RBVista: TRadioButton;
    RBLuci: TRadioButton;
    Sphere1: TSphere;
    Label3: TLabel;
    TrackBar3: TTrackBar;
    DCVista: TDummyCube;
    DCGenerale: TDummyCube;
    DCGlobale: TDummyCube;
    DcParticles: TDummyCube;
    Disk1: TDisk;
    Cylinder1: TCylinder;
    Cube1: TCube;
    TrackBar2: TTrackBar;
    TrackBar4: TTrackBar;
    Label4: TLabel;
    Label6: TLabel;
    TrackBar5: TTrackBar;
    Label7: TLabel;
    CheckBox1: TCheckBox;
    CBdentro: TCheckBox;
    CbAssi: TCheckBox;
    Test1: TTrackBar;
    Test2: TTrackBar;
    Test3: TTrackBar;
    CBHmedia: TCheckBox;
    Panel2: TPanel;
    rbscheletro: TCheckBox;
    cbcodpezzo: TComboBox;
    Label5: TLabel;
    Label8: TLabel;
    CBEntrata: TComboBox;
    Label9: TLabel;
    CBNUSCITE: TComboBox;
    LDescrpezzo: TLabel;
    LCod2: TLabel;
    Label10: TLabel;
    CBTipo: TComboBox;
    Cborient: TComboBox;
    Label11: TLabel;
    Panel3: TPanel;
    Image1: TImage;
    Epezzo: TEdit;
    SBPezzo: TSpinEdit;
    LPezzo: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    TBTurn: TTrackBar;
    Label14: TLabel;
    CBUscita1: TComboBox;
    Label15: TLabel;
    CBUscita2: TComboBox;
    GBVarie: TGroupBox;
    Label16: TLabel;
    CBFlusso: TComboBox;
    procedure TrackBar1Change(Sender: TObject);
    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RBVistaClick(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure GLSceneViewer1DblClick(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RBscheletroClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CBLocaleChange(Sender: TObject);
    procedure CB_RetiClick(Sender: TObject);
    procedure CBdentroClick(Sender: TObject);
    procedure CbAssiClick(Sender: TObject);
    procedure CBVetriClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBHmediaClick(Sender: TObject);
    procedure Test1Change(Sender: TObject);
    procedure BSalvaClick(Sender: TObject);
    procedure BRichiamaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CBNUSCITEChange(Sender: TObject);
    procedure cbcodpezzoChange(Sender: TObject);
    procedure CborientChange(Sender: TObject);
    procedure TBTurnChange(Sender: TObject);
    procedure CBUscita1Change(Sender: TObject);
    procedure CBEntrataChange(Sender: TObject);
  private
    { Private declarations }
  public

    procedure CubeProgress(Sender: TObject; const deltaTime,newTime: Double);
    procedure display(ac:boolean);
    Procedure Vis_pezzi_can(nomepr:string;ind:integer);

    { Public declarations }
  end;

var
  Form1,Form1a: TForm1;
  MX,My:integer;
  count:integer;
  countP:integer;
  NumEntita:integer;
  Ingrbase:real;


Procedure Cancellatutto;
Procedure Trackchange;

implementation

{$R *.dfm}

Procedure Trackchange;
Var ingra:real;
begin
ingra:=(form1.trackbar1.position)/40*2*ingrbase;
Form1.DCGenerale.Scale.X:=ingra;
Form1.DCGenerale.Scale.y:=ingra;
Form1.DCGenerale.Scale.z:=ingra;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
trackchange;
end;

procedure TForm1.GLSceneViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
Mx:=x;
My:=y;
end;

procedure TForm1.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if ssLeft in Shift then
  begin
// if rbvista.Checked then
    begin
    GLCamera1.MoveAroundTarget(my-y, mx-x);
    end;
// else
(*
  with DCLuci  do
    begin
    rollangle:=rollangle+(my-y);
    turnangle:=turnangle+(mx-x);
    end;
 *)   
   mx:=x;
   my:=y;

// DCLuci.MoveAroundTarget(my-y, mx-x);

   end;
//if Shift<>[] then GLCamera1.MoveAroundTarget((mx-x)/100,(my-y)/100);
{str(rollangle:4:0,lra.Caption);
lra.caption:='Roll:'+lra.caption;}
end;

procedure TForm1.RBVistaClick(Sender: TObject);
begin
if RBVista.checked then RBLuci.Checked:=false;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
settaingr;
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
glcamera1.FocalLength:=trackbar3.position*10+50;
//if trackbar3.position<=5 then
//glcamera1.FocalLength:=ingrbase*trackbar3.POsition/5
//else glcamera1.FocalLength:=ingrbase+(trackbar3.POsition-5)*ingrbase;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Modicord1        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);
Var Dist,Ang:real;
begin
if CordY=0 then
  begin
  if Cordx>=0 then ang:=pi/2 else ang:=(3/2)*pi;
  end
else
  begin
  if Cordy>0 then
    begin
    ang:=arctan(Cordx/abs(Cordy));
    end
  else
  ang:=(pi-arctan(Cordx/abs(Cordy)));
  end;
if ang<0 then ang:=2*pi+ang;

Dist:=sqrt(sqr(Cordx)+sqr(Cordy))*ing;
Ang:=Ang+Rot;
CordX:=sin(ang)*Dist+Dx;
Cordy:=Cos(ang)*Dist+Dy;
end;


procedure TForm1.display(ac:boolean);
Var xcor,ycor,zcor,acor,bcor,hcor,r1,r2,r3,xx1,yy1,xx2,yy2:real;
begin
cancellatutto;
//GLCamera1.MoveAroundTarget(-30,-30);
InitVariabili;
cambiacodice;
//panel1.Visible:=false;
//Disegnaedificio(percorsoDrive,ac);
(*
assignfile(f3d,'C:\sd\progettoprova\completo prova\Work_esempio piccolo\disegno.3dm');
reset(f3d);
while not eof(f3d) do
begin
read(f3d,buf3d);
with buf3d do
  case Entita[1] of
  'B':begin
      xx1:=-par[3]/2;
      YY1:=0;
      modicord1(xx1,yy1,XCOR,YCOR,R1,1);
      xx2:=par[3]/2;
      YY2:=0;
      modicord1(xx2,yy2,XCOR,YCOR,R1,1);
      //PareteSemp(0,xx1,yy1,xx2,yy2,Par[1],par[2],'');
      end;
  'T':begin
      xcor:=par[1];
      ycor:=par[2];
      zcor:=par[3];
      p.x:=xcor;
      p.y:=ycor;
      p.z:=zcor;
      end;
  'R':begin
      r1:=par[1]+PI/2;
      r2:=par[2];
      r3:=par[3];
      end;
   'V':curvaret(par[1],par[2],par[3],par[4],par[5]);
  //else PareteSemp(-10,1,-9,1,0.1,5);
  end;
end;
closefile(f3d);
*)
settaIngr;
//if tag=1 then button5.Visible:=true
//else initRec;
end;

procedure TForm1.GLSceneViewer1DblClick(Sender: TObject);
begin
 {
if panel1.Visible then
  begin
  panel1.Visible:=false;
  end
else
  begin
  panel1.Visible:=true;
  end
}
end;

procedure TForm1.CubeProgress(Sender: TObject; const deltaTime,
  newTime: Double);

Var obj:TglBasesceneobject;
begin
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
settaingr;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//CloseComunicazione();
action:=cafree;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
form1:=nil;
end;
Procedure Cancellatutto;
begin
form1.DCOggetti.DeleteChildren;
end;
procedure TForm1.RBscheletroClick(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.checked then formstyle:=fsStayOnTop
else formstyle:=fsNormal;
panel1.Visible:=false;
end;

procedure TForm1.CBLocaleChange(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.CB_RetiClick(Sender: TObject);
begin
  Display(false);
end;

procedure TForm1.CBdentroClick(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.CbAssiClick(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.CBVetriClick(Sender: TObject);
begin
Display(false);
end;



procedure TForm1.FormShow(Sender: TObject);
begin
initform;
panel1.Visible:=false;
 // CreazioneOggettoComunicazioneC();
end;

procedure TForm1.CBHmediaClick(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.Test1Change(Sender: TObject);
begin
Display(false);
end;


Type Tsalvaconf=record
                scheletro:boolean;
                Distanza,posx,posy,posz:integer;
                end;
Var  Fsalvaconf:file of Tsalvaconf;
     BSalvaconf:TSalvaconf;
const Nomesalvaconf='conf3d.cnf';
procedure TForm1.BSalvaClick(Sender: TObject);
begin
(*
with bsalvaconf do
  begin
  scheletro:=rbscheletro.Checked;
  Distanza:=trackbar1.position;
  posx:=trackbar2.position;
  posy:=trackbar4.position;
  posz:=trackbar5.position;
  end;
assignfile(Fsalvaconf,Nomesalvaconf);
rewrite(Fsalvaconf);
write(Fsalvaconf,Bsalvaconf);
Closefile(Fsalvaconf);
*)
end;

procedure TForm1.BRichiamaClick(Sender: TObject);
begin
(*
if not (fileexists(nomesalvaconf)) then exit;
assignfile(Fsalvaconf,Nomesalvaconf);
reset(Fsalvaconf);
read(Fsalvaconf,Bsalvaconf);
Closefile(Fsalvaconf);
with bsalvaconf do
  begin
  rbscheletro.Checked:=scheletro;
  trackbar1.position:=Distanza;
  trackbar2.position:=posx;
  trackbar4.position:=posy;
  trackbar5.position:=posz;
  end;
*)
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
//initform;
end;

procedure TForm1.CBNUSCITEChange(Sender: TObject);
begin
cambianuscite;
end;

procedure TForm1.cbcodpezzoChange(Sender: TObject);
begin
Cambiacodice;
end;

procedure TForm1.CborientChange(Sender: TObject);
begin
Cambiacodice;
end;

procedure TForm1.TBTurnChange(Sender: TObject);
begin
Cambiacodice;
end;

procedure TForm1.CBUscita1Change(Sender: TObject);
begin
cambianuscite;
end;

procedure TForm1.CBEntrataChange(Sender: TObject);
begin
cambianuscite;
end;
Procedure TForm1.Vis_pezzi_can(nomepr:string;ind:integer);
begin
end;
end.
