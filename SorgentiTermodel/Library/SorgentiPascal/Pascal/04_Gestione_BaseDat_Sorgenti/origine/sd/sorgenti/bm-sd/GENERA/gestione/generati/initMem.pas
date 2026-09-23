Procedure initMem(Nome:String;ind,ind2:integer);
Begin
Nome:=Upstring(nome);
If Nome='CAMPI' Then
  Begin
  exit;
  End;
If Nome='REC' Then
  Begin
  Rec_D^[Ind].Num:=0;
  Rec_D^[Ind].Codice:='';
  Rec_D^[Ind].Descrizione:='';
  Rec_D^[Ind].Massimo:=0;
  Rec_D^[Ind].Massimo:=100;
  Rec_D^[Ind].Tipo:='';
  Rec_D^[Ind].Tipo:='Archivio semplice';
  Rec_D^[Ind].Tipo:='Elenco';
  Rec_D^[Ind].Associato:='';
  Rec_D^[Ind].Menu:='';
  Rec_D^[Ind].Aggiorna:='';
  exit;
  End;
End;
