unit UProvacomp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, CatFormProj1_TLB, StdCtrls,udatalink;

type
  TFSceltaP = class(TForm)
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
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

with Fsceltap do
  begin
  CatFormX1.SetArticolo (gruppo,art);
  CatFormX1.Show;
  end;

end;

Function OnInitDialog(tp,ts,dpx,dpy:integer):boolean;
var ws:widestring;
begin

with Fsceltap do
  Case tp of
  1: {   QF}
    begin
    showArt('gruppo1','art1_1');
    CatFormX1.SetValore('xxx','200');
    if dpx=600 then CatFormX1.SetValore('dim1_1','2')
    else
      begin
      if dpy=600 then CatFormX1.SetValore('dim1_1','0')
      else CatFormX1.SetValore('dim1_1','1');
      end;
    end;
  2:{ QM  }
    begin
    ShowArt('gruppo1','art1_2');
    Str(ts-3:0,ws);
    CatFormX1.SetValore('sc1_2',ws);
    end;
  3:{  Fly}
    begin
    ShowArt('gruppo2','art2');
    Str(dpx:0,Ws);
    CatFormX1.SetValore('h2',ws);
    Str(dpy:0,Ws);
    CatFormX1.SetValore('l2',ws);
    Str(ts-3:0,ws);
    CatFormX1.SetValore('sc2',ws);
    end;
  4:{ alfa-parallel  }
    begin
    ShowArt('gruppo3','art3_1');
    Str(dpx:0,ws);
    CatFormX1.SetValore('h3_1',ws);
    Str(dpy:0,ws);
    CatFormX1.SetValore('l3_1',ws);
    Str(ts-3:0,ws);
    CatFormX1.SetValore('sc3_1',ws);
    end;
  5:{ alfa-cross  }
    begin
    ShowArt('gruppo3','art3_2');
    Str(dpx:0,ws);
    CatFormX1.SetValore('h3_2',ws);
    Str(dpy:0,ws);
    CatFormX1.SetValore('l3_2',ws);
    Str(ts-3:0,ws);
    CatFormX1.SetValore('sc3_2',ws);
    end;
  6:{ doghe  }
    begin
    ShowArt('gruppo4','art4');
    Str(dpy:0,ws);
    CatFormX1.SetValore('l4',ws);
    Str(ts-3:0,ws);
    CatFormX1.SetValore('sc4',ws);
    end;
  7:{  GKM }
    ShowArt('gruppo5','art5_1');
  8:{ GP  }
    ShowArt('gruppo5','art5_2');
  end;
Fsceltap.CatFormX1.Refr;
{ return TRUE unless you set the focus to a control
  EXCEPTION: OCX Property Pages should return FALSE }
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
ts:=0;
with Fsceltap do
  begin
  art1:=CatFormX1.GetArticolo;
  {int vi;}
  art:=ns(art1);
  CatFormX1.Uscita;
  if art='art1_1' then
    begin
    tp:=1;
    vi:=atof(CatFormX1.GetValore ('dim1_1'));
    if (vi<2) then dpx:=300
    else dpx:=600;
    if vi=1 then dpy:=1200
    else dpy:=600;
    end;
  if art='art1_2' then
    begin
    tp:=2;
    vi:=atof(CatFormX1.GetValore('dim1_2'));
    if vi=0 then
      begin
      dpx:=300;
      dpy:=1200;
      end
    else
      begin
      dpx:=600;
      dpy:=600;
      ts:=atof(CatFormX1.GetValore('sc1_2'))+3;
      end;
    end;
  if art='art2' then
    begin
    tp:=3;
    dpx:=atof(CatFormX1.GetValore('h2'));
    dpy:=atof(CatFormX1.GetValore('l2'));
    ts:=atof(CatFormX1.GetValore('sc2'))+3;
    end;
  if art='art3_1' then
    begin
    tp:=4;
    dpx:=atof(CatFormX1.GetValore('h3_1'));
    dpy:=atof(CatFormX1.GetValore('l3_1'));
    ts:=atof(CatFormX1.GetValore('sc3_1'))+3;
    end;
  if art='art3_2' then
    begin
    tp:=5;
    dpx:=atof(CatFormX1.GetValore('h3_2'));
    dpy:=atof(CatFormX1.GetValore('l3_2'));
    ts:=atof(CatFormX1.GetValore('sc3_2'))+3;
    end;
  if art='art4' then
    begin
    tp:=6;
    dpx:=200;
    dpy:=atof(CatFormX1.GetValore('l4'));
    ts:=atof(CatFormX1.GetValore('sc4'))+3;
    end;
  if art='art5_1' then tp:=7;
  if art='art5_2' then tp:=8;
  end;
end;

procedure TFSceltaP.FormActivate(Sender: TObject);
begin
CatFormX1.Show;
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
