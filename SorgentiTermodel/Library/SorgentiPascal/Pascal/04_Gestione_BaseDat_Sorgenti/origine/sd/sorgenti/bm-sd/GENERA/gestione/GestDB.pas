unit GestDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,gest_form, StdCtrls, Mask, DBCtrls, ExtCtrls, Grids, DBGrids,Ucompilaform,Udbt;

type
  TFGestDb = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    DBNavigator1: TDBNavigator;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBComboBox1: TDBComboBox;
    DBComboBox2: TDBComboBox;
    Label4: TLabel;
    Label5: TLabel;
    DBComboBox3: TDBComboBox;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    DBComboBox4: TDBComboBox;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit5: TDBEdit;
    Label10: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label11: TLabel;
    DBComboBox5: TDBComboBox;
    Label12: TLabel;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    Label13: TLabel;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FGestDb: TFGestDb;
Procedure Gest_Base_dati;
Var FGestform:TFGestForm=nil;
implementation

{$R *.dfm}
Procedure Gest_Base_dati;
begin
  begin
  FGestDb:=TFGestDb.Create(Nil);
  compilagriglia(FGestDb.dbgrid1,'Campi',dmtutti.DS_Campi);
  FGestDb.DbNavigator1.Datasource:=dmtutti.DS_Campi;
  FGestform:=Nuova_formDB(FGestDb,'REC','Codice',2);
  with FGestform do
    begin
    end;
  end;
FGestform.Showmodal;
end;
end.
