unit Fins;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls;

type
  Tins = class(TForm)
    ListBox1: TListBox;
    procedure ListBox1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ins: Tins;

implementation

{$R *.DFM}

procedure Tins.ListBox1DblClick(Sender: TObject);
begin
  close;
end;

end.
