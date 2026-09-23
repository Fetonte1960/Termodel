unit Tool_visualizza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons,grafica;

type
  TFTool_visualizza = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FTool_visualizza: TFTool_visualizza;
 
implementation

{$R *.dfm}

procedure TFTool_visualizza.BitBtn2Click(Sender: TObject);
begin
  set_cursor(Curzoom);
end;

procedure TFTool_visualizza.BitBtn1Click(Sender: TObject);
begin
  Zoom_estens;
end;

procedure TFTool_visualizza.ComboBox1Change(Sender: TObject);
begin
  cambiacontesto(ComboBox1.Text);
end;

end.
