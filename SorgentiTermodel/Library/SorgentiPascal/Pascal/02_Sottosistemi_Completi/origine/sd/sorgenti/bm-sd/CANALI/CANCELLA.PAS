Procedure Cancella;
var i,j,res:integer;
begin
ST1:='';
x:=500;y:=350;
orglocator(@x,@y);
richiesta('Selezionare entita`');
setclip(@xw1,@yw1,@xw2,@yw2);
delay(200);
  repeat
  readcord(x,y,cod,scelta,ST1,3);
  delay(200);
    case cod of
    132:begin
        int1:=7;
        setcolor(@int1);
        delbox;
        for i:=1 to nrighe do
          begin
          with dis^[i] do
            begin
            inters(real1,real2,res,x1,x2,xe(x+5),xe(x-5),y1,y2,ye(y+5),ye(y-5),0.001);
            if res=1 then
              begin
              int1:=0;setcolor(@int1);
              real1:=xg(x1);real2:=yg(y1);
              movabs(@real1,@real2);
              real1:=xg(x2);real2:=yg(y2);
              lnabs(@real1,@real2);
              int1:=col;setcolor(@int1);
              for j:=i to nrighe-1 do dis^[j]:=dis^[j+1];
              nrighe:=nrighe-1;
              end;
            end
          end;
        end
    end;
    if x>910 then delbox;
  until (cod=130)OR(SCELTA<>0);
 delbox;
setclip(@minxw,@minyw,@maxxw,@maxyw);
richiesta('');
end;
