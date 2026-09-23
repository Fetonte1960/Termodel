unit UDati;
interface
Uses DbTables,db;
Var data_drive,nomecom,progdrive:string;
Procedure CreaDataBase(var tt:TTable);
implementation
{$I Mappadb.pas}
Procedure CreaDataBase(var tt:TTable);
begin
Crea_ambienti(tt);
Crea_Default(tt);
Crea_Pareti(tt);
Crea_Muri(tt);
Crea_Finestre(tt);
Crea_Esposiz(tt);
Crea_Generalita(tt);
end;
end.
