unit UmessaggiDB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFmessaggidb = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmessaggidb: TFmessaggidb;

implementation

{$R *.dfm}

procedure TFmessaggidb.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TFmessaggidb.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=caFree;
end;

end.
