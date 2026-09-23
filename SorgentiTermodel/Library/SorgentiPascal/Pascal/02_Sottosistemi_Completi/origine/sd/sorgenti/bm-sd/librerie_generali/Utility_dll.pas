unit Utility_dll;

interface
uses windows,sysutils,forms,dialogs,libreriagenerale;

Procedure PercorsoDll(perc:string);
Function Funzione_dll(PNomefunz,PNomedll:string;PNumpar:integer;Par1,par2,par3,par4:string):string;
Function Procedura_dll(PNomefunz,PNomedll:string;PNumpar:integer;Par1,par2,par3,par4:string):string;
Function Percorso_dll:string;


implementation
Var  Nfunzdll:integer=0;
     PathDll:string='';
     Funzproc:boolean=true;

type TProcnopar=Procedure;
     TProc1par=Procedure(par1:pchar);
     TProc2par=Procedure(par1,par2:pchar);
     TProc3par=Procedure(par1,par2,par3:pchar);
     TProc4par=Procedure(par1,par2,par3,par4:pchar);
     Tfunzdll=record
              NumPar:integer;
              procnopar:Tprocnopar;
              proc1par:Tproc1par;
              proc2par:Tproc2par;
              proc3par:Tproc3par;
              proc4par:Tproc4par;
              Nomefunz,Nomedll:string;
              modulo:HModule;
              Proc:Farproc;
              end;
const maxfunzdll=100;
var Funzdll:array[1..maxfunzdll]of Tfunzdll;

Function Percorso_dll:string;
begin
result:=pathDll;
end;

Procedure PercorsoDll(perc:string);
begin
PathDll:=i_sl(perc);
end;
Function Funz_dll(PNomefunz,PNomedll:string;PNumpar:integer;PPar1,PPar2,PPar3,PPar4:string):string;
var i:integer;
    trov:integer;
    Par1,par2,par3,par4:pchar;
    H:hmodule;
    funz:farproc;
    tt,messaggio:string;
begin
trov:=0;
PNomedll:=ChangeFileExt(PNomeDll, '.dll');
par1:=Pchar(Ppar1);
par2:=Pchar(Ppar2);
par3:=Pchar(Ppar3);
par4:=Pchar(Ppar4);
i:=1;
if nfunzdll<>0 then
while (i<Nfunzdll)and(PNomefunz=Funzdll[i].Nomefunz)and(PNomeDll=Funzdll[i].NomeDll) do inc(i)
else i:=0;
if (i<>0)and(PNomefunz=Funzdll[i].Nomefunz)and(PNomeDll=Funzdll[i].NomeDll)
then trov:=i
else
  begin
  i:=1;
  if nfunzdll<> 0 then
  while (i<Nfunzdll)and(PNomeDll=Funzdll[i].NomeDll) do inc(i)
  else i:=0;
  if (i<>0)and(PNomeDll=Funzdll[i].NomeDll) then H:=Funzdll[i].modulo  //trovata un'altra procedura con la stessa dll
  else
  H := LoadLibraryEx(PChar(pathdll+PNomedll), 0, LOAD_WITH_ALTERED_SEARCH_PATH);
  messaggio:=' file non trovato.';
  if fileexists(pathdll+PNomedll) then messaggio:=' errore nel caricamento della Dll.';
  if H=0 then showmessage('Dll:'+pathdll+PNomedll+chr(13)+messaggio)
  else
    begin
    funz:= GetProcAddress(H, PChar(PNomefunz));
    if (not assigned(funz)) then
    showmessage('        Errore nel caricamento della dll'+chr(13)+chr(13)+pathdll+PNomedll+chr(13)+chr(13)+'funzione:'+PNomefunz+' non trovata')
    else
      begin
      inc(Nfunzdll);
      with Funzdll[Nfunzdll] do
        begin
        modulo:=H;
        nomefunz:=Pnomefunz;
        nomedll:=PnomeDll;
        NumPar:=PnumPar;
          case numpar of
          0:procnopar:=funz;
          1:proc1par:=funz;
          2:proc2par:=funz;
          3:proc3par:=funz;
          4:proc4par:=funz;
          end;
        trov:=Nfunzdll;
        end;
      end;
    end;
end;
if trov<>0 then
with Funzdll[Nfunzdll] do
  begin
    case numpar of
    0:procnopar;
    1:proc1par(par1);
    2:proc2par(par1,par2);
    3:proc3par(par1,par2,par3);
    4:proc4par(par1,par2,par3,par4);
    end;
  end;
end;

Function Funzione_dll(PNomefunz,PNomedll:string;PNumpar:integer;Par1,par2,par3,par4:string):string;
begin
funzproc:=true;
result:=Funz_dll(PNomefunz,PNomedll,PNumpar,Par1,par2,par3,par4);
end;
Function Procedura_dll(PNomefunz,PNomedll:string;PNumpar:integer;Par1,par2,par3,par4:string):string;
begin
funzproc:=false;
result:=Funz_dll(PNomefunz,PNomedll,PNumpar,Par1,par2,par3,par4);
end;

end.

