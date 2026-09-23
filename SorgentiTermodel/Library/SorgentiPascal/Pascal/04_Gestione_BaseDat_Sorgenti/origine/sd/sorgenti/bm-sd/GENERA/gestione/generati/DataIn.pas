{*************************************************************}
Procedure Leggi_Campi(var Tabella1:TTable;Var arr:Ar_RecCampi;Var i:Integer);
Begin
i:=0;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with arr[i] do
    Begin
    Codice:=tabella1.fields[2].asstring;
    Lunga:=tabella1.fields[3].asstring;
    Tipo:=tabella1.fields[4].asstring;
    LungCar:=tabella1.fields[5].asinteger;
    Tag:=tabella1.fields[6].asinteger;
    TipoCampo:=tabella1.fields[7].asstring;
    Griglia:=tabella1.fields[8].asinteger;
    LookUp:=tabella1.fields[9].asstring;
    CampoLookUp:=tabella1.fields[10].asstring;
    Combo1:=tabella1.fields[11].asstring;
    Combo2:=tabella1.fields[12].asstring;
    Combo3:=tabella1.fields[13].asstring;
    Combo4:=tabella1.fields[14].asstring;
    Combo5:=tabella1.fields[15].asstring;
    Combo6:=tabella1.fields[16].asstring;
    Combo7:=tabella1.fields[17].asstring;
    Combo8:=tabella1.fields[18].asstring;
    Combo9:=tabella1.fields[19].asstring;
    Combo10:=tabella1.fields[20].asstring;
    end;
  Tabella1.Next;
  end;
end;
{*************************************************************}
Procedure Leggi_Rec(var Tabella1:TTable;var Tabella3:TTable;DataS1:Tdatasource);
Var i:integer;
Begin
i:=0;
if Not FileExists(Tabella1.Databasename+'\Rec.DB') then
  Begin
  NRec:=i;
  Exit;
  End;
Tabella1.close;
Tabella1.tablename:='Rec.DB';
Tabella1.open;
Tabella3.close;
Tabella3.tablename:='Campi.DB';
Tabella3.Masterfields:='Numero';
Tabella3.IndexName:='PerNumero';
Tabella3.MasterSource:=Datas1;
Tabella3.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Rec_D^[i] do
    Begin
    Leggi_Campi(Tabella3,Campi,NCampi);
    Num:=tabella1.fields[0].asinteger;
    Codice:=tabella1.fields[1].asstring;
    Descrizione:=tabella1.fields[2].asstring;
    Massimo:=tabella1.fields[3].asinteger;
    Tipo:=tabella1.fields[4].asstring;
    Associato:=tabella1.fields[5].asstring;
    Menu:=tabella1.fields[6].asstring;
    Aggiorna:=tabella1.fields[7].asstring;
    end;
  Tabella1.Next;
  end;
NRec:=i;
If not tabT then
  begin
  Tabella3.Masterfields:='';
  Tabella3.IndexName:='';
  end;
end;
