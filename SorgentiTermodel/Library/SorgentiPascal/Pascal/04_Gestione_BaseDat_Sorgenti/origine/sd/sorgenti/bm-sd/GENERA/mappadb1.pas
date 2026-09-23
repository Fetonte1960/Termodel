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
  Fielddefs.Add('Descrizione progetto',ftstring,50,false);
  Fielddefs.Add('Committ',ftstring,50,false);
  Fielddefs.Add('Progettista',ftstring,50,false);
  Fielddefs.Add('Revisione',ftInteger,0,false);
  Fielddefs.Add('Data',ftstring,20,false);
  Fielddefs.Add('Ubicazione',ftstring,32,false);
  Fielddefs.Add('ritorno',ftstring,1,false);
  Fielddefs.Add('Perdite ammesse in predimensionamento',ftFloat,0,false);
  Fielddefs.Add('Velocità ammessa in predimensionamento',ftFloat,0,false);
  Fielddefs.Add('Perdite ammesse in equilibratura',ftFloat,0,false);
  Fielddefs.Add('Velocità ammessa in equilibratura',ftFloat,0,false);
  Fielddefs.Add('Tipo valvole',ftstring,8,false);
  Fielddefs.Add('Perdite minime',ftFloat,0,false);
  Fielddefs.Add('Tolleranza',ftFloat,0,false);
  Fielddefs.Add('Iterazioni',ftInteger,0,false);
  CreateTable;
  Open;
  Refresh;
  End;
End;
{*************************************************************}
Procedure Crea_perdite(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='perdite';
  tableType:=ttdefault;
  Fielddefs.Add('Codice',ftstring,8,false);
  Fielddefs.Add('Descrizione',ftstring,20,false);
  Fielddefs.Add('Lunghezza eq',ftFloat,0,false);
  Fielddefs.Add('Zeta',ftFloat,0,false);
  Fielddefs.Add('Ritorno',ftstring,1,false);
  CreateTable;
  Open;
  Refresh;
  End;
End;
{*************************************************************}
Procedure Crea_Diametri(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Diametri';
  tableType:=ttdefault;
  Fielddefs.Add('Indice',ftautoinc,0,false);
  Fielddefs.Add('Sigla diametro',ftstring,8,false);
  Fielddefs.Add('Diametro interno',ftFloat,0,false);
  Fielddefs.Add('Spessore',ftFloat,0,false);
  Fielddefs.Add('Formula di calcolo',ftInteger,0,false);
  CreateTable;
  Open;
  Refresh;
  End;
End;
{*************************************************************}
Procedure Crea_Tubazioni(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Tubazioni';
  tableType:=ttdefault;
  Fielddefs.Add('Codice',ftstring,8,false);
  Fielddefs.Add('Descrizione',ftstring,55,false);
  Fielddefs.Add('Densità',ftFloat,0,false);
  Fielddefs.Add('Rugosità',ftFloat,0,false);
  CreateTable;
  Open;
  Refresh;
  End;
End;
