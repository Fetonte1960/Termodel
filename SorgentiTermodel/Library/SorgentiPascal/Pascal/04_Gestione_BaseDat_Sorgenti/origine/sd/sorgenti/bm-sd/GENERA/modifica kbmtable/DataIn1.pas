{*************************************************************}
Procedure Leggi_generalita(var Tabella1:TTable);
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
Procedure Leggi_perdite(var Tabella1:TTable);
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
  end
end;
{*************************************************************}
Procedure Leggi_Diametri(var Tabella1:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Diametri.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Diam_D^[i] do
    Begin
    Dnom:=tabella1.fields[0].asstring;
    Dint:=tabella1.fields[1].asfloat;
    spes:=tabella1.fields[2].asfloat;
    form:=tabella1.fields[3].asinteger;
    end;
  Tabella1.Next;
  end
end;
{*************************************************************}
Procedure Leggi_Tubazioni(var Tabella1:TTable);
Var i:integer;
Begin
i:=0;
Tabella1.close;
Tabella1.tablename:='Tubazioni.DB';
Tabella1.open;
Tabella1.first;
While not Tabella1.eof do
  Begin
  inc(i);
  with Tubaz_D^[i] do
    Begin
    Cod:=tabella1.fields[0].asstring;
    Descr:=tabella1.fields[1].asstring;
    Dens:=tabella1.fields[2].asfloat;
    Rug:=tabella1.fields[3].asfloat;
    end;
  Tabella1.Next;
  end
end;
