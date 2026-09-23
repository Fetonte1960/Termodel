{$S-,R-,F-}
program prova;

uses dos;
type
textRec= record
         Handle:word;
         mode:word;
         Bufsize:word;
         Private:word;
         Bufpos:word;
         Bufend:word;
         Bufptr:^TextBuf;
         Openfunc:pointer;
         inoutfunc:pointer;
         flushfunc:pointer;
         closefunc:pointer;
         AuxPort:word;
         auxparams:word;
         inut:array[1..12] of byte;
         name:array[0..79] of char;
         buffer:textbuf;
       end;

VAR fp,com2:TEXT;
    ch:char;
    var regs:registers;
    f:textrec;
procedure assignaux(var F:text; port,params:word);



procedure auxinit(port,params:word);

{
inline (
$58 /
$5A /
$B4/$00/
$DC/$14);}

begin
with regs do
  begin
  DX:=port;
  AH:=0;
  AX:=Params;
  Flags:=0;
  Intr($14,regs);
  end;
end;

procedure auxoutchar(port:word;ch:char);

inline(
$58/
$5A/
$B4/$01/
$DC/$14);
{
begin
  with regs do
  begin
    AX:=ord(CH);
    DX:=PORT;
    AH:=1;
    flags:=0;
  end;
intr($14,regs);
end;}


{F+}

function AuxOutput(var F:textRec):integer;
var p:integer;
begin
  with F do
  begin
    for p:=0 to BufPos-1 do AuxOutChar(Auxport,Bufptr^[p]);
    BufPos:=0;
  end;
  AuxOutput:=0;
end;


function AuxIgnore(var F: TextRec):integer;
begin
  auxIgnore:=0;
end;

function auxopen(var F:TextRec):integer;
begin
  with F do
  begin
    AuxInit(AuxPort,AuxParams);
    Mode:=fmoutput;
    InOutFunc:=@AuxOutPut;
    FlushFunc:=@AuxOutPut;
    closeFunc:=@AuxIgnore;
  end;
  AuxOpen:=0;
end;
begin
  With textrec(F) do
  begin
    Handle:=$FFFF;
    Mode:=Fmoutput;
    BufSize:=Sizeof(buffer);
    BufPtr:=@Buffer;
    OpenFunc:=@AuxOpen;
    AuxPort:=Port;
    AuxParams:=Params;
    Name[0]:=#0;
   end;
end;

{F-}
var st:string;
BEGIN
  st:='';
  AssignAux(Com2,1,$14A);
  Rewrite(com2);
  assign(fp,'spool.plt');
  reset(fp);
  while not eof(fp) do
  begin
   readln(fp,st);
   writeln(com2,st);
  end;
  close(com2);
  close(fp);
end.