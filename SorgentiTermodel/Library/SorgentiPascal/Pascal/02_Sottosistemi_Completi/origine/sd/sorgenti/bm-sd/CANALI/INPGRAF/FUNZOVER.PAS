{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit FunzOver;


INTERFACE

USES Definiz,FunzDim,Angoli;

Procedure CalcCordIniz(Base,Alt,Diam:real;var X1A,Y1A,X2A,Y2A,Direz,DirezZ:real);
Procedure LoadNome;

IMPLEMENTATION

{-----------------------------------------------------------------------------}




{***************************  LoadNome         *******************************}

Procedure LoadNome;

Var FileNome:string;f:Text;

 function Exist(Nome:string):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;


begin

if exist(drivecca+'prog.Can') then
  begin
  assign(f,Drivecca+'prog.Can');
  reset(f);
  read(f,NomeProg);
  close(f);
  end
else HALT;

if NomeProg='' then Halt;

end;




{*-*-*-*-*-*-*-*-*-*-*-*-*-*  CalcCordIniz   *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure CalcCordIniz(Base,Alt,Diam:real;var X1A,Y1A,X2A,Y2A,Direz,DirezZ:real);

Var A1,B1:real;

begin



if Base=0 then Base:=Diam;

CalcDirez(Dati^[RisultCalc^.Origine]^.Ti,Direz,DirezZ);

if Ug(Abs(DirezZ),Pi/2,1) then
  begin
  Direz:=NotVert;
  sezione:=true;
  B1:=Bordo(Dati^[RisultCalc^.Origine]^.Ti,Alt,Diam);
  sezione:=false;
  end
else B1:=0;

A1:=Bordo(Dati^[RisultCalc^.Origine]^.Ti,Base,Diam);


A1:=A1/(Conf^.AltNum/40);
B1:=B1/(Conf^.AltNum/40);
Base:=Base/(Conf^.AltNum/40);


if direz<0 then direz:=2*pi+direz;

with dis^[Dati^[RisultCalc^.Origine]^.Ti]^ do

  begin
  X1A:=-Base/2-A1;
  Y1A:=-B1;
  ModiCord(X1A,Y1A,X1,Y1,Direz,False);
  X2A:=Base/2-A1;
  Y2A:=-B1;
  ModiCord(X2A,Y2A,X1,Y1,Direz,False);
    (*
    case round(Direz/(pi/2))Mod 4 of

    1:  {-- a destra --}
      begin
      X1A:=X1;      Y2A:=Y1-A1;
      X2A:=X1;      Y1A:=Y1+A2;
      Direz:=pi/2;  DirezZ:=0;
      end;
    3:  {-- a sinistra --}
      begin
      X1A:=X1;          Y2A:=Y1+A1;
      X2A:=X1;          Y1A:=Y1-A2;
      Direz:=pi*(3/2);  DirezZ:=0;
      end;
    2:  {-- in basso --}
      begin
      X2A:=X1-A1;   Y1A:=Y1;
      X1A:=X1+A2;   Y2A:=Y1;
      Direz:=pi;    DirezZ:=0;
      end;
    0:   {-- in alto --}
      begin
      X2A:=X1+A1;       Y1A:=Y1;
      X1A:=X1-A2;       Y2A:=Y1;
      Direz:=0;      DirezZ:=0;
      end;

    else write( chr(7));
    end;
    *)

  end;
DirezZ:=0;

end;

end.