unit UStampe;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  TStampa1 = class(TQuickRep)
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
  private

  public

  end;

var
  Stampa1: TStampa1;

implementation

uses UDB,dialogs;

{$R *.DFM}

procedure TStampa1.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
  var i:integer;
begin
showmessage('ok');
end;

end.
