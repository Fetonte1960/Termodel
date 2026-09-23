unit USemplicesel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, DBCtrls, ExtCtrls, Db, DBTables, Grids, DBGrids;

type
  TFterminale = class(TForm)
    Panel2: TPanel;
    Button1: TButton;
    GroupBox1: TGroupBox;
    Label14: TLabel;
    DBEdit7: TDBEdit;
    Label15: TLabel;
    Label16: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    GroupBox2: TGroupBox;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    GroupBox3: TGroupBox;
    DBEdit3: TDBEdit;
    DBEdit6: TDBEdit;
    GroupBox5: TGroupBox;
    GroupBox6: TGroupBox;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    GroupBox7: TGroupBox;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit16: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    GroupBox8: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Button2: TButton;
    DataSource1: TDataSource;
    Table1: TTable;
    Table2: TTable;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fterminale: TFterminale;

implementation
uses uRuncomp,uDati, UDB,uDatalink;
{$R *.DFM}

procedure TFterminale.Button1Click(Sender: TObject);
Var ss,cc,mm,ff:string;
begin
Seleziona(cc,mm,ff);
dm1.tt1.close;
dm1.tt1.Tablename:='terminale.db';
dm1.tt1.open;
dm1.tt1.edit;
with V_recterm do
  begin
  set_Fab(cc);
  set_Modello(mm);
  end;
dm1.tt1.post;
table1.refresh;
if ff<>'' then
with table2 do
  begin
  getdir(0,ss);
  close;
  databasename:=ss;
  tablename:=ff+'.db';
  open;
  end;
end;

procedure TFterminale.Button2Click(Sender: TObject);
begin
Crea_term;
end;

procedure TFterminale.FormActivate(Sender: TObject);
Var ss:string;
begin
Getdir(0,ss);
dm1.tt1.close;
dm1.tt1.Databasename:=ss;
table1.close;
table1.Databasename:=ss;
table1.tablename:='terminale.db';
table1.open;
end;

end.
