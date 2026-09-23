
Unit Angoli;

Interface

Uses Definiz,libreriagenerale;

Type RecVert=Array[1..3]of boolean;

Function UG(A,B:Real;Tipo:integer):Boolean;
function ArcSin(SinAng:real):real;
Procedure Calc_D(X1,Y1,Z1,X2,Y2,Z2:real;Var Dir,DirZ:real);
Procedure CalcDirez(Tratto:integer;Var Dir,DirZ:real);
Procedure CalcDirez_I(Tratto:integer;Var Dir,DirZ:real);

Procedure CalcAng(Tratto,tratto1:integer;Var Dir,DirZ:real;var orientam:integer;Var Vert:Boolean;UD:real);
Procedure
CalcDirez1(Tratto,Tratto1:integer;Var Dir,DirZ:real;var UltAng:real;Dev:Boolean;Var CanVert:Boolean;Var Inverti:boolean);
procedure
SETBRANCH(Entr,Nusc:integer;Var Main,Br1,Br2,Orient:integer;
          Var Vert:RecVert;UltDir:real;InvEntr:boolean;Var InvUsc:RecVert;var invmain:boolean);
Procedure Set_UD(tr:integer;Var UltDir:real;Var Inver:Boolean);
Function Format360(ang:real):real;
Function NotVert:real;
Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);
function CodAngolo(Direz: Real; Diram: Boolean): String;
Function Ang_acad(ang:real):real;
Function Ang_Rad(ang:real):real;
function P_vic1(x1,y1,z1,x2,y2,z2,apr:real):boolean;
procedure inters1(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr:real);
procedure intersPann(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr,passo:real);
Function Sovrapposte(x1,x2,x3,x4,y1,y2,y3,y4,apr:real):integer;


Var motivoInters:string;
    stmotivo:boolean=false;

Implementation
{----------------------------------------------------------------------------}
Function Ang_acad(ang:real):real;
begin
result:=90-ang*180/pi;
end;
Function Ang_Rad(ang:real):real;
begin
result:=PI/2-ang*pi/180;
end;
{----------------------------------------------------------------------------}

function CodAngolo(Direz: Real; Diram: Boolean): String;
begin
 Direz := Direz * 180 /PI;
 if Direz < 0 then Direz := -Direz;
 if (Direz > 10) and (Diram)  then Result := '30';
 if (Direz > 10) and (not Diram)  then Result := '45';
 if (Direz > 65) and (not Diram) then Result := '90';
 if (Direz > 50) and (Diram) then Result := '60';
 if (Direz > 75) and (Diram) then Result := '90';
end;


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



{***************************  Format360     *****************************}

Function Format360(ang:real):real;

begin
if ang<-0.01 then ang:=2*pi+ang;
if ang+0.01>=2*PI then ang:=ang-2*pi;
Format360:=ang;
end;


{***************************  UG              *******************************}

Function UG(A,B:Real;Tipo:integer):Boolean;

{-- 1=Angoli 2=Distanze 3=equazioni retta--}

Const Apr:Array[1..3]of real =(0.1,10,7);

begin
if Abs(A-B)<Apr[Tipo] then UG:=True else UG:=False;
end;


function ArcSin(SinAng:real):real;

var
 CosAng,TanAng:real;

 begin
    CosAng:=sqrt(1-(SinAng*SinAng));
    if cosang<>0 then
      begin
      TanAng:=SinAng/CosAng;
      ArcSin:=arctan(TanAng);
      end
    else
      begin
      if sinang>0 then ArcSin:=PI/2
      else ArcSin:=-PI/2;
      end;
 end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Calc_D       *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Calc_D(X1,Y1,Z1,X2,Y2,Z2:real;Var Dir,DirZ:real);

var dist:real;

begin
if y2=y1 then
  begin
  if x2>=x1 then Dir:=pi/2 else Dir:=(3/2)*pi;
  end
else
  begin
  if y2>y1 then
    begin
    Dir:=arctan((x2-x1)/abs(y2-y1));
    end
  else
    Dir:=pi-arctan((x2-x1)/abs(y2-y1));
  end;

if Dir<-0.01 then Dir:=2*pi+Dir;
if Dir+0.01>=2*PI then Dir:=Dir-2*pi;

if Z1=Z2 then
DirZ:=0
else
  begin
  dist:=sqrt(sqr(x2-x1)+sqr(y2-y1)+sqr(z2-z1));
  dirz:=arcsin((z2-z1)/dist);
  end

end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  CalcDirez     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure CalcDirez(Tratto:integer;Var Dir,DirZ:real);

begin
with Dis^[Tratto]^ do
  begin
  Calc_D(X1,Y1,Z1,X2,Y2,Z2,Dir,dirZ);
  {writeln(lst,X1:4:0,'  ',Y1:4:0,'  ',Z1:4:0,'  ',X2:4:0,'  ',Y2:4:0,'  ',Z2:4:0,'  ',Dir:5:2,'  ',dirZ:5:2,'  ');}
  end;
end;

Procedure CalcDirez_I(Tratto:integer;Var Dir,DirZ:real);

begin
with Dis_I^[Tratto]^ do
  begin
  Calc_D(X1,Y1,Z1,X2,Y2,Z2,Dir,dirZ);
  {writeln(lst,X1:4:0,'  ',Y1:4:0,'  ',Z1:4:0,'  ',X2:4:0,'  ',Y2:4:0,'  ',Z2:4:0,'  ',Dir:5:2,'  ',dirZ:5:2,'  ');}
  end;
end;
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  CalcAng     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}


Procedure CalcAng(Tratto,tratto1:integer;Var Dir,DirZ:real;var orientam:integer;Var Vert:Boolean;UD:real);

Var AngAr,Ang1,dist,Dir1,Dirz1:real;

begin

if Tratto>0 then

  begin
  with dis^[tratto]^ do
  if y2=y1 then
    begin
    if x2>=x1 then angar:=pi/2 else angar:=(3/2)*pi;
    end
  else
    begin
    if y2>y1 then
      begin
      angar:=arctan((x2-x1)/abs(y2-y1));
      end
    else
    angar:=(pi-arctan((x2-x1)/abs(y2-y1)));
    end;

  if angar<0 then angar:=2*pi+angar;
  end

else angar:=UD;

with dis^[tratto1]^ do
if y2=y1 then
  begin
  if x2>=x1 then ang1:=pi/2 else ang1:=(3/2)*pi;
  end
else
  begin
  if y2>y1 then
    begin
    ang1:=arctan((x2-x1)/abs(y2-y1));
    end
  else
  ang1:=(pi-arctan((x2-x1)/abs(y2-y1)));
  end;

if ang1<0 then ang1:=2*pi+ang1;

Dir:=ang1-angar;
if Dir > pi then Dir:=-(2*pi-Dir);
if Dir<-pi then Dir:=(2*pi+Dir);


CalcDirez (Tratto,Dir1,Dirz);

if(UG(dirz,0,1))then
  begin
  CalcDirez (Tratto1,Dir1,Dirz);
  if Ug(dirz,0,1) then
    begin
    if dir >0 then orientam:=1 else orientam:=3;
    Vert:=False;
    end
  else
    begin
    Dir:=0;
    if dirZ >0 then orientam:=4 else orientam:=2;
    Vert:=true;
    end
  end
else
  begin
  if dirZ >0 then orientam:=6 else orientam:=5;
  CalcDirez (Tratto1,Dir1,Dirz1);
  if UG(Dirz1,0,1) then Vert:=false else Vert:=true;
  Dir:=0;
  Dirz:=Dirz1-Dirz;
  if Dirz > pi then Dirz:=-(2*pi-Dirz);
  if Dirz< -pi then Dirz:=(2*pi+Dirz);
  end

end;



{*-*-*-*-*-*-*-*-*-*-*-*-*-*  CalcDirez1     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure
CalcDirez1(Tratto,Tratto1:integer;Var Dir,DirZ:real;var UltAng:real;Dev:Boolean;Var CanVert:Boolean;Var Inverti:Boolean);

var dist,Dir1,DirZ1:real;
    Tr2Ori:Boolean;       {- Elimina errore sulle croci verticali --}

begin
TR2Ori:=False;
CanVert:=False;
CalcDirez(Tratto,Dir,DirZ);
if abs(abs(dirz)-Pi/2)<0.1 then
  begin
  {writeln(lst,'Verticale');}
  CanVert:=true;
  if dev then
    begin
    CalcDirez(Tratto1,Dir,DirZ1);
    if abs(abs(dirz1)-Pi/2)<0.1 then
      begin
      {writeln(lst,'Assegna:',UltAng*180/pi:3:0);}
      Dir:=UltAng
      end
    else
      begin
      TR2Ori:=True;

      if not(UG(Dir,UltAng,1)) then
        begin
        {writeln(lst,'Prima dir:',Dir:3:2,'  UltAng:',Ultang:3:2,' inv:',inverti);}
        Dir1:=Dir+Pi;
        if Dir1+0.1>=2*Pi then dir1:=Dir1-2*Pi;
        if not(UG(Dir1,UltAng,1)) then
        inverti:=not(inverti);
        {writeln(lst,'dir1:',Dir1:3:2,'  UltAng:',Ultang:3:2,' inv:',inverti);}
        end;
      end;
    end
  else dir:=UltAng;

  end;
if Not (Tr2Ori) then UltAng:=dir;
{Writeln(lst,'  UA:',Ultang*180/pi:3:0);}
{writeln(lst,' CalcDirez1 dopo dir:',Dir:3:2,'  UltAng:',Ultang:3:2);}
end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  SETBRANCH              *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}



Procedure

SETBRANCH(Entr,Nusc:integer;Var Main,Br1,Br2,Orient:integer;
          Var Vert:RecVert;UltDir:real;InvEntr:boolean;Var InvUsc:RecVert;var invmain:boolean);

Var k          :integer;
    Dir,DirZ   :Array[0..3]of real;
    Ori        :integer;
    TrovatoMain:Boolean;
    vrt        :boolean;
    Dire1,Dire2:real;
    Stacco     :Boolean;
    UltDir1    :real;

begin
  For K:=1 to 3 do Vert[k]:=False;
  Stacco:=False;
  Main:=0;Br1:=0;Br2:=0;
  orient:=1;
  UltDir1:=UltDir;
  for k:=0 to Nusc do
  begin
    if K>0 then  {-- Tronchi in uscita con lati invertiti --}
    begin
      InvUsc[k]:=InvEntr;
      CalcDirez1(entr,Dati^[Dati^[Dis^[entr]^.tronco]^.pros[k]]^.Ti,Dire1,Dire2,
                 UltDir1,true,Vert[k],InvUsc[k]);
    end;
    if k=0 then CalcDirez(Entr,Dir[k],DirZ[k])
    else CalcDirez(Dati^[Dati^[Dis^[entr]^.tronco]^.pros[k]]^.Ti,Dir[k],DirZ[k]);
    if (k>0) then
    if UG(abs(DirZ[k]),Pi/2,1) then Vert[k]:=True else Vert[k]:=False;
    {writeln(lst,'k:',k,' Dir:',Dir[k]:4:2,' Dirz:',Dirz[k]:4:2);}
  end;
  InvMain    :=False;
  TrovatoMain:=False;
  for k:=1 to Nusc do
  begin
    if (UG(Dir[k],Dir[0],1))and(UG(dirZ[k],DirZ[0],1))then
    begin
      TrovatoMain:=true;
      InvMain:=true;    {-- Inversione dimensioni del main --}
      Main:=k;
    end;
  end;

  if UG(DirZ[0],0,1) then
  begin
    InvMain:=false;
    for k:=1 to Nusc do
    if K<>Main Then
    Begin
      CalcAng(Entr,Dati^[Dati^[Dis^[entr]^.tronco]^.pros[k]]^.Ti,Dir[k],DirZ[k],Ori,Vrt,UltDir1);
      if (UG(DirZ[k],0,1)) then
      Begin
        if (Dir[k]<0.1) then
        begin
          Orient:=3;
          if Nusc=2 then Br1:=k else Br2:=k
        end
        else
        begin
          Orient:=1;
          if not(trovatoMain) then Main:=k
          else Br1:=k;
        end
      end
      else
      Begin
        if (DirZ[k]>0.1) then
        begin
          Orient:=4;
          if Nusc=2 then Br1:=k else Br2:=k
        end
        else
        begin
          Orient:=2;
          if not(trovatoMain) then Main:=k
          else Br1:=k;
        end
      end
    end
  end
  else
  begin
    for k:=1 to Nusc do
    if K<>Main Then
    Begin
      {Writeln(lst,'Nusc:',Nusc,' Ultdir:',Ultdir:4:2,' Dir[k]:',Dir[k]:4:2);}
      Dir[K]:=Dir[k]-UltDir;
      if Dir[k] >  (pi-0.1) then Dir[k]:=-(2*pi-Dir[k]);
      if Dir[k] < -(pi+0.1) then Dir[k]:= (2*pi+Dir[k]);
      {Writeln(lst,'dopo  Dir[k]:',Dir[k]:4:2);}
      if (Dir[k]>=-0.1) then
      begin
        if Nusc=2 then Br1:=k else Br2:=k
      end
      else
      begin
        if not(trovatoMain) then Main:=k
        else Br1:=k;
      end;
    end;
    if DirZ[0]<0 then Orient:=5 else Orient:=6;
  end;
  if (nusc=2) then
  begin
    if (br1=1) then main:=2 else main:=1;
    if (main=1) then br1:=2 else br1:=1;
  end;

  if (nusc=3)  then
  begin
    if (br1<>1)and(br2<>1) then main:=1
    else
    if (br1<>2)and(br2<>2) then main:=2
    else
    if (br1<>3)and(br2<>3) then main:=3;

    if (main<>1)and(br2<>1) then br1:=1
    else
    if (main<>2)and(br2<>2) then br1:=2
    else
    if (main<>3)and(br2<>3) then br1:=3;

    if (br1<>1)and(main<>1) then br2:=1
    else
    if (br1<>2)and(main<>2) then br2:=2
    else
    if (br1<>3)and(main<>3) then br2:=3;

  end;

end;

{***************************  Set_UD     *****************************}

Procedure Set_UD(tr:integer;Var UltDir:real;Var Inver:Boolean);

var i:integer;
    Dir,Dirz:real;
    UD_1:Real;
    CanVert:Boolean;

begin

i:=Dati^[tr]^.Ti;
repeat

UD_1:=UltDir;
if Dis^[i]^.NLinea<>0 then
CalcDirez1(i,Dis^[i]^.Nlinea,Dir,DirZ,UD_1,true,CanVert,Inver);

calcDirez(i,Dir,Dirz);
if abs(abs(dirz)-Pi/2)>0.1 then
UltDir:=Dir;
i:=Dis^[i]^.NLinea;
until i=0;

end;

{***************************  NotVert     *****************************}

   {-- Trova il primo tronco non verticale --}

Function NotVert:real;
Var trovato:boolean;
    Dir,DirZ:real;

Function Not_V(tr1:integer;var trov:boolean):real;
Var i:integer;

begin
Not_V:=0;
i:=dati^[tr1]^.Ti;
while (dis^[i]^.Nlinea<>0)and(not(trov)) Do
  repeat
  CalcDirez(i,Dir,DirZ);
  if Not(UG(abs(DirZ),PI/2,1)) then
    begin
    trov:=true;
    Not_V:=Dir;
    end;
  i:=Dis^[i]^.NLinea;
  Until (i=0)or(trov);

for i:=1 to 3 Do
if (not(trov))and(Dati^[tr1]^.Pros[i]<>0) then
Not_V:=Not_V(Dati^[tr1]^.Pros[i],trov);

end;

Begin
Trovato:=false;
NotVert:=Not_V(RisultCalc^.Origine,Trovato);
end;

function P_vic1(x1,y1,z1,x2,y2,z2,apr:real):boolean;
begin
result:=(abs(x2-x1)<apr)and(abs(y2-y1)<apr)and(abs(z2-z1)<apr);
end;

procedure interspann(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr,passo:real);
var  m1,m2,c1,c2,max1,max2,min1,min2:real;

begin
if stmotivo then motivoInters:='';

if ( (abs(x1-x3)<= apr) and (abs(y1-y3)<= apr) )or  // verifica che gli estremi non sitocchino
   ( (abs(x1-x4)<= apr) and (abs(y1-y4)<= apr) )or
   ( (abs(x2-x3)<= apr) and (abs(y2-y3)<= apr) )or
   ( (abs(x2-x4)<= apr) and (abs(y2-y4)<= apr) ) then
   begin
   if stmotivo then motivoInters:='Gli estremi non si toccano';
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

if ((max1-min2)>= -passo) and ((max2-min1)>= -passo) then
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
   if ((max1-min2)>= -passo)and ((max2-min1)>= -passo) then
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
         ((x-x1<=+apr)or(x-x2<=+apr))and
         ((y-y1>=-apr)or(y-y2>=-apr))and
         ((y-y1<=+apr)or(y-y2<=+apr))and
         ((x-x3>=-apr)or(x-x4>=-apr))and
         ((x-x3<=+apr)or(x-x4<=+apr))and
         ((y-y3>=-apr)or(y-y4>=-apr))and
         ((y-y3<=+apr)or(y-y4<=+apr)) then res:=1

      else
        begin
        if ((x-x1>=-apr)or(x-x2>=-Passo))and { verifica se il punto e' esterno  ai segmenti ma dist < del passo}
         ((x-x1<=+apr)or(x-x2<=+Passo))and  //escluso il punto iniziale
         ((y-y1>=-apr)or(y-y2>=-Passo))and
         ((y-y1<=+apr)or(y-y2<=+Passo))and
         ((x-x3>=-Passo)or(x-x4>=-Passo))and
         ((x-x3<=+Passo)or(x-x4<=+Passo))and
         ((y-y3>=-Passo)or(y-y4>=-Passo))and
         ((y-y3<=+Passo)or(y-y4<=+Passo)) then res:=2
        else
          begin
          if stmotivo then motivoInters:='Intersezione x:'+float_to_str(x,2)+' y:'+float_to_str(y,2)+' fuori dai segmenti';
          res:=0;
          end;
        end;
      end
    else
      begin
      if stmotivo then motivoInters:='Linee parallele';
      res:=0;
      end;
    end
  else
    begin
    if stmotivo then motivoInters:='I range della Y non si sovrappongono';
    res:=0;
    end;
  end
else
  begin
  if stmotivo then motivoInters:='I range della X non si sovrappongono';
  res:=0;
  end;
end;

procedure inters1(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4,apr:real);
var  m1,m2,c1,c2,max1,max2,min1,min2:real;

begin

if ( (abs(x1-x3)<= apr) and (abs(y1-y3)<= apr) )or  // verifica che gli estremi non sitocchino
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
         ((x-x1<=+apr)or(x-x2<=+apr))and
         ((y-y1>=-apr)or(y-y2>=-apr))and
         ((y-y1<=+apr)or(y-y2<=+apr))and
         ((x-x3>=-apr)or(x-x4>=-apr))and
         ((x-x3<=+apr)or(x-x4<=+apr))and
         ((y-y3>=-apr)or(y-y4>=-apr))and
         ((y-y3<=+apr)or(y-y4<=+apr)) then res:=1

      else  res:=0;

      end
    else res:=0;
    end
  else res:=0;
  end
else res:=0;
end;
Function Sovrapposte(x1,x2,x3,x4,y1,y2,y3,y4,apr:real):integer;
var  m1,m2,c1,c2,max1,max2,min1,min2,temp:real;

begin
result:=0; exit;
//riduzione dei vettori al primo e secondo quadrante
if x2<x1 then
  begin
  temp:=x1;
  x1:=x2;
  x2:=temp;
  temp:=y1;
  y1:=y2;
  y2:=temp;
  end;
if x4<x3 then
  begin
  temp:=x3;
  x3:=x4;
  x4:=temp;
  temp:=y3;
  y3:=y4;
  y4:=temp;
  end;

 //verifica che gli intervalli X si intersecano
max1:=x2;
min1:=x1;
max2:=x4;
min2:=x3;

if ((max1-min2)>= -apr) and ((max2-min1)>= -apr) then  //verifica che gli intervalli Y si intersecano
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
   if ((max1-min2)>= -apr)and ((max2-min1)>= -apr) then   //verifica che gli intervalli Y si intersecano
    begin
    if abs(x2-x1)>10E-6 then m1:=(y2-y1)/(x2-x1)
    else m1:=10E6;
    c1:=y1-m1*x1;
    if m1=10E6 then  //Linea verticale
      begin
      if ((x4-x3)<apr)and((x3-x1)<apr)then result:=1;
      end
    else
      begin
      if ((y3-(x3*m1+c1)<apr))and((y4-(x4*m1+c1)<apr))then result:=1;
      end;
    end
  end
end;
end.



