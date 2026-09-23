unit UTabellare;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, DBCtrls, ComCtrls, TabNotBk, ExtCtrls,
  DB, DBTables,UDatalink, TeEngine, Series, TeeProcs, Chart, DbChart,UMaskgen;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    TabbedNotebook1: TTabbedNotebook;
    Panel2: TPanel;
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
    ListBox1: TListBox;
    Edit1: TEdit;
    Panel3: TPanel;
    DBNavigator2: TDBNavigator;
    DBGrid2: TDBGrid;
    Table1: TTable;
    DataSource1: TDataSource;
    Edit2: TEdit;
    Label1: TLabel;
    Table1TypeMat: TSmallintField;
    Table1IndiceMat: TIntegerField;
    Table1NomMat: TStringField;
    Table1LambdaMat: TFloatField;
    Table1MasseMat: TFloatField;
    Table1MuMat: TFloatField;
    Table1Version: TIntegerField;
    Table1CapTerm: TFloatField;
    Panel4: TPanel;
    DataSource2: TDataSource;
    Table2: TTable;
    DBGrid3: TDBGrid;
    DBNavigator3: TDBNavigator;
    Table2Nome: TStringField;
    Table2Indice: TIntegerField;
    Table2Mese: TStringField;
    Table2H0: TFloatField;
    Table2H1: TFloatField;
    Table2H2: TFloatField;
    Table2H3: TFloatField;
    Table2H4: TFloatField;
    Table2H5: TFloatField;
    Table2H6: TFloatField;
    Table2H7: TFloatField;
    Table2H8: TFloatField;
    Table2H9: TFloatField;
    Table2H10: TFloatField;
    Table2H11: TFloatField;
    Table2H12: TFloatField;
    Table2H13: TFloatField;
    Table2H14: TFloatField;
    Table2H15: TFloatField;
    Table2H16: TFloatField;
    Table2H17: TFloatField;
    Table2H18: TFloatField;
    Table2H19: TFloatField;
    Table2H20: TFloatField;
    Table2H21: TFloatField;
    Table2H22: TFloatField;
    Table2H23: TFloatField;
    DataSource3: TDataSource;
    Table3: TTable;
    DBChart1: TDBChart;
    Series1: TFastLineSeries;
    Table3ORA: TSmallintField;
    Table3VALORE: TFloatField;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid3DblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses calcoli, UDB,libreriagenerale, Master;

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
 table2.Close;
 CalcoloEstivo;
 table2.open;
end;

procedure TForm1.FormActivate(Sender: TObject);
{$I compilaLista}
begin
CompilaLista;
dm1.TT1.DatabaseName:=edit1.Text;
end;

procedure TForm1.ListBox1Click(Sender: TObject);
Var selezionato:string;
begin
selezionato:=Listbox1.Items[Listbox1.Itemindex];
Dm1.TT1.Close;
if Fileexists(edit1.Text+'\'+selezionato+'.db') then
Dm1.TT1.tablename:=selezionato+'.db'
else Creadatabase(selezionato);
Dm1.TT1.open;
end;

procedure TForm1.DBGrid2DblClick(Sender: TObject);
begin
dm1.TT1.Close;
dm1.TT1.TableName:='strati.db';
dm1.TT1.open;
dm1.TT1.append;
dm1.TT1.edit;
V_Recstrati.set_Nfile(edit2.Text);
V_Recstrati.set_Descrizione(Table1Nommat.Value);
V_Recstrati.set_PesoSpecifico(Table1Massemat.Value);
V_Recstrati.set_ConduttivitaLineare(Table1Lambdamat.Value);
if Table1capterm.Value >0 then
V_Recstrati.set_CaloreSpecifico(Table1capterm.Value)
else V_Recstrati.set_CaloreSpecifico(0.9);
dm1.TT1.post;
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
if upstring(dm1.TT1.tablename)='STRUTTURE.DB'then
edit2.Text:=V_TabStruttura.Nfile;
end;

procedure TForm1.DBGrid3DblClick(Sender: TObject);
var i:integer;
begin
Table3.First;
for i:=0 to 23 do
  begin
  table3.Edit;
  table3Valore.value:=table2.fields[i+3].Value;
  table3.Post;
  table3.next;
  end;
table3.Refresh;
TabbedNotebook1.ActivePage:='grafici';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
formmaster.showmodal;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
Application.CreateForm(TFMaskgen, FMaskgen);
usamaschera(Dm1.TT1.tablename,Dm1.TT1.Databasename,'Dettaglio','',1);
Fmaskgen.Release;
end;

end.
