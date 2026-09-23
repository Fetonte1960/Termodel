unit UProvacomp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, CatFormProj1_TLB, StdCtrls,udatalink;

type
  TFSceltaP = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure CatFormX1Show(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSceltaP: TFSceltaP;

implementation

uses UDB,Ucalcoli;

{$R *.DFM}

Procedure showArt(gruppo,art:string);
begin
end;

Function OnInitDialog(tp,ts,dpx,dpy:integer):boolean;
var ws:widestring;
begin
end;


Function atof(ss:string):integer;
Var code:integer;
begin
Val(ss,result,code);
end;

function ns(ws:widestring):string;
var i:integer;
begin
result:='';
for i:=1 to length(ws) do
if ws[i]<>#0 then result:=result+ws[i];
end;
Procedure OnOK(var dpx,dpy,ts,tp:integer;art:string);
var vi:integer;
    art1:widestring;
begin
end;

procedure TFSceltaP.Button1Click(Sender: TObject);
var dpx,dpy,Lts,Ltp:integer;art:string;
begin
OnOK(dpx,dpy,Lts,Ltp,art);
dm1.tt1.edit;
with v_amb do
  begin
  set_ts(Lts);
  set_tp(Ltp);
  set_Lq1(dpx);
  set_Hq1(dpy);
  set_Descrp(tipoPan(ltp));
  end;
dm1.tt1.Post;
FsceltaP.hide;
end;

procedure TFSceltaP.CatFormX1Show(Sender: TObject);
begin
{with V_amb do
if( tp<>0 )and (ts<> 0) and (lq1<>0) and(hq1<>0) then
OnInitDialog(tp,ts,round(Lq1),round(Hq1));}
end;

end.
