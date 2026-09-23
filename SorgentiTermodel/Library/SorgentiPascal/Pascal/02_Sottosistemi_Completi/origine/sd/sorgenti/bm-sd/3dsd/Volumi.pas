unit Volumi;
interface
Uses Uvariabililettura,geometria,sysutils;
Function Hmedia(numamb:Integer;Codnum:string):real;

implementation
uses calcolaZ;
Function Hmedia(numamb:Integer;Codnum:string):real;
Var i,ultf,a_1,A_2,indbl:integer;
    sommavol,sommaarea:real;
type TPOint=record xp_1,yp_1,xp_2,yp_2:real end;
 Var Vert:Tpoint;

function UltimaFrontiera:integer;
var ult:integer;
begin

   Ult:=MaxFrontiere1;

   while ( (Ft^[Ult].x0 = 0) AND  (Ft^[Ult].x1 = 0) AND
           (Ft^[Ult].Y0 = 0) AND  (Ft^[Ult].Y1 = 0) AND
           (Ult > 1) ) do Ult:=Ult-1;
   UltimaFrontiera:=Ult;

end;

Var HfissA:REAL;
function zP(xxp,yyp:real):real;
begin
result:=Z_Falda(xxp,yyp,Numamb);
end;

begin
result:=0;
indbl:=1;
while (indbl<nblocchitemp)and
      ((uppercase(Bll^[indbl].nome)<>'AMB')or(Bll^[indbl].Attrib1[1]<>codnum))
do inc(indbl);
if (uppercase(Bll^[indbl].nome)<>'AMB')or(Bll^[indbl].Attrib1[1]<>codnum)
then exit;

hfissa:=0;
Sommavol:=0;
SommaArea:=0;
ultf:=Ultimafrontiera;
for i:=1  to Ultf do
with ft^[i] do
begin

if (A1=indbl)or(A2=Indbl)then
  begin

  with Vert do
    begin
    if (A1=indbl) then
      begin
      xp_1:=x0/ftscala;
      Yp_1:=Y0/ftscala;
      xp_2:=x1/ftscala;
      Yp_2:=Y1/ftscala;
      end
    else
      begin
      xp_1:=x1/ftscala;
      Yp_1:=Y1/ftscala;
      xp_2:=x0/ftscala;
      Yp_2:=Y0/ftscala;
      end;

    SommaArea := SommaArea+( (Yp_1+Yp_2)/2*
                      (XP_2 -Xp_1));

    if yp_2>yp_1 then
      sommavol:=sommavol+(xp_2-xp_1)/2*(yp_1*zp(xp_1+(xp_2-xp_1)/3,Yp_1/3)
                                   +yp_1*zp(xp_1+(xp_2-xp_1)*2/3,Yp_1*2/3)
                                   +(yp_2-yp_1)*zp(xp_1+(xp_2-xp_1)*2/3,Yp_1+(yp_2-yp_1)/3))
    else
      sommavol:=sommavol+(xp_2-xp_1)/2*(yp_2*zp(xp_1+(xp_2-xp_1)/3,Yp_2/3)
                                   +yp_2*zp(xp_1+(xp_2-xp_1)*2/3,Yp_2*2/3)
                                   +(yp_1-yp_2)*zp(xp_1+(xp_2-xp_1)/3,Yp_2+(yp_1-yp_2)/3));

    end

  end;

end;
if sommaarea<>0 then result:=sommavol/sommaarea;
end;

end.
