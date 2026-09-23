unit Wizardusolomuri;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  DB,
  DBTables,
  dbcgrids,
  Buttons, ImgList, Mask, ComCtrls, ExtCtrls,
  DBCtrls, DBGrids, Grids,
  StdCtrls, Menus, jpeg, Spin, Math, RxRichEd,
  Udb,
  UdataLink,
  UGraficoIgro,
  Calcolo,
  UVariabili,
  LibreriaGenerale,
  Ucompilaform,
  Udisegnafinestra,
  ucorrelato, UArchMat, MSG, LbSpeedButton;

Const

     Sez_001 = 'NUOVA_PARETE';
     Sez_002 = 'NUOVA_FINESTRA';
     Sez_003 = 'NUOVA_PARTE_TRASPARENTE';
     Sez_004 = 'NUOVA_PARTE_OPACA';

     Sez_005 = 'INFO_NUOVA_PORTA';
     Sez_006 = 'INFO_NUOVA_FINESTRA';
     Sez_007 = 'INSERT_MANUALE';
     Sez_008 = 'PARETE_DETTAGLI';
     Sez_009 = 'FINESTRA_PROP_TERMICHE';
     Sez_010 = 'FINESTRA_SOLARI';
     
type
  TWizardFSoloMuri = class(TForm)
    Tabfinestre: TPageControl;
    TabSheetElementiDisponibili: TTabSheet;
    GroupBox1: TGroupBox;
    TabSheet3: TTabSheet;
    Image1: TImage;
    Image2: TImage;
    ListBox1: TListBox;
    DataSource1: TDataSource;
    Table1: TTable;
    DataSource2: TDataSource;
    Table2: TTable;
    DataSource3: TDataSource;
    Table3: TTable;
    DataSource4: TDataSource;
    Table4: TTable;
    GroupBox3: TGroupBox;
    DBGrid2: TDBGrid;
    GroupBox4: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox5: TGroupBox;
    Table2Categoria: TStringField;
    Table2Descrizione: TStringField;
    Table2Spessore: TFloatField;
    Table2Indicemat: TSmallintField;
    Table2Lambda: TFloatField;
    Table2Condutt: TFloatField;
    Table2Pesospecifico: TFloatField;
    Table2Permeabilit: TFloatField;
    Table2Revisione: TIntegerField;
    Table2CapTerm: TFloatField;
    Table2Disegno: TStringField;
    Table5: TTable;
    DataSource5: TDataSource;
    DataSource6: TDataSource;
    DataSource7: TDataSource;
    Table7: TTable;
    Table6: TTable;
    TabSheet4: TTabSheet;
    Image3: TImage;
    Table2Indice: TFloatField;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Label15: TLabel;
    Shape4: TShape;
    Label16: TLabel;
    Label17: TLabel;
    Shape5: TShape;
    Label18: TLabel;
    Shape6: TShape;
    Panel4: TPanel;
    Shape7: TShape;
    Shape8: TShape;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    Label23: TLabel;
    Table2Orizz: TStringField;
    Table2FormaBMP: TStringField;
    TabSheetTermiche: TTabSheet;
    PageControl4: TPageControl;
    TabSheet10: TTabSheet;
    TabSheet11: TTabSheet;
    Image4: TImage;
    Image5: TImage;
    GroupBox11: TGroupBox;
    Label29: TLabel;
    DBComboBox5: TDBComboBox;
    Label40: TLabel;
    DBComboBox8: TDBComboBox;
    GroupBox18: TGroupBox;
    Label24: TLabel;
    DBEdit24: TDBEdit;
    Label54: TLabel;
    Label55: TLabel;
    DBEdit25: TDBEdit;
    Label56: TLabel;
    Label57: TLabel;
    DBEdit26: TDBEdit;
    Label58: TLabel;
    Label59: TLabel;
    DBEdit27: TDBEdit;
    Label60: TLabel;
    Label61: TLabel;
    DBEdit28: TDBEdit;
    Label62: TLabel;
    Label63: TLabel;
    DBEdit29: TDBEdit;
    Label64: TLabel;
    GroupBox21: TGroupBox;
    Label77: TLabel;
    DBEdit34: TDBEdit;
    Label78: TLabel;
    Label41: TLabel;
    DBEdit21: TDBEdit;
    Label42: TLabel;
    GroupBox16: TGroupBox;
    Label49: TLabel;
    Label50: TLabel;
    DBEdit22: TDBEdit;
    GroupBox19: TGroupBox;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    Label70: TLabel;
    Label71: TLabel;
    DBEdit32: TDBEdit;
    Panel2: TPanel;
    Label83: TLabel;
    Label84: TLabel;
    Panel1: TPanel;
    Label85: TLabel;
    TreeView1: TTreeView;
    Panel7: TPanel;
    Panel9: TPanel;
    BtnAvanti: TSpeedButton;
    BtnIndietro: TSpeedButton;
    ButtonCancel: TSpeedButton;
    Label81: TLabel;
    Label86: TLabel;
    Panel10: TPanel;
    TabSheetDefinizione: TTabSheet;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    StatusBar1: TStatusBar;
    TabSheetPareteDettagli: TTabSheet;
    GroupBox2: TGroupBox;
    DBGrid4: TDBGrid;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    RadioGroup1: TRadioGroup;
    GroupBox8: TGroupBox;
    PopupMenu1: TPopupMenu;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    SpeedButton1: TSpeedButton;
    Timer1: TTimer;
    Edit21: TEdit;
    Label76: TLabel;
    CopiaElemento1: TMenuItem;
    N1: TMenuItem;
    DBComboBox11: TDBComboBox;
    Label91: TLabel;
    Bar: TProgressBar;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    DBEdit42: TDBEdit;
    Label101: TLabel;
    Label102: TLabel;
    DBEdit43: TDBEdit;
    SpeedButton4: TSpeedButton;
    Label103: TLabel;
    Label104: TLabel;
    DBEdit44: TDBEdit;
    SpeedButton5: TSpeedButton;
    Label105: TLabel;
    Label106: TLabel;
    DBEdit45: TDBEdit;
    SpeedButton6: TSpeedButton;
    Label107: TLabel;
    Label108: TLabel;
    DBEdit46: TDBEdit;
    Label109: TLabel;
    GroupBox22: TGroupBox;
    Label65: TLabel;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    DBEdit47: TDBEdit;
    DBEdit48: TDBEdit;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    GroupBox23: TGroupBox;
    Label113: TLabel;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    DBEdit49: TDBEdit;
    DBEdit50: TDBEdit;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    DBEdit51: TDBEdit;
    DBEdit52: TDBEdit;
    Label121: TLabel;
    Label122: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label123: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    DBEdit53: TDBEdit;
    DBEdit54: TDBEdit;
    Label126: TLabel;
    Label127: TLabel;
    Bevel3: TBevel;
    Label128: TLabel;
    DBEdit55: TDBEdit;
    RxSpinButton15: TSpinButton;
    RxSpinButton1: TSpinButton;
    RxSpinButton2: TSpinButton;
    RxSpinButton3: TSpinButton;
    RxSpinButton4: TSpinButton;
    RxSpinButton5: TSpinButton;
    RxSpinButton6: TSpinButton;
    RxSpinButton7: TSpinButton;
    RxSpinButton8: TSpinButton;
    RxSpinButton9: TSpinButton;
    RxSpinButton10: TSpinButton;
    RxSpinButton11: TSpinButton;
    RxSpinButton12: TSpinButton;
    RxSpinButton13: TSpinButton;
    RxSpinButton14: TSpinButton;
    Label53: TLabel;
    Label129: TLabel;
    DBEdit56: TDBEdit;
    Label130: TLabel;
    DBEdit57: TDBEdit;
    Label131: TLabel;
    ComboMese: TComboBox;
    Label132: TLabel;
    DBEdit58: TDBEdit;
    Label133: TLabel;
    DBComboBox3: TDBComboBox;
    DBComboBox13: TDBComboBox;
    Label134: TLabel;
    DBComboBox14: TDBComboBox;
    Label135: TLabel;
    DBComboBox15: TDBComboBox;
    Label136: TLabel;
    DBEdit59: TDBEdit;
    Label137: TLabel;
    DBEdit60: TDBEdit;
    Label138: TLabel;
    DBEdit61: TDBEdit;
    Label139: TLabel;
    DBComboBox16: TDBComboBox;
    Label140: TLabel;
    Label141: TLabel;
    Label142: TLabel;
    Label143: TLabel;
    Label144: TLabel;
    Label145: TLabel;
    DBEdit62: TDBEdit;
    DBEdit63: TDBEdit;
    DBEdit64: TDBEdit;
    DBEdit65: TDBEdit;
    Label146: TLabel;
    Label147: TLabel;
    SpinButton1: TSpinButton;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label97: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    Label150: TLabel;
    Label151: TLabel;
    Label152: TLabel;
    Label153: TLabel;
    DBEdit38: TDBEdit;
    Label154: TLabel;
    Label33: TLabel;
    DBEdit17: TDBEdit;
    Label35: TLabel;
    GroupBox17: TGroupBox;
    Label72: TLabel;
    Label73: TLabel;
    Label75: TLabel;
    Label155: TLabel;
    DBEdit33: TDBEdit;
    DBEdit66: TDBEdit;
    Label156: TLabel;
    DBComboBox10: TDBComboBox;
    Label157: TLabel;
    DBEdit67: TDBEdit;
    Label158: TLabel;
    Label159: TLabel;
    DBEdit68: TDBEdit;
    SpinButton2: TSpinButton;
    Label160: TLabel;
    Label30: TLabel;
    Label161: TLabel;
    Label162: TLabel;
    DBEdit69: TDBEdit;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    RichEdit1: TRxRichEdit;
    SpeedButton9: TSpeedButton;
    SpinButton3: TSpinButton;
    Label166: TLabel;
    DBEdit35: TDBEdit;
    Label167: TLabel;
    Label168: TLabel;
    Button13: TSpeedButton;
    Button14: TSpeedButton;
    Button2: TSpeedButton;
    Panel3: TPanel;
    GroupBox12: TGroupBox;
    Label34: TLabel;
    Label36: TLabel;
    Label169: TLabel;
    DBEdit19: TDBEdit;
    DBComboBox4: TDBComboBox;
    GroupBox10: TGroupBox;
    Label170: TLabel;
    Label25: TLabel;
    DBEdit15: TDBEdit;
    GroupBox9: TGroupBox;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label171: TLabel;
    Label172: TLabel;
    Label173: TLabel;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit18: TDBEdit;
    GroupBox13: TGroupBox;
    Label38: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label174: TLabel;
    Label37: TLabel;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    DBEdit20: TDBEdit;
    DBComboBox6: TDBComboBox;
    DBEdit39: TDBEdit;
    DBEdit40: TDBEdit;
    DBEdit23: TDBEdit;
    GroupBox14: TGroupBox;
    Label39: TLabel;
    DBComboBox7: TDBComboBox;
    Button16: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Image6: TImage;
    Image7: TImage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Shape_Ver: TShape;
    LB_InfoVer: TLbSpeedButton;
    Label6: TLabel;
    Shape_VerF: TShape;
    LB_InfoVerF: TLbSpeedButton;
    LB_TipoDiv: TLabel;
    DBCombo_TipoDiv: TDBComboBox;
    Label7: TLabel;
    Label8: TLabel;
    Ed_TrasmFin: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure DataSource2DataChange(Sender: TObject; Field: TField);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Table2AfterPost(DataSet: TDataSet);
    procedure ListBox1Click(Sender: TObject);
    procedure Table3AfterPost(DataSet: TDataSet);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure TabfinestreChange(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure BtnIndietroClick(Sender: TObject);
    procedure BtnAvantiClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBEdit15KeyPress(Sender: TObject; var Key: Char);
    procedure DBComboBox3KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit36KeyPress(Sender: TObject; var Key: Char);
    procedure ButtonCancelClick(Sender: TObject);
    procedure DBGrid2DragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure DBGrid2DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure MoveUp1Click(Sender: TObject);
    procedure MoveDown1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Edit21KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure CopiaElemento1Click(Sender: TObject);
    procedure DBEdit7KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit37KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure DBEdit28Change(Sender: TObject);
    procedure DBEdit29Change(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure RxSpinButton1DownClick(Sender: TObject);
    procedure RxSpinButton1UpClick(Sender: TObject);
    procedure DBComboBox5Change(Sender: TObject);
    procedure DBComboBox11Change(Sender: TObject);
    procedure DBComboBox6Change(Sender: TObject);
    procedure DBComboBox13Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure DBEdit23KeyPress(Sender: TObject; var Key: Char);
    procedure ComboMeseChange(Sender: TObject);
    procedure DBEdit55Change(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure DBComboBox3Change(Sender: TObject);
    procedure DBComboBox14Change(Sender: TObject);
    procedure DBComboBox15Change(Sender: TObject);
    procedure DBComboBox16Change(Sender: TObject);
    procedure DBComboBox4Change(Sender: TObject);
    procedure DBComboBox7Change(Sender: TObject);
    procedure DBComboBox8Change(Sender: TObject);
    procedure DBEdit42Change(Sender: TObject);
    procedure DBEdit47Change(Sender: TObject);
    procedure DBEdit48Change(Sender: TObject);
    procedure LB_InfoVerClick(Sender: TObject);
    procedure LB_InfoVerFClick(Sender: TObject);

  private
    procedure AttivaTab(NomeTab: TTabSheet);
    procedure Setta_Pulsanti;
    procedure Chiudi_Finestra;
    procedure Nuovo_Elemento;
    procedure Aggiorna_Grafico;
    procedure Muovi_Elemento(Direzione: Integer; DbGrid2: TDBGrid);
    procedure Aggiorna_Campo(Campo: TDBEdit; Incremento: Double);
    function Determina_Incremento(Valore: TDBEdit): Double;
    procedure Aggiorna_Adduttanza;
    procedure FindAddress(Sezione: String);
    procedure CaricaDatiTemperaturediProgetto;
    procedure CaricaHI_HE(CodiceVetro: String);

    { Private declarations }
  public
    { Public declarations }
    DirProg,Dirarch,Dirfile, DirImmagini:string;
    Nuovo_E : Boolean;
    Codice : String;
    Procedure AttivaMuri(DP,DA,DF, DI:string);
    Procedure AttivaFinestre(DP,DA,DF, DI:string);

  end;

//Procedure AttivaMuri(DP,DA,DF:string);
//Procedure AttivaFinestre(DP,DA,DF:string);
//Procedure Genera_Immagini(DP,DA,DF,DI:Pchar);

var
  WizardFSoloMuri: TWizardFSoloMuri;
//  Attivo,Pareti,GeneraIm:boolean;
  i:integer;


implementation
uses udispersioni, USolomuri, UtilityGestioneTutor, Coefficienti;
{$R *.dfm}

Procedure Grafico(cnv:integer);
begin
With WizardFSoloMuri do
  begin
  If pareti then
    begin
   // with chart1.BackImage do
   // disegnagrafico(Width,Height,false,1,Table7,dm1.tt3);
    if not generaim then disegnagrafico(WizardFSoloMuri.image2, image2.Width,image2.Height,false,cnv,table7,dm1.tt3);
    //table4.Refresh;
    end
  else
    begin
    if not generaim then disegnaFinestra(WizardFSoloMuri.image3, WizardFSoloMuri.image3.Width,WizardFSoloMuri.image3.Height,true,cnv,table7,dm1.tt3);
    //table4.Refresh;
    end
  end;
end;

Procedure CreaDBImmagini(var tabella1:TTable);
begin
With Tabella1 Do
  Begin
  Close;
  try fieldDefs.clear except end;
  try IndexDefs.clear except end;
  tableType:=ttdefault;
  Fielddefs.Add('Indice',ftautoinc,0,false);
  Fielddefs.Add('Numero',ftinteger,0,false);
  Fielddefs.Add('Immagine',ftgraphic,0,false);
  Fielddefs.Add('Descrizione',ftstring,50,false);
  Fielddefs.Add('Codice',ftstring,10,false);
  IndexDefs.Add('PerIndice','Indice',[IxPrimary]);
  IndexDefs.Add('PerNumero','Numero',[IXdescending]);
  CreateTable;
  End;
end;

Procedure Attiva_Muri(DP,DA,DF, DI:string);
Var
  Nomemaster,nomeslave,nomeIM:string;
begin
  If not fileexists(dp+'\strutture.db')then
  begin
    showmessage('Percorso: '+DP+' -non corretto');
    exit;
  end;
  If not fileexists(da+'\strutture.db')then
  begin
    showmessage('Percorso: '+DA+' - non corretto');
    exit;
  end;

  WizardFSoloMuri:= TWizardFSoloMuri.Create(Application);
  if pareti then InitCalcolo;
  attivo:=false;
  WizardFSoloMuri.DirProg:=Dp;
  WizardFSoloMuri.DirArch:=DA;
  WizardFSoloMuri.DirFile:=Df;
  WizardFSoloMuri.DirImmagini := Di;
  PercorsoDrive := Df;
  //fsolomuri.Table4.databasename:=da;
  //fsolomuri.Table4.Open;
  WizardFSoloMuri.DBEdit29.OnChange := nil;
  InitUdb(Dp);
  WizardFSoloMuri.DBEdit29.OnChange := WizardFSoloMuri.DBEdit29Change;

  if pareti then
  begin
    WizardFSoloMuri.Caption:='Elenco delle pareti del progetto';
    Nomemaster:='strutture';
    nomeslave:='strati';
    nomeIM:='immagini';
  end
  else
  begin
    WizardFSoloMuri.Caption:='Elenco delle porte e delle finestre del progetto';
    Nomemaster:='finestre';
    nomeslave:='setti';
    nomeIM:='immaginiF';
    //WizardFSoloMuri.dbctrlgrid2.datasource:=WizardFSoloMuri.datasource3;
    //WizardFSoloMuri.dbctrlgrid3.datasource:=WizardFSoloMuri.datasource3;
  end;

  dm1.TT1.tablename:=Nomemaster;
  dm1.TT3.tablename:=Nomeslave;


  //if not fileexists(da+'\strutture.db') then
  if false then
    begin
    dm1.TT1.databasename:=Da;
    creadatabase('strutture');
    dm1.TT3.databasename:=Da;
    creadatabase('strati');
    dm1.TT1.databasename:=Dp;
    creadatabase('strutture');
    dm1.TT3.databasename:=Dp;
    creadatabase('strati');
    WizardFSoloMuri.Table7.Databasename:=dp;
    WizardFSoloMuri.Table7.Tablename:='Immagini';
    WizardFSoloMuri.StatusBar1.Panels[1].Text :=dp;
    creaDbImmagini(WizardFSoloMuri.Table7);
    WizardFSoloMuri.Table6.Databasename:=da;
    WizardFSoloMuri.Table6.Tablename:='Immagini';
    creaDbImmagini(WizardFSoloMuri.Table6);
    end;


  if not fileexists(da+'\'+Nomemaster+'.db') then
    begin
    dm1.tt1.Close;
    dm1.tt1.Databasename:=da;
    dm1.tt1.tablename:=Nomemaster;
    creadatabase(Nomemaster);
    end;
  if not fileexists(da+'\'+Nomeslave+'.db') then
    begin
    dm1.tt1.Close;
    dm1.tt1.Databasename:=da;
    dm1.tt1.tablename:=NomeSlave;
    creadatabase(NomeSlave);
    end;


  WizardFSoloMuri.Datasource3.Dataset:=dm1.TT3;
  WizardFSoloMuri.Datasource4.Dataset:=dm1.TT1;
  dm1.TT1.tablename:=Nomemaster;
  dm1.TT3.tablename:=Nomeslave;
  InitAssociata;
  dm1.TT1.open;
  dm1.TT3.open;
  dm1.TT1.First;
  dm1.TT3.First;



  IF  pareti then
    begin
         WizardFSoloMuri.DBEdit36.tag := 7;
         WizardFSoloMuri.DBEdit37.tag := 8;
         WizardFSoloMuri.DBComboBox11.Tag := 12;

    //compilagriglia(Fsolomuri.DBGrid3,'Strutture',fsolomuri.datasource3);
    WizardFSoloMuri.Panel4.visible:=false;
    compilaform(WizardFSoloMuri.groupbox5,'Strutture',WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox21,'Strutture',WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox8,'Strutture',WizardFSoloMuri.Datasource4);

    with WizardFSoloMuri.DBGrid2 do
      begin
      Columns.Add;
      Columns[0].Width := 35;
      Columns[0].Field:=dm1.TT3.Fields[2];
      Columns[0].Title.Caption := 'Cod.';

      Columns.Add;
      Columns[1].Field:=dm1.TT3.Fields[3];
      Columns[1].width:=170;
      Columns[1].Title.Caption := 'Descrizione';

      Columns.Add;
      Columns[2].Field:=dm1.TT3.Fields[5];
      Columns[2].Width := 45;
      Columns[2].Title.Caption := 'Spessore';

      Columns.Add;
      Columns[3].Width := 45;
      Columns[3].Field:=dm1.TT3.Fields[7];
      Columns[3].Title.Caption := 'Lambda';

      Columns.Add;
      Columns[4].Width := 45;
      Columns[4].Field:=dm1.TT3.Fields[6];
      Columns[4].Title.Caption := 'Cond.';
      end;

  // Visualizza Griglia Archivio Materiali

    with WizardFSoloMuri.DBGrid1 do
      begin
      readonly:=true;


      // Colonna Categoria
      Columns.Add;
      Columns[0].Width := 35;
      Columns[0].Field:=WizardFSoloMuri.Table2.Fields[11];
      Columns[0].Title.Caption := 'Cod.';

      Columns.Add;
      Columns[1].Width := 170;
      Columns[1].Field:=WizardFSoloMuri.Table2.Fields[2];
      Columns[1].Title.Caption := 'Descrizione';

      // Colonna Lambda
      Columns.Add;
      Columns[2].Width := 60;
      Columns[2].Field:=WizardFSoloMuri.Table2.Fields[4];
      Columns[2].Title.Caption := 'Lambda';
      // Colonna Cap.Term.
      Columns.Add;
      Columns[3].Width := 60;
      Columns[3].Field:=WizardFSoloMuri.Table2.Fields[5];
      Columns[3].Title.Caption := 'Cond.';
      end;


    //Fsolomuri.dbimage1.left:=360;

    with WizardFSoloMuri.DBGrid4 do
      begin
      Columns.Add;
      Columns[0].Field:=dm1.TT3.Fields[3];
      Columns[0].width:=185;
      Columns.Add;
      Columns[1].Field:=dm1.TT3.Fields[5];
      visible:=true;
      WizardFSoloMuri.groupbox2.caption:='Stratigrafia della parete selezionata';
      end;
    end
  else // if pareti
    begin
    WizardFSoloMuri.DBEdit36.tag := 12;
    WizardFSoloMuri.DBEdit37.tag := 27;


    WizardFSoloMuri.groupbox2.caption:='Caratteristiche della finestra selezionata';
    //fsolomuri.Label24.Visible:=false;
    //fsolomuri.BitBtn1.Visible:=false;

    //compilaform(WizardFSoloMuri.groupbox6,nomeslave,NIL);
    //compilaform(WizardFSoloMuri.groupbox7,nomeslave,NIL);

    compilaform(WizardFSoloMuri.groupbox8,nomeMaster,WizardFSoloMuri.Datasource4);

    compilaform(WizardFSoloMuri.groupbox9,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox10,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox11,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox12,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox13,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox14,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox18,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox19,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox17,nomeMaster,WizardFSoloMuri.Datasource4);
    //compilaform(WizardFSoloMuri.groupbox171,nomeMaster,WizardFSoloMuri.Datasource4);
    WizardFSoloMuri.DBEdit47.OnChange := nil;
    WizardFSoloMuri.DBEdit48.OnChange := nil;
    compilaform(WizardFSoloMuri.groupbox22,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox23,nomeMaster,WizardFSoloMuri.Datasource4);
    compilaform(WizardFSoloMuri.groupbox16,nomeMaster,WizardFSoloMuri.Datasource4);
    WizardFSoloMuri.DBEdit47.OnChange := WizardFSoloMuri.DBEdit47Change;
    WizardFSoloMuri.DBEdit48.OnChange := WizardFSoloMuri.DBEdit48Change;;

    with dm1.TT0 do
    begin
      DatabaseName:=Percorso_Archivi;
      Tablename:='Ponti';
      open;
      first;
      while not eof do
        begin
        WizardFSoloMuri.DbCombobox4.Items.Add(dm1.TT0.fields[0].asstring);
        WizardFSoloMuri.DbCombobox7.Items.Add(dm1.TT0.fields[0].asstring);
        next;
        end;
      close;

      WizardFSoloMuri.DbCombobox6.Clear;
      WizardFSoloMuri.DbCombobox5.Clear;
      DatabaseName:=dp;
      Tablename:='Strutture';
      open;
      first;
      while not eof do
      begin
        if CompareStr(dm1.TT0.FieldByName('Categoria').asstring, 'OPACO') = 0 then
           WizardFSoloMuri.DbCombobox6.Items.Add(dm1.TT0.fields[2].asstring)
        else WizardFSoloMuri.DbCombobox5.Items.Add(dm1.TT0.fields[2].asstring);
        next;
      end;
      close;
    end;

     WizardFSoloMuri.DbCombobox5.itemIndex := 0;
     WizardFSoloMuri.DbCombobox6.itemIndex := 0;
    //WizardFSoloMuri.dbcombobox1.Items.Add('Finestra');
    //WizardFSoloMuri.dbcombobox1.Items.Add('Parete');
    //WizardFSoloMuri.dbcombobox2.Items.Add('Finestra');
    //WizardFSoloMuri.dbcombobox2.Items.Add('Parete');
    end;


  WizardFSoloMuri.Table2.close;
  // Modifica del 04/02/2004 by piero
  // la cartella dei tabella dei materiali è generale
  WizardFSoloMuri.Table2.Databasename:=di;
  WizardFSoloMuri.Table2.tablename:='Materiali';
  WizardFSoloMuri.Table2.Open;

  WizardFSoloMuri.Table1.close;
  WizardFSoloMuri.Table1.Databasename:=da;
  WizardFSoloMuri.Table1.tablename:=Nomemaster;
  //WizardFSoloMuri.Table1.Mastersource:= WizardFSoloMuri.DataSource6;
  WizardFSoloMuri.Table1.Open;

  WizardFSoloMuri.Table5.close;
  WizardFSoloMuri.Table5.Databasename:=da;
  WizardFSoloMuri.Table5.Mastersource:=WizardFSoloMuri.DataSource1;
  WizardFSoloMuri.Table5.IndexName:='PerNumero';
  WizardFSoloMuri.Table5.MasterFields:='Numero';
  WizardFSoloMuri.Table5.tablename:=Nomeslave;
  WizardFSoloMuri.Table5.Open;

  WizardFSoloMuri.Table7.close;
  WizardFSoloMuri.Table7.Databasename:=dp;
  WizardFSoloMuri.Table7.Tablename:=Nomeim;
  WizardFSoloMuri.StatusBar1.Panels[0].Text :=dp;

  if not fileexists(dp+'\'+NomeIm+'.db') then
    begin
    creaDbImmagini(WizardFSoloMuri.Table7);
    WizardFSoloMuri.Table7.open;
    WizardFSoloMuri.Table7.first;
    //if not fsolomuri.Table7.eof then
      begin
      WizardFSoloMuri.Table7.edit;
      WizardFSoloMuri.Table7.delete;
      end;
    end;
  WizardFSoloMuri.Table7.Mastersource:=WizardFSoloMuri.DataSource4;
  WizardFSoloMuri.Table7.MasterFields:='Numero';
  WizardFSoloMuri.Table7.IndexName:='PerNumero';
  //if not (fileexists(dp+'\immagini.db')) then
  //generaImmagini(dm1.tt1,fsolomuri.table7,dm1.tt3,fsolomuri.table7Immagine);
  //try
  //fsolomuri.Table7.Open;
  //except
  //creaDbImmagini(fsolomuri.Table7);
  //generaImmagini(dm1.TT1,fsolomuri.table7,dm1.tt3);
  //fsolomuri.Table7.Open;
  //end;
  WizardFSoloMuri.Table7.Open;
  //fsolomuri.DBText2.DataField:='Descrizione';

  WizardFSoloMuri.Table6.close;
  WizardFSoloMuri.Table6.Databasename:=da;
  WizardFSoloMuri.Table6.Tablename:=Nomeim;
  if not fileexists(da+'\'+NomeIm+'.db') then
  creaDbImmagini(WizardFSoloMuri.Table6);
  WizardFSoloMuri.Table6.Mastersource:=nil;
  //fsolomuri.Table6.Mastersource:=fsolomuri.DataSource1;
  WizardFSoloMuri.Table6.MasterFields:='Numero';
  WizardFSoloMuri.Table6.IndexName:='PerNumero';
  //if not(fileexists(da+'\immagini.db')) then
  //try
  //fsolomuri.Table6.Open;
  //except
  //creaDbImmagini(fsolomuri.Table6);
  //fsolomuri.Table6.Mastersource:=fsolomuri.datasource1;
  //generaImmagini(fsolomuri.Table1,fsolomuri.table6,fsolomuri.table5);
  //fsolomuri.Table6.Mastersource:=nil;
  WizardFSoloMuri.Table6.Open;
  //end;



  if generaim then
    begin
    dm1.tt1.first;
    while not dm1.tt1.eof do
      begin
      Grafico(1);
      dm1.tt1.next;
      end;
    end;
  //else  WizardFSoloMuri.showmodal;


  //crea_strutture(DM1.tt1);{ Modificato Num ftautoinc -> Ftinteger }
  dm1.TT1.Open;
  (*
  with Fsolomuri do
    begin
    table4.First;
    while not table4.eof do
      begin
      dm1.TT1.Append;
      dm1.TT1.Edit;
      with V_TabStruttura do
        begin
        //Table4Verticale: TBooleanField;
        Set_Num(Table4Numero.Value);
        //Set_NFile(Table4Numero.Value);
        Set_Descr(Table4Descrizione.Value);
        Set_HI(Table4Adduttanzainterna.Value);
        Set_HE(Table4Adduttanzaesterna.Value);
        //Set_Trasmitt(.Value);
        End;
      dm1.TT1.POst;
      table4.Next;
      end;
    end;
   *)
  //freeandNil(FSolomuri);

end;

Procedure TWizardFSoloMuri.AttivaMuri(DP,DA,DF, DI:string);
begin
  Pareti:=True;
  GeneraIm:=false;
  Attiva_Muri(DP,DA,DF, DI);
end;

Procedure TWizardFSoloMuri.AttivaFinestre(DP,DA,DF, DI:string);
begin
  Pareti:=False;
  GeneraIm:=false;
  Attiva_Muri(DP,DA,DF, DI);
end;

{
Procedure Genera_Immagini(DP,DA,DF,DI:Pchar);
begin
GeneraIm:=true;
Pareti:=True;
Attiva_Muri(strpas(DP),strpas(DA),strpas(DF), strpas(DI));
WizardFSoloMuri.close;
Pareti:=false;
Attiva_Muri(strpas(DP),strpas(DA),strpas(DF), strpas(DI));
WizardFSoloMuri.close;
end;     }

Procedure AttivaFiltro;
var
   Indice : Integer;
begin

with WizardFSoloMuri do
if listbox1.Itemindex>=0 then
  begin
       Indice := Table2.FindField('indice').AsInteger;
       Table2.filter:='Categoria='''+ListBox1.Items.Strings[listbox1.Itemindex]+'''';
       Table2.filtered:=true;
       Table2.Locate('indice', Indice, [])
  end
else WizardFSoloMuri.Table2.filtered:=true;
end;

Function Inlista(term:string):boolean;
Var i:Integer;
begin
with WizardFSoloMuri.ListBox1 do
  begin
  i:=0;
  result:=false;
  while (i< items.Count)and(not result) do
    begin
    inc(i);
    result:=term=items.Strings[i-1];
    end;
  if not result then items.Add(term);
  end;

end;

Procedure SettaFiltro;
begin
with WizardFSoloMuri do
  begin
  table2.disablecontrols;
  listbox1.items.clear;
  table2.Filtered:=false;
  table2.first;
  while not table2.Eof do
    begin
    inlista(table2Categoria.Value);
    table2.Next;
    end;
  table2.Filtered:=true;
  table2.Enablecontrols;
  end;

end;

procedure TWizardFSoloMuri.FormActivate(Sender: TObject);
begin
     if Pareti then
        begin
             settafiltro;
             attivafiltro;
        end;
//Grafico;
end;

procedure TWizardFSoloMuri.DataSource2DataChange(Sender: TObject; Field: TField);
Var NomFile:String;
begin
//if attivo then
  begin
   NomFile:=Percorso_Archivi +'Disegni\'+table2Disegno.Value+'.bmp';
  if FileExists(NomFile) then
  if table2Disegno.Value<>'' then
  image1.Picture.loadfromfile(NomFile);
  end;
end;

procedure TWizardFSoloMuri.DBGrid1DblClick(Sender: TObject);
begin
  dm1.TT3.Append;
  dm1.TT3.Edit;
  V_Recstrati.set_descrizione(Table2Descrizione.Value);
  V_Recstrati.set_NFile(Table2Indice.asstring);
  V_Recstrati.set_Disegno(Table2Disegno.Value);
  V_Recstrati.set_Spessore(Table2Spessore.Value);
  V_Recstrati.set_ConduttivitaLineare(Table2Lambda.Value);
  V_Recstrati.set_PesoSpecifico(Table2Pesospecifico.Value);
  V_Recstrati.set_mu(Table2Permeabilit.Value);
  V_Recstrati.set_CaloreSpecifico(Table2CapTerm.Value);
  V_Recstrati.set_Conduttanza(Table2Condutt.Value);
  V_Recstrati.set_Stretch(Table2FormaBMP.Value);

  //Table3.Refresh;
  {Table3Disegno.Value:=Table2Disegno.Value;}
  {Table3Conduttanza.Value:=Table2Lamdamat.Value;
  Table3Pesospecifico.Value:=Table2Massemat.Value;}
  //Table3.post;
  dm1.TT3.POst;
  disegnagrafico(WizardFSoloMuri.Image2, image2.Width,image2.Height,false,1,table6,dm1.tt3);
end;

procedure TWizardFSoloMuri.Table2AfterPost(DataSet: TDataSet);
begin
 Inlista(table2Categoria.Value);
end;

procedure TWizardFSoloMuri.ListBox1Click(Sender: TObject);
begin
 Attivafiltro;
 DisegnaMateriale(Image1);
end;

procedure TWizardFSoloMuri.Table3AfterPost(DataSet: TDataSet);
begin
 Grafico(1);
end;
(*
procedure TFSoloMuri.Table3AfterDelete(DataSet: TDataSet);
begin
Grafico;
end;
*)
(*
procedure TFSoloMuri.DrawGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  index: integer;
  bmp:Tbitmap;
begin
  bmp:=TBitmap.Create;
  bmp.LoadFromFile('d:\bmsistemi\archivi\pareti\disegni\2928.bmp');
  {
  for index:=1 to 20 do ImageList1.Add(bmp,bmp);
  index := ARow * DrawGrid1.ColCount + ACol;}
  with Sender as TDrawGrid do
  begin
  Canvas.Brush.bitmap:=bmp;
  Canvas.fillrect(Rect);
    {Canvas.Brush.Color := clBackGround;
    Canvas.FillRect(Rect);
    ImageList1.Draw(Canvas,Rect.Left,Rect.Top,index);}
    if gdFocused in State then
      Canvas.DrawFocusRect(Rect);
  end;
end;
*)
procedure TWizardFSoloMuri.Button2Click(Sender: TObject);
Var
   i : Integer;
begin
     FarchMat:=TFarchMat.create(nil);
     FArchmat.ListBox1.Items.Add('Tutti');
     for i := 0 to ListBox1.Items.Count - 1 do
        FArchmat.ListBox1.Items.Add(ListBox1.Items[i]);
     FarchMat.showmodal;
end;

procedure TWizardFSoloMuri.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 // Emansuela 21/10/2004 patch: parte spostata nell'attivazione della pagina
 { if Pareti then
  begin
     ForceDirectories(Percorso_progetti + 'Immagini_igro\');
     Image2.Picture.SaveToFile(Percorso_progetti + 'Immagini_igro\' + DbEdit36.Text + '_igro.bmp');
  end; }

  Table1.close;
  Table2.close;
  Table3.close;
  Table4.close;
  Table5.close;
  Table6.close;
  Table7.close;
  action:=cafree;
end;

procedure TWizardFSoloMuri.FormDestroy(Sender: TObject);
begin
 WizardFSoloMuri:=nil;
end;

procedure TWizardFSoloMuri.TabfinestreChange(Sender: TObject);
begin
 Grafico(1);
end;

procedure TWizardFSoloMuri.DBGrid1CellClick(Column: TColumn);
begin
     disegnamateriale(image1);
     DbGrid1.DragMode := dmAutomatic;
     Timer1.Enabled := True;
end;

procedure TWizardFSoloMuri.Button13Click(Sender: TObject);
begin

     if MessageDlg('Attenzione confermi la cancellazione dell''elemento selezionato ' + dm1.TT3.FindField('descrizione').AsString + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) <> mrYes then
        Exit;


with dm1.TT3 do
  begin
       edit;
       delete;
       Grafico(1);
  end;
end;


procedure TWizardFSoloMuri.Button14Click(Sender: TObject);
begin
     dm1.TT3.Edit;
     dm1.TT3.POst;
     Grafico(1);
end;

procedure TWizardFSoloMuri.BitBtn1Click(Sender: TObject);
begin

//ColorDialog1.Execute;
//BitBtn1.Glyph.Canvas.brush.color:={ColorDialog1.color}Clred;
//BitBtn1.Glyph.Canvas.FillRect(rect(0,0,50,50));

end;

procedure TWizardFSoloMuri.Button16Click(Sender: TObject);
begin
     Aggiorna_Grafico;
end;

procedure TWizardFSoloMuri.Aggiorna_Grafico;
begin
     dm1.TT1.Edit;
     dm1.TT1.POst;
     if not Pareti then
        CostruisciFinestra;

     Grafico(1);
end;

procedure TWizardFSoloMuri.TreeView1Click(Sender: TObject);
begin
    // Exit;
     if TreeView1.Selected = Nil then
        Exit;

     AttivaTab(Tabfinestre.Pages[TreeView1.Selected.Index]);
end;


procedure TWizardFSoloMuri.AttivaTab(NomeTab : TTabSheet);
Var
   i : Integer;
   Nodo : TTreeNode;
begin
     For i := 0 to Tabfinestre.PageCount - 1 do
        Tabfinestre.Pages[i].TabVisible := False;


     NomeTab.Visible := True;
     Tabfinestre.ActivePage := NomeTab;

     Nodo := TreeView1.Items[Tabfinestre.ActivePage.PageIndex];
     Nodo.Selected := True;

     Bar.Position := Nodo.AbsoluteIndex + 1;

     Setta_Pulsanti;
end;

procedure TWizardFSoloMuri.Setta_Pulsanti;
Var
   Delta : Integer;
begin
     BtnIndietro.Enabled := Tabfinestre.ActivePageIndex > 0;

     if (Tabfinestre.ActivePage = TabSheetElementiDisponibili) then // Elementi Disponibili
        Delta := 1
     else
        Delta := 0;

     if Tabfinestre.ActivePageIndex < Tabfinestre.PageCount - 1 - Delta then
        BtnAvanti.Caption := '&Avanti >'
     else
        BtnAvanti.Caption := 'Fine'
end;


procedure TWizardFSoloMuri.BtnIndietroClick(Sender: TObject);
Var
   Delta : Integer;
begin
     if (Tabfinestre.ActivePage = TabSheetPareteDettagli) then
        Delta := 3 // ritorno alla maschera di glaser
     else if (Tabfinestre.ActivePage = TabSheetElementiDisponibili) then
        if RadioGroup1.ItemIndex = 0 then // calcolo secondo norma
           Delta := 0
        else
           Delta := 3 // ritorno alla maschera di glaser
     else if (Tabfinestre.ActivePage = TabSheet4) then  // caratteristiche geometriche
        Delta := 1
     else
        Delta := 0;

     Delta := 0;
     AttivaTab(Tabfinestre.Pages[Tabfinestre.ActivePageIndex - 1 - Delta]);
end;


procedure TWizardFSoloMuri.Chiudi_Finestra;
Var
   Valore, Spessore : Double;
   Code : Integer;
begin
     if (Tabfinestre.ActivePage = TabSheetTermiche) then // Elementi Disponibili
        begin
             Val(DbEdit30.Text, Valore, Code);
             if (Code <> 0) or (Valore <= 0) then
                begin
                     MessageDlg(MSG_004023007, mtWarning, [mbOK], 0);
                     DBEdit30.SetFocus;
                     Exit
                end;

             Val(DbEdit31.Text, Valore, Code);
             if (Code <> 0) or (Valore < 0) then
                begin
                     MessageDlg(MSG_004023008, mtWarning, [mbOK], 0);
                     DBEdit31.SetFocus;
                     Exit
                end;
             {if DBComboBox9.Visible and (DBComboBox9.ItemIndex = - 1) then
                begin
                     MessageDlg(Msg_10, mtWarning, [mbOK], 0);
                     DBComboBox9.SetFocus;
                     Exit
                end;  }
             Val(DbEdit32.Text, Valore, Code);
             if (Code <> 0) or (Valore < 0) or (Valore > 100) then
                begin
                     MessageDlg(MSG_004023009, mtWarning, [mbOK], 0);
                     DBEdit32.SetFocus;
                     Exit
                end;
             Val(DbEdit33.Text, Valore, Code);
             if (Code <> 0) or (Valore < 0) or (Valore > 1) then
                begin
                     MessageDlg(MSG_004023034, mtWarning, [mbOK], 0);
                     DBEdit33.SetFocus;
                     Exit
                end;
             if DBComboBox10.ItemIndex = - 1 then
                begin
                     MessageDlg(MSG_004023035, mtWarning, [mbOK], 0);
                     DBComboBox10.SetFocus;
                     Exit
                end;
        end
     else if (Tabfinestre.ActivePage = TabSheetPareteDettagli) then // Elementi Disponibili
        begin
             DbGrid4.DataSource.DataSet.First;

             Spessore := 0;
             while not DbGrid4.DataSource.DataSet.Eof do
                begin
                     Spessore := Spessore + DbGrid4.DataSource.DataSet.FindField('Spessore').AsFloat;
                     DbGrid4.DataSource.DataSet.Next;
                end;

             dm1.TT1.Edit;
             dm1.TT1['spessoreparete'] := Spessore;
             dm1.TT1.Post;
        end;


     // nel caso di finestra devo memorizzare i k
     // effettuo un controllo se esiste l'elemento in archivio e
     // copio i valori dei k
     if not Pareti then
        begin
             // ricerco il valore relativo al cassonetto


        end;
     Grafico(2);
     Close;
end;


procedure TWizardFSoloMuri.BtnAvantiClick(Sender: TObject);
Var
   Valore : Double;
   Code : Integer;
   Query : TQuery;
   Esiste_Codice : Boolean;
begin
     if Pareti then WizardFSoloMuri.Shape_Ver.Brush.Color := $0000EA00
     else WizardFSoloMuri.Shape_VerF.Brush.Color := $0000EA00;
     if BtnAvanti.Caption = 'Fine' then
        begin
             if not Pareti then CaricaHI_HE(DBComboBox5.Text);
             Chiudi_Finestra;
             Exit;
        end;

     Case Tabfinestre.ActivePageIndex of
       0 : begin    // Definizione Parete
                if DBEdit36.Text = '' then
                   begin
                        MessageDlg(MSG_004023010, mtWarning, [mbOK], 0);
                        DBEdit36.SetFocus;
                        Exit
                   end;

                if DBEdit37.Text = '' then
                   begin
                        MessageDlg(MSG_004023011, mtWarning, [mbOK], 0);
                        DBEdit37.SetFocus;
                        Exit
                   end;

               if Pareti then
               begin
                // Emanuela patch del 21/10/04: verifica se il valore inserito è un floating point
                Val(dbEdit9.Text, Valore, Code);
                if Code <> 0 then
                begin
                  MessageDlg(MSG_004023012, mtWarning, [mbOK], 0);
                  DBEdit9.SetFocus;
                  Exit
                end;

                Val(dbEdit10.Text, Valore, Code);
                if Code <> 0 then
                begin
                  MessageDlg(MSG_004023013, mtWarning, [mbOK], 0);
                  DBEdit10.SetFocus;
                  Exit
                end;

                Val(dbEdit11.Text, Valore, Code);
                if Code <> 0 then
                begin
                  MessageDlg(MSG_004023014, mtWarning, [mbOK], 0);
                  DBEdit11.SetFocus;
                  Exit
                end;

                Val(dbEdit12.Text, Valore, Code);
                if Code <> 0 then
                begin
                  MessageDlg(MSG_004023015, mtWarning, [mbOK], 0);
                  DBEdit12.SetFocus;
                  Exit
                end;

                Val(dbEdit62.Text, Valore, Code);
                if Code <> 0 then
                begin
                  MessageDlg(MSG_004023016, mtWarning, [mbOK], 0);
                  DBEdit62.SetFocus;
                  Exit
                end;

                Val(dbEdit63.Text, Valore, Code);
                if Code <> 0 then
                begin
                  MessageDlg(MSG_004023017, mtWarning, [mbOK], 0);
                  DBEdit63.SetFocus;
                  Exit
                end;

                Val(dbEdit64.Text, Valore, Code);
                if Code <> 0 then
                begin
                  MessageDlg(MSG_004023018, mtWarning, [mbOK], 0);
                  DBEdit64.SetFocus;
                  Exit
                end;

                Val(dbEdit65.Text, Valore, Code);
                if Code <> 0 then
                begin
                  MessageDlg(MSG_004023019, mtWarning, [mbOK], 0);
                  DBEdit65.SetFocus;
                  Exit
                end;
              end;

                if Nuovo_E then
                begin
                     Query := TQuery.Create(Application);
                     Query.DatabaseName := dm1.TT1.DatabaseName;
                     Query.Active := False;
                     Query.SQL.Add('select * from ' + dm1.TT1.TableName + ' where Upper(codice) = ''' + UpperCase(DBEdit36.Text) + '''');
                     Query.Active := True;
                     Esiste_Codice := Query.RecordCount >= 1;
                     Query.Active := False;
                     FreeandNil(Query);

                     if Esiste_Codice then
                     begin
                        MessageDlg(MSG_004015008, mtWarning, [mbOK], 0);
                        DBEdit36.SetFocus;
                        Exit
                     end;

                     // copio i dati del fabbricato relativi alle temperature
                     if Pareti then FSoloMuri.Copia_Info_Fabbricato(dm1.tt1);

                end;


                if dm1.TT1.State in [dsEdit, dsInsert] then
                   dm1.TT1.Post;

                // ho controllato il codice che non è presente in archivio
                // setto la varizbile nuovo_e a false per impedire un ulteriore controllo
                Nuovo_E := False;

                Aggiorna_Grafico;

                if Pareti then
                   begin
                        if DBComboBox11.Text = 'TRASPARENTE' then
                           begin
                                ListBox1.ItemIndex := ListBox1.Items.IndexOf('Vetro');
                                AttivaFiltro;
                                DisegnaMateriale(Image1);
                                FindAddress(Sez_003);
                           end
                        else
                           FindAddress(Sez_004);

                        AttivaTab(TabSheet3);
                   end
                else
                   begin
                        GroupBox9.Caption := DBComboBox11.Text;


                        if DBComboBox11.Text = 'Porta' then
                           begin
                                GroupBox9.Caption := DBComboBox11.Text + ' parte trasparente';
                                dm1.TT1.Edit;
                                // Azzero le informazioni relative alla sezione Cassonetto
                                GroupBox12.Visible := False;
                                DbEdit19.Field.AsString := '';
                                DbComboBox4.DataField := '';
                                // Azzero le informazioni relative alla sezione Sopraluce
                                GroupBox10.Visible := False;
                                DbEdit15.Field.AsString := '';

                                GroupBox13.Caption := DBComboBox11.Text + ' parte opaca';

                                dm1.TT1.Post;
                                FindAddress(SEZ_005);

                           end
                        else
                           begin
                               GroupBox12.Visible := False;
                               GroupBox10.Visible := True;
                               FindAddress(SEZ_006);
                           end;

                        if RadioGroup1.ItemIndex = 0 then
                           begin
                                AttivaTab(TabSheet4);
                                if GroupBox12.Visible then
                                   DbEdit19.SetFocus
                                else
                                   DbEdit13.SetFocus;
                           end
                        else
                           begin
                                FindAddress(SEZ_007);
                                AttivaTab(TabSheetTermiche);
                                DbEdit30.SetFocus;
                           end;
                   end;
           end;
       1 : begin
                if ParetI then
                   begin
                        // Emanuela 21/10/2004 patch: creazione dell'immagine igro
                        if Pareti then
                        begin
                           ForceDirectories(Percorso_progetti + 'Immagini_igro\');
                           Image2.Picture.SaveToFile(Percorso_progetti + 'Immagini_igro\' + DbEdit36.Text + '_igro.bmp');
                        end;

                        // Dettaglio della parete selezionata
                        // forzo la creazione del grafico della parete
                        Aggiorna_Grafico;
                        AttivaTab(TabSheetPareteDettagli);
                        FindAddress(Sez_008);
                   end
                else
                   begin    // Geometriche
                    {   if DBComboBox11.Text = 'Porta' then
                          begin
                               Val(DBEdit38.Text, Valore, Code);
                               if Label92.Enabled and ((Code <> 0) or (Valore < 1)) then
                               begin
                                MessageDlg(Msg_17, mtWarning, [mbOK], 0);
                                DBEdit38.SetFocus;
                                Exit
                               end;

                               Val(DBEdit39.Text, Valore, Code);
                               if (Code <> 0) or (Valore < 0) then
                               begin
                                MessageDlg(Msg_18, mtWarning, [mbOK], 0);
                                DBEdit39.SetFocus;
                                Exit
                               end;


                               Val(DBEdit40.Text, Valore, Code);
                               if (Code <> 0) or (Valore < 1) then
                               begin
                                MessageDlg(Msg_15, mtWarning, [mbOK], 0);
                                DBEdit40.SetFocus;
                                Exit
                               end;
                               Val(DBEdit41.Text, Valore, Code);
                               if (Code <> 0) or (Valore < 0) then
                               begin
                                MessageDlg(Msg_16, mtWarning, [mbOK], 0);
                                DBEdit41.SetFocus;
                                Exit
                               end;
                          end;      }

                       Aggiorna_Grafico;
                       AttivaTab(TabSheetTermiche);
                       FindAddress(Sez_009);
                   end;
           end;
       2 : begin
                 if Pareti then
                    begin
                         //TabSheetPareteDettagli
                         dm1.TT3.Edit;
                         dm1.TT3.POst;

                         Chiudi_Finestra;
                    end
                 else
                    begin
                         // Termiche
                         // Controllo che i valori siano definiti solo se
                         // la finestra ha un numero di ante <> 0
                         if DBEdit16.Field.AsString <> '' then
                         begin
                              if DBComboBox5.ItemIndex = - 1 then
                              begin
                                MessageDlg(MSG_004023021, mtWarning, [mbOK], 0);
                                DBComboBox5.SetFocus;
                                Exit
                              end;

                              if DBComboBox8.ItemIndex = - 1 then
                              begin
                                MessageDlg(MSG_004023022, mtWarning, [mbOK], 0);
                                DBComboBox8.SetFocus;
                                Exit
                              end;

                              Val(DBEdit28.Text, Valore, Code);
                              if (Code <> 0) or (Valore < 0) then
                              begin
                                MessageDlg(MSG_004023023, mtWarning, [mbOK], 0);
                                DBEdit28.SetFocus;
                                Exit
                              end;

                              Val(DBEdit29.Text, Valore, Code);
                              if (Code <> 0) or (Valore < 0) then
                              begin
                                MessageDlg(MSG_004023024, mtWarning, [mbOK], 0);
                                DBEdit29.SetFocus;
                                Exit
                              end;
                         end;

                         Aggiorna_Grafico;
                         AttivaTab(TabSheetElementiDisponibili);
                         FindAddress(Sez_010);
                    end
           end;

       3 : begin //Elementi  disponibili
                Chiudi_Finestra;
           end;
     end;  // end Case
end;

procedure TWizardFSoloMuri.Nuovo_Elemento;
Var
   Ultcol:string;
begin
  if Pareti then
  begin
     dbComboBox13.OnChange := nil;
     dbEdit55.OnChange := nil;

  end
  else
  begin
    dbEdit42.OnChange := nil;
    DBComboBox5.OnChange := nil;
  end;
     ultcol:='';
     dm1.TT1.last;
     if dm1.TT1.RecordCount<>0 then uLtcol:=V_TabStruttura.colCad;
     dm1.TT1.Append;
     dm1.TT1.Edit;


     if ultcol='Rosso' then V_TabStruttura.set_colCad('Giallo');
     if ultcol='Giallo' then V_TabStruttura.set_colCad('Verde');
     if ultcol='Verde' then V_TabStruttura.set_colCad('Ciano');
     if ultcol='Ciano' then V_TabStruttura.set_colCad('Blu');
     if ultcol='Blu' then V_TabStruttura.set_colCad('Magenta');

     if Pareti then
     begin
       CaricaDatiTemperaturediProgetto;
     end;
     if Pareti then
     begin
       dbComboBox13.OnChange := DBComboBox13change;
       dbEdit55.OnChange := DBEdit55change;
     end
     else
     begin
       dbEdit42.OnChange := DBEdit42change;
       DBComboBox5.OnChange :=  DBComboBox5change;
     end;
end;

procedure TWizardFSoloMuri.CaricaDatiTemperaturediProgetto;
var
  TableF : TTable;
begin
   //Emanuela 26/8/2004: copio i dati del fabbricato relativi alle temperature
   WizardFSoloMuri.DBComboBox13.OnChange := nil;
   TableF := TTable.Create(Nil);
   TableF.DatabaseName := Percorso_progetti;
   TableF.TableName := 'Fabbricato.db';
   TableF.Open;

   V_TabStruttura.Set_Ti(TableF.FieldByName('I Temperatura interna').AsFloat);
   V_TabStruttura.Set_URi(TableF.FieldByName('I UR interna').AsFloat);
   V_TabStruttura.Set_EsTi(TableF.FieldByName('Temperatura estiva').AsFloat);
   V_TabStruttura.Set_EsURi(TableF.FieldByName('UR estiva').AsFloat);

   if CompareStr(DBComboBox13.text, 'INTERNA') = 0 then
   begin
     V_TabStruttura.Set_Te(TableF.FieldByName('I Temperatura interna').AsFloat);
     V_TabStruttura.Set_URe(TableF.FieldByName('I UR interna').AsFloat);
     V_TabStruttura.Set_EsTe(TableF.FieldByName('Temperatura estiva').AsFloat);
     V_TabStruttura.Set_EsURe(TableF.FieldByName('UR estiva').AsFloat);
   end
   else
   begin
     V_TabStruttura.Set_Te(TableF.FieldByName('Temperatura inv. esterna').AsFloat);
     V_TabStruttura.Set_URe(TableF.FieldByName('Um. rel. Esterna').AsFloat);
     V_TabStruttura.Set_EsTe(TableF.FieldByName('Temp. Estiva Est.BS').AsFloat);
     V_TabStruttura.Set_EsURe(TableF.FieldByName('Um. Estiva Est.BS').AsFloat);
   end;
   //dm1.TT1.Post;
   dm1.TT1.Edit;

   TableF.Close;
   FreeandNil(TableF);
   WizardFSoloMuri.DBComboBox13.OnChange := WizardFSoloMuri.DBComboBox13Change;
end;

procedure TWizardFSoloMuri.FormShow(Sender: TObject);
Var
   Ultcol:string;
   A : TDataSource;
begin
     //
     if Pareti then
     begin
        DBEdit55.OnChange := nil;
        dbComboBox13.OnChange := nil;
     end
     else
     begin
       DBEdit28.OnChange := nil;
       DBEdit29.OnChange := nil;
       DBEdit42.OnChange := nil;
     end;

     new(D_setti);

     if Pareti then
        begin
             WizardFSoloMuri.Tabfinestre.Pages[2].Destroy;
             WizardFSoloMuri.Tabfinestre.Pages[2].Destroy;
             WizardFSoloMuri.Tabfinestre.Pages[2].Destroy;
             WizardFSoloMuri.Label83.Caption := WizardFSoloMuri.Label83.Caption + 'di una parete';
             WizardFSoloMuri.Label84.Caption := WizardFSoloMuri.Label84.Caption + 'di una parete';
             FindAddress(Sez_001);
        end
     else
        begin
             WizardFSoloMuri.Tabfinestre.Pages[5].Destroy;
             WizardFSoloMuri.Tabfinestre.Pages[1].Destroy;
             WizardFSoloMuri.Label83.Caption := WizardFSoloMuri.Label83.Caption + 'di una porta o di una finestra';
             WizardFSoloMuri.Label84.Caption := WizardFSoloMuri.Label84.Caption + 'di una porta o di una finestra';
             FindAddress(Sez_002);
        end;

     TreeView1.Items.Clear;
     For i := 0 to TabFinestre.PageCount - 1 do
        TreeView1.Items.Add(Nil, TabFinestre.Pages[i].Caption);

     Bar.Position := 0;
     Bar.Max := TreeView1.Items.Count;

     AttivaTab(TabSheetDefinizione);

     RadioGroup1.Visible := not Pareti;
     GroupBox5.Visible := Pareti;

     if not Pareti then
        if Nuovo_E then
        begin
           RadioGroup1.ItemIndex := 0;
           Nuovo_Elemento;
        end
        else
        begin
          // Emanuela 14/7/2004 effettuata la modifica per evitare che il campo dbedit16 sia vuoto
          A := dm1.TT1.MasterSource;
          dm1.TT1.MasterSource := Nil;
          dm1.TT1.Locate('NUMERO', codice, []);
          dm1.TT1.MasterSource := A;

          if (DBEdit16.Field.AsString <> '') or (UpperCase(dm1.TT1.FieldByName('FinPor').AsString) = UpperCase('Porta')) then
             RadioGroup1.ItemIndex := 0
          else
             RadioGroup1.ItemIndex := 1;
          CaricaHI_HE(DBComboBox5.Text);
        end
     else // caso parete
        if Nuovo_E then
           Nuovo_Elemento
        else
           Begin
                A := dm1.TT1.MasterSource;
                dm1.TT1.MasterSource := Nil;
                dm1.TT1.Locate('NUMERO', codice, []);
                dm1.TT1.MasterSource := A;
                DBEdit61.Visible := DBComboBox11.Text = 'TRASPARENTE';
                Label138.Visible := DBComboBox11.Text = 'TRASPARENTE';
                LB_TipoDiv.Visible := (DBComboBox13.Text = 'INTERNA') and (DBComboBox11.Text <> 'TRASPARENTE');
                DbCombo_TipoDiv.Visible := (DBComboBox13.Text = 'INTERNA') and (DBComboBox11.Text <> 'TRASPARENTE');
                if DbCombo_TipoDiv.Visible then
                begin
                  LB_TipoDiv.Left := 9;
                  LB_TipoDiv.Top  := 108;
                  DbCombo_TipoDiv.Left := 154;
                  DbCombo_TipoDiv.Top  := 104;
                end;
                Aggiorna_Adduttanza;
           end;

     DBEdit36.SetFocus;
     if pareti then
     begin
        DBEdit55.OnChange := DBEdit55Change;
        dbComboBox13.OnChange := DBComboBox13change;
     end
     else
     begin
       DBEdit28.OnChange := DBEdit28Change;
       DBEdit29.OnChange := DBEdit29Change;
       DBEdit42.OnChange := DBEdit42Change;
     end;
end;

procedure TWizardFSoloMuri.FormCreate(Sender: TObject);
begin
     DecimalSeparator := '.';
     Application.UpdateFormatSettings := False;
     Nuovo_E := False;
     Codice := '';
     //TabSheet8.TabVisible := False;
     PageControl4.ActivePageIndex := 0;
end;

procedure TWizardFSoloMuri.DBEdit15KeyPress(Sender: TObject;
  var Key: Char);
begin
     if Key = #13 then
        begin
             Case (Sender as TDBEdit).tag of
                5 : DBedit13.SetFocus;
                7 : DBComboBox4.SetFocus;
                2 : DbEdit14.SetFocus;
                1 : DbEdit16.SetFocus;
                4 : DbEdit18.SetFocus;
                3 : DbEdit20.SetFocus;
                9 : begin
                         DBComboBox6.SetFocus;
                    end;
             end;

             Aggiorna_Grafico;
        end;
end;

procedure TWizardFSoloMuri.DBComboBox3KeyPress(Sender: TObject;
  var Key: Char);
begin
     if Key = #13 then
        begin
          Case (Sender as TDbComboBox).Tag of
            6 : DbEdit13.SetFocus;
            8 : DbEdit15.SetFocus;
//            10 : DBComboBox7.SetFocus;
          end;
          Aggiorna_Grafico
        end;
end;

procedure TWizardFSoloMuri.DBEdit36KeyPress(Sender: TObject;
  var Key: Char);
begin
     if Key = #13 then
        DBEdit37.SetFocus;
end;

procedure TWizardFSoloMuri.ButtonCancelClick(Sender: TObject);
begin
  // vedere come eliminare un inserimento che non è congruente
  if Nuovo_E then
   if CompareStr(UpperCase(ButtonCancel.Caption), UpperCase('&Calcella')) = 0 then
   begin
     if Pareti then
     begin
      DBEdit55.OnChange := nil;
      DBComboBox13.OnChange := nil;
     end;
     dm1.tt1.delete;
     if Pareti then
     begin
      DBEdit55.OnChange := DBEdit55Change;
      DBComboBox13.OnChange := DBComboBox13Change;
     end;
   end;
  if not Pareti then
  begin
   DBEdit28.OnChange := nil;
   DBEdit42.OnChange := nil;
  end;
  CancellaRigheDBVuote(dm1.TT1);
  if not Pareti then
  begin
    DBEdit28.OnChange := DBEdit28Change;
    DBEdit42.OnChange := DBEdit42Change;
  end;  
  Close
end;

procedure TWizardFSoloMuri.DBGrid2DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept := Source is TDBGrid;
end;

procedure TWizardFSoloMuri.DBGrid2DragDrop(Sender, Source: TObject; X, Y: Integer);
Var
    Valore : Array of Variant;
    i : Integer;
begin
     Case (Source as TDbGrid).Tag of
       1 : begin
           SetLength(Valore, 11);
           // RECUPERO GLI ELEMENTI DELLA RIGA SELEZIONATA
           Valore[1] := (Source as TDbGrid).DataSource.DataSet.FieldByName('DESCRIZIONE').AsString;
           Valore[2] := (Source as TDbGrid).DataSource.DataSet.FieldByName('INDICE').AsString;    // AS STRING
           Valore[3] := (Source as TDbGrid).DataSource.DataSet.FieldByName('DISEGNO').AsString;
           Valore[4] := (Source as TDbGrid).DataSource.DataSet.FieldByName('SPESSORE').AsFloat;
           Valore[5] := (Source as TDbGrid).DataSource.DataSet.FieldByName('LAMBDA').AsFloat;
           Valore[6] := (Source as TDbGrid).DataSource.DataSet.FieldByName('Peso specifico').AsFloat;
           Valore[7] := (Source as TDbGrid).DataSource.DataSet.FieldByName('Permeabilità').AsFloat;
           Valore[8] := (Source as TDbGrid).DataSource.DataSet.FieldByName('Cap.Term.').AsFloat;
           Valore[9] := (Source as TDbGrid).DataSource.DataSet.FieldByName('Condutt.').AsFloat;
           Valore[10] := (Source as TDbGrid).DataSource.DataSet.FieldByName('FormaBMP').AsString;

           dm1.TT3.Append;
           dm1.TT3.Edit;
           V_Recstrati.set_descrizione(Valore[1]);
           V_Recstrati.set_NFile(Valore[2]);
           V_Recstrati.set_Disegno(Valore[3]);
           V_Recstrati.set_Spessore(Valore[4]);
           V_Recstrati.set_ConduttivitaLineare(Valore[5]);
           V_Recstrati.set_PesoSpecifico(Valore[6]);
           V_Recstrati.set_mu(Valore[7]);
           V_Recstrati.set_CaloreSpecifico(Valore[8]);
           V_Recstrati.set_Conduttanza(Valore[9]);
           V_Recstrati.set_Stretch(Valore[10]);

           dm1.TT3.POst;
           disegnagrafico(WizardFSoloMuri.Image2, image2.Width,image2.Height,false,1,table6,dm1.tt3);
           end;
       2 : begin
           end;

     end;

     DbGrid1.DragMode := dmManual
end;

procedure TWizardFSoloMuri.MoveUp1Click(Sender: TObject);
begin
     Muovi_Elemento(-1, DbGrid2);
end;

procedure TWizardFSoloMuri.MoveDown1Click(Sender: TObject);
begin
     Muovi_Elemento(1, DbGrid2);
end;


{-----------------------------------------------------------------------------
  Procedura: TWizardFSoloMuri.Muovi_Elemento
  Autore:    Piero
  Data Creazione:      03-feb-2004
  Argomenti: Direzione : Integer; DbGrid2 : TDBGrid
  Valore Restituito:    None
  Descrizione : Questa procedura è un modo non elegante ma sbrigativo per muovere le riga di una tabella
                Il primo parametro indica il movimento da compiere
                   se = - 1 sposto la riga selezionata verso l'alto
                   se =   1 sposto la riga selezionata verso il basso
-----------------------------------------------------------------------------}
procedure TWizardFSoloMuri.Muovi_Elemento(Direzione : Integer; DbGrid2 : TDBGrid);
Var
   i, j, Indice : Integer;
   Lista : TStringList;
   Testo, AusString : String;
begin
     Indice := Dbgrid2.DataSource.DataSet.RecNo;

     Case Direzione of
       - 1 : if Indice = 1 then
                Exit;
         1 : If Indice = DbGrid2.DataSource.DataSet.RecordCount then
                Exit;
       end;

     Lista := TStringList.Create;

     Dbgrid2.DataSource.DataSet.DisableControls;
     Dbgrid2.DataSource.DataSet.First;

     while not DbGrid2.DataSource.DataSet.Eof do
        begin
             Testo := '';
             for i := 1 to DbGrid2.DataSource.DataSet.FieldCount - 2 do
                Testo := Testo + DbGrid2.DataSource.DataSet.Fields[i].AsString + '§';


             Testo := Testo + DbGrid2.DataSource.DataSet.Fields[DbGrid2.DataSource.DataSet.FieldCount - 1].AsString;

             Lista.Add(Testo);

             DbGrid2.DataSource.DataSet.Next
        end;

     // Decremento L'indice per riadeguarlo alla lista
     Indice := Indice - 1;
     Lista.Move(Indice, Indice + Direzione);

     Dbgrid2.DataSource.DataSet.First;

     while not DbGrid2.DataSource.DataSet.Eof do
        Dbgrid2.DataSource.DataSet.Delete;

     for i := 0 to Lista.Count - 1 do
        begin
             Testo := Lista[i];
             J := 1;
             DbGrid2.DataSource.DataSet.Insert;

             Indice := Pos('§', Testo);
             While Indice > 0 do
                begin
                     AusString := Copy(Testo, 1, Indice - 1);
                     DbGrid2.DataSource.DataSet.Fields[j].AsString := AusString;
                     Inc(J);

                     Delete(Testo, 1, Indice);
                     Indice := Pos('§', Testo);
                end;

             DbGrid2.DataSource.DataSet.Fields[j].AsString := Testo;
             DbGrid2.DataSource.DataSet.Post;
        end;

     Lista.Free;
     Dbgrid2.DataSource.DataSet.EnableControls;
     disegnagrafico(WizardFSoloMuri.Image2, image2.Width,image2.Height,false,1,table6,dm1.tt3);
end;


procedure TWizardFSoloMuri.SpeedButton1Click(Sender: TObject);
begin
     MessageDlg('Tasto destro del mouse per spostare la riga selezionata' + #13 + #13 +
                'Doppio click per posizionarsi sull''archivio materiali corrispondente alla riga selezionata', mtInformation, [mbOK], 0);
end;

procedure TWizardFSoloMuri.DBGrid2DblClick(Sender: TObject);
begin
     Table2.Filtered := False;
     Table2.Locate('descrizione', DbGrid2.DataSource.DataSet['descrizione'], []);
     ListBox1.ItemIndex := ListBox1.Items.IndexOf(Table2['categoria']);
     ListBox1.OnClick(Application);
end;

procedure TWizardFSoloMuri.Timer1Timer(Sender: TObject);
begin
     Timer1.Enabled := False;
     DBGrid1.DragMode := dmManual;
end;

procedure TWizardFSoloMuri.Edit21KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Edit21.Text = '' then Exit;

     Table2.Filtered := False;

     if Table2.Locate('descrizione', Edit21.Text, [loCaseInsensitive, loPartialKey]) then
     begin
          ListBox1.ItemIndex := ListBox1.Items.IndexOf(Table2['categoria']);
          ListBox1.OnClick(Application);
     end;
end;

procedure TWizardFSoloMuri.DBGrid2KeyPress(Sender: TObject; var Key: Char);
begin
     if Key = #13 then
        Button14Click(Sender);

end;

procedure TWizardFSoloMuri.CopiaElemento1Click(Sender: TObject);
Var
   i, j, Indice : Integer;
   Testo, AusString : String;
begin
     Testo := '';
     for i := 1 to DbGrid2.DataSource.DataSet.FieldCount - 2 do
        Testo := Testo + DbGrid2.DataSource.DataSet.Fields[i].AsString + '§';

     Testo := Testo + DbGrid2.DataSource.DataSet.Fields[DbGrid2.DataSource.DataSet.FieldCount - 1].AsString;

     J := 1;
     DbGrid2.DataSource.DataSet.Insert;

     Indice := Pos('§', Testo);
     While Indice > 0 do
        begin
             AusString := Copy(Testo, 1, Indice - 1);
             DbGrid2.DataSource.DataSet.Fields[j].AsString := AusString;
             Inc(J);

             Delete(Testo, 1, Indice);
             Indice := Pos('§', Testo);
        end;

     DbGrid2.DataSource.DataSet.Fields[j].AsString := Testo;
     DbGrid2.DataSource.DataSet.Post;

     disegnagrafico(WizardFSoloMuri.Image2, image2.Width,image2.Height,false,1,table6,dm1.tt3);
end;

procedure TWizardFSoloMuri.DBEdit7KeyPress(Sender: TObject; var Key: Char);
var
  Valore : Double;
  Code : Integer;
begin
  if pareti then
  begin
     if Key = #13 then
        begin
              Case (Sender as TDBedit).Tag of
                 1 : DbEdit8.SetFocus;
                 2 : DbEdit9.SetFocus;
                 3 : DbEdit10.SetFocus;
                 4 : DbEdit11.SetFocus;
                 5 : DbEdit12.SetFocus;
                 // Emanuela patch del 21/10/04: inserimento dei focus per
                 // gli altri edit della temperatura
                 6 : DbEdit62.SetFocus;
                 7 : DbEdit63.SetFocus;
                 8 : DbEdit64.SetFocus;
                 9 : DbEdit65.SetFocus;
              end;
        end;

      // Emanuela patch del 21/10/04: verifica se il valore inserito è un floating point
        Val(dbEdit9.Text, Valore, Code);
        if Code <> 0 then
        begin
          DBEdit9.SetFocus;
          Exit
        end;

        Val(dbEdit10.Text, Valore, Code);
        if Code <> 0 then
        begin
          DBEdit10.SetFocus;
          Exit
        end;

        Val(dbEdit11.Text, Valore, Code);
        if Code <> 0 then
        begin
          DBEdit11.SetFocus;
          Exit
        end;

        Val(dbEdit12.Text, Valore, Code);
        if Code <> 0 then
        begin
          DBEdit12.SetFocus;
          Exit
        end;

        Val(dbEdit62.Text, Valore, Code);
        if Code <> 0 then
        begin
          DBEdit62.SetFocus;
          Exit
        end;

        Val(dbEdit63.Text, Valore, Code);
        if Code <> 0 then
        begin
          DBEdit63.SetFocus;
          Exit
        end;

        Val(dbEdit64.Text, Valore, Code);
        if Code <> 0 then
        begin
          DBEdit64.SetFocus;
          Exit
        end;

        Val(dbEdit65.Text, Valore, Code);
        if Code <> 0 then
        begin
          DBEdit65.SetFocus;
          Exit
        end;
   end;
      // Emanuela 15/9/2004 inserita una forzatura dell memorizzazione dei dati modificati
      if dm1.TT1.State in [dsEdit, dsInsert] then
         dm1.TT1.Post;
end;

procedure TWizardFSoloMuri.DBEdit37KeyPress(Sender: TObject;
  var Key: Char);
begin
     if Key = #13 then
        BtnAvantiClick(Sender);
end;

procedure TWizardFSoloMuri.SpeedButton2Click(Sender: TObject);
begin
     FormCoefficienti := TFormCoefficienti.create(nil);
     FormCoefficienti.DBGrid1.Visible := True;
     FormCoefficienti.Width := 350;
     FormCoefficienti.Height := 250;
     FormCoefficienti.Caption := 'Coefficienti globali di trasmittanza termica di telai';

     FormCoefficienti.Table1.Close;

     FormCoefficienti.Table1.close;
     FormCoefficienti.Table1.Databasename := Percorso_Archivi;
     if DBComboBox11.Text = 'Porta' then
        FormCoefficienti.Table1.tablename := 'KTelInf.db'
     else
        FormCoefficienti.Table1.tablename := 'ktelaioinfisso.db';

     FormCoefficienti.Table1.Open;

     FormCoefficienti.DBGrid1.Columns.Clear;
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[0].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[0].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[0].Field := FormCoefficienti.Table1.Fields[0];
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[1].Field := FormCoefficienti.Table1.Fields[1];
     FormCoefficienti.DBGrid1.Columns[1].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[1].Title.Alignment  := taCenter;


     FormCoefficienti.ShowModal;
     dm1.TT1.Edit;
     DbEdit28.Field.AsString := FormCoefficienti.Table1.FindField('Valore').AsString;
     if dm1.TT1.State = dsEdit then
        dm1.TT1.Post;
end;

procedure TWizardFSoloMuri.SpeedButton3Click(Sender: TObject);
begin
     FormDispersioni := TFormDispersioni.create(nil);
     FormDispersioni.DBGrid1.Visible := True;

     FormDispersioni.Table1.close;
     FormDispersioni.Table1.Databasename := Percorso_Archivi;
     FormDispersioni.Table1.tablename := 'ktermlininf.db';
     FormDispersioni.Table1.Open;

     FormDispersioni.DBGrid1.Columns.Clear;
     FormDispersioni.DBGrid1.Columns.Add;
     FormDispersioni.DBGrid1.Columns[0].Title.Font.Color := clHotLight;
     FormDispersioni.DBGrid1.Columns[0].Title.Alignment  := taCenter;
     FormDispersioni.DBGrid1.Columns[0].Field := FormDispersioni.Table1.Fields[0];
     FormDispersioni.DBGrid1.Columns[0].Width := 320;
     FormDispersioni.DBGrid1.Columns.Add;
     FormDispersioni.DBGrid1.Columns[1].Field := FormDispersioni.Table1.Fields[1];
     FormDispersioni.DBGrid1.Columns[1].Title.Font.Color := clHotLight;
     FormDispersioni.DBGrid1.Columns[1].Title.Alignment  := taCenter;

     FormDispersioni.ShowModal;
     dm1.TT1.Edit;
     DbEdit29.Field.AsString := FormDispersioni.Table1.FindField('Valore').AsString;
     if dm1.TT1.State = dsEdit then
        dm1.TT1.Post;
end;

procedure TWizardFSoloMuri.SpeedButton4Click(Sender: TObject);
begin
     FormCoefficienti := TFormCoefficienti.create(nil);
     FormCoefficienti.DBGrid1.Visible := True;
     FormCoefficienti.Width := 470;
     FormCoefficienti.Height := 250;
     FormCoefficienti.Caption := 'Valori della resistenza termica aggiuntiva per finestre dotate di tapparelle abbassate';

     FormCoefficienti.Table1.Close;

     FormCoefficienti.Table1.close;
     FormCoefficienti.Table1.Databasename := Percorso_Archivi;
     FormCoefficienti.Table1.tablename := 'restermtapp.db';
     FormCoefficienti.Table1.Open;

     FormCoefficienti.DBGrid1.Columns.Clear;
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[0].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[0].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[0].Field := FormCoefficienti.Table1.Fields[0];
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[1].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[1].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[1].Field := FormCoefficienti.Table1.Fields[1];

     FormCoefficienti.ShowModal;
     dm1.TT1.Edit;
     DbEdit43.Field.AsString := FormCoefficienti.Table1.FindField('Valore').AsString;
     dm1.TT1.Post;
end;

procedure TWizardFSoloMuri.SpeedButton5Click(Sender: TObject);
begin
     FormCoefficienti := TFormCoefficienti.create(nil);
     FormCoefficienti.DBGrid1.Visible := True;
     FormCoefficienti.Width := 470;
     FormCoefficienti.Height := 250;
     FormCoefficienti.Caption := 'Valori del coefficiente m per serramenti di finestre e porte';

     FormCoefficienti.Table1.Close;

     FormCoefficienti.Table1.close;
     FormCoefficienti.Table1.Databasename := Percorso_Archivi;
     FormCoefficienti.Table1.tablename := 'Coeff_m_FinPorte_10344.db';
     FormCoefficienti.Table1.Open;

     FormCoefficienti.DBGrid1.Columns.Clear;
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[0].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[0].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[0].Field := FormCoefficienti.Table1.Fields[0];
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[1].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[1].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[1].Field := FormCoefficienti.Table1.Fields[1];

     FormCoefficienti.ShowModal;
     dm1.TT1.Edit;
     DbEdit44.Field.AsString := FormCoefficienti.Table1.FindField('Valore').AsString;
     dm1.TT1.Post;
end;

procedure TWizardFSoloMuri.SpeedButton6Click(Sender: TObject);
begin
     FormCoefficienti := FormCoefficienti.create(nil);
     FormCoefficienti.DBGrid1.Visible := True;
     FormCoefficienti.Width := 470;
     FormCoefficienti.Height := 250;
     FormCoefficienti.Caption := 'Valori del voefficiente V per cassonetti';

     FormCoefficienti.Table1.Close;

     FormCoefficienti.Table1.close;
     FormCoefficienti.Table1.Databasename := Percorso_Archivi;
     FormCoefficienti.Table1.tablename := 'Coeff_v_Cassonetti_10344.db';
     FormCoefficienti.Table1.Open;

     FormCoefficienti.DBGrid1.Columns.Clear;
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[0].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[0].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[0].Field := FormCoefficienti.Table1.Fields[0];
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[1].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[1].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[1].Field := FormCoefficienti.Table1.Fields[1];

     FormCoefficienti.ShowModal;
     dm1.TT1.Edit;
     DbEdit45.Field.AsString := FormCoefficienti.Table1.FindField('Valore').AsString;
     dm1.TT1.Post;
end;

procedure TWizardFSoloMuri.DBEdit28Change(Sender: TObject);
begin
     if not Nuovo_E then CalcolaFinestra
end;

procedure TWizardFSoloMuri.DBEdit29Change(Sender: TObject);
begin
     if not Nuovo_E then CalcolaFinestra
end;

procedure TWizardFSoloMuri.SpeedButton7Click(Sender: TObject);
begin
     FormCoefficienti := TFormCoefficienti.create(nil);
     FormCoefficienti.DBGrid1.Visible := True;
     FormCoefficienti.Width := 400;
     FormCoefficienti.Height := 250;
     FormCoefficienti.Caption := 'Fattore di schermatura dovuto a schermi';

     FormCoefficienti.Table1.Close;

     FormCoefficienti.Table1.close;
     FormCoefficienti.Table1.Databasename := Percorso_Archivi;
     FormCoefficienti.Table1.tablename := 'Coeff_Schermi_10344.db';
     FormCoefficienti.Table1.Open;

     FormCoefficienti.DBGrid1.Columns.Clear;
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[0].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[0].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[0].Field := FormCoefficienti.Table1.Fields[0];
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[1].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[1].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[1].Field := FormCoefficienti.Table1.Fields[1];

     FormCoefficienti.ShowModal;
     dm1.TT1.Edit;
     DbEdit47.Field.AsString := FormCoefficienti.Table1.FindField('Valore').AsString;
     dm1.TT1.Post;
end;

procedure TWizardFSoloMuri.SpeedButton8Click(Sender: TObject);
begin
     FormCoefficienti := TFormCoefficienti.create(nil);
     FormCoefficienti.DBGrid1.Visible := True;
     FormCoefficienti.Width := 470;
     FormCoefficienti.Height := 250;
     FormCoefficienti.Caption := 'Coefficiente di trasmissione solare g di alcuni tipi di vetro';

     FormCoefficienti.Table1.Close;

     FormCoefficienti.Table1.close;
     FormCoefficienti.Table1.Databasename := Percorso_Archivi;
     FormCoefficienti.Table1.tablename := 'Coeff_g_SolVetro_10344.db';
     FormCoefficienti.Table1.Open;

     FormCoefficienti.DBGrid1.Columns.Clear;
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[0].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[0].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[0].Field := FormCoefficienti.Table1.Fields[0];
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[1].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[1].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[1].Field := FormCoefficienti.Table1.Fields[1];

     FormCoefficienti.ShowModal;
     dm1.TT1.Edit;
     DbEdit17.Field.AsString := FormCoefficienti.Table1.FindField('Valore').AsString;
     dm1.TT1.Post;
end;

function  TWizardFSoloMuri.Determina_Incremento (Valore : TDBEdit) : Double;
begin
     Result := 0;

     Case Valore.Tag of
        25, 26, 43, 45 : Result := 0.01;
        17, 44, 47, 48, 49, 50, 51, 52, 53, 54 : Result := 0.1;
        13, 42 : Result := 10;
        15 : Result := 1;
     end;
end;


procedure TWizardFSoloMuri.Aggiorna_Campo(Campo : TDBEdit; Incremento : Double);
Var
   Valore : Double;
begin
     Valore := Campo.Field.AsFloat;
     Valore := Valore + Incremento;
     if SameValue(Valore, 0, 0.001) or (Valore < 0) then
        Valore := 0;

     Campo.DataSource.DataSet.Edit;
     Campo.Field.AsFloat := Valore;
     if Campo.DataSource.DataSet.State = dsEdit then
        Campo.DataSource.DataSet.Post;
end;

procedure TWizardFSoloMuri.RxSpinButton1DownClick(Sender: TObject);
Var
   Valore : TDBEdit;
begin
     Valore := TDBEdit((Sender as TSpinButton).FocusControl);
     Aggiorna_Campo(Valore, - Determina_Incremento(Valore));
end;

procedure TWizardFSoloMuri.RxSpinButton1UpClick(Sender: TObject);
Var
   Valore : TDBEdit;
begin
     Valore := TDBEdit((Sender as TSpinButton).FocusControl);
     Aggiorna_Campo(Valore, Determina_Incremento(Valore));
end;


procedure TWizardFSoloMuri.DBComboBox5Change(Sender: TObject);
begin
     CaricaCorrelato(dm1.tt1);
     CaricaHI_HE(DBComboBox5.Text);
     CalcolaFinestra;
     dm1.TT1.Edit;
     DBComboBox5.Field.DataSet.Edit;
     DBComboBox5.Field.Value := DBComboBox5.Text;
end;

procedure TWizardFSoloMuri.DBComboBox11Change(Sender: TObject);
begin
     DBEdit61.Visible := DBComboBox11.Text = 'TRASPARENTE';
     Label138.Visible := DBComboBox11.Text = 'TRASPARENTE';
     LB_TipoDiv.Visible := (DBComboBox13.Text = 'INTERNA') and (DBComboBox11.Text <> 'TRASPARENTE');
     DbCombo_TipoDiv.Visible := (DBComboBox13.Text = 'INTERNA') and (DBComboBox11.Text <> 'TRASPARENTE');

     if Pareti then
        Aggiorna_Adduttanza;
     DBComboBox11.Field.DataSet.Edit;
     DBComboBox11.Field.Value := DBComboBox11.Text;
end;


procedure TWizardFSoloMuri.DBComboBox6Change(Sender: TObject);
begin
     CaricaCorrelato(dm1.tt1);
     dm1.TT1.Edit;
     DBComboBox6.Field.DataSet.Edit;
     DBComboBox6.Field.Value := DBComboBox6.Text;
end;

procedure TWizardFSoloMuri.Aggiorna_Adduttanza;
var
   Hi, He : Double;
   Shi, She : String;
begin
     dm1.TT1.Edit;
     //dm1.TT1.Post;
     //dm1.TT1.Edit;
     if DBComboBox11.Text = 'TRASPARENTE' then
        begin
             SHi := Format('%.2f', [3.6 + 4.4 * V_TabStruttura.epson / 0.837]);
             Hi := StrToFloat(Shi);

             V_TabStruttura.Set_alfa(Hi);

             if DBComboBox13.ItemIndex = 0 then // esterna
                begin
                     V_TabStruttura.Set_beta(25);
                end
             else // interno
                begin
                     V_TabStruttura.Set_beta(Hi);
                end;
        end
     else // pareti opache
        begin
             if DBComboBox13.ItemIndex = 0 then // esterna
                begin
                     V_TabStruttura.Set_beta(25);
                     V_TabStruttura.Set_alfa(7.7);
                end
             else  // interne
                begin
                     V_TabStruttura.Set_alfa(7.7);
                     V_TabStruttura.Set_beta(7.7);
                end;
        end;

     Case DBComboBox3.ItemIndex of
       0 : // PARETE
           if DBComboBox13.ItemIndex = 0 then // esterna
              begin
                   V_TabStruttura.Set_HI(8.14);

                   if V_TabStruttura.wind <= 4 then
                      V_TabStruttura.Set_HE(23.25)
                   else
                      begin
                           She := Format('%.2f', [2.3 + 10.46 * Sqrt(V_TabStruttura.wind)]);
                           He := StrToFloat(She);
                           V_TabStruttura.Set_HE(He);
                      end;
              end
           else   // interna
              begin
                   V_TabStruttura.Set_HI(8.14);
                   V_TabStruttura.Set_HE(8.14);
              end;
       1 : // PAVIMENTO
           if DBComboBox13.ItemIndex = 0 then // esterna
              begin
                   V_TabStruttura.Set_HI(5.814);

                     if V_TabStruttura.wind <= 4 then
                        V_TabStruttura.Set_HE(16.27)
                     else
                        begin
                             She := Format('%.2f', [0.7 * (2.3 + 10.46 * Sqrt(V_TabStruttura.wind))]);
                             He := StrToFloat(She);
                             V_TabStruttura.Set_HE(He);
                        end
              end
           else   // interna
              begin
                   V_TabStruttura.Set_HI(5.814);
                   V_TabStruttura.Set_HE(5.814);
              end;
       2 : // SOFFITTO
           if DBComboBox13.ItemIndex = 0 then // esterna
              begin
                   V_TabStruttura.Set_HI(9.302);

                   if V_TabStruttura.wind <= 4 then
                      V_TabStruttura.Set_HE(23.25)
                   else
                      begin
                           She := Format('%.2f', [2.3 + 10.46 * Sqrt(V_TabStruttura.wind)]);
                           He := StrToFloat(She);
                           V_TabStruttura.Set_HE(He);
                      end
              end
           else   // interna
              begin
                   V_TabStruttura.Set_HI(9.302);
                   V_TabStruttura.Set_HE(9.302);
              end;
     end;

end;

procedure TWizardFSoloMuri.DBComboBox13Change(Sender: TObject);
begin
  LB_TipoDiv.Visible := (DBComboBox13.Text = 'INTERNA') and (DBComboBox11.Text <> 'TRASPARENTE');
  DbCombo_TipoDiv.Visible := (DBComboBox13.Text = 'INTERNA') and (DBComboBox11.Text <> 'TRASPARENTE');
  if DbCombo_TipoDiv.Visible then
  begin
    LB_TipoDiv.Left := 9;
    LB_TipoDiv.Top  := 108;
    DbCombo_TipoDiv.Left := 154;
    DbCombo_TipoDiv.Top  := 104;
  end;
  if Pareti then
  begin
     Aggiorna_Adduttanza;
     if Nuovo_E then CaricaDatiTemperaturediProgetto;
  end;
end;

procedure TWizardFSoloMuri.RadioGroup1Click(Sender: TObject);
begin
    LB_TipoDiv.Visible := (DBComboBox13.Text = 'INTERNA') and (DBComboBox11.Text <> 'TRASPARENTE');
    DbCombo_TipoDiv.Visible := (DBComboBox13.Text = 'INTERNA') and (DBComboBox11.Text <> 'TRASPARENTE');

     GroupBox17.Visible := RadioGroup1.ItemIndex = 1;
     if GroupBox17.Visible then
        begin
             BtnAvanti.Caption := 'Fine';
             FindAddress(SEZ_007);
        end
     else
        begin
             BtnAvanti.Caption := '&Avanti >';
             FindAddress(SEZ_007);

             if Pareti then
                FindAddress(Sez_001)
             else
                FindAddress(Sez_002);
        end;
end;

procedure TWizardFSoloMuri.DBEdit23KeyPress(Sender: TObject;
  var Key: Char);
begin
     if Key = #13 then DBEdit20.SetFocus;
end;

procedure TWizardFSoloMuri.ComboMeseChange(Sender: TObject);
begin
  Grafico(1);
end;

procedure TWizardFSoloMuri.FindAddress(Sezione : String);
Var
   Url : String;
begin
     Url := SezioneDaCaricare(Percorso_RisorseGenerale + 'Risorse\' + Path_Tutor, Sezione, GetTempFile);

     if FileExists(Url) then
        RichEdit1.Lines.LoadFromFile(Url)
     else
        RichEdit1.Clear;
end;


procedure TWizardFSoloMuri.DBEdit55Change(Sender: TObject);
begin
     Grafico(1);
end;

procedure TWizardFSoloMuri.SpeedButton9Click(Sender: TObject);
begin
     FormCoefficienti := TFormCoefficienti.create(nil);
     FormCoefficienti.DBGrid1.Visible := True;
     FormCoefficienti.Width := 470;
     FormCoefficienti.Height := 250;
     FormCoefficienti.Caption := 'Coefficiente di trasmissione solare g di alcuni tipi di vetro';

     FormCoefficienti.Table1.Close;

     FormCoefficienti.Table1.close;
     FormCoefficienti.Table1.Databasename := Percorso_Archivi;
     FormCoefficienti.Table1.tablename := 'prosp_XIV_10345.db';
     FormCoefficienti.Table1.Open;

     FormCoefficienti.DBGrid1.Columns.Clear;
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[0].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[0].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[0].Field := FormCoefficienti.Table1.Fields[0];
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[1].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[1].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[1].Field := FormCoefficienti.Table1.Fields[1];
     FormCoefficienti.DBGrid1.Columns.Add;
     FormCoefficienti.DBGrid1.Columns[2].Title.Font.Color := clHotLight;
     FormCoefficienti.DBGrid1.Columns[2].Title.Alignment  := taCenter;
     FormCoefficienti.DBGrid1.Columns[2].Field := FormCoefficienti.Table1.Fields[2];


     FormCoefficienti.ShowModal;
     dm1.TT1.Edit;
     DbEdit48.Field.AsString := FormCoefficienti.Table1.FindField('g').AsString;
     dm1.TT1.Post;

end;

procedure TWizardFSoloMuri.DBComboBox3Change(Sender: TObject);
begin
  Aggiorna_Adduttanza;
  DBComboBox3.Field.DataSet.Edit;
  DBComboBox3.Field.Value := DBComboBox3.Text;
end;

procedure TWizardFSoloMuri.DBComboBox14Change(Sender: TObject);
begin
  DBComboBox14.Field.DataSet.Edit;
  DBComboBox14.Field.Value := DBComboBox14.Text;
end;

procedure TWizardFSoloMuri.DBComboBox15Change(Sender: TObject);
begin
  DBComboBox15.Field.DataSet.Edit;
  DBComboBox15.Field.Value := DBComboBox15.Text;
end;

procedure TWizardFSoloMuri.DBComboBox16Change(Sender: TObject);
begin
  DBComboBox16.Field.DataSet.Edit;
  DBComboBox16.Field.Value := DBComboBox16.Text;
end;

procedure TWizardFSoloMuri.DBComboBox4Change(Sender: TObject);
begin
  DBComboBox4.Field.DataSet.Edit;
  DBComboBox4.Field.Value := DBComboBox4.Text;
end;

procedure TWizardFSoloMuri.DBComboBox7Change(Sender: TObject);
begin
  DBComboBox7.Field.DataSet.Edit;
  DBComboBox7.Field.Value := DBComboBox7.Text;
end;

procedure TWizardFSoloMuri.DBComboBox8Change(Sender: TObject);
begin
  DBComboBox8.Field.DataSet.Edit;
  DBComboBox8.Field.Value := DBComboBox8.Text;
end;

procedure TWizardFSoloMuri.DBEdit42Change(Sender: TObject);
begin
  CalcolaFinestra;
end;

procedure TWizardFSoloMuri.CaricaHI_HE(CodiceVetro: String);
var
  Tabella: TTable;
begin
  Tabella := TTable.Create(nil);
  Tabella.DatabaseName := Percorso_Progetti;
  Tabella.TableName := 'Strutture';
  Tabella.Open;
  Tabella.First;
  while (not Tabella.Eof) and (CompareStr(Tabella.FieldByName('Descrizione').AsString, CodiceVetro) <> 0) do
    Tabella.Next;
  dm1.tt1.Edit;
  dm1.tt1.FieldByName('Add. interna').Value := Tabella.FieldByName('Alfa').AsFloat;
  dm1.tt1.FieldByName('Add. esterna').Value := Tabella.FieldByName('Beta').AsFloat;
  dm1.tt1.Post;
  dm1.tt1.Edit;
  Tabella.Close;
  Tabella.Free;
end;

procedure TWizardFSoloMuri.DBEdit47Change(Sender: TObject);
begin
  DBEdit17.Field.DataSet.Edit;
  DBEdit17.Field.AsFloat := DBEdit47.Field.AsFloat + DBEdit48.Field.AsFloat;
end;

procedure TWizardFSoloMuri.DBEdit48Change(Sender: TObject);
begin
  DBEdit17.Field.DataSet.Edit;
  DBEdit17.Field.AsFloat := DBEdit47.Field.AsFloat + DBEdit48.Field.AsFloat;
end;

procedure TWizardFSoloMuri.LB_InfoVerClick(Sender: TObject);
begin
  if CompareStr(UpperCase(V_TabStruttura.interest), 'ESTERNA') = 0 then
    MessageDlg(MSG_004023001, mtInformation, [mbOK], 0)
  else
  if CompareStr(UpperCase(V_TabStruttura.interest), 'INTERNA') = 0 then
    MessageDlg(MSG_004023002, mtInformation, [mbOK], 0)
end;

procedure TWizardFSoloMuri.LB_InfoVerFClick(Sender: TObject);
begin
  MessageDlg(MSG_004023003, mtInformation, [mbOK], 0)
end;

end.


