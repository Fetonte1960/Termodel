{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit U_3733;

interface

Procedure D_3733;     { ho invertito i punti di uscita 29.6.91}
Procedure D_3734R;    { ho invertito i punti di uscita 29.6.91}
Procedure D_3734C;    { ho invertito i punti di uscita 29.6.91}
Procedure D_3735R;
Procedure D_3735C;


implementation

uses crt,dos,definiz,U_VARPEZZI,interf3d;

procedure D_3733;
var
    Base,LatoA,LatoB,Beta,Alfa:real;
 begin
curva3d1(pi/2,orient,1,(curv*b1-b2/2),b1*rap,b2,h1,-b1/2*(1-rap),0,0);
curva3d1(pi/2,orient,3,(curv*b1-b3/2),b1*(1-rap),b1,h1,b1/2*(-rap),0,0);

    case orient of
          1,3:begin
                if CodPezzo='3733' then
                BEGIN
                 Base:=(B1*Curv)*2+(B1-B2/2-B3/2);
                 LatoA:=B1*Curv+B2/2;
                 LatoB:=B1*Curv+B3/2;
                 Alfa:=ABS(arccos((LatoA*LatoA-Base*Base-LatoB*LatoB)/(-2*LatoB*Base)));
                 Beta:=ABS(arccos((LatoB*LatoB-Base*Base-LatoA*LatoA)/(-2*LatoA*Base)));
                 with DisPezzo^[1] do
                  begin
                     Entita:='A';             TLinea:=1;
                     X1:=-(B1*Curv);           Y1:=-(B1*Curv)-(B1/2-B2/2);
                     X2:=0;                   Y2:=pi/2;
                     R:=((B1*Curv)-B2/2);
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='A';             TLinea:=1;
                     X1:=-(B1*Curv);           Y1:=-(B1*Curv)-(B1/2-B2/2);
                     X2:=0;                   Y2:=pi/2-BETA;
                     R:=((B1*Curv)+B2/2);
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='A';             TLinea:=1;
                     X1:=-(B1*Curv);           Y1:=(B1*Curv)+(B1/2-B3/2);
                     X2:=-pi/2;               Y2:=0;
                     R:=((B1*Curv)-B3/2);
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='A';             TLinea:=1;
                     X1:=-(B1*Curv);           Y1:=(B1*Curv)+(B1/2-B3/2);
                     X2:=-pi/2+Alfa;          Y2:=0;
                     R:=((B1*Curv)+B3/2);
                  end;

                END
                else
                 begin
                    with DisPezzo^[1] do
                     begin
                        Entita:='A';             TLinea:=1;
                        X1:=-(B1*Curv);           Y1:=-(B1*Curv)-(B1/2-B2/2);
                        X2:=0;                   Y2:=pi/2;
                        R:=((B1*Curv)-B2/2);
                     end;
                    with DisPezzo^[2] do
                     begin
                        Entita:='P';              TLinea:=1;
                        X1:=-(B1*Curv);            Y1:=-(B1*Curv)-(B1/2-B2/2);
                        X2:=0;                    Y2:=pi/2;
                        R:=((B1*Curv)+B2/2);      R1:=((B1*Curv)-B2/2+B1*Rap);
                     end;
                    with DisPezzo^[3] do
                     begin
                        Entita:='A';              TLinea:=1;
                        X1:=-(B1*Curv);            Y1:=(B1*Curv)+(B1/2-B3/2);
                        X2:=-pi/2;                Y2:=0;
                        R:=((B1*Curv)-B3/2);
                     end;
                    with DisPezzo^[4] do
                     begin
                        Entita:='P';                         TLinea:=1;
                        X1:=-(B1*Curv);                       Y1:=(B1*Curv)+(B1/2-B3/2);
                        X2:=-pi/2;                           Y2:=0;
                        R:=((B1*Curv)-B3/2+B1*(1-Rap));      R1:=((B1*Curv)+B3/2);
                     end;
                 end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=B2/2;
                 Y3A:=-(B1*Curv)-(B1/2-B2/2);
                 X4A:=-B2/2;
                 Y4A:=-(B1*Curv)-(B1/2-B2/2);
                 X5A:=-B3/2;
                 Y5A:=(B1*Curv)+(B1/2-B3/2);
                 X6A:=B3/2;
                 Y6A:=(B1*Curv)+(B1/2-B3/2);

              end;

          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H1*Curv);        Y1:=-B1/2;
                     if H2>H3 then X2:=H2/2
		     else X2:=H3/2;        Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H1*Curv);        Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=B1/2;
                  end;
                 if H2<>H3 then
                  begin
                     if Orient=4 then
                      begin
                         Base:=H2;  H2:=H3;   H3:=Base;
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';      TLinea:=2;
                         X1:=-H2/2;        Y1:=B1/2;
                         X2:=-H2/2;        Y2:=-B1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';
                         if H2<H3 then TLinea:=2
                         else TLinea:=1;
                         X1:=H2/2;        Y1:=B1/2;
                         X2:=H2/2;        Y2:=-B1/2;
         	      end;

(*                    j:=2; i:=5;
		     Spicchio(B1,H2,i,j);*)
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;
                 X5A:=0;
                 Y5A:=B1/2;
                 X6A:=0;
                 Y6A:=-B1/2;
                 if Orient = 2 then
                  begin
                     Z2:=-(H1*Curv)-(H1/2-H2/2);
                     Z3:=H1*Curv+(H1/2-H2/2);
                  end
                 else
                  begin
                     Z2:=H1*Curv+(H1/2-H2/2);
                     Z3:=-(H1*Curv)-(H1/2-H2/2);
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
                     Entita:='L';
                     if Orient=5 then TLinea:=2
                     else TLinea:=1;
                     if CodPezzo='3733' then
                      begin
                         X1:=0;
                         X2:=0;
                      end
                     else
                      begin
                         X1:=-H1/2+H1*Rap;
                         X2:=-H1/2+H1*Rap;
                      end;
                     Y1:=B1/2;          Y2:=-B1/2;
                  end;
                 if Orient=6 then
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H1/2;             Y1:=B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                     end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                     end;

                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X1;
                 Y3A:=-B1/2;
                 X4A:=DisPezzo^[1].X1;
                 Y4A:=B1/2;
                 X5A:=DisPezzo^[1].X2;
                 Y5A:=B1/2;
                 X6A:=DisPezzo^[1].X2;
                 Y6A:=-B1/2;
                 if Orient = 5 then Z1:=H1*Curv
                 else Z1:=-H1*Curv;
              end;
    end;
 end;


Procedure D_3734R;
var AX,AY,DX,DY,DX1,DY1,X,B:real;
    Int:integer;
 begin
    X:=0.5+Costant^.C21;
    if Ang<61 then X:=Costant^.C55;
    if Ang<46 then X:=Costant^.C56;
    if Ang<31 then X:=Costant^.C57;
    Ang:=Ang/180*pi;
    AX:=B1*X*cos(Ang);
    AY:=B1*X*sin(Ang);
    DX:=(B2/2)*cos((pi/2)-Ang);
    DY:=(B2/2)*sin((pi/2)-Ang);
    DX1:=(B3/2)*cos((pi/2)-Ang);
    DY1:=(B3/2)*sin((pi/2)-Ang);

    case orient of
          1,3:begin
                 if B2>B3 then B:=B2
                  else B:=B3;
                 IF ANG <> pi/2 THEN
                  BEGIN
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=-B/2*Costant^.C58; Y1:=B1/2;
                         X2:=(AX+DX);           Y2:=B1/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX-DX;
                         Y1:=-AY-DY;
                         Inters(X2,Y2,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,-DX,-DisPezzo^[1].Y1,
                         -DisPezzo^[1].Y2,Y1,-DY);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX+DX;            Y1:=-AY+DY;
                         Inters(X2,Y2,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,DX,-DisPezzo^[1].Y1,
                         -DisPezzo^[1].Y2,Y1,DY);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                         Inters(X2,Y2,Int,X1,DisPezzo^[1].X2,DisPezzo^[2].X1,DisPezzo^[2].X2,
                                Y1,-DisPezzo^[1].Y2,DisPezzo^[2].Y1,DisPezzo^[2].Y2);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX-DX1;           Y1:=AY+DY1;
                         Inters(X2,Y2,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,-DX1,-DisPezzo^[1].Y1,
                         -DisPezzo^[1].Y2,Y1,DY1);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX+DX1;           Y1:=AY-DY1;
                         Inters(X2,Y2,Int,DisPezzo^[3].X1,DisPezzo^[3].X2,X1,DX1,DisPezzo^[3].Y1,
                         DisPezzo^[3].Y2,Y1,-DY1);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                         Inters(X2,Y2,Int,X1,DisPezzo^[1].X2,DisPezzo^[4].X1,DisPezzo^[4].X2,
                                Y1,-DisPezzo^[1].Y2,DisPezzo^[4].Y1,DisPezzo^[4].Y2);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X2:=DisPezzo^[5].X2;
                         Y2:=DisPezzo^[5].Y2;
                      end;

                     X1A:=DisPezzo^[1].X1;
                     Y1A:=-DisPezzo^[1].Y1;
                     X2A:=DisPezzo^[1].X1;
                     Y2A:=DisPezzo^[1].Y1;
                     X3A:=DisPezzo^[3].X1;
                     Y3A:=DisPezzo^[3].Y1;
                     X4A:=DisPezzo^[2].X1;
                     Y4A:=DisPezzo^[2].Y1;
                     X5A:=DisPezzo^[4].X1;
                     Y5A:=DisPezzo^[4].Y1;
                     X6A:=DisPezzo^[5].X1;
                     Y6A:=DisPezzo^[5].Y1;

                  END
                 ELSE
                  BEGIN
                     if B2 > B3 then AX:=B2/2
                      else AX:=B3/2;
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=-AX-B/2*Costant^.C58;   Y1:=B1/2;
                         X2:=-AX;               Y2:=B1/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-AX-B/2*Costant^.C58;  Y1:=-B1/2;
                         X2:=-AX;              Y2:=-B1/2;
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX;               Y1:=B1/2;
                         X2:=AX;               Y2:=-B1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-AX;              Y1:=B1/2;
                         X2:=-B3/2;            Y2:=Y1+AX*Costant^.C59;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX;               Y1:=B1/2;
                         X2:=B3/2;             Y2:=Y1+AX*Costant^.C59;
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-AX;              Y1:=-B1/2;
                         X2:=-B2/2;            Y2:=Y1-AX*Costant^.C59;
                      end;
                     with DisPezzo^[7] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX;               Y1:=-B1/2;
                         X2:=B2/2;             Y2:=Y1-AX*Costant^.C59;
                      end;

                     X1A:=DisPezzo^[1].X1;
                     Y1A:=DisPezzo^[1].Y1;
                     X2A:=DisPezzo^[1].X1;
                     Y2A:=-DisPezzo^[1].Y1;
                     X3A:=DisPezzo^[7].X2;
                     Y3A:=DisPezzo^[7].Y2;
                     X4A:=DisPezzo^[6].X2;
                     Y4A:=DisPezzo^[6].Y2;
                     X5A:=DisPezzo^[4].X2;
                     Y5A:=DisPezzo^[4].Y2;
                     X6A:=DisPezzo^[5].X2;
                     Y6A:=DisPezzo^[5].Y2;

                  END;



              end;

          2,4:begin
                 if H2>H3 then B:=H2
                  else B:=H3;
                 if Ang <> pi/2 then
                  begin
                     AX:=H1*X*cos(Ang);
                     DX:=(H2/2)*cos((pi/2)-Ang);
                     DX1:=(H3/2)*cos((pi/2)-Ang);
                  end
                 else
                  begin
                     if H2 > H3 then AX:=H2/2
                      else AX:=H3/2;
                     DX:=B/2*Costant^.C59;
                     DX1:=DX;
                  end;

                 if Ang<>pi/2 then
                  begin
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=-B/2*Costant^.C58; Y1:=B1/2;
                         if H2 > H3 then X2:=AX+DX
                         else X2:=AX+DX1;
                         Y2:=B1/2;
                      end;
                  end
                 else
                  begin
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';              TLinea:=1;
                         X1:=-B/2-B/2*Costant^.C58; Y1:=B1/2;
                         X2:=AX+DX;                Y2:=B1/2;
                      end;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                     X2:=DisPezzo^[1].X2;   Y2:=Y1;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';
                     if (Orient = 2) or (H2=H3)then TLinea:=1
                      else TLinea:=2;
                     if Ang <> pi/2 then X1:=-DX1
                     else X1:=-AX;
                                       Y1:=B1/2;
                     X2:=X1;           Y2:=-B1/2;
                  end;
                 if (H2<>H3) and (Ang <> pi/2) then
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';
                         if (Orient = 2) then TLinea:=2
                          else TLinea:=1;
                         X1:=-DX;            Y1:=B1/2;
                         X2:=-DX;            Y2:=-B1/2;
                      end;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-B1/2;
                 X5A:=DisPezzo^[1].X2;
                 Y5A:=B1/2;
                 X6A:=DisPezzo^[1].X2;
                 Y6A:=-B1/2;
              end;
          5,6:begin
                 if Ang <> pi/2 then
                  begin
                     AX:=H1*X*cos(Ang);
                     DX:=(H2/2)*cos((pi/2)-Ang);
                     DX1:=(H3/2)*cos((pi/2)-Ang);
                  end
                 else
                  begin
                     if H2 > H3 then AX:=H2/2
                      else AX:=H3/2;
                     DX:=AX*Costant^.C59;
                     DX1:=DX;
                  end;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-AX-DX1;          Y1:=B1/2;
                     X2:=AX+DX;            Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-AX-DX1;          Y1:=-B1/2;
                     X2:=AX+DX;            Y2:=-B1/2;
                  end;
                 if Orient = 6 then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H1/2;             Y1:=B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                      end;
                  end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X5A:=DisPezzo^[1].X2;
                 Y5A:=B1/2;
                 X6A:=DisPezzo^[1].X2;
                 Y6A:=-B1/2;
                 X3A:=DisPezzo^[1].X1;
                 Y3A:=-B1/2;
                 X4A:=DisPezzo^[1].X1;
                 Y4A:=B1/2;

              end;
    end;
 end;

Procedure D_3734C;
var AX,AY,DX,DY,DX1,DY1,X,D:real;
    Int:integer;
 begin
    X:=0.5+Costant^.C21;
    if Ang<61 then X:=Costant^.C55;
    if Ang<46 then X:=Costant^.C56;
    if Ang<31 then X:=Costant^.C57;
    Ang:=Ang/180*pi;
    AX:=D1*X*cos(Ang);
    AY:=D1*X*sin(Ang);
    DX:=(D2/2)*cos((pi/2)-Ang);
    DY:=(D2/2)*sin((pi/2)-Ang);
    DX1:=(D3/2)*cos((pi/2)-Ang);
    DY1:=(D3/2)*sin((pi/2)-Ang);
    if D2>D3 then D:=D2
     else D:=D3;

    case orient of
          1,3:begin

                 IF ANG <> pi/2 THEN
                  BEGIN
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=-D/2*Costant^.C58; Y1:=D1/2;
                         X2:=(AX+DX);           Y2:=D1/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX-DX;
                         Y1:=-AY-DY;
                         Inters(X2,Y2,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,-DX,-DisPezzo^[1].Y1,
                         -DisPezzo^[1].Y2,Y1,-DY);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX+DX;            Y1:=-AY+DY;
                         Inters(X2,Y2,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,DX,-DisPezzo^[1].Y1,
                         -DisPezzo^[1].Y2,Y1,DY);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                         Inters(X2,Y2,Int,X1,DisPezzo^[1].X2,DisPezzo^[2].X1,DisPezzo^[2].X2,
                                Y1,-DisPezzo^[1].Y2,DisPezzo^[2].Y1,DisPezzo^[2].Y2);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX-DX1;           Y1:=AY+DY1;
                         Inters(X2,Y2,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,-DX1,-DisPezzo^[1].Y1,
                         -DisPezzo^[1].Y2,Y1,DY1);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX+DX1;           Y1:=AY-DY1;
                         Inters(X2,Y2,Int,DisPezzo^[3].X1,DisPezzo^[3].X2,X1,DX1,DisPezzo^[3].Y1,
                         DisPezzo^[3].Y2,Y1,-DY1);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                         Inters(X2,Y2,Int,X1,DisPezzo^[1].X2,DisPezzo^[4].X1,DisPezzo^[4].X2,
                                Y1,-DisPezzo^[1].Y2,DisPezzo^[4].Y1,DisPezzo^[4].Y2);
                         if Int<>1 then write(Chr(7));
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X2:=DisPezzo^[5].X2;
                         Y2:=DisPezzo^[5].Y2;
                      end;

                     X1A:=DisPezzo^[1].X1;
                     Y1A:=-DisPezzo^[1].Y1;
                     X2A:=DisPezzo^[1].X1;
                     Y2A:=DisPezzo^[1].Y1;
                     X3A:=DisPezzo^[3].X1;
                     Y3A:=DisPezzo^[3].Y1;
                     X4A:=DisPezzo^[2].X1;
                     Y4A:=DisPezzo^[2].Y1;
                     X5A:=DisPezzo^[4].X1;
                     Y5A:=DisPezzo^[4].Y1;
                     X6A:=DisPezzo^[5].X1;
                     Y6A:=DisPezzo^[5].Y1;

                  END
                 ELSE
                  BEGIN
                     if D2 > D3 then AX:=D2/2
                      else AX:=D3/2;
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=-AX-D/2*Costant^.C58;   Y1:=D1/2;
                         X2:=-AX;               Y2:=D1/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-AX-D/2*Costant^.C58;  Y1:=-D1/2;
                         X2:=-AX;              Y2:=-D1/2;
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX;               Y1:=D1/2;
                         X2:=AX;               Y2:=-D1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-AX;              Y1:=D1/2;
                         X2:=-D3/2;            Y2:=Y1+AX*Costant^.C59;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX;               Y1:=D1/2;
                         X2:=D3/2;             Y2:=Y1+AX*Costant^.C59;
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-AX;              Y1:=-D1/2;
                         X2:=-D2/2;            Y2:=Y1-AX*Costant^.C59;
                      end;
                     with DisPezzo^[7] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=AX;               Y1:=-D1/2;
                         X2:=D2/2;             Y2:=Y1-AX*Costant^.C59;
                      end;
                     with DisPezzo^[8] do
                      begin
                         Entita:='P';          TLinea:=1;
                         X1:=-AX;              Y1:=0;
                         X2:=-pi/2;            Y2:=0;
                         R:=D1/2;              R1:=AX;
                      end;
                     with DisPezzo^[9] do
                      begin
                         Entita:='P';          TLinea:=1;
                         X1:=-AX;              Y1:=0;
                         X2:=0;                Y2:=pi/2;
                         R:=AX;                R1:=D1/2;
                      end;

                     X1A:=DisPezzo^[1].X1;
                     Y1A:=DisPezzo^[1].Y1;
                     X2A:=DisPezzo^[1].X1;
                     Y2A:=-DisPezzo^[1].Y1;
                     X3A:=DisPezzo^[7].X2;
                     Y3A:=DisPezzo^[7].Y2;
                     X4A:=DisPezzo^[6].X2;
                     Y4A:=DisPezzo^[6].Y2;
                     X5A:=DisPezzo^[4].X2;
                     Y5A:=DisPezzo^[4].Y2;
                     X6A:=DisPezzo^[5].X2;
                     Y6A:=DisPezzo^[5].Y2;

                  END;



              end;
          2,4:begin

                 if Ang = pi/2 then
                  begin
                     AX:=D/2;
                     DX:=D/2*Costant^.C59;
                     DX1:=DX;
                  end;

                 if Ang<>pi/2 then
                  begin
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=-D/2*Costant^.C58;  Y1:=D1/2;
                         X2:=0;                 Y1:=D1/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=0;                 Y1:=D1/2;
                         if D2 > D3 then X2:=AX+DX
                         else X2:=AX+DX1;
                         Y1:=D/2;
                      end;

                  end
                 else
                  begin
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';              TLinea:=1;
                         X1:=-D/2-D/2*Costant^.C58; Y1:=D1/2;
                         X2:=0;                    Y2:=D1/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';              TLinea:=1;
                         X1:=0;                    Y1:=D1/2;
                         X2:=AX+DX;                Y1:=D/2;
                      end;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                     X2:=DisPezzo^[1].X2;   Y2:=Y1;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;   Y1:=-DisPezzo^[2].Y1;
                     X2:=DisPezzo^[2].X2;   Y2:=-DisPezzo^[2].Y2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=DisPezzo^[2].X1;   Y1:=D1/2;
                     X2:=DisPezzo^[2].X2;
                     if D2 > D3 then Y2:=D3/2
                     else Y2:=D2/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=DisPezzo^[2].X1;   Y1:=-D1/2;
                     X2:=DisPezzo^[2].X2;   Y2:=-DisPezzo^[5].Y2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';
                     if (Orient = 2) or (D2=D3)then TLinea:=1
                      else TLinea:=2;
                     if Ang <> pi/2 then X1:=-DX1
                     else X1:=-AX;
                                       Y1:=D1/2;
                     X2:=X1;           Y2:=-D1/2;
                  end;
                 if (D2<>D3) and (Ang <> pi/2) then
                  begin
                     with DisPezzo^[8] do
                      begin
                         Entita:='L';
                         if (Orient = 2) then TLinea:=2
                          else TLinea:=1;
                         X1:=-DX;            Y1:=D1/2;
                         X2:=-DX;            Y2:=-D1/2;
                      end;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[2].X2;
                 Y3A:=D2/2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=-D2/2;
                 X5A:=DisPezzo^[2].X2;
                 Y5A:=D3/2;
                 X6A:=DisPezzo^[2].X2;
                 Y6A:=-D3/2;
              end;
          5,6:begin
                 if Ang = pi/2 then
                  begin
                     AX:=D/2;
                     DX:=D/2*Costant^.C59;
                     DX1:=DX;
                  end;

                 if DX > DX1 then DX1:=DX;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-AX-DX1;          Y1:=D2/2;
                     X2:=0;                Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-AX-DX1;          Y1:=-D2/2;
                     X2:=0;                Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=AX+DX1;           Y1:=D3/2;
                     X2:=0;                Y2:=D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=AX+DX1;           Y1:=-D3/2;
                     X2:=0;                Y2:=-D1/2;
                  end;
                 if Orient = 6 then
                  with DisPezzo^[5] do
                   begin
                      Entita:='C';          TLinea:=2;
                      X1:=0;                Y1:=0;
                      R:=D1/2;
                   end;

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X5A:=DisPezzo^[3].X1;
                 Y5A:=D3/2;
                 X6A:=DisPezzo^[3].X1;
                 Y6A:=-D3/2;
                 X3A:=DisPezzo^[1].X1;
                 Y3A:=-D2/2;
                 X4A:=DisPezzo^[1].X1;
                 Y4A:=D2/2;
  { ho cambiato i punti di attacco delle uscite per pino 06 07 92 }

              end;
    end;
 end;



procedure D_3735R;
 begin
       case orient of
          1,3:begin

                 Ang:=pi/4;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3*Costant^.C1;              Y1:=-B1/2;
                     X2:=((B1/2)/tan(Ang))-((B3/2)/sin(Ang));
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=((B1/2)/tan(Ang))+((B3/2)/sin(Ang));
                     Y1:=-B1/2;
                     X2:=X1+(B3/2)*cos(ang)*Costant^.C20;
                     Y2:=-(B1/2)-abs((B3/2)*sin(Ang)*Costant^.C20);
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X2-B3*sin(Ang);
                     Y1:=DisPezzo^[2].Y2-B3*cos(Ang);
                     Y2:=-B1/2;
                     X2:=DisPezzo^[1].X2;
                  end;

                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;   Y1:=B1/2;
                     X2:=DisPezzo^[2].X1+B3*Costant^.C19;
                     Y2:=B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                     X2:=DisPezzo^[1].X2;
                     Y2:=-DisPezzo^[1].Y2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;
                     Y1:=-DisPezzo^[2].Y1;
                     X2:=DisPezzo^[2].X2;
                     Y2:=-DisPezzo^[2].Y2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X1;
                     Y1:=-DisPezzo^[3].Y1;
                     X2:=DisPezzo^[3].X2;
                     Y2:=-DisPezzo^[3].Y2;
                  end;

                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[4].X1;   Y1:=-DisPezzo^[4].Y1;
                     X2:=DisPezzo^[4].X2;
                     Y2:=-DisPezzo^[4].Y2;
                  end;

                 X1A:=-B3*Costant^.C1;
                 Y1A:=B1/2;
                 X2A:=-B3*Costant^.C1;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[4].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[4].X2;
                 Y4A:=-B1/2;
                 X5A:=DisPezzo^[2].X2;
                 Y5A:=DisPezzo^[2].Y2;
                 X6A:=DisPezzo^[3].X1;
                 Y6A:=DisPezzo^[3].Y1;
                 X7A:=DisPezzo^[3].X1;
                 Y7A:=-DisPezzo^[3].Y1;
                 X8A:=DisPezzo^[2].X2;
                 Y8A:=-DisPezzo^[2].Y2;

              end;
          2,4:begin
                 Ang:=pi/4;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=((H1/2)/tan(Ang))-((H3/2)/sin(Ang));
                     Y1:=B1/2;             X2:=X1;
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=((H1/2)/tan(Ang))+((H3/2)/sin(Ang));
                     Y1:=B1/2;
                     X2:=X1;               Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H3*Costant^.C1;          Y1:=B1/2;
                     Y2:=B1/2;
                     X2:=((H1/2)/tan(Ang))+((H3/2)/sin(Ang))+H3*Costant^.C19;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X1;   Y1:=-B1/2;
                     X2:=DisPezzo^[3].X2;   Y2:=-B1/2;
                  end;


                 X1A:=DisPezzo^[3].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[3].X1;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[3].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[3].X2;
                 Y4A:=-B1/2;
                 X5A:=DisPezzo^[2].X1+(H3/2)*cos(ang)*Costant^.C20-H3*sin(Ang);
                 Y5A:=B1/2;
                 X6A:=X5A;
                 Y6A:=-B1/2;
                 X7A:=X5A;
                 Y7A:=B1/2;
                 X8A:=X5A;
                 Y8A:=-B1/2;

              end;
           5,6:begin

                 Ang:=pi/4;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H1/2)-abs((H3/2)*sin(Ang)*Costant^.C20)-H3*cos(Ang);
                     Y1:=B1/2;
                     X2:=-X1;              Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=-B1/2;
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
                 Y7A:=B1/2;
                 X8A:=DisPezzo^[1].X1;
                 Y8A:=-B1/2;

              end;
       end;
    end;

procedure D_3735C;
 begin
       case orient of
          1,3:begin

                 Ang:=pi/4;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3*Costant^.C1;              Y1:=-D1/2;
                     X2:=((D1/2)/tan(Ang))-((D3/2)/sin(Ang));
                     Y2:=-D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang));
                     Y1:=-D1/2;
                     X2:=X1+(D3/2)*cos(ang)*Costant^.C20;
                     Y2:=-(D1/2)-abs((D3/2)*sin(Ang)*Costant^.C20);
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X2-D3*sin(Ang);
                     Y1:=DisPezzo^[2].Y2-D3*cos(Ang);
                     Y2:=-D1/2;
                     X2:=DisPezzo^[1].X2;
                  end;

                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;   Y1:=D1/2;
                     X2:=DisPezzo^[2].X1+D3*Costant^.C19;
                     Y2:=D1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                     X2:=DisPezzo^[1].X2;
                     Y2:=-DisPezzo^[1].Y2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;
                     Y1:=-DisPezzo^[2].Y1;
                     X2:=DisPezzo^[2].X2;
                     Y2:=-DisPezzo^[2].Y2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X1;
                     Y1:=-DisPezzo^[3].Y1;
                     X2:=DisPezzo^[3].X2;
                     Y2:=-DisPezzo^[3].Y2;
                  end;

                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[4].X1;   Y1:=-DisPezzo^[4].Y1;
                     X2:=DisPezzo^[4].X2;
                     Y2:=-DisPezzo^[4].Y2;
                  end;

                 X1A:=-D3*Costant^.C1;
                 Y1A:=D1/2;
                 X2A:=-D3*Costant^.C1;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[4].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[4].X2;
                 Y4A:=-D1/2;
                 X5A:=DisPezzo^[2].X2;
                 Y5A:=DisPezzo^[2].Y2;
                 X6A:=DisPezzo^[3].X1;
                 Y6A:=DisPezzo^[3].Y1;
                 X7A:=DisPezzo^[3].X1;
                 Y7A:=-DisPezzo^[3].Y1;
                 X8A:=DisPezzo^[2].X2;
                 Y8A:=-DisPezzo^[2].Y2;

              end;
          2,4:begin
                 Ang:=pi/4;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=((D1/2)/tan(Ang))-((D3/2)/sin(Ang));
                     Y1:=D1/2;             X2:=X1;
                     Y2:=-D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang));
                     Y1:=D1/2;
                     X2:=X1;               Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3*Costant^.C1;          Y1:=D1/2;
                     Y2:=D1/2;
                     X2:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang))+D3*Costant^.C19;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X1;   Y1:=-D1/2;
                     X2:=DisPezzo^[3].X2;   Y2:=-D1/2;
                  end;


                 X1A:=DisPezzo^[3].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[3].X1;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[3].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[3].X2;
                 Y4A:=-D1/2;
                 X5A:=DisPezzo^[2].X1+(D3/2)*cos(ang)*Costant^.C20-D3*sin(Ang);
                 Y5A:=D1/2;
                 X6A:=X5A;
                 Y6A:=-D1/2;
                 X7A:=X5A;
                 Y7A:=D1/2;
                 X8A:=X5A;
                 Y8A:=-D1/2;

              end;

          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=-D1/2;            X1:=0;
                     Y2:=-D3/2;
                     X2:=-(D1/2)-abs((D3/2)*sin(Ang)*Costant^.C20)-D3*cos(Ang);
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=-D1/2;            X1:=0;
                     Y2:=-D3/2;
                     X2:=(D1/2)+abs((D3/2)*sin(Ang)*Costant^.C20)+D3*cos(Ang);
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=D1/2;             X1:=0;
                     Y2:=D3/2;             X2:=DisPezzo^[1].X2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=D1/2;             X1:=0;
                     Y2:=D3/2;             X2:=DisPezzo^[2].X2;
                  end;


                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
                 X5A:=DisPezzo^[2].X2;
                 Y5A:=D3/2;
                 X6A:=DisPezzo^[2].X2;
                 Y6A:=-D3/2;
                 X7A:=DisPezzo^[1].X2;
                 Y7A:=-D3/2;
                 X8A:=DisPezzo^[1].X2;
                 Y8A:=D3/2;


              end;
       end;

    end;


end.

