unit Main_suntrace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls,dbtables,db,udb,libreriagenerale, DBCtrls,
  Grids, DBGrids,Ucompilaform,varcarichi,solare, LbSpeedButton, StdCtrls,
  Mask,uleggiscrividati,dateutils;

type
  TFMain_suntrace = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label39: TLabel;
    DBEdit30: TDBEdit;
    Label40: TLabel;
    DBEdit31: TDBEdit;
    Label3: TLabel;
    Label41: TLabel;
    DBEdit36: TDBEdit;
    Label4: TLabel;
    DBEdit12: TDBEdit;
    Label15: TLabel;
    Label6: TLabel;
    DBEdit15: TDBEdit;
    Label12: TLabel;
    Label9: TLabel;
    DBEdit32: TDBEdit;
    Label38: TLabel;
    SpeedButton4: TLbSpeedButton;
    LbSpeedButton1: TLbSpeedButton;
    TRilievi: TTable;
    DSRilievi: TDataSource;
    dslocalita: TDataSource;
    Tlocalita: TTable;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label5: TLabel;
    DBEdit2: TDBEdit;
    Label7: TLabel;
    Label8: TLabel;
    LbSpeedButton2: TLbSpeedButton;
    DSProgetto: TDataSource;
    TProgetto: TTable;
    Label10: TLabel;
    DBEdit3: TDBEdit;
    Label11: TLabel;
    Label13: TLabel;
    DBEdit4: TDBEdit;
    Label14: TLabel;
    Label16: TLabel;
    DBEdit5: TDBEdit;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    GroupBox3: TGroupBox;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    LbSpeedButton3: TLbSpeedButton;
    Labelnorm: TLabel;
    LabelX2: TLabel;
    Labelins: TLabel;
    Labelx4: TLabel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    Labelx6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FMain_suntrace: TFMain_suntrace;

implementation

{$R *.dfm}



Procedure apri_db;
begin
with FMain_suntrace do
  begin
  Trilievi.close;
  TLocalita.close;
  TProgetto.close;
  Trilievi.databasename:=percorso_progetti;
  TLocalita.databasename:=percorso_progetti;
  TProgetto.databasename:=percorso_progetti;
  Trilievi.tablename:='rilievi';
  TLocalita.tablename:='Localita';
  TProgetto.tablename:='Progetto';
  Trilievi.open;
  TLocalita.open;
  TProgetto.open;
  end;
end;

Procedure chiudi_db;
begin
with FMain_suntrace do
  begin
  Trilievi.close;
  TLocalita.close;
  TProgetto.close;
  Trilievi.databasename:=percorso_progetti;
  TLocalita.databasename:=percorso_progetti;
  TProgetto.databasename:=percorso_progetti;
  end;
end;

Function CalcPotpan(irragg:real):real;
begin
result:=Progetto_d^.potPiccoPan*
          (irragg/1000)    *
          (Progetto_d^.RendInverter/100)*
          1000;
end;

Procedure Calcola;
Var i,h,m:integer;
    dd,hh:Tdatetime;
    mesecor,oracor:Integer;
    totX2,totX4,totX6,tot_inse,tot_eff,I_dir,I_rif,I_tot:real;
begin
chiudi_db;
dm1.TT1.DatabaseName:=percorso_progetti;
Leggidati;


ValOraMesi(Localita_D^.Lat);

totX2:=0;
totX4:=0;
totX6:=0;
tot_eff:=0;
tot_inse:=0;
for h:=0 to 23 do
for m:=1 to 12 do
  begin
  localita_d^.FattFoschia:=0.7;
  with progetto_d^ do
    begin
    i_dir:=IDR(h,m,1,orient,inclin);
    i_rif:=IDF(h,m,1,orient,inclin);
    i_tot:=i_dir{+i_rif};
    tot_eff:=tot_eff+I_tot/1000*7*30*0.13;
    // 30 giorni   7 mq per kwp   0.13 efficienza di conversione

    i_tot:=idn^[h,m]*localita_d^.FattFoschia;
    tot_Inse:=tot_inse+I_tot/1000*7*30*0.13;

    i_tot:=idn^[h,m]*localita_d^.FattFoschia*2;
    if i_tot>1000 then i_tot:=1000;
    totX2:=totX2+I_tot/1000*7*30*0.13;


    i_tot:=idn^[h,m]*localita_d^.FattFoschia*4;
    if i_tot>1000 then i_tot:=1000;
    totX4:=totX4+I_tot/1000*7*30*0.13;

    i_tot:=idn^[h,m]*localita_d^.FattFoschia*6;
    if i_tot>1000 then i_tot:=1000;
    totX6:=totX6+I_tot/1000*7*30*0.13;
    end;

  end;
FMain_suntrace.labelx2.caption:='Energia [kw/h] di un  impianto da 1000 W con inseguitore e concentratore X 2 : '+float_tostr(totX2);
FMain_suntrace.labelx4.caption:='Energia [kw/h] di un  impianto da 1000 W con inseguitore e concentratore X 4 : '+float_tostr(totX4);
FMain_suntrace.labelx6.caption:='Energia [kw/h] di un  impianto da 1000 W con inseguitore e concentratore X 6 : '+float_tostr(totX6);
FMain_suntrace.labelnorm.caption:='Energia [kw/h] di un impianto da 1000 W:'+float_tostr(tot_eff);
FMain_suntrace.labelins.caption:='Energia [kw/h] di un  impianto da 1000 W con inseguitore :'+float_tostr(tot_inse);

for i:=1 to NRilievi do
with rilievi_d^[i] do
  begin
  dd:=strtodate(data);
  Hh:=strtotime(ora);
  mesecor:=MonthOf(dd);
  oracor:=HourOf(hh);
  irragg:=idn^[oracor,mesecor];
  localita_d^.FattFoschia:=1-copertura/100;
  with progetto_d^ do
    begin
    irragg_pan_dir:=IDR(oracor,mesecor,1,orient,inclin);
    irragg_pan_rif:=IDF(oracor,mesecor,1,orient,inclin);
    end;
  irragg_pan_tot:=irragg_pan_dir+irragg_pan_rif;
  W_calc:=CalcPotpan(irragg_pan_dir);
  kW_h_Giorno_calc:=0;
  for h:=0 to 23 do
  with progetto_D^ do
  kW_h_Giorno_calc:=kW_h_Giorno_calc+CalcPotPan(IDR(h,mesecor,1,orient,inclin))/1000;
  Risparmio_Giorno_calc:=kW_h_Giorno_calc*Progetto_d^.CostoEnerg;
  end;
Scrividati;
Apri_db;
end;



procedure TFMain_suntrace.FormCreate(Sender: TObject);

begin
Init_punt;
initudb(percorso_progetti);
if not(fileexists(percorso_progetti+'\rilievi.db')) then
nuovodb;
compilagriglia(dbgrid1,'Rilievi',dsrilievi);
compilaform(groupbox1,'Localita',dslocalita);
compilaform(groupbox2,'Progetto',dsprogetto);
pagecontrol1.ActivePageIndex:=0;
//Calcola;
Apri_db;
end;

procedure TFMain_suntrace.SpeedButton4Click(Sender: TObject);
begin
chiudi_db;
Nuovodb;
apri_db;
end;

procedure TFMain_suntrace.LbSpeedButton1Click(Sender: TObject);
begin
Calcola;
end;

procedure TFMain_suntrace.LbSpeedButton2Click(Sender: TObject);
begin
tprogetto.Edit;
tprogetto.Post;
tLocalita.Edit;
tLocalita.Post;
end;

end.       '
