Procedure initDb(Nome:String);
Begin
Nome:=Upstring(nome);
If Nome='CAMPI' Then
  Begin
  V_RecCampi.Set_Tipo('Intero');
  V_RecCampi.Set_Tipo('Caratteri');
  V_RecCampi.Set_LungCar(20);
  V_RecCampi.Set_TipoCampo('Normale');
  V_RecCampi.Set_TipoCampo('Normale');
  exit;
  End;
If Nome='REC' Then
  Begin
  V_TabRec.Set_Massimo(100);
  V_TabRec.Set_Tipo('Archivio semplice');
  V_TabRec.Set_Tipo('Elenco');
  exit;
  End;
End;
