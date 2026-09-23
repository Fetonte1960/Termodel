unit risparmio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, LbSpeedButton, DBCtrls, Mask,dbtables,
  Grids, DBGrids, TeEngine, Series, TeeProcs, Chart, DbChart,udb, DB;

type
  TFRisparmio = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Image1: TImage;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    Label35: TLabel;
    LbSpeedButton1: TLbSpeedButton;
    GroupBox1: TGroupBox;
    LbSpeedButton2: TLbSpeedButton;
    DBComboBox1: TDBComboBox;
    Label36: TLabel;
    DBPrezzo: TDBEdit;
    DBAggiornato: TDBEdit;
    Label37: TLabel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label31: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label1: TLabel;
    ComboBox1: TComboBox;
    LTotale: TLabel;
    LbSpeedButton3: TLbSpeedButton;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    TabSheet3: TTabSheet;
    DBChart1: TDBChart;
    Tgraficiconsumi: TTable;
    Series1: TBarSeries;
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBComboBox1Change(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FRisparmio: TFRisparmio;

implementation

uses Carburanti, libreriagenerale,Ucompilaform;

{$R *.dfm}
Procedure Initdb;
begin
with  dm1.tt2 do
  begin
  close;
  databasename:=percorso_progetti;
  tablename:='Risparmio';
  compilaform(FRisparmio.groupbox1,'Risparmio',dm1.DataSource2);
  open;
  end;
with  dm1.tt3 do
  begin
  close;
  FRisparmio.dbgrid1.Columns.Clear;
  databasename:=percorso_progetti;
  tablename:='consumi';
  compilagriglia(FRisparmio.dbgrid1,'Consumi',dm1.DataSource3);
  open;
  end;
end;

Procedure closedb;
begin
dm1.tt2.close;
end;

Procedure creaconsumi;
Var i:Integer;
begin
  with dm1.tt3 do
  begin
    databasename:=percorso_progetti;
    tablename:='consumi';
    open;
    for i:=1 to 12 do
    begin
      edit;
      fieldbyname('Fabbisogno').asfloat:=sqr(i-7)*200;
      Post;
      Next;
    end;
    close;
  end;
  with FRisparmio.Tgraficiconsumi do
  begin
    databasename:=percorso_progetti;
    tablename:='consumi';
    open;
  end;
end;

procedure TFRisparmio.LbSpeedButton1Click(Sender: TObject);
begin
close;
end;

procedure TFRisparmio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFRisparmio.LbSpeedButton2Click(Sender: TObject);
begin
closedb;
FCarburanti:=TFCarburanti.create(nil);
Fcarburanti.showmodal;
initdb;
end;

procedure TFRisparmio.FormActivate(Sender: TObject);
begin
 InitDb;
 PageControl1.ActivePageIndex := 0;
end;

procedure TFRisparmio.DBComboBox1Change(Sender: TObject);
Var tt:ttable;
begin
tt:=ttable.Create(nil);
with tt do
  begin
  databasename:=percorso_archivi;
  tablename:='Carburanti';
  open;
  first;
  while (not eof)and(dbcombobox1.Text <> fieldbyname('Descrizione').AsString) do next;
  if dbcombobox1.Text=fieldbyname('Descrizione').AsString  then
    begin
    dm1.TT2.Edit;
    dm1.TT2.FieldByName('Prezzo').Value := tt.FieldByName('Prezzo').Value ;
    dm1.TT2.FieldByName('Aggiornato il').Value := tt.FieldByName('Aggiornato il').Value ;
    dm1.TT2.POst;
    end;
  free;
  end;
end;

procedure TFRisparmio.LbSpeedButton3Click(Sender: TObject);
Var tt:TTable;
    totale:real;
begin
tt:=ttable.Create(nil);
with tt do
  begin
  databasename:=percorso_Progetti;
  tablename:='Generatori';
  open;
  first;
  totale:=0;
  while (not eof)do
    begin
    totale:=totale+tt.fieldbyname('FBMJ').asfloat;
    next;
    end;
  free;
  end;
ltotale.Caption:=float_to_str(totale,2);
creaconsumi;
dm1.tt3.open;
end;

end.
