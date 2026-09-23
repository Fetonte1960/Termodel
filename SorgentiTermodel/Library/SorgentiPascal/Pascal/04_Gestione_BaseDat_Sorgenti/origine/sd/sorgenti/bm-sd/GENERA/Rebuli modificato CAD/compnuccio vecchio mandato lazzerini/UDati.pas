unit UDati;
interface
Uses DbTables,db;
Var data_drive,nomecom,progdrive:string;
Procedure CreaDataBase(var tt:TTable;Nomefile,TipoTab:string);
Procedure Crea_Term;
implementation
uses Udatalink,udb;
{$I Mappadb.pas}
Procedure CreaDataBase(var tt:TTable;Nomefile,TipoTab:string);
begin
If tipoTab='RADIATORI' then
Crea_radiatori(tt,NomeFile)
else
  begin
  If tipoTab='FANCOIL' then
  Crea_fancoil(tt,NomeFile)
  else
  Crea_Vuoto(tt,NomeFile);
  end;
end;
Procedure Crea_Term;
begin
Crea_Terminale(dm1.tt1);
dm1.tt1.open;
dm1.tt1.edit;
with V_recterm do
  begin
  set_ETbs(26);
  set_ETbu(19);
  set_ITbs(20);
  set_EInH2o(7);
  set_EDt(5);
  set_IInH2o(65);
  set_IDt(10);
  end;
dm1.tt1.POst;
end;
end.
