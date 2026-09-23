unit UCalc;
interface
uses db,dbtables,UdataLink;

Procedure Calcolo(var tabella,tabella3:TTable);

implementation
{$I Typedef}
{$I Mappadb.pas}
{$I DataIn.pas}
{$I DataOut.pas}

Var Primonodo:integer;
{$I proc.pas}
Procedure Calcolo(var tabella,tabella3:TTable);
Var i,j:integer;
begin
New(Tubaz_d);
Leggi_Tubazioni(Tabella,Tabella3);
for i:=1 to nTubaz do
with tubaz_d^[i] do
  begin
  dens:=850;
  for j:=1 to nsez do
  sez[j].Dint:=35;
  end;
Salva_Tubazioni(Tabella,Tabella3);
end;
end.
