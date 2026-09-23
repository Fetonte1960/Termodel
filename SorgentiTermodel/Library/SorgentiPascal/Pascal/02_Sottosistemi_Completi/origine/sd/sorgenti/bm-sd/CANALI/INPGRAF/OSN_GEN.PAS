
{$R+}    {Range checking off}
{$B-}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit osnap;

interface

uses crt,dos,definiz,genproc,ut_deb,halotp4,graph;

Function Osn(Var P_x,P_y:real;xp,yp,xu,yu:real;codice:integer):Boolean;


{==========================================================================}
implementation

Procedure linea(xa,ya,xb,yb:real);
function xgraf(xeff:real):real;
begin
xgraf:=xg1(Xeff+22717,0);
end;
function ygraf(yeff:real):real;
begin
ygraf:=yg1(Yeff+17937,0);
end;

begin
xa:=xgraf(xa);
ya:=ygraf(ya);
xb:=xgraf(xb);
yb:=ygraf(yb);

setcolor(5);
movabs(@xa,@ya);
lnabs(@xb,@yb);
repeat until keypressed;
end;

{***********************************************************************}
Procedure Vicino(var x,y:real;Xa,ya,Ang,xp1,yp1,xp2,yp2,Dist:real);
Var M1,m2,c1,c2:real;
begin
if  (abs(xp2-xp1)<=10E-6)then
 begin
 M1:=10E6;
 c1:=0;
 end
else
 begin
 m1:=(yp2-yp1)/(xp2-xp1);
 c1:=yp1-m1*xp1;
 end;

if abs(sin(ang))<x

end;

{ **************************** Perp ********************************* }

procedure perp(var x,y:real;xpun,ypun,x1,y1,x2,y2);

var a,c,b,d:real;


 begin

   if (abs(x2-x1)>10E-6) and (abs(y2-y1)>10E-6)then  { retta qualsiasi di arrivo}
   begin
     a:=(y2-y1)/(x2-x1);   {by minardo}
     b:=y1-a*x1;
     c:=-1/a;
     d:=ypun+xpun*1/a;
     x:=(d-b)/(a-c);
     y:=a*x+b;
   end;

   if  (abs(x2-x1)<=10E-6)then
   begin
    x:=x1;
    y:=ypun;
   end;

   if (abs(y2-y1)<=10E-6) then
   begin
    x:= xpun;
    y:= y1;
   end;

 end;

{**************************************************************************}


Function Osnap_P(Var pX,Py:integer;tipo:integer;box:integer;Pianta:string;xp1,yp1,xu1,yu1:real):Boolean;

type recdis=record mov:boolean;x,y:integer end;
     RECDIS1=ARRAY[1..nhpgl]OF RECDIS;
     TMP=record
          xm,ym:array[1..2]of integer;
          P_d:integer;
          end;

Var X_pr,Y_Pr:Integer;
    Max_x,Max_Y,Min_X,Min_Y:Integer;
    FDIS1:file of RECDIS1;
    dentro_p,Dentro_c:Boolean;
    M_Line,Max_line:Integer;
    M_p:array[1..10] of TMP;
    trovato,troppi,Os_temp:Boolean;
    hpgl:recdis1;
    i:integer;
    Fdeb:text;
    dist,dist1,dist2:real;
    temp:integer;



 {----}

Function Dentro(Punto:RECDIS):boolean;
begin
Dentro:=false;

with punto do
if (x>Min_x)and(x<Max_x)and(y>Min_y)and(y<Max_y) then dentro:=true;
end;

 {-----}

Function Dentro1(Punto:RECDIS):boolean;
begin
Dentro1:=false;

with punto do
if ((x>Min_x)and(x<Max_x))or((y>Min_y)and(y<Max_y)) then dentro1:=true;
end;

 {------}

Function Dentro_L(Punto:RECDIS;xpr,ypr:real):boolean;

Var lato1,lato2:integer;
    Sopra1,Sopra2,destra1,destra2:boolean;

function lato(xc,yc:real):integer;
begin
if xc>Px then
  begin
  if yc>py then lato:=2
  else lato:=3;
  end
else
  begin
  if yc>py then lato:=1
  else lato:=4;
  end;
end;


begin
Dentro_L:=false;
if abs(Punto.x-xpr)<5 then
  begin
  if abs(Punto.X-px)<=box then
    begin
    lato1:=lato(punto.x,punto.y);
    lato2:=lato(xpr,ypr);
    sopra1:=(Lato1=1)or(lato1=2);
    sopra2:=(Lato2=1)or(lato2=2);
    Dentro_l:=(sopra1)xor(sopra2);
    end
  end;
else
  begin
  if abs(Punto.y-ypr)<5 then
    begin
    if abs(Punto.y-py)<=box then
      begin
      lato1:=lato(punto.x,punto.y);
      lato2:=lato(xpr,ypr);
      destra1:=(Lato1=2)or(lato1=3);
      destra2:=(Lato2=2)or(lato2=3);
      Dentro_l:=(destra1)xor(destra2);
      end;
    end
  else
    begin
    end;
  end;

if (lato1<>0) and (lato2<>0) then
  begin
  lato1:=lato1+2;
  if lato1>4 then lato1:=lato1-4;
  end;
if lato1=lato2 then Dentro_l:=true;
end;

{-------}

Function distanza(x1,y1,x2,y2:real):real;
begin
distanza:=sqrt(sqr(x2-x1)+sqr(y2-y1));
end;

begin

{initdeb;}

Max_x:=px+box;
Max_Y:=py+box;
Min_X:=px-box;
Min_Y:=py-box;
troppi:=false;
M_Line:=0;
Osnap_p:=false;
Os_temp:=false;
Max_Line:=10;


Dentro_p:=false;

if exist(Pianta+'.dlt')then
begin
  assign(fdis1,Pianta+'.dlt' );
  reset(Fdis1);
  while (not eof(fdis1))and(not(troppi))do
  BEGIN
  READ(FDIS1,HPGL);

  for i:=1 to nhpgl do
    begin
    dentro_c:=dentro1(HPGL[i]);
      if not(HPGL[i].mov)  then
        begin

        if ((dentro_p) and (dentro_c)) then

        if dentro_L(HPGL[i],X_pr,Y_Pr) then

        if M_line < Max_line then
          begin

          M_line:=M_line+1;
          with m_p[M_Line] do
            begin
            xm[1]:=x_pr;
            xm[2]:=hpgl[i].x;
            ym[1]:=y_pr;
            ym[2]:=hpgl[i].y;
            end;
          end
        else troppi:=true;
        end;
      Dentro_p:=dentro_c;
      X_pr:=hpgl[i].x;
      Y_pr:=hpgl[i].y;

      end;
    end;
  end;
  close(FDis1);

  if M_Line >=1 then
    begin
    case tipo of
    1:if M_line=1 then
      with m_p[1] do
        begin
        dist1 :=xm[1]-xm[2];
        dist1 :=sqr(dist1);
        dist2:=ym[1]-ym[2];
        dist2:=sqr(dist2);

        dist:=sqrt(dist1+dist2)/2;

        dist1 :=px-xm[1];
        dist1 :=sqr(dist1);
        dist2:=py-ym[1];
        dist2:=sqr(dist2);

        {with m_p[1] do linea(xm[1],ym[1],xm[2],ym[2]);}


        if sqrt(dist1+dist2) < dist then
          begin
          px:=m_p[1].xm[1];
          Py:=m_p[1].ym[1];
          end
        else
          begin
          px:=m_p[1].xm[2];
          Py:=m_p[1].ym[2];
          end;
        os_temp:=true;
        end;

    2,3:if M_line=1 then
        begin
        if tipo=2 then
        with m_p[1] do
          begin
          {linea(xm[1],ym[1],xm[2],ym[2]);}
          perp(dist1,dist2,xp1,yp1,xm[1],ym[1],xm[2],ym[2]);
          px:=round(dist1);
          py:=round(dist2);
          os_temp:=true;
          end;
        end
       else
        begin
        if distanza(m_p[1].xm[1],m_p[1].ym[1],m_p[2].xm[1],m_p[2].ym[1])>
           distanza(m_p[1].xm[1],m_p[1].ym[1],m_p[2].xm[2],m_p[2].ym[2])  then
        with m_p[1] do
          begin
          temp:=xm[1];
          xm[1]:=xm[2];
          xm[2]:=temp;
          temp:=ym[1];
          ym[1]:=ym[2];
          ym[2]:=temp;
          end;

        dist1:=(m_p[1].xm[1]+m_p[2].xm[1])/2;
        m_p[1].xm[1]:=round(dist1);
        dist1:=(m_p[1].ym[1]+m_p[2].ym[1])/2;
        m_p[1].ym[1]:=round(dist1);
        dist1:=(m_p[1].xm[2]+m_p[2].xm[2])/2;
        m_p[1].xm[2]:=round(dist1);
        dist1:=(m_p[1].ym[2]+m_p[2].ym[2])/2;
        m_p[1].ym[2]:=round(dist1);

        if tipo=3 then
          begin
          {write(chr(7));
          linea(xp1,yp1,xu1,yu1);
          deb('xp1:',xp1);
          deb('yp1:',yp1);
          deb('xp2:',xu1);
          deb('yp2:',yu1);}
          dist1:=(m_p[1].xm[1]+m_p[1].xm[2])/2;
          m_p[1].xm[1]:=round(dist1);
          dist1:=(m_p[1].ym[1]+m_p[1].ym[2])/2;
          m_p[1].ym[1]:=round(dist1);
          end;

        with m_p[1] do
          begin
          if tipo=2 then perp(dist1,dist2,xp1,yp1,xm[1],ym[1],xm[2],ym[2])
          else perp(dist1,dist2,xm[1],ym[1],xp1,yp1,xu1,yu1);
          px:=round(dist1);
          py:=round(dist2);
          os_temp:=true;
          end;
        end;

    end;

    end;


if os_temp then osnap_p:=true else write(chr(7));

end;


Function Osn(Var P_x,P_y:real;xp,yp,xu,yu:real;codice:integer):Boolean;

Var X_s,Y_s:integer;
    dimbox:real;
    trovato_p:boolean;
    tiposnap:integer;
    temp:real;

begin
{initdeb;}
{deb('xp:',xp);
deb('yp:',yp);
deb('xu:',xu);
deb('xu:',xu);}
if codice=11 then tiposnap:=1;
if codice=2  then tiposnap:=2;
if codice=7  then tiposnap:=3;
X_s:=round(P_x-22717);
Y_s:=round(P_y-17937);

if codice IN [2,7] then
  begin
  Xp:=round(xp-22717);
  Yp:=round(yp-17937);
  end;

if codice=7 then
  begin
  Xu:=round(xu-22717);
  Yu:=round(yu-17937);
  end;


if sezione then DimBox:=ze(1)-ze(0)
else DimBox:=xe(1)-xe(0);
dimBox:=dimBox*5{C_DimBox};
trovato_p:=osnap_p(X_s,Y_s,Tiposnap,round(DimBox),Piantedrive+NomePianta,
                   xp,yp,xu,yu);
if Trovato_p then
  begin              {-- da completare nel caso di sezione --}
  P_x:=X_s+22717;
  P_y:=Y_s+17937;
  end;
Osn:=trovato_p;

{closedeb;}
end;



end.
