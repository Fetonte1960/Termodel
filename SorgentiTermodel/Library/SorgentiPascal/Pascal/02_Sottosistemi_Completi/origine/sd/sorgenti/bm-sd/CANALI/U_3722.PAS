

unit U_3722;

interface

Procedure D_3722;
Procedure D_3723;
procedure D_3736;

implementation

uses {crt,printer,dos,}definiz,definizcan,U_VARPEZZI,interf3d;


procedure D_3722;
 begin
    case orient of
            1:begin
                 Alfa:=arccos((B1+(B3*Curv)-B2)/(B3*Curv+B3));
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3*Curv+B3/2)+abs((B3*Curv+B3)*sin(Alfa));
                     Y2:=(B1/2)-B2;
                     X2:=X1+B3*Costant^.C22;
                     Y1:=(B1/2)-B2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3*Curv+B3/2);  Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=-(B3*Curv+(B3/2));     Y1:=-(B1/2)-B3*Curv;
                     X2:=0;                Y2:=pi/2;
                     R:=B3*Curv;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=-(B3*Curv+(B3/2));     Y1:=-(B1/2)-B3*Curv;
                     X2:=0;                Y2:=(pi/2)-Alfa;
                     R:=B3*Curv+B3;
                  end;



                 X1A:=DisPezzo^[2].X1;
                 Y1A:=DisPezzo^[2].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=-DisPezzo^[2].Y1;

                 X3A:=DisPezzo^[2].X2;
                 Y3A:=DisPezzo^[2].Y2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=DisPezzo^[1].Y2;

                 X5A:=B3/2;
                 Y5A:=-(B1/2)-B3*Curv;

                 X6A:=-B3/2;
                 Y6A:=-(B1/2)-B3*Curv;
              end;
            3:begin
                 Alfa:=arccos((B1+(B3*Curv)-B2)/(B3*Curv+B3));
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3*Curv+B3/2)+abs((B3*Curv+B3)*sin(Alfa));
                     Y2:=-(B1/2)+B2;
                     X2:=X1+B3*Costant^.C22;
                     Y1:=-(B1/2)+B2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3*Curv+B3/2);  Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=-(B3*Curv+(B3/2));     Y1:=(B1/2)+B3*Curv;
                     X2:=-pi/2;            Y2:=0;
                     R:=B3*Curv;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=-(B3*Curv+(B3/2));     Y1:=(B1/2)+B3*Curv;
                     X2:=-(pi/2)+Alfa;     Y2:=0;
                     R:=B3*Curv+B3;
                  end;


                 X1A:=DisPezzo^[2].X1;
                 Y1A:=-DisPezzo^[2].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;

                 X3A:=DisPezzo^[2].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;
                 X5A:=-B3/2;
                 Y5A:=(B1/2)+B3*Curv;
                 X6A:=B3/2;
                 Y6A:=(B1/2)+B3*Curv;
              end;

          2,4:begin
                Alfa:=arccos((H1+(H3*Curv)-H2)/(H3*Curv+H3));
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3*Curv+H3/2);       Y1:=B1/2;
                     X2:=-(H3*Curv+H3/2)+abs((H3*Curv+H3)*sin(Alfa))+H3*Costant^.C22;
                     Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3*Curv+H3/2);       Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;        Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-(H3*Curv+H3/2)+abs((H3*Curv+H3)*sin(Alfa));
                     Y1:=B1/2;
                     X2:=-(H3*Curv+H3/2)+abs((H3*Curv+H3)*sin(Alfa));
                     Y2:=-B1/2;
                  end;

                 if Orient=2 then
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H3/2;            Y1:=B1/2;
                         X2:=-H3/2;            Y2:=-B1/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H3/2;             Y1:=B1/2;
                         X2:=H3/2;             Y2:=-B1/2;
                      end;

                  end;

                 X1A:=-(H3*Curv+H3/2);
                 Y1A:=B1/2;
                 X2A:=-(H3*Curv+H3/2);
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-B1/2;
                 X5A:=0;
                 Y5A:=B1/2;
                 X6A:=0;
                 Y6A:=-B1/2;
                 if Orient = 2 then Z3:=-(H1/2)-H3*Curv
                 else Z3:=(H1/2)+H3*Curv;
              end;


            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H3*Curv+H1/2;          Y1:=B1/2;
                     X2:=H1/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H3*Curv+H1/2;          Y1:=-B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;
                 if H1<>H2 then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';        TLinea:=2;
                         X1:=-H1/2+H2;       Y1:=B1/2;
                         X2:=-H1/2+H2;       Y2:=-B1/2;
                      end;
                   end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=-H1/2+H2/2;
                 Y3A:=B1/2;
                 X4A:=-H1/2+H2/2;
                 Y4A:=-B1/2;
                 X5A:=H3*Curv+H1/2;
                 Y5A:=B1/2;
                 X6A:=H3*Curv+H1/2;
                 Y6A:=-B1/2;
                 Alfa:=arccos((H1+(H3*Curv)-H2)/(H3*Curv+H3));
                 Z1:=(H3*Curv+H3/2);
                 Z2:=(H3*Curv+H3/2)-abs((H3*Curv+H3)*sin(Alfa))-H3*Costant^.C22;
              end;

            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H3*Curv+H1/2;          Y1:=B1/2;
                     X2:=-H1/2+H2;         Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H3*Curv+H1/2;          Y1:=-B1/2;
                     X2:=-H1/2+H2;         Y2:=-B1/2;
                  end;
                 if H1<>H2 then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';        TLinea:=2;
                         X1:=H1/2;           Y1:=B1/2;
                         X2:=H1/2;           Y2:=-B1/2;
                      end
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=-H1/2+H2/2;
                 Y3A:=B1/2;
                 X4A:=-H1/2+H2/2;
                 Y4A:=-B1/2;
                 X5A:=H3*Curv+H1/2;
                 Y5A:=B1/2;
                 X6A:=H3*Curv+H1/2;
                 Y6A:=-B1/2;
                 Alfa:=arccos((H1+(H3*Curv)-H2)/(H3*Curv+H3));
                 Z1:=-(H3*Curv+H3/2);
                 Z2:=-(H3*Curv+H3/2)+abs((H3*Curv+H3)*sin(Alfa))+H3*Costant^.C22;
              end;

       end;
 end;
procedure D_3723;
  Var i:integer;
      angol,rin,rfin,rcor:real;
      yarc:real;
      xmin:real;
      Ymin:real;
      xcor:real;
      Clun:real;

 begin


    Clun:=0.2*Costant^.C54;
    Alfa:=B1*Rap;
    yMin:=0;
    yarc:=0;
    if B1*Rap < B2 then
    BEGIN
    Rin:=ArrotDec(B1*(1-Rap));
    Rin:=(B3*Curv+Rin);
    xmin:=abs(B3*curv+b1-B2-Rin);
    Ymin:=0;
    Rfin:=B3*Curv+B3;

    for i:=1 to 20 do
      begin
      Rcor:=Rfin-1/2*(Rfin-Rin)*(1+Cos(i*Pi/20));
      if i<>20 then
        begin
        if Rcor >Rin/Cos(i*pi/40) then Rcor:=Rin/Cos(i*pi/40);
        end;
      Xcor:=abs(B3*curv+b1-B2-(Rcor*Cos(i*pi/40)));
      if xcor<=Xmin then
        begin
        Xmin:=Xcor;
        Ymin:=Rcor*sin(i*pi/40);
        end;
      end;
    END;

    curva3d1(pi/2,orient,1,b3*curv,b1*(1-rap),b3,h1,-(b1/2-b1*(1-rap)/2),0,0);
    {Procedure Trasforma1(orie,T1,a_r1,alt1,T2,a_r2,alt2,eccx,eccy,Lung,dx,dy,dz,ang:real);}
    Trasforma1(1,1,B1*rap,H1,1,B2,H1,-b2/2+(b1*rap)/2,0,B3*Curv+B3/2+B3/2+clun*b2,b1/2-(b1*rap)/2,B3/2+clun*b2,0,0);


    case orient of
            1:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2+clun*b2;
                     Y1:=B1/2-B2;
                     x2:=ymin-Curv*B3-B3/2;
                     y2:=Y1;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3*Curv+B3/2);  Y1:=B1/2;
                     X2:=B3/2+clun*b2;  Y2:=Y1;
                  end;

                 with DisPezzo^[3] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=-(B3*Curv+(B3/2));   Y1:=-(B1/2)-B3*Curv;
                     X2:=0;                Y2:=pi/2;
                     R:=B3*Curv;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='P';          TLinea:=1;
                     X1:=-(B3*Curv+(B3/2));     Y1:=-(B1/2)-B3*Curv;
                     X2:=0;                Y2:=pi/2;
                     R:=B3*Curv+B3;
                     if B1*Rap < B2 then R1:=B3*Curv+(B1*(1-Rap))
                     else R1:=B3*Curv+B1-B2;
                  end;


                 X1A:=DisPezzo^[2].X1;
                 Y1A:=DisPezzo^[2].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=-DisPezzo^[2].Y1;

                 X3A:=b3/2+clun*b2;
                 Y3A:=DisPezzo^[2].Y2;
                 X4A:=x3a;
                 Y4A:=b1/2-b2;

                 X5A:=B3/2;
                 Y5A:=-(B1/2)-B3*Curv;

                 X6A:=-B3/2;
                 Y6A:=-(B1/2)-B3*Curv;
              end;

            3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2+clun*b2;
                     Y1:=-B1/2+B2;
                     x2:=ymin-Curv*B3-B3/2;
                     y2:=Y1;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3*Curv+B3/2);  Y1:=-B1/2;
                     X2:=B3/2+clun*b2;  Y2:=Y1;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=-(B3*Curv+(B3/2));     Y1:=(B1/2)+B3*Curv;
                     X2:=-pi/2;            Y2:=0;
                     R:=B3*Curv;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='P';          TLinea:=1;
                     X1:=-(B3*Curv+(B3/2));     Y1:=(B1/2)+B3*Curv;
                     X2:=-pi/2;            Y2:=0;
                     R1:=B3*Curv+B3;
                     if B1*Rap < B2 then R:=(B3*Curv+(B1*(1-Rap)))
                     else R:=B3*Curv+B1-B2;
                  end;


                 X1A:=DisPezzo^[2].X1;
                 Y1A:=-DisPezzo^[2].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;

                 X3A:=b3/2+clun*b2;
                 Y4A:=-b1/2;
                 X4A:=x3a;
                 Y3A:=-b1/2+b2;


                 X5A:=-B3/2;
                 Y5A:=(B1/2)+B3*Curv;
                 X6A:=B3/2;
                 Y6A:=(B1/2)+B3*Curv;
              end;

          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3*Curv+H3/2);       Y1:=B1/2;
                     X2:=H3*Curv+H3/2;          Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3*Curv+H3/2);       Y1:=-B1/2;
                     X2:=H3*Curv+H3/2;          Y2:=-B1/2;
                  end;

                 if Orient=2 then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H3/2;            Y1:=B1/2;
                         X2:=-H3/2;            Y2:=-B1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H3/2;             Y1:=B1/2;
                         X2:=H3/2;             Y2:=-B1/2;
                      end;

                  end;

                 X1A:=-(H3*Curv+H3/2);
                 Y1A:=B1/2;
                 X2A:=-(H3*Curv+H3/2);
                 Y2A:=-B1/2;
                 X3A:=H3*Curv+H3/2;
                 Y3A:=B1/2;
                 X4A:=H3*Curv+H3/2;
                 Y4A:=-B1/2;
                 X5A:=0;
                 Y5A:=B1/2;
                 X6A:=0;
                 Y6A:=-B1/2;
                 if Orient = 2 then Z3:=-(H1/2)-H3*Curv
                 else Z3:=(H1/2)+H3*Curv;
              end;


            5:begin
                 Alfa:=H1*Rap;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H3*Curv+H1/2;          Y1:=B1/2;
                     X2:=H1/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H3*Curv+H1/2;          Y1:=-B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2+Alfa;       Y1:=B1/2;
                     X2:=-H1/2+Alfa;       Y2:=-B1/2;
                  end;

                 if (-H1/2) > (DisPezzo^[3].X1-H2) then
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';             TLinea:=1;
                         X1:=DisPezzo^[3].X1-H2;   Y1:=B1/2;
                         X2:=X1;                  Y2:=-B1/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';        TLinea:=1;
                         X1:=DisPezzo^[4].X1; Y1:=B1/2;
                         X2:=-H1/2;          Y2:=B1/2;
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';        TLinea:=1;
                         X1:=DisPezzo^[4].X1; Y1:=-B1/2;
                         X2:=-H1/2;          Y2:=-B1/2;
                      end;
                   end
                 else
                  begin
                     if (-H1/2) <> (DisPezzo^[3].X1-H2) then
                      with DisPezzo^[4] do
                       begin
                          Entita:='L';             TLinea:=2;
                          X1:=DisPezzo^[3].X1-H2;   Y1:=B1/2;
                          X2:=X1;                  Y2:=-B1/2;
                       end;
                  end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=-H1/2-H2/2;
                 Y3A:=B1/2;
                 X4A:=X3A;
                 Y4A:=-B1/2;
                 X5A:=H3*Curv+H1/2;
                 Y5A:=B1/2;
                 X6A:=H3*Curv+H1/2;
                 Y6A:=-B1/2;
                 Alfa:=arccos((H1+(H3*Curv)-H2)/(H3*Curv+H3));
                 Z1:=(H3*Curv+H3/2);
                 Z2:=(H3*Curv+H3/2)-abs((H3*Curv+H3)*sin(Alfa))-H3*Costant^.C22;
              end;

            6:begin
                 Alfa:=H1*Rap;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H3*Curv+H1/2;          Y1:=B1/2;
                     X2:=-H1/2+Alfa;       Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H3*Curv+H1/2;          Y1:=-B1/2;
                     X2:=-H1/2+Alfa;       Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;

                 if (-H1/2) < (DisPezzo^[1].X2-H2) then
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';      TLinea:=1;
                         X1:=-H1/2;        Y1:=B1/2;
                         X2:=X1;           Y2:=-B1/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';            TLinea:=1;
                         X1:=DisPezzo^[1].X2-H2;  Y1:=B1/2;
                         X2:=-H1/2;              Y2:=B1/2;
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';        TLinea:=1;
                         X1:=DisPezzo^[5].X1; Y1:=-B1/2;
                         X2:=-H1/2;          Y2:=-B1/2;
                      end;
                   end
                 else
                  begin
                     if (-H1/2) <> (DisPezzo^[1].X2-H2) then
                      with DisPezzo^[4] do
                       begin
                          Entita:='L';          TLinea:=2;
                          X1:=-H1/2;            Y1:=B1/2;
                          X2:=X1;               Y2:=-B1/2;
                       end;
                  end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=-H1/2+H2/2;
                 Y3A:=B1/2;
                 X4A:=X3A;
                 Y4A:=-B1/2;
                 X5A:=H3*Curv+H1/2;
                 Y5A:=B1/2;
                 X6A:=H3*Curv+H1/2;
                 Y6A:=-B1/2;
                 Alfa:=arccos((H1+(H3*Curv)-H2)/(H3*Curv+H3));
                 Z1:=-(H3*Curv+H3/2);
                 Z2:=-(H3*Curv+H3/2)+abs((H3*Curv+H3)*sin(Alfa))+H3*Costant^.C22;
              end;

       end;
 end;


procedure D_3736;
  Var i:integer;
      angol,rin,rfin,rcor:real;
      yarc:real;
      xmin,xmin1:real;
      Ymin,ymin1:real;
      xcor,X:real;
      Alfa1:real;
      Clun,Pin:real;


 begin
    ymin:=0;
    ymin1:=0;
    Clun:=0.2*Costant^.C61;
    X:=(B1-(B1*(1-Rap)+B1*(1-Rap1)))/2;
    yarc:=0;
    if B2/2 > X then
    BEGIN
    Rin:=((B1*Curv)-B3/2+B1*(1-Rap));
    xmin:=abs(B1*curv-B3/2+B1*(1-Rap)+X-B2/2-Rin);
    Ymin:=0;
    Rfin:=B1*Curv+B3/2;

    for i:=1 to 20 do
      begin
      Rcor:=Rfin-1/2*(Rfin-Rin)*(1+Cos(i*Pi/20));
      if i<>20 then
        begin
        if Rcor >Rin/Cos(i*pi/40) then Rcor:=Rin/Cos(i*pi/40);
        end;
      Xcor:=abs(B1*curv-B3/2+B1*(1-Rap)+X-B2/2-(Rcor*Cos(i*pi/40)));
      if xcor<=Xmin then
        begin
        Xmin:=Xcor;
        Ymin:=Rcor*sin(i*pi/40);
        end;
      end;

    yarc:=0;
    Rin:=(B1*Curv)-B4/2+B1*(1-Rap1);
    xmin1:=abs(B1*curv-B4/2+B1*(1-Rap1)+X-B2/2-Rin);
    Ymin1:=0;
    Rfin:=B1*Curv+B4/2;

    for i:=1 to 20 do
      begin
      Rcor:=Rfin-1/2*(Rfin-Rin)*(1+Cos(i*Pi/20));
      if i<>20 then
        begin
        if Rcor >Rin/Cos(i*pi/40) then Rcor:=Rin/Cos(i*pi/40);
        end;
      Xcor:=abs(B1*curv-B4/2+B1*(1-Rap1)+X-B2/2-(Rcor*Cos(i*pi/40)));
      if xcor<=Xmin1 then
        begin
        Xmin1:=Xcor;
        Ymin1:=Rcor*sin(i*pi/40);
        end;
      end;
    END;

    case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='A';             TLinea:=1;
                     X1:=-(B1*Curv);          Y1:=-(B1*Curv)-(B1/2-B3/2);
                     X2:=0;                   Y2:=pi/2;
                     R:=((B1*Curv)-B3/2);
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='P';              TLinea:=1;
                     X1:=-(B1*Curv);           Y1:=-(B1*Curv)-(B1/2-B3/2);
                     X2:=0;                    Y2:=pi/2;
                     R:=((B1*Curv)+B3/2);
                     if B2/2 > X then  R1:=(B1*Curv)-B3/2+B1*(1-Rap)
                     else R1:=((B1*Curv)-B3/2+B1*(1-Rap)+X-B2/2)
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';              TLinea:=1;
                     X1:=-(B1*Curv);           Y1:=(B1*Curv)+(B1/2-B4/2);
                     X2:=-pi/2;                Y2:=0;
                     R:=((B1*Curv)-B4/2);
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='P';                         TLinea:=1;
                     X1:=-(B1*Curv);                      Y1:=(B1*Curv)+(B1/2-B4/2);
                     X2:=-pi/2;                           Y2:=0;
                     R1:=((B1*Curv)+B4/2);
                     if B2/2 > X  then  R:=(B1*Curv)-B4/2+B1*(1-Rap1)
                     else R:=(B1*Curv)-B4/2+B1*(1-Rap1)+X-B2/2

                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     if B3>B4 then X1:=B3/2+clun*B2
                     else X1:=B4/2+clun*B2;
                     Y1:=-B1/2+B1*(1-Rap)+X-B2/2;
                     x2:=ymin-Curv*B1;
                     y2:=Y1;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     if B3>B4 then X1:=B3/2+clun*B2
                     else X1:=B4/2+clun*B2;
                     Y1:=DisPezzo^[5].Y1+B2;
                     x2:=ymin1-Curv*B1;
                     y2:=Y1;
                  end;


                 X1A:=-B1*Curv;
                 Y1A:=B1/2;
                 X2A:=-B1*Curv;
                 Y2A:=-B1/2;

                 X3A:=DisPezzo^[5].X1;
                 Y3A:=-B1/2+B1*(1-Rap)+X-B2/2+B2;
                 X4A:=X3A;
                 Y4A:=-B1/2+B1*(1-Rap)+X-B2/2;

                 X5A:=B3/2;
                 Y5A:=DisPezzo^[1].Y1;

                 X6A:=-B3/2;
                 Y6A:=DisPezzo^[1].Y1;

                 X7A:=-B4/2;
                 Y7A:=DisPezzo^[3].Y1;

                 X8A:=B4/2;
                 Y8A:=DisPezzo^[3].Y1;

              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     if H3>H4 then X1:=H3/2+clun*H2
                     else X1:=H4/2+clun*H2;
                     Y1:=B1/2;
                     X2:=-Curv*H1;         Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=-B1/2;
                  end;

                 if H3<>H4 then
                  begin
                     if Orient=2 then
                      begin
                         with DisPezzo^[3] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H3/2;            Y1:=B1/2;
                             X2:=-H3/2;            Y2:=-B1/2;
                          end;
                         with DisPezzo^[4] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=H3/2;             Y1:=B1/2;
                             X2:=H3/2;             Y2:=-B1/2;
                          end;
                      end
                     else
                      begin
                         with DisPezzo^[3] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H4/2;            Y1:=B1/2;
                             X2:=-H4/2;            Y2:=-B1/2;
                          end;
                         with DisPezzo^[4] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=H4/2;             Y1:=B1/2;
                             X2:=H4/2;             Y2:=-B1/2;
                          end;
                      end
                  end;

                 X1A:=-H1*Curv;
                 Y1A:=B1/2;
                 X2A:=-H1*Curv;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X1;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X1;
                 Y4A:=-B1/2;
                 X5A:=0;
                 Y5A:=B1/2;
                 X6A:=0;
                 Y6A:=-B1/2;
                 X7A:=0;
                 Y7A:=B1/2;
                 X8A:=0;
                 Y8A:=-B1/2;
                 if Orient = 2 then
                  begin
                     Z3:=-(B1*Curv)-(B1/2-B3/2);
                     Z4:=(B1*Curv)+(B1/2-B4/2);
                  end
                 else
                  begin
                     Z3:=(B1*Curv)+(B1/2-B4/2);
                     Z4:=-(B1*Curv)-(B1/2-B4/2);
                  end;
              end;


          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H1*Curv)-(H1/2-H2/2);    Y1:=-B1/2;
                     X2:=(H1*Curv)+(H1/2-H3/2);     Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H1*Curv)-(H1/2-H2/2);    Y1:=B1/2;
                     X2:=(H1*Curv)+(H1/2-H3/2);     Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';             TLinea:=2;
                     X1:=H1/2-H1*Rap1;        Y1:=B1/2;
		     X2:=H1/2-H1*Rap1;        Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';             TLinea:=2;
                     X1:=-H1/2+H1*Rap;    Y1:=B1/2;
		     X2:=-H1/2+H1*Rap;    Y2:=-B1/2;
                  end;
                 if Orient=6 then
                  begin
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H1/2;             Y1:=B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                     end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                     end;
                  end
                 else
                  begin
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H2/2;             Y1:=B1/2;
                         X2:=H2/2;             Y2:=-B1/2;
                     end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H2/2;            Y1:=B1/2;
                         X2:=-H2/2;            Y2:=-B1/2;
                     end;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;
                 X5A:=DisPezzo^[1].X2;
                 Y5A:=B1/2;
                 X6A:=DisPezzo^[1].X2;
                 Y6A:=-B1/2;
                 X7A:=DisPezzo^[1].X1;
                 Y7A:=-B1/2;
                 X8A:=DisPezzo^[1].X1;
                 Y8A:=B1/2;
                 if Orient = 5 then
                  begin
                     Z1:=Curv*H1;
                     if H3>H4 then Z2:=-(H3/2+clun*H2)
                     else Z2:=-(H4/2+clun*H2);
                  end
                 else
                  begin
                     Z1:=-Curv*H1;
                     if H3>H4 then Z2:=H3/2+clun*H2
                     else Z2:=H4/2+clun*H2;
                  end;
              end;
       end;
 end;


end.

(*

procedure D_3736;
  Var i:integer;
      angol,rin,rfin,rcor:real;
      yarc:real;
      xmin,xmin1:real;
      Ymin,ymin1:real;
      xcor:real;
      Alfa1:real;
      Clun:real;


 begin
    Clun:=0.2*Costant^.C55;

    yarc:=0;
    Rin:=((B1*Curv)-B3/2+B1*(1-Rap));
    xmin:=abs(B1*curv-B3/2+(b1-B2)/2-Rin);
    Ymin:=0;
    Rfin:=B1*Curv+B3/2;

    for i:=1 to 20 do
      begin
      Rcor:=Rfin-1/2*(Rfin-Rin)*(1+Cos(i*Pi/20));
      if i<>20 then
        begin
        if Rcor >Rin/Cos(i*pi/40) then Rcor:=Rin/Cos(i*pi/40);
        end;
      Xcor:=abs(B1*curv-B3/2+(b1-B2)/2-(Rcor*Cos(i*pi/40)));
      if xcor<=Xmin then
        begin
        Xmin:=Xcor;
        Ymin:=Rcor*sin(i*pi/40);
        end;
      end;

    yarc:=0;
    Rin:=((B1*Curv)-B4/2+B1*(1-Rap1));
    xmin1:=abs(B1*curv-B4/2+(b1-B2)/2-Rin);
    Ymin1:=0;
    Rfin:=B1*Curv+B4/2;

    for i:=1 to 20 do
      begin
      Rcor:=Rfin-1/2*(Rfin-Rin)*(1+Cos(i*Pi/20));
      if i<>20 then
        begin
        if Rcor >Rin/Cos(i*pi/40) then Rcor:=Rin/Cos(i*pi/40);
        end;
      Xcor:=abs(B1*curv-B4/2+(b1-B2)/2-(Rcor*Cos(i*pi/40)));
      if xcor<=Xmin1 then
        begin
        Xmin1:=Xcor;
        Ymin1:=Rcor*sin(i*pi/40);
        end;
      end;



    case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='A';             TLinea:=1;
                     X1:=-(B1*Curv);          Y1:=-(B1*Curv)-(B1/2-B3/2);
                     X2:=0;                   Y2:=pi/2;
                     R:=((B1*Curv)-B3/2);
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='P';              TLinea:=1;
                     X1:=-(B1*Curv);           Y1:=-(B1*Curv)-(B1/2-B3/2);
                     X2:=0;                    Y2:=pi/2;
                     R:=((B1*Curv)+B3/2);      R1:=((B1*Curv)-B3/2+B1*(1-Rap));
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';              TLinea:=1;
                     X1:=-(B1*Curv);           Y1:=(B1*Curv)+(B1/2-B4/2);
                     X2:=-pi/2;                Y2:=0;
                     R:=((B1*Curv)-B4/2);
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='P';                         TLinea:=1;
                     X1:=-(B1*Curv);                      Y1:=(B1*Curv)+(B1/2-B4/2);
                     X2:=-pi/2;                           Y2:=0;
                     R:=((B1*Curv)-B4/2+B1*(1-Rap1));         R1:=((B1*Curv)+B4/2);
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     if B3>B4 then X1:=B3/2+clun*B2
                     else X1:=B4/2+clun*B2;
                     Y1:=-B2/2;
                     x2:=ymin-Curv*B1;
                     y2:=Y1;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     if B3>B4 then X1:=B3/2+clun*B2
                     else X1:=B4/2+clun*B2;
                     Y1:=B2/2;
                     x2:=ymin1-Curv*B1;
                     y2:=Y1;
                  end;


                 X1A:=-B1*Curv;
                 Y1A:=B1/2;
                 X2A:=-B1*Curv;
                 Y2A:=-B1/2;

                 X3A:=DisPezzo^[5].X1;
                 Y3A:=B2/2;
                 X4A:=X3A;
                 Y4A:=-B2/2;

                 X5A:=B3/2;
                 Y5A:=DisPezzo^[1].Y1;

                 X6A:=-B3/2;
                 Y6A:=DisPezzo^[1].Y1;

                 X7A:=-B4/2;
                 Y7A:=DisPezzo^[3].Y1;

                 X8A:=B4/2;
                 Y8A:=DisPezzo^[3].Y1;

              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     if H3>H4 then X1:=H3/2+clun*H2
                     else X1:=H4/2+clun*H2;
                     Y1:=B1/2;
                     X2:=-Curv*H1;         Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=-B1/2;
                  end;

                 if H3<>H4 then
                  begin
                     if Orient=2 then
                      begin
                         with DisPezzo^[3] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H3/2;            Y1:=B1/2;
                             X2:=-H3/2;            Y2:=-B1/2;
                          end;
                         with DisPezzo^[4] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=H3/2;             Y1:=B1/2;
                             X2:=H3/2;             Y2:=-B1/2;
                          end;
                      end
                     else
                      begin
                         with DisPezzo^[3] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H4/2;            Y1:=B1/2;
                             X2:=-H4/2;            Y2:=-B1/2;
                          end;
                         with DisPezzo^[4] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=H4/2;             Y1:=B1/2;
                             X2:=H4/2;             Y2:=-B1/2;
                          end;
                      end
                  end;

                 X1A:=-H1*Curv;
                 Y1A:=B1/2;
                 X2A:=-H1*Curv;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X1;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X1;
                 Y4A:=-B1/2;
              end;


          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H1*Curv)-(H1/2-H2/2);    Y1:=-B1/2;
                     X2:=(H1*Curv)+(H1/2-H3/2);     Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H1*Curv)-(H1/2-H2/2);    Y1:=B1/2;
                     X2:=(H1*Curv)+(H1/2-H3/2);     Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';
                     if Orient=5 then TLinea:=2
                     else TLinea:=1;
                     X1:=B1*(1-Rap);        Y1:=B1/2;
		     X2:=B1*(1-Rap);        Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';
                     if Orient=5 then TLinea:=2
                     else TLinea:=1;
                     X1:=-B1*(1-Rap1);    Y1:=B1/2;
		     X2:=-B1*(1-Rap1);    Y2:=-B1/2;
                  end;
                 if Orient=6 then
                  begin
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H1/2;             Y1:=B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                     end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                     end;
                  end
                 else
                  begin
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H2/2;             Y1:=B1/2;
                         X2:=H2/2;             Y2:=-B1/2;
                     end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H2/2;            Y1:=B1/2;
                         X2:=-H2/2;            Y2:=-B1/2;
                     end;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-B1/2;
                 X5A:=DisPezzo^[1].X1;
                 Y5A:=-B1/2;
                 X6A:=DisPezzo^[1].X1;
                 Y6A:=B1/2;
              end;



       end;
 end;

*)