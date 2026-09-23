unit UCompilaform;

interface
Uses classes,Controls,StdCtrls,DBCtrls,db,{UChiamatedll, UFcombo}Buttons,DbTables,Udb,LibreriaGenerale,DBGrids;
Procedure compilaform(group:TgroupBox;Nometabella:string;ds:Tdatasource);
Procedure compilagriglia(var gr:Tdbgrid;Nometabella:string;ds:Tdatasource);

implementation

function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;


Procedure compilaform(group:TgroupBox;Nometabella:string;ds:Tdatasource);
Var i:integer;
    codcampo:integer;
    azzerato:boolean;
Procedure AddCombo(item:string);
begin
if group.controls[i-1] is Tdbcombobox then
with (group.controls[i-1] as Tdbcombobox) do
  begin
  if not azzerato then
    begin
    azzerato:=true;
    items.clear;
    end;
  items.Add(item);
  end;
if group.controls[i-1] is TListbox then
with (group.controls[i-1] as TListbox) do
items.Add(item);
end;

Procedure GestCombo(sender:Tobject);
begin
(sender as Tdbcombobox).Text:='pippo';
end;

Procedure Etichetta(testo:string);
var
  Campo: TField;
begin
if group.controls[i-1] is Tdbcombobox then
with (group.controls[i-1] as Tdbcombobox) do
  begin
   if ds<>nil then datasource:=ds;
   Datafield:=copy(testo,1,25);
  //(group.controls[i-1] as Tdbcombobox).onchange:=Fcombo.DBComboBox1Change;
  end;
if group.controls[i-1] is Tdbedit then
with (group.controls[i-1] as Tdbedit) do
  begin
   if ds<>nil THEN datasource:=ds;
   Datafield:=copy(testo,1,25);
  end;
if group.controls[i-1] is TdbCheckBox then
with (group.controls[i-1] as TdbCheckBox) do
  begin
   if ds<>nil THEN datasource:=ds;
   Datafield:=copy(testo,1,25);
  end;
if group.controls[i-1] is TdbRadioGroup then
with (group.controls[i-1] as TdbRadioGroup) do
  begin
   if ds<>nil THEN datasource:=ds;
   Datafield:=copy(testo,1,25);
  end;
if group.controls[i-1] is TdbMemo then
with (group.controls[i-1] as TdbMemo) do
  begin
   if ds<>nil THEN datasource:=ds;
   Datafield:=copy(testo,1,25);
  end;
if group.controls[i-1] is TLabel then
with (group.controls[i-1] as TLabel) do
Caption:=testo;

if group.controls[i-1] is TListbox then
with (group.controls[i-1] as TListbox) do
  begin
  Visible:=false;
  //OnDblClick:=Fcombo.ListBox1DblClick;
  end;

if group.controls[i-1] is TButton then
with (group.controls[i-1] as Tbutton) do
  begin
  //canvas.bitmap:=Fcombo.bitbtn1.glyph;
  font.Size:=10;
  //font.Style:=[fsbold];
  caption:='?';
  //OnClick:=Fcombo.Button1Click;
  end;
end;


Procedure LookUp(testo,NomeLk:string;Nfield:integer;path:string);
Var TT:Ttable;
begin
TT:=TTable.Create(Nil);
if path='P' then tt.DatabaseName:=Percorso_progetti
else tt.DatabaseName:=Percorso_archivi;
tt.TableName:=NomeLk;
tt.Open;
if group.controls[i-1] is Tdbcombobox then
with (group.controls[i-1] as TDbcombobox) do
  begin
  //if ds<>nil then datasource:=ds;
  //Datafield:=copy(testo,1,25);
  tt.First;
  while not tt.Eof do
    begin
    Items.add(tt.fields[NField-1].asstring);
    tt.Next;
    end;
  //Listsource:=Lk;
  //ListFieldIndex:=Nfield;
  //(group.controls[i-1] as Tdbcombobox).onchange:=Fcombo.DBComboBox1Change;
  end;
tt.Close;
TT.Free;
end;

Procedure AddGrid(NomeCampo:string;Larg:integer);
begin
end;

begin
ds.Enabled:=false;
Nometabella:=upstring(nometabella);
for i:=1 to group.controlcount do
if (group.controls[i-1] is TgroupBox) then
  begin
  compilaform(group.controls[i-1] as TgroupBox,Nometabella,ds);
  end
else
if group.controls[i-1].tag<>0 then
  begin
  codcampo:=group.controls[i-1].tag;
  if group.controls[i-1] is Tdbcombobox then
     with (group.controls[i-1] as TDbcombobox) do
       begin
       azzerato:=true;
       Items.Clear;
       end;
  {$I Compilaform}

  end;
ds.Enabled:=true;
end;

Procedure compilagriglia(var gr:Tdbgrid;Nometabella:string;ds:Tdatasource);
Var Codcampo,colonne:integer;
Procedure Etichetta(testo:string);
begin
end;
Procedure LookUp(testo,NomeLk:string;Nfield:integer;path:string);
begin
end;
Procedure AddCombo(item:string);
begin
end;
Procedure AddGrid(NomeCampo:string;Larg:integer);
begin
gr.Columns.Add;
gr.Columns[colonne].FieldName:=Nomecampo;
if larg>0 then gr.Columns[colonne].Width:=larg;
inc(colonne);
end;
begin
Nometabella:=upstring(nometabella);
if ds<>Nil then gr.DataSource:=ds;
colonne:=0;
for codcampo:=1 to 100 do
  begin
  {$I Compilaform}

  end;
end;

end.
