unit UFileLog;

interface
Uses
  Windows, SysUtils, Dialogs, Classes;

const CALCOLI_B_F = 'CALC_B_F';

  Procedure InitFileLog(Nomecompleto:string);
  Procedure CloseFileLog;
  Procedure ScriviLog(valore: string);
  Function  ErroreG(NomeFile, NomeGen: String): String;
  Procedure CaricaContenutoFile(NomeFile, NomeGen: String);

Var
   LLog: TStringList;
   FLog: TextFile;

implementation

Procedure InitFileLog(Nomecompleto:string);
begin
  LLog := TStringList.Create;
  LLog.Add(NomeCompleto);
end;

Procedure CloseFileLog;
var
  i: Integer;
  Valore: String;
begin
  Valore := Copy(LLog[0], 1, Length(LLog[0]));
  AssignFile(FLog, Valore);
  Rewrite(FLog);
  for i := 1 to LLog.Count - 1 do
  begin
     Valore := Copy(LLog[i], 1, Length(LLog[i]));
     Writeln(FLog,Valore)
  end;
  CloseFile(FLog);
  LLog.Clear;
  FreeAndNil(LLog);
end;

Procedure ScriviLog(valore: string);
begin
  LLog.Add(Valore) ;
end;

Function ErroreG(NomeFile, NomeGen: String): String;
var
  FD: TFileStream;
  F: File of byte;
  Size: Integer;
  ParDoc, Doc: String;
  i, j: Integer;
begin
 if FileExists(NomeFile) then
 begin
  AssignFile(F,nomefile);
  FileMode := fmOpenRead;
  try
     Reset(F);
     Size := FileSize(F);
     CloseFile(F);
  except
     CloseFile(F);
  end;
  FD := TFileStream.Create(NomeFile, fmOpenRead or fmShareDenyWrite);
  SetLength(Doc,  Size);
  FD.Read(Doc[1], Size);
  FD.Free;
  i := Pos('IN:' + NOMEGEN, Doc);
  j := Pos('FN:' + NOMEGEN, Doc);
  i := i + Length('IN:' + NOMEGEN) + 2;
  ParDoc := Copy(Doc, i, j-i - 2);
  if Pos(CALCOLI_B_F, ParDoc) = 0 then
     Result := ParDoc
  else Result := '';
 end; 
end;

Procedure CaricaContenutoFile(NomeFile, NomeGen: String);
var
  Frase: String;
  i, j: Integer;
begin
  InitFileLog(NomeFile);
  AssignFile(FLog, NomeFile);
  Reset(Flog);
  while not Eof(FLog) do
  begin
    ReadLn(FLog, Frase);
    if CompareStr(Frase, ('IN:' + NOMEGEN)) <> 0 then
       ScriviLog(Frase)
    else
    begin
     while (CompareStr(Frase, ('FN:' + NOMEGEN)) <> 0) and (not Eof(FLog)) do ReadLn(FLog, Frase);
    end;
  end;
  CloseFile(FLog);
end;

end.
