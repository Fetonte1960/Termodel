unit Geometria;

interface
uses math,dialogs,sysutils;
Function CalcZ(xx,yy:real;orient,inclin,ZZMax:real):real;
Procedure Calc_D(X1,Y1,Z1,X2,Y2,Z2:real;Var Dir,DirZ:real);
Function Vicino(xx1,yy1,zz1,xx2,yy2,zz2:real):boolean;
Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);

Var nblocchitemp:integer;
implementation
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
Cordy:=(Cos(ang)*Dist+Dy);
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Calc_D       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Calc_D(X1,Y1,Z1,X2,Y2,Z2:real;Var Dir,DirZ:real);

var dist,temp:real;

begin
if y2=y1 then
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
  if dist<>0 then
    begin
    temp:=(z2-z1)/dist;
    dirz:=arcsin(temp);
    end
  else
    begin
    dir:=0;
    dirz:=0;
    end;
  end

end;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Calc_Z       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
//date le coordinate xx,yy calcola la Z sviluppando l'equazione
//di un piano con orientamento orient inclinazione inclin e valore di z in 0,0  Zmax

Function CalcZ(xx,yy:real;orient,inclin,ZZMax:real):real;
Var Dir,Dirz:real;
begin
Calc_D(0,0,0,xx,yy,0,dir,dirz);
result:=sqrt(sqr(xx)+sqr(yy))*cos(dir-(orient+180)*pi/180)*Tan(inClin*pi/180)-{Zesp[inde].}ZZmax;
//if zzmax<>0 then
//showmessage(floattostr(xx)+','+floattostr(yy)+','+floattostr(zzmax)+','+floattostr(result));
end;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Vicino       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

 Function Vicino(xx1,yy1,zz1,xx2,yy2,zz2:real):boolean;

   function Vic(a,b:real):boolean;
    Const
      app=0.01;
   begin
     vic:=abs(a-b)<app;
   end;
 begin
   result:=vic(xx1,xx2)and vic(yy1,yy2)and vic(zz1,zz2);
 end;

 Function float_To_str(valore:real; cdec:integer):String;
 begin
  str(valore:0:cdec,result);
 end;

end.
