program arc;
var
    x,y,angtemp:real;
    i:integer;
    ang1,ang2,r:real;

    f:text;

    spxi,sux1,
          spyi,suy1,
          spxf,sux2,
          spyf,suy2:real
                        ;

Procedure converticord(var Xscal,Yscal:real;P1x,P1y,P2x,P2y,U1x,U1y,U2x,U2y:real);
begin

  Xscal:=(P2x-P1x)/(U2x-U1x)*Xscal+P1X-(U1x*(P2x-P1x)/(U2x-U1x));
  Yscal:=(P2Y-P1Y)/(U2Y-U1Y)*Yscal+P1Y-(U1Y*(P2Y-P1Y)/(U2Y-U1Y));

end;

begin
  assign(f,'prova.plt');
  rewrite(f);
  ang1:=pi/4;
  ang2:=pi/2;
  r:=20;
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
  i:=0;
  if ang1>ang2 then
   begin
     ang2:=ang2+2*pi;
   end;
   x:=r*COS(ang1);
   y:=r*SIN(ang1);
   converticord(x,y,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
   x:=round(x);
   y:=round(y);
   write(f,'PU;','PA',round(x),',',round(y),';');
   write(f,'PD;');
   repeat
     x:=r*COS(ang1);
     y:=r*SIN(ang1);
     ang1:=ang1+(ang2-ang1)/40;
     converticord(x,y,spxi,spyi,spxf,spyf,sux1,suy1,sux2,suy2);
     x:=round(x);
     y:=round(y);
     write(f,'PA',round(x),',',round(y),';')
   until (ang2)-(ang1)<=0.025;
   close(f);
end.