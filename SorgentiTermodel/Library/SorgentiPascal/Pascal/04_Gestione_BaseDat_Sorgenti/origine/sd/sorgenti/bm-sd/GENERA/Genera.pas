

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
Var NumArraySlave,NomeSlave,riga,NometabSlave,linkcodeslave,identif,Tipostru:string;
    PosInd:Integer;
    tipotab,usesdb:string;
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
    TipoArray,Autoinc,Doppiop,vettore,vuoto,Archivio:boolean;

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
readln(basedati,riga);
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

readln(basedati,riga);
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

write_ln(fProcLink,'{*************************************************************}');

write_ln(fDataLink,'{*************************************************************}');
write_ln(fDataLink,'Type ');
write_ln(fDataLink,'O_'+Nomerec+'=');
write_ln(fDataLink,'       ObJect');

write_ln(ftype,'{*************************************************************}');
if datastru='array' then
  begin
  write_ln(ftype,'Const '+maxarray+'='+NumMaxarray+';');
  if notslave then Write_ln(ftype,'Var '+Numarray+':integer;');
  end;
write_ln(ftype,'Type ');
write_ln(ftype,Nomerec+'=Record');
if master then
  begin
  write_ln(ftype,'       '+Camposlave+':Ar_'+Nomeslave+';');
  write_ln(ftype,'       '+NumarraySlave+':Integer;');
  end;

write_ln(fSave,'{*************************************************************}');

write_ln(fDatain,'{*************************************************************}');
if slave then
  begin
  write_ln(fSave,'Procedure SaveTxt_'+nometabella+'(var Tabella1:'+TipoTab+');');
  write_ln(fDatain,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+Nomerec+';Var i:Integer);');
  write_ln(fIoDati,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+Nomerec+';Var i:Integer);');
  end
else
  begin
  write_ln(fSave,'Procedure SaveTxt_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+');');
  write_ln(fDatain,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+');');
  write_ln(fIodati,'Procedure Leggi_'+nometabella+'(var Tabella1:'+TipoTab+';var Tabella3:'+TipoTab+');');
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
    write_ln(fSave,'Tabella3.MasterSource:=dm1.Datasource1;');
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
    write_ln(fDataIn,'Tabella3.MasterSource:=dm1.Datasource1;');
    Write_ln(fDatain,'Tabella3.open;');

    end;
  end;
Write_ln(fDatain,'Tabella1.first;');
if datastru='array' then Write_ln(fDatain,'While not Tabella1.eof do');
if datastru='array' then Write_ln(fDatain,'  Begin');
if datastru='array' then
  begin
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
  Write_ln(fDatain,'    Leggi_'+Nometabslave+'(Tabella3,'+Camposlave+','+NumarraySlave+');');
  end;

if notslave then
Write_ln(FCaseTab,'If NomeTabella='''+UpperNomeTabella+'''then OpenTxt_'+Nometabella+'(dm1.tt1,dm1.tt3);')
else Write_ln(FCaseTab,'If NomeTabella='''+UpperNomeTabella+'''then OpenTxt_'+Nometabella+'(dm1.tt3);');

Write_ln(fCampoDb,'{*************************************************************}');
Write_ln(fCampoDb,'Function CampoDb_'+NomeTabella+':Integer;');
Write_ln(fCampoDb,'Begin');
Write_ln(fCampoDb,'  Case CampoCor of');
Write_ln(fCampoDb,'  -1:CampoCor:=campoCor;//Per fare compilare i case vuoti');

Write_ln(fOpen,'{*************************************************************}');

Write_ln(fDataout,'{*************************************************************}');
if slave then
  begin
  Write_ln(fDataout,'Procedure Salva_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+NomeRec+';Indmax:integer);');
  Write_ln(fIodati,'Procedure Salva_'+nometabella+'(var Tabella1:'+TipoTab+';Var arr:Ar_'+NomeRec+';Indmax:integer);');
  Write_ln(fOpen,'Procedure OpenTxt_'+nometabella+'(var Tabella1:'+TipoTab+');');
  end
else
  begin
  if not archivio then
    begin
    Write_ln(fStutti,'Salva_'+nometabella+'(dm1.tt1,dm1.tt3);');
    Write_ln(fLtutti,'Leggi_'+nometabella+'(dm1.tt1,dm1.tt3);');
    end;
  Write_ln(fOpen,'Procedure OpenTXT_'+nometabella+'(var Tabella1,Tabella3:'+TipoTab+');');

  Write_ln(fDataout,'Procedure Salva_'+nometabella+'(var Tabella1,Tabella3:'+TipoTab+');');
  Write_ln(fIodati,'Procedure Salva_'+nometabella+'(var Tabella1,Tabella3:'+TipoTab+');');
  end;

Write_ln(fOpen,'Begin');
if not(Master)and(notslave) then
  begin
  Write_ln(fOpen,'Tabella3.IndexName:='''';');
  Write_ln(fOpen,'Tabella3.Masterfields:='''';');
  end;
if master then
  begin
  Write_ln(fOpen,'Tabella3.Close;');
  Write_ln(fOpen,'CreaDatabase('''+Nometabslave+''');');
  end;
if notslave then
  begin
  Write_ln(fOpen,'CreaDatabase('''+Nometabella+''');');
  Write_ln(fOpen,'  Tabella1.open;');
  end;
if master then
  begin
  Write_ln(fOpen,'Tabella3.close;');
  Write_ln(fOpen,'Tabella3.tablename:='''+Nometabslave+'.DB'+''';');
  Write_ln(fOpen,'Tabella3.Masterfields:='''+linkcodeslave+''';');
  Write_ln(fOpen,'Tabella3.IndexName:=''Per'+linkcodeslave+''';');
  Write_ln(fOpen,'Tabella3.MasterSource:=dm1.Datasource1;');
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
Write_ln(fOPen,'    tabella1.fields[CampoDB_'+Nometabella+'].asstring:=ValoreCampo;');
Write_ln(fOPen,'    Leggi_campo;');
Write_ln(fOPen,'    End;');


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
  write_ln(fDataout,'Tabella3.MasterSource:=dm1.Datasource1;');
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
write_ln(fout,'  TableName:='''+Nometabella+''';');
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
  readln(basedati,riga);
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

    Cdec:='1';
    Leggivarianti;
    if tipo='REAL' then campo1:='F_real('+Campo+','+CDEC+')';


     if vettore then
       begin
       str(Nvettore:1,temp);
       Write_ln(Ftype,'       '+campo+':array[1..'+temp+'] of '+tipo+';');
       end
     else
     Write_ln(Ftype,'       '+campo+':'+tipo+';');

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

    if descrizione[1]<>'#'  then
      begin
      tt1:=Tipo;
      if copy(tipo,1,6)='STRING' then tt1:=copy(tipo,1,6);
      Write_ln(FDataLink,'       Function '+campo+':'+tt1+';');
      Write_ln(FProcLink,'Function O_'+Nomerec+'.'+campo+':'+tt1+';');
      Write_ln(FProcLink,'Begin');
      Write_ln(fProcLink,'If Tab0 then result:=Dm1.tt0.fields['+ss+'].'+funzconv);
      Write_ln(fProcLink,'else result:=Dm1.tt'+indt+'.fields['+ss+'].'+funzconv+';');
      Write_ln(FProcLink,'End;');
      Write_ln(FDataLink,'       Procedure Set_'+campo+'(Par:'+tt1+');');
      Write_ln(FProcLink,'Procedure O_'+Nomerec+'.'+'Set_'+campo+'(Par:'+tt1+');');
      Write_ln(FProcLink,'Begin');
      {Write_ln(fProcLink,'Dm1.tt1.Edit;');}
      Write_ln(fProcLink,'If Tab0 then Dm1.tt0.fields['+ss+'].'+funzconv+':=Par');
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

//if (not vuoto)or archivio then
  begin
  Write_ln(Fconferma,'  end;');
  Write_ln(FForm,'  end;');
  end;

Write_ln(Ftype,'       End;');
if datastru='array' then
  begin
  if doppioP then
  Write_ln(Ftype,'Ar_'+Nomerec+'=array[1..'+maxarray+']of ^'+nomerec+';')
  else
  Write_ln(Ftype,'Ar_'+Nomerec+'=array[1..'+maxarray+']of '+nomerec+';');
  if notslave then
    begin
    Write_ln(Ftype,'Var '+varname+':^Ar_'+nomerec+';')
    end;
  end
else Write_ln(Ftype,'Var '+varname+':^'+nomerec+';');

if not(slave) then
  begin
  Write_ln(fnewpun,'New('+Varname+');');
  Write_ln(fDispPun,'Dispose('+Varname+');');
  end;

write_ln(fout,'  CreateTable;');
if cbNobde.checked then
write_ln(fout,'  Close;');
{Write_ln(Fout,'  Open;');
Write_ln(Fout,'  Refresh;');}
write_ln(fout,'  End;');
write_ln(fout,'End;');

Write_ln(fDatain,'    end;');
if datastru='array' then
  begin
  Write_ln(fDatain,'  Tabella1.Next;');
  Write_ln(fDatain,'  end;');
  if notslave then Write_ln(fDatain,NumArray+':=i;');
  end;
if master then
  begin
  Write_ln(fDatain,'Tabella3.Masterfields:='''';');
  Write_ln(fDatain,'Tabella3.IndexName:='''';');
  end;

Write_ln(fDatain,'end;');

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
  Write_ln(fSave,'Tabella3.Masterfields:='''';');
  Write_ln(fSave,'Tabella3.IndexName:='''';');
  end;

Write_ln(fSave,'end;');



Write_ln(fOpen,'    Tabella1.POst;');
if master then
Write_ln(fOpen,'    OpenTxt_'+nometabSlave+'(Tabella3);');
if datastru='array' then Write_ln(fOpen,'  end;')
else Write_ln(fOpen,'ReadValoreCampo;');
Write_ln(fOpen,'end;');


Write_ln(fDataout,'    Tabella1.POst;');

if master then
Write_ln(fDataout,'    Salva_'+nometabSlave+'(Tabella3,'+CampoSlave+','+NumarraySlave+');');
if doppioP then Write_ln(fDataout,'    Dispose('+varname+'^[i]);');

Write_ln(fDataOut,'    end;');
if datastru='array' then Write_ln(fDataOut,'  end;');
if notslave then
  begin
  //Write_ln(fDataout,'Tabella1.refresh;');
  end;
if master then
  begin
  Write_ln(fDataout,'Tabella3.Masterfields:='''';');
  Write_ln(fDataout,'Tabella3.IndexName:='''';');
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
if paramcount>0 then
  begin
  ss:=paramstr(1);
  chdir(ss);
  end
else chdir('d:\bmsistemi\dev\term\carichi\database');
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
  tipotab:='TTableQ' ;
  usesdb:='DbTablesQ';
  end
else
  begin
  tipotab:='TTable';
  usesdb:='DbTables';
  end;
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

Fassignfile(fCreadb,'Creadb.pas');
Frewrite(fCreadb);
FWriteln(FCreadb,'Procedure Creadatabase(nome:string);');
FWriteln(FCreadb,'Begin');


Fassignfile(fCompila,'CompilaLista.pas');
Frewrite(fCompila);
FWriteln(Fcompila,'Procedure CompilaLista;');
FWriteln(Fcompila,'Begin');

Fassignfile(fnewPun,'NewPun.pas');
Frewrite(fNewPun);
FWriteln(FNewPun,'Procedure InitPuntatori;');
FWriteln(FNewPun,'Begin');
Fassignfile(fDispPun,'DispPun.pas');
Frewrite(fDispPun);
FWriteln(FDispPun,'Procedure DisposePuntatori;');
FWriteln(FDispPun,'Begin');

Fassignfile(fout,{c:\ded\sorgenti\genera\}'mappadb.pas');
Frewrite(fout);

Fassignfile(fDataLink,{c:\ded\sorgenti\genera\}'UDataLink.pas');
Frewrite(fDataLink);
FWriteln(Fdatalink,'Unit UDataLink;');
FWriteln(Fdatalink,'Interface');
FWriteln(Fdatalink,'Uses Udb ;');

Fassignfile(fIoDati,'ULeggiscriviDati.pas');
Frewrite(fIoDati);
FWriteln(fIoDati,'Unit ULeggiscrividati;');
FWriteln(fIoDati,'Interface');
FWriteln(fIoDati,'Uses Varcarichi,udb,'+UsesDb+',Sysutils,math;');

Fassignfile(fLtutti,'Leggitutti.pas');
Frewrite(fLtutti);
FWriteln(FLtutti,'Procedure Leggidati;');
FWriteln(FLtutti,'Begin');
Fassignfile(fstutti,'scrivitutti.pas');
Frewrite(fstutti);
FWriteln(FStutti,'Procedure Scrividati;');
FWriteln(FStutti,'Begin');

Fassignfile(fini,'init.pas');
Frewrite(fini);
Fwriteln(Fini,'Procedure initDb(Nome:String);');
Fwriteln(Fini,'Begin');
Fwriteln(Fini,'Nome:=Upstring(nome);');

Fassignfile(finimem,'initMem.pas');
Frewrite(finimem);
Fwriteln(Finimem,'Procedure initMem(Nome:String;ind,ind2:integer);');
Fwriteln(Finimem,'Begin');
Fwriteln(Finimem,'Nome:=Upstring(nome);');


Fassignfile(fNuovo,'Nuovo.pas');
Frewrite(fNuovo);
Fwriteln(FNuovo,'Procedure NuovoDb;');
Fwriteln(FNuovo,'Begin');

Fassignfile(fForm,'CompilaForm.pas');
Frewrite(fForm);

Fassignfile(fOpen,'Openfile.pas');
Frewrite(fOpen);

Fassignfile(fSave,'Savefile.pas');
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
Fassignfile(ftype,{c:\ded\sorgenti\genera\}'Typedef.pas');
Frewrite(ftype);

Fassignfile(fReport,'ReportFisso.pas');
Frewrite(fReport);

Fassignfile(fCaseTab,'CaseTabella.pas');
Frewrite(fCaseTab);

Fassignfile(fCampoDb,'CampoDb.pas');
Frewrite(fCampoDb);

riga:='  ';
while ((riga[2]<>'*')or (length(riga)<2))and (not eof(basedati)) do Leggidati;

Fclosefile(Fcontrolla);
Fclosefile(Fconferma);
Fclosefile(FForm);
Fclosefile(FReport);
Fclosefile(FCaseTab);
Fclosefile(FCampoDb);
Fclosefile(Fout);
Fclosefile(Ftype);
Fclosefile(FDataIn);
Fclosefile(FDataOut);

FWriteln(Fdatalink,'Implementation');
FWriteln(Fdatalink,'{$I DataLink.pas}');
FWriteln(Fdatalink,'End.');

FWriteln(FIodati,'Procedure Scrividati;');
FWriteln(FIodati,'Procedure Leggidati;');
FWriteln(FIodati,'Implementation');
FWriteln(FIodati,'Function F_real(Num:real;Cifredec:integer):real;');
FWriteln(FIodati,'Var i:integer;');
FWriteln(FIodati,'Begin');
//FWriteln(FIodati,'For i:=1 to cifredec do Num:=num*10;');
//FWriteln(FIodati,'Num:=round(num);');
//FWriteln(FIodati,'For i:=1 to cifredec do Num:=num/10;');
//FWriteln(FIodati,'result:=num;');
FWriteln(FIodati,'result:=RoundTo(num,-cifredec);');
FWriteln(FIodati,'end;');
FWriteln(FIodati,'{$I Datain.pas}');
FWriteln(FIodati,'{$I DataOut.pas}');
FWriteln(FIodati,'{$I Leggitutti.pas}');
FWriteln(FIodati,'{$I Scrivitutti.pas}');
FWriteln(FIodati,'End.');


Fclosefile(FIodati);

Fclosefile(FOpen);

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

Fclosefile(FCombo);

closefile(basedati);
assignfile(Fdata,'data.pas');
rewrite(fdata);
writeln(fdata,'Datacor:='''+DateToStr(Date)+''';');
closefile(fdata);
end;

Procedure Leggiriga;
begin
readln(basedati,riga);
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
