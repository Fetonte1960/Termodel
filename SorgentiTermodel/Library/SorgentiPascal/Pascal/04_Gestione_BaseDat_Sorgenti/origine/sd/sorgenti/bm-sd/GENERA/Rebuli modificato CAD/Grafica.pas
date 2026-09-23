unit Grafica;
interface
uses graphics,Windows,extctrls,Udb,dbtables,UDataLink,disegnoinscala,sysutils,udati,math;

Procedure Redraw(Var BR:boolean;Canv:Tcanvas;Var Dis:TImage;panel:Tpanel;Var Totlamp:integer);
Procedure linea(x1,y1,x2,y2:real);
function Yreal(y:real):real;
function Xreal(x:real):real;
function XGraf(X:real):Integer;
function YGraf(y:real):Integer;
Procedure CancellaLinea(cnv:Tcanvas;x,y:real);
Procedure DisegnaBlocco(cnv:Tcanvas;x,y:real;txt:string);


Procedure InitGrafica;
Const MaxFig=3000;
Var NFig:integer;
    Xprec,Yprec:real;
    ColCor,brushcor:Tcolor;
    TlineaCor:TPenStyle;
    SpesCor,Altcor:Integer;
Type RecFig=record
            tipo:char;
            x1,y1,x2,y2,r:real;
            Colore:Tcolor;
            TLinea:TPenStyle;
            Spes:Integer;
            brush:Tcolor;
            Testo:string[30];
            end;
     ArFig=Array [1..Maxfig]of recfig;
Var  D_Fig:^arFig;
     Buf:Array[1..100]of Tpoint;
     NBuf:Integer;
     ing,spoX,spoY:real;
     ingfisso:boolean;
implementation
uses Uinterattiva;

Procedure SetAttrib;
begin
with D_fig^[NFig] do
  begin
  Colore:=colcor;
  TLinea:=Tlineacor;
  Spes:=spescor;
  brush:=brushcor;
  end;
end;

Procedure inc1(ind:integer);
begin
inc(Nfig);
with D_fig^[NFig] do
  begin
  x1:=0;
  y1:=0;
  x2:=0;
  y2:=0;
  end;
end;

Procedure Dtesto(x,y:real;tst:string);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='T';
  x1:=X;
  Y1:=Y;
  X2:=0;
  Y2:=0;
  XPrec:=X1;
  YPrec:=Y1;
  setattrib;
  spes:=altcor;
  Testo:=tst;
  end;
end;
{ presa da carichi\funzionigrafiche1 }
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

{ presa da carichi\funzionigrafiche7  modificate}
 {***************************  UG              *******************************}

Function UG(A,B:Real;Tipo:integer):Boolean;

{-- 1=Angoli 2=Distanze 3=equazioni retta--}

Const Apr:Array[1..3]of real =(0.1,{10}0.0001,7);{ modifica }

begin
if Abs(A-B)<Apr[Tipo] then UG:=True else UG:=False;
end;
 {*-*-*-*-*-*-*-*-*-*-*-*-*-*  Calc_D       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Calc_D(X1,Y1,Z1,X2,Y2,Z2:real;Var Dir,DirZ:real);

var dist:real;

begin
if ug(y2,y1,2) then
  begin
  if x2>=x1 then Dir:=pi/2 else Dir:=(3/2)*pi;
  end
else
  begin
  if y2>y1 then
    begin
    Dir:=arctan((x2-x1)/abs(y2-y1));
    end
  else
    Dir:=pi-arctan((x2-x1)/abs(y2-y1));
  end;

if Dir<-0.01 then Dir:=2*pi+Dir;
if Dir+0.01>=2*PI then Dir:=Dir-2*pi;

if Z1=Z2 then
DirZ:=0
else
  begin
  dist:=sqrt(sqr(x2-x1)+sqr(y2-y1)+sqr(z2-z1));
  dirz:=arcsin((z2-z1)/dist);
  end;

if Ug(abs(dirz),Pi/2,1) then Dir:=0;
end;

{ presa da carichi\funzionigrafiche1  mofificata}
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  inters        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

 procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4:real);
var  m1,m2,c1,c2,max1,max2,min1,min2:real;
const apr=0;
begin

if ( (abs(x1-x3)<= apr) and (abs(y1-y3)<= apr) )or
   ( (abs(x1-x4)<= apr) and (abs(y1-y4)<= apr) )or
   ( (abs(x2-x3)<= apr) and (abs(y2-y3)<= apr) )or
   ( (abs(x2-x4)<= apr) and (abs(y2-y4)<= apr) ) then
   begin
   res:=0;
   exit
   end;
if x2>=x1 then
  begin
  max1:=x2;
  min1:=x1;
  end
else
  begin
  max1:=x1;
  min1:=x2;
  end;
if x4>=x3 then
  begin
  max2:=x4;
  min2:=x3;
  end
else
  begin
  max2:=x3;
  min2:=x4;
  end;

if ((max1-min2)>= -apr) and ((max2-min1)>= -apr) then
  begin
  if y2>=y1 then
    begin
    max1:=y2;
    min1:=y1;
    end
  else
    begin
    max1:=y1;
    min1:=y2;
    end;
  if y4>=y3 then
    begin
    max2:=y4;
    min2:=y3;
    end
  else
    begin
    max2:=y3;
    min2:=y4;
    end;
   if ((max1-min2)>= -apr)and ((max2-min1)>= -apr) then
    begin
    if abs(x2-x1)>10E-6 then m1:=(y2-y1)/(x2-x1)
    else m1:=10E30;
    if abs(x4-x3)>10E-6 then m2:=(y4-y3)/(x4-x3)
    else m2:=10E30;
    if abs(m2-m1)>10E-6 then
      begin

      c1:=y1-m1*x1;
      c2:=y3-m2*x3;
      x:=(c2-c1)/(m1-m2);
      if m1>=10E3 then y:=m2*X+c2 {  modifica  y:=m1*x+c1; }
      else y:=m1*x+c1;


      if ((x-x1>=-apr)or(x-x2>=-apr))and { verifica se il punto e' interno ai segmenti }
         ((x-x1<=+apr)or(x-x2<=+apr))and
         ((y-y1>=-apr)or(y-y2>=-apr))and
         ((y-y1<=+apr)or(y-y2<=+apr))and
         ((x-x3>=-apr)or(x-x4>=-apr))and
         ((x-x3<=+apr)or(x-x4<=+apr))and
         ((y-y3>=-apr)or(y-y4>=-apr))and
         ((y-y3<=+apr)or(y-y4<=+apr)) then res:=1

      else  res:=0;
      end
    else res:=0;
    end
  else res:=0;
  end
else res:=0;
end;

Function trovalinea(Var x,y:real):integer;
Var i,res:integer;
    lb,xpp,ypp:real;
begin
lb:=5/(ing/15);
result:=0;
for i:=1 to Nfig do
with D_fig^[i] do
  case tipo of
  'L':begin
      inters(xpp,ypp,res,x1,x2,x-lb,x+lb,y1,y2,y-lb,y+lb);
      if res=0 then
      inters(xpp,ypp,res,x1,x2,x+lb,x-lb,y1,y2,y-lb,y+lb);
      if res=1 then
        begin
        x:=xpp;
        y:=ypp;
        result:=i;
        exit;
        end;
      end;
  end;
end;

Procedure CancellaLinea(cnv:Tcanvas;x,y:real);
var ind:integer;
begin
ind:=trovalinea(x,y);
if ind<>0 then
with D_fig^[ind] do
  begin
  tipo:=' ';
  Modicord1(X1,y1,spox,spoy,0,ing);
  Modicord1(X2,y2,spox,spoy,0,ing);
  cnv.Pen.Color:=Clwhite;
  cnv.Pen.Style:=TLinea;
  cnv.Pen.Width:=spes;
  cnv.Moveto(Round(x1),Round(y1));
  cnv.Lineto(Round(x2),Round(y2));
  end;
end;


Procedure Blocco(cnv:Tcanvas;x,y,rr:real;Testo:string);
Var xx,yy:integer;
Procedure MCord(xmc,ymc:real);
begin
modicord1(xmc,ymc,x,y,rr,1);
xx:=round(xmc);
yy:=round(ymc);
end;
begin
if testo='FIN' then
  begin
  with cnv do
    begin
    MCord(-20,-5);
    moveto(xx,yy);
    MCord(20,-5);
    Lineto(xx,yy);
    MCord(-20,5);
    moveto(xx,yy);
    MCord(20,5);
    Lineto(xx,yy);
    end;
  exit;
  end;
if copy(testo,1,3)='AMB' then
  begin
  with cnv do
    begin
    Mcord(0,0);
    TextOut(XX,YY,Testo);
    end;
  exit;
  end;
end;


Procedure DisegnaBlocco(cnv:Tcanvas;x,y:real;txt:string);
var ind:integer;
    Dir,DirZ:real ;
begin
ind:=trovalinea(x,y);
if ind<>0 then
  begin
  Dtesto(x,y,txt);
  with d_Fig^[ind] do
    begin
    Calc_D(X1,Y1,0,X2,Y2,0,Dir,DirZ);
    end;
  with d_Fig^[Nfig] do
    begin
    x2:=Dir+pi/2;
    tipo:='B';
    end;
  {blocco(cnv,x,y,dir,txt);}
  end;
end;

function XGraf(X:real):Integer;
begin
result:=round(X*ing+spoX);
end;

function YGraf(y:real):Integer;
begin
result:=round(y*ing+spoy);
end;

function Xreal(x:real):real;
begin
result:=(x-spox)/ing;
end;

function Yreal(y:real):real;
begin
result:=(y-spoy)/ing;
end;

Procedure InitGrafica;
begin
New(d_fig);
NFig:=0;
end;



Procedure lineaRel(px2,py2:real);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='L';
  x1:=Xprec;
  Y1:=Yprec;
  X2:=px2;
  Y2:=Py2;
  XPrec:=pX2;
  YPrec:=Py2;
  setattrib;
  end;
end;




Procedure linea(x1,y1,x2,y2:real);
begin
xPrec:=x1;
yPrec:=Y1;
LineaRel(x2,y2);
end;

Procedure Forma(x,y:Real);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='F';
  x1:=x;
  Y1:=y;
  end;
XPrec:=X;
YPrec:=Y;
end;
Procedure EndForma;
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='E';
  setattrib;
  end;
end;

Procedure Cerchio(x,y,pr:real);
begin
inc1(Nfig);
with D_fig^[NFig] do
  begin
  Tipo:='C';
  X1:=x;
  Y1:=y;
  r:=Pr;
  setattrib;
  end;
end;


Procedure Disegna(Cnv:Tcanvas;spx,spy,ing,rot:real);
Var i:integer;
    Poly:boolean;
    BufRec:recfig;



Function FTipo(Tipo:char):char;
begin
If (POly)and(Tipo='L') then Tipo:='O';
Result:=Tipo;
end;
begin
POly:=False;
For i:=1 to Nfig do
begin
  BufRec:=D_fig^[13];
  BufRec:=D_fig^[i];
  with Bufrec do
  begin
  Modicord1(X1,y1,spx,spy,rot,ing);
  if tipo<>'B' then  Modicord1(X2,y2,spx,spy,rot,ing);
    case Ftipo(Tipo) of

    'L':begin
        cnv.Pen.Color:=Colore;
        cnv.Pen.Style:=TLinea;
        cnv.Pen.Width:=spes;
        cnv.Moveto(Round(x1),Round(y1));
        cnv.Lineto(Round(x2),Round(y2));
        end;
    'T':begin
        cnv.Pen.Color:=Colore;
        cnv.brush.Color:=brush;
        cnv.Pen.Style:=TLinea;
        cnv.font.height:=spes;
        cnv.TextOut(round(X1),round(Y1),Testo);
        end;
    'B':begin
        cnv.Pen.Color:=Colore;
        cnv.brush.Color:=brush;
        cnv.Pen.Style:=TLinea;
        cnv.font.height:=spes;
        blocco(cnv,round(X1),round(Y1),x2,Testo);
        end;
    'C':begin
        cnv.Pen.Color:=Colore;
        cnv.Pen.Style:=TLinea;
        cnv.Pen.Width:=spes;
        cnv.Arc(round(x1-r),round(y1-r),round(x1+r),round(y1+r),round(x1-r),round(y1-r),round(x1-r),round(y1-r));
        end;
    'O':Begin
        Inc(Nbuf);
        Buf[Nbuf].X:=Round(x2);
        Buf[Nbuf].Y:=Round(Y2);
        end;
    'F':Begin
        Poly:=true;
        NBuf:=1;
        Buf[Nbuf].X:=Round(x1);
        Buf[Nbuf].Y:=Round(Y1);
        end;
    'E':Begin
        Poly:=False;
        cnv.Brush.Color:={bufrec.brush}clteal;
        cnv.pen.color:=clYellow;
        cnv.Polygon(slice(Buf,Nbuf));
        end;
    end;
  end;
end;
end;

Procedure CaricaNord;
begin
brushcor:=clTeal;
Forma(0,-25);
lineaRel(25,25);
lineaRel(0,5);
lineaRel(-25,25);
lineaRel(0,-25);
EndForma;
colcor:=clblack;
Cerchio(0,0,20);
end;

Procedure Rettangolo(L,H:real);
begin
Linea(-L/2,-H/2,L/2,-H/2);
LineaRel(L/2,H/2);
LineaRel(-L/2,H/2);
LineaRel(-L/2,-H/2);
end;

Procedure Rett_pieno(L,h,Px,Py:real;Color:TColor);
Begin
brushcor:=Color;
colcor:=color;
l:=l/2;
h:=h/2;
Forma(-L+Px,-H+Py);
lineaRel(L+Px,-H+Py);
lineaRel(L+Px,H+Py);
lineaRel(-L+Px,H+Py);
lineaRel(-L+Px,-H+Py);
EndForma;
end;

Var MinX,MinY,MaxX,MaxY:real;

Procedure CaricaFile(nomefile:string);
Var ff:file of recfig;
    temp:integer;

Procedure VerLimiti(Num:real;var Min,Max:real);
begin
if num<Min then min:=num;
if Num>max then max:=Num;
end;

begin
MaxX:=-10E10;
Maxy:=-10E10;
MinX:=10E10;
Miny:=10E10;
if fileexists(Nomefile) then
  begin
  AssignFile(ff,Nomefile);
  Reset(ff);
  while not eof(ff) do
    begin
    Inc(nFig);
    read(ff,D_fig^[Nfig]);
    with D_fig^[Nfig] do
      case tipo of
      'B':begin
          Nfig:=Nfig-1;
          {rett_Pieno(0.01,0.01,D_fig^[Nfig+1].x1,D_fig^[Nfig+1].y1,ClGreen)};
          colcor:=clblack;
          altcor:=10;
          Dtesto(D_fig^[Nfig+1].x1,D_fig^[Nfig+1].y1,testo);
          tipo:='B';
          x2:=0;
          end;
      'L':begin
          Verlimiti(x1,Minx,MaxX );
          Verlimiti(Y1,MinY,MaxY );
          Verlimiti(x2,Minx,MaxX );
          Verlimiti(Y2,MinY,MaxY );
          end;
      end;
    end;
  Close(ff);
  end;
end;

Procedure Redraw(Var BR:boolean;Canv:Tcanvas;Var Dis:TImage;panel:Tpanel;Var Totlamp:integer);
var rett:trect;
    Lfin,HFin,XCFin,YCFin,Risp:Real;
    i,j,NVert,NVertL,Norizz,NorizzL,restoLoriz,restoLvert,sporizz,spvert,MezzaL ,
    MaxLoriz,MaxLVert:integer;
    RestoVert,RestoOrizz,lq,hq,LLamp,Hlamp,sc:Real;
    all:string;
begin
{DM1.TT1.Databasename:=tab.DatabaseName;
DM1.TT1.Tablename:=tab.TableName;
DM1.TT1.Open;}
{
dis.height:=768;
dis.Width:=1024;
 }
HFin:=panel.height;
LFin:=panel.Width;
YCFin:=Hfin/2;
XCFin:=Lfin/2;
rett.top:=0;
rett.Left:=0;
rett.Right:=1024;
rett.Bottom:=768;
canv.Brush.Color:=clwhite;
canv.pen.mode:=pmblack;
canv.fillrect(rett);
if primavoltagrafica then NFig:=0;
Risp:=80;
totlamp:=0;
colcor:=clblack;
TLineacor:=PsSolid;
altcor:=20;
SpesCor:=1;
brushcor:=clwhite;
if {fileexists(Nomecom+'\prova2.dis')}false then
  begin
  if primavoltagrafica then
    begin
    CaricaFile(Nomecom+'\prova2.dis');
    primavoltagrafica:=false;
    end;
  if not ingfisso then
    begin
    ing:=(LFin-100)/(Maxx-Minx);
    if (HFin-100)/(Maxy-Miny)<Ing then ing:=(HFin-100)/(Maxy-Miny);
    spoX:=-MinX*ing+50;
    spoY:=-MinY*ing+50;
    end;
  Disegna(canv,spoX,SpoY,ing,0);
  exit;
  end;
CaricaNord;
brushcor:=clwhite;
Disegna(canv,panel.Width/2,panel.height/2,0,0);
with V_amb do
  begin
  lq:=lq1/1000;
  Hq:=Hq1/1000;
  Llamp:=LLamp1/1000;
  Hlamp:=HLamp1/1000;
  Disegna(canv,40,40,1,Direz*pi/180);
  if (h>0) and (L>0) then
    begin
    Ing:=(HFin-risp*2)/H;
    if (LFin-risp*2)/L < Ing then Ing:=(LFin-risp*2)/L;
    NFig:=0;
    ColCor:=clred;
    Rettangolo(L,H);
    ColCor:=clBlue;
    TlineaCor:=psDot;
    sc:=h/80;
    linea(-L/2-L/20,0,L/2+L/20,0);
    linea(0,-H/2-H/20,0,H/2+H/20);
    Dtesto(0-sc,H/2+H/20,'3    5=Pavimento');
    Dtesto(0-sc,-H/2-H/20-sc*4,'1');
    Dtesto(-L/2-L/20-sc,0-sc*2,'4');
    Dtesto(L/2+L/20+sc,0-sc*2,'2');

    if (Lq>0)and(Lq<L)and(Hq>0)and(Hq<H) then
      begin
      TlineaCor:=psSolid;
      ColCor:=clBlack;
      all:=allinea;
      if all='' then all:='CC';
      NvertL:=Trunc(h/hQ);
      NVert:=NVertL;
      Restovert:=h-(Nvert*hQ);
      if all[1]='C' then
        begin
        restovert:=restovert/2;
        inc(nvert);
        end;
      if all[1]='A' then
        begin
        restovert:=0;
        inc(nvert);
        end;

      For i:=1 to NVert do
      linea(-L/2,restovert+(I-1)*Hq-H/2,L/2,restovert+(I-1)*Hq-H/2);

      NOrizzL:=Trunc(L/LQ);
      NOrizz:=NOrizzL;
      RestoOrizz:=L-(NOrizz*LQ);
      if all[2]='C' then
        begin
        restoorizz:=restoorizz/2;
        inc(norizz);
        end;
      if all[2]='S' then
        begin
        restoorizz:=0;
        inc(norizz);
        end;

      For i:=1 to NOrizz do
      linea(restoorizz+(I-1)*Lq-L/2,-H/2,restoorizz+(I-1)*Lq-L/2,H/2);
      MaxLoriz:=0;
      MaxLVert:=0;
      MezzaL:=(Nlamp-1) div 2;
      if (Nlamp>0)and(LLamp>0)and(Hlamp>0) then
        begin
        restoLoriz:=NorizzL+MezzaL mod nlamp;
        sporizz:={Nlamp div 2}0;
        restoLvert:=NvertL+MezzaL mod nlamp ;
        spvert:={Nlamp div 2}0;
        for i:=1 to nvertL do
        for j:= 1 to NOrizzL do
          begin
          if ( ( (i+mezzaL ) mod nlamp)=0) and(((j+MezzaL) mod nlamp)=0) then
            begin
            MaxlOriz:=j;
            MaxLvert:=i;
            end;
          end;
        RestoLoriz:=Norizz-MaxLoriz;
        sporizz:=(RestoLoriz-(Nlamp-1-MezzaL))div 2;
        if (RestoLoriz-(Nlamp-1-MezzaL))mod 2 <>0 then
          begin
          if all[2]='S' then inc(sporizz);
          end;
        RestoLVert:=NVert-MaxLOriz;
        spVert:=(RestoLVert-(Nlamp-1-MezzaL))div 2;
        if  (RestoLVert-(Nlamp-1-MezzaL))Mod 2 <>0 then
          begin
          if all[1]='A' then inc(spVert);
          end;
        for i:=1 to nvertL do
        for j:= 1 to NOrizzL do
          begin
          if ( ( (i+mezzaL-spvert ) mod nlamp)=0) and(((j+MezzaL-sporizz) mod nlamp)=0) then
            begin
            inc(totlamp);
             Rett_pieno(LLamp,HLamp,-L/2+Lq/2+restoOrizz+(j-1)*Lq,-H/2+Hq/2+restoVert+(i-1)*Hq,clYellow);
            end;
          end;
         br:=true;
         {set_Tlamp(totlamp);}
         br:=false;
        end;
      end;

    Disegna(canv,XCFin,YCFin,Ing,0);
    end;
  end;
{DM1.TT1.close;}
end;
end.
