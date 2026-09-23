unit UProvapsicro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,
  Diagramma;

type
  TFProvaPsicro = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FProvaPsicro: TFProvaPsicro;

implementation

{$R *.dfm}

procedure TFProvaPsicro.Button1Click(Sender: TObject);
begin
PuntoDiagramma(strtofloat(edit1.text),strtofloat(edit2.text));
end;

end.
