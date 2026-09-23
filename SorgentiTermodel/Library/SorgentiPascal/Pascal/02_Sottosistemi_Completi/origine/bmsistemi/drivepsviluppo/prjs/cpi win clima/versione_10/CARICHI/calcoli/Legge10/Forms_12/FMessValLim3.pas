unit FMessValLim3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, LbSpeedButton;

type
  TFormMessValLim3 = class(TForm)
    Panel_Area: TPanel;
    P_Bottoni: TPanel;
    B_OK: TLbSpeedButton;
    LFrase1: TLabel;
    LFrase2: TLabel;
    Image: TImage;
    procedure B_OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMessValLim3: TFormMessValLim3;

implementation

{$R *.dfm}

procedure TFormMessValLim3.B_OKClick(Sender: TObject);
begin
  close;
end;

end.
