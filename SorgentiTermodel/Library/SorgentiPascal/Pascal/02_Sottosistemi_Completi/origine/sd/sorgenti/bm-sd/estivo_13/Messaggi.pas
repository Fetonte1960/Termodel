unit Messaggi;

interface
Procedure echo(Mess:string);

implementation
Uses MainForm;
Procedure echo(Mess:string);
begin
FMainEstivo.memo1.lines.add(Mess);
end;
end.
