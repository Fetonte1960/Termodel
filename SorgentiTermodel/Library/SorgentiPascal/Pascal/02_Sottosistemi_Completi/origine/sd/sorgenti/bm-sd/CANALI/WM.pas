
unit WM;

INTERFACE
 uses sysutils;
const
 {$ifdef inglese}
 lingua='.Eng';
 {$endif}
 {$ifdef francia}
 lingua='.Fra';
 {$endif}
 {$ifdef italia}
 lingua='.Ita';
 {$endif}
 {$ifdef tedesco}
 lingua='.Ted';
 {$endif}
 {$ifdef slovacco}
 lingua='.Slo';
 {$endif}
 {$ifdef ceco}
 lingua='.Cec';
 {$endif}
 {$ifdef spagna}
 lingua='.Esp';
 {$endif}

VAR FILETRADUZ,backtraduz,dirwm:STRING[50];

Function W_M(i:integer):string;
Function W_M1T(i:integer;filet:string):string;
Function w_mw(i:integer):string;
Procedure NewFmes(Ftr:String);
Procedure RestoreFMes;

{---------------------------------------------------------------------------}
implementation
(*
Function W_M(i:integer):string;
var f    : text;
    Riga : string[80];
    k,y  : integer;
    expo,lin : string;

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
   if riga='' then
   begin
     str(y,lin);
     w_m:='>>'+FILETRADUZ+Lingua+expo+'<< linea '+lin;
   end
   else
   W_M:=Riga;
end;
*)

Function W_M(i:integer):string;
var f    : text;
    Riga : string[80];
    k,y  : integer;
    expo,lin : string;

begin
case i of
133:result:='PEZZO NON PRESENTE IN ARCHIVIO';
134:result:='PEZZO NON ADEGUATO';
135:result:='DATI USCITA BOCCHETTA ERRATI ( = 0)';
39:result:='Introdurre un terminale nel tratto ';

else result:='Messaggio '+inttostr(i);
end;
exit;
   assign(f,FILETRADUZ+Lingua);
   {$I-}
   reset(f);
   {$I+}
   if ioresult<>0 then
     begin
     riga:='>>'+FILETRADUZ+Lingua+'<<';
     end
   else
     begin
     for k:=1 to i do readln(f,Riga);
     close(f);
     end;
   if riga='' then
   begin
     str(i,lin);
     w_m:='>>'+FILETRADUZ+Lingua+'<< linea '+lin;
   end
   else
   W_M:=Riga;
end;

(*
Function W_M1T(i:integer;filet:string):string;
var f    : text;
    Riga : string[80];
    k,y  : integer;
    expo : string;

begin

   expo:='0';

{   write(' Y ',Y,'  K  ',EXPO,'  ',FILETRADUZ+expo);delay(2000);}


   assign(f,FILET+Lingua+expo);
   {$I-}
   reset(f);
   {$I+}
   if ioresult<>0 then
     begin
     riga:='>>'+FILET+Lingua+expo+'<<';
     end
   else
     begin
     for k:=1 to i do readln(f,Riga);
     close(f);
     end;

   W_M1T:=Riga;
end;

*)
Function W_M1T(i:integer;filet:string):string;
var f    : text;
    Riga : string[80];
    k,y  : integer;
    expo : string;

begin

   assign(f,FILET+Lingua);
   {$I-}
   reset(f);
   {$I+}
   if ioresult<>0 then
     begin
     riga:='>>'+FILET+Lingua+'<<';
     end
   else
     begin
     for k:=1 to i do readln(f,Riga);
     close(f);
     end;
   W_M1T:=Riga;
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


Function w_mw(i:integer):string;
begin
NewFmes(dirwm+'\igrwin');
w_mw:=w_m(i);
restorefmes;
end;

end.
