Unit esiste;

interface


 (*function Exist(Nome:string):boolean;
 function eliminadir(dir:string):string;
 FUNCTION SETRIGHT(ST:STRING):STRING;
 FUNCTION FORMAT(ST:STRING;StLength:INTEGER):STRING;
 FUNCTION SETLEFT(st:STRING):STRING;
 function UpString(St:string):string;
 Procedure Up_S(Var St:string);        *)

Implementation
{--------------------------------------------------------------------------}
(*
function Exist(Nome:string):boolean;
 var i:integer;
 s:tsearchrec;
 var f:file;
    begin
    exist:=false;
    i:=findfirst(nome,faAnyFile,s);
    exist:=i=0;
 end;

{--------------------------------------------------------------------------}

function eliminadir(dir:string):string;
var i:integer;

begin
  eliminadir:=dir;
  for i:=1 to length(dir) do
  if dir[i]='\' then eliminadir:=copy(dir,i+1,length(dir))
end;




{--------------------------------  SETright  ----------------------------------}
FUNCTION SETRIGHT(ST:STRING):STRING;
VAR
  I:INTEGER;
BEGIN
  I:=LENGTH(ST);
  while (I > 1) and (ST[i] = ' ') do i:=i-1;
  if i = 1 then
   begin
     if st[i] = ' ' then i:=0;
   end;

  if i = 0 then SetRight:=''
  else SETRIGHT:=COPY(ST,1,I);

END;     { FUNC. SETRIGHT }



{----------------------------  FORMAT_STRING  --------------------------------}

FUNCTION FORMAT(ST:STRING;StLength:INTEGER):STRING;
CONST Fill1='                                                                               ';
BEGIN
  ST:=COPY(ST,1,StLength);
  FORMAT:=ST+COPY(Fill1,1,StLength-LENGTH(ST));
END;      { FUNC.  FORMAT }

{--------------------------------  SETLEFT  ----------------------------------}
FUNCTION SETLEFT(st:STRING):STRING;
BEGIN
  WHILE (COPY(ST,1,1)=' ') AND (ST>'') DO ST:=COPY(ST,2,LENGTH(ST)-1);
  SETLEFT:=ST;
END;     { FUNC. SETLEFT }

{***************************  UPSTRING              *******************************}
 function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;

{***************************  UP_S              *******************************}
 Procedure Up_S(Var St:string);
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
 end;

{************************** exists*****************************************}
(*
function Exists(Nome:string):boolean;
var f:file;

begin
  if exist(nome) then exists:=true
  else
  begin
    {$I-} assign(f,Nome);rewrite(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      ExistS:=true
    end
    else exists:=false;
  end;
end;
*)


end.