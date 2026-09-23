unit URunComp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, StdCtrls, DBCGrids, Spin, ExtCtrls, Db, DBTables, Grids, DBGrids,
  ComCtrls, Tabnotbk;

type
  TFRunComp = class(TForm)
    DBCtrlGrid1: TDBCtrlGrid;
    DBImage1: TDBImage;
    pp1: TPanel;
    Ppl: TPanel;
    Pph: TPanel;
    Spl: TSpinEdit;
    Label1: TLabel;
    Label2: TLabel;
    Sph: TSpinEdit;
    Panel1: TPanel;
    Button3: TButton;
    Button1: TButton;
    Button2: TButton;
    Tt1: TTable;
    DataSource1: TDataSource;
    Tt1ID: TAutoIncField;
    Tt1Gruppo: TStringField;
    Tt1Padre: TStringField;
    Tt1Figlio: TStringField;
    Tt1Descrizione: TStringField;
    Tt1L: TIntegerField;
    Tt1H: TIntegerField;
    Tt1Lmin: TIntegerField;
    Tt1Lmax: TIntegerField;
    Tt1Lstep: TIntegerField;
    Tt1Hmin: TIntegerField;
    Tt1Hmax: TIntegerField;
    Tt1HSstep: TIntegerField;
    Tt1Comento: TMemoField;
    Tt1Immagine: TGraphicField;
    Panel2: TPanel;
    DBText1: TDBText;
    TabbedNotebook1: TTabbedNotebook;
    DBGrid1: TDBGrid;
    DataSource2: TDataSource;
    Tt2: TTable;
    Tt1Filtro: TStringField;
    DataSource3: TDataSource;
    Tt3: TTable;
    Panel3: TPanel;
    DBNavigator1: TDBNavigator;
    Panel4: TPanel;
    DBNavigator2: TDBNavigator;
    DBGrid2: TDBGrid;
    Tt2ID: TAutoIncField;
    Tt2Gruppo: TStringField;
    Tt2Produttore: TStringField;
    Tt2Descrizione: TStringField;
    Tt2File: TStringField;
    Tt2Codice: TStringField;
    Tt2Etc: TFloatField;
    DBText2: TDBText;
    DBText3: TDBText;
    Label3: TLabel;
    Tt1Tipodatabase: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBCtrlGrid1DblClick(Sender: TObject);
    procedure DBImage1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRunComp: TFRunComp;

Procedure seleziona(var costruttore,modello,nomefile:string);
  
implementation
uses UDati, USemplicesel, UDB;


{$R *.DFM}
Procedure seleziona(var costruttore,modello,nomefile:string);
begin
Fruncomp.showmodal;
costruttore:=fruncomp.tt2produttore.value;
Modello:=fruncomp.tt2descrizione.value;
Nomefile:=fruncomp.tt2File.value;
end;
procedure TFRunComp.FormActivate(Sender: TObject);
Var ss:string;
begin
tt1.close;
Getdir(0,ss);
tt1.Databasename:=ss;
dm1.tt1.close;
dm1.tt1.Databasename:=ss;
tt1.open;
tt1.filter:='gruppo=''BASE''';
tt1.filtered:=true;
tt2.close;
tt2.Databasename:=ss;
tt2.open;
end;

procedure TFRunComp.Button1Click(Sender: TObject);
begin
{tt1.filtered:=false;}
Fruncomp.close;
end;

procedure TFRunComp.DBCtrlGrid1DblClick(Sender: TObject);
begin
If Tt1Figlio.value<>'' then
  begin
  tt1.filter:='Gruppo='''+Tt1Figlio.value+'''';
  end;
end;

procedure TFRunComp.DBImage1Click(Sender: TObject);
begin
 If Tt1Figlio.value<>'' then
  begin
  tt1.filter:='Gruppo='''+Tt1Figlio.value+'''';
  end;
end;

procedure TFRunComp.Button3Click(Sender: TObject);
begin
If Tt1Padre.value<>'' then
  begin
  tt1.filter:='Gruppo='''+Tt1Padre.value+'''';
  end;
end;

procedure TFRunComp.DataSource1DataChange(Sender: TObject; Field: TField);
var ss:string;
begin
if tt1Tipodatabase.Value<>'' then tt2.open
  {begin
  tt2.close;
  getdir(0,ss);
  tt2.Databasename:=ss;
  tt2.Tablename:='modelli.db'tt1nomedatabase.Value+'.db';
  tt2.Masterfields:='filtro';
  tt2.IndexName:='PerGruppo';
  tt2.open;
  end}
else tt2.close;
end;

procedure TFRunComp.DataSource2DataChange(Sender: TObject; Field: TField);
Var ss:string;
    nome1,nome2:Pchar;
begin
if tt2File.Value<>'' then
  begin
  tt3.close;
  getdir(0,ss);
  tt3.Databasename:=ss;
  tt3.Tablename:=tt2File.Value+'.db';
  if not fileexists(ss+'\'+tt3.Tablename) then
    begin
    if fileexists(ss+'\'+tt1Tipodatabase.Value+'.db') then
      begin
      tt3.Tablename:=ss+'\'+tt1Tipodatabase.Value+'.db';
      tt3.open;
      tt3.close;
      tt3.createtable;
      end
    else
    creadatabase(tt3,tt3.Tablename,tt1tipodatabase.Value);
    end;
  tt3.open;
  end
else tt3.close;
end;

end.
