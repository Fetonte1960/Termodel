{*************************************************************}
Procedure Crea_Ambienti(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Ambienti';
  tableType:=ttdefault;
  Fielddefs.Add('Numero',ftAutoinc,0,false);
  Fielddefs.Add('Descrizione',ftstring,20,false);
  Fielddefs.Add('Direzione',ftFloat,0,false);
  Fielddefs.Add('Tipo Geometria',ftstring,10,false);
  Fielddefs.Add('Larghezza',ftFloat,0,false);
  Fielddefs.Add('Altezza',ftFloat,0,false);
  Fielddefs.Add('Altezza netta',ftFloat,0,false);
  Fielddefs.Add('Larghezza quadrotti',ftFloat,0,false);
  Fielddefs.Add('Altezza quadrotti',ftFloat,0,false);
  Fielddefs.Add('Allineamento quadrotti',ftstring,2,false);
  Fielddefs.Add('Densità lampade',ftInteger,0,false);
  Fielddefs.Add('Totale lampade',ftInteger,0,false);
  Fielddefs.Add('Larghezza lampade',ftFloat,0,false);
  Fielddefs.Add('Altezza lampade',ftFloat,0,false);
  Fielddefs.Add('Superficie lampade',ftFloat,0,false);
  Fielddefs.Add('POtenza di una lampada',ftFloat,0,false);
  Fielddefs.Add('POtenza delle lampade',ftFloat,0,false);
  Fielddefs.Add('Irraggiamento',ftFloat,0,false);
  Fielddefs.Add('Persone',ftFloat,0,false);
  Fielddefs.Add('Altri carichi',ftFloat,0,false);
  Fielddefs.Add('E,Totale sensibile',ftFloat,0,false);
  Fielddefs.Add('I,Totale sensibile',ftFloat,0,false);
  Fielddefs.Add('Superficie lorda',ftFloat,0,false);
  Fielddefs.Add('Superficie netta',ftFloat,0,false);
  Fielddefs.Add('Portata aria primaria ',ftFloat,0,false);
  Fielddefs.Add('I, Temperatura ambiente',ftFloat,0,false);
  Fielddefs.Add('I, umidita relativa  ambiente',ftFloat,0,false);
  Fielddefs.Add('I, Temperatura di immissione dell aria',ftFloat,0,false);
  Fielddefs.Add('I, Temperatura di mandata dell acqua',ftFloat,0,false);
  Fielddefs.Add('I, Temperatura di ritorno dell acqua',ftFloat,0,false);
  Fielddefs.Add('E, temperatura ambiente',ftFloat,0,false);
  Fielddefs.Add('E, umidita relativa  ambiente',ftFloat,0,false);
  Fielddefs.Add('E, Temperatura di immissione dell aria',ftFloat,0,false);
  Fielddefs.Add('E, Temperatura di mandata dell acqua',ftFloat,0,false);
  Fielddefs.Add('E, Temperatura di ritorno dell acqua',ftFloat,0,false);
  Fielddefs.Add('Tipo di pannello',ftInteger,0,false);
  Fielddefs.Add('Descrizione pannello',ftstring,30,false);
  Fielddefs.Add('Tipo di scambiatore',ftInteger,0,false);
  Fielddefs.Add('Resa invernale',ftFloat,0,false);
  Fielddefs.Add('Resa Estiva',ftFloat,0,false);
  Fielddefs.Add('Resa totale Estiva',ftFloat,0,false);
  Fielddefs.Add('Resa totale Invernale',ftFloat,0,false);
  IndexDefs.Add('PerNumero','Numero',[IxPrimary]);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_Pareti(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Pareti';
  tableType:=ttdefault;
  Fielddefs.Add('Indice',ftautoinc,0,false);
  Fielddefs.Add('Numero',ftinteger,0,false);
  Fielddefs.Add('Lato',ftstring,3,false);
  Fielddefs.Add('Tipo',ftstring,9,false);
  Fielddefs.Add('Codice',ftstring,8,false);
  Fielddefs.Add('Num/Lung',ftFloat,0,false);
  Fielddefs.Add('Sup.',ftFloat,0,false);
  IndexDefs.Add('PerIndice','Indice',[IxPrimary]);
  IndexDefs.Add('PerNumero','Numero',[IXdescending]);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_default(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='default';
  tableType:=ttdefault;
  Fielddefs.Add('Portata aria primaria ',ftFloat,0,false);
  Fielddefs.Add('Altezza netta',ftFloat,0,false);
  Fielddefs.Add('I, temperatura ambiente',ftFloat,0,false);
  Fielddefs.Add('I, umidita relativa  ambiente',ftFloat,0,false);
  Fielddefs.Add('I, Temperatura di immissione dell aria',ftFloat,0,false);
  Fielddefs.Add('I, Temperatura di mandata dell acqua',ftFloat,0,false);
  Fielddefs.Add('I, Temperatura di ritorno dell acqua',ftFloat,0,false);
  Fielddefs.Add('E, temperatura ambiente',ftFloat,0,false);
  Fielddefs.Add('E, umidita relativa  ambiente',ftFloat,0,false);
  Fielddefs.Add('E, Temperatura di immissione dell aria',ftFloat,0,false);
  Fielddefs.Add('E, Temperatura di mandata dell acqua',ftFloat,0,false);
  Fielddefs.Add('E, Temperatura di ritorno dell acqua',ftFloat,0,false);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_generalita(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='generalita';
  tableType:=ttdefault;
  Fielddefs.Add('Data',ftstring,8,false);
  Fielddefs.Add('Codice',ftstring,20,false);
  Fielddefs.Add('Committente',ftstring,30,false);
  Fielddefs.Add('Commessa',ftstring,30,false);
  Fielddefs.Add('Impianto',ftstring,8,false);
  Fielddefs.Add('Progettista',ftstring,8,false);
  Fielddefs.Add('Località',ftstring,8,false);
  Fielddefs.Add('Temperatura esterna Inv.',ftFloat,0,false);
  Fielddefs.Add('Temperatura esterna Est.',ftFloat,0,false);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_muri(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='muri';
  tableType:=ttdefault;
  Fielddefs.Add('Codice',ftstring,8,false);
  Fielddefs.Add('Descrizione',ftstring,20,false);
  Fielddefs.Add('K',ftFloat,0,false);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_Finestre(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Finestre';
  tableType:=ttdefault;
  Fielddefs.Add('Codice',ftstring,8,false);
  Fielddefs.Add('Descrizione',ftstring,20,false);
  Fielddefs.Add('Superficie unitaria',ftFloat,0,false);
  Fielddefs.Add('K',ftFloat,0,false);
  Fielddefs.Add('Shading solare (0..1)',ftFloat,0,false);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_Esposiz(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Esposiz';
  tableType:=ttdefault;
  Fielddefs.Add('Codice',ftstring,8,false);
  Fielddefs.Add('Descrizione',ftstring,20,false);
  Fielddefs.Add('Interno/Esterno',ftstring,1,false);
  Fielddefs.Add('Inclinazione',ftFloat,0,false);
  Fielddefs.Add('T. inv. loc. conf',ftFloat,0,false);
  Fielddefs.Add('T. est. loc. conf',ftFloat,0,false);
  CreateTable;
  End;
End;
