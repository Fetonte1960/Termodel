unit USolomuri;

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
  Buttons, ImgList,
  ComCtrls, ExtCtrls, DBCtrls, DBGrids, Grids,
  StdCtrls, Menus, Mask,
  dbcgrids,
  UGraficoIgro,
  Udb,
  UdataLink,
  Calcolo,
  UVariabili,
  LibreriaGenerale,
  Ucompilaform,
  Udisegnafinestra;

Const PathPareti1        = 'Pareti\';
      PathFinestre1      = 'Finestre\';
      NomemasterPareti   = 'strutture';
      nomeslavePareti    = 'strati';
      nomeIMPareti       = 'immagini';
      NomemasterFinestre = 'finestre';
      nomeslaveFinestre  = 'setti';
      nomeIMFinestre     = 'immaginiF';
      Msg_1 = 'Attenzione esiste una parete nell''archivio del progetto, che ha lo stesso codice rinominarla o cancellarla';


type
  TFSoloMuri = class(TForm)
    DataSource1: TDataSource;
    Table1: TTable;
    DataSource2: TDataSource;
    Table2: TTable;
    DataSource3: TDataSource;
    Table3: TTable;
    DataSource4: TDataSource;
    Table4: TTable;
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
    Table2Indice: TFloatField;
    Table2Orizz: TStringField;
    Table2FormaBMP: TStringField;
    PopupMenu1: TPopupMenu;
    CreaCategoria1: TMenuItem;
    CancellaCategoria1: TMenuItem;
    N1: TMenuItem;
    CreaCategoriaPrincipale1: TMenuItem;
    Timer1: TTimer;
    Panel8: TPanel;
    Button5: TSpeedButton;
    Button6: TSpeedButton;
    Button7: TSpeedButton;
    Button1: TSpeedButton;
    GroupBox1: TGroupBox;
    GroupBox8: TGroupBox;
    DBGrid4: TDBGrid;
    DBImage1: TDBImage;
    Panel5: TPanel;
    Shape8: TShape;
    Label22: TLabel;
    Label21: TLabel;
    Label20: TLabel;
    Label19: TLabel;
    DBGrid3: TDBGrid;
    GroupBox2: TGroupBox;
    Panel2: TPanel;
    BtnImportainArchivio: TSpeedButton;
    BtnTrasferiscinProgetto: TSpeedButton;
    Button8: TSpeedButton;
    Panel1: TPanel;
    DBCtrlGrid1: TDBCtrlGrid;
    DBText1: TDBText;
    DBImage2: TDBImage;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    TreeView1: TTreeView;
    Panel4: TPanel;
    StatusBar2: TStatusBar;
    StatusBar1: TStatusBar;
    GroupBox19: TGroupBox;
    Label66: TLabel;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Label71: TLabel;
    Label72: TLabel;
    Label73: TLabel;
    Label75: TLabel;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    DBEdit33: TDBEdit;
    GroupBox4: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Label4: TLabel;
    DBEdit_PosSchermo: TDBEdit;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnImportainArchivioClick(Sender: TObject);
    procedure BtnTrasferiscinProgettoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormDestroy(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Button10Click(Sender: TObject);
    procedure Button11Click(Sender: TObject);
    procedure Button12Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CreaCategoria1Click(Sender: TObject);
    procedure CancellaCategoria1Click(Sender: TObject);
    procedure DBCtrlGrid1DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure DBCtrlGrid1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure DBGrid3CellClick(Column: TColumn);
    procedure DBGrid3DragOver(Sender, Source: TObject; X, Y: Integer; State: TDragState; var Accept: Boolean);
    procedure Timer1Timer(Sender: TObject);
    procedure CreaCategoriaPrincipale1Click(Sender: TObject);
    procedure DBGrid3DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Panel4Click(Sender: TObject);
    procedure DBGrid3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid3KeyPress(Sender: TObject; var Key: Char);
    procedure DBGrid3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);

  private
    { Private declarations }
    function Ricerca_Path(Radice: TTreeNode; Path: String): String;
    function Calcola_Path_Albero(Nodo: TTreeNode): String;
    procedure Cancella_Path(Path: String);
    procedure Aggiungi_Elemento_Albero(Nodo: TTreeNode; Nome: String);
    function Esistono_File(Path: String): Boolean;
    procedure Copia_Elemento(Codice, PathOrigine, PathDestinazione: String);
    procedure Copia_Dati(NomeTabella, PercorsoA, PercorsoP: String; Numero: Integer; var NewNumero : Integer);
    // Emanuela patch 21/10/04 generazione delle immagini Igro e delle immagini
    // normali nel caso del trascinamento di una parete
    procedure GeneraIM;
    procedure CancellaImgP(Codice, Path: String);
    procedure CancellaImgF(Codice, Path: String);

  public
    { Public declarations }
    DirProg,Dirarch,Dirfile,DirImmagini:string;
    procedure Copia_Info_Fabbricato(Table: TTable);
    procedure CaricaDatiParete;
  end;

Procedure AttivaMuri(DP,DA,DF,DI:string);
Procedure AttivaFinestre(DP,DA,DF,DI:string);
Procedure Genera_Immagini(DP,DA,DF,DI:Pchar);

var
  FSoloMuri: TFSoloMuri;
  Attivo,Pareti,GeneraIm:boolean;
  i:integer;
implementation

uses UDispersioni, Wizardusolomuri, Coefficienti;

{$R *.dfm}

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
  Fielddefs.Add('Codice',ftstring,12,false);
  IndexDefs.Add('PerIndice','Indice',[IxPrimary]);
  IndexDefs.Add('PerNumero','Numero',[IXdescending]);
  CreateTable;
  End;
end;


procedure Controlla_O_Crea_Tabella(Path, Nometabella : String);
begin
  if not fileexists(Path + NomeTabella + '.db') then
  begin
       dm1.tt1.Close;
       dm1.tt1.Databasename:=Path;
       dm1.tt1.tablename:= Nometabella + '.db';
       creadatabase(Nometabella);
  end;
end;

procedure Controlla_O_Crea_TabellaImmagini(Path, Nometabella : String);
begin
  if not fileexists(Path + NomeTabella + '.db') then
     begin
          fsolomuri.Table6.close;
          fsolomuri.Table6.Databasename:=Path;
          fsolomuri.Table6.Tablename:=Nometabella + '.db';
          fsolomuri.Table6.Mastersource:=nil;
          creaDbImmagini(fsolomuri.Table6);
     end;
end;


function Controlla_EsistenzaFile(DP,DA,DF,DI:string) : Boolean;
begin
     Result := False;
     ForceDirectories(DP);
     ForceDirectories(DA);
     ForceDirectories(DF);
     ForceDirectories(DI);

     InitUdb(Dp);

     Fsolomuri:= TFsolomuri.Create(Application);

     Controlla_O_Crea_Tabella(Dp, NomemasterPareti);
     Controlla_O_Crea_Tabella(Dp, NomeslavePareti);
//     if not GeneraIm then //03/06/04
//       Controlla_O_Crea_TabellaImmagini(Dp, nomeIMPareti);

     Controlla_O_Crea_Tabella(Da, NomemasterPareti);
     Controlla_O_Crea_Tabella(Da, NomeslavePareti);
     Controlla_O_Crea_TabellaImmagini(Da, nomeIMPareti);


     if not pareti then
     begin
          Controlla_O_Crea_Tabella(Dp, NomemasterFinestre);
          Controlla_O_Crea_Tabella(Dp, NomeslaveFinestre);
//          if not GeneraIm then //03/06/04
//            Controlla_O_Crea_TabellaImmagini(Dp, nomeIMFinestre);

          Controlla_O_Crea_Tabella(Da, NomemasterFinestre);
          Controlla_O_Crea_Tabella(Da, NomeslaveFinestre);
          Controlla_O_Crea_TabellaImmagini(Da, nomeIMFinestre);

     end;


     { TODO : Occorre inserire un controllo sull'esistenza del database delle immagini e dei materiali? }

     if pareti then InitCalcolo;
     attivo:=false;
     Result := True;
end;


Procedure Attiva_Muri1(DP,DA,DF,DI:string);
Var
    Nomemaster1, NomeSlave1, nomeIM1 : String;
    Genera_Img : Boolean;
begin
     Fsolomuri.DirProg:=Dp;
     Fsolomuri.DirArch:=Da;
     Fsolomuri.DirFile:=Df;
     Fsolomuri.DirImmagini:=DI;

     PercorsoDrive := Df;
//fsolomuri.Table4.databasename:=da;
//fsolomuri.Table4.Open;

DisposeUdb;
InitUdb(Dp);

Controlla_O_Crea_Tabella(Da, NomemasterPareti);
Controlla_O_Crea_Tabella(Da, NomeslavePareti);
Controlla_O_Crea_TabellaImmagini(Da, nomeIMPareti);

if pareti then
  begin
       Fsolomuri.Caption:='Elenco delle pareti del progetto';
       Fsolomuri.GroupBox1.Caption := 'Pareti del progetto';
       Fsolomuri.GroupBox2.Caption := 'Pareti in archivio';
       Nomemaster1 := NomemasterPareti;
       NomeSlave1 := nomeslavePareti;
       NomeIm1 :=  nomeIMPareti;
  end
else
  begin
       Fsolomuri.Caption:='Elenco delle porte e delle finestre del progetto';
       Fsolomuri.GroupBox1.Caption := 'Porte e Finestre del progetto';
       Fsolomuri.GroupBox2.Caption := 'Porte e Finestre in archivio';

       Controlla_O_Crea_Tabella(Da, NomemasterFinestre);
       Controlla_O_Crea_Tabella(Da, NomeslaveFinestre);
       Controlla_O_Crea_TabellaImmagini(Da, nomeIMFinestre);
       Nomemaster1 := NomemasterFinestre;
       NomeSlave1 := nomeslaveFinestre;
       NomeIm1 := nomeIMFinestre
  end;


dm1.TT1.tablename:=Nomemaster1;
dm1.TT3.tablename:=Nomeslave1;


Fsolomuri.Datasource3.Dataset:=dm1.TT3;
Fsolomuri.Datasource4.Dataset:=dm1.TT1;
dm1.TT1.tablename:=Nomemaster1;
dm1.TT1.open;
dm1.TT3.tablename:=Nomeslave1;
InitAssociata;
dm1.TT3.open;
dm1.TT1.First;
dm1.TT3.First;

Fsolomuri.DBGrid3.Columns.Clear;

for i:=1 to 2 do
with Fsolomuri.DBGrid3 do
  begin
  Columns.Add;
  Columns[i-1].Field:=dm1.TT1.Fields[i];
  //width:=350;
  end;

Fsolomuri.DBGrid3.Columns[0].width := 52;
fsolomuri.DBGrid3.Columns[0].Title.Alignment := taCenter;
if pareti then Fsolomuri.DBGrid3.Columns[1].width := 200
else Fsolomuri.DBGrid3.Columns[1].width := 270;
fsolomuri.DBGrid3.Columns[1].Title.Alignment := taCenter;
IF  pareti then
  begin
       Fsolomuri.DBGrid3.Columns.Add;
       Fsolomuri.DBGrid3.Columns[2].Field := dm1.TT1.Fields[24];
       Fsolomuri.DBGrid3.Columns[2].Title.Caption := 'Spessore';
       Fsolomuri.DBGrid3.Columns[2].width := 60;
       fsolomuri.DBGrid3.Columns[2].Title.Alignment := taCenter;


  fsolomuri.groupbox19.Visible := False;
  fsolomuri.groupbox4.Visible := True;

  Fsolomuri.DBGrid4.Columns.Clear;
  with Fsolomuri.DBGrid4 do
    begin
    Columns.Add;
    Columns[0].Field:=dm1.TT3.Fields[3];
    Columns[0].width:=185;
    Columns[0].Title.Alignment := taCenter;
    Columns.Add;
    Columns[1].Field:=dm1.TT3.Fields[5];
    Columns[0].width:=340;
    Columns[1].Title.Alignment := taCenter;
    align:=alclient;
    visible:=true;
    end;
  end
else
  begin
   fsolomuri.groupbox19.Visible := True;
   fsolomuri.groupbox4.Visible := False;
   compilaform(fsolomuri.groupbox19,nomeMaster1,Fsolomuri.Datasource4);
  end;

if Pareti then FSoloMuri.CaricaDatiParete;

fsolomuri.Table2.close;
// Modifica del 04/02/2003 by piero
// la tabelladei materiali è generale
fsolomuri.Table2.Databasename:=di;
fsolomuri.Table2.tablename:='Materiali';
fsolomuri.Table2.Open;


fsolomuri.Table1.close;
fsolomuri.Table1.Databasename:=Da;
fsolomuri.Table1.tablename:=Nomemaster1;
// by piero
fsolomuri.Table1.MasterFields:='Numero';
fsolomuri.Table1.Mastersource:= fsolomuri.DataSource6;
fsolomuri.Table1.Open;


fsolomuri.Table5.close;
fsolomuri.Table5.Databasename:=Da;
fsolomuri.Table5.Mastersource:=fsolomuri.DataSource1;

// by piero
//fsolomuri.Table5.Mastersource:=fsolomuri.DataSource6;
fsolomuri.Table5.MasterFields:='Numero';
fsolomuri.Table5.IndexName:='PerNumero';
fsolomuri.Table5.tablename:=Nomeslave1;
fsolomuri.Table5.Open;
fsolomuri.DBGrid1.Columns.Clear;
if Pareti then
begin
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[0].Field := fsolomuri.Table5.Fields[3];
  fsolomuri.DBGrid1.Columns[0].Title.Caption := 'Descrizione';
  fsolomuri.DBGrid1.Columns[0].width := 170;
  fsolomuri.DBGrid1.Columns[0].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[1].Field := fsolomuri.Table5.Fields[4];
  fsolomuri.DBGrid1.Columns[1].Title.Caption := 'Peso specif.';
  fsolomuri.DBGrid1.Columns[1].width := 80;
  fsolomuri.DBGrid1.Columns[1].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[2].Field := fsolomuri.Table5.Fields[5];
  fsolomuri.DBGrid1.Columns[2].Title.Caption := 'Spessore';
  fsolomuri.DBGrid1.Columns[2].width := 60;
  fsolomuri.DBGrid1.Columns[2].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[3].Field := fsolomuri.Table5.Fields[6];
  fsolomuri.DBGrid1.Columns[3].Title.Caption := 'Conduttanza';
  fsolomuri.DBGrid1.Columns[3].width := 80;
  fsolomuri.DBGrid1.Columns[3].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[4].Field := fsolomuri.Table5.Fields[7];
  fsolomuri.DBGrid1.Columns[4].Title.Caption := 'Condutt. lineare';
  fsolomuri.DBGrid1.Columns[4].width := 100;
  fsolomuri.DBGrid1.Columns[4].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[5].Field := fsolomuri.Table5.Fields[8];
  fsolomuri.DBGrid1.Columns[5].Title.Caption := 'Calore specifico';
  fsolomuri.DBGrid1.Columns[5].width := 100;
  fsolomuri.DBGrid1.Columns[5].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[6].Field := fsolomuri.Table5.Fields[9];
  fsolomuri.DBGrid1.Columns[6].Title.Caption := 'Permeabilità al vapore';
  fsolomuri.DBGrid1.Columns[6].width := 130;
  fsolomuri.DBGrid1.Columns[6].Title.Alignment := taCenter;
end
else
begin
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[0].Field := fsolomuri.Table5.Fields[2];
  fsolomuri.DBGrid1.Columns[0].Title.Caption := 'Tipo';
  fsolomuri.DBGrid1.Columns[0].width := 150;
  fsolomuri.DBGrid1.Columns[0].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[1].Field := fsolomuri.Table5.Fields[3];
  fsolomuri.DBGrid1.Columns[1].Title.Caption := 'Altezza [m]';
  fsolomuri.DBGrid1.Columns[1].width := 100;
  fsolomuri.DBGrid1.Columns[1].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[2].Field := fsolomuri.Table5.Fields[4];
  fsolomuri.DBGrid1.Columns[2].Title.Caption := 'Lunghezza [m]';
  fsolomuri.DBGrid1.Columns[2].width := 120;
  fsolomuri.DBGrid1.Columns[2].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[3].Field := fsolomuri.Table5.Fields[5];
  fsolomuri.DBGrid1.Columns[3].Title.Caption := 'Largh. Telaio [m]';
  fsolomuri.DBGrid1.Columns[3].width := 115;
  fsolomuri.DBGrid1.Columns[3].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[4].Field := fsolomuri.Table5.Fields[17];
  fsolomuri.DBGrid1.Columns[4].Title.Caption := 'K Disp. Opaca';
  fsolomuri.DBGrid1.Columns[4].width := 120;
  fsolomuri.DBGrid1.Columns[4].Title.Alignment := taCenter;
  fsolomuri.DBGrid1.Columns.Add;
  fsolomuri.DBGrid1.Columns[5].Field := fsolomuri.Table5.Fields[18];
  fsolomuri.DBGrid1.Columns[5].Title.Caption := 'K L10 Opaca';
  fsolomuri.DBGrid1.Columns[5].width := 120;
  fsolomuri.DBGrid1.Columns[5].Title.Alignment := taCenter;
end;

fsolomuri.Table7.close;
fsolomuri.Table7.Databasename:=dp;
fsolomuri.Table7.Tablename:=Nomeim1;

fsolomuri.StatusBar1.Panels[1].Text :=dp;
fsolomuri.StatusBar2.Panels[1].Text :=da;

Genera_Img := False;
if not fileexists(dp+'\'+NomeIm1+'.db') then
  begin
  creaDbImmagini(fsolomuri.Table7);
  fsolomuri.Table7.open;
  fsolomuri.Table7.first;
  fsolomuri.Table7.edit;
  fsolomuri.Table7.delete;
  Genera_Img := True;
  end;



fsolomuri.Table7.Mastersource:=fsolomuri.DataSource4;
fsolomuri.Table7.MasterFields:='Numero';
fsolomuri.Table7.IndexName:='PerNumero';
fsolomuri.Table7.Open;
fsolomuri.DBImage1.DataField:='Immagine';
//fsolomuri.DBText2.DataField:='Descrizione';

if Genera_Img then
   generaImmagini(dm1.tt1, dm1.tt3, fsolomuri.table7);




// Modifica del 04/02/2004 il database delle immagini risiede nella cartella generale
fsolomuri.Table6.close;
fsolomuri.Table6.Databasename:=Da;
fsolomuri.Table6.Tablename:=Nomeim1;
fsolomuri.dbimage2.DataField:='Immagine';
fsolomuri.Table6.Mastersource:=nil;
//fsolomuri.Table6.Mastersource:=fsolomuri.DataSource5;
fsolomuri.Table6.MasterFields:='Numero';
fsolomuri.Table6.IndexName:='PerNumero';
fsolomuri.Table6.Open;
end;

Procedure Attiva_Muri(DP,DA,DF,DI:string);
begin
     PercorsoDrive := df;
     ForceDirectories('c:\temp');
     Session.PrivateDir := 'c:\temp';
     Session.NetFileDir := 'c:\temp';   

     if Pareti then
        begin
             if not Controlla_EsistenzaFile(DP,DA + PathPareti1,DF,DI) then
                Exit;
             Attiva_Muri1(DP,DA + PathPareti1,DF,DI)
        end
     else
        begin
             if not Controlla_EsistenzaFile(DP,Da + PathFinestre1,DF,DI) then
                Exit;

             Attiva_Muri1(DP,DA + PathFinestre1,DF,DI);
        end;

     if not GeneraIm then
        Fsolomuri.showmodal;
end;


Procedure AttivaMuri(DP,DA,DF,DI:string);
begin
Pareti:=True;
GeneraIm:=false;
Attiva_Muri(DP,DA,DF,DI);
end;

Procedure AttivaFinestre(DP,DA,DF,DI:string);
begin
Pareti:=False;
GeneraIm:=false;
Attiva_Muri(DP,DA,DF,DI);
end;

Procedure Genera_Immagini(DP,DA,DF,DI:Pchar);
begin
GeneraIm:=true;
Pareti:=True;
Attiva_Muri(strpas(DP),strpas(DA),strpas(DF), strpas(DI));
fsolomuri.close;
Pareti:=false;
Attiva_Muri(strpas(DP),strpas(DA),strpas(DF),strpas(DI));
fsolomuri.close;
end;

procedure TFSoloMuri.Button1Click(Sender: TObject);
begin
Close;
end;
Procedure AttivaFiltro;
begin
FSolomuri.Table2.filtered:=true;
end;

procedure TFSoloMuri.FormActivate(Sender: TObject);
begin
attivafiltro;
//Grafico;
end;

procedure TFSoloMuri.BtnImportainArchivioClick(Sender: TObject);
Var
   Descrizione : String;
begin
  if CompareStr(dm1.TT1.FieldByName('Codice').AsString, '') <> 0 then
  begin
     fsolomuri.Table1.Mastersource:= Nil;
     fsolomuri.Table6.Mastersource:=fsolomuri.DataSource1;
     fsolomuri.Table5.Mastersource:=fsolomuri.DataSource1;
     CopiarigaDB(dm1.TT1,dm1.TT3,table7,Table1,table5,table6);
     fsolomuri.Table6.Mastersource:= Nil;
     fsolomuri.Table1.Mastersource:= fsolomuri.DataSource6;

     if not Pareti then
        begin
             // Memorizzo il codice assegnato al tipo di vetro
             // attraverso una serie di query e copia di righe
             Descrizione := Dm1.TT1.FindField('Codice del vetro').AsString;
             Copia_Elemento(Descrizione, Percorso_progetti, Percorso_Archivi + PathFinestre1);
        end;

     DBCtrlGrid1.DataSource.DataSet.Refresh;
     DBImage2.DataSource.DataSet.Refresh;
  end;
end;


procedure TFSoloMuri.Copia_Elemento(Codice, PathOrigine, PathDestinazione : String);
Var
   NewNumero, i, Indice : Integer;
   AusQuery : TQuery;
   Testo, Numero : String;
   Tabella : TTable;
begin
     AusQuery := TQuery.Create(Application);
     AusQuery.DatabaseName := PathOrigine;

     // cerco l'elemento che ha come codice il codice del vetro passato come parametro
     // e la copio all'interno della tabella strutture dell'archivio

     Testo := 'Select * from strutture where descrizione = ''' + Codice + '''';

     AusQuery.Active := False;
     AusQuery.DatabaseName := PathDestinazione;
     AusQuery.SQL.Clear;
     AusQuery.SQL.Add(Testo);
     AusQuery.Active := True;

     // controllo se esiste in archivio una struttura simile a quella usata per comporre la finestra
     if AusQuery.RecordCount > 0 then
        begin
             AusQuery.Active := False;
             Exit;
        end;

     AusQuery.Active := False;
     AusQuery.DatabaseName := PathOrigine;
     AusQuery.Active := True;

     if AusQuery.RecordCount = 0 then
        begin
                AusQuery.Active := False;
                FreeandNil(AusQuery);
                Exit;
        end;

     Tabella := TTable.Create(Application);
     Tabella.DatabaseName := PathDestinazione;

     Numero := AusQuery.FindField('numero').AsString;


     Tabella.TableName := 'strutture';
     Tabella.Open;

     Tabella.Insert;
     for i := 1 to AusQuery.FieldCount - 1 do
        begin
             Indice := Tabella.FieldList.IndexOf(AusQuery.Fields[i].FieldName);
             if Indice <> - 1 then
                Tabella.Fields[Indice].Value := AusQuery.Fields[i].Value;
        end;

        // Emanuela 17/11/2004 non potendo in nessun modo in questo modo a creare l'immagini dello strato parete
        // non permetto la sua stampa
        Tabella.Fields[26].Value := 'Nessuna Stampa';


     Tabella.Post;
     NewNumero := Tabella.Fields[0].AsInteger;


     Testo := 'Select * from strati where numero = ' + Numero;
     AusQuery.Active := False;
     AusQuery.SQL.Clear;
     AusQuery.SQL.Add(Testo);
     AusQuery.Active := True;

     if AusQuery.RecordCount > 0 then
        begin
             Tabella.Close;
             Tabella.TableName := 'strati';
             Tabella.Open;

             Tabella.Insert;
             for i := 2 to AusQuery.FieldCount - 1 do
                begin
                     Indice := Tabella.FieldList.IndexOf(AusQuery.Fields[i].FieldName);
                     if Indice <> - 1 then
                        Tabella.Fields[Indice].Value := AusQuery.Fields[i].Value;
                end;

             Tabella.Fields[1].Value := NewNumero;

             Tabella.Post;
        end;

     Testo := 'Select * from immagini where numero = ' + Numero;
     AusQuery.Active := False;
     AusQuery.SQL.Clear;
     AusQuery.SQL.Add(Testo);
     AusQuery.Active := True;

     if AusQuery.RecordCount > 0 then
        begin
             Tabella.Close;
             Tabella.TableName := 'immagini';
             // Emanuela 16/11/2004 inserita la creazione della tabella se essa non esiste
             if not FileExists(Percorso_Progetti + 'Immagini.db') then CreaDBImmagini(Tabella);
             Tabella.Open;

             Tabella.Insert;
             for i := 2 to AusQuery.FieldCount - 1 do
                begin
                     Indice := Tabella.FieldList.IndexOf(AusQuery.Fields[i].FieldName);
                     if Indice <> - 1 then
                        Tabella.Fields[Indice].Value := AusQuery.Fields[i].Value;
                end;

             Tabella.Fields[1].Value := NewNumero;
             Tabella.Post;
        end;

     Tabella.Close;
     FreeAndNil(Tabella);
     AusQuery.Close;
     FreeandNil(Ausquery);
end;

procedure TFSoloMuri.BtnTrasferiscinProgettoClick(Sender: TObject);
Var tempnum:integer;
    A, B, C, D, E, F : TDataSource;
    Descrizione : String;
    // Emanuela 2/8/2005 verifica dell'esistenza del codice
    Query : TQuery;
    Esiste_Codice : Boolean;
begin
     if Table6.RecordCount = 0 then
        Exit;

     tempnum:=table6.fieldbyname('Numero').value;

     fsolomuri.Table1.Mastersource:=nil;
     fsolomuri.Table6.Mastersource:=fsolomuri.DataSource1;
     fsolomuri.table1.First;
     while (not fsolomuri.table1.eof)and (fsolomuri.table1.fieldbyname('Numero').value<>tempnum)do fsolomuri.table1.Next;
     // Emanuela 2/8/2005 verifica dell'esistenza del codice
     Query := TQuery.Create(Application);
     Query.DatabaseName := fsolomuri.Table7.DatabaseName;
     Query.Active := False;
     Query.SQL.Add('select * from ' + fsolomuri.Table7.TableName + ' where Upper(codice) = ''' + UpperCase(fsolomuri.Table1.FieldByName('Codice').AsString) + '''');
     Query.Active := True;
     Esiste_Codice := Query.RecordCount >= 1;
     Query.Active := False;
     FreeandNil(Query);

     if Esiste_Codice then
     begin
        MessageDlg(Msg_1, mtWarning, [mbOK], 0);
        DbGrid3.DataSource.DataSet.Refresh;
        DBImage1.DataSource.DataSet.Refresh;
     end;

     CopiarigaDB(fsolomuri.Table1,fsolomuri.table5,fsolomuri.table6,dm1.TT1,dm1.TT3,fsolomuri.table7);
     fsolomuri.Table6.Mastersource := nil;
     fsolomuri.Table1.Mastersource := fsolomuri.DataSource6;
     InitCalcolo;
     if not Pareti then
        begin
             // Memorizzo il codice assegnato al tipo di vetro
             // attraverso una serie di query e copia di righe
             Descrizione := FSoloMuri.Table1.FindField('Codice del vetro').AsString;
             Copia_Elemento(Descrizione, Percorso_Archivi + PathFinestre1, Percorso_progetti);
             // Memorizzo il codice assegnato al tipo di parte opaca o sottofinestra
             // attraverso una serie di query e copia di righe
             Descrizione := FSoloMuri.Table1.FindField('TipoSottoFin').AsString;
             Copia_Elemento(Descrizione, Percorso_Archivi + PathFinestre1, Percorso_progetti);
        end
     else
        Copia_Info_Fabbricato(dm1.TT1);

     GeneraIM;

     if Pareti then CaricaDatiParete;

     if Pareti and CALCOLOIGRO(Nil, PercorsoDrive, Panel5, 1, false) then
     begin
         MessageDlg('Attenzione possibile formazione di condensa per la parete importata dall''archivio.', mtWarning, [mbOK], 0);
         Panel5.Visible := False;
     end;

     DisposeCalcolo;
     DbGrid3.DataSource.DataSet.Refresh;
     DBImage1.DataSource.DataSet.Refresh;
end;

procedure TFSoloMuri.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dispose(D_setti);
DisposeUdb;
Table1.close;
Table2.close;
Table3.close;
Table4.close;
Table5.close;
Table6.close;
Table7.close;

action:=cafree;
end;

procedure TFSoloMuri.FormDestroy(Sender: TObject);
begin
Fsolomuri:=nil;
end;

procedure TFSoloMuri.Button5Click(Sender: TObject);
begin

     if dm1.TT1.RecordCount = 0 then
        begin
             MessageDlg('Nessun elemento presente in archivio da poter cancellare', mtInformation, [mbOK], 0);
             Exit;
        end;

     if MessageDlg('Attenzione confermi la cancellazione dell''elemento selezionato ' + dm1.TT1.FindField('descrizione').AsString + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) <> mrYes then
        Exit;

     // Emanuela 21/10/04 inserita la cancellazione delle immagini relative al progetto, quando si cancella un elemento
     if Pareti then
        CancellaImgP(dm1.TT1.FieldByName('Codice').AsString, dirFile)
     else CancellaImgF(dm1.TT1.FieldByName('Codice').AsString, dirFile);

     CancellaRigaDB(dm1.tt3,fsolomuri.Table7);
     dm1.TT1.Delete;
     DbGrid3.DataSource.DataSet.Refresh;
     DBImage1.DataSource.DataSet.Refresh;
end;

procedure TFSoloMuri.Button6Click(Sender: TObject);
Var
   AusQuery : TQuery;
   Esistono_Elementi : Boolean;

   i, Numero, NewNumero : Integer;
begin
     if not Pareti then
        begin
             AusQuery := TQuery.Create(Application);
             AusQuery.DatabaseName := dm1.TT1.DatabaseName;
             ForceDirectories(dm1.TT1.DatabaseName);
             AusQuery.Active := False;
             AusQuery.SQL.Clear;
             Esistono_Elementi := FileExists(dm1.TT1.DatabaseName + '\strutture.db');

             if Esistono_Elementi then
             begin
             AusQuery.SQL.Add('select * from strutture where Categoria= ''TRASPARENTE''');
             AusQuery.Active := True;
             Esistono_Elementi := AusQuery.RecordCount > 0;
             AusQuery.Active := False;
             end;

             if not Esistono_Elementi then
                begin
                     AusQuery.DatabaseName := Percorso_Archivi + PathPareti1 + 'Vetri';
                     Controlla_O_Crea_Tabella(AusQuery.DatabaseName, 'strutture');

                     AusQuery.Active := True;
                     Esistono_Elementi := AusQuery.RecordCount > 0;
                     AusQuery.Active := False;
                     FreeandNil(AusQuery);

                     if not FileExists(Percorso_Archivi + PathPareti1 + 'Vetri\strutture.db') or not Esistono_Elementi then
                     begin
                           MessageDlg('Attenzione per poter specificare in maniera corretta una finestra e/o una porta è ' +
                                      'necessario che nell''archivio del progetto sia presente una struttura di tipo vetro o trasparente', mtInformation, [mbOK], 0);
                           // Emanuela 23/9/2004, tenendo conto che chi ha usato sempre questa
                           // struttura dm1.tt1 avrebbe dovuto porsi la domanda, se durante gli scambi delle varie tabelle
                           // si perdevano dati o riferimenti, è stata inserita la parte necessaria
                           // per riportare i dati della tabella dm1.tt1 a quelli necessari, per evitare errori
                           // durante il trasferimento di una finestra dopo che è uscito il messaggio sopra.
                           dm1.TT1.close;
                           dm1.TT1.DatabaseName := Percorso_Progetti;
                           dm1.TT1.tablename:=NomemasterFinestre;
                           dm1.TT1.open;
                           Exit
                      end;

//                     MessageDlg('Selezionare un elemento vetro dall''archivio', mtInformation, [mbOK], 0);
                     FormCoefficienti := TFormCoefficienti.create(nil);
                     FormCoefficienti.Label1.Caption := 'Selezionare un elemento vetro dall''archivio';
                     FormCoefficienti.Label1.Font.Size := 12;
                     FormCoefficienti.Label1.Font.Style := [fsBold];
                     FormCoefficienti.Label1.Font.Color := clRed;

                     FormCoefficienti.DBGrid1.Visible := True;


                     FormCoefficienti.Table1.Close;

                     FormCoefficienti.Table1.close;
                     FormCoefficienti.Table1.Databasename := Percorso_Archivi + PathPareti1 + 'Vetri\';
                     FormCoefficienti.Table1.tablename := NomemasterPareti + '.db';
                     FormCoefficienti.Table1.Filter := 'Categoria= ''TRASPARENTE''';
                     FormCoefficienti.Table1.Filtered := True;
                     FormCoefficienti.Table1.Open;

                     FormCoefficienti.DBGrid1.Columns.Clear;
                     FormCoefficienti.DBGrid1.Columns.Add;
                     FormCoefficienti.DBGrid1.Columns[0].Field := FormCoefficienti.Table1.Fields[1];
                     FormCoefficienti.DBGrid1.Columns.Add;
                     FormCoefficienti.DBGrid1.Columns[1].Field := FormCoefficienti.Table1.Fields[2];
                     FormCoefficienti.DBGrid1.Columns.Add;
                     FormCoefficienti.DBGrid1.Columns[2].Field := FormCoefficienti.Table1.Fields[6];

                     FormCoefficienti.ShowModal;

                     Numero := FormDispersioni.Table1.findField('numero').AsInteger;
                     NewNumero := - 1;

                     Copia_Dati(NomemasterPareti, Percorso_Archivi + PathPareti1 + 'Vetri\', Percorso_progetti, Numero, NewNumero);
                     Copia_Dati(nomeslavePareti, Percorso_Archivi + PathPareti1 + 'Vetri\', Percorso_progetti, Numero, NewNumero);
                     Copia_Dati(nomeIMPareti, Percorso_Archivi + PathPareti1 + 'Vetri\', Percorso_progetti, Numero, NewNumero);
                end;
     end;

     WizardFSoloMuri := TWizardFSoloMuri.Create(Application);
     if Pareti then
     begin
        WizardFSoloMuri.AttivaMuri(Percorso_progetti,Percorso_Archivi + PathPareti1,PercorsoDrive, Percorso_Immagini);
     end
     else
     begin
        WizardFSoloMuri.AttivaFinestre(Percorso_progetti,Percorso_Archivi + PathFinestre1,PercorsoDrive, Percorso_Immagini);
     end;

     WizardFSoloMuri.Nuovo_E := True;
     WizardFSoloMuri.ShowModal;


     if pareti then DisposeCalcolo;

     if not pareti then WizardFSoloMuri.DBEdit42.OnChange := nil;
     DbGrid3.DataSource.DataSet.Refresh;
     if not pareti then WizardFSoloMuri.DBEdit42.OnChange := WizardFSoloMuri.DBEdit42Change;
     DBImage1.DataSource.DataSet.Refresh;
     // creazione dell'immagine della parete o della finestra nuova
     if FileExists(Percorso_progetti + 'DataBase\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString +'.bmp') then
        DeleteFile(Percorso_progetti + 'DataBase\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString +'.bmp');
     DBImage1.Picture.SaveToFile(Percorso_progetti + '\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString + '.bmp');

end;

procedure TFSoloMuri.Copia_Dati(NomeTabella, PercorsoA, PercorsoP : String; Numero : Integer; var NewNumero : Integer);
Var
   Ta, Tp : TTable;
begin
     Ta := TTable.Create(Application);
     Ta.DatabaseName := PercorsoA;
     Ta.TableName := NomeTabella + '.db';
     Ta.Open;
     Ta.Filter := 'Numero = ' + IntToStr(Numero);
     Ta.Filtered := True;

     Tp := TTable.Create(Application);
     Tp.DatabaseName := PercorsoP;
     Tp.TableName := NomeTabella + '.db';
     Tp.Open;

     Copia_Dati_Comuni_Tabelle(Ta, Tp, tpInsert);
     if NewNumero = - 1 then
        NewNumero := Tp.FindField('numero').AsInteger
     else
        begin
             Tp.Edit;
             Tp.FindField('numero').AsInteger := NewNumero;
             Tp.Post;
        end;


     Ta.Close;
     Tp.Close;
     FreeandNil(Ta);
     FreeandNil(Tp);
end;

procedure TFSoloMuri.Button7Click(Sender: TObject);
Var
   Codice : String;
begin
   if DbGrid3.DataSource.DataSet.RecordCount = 0 then
        Exit;

     Codice := DbGrid3.DataSource.DataSet.FindField('NUMERO').AsString;

     WizardFSoloMuri := TWizardFSoloMuri.Create(Application);

     if Pareti then
        WizardFSoloMuri.Attivamuri(Percorso_progetti,Percorso_Archivi + PathPareti1,PercorsoDrive, Percorso_Immagini)
     else
        WizardFSoloMuri.AttivaFinestre(Percorso_progetti,Percorso_Archivi+ PathFinestre1,PercorsoDrive, Percorso_Immagini);

     WizardFSoloMuri.Nuovo_E := False;
     WizardFSoloMuri.Codice := Codice;

     if not Pareti then
     begin
       WizardFSoloMuri.DBEdit48.OnChange := nil;
       WizardFSoloMuri.DBEdit47.OnChange := nil;
     end;
     WizardFSoloMuri.ShowModal;
     if not Pareti then
     begin
       WizardFSoloMuri.DBEdit48.OnChange := WizardFSoloMuri.DBEdit48Change;
       WizardFSoloMuri.DBEdit47.OnChange := WizardFSoloMuri.DBEdit47Change;
     end;
     DbGrid3.DataSource.DataSet.Refresh;
     DBImage1.DataSource.DataSet.Refresh;
     // creazione dell'immagine della parete o della finestra nuova
     if FileExists(Percorso_progetti + 'DataBase\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString +'.bmp') then
        DeleteFile(Percorso_progetti + 'DataBase\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString +'.bmp');
     DBImage1.Picture.SaveToFile(Percorso_progetti + '\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString + '.bmp');
end;

procedure TFSoloMuri.Button8Click(Sender: TObject);
begin
     if FSoloMuri.Table6.RecordCount = 0 then
        begin
             MessageDlg('Nessun elemento presente in archivio da poter cancellare', mtInformation, [mbOK], 0);
             Exit;
        end;


     if MessageDlg('Attenzione confermi la cancellazione dell''elemento selezionato ' + fsolomuri.Table6.FindField('descrizione').AsString + '?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) <> mrYes then
        Exit;

{
   // come prima
   fsolomuri.Table6.Mastersource:=fsolomuri.DataSource1;
   CancellaRigaDB(fsolomuri.Table5,fsolomuri.Table6);
   fsolomuri.Table6.Mastersource:=nil;
   FSoloMuri.Table1.Delete;   }



   // come prima
   fsolomuri.Table1.Mastersource:=fsolomuri.DataSource6;
   fsolomuri.Table5.Mastersource:=fsolomuri.DataSource6;

   CancellaRigaDB(fsolomuri.Table5,fsolomuri.Table1);

   fsolomuri.Table1.Mastersource:=nil;
   FSoloMuri.Table6.Delete;
end;

procedure TFSoloMuri.Button10Click(Sender: TObject);
begin
dm1.TT3.Append;
dm1.TT3.edit;
end;

procedure TFSoloMuri.Button11Click(Sender: TObject);
begin
if not(dm1.TT3.Eof) then
dm1.TT3.delete;
end;

procedure TFSoloMuri.Button12Click(Sender: TObject);
begin
dm1.TT3.insert;
dm1.TT3.edit;
end;

function TFSoloMuri.Ricerca_Path(Radice : TTreeNode; Path : String) : String;
Var
   Trovato : Integer;
   SearchRec : TSearchRec;
   Nodo : TTreeNode;
begin
     if Path[Length(Path)] <> '\' then
        Path := Path + '\';

     Trovato := FindFirst(Path + '*.*', faAnyFile, SearchRec);
     while Trovato = 0 do
        begin
             if (SearchRec.Name = '.') or (SearchRec.Name = '..') or (UpperCase(SearchRec.name) = 'DISEGNI') then
                begin
                     Trovato := FindNext(SearchRec);
                     Continue
                end;

             if SearchRec.Attr and faDirectory > 0 then
                begin
                     if Esistono_File(Path + SearchRec.Name + '\') then
                        begin
                             Nodo := TreeView1.Items.AddChild(Radice, SearchRec.Name);
                             Ricerca_Path(Nodo, Path + SearchRec.Name + '\');
                        end
                     else
                        RemoveDir(Path + SearchRec.Name);
                end;

             Trovato := FindNext(SearchRec);
        end;
end;

function TFSoloMuri.Esistono_File(Path : String) : Boolean;
Var
   Trovato : Integer;
   SearchRec : TSearchRec;
   Nodo : TTreeNode;
begin
     Result := False;
     if Path[Length(Path)] <> '\' then
        Path := Path + '\';

     Trovato := FindFirst(Path + '*.*', faAnyFile, SearchRec);
     while Trovato = 0 do
        begin
             if (SearchRec.Name = '.') or (SearchRec.Name = '..') or (UpperCase(SearchRec.name) = 'DISEGNI') then
                begin
                     Trovato := FindNext(SearchRec);
                     Continue
                end;

             Result := True;
             Exit;
        end;
end;


procedure TFSoloMuri.FormCreate(Sender: TObject);
Var
   Path : String;
begin
     DecimalSeparator := '.';
     Application.UpdateFormatSettings := False;

     new(D_setti);

     IF PARETI THEN
     begin
        Path := Percorso_Archivi + PathPareti1;
        GroupBox3.Caption := 'Stratigrafia della parete selezionata dall''archivio generale';
     end
     ELSE
     begin
        Path := Percorso_Archivi + PathFinestre1;
        GroupBox3.Caption := 'Caratteristiche della finestra selezionata dall''archivio generale';
     end;

     TreeView1.Items.BeginUpdate;
     Ricerca_Path(Nil, Path);
     TreeView1.FullExpand;
     TreeView1.Items.EndUpdate;
end;

function TFSoloMuri.Calcola_Path_Albero(Nodo : TTreeNode) : String;
Var
      Path : String;
begin
     Path := '';

     While Nodo <> Nil do
        begin
             Path := Nodo.Text + '\' + Path;
             Nodo := Nodo.Parent;
        end;

//     Delete(Path, Length(Path), 1);

     Result := Percorso_Archivi;
//     if Result[Length(Result)] = '\' then
//        Delete(Result, Length(Result), 1);

     if Pareti then
        Result := Result + PathPareti1 + Path
     else
        Result := Result + PathFinestre1 + Path;

//     Delete(Result, Length(Result), 1);
end;

procedure TFSoloMuri.CreaCategoria1Click(Sender: TObject);
Var
   Nome : String;
   Nodo : TTreeNode;
begin
     Nodo := TreeView1.Selected;

     if (Nodo = Nil) and (TreeView1.Items.Count > 0) then Exit;

     Nome := '';

     if not InputQuery('Inserimento Categoria', 'Inserisci il nome di una sotto categoria', Nome) then
        Exit;

     if Nome = '' then Exit;

     Aggiungi_Elemento_Albero(Nodo, Nome);
end;

procedure TFSoloMuri.CancellaCategoria1Click(Sender: TObject);
Var
   Path, NewPath : String;
   Nodo  : TTreeNode;
begin
     Nodo := TreeView1.Selected;

     if Nodo = Nil then
        begin
             MessageDlg('Attenzione devi selezionare una categoria', MtInformation, [mbOK], 0);
             Exit
        end;

     if MessageDlg('Confermi la cancellazione della categoria selezionata ' + Nodo.Text + '?' + #13 +
                   'La cancellazione della categoria comporta l''eliminazione delle eventuali sotto categorie e degli archivi associati.' + #13 + #13 +
                   'Continuare?', mtConfirmation, [mbYes, mbNo, mbCancel], 0) <> mrYes then
        Exit;


     Path := Calcola_Path_Albero(Nodo);

     DisposeUdb;


     if Nodo.Parent <> Nil then
        NewPath := Calcola_Path_Albero(Nodo.Parent)
     else if Nodo.GetNext <> Nil then
        NewPath := Calcola_Path_Albero(Nodo.GetNext)
     else
       NewPath := '';

     FSoloMuri.Table1.Close;
     FSoloMuri.Table5.Close;
     FSoloMuri.Table6.Close;

     Cancella_Path(Path);
     RemoveDir(Path);
     TreeView1.Items.Delete(Nodo);


     if NewPath <> '' then
        Attiva_Muri1(Percorso_progetti,NewPath,PercorsoDrive,Percorso_Immagini)
end;

procedure TFSoloMuri.Cancella_Path(Path : String);
Var
   Trovato : Integer;
   SearchRec : TSearchRec;
   Nome : String;
begin
     Trovato := FindFirst(Path + '\*.*', faAnyFile, SearchRec);
     while Trovato = 0 do
        begin
             if (SearchRec.Name = '.') or (SearchRec.Name = '..') then
                begin
                     Trovato := FindNext(SearchRec);
                     Continue
                end;

             Nome := Path + '\' + SearchRec.Name;

             if SearchRec.Attr and faDirectory > 0 then
                begin
                     Cancella_Path(Nome);
                     RemoveDir(Nome);
                end
             else
                DeleteFile(Nome);


                Trovato := FindNext(SearchRec);
        end;

     SetCurrentDir(Path + '\..');
     RemoveDir(Path);
end;

procedure TFSoloMuri.DBCtrlGrid1DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept := Source is TDBGrid;
end;

procedure TFSoloMuri.DBCtrlGrid1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
     BtnImportainArchivioClick(Sender);
end;

procedure TFSoloMuri.DBGrid3CellClick(Column: TColumn);
begin
     DbGrid3.DragMode := dmAutomatic;
     Timer1.Enabled := True;
end;

procedure TFSoloMuri.DBGrid3DragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
     Accept := Source is TDBImage;
end;

procedure TFSoloMuri.Timer1Timer(Sender: TObject);
begin
     DBGrid3.DragMode := dmManual;
     Timer1.Enabled := False;
     if Pareti then CaricaDatiParete;
end;

procedure TFSoloMuri.Aggiungi_Elemento_Albero(Nodo : TTreeNode; Nome : String);
Var
   Path : String;
   Nomemaster1,nomeslave1,nomeIM1:string;
begin
     Path := Calcola_Path_Albero(Nodo) + Nome;

     TreeView1.Items.AddChild(Nodo, Nome);
     ForceDirectories(Path);

     Controlla_O_Crea_Tabella(Path, NomemasterPareti);
     Controlla_O_Crea_Tabella(Path, NomeslavePareti);
     Controlla_O_Crea_TabellaImmagini(Path, nomeIMPareti);

     if NOT pareti then
     begin
          Fsolomuri.Caption:='Elenco delle porte e delle finestre del progetto';
          Fsolomuri.GroupBox1.Caption := 'Porte e Finestre del progetto';
          Fsolomuri.GroupBox2.Caption := 'Porte e Finestre in archivio';

          Controlla_O_Crea_Tabella(Path, NomemasterFinestre);
          Controlla_O_Crea_Tabella(Path, NomeslaveFinestre);
          Controlla_O_Crea_TabellaImmagini(Path, nomeIMFinestre);
     END;
end;


procedure TFSoloMuri.CreaCategoriaPrincipale1Click(Sender: TObject);
Var
   Nome : String;
   Nodo : TTreeNode;
begin
     Nodo := Nil;
     Nome := '';

     if not InputQuery('Inserimento Categoria', 'Inserisci il nome di una categoria', Nome) then
        Exit;

     if Nome = '' then Exit;

     Aggiungi_Elemento_Albero(Nodo, Nome)
end;

procedure TFSoloMuri.DBGrid3DragDrop(Sender, Source: TObject; X, Y: Integer);
begin
     BtnTrasferiscinProgettoClick(Sender);
end;

procedure TFSoloMuri.TreeView1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
Function GetShortName(Const FileName : String) : String;
var
   aTmp: array[0..255] of char;
begin
     if GetShortPathName(PChar(FileName), aTmp, Sizeof(aTmp) -1 ) = 0 then
        Result := FileName
     else
        Result := StrPas(aTmp);
end;

Var
   OldNodo, Nodo : TTreeNode;

   Path : String;
begin
     NODO := TreeView1.Selected;

     if Nodo = Nil then
        begin
             TreeView1.Selected := Nil;
             DisposeUdb;
             if Pareti then
                Attiva_Muri1(Percorso_progetti,Percorso_Archivi + PathPareti1,PercorsoDrive,Percorso_Immagini)
             else
                Attiva_Muri1(Percorso_progetti,Percorso_Archivi + PathFinestre1,PercorsoDrive,Percorso_Immagini);

             Exit;
        end;

     OldNodo := Nodo;

     Path := Calcola_Path_Albero(Nodo);

     Path := GetShortName(Path);

     DisposeUdb;
     Attiva_Muri1(Percorso_progetti,Path,PercorsoDrive,Percorso_Immagini);

     TreeView1.Selected := OldNodo;
end;

procedure TFSoloMuri.Panel4Click(Sender: TObject);
begin
     TreeView1.Selected := Nil;
     DisposeUdb;
     if pareti then
        Attiva_Muri1(Percorso_progetti,Percorso_Archivi + PathPareti1,PercorsoDrive,Percorso_Immagini)
     else
        Attiva_Muri1(Percorso_progetti,Percorso_Archivi + PathFinestre1,PercorsoDrive,Percorso_Immagini)
end;


procedure TFSoloMuri.Copia_Info_Fabbricato(Table : TTable);
var
   OldStato : TDataSetState;
   TableF : TTable;
begin
     if not (Table.State in [dsEdit, dsInsert]) then
        Table.Edit;

     TableF := TTable.Create(Nil);
     TableF.DatabaseName := Percorso_progetti;
     TableF.TableName := 'Fabbricato.db';
     TableF.Open;


     Table['Inverno Temp. Int'] := TableF['I Temperatura interna'];
     Table['Inverno Um. Int']   := TableF['I UR interna'];
     Table['Inverno Temp. Est'] := TableF['Temperatura inv. esterna'];
     Table['Inverno Um. Est']   := TableF['Um. rel. Esterna'];

     Table['Estate Temp. Int']       := TableF['Temperatura estiva'];
     Table['Estate Umidità Rel Int'] := TableF['UR estiva'];
     Table['Estate Temp. Est']       := TableF['Temp. Estiva Est.BS'];
     Table['Estate Umidità Rel Est'] := TableF['Um. Estiva Est.BS'];
     Table.Post;

     TableF.Close;
     FreeandNil(TableF);
end;

{-----------------------------------------------------------------------------
  Procedure: TFSoloMuri.GeneraIM
  Author:    Emanuela
  Date:      21-ott-2004
  Arguments: None
  Result:    None

  generazione dell immagini quando si trasferisce una parete dall'archivio generale
  al progetto
-----------------------------------------------------------------------------}

procedure TFSoloMuri.GeneraIM;
var
  Image : TImage;
begin
 if dm1 <> nil then
 begin
   if FileExists(Percorso_progetti + 'DataBase\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString +'.bmp') then
        DeleteFile(Percorso_progetti + 'DataBase\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString +'.bmp');
   DBImage1.Picture.SaveToFile(Percorso_progetti + '\Immagini_Pareti\' + dm1.tt1.findfield('codice').AsString + '.bmp');
   // Emanuela patch del 21/10/2004: generazione delle immagini igro quando viene trasferita nel progetto
    if Pareti then
    begin
       Image := TImage.Create(Nil);
       ForceDirectories(Percorso_progetti + '\Immagini_igro\');
       image.Width := 269;
       image.Height := 260;
       image.Transparent := False;
       Table7.open;
       disegnagrafico(image, 269,260, false,1,Table7,dm1.TT3);
       Image.Picture.SaveToFile(Percorso_progetti + '\Immagini_igro\' + dm1.tt1.findfield('codice').AsString + '_igro.bmp');
       FreeAndNil(Image);
    end;
 end;
end;

procedure TFSoloMuri.CancellaImgF(Codice, Path: String);
begin
   if FileExists(Path + 'DataBase\Immagini_Pareti\' + Codice +'.bmp') then DeleteFile(Path + 'DataBase\Immagini_Pareti\' + Codice +'.bmp');
end;

procedure TFSoloMuri.CancellaImgP(Codice, Path: String);
begin
  if FileExists(Path + 'DataBase\Immagini_Pareti\' + Codice +'.bmp') then DeleteFile(Path + 'DataBase\Immagini_Pareti\' + Codice +'.bmp');
  if FileExists(Path + 'DataBase\Immagini_Igro\' + Codice +'_igro.bmp') then DeleteFile(Path + 'DataBase\Immagini_Igro\' + Codice +'_igro.bmp');
end;

procedure TFSoloMuri.CaricaDatiParete;
begin
  Edit1.Text := dm1.TT1.FieldByName('Trasmittanza').AsString;
  Edit2.Text := dm1.TT1.FieldByName('parsof').AsString;
  Edit3.Text := dm1.TT1.FieldByName('interest').AsString;
end;

procedure TFSoloMuri.DBGrid3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Pareti then CaricaDatiParete;
end;

procedure TFSoloMuri.DBGrid3KeyPress(Sender: TObject; var Key: Char);
begin
  if Pareti then CaricaDatiParete;
end;

procedure TFSoloMuri.DBGrid3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Pareti then CaricaDatiParete;
end;

end.


