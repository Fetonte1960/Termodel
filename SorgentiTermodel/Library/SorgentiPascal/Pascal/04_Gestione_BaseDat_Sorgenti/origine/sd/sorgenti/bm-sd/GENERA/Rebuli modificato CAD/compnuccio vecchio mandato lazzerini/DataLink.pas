{*************************************************************}
Function O_RecRad.Grand:STRING;
Begin
result:=Dm1.tt1.fields[0].asstring;
End;
Procedure O_RecRad.Set_Grand(Par:STRING);
Begin
Dm1.tt1.fields[0].asstring:=Par;
End;
Function O_RecRad.Resa:REAL;
Begin
result:=Dm1.tt1.fields[1].asfloat;
End;
Procedure O_RecRad.Set_Resa(Par:REAL);
Begin
Dm1.tt1.fields[1].asfloat:=Par;
End;
{*************************************************************}
Function O_RecFan.Grand:STRING;
Begin
result:=Dm1.tt1.fields[0].asstring;
End;
Procedure O_RecFan.Set_Grand(Par:STRING);
Begin
Dm1.tt1.fields[0].asstring:=Par;
End;
Function O_RecFan.EPotsens:REAL;
Begin
result:=Dm1.tt1.fields[1].asfloat;
End;
Procedure O_RecFan.Set_EPotsens(Par:REAL);
Begin
Dm1.tt1.fields[1].asfloat:=Par;
End;
Function O_RecFan.EPotTot:REAL;
Begin
result:=Dm1.tt1.fields[2].asfloat;
End;
Procedure O_RecFan.Set_EPotTot(Par:REAL);
Begin
Dm1.tt1.fields[2].asfloat:=Par;
End;
Function O_RecFan.EPortH2o:REAL;
Begin
result:=Dm1.tt1.fields[3].asfloat;
End;
Procedure O_RecFan.Set_EPortH2o(Par:REAL);
Begin
Dm1.tt1.fields[3].asfloat:=Par;
End;
Function O_RecFan.EPerdH2o:REAL;
Begin
result:=Dm1.tt1.fields[4].asfloat;
End;
Procedure O_RecFan.Set_EPerdH2o(Par:REAL);
Begin
Dm1.tt1.fields[4].asfloat:=Par;
End;
Function O_RecFan.IPortH2o:REAL;
Begin
result:=Dm1.tt1.fields[5].asfloat;
End;
Procedure O_RecFan.Set_IPortH2o(Par:REAL);
Begin
Dm1.tt1.fields[5].asfloat:=Par;
End;
Function O_RecFan.IPotsens:REAL;
Begin
result:=Dm1.tt1.fields[6].asfloat;
End;
Procedure O_RecFan.Set_IPotsens(Par:REAL);
Begin
Dm1.tt1.fields[6].asfloat:=Par;
End;
Function O_RecFan.IPerdH2o:REAL;
Begin
result:=Dm1.tt1.fields[7].asfloat;
End;
Procedure O_RecFan.Set_IPerdH2o(Par:REAL);
Begin
Dm1.tt1.fields[7].asfloat:=Par;
End;
{*************************************************************}
Function O_RecVuoto.Faitu:STRING;
Begin
result:=Dm1.tt1.fields[0].asstring;
End;
Procedure O_RecVuoto.Set_Faitu(Par:STRING);
Begin
Dm1.tt1.fields[0].asstring:=Par;
End;
{*************************************************************}
Function O_RecTerm.Fab:STRING;
Begin
result:=Dm1.tt1.fields[0].asstring;
End;
Procedure O_RecTerm.Set_Fab(Par:STRING);
Begin
Dm1.tt1.fields[0].asstring:=Par;
End;
Function O_RecTerm.Modello:STRING;
Begin
result:=Dm1.tt1.fields[1].asstring;
End;
Procedure O_RecTerm.Set_Modello(Par:STRING);
Begin
Dm1.tt1.fields[1].asstring:=Par;
End;
Function O_RecTerm.Grand:STRING;
Begin
result:=Dm1.tt1.fields[2].asstring;
End;
Procedure O_RecTerm.Set_Grand(Par:STRING);
Begin
Dm1.tt1.fields[2].asstring:=Par;
End;
Function O_RecTerm.ETbs:REAL;
Begin
result:=Dm1.tt1.fields[3].asfloat;
End;
Procedure O_RecTerm.Set_ETbs(Par:REAL);
Begin
Dm1.tt1.fields[3].asfloat:=Par;
End;
Function O_RecTerm.ETbu:REAL;
Begin
result:=Dm1.tt1.fields[4].asfloat;
End;
Procedure O_RecTerm.Set_ETbu(Par:REAL);
Begin
Dm1.tt1.fields[4].asfloat:=Par;
End;
Function O_RecTerm.ITbs:REAL;
Begin
result:=Dm1.tt1.fields[5].asfloat;
End;
Procedure O_RecTerm.Set_ITbs(Par:REAL);
Begin
Dm1.tt1.fields[5].asfloat:=Par;
End;
Function O_RecTerm.EPsens:REAL;
Begin
result:=Dm1.tt1.fields[6].asfloat;
End;
Procedure O_RecTerm.Set_EPsens(Par:REAL);
Begin
Dm1.tt1.fields[6].asfloat:=Par;
End;
Function O_RecTerm.IPsens:REAL;
Begin
result:=Dm1.tt1.fields[7].asfloat;
End;
Procedure O_RecTerm.Set_IPsens(Par:REAL);
Begin
Dm1.tt1.fields[7].asfloat:=Par;
End;
Function O_RecTerm.EPTot:REAL;
Begin
result:=Dm1.tt1.fields[8].asfloat;
End;
Procedure O_RecTerm.Set_EPTot(Par:REAL);
Begin
Dm1.tt1.fields[8].asfloat:=Par;
End;
Function O_RecTerm.EInH2o:REAL;
Begin
result:=Dm1.tt1.fields[9].asfloat;
End;
Procedure O_RecTerm.Set_EInH2o(Par:REAL);
Begin
Dm1.tt1.fields[9].asfloat:=Par;
End;
Function O_RecTerm.EDt:REAL;
Begin
result:=Dm1.tt1.fields[10].asfloat;
End;
Procedure O_RecTerm.Set_EDt(Par:REAL);
Begin
Dm1.tt1.fields[10].asfloat:=Par;
End;
Function O_RecTerm.EPort:REAL;
Begin
result:=Dm1.tt1.fields[11].asfloat;
End;
Procedure O_RecTerm.Set_EPort(Par:REAL);
Begin
Dm1.tt1.fields[11].asfloat:=Par;
End;
Function O_RecTerm.EDP:REAL;
Begin
result:=Dm1.tt1.fields[12].asfloat;
End;
Procedure O_RecTerm.Set_EDP(Par:REAL);
Begin
Dm1.tt1.fields[12].asfloat:=Par;
End;
Function O_RecTerm.IInH2o:REAL;
Begin
result:=Dm1.tt1.fields[13].asfloat;
End;
Procedure O_RecTerm.Set_IInH2o(Par:REAL);
Begin
Dm1.tt1.fields[13].asfloat:=Par;
End;
Function O_RecTerm.IDt:REAL;
Begin
result:=Dm1.tt1.fields[14].asfloat;
End;
Procedure O_RecTerm.Set_IDt(Par:REAL);
Begin
Dm1.tt1.fields[14].asfloat:=Par;
End;
Function O_RecTerm.IPort:REAL;
Begin
result:=Dm1.tt1.fields[15].asfloat;
End;
Procedure O_RecTerm.Set_IPort(Par:REAL);
Begin
Dm1.tt1.fields[15].asfloat:=Par;
End;
Function O_RecTerm.IDP:REAL;
Begin
result:=Dm1.tt1.fields[16].asfloat;
End;
Procedure O_RecTerm.Set_IDP(Par:REAL);
Begin
Dm1.tt1.fields[16].asfloat:=Par;
End;
