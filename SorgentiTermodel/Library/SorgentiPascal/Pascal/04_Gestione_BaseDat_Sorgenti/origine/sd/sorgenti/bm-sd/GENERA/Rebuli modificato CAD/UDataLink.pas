Unit UDataLink;
Interface
Uses Udb ;
{*************************************************************}
Type 
O_Amb=
       ObJect
       Function Num:INTEGER;
       Procedure Set_Num(Par:INTEGER);
       Function Descr:STRING;
       Procedure Set_Descr(Par:STRING);
       Function Direz:REAL;
       Procedure Set_Direz(Par:REAL);
       Function Tipo:STRING;
       Procedure Set_Tipo(Par:STRING);
       Function L:REAL;
       Procedure Set_L(Par:REAL);
       Function H:REAL;
       Procedure Set_H(Par:REAL);
       Function Alt:REAL;
       Procedure Set_Alt(Par:REAL);
       Function LQ1:REAL;
       Procedure Set_LQ1(Par:REAL);
       Function HQ1:REAL;
       Procedure Set_HQ1(Par:REAL);
       Function allinea:STRING;
       Procedure Set_allinea(Par:STRING);
       Function NLamp:INTEGER;
       Procedure Set_NLamp(Par:INTEGER);
       Function TLamp:INTEGER;
       Procedure Set_TLamp(Par:INTEGER);
       Function LLamp1:REAL;
       Procedure Set_LLamp1(Par:REAL);
       Function HLamp1:REAL;
       Procedure Set_HLamp1(Par:REAL);
       Function SLamp:REAL;
       Procedure Set_SLamp(Par:REAL);
       Function POtlamp:REAL;
       Procedure Set_POtlamp(Par:REAL);
       Function TPOtlamp:REAL;
       Procedure Set_TPOtlamp(Par:REAL);
       Function Irragg:REAL;
       Procedure Set_Irragg(Par:REAL);
       Function Persone:REAL;
       Procedure Set_Persone(Par:REAL);
       Function AltriC:REAL;
       Procedure Set_AltriC(Par:REAL);
       Function ETotSens:REAL;
       Procedure Set_ETotSens(Par:REAL);
       Function ITotSens:REAL;
       Procedure Set_ITotSens(Par:REAL);
       Function Slorda:REAL;
       Procedure Set_Slorda(Par:REAL);
       Function Snetta:REAL;
       Procedure Set_Snetta(Par:REAL);
       Function POrtAp:REAL;
       Procedure Set_POrtAp(Par:REAL);
       Function TiI:REAL;
       Procedure Set_TiI(Par:REAL);
       Function URI:REAL;
       Procedure Set_URI(Par:REAL);
       Function ITmaria:REAL;
       Procedure Set_ITmaria(Par:REAL);
       Function ITmacq:REAL;
       Procedure Set_ITmacq(Par:REAL);
       Function ITracq:REAL;
       Procedure Set_ITracq(Par:REAL);
       Function TiE:REAL;
       Procedure Set_TiE(Par:REAL);
       Function URE:REAL;
       Procedure Set_URE(Par:REAL);
       Function ETmaria:REAL;
       Procedure Set_ETmaria(Par:REAL);
       Function ETmacq:REAL;
       Procedure Set_ETmacq(Par:REAL);
       Function ETracq:REAL;
       Procedure Set_ETracq(Par:REAL);
       Function tp:INTEGER;
       Procedure Set_tp(Par:INTEGER);
       Function DescrP:STRING;
       Procedure Set_DescrP(Par:STRING);
       Function ts:INTEGER;
       Procedure Set_ts(Par:INTEGER);
       Function resaI:REAL;
       Procedure Set_resaI(Par:REAL);
       Function resaE:REAL;
       Procedure Set_resaE(Par:REAL);
       Function TotE:REAL;
       Procedure Set_TotE(Par:REAL);
       Function TotI:REAL;
       Procedure Set_TotI(Par:REAL);
       End;
Var V_Amb:O_Amb;
{*************************************************************}
Type 
O_RecPar=
       ObJect
       Function Lato:STRING;
       Procedure Set_Lato(Par:STRING);
       Function Tipo:STRING;
       Procedure Set_Tipo(Par:STRING);
       Function Cod:STRING;
       Procedure Set_Cod(Par:STRING);
       Function Num:REAL;
       Procedure Set_Num(Par:REAL);
       Function Sup:REAL;
       Procedure Set_Sup(Par:REAL);
       End;
Var V_RecPar:O_RecPar;
{*************************************************************}
Type 
O_Recdef=
       ObJect
       Function POrtAp:REAL;
       Procedure Set_POrtAp(Par:REAL);
       Function Alt:REAL;
       Procedure Set_Alt(Par:REAL);
       Function TiI:REAL;
       Procedure Set_TiI(Par:REAL);
       Function URI:REAL;
       Procedure Set_URI(Par:REAL);
       Function ITmaria:REAL;
       Procedure Set_ITmaria(Par:REAL);
       Function ITmacq:REAL;
       Procedure Set_ITmacq(Par:REAL);
       Function ITracq:REAL;
       Procedure Set_ITracq(Par:REAL);
       Function TiE:REAL;
       Procedure Set_TiE(Par:REAL);
       Function URE:REAL;
       Procedure Set_URE(Par:REAL);
       Function ETmaria:REAL;
       Procedure Set_ETmaria(Par:REAL);
       Function ETmacq:REAL;
       Procedure Set_ETmacq(Par:REAL);
       Function ETracq:REAL;
       Procedure Set_ETracq(Par:REAL);
       End;
Var V_Recdef:O_Recdef;
{*************************************************************}
Type 
O_Recgen=
       ObJect
       Function Data:STRING;
       Procedure Set_Data(Par:STRING);
       Function Codice:STRING;
       Procedure Set_Codice(Par:STRING);
       Function Committente:STRING;
       Procedure Set_Committente(Par:STRING);
       Function Commessa:STRING;
       Procedure Set_Commessa(Par:STRING);
       Function Impianto:STRING;
       Procedure Set_Impianto(Par:STRING);
       Function Progettista:STRING;
       Procedure Set_Progettista(Par:STRING);
       Function localita:STRING;
       Procedure Set_localita(Par:STRING);
       Function TestInv:REAL;
       Procedure Set_TestInv(Par:REAL);
       Function TestEst:REAL;
       Procedure Set_TestEst(Par:REAL);
       End;
Var V_Recgen:O_Recgen;
{*************************************************************}
Type 
O_RecMuri=
       ObJect
       Function Cod:STRING;
       Procedure Set_Cod(Par:STRING);
       Function Descr:STRING;
       Procedure Set_Descr(Par:STRING);
       Function K:REAL;
       Procedure Set_K(Par:REAL);
       End;
Var V_RecMuri:O_RecMuri;
{*************************************************************}
Type 
O_RecFin=
       ObJect
       Function Cod:STRING;
       Procedure Set_Cod(Par:STRING);
       Function Descr:STRING;
       Procedure Set_Descr(Par:STRING);
       Function SupUn:REAL;
       Procedure Set_SupUn(Par:REAL);
       Function K:REAL;
       Procedure Set_K(Par:REAL);
       Function AttSol:REAL;
       Procedure Set_AttSol(Par:REAL);
       End;
Var V_RecFin:O_RecFin;
{*************************************************************}
Type 
O_RecEsp=
       ObJect
       Function Cod:STRING;
       Procedure Set_Cod(Par:STRING);
       Function Descr:STRING;
       Procedure Set_Descr(Par:STRING);
       Function Tipo:STRING;
       Procedure Set_Tipo(Par:STRING);
       Function Incl:REAL;
       Procedure Set_Incl(Par:REAL);
       Function TLcI:REAL;
       Procedure Set_TLcI(Par:REAL);
       Function TLcE:REAL;
       Procedure Set_TLcE(Par:REAL);
       End;
Var V_RecEsp:O_RecEsp;
Implementation
{$I DataLink.pas}
End.
