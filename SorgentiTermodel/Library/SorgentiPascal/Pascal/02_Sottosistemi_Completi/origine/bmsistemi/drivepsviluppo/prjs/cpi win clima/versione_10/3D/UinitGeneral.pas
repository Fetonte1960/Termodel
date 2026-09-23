unit UInitGeneral;

interface
uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList,
  Uchiamatedll,HeaderDllTermico,libreriagenerale;

Procedure Personalizza;

implementation
Procedure Personalizza;
Var ft:textfile;
    pathcor:string;
    PercorsoBase:string;
begin
Pathcor:=ExtractFilePath(application.ExeName);
PercorsoBase:=copy(pathcor,1,length(pathcor)-length('\file_termico\Cadesterno\'));
assign(ft,pathcor+'pathprog.txt');
rewrite(ft);
writeln(ft,Pathcor+'database\');
close(ft);
assign(ft,Pathcor+'patharch.txt');
rewrite(ft);
writeln(ft,PercorsoBase+'\file_termico\archivi\');
close(ft);
libreriagenerale.percorsodrive:=copy(pathcor,1,length(Pathcor)-1);
CaricaDllTermico(percorsobase+'\file_termico\DLLtermico\');
DefinisciPercorsi(Pchar(Percorsobase+'\file_termico'),Pchar(libreriagenerale.percorsoDrive+'\'));
if not fileexists(percorso_progetti+'\locali.db') then Nuovotxt(pchar(percorso_progetti));
end;
end.
