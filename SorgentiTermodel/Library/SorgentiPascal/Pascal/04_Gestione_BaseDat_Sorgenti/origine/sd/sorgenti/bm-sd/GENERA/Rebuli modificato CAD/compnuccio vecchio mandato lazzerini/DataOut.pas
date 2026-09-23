{*************************************************************}
Procedure Salva_Radiatori(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_Radiatori(Tabella1);
For i:=1 to NRad Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Rad_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Grand;
    tabella1.fields[1].asfloat:=Resa;
    Tabella1.POst;
    end;
  end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_Fancoil(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_Fancoil(Tabella1);
For i:=1 to NFan Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Fan_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Grand;
    tabella1.fields[1].asfloat:=EPotsens;
    tabella1.fields[2].asfloat:=EPotTot;
    tabella1.fields[3].asfloat:=EPortH2o;
    tabella1.fields[4].asfloat:=EPerdH2o;
    tabella1.fields[5].asfloat:=IPortH2o;
    tabella1.fields[6].asfloat:=IPotsens;
    tabella1.fields[7].asfloat:=IPerdH2o;
    Tabella1.POst;
    end;
  end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_Vuoto(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_Vuoto(Tabella1);
For i:=1 to NVuoto Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Vuoto_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Faitu;
    Tabella1.POst;
    end;
  end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_Terminale(var Tabella1,Tabella3:TTable);
Begin
Crea_Terminale(Tabella1);
  Tabella1.append;
  Tabella1.edit;
  with Terminali_D^ do
    Begin
    tabella1.fields[0].asstring:=Fab;
    tabella1.fields[1].asstring:=Modello;
    tabella1.fields[2].asstring:=Grand;
    tabella1.fields[3].asfloat:=ETbs;
    tabella1.fields[4].asfloat:=ETbu;
    tabella1.fields[5].asfloat:=ITbs;
    tabella1.fields[6].asfloat:=EPsens;
    tabella1.fields[7].asfloat:=IPsens;
    tabella1.fields[8].asfloat:=EPTot;
    tabella1.fields[9].asfloat:=EInH2o;
    tabella1.fields[10].asfloat:=EDt;
    tabella1.fields[11].asfloat:=EPort;
    tabella1.fields[12].asfloat:=EDP;
    tabella1.fields[13].asfloat:=IInH2o;
    tabella1.fields[14].asfloat:=IDt;
    tabella1.fields[15].asfloat:=IPort;
    tabella1.fields[16].asfloat:=IDP;
    Tabella1.POst;
    end;
Tabella1.refresh;
end;
