unit Progress3d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,libreriagenerale;

type
  TForm2 = class(TForm)
    ProgressBar1: TProgressBar;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Var Num_vers:string='???';
    mododebug:boolean=false;

var
  Form2: TForm2=Nil;
Procedure progress_3d(POs:integer;Fase:String);
Procedure Libera_progress_3d;
function step_prog(prog,max:integer):integer;
implementation

{$R *.dfm}
function step_prog(prog,max:integer):integer;
begin
result:=round((prog-1)/max*100);
end;
Procedure Libera_progress_3d;
begin
form2.Free;
end;
Procedure progress_3d(POs:integer;Fase:String);
Var datacor:string;
begin
fase:=fase+'                                    ';
{$I Data}
if mododebug then
  begin
  if pos=-1 then fase:='Fine procedura '+fase;
  if pos=-2 then fase:='Inizio procedura '+fase;
  showmessage(fase);
  exit;
  end;
if Form2=nil then
  begin
  Form2:=Tform2.Create(nil);
  Form2.label2.caption:='ProjectBrowser3D '+num_vers+' db:'+datacor;
  if versione_trial then
  Form2.label2.caption:=Form2.label2.caption+' Trial';
  if versione_trial_pannelli then
  Form2.label2.caption:=Form2.label2.caption+' Trial_pannelli';
  {$Ifdef dllbm}
  //form2.FormStyle:=fsnormal;
  {$endif}
  end;
if pos=-2 then
  begin
  pos:=0;
  Form2.Show;
  end;
if pos=-1 then
  begin
  form2.Hide;
  //Form2.Close;
  end
else
  begin
  Form2.label1.Caption:=Fase;
  Form2.label1.Refresh;
  Form2.label2.Refresh;
  Form2.Progressbar1.position:=Pos;
  end;
end;
end.
