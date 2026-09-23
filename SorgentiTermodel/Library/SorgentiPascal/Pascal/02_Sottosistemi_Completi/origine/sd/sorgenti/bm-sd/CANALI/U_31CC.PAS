

unit U_31CC;

interface

Procedure D_31CC;
Procedure D_30;
Procedure D_250R;


implementation

uses crt,dos,definiz,definizcan,U_VARPEZZI,interf3d;

Procedure D_31CC;
var AX,AY,DX,DY,X,A,B,D:real;
    Int:integer;
    Lung:real;
 begin
    X:=0.5+Costant^.C5;
    if Ang<60.1 then X:=Costant^.C9;
    if Ang<45.1 then X:=Costant^.C10;
    if Ang<30.1 then X:=Costant^.C11;
    Ang:=Ang/180*pi;
    AX:=D1*X*cos(Ang);
    AY:=D1*X*sin(Ang);
    DX:=(D3/2)*cos((pi/2)-Ang);
    DY:=(D3/2)*sin((pi/2)-Ang);

    if Ang=pi/2 then Lung:=D1/2*Costant^.C44+D1/2*Costant^.C43
    else Lung:=(AX+DX)*Costant^.C44+D1/2*Costant^.C43;

    Cilindro1(orient,d3,D1/2+D3/2,-(D1/2+D3/2)/2,0,0,Pi/2);
    Cilindro1(orient,d1,lung,0,0,0,0);


    case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D1/2*Costant^.C43;Y1:=D1/2;
                     if Ang=pi/2 then X2:=D1/2*Costant^.C44
                     else X2:=(AX+DX)*Costant^.C44;
                     Y2:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=AX-DX;
                     if Ang=pi/2 then Y1:=-D1/2-D3/2
                     else Y1:=-AY-DY;
                     Inters(X2,Y2,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,-DX,-DisPezzo^[1].Y1,
                     -DisPezzo^[1].Y2,Y1,-DY);
                     if Int<>1 then write(Chr(7));
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=AX+DX;
                     if Ang=pi/2 then Y1:=-D1/2-D3/2
                     else Y1:=-AY+DY;
                     Inters(X2,Y2,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,X1,DX,-DisPezzo^[1].Y1,
                     -DisPezzo^[1].Y2,Y1,DY);
                     if Int<>1 then write(Chr(7));
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-DisPezzo^[1].Y1;
                     Inters(X2,Y2,Int,X1,DisPezzo^[1].X2,DisPezzo^[2].X1,DisPezzo^[2].X2,
                            Y1,-DisPezzo^[1].Y2,DisPezzo^[2].Y1,DisPezzo^[2].Y2);
                     if Int<>1 then write(Chr(7));
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=-DisPezzo^[1].Y2;
                     Inters(X2,Y2,Int,X1,DisPezzo^[1].X1,DisPezzo^[3].X1,DisPezzo^[3].X2,
                            Y1,-DisPezzo^[1].Y1,DisPezzo^[3].Y1,DisPezzo^[3].Y2);
                     if Int<>1 then write(Chr(7));
                  end;

                 with DisPezzo^[6] do
                  begin
                     Entita:='P';          TLinea:=1;
                     Inters(X1,Y1,Int,DisPezzo^[1].X1,DisPezzo^[1].X2,AX,0,-DisPezzo^[1].Y1,
                     -DisPezzo^[1].Y2,-AY,0);
                     if Int<>1 then write(Chr(7));
                     A:=abs(Y1)-abs(DisPezzo^[3].Y2);
                     B:=DisPezzo^[3].X2-DisPezzo^[6].X1;
                     X:=ArcTan(A/B);
                     if Orient = 1 then
                      begin
                         X2:=0+X;              Y2:=pi/2+X;
                         R:=B*cos(X);          R1:=D3/2;
                      end
                     else
                      begin
                         x2:=-pi/2+X;           y2:=0+X;
                         R1:=B*cos(X);          R:=D3/2;
                      end;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='P';          TLinea:=1;
                     X1:=DisPezzo^[6].X1;   Y1:=DisPezzo^[6].Y1;
                     if Orient = 1 then
                      begin
                         X2:=pi/2+X;           Y2:=pi+X;
                      end
                     else
                      begin
                         X2:=-pi/2+X;            Y2:=pi+X;
                      end;
                     R:=D3/2;
                     R1:=B*cos(X);
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-DisPezzo^[1].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-DisPezzo^[1].Y2;

                 if Orient=1 then
                  begin
                     X5A:=DisPezzo^[3].X1;
                     Y5A:=DisPezzo^[3].Y1;
                     X6A:=DisPezzo^[2].X1;
                     Y6A:=DisPezzo^[2].Y1;
                  end
                 else
                  begin
                     Speculare:=true;
                     X5A:=DisPezzo^[2].X1;
                     Y5A:=-DisPezzo^[2].Y1;
                     X6A:=DisPezzo^[3].X1;
                     Y6A:=-DisPezzo^[3].Y1;
                  end;

              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D1/2*Costant^.C43;Y1:=D1/2;
                     if Ang=pi/2 then X2:=D1/2*Costant^.C44
                     else X2:=(AX+DX)*Costant^.C44;
                     Y2:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D1/2*Costant^.C43;Y1:=-D1/2;
                     if Ang=pi/2 then X2:=D1/2*Costant^.C44
                     else X2:=(AX+DX)*Costant^.C44;
                     Y2:=-D2/2;
                  end;
                 if (Orient = 2) and (Ang=pi/2) then
                  with DisPezzo^[3] do
                   begin
                      Entita:='C';          TLinea:=2;
                      X1:=0;                Y1:=0;
                      R:=D3/2;
                   end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=D2/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-D2/2;
                 X5A:=AX;
                 Y5A:=D3/2;
                 X6A:=AX;
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
                     X2:=AY+DY;            Y2:=D3/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D;                Y1:=-D3/2;
                     X2:=AY+DY;            Y2:=-D3/2;
                  end;

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
                 X5A:=AY+DY;
                 Y5A:=D3/2;
                 X6A:=AY+DY;
                 Y6A:=-D3/2;

              end;
    end;
 end;



procedure D_30;
var Dx,Lato,Larg:real;
 begin
       case orient of

        1,3,2,4:begin
                 if (CodPezzo='30') or (CodPezzo='24ER') then
                  begin
                     if Lung > 0 then Larg:=Lung*2
                     else Larg:=B1*Costant^.C47;
                     Lato:=B1;
                  end
                 else
                  begin
                     if Lung > 0 then Larg:=Lung*2
                     else Larg:=D1*Costant^.C47;
                     Lato:=D1;
                  end;

                 Dx:=(Larg/4)*sin(pi/4);

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;          Y1:=Lato/2;
                     X2:=Larg/4;           Y2:=Lato/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;          Y1:=-Lato/2;
                     X2:=Larg/4;           Y2:=-Lato/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=Lato/4;
                     R:=Costant^.C12;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=-Lato/4;
                     R:=Costant^.C12;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Dx;              Y1:=Lato/4-Dx;
                     X2:=Dx;               Y2:=Lato/4+Dx;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Dx;               Y1:=-Lato/4-Dx;
                     X2:=-Dx;              Y2:=-Lato/4+Dx;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;

              end;
       end;
 end;

procedure D_250R;
var Larg,Lato:real;
 begin
       case orient of

        1,3,2,4:begin
                 if (CodPezzo='250R') then
                  begin
                     Lato:=B1;
                     if Lung > 0 then Larg:=Lung*2
                     else Larg:=B1/2*Costant^.C46;
                  end
                 else
                  begin
                     Lato:=D1;
                     if Lung > 0 then Larg:=Lung*2
                     else Larg:=D1/2*Costant^.C46;
                  end;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;          Y1:=Lato/2;
                     X2:=Larg/4;           Y2:=Lato/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;          Y1:=-Lato/2;
                     X2:=Larg/4;           Y2:=-Lato/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/12;          Y1:=Lato/2;
                     X2:=-Larg/12;          Y2:=-Lato/2+Larg/6*Costant^.C13;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Larg/12;           Y1:=-Lato/2;
                     X2:=Larg/12;           Y2:=Lato/2-Larg/6*Costant^.C13;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;

              end;
       end;
 end;


end.


(*
                 with DisPezzo^[6] do
                  begin
                     Entita:='A';          TLinea:=1;
                     if Ang=pi/2 then
                      begin
                         X1:=0;  Y1:=-D1/2;
                      end
                     else
                      begin
                         Inters(X1,Y1,Int,0,DX,DisPezzo^[1].X1,DisPezzo^[1].X2,
                                0,-DY,-DisPezzo^[1].Y1,-DisPezzo^[1].Y2);
                         if Int<>1 then write(Chr(7));
                      end;
                     DY:=D1/2-D2/2;
                     DX:=DisPezzo^[1].X2-(DisPezzo^[2].X1);
                     AX:=Sqrt(sqr(DX)+sqr(DY));
                     Ang:=arccos(DX/AX);
                     DX:=DY*sin(Ang);
                     X1:=X1+(DX);
                     Y1:=Y1-(DY);
                     A:=abs(DisPezzo^[3].X2-(DisPezzo^[2].X2));
                     B:=abs(DisPezzo^[2].Y2-(DisPezzo^[3].Y2));
                     Cell1:=Sqrt(sqr(A)+sqr(B))/2;
                     if Ang<>pi/2 then Cell2:=sqr(3-(Ang/(pi/2)))*Costant^.C2
                     else Cell2:=0;
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
                     X7A:=DisPezzo^[6].X1;
                     Y7A:=DisPezzo^[6].Y1;
                  end;
*)