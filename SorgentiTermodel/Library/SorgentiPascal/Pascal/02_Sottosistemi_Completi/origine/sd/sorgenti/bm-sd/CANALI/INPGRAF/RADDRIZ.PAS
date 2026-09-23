{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit Raddriz;

INTERFACE

uses Definiz,FunzDim;

Procedure RaddrizzaDis(Angolo:Real);

{---------------------------------------------------------------------------}
implementation
Procedure RaddrizzaDis(Angolo:Real);
Var Vettore1:VetDim;

Begin
{If Sez_Dim Then
With Vettore Do}

Vettore1:=Vettore;
Vettore1.piano:=PianoCorDim;
If Sez_Dim Then
With Vettore1 Do
  begin

  Z1:=Vettore.Y1;
  Y1:=-Vettore.Z1;
  X1:=Vettore.X1;
  Modicord(X1,Y1,0,0,-Angolo,False);

  If Entita[1] IN ['L','F','*'] then
    begin
    Z2:=Vettore.Y2;
    Y2:=-Vettore.Z2;
    X2:=Vettore.X2;
    Modicord(X2,Y2,0,0,-Angolo,False);
    end;
  If Entita[1]='A' then Writeln(FDeb,R:6:0);


  {Writeln(FDeb,'  X1:',X1:6:0,'  Y1:',Y1:6:0,'  Z1:',Z1:6:0,
               '  X2:',X2:6:0,'  Y2:',Y2:6:0,'  Z2:',Z2:6:0);}
  end;

Write(FDim,Vettore1);
end;

end.