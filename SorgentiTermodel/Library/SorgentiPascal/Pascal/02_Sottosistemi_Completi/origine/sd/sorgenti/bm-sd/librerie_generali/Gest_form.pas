unit Gest_form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, LbSpeedButton, ExtCtrls,dbtables,db,ucompilaform,
  Mask, DBCtrls, ComCtrls,udbt,gestudb,sceltaA,libreriagenerale,menus,creadbt,
  FileCtrl;

type
  TFGestForm = class(TForm)
    Panel6: TPanel;
    Button2: TLbSpeedButton;
    Button3: TLbSpeedButton;
    LbSpeedButton1: TLbSpeedButton;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    GroupBox2: TGroupBox;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    Button4: TLbSpeedButton;
    Binserisci: TLbSpeedButton;
    Label4: TLabel;
    Edit1: TEdit;
    Label1: TLabel;
    DBEdit2: TDBEdit;
    Panel2: TPanel;
    PageControl1: TPageControl;
    LbSpeedButton2: TLbSpeedButton;
    LbSpeedButton3: TLbSpeedButton;
    LbSpeedButton4: TLbSpeedButton;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    Panel3: TPanel;
    DirectoryListBox1: TDirectoryListBox;
    Panel4: TPanel;
    Panel5: TPanel;
    Label7: TLabel;
    LbSpeedButton5: TLbSpeedButton;
    Label8: TLabel;
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BinserisciClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button3Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LbSpeedButton4Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
  private
   Function ControllaCod:boolean;
    { Private declarations }
  public
   Tabdb:TTable;
   Tabdba:TTable;
   DsDB:TDatasource;
   Tabslave:TTable;
   CampoCod:string;
   GF_calcolo192:boolean;
   GF_pareti:boolean;
   GF_Reti:boolean;
   Archivi_standard:boolean;
   Sel_associata:boolean;
   tempt,tempta:TTable;
   tempds:Tdatasource;
   nuova_riga:Tprocedure;
   chiudi_form:Tprocedure;
   aggiornaform:Tprocedure;
   salva_arch:Tprocedure;
   leggi_arch:Tprocedure;
   nometab:string;
   ChildForm:Tcontrol;
   //Nuova_riga:Tprocedure=Nuovariga;
   Procedure Aggiorna_form;
   procedure InitForm(Nomet,c_cod:string;TagDes:integer;TT:Ttable;Ds:Tdatasource);
   procedure archivistandard;
   Procedure Nuovariga;
   Procedure tabdbPost;
   Procedure Insert_tab;
   Procedure Insert_taba;
   Procedure Attivaform;
    { Public declarations }
  end;

Function Nuova_formDB(Form:Tcontrol;Nomet,c_cod:string;TagDes:integer):TFGestForm;

Var POsform:TPOsition=poMainFormCenter;

implementation

Procedure L_A;
begin
end;
Procedure S_A;
begin
end;
Procedure N_R;
begin
end;
Procedure A_F;
begin
end;
{$R *.dfm}
Function Nuova_formDB(Form:Tcontrol;Nomet,c_cod:string;TagDes:integer):TFGestForm;
var i,lgrid:integer;
begin
//Application.CreateForm(TFGestForm,result);
result:=TFGestForm.Create(nil);
nomet:=uppercase(nomet);
with result do
  begin
  //position:=POsform; da chiarire dove serviva
  ChildForm:=form;
  //if tabdb.FieldByName(campocod).asstring= ''then
  binserisci.visible:=false;
  nometab:=nomet;
  if Nomet='STRUTTURE' then
    begin
    GF_calcolo192:=true;
    GF_pareti:=true;
    end;
  if Nomet='RETI' then
    begin
    GF_calcolo192:=true;
    GF_reti:=true;
    end;
  directoryListBox1.Directory:='C:\bm sistemi srl\distribuzioni\archivi\clima\archivi\pareti\';
  nuova_riga;
  tabdb:=database(nomet);
  dsdb:=datasource(nomet);
  tabdba:=associata(nomet);
  sel_associata:=true;
  tempt.close;
  tempt.DatabaseName:=tabdb.DatabaseName;
  tempt.tablename:=tabdb.TableName;
  if tabdba<>nil then
     begin
     tempds.DataSet:=tempt;
     tempta.close;
     tempta.DatabaseName:=tempt.DatabaseName;
     tempta.tablename:=tabdba.TableName;
     tempta.Mastersource:=tempds;
     tempta.IndexName:=tabdba.IndexName;
     tempta.Masterfields:=tabdba.Masterfields;
     end;
  CampoCod:=C_cod;
  if tagdes<>0 then
  DbEdit1.Tag:=TagDes
  else
    begin
    label2.Visible:=false;
    dbedit1.Visible:=false;
    end;
  compilagriglia(dbgrid1,NomeT,DsDb);
  compilaform(groupbox2,NomeT,DsDb);
  dbedit2.DataSource:=dsdb;
  dbedit2.dataField:=campocod;
  tabdb.Edit;
  tabdbPost;
  Lgrid:=0;
  for i:=1 to DBGrid1.FieldCount do
  lgrid:=lgrid+DBGrid1.columns[i-1].Width;
  //DBGrid1.Width:=Lgrid+38;
  Panel3.Width:=Lgrid+38;
  Width:=Form.width+dbgrid1.width+10;
  height:=form.height+groupbox2.height+panel6.height+40;
  //form.Top:=panel2.Top+top+28;
  //form.left:=left+panel1.left+5;
  Compilaform_auto(form);
  for i:=1 to form.ComponentCount do
  if form.Components[i-1] is Tmainmenu then
  result.Menu :=form.Components[i-1] as Tmainmenu;
  result.caption:=(form as tform).caption;
  form.manualdock(pagecontrol1,Form,alclient);
  groupbox2.width:=panel2.Width;
  dbedit1.Width:=groupbox2.width-dbedit1.Left-10;
  //form.Height:=form.Height-30;
  attivaform;
  form.Show;
  end;
end;
Procedure TFGestForm.Attivaform;
begin
if (tabdb.eof)or(tabdb.FieldByName(campocod).asstring= '' )then
  begin
  Panel1.Visible:=false;
  Panel2.Visible:=false;
  groupbox2.Visible:=false;
  ChildForm.Visible:=false
  end
else
  begin
  Panel1.Visible:=true;
  Panel2.Visible:=true;
  groupbox2.Visible:=true;
  ChildForm.Visible:=true;
  end;
end;

Procedure TFGestForm.Aggiorna_form;
begin
{if A_F then} Aggiornaform;
Attivaform;
end;

Procedure TFGestForm.tabdbPost;
begin
if tabdb.FieldByName(campocod).asstring<>''then
tabdb.Post;
end;
Procedure TFGestForm.Nuovariga;
begin
{if n_r then} nuova_riga;
end;

Procedure chiudiform;
begin
end;

procedure TFGestForm.LbSpeedButton1Click(Sender: TObject);
begin
//chiudi_form;
Close;
end;
procedure TFGestForm.archivistandard;
begin
LbSpeedButton2.Visible:=true;
radiobutton1.Visible:=true;
radiobutton2.Visible:=true;
//LbSpeedButton3.Visible:=true;
//LbSpeedButton4.Visible:=true;
end;
procedure TFGestForm.InitForm(Nomet,c_cod:string;TagDes:integer;TT:Ttable;Ds:Tdatasource);
begin
nuova_riga;
tabdb:=Tt;
DsDb:=Ds;
GF_calcolo192:=false;
GF_pareti:=true;
GF_reti:=false;
CampoCod:=C_cod;
DbEdit1.Tag:=TagDes;
compilagriglia(dbgrid1,NomeT,DsDb);
compilaform(groupbox2,NomeT,DsDb);
dbedit2.DataSource:=dsdb;
dbedit2.dataField:=campocod;
tabdb.Edit;
tabdbPost;
end;

Function TFGestForm.ControllaCod:boolean;
begin
result:=false;
if Edit1.text='' then
showmessage('Inserire un codice per la nuova riga')
else result:=true;
end;

procedure TFGestForm.Button4Click(Sender: TObject);
Var flt:boolean;
begin
if controllacod then
  begin
  flt:=tabdb.Filtered;
  tabdb.Filtered:=false;
  if ( tabdb.eof)or(tabdb.FieldByName(campocod).AsString<>'')
  then tabdb.append;
  tabdb.edit;
  tabdb.FieldByName(campocod).AsString:=Edit1.text;
  Nuovariga;
  tabdb.edit;
  tabdbpost;
  tabdb.Filtered:=flt;
  Aggiorna_form;
  tabdb.Last;
  end;
end;

procedure TFGestForm.Button2Click(Sender: TObject);
begin
tabdb.edit;
tabdbpost;
Aggiorna_form;
end;

procedure TFGestForm.BinserisciClick(Sender: TObject);
begin
if controllacod then
  begin
  if ( tabdb.eof)or(tabdb.FieldByName(campocod).AsString<>'')
  then Insert_Tab;//tabdb.insert;
  tabdb.edit;
  tabdb.FieldByName(campocod).AsString:=Edit1.text;
  tabdbpost;
  Nuovariga;
  Aggiorna_form;
  end;
end;

procedure TFGestForm.DBGrid1CellClick(Column: TColumn);
begin
Aggiorna_form;
end;

procedure TFGestForm.Button3Click(Sender: TObject);
begin
if tabdba<>nil then
  begin
  tabdba.First;
  while not tabdba.Eof do tabdba.Delete;
  end;
tabdb.delete;
attivaform;
end;



procedure TFGestForm.DBGrid1DrawColumnCell(Sender: TObject;

  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
{
begin
procedure TFSoloMuri.DBGrid3DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn;
                                           State: TGridDrawState);
}
var
   NRect : TRect;
   TempStr : String;
   TempGrg : TDBGrid;
   NCol : Integer;
   Colore : TColor;
begin
if GF_Calcolo192 then
   begin
   NRect := Rect;
   NRect.Left := NRect.Left + 1;
   NRect.Right := NRect.Right - 1;
   TempGrg := (Sender As TDBGrid);
   TempStr := Column.Field.AsString;

     if tabdb.FieldByName('Codice').AsString <> '' then
     begin
     if GF_reti then
       begin
           If (DataCol = 1) Then
           Begin
             If CompareStr('SI', UpperCase(TempStr)) = 0 Then
             Begin
               TempGrg.Canvas.Font.Style := [fsBold];
               TempGrg.Canvas.Font.Color := clWhite;
               TempGrg.Canvas.Brush.Color := $0000B700;
               TempStr := 'Positiva';
             End
             Else
                If CompareStr('NO', UpperCase(TempStr)) = 0 Then
                Begin
                  TempGrg.Canvas.Font.Style := [fsBold];
                  TempGrg.Canvas.Font.Color := clWhite;
                  TempGrg.Canvas.Brush.Color := $000000DF;
                  TempStr := 'Negativa';
                end
                else
                If CompareStr('PS', UpperCase(TempStr)) = 0 Then
                Begin
                  TempGrg.Canvas.Font.Style := [fsBold];
                  TempGrg.Canvas.Font.Color := clWhite;
                  TempGrg.Canvas.Brush.Color := $0028C5F2;
                  TempStr := 'Positiva';
                end
                else
                begin
                  TempGrg.Canvas.Font.Color := clBlack;
                  TempGrg.Canvas.Brush.Color := clWhite;
                  TempStr := '---';
                end;
             TempGrg.Canvas.FillRect(Rect);
             DrawText(TempGrg.Canvas.Handle, PChar(TempStr), Length(TempStr), NRect, DT_VCENTER);
           end
       end
       else
       if GF_Pareti then
       begin
         If (DataCol = 2) or (DataCol = 3) Then
         Begin
           If CompareStr('SI', UpperCase(TempStr)) = 0 Then
           Begin
             TempGrg.Canvas.Font.Style := [fsBold];
             TempGrg.Canvas.Font.Color := clWhite;
             TempGrg.Canvas.Brush.Color := $0000B700;
             TempStr := 'Positiva';
           End
           Else
              If CompareStr('NO', UpperCase(TempStr)) = 0 Then
              Begin
                TempGrg.Canvas.Font.Style := [fsBold];
                TempGrg.Canvas.Font.Color := clWhite;
                TempGrg.Canvas.Brush.Color := $000000DF;
                TempStr := 'Negativa';
              end
              else
              If CompareStr('PS', UpperCase(TempStr)) = 0 Then
              Begin
                TempGrg.Canvas.Font.Style := [fsBold];
                TempGrg.Canvas.Font.Color := clWhite;
                TempGrg.Canvas.Brush.Color := $0028C5F2;
                TempStr := 'Positiva';
              end
              else
              begin
                TempGrg.Canvas.Font.Color := clBlack;
                TempGrg.Canvas.Brush.Color := clWhite;
                TempStr := '---';
              end;
           TempGrg.Canvas.FillRect(Rect);
           DrawText(TempGrg.Canvas.Handle, PChar(TempStr), Length(TempStr), NRect, DT_VCENTER);
         end;
       end
       else
       begin
           If (DataCol = 2) Then
           Begin
             If CompareStr('SI', UpperCase(TempStr)) = 0 Then
             Begin
               TempGrg.Canvas.Font.Style := [fsBold];
               TempGrg.Canvas.Font.Color := clWhite;
               TempGrg.Canvas.Brush.Color := $0000B700;
               TempStr := 'Positiva';
             End
             Else
                If CompareStr('NO', UpperCase(TempStr)) = 0 Then
                Begin
                  TempGrg.Canvas.Font.Style := [fsBold];
                  TempGrg.Canvas.Font.Color := clWhite;
                  TempGrg.Canvas.Brush.Color := $000000DF;
                  TempStr := 'Negativa';
                end
                else
                If CompareStr('PS', UpperCase(TempStr)) = 0 Then
                Begin
                  TempGrg.Canvas.Font.Style := [fsBold];
                  TempGrg.Canvas.Font.Color := clWhite;
                  TempGrg.Canvas.Brush.Color := $0028C5F2;
                  TempStr := 'Positiva';
                end
                else
                begin
                  TempGrg.Canvas.Font.Color := clBlack;
                  TempGrg.Canvas.Brush.Color := clWhite;
                  TempStr := '---';
                end;
             TempGrg.Canvas.FillRect(Rect);
             DrawText(TempGrg.Canvas.Handle, PChar(TempStr), Length(TempStr), NRect, DT_VCENTER);
           end;
       end;
     end;
    end;
end;

procedure TFGestForm.FormCreate(Sender: TObject);
begin
Nuova_riga:=N_R;
chiudi_form:=chiudiform;
AggiornaForm:=A_F;
Salva_arch:=S_a;
leggi_arch:=L_a;
Archivi_standard:=true;
tempt:=TTable.Create(nil);
tempta:=TTable.Create(nil);
tempds:=Tdatasource.Create(nil);
end;
//copiata da libreriagenerale e mofificata per evitare che copy il campo link  "Numero"
procedure Copia_Dati_Tabelle(Origine, Destinazione : TTable; Operazione : Tipo_Operazione);
 Var
   i, j : Integer;
 begin
     Case Integer(Operazione) of
       Ord(tpEdit) : Destinazione.Edit;
       Ord(tpInsert) : Destinazione.Insert;
     end;

     for j := 0 to Destinazione.FieldCount - 1 do
        for i := 0 to Origine.FieldCount - 1 do
           if (Destinazione.FieldDefs[j].Name<>'Numero')and(not (Destinazione.FieldDefs[j].DataType in [ftAutoInc]))
              and (CompareStr(UpperCase(Destinazione.Fields[j].FieldName),UpperCase(Origine.Fields[i].FieldName)) = 0) then
              begin
                if Destinazione.Fields[j].DataType = ftString then
                   Destinazione.Fields[j].AsString := Origine.Fields[i].AsString
                else if Destinazione.Fields[j].DataType = ftInteger then
                        Destinazione.Fields[j].AsInteger := Origine.Fields[i].AsInteger
                     else if Destinazione.Fields[j].DataType = ftFloat then
                             Destinazione.Fields[j].AsFloat := Origine.Fields[i].AsFloat;
                   Break
              end;

     Destinazione.Post;
 end;
procedure TFGestForm.LbSpeedButton2Click(Sender: TObject);
//{$I mappadb}
//var ttt:ttable;
var ss:string;
begin
if archivi_standard then
  begin
  {
  ttt:=ttable.Create(nil);
  ttt.DatabaseName:=percorso_archivi_personali_out;
  crea_strutture(ttt);
  crea_strati(ttt);
  ttt.Free;
  }
  if percorso_archivi_personali_out<>'' then
    begin
    tempt.close;
    tempt.DatabaseName:=percorso_archivi_personali_out;
    if not fileexists(tempt.DatabaseName+tempt.tablename) then
      begin
      tabdb.Close;
      ss:=tabdb.DatabaseName;
      if tabdba<>nil then
        begin
        tabdba.Close;
        tabdba.DatabaseName:=percorso_archivi_personali_out;
        end;
      tabdb.DatabaseName:=percorso_archivi_personali_out;
      creadatabase(copy(tabdb.tablename,1,length(tabdb.tablename)-3));
      tabdb.Close;
      tabdb.DatabaseName:=ss;
      tabdb.open;
      if tabdba<>nil then
        begin
        tabdba.Close;
        tabdba.DatabaseName:=ss;
        tabdba.open;
        end;
      end;
    tempt.open;
    tempt.last;
    Copia_Dati_Comuni_Tabelle(Tabdb,tempt,tpinsert);
    if tabdba<>nil then
      begin
      tempta.close;
      tempta.DatabaseName:=tempt.DatabaseName;
      tempta.open;
      tabdba.First;
      while not tabdba.eof do
        begin
        Copia_Dati_Tabelle(Tabdba,tempta,tpinsert);
        tabdba.Next;
        end;
      end;
    end;
  end
else Salva_arch;
end;

procedure TFGestForm.LbSpeedButton3Click(Sender: TObject);
var Perc_arc,scelta:string;
begin
if archivi_standard then
  begin
  perc_arc:=Percorso_archivi_personali_in;
  scelta:=SceltaGenerica('selezionare la struttura da importare',I_sl(Perc_arc)+tabdb.TableName,tabdb.TableName,'Descrizione',sel_associata);
  if scelta<>'' then
    begin
    tempt.close;
    tempt.DatabaseName:=perc_arc;
    tempt.open;
    tempt.first;
    while (not tempt.eof)and(tempt.FieldByName('Descrizione').asstring<>scelta) do tempt.next;
    if ( tabdb.eof)or(tabdb.FieldByName(campocod).AsString<>'')
    then  Copia_Dati_Comuni_Tabelle(tempt,tabdb, tpinsert)
    else Copia_Dati_Comuni_Tabelle(tempt,tabdb, tpedit);
    if tabdba<>nil then
      begin
      tempta.close;
      tempta.DatabaseName:=tempt.DatabaseName;
      tempta.open;
      tempta.First;
      while not tempta.eof do
        begin
        Copia_Dati_Tabelle(tempta,tabdba,tpinsert);
        tempta.Next;
        end;
      end;
    end;
  end
else leggi_arch;
aggiorna_form;
end;

Procedure TFGestForm.Insert_taba;
Var TT,tta:TTable;
    pos,posa:integer;
begin
if tabdba=nil then exit;
with tabdba do
  begin
  if recordcount=0 then
    begin
    append;
    exit;
    end;
  end;
with tabdb do
  begin
  pos:=recno;
  posa:=tabdba.recno;
  Close;
  databasename:=I_sl(percorsodrive)+'tempdb\';
  end;

with tabdba do
  begin
  Close;
  databasename:=I_sl(percorsodrive)+'tempdb\';
  end;
creadatabase(Nometab);

with tabdb do
  begin
  Close;
  databasename:=percorso_progetti;
  Open
  end;

with tabdba do
  begin
  Close;
  databasename:=percorso_progetti;
  Open;
  end;

tta:=TTable.Create(nil);
with tta do
  begin
  databasename:=I_sl(percorsodrive)+'tempdb\';
  tablename:=tabdba.tablename;
  open;
  end;


with tabdb do
  begin
  first;
  while recno<pos do next;
  end;
with tabdba do
  begin
  first;
  while recno<posa do next;
  end;
Copia_Dati_Tabelle(tabdba,tta,tpinsert);
while (tabdba.recno<tabdba.RecordCount) do
  begin
  tabdba.next;
  Copia_Dati_Tabelle(tabdba,tta,tpinsert);
  tta.first;
  Copia_Dati_Tabelle(tta,tabdba,tpedit);
  tta.Delete;
  tta.last;
  end;
Copia_Dati_Tabelle(tta,tabdba,tpinsert);
with tabdba do
  begin
  first;
  while recno<>posa do next;
  end;
tta.Free;
end;

Procedure TFGestForm.Insert_tab;
Var TT,tta:TTable;
    pos:integer;
begin
with tabdb do
  begin
  if recordcount=0 then
    begin
    append;
    exit;
    end;
  pos:=recno;
  Close;
  databasename:=I_sl(percorsodrive)+'tempdb\';
  end;
if tabdba<>nil then
with tabdba do
  begin
  Close;
  databasename:=I_sl(percorsodrive)+'tempdb\';
  end;
creadatabase(Nometab);
with tabdb do
  begin
  Close;
  databasename:=percorso_progetti;
  Open
  end;
if tabdba<>nil then
with tabdba do
  begin
  Close;
  databasename:=percorso_progetti;
  Open;
  end;

tt:=TTable.Create(nil);
with tt do
  begin
  databasename:=I_sl(percorsodrive)+'tempdb\';
  tablename:=tabdb.tablename;
  open;
  end;
tta:=TTable.Create(nil);
if tabdba<>nil then
with tta do
  begin
  databasename:=I_sl(percorsodrive)+'tempdb\';
  tablename:=tabdba.tablename;
  open;
  end;

with tabdb do
  begin
  first;
  while recno<pos do next;
  end;
Copia_Dati_Tabelle(tabdb,tt,tpinsert);
{
if tabdba=nil then
  begin
  tta.close;
  tta.emptytable;
  tta.Open;
  tabdba.First;
  while not tabdba.Eof do
    begin
    Copia_Dati_Tabelle(tabdba,tta,tpinsert);
    tabdba.Next;
    end;
  end;
 }
while (tabdb.recno<tabdb.RecordCount) do
  begin
  tabdb.next;
  Copia_Dati_Tabelle(tabdb,tt,tpinsert);
  tt.first;
  Copia_Dati_Tabelle(tt,tabdb,tpedit);
  tt.Delete;
  tt.last;
  end;
Copia_Dati_Tabelle(tt,tabdb,tpinsert);
with tabdb do
  begin
  first;
  while recno<>pos do next;
  end;
tt.Free;
tta.Free;
end;



procedure TFGestForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
chiudi_form;
childform.free;
action:=cafree;
end;

procedure TFGestForm.LbSpeedButton4Click(Sender: TObject);
begin
Azzera_archpers;
Percorso_archivi_personali_in;
end;

procedure TFGestForm.RadioButton1Click(Sender: TObject);
begin
if radiobutton1.Checked then
  begin
  lbspeedbutton2.caption:='Salva in archivio';
  Panel5.Visible:=false;
  //radiobutton2.Checked:=false;
  end
else
  begin
  lbspeedbutton2.caption:='Inpota in progetto';
  Panel5.Visible:=true;
  //radiobutton2.Checked:=true;
  end;
end;

end.
