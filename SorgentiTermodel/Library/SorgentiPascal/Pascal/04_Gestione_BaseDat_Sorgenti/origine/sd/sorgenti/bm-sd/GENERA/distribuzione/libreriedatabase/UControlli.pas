unit UControlli;

interface
Uses Udatalink,classes,UmessaggiDB, sysutils;
Function Visualizzamessaggio(messaggi:Tstringlist):boolean;
Function Controllodb(Tabelle,Campi:string):Tstringlist;

implementation
uses libreriagenerale;

Function Visualizzamessaggio(messaggi:Tstringlist):boolean;
Var i:integer;
begin
result:=False;
FMessaggiDB:=TFMessaggiDB.Create(nil);
FMessaggiDB.Memo1.Clear;
if messaggi.Count >0 then
  begin
  Result:=True;
  for i:=1 to messaggi.Count do
  FMessaggiDB.Memo1.Lines.add(messaggi.strings[i-1]);
  FMessaggiDB.showmodal;
  end;
end;

Function Controllodb(Tabelle,Campi:string):Tstringlist;

Procedure Aggiungimessaggio(Messaggio:string);
begin
result.Add(Messaggio);
end;

Function Dacontrollare(Tabella:string;Campo:Integer):Boolean;
begin
if tabelle='' then result:=true
else
   Result := contenuta(tabelle, tabella) and contenuta(Campi, IntToStr(Campo))
end;
Procedure Faicontrolli;
begin
{$I Controlli}
end;
Begin
result:=Tstringlist.create;
result.Clear;
faicontrolli;
end;
end.
