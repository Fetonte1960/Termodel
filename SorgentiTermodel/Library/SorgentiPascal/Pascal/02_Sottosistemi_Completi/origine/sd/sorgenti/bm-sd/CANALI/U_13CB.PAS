

unit U_13CB;

interface

Procedure D_13CB;
Procedure D_328F;
Procedure D_10RBT;
Procedure D_11RBT;
Procedure D_11CBT;


implementation


uses definizcan,definiz,U_VARPEZZI,interf3d;


Procedure D_13CB;
var D:real;
 begin
       case orient of
          1,3:begin
                 if Abs(D1) > Abs(H3) then
                  D:=sqrt(sqr(D1/2)-sqr(H3/2))
                 else D:=D1;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3/2+B3*Costant^.C32);
                     X2:=B3/2+B3*Costant^.C32;
                     Y1:=D1/2;             Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3/2+B3*Costant^.C32);
                     Y1:=-D1/2;
                     X2:=-B3/2;
                     Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;
                     Y1:=-D1/2;
                     X2:=B3/2+B3*Costant^.C32;
                     Y2:=-D1/2;
                  end;
            (*   with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;            Y1:=-D1/2;
                     X2:=-B3/2;            Y2:=-D1/2+D;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;             Y1:=-D1/2;
                     X2:=B3/2;             Y2:=-D1/2+D;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;            Y1:=-D1/2+D;
                     X2:=B3/2;             Y2:=-D1/2+D;
                  end;
           *)

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;

                 X3A:=DisPezzo^[1].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-D1/2;

                 if Orient=1 then
                  begin
                     X5A:=B3/2;
                     Y5A:=-D1/2+D;
                     X6A:=-B3/2;
                     Y6A:=-D1/2+D;
                  end
                 else
                  begin
                     Speculare:=true;
                     X5A:=-B3/2;
                     Y5A:=D1/2-D;
                     X6A:=B3/2;
                     Y6A:=D1/2-D;
                  end;
              end;

          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3/2+H3*Costant^.C32);          Y1:=D1/2;
                     X2:=H3/2+H3*Costant^.C32;           Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3/2+H3*Costant^.C32);          Y1:=-D1/2;
                     X2:=H3/2+H3*Costant^.C32;           Y2:=-D1/2;
                  end;

                 if Orient = 2 then
                  begin
                     if B3<>D1 then
                      begin
                         with DisPezzo^[5] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H3/2;            Y1:=B3/2;
                             X2:=H3/2;             Y2:=B3/2;
                          end;
                         with DisPezzo^[6] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H3/2;            Y1:=-B3/2;
                             X2:=H3/2;             Y2:=-B3/2;
                          end;
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=-H3/2;             Y1:=B3/2;
                         X2:=-H3/2;             Y2:=-B3/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=H3/2;              Y1:=B3/2;
                         X2:=H3/2 ;             Y2:=-B3/2;
                      end;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=D1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-D1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=D1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-D1/2;
                 X5A:=H3/2;
                 Y5A:=0;
                 X6A:=-H3/2;
                 Y6A:=0;
              end;
          5,6:begin
                 if Abs(D1) > Abs(B3) then
                   D:=sqrt(sqr(D1/2)-sqr(B3/2))
                 else D:=D1;

                 if Orient = 6 then
                  with DisPezzo^[1] do
                   begin
                      Entita:='C';          TLinea:=1;
                      X1:=0;                Y1:=0;
                      R:=D1/2;
                   end;

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D1/2;
                 X4A:=0;
                 Y4A:=-D1/2;
                 X5A:=D;
                 Y5A:=B3/2;
                 X6A:=D;
                 Y6A:=-B3/2;
              end;

       end;
 end;

Procedure D_328F;
var D:real;
 begin
       if (CodPezzo='328F') or (CodPezzo='336F') then
        begin
           B3:=B2;
           H3:=H2;
        end;
       case orient of
          1,3:begin
                 if Abs(D1) > Abs(H3) then
                   D:=sqrt(sqr(D1/2)-sqr(H3/2))
                 else D:=D1;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B3/2+B3*Costant^.C65);         Y1:=D1/2;
                     X2:=-(B3/2+B3*Costant^.C65);        Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3/2+B3*Costant^.C65);
                     Y1:=-D1/2;
                     X2:=-B3/2;
                     Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;
                     Y1:=-D1/2;
                     X2:=B3/2+B3*Costant^.C65;
                     Y2:=-D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B3/2+B3*Costant^.C65);        Y1:=-D1/2;
                     X2:=(B3/2+B3*Costant^.C65);        Y2:=D1/2;
                  end;
(*

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;            Y1:=-D1/2;
                     X2:=-B3/2;            Y2:=-D1/2+D;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;             Y1:=-D1/2;
                     X2:=B3/2;             Y2:=-D1/2+D;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;            Y1:=-D1/2+D;
                     X2:=B3/2;             Y2:=-D1/2+D;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B3/2+B3*Costant^.C65);        Y1:=-D1/2;
                     X2:=(B3/2+B3*Costant^.C65);        Y2:=D1/2;
                  end;
*)

                 X1A:=-(B3/2+B3*Costant^.C65);
                 Y1A:=D1/2;
                 X2A:=-(B3/2+B3*Costant^.C65);
                 Y2A:=-D1/2;
                 if Orient=1 then
                  begin
                     X3A:=B3/2;
                     Y3A:=-D1/2+D;
                     X4A:=-B3/2;
                     Y4A:=-D1/2+D;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=-B3/2;
                     Y3A:=D1/2-D;
                     X4A:=B3/2;
                     Y4A:=D1/2-D;
                  end;
              end;

          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H3/2+H3*Costant^.C65);         Y1:=-D1/2;
                     X2:=-(H3/2+H3*Costant^.C65);        Y2:=-D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H3/2+H3*Costant^.C65);         Y1:=D1/2;
                     X2:=-(H3/2+H3*Costant^.C65);        Y2:=D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H3/2+H3*Costant^.C65);         Y1:=-D1/2;
                     X2:=(H3/2+H3*Costant^.C65);         Y2:=D1/2;
                  end;
                 if Orient = 2 then
                  begin
                     if B3<>D1 then
                      begin
                         with DisPezzo^[6] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H3/2;            Y1:=B3/2;
                             X2:=H3/2;             Y2:=B3/2;
                          end;
                         with DisPezzo^[7] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H3/2;            Y1:=-B3/2;
                             X2:=H3/2;             Y2:=-B3/2;
                          end;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=-H3/2;             Y1:=B3/2;
                         X2:=-H3/2;             Y2:=-B3/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=H3/2;              Y1:=B3/2;
                         X2:=H3/2;             Y2:=-B3/2;
                      end;
                  end;


                 X1A:=-(H3/2+H3*Costant^.C65);
                 Y1A:=D1/2;
                 X2A:=-(H3/2+H3*Costant^.C65);
                 Y2A:=-D1/2;
                 X3A:=H3/2;
                 Y3A:=0;
                 X4A:=-H3/2;
                 Y4A:=0;
              end;
          5,6:begin
                 if Abs(D1) > Abs(B3) then
                   D:=sqrt(sqr(D1/2)-sqr(B3/2))
                 else D:=D1;

                 if Orient = 6 then
                  with DisPezzo^[1] do
                   begin
                      Entita:='C';          TLinea:=1;
                      X1:=0;                Y1:=0;
                      R:=D1/2;
                   end;

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=D;
                 Y3A:=B3/2;
                 X4A:=D;
                 Y4A:=-B3/2;
              end;

       end;
 end;

Procedure D_10RBT;
var D:real;
    j:integer;
 begin
   box1(orient,b1,h1,2*(b2/2+b2*Costant^.C65),0,0,0,0);
   box1(orient,b2,h2,(b2/2+b2*Costant^.C65),0,-(b1/2+b2*Costant^.C65)/2,0,pi/2);

       case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B2/2+B2*Costant^.C65);         Y1:=-B1/2;
                     X2:=-(B2/2+B2*Costant^.C65);        Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B2/2+B2*Costant^.C65);         Y1:=B1/2;
                     X2:=-(B2/2+B2*Costant^.C65);        Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B2/2+B2*Costant^.C65);        Y1:=B1/2;
                     X2:=(B2/2+B2*Costant^.C65);        Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B2/2;             Y1:=-B1/2;
                     X2:=B2/2;             Y2:=-B1/2-B2*Costant^.C66;
                  end;

                 if (CodPezzo = '12RBT') or (CodPezzo = '12RAT') then

                  begin
                     DisPezzo^[4].Y2:=-B1/2-B2/2-B2/2*Costant^.C66;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B2/2;            Y1:=-B1/2-B2/2;
                         X2:=-B2/2;            Y2:=-B1/2-B2/2-B2/2*Costant^.C66;
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B2/2;            Y1:=-B1/2-B2/2;
                         X2:=-B2/2;            Y2:=-B1/2-B2/2-B2/2*Costant^.C66;
                      end;
                     with DisPezzo^[7] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B2;              Y1:=-B1/2;
                         X2:=-B2/2;            Y2:=-B1/2-B2/2;
                      end;
                     with DisPezzo^[8] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B2;              Y1:=-B1/2;
                         X2:=-B2/2;            Y2:=-B1/2-B2/2;
                      end;
                  end
                 else
                  with DisPezzo^[5] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=-B2/2;            Y1:=-B1/2;
                      X2:=-B2/2;            Y2:=-B1/2-B2*Costant^.C66;
                   end;

                 X1A:=-(B2/2+B2*Costant^.C65);
                 Y1A:=B1/2;
                 X2A:=-(B2/2+B2*Costant^.C65);
                 Y2A:=-B1/2;
                 if Orient = 1 then
                  begin
                     X3A:=B2/2;
                     X4A:=-B2/2;
                     if (CodPezzo = '12RBT') or (CodPezzo = '12RAT') then
                      begin
                         Y3A:=-B1/2-B2/2-B2/2*Costant^.C66;
                         Y4A:=-B1/2-B2/2-B2/2*Costant^.C66;
                      end
                     else
                      begin
                         Y3A:=-B1/2-B2*Costant^.C66;
                         Y4A:=-B1/2-B2*Costant^.C66;
                      end;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=-B2/2;
                     X4A:=B2/2;
                     if (CodPezzo = '12RBT') or (CodPezzo = '12RAT') then
                      begin
                         Y3A:=B1/2+B2/2+B2/2*Costant^.C66;
                         Y4A:=B1/2+B2/2+B2/2*Costant^.C66;
                      end
                     else
                      begin
                         Y3A:=B1/2+B2*Costant^.C66;
                         Y4A:=B1/2+B2*Costant^.C66;
                      end;
                  end;
              end;

          2,4:begin
                 j:=6;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H2/2+H2*Costant^.C65);         Y1:=-B1/2;
                     X2:=-(H2/2+H2*Costant^.C65);        Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H2/2+H2*Costant^.C65);         Y1:=B1/2;
                     X2:=-(H2/2+H2*Costant^.C65);        Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H2/2+H2*Costant^.C65);        Y1:=B1/2;
                     X2:=(H2/2+H2*Costant^.C65);        Y2:=-B1/2;
                  end;
                 if Orient = 2 then
                  begin
                     if B2<>B1 then
                      begin
                         with DisPezzo^[6] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H2/2;            Y1:=B2/2;
                             X2:=H2/2;             Y2:=B2/2;
                          end;
                         with DisPezzo^[7] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H2/2;            Y1:=-B2/2;
                             X2:=H2/2;             Y2:=-B2/2;
                          end;
                         j:=8;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=-H2/2;             Y1:=B2/2;
                         X2:=-H2/2;             Y2:=-B2/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=H2/2;              Y1:=B2/2;
                         X2:=H2/2;              Y2:=-B2/2;
                      end;
                     if (CodPezzo = '12RBT') or (CodPezzo = '12RAT') then
                      BEGIN
                         with DisPezzo^[j] do
                          begin
                             Entita:='L';           TLinea:=2;
                             X1:=-H2;               Y1:=B2/2;
                             X2:=-H2;              Y2:=-B2/2;
                          end;
                         DisPezzo^[6].X1:=-H2;
                         DisPezzo^[7].X1:=-H2;
                      END;
                  end;



                 X1A:=-(H2/2+H2*Costant^.C65);
                 Y1A:=B1/2;
                 X2A:=-(H2/2+H2*Costant^.C65);
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B2/2;
                 X4A:=0;
                 Y4A:=-B2/2;
              end;

          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=B2/2;
                     X2:=H1/2+H2*Costant^.C66;          Y2:=B2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-B2/2;
                     X2:=H1/2+H2*Costant^.C66;          Y2:=-B2/2;
                  end;
                 if (CodPezzo = '12RBT') or (CodPezzo = '12RAT') then
                  begin
                     DisPezzo^[1].X2:=H1/2+H2/2+H2/2*Costant^.C66;
                     DisPezzo^[2].X2:=H1/2+H2/2+H2/2*Costant^.C66;
                  end;
                 if Orient = 6 then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=H1/2;             Y2:=B1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-H1/2;            Y1:=-B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=H1/2;             Y1:=B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                      end;
                     if (CodPezzo = '12RBT') or (CodPezzo = '12RAT') then
                      with DisPezzo^[7] do
                       begin
                          Entita:='L';          TLinea:=2;
                          X1:=-H2/2;            Y1:=B2/2;
                          X2:=-H2/2;            Y2:=-B2/2;
                       end;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 Y3A:=B2/2;
                 Y4A:=-B2/2;

                 if (CodPezzo = '12RBT') or (CodPezzo = '12RAT') then
                  begin
                     X3A:=H1/2+H2/2+H2/2*Costant^.C66;
                     X4A:=H1/2+H2/2+H2/2*Costant^.C66;
                  end
                 else
                  begin
                     X3A:=H1/2+H2*Costant^.C66;
                     X4A:=H1/2+H2*Costant^.C66;
                  end;

              end;

       end;
 end;


Procedure D_11RBT;
var D:real;
 begin

box1(orient,b1,h1,(D2/2+D2*Costant^.C65)*2,0,0,0,0);
Cilindro1(orient,d2,B1/2+D2*Costant^.C66,0,-(B1/2+D2*Costant^.C66)/2,0,Pi/2);

       case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(D2/2+D2*Costant^.C65);         Y1:=-B1/2;
                     X2:=-(D2/2+D2*Costant^.C65);        Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(D2/2+D2*Costant^.C65);         Y1:=B1/2;
                     X2:=-(D2/2+D2*Costant^.C65);        Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(D2/2+D2*Costant^.C65);         Y1:=B1/2;
                     X2:=(D2/2+D2*Costant^.C65);         Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D2/2;            Y1:=-B1/2;
                     X2:=-D2/2;            Y2:=-B1/2-D2*Costant^.C66;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D2/2;             Y1:=-B1/2;
                     X2:=D2/2;             Y2:=-B1/2-D2*Costant^.C66;
                  end;

                 X1A:=-(D2/2+D2*Costant^.C65);
                 Y1A:=B1/2;
                 X2A:=-(D2/2+D2*Costant^.C65);
                 Y2A:=-B1/2;
                 if Orient = 1 then
                  begin
                     X3A:=D2/2;
                     Y3A:=-B1/2-D2*Costant^.C66;
                     X4A:=-D2/2;
                     Y4A:=-B1/2-D2*Costant^.C66;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=-D2/2;
                     Y3A:=B1/2+D2*Costant^.C66;
                     X4A:=D2/2;
                     Y4A:=B1/2+D2*Costant^.C66;
                  end;
              end;

          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(D2/2+D2*Costant^.C65);         Y1:=-B1/2;
                     X2:=-(D2/2+D2*Costant^.C65);        Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(D2/2+D2*Costant^.C65);         Y1:=B1/2;
                     X2:=-(D2/2+D2*Costant^.C65);        Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(D2/2+D2*Costant^.C65);         Y1:=B1/2;
                     X2:=(D2/2+D2*Costant^.C65);         Y2:=-B1/2;
                  end;
                 if Orient = 2 then
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='C';          TLinea:=2;
                         X1:=0;                Y1:=0;
                         R:=D2/2;
                      end;
                  end;


                 X1A:=-(D2/2+D2*Costant^.C65);
                 Y1A:=B1/2;
                 X2A:=-(D2/2+D2*Costant^.C65);
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;
              end;

          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=D2/2;
                     X2:=H1/2+D2*Costant^.C66;          Y2:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-D2/2;
                     X2:=H1/2+D2*Costant^.C66;          Y2:=-D2/2;
                  end;
                 if Orient = 6 then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=H1/2;             Y2:=B1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-H1/2;            Y1:=-B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=H1/2;             Y1:=B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                      end;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=H1/2+D2*Costant^.C66;
                 Y3A:=D2/2;
                 X4A:=H1/2+D2*Costant^.C66;
                 Y4A:=-D2/2;

              end;

       end;
 end;

Procedure D_11CBT;
var D,dP1,dp2,dp3,Dx:real;
    j:integer;
 begin
     if (CodPezzo='11CAT') or (CodPezzo='11CBT') then D3:=D2;
     if D2>D3 then Dx:=D2
      else Dx:=D3;
       case orient of
	  1,3:begin

		 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=-D2/2;            Y1:=-D1/2;
		     X2:=-D2/2;            Y2:=-D1/2-Dx*Costant^.C66;
                  end;
		 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=D2/2;             Y1:=-D1/2;
		     X2:=D2/2;             Y2:=-D1/2-Dx*Costant^.C66;
		  end;
		 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=(D2/2+Dx*Costant^.C65);            Y1:=-D1/2;
		     X2:=X1;                     Y2:=D1/2;
		  end;
		 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=-(D2/2+Dx*Costant^.C65);            Y1:=-D1/2;
		     X2:=-D2/2;            Y2:=-D1/2;
		  end;
		 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=(D2/2+Dx*Costant^.C65);            Y1:=-D1/2;
		     X2:=D2/2;            Y2:=-D1/2;
		  end;
		 with DisPezzo^[6] do
                  begin
		     Entita:='A';          TLinea:=1;
		     X1:=0;                Y1:=-D1/2;
                     if Orient=1 then
                      begin
   		         X2:=0;  Y2:=pi;
                      end
                     else
                      begin
                         X2:=pi;   Y2:=0;
                      end;
                     if D3 > D1 then R:=D1/2
		     else R:=D2/2;
		  end;
                 if (CodPezzo='11CAT') or (CodPezzo='11CBT') then
                  begin
                     with DisPezzo^[7] do
                      begin
                         Entita:='L';          TLinea:=1;
	                 X1:=-(D2/2+Dx*Costant^.C65);           Y1:=D1/2;
		         X2:=(D2/2+Dx*Costant^.C65);            Y2:=D1/2;
                      end;
		  end
                 else
                  begin
                     with DisPezzo^[7] do
                      begin
                         Entita:='L';          TLinea:=1;
	                 X1:=-(D2/2+Dx*Costant^.C65);            Y1:=D1/2;
		         X2:=-D3/2;            Y2:=D1/2;
                      end;
		     with DisPezzo^[8] do
                      begin
                         Entita:='L';          TLinea:=1;
		         X1:=(D2/2+Dx*Costant^.C65);            Y1:=D1/2;
		         X2:=D3/2;            Y2:=D1/2;
		      end;
		     with DisPezzo^[9] do
                      begin
		         Entita:='A';          TLinea:=1;
		         X1:=0;                Y1:=D1/2;
                         if Orient=1 then
                          begin
      	   	             X2:=pi;  Y2:=0;
                          end
                         else
                          begin
                             X2:=0;   Y2:=pi;
                          end;
                         if D3 > D1 then R:=D1/2
                         else R:=D3/2;
		      end;
                     with DisPezzo^[10] do
                      begin
                         Entita:='L';          TLinea:=1;
	     	         X1:=-D3/2;            Y1:=D1/2;
		         X2:=-D3/2;            Y2:=D1/2+Dx*Costant^.C66;
                      end;
      		     with DisPezzo^[11] do
                      begin
                         Entita:='L';          TLinea:=1;
		         X1:=D3/2;             Y1:=D1/2;
		         X2:=D3/2;             Y2:=D1/2+Dx*Costant^.C66;
		      end;
                  end;


		 X1A:=-(D2/2+Dx*Costant^.C65);
		 Y1A:=D1/2;
		 X2A:=-(D2/2+Dx*Costant^.C65);
		 Y2A:=-D1/2;
                 if Orient = 1 then
                  begin
                     X3A:=D2/2;
		     Y3A:=-D1/2-Dx*Costant^.C66;
                     X4A:=-D2/2;
		     Y4A:=-D1/2-Dx*Costant^.C66;
                     if (CodPezzo='14CAT') or (CodPezzo='14CBT') then
                      begin
                         X5A:=-D3/2;
 	                 Y5A:=D1/2+Dx*Costant^.C66;
                         X6A:=D3/2;
                         Y6A:=D1/2+Dx*Costant^.C66;
                      end;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=-D2/2;
		     Y3A:=D1/2+Dx*Costant^.C66;
                     X4A:=D2/2;
		     Y4A:=D1/2+Dx*Costant^.C66;
                     if (CodPezzo='14CAT') or (CodPezzo='14CBT') then
                      begin
                         X5A:=D3/2;
 	                 Y5A:=-D1/2-Dx*Costant^.C66;
                         X6A:=-D3/2;
                         Y6A:=-D1/2-Dx*Costant^.C66;
                      end;
                  end;
              end;

	  2,4:begin
		 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=-(D2/2+Dx*Costant^.C65);           Y1:=D1/2;
		     X2:=(D2/2+Dx*Costant^.C65);            Y2:=D1/2;
		  end;
		 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=-(D2/2+Dx*Costant^.C65);            Y1:=-D1/2;
		     X2:=(D2/2+Dx*Costant^.C65);            Y2:=-D1/2;
		  end;
		 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=(D2/2+Dx*Costant^.C65);            Y1:=-D1/2;
		     X2:=X1;                     Y2:=D1/2;
		  end;

                 if ((CodPezzo='14CAT') or (CodPezzo='14CBT')) and (D2<>D3) then
                  begin
		     with DisPezzo^[4] do
                      begin
                         Entita:='C';          TLinea:=2;
                         X1:=0;                Y1:=0;
                         if Orient = 2 then    R:=D2/2
                         else R:=D3/2;
                      end;
                  end
                 else
                  if Orient = 2 then
                   with DisPezzo^[4] do
                    begin
                       Entita:='C';          TLinea:=2;
                       X1:=0;                Y1:=0;
                       R:=D2/2;
                    end;


		 X1A:=-(D2/2+Dx*Costant^.C65);
		 Y1A:=D1/2;
		 X2A:=-(D2/2+Dx*Costant^.C65);
		 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;
                 if (CodPezzo='14CAT') or (CodPezzo='14CBT') then
                  begin
                     X5A:=0;
                     Y5A:=D3/2;
                     X6A:=0;
                     Y6A:=-D3/2;
                  end;

              end;

	  5,6:begin
(*                 Dp1:=D1/2;
                 writeln(' dp1 ',dp1:5:2);
                 dp2:=D2/2;
                 writeln(' dp2 ',dp2:5:2);
                 dp3:=dp1-dp2;
                 writeln(' dp3 ',dp3:5:2);
                 d:=sqrt(dp3); *)
                 if Abs(D1) > Abs(D2) then
                   D:=sqrt(sqr(D1/2)-sqr(D2/2))
                 else D:=D1;
                 j:=3;
		 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=D;                Y1:=D2/2;
		     X2:=D1/2+Dx*Costant^.C66;          Y2:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
		     X1:=D;                Y1:=-D2/2;
		     X2:=D1/2+Dx*Costant^.C66;          Y2:=-D2/2;
                  end;
                 if Orient = 6 then
                  begin
                     j:=j+1;
                     with DisPezzo^[3] do
                      begin
			 Entita:='C';          TLinea:=1;
			 X1:=0;                Y1:=0;
			 R:=D1/2;
                      end;
                  end;
                 if (CodPezzo='14CAT') or (CodPezzo='14CBT') then
                  begin
                     if Abs(D1) > Abs(D3) then
                       D:=sqrt(sqr(D1/2)-sqr(D3/2))
                     else D:=D1;
    		     with DisPezzo^[j] do
                      begin
                         Entita:='L';          TLinea:=1;
    	      	         X1:=-D;                      Y1:=D3/2;
		         X2:=-D1/2-Dx*Costant^.C66;    Y2:=D3/2;
                      end;
                     with DisPezzo^[J+1] do
                      begin
                         Entita:='L';          TLinea:=1;
		         X1:=-D;                      Y1:=-D3/2;
		         X2:=-D1/2-Dx*Costant^.C66;    Y2:=-D3/2;
                      end;
                  end;

                 X1A:=0;
		 Y1A:=D1/2;
                 X2A:=0;
		 Y2A:=-D1/2;
		 X3A:=D1/2+Dx*Costant^.C66;
                 Y3A:=D2/2;
		 X4A:=D1/2+Dx*Costant^.C66;
                 Y4A:=-D2/2;
                 if (CodPezzo='14CAT') or (CodPezzo='14CBT') then
                  begin
    		     X5A:=-D1/2-Dx*Costant^.C66;
                     Y5A:=-D3/2;
	   	     X6A:=-D1/2-Dx*Costant^.C66;
                     Y6A:=D3/2;
                  end;

              end;

       end;
 end;


END.