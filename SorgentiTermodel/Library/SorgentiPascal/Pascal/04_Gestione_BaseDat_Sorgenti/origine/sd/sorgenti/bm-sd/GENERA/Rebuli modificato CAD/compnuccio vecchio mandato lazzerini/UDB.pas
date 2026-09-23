unit UDB;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables;

type
  TDM1 = class(TDataModule)
    TT1: TTable;
    TT2: TTable;
    TT3: TTable;
    TT4: TTable;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM1: TDM1;

implementation

{$R *.DFM}

end.
