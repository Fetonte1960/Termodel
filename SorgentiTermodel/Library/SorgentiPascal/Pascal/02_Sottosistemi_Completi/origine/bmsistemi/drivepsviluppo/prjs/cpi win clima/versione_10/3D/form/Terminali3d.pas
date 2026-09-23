unit Terminali3d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,gest_form, StdCtrls, ComCtrls, DBCtrls, Mask, LbSpeedButton,
  ExtCtrls,udbt, Grids, DBGrids,ucompilaform;

type
  TFTerminali3d = class(TForm)
    GroupBox2: TGroupBox;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label17: TLabel;
    Image1: TImage;
    SpeedButton5: TLbSpeedButton;
    DBEdit3: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit10: TDBEdit;
    DBComboBox1: TDBComboBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    GB_DettTerm: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    DB_Potenza: TDBEdit;
    DB_Esponente: TDBEdit;
    DB_Larghezza: TDBEdit;
    DB_Altezza: TDBEdit;
    DB_Profondita: TDBEdit;
    DB_Interasse: TDBEdit;
    DB_Capacita: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Panel2: TPanel;
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Button4: TLbSpeedButton;
    Button2: TLbSpeedButton;
    Button3: TLbSpeedButton;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTerminali3d: TFTerminali3d;

Procedure Gest_terminali3d;
Var FGestform:TFGestForm=nil;

implementation

{$R *.dfm}
Procedure Gest_terminali3d;
begin
FTerminali3d:=TFTerminali3d.Create(Nil);
FGestform:=Nuova_formDB(FTerminali3d,'Terminali','Codice',2);
with FGestform do
  begin
  binserisci.Visible:=true;
  //chiudi_form:=chiusura;
  //aggiornaform:=aggiorna;
  end;
compilagriglia(FTerminali3d.DBGrid1,'DettaglioTerminali',dmtutti.DS_DettaglioTerminali);
FGestform.Showmodal;
end;


procedure TFTerminali3d.Button2Click(Sender: TObject);
begin
dmtutti.T_DettaglioTerminali.Edit;
dmtutti.T_DettaglioTerminali.Post;
dmtutti.T_DettaglioTerminali.Edit;
end;

procedure TFTerminali3d.Button4Click(Sender: TObject);
begin
dmtutti.T_DettaglioTerminali.append;
dmtutti.T_DettaglioTerminali.Edit;
end;

procedure TFTerminali3d.Button3Click(Sender: TObject);
begin
dmtutti.T_DettaglioTerminali.delete;
dmtutti.T_DettaglioTerminali.Edit;
end;

end.
