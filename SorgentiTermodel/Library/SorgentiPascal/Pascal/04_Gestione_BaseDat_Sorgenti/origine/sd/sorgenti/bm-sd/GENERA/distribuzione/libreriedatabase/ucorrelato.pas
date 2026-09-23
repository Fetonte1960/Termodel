unit ucorrelato;


interface
uses SysUtils, DBTables, LibreriaGenerale, UdataLink,variants;


procedure CaricaCorrelato(Table : TTable);

var
   Table_name : String;

implementation


procedure CaricaCorrelato(Table : TTable);
function CampoCorrelato(NomeTabella : String; ColonnaCod, ColonnaResult : Integer; PA : Char; Ricerca : String): Real;
Var
   Table1 : TTable;
begin
     Table1 := TTable.Create(Nil);
     if Pa = 'P' then
        Table1.Databasename := Percorso_Progetti
     else
        Table1.Databasename := Percorso_Archivi;

     Table1.tablename := NomeTabella + '.db';
     Table1.Open;



     if Table1.Locate(Table1.fields[ColonnaCod].FieldName, Ricerca, []) then
     if Table1[Table1.fields[ColonnaResult].FieldName]<>null then
        Result := Table1.FindField(Table1.fields[ColonnaResult].FieldName).AsFloat
     else result:=0
     else
        Result := 0;

     Table1.Close;
     FreeandNil(Table1);
end;
begin

     Table_Name := UpperCase(ExtractFileName(Table.TableName));
     Table.Edit;
     Table.Post;
     Table.Edit;
     {$I conferma}
     Table.Post;
end;


end.
