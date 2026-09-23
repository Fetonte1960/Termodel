unit Archpers3D;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,sceltaA,config_var;

type
  TFArchiviPers = class(TForm)
    Panel1: TPanel;
    Button21: TButton;
    Button1: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button21Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FArchiviPers: TFArchiviPers=nil;
Procedure Vis_percorso_archivi_pers;

implementation

{$R *.dfm}

Procedure Vis_percorso_archivi_pers;
begin
if FArchiviPers=nil then FArchiviPers:=TFArchiviPers.Create(nil);
with FArchiviPers do
  begin
  label2.caption:=Percorso_archivi_personali_in;
  showmodal;
  end;
end;

procedure TFArchiviPers.Button1Click(Sender: TObject);
Var tmp:string;
begin
tmp:=leggi_var('Percorso_archivi_personali');
Azzera_Archpers;
label2.caption:=Percorso_archivi_personali_in;
if label2.caption='' then label2.caption:=tmp;
end;

procedure TFArchiviPers.Button21Click(Sender: TObject);
begin
close;
end;

end.
