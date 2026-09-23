unit UFormgen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, Db, DBTables, StdCtrls, DBCtrls, ExtCtrls;

type
  TFGenerale = class(TForm)
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    BOk: TButton;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    procedure BOkClick(Sender: TObject);
    procedure BCancellClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGenerale: TFGenerale;
Procedure formgen(caption,nomefile:string);

implementation
uses Udati, UDB;
{$R *.DFM}
Procedure formgen(caption,nomefile:string);
begin
DM1.TT4.Close;
DM1.TT4.Databasename:=nomecom;
DM1.TT4.Tablename:=nomefile+'.db';
DM1.TT4.open;
Fgenerale.Caption:=caption;
Fgenerale.showmodal;
end;

procedure TFGenerale.BOkClick(Sender: TObject);
begin
Fgenerale.close;
end;

procedure TFGenerale.BCancellClick(Sender: TObject);
begin
Fgenerale.Hide;
end;

procedure TFGenerale.DBGrid1DblClick(Sender: TObject);
begin
Fgenerale.close;
end;

end.
