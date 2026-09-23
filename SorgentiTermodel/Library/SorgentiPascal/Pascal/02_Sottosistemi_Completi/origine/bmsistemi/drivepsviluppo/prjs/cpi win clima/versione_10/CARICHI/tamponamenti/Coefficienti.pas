unit Coefficienti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, Grids, DBGrids, DB, DBTables, StdCtrls;

type
  TFormCoefficienti = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TSpeedButton;
    DataSource1: TDataSource;
    Table1: TTable;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCoefficienti: TFormCoefficienti;

implementation

{$R *.dfm}

procedure TFormCoefficienti.FormCreate(Sender: TObject);
begin
  // Form create
  Label1.Caption := '';
end;

procedure TFormCoefficienti.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormCoefficienti.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormCoefficienti.DBGrid1CellClick(Column: TColumn);
begin
  Close;
end;

procedure TFormCoefficienti.DBGrid1DblClick(Sender: TObject);
begin
  Close;
end;

end.
