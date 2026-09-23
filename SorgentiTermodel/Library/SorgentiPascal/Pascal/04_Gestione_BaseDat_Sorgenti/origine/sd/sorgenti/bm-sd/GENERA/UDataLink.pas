Unit UDataLink;
Interface
Uses Udb ;
{*************************************************************}
Type 
O_RecGen=
       ObJect
       Function Progetto:STRING;
       Procedure Set_Progetto(Par:STRING);
       Function Committ:STRING;
       Procedure Set_Committ(Par:STRING);
       Function Progettista:STRING;
       Procedure Set_Progettista(Par:STRING);
       Function Revisione:INTEGER;
       Procedure Set_Revisione(Par:INTEGER);
       Function Data:STRING;
       Procedure Set_Data(Par:STRING);
       Function Luogo:STRING;
       Procedure Set_Luogo(Par:STRING);
       Function ritorno:STRING;
       Procedure Set_ritorno(Par:STRING);
       Function dps:REAL;
       Procedure Set_dps(Par:REAL);
       Function maxvels:REAL;
       Procedure Set_maxvels(Par:REAL);
       Function dpe:REAL;
       Procedure Set_dpe(Par:REAL);
       Function maxvele:REAL;
       Procedure Set_maxvele(Par:REAL);
       Function valvtipo:STRING;
       Procedure Set_valvtipo(Par:STRING);
       Function perdmin:REAL;
       Procedure Set_perdmin(Par:REAL);
       Function Tolleranza:REAL;
       Procedure Set_Tolleranza(Par:REAL);
       Function Iterazioni:INTEGER;
       Procedure Set_Iterazioni(Par:INTEGER);
       End;
Var V_RecGen:O_RecGen;
{*************************************************************}
Type 
O_RecPerd=
       ObJect
       Function Cod:STRING;
       Procedure Set_Cod(Par:STRING);
       Function Descr:STRING;
       Procedure Set_Descr(Par:STRING);
       Function Leq:REAL;
       Procedure Set_Leq(Par:REAL);
       Function Zeta:REAL;
       Procedure Set_Zeta(Par:REAL);
       Function Rit:STRING;
       Procedure Set_Rit(Par:STRING);
       End;
Var V_RecPerd:O_RecPerd;
{*************************************************************}
Type 
O_Recsez=
       ObJect
       Function Dnom:STRING;
       Procedure Set_Dnom(Par:STRING);
       Function Dint:REAL;
       Procedure Set_Dint(Par:REAL);
       Function spes:REAL;
       Procedure Set_spes(Par:REAL);
       Function form:INTEGER;
       Procedure Set_form(Par:INTEGER);
       End;
Var V_Recsez:O_Recsez;
{*************************************************************}
Type 
O_RecTubaz=
       ObJect
       Function Cod:STRING;
       Procedure Set_Cod(Par:STRING);
       Function Descr:STRING;
       Procedure Set_Descr(Par:STRING);
       Function Dens:REAL;
       Procedure Set_Dens(Par:REAL);
       Function Rug:REAL;
       Procedure Set_Rug(Par:REAL);
       End;
Var V_RecTubaz:O_RecTubaz;
{*************************************************************}
Type 
O_RecPconc=
       ObJect
       Function N:INTEGER;
       Procedure Set_N(Par:INTEGER);
       Function Cod:STRING;
       Procedure Set_Cod(Par:STRING);
       End;
Var V_RecPconc:O_RecPconc;
{*************************************************************}
Type 
O_RecPros=
       ObJect
       Function Ramo:INTEGER;
       Procedure Set_Ramo(Par:INTEGER);
       End;
Var V_RecPros:O_RecPros;
{*************************************************************}
Type 
O_calcrec=
       ObJect
       Function Num:INTEGER;
       Procedure Set_Num(Par:INTEGER);
       Function x:REAL;
       Procedure Set_x(Par:REAL);
       Function y:REAL;
       Procedure Set_y(Par:REAL);
       Function Tipo:STRING;
       Procedure Set_Tipo(Par:STRING);
       Function Dh:REAL;
       Procedure Set_Dh(Par:REAL);
       Function lungh:REAL;
       Procedure Set_lungh(Par:REAL);
       Function Coddiam:STRING;
       Procedure Set_Coddiam(Par:STRING);
       Function diam:REAL;
       Procedure Set_diam(Par:REAL);
       Function SWDiam:STRING;
       Procedure Set_SWDiam(Par:STRING);
       Function port:REAL;
       Procedure Set_port(Par:REAL);
       Function PortEff:REAL;
       Procedure Set_PortEff(Par:REAL);
       Function Ti:INTEGER;
       Procedure Set_Ti(Par:INTEGER);
       Function Term:INTEGER;
       Procedure Set_Term(Par:INTEGER);
       Function pd:REAL;
       Procedure Set_pd(Par:REAL);
       Function pl:REAL;
       Procedure Set_pl(Par:REAL);
       Function pp:REAL;
       Procedure Set_pp(Par:REAL);
       Function pr:REAL;
       Procedure Set_pr(Par:REAL);
       End;
Var V_calcrec:O_calcrec;
Implementation
{$I DataLink.pas}
End.
