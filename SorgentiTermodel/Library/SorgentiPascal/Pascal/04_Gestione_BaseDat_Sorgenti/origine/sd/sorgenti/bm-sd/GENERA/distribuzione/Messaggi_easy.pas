unit Messaggi_easy;

interface
Procedure Cancellamessaggi;
Procedure Messaggio(par:string);

implementation
Uses Maingestionegenera;
Procedure Cancellamessaggi;
begin
FGestioneGenera.Memo1.Clear;
end;
Procedure Messaggio(par:string);
begin
FGestioneGenera.Memo1.Lines.Add(Par);
end;

end.
