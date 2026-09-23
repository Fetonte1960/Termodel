{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit U_358;

interface

Procedure D_358;
Procedure D_359;
Procedure D_3510;
Procedure D_3511;


implementation

uses crt,dos,definiz,U_VARPEZZI;

procedure  D_358;
var  TL:integer;
 begin
    Ang:=Ang/180*pi;
    Lung:=(Abs(B1-B2)/2)/tan(Ang/2);
    case orient of
      1,3,2,4:begin
                 with DisPezzo[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;            Y1:=B1/2;
                     X2:=Lung/2;             Y2:=B2/2;
                  end;
                 with DisPezzo[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;            Y1:=-B1/2;
                     X2:=Lung/2;             Y2:=-B2/2;
                  end;

                 X1A:=-Lung/2;
                 Y1A:=B1/2;
                 X2A:=-Lung/2;
                 Y2A:=-B1/2;
                 X3A:=Lung/2;
                 Y3A:=B2/2;
                 X4A:=Lung/2;
                 Y4A:=-B2/2;

              end;
       end;
    end;


Procedure D_359;
var DY:real;
    TL:integer;
begin
    Ang:=Ang/180*pi;
    Lung:=(Abs(B1-B2)/2)/tan(Ang/2);
     case orient of
          1,3:begin
                 with DisPezzo[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=-B1/2;
                     X2:=Lung/2;           Y2:=B1/2-B2;
                  end;
                 with DisPezzo[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=B1/2;
                     X2:=Lung/2;           Y2:=B1/2;
                  end;

                 X1A:=-Lung/2;
                 Y1A:=B1/2;
                 X2A:=-Lung/2;
                 Y2A:=-B1/2;
                 if Orient=1  then
                  begin
                     X3A:=Lung/2;
                     Y3A:=B1/2;
                     X4A:=Lung/2;
                     Y4A:=B1/2-B2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=Lung/2;
                     Y3A:=-B1/2;
                     X4A:=Lung/2;
                     Y4A:=-B1/2+B2;
                  end;

              end;

          2,4:begin
                 with DisPezzo[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=B1/2;
                     X2:=Lung/2;           Y2:=B2/2;
                  end;
                 with DisPezzo[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=-B1/2;
                     X2:=Lung/2;           Y2:=-B2/2;
                  end;

                 X1A:=-Lung/2;
                 Y1A:=B1/2;
                 X2A:=-Lung/2;
                 Y2A:=-B1/2;
                 X3A:=Lung/2;
                 Y3A:=B2/2;
                 X4A:=Lung/2;
                 Y4A:=-B2/2;

              end;

       end;
    end;

Procedure D_3510;
var DY:real;
begin
    Ang:=Ang/180*pi;
    Lung:=(Abs(B1-B2)/2)/tan(Ang/2);
    DY:=Lung*Tan(10/180*pi);
      case orient of
          1,3:begin
                 with DisPezzo[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=B1/2;
                     X2:=Lung/2;           Y2:=B1/2+DY;
                  end;
                 with DisPezzo[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=-B1/2;
                     X2:=Lung/2;           Y2:=B1/2+DY-B2;
                  end;

                 X1A:=-Lung/2;
                 Y1A:=B1/2;
                 X2A:=-Lung/2;
                 Y2A:=-B1/2;
                 if Orient = 1 then
                  begin
                     X3A:=Lung/2;
                     Y3A:=B1/2+DY;
                     X4A:=Lung/2;
                     Y4A:=B1/2+DY-B2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=Lung/2;
                     Y3A:=-B1/2-DY+B2;
                     X4A:=Lung/2;
                     Y4A:=-B1/2-DY;
                  end;

              end;
          2,4:begin
                 with DisPezzo[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=B1/2;
                     X2:=Lung/2;           Y2:=B2/2;
                  end;
                 with DisPezzo[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=-B1/2;
                     X2:=Lung/2;           Y2:=-B2/2;
                  end;

                 X1A:=-Lung/2;
                 Y1A:=B1/2;
                 X2A:=-Lung/2;
                 Y2A:=-B1/2;
                 X3A:=Lung/2;
                 Y3A:=B2/2;
                 X4A:=Lung/2;
                 Y4A:=-B2/2;

              end;

       end;
    end;

Procedure D_3511;
var DY:real;
begin
    Ang:=Ang/180*pi;
    Lung:=(Abs(B1-B2)/2)/tan(Ang/2);
    DY:=Lung*Tan(10/180*pi);
      case orient of
          1,3:begin
                 with DisPezzo[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=B1/2;
                     X2:=Lung/2;           Y2:=B1/2-DY;
                  end;
                 with DisPezzo[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=-B1/2;
                     X2:=Lung/2;           Y2:=B1/2-DY-B2;
                  end;

                 X1A:=-Lung/2;
                 Y1A:=B1/2;
                 X2A:=-Lung/2;
                 Y2A:=-B1/2;
                 if Orient = 1 then
                  begin
                     X3A:=Lung/2;
                     Y3A:=B1/2-DY;
                     X4A:=Lung/2;
                     Y4A:=B1/2-DY-B2;
                  end
                 else
                  begin
                     Speculare:=true;
                     X3A:=Lung/2;
                     Y3A:=-B1/2+DY+B2;
                     X4A:=Lung/2;
                     Y4A:=-B1/2+DY;
                  end;

              end;
          2,4:begin
                 with DisPezzo[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=B1/2;
                     X2:=Lung/2;           Y2:=B2/2;
                  end;
                 with DisPezzo[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-Lung/2;          Y1:=-B1/2;
                     X2:=Lung/2;           Y2:=-B2/2;
                  end;

                 X1A:=-Lung/2;
                 Y1A:=B1/2;
                 X2A:=-Lung/2;
                 Y2A:=-B1/2;
                 X3A:=Lung/2;
                 Y3A:=B2/2;
                 X4A:=Lung/2;
                 Y4A:=-B2/2;

              end;

       end;
    end;


end.