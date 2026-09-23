Unit Read_c;

Interface

Uses Definiz,Graph;

Implementation
Procedure Muovi_cur(x,y:real;Cod:integer);
begin
      case cod of
           1:begin
             if code=130 then
               begin
               uscita:=ultcom;
               delay(200);
               end;
               msnap(x,y,true);
               movhcurabs(@x,@y); {procedura vaga}
             end;
             2:begin              {Procedura tronco al punto}
                 delhcur;
                 if retino then Tretino(x,y,false);
                 int1:=8;
                 setcolor(int1);
                 setclip(@xw1,@yw1,@xw2,@yw2);
                 Movabs1(@xp,@yp);
                 rlnabs(@x,@y);
                 int1:=7;
                 setcolor(int1);
                 isocur(x,y,1);
               end;
             3:begin {cancella}
                 delhcur;
                 real1:=x-5;real2:=y-5;real3:=x+5;real4:=y+5;
                 rbox(@real1,@real2,@real3,@real4);
               end;
             4:begin  {zoom}
                 int1:=7;
                 setcolor(int1);
                 rbox(@xp,@yp,@x,@y);
               end;
          5,10:begin  {Snap a nodo}
                 min:=10E6;
                 indmin:=1;
                 trovato1:=false;
                 for i:=1 to ultriga do
                 with dis^[i]^ do
                 if (tronco >0)and(tronco<=ulttronco) then
                 if (entita='L')and((flag)or
                    ( (ug(x2,PXSez,2))and(ug(y2,PySez,2))and(ug(z2,PzSez,2)))or
                    ((not(sezione))and(Ug(z2,risultCalc.quota,2)))
                    )
                 then
                   begin
                   entra:=false;
                   if nlinea=0 then entra:=true
                   else if dis^[nlinea]^.entita[1]<>'T' then entra:=true;
                   if (cod=10)and(dis^[i]^.Rid='') then entra:=false;

                   if entra then
                     begin
                     {if i<>trattoin then
                       begin
                       xgraf:=xg(x1,y1);
                       ygraf:=yg(y1,z1);
                       if abs(x-xgraf)+abs(y-ygraf)<min then
                         begin
                         if (xgraf>0)and(xgraf<900)and(ygraf>45)and(ygraf<750) then
                           begin
                           min:=abs(x-xgraf)+abs(y-ygraf);
                           indmin:=i;
                           trattosel:=i;
                           inizio:=true;
                           end;
                         end;
                       end;}

                     xgraf:=xg(x2,y2);
                     ygraf:=yg(y2,z2);
                     if abs(x-xgraf)+abs(y-ygraf)<min then
                       begin
                       if (xgraf>0)and(xgraf<900)and(ygraf>45)and(ygraf<750) then
                         begin
                         min:=abs(x-xgraf)+abs(y-ygraf);
                         indmin:=i;
                         Trattosel:=i;
                         inizio:=false;
                         trovato1:=true;
                         end;
                       end;
                     end;
                   end;

                 if inizio then
                   begin
                   x:=xg(dis^[indmin]^.x1,dis^[indmin]^.y1);
                   y:=yg(dis^[indmin]^.y1,dis^[indmin]^.z1);
                   end
                 else
                   begin
                   x:=xg(dis^[indmin]^.x2,dis^[indmin]^.y2);
                   y:=yg(dis^[indmin]^.y2,dis^[indmin]^.z2);
                   end;

                 movhcurabs(@x,@y);
                 Trattosel:=Indmin;
                 if not trovato1 then code:=130;
               end;

             6:begin  {Snap a terminale}
                 x:=xe(x);
                 y:=ye(x,y);
                 primo:=1;
                 while (dis^[primo]^.entita<>'T')and(primo<nrighe) do primo:=primo+1;
                 with dis^[primo]^ do min:=abs(x-x1)+abs(y-y1);
                 indmin:=primo;
                 for i:=1 to nrighe do
                 with dis^[i]^ do
                 if entita='T' then
                 begin
                   if abs(x-x1)+abs(y-y1)<min then
                   begin
                     if (xg(x1,y1)>0)and(xg(x1,y1)<900)and(yg(y1,z1)>45)and(yg(y1,z1)<700) then
                     begin
                       min:=abs(x-x1)+abs(y-y1);
                       indmin:=i;
                     end;
                   end;
                 end;
                 setclip(@xw1,@yw1,@xw2,@yw2);
                 x:=xg(dis^[indmin]^.x1,dis^[indmin]^.y1);
                 y:=yg(dis^[indmin]^.y1,dis^[indmin]^.z1);
                 movhcurabs(@x,@y);
                 Trattosel:=indmin;
               end;

             7:begin   {snap a tronco}


               if (incl<=1)and(incl>=-1) then
                 begin

                   if (x>gx2)and(gx2>=gx1) then x:=gx2;
                   if (x<gx1)and(gx2>=gx1) then x:=gx1;
                   if (x<gx2)and(gx1>=gx2) then x:=gx2;
                   if (x>gx1)and(gx1>=gx2) then x:=gx1;
                   y:=gy1+(incl*(x-gx1))
                 end
               else
                 begin
                   if (y>gy2)and(gy2>=gy1) then y:=gy2;
                   if (y<gy1)and(gy2>=gy1) then y:=gy1;
                   if (y<gy2)and(gy1>=gy2) then y:=gy2;
                   if (y>gy1)and(gy1>=gy2) then y:=gy1;
                   x:=gx1+(1/incl)*(y-gy1);
                 end;
               {if retino then} Tretino(x,y,true);
               setcolor(7);
               isocur(x,y,1);
               end;
             8:begin      {-- inserimento numero tronco --}

               movtcurabs(@xpr,@ypr);
               stext(@stx);
               xpr:=x;ypr:=y;
               movtcurabs(@x,@y);
               stext(@stx);
               deltcur;
               end;
             9:begin   {-----snap a terminale----}
               trovato1:=false;
                 x:=xe(x);
                 y:=ye(x,y);
                 min:=10E6;
                 indmin:=1;
                 for i:=1 to ultriga do
                 with dis^[i]^ do

                 if (tronco >0)and(tronco<=ulttronco) then

                 if (entita='L')and (nlinea=0)and(flag)
                    and(dati^[tronco]^.pros[1]=0) then

                 if Dati^[tronco]^.Pezzi[1]<>0 then

                 begin
                   if abs(x-x2)+abs(y-y2)<min then
                   begin
                     if (xg(x2,y2)>0)and(xg(x2,y2)<900)and(yg(y2,z2)>45)and(yg(y2,z2)<750) then
                     begin
                       min:=abs(x-x2)+abs(y-y2);
                       indmin:=i;
                       trovato1:=true;
                     end;
                   end;
                 end;
                 x:=xg(dis^[indmin]^.x2,dis^[indmin]^.y2);
                 y:=yg(dis^[indmin]^.y2,dis^[indmin]^.z2);
                 movhcurabs(@x,@y);
                 Trattosel:=Indmin;
                 if not trovato1 then code:=130;
               end;

            11:begin              { selezione punto con isocur }
                 delhcur;
                 setclip(@xw1,@yw1,@xw2,@yw2);
                 MSnap(x,y,true);
                 int1:=7;
                 setcolor(int1);
                 isocur(x,y,1);
               end;

      end;
end;
end.
