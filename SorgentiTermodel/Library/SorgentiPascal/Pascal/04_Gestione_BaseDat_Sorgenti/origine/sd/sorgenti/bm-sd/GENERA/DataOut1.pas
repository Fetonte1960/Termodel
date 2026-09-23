{*************************************************************}
Procedure Salva_generalita(var Tabella1,Tabella3:TTable);
Begin
Crea_generalita(Tabella1:Ttable);
  Tabella1.append;
  Tabella1.edit;
  with GENERALITA_D^ do
    Begin
    tabella1.fields[0].asstring:=Progetto;
    tabella1.fields[1].asstring:=Committ;
    tabella1.fields[2].asstring:=Progettista;
    tabella1.fields[3].asinteger:=Revisione;
    tabella1.fields[4].asstring:=Data;
    tabella1.fields[5].asstring:=Luogo;
    tabella1.fields[6].asstring:=ritorno;
    tabella1.fields[7].asfloat:=dps;
    tabella1.fields[8].asfloat:=maxvels;
    tabella1.fields[9].asfloat:=dpe;
    tabella1.fields[10].asfloat:=maxvele;
    tabella1.fields[11].asstring:=valvtipo;
    tabella1.fields[12].asfloat:=perdmin;
    tabella1.fields[13].asfloat:=Tolleranza;
    tabella1.fields[14].asinteger:=Iterazioni;
    Tabella1.POst;
    end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_perdite(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_perdite(Tabella1:Ttable);
For i:=1 to Nperd Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Perd_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Cod;
    tabella1.fields[1].asstring:=Descr;
    tabella1.fields[2].asfloat:=Leq;
    tabella1.fields[3].asfloat:=Zeta;
    tabella1.fields[4].asstring:=Rit;
    Tabella1.POst;
    end;
  end;
Tabella1.refresh;
end;
{*************************************************************}
Procedure Salva_Diametri(var Tabella1:TTable;Var arr:Ar_Recsez;Indmax:integer);
Var i:integer;
Begin
For i:=1 to Indmax Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Diam_D^[i] do
    Begin
    tabella1.fields[2].asstring:=Dnom;
    tabella1.fields[3].asfloat:=Dint;
    tabella1.fields[4].asfloat:=spes;
    tabella1.fields[5].asinteger:=form;
    Tabella1.POst;
    end;
  end;
end;
{*************************************************************}
Procedure Salva_Tubazioni(var Tabella1,Tabella3:TTable);
Var i:integer;
Begin
Crea_Tubazioni(Tabella1:Ttable);
Crea_Diametri(Tabella3:Ttable);
For i:=1 to Ntubaz Do
  Begin
  Tabella1.append;
  Tabella1.edit;
  with Tubaz_D^[i] do
    Begin
    tabella1.fields[0].asstring:=Cod;
    tabella1.fields[1].asstring:=Descr;
    tabella1.fields[2].asfloat:=Dens;
    tabella1.fields[3].asfloat:=Rug;
    Tabella1.POst;
    Salva_Diametri(Tabella3,Sez,NSez);
    end;
  end;
Tabella1.refresh;
end;
