unit UMain_CalcTubi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ComCtrls, Grids, DBGrids, DBCtrls,
  {uses progetto}
  Calcolo, Grafica, Libreriagenerale, UDB,
  UCompilaform, Uleggitxt, UdataLink, UCaricadati, Definiz,
  TooL_Visualizza, Buttons, ImpTerm, Mask, InitPunt_Tubi, OutDXFBM
  {$IFDEF CANALI}
  ,CalcoloCanali, disperrori
  {$ELSE}
  {$ENDIF};

type
  TFMainTubi = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    PC_DatiRete: TPageControl;
    TabSheet1: TTabSheet;
    GB_CriteriCalcolo: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label7: TLabel;
    DBEdit4: TDBEdit;
    TabSheet2: TTabSheet;
    GB_DatiOggetto: TGroupBox;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    LB_Lunghezza: TLabel;
    Edit1: TEdit;
    GroupBox5: TGroupBox;
    Label13: TLabel;
    Edit2: TEdit;
    Label16: TLabel;
    Edit3: TEdit;
    Label18: TLabel;
    Edit4: TEdit;
    Label19: TLabel;
    Edit5: TEdit;
    GroupBox6: TGroupBox;
    GroupBox7: TGroupBox;
    Label21: TLabel;
    Edit6: TEdit;
    ComboBox2: TComboBox;
    GB_RisCalcolo: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    DBEdit3: TDBEdit;
    ED_Portata: TEdit;
    ED_Prevalenza: TEdit;
    ED_TipoTubo: TEdit;
    Panel5: TPanel;
    PageControl1: TPageControl;
    Panel3: TPanel;
    Image1: TImage;
    Button1: TSpeedButton;
    TabSheet3: TTabSheet;
    GroupBox1: TGroupBox;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    LIndpCan: TLabel;
    EACan: TEdit;
    EBCan: TEdit;
    ERCan: TEdit;
    ECodiceCan: TEdit;
    Timer1: TTimer;
    MPerdite: TMemo;
    Label17: TLabel;
    Label20: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label27: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Memo1: TMemo;
    GroupBox8: TGroupBox;
    DBGrid_NomeRete: TDBGrid;
    Label28: TLabel;
    Edit7: TEdit;
    Label34: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure ComboBox2Change(Sender: TObject);
    procedure Panel3Resize(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure DBGrid_NomeReteCellClick(Column: TColumn);
    procedure DBGrid_NomeReteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid_NomeReteKeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid_NomeReteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    { Private declarations }
    StartGrafica: Boolean;
    function VerificaErrori: Boolean;
    procedure RipuliscifileErrore;
  public
    { Public declarations }
  end;

var
  FMainTubi: TFMainTubi;
  Fgenerato: Text; bufgenerato: String;

Procedure CalcTubi(perc, Percorso_Sup:Pchar; Visual: Boolean);
Procedure Echo(mess:string);
Procedure Ridisegna;

implementation

uses Leggidxf, UGrafodxf, UStampe, UTiReport
     {$IFDEF VERSIONE_12}
     , RitornoDXF {$ELSE}
     , Ritorno {$ENDIF};

{$R *.DFM}
Procedure Echo(mess:string);
begin
  FMainTubi.Memo1.lines.Add(mess);
end;

Procedure CalcTubi(perc, Percorso_Sup:Pchar; Visual: Boolean);
begin
 PercorsoDrive:=strpas(perc);
 Percorso_RisorseGen := StrPas(Percorso_Sup);
 FMainTubi:=TFMainTubi.Create(nil);
 if Visual then
 begin
    FMainTubi.StartGrafica := False;
    FMainTubi.ShowModal;
 end;
end;

Procedure eseguiCalcoli;
Var ss:string;
begin
  if not FMainTubi.VerificaErrori then
  begin
    CaricaCodiciTerminali;
    // Emanuela
   {$IFDEF VERSIONE_12}
    ApriFileOutBM(percorsodrive+'\tubirit.txt');
   {$ELSE}
    ApriFileRitorno(percorsodrive+'\tubirit.txt');
   {$ENDIF}
    InitFileReport(PercorsoDrive + '\Tubi.rep');
    Wrep_str('NOMECOMUNE', DatiProgetto(1));
    Wrep_str('PROV', DatiProgetto(6));
    ApriFo(PercorsoDrive + '\SoloTubi.dxf');
   {$IFDEF VERSIONE_12}
    dm1.TT1.First;
    while not dm1.TT1.Eof do
    begin
      scaricadxf('1','');
   {$ENDIF}
      risultCalc^.Origine := V_RecGen.Origine;
      Calcoli;
      DisRit;
      dm1.TT1.Edit;
      Prepararep(PercorsoDrive + '\Tubi.rep');
      V_RecGen.Set_Portata(risultCalc^.Portata);
      V_RecGen.Set_Prevalenza(risultCalc^.Perdita);
      dm1.TT1.Post;
   {$IFDEF VERSIONE_12}
      dm1.TT1.Next;
    end;
    StampaTerminali;
    scaricadxf('5','TR');
   {$ENDIF}
    Fine_compart;
    CloseFileReport;
    ChiudiFo;
   {$IFDEF VERSIONE_12}
    ChiudiFileOutBM;
   {$ELSE}
    ChiudiRitorno;
   {$ENDIF}
    scriviquotebm;
    scriviquote(PercorsoDrive + '\disegno.dxf');
    FMainTubi.StartGrafica := True;
    dm1.TT1.First;
     with V_RecGen do
     begin
      str(Portata:6:4,ss);
      FMainTubi.ED_Portata.Text := ss;
      str(Prevalenza:6:4,ss);
      FMainTubi.ED_Prevalenza.Text := ss;
      RisultCalc^.Origine := Origine;
     end;
    SettaFiltro;
    Ridisegna;
  end;
end;

Procedure ScriviUnif3D(nomepr:string);

Var Buf:cadrec;
    FU3d:file of cadrec;
    i:integer;
begin
assign(FU3d,PercorsoDrive+'\'+Nomepr+'.U3D');
Rewrite(FU3d);
For i:=1 to  ultriga do
write(fu3d,dis^[i]^);
close(Fu3d);
end;

Procedure ScriviTermf3D(nomepr:string);

Var Buf:cadrec;
    FT3d:file of recGterm;
    i:integer;
begin
assign(Ft3d,PercorsoDrive+'\'+Nomepr+'.T3D');
Rewrite(FT3d);
For i:=1 to  NGTerm do
    write(fT3d,GTerm^[i]^);
close(FT3d);
end;

Procedure GeneraFile3D(nomePr: String);
begin
  ScriviUnif3D(nomePr);
  ScriviTermf3D(NomePr);
end;


Procedure esegui_calcoli;
Var i:integer;
begin
GeneraFile3D(v_recgen.Codice);
Case Tipo_rete of
{$IFDEF CANALI}
TrCanali:begin
         Calcolo_Canali(percorsodrive,v_recgen.Codice);
         for i:=1 to listerrori.Count do FmainTubi.memo1.Lines.Add(listerrori.Strings[i]);
         scriviquote(PercorsoDrive+'\disegno.dxf');
         FMainTubi.StartGrafica := True;
         Redraw(FMainTubi.Image1.canvas,FMainTubi.Image1,FMainTubi.panel3,0,0);
         end;
{$ENDIF}
TrTubi:eseguicalcoli;
end;
end;

procedure TFMainTubi.FormCreate(Sender: TObject);
Var
  i, org: Integer;
  IndiceRete: Byte;
begin
  // settaggio del decimal separator
  DecimalSeparator := '.';
  Application.UpdateFormatSettings := False;
  // Emanuela 30/7/2004 ripulisco il file degli errori se è esistente, altrimenti l'ho creo
  RipuliscifileErrore;

  FTool_Visualizza:=TFTool_Visualizza.create(nil);
  FTool_Visualizza.Show;
  FTool_Visualizza.ManualDock(Pagecontrol1, nil, alNone);
  Pagecontrol1.Pages[0].TabVisible := false;
  Pagecontrol1.ActivePageIndex := 0;
  PC_DatiRete.ActivePageIndex := 0;
  InitGrafica;
  InitUdb(Percorso_progetti);
  Iniz_PuntTubi;
  CopyFile(PChar(Percorso_Archivi + 'Perdite.db'), PChar(Percorso_Progetti + 'Perdite.db'), False);
  CaricaArchivi;
  dm1.TT1.close;
  dm1.TT3.close;
  dm1.TT1.DatabaseName := Percorso_progetti;
  dm1.TT3.DatabaseName:=Percorso_progetti;
  Creadatabase('Reti');
  dm1.tt1.tablename := 'Reti';
  compilagriglia(DBGrid_NomeRete,'Reti', dm1.Datasource1);
  DBGrid_NomeRete.Columns[0].Title.Alignment := taCenter;
  DBGrid_NomeRete.Columns[0].Width := 80;
  DBGrid_NomeRete.Columns[1].Title.Alignment := taCenter;
  DBGrid_NomeRete.Columns[1].Width := 143;
  compilaform(GB_CriteriCalcolo, 'Reti', dm1.Datasource1);
  dm1.TT1.Open;

  LeggiElencoRet1Txt;

  risultcalc^.Origine:=0;
  copyfile(Pchar(PercorsoDrive+'\Disegno.dxf'),Pchar(PercorsoDrive+'\CopiaDisegno.dxf'),false);
  Read_Dxf(PercorsoDrive + '\copiadisegno.dxf',PercorsoDrive + '\DISEGNOTUBO.txt',true);
  dm1.TT1.First;
 {$IFDEF VERSIONE_12}
  IndiceRete := 1;
  While not dm1.TT1.Eof do
  begin
 {$ENDIF}
    with V_Recgen do
    begin
         dm1.TT1.Edit;
         costruiscigrafo(Xori,Yori,Zori,org,IndiceRete);
         Set_Origine(org);
         dm1.TT1.Post;
         set_Tipo_rete(progetto);
    end;
 {$IFDEF VERSIONE_12}
    dm1.TT1.Next;
    inc(IndiceRete);
  end;
 {$ENDIF}
  dm1.TT1.First;
  piano_cor:=V_recgen.Piano;
  Case Tipo_rete of
    {$IFDEF CANALI}
    TrCanali: begin
                TabSheet2.TabVisible := False;
                TabSheet3.TabVisible := True;
              end;
    {$ENDIF}
    TrTubi:  begin
               TabSheet2.TabVisible := True;
               TabSheet3.TabVisible := False;
             end;
  end;
end;

procedure TFMainTubi.FormActivate(Sender: TObject);
begin
 settaFiltro;
 Redraw(Image1.canvas,Image1,panel3,0,0);
 ComboBox2.ItemIndex := ComboBox2.Items.IndexOf('Rete principale');
 esegui_calcoli;
end;

procedure TFMainTubi.FormClose(Sender: TObject; var Action: TCloseAction);
Var
 i:integer;
begin
 Dispose_PuntTubi;
 DisposeUdb;
 action:=cafree;
end;

procedure TFMainTubi.FormDestroy(Sender: TObject);
begin
  FMainTubi:=nil;
end;

procedure TFMainTubi.Image1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
case button of
mbleft:begin
        case image1.Cursor of
        CurZoom:begin
                ing_zoom_in:=2;
                Zoom_in(x,y,panel3.Width,panel3.height);
                Redraw(Image1.canvas,Image1,panel3,0,0);
                end;
        else  Redraw(Image1.canvas,Image1,panel3,x,y);
        end;
        end;
mbright:zoom_estens;
end;

end;


procedure TFMainTubi.ComboBox2Change(Sender: TObject);
begin
  primavolta:=true;
  Redraw(Image1.canvas,Image1,panel3,0,0);
end;

Procedure Ridisegna;
begin
Redraw(FMainTubi.Image1.canvas,FMainTubi.Image1,FMainTubi.panel3,0,0);
end;

procedure TFMainTubi.Panel3Resize(Sender: TObject);
begin
 if StartGrafica then
    Redraw(Image1.canvas,Image1,panel3,0,0);
end;

procedure TFMainTubi.Button1Click(Sender: TObject);
begin
Close;
end;

{-----------------------------------------------------------------------------
  Procedure: TFMainTubi.VerificaErrori
  Author:    Emanuela
  Date:      30-lug-2004
  Arguments: None
  Result:    Boolean

  Funzione che verifica se sono trovati degli errori durante la ricostruzione
  del grafo della rete.
-----------------------------------------------------------------------------}
function TFMainTubi.VerificaErrori: Boolean;
var
  FErrori: TextFile;
  NErrori: Integer;
  Errore: String;
begin
  // Emanuela inserimento degli errori nel file erroriimpianti.txt
  Result := False;
  NErrori := 0;
  AssignFile(FErrori, PercorsoDrive + NomeFile_Errori_Impianti);
  Reset(FErrori);
  try
    while not Eof(FErrori) do
    begin
      Readln(FErrori, Errore);
      echo(Errore);
      inc(NErrori);
    end;
    CloseFile(FErrori);
  except
    CloseFile(FErrori);
  end;
  if NErrori <> 0 then Result := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TFMainTubi.RipuliscifileErrore
  Author:    Emanuela
  Date:      30-lug-2004
  Arguments: None
  Result:    None

  Crea, se non esiste il file contenente gli errori, altrimenti lo ripulisce.
-----------------------------------------------------------------------------}
procedure TFMainTubi.RipuliscifileErrore;
var
  FErrori: TextFile;
begin
 AssignFile(FErrori, PercorsoDrive + NomeFile_Errori_Impianti);
 Rewrite(FErrori);
 try
  CloseFile(FErrori);
 except
  CloseFile(FErrori);
 end;
end;

procedure TFMainTubi.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
if stopweel then exit;
if (mousepos.X>panel3.Left)and(mousepos.X<(panel3.Left+panel3.width))
   and(mousepos.y>panel3.top)and(mousepos.y<(panel3.top+panel3.height+40))
then
  begin
  stopweel:=true;
  timer1.Enabled:=true;
  ing_zoom_in:=0.92;
  Zoom_in(mousepos.X-panel3.Left,mousepos.y-panel3.top,panel3.Width,panel3.height);
  Redraw(Image1.canvas,Image1,panel3,0,0);
  end;
end;

procedure TFMainTubi.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
if stopweel then exit;
if (mousepos.X>panel3.Left)and(mousepos.X<(panel3.Left+panel3.width))
   and(mousepos.y>panel3.top)and(mousepos.y<(panel3.top+panel3.height+40))
then
  begin
  stopweel:=true;
  timer1.Enabled:=true;
  ing_zoom_in:=1.08;
  Zoom_in(mousepos.X-panel3.Left,mousepos.y-panel3.top-40,panel3.Width,panel3.height);
  Redraw(Image1.canvas,Image1,panel3,0,0);
  end;
end;

procedure TFMainTubi.Timer1Timer(Sender: TObject);
begin
 stopweel:=false;
 timer1.Enabled:=false;
end;

procedure TFMainTubi.DBGrid_NomeReteCellClick(Column: TColumn);
var
  i: Integer;
  codiceTemp, ss: String;
begin
  i := 1;
  CodiceTemp := V_RecGen.Codice;
  dm1.TT1.First;
  While (not dm1.TT1.Eof) and (V_RecGen.Codice <> CodiceTemp) do
  begin
      inc(i);
      dm1.TT1.Next;
  end;
  with V_RecGen do
  begin
    str(Portata:6:3,ss);
    ED_Portata.Text := ss;
    str(Prevalenza:6:3,ss);
    ED_Prevalenza.Text := ss;
    RisultCalc^.Origine := Origine;
  end;
  SettaFiltro;
  Ridisegna;
  Case Tipo_rete of
    {$IFDEF CANALI}
    TrCanali: begin
                TabSheet2.TabVisible := False;
                TabSheet3.TabVisible := True;
              end;
    {$ENDIF}
    TrTubi:  begin
               TabSheet2.TabVisible := True;
               TabSheet3.TabVisible := False;
             end;
  end;
  DBGrid_NomeRete.Columns[1].Width := 143;
end;


procedure TFMainTubi.DBGrid_NomeReteKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Tipo_rete of
    {$IFDEF CANALI}
    TrCanali: begin
                TabSheet2.TabVisible := False;
                TabSheet3.TabVisible := True;
              end;
    {$ENDIF}
    TrTubi:  begin
               TabSheet2.TabVisible := True;
               TabSheet3.TabVisible := False;
             end;
  end;
  DBGrid_NomeRete.Columns[1].Width := 143;
end;

procedure TFMainTubi.DBGrid_NomeReteKeyPress(Sender: TObject; var Key: Char);
begin
  Case Tipo_rete of
    {$IFDEF CANALI}
    TrCanali: begin
                TabSheet2.TabVisible := False;
                TabSheet3.TabVisible := True;
              end;
    {$ENDIF}
    TrTubi:  begin
               TabSheet2.TabVisible := True;
               TabSheet3.TabVisible := False;
             end;
  end;
  DBGrid_NomeRete.Columns[1].Width := 143;
end;

procedure TFMainTubi.DBGrid_NomeReteKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  Case Tipo_rete of
    {$IFDEF CANALI}
    TrCanali: begin
                TabSheet2.TabVisible := False;
                TabSheet3.TabVisible := True;
              end;
    {$ENDIF}
    TrTubi:  begin
               TabSheet2.TabVisible := True;
               TabSheet3.TabVisible := False;
             end;
  end;
  DBGrid_NomeRete.Columns[1].Width := 143;
end;

end.
