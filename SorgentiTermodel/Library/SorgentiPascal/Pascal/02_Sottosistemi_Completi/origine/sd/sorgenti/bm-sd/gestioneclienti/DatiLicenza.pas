unit DatiLicenza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, jpeg;

type
  TFDatilicenza = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button2: TButton;
    Shape2: TShape;
    Label7: TLabel;
    Label8: TLabel;
    Image2: TImage;
    Shape3: TShape;
    Label9: TLabel;
    Label10: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FDatilicenza: TFDatilicenza=Nil;
Procedure GestDatiLicenza;

implementation
uses chiedilicenza;
{$R *.dfm}

Procedure GestDatiLicenza;
begin
if Fdatilicenza=nil then Fdatilicenza:=TFdatilicenza.Create(nil);
  begin
  Fdatilicenza.Label2.caption:=cliente;
  //Fdatilicenza.Label3.caption:=Indirizzo1;
  //Fdatilicenza.Label4.caption:=Indirizzo2;
  //Fdatilicenza.Label6.caption:=Utilizzo;
  end;
Fdatilicenza.ShowModal;
end;

procedure TFDatilicenza.Button1Click(Sender: TObject);
begin
FDatilicenza.close;
end;

procedure TFDatilicenza.Button2Click(Sender: TObject);
begin
GestChiedilicenza;
Fdatilicenza.Label2.caption:=cliente;
end;

end.
