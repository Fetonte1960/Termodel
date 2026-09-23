unit Cpi_WIN_CLIMA_CadLT;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ExtCtrls, ComCtrls, UInitGeneral, HeaderDllTermico,
  Buttons, StdCtrls, UGest_cad, DBCtrls, UDB, LibreriaGenerale, UCompilaForm,
  ToolWin, ImgList, Mask,udatalink,duplicaPiani, DB, DBTables,leggi_dxf_bm,varcarichi;

type
  TFPannelloClima = class(TForm)
    MainMenu1: TMainMenu;
    Edificio1: TMenuItem;
    reti1: TMenuItem;
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    ArchivioPareti1: TMenuItem;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    Memo1: TMemo;
    Memo2: TMemo;
    Memo3: TMemo;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    GBPareti: TGroupBox;
    DBTipoParete: TDBComboBox;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    CbTLinea: TComboBox;
    LPr1: TLabel;
    LPr2: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBConfineParete: TDBComboBox;
    GBFinestre: TGroupBox;
    Label6: TLabel;
    DBTipoFinestra: TDBComboBox;
    GBPontiTermici: TGroupBox;
    Label7: TLabel;
    DBTipoPontiTermici: TDBComboBox;
    Label8: TLabel;
    Label9: TLabel;
    GBLocali: TGroupBox;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    Label10: TLabel;
    DBTipoZona: TDBComboBox;
    Label11: TLabel;
    DBTipoImpianto: TDBComboBox;
    GBSoffitto: TGroupBox;
    Label12: TLabel;
    DBTipoSoffitto: TDBComboBox;
    Label13: TLabel;
    DBConfineSoffitto: TDBComboBox;
    PageControl3: TPageControl;
    TabSheet8: TTabSheet;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    GBTipoRete: TGroupBox;
    GBCollettore: TGroupBox;
    GroupBox1: TGroupBox;
    Label16: TLabel;
    DBCarattCostruttive: TDBComboBox;
    Label17: TLabel;
    Label18: TLabel;
    GroupBox2: TGroupBox;
    Label20: TLabel;
    CBTiporete: TDBComboBox;
    GroupBox3: TGroupBox;
    Label21: TLabel;
    CbPerdloc: TDBComboBox;
    Label19: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    DBAttIrete: TDBComboBox;
    Label24: TLabel;
    GBVALVOLE: TGroupBox;
    GBTERMINALI: TGroupBox;
    PageControl4: TPageControl;
    TabSheet9: TTabSheet;
    TabSheet12: TTabSheet;
    GroupBox6: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Edit5: TEdit;
    Label27: TLabel;
    Edit6: TEdit;
    Label28: TLabel;
    GBDATITERM1: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    EINCRPOT: TDBEdit;
    ELARGMAX: TDBEdit;
    GBDATITERM2: TGroupBox;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    EPORT: TDBEdit;
    EPOT: TDBEdit;
    Label33: TLabel;
    Label37: TLabel;
    EPERD: TDBEdit;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    DBAttTerm: TDBComboBox;
    DBSIMBTERM: TDBComboBox;
    Label41: TLabel;
    Label42: TLabel;
    EMONTAGGIO: TDBEdit;
    Label43: TLabel;
    CbDISPERDITE: TDBComboBox;
    Label44: TLabel;
    CBCODPERDITE: TDBComboBox;
    Label45: TLabel;
    Label46: TLabel;
    DBComboBox7: TDBComboBox;
    Label47: TLabel;
    DBComboBox8: TDBComboBox;
    Label48: TLabel;
    DBEdit7: TDBEdit;
    DBELponte: TDBEdit;
    ECodRete: TDBEdit;
    Elungtubo: TDBEdit;
    Enumcurve: TDBEdit;
    Archivio1: TMenuItem;
    ArchivioPontiTermici1: TMenuItem;
    DatidiProgetto1: TMenuItem;
    DatiZone1: TMenuItem;
    Dati1: TMenuItem;
    DatiConfine1: TMenuItem;
    N2: TMenuItem;
    N1: TMenuItem;
    DatiGeneratori1: TMenuItem;
    DatiOrari1: TMenuItem;
    DatiTerminali1: TMenuItem;
    DatiTubi1: TMenuItem;
    DatiPerdite1: TMenuItem;
    DatiTipologiaReti1: TMenuItem;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ImageList2: TImageList;
    SpeedButton7: TSpeedButton;
    SpeedButton1: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton8: TSpeedButton;
    DBImPareti: TDBImage;
    Timer1: TTimer;
    OpenDialog1: TOpenDialog;
    GBPIANI: TGroupBox;
    Label1: TLabel;
    SpeedButton5: TSpeedButton;
    CBPiano: TDBComboBox;
    SpeedButton10: TSpeedButton;
    TPareti: TTable;
    DataSource1: TDataSource;
    CBCOLOREPARETE: TComboBox;
    CBCOloreTubo: TComboBox;
    Panel3: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    TFinestre: TTable;
    DataSource2: TDataSource;
    Label53: TLabel;
    SpeedButton11: TSpeedButton;
    Barchiviotubi: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    Label54: TLabel;
    Label55: TLabel;
    SpeedButton14: TSpeedButton;
    PageControl5: TPageControl;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    Label49: TLabel;
    DBEdit12: TDBEdit;
    Label50: TLabel;
    Label51: TLabel;
    DBEdit13: TDBEdit;
    Label52: TLabel;
    DBImfinestre: TDBImage;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    SpeedButton9: TSpeedButton;
    SpeedButton21: TSpeedButton;
    SaveDialog1: TSaveDialog;
    DBImage1: TDBImage;
    GBPavimento: TGroupBox;
    Label14: TLabel;
    Label15: TLabel;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    DBTipoPavimento: TDBComboBox;
    DBConfinePavimento: TDBComboBox;
    D1: TMenuItem;
    TTForm: TTable;
    File1: TMenuItem;
    Nuovo1: TMenuItem;
    Apri1: TMenuItem;
    Salva1: TMenuItem;
    Salvacome1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ArchivioPareti1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBTipoPareteChange(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Archivio1Click(Sender: TObject);
    procedure ArchivioPontiTermici1Click(Sender: TObject);
    procedure DatiZone1Click(Sender: TObject);
    procedure Dati1Click(Sender: TObject);
    procedure DatidiProgetto1Click(Sender: TObject);
    procedure DatiConfine1Click(Sender: TObject);
    procedure DatiGeneratori1Click(Sender: TObject);
    procedure DatiOrari1Click(Sender: TObject);
    procedure DatiTerminali1Click(Sender: TObject);
    procedure DatiTubi1Click(Sender: TObject);
    procedure DatiPerdite1Click(Sender: TObject);
    procedure DatiTipologiaReti1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure CBPianoChange(Sender: TObject);
    procedure CBCOLOREPARETEChange(Sender: TObject);
    procedure DBConfinePareteChange(Sender: TObject);
    procedure CbTLineaChange(Sender: TObject);
    procedure DBTipoZonaChange(Sender: TObject);
    procedure DBTipoFinestraChange(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure DBCarattCostruttiveChange(Sender: TObject);
    procedure CBCOloreTuboChange(Sender: TObject);
    procedure CBTiporeteChange(Sender: TObject);
    procedure ECodReteChange(Sender: TObject);
    procedure DBAttIreteChange(Sender: TObject);
    procedure ElungtuboChange(Sender: TObject);
    procedure EnumcurveChange(Sender: TObject);
    procedure CbPerdlocChange(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton13Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure DBAttTermChange(Sender: TObject);
    procedure DBSIMBTERMChange(Sender: TObject);
    procedure EMONTAGGIOChange(Sender: TObject);
    procedure EPORTChange(Sender: TObject);
    procedure EPOTChange(Sender: TObject);
    procedure EPERDChange(Sender: TObject);
    procedure ELARGMAXChange(Sender: TObject);
    procedure EINCRPOTChange(Sender: TObject);
    procedure DBTipoPontiTermiciChange(Sender: TObject);
    procedure DBELponteChange(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure BarchiviotubiClick(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    // Procedure inserite da Emanuela per il caricamento delle immagini dei ponti termici
    procedure CaricaImmagine(Codice: String);
    function  RestituisciNomeImmaginePT(Codice: String): String;
    procedure CbDISPERDITEChange(Sender: TObject);
    procedure CBCODPERDITEChange(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure D1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    Function POsizRiga(riga:string):boolean;
    Function POsizRigaFin(riga:string):boolean;
    Procedure Script_Valvola;
    Procedure Script_Terminale;
    Procedure Script_POnte;
    Procedure Script_parete;
    Procedure Script_allinea;
    Procedure Script_Finestra;
    Procedure Script_Locale;
    Procedure Script_Tubo;
    Procedure Script_Gestrete;
    Procedure Settacolore(Modo:integer);
    Procedure SettaTLinea;
    Procedure Cambiacolore(modo:integer);
    Procedure CambiacoloreTUBI(modo:integer);
    Procedure InitCadParete(tipo,tipof,conf:string);
    Procedure Chiuditabelle;
    Procedure Apritabelle;
    Procedure ApritabFinestre;
    Procedure aggiornaForm;
    Procedure Aggiornascript;
    Procedure TLineaParete;
    procedure POsizConf(riga,tln:string);

  end;

var
  FPannelloClima: TFPannelloClima;
  Progcor:string;
  Var arcolori:array[0..50]of boolean;
      tl:array[1..6]of record
                       n:string[50];
                       v:boolean;
                       end;
  const senzanome='Progetto senza nome';
        confauto='Autorilevato';
  Procedure visualProg;
  Procedure LeggiNomeProgetto;
  Function Numpiani:integer;
  procedure nuovoprogetto;
  Procedure incnumpiani;
  Function colore_CAD(ind:integer):string;
  Procedure initcolori;
  Function indcolore(nomecolore:string):integer;
  Procedure CancellafileTemporanei;
  Procedure EseguiMenu(Item:String);
  Procedure ApritabPareti(var Img:TdbImage);
implementation
{$R *.dfm}
Procedure InitTlinea;
Var i:integer;
begin
for i:=1 to 6 do
  case i of
  1:tl[i].n:='0:CONTINUOUS: ( _____________)';
  2:tl[i].n:='1:ACAD_ISO02W100:( __ __ __ __ )';
  3:tl[i].n:='2:ACAD_ISO03W100:( _ _ _ _ _ _ _)';
  4:tl[i].n:='3:ACAD_ISO04W100:( __.__.__.__.)';
  5:tl[i].n:='4:ACAD_ISO05W100:( __..__..__..  )';
  6:tl[i].n:='5:ACAD_ISO06W100:( __...__...__  )';
  end;
end;
Function Numpiani:integer;
begin
result:=FPannelloclima.cbpiano.Items.count;
end;
Procedure incnumpiani;
Var i:integer;
begin
i:=numpiani;
FPannelloclima.cbpiano.Items.Add('P'+inttostr(i+1));
dm1.tt0.Edit;
v_recconfcad.Set_NPiani(i+1);
dm1.tt0.Post;
end;
Procedure TFPannelloClima.Aggiornascript;
begin
//scriptloop;
scriptCalcoli;
scriptNuovo;
scriptapri;
Script_Parete;
Script_locale;
Script_Tubo;
Script_Ponte;
Script_finestra;
Script_terminale;
Script_Valvola;
Script_GESTRETE;
ScriptNord('P1');
ScriptAggiorna;
Scriptsalva;
ScriptPianta('0');
Script_allinea;
ScriptPianta('0');

(*
//Procedure ScriptGestrete(Comando,piano,codice,l,nc,tc:string);
Script_Collettore;
Scriptedifon;
ScriptedifOFF;
ScriptTubiOFF;
ScriptDisTubiON;
ScriptInpTubiON;
*)
end;
Procedure TFpannelloclima.chiuditabelle;
begin
//table1.close;
//table2.close;
//timfinestre.close;
dm1.tt0.Close;
tpareti.Close;
tFinestre.Close;
end;

Procedure TFpannelloclima.ApritabFinestre;
begin
dbimfinestre.Visible:=false;
if fileexists(percorso_progetti+'immaginif.db') then
if V_recconfcad.Tipofinestra<>'' then
  begin
  tfinestre.Open;
  if posizRigafin(V_recconfcad.Tipofinestra) then
  dbimFinestre.Visible:=true
  else
    begin
    dm1.tt0.Edit;
    v_recconfcad.set_Tipofinestra('');
    dm1.tt0.POst;
    dm1.tt0.Edit;
    end;
  end;
end;

Procedure ApritabPareti(var Img:TdbImage);
begin
with Fpannelloclima  do
  begin
  Img.Visible:=false;
  if fileexists(percorso_progetti+'immagini.db') then
  if V_recconfcad.TipoParete<>'' then
    begin
    tpareti.Open;
    if posizRiga(V_recconfcad.TipoParete) then
    img.Visible:=true
    else
      begin
      dm1.tt0.Edit;
      v_recconfcad.set_TipoParete('');
      dm1.tt0.POst;
      dm1.tt0.Edit;
      end;
    end;
  end
end;

Procedure TFpannelloclima.Apritabelle;
begin
dm1.tt0.Open;
InitCadParete('','','');
APriTabPareti(Fpannelloclima.dbimpareti);
APriTabFinestre;
Settacolore(2);
end;


Procedure EseguiMenu(Item:String);
begin
 Fpannelloclima.chiuditabelle;
 Item:=UpperCase(Item);
 Item_Menu(PChar(Item));
 Fpannelloclima.ApriTabelle;
 FpannelloClima.aggiornaForm;
end;

Procedure TFPannelloClima.aggiornaForm;
Var i:integer;
begin
 CompilaForm(GBPareti,       'confcad', dm1.DataSource0);
 DbconfineParete.Items.Add(confauto);
 CompilaForm(GBFinestre,     'confcad', dm1.DataSource0);
 CompilaForm(GBPontiTermici, 'confcad', dm1.DataSource0);
 CompilaForm(GBLocali,       'confcad', dm1.DataSource0);
 CompilaForm(GBPiani,       'confcad', dm1.DataSource0);
 CompilaForm(GBTiporete,       'confcad', dm1.DataSource0);
 CompilaForm(GBVALVOLE,       'confcad', dm1.DataSource0);
 CompilaForm(GBTERMINALI,       'confcad', dm1.DataSource0);
 CompilaForm(GBDATITERM1,       'confcad', dm1.DataSource0);
 CompilaForm(GBDATITERM2,       'confcad', dm1.DataSource0);

 //for i:=1 to 50 do FPannelloclima.cbcoloreparete.Items.Add(colore_cad(i));
 //for i:=1 to 50 do FPannelloclima.cbcoloretubo.Items.Add(colore_cad(i));

End;

procedure TFPannelloClima.FormCreate(Sender: TObject);
Var i:integer;
    myEdificio, myTubi, myEstivo: Boolean;
begin
{ TODO -odiego -cCpi_WIN_CLIMA_CadLT : Oncreate }

// Emanuela Introdotta la protezione
//VerificaProtezione(myEdificio, myTubi, myEstivo);
new(entita_d);
Personalizza;
puliscifile;
initudb(Percorso_progetti);
Tab0:=true;
dm1.tt2.databasename:=Percorso_progetti;
dm1.tt2.tablename:='Piani';
dm1.tt0.databasename:=Percorso_progetti;
dm1.tt0.tablename:='confcad';
dm1.tt0.open;
tpareti.DatabaseName:=Percorso_progetti;
tpareti.tablename:='Immagini';
Apritabpareti(dbimpareti);
settacolore(2);
tFinestre.DatabaseName:=Percorso_progetti;
tFinestre.tablename:='ImmaginiF';
ApritabFinestre;
dbimfinestre.DataField:='immagine';
dbimpareti.DataField:='immagine';
AggiornaForm;
initTlinea;
tlineaParete;
Pagecontrol1.ActivePageIndex:=0;
Pagecontrol2.ActivePageIndex:=0;
InitCadParete('','','');
Init_cadEsterno;
//scriptloop;
Run_CadEsterno;
LeggiNomeProgetto;
left:=screen.Width-width;
top:=105;
if top+height>screen.Height then
top:=screen.Height-height;
// Istruzioni inserite da Emanuela per caricare l'immagine dei ponti termici
DBTipoPontiTermici.ItemIndex := 0;
DBTipoPontiTermici.Field.DataSet.Edit;
DBTipoPontiTermici.Field.Value := DBTipoPontiTermici.Text;
CaricaImmagine(DBTipoPontiTermici.Text);
dbConfineParete.Items.Add('Esterno');
dbConfineSoffitto.Items.Add('Esterno');
dbConfinePavimento.Items.Add('Esterno');
cbdisperdite.Items.Add('DISLIVELLO');
dbConfineParete.ItemIndex := 0;
dbConfineSoffitto.ItemIndex := 0;
dbConfinePavimento.ItemIndex := 0;
end;

procedure TFPannelloClima.ArchivioPareti1Click(Sender: TObject);
begin
 EseguiMenu('ARCHIVIOPARETI');  // Esegue gli Archivi Pareti
end;

procedure TFPannelloClima.SpeedButton1Click(Sender: TObject);
begin
 EseguiMenu('CONFINE');         // Esegue l'Archivio Confine
 script_parete;
end;

procedure TFPannelloClima.TLineaParete;
begin
cbTlinea.Items.Clear;
if (v_recconfcad.ConfineParete='')or(v_recconfcad.ConfineParete=confauto)then
cbtlinea.Text:=tl[1].n
else POsizConf(v_recconfcad.ConfineParete,'');
end;

procedure TFPannelloClima.DBTipoPareteChange(Sender: TObject);
begin
 dm1.tt0.Edit;
 dm1.tt0.post;
 dm1.tt0.Edit;
 ApriTabPareti(dbimpareti);
 Script_Parete;
end;

Function TFPannelloclima.POsizRiga(riga:string):boolean;
begin
result:=false;
with tPareti do
  begin
  Open;
  first;
  while (not eof)and(fields[4].asstring<>riga) do next;
  if  fields[4].asstring=riga then
    begin
    result:=true;
    settacolore(1);
    end;
  end;
end;

Function TFPannelloclima.POsizRigaFin(riga:string):boolean;
begin
result:=false;
with tfinestre do
  begin
  Open;
  first;
  while (not eof)and(fields[4].asstring<>riga) do next;
  if  fields[4].asstring=riga then
    begin
    result:=true
    end;
  end;
end;


Procedure TFpannelloclima.Script_Valvola;
Var att:string;
begin
if not (dm1.tt0.active) then exit;
dm1.tt0.Edit;
dm1.tt0.Post;
dm1.tt0.Edit;
if CBDISPERDITE.text<>'' then
ScriptValvola(IndcodPiano(V_recconfcad.Pianocor),CBDISPERDITE.text,CBCODPERDITE.text);
end;


Procedure TFpannelloclima.Script_Terminale;
Var att:string;
begin
if not (dm1.tt0.active) then exit;
dm1.tt0.Edit;
dm1.tt0.Post;
dm1.tt0.Edit;
att:='D';
if DBATTTERM.text<>'' then att:=DBATTTERM.text[1];
if DBSimbTerm.text<>'' then
ScriptTerminale(IndcodPiano(V_recconfcad.Pianocor),DBSimbTerm.text,att,EIncrpot.Text,Elargmax.Text,EPort.Text,EPot.text,Eperd.text,EMontaggio.text);
end;



Procedure TFpannelloclima.Script_POnte;
begin
if not (dm1.tt0.active) then exit;
dm1.tt0.Edit;
dm1.tt0.Post;
dm1.tt0.Edit;
ScriptPonte(IndcodPiano(V_recconfcad.Pianocor),DBTipoPOntiTermici.text,DbeLponte.text);
end;


Procedure TFpannelloclima.Script_parete;
begin
if not (dm1.tt0.active) then exit;
ScriptParete(IndcodPiano(V_recconfcad.Pianocor),CBColoreParete.Text,CbTLinea.Text);
end;

Procedure TFpannelloclima.Script_Allinea;
begin
if not (dm1.tt0.active) then exit;
Scriptallinea(IndcodPiano(V_recconfcad.Pianocor));
end;


Procedure TFpannelloclima.Script_Locale;
begin
if not (dm1.tt0.active) then exit;
dm1.tt0.Edit;
dm1.tt0.Post;
dm1.tt0.Edit;
Scriptlocale(IndcodPiano(V_recconfcad.Pianocor),V_recconfcad.TipoZonaLoc,V_recconfcad.ImpZonaLoc,V_recconfcad.TipoPavLoc,V_recconfcad.ConfPavLoc,V_recconfcad.TipoSoffLoc,V_recconfcad.ConfSoffLoc);
end;

Procedure TFpannelloclima.Script_Tubo;
begin
if dm1.tt0.Active then
  begin
  dm1.tt0.Edit;
  dm1.tt0.Post;
  dm1.tt0.Edit;
  ScriptTubo(IndcodPiano(V_recconfcad.Pianocor),CBColoreTubo.Text,'');
  end;
end;
Procedure TFpannelloclima.Script_Gestrete;
Var pref:string;
begin
if dm1.tt0.Active then
  begin
  dm1.tt0.Edit;
  dm1.tt0.Post;
  dm1.tt0.Edit;
  pref:='D';
  if  DBAttIrete.Text<>'' then
  pref:=DBAttIrete.Text[1];
  ScriptGestrete('Irete'+pref,'Irete',CBTiporete.text,IndcodPiano(V_recconfcad.Pianocor)+'_TUBI',Ecodrete.Text,'','','');
  ScriptGestrete('RIprete'+pref,'RIPrete',CBTiporete.text,IndcodPiano(V_recconfcad.Pianocor)+'_TUBISIMB',Ecodrete.Text,'','','');
  ScriptGestrete('Rimrete'+pref,'Rimrete',CBTiporete.text,IndcodPiano(V_recconfcad.Pianocor)+'_TUBISIMB',Ecodrete.Text,ELungtubo.text,ENumcurve.text,CBPerdloc.text);
  end;
end;
Procedure TFpannelloclima.SettaTlinea;
Var Table2:TTable;
     i:integer;
begin
Table2:=TTable.Create(nil);
with table2 do
  begin
  close;
  databasename:=percorso_progetti;
  tablename:='Confine.db';
  open;
  for i:=1 to 6 do tl[i].v:=false;
  first;
  while not eof do
    begin
    tl[fields[3].asinteger].v:=true;
    next;
    end;

  for i:=2 to 6 do
  if not(tl[i].v) then
  FPannelloclima.cbtlinea.Items.Add(colore_cad(i));
  first;
  while (not eof)and(uppercase(V_recconfcad.TipoParete)<>uppercase(fields[1].asstring)) do
  next;
  CBColoreParete.text:=fields[3].asstring;
  close;
  end;
Table2.free;
end;


Procedure TFpannelloclima.Settacolore(Modo:integer);
Var Table2:TTable;
     i,campo,Campocod:integer;
     Nomedb,SetCod:string;
     Var CBox:Tcombobox ;
begin
Table2:=TTable.Create(nil);
if modo=1 then
  begin
  nomedb:='strutture.db';
  Cbox:=cbcoloreParete;
  Campo:=3;
  CampoCod:=1;
  SetCod:=V_recconfcad.TipoParete;
  end
else
  begin
  nomedb:='tipirete.db';
  Cbox:=cbcoloreTubo;
  Campo:=14;
  CampoCod:=1;
  SetCod:=V_recconfcad.CarCostruttRete;
  end;
with table2 do
  begin
  close;
  databasename:=percorso_progetti;
  tablename:=nomedb;
  open;
  initcolori;
  first;
  while not eof do
    begin
    arcolori[indcolore(fields[Campo].asstring)]:=true;
    next;
    end;
  cbox.Items.clear;
  for i:=1 to 50 do
  if not(arcolori[i]) then
  cbox.Items.Add(colore_cad(i));
  first;
  while (not eof)and(uppercase(SetCod)<>uppercase(fields[CampoCod].asstring)) do
  next;
  CBox.text:=fields[Campo].asstring;
  close;
  end;
Table2.free;
end;

Procedure TFPannelloclima.InitCadParete(tipo,tipof,conf:string);
var i:Integer;
begin
//if cbpiano.Text='' then
Aggiornascript;
end;

Procedure visualProg;
Var tt:string;
begin
tt:=extractfilePath(progcor);
if length(tt)>20 then tt:=' ... '+copy(tt,length(tt)-30,30);
FPannelloclima.LPr1.caption:=tt;
FPannelloclima.LPr2.caption:=' '+extractfilename(progcor)+' (.dwg)';
end;

Procedure LeggiNomeProgetto;
Var ft:textfile;
begin
if fileexists(percorsoDrive+'\nomeprog.txt') then
  begin
  assign(ft,percorsoDrive+'\nomeprog.txt');
  reset(ft);
  readln(ft,progcor);
  close(ft);
  end
else progcor:=senzanome;
Visualprog;
end;



procedure TFPannelloClima.SpeedButton5Click(Sender: TObject);
begin
  //EseguiMenu('GESTIONEPIANI'); // Eegue la Gestione dei Piani
  CopiaPiano;
  CompilaForm(GBPiani,       'confcad', dm1.DataSource1);
  dm1.tt0.Open;
end;

procedure TFPannelloClima.ToolButton1Click(Sender: TObject);
begin
 CalcoloL10;                    // Esegue il Calcolo della Legge 10
end;

procedure TFPannelloClima.Archivio1Click(Sender: TObject);
begin
 EseguiMenu('ARCHIVIOFINESTRE');  // Esegue l'Archivio Finestre e Porte
end;

procedure TFPannelloClima.ArchivioPontiTermici1Click(Sender: TObject);
begin
 EseguiMenu('PONTI');           // Esegue l'Archivio Ponti Termici
end;

procedure TFPannelloClima.DatiZone1Click(Sender: TObject);
begin
 EseguiMenu('ZONE');            // Esegue l'Archivio Zone Termiche
end;

procedure TFPannelloClima.Dati1Click(Sender: TObject);
begin
 EseguiMenu('IMPIANTI');        // Esegue l'Archivio Impianti
end;

procedure TFPannelloClima.DatidiProgetto1Click(Sender: TObject);
begin
 EseguiMenu('FABBRICATO');      // Esegue l'Archivio Fabbricato
end;

procedure TFPannelloClima.DatiConfine1Click(Sender: TObject);
begin
 EseguiMenu('CONFINE');         // Esegue l'Archivio Confine
end;

procedure TFPannelloClima.DatiGeneratori1Click(Sender: TObject);
begin
 EseguiMenu('GENERATORI');      // Esegue l'Archivio Generatori
end;

procedure TFPannelloClima.DatiOrari1Click(Sender: TObject);
begin
 EseguiMenu('ORARI');           // Esegue l'Archivio Dati Orari
end;

procedure TFPannelloClima.DatiTerminali1Click(Sender: TObject);
begin
 EseguiMenu('TERMINALI');       // Esegue l'Archivio Dati Terminali
end;

procedure TFPannelloClima.DatiTubi1Click(Sender: TObject);
begin
 EseguiMenu('ARCHTUBI');        // Esegue l'Archivio Tubi
end;

procedure TFPannelloClima.DatiPerdite1Click(Sender: TObject);
begin
 EseguiMenu('PERDITE');         // Esegue l'Archivio Perdite
end;

procedure TFPannelloClima.DatiTipologiaReti1Click(Sender: TObject);
begin
 EseguiMenu('TIPIRETE');        // Esegue l'Archivio Tipi Rete
end;


procedure TFPannelloClima.ToolButton2Click(Sender: TObject);
begin
 NuovoProgetto;
end;

procedure TFPannelloClima.ToolButton9Click(Sender: TObject);
begin
 EseguiMenu('STAMPA');          // Esegue la Stampa delle Relazioni
end;

procedure TFPannelloClima.ToolButton8Click(Sender: TObject);
begin
 EseguiMenu('CALCTUBI');        // Esegue il Calcolo Tubi
end;

procedure TFPannelloClima.ToolButton7Click(Sender: TObject);
begin
 EseguiMenu('ESTIVO');          // Esegue il Calcolo Estivo
end;

procedure TFPannelloClima.ToolButton6Click(Sender: TObject);
begin
 chiuditabelle;
 FineDisegno(PChar(''));        // Esegue Lettura del Disegno
 apritabelle;
end;

procedure TFPannelloClima.SpeedButton7Click(Sender: TObject);
begin
 EseguiMenu('ARCHIVIOPARETI');  // Esegue gli archivi pareti
 script_Parete;
end;

procedure TFPannelloClima.SpeedButton6Click(Sender: TObject);
begin
 EseguiMenu('ARCHIVIOFINESTRE');// Esegue gli archivi Finestre e Porte
 script_finestra;
end;

procedure TFPannelloClima.SpeedButton8Click(Sender: TObject);
begin
 EseguiMenu('PONTI');           // Esegue l'Archivio Ponti Termici
end;

procedure TFPannelloClima.SpeedButton2Click(Sender: TObject);
begin
eseguiautocad;
end;

Procedure cambiaProgetto(nprogetto:string);
Var ft:textfile;
begin
assign(ft,percorsoDrive+'\nomeprog.txt');
rewrite(ft);
writeln(ft,nprogetto);
close(ft);
progcor:=Nprogetto;
Visualprog;
end;

 Procedure CancellaFileestensione(percorso,estens:string);
 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
 begin
     perc:=percorso+'\*.'+estens;

     Trovato := FindFirst(perc,faarchive,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso + '\' + sr.Name;
             DeleteFile(NomeFile);
             Trovato := FindNext(sr);
        end;
 end;

Procedure CancellafileTemporanei;
Var  ff:file;
begin
if fileexists(percorsodrive+'\disegno.dxf')then
  begin
  assignfile(ff,percorsodrive+'\disegno.dxf');
  erase(ff);
  end;
if fileexists(percorsodrive+'\copiadisegno.dxf')then
  begin
  assignfile(ff,percorsodrive+'\copiadisegno.dxf');
  erase(ff);
  end;
if fileexists(percorsodrive+'\Workdisegno.dxf')then
  begin
  assignfile(ff,percorsodrive+'\Workdisegno.dxf');
  erase(ff);
  end;
cancellafileestensione(percorsodrive,'3DM');    
cancellafileestensione(percorsodrive,'o3D');  
cancellafileestensione(percorsodrive,'U3D');
cancellafileestensione(percorsodrive,'D3D');
cancellafileestensione(percorsodrive,'P3D');
cancellafileestensione(percorsodrive,'T3D');
cancellafileestensione(percorsodrive,'FIN');
cancellafileestensione(percorsodrive,'INT');
cancellafileestensione(percorsodrive,'RTT');
cancellafileestensione(percorsodrive,'LKK');
cancellafileestensione(percorsodrive,'FXF');
cancellafileestensione(percorsodrive,'BXF');
cancellafileestensione(percorsodrive,'IGI');
cancellafileestensione(percorsodrive,'BGI');
cancellafileestensione(percorsodrive,'EGI');
end;

procedure Apriprogetto;
var Pathprog,nomeprog,path2:string;
    ff:file;
    //opendialog1:topendialog;
begin
//opendialog1:=TOpendialog.Create(nil);
Fpannelloclima.chiuditabelle;
Fpannelloclima.Opendialog1.initialdir:=libreriagenerale.percorsodrive+'\esempi';
Fpannelloclima.Opendialog1.Execute;
if Fpannelloclima.Opendialog1.FileName<>'' then
  begin
  cambiaprogetto(Fpannelloclima.Opendialog1.FileName);
  end
else
  begin
  Fpannelloclima.apritabelle;
  exit;
  end;
OpenTxt(PChar(Percorso_progetti),pchar(progcor));
if fileexists(pchar(copy(Fpannelloclima.Opendialog1.FileName,1,length(Fpannelloclima.Opendialog1.FileName)-3)+'dwg')) then
  begin
  copyfile(pchar(copy(Fpannelloclima.Opendialog1.FileName,1,length(Fpannelloclima.Opendialog1.FileName)-3)+'dwg'),pchar(percorsodrive+'\disegno.dwg'),false);
  copyfile(pchar(percorsodrive+'\prototipo.dxf'),pchar(percorsodrive+'\disegno.dxf'),false);//elimina problema del mancato salvataggio  dwg
  end;
pathprog:=extractfilepath(Fpannelloclima.Opendialog1.FileName);
nomeprog:=copy(extractfilename(Fpannelloclima.Opendialog1.FileName),1,length(extractfilename(Fpannelloclima.Opendialog1.FileName))-4);
Path2:=pathprog+'Work_'+Nomeprog+'\';

if fileexists(pathprog+'\Disegno.txt') then
copyfile(Pchar(pathprog+'\Disegno.txt'),pchar(percorsodrive+'\disegno.txt'),false);
if fileexists(path2+'Disegno.txt') then
copyfile(Pchar(path2+'Disegno.txt'),pchar(percorsodrive+'\disegno.txt'),false);
if fileexists(path2+'Tubi.txt') then
copyfile(Pchar(path2+'Tubi.txt'),pchar(percorsodrive+'\Tubi.txt'),false);
if fileexists(path2+'Datirelazione.ini') then
copyfile(Pchar(path2+'Datirelazione.ini'),pchar(percorsodrive+'\Datirelazione.ini'),false);

Fpannelloclima.apritabelle;
cancellafiletemporanei;
//opendialog1.Free;
end;
procedure nuovoprogetto;
begin

//copyfile(pchar(percorsodrive+'\prototipo.dxf'),pchar(percorsodrive+'\disegno.dxf'),false);
//copyfile(pchar(percorsodrive+'\prototipo.dwg'),pchar(percorsodrive+'\disegno.dwg'),false);
Fpannelloclima.Chiuditabelle;
Cancellafiletemporanei;
copiaprototipo;
NuovoTxt(pchar(percorso_progetti));
Item_Menu('NUOVOFABBRICATO');
deletefile(percorso_progetti+'\nomeprog.txt');
legginomeprogetto;
Fpannelloclima.apritabelle;
//Fpannelloclima.InitCadParete('','','');
deletefile(Percorsodrive+'\disegno.wmf');
Fpannelloclima.aggiornaform;
initcbpiano;
//scriptstoploop;
//eseguiautocad;
end;

Procedure SalvaProgetto(conNome:boolean);
begin
with Fpannelloclima do
  begin
 chiuditabelle;
 if (progcor=senzanome)or (connome) then
   begin
   savedialog1.initialdir:=libreriagenerale.percorsodrive+'\esempi';
   savedialog1.Execute;
   if savedialog1.FileName<>'' then
     begin
     cambiaprogetto(savedialog1.FileName);
     end
   else exit;
   end;
 copyfile(pchar(percorsodrive+'\disegno.dwg'),pchar(copy(progcor,1,length(Progcor)-3)+'dwg'),false);
 SaveTxt(PChar(Percorso_progetti),pchar(progcor));
 apritabelle;
 end;
end;

Function Caricamessaggio(nomef:string;Var mm:Tmemo;Var verde,rosso:TShape):boolean;
var ft:textfile;
    buf:string;
begin
verde.Brush.Color:=clwhite;
rosso.Brush.Color:=clred;
result:=false;
mm.Lines.Clear;
if fileexists(nomef) then
  begin
  assign(ft,nomef);
  reset(ft);
  while not eof(ft) do
    begin
    readln(ft,buf);
    mm.lines.Add(buf);
    end;
  close(ft);  
  result:=buf=Str_Tutto_OK;
  if result then
    begin
    verde.Brush.Color:=clgreen;
    rosso.Brush.Color:=clwhite;
    end;
  end
else mm.Lines.Add('Lettura non eseguita');
end;

Procedure aggiornaCalcoli;
begin
With  Fpannelloclima do
  begin
  Chiuditabelle;
  pagecontrol1.ActivePageIndex:=2;
  FineDisegno(PChar('@#'));        // Esegue Lettura del Disegno
  CaricaMessaggio(percorsodrive+NomeFile_Errori_Disegno,Fpannelloclima.memo1,shape3,shape1);
  Item_menu('AGG3D');
  apritabelle;
  end;
end;

Procedure Comandoesterno;
begin
if fileexists(Percorsodrive+'\disegno.wmf') then
  begin
  Fpannelloclima.timer1.enabled:=false;
  Nuovoprogetto;
  Fpannelloclima.timer1.enabled:=true;
  end;
if fileexists(Percorsodrive+'\disegno.eps') then
  begin
  Fpannelloclima.timer1.enabled:=false;
  deletefile(Percorsodrive+'\disegno.eps');
  apriprogetto;
  Fpannelloclima.timer1.enabled:=true;
  end;
if fileexists(Percorsodrive+'\disegno.bmp') then
  begin
  deletefile(Percorsodrive+'\disegno.bmp');
  Aggiornacalcoli;
  end;

end;
procedure TFPannelloClima.Timer1Timer(Sender: TObject);
begin
comandoesterno;
end;

procedure TFPannelloClima.SpeedButton10Click(Sender: TObject);
begin
Eseguiautocad;
end;

procedure TFPannelloClima.ToolButton3Click(Sender: TObject);
begin
ApriProgetto;
end;

procedure TFPannelloClima.CBPianoChange(Sender: TObject);
begin
dm1.tt0.edit;
dm1.tt0.Post;
dm1.tt0.edit;
aggiornascript;
end;




Function colore_CAD(ind:integer):string;
begin
case ind of
1:Result:='Rosso';
2:Result:='Giallo';
3:Result:='Verde';
4:Result:='Ciano';
5:Result:='Blu';
6:Result:='Magenta';
7:Result:='Bianco';
else result:='Colore '+inttostr(ind);
end;
end;

Function indcolore(nomecolore:string):integer;
begin
nomecolore:=Lowercase(nomecolore);
if copy(nomecolore,1,6)='colore' then
result:=strtoint(copy(nomecolore,8,length(nomecolore)-7))
else
if nomecolore='rosso' then result:=1  else
if nomecolore='giallo' then result:=2  else
if nomecolore='verde' then result:=3  else
if nomecolore='ciano' then result:=4  else
if nomecolore='blu' then result:=5  else
if nomecolore='magenta' then result:=6  else
if nomecolore='bianco' then result:=7
else result:=0;
end;

Procedure initcolori;
Var i:integer;
begin
for i:=1 to 50 do arcolori[i]:=false;
end;

Function Nuovocolore:string;
Var i:integer;
begin
i:=1;
while (i<50)and arcolori[i] do inc(i);
result:=colore_Cad(i);
end;


Procedure TFpannelloclima.Cambiacolore(modo:integer);
var table2:Ttable;
    nuovocol:string;

begin
nuovocol:=CBColoreParete.Text;
table2:=TTable.Create(nil);
with table2 do
  begin
  close;
  databasename:=percorso_progetti;
  tablename:='strutture.db';
  open;
  initcolori;
  first;
  while not eof do
    begin
    arcolori[indcolore(fields[3].asstring)]:=true;
    next;
    end;
  if arcolori[indcolore(Nuovocol)]then nuovocol:=nuovocolore;
  first;
  while (not eof)and(Uppercase(v_recconfcad.TipoParete)<>uppercase(Fieldbyname('Codice').asstring)) do
  next;
  //if NuovoColore<>'' then
  //if  NuovoColore=uppercase(fields[1].asstring) then
    begin
    edit;
    if  modo=1 then
      begin
      CBColoreParete.text:=fields[3].asstring;
      if indcolore(CBColoreParete.text)=0 then
        begin
        CBColoreParete.text:=nuovocolore;
        fields[3].asstring:=CBColoreParete.text;
        end;
      end
    else
    fields[3].asstring:=Nuovocol;
    post;
    end;
  close;
  end;
table2.Free;
end;

Procedure TFpannelloclima.CambiacoloreTUBI(modo:integer);
var table2:Ttable;
begin
table2:=TTable.Create(nil);
with table2 do
  begin
  close;
  databasename:=percorso_progetti;
  tablename:='Tipirete.db';
  open;
  initcolori;
  first;
  while not eof do
    begin
    arcolori[indcolore(fields[14].asstring)]:=true;
    next;
    end;
  first;
  while (not eof)and(uppercase(DBCarattCostruttive.text)<>uppercase(fields[1].asstring)) do
  next;
  edit;
  if modo=1 then
    begin
    CBColoreTubo.text:=fields[14].asstring ;
    if indcolore(CBColoreTubo.text)=0 then
      begin
      CBColoreTubo.text:=nuovocolore;
      fields[14].asstring:=CBColoretubo.text;
      end;
    end
  else fields[14].asstring:=CBColoreTubo.text;
  post;
  close;
  end;
table2.Free;
end;



procedure TFPannelloClima.CBCOLOREPARETEChange(Sender: TObject);
begin
Cambiacolore(2);
Script_Parete;
end;

procedure TFPannelloClima.DBConfinePareteChange(Sender: TObject);
begin
 dm1.tt0.Edit;
 dm1.tt0.post;
 dm1.tt0.Edit;
 TLineaParete;
 Script_Parete;
end;
procedure TFPannelloclima.POsizConf(riga,tln:string);
Var i,ind,err:Integer;
    table2:Ttable;

begin
table2:=TTable.Create(nil);

with table2 do
  begin
  close;
  databasename:=Percorso_progetti;
  tablename:='Confine';
  Open;

  first;
  i:=1;
  while (not eof)and(fields[0].asstring<>riga) do begin next;inc(i) end;
  if fields[0].asstring=riga then
    begin
    val(fields[29].asstring,ind,err);
    if (fields[29].asstring='')or(err<>0) then
      begin
      edit;
      fields[29].asinteger:=i;
      Post;
      end;
    if tln<>'' then
      begin
      edit;
      azzeraidentif;
      fields[29].asstring:=leggiidentif1(tln);
      Post;
      end;
    if tln='' then cbtlinea.text:=tl[strtoint(fields[29].asstring)+1].n;
    end;

  for i:=1 to 6 do tl[i].v:=false;
  first;
  while (not eof)do
    begin
    val(fields[29].asstring,ind,err);
    if (ind<>0)and(err=0) then
    tl[ind+1].v:=true;
    next;
    end;
  if tln='' then  
  for i:=2 to 6 do
  if not(tl[i].v) then cbtlinea.Items.Add(tl[i].n);
  end;
table2.Free;
end;

procedure TFPannelloClima.CbTLineaChange(Sender: TObject);
begin
//cbtlinea.Items.Clear;
PosizConf(v_recconfcad.ConfineParete,cbtlinea.Text);
script_parete;
end;

procedure TFPannelloClima.DBTipoZonaChange(Sender: TObject);
begin
script_locale;
end;

procedure TFPannelloClima.script_finestra;
begin
dm1.tt0.Edit;
dm1.tt0.post;
dm1.tt0.Edit;
ScriptFinestra(IndcodPiano(V_recconfcad.Pianocor),V_recconfcad.TipoFinestra,float_to_str(V_recconfcad.LarghFinestra,2),float_to_str(V_recconfcad.AltezFinestra,2));
end;

procedure TFPannelloClima.DBTipoFinestraChange(Sender: TObject);
begin
dm1.tt0.Edit;
dm1.tt0.post;
dm1.tt0.Edit;
ApriTabfinestre;
Script_Finestra;
end;

procedure TFPannelloClima.SpeedButton11Click(Sender: TObject);
begin
chiuditabelle;
FineDisegno(PChar(''));        // Esegue Lettura del Disegno
apritabelle;
end;


procedure TFPannelloClima.DBCarattCostruttiveChange(Sender: TObject);
begin
if dm1.tt0.Active then
 begin
 dm1.tt0.Edit;
 dm1.tt0.post;
 dm1.tt0.Edit;
 settacolore(2);
 Script_tubo;
 end;
end;

procedure TFPannelloClima.CBCOloreTuboChange(Sender: TObject);
begin
CambiacoloreTubi(2);
Script_Tubo;
end;

procedure TFPannelloClima.CBTiporeteChange(Sender: TObject);
begin
Script_Gestrete;
end;

procedure TFPannelloClima.ECodReteChange(Sender: TObject);
begin
Script_Gestrete;
end;

procedure TFPannelloClima.DBAttIreteChange(Sender: TObject);
begin
Script_Gestrete;
end;

procedure TFPannelloClima.ElungtuboChange(Sender: TObject);
begin
 Script_Gestrete;
end;

procedure TFPannelloClima.EnumcurveChange(Sender: TObject);
begin
 Script_Gestrete;
end;

procedure TFPannelloClima.CbPerdlocChange(Sender: TObject);
begin
 Script_Gestrete;
end;

procedure TFPannelloClima.SpeedButton12Click(Sender: TObject);
begin

 EseguiMenu('PERDITE');  // Esegue gli archivi pareti
 script_Gestrete;
end;

procedure TFPannelloClima.SpeedButton13Click(Sender: TObject);
begin
EseguiMenu('CALCTUBI');
end;

procedure TFPannelloClima.SpeedButton15Click(Sender: TObject);
begin
EseguiMenu('ZONE');
script_locale;
end;

procedure TFPannelloClima.SpeedButton16Click(Sender: TObject);
begin
EseguiMenu('IMPIANTI');
script_locale;
end;

procedure TFPannelloClima.SpeedButton17Click(Sender: TObject);
begin
EseguiMenu('ARCHIVIOPARETI');
script_locale;
end;

procedure TFPannelloClima.SpeedButton18Click(Sender: TObject);
begin
EseguiMenu('CONFINE');
script_locale;
end;

procedure TFPannelloClima.SpeedButton19Click(Sender: TObject);
begin
 EseguiMenu('ARCHIVIOPARETI');
script_locale;
end;

procedure TFPannelloClima.SpeedButton20Click(Sender: TObject);
begin
EseguiMenu('CONFINE');
script_locale;
end;

procedure TFPannelloClima.DBAttTermChange(Sender: TObject);
begin
SCript_terminale;
end;

procedure TFPannelloClima.DBSIMBTERMChange(Sender: TObject);
begin
SCript_terminale;

end;

procedure TFPannelloClima.EMONTAGGIOChange(Sender: TObject);
begin
SCript_terminale;
end;

procedure TFPannelloClima.EPORTChange(Sender: TObject);
begin
SCript_terminale;
end;

procedure TFPannelloClima.EPOTChange(Sender: TObject);
begin
SCript_terminale;
end;

procedure TFPannelloClima.EPERDChange(Sender: TObject);
begin
SCript_terminale;
end;

procedure TFPannelloClima.ELARGMAXChange(Sender: TObject);
begin
SCript_terminale;
end;

procedure TFPannelloClima.EINCRPOTChange(Sender: TObject);
begin
SCript_terminale;
end;

procedure TFPannelloClima.DBTipoPontiTermiciChange(Sender: TObject);
begin
  SCript_POnte;
  // Istruzione inserita da Emanuela per il caricamento del ponte termico
  CaricaImmagine(DBTipoPontiTermici.Text);
end;

procedure TFPannelloClima.DBELponteChange(Sender: TObject);
begin
SCript_POnte;
end;

procedure TFPannelloClima.SpeedButton14Click(Sender: TObject);
begin
EseguiMenu('ESTIVO');
end;

procedure TFPannelloClima.SpeedButton9Click(Sender: TObject);
begin
Fpannelloclima.chiuditabelle;
CalcoloL10;
Fpannelloclima.ApriTabelle;
end;

procedure TFPannelloClima.SpeedButton21Click(Sender: TObject);
begin
EseguiMenu('AGG3D');
end;

procedure TFPannelloClima.BarchiviotubiClick(Sender: TObject);
begin
EseguiMenu('TIPIRETE');
Script_tubo;
end;

procedure TFPannelloClima.ToolButton4Click(Sender: TObject);
begin
salvaprogetto(false);
end;

procedure TFPannelloClima.ToolButton5Click(Sender: TObject);
begin
salvaprogetto(true);
end;

// Procedure inserite da Emanuela per il caricamento delle immagini dei ponti termici
procedure TFPannelloClima.CaricaImmagine(Codice: String);
var
  NomeFile, NomeImg: String;
begin
  NomeImg := RestituisciNomeImmaginePT(Codice);
  NomeFile := Percorso_Progetti + 'Immagini_Ponti_Termici\' + NomeImg;
  If FileExists(NomeFile) then
     dbImage1.Picture.LoadFromFile(NomeFile);
end;

function TFPannelloClima.RestituisciNomeImmaginePT(Codice: String): String;
var
  TabPT: TTable;
  Trovato: Boolean;
begin
 Result := '';
 TabPT := TTable.Create(nil);
 TabPT.DatabaseName := Percorso_Progetti;
 TabPT.Tablename := 'Ponti';
 Trovato := False;
 if TabPT.Exists then
 begin
   TabPT.Open;
   TabPT.First;
   while (not TabPT.Eof) and (not Trovato) do
   begin
     if Codice = TabPT.FieldByName('Codice').AsString then
     begin
       Result :=  TabPT.FieldByName('Immagine').AsString;
       Trovato := True;
     end;
     TabPT.Next;
   end;
  TabPT.Close;
  TabPT.Free;
 end;
end;

procedure TFPannelloClima.CbDISPERDITEChange(Sender: TObject);
begin
script_valvola;
end;

procedure TFPannelloClima.CBCODPERDITEChange(Sender: TObject);
begin
script_valvola;
end;

procedure TFPannelloClima.SpeedButton22Click(Sender: TObject);
begin
Leggidxf_bm;
end;

procedure TFPannelloClima.D1Click(Sender: TObject);
begin
EseguiMenu('PERDITECONCENTRATE');         // Esegue l'Archivio valvole
end;

end.


