unit LetturaFileDiego;

interface

implementation
Var riga,identif:string;
    POsind:integer;
procedure leggiidentif;
Var i:integer;
begin
i:=posind+1;
while (riga[i]<>':')and(i<length(riga)) do inc(i);
if i=posind+1 then
identif:=''
else
Identif:=copy(riga,posind+1,i-posind-1);
POsind:=i;
end;

Procedure LetturaFileDiego(Nomefile:string);
Var Finp:text;
    Nome,Valore:string;
begin
AssignFile(finp,Nomefile);
reset(Finp);
while not eof(Finp) do
  begin
  readln(Finp,riga);
  posind:=0;
  LeggiIdentif;
  Nome:=Identif;
  LeggiIdentif;
  Valore:=Identif;
  Doc.IfInizVariabile(Nome,Valore);
  end;
closefile(Finp);
end;
end.
