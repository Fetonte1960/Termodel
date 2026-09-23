{$R+}
{$B-}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}
{$C DEMANDLOAD}
unit OsnapTro;

INTERFACE

uses definiz,angoli,halotp4,graph,gruti;
Procedure FrTrsnap(xo,yo,rot:real);
{---------------------------------------------------------------------------}
implementation

uses genproc;{,controll;}
Procedure FrTrsnap(xo,yo,rot:real);
  Procedure DisFrec;
   var ing:real;

  begin
  ing:=50;
  xo :=xg(xo,yo);
  yo :=yg(yo,0);

{  real1:=0;real2:=1;
  ModiCord1(real1,real2,xo,yo,rot,ing);}
  movabs1(@xo,@yo);

  real1:=0;real2:=1;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  lnabs1(@real1,@real2);

  movabs1(@real1,@real2);


  real1:=0.1;real2:=0.8;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  lnabs1(@real1,@real2);

  real1:=0;real2:=1;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  movabs1(@real1,@real2);



  real1:=-0.1;real2:=0.8;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  lnabs1(@real1,@real2);

{  real1:=0;real2:=1;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  movabs1(@real1,@real2);

  real1:=0;real2:=-1;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  lnabs1(@real1,@real2);

  real1:=1;real2:=-1;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  lnabs1(@real1,@real2);

  real1:=0.8;real2:=-1.2;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  lnabs1(@real1,@real2);

  real1:=1;real2:=-1;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  movabs1(@real1,@real2);

  real1:=0.8;real2:=-0.8;
  ModiCord1(real1,real2,xo,yo,rot,ing);
  lnabs1(@real1,@real2);}

  end;

 begin
    int1:=1;
    setlnstyle(@int1);
    setxor(@int1);
    int1:=10;
    setcolor(int1);
    disfrec;

 end;
end.