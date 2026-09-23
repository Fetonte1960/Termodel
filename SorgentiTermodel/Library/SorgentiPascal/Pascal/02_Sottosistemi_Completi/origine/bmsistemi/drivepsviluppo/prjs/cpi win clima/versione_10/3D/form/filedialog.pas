unit filedialog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, FileCtrl, StdCtrls, ExtCtrls, LbSpeedButton,config_var,libreriagenerale,
  Buttons,selectdir,conferma3d;

type
  TFFiledialog = class(TForm)
    Panel1: TPanel;
    EDNOME: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    LbSpeedButton1: TLbSpeedButton;
    Binserisci: TLbSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton15: TSpeedButton;
    ListBox1: TListBox;
    LbSpeedButton2: TLbSpeedButton;
    procedure BinserisciClick(Sender: TObject);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton15Click(Sender: TObject);
    procedure ListBox1DblClick(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FFiledialog: TFFiledialog=Nil;

Function dialogNuovoprogetto:string;
Procedure ListaProgetti(Var lb:Tlistbox);
Function dialogApriprogetto:string;


implementation
Var     modo:(apri,nuovo);

{$R *.dfm}
Var progsel:string;
Procedure ListaProgetti(Var lb:Tlistbox);
Var sr:Tsearchrec;
    trov:integer;
    Pbase,nomep:string;
begin
Pbase:=leggi_var('CARTELLAPROGETTI');
Pbase:=I_sl(pbase);
lb.Clear;
trov:=findfirst(Pbase+'*.*',faDirectory,sr);
while trov=0 do
with lb do
  begin
  if fileexists(Pbase+sr.Name+'\'+sr.Name+'.bmt') then
  items.Add(sr.Name);
  trov:=findnext(sr);
  end;
//importazione progetti BM
trov:=findfirst(Pbase+'*.bmt',faarchive,sr);
while trov=0 do
with lb do
  begin
  nomep:=copy(sr.Name,1,length(sr.Name)-4);
  if fileexists(Pbase+'Work_'+Nomep+'\disegno.txt') then
  items.Add(nomep);
  trov:=findnext(sr);
  end;
end;
Function dialogNuovoprogetto;
begin
modo:=nuovo;
progsel:='';
If FFiledialog=nil then fFiledialog:=TfFiledialog.Create(nil);
with FFiledialog do
  begin
  label6.caption:=leggi_var('CARTELLAPROGETTI');
  if not existdir(label6.caption) then  label6.caption:=selezionadir('Percorso di archiviazione dei progetti');
  if existdir(label6.caption) then
    begin
    Salva_var('CARTELLAPROGETTI',label6.caption);
    listaprogetti(listbox1);
    caption:='Projectbrowser:creazione di un nuovo progetto';
    label1.Visible:=true;
    label2.Visible:=true;
    ednome.Visible:=true;
    lbspeedbutton1.Caption:='Crea';
    showmodal;
    end
  else close;
  end;
result:=Progsel;
end;

Function dialogApriprogetto:string;
begin
modo:=apri;
progsel:='';
If FFiledialog=nil then fFiledialog:=TfFiledialog.Create(nil);
with FFiledialog do
  begin
  label6.caption:=leggi_var('CARTELLAPROGETTI');
  if not existdir(label6.caption) then  label6.caption:=selezionadir('Percorso di archiviazione dei progetti');
  if existdir(label6.caption) then
    begin
    Salva_var('CARTELLAPROGETTI',label6.caption);
    listaprogetti(listbox1);
    label1.Visible:=false;
    label2.Visible:=false;
    ednome.Visible:=false;
    lbspeedbutton1.Caption:='Apri';
    caption:='Projectbrowser:Apertura di un progetto';
    showmodal;
    end
  else close;
  end;
result:=Progsel;
end;

procedure TFFiledialog.BinserisciClick(Sender: TObject);
begin
Progsel:='';
close;
end;

procedure TFFiledialog.LbSpeedButton1Click(Sender: TObject);
Var perc:string;
begin
perc:=leggi_var('CARTELLAPROGETTI');
perc:=i_sl(perc);
if modo=nuovo then
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
      close;
      end;
    end;
  end
else
  begin
  if listbox1.itemindex>=0 then
    begin
    progsel:=Listbox1.Items[listbox1.itemindex];
    if fileexists(perc+progsel+'.bmt') then
    progsel:=perc+progsel+'.bmt'
    else progsel:=perc+progsel+'\'+progsel+'.bmt';
    close;
    end
  else showmessage('Selezionare un progetto dalla lista');
  end;
end;

procedure TFFiledialog.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
FFiledialog:=nil;
end;

procedure TFFiledialog.SpeedButton15Click(Sender: TObject);
Var perc:string;
begin
perc:=selezionadir('Cartella base per l''archiviazione');
if existdir(perc) then
  begin
  Salva_var('CARTELLAPROGETTI',perc);
  label6.Caption:=perc;
  Listaprogetti(listbox1);
  end;
end;

procedure TFFiledialog.ListBox1DblClick(Sender: TObject);
begin
LbSpeedButton1Click(nil);
end;

procedure TFFiledialog.LbSpeedButton2Click(Sender: TObject);
Var perc:string;
begin
if listbox1.itemindex>=0 then
  begin
  perc:=Listbox1.Items[listbox1.itemindex];
  perc:= label6.Caption+'\'+perc;
  if chiediconferma('Siete sicuri di volere eliminare il progetto :'+chr(13)+'" '+perc+' "')=1 then
    begin
    cancellafilecartella(perc);
    removedir(perc);
    listaprogetti(listbox1);
    end;
  end
else
showmessage('Selezionare un progetto');
end;

end.
