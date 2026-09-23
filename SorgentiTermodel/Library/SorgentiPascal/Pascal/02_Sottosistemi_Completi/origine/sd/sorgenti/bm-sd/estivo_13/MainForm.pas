unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls,Calcoli, StdCtrls,LibreriaGenerale, TeEngine, Series,
  TeeProcs, Chart, DbChart, DB, DBTables, Grids, DBGrids,udb,Ucompilaform,Udatalink;

type
  TFMainEstivo = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    ComboBox1: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Panel3: TPanel;
    Panel4: TPanel;
    Memo1: TMemo;
    DBChart1: TDBChart;
    Table1: TTable;
    Table3: TTable;
    ListBox1: TListBox;
    Table3ORA: TSmallintField;
    Table3VALORE: TFloatField;
    Table1Nome: TStringField;
    Table1Indice: TIntegerField;
    Table1Mese: TStringField;
    Table1H0: TFloatField;
    Table1H1: TFloatField;
    Table1H2: TFloatField;
    Table1H3: TFloatField;
    Table1H4: TFloatField;
    Table1H5: TFloatField;
    Table1H6: TFloatField;
    Table1H7: TFloatField;
    Table1H8: TFloatField;
    Table1H9: TFloatField;
    Table1H10: TFloatField;
    Table1H11: TFloatField;
    Table1H12: TFloatField;
    Table1H13: TFloatField;
    Table1H14: TFloatField;
    Table1H15: TFloatField;
    Table1H16: TFloatField;
    Table1H17: TFloatField;
    Table1H18: TFloatField;
    Table1H19: TFloatField;
    Table1H20: TFloatField;
    Table1H21: TFloatField;
    Table1H22: TFloatField;
    Table1H23: TFloatField;
    ComboBox3: TComboBox;
    Label3: TLabel;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    Label4: TLabel;
    Series1: TLineSeries;
    CBContinuo: TCheckBox;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
  Procedure  Aggiornagrafico;
    { Public declarations }
  end;

var
  FMainEstivo: TFMainEstivo;

implementation

{$R *.dfm}

procedure TFMainEstivo.Button1Click(Sender: TObject);
begin
CalcoloEstivo;
end;

procedure TFMainEstivo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
DisposeUdb;
action:=cafree;
end;

procedure TFMainEstivo.FormDestroy(Sender: TObject);
begin
FMainEstivo:=nil;
end;

Var Variabile:string;
    elenco:string;
Procedure Visualizzagrafico;
Var i:integer;
    Codice,StMax:string;
    Indice,OraMax:integer;
    Massimo:real;

begin

With FMainEstivo do
  begin
  codice:='';
  if elenco='Locali' then  codice:=V_recamb.Denom;
  if elenco='Zone' then  codice:=V_recZone.Denom;

  indice:=1;
  if codice<>'' then
    begin
    dm1.TT1.First;
    while ( not dm1.TT1.Eof)and(V_recamb.denom<>Codice) do
      begin
      inc(indice);
      dm1.TT1.Next;
      end;
    end;  
  DBchart1.Title.Text.Clear;
  table1.open;
  table1.first;
  while (not table1.eof)and((Upstring(table1Nome.Value)<>Upstring(Variabile))or(table1Indice.Value<>Indice)) do table1.next;
  Table3.First;
  Massimo:=-10E6;
  OraMax:=0;
  for i:=0 to 23 do
    begin
    table3.Edit;
    if table1.eof then  table3Valore.value:=0
    else table3Valore.value:=table1.fields[i+3].Value;
    
    if table3Valore.value>Massimo then
      begin
      massimo:=table3Valore.value;
      OraMax:=i;
      end;
    table3.Post;
    table3.next;
    end;
  table3.Refresh;
  DBchart1.Title.Text.Add(' ( '+Table1Mese.Value+' ) '+ListBox1.Items[ListBox1.ItemIndex]+' : '+codice);
  str(Massimo:6:0,stmax);
  Label4.Caption:='Massimo:'+stmax+' , alle ore '+Inttostr(OraMax);
  table1.close;
  end;
end;

Procedure  TFMainEstivo.Aggiornagrafico;
Var i,Field:integer;
    Fai:boolean;
begin
Fai:=True;
elenco:='';
Field:=0;
Case ListBox1.ItemIndex of
0:begin
  variabile:='SETOT.MIC';
  elenco:='';
  end;
1:begin
  variabile:='TE.DAT';
  elenco:='';
  end;
2:begin
  variabile:='IDN.DAT';
  elenco:='';
  end;
9:begin
  variabile:='QACON.DAT';
  elenco:='Locali';
  end;
10:begin
  variabile:='QIRRTOT.DAT';
  elenco:='Locali';
  end;
11:begin
  variabile:='QOCS.DAT';
  elenco:='Locali';
  end;
12:begin
  variabile:='QAPS.DAT';
  elenco:='Locali';
  end;

7:begin
  variabile:='EREST.DAT';
  elenco:='Locali';
  end;
8:begin
  variabile:='LATEFF.DAT';
  elenco:='Locali';
  end;
4:begin
  variabile:='SZTOT.DAT';
  elenco:='Zone';
  end;
5:begin
  variabile:='LZTOT.DAT';
  elenco:='Zone';
  end;

else Fai:=false;
end;
DBchart1.Title.Text.Clear;
dm1.tt1.close;
if elenco<>'' then
  begin
  dm1.tt1.Tablename:=elenco;
  compilagriglia(dbgrid1,elenco,dm1.Datasource1);
  dm1.TT1.Open;
  end;

if fai then Visualizzagrafico;

end;
procedure TFMainEstivo.ListBox1Click(Sender: TObject);
begin
Aggiornagrafico;
end;
procedure TFMainEstivo.FormCreate(Sender: TObject);
begin
InitUdb(Percorso_progetti);
table3.close;
Table3.DatabaseName:=PercorsoDrive+'\file_termico_10\estivo';
table3.open;
table1.close;
Table1.DatabaseName:=Percorso_Progetti;
end;

procedure TFMainEstivo.DBGrid1CellClick(Column: TColumn);
Var Codice:string;
    Indice:integer;
begin
Visualizzagrafico;
end;

procedure TFMainEstivo.Button2Click(Sender: TObject);
begin
close;
end;

procedure TFMainEstivo.FormActivate(Sender: TObject);
begin
CalcoloEstivo;
end;

end.
