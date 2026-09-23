unit UtilityGestioneTutor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ShellApi;

  procedure EstraiSezione(PathFileTutor, NomeSezione, PathFileGenerato: String);
  procedure Sezione(FileEs, NomeSezione: String; var Modello: String);
  procedure FileinInput(nomefile: String);
  procedure FileinOutput(nomefile: String);
  function  InizioFileRTF: String;
  function  FineFileRTF: String;
  function  SezioneDaCaricare(NomeModelloRTF, NomeSezione, NomeFileGenerato: String): String;

var
  Doc, Sez, VarSez: String;

implementation

procedure EstraiSezione(PathFileTutor, NomeSezione, PathFileGenerato: String);
begin
  Sez := '';
  FileinInput(PathFileGenerato);
  Sezione(PathFileTutor, NomeSezione, Sez);
  // Modifica del 07/04/2004
  // se non trovo la sezione specificata all'interno del documento
  // visualizzo nel wizard che non ho trovato quella sezione
  if Sez = '' then
     Doc := 'Attenzione non è stata trovata  nel documento ' + #10 + PathFileTutor + #10 + ' la sezione ' + #10 + NomeSezione
  else
     Doc := InizioFileRTF + Sez + FineFileRTF;

  FileinOutput(PathFileGenerato);
end;

// Procedura che apre il file in input da modificare
procedure FileinInput(nomefile: String);
var
  FD: TFileStream;
  F: File of byte;
  Size: Integer;
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
 FD := TFileStream.Create(nomefile,fmOpenRead or fmShareDenyWrite);
 SetLength(Doc,size);
 // modificato FD.Read(Doc[1],size);
 if size<>0 then FD.Read(Doc[1],size); //diego mi da erore non so perche ?
 FD.Free;
end;

// Procedura che restituisce il file modificato
procedure FileinOutput(nomefile: String);
var
 i: Integer;
 NewFile: TFileStream;
begin
 NewFile := TFileStream.Create(nomefile,fmCreate);
 i:= Length(Doc);
 NewFile.Write(Doc[1],i);
 NewFile.Free;
end;

{-----------------------------------------------------------------------------
  Procedure: TUtilityGestioneTutor.Sezione
  Author:    Emanuela
  Date:      29-mar-2004
  Arguments: NomeSezione: String; var Modello: String
  Result:    None

  Funzione che estrae una sezione da un file
-----------------------------------------------------------------------------}

procedure Sezione(FileEs, NomeSezione: String; var Modello: String);
var
 i, j, cont: Integer;
 FDoc: String;
 FD: TFileStream;
 F: File of byte;
 Size: Integer;
begin
 AssignFile(F, FileEs);
 FileMode := fmOpenRead;
 try
   Reset(F);
   Size := FileSize(F);
   CloseFile(F);
 except
   CloseFile(F);
 end;
 FD := TFileStream.Create(FileEs, fmOpenRead or fmShareDenyWrite);
 SetLength(FDoc, size);
 FD.Read(FDoc[1], size);
 FD.Free;
 i:= Pos('<START_' + UpperCase(NomeSezione) + '>', FDoc);
 cont:=Length('<START_' + UpperCase(NomeSezione) + '>');
 j:= Pos('<END_' + UpperCase(NomeSezione) + '>', FDoc);
 Modello := Copy(FDoc, i+cont,j - (i+cont));
end;

function SezioneDaCaricare(NomeModelloRTF, NomeSezione, NomeFileGenerato: String): String;
Var
   F : TextFile;
begin
  if not FileExists(NomeModelloRTF) then
  begin
    AssignFile(F, NomeFileGenerato);
    try
      Rewrite(F);
      Writeln(F, 'Attenzione non è stata trovato il file del tutor');
      Writeln(F, NomeModelloRTF);
      CloseFile(F);
    except
      CloseFile(F);
    end;
    Result := NomeFileGenerato;
  end
  else
  begin
    EstraiSezione(NomeModelloRtf, NomeSezione, NomeFileGenerato);
    Result := NomeFileGenerato;
  end;
end;

function InizioFileRTF: String;
var
  Str: String;
begin
  Str := '';
  Str := Str + '{\rtf1\ansi\ansicpg1252\uc1\deff0\stshfdbch0\stshfloch0\stshfhich0\stshfbi0\';
  Str := Str + 'deflang1040\deflangfe1040{\fonttbl{\f0\froman\fcharset0\fprq2';
  Str := Str + '{\*\panose 02020603050405020304}Times New Roman;}{\f1\fswiss\fcharset0\fprq2';
  Str := Str + '{\*\panose 020b0604020202020204}Arial;}';
  Str := Str + '{\f2\fmodern\fcharset0\fprq1{\*\panose 02070309020205020404}Courier New;}';
  Str := Str + '{\f3\froman\fcharset2\fprq2{\*\panose 05050102010706020507}Symbol;}';
  Str := Str + '{\f10\fnil\fcharset2\fprq2{\*\panose 05000000000000000000}Wingdings;}';
  Str := Str + '{\f36\fscript\fcharset0\fprq2{\*\panose 00000000000000000000}Brush Script MT;}';
  Str := Str + '{\f37\froman\fcharset238\fprq2 Times New Roman CE;}';
  Str := Str + '{\f38\froman\fcharset204\fprq2 Times New Roman Cyr;}';
  Str := Str + '{\f40\froman\fcharset161\fprq2 Times New Roman Greek;}';
  Str := Str + '{\f41\froman\fcharset162\fprq2 Times New Roman Tur;}';
  Str := Str + '{\f42\froman\fcharset177\fprq2 Times New Roman (Hebrew);}';
  Str := Str + '{\f43\froman\fcharset178\fprq2 Times New Roman (Arabic);}';
  Str := Str + '{\f44\froman\fcharset186\fprq2 Times New Roman Baltic;}';
  Str := Str + '{\f45\froman\fcharset163\fprq2 Times New Roman (Vietnamese);}';
  Str := Str + '{\f47\fswiss\fcharset238\fprq2 Arial CE;}{\f48\fswiss\fcharset204\fprq2 Arial Cyr;}';
  Str := Str + '{\f50\fswiss\fcharset161\fprq2 Arial Greek;}{\f51\fswiss\fcharset162\fprq2 Arial Tur;}';
  Str := Str + '{\f52\fswiss\fcharset177\fprq2 Arial (Hebrew);}{\f53\fswiss\fcharset178\fprq2 Arial (Arabic);}';
  Str := Str + '{\f54\fswiss\fcharset186\fprq2 Arial Baltic;}{\f55\fswiss\fcharset163\fprq2 Arial (Vietnamese);}';
  Str := Str + '{\f57\fmodern\fcharset238\fprq1 Courier New CE;}';
  Str := Str + '{\f58\fmodern\fcharset204\fprq1 Courier New Cyr;}';
  Str := Str + '{\f60\fmodern\fcharset161\fprq1 Courier New Greek;}';
  Str := Str + '{\f61\fmodern\fcharset162\fprq1 Courier New Tur;}';
  Str := Str + '{\f62\fmodern\fcharset177\fprq1 Courier New (Hebrew);}';
  Str := Str + '{\f63\fmodern\fcharset178\fprq1 Courier New (Arabic);}';
  Str := Str + '{\f64\fmodern\fcharset186\fprq1 Courier New Baltic;}';
  Str := Str + '{\f65\fmodern\fcharset163\fprq1 Courier New (Vietnamese);}}';
  Str := Str + '{\colortbl;\red0\green0\blue0;\red0\green0\blue255;\red0\green255\blue255;';
  Str := Str + '\red0\green255\blue0;\red255\green0\blue255;\red255\green0\blue0;\red255\green255\blue0;';
  Str := Str + '\red255\green255\blue255;\red0\green0\blue128;\red0\green128\blue128;\red0\green128\blue0;';
  Str := Str + '\red128\green0\blue128;\red128\green0\blue0;\red128\green128\blue0;';
  Str := Str + '\red128\green128\blue128;\red192\green192\blue192;\red204\green204\blue204;';
  Str := Str + '\red51\green51\blue153;}';
  Str := Str + '{\stylesheet{\ql \li0\ri0\widctlpar\aspalpha\aspnum\faauto\adjustright\rin0\lin0\itap0 ';
  Str := Str + '\fs20\lang1040\langfe1040\cgrid\langnp1040\langfenp1040';
  Str := Str + '\snext0 \styrsid4526557 Normal;}{\s2\ql \li0\ri0\sb240\sa60\keepn\widctlpar\';
  Str := Str + 'aspalpha\aspnum\faauto\outlinelevel1\adjustright\rin0\lin0\itap0 \b\i\f1\fs28\';
  Str := Str + 'lang1040\langfe1040\cgrid\langnp1040\langfenp1040 \sbasedon0 \snext0 \styrsid5916836 heading 2;}';
  Str := Str + '{\s3\ql \li0\ri0\sb240\sa60\keepn\widctlpar\aspalpha\aspnum\faauto\outlinelevel2\adjustright\rin0\';
  Str := Str + 'lin0\itap0 \b\f1\fs26\lang1040\langfe1040\cgrid\langnp1040\langfenp1040 \sbasedon0 \snext0 \';
  Str := Str + 'styrsid5916836 heading 3;}';

  Result := Str;
end;

function FineFileRTF: String;
var
  St: String;
begin
  St := '\par }}';
  Result := St;
end;

end.
