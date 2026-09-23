Unit UDataOutT;
Interface
uses Sysutils,Varcarichi,Math,db,Udb,CreaDbT,DBtables;
Procedure Leggi_Campi(var Tabella1:TTable;Var arr:Ar_RecCampi;Var i:Integer);
Procedure Salva_Campi(var Tabella1:TTable;Var arr:Ar_RecCampi;Indmax:integer);
Procedure Leggi_Rec(var Tabella1:TTable;var Tabella3:TTable;DataS1:Tdatasource);
Procedure Salva_Rec(var Tabella1,Tabella3:TTable;Var DataS1:Tdatasource);
Implementation
{$I Freal}
{$I DataOut}
{$I Datain}
End.
