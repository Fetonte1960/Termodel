unit FMessValLim;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, LbSpeedButton;

type
  TFormMessValLim = class(TForm)
    Panel_Area: TPanel;
    P_Bottoni: TPanel;
    B_OK: TLbSpeedButton;
    Image: TImage;
    LFrase1: TLabel;
    LFrase2: TLabel;
    procedure B_OKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMessValLim: TFormMessValLim;

implementation

{$R *.dfm}

procedure TFormMessValLim.B_OKClick(Sender: TObject);
begin
  close;
end;

end.
