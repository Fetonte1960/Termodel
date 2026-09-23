unit Piani3d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DBGrids, LbSpeedButton, ExtCtrls,Udbt,Ucompilaform,
  DBCtrls, Mask,CopiaLetturaDisegno3d,UDataLink, Buttons,gest_form,varcarichi;

type
  TFPiani3d = class(TForm)
    Panel2: TPanel;
    GroupBox1: TGroupBox;
    GroupBox23: TGroupBox;
    Label178: TLabel;
    Label179: TLabel;
    Label180: TLabel;
    Label181: TLabel;
    DBEdit1: TDBEdit;
    DBEdit25: TDBEdit;
    DBComboBox4: TDBComboBox;
    LbSpeedButton2: TLbSpeedButton;
    Label1: TLabel;
    LbSpeedButton4: TLbSpeedButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox2: TGroupBox;
    DBEdit2: TDBEdit;
    Label5: TLabel;
    Label6: TLabel;
    DBComboBox1: TDBComboBox;
    Label7: TLabel;
    GroupBox3: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBComboBox2: TDBComboBox;
    DBComboBox3: TDBComboBox;
    DBComboBox5: TDBComboBox;
    DBComboBox6: TDBComboBox;
    SpeedButton19: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    CBPianisfondo: TGroupBox;
    Label12: TLabel;
    Label15: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    GroupBox4: TGroupBox;
    Label13: TLabel;
    DBEdit3: TDBEdit;
    Label14: TLabel;
    Label16: TLabel;
    DBEdit4: TDBEdit;
    Label17: TLabel;
    Label18: TLabel;
    DBEdit5: TDBEdit;
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure LbSpeedButton4Click(Sender: TObject);
    procedure DBComboBox1Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBComboBox2Change(Sender: TObject);
    procedure DBComboBox5Change(Sender: TObject);
    procedure DBComboBox3Change(Sender: TObject);
    procedure DBComboBox6Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FPiani3d: TFPiani3d;
Procedure GestPiani3d;
Procedure NumeraPiani;

Var FGestform:TFGestForm=nil;
implementation
uses Init_Cad3D, U3dsd;
{$R *.dfm}

Procedure NumeraPiani;
Var Indcor,countpiani,i,j:integer;
    arNumpiani:array[1..maxpiani]of integer;
    trov:boolean;
begin
with dmtutti.T_piani do
  begin
  disablecontrols;
  countpiani:=0;
  first;
  while not eof do
    begin
    inc(countPiani);
    arNumpiani[countPiani]:=V_recPia.Indice;
    Next;
    end;
  For i:=1 to CountPiani do
    begin
    //Verifica numerazioni ripetute
    for j:=1 to i-1 do if arNumpiani[j]=arNumpiani[i] then arNumpiani[i]:=0;
    //Numera
    if arNumpiani[i]=0 then
      begin
      Indcor:=0;
        repeat
        inc(indcor);
        trov:=true;
        for j:=1 to CountPiani do if arNumpiani[j]=indcor then trov:=false;
        until trov;
      arNumpiani[i]:=indcor;
      end;
    end;
  first;
  while not eof do
    begin
    edit;
    V_recPia.set_Indice(arNumpiani[recno]);
    POst;
    Next;
    end;
  enablecontrols;  
  end;
end;

Procedure Chiusura;
begin
NumeraPiani;
dmtutti.T_Piani.Edit;
dmtutti.T_Piani.POst;
compilaform(form1.groupbox2,'ConfCad',dmtutti.ds_confcad);
if V_RecConfcad.PIANOCOR='' then
  begin
  SalvaPiano(form1.DBCombobox1.text,form1.RadioButton1.Checked,true);
  if V_recPia.Cod<>'' then
    begin
    dmtutti.T_ConfCad.Edit;
    V_RecConfcad.Set_PIANOCOR(V_recPia.Cod);
    dmtutti.T_ConfCad.Post;
    end;
  Apripiano(form1.RadioButton1.Checked,form1.DBCombobox1.text);
  ridisegna;
  end;
nocambia:=false;
end;

Procedure aggiorna;
begin
dmtutti.T_Piani.edit;;
dmtutti.T_Piani.Post;
compilaform(FPiani3d.groupbox1,'Piani',dmtutti.ds_PIani);
//NumeraPiani;
end;

Procedure Nuovar;
begin
dmtutti.T_Piani.edit;;
V_recPia.Set_Indice(0);
dmtutti.T_Piani.Post;
NumeraPiani;
dmtutti.T_Piani.edit;;
end;

Procedure GestPiani3d;
begin
Piani_In_memoria:=false;
nocambia:=true;
{
if FPiani3d=Nil then FPiani3d:=TFPiani3d.Create(Nil);
FPiani3d.ShowModal;
}

//if FGestform=Nil then
  begin
  //if FPiani3d=Nil then
  FPiani3d:=TFPiani3d.Create(Nil);
  //FFinestre3d.initform;
  FGestform:=Nuova_formDB(FPiani3d,'PIANI','Codice',0);
  NumeraPiani;
  with FGestform do
    begin
    binserisci.Visible:=true;
    chiudi_form:=chiusura;
    Nuova_riga:=Nuovar;
    //binserisci.Visible:=false;
    aggiornaform:=aggiorna;
    //GF_Calcolo192:=true;
    //sel_associata:=false;
    //archivistandard;
    end;
  //FFinestre3d.setcombovetro;
  end;
FGestform.Showmodal;
end;
procedure TFPiani3d.LbSpeedButton2Click(Sender: TObject);
begin
CaricaPiantasfondo;
end;

procedure TFPiani3d.LbSpeedButton4Click(Sender: TObject);
begin
dmtutti.T_Piani.Edit;
V_recpia.Set_Rif_Pianta('');
V_recpia.Set_ScalaP(1);
dmtutti.T_Piani.POst;
end;

Procedure AGG_combo_piani;
begin
//with DBComboBox1.Items
end;
procedure TFPiani3d.DBComboBox1Click(Sender: TObject);
begin
//DBComboBox1.Items.Clear;
//dmtutti.T_Piani.fist;
end;

procedure TFPiani3d.SpeedButton19Click(Sender: TObject);
begin
ArchivioPareti;
end;

procedure TFPiani3d.SpeedButton1Click(Sender: TObject);
begin
ArchivioConfini;
end;

procedure TFPiani3d.SpeedButton3Click(Sender: TObject);
begin
ArchivioConfini;
end;

procedure TFPiani3d.DBComboBox2Change(Sender: TObject);
begin
dmtutti.T_Piani.Edit;
dmtutti.T_Piani.POst;
dmtutti.T_Piani.Edit;
if V_recpia.T_Pav='Interp' then
V_recpia.Set_C_Pav('Non sc');
dmtutti.T_Piani.POst;
dmtutti.T_Piani.Edit;
end;

procedure TFPiani3d.DBComboBox5Change(Sender: TObject);
begin
dmtutti.T_Piani.Edit;
dmtutti.T_Piani.POst;
dmtutti.T_Piani.Edit;
if V_recpia.T_Soff='Interp' then
V_recpia.Set_C_soff('Non sc');
dmtutti.T_Piani.POst;
dmtutti.T_Piani.Edit;
end;

procedure TFPiani3d.DBComboBox3Change(Sender: TObject);
begin
dmtutti.T_Piani.Edit;
dmtutti.T_Piani.POst;
dmtutti.T_Piani.Edit;
if V_recpia.C_Pav='Non sc' then
V_recpia.Set_T_Pav('Interp');
dmtutti.T_Piani.POst;
dmtutti.T_Piani.Edit;
end;

procedure TFPiani3d.DBComboBox6Change(Sender: TObject);
begin
dmtutti.T_Piani.Edit;
dmtutti.T_Piani.POst;
dmtutti.T_Piani.Edit;
if V_recpia.C_Soff='Non sc' then
V_recpia.Set_T_Soff('Interp');
dmtutti.T_Piani.POst;
dmtutti.T_Piani.Edit;
end;

procedure TFPiani3d.FormActivate(Sender: TObject);
begin
compilaform(groupbox1,'Piani',dmtutti.ds_PIani);
end;

end.
