unit UCalcoloCanDLL;

interface
uses sysutils,windows,forms,dialogs;
Const NomeDll='CalcoloCan.dll';

Procedure InitCalcoloCanali;
Function Settacodice(var Codice:Pchar):boolean;
Procedure Calcola_reti( Percorso,nomerete:string);
Var  percdll:string;
implementation
Var  HDll: HModule;
Procedure InitCalcoloCanali;
begin
HDll:=0;
end;

Function DLLCaricata:boolean;
begin
if HDll=0 then
HDll := LoadLibraryEx(PChar(percdll+'\'+Nomedll), Application.Handle, LOAD_WITH_ALTERED_SEARCH_PATH);
result:=Hdll<>0;
if Hdll=0  then showmessage(percdll+'\'+Nomedll+' non trovata.')
end;

Function CaricaFunzDll(nome:string;proc :Farproc):boolean;
Var temp:farproc;
begin
if dllcaricata then
  begin
  temp:= GetProcAddress(HDLL, PChar(Nome));
  Proc:=temp;
  result:=True;
  if not assigned(proc) then
     begin
     result:=False;
     showmessage('Procedura :'+nome+' Non Trovata ');
     end
  end;
end;
 {
Function Settacodice(var Codice:pchar):boolean;
Const Nome='Selcodice';
type tFunzione=Procedure ;//(var codice:pchar);

Var temp:farproc;
    myfunzione:Tfunzione;
begin
if CaricaFunzDll(nome,temp) then
  begin
  myfunzione:=Temp;
  myfunzione;//(codice);
  end;
end;
}
Function Settacodice(var Codice:pchar):boolean;
Const Nome='Selcodice';
type tFunzione=Procedure(Var codin:Pchar) ;//(var codice:pchar);

Var temp:farproc;
    myfunzione:Tfunzione;
begin
if CaricaFunzDll(nome,temp) then
  begin
  myfunzione:= GetProcAddress(HDLL, PChar(Nome));
  if not assigned(myfunzione) then
  showmessage('Procedura :'+nome+' Non Trovata ')
  else myfunzione(codice);//(codice);
  end;
end;

Procedure Calcola_reti( Percorso,nomerete:string);
Const Nome='CalcolaReti';
type tFunzione=Procedure(fPercorso,fnomerete:Pchar) ;//(var codice:pchar);

Var temp:farproc;
    myfunzione:Tfunzione;
begin
if CaricaFunzDll(nome,temp) then
  begin
  myfunzione:= GetProcAddress(HDLL, PChar(Nome));
  if not assigned(myfunzione) then
  showmessage('Procedura :'+nome+' Non Trovata ')
  else myfunzione(pchar(Percorso),pchar(nomerete));
  end;
end;
end.
