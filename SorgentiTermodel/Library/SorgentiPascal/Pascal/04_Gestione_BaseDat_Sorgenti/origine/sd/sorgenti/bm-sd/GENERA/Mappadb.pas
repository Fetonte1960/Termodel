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
  Fielddefs.Add('Codice',ftstring,10,false);
  Fielddefs.Add('Sigla diametro',ftstring,8,false);
  Fielddefs.Add('Diametro interno',ftFloat,0,false);
  Fielddefs.Add('Spessore',ftFloat,0,false);
  Fielddefs.Add('Formula di calcolo',ftInteger,0,false);
  IndexDefs.Add('PerIndice','Indice',[IxPrimary]);
  IndexDefs.Add('PerCodice','Codice',[IXdescending]);
  CreateTable;
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
  IndexDefs.Add('PerCodice','Codice',[IxPrimary]);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_PerdConc(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='PerdConc';
  tableType:=ttdefault;
  Fielddefs.Add('Numero',ftInteger,0,false);
  Fielddefs.Add('Codice',ftstring,8,false);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_rami(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='rami';
  tableType:=ttdefault;
  Fielddefs.Add('Indice',ftautoinc,0,false);
  Fielddefs.Add('num',ftstring,10,false);
  Fielddefs.Add('Ramo',ftInteger,0,false);
  IndexDefs.Add('PerIndice','Indice',[IxPrimary]);
  IndexDefs.Add('Pernum','num',[IXdescending]);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_Nodi(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Nodi';
  tableType:=ttdefault;
  Fielddefs.Add('Numerazione tronchi',ftInteger,0,false);
  Fielddefs.Add('Posizione etichetta X',ftFloat,0,false);
  Fielddefs.Add('Posizione etichetta X',ftFloat,0,false);
  Fielddefs.Add('Tipo Tubazione',ftstring,8,false);
  Fielddefs.Add('Diff di quota',ftFloat,0,false);
  Fielddefs.Add('Lunghezza',ftFloat,0,false);
  Fielddefs.Add('Codice diametro',ftstring,8,false);
  Fielddefs.Add('Diametro',ftFloat,0,false);
  Fielddefs.Add('Diametro fissato',ftstring,1,false);
  Fielddefs.Add('Port. richiesta',ftFloat,0,false);
  Fielddefs.Add('Port. effettiva',ftFloat,0,false);
  Fielddefs.Add('Linea iniziale',ftInteger,0,false);
  Fielddefs.Add('Terminale collegato',ftInteger,0,false);
  Fielddefs.Add('Perdite distribuite',ftFloat,0,false);
  Fielddefs.Add('Perdite localizzate',ftFloat,0,false);
  Fielddefs.Add('Perdite progressive',ftFloat,0,false);
  Fielddefs.Add('Perdite del ramo',ftFloat,0,false);
  IndexDefs.Add('Pernum','num',[IxPrimary]);
  CreateTable;
  End;
End;
