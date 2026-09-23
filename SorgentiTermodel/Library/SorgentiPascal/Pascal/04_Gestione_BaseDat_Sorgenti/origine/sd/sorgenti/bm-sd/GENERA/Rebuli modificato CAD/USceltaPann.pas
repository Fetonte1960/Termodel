unit USceltaPann;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  OleCtrls, CatFormProj1_TLB;

type
  TFsceltapann = class(TForm)
    CatFormX1: TCatFormX;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fsceltapann: TFsceltapann;

implementation

uses Uprovacomp;

{$R *.DFM}

procedure TFsceltapann.FormActivate(Sender: TObject);
begin
CatFormX1.show;
end;

end.
