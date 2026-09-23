Unit UDataLink;
Interface
Uses Udb,UdbT ;
{*************************************************************}
Type 
O_RecCampi=
       ObJect
       Function Codice:STRING;
       Procedure Set_Codice(Par:STRING);
       Function Lunga:STRING;
       Procedure Set_Lunga(Par:STRING);
       Function Tipo:STRING;
       Procedure Set_Tipo(Par:STRING);
       Function LungCar:INTEGER;
       Procedure Set_LungCar(Par:INTEGER);
       Function Tag:INTEGER;
       Procedure Set_Tag(Par:INTEGER);
       Function TipoCampo:STRING;
       Procedure Set_TipoCampo(Par:STRING);
       Function Griglia:INTEGER;
       Procedure Set_Griglia(Par:INTEGER);
       Function LookUp:STRING;
       Procedure Set_LookUp(Par:STRING);
       Function CampoLookUp:STRING;
       Procedure Set_CampoLookUp(Par:STRING);
       Function Combo1:STRING;
       Procedure Set_Combo1(Par:STRING);
       Function Combo2:STRING;
       Procedure Set_Combo2(Par:STRING);
       Function Combo3:STRING;
       Procedure Set_Combo3(Par:STRING);
       Function Combo4:STRING;
       Procedure Set_Combo4(Par:STRING);
       Function Combo5:STRING;
       Procedure Set_Combo5(Par:STRING);
       Function Combo6:STRING;
       Procedure Set_Combo6(Par:STRING);
       Function Combo7:STRING;
       Procedure Set_Combo7(Par:STRING);
       Function Combo8:STRING;
       Procedure Set_Combo8(Par:STRING);
       Function Combo9:STRING;
       Procedure Set_Combo9(Par:STRING);
       Function Combo10:STRING;
       Procedure Set_Combo10(Par:STRING);
       End;
Var V_RecCampi:O_RecCampi;
{*************************************************************}
Type 
O_TabRec=
       ObJect
       Function Num:INTEGER;
       Procedure Set_Num(Par:INTEGER);
       Function Codice:STRING;
       Procedure Set_Codice(Par:STRING);
       Function Descrizione:STRING;
       Procedure Set_Descrizione(Par:STRING);
       Function Massimo:INTEGER;
       Procedure Set_Massimo(Par:INTEGER);
       Function Tipo:STRING;
       Procedure Set_Tipo(Par:STRING);
       Function Associato:STRING;
       Procedure Set_Associato(Par:STRING);
       Function Menu:STRING;
       Procedure Set_Menu(Par:STRING);
       Function Aggiorna:STRING;
       Procedure Set_Aggiorna(Par:STRING);
       End;
Var V_TabRec:O_TabRec;
Implementation
{$I DataLink.pas}
End.
