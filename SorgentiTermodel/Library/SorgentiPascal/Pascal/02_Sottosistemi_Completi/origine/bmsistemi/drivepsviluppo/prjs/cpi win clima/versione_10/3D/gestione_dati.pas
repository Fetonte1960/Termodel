unit Gestione_dati;

interface
uses Uvariabililettura,UDataoutT,udbt,gestudb,udatalink,varcarichi,
     libreriagenerale,dialogs,sysutils;
Procedure Puliscilocali(I_O:boolean);
Function Cerca_Amb(Namb:string;Var a_cor:integer):boolean;
Function IS_aggre(descr:string;var IndAggre:integer):boolean;
function CodAggre(descr:string):string;

implementation
function CodAggre(descr:string):string;
begin
result:=copy(descr,length('Aggre-')+1,length(descr)-length('Aggre-'));
end;

Function IS_aggre(descr:string;var IndAggre:integer):boolean;
begin
IndAggre:=0;
result:=POs('AGGRE-',Uppercase(descr))<>0;
if result then
  begin
  indaggre:=str_toint(CodAggre(descr));
  result:=indaggre<>0;
  end;
end;

Function Cerca_Amb(Namb:string;Var a_cor:integer):boolean;
Var i:integer;
Begin
if Nambienti=0 then
  begin
  result:=false;
  exit;
  end;
I:=1;
while (i<Nambienti) and (Ambienti_D^[i].CodNum<>Namb) do INC(I);
result:=(Ambienti_D^[i].CodNum=Namb) ;
a_cor:=i;
end;

Procedure Puliscilocali(I_O:boolean);
Var i,j:integer;
    Blin:file of  BLOCCHI;
    bufbl:blocchi;
    A_cor:integer;
begin
if I_O then
  begin
  Leggi_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
  Leggi_piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.DS_Piani);
  end;
for i:=1 to Nambienti do
ambienti_D^[i]^.Piano:='';
for i:=1 to NPiani do
if fileexists(percorsodrive+'\'+piani_D^[i].Cod+'.Bgi') then 
  begin
  assign(Blin,percorsodrive+'\'+piani_D^[i].Cod+'.Bgi');
  reset(Blin);
  while not eof(blin) do
    begin
    read(Blin,bufbl);
    if cerca_amb(bufbl.attrib1[1],a_cor) then
      begin
      if ambienti_D^[A_cor]^.Piano<>'' then showmessage('Due simboli fanno riferimento allo stesso locale');
      ambienti_D^[A_cor]^.Piano:=piani_D^[i].Cod;
      end;
    end;
  close(Blin);
  end;
j:=0;
for i:=1 to nambienti do
if ambienti_D^[i]^.Piano<>'' then
  begin
  inc(j);
  if i<>j then  ambienti_D^[j]^:=ambienti_D^[i]^;
  end;
Nambienti:=j;

if I_O then
Salva_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
end;

end.
