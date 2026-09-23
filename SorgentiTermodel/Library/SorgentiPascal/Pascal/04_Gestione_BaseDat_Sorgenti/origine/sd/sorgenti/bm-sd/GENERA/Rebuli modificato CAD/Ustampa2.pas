unit Ustampa2;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, Quickrpt, QRCtrls;

type
  Tstampa2 = class(TQuickRep)
    QRBand1: TQRBand;
    im1: TQRImage;
    QRLabel1: TQRLabel;
    QRDBText1: TQRDBText;
    procedure QuickRepNeedData(Sender: TObject; var MoreData: Boolean);
    procedure QRBand1BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
  private

  public

  end;

var
  stampa2: Tstampa2;

implementation

uses UDB;

{$R *.DFM}

procedure Tstampa2.QuickRepNeedData(Sender: TObject;
  var MoreData: Boolean);
begin
stampa2.im1.picture.loadfromfile('c:\ded\sorgenti\rebuli\resources\fiore.bmp');
end;

procedure Tstampa2.QRBand1BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
stampa2.im1.picture.loadfromfile('c:\ded\sorgenti\rebuli\resources\fiore.bmp');
end;

end.
