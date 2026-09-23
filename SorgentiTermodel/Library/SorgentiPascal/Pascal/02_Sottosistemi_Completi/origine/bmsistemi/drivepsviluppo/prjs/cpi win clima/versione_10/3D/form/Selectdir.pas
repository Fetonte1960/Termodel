unit Selectdir;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, StdCtrls, FileCtrl,libreriagenerale;

type
  TFseldir = class(TForm)
    DirectoryListBox1: TDirectoryListBox;
    DriveComboBox1: TDriveComboBox;
    Label1: TLabel;
    LbSpeedButton1: TLbSpeedButton;
    Binserisci: TLbSpeedButton;
    LbSpeedButton2: TLbSpeedButton;
    Edit1: TEdit;
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure BinserisciClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LbSpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fseldir: TFseldir=Nil;
Function selezionadir(messaggio:string):string;

implementation

{$R *.dfm}
Var dir_sel:string;
Function selezionadir(messaggio:string):string;
begin
dir_sel:='';
if  Fseldir=nil then Fseldir:=TFseldir.Create(nil);
with Fseldir do
  begin
  caption:=messaggio;
  showmodal;
  end;
result:=dir_sel;
end;

procedure TFseldir.LbSpeedButton1Click(Sender: TObject);
begin
 dir_sel:=DirectoryListBox1.Directory;
 close;
end;

procedure TFseldir.BinserisciClick(Sender: TObject);
begin
 dir_sel:='';
 close;
end;

procedure TFseldir.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
Fseldir:=nil;
end;

procedure TFseldir.LbSpeedButton2Click(Sender: TObject);
begin
if not createdir(DirectoryListBox1.Directory+'\'+edit1.text) then showmessage('Impossibile creare la directory')
else
  begin
  DirectoryListBox1.Directory:=DirectoryListBox1.Directory+'\'+edit1.text;
  DirectoryListBox1.Update;
  end;
end;

end.
