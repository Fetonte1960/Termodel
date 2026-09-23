Procedure CreaDataBase(percorso:string);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  DataBaseName:=Percorso;
  TableName:='generatore.DB';
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
