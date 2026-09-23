unit GestioneLettura;

interface
uses udb,UDatalink,UVariabililettura,sysutils,libreriagenerale,windows, ShellApi,
      Letturadisegnobidimensionale ,leggidxf,Ucaricatabelle,letturadisegno;

Procedure LeggidiSegno(piano:string;elimina:boolean);

implementation
Uses Ulettura,ULeggiscrividati,varcarichi;
var
   FileErrori : TextFile;
   errorelettura:boolean;

Procedure LeggiUndisegno(piano:string;elimina:boolean);
Var break:boolean;

begin
erroreX:=0;
erroreY:=0;
break:=false;
CaricaInput(piano,break);
if break then exit;
flettura.Memo1.Clear;
Letturadisegnobidimensionale.LeggiDXF(piano,elimina); // elaborazione del grafo
flettura.Memo1.Lines.Add(erroreneldisegno);
// modifica del 05/05/2004 eseguo il controllo sulla stringa errore nel disegno per evitare di scrivere
// nel file un'informazione non corretta

if (Piano = '')  then
   begin
        Writeln(FileErrori, pianocor);
        if (erroreneldisegno <> Letturacorretta) then
           begin
                ErroreLettura := True;
//                Writeln(FileErrori, Format('Anomalie alle coordinate (%.2f, %.2f)', [ErroreX, ErroreY]));
           end;

        Writeln(FileErrori, Erroreneldisegno);
        CaricaTabelle;
   end;
errore_lettura:=(erroreneldisegno <> Letturacorretta);
end;

Procedure LeggidiSegno(piano:string;elimina:boolean);
Var Esci : boolean;
    Pp:string;
    PathProg:string;
    AperturaFinestra : Boolean;
    i:integer;
begin
if (piano='') then
  begin
  Leggi_Locali(dm1.tt1,dm1.tt3);
  Leggi_Zone(dm1.tt1,dm1.tt3);
  Leggi_strutture(dm1.tt1,dm1.tt3);
  Leggi_Confine(dm1.tt1,dm1.tt3);
  Leggi_finestre(dm1.tt1,dm1.tt3);
  Leggi_impianti(dm1.tt1,dm1.tt3);
  Leggi_Piani(dm1.tt1,dm1.tt3);
  for i:=1 to NAmbienti do ambienti_d^[i]^.V:='';
  end;

     AperturaFinestra := Piano = '';

//caricaspessore;
(*
if (piano='') then
with dm1.TT3 do
  begin
  Mastersource:=nil;
  first;
  while not eof do
    begin
    {if V_recPar.item<>0 then }delete
    {else next};
    end;
  Mastersource:=dm1.Datasource1;
  end;
*)

if (piano='')and(elimina) then
  begin
  dm1.tt1.close;
  dm1.tt1.tablename:='Locali';
  dm1.tt1.open;

  with dm1.TT1 do
    begin
    first;
    while not eof do
      begin
      edit;
      V_recAmb.Set_V('');
      POst;
      next;
      end;
    end;
  end;

//pathprog:=drivprg+'\disegno.txt';
pathprog := IncludeTrailingPathDelimiter(PercorsoDrive) + 'disegno.txt';
(*
if fileexists(PercorsoDrive+'\disegno.dxf') then
  begin
  copyfile(pchar(PercorsoDrive+'\disegno.dxf'),pchar(PercorsoDrive+'\copiadisegno.dxf'),false);
  Read_dxf(PercorsoDrive+'\copiadisegno.dxf',pathprog,false);
  end;
*)
//if fileexists('c:\windows\system32\disegno.dxf') then
//Read_dxf('c:\windows\system32\disegno.dxf',pathprog,false);


//if not fileexists(pathprog) then
pathprog := IncludeTrailingPathDelimiter(PercorsoDrive) + 'disegno.txt';

if Piano = '' then
begin
AssignFile(FileErrori, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_Errori_Disegno);
ErroreLettura := False;
try
  Rewrite(FileErrori);
except
  CloseFile(FileErrori);
end;
end;

AssignFile(fdis,pathprog);
try
  Reset(fdis);
  if piano<>'' then
    begin
    repeat Readln(fdis,Bufdis);
    AzzeraIdentif;
    pp:=Uppercase(leggiidentif1(Bufdis));
    until (pp='PIANO')and(Upstring(leggiidentif1(Bufdis))=piano);
    Leggiundisegno(piano,Esci);
    end
  else
    begin
    DirezNord:=0;
    while not eof(fdis) do
      begin
      Leggiundisegno('',Esci);
      pianocor:=Flettura.ComboBox1.Text;
      end;
    end;
  close(fDis);
except
  close(fDis);
end;

// 05/05/2004


     if AperturaFinestra then
     begin
          // imposto per default il primo piano
          if not ErroreLettura then Writeln(FileErrori, Str_Tutto_OK);

          Close(FileErrori);
          FLettura.ComboBox1.ItemIndex := 0;
          pianocor:=Flettura.ComboBox1.Text;
          FLettura.ComboBox1Change(Nil);
     end;

//close(FFig);
if (piano='') then
  begin
  Salva_Piani(dm1.tt1,dm1.tt3,dm1.datasource1);
  Salva_Locali(dm1.tt1,dm1.tt3,dm1.datasource1);
  //Dm1.DataSource1.DataSet:=dm1.tt1;
  //Dm1.DataSource3.DataSet:=dm1.tt3;
  dm1.tt1.close;
  dm1.tt3.close;
  dm1.tt1.tablename:='Locali';
  dm1.tt3.tablename:='Pareti';
  dm1.tt1.open;
  initassociata;
  end;
dm1.TT1.Open;
dm1.TT3.Open;

if (piano='')and(elimina) then
  begin
  with dm1.TT1 do
    begin
    first;
    while not eof do
      begin
      If V_recAmb.V='' then
      CancellarigadbMasterSlave(dm1.TT1,dm1.TT3)
      else next;
      end;
    end;
  end;


end;
end.
