unit Diagramma;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,
  Psicrometrico, StdCtrls;

Type Tpuntosc=record xsc,ysc:integer end;
type
  TFDiagramma = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Image1: TImage;
    Button1: TButton;
    procedure FormResize(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    private
    { Private declarations }
  public
  Procedure init(Hmare:real);
  Function DrawP(T,US:real):Tpuntosc;
  procedure line(T1,us1,t2,us2:real);
  Procedure Testo(T,US:Real;Testo:string);
  Procedure Pallino(T,US:Real;Colore:Tcolor);

    { Public declarations }
  end;

  procedure puntodiagramma(PTbs,PUr:real);
  procedure DisegnaTrattamenti;
  Function CalcUSgkg(T,UR:real):REAL;

var
  FDiagramma: TFDiagramma;

Const maxtrat=10;
type Ttratt=array[1..maxtrat]of record
                                 Descrizione:string[80];
                                 Tbs,Ur,US:real;
                                 usaUr:boolean;
                                 colore:Tcolor;
                                 end;
Var trattamenti:Ttratt;
    Ntrat:integer;
    Altezzaslm:real;
    PercorsoBMP:string;
implementation
{$R *.dfm}
var l,h,xori,yori:Integer;

Function CalcUSgkg(T,UR:real):REAL;
begin
result:=CalcUS(T,UR)*1000;
if result>34 then result:=34;
end;

Procedure DisCerchio(x1,y1,R:real);
begin
if r<0 then r:=-R;
FDiagramma.image1.Canvas.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1-r),round(y1-r),round(x1-r),round(y1-r));
end;

Procedure TFDiagramma.init(Hmare:real);
var i,j:integer;
    Tcor,Ucor:integer;
    ss,ss2:string;
begin
yori:=round(panel2.Height-panel2.Height*0.1);
xori:=round(panel2.Width*0.1);
l:=round(panel2.Width*0.8);
h:=round(panel2.Height*0.8);
image1.Canvas.Brush.Color:=clwhite;
image1.Canvas.pen.Color:=clwhite;
image1.Canvas.Rectangle(0,0,2000,1000);
image1.Canvas.pen.Color:=clblack;
line(-15,0,50,0);
line(50,0,50,34);
Testo(-15,-1,'Tbs['+{#248+}'C]');
Testo(50,35,'US['+{#248+}'g/kg]');
Testo(26,26.6,'UR[%]');
DetPATM(Hmare);
str(Hmare:1:0,ss);
image1.Canvas.TextOut(20,20,'Quota : metri '+ss+' sul livello del mare.');
line(-15,0,-15,CalcUsgkg(-15,100));
for i:=1 to 13  do
  begin
  Tcor:=-15+i*5;
  image1.Canvas.pen.Color:=clgray;
  if i<=8 then
  for j:=1 to 10 do
  line(Tcor-5,CalcUsgkg(Tcor-5,j*10),Tcor,CalcUsgkg(Tcor,j*10));
  image1.Canvas.pen.Color:=clblack;
  //line(Tcor-5,CalcUsgkg(Tcor-5,100),Tcor,CalcUsgkg(Tcor,100));
  line(Tcor,0,Tcor,CalcUsgkg(Tcor,100));
  testo(Tcor,-1,inttostr(Tcor));
  end;
for i:=1 to 17  do
  begin
  Ucor:=i*2;
  image1.Canvas.pen.Color:=clgray;
  for j:=1 to 10 do
  if  CalcTbs((Ucor-2)/1000,j*10)>25 then
  line(CalcTbs((Ucor-2)/1000,j*10),Ucor-2,CalcTbs(Ucor/1000,j*10),Ucor);

  image1.Canvas.pen.Color:=clblack;

  line(50,Ucor,CalcTbs(Ucor/1000,100),Ucor);
  Testo(51,ucor,inttostr(Ucor));
  end;

For i:=1 to 10 do
Testo(30.1,CalcUsgkg(30,I*10),inttostr(i*10));

for i:=1 to Ntrat do
with trattamenti[i] do
  begin
  if Us<0 then
  Us:=CalcUsgkg(tbs,Ur);

  str(Tbs:2:1,ss);
  ss:=ss+' [C] , ';
  if not usaur then
    begin
    str(US:2:1,ss2);
    ss2:=ss2+' [g/kg]';
    end
  else
    begin
    str(UR:2:1,ss2);
    ss2:=ss2+' [%]';
    end ;
  image1.Canvas.TextOut(110,20+i*20,Descrizione+'  '+ss+ss2+'  ');

  pallino(Tbs,Us,colore);
  image1.Canvas.pen.Color:=colore;
  image1.Canvas.pen.Width:=3;
  if descrizione<>'' then
    begin
    image1.Canvas.MoveTo(20,25+i*20);
    if i>1 then
    image1.Canvas.LineTo(100,25+i*20)
    else discerchio(100,25+i*20,3);
    end;
  if i>1 then
  line(trattamenti[i-1].tbs,trattamenti[i-1].Us,tbs,US);
  end;
image1.Canvas.pen.Width:=1;
image1.Canvas.pen.Color:=clblack;
image1.Picture.SaveToFile(percorsobmp+'\diagramma.bmp');
end;

Function TFDiagramma.DrawP(T,US:real):Tpuntosc;
begin
result.xsc:=round(Xori+(T+15)*l/65);
result.Ysc:=round(yori-Us*h/34);
end;

Procedure TFDiagramma.Pallino(T,US:Real;Colore:Tcolor);
Var pp:Tpuntosc;
const    dd=3;
begin
image1.Canvas.Pen.Color:=colore;
image1.Canvas.Pen.Width:=6;
pp:=Drawp(t,us);
with pp do
DisCerchio(Xsc,Ysc,dd);
image1.Canvas.Pen.Width:=1;
end;

Procedure TFDiagramma.Testo(T,US:Real;Testo:string);
Var pp:Tpuntosc;
begin
pp:=Drawp(t,us);
image1.Canvas.TextOut(pp.xsc,pp.ysc,testo);
end;
procedure TFDiagramma.line(T1,us1,t2,us2:real);
Var pp:Tpuntosc;
begin
pp:=Drawp(t1,us1);
image1.Canvas.MoveTo(pp.xsc,pp.ysc);
pp:=Drawp(t2,us2);
image1.Canvas.LineTo(pp.xsc,pp.ysc);
end;
procedure TFDiagramma.FormResize(Sender: TObject);
begin
Init(altezzaslm);
end;

procedure puntodiagramma(PTbs,PUr:real);
begin
Fdiagramma:=TFDiagramma.create(nil);
Ntrat:=1;
with trattamenti[1]do
  begin
  tbs:=Ptbs;
  Ur:=PUr;
  Colore:=clred;
  end;
FDiagramma.init(0);
Fdiagramma.ShowModal;
end;

procedure DisegnaTrattamenti;
begin
Fdiagramma:=TFDiagramma.create(nil);
FDiagramma.init(altezzaslm);
Fdiagramma.ShowModal;
end;

procedure TFDiagramma.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFDiagramma.FormDestroy(Sender: TObject);
begin
 Fdiagramma:=nil;
end;

procedure TFDiagramma.Button1Click(Sender: TObject);
begin
Close;
end;

end.
