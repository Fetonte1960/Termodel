unit Ucompsel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, Grids, DBGrids, StdCtrls, ExtCtrls, Db, DBTables, ExtDlgs,
  ComCtrls, Tabnotbk;

type
  TFProgcomp = class(TForm)
    Tt1: TTable;
    DataSource1: TDataSource;
    Dlg1: TOpenPictureDialog;
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
    TabbedNotebook1: TTabbedNotebook;
    DBGrid2: TDBGrid;
    Panel2: TPanel;
    DBNavigator2: TDBNavigator;
    Button3: TButton;
    DBImage2: TDBImage;
    Button4: TButton;
    DBMemo2: TDBMemo;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    Table1: TTable;
    DataSource2: TDataSource;
    DBGrid1: TDBGrid;
    Tt1C1: TStringField;
    Tt1C2: TStringField;
    Table1Codice: TStringField;
    Table1Ind: TAutoIncField;
    Table1Tipo: TStringField;
    Table1Campo: TStringField;
    Tt1C3: TStringField;
    Tt1TP: TIntegerField;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FProgcomp: TFProgcomp;

var runsel:boolean;
  
implementation

uses URunComp;

{$R *.DFM}


procedure TFProgcomp.Button2Click(Sender: TObject);
begin
Dlg1.execute;
if dlg1.filename<>'' then
  begin
  TT1.Append;
  tt1.edit;
  tt1Immagine.Loadfromfile(dlg1.filename);
  tt1.post;
  end;
end;

procedure TFProgcomp.Button1Click(Sender: TObject);
begin
runsel:=true;
Fruncomp.showmodal;
end;

procedure TFProgcomp.DataSource1DataChange(Sender: TObject; Field: TField);

Procedure Displayinput(var combo:Tcombobox);
begin
if Fprogcomp.table1Tipo.Value[1]='A' then dimunite:=true;
Fprogcomp.Table1.filtered:=true;
  case Fprogcomp.table1Tipo.Value[1] of
    'A','B','C':
        begin
        Fprogcomp.table1.first;
        Combo.Text:=Fprogcomp.Table1Campo.Value;
        Combo.Items.clear;
        while not Fprogcomp.table1.eof do
          begin
          Combo.Items.Add(Fprogcomp.table1Campo.Value);
          Fprogcomp.table1.Next;
          end;
        end;
  end;
end;
begin
if runsel then
with Fruncomp do
  begin
  dimunite:=false;
  pp1.visible:=false;
  ppl.visible:=false;
  pph.visible:=false;
  comb1.visible:=false;
  cb3.Visible:=false;
  l3.Visible:=false;
  cb4.Visible:=false;
  l4.Visible:=false;

  if tt1C1.Value<>'' then
    begin
    Fprogcomp.table1.filter:='Codice='''+Fprogcomp.Tt1C1.value+'''';
    DisplayInput(cb1);
    comb1.visible:=true;
    end;

  if tt1C2.Value<>'' then
    begin
    Fprogcomp.table1.filter:='Codice='''+Fprogcomp.Tt1C2.value+'''';
    DisplayInput(cb2);
    comb1.visible:=true;
    end;

  if tt1C3.Value<>'' then
    begin
    Fprogcomp.table1.filter:='Codice='''+Fprogcomp.Tt1C3.value+'''';
    if tt1Lmin.Value<>0 then
      begin
      DisplayInput(cb4);
      cb4.Visible:=true;
      l4.Visible:=true;
      end
    else
      begin
      DisplayInput(cb3);
      comb1.visible:=true;
      cb3.Visible:=true;
      l3.Visible:=true;
      end
    end;

  if tt1Lmin.Value<>0 then
    begin
    Pp1.Visible:=true;
    PpL.Visible:=true;
    spL.minvalue:=tt1Lmin.Value;
    spL.maxvalue:=tt1Lmax.Value;
    spl.increment:=tt1Lstep.Value;
    spl.Value:=tt1L.Value;
    end;
  if tt1Hmin.Value<>0 then
    begin
    Pp1.Visible:=true;
    PpH.Visible:=true;
    spH.minvalue:=tt1Hmin.Value;
    spH.maxvalue:=tt1Hmax.Value;
    spH.increment:=tt1Hsstep.Value;
    spH.Value:=tt1H.Value;
    end;
  end;
end;

procedure TFProgcomp.FormActivate(Sender: TObject);
begin
runsel:=false;
end;

end.
