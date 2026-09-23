{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit globfunz;

INTERFACE

uses Turbo3,crt,dos,definiz,Gruti,piante,printer,angoli,Genproc,halotp4,graph,WM;


Function  readcom(dato,def:string;stpos:integer):string;
procedure readcord(var x,y:real;var code,uscita:integer;var st:string;cod:integer);
Function  SelezLinea(var Numlinea:integer):integer;
Function  InsNodo(Tratto,NTratto,Tipo,Nuovotr:integer):integer;
procedure initRec(indice,Modo:integer);
procedure vaga;
Function  TipoNodo(Tratto:integer):integer;
function SetFlag:boolean;
Procedure Disegna(i:Integer);
Procedure PArc(Dxf:boolean);
Function  OutTextN(Cod,Valor:real):String;
Procedure ModiColor(Var OLD_C:integer;New_C:integer;Echo:Boolean);
Procedure DisNumeri(Colore:integer);
Procedure DisRid(Ntratto,Colore:integer);
Procedure CancNum(tr:integer);
Function App_Sez(k,modo:integer;Var est:integer;Var App:boolean):boolean;
Procedure DisBoc(NL:integer);
Procedure Ver_spez(xs,ys,zs:real;Trattos:integer;Var Cod:integer);
Function NomeFile(Drive:string):String;

{---------------------------------------------------------------------------}
implementation


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
    if ug(dis^[k].x2,PxSez,3) then
      begin
      est:=2;
      App:=true;
      App_sez:=true;
      end;
    if ug(dis^[k].x1,PxSez,3)and(modo=1) then
      begin
      est:=1;
      App_sez:=true;
      if App then App:=false else App:=true;
      end;
    end
  else
    begin
    if (ug(dis^[k].y2,C_sez+dis^[k].x2*M_sez,3)) then
      begin
      est:=2;
      App_sez:=true;
      App:=true;
      end;
    if (ug(dis^[k].y1,C_sez+dis^[k].x1*M_sez,3)and(modo=1)) then
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

begin
if (dati^[tri].ti<>0) then
    begin

    k:=dati^[tri].ti;
      while dis^[k].nlinea<>0 do k:=dis^[k].nlinea;

    if  (dati^[tri].x=0)and(dati^[tri].y=0) then

      begin

      dati^[tri].x:=dis^[k].x2;
      dati^[tri].y:=dis^[k].y2;

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

    if (Dis^[k].flag)or
       ((not sezione)and(dis^[k].z2=RisultCalc.quota))or
       (App_Sez(k,2,est,app)) then

      begin

      real1:=xg1(dati^[tri].x,dati^[tri].y);
      real2:=yg1(dati^[tri].y,Dis^[k].Z2);
      st1:='';
      str(dati^[tri].num,st1);
      if dati^[tri].num=0 then
        begin
        str(tri,st1);
        st1:='N'+st1
        end;
      movtcurabs(@real1,@real2);
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
real1:=abs(xg1(20*40,20*40)-xg1(0,0));
real2:=1;
int1:=0;
setstext(@real1,@real2,@int1);
if ((dati^[tr].x<>0)or(dati^[tr].y<>0))and(risultCalc.Nodi) then
DisNum(tr);
dati^[tr].x:=0;
dati^[tr].y:=0;
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
real1:=abs(xg1(20*40,20*40)-xg1(0,0));
real2:=1;
int1:=0;
setstext(@real1,@real2,@int1);

  for i:=1 to ulttronco do
  DisNum(i);

end;


{***************************  DisRid         *******************************}

Procedure DisRid(Ntratto,Colore:integer);

var dir,dx,dy,px2,py2,px1,py1,dist,DimSim:real;
const dimsim1=30;

begin
DimSim:=DimSim1*100/Conf.Altnum;
int1:=0;
setXor(@int1);
setcolor(colore);
with dis^[ntratto] do
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
  real1:=1;
  real2:=-2;
  Modicord1(real1,real2,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  lnabs1(@real1,@real2);
  real1:=-1;
  real2:=2;
  Modicord1(real1,real2,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  movabs1(@real1,@real2);
  real1:=-1;
  real2:=-2;
  Modicord1(real1,real2,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  lnabs1(@real1,@real2);
  real1:=1;
  real2:=0;
  Modicord1(real1,real2,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  movabs1(@real1,@real2);
  real1:=-1;
  real2:=0;
  Modicord1(real1,real2,px2,py2,dir,yg1(dimsim,dimsim)-yg1(0,0));
  lnabs1(@real1,@real2);

end;




{****************************** VAGA *****************************************}

procedure vaga;

begin
  st1:='';
  setclip(@minxw,@minyw,@maxxW,@maxYw);
  repeat
    readcord(x,y,cod,scelta,ST1,1);
  until scelta<>0;
end;
{************************** RICHIESTA1 ****************************************}

(*Procedure richiesta1(rich:st80);

var Fl:string;

begin
  real1:=0;real2:=0;real3:=900;real4:=750;
  setclip(@real1,@real2,@real3,@real4);
  int1:=15;
  int2:=0;
  settextclr(@int1,@int2);
  Fl:='                                                            ';
  real1:=1;real2:=15;
  MovTcurabs1(@real1,@real2);
  text1(@Fl);
  real1:=1;real2:=15;
  MovTcurabs1(@real1,@real2);
  text1(@rich);
  deltcur;
end;*)

{*************************** READCOM *************************************}
Function readcom(dato,def:string;stpos:integer):string;
var
   ldato:integer;
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
    ycar:=15;
    xcar:=1+TextWidth(dato1)/inx;
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
    dato:=LINE_INPUT(round(xcar),round(ycar),20,StartPos,' ',Dato,3,Exit_Char,false,F,riga);
    if dato='' then dato:=def;
    readcom:=dato;
    M_ON;

  end
  else
    begin
    M_OFF;
    dato:=LINE_INPUT(round(xcar),round(ycar),20,StartPos,' ',Dato,3,Exit_Char,false,F,riga);
    readcom:=dato;
    M_ON;
    end;

IF Exit_Char=Chr(27) then
  begin
  ReadCom:='';
  delay(300);
  end;

end;


{***************************  ModiColor     *******************************}

Procedure ModiColor(Var OLD_C:integer;New_C:integer;Echo:Boolean);


begin
  Case New_C of
   1:begin
     if (Old_C<1)or(Old_C>9) Then Old_C:=1;
     if sezione then
       case Old_C Of
       1,4,7:Old_C:=1;
       2,5,8:Old_C:=2;
       3,6,9:Old_C:=3;
       end
     else
       case Old_C Of
       1,2,3:Old_C:=1;
       4,5,6:Old_C:=4;
       7,8,9:Old_C:=7;
       end;
     if echo then
       begin
       Richiesta('');
       Richiesta(W_M(75));
       {'Colore Bianco (Asse)');}
       end;
     end;
   2:begin
     if (Old_C<1)or(Old_C>9) Then Old_C:=1;
     if sezione then
       case Old_C Of
       1,4,7:Old_C:=4;
       2,5,8:Old_C:=5;
       3,6,9:Old_C:=6;
       end
     else
       case Old_C Of
       1,2,3:Old_C:=2;
       4,5,6:Old_C:=5;
       7,8,9:Old_C:=8;
       end;
     if echo then
       begin
       Richiesta('');
       if sezione then Richiesta(W_M(76)) {'Colore Giallo (Sotto)')}
       else Richiesta(W_M(77));  {Colore Giallo (bordo destro)')}
       end;
     end;
   3:begin
     if (Old_C<1)or(Old_C>9) Then Old_C:=1;
     if sezione then
       case Old_C Of
       1,4,7:Old_C:=7;
       2,5,8:Old_C:=8;
       3,6,9:Old_C:=9;
       end
     else
       case Old_C Of
       1,2,3:Old_C:=3;
       4,5,6:Old_C:=6;
       7,8,9:Old_C:=9;
       end;
     if echo then
       begin
       Richiesta('');
       if sezione then Richiesta(W_M(78)) {'Colore rosso (Sopra)')}
       else Richiesta(W_M(79));   {'Colore Rosso (bordo sinistro)');}
       end;
     end;
  end
end;

{************************** READCORD *****************************************}

procedure readcord(var x,y:real;var code,uscita:integer;var st:string;cod:integer);
var lung,i,indmin,primo:integer;
    min,xpr,ypr:real;
    entra,pr,trovato,trovato1:boolean;
    stx       :string;
    stpino    :string;
    trattoin  :integer;
    inizio    :boolean;
    xgraf,ygraf:real;
    gx1,gx2,gy1,gy2,incl:real;
    st1an,st2an,st3an,st1x,st1y,st1m,st2m:string;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Tastofunz       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Tastofunz(exitprec:char);

var ch:Char;
    READ_KBD:Boolean;
    ft:text;

begin
if exitprec='O' then
  begin
  READ_KBD:=False;
  READ(KBD,CH);
  IF KEYpressed AND (ORD(CH)=27) THEN
    BEGIN
    READ(KBD,CH);
    READ_KBD:=TRUE;
    END;
  end
else
  begin
  READ_KBD:=true;
  ch:=exitprec;
  end;
if READ_KBD then
  case ord(ch) of
  59,60,61:begin
           MOdiColor(Conf.RColore,Ord(ch)-58,True);
           end;
  62:begin
     if (Conf.RColore<1)or(Conf.RColore>9) Then Conf.RColore:=1;
     if Not(sezione) then
       begin
       case Conf.Rcolore Of
       1,4,7:Conf.Rcolore:=1;
       2,5,8:Conf.Rcolore:=2;
       3,6,9:Conf.Rcolore:=3;
       end;

       Richiesta('');
       Richiesta(W_M(80));  {'Asse (sezione)');}
       end
     else
       begin
       case Conf.Rcolore Of

       1,2,3:Conf.RColore:=1;
       4,5,6:Conf.RColore:=4;
       7,8,9:Conf.RColore:=7;
       end;

       Richiesta('');
       Richiesta(W_M(81));  {'Asse (Pianta)');}
       end
     end;

  63:begin
     if (Conf.RColore<1)or(Conf.RColore>9) Then Conf.RColore:=1;
     if Not(sezione) then
       begin
       case Conf.Rcolore Of
       1,4,7:Conf.Rcolore:=4;
       2,5,8:Conf.Rcolore:=5;
       3,6,9:Conf.Rcolore:=6;
       end;

       Richiesta('');
       Richiesta(W_M(82));  {'Sotto (sezione) '); }
       end
     else
       begin
       case Conf.Rcolore Of
       1,2,3:Conf.RColore:=2;
       4,5,6:Conf.RColore:=5;
       7,8,9:Conf.RColore:=8;
       end;

       Richiesta('');
       Richiesta(W_M(83));  { 'Bordo destro (Pianta)'); }
       end
     end;

  64:begin
     if (Conf.RColore<1)or(Conf.RColore>9) Then Conf.RColore:=1;
     if Not(sezione) then
       begin
       case Conf.Rcolore Of
       1,4,7:Conf.Rcolore:=7;
       2,5,8:Conf.Rcolore:=8;
       3,6,9:Conf.Rcolore:=9;
       end;

       Richiesta('');
       Richiesta(W_M(84));  { 'Sopra (sezione) '); }
       end
     else
       begin
       case Conf.Rcolore Of
       1,2,3:Conf.RColore:=3;
       4,5,6:Conf.RColore:=6;
       7,8,9:Conf.RColore:=9;
       end;

       Richiesta('');
       Richiesta(W_M(85));  { 'Bordo sinistro (Pianta)'); }
       end
     end;

  65:begin
     Richiesta('');
     if snapx then Richiesta(W_M(86))  { 'Snap Y') }
     else Richiesta(W_M(87));  { 'Snap X'); }
     snapx:=not(snapx);
     end;

  66:begin
     Richiesta('');
     if snapz then Richiesta(W_M(88))  { 'Snap XY') }
     else Richiesta(W_M(89));  { 'Snap Z'); }
     snapz:=not(snapz);
     end;

  67:begin
     if SnapAng then richiesta(W_M(90))  { 'Snap angolare DISATTIVATO') }
     else richiesta(W_M(91));  { 'Snap angolare ATTIVATO'); }
     SnapAng:=Not(SnapAng);
     end;

  68:begin
     assign(ft,'Fine.sce');
     rewrite(ft);
     write(ft,'**');
     close(Ft);
     uscita:=15;
     end
  end;
if cod=1 then
  begin
  real1:=0;real2:=40;real3:=1000;real4:=750;
  setclip(@real1,@real2,@real3,@real4);
  end;
Filo1(Conf.RColore);

end;

begin


  case cod of
 1,11:begin
      if (conf.rsnap>0) then
      begin
      int1:=7;int2:=0;
      settextclr(@int1,@int2);
      real1:=0;
      real2:=ysp-1;
      st1an:='                                         ';
      movtcurabs(@real1,@real2);
      {text1(@st1an);
      str(RisultCalc.quota*conf.altnum/40000:6:2,st1an);
      st1an:=format(st1an,6);}
      st1an:='x:       [m],y:       [m],z:       [m]';
      movtcurabs(@real1,@real2);
      text1(@st1an);
      end;
    end;

  2,7:begin
      int1:=7;int2:=0;
      settextclr(@int1,@int2);
      real1:=0;
      real2:=ysp-1;
      if sezione then st2an:=W_M(92)  { 'Ang:    [Deg],Lung.:        [m],Z:         [m]'}
      else st2an:=W_M(93);  { 'Ang:    [Deg],Lung.:        [m]        ';}
      movtcurabs(@real1,@real2);
      text1(@st2an);
      if Cod=7 then
      with dis^[trattosel]do
        begin
        gx1:=xg(x1,y1);
        gy1:=yg(y1,z1);
        xp:=gx1;
        yp:=gy1;
        gx2:=xg(x2,y2);
        gy2:=yg(y2,z2);
        if abs(gx2-gx1)< 10E-6 then
          begin
          incl:=10E6;
          if gy2<gy1 then incl:=-10E6
          end
        else incl:=(gy2-gy1)/(gx2-gx1);

        end;
     end;


  8:begin
    int1:=1;
    setxor(@int1);
    real1:=xg(conf.altnum,0)-xg(0,0);
    real2:=1;
    int1:=0;
    setstext(@real1,@real2,@int1);
    deltcur;
    stx:='';
{    if upcase(conf.numdia[1])='N'then str(dati^[ntronco].num,stx)
    else
    if dati^[i].CodDiam<>''then stx:=dati^[ntronco].Coddiam;}
    int1:=0;int2:=15;
    settextclr(@int1,@int2);
    movtcurabs(@x,@y);
    stext(@stx);
    xpr:=x;
    ypr:=y;
    end;

 end;

  if risultcalc.Origine<>0 then Trattoin:=dati^[RisultCalc.Origine].Ti;
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
               msnap(x,y,true);
               movhcurabs(@x,@y); {procedura vaga}
             end;
             2:begin              {Procedura tronco al punto}
                 delhcur;
                 if retino then Tretino(x,y,false);
                 int1:=8;
                 setcolor(int1);
                 setclip(@xw1,@yw1,@xw2,@yw2);
                 Movabs1(@xp,@yp);
                 rlnabs(@x,@y);
                 int1:=7;
                 setcolor(int1);
                 isocur(x,y,1);
               end;
             3:begin {cancella}
                 delhcur;
                 real1:=x-5;real2:=y-5;real3:=x+5;real4:=y+5;
                 rbox(@real1,@real2,@real3,@real4);
               end;
             4:begin  {zoom}
                 int1:=7;
                 setcolor(int1);
                 rbox(@xp,@yp,@x,@y);
               end;
          5,10:begin  {Snap a nodo}
                 min:=10E6;
                 indmin:=1;
                 for i:=1 to ultriga do
                 with dis^[i] do
                 if (tronco >0)and(tronco<=ulttronco) then
                 if (entita='L')and((flag)or
                    ( (ug(x2,PXSez,2))and(ug(y2,PySez,2))and(ug(z2,PzSez,2)))or
                    ((not(sezione))and(Ug(z2,risultCalc.quota,2)))
                    )
                 then
                   begin
                   entra:=false;
                   if nlinea=0 then entra:=true
                   else if dis^[nlinea].entita[1]<>'T' then entra:=true;
                   if (cod=10)and(dis^[i].Rid='') then entra:=false;

                   if entra then
                     begin
                     {if i<>trattoin then
                       begin
                       xgraf:=xg(x1,y1);
                       ygraf:=yg(y1,z1);
                       if abs(x-xgraf)+abs(y-ygraf)<min then
                         begin
                         if (xgraf>0)and(xgraf<900)and(ygraf>45)and(ygraf<750) then
                           begin
                           min:=abs(x-xgraf)+abs(y-ygraf);
                           indmin:=i;
                           trattosel:=i;
                           inizio:=true;
                           end;
                         end;
                       end;}

                     xgraf:=xg(x2,y2);
                     ygraf:=yg(y2,z2);
                     if abs(x-xgraf)+abs(y-ygraf)<min then
                       begin
                       if (xgraf>0)and(xgraf<900)and(ygraf>45)and(ygraf<750) then
                         begin
                         min:=abs(x-xgraf)+abs(y-ygraf);
                         indmin:=i;
                         Trattosel:=i;
                         inizio:=false;
                         end;
                       end;
                     end;
                   end;

                 if inizio then
                   begin
                   x:=xg(dis^[indmin].x1,dis^[indmin].y1);
                   y:=yg(dis^[indmin].y1,dis^[indmin].z1);
                   end
                 else
                   begin
                   x:=xg(dis^[indmin].x2,dis^[indmin].y2);
                   y:=yg(dis^[indmin].y2,dis^[indmin].z2);
                   end;

                 movhcurabs(@x,@y);
                 Trattosel:=Indmin;
               end;

             6:begin  {Snap a terminale}
                 x:=xe(x);
                 y:=ye(x,y);
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
                     if (xg(x1,y1)>0)and(xg(x1,y1)<900)and(yg(y1,z1)>45)and(yg(y1,z1)<700) then
                     begin
                       min:=abs(x-x1)+abs(y-y1);
                       indmin:=i;
                     end;
                   end;
                 end;
                 setclip(@xw1,@yw1,@xw2,@yw2);
                 x:=xg(dis^[indmin].x1,dis^[indmin].y1);
                 y:=yg(dis^[indmin].y1,dis^[indmin].z1);
                 movhcurabs(@x,@y);
                 Trattosel:=indmin;
               end;

             7:begin   {snap a tronco}


               if (incl<=1)and(incl>=-1) then
                 begin

                   if (x>gx2)and(gx2>=gx1) then x:=gx2;
                   if (x<gx1)and(gx2>=gx1) then x:=gx1;
                   if (x<gx2)and(gx1>=gx2) then x:=gx2;
                   if (x>gx1)and(gx1>=gx2) then x:=gx1;
                   y:=gy1+(incl*(x-gx1))
                 end
               else
                 begin
                   if (y>gy2)and(gy2>=gy1) then y:=gy2;
                   if (y<gy1)and(gy2>=gy1) then y:=gy1;
                   if (y<gy2)and(gy1>=gy2) then y:=gy2;
                   if (y>gy1)and(gy1>=gy2) then y:=gy1;
                   x:=gx1+(1/incl)*(y-gy1);
                 end;
               {if retino then} Tretino(x,y,true);
               setcolor(7);
               isocur(x,y,1);
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
                 y:=ye(x,y);
                 min:=10E6;
                 indmin:=1;
                 for i:=1 to ultriga do
                 with dis^[i] do

                 if (tronco >0)and(tronco<=ulttronco) then

                 if (entita='L')and (nlinea=0)and(flag)
                    and(dati^[tronco].pros[1]=0) then

                 if Dati^[tronco].Pezzi[1]<>0 then

                 begin
                   if abs(x-x2)+abs(y-y2)<min then
                   begin
                     if (xg(x2,y2)>0)and(xg(x2,y2)<900)and(yg(y2,z2)>45)and(yg(y2,z2)<750) then
                     begin
                       min:=abs(x-x2)+abs(y-y2);
                       indmin:=i;
                       trovato1:=true;
                     end;
                   end;
                 end;
                 x:=xg(dis^[indmin].x2,dis^[indmin].y2);
                 y:=yg(dis^[indmin].y2,dis^[indmin].z2);
                 movhcurabs(@x,@y);
                 Trattosel:=Indmin;
                 if not trovato1 then code:=130;
               end;

            11:begin              { selezione punto con isocur }
                 delhcur;
                 setclip(@xw1,@yw1,@xw2,@yw2);
                 MSnap(x,y,true);
                 int1:=7;
                 setcolor(int1);
                 isocur(x,y,1);
               end;

      end;
    end;
  end
  else
  begin
    code:=10;
   {if (cod=2)and(not iso) then isocur(x,y,1);}
  end;

  if (keypressed)then
    begin
    if lung<>0 then
      begin
      st:=readcom(stpino,'',0);
      if (st='') then tastofunz(exit_char);
      end
    else
      begin
      Tastofunz('O');
      st:='';
      end;
    end;

  until (st<>'')or(uscita<>0)or(code=132)or(code=130);
  case cod of
  1,2,11:begin
      (*int1:=47;int2:=52;int3:=1;int4:=10;
      ftinit;
      ftsize(@int3,@int4);
      ftlocate(@int1,@int2);
      stpino:='                               ';
      FText(@stpino);*)
      end;

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
        real4:=yg(dis^[i].y2,dis^[i].z2)-real2*xg(dis^[i].x2,dis^[i].y2);
        x:=(real4-real3)/(real1-real2);
        y:=real1*x+real3;
        if (abs(yp-y)<0.001)  then
        begin
          write(chr(7));
          richiesta(W_M(94)); { 'Le rette coincidono !'); }
          delay(1000);
          controllo:=false;
        end;
        if  (not (trovato)) then
        begin
          write(chr(7));
          richiesta(W_M(95)); { 'Non trovo l''intersezione con il terminale selezionato !');}
          delay(1000);
          controllo:=false;
        end
      end;

    8:begin
      int1:=0;
      setxor(@int1);
      end;

  end;

real1:=0;
real2:=ysp-1;
st1an:='                                               ';
movtcurabs(@real1,@real2);
text1(@st1an);
{
if (trattosel<>0)and(trattosel<300) then
writeln(lst,Nodo:,Dis^[trattosel].tronco)
else writeln(lst,'rc trattosel:',trattosel)
}
end;

{***************************  DisBoc     *****************************}

Procedure DisBoc(NL:integer);

Var NPZ:integer;
    Trovato:Boolean;
    Dir,Dirz:Real;
    X1L,Y1L:real;
    DimSim:real;

begin
DimSim:=50*100/Conf.Altnum;
if Dis^[NL].NLinea=0 then
if Dati^[Dis^[NL].tronco].Pros[1]=0 then
if Dati^[Dis^[NL].tronco].Pezzi[1]<>0 then
  begin
  NPZ:=0;
  Trovato:=false;
    repeat

    NPZ:=NPZ+1;
    if NPZ=PezziTr then trovato:=true
    else Trovato:=Dati^[Dis^[NL].tronco].Pezzi[NPZ+1]=0;

    until trovato;
  if VPezzi^[Dati^[Dis^[NL].tronco].Pezzi[NPZ]].Port<>0 then
    begin
    CalcDirez(NL,Dir,DirZ);
    if sezione then Dir:=Pi/2-DirZ;
    with Dis^[NL] do
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


{***************************  Disegna         *******************************}

Procedure Disegna(i:Integer);

var est:integer;
    app:boolean;

begin
if Dis^[i].entita<>'' then
case dis^[i].entita[1] of
        'L':begin
            {Writeln(lst,'Linea:',i);
            with dis^[i] do
            writeln(lst,X1:4:0,' ',y1:4:0,' ',z1:4:0,' ',X2:4:0,' ',y2:4:0,' ',z2:4:0,' ');}
            setlnstyle(@dis^[i].tlinea);
            real1:=xg(dis^[i].x1,dis^[i].y1);
            real2:=yg(dis^[i].y1,dis^[i].z1);
            {writeln(lst,Real1:4:0,'  ',Real2:4:0);}
            movabs1(@real1,@real2);

            real3:=3;
            int1:=11;
            setcolor(int1);
            if sezione then {-- Cerchi di sezione --}
              begin

              if App_sez(i,1,est,app) then
              if App then
                begin
                if est=1 then
                  begin
                  real1:=xg(dis^[i].x1,dis^[i].y1);
                  real2:=yg(dis^[i].y1,dis^[i].z1);
                  end
                else
                  begin
                  real1:=xg(dis^[i].x2,dis^[i].y2);
                  real2:=yg(dis^[i].y2,dis^[i].z2);
                  end;
                movabs1(@real1,@real2);
                cir(@real3);
                end;

              end
            else
              begin
              if Not UG(dis^[i].z1,dis^[i].z2,2) then
                begin
                if UG(dis^[i].z1,RisultCalc.Quota,2)then
                  begin
                  real1:=xg(dis^[i].x1,dis^[i].y1);
                  real2:=yg(dis^[i].y1,dis^[i].z1);
                  movabs1(@real1,@real2);
                  cir(@real3);
                  end;
                if Ug(dis^[i].z2,RisultCalc.Quota,2) then
                  begin
                  real1:=xg(dis^[i].x2,dis^[i].y2);
                  real2:=yg(dis^[i].y2,dis^[i].z2);
                  movabs1(@real1,@real2);
                  cir(@real3);
                  end;
                end

              end;

            movabs1(@real1,@real2);

            setLcolor(i);
            real1:=xg(dis^[i].x2,dis^[i].y2);
            real2:=yg(dis^[i].y2,dis^[i].z2);
            {writeln(lst,Real1:4:0,'  ',Real2:4:0);}
            lnabs1(@real1,@real2);
            with dis^[i] do
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

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  PArc          *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure PArc(Dxf:boolean);

const Ndiv1=20;
      Ndiv2=20;

var i,Ndiv:integer;
    xpr,ypr,Xcor,ycor,Rcor:real;
    StepAng,StepCos:real;
    angpr:real;
begin
if dxf then NDiv:=NDiv2 else NDiv:=NDiv1;


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
    real1:=Xg1(Xpr,0);
    real2:=Yg1(Ypr,0);
    MovAbs(@Real1,@Real2);
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
      real1:=Xg1(Xcor,0);
      real2:=Yg1(Ycor,0);
      LnAbs(@Real1,@Real2);
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



{**************************** SelezLinea ***********************************}

Function SelezLinea(var Numlinea:integer):integer;

Var i,res :integer;

begin
NumLinea:=0;
richiesta('');

if not vuoto then

  begin
  richiesta(W_M(49));  {'Selezionare tronco');}
  st1:='';
  readcord(x,y,cod,scelta,st1,3);
  delbox;
  delay(200);

    case cod of

    132:begin
        delbox;
        i:=0;
        res:=0;

        while (res=0) and (i<UltRiga) do

          begin
          i:=i+1;
          with dis^[i] do

            begin
            if (entita='L')and(flag) then
              begin
             { writeln(lst,' X1:',xg(x1,y1),' X2:',xg(x2,y2),' y1:',yg(y1,z1),' y2:',yg(y2,z2));}
              inters(real1,real2,res,xg(x1,y1),xg(x2,y2),x+5,x-5,yg(y1,z1),yg(y2,z2),y+5,y-5,0.001);
              if res=0 then
              inters(real1,real2,res,xg(x1,y1),xg(x2,y2),x-5,x+5,yg(y1,z1),yg(y2,z2),y+5,y-5,0.001);
              end;
            end;

          end;

        if res<>0 then
        NumLinea:=i
        else
          begin
          numlinea:=0;
          selezlinea:=130;
          richiesta(W_M(96));  { 'Nessun tronco selezionato'); }
          delay(800);
          end;

        end;

    else SelezLinea:=130;
    end;


  end

else

  begin
  Selezlinea:=130;
  NumLinea:=0;
  end

end;

{**************************** INSNODO *************************************}

   {-- Collega la nuova entita` Ntratto a Tratto sul grafo --}

Function InsNodo(Tratto,NTratto,Tipo,Nuovotr:integer):integer;
var i,titemp,TrTemp:integer;
    insertMode:boolean;

begin
  case tipo of
  1:begin                           {-- Interno ad un tronco --}
    CancNum(dis^[tratto].TRonco);
    initrec(NTronchi,1);
    TrTemp:=NTronchi;

    with dati^[ntronchi] do     {* E *}
      begin
      Ti:=dis^[tratto].nlinea;
      for i:=1 to 6 do  pros[i]:=Dati^[dis^[tratto].tronco].pros[i];
      {Term:=Dati^[dis^[tratto].tronco].Term;}
      end;

    dis^[tratto].nlinea:=0;     {* 1 *}

    i:=Dati^[NTronchi].Ti;      {* 2,.. *}
    repeat
      dis^[i].tronco:=NTronchi;
      i:=dis^[i].NLinea;
      if i<>0 then if dis^[i].entita='T' then
        begin
        dis^[i].tronco:=NTronchi;
        i:=0;
        end;
    Until i=0;


    if Nuovotr=0 then
      begin
      insertMode:=false;
      NTronchi:=NewTr;
      NuovoTr:=NTronchi;
      end
    else insertMode:=true;

    initrec(NuovoTr,1);
    dati^[NuovoTr].Ti:=Ntratto;   {* D *}
    InsNodo:=NuovoTr;

    titemp:=dati^[dis^[Tratto].tronco].Ti;
    initrec(dis^[Tratto].tronco,2);

    with dati^[dis^[Tratto].tronco] do    {* A *}
      begin
      Ti:=Titemp;
      Pros[1]:=NuovoTr;
      Pros[2]:=TrTemp;
      end;
    if not insertMode then Ntronchi:=Newtr;
    end;

  2:begin                              {-- Nodo finale --}
    CancNum(dis^[tratto].TRonco);
    dis^[tratto].nlinea:=Ntratto;  {* 2 *}
    InsNodo:=dis^[tratto].tronco;
    InitRec(dis^[tratto].tronco,4);
    end;

  3:begin                  {-- Nodo con rami --}

    with Dati^[Dis^[Tratto].Tronco] do
      begin

      i:=1;
      while (pros[i]<>0) and (i<6) do i:=I+1;
      if pros[i]<>0 then
        begin
        Write(chr(7));
        richiesta(W_M(97));  { 'Impossibile inserire altri tronchi sul nodo selezionato');}
        InsNodo:=0;
        end
      else
        begin
        if Nuovotr=0 then
          begin
          pros[i]:=Ntronchi;   {* A *}

          initRec(NTronchi,1);          {* D *}
          dati^[NTronchi].Ti:=NTratto;

          InsNodo:=NTronchi;
          Ntronchi:=Newtr;
          InitRec(dis^[tratto].tronco,4);
          end
        else
          begin
          pros[i]:=NuovoTr;
          InsNodo:=NuovoTr;
          end;
        end
      end

    end

  end

end;

{****************************** InitRec *************************************}

procedure initRec(indice,Modo:integer);

var i:integer;


begin

if Modo IN [2,3,4] then
  begin
  For i:=1 to Pezzitr do
  if Dati^[indice].Pezzi[i]<>0 then
    begin
    VPezzi^[dati^[indice].Pezzi[i]].Codice:='';
    Dati^[indice].Pezzi[i]:=0;
    end;
  end;

if modo=3 then
  begin

  with dati^[indice] do
    begin
    Num    :=0;
    x      :=0;
    y      :=0;
    end;
  end;

if modo IN [1,2] then
  begin

  with dati^[indice] do
    begin
    Num    :=0;
    x      :=0;
    y      :=0;
    for i:=0 to pezzitr do pezzi[i]:=0;
    Ti     :=0;
    for i:=1 to 6 do pros[i]:=0;
    end;
  end;

end;

{**************************** TIPONODO *************************************}

{-- Classifica il tipo di nodo in cui termina tratto --}

Function TipoNodo(Tratto:integer):integer;

begin
if dis^[tratto].nlinea<>0 then Tiponodo:=1 {-- interno ad un tronco --}
  else
  begin
  with dati^[dis^[tratto].tronco] do
  if pros[1]=0 then Tiponodo:=2       {--  nodo finale   --}
  else Tiponodo:=3;                   {--  nodo con rami --}
  end;
end;


{***************************  SetFlag         *******************************}

function SetFlag:boolean;

var i:integer;
    m1,m2,c1,c2:real;
    trovato:boolean;


begin

trovato:=false;

if sezione then
  begin
  if abs(xsup-xinf)>1 then
    begin
    m1:=(ysup-yinf)/(xsup-xinf);
    c1:=yinf-m1*xinf;
    end
  else
    begin
    m1:=10E6;
    c1:=xinf;
    end;

  if m1>1000 then
    begin
    m1:=10E6;
    c1:=xinf;
    end;
  M_Sez:=m1;
  C_sez:=c1;
(*
writeln(lst,' Finestra orz:',orz,{'  xs:',xsup:5:0,'ys:',ysup:5:0,'xi:',xinf:5:0,'yi:',yinf:5:0,}'m1:',m1:10:3,'c1:',c1:10:3);
*)
  end;

For i:=1 to ultriga do
with Dis^[i] do
if Entita<>'' then
  begin
  if sezione then
    begin
    if abs(x2-x1)>1 then
      begin
      m2:=(y2-y1)/(x2-x1);
      c2:=y1-m2*x1;
      end
    else
      begin
      m2:=10E6;
      c2:=x1;
      if abs(y2-y1)<10E-6 then  {-- Tratto Verticale --}
        begin
        if ((m1<10E2)and(abs(Y1-(m1*X1+c1))<10))or
           ((m1>=10E2)and(abs(x1-c1)<10)) then
          begin
          m2:=m1;
          c2:=c1;
          end
        end
      end;

    if m2>1000 then
    begin
    m2:=10E6;
    c2:=x1;
    end;

    if (abs(m1-m2)<0.1)and( (abs(c1-c2)<10)or
       ((m2>=10E2)and(abs(c2-c1)<10)) ) then

    Flag:=true
    else Flag:=false;
(*
   if  flag then
  writeln(lst,i,{' x2: ',x2:5:0,'y2: ',y2:5:0,'x1: ',x1:5:0,'y1: ',y1:5:0,}'m2: ',m2:10:3,'c2: ',c2:10:3,'F:  ',flag);
*)
    end
  else
    begin

    if  (abs(Z1-Z2)<10)and(abs(Z1-RisultCalc.Quota)<10) then Flag:=true
    else Flag:=false;
    {writeln(lst,i,' RisultCalc.Quota: ',RisultCalc.Quota:5:0,'  z2: ',z2:5:0,'  z1: ',z1:5:0,'  Flag:',Flag);}
    end;
  Trovato:=(trovato)or(flag);
  if (not(sezione))and(Ug(z2,risultCalc.quota,2)) Then Trovato:=true;
  end;
SetFlag:=trovato;
end;

{***************************  VER_SPEZ     *****************************}

Procedure Ver_spez(xs,ys,zs:real;Trattos:integer;Var Cod:integer);
begin
with Dis^[trattos] do
if ((Ug(xs,x1,2))and(Ug(ys,y1,2))and(Ug(zs,z1,2)))or
   ((Ug(xs,x2,2))and(Ug(ys,y2,2))and(Ug(zs,z2,2))) then
  begin
  Write(chr(7));
  Richiesta(W_M(98));  { 'Punto non corretto'); }
  Delay(500);
  Cod:=130;
  end;
end;

{***************************  NomeFile     *****************************}

Function NomeFile(Drive:string):String;

var Err:boolean;
    Nome:string;
begin
Err:=False;
repeat
if Not(Err) then
Nome:=ReadCom(W_M(99),'',0)  { 'Nome del file','',0) }
else Nome:=ReadCom(W_M(100),'',0);  { 'Introdurre nome corretto','',0); }
Err:=Not(ExistS(Drive+Nome))
Until (Nome='')or(Not(Err));
NomeFile:=Nome;
end;

end.