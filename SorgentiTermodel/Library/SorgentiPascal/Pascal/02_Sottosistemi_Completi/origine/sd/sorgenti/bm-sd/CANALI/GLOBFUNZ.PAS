{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{F+}

unit globfunz;

INTERFACE

uses crt,dos,definiz,gruti;


PROCEDURE INIT_mont;
PROCEDURE TRANSFER_mont(FileName:ST80;Modo:CHAR);
procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr:real);
Procedure Isocur(xwd1,ywd1:real;modo:integer);
Function XE(x:real):real;
Function YE(Y:real):real;
Function Xg(x:real):real;
Function Yg(Y:real):real;
Procedure LoadDis(nomedis:string);
Procedure TRetino(var xi,yi:real);
Procedure richiesta(rich:st80);
Function readcom(dato,def:string;stpos:integer):string;
procedure msnap(var xs,ys:real);
procedure readcord(var x,y:real;var code,uscita:integer;var st:string;cod:integer);
{---------------------------------------------------------------------------}
implementation

{$I halotp4.p}

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

  int1:=1;
  setlnstyle(@int1);
  setxor(@int1);
  if iso then
  begin
    if (direzprec=1)or(direzprec=2) then
    begin
      real1:=oldy+800;
      real2:=oldy-800;
      movabs(@oldx,@real1);
      lnabs(@oldx,@real2);
    end;
    if (direzprec=0)or(direzprec=2) then
    begin
      real1:=oldy+800*cos(pi/3);
      real2:=oldy-800*cos(pi/3);
      real3:=oldx+800*sin(pi/3);
      real4:=oldx-800*sin(pi/3);
      movabs(@real3,@real1);
      lnabs(@real4,@real2);
    end;
    if (direzprec=1)or(direzprec=0) then
    begin
      real1:=oldy+800*cos(2*pi/3);
      real2:=oldy-800*cos(2*pi/3);
      real3:=oldx+800*sin(2*pi/3);
      real4:=oldx-800*sin(2*pi/3);
      movabs(@real3,@real1);
      lnabs(@real4,@real2);
    end;
    iso:=false;
  end;
  if modo = 1 then
  begin
    if (direz=1)or(direz=2) then
    begin
      real1:=ywd1+800;
      real2:=ywd1-800;
      movabs(@xwd1,@real1);
      lnabs(@xwd1,@real2);
    end;
    if (direz=0)or(direz=2) then
    begin
      real1:=ywd1+800*cos(pi/3);
      real2:=ywd1-800*cos(pi/3);
      real3:=xwd1+800*sin(pi/3);
      real4:=xwd1-800*sin(pi/3);
      movabs(@real3,@real1);
      lnabs(@real4,@real2);
    end;
    if (direz=1)or(direz=0) then
    begin
      real1:=ywd1+800*cos(2*pi/3);
      real2:=ywd1-800*cos(2*pi/3);
      real3:=xwd1+800*sin(2*pi/3);
      real4:=xwd1-800*sin(2*pi/3);
      movabs(@real3,@real1);
      lnabs(@real4,@real2);
    end;
    oldx:=xwd1;oldy:=ywd1;
    direzprec:=direz;
    iso:=true;
  end;
  int1:=0;
  setxor(@int1);
  setlnstyle(@conf.tlinea);
  movabs(@xp,@yp);
end;

{************************** Xe    *****************************************}
Function XE(x:real):real;
begin
  XE:=Xinf+((Xsup-Xinf)/1000)*x
end;
{************************** Ye    *****************************************}
Function YE(Y:real):real;
begin
  YE:=Yinf+((Ysup-Yinf)/750)*Y
end;
{************************** Xg    *****************************************}
Function Xg(x:real):real;
begin
  Xg:=(x-Xinf)*1000/(xsup-xinf)
end;
{************************** Yg    *****************************************}
Function Yg(Y:real):real;
begin
  Yg:=(Y-Yinf)*750/(Ysup-Yinf)
end;

{------------------------------ INIT_mont ---------------------------------}
PROCEDURE INIT_mont;
var i,j:integer;
BEGIN
  IF mont_D=NIL THEN NEW(mont_D);
  For i:=1 to Maxmont do
  WITH mont_D^[i] DO
    begin
    Cod      :='';
    TipTub   :='';
    CodTub   :='';
    LungTub  :=0;
    CodPerd1 :='';
    NumPerd1 :=0;
    CodPerd2 :='';
    NumPerd2 :=0;
    CodPerd3 :='';
    NumPerd3 :=0;
    end;

END;   { PROC.   INIT_mont }
{************************** TRANSFER_mont    *****************************************}
PROCEDURE TRANSFER_mont(FileName:ST80;Modo:CHAR);

VAR
  Fl:FILE OF Recmont;
  I,IOERR:INTEGER;
BEGIN
  Modo:=UpCase(Modo);
  if exist(filename) then;
  begin
    ASSIGN(Fl,FileName);
      RESET(Fl);
      IOERR:=IOresult;
      I:=0;
      WHILE  not(EOF(Fl))  DO
      BEGIN
        I:=I+1;
        READ(Fl,mont_D^[I]);
      END;
      close(Fl);
   end;
END;  { PROC. TRANSFER_mont }


{************************** LOADDIS*****************************************}
Procedure LoadDis(nomedis:string);
var i:integer;

procedure initconf;

begin
  with conf do
  begin
    codTub:='ASTM';
    Rcolore:=15;
    CodTe:='TEE90';
    Tlinea:=1;
    codmont:='';
    CodCurve:='CU90';
    griglia :=20;
    Rsnap:=20;
    Terminale:=1;
    altnum:=13;
    numdia:='N';

  end;
end;

procedure InitRis;

begin
  with RisulTCalc do
  begin
    Origine:=0;
    Portata:=0;
    Perdita:=0;
    Sbil   :=0;
    Sfavor :=0;
  end;
end;



begin
write(Nomedis);
Ultriga:=1;
  if exist(nomedis+'.ret') then
  begin
    i:=1;
    assign(fi,nomedis+'.ret');reset(fi);
    while not(eof(fi)) and (i<=lungdis) do
    begin
      read(fi,dis^[i]);
      i:=i+1;
    end;
    UltRiga:=i-1;
    close(fi);
  end
  else
  begin
  Ultriga:=1;
  dis^[Ultriga].entita:='';
  end;

Nrighe:=Ultriga;

UltTronco:=1;
if exist(nomedis+'.dtr') then
  begin
  i:=1;
  assign(fr,nomedis+'.dtr');reset(fr);
  while not(eof(fr)) and (i<=lungDati) do
    begin
      read(fr,dati^[i]);
      i:=i+1;
    end;
    UltTronco:=i-1;
    close(fr);
  end
  else
    begin
    Ulttronco:=1;
    dati^[UltTronco].Ti:=0;
    end;

Ntronchi:=ultTronco;

UltGTerm:=1;
if exist(nomedis+'.ter') then
  begin
  i:=1;
  assign(fGT,nomedis+'.ter');reset(fgt);
  while not(eof(fgt)) and (i<=MaxGTErm) do
    begin
      read(fgt,GTerm^[i]);
      i:=i+1;
    end;
    UltGTerm:=i-1;
    close(fgt);
  end
  else
    begin
    UltGTerm:=1;
    GTerm^[UltGTerm].Cod:='';
    end;

NGTerm:=ultGTerm;

PieniT   :=false;
PieniD   :=false;
PieniTerm:=false;

if exist(nomedis+'.con') then
   begin
   assign(fconf,nomedis+'.con');
   reset(fconf);
   read(fconf,conf);
   close(fconf);
   end
else initconf;

if exist(nomedis+'.ris') then
   begin
   assign(frisult,nomedis+'.ris');
   reset(frisult);
   read(frisult,RisultCalc);
   close(FRisult);
   end
else initRis;

end;


{************************** RETINO *****************************************}
Procedure TRetino(var xi,yi:real);
var ang,dist:real;
    ang1:integer;
    snap1:real;
begin
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
  ang1:=round(ang/(pi/3));
  direzprec:=direz;
  direz:=ang1 mod 3;
  if direz=-1 then direz:=2;
  ang:=(pi/3)*ang1;
  snap1:=xg(conf.rsnap)-xg(0);
  if snap1<>0 then dist:=round(dist/snap1)*snap1;
  xi:=xp+dist*sin(ang);
  yi:=yp+dist*cos(ang);
end;

{************************** RICHIESTA ****************************************}

Procedure richiesta(rich:st80);

begin
  real1:=0;real2:=0;real3:=900;real4:=750;
  setclip(@real1,@real2,@real3,@real4);
  int1:=15;
  int2:=0;
  settextclr(@int1,@int2);
  if rich='' then rich:='                                                             ';
  real1:=1;real2:=15;
  MovTcurabs(@real1,@real2);
  text1(@rich);
  deltcur;
end;
{*************************** READCOM *************************************}
Function readcom(dato,def:string;stpos:integer):string;
var
   ldato:integer;
   exitchar:char;
   f       :boolean;
   startpos:integer;
   riga    :integer;
   xcar,ycar:real;
   st2,dato1:string;



begin
  setclip(@minxw,@minyw,@maxxw,@maxyw);
  if dato<>'' then
    begin
    dato1:=dato;
    if def<>'' then dato1:=dato1+' <'+def+'>';
    dato1:=dato1+':';
    richiesta(dato1);
    inqTcur(@xcar,@ycar,@int1);
    end
  else
    begin
    xcar:=1;
    ycar:=10;
    end;
  G_textcolor(15);
  G_textbackground(0);
  int1:=15;int2:=15;
  setstclr(@int1,@int2);
  startpos:=1;
  riga:=1;

  if dato<>'' then
  begin
    startpos:=1;
    dato:='';
    M_OFF;
    if def<>'' then dato1:=dato+' <'+def+'>';
    dato1:=dato+':';
    dato:=format(dato,20);
    dato:=LINE_INPUT(round(xcar),round(ycar),20,StartPos,' ',Dato,3,ExitChar,false,F,riga);
    if dato='' then dato:=def;
    readcom:=dato;
    M_ON;

  end
  else
    begin
    M_OFF;
    dato:=LINE_INPUT(round(xcar),round(ycar),20,StartPos,' ',Dato,3,ExitChar,false,F,riga);
    readcom:=dato;
    M_ON;
    end;
end;

{***************************  SNAP   **************************************}

procedure msnap(var xs,ys:real);
var i,rapp:integer;
    gridx,gridy,xsmin,xsmax,ysmin,ysmax,xcor,ycor:real;

begin
  if (conf.rsnap<>0) then
  begin
    xs:=xe(xs);
    ys:=ye(ys);
    gridx:=2*conf.rsnap*sin(pi/3);
    gridy:=conf.rsnap*0.5;
    xsmin:=trunc(limxi/gridx)*gridx;
    ysmin:=trunc(limyi/gridy)*gridy;
    xs:=xsmin+round((xs-xsmin)/gridx)*gridx;
    rapp:=round((ys-ysmin)/gridy);
    ys:=ysmin+rapp*gridy ;
    if rapp mod 2<>0 then {xs:=xs+gridx else} xs:=xs-(gridx/2);
    xs:=xg(xs);
    ys:=yg(ys);
  end;
end;

{************************** READCORD *****************************************}

procedure readcord(var x,y:real;var code,uscita:integer;var st:string;cod:integer);
var lung,i,indmin,primo:integer;
    min,xpr,ypr:real;
    entra,pr,trovato,trovato1:boolean;
    stx       :string;
    stpino    :string;
begin

  case cod of

  8:begin
    int1:=1;
    setxor(@int1);
    real1:=xg(conf.altnum)-xg(0);
    real2:=1;
    int1:=0;
    setstext(@real1,@real2,@int1);
    deltcur;
    stx:='';
    if upcase(conf.numdia[1])='N'then str(dati^[ntronco].num,stx)
    else
    if dati^[i].CodDiam<>''then stx:=dati^[ntronco].Coddiam;
    int1:=0;int2:=15;
    settextclr(@int1,@int2);
    movtcurabs(@x,@y);
    stext(@stx);
    xpr:=x;
    ypr:=y;
    end;

 end;

  pr:=true;
  lung:=length(st);
  stpino:=st;
  st:='';
  uscita:=0;
  code:=0;
  mousepres:=true;
  readlocator(@x,@y,@code);
  repeat
  if (m_attivo(x,y,code))or(pr) then
  begin
    pr:=false;
    if (x>900)and(cod=1) then
    begin
      delhcur;
      uscita:=gmenu;
      ultcom:=uscita;
    end
    else
    begin
      case cod of
           1:begin
             if code=130 then
               begin
               uscita:=ultcom;
               delay(200);
               end;
               msnap(x,y);
               movhcurabs(@x,@y); {procedura vaga}

             end;
             2:begin              {Procedura tronco}
                 delhcur;
                 if retino then Tretino(x,y);
                 int1:=8;
                 setcolor(@int1);
                 setclip(@xw1,@yw1,@xw2,@yw2);
                 rlnabs(@x,@y);
                 int1:=7;
                 setcolor(@int1);
                 isocur(x,y,1);
               end;
             3:begin {cancella}
                 delhcur;
                 int1:=8;
                 setcolor(@int1);
                 real1:=x-5;real2:=y-5;real3:=x+5;real4:=y+5;
                 rbox(@real1,@real2,@real3,@real4);
               end;
             4:begin  {zoom}
                 int1:=7;
                 setcolor(@int1);
                 rbox(@xp,@yp,@x,@y);
               end;
             5:begin  {Snap a nodo}
                 x:=xe(x);
                 y:=ye(y);
                 min:=10E6;
                 indmin:=1;
                 for i:=1 to ultriga do
                 with dis^[i] do
                 if (tronco >0)and(tronco<=ulttronco) then
                 if (entita='L') then
                   begin
                   entra:=false;
                   if nlinea=0 then entra:=true
                   else if dis^[nlinea].entita[1]<>'T' then entra:=true;
                   if entra then
                     begin
                     if abs(x-x2)+abs(y-y2)<min then
                       begin
                       if (xg(x2)>0)and(xg(x2)<900)and(yg(y2)>45)and(yg(y2)<700) then
                         begin
                         min:=abs(x-x2)+abs(y-y2);
                         indmin:=i;
                         end;
                       end;
                     end;
                   end;
                 x:=xg(dis^[indmin].x2);
                 y:=yg(dis^[indmin].y2);
                 movhcurabs(@x,@y);
                 Trattosel:=Indmin;
               end;

             6:begin  {Snap a terminale}
                 x:=xe(x);
                 y:=ye(y);
                 primo:=1;
                 while (dis^[primo].entita<>'T')and(primo<nrighe) do primo:=primo+1;
                 with dis^[primo] do min:=abs(x-x1)+abs(y-y1);
                 indmin:=primo;
                 for i:=1 to nrighe do
                 with dis^[i] do
                 if entita='T' then
                 begin
                   if abs(x-x1)+abs(y-y1)<min then
                   begin
                     if (xg(x1)>0)and(xg(x1)<900)and(yg(y1)>45)and(yg(y1)<700) then
                     begin
                       min:=abs(x-x1)+abs(y-y1);
                       indmin:=i;
                     end;
                   end;
                 end;
                 setclip(@xw1,@yw1,@xw2,@yw2);
                 x:=xg(dis^[indmin].x1);
                 y:=yg(dis^[indmin].y1);
                 movhcurabs(@x,@y);
                 Trattosel:=indmin;
               end;

             7:begin   {snap a tronco}
                 with dis^[Trattosel] do
                 begin
                   x:=xe(x);
                   y:=ye(y);
                   if abs(x2-x1)< 10E-6 then real1:=10E6
                   else real1:=(y2-y1)/(x2-x1);
                   if (real1<=1)and(real1>=-1) then
                   begin
                     if (x>x2)and(x2>=x1) then x:=x2;
                     if (x<x1)and(x2>=x1) then x:=x1;
                     if (x<x2)and(x1>=x2) then x:=x2;
                     if (x>x1)and(x1>=x2) then x:=x1;
                     y:=y1+(real1*(x-x1))
                   end
                   else
                   begin
                     if (y>y2)and(y2>=y1) then y:=y2;
                     if (y<y1)and(y2>=y1) then y:=y1;
                     if (y<y2)and(y1>=y2) then y:=y2;
                     if (y>y1)and(y1>=y2) then y:=y1;
                     x:=x1+(1/real1)*(y2-y1);
                   end;
                   x:=xg(x);
                   y:=yg(y);
                   isocur(x,y,1);
                 end;
               end;
             8:begin      {-- inserimento numero tronco --}

               movtcurabs(@xpr,@ypr);
               stext(@stx);
               xpr:=x;ypr:=y;
               movtcurabs(@x,@y);
               stext(@stx);
               deltcur;
               end;
             9:begin   {-----snap a terminale----}
               trovato1:=false;
                 x:=xe(x);
                 y:=ye(y);
                 min:=10E6;
                 indmin:=1;
                 for i:=1 to ultriga do
                 with dis^[i] do
                 if (tronco >0)and(tronco<=ulttronco) then

                 if (entita='L')and (nlinea=0)and(dati^[tronco].term=0)
                    and(dati^[tronco].pros[1]=0) then

                 begin
                   if abs(x-x2)+abs(y-y2)<min then
                   begin
                     if (xg(x2)>0)and(xg(x2)<900)and(yg(y2)>45)and(yg(y2)<700) then
                     begin
                       min:=abs(x-x2)+abs(y-y2);
                       indmin:=i;
                       trovato1:=true;
                     end;
                   end;
                 end;
                 x:=xg(dis^[indmin].x2);
                 y:=yg(dis^[indmin].y2);
                 movhcurabs(@x,@y);
                 Trattosel:=Indmin;
                 if not trovato1 then code:=130;
               end;

      end;
    end;
  end
  else
  begin
    code:=10;
   {if (cod=2)and(not iso) then isocur(x,y,1);}
  end;
  if (keypressed)and(lung<>0) then

  st:=readcom(stpino,'',0);
  until (st<>'')or(uscita<>0)or(code=132)or(code=130);
  case cod of
    6:begin
        controllo:=true;
        trovato:=false;
        i:=0;
        repeat
          i:=i+1;
          if (dis^[i].entita='L')and (dis^[indmin].x1=dis^[i].x2)and (dis^[indmin].y1=dis^[i].y2) then trovato:=true;
        until (trovato) or (i=nrighe);
        if abs(dis^[i].x2-dis^[i].x1)< 10E-20 then real1:=10E3
        else real1:=(dis^[i].y2-dis^[i].y1)/(dis^[i].x2-dis^[i].x1);
        real2:=elsimb[1+round(dis^[indmin].x2)].m;
        real3:=yp-real1*xp;
        real4:=yg(dis^[i].y2)-real2*xg(dis^[i].x2);
        x:=(real4-real3)/(real1-real2);
        y:=real1*x+real3;
        if (abs(yp-y)<0.001)  then
        begin
          write(chr(7));
          richiesta('Le rette coincidono !');
          delay(1000);
          controllo:=false;
        end;
        if  (not (trovato)) then
        begin
          write(chr(7));
          richiesta('Non trovo l''intersezione con il terminale selezionato !');
          delay(1000);
          controllo:=false;
        end
      end;

    8:begin
      int1:=0;
      setxor(@int1);
      end;

  end;
end;

end.