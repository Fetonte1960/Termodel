unit UMainGenera;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Tabnotbk,dbtables, DBCtrls, Grids, DBGrids,
  Db,assembla;

type
  TForm1 = class(TForm)
    Button3: TButton;
    Label1: TLabel;
    Edit1: TEdit;
    CBNobde: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Locale:boolean=false;
  PathLoc:string;
implementation
uses UCalc,UFunzgenera;

{$R *.DFM}
Function Tipo_C(tipopas:string;parte:integer):string;
begin
result:='';
tipopas:=uppercase(tipoPas);
if parte=1 then
  begin
  if tipopas='BOOLEAN' then result:='bool';
  if tipopas='INTEGER' then result:='int';
  if tipopas='REAL' then result:='double';
  if pos('STRING',tipopas)<>0 then result:='char ';
  end
else
if pos('STRING',tipopas)<>0 then result:=' '+copy(tipopas,7,length(tipopas)-6);
end;

function Valida(st:string):boolean;
begin
result:=(st<>'')and(st[1]<>'/');
end;
Procedure CancellaFileestensione(percorso,estens:string);
 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
 begin
     perc:=percorso+'\*.'+estens;

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             DeleteFile(NomeFile);
             Trovato := FindNext(sr);
        end;
 end;

Var i:Integer;
procedure TForm1.Button1Click(Sender: TObject);


 function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;



Procedure OutTabella(Tabella:TTable;dup:boolean);
Var i,lung:integer;
    lungst,tipodati,opzioni:string;
    Primo:boolean;
begin
{Tabella.Tablename:=NomeTab;}
{Tabella.Open;}
(*Tabella1.close;
Tabella1.DatabaseName:=Tabella.DatabaseName;
Tabella1.TableName:=Tabella.TableName;
Tabella1.open;
write_ln(Fout,'With DB.'+Tabella.name+' Do');
write_ln(Fout,'If (uppercase(tablename)=uppercase(NomeTab))or (nometab='''') then');
If not dup then
  begin
  write_ln(fout,'  Begin');
  write_ln(Fout,'  Close;');
  write_ln(Fout,'  try fieldDefs.clear except end;');
  write_ln(Fout,'  try IndexDefs.clear except end;');
  {Write_ln(Fout,'  ;');
  Write_ln(Fout,'  ;');}
  write_ln(fout,'  DataBaseName:=Percorso;');
  write_ln(fout,'  TableName:='''+tabella.Tablename+''';');
  write_ln(fout,'  tableType:=ttdefault;');
  Tabella1.IndexDefs.Update;
  For i:=0 to Tabella1.FieldCount-1 do
  with tabella1.fields[i]  do
    begin
    lung:=0;
    TipoDati:='ftUnkown';
      case datatype of
      ftstring:
        begin
        lung:=datasize-1;
        tipodati:='ftstring';
        end;
      ftSmallint:tipodati:='ftSmallint';
      ftInteger:tipodati:='ftInteger';
      ftWord:tipodati:='ftWord';
      ftBoolean:tipodati:='ftBoolean';
      ftFloat:tipodati:='ftFloat';
      ftCurrency:tipodati:='ftCurrency';
      ftBCD:tipodati:='ftBCD';
      ftDate:tipodati:='ftDate';
      ftTime:tipodati:='ftTime';
      ftDateTime:tipodati:='ftDateTime';
      ftBytes:tipodati:='ftBytes';
      ftVarBytes:tipodati:='ftVarBytes';
      ftAutoInc:tipoDati:='ftAutoinc';
      ftBlob:tipodati:='ftBlob';
      ftMemo:
        begin
        lung:=size;
        tipodati:='ftMemo';
        end;
      ftGraphic:tipodati:='ftGraphic';
      ftFmtMemo:tipodati:='ftFmtMemo';
      ftParadoxOle:tipodati:='ftParadoxOle';
      ftDBaseOle:tipodati:='ftDBaseOle';
      ftTypedBinary:tipodati:='ftTypedBinary';
      end;
    str(lung,lungst);
    Tabella1.IndexDefs.Update;
    write_ln(fout,'  Fielddefs.Add('''+fieldname+''','+TipoDati+','+Lungst+',false);');
    end;
  for I := 0 to Tabella1.IndexDefs.Count - 1 do
  with Tabella1.IndexDefs.Items[I] do
    begin
    Primo:=true;
    opzioni:='[';
    if ixPrimary in Options then
      begin
      if not primo then opzioni:=opzioni+','
      else primo:=false;
      opzioni:=opzioni+'ixPrimary';
      end;
    if ixUnique in Options then
      begin
      if not primo then opzioni:=opzioni+','
      else primo:=false;
      opzioni:=opzioni+'ixUnique';
      end;
    if ixDescending in Options then
      begin
      if not primo then opzioni:=opzioni+','
      else primo:=false;
      opzioni:=opzioni+'ixDescending';
      end;
    if ixExpression in Options then
      begin
      if not primo then opzioni:=opzioni+','
      else primo:=false;
      opzioni:=opzioni+'ixExpression';
      end;
    if ixCaseInsensitive in Options then
      begin
      if not primo then opzioni:=opzioni+','
      else primo:=false;
      opzioni:=opzioni+'ixCaseInsensitive';
      end;
    write_ln(fout,'  IndexDefs.Add('''+Name+''','''+Fields+''','+Opzioni+']);');
    end;
  write_ln(fout,'  CreateTable;');
  end
else
  begin
  write_ln(Fout,'  begin;');
  write_ln(Fout,'  Close;');
  write_ln(fout,'  DataBaseName:=Percorso;');
  write_ln(fout,'  TableName:='''+tabella.Tablename+''';');
  end;
write_ln(Fout,'  Open;');
write_ln(Fout,'  Refresh;');
write_ln(fout,'  End;');
 *)
{Tabella.close;}
end;
Var NumArraySlave,NomeSlave,riga,NometabSlave,linkcodeslave,identif,Tipostru,Nometabellaprec:string;
    PosInd:Integer;
    tipotab,usesdb,VQ:string;
procedure leggiidentif;
Var i:integer;
begin
i:=posind+1;

if i<length(riga) then
while (riga[i]<>':')and(i<length(riga)) do inc(i);

if i=posind+1 then
identif:=''
else
Identif:=copy(riga,posind+1,i-posind-1);
POsind:=i;
end;

procedure Leggidati;
Var ss,tt1,indt:string;
    lung,count,Nvettore,IndVettore,ERConv:integer;
    temp,Funzconv,Nomerec,Nometabella,UpperNometabella,TipoTabella,campo,campo1,descrizione,
    tipo,tipodati,lungst,datastru,varname,maxarray,nummaxarray,
    lunglink,linkcode,numarray,Isslave,Camposlave,report,valorefisso,Parametrigen,NumCampo,cdec:string;
    TipoArray,Autoinc,Doppiop,GenTab,vettore,vuoto,Archivio:boolean;

Function Slave:boolean;
begin
Slave:=Upstring(Isslave)='SLAVE';
end;

Function NotSlave:boolean;
begin
NotSlave:=Upstring(Isslave)<>'SLAVE';
end;

Function Master:boolean;
begin
Master:=Upstring(Isslave)='MASTER';
end;

{
Procedure Compilareport(NomeVar,Contenuto,TipoVar:string);
begin
write_ln(Freport,'TempStr := '+Contenuto+';');
write_ln(Freport,'Doc.IfInizVariabile('''+Nomevar+''', TempStr);');
end;
}

Function tipo_stru(data_stru:string;doppio_p:boolean;nomeind:string):string;
begin
if upstring(data_stru)='ARRAY' then
  begin
  if doppio_P then
    begin
    Tipo_stru:='^['+nomeInd+']^.';
    end
  else
    begin
    Tipo_stru:='^['+nomeInd+'].';
    end;
  end
else
  begin
  Tipo_stru:='^.';
  end;
end;
Procedure Compilareport(NomeVar,Contenuto,TipoVar:string);
begin
write_ln(Freport,'Wrep_str('''+Nomevar+''','+Nomevar+');');
//write_ln(Freport,'Doc.IfInizVariabile('''+Nomevar+''', TempStr);');
end;


Const rep=1;
      cmb=2;
      ini=3;
      Lkk=4;
      Grd=5;
      Crl=6;
      Cnt=7;
      Dec=8;
Function Costante(st:string):integer;
begin
result:=0;
if upstring(st)='REP' then result:=1;
if upstring(st)='CMB' then result:=2;
if upstring(st)='INI' then result:=3;
if upstring(st)='LKK' then result:=4;
if upstring(st)='GRD' then result:=5;
if upstring(st)='CRL' then result:=6;
if upstring(st)='CNT' then result:=7;
if upstring(st)='DEC' then result:=8;
end;

Procedure Leggivarianti;
Var st,Tipotest:String;
    primocombo:Boolean;

Function Par_ST(ss:string;Np:integer):string;
Var i,count,pos:integer;
begin
result:='';
if ss='' then exit;
i:=1;
count:=0;
pos:=0;
while (i<length(ss))and(count<np)do
  begin
  inc(i);
  if (ss[i]='/')or(i=length(ss)) then
    begin
    inc(count);
    if (count<>NP) then pos:=i;
    end;
  end;
if i=length(ss) then i:=i+1;
if count=NP then result:=copy(ss,pos+1,i-pos-1);
end;

begin
//If (Not Vuoto)or archivio then
  begin
  if numcampo<>'' then
    begin
    write_ln(Fform,'  '+NumCampo+':Begin');
    write_ln(Fform,'    etichetta('''+Descrizione+''');');
    end;
  end;
primocombo:=true;

  repeat
  leggiidentif;
  if (length(identif)>4) then  st:=copy(identif,5,length(identif)-4);
  if (length(identif)>4)and(identif[4]='#') then
    case costante(copy(identif,1,3)) of
    rep:Compilareport(Campo,st,Tipo);
    cmb:begin
        write_ln(Fcombo,campo+':'+Descrizione+':'+st+':');
        if numcampo<>'' then write_ln(Fform,'    AddCombo('''+st+''');');

        if primocombo then
          begin
          write_ln(Fini,'  V_'+Nomerec+'.Set_'+Campo+'('''+st+''');');
          if notslave then write_ln(Finimem,'  '+Varname+Tipostru+Campo+':='''+st+''';');
          PrimoCombo:=false;
          end;
        end;
    LKK:begin
        write_ln(Fform,'    LookUp('''+Descrizione+''','''+Par_ST(st,1)+''','+Par_ST(st,2)+','''+Par_ST(st,3)+''');');
        end;
    ini:begin
        write_ln(Fini,'  V_'+Nomerec+'.Set_'+Campo+'('+st+');');
        if notslave then write_ln(Finimem,'  '+Varname+TipoStru+Campo+':='+st+';');
        end;
    Grd:write_ln(Fform,'    AddGrid('''+Descrizione+''','+st+');');
    Crl:write_ln(FConferma,'  V_'+Nomerec+'.Set_'+Campo+'(CampoCorrelato('''+Par_ST(st,1)+''','+Par_ST(st,2)+','+Par_ST(st,3)+','''+Par_ST(st,4)+''',V_'+Nomerec+'.'+Par_ST(st,5)+'));');
    Cnt:begin
        write_ln(FControlla,'If Dacontrollare('''+Nometabella+''','+Numcampo+') Then ');
        write_ln(FControlla,'If not(  V_'+Nomerec+'.'+Campo+Par_ST(st,2)+') Then ');
        TipoTest:=Par_ST(st,2);
        if tipotest='<>''''' then tipotest:='un valore valido';
        write_ln(FControlla,'Aggiungimessaggio(''Inserire un valore '+tipotest+' per il campo '+Upstring(Par_ST(st,1))+' '');');
        end;
    Dec:Cdec:=st;
    end;
  until identif='';
if numcampo<>'' then
write_ln(Fform,'    End;');
end;

begin

count:=0;
TipoArray:=false;
Vuoto:=false;
Archivio:=false;
repeat readln(basedati,riga); until valida(riga);
if (riga<>'') and (riga[1]='/') then showmessage(riga);
POsind:=0;
leggiidentif;
parametriGen:=Identif;
if Upstring(Parametrigen)='VUOTO' then vuoto:=true;
if Upstring(Parametrigen)='ARCHIVIO' then
  begin
  vuoto:=true;
  archivio:=true;
  end;
leggiidentif;
nomerec:=identif;
leggiidentif;
salvadb:=true;
Nometabella:=identif;
UpperNometabella:=Uppercase(Nometabella);
if nometabella[1]='#' then
  begin
  Nometabella:=copy(nometabella,2,length(nometabella)-1);
  salvadb:=false;
  end;
leggiidentif;
indT:=identif;
leggiidentif;
TipoTabella:=identif;
leggiidentif;
DoppioP:=upstring(identif)='DOPPIOP';
GenTab:=upstring(identif)<>'NOTAB';
leggiidentif;
DoppioP:=DoppioP or (upstring(identif)='DOPPIOP');
GenTab:=GenTab and (upstring(identif)<>'NOTAB');

repeat readln(basedati,riga); until valida(riga);
if (riga<>'') and (riga[1]='/') then showmessage(riga);

POsind:=0;
leggiidentif;
Datastru:=identif;
leggiidentif;
Varname:=identif;

if datastru='array' then
  begin
  leggiidentif;
  Maxarray:=identif;
  leggiidentif;
  NumMaxarray:=identif;
  leggiidentif;
  Numarray:=identif;
  leggiidentif;
  IsSlave:=identif;
  leggiidentif;
  linkcode:=Identif;
  leggiidentif;
  lunglink:=Identif;
  leggiidentif;
  Camposlave:=Identif;
  end;
{ TODO -oGenera -cNavigazione : Intestazione tabella }
if salvadb then
  begin
  Write_ln(FUDB,'    T_'+Nometabella+': TTable'+VQ+';');
  Write_ln(FUDB,'    DS_'+Nometabella+': TDataSource;');
  inc(numtabelle);
  FWriteln(FUdbDFm,'  object T_'+Nometabella+': TTable'+VQ);
  if cbnobde.checked then
    begin
    FWriteln(FUdbDFm,'    DesignActivation = True');
    FWriteln(FUdbDFm,'    AttachedAutoRefresh = True');
    FWriteln(FUdbDFm,'    AttachMaxCount = 1');
    FWriteln(FUdbDFm,'    FieldDefs = <>');
    FWriteln(FUdbDFm,'    IndexDefs = <>');
    FWriteln(FUdbDFm,'    SortOptions = []');
    FWriteln(FUdbDFm,'    PersistentBackup = False');
    FWriteln(FUdbDFm,'    ProgressFlags = [mtpcLoad, mtpcSave, mtpcCopy]');
    FWriteln(FUdbDFm,'    FilterOptions = []');
    FWriteln(FUdbDFm,'    Version = ''3.01''');
    FWriteln(FUdbDFm,'    LanguageID = 0');
    FWriteln(FUdbDFm,'    SortID = 0');
    FWriteln(FUdbDFm,'    SubLanguageID = 1');
    FWriteln(FUdbDFm,'    LocaleID = 1024');
    end;
  FWriteln(FUdbDFm,'    OnNewRecord = ONNewRecord');
  FWriteln(FUdbDFm,'    OnFilterRecord = ONFilterRecord');
  FWriteln(FUdbDFm,'    Left = '+inttostr(160+(numtabelle div 15)*230));
  FWriteln(FUdbDFm,'    Top = '+inttostr(50+(((numtabelle-1) mod 15)-1)*45));
  FWriteln(FUdbDFm,'  end');
  FWriteln(FUdbDFm,'  object DS_'+Nometabella+': TDataSource');
  FWriteln(FUdbDFm,'    DataSet = T_'+Nometabella);
  FWriteln(FUdbDFm,'    Left = '+inttostr(50+(numtabelle div 15)*230));
  FWriteln(FUdbDFm,'    Top = '+inttostr(50+(((numtabelle-1) mod 15)-1)*45));
  FWriteln(FUdbDFm,'  end');

  FWriteln(FComDB,'  Case action of ');
  FWriteln(FComDB,'  Init:Begin');
  if archivio then
  FWriteln(FComDB,'       dmtutti.T_'+Nometabella+'.databasename:=parA;')
  else
  FWriteln(FComDB,'       dmtutti.T_'+Nometabella+'.databasename:=par;');
  FWriteln(FComDB,'       dmtutti.T_'+Nometabella+'.Tablename:='''+Nometabella+'.db'';');
  FWriteln(FComDB,'       end;');

  if  archivio then FWriteln(FComDB,'  NuovoArch:')
  else FWriteln(FComDB,'  Nuovo:');
  FWriteln(FComDB,'   Begin');
  FWriteln(FComDB,'   crea_'+Nometabella+'(T_'+Nometabella+');');
  if (salvaDB)and (not slave) then write_ln(FComDB,'   '+NomeTabella+'_In_memoria:=false;');
  FWriteln(FComDB,'   end;');

  FWriteln(FComDB,'  Apri:Begin');
  if master then
    begin
    FWriteln(FComDB,'       T_'+Nometabella+'.Open;');
    FWriteln(FComDB,'       T_'+nometabellaPrec+'.mastersource:=DS_'+Nometabella+';');
    FWriteln(FComDB,'       T_'+nometabellaPrec+'.MasterFields:=''Numero'';');
    FWriteln(FComDB,'       T_'+nometabellaPrec+'.IndexName:=''PerNumero'';');
    FWriteln(FComDB,'       T_'+nometabellaPrec+'.Open;');
    end ;
  if notslave then  FWriteln(FComDB,'       T_'+Nometabella+'.Open;');
  FWriteln(FComDB,'       end;');
  FWriteln(FComDB,'  Chiudi:T_'+Nometabella+'.Close;');
  if not archivio then
    begin
    if master then
    FWriteln(FComDB,'  salva:SaveTxt_'+Nometabella+'(T_'+Nometabella+',T_'+nometabellaPrec+',DS_'+Nometabella+');')
    else if notslave then
    FWriteln(FComDB,'  salva:SaveTxt_'+Nometabella+'(T_'+Nometabella+',TTtemp,DS_'+Nometabella+');');
    end;
  FWriteln(FComDB,'  end ;');
  end;
nometabellaPrec:=nometabella;
//if (not vuoto)or archivio then
  begin
  Write_ln(Fconferma,'If Table_name='''+upstring(Nometabella)+''' then');
  Write_ln(Fconferma,'  begin');
  Write_ln(FForm,'If Nometabella='''+upstring(Nometabella)+''' then');
  Write_ln(FForm,'  Case codcampo of');
  Write_ln(FForm,'  0:;');
  end;
Write_ln(FCombo,'#'+Nometabella);
Write_ln(Fcompila,'ListBox1.Items.add('''+NomeTabella+''');');
write_ln(Fcreadb ,'If Nome='''+Nometabella+''' then Crea_'+Nometabella+'(Dm1.TT1);');
if notslave then
  begin
  write_ln(FcreadbT ,'If Nome='''+uppercase(Nometabella)+''' then Crea_'+Nometabella+'(Dmtutti.T_'+Nometabella+');');
  if master then
  write_ln(FcreadbT ,'If Nome='''+uppercase(Nometabella)+''' then Crea_'+Nometabslave+'(Dmtutti.T_'+Nometabslave+');');
  end;
write_ln(fProcLink,'{*************************************************************}');

write_ln(fDataLink,'{*************************************************************}');
write_ln(fDataLink,'Type ');
write_ln(fDataLink,'O_'+Nomerec+'=');
write_ln(fDataLink,'       ObJect');

write_ln(ftype,'{*************************************************************}');
write_ln(ftype_C,'//{*************************************************************}');
if (salvadb)and (not slave)then
  begin
  write_ln(ftype,'Var '+NomeTabella+'_In_memoria:Boolean=false;');
  write_ln(ftype_C,'bool '+NomeTabella+'_In_memoria=false;');
  end;
if datastru='array' then
  begin
  write_ln(ftype,'Const '+maxarray+'='+NumMaxarray+';');
  write_ln(ftype_C,'const int '+maxarray+'='+NumMaxarray+';');
  if notslave then
    begin
    Write_ln(ftype,'Var '+Numarray+':integer;');
    Write_ln(ftype_C,'int '+Numarray+' ;');
    end;
  end;
write_ln(ftype,'Type ');
write_ln(ftype,Nomerec+'=Record');
write_ln(ftype_C,'struct '+Nomerec+' {');
if master then
  begin
  write_ln(ftype,'       '+Camposlave+':Ar_'+Nomeslave+';');
  write_ln(ftype_C,'       Ar_'+Nomeslave+' '+Camposlave+';');
  write_ln(ftype,'       '+NumarraySlave+':Integer;');
  write_ln(ftype_C,'       int '+NumarraySlave+' ;');
  end;

write_ln(fSave,'{*************************************************************}');

write_ln(fDatain,'{*************************************************************}');
if slave then
  begin
  write_ln(fSave,'Procedure SaveTxt_'+nometabella+'(var Tabella1:'+TipoTab+');');
  write_ln(fUDataOutT,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+Nomerec+';Var i:Integer);');
  write_ln(fDatain,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+Nomerec+';Var i:Integer);');
  write_ln(fIoDati,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+Nomerec+';Var i:Integer);');
  end
else
  begin
  write_ln(fSave,'Procedure SaveTxt_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+';DataS1:Tdatasource);');
  write_ln(fUDataOutT,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+';DataS1:Tdatasource);');
  write_ln(fIodati,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+';DataS1:Tdatasource);');
  if salvadb then
    begin
    write_ln(fIodati,'Procedure Leggi_mem_'+nometabella+';');
    write_ln(fDatain,'Procedure OLD_Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+';DataS1:Tdatasource);');
    end
  else
  write_ln(fDatain,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+';DataS1:Tdatasource);');
  end;
if (datastru='array')and notslave then Write_ln(fDatain,'Var i:integer;');

//********
write_ln(fSave,'Begin');
if notslave then
  begin
  write_ln(fSave,'Tabella1.close;');
  write_ln(fSave,'Tabella1.tablename:='''+Nometabella+'.DB'+''';');
  write_ln(fSave,'Tabella1.open;');
  if master then
    begin
    write_ln(fSave,'Tabella3.close;');
    write_ln(fSave,'Tabella3.tablename:='''+Nometabslave+'.DB'+''';');
    write_ln(fSave,'Tabella3.Masterfields:='''+linkcodeslave+''';');
    write_ln(fSave,'Tabella3.IndexName:=''Per'+linkcodeslave+''';');
    write_ln(fSave,'Tabella3.MasterSource:=DataS1;');
    write_ln(fSave,'Tabella3.open;');
    end;
  end;
write_ln(fSave,'Tabella1.first;');
if notslave then write_ln(fSave,'Writecampo(''--------------------------------------->'+UpperNomeTabella+''');') ;
if datastru='array' then
  begin
  write_ln(fSave,'While not Tabella1.eof do');
  write_ln(fSave,'  Begin');
  if notslave then Write_ln(fSave,'  Writecampo(''#RIGATABELLA#'');')
  else Write_ln(fSave,'  Writecampo(''#RIGATABASSOCIATA#'');');
  end;

Write_ln(fSave,'    Begin');

Write_ln(fNuovo,'CreaDataBase('''+Nometabella+''');');
if not vuoto then
  begin
  Write_ln(fNuovo,'dm1.tt1.Open;');
  Write_ln(fNuovo,'dm1.tt1.append;');
  Write_ln(fNuovo,'dm1.tt1.POst;');
  Write_ln(fNuovo,'dm1.tt1.Close;');
  end;
//**********
Write_ln(fDatain,'Begin');

if datastru='array' then Write_ln(fDatain,'i:=0;');
if notslave then
  begin

  Write_ln(fDatain,'if Not FileExists(Tabella1.Databasename+''\'+Nometabella+'.DB'+''') then');
  Write_ln(fDatain,'  Begin');
  if datastru='array' then
    begin
    Write_ln(fDatain,'  '+NumArray+':=i;');
    Write_ln(fDatain,'  Exit;');
    end
  else Write_ln(fDatain,'  CreaDataBase('''+Nometabella+''');');
  Write_ln(fDatain,'  End;');
  Write_ln(fDatain,'Tabella1.close;');
  Write_ln(fDatain,'Tabella1.tablename:='''+Nometabella+'.DB'+''';');
  Write_ln(fDatain,'Tabella1.open;');
  if master then
    begin
    Write_ln(fDatain,'Tabella3.close;');
    Write_ln(fDatain,'Tabella3.tablename:='''+Nometabslave+'.DB'+''';');
    Write_ln(fDatain,'Tabella3.Masterfields:='''+linkcodeslave+''';');
    Write_ln(fDatain,'Tabella3.IndexName:=''Per'+linkcodeslave+''';');
    //write_ln(fDataIn,'Tabella3.MasterSource:=dm1.Datasource1;');
    write_ln(fDataIn,'Tabella3.MasterSource:=Datas1;');
    Write_ln(fDatain,'Tabella3.open;');

    end;
  end;
Write_ln(fDatain,'Tabella1.first;');
if datastru='array' then Write_ln(fDatain,'While not Tabella1.eof do');
if datastru='array' then Write_ln(fDatain,'  Begin');
if datastru='array' then
  begin
  if (cbNobde.checked)and(slave) then
    begin
    Write_ln(fDatain,'  if Tabella1.fields[1].asinteger=Indmaster then');
    Write_ln(fDatain,'  begin');
    end;
  Write_ln(fDatain,'  inc(i);');
  if doppiop then Write_ln(fDatain,'  New('+varname+'^[i]);');
  if slave then Write_ln(fDatain,'  with arr[i] do')
  else
    begin
    if doppiop then Write_ln(fDatain,'  with '+varname+'^[i]^ do')
    else Write_ln(fDatain,'  with '+varname+'^[i] do');
    end;
  end
else Write_ln(fDatain,'  with '+varname+'^ do');
Write_ln(fDatain,'    Begin');
if master then
  begin
  if cbnobde.checked then Write_ln(fDatain,'    indmaster:=i-1;');
  Write_ln(fDatain,'    Leggi_'+Nometabslave+'(Tabella3,'+Camposlave+','+NumarraySlave+');');
  end;

if notslave then
Write_ln(FCaseTab,'If NomeTabella='''+UpperNomeTabella+'''then OpenTxt_'+Nometabella+'(dm1.tt1,dm1.tt3,dm1.DataSource1);')
else Write_ln(FCaseTab,'If NomeTabella='''+UpperNomeTabella+'''then OpenTxt_'+Nometabella+'(dm1.tt3);');

Write_ln(FCaseTab_mem,'If NomeTabella='''+UpperNomeTabella+'''then OpenTxt_'+Nometabella+'_mem;');

if master then  Write_ln(FCaseTabT,'If NomeTabella='''+UpperNomeTabella+'''then OpenTxt_'+Nometabella+'(T_'+Nometabella+',T_'+Nometabslave+',DS_'+Nometabella+');')
else if notslave then
Write_ln(FCaseTabT,'If NomeTabella='''+UpperNomeTabella+'''then OpenTxt_'+Nometabella+'(T_'+Nometabella+',tttemp,DS_'+Nometabella+');')
else Write_ln(FCaseTabT,'If NomeTabella='''+UpperNomeTabella+'''then OpenTxt_'+Nometabella+'(T_'+nometabella+');');

Write_ln(fCampoDb,'{*************************************************************}');
Write_ln(fCampoDb,'Function CampoDb_'+NomeTabella+':Integer;');
Write_ln(fCampoDb,'Begin');
Write_ln(fCampoDb,'result:=-1;');
Write_ln(fCampoDb,'  Case CampoCor of');
Write_ln(fCampoDb,'  -1:CampoCor:=campoCor;//Per fare compilare i case vuoti');

Write_ln(fCampoDb_mem,'{*************************************************************}');
if notslave then
Write_ln(fCampoDb_mem,'Procedure CampoDb_'+NomeTabella+'(LabelCampo:integer;valore:string);')
else Write_ln(fCampoDb_mem,'Procedure CampoDb_'+NomeTabella+'(LabelCampo:integer;valore:string;Var Associata:'+nomerec+');');

Write_ln(fCampoDb_mem,'Begin');
Write_ln(fCampoDb_mem,'  Case LabelCampo of');



Write_ln(fOpen,'{*************************************************************}');
Write_ln(fOpen_mem,'{*************************************************************}');

Write_ln(fDataout,'{*************************************************************}');
if slave then
  begin
  Write_ln(fUDataoutT,'Procedure Salva_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+NomeRec+';Indmax:integer);');
  Write_ln(fDataout,'Procedure Salva_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+NomeRec+';Indmax:integer);');
  Write_ln(fIodati,'Procedure Salva_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+NomeRec+';Indmax:integer);');
  Write_ln(fOpen,'Procedure OpenTxt_'+nometabella+'(var Tabella1:'+TipoTab+');');
  Write_ln(fOpen_mem,'Procedure OpenTxt_'+nometabella+'_mem;');
  end
else
  begin
  if not archivio then
    begin
    Write_ln(fStutti,'Salva_'+nometabella+'(dm1.tt1,dm1.tt3,dm1.datasource1);');
    Write_ln(fLtutti,'Leggi_'+nometabella+'(dm1.tt1,dm1.tt3,dm1.datasource1);');
    if master then
      begin
      Write_ln(fStuttiT,'Salva_'+nometabella+'(dmtutti.t_'+nometabella+',dmtutti.t_'+nometabslave+',dmtutti.ds_'+nometabella+');');
      Write_ln(fLtuttiT,'Leggi_'+nometabella+'(dmtutti.t_'+nometabella+',dmtutti.t_'+nometabslave+',dmtutti.ds_'+nometabella+');');
      end
    else
      begin
      Write_ln(fStuttiT,'Salva_'+nometabella+'(dmtutti.t_'+nometabella+',dmtutti.t_'+nometabella+',dmtutti.ds_'+nometabella+');');
      Write_ln(fLtuttiT,'Leggi_'+nometabella+'(dmtutti.t_'+nometabella+',dmtutti.t_'+nometabella+',dmtutti.ds_'+nometabella+');');
      end
    end;
  Write_ln(fOpen,'Procedure OpenTXT_'+nometabella+'(var Tabella1,Tabella3:'+TipoTab+';DataS1:Tdatasource);');
  Write_ln(fOpen_mem,'Procedure OpenTXT_'+nometabella+'_mem;');

  Write_ln(fUDataoutT,'Procedure Salva_'+nometabella+'(var Tabella1,Tabella3:'+TipoTab+';Var DataS1:Tdatasource);');
  Write_ln(fDataout,'Procedure Salva_'+nometabella+'(var Tabella1,Tabella3:'+TipoTab+';Var DataS1:Tdatasource);');
  Write_ln(fIodati,'Procedure Salva_'+nometabella+'(var Tabella1,Tabella3:'+TipoTab+';Var DataS1:Tdatasource);');
  end;

Write_ln(fOpen,'Begin');
Write_ln(fOpen_mem,'Begin');
if not(Master)and(notslave) then
  begin
  Write_ln(fOpen,'Tabella3.IndexName:='''';');
  Write_ln(fOpen,'Tabella3.Masterfields:='''';');
  end;
if master then
  begin
  Write_ln(fOpen,'Tabella3.Close;');
  { TODO -oDiego -cmodifiche generali : compatibilità multitabella }
  //prima Write_ln(fOpen,'CreaDatabase('''+Nometabslave+''');');
  Write_ln(fOpen,'Tabella3.Tablename:='''+Nometabslave+'.db'';');
  end;
if notslave then
  begin
  { TODO -oDiego -cmodifiche generali : compatibilità multitabella }
  Write_ln(fOpen,'Tabella1.Tablename:='''+Nometabella+'.db'';');
  //prima Write_ln(fOpen,'CreaDatabase('''+Nometabella+''');');
  Write_ln(fOpen,'  Tabella1.open;');
  end;
if master then
  begin
  Write_ln(fOpen,'Tabella3.close;');
  Write_ln(fOpen,'Tabella3.tablename:='''+Nometabslave+'.DB'+''';');
  Write_ln(fOpen,'Tabella3.Masterfields:='''+linkcodeslave+''';');
  Write_ln(fOpen,'Tabella3.IndexName:=''Per'+linkcodeslave+''';');
  Write_ln(fOpen,'Tabella3.MasterSource:=DataS1;');
  Write_ln(fOpen,'Tabella3.open;');
  end;
if datastru='array' then
  begin
  if slave then Write_ln(fOpen,'While ReadValoreCampo=''#RIGATABASSOCIATA#'' Do')
  else Write_ln(fOpen,'While ReadValoreCampo=''#RIGATABELLA#'' Do')
  end;
if datastru='array' then Write_ln(fOpen,'  Begin');

Write_ln(fOPen,'  Tabella1.append;');
Write_ln(fOPen,'  Tabella1.edit;');
Write_ln(fOPen,'  Leggi_campo;');
Write_ln(fOPen,'  While Buf_Txt<>''#FINECAMPI#'' do');
Write_ln(fOPen,'    begin;');
Write_ln(fOPen,'    if CampoDB_'+Nometabella+'<>-1 then');
Write_ln(fOPen,'    tabella1.fields[CampoDB_'+Nometabella+'].asstring:=ValoreCampo;');
Write_ln(fOPen,'    Leggi_campo;');
Write_ln(fOPen,'    End;');
if (cbNobde.checked)and(slave) then
Write_ln(fOPen,'    tabella1.fields[1].asinteger:=Indmaster;');

if datastru='array' then Write_ln(fDataout,'Var i:integer;');
Write_ln(fDataout,'Begin');
if master then
  begin
  Write_ln(fDataout,'Tabella3.Close;');
  Write_ln(fDataout,'CreaDatabase('''+Nometabslave+''');');
  end;
if notslave then
  begin
  Write_ln(fDataout,'CreaDatabase('''+Nometabella+''');');
  Write_ln(fDataout,'  Tabella1.open;');
  end;
if master then
  begin
  Write_ln(fDataout,'Tabella3.close;');
  Write_ln(fDataout,'Tabella3.tablename:='''+Nometabslave+'.DB'+''';');
  Write_ln(fDataout,'Tabella3.Masterfields:='''+linkcodeslave+''';');
  Write_ln(fDataout,'Tabella3.IndexName:=''Per'+linkcodeslave+''';');
//  write_ln(fDataout,'Tabella3.MasterSource:=dm1.Datasource1;');
  write_ln(fDataout,'Tabella3.MasterSource:=Datas1;');
  Write_ln(fDataout,'Tabella3.open;');
  end;
{Write_ln(fDataout,'Crea_'+Nometabella+'(Tabella1);');}

//if master then Write_ln(fDataout,'Crea_'+Nometabslave+'(Tabella3);');
if datastru='array' then
  begin
  if slave then Write_ln(fDataout,'For i:=1 to Indmax Do')
  else Write_ln(fDataout,'For i:=1 to '+numarray+' Do');
  end;
if datastru='array' then Write_ln(fDataout,'  Begin');
{
Write_ln(fDataout,'Tabella1.tablename:='''+Nometabella+'.DB'+''';');
Write_ln(fDataout,'Tabella1.close;');
Write_ln(fDataout,'Tabella1.Exclusive:=true;');
Write_ln(fDataout,'Tabella1.Emptytable;');
Write_ln(fDataout,'Tabella1.Exclusive:=false;');
Write_ln(fDataout,'Tabella1.open;');
}
Write_ln(fDataout,'  Tabella1.append;');
Write_ln(fDataout,'  Tabella1.edit;');
{if datastru='array' then Write_ln(fDataout,'  Begin');}
if slave then Write_ln(fDataout,'  with arr[i] do')
  else
  begin
  if datastru='array' then
    begin
    if doppioP then Write_ln(fDataout,'  with '+varname+'^[i]^ do')
    else Write_ln(fDataout,'  with '+varname+'^[i] do');
    end
  else Write_ln(fDataout,'  with '+varname+'^ do');
  end;
Write_ln(fDataout,'    Begin');

write_ln(fout,'{*************************************************************}');

if upstring(Tipotabella)='VARIABILE' then
write_ln(fout,'Procedure Crea_'+Nometabella+'(Var Tabella1:'+TipoTab+';Nometab:string);')
else
write_ln(fout,'Procedure Crea_'+Nometabella+'(Var Tabella1:'+TipoTab+');');

write_ln(Fout,'Var i:integer;');
write_ln(fout,'Begin');

write_ln(Fout,'With Tabella1 Do');
write_ln(fout,'  Begin');
write_ln(Fout,'  Close;');
write_ln(Fout,'  try fieldDefs.clear except end;');
write_ln(Fout,'  try IndexDefs.clear except end;');
{Write_ln(Fout,'  ;');
Write_ln(Fout,'  ;');}
if upstring(Tipotabella)='VARIABILE' then
write_ln(fout,'  TableName:=Nometab;')
else
write_ln(fout,'  TableName:='''+Nometabella+'.Db'';');
write_ln(fout,'  tableType:=ttdefault;');
if slave then write_ln(fout,'  Fielddefs.Add(''Indice'',ftautoinc,0,false);');
if slave then
  begin
  if upstring(lunglink)='INTEGER' then
  write_ln(fout,'  Fielddefs.Add('''+LinkCode+''',ftinteger,0,false);')
  else write_ln(fout,'  Fielddefs.Add('''+LinkCode+''',ftstring,'+lunglink+',false);');
  {Write_ln(fout,'  fields[0].visible:=false;');
  Write_ln(fout,'  fields[1].visible:=false;');}
  end;

Write_ln(fini,'If Nome='''+Upstring(Nometabella)+''' Then');
Write_ln(fini,'  Begin');

Write_ln(finimem,'If Nome='''+Upstring(Nometabella)+''' Then');
Write_ln(finimem,'  Begin');
if upstring(datastru)='ARRAY' then
  begin
  if doppioP then
    begin
    Tipostru:='^[Ind]^.';
    end
  else
    begin
    Tipostru:='^[Ind].';
    end;
  end
else
  begin
  Tipostru:='^.';
  end;




while not eof(basedati)and (riga[1]<>'*') do
  begin
  repeat readln(basedati,riga); until valida(riga);
  if (riga<>'') and (riga[1]='/') then showmessage(riga);
  if riga[1]='*' then
    begin
    end
  else
    begin
    inc(count);
    POsind:=0;
    Leggiidentif;
    campo:=identif;

    NumCampo:='';
    if campo[1]='#' then
      begin
      numcampo:=copy(campo,2,length(campo)-1);
      Leggiidentif;
      campo:=identif;
      end;
    campo1:=campo;
    Leggiidentif;
    Descrizione:=identif;
    Leggiidentif;
    tipo:=identif;
    if descrizione='' then descrizione:=campo;
    if cbnobde.checked then descrizione:=copy(descrizione,1,25);
    if descrizione[1]='#' then
      begin
      count:=count-1;
      Valorefisso:='';
      i:=1;
      while (i<length(descrizione))and (Descrizione[i]<>'-') do
        begin
        inc(i);
        if Descrizione[i]<>'-' then ValoreFisso:=ValoreFisso+Descrizione[i];
        end;
      end;
    lung:=0;
    lungst:='0';
    TipoDati:='ftUnkown';
    tipo :=Upstring(tipo);
    autoinc:=false;
    Vettore:=false;

    if tipo='AUTOINC' then
      begin
      autoinc:=true;
      tipo:='INTEGER';
      end;
    if tipo='INTEGER' then
      begin
      if notslave then write_ln(Finimem,'  '+Varname+tipostru+Campo+':=0;');
      funzconv:='asinteger';
      if autoinc then tipodati:='ftAutoinc'
      else tipodati:='ftInteger';
      end;
    if copy(tipo,1,4)='REAL' then
      begin
      if notslave then write_ln(Finimem,'  '+Varname+tipostru+Campo+':=0;');
      campo1:='F_real('+Campo+','+CDEC+')';
      if tipo<>'REAL' then
        begin
        Val(copy(tipo,6,length(tipo)-6),Nvettore,erconv);
        if erconv=0 then Vettore:=true;
        end;
      tipo:='REAL';
      tipodati:='ftFloat';
      funzconv:='asfloat';
      end;
    if copy(tipo,1,6)='STRING' then
      begin
      if notslave then write_ln(Finimem,'  '+Varname+tipostru+Campo+':='''';');
      funzconv:='asstring';
      tipodati:='ftstring';
      lungst:=copy(tipo,8,length(tipo)-8);
      end;

    Cdec:='-1';
    Leggivarianti;
    if tipo='REAL' then campo1:='F_real('+Campo+','+CDEC+')';


     if vettore then
       begin
       str(Nvettore:1,temp);
       Write_ln(Ftype,'       '+campo+':array[1..'+temp+'] of '+tipo+';');
       Write_ln(Ftype_C,'       typedef '+tipo+' '+campo+' ['+temp+'];');
       end
     else
       begin
       Write_ln(Ftype,'       '+campo+':'+tipo+';');
       Write_ln(Ftype_C,'       '+tipo_C(tipo,1)+' '+campo+tipo_C(tipo,2)+' ;');
       end;
{    case datatype of
      ftstring:
        begin
        lung:=datasize-1;
        tipodati:='ftstring';
        end;
      ftSmallint:tipodati:='ftSmallint';
      ftInteger:tipodati:='ftInteger';
      ftWord:tipodati:='ftWord';
      ftBoolean:tipodati:='ftBoolean';
      ftFloat:tipodati:='ftFloat';
      ftCurrency:tipodati:='ftCurrency';
      ftBCD:tipodati:='ftBCD';
      ftDate:tipodati:='ftDate';
      ftTime:tipodati:='ftTime';
      ftDateTime:tipodati:='ftDateTime';
      ftBytes:tipodati:='ftBytes';
      ftVarBytes:tipodati:='ftVarBytes';
      ftAutoInc:tipoDati:='ftAutoinc';
      ftBlob:tipodati:='ftBlob';
      ftMemo:
        begin
        lung:=size;
        tipodati:='ftMemo';
        end;
      ftGraphic:tipodati:='ftGraphic';
      ftFmtMemo:tipodati:='ftFmtMemo';
      ftParadoxOle:tipodati:='ftParadoxOle';
      ftDBaseOle:tipodati:='ftDBaseOle';
      ftTypedBinary:tipodati:='ftTypedBinary';
    end;}
  {str(lung,lungst);}

    if descrizione[1]<>'#' then
      begin
      if vettore then
      for IndVettore:=1 to NVettore do
        begin
        str(indvettore:1,temp);
        write_ln(fout,'  Fielddefs.Add('''+descrizione+temp+''','+TipoDati+','+Lungst+',false);');
        end
      else
      write_ln(fout,'  Fielddefs.Add('''+descrizione+''','+TipoDati+','+Lungst+',false);');
      end;

    if vettore then
      begin
      for IndVettore:=1 to NVettore do
        begin
        if slave then str(count+1+Indvettore-1:1,ss) else str(count-1+Indvettore-1:1,ss);
        str(indvettore:1,temp);

        if descrizione[1]<>'#' then
        Write_ln(fdatain,'    '+campo+'['+temp+']:=tabella1.fields['+ss+'].'+funzconv+';')
        else Write_ln(fdatain,'    '+campo+'['+temp+']:='+Valorefisso+';');



        if descrizione[1]<>'#' then
          begin
          if upstring(tipo)='REAL' then Write_ln(fdataout,'    tabella1.fields['+ss+'].'+funzconv+':=F_real('+campo+'['+temp+'],'+cdec+');')
          else Write_ln(fdataout,'    tabella1.fields['+ss+'].'+funzconv+':='+campo+'['+temp+'];');

          if (not master)or (ss<>'0') then
            begin
            //*NN Write_ln(fOpen,'    tabella1.fields[CampoDB_'+Nometabella+'].asstring:=ValoreCampo;');
            if numcampo<>'' then
            Write_ln(fSave,'    WriteCampo('''+NumCampo+':''+tabella1.fields['+ss+'].asstring);');
            end;

          end;
        end;
      if descrizione[1]<>'#' then count:=count+NVettore-1;
      end
    else
      begin
      if slave then str(count+1:1,ss) else str(count-1:1,ss);
      if descrizione[1]<>'#'  then
      Write_ln(fdatain,'    '+campo+':=tabella1.fields['+ss+'].'+funzconv+';')
      else Write_ln(fdatain,'    '+campo+':='+Valorefisso+';');

      if descrizione[1]<>'#'  then
        begin
        if (Not Master)or(ss<>'0')then
        Write_ln(fdataout,'    tabella1.fields['+ss+'].'+funzconv+':='+campo1+';');

        if (not master )or (ss<>'0') then
          begin
          //*NNWrite_ln(fOpen,'    tabella1.fields[CampoDB_'+NomeTabella+'].asstring:=ValoreCampo;');
          if NumCampo<>'' then
          Write_ln(fSave,'    WriteCampo('''+NumCampo+':''+tabella1.fields['+ss+'].asstring);');
          end;
        end;

      end;

    if numcampo<>'' then Write_ln(FCampoDB,'  '+NumCampo+':Result:='+ss+';');
    if numcampo<>'' then
      begin
      if tipo='AUTOINC' then
        begin
        autoinc:=true;
        tipo:='INTEGER';
        end;
      if tipo='INTEGER' then
      if notslave then write_ln(FCampoDB_mem,'  '+NumCampo+':'+Varname+tipo_stru(datastru,doppiop,numarray)+Campo+':=strtoint(valore);')
      else write_ln(FCampoDB_mem,'  '+NumCampo+':Associata.'+Campo+':=strtoint(valore);');

      if copy(tipo,1,4)='REAL' then
        begin
        if notslave then write_ln(FCampoDB_mem,'  '+NumCampo+':'+Varname+tipo_stru(datastru,doppiop,numarray)+Campo+':=str_tofloat(valore);')
        else write_ln(FCampoDB_mem,'  '+NumCampo+':Associata.'+Campo+':=str_tofloat(valore);');

        campo1:='F_real('+Campo+','+CDEC+')';
        if tipo<>'REAL' then
          begin
          Val(copy(tipo,6,length(tipo)-6),Nvettore,erconv);
          if erconv=0 then Vettore:=true;
          end;
        tipo:='REAL';
        end;
      if copy(tipo,1,6)='STRING' then
      if notslave then write_ln(FCampoDB_mem,'  '+NumCampo+':'+Varname+tipo_stru(datastru,doppiop,numarray)+Campo+':=valore;')
      else write_ln(FCampoDB_mem,'  '+NumCampo+':Associata.'+Campo+':=valore;');
      end;

    if descrizione[1]<>'#'  then
      begin
      tt1:=Tipo;
      if copy(tipo,1,6)='STRING' then tt1:=copy(tipo,1,6);
      Write_ln(FDataLink,'       Function '+campo+':'+tt1+';');
      Write_ln(FProcLink,'Function O_'+Nomerec+'.'+campo+':'+tt1+';');
      Write_ln(FProcLink,'Begin');
      Write_ln(fProcLink,'If Tab0 then result:=Dm1.tt0.fields['+ss+'].'+funzconv);
      Write_ln(fProcLink,'else If TabT Then result:=DmTutti.t_'+Nometabella+'.fields['+ss+'].'+funzconv);
      Write_ln(fProcLink,'else result:=Dm1.tt'+indt+'.fields['+ss+'].'+funzconv+';');
      Write_ln(FProcLink,'End;');
      Write_ln(FDataLink,'       Procedure Set_'+campo+'(Par:'+tt1+');');
      Write_ln(FProcLink,'Procedure O_'+Nomerec+'.'+'Set_'+campo+'(Par:'+tt1+');');
      Write_ln(FProcLink,'Begin');
      {Write_ln(fProcLink,'Dm1.tt1.Edit;');}
      Write_ln(fProcLink,'If Tab0 then Dm1.tt0.fields['+ss+'].'+funzconv+':=Par');
      Write_ln(fProcLink,'else If TabT then DmTutti.t_'+Nometabella+'.fields['+ss+'].'+funzconv+':=Par');
      Write_ln(fProcLink,'else Dm1.tt'+indt+'.fields['+ss+'].'+funzconv+':=Par;');
      {Write_ln(fProcLink,'Dm1.tt1.POst;');}
      Write_ln(FProcLink,'End;');
      end;
    end;
  end;

if slave then
  begin
  write_ln(fout,'  IndexDefs.Add(''PerIndice'',''Indice'',[IxPrimary]);');
  write_ln(fout,'  IndexDefs.Add(''Per'+Linkcode+''','''+Linkcode+''',[IXdescending]);');
  end;
if Master then
write_ln(fout,'  IndexDefs.Add(''Per'+Linkcode+''','''+Linkcode+''',[IxPrimary]);');

write_ln(FDataLink,'       End;');
Write_ln(fDataLink,'Var V_'+Nomerec+':O_'+Nomerec+';');

Write_ln(FIni,'  exit;');
Write_ln(FIni,'  End;');
Write_ln(FInimem,'  exit;');
Write_ln(FInimem,'  End;');
Write_ln(FCampoDb,'  End;');
Write_ln(FCampoDb,'End;');
Write_ln(FCampoDb_mem,'  End;');
Write_ln(FCampoDb_mem,'End;');

//if (not vuoto)or archivio then
  begin
  Write_ln(Fconferma,'  end;');
  Write_ln(FForm,'  end;');
  end;

Write_ln(Ftype,'       End;');
Write_ln(Ftype_C,'       };');
if datastru='array' then
  begin
  if doppioP then
    begin
    Write_ln(Ftype,'Ar_'+Nomerec+'=array[1..'+maxarray+']of ^'+nomerec+';');
    Write_ln(Ftype_C,'typedef '+nomerec +'* Ar_'+Nomerec+' ['+maxarray+'];')
    end
  else
    begin
    Write_ln(Ftype,'Ar_'+Nomerec+'=array[1..'+maxarray+']of '+nomerec+';');
    Write_ln(Ftype_C,'typedef '+Nomerec+ ' Ar_'+Nomerec+' ['+maxarray+'];');
    end;
  if notslave then
    begin
    Write_ln(Ftype,'Var '+varname+':^Ar_'+nomerec+';');
    Write_ln(Ftype_C,'Ar_'+Nomerec+'* '+varname+'=NULL;')
    end;
  end
else
  begin
  Write_ln(Ftype,'Var '+varname+':^'+nomerec+';');
  Write_ln(Ftype_C,Nomerec+'* '+varname+'=NULL;');
  end;

if not(slave) then
  begin
  Write_ln(fnewpun,'New('+Varname+');');
  if doppioP then
    begin
    Write_ln(fnewpun,'For i:=1 to '+NumMaxarray +' Do');
    Write_ln(fnewpun,Varname+'^[i]:=Nil;');
    end;
  Write_ln(fDispPun,'Dispose('+Varname+');');
  end;

write_ln(fout,'  CreateTable;');
if cbNobde.checked then write_ln(fout,'active:=true;');
if cbNobde.checked then
write_ln(fout,'  Close;');
{Write_ln(Fout,'  Open;');
Write_ln(Fout,'  Refresh;');}
write_ln(fout,'  End;');
write_ln(fout,'End;');

Write_ln(fDatain,'    end;');
if datastru='array' then
  begin
  if (cbNobde.checked)and(slave) then write_ln(fdatain,'  end;');
  Write_ln(fDatain,'  Tabella1.Next;');
  Write_ln(fDatain,'  end;');
  if notslave then Write_ln(fDatain,NumArray+':=i;');
  end;
if master then
  begin
  Write_ln(fDatain,'If not tabT then');
  Write_ln(fDatain,'  begin');
  Write_ln(fDatain,'  Tabella3.Masterfields:='''';');
  Write_ln(fDatain,'  Tabella3.IndexName:='''';');
  Write_ln(fDatain,'  end;');
  end;

Write_ln(fDatain,'end;');
if (salvadb)and (not slave)then
  begin
  Write_ln(fDatain,'Procedure Leggi_Mem_'+nometabella+';');
  Write_ln(fDatain,'Begin');
  Write_ln(fDatain,'If not '+nometabella+'_in_memoria then');
  Write_ln(fDatain,'with dmtutti do');
  Write_ln(fDatain,'  Begin');
  Write_ln(fDatain,'  if Gest_dati_mem  then '+nometabella+'_in_memoria:= true;');
  if master then Write_ln(fDatain,'  OLD_leggi_'+nometabella+'(T_'+Nometabella+',T_'+Nometabslave+',ds_'+Nometabella+');')
  else Write_ln(fDatain,'  OLD_leggi_'+nometabella+'(T_'+Nometabella+',T_'+Nometabella+',ds_'+Nometabella+');');
  Write_ln(fDatain,'  end;');
  Write_ln(fDatain,'End;');
  write_ln(fDatain,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+';DataS1:Tdatasource);');
  Write_ln(fDatain,'Begin');
  Write_ln(fDatain,'if not Gest_dati_mem  then ');
  write_ln(fDatain,'OLD_Leggi_'+nometabella+'(Tabella1,Tabella3,DataS1)');
  Write_ln(fDatain,'else');
  Write_ln(fDatain,'Leggi_Mem_'+nometabella+';');
  Write_ln(fDatain,'End;');
  end;
Write_ln(fSave,'    Writecampo(''#FINECAMPI#'');');

if master then
  begin
  Write_ln(fSave,'    SaveTxt_'+Nometabslave+'(Tabella3);');
  end;

Write_ln(fSave,'    end;');


if datastru='array' then
  begin
  Write_ln(fSave,'  Tabella1.Next;');
  Write_ln(fSave,'  end;');
  end;

if slave then Write_ln(fSave,'Writecampo(''#FINETABASSOCIATA#'');');

if master then
  begin
  Write_ln(fSave,'If not tabT then');
  Write_ln(fSave,'  begin');
  Write_ln(fSave,'  Tabella3.Masterfields:='''';');
  Write_ln(fSave,'  Tabella3.IndexName:='''';');
  Write_ln(fSave,'  end;');
  end;

Write_ln(fSave,'end;');



Write_ln(fOpen,'    Tabella1.POst;');
if master then
  begin
  if cbNobde.checked then Write_ln(fOpen,'    Indmaster:=tabella1.fields[0].asinteger;');
  Write_ln(fOpen,'    OpenTxt_'+nometabSlave+'(Tabella3);');
  end;
if datastru='array' then Write_ln(fOpen,'  end;')
else Write_ln(fOpen,'ReadValoreCampo;');
if {(cbNobde.checked)and}(notslave) then
  begin
  Write_ln(fOPen,'tabella3.close;');
  Write_ln(fOPen,'tabella1.close;');
  end;
Write_ln(fOpen,'end;');
Write_ln(fOpen_mem,'end;');

if (cbNobde.checked)and(slave) then Write_ln(fDataout,'    tabella1.fields[1].asinteger:=indmaster;');
Write_ln(fDataout,'    Tabella1.POst;');
if (cbNobde.checked)and(master) then Write_ln(fDataout,'    indmaster:=i-1;');
if master then
Write_ln(fDataout,'    Salva_'+nometabSlave+'(Tabella3,'+CampoSlave+','+NumarraySlave+');');
//if doppioP then Write_ln(fDataout,'    Dispose('+varname+'^[i]);');

Write_ln(fDataOut,'    end;');
if datastru='array' then Write_ln(fDataOut,'  end;');
if notslave then
  begin
  //Write_ln(fDataout,'Tabella1.refresh;');
  end;
if master then
  begin
  Write_ln(fDataout,'if not Tabt then');
  Write_ln(fDataout,'  begin');
  Write_ln(fDataout,'  Tabella3.Masterfields:='''';');
  Write_ln(fDataout,'  Tabella3.IndexName:='''';');
  Write_ln(fDataout,'  end;');
  end;
Write_ln(fDataOut,'end;');
Nomeslave:=nomerec;
NumArraySlave:=Numarray;
Nometabslave:=Nometabella;
LinkCodeSlave:=LinkCode;
end;

procedure CreaMappa;
Var ss:string;
    fdata:textfile;
begin
if locale then
  begin
  ss:=Pathloc;
  chdir(ss);
  end
else
  begin
  if paramcount>0 then
    begin
    ss:=paramstr(1);
    chdir(ss);
    end
  else chdir('d:\bmsistemi\dev\term\carichi\database');
  end;
form1.Edit1.text:=ss;
//chdir(form1.Edit1.text);
//chdir('d:\bmsistemi\dev\term\carichi\database');
//getdir(0,ss);
if not fileexists(ss+'\base.dat') then
  begin
  showmessage('non esite :'+ss+'\base.dat');
  exit;
  end;
if cbNobde.checked then
  begin
  VQ:='Q';
  tipotab:='TTableQ' ;
  usesdb:='DbTablesQ';
  end
else
  begin
  VQ:='';
  tipotab:='TTable';
  usesdb:='DbTables';
  end;

assemblabase(ss+'\base.dat');

numtabelle:=0;
Assignfile(Basedati,{c:\ded\sorgenti\genera\}'base.dat');
reset(Basedati);

//if paramcount>1 then
//  begin
//  ss:=paramstr(2);
//  end
//else ss:='D:\DISTRIBUZIONE_10\VERSIONE_10\CPI WIN CLIMA\Combo.txt';
//Fassignfile(fcombo,ss);
//form1.Edit2.text:=ss;
Fassignfile(fcombo,'Combo.txt');
Frewrite(fCombo);
{ TODO -oGenera -cNavigazione : Intestazione file}
Fassignfile(fUdb,'UDBT.pas');
Frewrite(fUdb);
FWriteln(FUdb,'unit UDBT;');
FWriteln(FUdb,'');
FWriteln(FUdb,'interface');
FWriteln(FUdb,'');
FWriteln(FUdb,'uses');
FWriteln(FUdb,'  SysUtils, Classes, DB, kbmMemTable, DbtablesQ,dbtables,funzUDBT,libreriagenerale;');
FWriteln(FUdb,'');
FWriteln(FUdb,'Type dbcom=(Init,chiudi,nuovo,nuovoarch,apri,salva,salvaarch,leggi);');
FWriteln(FUdb,'  TDMTutti = class(TDataModule)');

Fassignfile(fUdbdfm,'UDBT.dfm');
Frewrite(fUdbDFm);
FWriteln(FUdbDFm,'object DMTutti: TDMTutti');
FWriteln(FUdbDFm,'  OldCreateOrder = False');
FWriteln(FUdbDFm,'  Left = 490');
FWriteln(FUdbDFm,'  top = 110');
FWriteln(FUdbDFm,'  Height = 750');
FWriteln(FUdbDFm,'  Width = 950');

Fassignfile(fcomdb,'comdb.pas');
Frewrite(fcomdb);

Fassignfile(fCreadb,'inclusi\Creadb.pas');
Frewrite(fCreadb);
FWriteln(FCreadb,'Procedure Creadatabase(nome:string);');
FWriteln(FCreadb,'Begin');

Fassignfile(fCreadbT,'CreadbT.pas');
Frewrite(fCreadbT);
FWriteln(FCreadbT,'Unit CreaDbT;');
FWriteln(FCreadbT,'Interface');
if form1.cbnobde.checked  then FWriteln(FCreadbT,'uses Udbt,db,DBtablesQ,sysutils;')
else FWriteln(FCreadbT,'uses Udbt,db,DBtables,sysutils,varcarichi;');
FWriteln(FCreadbT,'Procedure Creadatabase(nome:string);');
FWriteln(FCreadbT,'Implementation');
FWriteln(FCreadbT,'{$I MappaDB}');
FWriteln(FCreadbT,'Procedure Creadatabase(nome:string);');
FWriteln(FCreadbT,'Begin');
FWriteln(FCreadbT,'Nome:=uppercase(nome);');

Fassignfile(fCompila,'CompilaLista.pas');
Frewrite(fCompila);
FWriteln(Fcompila,'Procedure CompilaLista;');
FWriteln(Fcompila,'Begin');

Fassignfile(fnewPun,'inclusi\NewPun.pas');
Frewrite(fNewPun);
FWriteln(FNewPun,'Procedure InitPuntatori;');
FWriteln(FNewPun,'Var I:integer;');
FWriteln(FNewPun,'Begin');
Fassignfile(fDispPun,'inclusi\DispPun.pas');
Frewrite(fDispPun);
FWriteln(FDispPun,'Procedure DisposePuntatori;');
FWriteln(FDispPun,'Begin');

Fassignfile(fout,{c:\ded\sorgenti\genera\}'inclusi\mappadb.pas');
Frewrite(fout);

Fassignfile(fDataLink,{c:\ded\sorgenti\genera\}'UDataLink.pas');
Frewrite(fDataLink);
FWriteln(Fdatalink,'Unit UDataLink;');
FWriteln(Fdatalink,'Interface');
FWriteln(Fdatalink,'Uses Udb,UdbT ;');

Fassignfile(fIoDati,'ULeggiscriviDati.pas');
Frewrite(fIoDati);
FWriteln(fIoDati,'Unit ULeggiscrividati;');
FWriteln(fIoDati,'Interface');
FWriteln(fIoDati,'Uses DB,Varcarichi,udbt,udb,'+UsesDb+',Sysutils,math,creadbt;');

Fassignfile(fLtutti,'Leggitutti.pas');
Frewrite(fLtutti);
FWriteln(FLtutti,'Procedure Leggidati;');
FWriteln(FLtutti,'Begin');
Fassignfile(fLtuttiT,'LeggituttiT.pas');
Frewrite(fLtuttiT);
FWriteln(FLtuttiT,'Procedure LeggidatiT;');
FWriteln(FLtuttiT,'Begin');
Fassignfile(fstutti,'scrivitutti.pas');
Frewrite(fstutti);
FWriteln(FStutti,'Procedure Scrividati;');
FWriteln(FStutti,'Begin');
Fassignfile(fstuttiT,'scrivituttiT.pas');
Frewrite(fstuttiT);
FWriteln(FStuttiT,'Procedure ScrividatiT;');
FWriteln(FStuttiT,'Begin');

Fassignfile(fini,'inclusi\init.pas');
Frewrite(fini);
Fwriteln(Fini,'Procedure initDb(Nome:String);');
Fwriteln(Fini,'Begin');
Fwriteln(Fini,'Nome:=Upstring(nome);');

Fassignfile(finimem,'initMem.pas');
Frewrite(finimem);
Fwriteln(Finimem,'Procedure initMem(Nome:String;ind,ind2:integer);');
Fwriteln(Finimem,'Begin');
Fwriteln(Finimem,'Nome:=Upstring(nome);');


Fassignfile(fNuovo,'inclusi\Nuovo.pas');
Frewrite(fNuovo);
Fwriteln(FNuovo,'Procedure NuovoDb;');
Fwriteln(FNuovo,'Begin');

Fassignfile(fForm,'CompilaForm.pas');
Frewrite(fForm);

Fassignfile(fOpen,'Openfile.pas');
Frewrite(fOpen);
Fassignfile(fOpen_mem,'Openfile_mem.pas');
Frewrite(fOpen_mem);

Fassignfile(fSave,'inclusi\Savefile.pas');
Frewrite(fSave);

Fassignfile(fconferma,'Conferma.pas');
Frewrite(fconferma);
Fassignfile(fcontrolla,'Controlli.pas');
Frewrite(fcontrolla);


Fassignfile(fProcLink,{c:\ded\sorgenti\genera\}'DataLink.pas');
Frewrite(fProcLink);

Fassignfile(fDataIn,{c:\ded\sorgenti\genera\}'DataIn.pas');
Frewrite(fDataIn);
Fassignfile(fDataout,{c:\ded\sorgenti\genera\}'DataOut.pas');
Frewrite(fDataout);


Fassignfile(fUDataoutT,'UDataOutT.pas');
Frewrite(fUDataoutT);
FWriteln(FUDataoutT,'Unit UDataOutT;');
FWriteln(FUDataoutT,'Interface');
if form1.cbnobde.checked  then FWriteln(FUDataoutT,'uses Sysutils,Varcarichi,Math,db,udb,CreaDbT,DBtablesQ;')
else FWriteln(FUDataoutT,'uses Sysutils,Varcarichi,Math,db,Udb,Udbt,CreaDbT,DBtables;');
Fassignfile(ftype,{c:\ded\sorgenti\genera\}'inclusi\Typedef.pas');
Frewrite(ftype);
Write_ln(ftype,'Var Gest_dati_mem:boolean=false;');
Fassignfile(ftype_C,{c:\ded\sorgenti\genera\}'sorg_c\typedef.h');
Frewrite(ftype_C);
Write_ln(ftype_C,'Var Gest_dati_mem:boolean=false;');
Fassignfile(fReport,'inclusi\ReportFisso.pas');
Frewrite(fReport);

Fassignfile(fCaseTab,'CaseTabella.pas');
Frewrite(fCaseTab);
Fassignfile(fCaseTab_mem,'CaseTabella_mem.pas');
Frewrite(fCaseTab_mem);


Fassignfile(fCaseTabT,'CaseTabellaT.pas');
Frewrite(fCaseTabT);

Fassignfile(fCampoDb,'CampoDb.pas');
Frewrite(fCampoDb);
Fassignfile(fCampoDb_mem,'CampoDb_mem.pas');
Frewrite(fCampoDb_mem);

riga:='  ';
while ((riga[2]<>'*')or (length(riga)<2))and (not eof(basedati)) do Leggidati;
{ TODO -oGenera -cNavigazione : Chiusura file }
FWriteln(FUdb,'  procedure ONNewRecord(DataSet: TDataSet);');
FWriteln(FUdb,'  procedure ONFilterRecord(DataSet: TDataSet;var Accept: Boolean);');
FWriteln(FUdb,'  private');
FWriteln(FUdb,'    { Private declarations }');
FWriteln(FUdb,'  public');
FWriteln(FUdb,'    { Public declarations }');
FWriteln(FUdb,'    Procedure ComDB(action:DBCom;Par,ParA:string);');
FWriteln(FUdb,'  end;');
FWriteln(FUdb,'');
FWriteln(FUdb,'var');
FWriteln(FUdb,'  DMTutti: TDMtutti;');
FWriteln(FUdb,'');
FWriteln(FUdb,'Var Tipofiltro,ValF1,ValF2,ValF3:string;');
FWriteln(FUdb,'implementation');
FWriteln(FUdb,'');
FWriteln(FUdb,'Uses Udatalink,udb,varcarichi;');
FWriteln(FUdb,'{$R *.dfm}');
FWriteln(FUdb,'');
FWriteln(FUdb,'{$I MappaDB}');
FWriteln(FUdb,'{$I SaveFile}');
FWriteln(FUdb,'Procedure TDMTutti.ComDB(action:DBCom;Par,ParA:string);');
FWriteln(FUdb,'Begin');
FWriteln(FUdb,'{$I ComDB}');
FWriteln(FUdb,'End;');
FWriteln(FUdb,'{$I Init }');
FWriteln(FUdb,'procedure TDMTutti.ONFilterRecord(DataSet: TDataSet;var Accept: Boolean);');
FWriteln(FUdb,'Var nometab:string;');
FWriteln(FUdb,'begin');
FWriteln(FUdb,'nometab:=(dataset as TTable).TableName;');
FWriteln(FUdb,'nometab:=uppercase(copy(nometab,1,length(nometab)-3));');
FWriteln(FUdb,'{$I Filtri_DB}');
FWriteln(FUdb,'end;');
FWriteln(FUdb,'procedure TDMTutti.ONNewRecord(DataSet: TDataSet);');
if cbnobde.checked then FWriteln(FUdb,'Var TLoc: TTableQ;')
else FWriteln(FUdb,'Var TLoc: TTable;');
FWriteln(FUdb,'begin');
if cbnobde.checked then FWriteln(FUdb,'TLoc:=Dataset as TTableQ;')
else FWriteln(FUdb,'TLoc:=Dataset as TTable;');
FWriteln(FUdb,'InitDb(copy(Tloc.tablename,1,length(TLoc.tablename)-3));');
FWriteln(FUdb,'end;');
FWriteln(FUdb,'end.');
Fclosefile(FUdb);

FWriteln(FUdbDFm,'end');
Fclosefile(FUdbDfm);
Fclosefile(Fcomdb);
Fclosefile(Fcontrolla);
Fclosefile(Fconferma);
Fclosefile(FForm);
Fclosefile(FReport);
Fclosefile(FCaseTab);
Fclosefile(FCaseTab_mem);
Fclosefile(FCaseTabT);
Fclosefile(FCampoDb);
Fclosefile(Fout);
Fclosefile(Ftype);
Fclosefile(Ftype_C);
Fclosefile(FDataIn);
Fclosefile(FDataOut);

FWriteln(FUDataOutT,'Implementation');
FWriteln(FUDataOutT,'{$I Freal}');
FWriteln(FUDataOutT,'{$I DataOut}');
FWriteln(FUDataOutT,'{$I Datain}');
FWriteln(FUDataOutT,'End.');
Fclosefile(FUDataOutT);


FWriteln(Fdatalink,'Implementation');
FWriteln(Fdatalink,'{$I DataLink.pas}');
FWriteln(Fdatalink,'End.');

FWriteln(FIodati,'Procedure Scrividati;');
FWriteln(FIodati,'Procedure Leggidati;');
FWriteln(FIodati,'Procedure ScrividatiT;');
FWriteln(FIodati,'Procedure LeggidatiT;');
FWriteln(FIodati,'Implementation');
if cbnobde.checked then FWriteln(FIodati,'Var indmaster:integer;');
FWriteln(FIodati,'Function F_real(Num:real;Cifredec:integer):real;');
FWriteln(FIodati,'Var i:integer;');
FWriteln(FIodati,'Begin');
//FWriteln(FIodati,'For i:=1 to cifredec do Num:=num*10;');
//FWriteln(FIodati,'Num:=round(num);');
//FWriteln(FIodati,'For i:=1 to cifredec do Num:=num/10;');
//FWriteln(FIodati,'result:=num;');
FWriteln(FIodati,'if cifredec=-1 then');
FWriteln(FIodati,'  begin');
FWriteln(FIodati,'  result:=num;');
FWriteln(FIodati,'  exit;');
FWriteln(FIodati,'  end;');
FWriteln(FIodati,'result:=RoundTo(num,-cifredec);');
FWriteln(FIodati,'end;');
FWriteln(FIodati,'{$I Datain.pas}');
FWriteln(FIodati,'{$I DataOut.pas}');
FWriteln(FIodati,'{$I Leggitutti.pas}');
FWriteln(FIodati,'{$I Scrivitutti.pas}');
FWriteln(FIodati,'{$I LeggituttiT.pas}');
FWriteln(FIodati,'{$I ScrivituttiT.pas}');
FWriteln(FIodati,'End.');


Fclosefile(FIodati);

Fclosefile(FOpen);
Fclosefile(FOpen_mem);

Fclosefile(FSave);

Fwriteln(FNuovo,'End;');
Fclosefile(FNuovo);


Fwriteln(Fini,'End;');
Fclosefile(Fini);
Fwriteln(Finimem,'End;');
Fclosefile(Finimem);

FWriteln(FLtutti,'End;');
FWriteln(FStutti,'End;');
Fclosefile(FLtutti);
Fclosefile(Fstutti);
FWriteln(FLtuttiT,'End;');
FWriteln(FStuttiT,'End;');
Fclosefile(FLtuttiT);
Fclosefile(FstuttiT);


Fclosefile(FDataLink);
Fclosefile(FProcLink);

FWriteln(FNewPun,'End;');
FCloseFile(fNewPun);
FWriteln(FDispPun,'End;');
FClosefile(fDispPun);

FWriteln(FCompila,'End;');
FClosefile(fCompila);

FWriteln(FCreadb,'End;');
FClosefile(fCreadb);

FWriteln(FCreadbT,'End;');
FWriteln(FCreadbT,'End.');
FClosefile(fCreadbT);



Fclosefile(FCombo);

closefile(basedati);
assignfile(Fdata,'inclusi\data.pas');
rewrite(fdata);
writeln(fdata,'Datacor:='''+DateToStr(Date)+''';');
closefile(fdata);
end;

Procedure Leggiriga;
begin
repeat readln(basedati,riga); until valida(riga);
if (riga<>'') and (riga[1]='/') then showmessage(riga);
POsind:=0;
end;
Var Nomeproc,TipoCalc,fase:string;

Procedure Leggi_Identif(Var sysvar:string;Up_string:boolean);
begin
LeggiIdentif;
sysvar:=identif;
if up_string then sysvar:=UpString(sysvar);
end;

Procedure Inseriscirighe;
begin
  repeat
  leggiriga;
  if upstring(riga)<>'END:' then
  writeln(ffout,riga);
  until upstring(riga)='END:';
leggiriga;
leggi_Identif(fase,true);
end;
Procedure GeneraPercorri;
begin
leggiriga;
leggi_Identif(fase,true);
writeln(ffout,'{*************************************************************}');
writeln(ffout,'Procedure Iter_Percorri_'+TipoCalc+'(Nodo:integer);');
writeln(ffout,'Var i:Integer;');
if fase='DEFINIZ' then inseriscirighe;
writeln(ffout,'Begin');
writeln(ffout,'With Dati^[nodo] Do');
writeln(ffout,'  Begin');
if fase='PRIMA' then inseriscirighe;
writeln(ffout,'  For i:=1 to Npros do');
writeln(ffout,'  Iter_Percorri_'+TipoCalc+'(Pros[i].ramo);');
writeln(ffout,'  End;');
writeln(ffout,'End;');
writeln(ffout,'Procedure Percorri_'+Tipocalc+';');
writeln(ffout,'Begin');
writeln(ffout,'Iter_Percorri_'+TipoCalc+'(Primonodo);');
writeln(ffout,'End;');
end;
Procedure Leggiproc;
Var Proc:string;
begin
Leggiriga;
leggi_identif(Nomeproc,true);
leggi_identif(TipoCalc,false);
if NomeProc='PERCORRI' then GeneraPercorri;
end;
Procedure Generaproc;
begin
Assignfile(Basedati,'d:\ded\sorgenti\genera\Proc.dat');
reset(Basedati);
assignfile(ffout,'d:\ded\sorgenti\genera\Proc.pas');
rewrite(ffout);
riga:='  ';
while ((riga[2]<>'*')or (length(riga)<2))and (not eof(basedati)) do LeggiProc;
closefile(fFout);
closefile(basedati);
end;
begin
if (checkbox1.Checked)and
(label2.caption<>'Verranno cancellati i file della  ( Database ) (parametro 2)' )then
  begin
  cancellafileestensione(label2.caption,'db');
  end;
CreaMappa;
showmessage('Generazione completata');
//GeneraProc;
end;

procedure TForm1.FormActivate(Sender: TObject);
Var ss:string;
begin
GetDir(0,ss);
edit1.text:=ss;
if paramcount>0 then
  begin
  ss:=paramstr(1);
  end
else ss:='Manca il parametro';
form1.Edit1.text:=ss;
if paramcount>1 then
  begin
  label2.Caption:=paramstr(2);
  end;

end;

end.
