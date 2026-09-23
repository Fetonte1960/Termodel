unit KTUDB;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DbtablesQ;

type
  TDataModule2 = class(TDataModule)
    TableQ1: TTableQ;
    TableQ2: TTableQ;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

{$R *.dfm}

end.
