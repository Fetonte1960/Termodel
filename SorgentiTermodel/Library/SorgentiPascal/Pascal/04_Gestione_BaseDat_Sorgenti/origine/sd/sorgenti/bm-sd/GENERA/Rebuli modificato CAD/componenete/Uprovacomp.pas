unit Uprovacomp;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, CatFormProj1_TLB, StdCtrls;

type
  TForm1 = class(TForm)
    CatFormX1: TCatFormX;
    Button1: TButton;
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

procedure TForm1.Button1Click(Sender: TObject);
begin
CatFormX1.show;
end;

end.
