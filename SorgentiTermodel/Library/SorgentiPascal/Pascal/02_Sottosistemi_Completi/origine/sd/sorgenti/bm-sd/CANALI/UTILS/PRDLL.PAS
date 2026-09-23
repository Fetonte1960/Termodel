unit Prdll;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs;

type
  TForm1 = class(TForm)
    procedure FormDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

function inv_mes(nomefile,header,inizio:pchar):boolean;
implementation
function inv_mes(nomefile,header,inizio:pchar):boolean; external 'w_mes';
{$R *.DFM}

procedure TForm1.FormDblClick(Sender: TObject);
begin
  inv_mes('pippo.msg','Pippo','Inserimento primalinea');
end;

end.
