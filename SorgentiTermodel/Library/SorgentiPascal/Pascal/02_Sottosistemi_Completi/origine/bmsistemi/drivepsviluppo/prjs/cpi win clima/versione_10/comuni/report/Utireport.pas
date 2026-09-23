Unit Utireport;

Interface

Uses
  Windows, SysUtils, Dialogs, LibreriaGenerale, Math, Classes;

  Procedure InitFileReport(Nomecompleto: string);
  Procedure CloseFileReport;
  Procedure W_Reale(sigla:string; Valore: real; Cifredec:integer);
  Procedure Wrep_int(sigla: string; Valore: integer);
  Procedure Wrep_str(sigla, valore:string);
  Procedure Writeln_Frep(testo: string);
  Procedure IniZio_compart(nome: string);
  Procedure Fine_Gruppo;
  Procedure Fine_compart;
  Function  Eliminaduepunti(ss: string):string;
  Function  FormInd(ind: integer):String;
  Function  togliduepunti(ss: string):string;
  Procedure W_MesiL10_real(corrente:integer; Sigla:string; Valore:real; cifredec, IndiceMese, MesiRisc_st:Integer);
  Procedure W_Mesi12L10_real(corrente:integer; Sigla:string; Valore:real; cifredec:Integer);
  Procedure Iniziotabella(Nometab:string; Colonne:integer);
  Procedure WRealeTab(Valore:double; Cifredec:integer);
  Procedure WStrTab(Valore:string);
  Procedure WIntTab(Valore:integer);
  Procedure FinerigaTabella;
  Procedure Finetabella;
  // Procedure create da Emanuela
  procedure Sezione(Nome, Valore: String);
  procedure Init_Modulo(Nome: String);
  procedure End_Modulo;
  procedure FG_Modulo;
  Procedure AggFileReport(Nomecompleto:string);
  function UnisciRep(nome1,nome2,nomedest,nomefiltro,filtro:string): Boolean;

Var
      Frep: TextFile;
      RigheTabReport: integer;
      ColonneTabReport: integer;
      NomeTabReport:string;
      LRep, LTempReport: TStringList;

implementation

Procedure InitFileReport(Nomecompleto:string);
begin
  LRep := TStringList.Create;
  LRep.Add(NomeCompleto+'R');
end;

{-----------------------------------------------------------------------------
  Procedure: AggFileReport
  Author:    e.diquattro
  Date:      03-mag-2006
  Arguments: Nomecompleto:string
  Result:    None

  Cosa fa: aggiorna un file rep esistente
-----------------------------------------------------------------------------}
Procedure AggFileReport(Nomecompleto:string);
begin
  LRep := TStringList.Create;
  LRep.Add(NomeCompleto + 'A');
end;

Procedure CloseFileReport;
var
  i: Integer;
  Tipo, Valore: String;
begin
  Tipo := Copy(LRep[0], Length(LRep[0]), 1);
  Valore := Copy(LRep[0], 1, Length(LRep[0]) - 1);

  AssignFile(FRep, Valore);
  if Tipo = 'R' then
     Rewrite(FRep)
  else
    if FileExists(Valore) then
       Append(FRep)
    else Rewrite(FRep);
  for i := 1 to LRep.Count - 1 do
  begin
     Tipo := Copy(LRep[i], Length(LRep[i]), 1);
     Valore := Copy(LRep[i], 1, Length(LRep[i]) - 1);
     if Tipo = 'R' then
        writeln(frep,Valore)
     else write(frep,Valore);
  end;
  CloseFile(FRep);
  LRep.Clear;
  FreeAndNil(LRep);
end;

Procedure W_Reale(sigla:string; Valore:real; Cifredec:integer);
Var
 tt: string;
begin
  str(valore:1:Cifredec, tt);
  LRep.Add(sigla + ':' + tt +':'+'R') ;
end;

Procedure Wrep_str(sigla, valore: string);
begin
  LRep.Add(sigla+':'+togliduepunti(valore)+':'+'R') ;
end;

Procedure Wrep_int(sigla: string; valore: integer);
begin
  LRep.Add(sigla+':'+intToStr(valore)+':'+'R');
end;

procedure Writeln_Frep(testo: string);
begin
  LRep.Add(testo + 'R');
end;

Procedure IniZio_compart(nome: string);
begin
  LRep.Add('INIZIOCOMPARTIMENTO:' + nome + ':'+'R');
end;

Procedure Fine_Gruppo;
begin
  LRep.Add('FINEGRUPPO:'+'R');
end;

Procedure Fine_compart;
begin
  LRep.Add('FINECOMPARTIMENTO:'+'R');
end;

{-----------------------------------------------------------------------------
  Procedure: Sezione
  Author:    Emanuela
  Date:      02-dic-2004
  Arguments: Nome, Valore: String
  Result:    None

  Scrittura della sezione
-----------------------------------------------------------------------------}
procedure Sezione(Nome, Valore: String);
begin
 LRep.Add('SEZIONE:'+ Nome +':'+'R');
 LRep.Add(Nome +':'+ Valore +':'+'R');
end;

{-----------------------------------------------------------------------------
  Procedure: Init_Modulo
  Author:    e.diquattro
  Date:      14-nov-2005
  Arguments: Nome: String
  Result:    None

  Cosa fa: indica dove deve iniziare un modulo
-----------------------------------------------------------------------------}
procedure Init_Modulo(Nome: String);
begin
  LRep.Add('IMODULO:'+ Nome +':'+'R');
end;

{-----------------------------------------------------------------------------
  Procedure: End_Modulo
  Author:    e.diquattro
  Date:      14-nov-2005
  Arguments: Nome: String
  Result:    None

  Cosa fa: indica dove termina il modulo
-----------------------------------------------------------------------------}
procedure End_Modulo;
begin
  LRep.Add('FMODULO:'+'R');
end;

{-----------------------------------------------------------------------------
  Procedure: FG_Modulo
  Author:    e.diquattro
  Date:      14-nov-2005
  Arguments: Nome: String
  Result:    None

  Cosa fa: indica dove finisce un gruppo del modulo
-----------------------------------------------------------------------------}
procedure FG_Modulo;
begin
  LRep.Add('IGMODULO:'+'R');
end;

Procedure W_MesiL10_real(corrente: integer; Sigla: string; Valore: real; cifredec, IndiceMese, MesiRisc_st: Integer);
Var
  tt, Indice: string;
Begin
{$Ifdef Estivo}
{$Else}
  Str(roundr(cifredec,valore):1:cifredec,tt);
  Case IndiceMese of
    10: Indice := '01';
    11: Indice := '02';
    12: Indice := '03';
    1 : Indice := '04';
    2 : Indice := '05';
    3 : Indice := '06';
    4 : Indice := '07';
  end;

  if corrente = mesirisc_st then LRep.Add(sigla + Indice + ':' + tt + ':' + 'R')
  else LRep.Add(sigla + Indice + ':' + tt + ':' + 'L');
{$Endif}
end;

Procedure W_Mesi12L10_real(corrente: integer; Sigla: string; Valore: real; cifredec: Integer);
Var
  tt: string;
begin
  {$Ifdef Estivo}
  {$Else}
    Str(roundr(cifredec,valore):1:cifredec,tt);
    if corrente=12 then LRep.Add(sigla+formInd(corrente)+ ':' + tt + ':' +'R')
    else LRep.Add(sigla + formInd(corrente) + ':' + tt + ':' + 'L');
  {$Endif}
end;

// funzioni che scrivono le tabelle
Procedure Iniziotabella(Nometab:string;Colonne:integer);
begin
  LTempReport := TStringList.Create;
  RigheTabReport:=0;
  ColonneTabReport := colonne;
  NomeTabReport := Nometab;
end;

Procedure WRealeTab(Valore:Double; Cifredec:integer);
Var
  tt:string;
begin
  if SameValue(valore, 0) then LTempReport.Add('0'+':'+'L')
  else
  begin
    str(valore:1:Cifredec,tt);
    LTempReport.Add(tt+':'+'L');
  end;
end;

Procedure WIntTab(Valore:integer);
Var
  tt:string;
begin
  if SameValue(valore, 0) then LTempReport.Add('0'+':'+'L')
  else
  begin
    tt:=inttostr(valore);
    LTempReport.Add(tt+':'+'L');
  end;
end;

Procedure WStrTab(Valore:string);
begin
  LTempReport.Add(togliduepunti(Valore)+':'+'L');
end;

Procedure FinerigaTabella;
begin
  LTempReport.Add(''+'R');
  inc(RigheTabReport);
end;

Procedure Finetabella;
Var
  Buf:string;
  i: Integer;
begin
  LRep.Add('INIZIOTABELLA:' + NomeTabReport + ':' + inttostr(ColonneTabReport) + ':'+ inttostr(RigheTabReport) + ':' + 'R');
  for i := 0 to LTempReport.Count - 1 do
    LRep.Add(LTempReport[i]);
  LRep.Add('FINETABELLA:' + 'R');
end;

Function FormInd(ind: integer): String;
begin
  str(ind:1, result);
  if ind < 10 then result := '0' + result;
end;

Function togliduepunti(ss: string): string;
Var
  i:integer;
begin
  for i := 1 to Length(ss) do
  if ss[i] = ':' then ss[i]:='§';
  result:=ss;
end;

Function Eliminaduepunti(ss: string): string;
Var
  i:integer;
begin
  for i := 1 to length(ss) do
  if ss[i] = ':' then ss := Copy(ss, 1, i-1);
  result:=ss;
end;

function UnisciRep(nome1,nome2,nomedest,nomefiltro,filtro:string): Boolean;
Var Buf:string;
    f1,f2:textfile;
begin
 Result := True;
 if FileExists(nome1) and FileExists(nome2) then
 begin
  assignFile(f1,Nome1);
  try
    reset(f1);
    assignFile(f2,Nomedest);
    try
      rewrite(f2);
      while not eof(f1) do
      begin
        readln(f1,buf);
        writeln(f2,buf);
      end;
      close(f1);
      assignFile(f1,Nome2);
      reset(f1);
      while not eof(f1) do
      begin
        readln(f1,buf);
        writeln(f2,buf);
      end;
      CloseFile(f2);
    except
      CloseFile(f2);
    end;
    CloseFile(f1);
  except
    CloseFile(f1);
  end;
 end
 else
 begin
   MessageDlg('La relazione non può essere generata, controllare di aver effettuato il calcolo per il generatore impostato', mtInformation, [mbOK], 0);
   Result := False;
 end;
end;


end.


