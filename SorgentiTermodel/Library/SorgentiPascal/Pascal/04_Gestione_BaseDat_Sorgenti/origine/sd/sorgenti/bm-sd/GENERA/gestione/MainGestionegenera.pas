unit MainGestionegenera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ExtCtrls,libreriagenerale,Init_easy,config_var,Udbt,gestudb,
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
    AggiornaBasedati1: TMenuItem;
    Panel1: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    SaveDialog1: TSaveDialog;
    V1: TMenuItem;
    Pers11: TMenuItem;
    Pers21: TMenuItem;
    Pers31: TMenuItem;
    Pers41: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure Nuovo1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Aggiornafilediprogetto1Click(Sender: TObject);
    procedure V1Click(Sender: TObject);
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
begin
Gest_menu((sender as Tmenuitem).Caption);
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
      pers11.visible:=true;
      pers11.Caption:=Testo;
      pers11.Add(newitem1);
      end
    else
      begin
      if not pers21.visible then
        begin
        pers21.visible:=true;
        pers21.Caption:=Testo;
        pers21.Add(newitem1);
        end
      else
        begin
        pers31.visible:=true;
        pers31.Caption:=Testo;
        pers31.Add(newitem1);
        end;
      end
    end;
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


procedure TFGestioneGenera.FormCreate(Sender: TObject);
Var ff:textfile;
    tt:string;
begin
PercorsoDrive:=extractfilepath(application.ExeName);
percorsodrive:=I_sl(PercorsoDrive);
perc1:=percorsodrive;

If {true then //}fileexists(leggi_var('PROG_COR')) then
  begin
  nomeprog:=leggi_var('PROG_COR');
  Nome:=copy(extractfilename(nomeprog),1,length(extractfilename(nomeprog))-4);
  //Perc:=extractfilepath(nomeprog);
  //perc:=I_sl(perc);
  initUdbT(perc1+'database',perc1+'database');
  NuovoUdbT;
  ApriTxtUDBT(perc1+'database',nomeprog);
  OpenUDBT;
  Apriprog;
  end
else
  begin
  Savedialog1.execute;
  nomeProg:=savedialog1.FileName;
  Nome:=copy(extractfilename(nomeprog),1,length(extractfilename(nomeprog))-4);
  Perc:=extractfilepath(nomeprog);
  perc:=I_sl(perc);
  Nuovoprog;
  perc:=perc+nome+'\';
  nomeprog:=perc+nome+'.EPG';
  if nomeprog='' then exit;
  initUdbT(perc1+'database',perc1+'database');
  NuovoUdbT;
  OpenUDBT;
  end;
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
Savedialog1.execute;
nomeProg:=savedialog1.FileName;
Nuovoprog;
Vis_caption;
end;

procedure TFGestioneGenera.Button1Click(Sender: TObject);
begin
if nomeprog<>noname then
  begin
  salva_var('PROG_COR',Nomeprog);
  SaveUdBT(Nomeprog);
  end;
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

end.
