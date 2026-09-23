{$A+,B-,D+,E-,F+,I+,L+,N-,O+,R+,S+,V+}
{$M 16384,0,655360}
{$C DEMANDLOAD}
unit dxfoutu;

interface

Procedure dxfout(nomefile:string;bt:boolean);


implementation

uses definiz,globfunz,diseg,defuti;


const
    Piano='  8';
    Nomi ='  2';
    Testo='  1';
    TLin ='  6';
    Pxi  ='  10';
    Pyi  ='  20';
    pzi  ='  30';
    AltT ='  40';
    pxf  ='  11';
    pyf  ='  21';
    pzf  ='  31';
    Color='  62';
    Fine ='  0';
    FX=0.025;
    FY=1.0;
col:array[1..15] of integer=(5,3,4,1,6,7,7,8,13,11,12,9,14,2,15);

var f,f2,f3,f4,F5:text;
    i:integer;
    f1:text;
    j,k:integer;
    s1,s2,s3,s4:string;
    xi,yi,zi:real;
    prima:boolean;
    codgr,codgr1:integer;
    esci:boolean;
    st1:string;
function Exist(Nome:string):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-*  PArc          *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure PArcD;

const Ndiv=20;

var i:integer;
    angpr,xpr,ypr,Xcor,ycor,Rcor:real;
    StepAng,StepCos:real;
begin
  with Vettore^ Do
  begin
    StepCos:=Pi/Ndiv;
    StepAng:=(y2-x2)/Ndiv;
    x2:=x2+2*pi;
    y2:=y2+2*pi;
    xpr:=X1+R*Cos(x2);
    ypr:=Y1+R*Sin(x2);
    writeln(f1,'POLYLINE');
    writeln(f1,piano);
    writeln(f1,'0');
    writeln(f1,color);
    writeln(f1,col[colore]);
    writeln(f1,'  66');
    writeln(f1,'     1');
    writeln(f1,pxi);
    writeln(f1,'0.0');
    writeln(f1,pyi);
    writeln(f1,'0.0');
    writeln(f1,pzi);
    writeln(f1,'0.0');
    writeln(f1,fine);
    writeln(f1,'VERTEX');
    writeln(f1,piano);
    writeln(f1,'0');
    xpr:=xpr*fx;
    ypr:=ypr*fx;
    str(xpr,s4);
    writeln(f1,pxi);
    writeln(f1,s4);
    s4:='';
    str(ypr,s4);
    writeln(f1,pyi);
    writeln(f1,s4);
    s4:='';
    writeln(f1,fine);
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
      writeln(f1,'VERTEX');
      writeln(f1,piano);
      writeln(f1,'0');
      xcor:=xcor*fx;
      str(xcor,s4);
      writeln(f1,pxi);
      writeln(f1,s4);
      s4:='';
      ycor:=ycor*fx;
      str(ycor,s4);
      writeln(f1,pyi);
      writeln(f1,s4);
      s4:='';
      writeln(f1,fine);
      XPr:=XCor;
      YPr:=YCor;
    end;
    writeln(f1,'SEQEND');
    writeln(f1,piano);
    writeln(f1,'0');
    writeln(f1,fine);
  end;
end;


procedure Linea(bd:boolean);
var c:string;
begin

  if bd then c:='LINE' else c:='3DLINE';
  writeln(f1,c);
  writeln(f1,piano);
  writeln(f1,'MC4-DUCT');
  writeln(f1,'  6');

  case vettore^.tlinea of
    1:writeln(f1,'CONTINUOUS');
    2:writeln(f1,'TRATTEGGIATA');
    3:writeln(f1,'TRATTO-PUNTO');
  end;

  writeln(f1,color);
  writeln(f1,col[vettore^.colore]);
  writeln(f1,pxi);
  writeln(f1,vettore^.x1*fx);
  writeln(f1,pyi);
  writeln(f1,vettore^.y1*fx);
  if not bd then
  begin
    writeln(f1,pzi);
    writeln(f1,vettore^.z2*fx);
  end;
  writeln(f1,pxf);
  writeln(f1,vettore^.x2*fx);
  writeln(f1,pyf);
  writeln(f1,vettore^.y2*fx);
  if not bd then
  begin
    writeln(f1,pzf);
    writeln(f1,vettore^.z2*fx);
  end;
  writeln(f1,fine);

end;


procedure arco(bd:boolean);
begin

  writeln(f1,'ARC');
  writeln(f1,piano);
  writeln(f1,'0');
  writeln(f1,'  6');

  case vettore^.tlinea of
  1:writeln(f1,'CONTINUOUS');
  2:writeln(f1,'TRATTEGGIATA');
  3:writeln(f1,'TRATTO-PUNTO');
  end;
  writeln(f1,color);
  writeln(f1,col[vettore^.colore]);
  writeln(f1,pxi);
  real1:=(vettore^.x1)*FX;
  str(real1,S4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,pyi);
  real2:=(vettore^.y1)*fx;
  str(real2,S4);
  writeln(f1,s4);
  s4:='';
  if not bd then
  begin
    writeln(f1,pzi);
    writeln(f1,vettore^.z2*fx);
  end;
  real3:=(vettore^.R)*fx;
  str(real3,s4);
  writeln(f1,'  40');
  writeln(f1,s4);
  s4:='';
  writeln(f1,'  50');
  real1:=vettore^.x2*180/PI;
  str(real1,s4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,'  51');
  real2:=vettore^.y2*180/PI;
  str(real2,s4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,fine);
end;

procedure cerchio(bd:boolean);
begin
  writeln(f1,'CIRCLE');
  writeln(f1,piano);
  writeln(f1,'0');
  writeln(f1,color);
  writeln(f1,col[vettore^.colore]);
  writeln(f1,'  6');
  case vettore^.tlinea of
  1:writeln(f1,'CONTINUOUS');
  2:writeln(f1,'TRATTEGGIATA');
  3:writeln(f1,'TRATTO-PUNTO');
  end;
  writeln(f1,pxi);
  real1:=vettore^.x1*fx;
  str(real1,s4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,pyi);
  real1:=vettore^.y1*fx;
  str(real1,s4);
  writeln(f1,s4);
  s4:='';
  if not bd then
  begin
    writeln(f1,pzi);
    writeln(f1,vettore^.z2*fx);
  end;
  real1:=vettore^.R*fx;
  writeln(f1,'  40');
  str(real1,s4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,fine);
end;

procedure quota(bd:boolean);
begin
  writeln(f1,'TEXT');
  writeln(f1,piano);
  writeln(f1,'0');
  writeln(f1,color);
  writeln(f1,col[vettore^.colore]);
  real1:=vettore^.x1*fx;
  str(real1,s4);
  writeln(f1,pxi);
  writeln(f1,s4);
  s4:='';
  real2:=vettore^.y1*fx;
  str(real2,s4);
  writeln(f1,pyi);
  writeln(f1,s4);
  s4:='';
  if not bd then
  begin
    writeln(f1,pzi);
    writeln(f1,vettore^.z1*fx);
  end;
  writeln(f1,altT);
  real1:=costant^.altquo;
  str(real1,s4);
  writeln(f1,s4);
  s4:='';
  writeln(f1,testo);
  st1:=outtextN(vettore^.r,vettore^.x2);
  writeln(f1,st1);
  int1:=round(vettore^.y2);
  real1:=int1*90;
  str(real1,s4);
  writeln(f1,'  50');
  writeln(f1,s4);
  s4:='';
  writeln(f1,'  41');
  writeln(f1,'0.55');
  writeln(f1,fine);
end;

Procedure PArc3D;

const Ndiv=20;

var i:integer;
    angpr,xpr,ypr,Xcor,ycor,Rcor:real;
    StepAng,StepCos:real;
begin
  with vettore^ Do
  begin
    StepCos:=Pi/Ndiv;
    StepAng:=(y2-x2)/Ndiv;
    x2:=x2+2*pi;
    y2:=y2+2*pi;
    xpr:=X1+R*Cos(x2);
    ypr:=Y1+R*Sin(x2);
    writeln(f1,'POLYLINE');
    writeln(f1,piano);
    writeln(f1,'0');
    writeln(f1,color);
    writeln(f1,col[colore]);
    writeln(f1,'  66');
    writeln(f1,'     1');
    writeln(f1,pxi);
    writeln(f1,'0.0');
    writeln(f1,pyi);
    writeln(f1,'0.0');
    writeln(f1,pzi);
    writeln(f1,'0.0');
    writeln(f1,' 70');
    writeln(f1,'    8');
    writeln(f1,fine);
    writeln(f1,'VERTEX');
    writeln(f1,piano);
    writeln(f1,'0');

    xpr:=xpr*fx;
    ypr:=ypr*fx;
    str(xpr,s4);
    writeln(f1,pxi);
    writeln(f1,s4);
    s4:='';
    str(ypr,s4);
    writeln(f1,pyi);
    writeln(f1,s4);
    s4:='';
    str(z2*fx,s4);
    writeln(f1,pzi);
    writeln(f1,s4);
    writeln(f1,' 70');
    writeln(f1,'    32');
    writeln(f1,fine);

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
      writeln(f1,'VERTEX');
      writeln(f1,piano);
      writeln(f1,'0');
      xcor:=xcor*fx;
      str(xcor,s4);
      writeln(f1,pxi);
      writeln(f1,s4);
      s4:='';
      ycor:=ycor*fx;
      str(ycor,s4);
      writeln(f1,pyi);
      writeln(f1,s4);
      s4:='';
      str(z2*fx,s4);
      writeln(f1,pzi);
      writeln(f1,s4);
      writeln(f1,' 70');
      writeln(f1,'    32');
      writeln(f1,fine);
      XPr:=XCor;
      YPr:=YCor;
    end;
    writeln(f1,'SEQEND');
    writeln(f1,piano);
    writeln(f1,'0');
    writeln(f1,fine);
  end;
end;


procedure face3d;
begin
  if vettore^.entita[1]<>'*' then
  begin
    k:=0;
    writeln(f1,'3DFACE');
    writeln(f1,piano);
    writeln(f1,'MC4-DUCT');
    writeln(f1,color);
    writeln(f1,col[vettore^.colore]);
    writeln(f1,pxi);
    real1:=(vettore^.x1)*fx;
    str(real1,S4);
    writeln(f1,s4);
    s4:='';
    writeln(f1,pyi);
    real2:=(vettore^.y1)*fx;
    str(real2,S4);
    writeln(f1,s4);
    s4:='';
    writeln(f1,pzi);
    real2:=(vettore^.z1)*fx;
    str(real2,S4);
    writeln(f1,s4);
    s4:='';
    if prima then
    begin
      xi:=(vettore^.x1)*fx;
      yi:=(vettore^.y1)*fx;
      zi:=(vettore^.z1)*fx;
      prima:=false;
    end;
  end
  else
  begin
    k:=k+1;
    case k of
    1:begin
        writeln(f1,pxf);
        real1:=(vettore^.x1)*fx;
        str(real1,S4);
        writeln(f1,s4);
        s4:='';
        writeln(f1,pyf);
        real2:=(vettore^.y1)*fx;
        str(real2,S4);
        writeln(f1,s4);
        s4:='';
        writeln(f1,pzf);
        real2:=(vettore^.z2)*fx;
        str(real2,S4);
        writeln(f1,s4);
        s4:='';
      end;
    2:begin
        writeln(f1,'  12');
        real1:=(vettore^.x1)*fx;
        str(real1,S4);
        writeln(f1,s4);
        s4:='';
        writeln(f1,'  22');
        real2:=(vettore^.y1)*fx;
        str(real2,S4);
        writeln(f1,s4);
        s4:='';
        writeln(f1,'  32');
        real2:=(vettore^.z1)*fx;
        str(real2,S4);
        writeln(f1,s4);
      end;
    3:begin
        writeln(f1,'  13');
        real1:=(vettore^.x1)*fx;
        str(real1,S4);
        writeln(f1,s4);
        s4:='';
        writeln(f1,'  23');
        real2:=(vettore^.y1)*fx;
        str(real2,S4);
        writeln(f1,s4);
        s4:='';
        writeln(f1,'  33');
        real2:=(vettore^.z1)*fx;
        str(real2,S4);
        writeln(f1,s4);
        writeln(f1,fine);
      end;
    end;
  end;
end;



Procedure dxfout(nomefile:string;bt:boolean);
VAR NGRS:STRING;
begin
if exist(DriveProg+NomeProg+'.DIM') then
begin
  Assign(Fdim,DriveProg+NomeProg+'.DIM');
  Reset(Fdim);
  s1:='';s2:='';s3:='';s4:='';
  assign(f,'dxf.dxf');
  reset(f);
  assign(f1,'block.tem');
  rewrite(f1);
  assign(f2,'entit.tem');
  rewrite(f2);
  assign(f4,'intest.tem');
  rewrite(f4);
  assign(f5,'DEBUG.tem');
  rewrite(f5);
  while (s1<>'BLOCKS')  DO
  begin
    readln(f,s1);
    writeln(f4,s1);
  end;
  writeln(f4,fine);

  codgr1:=1;
  writeln(f2,'ENTITIES');
  writeln(f2,'  0');
  read(Fdim,vettore^);

  esci:=false;
  While not(eof(Fdim)) do
  begin
    if(
    ((vettore^.z1>=Zmin_p)and(vettore^.z1<=Zmax_p))or
    ((vettore^.z2>=Zmin_p)and(vettore^.z2<=Zmax_p)))  then
    begin
      codgr:=vettore^.GRUPPO;
      prima:=true;
      writeln(f1,'BLOCK');
      writeln(f1,piano);
      writeln(f1,'MC4-DUCT');
      writeln(f1,nomi);
      str(codgr,ngrs);
      writeln(f1,nomeprog+ngrs);
      writeln(f1,' 70');
      writeln(f1,'    64');
      writeln(f1,' 10');
      writeln(f1,'0.0');
      writeln(f1,' 20');
      writeln(f1,'0.0');
      writeln(f1,' 30');
      writeln(f1,'0.0');
      writeln(f1,'  0');
      repeat
        Case vettore^.Entita[1] of
          'L':begin
                linea(bt);
                if eof(fdim) then esci:=true;
             end;

     'F','*':begin
               if bt then linea(true) else face3d;
               if eof(fdim) then esci:=true;
             end;
         'A':begin
               arco(bt);
               if eof(fdim) then esci:=true;
             end;
         'C':begin
               cerchio(bt);
               if eof(fdim) then esci:=true;
             end;
         'P':begin
               if bt then PArcD else parc3d;
               if eof(fdim) then esci:=true;
             end;
         'Q':begin
              quota(bt);
              if eof(fdim) then esci:=true;
             end;
        end; {case}
        if not eof(fdim) then read(fdim,vettore^);
      until(codgr<>vettore^.GRUPPO) OR esci;
      writeln(f5,vettore^.gruppo);
      writeln(f1,'ENDBLK');
      writeln(f1,'  8');
      writeln(f1,'MC4-DUCT');
      WRITELN(F1,'  0');
      writeln(f2,'INSERT');
      writeln(f2,piano);
      writeln(f2,'MC4-DUCT');
      writeln(f2,nomi);
      writeln(f2,NOMEPROG+ngrs);
      writeln(f2,' 10');
      writeln(f2,'0,0');
      writeln(f2,' 20');
      writeln(f2,'0,0');
      writeln(f2,' 30');
      writeln(f2,'0.0');
      writeln(f2,'  0');
      codgr:=vettore^.GRUPPO;
     end
     else
     begin
       read(Fdim,vettore^);
     end;{if in zmin zmax}
  end;{while not eof fdim}
end;{if exist}
close(FDim);
close(f);
writeln(f1,'ENDSEC');
writeln(f1,'  0');
writeln(f1,'SECTION');
writeln(f1,'  2');
close(f1);
writeln(f2,'ENDSEC');
writeln(f2,'  0');
writeln(f2,'EOF');
close(f2);
close(f4);
assign(f3,nomefile);
rewrite(f3);
assign(f4,'intest.tem');
reset(f4);
while not eof(f4) do
begin
 readln(f4,s1);
 writeln(f3,s1);
end;
close(f4);
assign(f1,'block.tem');
reset(f1);
while not eof(f1) do
begin
 readln(f1,s1);
 writeln(f3,s1);
end;
close(f1);
assign(f2,'entit.tem');
reset(f2);
while not eof(f2) do
begin
 readln(f2,s1);
 writeln(f3,s1);
end;
close(f2);
close(f3);
CLOSE(F5);
end;
end.