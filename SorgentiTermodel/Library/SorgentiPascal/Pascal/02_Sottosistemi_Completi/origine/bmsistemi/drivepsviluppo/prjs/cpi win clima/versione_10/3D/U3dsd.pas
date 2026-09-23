unit U3dsd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  ExtCtrls,  StdCtrls,DBCtrls,Mask,Grids, DBGrids,udbt,
  ComCtrls, MPlayer, Spin, LbButton,Buttons,DB, DBTables,LbSpeedButton,
  ImgList, ToolWin,OleCtnrs, DdeMan,TeEngine, Series,TeeProcs, Chart, LbStaticText, Menus,
  ValEdit,

  GLWin32Viewer,GLScene, GLObjects, GLMisc,gltexture, GLSkydome, GLParticles,
  GLCadencer,GLBehaviours, GLSpaceText,glmovement,
  grafica2d,
  {$Ifdef Canali_14}
  UCalcoloCanDll,
  {$endif}
  UOggetti,
  libreriagenerale,
  disedificio,
  varcarichi,
  ULeggiscriviDati,
  init_cad3d,
  CopiaLetturadisegno3d,
  gesterrori,
  fconsigli,
  setta_config_user,
  falde3d,
  stampe3d,
  vispareti3d,
  Edificio3D,
  reti3d,

  udatalink,
  visreportlocali,
  variabili3d,
  chiamateoggetti,
  uvariabililettura,
  Ucompilaform,
  fasi_progetto,
  compila_form_database,
  {$IfNdef usadll}
  init_l10,
  {$endif}
  gestudb,
  progress3D,
  sceltaA,
  config_var,
  chiedilicenza,
  datilicenza,
  archpers3d,
  {$Ifdef tubi_14}
  Funz_reti,
  tratti_rete3d,
  {$Else}
  Interf3D_reti,
  {$endif}
  headerDllTermico,
  selectdir,
  filedialog,
  conferma3d,
  Carburanti3D,dxf_in_out;

type
  TForm1 = class(TForm)
    GLSceneViewer1: TGLSceneViewer;
    GLScene1: TGLScene;
    GLCamera1: TGLCamera;
    DCOggetti: TDummyCube;
    DCLuci: TDummyCube;
    Sphere1: TSphere;
    DCVista: TDummyCube;
    DCGenerale: TDummyCube;
    DCGlobale: TDummyCube;
    DcParticles: TDummyCube;
    Disk1: TDisk;
    Cylinder1: TCylinder;
    Cube1: TCube;
    GB_PuntiVista3D: TGroupBox;
    CheckBox1: TCheckBox;
    RBscheletro: TCheckBox;
    CBHmedia: TCheckBox;
    CBVetri: TCheckBox;
    CB_Reti: TCheckBox;
    CB_Canali: TCheckBox;
    CBdentro: TCheckBox;
    CbAssi: TCheckBox;
    GroupBox1: TGroupBox;
    GB_ZoomRot: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    TrackBar1: TTrackBar;
    TrackBar2: TTrackBar;
    TrackBar4: TTrackBar;
    TrackBar5: TTrackBar;
    Label5: TLabel;
    CBLocale: TComboBox;
    Label9: TLabel;
    CBPIano: TComboBox;
    Bsalva: TLbButton;
    Brichiama: TLbButton;
    RBVista: TRadioButton;
    RBLuci: TRadioButton;
    Label6: TLabel;
    SBNPezzo: TSpinEdit;
    test1: TTrackBar;
    Label7: TLabel;
    TrackBar3: TTrackBar;
    Panel_base: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TSCanali: TTabSheet;
    GBVarie: TGroupBox;
    GBCANALI: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    LIndpCan: TLabel;
    EACan: TEdit;
    EBCan: TEdit;
    ERCan: TEdit;
    ECodiceCan: TEdit;
    LIndicepezzo: TLabel;
    LRaggioCan: TLabel;
    ERagCan: TEdit;
    LURaggiocan: TLabel;
    Label20: TLabel;
    EPOrtCan: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    EPerdCan: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    ELungCan: TEdit;
    Label25: TLabel;
    LBArchivio: TLbButton;
    LBModifica: TLbButton;
    GroupBox3: TGroupBox;
    Merrorican: TMemo;
    Label10: TLabel;
    CBFISSA: TComboBox;
    Leq: TLabel;
    LbAggiornaCanali: TLbButton;
    PageControl1: TPageControl;
    Panel1: TPanel;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    PageControl2: TPageControl;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    TabSheet9: TTabSheet;
    TabSheet10: TTabSheet;
    PageControl3: TPageControl;
    TabSheet12: TTabSheet;
    TabSheet13: TTabSheet;
    TabSheet14: TTabSheet;
    Groupbox2: TGroupBox;
    PageControl4: TPageControl;
    TabSheet15: TTabSheet;
    TabSheet16: TTabSheet;
    DBComboBox1: TDBComboBox;
    Panel2: TPanel;
    Image1: TImage;
    SpeedButton2: TSpeedButton;
    GBPareti: TGroupBox;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    SpeedButton7: TSpeedButton;
    DBTipoParete: TDBComboBox;
    DBConfineParete: TDBComboBox;
    DBImPareti: TDBImage;
    GBFinestre: TGroupBox;
    Label37: TLabel;
    SpeedButton6: TSpeedButton;
    DBTipoFinestra: TDBComboBox;
    PageControl5: TPageControl;
    TabSheet11: TTabSheet;
    DBImfinestre: TDBImage;
    TabSheet17: TTabSheet;
    Label49: TLabel;
    Label50: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    Label62: TLabel;
    Label63: TLabel;
    Label64: TLabel;
    Label65: TLabel;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    TabSheet18: TTabSheet;
    TabSheet19: TTabSheet;
    GroupBox9: TGroupBox;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    Label39: TLabel;
    Label40: TLabel;
    ComboBox2: TComboBox;
    TabSheet20: TTabSheet;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    LB_Lunghezza: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label48: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    lfisso: TLabel;
    Edit1: TEdit;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    MPerdite: TMemo;
    ED_TipoTubo: TEdit;
    ED_Velocita: TEdit;
    Ed_PCar: TEdit;
    Edit8: TEdit;
    PageControl6: TPageControl;
    TabSheet21: TTabSheet;
    TabSheet22: TTabSheet;
    TabSheet23: TTabSheet;
    TabSheet24: TTabSheet;
    PageControl7: TPageControl;
    TabSheet25: TTabSheet;
    TabSheet26: TTabSheet;
    TabSheet27: TTabSheet;
    DBGrid2: TDBGrid;
    PageControl8: TPageControl;
    TabSheet28: TTabSheet;
    TabSheet29: TTabSheet;
    GroupBox10: TGroupBox;
    PageControl9: TPageControl;
    TabSheet30: TTabSheet;
    GroupBox11: TGroupBox;
    Label76: TLabel;
    Label77: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    Label80: TLabel;
    Label81: TLabel;
    Label82: TLabel;
    Label83: TLabel;
    Label84: TLabel;
    Label85: TLabel;
    Label86: TLabel;
    Label87: TLabel;
    Label88: TLabel;
    Label89: TLabel;
    Label90: TLabel;
    Label91: TLabel;
    DBEdit2: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    DBComboBox6: TDBComboBox;
    DBComboBox7: TDBComboBox;
    DBEdit16: TDBEdit;
    DBEdit26: TDBEdit;
    Ed_Volume: TStaticText;
    TabSheet31: TTabSheet;
    GroupBox12: TGroupBox;
    Label92: TLabel;
    Label93: TLabel;
    Label94: TLabel;
    Label95: TLabel;
    Label96: TLabel;
    Label97: TLabel;
    Label98: TLabel;
    Label99: TLabel;
    Label100: TLabel;
    Label101: TLabel;
    Label102: TLabel;
    Label103: TLabel;
    Label104: TLabel;
    Label105: TLabel;
    Label106: TLabel;
    Label107: TLabel;
    Label108: TLabel;
    Label109: TLabel;
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
    TabSheet32: TTabSheet;
    GroupBox13: TGroupBox;
    Label110: TLabel;
    Label111: TLabel;
    Label112: TLabel;
    Label113: TLabel;
    DBComboBox11: TDBComboBox;
    DBComboBox12: TDBComboBox;
    DBComboBox13: TDBComboBox;
    DBComboBox14: TDBComboBox;
    Combo_TipoSoffitto: TComboBox;
    Combo_ConfineSoffitto: TComboBox;
    Combo_TipoPavimento: TComboBox;
    Combo_ConfinePavimento: TComboBox;
    Panel3: TPanel;
    SB_Conferma: TLbSpeedButton;
    GroupBox14: TGroupBox;
    GroupBox15: TGroupBox;
    Label114: TLabel;
    Label115: TLabel;
    Label116: TLabel;
    Label117: TLabel;
    Label118: TLabel;
    Label119: TLabel;
    Label120: TLabel;
    Label122: TLabel;
    Label123: TLabel;
    Label121: TLabel;
    Label124: TLabel;
    Label125: TLabel;
    Label126: TLabel;
    Label127: TLabel;
    Label128: TLabel;
    Label129: TLabel;
    Label130: TLabel;
    Label131: TLabel;
    Label132: TLabel;
    Label133: TLabel;
    Label134: TLabel;
    Label135: TLabel;
    Label136: TLabel;
    Label137: TLabel;
    Label138: TLabel;
    StringGrid1: TStringGrid;
    PageControl10: TPageControl;
    TabSheet33: TTabSheet;
    TabSheet34: TTabSheet;
    TabSheet35: TTabSheet;
    DBGrid3: TDBGrid;
    DBGrid4: TDBGrid;
    Panel4: TPanel;
    GroupBox16: TGroupBox;
    Panel5: TPanel;
    GroupBox17: TGroupBox;
    TabSheet36: TTabSheet;
    PageControl11: TPageControl;
    TabSheet37: TTabSheet;
    TabSheet38: TTabSheet;
    TabSheet39: TTabSheet;
    TabSheet40: TTabSheet;
    TabSheet41: TTabSheet;
    TabSheet42: TTabSheet;
    DBGrid10: TDBGrid;
    Panel10: TPanel;
    Label139: TLabel;
    Panel12: TPanel;
    Panel13: TPanel;
    DBNavigator1: TDBNavigator;
    GroupBox30: TGroupBox;
    DBComboBox3: TDBComboBox;
    DBComboBox5: TDBComboBox;
    Label141: TLabel;
    Label142: TLabel;
    GroupBox32: TGroupBox;
    Label143: TLabel;
    Label144: TLabel;
    DBComboBox15: TDBComboBox;
    DBComboBox16: TDBComboBox;
    GroupBox33: TGroupBox;
    Label145: TLabel;
    Label146: TLabel;
    DBComboBox17: TDBComboBox;
    DBComboBox18: TDBComboBox;
    Panel11: TPanel;
    GroupBox18: TGroupBox;
    Label140: TLabel;
    Label151: TLabel;
    DBComboBox23: TDBComboBox;
    DBComboBox24: TDBComboBox;
    GroupBox19: TGroupBox;
    Label152: TLabel;
    Label153: TLabel;
    DBComboBox25: TDBComboBox;
    DBComboBox26: TDBComboBox;
    GroupBox31: TGroupBox;
    Label147: TLabel;
    Label148: TLabel;
    Label149: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Label150: TLabel;
    DBEdit6: TDBEdit;
    Label154: TLabel;
    DBEdit7: TDBEdit;
    Label155: TLabel;
    DBEdit8: TDBEdit;
    Label156: TLabel;
    DBEdit9: TDBEdit;
    Label157: TLabel;
    DBEdit10: TDBEdit;
    Label158: TLabel;
    Label159: TLabel;
    Label160: TLabel;
    Label161: TLabel;
    GroupBox20: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    DBGrid5: TDBGrid;
    DBGrid6: TDBGrid;
    GroupBox21: TGroupBox;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton1: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ImageList1: TImageList;
    GroupBox22: TGroupBox;
    DBGrid7: TDBGrid;
    DBNavigator2: TDBNavigator;
    TabSheet43: TTabSheet;
    GroupBox23: TGroupBox;
    GroupBox24: TGroupBox;
    GroupBox25: TGroupBox;
    ListBox1: TListBox;
    Memo1: TMemo;
    TabSheet44: TTabSheet;
    PageControl12: TPageControl;
    TabSheet45: TTabSheet;
    TabSheet46: TTabSheet;
    TabSheet47: TTabSheet;
    Panel6: TPanel;
    DBNavigator3: TDBNavigator;
    DBGrid8: TDBGrid;
    PageControl13: TPageControl;
    TabSheet48: TTabSheet;
    GroupBox26: TGroupBox;
    Label162: TLabel;
    Label163: TLabel;
    Label164: TLabel;
    Label165: TLabel;
    DBEdit36: TDBEdit;
    DBEdit37: TDBEdit;
    DBEdit53: TDBEdit;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    GroupBox27: TGroupBox;
    Label166: TLabel;
    LbButton2: TLbButton;
    LbButton3: TLbButton;
    SaveDialog2: TSaveDialog;
    LbButton4: TLbButton;
    Memo2: TMemo;
    Panel7: TPanel;
    Panel8: TPanel;
    Memo3: TMemo;
    Button1: TButton;
    GBLocali: TGroupBox;
    Label167: TLabel;
    Label168: TLabel;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    DBTipoZona: TDBComboBox;
    DBTipoImpianto: TDBComboBox;
    GBSoffitto: TGroupBox;
    Label169: TLabel;
    Label170: TLabel;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    DBTipoSoffitto: TDBComboBox;
    DBConfineSoffitto: TDBComboBox;
    GBPavimento: TGroupBox;
    Label171: TLabel;
    Label172: TLabel;
    SpeedButton17: TSpeedButton;
    SpeedButton18: TSpeedButton;
    DBTipoPavimento: TDBComboBox;
    DBConfinePavimento: TDBComboBox;
    Panel9: TPanel;
    DBNavigator4: TDBNavigator;
    DBGrid9: TDBGrid;
    PageControl14: TPageControl;
    TabSheet49: TTabSheet;
    GroupBox28: TGroupBox;
    Label173: TLabel;
    Label174: TLabel;
    DBEdit11: TDBEdit;
    DBEdit17: TDBEdit;
    GBPontiTermici: TGroupBox;
    Label175: TLabel;
    Label176: TLabel;
    Label177: TLabel;
    SpeedButton8: TSpeedButton;
    DBTipoPontiTermici: TDBComboBox;
    DBELponte: TDBEdit;
    DBImage1: TDBImage;
    Label178: TLabel;
    Label179: TLabel;
    DBEdit1: TDBEdit;
    Label180: TLabel;
    OpenDialog2: TOpenDialog;
    DBEdit25: TDBEdit;
    TabSheet50: TTabSheet;
    DBGrid11: TDBGrid;
    GroupBox5: TGroupBox;
    DBNavigator5: TDBNavigator;
    DBComboBox2: TDBComboBox;
    CBAGG3D: TCheckBox;
    SpeedButton4: TSpeedButton;
    DBComboBox4: TDBComboBox;
    Label181: TLabel;
    SpeedButton5: TSpeedButton;
    SpeedButton10: TSpeedButton;
    Label182: TLabel;
    Label183: TLabel;
    Label184: TLabel;
    BitBtn1: TBitBtn;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    SpeedButton11: TSpeedButton;
    GroupBox29: TGroupBox;
    checkbox2: TRadioButton;
    checkbox3: TRadioButton;
    GBTipoRete: TGroupBox;
    Barchiviotubi: TSpeedButton;
    GroupBox6: TGroupBox;
    Label26: TLabel;
    DBCarattCostruttive: TDBComboBox;
    GroupBox7: TGroupBox;
    Label27: TLabel;
    Label28: TLabel;
    CBTiporete: TDBComboBox;
    GroupBox8: TGroupBox;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    SpeedButton12: TSpeedButton;
    CbPerdloc: TDBComboBox;
    Elungtubo: TDBEdit;
    Enumcurve: TDBEdit;
    DBAttIrete: TDBComboBox;
    ECodRete: TDBEdit;
    Label185: TLabel;
    DBComboBox19: TDBComboBox;
    SpeedButton13: TSpeedButton;
    CBDoppio: TCheckBox;
    GBVALVOLE: TGroupBox;
    Label186: TLabel;
    Label187: TLabel;
    CbDISPERDITE: TDBComboBox;
    CBCODPERDITE: TDBComboBox;
    GBTERMINALI: TGroupBox;
    Label188: TLabel;
    Label189: TLabel;
    Label190: TLabel;
    Label191: TLabel;
    DBAttTerm: TDBComboBox;
    DBSIMBTERM: TDBComboBox;
    EMONTAGGIO: TDBEdit;
    PageControl15: TPageControl;
    TabSheet51: TTabSheet;
    GroupBox34: TGroupBox;
    Label192: TLabel;
    Label193: TLabel;
    Label194: TLabel;
    Label195: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    GBDATITERM1: TGroupBox;
    Label196: TLabel;
    Label197: TLabel;
    Label198: TLabel;
    Label199: TLabel;
    EINCRPOT: TDBEdit;
    ELARGMAX: TDBEdit;
    TabSheet52: TTabSheet;
    GBDATITERM2: TGroupBox;
    Label200: TLabel;
    Label201: TLabel;
    Label202: TLabel;
    Label203: TLabel;
    Label204: TLabel;
    Label205: TLabel;
    Label206: TLabel;
    EPORT: TDBEdit;
    EPOT: TDBEdit;
    EPERD: TDBEdit;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    GroupBox4: TGroupBox;
    Label207: TLabel;
    Label208: TLabel;
    Label209: TLabel;
    Label210: TLabel;
    Label211: TLabel;
    Label212: TLabel;
    Label213: TLabel;
    Label214: TLabel;
    Label215: TLabel;
    Label216: TLabel;
    Label217: TLabel;
    Label218: TLabel;
    Label219: TLabel;
    Label220: TLabel;
    Label222: TLabel;
    Label223: TLabel;
    Label224: TLabel;
    DBComboBox20: TDBComboBox;
    DBEdit27: TDBEdit;
    DBEdit28: TDBEdit;
    DBEdit29: TDBEdit;
    DBComboBox21: TDBComboBox;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    DBComboBox22: TDBComboBox;
    DBEdit32: TDBEdit;
    DBEdit33: TDBEdit;
    PageControl16: TPageControl;
    TabSheet53: TTabSheet;
    TabSheet54: TTabSheet;
    GroupBox35: TGroupBox;
    Label221: TLabel;
    Label225: TLabel;
    Label226: TLabel;
    Label227: TLabel;
    Label228: TLabel;
    Label229: TLabel;
    Label230: TLabel;
    Label231: TLabel;
    Label232: TLabel;
    Label233: TLabel;
    Label234: TLabel;
    Label235: TLabel;
    Label236: TLabel;
    Label238: TLabel;
    Label239: TLabel;
    DBEdit34: TDBEdit;
    DBEdit35: TDBEdit;
    DBEdit38: TDBEdit;
    DBComboBox27: TDBComboBox;
    DBComboBox28: TDBComboBox;
    DBEdit39: TDBEdit;
    DBEdit40: TDBEdit;
    StaticText1: TStaticText;
    TabSheet55: TTabSheet;
    DBGrid12: TDBGrid;
    SpeedButton14: TSpeedButton;
    DBEdit41: TDBEdit;
    Label237: TLabel;
    Label240: TLabel;
    Memo4: TMemo;
    TabSheet56: TTabSheet;
    TabSheet57: TTabSheet;
    DBGridGeneratori: TDBGrid;
    Panel14: TPanel;
    DBNGeneratori: TDBNavigator;
    PageControl_Ris: TPageControl;
    TabSheet_Risultati: TTabSheet;
    Label_Art7: TLabel;
    GB_Dimens: TGroupBox;
    LB_VolumeL: TLabel;
    Lb_m: TLabel;
    LB_SupL: TLabel;
    LB_m2: TLabel;
    LB_SupP: TLabel;
    LB_m22: TLabel;
    Label_SV: TLabel;
    LB_m1: TLabel;
    GroupBox_Disper: TGroupBox;
    LB_Disp: TLabel;
    LB_W1: TLabel;
    LB_DispInf: TLabel;
    LB_W2: TLabel;
    Label241: TLabel;
    LB_wm3: TLabel;
    EN_DispPerCDInf: TStaticText;
    EN_DispVol: TStaticText;
    EN_DispPerCD: TStaticText;
    GB_Veriche192: TGroupBox;
    LB_Info: TLbSpeedButton;
    Label242: TLabel;
    Label_FMJ: TLabel;
    Label_perc: TLabel;
    Label_perc2: TLabel;
    Label243: TLabel;
    Label244: TLabel;
    Label_KJ: TLabel;
    SB_VerPareti: TLbSpeedButton;
    SB_VerFinestre: TLbSpeedButton;
    ST_Calcolato: TStaticText;
    ST_ValoreLimite: TStaticText;
    ST_Feap: TStaticText;
    St_EtaG: TStaticText;
    St_EtaP: TStaticText;
    ST_ValLim: TStaticText;
    ST_FabKW: TStaticText;
    EN_RendCalcolato: TStaticText;
    EN_RendMax: TStaticText;
    ST_EtaPC: TStaticText;
    ST_EtaPV: TStaticText;
    St_CD: TStaticText;
    EN_CdCalcolato: TStaticText;
    EN_CDLegge: TStaticText;
    ST_Fen: TStaticText;
    EN_Fen: TStaticText;
    EN_FenLimite: TStaticText;
    LB_SM1: TLbStaticText;
    LB_SM2: TLbStaticText;
    LB_SM3: TLbStaticText;
    LB_SM4: TLbStaticText;
    LB_SM5: TLbStaticText;
    EN_Articolo7: TStaticText;
    GroupBox_VerCorr: TGroupBox;
    ListBox_VerCor: TListBox;
    TabSheet_Grafico: TTabSheet;
    LB_frase: TLabel;
    GraficoDispersioni: TChart;
    Series1: TBarSeries;
    TSheet_AttEnergEdif: TTabSheet;
    Label245: TLabel;
    Label246: TLabel;
    Label247: TLabel;
    Label248: TLabel;
    Label249: TLabel;
    Label250: TLabel;
    LB_Cat: TLabel;
    Shape1: TShape;
    Image2: TImage;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    Shape8: TShape;
    Shape7: TShape;
    Shape9: TShape;
    Shape10: TShape;
    Shape11: TShape;
    Shape12: TShape;
    Shape13: TShape;
    Shape14: TShape;
    Label251: TLabel;
    Label252: TLabel;
    Label253: TLabel;
    Label254: TLabel;
    Label255: TLabel;
    Label256: TLabel;
    Label257: TLabel;
    Shape15: TShape;
    Shape16: TShape;
    Shape17: TShape;
    Shape18: TShape;
    Shape19: TShape;
    Shape20: TShape;
    Shape21: TShape;
    LBVal_A: TLabel;
    LBVal_B: TLabel;
    LBVal_C: TLabel;
    LBVal_D: TLabel;
    LBVal_E: TLabel;
    LBVal_F: TLabel;
    LBVal_G: TLabel;
    LBVal_AJ: TLabel;
    LBVal_BJ: TLabel;
    LbVal_CJ: TLabel;
    LBVal_DJ: TLabel;
    LBVal_EJ: TLabel;
    LbVal_FJ: TLabel;
    LbVal_GJ: TLabel;
    Panel15: TPanel;
    Label258: TLabel;
    TabSheet58: TTabSheet;
    Panel16: TPanel;
    DBEdit42: TDBEdit;
    DBEdit43: TDBEdit;
    DBEdit44: TDBEdit;
    DBEdit45: TDBEdit;
    DBEdit46: TDBEdit;
    TabSheet59: TTabSheet;
    GroupBox36: TGroupBox;
    Label261: TLabel;
    DBEdit48: TDBEdit;
    Label262: TLabel;
    Label263: TLabel;
    DBEdit49: TDBEdit;
    Label264: TLabel;
    Label265: TLabel;
    DBEdit50: TDBEdit;
    Label266: TLabel;
    Label267: TLabel;
    DBEdit51: TDBEdit;
    Label268: TLabel;
    Label269: TLabel;
    DBEdit52: TDBEdit;
    GBConsumiRisc: TGroupBox;
    Label283: TLabel;
    Label284: TLabel;
    Label285: TLabel;
    Label286: TLabel;
    Label287: TLabel;
    Label288: TLabel;
    Label289: TLabel;
    Label290: TLabel;
    Label291: TLabel;
    Label292: TLabel;
    Label293: TLabel;
    DBEdit62: TDBEdit;
    DBEdit63: TDBEdit;
    DBEdit64: TDBEdit;
    DBEdit65: TDBEdit;
    DBEdit66: TDBEdit;
    DBEdit67: TDBEdit;
    GroupBox37: TGroupBox;
    Label270: TLabel;
    Label271: TLabel;
    Label272: TLabel;
    Label273: TLabel;
    Label274: TLabel;
    Label275: TLabel;
    Label276: TLabel;
    Label277: TLabel;
    Label278: TLabel;
    Label279: TLabel;
    Label280: TLabel;
    Label281: TLabel;
    Label282: TLabel;
    DBEdit54: TDBEdit;
    DBEdit55: TDBEdit;
    DBEdit56: TDBEdit;
    DBEdit57: TDBEdit;
    DBEdit58: TDBEdit;
    DBEdit59: TDBEdit;
    DBEdit60: TDBEdit;
    DBEdit61: TDBEdit;
    DBGrid13: TDBGrid;
    Panel17: TPanel;
    GroupBox39: TGroupBox;
    Label259: TLabel;
    Label260: TLabel;
    Label294: TLabel;
    Label295: TLabel;
    Label296: TLabel;
    Label297: TLabel;
    Label301: TLabel;
    Label302: TLabel;
    Label303: TLabel;
    Label304: TLabel;
    DBEdit47: TDBEdit;
    DBEdit68: TDBEdit;
    DBEdit69: TDBEdit;
    DBEdit70: TDBEdit;
    DBEdit73: TDBEdit;
    DBEdit74: TDBEdit;
    TabSheet60: TTabSheet;
    PageControl17: TPageControl;
    TabSheet61: TTabSheet;
    GroupBox40: TGroupBox;
    Label298: TLabel;
    Label299: TLabel;
    Label300: TLabel;
    Label305: TLabel;
    Label306: TLabel;
    DBEdit71: TDBEdit;
    DBEdit72: TDBEdit;
    GroupBox41: TGroupBox;
    Memo5: TMemo;
    GroupBox42: TGroupBox;
    Memo6: TMemo;
    Button2: TButton;
    GroupBox43: TGroupBox;
    Memo7: TMemo;
    Button3: TButton;
    GroupBox44: TGroupBox;
    Memo8: TMemo;
    Button4: TButton;
    GroupBox45: TGroupBox;
    Memo9: TMemo;
    Button5: TButton;
    Panel18: TPanel;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Nuovo1: TMenuItem;
    Apri1: TMenuItem;
    Salva1: TMenuItem;
    Salvaconnome1: TMenuItem;
    Chiudi1: TMenuItem;
    Stampa1: TMenuItem;
    TabSheet62: TTabSheet;
    GBLocSemp: TGroupBox;
    Label307: TLabel;
    btnArchivio: TLbSpeedButton;
    DBEdit75: TDBEdit;
    TabSheet63: TTabSheet;
    TabSheet64: TTabSheet;
    TabSheet65: TTabSheet;
    Panel19: TPanel;
    Panel20: TPanel;
    Button6: TButton;
    Button7: TButton;
    DBGfinsemp: TDBGrid;
    Panel21: TPanel;
    GroupBox46: TGroupBox;
    Label308: TLabel;
    Label309: TLabel;
    Label310: TLabel;
    DBEdit76: TDBEdit;
    Label311: TLabel;
    Label312: TLabel;
    Label313: TLabel;
    Label314: TLabel;
    Label315: TLabel;
    DBEdit77: TDBEdit;
    DBEdit78: TDBEdit;
    DBEdit79: TDBEdit;
    DBEdit80: TDBEdit;
    DBEdit81: TDBEdit;
    Label316: TLabel;
    Button8: TButton;
    TabSheet66: TTabSheet;
    Panel22: TPanel;
    Panel23: TPanel;
    DBNAllSemp: TDBNavigator;
    GroupBox47: TGroupBox;
    DBGALLsemp: TDBGrid;
    PageControl18: TPageControl;
    TabSheet67: TTabSheet;
    TabSheet68: TTabSheet;
    Panel24: TPanel;
    Panel25: TPanel;
    Button9: TButton;
    GroupBox48: TGroupBox;
    DBGMesisemp: TDBGrid;
    Label317: TLabel;
    DBEdit82: TDBEdit;
    Label318: TLabel;
    Label319: TLabel;
    DBEdit83: TDBEdit;
    Label320: TLabel;
    DBEdit84: TDBEdit;
    Label321: TLabel;
    Label322: TLabel;
    DBEdit85: TDBEdit;
    Label323: TLabel;
    DBEdit86: TDBEdit;
    Label324: TLabel;
    DBEdit87: TDBEdit;
    Label325: TLabel;
    Label326: TLabel;
    DBEdit88: TDBEdit;
    Label327: TLabel;
    Label328: TLabel;
    DBEdit89: TDBEdit;
    Label329: TLabel;
    DBEdit90: TDBEdit;
    Label330: TLabel;
    DBEdit91: TDBEdit;
    Label331: TLabel;
    Label332: TLabel;
    DBEdit92: TDBEdit;
    Label333: TLabel;
    Button10: TButton;
    GroupBox49: TGroupBox;
    Label334: TLabel;
    Label335: TLabel;
    Label336: TLabel;
    Label337: TLabel;
    Label338: TLabel;
    Label339: TLabel;
    Label340: TLabel;
    Label341: TLabel;
    Label342: TLabel;
    DBEdit93: TDBEdit;
    DBEdit94: TDBEdit;
    DBEdit95: TDBEdit;
    DBEdit96: TDBEdit;
    DBEdit97: TDBEdit;
    DBEdit98: TDBEdit;
    Panel26: TPanel;
    Panel27: TPanel;
    Button11: TButton;
    Button12: TButton;
    Button13: TButton;
    DBGrid14: TDBGrid;
    GroupBox50: TGroupBox;
    Label343: TLabel;
    Label344: TLabel;
    Label345: TLabel;
    Label346: TLabel;
    Label347: TLabel;
    Label348: TLabel;
    Label349: TLabel;
    DBEdit99: TDBEdit;
    DBEdit100: TDBEdit;
    DBEdit101: TDBEdit;
    DBEdit102: TDBEdit;
    DBEdit103: TDBEdit;
    Label353: TLabel;
    Label354: TLabel;
    Label355: TLabel;
    Label356: TLabel;
    Label357: TLabel;
    Label358: TLabel;
    DBComboBox29: TDBComboBox;
    PageControl19: TPageControl;
    TabSheet69: TTabSheet;
    TabSheet70: TTabSheet;
    DBComboBox31: TDBComboBox;
    Label359: TLabel;
    DBEdit106: TDBEdit;
    DBEdit107: TDBEdit;
    Label360: TLabel;
    PageControl20: TPageControl;
    TabSheet71: TTabSheet;
    GroupBox52: TGroupBox;
    Label365: TLabel;
    Label366: TLabel;
    Label367: TLabel;
    Label368: TLabel;
    Label369: TLabel;
    Label370: TLabel;
    DBComboBox34: TDBComboBox;
    DBEdit108: TDBEdit;
    DBComboBox35: TDBComboBox;
    DBEdit109: TDBEdit;
    TabSheet72: TTabSheet;
    GroupBox53: TGroupBox;
    Label372: TLabel;
    Label373: TLabel;
    Label374: TLabel;
    Label375: TLabel;
    Label376: TLabel;
    Label377: TLabel;
    Label378: TLabel;
    DBComboBox37: TDBComboBox;
    DBEdit110: TDBEdit;
    DBComboBox38: TDBComboBox;
    DBComboBox39: TDBComboBox;
    DBEdit111: TDBEdit;
    Label350: TLabel;
    DBComboBox30: TDBComboBox;
    TabSheet73: TTabSheet;
    GroupBox51: TGroupBox;
    Label351: TLabel;
    DBEdit104: TDBEdit;
    Label352: TLabel;
    Label361: TLabel;
    DBEdit105: TDBEdit;
    Label362: TLabel;
    Label363: TLabel;
    GroupBox54: TGroupBox;
    Label364: TLabel;
    DBEdit112: TDBEdit;
    Label371: TLabel;
    Label379: TLabel;
    DBEdit113: TDBEdit;
    Label380: TLabel;
    Label381: TLabel;
    DBEdit114: TDBEdit;
    Label382: TLabel;
    DBEdit115: TDBEdit;
    Label383: TLabel;
    Label384: TLabel;
    Label385: TLabel;
    DBEdit116: TDBEdit;
    Label386: TLabel;
    Label387: TLabel;
    DBEdit117: TDBEdit;
    Label388: TLabel;
    PageControl21: TPageControl;
    TabSheet74: TTabSheet;
    TabSheet75: TTabSheet;
    TabSheet76: TTabSheet;
    GroupBox55: TGroupBox;
    PageControl22: TPageControl;
    TabSheet77: TTabSheet;
    TabSheet78: TTabSheet;
    Memo10: TMemo;
    CbColoreParete: TDBComboBox;
    TabSheet79: TTabSheet;
    Memo11: TMemo;
    CBTlinea: TDBEdit;
    Progetto1: TMenuItem;
    Datidiprogetto1: TMenuItem;
    Edificio1: TMenuItem;
    Pareti1: TMenuItem;
    Finestre1: TMenuItem;
    PontiTermici1: TMenuItem;
    Profiliorari1: TMenuItem;
    Zone1: TMenuItem;
    Impianti1: TMenuItem;
    Generatori1: TMenuItem;
    Confini1: TMenuItem;
    Calcoli1: TMenuItem;
    Verifichedileggeart3111: TMenuItem;
    Button14: TButton;
    Timer1: TTimer;
    Button15: TButton;
    Gestionepiani1: TMenuItem;
    Button16: TButton;
    Panel28: TPanel;
    Button17: TButton;
    PageControl23: TPageControl;
    TabSheet80: TTabSheet;
    TabSheet81: TTabSheet;
    Memo12: TMemo;
    CBSchelPiani: TCheckBox;
    Button18: TButton;
    impan: TImage;
    CBSfondo: TCheckBox;
    Label390: TLabel;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Opzioni1: TMenuItem;
    Gestionedegliarchivipersonali1: TMenuItem;
    CBFiltroloc: TCheckBox;
    Edit12: TEdit;
    Intestatariodellicenzaduso1: TMenuItem;
    PageControl24: TPageControl;
    TabSheet82: TTabSheet;
    TabSheet83: TTabSheet;
    GB2D: TGroupBox;
    Ultimoprogetto1: TMenuItem;
    SpeedButton3: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton21: TSpeedButton;
    GroupBox56: TGroupBox;
    Panel29: TPanel;
    PageControl25: TPageControl;
    TabSheet84: TTabSheet;
    TabSheet85: TTabSheet;
    Memo13: TMemo;
    GroupBox57: TGroupBox;
    CBColoretubo: TDBComboBox;
    DBEdit118: TDBEdit;
    Label389: TLabel;
    CheckBox10: TCheckBox;
    Edit41: TEdit;
    Label8: TLabel;
    DBComboBox32: TDBComboBox;
    Button22: TButton;
    Reti1: TMenuItem;
    CheckBox11: TCheckBox;
    Button23: TButton;
    Label18: TLabel;
    OleContainer1: TOleContainer;
    GroupBox58: TGroupBox;
    Label19: TLabel;
    Label38: TLabel;
    Label391: TLabel;
    Label392: TLabel;
    GroupBox59: TGroupBox;
    Tabcalcoli: TTabSheet;
    Button24: TButton;
    Label393: TLabel;
    Button25: TButton;
    TSDialogo: TTabSheet;
    Panel30: TPanel;
    LbSpeedButton1: TLbSpeedButton;
    Binserisci: TLbSpeedButton;
    SpeedButton22: TSpeedButton;
    Label394: TLabel;
    Label395: TLabel;
    Label396: TLabel;
    Label397: TLabel;
    EDNOME: TEdit;
    ListBox2: TListBox;
    Panel31: TPanel;
    LbSpeedButton2: TLbSpeedButton;
    GroupBox60: TGroupBox;
    CBVERSBM: TCheckBox;
    F1: TMenuItem;
    GroupBox61: TGroupBox;
    DBGCarb: TDBGrid;
    SpeedButton23: TSpeedButton;
    TabSheet86: TTabSheet;
    LbSpeedButton3: TLbSpeedButton;
    DBEdit119: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    BitBtn2: TBitBtn;
    EAlloggio: TComboBox;
    Button26: TButton;
    PCLATERALE: TPageControl;
    TSConf3d: TTabSheet;
    TSPannello: TTabSheet;
    TabSheet87: TTabSheet;
    Button27: TButton;
    TabSheet88: TTabSheet;
    Label398: TLabel;
    Label399: TLabel;
    Label400: TLabel;
    Label401: TLabel;
    Label402: TLabel;
    Label403: TLabel;
    Label404: TLabel;
    Label405: TLabel;
    Label406: TLabel;
    Label407: TLabel;
    Image3: TImage;
    Label408: TLabel;
    Label409: TLabel;
    UpDown1: TUpDown;
    Button28: TButton;
    CBSpirali: TCheckBox;
    TabSheet89: TTabSheet;
    TabSheet90: TTabSheet;
    SG_pareti: TStringGrid;
    GB_Pareti_1: TGroupBox;
    procedure TrackBar1Change(Sender: TObject);
    procedure GLSceneViewer1MouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure GLSceneViewer1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure RBVistaClick(Sender: TObject);
    procedure TrackBar2Change(Sender: TObject);
    procedure TrackBar3Change(Sender: TObject);
    procedure GLSceneViewer1DblClick(Sender: TObject);
    procedure TrackBar4Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure RBscheletroClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CBLocaleChange(Sender: TObject);
    procedure CB_RetiClick(Sender: TObject);
    procedure CBdentroClick(Sender: TObject);
    procedure CbAssiClick(Sender: TObject);
    procedure CBVetriClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBHmediaClick(Sender: TObject);
    procedure BSalvaClick(Sender: TObject);
    procedure BRichiamaClick(Sender: TObject);
    procedure test1Change(Sender: TObject);
    procedure EpezzoChange(Sender: TObject);
    procedure SBNPezzoChange(Sender: TObject);
    procedure CBTUTTILOCALIClick(Sender: TObject);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure LBArchivioClick(Sender: TObject);
    procedure LBModificaClick(Sender: TObject);
    procedure LbAggiornaCanaliClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure SpeedButton7Click(Sender: TObject);
    procedure DBTipoPareteChange(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure DBTipoFinestraChange(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure DBConfinePareteChange(Sender: TObject);
    procedure CBTlineaChange(Sender: TObject);
    procedure Panel2CanResize(Sender: TObject; var NewWidth,
      NewHeight: Integer; var Resize: Boolean);
    procedure DBComboBox1Change(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure PageControl8Change(Sender: TObject);
    procedure PageControl4Change(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure LbButton2Click(Sender: TObject);
    procedure LbButton3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure LbButton4Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure DBTipoZonaChange(Sender: TObject);
    procedure LbButton6Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure PageControl1Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure DBNavigator3Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBNavigator4Click(Sender: TObject; Button: TNavigateBtn);
    procedure LbButton7Click(Sender: TObject);
    procedure LbButton8Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure CheckBox5Click(Sender: TObject);
    procedure DBComboBox2Change(Sender: TObject);
    procedure CBCOloreTuboChange(Sender: TObject);
    procedure DBCarattCostruttiveChange(Sender: TObject);
    procedure BarchiviotubiClick(Sender: TObject);
    procedure CbDISPERDITEChange(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure CBCOLOREPARETEChange(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure SpeedButton14Click(Sender: TObject);
    procedure DBEdit41Change(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure DBTipoPontiTermiciChange(Sender: TObject);
    procedure DBELponteChange(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure btnArchivioClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure TabSheet77Enter(Sender: TObject);
    procedure PageControl22Change(Sender: TObject);
    procedure PageControl22Changing(Sender: TObject;
      var AllowChange: Boolean);
    procedure Datidiprogetto1Click(Sender: TObject);
    procedure Pareti1Click(Sender: TObject);
    procedure Finestre1Click(Sender: TObject);
    procedure PontiTermici1Click(Sender: TObject);
    procedure Confini1Click(Sender: TObject);
    procedure Profiliorari1Click(Sender: TObject);
    procedure Zone1Click(Sender: TObject);
    procedure Impianti1Click(Sender: TObject);
    procedure Generatori1Click(Sender: TObject);
    procedure Verifichedileggeart3111Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Nuovo1Click(Sender: TObject);
    procedure DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
    procedure Button15Click(Sender: TObject);
    procedure Salva1Click(Sender: TObject);
    procedure Chiudi1Click(Sender: TObject);
    procedure DBEdit38Change(Sender: TObject);
    procedure Gestionepiani1Click(Sender: TObject);
    procedure Button16Click(Sender: TObject);
    procedure Apri1Click(Sender: TObject);
    procedure SpeedButton19Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure Salvaconnome1Click(Sender: TObject);
    procedure SpeedButton20Click(Sender: TObject);
    procedure SpeedButton18Click(Sender: TObject);
    procedure CBSchelPianiClick(Sender: TObject);
    procedure Button18Click(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button19Click(Sender: TObject);
    procedure Button20Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
    procedure Gestionedegliarchivipersonali1Click(Sender: TObject);
    procedure CBFiltrolocClick(Sender: TObject);
    procedure Intestatariodellicenzaduso1Click(Sender: TObject);
    procedure Ultimoprogetto1Click(Sender: TObject);
    procedure SpeedButton21Click(Sender: TObject);
    procedure PageControl24Change(Sender: TObject);
    procedure CheckBox10Click(Sender: TObject);
    procedure Button22Click(Sender: TObject);
    procedure CBTiporeteChange(Sender: TObject);
    procedure Reti1Click(Sender: TObject);
    procedure CheckBox11Click(Sender: TObject);
    procedure Button23Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure OleContainer1Deactivate(Sender: TObject);
    procedure CBLUCClick(Sender: TObject);
    procedure TrackBar6Change(Sender: TObject);
    procedure PageControl3Change(Sender: TObject);
    procedure Button25Click(Sender: TObject);
    procedure Button24Click(Sender: TObject);
    procedure Edit12Change(Sender: TObject);
    procedure BinserisciClick(Sender: TObject);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure F1Click(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
    procedure DBEdit119Change(Sender: TObject);
    procedure EAlloggioChange(Sender: TObject);
    procedure Button26Click(Sender: TObject);
    procedure Button27Click(Sender: TObject);
    procedure Panel_baseChange(Sender: TObject);
    procedure UpDown1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure Button28Click(Sender: TObject);
    procedure CBSpiraliClick(Sender: TObject);
  private
    { Private declarations }
  public

    procedure CubeProgress(Sender: TObject; const deltaTime,newTime: Double);
    procedure display(ac:boolean);
//    Procedure WndProc(Var TheMsg: TMessage); override;
    Procedure Vis_pezzi_can(nomepr:string;ind:integer);
    Procedure redraw3d;
    procedure Debugcubo(par:Pchar);
    procedure ripristinazoom;

    { Public declarations }
  end;

var
  Form1: TForm1;
  MX,My:integer;
  count:integer;
  countP:integer;
  weel,Xar1,Yar1,zar1,Xar2,Yar2,zar2:real;
  IndPP:integer;
  bloccapannello:boolean=false;
  chiudi_form:boolean=false;
var XPanel:integer=10;
    YPanel:integer=150;
    BloccaRedraw:boolean=true;
    Form_prop:boolean=false;
Procedure Cancellatutto;
Procedure Trackchange;
Procedure Ridisegna;
Procedure Init_Form_3d;


implementation
uses secondario,interfDLL;
//uses GestTiporete;

{$R *.dfm}
Var Prima_v:boolean=true;
Procedure Ridisegna;
begin
exit;
if prima_volta then prima_v:=true;
if not bloccaredraw then
  begin
  prima_volta:=prima_v;
  Redraw(Form1.Image1.Canvas,Form1.Image1,form1.panel2,0,0);
  prima_v:=false;
  end;
end;
Procedure Trackchange;
Var ingra:real;
begin
ingra:=(form1.trackbar1.position)/40*2*ingrbase;
Form1.DCGenerale.Scale.X:=ingra;
Form1.DCGenerale.Scale.y:=ingra;
Form1.DCGenerale.Scale.z:=ingra;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
trackchange;
end;

procedure TForm1.GLSceneViewer1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
if ssright in Shift then
  begin
  cbassi.Checked:=not cbassi.Checked;
  if cbassi.Checked then
  rbscheletro.checked:=true
  else
    begin
    rbscheletro.checked:=false;
    sbnpezzo.Value := pezzosel;
    end;
  end;
 Mx:=x;
 My:=y;
end;

procedure TForm1.ripristinazoom;
begin
trackbar2.Position:=50;
trackbar4.Position:=50;
trackbar5.Position:=50;
trackbar2.Position:=8;
end;
procedure TForm1.GLSceneViewer1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
if ssLeft in Shift then
  begin
// if rbvista.Checked then
    begin
     GLCamera1.MoveAroundTarget(my-y, mx-x);
    end;
   mx:=x;
   my:=y;

// DCLuci.MoveAroundTarget(my-y, mx-x);

  end
else
if cbassi.Checked then
  begin
  trackbar2.position:=round(50+(x-GLSceneViewer1.Width/2)*100/GLSceneViewer1.Width);
  trackbar5.position:=round(50-(y-GLSceneViewer1.height/2)*100/GLSceneViewer1.height);
  { TODO -oDiego -cNavigazione : lavoro quì }
  end;
//if Shift<>[] then GLCamera1.MoveAroundTarget((mx-x)/100,(my-y)/100);
{str(rollangle:4:0,lra.Caption);
lra.caption:='Roll:'+lra.caption;}
end;

procedure TForm1.RBVistaClick(Sender: TObject);
begin
if RBVista.checked then RBLuci.Checked:=false;
end;

procedure TForm1.TrackBar2Change(Sender: TObject);
begin
settaingr;
snapoggetto;
end;

procedure TForm1.TrackBar3Change(Sender: TObject);
begin
glcamera1.FocalLength:=trackbar3.position*10+50;
//if trackbar3.position<=5 then
//glcamera1.FocalLength:=ingrbase*trackbar3.POsition/5
//else glcamera1.FocalLength:=ingrbase+(trackbar3.POsition-5)*ingrbase;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Modicord1        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure ModiCord1(var Cordx,Cordy:real;Dx,Dy,Rot,ing:real);
Var Dist,Ang:real;
begin
if CordY=0 then
  begin
  if Cordx>=0 then ang:=pi/2 else ang:=(3/2)*pi;
  end
else
  begin
  if Cordy>0 then
    begin
    ang:=arctan(Cordx/abs(Cordy));
    end
  else
  ang:=(pi-arctan(Cordx/abs(Cordy)));
  end;
if ang<0 then ang:=2*pi+ang;

Dist:=sqrt(sqr(Cordx)+sqr(Cordy))*ing;
Ang:=Ang+Rot;
CordX:=sin(ang)*Dist+Dx;
Cordy:=Cos(ang)*Dist+Dy;
end;

Procedure Tform1.Display(ac:boolean);
begin
cancellatutto;
//GLCamera1.MoveAroundTarget(-30,-30);
InitVariabili;
//panel1.Visible:=false;
Disegnaedificio(percorsoDrive,ac);
sbnpezzo.MaxValue:=Nogg;
sbnpezzo.MinValue:=1;
(*
assignfile(f3d,'C:\sd\progettoprova\completo prova\Work_esempio piccolo\disegno.3dm');
reset(f3d);
while not eof(f3d) do
begin
read(f3d,buf3d);
with buf3d do
  case Entita[1] of
  'B':begin
      xx1:=-par[3]/2;
      YY1:=0;
      modicord1(xx1,yy1,XCOR,YCOR,R1,1);
      xx2:=par[3]/2;
      YY2:=0;
      modicord1(xx2,yy2,XCOR,YCOR,R1,1);
      //PareteSemp(0,xx1,yy1,xx2,yy2,Par[1],par[2],'');
      end;
  'T':begin
      xcor:=par[1];
      ycor:=par[2];
      zcor:=par[3];
      p.x:=xcor;
      p.y:=ycor;
      p.z:=zcor;
      end;
  'R':begin
      r1:=par[1]+PI/2;
      r2:=par[2];
      r3:=par[3];
      end;
   'V':curvaret(par[1],par[2],par[3],par[4],par[5]);
  //else PareteSemp(-10,1,-9,1,0.1,5);
  end;
end;
closefile(f3d);
*)
settaIngr;
aggiornasecondario;
ult_cubo:=nil;
//if tag=1 then button5.Visible:=true
//else initRec;
end;
procedure Tform1.Debugcubo(par:Pchar);
var ss,col:string;
var xl1,yl1,zl1,xl2,yl2,zl2:real;
begin
ss:=strpas(par);
azzeraidentif;
xl1:=str_tofloat(leggiidentif1(ss));
yl1:=str_tofloat(leggiidentif1(ss));
zl1:=str_tofloat(leggiidentif1(ss));
xl2:=str_tofloat(leggiidentif1(ss));
yl2:=str_tofloat(leggiidentif1(ss));
zl2:=str_tofloat(leggiidentif1(ss));
if ult_cubo<>nil then ult_cubo.Free;
Linea(xl1,yl1,zl1,xl2,yl2,zl2,0.07,crosso);
end;
procedure TForm1.Redraw3d;
Var xcor,ycor,zcor,acor,bcor,hcor,r1,r2,r3,xx1,yy1,xx2,yy2:real;
begin
display(false);
//if form1.CBAGG3D.Checked then display(false);
end;

procedure TForm1.GLSceneViewer1DblClick(Sender: TObject);
begin
if not doppioclick then exit;
if panel_base.Visible then
  begin
  panel_base.Visible:=false;
  //panel29.Visible:=false;
  end
else
  begin
  panel_base.Visible:=true;
  //panel29.Visible:=true;
  end
end;

procedure TForm1.CubeProgress(Sender: TObject; const deltaTime,
  newTime: Double);

Var obj:TglBasesceneobject;
begin
end;

procedure TForm1.TrackBar4Change(Sender: TObject);
begin
settaingr;
snapoggetto;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
Var conferma:integer;
begin
if primoavvio then
    begin
    //chiudisecondario;
    action:=cafree;
    exit;
    end;
if comando_acad then  //form filtrata (nord piani 3d)
  begin
  hide;
  if sottoform then mempos:=false;
  Button14Click(nil);
  mempos:=true;
  action:=canone;
  timer1.enabled:=true;
  sottoform:=false;
  //if riapri then
  show;
  exit;
  end;
if dllbm then
  begin
  nocambia:=true;
  SalvaPOsform;
  if chiudi_form then
    begin
    action:=cafree;
    end
  else action:=cahide;
  end
else
  begin

  if edit_in_Cad then
  conferma:=chiediconferma('E'' corretto chiudere projectbrowser dalla apposita icona della toolbar di autocad ,in caso contrario le modifiche realizzate nel CAD non verranno salvate , volete uscire comunque')
  else conferma:=1;
  if conferma=1 then
    begin
    conferma:=chiediconferma('Volete salvare le modifiche');
    if conferma<>0 then
      begin
      //Piano_precedente:=pianocor;
      salvapiano_precedente(false);
      //CloseComunicazione();
      if conferma=1 then
        begin
        Salvaprogetto(false);
        SalvaPOsform;
        end;
      chiudisecondario;
      action:=cafree;
      end
    else action:=canone;
    end
  else action:=canone;
  end;
//SalvaPOsa;  
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
//form1:=nil;
end;
Procedure Cancellatutto;
begin
form1.DCOggetti.DeleteChildren;
end;
procedure TForm1.RBscheletroClick(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if CheckBox1.checked then formstyle:=fsStayOnTop
else formstyle:=fsNormal;
panel_base.Visible:=false;
end;

procedure TForm1.CBLocaleChange(Sender: TObject);
begin
Display(false);
cbschelpiani.SetFocus;
end;

procedure TForm1.CB_RetiClick(Sender: TObject);
begin
  Display(false);
end;

procedure TForm1.CBdentroClick(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.CbAssiClick(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.CBVetriClick(Sender: TObject);
begin
//Display(false);
end;
 (*
procedure TForm1.WndProc(var TheMsg: TMessage);
//        Ricezione dell'eventuale del valore da parte del programma chiamante
Var
     ExternalString: String;
begin

     if (aCommunique <> nil) then
          case aCommunique.CommWndProc(TheMsg, ExternalString) of
               wpString :
               begin
                    PercorsoDrive := ExternalString;
                    Display(False);
               end;
               {
               wpClose  :
                    Close;    //  Chiudo il programma chiamato
               }
          end;

     Inherited WndProc(TheMsg);
end;
  *)
procedure TForm1.FormShow(Sender: TObject);
begin
//Form1.Panel_base.ActivePageIndex:=0;
// CreazioneOggettoComunicazioneC();
end;

procedure TForm1.CBHmediaClick(Sender: TObject);
begin
Display(false);
end;

Type Tsalvaconf=record
                scheletro:boolean;
                Distanza,posx,posy,posz:integer;
                end;
Var  Fsalvaconf:file of Tsalvaconf;
     BSalvaconf:TSalvaconf;
const Nomesalvaconf='conf3d.cnf';
procedure TForm1.BSalvaClick(Sender: TObject);
begin
with bsalvaconf do
  begin
  scheletro:=rbscheletro.Checked;
  Distanza:=trackbar1.position;
  posx:=trackbar2.position;
  posy:=trackbar4.position;
  posz:=trackbar5.position;
  end;
assignfile(Fsalvaconf,Nomesalvaconf);
rewrite(Fsalvaconf);
write(Fsalvaconf,Bsalvaconf);
Closefile(Fsalvaconf);
end;

procedure TForm1.BRichiamaClick(Sender: TObject);
begin
if not (fileexists(nomesalvaconf)) then exit;
assignfile(Fsalvaconf,Nomesalvaconf);
reset(Fsalvaconf);
read(Fsalvaconf,Bsalvaconf);
Closefile(Fsalvaconf);
with bsalvaconf do
  begin
  rbscheletro.Checked:=scheletro;
  trackbar1.position:=Distanza;
  trackbar2.position:=posx;
  trackbar4.position:=posy;
  trackbar5.position:=posz;
  end;
end;

procedure TForm1.test1Change(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.EpezzoChange(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.SBNPezzoChange(Sender: TObject);
begin
pezzosel:=sbnpezzo.value;
Display(false);
if (sbnpezzo.value<=Nogg)and(sbnpezzo.value>0) then
with Listaogg_D^[sbnpezzo.value]^ do
Vis_pezzi_can(prog,ind);
end;

procedure TForm1.CBTUTTILOCALIClick(Sender: TObject);
begin
Cblocale.Clear;
Display(false);
end;

Function XGraf(mpX:integer):Integer;
begin
result:=round(Mpx-form1.left-Xpanel);
end;
Function YGraf(mpY:integer):Integer;
begin
result:=round(MpY-form1.Top-Ypanel);
end;
procedure TForm1.FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
//memo1.SetFocus;
//if (mousepos.X<tabsheet15.Left+tabsheet15.Width)and
if pagecontrol4.ActivePageIndex=0 then
  begin
  if cbassi.Checked then
    begin
    glsceneviewer1.SetFocus;
    weel:=weel+0.3;
    trackbar4.Position:=round(weel);
    end
  else trackbar1.Position:=trackbar1.Position+1;
  end
else
  begin
  ing_zoom_in:=1.05;
  Zoom_in(mousepos.X-form1.left-Xpanel,mousepos.y-form1.top-Ypanel,panel2.Width,Panel2.Height);
  ridisegna;
  end;
end;

procedure TForm1.FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
  MousePos: TPoint; var Handled: Boolean);
begin
//memo1.SetFocus;
if pagecontrol4.ActivePageIndex=0 then
  begin
  if cbassi.Checked then
    begin
    glsceneviewer1.SetFocus;
    weel:=weel-0.3;
    trackbar4.Position:=round(weel);
    end
  else trackbar1.Position:=trackbar1.Position-1;
  end
else
  begin
  ing_zoom_in:=0.95;
  Zoom_in(mousepos.X-form1.left-Xpanel,mousepos.y-form1.top-Ypanel,panel2.Width,Panel2.Height);
  ridisegna;
  end;
end;

Procedure Init_Form_3d;
var tt:string;
    ff:textfile;
begin
weel:=250;
//try
InitPannelloclima;
{
except
closeudbt;
showmessage('Il file temporanei del progetto corrente sono danneggiati, ricaricare il progetto');
tt:=percorso_progetti;
assignfile(ff,I_sl(tt)+'Orari.db');
erase(ff);
InitPannelloclima;
end;
}
end;

procedure TForm1.FormCreate(Sender: TObject);
Var agg:boolean;
begin
{$IfNdef DLLBM}
Init_form_3d;
{$Endif}
end;

Procedure TForm1.Vis_pezzi_can(nomepr:string;ind:integer);
type
      recpezzi=record
                X1Ar,Y1Ar,Z1Ar,X2Ar,Y2Ar,Z2Ar:real;
                indpezzo:integer;
                CODP:String[10];
                Codice:string[5];
                R,A,B:real;
                Flag:string[1];
                Lung:real;
                Ang,Rag,Perd,port,varie:real;
              end;
Var bufpezzi:Recpezzi;
    count:integer;
    Fp3d:file of Recpezzi;
    Dim1:real;
    tt:string;
begin
nomepr:=IncludeTrailingPathDelimiter(percorsoDrive) + copy(Nomepr,1,length(nomepr)-3)+'p3d';
if fileexists(nomepr) then
with Bufpezzi do
  begin
  tt:=extractfilename(Nomepr);
  Form1.gbcanali.Caption:='Rete: '+copy(tt,1,length(tt)-4);
  Form1.LBArchivio.Visible:=true;
  Form1.LBmodifica.Visible:=true;
  assignfile(Fp3d,nomepr);
  reset(fp3d);
  count:=0;
  while not(eof(Fp3d))and(count<ind) do
    begin
    read(Fp3d,bufpezzi);
    inc(count);
    end;
  closefile(fp3d);
  Form1.Panel_base.ActivePageIndex:=3;
  //tronco_sel:=item;
  //Form1.LIndicepezzo.caption:=' ( pezzo:'+inttostr(ind)+' )';
  Xar1:=X1ar;
  Yar1:=Y1ar;
  zar1:=z1ar;
  Xar2:=X2ar;
  Yar2:=Y2ar;
  zar2:=z2ar;
  IndPP:=Indpezzo;
  //sbnpezzo.Value:=indpp;
  Form1.ECodiceCan.text:=codP;
  Form1.EACan.text:=Float_to_str(A,0);
  Form1.EBCan.text:=Float_to_str(B,0);
  if b<> 0 then
    begin
    Form1.leq.visible:=true;
    Form1.ERCan.readonly:=true;
    end
  else
    begin
    Form1.leq.visible:=false;
    Form1.ERCan.readonly:=false;
    end;
  Form1.ERCan.text:=Float_to_str(R,0);
  if a<>0 then dim1:=A else dim1:=R;
  if R<>0 then
    begin
    Form1.LURaggioCan.visible:=true;
    Form1.LRaggioCan.visible:=true;
    Form1.ERagCan.visible:=true;
    Form1.ERagCan.text:=Float_to_str(Rag*dim1-dim1/2,0)
    end
  else
    begin
    Form1.LURaggioCan.visible:=false;
    Form1.LRaggioCan.visible:=false;
    Form1.ERagCan.visible:=false;
    Form1.ERagCan.text:='';
    end;
  Form1.ELungCan.text:=Float_to_str(Lung,2);
  Form1.EPerdCan.text:=Float_to_str(Perd,1);
  Form1.EPOrtCan.text:=Float_to_str(Port,2);
  if  flag='*' then Form1.CBFISSA.ItemIndex:=2
  else Form1.CBFISSA.ItemIndex:=0;
  { TODO -oDiego -cNavigazione : lavoro qui visualizza dati pezzo }
  end;
end;

procedure TForm1.LBArchivioClick(Sender: TObject);
Var codin:Pchar;
begin
{$Ifdef Canali_14}
codin:=Pchar(ecodicecan.text);
settacodice(codin);
ecodicecan.text:=strpas(codin);
{$endif}
end;

procedure TForm1.LBModificaClick(Sender: TObject);
var tt:string;
begin
{$Ifdef Canali_14}
tt:=listaOgg_d^[pezzosel]^.prog;
inc(Nupdate);
new(update_d^[Nupdate]);
with update_d^[Nupdate]^ do
  begin
  indpezzo:=indpp;
  xa1:=xar1;
  ya1:=yar1;
  za1:=zar1;
  xa2:=xar2;
  ya2:=yar2;
  za2:=zar2;
  codp:=Ecodicecan.Text;
  Prog:=copy(tt,1,length(tt)-4);
  end;
if CBFissa.ItemIndex>0 then
  begin
  inc(Nupdate);
  new(update_d^[Nupdate]);
  with update_d^[Nupdate]^ do
    begin
    indpezzo:=indpp;
    xa1:=xar1;
    ya1:=yar1;
    za1:=zar1;
    xa2:=xar2;
    ya2:=yar2;
    za2:=zar2;
    codp:='F'+inttostr(CBFissa.ItemIndex)+':'+EaCan.Text+':'+EBCan.Text+':'+ERCan.Text+':';
    Prog:=copy(tt,1,length(tt)-4);
  end;
  end;
Salva_Update(dm1.tt1,dm1.tt3,dm1.datasource1);
if pezzosel <>0 then
  begin
  Calcola_reti(Percorsodrive,copy(tt,1,length(tt)-4));
  display(false);
  end;
{$endif}
end;

procedure TForm1.LbAggiornaCanaliClick(Sender: TObject);
begin
{$Ifdef Canali_14}
Calcola_reti(Percorsodrive,'');
display(false);
{$endif}
end;

procedure TForm1.SpeedButton1Click(Sender: TObject);
begin
if not edit_in_cad then
PassaAlCad;
Esegui_autocad(false);
end;

procedure TForm1.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
ridisegna;
end;
procedure TForm1.SpeedButton7Click(Sender: TObject);
begin
ArchivioPareti;
end;

procedure TForm1.DBTipoPareteChange(Sender: TObject);
begin
Cambiatipopar;
cbTlinea.SetFocus;
end;

procedure TForm1.SpeedButton6Click(Sender: TObject);
begin
EseguiMenuDll('ARCHIVIOFINESTRE');
//EseguiMenu('ARCHIVIOFINESTRE');  // Esegue gli archivi pareti
compilaform(form1.gbfinestre,'ConfCad',dmtutti.ds_confcad);
script_Finestra;
end;

procedure TForm1.DBTipoFinestraChange(Sender: TObject);
begin
CambiatipoF;
end;

procedure TForm1.SpeedButton3Click(Sender: TObject);
begin
//ArchivioConfini;

if Pagecontrol4.Visible then
PassaAlCad;
Esegui_autocad(true);
end;

procedure TForm1.DBConfinePareteChange(Sender: TObject);
begin
cambiaconfine;
cbTlinea.SetFocus;
end;

procedure TForm1.CBTlineaChange(Sender: TObject);
begin
CambiaTlinea;
end;

procedure TForm1.Panel2CanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
prima_volta:=true;
end;

procedure TForm1.DBComboBox1Change(Sender: TObject);
begin
CambiaPiano;
end;

procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
if button=mbleft then
  begin
  itemseledif:=0;
  edit12.Text:='';
  itemseledif_C:=0;
  puntosel:=true;
  Redraw(Form1.Image1.Canvas,Form1.Image1,form1.panel2,X,Y);
  puntosel:=false;
  if (form1.checkbox3).Checked and (form1.RadioButton2.Checked) then //per disegnare tutto il tronco
  Redraw(Form1.Image1.Canvas,Form1.Image1,form1.panel2,0,0);
  end;
if button=mbright then
  begin
  prima_volta:=true;
  ItemSelEdif:=0;
  edit12.Text:='';
  ridisegna;
  end;

if button=mbMiddle then
  begin
  //impan.left:=X-12;
  //impan.top:=Y+61;
  //impan.Visible:=true;
  Pan_On(X,Y);
  end;
end;
procedure  setcblocale(codamb:string);
Var i:integer;
begin
with form1.CBLocale do
  begin
  i:=0;
  while (i< Items.Count) and (uppercase(codamb)<>uppercase(items[i])) do inc(i);
  form1.CBLocale.itemindex:=i;
  form1.display(false);
  end;
end;


procedure TForm1.DBGrid1CellClick(Column: TColumn);
begin
setcblocale(v_recAmb.CodNum ) ;
Form1.cblocale.itemindex:=3;
form1.PageControl4.ActivePageIndex:=0;
end;

procedure TForm1.PageControl8Change(Sender: TObject);
begin
Compilamemolocali;
end;

procedure TForm1.PageControl4Change(Sender: TObject);
begin
groupbox1.Visible:=PageControl4.ActivePageIndex=0;
if (edit12.Text<>'')or (not agg_3d) then
  begin
  agg_3d:=true;
  display(true);
  end;
Compilamemolocali;
end;


procedure TForm1.RadioButton1Click(Sender: TObject);
begin
Salvapiano_precedente(true);
vis_input:=radiobutton1.Checked;
Apri_piano;
ridisegna;
pagecontrol4.activepageindex:=1;
if RadioButton1.Checked then button16.visible:=true//button16.Caption:='Conferma modifiche'
else button16.visible:=false//button16.Caption:='Dettagli';
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
Nuovo_Progetto(true);
Salvaprogetto(false);
end;

procedure TForm1.ListBox1Click(Sender: TObject);
begin
//DettaglioErrore;
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
Salvaprogetto(false);
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
Salvaprogetto(True);
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
nocambia:=true;
Apri_progetto('',false);
nocambia:=false;
end;

procedure TForm1.LbButton2Click(Sender: TObject);
begin
modificapercorsodxf;
end;

procedure TForm1.LbButton3Click(Sender: TObject);
begin
EsportaDXF;
end;

procedure TForm1.Button1Click(Sender: TObject);
Var i,J:integer;
begin
Leggi_Entita(dmtutti.T_Entita,dmtutti.T_Attributi,dmtutti.ds_Entita);
with memo3.Lines do
  begin
  clear;
  for i:=1 to nentita do
  with entita_D^[i]^ do
    begin
    add('Cod:'+cod);
    end;
  end;
end;

procedure TForm1.LbButton4Click(Sender: TObject);
begin
InportaDxf(true,false,false);
end;

procedure TForm1.PageControl2Change(Sender: TObject);
begin
//compilaform(form1.gblocali,'ConfCad',dmtutti.ds_confcad);
scriptoggetto;
end;

procedure TForm1.DBTipoZonaChange(Sender: TObject);
begin
cambia_zona;
end;

procedure TForm1.LbButton6Click(Sender: TObject);
begin
CaricaPiantasfondo;
end;

procedure TForm1.SpeedButton4Click(Sender: TObject);
begin
EseguiMenuDll('PIANI3D');
end;

procedure TForm1.PageControl1Change(Sender: TObject);
begin
compila_form_pannello;
tubi_edif(2);
scriptoggetto;
end;

procedure TForm1.SpeedButton5Click(Sender: TObject);
begin
Pagecontrol1.ActivePageIndex:=2;
Pagecontrol3.ActivePageIndex:=0;
end;

procedure TForm1.PageControl1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
if edit_in_Cad then
  begin
  allowchange:=false;
  showmessage('Operazioni non abilitate quando il disegno è in editazione nel CAD esterno');
  end;
end;

procedure TForm1.DBNavigator3Click(Sender: TObject; Button: TNavigateBtn);
begin
Compila_form_pannello_locale;
end;

procedure TForm1.DBNavigator4Click(Sender: TObject; Button: TNavigateBtn);
begin
Compila_form_pannello_locale;
end;

procedure TForm1.LbButton7Click(Sender: TObject);
begin
aggiorna_dati(pagecontrol2.ActivePageIndex);
end;

procedure TForm1.LbButton8Click(Sender: TObject);
begin
Aggiorna_tutto;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
Aggiorna_tutto;
end;

procedure TForm1.CheckBox5Click(Sender: TObject);
begin
if CheckBox5.checked then
  begin
  checkbox4.Visible:=false;
  CheckBox5.caption:='Incolla da '+label182.Caption;
  end
else
  begin
  CheckBox5.caption:='Incolla dati su';
  checkbox4.Visible:=true;
  end;
end;

procedure TForm1.DBComboBox2Change(Sender: TObject);
begin
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
caricadis_Tubi;
form1.checkbox3.Checked;
dmtutti.T_ConfCad.Edit;
end;

procedure TForm1.CBCOloreTuboChange(Sender: TObject);
begin
if nocambia then exit;
cambiacoloretubo;
end;

procedure TForm1.DBCarattCostruttiveChange(Sender: TObject);
begin
if nocambia then exit;
cambiatipotubo;
script_Tubo;
scriptOggetto;
end;

procedure TForm1.BarchiviotubiClick(Sender: TObject);
begin
EseguiMenuDLL('TIPIRETE');
//EseguiMenu('TIPIRETE');
end;

procedure TForm1.CbDISPERDITEChange(Sender: TObject);
begin
if nocambia then exit;
Script_Terminale;
ScriptOggetto;
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
EseguiMenu('ESTIVO'); 
end;

procedure TForm1.SpeedButton15Click(Sender: TObject);
begin
EseguiMenuDLL('ZONE');
compilaform(form1.gblocali,'ConfCad',dmtutti.ds_confcad);
//EseguiMenu('ZONE');
script_Locale;
end;

procedure TForm1.SpeedButton16Click(Sender: TObject);
begin
EseguiMenuDLL('IMPIANTI');
compilaform(form1.gblocali,'ConfCad',dmtutti.ds_confcad);
//EseguiMenu('IMPIANTI');
script_Locale;
end;

procedure TForm1.CBCOLOREPARETEChange(Sender: TObject);
begin
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.post;
CambiaColoreParete;
dmtutti.T_ConfCad.Edit;
cbTlinea.SetFocus;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
//calcolo_L10;
end;

procedure TForm1.SpeedButton14Click(Sender: TObject);
begin
//Consiglio;
end;

procedure TForm1.DBEdit41Change(Sender: TObject);
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.post;
direznord:=V_recconfcad.AngNord;
//pagecontrol4.ActivePageIndex:=1;
ridisegna;
dmtutti.T_ConfCad.Edit;
end;

procedure TForm1.SpeedButton8Click(Sender: TObject);
begin
EseguiMenuDLL('PONTI');  // Esegue gli archivi pareti
//EseguiMenu('PONTI');  // Esegue gli archivi pareti
compilaform(form1.gbPONTITERMICI,'ConfCad',dmtutti.ds_confcad);
script_Ponte;
end;

procedure TForm1.DBTipoPontiTermiciChange(Sender: TObject);
begin
CambiaPOnte;
end;

procedure TForm1.DBELponteChange(Sender: TObject);
begin
CambiaLponte;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
begin
itemMenu('STAMPE');
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
EseguiMenuDLL('ARCHIVIOFINESTRE');  // Esegue gli archivi pareti
//EseguiMenu('ARCHIVIOFINESTRE');  // Esegue gli archivi pareti
compilaGriglia(form1.dbgFinsemp,'Finestre',dmtutti.ds_Finestre);
end;

procedure TForm1.Button9Click(Sender: TObject);
begin
//CalcoloSemp;
end;

procedure TForm1.btnArchivioClick(Sender: TObject);
begin
//Sceglicomune;
end;

procedure TForm1.Button10Click(Sender: TObject);
begin
EseguiMenuDLL('ARCHIVIOPARETI');  // Esegue gli archivi pareti
//EseguiMenu('ARCHIVIOPARETI');  // Esegue gli archivi pareti
end;

procedure TForm1.Stampa1Click(Sender: TObject);
var ret:Integer;
begin
if usadll then
EseguiMenuDll('STAMPA')
else
  begin
  if not CBVersBM.Checked then
    begin
    //EseguiMenuDll('CALCOLOL10');
    geststampe3d(perc_progcor,cliente);
    end
  else
    begin
    Vai_bm;
    Item_menu('STAMPA');
    ritorna_sd;
    end;
  exit;
  //ret:=winexec(Pchar('"'+ i_sl(Percorsodrive) + 'eseguistampe.exe"'),SW_Normal);
  nocambia:=true;
  closeUdbt;
  ret:=winexec(Pchar('"'+ i_sl(Percorsodrive) + 'eseguistampe.exe"'),SW_Normal);
  OpenUdbT;
  nocambia:=false;
  end;
end;

procedure TForm1.TabSheet77Enter(Sender: TObject);
begin
AggiornaTabcolori;
end;

procedure TForm1.PageControl22Change(Sender: TObject);
begin
AggiornaTabcolori;
end;

procedure TForm1.PageControl22Changing(Sender: TObject;
  var AllowChange: Boolean);
Var   err:string;
begin
{
AllowChange:=true;
err:=VerificaDoppionicolori((sender as tdbcombobox).Text);
if err<>'' then
  begin
  showmessage(err);
  AllowChange:=false;
  end
else AggiornaTabcolori;
}
end;

procedure TForm1.Datidiprogetto1Click(Sender: TObject);
begin
if form1.CBVERSBM.Checked then  EseguiMenuDll('FABBRICATO')
else GestEdificio3D;
end;

procedure TForm1.Pareti1Click(Sender: TObject);
begin
EseguiMenuDll('ARCHIVIOPARETI');
AggiornaTabcolori;
end;

procedure TForm1.Finestre1Click(Sender: TObject);
begin
EseguiMenuDll('ARCHIVIOFINESTRE');
end;

procedure TForm1.PontiTermici1Click(Sender: TObject);
begin
EseguiMenuDll('PONTI');
end;

procedure TForm1.Confini1Click(Sender: TObject);
begin
EseguiMenuDll('CONFINE');
AggiornaTabConfini;
end;

procedure TForm1.Profiliorari1Click(Sender: TObject);
begin
EseguiMenuDll('ORARI');
end;

procedure TForm1.Zone1Click(Sender: TObject);
begin
EseguiMenuDll('ZONE');
end;

procedure TForm1.Impianti1Click(Sender: TObject);
begin
EseguiMenuDll('IMPIANTI');
end;

procedure TForm1.Generatori1Click(Sender: TObject);
begin
EseguiMenuDll('GENERATORI');
end;

procedure TForm1.Verifichedileggeart3111Click(Sender: TObject);
begin
nocambia:=true;
EseguiMenuDll('CALCOLOL10');
nocambia:=false;
end;

procedure TForm1.SpeedButton2Click(Sender: TObject);
begin
PassaAlCad
end;

procedure TForm1.SpeedButton9Click(Sender: TObject);
begin
Gestconfineparete;
end;

procedure TForm1.Button14Click(Sender: TObject);
Var Pdis,rete:string;
begin
if riapri then
  begin
  rete:='';
  if form1.PageControl24.ActivePageIndex=1 then
  rete:=V_recconfcad.ColoreTipoReteIRR+'§';
  Pdis:=I_sl(Perc_progcor)+rete+V_recconfcad.PIANOCOR+'.dxf';
  Salva_var('DISEGNOCORRENTE',Pdis);
  PassaAlCad;
  end
else
  begin
  cercapiano;
  dmtutti.T_Piani.Edit;
  V_recpia.set_AllineaX(ultspox);
  V_recpia.set_Allineay(ultspoy);
  dmtutti.T_Piani.POst;
  dmtutti.T_Piani.Edit;
  formpannello;
  edit_in_cad:=true;
  startaggiorna;
  end;
PageControl1.visible:=true;
PageControl2.Tabheight:=0;
PageControl2.Tabwidth:=0;
panel28.Visible:=false;
if riapri then
  begin
  //copyfile(Pchar(i_sl(percorsodrive)+'disegno.dxf'),pchar(Pdis),false);
  visualizza_disegno(Pdis);
  end
else
  Begin
  dmtutti.T_ConfCad.edit;
  v_recconfcad.Set_PIANOCOR(oldpianocor);
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.edit;
  end;

end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
{$IFNDEF DLLBM}
agg_visual:=true;
Aggiorna3D;
agg_visual:=false;
{$ENDIF}
end;

procedure TForm1.Nuovo1Click(Sender: TObject);
begin
Nuovo_Progetto(true);
Salvaprogetto(false);
//pagecontrol4.ActivePageIndex:=1;
end;

procedure TForm1.DBNavigator2Click(Sender: TObject; Button: TNavigateBtn);
begin
nocambia:=true;
compilaform(form1.groupbox2,'ConfCad',dmtutti.ds_confcad);
SalvaPiano(form1.DBCombobox1.text,form1.RadioButton1.Checked,true);
if V_recPia.Cod<>'' then
  begin
  dmtutti.T_ConfCad.Edit;
  V_RecConfcad.Set_PIANOCOR(V_recPia.Cod);
  dmtutti.T_ConfCad.Post;
  end;
Apripiano(form1.RadioButton1.Checked,form1.DBCombobox1.text);
ridisegna;
nocambia:=false;
end;

procedure TForm1.Button15Click(Sender: TObject);
begin
CaricaPiantasfondo;
end;

procedure TForm1.Salva1Click(Sender: TObject);
begin
Salvaprogetto(false);
end;

procedure TForm1.Chiudi1Click(Sender: TObject);
begin
close;
end;

procedure TForm1.DBEdit38Change(Sender: TObject);
begin
statictext1.Caption:=float_to_Str(V_recAmb.Superficie*V_recAmb.HSoffitto,1);
end;

procedure TForm1.Gestionepiani1Click(Sender: TObject);
begin
EseguiMenuDll('PIANI3D');
end;

procedure TForm1.Button16Click(Sender: TObject);
begin
if uppercase(Button16.caption)='DISEGNA' then
  begin
  nocambia:=true; //??
  {$ifNdef dllbm}
  Aggiornascript('');
  {$Endif}
  nocambia:=true;
  close;
  exit;
  end;
if Piani_simili(V_recconfcad.PIANOCOR)<>'' then exit;
aggiorna_dati(pagecontrol2.ActivePageIndex);
end;

procedure TForm1.Apri1Click(Sender: TObject);
begin
nocambia:=true;
if Apri_progetto('',false)then
  begin
  nocambia:=false;
  Aggiorna_liberi;
  end
else  nocambia:=false;
end;

procedure TForm1.SpeedButton19Click(Sender: TObject);
begin
ArchivioPareti;
end;

procedure TForm1.SpeedButton17Click(Sender: TObject);
begin
ArchivioPareti;
end;
procedure TForm1.Salvaconnome1Click(Sender: TObject);
begin
Salvaprogetto(true);
end;

procedure TForm1.SpeedButton20Click(Sender: TObject);
begin
//ArchivioConfini;
Gest_Falde3d;
end;

procedure TForm1.SpeedButton18Click(Sender: TObject);
begin
Gest_Pavim3d;
end;

procedure TForm1.CBSchelPianiClick(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.Button18Click(Sender: TObject);
begin
dmtutti.T_Confcad.edit;
V_Recconfcad.Set_DescrAmb('-');
dmtutti.T_Confcad.post;
//edit9.Text:='-';
Button16Click(nil);
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
impan.Visible:=false;
Pan_OFF(x,y);
end;

procedure TForm1.Button19Click(Sender: TObject);
begin
Progress_3d(-2,'');
//Aggiorna_tutto;
//Puliscilocali(true);
redraw3d;
Progress_3d(-1,'');
pagecontrol4.activepageindex:=0;
end;

procedure TForm1.Button20Click(Sender: TObject);
begin
cblocale.ItemIndex:=-1;
display(false);
end;

procedure TForm1.Button21Click(Sender: TObject);
begin
CbPiano.Clear;
Display(false);
end;

procedure TForm1.Gestionedegliarchivipersonali1Click(Sender: TObject);
begin
//salva_var('Percorso_archivi_personali','');
//Percorso_archivi_personali_in;
Vis_percorso_archivi_pers;
end;

procedure TForm1.CBFiltrolocClick(Sender: TObject);
begin
display(false);
end;

procedure TForm1.Intestatariodellicenzaduso1Click(Sender: TObject);
begin
GestDatilicenza;
end;

procedure TForm1.Ultimoprogetto1Click(Sender: TObject);
begin
nocambia:=true;
Apri_progetto(leggi_var('ULTIMOPROGETTO'),false);
nocambia:=false;
Aggiorna_liberi;
end;

procedure TForm1.SpeedButton21Click(Sender: TObject);
begin
Gest_reti3d;
end;

procedure TForm1.PageControl24Change(Sender: TObject);
begin
itemseledif:=0;
edit12.Text:='';
itemseledif_C:=0;
itemselreti:=0;
Tubi_edif(1);
ridisegna;
end;

procedure TForm1.CheckBox10Click(Sender: TObject);
begin
if CheckBox10.checked then
  begin
  dmtutti.T_Reti.First;
  if V_Recgen.Codice='' then
    begin
    Gest_reti3d;
    dmtutti.T_Reti.First;
    if V_Recgen.Codice='' then
      begin
      CheckBox10.checked:=false;
      exit;
      end;
    end;
  dbcombobox32.visible:=true;
  SpeedButton23.Visible:=true;
  Pagecontrol24.ActivePageIndex:=1;
  end
else
  begin
  SpeedButton23.Visible:=false;
  dbcombobox32.visible:=False;
  Pagecontrol24.ActivePageIndex:=0;
  end;
end;

procedure TForm1.Button22Click(Sender: TObject);
begin
Vis_pareti(V_Recconfcad.DescrAmb,V_Recconfcad.PIANOCOR);
end;

procedure TForm1.CBTiporeteChange(Sender: TObject);
begin
Script_Gestrete;
end;

procedure TForm1.Reti1Click(Sender: TObject);
begin
//Aggiorna_Calc_reti; in sospeso
//Gest_Reti3d;
end;

procedure TForm1.CheckBox11Click(Sender: TObject);
begin
radiobutton2.Checked:=CheckBox11.checked;
radiobutton1.Checked:=not(CheckBox11.checked);
end;

procedure TForm1.Button23Click(Sender: TObject);
begin
Gest_trattirete3d;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
if (edit_in_cad)and(not dllbm) then Posiz_prop;
bloccaredraw:=false;
ridisegna;
end;

procedure TForm1.FormDeactivate(Sender: TObject);
begin
bloccaredraw:=true;
end;

procedure TForm1.OleContainer1Deactivate(Sender: TObject);
begin
showmessage('chiusura');
end;

procedure TForm1.CBLUCClick(Sender: TObject);
begin
script_finestra;
end;

procedure TForm1.TrackBar6Change(Sender: TObject);
begin
display(false);
end;

procedure TForm1.PageControl3Change(Sender: TObject);
begin
scriptoggetto;
end;

procedure TForm1.Button25Click(Sender: TObject);
begin
fsecondario.close;
end;

procedure TForm1.Button24Click(Sender: TObject);
begin
Salva_var('SECONDARIO','TRUE');
Salva_var('POSTOP3D','');
Salva_var('POSLeft3D','');
Salva_var('POSWidth3D','');
Salva_var('POSHeight3D','');
aggiornasecondario;
end;

procedure TForm1.Edit12Change(Sender: TObject);
begin
if (cbfiltroloc.checked)and(attivosecondario) then display(true);
end;

procedure TForm1.BinserisciClick(Sender: TObject);
begin
close;
end;

procedure TForm1.LbSpeedButton1Click(Sender: TObject);
Var progsel,perc:string;
begin
perc:=leggi_var('CARTELLAPROGETTI');
perc:=i_sl(perc);
if caption='Creazione di un nuovo progetto' then
  begin
  progsel:=perc+ednome.Text+'\'+ednome.Text+'.bmt';
  if fileexists(progsel) then
  showmessage('Esiste già un progetto con questo nome')
  else
    begin
    if not createdir(perc+ednome.Text)
    then showmessage('Errore nella creazione della cartella')
    else
      begin
      Setta_progetto(progsel);
      nuovo_progetto(true);
      close;
      end;
    end;
  end
else
  begin
  if  listbox2.ItemIndex<0 then showmessage('Selezionare un progetto dalla lista')
  else
  //showmessage(listbox2.Items[listbox2.ItemIndex]);
  progsel:=perc+listbox2.Items[listbox2.ItemIndex]+'\'+listbox2.Items[listbox2.ItemIndex]+'.bmt';
  nocambia:=true;
  Apri_progetto(progsel,false);
  close;
  end;
end;

procedure TForm1.SpeedButton22Click(Sender: TObject);
Var perc:string;
begin
perc:=selezionadir('Cartella base per l''archiviazione');
if existdir(perc) then
  begin
  Salva_var('CARTELLAPROGETTI',perc);
  label395.Caption:=perc;
  Listaprogetti(listbox2);
  end;
end;

procedure TForm1.LbSpeedButton2Click(Sender: TObject);
begin
if  LbSpeedButton2.caption='Esegui calcoli'  then Verifichedileggeart3111Click(nil)
else Stampa1Click(nil);
end;

procedure TForm1.F1Click(Sender: TObject);
begin
Gest_Carburanti3d;
end;

procedure TForm1.LbSpeedButton3Click(Sender: TObject);
begin
Gest_reti3d;
end;

procedure TForm1.DBEdit119Change(Sender: TObject);
begin
script_locale;
end;

procedure TForm1.EAlloggioChange(Sender: TObject);
begin
Script_locale;
end;

procedure TForm1.Button26Click(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.Button27Click(Sender: TObject);
begin
ripristinazoom;
display(false);
end;

procedure TForm1.Panel_baseChange(Sender: TObject);
begin
Display(false);
end;

procedure TForm1.UpDown1Changing(Sender: TObject;
  var AllowChange: Boolean);
begin
Display(false);
end;

procedure TForm1.Button28Click(Sender: TObject);
Var delta:real;
begin
delta:=(kmaxtrasm-kmintrasm)/10;
if (kmaxtrasm>0)and(kmaxtrasm>kmintrasm) then
  begin
  form1.Label398.Caption:=float_to_str(kmintrasm,3);
  form1.Label399.Caption:=float_to_str(kmintrasm+delta*1,3);
  form1.Label400.Caption:=float_to_str(kmintrasm+delta*2,3);
  form1.Label401.Caption:=float_to_str(kmintrasm+delta*3,3);
  form1.Label402.Caption:=float_to_str(kmintrasm+delta*4,3);
  form1.Label403.Caption:=float_to_str(kmintrasm+delta*5,3);
  form1.Label404.Caption:=float_to_str(kmintrasm+delta*6,3);
  form1.Label405.Caption:=float_to_str(kmintrasm+delta*7,3);
  form1.Label406.Caption:=float_to_str(kmintrasm+delta*8,3);
  form1.Label407.Caption:=float_to_str(kmintrasm+delta*9,3);
  form1.Label408.Caption:=float_to_str(kmintrasm+delta*10,3);
  Display(false);
  end;
end;

procedure TForm1.CBSpiraliClick(Sender: TObject);
begin
Display(false);
end;

end.
