unit inituti;


interface
uses defuti,crt ,utilitie,misure;
procedure initprogram;

procedure disposeprogram;
implementation


procedure initprogram;
var i:integer;
    f:text;
    s:string;
begin
canc_data:=true;
ins_data:=true;
tab_testo:=true;
stampe_word:=false;
drive_lingua:='';
stampprn:=exist('stampe.pin');
FlagStampa:=true;
UnMistemperatura:=1;
cambiatemperature;
tabellaaggiornata:=false;
misurecor:=1;
new(vcomandi);
new(tabella);
new(tabmista);
new(ar_ins);
initins;
ncampimista:=false;
new(umlav);
new(arkum);
new(info);
new(info1);
new(infoum);
new(messum);
new(mappa);
new(mappaMista);
new(bufopz);
new(mess);
for i:=1 to maxinfo do mess^[i]:='';
initumlav;
INITUM;
{$ifdef win}
cancloseok:=true;
new(tabellacorrente);
new(postab);
fillchar(postab^,sizeof(postab^),0);
ulttab:=1;
if exist('postab.dat') then
begin
  assign(fpostab,'postab.dat');
  reset(fpostab);
  while not eof(fpostab) do
  begin
    read(fpostab,postab^[ulttab]);
    inc(ulttab);
  end;
  close(fpostab);
end
else ulttab:=0;
initproc;
dueres:=false;
for i :=1 to maxtabelle do
with tabellacorrente^[i] do
begin
  nome:='';
  dialog:=nil;
  maniglia:=0;
end;
posx:=20;
posy:=70;
getdata:=true;
numcampitab:=0;
new(elstr);
fillchar(elstr^,sizeof(elstr^),0);
a_w:=0;
{$endif}
end;
procedure disposeprogram;
begin
dispose(vcomandi);
dispose(tabella);
dispose(tabmista);
dispose(ar_ins);
dispose(umlav);
dispose(arkum);
dispose(info);
dispose(info1);
dispose(infoum);
dispose(messum);
dispose(mappa);
dispose(mappaMista);
dispose(bufopz);
dispose(mess);
{$ifdef win}
dispose(tabellacorrente);
{$endif}
end;
end.