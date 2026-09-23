unit Interf3D;
interface
uses definiz,angoli,funzdim,U_varpezzi,wintypes,winprocs
     {$ifdef delphi},messages{$endif};



Var F3d:file of Int3d;
    F3dTxt:text;
Procedure Init3d;
Procedure cLOSE3d;
Procedure DisegnaCan(x1,y1,x2,y2,x3,y3,x4,y4:real;tr,pz:integer);
Procedure DisegnaCan1(tr,pz:integer;Xp1,Yp1,Zp1,Xp2,Yp2,Zp2,ultang:real);

Procedure CopiaPezzo3d;
Procedure Inser3d(DX,DY,DZ,Rot,rotz:real);
Procedure Scrivi3d;
Procedure Stampa_unif_3d;
procedure  InitTab3d;
Procedure Trasla(x,y,z:real);
Procedure Trasla1(x,y,z:real);
Procedure Ruota(ang,x,y,z:real);
Procedure Ruota1(ang,x,y,z:real);
Procedure RuotaZ(ang,x,y,z:real);
Procedure Box1(orie,larg,alt,Lung,dx,dy,dz,ang:real);
{Procedure Box(orie,larg,alt,Lung,dx,dy,dz,ang:real);}
Procedure Trasforma1(orie,T1,a_r1,alt1,T2,a_r2,alt2,eccx,eccy,Lung,dx,dy,dz,ang:real);
Procedure Cilindro1(orie,Diam,Lung,dx,dy,dz,ang:real);
Procedure Annulla(x,y,z:real);
Procedure Annulla1(x,y,z:real);
{Procedure Curva3d(ang,orie,R,A1,A2,B,Dx,Dy,Dz:real);}
Procedure Curva3d1(ang,orie,verso,R,A1,A2,B,Dx,Dy,Dz:real);
Procedure Componi3d(orie:integer;pu1_0,Pu1_1:real);
Procedure IniziaPezzo3d(orie:integer);
Procedure FinePezzo3d(orie:integer);


implementation
Var  buf:int3d;
     Indpezzo3d:integer;


{---------------------------------------------------------------------------}
Procedure Box1(orie,larg,alt,Lung,dx,dy,dz,ang:real);
begin

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
Procedure Box(orie,larg,alt,Lung,dx,dy,dz,ang:real);
begin
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

{---------------------------------------------------------------------------}
Procedure Cilindro1(orie,Diam,Lung,dx,dy,dz,ang:real);
begin

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
Procedure Trasla1(x,y,z:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='L';
  Par[1]:=x;
  Par[2]:=y;
  Par[3]:=z;
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
Procedure Curva(ang,R,A1,A2,B:real);
begin
indpezzo3d:=indpezzo3d+1;
with DisPezzo3d^[indpezzo3d] do
  begin
  entita:='V';
  Par[1]:=ang;
  Par[2]:=R/conf^.altnum*40;
  Par[3]:=A1/conf^.altnum*40;
  Par[4]:=A2/conf^.altnum*40;
  Par[5]:=b/conf^.altnum*40;
  end;
end;

{---------------------------------------------------------------------------}
Procedure IniziaPezzo3d(orie:integer);
begin
trasla1(0,0,0);

Ruota(Pi/2,0,0,-1);

RuotaZ(0,1,0,0);  {Rot verticale}

{Ruota(0,0,0,-1);}

case round(orie) of
1:Ruota(pi,0,1,0);
4:Ruota(pi/2,0,1,0);
2:Ruota(3/2*pi,0,1,0);
5:Ruota(pi/2,0,1,0);
6:Ruota(3*pi/2,0,1,0);
end;

{trasla(Dx,Dy,Dz);}

end;

{---------------------------------------------------------------------------}
Procedure FinePezzo3d(orie:integer);
begin

{annulla(Dx,Dy,Dz);}

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

Procedure Curva3d1(ang,orie,verso,R,A1,A2,B,Dx,Dy,Dz:real);
Var temp:real;
begin

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

Procedure Scrivi3d;
Var i:Integer;
begin
i:=1;
repeat
if DisPezzo13d^[i].entita<>' ' then
  begin
  write(f3d,DisPezzo13d^[i]);
  with DisPezzo13d^[i] do
  writeLn(f3dtxt,entita,' P1:',Par[1]:5:1,' P2:',Par[2]:5:1,' P3:',
           Par[3]:5:1,' P4:',Par[4]:5:1,' P5:',Par[5]:5:1);
  end;
i:=i+1;
until DisPezzo13d^[i].entita=' ';
end;

{---------------------------------------------------------------------------}


procedure  InitTab3d;
 var i:integer;
begin
indpezzo3d:=0;
   for i:=1 to 30 do
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

for i:=1 to 30 do
  begin
  DisPezzo13d^[i]:=DisPezzo3d^[i];
  if DisPezzo3d^[i].Entita[1]=' ' then DisPezzo13d^[i].Entita:=' ';
  end;

for i:=31 to 50 do
begin
FillChar(DisPezzo13d^[i],sizeof(DisPezzo13d^[i]),' ');
DisPezzo13d^[i].entita:=' ';
end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Inser           *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Inser3d(DX,DY,DZ,Rot,rotz:real);


var i:integer;

begin
for i:=1 to 30 do
with DisPezzo13d^[i] do
if entita[1]<>' ' then
  begin
  {ModiCord(X1,Y1,Dx,Dy,Rot,true);}
  case entita[1] of
  'T','A':
      begin
      {ModiCord(Par[1],Par[2],0,0,Rot,true);}
      {Par[1]:=Par[1]+DX;
      Par[2]:=Par[2]+DY;}
      {Par[3]:=0;}
      end;
  'L','N':
      begin
      Par[1]:=Par[1]+DX;
      Par[2]:=Par[2]+DY;
      Par[3]:=Par[3]+DZ;
      end;

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
  sendmessage(hd,wm_user+101,0,0);
end;
end;

{---------------------------------------------------------------------------}

Procedure DisegnaCan1(tr,pz:integer;Xp1,Yp1,Zp1,Xp2,Yp2,Zp2,ultang:real);

Var dir,dirz,lung,larg,alt,Cx,Cy,CZ:real;

begin

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
  write(f3d,buf);

  Calc_d(xp1,yp1,Zp1,xp2,yp2,Zp2,dir,dirz);
  if ug(abs(dirz),Pi/2,1) then dir:=ultang;

  entita:='R';
  Par[1]:=dir;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=-1;
  write(f3d,buf);

    entita:='R';
  Par[1]:=dirz;
  Par[2]:=1;
  Par[3]:=0;
  Par[4]:=0;
  write(f3d,buf);



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
  write(f3d,buf);




  entita:='R';
  Par[1]:=Dirz;
  Par[2]:=-1;
  Par[3]:=0;
  Par[4]:=0;
  write(f3d,buf);

   entita:='R';
  Par[1]:=dir;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=1;
  write(f3d,buf);

  entita:='A';
  Par[1]:=CX;
  Par[2]:=Cy;
  Par[3]:=CZ;
  write(f3d,buf);
  end;

end;

{---------------------------------------------------------------------------}

Procedure DisegnaCan(x1,y1,x2,y2,x3,y3,x4,y4:real;tr,pz:integer);
Var Xp1,Yp1,Xp2,Yp2,dir,dirz,lung,larg,alt,Cx,Cy:real;

begin

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
  write(f3d,buf);

  Calc_d(xp1,yp1,0,xp2,yp2,0,dir,dirz);
  entita:='R';
  Par[1]:=dir;
  Par[2]:=0;
  Par[3]:=0;
  Par[4]:=-1;
  write(f3d,buf);
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
  write(f3d,buf);


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
  write(f3d,buf);

  entita:='A';
  Par[1]:=CX;
  Par[2]:=Cy;
  Par[3]:=0;
  write(f3d,buf);
  end;

end;
end.
