unit controlla3d;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, LbSpeedButton, StdCtrls, ExtCtrls, ComCtrls,gestudb,init_Cad3d;

type
  TFcontrolla3d = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Panel1: TPanel;
    TabSheet2: TTabSheet;
    Panel2: TPanel;
    Memo1: TMemo;
    Panel3: TPanel;
    Memo2: TMemo;
    LbSpeedButton1: TLbSpeedButton;
    LbSpeedButton2: TLbSpeedButton;
    LbSpeedButton3: TLbSpeedButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure LbSpeedButton1Click(Sender: TObject);
    procedure LbSpeedButton2Click(Sender: TObject);
    procedure LbSpeedButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fcontrolla3d: TFcontrolla3d;

Procedure Gestcontrolla3d(modo:integer);

implementation
uses u3dsd;
{$R *.dfm}

Procedure Gestcontrolla3d(modo:integer);
begin
openudbt;
FControlla3d:=TFcontrolla3d.Create(nil);
Fcontrolla3d.showmodal;
end;

procedure TFcontrolla3d.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TFcontrolla3d.LbSpeedButton1Click(Sender: TObject);
begin
nocambia:=true;
close;
end;

procedure TFcontrolla3d.LbSpeedButton2Click(Sender: TObject);
begin
Form1.Verifichedileggeart3111Click(nil);
end;

procedure TFcontrolla3d.LbSpeedButton3Click(Sender: TObject);
begin
Form1.Stampa1Click(nil)
end;

end.
