{$ifdef debug}
Unit key;
interface


Procedure decrementa(VAR Valore : integer;Locazione : integer);

Procedure ControlloChiave(var Risultato : INTEGER;Locazione,vers : integer);

function  lettura(locazione:byte):integer;

const entryLoc=22;
      LocIndhpgl=23;
      PosWin=24;

var EntrYLevel,inphpgl:integer;

{==========================================================================}
implementation
Procedure decrementa(VAR Valore : integer;Locazione : integer);
begin
end;
Procedure ControlloChiave(var Risultato : INTEGER;Locazione,vers : integer);
begin
end;
function  lettura(locazione:byte):integer;
begin
end;
{$else}
{$ifdef free}
{$define SPROTETTO}
{$undef PROTETTO}
{$ENDIF}
Unit key;
interface

uses    crt,dos,mphar,
        wintypes,
        Scribe,
        winprocs,                                 (* SentinelScribe driver   *)
        {$IFDEF DELPHI}
        SYSUTILS,
        forms,
        utigen,
        {$ELSE}
        strings,
        owindows,
        utilitie,
        {$ENDIF}
        Wm;


Procedure decrementa(VAR Valore : integer;Locazione : integer);

Procedure ControlloChiave(var Risultato : INTEGER;Locazione,vers : integer);

function  lettura(locazione:byte):integer;

function writekey(locazione,valore:integer):integer;

function DRIVERINSTALLATO:boolean;

function winnt:boolean;

procedure Micro(var Key:string);

const entryLoc=22;
      LocIndhpgl=23;
      PosWin=24;

var EntrYLevel,inphpgl:integer;

{==========================================================================}
implementation
{$R-}

var valeur:longint;
    address:byte;

procedure meskey;
var avar:integer;
    i:integer;
    st:string[80];
    pc:array[0..80] of char;
    s:string;

begin
  {$ifdef install}
   st:=oem_ans(w_m(7))+oem_ans(w_m(8));{'La chive di protezione non risponde.Verificare l''installazione';}
   {$else}
   st:=oem_ans(w_mw(59))+oem_ans(w_mw(60));
   {$endif}
   strpcopy(pc,st);
   winprocs.messagebox(0,pc,'Mc4-hvac',mb_ok or mb_iconexclamation);
   messagebeep(10);
end;

procedure MancaKey;
begin
   meskey;
   halt;
end;


function winnt:boolean;
const GetXVersionCmd = 'V/x'            ;
      GetVersionCmd  = 'V/'             ;
var cmdstring:string;
    rst:word;
begin
  CmdString := GetVersionCmd                            ;
  rst := SK_COMMAND(@CmdString[1],2)                 ; {SentinelSRIBE API Call}

  CmdString:=GetXVersionCmd                             ; {SentinelSRIBE API Call}
  RsT:=SK_COMMAND(@CmdString[1],3)                   ;
  if ((RsT MOD 256)=RB_WINNT_SYS_DRVR) or not ((RsT MOD 256)in[1..8])then winnt:=true else winnt:=false;
end;


function DRIVERINSTALLATO:boolean;
const StatusCallCmd='?/';
var cmdstring:string;
    rst:integer;
    size:integer;
begin

  CmdString := StatusCallCmd               ;
  RST := SK_COMMAND(@CmdString[1],2) ;    {SentinelSRIBE API Call}
  if RST=SKCMD_DRVR_NOT_INSTALLED  then DRIVERINSTALLATO:=FALSE
                                   else DRIVERINSTALLATO:=TRUE;
end;





procedure Micro(var Key:string);

var
  Retour,i:Integer;
  Pstr,loc:string;
  st:string[80];
  pc:array[0..80] of char;






 Begin
    Key:='';
    if not winnt then Retour:=lecture(0,valeur) else retour:=1;
    If Retour<>0 then
    begin
      i:=1;
      while (retour <> 0) and (i < 5) do
      begin
        Str(i,Pstr);
        Pstr:='I/'+Pstr+'/10';
        Retour :=SK_COMMAND(@Pstr[1],length(pstr));
        i:=i+1;
      end;
      IF Retour = 0 then
      begin
        Key:='Rain';
        pstr:='E/hyTAyAjqscoDyada';
        Retour:=SK_COMMAND(@pstr[1],length(pstr));
        pstr:='E/aAdaUabdcjtNcorc';
        Retour:=SK_COMMAND(@pstr[1],length(pstr));
      end
      else MancaKey;
    end
    else Key:='Micro';
    if Key > '' then
    begin
        { la locazione 24 e la locazione per la protezione su windows 1=non abilitato 0=abilitato}

      if Key='Rain' then
      begin
        Str(PosWin,Loc);
        Pstr:='R/'+Loc;
        Retour :=SK_COMMAND(@Pstr[1],length(pstr));
      end
      else
      begin
        Retour:=Lecture(PosWin,valeur);
        Retour:=Valeur;
      end;
      if Retour = 1 then
      begin
        meskey;
        halt;
      end;
        {$R+}
    end;
 end;


Procedure decrementa(VAR Valore : integer;Locazione : integer);
var Retour,ValoreOk : integer;
    Loc,PStr,Key:string;
begin
  Micro(Key);
  if Key='Rain' then
  begin
    Str(Locazione,Loc);
    Pstr:='R/'+Loc;
    Retour :=SK_COMMAND(@Pstr[1],length(pstr));
    if (Retour > 1) and (Retour < 300) then
    begin
      Retour := Retour - 1;
      Str(Retour,Pstr);
      Pstr:='W/'+Loc+'/'+Pstr;
      Retour :=SK_COMMAND(@Pstr[1],length(pstr));
    end;
  end
  else
  begin
    Retour:=Lecture(Locazione,valeur);
    valore:=valeur;
    if (Valore> 1) and (Valore<300) then
    begin
      Valore := Valore - 1;
      ValoreOk := Ecriture(Locazione,Valore);
    end;
  end;
end;

function writekey(locazione,valore:integer):integer;
var
    Loc,PStr,Key:string;
begin
  Micro(Key);
  if Key='Rain' then
  begin
    Str(Locazione,Loc);
    Str(valore,Pstr);
    Pstr:='W/'+Loc+'/'+Pstr;
    writekey :=SK_COMMAND(@Pstr[1],length(pstr));
  end
  else
  begin
    writekey := Ecriture(Locazione,Valore);
  end;
end;



procedure PassWordKey(VAR Valore : integer;Locazione,Vers : integer);
var  V1,V2,Num1,Num2,num3,num4   : longint;

     carattere,Codice  : String[10];
     C1,c2             : String[5];
     ris               : integer;
     version:longint;
begin
(*   V1 := Lecture(28,Valeur);  Num1 := Valeur;
   V1 := Lecture(29,Valeur);  Num2 := Valeur;

   V1 := Lecture(25,Valeur);  Num3 := Valeur;
   V1 := Lecture(26,Valeur);  Num4 := Valeur;

   If ( Num1 = Num3 ) AND (Num2 = Num4) then
   begin
     Ris := Ecriture(Locazione,Version);
     Valore := Version;
   end

   else
    begin

      clrscr;

      gotoxy(8,6); write(W_M(1)); {' CHIAVE DISABILITATA ');}
      gotoxy(8,8);write(W_M(2));  {'Inserire codice di abilitazione :');}

      readLN(carattere);
      clrScr;

      C1 := '';  C2 := '';

      V1 := Lecture(25,Valeur);  STR(Valeur,C1);
      V1 := Lecture(26,Valeur);  STR(Valeur,C2);

      Codice := C1+C2;

      if Carattere = Codice then
       begin
         Ris := Ecriture(Locazione,Version);
         Valore := Version;

         V1  := Ecriture(25,Num1);
         V2  := Ecriture(26,Num2);
       end
      else
       begin
         gotoxy(8,10);write(W_M(3)); { ' CODICE ERRATO !!!'); }
         Valeur := 1;
         delay(6000);
         Halt;
       end;
    end;*)
end;


procedure PassWordKeyRain(VAR Valeur : integer;Locazione,Vers : integer);
var  Num1,Num2,num3,num4   : integer;

     carattere,Codice  : String[10];
     C1,c2             : String[5];
     ris               : integer;
     Loc,PStr          : string;

begin
(*   Str(Locazione,Loc);

   pstr:='R/28';
   Num1 := SK_COMMAND(@pstr[1],length(pstr));
   pstr:='R/29';
   Num2 := SK_COMMAND(@pstr[1],length(pstr));

   pstr:='R/25';
   Num3 := SK_COMMAND(@pstr[1],length(pstr));
   pstr:='R/26';
   Num4 := SK_COMMAND(@pstr[1],length(pstr));

   If ( Num1 = Num3 ) AND (Num2 = Num4) then
    begin
       Str(vers,Pstr);
       Pstr:='W/'+Loc+'/'+Pstr;
       Valeur :=SK_COMMAND(@pstr[1],length(pstr));
    end
   else
    begin
      clrscr;
      gotoxy(8,6); write(W_M(1)); {' CHIAVE DISABILITATA ');}
      gotoxy(8,8);write(W_M(2));  {'Inserire codice di abilitazione :');}
      readLN(carattere);
      clrScr;
      C1 := '';  C2 := '';
      pstr:='R/25';
      Valeur:=SK_COMMAND(@pstr[1],length(pstr));  STR(Valeur,C1);
      pstr:='R/26';
      valeur:=SK_COMMAND(@pstr[1],length(pstr));  STR(Valeur,C2);
      Codice := C1+C2;
      if Carattere = Codice then
       begin
          Str(Vers,Pstr);
          Pstr:='W/'+Loc+'/'+Pstr;
          Valeur := SK_COMMAND(@pstr[1],length(pstr));

          Str(Num1,Pstr);
          Pstr:='W/25/'+Pstr;
          Ris := SK_COMMAND(@pstr[1],length(pstr));

          Str(Num2,Pstr);
          Pstr:='W/26/'+Pstr;

          Ris := SK_COMMAND(@pstr[1],length(pstr));
       end
      else
       begin
         gotoxy(8,10);write(W_M(3)); { ' CODICE ERRATO !!!'); }
         delay(6000);
         Halt;
       end;
    end;*)
end;


function  lettura(locazione:byte):integer;

var Retour: integer;
    valore:longint;
    Loc,PStr,Key:string;


begin
  Micro(Key);
  if Key='Rain' then
   begin
      Str(Locazione,Loc);
      Pstr:='R/'+Loc;
      Retour:=SK_COMMAND(@pstr[1],length(pstr));;
   end
  else
   begin
     Retour:=Lecture(Locazione,valore);
     Retour:=Valore;
   end;
  Lettura:=Retour;
end;


Procedure ControlloChiave(var Risultato : INTEGER;Locazione,vers : integer);
Var
   Valore:integer;
   Retour :integer;

   Pstr,Key      : string;

procedure messerrore;
var st:string[80];
   pc:array[0..80] of char;
begin
 meskey;
 halt;
end;

Begin
   {$IFDEF PROTETTO}
   {$R-}
   newFmes('key');
   textbackground(0);
   textcolor(7);
   Micro(key);
   if Key='Rain' then
    begin
       pstr:='R/0';
       Retour:=SK_COMMAND(@pstr[1],length(pstr));;
       if retour < 0 then MancaKey;
       Risultato:=(Retour div 1492);
       Str(Locazione,Pstr);
       Pstr:='R/'+Pstr;
       Retour:=SK_COMMAND(@pstr[1],length(pstr));
       case retour of
         0 : messErrore;    {chiave non abilitata con questa realise del pgm}
         1 : PassWordKeyRain(Retour,Locazione,vers);   {digitare la passWord per settare la chiave}
       end;
      if Retour < 0 then messErrore;
      if (Retour > 299) and (retour < vers) then messErrore;    {chiave non abilitata con questa realise del pgm}
    end
   else
    begin
       Valeur:=0;
       Retour:=Lecture(0,valeur);
       if retour <> 0 then MancaKey;
       Risultato:=(Valeur div 1492);
       if risultato <> 1 then mancakey;
       Retour:=Lecture(Locazione,valeur);
       case valeur of
         0 : messErrore;    {chiave non abilitata con questa realise del pgm}
         1 : PassWordKey(Valore,Locazione,vers);   {digitare la passWord per settare la chiave}
       end;
      if Valeur < 0 then messErrore;
      if (valeur > 299) and (valeur < vers) then messErrore;    {chiave non abilitata con questa realise del pgm}
    end;
    RestoreFmes;
    {$R+}
    {$ELSE}
    RISULTATO:=1;
    {$ENDIF}
End;
{$endif}
{$R+}
end.

