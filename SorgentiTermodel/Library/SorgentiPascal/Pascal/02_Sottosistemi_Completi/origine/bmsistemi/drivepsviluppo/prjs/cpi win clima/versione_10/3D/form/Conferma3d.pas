unit Conferma3d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, LbSpeedButton;

type
  TFConferma = class(TForm)
    LbSpeedButton1: TLbSpeedButton;
    Binserisci: TLbSpeedButton;
    LbSpeedButton2: TLbSpeedButton;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure BinserisciClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConferma: TFConferma=nil;

Function chiediconferma(mess:string):integer;

implementation

{$R *.dfm}
Function conferma(caption,messagio:string):boolean;
begin
end;
Var pulsante:Integer;
Function chiediconferma(mess:string):integer;
begin
Pulsante:=0;
if Fconferma=nil then Fconferma:=tfconferma.create(nil);
with fconferma do
  begin
  Caption:='Projectbrowser';
  label1.caption:=mess+' ?';
  showmodal;
  end;
result:=pulsante;
{
case messagedlg(mess,mtConfirmation,[mbyes,mbno,mbcancel],0) of
mryes:result:=1;
mrno:result:=2;
mrcancel:result:=0;
}
end;

procedure TFConferma.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
fconferma:=nil;
end;

procedure TFConferma.LbSpeedButton1Click(Sender: TObject);
begin
Pulsante:=1;
close;
end;

procedure TFConferma.BinserisciClick(Sender: TObject);
begin
Pulsante:=1;
close;
end;

end.
