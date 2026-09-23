

unit U_VARPEZZI;

interface


 VAR
    i,j:integer;
    y,Cell1,Cell2:real;
    st1:string;
    Alfa:real;
    Speculare:boolean;

    TypeRid,TypeAll,TypeRot:boolean;
    codpezzo:string;
    B1,H1,B2,H2,B3,H3,B4,H4,D1,D2,D3,D4:real;
    Orient:integer;Ang,Curv,Lung,Rap,Rap1,Varie:real;
    X1A,Y1A,X2A,Y2A,X3A,Y3A,X4A,Y4A,
    X5A,Y5A,X6A,Y6A,X7A,Y7A,X8A,Y8A,Z1,Z2,Z3,Z4:real;
    ColoreLinea:integer;

Function Tan(Ang:real):real;
Function ArcCos(CosAng:real):real;
Function ArcSin(SinAng:real):real;
Procedure Specchio;
Procedure SpecchioX;
Procedure Rotaz;
Procedure ModiCord(var Cordx,Cordy:real;Dx,Dy,Rot:real);
Procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4:real);
                 var  m1,m2,c1,c2,max1,max2,min1,min2:real;
Procedure FrecciaU(X,Y,L,Inc:real;var i:integer);
Procedure FrecciaE(X,Y,L,Inc:real;var i:integer);
Procedure BoccRet(Base,Alt:real;var i,Tipo:integer);
Procedure BoccCirc(Diam:real;var i,Tipo:integer);
Function ArrotDec(R:real):real;

implementation

uses crt,dos,definiz,definizcan;

function Tan(Ang:real):real;
 begin
    Tan:=0;
    if cos(ang) <> 0 then
     Tan:=sin(Ang)/cos(Ang);
 end;

function ArcCos(CosAng:real):real;
var
 SinAng,TanAng:real;
 begin
    arccos:=0;
    if (cosang*cosang)< 1 then
    begin
    SinAng:=sqrt(1-(CosAng*CosAng));
    if CosAng<>0 then
     begin
        TanAng:=SinAng/CosAng;
        ArcCos:=arctan(TanAng);
     end
    else
     begin
        if CosAng>0 then ArcCos:=PI/2
        else ArcCos:=-PI/2;
     end;
    end;
 end;

function ArcSin(SinAng:real):real;
var
 CosAng,TanAng:real;
 begin
    ArcSin:=0;
    if (sinang*sinang)< 1 then
     begin
    CosAng:=sqrt(1-(SinAng*SinAng));
    if CosAng<>0 then
     begin
        TanAng:=SinAng/CosAng;
        ArcSin:=arctan(TanAng);
     end
    else
     begin
        if SinAng>0 then ArcSin:=PI/2
        else ArcSin:=-PI/2;
     end;
   end;
 end;

procedure Specchio;
 var i:integer;
begin
   for i:=1 to 30 do
    with DisPezzo^[i] do
     begin
        Y1:=-Y1;    Y2:=-Y2;
     end;
end;

procedure SpecchioX;
 var i:integer;
begin
   for i:=1 to 30 do
    with DisPezzo^[i] do
     begin
        X1:=-X1;    X2:=-X2;
     end;
end;

procedure Rotaz;
 var i:integer;
     A,B:real;
begin
   for i:=1 to 30 do
    with DisPezzo^[i] do
     begin
        A:=X1;     B:=X2;
        X1:=Y1;    X2:=Y2;
        Y1:=A;     Y2:=B;
     end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Modicord        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure ModiCord(var Cordx,Cordy:real;Dx,Dy,Rot:real);
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

Dist:=sqrt(sqr(Cordx)+sqr(Cordy));
Ang:=Ang+Rot;
CordX:=sin(ang)*Dist+Dx;
Cordy:=Cos(ang)*Dist+Dy;
end;

{*************************** Inters1   **************************************}
procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4:real);
var  m1,m2,c1,c2,max1,max2,min1,min2:real;

begin
res:=1;
if abs(x2-x1)>10E-6 then m1:=(y2-y1)/(x2-x1)
else m1:=10E6;
if abs(x4-x3)>10E-6 then m2:=(y4-y3)/(x4-x3)
else m2:=10E6;
if abs(m2-m1)>10E-6 then
  begin
  c1:=y1-m1*x1;
  c2:=y3-m2*x3;
  x:=(c2-c1)/(m1-m2);
  y:=m1*x+c1;
  end
else res:=0;

end;


procedure FrecciaU(X,Y,L,Inc:real;var i:integer);
var
  a,b:real;
 begin
    Inc:=Inc/180*pi;
    with DisPezzo^[i] do
     begin
        Entita:='L';          TLinea:=1;
        A:=X;                 B:=Y;
        ModiCord(A,B,0,0,Inc);
        X1:=A;                Y1:=B;
        A:=X+L;               B:=Y;
        ModiCord(A,B,0,0,Inc);
        X2:=A;                Y2:=B;
        R:=0;
     end;
    i:=i+1;
    with DisPezzo^[i] do
     begin
        Entita:='L';          TLinea:=1;
        X1:=DisPezzo^[i-1].X2; Y1:=DisPezzo^[i-1].Y2;
        {A:=X+L-12;            B:=Y+9;}
        A:=X+L-(L/4);          B:=Y+(L/8.5);
        ModiCord(A,B,0,0,Inc);
        X2:=A;                Y2:=B;
        R:=0;
     end;
    i:=i+1;
    with DisPezzo^[i] do
     begin
        Entita:='L';          TLinea:=1;
        X1:=DisPezzo^[i-1].X1; Y1:=DisPezzo^[i-1].Y1;
        {A:=X+L-12;            B:=Y-9;}
        A:=X+L-(L/4);          B:=Y-(L/8.5);
        ModiCord(A,B,0,0,Inc);
        X2:=A;                Y2:=B;
        R:=0;
     end;
    i:=i+1;
 end;

procedure FrecciaE(X,Y,L,Inc:real;var i:integer);
var
  a,b:real;
 begin
    Inc:=Inc/180*pi;
    with DisPezzo^[i] do
     begin
        Entita:='L';          TLinea:=1;
        A:=X;                 B:=Y;
        ModiCord(A,B,0,0,Inc);
        X1:=A;                Y1:=B;
        A:=X+L;               B:=Y;
        ModiCord(A,B,0,0,Inc);
        X2:=A;                Y2:=B;
        R:=0;
     end;
    i:=i+1;
    with DisPezzo^[i] do
     begin
        Entita:='L';          TLinea:=1;
        X1:=DisPezzo^[i-1].X1; Y1:=DisPezzo^[i-1].Y1;
        {A:=X+12;            B:=Y+9;}
        A:=X+L-(L/4);          B:=Y+(L/8.5);
        ModiCord(A,B,0,0,Inc);
        X2:=A;                Y2:=B;
        R:=0;
     end;
    i:=i+1;
    with DisPezzo^[i] do
     begin
        Entita:='L';          TLinea:=1;
        X1:=DisPezzo^[i-1].X1; Y1:=DisPezzo^[i-1].Y1;
        {A:=X+12;              B:=Y-9;}
        A:=X+L-(L/4);          B:=Y-(L/8.5);
        ModiCord(A,B,0,0,Inc);
        X2:=A;                Y2:=B;
        R:=0;
     end;
    i:=i+1;
 end;


Procedure BoccRet(Base,Alt:real;var i,Tipo:integer);
var
Int:integer;

 begin
    with DisPezzo^[i] do
     begin
        Entita:='L';          TLinea:=Tipo;
        X1:=-Alt/2;           Y1:=-Base/2;
        X2:=Alt/2;           Y2:=Base/2;
{        inters(X2,Y2,Int,X1,X1+Alt/5,Alt/2,X1,Y1,-Y1,-Y1,-Y1-(Base/5));
        if Int<>1 then write(chr(7)); }
     end;
    Conf^.ManRip:=UpCase(Conf^.ManRip[1]);
    if Conf^.ManRip = 'M' then
     with DisPezzo^[i+1] do
      begin
         Entita:='L';          TLinea:=Tipo;
         X1:=-Alt/2;           Y1:=Base/2;
         X2:=Alt/2;            Y2:=-Base/2;
      end;
 end;

Procedure BoccCirc(Diam:real;var i,Tipo:integer);
var
Dx:real;

 begin
    Dx:=(Diam/2)*Cos(pi/4);
    with DisPezzo^[i] do
     begin
        Entita:='L';          TLinea:=Tipo;
        X1:=Dx;               Y1:=Dx;
        X2:=-Dx;              Y2:=-Dx;
     end;
    Conf^.ManRip:=UpCase(Conf^.ManRip[1]);
    if Conf^.ManRip = 'M' then
     with DisPezzo^[i+1] do
      begin
         Entita:='L';         TLinea:=Tipo;
         X1:=-Dx;             Y1:=Dx;
         X2:=Dx;              Y2:=-Dx;
      end;
 end;
 function ArrotDec(R:real):real;
var Ar:real;
    PInt:integer;
begin
   R:=Trunc((R+0.001)*100)/100;
   PInt:=Trunc(R);
   Ar:=R-Trunc(R);
   Ar:=Trunc(Ar*10+1);
   ArrotDec:=PInt+Ar/10;
end;

END.

