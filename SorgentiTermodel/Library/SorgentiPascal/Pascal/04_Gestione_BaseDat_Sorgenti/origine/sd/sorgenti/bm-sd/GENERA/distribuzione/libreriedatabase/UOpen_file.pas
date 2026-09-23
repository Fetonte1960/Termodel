unit UOpen_file;

interface
uses SysUtils, UDB, DBtables, Dialogs, DbtablesQ,db;
Procedure ApriTXT;
//Var TxtOut:TextFile;
implementation
Var Indmaster:integer;

Procedure ApriTXT;
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
readln(txtout,Versione);
readln(txtout,Buf_txt);
while not eof(txtout) do
  begin
  NomeTabella:=Uppercase(copy(Buf_txt,41,length(Buf_txt)-40));
  {$I CaseTabella}
  end;
end;

end.
