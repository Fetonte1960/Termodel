{*************************************************************}
Procedure Crea_Campi(Var Tabella1:TTable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Campi.Db';
  tableType:=ttdefault;
  Fielddefs.Add('Indice',ftautoinc,0,false);
  Fielddefs.Add('Numero',ftinteger,0,false);
  Fielddefs.Add('Codice',ftstring,20,false);
  Fielddefs.Add('Lunga',ftstring,50,false);
  Fielddefs.Add('Tipo',ftstring,50,false);
  Fielddefs.Add('LungCar',ftInteger,0,false);
  Fielddefs.Add('Tag',ftInteger,0,false);
  Fielddefs.Add('TipoCampo',ftstring,50,false);
  Fielddefs.Add('Griglia',ftInteger,0,false);
  Fielddefs.Add('LookUp',ftstring,50,false);
  Fielddefs.Add('CampoLookUp',ftstring,50,false);
  Fielddefs.Add('Combo1',ftstring,150,false);
  Fielddefs.Add('Combo2',ftstring,150,false);
  Fielddefs.Add('Combo3',ftstring,150,false);
  Fielddefs.Add('Combo4',ftstring,150,false);
  Fielddefs.Add('Combo5',ftstring,150,false);
  Fielddefs.Add('Combo6',ftstring,150,false);
  Fielddefs.Add('Combo7',ftstring,150,false);
  Fielddefs.Add('Combo8',ftstring,150,false);
  Fielddefs.Add('Combo9',ftstring,150,false);
  Fielddefs.Add('Combo10',ftstring,150,false);
  IndexDefs.Add('PerIndice','Indice',[IxPrimary]);
  IndexDefs.Add('PerNumero','Numero',[IXdescending]);
  CreateTable;
  End;
End;
{*************************************************************}
Procedure Crea_Rec(Var Tabella1:TTable);
Var i:integer;
Begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  TableName:='Rec.Db';
  tableType:=ttdefault;
  Fielddefs.Add('Numero',ftAutoinc,0,false);
  Fielddefs.Add('Codice',ftstring,8,false);
  Fielddefs.Add('Descrizione',ftstring,50,false);
  Fielddefs.Add('Massimo',ftInteger,0,false);
  Fielddefs.Add('Tipo',ftstring,50,false);
  Fielddefs.Add('Associato',ftstring,50,false);
  Fielddefs.Add('Menu',ftstring,20,false);
  Fielddefs.Add('Aggiorna',ftstring,2,false);
  IndexDefs.Add('PerNumero','Numero',[IxPrimary]);
  CreateTable;
  End;
End;
