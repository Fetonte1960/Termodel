unit Secondario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLWin32Viewer,u3dsd,config_var, StdCtrls, ExtCtrls;

type
  TFSecondario = class(TForm)
    GLSceneViewer1: TGLSceneViewer;
    GBsetting: TGroupBox;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    RbNulla: TRadioButton;
    RBTutto: TRadioButton;
    RBPiano: TRadioButton;
    RBLoc: TRadioButton;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure GLSceneViewer1DblClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure RbNullaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSecondario: TFSecondario=nil;

Procedure aggiornasecondario;
Procedure Chiudisecondario;
Function Attivosecondario:boolean;

implementation
Var chiusuralocale:boolean=true;
{$R *.dfm}
Function Attivosecondario:boolean;
begin
result:=fsecondario<>nil
end;
Procedure Chiudisecondario;
begin
chiusuralocale:=false;
if fsecondario<>nil then FSecondario.Close;
chiusuralocale:=true;
//form1.SetFocus;
end;
Procedure aggiornasecondario;
begin
if leggi_var('SECONDARIO')<>'TRUE' then exit;
if FSecondario=nil then
FSecondario:=Tfsecondario.Create(nil);
FSecondario.Show;
end;

procedure TFSecondario.FormCreate(Sender: TObject);
Var tmp:string;
begin
form1.GLSceneViewer1.enabled:=false;
form1.GLSceneViewer1.visible:=false;
GLSceneViewer1.Camera:=form1.GLCamera1;
tmp:=Leggi_var('POSTOP3D');
if tmp<>'' then top:=strtoint(tmp);
tmp:=Leggi_var('POSLeft3D');
if tmp<>'' then Left:=strtoint(tmp);
tmp:=Leggi_var('POSWidth3D');
if tmp<>'' then Width:=strtoint(tmp);
tmp:=Leggi_var('POSHeight3D');
if tmp<>'' then Height:=strtoint(tmp);
end;

procedure TFSecondario.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if chiusuralocale then
  begin
  salva_var('SECONDARIO','FALSE');
  form1.GLSceneViewer1.enabled:=true;
  form1.GLSceneViewer1.visible:=true;
  end
else
  begin
  Salva_var('POSTOP3D',inttostr(top));
  Salva_var('POSLeft3D',inttostr(Left));
  Salva_var('POSWidth3D',inttostr(Width));
  Salva_var('POSHeight3D',inttostr(Height));
  end;
action:=cafree;
FSecondario:=nil;
end;

procedure TFSecondario.GLSceneViewer1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
form1.GLSceneViewer1MouseDown(sender,button,shift,x,y);
end;

procedure TFSecondario.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
form1.GLSceneViewer1MouseMove(Sender,Shift,X, Y);
end;

procedure TFSecondario.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
with form1 do
  begin
  if cbassi.Checked then
    begin
    FSecondario.glsceneviewer1.SetFocus;
    weel:=weel-10;
    trackbar4.Position:=round(weel);
    end
  else trackbar1.Position:=trackbar1.Position-1;
  end;
end;

procedure TFSecondario.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
with form1 do
  begin
  if cbassi.Checked then
    begin
    FSecondario.glsceneviewer1.SetFocus;
    weel:=weel+10;
    trackbar4.Position:=round(weel);
    end
  else trackbar1.Position:=trackbar1.Position+1;
  end;
end;

Procedure aggiornaconf;
begin
with Fsecondario do
  begin
  form1.RBscheletro.checked:=false;
  form1.cbfiltroloc.checked:=false;
  form1.CbPiano.Clear;
  if rbtutto.Checked then  form1.RBscheletro.checked:=true
  else
  if  rbPiano.Checked then  form1.cbpiano.text:=''
  else
  if  rbloc.Checked then  form1.cbfiltroloc.checked:=true;
  end;
form1.display(true);
end;
procedure TFSecondario.GLSceneViewer1DblClick(Sender: TObject);
begin
with gbsetting do
  begin
  if form1.RBscheletro.checked then  rbtutto.Checked:=true
  else
  if form1.cbpiano.text<>'' then  rbPiano.Checked:=true
  else
  if form1.cbfiltroloc.checked then  rbloc.Checked:=true
  else rbnulla.Checked:=true;
  gbsetting.top:=round(Fsecondario.Height/2)-round(gbsetting.Height/2);
  gbsetting.Left:=round(Fsecondario.Width/2)-round(gbsetting.Width/2);
  gbsetting.visible:=true;
  end;
end;

procedure TFSecondario.Button1Click(Sender: TObject);
begin
with gbsetting do
  begin
  gbsetting.visible:=false;
  aggiornaconf;
  end;
end;

procedure TFSecondario.RbNullaClick(Sender: TObject);
begin
Aggiornaconf;
end;

end.
