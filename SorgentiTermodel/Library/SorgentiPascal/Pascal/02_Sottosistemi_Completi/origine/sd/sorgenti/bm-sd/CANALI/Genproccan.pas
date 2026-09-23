

unit GENPROCcan;

Interface

uses
//halotp4,
//graph,
angoli,sysutils,
definiz,definizcan,funzbase,esiste,WM{,win_uti,controll}{$IFDEF WIN},main_res,def_win{$ENDIF};


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
Function T_Col(Scolore:string):integer;
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
result:=true;
//  isflag:=(dis^[i]^.flag and sezione) or
//          ((not sezione) and (risultcalc^.quota=dis^[i]^.z1))

end;



{***************************  Clip            *******************************}

Procedure Clip(NClip:integer);

var r1,r2,r3,r4:real;

begin
r1:=0;r2:=0;r3:=1000;r4:=750;
Case NClip of
1:;
end;
//SetClip(@r1,@r2,@r3,@r4);
end;


{***************************  SNAP   **************************************}

procedure msnap(var xs,ys:real;display:boolean);
var i,rapp:integer;
    gridx,gridy,xsmin,xsmax,ysmin,ysmax,xcor,ycor,zeff,xs1:real;
    visual,stx,sty,stz:string;


begin

end;


{***************************  Filo           *******************************}

Procedure Filo(Nfilo:integer);

var  r1,r2:real;
     i:integer;

begin

end;

{***************************  Filo1           *******************************}

Procedure Filo1(Nfilo:integer);

var  r1,r2:real;
     i:integer;

begin

end;

{***************************  Col             *******************************}

Function T_Col(Scolore:string):integer;
var colore:integer;
begin
colore:=strtoint(Scolore);
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

end;

{***************************  SetLColor1      *******************************}

Procedure SetLColor1(i:integer);

Var cl:integer;
begin
end;

{***************************  Marca           *******************************}

Procedure Marca(tr,col:integer;segna:boolean);

var i:integer;


begin
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
  //write(chr(7));
  //richiesta('');
  //st1:='';
  //str((lungdis-ultriga),st1);
  //richiesta(W_M(103)+' '+st1+' '+W_M(104));
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
  //write(chr(7));
  //richiesta('');
  //st1:='';
  //str((lungdati-ulttronco),st1);
  //richiesta(W_M(103)+' '+st1+' '+W_M(105));
  { Attenzione ! Potete disegnare ancora }  { TRONCHI }
  end;

end;

{****************************** NewPezzo *************************************}

Function NewPezzo:integer;
var i:integer;
Begin
inc(ultpezzo);
if ultpezzo>lungpezzi then Newpezzo:=0
else
  begin
  newpezzo:=ultpezzo;
  new(Vpezzi^[ultpezzo]);
  Vpezzi^[ultpezzo].indpezzo:=0;
  end;
(*
i:=1;
while (i<UltPezzo)and(VPezzi^[i]^.Codice<>'') do i:=i+1;
if (i>=UltPezzo){and(VPezzi^[i]^.Codice<>'') }then
  begin

  if i<lungPezzi then

    begin
    //i:=i+1;
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
  //write(chr(7));
  //richiesta('');
  //st1:='';
  //str((lungPezzi-ultPezzo),st1);
  //richiesta(W_M(106)+' '+st1+' '+W_M(107));
  {'Attenzione ! Potete inserire ancora }{ pezzi');}
  end
*)
end;


{****************************** InitPezzi ***********************************}

procedure initPezzo(var recp:recpezzi);


begin
with recp do
  begin
  Codice:='  ';
  R:=50;
  A:=400;
  B:=400;
  Flag:='';
  Lung:=0;
  Ang:=0;
  Rag:=0.5;
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
//if not sezione then Ze:=RisultCalc^.Quota else
//  ZE:=Zinf+((Zsup-Zinf)/750)*(Y-40)
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