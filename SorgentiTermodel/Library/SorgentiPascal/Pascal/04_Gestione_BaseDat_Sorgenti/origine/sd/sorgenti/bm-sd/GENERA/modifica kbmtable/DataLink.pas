{*************************************************************}
Function O_RecGen.Progetto:STRING;
Begin
result:=Dm1.tt1.fields[0].asstring;
End;
Procedure O_RecGen.Set_Progetto(Par:STRING);
Begin
Dm1.tt1.fields[0].asstring:=Par;
End;
Function O_RecGen.Committ:STRING;
Begin
result:=Dm1.tt1.fields[1].asstring;
End;
Procedure O_RecGen.Set_Committ(Par:STRING);
Begin
Dm1.tt1.fields[1].asstring:=Par;
End;
Function O_RecGen.Progettista:STRING;
Begin
result:=Dm1.tt1.fields[2].asstring;
End;
Procedure O_RecGen.Set_Progettista(Par:STRING);
Begin
Dm1.tt1.fields[2].asstring:=Par;
End;
Function O_RecGen.Revisione:INTEGER;
Begin
result:=Dm1.tt1.fields[3].asinteger;
End;
Procedure O_RecGen.Set_Revisione(Par:INTEGER);
Begin
Dm1.tt1.fields[3].asinteger:=Par;
End;
Function O_RecGen.Data:STRING;
Begin
result:=Dm1.tt1.fields[4].asstring;
End;
Procedure O_RecGen.Set_Data(Par:STRING);
Begin
Dm1.tt1.fields[4].asstring:=Par;
End;
Function O_RecGen.Luogo:STRING;
Begin
result:=Dm1.tt1.fields[5].asstring;
End;
Procedure O_RecGen.Set_Luogo(Par:STRING);
Begin
Dm1.tt1.fields[5].asstring:=Par;
End;
Function O_RecGen.ritorno:STRING;
Begin
result:=Dm1.tt1.fields[6].asstring;
End;
Procedure O_RecGen.Set_ritorno(Par:STRING);
Begin
Dm1.tt1.fields[6].asstring:=Par;
End;
Function O_RecGen.dps:REAL;
Begin
result:=Dm1.tt1.fields[7].asfloat;
End;
Procedure O_RecGen.Set_dps(Par:REAL);
Begin
Dm1.tt1.fields[7].asfloat:=Par;
End;
Function O_RecGen.maxvels:REAL;
Begin
result:=Dm1.tt1.fields[8].asfloat;
End;
Procedure O_RecGen.Set_maxvels(Par:REAL);
Begin
Dm1.tt1.fields[8].asfloat:=Par;
End;
Function O_RecGen.dpe:REAL;
Begin
result:=Dm1.tt1.fields[9].asfloat;
End;
Procedure O_RecGen.Set_dpe(Par:REAL);
Begin
Dm1.tt1.fields[9].asfloat:=Par;
End;
Function O_RecGen.maxvele:REAL;
Begin
result:=Dm1.tt1.fields[10].asfloat;
End;
Procedure O_RecGen.Set_maxvele(Par:REAL);
Begin
Dm1.tt1.fields[10].asfloat:=Par;
End;
Function O_RecGen.valvtipo:STRING;
Begin
result:=Dm1.tt1.fields[11].asstring;
End;
Procedure O_RecGen.Set_valvtipo(Par:STRING);
Begin
Dm1.tt1.fields[11].asstring:=Par;
End;
Function O_RecGen.perdmin:REAL;
Begin
result:=Dm1.tt1.fields[12].asfloat;
End;
Procedure O_RecGen.Set_perdmin(Par:REAL);
Begin
Dm1.tt1.fields[12].asfloat:=Par;
End;
Function O_RecGen.Tolleranza:REAL;
Begin
result:=Dm1.tt1.fields[13].asfloat;
End;
Procedure O_RecGen.Set_Tolleranza(Par:REAL);
Begin
Dm1.tt1.fields[13].asfloat:=Par;
End;
Function O_RecGen.Iterazioni:INTEGER;
Begin
result:=Dm1.tt1.fields[14].asinteger;
End;
Procedure O_RecGen.Set_Iterazioni(Par:INTEGER);
Begin
Dm1.tt1.fields[14].asinteger:=Par;
End;
{*************************************************************}
Function O_RecPerd.Cod:STRING;
Begin
result:=Dm1.tt1.fields[0].asstring;
End;
Procedure O_RecPerd.Set_Cod(Par:STRING);
Begin
Dm1.tt1.fields[0].asstring:=Par;
End;
Function O_RecPerd.Descr:STRING;
Begin
result:=Dm1.tt1.fields[1].asstring;
End;
Procedure O_RecPerd.Set_Descr(Par:STRING);
Begin
Dm1.tt1.fields[1].asstring:=Par;
End;
Function O_RecPerd.Leq:REAL;
Begin
result:=Dm1.tt1.fields[2].asfloat;
End;
Procedure O_RecPerd.Set_Leq(Par:REAL);
Begin
Dm1.tt1.fields[2].asfloat:=Par;
End;
Function O_RecPerd.Zeta:REAL;
Begin
result:=Dm1.tt1.fields[3].asfloat;
End;
Procedure O_RecPerd.Set_Zeta(Par:REAL);
Begin
Dm1.tt1.fields[3].asfloat:=Par;
End;
Function O_RecPerd.Rit:STRING;
Begin
result:=Dm1.tt1.fields[4].asstring;
End;
Procedure O_RecPerd.Set_Rit(Par:STRING);
Begin
Dm1.tt1.fields[4].asstring:=Par;
End;
{*************************************************************}
Function O_Recsez.Dnom:STRING;
Begin
result:=Dm1.tt1.fields[2].asstring;
End;
Procedure O_Recsez.Set_Dnom(Par:STRING);
Begin
Dm1.tt1.fields[2].asstring:=Par;
End;
Function O_Recsez.Dint:REAL;
Begin
result:=Dm1.tt1.fields[3].asfloat;
End;
Procedure O_Recsez.Set_Dint(Par:REAL);
Begin
Dm1.tt1.fields[3].asfloat:=Par;
End;
Function O_Recsez.spes:REAL;
Begin
result:=Dm1.tt1.fields[4].asfloat;
End;
Procedure O_Recsez.Set_spes(Par:REAL);
Begin
Dm1.tt1.fields[4].asfloat:=Par;
End;
Function O_Recsez.form:INTEGER;
Begin
result:=Dm1.tt1.fields[5].asinteger;
End;
Procedure O_Recsez.Set_form(Par:INTEGER);
Begin
Dm1.tt1.fields[5].asinteger:=Par;
End;
{*************************************************************}
Function O_RecTubaz.Cod:STRING;
Begin
result:=Dm1.tt1.fields[0].asstring;
End;
Procedure O_RecTubaz.Set_Cod(Par:STRING);
Begin
Dm1.tt1.fields[0].asstring:=Par;
End;
Function O_RecTubaz.Descr:STRING;
Begin
result:=Dm1.tt1.fields[1].asstring;
End;
Procedure O_RecTubaz.Set_Descr(Par:STRING);
Begin
Dm1.tt1.fields[1].asstring:=Par;
End;
Function O_RecTubaz.Dens:REAL;
Begin
result:=Dm1.tt1.fields[2].asfloat;
End;
Procedure O_RecTubaz.Set_Dens(Par:REAL);
Begin
Dm1.tt1.fields[2].asfloat:=Par;
End;
Function O_RecTubaz.Rug:REAL;
Begin
result:=Dm1.tt1.fields[3].asfloat;
End;
Procedure O_RecTubaz.Set_Rug(Par:REAL);
Begin
Dm1.tt1.fields[3].asfloat:=Par;
End;
{*************************************************************}
Function O_RecPconc.N:INTEGER;
Begin
result:=Dm1.tt1.fields[0].asinteger;
End;
Procedure O_RecPconc.Set_N(Par:INTEGER);
Begin
Dm1.tt1.fields[0].asinteger:=Par;
End;
Function O_RecPconc.Cod:STRING;
Begin
result:=Dm1.tt1.fields[1].asstring;
End;
Procedure O_RecPconc.Set_Cod(Par:STRING);
Begin
Dm1.tt1.fields[1].asstring:=Par;
End;
{*************************************************************}
Function O_RecPros.Ramo:INTEGER;
Begin
result:=Dm1.tt1.fields[2].asinteger;
End;
Procedure O_RecPros.Set_Ramo(Par:INTEGER);
Begin
Dm1.tt1.fields[2].asinteger:=Par;
End;
{*************************************************************}
Function O_calcrec.Num:INTEGER;
Begin
result:=Dm1.tt1.fields[0].asinteger;
End;
Procedure O_calcrec.Set_Num(Par:INTEGER);
Begin
Dm1.tt1.fields[0].asinteger:=Par;
End;
Function O_calcrec.x:REAL;
Begin
result:=Dm1.tt1.fields[1].asfloat;
End;
Procedure O_calcrec.Set_x(Par:REAL);
Begin
Dm1.tt1.fields[1].asfloat:=Par;
End;
Function O_calcrec.y:REAL;
Begin
result:=Dm1.tt1.fields[2].asfloat;
End;
Procedure O_calcrec.Set_y(Par:REAL);
Begin
Dm1.tt1.fields[2].asfloat:=Par;
End;
Function O_calcrec.Tipo:STRING;
Begin
result:=Dm1.tt1.fields[3].asstring;
End;
Procedure O_calcrec.Set_Tipo(Par:STRING);
Begin
Dm1.tt1.fields[3].asstring:=Par;
End;
Function O_calcrec.Dh:REAL;
Begin
result:=Dm1.tt1.fields[4].asfloat;
End;
Procedure O_calcrec.Set_Dh(Par:REAL);
Begin
Dm1.tt1.fields[4].asfloat:=Par;
End;
Function O_calcrec.lungh:REAL;
Begin
result:=Dm1.tt1.fields[5].asfloat;
End;
Procedure O_calcrec.Set_lungh(Par:REAL);
Begin
Dm1.tt1.fields[5].asfloat:=Par;
End;
Function O_calcrec.Coddiam:STRING;
Begin
result:=Dm1.tt1.fields[6].asstring;
End;
Procedure O_calcrec.Set_Coddiam(Par:STRING);
Begin
Dm1.tt1.fields[6].asstring:=Par;
End;
Function O_calcrec.diam:REAL;
Begin
result:=Dm1.tt1.fields[7].asfloat;
End;
Procedure O_calcrec.Set_diam(Par:REAL);
Begin
Dm1.tt1.fields[7].asfloat:=Par;
End;
Function O_calcrec.SWDiam:STRING;
Begin
result:=Dm1.tt1.fields[8].asstring;
End;
Procedure O_calcrec.Set_SWDiam(Par:STRING);
Begin
Dm1.tt1.fields[8].asstring:=Par;
End;
Function O_calcrec.port:REAL;
Begin
result:=Dm1.tt1.fields[9].asfloat;
End;
Procedure O_calcrec.Set_port(Par:REAL);
Begin
Dm1.tt1.fields[9].asfloat:=Par;
End;
Function O_calcrec.PortEff:REAL;
Begin
result:=Dm1.tt1.fields[10].asfloat;
End;
Procedure O_calcrec.Set_PortEff(Par:REAL);
Begin
Dm1.tt1.fields[10].asfloat:=Par;
End;
Function O_calcrec.Ti:INTEGER;
Begin
result:=Dm1.tt1.fields[11].asinteger;
End;
Procedure O_calcrec.Set_Ti(Par:INTEGER);
Begin
Dm1.tt1.fields[11].asinteger:=Par;
End;
Function O_calcrec.Term:INTEGER;
Begin
result:=Dm1.tt1.fields[12].asinteger;
End;
Procedure O_calcrec.Set_Term(Par:INTEGER);
Begin
Dm1.tt1.fields[12].asinteger:=Par;
End;
Function O_calcrec.pd:REAL;
Begin
result:=Dm1.tt1.fields[13].asfloat;
End;
Procedure O_calcrec.Set_pd(Par:REAL);
Begin
Dm1.tt1.fields[13].asfloat:=Par;
End;
Function O_calcrec.pl:REAL;
Begin
result:=Dm1.tt1.fields[14].asfloat;
End;
Procedure O_calcrec.Set_pl(Par:REAL);
Begin
Dm1.tt1.fields[14].asfloat:=Par;
End;
Function O_calcrec.pp:REAL;
Begin
result:=Dm1.tt1.fields[15].asfloat;
End;
Procedure O_calcrec.Set_pp(Par:REAL);
Begin
Dm1.tt1.fields[15].asfloat:=Par;
End;
Function O_calcrec.pr:REAL;
Begin
result:=Dm1.tt1.fields[16].asfloat;
End;
Procedure O_calcrec.Set_pr(Par:REAL);
Begin
Dm1.tt1.fields[16].asfloat:=Par;
End;
