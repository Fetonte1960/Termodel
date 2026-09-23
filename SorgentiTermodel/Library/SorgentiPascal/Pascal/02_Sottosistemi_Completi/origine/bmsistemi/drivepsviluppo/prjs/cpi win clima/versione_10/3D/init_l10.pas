unit Init_l10;

interface
uses

{$IfNdef usadll}
//funzionidll,
uInizializza,Uvariabili,
{$endif}
dialogs,windows,forms,{uforml10,}gestione_dati,
libreriagenerale,udb,gestudb,sysutils,varcarichi,headerDlltermico,
UDataOutT,UdbT,progress3d;
Procedure Init_CalcoloL10;
Procedure Calcolo_Legge10(versbm:boolean);
Procedure Carica_generatori;
Procedure Calcolaconsumi;
 const I_autonomo='Generatore autonomo per ogni appartamento';
       I_aggiunto='A_';
       I_aggiunto1='All-';
 //      I_Aggre='AGGRE-';
implementation
{$Ifdef isolato}
Procedure Vai_BM;
Var ft:textfile;
    distribuzione:string;
begin
distribuzione:=copy(i_sl(libreriagenerale.PercorsoDrive),1,length(i_sl(libreriagenerale.PercorsoDrive))-length('versione_14\termotecnica\file_termico\Projectbrowser\'));
closeudbt;
assign(ft,libreriagenerale.percorsodrive+'patharch.txt');
rewrite(ft);
writeln(ft,distribuzione+'archivi\clima\archivi');
close(ft);
end;
Procedure Ritorna_SD;
Var ft:textfile;
begin
openUdbt;
assign(ft,libreriagenerale.percorsodrive+'patharch.txt');
rewrite(ft);
writeln(ft,i_sl(libreriagenerale.PercorsoDrive)+'archivi\');
close(ft);
end;
{$else}
uses init_Cad3d,u3dsd;//,CopiaLetturadisegno3d;
{$Endif}
Procedure Init_CalcoloL10;
begin
Inizial;
{$IfNdef usadll}
Inizializza_punt_L10;
{$else}
{ TODO -oDiego : Esclusione dll }
//CaricaDll('Legge10DLL');
//MyCalcoloLegge10 := CaricaFunzDll('CalcoloLegge10');
{$endif}
end;
Procedure Calcolo_Legge10(versbm:boolean);
var ret:integer;
    ff,ft:textfile;
    vv:string;

begin
if VERSBM then //dllbm
 begin
 Vai_bm;
 Headerdlltermico.Calcolol10;
 Ritorna_SD;
 end
else
 begin
 nocambiag:=true;
 vv:=copy(I_sl(PercorsoDrive),1,length(PercorsoDrive)-1);
 //uforml10.CalcoloL10(vv,Percorso_RisorseGen);
 nocambiag:=false;
 end;
Calcolaconsumi; 
end;
Procedure Calcolo_L10_Hide;
begin
{$IfNdef usadll}
{
tabt:=false;
nocambia:=true;
closeudbt;
//Procedure CalcoloL10(PathFiles, PathRisorse:Pchar);
Drivecombo := Percorso_RisorseGen + '\Risorse';
//PercorsoDrive := strpas(PathFiles);
dp := Percorso_progetti;
da := Percorso_archivi;
FCalcL10 := TFCalcL10.Create(nil);
FCalcL10.ShowModal;
//Fine Calcolo L10


tabt:=true;
openudbt;
nocambia:=false;
}
{$endif}
end;

Function IS_autonomo(Descr:string):boolean;
begin
result:=pos('§',Descr)<>0;
//result:=pos(Uppercase(i_Autonomo),Uppercase(codinp))<>0;
end;
Function IS_aggiunto(codinp:string):boolean;
begin
result:=pos(Uppercase(i_Aggiunto),Uppercase(codinp))<>0;
result:=result or(pos(Uppercase(i_Aggiunto1),Uppercase(codinp))<>0);
end;
Function Indice_impianto(codinp:string):integer;
var i:integer;
begin
i:=1;
result:=0;
while (i<Nimpianti)and(Uppercase(Impianto_D^[i].Codice)<>Uppercase(codinp))do inc(i);
if (i<=Nimpianti)and(Uppercase(Impianto_D^[i].Codice)=Uppercase(codinp)) then result:=i;
end;
Function Indice_generatore(descrgen:string):integer;
var i:integer;
begin
i:=1;
result:=0;
while (i<NGeneratori)and(Uppercase(DescGen1^[i].Descrizione)<>Uppercase(descrgen))do inc(i);
if (i<=NGeneratori)and(Uppercase(DescGen1^[i].Descrizione)=Uppercase(descrgen)) then result:=i;
end;

function existimp(codall:string):integer;
Var tt:string;
    i:integer;
begin
result:=0;
i:=1;
while (i<Nimpianti) and (Impianto_D^[i].Codice<>I_aggiunto+codall) do inc(i);
if Impianto_D^[i].Codice=I_aggiunto+codall  then result:=i;
end;

function Pianoduplicato(piano:string):string;
Var i,ipiano:integer;
begin
piano:=uppercase(piano);
result:='';
for i:=1 to npiani do
if uppercase(Piani_d^[i].Cod)=piano then ipiano:=i;
if Piani_d^[ipiano].CopiaDi<>'' then result:=piano;
for i:=1 to npiani do
with Piani_d^[i] do
if (uppercase(cod)<>piano)then
if (uppercase(copiadi)=piano) then result:=piano;
end;
Function ExistPiano(nomep:string):boolean;
Var i:integer;
begin
nomep:=uppercase(nomep);
result:=false;
if npiani=0 then exit;
i:=0;
while (not result)and(i<Npiani) do
  begin
  inc(i);
  result:=nomep=uppercase(piani_d^[i].Cod);
  end;
end;
Procedure Carica_generatori;
Var i,j,IndGeneratore,indaggre:integer;
    DescAll,descall1,nomepiano:string;
begin
Leggi_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.Ds_Locali);
Leggi_Impianti(dmtutti.T_Impianti,dmtutti.T_Impianti,dmtutti.Ds_Impianti);
Leggi_Generatori(dmtutti.T_Generatori,dmtutti.T_Generatori,dmtutti.Ds_Generatori);
Leggi_piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.DS_Piani);
Leggi_Zone(dmtutti.T_Zone,dmtutti.T_Zone,dmtutti.DS_Zone);
//elimina i piani cancellati
j:=0;
for i:=1 to nambienti do
if existPiano(ambienti_d^[i]^.Piano) then
begin
inc(j);
if j<>i then
ambienti_d^[j]^:=ambienti_d^[i]^;
end;
Nambienti:=j;

try
{ Andava bene per i dati generali semplificati Projectbrowser
For i:=1 to Nzone do
with zone_D^[i]  do
  begin
  IncrIntV:=zone_D^[1].IncrIntV;
  end;
}
{
for i:=1 to NAmbienti do
with ambienti_D^[i]^ do
if is_aggiunto(impianto) then
  begin
  Indimpianto:=Indice_impianto(Impianto);
  if (indimpianto>0)and(indimpianto<Nimpianti) then
  Impianto:=impianto_D^[indimpianto].descrizione
  else impianto:='';
  end;
}
j:=0;
for i:=1 to NImpianti do
//per potere utilizzare caldaie diverse nello stesso condomiio es.Autono1 ,Autono2
if not (Is_aggiunto(Impianto_D^[i].Codice))
then j:=i;
NImpianti:=j;
for i:=1 to NGeneratori do
//per potere utilizzare caldaie diverse nello stesso condomiio es.Autono1 ,Autono2
if not (Is_aggiunto(DescGen1^[i].Cod))
then j:=i;
Ngeneratori:=j;

for i:=1 to NAmbienti do
with ambienti_D^[i]^ do
if is_autonomo(denom) then
if uppercase(impianto)<>'NESSUNO' then
 begin
 Progress_3D(round((i-1)/NAmbienti*100),'Elaborazione impianti autonomi');

 if Is_aggiunto(Impianto)then //salva e ripristina l'impianto di riferimento
   begin
   if Indice_impianto(tipobxscelto)<>0 then impianto:=tipobxscelto;
   end
 else tipobxscelto:=impianto;
 Indimpianto:=Indice_impianto(Impianto);
 if indimpianto<>0 then IndGeneratore:=Indice_Generatore(impianto_D^[Indimpianto].GenInvt);

 if is_autonomo(denom)and(not is_aggre(denom,indaggre)) then
   begin
   nomepiano:=Pianoduplicato(piano);
   if nomepiano='' then
     begin
     descall:=uppercase(copy(denom,1,POs('§',Denom)-1));
     descall1:=uppercase(copy(denom,1,POs('§',Denom)-1));
     end
   else
     begin
     descall:=uppercase(copy(denom,1,POs('§',Denom)-1)+' '+nomepiano);
     descall1:=uppercase(copy(denom,1,POs('§',Denom)-1)+' P'+inttostr(strtoint(codnum)div 1000));
     end;
   if (indgeneratore<>0)and(indimpianto<>0)then
   if existimp(descall1)<>0 then
       begin
       impianto:=impianto_D^[existimp(descall1)].Codice;
       indimpianto:=existimp(descall1);
       end
   else
     begin
     inc(Ngeneratori);
     DescGen1^[Ngeneratori]:=DescGen1^[IndGeneratore];
     DescGen1^[Ngeneratori].Cod:=I_aggiunto+descall1;
     DescGen1^[Ngeneratori].Descrizione:=I_aggiunto+descall;
     inc(Nimpianti);
     impianto_D^[Nimpianti]:=impianto_D^[Indimpianto];
     impianto_D^[Nimpianti].Descrizione:=I_aggiunto+descall;
     impianto_D^[Nimpianti].Codice:=I_aggiunto+descall1;
     impianto_D^[NImpianti].GenInvt:=DescGen1^[Ngeneratori].Descrizione;
     indimpianto:=NImpianti;
     impianto:=impianto_D^[NImpianti].Codice;
     end;
   end
 end;
for i:=1 to NAmbienti do
for j:=1 to NAmbienti do
if j<>i then
if IS_Aggre(ambienti_D^[j]^.Denom,indaggre) then
if ambienti_D^[i]^.codnum=codaggre(ambienti_D^[j]^.Denom) then
ambienti_D^[j]^.Impianto:=ambienti_D^[i]^.Impianto;
except
showmessage('Il calcolo non si è concluso correttamente');
exit;
end;
Salva_Impianti(dmtutti.T_Impianti,dmtutti.T_Impianti,dmtutti.Ds_Impianti);
Salva_Generatori(dmtutti.T_Generatori,dmtutti.T_Generatori,dmtutti.Ds_Generatori);
Salva_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.Ds_Locali);
Salva_Zone(dmtutti.T_Zone,dmtutti.T_Zone,dmtutti.DS_Zone);
end;

Procedure Calcolaconsumi;
Var i,j,k:integer;
begin
Leggi_Generatori(dmtutti.T_Generatori,dmtutti.T_Generatori,dmtutti.Ds_Generatori);
Leggi_Carburanti(dmtutti.T_Carburanti,dmtutti.T_Carburanti,dmtutti.Ds_Carburanti);
NRisparmio:=0;
for i:=1 to ngeneratori do
with Descgen1^[i] do
  begin
  j:=1;
  while (j<Nrisparmio)and(uppercase(combust)<>uppercase(risparmio_D^[j].Fonte)) do inc(j);
  if (Nrisparmio=0)or(uppercase(combust)<>uppercase(risparmio_D^[j].Fonte)) then
    begin
    inc(Nrisparmio);
    j:=NRisparmio;
    risparmio_d^[Nrisparmio].Fonte:=combust;
    risparmio_d^[Nrisparmio].POt:=0;
    risparmio_d^[Nrisparmio].TotmJ:=0;
    risparmio_d^[Nrisparmio].suprisc:=0;
    risparmio_d^[Nrisparmio].EP:=0;
    end;
  risparmio_d^[Nrisparmio].Fonte:=combust;
  risparmio_d^[Nrisparmio].POt:=risparmio_d^[Nrisparmio].POt+DispCDInf;
  risparmio_d^[Nrisparmio].TotmJ:=risparmio_d^[Nrisparmio].TotmJ+FBmJ;
  risparmio_d^[Nrisparmio].ep:=risparmio_d^[Nrisparmio].ep*risparmio_d^[Nrisparmio].suprisc;
  risparmio_d^[Nrisparmio].suprisc:=risparmio_d^[Nrisparmio].suprisc+SupUtileR;
  risparmio_d^[Nrisparmio].ep:=(risparmio_d^[Nrisparmio].ep+FBKWSU*SupUtileR)/risparmio_d^[Nrisparmio].suprisc;
  end;
for i:=1 to NRisparmio do
with risparmio_d^[i] do
  begin
  j:=1;
  while (j<NCarburanti)and(uppercase(fonte)<>uppercase(Carburanti_D^[j].Descrizione)) do inc(j);
  if (NCarburanti<>0)and(uppercase(fonte)=uppercase(Carburanti_D^[j].Descrizione))then
    begin
    TotPrezzo:=Carburanti_D^[j].Prezzo*TotmJ;
    TotTEP:=Carburanti_D^[j].TEP*TotmJ;
    end;
  end;

Salva_Risparmio(dmtutti.T_Risparmio,dmtutti.T_Risparmio,dmtutti.Ds_Risparmio);
end;

end.
