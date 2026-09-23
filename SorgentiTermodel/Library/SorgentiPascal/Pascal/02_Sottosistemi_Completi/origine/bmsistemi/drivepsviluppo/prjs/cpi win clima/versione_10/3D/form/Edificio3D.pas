unit Edificio3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, LbSpeedButton,UCompilaForm,UdBT,udb,dbtables,terminali3d,
  ExtCtrls,generatore3D,sceltaA,libreriagenerale,udatalink{localita,DatiFabbricato};

type
  TFEdificio3d = class(TForm)
    GBLocSemp: TGroupBox;
    Label307: TLabel;
    btnArchivio: TLbSpeedButton;
    Label317: TLabel;
    Label318: TLabel;
    Label319: TLabel;
    Label320: TLabel;
    Label321: TLabel;
    Label322: TLabel;
    Label323: TLabel;
    Label324: TLabel;
    Label325: TLabel;
    Label326: TLabel;
    Label327: TLabel;
    Label328: TLabel;
    Label329: TLabel;
    Label330: TLabel;
    Label331: TLabel;
    Label332: TLabel;
    Label333: TLabel;
    Label350: TLabel;
    DBEdit75: TDBEdit;
    DBEdit82: TDBEdit;
    DBEdit83: TDBEdit;
    DBEdit84: TDBEdit;
    DBEdit85: TDBEdit;
    DBEdit86: TDBEdit;
    DBEdit87: TDBEdit;
    DBEdit88: TDBEdit;
    DBEdit89: TDBEdit;
    DBEdit90: TDBEdit;
    DBComboBox30: TDBComboBox;
    Panel6: TPanel;
    Button2: TLbSpeedButton;
    LbSpeedButton1: TLbSpeedButton;
    LbSpeedButton2: TLbSpeedButton;
    GBEdifZone: TGroupBox;
    Label38: TLabel;
    DBEdit53: TDBEdit;
    Label42: TLabel;
    Label83: TLabel;
    DBEdit51: TDBEdit;
    Label103: TLabel;
    Label84: TLabel;
    DBEdit52: TDBEdit;
    Label102: TLabel;
    Label115: TLabel;
    DBEdit46: TDBEdit;
    Label117: TLabel;
    LbSpeedButton3: TLbSpeedButton;
    GBEdifImpianto: TGroupBox;
    Label177: TLabel;
    DBComboBox37: TDBComboBox;
    LbSpeedButton4: TLbSpeedButton;
    GBEdifGeneratore: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit16: TDBEdit;
    Label3: TLabel;
    DBEdit1: TDBEdit;
    Label4: TLabel;
    DBEdit2: TDBEdit;
    Label6: TLabel;
    LbSpeedButton5: TLbSpeedButton;
    LbSpeedButton6: TLbSpeedButton;
    LbSpeedButton7: TLbSpeedButton;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    GBTubazioni: TGroupBox;
    DBRadioGroup1: TDBRadioGroup;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    CBCrono: TCheckBox;
    Label175: TLabel;
    DBComboBox12: TDBComboBox;
    Label176: TLabel;
    DBComboBox13: TDBComboBox;
    CBValv: TCheckBox;
    CBZone: TCheckBox;
    Label10: TLabel;
    DBEdit6: TDBEdit;
    Label11: TLabel;
    Label12: TLabel;
    DBComboBox1: TDBComboBox;
    LbSpeedButton8: TLbSpeedButton;
    Label14: TLabel;
    Label43: TLabel;
    DBComboBox2: TDBComboBox;
    Label13: TLabel;
    DBEdit7: TDBEdit;
    Label15: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure btnArchivioClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
    procedure LbSpeedButton4Click(Sender: TObject);
    procedure LbSpeedButton5Click(Sender: TObject);
    procedure LbSpeedButton7Click(Sender: TObject);
    procedure LbSpeedButton6Click(Sender: TObject);
    procedure DBComboBox12Change(Sender: TObject);
    procedure CBValvClick(Sender: TObject);
    procedure CBCronoClick(Sender: TObject);
    procedure CBZoneClick(Sender: TObject);
    procedure LbSpeedButton8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;
Procedure GestEdificio3D;
Procedure Carica_gen(Path:string);

var
  FEdificio3d: TFEdificio3d=Nil;

implementation
uses init_Cad3D;
{$R *.dfm}

Procedure Compila_edificio3D;
begin
if Fedificio3d<>Nil then
with Fedificio3d do
  begin
  compilaform(GBLocSemp,'Fabbricato',dmtutti.ds_Fabbricato);
  compilaform(GBTubazioni,'Fabbricato',dmtutti.ds_Fabbricato);
  dmtutti.T_zone.First;
  compilaform(GBEdifZone,'Zone',dmtutti.ds_zone);
  dmtutti.T_Impianti.First;
  dmtutti.T_Impianti.Open;
  compilaform(GBEdifImpianto,'Impianti',dmtutti.ds_Impianti);
  dmtutti.T_Generatori.First;
  compilaform(GBEdifGeneratore,'Generatori',dmtutti.ds_Generatori);
  Button2Click(nil);
  DBComboBox12Change(nil);
  end;
end;
Procedure GestEdificio3D;
begin
If Fedificio3D=Nil then FEdificio3d:=TFedificio3d.Create(Nil);
FEdificio3d.ShowModal;
end;

procedure TFEdificio3d.FormActivate(Sender: TObject);
begin
Compila_edificio3D;
end;

procedure TFEdificio3d.btnArchivioClick(Sender: TObject);
Var nomec:string;
    perc:string;
begin
perc:=percorso_archivi;
dmtutti.T_Fabbricato.Edit;
dmtutti.T_Fabbricato.POst;
Nomec:=sceltaGenerica('comune',i_sl(perc)+'comuni.db','Comuni.db','Comune',false);
if Nomec<>'' then
Copia_Dati_Comuni_Tabelle(FsceltaArch.t1,dmtutti.T_fabbricato, tpedit);
Fsceltaarch.t1.Close;
end;

procedure TFEdificio3d.Button2Click(Sender: TObject);
begin
dmtutti.T_Fabbricato.Edit;
dmtutti.T_Fabbricato.POst;
dmtutti.T_Fabbricato.Edit;
dmtutti.T_Zone.Edit;
dmtutti.T_Zone.POst;
dmtutti.T_Zone.Edit;
dmtutti.T_Impianti.Edit;
dmtutti.T_Impianti.POst;
dmtutti.T_Impianti.Edit;
end;

procedure TFEdificio3d.LbSpeedButton1Click(Sender: TObject);
begin
Close;
end;

procedure TFEdificio3d.LbSpeedButton2Click(Sender: TObject);
begin
EseguiMenuDll('FABBRICATO');
end;

procedure TFEdificio3d.LbSpeedButton3Click(Sender: TObject);
begin
EseguiMenuDll('Zone');
end;

procedure TFEdificio3d.LbSpeedButton4Click(Sender: TObject);
begin
EseguiMenuDll('Impianti');
end;

procedure TFEdificio3d.LbSpeedButton5Click(Sender: TObject);
begin
GestGeneratore3D;
end;

Procedure Carica_gen(Path:string);
Var codgen,descrgen,modgen:string;
    tempgen:real;
    numgen:integer;
begin
dmtutti.T_generatori.edit;
dmtutti.T_generatori.Post;
dmtutti.T_generatori.edit;
modgen:=sceltaGenerica('generatore',i_sl(path)+'Generatori.db','Generatori','Modello',false);
if modgen<>'' then
  begin
  codgen:=V_recgenerat.cod;
  descrgen:=V_recgenerat.Descrizione;
  //tempgen:=V_recgenerat.TempH2O;
  Numgen:=V_recgenerat.Numero;
  Copia_Dati_Comuni_Tabelle(FsceltaArch.t1,dmtutti.T_Generatori, tpedit);
  dmtutti.T_generatori.edit;
  V_recgenerat.set_cod(codgen);
  V_recgenerat.set_Descrizione(descrgen);
  //V_recgenerat.set_TempH2O(tempgen);
  V_recgenerat.set_numero(Numgen);
  dmtutti.T_generatori.Post;
  dmtutti.T_generatori.edit;
  end;
Fsceltaarch.t1.Close;
end;
procedure TFEdificio3d.LbSpeedButton7Click(Sender: TObject);
begin
Carica_gen(Percorso_archivi);
end;
procedure TFEdificio3d.LbSpeedButton6Click(Sender: TObject);
begin
Carica_gen(Percorso_archivi_personali_in);
end;

Var cambia_cb_reg:boolean=true;

procedure TFEdificio3d.DBComboBox12Change(Sender: TObject);
begin
cambia_cb_reg:=false;
dmtutti.T_Impianti.edit;
dmtutti.T_Impianti.Post;
dmtutti.T_Impianti.edit;
cbvalv.Checked:=false;
cbcrono.Checked:=false;
cbzone.Checked:=false;
if pos('AMBIENTE',uppercase(V_recimp.tipoReg))<>0
then cbvalv.Checked:=true;
if pos('ZONA',uppercase(V_recimp.tiporeg))<>0
then cbzone.Checked:=true;
if pos('CLIMATICO',uppercase(V_recimp.tiporeg))<>0
then cbcrono.Checked:=true;
cambia_cb_reg:=true;
end;

Procedure AggiornaCbReg;
begin
dmtutti.T_Impianti.edit;
V_recimp.set_tipoProd('Termostato di caldaia');
V_recimp.set_tipoReg('Regolazione manuale');
with FEdificio3d do
  begin
  if cbcrono.Checked then
    begin
    V_recimp.set_tipoProd('Regolatore climatico e/o ottimizzatore');
    V_recimp.set_tipoReg('Climatico centralizzato');
    end;
  if cbZone.Checked then
    begin
    if Cbcrono.Checked then
    V_recimp.set_tipoReg('Climatico + zona')
    else  V_recimp.set_tipoReg('Solo di zona');
    V_recimp.set_tipoProd('Regolatore modulante (banda proporzionale 2 °C)');
    CbValv.Checked:=false;
    end
  else
    begin
    if cbvalv.Checked then
      begin
      V_recimp.set_tipoProd('Regolatore modulante (banda proporzionale 2 °C)');
      if Cbcrono.Checked then
      V_recimp.set_tipoReg('Climatico + singolo ambiente')
      else V_recimp.set_tipoReg('Solo per singolo ambiente');
      end;
    end;
  end;
dmtutti.T_Impianti.Post;
dmtutti.T_Impianti.edit;
end;
procedure TFEdificio3d.CBValvClick(Sender: TObject);
begin
if not (cambia_cb_reg) then exit; //blocca gli eventi
cambia_cb_reg:=false;
if cbvalv.Checked then  cbzone.Checked:=false;
AggiornaCbReg;
cambia_cb_reg:=true;
end;
procedure TFEdificio3d.CBCronoClick(Sender: TObject);
begin
if not (cambia_cb_reg) then exit; //blocca gli eventi
cambia_cb_reg:=false;
AggiornaCbReg;
cambia_cb_reg:=true;
end;

procedure TFEdificio3d.CBZoneClick(Sender: TObject);
begin
if not (cambia_cb_reg) then exit; //blocca gli eventi
cambia_cb_reg:=false;
if cbzone.Checked then  cbvalv.Checked:=false;
AggiornaCbReg;
cambia_cb_reg:=true;
end;

procedure TFEdificio3d.LbSpeedButton8Click(Sender: TObject);
begin
Gest_terminali3d;
compilaform(GBEdifImpianto,'Impianti',dmtutti.ds_Impianti);
end;

end.
