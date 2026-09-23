unit Errori3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, StdCtrls, ExtCtrls;

type
  TFErrori3d = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Button4: TLbSpeedButton;
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FErrori3d: TFErrori3d;

implementation

{$R *.dfm}

procedure TFErrori3d.Button4Click(Sender: TObject);
begin
close;
end;

end.
