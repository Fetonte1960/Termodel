unit ChiediLicenza;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,libreriagenerale,datilicenza,utility_Mat;

type
  TFChiediLicenza = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    GroupBox1: TGroupBox;
    Button2: TButton;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FChiediLicenza: TFChiediLicenza=Nil;
  codlicenza:string='';
  cliente:string='';
  versione:string='13';
  indlicenza:integer;
Function GestChiedilicenza:boolean;
Function LicenzaOK:boolean;
Function verificalicenza:boolean;

const setupLic='C:\Documents and Settings\Conf_cad.dat';

implementation

{$R *.dfm}

Procedure Salvalicenza;
Var FF:text;
begin
assign(ff,setuplic);
rewrite(ff);
writeln(ff,codlicenza);
writeln(ff,cliente);
close(ff);
end;
Function GestChiedilicenza:boolean;
Var vers:string;
begin
result:=false;
If Fchiedilicenza=Nil then FChiedilicenza:=TFChiedilicenza.Create(nil);
FChiedilicenza.edit1.Text:='';
FChiedilicenza.edit2.Text:='';
FChiedilicenza.ShowModal;
cliente:=Fchiedilicenza.edit2.Text;
codlicenza:=Fchiedilicenza.edit1.text;
vers:='13';
if controlloLicenza(codlicenza,cliente,M_Cad,vers)<>'' then
  begin
  //GestDatilicenza;
  salvalicenza;
  result:=true;
  end;
end;

Function LicenzaOK:boolean;
Var ff:text;
begin
result:=false;
if fileexists(setupLic) then
  begin
  assign(ff,setupLic );
  reset(ff);
  readln(ff,codlicenza);
  if not eof(ff) then
  readln(ff,cliente);
  close(ff);
  result:=controlloLicenza(codlicenza,cliente,M_Cad,versione)<>'';
  end;
if not result then result:=Gestchiedilicenza;
end;
procedure TFChiediLicenza.Button1Click(Sender: TObject);
Var Vers:string;
begin
cliente:=edit2.Text;
codlicenza:=Fchiedilicenza.edit1.text;
vers:='13';
if controlloLicenza(codlicenza,cliente,M_Cad,vers)<>'' then
close
else showmessage('Codice di attivazione errato');
end;

Function verificalicenza:boolean;
begin
result:=false;
if controlloLicenza(codlicenza,cliente,M_Cad,versione)='' then
showmessage('Codice di attivazione errato')
else result:=true;
end;

procedure TFChiediLicenza.Button2Click(Sender: TObject);
begin
close;
end;

end.
