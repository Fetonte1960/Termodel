
unit funzbase;

INTERFACE

uses definizcan,definiz,esiste,dummyfunction;


Function Vuoto:boolean;
Procedure LoadNome;

implementation

{--------------------------------------------------------------------------}

{****************************** Vuoto *************************************}
Function Vuoto:boolean;
var i:integer;
    vuoto1:boolean;

begin
Vuoto1:=true;

i:=0;
repeat
i:=i+1;
if dis^[i]^.entita<>''then Vuoto1:=false;
until (Not Vuoto1)or(i=ultriga);
vuoto:=vuoto1;
end;

{***************************  LoadNome         *******************************}

Procedure LoadNome;

Var FileNome:string;f:Text;



begin


if exist('prog.Can') then
  begin
  assign(f,'prog.Can');
  reset(f);
  read(f,NomeProg);
  close(f);
  end
else HALT;

if NomeProg='' then Halt;

end;

end.