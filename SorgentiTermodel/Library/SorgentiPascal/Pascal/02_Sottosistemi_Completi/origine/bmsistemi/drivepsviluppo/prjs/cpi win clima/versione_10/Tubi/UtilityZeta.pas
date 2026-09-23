unit UtilityZeta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,libreriagenerale;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Ediam: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EPrev: TEdit;
    Label3: TLabel;
    EPort: TEdit;
    Label4: TLabel;
    LZeta: TLabel;
    Label5: TLabel;
    Lvel: TLabel;
    Label6: TLabel;
    LWatt: TLabel;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
Var perdita,vel,port,diam:real;
const densh2O=973; //Kg/l
begin
diam:=str_tofloat(Ediam.text)/1000;// da mm a m
port:=str_tofloat(Eport.text)/(densh2O/1000)/3600/1000;// da Kg/H a mc/s
LWatt.Caption:=float_to_str((Port*1000)*4180*10,2);
Perdita:=str_tofloat(Eprev.text)*1000;//da KPa a Pa
vel:=Port/(sqr(diam/2)*Pi);
Lvel.caption:=float_to_str(vel,2);
LZeta.caption:=float_to_str(Perdita/(DensH2O*sqr(vel)/2),2);
end;

end.
