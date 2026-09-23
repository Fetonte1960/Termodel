{*************************************************************}
Procedure Salva_Ambienti(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_Ambienti(Tabella1);
Crea_(Tabella3);
For i:=1 to NAmb Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Ambienti_D^[i] do
    Begin
    tabella1.fields[0].asinteger:=Num;
    tabella1.fields[1].asstring:=Descr;
    tabella1.fields[2].asfloat:=Direz;
    tabella1.fields[3].asstring:=Tipo;
    tabella1.fields[4].asfloat:=L;
    tabella1.fields[5].asfloat:=H;
    tabella1.fields[6].asfloat:=Alt;
    tabella1.fields[7].asfloat:=LQ1;
    tabella1.fields[8].asfloat:=HQ1;
    tabella1.fields[9].asstring:=allinea;
    tabella1.fields[10].asinteger:=NLamp;
    tabella1.fields[11].asinteger:=TLamp;
    tabella1.fields[12].asfloat:=LLamp1;
    tabella1.fields[13].asfloat:=HLamp1;
    tabella1.fields[14].asfloat:=SLamp;
    tabella1.fields[15].asfloat:=POtlamp;
    tabella1.fields[16].asfloat:=TPOtlamp;
    tabella1.fields[17].asfloat:=Irragg;
    tabella1.fields[18].asfloat:=Persone;
    tabella1.fields[19].asfloat:=AltriC;
    tabella1.fields[20].asfloat:=ETotSens;
    tabella1.fields[21].asfloat:=ITotSens;
    tabella1.fields[22].asfloat:=Slorda;
    tabella1.fields[23].asfloat:=Snetta;
    tabella1.fields[24].asfloat:=POrtAp;
    tabella1.fields[25].asfloat:=TiI;
    tabella1.fields[26].asfloat:=URI;
    tabella1.fields[27].asfloat:=ITmaria;
    tabella1.fields[28].asfloat:=ITmacq;
    tabella1.fields[29].asfloat:=ITracq;
    tabella1.fields[30].asfloat:=TiE;
    tabella1.fields[31].asfloat:=URE;
    tabella1.fields[32].asfloat:=ETmaria;
    tabella1.fields[33].asfloat:=ETmacq;
    tabella1.fields[34].asfloat:=ETracq;
    tabella1.fields[35].asinteger:=tp;
    tabella1.fields[36].asstring:=DescrP;
    tabella1.fields[37].asinteger:=ts;
    tabella1.fields[38].asfloat:=resaI;
    tabella1.fields[39].asfloat:=resaE;
    tabella1.fields[40].asfloat:=TotE;
    tabella1.fields[41].asfloat:=TotI;
    Tabella1.POst;
    Salva_(Tabella3,Par,);
    end;
  end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_Pareti(var Tabella1:TTable;Var arr:Ar_RecPar;Indmax:integer);
Var i:integer;
Begin
For i:=1 to Indmax Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with arr[i] do
    Begin
    tabella1.fields[2].asstring:=Lato;
    tabella1.fields[3].asstring:=Tipo;
    tabella1.fields[4].asstring:=Cod;
    tabella1.fields[5].asfloat:=Num;
    tabella1.fields[6].asfloat:=Sup;
    Tabella1.POst;
    end;
  end;
end;
{*************************************************************}
Procedure Salva_default(var Tabella1,Tabella3:TTable);
Begin
Crea_default(Tabella1);
  Tabella1.append;
  Tabella1.edit;
  with Default_D^ do
    Begin
    tabella1.fields[0].asfloat:=POrtAp;
    tabella1.fields[1].asfloat:=Alt;
    tabella1.fields[2].asfloat:=TiI;
    tabella1.fields[3].asfloat:=URI;
    tabella1.fields[4].asfloat:=ITmaria;
    tabella1.fields[5].asfloat:=ITmacq;
    tabella1.fields[6].asfloat:=ITracq;
    tabella1.fields[7].asfloat:=TiE;
    tabella1.fields[8].asfloat:=URE;
    tabella1.fields[9].asfloat:=ETmaria;
    tabella1.fields[10].asfloat:=ETmacq;
    tabella1.fields[11].asfloat:=ETracq;
    Tabella1.POst;
    end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_generalita(var Tabella1,Tabella3:TTable);
Begin
Crea_generalita(Tabella1);
  Tabella1.append;
  Tabella1.edit;
  with Gen_D^ do
    Begin
    tabella1.fields[0].asstring:=Data;
    tabella1.fields[1].asstring:=Codice;
    tabella1.fields[2].asstring:=Committente;
    tabella1.fields[3].asstring:=Commessa;
    tabella1.fields[4].asstring:=Impianto;
    tabella1.fields[5].asstring:=Progettista;
    tabella1.fields[6].asstring:=localita;
    tabella1.fields[7].asfloat:=TestInv;
    tabella1.fields[8].asfloat:=TestEst;
    Tabella1.POst;
    end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_muri(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_muri(Tabella1);
For i:=1 to NMuri Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Muri_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Cod;
    tabella1.fields[1].asstring:=Descr;
    tabella1.fields[2].asfloat:=K;
    Tabella1.POst;
    end;
  end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_Finestre(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_Finestre(Tabella1);
For i:=1 to NFinestre Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Finestre_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Cod;
    tabella1.fields[1].asstring:=Descr;
    tabella1.fields[2].asfloat:=SupUn;
    tabella1.fields[3].asfloat:=K;
    tabella1.fields[4].asfloat:=AttSol;
    Tabella1.POst;
    end;
  end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_Esposiz(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_Esposiz(Tabella1);
For i:=1 to NEspos Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Espos_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Cod;
    tabella1.fields[1].asstring:=Descr;
    tabella1.fields[2].asstring:=Tipo;
    tabella1.fields[3].asfloat:=Incl;
    tabella1.fields[4].asfloat:=TLcI;
    tabella1.fields[5].asfloat:=TLcE;
    Tabella1.POst;
    end;
  end;
Tabella1.refresh;
end;
