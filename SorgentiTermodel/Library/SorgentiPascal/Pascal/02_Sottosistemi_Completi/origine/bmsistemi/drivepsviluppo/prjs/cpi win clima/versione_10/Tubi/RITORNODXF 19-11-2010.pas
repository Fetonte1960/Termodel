{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit RITORNODXF;

INTERFACE

uses Definiz,angoli,math,libreriagenerale,varcarichi,sysutils,gestdim,ugrafodxf,collettori,dialogs,spirali;
//printer,definiz,globfunz,genproc,Angoli,Load_D,wm,controll;


Procedure DisRit;
Procedure DisRit3D(piano:string);

Procedure scaricaDXF(Colore,Tipolinea:string);
Procedure ArcoDxf2(piano:string;xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);

Var i:Integer;
{$Ifdef Debugtubi}
const dis_colle=false;
{$Else}
const dis_colle=false;
{$Endif}
{---------------------------------------------------------------------------}
implementation
uses leggidxf;
Var piano_dis:string='';
    dis_mand:boolean;
Procedure ArcoDxf2(piano:string;xl1,yl1,raggio,angin,angfin:real;layer,colore,tlinea:string);

Procedure angraccordi(Var angolo1,angolo2:real);
Var Temp:real;
begin
angolo1:=-angolo1;//antiorario
angolo1:=angolo1+PI/2; //origine orizzontale
angolo2:=-angolo2;//antiorario
angolo2:=angolo2+PI/2; //origine orizzontale
if angolo1 < 0 then
  begin
  angolo1:=angolo1+2*pi;
  angolo2:=angolo2+2*pi;
  end;
if angolo1 > 2*PI then
  begin
  angolo1:=angolo1-2*pi;
  angolo2:=angolo2-2*pi;
  end;
if (angolo2>angolo1)and(angolo2-angolo1>PI)then  //solo angoli acuti
  begin
  temp:=angolo1;
  angin:=angolo2;
  angolo2:=temp;
  end
else
if (angolo1>angolo2)and(angolo1-angolo2<PI)then  //solo angoli acuti
  begin
  temp:=angolo1;
  angolo1:=angolo2;
  angolo2:=temp;
  end;
//angolo:=angolo*180/pi;
//angolo1:=angolo1*180/pi;
end;
begin
angraccordi(angin,angfin);
Arco_dim(Piano,xl1,yl1,raggio,angin,angfin,layer,colore,tlinea);
end;
procedure Disrit_can;
type
      VetDim=record
             Codpezzo,gruppo:integer;
             Entita:string[1];
             Piano:string[30];
             Tlinea,Colore:integer;
             X1,Y1,X2,Y2,Z1,Z2:real;
             R,R2:real;
             end;
Var fDim:file of vetdim;
    bufdim:vetdim;
    temp:real;
    coltemp:string;
begin
if fileexists(IncludeTrailingPathDelimiter(PercorsoDrive) + 'disegnocanali.dsc') then
  begin
  assignfile(fdim,IncludeTrailingPathDelimiter(PercorsoDrive) + 'disegnocanali.dsc');
  try
    reset(fdim);
    while not eof(Fdim)do
    begin
      read(fdim,bufdim);
      with bufdim do
      case upcase(entita[1]) of
      'L','F','*':{lineadxf(x1,y1,x2,y2,Piano+'_CANALI','5','1')provvisoriamente per 3d };

      'Q':Begin
          //Testo(x1,y1,float_to_str(x2,2));
          end;
      'A'://Arco(x1,y1,R,x2,y2);
          begin
          coltemp:='5';
          {
          if (x2>Y2) then
            begin
            temp:=x2;
            x2:=y2;
            Y2:=temp;
            end;
          if x2<0 then
            begin
            x2:=x2+2*pi;
            y2:=y2+2*pi;
            end;
          if Y2>2*pi then
            begin
            x2:=x2-2*pi;
            y2:=y2-2*pi;
            end;

          if x2>3/2*pi then coltemp:='6'
          else if x2>pi then coltemp:='7'
          else if x2>pi/2 then coltemp:='8';
          {
          if (x2>Y2)or(x2>pi) then
            begin
            coltemp:='6';
            x2:=x2+pi;
            Y2:=y2+pi;
            end;
           }

          //arcodxf(x1,y1,R,x2{+pi},y2{+pi},Piano+'_CANALI',Coltemp,'1')provvisoriamente per 3d;
          end;
      end;
      end;
    close(Fdim);
  except
    Close(Fdim);
  end;
 end;
end;


Procedure Raccordo(ind1,ind2:integer;Raggio:real;Layer,Colore,tlinea:string;Var xpr2,ypr2:real);
Var Dir,DirZ,l1,lung1,lung2,ang1,ang2,xp1,yp1,xcen,ycen,xcen1,ycen1,angin,xp2,yp2,angfin:real;
orientam:integer;
Vert,arco:Boolean;
begin
debug_2d:=false;
arco:=false;
vert:=false;
CalcDirez(ind1,Dir,DirZ);
if ug(abs(dirz),Pi/2,1) then vert:=true;
CalcDirez(ind2,Dir,DirZ);
if ug(abs(dirz),Pi/2,1) then vert:=true;

CalcAng(ind1,ind2,Dir,DirZ,orientam,Vert,0);
if (abs(dir)>PI/100)and(not vert) then  //segmenti non allineati
begin
  with dis^[ind1]^ do
  lung1:=sqrt(sqr(x2-x1)+sqr(y2-y1));
  with dis^[ind2]^ do
  lung2:=sqrt(sqr(x2-x1)+sqr(y2-y1));
  if dir<0 then dir:=-dir;
  dir:=(pi-dir)/2;
  L1:=Raggio/tan(dir);
  //if l1>lung1 then //raccordo troppo ampio
  if l1>lung1/2 then //raccordo troppo ampio
  begin
    {raggio:=lung1*tan(dir);
    l1:=lung1; }
    raggio:=lung1/2*tan(dir);
    l1:=lung1/2;
  end;
 // if l1>lung2 then    //raccordo troppo ampio
  if l1>lung2/2 then    //raccordo troppo ampio
  begin
    {raggio:=lung2*tan(dir);
    l1:=lung2;   }
    raggio:=lung2/2*tan(dir);
    l1:=lung2/2;
  end;
  calcdirez(ind1,ang1,dirz);
  calcdirez(ind2,ang2,dirz);
  xp1:=0;Yp1:=lung1-l1;
  modicord1(xp1,yp1,dis^[ind1]^.x1,dis^[ind1]^.y1,ang1,1);
  xp2:=0;Yp2:=l1;
  modicord1(xp2,yp2,dis^[ind2]^.x1,dis^[ind2]^.y1,ang2,1);
  xcen:=raggio;
  Ycen:=0;
  modicord1(xcen,ycen,xp1,yp1,ang1,1);
  xcen1:=-raggio;
  Ycen1:=0;
  modicord1(xcen1,ycen1,xp2,yp2,pi+ang2,1);
  if not vicino(xcen,ycen,0,xcen1,ycen1,0) then
    begin
    xcen:=-raggio;
    Ycen:=0;
    modicord1(xcen,ycen,xp1,yp1,ang1,1);
    end;
  calc_D(xcen,ycen,0,xp1,yp1,0,angin,dirz);
  calc_D(xcen,ycen,0,xp2,yp2,0,angfin,dirz);
  arco:=true;
end
else
WITH dis^[ind1]^  DO
begin
  xp1:=x2;
  yp1:=y2;
  xp2:=x2;
  yp2:=y2;
end;
if (not dis^[ind1]^.cl)or (dis_colle) then
  begin
  linea_Dim(dis^[ind1]^.piano,xpr2,ypr2,xp1,yp1,layer,colore,tlinea);
  Lineadeb(dis^[ind1]^.piano,xpr2,ypr2,xp1,yp1,ind1,'1');
  end;
if arco then arcodxf2(dis^[ind1]^.piano,xcen,ycen,raggio,angin,angfin,layer,colore,tlinea);
xpr2:=xp2;
ypr2:=yp2;
end;



Procedure scaricaDXF(Colore,Tipolinea:string);
var i, j, ultj:integer;
     xp2,yp2,difarco,dir1,dirz:real;
    Ori      :Integer;
    Ud       :Real;
    Vert     :Boolean;
begin
//debug_2d:=true;
//for i:=1 to ulttronco do
//if (dati^[i]^.Term<>0) then
//with dis^[dati^[i]^.Ti]^ do
//Lineadeb(piano,x1,y1,x2,y2,i,'1');

debug_2d:=false;
for i:=1 to ulttronco do
if (dati^[i]^.Term<>0)and(cisono_collettori{dis^[dati^[i]^.Ti]^.cl  approfondire }) then
  begin
  j:=dati^[i]^.Ti;
  ultj:=0;
  xp2:=dis^[j]^.x1;
  Yp2:=dis^[j]^.y1;
  while dis^[j]^.nlinea<>0 do
    begin

    difarco:=manrit;
    if  dis^[j]^.flag then difarco:=-difarco;
    if (dis_mand)or(uppercase(copy(Gterm^[dati^[i]^.Term]^.tipoterm,1,4))='PANN')  then difarco:=0; //caso pannelli arco sui funghetti

    CalcAng(j,Dis^[j]^.NLinea,Dir1,DirZ,Ori,Vert,UD);
    if dir1<0 then difarco:=-difarco;

    {if false then //}if {j=dati^[i]^.Ti}dis^[j]^.CL then
    begin
      //raccordo(j,dis^[j]^.nlinea,0.2,dis^[j]^.piano+'_RITCOLLE',Colore,TipoLINEA,xp2,yp2);
      raccordo(j,dis^[j]^.nlinea,0.2+difarco,'ESECUTIVO_RETE',Colore,TipoLINEA,xp2,yp2);
    end
    else
    begin
      //raccordo(j,dis^[j]^.nlinea,0.2,dis^[j]^.piano+'_RITORNO',Colore,TipoLINEA,xp2,yp2);
      raccordo(j,dis^[j]^.nlinea,0.2+difarco,'ESECUTIVO_RETE',Colore,TipoLINEA,xp2,yp2);
    end;
    j:=dis^[j]^.nlinea;
    end;
  with dis^[j]^ do
    begin

  //lineadxf(xp2,yp2,x2,y2,piano+'_RITORNO',Colore,TipoLINEA);
  //  lineadxf(xp2,yp2,x2,y2,'ESECUTIVO_RETE',Colore,TipoLINEA);
      if (not cl)or (dis_colle) then
        begin
        linea_dim(piano,xp2,yp2,x2,y2,'ESECUTIVO_RETE',Colore,TipoLINEA);
        Lineadeb(piano,xp2,yp2,x2,y2,j,'1');
        end;
    end;
  end
else
  begin
  j:=dati^[i]^.Ti;
  while j<>0 do
    begin
    with dis^[j]^ do
    if cl then
      begin
       //lineadxf(x1,y1,x2,y2,piano+'_RITCOLLE',Colore,TipoLINEA);
      //lineadxf(x1,y1,x2,y2,'ESECUTIVO_RETE',Colore,TipoLINEA);
      if dis_colle then linea_Dim(Piano,x1,y1,x2,y2,'ESECUTIVO_RETE',Colore,TipoLINEA);
      end
    else
      begin
       //lineadxf(x1,y1,x2,y2,piano+'_RITORNO',Colore,TipoLINEA);
      //lineadxf(x1,y1,x2,y2,'ESECUTIVO_RETE',Colore,TipoLINEA);
      linea_dim(Piano,x1,y1,x2,y2,'ESECUTIVO_RETE',Colore,TipoLINEA);
      Lineadeb(piano,xp2,yp2,x2,y2,j,'1');
      end;

    with dis^[j]^ do
    if (dis_colle)or(not cl) then
    if nlinea=0 then
    Cerchio_Dim(Piano,x2,y2,0.005,'ESECUTIVO_RETE',Colore,TipoLINEA);

    j:=dis^[j]^.nlinea;
    end;

  end;

end;

Procedure DisRit_Tubi;
Var St1Dist  :string;
    DistRit  :Real;
    CodEr    :integer;
    XOri,YOri:ReaL;
    Ori      :Integer;
    Ud       :Real;
    Vert     :Boolean;
    ManritPr :Boolean;

Var Dir,Dir1,DirZ:Real;

{---------------------------------------------------------------------------}

Procedure IterRid(Tr:integer;Spostx,Xpr,YPr,ZPr,UD:Real);
Var i,j:Integer;
    Spx,spy:real;
    X1P,Y1P:real;
    Croce,is_rimando:Boolean;
    DirBr:Real;
    SetX2:Boolean;
    Prx,pry:real;
begin
debug3d_on:=false;
is_rimando:=false;
X1p:=XPr;
Y1p:=YPr;

Dati^[tr]^.x:=0;
Dati^[tr]^.Y:=0;

i:=Dati^[tr]^.Ti;


While Dis^[i]^.NLinea<>0 do    {-- Spostamento tronco --}
  begin

  CalcDirez(Dis^[i]^.NLinea,Dir,DirZ);
  if not ug(abs(dirz),Pi/2,1) then
    begin
    CalcAng(i,Dis^[i]^.NLinea,Dir1,DirZ,Ori,Vert,UD);
    if not(ug(dirz,0,1)) then
      begin
      Dir1:=Pi/2;
      if Dirz<0 then Dir1:=-Dir1;
      end;

    if dis^[i].rimando='B' then is_rimando:=true;

    CalcDirez(i,Dir,DirZ);
    spx:=spostx;
    spy:=-spostx*Sin(Dir1);
    //spy:=0;



    if ug(abs(dirz),Pi/2,1) then
      begin
      Dis^[i]^.X2:=X1P;
      Dis^[i]^.Y2:=Y1P;
      end
    else
      begin
      UD:=Dir;
      Dis^[i]^.flag:=(spx>0); //per disegnare correttamente l'arco
      Modicord1(spx,spy,0,0,dir,1);
      Dis^[i]^.X2:=Dis^[i]^.x2+spx;
      Dis^[i]^.Y2:=Dis^[i]^.Y2+spy;
      end;

    Dis^[i]^.X1:=X1p;
    Dis^[i]^.Y1:=Y1p;

    DebugL3d(i);

    i:=Dis^[i]^.NLinea;

    if Not(ug(abs(dirz),Pi/2,1)) then
      begin
      X1p:=Dis^[i]^.x1+Spx;
      Y1p:=Dis^[i]^.Y1+Spy;
      end
    else
      begin   //dopo un verticale ricomincia da 0
      x1p:=-DistRit;
      spostx:=x1p;
      y1p:=0;
      CalcDirez(i,Dir,DirZ);
      ModiCord1(x1p,y1p,dis^[i].x1,dis^[i].y1,Dir,1);
      end
    end
else
    begin
    spy:=0;
    CalcDirez(i,Dir,DirZ);
    if Not(ug(abs(dirz),Pi/2,1)) then
      begin
      ModiCord1(spostx,spy,0,0,Dir,1);
      Dis^[i]^.X2:=Dis^[i]^.x2+spostx;
      Dis^[i]^.Y2:=Dis^[i]^.Y2+spy;
      Dis^[i]^.X1:=X1p;
      Dis^[i]^.Y1:=Y1p;
      x1p:=Dis^[i]^.x2;
      y1p:=Dis^[i]^.y2;
      end
    else
      begin   //più tratti verticali in sequenza
      x1p:=-DistRit;
      spostx:=x1p;
      y1p:=0;
      CalcDirez(Dis^[i]^.NLinea,Dir,DirZ);
      ModiCord1(x1p,y1p,dis^[Dis^[i]^.NLinea].x1,dis^[Dis^[i]^.NLinea].y1,Dir,1);
      end  ;

    DebugL3d(i);

    i:=Dis^[i]^.NLinea;
    end;

end;


if Dati^[Dis^[i]^.Tronco]^.Pros[1]=0 then  {-- Terminale --}
  begin
  prx:=Dis^[i]^.X2;
  pry:=Dis^[i]^.y2;


  CalcDirez(i,Dir,DirZ);
  if Not(ug(abs(dirz),Pi/2,1)) then
    begin
    UD:=Dir;
    spx:=spostx;
    Spy:=0;

    Modicord1(spx,spy,0,0,dir,1);

    Dis^[i]^.X2:=Dis^[i]^.x2+spx;
    Dis^[i]^.Y2:=Dis^[i]^.Y2+spy;
    end
  else
    begin
    Dis^[i]^.X2:=X1p;
    Dis^[i]^.Y2:=Y1p;
    end;
  Dis^[i]^.X1:=X1p;
  Dis^[i]^.Y1:=Y1p;

  //lineadxf(prx,pry,Dis^[i]^.X2,Dis^[i]^.y2,Dis^[i]^.piano+'_RITORNO','5','');
  if Uppercase(copy(Gterm^[Dati^[Dis^[i]^.Tronco]^.Term ]^.TipoTerm,1,4))<>'PANN' then
    begin
    linea_dim(Dis^[i]^.piano,prx,pry,Dis^[i]^.X2,Dis^[i]^.y2,'ESECUTIVO_RETE','5','');
    end;
  DebugL3d(i);

end
else
  begin
  j:=1;
  DirBr:=-Pi/2;

  While (j<=6)and(Dati^[tr]^.Pros[j]<>0) Do
    begin
    CalcAng(i,Dati^[Dati^[tr]^.Pros[j]]^.Ti,Dir,DirZ,Ori,Vert,UD);  {-- Cerca Croci e TEE  -}

    if not(ug(dirz,0,1)) then  Dirbr:=Pi/2
    else
      begin
      If ((Dir>0.1)or(Dir<-0.1)) then
      if Dir>DirBr Then DirBr:=dir;
      end;
    j:=J+1;
    end;

  spx:=spostx;
  if (Dis^[i]^.CL)and(Dati^[tr]^.Pros[1]<>0)and(not Dis^[Dati^[Dati^[tr]^.Pros[1]]^.ti]^.cl) then spy:=0
  else
  spy:=-spostx*Sin(DirBr);

  CalcDirez(i,Dir,DirZ);
  if Not(ug(abs(dirz),Pi/2,1)) then
    begin
    Ud:=Dir;
    Modicord1(spx,spy,0,0,dir,1);

    Dis^[i]^.X2:=Dis^[i]^.x2+spx;
    Dis^[i]^.Y2:=Dis^[i]^.Y2+spy;
    end
  else
    begin
    Dis^[i]^.X2:=X1p;
    Dis^[i]^.Y2:=Y1p;
    end;

  Xpr:=Dis^[i]^.X2;
  Ypr:=Dis^[i]^.Y2;
  Zpr:=Dis^[i]^.Z2;

  Dis^[i]^.X1:=X1p;
  Dis^[i]^.Y1:=Y1p;

  DebugL3d(i);

  j:=1;
  While (j<=6)and(Dati^[tr]^.Pros[j]<>0) Do
    begin
    CalcAng(i,Dati^[Dati^[tr]^.Pros[j]]^.Ti,Dir,DirZ,Ori,Vert,UD);
    spx:=spostx;
    if (Dir < -0.1)and(DirBr>0.1)and(ug(dirz,0,1))then SpX:=-SpostX;
    IterRid(Dati^[tr]^.Pros[j],Spx,Xpr,Ypr,Zpr,UD);
    j:=J+1;
    end;
  end;

end;

{Main Principale}
Var i,j,ultj,ultr:integer;
Begin
  DistRit:=ManRit;
  disegnacollettori(true);
  Disegnapannelli;
  dis_mand:=true;
  scaricadxf('1','');

  if RisultCalc^.Origine<>0 then
    begin

    XOri:=-DistRit;//*40/conf^.AltNum;
    YOri:=0;
    CalcDirez(Dati^[RisultCalc^.Origine]^.Ti,Dir,DirZ);
    ModiCord1(XOri,YOri,Dis^[Dati^[RisultCalc^.Origine]^.Ti]^.X1,Dis^[Dati^[RisultCalc^.Origine]^.Ti]^.Y1,Dir,1);

    ITerRid(RisultCalc^.Origine,-DistRit{*40/conf^.AltNum},XOri,YOri,
          Dis^[Dati^[RisultCalc^.Origine]^.Ti]^.Z1,0);

    dis_mand:=false;
    scaricadxf('5','TR');

(*    For i:=1 to Ultriga do
      begin
      if Dis^[i]^.Entita='L' then
        begin
        Dis^[i]^.Color:='rosso'{conf^.RColore};
        Dis^[i]^.TLinea:=1{conf^.TLinea};
        end;
      if Dis^[i]^.Entita='T' then Dis^[i]^.Entita:='';
      end; *)

 (*
    ultr:=ultriga;
    for i:=1 to ultr do
    with dis^[i]^ do
      begin
      inc(ultriga);
      if dis^[ultriga]=nil then new(dis^[ultriga]);
      dis^[ultriga]^:=dis^[i]^;
      if dis^[ultriga]^.CL then
      LineaDxf(x1,y1,x2,y2,'P1_RITCOLLE','5')
      else LineaDxf(x1,y1,x2,y2,'P1_RITORNO','5');
      end;
*)
(*
new(dis^[ultriga+1]);
new(dis^[ultriga+2]);
with dis^[ultriga+1]^ do
  begin
  x1:=0;
  y1:=0;
  x2:=0;
  y2:=20;
  z1:=0;
  z2:=0;
  end;
with dis^[ultriga+2]^ do
  begin
  x1:=0;
  y1:=20;
  x2:=20;
  y2:=20;
  z1:=0;
  z2:=0;
  end;
  Raccordo(ultriga+1,ultriga+2,3,'P1_RITORNO','5');
  with dis^[ultriga+2]^ do
  lineadxf(x1,y1,x2,y2,'P1_RITORNO','5');
  *)
  end;
End;

Procedure DisRit;
begin
 Case Tipo_rete of
{$IFDEF CANALI}
  TrCanali: DisRit_Can;
{$ENDIF}
  TrTubi:DisRit_Tubi;
 end;

end;
Procedure DisRit3D(piano:string);
var dir,dirz,xtemp,ytemp:real;
    j,k,indln:integer;
    trov:boolean;
begin
InitF_dim(nome_rete);
// quote sul collettore
for j:=1 to ultriga do
if (not dis^[j].cl)and(dis^[j].Nlinea<>0)then
if (dis^[dis^[j].Nlinea]^.cl) then
  begin
  calcdirez(dis^[j].Nlinea,dir,dirz);
  Xtemp:=0;
  Ytemp:=-0.05;
  ModiCord1(Xtemp,Ytemp,dis^[dis^[j].Nlinea]^.x2,dis^[dis^[j].Nlinea]^.Y2,dir,1);
  trov:=false;
  for k:=1 to dati^[dis^[j]^.tronco]^.NPros do
  if not trov then
    begin
    indln:=dati^[dati^[dis^[j]^.tronco]^.pros[k]]^.ti;
    trov:=dis^[indln]^.nlinea=0;
    if not trov  then trov:=dis^[dis^[indln]^.nlinea]^.CL;
    Testo_Dim(dis^[j]^.Piano,dati^[dati^[dis^[j]^.tronco]^.pros[k]]^.Coddiam,Xtemp,Ytemp,Dir,'ESECUTIVO_RETE','3');
    end;
  end;

attivaoutbm:=false;
Piano_dis:=piano;
 Case Tipo_rete of
{$IFDEF CANALI}
  TrCanali: DisRit_Can;
{$ENDIF}
  TrTubi:DisRit_Tubi;
 end;

closeF_dim;
end;


end.
