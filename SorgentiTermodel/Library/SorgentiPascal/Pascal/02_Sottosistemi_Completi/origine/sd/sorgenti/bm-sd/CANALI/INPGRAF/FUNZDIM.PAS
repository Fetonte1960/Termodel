{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit FunzDim;

INTERFACE

uses Definiz,Angoli,printer;

function UpString(St:string):string;
Procedure Init_COST;
PROCEDURE TRANSFER_Costanti(FileName:STring;Modo:CHAR);
procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4:real);
var  m1,m2,c1,c2,max1,max2,min1,min2:real;
Function Bordo(Riga:integer;Larg,Diam:real):real;
Procedure ModiCord(var Cordx,Cordy:real;Dx,Dy,Rot:real;ing:Boolean);
procedure Quote(tr,trat:integer;cx1,cy1,cx2,cy2,Direz:real;Var Rprec,APrec,BPrec:real);
Procedure Quotaboc(tr,trat:integer;cx1,cy1,cx2,cy2,Direz:real);
Function CalcSpx(i:integer;Dir,DirZ,L,H,FI,Spy:real;Riduz:Boolean):real;
procedure inters_A(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr:real);
Procedure RaddrizzaDis(Angolo:Real);


{---------------------------------------------------------------------------}
implementation


Procedure RaddrizzaDis(Angolo:Real);
Var Vettore1:VetDim;

Begin
{If Sez_Dim Then
With Vettore^ Do}

Vettore1:=Vettore^;
If Sez_Dim Then
With Vettore1 Do
  begin

  Z1:=Vettore^.Y1;
  Y1:=-Vettore^.Z1;
  X1:=Vettore^.X1;
  Modicord(X1,Y1,0,0,-Angolo,False);

  If Entita[1] IN ['L','F','*'] then
    begin
    Z2:=Vettore^.Y2;
    Y2:=-Vettore^.Z2;
    X2:=Vettore^.X2;
    Modicord(X2,Y2,0,0,-Angolo,False);
    end;
  If Entita[1]='A' then Writeln(FDeb,R:6:0);


  {Writeln(FDeb,'  X1:',X1:6:0,'  Y1:',Y1:6:0,'  Z1:',Z1:6:0,
               '  X2:',X2:6:0,'  Y2:',Y2:6:0,'  Z2:',Z2:6:0);}
  end;

Write(FDim,Vettore1);
end;




 function Exist(Nome:string):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;

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


 function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;




{ ---------------------------- INIT_COSTANTI ------------------------------ }

Procedure Init_COST;
var i : integer;
begin

 if not Exist(drivearc+'costanti.ark') then
  begin
     with Costant^ do
      begin
         ColCan:=15;    ColQ:=4;
         QCan:='S'; Por:='S';  Altquo:=4;
         C1:=0;     C2:=0;     C3:=0;
         C4:=0;     C5:=0;     C6:=0;
         C7:=0;     C8:=0;     C9:=0;
         C10:=0;    C11:=0;    C12:=0;
         C13:=0;    C14:=0;    C15:=0;
         C16:=0;    C17:=0;    C18:=0;
         C19:=0;    C20:=0;    C21:=0;
         C22:=0;    C23:=0;    C24:=0;
      end;
  end;
end;


{ ---------------------------- TRANSFER_Costanti -------------------------- }

PROCEDURE TRANSFER_Costanti(FileName:STring;Modo:CHAR);


VAR

  Fl   : FILE OF RecCostDis;
  IOERR: INTEGER;

BEGIN

  Modo:=UpCase(Modo);

  if (not exist(filename) ) and (modo = 'L') then
   begin
      Modo :='S';
      Init_Cost;
   end;

      ASSIGN(Fl,FileName);

      IF Modo='S' THEN
       begin
         Rewrite(Fl);
         IOERR:=IOresult;
         Write(Fl,Costant^);
       end

     ELSE
       begin
        Reset(Fl);
        IOERR:=IOresult;
        Read(Fl,Costant^);
       end;

      CLOSE(Fl);

END;  { PROC. TRANSFER_Costanti }


{*************************** Inters  **************************************}

procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4:real);
var  m1,m2,c1,c2,max1,max2,min1,min2:real;

begin
res:=1;
if abs(x2-x1)>10E-6 then m1:=(y2-y1)/(x2-x1)
else m1:=10E6;
if abs(x4-x3)>10E-6 then m2:=(y4-y3)/(x4-x3)
else m2:=10E6;

if abs(m2-m1)>10E-1 then
  begin
  c1:=y1-m1*x1;
  c2:=y3-m2*x3;
  x:=(c2-c1)/(m1-m2);
  y:=m1*x+c1;
  if m1>=10E6 then x:=x1;
  if m2>=10E6 then x:=x3;
  end
else res:=0;

end;

{*************************** Inters_A  **************************************}

procedure inters_A(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr:real);
var  m1,m2,c1,c2,max1,max2,min1,min2:real;

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
      else m1:=10E6;
      if abs(x4-x3)>10E-6 then m2:=(y4-y3)/(x4-x3)
      else m2:=10E6;
      if abs(m2-m1)>10E-6 then
      begin
        c1:=y1-m1*x1;
        c2:=y3-m2*x3;
        x:=(c2-c1)/(m1-m2);
        y:=m1*x+c1;
        if ((x-x1>=-apr)or(x-x2>=-apr))and { verifica se il punto e' interno ai segmenti }
        ((x-x1<=+apr)or(x-x2<=+apr))   and
        ((y-y1>=-apr)or(y-y2>=-apr))   and
        ((y-y1<=+apr)or(y-y2<=+apr))   and
        ((x-x3>=-apr)or(x-x4>=-apr))   and
        ((x-x3<=+apr)or(x-x4<=+apr))   and
        ((y-y3>=-apr)or(y-y4>=-apr))   and
        ((y-y3<=+apr)or(y-y4<=+apr))      then res:=1  else  res:=0;
      end
      else res:=0;
    end
    else res:=0;
  end
  else res:=0;
end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Bordo           *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function Bordo(Riga:integer;Larg,Diam:real):real;

var Tipo:integer;

begin

if Larg=0 then Larg:=Diam;
Tipo:=1;
with Dis^[riga]^ do
  begin
  if sezione then
    begin
      Case color of
      1,2,3:Tipo:=1;
      4,5,6:Tipo:=2;
      7,8,9:Tipo:=3;
      end;
    end
  else
    begin
      Case color of
      1,4,7:Tipo:=1;
      2,5,8:Tipo:=2;
      3,6,9:Tipo:=3;
      end;
    end;

  end;
  Case Tipo of
  1:Bordo:= 0;
  2:Bordo:= Larg/2;
  3:Bordo:=-Larg/2;
  end;

end;

{***************************  CalcSpx     *****************************}

Function CalcSpx(i:integer;Dir,DirZ,L,H,FI,Spy:real;Riduz:Boolean):real;

Var Spx1:real;

begin

IF not Ug(DirZ,0,1) then
  begin
  sezione:=true;
  L:=H;
  end;

spx1:=Bordo(i,L,Fi);

sezione:=false;

IF not Ug(DirZ,0,1) then
  begin
  if not riduz then
    begin
    if abs(abs(dirZ)-Pi/2)>0.1 then
    spx1:=spx1/sin(dirZ)-spy/(sin(dirZ)/cos(dirZ))
    else spx1:=spx1/sin(dirZ);
    spx1:=-spx1;
    end
  else Spx1:=0;
  end
else
  begin
  if not riduz then
    begin
    if abs(abs(dir)-Pi/2)>0.1 then
    spx1:=spx1/sin(dir)-spy/(sin(dir)/cos(dir))
    else spx1:=spx1/sin(dir);
    end
  else Spx1:=0;
  end;
CalcSpx:=spx1;
end;


{-----------------------------------------------------------------------------}





{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Modicord        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure ModiCord(var Cordx,Cordy:real;Dx,Dy,Rot:real;ing:Boolean);
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

Dist:=sqr(Cordx)+sqr(Cordy);
if dist>=0 then Dist:=sqrt(dist)
else
  begin
  write('Modicord Radice negativa');
  dist:=0;
  end;
if ing then dist:=Dist/(Conf^.Altnum/40);
Ang:=Ang+Rot;
CordX:=sin(ang)*Dist+Dx;
Cordy:=Cos(ang)*Dist+Dy;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Quote         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

procedure Quote(tr,trat:integer;cx1,cy1,cx2,cy2,Direz:real;Var Rprec,APrec,BPrec:real);

Const
      aspChar=0.55;

Var HNum,Ln1:real;

var inga,ingb,Dircan,Cenx,CenY,Lar,pinsx,pinsy:real;
    Lungt:integer;
    a1:real;
    Circ:boolean;
    Codp:string;
    QuotaEst:boolean;

begin
HNum:=Costant^.AltQuo*40;
ln1:=Hnum/4;
trat:=trat+1;
repeat
trat:=trat-1;
Codp:=Vpezzi^[Dati^[tr]^.Pezzi[trat]]^.Codice;
until (Codp='310R')or(Codp='310C')or(Codp='310R ')or(Codp='310C ') or
      (Codp='310F ')or(Codp='310F') or(trat=1);


with Vpezzi^[Dati^[tr]^.Pezzi[trat]]^ do
if (Rprec<>R)or(Aprec<>A)or(BPrec<>B) then
  begin
  RPrec:=R;
  APrec:=A;
  BPrec:=B;
  Vettore^.TLinea:=1;
  Vettore^.Colore:=Costant^.Colq;
  circ:=true;
  if a>0 then
    begin
    circ:=false;
    a1:=a; {round(a);}
    end
  else a1:=R; {round(R);}
  lungt:=6;
  if a1>1000 then lungt:=7;
  if a1<100 then lungt:=5;
  Lar:=a1*40.0/Conf^.altNum;
  Cenx:=(cx1+cx2)/2;
  Ceny:=(cy1+cy2)/2;
  Dircan:=Direz;

  if (dirCan>0)and(dircan<=Pi) then dirCan:=dirCan-Pi;
  if Dircan<=-Pi then dircan:=DirCan+Pi;

  if (lar<(Lungt+1)*Hnum*aspchar)              or
     (sqrt(sqr(cx2-cx1)+sqr(cy2-cy1))<2.5*Hnum)or  {Controlla che il canale non sia troppo lungo}
     ((abs(dircan)>0.2)                    and
     (abs(abs(Dircan)-Pi)>0.2)             and
     (abs(abs(Dircan)-3*Pi/2)>0.2)         and
     (abs(abs(Dircan)-2*Pi)>0.2)           and
     (abs(abs(Dircan)-Pi/2)>0.2)) then

  QuotaEst:=true else QuotaEst:=false;

  if (not(QuotaEst))or(Upstring(Costant^.QCan)<>'N') then
    begin

    Vettore^.entita:='L';
    Vettore^.X1:=-ln1;
    Vettore^.Y1:=-ln1;
    Vettore^.X2:=ln1;
    Vettore^.Y2:=ln1;
    Pinsx:=0;
    PinsY:=-Lar/2;
    ModiCord1(PinsX,PinsY,0,0,DirCan,1);
    ModiCord1(Vettore^.X1,Vettore^.Y1,Cenx+Pinsx,Ceny+Pinsy,Dircan,1);
    ModiCord1(Vettore^.X2,Vettore^.Y2,Cenx+Pinsx,Ceny+PinsY,Dircan,1);

    RaddrizzaDis(0);
    {Write(FDim,Vettore^);}

    Vettore^.X1:=-ln1;
    Vettore^.Y1:=-ln1;
    Vettore^.X2:=ln1;
    Vettore^.Y2:=ln1;
    Pinsx:=0;
    PinsY:=Lar/2;
    ModiCord1(PinsX,PinsY,0,0,DirCan,1);
    ModiCord1(Vettore^.X1,Vettore^.Y1,Cenx+Pinsx,Ceny+Pinsy,Dircan,1);
    ModiCord1(Vettore^.X2,Vettore^.Y2,Cenx+Pinsx,Ceny+PinsY,Dircan,1);

    RaddrizzaDis(0);
    {Write(FDim,Vettore^);}

    Vettore^.X1:=0;
    Vettore^.Y1:=lar/2;
    Vettore^.X2:=0;
    Vettore^.Y2:=-lar/2;
    ModiCord1(Vettore^.X1,Vettore^.Y1,Cenx,Ceny,Dircan,1);
    ModiCord1(Vettore^.X2,Vettore^.Y2,Cenx,Ceny,Dircan,1);

    RaddrizzaDis(0);
    {Write(FDim,Vettore^);}


    if  QuotaEst then

      begin

      Vettore^.X2:=0;
      Vettore^.Y2:=-lar/2;
      Vettore^.X1:=0;
      Vettore^.Y1:=-lar/2-1.5*Hnum;
      ModiCord1(Vettore^.X1,Vettore^.Y1,Cenx,Ceny,Dircan,1);
      ModiCord1(Vettore^.X2,Vettore^.Y2,Cenx,Ceny,Dircan,1);

      RaddrizzaDis(0);
      {Write(FDim,Vettore^);}

      Vettore^.y2:=Vettore^.Y1;
      Vettore^.x2:=Vettore^.x1+Hnum*aspChar*(0.5+Lungt);

      RaddrizzaDis(0);
      {Write(FDim,Vettore^);}

      Vettore^.entita:='Q';
      Vettore^.y1:=Vettore^.Y1+Hnum*0.2;
      Vettore^.x1:=Vettore^.x1+Hnum*0.2;
      Vettore^.X2:=a1;
      Vettore^.Y2:=0;

      if circ then Vettore^.R:=3 else Vettore^.R:=1;

      RaddrizzaDis(0);
      {Write(FDim,Vettore^);}

      if not circ then
        begin

        Vettore^.y1:=Vettore^.Y1-Hnum*1.4;
        Vettore^.X2:=b;
        Vettore^.R:=2;

        RaddrizzaDis(0);
        {Write(FDim,Vettore^);}
        end;

      end

    else

      begin
      direz:=direz+3/2*pi;
      if direz<0 then Direz:=Direz+2*pi;
      int1:=Round(Direz/(pi/2))mod 4;
      if int1=2 then int1:=0;
      if int1=3 then int1:=1;
      Vettore^.entita:='Q';

      if int1=0 then
        begin
        Vettore^.X1:=(cx1+cx2)/2-(hnum*lungt/2*AspChar);
        Vettore^.Y1:=(cy1+cy2)/2+hnum*0.2;
        end
      else
        begin
        Vettore^.X1:=(cx1+cx2)/2-hnum*0.2;
        Vettore^.Y1:=(cy1+cy2)/2-(hnum*lungt/2*AspChar);
        end;
      Vettore^.X2:=a1;
      Vettore^.Y2:=int1;
      if circ then Vettore^.R:=3 else Vettore^.R:=1;

      RaddrizzaDis(0);
      {Write(FDim,Vettore^);}

      if not circ then
        begin

        if int1=0 then
          begin
          Vettore^.X1:=(cx1+cx2)/2-(hnum*lungt/2*AspChar);
          Vettore^.Y1:=(cy1+cy2)/2-hnum*1.5;
          end
        else
          begin
          Vettore^.X1:=(cx1+cx2)/2+hnum*1.2;
          Vettore^.Y1:=(cy1+cy2)/2-(hnum*lungt/2*AspChar);
          end;

        Vettore^.X2:=b;
        Vettore^.R:=2;

        RaddrizzaDis(0);
        {Write(FDim,Vettore^);}
        end
      end
    end
  end;
end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Quotaboc       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Quotaboc(tr,trat:integer;cx1,cy1,cx2,cy2,Direz:real);

Const
      aspChar=0.55;
      Ln1=40;

var Dircan,Cenx,CenY,Lar:real;
    Lungt:integer;
    a1:real;{integer;}
    Codp:string;
    HNum:Real;

begin
HNum:=Costant^.AltQuo*40;
with Vpezzi^[Dati^[tr]^.Pezzi[trat]]^ do
if upstring(Costant^.Por)<>'N' then

  begin

  Vettore^.TLinea:=1;
  Vettore^.Colore:=Costant^.Colq;;
  lungt:=5;

  if a>0 then a1:=a {round(a)}
  else a1:=r; {round(R);}

  Lar:=a1*40/Conf^.altNum;
  Cenx:=(cx1+cx2)/2;
  Ceny:=(cy1+cy2)/2;
  Dircan:=Direz;
  if (dirCan>0.1)and(dircan<=Pi) then dirCan:=dirCan-Pi;
  if Dircan<=-Pi then dircan:=DirCan+Pi;

  Vettore^.entita:='L';
  Vettore^.X2:=0;
  Vettore^.X1:=0;
  Vettore^.Y2:=lar/2;
  Vettore^.Y1:=lar/2+1.7*Hnum;

  ModiCord1(Vettore^.X1,Vettore^.Y1,Cenx,Ceny,Dircan,1);
  ModiCord1(Vettore^.X2,Vettore^.Y2,Cenx,Ceny,Dircan,1);

  RaddrizzaDis(0);
  {Write(FDim,Vettore^);}

  Vettore^.y2:=Vettore^.Y1;

  if Ug(dircan,0,1) then
  Vettore^.x2:=Vettore^.x1+Hnum*aspChar*(0.5+Lungt)
  else Vettore^.x2:=Vettore^.x1-Hnum*aspChar*(0.5+Lungt);

  RaddrizzaDis(0);
  {Write(FDim,Vettore^);}

  Vettore^.entita:='Q';

  if ug(dircan,0,1) then Vettore^.x1:=Vettore^.x1+Hnum*0.2
  else Vettore^.x1:=Vettore^.x2;

  Vettore^.y1:=Vettore^.Y1+Hnum*0.2;
  Vettore^.X2:=Port;
  Vettore^.Y2:=0;
  Vettore^.R :=5;

  RaddrizzaDis(0);
  {Write(FDim,Vettore^);}

  Vettore^.y1:=Vettore^.Y1-Hnum*1.4;
  Vettore^.R:=4;

  RaddrizzaDis(0);
  {Write(FDim,Vettore^);}

  end

end;

end.