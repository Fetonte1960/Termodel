unit UOggetti;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GLWin32Viewer, ExtCtrls, GLScene, GLObjects, GLMisc, StdCtrls,
  ComCtrls,geometry,gltexture,glextrusion{,libreriagenerale,CalcolaZ,varcarichi},geometria,variabili3d;


Procedure fissaingr(mnx,mxx,mny,mxy,mnz,mxz:real);
Procedure comando(riga:string);
Procedure InitVariabili;
Procedure Paretesemp(Q,x1,y1,x2,y2,spes,alt:real;filo:char;codesp:string);
Procedure Parete(Q,upa,upb,x1,y1,x2,y2,spes,alt:real;filo:char;h1,h2:real;colore:Tcolori3d);
Procedure Linea(x1,y1,z1,x2,y2,z2,spes:real;Color:Tcolori3d);
Procedure SettaIngr;
Procedure Curvaret(ang,r,w1,w2,h,roll,turn,pitch:real);
Procedure Pavimento(spes,Quota:real;Colore:Tcolori3d;ox,oy,fing,incfalda,orifalda:real);
Procedure ModiProf(rot,ing:real);
Procedure AzzeraBuchi;
Procedure addbuco(xc,yc,zc,lb,hb:real);
Procedure Parallelepi(Q,x1,y1,dir,lung,spes,alt:real;Colore:Tcolori3d);
Procedure DisegnaCanali(Nome:string;colore:Tcolori3d);
Procedure SnapOggetto;
Procedure Init_ogg;

type vettore=record x,y,z:real; end;

Var sc,p1,p2,p:vettore;
const Maxprof=300;
Type punto=record V:boolean;x1,y1,z1,x2,y2,z2:real  end;
     TProf=array[1..maxprof]of punto;
var Prof:TProf;
    NProf:integer;

Const Maxbuchi=50;
Type Tbuchi=array[1..Maxbuchi]of record
                                xxc,YYc,zzc,LLb,HHb:real
                                end;
Var Nbuchi:integer;
    buchi:Tbuchi;
    DcBloccoTurnAng,DcBloccoRollAng,DcBloccoPOs:TDummycube;


const Maxogg=10000;
type Rlistaogg=record
              prog:string[50];
              tipo:integer;
              ind:integer;
              end;
PListaogg=^RListaogg;
Vetlistaogg=array[1..Maxogg]of PListaogg;
Var Listaogg_D:^Vetlistaogg;
    Nogg,pezzosel:integer;
implementation
uses u3dsd;

(*
procedure TForm1.FormCreate(Sender: TObject);
var
	x, y, z : Integer;
	cube : TCube;
	factor, cubeSize : Single;
begin
	// bench only creation and 1st render (with lists builds, etc...)
	factor:=70/(cSize*2+1);
	cubeSize:=0.4*factor;
	for x:=-cSize to cSize do for y:=-cSize to cSize do for z:=-cSize to cSize do begin
		cube:=TCube(DummyCube1.AddNewChild(TCube));
		cube.Position.AsVector:=PointMake(factor*x, factor*y, factor*z);
		cube.CubeWidth:=cubeSize;
		cube.CubeHeight:=cubeSize;
		cube.CubeDepth:=cubeSize;
      with cube.Material.FrontProperties do begin
         Diffuse.Color:=VectorLerp(clrYellow, clrRed, (x*x+y*y+z*z)/(cSize*cSize*3));

         // uncomment following lines to stress OpenGL with more color changes calls

//         Ambient.Color:=VectorLerp(clrYellow, clrRed, (x*x+y*y+z*z)/(cSize*cSize*3));
//         Emission.Color:=VectorLerp(clrYellow, clrRed, (x*x+y*y+z*z)/(cSize*cSize*3));
//         Specular.Color:=VectorLerp(clrYellow, clrRed, (x*x+y*y+z*z)/(cSize*cSize*3));
      end;
	end;
end;
 *)
Procedure Init_ogg;
Var i:integer;
begin
pezzosel:=0;
Nogg:=0;
New(listaogg_d);
for i:=1 to MaxOgg do listaogg_d[i]:=nil;
end;

Var {scx,scy,scz,x1,y1,z1,x2,y2,z2,px,py,pz,}spessore,altezza,rollang,Pitchang,Turnang:real ;
    Maxx,MaxY,Maxz,Minx,Miny,Minz,MinA,MaxA:real;

{ TODO -oDiego -cNavigazione : snap oggetto }

Procedure settacolore(Dcc:Tdummycube;sel:boolean);
Var i:integer;
begin
with dcc do
for i:=0 to count-1 do
  begin
  if Children[i] is Tdummycube then
  settacolore(Children[i] as Tdummycube,sel)
  else
  if Children[i] is Tglsceneobject then
    begin
    if sel then
      begin
      (Children[i] as Tglsceneobject).Material.FrontProperties.diffuse.Color:=VectorLerp(clrred,clrred,0);
      (Children[i] as Tglsceneobject).Material.FrontProperties.emission.Color:=clrbronze;
      end
    else
      begin
      (Children[i] as Tglsceneobject).Material.FrontProperties.diffuse.Color:=clrwhite;
      (Children[i] as Tglsceneobject).Material.FrontProperties.ambient.Color:=clrDarkWood;
      (Children[i] as Tglsceneobject).Material.FrontProperties.emission.Color:=clrDarkWood;
      end;
    end;
  end;
end;

Procedure SnapOggetto;
Var i,j,cmin,jmin:integer;
    dist,distmin,xx,yy,zz:real;
begin
cmin:=-1;
distmin:=10E9;
for i:=0 to form1.DCOggetti.count-1 do
if form1.DCOggetti.Children[i] is Tdummycube then
  begin
  //for j:=0 to (form1.DCOggetti.Children[i] as Tdummycube).count-1 do
  //if ((form1.DCOggetti.Children[i] as Tdummycube).Children[j]  is Tdummycube ) then
  if (form1.DCOggetti.Children[i] as Tdummycube).Tag>0 then
  with  (form1.DCOggetti.Children[i] as Tdummycube) do
    begin
    settacolore(form1.DCOggetti.Children[i] as Tdummycube,false);
    xx:=form1.DCoggetti.Position.X+Position.X;
    yy:=form1.DCoggetti.Position.y+Position.y;
    zz:=form1.DCoggetti.Position.z+Position.z;
    dist:=sqrt(
        sqr(xx-form1.DCgenerale.Position.X)+
        sqr(yy-form1.DCgenerale.Position.y)+
        sqr(zz-form1.DCgenerale.Position.z)
               );

    if dist<Distmin then
       begin
       distmin:=dist;
       cmin:=i;
       end;
     end;
  end;
if cmin<>-1 then
  begin
  Pezzosel:=(form1.DCOggetti.Children[Cmin] as Tdummycube).Tag;
  with listaOgg_d^[pezzosel]^ do
  form1.Vis_pezzi_can(Prog,ind);
  settacolore(form1.DCOggetti.Children[Cmin] as Tdummycube,true);
  end;
end;
{ TODO -oDiego -cNavigazione : Box,cilindro (disegno) }
Procedure CuboB(a,b,c,px,py,pz,rolla,turn,pitch:real);
Var oggetto:Tcube;
begin
with form1 do
  begin
  oggetto:=TCube(DCBloccoRollang.AddNewChild(TCube));
  turnang:=turn;//+PI/2;
  pitchang:=pitch+PI/2;
  rollang:=rolla;
  p.x:=px;
  p.y:=py;
  p.z:=pz;
  sc.x:=a;
  sc.y:=b;
  sc.z:=c;

  {$I Settaproprieta.pas}

  end;
end;

Procedure Cilindro(D,l,px,py,pz,rolla,turn,pitch:real);
Var oggetto:TCylinder;
begin
with form1 do
  begin
  oggetto:=TCYlinder(DCBloccoRollang.AddNewChild(TCylinder));
  turnang:=turn;//+PI/2;
  pitchang:=pitch;//+PI/2;
  rollang:=rolla;
  p.x:=px;
  p.y:=py;
  p.z:=pz;
  sc.x:=1;
  sc.y:=1;
  sc.z:=1;

  {$I Settaproprieta.pas}
  oggetto.Height:=l;
  oggetto.TopRadius:=d/2;
  oggetto.BottomRadius:=d/2;
  end;
end;

Procedure NuovoDcBlocco(dx,dy,dz,rolla,turna,pitcha:real;nomefile:string;Indp:integer);
begin
Inc(Nogg);
if listaogg_d^[Nogg]=nil then  new(listaogg_d^[Nogg]);
listaogg_d^[Nogg]^.prog:=Nomefile;
listaogg_d^[Nogg]^.Tipo:=1;
listaogg_d^[Nogg]^.ind:=Indp;

with form1 do
  begin
  DcBloccoPOs:=TDummyCube(DCOggetti.AddNewChild(TDummyCube));
  DcBloccoPOs.Tag:=Nogg;
  DcBloccoturnAng:=TDummyCube(DcBloccoPOs.AddNewChild(TDummyCube));
  DcBloccorollAng:=TDummyCube(DcBloccoturnAng.AddNewChild(TDummyCube));
  end;
with dcbloccopos do
  begin
  position.X:=dx;
  position.y:=dy;
  position.z:=dz;
  end;
dcbloccoTurnang.turnangle:=turna*180/Pi;
dcbloccorollang.rollangle:=rolla*180/Pi;
end;
Procedure InserDcBlocco(dx,dy,dz,rolla,turna,pitcha:real);
begin

with dcbloccopos do
  begin
  //showaxes:=true;
  //tag:=10;
  if tag=pezzosel then settacolore(dcbloccopos,true);
  position.X:=dx;
  position.y:=dy;
  position.z:=dz;
  end;
dcbloccoturnang.rollangle:=turna*180/Pi;
dcbloccorollang.Pitchangle:=rolla*180/Pi;
end;


Procedure ModiProf(rot,ing:Real);
Var i:integer;
begin
if rot=0 then exit;
for i:=1 to NProf do
with prof[i] do
  begin
  modicord1(x1,y1,0,0,rot,ing);
  modicord1(x2,y2,0,0,rot,ing);
  end;
end;

function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;




Procedure fissaingr(mnx,mxx,mny,mxy,mnz,mxz:real);
begin
Minx:=mnx;
Maxy:=-mxx;
Miny:=mny;
Maxy:=mxy;
Minz:=mnz;
Maxz:=mxz;
end;

Procedure InitVariabili;
begin
NumEntita:=0;
MinA:=10E6;
MaxA:=-10E6;
Minx:=10E6;
Maxx:=-10E6;
Miny:=10E6;
Maxy:=-10E6;
Minz:=10E6;
Maxz:=-10E6;
p1.x:=0;
p1.Y:=0;
p1.z:=0;
p2.x:=1;
p2.Y:=1;
p2.z:=1;
p.x:=0;
p.Y:=0;
p.z:=0;
sc.x:=1;
sc.Y:=1;
sc.z:=1;
spessore:=1;
Altezza:=1;
ingrbase:=50;
end;

{Procedure Parete;
begin
with form1 do
  begin
  end;
end;}

Procedure TestRange(Valore:real;var min,max:real);
begin
if Valore>Max then Max:=Valore;
if Valore<Min then min:=Valore;
end;


Procedure Cubo;
Var oggetto:Tcube;
begin
with form1 do
  begin
  oggetto:=TCube(DCOggetti.AddNewChild(TCube));
  {$I Settaproprieta.pas}
  end;
end;

Procedure Cubo1;
Var oggetto:TDisk;
begin
with form1 do
  begin
  oggetto:=TDisk(DCOggetti.AddNewChild(Tdisk));
  {$I Settaproprieta.pas}
  end;
end;

Function CalcAng(xx,yy:real;codesp:string):real;
begin
result:=0;
end;



Procedure Pavimento(spes,Quota:real;Colore:Tcolori3d;ox,oy,fing,incfalda,orifalda:real);
Var oggetto:TExtrusionsolid;
    dcube:Tdummycube;
    i,j:integer;
    trov:boolean;
    //Fing:real;
begin
//orifalda:=0;
//incfalda:=0;
//if incfalda<>0 then
//  begin
//  quota:=5;
//  incfalda:=0;
//  end;
fing:=1/cos(incfalda*PI/180);
//if orifalda=0 then
  begin
  //quota:=-quota;
  //incfalda:=-incfalda;
  end;
//quota:=-quota{-1.5};
if form1.RBscheletro.Checked then exit;
if colore=Cschel then exit;
Colorecor_3d:=colore;
spes:=0.01;
sc.x:=1;
sc.y:=Fing;
sc.z:=1;
p.x:=ox;
p.y:=oy;
//POsfalda(p.x,p.y,fing,Namb);
turnang:=0;
//pitchang:=-IncFalda*PI/180;
pitchang:=IncFalda*PI/180;
//pitchang:=0;
//rollang:=orifalda-PI/2;
rollang:=0;
p.z:=0;//-Quota;

with form1 do
  begin
  {------------------------ Profilo diretto -----------------------------------------}

  dcube:=Tdummycube(DCOggetti.AddNewChild(Tdummycube));
  oggetto:=TExtrusionsolid(DCube.AddNewChild(TExtrusionsolid));
  {$I Settaproprieta.pas}
  oggetto.Height:=spes;
  oggetto.NormalDirection:=ndOutside;
  oggetto.parts:=[espOutside,espStartPolygon,espStopPolygon];
  with Oggetto.Contours do
    begin
      with Add.Nodes do
        begin
        for i:=1 to nprof do Prof[i].V:=false;
        i:=1;
        repeat
        with Prof[i] do
          begin
          AddNode(Prof[i].x1,Prof[i].y1,0);
          v:=true;
          trov:=false;
          j:=1;
          while (j<Nprof)and(not Vicino(Prof[j].x1,Prof[j].y1,0,x2,y2,0) or Prof[j].v)do inc(j);
          trov:=Vicino(Prof[j].x1,Prof[j].y1,0,x2,y2,0) and Not(Prof[j].v);
          end;
        if trov then i:=j;
        until  not trov;
        end;
      //Add;
    end;
  dcube.Position.X:=-oggetto.Position.X;
  dcube.Position.y:=-oggetto.Position.y;
  dcube.Position.z:=Quota;
  dcube.PitchAngle:=0;
  //dcube.PitchAngle:=0;
  dcube.RollAngle:=orifalda*180/PI-90;
  //dcube.RollAngle:=90;
  dcube.scale.y:=1;
  oggetto.Position.z:=0;
  {------------------------ Profilo inverso -----------------------------------------}
  dcube:=Tdummycube(DCOggetti.AddNewChild(Tdummycube));
  oggetto:=TExtrusionsolid(DCube.AddNewChild(TExtrusionsolid));
  {$I Settaproprieta.pas}
  oggetto.Height:=spes;
  oggetto.NormalDirection:=ndOutside;
  oggetto.parts:=[espOutside,espStartPolygon,espStopPolygon];
  with Oggetto.Contours do
    begin
      with Add.Nodes do
        begin
        for i:=1 to nprof do Prof[i].V:=false;
        i:=1;
        repeat
        with Prof[i] do
          begin
          AddNode(Prof[i].x2,Prof[i].y2,0);
          v:=true;
          trov:=false;
          j:=1;
          while (j<Nprof)and(not Vicino(Prof[j].x2,Prof[j].y2,0,x1,y1,0) or Prof[j].v)do inc(j);
          trov:=Vicino(Prof[j].x2,Prof[j].y2,0,x1,y1,0) and Not(Prof[j].v);
          end;
        if trov then i:=j;
        until  not trov;
        end;
    end;
  dcube.Position.X:=-oggetto.Position.X;
  dcube.Position.y:=-oggetto.Position.y;
  dcube.Position.z:=Quota;
  dcube.PitchAngle:=0;
  //dcube.PitchAngle:=0;
  dcube.RollAngle:=orifalda*180/PI-90;
  //dcube.RollAngle:=90;
  dcube.scale.y:=1;
  oggetto.Position.z:=0;
  end;
end;
Procedure Parete(Q,upa,upb,x1,y1,x2,y2,spes,alt:real;filo:char;h1,h2:real;colore:Tcolori3d);
Var oggetto:TExtrusionsolid;
    dcube:Tdummycube;
    i,j:integer;
    trov:boolean;
    dir,dirz,spoX,SpoY,lung,Pbuco:real;
const rtn=0.04;
begin
//q:=-q;
Colorecor_3d:=colore;
spes:=0.01;
SpoY:=0;
case filo of
'C':spoX:=0;
'S':spoX:=spes/2;
'D':spoX:=-spes/2;
end;
//Spox:=0;
//spoy:=spoy+spes;
inc(NumEntita);
TestRange(x1,minX,MaxX);
TestRange(y1,minY,MaxY);
TestRange(x2,minX,MaxX);
TestRange(y2,minY,MaxY);
TestRange(Q,minZ,MaxZ);
TestRange(Q+h1,minZ,MaxZ);
TestRange(Q+h2,minZ,MaxZ);
calc_d(x1,y1,0,x2,y2,0,dir,dirz);
if spox<>0 then
modicord1(spox,spoy,0,0,dir,1);
p.x:=(x1+x2)/2+spox;
p.y:=(y1+y2)/2+spoy;
p.z:=Q{+1.5};
lung:=sqrt(sqr(x2-x1)+sqr(y2-y1))/2;
rollang:=-dir+PI/2;
//rollang:=0;
sc.x:=1;
sc.y:=1;
sc.z:=1;
PitchAng:=0;
turnang:=-PI/2;

with form1 do
  begin
  dcube:=Tdummycube(DCOggetti.AddNewChild(Tdummycube));
  oggetto:=TExtrusionsolid(DCube.AddNewChild(TExtrusionsolid));
  {$I Settaproprieta.pas}
  //spes:=0.01;
  oggetto.Height:=spes;
  oggetto.NormalDirection:=ndOutside;
  oggetto.parts:=[espOutside,espStartPolygon,espStopPolygon];
  with Oggetto.Contours do
    begin
      with Add.Nodes do
        begin
        AddNode(upb,-lung, -spes/2);
        AddNode(h2+upb, -lung, -spes/2);
        AddNode(h1+upa, lung, -spes/2);
        AddNode(upa, lung, -spes/2);

        if (form1.RBscheletro.Checked)or (colore=cschel) then
          begin
          AddNode(RTN+upa, lung-RTN, -spes/2);
          AddNode(h1-RTN+upa, lung-RTN, -spes/2);
          AddNode(h2-RTN+upb, -lung+RTN, -spes/2);
          AddNode(RTN+upb,-lung+RTN, -spes/2);
          AddNode(RTN+upa, lung-RTN, -spes/2);
          end
        else
        for i:=1 to Nbuchi do
        with buchi[i] do
          begin
          Pbuco:=sqrt(sqr(xxc-x2)+sqr(yyc-y2))-lung;
          AddNode(upa+zzc-hhb/2, Pbuco+llb/2, -spes/2);
          AddNode(upa+zzc+hhb/2, Pbuco+llb/2, -spes/2);
          AddNode(upb+zzc+hhb/2, Pbuco-llb/2, -spes/2);
          AddNode(upb+zzc-hhb/2,Pbuco-llb/2, -spes/2);
          AddNode(upa+zzc-hhb/2,Pbuco+llb/2, -spes/2);
          end;

        AddNode(upa, lung, -spes/2);
        end;
    end;
  dcube.Position.X:=0;
  dcube.Position.y:=0;
  dcube.Position.z:=0;
  dcube.PitchAngle:=0;
  dcube.TurnAngle:=0;
  //dcube.ShowAxes:=true;

  end;
end;
{ TODO -oDiego -cNavigazione : Curva (Disegno) }
Procedure Curvaret(ang,r,w1,w2,h,roll,turn,pitch:real);
Var oggetto:TRevolutionsolid;
    dcubePOs,dcubePitch:Tdummycube;
    ofx,ofy:real;
begin
sc.x:=1;
sc.y:=1;
sc.z:=1;
p.x:=0;
p.y:=0;
p.z:=0;
rollang:=0;
turnang:=0;
pitchang:=0;
//ofx:=-W1/2;
ofy:=0;
ofx:=0;
//r:=r*w1;//+0.05;
//ofy:=0;
with form1 do
  begin
  dcubePitch:=Tdummycube(DCbloccorollang.AddNewChild(Tdummycube));
  dcubePOs:=Tdummycube(dcubePitch.AddNewChild(Tdummycube));
  oggetto:=TRevolutionsolid(dcubePOs.AddNewChild(TRevolutionsolid));
  {$I Settaproprieta.pas}
  with oggetto.nodes do
    begin
    (*
    Add;Last.x:=r;Last.y:=r+ofy;Last.Z:=0;
    Add;Last.x:=r+w1+ofx;Last.y:=r+ofy;Last.Z:=0;
    Add;Last.x:=r+w1+ofx;Last.y:=r+h+ofy;Last.Z:=0;
    Add;Last.x:=r+ofx;Last.y:=r+h+ofy;Last.Z:=0;
    Add;Last.x:=r+ofx;Last.y:=r+ofy;Last.Z:=0;
    Add;Last.x:=r+ofx;Last.y:=r+h+ofy;Last.Z:=0;
    Add;Last.x:=r+w1+ofx;Last.y:=r+h+ofy;Last.Z:=0;
    Add;Last.x:=r+w1+ofx;Last.y:=r+ofy;Last.Z:=0;
    Add;Last.x:=r+ofx;Last.y:=r+ofy;Last.Z:=0;
    *)
    Add;Last.x:=r+ofx;Last.y:=ofy;Last.Z:=0;
    Add;Last.x:=r+w1+ofx;Last.y:=ofy;Last.Z:=0;
    Add;Last.x:=r+w1+ofx;Last.y:=h+ofy;Last.Z:=0;
    Add;Last.x:=r+ofx;Last.y:=h+ofy;Last.Z:=0;
    Add;Last.x:=r+ofx;Last.y:=ofy;Last.Z:=0;
    Add;Last.x:=r+ofx;Last.y:=h+ofy;Last.Z:=0;
    Add;Last.x:=r+w1+ofx;Last.y:=h+ofy;Last.Z:=0;
    Add;Last.x:=r+w1+ofx;Last.y:=ofy;Last.Z:=0;
    Add;Last.x:=r+ofx;Last.y:=ofy;Last.Z:=0;

    end;
  dcubePOs.Position.X:=H/2;
  dcubePOs.Position.y:=-W1/2-r;
  dcubePOs.Position.z:=(W1/2+r)*tan((ang/2)*pi/180);
  //dcube.ShowAxes:=true;
  oggetto.Position.y:=0;
  oggetto.Position.X:=0;
  //oggetto.Position.y:=0;
  oggetto.Position.z:=0;
  //oggetto.ShowAxes:=true;
  oggetto.StartAngle:=0;
  oggetto.StopAngle:=ang;
  (*
  dcubePitch.RollAngle:=roll*180/pi;
  dcubePitch.turnAngle:=turn*180/pi;
  dcubePitch.pitchAngle:=pitch*180/pi;
  *)
  dcubePitch.RollAngle:=0;
  dcubePitch.turnAngle:=270;//form1.Test1.Position*3.6;
  dcubePitch.pitchAngle:=0;
  end;
end;

{ TODO -oDiego -cNavigazione : Trasformazione (Disegno) }
Procedure riduz(T1,w1,H1,T2,w2,h2,L,Dw,Dh,px,py,pz,rolla,turna,pitcha:real);
Var oggetto:TPolygon;
    dcube:Tdummycube;
    ofx,ofy:real;
begin

with form1 do
  begin
  Dcube:=TDummycube(DCBloccoRollang.AddNewChild(TDummycube));
  with Dcube do
    begin
    turnangle:=turna*180/pi;//+PI/2;
    pitchangle:=(pitcha{+PI/2})*180/pi;
    rollangle:=(rolla-PI/2)*180/pi;
    position.x:=px;
    position.y:=py;
    position.z:=pz;
    end;
  sc.x:=1;
  sc.y:=1;
  sc.z:=1;
  p.x:=0;
  p.y:=0;
  p.z:=0;
  rollang:=0;
  turnang:=0;
  pitchang:=0;

  oggetto:=TPolygon(Dcube.AddNewChild(TPolygon));
  {$I Settaproprieta.pas}
  with oggetto.nodes do
    begin
    Add;Last.x:=-L/2;Last.y:=W1/2;Last.Z:=-H1/2;
    Add;Last.x:=L/2;Last.y:=W2/2;Last.Z:=-H2/2;
    Add;Last.x:=L/2;Last.y:=-W2/2;Last.Z:=-H2/2;
    Add;Last.x:=-L/2;Last.y:=-W1/2;Last.Z:=-H1/2;
    end;
  oggetto:=TPolygon(Dcube.AddNewChild(TPolygon));
  {$I Settaproprieta.pas}
  with oggetto.nodes do
    begin
    Add;Last.x:=-L/2;Last.y:=W1/2;Last.Z:=H1/2;
    Add;Last.x:=L/2;Last.y:=W2/2;Last.Z:=H2/2;
    Add;Last.x:=L/2;Last.y:=-W2/2;Last.Z:=H2/2;
    Add;Last.x:=-L/2;Last.y:=-W1/2;Last.Z:=H1/2;
    end;
  oggetto:=TPolygon(Dcube.AddNewChild(TPolygon));
  {$I Settaproprieta.pas}
  with oggetto.nodes do
    begin
    Add;Last.x:=-L/2;Last.y:=W1/2;Last.Z:=-H1/2;
    Add;Last.x:=L/2;Last.y:=W2/2;Last.Z:=-H2/2;
    Add;Last.x:=L/2;Last.y:=W2/2;Last.Z:=H2/2;
    Add;Last.x:=-L/2;Last.y:=W1/2;Last.Z:=H1/2;
    end;
  oggetto:=TPolygon(Dcube.AddNewChild(TPolygon));
  {$I Settaproprieta.pas}
  with oggetto.nodes do
    begin
    Add;Last.x:=L/2;Last.y:=-W2/2;Last.Z:=-H2/2;
    Add;Last.x:=-L/2;Last.y:=-W1/2;Last.Z:=-H1/2;
    Add;Last.x:=-L/2;Last.y:=-W1/2;Last.Z:=H1/2;
    Add;Last.x:=L/2;Last.y:=-W2/2;Last.Z:=H2/2;
    end;

  //dcube.Position.X:=oggetto.Position.X;
  //dcube.Position.y:=oggetto.Position.y;
  //dcube.Position.z:=oggetto.Position.z;
  //dcube.ShowAxes:=true;
  oggetto.Position.y:=0;
  oggetto.Position.X:=0;
  oggetto.Position.z:=0;
  //dcube.RollAngle:=roll*180/pi;
  //dcube.turnAngle:=turn*180/pi;
  //dcube.pitchAngle:=pitch*180/pi;
  end;
end;

Procedure Parallelepi(Q,x1,y1,dir,lung,spes,alt:real;Colore:Tcolori3d);
Var dirz,spoX,SpoY:real;
begin
inc(NumEntita);
TestRange(x1,minX,MaxX);
TestRange(y1,minY,MaxY);
//TestRange(alt,minZ,MaxZ);
//TestRange(Q,minZ,MaxZ);
//TestRange(alt,minZ,MaxZ);
p.x:=(x1);
p.y:=(y1);
p.z:=Q;
Colorecor_3d:=colore;
sc.y:=spes;
sc.x:=lung;
sc.z:=alt;
rollang:=-dir;
Pitchang:=0;
Turnang:=0;
cubo;
end;

Procedure Paretesemp(Q,x1,y1,x2,y2,spes,alt:real;filo:char;codesp:string);
Var dir,dirz,spoX,SpoY:real;
begin
SpoY:=0;
case filo of
'C':spoX:=0;
'S':spoX:=spes/2;
'D':spoX:=-spes/2;
end;
inc(NumEntita);
TestRange(x1,minX,MaxX);
TestRange(y1,minY,MaxY);
TestRange(x2,minX,MaxX);
TestRange(y2,minY,MaxY);
TestRange(alt,minZ,MaxZ);
TestRange(0,minZ,MaxZ);
TestRange(alt,minZ,MaxZ);
calc_d(x1,y1,0,x2,y2,0,dir,dirz);
if spox<>0 then
modicord1(spox,spoy,0,0,dir,1);
p.x:=(x1+x2)/2+spox;
p.y:=(y1+y2)/2+spoy;
//p.z:=alt/2;
p.z:=Q;
sc.y:=spes;
sc.x:=sqrt(sqr(x2-x1)+sqr(y2-y1));
sc.z:=alt;
rollang:=-dir;
Pitchang:=0;
Turnang:=0;
cubo;
end;

Procedure Linea(x1,y1,z1,x2,y2,z2,spes:real;Color:Tcolori3d);
Var dir,dirz:real;
begin
inc(NumEntita);
TestRange(x1,minX,MaxX);
TestRange(y1,minY,MaxY);
TestRange(x2,minX,MaxX);
TestRange(y2,minY,MaxY);
TestRange(z1,minZ,MaxZ);
TestRange(z2,minZ,MaxZ);
p.x:=(x1+x2)/2;
p.y:=(y1+y2)/2;
p.z:=(z1+z2)/2;
sc.y:=spes;
sc.x:=sqrt(sqr(x2-x1)+sqr(y2-y1)+sqr(z2-z1));
sc.z:=spes;
calc_d(x1,y1,z1,x2,y2,z2,dir,dirz);
//if (z1<>0)or(z2<>0) then
rollang:=-dir;
Pitchang:=0;
//if dirz<>0 then
Turnang:=dirz;
colorecor_3d:=color;
cubo;
end;


Procedure disegnalimiti;
begin
linea(minx,miny,minz,maxx,miny,minz,0.1,Cblu);
linea(minx,miny,minz,minx,maxy,minz,0.1,Cblu);
linea(minx,miny,minz,minx,miny,maxz,0.1,Cblu);
linea(maxx,maxy,maxz,minx,maxy,maxz,0.1,Cblu);
linea(maxx,maxy,maxz,maxx,miny,maxz,0.1,Cblu);
linea(maxx,maxy,maxz,maxx,maxy,minz,0.1,Cblu);
end;

Procedure SettaIngr;
Var maxass:real;
    ingra:real;
begin
//disegnalimiti;
Form1.DCOggetti.position.Y:=-(Miny+Maxy)/2+(Form1.Trackbar4.position-250)/500*(Miny+Maxy);
Form1.DCOggetti.position.X:=-(Minx+Maxx)/2+(Form1.Trackbar2.position-50)/100*(Minx+Maxx);
Form1.DCOggetti.position.Z:=-(Minz+Maxz)/2+(Form1.Trackbar5.position-50)/100*(Minz+Maxz);

Form1.DCgenerale.ShowAxes:=(form1.cbassi.checked)and (Not (form1.CBdentro.Checked));
if form1.CBdentro.Checked then
  begin
  MaxAss:=5;
  end
else
  begin
  MaxAss:=(Maxx-Minx);
  if (Maxy-Miny)> MaxAss then MaxAss:=(Maxy-Miny);
  if (Maxz-Minz)*2> MaxAss then MaxAss:=(Maxz-Minz)*3;
  end;
ingrbase:=15/Maxass;

//Form1.DCGenerale.Scale.X:=ingrbase;
//Form1.DCGenerale.Scale.y:=ingrbase;
//Form1.DCGenerale.Scale.z:=ingrbase;
trackchange;
//ingra:=(form1.trackbar1.position)/100*2*ingrbase;
//Form1.DCGenerale.Scale.X:=ingra;
//Form1.DCGenerale.Scale.y:=ingra;
//Form1.DCGenerale.Scale.z:=ingra;

end;

Function IntComando(com:string):boolean;
begin
com:=upstring(com);
result:=(com='PARETE');
end;

Procedure ExecComando(com:string);
Var so:tglsceneobject;
begin
com:=upstring(com);
if com='PARETE' then
  begin
  {Parete;}
  exit;
  end;
end;

Procedure CarPunto(vetstr:string;var pnt:vettore);
Var i,iprec:integer;
begin
i:=0;
iprec:=1;
while (i<length(vetstr))and(vetstr[i]<>',') do inc(i);
pnt.x:=strtofloat(copy(vetstr,iprec,i-iprec));
inc(i);
iprec:=i;
while (i<length(vetstr))and(vetstr[i]<>',') do inc(i);
pnt.y:=strtofloat(copy(vetstr,iprec,i-iprec));
inc(i);
iprec:=i;
while (i<length(vetstr))and(vetstr[i]<>',') do inc(i);
pnt.z:=strtofloat(copy(vetstr,iprec,i-iprec+1));
end;

Procedure CambiaP2;
begin
end;

Procedure Parametri(par:string);
Var i:integer;
begin
if par='' then exit;
par:=upstring(Par);
i:=1;
while (i<length(par))and(par[i]<>'=') do inc(i);
if par[i]<>'=' then exit;
if copy(par,1,2)='P2' then
  begin
  CarPunto(copy(par,4,length(par)-4+1),P2);
  exit;
  end;
if copy(par,1,2)='P1' then
  begin
  exit;
  end;
end;



Procedure comando(riga:string);
Var POsind:integer;
    Identif:string;

procedure leggiidentif;
Var i:integer;
begin
i:=posind+1;

if i<length(riga) then
while (riga[i]<>':')and(i<length(riga)) do inc(i);

if i=posind+1 then
identif:=''
else
Identif:=copy(riga,posind+1,i-posind-1);
POsind:=i;
end;

Var NomeCom:string;

begin
posind:=0;
Leggiidentif;
Nomecom:=identif;
if IntComando(Nomecom)then
  begin
  ExecComando(Nomecom);
  end;
end;

Procedure AzzeraBuchi;
begin
Nbuchi:=0;
end;
Procedure addbuco(xc,yc,zc,lb,hb:real);
begin
inc(nbuchi);
with buchi[Nbuchi] do
  begin
  xxc:=xc;
  YYc:=Yc;
  zzc:=zc;
  LLb:=lb;
  HHb:=hb;
  end;
end;

procedure Leggidisegno_Piano_canali(percorso:string);
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
    z:real;
begin
z:=form1.test1.position/10;
if fileexists(Percorso+'disegnocanali.dsc') then
  begin
  assignfile(fdim,Percorso+'disegnocanali.dsc');
  reset(fdim);
    while not eof(Fdim)do
      begin
      read(fdim,bufdim);
      with bufdim do
      case upcase(entita[1]) of
      'L','F','*':begin
          linea(x1,y1,z,x2,y2,z,0.01,cLegno);
          end;
      (*
      'Q':Begin
          Testo(x1,y1,float_to_str(x2,2));
          end;
      'A':Arco(x1,y1,R,x2,y2);
      'C':Arco(x1,y1,R,0,2*pi);
      end;
      *)
      end;

  end;
  close(Fdim);
  end;
end;

 { TODO -oDiego -cNavigazione : Disegn 3d Canali }
Procedure DisegnaCanali(Nome:string;colore:Tcolori3d);
const maxpar=9;
type Int3d=record
            Entita:string[1];
            codp:string[10];
            Indp:integer;
            Par:array[1..maxpar]of real;
           end;
Var F3d:file of Int3d;
    buf3d:int3d;
    codpcor,nomefile:string;


Var xcor,ycor,zcor,xcora,ycora,zcora,acor,bcor,hcor,r1,r2,r3,r1a,r2a,r3a,rotz,xx1,yy1,xx2,yy2:real;
    tmp:real;
begin
//Leggidisegno_Piano_canali(extractfilepath(nome));
//exit;
Nogg:=0;
nomefile:=extractfilename(nome);
assignfile(f3d,Nome);//.3dm
reset(f3d);
colorecor_3d:=Colore;
rotz:=0;
r1:=0;
r2:=0;
r3:=0;
r1a:=0;
r2a:=0;
r3a:=0;
xcor:=0;
ycor:=0;
zcor:=0;
codpcor:='';
while not eof(f3d) do
begin
read(f3d,buf3d);
with buf3d do
   //if (form1.SBPezzo.Value=0)or(form1.SBPezzo.Value=indp) then
   begin
   //if form1.SBPezzo.Value<>0  then form1.LPezzo.Caption:=codp
   //else form1.LPezzo.Caption:='';
  //if buf3d.codp='310R' then
  //if (form1.EPezzo.Text='')or(buf3d.Indp=strtoint(form1.EPezzo.Text)) then
  case Entita[1] of
  'D':begin
      r1a:=0;
      r2a:=0;
      r3a:=0;
      xcora:=0;
      ycora:=0;
      zcora:=0;
      NuovoDcBlocco(par[1],par[2],par[3],par[4],par[5],par[6],Nomefile,indp);
      end;
   //'I':InserDcBlocco(par[1],par[2],par[3],form1.Test1.position/100*2*pi,par[5],par[6]);
 'I':InserDcBlocco(par[1],par[2],par[3],par[4],par[5],par[6]);

  'L':begin
      xcora:=par[1];
      ycora:=par[2];
      zcora:=par[3];
      end;
  'U':begin
      r1a:=Par[2];
      r2a:=Par[3];
      r3a:=Par[4];
      end;

  'P':Cubob(Par[1],par[2],par[3],Xcora,Ycora,zcora,r1a,r2a,r3a);
  'C':Cilindro(Par[1],par[3],Xcora,Ycora,zcora,r1a,r2a,r3a);
  {
  riduz(T1,w1,H1,T2,w2,h2,L,Dw,Dh,roll,turn,pitch:real);
  Par[1]:=t1;
  par[2]:=t2;
  Par[3]:=a_r1/conf^.altnum*40;
  Par[4]:=alt1/conf^.altnum*40;
  Par[5]:=a_r2/conf^.altnum*40;
  Par[6]:=alt2/conf^.altnum*40;
  Par[7]:=eccx/conf^.altnum*40;
  Par[8]:=eccy/conf^.altnum*40;
  Par[9]:=lung/conf^.altnum*40;
  }
  'F':riduz(Par[1],Par[3],Par[4],Par[2],Par[5],Par[6],Par[9],Par[7],Par[8],Xcora,Ycora,zcora,r1a,r2a,r3a);

  'B':begin
      xx1:=-par[3]/2;
      YY1:=0;
      tmp:=r3a;//*form1.test1.position/100;
      modicord1(xx1,yy1,XCOR,YCOR,R3+tmp+pi/2,1);
      xx2:=par[3]/2;
      YY2:=0;
      modicord1(xx2,yy2,XCOR,YCOR,R3+tmp+pi/2,1);
      //Paretesemp(Q,x1,y1,x2,y2,spes,alt:real;filo:char;codesp:string);
      //if codp='3736R' then
      PareteSemp(0,xx1,yy1,xx2,yy2,Par[1],par[2],'C','');
      end;

  'T':begin
      xcor:=xcor+par[1];
      ycor:=ycor+par[2];
      zcor:=zcor+par[3];
      p.x:=xcor;
      p.y:=ycor;
      p.z:=zcor;
      end;

  'A':begin
      xcor:=xcor-par[1];
      ycor:=ycor-par[2];
      zcor:=zcor-par[3];
      p.x:=xcor;
      p.y:=ycor;
      p.z:=zcor;
      end;

  'R':begin
      r1:=r1+par[1]*Par[2];
      r2:=r2+par[1]*Par[3];
      r3:=r3+par[1]*Par[4];
      end;


   'Z':rotz:=Par[1];
   'V':curvaret(par[1],par[2],par[3],par[4],par[5],r1a,r2a,r3a);
   //curvaret(par[1],par[2],par[3],par[4],par[5],0,Pi/2,3/2*pi);
   //(form1.test.position*2*pi/10)
  //else PareteSemp(-10,1,-9,1,0.1,5);
  end;
  end;
end;
closefile(f3d);
end;

end.

