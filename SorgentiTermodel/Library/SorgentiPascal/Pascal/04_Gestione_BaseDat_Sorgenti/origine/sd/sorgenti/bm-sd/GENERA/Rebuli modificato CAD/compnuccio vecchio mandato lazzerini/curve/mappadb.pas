{*************************************************************}
Procedure Crea_Curve(Var Tabella1:ttable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Curve';
  tableType:=ttdefault;
  Fielddefs.Add('Nome',ftstring,20,false);
  Fielddefs.Add('Parametro',ftFloat,0,false);
  Fielddefs.Add('X',ftFloat,0,false);
  Fielddefs.Add('Y',ftFloat,0,false);
  CreateTable;
  End;
End;
