{$F+,I-,R-,S-,V-}


program pilotas;
uses crt,dos;
Type maxstr=string[7];
const
    DsegPrincipale : integer =0;
    BufferMax = 1024;
    CR        =#13;
    Portadati =$03F8;
    IER       =$03F9;
    LCR       =$03FB;
    MCR       =$03FC;
    LSR       =$03FD;
    MDMMSR    =$03FE;
    ENBLRDY   =$01;
    MDMMOD    =$0B;
    MDMCD     =$80;
    INTCTLR   =$21;
var
   Vettore    :Pointer;
   regs       :registers;
   Buffer     :array [1..buffermax] of char;
   i,
   CarInBuf,
   CircOut,
   CircIn     :integer;
   Orig       :char;

(*************************  SvuotaBuffer **************************)
Procedure SvuotaBuffer;
begin
CarInBuf:=0;
CircOut :=1;
CircIn  :=1;
fillchar(buffer,sizeof(buffer),0);
end;

(************************* Inter        *****************************)
Procedure Inter; Interrupt;
begin
inline($FB);

if(CarInBuf < BufferMax) then
  begin
  Buffer[CircIn]:= Char(Port[Portadati]);
  If (CircIn<Buffermax) then
    CircIn := CircIn+1
  else
    CircIn:=1;
  CarInBuf:=CarInBuf+1;
  end;
Inline($FA);
Port[$20]:= $20;
end;
(************************* SettaSeriale *****************************)
Procedure SettaSeriale(Seriale,BPS,Stop,Dati:integer;Parita:char);

Var Regs:Registers;
    Parametro:byte;
begin
  case BPS of
  4800:BPS:=6;
  9600:bps:=7;
  end;
if Stop= 2 then stop:=1 else stop:=0;
if dati =7 then dati:=2 else dati:=3;
parametro:=(BPS shl 5)+(Stop shl 2)+dati;
case upcase(parita) of
'E':parametro:=parametro+8;
'O':parametro:=parametro+24;
end;
with regs do
  begin
  DX:=seriale-1;
  AH:=0;
  AL:=Parametro;
  Flags:=0;
  Intr($14,regs);
  end;
end;
(************************* AttivaPorta ****************************)
Procedure attivaporta;
var b:byte;
begin
DsegPrincipale:=Dseg;
SvuotaBuffer;
GetIntVec($0C,Vettore);
SetIntVec($0C,@Inter);


b:=Port[INTCTLR];
b:= b and $0EF;
Port[LCR] :=b;
b:=Port[LCR];
b:= b and $7F;
Port[LCR]:=b;
Port[IER] :=ENBLRDY;
Port[MCR]:=$08 or MDMMOD;
Port[MDMMSR]:=MDMCD;
Port[$20]:=$20;
end;
(******************************  LeggiCar ***********************)
function LeggiCar:char;
var ch:Char;
Begin
if CarInBuf>0 then
  begin
  LeggiCar:=buffer[CircOut];
  If CircOut < Buffermax then CircOut:= CircOut+1
  else CircOut:=1;
  CarInBuf:=CarInBuf-1;
  end;
end;
(************************** InviaCar *******************************)
Procedure InviaCar(b:byte);
begin
While ((Port[LSR] AND $20)<> $20) Do Port[Portadati]:=b;
end;
(************************** Stringa *********************************)
Procedure Stringa(s:MaxStr);
var i:integer;
begin
 for i:=1 to Length(s) do InviaCar(Ord(s[i]));
 Inviacar(Ord(cr));
end;
(*********************** Disattiva Porta *************************)
Procedure disattivaPorta;
var b:byte;
begin
Stringa('ATC0');
b:=Port[INTCTLR];
b:= b or $10;
Port[INTCTLR]:=b;
b:=Port[LCR];
b:=b and $7F;
Port[LCR]:=b;
Port[IER]:=$0;
Port[MCR]:=$0;
Port[$20]:=$20;
SetintVec($0C,vettore);
MsDos(regs);
End;
(************************* plottaggio *****************************)
Procedure Plottaggio;
Var OutCar:Char;
    f,f1:text;

begin
Assign(f,'Spol.plt');
reset(f);
assign(f1,'com1');
rewrite(f1);
repeat
  Read(f,OutCar);
  write(f1,OutCar);
Until eof(f);
close(f);
close(f1);
end;
(***********************   Main  ********************)
begin
  SettaSeriale(1,9600,1,7,'e');
  AttivaPorta;
  Plottaggio;
  stringa('ATZ');
  delay(1000);
  DisattivaPorta;
end.
