{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit U_180R;

interface

Procedure D_180R;
Procedure D_19CR;
Procedure D_19ER;
Procedure D_200R;
Procedure D_220R;
Procedure D_230R;
Procedure D_24TR;
Procedure D_382;

implementation


uses crt,dos,definiz,U_VARPEZZI;



Procedure D_180R;
var Lato,Larg:real;
 begin
       case orient of

        1,3,2,4:begin

                 if CodPezzo='180R' then
                  begin
                     if Lung <> 0 then Larg:=Lung*2
                     else Larg:=B1*Costant^.C46;
                     Lato:=B1
                  end
                 else
                  begin
                     if Lung <> 0 then Larg:=Lung*2
                     else Larg:=D1*Costant^.C46;
                     Lato:=D1;
                  end;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;          Y1:=Lato/2;
                     X2:=-Larg/8;          Y2:=Lato/2-Lato*0.05*Costant^.C37;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/8;          Y1:=DisPezzo^[1].Y2;
                     X2:=0;                Y2:=Lato/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=0;                Y1:=Lato/2;
                     X2:=Larg/8;           Y2:=DisPezzo^[1].Y2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Larg/8;           Y1:=DisPezzo^[1].Y2;
                     X2:=Larg/4;           Y2:=Lato/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;          Y1:=-Lato/2;
                     X2:=-Larg/8;          Y2:=-Lato/2+Lato*0.05*Costant^.C37;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/8;          Y1:=DisPezzo^[5].Y2;
                     X2:=0;                Y2:=-Lato/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=0;                Y1:=-Lato/2;
                     X2:=Larg/8;           Y2:=DisPezzo^[5].Y2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Larg/8;           Y1:=DisPezzo^[5].Y2;
                     X2:=Larg/4;           Y2:=-Lato/2;
                  end;
                 with DisPezzo^[9] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=DisPezzo^[1].Y2;
                     X2:=X1;               Y2:=DisPezzo^[5].Y2;
                  end;
                 with DisPezzo^[10] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[2].X2;   Y1:=DisPezzo^[1].Y1;
                     X2:=X1;               Y2:=DisPezzo^[5].Y1;
                  end;
                 with DisPezzo^[11] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].X2;   Y1:=DisPezzo^[1].Y2;
                     X2:=X1;               Y2:=DisPezzo^[5].Y2;
                  end;

                 X1A:=-Larg/4;
                 Y1A:=Lato/2;
                 X2A:=-Larg/4;
                 Y2A:=-Lato/2;
                 X3A:=Larg/4;
                 Y3A:=Lato/2;
                 X4A:=Larg/4;
                 Y4A:=-Lato/2;

              end;
       end;
 end;


Procedure D_19CR;
var Lato:real;
 begin
       case orient of

        1,3,2,4:begin
                 if Lung <> 0 then Lato:=Lung*2
                  else Lato:=B1*Costant^.C49;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lato/4;            Y1:=B1/2;
                     X2:=Lato/4;             Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lato/4;            Y1:=-B1/2;
                     X2:=Lato/4;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=Lato/6*Costant^.C38;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[3].R*0.8;    Y1:=0;
                     X2:=-X1;              Y2:=0;
                  end;
                 if CodPezzo = '19CR' then
                  with DisPezzo^[5] do
                   begin
                      Entita:='L';          TLinea:=1;
                      X1:=0;                Y1:=DisPezzo^[4].X1;
                      X2:=0;                Y2:=-Y1;
                   end;

                 X1A:=-Lato/4;
                 Y1A:=B1/2;
                 X2A:=-Lato/4;
                 Y2A:=-B1/2;
                 X3A:=Lato/4;
                 Y3A:=B1/2;
                 X4A:=Lato/4;
                 Y4A:=-B1/2;

              end;
       end;
 end;


Procedure D_19ER;
var Lato:real;
 begin
       case orient of

        1,3,2,4:begin
                 if Lung <> 0 then Lato:=Lung*2
                 else Lato:=B1*Costant^.C49;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lato/4;            Y1:=B1/2;
                     X2:=Lato/4;             Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lato/4;            Y1:=-B1/2;
                     X2:=Lato/4;             Y2:=-B1/2;
                  end;

                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=0;                Y1:=B1/2*0.1;
                     X2:=0;                Y2:=-B1/2*0.1;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=0;                Y1:=-B1/2*0.1;
                     X2:=Lato/4*0.7;         Y2:=B1/2*0.4;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=0;                Y1:=B1/2*0.1;
                     X2:=-Lato/4*0.7;        Y2:=-B1/2*0.4;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Lato/4*0.7;         Y1:=B1/2*0.4;
                     X2:=X1-2;             Y2:=Y1-15;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Lato/4*0.7;         Y1:=B1/2*0.4;
                     X2:=X1-15;            Y2:=Y1-6;
                  end;




                 X1A:=-Lato/4;
                 Y1A:=B1/2;
                 X2A:=-Lato/4;
                 Y2A:=-B1/2;
                 X3A:=Lato/4;
                 Y3A:=B1/2;
                 X4A:=Lato/4;
                 Y4A:=-B1/2;

              end;
       end;
 end;


Procedure D_200R;
var Lato:real;
 begin
       case orient of

        1,3,2,4:begin
                 if Lung <> 0 then Lato:=Lung*2
                 else Lato:=B1*Costant^.C50;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lato/4;            Y1:=B1/2;
                     X2:=Lato/4;             Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lato/4;            Y1:=-B1/2;
                     X2:=Lato/4;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Lato/4;             Y1:=B1/2;
                     X2:=-Lato/4;            Y2:=B1/4;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lato/4;            Y1:=B1/4;
                     X2:=Lato/4;             Y2:=0;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=Lato/4;             Y1:=0;
                     X2:=-Lato/4;            Y2:=-B1/4;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lato/4;            Y1:=-B1/4;
                     X2:=Lato/4;             Y2:=-B1/2;
                  end;



                 X1A:=-Lato/4;
                 Y1A:=B1/2;
                 X2A:=-Lato/4;
                 Y2A:=-B1/2;
                 X3A:=Lato/4;
                 Y3A:=B1/2;
                 X4A:=Lato/4;
                 Y4A:=-B1/2;

              end;
       end;
 end;

Procedure D_220R;
var Larg:real;
 begin
       case orient of

        1,3,2,4:begin
                 if Lung <> 0 then Larg:=Lung/2
                 else Larg:=B1/2*1.2*Costant^.C42;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg;
                     Y1:=B1/2*1.2*Costant^.C42;
                     X2:=Larg;              Y2:=Y1;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-B1/2*1.2*Costant^.C42;
                     X2:=-X1;              Y2:=Y1;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=DisPezzo^[1].Y1;
                     X2:=X1;               Y2:=B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X1;   Y1:=-B1/2;
                     X2:=X1;               Y2:=DisPezzo^[2].Y1;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=DisPezzo^[1].Y1;
                     X2:=X1;               Y2:=B1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=DisPezzo^[1].X2;   Y1:=-B1/2;
                     X2:=X1;               Y2:=DisPezzo^[2].Y1;
                  end;


                 X1A:=DisPezzo^[1].X1;
                 Y1A:=B1/2;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=-B1/2;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=B1/2;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=-B1/2;

              end;
       end;
 end;


Procedure D_230R;
 var Lato,Larg:real;
 begin
    if (CodPezzo='230R') or (CodPezzo='210R') or (CodPezzo='388R') then
     begin
       if Lung <> 0 then Larg:=Lung*2
        else Larg:=B1*Costant^.C51;
       Lato:=B1;
     end
    else
     begin
        if Lung <> 0 then Larg:=Lung*2
        else Larg:=D1*Costant^.C51;
        Lato:=D1;
     end;
       case orient of

        1,3,2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;            Y1:=Lato/2;
                     X2:=Larg/4;             Y2:=Lato/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;            Y1:=-Lato/2;
                     X2:=Larg/4;             Y2:=-Lato/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;            Y1:=Lato/4;
                     X2:=0;                Y2:=Lato/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;            Y1:=0;
                     X2:=Larg/4;             Y2:=Lato/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;            Y1:=-Lato/4;
                     X2:=Larg/4;             Y2:=Lato/4;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/4;            Y1:=-Lato/2;
                     X2:=Larg/4;             Y2:=0;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=0;                Y1:=-Lato/2;
                     X2:=Larg/4;             Y2:=-Lato/4;
                  end;



                 X1A:=-Larg/4;
                 Y1A:=Lato/2;
                 X2A:=-Larg/4;
                 Y2A:=-Lato/2;
                 X3A:=Larg/4;
                 Y3A:=Lato/2;
                 X4A:=Larg/4;
                 Y4A:=-Lato/2;

              end;
       end;
 end;


Procedure D_24TR;
var Lato,Larg:real;
 begin
    if CodPezzo='24TR' then
     begin
        if Lung <> 0 then Larg:=Lung
        else Larg:=B1*Costant^.C52;
        Lato:=B1;
     end
    else
     begin
        if Lung <> 0 then Larg:=Lung
        else Larg:=D1*Costant^.C52;
        Lato:=D1;
     end;
       case orient of

        1,3,2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/2;            Y1:=Lato/2;
                     X2:=Larg/2;             Y2:=Lato/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/2;            Y1:=-Lato/2;
                     X2:=Larg/2;             Y2:=-Lato/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Larg/2;            Y1:=0;
                     X2:=Larg/2;             Y2:=0;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=Costant^.C12;
                  end;


                 X1A:=-Larg/2;
                 Y1A:=Lato/2;
                 X2A:=-Larg/2;
                 Y2A:=-Lato/2;
                 X3A:=Larg/2;
                 Y3A:=Lato/2;
                 X4A:=Larg/2;
                 Y4A:=-Lato/2;

              end;
       end;
 end;

Procedure D_382;
var Lato,Larg,Diag:real;
 begin
    if CodPezzo='381' then
     begin
        if Lung <> 0 then Larg:=Lung
        else Larg:=D1*Costant^.C53;
        Lato:=D1;
     end
    else
     begin
        if Lung <> 0 then Larg:=Lung
        else Larg:=B1*Costant^.C53;
        Lato:=B1;
     end;
       case orient of

        1,3,2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';            TLinea:=1;
                     if Lato/2*sin(pi/4) > Larg/2 then Diag:=Larg/2*sin(pi/4)
                     else Diag:=Lato/2*sin(pi/4);
                     X1:=-Diag;              Y1:=X1;
                     X2:=-X1;                Y2:=X2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=Costant^.C12;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';                     TLinea:=1;
                     X1:=Larg/2;                      Y1:=Lato/2;
                     X2:=-X1;                         Y2:=Lato/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';                     TLinea:=1;
                     X1:=Larg/2;                      Y1:=-Lato/2;
                     X2:=-X1;                         Y2:=-Lato/2;
                  end;
(*
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';                     TLinea:=1;
                     X1:=DisPezzo^[1].X1-Costant^.C39;  Y1:=Lato/2;
                     X2:=-X1;                         Y2:=Lato/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';                     TLinea:=1;
                     X1:=DisPezzo^[1].X1-Costant^.C39;  Y1:=-Lato/2;
                     X2:=-X1;                         Y2:=-Lato/2;
                  end;
*)


                 X1A:=DisPezzo^[4].X1;
                 Y1A:=Lato/2;
                 X2A:=DisPezzo^[4].X1;
                 Y2A:=-Lato/2;
                 X3A:=DisPezzo^[4].X2;
                 Y3A:=Lato/2;
                 X4A:=DisPezzo^[4].X2;
                 Y4A:=-Lato/2;

              end;
       end;
 end;



end.
