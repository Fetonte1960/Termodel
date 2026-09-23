unit UPrepStampe;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  QuickRpt, StdCtrls;

type
  TPrepStampa = class(TForm)
    ReportPrinc: TQRCompositeReport;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ReportPrincAddReports(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PrepStampa: TPrepStampa;

implementation

uses UStampe, UDB, Ustampa2;

{$R *.DFM}

procedure TPrepStampa.Button1Click(Sender: TObject);
begin
 {stampa1.im1.picture.loadfromfile('c:\ded\sorgenti\rebuli\resources\fiore.bmp');}
 ReportPrinc.preview;
end;

procedure TPrepStampa.ReportPrincAddReports(Sender: TObject);
begin
ReportPrinc.Reports.add(stampa1);
ReportPrinc.Reports.add(stampa2);
end;

end.
