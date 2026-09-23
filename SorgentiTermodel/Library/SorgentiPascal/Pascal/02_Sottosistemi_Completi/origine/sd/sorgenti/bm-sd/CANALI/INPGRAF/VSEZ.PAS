{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit VSez;

INTERFACE

uses crt,turbo3,gruti,definiz,funzbase,globfunz,genproc,Angoli,halotp4,defuti,
     graph,Ridis_U,WM,esiste,controll{$ifdef win},def_win{$endif};
Procedure Vista;

{---------------------------------------------------------------------------}
implementation


{***************************  DisFrecce        *******************************}

Procedure DisFrecce(xo,yo,rot,ing:real);


begin

real1:=0;real2:=1;
ModiCord1(real1,real2,xo,yo,rot,ing);
movabs1(@real1,@real2);

real1:=1;real2:=1;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0.8;real2:=1.2;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=1;real2:=1;
ModiCord1(real1,real2,xo,yo,rot,ing);
movabs1(@real1,@real2);

real1:=0.8;real2:=0.8;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0;real2:=1;
ModiCord1(real1,real2,xo,yo,rot,ing);
movabs1(@real1,@real2);

real1:=0;real2:=-1;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=1;real2:=-1;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=0.8;real2:=-1.2;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

real1:=1;real2:=-1;
ModiCord1(real1,real2,xo,yo,rot,ing);
movabs1(@real1,@real2);

real1:=0.8;real2:=-0.8;
ModiCord1(real1,real2,xo,yo,rot,ing);
lnabs1(@real1,@real2);

end;

{***************************  Vista           *******************************}

Procedure Vista_Sez;

procedure inverti(var val1,val2:real);
var temp:real;
begin
temp:=val1;
val1:=val2;
val2:=temp;
end;

var nlinea:integer;
    xvista,Yvista,Xvista_E,Yvista_E,Torz,orz1,orz2,orzprec:real;
    fine,p2,p2prec,conferma:boolean;
    ch1:char;
    code:integer;
    contr:integer;
    ASez:real;
    Sfl:boolean;
    var st01:string;
begin;

if not(Sezione) then
  begin
  st01:='';
  richiesta(W_M(35)); {'<Sul punto>');}
  if not(vuoto) then readcord(x,y,cod,scelta,st01,5)
  else readcord(x,y,cod,scelta,st01,1);
  delHcur;
  if cod=132 then nlinea:=trattosel else nlinea:=0;

  if nlinea<>0 then
    begin
    if vuoto then
      begin
      xvista:=x;
      yvista:=y;
      orz1:=0;
      orz :=Pi/2;
      end
    else
      begin

      CalcDirez(nlinea,orz1,real1);

      orz2:=orz1+pi/2;
      if orz2>=2*pi then orz2:=orz2-2*pi;

      xvista:=xg(dis^[nlinea]^.x2,dis^[nlinea]^.y2);
      yvista:=yg(dis^[nlinea]^.y2,0);
      end;

    {$Ifdef win}
    Conferma:=true;
    Torz:=Dir_fr;
    {$else}
    p2:=true;
    int1:=1;
    setlnstyle(@int1);
    setxor(@int1);
    int1:=10;
    setcolor(int1);

    TOrz:=orz1;

    disfrecce(xvista,yvista,Torz,50);

    fine:=false;

      repeat

      orzprec:=Torz;
      p2prec :=p2;

      if keypressed then
        begin
        ch1:=readkey;
        if ch1=(#0) then
          begin
          ch1:=readkey;
            case ch1 of

            chr(77),chr(80):begin
                    Torz:=Torz+Pi/2;
                    if Torz>=2*pi then Torz:=Torz-2*pi;
                    end;
            {if Torz=orz1 then Torz:=orz2
                    else Torz:=orz1;}

            chr(75),chr(72):begin
                    Torz:=Torz-Pi/2;
                    if Torz<=0 then Torz:=Torz+2*pi;
                    end;

            {if Torz=orz1 then Torz:=orz2
                    else Torz:=orz1;}
            {
            chr(80):p2:=not(p2);

            chr(72):p2:=not(p2);
            }
            end;

          end;

        end;

      if m_attivo(real1,real2,code) then
        case code of

        132:begin
            conferma:=true;
            fine:=true;
            end;
        130:begin
            conferma:=false;
            fine:=true;
            end
        end;

      if (Torz<>orzprec)or(p2<>p2prec)then disfrecce(xvista,yvista,orzprec,50);

      {
      if p2 then

        begin
        xvista:=xg(dis^[nlinea].x2,0);
        yvista:=yg(dis^[nlinea].y2,0);
        end
      else

        begin
        xvista:=xg(dis^[nlinea].x1,0);
        yvista:=yg(dis^[nlinea].y1,0);
        end;
      }

      if (Torz<>orzprec)or(p2<>p2prec)then disfrecce(xvista,yvista,Torz,50);

      until fine;

    disfrecce(xvista,yvista,Torz,50);

    int1:=0;
    setxor(@int1);
    setlnstyle(@conf^.tlinea);
    setcolor(conf^.rcolore);
    setstclr(@conf^.rcolore,@conf^.rcolore);
    {$EndIf}
    end
  else conferma:=false;

  if conferma then
    begin
    pianfilt:=false; {cippo}
    piccolo := false ; (* cippo  per evitare problemi in zoom dinamico *)
    repeat
    val(ReadCom(W_M(36),AltSez,0),Asez,Contr); { 'Altezza Sezione +/- [m]}
    until contr=0;
    Asez:=Asez*40000/conf^.AltNum;
    zsup:=RisultCalc^.quota+Asez;
    zinf:=RisultCalc^.quota-Asez;

    PZSez:=RisultCalc^.Quota*40000/conf^.AltNum;

    {
    if p2 then

      begin
      xvista:=dis^[nlinea].x2;
      yvista:=dis^[nlinea].y2;
      end

    else

      begin
      xvista:=dis^[nlinea].x1;
      yvista:=dis^[nlinea].y1;
      end;
    }

    xvista_E:=Xe(XVista);
    yvista_E:=Ye(XVista,YVista);

{    if not (vuoto) then conf^.RColore:=Dis^[NLinea]^.Color;}

    orz:=Torz;
    sezione:=true;

    PZSez:=RisultCalc^.Quota;
    PXSez:=XVista_E;
    PYSez:=YVista_E;

    xinf:=xvista_E-(zsup-zinf)*(1000/750)*(-sin(orz))/2;
    xsup:=xvista_E+(zsup-zinf)*(1000/750)*(-sin(orz))/2;
    yinf:=yvista_E+(zsup-zinf)*(1000/750)*cos(orz)/2;
    ysup:=yvista_E-(zsup-zinf)*(1000/750)*cos(orz)/2;

    sfl:=SetFlag;

    S_limXS:=xsup;
    S_LIMXI:=xinf;
    S_LimYS:=ysup;
    S_LimYI:=yinf;
    S_LimZS:=zsup;
    S_LimZI:=zinf;

    XSupp:=xsup;
    XInfp:=xinf;
    YSupp:=ysup;
    YInfp:=yinf;
    ZSupp:=zsup;
    ZInfp:=zinf;

    end
  else orz:=0;

  end

else

  begin
  pianfilt:=false; {cippo}
  piccolo := false ; (* cippo  per evitare problemi in zoom dinamico *)
  PZSez:=0;
  PXSez:=0;
  PYSez:=0;
  orz:=0;
  sezione:=false;
  Sfl:=SetFlag;
  xinf:=L_xinf;
  yinf:=L_yinf;
  xsup:=L_xsup;
  ysup:=L_ysup;
 { Xsup:=limXS;
  Xinf:=LIMXI;
  YSup:=LimYS;
  YInf:=LimYI;}
  end;
{
writeln(lst,'  xs:',xsup:5:0,'ys:',ysup:5:0,'zs:',zsup:5:0,'xi:',xinf:5:0,'yi:',yinf:5:0,'zi:',zinf:5:0);
}


ridis;
scelta:=0;
{
writeln(lst,'  xs:',xsup:5:0,'    ys:',ysup:5:0,'   zs:',zsup:5:0,'   xi:',xinf:5:0,'   yi:',yinf:5:0,'   zi:',zinf:5:0);
}
end;

Procedure Vista;

Var C_Com:string;

Const MaxSez=20;

type
    RecSezioni = record
                    NomeP            : st8;
                    XIns,YIns,XOri   :real;
                    YOri,ZOri,Orient : real;
                    Scala            :integer;
                    A_S,BS,HS         : real;
                end;

    ElenSez = array[1..maxSez] of RecSezioni;

Var Sez    : ElenSez;
    fesez  : File of ElenSez;
    Trovato:Boolean;
    i:integer;
    Molt:real;
    var st01:string;

begin
Molt:=40000/conf^.altnum;

  repeat
{V}    C_com:=ReadCom(W_M(130),CH38,0);     {('Vista/Ins-sezione','V',0);}
    C_com:=UpString(C_Com);
{I,V}    until (C_com=CH39)or(C_com=CH38)or(C_com='');

{V}if (C_com=CH38) then Vista_Sez;

{I}if C_com=CH39 then
  begin
  if sezione then C_Com:=Nomesez
  else C_com:=ReadCom(W_M(37),'',0); {'Nome della sezione'}
  C_com:=UpString(C_Com);
  {agg-prima
  Driveplt+nomecommessa+'.sez'
  fine-prima}
  {agg-dopo}
  if (C_Com<>'')and(exist(Driveplt+'work.sez')) then
    begin
    assign(fesez,Driveplt+'work.sez');
  {fine-dopo}
    reset(fesez);
    read(fesez,Sez);

    Trovato:=false;
    i:=0;

      Repeat
      i:=i+1;
      if upstring(sez[i].NomeP)=C_com then trovato:=true;

      until (trovato)or(i=MaxSez)or(sez[i].NomeP='');

    if trovato then
      begin
      if sezione then richiesta(W_M(38)) {'Origine ')}
      else richiesta(W_M(39)); {'Punto di inserimento dell`Origine'}

      st01:='';
      retino:=true;

      readcord(x,y,cod,scelta,st01,11);
      isocur(x,y,2);

      if cod=132 then
        begin
        if sezione then
        with sez[i] do
          begin
          XIns:=XIns+(ze(x-xg(xori*molt,yori*molt))-Ze(0))/molt;
          YIns:=YIns+(ze(y-yg(yori*molt,zori*molt))-Ze(0))/molt;
          {
          xg()-Ze(0))*conf^.Altnum/40000 +Xins;


          XIns:=-sqrt(sqr(Xori-Xinf*conf^.Altnum/40000) +
                     sqr(Yori-Yinf*conf^.Altnum/40000))+
                     (ze(x)-Ze(0))*conf^.Altnum/40000 +Xins;

          YIns:=Zinf*conf^.Altnum/40000-Zori +
                 (ze(Y)-Ze(0))*conf^.Altnum/40000 +Yins;
          }
          end
        else
          begin
          with sez[i] do
             begin
             Xori:=xe(x)*conf^.altnum/40000;
             Yori:=Ye(x,y)*conf^.altnum/40000;
             end
          end;
        rewrite(fesez);
        write(fesez,Sez);
        end;

      richiesta('');

      end

    else richiesta('Sezione non in archivio');

    close(Fesez);

    if (sezione)and(trovato) then ridis;

    end;

  end;


end;

end.