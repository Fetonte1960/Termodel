unit Caricamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TFormCaricamento = class(TForm)
    Panel_Caricamento: TPanel;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCaricamento: TFormCaricamento;

implementation

{$R *.dfm}

procedure TFormCaricamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormCaricamento.FormCreate(Sender: TObject);
begin
  Label1.Caption := 'Calcolo dei carichi estivi...';
end;

end.
