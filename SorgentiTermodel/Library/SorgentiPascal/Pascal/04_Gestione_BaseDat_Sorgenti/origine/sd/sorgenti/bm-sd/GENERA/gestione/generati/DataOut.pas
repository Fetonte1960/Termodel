{*************************************************************}
Procedure Salva_Campi(var Tabella1:TTable;Var arr:Ar_RecCampi;Indmax:integer);
Var i:integer;
Begin
For i:=1 to Indmax Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with arr[i] do
    Begin
    tabella1.fields[2].asstring:=Codice;
    tabella1.fields[3].asstring:=Lunga;
    tabella1.fields[4].asstring:=Tipo;
    tabella1.fields[5].asinteger:=LungCar;
    tabella1.fields[6].asinteger:=Tag;
    tabella1.fields[7].asstring:=TipoCampo;
    tabella1.fields[8].asinteger:=Griglia;
    tabella1.fields[9].asstring:=LookUp;
    tabella1.fields[10].asstring:=CampoLookUp;
    tabella1.fields[11].asstring:=Combo1;
    tabella1.fields[12].asstring:=Combo2;
    tabella1.fields[13].asstring:=Combo3;
    tabella1.fields[14].asstring:=Combo4;
    tabella1.fields[15].asstring:=Combo5;
    tabella1.fields[16].asstring:=Combo6;
    tabella1.fields[17].asstring:=Combo7;
    tabella1.fields[18].asstring:=Combo8;
    tabella1.fields[19].asstring:=Combo9;
    tabella1.fields[20].asstring:=Combo10;
    Tabella1.POst;
    end;
  end;
end;
{*************************************************************}
Procedure Salva_Rec(var Tabella1,Tabella3:TTable;Var DataS1:Tdatasource);
Var i:integer;
Begin
Tabella3.Close;
CreaDatabase('Campi');
CreaDatabase('Rec');
  Tabella1.open;
Tabella3.close;
Tabella3.tablename:='Campi.DB';
Tabella3.Masterfields:='Numero';
Tabella3.IndexName:='PerNumero';
Tabella3.MasterSource:=Datas1;
Tabella3.open;
For i:=1 to NRec Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Rec_D^[i] do
    Begin
    tabella1.fields[1].asstring:=Codice;
    tabella1.fields[2].asstring:=Descrizione;
    tabella1.fields[3].asinteger:=Massimo;
    tabella1.fields[4].asstring:=Tipo;
    tabella1.fields[5].asstring:=Associato;
    tabella1.fields[6].asstring:=Menu;
    tabella1.fields[7].asstring:=Aggiorna;
    Tabella1.POst;
    Salva_Campi(Tabella3,Campi,NCampi);
    end;
  end;
if not Tabt then
  begin
  Tabella3.Masterfields:='';
  Tabella3.IndexName:='';
  end;
end;
