
unit U_10RA;

interface

Procedure D_10RA(Tipo:string);
Procedure D_11RA;
Procedure D_12RA;
{Procedure D_14RA;}
Procedure D_15RA;
Procedure D_15CB;

implementation


uses crt,dos,definiz,definizcan,U_VARPEZZI,interf3d;


Procedure D_10RA(Tipo:string);
 begin
   box1(orient,b1,h1,(b1/2+b3*Costant^.C15),0,0,0,0);
   box1(orient,b3,h3,(b1/2+b3*Costant^.C15),0,-(b1/2+b3*Costant^.C15)/2,0,pi/2);
   


       case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;            Y1:=-B1/2;
                     X2:=-B3/2;            Y2:=-B1/2-B3*Costant^.C15;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;             Y1:=-B1/2;
                     X2:=B3/2;             Y2:=-B1/2-B3*Costant^.C15;
                  end;
                 if Tipo='10RA' then
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-(B3/2+B3*Costant^.C14);          Y1:=B1/2;
                         X2:=B3/2+B3*Costant^.C14;               Y2:=B1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-(B3/2+B3*Costant^.C14);              Y1:=-B1/2;
                         X2:=B3/2+B3*Costant^.C14;               Y2:=-B1/2;
                      end;
                  end
                 else
                  begin
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-(B3/2+B3*Costant^.C14);          Y1:=B1/2;
                         X2:=B3/2+B3*Costant^.C14;             Y2:=B1/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-(B3/2+B3*Costant^.C14);          Y1:=-B1/2;
                         X2:=-B3/2;            Y2:=-B1/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=B3/2;             Y1:=-B1/2;
                         X2:=B3/2+B3*Costant^.C14;             Y2:=-B1/2;
                      end;
                  end;


                 X1A:=-(B3/2+B3*Costant^.C14);
                 Y1A:=B1/2;
                 X2A:=-(B3/2+B3*Costant^.C14);
                 Y2A:=-B1/2;
                 X3A:=B3/2+B3*Costant^.C14;
                 Y3A:=B1/2;
                 X4A:=B3/2+B3*Costant^.C14;
                 Y4A:=-B1/2;

                 if Orient=1 then
                  begin
                     X5A:=B3/2;
                     Y5A:=-B1/2-B3*Costant^.C15;
                     X6A:=-B3/2;
                     Y6A:=-B1/2-B3*Costant^.C15;
                  end
                 else
                  begin
                     Speculare:=true;
                     X5A:=-B3/2;
                     Y5A:=B1/2+B3*Costant^.C15;
                     X6A:=B3/2;
                     Y6A:=B1/2+B3*Costant^.C15;
                  end;

              end;

          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3/2+H3*Costant^.C14);              Y1:=B1/2;
                     X2:=H3/2+H3*Costant^.C14;               Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3/2+H3*Costant^.C14);              Y1:=-B1/2;
                     X2:=H3/2+H3*Costant^.C14;               Y2:=-B1/2;
                  end;

                 if Orient = 2 then
                  begin
                     if B3<>B1 then
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
{                     i:=5;
                     j:=2;
                     Spicchio(B3,H3,i,j);}
                  end;

                 X1A:=-(H3/2+H3*Costant^.C14);
                 Y1A:=B1/2;
                 X2A:=-(H3/2+H3*Costant^.C14);
                 Y2A:=-B1/2;
                 X3A:=H3/2+H3*Costant^.C14;
                 Y3A:=B1/2;
                 X4A:=H3/2+H3*Costant^.C14;
                 Y4A:=-B1/2;
                 X5A:=0;
                 Y5A:=B3/2;
                 X6A:=0;
                 Y6A:=-B3/2;
                 if Orient = 2 then Z3:=-H1/2-H3*Costant^.C15
                 else Z3:=H1/2+H3*Costant^.C15;
              end;
          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=B3/2;
                     X2:=H1/2+H3*Costant^.C15;          Y2:=B3/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-B3/2;
                     X2:=H1/2+H3*Costant^.C15;          Y2:=-B3/2;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;

                 X5A:=H1/2+H3*Costant^.C15;
                 Y5A:=B3/2;
                 X6A:=H1/2+H3*Costant^.C15;
                 Y6A:=-B3/2;

                 if Orient = 5 then
                  begin
                     Z1:=H3/2+H3*Costant^.C14;
                     Z2:=-(H3/2+H3*Costant^.C14);
                  end
                 else
                  begin
                     Z1:=-(H3/2+H3*Costant^.C14);
                     Z2:=H3/2+H3*Costant^.C14;
                  end;
              end;

       end;
 end;

procedure D_11RA;
 begin
    case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(D3/2+D3*Costant^.C14);              Y1:=B1/2;
                     X2:=D3/2+D3*Costant^.C14;               Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(D3/2+D3*Costant^.C14);              Y1:=-B1/2;
                     X2:=D3/2+D3*Costant^.C14;               Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-D3/2;            Y1:=-B1/2;
                     X2:=-D3/2;            Y2:=-B1/2-D3/2*Costant^.C15;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D3/2;             Y1:=-B1/2;
                     X2:=D3/2;             Y2:=-B1/2-D3/2*Costant^.C15;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y2;
                 X4A:=DisPezzo^[2].X2;
                 Y4A:=DisPezzo^[2].Y2;

                 if Orient=1 then
                  begin
                     X5A:=DisPezzo^[4].X2;
                     Y5A:=DisPezzo^[4].Y2;
                     X6A:=DisPezzo^[3].X2;
                     Y6A:=DisPezzo^[3].Y2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X5A:=DisPezzo^[3].X2;
                     Y5A:=-DisPezzo^[3].Y2;
                     X6A:=DisPezzo^[4].X2;
                     Y6A:=-DisPezzo^[4].Y2;
                  end;

              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(D3/2+D3*Costant^.C14);              Y1:=B1/2;
                     X2:=D3/2+D3*Costant^.C14;               Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(D3/2+D3*Costant^.C14);              Y1:=-B1/2;
                     X2:=D3/2+D3*Costant^.C14;               Y2:=-B1/2;
                  end;

                 if Orient = 2 then
                  with DisPezzo^[3] do
                   begin
                      Entita:='C';          TLinea:=2;
                      X1:=0;                Y1:=0;
                      R:=D3/2;
                   end;


                 X1A:=-(D3/2+D3*Costant^.C14);
                 Y1A:=B1/2;
                 X2A:=-(D3/2+D3*Costant^.C14);
                 Y2A:=-B1/2;
                 X3A:=D3/2+D3*Costant^.C14;
                 Y3A:=B1/2;
                 X4A:=D3/2+D3*Costant^.C14;
                 Y4A:=-B1/2;
                 X5A:=0;
                 Y5A:=D3/2;
                 X6A:=0;
                 Y6A:=-D3/2;
                 if Orient = 2 then Z3:=-H1/2-D3/2*Costant^.C15
                 else Z3:=H1/2+D3/2*Costant^.C15;
              end;
          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=D3/2;
                     X2:=H1/2+D3/2*Costant^.C15;        Y2:=D3/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-D3/2;
                     X2:=H1/2+D3/2*Costant^.C15;        Y2:=-D3/2;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;

                 X5A:=H1/2+D3/2*Costant^.C15;
                 Y5A:=D3/2;
                 X6A:=H1/2+D3/2*Costant^.C15;
                 Y6A:=-D3/2;

                 if Orient = 5 then
                  begin
                     Z1:=D3/2+D3*Costant^.C14;
                     Z2:=-(D3/2+D3*Costant^.C14);
                  end
                 else
                  begin
                     Z1:=-(D3/2+D3*Costant^.C14);
                     Z2:=D3/2+D3*Costant^.C14;
                  end;
              end;

       end;
    end;

Procedure D_12RA;

 Procedure I_14RA(Orient:integer);
  begin
     case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3+B3*Costant^.C14);              Y1:=B1/2;
                     X2:=B3/2+B3*Costant^.C14;               Y2:=B1/2-(B1-B2);
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3+B3*Costant^.C14);              Y1:=-B1/2;
                     X2:=B3/2+B3*Costant^.C14;               Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;            Y1:=-B1/2-B3/2;
                     X2:=-B3/2;            Y2:=-B1/2-B3/2-(B3/2)*Costant^.C15;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;             Y1:=-B1/2;
                     X2:=B3/2;             Y2:=-B1/2-B3/2-(B3/2)*Costant^.C15;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3;              Y1:=-B1/2;
                     X2:=-B3/2;            Y2:=-B1/2-B3/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;


                 if Orient=1 then
                  begin
                     X3A:=DisPezzo^[1].X2;
                     Y3A:=DisPezzo^[1].Y2;
                     X4A:=DisPezzo^[2].X2;
                     Y4A:=DisPezzo^[2].Y2;
                     X5A:=DisPezzo^[4].X2;
                     Y5A:=DisPezzo^[4].Y2;
                     X6A:=DisPezzo^[3].X2;
                     Y6A:=DisPezzo^[3].Y2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=DisPezzo^[2].X2;
                     Y3A:=-DisPezzo^[2].Y2;
                     X4A:=DisPezzo^[1].X2;
                     Y4A:=-DisPezzo^[1].Y2;
                     X5A:=DisPezzo^[3].X2;
                     Y5A:=-DisPezzo^[3].Y2;
                     X6A:=DisPezzo^[4].X2;
                     Y6A:=-DisPezzo^[4].Y2;
                  end;
              end;
     end;
  end;

 begin
       case orient of
          1,3:begin
                 if ((CodPezzo = '14RA') and (Orient in[1,3])) then I_14RA(Orient)
                 else
                  begin
                     with DisPezzo^[1] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-(B3+B3*Costant^.C14);              Y1:=B1/2;
                         X2:=B3/2+B3*Costant^.C14;               Y2:=B1/2;
                      end;
                     with DisPezzo^[2] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-(B3+B3*Costant^.C14);              Y1:=-B1/2;
                         X2:=B3/2+B3*Costant^.C14;               Y2:=-B1/2;
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B3/2;            Y1:=-B1/2-B3/2;
                         X2:=-B3/2;            Y2:=-B1/2-B3/2-(B3/2)*Costant^.C15;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=B3/2;             Y1:=-B1/2;
                         X2:=B3/2;             Y2:=-B1/2-B3/2-(B3/2)*Costant^.C15;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B3;              Y1:=-B1/2;
                         X2:=-B3/2;            Y2:=-B1/2-B3/2;
                      end;

                     X1A:=-(B3+B3*Costant^.C14);
                     Y1A:=B1/2;
                     X2A:=-(B3+B3*Costant^.C14);
                     Y2A:=-B1/2;
                     X3A:=B3/2+B3*Costant^.C14;
                     Y3A:=B1/2;
                     X4A:=B3/2+B3*Costant^.C14;
                     Y4A:=-B1/2;

                     if Orient=1 then
                      begin
                         X5A:=B3/2;
                         Y5A:=-B1/2-B3/2-(B3/2)*Costant^.C15;
                         X6A:=-B3/2;
                         Y6A:=-B1/2-B3/2-(B3/2)*Costant^.C15;
                      end
                     else
                      begin
                         Speculare:=true;
                         X5A:=-B3/2;
                         Y5A:=B1/2+B3/2+(B3/2)*Costant^.C15;
                         X6A:=B3/2;
                         Y6A:=B1/2+B3/2+(B3/2)*Costant^.C15;
                      end;
                  end;
              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3+H3*Costant^.C14);              Y1:=B1/2;
                     X2:=H3/2+H3*Costant^.C14;               Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(H3+H3*Costant^.C14);              Y1:=-B1/2;
                     X2:=H3/2+H3*Costant^.C14;               Y2:=-B1/2;
                  end;

                 if Orient = 2 then
                  begin
                     if B3<>B1 then
                      begin
                         with DisPezzo^[6] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H3;              Y1:=B3/2;
                             X2:=H3/2;             Y2:=B3/2;
                          end;
                         with DisPezzo^[7] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H3;              Y1:=-B3/2;
                             X2:=H3/2;             Y2:=-B3/2;
                          end;

{                         i:=8;
			 j:=2;
                         Spicchio(B3,H3,i,j);}
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
                         X2:=H3/2 ;             Y2:=-B3/2;
                      end;
                  end
                 else
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=-H3;               Y1:=B3/2;
                         X2:=-H3/2;             Y2:=B3/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';           TLinea:=1;
                         X1:=-H3;               Y1:=-B3/2;
                         X2:=-H3/2;             Y2:=-B3/2;
                      end;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';
                     if Orient=2 then TLinea:=2
                     else TLinea:=1;
                     X1:=-H3;               Y1:=B3/2;
                     X2:=-H3;               Y2:=-B3/2;
                  end;

                 X1A:=-(H3+H3*Costant^.C14);
                 Y1A:=B1/2;
                 X2A:=-(H3+H3*Costant^.C14);
                 Y2A:=-B1/2;
                 X3A:=H3/2+H3*Costant^.C14;
                 Y3A:=B1/2;
                 X4A:=H3/2+H3*Costant^.C14;
                 Y4A:=-B1/2;
                 X5A:=0;
                 Y5A:=B3/2;
                 X6A:=0;
                 Y6A:=-B3/2;
                 if Orient = 2 then Z3:=-H1/2-H3/2-(H3/2)*Costant^.C15
                 else Z3:=H1/2+H3/2+(H3/2)*Costant^.C15;
              end;
          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=B3/2;
                     X2:=H1/2+H3/2+(H3/2)*Costant^.C15;          Y2:=B3/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-B3/2;
                     X2:=H1/2+H3/2+(H3/2)*Costant^.C15;          Y2:=-B3/2;
                  end;
                 if Costant^.C15 <> 0 then
                  with DisPezzo^[3] do
                   begin
                      Entita:='L';
                      if Orient=5 then TLinea:=1
                      else TLinea:=2;
                      X1:=H1/2+H3/2;        Y1:=B3/2;
                      X2:=H1/2+H3/2;        Y2:=-B3/2;
                   end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;

                 X5A:=H1/2+H3/2+(H3/2)*Costant^.C15;
                 Y5A:=B3/2;
                 X6A:=H1/2+H3/2+(H3/2)*Costant^.C15;
                 Y6A:=-B3/2;

                 if Orient = 5 then
                  begin
                     Z1:=H3/2+H3*Costant^.C14;
                     Z2:=-(H3/2+H3*Costant^.C14);
                  end
                 else
                  begin
                     Z1:=-(H3/2+H3*Costant^.C14);
                     Z2:=H3/2+H3*Costant^.C14;
                  end;
              end;

       end;
 end;
(*
procedure D_14RA;
begin
   if (CodPezzo = '14RA') then
    begin
       case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B1;              Y1:=B1/2;
                     X2:=B1;               Y2:=B1/2-(B1-B2);
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B1;              Y1:=-B1/2;
                     X2:=B1;               Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;            Y1:=-B1/2-B3/2;
                     X2:=-B3/2;            Y2:=-B1/2-B3;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;             Y1:=-B1/2;
                     X2:=B3/2;             Y2:=-B1/2-B3;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3;              Y1:=-B1/2;
                     X2:=-B3/2;            Y2:=-B1/2-B3/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[2].X1;
                 Y2A:=DisPezzo^[2].Y1;


                 if Orient=1 then
                  begin
                     X3A:=DisPezzo^[1].X2;
                     Y3A:=DisPezzo^[1].Y2;
                     X4A:=DisPezzo^[2].X2;
                     Y4A:=DisPezzo^[2].Y2;
                     X5A:=DisPezzo^[4].X2;
                     Y5A:=DisPezzo^[4].Y2;
                     X6A:=DisPezzo^[3].X2;
                     Y6A:=DisPezzo^[3].Y2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=DisPezzo^[2].X2;
                     Y3A:=-DisPezzo^[2].Y2;
                     X4A:=DisPezzo^[1].X2;
                     Y4A:=-DisPezzo^[1].Y2;
                     X5A:=DisPezzo^[3].X2;
                     Y5A:=-DisPezzo^[3].Y2;
                     X6A:=DisPezzo^[4].X2;
                     Y6A:=-DisPezzo^[4].Y2;
                  end;

              end;


       end;
    end;
end;
*)
procedure D_15RA;
Var L:real;
 begin
    case orient of
          1,3:begin
                 if B2>B3 then  L:=B2*Costant^.C16
                 else L:=B3*Costant^.C16;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(L+B1/2);       Y1:=B1/2;
                     X2:=-(B4/2);          Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B4/2);          Y1:=B1/2;
                     X2:=-(B4/2);          Y2:=L+(B1/2);
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B4/2;             Y1:=L+(B1/2);
                     X2:=B4/2;             Y2:=B2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B4/2;             Y1:=B2/2;
                     X2:=L+(B1/2);        Y2:=B2/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=L+(B1/2);        Y1:=-(B2/2);
                     X2:=B3/2;             Y2:=-(B2/2);
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;             Y1:=-(B2/2);
                     X2:=B3/2;             Y2:=-(L+(B1/2));
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3/2);          Y1:=-(L+(B1/2));
                     X2:=-(B3/2);          Y2:=-(B1/2);
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(B3/2);          Y1:=-(B1/2);
                     X2:=-(L+(B1/2));     Y2:=-(B1/2);
                  end;

                 X1A:=-(L+(B1/2));
                 Y1A:=B1/2;
                 X2A:=-(L+(B1/2));
                 Y2A:=-B1/2;
                 X3A:=(L+(B1/2));
                 Y3A:=B2/2;
                 X4A:=(L+(B1/2));
                 Y4A:=-B2/2;
                 X5A:=B3/2;
                 Y5A:=-(L+(B1/2));
                 X6A:=-B3/2;
                 Y6A:=-(L+(B1/2));
                 X7A:=-B4/2;
                 Y7A:=(L+(B1/2));
                 X8A:=B4/2;
                 Y8A:=(L+(B1/2));
              end;
          2,4:begin
                 if H2>H3 then  L:=H2*Costant^.C16
                 else L:=H3*Costant^.C16;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(L+H1/2);       Y1:=B1/2;
                     X2:=L+H1/2;          Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(L+H1/2);       Y1:=-B1/2;
                     X2:=L+H1/2;          Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                   begin
                      Entita:='L';
                      if Orient=2 then  TLinea:=1
                      else TLinea:=2;
                      X1:=-H4/2;            Y1:=B1/2;
                      X2:=-H4/2;            Y2:=-B1/2;
                   end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';
                      if Orient=2 then  TLinea:=1
                      else TLinea:=2;
                     X1:=H4/2;             Y1:=B1/2;
                     X2:=H4/2;             Y2:=-B1/2;
                  end;


                 if H3<>H4 then
                  begin
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';
                         if Orient=2 then  TLinea:=2
                         else TLinea:=1;
                         X1:=-H3/2;            Y1:=B1/2;
                         X2:=-H3/2;            Y2:=-B1/2;
                      end;
                     with DisPezzo^[6] do
                      begin
                         Entita:='L';
                         if Orient=2 then  TLinea:=2
                         else TLinea:=1;
                         X1:=H3/2;             Y1:=B1/2;
                         X2:=H3/2;             Y2:=-B1/2;
                      end;
                  end;


                 X1A:=-(L+(H1/2));
                 Y1A:=B1/2;
                 X2A:=-(L+(H1/2));
                 Y2A:=-B1/2;
                 X3A:=L+(H1/2);
                 Y3A:=B1/2;
                 X4A:=L+(H1/2);
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
                     Z3:=-(L+H1/2);
                     Z4:=L+H1/2;
                  end
                 else
                  begin
                     Z3:=L+H1/2;
                     Z4:=-(L+H1/2);
                  end;
              end;
          5,6:begin
                 if H2>H3 then  L:=H2*Costant^.C16
                 else L:=H3*Costant^.C16;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(L+H1/2);       Y1:=B1/2;
                     X2:=L+H1/2;          Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(L+H1/2);       Y1:=-B1/2;
                     X2:=L+H1/2;          Y2:=-B1/2;
                  end;

                 if H1<>H2 then
                  begin
                     if Orient=6 then
                      begin
                         with DisPezzo^[3] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H1/2;            Y1:=B1/2;
                             X2:=-H1/2;            Y2:=-B1/2;
                          end;
                         with DisPezzo^[4] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=H1/2;             Y1:=B1/2;
                             X2:=H1/2;             Y2:=-B1/2;
                          end;
                      end
                     else
                      begin
                         with DisPezzo^[3] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H2/2;            Y1:=B1/2;
                             X2:=-H2/2;            Y2:=-B1/2;
                          end;
                         with DisPezzo^[4] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=H2/2;             Y1:=B1/2;
                             X2:=H2/2;             Y2:=-B1/2;
                          end;
                      end
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;
                 Y5A:=B1/2;
                 X5A:=L+(H1/2);
                 Y6A:=-B1/2;
                 X6A:=L+(H1/2);
                 Y7A:=-B1/2;
                 X7A:=-(L+(H1/2));
                 Y8A:=B1/2;
                 X8A:=-(L+(H1/2));

                 if Orient = 5 then
                  begin
                     Z1:=-(L+H1/2);
                     Z2:=L+H1/2;
                  end
                 else
                  begin
                     Z1:=L+H1/2;
                     Z2:=-(L+H1/2);
                  end;
              end;

       end;
 end;

procedure D_15CB;
Var L:real;
 begin
    if D2>D3 then  L:=D2*Costant^.C16
    else L:=D3*Costant^.C16;
    case orient of
          1,3:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(L+D1/2);       Y1:=D1/2;
                     X2:=-(D4/2);          Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(D4/2);          Y1:=D1/2;
                     X2:=-(D4/2);          Y2:=L+(D1/2);
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D4/2;             Y1:=L+(D1/2);
                     X2:=D4/2;             Y2:=D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D4/2;             Y1:=D1/2;
                     X2:=L+(D1/2);        Y2:=D2/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=L+(D1/2);        Y1:=-(D2/2);
                     X2:=D3/2;             Y2:=-(D1/2);
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=D3/2;             Y1:=-(D1/2);
                     X2:=D3/2;             Y2:=-(L+(D1/2));
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(D3/2);          Y1:=-(L+(D1/2));
                     X2:=-(D3/2);          Y2:=-(D1/2);
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(D3/2);          Y1:=-(D1/2);
                     X2:=-(L+(D1/2));     Y2:=-(D1/2);
                  end;

                 with DisPezzo^[9] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=0;                Y1:=-D1/2;
                     X2:=0;                Y2:=pi;
                     R:=D3/2;
                  end;
                 with DisPezzo^[10] do
                  begin
                     Entita:='A';          TLinea:=1;
                     X1:=0;                Y1:=D1/2;
                     X2:=pi;               Y2:=0;
                     R:=D4/2;
                  end;


                 X1A:=-(L+(D1/2));
                 Y1A:=D1/2;
                 X2A:=-(L+(D1/2));
                 Y2A:=-D1/2;
                 X3A:=(L+(D1/2));
                 Y3A:=D2/2;
                 X4A:=(L+(D1/2));
                 Y4A:=-D2/2;
                 X5A:=D3/2;
                 Y5A:=-(L+(D1/2));
                 X6A:=-D3/2;
                 Y6A:=-(L+(D1/2));
                 X7A:=-D4/2;
                 Y7A:=(L+(D1/2));
                 X8A:=D4/2;
                 Y8A:=(L+(D1/2));
              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(L+D1/2);       Y1:=D1/2;
                     if D3>D4 then X2:=D3/2
                     else X2:=D4/2;
                     Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-(L+D1/2);       Y1:=-D1/2;
                     X2:=DisPezzo^[1].X2;   Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=D1/2;
                     X2:=D1+D1/2;          Y2:=D2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=-D1/2;
                     X2:=D1+D1/2;          Y2:=-D2/2;
                  end;

                 X1A:=-(L+(D1/2));
                 Y1A:=D1/2;
                 X2A:=-(L+(D1/2));
                 Y2A:=-D1/2;
                 X3A:=(L+(D1/2));
                 Y3A:=D2/2;
                 X4A:=(L+(D1/2));
                 Y4A:=-D2/2;

                 if Orient=2 then
                  begin
                     X5A:=0;
                     Y5A:=D3/2;
                     X6A:=0;
                     Y6A:=-D3/2;
                     X7A:=0;
                     Y7A:=D4/2;
                     X8A:=0;
                     Y8A:=-D4/2;
                  end
                 else
                  begin
                     X5A:=0;
                     Y5A:=D4/2;
                     X6A:=0;
                     Y6A:=-D4/2;
                     X7A:=0;
                     Y7A:=D3/2;
                     X8A:=0;
                     Y8A:=-D3/2;
                  end;
                 if Orient = 2 then
                  begin
                     Z3:=-(L+D1/2);
                     Z4:=L+D1/2;
                  end
                 else
                  begin
                     Z3:=L+D1/2;
                     Z4:=-(L+D1/2);
                  end;
              end;
          5,6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=D3/2;             X1:=-(L+D1/2);
                     Y2:=D1/2;             X2:=0;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=-D3/2;            X1:=-(L+D1/2);
                     Y2:=-D1/2;            X2:=0;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=D4/2;             X1:=L+D1/2;
                     Y2:=D1/2;             X2:=0;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     Y1:=-D4/2;            X1:=L+D1/2;
                     Y2:=-D1/2;            X2:=0;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='C';          TLinea:=2;
                     Y1:=0;                X1:=0;
                     if Orient=5 then  R:=D2/2
                     else R:=D1/2;
                  end;

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;
                 Y5A:=D3/2;
                 X5A:=L+D1/2;
                 Y6A:=-D3/2;
                 X6A:=L+D1/2;
                 Y7A:=-D4/2;
                 X7A:=-(L+D1/2);
                 Y8A:=D4/2;
                 X8A:=-(L+D1/2);
                 if Orient = 5 then
                  begin
                     Z1:=-(L+D1/2);
                     Z2:=L+D1/2;
                  end
                 else
                  begin
                     Z1:=L+D1/2;
                     Z2:=-(L+D1/2);
                  end;
              end;

       end;
 end;

end.

(*
                i:=1;

                FrecciaU((H1/2+B1*0.3),0,B1*0.7,0,i);

                for i:=4 to 6 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-3].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-3].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,H1/2-B1/2,pi/2);
                    DisPezzo^[i].X2:=DisPezzo^[i-3].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-3].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,H1/2-B1/2,pi/2);
                 end;

                for i:=7 to 9 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-6].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-6].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,0,pi);
                    DisPezzo^[i].X2:=DisPezzo^[i-6].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-6].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,0,pi);
                 end;

                for i:=10 to 12 do
                 begin
                    DisPezzo^[i].Entita:='L';
                    DisPezzo^[i].TLinea:=1;
                    DisPezzo^[i].X1:=DisPezzo^[i-9].X1;
                    DisPezzo^[i].Y1:=DisPezzo^[i-9].Y1;
                    ModiCord(DisPezzo^[i].X1,DisPezzo^[i].Y1,0,B1/2-H1/2,-pi/2);
                    DisPezzo^[i].X2:=DisPezzo^[i-9].X2;
                    DisPezzo^[i].Y2:=DisPezzo^[i-9].Y2;
                    ModiCord(DisPezzo^[i].X2,DisPezzo^[i].Y2,0,B1/2-H1/2,-pi/2);
                 end;

                if orient = 6 then
                 begin
                    with DisPezzo^[13] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-H1/2;            Y1:=B1/2;
                        X2:=H1/2;             Y2:=B1/2;
                     end;
                    with DisPezzo^[14] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=H1/2;             Y1:=B1/2;
                        X2:=H1/2;             Y2:=-B1/2;
                     end;
                    with DisPezzo^[15] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=H1/2;             Y1:=-B1/2;
                        X2:=-H1/2;            Y2:=-B1/2;
                     end;
                    with DisPezzo^[16] do
                     begin
                        Entita:='L';          TLinea:=1;
                        X1:=-H1/2;            Y1:=-B1/2;
                        X2:=-H1/2;            Y2:=B1/2;
                     end;

                    i:=i+1;
                    j:=1;
                    Spicchio(B1,H1,i,j);

                 end;

*)
