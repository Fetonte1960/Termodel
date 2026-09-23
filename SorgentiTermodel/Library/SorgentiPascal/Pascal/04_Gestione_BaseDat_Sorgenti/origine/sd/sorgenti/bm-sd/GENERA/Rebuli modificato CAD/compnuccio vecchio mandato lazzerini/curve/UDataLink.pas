Unit UDataLink;
Interface
Uses Udb ;
{*************************************************************}
Type 
O_RecCurve=
       ObJect
       Function Nome:STRING;
       Procedure Set_Nome(Par:STRING);
       Function Parametro:REAL;
       Procedure Set_Parametro(Par:REAL);
       Function X:REAL;
       Procedure Set_X(Par:REAL);
       Function Y:REAL;
       Procedure Set_Y(Par:REAL);
       End;
Var V_RecCurve:O_RecCurve;
Implementation
{$I DataLink.pas}
End.
