unit Fconsigli;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls,libreriagenerale;

type
  TF_consigli = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  F_consigli: TF_consigli;
Procedure consiglio;

implementation
uses gesterrori, U3dsd,Init_cad3d;
{$R *.dfm}
Procedure consiglio;
procedure disp_cons(mm:string);
begin
f_consigli.Memo1.Clear;
f_consigli.Memo1.lines.Add(mm);
end;
begin
F_consigli:=TF_consigli.create(Nil);
F_consigli.Button2.Visible:=false;
  case errorecor of
  0:disp_cons('Le elaborazioni richieste si sono concluse con successo , potete produrre gli elaborati  (stampe e disegni )' );
  1:disp_cons('Irregolarità durante le elaborazioni ,doppio click sulla lista egli errori per ottenere indicazioni dettagliate e nuovamente su questo pulsante per ottenere consigli specifici');
  2:begin
    disp_cons('Porre il programma in modalità CADESTERNO ( 1 ) ,avviare Il cad esterno se non avviato in precedenza ( 2 )');
    F_consigli.Button2.Visible:=true;
    end;
  3:begin
    disp_cons('Inserire una piano nell''elenco piani');
    F_consigli.Button2.Visible:=true;
    end;
  else disp_cons('Nessuna indicazione per questo caso');
  end;
if fileexists(I_sl(percorsodrive)+'risorsecad\'+inttostr(errorecor)+'.jpg') then
f_consigli.Image1.Picture.LoadFromFile(I_sl(percorsodrive)+'risorsecad\'+inttostr(errorecor)+'.jpg');
F_consigli.Showmodal;
end;
procedure TF_consigli.FormClose(Sender: TObject; var Action: TCloseAction);
begin
action:=cafree;
end;

procedure TF_consigli.Button1Click(Sender: TObject);
begin
Close;
end;

procedure TF_consigli.Button2Click(Sender: TObject);
begin
with form1 do
case errorecor of
2:PassaAlCad;
3:pagecontrol1.ActivePageIndex:=3;
end;
close;
end;

end.
