unit Utilitie;

interface
uses defuti,sysutils;
FUNCTION FORMAT(ST:STRING;StLength:INTEGER):STRING;
function UpString(St:string):string;
FUNCTION SETLEFT(ST:STRING):STRING;
FUNCTION SETRIGHT(ST:STRING):STRING;
Function Exist(nomef:string):boolean;
Function conferma(fmess,appmess:string;indmess:integer):boolean;
Function Get_drive:string;

implementation
{----------------------------  FORMAT_STRING  --------------------------------}
FUNCTION FORMAT(ST:STRING;StLength:INTEGER):STRING;
BEGIN
  ST:=COPY(ST,1,StLength);
  FORMAT:=ST+COPY(Fill,1,StLength-LENGTH(ST));
END;      { FUNC.  FORMAT }

 function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;

FUNCTION SETLEFT(ST:STRING):STRING;
BEGIN
  WHILE (COPY(ST,1,1)=' ') AND (ST>'') DO ST:=COPY(ST,2,LENGTH(ST)-1);
  SETLEFT:=ST;
END;     { FUNC. SETLEFT }

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

Function Exist(nomef:string):boolean;
begin
result:=fileexists(nomef);
end;

Function conferma(fmess,appmess:string;indmess:integer):boolean;
begin
end;

Function Get_drive:string;
begin
end;
end.
