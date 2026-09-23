unit Carburanti;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, ExtCtrls, StdCtrls, Grids, DBGrids,udb,dbtables,db,libreriagenerale,Ucompilaform,
  dateutils, Mask, DBCtrls;

type
  TFCarburanti = class(TForm)
    Panel1: TPanel;
    LbSpeedButton1: TLbSpeedButton;
    LbSpeedButton2: TLbSpeedButton;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    LbSpeedButton3: TLbSpeedButton;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    LbKWH: TLbSpeedButton;
    EKWH: TEdit;
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
    procedure LbKWHClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCarburanti: TFCarburanti;
  dstemp:tdatasource;
  Ttemp:ttable;
implementation

{$R *.dfm}

procedure TFCarburanti.LbSpeedButton1Click(Sender: TObject);
begin
close;
end;

procedure TFCarburanti.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dstemp.Free;
ttemp.free;
action:=cafree;
end;

procedure TFCarburanti.FormCreate(Sender: TObject);
{$I Mappadb}
begin
ttemp:=ttable.Create(nil);
dstemp:=tdatasource.Create(nil);
dstemp.DataSet:=ttemp;
with  ttemp do
  begin
  close;
  databasename:=percorso_archivi;
  tablename:='Carburanti';
  if not fileexists(percorso_archivi + 'Carburanti.db') then
  Crea_Carburanti(ttemp);
  dbgrid1.DataSource:=dstemp;
  compilagriglia(dbgrid1,'Carburanti',dstemp);
  compilaform(groupbox1,'Carburanti',dstemp);
  open;
  end;
end;

procedure TFCarburanti.LbSpeedButton2Click(Sender: TObject);
begin
dm1.TT2.Edit;
dm1.TT2.Post;
end;

procedure TFCarburanti.LbSpeedButton3Click(Sender: TObject);
Var AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
begin
dm1.TT2.Append;
dm1.TT2.Edit;
DecodeDateTime(date, AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
dm1.TT2.FieldByName('Aggiornato il').AsString := inttostr(aday) + '-' + inttostr(amonth) + '-' + inttostr(ayear);
end;

procedure TFCarburanti.LbKWHClick(Sender: TObject);
begin
dm1.TT2.Edit;
dm1.TT2.fieldbyname('Densità').AsFloat := 0;
dm1.TT2.fieldbyname('Potere calorifico').AsFloat:= 0;
dm1.TT2.fieldbyname('TEP').AsFloat := 1;
dm1.TT2.fieldbyname('Prezzo').AsFloat := round(str_tofloat(ekwh.text)/3.6*100000)/100000;
dm1.TT2.POst;
end;

end.
