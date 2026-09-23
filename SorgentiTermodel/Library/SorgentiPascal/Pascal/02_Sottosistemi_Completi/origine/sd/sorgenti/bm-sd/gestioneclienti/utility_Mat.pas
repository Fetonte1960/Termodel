unit Utility_mat;
interface
uses sysutils;
type TModuli=(M_L10,M_Estivo,M_tubi,M_canali,M_CAD);
const  Nprod=4;
type Telprod=array[1..nprod]of boolean;

Function controllolicenza(cod_attivaz,Ragione:string;modulo:TModuli;Var Vers:string):string;
Function pulisci_st(ss:string):string;
function Codifica_Licenza(ragione,release:string;Prod:Telprod):string;
Function Licenza_provvisoria(cod_attivaz,Ragione:string;modulo:TModuli;Var Vers:string):string;
implementation
Function pulisci_st(ss:string):string;
Var i:integer;
begin
ss:=uppercase(SS);
result:='';
for i:=1 to length(ss) do
if (SS[i] in ['A'..'Z'])or(SS[i] in ['0'..'9']) then result:=result+ss[i];
end;
Function Licenza_definitiva(Ragione:string;modulo:TModuli;Var Vers:string):string;
{$I Licenze}
var i:integer;
begin
vers:='';
result:='';
ragione:=pulisci_st(ragione);
if ragione='' then exit;
i:=1;
while (i<NLicenze)and(ragione<>pulisci_st(licenze[i].Ragione)) do inc(i);
if ragione=pulisci_st(licenze[i].Ragione) then
  begin
  result:=licenze[i].Ragione;
  if uppercase (licenze[i].utilizzo)='TEST' then
  result:=result+' ( Versione in fase di collaudo )';
  end;
end;


Function NumCaratteri:integer;
begin
result:=ord('Z')-ord('A')+1+10;
end;

function cod_car(numcifra:integer):char;
begin
numcifra:=numcifra mod Numcaratteri;
if numcifra<10 then result:=chr(ord('0')+numcifra)
else result:=chr(ord('A')+numcifra-10);
if result='0' then result:='+';
if result='O' then result:='?';
if result='I' then result:='$';
end;
function Codifica_Licenza(ragione,release:string;Prod:Telprod):string;
Var strcod,ragioneprov:string;
    i:integer;
    car:array[0..3]of integer;
begin
strcod:='';
ragione:=uppercase(ragione);
release:=uppercase(release);
for i:=1 to length(ragione) do
if (ragione[i]<>'F')and((ragione[i] in ['A'..'Z'])or(ragione[i] in ['0'..'9'])) then
strcod:=strcod+ragione[i];
ragioneprov:=strcod;
strcod:=strcod+'§';
for i:=1 to length(release) do
if (release[i] in ['A'..'Z'])or(release[i] in ['0'..'9']) then
strcod:=strcod+release[i];
strcod:=strcod+'§';
for i:=1 to NProd do
if prod[i] then strcod:=strcod+ragioneprov[length(ragioneprov)-i+1]
else  strcod:=strcod+'F';
for i:=0 to 3 do car[i]:=0;
for i:=1 to length(strcod) do car[i mod 4]:=car[i mod 4]+ord(strcod[i]);
//result:=strcod;
result:='';
for i:=0 to 3 do
result:=result+cod_car(car[i]);
end;


Function Licenza_provvisoria(cod_attivaz,Ragione:string;modulo:TModuli;Var Vers:string):string;
Var Prod:Telprod;
    i:integer;
begin
for i:=1 to Nprod do Prod[i]:=false;
result:='';
if cod_attivaz=Codifica_Licenza(ragione,vers,Prod) then result:=ragione;
end;

Function controlloLicenza(cod_attivaz,Ragione:string;modulo:TModuli;Var Vers:string):string;
Var tt:string;
begin
tt:=Licenza_provvisoria(cod_attivaz,Ragione,modulo,Vers);
//if tt='' then
//tt:=Licenza_definitiva(Ragione,modulo,Vers);
result:=tt;
end;
end.
