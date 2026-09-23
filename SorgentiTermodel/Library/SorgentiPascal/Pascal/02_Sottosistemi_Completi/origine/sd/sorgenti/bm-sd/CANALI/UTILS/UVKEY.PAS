unit Uvkey;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs,key, StdCtrls, Grids;

type
  TForm1 = class(TForm)
    s1: TStringGrid;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormActivate(Sender: TObject);
var i,j,k,l:integer;
begin
  l:=1;
  for i:=1 to 5 do
  for j:=1 to 6 do
  begin
    k:=lettura(l);
    s1.cells[i,j]:=inttostr(k);
    inc(l);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var i,j,k,l:integer;
begin
  l:=1;
  for i:=1 to 5 do
  for j:=1 to 6 do
  begin
    k:=801;
    writekey(l,k);
    inc(l);
  end;
end;

end.
