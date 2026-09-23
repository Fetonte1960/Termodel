unit Uvpezzi;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, DBTables, DB, StdCtrls, DBLookup, DBCtrls, Grids, DBGrids,
  ExtCtrls, Buttons,definiz, Tabs;
type
  TForm1 = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBImage1: TDBImage;
    Table1Codice: TStringField;
    Table1Descrizione: TStringField;
    Table1Disegno: TSmallintField;
    Table1Main: TStringField;
    Table1Branch: TStringField;
    Table1Fonte: TStringField;
    Table1Varie: TStringField;
    Table1TipoSez: TStringField;
    Table1Nuscite: TSmallintField;
    Table1Figura: TGraphicField;
    Table1Categoria: TStringField;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    Table2: TTable;
    Table2Descrizione: TStringField;
    Table2Valore: TStringField;
    Table2Attribbuto: TStringField;
    BitBtn1: TBitBtn;
    Table2Count: TIntegerField;
    Notebook1: TNotebook;
    TabSet1: TTabSet;
    DBGrid2: TDBGrid;
    Label1: TLabel;
    DBText1: TDBText;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    fisso: TCheckBox;
    Label2: TLabel;
    Edit4: TEdit;
    Label6: TLabel;
    Edit5: TEdit;
    Label7: TLabel;
    Edit6: TEdit;
    Label8: TLabel;
    Edit7: TEdit;
    Label9: TLabel;
    Umport: TLabel;
    Edit8: TEdit;
    Label10: TLabel;
    Edit9: TEdit;
    Label11: TLabel;
    Edit10: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure Table2BeforePost(DataSet: TDataset);
    procedure FormCreate(Sender: TObject);
    procedure TabSet1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    ncount:longint;
    parente:hwnd;
    procedure aggpzz;
    { Private declarations }
  public
    { Public declarations }
  end;
type punpezzi=^recpezzi;

var
  Form1: TForm1;
  pezzi:punpezzi;
  unmis:integer;
procedure settaparametri(var apezzi:punpezzi;um:integer;aparente:hwnd); export;
implementation

{$R *.DFM}

procedure TForm1.aggpzz;
var cat,s:string;
    i:INTEGER;
begin

  {pezzi.codice:='3733D';}
  table1.cancelrange;
  table1.indexname:='';
  if table1.findkey([pezzi^.codice]) then cat:=table1categoria.value;
  table1.indexname:='codcat';
  table1.setrangestart;
  table1codice.value:='0';
  table1categoria.value:=cat;
  table1.setrangeend;
  table1categoria.value:=cat;
  table1codice.value:='Z';
  table1.applyrange;
  table1.findkey([cat,pezzi^.codice]);


  table2.close;
  table2.open;
  table2.disablecontrols;
  table2.last;
  while not table2.bof do table2.delete;
  table2.enablecontrols;
  ncount:=0;
  for i:=1 to maxd do
  with pezzi^.tabdescr[i] do
  begin
    if descr>'' then
    begin
    table2.append;
    table2descrizione.value:=descr;
    table2valore.value:=valor;
    table2attribbuto.value:=attrib;;
    end;
  end;
  table2.indexname:='attr';
  table2.setrangestart;
  table2attribbuto.value:='S';
  table2.setrangeend;
  table2attribbuto.value:='S';
  table2.applyrange;
  with pezzi^ do
  begin
    str(r:5:0,s);
    edit1.text:=s;
    str(a:5:0,s);
    edit2.text:=s;
    str(b:5:0,s);
    edit3.text:=s;
    if flag='*' then fisso.checked:=true else fisso.checked:=false;
    str(Ang:5:0,s);
    edit4.text:=s;

    str(Rag:5:4,s);
    edit5.text:=s;

    str(Lung:5:2,s);
    edit6.text:=s;

    str(perd:5:3,s);
    edit7.text:=s;
    if unmis=1 then  str(Port:5:4,s) else str(Port:5:0,s);
    edit8.text:=s;
    edit9.text:='';

    str(varie:5:0,s);
    edit10.text:=s;
  end;
end;

procedure settaparametri(var apezzi:punpezzi;um:integer;aparente:hwnd);
begin
  if form1=nil then form1:=TForm1.create(Application);
  pezzi:=apezzi;
  unmis:=um;
  form1.parente:=aparente;
  form1.aggpzz;
  form1.show;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var i:integer;
begin
  if table2.state in [dsinsert,dsedit] then table2.post;
  table2.disablecontrols;
  table2.first;
  i:=1;
  while (not table2.eof) and (i<=50) do
  with pezzi^.tabdescr[i] do
  begin
    descr:=table2descrizione.value;
    valor:=table2valore.value;
    attrib:=table2attribbuto.value;
    table2.next;
    inc(i);
  end;
  table2.enablecontrols;
  pezzi^.codice:=table1codice.value;
  sendmessage(parente,wm_user+101,0,0);
end;

procedure TForm1.Table2BeforePost(DataSet: TDataset);
begin
  inc(ncount);
  table2count.value:=ncount;
  table2attribbuto.value:='S';
end;

procedure TForm1.FormCreate(Sender: TObject);
var f:textfile;
    s:string;
begin
  tabset1.tabs:=notebook1.pages;
  top:=screen.height-height;
  left:=screen.width-width;
  table1.close;
  assignfile(f,'drive1.int');
  reset(f);
  readln(f,s);
  closefile(f);
  assignfile(f,s+'\drivearc.int');
  reset(f);
  readln(f,s);
  closefile(f);
  table1.databasename:=s+'\duct';
  table1.tablename:='pezzi.db';
  table1.open;
  table2.close;
  table2.databasename:=table1.databasename;
  table2.tablename:='comodo.db';
end;

procedure TForm1.TabSet1Click(Sender: TObject);
begin
  notebook1.pageindex:=tabset1.tabindex;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  action:=cafree;
  form1:=nil;
end;

end.

