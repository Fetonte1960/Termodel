{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit U_362R;

interface

Procedure D_362R;
Procedure D_362C;
Procedure D_354;
Procedure D_356;
Procedure D_034R;
Procedure D_352;


implementation

uses crt,dos,definiz,U_VARPEZZI;


procedure D_362R;
 var  Dx,Dy:real;
      TL:integer;
 begin


       case orient of
      1,3,2,4:begin
                 if Lung = 0 then
                  begin
                     Ang:=Ang/180*pi;
                     if Ang=pi then Lung:=0
                     else Lung:=abs((((B1-B2)/2)*(1-Costant^.C6))/tan(Ang/2));
                  end;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-(B2/2)*Costant^.C7;  Y1:=B2/2;
                     X2:=X1-Lung;             Y2:=B1/2-((B1-B2)/2)*Costant^.C6;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-(B2/2)*Costant^.C7;  Y1:=-B2/2;
                     X2:=X1-Lung;             Y2:=-B1/2+((B1-B2)/2)*Costant^.C6;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[1].X2;      Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;      Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[1].X1;      Y1:=B2/2;
                     X2:=DisPezzo^[1].X1;      Y2:=-B2/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-Lung-((B2/2)*Costant^.C7)*2;
                     X2:=-Lung-(B2/2)*Costant^.C7;
                     Y1:=B1/2;                Y2:=B1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-Lung-((B2/2)*Costant^.C7)*2;
                     X2:=-Lung-(B2/2)*Costant^.C7;
                     Y1:=-B1/2;               Y2:=-B1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=B2/2;
                     X2:=-(B2/2)*Costant^.C7;  Y2:=B2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=-B2/2;
                     X2:=-(B2/2)*Costant^.C7;  Y2:=-B2/2;
                  end;

                 X1A:=DisPezzo^[5].X1;
                 Y1A:=DisPezzo^[5].Y1;
                 X2A:=DisPezzo^[6].X1;
                 Y2A:=DisPezzo^[6].Y1;
                 X3A:=DisPezzo^[7].X1;
                 Y3A:=DisPezzo^[7].Y1;
                 X4A:=DisPezzo^[8].X1;
                 Y4A:=DisPezzo^[8].Y1;

              end;
        5,6:begin
               Dx:=ABS(((H2-H1)/2)*Costant^.C6);
               Dy:=ABS(((B2-B1)/2)*Costant^.C6);
               if Orient=5 then TL:=2
               else TL:=1;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2+Dx;         Y1:=B1/2-Dy;
                     X2:=H1/2-Dx;          Y2:=B1/2-Dy;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2-Dx;          Y1:=-B1/2+Dy;
                     X2:=-H1/2+Dx;         Y2:=-B1/2+Dy;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2-Dx;          Y1:=B1/2-Dy;
                     X2:=H1/2-Dx;          Y2:=-B1/2+Dy;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2+Dx;         Y1:=-B1/2+Dy;
                     X2:=-H1/2+Dx;         Y2:=B1/2-Dy;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2;            Y1:=B2/2;
                     X2:=-H1/2+Dx;         Y2:=B1/2-Dy;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H2/2;             Y1:=B2/2;
                     X2:=H1/2-Dx;          Y2:=B1/2-Dy;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H2/2;             Y1:=-B2/2;
                     X2:=H1/2-Dx;          Y2:=-B1/2+Dy;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2;            Y1:=-B2/2;
                     X2:=-H1/2+Dx;         Y2:=-B1/2+Dy;
                  end;

                 if Orient = 5 then
                  begin
                     with DisPezzo^[9] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=-H2/2;            Y1:=B2/2;
                         X2:=H2/2;             Y2:=B2/2;
                      end;
                     with DisPezzo^[10] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=H2/2;             Y1:=-B2/2;
                         X2:=-H2/2;            Y2:=-B2/2;
                      end;
                     with DisPezzo^[11] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=H2/2;             Y1:=B2/2;
                         X2:=H2/2;             Y2:=-B2/2;
                      end;
                     with DisPezzo^[12] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=-H2/2;            Y1:=-B2/2;
                         X2:=-H2/2;            Y2:=B2/2;
                      end;
                  end
                 else
                  begin
                     with DisPezzo^[9] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=H1/2;             Y2:=B1/2;
                      end;
                     with DisPezzo^[10] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=H1/2;             Y1:=-B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                      end;
                     with DisPezzo^[11] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=H1/2;             Y1:=B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[12] do
                      begin
                         Entita:='L';          TLinea:=TL;
                         X1:=-H1/2;            Y1:=-B1/2;
                         X2:=-H1/2;            Y2:=B1/2;
                      end;
                  end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B2/2;
                 X4A:=0;
                 Y4A:=-B2/2;

                 if Lung = 0 then
                  begin
                     Ang:=Ang/180*pi;
                     if Ang=pi then Lung:=0
                     else Lung:=abs((((H1-H2)/2)*(1-Costant^.C6))/tan(Ang/2));
                  end;

                 if Orient = 5 then Z1:=Lung+((H2/2)*Costant^.C7)*2
                 else Z1:=-Lung-((H2/2)*Costant^.C7)*2;

              end;

       end;
    end;


procedure D_362C;
 begin

    if Lung = 0 then
     begin
        Ang:=Ang/180*pi;
        if Ang=pi then Lung:=0
        else Lung:=abs(((D1-D2)/2)*(1-Costant^.C6)/tan(Ang/2));
     end;

       case orient of
      1,3,2,4:begin

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-(D2/2)*Costant^.C7;  Y1:=D2/2;
                     X2:=X1-Lung;             Y2:=D1/2-((D1-D2)/2)*Costant^.C6;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-(D2/2)*Costant^.C7;  Y1:=-D2/2;
                     X2:=X1-Lung;             Y2:=-D1/2+((D1-D2)/2)*Costant^.C6;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[1].X2;      Y1:=D1/2;
                     X2:=DisPezzo^[1].X2;      Y2:=-D1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[1].X1;      Y1:=D2/2;
                     X2:=DisPezzo^[1].X1;      Y2:=-D2/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-Lung-((D2/2)*Costant^.C7)*2;
                     X2:=-Lung-(D2/2)*Costant^.C7;
                     Y1:=D1/2;                Y2:=D1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=-Lung-((D2/2)*Costant^.C7)*2;
                     X2:=-Lung-(D2/2)*Costant^.C7;
                     Y1:=-D1/2;               Y2:=-D1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=D2/2;
                     X2:=-(D2/2)*Costant^.C7;  Y2:=D2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=-D2/2;
                     X2:=-(D2/2)*Costant^.C7;  Y2:=-D2/2;
                  end;

                 X1A:=DisPezzo^[5].X1;
                 Y1A:=DisPezzo^[5].Y1;
                 X2A:=DisPezzo^[6].X1;
                 Y2A:=DisPezzo^[6].Y1;
                 X3A:=DisPezzo^[7].X1;
                 Y3A:=DisPezzo^[7].Y1;
                 X4A:=DisPezzo^[8].X1;
                 Y4A:=DisPezzo^[8].Y1;

              end;
          5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';          TLinea:=2;
                     X1:=0;                Y1:=0;
                     R:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='C';          TLinea:=2;
                     X1:=0;                Y1:=0;
                     R:=D1/2-((D1-D2)/2)*Costant^.C6;
                  end;


                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;

                 Z1:=Lung+((D2/2)*Costant^.C7)*2;
              end;
            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='C';          TLinea:=2;
                     X1:=0;                Y1:=0;
                     R:=D1/2-((D1-D2)/2)*Costant^.C6;
                  end;

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;

                 Z1:=-Lung-((D2/2)*Costant^.C7)*2;
            end;

       end;
    end;


procedure D_354;
 var Dx,Dy:real;
     TL:integer;
 begin
       case orient of
      1,3,2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=(B1/2)*Costant^.C7+Lung;   Y1:=B2/2-((B2-B1)/2)*Costant^.C6;
                     X2:=(B1/2)*Costant^.C7;        Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=(B1/2)*Costant^.C7+Lung;   Y1:=-B2/2+((B2-B1)/2)*Costant^.C6;
                     X2:=(B1/2)*Costant^.C7;        Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=DisPezzo^[1].X1;           Y1:=B2/2;
                     X2:=DisPezzo^[1].X1;           Y2:=-B2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=DisPezzo^[1].X2;           Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;           Y2:=-B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=B1/2;
                     X2:=(B1/2)*Costant^.C7;   Y2:=B1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=-B1/2;
                     X2:=(B1/2)*Costant^.C7;   Y2:=-B1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[5].X2+Lung+(B1/2)*Costant^.C7;
                     Y1:=B2/2;
                     X2:=DisPezzo^[5].X2+Lung; Y2:=B2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[5].X2+Lung+(B1/2)*Costant^.C7;
                     Y1:=-B2/2;
                     X2:=DisPezzo^[5].X2+Lung; Y2:=-B2/2;
                  end;

                 X1A:=DisPezzo^[5].X1;
                 Y1A:=DisPezzo^[5].Y1;
                 X2A:=DisPezzo^[6].X1;
                 Y2A:=DisPezzo^[6].Y1;
                 X3A:=DisPezzo^[7].X1;
                 Y3A:=DisPezzo^[7].Y1;
                 X4A:=DisPezzo^[8].X1;
                 Y4A:=DisPezzo^[8].Y1;

              end;
        5,6:begin
               Dx:=ABS(((H2-H1)/2)*Costant^.C6);
               Dy:=ABS(((B2-B1)/2)*Costant^.C6);
               if Orient=5 then TL:=1
               else TL:=2;

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2+Dx;         Y1:=B2/2-Dy;
                     X2:=H2/2-Dx;          Y2:=B2/2-Dy;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H2/2-Dx;          Y1:=-B2/2+Dy;
                     X2:=-H2/2+Dx;         Y2:=-B2/2+Dy;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H2/2-Dx;          Y1:=B2/2-Dy;
                     X2:=H2/2-Dx;          Y2:=-B2/2+Dy;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H2/2+Dx;         Y1:=-B2/2+Dy;
                     X2:=-H2/2+Dx;         Y2:=B2/2-Dy;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-H2/2+Dx;         Y2:=B2/2-Dy;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H2/2-Dx;          Y2:=B2/2-Dy;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=H2/2-Dx;          Y2:=-B2/2+Dy;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=TL;
                     X1:=-H1/2;            Y1:=-B1/2;
                     X2:=-H2/2+Dx;         Y2:=-B2/2+Dy;
                  end;

                 if Orient = 5 then
                  begin
                     with DisPezzo^[9] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-H2/2;            Y1:=B2/2;
                         X2:=H2/2;             Y2:=B2/2;
                      end;
                     with DisPezzo^[10] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=H2/2;             Y1:=-B2/2;
                         X2:=-H2/2;            Y2:=-B2/2;
                      end;
                     with DisPezzo^[11] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=H2/2;             Y1:=B2/2;
                         X2:=H2/2;             Y2:=-B2/2;
                      end;
                     with DisPezzo^[12] do
                      begin
                         Entita:='L';          TLinea:=1;
                         X1:=-H2/2;            Y1:=-B2/2;
                         X2:=-H2/2;            Y2:=B2/2;
                      end;
                  end
                 else
                  begin
                     with DisPezzo^[9] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H1/2;            Y1:=B1/2;
                         X2:=H1/2;             Y2:=B1/2;
                      end;
                     with DisPezzo^[10] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H1/2;             Y1:=-B1/2;
                         X2:=-H1/2;            Y2:=-B1/2;
                      end;
                     with DisPezzo^[11] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=H1/2;             Y1:=B1/2;
                         X2:=H1/2;             Y2:=-B1/2;
                      end;
                     with DisPezzo^[12] do
                      begin
                         Entita:='L';          TLinea:=2;
                         X1:=-H1/2;            Y1:=-B1/2;
                         X2:=-H1/2;            Y2:=B1/2;
                      end;
                  end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B2/2;
                 X4A:=0;
                 Y4A:=-B2/2;

                 if Orient = 5 then Z2:=-Lung-((H1/2)*Costant^.C7)*2
                 else Z2:=Lung+((H1/2)*Costant^.C7)*2;

              end;
       end;
    end;

procedure D_356;
 var Dx:real;
 begin
       case orient of
          1,3:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=(B1/2)*Costant^.C7+Lung;   Y1:=B2/2-((B2-B1)/2)*Costant^.C6;
                     X2:=(B1/2)*Costant^.C7;        Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=(B1/2)*Costant^.C7+Lung;   Y1:=-B2/2+((B2-B1)/2)*Costant^.C6;
                     X2:=(B1/2)*Costant^.C7;        Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=DisPezzo^[1].X1;           Y1:=B2/2;
                     X2:=DisPezzo^[1].X1;           Y2:=-B2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=DisPezzo^[1].X2;           Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;           Y2:=-B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=B1/2;
                     X2:=(B1/2)*Costant^.C7;   Y2:=B1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=-B1/2;
                     X2:=(B1/2)*Costant^.C7;   Y2:=-B1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[5].X2+Lung+(B1/2)*Costant^.C7;
                     Y1:=B2/2;
                     X2:=DisPezzo^[5].X2+Lung; Y2:=B2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[5].X2+Lung+(B1/2)*Costant^.C7;
                     Y1:=-B2/2;
                     X2:=DisPezzo^[5].X2+Lung; Y2:=-B2/2;
                  end;

                 X1A:=DisPezzo^[5].X1;
                 Y1A:=DisPezzo^[5].Y1;
                 X2A:=DisPezzo^[6].X1;
                 Y2A:=DisPezzo^[6].Y1;
                 X3A:=DisPezzo^[7].X1;
                 Y3A:=DisPezzo^[7].Y1;
                 X4A:=DisPezzo^[8].X1;
                 Y4A:=DisPezzo^[8].Y1;

              end;
          2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';                    TLinea:=1;
                     X1:=0;                          Y1:=B1/2;
                     X2:=Lung+(H1/2)*Costant^.C7*2;   Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';                    TLinea:=1;
                     X1:=0;                          Y1:=-B1/2;
                     X2:=Lung+(H1/2)*Costant^.C7*2;   Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';                    TLinea:=1;
                     X1:=(H1/2)*Costant^.C7;          Y1:=B1/2;
                     X2:=(H1/2)*Costant^.C7;          Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';                    TLinea:=1;
                     X1:=(H1/2)*Costant^.C7+Lung;     Y1:=B1/2;
                     X2:=(H1/2)*Costant^.C7+Lung;     Y2:=-B1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y1;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=DisPezzo^[2].Y1;

              end;

          5:begin
               Dx:=ABS(((H2-H1)/2)*Costant^.C6);

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=B1/2;
                     X2:=-H1/2;            Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H2/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=-B1/2;
                     X2:=-H1/2;            Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=H2/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=B1/2;
                     X2:=-H2/2;            Y2:=-B1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=B1/2;
                     X2:=H2/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2-Dx;          Y1:=B1/2;
                     X2:=H2/2-Dx;          Y2:=-B1/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2+Dx;         Y1:=B1/2;
                     X2:=-H2/2+Dx;         Y2:=-B1/2;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;

                 Z2:=-Lung-((H1/2)*Costant^.C7)*2;

              end;
          6:begin
               Dx:=ABS(((H2-H1)/2)*Costant^.C6);

                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-H1/2;            Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H2/2-Dx;          Y1:=B1/2;
                     X2:=H2/2-Dx;          Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H2/2+Dx;         Y1:=B1/2;
                     X2:=-H2/2+Dx;         Y2:=-B1/2;
                  end;


                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;

                 Z2:=Lung+((H1/2)*Costant^.C7)*2;

              end;
       end;
    end;

procedure D_034R;
 var Dx,Dy:real;
     TL:integer;
 begin
       case orient of
          1,3:begin
                 if Lung = 0 then
                  begin
                     Ang:=Ang/180*pi;
                     if Ang=pi then Lung:=0
                     else Lung:=abs(((B1-B2)/2)/tan(Ang/2));
                  end;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=(B1/2)*Costant^.C7+Lung;   Y1:=B2/2;
                     X2:=(B1/2)*Costant^.C7;        Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=(B1/2)*Costant^.C7+Lung;   Y1:=-B2/2;
                     X2:=(B1/2)*Costant^.C7;        Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=DisPezzo^[1].X1;           Y1:=B2/2;
                     X2:=DisPezzo^[1].X1;           Y2:=-B2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=DisPezzo^[1].X2;           Y1:=B1/2;
                     X2:=DisPezzo^[1].X2;           Y2:=-B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=0;                        Y1:=B1/2;
                     X2:=(B1/2)*Costant^.C7;        Y2:=B1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=0;                        Y1:=-B1/2;
                     X2:=(B1/2)*Costant^.C7;        Y2:=-B1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[5].X2+Lung+(B1/2)*Costant^.C7;
                     Y1:=B2/2;
                     X2:=DisPezzo^[5].X2+Lung; Y2:=B2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[5].X2+Lung+(B1/2)*Costant^.C7;
                     Y1:=-B2/2;
                     X2:=DisPezzo^[5].X2+Lung; Y2:=-B2/2;
                  end;

                 X1A:=DisPezzo^[5].X1;
                 Y1A:=DisPezzo^[5].Y1;
                 X2A:=DisPezzo^[6].X1;
                 Y2A:=DisPezzo^[6].Y1;
                 X3A:=DisPezzo^[7].X1;
                 Y3A:=DisPezzo^[7].Y1;
                 X4A:=DisPezzo^[8].X1;
                 Y4A:=DisPezzo^[8].Y1;

              end;
          2,4:begin
                 if Lung = 0 then
                  begin
                     Ang:=Ang/180*pi;
                     if Ang=pi then Lung:=0
                     else Lung:=abs(((H1-H2)/2)/tan(Ang/2));
                  end;
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';                    TLinea:=1;
                     X1:=0;                          Y1:=B1/2;
                     X2:=Lung+(H1/2)*Costant^.C7*2;   Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';                    TLinea:=1;
                     X1:=0;                          Y1:=-B1/2;
                     X2:=Lung+(H1/2)*Costant^.C7*2;   Y2:=-B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';                    TLinea:=1;
                     X1:=(H1/2)*Costant^.C7;          Y1:=B1/2;
                     X2:=(H1/2)*Costant^.C7;          Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';                    TLinea:=1;
                     X1:=(H1/2)*Costant^.C7+Lung;     Y1:=B1/2;
                     X2:=(H1/2)*Costant^.C7+Lung;     Y2:=-B1/2;
                  end;

                 X1A:=DisPezzo^[1].X1;
                 Y1A:=DisPezzo^[1].Y1;
                 X2A:=DisPezzo^[1].X1;
                 Y2A:=DisPezzo^[2].Y1;
                 X3A:=DisPezzo^[1].X2;
                 Y3A:=DisPezzo^[1].Y1;
                 X4A:=DisPezzo^[1].X2;
                 Y4A:=DisPezzo^[2].Y1;

              end;

          5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=B1/2;
                     X2:=-H1/2;            Y2:=B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H2/2;             Y2:=B1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=-B1/2;
                     X2:=-H1/2;            Y2:=-B1/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H1/2;             Y1:=-B1/2;
                     X2:=H2/2;             Y2:=-B1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=-H2/2;            Y1:=B1/2;
                     X2:=-H2/2;            Y2:=-B1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';          TLinea:=1;
                     X1:=H2/2;             Y1:=B1/2;
                     X2:=H2/2;             Y2:=-B1/2;
                  end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;

                 if Lung = 0 then
                  begin
                     Ang:=Ang/180*pi;
                     if Ang=pi then Lung:=0
                     else Lung:=abs(((H1-H2)/2)/tan(Ang/2));
                  end;
                 Z2:=-Lung-((H1/2)*Costant^.C7)*2;

              end;
          6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=-H1/2;            Y1:=B1/2;
                     X2:=-H1/2;            Y2:=-B1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';          TLinea:=2;
                     X1:=H1/2;             Y1:=B1/2;
                     X2:=H1/2;             Y2:=-B1/2;
                  end;

                 X1A:=0;
                 Y1A:=B1/2;
                 X2A:=0;
                 Y2A:=-B1/2;
                 X3A:=0;
                 Y3A:=B1/2;
                 X4A:=0;
                 Y4A:=-B1/2;

                 if Lung = 0 then
                  begin
                     Ang:=Ang/180*pi;
                     if Ang=pi then Lung:=0
                     else Lung:=abs(((H1-H2)/2)/tan(Ang/2));
                  end;
                 Z2:=Lung+((H1/2)*Costant^.C7)*2;

              end;
       end;
    end;


procedure D_352;
 begin
       case orient of
      1,3,2,4:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=(D1/2)*Costant^.C7+Lung;   Y1:=D2/2-((D2-D1)/2)*Costant^.C6;
                     X2:=(D1/2)*Costant^.C7;        Y2:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=(D1/2)*Costant^.C7+Lung;   Y1:=-D2/2+((D2-D1)/2)*Costant^.C6;
                     X2:=(D1/2)*Costant^.C7;        Y2:=-D1/2;
                  end;
                 with DisPezzo^[3] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=DisPezzo^[1].X1;           Y1:=D2/2;
                     X2:=DisPezzo^[1].X1;           Y2:=-D2/2;
                  end;
                 with DisPezzo^[4] do
                  begin
                     Entita:='L';                  TLinea:=1;
                     X1:=DisPezzo^[1].X2;           Y1:=D1/2;
                     X2:=DisPezzo^[1].X2;           Y2:=-D1/2;
                  end;
                 with DisPezzo^[5] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=D1/2;
                     X2:=(D1/2)*Costant^.C7;   Y2:=D1/2;
                  end;
                 with DisPezzo^[6] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=0;                   Y1:=-D1/2;
                     X2:=(D1/2)*Costant^.C7;   Y2:=-D1/2;
                  end;
                 with DisPezzo^[7] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[5].X2+Lung+(D1/2)*Costant^.C7;
                     Y1:=D2/2;
                     X2:=DisPezzo^[5].X2+Lung; Y2:=D2/2;
                  end;
                 with DisPezzo^[8] do
                  begin
                     Entita:='L';             TLinea:=1;
                     X1:=DisPezzo^[5].X2+Lung+(D1/2)*Costant^.C7;
                     Y1:=-D2/2;
                     X2:=DisPezzo^[5].X2+Lung; Y2:=-D2/2;
                  end;

                 X1A:=DisPezzo^[5].X1;
                 Y1A:=DisPezzo^[5].Y1;
                 X2A:=DisPezzo^[6].X1;
                 Y2A:=DisPezzo^[6].Y1;
                 X3A:=DisPezzo^[7].X1;
                 Y3A:=DisPezzo^[7].Y1;
                 X4A:=DisPezzo^[8].X1;
                 Y4A:=DisPezzo^[8].Y1;

              end;
          5:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=D2/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='C';          TLinea:=1;
                     X1:=0;                Y1:=0;
                     R:=D2/2-((D2-D1)/2)*Costant^.C6;
                  end;


                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;

                 Z2:=-Lung-((D1/2)*Costant^.C7)*2;
              end;
            6:begin
                 with DisPezzo^[1] do
                  begin
                     Entita:='C';          TLinea:=2;
                     X1:=0;                Y1:=0;
                     R:=D1/2;
                  end;
                 with DisPezzo^[2] do
                  begin
                     Entita:='C';          TLinea:=2;
                     X1:=0;                Y1:=0;
                     R:=D2/2-((D2-D1)/2)*Costant^.C6;
                  end;

                 X1A:=0;
                 Y1A:=D1/2;
                 X2A:=0;
                 Y2A:=-D1/2;
                 X3A:=0;
                 Y3A:=D2/2;
                 X4A:=0;
                 Y4A:=-D2/2;

                 Z2:=Lung+((D1/2)*Costant^.C7)*2;
            end;
       end;
    end;
end.