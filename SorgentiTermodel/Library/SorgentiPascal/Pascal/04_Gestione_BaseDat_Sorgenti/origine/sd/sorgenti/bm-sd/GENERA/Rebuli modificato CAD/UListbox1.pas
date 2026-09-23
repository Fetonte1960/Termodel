unit UListbox1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TFListbox = class(TForm)
    ListBox1: TListBox;
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FListbox: TFListbox;

Function seleziona:string;

implementation

{$R *.DFM}

Var selezione:string;
procedure TFListbox.ListBox1DblClick(Sender: TObject);
begin
FListBox.close;
selezione:=listbox1.items.strings[listbox1.itemindex];
end;
Function seleziona:string;
begin
FListBox.showmodal;
result:=selezione;
end;
end.
