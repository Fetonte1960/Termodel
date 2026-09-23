Procedure NuovoDb;
Begin
CreaDataBase('Campi');
dm1.tt1.Open;
dm1.tt1.append;
dm1.tt1.POst;
dm1.tt1.Close;
CreaDataBase('Rec');
End;
