unit UChiamateDLL;

interface
uses sysutils,windows,forms,messaggio,HeaderDllTermico,dbtables;



Var
H: HModule;
erroreDll:boolean;
//Percorsodrive:string;

//function Percorso_progetti:string;
//function Percorso_Archivi:string;
function caricadllTermico(percorso:string):boolean;
Procedure CancellaRigaDBMasterSlave(s1,s2:Ttable);

implementation
{
function Percorso_progetti:string;
var ff:textfile;
    dr,cd:string;
begin
  if fileexists(Percorsodrive+'\PathProg.txt') then
    begin
    ASSIGNFILE(ff,Percorsodrive+'\PathProg.txt');
    RESET(ff);
    read(ff,dr);
    closefile(ff);
    end;
  result:=dr;
end;

function Percorso_Archivi:string;
var ff:textfile;
    dr,cd:string;
begin
  if fileexists(Percorsodrive+'\PathArch.txt') then
    begin
    ASSIGNFILE(ff,Percorsodrive+'\PathArch.txt');
    RESET(ff);
    read(ff,dr);
    closefile(ff);
    end;
  result:=dr;
end;
}
Procedure CancellaRigaDBMasterSlave(s1,s2:Ttable);
begin
s2.First;
while not s2.Eof do
  begin
  s2.First;
  s2.Delete;
  end;
s1.delete;
end;

function caricadll(nomeDll:string):boolean;
var PP:Pchar;
begin
H := LoadLibraryEx(PChar(NomeDll+'.dll'), Application.Handle, LOAD_WITH_ALTERED_SEARCH_PATH);
if H <> 0 then  result:=true
else Vmessaggio('Modulo BmTermoCadDll','Dll : '+NomeDll+'.dll Non Trovata ');
erroredll:=not result;
end;

Function CaricaFunzDll(nome:string):Farproc;
Var temp:farproc;
begin
temp:= GetProcAddress(H, PChar(Nome));
result:=temp;
if not assigned(result) then
   begin
   vmessaggio('Modulo BmTermoCadDll ','Procedura :'+nome+' Non Trovata ');
   erroreDll:=true;
   end
end;


function caricadllTermico(percorso:string):boolean;
begin
erroreDll:=false;
if CaricaDll(Percorso+'bmtermocaddll') then
  begin
  if not erroreDll then Item_menu:=CaricaFunzDll('ITEM_MENU');
  //if not erroreDll then AggiornaDisegno:=CaricaFunzDll('AggiornaDisegno');
  //if not erroreDll then AggiungiEntita:=CaricaFunzDll('AggiungiEntita');
  if not erroreDll then FineDisegno:=CaricaFunzDll('FineDisegno');
  //if not erroreDll then SuperficiScambianti:=CaricaFunzDll('SuperficiScambianti');
  if not erroreDll then SaveTxt:=CaricaFunzDll('SaveTxt');
  if not erroreDll then OpenTxt:=CaricaFunzDll('OpenTxt');
  if not erroreDll then NuovoTxt:=CaricaFunzDll('NuovoTxt');
  //if not erroreDll then EditTabella:=CaricaFunzDll('EditTabella');
  if not erroreDll then CalcoloL10:=CaricaFunzDll('CalcoloL10');
  if not erroreDll then DefinisciPercorsi:=CaricaFunzDll('DefinisciPercorsi');
  end;
result:=not(erroredll);
end;

end.
