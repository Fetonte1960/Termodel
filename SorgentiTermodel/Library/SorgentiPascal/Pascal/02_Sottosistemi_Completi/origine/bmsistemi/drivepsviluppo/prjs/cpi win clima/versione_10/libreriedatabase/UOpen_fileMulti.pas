unit UOpen_fileMulti;

interface
uses SysUtils, UDBT, DBtables, Dialogs, DbtablesQ,gestudb,funzudbT,db,progress3d;
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
  result:=copy(Buf_txt,POs_val,length(Buf_txt)-Pos_val+1);
  if result='NAN' then result:='0';
end;

Function ReadValorecampo:string;
begin
Readln(txtOut,Buf_txt);
result:=buf_txt;
end;

Procedure Leggi_Campo;
Var i:integer;
    temp:string;
    trovato:boolean;
begin
  //cerca di risolvere i casi in cui si crea una stringa con chr(13)
  repeat
  trovato:=true;
  readln(txtout,Buf_txt);
  if (Buf_txt <> '#FINECAMPI#') and (Buf_Txt <> '') then
  begin
   i:=1;
   if pos(':',Buf_txt)<>0 then
     begin
     while Buf_txt[i]<>':' do inc(i);
     POs_val:=i+1;
     temp:=copy(Buf_Txt,1,i-1);
     end
   else
     begin
     trovato:=false;
     //showmessage('Archivio:'+nometabella+',linea irregolare:'+Buf_txt);
     temp:='';
     end;
   if temp <> '' then
     begin
     try
     Campocor:=strtoint(temp);
       except
       trovato:=false;
       end
     end
   else trovato:=false;
  end;
  until (trovato)or(eof(txtout));
end;
{$I CampoDB}
{$I Openfile}

Var ultbuf:string;
begin
if fileexists(nome) then
  begin
  //progress_3d(1,'Inizializzazione database');
  CloseUdbT;
  NuovoUdbT;
  //progress_3d(1,'Lettura file di progetto');
  assignfile(txtout,nome);
  reset(txtout);
  readln(txtout,Versione);
  readln(txtout,Buf_txt);
  ultbuf:='';
  while not eof(txtout) do
    begin
    if ultbuf=Buf_txt then //L'Archivio è stato eliminato nella nuova versione
      begin
      Buf_txt:='';
      while (not eof(txtOut))and(pos('------',Buf_txt)=0) do readln(txtout,Buf_txt);
      end;
    ultbuf:=Buf_txt;
    NomeTabella:=Uppercase(copy(Buf_txt,41,length(Buf_txt)-40));
    with dmtutti do
      begin
      //progress_3d(1,'Lettura '+copy(Buf_txt,41,length(Buf_txt)-40));
      {$I CaseTabellaT}
      end;
    end;
  //progress_3d(1,'Chiusura database');
  CloseUdbT;
  OpenUdbT;
  closefile(txtout);
  end
else showmessage(nome+' non trovato');
end;

end.
