unit URunComp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, DBCGrids, Spin, ExtCtrls;

type
  TFRunComp = class(TForm)
    DBCtrlGrid1: TDBCtrlGrid;
    DBCtrlGrid2: TDBCtrlGrid;
    Button1: TButton;
    Button2: TButton;
    DBImage1: TDBImage;
    DBMemo1: TDBMemo;
    Button3: TButton;
    pp1: TPanel;
    Ppl: TPanel;
    Pph: TPanel;
    Spl: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Sph: TSpinEdit;
    Comb1: TPanel;
    CB1: TComboBox;
    Label3: TLabel;
    CB2: TComboBox;
    Label4: TLabel;
    DBText1: TDBText;
    CB3: TComboBox;
    L3: TLabel;
    L4: TLabel;
    CB4: TComboBox;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBCtrlGrid1DblClick(Sender: TObject);
    procedure DBImage1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRunComp: TFRunComp;
  dimunite:boolean;
Procedure Scegli(progd:string;Var LHp,LLp,LTP,LTs:Integer;Var LDescr:string);

implementation

uses Ucompsel;
Var Hp,Lp,TP,Ts:Integer;Descr:string ;


{$R *.DFM}

procedure TFRunComp.FormActivate(Sender: TObject);
begin
Fprogcomp.tt1.filter:='gruppo=''BASE''';
Fprogcomp.tt1.filtered:=true;
end;

procedure TFRunComp.Button1Click(Sender: TObject);

Procedure separaaperb(st:string;Var a,b:integer);
Var i,err:integer;
begin
i:=1;
while (i < length(st))and(upcase(st[i])<>'X') do
inc(i);
val(copy(st,1,i-1),a,err);
val(copy(st,i+1,length(st)-i),b,err);
end;
begin
Descr:=Fprogcomp.tt1descrizione.Value;
TP:=Fprogcomp.tt1TP.Value;
with fruncomp do
if comb1.visible then
  begin
  separaaperb(cb1.text,Hp,Lp);
  {if cb2.visible then tp:=cb2.ItemIndex
  else tp:=0;}
  if cb3.visible then
     begin
     if cb3.ItemIndex=0 then ts:=3
     else ts:=4;
     end
  else ts:=0;
  end;
if pp1.Visible then
  begin
  Lp:=spl.value;
  Hp:=spH.value;
  if cb4.visible then
     begin
     if cb4.ItemIndex=0 then ts:=3
     else ts:=4;
     end
  else ts:=0;
  end;
{Hp:=Fprogcomp.tt1descrizione.Value;
Lp:=Fprogcomp.tt1descrizione.Value;
Tp:=Fprogcomp.tt1descrizione.Value;
Ts:=Fprogcomp.tt1descrizione.Value;}
Fprogcomp.tt1.filtered:=false;
Fprogcomp.table1.filtered:=false;
Fruncomp.close;
runsel:=false;
end;

procedure TFRunComp.DBCtrlGrid1DblClick(Sender: TObject);
begin
If Fprogcomp.Tt1Figlio.value<>'' then
  begin
  Fprogcomp.tt1.filter:='Gruppo='''+Fprogcomp.Tt1Figlio.value+'''';
  end;
end;

procedure TFRunComp.DBImage1Click(Sender: TObject);
begin
 If Fprogcomp.Tt1Figlio.value<>'' then
  begin
  Fprogcomp.tt1.filter:='Gruppo='''+Fprogcomp.Tt1Figlio.value+'''';
  end;
end;

procedure TFRunComp.Button3Click(Sender: TObject);
begin
If Fprogcomp.Tt1Padre.value<>'' then
  begin
  Fprogcomp.tt1.filter:='Gruppo='''+Fprogcomp.Tt1Padre.value+'''';
  end;
end;
Procedure Scegli(progd:string;Var LHp,LLp,LTP,LTs:Integer;Var LDescr:string);
begin
Fprogcomp.tt1.filtered:=true;
Fprogcomp.table1.filtered:=true;
Hp:=0;
LP:=0;
Tp:=0;
Ts:=0;
Descr:='';
runsel:=true;
with Fprogcomp do
  begin
  table1.close;
  table1.Databasename:=progd;
  table1.open;
  tt1.close;
  tt1.Databasename:=progd;
  tt1.open;
  end;
Fruncomp.Showmodal;
LHp:=Hp;
LLP:=Lp;
LTp:=TP;
LTs:=Ts;
LDescr:=Descr;
end;

end.
