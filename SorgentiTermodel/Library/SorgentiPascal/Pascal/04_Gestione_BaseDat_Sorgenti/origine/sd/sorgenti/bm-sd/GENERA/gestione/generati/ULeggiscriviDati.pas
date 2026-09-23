Unit ULeggiscrividati;
Interface
Uses DB,Varcarichi,udbt,udb,DbTables,Sysutils,math;
Procedure Leggi_Campi(var Tabella1:TTable;Var arr:Ar_RecCampi;Var i:Integer);
Procedure Salva_Campi(var Tabella1:TTable;Var arr:Ar_RecCampi;Indmax:integer);
Procedure Leggi_Rec(var Tabella1:TTable;var Tabella3:TTable;DataS1:Tdatasource);
Procedure Salva_Rec(var Tabella1,Tabella3:TTable;Var DataS1:Tdatasource);
Procedure Scrividati;
Procedure Leggidati;
Procedure ScrividatiT;
Procedure LeggidatiT;
Implementation
Function F_real(Num:real;Cifredec:integer):real;
Var i:integer;
Begin
result:=RoundTo(num,-cifredec);
end;
{$I Datain.pas}
{$I DataOut.pas}
{$I Leggitutti.pas}
{$I Scrivitutti.pas}
{$I LeggituttiT.pas}
{$I ScrivituttiT.pas}
End.
