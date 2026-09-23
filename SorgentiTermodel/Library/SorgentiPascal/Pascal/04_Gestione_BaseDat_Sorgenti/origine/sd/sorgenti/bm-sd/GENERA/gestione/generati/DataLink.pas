{*************************************************************}
Function O_RecCampi.Codice:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[2].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[2].asstring
else result:=Dm1.tt3.fields[2].asstring;
End;
Procedure O_RecCampi.Set_Codice(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[2].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[2].asstring:=Par
else Dm1.tt3.fields[2].asstring:=Par;
End;
Function O_RecCampi.Lunga:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[3].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[3].asstring
else result:=Dm1.tt3.fields[3].asstring;
End;
Procedure O_RecCampi.Set_Lunga(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[3].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[3].asstring:=Par
else Dm1.tt3.fields[3].asstring:=Par;
End;
Function O_RecCampi.Tipo:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[4].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[4].asstring
else result:=Dm1.tt3.fields[4].asstring;
End;
Procedure O_RecCampi.Set_Tipo(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[4].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[4].asstring:=Par
else Dm1.tt3.fields[4].asstring:=Par;
End;
Function O_RecCampi.LungCar:INTEGER;
Begin
If Tab0 then result:=Dm1.tt0.fields[5].asinteger
else If TabT Then result:=DmTutti.t_Campi.fields[5].asinteger
else result:=Dm1.tt3.fields[5].asinteger;
End;
Procedure O_RecCampi.Set_LungCar(Par:INTEGER);
Begin
If Tab0 then Dm1.tt0.fields[5].asinteger:=Par
else If TabT then DmTutti.t_Campi.fields[5].asinteger:=Par
else Dm1.tt3.fields[5].asinteger:=Par;
End;
Function O_RecCampi.Tag:INTEGER;
Begin
If Tab0 then result:=Dm1.tt0.fields[6].asinteger
else If TabT Then result:=DmTutti.t_Campi.fields[6].asinteger
else result:=Dm1.tt3.fields[6].asinteger;
End;
Procedure O_RecCampi.Set_Tag(Par:INTEGER);
Begin
If Tab0 then Dm1.tt0.fields[6].asinteger:=Par
else If TabT then DmTutti.t_Campi.fields[6].asinteger:=Par
else Dm1.tt3.fields[6].asinteger:=Par;
End;
Function O_RecCampi.TipoCampo:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[7].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[7].asstring
else result:=Dm1.tt3.fields[7].asstring;
End;
Procedure O_RecCampi.Set_TipoCampo(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[7].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[7].asstring:=Par
else Dm1.tt3.fields[7].asstring:=Par;
End;
Function O_RecCampi.Griglia:INTEGER;
Begin
If Tab0 then result:=Dm1.tt0.fields[8].asinteger
else If TabT Then result:=DmTutti.t_Campi.fields[8].asinteger
else result:=Dm1.tt3.fields[8].asinteger;
End;
Procedure O_RecCampi.Set_Griglia(Par:INTEGER);
Begin
If Tab0 then Dm1.tt0.fields[8].asinteger:=Par
else If TabT then DmTutti.t_Campi.fields[8].asinteger:=Par
else Dm1.tt3.fields[8].asinteger:=Par;
End;
Function O_RecCampi.LookUp:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[9].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[9].asstring
else result:=Dm1.tt3.fields[9].asstring;
End;
Procedure O_RecCampi.Set_LookUp(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[9].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[9].asstring:=Par
else Dm1.tt3.fields[9].asstring:=Par;
End;
Function O_RecCampi.CampoLookUp:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[10].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[10].asstring
else result:=Dm1.tt3.fields[10].asstring;
End;
Procedure O_RecCampi.Set_CampoLookUp(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[10].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[10].asstring:=Par
else Dm1.tt3.fields[10].asstring:=Par;
End;
Function O_RecCampi.Combo1:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[11].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[11].asstring
else result:=Dm1.tt3.fields[11].asstring;
End;
Procedure O_RecCampi.Set_Combo1(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[11].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[11].asstring:=Par
else Dm1.tt3.fields[11].asstring:=Par;
End;
Function O_RecCampi.Combo2:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[12].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[12].asstring
else result:=Dm1.tt3.fields[12].asstring;
End;
Procedure O_RecCampi.Set_Combo2(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[12].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[12].asstring:=Par
else Dm1.tt3.fields[12].asstring:=Par;
End;
Function O_RecCampi.Combo3:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[13].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[13].asstring
else result:=Dm1.tt3.fields[13].asstring;
End;
Procedure O_RecCampi.Set_Combo3(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[13].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[13].asstring:=Par
else Dm1.tt3.fields[13].asstring:=Par;
End;
Function O_RecCampi.Combo4:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[14].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[14].asstring
else result:=Dm1.tt3.fields[14].asstring;
End;
Procedure O_RecCampi.Set_Combo4(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[14].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[14].asstring:=Par
else Dm1.tt3.fields[14].asstring:=Par;
End;
Function O_RecCampi.Combo5:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[15].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[15].asstring
else result:=Dm1.tt3.fields[15].asstring;
End;
Procedure O_RecCampi.Set_Combo5(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[15].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[15].asstring:=Par
else Dm1.tt3.fields[15].asstring:=Par;
End;
Function O_RecCampi.Combo6:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[16].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[16].asstring
else result:=Dm1.tt3.fields[16].asstring;
End;
Procedure O_RecCampi.Set_Combo6(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[16].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[16].asstring:=Par
else Dm1.tt3.fields[16].asstring:=Par;
End;
Function O_RecCampi.Combo7:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[17].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[17].asstring
else result:=Dm1.tt3.fields[17].asstring;
End;
Procedure O_RecCampi.Set_Combo7(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[17].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[17].asstring:=Par
else Dm1.tt3.fields[17].asstring:=Par;
End;
Function O_RecCampi.Combo8:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[18].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[18].asstring
else result:=Dm1.tt3.fields[18].asstring;
End;
Procedure O_RecCampi.Set_Combo8(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[18].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[18].asstring:=Par
else Dm1.tt3.fields[18].asstring:=Par;
End;
Function O_RecCampi.Combo9:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[19].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[19].asstring
else result:=Dm1.tt3.fields[19].asstring;
End;
Procedure O_RecCampi.Set_Combo9(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[19].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[19].asstring:=Par
else Dm1.tt3.fields[19].asstring:=Par;
End;
Function O_RecCampi.Combo10:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[20].asstring
else If TabT Then result:=DmTutti.t_Campi.fields[20].asstring
else result:=Dm1.tt3.fields[20].asstring;
End;
Procedure O_RecCampi.Set_Combo10(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[20].asstring:=Par
else If TabT then DmTutti.t_Campi.fields[20].asstring:=Par
else Dm1.tt3.fields[20].asstring:=Par;
End;
{*************************************************************}
Function O_TabRec.Num:INTEGER;
Begin
If Tab0 then result:=Dm1.tt0.fields[0].asinteger
else If TabT Then result:=DmTutti.t_Rec.fields[0].asinteger
else result:=Dm1.tt1.fields[0].asinteger;
End;
Procedure O_TabRec.Set_Num(Par:INTEGER);
Begin
If Tab0 then Dm1.tt0.fields[0].asinteger:=Par
else If TabT then DmTutti.t_Rec.fields[0].asinteger:=Par
else Dm1.tt1.fields[0].asinteger:=Par;
End;
Function O_TabRec.Codice:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[1].asstring
else If TabT Then result:=DmTutti.t_Rec.fields[1].asstring
else result:=Dm1.tt1.fields[1].asstring;
End;
Procedure O_TabRec.Set_Codice(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[1].asstring:=Par
else If TabT then DmTutti.t_Rec.fields[1].asstring:=Par
else Dm1.tt1.fields[1].asstring:=Par;
End;
Function O_TabRec.Descrizione:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[2].asstring
else If TabT Then result:=DmTutti.t_Rec.fields[2].asstring
else result:=Dm1.tt1.fields[2].asstring;
End;
Procedure O_TabRec.Set_Descrizione(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[2].asstring:=Par
else If TabT then DmTutti.t_Rec.fields[2].asstring:=Par
else Dm1.tt1.fields[2].asstring:=Par;
End;
Function O_TabRec.Massimo:INTEGER;
Begin
If Tab0 then result:=Dm1.tt0.fields[3].asinteger
else If TabT Then result:=DmTutti.t_Rec.fields[3].asinteger
else result:=Dm1.tt1.fields[3].asinteger;
End;
Procedure O_TabRec.Set_Massimo(Par:INTEGER);
Begin
If Tab0 then Dm1.tt0.fields[3].asinteger:=Par
else If TabT then DmTutti.t_Rec.fields[3].asinteger:=Par
else Dm1.tt1.fields[3].asinteger:=Par;
End;
Function O_TabRec.Tipo:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[4].asstring
else If TabT Then result:=DmTutti.t_Rec.fields[4].asstring
else result:=Dm1.tt1.fields[4].asstring;
End;
Procedure O_TabRec.Set_Tipo(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[4].asstring:=Par
else If TabT then DmTutti.t_Rec.fields[4].asstring:=Par
else Dm1.tt1.fields[4].asstring:=Par;
End;
Function O_TabRec.Associato:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[5].asstring
else If TabT Then result:=DmTutti.t_Rec.fields[5].asstring
else result:=Dm1.tt1.fields[5].asstring;
End;
Procedure O_TabRec.Set_Associato(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[5].asstring:=Par
else If TabT then DmTutti.t_Rec.fields[5].asstring:=Par
else Dm1.tt1.fields[5].asstring:=Par;
End;
Function O_TabRec.Menu:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[6].asstring
else If TabT Then result:=DmTutti.t_Rec.fields[6].asstring
else result:=Dm1.tt1.fields[6].asstring;
End;
Procedure O_TabRec.Set_Menu(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[6].asstring:=Par
else If TabT then DmTutti.t_Rec.fields[6].asstring:=Par
else Dm1.tt1.fields[6].asstring:=Par;
End;
Function O_TabRec.Aggiorna:STRING;
Begin
If Tab0 then result:=Dm1.tt0.fields[7].asstring
else If TabT Then result:=DmTutti.t_Rec.fields[7].asstring
else result:=Dm1.tt1.fields[7].asstring;
End;
Procedure O_TabRec.Set_Aggiorna(Par:STRING);
Begin
If Tab0 then Dm1.tt0.fields[7].asstring:=Par
else If TabT then DmTutti.t_Rec.fields[7].asstring:=Par
else Dm1.tt1.fields[7].asstring:=Par;
End;
