{EX UTILITIE}
unit LibreriaGenerale;

interface

uses Windows, SysUtils, dbtables, dialogs, DBCtrls, Db, Forms, Classes, IniFiles,
     Math,controls;

type Tipo_Operazione = (tpEdit, tpInsert);
     Tipo_Errore = (erLegge10, erCad, erImpianti);
     TmyMsgDlgType = (mtInfo, mtCancel);

Const
      Fill='                                                                                                 ';
   {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
      Path_Tutor = 'Risorse\Tutor\Tutor.rtf';
   {$ELSE}
      Path_Tutor = 'Tutor\Tutor.rtf';
   {$IFEND}
      NomeFile_Errori_Disegno = 'erroridisegno.txt';
      NomeFile_Errori_Impianti = 'erroriimpianti.txt';
      NomeFile_Errori_CAD = 'erroricad.txt';
      NomeFile_CalcDispOK = 'CalcDispOK.txt';
      NomeFile_CalcL10OK = 'CalcL10OK.txt';
      NomeFile_CalcEstivoOK = 'CalcEstitvoOK.txt';
      NomeFile_CalcTubiOK = 'CalcTubiOK.txt';
      NomeFile_CalcCanaliOK = 'CalcCanaliOK.txt';
      Str_Tutto_OK = '[***CONTROLLO VERIFICATO***]';
      Str_Calc_OK  = '[***CALCOLO CORRETTO***]';
      Str_Calc_No_OK = '[***CALCOLO NO CORRETTO***]';
      Rit_Carrello = #13 + #10;
      C_Non_sc='Non sc';
      C_Esterno='Esterno';
      C_Nessuno='Nessuno';
      Non_Clima='Non Climatizzato';
      Non_Risc='Non Riscaldato';
      //ManRit=0.10;  //coefficiente in metri reali, scala 1:100 0.10 m
      C_ManRit=0.1;//provvisorio in attesa di definizione da allineare con il collettore
      //RispManRit=ManRit / 4;  //coefficiente di rispetto rispetto la mandata e il ritorno
      C_RispManRit=0.05; //provvisorio in attesa di definizione da allineare con il collettore
  var Manrit:real=C_ManRit;  
      RispManrit:Real=C_RispManrit;
  function get_drive:string;
  function W_m(i:integer):string;
  Function Exist(Nomefile:string):boolean;
  Function ExistDir(percorso:string):boolean;
  FUNCTION SETLEFT(ST:STRING):STRING;
  FUNCTION SETRIGHT(ST:STRING):STRING;
  procedure leggiidentif;
  Procedure CopiaRigaDB(t1,s1,s1b,t2,s2,s2b:TTable);
  Procedure CancellaRigaDB(s1,s2:Ttable);
  Function Restoidentif(riga:string):string;
  Procedure CancellaRigaDBMasterSlave(s1,s2:Ttable);
  function Get_Msg_Errore(Tipo : Tipo_Errore; var TuttoOk, Warning : Boolean) : String;
  Function Vicino(xx1,yy1,zz1,xx2,yy2,zz2:real):boolean;
  Function float_To_str(valore:real; cdec:integer):String;
  Function str_tofloat(valore:string):real;
  Function str_toInt(valore:string):Integer;

  Function float_Tostr(valore:real):String;
  function InRange(Num,Min,Max:integer):boolean;
  Function FormST(ST:STRING):String;
  function UpString(St:string):string;
  Procedure CancellaFileCartella(percorso:string);
  Procedure CancellaFileCartellaO(percorso:string);
  function ReadDirInstallazione(Percorso: String): String;
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
  function RoundR(cifredec:integer;Valore:real):real;
  function Solocaratteri(grande:string):string;
  function ContieneStringa(Piccola,grande:string):boolean;
  function contenuta (testo, ricerca : string) : boolean;
  procedure Copia_Dati_Comuni_Tabelle(Origine, Destinazione : TTable; Operazione : Tipo_Operazione);
  function Percorso_Immagini:string;
  function Test_Climatizzazione : Boolean;
  function Test_Riscaldamento : Boolean;
  function Test_Legge10 : Boolean;
  procedure Centra_Finestra(var Top, Left : Integer; Height, Width : Integer);
  procedure Inizial;
  function leggiidentif1(riga:string):string;
  procedure azzeraidentif;
  function GetTempFile: string;
  function Percorso_Risorse:string;
  function Percorso_progetti:string;
  function Percorso_Archivi:string;
  function Percorso_RisorseGenerale:string;
  procedure AzioniDaFareNOVerf(var MSG: String; VerCD, VerFen, VerRend: String);
  // Emanuela 5/10/2004 creata una funzione per verificare se il file è corretto
  function StringaEsiste(tFile: String; St: String): Boolean;
  // Emanuela 10/11/2004: Valori che si riferiscono all'abilitazione della chiave
  procedure CaricaValoriProtezione;
  function DescrClassificazione(Classif: String): String;
  procedure Cancellafile(nomef:string);
  function VerificaVersione: Integer;
  procedure CancellaRigheDBVuote(Tab: TTable);
  function Esp(Num,Num1:real):real;
  function FormST1(ST:STRING):StRING;
  function IndZonaGeografica(ZonaGeo: String): Integer;
  procedure CancellaFileLCK(percorso:string);
  procedure Set_Errori_Impianti(Testo: String);
  procedure CalcoloCD1_CD2DM(Gradi: Real; var Cd1, Cd2: real);
  procedure EliminaFile3D(Pathwork: String);
  procedure SalvaTipologiaFabbricato(Tipo: String);
  function EsistonoCaratteriSpeciali(Parola: String): Boolean;
  function IndImpiantoTipoRegolazione(Tipo: String): Integer;
  function IndImpiantoTipoProduzione(Tipo: String): Integer;
  function IndImpiantoTipoTerminali(Tipo: String): Integer;
  function IndGeneratoreTipoInvolucro(Tipo: String): Integer;
  function IndGeneratoreTipo(Tipo: String): Integer;
  function IndZoneClassif(CL: String): Integer;
  function IndFabbricatoDataCostr(Data: String): Integer;
  function IndFabbricatoCodUb(Tipo: String): Integer;
  function IndFabbricatoSerram(Tipo: String): Integer;
  function IndFabbricatoSchermo(Tipo: String): Integer;
  function IndFabbricatoDistr(Tipo: String): Integer;
  function IndFabbricatoIntonaco(Tipo: String): Integer;
  function IndFabbricatoIsolamento(Tipo: String): Integer;
  function IndFabbricatoParEst(Tipo: String): Integer;
  function IndFabbricatoPavimenti(Tipo: String): Integer;
  function IndConfineTPavimenti(Tipo: String): Integer;
  function IndFabbricatoTipCostr(Tipo: String): Integer;
  Procedure SalvaTipoOperaFabbricato(Tipo: String);
  Procedure EliminaFileDisegno(Percorso: String);
  Function I_sl(var ss:string):string;
  Function N_sl(ss:string):string;
  function SetLung(ss:string;ln:integer):string;
  Function NumValido(Valore:string):boolean;
  Procedure CopiaCartella(percorso1,percorso2,eccetto:string);
  Procedure CancellaFileestensione(percorso,estens:string);
  Procedure CopiaCartellaEstenzione(percorso1,percorso2,estens:string);
  //Function chiediconferma(mess:string):integer;
  function EseguiProgramma(percorso,parametro:string):boolean;
  Procedure Init_DBNET(Path,nomeDll:string);
  Procedure Setta_drive;
  Procedure Copiafilefiltro(percorso1,percorso2,filtro:string);
  Procedure Sblocca_files(percorso1,estens:string);


 Var PercorsoDrive, RisultatoLeggiIdentif, Percorso_RisorseGen, Generatore,perc_word:string;
     RigaGen: Integer;
     Errore_Lettura: Boolean;
     // Emanuela 10/11/2004: Valori che si riferiscono all'abilitazione della chiave
     EdificioLB, TubiLB, EstivoLB: Boolean;
     POsind:integer;
     nocambiag:boolean=false;
     percorso_archivi_pjb:string;
     Versione_Trial:boolean=false;
     Versione_Trial_pannelli:boolean=false;
 implementation

 Var
     riga,identif:string;
     FCombo:textfile;
     tabella:string;

Procedure Setta_drive;
begin
percorsodrive:=extractfilepath(application.exename);
percorsodrive:=i_sl(percorsodrive);
end;


Procedure Init_DBNET(Path,nomeDll:string);
begin
Path:=I_sl(Path);
if not DirectoryExists(Path) then
ForceDirectories(Path);
if not DirectoryExists(Path +'private') then
ForceDirectories(Path + 'private');
if not DirectoryExists(Path +'private\' +NomeDll) then
ForceDirectories(Path +'private\' +NomeDll);
Session.PrivateDir := Path+'private' ;
Session.NetFileDir := Path ;
end;

function EseguiProgramma(percorso,parametro:string):boolean;
Var Ret:integer;
begin
result:=true;
if fileexists(percorso) then
ret:=winexec(Pchar('"'+percorso+'" "'+parametro+'"'),SW_Normal)
else
  begin
  showmessage('non esiste il programma nel percorso indicato( '+percorso+' )');
  result:=false;
  end;
end;

Function chiediconferma(mess:string):integer;
begin
case messagedlg(mess,mtConfirmation,[mbyes,mbno,mbcancel],0) of
mryes:result:=1;
mrno:result:=2;
mrcancel:result:=0;
end;
end;
Procedure CancellaFileestensione(percorso,estens:string);
 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
 begin

     perc:=I_sl(percorso)+'*.'+estens;

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := I_sl(percorso) + sr.Name;
             DeleteFile(NomeFile);
             Trovato := FindNext(sr);
        end;
 end;
Procedure CopiaCartella(percorso1,percorso2,eccetto:string);
var sr:TSearchrec;
    Trovato:integer;
begin
//createdir(percorso2);
Trovato := FindFirst(I_sl(percorso1)+'*.*',faarchive,sr);
while Trovato = 0 do
  begin
  if eccetto<>sr.name then
  copyfile(pchar(I_sl(percorso1)+sr.name),Pchar(i_sl(percorso2)+sr.name),false);
  Trovato := FindNext(sr);
  end;
end;

Procedure Sblocca_files(percorso1,estens:string);
var sr:TSearchrec;
    Trovato:integer;
begin
//createdir(percorso2);
Trovato := FindFirst(I_sl(percorso1)+'*.'+estens,faarchive,sr);
while Trovato = 0 do
  begin
  FileSetReadOnly(I_sl(percorso1)+sr.name,false);
  Trovato := FindNext(sr);
  end;
end;


Procedure CopiaCartellaEstenzione(percorso1,percorso2,estens:string);
var sr:TSearchrec;
    Trovato:integer;
begin
//createdir(percorso2);

Trovato := FindFirst(I_sl(percorso1)+'*.'+estens,faanyfile,sr);
while Trovato = 0 do
  begin
  FileSetReadOnly(I_sl(percorso1)+sr.name,false);
  copyfile(pchar(I_sl(percorso1)+sr.name),Pchar(i_sl(percorso2)+sr.name),false);
  Trovato := FindNext(sr);
  end;
end;


Procedure Copiafilefiltro(percorso1,percorso2,filtro:string);
var sr:TSearchrec;
    Trovato:integer;
begin
//createdir(percorso2);
percorso1:=i_sl(percorso1);
percorso2:=i_sl(percorso2);
Trovato := FindFirst(percorso1+filtro,faarchive,sr);
while Trovato = 0 do
  begin
  copyfile(pchar(I_sl(percorso1)+sr.name),Pchar(i_sl(percorso2)+sr.name),false);
  Trovato := FindNext(sr);
  end;
end;



Function NumValido(Valore:string):boolean;
Var err:integer;
    tmp:real;
begin
val(valore,tmp,err);
result:=err=0;
end;


Function I_sl(var ss:string):string;
begin
ss:=IncludeTrailingPathDelimiter(ss);
result:=ss;
end;
Function N_sl(ss:string):string;
begin
result:=ss;
if ss[length(ss)]='\' then result:=copy(ss,1,length(ss)-1);
end;
function SetLung(ss:string;ln:integer):string;
Var i:integer;
begin
result:=ss;
if length(ss)<ln then
for i:=1 to ln-length(ss) do  result:=result+' ';
end;

Function VerificaVersione: Integer;
var
  FIni: TIniFile;
begin
  FIni := TIniFile.Create(IncludeTrailingPathDelimiter(PercorsoDrive) + 'DatiRelazione.ini');
  Result := FIni.ReadInteger('Versione','Versione',0);
  FIni.Free;
end;

Procedure SalvaTipologiaFabbricato(Tipo: String);
var
  FIni: TIniFile;
begin
  FIni := TIniFile.Create(IncludeTrailingPathDelimiter(PercorsoDrive) + 'DatiRelazione.ini');
  FIni.WriteString('TipoProgetto', 'TipoProgetto', Tipo);
  FIni.Free;
end;

Procedure SalvaTipoOperaFabbricato(Tipo: String);
var
  FIni: TIniFile;
begin
  FIni := TIniFile.Create(IncludeTrailingPathDelimiter(PercorsoDrive) + 'DatiRelazione.ini');
  FIni.WriteString('TipoOpera', 'TipoOpera', Tipo);
  FIni.Free;
end;

 procedure CaricaValoriProtezione;
 var
   FIni: TIniFile;
 begin
  if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + 'DatiRelazione.ini') then
  begin
   FIni := TIniFile.Create(IncludeTrailingPathDelimiter(PercorsoDrive) + 'DatiRelazione.ini');
   EdificioLB := FIni.ReadBool('Protezione', 'Edificio', False);
   TubiLB     := FIni.ReadBool('Protezione', 'Tubi', False);
   EstivoLB   := FIni.ReadBool('Protezione', 'Estivo', False);
   FIni.Free;
  end;
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

 procedure SetCalcDispOK(Testo: String);
 var
  F: TextFile;
 begin
  AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcDispOK);
  try
   Rewrite(F);
   Writeln(F, Testo);
   CloseFile(F);
  except
   CloseFile(F);
  end;
 end;

 procedure SetCalcEstivoOK(Testo: String);
 var
  F: TextFile;
 begin
  AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcEstivoOK);
  try
   Rewrite(F);
   Writeln(F, Testo);
   CloseFile(F);
  except
   CloseFile(F);
  end;
 end;

 procedure SetCalcL10OK(Testo: String);
 var
  F: TextFile;
 begin
  AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcL10OK);
  try
   Rewrite(F);
   Writeln(F, Testo);
   CloseFile(F);
  except
   CloseFile(F);
  end;
 end;

 procedure SetCalcCanaliOK(Testo: String);
 var
  F: TextFile;
 begin
  AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcCanaliOK);
  try
   Rewrite(F);
   Writeln(F, Testo);
   CloseFile(F);
  except
   CloseFile(F);
  end;
 end;

 procedure SetCalcTubiOK(Testo: String);
 var
  F: TextFile;
 begin
  AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcTubiOK);
  try
   Rewrite(F);
   Writeln(F, Testo);
   CloseFile(F);
  except
   CloseFile(F);
  end;
 end;

 procedure Set_Errori_Impianti(Testo: String);
 var
  F: TextFile;
 begin
  AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_Errori_Impianti);
  try
   Rewrite(F);
   Writeln(F, Testo);
   CloseFile(F);
  except
   CloseFile(F);
  end;
 end;

 function CalcDispOK: Boolean;
 var
  F: TextFile;
  Valore: String;
  V: Boolean;
 begin
  V := False;
  Result := False;
  if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcDispOK) then
  begin
   AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcDispOK);
   try
    Reset(F);
    Readln(F, Valore);
    if Valore = Str_Calc_OK then V := True
    else if Valore = Str_Calc_No_OK then V := False;
    CloseFile(F);
    Result := V;
   except
    CloseFile(F);
   end;
  end;
 end;

 function CalcEstivoOK: Boolean;
 var
  F: TextFile;
  Valore: String;
  V: Boolean;
 begin
  V := False;
  Result := False;
  if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcEstivoOK) then
  begin
   AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcEstivoOK);
   try
    Reset(F);
    Readln(F, Valore);
    if Valore = Str_Calc_OK then V := True
    else if Valore = Str_Calc_No_OK then V := False;
    CloseFile(F);
    Result := V;
   except
    CloseFile(F);
   end;
  end;
 end;

 function CalcL10OK: Boolean;
 var
  F: TextFile;
  Valore: String;
  V: Boolean;
 begin
  V := False;
  Result := False;
  if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcL10OK) then
  begin
    AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcL10OK);
    try
     Reset(F);
     Readln(F, Valore);
     if Valore = Str_Calc_OK then V := True
     else if Valore = Str_Calc_No_OK then V := False;
     CloseFile(F);
     Result := V;
    except
     CloseFile(F);
    end;
  end;
 end;

 function CalcTubiOK: Boolean;
 var
  F: TextFile;
  Valore: String;
  V: Boolean;
 begin
  V := False;
  Result := False;
  if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcTubiOK) then
  begin
   AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcTubiOK);
   try
    Reset(F);
    Readln(F, Valore);
    if Valore = Str_Calc_OK then V := True
    else if Valore = Str_Calc_No_OK then V := False;
    CloseFile(F);
    Result := V;
   except
    CloseFile(F);
   end;
  end;
 end;


 function CalcCanaliOK: Boolean;
 var
  F: TextFile;
  Valore: String;
  V: Boolean;
 begin
  V := False;
  Result := False;
  if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcCanaliOK) then
  begin
   AssignFile(F, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcCanaliOK);
   try
    Reset(F);
    Readln(F, Valore);
    if Valore = Str_Calc_OK then V := True
    else if Valore = Str_Calc_No_OK then else V := False;
    CloseFile(F);
    Result := V;
   except
    CloseFile(F);
   end;
  end;
 end;

 function Test_Climatizzazione : Boolean;
 begin
    Result := EstivoLB;
 end;

 function Test_Riscaldamento : Boolean;
 begin
     Result := TubiLB;
 end;

 function Test_Legge10 : Boolean;
 begin
    Result := EdificioLB;
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
           if (not (Destinazione.FieldDefs[j].DataType in [ftAutoInc]))
              and (CompareStr(UpperCase(Destinazione.Fields[j].FieldName),UpperCase(Origine.Fields[i].FieldName)) = 0) then
              begin
                if Destinazione.Fields[j].DataType = ftString then
                   Destinazione.Fields[j].AsString := Origine.Fields[i].AsString
                else if Destinazione.Fields[j].DataType = ftInteger then
                        Destinazione.Fields[j].AsInteger := Origine.Fields[i].AsInteger
                     else if Destinazione.Fields[j].DataType = ftFloat then
                             Destinazione.Fields[j].AsFloat := Origine.Fields[i].AsFloat;
                   Break
              end;

     Destinazione.Post;
 end;

 function GetTempFile: string;
 var
  Buffer: array[0..MAX_PATH] OF Char;
 begin
  GetTempPath(Sizeof(Buffer)-1,Buffer);
  GetTempFileName(Buffer,'~',0,Buffer);
  result := StrPas(Buffer)
 end;

{-----------------------------------------------------------------------------
  Procedure: CancellaRigheDBVuote
  Author:    Emanuela
  Date:      27-dic-2004
  Arguments: Tab: TTable
  Result:    None

  Cancella le righe della tabella vuote
-----------------------------------------------------------------------------}
 procedure CancellaRigheDBVuote(Tab: TTable);
 begin
   Tab.Edit;
   Tab.First;
   while not Tab.Eof do
   begin
    if (CompareStr(UpperCase(Tab.TableName), UpperCase('Localita')) <> 0) and
       (CompareStr(UpperCase(Tab.TableName), UpperCase('Diametri')) <> 0) and
       (CompareStr(UpperCase(Tab.TableName), UpperCase('MatTubi')) <> 0)
    then
       if Tab.FieldByName('Codice').AsString = '' then tab.Delete;
    Tab.Next;
   end;
 end;


 Procedure D_ispose(var P:pointer);
 begin
  if p <> Nil then
  dispose(p);
  p:=nil;
 end;

 Function Vicino(xx1,yy1,zz1,xx2,yy2,zz2:real):boolean;

   function Vic(a,b:real):boolean;
    Const
      app=0.0001;
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
  if valore <> '' then
  for e:=1 to length(valore) do
   if Valore[E]=',' then Valore[E]:='.';
  val(valore,VV,e);
  result:=VV;
 end;

Function str_toInt(valore:string):Integer;
 Var E:Integer;
     vv:real;
 begin
  if valore <> '' then
  for e:=1 to length(valore) do
   if Valore[E]=',' then Valore[E]:='.';
  val(valore,VV,e);
  result:=round(VV);
 end;


 Procedure CancellaFileCartellaO(percorso:string);
 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
     i: Integer;
     Lista: TStringList;
 begin
     Lista := TStringList.Create;

     percorso := IncludeTrailingPathDelimiter(percorso);

     perc:= percorso + '*.*';

     Trovato := FindFirst(perc, faAnyFile, sr);
     while Trovato = 0 do
        begin
          // Emanuela 14/9/2004 inserita verifica affinchè non venga cancellata la
          // cartella contenente le immagini dei ponti termici

          if (Sr.Name <> '.') and (Sr.Name <> '..') then
          begin
                // Directory da preservare
                if UpperCase(Sr.Name) = 'IMMAGINI_PARETI' then
                begin
                      CancellaFileCartellaO(percorso + Sr.Name);
                      RemoveDirectory(PChar(Percorso + Sr.Name));
                end;

                if UpperCase(Sr.Name) = 'IMMAGINI_IGRO' then
                begin
                      CancellaFileCartellaO(percorso + Sr.Name);
                      RemoveDirectory(PChar(Percorso + Sr.Name));
                end;

                if (Sr.Attr and faDirectory) = 0 then
                begin

                //if (UpperCase(Sr.Name) <> 'IMMAGINI_PONTI_TERMICI') and (UpperCase(Sr.Name) <> 'IMMAGINI_IGRO') then
                //begin
                       NomeFile := percorso + sr.Name;
                       Lista.Add(NomeFile);

                       //DeleteFile(NomeFile);
                end;
          end;

          Trovato := FindNext(sr);
        end; // while
        
    FindClose(Sr);

    for i := 0 to Lista.Count - 1 do
      DeleteFile(Lista[i]);

    Lista.Free;

 end;


 //Cancella i file lck se esistono
 Procedure CancellaFileLCK(percorso:string);
 Var sr:Tsearchrec;
     NomeFile, Ext : String;
     perc:string;
     Trovato : Integer;
 begin
     perc:=percorso+'\*.*';

     Trovato := FindFirst(perc, faAnyFile, sr);
     while Trovato = 0 do
     begin
         if (sr.Name <> '.') and (sr.Name <> '..') then
         begin
            NomeFile := percorso + '\' + sr.Name;
            Ext := UpperCase(ExtractFileExt(NomeFile));
            if Ext = '.LCK' then
               DeleteFile(NomeFile);
            if sr.Attr and faDirectory > 0 then
               CancellaFileLCK(Percorso + '\' + sr.Name);
         end;
         Trovato := FindNext(sr);
     end;
 end;

 Procedure CancellaFileCartella(percorso:string);
 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
 begin
     perc:=percorso+'\*.*';

     Trovato := FindFirst(perc, faArchive, sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             DeleteFile(NomeFile);
             Trovato := FindNext(sr);
        end;
 end;

 procedure EliminaFile3D(Pathwork: String);
 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
 begin
     perc:=PathWork + '\*.T3D';

     Trovato := FindFirst(perc, faAnyFile, sr);
     while Trovato = 0 do
     begin
        NomeFile := PathWork + '\' + sr.Name;
        DeleteFile(NomeFile);
        Trovato := FindNext(sr);
     end;

     perc:=PathWork + '\*.U3D';

     Trovato := FindFirst(perc, faAnyFile, sr);
     while Trovato = 0 do
     begin
        NomeFile := PathWork + '\' + sr.Name;
        DeleteFile(NomeFile);
        Trovato := FindNext(sr);
     end;
 end;

 Procedure CopiaRigaDB(t1,s1,s1b,t2,s2,s2b:TTable);
 Var
   i, count: Integer;
 begin
  t2.Open;
  t1.Open;
  s1.Open;
  s1b.Open;
  s2.Open;
  s2b.Open;
  t2.Append;
  t2.Edit;
  if t1.FieldCount > t2.FieldCount then count := t2.FieldCount
  else count := t1.FieldCount;
  for i:=2 to Count do
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
    for i:=3 to s1b.FieldCount do
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
 Var
  i: Integer;
 begin
  if (Not IsNan(Valore)) and (Not IsInfinite(Valore)) then
  begin
    for i := 1 to cifredec do
       Valore:=Valore * 10;
    Valore:=round(Valore);
    for i := 1 to cifredec do
        Valore:=Valore / 10;
    result:=valore;
  end
  else Result := 0;  
 end;

Procedure azzeraidentif;
begin
  posind:=0;
end;

Function leggiidentif1(riga:string):string;
Var i:integer;
    identif:string;
begin
if posind=length(riga)then
  begin
  result:='';
  exit;
  end;
i:=posind+1;
if i<length(riga) then
while (riga[i]<>':')and(i<length(riga)) do inc(i);

if riga[i]=':' then
Identif:=copy(riga,posind+1,i-posind-1)
else Identif:=copy(riga,posind+1,i-posind);

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

{--------------------------------  SETLEFT  ----------------------------------}
function InRange(Num,Min,Max:integer):boolean;
begin
   if (Num >=Min) and (Num <= Max) then InRange:=true
   else InRange:=false;
end;

function Percorso_word: String;
var ff:textfile;
    dr:string;
begin
  Result := '';
  if fileexists(IncludeTrailingPathDelimiter(Percorsodrive) + 'Pathword.txt') then
  begin
    AssignFile(ff, IncludeTrailingPathDelimiter(Percorsodrive) + 'Pathword.txt');
    try
     Reset(ff);
     read(ff,dr);
     closefile(ff);
     result:=dr;
    except
     CloseFile(ff);
    end;
  end;
end;

function Percorso_progetti:string;
var ff:textfile;
    dr:string;
begin
  Result := '';
  if fileexists(IncludeTrailingPathDelimiter(Percorsodrive) + 'PathProg.txt') then
  begin
    AssignFile(ff, IncludeTrailingPathDelimiter(Percorsodrive) + 'PathProg.txt');
    try
     Reset(ff);
     read(ff,dr);
     closefile(ff);
     result:= IncludeTrailingPathDelimiter(dr);
    except
     closefile(ff);
    end;
  end;
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
    dr:string;
begin
//result:=I_sl(percorsodrive)+'archivi\';

  Result := '';
  if fileexists(IncludeTrailingPathDelimiter(Percorsodrive) + 'PathArch.txt') then
  begin
    ASSIGNFILE(ff, IncludeTrailingPathDelimiter(Percorsodrive) + 'PathArch.txt');
    try
     RESET(ff);
     read(ff,dr);
     closefile(ff);
     result:= IncludeTrailingPathDelimiter(dr);
    except
     closefile(ff);
    end;
  end;

end;

function Percorso_RisorseGenerale:string;
var ff:textfile;
    dr:string;
begin
  Result := '';
  if fileexists(IncludeTrailingPathDelimiter(Percorsodrive) + 'PathRisorse.txt') then
  begin
    ASSIGNFILE(ff, IncludeTrailingPathDelimiter(Percorsodrive) + 'PathRisorse.txt');
    try
     RESET(ff);
     read(ff,dr);
     closefile(ff);
     result := IncludeTrailingPathDelimiter(dr);
    except
     closefile(ff);
    end;
  end;
end;

function get_drive:string;
var ff:textfile;
    dr,cd:string;
begin
  Result := '';
  getdir(0,cd);
  chdir(cd);
  if fileexists('drive1.int') then
  begin
    ASSIGNFILE(ff,'path.txt');
    try
     RESET(ff);
     read(ff,dr);
     closefile(ff);
     result:=dr;
    except
     closefile(ff);
    end;
  end;
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

Function ContieneStringa(Piccola, grande:string):boolean;
Var
  i,diff,lp:integer;
  tempgrande:string;
begin
  result:=false;
  if piccola = '' then
  begin
   result:=true;
   exit;
  end;
  tempgrande := solocaratteri(grande);
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

Function ExistDir(percorso:string):boolean;
var dircor:string;
begin
getdir(0,dircor);
{$I-}
chdir(percorso);
{$I+}
result:=ioresult=0;
chdir(dircor);
end;

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
         erLegge10 : NomeFile := IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_Errori_Disegno;
         erCad : NomeFile := IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_Errori_CAD;
         erImpianti  : NomeFile := IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_Errori_Impianti;
     end;

     if not FileExists(NomeFile) then
        begin
             TuttoOK := True;
             Exit
        end;

     AssignFile(F, NomeFile);
     try
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
     except
       CloseFile(F);
     end;
end;

procedure Centra_Finestra(var Top, Left : Integer; Height, Width : Integer);
begin
     Top := (Screen.Height - Height) div 2;
     Left := (Screen.Width - Width) div 2;
end;

procedure Inizial;
begin
     DecimalSeparator := '.';
     Application.UpdateFormatSettings := False;
     // Emanuela 10/11/2004: caricamento dei valori di protezione
     EdificioLB := False;
     TubiLB     := False;
     EstivoLB   := False;
end;

function ReadDirInstallazione(Percorso: String): String;
var
  j: Integer;
begin
 {$IFDEF VERSIONE_12}
  j := Pos(UpperCase('Versione_12'), Percorso);
 {$ELSEIF DEFINED(VERSIONE_13)}
  j := Pos(UpperCase('Versione_13'), Percorso);
 {$ELSE}
  j := Pos(UpperCase('Versione_11'), Percorso);
 {$IFEND}
  Result := Copy(Percorso, 1, j - 1);
end;

procedure leggiidentif;
Var
  i:integer;
begin
  i:=posind+1;
  while (riga[i]<>':')and(i<length(riga)) do inc(i);
  if i=posind+1 then
  identif:=''
  else
  Identif:=copy(riga,posind+1,i-posind-1);
  POsind:=i;
end;

Const spazVert=5;
      Maxrighe=10;

procedure AzioniDaFareNOVerf(var MSG: String; VerCD, VerFen, VerRend: String);
begin
  if (VerCD = 'Si') and (VerFen = 'Si') and (VerRend = 'Si') then
  begin
    MSG := 'Il calcolo è stato effettuato correttamente e le verifiche sono soddisfatte';
  end
  else
  if (VerCD = 'No') and (VerFen = 'Si') and (VerRend = 'Si') then
  begin
    MSG := 'Il valore del Cd non è verificato, modificare i valori delle trasmittanze k delle strutture.';
  end
  else
  if (VerCD = 'Si') and (VerFen = 'No') and (VerRend = 'Si') then
  begin
    MSG := 'Il valore del FEN non è Verificato. Controllare' + #13#10;
    MSG := MSG + '- il numero di ricambi dovuti sia alla ventilazione naturale (Infiltrazioni) che all''aria trattata (Ventilazione meccanica), ' + #13#10;
    MSG := MSG + '  nella maschera Zone Termiche. Se le quantità assumono valori troppo alti diminuire questi valori;' + #13#10;
    MSG := MSG + '- il numero di ricambi d''aria per persona (Trattata) o il numero di ricambi imposto (calcolo con DPR 412 art. 8 comma 9) ' + #13#10;
    MSG := MSG + '  nella maschera Zone Termiche (se attivato). Questo dato incrementa il valore del Fen limite;' + #13#10;
    MSG := MSG + '- il fattore di Shading dello schermo dei serramenti vetrati.' + #13#10;
    MSG := MSG + '  Effettuare la selezione in modo da avere un valore abbastanza vicino all''unità.' + #13#10;
  end
  else
  if (VerCD = 'Si') and (VerFen = 'Si') and (VerRend = 'No') then
  begin
    MSG := 'I valore dei rendimenti non sono verificati. Controllare' + #13#10;
    MSG := MSG + '- nel sistema di regolazione di aver inserito la combinazione che';
    MSG := MSG + '  dia un valore di rendimento alto (vedi norma UNI 10348 Prospetto II).';
    MSG := MSG + '  Modificare in Dati Impianto - box Dati per la verifica di Legge 10 i ';
    MSG := MSG + '  seguenti campi: Sistema di regolazione e Tipologia di prodotto. ;' + #13#10;
    MSG := MSG + '- che il numero di ore inserite nei due campi relativi al periodo di attenuazione';
    MSG := MSG + '  o spegnimento dell''impianto di riscaldamento (espresso in ore) corrisponda al';
    MSG := MSG + '  periodo di spegnimento giornaliero e che i giorni settimanali di attenuazione';
    MSG := MSG + '  o spegnimento inseriti corrispondano al numero di giorni in cui l’impianto di';
    MSG := MSG + '  riscaldamento è spento; ' + #13#10;
    MSG := MSG + '- la potenza del generatore (Potenza nominale utile del sistema di produzione) sia';
    MSG := MSG + '  superiore o comunque vicino al valore delle dispersioni termiche calcolate da';
    MSG := MSG + '  programma.;' + #13#10;
    MSG := MSG + '- che il valore delle perdite di distribuzione non sia troppo grande.' + #13#10;
  end
  else
  if (VerCD = 'No') and (VerFen = 'No') and (VerRend = 'Si') then
  begin
   MSG := 'I valori del CD e del FEN non sono verificati. Controllare' + #13#10;
   MSG := MSG + '- i valori delle trasmittanze k delle strutture;'+ #13#10;
   MSG := MSG + '- il numero di ricambi dovuti sia alla ventilazione naturale (Infiltrazioni) che all''aria trattata (Ventilazione meccanica), ' + #13#10;
   MSG := MSG + '  nella maschera Zone Termiche. Se le quantità assumono valori troppo alti diminuire questi valori;' + #13#10;
   MSG := MSG + '- il numero di ricambi d''aria per persona (Trattata) o il numero di ricambi imposto (calcolo con DPR 412 art. 8 comma 9) ' + #13#10;
   MSG := MSG + '  nella maschera Zone Termiche (se attivato). Questo dato incrementa il valore del Fen limite;' + #13#10;
   MSG := MSG + '- il fattore di Shading dello schermo dei serramenti vetrati.' + #13#10;
   MSG := MSG + '  Effettuare la selezione in modo da avere un valore abbastanza vicino all''unità.' + #13#10;
  end
  else
  if (VerCD = 'Si') and (VerFen = 'No') and (VerRend = 'No') then
  begin
    MSG := 'I valori del FEN e dei rendimenti non sono verificati. Controllare' + #13#10;
    MSG := MSG + '- il numero di ricambi dovuti sia alla ventilazione naturale (Infiltrazioni) che all''aria trattata (Ventilazione meccanica), ' + #13#10;
    MSG := MSG + '  nella maschera Zone Termiche. Se le quantità assumono valori troppo alti diminuire questi valori;' + #13#10;
    MSG := MSG + '- il numero di ricambi d''aria per persona (Trattata) o il numero di ricambi imposto (calcolo con DPR 412 art. 8 comma 9) ' + #13#10;
    MSG := MSG + '  nella maschera Zone Termiche (se attivato). Questo dato incrementa il valore del Fen limite;' + #13#10;
    MSG := MSG + '- il fattore di Shading dello schermo dei serramenti vetrati.' + #13#10;
    MSG := MSG + '  Effettuare la selezione in modo da avere un valore abbastanza vicino all''unità.' + #13#10;
    MSG := MSG + '- nel sistema di regolazione di aver inserito la combinazione che';
    MSG := MSG + '  dia un valore di rendimento alto (vedi norma UNI 10348 Prospetto II).';
    MSG := MSG + '  Modificare in Dati Impianto - box Dati per la verifica di Legge 10 i ';
    MSG := MSG + '  seguenti campi: Sistema di regolazione e Tipologia di prodotto. ;' + #13#10;
    MSG := MSG + '- che il numero di ore inserite nei due campi relativi al periodo di attenuazione';
    MSG := MSG + '  o spegnimento dell''impianto di riscaldamento (espresso in ore) corrisponda al';
    MSG := MSG + '  periodo di spegnimento giornaliero e che i giorni settimanali di attenuazione';
    MSG := MSG + '  o spegnimento inseriti corrispondano al numero di giorni in cui l’impianto di';
    MSG := MSG + '  riscaldamento è spento; ' + #13#10;
    MSG := MSG + '- la potenza del generatore (Potenza nominale utile del sistema di produzione) sia';
    MSG := MSG + '  superiore o comunque vicino al valore delle dispersioni termiche calcolate da';
    MSG := MSG + '  programma.;' + #13#10;
    MSG := MSG + '- che il valore delle perdite di distribuzione non sia troppo grande.' + #13#10;
  end
  else if (VerCD = 'No') and (VerFen = 'No') and (VerRend = 'No') then
       begin
         MSG := 'I valori del CD, del FEN e dei rendimenti non sono verificati. Controllare' + #13#10;
         MSG := MSG + '- i valori delle trasmittanze k delle strutture;' + #13#10;
         MSG := MSG + '- il numero di ricambi dovuti sia alla ventilazione naturale (Infiltrazioni) che all''aria trattata (Ventilazione meccanica), ' + #13#10;
         MSG := MSG + '  nella maschera Zone Termiche. Se le quantità assumono valori troppo alti diminuire questi valori;' + #13#10;
         MSG := MSG + '- il numero di ricambi d''aria per persona (Trattata) o il numero di ricambi imposto (calcolo con DPR 412 art. 8 comma 9) ' + #13#10;
         MSG := MSG + '  nella maschera Zone Termiche (se attivato). Questo dato incrementa il valore del Fen limite;' + #13#10;
         MSG := MSG + '- il fattore di Shading dello schermo dei serramenti vetrati.' + #13#10;
         MSG := MSG + '  Effettuare la selezione in modo da avere un valore abbastanza vicino all''unità.' + #13#10;
         MSG := MSG + '- nel sistema di regolazione di aver inserito la combinazione che';
         MSG := MSG + '  dia un valore di rendimento alto (vedi norma UNI 10348 Prospetto II).';
         MSG := MSG + '  Modificare in Dati Impianto - box Dati per la verifica di Legge 10 i ';
         MSG := MSG + '  seguenti campi: Sistema di regolazione e Tipologia di prodotto. ;' + #13#10;
         MSG := MSG + '- che il numero di ore inserite nei due campi relativi al periodo di attenuazione';
         MSG := MSG + '  o spegnimento dell''impianto di riscaldamento (espresso in ore) corrisponda al';
         MSG := MSG + '  periodo di spegnimento giornaliero e che i giorni settimanali di attenuazione';
         MSG := MSG + '  o spegnimento inseriti corrispondano al numero di giorni in cui l’impianto di';
         MSG := MSG + '  riscaldamento è spento; ' + #13#10;
         MSG := MSG + '- la potenza del generatore (Potenza nominale utile del sistema di produzione) sia';
         MSG := MSG + '  superiore o comunque vicino al valore delle dispersioni termiche calcolate da';
         MSG := MSG + '  programma.;' + #13#10;
         MSG := MSG + '- che il valore delle perdite di distribuzione non sia troppo grande.' + #13#10;
       end;
end;

{-----------------------------------------------------------------------------
  Procedure: StringaEsiste
  Author:    Emanuela
  Date:      05-ott-2004
  Arguments: tFile: String; St: String
  Result:    None

  verifica se c'è una stringa nel file
-----------------------------------------------------------------------------}

function StringaEsiste(tFile: String; St: String): Boolean;
const
  Et1  = '--------------------------------------->STRUTTURE';
  Et2  = '--------------------------------------->FINESTRE';
  Et3  = '--------------------------------------->CONFINE';
  Et4  = '--------------------------------------->ORARI';
  Et5  = '--------------------------------------->GENERATORI';
  Et6  = '--------------------------------------->PIANI';
  Et7  = '--------------------------------------->DESCSTAMPE';
  Et8  = '--------------------------------------->FABBRICATO';
  Et9  = '--------------------------------------->ZONE';
  Et10 = '--------------------------------------->IMPIANTI';
  Et11 = '--------------------------------------->PONTI';
  Et12 = '--------------------------------------->LOCALI';
 {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
  Et13 = '--------------------------------------->CARICHIINTERNI';
  Et14 = '--------------------------------------->PERDITE_CONC';
 {$IFEND}
 {$IFDEF CANALI}
  Et15 = '--------------------------------------->UPDATE';
 {$ENDIF}
  Et16 = '--------------------------------------->TIPIRETE';
  Et17 = '--------------------------------------->PERDITE';
var
  FileStr: TStringList;
  Val1, Val2, Val3, Val4, Val5, Val6, Val7, Val8, Val9: Integer;
  Val10, Val11, Val12, Val13, Val14, Val15, Val16, Val17, Val18: Integer;
begin
  Result := False;
  FileStr := TStringList.Create;
  FileStr.LoadFromFile(tFile);
  Val1  := Pos(St, FileStr.Text);
  Val2  := Pos(Et1, FileStr.Text);
  Val3  := Pos(Et2, FileStr.Text);
  Val4  := Pos(Et3, FileStr.Text);
  Val5  := Pos(Et4, FileStr.Text);
  Val6  := Pos(Et5, FileStr.Text);
  Val7  := Pos(Et6, FileStr.Text);
  Val8  := Pos(Et7, FileStr.Text);
  Val9  := Pos(Et8, FileStr.Text);
  Val10 := Pos(Et9, FileStr.Text);
  Val11 := Pos(Et10, FileStr.Text);
  Val12 := Pos(Et11, FileStr.Text);
  Val13 := Pos(Et12, FileStr.Text);
 {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
  Val14 := Pos(Et13, FileStr.Text);
  Val15 := Pos(Et14, FileStr.Text);
 {$IFEND}
 {$IFDEF CANALI}
  Val16 := Pos(Et15, FileStr.Text);
 {$ENDIF}
  Val17 := Pos(Et16, FileStr.Text);
  Val18 := Pos(Et17, FileStr.Text);
  if (Val14 = 0) and (Val15 = 0) then
  begin
    Val14 := 1;
    Val15 := 1;
  end;
  if (Val1 > 0) and (Val2 > 0) and (Val3 > 0) and (Val4 > 0) and
     (Val5 > 0) and (Val6 > 0) and (Val7 > 0) and (Val8 > 0) and
     (Val9 > 0) and (Val10 > 0) and (Val11 > 0) and (Val12 > 0) and
     (Val13 > 0) {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}and (Val14 > 0) and (Val15 > 0){$IFEND}
      and {$IFDEF CANALI} (Val16 > 0) and {$ENDIF}
     (Val17 > 0) and (Val18 > 0)
  then
     Result := True;
end;

function Esp(Num,Num1:real):real;
begin
   if Num > 0 then
    Esp:=EXP(Num1*ln(Num))
   else Esp:=0;
end;

{-----------------------------------------------------------------------------
  Procedure: DescrClassficazione
  Author:    Emanuela
  Date:      10-dic-2004
  Arguments: Classif: String
  Result:    String

  funzione che restituisce la descrizione della classificazione
-----------------------------------------------------------------------------}
function DescrClassificazione(Classif: String): String;
begin
    if Classif = 'E1(1)' then
       Result := #13#10 + 'Abitazioni adibite a residenza con carattere continuativo'
    else
    if Classif = 'E1(2)' then
       Result := #13#10 + 'Abitazioni adibite a residenza con occupazione saltuaria'
    else
    if Classif = 'E1(3)' then
       Result := #13#10 + 'Edifici adibiti ad albergo, pensione ed attività similari'
    else
    if Classif = 'E2' then Result := #13#10 + 'Edifici adibiti a uffici e assimilabili'
    else
    if Classif = 'E3' then
       Result := #13#10 + 'Edifici adibiti a ospedali, cliniche o case di cura' + #13#10' e assimilabili'
    else
    if Classif = 'E4(1)' then Result := #13#10 + 'Cinema, teatri, sale congressi'
    else
    if Classif = 'E4(2)' then Result := #13#10 + 'Mostre, musei, biblioteche, luoghi di culto'
    else
    if Classif = 'E4(3)' then Result := #13#10 + 'Bar, ristoranti, sale da ballo'
    else
    if Classif = 'E5' then Result := #13#10 + 'Edifici adibiti ad attività commerciali e assimilabili'
    else
    if Classif = 'E6(1)' then Result := #13#10 + 'Piscine, saune e simili'
    else
    if Classif = 'E6(2)' then Result := #13#10 + 'Palestre e simili'
    else
    if Classif = 'E6(3)' then Result := #13#10 + 'Servizi di supporto alle attività sportive'
    else
    if Classif = 'E7' then Result := #13#10 + 'Edifici adibiti ad attività scolastiche a tutti i livelli' + #13#10 + ' e assimilabili'
    else
    if Classif = 'E8' then Result := #13#10 + 'Edifici adibiti ad attività industriali e artigianali' + #13#10 + ' e assimilabili';
end;

{-----------------------------------------------------------------------------
  Procedure: IndZonaGeografica
  Author:    Emanuela
  Date:      15-lug-2005
  Arguments: ZonaGeo: String
  Result:    Integer

  Restituisce un indice per la zona geografica
  1: ITALIA SETTENTRIONALE TRANSPADANA:
  2: ITALIA SETTENTRIONALE CISPADANA:
  3: ITALIA CENTRALE E MERIDIONALE:
  4: SICILIA:
  5: SARDEGNA:
-----------------------------------------------------------------------------}
function IndZonaGeografica(ZonaGeo: String): Integer;
const
  Zona1 = 'ITALIA SETTENTRIONALE TRANSPADANA';
  Zona2 = 'ITALIA SETTENTRIONALE CISPADANA';
  Zona3 = 'ITALIA CENTRALE E MERIDIONALE';
  Zona4 = 'SICILIA';
  Zona5 = 'SARDEGNA';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(ZonaGeo) = Zona1 then  Result := 1
  else
   if UpperCase(ZonaGeo) = Zona2 then  Result := 2
   else
    if UpperCase(ZonaGeo) = Zona3 then  Result := 3
    else
     if UpperCase(ZonaGeo) = Zona4 then  Result := 4
     else
      if UpperCase(ZonaGeo) = Zona5 then  Result := 5;
   if Result = 0 then
   begin
     St := 'La zona geografica ' + ZonaGeo + ' è inesistente. Controllare i dati della Località impostata nella maschera dati Progetto';
     MessageDlg(st, mtInformation, [mbOK], 0);
   end;

end;

{-----------------------------------------------------------------------------
  Procedure: IndImpiantoTipoRegolazione
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: restituisce il tipo regolazione dell'impianto
-----------------------------------------------------------------------------}
function IndImpiantoTipoRegolazione(Tipo: String): Integer;
const
  Tipo1 = 'Regolazione manuale';
  Tipo2 = 'Climatico centralizzato';
  Tipo3 = 'Solo per singolo ambiente';
  Tipo4 = 'Climatico + singolo ambiente';
  Tipo5 = 'Solo di zona';
  Tipo6 = 'Climatico + zona';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3
    else
     if UpperCase(Tipo) = UpperCase(Tipo4) then  Result := 4
     else
      if UpperCase(Tipo) = UpperCase(Tipo5) then  Result := 5
      else
       if UpperCase(Tipo) = UpperCase(Tipo6) then  Result := 6;
   if Result = 0 then
   begin
     St := 'Il tipo regolazione ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera degli Impianti';
     MessageDlg(st, mtInformation, [mbOK], 0);
   end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndImpiantoTipoProduzione
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: restituisce l'indice del tipo produzione degli impianti
-----------------------------------------------------------------------------}
function IndImpiantoTipoProduzione(Tipo: String): Integer;
const
  Tipo1 = 'Termostato di caldaia';
  Tipo2 = 'Regolatore climatico e/o ottimizzatore';
  Tipo3 = 'Regolatore si/no a differenziale';
  Tipo4 = 'Regolatore modulante (banda proporzionale 1 °C)';
  Tipo5 = 'Regolatore modulante (banda proporzionale 2 °C)';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3
    else
     if UpperCase(Tipo) = UpperCase(Tipo4) then  Result := 4
     else
      if UpperCase(Tipo) = UpperCase(Tipo5) then  Result := 5;
   if Result = 0 then
   begin
     St := 'Il tipo produzione ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera degli Impianti';
     MessageDlg(st, mtInformation, [mbOK], 0);
   end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndImpiantoTipoTerminali
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice del tipo terminale
-----------------------------------------------------------------------------}
function IndImpiantoTipoTerminali(Tipo: String): Integer;
const
 {$IFDEF VERSIONE_13}
  Tipo1 = 'Termoconvettori';
  Tipo2 = 'Ventilconvettori';
  Tipo3 = 'Bocchette aria calda';
  Tipo4 = 'Radiatori, tutte le tipologie esclusa la successiva';
  Tipo5 = 'Radiatori con superficie di emissione piana e continua';
  Tipo6 = 'Pannelli radianti isolati dalle strutture';
  Tipo7 = 'Pannelli annegati a pavimento';
  Tipo8 = 'Pannelli annegati a soffitto';
 {$ELSE}
  Tipo1 = 'Termoconvettori';
  Tipo2 = 'Ventilconvettori';
  Tipo3 = 'Bocchette aria calda';
  Tipo4 = 'Radiatori';
  Tipo5 = 'Pannelli radianti isolati dalle strutture';
  Tipo6 = 'Pannelli radianti annegati nelle strutture';
 {$ENDIF}
var
  St: String;
Begin
  Result := 0;
 {$IFDEF VERSIONE_13}
  if CompareStr(UpperCase(Tipo), 'RADIATORI') = 0 then
     Result := 4
  else
   if CompareStr(UpperCase(Tipo), 'PANNELLI RADIANTI ANNEGATI NELLE STRUTTURE') = 0 then
      Result := 7
   else
 {$ENDIF}
    if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
    else
     if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
     else
      if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3
      else
       if UpperCase(Tipo) = UpperCase(Tipo4) then  Result := 4
       else
        if UpperCase(Tipo) = UpperCase(Tipo5) then  Result := 5
        else
         if UpperCase(Tipo) = UpperCase(Tipo6) then  Result := 6
        {$IFDEF VERSIONE_13}
         else
          if UpperCase(Tipo) = UpperCase(Tipo7) then  Result := 7
          else
           if UpperCase(Tipo) = UpperCase(Tipo8) then  Result := 8
        {$ENDIF};
   if Result = 0 then
   begin
     St := 'Il tipo Terminale ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera degli Impianti';
     MessageDlg(st, mtInformation, [mbOK], 0);
   end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndGeneratoreTipoInvolucro
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice del tipo involucro
-----------------------------------------------------------------------------}
function IndGeneratoreTipoInvolucro(Tipo: String): Integer;
const
  Tipo1 = 'In ottimo stato ad alto rendimento';
  Tipo2 = 'In ottimo stato';
  Tipo3 = 'Obsoleto e mediamente isolato';
  Tipo4 = 'Obsoleto e male isolato';
  Tipo5 = 'Obsoleto e privo di isolamento';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3
    else
     if UpperCase(Tipo) = UpperCase(Tipo4) then  Result := 4
     else
      if UpperCase(Tipo) = UpperCase(Tipo5) then  Result := 5;
   if Result = 0 then
   begin
     St := 'Il tipo Involucro ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera dei Generatori';
     MessageDlg(st, mtInformation, [mbOK], 0);
   end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndGeneratoreTipo
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer

  Cosa fa: Restituisce il tipo di generatore
-----------------------------------------------------------------------------}
function IndGeneratoreTipo(Tipo: String): Integer;
const
  Tipo1 = 'Caldaia';
  Tipo2 = 'Pompa di calore';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2;
  if Result = 0 then
  begin
     St := 'Il tipo generatore ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera dei Generatori';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndZoneClassif
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: CL: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice della classificazione
-----------------------------------------------------------------------------}
function IndZoneClassif(CL: String): Integer;
const
  CL1 = 'E1(1)';
  CL2 = 'E1(2)';
  CL3 = 'E1(3)';
  CL4 = 'E2';
  CL5 = 'E3';
  CL6 = 'E4(1)';
  CL7 = 'E4(2)';
  CL8 = 'E4(3)';
  CL9 = 'E5';
  CL10 = 'E6(1)';
  CL11 = 'E6(2)';
  CL12 = 'E6(3)';
  CL13 = 'E7';
  CL14 = 'E8';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(CL) = UpperCase(CL1) then  Result := 1
  else
   if UpperCase(CL) = UpperCase(CL2) then  Result := 2
   else
   if UpperCase(CL) = UpperCase(CL3) then  Result := 3
   else
   if UpperCase(CL) = UpperCase(CL4) then  Result := 4
   else
   if UpperCase(CL) = UpperCase(CL5) then  Result := 5
   else
   if UpperCase(CL) = UpperCase(CL6) then  Result := 6
   else
   if UpperCase(CL) = UpperCase(CL7) then  Result := 7
   else
   if UpperCase(CL) = UpperCase(CL8) then  Result := 8
   else
   if UpperCase(CL) = UpperCase(CL9) then  Result := 9
   else
   if UpperCase(CL) = UpperCase(CL10) then  Result := 10
   else
   if UpperCase(CL) = UpperCase(CL11) then  Result := 11
   else
   if UpperCase(CL) = UpperCase(CL12) then  Result := 12
   else
   if UpperCase(CL) = UpperCase(CL13) then  Result := 13
   else
   if UpperCase(CL) = UpperCase(CL10) then  Result := 14;
  if Result = 0 then
  begin
     St := 'La Classificazione ' + CL + ' è inesistente. Controllare i dati impostati nella maschera delle Zone';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoDataCostr
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Data: String
  Result:    Integer

  Cosa fa: Restituisce l'indice della data di costruzione
-----------------------------------------------------------------------------}
function IndFabbricatoDataCostr(Data: String): Integer;
const
  Tipo1 = 'Dopo il 1987';
  Tipo2 = 'Prima del 1987';
var
  St: String;
Begin
  Result := 2;
  if UpperCase(DAta) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Data) = UpperCase(Tipo2) then  Result := 2;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoCodUb
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice dell'ubicazione dell'edificio
-----------------------------------------------------------------------------}
function IndFabbricatoCodUb(Tipo: String): Integer;
const
  Tipo1 = 'Centro urbano';
  Tipo2 = 'Periferia';
  Tipo3 = 'Campagna';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3;
  if Result = 0 then
  begin
     St := 'L''ubicazione ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoSerram
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: restituisce l'indice del codice dei serramenti
-----------------------------------------------------------------------------}
function IndFabbricatoSerram(Tipo: String): Integer;
const
  Tipo1 = 'Elevata';
  Tipo2 = 'Media';
  Tipo3 = 'Bassa';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3;
  if Result = 0 then
  begin
     St := 'Il serramento ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoSchermo
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: restituisce l'indice del tipo schermo
-----------------------------------------------------------------------------}
function IndFabbricatoSchermo(Tipo: String): Integer;
const
  Tipo1 = 'Non schermato';
  Tipo2 = 'Parzialmente schermato';
  Tipo3 = 'Totalmente schermato';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3;
  if Result = 0 then
  begin
     St := 'Il tipo schermo ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoDistr
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice del tipo distribuzione
-----------------------------------------------------------------------------}
function IndFabbricatoDistr(Tipo: String): Integer;
const
  Tipo1 = 'A';
  Tipo2 = 'B';
  Tipo3 = 'C';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3;
  if Result = 0 then
  begin
     St := 'Il tipo distribuzione ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoIntonaco
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice del tipo di intonaco
-----------------------------------------------------------------------------}
function IndFabbricatoIntonaco(Tipo: String): Integer;
const
  Tipo1 = 'Malta';
  Tipo2 = 'Gesso';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2;
  if Result = 0 then
  begin
     St := 'Il tipo intonaco ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoIntonaco
  Author:    e.diquattro
  Date:      04-ott-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: ritorna l'indice della tipologia costruttiva
-----------------------------------------------------------------------------}
function IndFabbricatoTipCostr(Tipo: String): Integer;
const
  Tipo1 = 'Edifici con muri di pietra o assimilabili';
  Tipo2 = 'Edifici con muri di mattoni pieni o assimilabili';
  Tipo3 = 'Edifici con muri di mattoni forati o assimilabili';
  Tipo4 = 'Edifici con pareti leggere o isolati dall''interno';
var
  St: String;
Begin
  Result := 0;
 if Tipo = '' then Result := 1
 else
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3
    else
     if UpperCase(Tipo) = UpperCase(Tipo4) then  Result := 4;
  if Result = 0 then
  begin
     St := 'Il tipo tipologia costruttiva ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoIsolamento
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice del tipo isolamento
-----------------------------------------------------------------------------}
function IndFabbricatoIsolamento(Tipo: String): Integer;
const
  Tipo1 = 'Assente o Esterno';
  Tipo2 = 'Interno';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2;
  if Result = 0 then
  begin
     St := 'Il tipo isolamento ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoParEst
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer

  Cosa fa: Restituisce l'indice il tipo di parete esterna
-----------------------------------------------------------------------------}
function IndFabbricatoParEst(Tipo: String): Integer;
const
  Tipo1 = 'Medie';
  Tipo2 = 'Leggere o Blocchi';
  Tipo3 = 'Pesanti';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3;
  if Result = 0 then
  begin
     St := 'Il tipo di parete esterna ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndFabbricatoPavimenti
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice il tipo di pavimenti
-----------------------------------------------------------------------------}
function IndFabbricatoPavimenti(Tipo: String): Integer;
const
  Tipo1 = 'Piastrelle';
  Tipo2 = 'Tessile';
  Tipo3 = 'Legno';
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3;
  if Result = 0 then
  begin
     St := 'Il tipo pavimento ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera del Fabbricato';
     MessageDlg(st, mtInformation, [mbOK], 0);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: IndConfineTPavimenti
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Tipo: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice del tipo pavimento terreno
-----------------------------------------------------------------------------}
function IndConfineTPavimenti(Tipo: String): Integer;
const
  Tipo1 = '1 - PAVIMENTO. SU TERR. SENZA ISOLAM./CON ISOLAM. UNIFORME';
  Tipo2 = '2 - PAV. CON ISOLAM. PERIMETRALE ORIZZONTALE';
 {$IFDEF VERSIONE_13}
  Tipo3 = '3 - PAV. CON ISOLAM. PERIMETR. VERTICALE (strato Isolante)';       // caso di calcolo 3
  Tipo4 = '4 - PAV. CON ISOLAM. PERIMETR. VERTICALE (fondazione a bassa densità)';
  Tipo5 = '5 - PAVIMENTO SU SPAZIO AERATO';                                  // caso calcolo 4
  Tipo6 = '6 - PAVIMENTO INTERRATO RISCALDATO';                              // caso calcolo 5
  Tipo7 = '7 - PAVIMENTO INTERRATO NON RISCALDATO O PARZIALMENTE RISC.';     // caso calcolo 6
 {$ELSE}
  Tipo3 = '3 - PAV. CON ISOLAM. PERIMETR. VERTICALE E ASSIMILABILI';
  Tipo4 = '4 - PAVIMENTO SU SPAZIO AERATO';
  Tipo5 = '5 - PAVIMENTO INTERRATO';
 {$ENDIF}
var
  St: String;
Begin
  Result := 0;
  if UpperCase(Tipo) = UpperCase(Tipo1) then  Result := 1
  else
   if UpperCase(Tipo) = UpperCase(Tipo2) then  Result := 2
   else
   {$IFDEF VERSIONE_13}
    if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3
    else
     if UpperCase(Tipo) = UpperCase(Tipo4) then  Result := 3
     else
      if UpperCase(Tipo) = UpperCase(Tipo5) then  Result := 4
      else
      if UpperCase(Tipo) = UpperCase(Tipo6) then  Result := 5
        else
        if UpperCase(Tipo) = UpperCase(Tipo7) then  Result := 6;
    {$ELSE}
        if UpperCase(Tipo) = UpperCase(Tipo3) then  Result := 3
        else
         if UpperCase(Tipo) = UpperCase(Tipo4) then  Result := 4
         else
          if UpperCase(Tipo) = UpperCase(Tipo5) then  Result := 5;
    {$ENDIF}
   if Result = 0 then
   begin
     St := 'Il tipo pavimento su terreno ' + Tipo + ' è inesistente. Controllare i dati impostati nella maschera dei Confini';
     MessageDlg(st, mtInformation, [mbOK], 0);
   end;
end;

{-----------------------------------------------------------------------------
  Procedure: CalcoloCD1_CD2DM
  Author:    e.diquattro
  Date:      01-ago-2006
  Arguments: Gradi: Real; var Cd1, Cd2: Real
  Result:    None
  
  Cosa fa: Calcolo dei cd1 e cd2
-----------------------------------------------------------------------------}
procedure CalcoloCD1_CD2DM(Gradi: Real; var Cd1, Cd2: Real);
const // Gradi giorno
        b1 = 601.0;
        b2 = 900.0;
        c1 = 901.0;
        c2 = 1400.0;
        d1 = 1401.0;
        d2 = 2100.0;
        e1 = 2101.0;
        e2 = 3000.0;

        // valori cd
        cdb1=0.49;
        cdb2=0.46;
        cdb3=1.16;
        cdb4=1.08;

        cdc1=0.46;
        cdc2=0.42;
        cdc3=1.08;
        cdc4=0.95;

        cdd1=0.42;
        cdd2=0.34;
        cdd3=0.95;
        cdd4=0.78;

        cde1=0.34;
        cde2=0.30;
        cde3=0.78;
        cde4=0.73;

        // valori cd d.m. 27/7/2005
        {cdDM27b1 = 0.44;
        cdDM27b2 = 0.41;
        cdDM27b3 = 1.04;
        cdDM27b4 = 0.97;

        cdDM27c1 = 0.41;
        cdDM27c2 = 0.38;
        cdDM27c3 = 0.97;
        cdDM27c4 = 0.86;

        cdDM27d1 = 0.38;
        cdDM27d2 = 0.31;
        cdDM27d3 = 0.86;
        cdDM27d4 = 0.70;

        cdDM27e1 = 0.31;
        cdDM27e2 = 0.27;
        cdDM27e3 = 0.70;
        cdDM27e4 = 0.66; }

var
    cdl1,cdl2,cdl3,cdl4: real;
    ci:Smallint;
    //variabile d.m. 27/7/2005
    //cdDml1,cdDml2,cdDml3,cdDml4: real;
    gg: real;
    z1:char;
    g1,g2:real;
begin
    {cdDml1 := 0;
    cdDml2 := 0;
    cdDml3 := 0;
    cdDml4 := 0;  }
    cdl1 := 0;
    cdl2 := 0;
    cdl3 := 0;
    cdl4 := 0;
    g1 := 0;
    g2 := 0;
    z1 := ' ';
    gg := gradi;
    if gg < 600 then z1 := 'A'
    else
    if (gg > 600) and (gg <= 900) then z1 := 'B'
    else
    if (gg > 900) and (gg <= 1400) then z1 := 'C'
    else
    if (gg > 1400) and (gg <= 2100) then z1 := 'D'
    else
    if (gg > 2100) and (gg <= 3000) then z1 := 'E'
    else
    if gg > 3000 then z1 := 'F';

    case z1 of
     'A':begin
           cd1:=0.490;
           cd2:=1.160;
           // d.m. 27/7/2005
           //CD1 := 0.44;
           //Cd2 := 1.04;
         end;
     'B':begin
           g1 := b1;
           g2 := b2;
           cdl1:=cdB1;
           cdl2:=cdB2;
           cdl3:=cdB3;
           cdl4:=cdB4;
           //d.m 27/07/2005
           {cdDml1 := cdDm27B1;
           cdDml2 := cdDm27B2;
           cdDml3 := cdDm27B3;
           cdDml4 := cdDm27B4;  }
         end;
     'C':begin
           g1 := c1;
           g2 := c2;
           cdl1:=cdC1;
           cdl2:=cdC2;
           cdl3:=cdC3;
           cdl4:=cdC4;
           //d.m 27/07/2005
           {cdDml1 := cdDm27c1;
           cdDml2 := cdDm27C2;
           cdDml3 := cdDm27C3;
           cdDml4 := cdDm27C4;    }
         end;
     'D':begin
           g1 := d1;
           g2 := d2;
           cdl1:=cdD1;
           cdl2:=cdD2;
           cdl3:=cdD3;
           cdl4:=cdD4;
           //d.m 27/07/2005
           {cdDml1 := cdDm27D1;
           cdDml2 := cdDm27D2;
           cdDml3 := cdDm27D3;
           cdDml4 := cdDm27D4;}
         end;
     'E':begin
           g1 := e1;
           g2 := e2;
           cdl1:=cdE1;
           cdl2:=cdE2;
           cdl3:=cdE3;
           cdl4:=cdE4;
           {//d.m 27/07/2005
           cdDml1 := cdDm27E1;
           cdDml2 := cdDm27E2;
           cdDml3 := cdDm27E3;
           cdDml4 := cdDm27E4; }
         end;
     'F':begin
           cd1:=0.300;
           cd2:=0.730;
           {// d.m. 27/7/2005
           CD1 := 0.27;
           Cd2 := 0.66;}
         end;
    end;
    if (z1 <> 'A') and (z1<>'F') then
    begin
        cd1 := RoundTo((cdl1-(cdl1-cdl2)*((gg-g1)/(g2-g1))), -3);
        cd2 := RoundTo((cdl3-(cdl3-cdl4)*((gg-g1)/(g2-g1))), -3);
        {// d.m. 27/7/2005
        CD1 := RoundTo((cdDMl1-(cdDMl1-cdDMl2)*((gg-g1)/(g2-g1))), -3);
        Cd2 := RoundTo((cdDMl3-(cdDMl3-cdDMl4)*((gg-g1)/(g2-g1))), -3); }
    end;

end;

{-----------------------------------------------------------------------------
  Procedure: EsistonoCaratteriSpeciali
  Author:    e.diquattro
  Date:      18-apr-2006
  Arguments: Parola: String
  Result:    Boolean

  Cosa fa: Verifica l'esistenza dei caratteri speciali [|,/,:,?,",<,>,|] in
           in una stringa
-----------------------------------------------------------------------------}

function EsistonoCaratteriSpeciali(Parola: String): Boolean;
var
  Esiste: Boolean;
begin
  Esiste := False;
  if Pos('\', Parola) <> 0 then Esiste := True
  else
  if Pos('/', Parola) <> 0 then Esiste := True
  else
  if Pos(':', Parola) <> 0 then Esiste := True
  else
  if Pos('*', Parola) <> 0 then Esiste := True
  else
  if Pos('?', Parola) <> 0 then Esiste := True
  else
  if Pos('"', Parola) <> 0 then Esiste := True
  else
  if Pos('<', Parola) <> 0 then Esiste := True
  else
  if Pos('>', Parola) <> 0 then Esiste := True
  else
  if Pos('|', Parola) <> 0 then Esiste := True;
  Result := Esiste;
end;

Procedure EliminaFileDisegno(Percorso: String);
begin
  if FileExists(IncludeTrailingPathDelimiter(Percorso) + 'Disegno.txt') then
     DeleteFile(IncludeTrailingPathDelimiter(Percorso) + 'Disegno.txt');
end;

end.
