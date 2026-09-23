{*************************************************************}
Procedure Leggi_Ambienti(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Ambienti.DB';
Tabella1.open;
Tabella3.close;
Tabella3.tablename:='.DB';
Tabella3.Masterfields:='';
Tabella3.IndexName:='Per';
Tabella3.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Ambienti_D^[i] do
    Begin
    Leggi_(Tabella3,Par,);
    Num:=tabella1.fields[0].asinteger;
    Descr:=tabella1.fields[1].asstring;
    Direz:=tabella1.fields[2].asfloat;
    Tipo:=tabella1.fields[3].asstring;
    L:=tabella1.fields[4].asfloat;
    H:=tabella1.fields[5].asfloat;
    Alt:=tabella1.fields[6].asfloat;
    LQ1:=tabella1.fields[7].asfloat;
    HQ1:=tabella1.fields[8].asfloat;
    allinea:=tabella1.fields[9].asstring;
    NLamp:=tabella1.fields[10].asinteger;
    TLamp:=tabella1.fields[11].asinteger;
    LLamp1:=tabella1.fields[12].asfloat;
    HLamp1:=tabella1.fields[13].asfloat;
    SLamp:=tabella1.fields[14].asfloat;
    POtlamp:=tabella1.fields[15].asfloat;
    TPOtlamp:=tabella1.fields[16].asfloat;
    Irragg:=tabella1.fields[17].asfloat;
    Persone:=tabella1.fields[18].asfloat;
    AltriC:=tabella1.fields[19].asfloat;
    ETotSens:=tabella1.fields[20].asfloat;
    ITotSens:=tabella1.fields[21].asfloat;
    Slorda:=tabella1.fields[22].asfloat;
    Snetta:=tabella1.fields[23].asfloat;
    POrtAp:=tabella1.fields[24].asfloat;
    TiI:=tabella1.fields[25].asfloat;
    URI:=tabella1.fields[26].asfloat;
    ITmaria:=tabella1.fields[27].asfloat;
    ITmacq:=tabella1.fields[28].asfloat;
    ITracq:=tabella1.fields[29].asfloat;
    TiE:=tabella1.fields[30].asfloat;
    URE:=tabella1.fields[31].asfloat;
    ETmaria:=tabella1.fields[32].asfloat;
    ETmacq:=tabella1.fields[33].asfloat;
    ETracq:=tabella1.fields[34].asfloat;
    tp:=tabella1.fields[35].asinteger;
    DescrP:=tabella1.fields[36].asstring;
    ts:=tabella1.fields[37].asinteger;
    resaI:=tabella1.fields[38].asfloat;
    resaE:=tabella1.fields[39].asfloat;
    TotE:=tabella1.fields[40].asfloat;
    TotI:=tabella1.fields[41].asfloat;
    end;
  Tabella1.Next;
  end;
NAmb:=i;
end;
{*************************************************************}
Procedure Leggi_Pareti(var Tabella1:TTable;Var arr:Ar_RecPar;Var i:Integer);
Begin
i:=0;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with arr[i] do
    Begin
    Lato:=tabella1.fields[2].asstring;
    Tipo:=tabella1.fields[3].asstring;
    Cod:=tabella1.fields[4].asstring;
    Num:=tabella1.fields[5].asfloat;
    Sup:=tabella1.fields[6].asfloat;
    end;
  Tabella1.Next;
  end;
end;
{*************************************************************}
Procedure Leggi_default(var Tabella1:TTable;var Tabella3:TTable);
Begin
Tabella1.close;
Tabella1.tablename:='default.DB';
Tabella1.open;
Tabella1.first;
  with Default_D^ do
    Begin
    POrtAp:=tabella1.fields[0].asfloat;
    Alt:=tabella1.fields[1].asfloat;
    TiI:=tabella1.fields[2].asfloat;
    URI:=tabella1.fields[3].asfloat;
    ITmaria:=tabella1.fields[4].asfloat;
    ITmacq:=tabella1.fields[5].asfloat;
    ITracq:=tabella1.fields[6].asfloat;
    TiE:=tabella1.fields[7].asfloat;
    URE:=tabella1.fields[8].asfloat;
    ETmaria:=tabella1.fields[9].asfloat;
    ETmacq:=tabella1.fields[10].asfloat;
    ETracq:=tabella1.fields[11].asfloat;
    end;
end;
{*************************************************************}
Procedure Leggi_generalita(var Tabella1:TTable;var Tabella3:TTable);
Begin
Tabella1.close;
Tabella1.tablename:='generalita.DB';
Tabella1.open;
Tabella1.first;
  with Gen_D^ do
    Begin
    Data:=tabella1.fields[0].asstring;
    Codice:=tabella1.fields[1].asstring;
    Committente:=tabella1.fields[2].asstring;
    Commessa:=tabella1.fields[3].asstring;
    Impianto:=tabella1.fields[4].asstring;
    Progettista:=tabella1.fields[5].asstring;
    localita:=tabella1.fields[6].asstring;
    TestInv:=tabella1.fields[7].asfloat;
    TestEst:=tabella1.fields[8].asfloat;
    end;
end;
{*************************************************************}
Procedure Leggi_muri(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='muri.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Muri_D^[i] do
    Begin
    Cod:=tabella1.fields[0].asstring;
    Descr:=tabella1.fields[1].asstring;
    K:=tabella1.fields[2].asfloat;
    end;
  Tabella1.Next;
  end;
NMuri:=i;
end;
{*************************************************************}
Procedure Leggi_Finestre(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Finestre.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Finestre_D^[i] do
    Begin
    Cod:=tabella1.fields[0].asstring;
    Descr:=tabella1.fields[1].asstring;
    SupUn:=tabella1.fields[2].asfloat;
    K:=tabella1.fields[3].asfloat;
    AttSol:=tabella1.fields[4].asfloat;
    end;
  Tabella1.Next;
  end;
NFinestre:=i;
end;
{*************************************************************}
Procedure Leggi_Esposiz(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Esposiz.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Espos_D^[i] do
    Begin
    Cod:=tabella1.fields[0].asstring;
    Descr:=tabella1.fields[1].asstring;
    Tipo:=tabella1.fields[2].asstring;
    Incl:=tabella1.fields[3].asfloat;
    TLcI:=tabella1.fields[4].asfloat;
    TLcE:=tabella1.fields[5].asfloat;
    end;
  Tabella1.Next;
  end;
NEspos:=i;
end;
