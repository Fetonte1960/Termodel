{*************************************************************}
Procedure Leggi_generalita(var Tabella1:TTable;var Tabella3:TTable);
Begin
Tabella1.close;
Tabella1.tablename:='generalita.DB';
Tabella1.open;
Tabella1.first;
  with GENERALITA_D^ do
    Begin
    Progetto:=tabella1.fields[0].asstring;
    Committ:=tabella1.fields[1].asstring;
    Progettista:=tabella1.fields[2].asstring;
    Revisione:=tabella1.fields[3].asinteger;
    Data:=tabella1.fields[4].asstring;
    Luogo:=tabella1.fields[5].asstring;
    ritorno:=tabella1.fields[6].asstring;
    dps:=tabella1.fields[7].asfloat;
    maxvels:=tabella1.fields[8].asfloat;
    dpe:=tabella1.fields[9].asfloat;
    maxvele:=tabella1.fields[10].asfloat;
    valvtipo:=tabella1.fields[11].asstring;
    perdmin:=tabella1.fields[12].asfloat;
    Tolleranza:=tabella1.fields[13].asfloat;
    Iterazioni:=tabella1.fields[14].asinteger;
    end;
end;
{*************************************************************}
Procedure Leggi_perdite(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='perdite.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Perd_D^[i] do
    Begin
    Cod:=tabella1.fields[0].asstring;
    Descr:=tabella1.fields[1].asstring;
    Leq:=tabella1.fields[2].asfloat;
    Zeta:=tabella1.fields[3].asfloat;
    Rit:=tabella1.fields[4].asstring;
    end;
  Tabella1.Next;
  end;
Nperd:=i;
end;
{*************************************************************}
Procedure Leggi_Diametri(var Tabella1:TTable;Var arr:Ar_Recsez;Var i:Integer);
Begin
i:=0;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with arr[i] do
    Begin
    Dnom:=tabella1.fields[2].asstring;
    Dint:=tabella1.fields[3].asfloat;
    spes:=tabella1.fields[4].asfloat;
    form:=tabella1.fields[5].asinteger;
    end;
  Tabella1.Next;
  end;
end;
{*************************************************************}
Procedure Leggi_Tubazioni(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Tubazioni.DB';
Tabella1.open;
Tabella3.close;
Tabella3.tablename:='Diametri.DB';
Tabella3.Masterfields:='Codice';
Tabella3.IndexName:='PerCodice';
Tabella3.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Tubaz_D^[i] do
    Begin
    Leggi_Diametri(Tabella3,Sez,NSez);
    Cod:=tabella1.fields[0].asstring;
    Descr:=tabella1.fields[1].asstring;
    Dens:=tabella1.fields[2].asfloat;
    Rug:=tabella1.fields[3].asfloat;
    end;
  Tabella1.Next;
  end;
Ntubaz:=i;
end;
{*************************************************************}
Procedure Leggi_PerdConc(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='PerdConc.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Pconc_D^[i] do
    Begin
    N:=tabella1.fields[0].asinteger;
    Cod:=tabella1.fields[1].asstring;
    end;
  Tabella1.Next;
  end;
Npconc:=i;
end;
{*************************************************************}
Procedure Leggi_rami(var Tabella1:TTable;Var arr:Ar_RecPros;Var i:Integer);
Begin
i:=0;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with arr[i] do
    Begin
    Ramo:=tabella1.fields[2].asinteger;
    end;
  Tabella1.Next;
  end;
end;
{*************************************************************}
Procedure Leggi_Nodi(var Tabella1:TTable;var Tabella3:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Nodi.DB';
Tabella1.open;
Tabella3.close;
Tabella3.tablename:='rami.DB';
Tabella3.Masterfields:='num';
Tabella3.IndexName:='Pernum';
Tabella3.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Dati^[i] do
    Begin
    Leggi_rami(Tabella3,Pros,Npros);
    Num:=tabella1.fields[0].asinteger;
    x:=tabella1.fields[1].asfloat;
    y:=tabella1.fields[2].asfloat;
    Tipo:=tabella1.fields[3].asstring;
    Dh:=tabella1.fields[4].asfloat;
    lungh:=tabella1.fields[5].asfloat;
    Coddiam:=tabella1.fields[6].asstring;
    diam:=tabella1.fields[7].asfloat;
    SWDiam:=tabella1.fields[8].asstring;
    port:=tabella1.fields[9].asfloat;
    PortEff:=tabella1.fields[10].asfloat;
    Ti:=tabella1.fields[11].asinteger;
    Term:=tabella1.fields[12].asinteger;
    pd:=tabella1.fields[13].asfloat;
    pl:=tabella1.fields[14].asfloat;
    pp:=tabella1.fields[15].asfloat;
    pr:=tabella1.fields[16].asfloat;
    end;
  Tabella1.Next;
  end;
Ntronchi:=i;
end;
