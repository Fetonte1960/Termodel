unit Messaggio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TFMessaggio = class(TForm)
    Panel1: TPanel;
    MemoMessaggio: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    
  private
    { Private declarations }

  public
    { Public declarations }

  procedure messaggio(capt,mess:string);

  end;

var
  FMessaggio: TFMessaggio;

procedure vmessaggio(capt,mess:string);

implementation

{$R *.dfm}

procedure TFMessaggio.Button1Click(Sender: TObject);
begin
close;
end;

procedure TFMessaggio.messaggio(capt,mess:string);
begin
caption:=capt;
MemoMessaggio.Clear;
MemoMessaggio.Lines.Add(mess);
showmodal;
end;

procedure vmessaggio(capt,mess:string);
begin
FMessaggio:=TFMessaggio.Create(nil);
FMessaggio.Messaggio(capt,mess);
FreeAndNil(FMessaggio);
end;

end.


