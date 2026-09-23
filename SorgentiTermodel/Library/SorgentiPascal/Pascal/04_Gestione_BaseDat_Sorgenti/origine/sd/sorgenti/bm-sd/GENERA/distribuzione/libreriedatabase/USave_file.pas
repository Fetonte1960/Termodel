unit USave_file;

interface
Uses UDB;
Procedure salvaTxt;

implementation
Procedure salvaTxt;
Const Versione='3.00';
begin
Writeln(txtOut,Versione);
end;
end.
