procedure inters(var x,y:real;var res:integer;x1,x2,x3,x4,y1,y2,y3,y4:real);
var  m1,m2,c1,c2,max1,max2,min1,min2:real;

begin

if ( (abs(x1-x3)<= apr) and (abs(y1-y3)<= apr) )or
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
    if (abs(x2-x1)>10E-6) and ((x2 - x1) <> 0) then m1:=(y2-y1)/(x2-x1)
    else m1:=10E6;
    if (abs(x4-x3)>10E-6) and ((x4 - x3) <> 0) then m2:=(y4-y3)/(x4-x3)
    else m2:=10E6;
    if abs(m2-m1)>10E-6 then
      begin

      c1:=y1-m1*x1;
      c2:=y3-m2*x3;
      if (m1-m2) = 0 then x := 0
      else x:=(c2-c1)/(m1-m2);
      y:=m1*x+c1;

(*      writeln('inters1 ');
      writeln('x ',x:5:5);
      writeln('y ',y:5:5);
      writeln('apr ',apr:5:5);
      repeat until keypressed; *)

      if ((x-x1>=-apr)or(x-x2>=-apr))and { verifica se il punto e' interno ai segmenti }
         ((x-x1<=+apr)or(x-x2<=+apr))and
         ((y-y1>=-apr)or(y-y2>=-apr))and
         ((y-y1<=+apr)or(y-y2<=+apr))and
         ((x-x3>=-apr)or(x-x4>=-apr))and
         ((x-x3<=+apr)or(x-x4<=+apr))and
         ((y-y3>=-apr)or(y-y4>=-apr))and
         ((y-y3<=+apr)or(y-y4<=+apr)) then res:=1

      else  res:=0;


(*     clrscr;
     writeln ('(  (x-x1>=-apr)or(x-x2>=-apr))  = ',((x-x1>=-apr)or(x-x2>=-apr)));
     writeln('  ((x-x1<=+apr)or(x-x2<=+apr))   = ',((x-x1<=+apr)or(x-x2<=+apr)));
     writeln(' ( (y-y1>=-apr)or(y-y2>=-apr))   = ',((y-y1>=-apr)or(y-y2>=-apr)));
     writeln(' ((y-y1<=+apr)or(y-y2<=+apr))    = ',((y-y1<=+apr)or(y-y2<=+apr)));
     writeln(' ((x-x3>=-apr)or(x-x4>=-apr))    = ',((x-x3>=-apr)or(x-x4>=-apr)));
     writeln(' ((x-x3<=+apr)or(x-x4<=+apr))    = ',((x-x3<=+apr)or(x-x4<=+apr)));
     writeln(' ((y-y3>=-apr)or(y-y4>=-apr))    = ',((y-y3>=-apr)or(y-y4>=-apr)));
     writeln(' ((y-y3<=+apr)or(y-y4<=+apr))    = ',((y-y3<=+apr)or(y-y4<=+apr)));
     writeln('x : ',x:5:5);
     writeln('x3 : ',x3:5:5);
     writeln('x4 : ',x4:5:5);
     writeln('x-x3 : ',(x-x3):5:5);
     writeln('x-x4 : ',(x-x4):5:5);
     repeat until keypressed; *)
(*      writeln('c1:',c1:6:3,' c2:',c2:6:3,'  m1:',m1:6:3,'  m2:',m2:6:3);*)

      end
    else res:=0;
    end
  else res:=0;
  end
else res:=0;
end;
