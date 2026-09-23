unit U3dsdridotto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLWin32Viewer, GLScene, GLObjects, GLMisc, Grids, DBGrids,
  StdCtrls, DBCtrls, Mask, Spin, LbButton, ComCtrls,variabili3d,uoggetti,disedificio,
  libreriagenerale,chiamateoggetti;

type
  TForm1rid = class(TForm)
    GLScene1: TGLScene;
    DCGlobale: TDummyCube;
    DCGenerale: TDummyCube;
    DCVista: TDummyCube;
    Cube1: TCube;
    DCOggetti: TDummyCube;
    DCLuci: TDummyCube;
    Sphere1: TSphere;
    Disk1: TDisk;
    Cylinder1: TCylinder;
    DcParticles: TDummyCube;
    Cube2: TCube;
    GLCamera1: TGLCamera;
    GLLightSource1: TGLLightSource;
    GLSceneViewer1: TGLSceneViewer;
    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
  Procedure Display(ac:boolean);
    { Public declarations }
  end;

var
  Form1rid: TForm1rid;
  weel:real;
Procedure Trackchange;
Procedure Cancellatutto;

implementation

{$R *.dfm}
Var
MX,My:integer;


Procedure Trackchange;
Var ingra:real;
begin
{
ingra:=(form1.trackbar1.position)/40*2*ingrbase;
Form1.DCGenerale.Scale.X:=ingra;
Form1.DCGenerale.Scale.y:=ingra;
Form1.DCGenerale.Scale.z:=ingra;
}
end;

procedure TForm1rid.GLSceneViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
{
if ssright in Shift then
  begin
  cbassi.Checked:=not cbassi.Checked;
  if cbassi.Checked then
  rbscheletro.checked:=true
  else
    begin
    rbscheletro.checked:=false;
    sbnpezzo.Value := pezzosel;
    end;
  end;
 Mx:=x;
 My:=y;
}
end;
procedure TForm1rid.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
(*
if ssLeft in Shift then
  begin
// if rbvista.Checked then
    begin
     GLCamera1.MoveAroundTarget(my-y, mx-x);
    end;
   mx:=x;
   my:=y;

// DCLuci.MoveAroundTarget(my-y, mx-x);

  end
else
if cbassi.Checked then
  begin
  trackbar2.position:=round(50+(x-GLSceneViewer1.Width/2)*100/GLSceneViewer1.Width);
  trackbar5.position:=round(50-(y-GLSceneViewer1.height/2)*100/GLSceneViewer1.height);
  { TODO -oDiego -cNavigazione : lavoro quì }
  end;
//if Shift<>[] then GLCamera1.MoveAroundTarget((mx-x)/100,(my-y)/100);
{str(rollangle:4:0,lra.Caption);
lra.caption:='Roll:'+lra.caption;}
*)
end;

Procedure TForm1rid.Display(ac:boolean);
begin
(*eliminato prov
cancellatutto;
//GLCamera1.MoveAroundTarget(-30,-30);
InitVariabili;
//panel1.Visible:=false;
Disegnaedificio(percorsoDrive,ac);
sbnpezzo.MaxValue:=Nogg;
sbnpezzo.MinValue:=1;
*)
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
//aggiornasecondario;
ult_cubo:=nil;
//if tag=1 then button5.Visible:=true
//else initRec;
end;
Procedure Cancellatutto;
begin
//form1.DCOggetti.DeleteChildren;
end;

procedure TForm1rid.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

end.
