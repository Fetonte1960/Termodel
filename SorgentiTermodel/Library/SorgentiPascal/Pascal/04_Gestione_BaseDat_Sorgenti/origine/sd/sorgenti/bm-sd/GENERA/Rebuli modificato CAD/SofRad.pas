unit SofRad;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, ComCtrls, Tabnotbk, DBCtrls, Db, DBTables, Grids,
  DBGrids, StdCtrls, Mask,uDatalink, Buttons,Uinterattiva;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Apri1: TMenuItem;
    Apri2: TMenuItem;
    Panel1: TPanel;
    OpenDialog1: TOpenDialog;
    Panel2: TPanel;
    Disegno: TImage;
    DataSource1: TDataSource;
    Etic1: TLabel;
    etic2: TLabel;
    SaveDialog1: TSaveDialog;
    Calcoli1: TMenuItem;
    Calcolodelcaricotermico1: TMenuItem;
    Datigeneraliperilcalcolo1: TMenuItem;
    DispTab1: TTable;
    Allineamentoquadrotti1: TMenuItem;
    Orizzontale1: TMenuItem;
    Verticale1: TMenuItem;
    Destra: TMenuItem;
    Centro1: TMenuItem;
    Sinistra: TMenuItem;
    Alto: TMenuItem;
    Centro2: TMenuItem;
    Basso: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Stampa1: TMenuItem;
    TabbedNotebook1: TTabbedNotebook;
    GroupBox1: TGroupBox;
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
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    DBEdit14: TDBEdit;
    DBEdit15: TDBEdit;
    GroupBox2: TGroupBox;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    Panel6: TPanel;
    DBNavigator4: TDBNavigator;
    GroupBox3: TGroupBox;
    Label12: TLabel;
    Label13: TLabel;
    Label37: TLabel;
    Label56: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit21: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit8: TDBEdit;
    GroupBox7: TGroupBox;
    DBText1: TDBText;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Button1: TButton;
    DBEdit6: TDBEdit;
    GroupBox8: TGroupBox;
    DBText2: TDBText;
    Label14: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    DBText3: TDBText;
    Label38: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    DBText4: TDBText;
    GroupBox4: TGroupBox;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
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
    DBText5: TDBText;
    DBText6: TDBText;
    DBText7: TDBText;
    DBText8: TDBText;
    Panel4: TPanel;
    DBEdit22: TDBEdit;
    DBEdit23: TDBEdit;
    DBEdit24: TDBEdit;
    Panel5: TPanel;
    DBNavigator3: TDBNavigator;
    GroupBox5: TGroupBox;
    Label57: TLabel;
    Label58: TLabel;
    Label59: TLabel;
    DBText10: TDBText;
    Label60: TLabel;
    Label61: TLabel;
    DBText11: TDBText;
    Label62: TLabel;
    DBEdit25: TDBEdit;
    DBGrid1: TDBGrid;
    Panel7: TPanel;
    DBNavigator1: TDBNavigator;
    GroupBox9: TGroupBox;
    DBEdit26: TDBEdit;
    Label64: TLabel;
    Label65: TLabel;
    DBComboBox2: TDBComboBox;
    Label66: TLabel;
    DBEdit27: TDBEdit;
    GroupBox10: TGroupBox;
    Label67: TLabel;
    Label68: TLabel;
    Label69: TLabel;
    Label70: TLabel;
    Panel3: TPanel;
    DBNavigator2: TDBNavigator;
    GSuperfici: TGroupBox;
    Panel8: TPanel;
    DBNavigator5: TDBNavigator;
    DBGrid2: TDBGrid;
    DataSource2: TDataSource;
    Archiviopareti1: TMenuItem;
    Archiviofinrstre1: TMenuItem;
    BSuperfici: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Archiviodelleesposizioni1: TMenuItem;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    Label3: TLabel;
    DBEdit5: TDBEdit;
    Label4: TLabel;
    Label5: TLabel;
    Datigenerali1: TMenuItem;
    PanelLente: TPanel;
    Lente: TImage;
    chorto: TCheckBox;
    BParete: TButton;
    BCancella: TButton;
    BFinestra: TButton;
    procedure Apri2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Apri1Click(Sender: TObject);
    procedure SaveDialog1CanClose(Sender: TObject; var CanClose: Boolean);
    procedure Panel1Resize(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure Calcolodelcaricotermico1Click(Sender: TObject);
    procedure Datigeneraliperilcalcolo1Click(Sender: TObject);
    procedure DestraClick(Sender: TObject);
    procedure Centro1Click(Sender: TObject);
    procedure SinistraClick(Sender: TObject);
    procedure AltoClick(Sender: TObject);
    procedure Centro2Click(Sender: TObject);
    procedure BassoClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure Stampa1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Archiviopareti1Click(Sender: TObject);
    procedure Archiviofinrstre1Click(Sender: TObject);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure BSuperficiClick(Sender: TObject);
    procedure Archiviodelleesposizioni1Click(Sender: TObject);
    procedure Datigenerali1Click(Sender: TObject);
    procedure DisegnoMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DisegnoMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DisegnoMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BPareteClick(Sender: TObject);
    procedure BCancellaClick(Sender: TObject);
    procedure BFinestraClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Procedure AllineaMenu(vert,orizz:string;aggdb:boolean);

var
  Form1: TForm1;
Var bloccaredraw:boolean;
    primopost:boolean;
    
implementation

uses Unit1, Grafica, UDati, UtilsGen, UDB, UCacoli, UDatigen, UStampe,
  UPrepStampe, {USceltaPann, UProvacomp,} UCalcoli, UFormgen, UListbox,
  UListbox1,Umaskgen,uruncomp;

{$R *.DFM}
Var rsz:boolean;

Procedure salvaDataDrive;
Var ff:textfile;
begin
assignfile(ff,Progdrive+'\path.fil');
rewrite(ff);
Writeln(ff,Data_Drive);
Writeln(ff,NomeCom);
closefile(ff);
end;


Procedure ActiveDisplayTab(Path:string);
var tl:integer;
begin
DM1.TT1.close;
DM1.TT1.Databasename:=Path;
DM1.TT1.Tablename:='Ambienti.db';
DM1.TT1.open;
DM1.TT2.close;
DM1.TT2.Databasename:=Path;
DM1.TT2.Tablename:='Default.db';
DM1.TT2.open;

DM1.TT3.close;
DM1.TT3.MasterFields:='Numero';
DM1.TT3.IndexName:='PerNumero';
DM1.TT3.Databasename:=Path;
DM1.TT3.Tablename:='Pareti.db';
DM1.TT3.open;
DM1.TT3.fields[0].visible:=false;
DM1.TT3.fields[1].visible:=false;
DM1.TT3.fields[2].displaywidth:=3;

Form1.DispTab1.Close;
Form1.DispTab1.DataBaseName:=Path;
Form1.DispTab1.TableName:='Ambienti.DB';
Form1.DispTab1.Open;

Datigen.DisplayTab2.Close;
Datigen.DisplayTab2.DataBaseName:=Path;
Datigen.DisplayTab2.TableName:='Default.DB';
Datigen.DisplayTab2.Open;
Redraw(bloccaredraw,form1.Disegno.Canvas,form1.Disegno,form1.Panel1,tl);
form1.caption:='Calcolo soffitti radianti     '+nomecom;
end;


procedure TForm1.Apri2Click(Sender: TObject);
begin
Opendialog1.Initialdir:=Data_drive;
Opendialog1.DefaultExt:='*.ref';
Opendialog1.execute;
Nomecom:=TogliEstensioneFile(Opendialog1.filename);
Data_drive:=SeparaPercorsoFile(Nomecom);
if not fileexists(nomecom+'\ambienti.db') then exit;
ActiveDisplayTab(Nomecom);
SalVaDataDrive;
end;

procedure TForm1.FormActivate(Sender: TObject);
Var ff:textfile;
begin
primopost:=true;
{bloccaredraw:=true;}
init_interattiva;
InitGrafica;
getdir(0,progdrive);
 if fileexists('path.fil') then
   begin
   assignfile(ff,'path.fil');
   reset(ff);
   readln(ff,Data_Drive);
   readln(ff,Nomecom);
   closefile(ff);
   if fileexists(nomecom+'\ambienti.db') then
   ActiveDisplayTab(Nomecom);
   end
else Data_drive:=progDrive;
 rsz:=true;
 {bloccaredraw:=false;}
 etic2.Caption:='';
 {gSuperfici.visible:=false;}

end;

procedure TForm1.Apri1Click(Sender: TObject);
begin
Savedialog1.DefaultExt:='*.ref';
Savedialog1.initialDir:=Data_drive;
Savedialog1.execute;
end;

procedure TForm1.SaveDialog1CanClose(Sender: TObject;
  var CanClose: Boolean);
Var ff:textfile;
begin
bloccaredraw:=true;
{showmessage(Savedialog1.filename);}
createdir(Savedialog1.filename);
{
if fileexist(Savedialog1.filename) then
  begin
  showmessage('Il file esiste già');
  exit;
  end;
}
nomecom:=Savedialog1.filename;
if nomecom[length(nomecom)-3]='.' then
nomecom:=TogliEstensioneFile(nomecom);
Data_drive:=separapercorsofile(Nomecom);

assignfile(ff,Nomecom+'.ref');
rewrite(ff);
writeln(ff,'Uncompressed');
closefile(ff);
{etic2.caption:=data_drive;}
DM1.TT1.close;
DM1.TT1.DatabaseName:=NomeCom;
CreaDataBase(DM1.TT1);
DM1.TT2.close;
DM1.TT2.DatabaseName:=NomeCom;
CreaDataBase(DM1.TT1);
ActiveDisplayTab(Nomecom);
initdefault(DM1.TT2,datigen.displaytab2);
SalVaDataDrive;
bloccaredraw:=false;

end;
procedure TForm1.Panel1Resize(Sender: TObject);
Var tl:integer;
begin
ultx:=-10;
if rsz then Redraw(bloccaredraw,Disegno.Canvas,Disegno,Panel1,tl);
{disegno.picture.Savetofile('C:\ded\sorgenti\rebuli\resources\fiore.bmp');}
end;

Procedure AllineaMenu(vert,orizz:string;aggdb:boolean);
Var rigadb:string;
begin
rigadb:=V_amb.Allinea;
if rigadb='' then rigadb:='CC';
if vert<>'' then
with form1 do
  begin
  rigadb[1]:=vert[1];
  Alto.checked:=False;
  centro2.checked:=False;
  Basso.checked:=False;
  case Vert[1] of
  'A':Alto.checked:=True;
  'C':Centro2.checked:=True;
  'B':Basso.checked:=True;
  end;
  end;
with form1 do
if Orizz<>'' then
  begin
  rigadb[2]:=orizz[1];
  Destra.checked:=False;
  centro1.checked:=False;
  Sinistra.checked:=False;
  case Orizz[1] of
  'D':Destra.checked:=True;
  'C':Centro1.checked:=True;
  'S':Sinistra.checked:=True;
  end;
  end;
dm1.tt1.edit;
if aggDb then V_amb.set_Allinea(rigadb);
dm1.tt1.post;
end;



procedure TForm1.DataSource1DataChange(Sender: TObject; Field: TField);
Var tl:integer;
begin
{
rsz:=true;
if not bloccaredraw then
  begin
  Redraw(bloccaredraw,Disegno.Canvas,Disegno,Panel1,tl);}
  {disegno.picture.Savetofile('C:\ded\sorgenti\rebuli\resources\fiore.bmp');}
{
  end;
with V_amb do
  begin
  if V_amb.allinea<>'' then AllineaMenu(allinea[1],allinea[2],false)
  else AllineaMenu('C','C',false)
  end;
 }
end;

procedure TForm1.Calcolodelcaricotermico1Click(Sender: TObject);
begin
Calcolo;
end;

procedure TForm1.Datigeneraliperilcalcolo1Click(Sender: TObject);
begin
Datigen.displaytab2.edit;
Datigen.ShowModal;
end;


procedure TForm1.DestraClick(Sender: TObject);
begin
Allineamenu('','D',true);
end;

procedure TForm1.Centro1Click(Sender: TObject);
begin
Allineamenu('','C',true);
end;

procedure TForm1.SinistraClick(Sender: TObject);
begin
Allineamenu('','S',true);
end;

procedure TForm1.AltoClick(Sender: TObject);
begin
Allineamenu('A','',true);
end;

procedure TForm1.Centro2Click(Sender: TObject);
begin
Allineamenu('C','',true);
end;

procedure TForm1.BassoClick(Sender: TObject);
begin
Allineamenu('B','',true);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
Allineamenu('','D',true);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
Allineamenu('','C',true);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
Allineamenu('','S',true);
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
Allineamenu('B','',true);
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
begin
Allineamenu('C','',true);
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
Allineamenu('A','',true);
end;

procedure TForm1.Stampa1Click(Sender: TObject);
begin
PrepStampa.show;
end;

procedure TForm1.Button1Click(Sender: TObject);
var a:string;
Var LHp,LLp,LTP,LTs:Integer;Var LDescr:string ;
begin
bloccaredraw:=true;
{chdir(progdrive);
FsceltaP.show;}
scegli(progdrive,LHp,LLp,LTP,LTs,LDescr);
dm1.tt1.open;
dm1.tt1.edit;
with V_amb do
  begin
  set_descrP(LDescr);
  set_LQ1(LLp);
  set_HQ1(LHp);
  set_Tp(LTp);
  set_Ts(LTs);
  end;
bloccaredraw:=false;
dm1.tt1.post;

end;

procedure TForm1.BitBtn9Click(Sender: TObject);
Var tl:integer;
begin
Redraw(bloccaredraw,Disegno.Canvas,Disegno,Panel1,tl);
CalcoloPann(Bloccaredraw,dm1.tt1,tl);
end;

procedure TForm1.Archiviopareti1Click(Sender: TObject);
begin
formgen('archivio delle pareti','muri');
end;

procedure TForm1.Archiviofinrstre1Click(Sender: TObject);
begin
formgen('archivio delle finestre','finestre');
end;
Var Xmouse,Ymouse:integer;
procedure TForm1.DBGrid2DblClick(Sender: TObject);
begin
dm1.tt3.edit;
case  Form1.DBGrid2.SelectedField.fieldno of
  5:begin
    if V_recPar.Tipo='Parete' then
       begin
       formgen('archivio delle pareti','muri');
       V_recPar.Set_Cod(V_recmuri.cod);
       end
    else
       begin
       if V_recPar.Tipo='Finestra' then
         begin
         formgen('archivio delle finestre','Finestre');
         V_recPar.Set_Cod(V_recfin.cod);
         V_recPar.Set_Sup(V_recfin.SupUn);
         V_recPar.Set_Num(1);
         end
       else
         begin
         V_recPar.Set_Tipo(seleziona);
         IF V_recPar.Tipo<>'Parete' then
         V_recPar.Set_Lato('-');
         end;
       end;
    end;
  4:begin
    V_recPar.Set_Tipo(seleziona);
    IF V_recPar.Tipo<>'Parete' then
    V_recPar.Set_Lato('-');
    end;
  3:begin
    formgen('archivio delle esposizioni','esposiz');
    V_recPar.Set_Lato(V_recesp.cod);
    if (V_recPar.Lato<>'-')and(V_recPar.Lato<>'') then
      begin
      V_recPar.Set_Tipo('Parete');
        case V_recPar.Lato[1] of
        '1','3':
          begin
          V_recPar.set_Num(v_amb.L);
          V_recPar.set_sup(V_recPar.Num*V_amb.alt);
          end;
        '2','4':
          begin
          V_recPar.set_Num(v_amb.H);
          V_recPar.set_sup(V_recPar.Num*V_amb.alt);
          end;
         '5':V_recPar.set_sup(V_amb.L*V_amb.H);
        end;
      end;
    end;
  {8:formgen('archivio delle finestre','finestre');}
end;
dm1.tt3.POst;
end;

procedure TForm1.BSuperficiClick(Sender: TObject);
Var tl:Integer;
begin
if not primopost then exit;
primopost:=false;
{rsz:=true;}
if not bloccaredraw then
  begin
  Redraw(bloccaredraw,form1.Disegno.Canvas,form1.Disegno,form1.Panel1,tl);
  {disegno.picture.Savetofile('C:\ded\sorgenti\rebuli\resources\fiore.bmp');}

  end;
with V_amb do
  begin
  if V_amb.allinea<>'' then AllineaMenu(allinea[1],allinea[2],false)
  else AllineaMenu('C','C',false);
  CalcoloPann(bloccaredraw,dm1.tt1,tl);
  end;
primopost:=true;
{Gsuperfici.visible:=true;
Bsuperfici.visible:=false;}
end;


procedure TForm1.Archiviodelleesposizioni1Click(Sender: TObject);
begin
formgen('archivio delle esposizioni','esposiz');
end;

procedure TForm1.Datigenerali1Click(Sender: TObject);
begin
Usamaschera('generalita','Dati generali','Unità di misura °C');
end;

procedure TForm1.DisegnoMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i:integer;
begin
M_Move(x,y);
end;

procedure TForm1.DisegnoMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
M_down(button,X,Y);
end;

procedure TForm1.DisegnoMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
M_Up(button,X,Y);
end;

procedure TForm1.BPareteClick(Sender: TObject);
begin
ultx:=-10;
modo:=L_primop;
end;

procedure TForm1.BCancellaClick(Sender: TObject);
begin
ultx:=-10;
modo:=Cancella_p;
end;

procedure TForm1.BFinestraClick(Sender: TObject);
begin
ultx:=-10;
modo:=D_Finestra;
end;

end.
