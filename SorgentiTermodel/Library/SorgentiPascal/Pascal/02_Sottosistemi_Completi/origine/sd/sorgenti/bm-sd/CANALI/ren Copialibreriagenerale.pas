{EX UTILITIE}
unit CopiaLibreriaGenerale;

interface

uses Windows, SysUtils, CopiaVariabiliGenerali, dbtables, dialogs, DB, Forms;

type Tipo_Operazione = (tpEdit, tpInsert);
     Tipo_Errore = (erLegge10, erCad, erImpianti);

Const Path_Tutor = 'Tutor\Tutor.rtf';
      NomeFile_Errori_Disegno = '\erroridisegno.txt';
      NomeFile_Errori_Impianti = '\erroriimpianti.txt';
      NomeFile_Errori_CAD = '\erroricad.txt';
      NomeFile_CalcDispOK = '\CalcDispOK.txt';
      NomeFile_CalcL10OK = '\CalcL10OK.txt';
      NomeFile_CalcEstivoOK = '\CalcEstitvoOK.txt';
      NomeFile_CalcTubiOK = '\CalcTubiOK.txt';
      NomeFile_CalcCanaliOK = '\CalcCanaliOK.txt';
      Str_Tutto_OK = '[***CONTROLLO VERIFICATO***]';
      Str_Calc_OK  = '[***CALCOLO CORRETTO***]';
      Str_Calc_No_OK = '[***CALCOLO NO CORRETTO***]';
      Rit_Carrello = #13 + #10;
      C_Non_sc='Non-sc';
      C_Esterno='Esterno';
Function CalcDispOK: Boolean;
function CalcEstivoOK: Boolean;
function CalcL10OK: Boolean;
function CalcCanaliOK: Boolean;
function CalcTubiOK: Boolean;
procedure SetCalcDispOK(Testo: String);
procedure SetCalcEstivoOK(Testo: String);
procedure SetCalcL10OK(Testo: String);
procedure SetCalcCanaliOK(Testo: String);
procedure SetCalcTubiOK(Testo: String);
Procedure  WriteMessage(NomeFile:string;CodErr:integer);
Function Exist(Nomefile:string):boolean;
Function FormST(ST:STRING):String;
function UpString(St:string):string;
FUNCTION SETLEFT(ST:STRING):STRING;
FUNCTION SETRIGHT(ST:STRING):STRING;
function get_drive:string;
function Percorso_progetti:string;
function Percorso_Archivi:string;
function Percorso_Immagini:string;
function Percorso_word:string;
function Percorso_Risorse:string;
Function Parametro(stringa:string;Num:integer):string;
function InRange(Num,Min,Max:integer):boolean;
procedure GotoXy(x,y:real);
procedure writec(a:string;b:integer);
function W_m(i:integer):string;
Function leggiidentif1(riga:string):string;
function contenuta (testo, ricerca : string) : boolean;
Procedure azzeraidentif;
Function NotPar(riga:string):boolean;
Function RoundR(cifredec:integer;Valore:real):real;
Procedure CopiaRigaDB(t1,s1,s1b,t2,s2,s2b:TTable);
Procedure CancellaRigaDB(s1,s2:Ttable);
Procedure CancellaRigaDBMasterSlave(s1,s2:Ttable);
Procedure CancellaFileCartella(percorso:string);
Function str_tofloat(valore:string):real;
Function float_Tostr(valore:real):String;
Function ContieneStringa(Piccola,grande:string):boolean;
Function Solocaratteri(grande:string):string;
Function Vicino(xx1,yy1,zz1,xx2,yy2,zz2:real):boolean;
Procedure D_ispose(var P:pointer);
Function float_To_str(valore:real; cdec:integer):String;
Procedure setta_Path_prog_arch(perc:string);
Function Restoidentif(riga:string):string;
function Test_Climatizzazione : Boolean;
function Test_Riscaldamento : Boolean;
function Test_Legge10 : Boolean;
procedure Copia_Dati_Comuni_Tabelle(Origine, Destinazione : TTable; Operazione : Tipo_Operazione);
function GetTempFile: string;
function Get_Msg_Errore(Tipo : Tipo_Errore; var TuttoOk, Warning : Boolean) : String;
procedure Centra_Finestra(var Top, Left : Integer; Height, Width : Integer);
Procedure inizializza;
procedure Cancellafile(nomef:string);
Function I_sl(var ss:string):string;

//Procedure CopyallFiles(percorso,destinazione,est:string);


Var PercorsoDrive, RisultatoLeggiIdentif, Percorso_RisorseGen:string;
    Errore_Lettura : Boolean;
implementation
Function I_sl(var ss:string):string;
begin
ss:=IncludeTrailingPathDelimiter(ss);
result:=ss;
end;
procedure Cancellafile(nomef:string);
var ff:file;
begin
if fileexists(nomef) then
  begin
  assign(ff,nomef);
  erase(ff);
  end;
end;

Var POsind:integer;
 Procedure inizializza;
 begin
 decimalseparator:='.';
 application.UpdateFormatSettings:=false;
 forcedirectories('c:\temp');
 session.PrivateDir:='C:\temp';
 session.NetFileDir:='C:\temp';
 end;
procedure SetCalcDispOK(Testo: String);
var
  F: TextFile;
begin
  AssignFile(F, PercorsoDrive + NomeFile_CalcDispOK);
  Rewrite(F);
  Writeln(F, Testo);
  CloseFile(F);
end;

procedure SetCalcEstivoOK(Testo: String);
var
  F: TextFile;
begin
  AssignFile(F, PercorsoDrive + NomeFile_CalcEstivoOK);
  Rewrite(F);
  Writeln(F, Testo);
  CloseFile(F);
end;

procedure SetCalcL10OK(Testo: String);
var
  F: TextFile;
begin
  AssignFile(F, PercorsoDrive + NomeFile_CalcL10OK);
  Rewrite(F);
  Writeln(F, Testo);
  CloseFile(F);
end;

procedure SetCalcCanaliOK(Testo: String);
var
  F: TextFile;
begin
  AssignFile(F, PercorsoDrive + NomeFile_CalcCanaliOK);
  Rewrite(F);
  Writeln(F, Testo);
  CloseFile(F);
end;

procedure SetCalcTubiOK(Testo: String);
var
  F: TextFile;
begin
  AssignFile(F, PercorsoDrive + NomeFile_CalcTubiOK);
  Rewrite(F);
  Writeln(F, Testo);
  CloseFile(F);
end;

function CalcDispOK: Boolean;
var
  F: TextFile;
  Valore: String;
  V: Boolean;
begin
 {V := False;
 if FileExists(PercorsoDrive + NomeFile_CalcDispOK) then
 begin
   AssignFile(F, PercorsoDrive + NomeFile_CalcDispOK);
   Reset(F);
   Readln(F, Valore);
   if Valore = Str_Calc_OK then V := True
   else if Valore = Str_Calc_No_OK then V := False;
   CloseFile(F);
 end;
 Result := V; }
 result:= true;
 //if not result then showmessage('I calcoli non sono andati a buon fine, volete stampare ugualmente?');
end;

function CalcEstivoOK: Boolean;
var
  F: TextFile;
  Valore: String;
  V: Boolean;
begin
 {V := False;
 if FileExists(PercorsoDrive + NomeFile_CalcEstivoOK) then
 begin
   AssignFile(F, PercorsoDrive + NomeFile_CalcEstivoOK);
   Reset(F);
   Readln(F, Valore);
   if Valore = Str_Calc_OK then V := True
   else if Valore = Str_Calc_No_OK then V := False;
   CloseFile(F);
 end;
 Result := V;  }
 result:= true;
 //if not result then showmessage('I calcoli non sono andati a buon fine, volete stampare ugualmente?');
end;

function CalcL10OK: Boolean;
var
  F: TextFile;
  Valore: String;
  V: Boolean;
begin
 {V := False;
 if FileExists(PercorsoDrive + NomeFile_CalcL10OK) then
 begin
   AssignFile(F, PercorsoDrive + NomeFile_CalcL10OK);
   Reset(F);
   Readln(F, Valore);
   if Valore = Str_Calc_OK then V := True
   else if Valore = Str_Calc_No_OK then V := False;
   CloseFile(F);
 end;
 Result := V;       }
 result:= true;
 //if not result then showmessage('I calcoli non sono andati a buon fine, volete stampare ugualmente?');
end;

function CalcTubiOK: Boolean;
var
  F: TextFile;
  Valore: String;
  V: Boolean;
begin
 V := False;
 if FileExists(PercorsoDrive + NomeFile_CalcTubiOK) then
 begin
   AssignFile(F, PercorsoDrive + NomeFile_CalcTubiOK);
   Reset(F);
   Readln(F, Valore);
   if Valore = Str_Calc_OK then V := True
   else if Valore = Str_Calc_No_OK then V := False;
   CloseFile(F);
 end;
 Result := V;
 //result:= true;
 //if not result then showmessage('I calcoli non sono andati a buon fine, volete stampare ugualmente?');
end;

function CalcCanaliOK: Boolean;
var
  F: TextFile;
  Valore: String;
  V: Boolean;
begin
 {V := False;
 if FileExists(PercorsoDrive + NomeFile_CalcCanaliOK) then
 begin
   AssignFile(F, PercorsoDrive + NomeFile_CalcCanaliOK);
   Reset(F);
   Readln(F, Valore);
   if Valore = Str_Calc_OK then V := True
   else if Valore = Str_Calc_No_OK then else V := False;
   CloseFile(F);
 end;
 Result := V;   }
 result:= true;
 //if not result then showmessage('I calcoli non sono andati a buon fine, volete stampare ugualmente?');
end;

function Test_Climatizzazione : Boolean;
begin
     Result := True;
end;

function Test_Riscaldamento : Boolean;
begin
     Result :=   True;
end;

function Test_Legge10 : Boolean;
begin
     Result := True;
end;

{-----------------------------------------------------------------------------
  Procedura: Copia_Dati_Comuni_Tabelle
  Autore:    Piero
  Data Creazione:      13-apr-2004
  Argomenti: Origine, Destinazione : TTable; Operazione : Integer
  Valore Restituito:    None
  Descrizione : La variabile operazione se = 0 --> Edit
                                        se = 1 --> Insert
-----------------------------------------------------------------------------}
procedure Copia_Dati_Comuni_Tabelle(Origine, Destinazione : TTable; Operazione : Tipo_Operazione);
Var
   i, j : Integer;
begin
     Case Integer(Operazione) of
       Ord(tpEdit) : Destinazione.Edit;
       Ord(tpInsert) : Destinazione.Insert;
     end;

     for j := 0 to Destinazione.FieldCount - 1 do
        for i := 0 to Origine.FieldCount - 1 do
           if (not (Destinazione.FieldDefs[j].DataType in [ftAutoInc])) and (UpperCase(Destinazione.Fields[j].FieldName) = UpperCase(Origine.Fields[i].FieldName)) then
              begin
                   Destinazione.Fields[j].Value := Origine.Fields[i].Value;
                   Break
              end;

     Destinazione.Post;
end;

function GetTempFile: string;
var
  Buffer: array[0..MAX_PATH] OF Char;
  aFile : string;
begin
  GetTempPath(Sizeof(Buffer)-1,Buffer);
  GetTempFileName(Buffer,'~',0,Buffer);
  result := StrPas(Buffer)
end;


Procedure D_ispose(var P:pointer);
begin
if p<>Nil then
dispose(p);
p:=nil;
end;

Function Vicino(xx1,yy1,zz1,xx2,yy2,zz2:real):boolean;

function Vic(a,b:real):boolean;
Const app=0.01;
begin
vic:=abs(a-b)<app;
end;
begin
result:=vic(xx1,xx2)and vic(yy1,yy2)and vic(zz1,zz2);
end;

Function float_To_str(valore:real; cdec:integer):String;
begin
str(valore:0:cdec,result);
end;


Function float_Tostr(valore:real):String;
begin
str(valore:0:0,result);
end;

Function str_tofloat(valore:string):real;
Var E:Integer;
    vv:real;
begin
if valore<>'' then
for e:=1 to length(valore) do if Valore[E]=',' then Valore[E]:='.';
val(valore,VV,e);
result:=VV;
end;

Procedure CancellaFileCartella(percorso:string);
Var sr:Tsearchrec;
    NomeFile : String;
    perc:string;
    Trovato : Integer;
begin
     perc:=percorso+'\*.*';

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             DeleteFile(NomeFile);
             Trovato := FindNext(sr);
        end;

{


  repeat
  assign(f,percorso+'\'+sr.Name);
  erase(f);
  until FindNext(sr) <> 0;
  FindClose(sr);
  // Emanuela: mancava la chiusura del file
  CloseFile(f);
  end;}
end;



Procedure CopiaRigaDB(t1,s1,s1b,t2,s2,s2b:TTable);
Var i:integer;
begin
t2.Open;
t1.Open;
s1.Open;
s1b.Open;
s2.Open;
s2b.Open;
t2.Append;
t2.Edit;
for i:=2 to  t1.FieldCount do
t2.Fields[i-1].Value:=t1.Fields[i-1].Value;
t2.POst;
s1.First;
while not s1.eof do
  begin
  s2.Append;
  s2.Edit;
  for i:=3 to  s1.FieldCount do
  s2.Fields[i-1].Value:=s1.Fields[i-1].Value;
  s2.Post;
  s1.Next;
  end;
s1b.First;
while not s1b.eof do
  begin
  s2b.Append;
  s2b.Edit;
  for i:=3 to  s1b.FieldCount do
  s2b.Fields[i-1].Value:=s1b.Fields[i-1].Value;
  s2b.Post;
  s1b.Next;
  end;
end;
Procedure CancellaRigaDBMasterSlave(s1,s2:Ttable);
begin
s2.First;
while not s2.Eof do
  begin
  s2.First;
  s2.Delete;
  end;
s1.delete;
end;
Procedure CancellaRigaDB(s1,s2:Ttable);
begin
s1.First;
while not s1.Eof do
  begin
  s1.First;
  s1.Delete;
  end;
s2.First;
while not s2.Eof do
  begin
  s2.First;
  s2.Delete;
  end;
end;


Function RoundR(cifredec:integer;Valore:real):real;
Var i:integer;
begin
for i:=1 to cifredec do Valore:=Valore*10;
Valore:=round(Valore);
for i:=1 to cifredec do Valore:=Valore/10;
result:=valore;
end;
Procedure azzeraidentif;
begin
posind:=0;
end;

Function NotPar(riga:string):boolean;
begin
result:=POsind=length(riga);
end;

Function leggiidentif1(riga:string):string;
Var i:integer;
    identif:string;
begin
i:=posind+1;

if i<length(riga) then
while (riga[i]<>':')and(i<length(riga)) do inc(i);

if i=posind+1 then
identif:=''
else
Identif:=copy(riga,posind+1,i-posind-1);
POsind:=i;
RisultatoLeggiIdentif := Identif;
result:=identif;
end;

function contenuta (testo, ricerca : string) : boolean;
var
   AusString : String;
begin
     result := false;
     azzeraidentif;
     while not result do
        begin
             ausstring := leggiidentif1(testo);
             result := UpperCase(AusString) = Uppercase(Ricerca);
             if ausstring = '' then break
        end
end;


Function Restoidentif(riga:string):string;
begin
result:=copy(riga,posind+1,length(riga)-posind);
end;

function W_m(i:integer):string;
begin
result:=inttostr(i);
end;
procedure writec(a:string;b:integer);
begin
end;
procedure GotoXy(x,y:real);
begin
end;
{--------------------------------  SETLEFT  ----------------------------------}
function InRange(Num,Min,Max:integer):boolean;
begin
   if (Num >=Min) and (Num <= Max) then InRange:=true
   else InRange:=false;
end;

function Percorso_word:string;
var ff:textfile;
    dr,cd:string;
begin
  if fileexists(Percorsodrive+'\Pathword.txt') then
    begin
    ASSIGNFILE(ff,Percorsodrive+'\Pathword.txt');
    RESET(ff);
    read(ff,dr);
    closefile(ff);
    end;
  result:=dr;
end;

function Percorso_progetti:string;
var ff:textfile;
    dr,cd:string;
begin
  if fileexists(Percorsodrive+'\PathProg.txt') then
    begin
    ASSIGNFILE(ff,Percorsodrive+'\PathProg.txt');
    RESET(ff);
    read(ff,dr);
    closefile(ff);
    end;
  result:=dr;
  if result[Length(result)] <> '\' then
     result := result + '\'
end;

function Percorso_Risorse : String;
Var
   Path : String;
begin
     Path := Percorso_Archivi;

     Result := Copy(Path, 1, Length(Path) - Length('Archivi\')) + 'Risorse\'
end;


function Percorso_Archivi:string;
var ff:textfile;
    dr,cd:string;
begin
  if fileexists(Percorsodrive+'\PathArch.txt') then
    begin
    ASSIGNFILE(ff,Percorsodrive+'\PathArch.txt');
    RESET(ff);
    read(ff,dr);
    closefile(ff);
    end;
  result:=dr;

  if result[Length(result)] <> '\' then
     result := result + '\'
end;

Procedure setta_Path_prog_arch(perc:string);
Var ft:textfile;
begin
assign(ft,perc+'\pathprog.txt');
rewrite(ft);
writeln(ft,perc+'\database\');
close(ft);
if not fileexists(percorso_archivi+'materiali.db') then
  begin
  assign(ft,perc+'\patharch.txt');
  rewrite(ft);
  writeln(ft,perc+'\archivi\');
  close(ft);
  end;
end;

function get_drive:string;
var ff:textfile;
    dr,cd:string;
begin
  getdir(0,cd);
  chdir(cd);
  if fileexists('drive1.int') then
    begin
    ASSIGNFILE(ff,'path.txt');
    RESET(ff);
    read(ff,dr);
    closefile(ff);
    end;
  result:=dr;
end;
Procedure  WriteMessage(NomeFile:string;CodErr:integer);
begin
end;

Function Solocaratteri(grande:string):string;
Var i:integer;
    tempgrande:string;
begin
tempgrande:='';
for i:=1 to length(grande) do
if (grande[i]<>' ')and(grande[i]<>'.')and(grande[i]<>',')
and(grande[i]<>'-')and(grande[i]<>'''') then
tempgrande:=tempgrande+upcase(grande[i]);
result:=tempgrande;
end;

Function ContieneStringa(Piccola,grande:string):boolean;
Var i,diff,lp:integer;
    tempgrande:string;
begin
result:=false;
if piccola='' then
  begin
  result:=true;
  exit;
  end;
tempgrande:=solocaratteri(grande);
if length(tempgrande)<length(piccola) then exit;
i:=1;
lp:=length(piccola);
diff:=length(tempgrande)-lp+1;
while (i<=diff)and(not result) do
  begin
  result:=(Piccola=copy(grande,i,lp));
  inc(i);
  end;
end;

function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;

Function Exist(Nomefile:string):boolean;
begin
result:=FileExists(Nomefile);
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

{----------------------------  FORMAT_STRING  --------------------------------}
FUNCTION FORMAT(ST:STRING;StLength:INTEGER):STRING;
BEGIN
  ST:=COPY(ST,1,StLength);
  FORMAT:=ST+COPY(Fill,1,StLength-LENGTH(ST));
END;      { FUNC.  FORMAT }

Function FormST(ST:STRING):String;
begin
   St:=(SetLeft(SetRight(St)));
   FormSt:=UpString(St);
end;

Function FormST1(ST:STRING):String;
begin
   St:=(SetLeft(SetRight(St)));
   FormSt1:=(St);
end;

Function Parametro(stringa:string;Num:integer):string;
Var i,count:Integer;
begin
count:=0;
i:=0;
result:='';
while (i<length(stringa))and(count<>Num-1) do
  begin
  inc(i);
  if stringa[i]=':' then inc(count);
  end;
if stringa[i]=':' then stringa[i]:=' ';
while (i<length(stringa))and(stringa[i]<>':') do
  begin
  inc(i);
  if stringa[i]<>':' then result:=result+stringa[i];
  end;

end;

// Inserimento del 03/02/2004 by Piero
function Percorso_Immagini:string;
var ff:textfile;
    dr,cd:string;
begin
     Result := Percorso_Archivi;

     // per il momento è cos' poi si dovrà collegare ad una chiamata dal registro ?!?!
end;


function Get_Msg_Errore(Tipo : Tipo_Errore; var TuttoOk, Warning : Boolean) : String;
Var
   F : TextFile;
   Testo, NomeFile : String;
begin
     Result := '';
     TuttoOk := False;
     Warning := False;
     Case Tipo of
         erLegge10 : NomeFile := PercorsoDrive + NomeFile_Errori_Disegno;
         erCad : NomeFile := PercorsoDrive + NomeFile_Errori_CAD;
         erImpianti  : NomeFile := PercorsoDrive + NomeFile_Errori_Impianti;
     end;

     if not FileExists(NomeFile) then
        begin
             TuttoOK := True;
             Exit
        end;

     AssignFile(F, NomeFile);
     Reset(F);
     while not Eof(F) do
        begin
             Readln(F, Testo);
             IF Testo = Str_Tutto_OK THEN
                TuttoOK := True
             else
                Result := Result + Testo + Rit_Carrello
        end;

     CloseFile(F);
end;

procedure Centra_Finestra(var Top, Left : Integer; Height, Width : Integer);
begin
     Top := (Screen.Height - Height) div 2;
     Left := (Screen.Width - Width) div 2;
end;

end.
