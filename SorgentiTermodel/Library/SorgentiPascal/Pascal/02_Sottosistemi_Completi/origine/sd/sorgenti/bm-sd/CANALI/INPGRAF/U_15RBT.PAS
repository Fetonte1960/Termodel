{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit U_15RBT;

interface

Procedure D_15RBT;


implementation


uses crt,dos,definiz,U_VARPEZZI;



Procedure D_15RBT;
var B,H:real;
    j:integer;
 begin
    if (CodPezzo='15RAT') or (CodPezzo='15RBT') or
       (CodPezzo='16RAT') or (CodPezzo='16RBT') then
     begin
        B2:=B4; B3:=B3; H2:=H3; H3:=H4;
     end;
    if (CodPezzo='15RAC') or (CodPezzo='15RBC') then
     begin
        B2:=D3; B3:=D4; H2:=D3; H3:=D4;
     end;
    if (CodPezzo='15CAT') or (CodPezzo='15CBT') then
     begin
        B1:=D1; H1:=D1;
        B2:=B3; B3:=B4; H2:=H3; H3:=H4;
     end;

       case orient of
          1,3:begin
                 if B3 > B2 then B:=B3
                  else B:=B2;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B/2+B*Costant^.C32);        Y1:=-B1/2;
                     X2:=-(B/2+B*Costant^.C32);       Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(B/2+B*Costant^.C32);        Y1:=B1/2;
                     X2:=-(B/2+B*Costant^.C32);       Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B2/2;             Y1:=-B1/2;
                     X2:=-B2/2;             Y2:=-B1/2-B*Costant^.C33;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B2/2;             Y1:=-B1/2;
                     X2:=B2/2;             Y2:=-B1/2-B*Costant^.C33;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-B3/2;             Y1:=B1/2;
                     X2:=-B3/2;             Y2:=B1/2+B*Costant^.C33;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=B3/2;             Y1:=B1/2;
                     X2:=B3/2;             Y2:=B1/2+B*Costant^.C33;
                  end;

                 if (CodPezzo='16RAT') or (CodPezzo='16RBT') then
                  begin
                     DisPezzo^[3].Y1:=-B1/2-B2/2;
                     DisPezzo^[3].Y2:=-B1/2-B/2-B/2*Costant^.C33;
                     DisPezzo^[4].Y2:=-B1/2-B/2-B/2*Costant^.C33;
                     DisPezzo^[5].Y1:=B1/2+B3/2;
                     DisPezzo^[5].Y2:=B1/2+B/2+B/2*Costant^.C33;
                     DisPezzo^[6].Y2:=B1/2+B/2+B/2*Costant^.C33;

                     with DisPezzo^[7] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B2;              Y1:=-B1/2;
                         X2:=-B2/2;            Y2:=-B1/2-B2/2;
                      end;
                     with DisPezzo^[8] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-B3;              Y1:=B1/2;
                         X2:=-B3/2;            Y2:=B1/2+B3/2;
                      end;
                  end;


                 X1A:=-(B/2+B*Costant^.C32);
                 Y1A:=B1/2;
                 X2A:=-(B/2+B*Costant^.C32);
                 Y2A:=-B1/2;
                 X3A:=(B/2+B*Costant^.C32);
                 Y3A:=B1/2;
                 X4A:=(B/2+B*Costant^.C32);
                 Y4A:=-B1/2;
                 X5A:=B3/2;
                 X6A:=-B3/2;
                 X7A:=-B2/2;
                 X8A:=B2/2;
                 Y3A:=B1/2;
                 Y4A:=-B1/2;
                 Y5A:=DisPezzo^[3].Y2;
                 Y6A:=DisPezzo^[3].Y2;
                 Y7A:=DisPezzo^[5].Y2;
                 Y8A:=DisPezzo^[5].Y2;
                 Speculare:=true;
              end;

          2,4:begin
                 j:=4;
                 if H3 > H2 then H:=H3
                  else H:=H2;

                 if Orient = 2 then B:=B2
                 else B:=B3;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H/2+H*Costant^.C32);        Y1:=-B1/2;
                     X2:=-(H/2+H*Costant^.C32);       Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=(H/2+H*Costant^.C32);        Y1:=B1/2;
                     X2:=-(H/2+H*Costant^.C32);       Y2:=B1/2;
                  end;
                 if (CodPezzo='15RAC') or (CodPezzo='15RBC') then
                  begin
                     with DisPezzo^[3] do
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
                         with DisPezzo^[5] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H/2;            Y1:=B/2;
                             X2:=H/2;             Y2:=B/2;
                          end;
                         with DisPezzo^[6] do
                          begin
                             Entita:='L';          TLinea:=2;
                             X1:=-H/2;            Y1:=-B/2;
                             X2:=H/2;             Y2:=-B/2;
                          end;
                         if (CodPezzo='16RAT') or (CodPezzo='16RBT') then
                          begin
                             DisPezzo^[5].X1:=-H;
                             DisPezzo^[6].X1:=-H;
                          end;
                         j:=6;
                      end;
                     with DisPezzo^[3] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=-H/2;             Y1:=B/2;
                         X2:=-H/2;             Y2:=-B/2;
                      end;
                     with DisPezzo^[4] do
                      begin
                         Entita:='L';           TLinea:=2;
                         X1:=H/2;              Y1:=B/2;
                         X2:=H/2 ;             Y2:=-B/2;
                      end;
                     if (CodPezzo='16RAT') or (CodPezzo='16RBT') then
                      with DisPezzo^[j+1] do
                       begin
                          Entita:='L';           TLinea:=2;
                          X1:=-H;                Y1:=B/2;
                          X2:=-H;                Y2:=-B/2;
                       end;
                  end;


                 X1A:=-(H/2+H*Costant^.C32);
                 Y1A:=B1/2;
                 X2A:=-(H/2+H*Costant^.C32);
                 Y2A:=-B1/2;
                 X3A:=(H/2+H*Costant^.C32);
                 Y3A:=B1/2;
                 X4A:=(H/2+H*Costant^.C32);
                 Y4A:=-B1/2;
                 X5A:=0;
                 Y5A:=B2/2;
                 X6A:=0;
                 Y6A:=-B2/2;
                 X7A:=0;
                 Y7A:=B3/2;
                 X8A:=0;
                 Y8A:=-B3/2;

                 if Orient = 2 then
                  begin
                     Z3:=-(H1/2+H*Costant^.C33);
                     Z4:=H1/2+H*Costant^.C33;
                  end
                 else
                  begin
                     Z3:=H1/2+H*Costant^.C33;
                     Z4:=-(H1/2+H*Costant^.C33);
                  end;

              end;

          5,6:begin
                 J:=5;
                 if H3 > H2 then H:=H3
                  else H:=H2;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=H1/2;               Y1:=B2/2;
                     X2:=H1/2+H*Costant^.C33; Y2:=B2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';            TLinea:=1;
                     X1:=H1/2;               Y1:=-B2/2;
                     X2:=H1/2+H*Costant^.C33; Y2:=-B2/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-H1/2;               Y1:=B3/2;
                     X2:=-H1/2-H*Costant^.C33; Y2:=B3/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-H1/2;               Y1:=-B3/2;
                     X2:=-H1/2-H*Costant^.C33; Y2:=-B3/2;
                  end;
                 if (CodPezzo='16RAT') or (CodPezzo='16RBT') then
                  begin
                     DisPezzo^[1].X2:=H1/2+H/2+H/2*Costant^.C33;
                     DisPezzo^[2].X2:=H1/2+H/2+H/2*Costant^.C33;
                     DisPezzo^[3].X2:=-H1/2-H/2-H/2*Costant^.C33;
                     DisPezzo^[4].X2:=-H1/2-H/2-H/2*Costant^.C33;
                  end;
                 if Orient = 6 then
                  begin
                     if (CodPezzo='15CAT') or (CodPezzo='15CBT') then
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


                 if (CodPezzo='16RAT') or (CodPezzo='16RBT') then
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
                 X3A:=0;
                 X4A:=0;
                 X5A:=DisPezzo^[1].X2;
                 X6A:=DisPezzo^[1].X2;
                 X7A:=DisPezzo^[3].X2;
                 X8A:=DisPezzo^[3].X2;
                 Y3A:=B1/2;
                 Y4A:=-B1/2;
                 Y5A:=B2/2;
                 Y6A:=-B2/2;
                 Y7A:=B3/2;
                 Y8A:=-B3/2;

              end;

       end;
 end;


END.