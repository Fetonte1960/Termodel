unit MainEdit;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, DB, DBTables, DBCtrls,
  Grids, DBGrids;

type
  TEditapezzo = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DBImage1: TDBImage;
    DBGrid1: TDBGrid;
    ComboBox1: TComboBox;
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
    DBText1: TDBText;
    BitBtn1: TBitBtn;
    procedure ComboBox1Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    private
    procedure cercapezzo(var Message: Tmessage); message wm_user+101;
  end;
var
  Editapezzo: TEditapezzo;

implementation

{$R *.DFM}

procedure TEditapezzo.ComboBox1Change(Sender: TObject);
begin
  table1.indexname:='percat';
  table1.setrangestart;
  table1categoria.asstring:=COMBOBOX1.text;
  table1.setrangeend;
  table1categoria.asstring:=COMBOBOX1.text;
  table1.applyrange;
end;

PROCEDURE TEditapezzo.cercapezzo(var Message: Tmessage);
var f:textfile;
    s:string;
begin
  assignfile(f,'codpzz.txt');
  reset(f);
  read(f,s);
  closefile(f);
  table1.indexname:='';
  table1.setkey;
  table1.findkey([s]);
end;

procedure TEditapezzo.Button1Click(Sender: TObject);
var f:textfile;
begin
  assignfile(f,'codpzz.txt');
  rewrite(f);
  write(f,'079R');
  closefile(f);
  sendmessage(handle,wm_user+101,0,0);
end;

function usaforma:thandle;
begin

end;


procedure TEditapezzo.BitBtn1Click(Sender: TObject);
begin
  free;
end;

procedure TEditapezzo.FormCreate(Sender: TObject);
var f:textfile;
    s,s1:string;
begin
  table1.close;
  assignfile(f,'drive1.int');
  if fileexists('drive1.int') then reset(f) else halt;
  readln(f,s);
  closefile(f);
  assignfile(f,s+'\drivearc.int');
  if fileexists(s+'\drivearc.int') then reset(f) else halt;
  readln(f,s1);
  closefile(f);
  table1.databasename:=s1+'\duct';
  table1.open;
end;

end.
