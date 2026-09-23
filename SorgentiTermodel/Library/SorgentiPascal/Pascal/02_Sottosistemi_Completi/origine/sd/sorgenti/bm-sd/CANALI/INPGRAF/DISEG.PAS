

unit diseg;

INTERFACE

uses definiz,halotp4,graph,gruti,wm,angoli{$ifdef win},multilin,def_win,winprocs{$endif};

Procedure Disegna(i:Integer);
Function  OutTextN(Cod,Valor:real):String;
Procedure PArc(Vettore:Vetdim;Dxf:boolean);
Function  App_Sez(k,modo:integer;Var est:integer;Var App:boolean):boolean;
Procedure DisNum(tri:integer);
Procedure DisBoc(NL:integer);
Procedure DisRid(Ntratto,Colore:integer);
Procedure DisNumeri(Colore:integer);
Procedure DisUniOutQ(aaa,bbb:integer);

implementation
uses genproc;
{----------------------------------------------------------------------------}

{***************************  DisBoc     *****************************}

Procedure DisBoc(NL:integer);

Var NPZ:integer;
    Trovato:Boolean;
    Dir,Dirz:Real;
    X1L,Y1L:real;
    DimSim:real;

begin
DimSim:=50*100/conf^.Altnum;
if Dis^[NL]^.NLinea=0 then
if Dati^[Dis^[NL]^.tronco]^.Pros[1]=0 then
if Dati^[Dis^[NL]^.tronco]^.Pezzi[1]<>0 then
  begin
  NPZ:=0;
  Trovato:=false;
    repeat

    NPZ:=NPZ+1;
    if NPZ=PezziTr then trovato:=true
    else Trovato:=Dati^[Dis^[NL]^.tronco]^.Pezzi[NPZ+1]=0;

    until trovato;
  if VPezzi^[Dati^[Dis^[NL]^.tronco]^.Pezzi[NPZ]]^.Port<>0 then
    begin
    CalcDirez(NL,Dir,DirZ);
    if sezione then Dir:=Pi/2-DirZ;
    with Dis^[NL]^ do
      begin
      X1L:=xg(X2,Y2);
      Y1L:=yg(Y2,Z2);
      end;
    real1:=1;
    real2:=0;
    Modicord1(real1,real2,x1L,y1L,dir,yg1(dimsim,dimsim)-yg1(0,0));
    movabs1(@real1,@real2);
    real1:=-1;
    real2:=0;
    Modicord1(real1,real2,x1L,y1L,dir,yg1(dimsim,dimsim)-yg1(0,0));
    lnabs1(@real1,@real2);
    end;
  end;

end;

{************************** DisUniOutq ***********************}
Procedure DisUniOutQ(aaa,bbb:integer);
var i,j,est:integer;
    app:boolean;
    rcw:real;
BEGIN
if RisultCalc^.disUnif then
   begin
    int1:=11;
    setcolor(int1);
    for i:=aaa to bbb do
    if (dis^[i]<>nil)and(not dis^[i]^.Flag) then
      begin
        case dis^[i]^.entita[1] of
        'L':if(
               ((dis^[i]^.z1>=Zmin_p)and(dis^[i]^.z1<=Zmax_p))or
               ((dis^[i]^.z2>=Zmin_p)and(dis^[i]^.z2<=Zmax_p))
              )or (sezione) then
            begin
            setlnstyle(@dis^[i]^.tlinea);
            rcw:=120;
            real3:=3;
            if sezione then {-- Cerchi di sezione --}
              begin

              if App_sez(i,1,est,app) then
                 begin
                 if est=1 then
                   begin
                   real1:=xg(dis^[i]^.x1,dis^[i]^.y1);
                   real2:=yg(dis^[i]^.y1,dis^[i]^.z1);
                   end
                 else
                   begin
                   real1:=xg(dis^[i]^.x2,dis^[i]^.y2);
                   real2:=yg(dis^[i]^.y2,dis^[i]^.z2);
                   end;
                 movabs1A(@real1,@real2);
                 cir(@real3);
                 end;

              end
            else
              begin
              if Not UG(dis^[i]^.z1,dis^[i]^.z2,2) then
                begin
                if UG(dis^[i]^.z1,RisultCalc^.Quota,2)then
                  begin
                  real1:=xg(dis^[i]^.x1,dis^[i]^.y1);
                  real2:=yg(dis^[i]^.y1,dis^[i]^.z1);
                  movabs1A(@real1,@real2);
                  cir(@real3);
                  {$ifdef win}
                  if multi_w then
                  begin
                  with dis^[i]^ do
                  multicirsez(x1,y1,z1,real3,1);
                  for j:=1 to 2 do el_win[j].active:=false;
                  setlcolor(i);
                  settapenna;
                  multi_line(i);
                  for j:=1 to 2 do el_win[j].active:=true;
                  end;
                  {$endif}
                  end;
                if Ug(dis^[i]^.z2,RisultCalc^.Quota,2) then
                  begin
                  real1:=xg(dis^[i]^.x2,dis^[i]^.y2);
                  real2:=yg(dis^[i]^.y2,dis^[i]^.z2);
                  movabs1A(@real1,@real2);
                  cir(@real3);
                  {$ifdef win}
                  if multi_w then
                  begin
                  with dis^[i]^ do
                  multicirsez(x1,y1,z1,real3,1);
                  for j:=1 to 2 do el_win[j].active:=false;
                  setlcolor(i);
                  settapenna;
                  multi_line(i);
                  for j:=1 to 2 do el_win[j].active:=true;
                  end;
                  {$endif}
                  end;
                end

              end;
            if not(sezione)then
              begin
              real1:=xg(dis^[i]^.x1,dis^[i]^.y1);
              real2:=yg(dis^[i]^.y1,dis^[i]^.z1);
              movabs1(@real1,@real2);
              real1:=xg(dis^[i]^.x2,dis^[i]^.y2);
              real2:=yg(dis^[i]^.y2,dis^[i]^.z2);
              lnabs1(@real1,@real2);
              DisBoc(i);
              end;
            end;

        'T':begin
            {setlnstyle(@dis^[i].tlinea);
            setcolor(@dis^[i].colore);
            real1:=dis^[i].x1;
            real2:=dis^[i].y1;
            setstclr(@dis^[i].colore,@dis^[i].colore);
            disetic(round(dis^[i].x2),2,dati^[Dis^[i].tronco].term,real1,real2,dis^[i].y2);}
            end;
        'E':begin
            {setlnstyle(@dis^[i].tlinea);
            setcolor(@dis^[i].colore);
            real1:=dis^[i].x1;
            real2:=dis^[i].y1;
            setstclr(@dis^[i].colore,@dis^[i].colore);
            disetic(round(dis^[i].x2),1,dis^[dis^[i].tronco].tronco,real1,real2,dis^[i].y2);}
            end;
        end
      end;
   end;
END;


{***************************  Disegna         *******************************}

Procedure Disegna(i:Integer);

var est,j:integer;
    app:boolean;
    xc,yc,zc,rcw:real;

begin
if Dis^[i]^.entita<>'' then
case dis^[i]^.entita[1] of
        'L':begin
            {Writeln(lst,'Linea:',i);
            with dis^[i] do
            writeln(lst,X1:4:0,' ',y1:4:0,' ',z1:4:0,' ',X2:4:0,' ',y2:4:0,' ',z2:4:0,' ');}
            setlnstyle(@dis^[i]^.tlinea);
            real1:=xg(dis^[i]^.x1,dis^[i]^.y1);
            real2:=yg(dis^[i]^.y1,dis^[i]^.z1);
            {writeln(lst,Real1:4:0,'  ',Real2:4:0);}
            movabs1(@real1,@real2);

            real3:=3;
            rcw:=120;
            int1:=11;
            setcolor(int1);
            if sezione then {-- Cerchi di sezione --}
              begin

              if App_sez(i,1,est,app) then
              if App then
                begin
                if est=1 then
                  begin
                  real1:=xg(dis^[i]^.x1,dis^[i]^.y1);
                  real2:=yg(dis^[i]^.y1,dis^[i]^.z1);
                  xc:=dis^[i]^.x1;
                  yc:=dis^[i]^.y1;
                  zc:=dis^[i]^.z1
                  end
                else
                  begin
                  real1:=xg(dis^[i]^.x2,dis^[i]^.y2);
                  real2:=yg(dis^[i]^.y2,dis^[i]^.z2);
                  xc:=dis^[i]^.x2;
                  yc:=dis^[i]^.y2;
                  zc:=dis^[i]^.z2
                  end;
                movabs1A(@real1,@real2);
                cir(@real3);
                {$ifdef win}
                multicirsez(xc,yc,zc,real3,1);
                {$endif}
                end;

              end
            else
              begin
              if Not UG(dis^[i]^.z1,dis^[i]^.z2,2) then
                begin
                if UG(dis^[i]^.z1,RisultCalc^.Quota,2)then
                  begin
                  real1:=xg(dis^[i]^.x1,dis^[i]^.y1);
                  real2:=yg(dis^[i]^.y1,dis^[i]^.z1);
                  movabs1A(@real1,@real2);
                  xc:=dis^[i]^.x1;
                  yc:=dis^[i]^.y1;
                  zc:=dis^[i]^.z1;
                  cir(@real3);
                  {$ifdef win}
                  if multi_w then
                  begin
                  multicirsez(xc,yc,zc,real3,1);
                  for j:=1 to 2 do el_win[j].active:=false;
                  setlcolor(i);
                  settapenna;
                  multi_line(i);
                  for j:=1 to 2 do el_win[j].active:=true;
                  end;
                  {$endif}
                  end;
                if Ug(dis^[i]^.z2,RisultCalc^.Quota,2) then
                  begin
                  real1:=xg(dis^[i]^.x2,dis^[i]^.y2);
                  real2:=yg(dis^[i]^.y2,dis^[i]^.z2);
                  movabs1A(@real1,@real2);
                  xc:=dis^[i]^.x2;
                  yc:=dis^[i]^.y2;
                  zc:=dis^[i]^.z2;
                  cir(@real3);
                  {$ifdef win}
                  if multi_w then
                  begin
                  multicirsez(xc,yc,zc,real3,1);
                  for j:=1 to 2 do el_win[j].active:=false;
                  setlcolor(i);
                  settapenna;
                  multi_line(i);
                  for j:=1 to 2 do el_win[j].active:=true;
                  end;
                  {$endif}
                  end;
                end

              end;

            movabs1(@real1,@real2);

            setLcolor(i);
            real1:=xg(dis^[i]^.x2,dis^[i]^.y2);
            real2:=yg(dis^[i]^.y2,dis^[i]^.z2);
            {writeln(lst,Real1:4:0,'  ',Real2:4:0);}
            lnabs1(@real1,@real2);
            {$ifdef win}
            if multi_w then
            begin
            multi_line(i);
            end;
            {$endif}
            with dis^[i]^ do
            if rid<>'' then DisRid(i,T_Col(Color));
            DisBoc(i);
            end;
        'T':begin
            {setlnstyle(@dis^[i].tlinea);
            setLcolor(i);
            real1:=dis^[i].x1;
            real2:=dis^[i].y1;
            setstclr(@dis^[i].colore,@dis^[i].colore);
            disetic(round(dis^[i].x2),2,dati^[Dis^[i].tronco].term,real1,real2,dis^[i].y2);}
            end;
        'E':begin
            {setlnstyle(@dis^[i].tlinea);
            setcolor(dis^[i].colore);
            real1:=dis^[i].x1;
            real2:=dis^[i].y1;
            setstclr(@dis^[i].colore,@dis^[i].colore);
            disetic(round(dis^[i].x2),1,dis^[dis^[i].tronco].tronco,real1,real2,dis^[i].y2);}
            end;
        end
end;




{***************************   APP_SEZ      *******************************}
Function App_Sez(k,modo:integer;Var est:integer;Var App:boolean):boolean;


begin
App:=false;
est:=1;
App_sez:=false;

if (sezione)then
  begin
  if M_sez>=10E6 then
    begin
    if ug(dis^[k]^.x2,PxSez,3) then
      begin
      est:=2;
      App:=true;
      App_sez:=true;
      end;
    if ug(dis^[k]^.x1,PxSez,3)and(modo=1) then
      begin
      est:=1;
      App_sez:=true;
      if App then App:=false else App:=true;
      end;
    end
  else
    begin
    if (ug(dis^[k]^.y2,C_sez+dis^[k]^.x2*M_sez,3)) then
      begin
      est:=2;
      App_sez:=true;
      App:=true;
      end;
    if (ug(dis^[k]^.y1,C_sez+dis^[k]^.x1*M_sez,3)and(modo=1)) then
      begin
      est:=1;
      App_sez:=true;
      if App then App:=false else App:=true;
      end;
    end
  end
end;


{***************************  DisNum          *******************************}

Procedure DisNum(tri:integer);

var k,est:integer;
    altNodi:real;
    App:boolean;
    St1:string; (* cippo crea problemi in zoom din. sulla readcord(..,st1)
                   essendo gia definita St1 *)

begin
if (dati^[tri]^.ti<>0) then
    begin

    k:=dati^[tri]^.ti;
      while dis^[k]^.nlinea<>0 do k:=dis^[k]^.nlinea;

    if  (dati^[tri]^.x=0)and(dati^[tri]^.y=0) then

      begin

      dati^[tri]^.x:=dis^[k]^.x2;
      dati^[tri]^.y:=dis^[k]^.y2;

      end;

{
if dati^[tri].num=5 then
writeln(lst,'M_sez:',M_sez:4:3,
            'C_sez:',C_sez:4:3,
            ' x2:',dis^[k].x2:5:3,
            ' x1:',dis^[k].x1:5:3,
            ' y1:',dis^[k].y1:5:3,
            ' y2:',dis^[k].y2:5:3,
            ' PxSez:', PxSez:5:0,
            (M_sez>=10E6),
            (ug(dis^[k].x2,PxSez,3)),
            (App_Sez(k,2)));
}

    if (Dis^[k]^.flag)or
       ((not sezione)and(dis^[k]^.z2=RisultCalc^.quota))or
       (App_Sez(k,2,est,app)) then

      begin

      real1:=xg(dati^[tri]^.x,dati^[tri]^.y);
      real2:=yg(dati^[tri]^.y,Dis^[k]^.Z2);
      st1:='';
      str(dati^[tri]^.num,st1);
      if dati^[tri]^.num=0 then
        begin
        str(tri,st1);
        st1:='N'+st1
        end;
      movabs1(@real1,@real2);
      stext(@st1);
      end;
    end;


end;


{***************************  CancNum          *******************************}

Procedure CancNum(tr:integer);

begin
int1:=0;int2:=0;
setstclr(@int1,@int2);
int1:=1;
Setlnstyle(@int1);
{real1:=abs(xg1(20*40,20*40)-xg1(0,0));}
real1:=abs(xg1(costant^.altquo*hhnn{70},costant^.altquo*hhnn{70}{cippo ex 20*40,20*40})-xg1(0,0));

real2:=1;
int1:=0;
setstext(@real1,@real2,@int1);
if ((dati^[tr]^.x<>0)or(dati^[tr]^.y<>0))and(risultCalc^.Nodi) then
DisNum(tr);
dati^[tr]^.x:=0;
dati^[tr]^.y:=0;
end;


{***************************  DISNUMERI      *******************************}

Procedure DisNumeri(Colore:integer);

var i,k,est:integer;
    altNodi:real;

begin
int1:=colore;int2:=colore;
setstclr(@int1,@int2);
int1:=1;
Setlnstyle(@int1);
real1:=abs(xg1(costant^.altquo*hhnn{70},costant^.altquo*hhnn{70}{cippo ex 20*40,20*40})-xg1(0,0));
real2:=1;
int1:=0;
setstext(@real1,@real2,@int1);

  for i:=1 to ulttronco do
  DisNum(i);

end;


{***************************  DisRid         *******************************}

Procedure DisRid(Ntratto,Colore:integer);

var dir,dx,dy,px2,py2,px1,py1,dist,DimSim,xa,ya,xb,yb:real;
const dimsim1=30;

begin
DimSim:=DimSim1*100/conf^.Altnum;
int1:=0;
setXor(@int1);
setcolor(colore);
with dis^[ntratto]^ do
  begin
  px1:=xg(X1,Y1);
  py1:=yg(y1,Z1);
  px2:=xg(X2,Y2);
  py2:=yg(y2,Z2);
  end;

  if py2=py1 then
    begin
      if px2>=px1 then Dir:=pi/2 else Dir:=(3/2)*pi;
    end
    else
    begin
      if py2>py1 then
      begin
      Dir:=arctan((px2-px1)/abs(py2-py1));
      end
    else
      Dir:=pi-arctan((px2-px1)/abs(py2-py1));
    end;

  if Dir<0 then Dir:=2*pi+Dir;

  real1:=1;
  real2:=2;
  Modicord1(real1,real2,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  movabs1(@real1,@real2);
  real3:=1;
  real4:=-2;
  Modicord1(real3,real4,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  lnabs1(@real3,@real4);
  xa:=xe(real1);
  ya:=ye(real1,real2);
  xb:=xe(real3);
  yb:=ye(real3,real4);
  {$ifdef win}
  multil1(xa,ya,0,xb,yb,0);
  {$endif}

  real1:=-1;
  real2:=2;
  Modicord1(real1,real2,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  movabs1(@real1,@real2);
  real3:=-1;
  real4:=-2;
  Modicord1(real3,real4,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  lnabs1(@real3,@real4);
  xa:=xe(real1);
  ya:=ye(real1,real2);
  xb:=xe(real3);
  yb:=ye(real3,real4);
  {$ifdef win}
  multil1(xa,ya,0,xb,yb,0);
  {$endif}


  real1:=1;
  real2:=0;
  Modicord1(real1,real2,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  movabs1(@real1,@real2);
  real3:=-1;
  real4:=0;
  Modicord1(real3,real4,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  lnabs1(@real3,@real4);

  xa:=xe(real1);
  ya:=ye(real1,real2);
  xb:=xe(real3);
  yb:=ye(real3,real4);
  {$ifdef win}
  multil1(xa,ya,0,xb,yb,0);
  {$endif}


end;




{*-*-*-*-*-*-*-*-*-*-*-*-*-*  PArc          *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure PArc(Vettore:Vetdim;Dxf:boolean);

const Ndiv1=20;
      Ndiv2=20;

var i,Ndiv:integer;
    xpr,ypr,Xcor,ycor,Rcor:real;
    StepAng,StepCos:real;
    angpr:real;
begin
{if stampa_win then messagebeep(10);}
if dxf or stampa_win then NDiv:=NDiv2 else NDiv:=NDiv1;


with Vettore Do
  begin
  StepCos:=Pi/Ndiv;
  StepAng:=(y2-x2)/Ndiv;
  x2:=x2+2*pi;
  y2:=y2+2*pi;
  xpr:=X1+R*Cos(x2);
  ypr:=Y1+R*Sin(x2);

  if dxf then  {-- Inizializzazione polilinea --}
    begin
    end
  else
    begin
    real1:=Xg(Xpr,0);
    real2:=Yg(Ypr,0);
    MovAbs1(@Real1,@Real2);
    end;

  for i:=1 to Ndiv Do
    begin
    rcor:=R2-1/2*(R2-R)*(1+Cos(StepCos*i));

        {-- Sforamento --}

    if R2>R then
      begin
      angpr:=abs(StepAng*i);
      if angpr<PI/2-0.1 then
      if rcor > R/cos(angpr) then rcor:=R/cos(angpr);
      end
    else
      begin
      angpr:=abs(StepAng*(ndiv-i));
      if angpr<PI/2-0.1 then
      if rcor > R2/cos(angpr) then rcor:=R2/cos(angpr);
      end;

    xcor:=X1+rcor*Cos(x2+StepAng*i);
    ycor:=Y1+rcor*Sin(x2+StepAng*i);
    if Dxf Then
      begin
      end
    else
      begin
      real1:=Xg(Xcor,0);
      real2:=Yg(Ycor,0);
      LnAbs1(@Real1,@Real2);
      end;
    XPr:=XCor;
    YPr:=YCor;
    end;
  end
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  OutTextN      *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Function OutTextN(Cod,Valor:real):String;

Var st1:string;

begin
if Cod=5 then
  begin
  if unmis=1 then
  str(Valor:5:3,st1)
  else
  str(Valor*3600:5:1,st1);
  end
else str(Valor:3:0,st1);

if Cod=1 then st1:=st1+' x';
if Cod=3 then st1:='D '+st1;
if Cod=4 then
  begin
  if unmis=1 then
  st1:=W_M(128)  { 'mc/s' }
  else
  st1:=W_M(129);  {'mc/h';}
  end;
OutTextN:=St1;
end;



end.