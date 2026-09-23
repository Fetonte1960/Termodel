unit UOpen_fileMulti;

interface
uses SysUtils, UDBT, DBtables, Dialogs, DbtablesQ,gestudb,funzudbT,db;
Procedure ApriTxtUDBT(dati,nome:string);
Function filecorretto(nome:string):string;
Function filesalvatocorretto(nome:string):string;
//Var TxtOut:TextFile;
implementation
Var Indmaster:integer;

Function filesalvatocorretto(nome:string):string;
Var ff:textfile;
    buf:string;
begin
result:='';
assign(ff,nome);
reset(ff);
while not eof(ff) do readln(ff,buf);
close(ff);
if buf<>'#ENDFILE#' then result:='Il file non è stato salvato correttamente ! Si consiglia di chiudere e riavviare il programma.';
end;

Function filecorretto(nome:string):string;
Var ff:textfile;
    buf:string;
begin
result:='';
if not fileexists(nome)  then
  begin
  result:='Il file '+nome+' non esiste !';
  exit;
  end;
assign(ff,nome);
reset(ff);
while not eof(ff) do readln(ff,buf);
close(ff);
if buf<>'#ENDFILE#' then result:='Il file non è leggibile !';
end;

Procedure ApriTxtUDBT(dati,nome:string);
Var Versione,Buf_Txt,Nometabella:string;
    CampoCor,Pos_val:integer;

Function Valorecampo:string;
begin
  result:=copy(Buf_txt,POs_val,length(Buf_txt)-Pos_val+1)
end;

Function ReadValorecampo:string;
begin
Readln(txtOut,Buf_txt);
result:=buf_txt;
end;

Procedure Leggi_Campo;
Var i:integer;
    temp:string;
begin
  readln(txtout,Buf_txt);
  if (Buf_txt <> '#FINECAMPI#') and (Buf_Txt <> '') then
  begin
   i:=1;
   while Buf_txt[i]<>':' do inc(i);
   POs_val:=i+1;
   temp:=copy(Buf_Txt,1,i-1);
   if temp <> '' then
      Campocor:=strtoint(temp);
  end;
end;
{$I CampoDB}
{$I Openfile}


begin
if fileexists(nome) then
  begin
  CloseUdbT;
  NuovoUdbT;
  assignfile(txtout,nome);
  reset(txtout);
  readln(txtout,Versione);
  readln(txtout,Buf_txt);
  while not eof(txtout) do
    begin
    NomeTabella:=Uppercase(copy(Buf_txt,41,length(Buf_txt)-40));
    with dmtutti do
      begin
      {$I CaseTabellaT}
      end;
    end;
  CloseUdbT;
  OpenUdbT;
  closefile(txtout);
  end
else showmessage(nome+' non trovato');
end;

end.
