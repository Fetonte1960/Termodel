unit Unit1;
interface
uses
  unitcan,
   U_cvcan,
   u_cvcan1,
   UTILITIE,
   strings,
   init_cca,
   inituti,
   winprocs,
   wintypes,
   wm,definiz;

procedure calcola;
implementation
procedure calcola;
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
{$ifdef tedesco}
StrCopy(WindowTitle,'Mc4 Software: Berechnung im Gange');
{$endif}
{$ifdef inglese}
StrCopy(WindowTitle,'Mc4 Software: Calculation running');
{$endif}
{$ifdef spagna}
StrCopy(WindowTitle,'Mc4 Software: Cálculo de conductos');
{$endif}
InitWinCrt;
if exist('calc.sce') then
begin
assign(fInt,'calc.sce'); {'\cca'}
reset(fInt);
read(fInt,sc);
close(fInt);
new(costant);
if sc <>9 then
 cvcan else
INDERR:=1;




if inderr=1 then
  begin
  initprogram;
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
  sendmessage(hd,wm_command,10100,0);
  donewincrt;
  end;
end;

end.

