unit UDBT;

interface

uses
  SysUtils, Classes, DB, kbmMemTable, DbtablesQ,dbtables,funzUDBT,libreriagenerale;

Type dbcom=(Init,chiudi,nuovo,nuovoarch,apri,salva,salvaarch,leggi);
  TDMTutti = class(TDataModule)
    T_Campi: TTable;
    DS_Campi: TDataSource;
    T_Rec: TTable;
    DS_Rec: TDataSource;
  procedure ONNewRecord(DataSet: TDataSet);
  procedure ONFilterRecord(DataSet: TDataSet;var Accept: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure ComDB(action:DBCom;Par,ParA:string);
  end;

var
  DMTutti: TDMtutti;

Var Tipofiltro,ValF1,ValF2,ValF3:string;
implementation

Uses Udatalink,udb;
{$R *.dfm}

{$I MappaDB}
{$I SaveFile}
Procedure TDMTutti.ComDB(action:DBCom;Par,ParA:string);
Begin
{$I ComDB}
End;
{$I Init }
procedure TDMTutti.ONFilterRecord(DataSet: TDataSet;var Accept: Boolean);
Var nometab:string;
begin
nometab:=(dataset as TTable).TableName;
nometab:=uppercase(copy(nometab,1,length(nometab)-3));
{$I Filtri_DB}
end;
procedure TDMTutti.ONNewRecord(DataSet: TDataSet);
Var TLoc: TTable;
begin
TLoc:=Dataset as TTable;
InitDb(copy(Tloc.tablename,1,length(TLoc.tablename)-3));
end;
end.
