unit MainGestionegenera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls,libreriagenerale,Init_easy,config_var,Udbt,gestudb,Calcolo,
  {$Ifdef master}
  gestdb,
  {$Endif}
  UOpen_fileMulti;

type
  TFGestioneGenera = class(TForm)
    MainMenu1: TMainMenu;
    F1: TMenuItem;
    Nuovo1: TMenuItem;
    Generaapplicazione1: TMenuItem;
    Aggiornafilediprogetto1: TMenuItem;
    Panel1: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    V1: TMenuItem;
    Pers11: TMenuItem;
    Pers21: TMenuItem;
    Pers31: TMenuItem;
    Pers41: TMenuItem;
    Apri1: TMenuItem;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Button3: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Nuovo1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Aggiornafilediprogetto1Click(Sender: TObject);
    procedure V1Click(Sender: TObject);
    procedure Apri1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
  Procedure ADD_menu(Testo:string;Elementi:Tstringlist);
  procedure Eseguimenu(Sender: TObject);
    { Public declarations }
  end;

var
  FGestioneGenera: TFGestioneGenera;

const
      Noname='Progetto senza nome';
Var   Nomeprog:string=Noname;
Var out_sorg,out_base,nome,perc,perc1:string;

implementation

{$R *.dfm}

Procedure Vis_Caption;
begin
FGestioneGenera.Caption:=nomeapp+'('+Nomeprog+')';
end;

Procedure ApriProgetto;
begin
end;

procedure TFGestioneGenera.eseguimenu(Sender: TObject);
Var voce,voce1:string;
    i:integer;
begin
voce:=(sender as Tmenuitem).Caption;
voce1:='';
for i:=1 to length(voce) do
if voce[i]<>'&' then
voce1:=voce1+voce[i];
Gest_menu(voce1);
end;

Procedure TFGestioneGenera.ADD_menu(Testo:string;Elementi:Tstringlist);
var
  NewItem,Newitem1: TMenuItem;
  I : integer;
begin
  //NewItem := TMenuItem.Create(nil);
  //NewItem.Caption :=Testo;
  //mainmenu1.InsertComponent(NewItem);
  for i:=1 to elementi.Count do
    begin
    newItem1:= TMenuItem.Create(nil);
    NewItem1.onclick :=eseguimenu;
    Newitem1.Caption:=elementi.Strings[i-1];
    if not pers11.visible then
      begin
      pers11.Caption:=Testo;
      pers11.Add(newitem1);
      end
    else
      begin
      if not pers21.visible then
        begin
        pers21.Caption:=Testo;
        pers21.Add(newitem1);
        end
      else
        begin
        pers31.Caption:=Testo;
        pers31.Add(newitem1);
        end;
      end;
    end;  
    if not pers11.visible then
    pers11.visible:=true
    else
    if not pers21.visible then
    pers21.visible:=true
    else
    pers31.visible:=true;

  (*
  //Nuovo1.Add(NewItem);
  { now create and add a menu item for each form }
  for  I := 0 to Screen.FormCount-1 do
  begin
    NewItem := TMenuItem.Create(Self);
    NewItem.Caption := Screen.Forms[I].Name;
    Windows.Add(NewItem);
  *)

end;


Procedure Nuovo_progetto;
begin
with FGestioneGenera do
  begin
  Savedialog1.execute;
  nomeProg:=savedialog1.FileName;
  Nome:=copy(extractfilename(nomeprog),1,length(extractfilename(nomeprog))-4);
  Perc:=extractfilepath(nomeprog);
  perc:=I_sl(perc);
  createdir(perc+nome);
  Nuovoprog;
  perc:=perc+nome+'\';
  nomeprog:=perc+nome+'.EPG';
  if nomeprog='' then exit;
  closeUdbt;
  NuovoUdbT;
  OpenUDBT;
  Apriprog;
  end;
end;

Procedure Apri_progetto;
begin
  nomeprog:=leggi_var('PROG_COR');
  Nome:=copy(extractfilename(nomeprog),1,length(extractfilename(nomeprog))-4);
  //Perc:=extractfilepath(nomeprog);
  //perc:=I_sl(perc);
  closeUdbt;
  NuovoUdbT;
  ApriTxtUDBT(perc1+'database',nomeprog);
  OpenUDBT;
  Apriprog;
end;

procedure TFGestioneGenera.FormCreate(Sender: TObject);
Var ff:textfile;
    tt:string;
begin
{$Ifdef master}
Button2.Visible:=true;
{$Endif}
PercorsoDrive:=extractfilepath(application.ExeName);
percorsodrive:=I_sl(PercorsoDrive);
perc1:=percorsodrive;
initUdbT(perc1+'database',perc1+'database');

nomeProg:=leggi_var('PROG_COR');
If not fileexists(leggi_var('PROG_COR')) then Nuovo_progetto else apri_progetto;
{
  Begin
  Opendialog1.execute;
  nomeProg:=Opendialog1.FileName;
  salva_var('PROG_COR',Nomeprog);
  end;
}
if nomeProg='' then  exit;

Init_app;
tt:=I_sl(percorsodrive)+'PathProg.txt';
assignfile(ff,tt);
rewrite(ff);
writeln(ff,I_sl(percorsodrive)+'Database');
closefile(ff);
Vis_caption;
end;

procedure TFGestioneGenera.Nuovo1Click(Sender: TObject);
Var perc,nome:string;
begin
closeUDBT;
Nuovo_progetto;
Vis_caption;
end;

procedure TFGestioneGenera.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFGestioneGenera.Aggiornafilediprogetto1Click(Sender: TObject);
begin
Aggiorna_file;
end;

procedure TFGestioneGenera.V1Click(Sender: TObject);
begin
{$Ifdef master}
Gest_Base_dati;
{$Endif}
end;

procedure TFGestioneGenera.Apri1Click(Sender: TObject);
begin
Opendialog1.execute;
nomeProg:=Opendialog1.FileName;
salva_var('PROG_COR',Nomeprog);
closeUDBT;
apri_progetto;
Vis_caption;
end;

procedure TFGestioneGenera.Button2Click(Sender: TObject);
begin
eseguiprogramma('C:\Programmi\Borland\Delphi6\Bin\Delphi32.exe',out_sorg+'Projectgroup.bpg');
end;

procedure TFGestioneGenera.Button3Click(Sender: TObject);
begin
Calcolo_generale;
end;

procedure TFGestioneGenera.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
if nomeprog<>noname then
  begin
  salva_var('PROG_COR',Nomeprog);
  SaveUdBT(Nomeprog);
  end;
end;

end.
