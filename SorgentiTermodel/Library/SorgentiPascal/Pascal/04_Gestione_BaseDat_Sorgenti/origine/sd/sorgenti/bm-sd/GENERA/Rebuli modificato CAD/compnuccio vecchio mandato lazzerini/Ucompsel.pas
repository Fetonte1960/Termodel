unit Ucompsel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  DBCtrls, Grids, DBGrids, StdCtrls, ExtCtrls, Db, DBTables, ExtDlgs;

type
  TFProgcomp = class(TForm)
    Tt1: TTable;
    DataSource1: TDataSource;
    Panel1: TPanel;
    DBNavigator1: TDBNavigator;
    Button1: TButton;
    DBGrid1: TDBGrid;
    DBImage1: TDBImage;
    Button2: TButton;
    Dlg1: TOpenPictureDialog;
    DBMemo1: TDBMemo;
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
    Tt1Filtro: TStringField;
    Tt1Tipodatabase: TStringField;
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
begin
if runsel then
with Fruncomp do
  begin
  pp1.visible:=false;
  ppl.visible:=false;
  pph.visible:=false;
  if tt1Lmin.Value<>0 then
    begin
    Pp1.Visible:=true;
    PpL.Visible:=true;
    spL.minvalue:=tt1Lmin.Value;
    spL.maxvalue:=tt1Lmax.Value;
    spl.increment:=tt1Lstep.Value;
    end;
  if tt1Hmin.Value<>0 then
    begin
    Pp1.Visible:=true;
    PpH.Visible:=true;
    spH.minvalue:=tt1Hmin.Value;
    spH.maxvalue:=tt1Hmax.Value;
    spH.increment:=tt1Hsstep.Value;
    end;
  end;
end;

procedure TFProgcomp.FormActivate(Sender: TObject);
var ss:string;
begin
runsel:=false;
tt1.close;
Getdir(0,ss);
tt1.Databasename:=ss;
tt1.open;
end;

end.
