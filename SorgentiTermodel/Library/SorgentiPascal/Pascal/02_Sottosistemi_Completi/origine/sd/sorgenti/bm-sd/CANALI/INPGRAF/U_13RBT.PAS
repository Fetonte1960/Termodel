{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit U_13RBT;

interface

Procedure D_13RBT;


implementation


uses crt,dos,definiz,U_VARPEZZI;



Procedure D_13RBT;
var B,H:real;
    j:integer;
 begin
    if (CodPezzo='13RAC') or (CodPezzo='13RBC') then
     begin
        B2:=D2; B3:=D3; H2:=D2; H3:=D3;
     end;
    if (CodPezzo='13CAT') or (CodPezzo='13CBT') then
     begin
        B1:=D1; H1:=D1;
     end;

       case orient of
          1,3:begin
                 if B3 > B2 then B:=B3
                  else B:=B2;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B/2+B*Costant^.C65);    Y1:=-B1/2;
                     X2:=-(B/2+B*Costant^.C65);   Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B/2+B*Costant^.C65);     Y1:=B1/2;
                     X2:=-(B/2+B*Costant^.C65);    Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B/2+B*Costant^.C65);     Y1:=B1/2;
                     X2:=(B/2+B*Costant^.C65);     Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B2/2;   Y1:=-B1/2;
                     X2:=-B2/2;   Y2:=-B1/2-B*Costant^.C66;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B2/2;    Y1:=-B1/2;
                     X2:=B2/2;    Y2:=-B1/2-B*Costant^.C66;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;   Y1:=B1/2;
                     X2:=-B3/2;   Y2:=B1/2+B*Costant^.C66;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;    Y1:=B1/2;
                     X2:=B3/2;    Y2:=B1/2+B*Costant^.C66;
                  end;

                 if (CodPezzo='14RAT') or (CodPezzo='14RBT') then
                  begin
                     DisPezzo^[4].Y1:=-B1/2-B2/2;
                     DisPezzo^[4].Y2:=-B1/2-B/2-B/2*Costant^.C66;
                     DisPezzo^[5].Y2:=-B1/2-B/2-B/2*Costant^.C66;
                     DisPezzo^[6].Y1:=B1/2+B3/2;
                     DisPezzo^[6].Y2:=B1/2+B/2+B/2*Costant^.C66;
                     DisPezzo^[7].Y2:=B1/2+B/2+B/2*Costant^.C66;
                     with DisPezzo^[8] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B2;              Y1:=-B1/2;
                         X2:=-B2/2;            Y2:=-B1/2-B2/2;
                      end;
                     with DisPezzo^[9] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B3;              Y1:=B1/2;
                         X2:=-B3/2;            Y2:=B1/2+B3/2;
                      end;
                  end;


                 X1A:=-(B/2+B*Costant^.C65);
                 Y1A:=B1/2;
                 X2A:=-(B/2+B*Costant^.C65);
                 Y2A:=-B1/2;
                 if Orient = 1 then
                  begin
                     X3A:=B2/2;
                     X4A:=-B2/2;
                     X5A:=-B3/2;
                     X6A:=B3/2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=B3/2;
                     X4A:=-B3/2;
                     X5A:=-B2/2;
                     X6A:=B2/2;
                  end;

                 Y3A:=DisPezzo^[4].Y2;
                 Y4A:=DisPezzo^[4].Y2;
                 Y5A:=DisPezzo^[6].Y2;
                 Y6A:=DisPezzo^[6].Y2;
              end;

          2,4:begin
                 if H3 > H2 then H:=H3
                  else H:=H2;

                 if Orient = 2 then B:=B2
                 else B:=B3;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H/2+H*Costant^.C65);    Y1:=-B1/2;
                     X2:=-(H/2+H*Costant^.C65);   Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H/2+H*Costant^.C65);     Y1:=B1/2;
                     X2:=-(H/2+H*Costant^.C65);    Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H/2+H*Costant^.C65);     Y1:=B1/2;
                     X2:=(H/2+H*Costant^.C65);     Y2:=-B1/2;
                  end;

                 if (CodPezzo='13RAC') or (CodPezzo='13RBC') then
                  begin
                     with DisPezzo^[4] do
                      begin
                         Entita:='C';          TLinea:=1;
                         X1:=0;                Y1:=0;
                         R:=B/2;
                      end;
                  end
                 else
                  begin
                     if B<>B1 then
                      begin
                         with DisPezzo^[7] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H/2;            Y1:=B/2;
                             X2:=H/2;             Y2:=B/2;
                          end;
                         with DisPezzo^[8] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H/2;            Y1:=-B/2;
                             X2:=H/2;             Y2:=-B/2;
                          end;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=-H/2;             Y1:=B/2;
                         X2:=-H/2;             Y2:=-B/2;
                      end;
                     with DisPezzo^[5] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=H/2;              Y1:=B/2;
                         X2:=H/2 ;             Y2:=-B/2;
                      end;
                     if (CodPezzo='14RAT') or (CodPezzo='14RBT') then
                      begin
                         with DisPezzo^[6] do
                          begin
                             Entita:='L';           TLinea:=2;
                             X1:=-H;                Y1:=B/2;
                             X2:=-H;                Y2:=-B/2;
                          end;
                         DisPezzo^[7].X1:=-H;
                         DisPezzo^[8].X1:=-H;
                      end;
                   end;


                 X1A:=-(H/2+H*Costant^.C65);
                 Y1A:=B1/2;
                 X2A:=-(H/2+H*Costant^.C65);
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B2/2;
                 X4A:=0;
                 Y4A:=-B2/2;
                 X5A:=0;
                 Y5A:=B3/2;
                 X6A:=0;
                 Y6A:=-B3/2;
(*                 if Orient = 2 then
                  begin
                     Z2:=-(H1/2+H*Costant^.C66);
                     Z3:=H1/2+H*Costant^.C66;
                  end
                 else
                  begin
                     Z2:=H1/2+H*Costant^.C66;
                     Z3:=-(H1/2+H*Costant^.C66);
                  end; *)
              end;

          5,6:begin
                 J:=5;
                 if H3 > H2 then H:=H3
                  else H:=H2;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=H1/2;               Y1:=B2/2;
                     X2:=H1/2+H*Costant^.C66; Y2:=B2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=H1/2;               Y1:=-B2/2;
                     X2:=H1/2+H*Costant^.C66; Y2:=-B2/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-H1/2;               Y1:=B3/2;
                     X2:=-H1/2-H*Costant^.C66; Y2:=B3/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-H1/2;               Y1:=-B3/2;
                     X2:=-H1/2-H*Costant^.C66; Y2:=-B3/2;
                  end;
                 if (CodPezzo='14RAT') or (CodPezzo='14RBT') then
                  begin
                     DisPezzo^[1].X2:=H1/2+H/2+H/2*Costant^.C66;
                     DisPezzo^[2].X2:=H1/2+H/2+H/2*Costant^.C66;
                     DisPezzo^[3].X2:=-H1/2-H/2-H/2*Costant^.C66;
                     DisPezzo^[4].X2:=-H1/2-H/2-H/2*Costant^.C66;
                  end;
                 if Orient = 6 then
                  begin
                     if (CodPezzo='13CAT') or (CodPezzo='13CBT') then
                      begin
                         with DisPezzo^[5] do
                          begin
                             Entita:='C';          TLinea:=1;
                             X1:=0;                Y1:=0;
                             R:=B1/2;
                          end;
                         j:=6;
                      end
                     else
                      begin
                         with DisPezzo^[5] do
                          begin
                             Entita:='L';          TLinea:=1;
                             X1:=-H1/2;            Y1:=B1/2;
                             X2:=H1/2;             Y2:=B1/2;
                          end;
                         with DisPezzo^[6] do
                          begin
                             Entita:='L';          TLinea:=1;
                             X1:=-H1/2;            Y1:=-B1/2;
                             X2:=H1/2;             Y2:=-B1/2;
                          end;
                         with DisPezzo^[7] do
                          begin
                             Entita:='L';          TLinea:=1;
                             X1:=H1/2;             Y1:=B1/2;
                             X2:=H1/2;             Y2:=-B1/2;
                          end;
                         with DisPezzo^[8] do
                          begin
                             Entita:='L';          TLinea:=1;
                             X1:=-H1/2;            Y1:=B1/2;
                             X2:=-H1/2;            Y2:=-B1/2;
                          end;
                         j:=9;
                      end;
                  end;


                 if (CodPezzo='14RAT') or (CodPezzo='14RBT') then
                  begin
                     with DisPezzo^[j] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H1/2+H2/2;        Y1:=B2/2;
                         X2:=H1/2+H2/2;        Y2:=-B2/2;
                      end;
                     with DisPezzo^[j+1] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H1/2-H3/2;       Y1:=B3/2;
                         X2:=-H1/2-H3/2;       Y2:=-B3/2;
                      end;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;

                 X3A:=DisPezzo^[1].X2;
                 X4A:=DisPezzo^[1].X2;
                 X5A:=DisPezzo^[3].X2;
                 X6A:=DisPezzo^[3].X2;
                 Y3A:=B2/2;
                 Y4A:=-B2/2;
                 Y5A:=B3/2;
                 Y6A:=-B3/2;

(*                 if Orient = 5 then Z1:=H/2+H*Costant^.C65
                 else Z1:=-(H/2+H*Costant^.C65); *)
              end;

       end;
 end;


END.