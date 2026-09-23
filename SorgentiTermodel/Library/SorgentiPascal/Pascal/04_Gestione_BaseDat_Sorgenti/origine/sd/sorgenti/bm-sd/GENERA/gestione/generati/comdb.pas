  Case action of 
  Init:Begin
       dmtutti.T_Campi.databasename:=par;
       dmtutti.T_Campi.Tablename:='Campi.db';
       end;
  Nuovo:crea_Campi(T_Campi);
  Apri:Begin
       end;
  Chiudi:T_Campi.Close;
  end ;
  Case action of 
  Init:Begin
       dmtutti.T_Rec.databasename:=par;
       dmtutti.T_Rec.Tablename:='Rec.db';
       end;
  Nuovo:crea_Rec(T_Rec);
  Apri:Begin
       T_Rec.Open;
       T_Campi.mastersource:=DS_Rec;
       T_Campi.MasterFields:='Numero';
       T_Campi.IndexName:='PerNumero';
       T_Campi.Open;
       T_Rec.Open;
       end;
  Chiudi:T_Rec.Close;
  salva:SaveTxt_Rec(T_Rec,T_Campi,DS_Rec);
  end ;
