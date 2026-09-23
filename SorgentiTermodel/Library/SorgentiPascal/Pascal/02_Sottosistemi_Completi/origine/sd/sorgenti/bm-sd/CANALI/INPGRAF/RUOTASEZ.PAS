{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit RuotaSez;

INTERFACE

uses Definiz,FunzDim;

Procedure RuotaSezione(angolo:Real);

{---------------------------------------------------------------------------}
implementation

Procedure RuotaSezione(angolo:Real);

Var XTem,YTem,ZTem:Real;
    ATem:Real;


Procedure ITerRuota(Tr:InTeger);
Var I:Integer;

Begin
i:=Dati^[tr]^.Ti;
While i<>0 Do
  begin
  YTem:=Dis^[i]^.Y1;
  Dis^[i]^.Y1:=Dis^[i]^.Z1;
  Dis^[i]^.Z1:=-YTem;
  ModiCord(Dis^[i]^.x1,Dis^[i]^.y1,0,0,Angolo,False);

  YTem:=Dis^[i]^.Y2;
  Dis^[i]^.Y2:=Dis^[i]^.Z2;
  Dis^[i]^.Z2:=-YTem;
  MoDiCord(Dis^[i]^.x2,Dis^[i]^.y2,0,0,Angolo,False);

  i:=Dis^[i]^.NLInea;
  end;

For i:=1 to Pezzitr do
If Dati^[tr]^.Pezzi[i]<>0 then
If VPezzi^[Dati^[tr]^.Pezzi[i]]^.Codice<>'' then
With VPezzi^[Dati^[tr]^.Pezzi[i]]^ Do
  begin
  ATem:=A;
  A:=B;
  B:=ATem;
  End;

i:=1;

While (Dati^[tr]^.Pros[i]<>0) And (i<5) Do
  begin
  ITerRuota(Dati^[tr]^.Pros[i]);
  i:=I+1;
  end;

end;

begin
ITerRuota(RiSultCalc^.Origine);
end;

end.