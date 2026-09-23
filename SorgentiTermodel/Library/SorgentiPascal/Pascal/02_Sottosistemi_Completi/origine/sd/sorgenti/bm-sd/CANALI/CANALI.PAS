Program Canali;
uses crt,unitcan,U_cvcan,u_cvcan1,UTILITIE,inituti,init_CCA;
VAR SC:integer;
    fint:file of integer;
begin
{NEW(TABELLA);}
CHDIR(GET_DRIVE+'\CCA');
initprogram;
if exist('calc.sce') then
begin

assign(fInt,'calc.sce'); {'\cca'}
reset(fInt);
read(fInt,sc);
close(fInt);
initcca;{davide}
if sc <>9 then
 cvcan else
INDERR:=1;
if inderr=1 then
  begin
  calc_can;
  if sc<>9 then
  cvcan1;


  end;
end
{donewincrt;}
end.