unit Miglioramenti;

interface
uses db,dbtables;
Procedure Init_miglioramenti;
Var T_Mig:TTable;
    ds_Mig:Tdatasource;
implementation
uses uformL10;

Procedure Init_miglioramenti;
begin
T_mig:=TTable.create(nil);
DS_mig:=TDatasource.create(nil);
with FCalcL10 do
  begin
  end;
end;

end.
