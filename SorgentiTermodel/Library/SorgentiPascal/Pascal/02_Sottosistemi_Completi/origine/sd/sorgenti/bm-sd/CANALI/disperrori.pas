unit disperrori;

interface
uses Classes;

Procedure RWRITE_E(Mess:string);
Procedure WRITE_E(Mess:string);
Procedure CWRITE_E(Mess:string);
Procedure initErrori(Percorso_Drive:string);
Procedure CloseErrori;
Var ListErrori:TStringlist;
implementation
Var ferrori:textfile;
//uses Umain_calctubi;
Procedure initErrori(Percorso_Drive:string);
begin
assign(Ferrori,Percorso_Drive +'Errorican.txt');
rewrite(Ferrori);
//ListErrori:=TStringList.Create;
end;
Procedure CloseErrori;
begin
close(Ferrori);
end;
Procedure echo(mess:string);
begin
writeln(ferrori,mess);
//listerrori.Add(mess)
end;
var stcor:string;
Procedure CWRITE_E(Mess:string);
begin
stcor:=mess;
end;
Procedure RWRITE_E(Mess:string);
begin
echo(stcor+Mess);
stcor:='';
end;
Procedure WRITE_E(Mess:string);
begin
stcor:=stcor+mess;
end;
end.
