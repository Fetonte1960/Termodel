{*************************************************************}
Procedure Crea_Radiatori(Var Tabella1:ttable;Nometab:string);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:=Nometab;
  tableType:=ttdefault;
  Fielddefs.Add('Grandezza',ftstring,8,false);
  Fielddefs.Add('Resa dt=60',ftFloat,0,false);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_Fancoil(Var Tabella1:ttable;Nometab:string);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:=Nometab;
  tableType:=ttdefault;
  Fielddefs.Add('Grandezza',ftstring,8,false);
  Fielddefs.Add('E Potenza sensibile',ftFloat,0,false);
  Fielddefs.Add('E Potenza totale',ftFloat,0,false);
  Fielddefs.Add('E Portata acqua',ftFloat,0,false);
  Fielddefs.Add('E Perdite di carico',ftFloat,0,false);
  Fielddefs.Add('I Portata acqua',ftFloat,0,false);
  Fielddefs.Add('I Potenza sensibile',ftFloat,0,false);
  Fielddefs.Add('I Perdite di carico',ftFloat,0,false);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_Vuoto(Var Tabella1:ttable;Nometab:string);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:=Nometab;
  tableType:=ttdefault;
  Fielddefs.Add('Database da definire puoi farlo tu',ftstring,50,false);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_Terminale(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Terminale';
  tableType:=ttdefault;
  Fielddefs.Add('Fabbricante',ftstring,20,false);
  Fielddefs.Add('Modello',ftstring,20,false);
  Fielddefs.Add('Grandezza',ftstring,20,false);
  Fielddefs.Add('E Temperatura interna BS',ftFloat,0,false);
  Fielddefs.Add('E Temperatura interna BU',ftFloat,0,false);
  Fielddefs.Add('I Temperatura interna BS',ftFloat,0,false);
  Fielddefs.Add('E Potenza sensibile',ftFloat,0,false);
  Fielddefs.Add('I Potenza sensibile',ftFloat,0,false);
  Fielddefs.Add('E Potenza totale',ftFloat,0,false);
  Fielddefs.Add('E T ingresso acqua',ftFloat,0,false);
  Fielddefs.Add('E Salto termico acqua',ftFloat,0,false);
  Fielddefs.Add('E Portata acqua',ftFloat,0,false);
  Fielddefs.Add('E Perdite di carico',ftFloat,0,false);
  Fielddefs.Add('I T ingresso acqua',ftFloat,0,false);
  Fielddefs.Add('I Salto termico acqua',ftFloat,0,false);
  Fielddefs.Add('I Portata acqua',ftFloat,0,false);
  Fielddefs.Add('I Perdite di carico',ftFloat,0,false);
  CreateTable;
  End;
End;
