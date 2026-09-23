{$M 8192,0,221184}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit U_310F;

interface

Procedure D_310F(X1,X2,X3,X4,Y1,Y2,Y3,Y4:REAL);

implementation


uses crt,dos,turbo3,definiz,funzdim,angoli;


Procedure D_310F(X1,X2,X3,X4,Y1,Y2,Y3,Y4:REAL);
var Alt,Lung,Dx,Dy,VX1,VY1,Ang,ang1,Xin,Yin:real;
    XDiv:integer;
    i:integer;
    ddy:real;
 begin
    Vettore^.Piano:=PianocorDim;
    Xin:=(X1+X2)/2;
    Yin:=(Y1+Y2)/2;
    Alt:=sqrt(sqr(X1-X2)+sqr(Y1-Y2));
    Lung:=sqrt(sqr(X1-X3)+sqr(Y1-Y3));
    Dy:=(Alt*Costant^.C31*40)/Conf^.AltNum;
    Ddy:=(Alt*Costant^.C32*40)/Conf^.AltNum;
    Dx:=int(Lung/Ddy);
    Xdiv:=Trunc(Dx);
    if Odd(XDiv) then XDiv:=XDiv-1;
    if Xdiv=0 then Xdiv:=2;
    Dx:=Lung/XDiv;
    Calc_D(X1,Y1,0,X3,Y3,0,Ang,Ang1);
    Ang:=Ang-pi/2;

    Vettore^.entita:='L';
    Vettore^.TLinea:=1;
    Vettore^.Colore:=costant^.colcan;
    Vettore^.R:=0;
    Vettore^.R2:=0;

    VX1:=0;
    VY1:=Alt/2;

    for i:=1 to XDiv do
     begin

        Vettore^.X1:=VX1;
        Vettore^.Y1:=VY1;

        Vettore^.X2:=Vettore^.X1+Dx;
        if Odd(i) then Vettore^.Y2:=Vettore^.Y1-Dy
         else Vettore^.Y2:=Vettore^.Y1+Dy;

        VX1:=Vettore^.X2;
        VY1:=Vettore^.Y2;

        ModiCord(Vettore^.X1,Vettore^.Y1,Xin,Yin,Ang,false);
        ModiCord(Vettore^.X2,Vettore^.Y2,Xin,Yin,Ang,false);

        Write(FDim,Vettore^);

     end;

    VX1:=0;
    VY1:=-Alt/2;

    for i:=1 to XDiv do
     begin

        Vettore^.X1:=VX1;
        Vettore^.Y1:=VY1;

        Vettore^.X2:=Vettore^.X1+Dx;
        if Odd(i) then Vettore^.Y2:=Vettore^.Y1+Dy
         else Vettore^.Y2:=Vettore^.Y1-Dy;

        VX1:=Vettore^.X2;
        VY1:=Vettore^.Y2;

        ModiCord(Vettore^.X1,Vettore^.Y1,Xin,Yin,Ang,false);
        ModiCord(Vettore^.X2,Vettore^.Y2,Xin,Yin,Ang,false);

        Write(FDim,Vettore^);

     end;

    VX1:=0;

    for i:=1 to XDiv do
     begin

        Vettore^.X1:=VX1+Dx;
        if Odd(i) then Vettore^.Y1:=Alt/2-Dy
         else Vettore^.Y1:=Alt/2;

        Vettore^.X2:=Vettore^.X1-Dx;
        if Odd(i) then Vettore^.Y2:=-Alt/2
         else Vettore^.Y2:=-Alt/2+Dy;

        VX1:=Vettore^.X1;

        ModiCord(Vettore^.X1,Vettore^.Y1,Xin,Yin,Ang,false);
        ModiCord(Vettore^.X2,Vettore^.Y2,Xin,Yin,Ang,false);

        Write(FDim,Vettore^);

        Vettore^.X1:=X3;
        Vettore^.Y1:=Y3;
        Vettore^.X2:=X4;
        Vettore^.Y2:=Y4;
        Write(FDim,Vettore^);

        Vettore^.X1:=X1;
        Vettore^.Y1:=Y1;
        Vettore^.X2:=X2;
        Vettore^.Y2:=Y2;
        Write(FDim,Vettore^);

     end;

 end;

end.
(*
  CLRSCR;
  gotoxy(1,1);
  writeLN('X1  ',x1:8:2,' X2  ',x2:8:2,' X3  ',x3:8:2,' X4  ',x4:8:2);
  WRITELN('Y1  ',Y1:8:2,' Y2  ',Y2:8:2,' Y3  ',Y3:8:2,' Y4  ',Y4:8:2);
  writeLN('lung. ',lung:8:2,' alt ',alt:8:2,' dy ',dy:8:2,' dx ',dx:10:4,' fraz. ',Xdiv:8,' ang ',ang:6:2);
  delay(1000);
*)
