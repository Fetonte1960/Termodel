

unit genproc;

Interface

uses
halotp4,
graph,angoli,
definiz,funzbase,esiste,WM,win_uti,controll{$IFDEF WIN},main_res,def_win{$ENDIF};


procedure msnap(var xs,ys:real;display:boolean);
Function NewRiga:integer;
Function NewTR:integer;
Function NewPezzo:integer;
procedure initPezzo(var recp:recpezzi);
procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr:real);
Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);
Procedure Isocur(xwd1,ywd1:real;modo:integer);
Function Xg1(x,y:real):real;
Function Yg1(y,z:real):real;
Function XE(x:real):real;
Function YE(X,Y:real):real;
Function Ze(Y:real):real;
Function Xg(x,y:real):real;
Function Yg(y,z:real):real;
Procedure TRetino(var xi,yi:real;Spezza:boolean);
Procedure Marca(tr,col:integer;segna:boolean);
Procedure SetLColor(i:integer);
Function T_Col(colore:integer):integer;
Function V_Col(i:integer):integer;
Procedure SetLColor1(i:integer);
Procedure Filo(Nfilo:integer);
Procedure Filo1(Nfilo:integer);
Procedure Fat_er(mess:string;grafica:boolean);
Function NuovoPezzo(tr,IndTr:integer):string;
function isflag(i:integer):boolean;
procedure calc3d(var x3d,y3d:real;xf,yf,zf:real);
Procedure Ucs(xo,yo,ing:real);

Implementation
{$ifdef win}
uses multilin;
{$endif}
{***************************  Fat_er     *****************************}

Procedure Ucs(xo,yo,ing:real);
const rot=0;
var ingtext:real;
    rot_text:integer;
    st1:string;
begin

{$ifdef win}
if num_win>1 then ing:=2*ing;
{$endif}


real1:=0.2;real2:=1;
ModiCord1(real1,real2,xo,yo,rot,ing);
movabs1(@real1,@real2);

real1:=0.8;real2:=1;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0.8;real2:=3;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=1;real2:=3;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);


real1:=0.5;real2:=3.5;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0;real2:=3;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0.2;real2:=3;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0.2;real2:=1;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);
{------------}
real1:=2;real2:=1;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);


real1:=2;real2:=0.8;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=2.5;real2:=1.3;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=2;real2:=1.8;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=2;real2:=1.6;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0.2;real2:=1.6;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0.35;real2:=2.5;
ModiCord1(real1,real2,xo,yo,rot,ing);
movabs1(@real1,@real2);
{$ifdef dos}
int1:=AngText(Rot);
IngText:=Ing*iny*0.85;
setstext(@ingText,@real2,@int1);
{$else}
IngText:=ing*iny*0.5;
real1:=2*pi-rot;
rot_text:=round(real1*180/Pi)*10;
INT2:=round(ingtext);
if int2 < 1 then int2:=1;
if not multi_w then settatesto2(Rot_text,int2);
ton:=true;
{$endif}

if sezione then st1:='Z' else st1:='Y';
stext(@st1);

if sezione then
begin
real1:=1.2;real2:=1.1;
ModiCord1(real1,real2,xo,yo,rot,ing);
movabs1(@real1,@real2);
end
else
begin
real1:=1.5;real2:=1.15;
ModiCord1(real1,real2,xo,yo,rot,ing);
movabs1(@real1,@real2);
end;


if sezione then st1:='XY' else st1:='X';
stext(@st1);


end;

Procedure Fat_er(mess:string;grafica:boolean);

begin
(*
 {$ifdef win}
 {$else}

 if grafica then CloseGraphics;

 {$endif}

 clrscr;
 gotoXy(5,10);
 write(Mess);
 repeat until keypressed;
 halt;
 *)
end;

{**************************  calc3d    *****************************************}

procedure calc3d(var x3d,y3d:real;xf,yf,zf:real);
begin
end;




function isflag(i:integer):boolean;

begin
  isflag:=(dis^[i]^.flag and sezione) or
          ((not sezione) and (risultcalc^.quota=dis^[i]^.z1))

end;



{***************************  Clip            *******************************}

Procedure Clip(NClip:integer);

var r1,r2,r3,r4:real;

begin
r1:=0;r2:=0;r3:=1000;r4:=750;
Case NClip of
1:;
end;
SetClip(@r1,@r2,@r3,@r4);
end;


{***************************  SNAP   **************************************}

procedure msnap(var xs,ys:real;display:boolean);
var i,rapp:integer;
    gridx,gridy,xsmin,xsmax,ysmin,ysmax,xcor,ycor,zeff,xs1:real;
    visual,stx,sty,stz:string;


begin
  if (conf^.rsnap<>0) then
  begin
  xs1:=xs;
  xs:=xe(xs);
  Zeff:=ze(ys);
  ys:=ye(xs1,ys);

  gridx:=conf^.rsnap*40000/conf^.altnum;
  xs:=round(xs/gridx)*gridx;
  ys:=round(ys/gridx)*gridx;
  if sezione then Zeff:=round(Zeff/gridx)*gridx;

  str(xs*(conf^.AltNum/40000):4:2,stx);
  str(ys*(conf^.AltNum/40000):4:2,sty);
  str(Zeff*(conf^.AltNum/40000):4:2,stz);

  stx:=format(stx,7);
  sty:=format(sty,7);
  stz:=format(stz,7);
  setclip(@minxw,@minyw,@maxxw,@maxyw);

  if display then

    begin

    write_cord(stx,sty,stz);
    int1:=7;int2:=0;
    settextclr(@int1,@int2);
    real1:=textwidth('x:');
    real2:=ysp-1;
    movtcurabs(@real1,@real2);
    {$ifdef dos}
    text1(@stx);
    {$endif}
    real1:=textwidth('x:       [m],y:');
    real2:=ysp-1;
    movtcurabs(@real1,@real2);
    {$ifdef dos}
    text1(@sty);
    {$endif}
    real1:=textwidth('x:       [m],y:       [m],z:');
    real2:=ysp-1;
    movtcurabs(@real1,@real2);
    {$ifdef dos}
    text1(@stz);
    {$endif}
    end;

  xs:=xg(xs,ys);
  ys:=yg(ys,Zeff);

  end;
end;


{***************************  Filo           *******************************}

Procedure Filo(Nfilo:integer);

var  r1,r2:real;
     i:integer;

begin
{$Ifdef Win}
{$Else}
Clip(0);
i:=0;
SetXor(@i);
i:=0;
SetColor(i);
r1:=XFilo;r2:=YFilo;
MovAbs1(@r1,@r2);
r1:=2;
Cir(@R1);

i:=8;
Setcolor(i);

r1:=920;r2:=50;
MovAbs1(@r1,@r2);
r1:=990;r2:=50;
LnAbs1(@r1,@r2);
r1:=990;r2:=120;
LnAbs1(@r1,@r2);
r1:=920;r2:=120;
LnAbs1(@r1,@r2);
r1:=920;r2:=50;
LnAbs1(@r1,@r2);
r1:=955;r2:=85;
MovAbs1(@r1,@r2);
r1:=20;
cir(@r1);
  Case Nfilo of
  1,4,7:r1:=955;
  2,5,8:r1:=990;
  3,6,9:r1:=920;
  end;
  Case Nfilo of
  1,2,3:r2:=85;
  4,5,6:r2:=50;
  7,8,9:r2:=120;
  end;

xfilo:=r1;
YFilo:=r2;

MovAbs1(@r1,@r2);
int1:=14;
SetColor(int1);
r1:=2;
Cir(@r1);
{$endif}
end;

{***************************  Filo1           *******************************}

Procedure Filo1(Nfilo:integer);

var  r1,r2:real;
     i:integer;

begin
{$Ifdef Win}
{$Else}
Clip(0);
i:=0;
SetXor(@i);
i:=0;
SetColor(i);
r1:=XFilo;r2:=YFilo;
MovAbs1(@r1,@r2);
r1:=2;
Cir(@R1);

  Case Nfilo of
  1,4,7:r1:=955;
  2,5,8:r1:=990;
  3,6,9:r1:=920;
  end;
  Case Nfilo of
  1,2,3:r2:=85;
  4,5,6:r2:=50;
  7,8,9:r2:=120;
  end;

xfilo:=r1;
YFilo:=r2;

MovAbs1(@r1,@r2);
int1:=14;
SetColor(int1);
r1:=2;
Cir(@r1);
{$endif}
end;

{***************************  Col             *******************************}

Function T_Col(colore:integer):integer;

begin
T_col:=15;
if sezione then
  begin
    case colore of
    1,2,3:T_Col:=15;
    4,5,6:T_Col:=14;
    7,8,9:T_Col:=4;
    end;
  end
else
  begin
    case colore of
    1,4,7:T_Col:=15;
    2,5,8:T_Col:=14;
    3,6,9:T_Col:=4;
    end;
  end
end;

{***************************  V_Col           *******************************}

Function V_Col(i:integer):integer;

begin
V_col:=T_Col(Dis^[i]^.Color);
end;

{***************************  SetLColor        *******************************}

Procedure SetLColor(i:integer);

Var cl1:integer;

begin
Cl1:=T_Col(Dis^[i]^.Color);
{writeln(lst,'ind:',i,' cl:',cl1);}
SetColor(cl1);
end;

{***************************  SetLColor1      *******************************}

Procedure SetLColor1(i:integer);

Var cl:integer;
begin
Cl:=T_Col(i);
SetColor(cl);
end;

{***************************  Marca           *******************************}

Procedure Marca(tr,col:integer;segna:boolean);

var i:integer;


begin
{$ifdef win}
multi_w:=true;
{$endif}
i:=dati^[tr]^.ti;
  while i<>0 do
    begin
    case dis^[i]^.entita[1] of
    'L':begin

          setlnstyle(@dis^[i]^.tlinea);
          if col=0 then setLcolor(i)
          else setcolor(col);
          if segna then dis^[i]^.flag:=true;
          real1:=xg(dis^[i]^.x1,dis^[i]^.y1);
          real2:=yg(dis^[i]^.y1,dis^[i]^.z1);
          movabs1(@real1,@real2);
          real1:=xg(dis^[i]^.x2,dis^[i]^.y2);
          real2:=yg(dis^[i]^.y2,dis^[i]^.z2);
          lnabs1(@real1,@real2);
          {$ifdef win}
           multi_line(i);
          {$endif}
        end;
    end;

    if dis^[i]^.entita='T' then i:=0 else i:=dis^[i]^.nlinea;

    end;
{$ifdef win}
multi_w:=false;
{$endif}
end;


{****************************** NewRiga ***********************************}

Function NewRiga:integer;

var i:integer;

Begin

i:=1;
while (i<Ultriga)and(dis^[i]^.entita<>'') do i:=i+1;


if (i=Ultriga)and(dis^[i]^.entita<>'') then

  begin

  if {i<lungdis}true then

    begin
    i:=i+1;
    Ultriga:=Ultriga+1;
    if dis^[i]=nil then new(dis^[i]);
    dis^[i]^.entita:='';
    NewRiga:=i;
    end

  else

    begin
    NewRiga:=0;
    PieniT:=true;
    end;

  end

else
begin
  NewRiga:=i;
end;

if (i=Ultriga)and(Lungdis-ultriga<=20) then
  begin
  write(chr(7));
  richiesta('');
  st1:='';
  str((lungdis-ultriga),st1);
  richiesta(W_M(103)+' '+st1+' '+W_M(104));
  {'Attenzione ! Potete disegnare ancora '}  {' elementi')}
  end

end;


{****************************** NewTr *************************************}

Function NewTR:integer;
var i:integer;
Begin
i:=1;
while (i<Ulttronco)and(dati^[i]^.TI<>0) do
                                          i:=i+1;
if (i=Ulttronco)and(dati^[i]^.Ti<>0) then

  begin

  if {i<lungdati}true then

    begin
    i:=i+1;
    UltTronco:=UltTronco+1;
    if Dati^[i]=Nil then new(dati^[i]);
    dati^[i]^.ti:=0;
    NewTr:=i;
    end

  else

    begin
    NewTr:=0;
    PieniD:=true;
    end;

  end

else newtr:=i;

if (i=Ulttronco)and(Lungdati-ulttronco<=20) then
  begin
  write(chr(7));
  richiesta('');
  st1:='';
  str((lungdati-ulttronco),st1);
  richiesta(W_M(103)+' '+st1+' '+W_M(105));
  { Attenzione ! Potete disegnare ancora }  { TRONCHI }
  end;

end;

{****************************** NewPezzo *************************************}

Function NewPezzo:integer;
var i:integer;
Begin
i:=1;
while (i<UltPezzo)and(VPezzi^[i]^.Codice<>'') do i:=i+1;
if (i=UltPezzo)and(VPezzi^[i]^.Codice<>'') then

  begin

  if {i<lungPezzi}true then

    begin
    i:=i+1;
    UltPezzo:=UltPezzo+1;
    if VPezzi^[i]=nil then new(VPezzi^[i]);
    VPezzi^[i]^.Codice:='';
    NewPezzo:=i;
    end

  else

    begin
    NewPezzo:=0;
    PieniP:=true;
    end;

  end

else newPezzo:=i;

if (i=UltPezzo)and(LungPezzi-ultPezzo<=20) then
  begin
  write(chr(7));
  richiesta('');
  st1:='';
  str((lungPezzi-ultPezzo),st1);
  richiesta(W_M(106)+' '+st1+' '+W_M(107));
  {'Attenzione ! Potete inserire ancora }{ pezzi');}
  end

end;


{****************************** InitPezzi ***********************************}

procedure initPezzo(var recp:recpezzi);


begin
with recp do
  begin
  Codice:='  ';
  R:=0;
  A:=0;
  B:=0;
  Flag:='';
  Lung:=0;
  Ang:=0;
  Rag:=0;
  Perd:=0;
  port:=0;
  varie:=0;
  end;
  {$ifdef newcr}
  fillchar(recp.TabDescr,sizeof(recp.TabDescr),0);
  {$endif}
end;


{*************************** RETTA   **************************************}

procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr:real);
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
{************************** ISOCUR *****************************************}
     {-- Modo
         1--> sposta cursore
         2--> cancella cusore  --}

Procedure Isocur(xwd1,ywd1:real;modo:integer);
var i,x,y:integer;

begin
{$ifdef win}
if not multi_w then
{$endif}
  begin
  setclip(@xw1,@yw1,@xw2,@yw2);
  int1:=1;
  setlnstyle(@int1);
  setxor(@int1);
  if iso then
  begin
    real1:=oldy+1600;
    real2:=oldy-1600;
    movabs1(@oldx,@real1);
    lnabs1(@oldx,@real2);
    real1:=oldx+1600;
    real2:=oldx-1600;
    movabs1(@real1,@oldy);
    lnabs1(@real2,@oldy);
    iso:=false;
  end;

  if modo = 1 then
  begin
    real1:=ywd1+1600;
    real2:=ywd1-1600;
    movabs1(@xwd1,@real1);
    lnabs1(@xwd1,@real2);
    real1:=xwd1+1600;
    real2:=xwd1-1600;
    movabs1(@real1,@ywd1);
    lnabs1(@real2,@ywd1);
    oldx:=xwd1;oldy:=ywd1;
    direzprec:=direz;
    iso:=true;
  end;
  int1:=0;
  setxor(@int1);
  setlnstyle(@conf^.tlinea);
  movabs1(@xp,@yp);
  end;
end;

{************************** Xe    *****************************************}
Function XE(x:real):real;
begin
  XE:=Xinf+((Xsup-Xinf)/1000)*x
end;

{************************** Ye    *****************************************}
Function YE(X,Y:real):real;
begin
  if not sezione then
  YE:=Yinf+((Ysup-Yinf)/750)*(Y-40)
  else
  YE:=Yinf+((Ysup-Yinf)/1000)*X
end;

{************************** Ze    *****************************************}
Function Ze(Y:real):real;
begin
if not sezione then Ze:=RisultCalc^.Quota else
  ZE:=Zinf+((Zsup-Zinf)/750)*(Y-40)
end;

{************************** Xg    *****************************************}
Function Xg(x,y:real):real;
begin
  if abs(xsup-xinf)<10 then
  Xg:=(y-yinf)*1000./(ysup-yinf)
  else
  Xg:=(x-Xinf)*1000./(xsup-xinf);
end;
{************************** Yg    *****************************************}
Function Yg(y,z:real):real;
begin
  if not sezione then
  Yg:=(Y-Yinf)*750./(Ysup-Yinf)+40
  else
  Yg:=(Z-Zinf)*750./(Zsup-Zinf)+40;
end;


{************************** Xg1    *****************************************}
Function Xg1(x,y:real):real;
var xsp1:real;
begin
  xsp1:=xsp;
  if abs(xsup-xinf)<1E-4{-10 cippo} then
  Xg1:=(y-yinf)*xsp1/(ysup-yinf)
  else
  Xg1:=(x-Xinf)*xsp1/(xsup-xinf);
end;
{************************** Yg1    *****************************************}
Function Yg1(y,z:real):real;
var ysp1:real;
begin
  ysp1:=ysp;
  if not sezione then
  Yg1:=ysp1-(Y-Yinf)*ysp1/(Ysup-Yinf)-s_up
  else
  Yg1:=ysp1-(Z-Zinf)*ysp1/(Zsup-Zinf)-s_up;
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

{************************** RETINO *****************************************}
Procedure TRetino(var xi,yi:real;Spezza:boolean);
var ang,dist,dist1:real;
    ang1,ang2:real;
    snap1:real;
    diff :real;
    angar:real;
    negativo:boolean;
    gradi,StZeta:string;
    gradiprec:string;
    STdist   :string;
    xp1,yp1,zp1,zi:real;
    dist2,Quota1,xin,yin:real;
    st1a,st2a,st3a:string;
    tratto_salv:integer;

begin
  tratto_salv:=trattosel;
  xin:=xi;
  yin:=yi;
  dist:=sqrt(sqr(xi-xp)+sqr(yi-yp));
  if yi=yp then
    begin
    if xi>=xp then ang:=pi/2 else ang:=(3/2)*pi;
    end
  else
    begin
    if yi>yp then
      begin
      ang:=arctan((xi-xp)/abs(yi-yp));
      end
    else
    ang:=(pi-arctan((xi-xp)/abs(yi-yp)));
    end;

  if trattosel<>0 then {-- trattosel in sezione --}
  with Dis^[Trattosel]^ do
  if (xg(x2,y2)=xg(x1,y1))and(yg(y2,z2)=yg(y1,z1)) then {trattosel:=0} tratto_salv:=0;

  if (vuoto)OR({Trattosel=0}tratto_salv=0) then
    begin

    if SnapAng then
      begin
      ang1:=round(ang/(pi/2));
      ang:=(pi/2)*ang1;
      end;

    angar:=0;
    end
  else
    begin

    with dis^[trattosel]^ do
    if yg(y2,z2)=yg(y1,z1) then
      begin
      if xg(x2,y2)>=xg(x1,y1) then angar:=pi/2 else angar:=(3/2)*pi;
      end
    else
      begin
      if yg(y2,z2)>yg(y1,z1) then
        begin
        angar:=arctan((xg(x2,y2)-xg(x1,y1))/abs(yg(y2,z2)-yg(y1,z1)));
        end
      else
      angar:=(pi-arctan((xg(x2,y2)-xg(x1,y1))/abs(yg(y2,z2)-yg(y1,z1))));
      end;

    if angar<0 then angar:=2*pi+angar;
    if ang<0 then ang:=2*pi+ang;


    ang:=ang-angar;

    if ang>pi then ang:=-(2*pi-ang);
    if ang<-pi then ang:=(2*pi+ang);

    negativo:=false;
    if ang<0 then
      begin
      negativo:=true;
      ang:=-ang
      end;

    if SnapAng then
      begin

      ang1:=pi/9;
      diff:=abs(ang-ang1);
      if abs(ang-pi/12)<diff then
        begin
        ang1:=pi/12;
        diff:=abs(ang-ang1);
        end;
      if abs(ang)<diff then
        begin
        ang1:=0;
        diff:=abs(ang-ang1);
        end;
      if abs(ang-pi/6)<diff then
        begin
        ang1:=pi/6;
        diff:=abs(ang-ang1);
        end;
      if abs(ang-pi/4)<diff then
        begin
        ang1:=pi/4;
        diff:=abs(ang-ang1);
        end;
      if abs(ang-pi/3)<diff then
        begin
        ang1:=pi/3;
        diff:=abs(ang-ang1);
        end;
      if abs(ang-5*pi/12)<diff then
        begin
        ang1:=5*pi/12;
        diff:=abs(ang-ang1);
        end;
      if abs(ang-pi/2)<diff then
        begin
        ang1:=pi/2;
        diff:=abs(ang-ang1);
        end;

      ang:=ang1;
      end
    else
      begin
        if ang>pi/2 then ang:=pi/2;
      end;
    if snapang then
    if ang=pi/2 then dist:=dist*cos(diff);
    if negativo then ang:=-ang;
    end;

  if spezza then ang:=0;

  snap1:=conf^.rsnap*40000/conf^.altnum;
  quota1:=RisultCalc^.Quota*40000/conf^.altnum;

  ang2:=angar+ang;
  xi:=xp+dist*sin(ang2);
  yi:=yp+dist*cos(ang2);

  if not vuoto then
  begin
    if (ug(ang,pi/2,1) or ug(ang,-pi/2,1)) and (ug(angar,0,1)  or ug(angar,pi,1)) then
    begin
      if xi>xin then xi:=xin;
      if xi<xin then xi:=xin;
    end;

    if (ug(ang,pi/2,1) or ug(ang,-pi/2,1)) and (ug(angar,pi/2,1)  or ug(angar,(3/2)*pi,1)) then
    begin
      if yi>xin then yi:=yin;
      if yi<xin then yi:=yin;
    end;
  end;


  if  not sezione then dist1:=xe(dist)-xe(0)
  else dist1:=ze(dist)-ze(0);

  if (snap1<>0)and(SnapAng) then
    begin
    if sezione then
      begin
      zi:=ze(yi);
      yi:=ye(xi,yi);
      xi:=xe(xi);
      xp1:=xe(xp);
      yp1:=ye(xp,yp);
      zp1:=ze(yp);

      if ((snapz)or((abs(yi-yp1)<10E-6)and(abs(xi-xp1)<10E-6)))and
         (abs(zi-zp1)>10E-6) then
        begin
        zi:=round(zi/snap1)*snap1;
        dist1:=abs((zi-zp1)/cos(ang2));
        dist2:=abs(yg(0,dist1)-yg(0,0));
        yi:=yg(0,zi);
        xi:=xp+dist2*sin(ang2);
        end

      else

        begin
        if (abs(yi-yp1)>Snap1)or(abs(xi-xp1)>=snap1) then
          begin
          if ((snapx)or(abs(ysup-yinf)<snap1))and(abs(xsup-xinf)>=snap1) then
            begin
            xi:=round(xi/snap1)*snap1;
            xi:=xg(xi,yi);
            dist2:=abs((xi-xp)/sin(ang2));
            dist1:=abs(ze(dist2)-ze(0));
            yi:=yp+dist2*cos(ang2);
            end
          else
            begin
            yi:=round(yi/snap1)*snap1;
            xi:=(yi-yinf)*1000/(ysup-yinf);
            dist2:=abs((xi-xp)/sin(ang2));
            dist1:=abs(ze(dist2)-ze(0));
            yi:=yp+dist2*cos(ang2);
            end
          end

        else

          begin
          xi:=xp;
          yi:=yp;
          dist1:=0;
          end

        end;

      end

    else

      begin
      yi:=ye(xi,yi);
      xi:=xe(xi);
      xp1:=xe(xp);
      yp1:=ye(xp,yp);


      if ((snapx)or(abs(yi-yp1)<snap1))and(abs(xi-xp1)>=snap1) then
        begin
        xi:=round(xi/snap1)*snap1;
        dist1:=abs((xi-xp1)/sin(ang2));
        yi:=yp1+dist1*cos(ang2);
        end
      else
        begin
        if abs(yi-yp1)>=snap1 then
          begin
          yi:=round(yi/snap1)*snap1;
          dist1:=abs((yi-yp1)/cos(ang2));
          xi:=xp1+dist1*sin(ang2);
          end
        else
          begin
          xi:=xp1;
          yi:=yp1;
          dist1:=0;
          end
        end;
      xi:=xg(xi,0);
      yi:=yg(yi,0);
      end;
    end
  else
    begin
    if Snap1<>0 then
      begin
      MSnap(Xi,Yi,false);
      dist:=sqrt(sqr(Xi-Xp)+sqr(Yi-Yp));
      if  not sezione then dist1:=xe(dist)-xe(0)
      else dist1:=ze(dist)-ze(0);
      end;
    end;

  str(ang*180/pi:3:0,gradi);
  str(dist1*(conf^.AltNum/40000):6:2,stdist);
  stdist:=format(stdist,7);
  GRADI:=format(GRADI,3);
  Write_lung(StDist,gradi);
  st2a:=W_M(109);
   {'Ang: -90[Deg] Lung.: 000.00 [m]0000';}

  setclip(@minxw,@minyw,@maxxw,@maxyw);

  int1:=7;int2:=0;
  settextclr(@int1,@int2);
  st1a:=W_M(110); {'Ang: ';}

  real1:=textWidth(W_M(110)); {'Ang: ';}
  real2:=ysp-1;
  movtcurabs(@real1,@real2);
  {$ifdef dos}
  Text1(@gradi);

  st1a:='.                  .';
  real1:=textwidth(st1a);
  movtcurabs(@real1,@real2);
  Text1(@Stdist);
  {$endif}
  if sezione then
    begin
    str(ze(yi)*conf^.altnum/40000:6:2,stzeta);
    stzeta:=format(stzeta,6);
    st1a:='.                                 .';
    real1:=textwidth(st1a);
    movtcurabs(@real1,@real2);
    {$ifdef dos}Text1(@Stzeta);{$endif}
    Write_cord(' ',' ',StZeta);
    end;


end;


{***************************  NuovoPezzo     *****************************}

Function NuovoPezzo(tr,IndTr:integer):string;

begin
NuovoPezzo:='';

if IndTr>PezziTr then NuovoPezzo:=W_M(111) {'Troppi pezzi sullo stesso tronco'}
else
  begin
  if Dati^[tr]^.Pezzi[IndTr]=0 then Dati^[tr]^.Pezzi[IndTr]:=NewPezzo;
  if Dati^[tr]^.Pezzi[IndTr]=0 then NuoVoPezzo:=W_M(112) { Impossibile inserire nuovi pezzi}
  end;
end;


end.