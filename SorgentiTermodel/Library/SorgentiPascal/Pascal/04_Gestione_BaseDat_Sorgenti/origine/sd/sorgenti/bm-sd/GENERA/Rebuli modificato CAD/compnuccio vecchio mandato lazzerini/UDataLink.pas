Unit UDataLink;
Interface
Uses Udb ;
{*************************************************************}
Type 
O_RecRad=
       ObJect
       Function Grand:STRING;
       Procedure Set_Grand(Par:STRING);
       Function Resa:REAL;
       Procedure Set_Resa(Par:REAL);
       End;
Var V_RecRad:O_RecRad;
{*************************************************************}
Type 
O_RecFan=
       ObJect
       Function Grand:STRING;
       Procedure Set_Grand(Par:STRING);
       Function EPotsens:REAL;
       Procedure Set_EPotsens(Par:REAL);
       Function EPotTot:REAL;
       Procedure Set_EPotTot(Par:REAL);
       Function EPortH2o:REAL;
       Procedure Set_EPortH2o(Par:REAL);
       Function EPerdH2o:REAL;
       Procedure Set_EPerdH2o(Par:REAL);
       Function IPortH2o:REAL;
       Procedure Set_IPortH2o(Par:REAL);
       Function IPotsens:REAL;
       Procedure Set_IPotsens(Par:REAL);
       Function IPerdH2o:REAL;
       Procedure Set_IPerdH2o(Par:REAL);
       End;
Var V_RecFan:O_RecFan;
{*************************************************************}
Type 
O_RecVuoto=
       ObJect
       Function Faitu:STRING;
       Procedure Set_Faitu(Par:STRING);
       End;
Var V_RecVuoto:O_RecVuoto;
{*************************************************************}
Type 
O_RecTerm=
       ObJect
       Function Fab:STRING;
       Procedure Set_Fab(Par:STRING);
       Function Modello:STRING;
       Procedure Set_Modello(Par:STRING);
       Function Grand:STRING;
       Procedure Set_Grand(Par:STRING);
       Function ETbs:REAL;
       Procedure Set_ETbs(Par:REAL);
       Function ETbu:REAL;
       Procedure Set_ETbu(Par:REAL);
       Function ITbs:REAL;
       Procedure Set_ITbs(Par:REAL);
       Function EPsens:REAL;
       Procedure Set_EPsens(Par:REAL);
       Function IPsens:REAL;
       Procedure Set_IPsens(Par:REAL);
       Function EPTot:REAL;
       Procedure Set_EPTot(Par:REAL);
       Function EInH2o:REAL;
       Procedure Set_EInH2o(Par:REAL);
       Function EDt:REAL;
       Procedure Set_EDt(Par:REAL);
       Function EPort:REAL;
       Procedure Set_EPort(Par:REAL);
       Function EDP:REAL;
       Procedure Set_EDP(Par:REAL);
       Function IInH2o:REAL;
       Procedure Set_IInH2o(Par:REAL);
       Function IDt:REAL;
       Procedure Set_IDt(Par:REAL);
       Function IPort:REAL;
       Procedure Set_IPort(Par:REAL);
       Function IDP:REAL;
       Procedure Set_IDP(Par:REAL);
       End;
Var V_RecTerm:O_RecTerm;
Implementation
{$I DataLink.pas}
End.
