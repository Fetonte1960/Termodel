unit Ulettura;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Controls,
  Forms, Dialogs, ComCtrls, ExtCtrls, Grids, DBGrids, StdCtrls,
  DB, DBCtrls, Mask, Buttons, DBTables,
  {my uses}
  Udb, Ucompilaform, libreriagenerale,
  Ucaricatabelle, Gestionelettura, letturadisegnobidimensionale;

type
  TFLettura = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel4: TPanel;
    Panel7: TPanel;
    GroupBox6: TGroupBox;
    Memo1: TMemo;
    GroupBox5: TGroupBox;
    PageControl4: TPageControl;
    TabSheet8: TTabSheet;
    GroupBox7: TGroupBox;
    Label3: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    DBEdit1: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBComboBox6: TDBComboBox;
    DBComboBox7: TDBComboBox;
    DBEdit16: TDBEdit;
    TabSheet11: TTabSheet;
    GroupBox12: TGroupBox;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    DBComboBox8: TDBComboBox;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBComboBox9: TDBComboBox;
    DBEdit21: TDBEdit;
    DBEdit22: TDBEdit;
    DBComboBox10: TDBComboBox;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    Label58: TLabel;
    DBEdit26: TDBEdit;
    Label9: TLabel;
    Panel8: TPanel;
    SpeedButton4: TSpeedButton;
    Panel6: TPanel;
    GroupBox13: TGroupBox;
    DBGrid4: TDBGrid;
    PageControl2: TPageControl;
    Panel5: TPanel;
    Image1: TImage;
    GroupBox9: TGroupBox;
    DBGrid5: TDBGrid;
    Panel3: TPanel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label57: TLabel;
    Label59: TLabel;
    TabSheet3: TTabSheet;
    GroupBox11: TGroupBox;
    DBComboBox11: TDBComboBox;
    DBComboBox12: TDBComboBox;
    DBComboBox13: TDBComboBox;
    DBComboBox14: TDBComboBox;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Combo_TipoSoffitto: TComboBox;
    Combo_ConfineSoffitto: TComboBox;
    Combo_TipoPavimento: TComboBox;
    Combo_ConfinePavimento: TComboBox;
    Label64: TLabel;
    SB_Conferma: TSpeedButton;
    GroupBox2: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox3: TGroupBox;
    DBGrid2: TDBGrid;
    GroupBox1: TGroupBox;
    PageControl3: TPageControl;
    TabSheet6: TTabSheet;
    GroupBox8: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label1: TLabel;
    Label30: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBComboBox2: TDBComboBox;
    DBEdit6: TDBEdit;
    DBEdit25: TDBEdit;
    TabSheet10: TTabSheet;
    GroupBox10: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    DBComboBox3: TDBComboBox;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBComboBox4: TDBComboBox;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBComboBox5: TDBComboBox;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    SpeedButton1: TSpeedButton;
    Label65: TLabel;
    Ed_Volume: TEdit;
    Label66: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BokClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Combo_TipoSoffittoChange(Sender: TObject);
    procedure Combo_ConfineSoffittoChange(Sender: TObject);
    procedure Combo_TipoPavimentoChange(Sender: TObject);
    procedure Combo_ConfinePavimentoChange(Sender: TObject);
    procedure DBComboBox13Change(Sender: TObject);
    procedure DBComboBox14Change(Sender: TObject);
    procedure DBComboBox11Change(Sender: TObject);
    procedure DBComboBox12Change(Sender: TObject);
    procedure DBGrid4CellClick(Column: TColumn);
    procedure DBGrid4Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SB_ConfermaClick(Sender: TObject);
    procedure DBComboBox8Change(Sender: TObject);
    procedure DBComboBox9Change(Sender: TObject);
    procedure DBComboBox10Change(Sender: TObject);
    procedure DBComboBox6Change(Sender: TObject);
    procedure DBComboBox7Change(Sender: TObject);
    procedure DBGrid5CellClick(Column: TColumn);
    procedure DBGrid5Enter(Sender: TObject);
    procedure DBGrid4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid4KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    Procedure CompilaCombo_TS(Var cmb:Tcombobox; Dbase, NomeTabella:string; Campo:integer);
    function RestituisciDescrizione(Codice: String; Dbase, NomeTabella:string; Campo, Campo2:integer): String;
    function RestituisciCodice(Descrizione: String; Dbase, NomeTabella:string; Campo, Campo2:integer): String;

  public
    { Public declarations }
    Procedure ModificaValoriCombo;
  end;

var
  FLettura: TFLettura;
  Tabellare,invisibile:boolean;

Procedure Initlettura(dp,da,numamb:string);
Procedure DisAttiva_archPareti;
Procedure Attiva_archPareti;
Procedure eseguilettura(elimina:boolean);
Procedure Ridisegna;

implementation

uses grafica, Tool_visualizza;
{$R *.dfm}

Procedure Ridisegna;
begin
Redraw(FLettura.image1.Canvas,FLettura.image1,FLettura.panel5,0,0);
end;

Procedure Attiva_archPareti;
Var Nomearch:string;
begin
exit;
{dm1.TT0.close;
if Flettura.combobox2.text='Pareti' then nomearch:='Immagini';
if Flettura.combobox2.text='Finestre' then nomearch:='ImmaginiF';
if Flettura.combobox2.text='Ponti termici' then nomearch:='Ponti';
dm1.TT0.databasename:=Percorso_progetti;
dm1.TT0.TableName:=Nomearch;
if Flettura.combobox2.text<>'Ponti termici' then
  begin
  Flettura.DBImage1.DataSource:=dm1.DataSource0;
  Flettura.DBImage1.DataField:='Immagine';
  end
else Flettura.DBImage1.DataSource:=Nil;
Flettura.dbgrid3.DataSource:=dm1.DataSource0;
Flettura.dbgrid3.Columns[0].FieldName:='Descrizione';
dm1.TT0.open;        }
end;

Procedure DisAttiva_archPareti;
begin
{Flettura.DBImage1.DataField:='';
Flettura.dbgrid3.DataSource:=Nil;
}
end;

Procedure Initlettura(dp,da,numamb:string);
begin

if numamb='' then Tabellare:=false
else tabellare:=true;
if numamb='@#' then invisibile:=true
else invisibile:=false;
caricaspes;

Flettura:=TFlettura.Create(nil);

FTool_Visualizza:=TFTool_Visualizza.create(nil);
FTool_Visualizza.Show;
FTool_Visualizza.ManualDock(Flettura.Pagecontrol2, nil, alNone);
Flettura.Pagecontrol2.Pages[0].TabVisible := false;
Flettura.Pagecontrol2.ActivePageIndex := 0;

dm1.TT1.Close;
dm1.TT1.TableName:='Locali';
dm1.TT1.open;
dm1.TT3.Close;
dm1.TT3.TableName:='Pareti';
InitAssociata;
if not tabellare then Eseguilettura(True);
if numamb<>'' then cercaamb1(numamb);

 with flettura do
 begin
  dbedit1.Datasource:=dm1.datasource1;
  dbedit1.Datafield:='Descrizione';
  Attiva_archPareti;
  compilagriglia(dbgrid1,'Locali',dm1.datasource1);
  compilagriglia(dbgrid2,'Pareti',dm1.datasource3);
  compilagriglia(dbgrid5,'Pareti',dm1.datasource3);
  DBGrid5.Columns[0].width := 50;
  DBGrid5.Columns[0].Title.Alignment := taCenter;
  DBGrid5.Columns[0].Title.Caption := 'Confine';
  DBGrid5.Columns[1].width := 40;
  DBGrid5.Columns[1].Title.Alignment := taCenter;
  DBGrid5.Columns[1].Title.Caption := 'Lato';
  DBGrid5.Columns[2].width := 60;
  DBGrid5.Columns[2].Title.Alignment := taCenter;
  DBGrid5.Columns[2].Title.Caption := 'Tipo';
  DBGrid5.Columns[3].width := 65;
  DBGrid5.Columns[3].Title.Caption := 'Codice';
  DBGrid5.Columns[3].Title.Alignment := taCenter;
  DBGrid5.Columns[4].width := 40;
  DBGrid5.Columns[4].Title.Caption := 'Lung.';
  DBGrid5.Columns[4].Title.Alignment := taCenter;
  DBGrid5.Columns[5].width := 33;
  DBGrid5.Columns[5].Title.Caption := 'H1';
  DBGrid5.Columns[5].Title.Alignment := taCenter;
  DBGrid5.Columns[6].width := 50;
  DBGrid5.Columns[6].Title.Caption := 'Superf.';
  DBGrid5.Columns[6].Title.Alignment := taCenter;
  DBGrid5.Columns[7].width := 33;
  DBGrid5.Columns[7].Title.Caption := 'H2';
  DBGrid5.Columns[7].Title.Alignment := taCenter;


  compilagriglia(dbgrid4,'Locali',dm1.datasource1);
  DBGrid4.Columns[0].width := 54;
  DBGrid4.Columns[0].Title.Alignment := taCenter;
  DBGrid4.Columns[1].width := 100;
  DBGrid4.Columns[1].Title.Alignment := taCenter;
  DBGrid4.Columns[2].width := 90;
  DBGrid4.Columns[2].Title.Alignment := taCenter;

  Compilaform(groupbox7, 'Locali',Dm1.DataSource1);
  Compilaform(groupbox6, 'Locali',Dm1.DataSource1);
  Compilaform(groupbox8, 'Locali',Dm1.DataSource1);
  Compilaform(groupbox10,'Locali',Dm1.DataSource1);
  Compilaform(groupbox11,'Locali',Dm1.DataSource1);
  Compilaform(groupbox12, 'Locali',Dm1.DataSource1);
  DBComboBox6.Items.Add('Non Risc');
  DBComboBox7.Items.Add('Nessuno');
  if DBComboBox6.ItemIndex = - 1 then DBComboBox6.ItemIndex := 0;
  if DBComboBox7.ItemIndex = - 1 then DBComboBox7.ItemIndex := 0;
  if DBComboBox8.ItemIndex = - 1 then DBComboBox8.ItemIndex := 0;
  if DBComboBox9.ItemIndex = - 1 then DBComboBox9.ItemIndex := 0;
  if DBComboBox10.ItemIndex = - 1 then DBComboBox10.ItemIndex := 0;
  if DBComboBox12.ItemIndex = - 1 then DBComboBox12.ItemIndex := 0;

  // Emanuela 29/7/2004 Inserimento del caricamento della descrizione del tipo e confine
  // pavimento e del tipo e del confine soffitto
  CompilaCombo_TS(Combo_TipoSoffitto, Percorso_Progetti,  'Strutture', 2);
  Combo_TipoSoffitto.Items.Add('Nessuno');
  CompilaCombo_TS(Combo_ConfineSoffitto, Percorso_Progetti, 'Confine', 1);
  Combo_ConfineSoffitto.Items.Add('Non Scambiante');
  Combo_ConfineSoffitto.Items.Add('Esterno');
  CompilaCombo_TS(Combo_TipoPavimento, Percorso_Progetti, 'Strutture', 2);
  Combo_TipoPavimento.Items.Add('Nessuno');
  CompilaCombo_TS(Combo_ConfinePavimento, Percorso_Progetti, 'Confine', 1);
  Combo_ConfinePavimento.Items.Add('Non Scambiante');
  Combo_ConfinePavimento.Items.Add('Esterno');
  // Fine parte inserita da Emanuela

  dbcombobox12.Items.Add(C_Esterno);
  dbcombobox12.Items.Add(C_Non_sc);
  dbcombobox14.Items.Add(C_Esterno);
  dbcombobox14.Items.Add(C_Non_sc);
  dbcombobox13.Items.Add(C_Nessuno);
  dbcombobox11.Items.Add(C_Nessuno);

  // Emanuela 28/7/2004 inserita per aggiornare correttamente il combo
  dm1.TT1.First;
  ModificaValoriCombo;

  if not invisibile then
  begin
    ShowModal;
  end;
 end;

 if flettura <> nil then FreeAndNil(Flettura);

end;

Procedure TFLettura.CompilaCombo_TS(Var cmb:Tcombobox; Dbase, NomeTabella:string; Campo:integer);
Var
  Tabella: TTable;
begin
 Tabella := TTable.create(nil);
 with tabella do
 begin
  DatabaseName := Dbase;
  Tablename := NomeTabella;
  if Exists then
  begin
   Open;
   cmb.Items.Clear;
   while not eof do
   begin
    cmb.Items.add(fields[campo].AsString);
    next;
   end;
   Close;
   Free;
  end {if exists}
 end;
end;

function TFLettura.RestituisciDescrizione(Codice: String; Dbase, NomeTabella:string; Campo, Campo2:integer): String;
Var
  Tabella: TTable;
  Trovato: Boolean;
begin
 Tabella := TTable.create(nil);
 Result := '';
 with tabella do
 begin
  DatabaseName := Dbase;
  Tablename := NomeTabella;
  if Exists then
  begin
   Open;
   Trovato := False;
   while (not eof) and (Not Trovato) do
   begin
     if CompareStr(UpperCase(fields[campo].AsString), UpperCase(Codice)) = 0 then
     begin
       Result := fields[campo2].AsString;
       Trovato := True;
     end
     else
     begin
      if NomeTabella = 'Confine' then
      begin
        if CompareStr(UpperCase(Codice), UpperCase('Non sc')) = 0 then
        begin
          Result := 'Non scambiante';
          Trovato := True;
        end
        else if CompareStr(UpperCase(Codice), UpperCase('Esterno')) = 0 then
             begin
                Result := 'Esterno';
                Trovato := True;
             end;
      end
      else if NomeTabella = 'Strutture' then
           begin
              if CompareStr(UpperCase(Codice), UpperCase('Nessuno')) = 0 then
              begin
                Result := 'Nessuno';
                Trovato := True;
              end;
           end;
     end;
    next;
   end;
   Close;
   Free;
  end {if exists}
 end;
end;

function TFLettura.RestituisciCodice(Descrizione: String; Dbase, NomeTabella:string; Campo, Campo2:integer): String;
Var
  Tabella: TTable;
  Trovato: Boolean;
begin
 Tabella := TTable.create(nil);
 Result := '';
 with tabella do
 begin
  DatabaseName := Dbase;
  Tablename := NomeTabella;
  if Exists then
  begin
   Open;
   Trovato := False;
   while (not eof) and (Not Trovato) do
   begin
     if CompareStr(UpperCase(fields[campo].AsString), UpperCase(Descrizione)) = 0 then
     begin
       Result := fields[campo2].AsString;
       Trovato := True;
     end
     else
     begin
       if NomeTabella = 'Confine' then
       begin
        if CompareStr(UpperCase(Descrizione), UpperCase('Non scambiante')) = 0 then
        begin
          Result := 'Non sc';
          Trovato := True;
        end
        else if CompareStr(UpperCase(Descrizione), UpperCase('Esterno')) = 0 then
             begin
                Result := 'Esterno';
                Trovato := True;
             end;
       end
       else if NomeTabella = 'Strutture' then
           begin
              if CompareStr(UpperCase(Descrizione), UpperCase('Nessuno')) = 0 then
              begin
                Result := 'Nessuno';
                Trovato := True;
              end;
           end;
     end;
     next;
   end;
   Close;
   Free;
  end {if exists}
 end;
end;


procedure TFLettura.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 action:=cafree;
 disposeUDB;
end;

procedure TFLettura.FormDestroy(Sender: TObject);
begin
 Flettura:=nil;
end;

Procedure eseguilettura(elimina:boolean);
Var Testo : String; TuttoOk, Warning : Boolean;
begin

Disattiva_ArchPareti;
//creaDatabase('Ambienti');
//dm1.tt3.close;
//creaDatabase('Pareti');
dm1.tt3.Open;
dm1.tt1.close;
dm1.tt1.Tablename:='Locali.db';
//creaDatabase('Ambienti.db');
//CancTab(dm1.tt1);
dm1.tt1.open;
FLettura.ComboBox1.Style := csDropDown;
FLettura.combobox1.Items.Clear;
//Dm1.tt1.DisableControls;
//Dm1.TT3.DisableControls;
//Dm1.DataSource1.DataSet:=nil;
//Dm1.DataSource3.DataSet:=nil;
LeggidiSegno('',elimina);
//Redraw(FLettura.image1.Canvas,FLettura.image1,FLettura.panel5,0,0);
//Dm1.DataSource1.DataSet:=dm1.tt1;
//Dm1.DataSource3.DataSet:=dm1.tt3;
//Dm1.tt1.EnableControls;
//Dm1.tt3.EnableControls;
Attiva_ArchPareti;

// Modifica del 05/05/2004
// carico il file di messaggi generato dal programma
//if FileExists(PercorsoDrive + NomeFile_Errori_Disegno) then
//   FLettura.Memo1.Lines.LoadFromFile(PercorsoDrive + NomeFile_Errori_Disegno);
FLettura.ComboBox1.Style := csDropDownList;
Testo := Get_Msg_Errore(erLegge10, TuttoOk, Warning);
FLettura.Memo1.ReadOnly := False;
FLettura.Memo1.Clear;

FLettura.Memo1.Lines.Add(Testo);
FLettura.Memo1.ReadOnly := True;
end;

procedure TFLettura.Button1Click(Sender: TObject);
begin
EseGuilettura(True);
end;

procedure TFLettura.BokClick(Sender: TObject);
begin
dm1.tt1.edit;
dm1.tt1.post;
//close;
end;



procedure TFLettura.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
case image1.Cursor of
CurZoom:begin
        //Zoom_in(x,y);
        Zoom_in(x,y,panel5.Width,Panel5.Height);
        Redraw(Image1.canvas,Image1,panel5,0,0);
        end;
else
  begin
    if not errore_lettura then
    begin
     Redraw(Image1.canvas,Image1,panel5,x,y);
     Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
    end;
  end;
end;
end;

procedure TFLettura.FormActivate(Sender: TObject);
var
  i: Integer;
begin
  if tabellare then
  begin
    pagecontrol1.ActivePageIndex := 1;
  end
  else
  begin
    for i := 0 to PageControl1.PageCount - 1 do
      PageControl1.Pages[i].TabVisible := False;
    pagecontrol1.ActivePage := pagecontrol1.Pages[0];
    Redraw(FLettura.image1.Canvas, FLettura.image1, FLettura.panel5,0,0);
    Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
  end;
end;

procedure TFLettura.Button4Click(Sender: TObject);
begin
Eseguilettura(true);
end;

procedure TFLettura.ComboBox2Change(Sender: TObject);
begin
Attiva_ArchPareti;
end;

procedure TFLettura.Button6Click(Sender: TObject);
begin
dm1.TT3.Edit;
dm1.TT3.POst;
end;

procedure TFLettura.Button7Click(Sender: TObject);
begin
dm1.TT3.delete;
end;

procedure TFLettura.BitBtn3Click(Sender: TObject);
begin
Dm1.TT1.Edit;
Dm1.TT1.Post;
end;

procedure TFLettura.SpeedButton4Click(Sender: TObject);
begin
 Close
end;

procedure TFLettura.SpeedButton1Click(Sender: TObject);
begin
     if MessageDlg('Confermi la cancellazione del locale selezionato ' + dm1.TT1.FindField('descrizione').AsString + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) = mrYes then
        dm1.TT1.Delete;
end;

procedure TFLettura.SpeedButton2Click(Sender: TObject);
begin
// Nuovo Locale
end;

procedure TFLettura.SpeedButton3Click(Sender: TObject);
begin
// Modifica Locale
end;

procedure TFLettura.ComboBox1Change(Sender: TObject);
Var Testo : String; TuttoOk, Warning : Boolean;
begin
Disattiva_ArchPareti;
LeggidiSegno(Combobox1.Text,False);
zoom_estens;
//Redraw(image1.Canvas,image1,panel5,0,0);
Attiva_ArchPareti;
// Modifica del 05/05/2004
// carico il file di messaggi generato dal programma

Testo := Get_Msg_Errore(erLegge10, TuttoOk, Warning);
FLettura.Memo1.Clear;

FLettura.Memo1.Lines.Add(Testo);


// if FileExists(PercorsoDrive + NomeFile_Errori_Disegno) then
//    FLettura.Memo1.Lines.LoadFromFile(PercorsoDrive + NomeFile_Errori_Disegno);
end;

procedure TFLettura.Button16Click(Sender: TObject);
begin
dm1.TT1.Edit;
dm1.TT1.Post;
end;

procedure TFLettura.Combo_TipoSoffittoChange(Sender: TObject);
var
  CodTSoff: String;
  i: Integer;
begin
 CodTSoff := RestituisciCodice(Combo_TipoSoffitto.Text, Percorso_Progetti, 'Strutture', 2, 1);
 For i := 0 to DBComboBox13.Items.Count - 1 do
    if CompareSTR(UpperCase(DBComboBox13.items[i]), UpperCase(CodTSoff)) = 0 then
       DBComboBox13.ItemIndex := i;
end;

procedure TFLettura.Combo_ConfineSoffittoChange(Sender: TObject);
var
 CodCSoff: String;
 i: Integer;
begin
 CodCSoff := RestituisciCodice(Combo_ConfineSoffitto.Text, Percorso_Progetti, 'Confine', 1, 0);
 For i := 0 to DBComboBox14.Items.Count - 1 do
    if CompareSTR(UpperCase(DBComboBox14.items[i]), UpperCase(CodCSoff)) = 0 then
       DBComboBox14.ItemIndex := i;
end;

procedure TFLettura.Combo_TipoPavimentoChange(Sender: TObject);
var
  CodTPav: String;
  i: Integer;
begin
  CodTPav := RestituisciCodice(Combo_TipoPavimento.Text, Percorso_Progetti, 'Strutture', 2, 1);
  For i := 0 to DBComboBox11.Items.Count - 1 do
    if CompareSTR(UpperCase(DBComboBox11.items[i]), UpperCase(CodTPav)) = 0 then
       DBComboBox11.ItemIndex := i;
end;

procedure TFLettura.Combo_ConfinePavimentoChange(Sender: TObject);
var
  CodCPav: String;
  i: Integer;
begin
  CodCPav := RestituisciCodice(Combo_ConfinePavimento.Text, Percorso_Progetti, 'Confine', 1, 0);
  For i := 0 to DBComboBox12.Items.Count - 1 do
    if CompareSTR(UpperCase(DBComboBox12.items[i]), UpperCase(CodCPav)) = 0 then
       DBComboBox12.ItemIndex := i;
end;

procedure TFLettura.DBComboBox13Change(Sender: TObject);
var
  TipoSoff: String;
  i: Integer;
begin
  TipoSoff := RestituisciDescrizione(DBComboBox13.Text, Percorso_Progetti, 'Strutture', 1, 2);

  For i := 0 to Combo_TipoSoffitto.Items.Count - 1 do
    if CompareSTR(UpperCase(Combo_TipoSoffitto.items[i]), UpperCase(TipoSoff)) = 0 then
       Combo_TipoSoffitto.ItemIndex := i;
end;

procedure TFLettura.DBComboBox14Change(Sender: TObject);
var
  ConfSoff: String;
  i: Integer;
begin
  ConfSoff := RestituisciDescrizione(DBComboBox14.Text, Percorso_Progetti, 'Confine', 0, 1);

  For i := 0 to Combo_ConfineSoffitto.Items.Count - 1 do
    if CompareSTR(UpperCase(Combo_ConfineSoffitto.items[i]), UpperCase(ConfSoff)) = 0 then
       Combo_ConfineSoffitto.ItemIndex := i;
end;

procedure TFLettura.DBComboBox11Change(Sender: TObject);
var
  TipoPav: String;
  i: Integer;
begin
  TipoPav := RestituisciDescrizione(DBComboBox11.Text, Percorso_Progetti, 'Strutture', 1, 2);

  For i := 0 to Combo_TipoPavimento.Items.Count - 1 do
    if CompareSTR(UpperCase(Combo_TipoPavimento.items[i]), UpperCase(TipoPav)) = 0 then
       Combo_TipoPavimento.ItemIndex := i;
end;

procedure TFLettura.DBComboBox12Change(Sender: TObject);
var
  ConfPav: String;
  i: Integer;
begin
  ConfPav := RestituisciDescrizione(DBComboBox12.Text, Percorso_Progetti, 'Confine', 0, 1);

  For i := 0 to Combo_ConfinePavimento.Items.Count - 1 do
    if CompareSTR(UpperCase(Combo_ConfinePavimento.items[i]), UpperCase(ConfPav)) = 0 then
       Combo_ConfinePavimento.ItemIndex := i;
  // Fine parte inserita da Emanuela
end;

procedure TFLettura.ModificaValoriCombo;
var
 TipoPav, ConfPav, TipoSoff, ConfSoff: String;
 i: Integer;
begin
  TipoPav := RestituisciDescrizione(DBComboBox11.Text, Percorso_Progetti, 'Strutture', 1, 2);
  ConfPav := RestituisciDescrizione(DBComboBox12.Text, Percorso_Progetti, 'Confine', 0, 1);
  TipoSoff := RestituisciDescrizione(DBComboBox13.Text, Percorso_Progetti, 'Strutture', 1, 2);
  ConfSoff := RestituisciDescrizione(DBComboBox14.Text, Percorso_Progetti, 'Confine', 0, 1);

  For i := 0 to Combo_TipoSoffitto.Items.Count - 1 do
    if CompareSTR(UpperCase(Combo_TipoSoffitto.items[i]), UpperCase(TipoSoff)) = 0 then
       Combo_TipoSoffitto.ItemIndex := i;

  For i := 0 to Combo_ConfineSoffitto.Items.Count - 1 do
    if CompareSTR(UpperCase(Combo_ConfineSoffitto.items[i]), UpperCase(ConfSoff)) = 0 then
       Combo_ConfineSoffitto.ItemIndex := i;

  For i := 0 to Combo_TipoPavimento.Items.Count - 1 do
    if CompareSTR(UpperCase(Combo_TipoPavimento.items[i]), UpperCase(TipoPav)) = 0 then
       Combo_TipoPavimento.ItemIndex := i;

  For i := 0 to Combo_ConfinePavimento.Items.Count - 1 do
    if CompareSTR(UpperCase(Combo_ConfinePavimento.items[i]), UpperCase(ConfPav)) = 0 then
       Combo_ConfinePavimento.ItemIndex := i;
end;

procedure TFLettura.DBGrid4CellClick(Column: TColumn);
begin
  ModificaValoriCombo;
  Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
end;

procedure TFLettura.DBGrid4Enter(Sender: TObject);
begin
  ModificaValoriCombo;
  Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
end;

procedure TFLettura.FormCreate(Sender: TObject);
var
  Table: TTable;
  Id_CB15: Integer;
begin
  Table := TTable.Create(Nil);
  Table.DatabaseName := Percorso_progetti;
  Table.TableName := 'fabbricato.db';
  Table.Close;
  Table.Open;

   if CompareStr(Table.fieldByName('Tipo Progetto').asString, 'Riscaldamento') = 0 then
        ID_CB15 := 0
     else if CompareStr(Table.fieldByName('Tipo Progetto').asString, 'Solo rete di tubazione/canali') = 0 then
             ID_CB15 := 1
          else if CompareStr(Table.fieldByName('Tipo Progetto').asString, 'Riscaldamento e climatizzazione estiva') = 0 then
                  ID_CB15:= 2
               else if CompareStr(Table.fieldByName('Tipo Progetto').asString, 'Climatizzazione estiva') = 0 then
                       ID_CB15:= 2;
  Table.Close;
  FreeAndNil(Table);

  if Id_CB15 = 2 then
  begin
   TabSheet11.TabVisible := True;
   TabSheet10.TabVisible := True;
  end
  else
  begin
   TabSheet11.TabVisible := False;
   TabSheet10.TabVisible := False;
  end;
  PageControl4.ActivePageIndex := 0;
  PageControl3.ActivePageIndex := 0;
end;

procedure TFLettura.SB_ConfermaClick(Sender: TObject);
begin
  dm1.TT1.Edit;
  dm1.TT1.Post;
end;

procedure TFLettura.DBComboBox8Change(Sender: TObject);
begin
  DBComboBox8.Field.DataSet.Edit;
  DBComboBox8.Field.Value := DBComboBox8.Text;
end;

procedure TFLettura.DBComboBox9Change(Sender: TObject);
begin
 DBComboBox9.Field.DataSet.Edit;
 DBComboBox9.Field.Value := DBComboBox9.Text;
end;

procedure TFLettura.DBComboBox10Change(Sender: TObject);
begin
  DBComboBox10.Field.DataSet.Edit;
  DBComboBox10.Field.Value := DBComboBox10.Text;
end;

procedure TFLettura.DBComboBox6Change(Sender: TObject);
begin
  DBComboBox6.Field.DataSet.Edit;
  DBComboBox6.Field.Value := DBComboBox6.Text;
end;

procedure TFLettura.DBComboBox7Change(Sender: TObject);
begin
  DBComboBox7.Field.DataSet.Edit;
  DBComboBox7.Field.Value := DBComboBox7.Text;
end;

procedure TFLettura.DBGrid5CellClick(Column: TColumn);
begin
  Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
end;

procedure TFLettura.DBGrid5Enter(Sender: TObject);
begin
  Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
end;

procedure TFLettura.DBGrid4KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
end;

procedure TFLettura.DBGrid4KeyPress(Sender: TObject; var Key: Char);
begin
  Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
end;

procedure TFLettura.DBGrid4KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Ed_Volume.Text := FloatToStr(dbEdit15.Field.AsFloat * dbEdit14.Field.AsFloat);
end;

end.
