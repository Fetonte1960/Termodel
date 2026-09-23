{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit C_WM;

INTERFACE

uses
{$Ifdef Win}
  Wincrt;
{$else}
  Crt,
  Dos;
{$endif}


{$I lingua.pas}

VAR FILETRADUZ,backtraduz:STRING;

Function W_M(i:integer):string;
Procedure NewFmes(Ftr:String);
Procedure RestoreFMes;

{---------------------------------------------------------------------------}
implementation

Function W_M(i:integer):string;
var f    : text;
    Riga : string[80];
    k,y  : integer;
    expo : string;

begin
   y:=(i mod 10);
   k:=(i div 10);
   if y=0 then
    begin
       y:=10;
       k:=k-1;
    end;
   str(k,expo);

{   write(' Y ',Y,'  K  ',EXPO,'  ',FILETRADUZ+expo);delay(2000);}


   assign(f,FILETRADUZ+Lingua+expo);
   {$I-}
   reset(f);
   {$I+}
   if ioresult<>0 then
     begin
     riga:='>>'+FILETRADUZ+Lingua+expo+'<<';
     end
   else
     begin
     for k:=1 to y do readln(f,Riga);
     close(f);
     end;

   W_M:=Riga;
end;

Procedure NewFmes(Ftr:String);
begin
BackTraduz:=FileTraduz;
FileTraduz:=FTR;
end;

Procedure RestoreFMes;
begin
FileTraduz:=BackTraduz;
end;


end.