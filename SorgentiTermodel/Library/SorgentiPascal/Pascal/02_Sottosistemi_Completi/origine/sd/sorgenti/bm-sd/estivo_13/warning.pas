unit warning;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,varcarichi,Varcarichi_estivo_14;

type
  TFWarning = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FWarning: TFWarning;
  war:boolean;
const
s_Locale='Locale';

Procedure Warn(mess:string);
Procedure controllogen;

implementation

{$R *.dfm}
Procedure EGen(mess:string);
begin
warn(mess);
erroregen:=true;
end;
Procedure controllogen;
Var i:integer;
begin
for i:=1 to nfrontiere do
with frontiere_d^[i]^ do
  begin
  if (codmuro<=0)or(codmuro>massimomuri) then Egen('Frontiera:'+inttostr(i)+' codice parete errato ('+inttostr(codmuro)+')');
  end;
end;
procedure TFWarning.FormCreate(Sender: TObject);
begin
war:=false;
erroregen:=false;
memo1.lines.clear;
end;

procedure TFWarning.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;
Procedure Warn(mess:string);
begin
War:=true;
FWarning.memo1.lines.add(mess);
end;
procedure TFWarning.FormActivate(Sender: TObject);
begin
if erroregen then caption:='Errori interni che impediscono il calcolo (contattare l''assistenza)';
end;

end.
