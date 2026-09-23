{*************************************************************}
Procedure Leggi_Radiatori(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Radiatori.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Rad_D^[i] do
    Begin
    Grand:=tabella1.fields[0].asstring;
    Resa:=tabella1.fields[1].asfloat;
    end;
  Tabella1.Next;
  end;
NRad:=i;
end;
{*************************************************************}
Procedure Leggi_Fancoil(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Fancoil.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Fan_D^[i] do
    Begin
    Grand:=tabella1.fields[0].asstring;
    EPotsens:=tabella1.fields[1].asfloat;
    EPotTot:=tabella1.fields[2].asfloat;
    EPortH2o:=tabella1.fields[3].asfloat;
    EPerdH2o:=tabella1.fields[4].asfloat;
    IPortH2o:=tabella1.fields[5].asfloat;
    IPotsens:=tabella1.fields[6].asfloat;
    IPerdH2o:=tabella1.fields[7].asfloat;
    end;
  Tabella1.Next;
  end;
NFan:=i;
end;
{*************************************************************}
Procedure Leggi_Vuoto(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Vuoto.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Vuoto_D^[i] do
    Begin
    Faitu:=tabella1.fields[0].asstring;
    end;
  Tabella1.Next;
  end;
NVuoto:=i;
end;
{*************************************************************}
Procedure Leggi_Terminale(var Tabella1:TTable;var Tabella3:TTable);
Begin
Tabella1.close;
Tabella1.tablename:='Terminale.DB';
Tabella1.open;
Tabella1.first;
  with Terminali_D^ do
    Begin
    Fab:=tabella1.fields[0].asstring;
    Modello:=tabella1.fields[1].asstring;
    Grand:=tabella1.fields[2].asstring;
    ETbs:=tabella1.fields[3].asfloat;
    ETbu:=tabella1.fields[4].asfloat;
    ITbs:=tabella1.fields[5].asfloat;
    EPsens:=tabella1.fields[6].asfloat;
    IPsens:=tabella1.fields[7].asfloat;
    EPTot:=tabella1.fields[8].asfloat;
    EInH2o:=tabella1.fields[9].asfloat;
    EDt:=tabella1.fields[10].asfloat;
    EPort:=tabella1.fields[11].asfloat;
    EDP:=tabella1.fields[12].asfloat;
    IInH2o:=tabella1.fields[13].asfloat;
    IDt:=tabella1.fields[14].asfloat;
    IPort:=tabella1.fields[15].asfloat;
    IDP:=tabella1.fields[16].asfloat;
    end;
end;
