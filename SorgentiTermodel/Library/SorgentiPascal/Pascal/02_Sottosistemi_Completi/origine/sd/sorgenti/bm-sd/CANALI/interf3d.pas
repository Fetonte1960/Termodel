unit Interf3D;
interface
uses definiz,definizcan,angoli,funzdim,U_varpezzi,wintypes,winprocs,U_funz,
     sysutils,ugestpezzi
     {$ifdef delphi},messages{$endif};



Var F3d:file of Int3d;
    F3dTxt:text;
Procedure Init3d;
Procedure cLOSE3d;
Procedure DisegnaCan(x1,y1,x2,y2,x3,y3,x4,y4,Z1,z2:real;tr,pz:integer;Ultd:real);

//Procedure DisegnaCan1(tr,pz:integer;Xp1,Yp1,Zp1,Xp2,Yp2,Zp2,ultang:real);

Procedure CopiaPezzo3d;
Procedure Inser3d(DX,DY,DZ,Rot,rotz:real;Orient:integer);
Procedure Scrivi3d;
Procedure Stampa_unif_3d;
procedure  InitTab3d;
//Procedure Trasla(x,y,z:real);
//Procedure Trasla1(x,y,z:real);
//Procedure Ruota(ang,x,y,z:real);
//Procedure Ruota1(ang,x,y,z:real);
//Procedure RuotaZ(ang,x,y,z:real);
{Procedure Box(orie,larg,alt,Lung,dx,dy,dz,ang:real);}
//Procedure Annulla(x,y,z:real);
//Procedure Annulla1(x,y,z:real);
{Procedure Curva3d(ang,orie,R,A1,A2,B,Dx,Dy,Dz:real);}

// funzioni esterne dummy
Procedure Curva3d1(ang,orie,verso,R,A1,A2,B,Dx,Dy,Dz:real);
Procedure Cilindro1(orie,Diam,Lung,dx,dy,dz,ang:real);
Procedure Trasforma1(orie,T1,a_r1,alt1,T2,a_r2,alt2,eccx,eccy,Lung,dx,dy,dz,ang:real);
Procedure Box1(orie,larg,alt,Lung,dx,dy,dz,ang:real);


Procedure Componi3d(orie:integer;pu1_0,Pu1_1:real);
Procedure IniziaPezzo3d(orie:integer);
Procedure FinePezzo3d(orie:integer);
procedure disegnapezzoJolly(Xcodpezzo:string;Indprog:integer;XB1,XH1,XB2,XH2,XB3,XH3,XB4,XH4,XD1,XD2,XD3,XD4:real;
                   XOrient:integer;XAng,XCurv,XLung,XRap,XRap1,XVarie:real;ColLinea:integer;XX1A,XY1A,XX2A,XY2A,
                   XX3A,XY3A,XX4A,XY4A,XX5A,XY5A,XX6A,XY6A,XX7A,XY7A,XX8A,XY8A:real;Var XZ1,XZ2,XZ3,XZ4:real);

{
Procedure Jolly(orie:integer;Cod:string;Ang,Curv,Lung,Rap,Rap1,B1,H1,B2,H2,B3,H3,B4,H4,D1,D2,D3,D4,
                XX1A,XY1A,XX2A,XY2A,
                XX3A,XY3A,XX4A,XY4A,
                XX5A,XY5A,XX6A,XY6A,
                XX7A,XY7A,XX8A,XY8A,
                XZ1,XZ2,XZ3,XZ4:real);
}
Procedure ScriviCommento3d(commento:string);
Procedure Write_f3d(buf3d:int3d);
//Procedure Ruota2(roll,turn,pitch:real);

Var Disegnato3d:boolean;
    Indpezzo3d,countpezzo3d:integer;
implementation
uses pezzi;
Var  buf:int3d;

{---------------------------------------------------------------------------}
Procedure Ruota1(ang,x,y,z:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='U';
  Par[1]:=ang;
  Par[2]:=x;
  Par[3]:=y;
  Par[4]:=z;
  end;
end;
{---------------------------------------------------------------------------}
Procedure Trasla1(x,y,z:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='L';
  Par[1]:=x/1000;
  Par[2]:=y/1000;
  Par[3]:=z/1000;
  end;
end;
{---------------------------------------------------------------------------}
Procedure Trasla(x,y,z:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='T';
  Par[1]:=x/conf^.altnum*40;
  Par[2]:=y/conf^.altnum*40;
  Par[3]:=z/conf^.altnum*40;
  end;
end;
{---------------------------------------------------------------------------}
Procedure Annulla1(x,y,z:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='N';
  Par[1]:=x;
  Par[2]:=y;
  Par[3]:=z;
  end;
end;

{---------------------------------------------------------------------------}
Procedure Annulla(x,y,z:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='A';
  Par[1]:=x/conf^.altnum*40;
  Par[2]:=y/conf^.altnum*40;
  Par[3]:=z/conf^.altnum*40;
  end;
end;
{---------------------------------------------------------------------------}
Procedure RuotaZ(ang,x,y,z:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='Z';
  Par[1]:=ang;
  Par[2]:=x;
  Par[3]:=y;
  Par[4]:=z;
  end;
end;

{---------------------------------------------------------------------------}
Procedure Ruota2(roll,turn,pitch:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='U';
  Par[1]:=roll;
  Par[2]:=turn;
  Par[3]:=pitch;
  Par[4]:=0;
  end;
end;

{---------------------------------------------------------------------------}
Procedure Ruota(ang,x,y,z:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='R';
  Par[1]:=ang;
  Par[2]:=x;
  Par[3]:=y;
  Par[4]:=z;
  end;
end;

{---------------------------------------------------------------------------}
Procedure Box1(orie,larg,alt,Lung,dx,dy,dz,ang:real);
begin
exit;
end;
{---------------------------------------------------------------------------}
Procedure Box2(orie,larg,alt,Lung,dx,dy,dz,ang:real);
begin
//if indpezzo3d=30 then exit;
Ruota1(ang,0,0,-1);
trasla(dx,dy,dz);

indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='B';
  Par[1]:=larg/conf^.altnum*40;
  Par[2]:=alt/conf^.altnum*40;
  Par[3]:=lung/conf^.altnum*40;
  end;

Annulla(dx,dy,dz);
Ruota1(ang,0,0,1);
end;
{---------------------------------------------------------------------------}
{ TODO -oDiego -cNavigazione : Box,cilindro (inserimento) }
Procedure Cilindro3(orie,Diam,Lung,dx,dy,dz,ang:real);
begin

with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='C';
  Par[1]:=Diam/1000;
  Par[3]:=lung/1000;
  end;
end;
Procedure Box3(orie,larg,alt,Diam,Lung,dx,dy,dz,ang:real);
begin
Ruota2(0,ang,0);
trasla1(dx,dy,dz);
indpezzo3d:=indpezzo3d+1;

if (larg=0)or(alt=0) then
Cilindro3(orie,Diam,Lung,dx,dy,dz,ang)
else
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='P';
  Par[1]:=larg/1000;
  Par[2]:=alt/1000;
  Par[3]:=lung/1000;
  end;
end;

{---------------------------------------------------------------------------}
Procedure Box(orie,larg,alt,Lung,dx,dy,dz,ang:real);
begin
exit;
trasla1(0,0,0);
Ruota(Pi/2,0,0,-1);

case round(orie) of
3:Ruota(-pi,0,1,0);
end;
Ruota1(ang,0,0,-1);
trasla(dx,dy,dz);

indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='B';
  Par[1]:=larg/conf^.altnum*40;
  Par[2]:=alt/conf^.altnum*40;
  Par[3]:=lung/conf^.altnum*40;
  end;

Annulla(dx,dy,dz);
Ruota1(ang,0,0,1);
case round(orie) of
3:Ruota(-pi,0,-1,0);
end;
Ruota(Pi/2,0,0,1);
Annulla1(0,0,0);
end;

{---------------------------------------------------------------------------}
Procedure Trasforma1(orie,T1,a_r1,alt1,T2,a_r2,alt2,eccx,eccy,Lung,dx,dy,dz,ang:real);
begin
exit;
Ruota1(ang,0,0,-1);


case round(orie) of
3:Ruota(-pi,0,1,0);
2:Ruota(-pi/2,0,1,0);
end;


trasla(dx,dy-lung,dz);


Ruota1(-pi/2,1,0,0);


indpezzo3d:=indpezzo3d+1;

{Trasform(t1,t2:char;a_r1,H1,ecc1X,ecc1Y,a_r2,H2,ecc2X,ecc2Y,H:real);
 Trasform(S_in,S_out,Par[3],Par[4],0,0,Par[5],Par[6],Par[7],Par[8],Par[9]);}
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='F';
  Par[1]:=t1;
  par[2]:=t2;
  Par[3]:=a_r1/conf^.altnum*40;
  Par[4]:=alt1/conf^.altnum*40;
  Par[5]:=a_r2/conf^.altnum*40;
  Par[6]:=alt2/conf^.altnum*40;
  Par[7]:=eccx/conf^.altnum*40;
  Par[8]:=eccy/conf^.altnum*40;
  Par[9]:=lung/conf^.altnum*40;
  end;


Ruota1(-pi/2,-1,0,0);

Annulla(dx,dy-lung,dz);

case round(orie) of
3:Ruota(-pi,0,-1,0);
2:Ruota(-pi/2,0,-1,0);
end;


Ruota1(ang,0,0,1);

end;
{---------------------------------------------------------------------------}
Procedure Trasforma(orie,T1,a_r1,alt1,T2,a_r2,alt2,eccx,eccy,Lung,dx,dy,dz,ang:real);
begin
exit;
trasla1(0,0,0);
Ruota(Pi/2,0,0,-1);

RuotaZ(-Pi/2,1,0,0);  {Rot verticale}


case round(orie) of
3:Ruota(-pi,0,1,0);
end;
Ruota1(ang,0,0,-1);
trasla(dx,dy,dz-lung);

indpezzo3d:=indpezzo3d+1;

{Trasform(t1,t2:char;a_r1,H1,ecc1X,ecc1Y,a_r2,H2,ecc2X,ecc2Y,H:real);
 Trasform(S_in,S_out,Par[3],Par[4],0,0,Par[5],Par[6],Par[7],Par[8],Par[9]);}
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='F';
  Par[1]:=t1;
  par[2]:=t2;
  Par[3]:=a_r1/conf^.altnum*40;
  Par[4]:=alt1/conf^.altnum*40;
  Par[5]:=a_r2/conf^.altnum*40;
  Par[6]:=alt2/conf^.altnum*40;
  Par[7]:=eccx/conf^.altnum*40;
  Par[8]:=eccy/conf^.altnum*40;
  Par[9]:=lung/conf^.altnum*40;
  end;

Annulla(dx,dy,dz-lung);
Ruota1(ang,0,0,1);
case round(orie) of
3:Ruota(-pi,0,-1,0);
end;

RuotaZ(-Pi/2,-1,0,0);  {Rot verticale}


Ruota(Pi/2,0,0,1);
Annulla1(0,0,0);
end;
{ TODO -oDiego -cNavigazione : Trasormazione (inserimento) }
Procedure Trasforma3(orie,T1,a_r1,alt1,T2,a_r2,alt2,eccx,eccy,Lung,dx,dy,dz,ang:real);
begin
Ruota2(0,ang,0);
trasla1(dx,dy,dz);
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='F';
  Par[1]:=t1;
  par[2]:=t2;
  Par[3]:=a_r1/1000;
  Par[4]:=alt1/1000;
  Par[5]:=a_r2/1000;
  Par[6]:=alt2/1000;
  Par[7]:=eccx/1000;
  Par[8]:=eccy/1000;
  Par[9]:=lung/1000;
  end;
end;
{---------------------------------------------------------------------------}
Procedure Cilindro1(orie,Diam,Lung,dx,dy,dz,ang:real);
begin
exit;
trasla(dx,dy,dz);
Ruota1(ang{+Pi/2},0,0,-1);

indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='C';
  Par[1]:=Diam/conf^.altnum*40;
  Par[3]:=lung/conf^.altnum*40;
  end;


Ruota1(ang{+PI/2},0,0,1);
Annulla(dx,dy,dz);

end;


{---------------------------------------------------------------------------}
Procedure Cilindro(orie,Diam,Lung,dx,dy,dz,ang:real);
begin
exit;
case round(orie) of
3:Ruota(pi,0,1,0);
end;
trasla(dx,dy,dz);
Ruota(ang+Pi/2,0,0,-1);

indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='C';
  Par[1]:=Diam/conf^.altnum*40;
  Par[3]:=lung/conf^.altnum*40;
  end;


Ruota(ang+PI/2,0,0,1);
Annulla(dx,dy,dz);

case round(orie) of
3:Ruota(pi,0,-1,0);
end;
end;


{---------------------------------------------------------------------------}
{ TODO -oDiego -cNavigazione : Curva (Inserimento) }
Procedure Curva(ang,R,A1,A2,B:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='V';
  Par[1]:=ang;
  (*
  Par[2]:=R/conf^.altnum*40;
  Par[3]:=A1/conf^.altnum*40;
  Par[4]:=A2/conf^.altnum*40;
  Par[5]:=b/conf^.altnum*40;
  *)
  Par[2]:=R/1000;
  Par[3]:=A1/1000;
  Par[4]:=A2/1000;
  Par[5]:=b/1000;
  end;
end;

{*** -----------------------------------------------------------------------}
Procedure Nuovoblocco;
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='D';
  Par[1]:=0;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=0;
  Par[5]:=0;
  Par[6]:=0;
  end;
end;
{---------------------------------------------------------------------------}
Procedure IniziaPezzo3d(orie:integer);
begin
Nuovoblocco;
disegnato3d:=false;
//*trasla1(0,0,0);

//*Ruota(Pi/2,0,0,-1);

//*RuotaZ(0,1,0,0);  {Rot verticale}

{Ruota(0,0,0,-1);}
 (*-+
case round(orie) of
1:Ruota(pi,0,1,0);
4:Ruota(pi/2,0,1,0);
2:Ruota(3/2*pi,0,1,0);
5:Ruota(pi/2,0,1,0);
6:Ruota(3*pi/2,0,1,0);
end;
 *)
{trasla(Dx,Dy,Dz);}

end;
{---------------------------------------------------------------------------}
Procedure FinePezzo3d(orie:integer);
begin

{annulla(Dx,Dy,Dz);}
 (*-*
case round(orie) of
1:Ruota(pi,0,-1,0);
4:Ruota(pi/2,0,-1,0);
2:Ruota(3/2*pi,0,-1,0);
5:Ruota(pi/2,0,-1,0);
6:Ruota(3*pi/2,0,-1,0);

end;

RuotaZ(0,-1,0,0);  {Rot verticale}

Ruota(PI/2,0,0,1);

{Ruota(0,0,0,1);}
annulla1(0,0,0);
*)
end;

{---------------------------------------------------------------------------}
Procedure Curva3d1(ang,orie,verso,R,A1,A2,B,Dx,Dy,Dz:real);
begin
end;
Procedure Curva3d3(ang,orie,verso,R,A1,A2,B,Dx,Dy,Dz:real);
Var temp:real;
begin
disegnato3d:=true;
case round(orie) of
2,4,5,6:
if b>0 then
  begin
  temp:=a1;
  a1:=b;
  b:=temp;
  a2:=a1;
  end;
end;

Dy:=dy-(R+A2/2)*tan(Ang/2);

//if verso<>1 then
//Ruota1(pi,0,1,0);

trasla1(Dx,Dy,Dz);

Curva(ang*180/pi,R,A1,A2,B);


end;
{---------------------------------------------------------------------------}

Procedure Curva3d2(ang,orie,verso,R,A1,A2,B,Dx,Dy,Dz:real);
Var temp:real;
begin
disegnato3d:=true;
case round(orie) of
2,4,5,6:
if b>0 then
  begin
  temp:=a1;
  a1:=b;
  b:=temp;
  a2:=a1;
  end;
end;

Dy:=dy-(R+A2/2)*tan(Ang/2);

if verso<>1 then
Ruota1(pi,0,1,0);

trasla(Dx,Dy,Dz);

Curva(ang*180/pi,R,A1,A2,B);

annulla(Dx,Dy,Dz);

if verso<>1 then
Ruota1(pi,0,-1,0);

end;
{---------------------------------------------------------------------------}

Procedure Curva3d(ang,orie,R,A1,A2,B,Dx,Dy,Dz:real);
Var temp:real;
begin
exit;
trasla1(0,0,0);

Ruota(Pi/2,0,0,-1);

RuotaZ(0,1,0,0);  {Rot verticale}


{Ruota(0,0,0,-1);}


case round(orie) of
2,4,5,6:
if b>0 then
  begin
  temp:=a1;
  a1:=b;
  b:=temp;
  a2:=a1;
  end;
end;


case round(orie) of
1:Ruota(pi,0,1,0);
4:Ruota(pi/2,0,1,0);
2:Ruota(3/2*pi,0,1,0);
5:Ruota(pi/2,0,1,0);
6:Ruota(3*pi/2,0,1,0);
end;

Dy:=dy-(R+A1/2)*tan(Ang/2);



trasla(Dx,Dy,Dz);



Curva(ang*180/pi,R,A1,A2,B);



annulla(Dx,Dy,Dz);


case round(orie) of
1:Ruota(pi,0,-1,0);
4:Ruota(pi/2,0,-1,0);
2:Ruota(3/2*pi,0,-1,0);
5:Ruota(pi/2,0,-1,0);
6:Ruota(3*pi/2,0,-1,0);
end;




RuotaZ(0,-1,0,0);  {Rot verticale}

Ruota(PI/2,0,0,1);

{Ruota(0,0,0,1);}
annulla1(0,0,0);
end;


{---------------------------------------------------------------------------}
{ TODO -oDiego -cNavigazione : Disegno pezzo jolly }

Procedure Jolly(orie:integer;Cod:string;Ang,Curv,Lung,Rap,Rap1,B1,H1,B2,H2,B3,H3,B4,H4,D1,D2,D3,D4,
                XX1A,XY1A,XX2A,XY2A,
                XX3A,XY3A,XX4A,XY4A,
                XX5A,XY5A,XX6A,XY6A,
                XX7A,XY7A,XX8A,XY8A,
                XZ1,XZ2,XZ3,XZ4:real);
Var tipoUscite:array[0..4] of char;
    Nuscite,indpezzo,i:integer;
    risp,maxder:real;
    const cRisp=50;
    righediff=1;
var  b2a,b3a,b4a,tt:real;
Var  Tipo,codN:string;
begin
If (orie=5)or(orie=6) then
  begin
  tt:=b1;
  b1:=h1;
  h1:=tt;
  end;
if (copy(cod,1,2)='07') then  //curve
  begin
  if Curv=0 then Curv:=1;
  Ang:=Ang/180*pi;
  curva3d3(ang,orient,1,(curv*b1-b1/2),b1,b1,h1,0,0,0);
  exit;
  end;
indpezzo:=Cerca_ARCHIVIOVecchio(cod);
if indpezzo=0 then exit;
codn:=archpezzi[indpezzo].codice;
NUscite:=strtoint(codn[2]);
Tipo:='';
if length(codn)>=Nuscite+6 then tipo:=copy( codn,Nuscite+4,3);
orie:=1;
if b2=0 then b2a:=d2 else b2a:=b2;
if b3=0 then b3a:=d3 else b3a:=b3;
if b4=0 then b4a:=d4 else b4a:=b4;
if b4a>b3a then
risp:=Crisp+(Xx7A+Xx8A)/2+b4a
else
risp:=Crisp+(Xx5A+Xx6A)/2+b3a;

if Nuscite =0 then
  begin
  for i:=1 to righediff do
  Box3(orie,B1*i/righediff,H1*i/righediff,D1*i/righediff,10,XX1A/2+righediff*10/(i),(XY1A+XY2A)/2,0,0);
  exit;
  end;
if Nuscite > 2 then risp:=0;

//Box1(orie,larg,alt,Lung,dx,dy,dz,ang:real);
if tipo='ULT' then
  begin
  risp:=Crisp+(Xx3A+Xx4A)/2+b2a;
  Box3(orie,B2,H2,D2,abs(XY3A),(Xx3A+Xx4A)/2,-abs(XY3A/2),0,Pi/2);
  end;

if tipo='RID' then
  begin
  Trasforma3(orie,1,B1,H1,1,B2,H2,0,0,Lung,(XX1A+XX3A)/2,0,0,0);
  end
else Box3(orie,B1,H1,D1,abs(XX1A)+risp,XX1A/2,(XY1A+XY2A)/2,0,0);

if Nuscite > 1 then
  begin
  if tipo='TEE' then
    begin
    Box3(orie,B2,H2,D2,abs(XY3A),(XX3A+xx4a)/2,abs(XY3A/2),0,pi/2);
    Box3(orie,B3,H3,D3,abs(XY5A),(Xx5A+Xx6A)/2,-abs(XY5A/2),0,Pi/2);
    //Box3(orie,B4,H1,abs(XY7A),(Xx7A+Xx8A)/2,abs(XY7A/2),0,Pi/2);
    end
  else
    begin
    Box3(orie,B2,H2,D2,abs(XX3A),XX3A/2,(XY3A+XY4A)/2,0,0);
    Box3(orie,B3,H3,D3,abs(XY5A),(Xx5A+Xx6A)/2,-abs(XY5A/2),0,Pi/2);
    Box3(orie,B4,H1,D4,abs(XY7A),(Xx7A+Xx8A)/2,abs(XY7A/2),0,Pi/2);
    end;
  end;

end;
{ Pezzo con orientamento 1 -----------------}
procedure disegnapezzoJolly(Xcodpezzo:string;Indprog:integer;XB1,XH1,XB2,XH2,XB3,XH3,XB4,XH4,XD1,XD2,XD3,XD4:real;
                   XOrient:integer;XAng,XCurv,XLung,XRap,XRap1,XVarie:real;ColLinea:integer;XX1A,XY1A,XX2A,XY2A,
                   XX3A,XY3A,XX4A,XY4A,XX5A,XY5A,XX6A,XY6A,XX7A,XY7A,XX8A,XY8A:real;Var XZ1,XZ2,XZ3,XZ4:real);
Var ttt:real;
begin

 if (Xorient=2)or(Xorient=4) then
   begin
   ttt:=xb1;
   xb1:=xh1;
   xh1:=ttt;
   end;

disegnapezzo1(false,Xcodpezzo,Indprog,XB1,XH1,XB2,XH2,XB3,XH3,XB4,XH4,XD1,XD2,XD3,XD4,
                   1,XAng,XCurv,XLung,XRap,XRap1,XVarie,ColLinea,XX1A,XY1A,XX2A,XY2A,
                   XX3A,XY3A,XX4A,XY4A,XX5A,XY5A,XX6A,XY6A,XX7A,XY7A,XX8A,XY8A,XZ1,XZ2,XZ3,XZ4);

jolly(Xorient,XCodpezzo,XAng,XCurv,XLung,XRap,XRap1,XB1,XH1,XB2,XH2,XB3,XH3,XB4,XH4,XD1,XD2,XD3,XD4,
          XX1A,XY1A,XX2A,XY2A,
          XX3A,XY3A,XX4A,XY4A,
          XX5A,XY5A,XX6A,XY6A,
          XX7A,XY7A,XX8A,XY8A,
          XZ1,XZ2,XZ3,XZ4);
if Xorient=4 then
Xz2:=(Xy3A+Xy4A)/2;

end;
{---------------------------------------------------------------------------}

Procedure Scrivi3d;
Var i:Integer;
begin
i:=1;
repeat
if DisPezzo13d^[i].entita<>' ' then
  begin
  DisPezzo13d^[i].codp:=codpcor;
  DisPezzo13d^[i].Indp:=Indpcor;
  write(f3d,DisPezzo13d^[i]);
  with DisPezzo13d^[i] do
  writeLn(f3dtxt,inttostr(Indpcor)+' '+codpcor+' '+entita,' P1:',Par[1]:5:1,' P2:',Par[2]:5:1,' P3:',
           Par[3]:5:1,' P4:',Par[4]:5:1,' P5:',Par[5]:5:1);
  end;
i:=i+1;
until DisPezzo13d^[i].entita=' ';
inc(countpezzo3d);
writeLn(f3dtxt,'-----------------  fine gruppo '+inttostr(countpezzo3d)+' -----------------');
end;

{---------------------------------------------------------------------------}
Procedure ScriviCommento3d(commento:string);
begin
writeLn(f3dtxt,'-----------------  '+commento+' -----------------');
end;
{---------------------------------------------------------------------------}

procedure  InitTab3d;
 var i:integer;
begin
indpezzo3d:=0;
   for i:=1 to Maxp3d do
    begin
    FillChar(DisPezzo3d^[i],sizeof(DisPezzo3d^[i]),' ');
    disPezzo3d^[i].entita[1]:=' ';
    end;
end;

{---------------------------------------------------------------------------}
Procedure Componi3d(orie:integer;pu1_0,Pu1_1:real);
Var i,j:Integer;
begin
i:=1;
while DisPezzo13d^[i].Entita[1]<>' ' do I:=i+1;

j:=1;
while DisPezzo3d^[j].Entita[1]<>' ' do
  begin
  DisPezzo13d^[i+j-1]:=DisPezzo3d^[j];
  with DisPezzo13d^[i+j-1] do
  if entita[1] IN ['T','A'] THEN
  Par[1]:=Par[1]+(PU1_0-PU1_1)/conf^.altnum*40;
  {X2:=X2+PU1[0].Xa-PU[1].Xa;}
  j:=j+1;
  end;
end;
{---------------------------------------------------------------------------}


Procedure CopiaPezzo3d;

var i:integer;

begin

for i:=1 to Maxp3d do
  begin
  DisPezzo13d^[i]:=DisPezzo3d^[i];
  if DisPezzo3d^[i].Entita[1]=' ' then DisPezzo13d^[i].Entita:=' ';
  end;

for i:=Maxp3d+1 to Maxp3d1 do
begin
FillChar(DisPezzo13d^[i],sizeof(DisPezzo13d^[i]),' ');
DisPezzo13d^[i].entita:=' ';
end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Inser           *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Inser3d1(DX,DY,DZ,Rot,rotz:real);


var i:integer;

begin
for i:=1 to Maxp3d do
with DisPezzo13d^[i] do
if entita[1]<>' ' then
  begin
  {ModiCord(X1,Y1,Dx,Dy,Rot,true);}
  case entita[1] of
  'T','A':
      begin
      {ModiCord(Par[1],Par[2],0,0,Rot,true);}
      Par[1]:=Par[1]+DX;
      Par[2]:=Par[2]+DY;
      {Par[3]:=0;}
      end;
  (*'L','N':  Modif 2005
      begin
      Par[1]:=Par[1]+DX;
      Par[2]:=Par[2]+DY;
      Par[3]:=Par[3]+DZ;
      end;
   *)
  'R':begin
      if par[4]<>0 then Par[1]:=par[1]+rot;
      end;

   'Z':Par[1]:=par[1]+rotz;

   { 'L'    :ModiCord(X2,Y2,Dx,Dy,Rot,true);
    'A','C','P':Begin
                R:=R/(Conf^.Altnum/40);
                R1:=R1/(Conf^.Altnum/40);
                X2:=x2-rot;
                Y2:=y2-rot;
                end;}
    end;
  end;


end;
 { TODO -oDiego -cNavigazione : Inser 3d }
Procedure Inser3d(DX,DY,DZ,Rot,rotz:real;Orient:integer);
Var roll:real;
begin
indpezzo3d:=indpezzo3d+1;
roll:=0;
  Case orient of
  1:roll:=PI;
  4:roll:=Pi*3/2;
  3:roll:=0;
  2:roll:=Pi/2;
  5:begin
    rotz:=PI/2;
    rot:=rot+pi/2;
    end;
  6:begin
    rotz:=-PI/2;
    rot:=rot+pi/2;
    end;
  end;
ROLL:=ROLL+pi;
with DisPezzo13d^[indpezzo3d] do
  begin
  entita:='I';
  (*
  Par[1]:=dx/conf^.altnum*40;
  Par[2]:=dy/conf^.altnum*40;
  Par[3]:=dz/conf^.altnum*40;
  *)
  Par[1]:=dx;
  Par[2]:=dy;
  Par[3]:=dz;
  Par[4]:=roll;
  Par[5]:=-rot;
  Par[6]:=rotz;
  end;
end;
{---------------------------------------------------------------------------}


Procedure Init3d;
begin
new(DisPezzo3d);
new(DisPezzo13d);
Assign(F3d,Driveprog+NomeProg+'.3dM');
Rewrite(F3d);
Assign(F3dtxt,Driveprog+NomeProg+'.3dT');
Rewrite(F3dtxt);

end;

{---------------------------------------------------------------------------}
Procedure Put_punto(x,y,z:real);
begin
with buf do
  begin
  entita:='T';
  par[1]:=x;
  par[2]:=Y;
  par[3]:=Z;
  write(f3d,buf);
  entita:='S';
  par[1]:=300;
  par[2]:=300;
  par[3]:=300;
  write(f3d,buf);
  entita:='T';
  par[1]:=-x;
  par[2]:=-Y;
  par[3]:=-Z;
  write(f3d,buf);
  end;
end;

{---------------------------------------------------------------------------}
Procedure Stampa_unif_3d;
Var i:Integer;
begin
for i:=1 to UltRiga do
If dis^[i]^.Entita<>'' then
If dis^[i]^.Entita='L' then
with dis^[i]^ do
  begin
  Put_punto(x1,y1,z1);
  Put_punto(x2,y2,z2);
  end;
end;
{---------------------------------------------------------------------------}

Procedure cLOSE3d;
var hd:thandle;
begin
close(F3dtxt);
Close(F3d);
Dispose(DisPezzo3d);
Dispose(DisPezzo13d);
hd:=findwindow('Tform1','Form1');
if hd<>0 then
begin
//  sendmessage(hd,wm_user+101,0,0);
end;
end;

{---------------------------------------------------------------------------}

Procedure DisegnaCan1a(tr,pz:integer;Xp1,Yp1,Zp1,Xp2,Yp2,Zp2,ultang:real);

Var dir,dirz,lung,larg,alt,Cx,Cy,CZ:real;

begin
codpcor:='310R';
indpcor:=Dati^[tr]^.Pezzi[Pz];
with buf do
  begin
  Larg:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.A/conf^.altnum*40;
  Alt:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.B/conf^.altnum*40;

  Cx:=(xp1+xp2)/2;
  Cy:=(yp1+yp2)/2;
  Cz:=(zp1+zp2)/2;

  Lung:=sqrt(sqr(xp2-xp1)+sqr(yp2-yp1)+sqr(zp2-zp1));

  entita:='T';
  Par[1]:=CX;
  Par[2]:=Cy;
  Par[3]:=Cz;
  write_f3d(buf);

  Calc_d(xp1,yp1,Zp1,xp2,yp2,Zp2,dir,dirz);
  if ug(abs(dirz),Pi/2,1) then dir:=ultang;

  entita:='R';
  Par[1]:=dir;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=-1;
  write_f3d(buf);

    entita:='R';
  Par[1]:=dirz;
  Par[2]:=1;
  Par[3]:=0;
  Par[4]:=0;
  write_f3d(buf);



  if Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.B =0 then
  begin
  Larg:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.R/conf^.altnum*40;
  entita:='C';
  end
  else
  entita:='B';


  Par[1]:=larg;
  Par[2]:=Alt;
  Par[3]:=Lung;
  write_f3d(buf);




  entita:='R';
  Par[1]:=Dirz;
  Par[2]:=-1;
  Par[3]:=0;
  Par[4]:=0;
  write_f3d(buf);

   entita:='R';
  Par[1]:=dir;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=1;
  write_f3d(buf);

  entita:='A';
  Par[1]:=CX;
  Par[2]:=Cy;
  Par[3]:=CZ;
  write_f3d(buf);
  end;

end;


{---------------------------------------------------------------------------}
Procedure Write_f3d(buf3d:int3d);
begin
buf3d.codp:=codpcor;
buf3d.indp:=Indpcor;
write(f3d,buf3d);
with buf3d do
  writeLn(f3dtxt,codpcor+' '+entita,' P1:',Par[1]:5:1,' P2:',Par[2]:5:1,' P3:',
           Par[3]:5:1,' P4:',Par[4]:5:1,' P5:',Par[5]:5:1);
end;
{---------------------------------------------------------------------------}
{ TODO -oDiego -cNavigazione : Canale diritto (Inserimento) }
Procedure DisegnaCan(x1,y1,x2,y2,x3,y3,x4,y4,Z1,z2:real;tr,pz:integer;Ultd:real);
Var Xp1,Yp1,Xp2,Yp2,dir,dirz,lung,larg,alt,Cx,Cy:real;

begin
inc(countpezzo3d);
writeLn(f3dtxt,'-------------- Canale diritto '+inttostr(countpezzo3d)+' ----------------------');
indpcor:=Dati^[tr]^.Pezzi[Pz];
codpcor:=Vpezzi^[indpcor]^.Codice;

with buf do
  begin
  entita:='D';
  Par[1]:=0;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=0;
  Par[5]:=0;
  Par[6]:=0;
  write_f3d(buf);

  Larg:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.A/conf^.altnum*40;
  Alt:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.B/conf^.altnum*40;

  Xp1:=(x1+x2)/2;
  Yp1:=(y1+y2)/2;
  Xp2:=(x3+x4)/2;
  Yp2:=(y3+y4)/2;
  Cx:=(xp1+xp2)/2;
  Cy:=(yp1+yp2)/2;

  //if dz=0 then
  Lung:=sqrt(sqr(xp2-xp1)+sqr(yp2-yp1)+sqr(z2-z1));
  //else lung:=abs(dz);

  {
  entita:='R';
  Par[1]:=90;
  Par[2]:=1;
  Par[3]:=0;
  Par[4]:=0;
  write(f3d,buf);
  }

  if Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.B =0 then
  begin
  Larg:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.R/conf^.altnum*40;
  entita:='C';
  end
  else
  entita:='P';
  Par[1]:=larg;
  Par[2]:=Alt;
  Par[3]:=Lung;
  write_f3d(buf);


  entita:='I';
  Par[1]:=CX;
  Par[2]:=Cy;
  Par[3]:=(Z1+z2)/2;
  Calc_d(xp1,yp1,z1,xp2,yp2,z2,dir,dirz);
  if abs(dirz-pi/2)<0.01 then dir:=ultd;
  Par[4]:=0;
  Par[5]:=-dir+Pi/2;
  Par[6]:=dirz;
  //if dz<>0 then Par[6]:=pi/2;
  write_f3d(buf);
  end;

end;

Procedure DisegnaCanA(x1,y1,x2,y2,x3,y3,x4,y4:real;tr,pz:integer);
Var Xp1,Yp1,Xp2,Yp2,dir,dirz,lung,larg,alt,Cx,Cy:real;

begin
codpcor:='310R';
indpcor:=0;

with buf do
  begin
  Larg:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.A/conf^.altnum*40;
  Alt:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.B/conf^.altnum*40;

  Xp1:=(x1+x2)/2;
  Yp1:=(y1+y2)/2;
  Xp2:=(x3+x4)/2;
  Yp2:=(y3+y4)/2;
  Cx:=(xp1+xp2)/2;
  Cy:=(yp1+yp2)/2;

  Lung:=sqrt(sqr(xp2-xp1)+sqr(yp2-yp1));

  entita:='T';
  Par[1]:=CX;
  Par[2]:=Cy;
  Par[3]:=0;
  write_f3d(buf);

  Calc_d(xp1,yp1,0,xp2,yp2,0,dir,dirz);
  entita:='R';
  Par[1]:=dir;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=-1;
  write_f3d(buf);
  {
  entita:='R';
  Par[1]:=90;
  Par[2]:=1;
  Par[3]:=0;
  Par[4]:=0;
  write(f3d,buf);
  }

  if Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.B =0 then
  begin
  Larg:=Vpezzi^[Dati^[tr]^.Pezzi[Pz]]^.R/conf^.altnum*40;
  entita:='C';
  end
  else
  entita:='B';


  Par[1]:=larg;
  Par[2]:=Alt;
  Par[3]:=Lung;
  write_f3d(buf);


  {
  entita:='R';
  Par[1]:=90;
  Par[2]:=-1;
  Par[3]:=0;
  Par[4]:=0;
  write(f3d,buf);
  }
  entita:='R';
  Par[1]:=dir;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=1;
  write_f3d(buf);

  entita:='A';
  Par[1]:=CX;
  Par[2]:=Cy;
  Par[3]:=0;
  write_f3d(buf);
  end;

end;
end.
