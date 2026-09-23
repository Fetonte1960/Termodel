unit Generatori3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, ExtCtrls, StdCtrls, Grids, DBGrids,dbtables,udbt,db,libreriagenerale,Ucompilaform,
  dateutils, Mask, DBCtrls,gest_form,Udatalink, Buttons, ComCtrls,edificio3d,sceltaA;

type
  TFGeneratori3d = class(TForm)
    GroupBox8: TGroupBox;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label43: TLabel;
    DBComboBox1: TDBComboBox;
    DBEdit2: TDBEdit;
    DBEdit16: TDBEdit;
    DBComboBox2: TDBComboBox;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    Label20: TLabel;
    Label18: TLabel;
    Label8: TLabel;
    DBComboBox3: TDBComboBox;
    DBEdit3: TDBEdit;
    DBEdit9: TDBEdit;
    GroupBox3: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    SpeedButton5: TLbSpeedButton;
    Label44: TLabel;
    Label45: TLabel;
    Label37: TLabel;
    Label19: TLabel;
    DBComboBox5: TDBComboBox;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit17: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    GroupBox11: TGroupBox;
    Label35: TLabel;
    Label36: TLabel;
    Label17: TLabel;
    Label22: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    GBPel: TGroupBox;
    Label10: TLabel;
    Label15: TLabel;
    Label26: TLabel;
    Label34: TLabel;
    DBEdit5: TDBEdit;
    DBEdit11: TDBEdit;
    TabSheet4: TTabSheet;
    GBPmot: TGroupBox;
    Label75: TLabel;
    Label80: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    DBEdit34: TDBEdit;
    DBEdit38: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit6: TDBEdit;
    Panel6: TPanel;
    LbSpeedButton2: TLbSpeedButton;
    LbSpeedButton6: TLbSpeedButton;
    LbSpeedButton7: TLbSpeedButton;
    procedure DBComboBox1Change(Sender: TObject);
    procedure LbSpeedButton6Click(Sender: TObject);
    procedure LbSpeedButton7Click(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGeneratori3d: TFGeneratori3d;

Var FGestform:TFGestForm=nil;
Procedure Gest_Generatori3d;


implementation

{$R *.dfm}

Procedure Aggiorna;
Begin
Dmtutti.T_Generatori.Edit;
Dmtutti.T_Generatori.POst;
Dmtutti.T_Generatori.Edit;
with FGeneratori3d do
if Uppercase(V_recgenerat.Tipo)='CALDAIA' then
  begin
  groupbox3.Visible:=true;
  groupbox11.Visible:=false;
  end
else
  begin
  groupbox3.Visible:=false;
  groupbox11.Visible:=true;
  end;
end;
Procedure Gest_Generatori3d;
begin
  begin
  FGeneratori3D:=TFGeneratori3d.Create(Nil);
  FGestform:=Nuova_formDB(FGeneratori3d,'Generatori','Codice',2);
  with FGestform do
    begin
    aggiornaform:=aggiorna;
    //chiudi_form:=chiusura;
    aggiorna;
    end;
  end;
FGestform.Showmodal;
end;


procedure TFGeneratori3d.DBComboBox1Change(Sender: TObject);
begin
aggiorna;
end;

procedure TFGeneratori3d.LbSpeedButton6Click(Sender: TObject);
begin
Carica_gen(Percorso_archivi_personali_in);
end;

procedure TFGeneratori3d.LbSpeedButton7Click(Sender: TObject);
begin
Carica_gen(Percorso_archivi);
end;

procedure TFGeneratori3d.LbSpeedButton2Click(Sender: TObject);
begin
Salva_in_archivio('Generatori','Modello');
end;

end.
