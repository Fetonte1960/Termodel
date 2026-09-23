unit Uprova;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls,definiz;

type
  TForm1 = class(TForm)
    Button1: TButton;
    l1: TListBox;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure aggiornapezzo(var Message: Tmessage); message wm_user+101;
    { Private declarations }
  public
    { Public declarations }
  end;
  type punpezzi=^recpezzi;
var
  Form1: TForm1;

  var unpezzo:punpezzi;
procedure settaparametri(var apezzi:punpezzi;un:integer;aparente:hwnd);
implementation
procedure settaparametri(var apezzi:punpezzi;un:integer;aparente:hwnd); external 'vpezzi';
{$R *.DFM}

procedure tform1.aggiornapezzo(var Message: Tmessage);
var i:integer;
begin
l1.items.clear;
for i:=1 to maxd do
with unpezzo^.tabdescr[i] do
begin
  if descr>'' then
  l1.items.add(descr+' '+valor+' '+attrib)
end;
LABEL1.CAPTION:=UNPEZZO^.CODICE;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  fillchar(unpezzo^,sizeof(unpezzo^),0);
  with unpezzo^ do
  begin
   codice:=edit1.text;
   a:=500;
   b:=250;
   r:=0;
   perd:=8.2;
   port:=1200;
   rag:=1.5;
   ang:=90;
   varie:=2
  end;
  settaparametri(unpezzo,0,handle);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  new(unpezzo);
end;

end.

