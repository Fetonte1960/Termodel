
Program w_calc;

uses winprocs,wintypes,strings,{$ifdef delphi} messages, {$endif}
   unitcan,
   U_cvcan,
   u_cvcan1,
   UTILITIE,
   init_cca,
   inituti,
   wm,definiz,defuti,wincrt;

var sc:integer;
    F:TEXT;
    fint:file of integer;
    dr:string;
    st:string[80];
    pc:array[0..80] of char;
begin
{NEW(TABELLA);}
ASSIGN(f,'drive1.int');
reset(f);
read(f,dr);
close(f);
chdir(dr+'\cca');

INITCCA;
{$ifdef francia}
StrCopy(WindowTitle,'Mc4 Software: Calcul en cours');
{$endif}
{$ifdef italia}
StrCopy(WindowTitle,'Mc4 Software: Calcolo canali aria');
{$endif}
{$ifdef inglese}
StrCopy(WindowTitle,'Mc4 Software: Calculation running');
{$endif}
{$ifdef spagna}
StrCopy(WindowTitle,'Mc4 Software: Cálculo de conductos');
{$endif}
{$ifdef tedesco}
StrCopy(WindowTitle,'Mc4 Software: Berechnung im Gange');
{$endif}

InitWinCrt;
if exist('calc.sce') then
begin
assign(fInt,'calc.sce'); {'\cca'}
reset(fInt);
read(fInt,sc);
close(fInt);

{cercaer;}

if sc <>9 then
 cvcan else
INDERR:=1;




if inderr=1 then
  begin
  initprogram;
  stampe_word:=paramcount>0;
  calc_can;
  if sc<>9 then
  cvcan1;
  assign(f,'wintxt.dat');
  reset(f);
  read(f,st);
  strpcopy(pc,st);
  hd:=0;
  hd:=findwindow('TurboWindow',pc);
  if hd<> 0 then
  begin
  if sc<>9 then sendmessage(hd,wm_command,10100,0)
  else if stampe_word then sendmessage(hd,wm_command,502,0);
  end;
  donewincrt;
  end;
end;

end.

procedure cercaer;
var i,x:integer;
    f:text;
begin
 assign(f,'coptat.txt');
 rewrite(f);
for i:=1 to npezzi do
begin
   if archivio^.CodPezzo > '' then
    begin
       writeln(f,i:3);
       writeln(f,archivio^.CodPezzo);
       flusc(f);
       x:=TRANSFER_TAB(archivio^.Main);
       x:=TRANSFER_TAB(archivio^.Branch);
    end;
   close(f);
end;
end;


