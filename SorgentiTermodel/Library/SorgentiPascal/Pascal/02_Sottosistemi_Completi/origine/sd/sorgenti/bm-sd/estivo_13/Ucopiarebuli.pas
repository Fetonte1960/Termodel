unit Ucopiarebuli;

interface
uses Varcarichi,Uinitmem,sysutils;
Procedure Copiarebuli;

implementation
Procedure Copiarebuli;
Var i,j:integer;
begin
Nambienti:=0;
for i:=1 to Namb do
with Ambienti_R^[i] do
  begin
  inc(Nambienti);
  initMem('LOCALI',1,0);
  Ambienti_D^[i].denom:=Descr;
  Ambienti_D^[i].Zona:=1;
  Ambienti_D^[i].Npar:=0;
  Ambienti_D^[i].Codnum:=Inttostr(i);
  Ambienti_D^[i].Impianto:='Principale';
  Ambienti_D^[i].Superficie:=L*H;
  Ambienti_D^[i].Hsoffitto:=alt;
  end;
end;

end.
