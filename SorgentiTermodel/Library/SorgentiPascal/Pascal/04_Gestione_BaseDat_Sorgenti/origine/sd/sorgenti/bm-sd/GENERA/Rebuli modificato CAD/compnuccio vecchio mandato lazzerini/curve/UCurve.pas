unit UCurve;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFprovacurve = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fprovacurve: TFprovacurve;

implementation

uses Uusacurve;

{$R *.DFM}

procedure TFprovacurve.Button1Click(Sender: TObject);
begin
Usacurve.showmodal;
end;

end.
