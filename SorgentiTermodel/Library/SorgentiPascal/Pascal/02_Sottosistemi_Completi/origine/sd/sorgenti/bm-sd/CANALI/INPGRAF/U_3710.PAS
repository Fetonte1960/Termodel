{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit U_3710;

interface

Procedure D_3710;
Procedure D_3711;
Procedure D_3717;
Procedure D_3723R;

implementation

uses crt,dos,definiz,U_VARPEZZI;

Procedure D_3710;
VAR Dif,Imb:real;
 begin
    Dif:=D3/4*Costant^.C23;
    Imb:=D3*Costant^.C24;
    case orient of
          1,3:begin

                 Ang:=pi/2;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3/2-Dif-Imb;    Y1:=-D1/2;
                     X2:=-D3/2-Dif;        Y2:=-D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D3/2+Dif;         Y1:=-D1/2;
                     X2:=D3/2+Dif+Imb;   Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3/2-Dif;        Y1:=-D1/2;
                     X2:=-D3/2-Dif;        Y2:=-D1/2-Dif;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D3/2+Dif;        Y1:=-D1/2;
                     X2:=D3/2+Dif;        Y2:=-D1/2-Dif;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3/2-Dif;        Y1:=-D1/2-Dif;
                     X2:=-D3/2;            Y2:=Y1-Dif;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D3/2+Dif;         Y1:=-D1/2-Dif;
                     X2:=D3/2;             Y2:=Y1-Dif;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3/2;            Y1:=DisPezzo^[6].Y2;
                     X2:=-D3/2;            Y2:=Y1-D3/4*Costant^.C25;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D3/2;             Y1:=DisPezzo^[6].Y2;
                     X2:=D3/2;             Y2:=Y1-D3/4*Costant^.C25;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3/2-Dif-Imb;  Y1:=D1/2;
                     X2:=D3/2+Dif+Imb;   Y2:=D1/2;
                  end;
                 with DisPezzo^[10] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[5].X1;   Y1:=DisPezzo^[5].Y1;
                     X2:=DisPezzo^[6].X1;   Y2:=Y1;
                  end;
                 with DisPezzo^[11] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[5].X2;   Y1:=DisPezzo^[5].Y2;
                     X2:=DisPezzo^[6].X2;   Y2:=Y1;
                  end;
                 with DisPezzo^[12] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=0;                Y1:=-D1/2;
                     R:=D3/2+Dif;
                     if Orient=1 then
                      begin
                          X2:=0;
                          Y2:=pi;
                      end
                     else
                      begin
                         X2:=pi;
                         Y2:=0;
                      end;
                  end;


                 X1A:=DisPezzo^[9].X1;
                 Y1A:=DisPezzo^[9].Y1;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=DisPezzo^[1].Y1;
                 X3A:=DisPezzo^[9].X2;
                 Y3A:=DisPezzo^[9].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;

                 if Orient=1 then
                  begin
                     X5A:=DisPezzo^[8].X2;
                     Y5A:=DisPezzo^[8].Y2;
                     X6A:=DisPezzo^[7].X2;
                     Y6A:=DisPezzo^[7].Y2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X5A:=DisPezzo^[7].X2;
                     Y5A:=-DisPezzo^[7].Y2;
                     X6A:=DisPezzo^[8].X2;
                     Y6A:=-DisPezzo^[8].Y2;
                  end;

              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3/2-Dif-Imb;              Y1:=-D1/2;
                     X2:=D3/2+Dif+Imb;               Y2:=-D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3/2-Dif-Imb;              Y1:=D1/2;
                     X2:=D3/2+Dif+Imb;               Y2:=D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='C';
                     if Orient = 2 then TLinea:=2
                     else TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=D3/2+Dif;
                  end;
                 if Orient = 2 then
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='C';          TLinea:=2;
                         X1:=0;                Y1:=0;
                         R:=D3/2;
                      end;
                  end;

                 X1A:=-D3/2-Dif-Imb;
                 Y1A:=D1/2;
                 X2A:=-D3/2-Dif-Imb;
                 Y2A:=-D1/2;
                 X3A:=D3/2+Dif+Imb;
                 Y3A:=D1/2;
                 X4A:=D3/2+Dif+Imb;
                 Y4A:=-D1/2;
                 X5A:=0;
                 Y5A:=D3/2;
                 X6A:=0;
                 Y6A:=-D3/2;
                 if Orient = 2 then Z3:=-(D1/2+2*Dif+D3/4*Costant^.C25)
                 else Z3:=D1/2+2*Dif+D3/4*Costant^.C25;
              end;

          5,6:begin
                 Ang:=ArcSin((D3/2+Dif)/(D1/2));
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D1/2*cos(ang);    Y1:=D3/2+Dif;
                     X2:=D1/2+Dif;         Y2:=Y1;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                     X2:=DisPezzo^[1].X2;   Y2:=-DisPezzo^[1].Y1;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=DisPezzo^[1].Y2;
                     X2:=X1+Dif;           Y2:=D3/2;  {Y1-Dif;}
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=DisPezzo^[2].Y2;
                     X2:=X1+Dif;           Y2:=-D3/2;  {Y1+Dif;}
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[4].X2;   Y1:=D3/2;
                     X2:=X1+D3/4*Costant^.C25;          Y2:=D3/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[4].X2;   Y1:=-D3/2;
                     X2:=X1+D3/4*Costant^.C25;          Y2:=-D3/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=DisPezzo^[1].Y1;
                     X2:=DisPezzo^[1].X2;   Y2:=-DisPezzo^[1].Y1;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[4].X2;   Y1:=D3/2;
                     X2:=DisPezzo^[4].X2;   Y2:=-D3/2;
                  end;


                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
                 X5A:=DisPezzo^[6].X2;
                 Y5A:=D3/2;
                 X6A:=DisPezzo^[6].X2;
                 Y6A:=-D3/2;
                 if Orient = 5 then
                  begin
                     Z1:=D3/2+Dif+Imb;
                     Z2:=-D3/2-Dif-Imb;
                  end
                 else
                  begin
                     Z1:=-D3/2-Dif-Imb;
                     Z2:=D3/2+Dif+Imb;
                  end;
              end;

    end;
 end;



Procedure D_3711;
VAR D:real;
 begin
    Ang:=pi/4;
    case orient of
          1,3:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=((D1/2)/tan(Ang))-((D3/2)/sin(Ang))-D3*Costant^.C26;
                     X2:=((D1/2)/tan(Ang))-((D3/2)/sin(Ang))-(D3/4)*Costant^.C27;
                     Y2:=-D1/2;    Y1:=-D1/2;
                     R:=abs(X1)-abs(X2);
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang))+(D3/4)*Costant^.C28;
                     Y1:=-D1/2;
                     X2:=X1;
                     Y2:=-D1/2-D3/4*Costant^.C28;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;   Y1:=DisPezzo^[2].Y2;
                     X2:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang))+(D3/2)*cos(ang)*Costant^.C29;
                     Y2:=-D1/2-abs((D3/2)*sin(Ang));
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X2;   Y1:=DisPezzo^[2].Y2;
                     X2:=X1-D3*sin(Ang);   Y2:=Y1-D3*cos(Ang);
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X2-D3*sin(Ang);
                     Y1:=DisPezzo^[3].Y2-D3*cos(Ang);
                     X2:=DisPezzo^[8].X2;
                     Y2:=DisPezzo^[8].Y2;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[8].X2;   Y1:=DisPezzo^[8].Y2;
                     X2:=DisPezzo^[1].X2;   Y2:=DisPezzo^[1].Y2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X1;   Y1:=-D1/2;  { -D2}
                     X2:=DisPezzo^[3].X1+D3*Costant^.C30;
                     Y2:=-D1/2;                        { -D2}
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[5].X2;   Y1:=D1/2;
                     X2:=((D1/2)/tan(Ang))-((D3/2)/sin(Ang))-D3*Costant^.C26;
                     Y2:=D1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='A';          TLinea:=1;
                     if DisPezzo^[1].X2 > 0 then Cell1:=abs((DisPezzo^[2].X1-DisPezzo^[1].X2)/2)
                     else Cell1:=abs((DisPezzo^[1].X2-DisPezzo^[2].X1)/2);
                     Cell2:=sqr(3-(Ang/(pi/2)))*Costant^.C2;
                     X1:=DisPezzo^[1].X2+Cell1;
                     Y1:=DisPezzo^[1].Y2-Cell2;
                     R:=Sqrt(sqr(Cell1)+sqr(Cell2));
                     if Cell2/R=0 then
                      begin
                         if Orient=1 then
                          begin
                             X2:=0;
                             Y2:=pi;
                          end
                         else
                          begin
                             X2:=pi;
                             Y2:=0;
                          end
                      end
                     else
                      if Orient=1 then
                       begin
                          X2:=pi/2-ArcCos(Cell2/R);
                          Y2:=pi/2+ArcCos(Cell2/R);
                       end
                      else
                       begin
                          X2:=-ArcCos(Cell2/R)-pi/2;
                          Y2:=pi/2-ArcCos(Cell2/R);
                       end;

                  end;


(*
 DISEGNO DELL'ARCO MEDIANTE LA PLINEA, NON FUNZIONA BENE !
                 with DisPezzo^[7] do
                  begin
                     Entita:='P';          TLinea:=1;
                     X1:=DisPezzo^[3].X2-(D3/2)*sin(Ang);
                     Y1:=DisPezzo^[3].Y2-(D3/2)*cos(Ang);
                     Inters(X1,Y1,Int1,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,0,DisPezzo^[1].Y1,
                     DisPezzo^[1].Y2,Y1,0);
                     if Int1<>1 then write(Chr(7));
                     X2:=0;                Y2:=pi/2;
                     R:=DisPezzo^[2].X1-X1; R1:=D3/2;
                     X7A:=X1;
                     Y7A:=Y1;
                  end;
                 with DisPezzo^[10] do
                  begin
                     Entita:='P';          TLinea:=1;
                     X1:=DisPezzo^[7].X1;   Y1:=DisPezzo^[7].Y1;
                     X2:=pi/2;             Y2:=pi;
                     R:=D3/2;              R1:=DisPezzo^[2].X1-X1;
                  end;
*)

                 X1A:=DisPezzo^[6].X2;
                 Y1A:=DisPezzo^[6].Y2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=DisPezzo^[1].Y1;

                 if Orient=1 then
                  begin
                     X3A:=DisPezzo^[6].X1;
                     Y3A:=DisPezzo^[6].Y1;
                     X4A:=DisPezzo^[5].X2;
                     Y4A:=DisPezzo^[5].Y1;
                     X5A:=DisPezzo^[3].X2;
                     Y5A:=DisPezzo^[3].Y2;
                     X6A:=DisPezzo^[4].X1;
                     Y6A:=DisPezzo^[4].Y1;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=DisPezzo^[5].X2;
                     Y3A:=-DisPezzo^[5].Y1;
                     X4A:=DisPezzo^[6].X1;
                     Y4A:=-DisPezzo^[6].Y1;
                     X5A:=DisPezzo^[4].X1;
                     Y5A:=-DisPezzo^[4].Y1;
                     X6A:=DisPezzo^[3].X2;
                     Y6A:=-DisPezzo^[3].Y2;
                  end;

              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=((D1/2)/tan(Ang))-((D3/2)/sin(Ang))-D3*Costant^.C26;
                     Y1:=D1/2;
                     X2:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang))+(D3/4)*Costant^.C28+D3*Costant^.C30;
                     Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=0;                Y1:=D3/2;
                     X2:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang))+(D3/2)*cos(ang)*Costant^.C29;
                     Y2:=D3/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X1;   Y1:=-D3/2;
                     X2:=DisPezzo^[3].X2;   Y2:=-D3/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-D1/2;
                 X5A:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang))+(D3/2)*cos(ang)*Costant^.C29;
                 Y5A:=D3/2;
                 X6A:=((D1/2)/tan(Ang))+((D3/2)/sin(Ang))+(D3/2)*cos(ang)*Costant^.C29;
                 Y6A:=-D3/2;
              end;
          5,6:begin
                 if Abs(D1) > Abs(D3) then
                   D:=sqrt(sqr(D1/2)-sqr(D3/2))
                 else D:=D1;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D;                Y1:=D3/2;
                     X2:=D1/2+(D3/2)*cos(ang)*Costant^.C29;
                     Y2:=D3/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D;                Y1:=-D3/2;
                     X2:=D1/2+(D3/2)*cos(ang)*Costant^.C29;
                     Y2:=-D3/2;
                  end;

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
                 X5A:=D1/2+(D3/2)*cos(ang)*Costant^.C29;
                 Y5A:=D3/2;
                 X6A:=D1/2+(D3/2)*cos(ang)*Costant^.C29;
                 Y6A:=-D3/2;

              end;

    end;
 end;

Procedure D_3717;
var
   Int:integer;
   DX,DX1:real;
 begin
    Ang:=pi/4;
    DX:=(D1*Costant^.C3*sin(Ang));
    DX1:=(D3/2)*sin(Ang);

    case orient of
          1,3:begin
                 Ang:=pi/4;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=-((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang));
                     Y1:=D1/2;
                     X2:=X1+2*D3*Costant^.C4; Y2:=D2/2;
                  end;



                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-D1/2;
                     X2:=DisPezzo^[1].X1+DX-DX1;
                     Y2:=-DX-DX1;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X2:=DisPezzo^[2].X2+2*DX1;
                     Y2:=-DX+DX1;
                     Inters(X1,Y1,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,DisPezzo^[1].X1,
                            X2,-DisPezzo^[1].Y1,-DisPezzo^[1].Y2,((D3/2)/cos(pi/4)),Y2);
                     if Int<>1 then write(Chr(7));
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X1;   Y1:=DisPezzo^[3].Y1;
                     X2:=DisPezzo^[1].X2;   Y2:=-DisPezzo^[1].Y2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='A';         TLinea:=1;
		     X1:=-Costant^.C8*D3;         Y1:=-DX-(Costant^.C8*D3*sin(Ang));
                     if Orient=1 then
                      begin
                         X2:=0;               Y2:=Ang;
                      end
                     else
                      begin
                         X2:=-Ang;            Y2:=0;
                      end;
                     R:=(Costant^.C8*D3-D3/2);
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='A';         TLinea:=1;
                     X1:=-Costant^.C8*D3;         Y1:=-DX-(Costant^.C8*D3*sin(Ang));
                     if Orient=1 then
                      begin
                         X2:=0;               Y2:=Ang;
                      end
                     else
                      begin
                         X2:=-Ang;            Y2:=0;
                      end;
                     R:=(Costant^.C8*D3+D3/2);
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X2;   Y1:=DisPezzo^[3].Y2;
                     X2:=DisPezzo^[2].X2;   Y2:=DisPezzo^[2].Y2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=DisPezzo^[1].Y1;
                     X2:=X1-D3*Costant^.C40;    Y2:=Y1;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;   Y1:=DisPezzo^[2].Y1;
                     X2:=DisPezzo^[8].X2;   Y2:=Y1;
                  end;
                 with DisPezzo^[10] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X1;   Y1:=DisPezzo^[3].Y1;
                     X2:=DisPezzo^[1].X1;   Y2:=0;
                  end;
                 with DisPezzo^[11] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=DisPezzo^[1].Y1;
                     X2:=DisPezzo^[1].X1;   Y2:=-Y1;
                  end;


                 X1A:=DisPezzo^[8].X2;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[8].X2;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[4].X2;
                 Y4A:=DisPezzo^[4].Y2;

                 if Orient=1 then
                  begin
                     X5A:=D3/2;
                     Y5A:=DisPezzo^[5].Y1;
                     X6A:=-D3/2;
                     Y6A:=DisPezzo^[5].Y1;
                  end
                 else
                  begin
                     Speculare:=true;
                     X5A:=-D3/2;
                     Y5A:=-DisPezzo^[5].Y1;
                     X6A:=D3/2;
                     Y6A:=-DisPezzo^[5].Y1;
                  end;

              end;
          2,4:begin
                 Ang:=pi/4;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang));
                     Y1:=D1/2;
                     X2:=X1+2*D3*Costant^.C4;         Y2:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang));
                     Y1:=-D1/2;
                     X2:=X1+2*D3*Costant^.C4;         Y2:=-D2/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=DisPezzo^[1].Y1;
                     X2:=X1-D3*Costant^.C40;    Y2:=Y1;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;   Y1:=DisPezzo^[2].Y1;
                     X2:=DisPezzo^[3].X2;   Y2:=Y1;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=DisPezzo^[1].Y1;
                     X2:=DisPezzo^[1].X1;   Y2:=-Y1;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';
                     if Orient=2 then  TLinea:=1
                     else TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=DisPezzo^[1].Y1;
                     X2:=0;                Y2:=D3/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';
                     if Orient=2 then  TLinea:=1
                     else TLinea:=1;
                     X1:=DisPezzo^[2].X1;   Y1:=DisPezzo^[2].Y1;
                     X2:=0;                Y2:=-D3/2;
                  end;
                 if Orient = 2 then
                  with DisPezzo^[8] do
                   begin
                      Entita:='C';          TLinea:=2;
                      X1:=0;                Y1:=0;
                      R:=D3/2;
                   end;


                 X1A:=DisPezzo^[3].X2;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[3].X2;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;
                 X5A:=0;
                 Y5A:=D3/2;
                 X6A:=0;
                 Y6A:=-D3/2;
                 if Orient = 2 then
                  Z3:=-((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang))+DX-DX1-(D3*sin(Ang))
                 else Z3:=((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang))-DX+DX1+(D3*sin(Ang));

              end;
          5,6:begin
                 Ang:=pi/4;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=0;                Y1:=D1/2;
                     X2:=((Costant^.C8*D3)+((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang));
		     Y2:=D3/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=-D3/2;
                  end;
                 if Orient = 5 then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='C';          TLinea:=2;
                         X1:=0;                Y1:=0;
                         R:=D2/2;
                      end;
                  end
                 else
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='C';          TLinea:=1;
                         X1:=0;                Y1:=0;
                         R:=D1/2;
                      end;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X1;
                 Y3A:=D2/2;
                 X4A:=DisPezzo^[1].X1;
                 Y4A:=-D2/2;
                 X5A:=DisPezzo^[1].X2;
                 Y5A:=D3/2;
                 X6A:=DisPezzo^[1].X2;
                 Y6A:=-D3/2;

                 if Orient = 5 then
                  begin
                     Z1:=((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang))+D3*Costant^.C40;
		     Z2:=((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang))-2*D3*Costant^.C4;
                  end
                 else
                  begin
                     Z1:=-((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang))-D3*Costant^.C40;
                     Z2:=-((Costant^.C8*D3)-((Costant^.C8*D3)*cos(Ang))+(D1*Costant^.C3)*cos(Ang))+2*D3*Costant^.C4;
                  end;

              end;

    end;
 end;

Procedure D_3723R;
 begin
       Ang:=Ang/180*pi;
       case orient of
          1,3:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=-B3*Costant^.C64;          Y1:=-B1/2;
                     if Ang=pi/2 then X2:=-B3/2
                     else X2:=((B1/2)/tan(Ang))-((B3/2)/sin(Ang));
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     if Ang=pi/2 then X1:=B3/2
                     else X1:=((B1/2)/tan(Ang))+((B3/2)/sin(Ang));
                     Y1:=-B1/2;
                     X2:=X1+(B3/2)*cos(ang)*Costant^.C18;
                     Y2:=-(B1/2)-abs((B3/2)*sin(Ang)*Costant^.C18);
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X2-B3*sin(Ang);
                     Y1:=DisPezzo^[2].Y2-B3*cos(Ang);
                     Y2:=-B1/2;
                     X2:=DisPezzo^[1].X2;
                  end;

      (* ricalcolo i valori della seconda linea in modo che la procedura funzioni
        sia con Ingresso=Uscita o Ingresso<> Uscita   *)

                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=B1/2-B2;
                     X2:=X1+(B3/2)*cos(ang)*Costant^.C18;
                     Y2:=-(B1/2)-abs((B3/2)*sin(Ang)*Costant^.C18);
                     if Ang<>pi/2 then X1:=X1-((B1-B2)/tan(Ang));
                  end;

                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X1;   Y1:=B1/2-B2;
		     X2:=DisPezzo^[2].X1+B3*Costant^.C17;
                     Y2:=B1/2-B2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[4].X2;   Y1:=B1/2;
                     X2:=DisPezzo^[1].X1;   Y2:=B1/2;
                  end;

		 X1A:=-B3*Costant^.C64;
                 Y1A:=B1/2;
		 X2A:=-B3*Costant^.C64;
                 Y2A:=-B1/2;

                 if Orient=1 then
                  begin
                     X3A:=DisPezzo^[4].X2;
                     Y3A:=B1/2;
                     X4A:=DisPezzo^[4].X2;
                     Y4A:=B1/2-B2;
                     X6A:=DisPezzo^[3].X1;
                     Y6A:=DisPezzo^[3].Y1;
                     X5A:=DisPezzo^[2].X2;
                     Y5A:=DisPezzo^[2].Y2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=DisPezzo^[4].X2;
                     Y3A:=-B1/2+B2;
                     X4A:=DisPezzo^[4].X2;
                     Y4A:=-B1/2;
                     X6A:=DisPezzo^[2].X2;
                     Y6A:=-DisPezzo^[2].Y2;
                     X5A:=DisPezzo^[3].X1;
                     Y5A:=-DisPezzo^[3].Y1;
                  end;

              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=-H3*Costant^.C64;          Y1:=-B1/2;
                     if Ang=pi/2 then X2:=H3/2
		     else X2:=(H1/2)/tan(Ang)+(H3/2)/sin(Ang)-(H1-H2)/tan(Ang)+H3*Costant^.C17;
                     Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';
                     if Orient = 2 then TLinea:=2
                     else TLinea:=1;
                     if Ang=pi/2 then X1:=H3/2
                     else X1:=((H1/2)/tan(Ang))+((H3/2)/sin(Ang))+(H3/2)*cos(ang)*Costant^.C18-H3*sin(Ang);
                     Y1:=B1/2;
                     X2:=X1;               Y2:=-B1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=B1/2;;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-B1/2;;
                 X5A:=DisPezzo^[3].X1;
                 Y5A:=B1/2;;
                 X6A:=DisPezzo^[3].X1;
                 Y6A:=-B1/2;;

              end;
            5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=(H1/2)+abs((H3/2)*sin(Ang)*Costant^.C18)+H3*cos(Ang);
		     Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;
		     Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2+H2;
                     Y1:=B1/2;
                     X2:=X1;               Y2:=-B1/2;
                  end;

                 X1A:=0;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=0;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=0;
                 Y3A:=DisPezzo^[1].Y1;
                 X4A:=0;
                 Y4A:=DisPezzo^[2].Y1;
                 X5A:=DisPezzo^[2].X2;
                 Y5A:=DisPezzo^[1].Y1;
                 X6A:=DisPezzo^[2].X2;
                 Y6A:=DisPezzo^[2].Y1;

              end;
            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H1/2+H2;         Y1:=B1/2;
                     X2:=(H1/2)+abs((H3/2)*sin(Ang)*Costant^.C18)+H3*cos(Ang);
		     Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-B1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=X1;               Y2:=-B1/2;
                  end;

                 X1A:=0;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=0;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=0;
                 Y3A:=DisPezzo^[1].Y1;
                 X4A:=0;
                 Y4A:=DisPezzo^[2].Y1;
                 X5A:=DisPezzo^[2].X2;
                 Y5A:=DisPezzo^[1].Y1;
                 X6A:=DisPezzo^[2].X2;
                 Y6A:=DisPezzo^[2].Y1;

              end;

       end;
 end;
end.

