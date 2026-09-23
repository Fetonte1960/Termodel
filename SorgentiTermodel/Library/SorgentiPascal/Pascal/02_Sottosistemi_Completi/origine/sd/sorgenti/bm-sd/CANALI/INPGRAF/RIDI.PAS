{$R+}
{$B-}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit Ridis_U;

INTERFACE

uses definiz,diseg,angoli,piante,halotp4,graph,gruti,
     WM,disdim,esiste;
procedure W_paint;
Procedure Ridis;

{---------------------------------------------------------------------------}
implementation

uses genproc,controll;

{**************************** RIDIS ****************************************}

procedure W_Paint;
var i,est:integer;
    app:boolean;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Leggip         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
procedure leggip;




type recdis=record mov:boolean;x,y:integer end;
     RECDIS1=ARRAY[1..nhpgl]OF RECDIS;

var fdis:file of recdis;
    FDIS1:FILE OF RECDIS1;
    hpgl1:RECDIS1;
    buf:recdis;
    trovpi:boolean;
    rigac:real;

const MaxEpiante=20;
      MaxSez    =20;

type

    RecPiante = record
                    NomeP  : string[8];
                    ZPMin  : real;
                    ZPMax  : real;
                end;

    EPianteAr = array[1..maxEPiante] of RecPiante;


var  EPt       :EPianteAr;
     Fept      :file of EPianteAr;
     TrovSez   :integer;

type
    RecSezioni = record
                    NomeP            : string[8];
                    XIns,YIns,XOri   :real;
                    YOri,ZOri,Orient : real;
                    Scala            :integer;
                    AS,BS,HS         : real;
                end;

    ElenSez = array[1..maxSez] of RecSezioni;

Var Sez    : ElenSez;
    fesez  : File of ElenSez;
    XiW,YiW,XsW,YsW,Dxs,Dys,Dir,Dirz,B1,A1,H1:real;
    Ingr_X,Ingr_Y,Spost_X,Spost_Y,xsp1,ysp1:real;
    i:integer;
    Xinf_R,Yinf_R,Xsup_R,Ysup_R,XPrec_R,YPrec_R:integer;
    Fuori:boolean;
{    palet:palettetype;}




{************************** Xg3    *****************************************}
Function Xg3(xpar:real):real;
var xsp1:real;
begin
  xsp1:=xsp;
  Xg3:=(xpar-Xiw)*xsp1/(xsw-xiw);
end;
{************************** Yg3    *****************************************}
Function Yg3(y:real):real;
begin
  Yg3:=ysp-(Y-Yiw)*ysp/(Ysw-Yiw)-s_up
end;

var Fersez:text;

begin
nomepianta:='';

if sezione then
  begin
  assign(fersez,DataDrive+w_m(149)+{'\progetti\}'ersez.doc');
  rewrite(feRsez);
  writeln(fersez,' Rapporto sull`inserimento delle sezioni');

  if exist(PianteDrive+eliminadir(Nomeprog)+'.sez') then
    begin
    assign(fesez,PianteDrive+eliminadir(Nomeprog)+'.sez');
    reset(fesez);
    read(fesez,Sez);
    close(Fesez);

    Calc_d(Xinf,Yinf,0,XSup,YSup,0,Dir,Dirz);

    i:=1;
    TrovSez:=0;
      repeat
      with Sez[i] do
      if NomeP<>'' then
        begin
        writeln(fersez,'sezione:',NomeP);
        if UG(Dir,Orient*Pi/180,1) then {-- Verifica la direzione --}
          begin
          A1:={(xsup+xinf)/2}PxSez*Conf.AltNum/40000-Xori;
          B1:={(Ysup+Yinf)/2}PYsez*Conf.AltNum/40000-Yori;

          Modicord1(A1,B1,0,0,-Dir+Pi/2,1);
          H1:={(ZSup+ZInf)/2}PZSez*Conf.AltNum/40000-Zori;

          if (B1<=0)and(B1>=-BS) then
            begin
            if (A1>=0)and(A1<=AS) then
              begin
              if (H1>=0)and(H1<=HS) then
                begin
                if (scala<>0)
                then {- Range attivazione -}
                  begin
                  NomePianta:=NomeP;
                  TrovSez   :=i;

                  dxs:=xinf-Xori*40000/Conf.AltNum;
                  dys:=yinf-Yori*40000/Conf.AltNum;
                  ModiCord1(dxs,dys,0,0,-Dir+Pi/2,1);
                  {XiW:=Xins+Dxs*Conf.Altnum/scala;}
                  XiW:=Xins*40000/scala+Dxs*Conf.Altnum/scala;

                  dxs:=xsup-Xori*40000/Conf.AltNum;
                  dys:=ysup-Yori*40000/Conf.AltNum;
                  ModiCord1(dxs,dys,0,0,-Dir+Pi/2,1);
                  {XsW:=Xins+Dxs*Conf.Altnum/scala;}
                  XsW:=Xins*40000/scala+Dxs*Conf.Altnum/scala;

                  YiW:=Yins*40000/scala+(Zinf-Zori*40000/Conf.AltNum)*Conf.Altnum/scala;

                  YsW:=Yins*40000/scala+(Zsup-Zori*40000/Conf.AltNum)*Conf.Altnum/scala;
                  end
                else writeln(fersez,'scala=0');
                end
              else writeln(fersez,'Punto di sezione fuori dai limiti in altezza');
              end
            else writeln(fersez,'Punto di sezione fuori dai limiti laterali');
            end
          else writeln(fersez,'Punto di sezione fuori dai limiti di profondita`');
          end
        else writeln(fersez,'Direzione della sezione non coerente');
        end;

(*      writeln(lst,'i:',i,'  dxs:',dxs:4:2,'  dys:',dys:4:2,'  A1:',A1:4:2,
             '  B1:',B1:4:2,'  H1:',H1:4:2,'  dir:',dir:4:2);
writeln(lst,' XiW:',XiW:5:0,' YiW:',YiW:5:0,' XsW:',XsW:5:0,' YsW:',YsW:5:0,' Zsup:',ZSup:5:0,' Zinf:',Zinf:5:0);*)
      i:=I+1;
      until (i>MaxSez)or(Nomepianta<>'');
    Nomesez:=nomepianta;
    end
  else Writeln(fersez,'Elenco sezioni:',PianteDrive+eliminadir(Nomeprog)+'.sez non trovato');
  CLOSE(fersez);
  end
else
  begin
  ZMax_P:=10E6;
  ZMin_P:=-10E6;
  if exist(PianteDrive+eliminadir(Nomeprog)+'.pnt') then
    begin
    assign(fept,PianteDrive+eliminadir(Nomeprog)+'.pnt');
    reset(fept);
    read(fept,Ept);
    close(Fept);
    i:=1;
      repeat
      with EpT[i] do
      if nomeP<>'' then
        begin
        if (RisultCalc.Quota*Conf.AltNum/40000>=ZPmin)and(RisultCalc.Quota*Conf.AltNum/40000<=ZPmax) then
          begin
          Nomepianta:=NomeP;
          ZMax_P:=ZPmax*40000/Conf.AltNum;
          ZMin_P:=ZPmin*40000/Conf.AltNum;
          end;
        end;
      i:=I+1;
      until (i>MaxEPiante)or(Nomepianta<>'');
    end;
  end;

if sezione then rigac:=40*(Zsup-Zinf)/750
else rigac:=40*(Ysup-Yinf)/750;

trovpi:=true;
if not(exist(Piantedrive+(NomePianta)+'.dlt')) then
  begin
  if exist(PianteDrive+(NomePianta)+'.plt') then
  Leggiplt(PianteDrive+NomePianta)
  else TrovPi:=False;
  end;
if trovpi then
  begin
  {richiesta(nomepianta);}
  if sezione then
    begin
    {Xiw:=XiW-22717;
    YiW:=YiW-17937;
    Xsw:=XsW-22717;
    Ysw:=YsW-17937;}
    setworld(@real1,@real2,@real3,@real4);
    real3:=real3-(real3-real1)*0.1;
    real2:=real2+(real4-real2)*(1-710/750);
    end
  else
    begin
    real1:=xinf-22717;
    real2:=yinf-17937;
    real3:=xsup-22717;
    real4:=ysup-17937;
    setworld(@real1,@real2,@real3,@real4);
    real3:=real3-(real3-real1)*0.1;
    real2:=real2+(real4-real2)*(1-710/750);
    end;

  if xw2 < Max_wx then setclip(@xw1,@yw1,@xw2,@yw2)
  else setclip(@xw1,@yw1,@Max_wx,@yw2);
  assign(fdis1,piantedrive+NomePianta+'.dlt');
  reset(fdis1);
  setcolor(8);

  xsp1:=xsp;
  ysp1:=ysp;

  if sezione then
    begin
    ingr_X :=xsp1/(xsw-xiw);
    spost_X:=(22717.0-Xiw)*xsp1/(xsw-xiw);

    ingr_Y :=-Ysp1/(Ysw-Yiw);
    spost_Y:=ysp1-(17937.0-Yiw)*Ysp1/(Ysw-Yiw)-s_up;
    {
    writeln(lst,'  Xiw:',Xiw:6:0,'  Yiw:',Yiw:6:0,'  XSW:',Xsw:6:0,'  YSW:',Ysw:6:0);
    }

    if XiW > 0  then Xinf_R:=Round(XiW-22717) else Xinf_R:=-22717;
    if YiW > 0  then Yinf_R:=Round(YiW-17937) else Yinf_R:=-17937;
    if XsW < 45434  then Xsup_R:=Round(XsW-22717) else Xsup_R:=22717;
    if YsW < 35874  then Ysup_R:=Round(YsW-17937) else Ysup_R:=17937;

    end
  else
    begin
    ingr_X :=xsp1/(xsup-xinf);
    spost_X:=(22717.0-Xinf)*xsp1/(xsup-xinf);

    ingr_Y :=-Ysp1/(Ysup-Yinf);
    spost_Y:=ysp1-(17937.0-Yinf)*Ysp1/(Ysup-Yinf)-s_up;

    Xinf_R:=Round(Xinf-22717);
    Yinf_R:=Round(Yinf-17937);
    Xsup_R:=Round(XSup-22717);
    Ysup_R:=Round(YSup-17937);

    end;



{  if (memo_im=Nomepianta)and(memo_pi) then
    begin
    setpalette(8,0);
    for i:=1 to Nfette do
    putimage(0,(i-1)*fetta,Punt_im[i]^,normalput);
    GetDefaultPalette(Palet);
    setAllPalette(Palet);
    memo_pi:=false;
    end
  else}
  begin
  while not eof(fdis1) do
  BEGIN
  READ(FDIS1,HPGL1);
  for i:=1 to nhpgl do
    begin
    if HPGL1[i].mov  then
      begin
      XPrec_R:=hpgl1[i].X;
      YPrec_R:=hpgl1[i].Y;
      fuori:=true;
      end
    else
      begin
      if (fuori)and(
         ((hpgl1[i].X <XInf_R)and(XPrec_R <XInf_R))or
         ((hpgl1[i].X >XSup_R)and(XPrec_R >XSup_R))or
         ((hpgl1[i].Y <YInf_R)and(YPrec_R <YInf_R))or
         ((hpgl1[i].Y >YSup_R)and(YPrec_R >YSup_R)))  then
        begin
        XPrec_R:=hpgl1[i].X;
        YPrec_R:=hpgl1[i].Y;
        fuori:=true;
        end
      else
        begin
        if fuori then
          begin

          real1:=XPrec_R*ingr_X+Spost_X;
          real2:=YPrec_R*ingr_Y+Spost_Y;

          XPrec_R:=Round(real1);
          YPrec_R:=Round(real2);
          end;

        real1:=hpgl1[i].X*ingr_X+Spost_X;
        real2:=hpgl1[i].Y*ingr_Y+Spost_Y;

        int1:=round(real1);
        int2:=round(real2);

        line(XPrec_R,YPrec_R,int1,int2);
        XPrec_R:=int1;
        YPrec_R:=int2;

        Fuori:=false;
        end;
      end
    end;

  end;
  close(fdis1);
  {$R+}
  {$S+}
  end;
{  if save_im then
    begin
    for i:=1 to nfette do
    getimage(0,(i-1)*fetta,LarW,i*fetta,Punt_im[i]^);
    Memo_im:=nomepianta;
    Save_im:=false;
    end;}
  end;
end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*}

procedure griglia;
var i:integer;
    grid,xsmin,xsmax,ysmin,ysmax,zsmin,zsmax,xcor,ycor:real;
    snx:boolean;
    stepx,stepy:real;

procedure inverti(var val1,val2:real);
var temp:real;
begin
temp:=val1;
val1:=val2;
val2:=temp;
end;

begin
if conf.griglia<> 0 then
  begin
  int1:=7;
  setcolor(int1);
  grid:=conf.griglia*40000/conf.altnum;

  if ((snapx)or(abs(ysup-yinf)<10E-6))and(abs(xsup-xinf)>10E-6) then snx:=true
  else snx:=false;

  if sezione then
    begin
    if snx then
      begin
      xsmin:=xg(round(xinf/grid)*grid,0);
      xsmax:=xg(round(xsup/grid)*grid,0);
      if xsmin>xsmax then inverti(xsmin,xsmax);
      stepx:=abs(xg(grid,0)-xg(0,0));
      end
    else
      begin
      xsmin:=round(yinf/grid)*grid;
      xsmin:=(xsmin-yinf)*1000/(ysup-yinf);
      xsmax:=round(ysup/grid)*grid;
      xsmax:=(xsmax-yinf)*1000/(ysup-yinf);
      if xsmin>xsmax then inverti(xsmin,xsmax);
      stepx:=abs((grid-yinf)*1000/(ysup-yinf)-(-yinf)*1000/(ysup-yinf));{yg..}
      end;


    ysmin:=yg(0,round(zinf/grid)*grid);
    ysmax:=yg(0,round(zsup/grid)*grid);
    if ysmin>ysmax then inverti(ysmin,ysmax);
    stepy:=abs(yg(0,grid)-yg(0,0));
    end

  else

    begin
    xsmin:=xg(round(xinf/grid)*grid,0);
    xsmax:=xg(round(xsup/grid)*grid,0);
    if xsmin>xsmax then inverti(xsmin,xsmax);
    stepx:=abs(xg(grid,0)-xg(0,0));
    ysmin:=yg(round(yinf/grid)*grid,0);
    ysmax:=yg(round(ysup/grid)*grid,0);
    if ysmin>ysmax then inverti(ysmin,ysmax);
    stepy:=abs(yg(grid,0)-yg(0,0));
    end;

  if (stepx>5)and(stepy>5) then
    begin
    ycor:=ysmin;
    xcor:=xsmin;

    while ycor<=ysmax do
      begin
      while xcor<=xsmax do
        begin
        ptabs1(@xcor,@ycor);
        xcor:=xcor+stepx;
        end;
      ycor:=ycor+stepy;
      xcor:=xsmin;
      end;
    end
  else richiesta(W_M(59)); {'Griglia troppo fitta'); }
  end;
end;

begin
Salva_val:=1;
int1:=0;
setxor(@int1);
  setcolor(c1);
  if rinfr_menu then
    begin
    setclip(@minxw,@minyw,@maxxw,@maxyw);
    clr;
    rinfresca;
    setclip(@xw1,@yw1,@xw2,@yw2)
    end
  else
    begin
    setworld(@minxw,@minyw,@maxxw,@maxyw);
    if xw2 < Max_wx then setclip(@xw1,@yw1,@xw2,@yw2)
    else setclip(@xw1,@yw1,@Max_wx,@yw2);
    clr;
    end;

Salva_val:=2;
  int1:=8;
  setcolor(int1);
  leggip;

Salva_val:=3;
  griglia;

Salva_val:=4;

  if (RisultCalc.DisDimens)and(not(sezione)) then
    begin
    real1:=1;

    if ((exist(DataDrive+NomeProg+'.DIM'))and(Not Sezione))Or
       ((exist(DataDrive+NomeProg+'.qqq'))and(Sezione)) then
      begin
      If Sezione Then Assign(Fdim,DataDrive+NomeProg+'.qqq')
      ELse Assign(Fdim,DataDrive+NomeProg+'.DIM');
      Reset(Fdim);
      While not(eof(Fdim)) do
        begin
        read(Fdim,Vettore);
        disegna_dim(Vettore,0);
        end;
      close(FDim);
      end
    end;

{  else }
Salva_val:=5;
if RisultCalc.disUnif then
    begin
    int1:=11;
    setcolor(int1);
    for i:=1 to Ultriga do
    if (dis^[i]^.entita<>'')and(not dis^[i]^.Flag) then
      begin
        case dis^[i]^.entita[1] of
        'L':if(
               ((dis^[i]^.z1>=Zmin_p)and(dis^[i]^.z1<=Zmax_p))or
               ((dis^[i]^.z2>=Zmin_p)and(dis^[i]^.z2<=Zmax_p))
              )or (sezione) then
            begin
            setlnstyle(@dis^[i]^.tlinea);

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
                if UG(dis^[i]^.z1,RisultCalc.Quota,2)then
                  begin
                  real1:=xg(dis^[i]^.x1,dis^[i]^.y1);
                  real2:=yg(dis^[i]^.y1,dis^[i]^.z1);
                  movabs1A(@real1,@real2);
                  cir(@real3);
                  end;
                if Ug(dis^[i]^.z2,RisultCalc.Quota,2) then
                  begin
                  real1:=xg(dis^[i]^.x2,dis^[i]^.y2);
                  real2:=yg(dis^[i]^.y2,dis^[i]^.z2);
                  movabs1A(@real1,@real2);
                  cir(@real3);
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
Salva_val:=6;
    for i:=1 to Ultriga do
    if (dis^[i]^.entita<>'')and(dis^[i]^.Flag) then
      begin
      Disegna(i);
      end;
    end;
Salva_val:=7;
if (RisultCalc.Nodi)and(RisultCalc.DisUnif) then disNumeri(14);

real1:=0;real2:=40;real3:=1000;real4:=750;
setclip(@real1,@real2,@real3,@real4);
Salva_val:=8;
if rinfr_menu then Filo(Conf.RColore);
deltcur;
scelta:=0;
end;

Procedure Ridis;
begin
{$ifdef win}
ridisegna;
{$Else}
W_paint;
{$endif}
end;
end.