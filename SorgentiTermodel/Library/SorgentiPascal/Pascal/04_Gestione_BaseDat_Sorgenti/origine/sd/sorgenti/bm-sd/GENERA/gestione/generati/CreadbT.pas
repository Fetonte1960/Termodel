Unit CreaDbT;
Interface
uses Udbt,db,DBtables,sysutils;
Procedure Creadatabase(nome:string);
Implementation
{$I MappaDB}
Procedure Creadatabase(nome:string);
Begin
Nome:=uppercase(nome);
If Nome='REC' then Crea_Rec(Dmtutti.T_Rec);
If Nome='REC' then Crea_Campi(Dmtutti.T_Campi);
End;
End.
