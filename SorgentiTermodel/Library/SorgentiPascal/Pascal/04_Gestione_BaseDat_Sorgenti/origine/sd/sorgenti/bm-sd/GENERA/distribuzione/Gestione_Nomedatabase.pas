unit Gestione_Nomedatabase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, ExtCtrls, StdCtrls,gest_form,udbt,Ucompilaform,
  Mask;

type
  TFNomeDatabase = class(TForm)
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    {$I DefCampi_NomeDatabase}
    DBNavigator1: TDBNavigator;
    DBGrid1: TDBGrid;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FNomeDatabase: TFNomeDatabase;

Procedure Gest_NomeDatabase;

Var FGestform:TFGestForm=nil;
implementation

{$R *.dfm}
Procedure Gest_NomeDatabase;
begin
  begin
  FNomeDatabase:=TFNomeDatabase.Create(Nil);
  {$I Associata_NomeDatabase}
  FGestform:=Nuova_formDB(FNomeDatabase,'NomeDatabase','Campo_Codice',TagDescr);
  with FGestform do
    begin
    end;
  end;
FGestform.Showmodal;
end;
end.
