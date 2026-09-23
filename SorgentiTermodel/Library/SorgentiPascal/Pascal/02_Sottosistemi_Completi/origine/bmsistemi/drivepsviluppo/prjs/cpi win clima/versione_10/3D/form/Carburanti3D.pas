unit Carburanti3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, ExtCtrls, StdCtrls, Grids, DBGrids,dbtables,udbt,db,libreriagenerale,Ucompilaform,
  dateutils, Mask, DBCtrls,gest_form,Udatalink;

type
  TFCarburanti3D = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    GroupBox2: TGroupBox;
    Label6: TLabel;
    EDMetano: TEdit;
    LbSpeedButton1: TLbSpeedButton;
    ComboBox1: TComboBox;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DBEdit5: TDBEdit;
    procedure FormCreate(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
    procedure LbKWHClick(Sender: TObject);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FCarburanti3D: TFCarburanti3D;
  dstemp:tdatasource;
  Ttemp:ttable;
Var FGestform:TFGestForm=nil;
Procedure Gest_Carburanti3d;


implementation

{$R *.dfm}

procedure TFCarburanti3D.FormCreate(Sender: TObject);
{$I Mappadb}
begin
{
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
}
end;

procedure TFCarburanti3D.LbSpeedButton2Click(Sender: TObject);
begin
{
dm1.TT2.Edit;
dm1.TT2.Post;
}
end;

procedure TFCarburanti3D.LbSpeedButton3Click(Sender: TObject);
Var AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond: Word;
begin
{
dm1.TT2.Append;
dm1.TT2.Edit;
DecodeDateTime(date, AYear, AMonth, ADay, AHour, AMinute, ASecond, AMilliSecond);
dm1.TT2.FieldByName('Aggiornato il').AsString := inttostr(aday) + '-' + inttostr(amonth) + '-' + inttostr(ayear);
}
end;

procedure TFCarburanti3D.LbKWHClick(Sender: TObject);
begin
{
Dmtutti.T_Carburanti.Edit;
V_reccarburanti.set_Densita(0);
V_reccarburanti.set_Poterecal(0);
V_reccarburanti.set_TEP(1);
V_reccarburanti.set_Prezzo(round(str_tofloat(ekwh.text)/3.6*100000)/100000);
Dmtutti.T_Carburanti.POst;
Dmtutti.T_Carburanti.Edit;
}
end;

Procedure Gest_Carburanti3d;
begin
  begin
  FCarburanti3D:=TFCarburanti3d.Create(Nil);
  FGestform:=Nuova_formDB(FCarburanti3d,'Carburanti','Descrizione',0);
  with FGestform do
    begin
    //chiudi_form:=chiusura;
    end;
  end;
FGestform.Showmodal;
end;
Var PCal,KgEP,Dens:real;
procedure TFCarburanti3D.LbSpeedButton1Click(Sender: TObject);
begin
ComboBox1Change(nil);
Dmtutti.T_Carburanti.Edit;
V_reccarburanti.Set_Descrizione(combobox1.text);
if dens<>1 then
V_reccarburanti.set_Densita(dens)
else V_reccarburanti.set_Densita(0);
V_reccarburanti.set_Poterecal(pcal);
V_reccarburanti.set_TEP(kgep);
V_reccarburanti.set_Prezzo(roundr(4,str_tofloat(edmetano.text)/pcal*dens*1000));
//V_reccarburanti.set_Prezzo(roundr(4,str_tofloat(edmetano.text)/40.5144));
Dmtutti.T_Carburanti.POst;
Dmtutti.T_Carburanti.Edit;
end;

procedure TFCarburanti3D.ComboBox1Change(Sender: TObject);
begin
Dens:=1;
  case combobox1.ItemIndex of
  //Energia elettrica
  0:begin
    Pcal:=3600;
    KgEp:=0.22;
    Label7.Caption:='( Euro/Kwh )';
    end;
  //Gas naturale  ( 93% metano )
  1:begin
    Pcal:=47200;
    KgEp:=1.126;
    dens:=1.165;
    Label7.Caption:='( Euro/mc )';
    end;
  //GPL
  2:begin
    Pcal:=46000;
    KgEp:=1.099;
    Label7.Caption:='( Euro/mc )';
    end;
  //Carbone
  3:begin
    Pcal:=28500;
    KgEp:=0.676;
    Label7.Caption:='( Euro/kg )';
    end;
  //Carbon fossile
  4:begin
    Pcal:=17200;
    KgEp:=0.411;
    Label7.Caption:='( Euro/kg )';
    end;
  //Mattonelle di lignite
  5:begin
    Pcal:=20000;
    KgEp:=0.478;
    Label7.Caption:='( Euro/kg )';
    end;
  //Lignite nera
  6:begin
    Pcal:=15500;
    KgEp:=0.251;
    Label7.Caption:='( Euro/kg )';
    end;
  //Lignite
  7:begin
    Pcal:=5600;
    KgEp:=0.134;
    Label7.Caption:='( Euro/kg )';
    end;
  //Scisti bituminosi
  8:begin
    Pcal:=8000;
    KgEp:=0.191;
    Label7.Caption:='( Euro/kg )';
    end;
  //Torba
  9:begin
    Pcal:=7800;
    KgEp:=0.33;
    Label7.Caption:='( Euro/kg )';
    end;
  //Mattonelle di torba
  10:begin
    Pcal:=16000;
    KgEp:=0.382;
    Label7.Caption:='( Euro/kg )';
    end;
  //Olio pesante residuo
  11:begin
    Pcal:=40000;
    KgEp:=0.955;
    Label7.Caption:='( Euro/kg )';
    end;
  //Olio combustibile
  12:begin
    Pcal:=42300;
    KgEp:=1.01;
    Label7.Caption:='( Euro/kg )';
    end;
  //Carburante ( benzina )
  13:begin
    Pcal:=44000;
    KgEp:=1.051;
    Label7.Caption:='( Euro/kg )';
    end;
  //Paraffina
  14:begin
    Pcal:=40000;
    KgEp:=0.955;
    Label7.Caption:='( Euro/kg )';
    end;
  //GNL
  15:begin
    Pcal:=45190;
    KgEp:=1.079;
    Label7.Caption:='( Euro/kg )';
    end;
  //Legname ( umidità 25 % )
  16:begin
    Pcal:=13800;
    KgEp:=0.33;
    Label7.Caption:='( Euro/kg )';
    end;
  //Pellet/mattoni di legno
  17:begin
    Pcal:=16800;
    KgEp:=0.401;
    Label7.Caption:='( Euro/kg )';
    end;
  //Rifiuti
  18:begin
    Pcal:=7400;
    KgEp:=0.177;
    Label7.Caption:='( Euro/kg )';
    end;
  //Calore derivato
  19:begin
    Pcal:=1000;
    KgEp:=0.024;
    Label7.Caption:='( Euro/kcal )';
    end;
  end;
end;

end.
