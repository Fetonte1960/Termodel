unit SceltaA;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, LbSpeedButton, ExtCtrls,UCompilaForm,UdBT,
  DB, DBTables,config_var,libreriagenerale,varcarichi;

type
  TFSceltaArch = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Button1: TLbSpeedButton;
    Button2: TLbSpeedButton;
    CheckBox1: TCheckBox;
    Edit1: TEdit;
    DBGrid1: TDBGrid;
    DS1: TDataSource;
    T1: TTable;
    Label2: TLabel;
    LbSpeedButton1: TLbSpeedButton;
    Ta: TTable;
    DBGrid2: TDBGrid;
    Dsa: TDataSource;
    procedure T1FilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure LbSpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FSceltaArch: TFSceltaArch=Nil;

Function SceltaGenerica(Titolo,dbname,identif,campo:string;V_associata:boolean):string;
Function Percorso_archivi_personali_In:string;
Procedure Salva_in_archivio(nomea,chiave:string);
Function Percorso_archivi_personali_out:string;
function database(nomet:string):TTable;
function Datasource(nomet:string):TDatasource;
function associata(nomet:string):TTable;
Procedure Azzera_archpers;

implementation
Var Campogen,selez:string;
    P_arch_pers:string='';
{$R *.dfm}
function database(nomet:string):TTable;
Var i:integer;
begin
result:=nil;
nomet:=uppercase(nomet);
i:=1;
while (i< dmtutti.ComponentCount)and
      (not((dmtutti.Components[i-1] is TTable)and
       (uppercase((dmtutti.Components[i-1] as TTable).tablename)=nomet+'.DB'))
      )do inc(i);
if  (dmtutti.Components[i-1] is TTable) and(uppercase((dmtutti.Components[i-1] as TTable).tablename)=nomet+'.DB')
then result:=dmtutti.Components[i-1] as TTable;
end;
function Datasource(nomet:string):TDatasource;
Var i:integer;
begin
result:=nil;
i:=1;
nomet:=uppercase(nomet);
while (i< dmtutti.ComponentCount)and
      (not((dmtutti.Components[i-1] is TDatasource)and
       (uppercase(((dmtutti.Components[i-1] as TDatasource).DataSet as TTable).TableName)=nomet+'.DB'))
      )do inc(i);
if (dmtutti.Components[i-1] is TDatasource)and
       (uppercase(((dmtutti.Components[i-1] as TDatasource).DataSet as TTable).TableName)=nomet+'.DB')
then result:=dmtutti.Components[i-1] as Tdatasource;
end;
function associata(nomet:string):TTable;
Var i:integer;
    dsdb:Tdatasource;
begin
i:=1;
result:=nil;
nomet:=uppercase(nomet);
dsdb:=datasource(nomet);
if dsdb<>nil then
  begin
  while (i< dmtutti.ComponentCount)and
        (not((dmtutti.Components[i-1] is TTable)and
             ((dmtutti.Components[i-1] as TTable).mastersource =dsdb)
            )
        )do inc(i);
  if (dmtutti.Components[i-1] is TTable)and((dmtutti.Components[i-1] as TTable).mastersource =dsdb)
  then result:=dmtutti.Components[i-1] as TTable;
  end;
end;
Procedure Azzera_archpers;
begin
P_arch_pers:='';
salva_var('Percorso_archivi_personali','');
end;
Function Percorso_archivi_personali_in:string;
Var OpDlg:Topendialog;
begin
if P_arch_pers='' then
P_arch_pers:=Leggi_var('Percorso_archivi_personali');
if P_arch_pers='' then
  begin
  Opdlg:=TOpendialog.Create(nil);
  OPdlg.Title:='Selezionare il percorso con gli archivi personali';
  OPdlg.InitialDir:='C:\documenti';
  OPdlg.Files.Add('*.db');
  OPdlg.FileName:='*.db';
  OPdlg.Filter:='*.db';
  Opdlg.Execute;
  if fileexists(OPdlg.FileName) then
    begin
    P_arch_pers:=extractfilepath(OPdlg.FileName);
    salva_var('Percorso_archivi_personali',P_arch_pers);
    end;
  Opdlg.free;
  end;
result:=P_arch_pers;
end;
Function Percorso_archivi_personali_out:string;
Var OpDlg:TSavedialog;
begin
if P_arch_pers='' then
P_arch_pers:=Leggi_var('Percorso_archivi_personali');
if P_arch_pers='' then
  begin
  Opdlg:=Tsavedialog.Create(nil);
  OPdlg.Title:='Selezionare il percorso con gli archivi personali';
  OPdlg.InitialDir:='C:\documenti';
  OPdlg.Files.Add('*.db');
  OPdlg.FileName:='Generatori.db';
  OPdlg.Filter:='*.db';
  Opdlg.Execute;
  if OPdlg.filename<>'Generatori.db' then
    begin
    P_arch_pers:=extractfilepath(OPdlg.FileName);
    salva_var('Percorso_archivi_personali',P_arch_pers);
    end;
  Opdlg.free;
  end;
result:=P_arch_pers;
end;
Procedure Creaform;
begin
if FSceltaArch=Nil then FSceltaArch:=TFSceltaArch.create(Nil);
end;
Function SceltaGenerica(Titolo,dbname,identif,campo:string;V_associata:boolean):string;
var tempta:TTable;
begin
result:='';
campogen:=campo;
if not(fileexists(dbname)) then
  begin
  showmessage('Archivi non presenti nel percorso:'+dbname);
  Exit;
  end;
creaform;
with FSceltaArch do
  begin
  edit1.Text:='';
  t1.Filtered:=false;
  label2.Caption:=dbname;
  checkbox1.Checked:=false;
  t1.Close;
  t1.DatabaseName:=extractfilepath(dbname);
  t1.TableName:=extractfilename(identif);
  tempta:=associata(copy(t1.TableName,1,length(t1.TableName)-3));
  dbgrid2.visible:=false;
  if (tempta<>nil)and(V_associata) then
    begin
    ta.Close;
    ta.DatabaseName:=t1.DatabaseName;
    ta.TableName:=tempta.TableName;
    ta.IndexName:=tempta.IndexName;
    ta.Masterfields:=tempta.Masterfields;
    ta.open;
    dbgrid2.visible:=true;
    end;
  t1.Close;
  Caption:='Scelta '+Titolo;
  dbgrid1.Columns[0].FieldName:=campo;
  //compilaGriglia(dbgrid1,dbname,ds1);
  t1.Open;
  selez:='';
  showmodal;
  result:=selez;
  end;
end;
procedure TFSceltaArch.T1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
accept:=pos(uppercase(edit1.text),uppercase(t1.fieldbyname(campogen).asstring))<>0;
end;

procedure TFSceltaArch.CheckBox1Click(Sender: TObject);
begin
t1.Filtered:=checkbox1.Checked;
end;

procedure TFSceltaArch.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFSceltaArch.Button2Click(Sender: TObject);
begin
selez:=t1.fieldbyname(campogen).asstring;
close;
end;

procedure TFSceltaArch.DBGrid1DblClick(Sender: TObject);
begin
Button2Click(Nil)
end;
Procedure Salva_in_archivio(nomea,chiave:string);
{$I Mappadb}
var TT:TTable;
    risp:integer;
begin
campogen:=chiave;
creaform;
nomea:=uppercase(nomea);
if percorso_archivi_personali_out<>'' then
with FSceltaArch.T1 do
  begin
  close;
  filtered:=false;
  databasename:=percorso_archivi_personali_out;

  if nomea='GENERATORI' then
    begin
    {$IFNDEF Generico}
    FSceltaArch.edit1.text:=dmtutti.T_Generatori.fieldbyname(chiave).asstring;
    if not(fileexists(databasename+nomea+'.db')) then
    crea_generatori(FSceltaArch.t1);
    tablename:=nomea+'.db';
    Open;
    filtered:=true;
    if fieldbyname(chiave).asstring<>'' then
      begin
      risp:=Application.messagebox('Volete sostituirlo ?',Pchar('Modello "'+fieldbyname(chiave).asstring+ '" già presente in archivio '),MB_YESNO );
      if risp=6 then
         begin
         Copia_Dati_Comuni_Tabelle(dmtutti.T_Generatori,FsceltaArch.t1,tpedit);
         end;
      end
    else
      begin
      filtered:=false;
      last;
      Copia_Dati_Comuni_Tabelle(dmtutti.T_Generatori,FsceltaArch.t1,tpinsert);
      end;
    close;
    {$Endif}
    end
  else
    begin
    end;
  end;
end;
procedure TFSceltaArch.LbSpeedButton1Click(Sender: TObject);
begin
if t1.Eof then exit;
if ta.DatabaseName<>'' then
  begin
  ta.First;
  while not ta.Eof do ta.Delete;
  end;
t1.Delete;
end;

end.
