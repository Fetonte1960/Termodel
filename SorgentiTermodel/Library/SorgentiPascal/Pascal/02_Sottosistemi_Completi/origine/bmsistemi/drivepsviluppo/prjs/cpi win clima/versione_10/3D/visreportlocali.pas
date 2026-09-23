unit visreportlocali;

interface
uses Udatalink,udb,sysutils,libreriagenerale,definiz,udbt;
Procedure compilamemoLocali;

implementation
uses U3dsd;
function cercadato(indloc:integer;coddato:string):string;
Var FF:Text;
    buf,tt:string;
    trovato,trovatoloc:boolean;
begin
exit;//disattivato
result:='';
coddato:=uppercase(coddato);
assign(ff,Percorsodrive+'\riepilogoestivolocali.rep');
reset(ff);
trovato:=false;
trovatoloc:=false;
while (not eof(ff))and(not trovato) do
  begin
  readln(ff,buf);
  if trovatoloc then
    begin
    azzeraidentif;
    tt:=leggiidentif1(buf);
    if uppercase(tt)=coddato then
      begin
      result:=leggiidentif1(buf);
      trovato:=true;
      end;
    end
  else
    begin
    azzeraidentif;
    tt:=leggiidentif1(buf);
    if uppercase(tt)='CODAMB' then
      begin
      tt:=leggiidentif1(buf);
      if strtoint(tt)=indloc then trovatoloc:=true;
      end;
    end;
  end;
close(ff);
end;
function Fst(ss:string;nch:integer):string;
var lss,i:integer;
begin
lss:=length(ss);
if lss<nch then
for i :=1 to nch-lss do
ss:=ss+' ';
result:=ss;
end;

Procedure compilamemoLocali;
Var indAmb,i:integer;
    toti,Tote:real;
const laggre=6;
begin
{
if dmtutti.T_Locali.Eof then exit;
toti:=0;
TotE:=0;
indamb:=strtoint(V_recAmb.codnum);
if Uppercase(copy(V_recAmb.Denom,1,laggre))='AGGRE-' then
  begin
  indamb:=strtoint(copy(V_recAmb.Denom,laggre+1,length(V_recAmb.Denom)-laggre));
  form1.GroupBox14.Caption:='Spazio aggregato al locale:'+inttostr(Indamb)+' , dati complessivi';
  end
else form1.GroupBox14.Caption:=' Locale:'+V_recAmb.Denom+' ';

with form1 do
  begin
  label116.Caption:=cercadato(indamb,'TRASMLOC');
  label118.Caption:=cercadato(indamb,'ILLLOC');
  label123.Caption:=cercadato(indamb,'APPSLOC');
  label124.Caption:=cercadato(indamb,'APPLLOC');
  label126.Caption:=cercadato(indamb,'INFSLOC');
  label128.Caption:=cercadato(indamb,'INFLLOC');
  label130.Caption:=cercadato(indamb,'PERSLOC');
  label132.Caption:=cercadato(indamb,'PERSLLOC');
  label134.Caption:=cercadato(indamb,'MAXCT');
  label136.Caption:=cercadato(indamb,'ORAMAXCT');
  label138.Caption:=cercadato(indamb,'MESEMAXCT');
  end;
with form1.StringGrid1 do
  begin
  cols[1].clear;
  cols[0].clear;
  cols[2].clear;
  cols[3].clear;
  cols[4].clear;
  cols[5].clear;
  cols[0].add('');
  cols[1].add('Tipo');
  cols[2].add('Modello');
  cols[3].add('Serie');
  cols[4].add('POt. Inv (W)');
  cols[5].add('POt. Est (W)');
  (*
  Memo1.Lines.clear;
  Memo2.Lines.clear;
  Memo1.Lines.add('Codice');
  Memo2.Lines.add('Tipo');
  ///           Modello       Serie');
  *)
  for i:=1 to NGterm do
  with gterm^[i]^ do
  if numamb=indamb then
    begin
    cols[0].add(Cod);
    cols[1].add(TipoTerm);
    cols[2].add(Modello);
    cols[3].add(Serie);
    cols[4].add(FLOAT_To_Str(POT,0));
    cols[5].add(FLOAT_To_Str(POTE,0));
    toti:=toti+pot;
    totE:=totE+potE;
    end;
  cols[0].add('');
  cols[0].add('Totale');
  cols[4].add('');
  cols[5].add('');
  cols[4].add(Float_To_Str(Toti,0));
  cols[5].add(Float_To_Str(TotE,0));
  end;
 } 
end;

end.
