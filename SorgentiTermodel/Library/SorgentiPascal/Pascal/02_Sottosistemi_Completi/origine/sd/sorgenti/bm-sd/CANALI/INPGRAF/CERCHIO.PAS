{$A+,B-,D+,E+,F-,I+,L+,N-,O+,R+,S+,V+}
{$M 16384,0,655360}

program plot;


uses crt,definiz,globfunz;




procedure plotter(nome,porta:string);

var Ii,k,j:integer;
    f,f1,f2:text;
    pxi3,pyi3:real;
    real5:real;
    spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2:real;
    fp,fx:real;
    fr:integer;
    tratt:boolean;
    AltN,AltNC:real;
    ch:array[1..4] of string;
    ch1:string;
const a='PA';
      d='PD;';
      u='PU;';
      i='IP';
      p='SP';
      Fht=0.666666666;
Procedure converticord(var Xscal,Yscal:real;P1x,P1y,P2x,P2y,U1x,U1y,U2x,U2y:real);
begin

  Xscal:=(P2x-P1x)/(U2x-U1x)*Xscal+P1X-(U1x*(P2x-P1x)/(U2x-U1x));
  Yscal:=(P2Y-P1Y)/(U2Y-U1Y)*Yscal+P1Y-(U1Y*(P2Y-P1Y)/(U2Y-U1Y));

end;


procedure arcplt(xa1,ya1,ang1,ang2,r:real;tr:boolean);

var
    x,y,angtemp:real;
    i:integer;

begin
  i:=0;
  if ang1>ang2 then
   begin
     ang2:=ang2+2*pi;
   end;
   x:=r*COS(ang1)+xa1;
   y:=r*SIN(ang1)+ya1;
   converticord(x,y,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
   x:=round(x);
   y:=round(y);
   write(f,u,a,round(x),',',round(y),';');
   write(f,d);
   repeat
     x:=r*COS(ang1)+xa1;
     y:=r*SIN(ang1)+ya1;
     ang1:=ang1+(ang2-ang1)/40;
     converticord(x,y,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
     x:=round(x);
     y:=round(y);
     write(f,a,round(x),',',round(y),';')
   until (ang2)-(ang1)<=0.025;
end;







Procedure PArcP;

const Ndiv=20;

var i:integer;
    angpr,xpr,ypr,Xcor,ycor,Rcor:real;
    StepAng,StepCos:real;
begin
  with Vettore Do
  begin
    StepCos:=Pi/Ndiv;
    StepAng:=(y2-x2)/Ndiv;
    x2:=x2+2*pi;
    y2:=y2+2*pi;
    xpr:=X1+R*Cos(x2);
    ypr:=Y1+R*Sin(x2);
    xpr:=xpr*fx;
    ypr:=ypr*fx;
    real1:=xpr;
    real2:=ypr;
    converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
    write(f,u,a,round(real1),',',round(real2),';');
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
      xcor:=xcor*fx;
      ycor:=ycor*fx;
      real1:=xcor;
      real2:=ycor;
      converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
      write(f,d,a,round(real1),',',round(real2),';');
      XPr:=XCor;
      YPr:=YCor;
    end;
  end;
end;



        begin
          ii:=0;
          tratt:=false;
          {leggiconf;}
          fr:=0;
          fx  :=0.025;

          sux1:=0;
          suy1:=0;
          sux2:=420;
          suy2:=297;

          if sux2 > 450 then
          begin
            sux1:=-sux2/2;
            suy1:=-suy2/2;
            sux2:=sux2/2;
            suy2:=suy2/2;
          end;
          spxi:=sux1*40;
          spyi:=suy1*40;
          spxf:=sux2*40;
          spyf:=suy2*40;
          AltN:=(sux2/1135.85*5.5);
          AltNC:=AltN/10;
          Assign(Fdim,nome);
          Reset(Fdim);
          assign(f,'Spool.plt');
          rewrite(f);
          write(f,'RO',fr,';','SP1',';');

          While not(eof(Fdim)) do
          begin
            read(Fdim,Vettore);
            Case Vettore.Entita[1] of
            'L':begin

                  case vettore.tlinea of
                    1:writeln(f,'LT;');
                    2:writeln(f,'LT2;');
                    3:writeln(f,'LT4;');
                  end;
                  {write(f,'SP',vettore.colore,';');}
                  write(f,U);
                  real1:=(Vettore.x1)*fx;
                  real2:=(Vettore.y1)*fx;
                  converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
                  write(f,a,round(real1),',',round(real2),';');
                  write(f,d);
                  real1:=(Vettore.x2)*fx;
                  real2:=(Vettore.y2)*fx;
                  converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
                  write(f,a,round(real1),',',round(real2),';');
                end;
         'F','*':begin
                   if vettore.entita[1]<>'*' then
                   begin

                     k:=0;
                     {write(f,'SP',vettore.colore,';');}
                     write(f,U);
                     pxi3:=(Vettore.x1*fx);
                     pyi3:=(Vettore.y1*fx);
                     converticord(pxi3,pyi3,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
                     write(f,a,round(pxi3),',',round(pyi3),';');
                   end
                   else
                   begin
                     k:=k+1;
                     case k of
                       1:begin
                           write(f,d);
                           real1:=(Vettore.x1*fx);
                           real2:=(Vettore.y1*fx);
                           converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
                           write(f,a,round(real1),',',round(real2),';');
                         end;
                       2:begin
                           write(f,d);
                           real1:=(Vettore.x1*fx);
                           real2:=(Vettore.y1*fx);
                           converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
                           write(f,a,round(real1),',',round(real2),';');
                         end;
                       3:begin
                           write(f,d);
                           real1:=(Vettore.x1*fx);
                           real2:=(Vettore.y1*fx);
                           converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
                           write(f,a,round(real1),',',round(real2),';');
                           write(f,a,round(pxi3),',',round(pyi3),';');
                         end;
                     end;
                   end;
                 end;

              'A':begin

                   case vettore.tlinea of
                     1:tratt:=false;
                   2,3:tratt:=true;
                  end;
                  {writeln(f,'SP',vettore.colore);}
                  real1:=(Vettore.x1)*FX;
                  real2:=(Vettore.y1)*fx;
                  real3:=(Vettore.R)*fx;
                  real4:=Vettore.x2;
                  real5:=Vettore.y2;
                  arcplt(real1,real2,real4,real5,real3,false);
                 end;

              'C':begin
                   case vettore.tlinea of
                    1:tratt:=false;
                  2,3:tratt:=true;
                  end;
                  {writeln(f,'SP',vettore.colore);}
                  real1:=(Vettore.x1)*FX;
                  real2:=(Vettore.y1)*fx;
                  real3:=(Vettore.R)*fx;
                  real4:=0;
                  real5:=2*pi;
                  arcplt(real1,real2,real4,real5,real3,false);
                end;

            'P':PArcP;

            'Q':begin
                   Ii:=Ii+1;
                   write(f,'DT',chr(3),';');
                   {write(f,'SP',vettore.colore,';');}
                   real1:=Vettore.x1*fx;
                   case round(vettore.y2 ) of
                   0,2:begin
                        if (ii mod 2 <> 0) then real2:=Vettore.y1*fx
                        else real2:=(Vettore.y1*fx)+(5.5-AltN);
                       end;
                   else
                   begin
                     real2:=Vettore.y1*fx;
                     if (ii mod 2 = 0) then real1:=(vettore.x1*fx)-(5.5*fht-AltN);
                   end;
                   end;


                   st1:=outtext(vettore.r,vettore.x2);
                   converticord(real1,real2,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
                   real3:=cos(vettore.y2*PI/2);
                   real4:=sin(vettore.y2*PI/2);
                   write(f,u,a,round(real1),',',round(real2),';','SI',fht*AltNC,
                   ',',AltNC,';','DI',REAL3,',',REAL4,';''LB',st1,chr(3));

                end;




  end;
 end;
 close(fdim);
 close(f);
 assign(f,porta);
 rewrite(f);
 assign(f1,'spool.plt');
 reset(f1);
 assign(f2,porta);
 reset(f2);
 while not eof(f1) do
   begin
       read(f1,ch[k]);
       write(f,ch[k]);
       write(f,'.B;');
       readln(f2,ch1);
       val(ch1,j,k);
   end;
 close(f);
 close(f1);
 end;
begin
plotter('c:\daticca\progetti\pippo4.dim','com2');
end.