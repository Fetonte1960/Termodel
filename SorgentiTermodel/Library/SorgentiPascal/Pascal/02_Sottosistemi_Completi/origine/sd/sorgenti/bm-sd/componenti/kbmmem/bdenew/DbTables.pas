unit DbTables;

interface

uses
  Windows, Messages, SysUtils, Classes, DB, kbmMemTable,kbmMemCSVStreamFormat;

type
  TTable = class(TkbmMemTable)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
  Databasename:string;
  Tablename:string;
  //tabletype:TTabletype;
  procedure open;
  procedure Close;
    { Public declarations }
  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Quattrone', [TTable]);
end;
 procedure TTable.open;
Var format:TkbmCSVStreamFormat;
    nome:string;
begin
format:=TkbmCSVStreamFormat.create(nil);
defaultformat:=format;
formformat:=format;
persistentformat:=format;
Nome:=databasename+'\'+tablename;
if (length(tablename)<=3) or (tablename[length(tablename)-2]<>'.') then
nome:=nome+'.db';
LoadFromFile(nome);
active:=true;
end;
procedure TTable.close;
Var format:TkbmCSVStreamFormat;
    nome:string;
begin
format:=TkbmCSVStreamFormat.create(nil);
defaultformat:=format;
formformat:=format;
persistentformat:=format;
Nome:=databasename+'\'+tablename;
if (length(tablename)<=3) or (tablename[length(tablename)-2]<>'.') then
nome:=nome+'.db';
SavetoFile(nome);
active:=False;
end;
end.
