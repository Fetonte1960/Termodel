{*************************************************************}
Function O_Amb.Num:INTEGER;
Begin
result:=Dm1.tt1.fields[0].asinteger;
End;
Procedure O_Amb.Set_Num(Par:INTEGER);
Begin
Dm1.tt1.fields[0].asinteger:=Par;
End;
Function O_Amb.Descr:STRING;
Begin
result:=Dm1.tt1.fields[1].asstring;
End;
Procedure O_Amb.Set_Descr(Par:STRING);
Begin
Dm1.tt1.fields[1].asstring:=Par;
End;
Function O_Amb.Direz:REAL;
Begin
result:=Dm1.tt1.fields[2].asfloat;
End;
Procedure O_Amb.Set_Direz(Par:REAL);
Begin
Dm1.tt1.fields[2].asfloat:=Par;
End;
Function O_Amb.Tipo:STRING;
Begin
result:=Dm1.tt1.fields[3].asstring;
End;
Procedure O_Amb.Set_Tipo(Par:STRING);
Begin
Dm1.tt1.fields[3].asstring:=Par;
End;
Function O_Amb.L:REAL;
Begin
result:=Dm1.tt1.fields[4].asfloat;
End;
Procedure O_Amb.Set_L(Par:REAL);
Begin
Dm1.tt1.fields[4].asfloat:=Par;
End;
Function O_Amb.H:REAL;
Begin
result:=Dm1.tt1.fields[5].asfloat;
End;
Procedure O_Amb.Set_H(Par:REAL);
Begin
Dm1.tt1.fields[5].asfloat:=Par;
End;
Function O_Amb.Alt:REAL;
Begin
result:=Dm1.tt1.fields[6].asfloat;
End;
Procedure O_Amb.Set_Alt(Par:REAL);
Begin
Dm1.tt1.fields[6].asfloat:=Par;
End;
Function O_Amb.LQ1:REAL;
Begin
result:=Dm1.tt1.fields[7].asfloat;
End;
Procedure O_Amb.Set_LQ1(Par:REAL);
Begin
Dm1.tt1.fields[7].asfloat:=Par;
End;
Function O_Amb.HQ1:REAL;
Begin
result:=Dm1.tt1.fields[8].asfloat;
End;
Procedure O_Amb.Set_HQ1(Par:REAL);
Begin
Dm1.tt1.fields[8].asfloat:=Par;
End;
Function O_Amb.allinea:STRING;
Begin
result:=Dm1.tt1.fields[9].asstring;
End;
Procedure O_Amb.Set_allinea(Par:STRING);
Begin
Dm1.tt1.fields[9].asstring:=Par;
End;
Function O_Amb.NLamp:INTEGER;
Begin
result:=Dm1.tt1.fields[10].asinteger;
End;
Procedure O_Amb.Set_NLamp(Par:INTEGER);
Begin
Dm1.tt1.fields[10].asinteger:=Par;
End;
Function O_Amb.TLamp:INTEGER;
Begin
result:=Dm1.tt1.fields[11].asinteger;
End;
Procedure O_Amb.Set_TLamp(Par:INTEGER);
Begin
Dm1.tt1.fields[11].asinteger:=Par;
End;
Function O_Amb.LLamp1:REAL;
Begin
result:=Dm1.tt1.fields[12].asfloat;
End;
Procedure O_Amb.Set_LLamp1(Par:REAL);
Begin
Dm1.tt1.fields[12].asfloat:=Par;
End;
Function O_Amb.HLamp1:REAL;
Begin
result:=Dm1.tt1.fields[13].asfloat;
End;
Procedure O_Amb.Set_HLamp1(Par:REAL);
Begin
Dm1.tt1.fields[13].asfloat:=Par;
End;
Function O_Amb.SLamp:REAL;
Begin
result:=Dm1.tt1.fields[14].asfloat;
End;
Procedure O_Amb.Set_SLamp(Par:REAL);
Begin
Dm1.tt1.fields[14].asfloat:=Par;
End;
Function O_Amb.POtlamp:REAL;
Begin
result:=Dm1.tt1.fields[15].asfloat;
End;
Procedure O_Amb.Set_POtlamp(Par:REAL);
Begin
Dm1.tt1.fields[15].asfloat:=Par;
End;
Function O_Amb.TPOtlamp:REAL;
Begin
result:=Dm1.tt1.fields[16].asfloat;
End;
Procedure O_Amb.Set_TPOtlamp(Par:REAL);
Begin
Dm1.tt1.fields[16].asfloat:=Par;
End;
Function O_Amb.Irragg:REAL;
Begin
result:=Dm1.tt1.fields[17].asfloat;
End;
Procedure O_Amb.Set_Irragg(Par:REAL);
Begin
Dm1.tt1.fields[17].asfloat:=Par;
End;
Function O_Amb.Persone:REAL;
Begin
result:=Dm1.tt1.fields[18].asfloat;
End;
Procedure O_Amb.Set_Persone(Par:REAL);
Begin
Dm1.tt1.fields[18].asfloat:=Par;
End;
Function O_Amb.AltriC:REAL;
Begin
result:=Dm1.tt1.fields[19].asfloat;
End;
Procedure O_Amb.Set_AltriC(Par:REAL);
Begin
Dm1.tt1.fields[19].asfloat:=Par;
End;
Function O_Amb.ETotSens:REAL;
Begin
result:=Dm1.tt1.fields[20].asfloat;
End;
Procedure O_Amb.Set_ETotSens(Par:REAL);
Begin
Dm1.tt1.fields[20].asfloat:=Par;
End;
Function O_Amb.ITotSens:REAL;
Begin
result:=Dm1.tt1.fields[21].asfloat;
End;
Procedure O_Amb.Set_ITotSens(Par:REAL);
Begin
Dm1.tt1.fields[21].asfloat:=Par;
End;
Function O_Amb.Slorda:REAL;
Begin
result:=Dm1.tt1.fields[22].asfloat;
End;
Procedure O_Amb.Set_Slorda(Par:REAL);
Begin
Dm1.tt1.fields[22].asfloat:=Par;
End;
Function O_Amb.Snetta:REAL;
Begin
result:=Dm1.tt1.fields[23].asfloat;
End;
Procedure O_Amb.Set_Snetta(Par:REAL);
Begin
Dm1.tt1.fields[23].asfloat:=Par;
End;
Function O_Amb.POrtAp:REAL;
Begin
result:=Dm1.tt1.fields[24].asfloat;
End;
Procedure O_Amb.Set_POrtAp(Par:REAL);
Begin
Dm1.tt1.fields[24].asfloat:=Par;
End;
Function O_Amb.TiI:REAL;
Begin
result:=Dm1.tt1.fields[25].asfloat;
End;
Procedure O_Amb.Set_TiI(Par:REAL);
Begin
Dm1.tt1.fields[25].asfloat:=Par;
End;
Function O_Amb.URI:REAL;
Begin
result:=Dm1.tt1.fields[26].asfloat;
End;
Procedure O_Amb.Set_URI(Par:REAL);
Begin
Dm1.tt1.fields[26].asfloat:=Par;
End;
Function O_Amb.ITmaria:REAL;
Begin
result:=Dm1.tt1.fields[27].asfloat;
End;
Procedure O_Amb.Set_ITmaria(Par:REAL);
Begin
Dm1.tt1.fields[27].asfloat:=Par;
End;
Function O_Amb.ITmacq:REAL;
Begin
result:=Dm1.tt1.fields[28].asfloat;
End;
Procedure O_Amb.Set_ITmacq(Par:REAL);
Begin
Dm1.tt1.fields[28].asfloat:=Par;
End;
Function O_Amb.ITracq:REAL;
Begin
result:=Dm1.tt1.fields[29].asfloat;
End;
Procedure O_Amb.Set_ITracq(Par:REAL);
Begin
Dm1.tt1.fields[29].asfloat:=Par;
End;
Function O_Amb.TiE:REAL;
Begin
result:=Dm1.tt1.fields[30].asfloat;
End;
Procedure O_Amb.Set_TiE(Par:REAL);
Begin
Dm1.tt1.fields[30].asfloat:=Par;
End;
Function O_Amb.URE:REAL;
Begin
result:=Dm1.tt1.fields[31].asfloat;
End;
Procedure O_Amb.Set_URE(Par:REAL);
Begin
Dm1.tt1.fields[31].asfloat:=Par;
End;
Function O_Amb.ETmaria:REAL;
Begin
result:=Dm1.tt1.fields[32].asfloat;
End;
Procedure O_Amb.Set_ETmaria(Par:REAL);
Begin
Dm1.tt1.fields[32].asfloat:=Par;
End;
Function O_Amb.ETmacq:REAL;
Begin
result:=Dm1.tt1.fields[33].asfloat;
End;
Procedure O_Amb.Set_ETmacq(Par:REAL);
Begin
Dm1.tt1.fields[33].asfloat:=Par;
End;
Function O_Amb.ETracq:REAL;
Begin
result:=Dm1.tt1.fields[34].asfloat;
End;
Procedure O_Amb.Set_ETracq(Par:REAL);
Begin
Dm1.tt1.fields[34].asfloat:=Par;
End;
Function O_Amb.tp:INTEGER;
Begin
result:=Dm1.tt1.fields[35].asinteger;
End;
Procedure O_Amb.Set_tp(Par:INTEGER);
Begin
Dm1.tt1.fields[35].asinteger:=Par;
End;
Function O_Amb.DescrP:STRING;
Begin
result:=Dm1.tt1.fields[36].asstring;
End;
Procedure O_Amb.Set_DescrP(Par:STRING);
Begin
Dm1.tt1.fields[36].asstring:=Par;
End;
Function O_Amb.ts:INTEGER;
Begin
result:=Dm1.tt1.fields[37].asinteger;
End;
Procedure O_Amb.Set_ts(Par:INTEGER);
Begin
Dm1.tt1.fields[37].asinteger:=Par;
End;
Function O_Amb.resaI:REAL;
Begin
result:=Dm1.tt1.fields[38].asfloat;
End;
Procedure O_Amb.Set_resaI(Par:REAL);
Begin
Dm1.tt1.fields[38].asfloat:=Par;
End;
Function O_Amb.resaE:REAL;
Begin
result:=Dm1.tt1.fields[39].asfloat;
End;
Procedure O_Amb.Set_resaE(Par:REAL);
Begin
Dm1.tt1.fields[39].asfloat:=Par;
End;
Function O_Amb.TotE:REAL;
Begin
result:=Dm1.tt1.fields[40].asfloat;
End;
Procedure O_Amb.Set_TotE(Par:REAL);
Begin
Dm1.tt1.fields[40].asfloat:=Par;
End;
Function O_Amb.TotI:REAL;
Begin
result:=Dm1.tt1.fields[41].asfloat;
End;
Procedure O_Amb.Set_TotI(Par:REAL);
Begin
Dm1.tt1.fields[41].asfloat:=Par;
End;
{*************************************************************}
Function O_RecPar.Lato:STRING;
Begin
result:=Dm1.tt3.fields[2].asstring;
End;
Procedure O_RecPar.Set_Lato(Par:STRING);
Begin
Dm1.tt3.fields[2].asstring:=Par;
End;
Function O_RecPar.Tipo:STRING;
Begin
result:=Dm1.tt3.fields[3].asstring;
End;
Procedure O_RecPar.Set_Tipo(Par:STRING);
Begin
Dm1.tt3.fields[3].asstring:=Par;
End;
Function O_RecPar.Cod:STRING;
Begin
result:=Dm1.tt3.fields[4].asstring;
End;
Procedure O_RecPar.Set_Cod(Par:STRING);
Begin
Dm1.tt3.fields[4].asstring:=Par;
End;
Function O_RecPar.Num:REAL;
Begin
result:=Dm1.tt3.fields[5].asfloat;
End;
Procedure O_RecPar.Set_Num(Par:REAL);
Begin
Dm1.tt3.fields[5].asfloat:=Par;
End;
Function O_RecPar.Sup:REAL;
Begin
result:=Dm1.tt3.fields[6].asfloat;
End;
Procedure O_RecPar.Set_Sup(Par:REAL);
Begin
Dm1.tt3.fields[6].asfloat:=Par;
End;
{*************************************************************}
Function O_Recdef.POrtAp:REAL;
Begin
result:=Dm1.tt2.fields[0].asfloat;
End;
Procedure O_Recdef.Set_POrtAp(Par:REAL);
Begin
Dm1.tt2.fields[0].asfloat:=Par;
End;
Function O_Recdef.Alt:REAL;
Begin
result:=Dm1.tt2.fields[1].asfloat;
End;
Procedure O_Recdef.Set_Alt(Par:REAL);
Begin
Dm1.tt2.fields[1].asfloat:=Par;
End;
Function O_Recdef.TiI:REAL;
Begin
result:=Dm1.tt2.fields[2].asfloat;
End;
Procedure O_Recdef.Set_TiI(Par:REAL);
Begin
Dm1.tt2.fields[2].asfloat:=Par;
End;
Function O_Recdef.URI:REAL;
Begin
result:=Dm1.tt2.fields[3].asfloat;
End;
Procedure O_Recdef.Set_URI(Par:REAL);
Begin
Dm1.tt2.fields[3].asfloat:=Par;
End;
Function O_Recdef.ITmaria:REAL;
Begin
result:=Dm1.tt2.fields[4].asfloat;
End;
Procedure O_Recdef.Set_ITmaria(Par:REAL);
Begin
Dm1.tt2.fields[4].asfloat:=Par;
End;
Function O_Recdef.ITmacq:REAL;
Begin
result:=Dm1.tt2.fields[5].asfloat;
End;
Procedure O_Recdef.Set_ITmacq(Par:REAL);
Begin
Dm1.tt2.fields[5].asfloat:=Par;
End;
Function O_Recdef.ITracq:REAL;
Begin
result:=Dm1.tt2.fields[6].asfloat;
End;
Procedure O_Recdef.Set_ITracq(Par:REAL);
Begin
Dm1.tt2.fields[6].asfloat:=Par;
End;
Function O_Recdef.TiE:REAL;
Begin
result:=Dm1.tt2.fields[7].asfloat;
End;
Procedure O_Recdef.Set_TiE(Par:REAL);
Begin
Dm1.tt2.fields[7].asfloat:=Par;
End;
Function O_Recdef.URE:REAL;
Begin
result:=Dm1.tt2.fields[8].asfloat;
End;
Procedure O_Recdef.Set_URE(Par:REAL);
Begin
Dm1.tt2.fields[8].asfloat:=Par;
End;
Function O_Recdef.ETmaria:REAL;
Begin
result:=Dm1.tt2.fields[9].asfloat;
End;
Procedure O_Recdef.Set_ETmaria(Par:REAL);
Begin
Dm1.tt2.fields[9].asfloat:=Par;
End;
Function O_Recdef.ETmacq:REAL;
Begin
result:=Dm1.tt2.fields[10].asfloat;
End;
Procedure O_Recdef.Set_ETmacq(Par:REAL);
Begin
Dm1.tt2.fields[10].asfloat:=Par;
End;
Function O_Recdef.ETracq:REAL;
Begin
result:=Dm1.tt2.fields[11].asfloat;
End;
Procedure O_Recdef.Set_ETracq(Par:REAL);
Begin
Dm1.tt2.fields[11].asfloat:=Par;
End;
{*************************************************************}
Function O_Recgen.Data:STRING;
Begin
result:=Dm1.tt2.fields[0].asstring;
End;
Procedure O_Recgen.Set_Data(Par:STRING);
Begin
Dm1.tt2.fields[0].asstring:=Par;
End;
Function O_Recgen.Codice:STRING;
Begin
result:=Dm1.tt2.fields[1].asstring;
End;
Procedure O_Recgen.Set_Codice(Par:STRING);
Begin
Dm1.tt2.fields[1].asstring:=Par;
End;
Function O_Recgen.Committente:STRING;
Begin
result:=Dm1.tt2.fields[2].asstring;
End;
Procedure O_Recgen.Set_Committente(Par:STRING);
Begin
Dm1.tt2.fields[2].asstring:=Par;
End;
Function O_Recgen.Commessa:STRING;
Begin
result:=Dm1.tt2.fields[3].asstring;
End;
Procedure O_Recgen.Set_Commessa(Par:STRING);
Begin
Dm1.tt2.fields[3].asstring:=Par;
End;
Function O_Recgen.Impianto:STRING;
Begin
result:=Dm1.tt2.fields[4].asstring;
End;
Procedure O_Recgen.Set_Impianto(Par:STRING);
Begin
Dm1.tt2.fields[4].asstring:=Par;
End;
Function O_Recgen.Progettista:STRING;
Begin
result:=Dm1.tt2.fields[5].asstring;
End;
Procedure O_Recgen.Set_Progettista(Par:STRING);
Begin
Dm1.tt2.fields[5].asstring:=Par;
End;
Function O_Recgen.localita:STRING;
Begin
result:=Dm1.tt2.fields[6].asstring;
End;
Procedure O_Recgen.Set_localita(Par:STRING);
Begin
Dm1.tt2.fields[6].asstring:=Par;
End;
Function O_Recgen.TestInv:REAL;
Begin
result:=Dm1.tt2.fields[7].asfloat;
End;
Procedure O_Recgen.Set_TestInv(Par:REAL);
Begin
Dm1.tt2.fields[7].asfloat:=Par;
End;
Function O_Recgen.TestEst:REAL;
Begin
result:=Dm1.tt2.fields[8].asfloat;
End;
Procedure O_Recgen.Set_TestEst(Par:REAL);
Begin
Dm1.tt2.fields[8].asfloat:=Par;
End;
{*************************************************************}
Function O_RecMuri.Cod:STRING;
Begin
result:=Dm1.tt4.fields[0].asstring;
End;
Procedure O_RecMuri.Set_Cod(Par:STRING);
Begin
Dm1.tt4.fields[0].asstring:=Par;
End;
Function O_RecMuri.Descr:STRING;
Begin
result:=Dm1.tt4.fields[1].asstring;
End;
Procedure O_RecMuri.Set_Descr(Par:STRING);
Begin
Dm1.tt4.fields[1].asstring:=Par;
End;
Function O_RecMuri.K:REAL;
Begin
result:=Dm1.tt4.fields[2].asfloat;
End;
Procedure O_RecMuri.Set_K(Par:REAL);
Begin
Dm1.tt4.fields[2].asfloat:=Par;
End;
{*************************************************************}
Function O_RecFin.Cod:STRING;
Begin
result:=Dm1.tt4.fields[0].asstring;
End;
Procedure O_RecFin.Set_Cod(Par:STRING);
Begin
Dm1.tt4.fields[0].asstring:=Par;
End;
Function O_RecFin.Descr:STRING;
Begin
result:=Dm1.tt4.fields[1].asstring;
End;
Procedure O_RecFin.Set_Descr(Par:STRING);
Begin
Dm1.tt4.fields[1].asstring:=Par;
End;
Function O_RecFin.SupUn:REAL;
Begin
result:=Dm1.tt4.fields[2].asfloat;
End;
Procedure O_RecFin.Set_SupUn(Par:REAL);
Begin
Dm1.tt4.fields[2].asfloat:=Par;
End;
Function O_RecFin.K:REAL;
Begin
result:=Dm1.tt4.fields[3].asfloat;
End;
Procedure O_RecFin.Set_K(Par:REAL);
Begin
Dm1.tt4.fields[3].asfloat:=Par;
End;
Function O_RecFin.AttSol:REAL;
Begin
result:=Dm1.tt4.fields[4].asfloat;
End;
Procedure O_RecFin.Set_AttSol(Par:REAL);
Begin
Dm1.tt4.fields[4].asfloat:=Par;
End;
{*************************************************************}
Function O_RecEsp.Cod:STRING;
Begin
result:=Dm1.tt4.fields[0].asstring;
End;
Procedure O_RecEsp.Set_Cod(Par:STRING);
Begin
Dm1.tt4.fields[0].asstring:=Par;
End;
Function O_RecEsp.Descr:STRING;
Begin
result:=Dm1.tt4.fields[1].asstring;
End;
Procedure O_RecEsp.Set_Descr(Par:STRING);
Begin
Dm1.tt4.fields[1].asstring:=Par;
End;
Function O_RecEsp.Tipo:STRING;
Begin
result:=Dm1.tt4.fields[2].asstring;
End;
Procedure O_RecEsp.Set_Tipo(Par:STRING);
Begin
Dm1.tt4.fields[2].asstring:=Par;
End;
Function O_RecEsp.Incl:REAL;
Begin
result:=Dm1.tt4.fields[3].asfloat;
End;
Procedure O_RecEsp.Set_Incl(Par:REAL);
Begin
Dm1.tt4.fields[3].asfloat:=Par;
End;
Function O_RecEsp.TLcI:REAL;
Begin
result:=Dm1.tt4.fields[4].asfloat;
End;
Procedure O_RecEsp.Set_TLcI(Par:REAL);
Begin
Dm1.tt4.fields[4].asfloat:=Par;
End;
Function O_RecEsp.TLcE:REAL;
Begin
result:=Dm1.tt4.fields[5].asfloat;
End;
Procedure O_RecEsp.Set_TLcE(Par:REAL);
Begin
Dm1.tt4.fields[5].asfloat:=Par;
End;
