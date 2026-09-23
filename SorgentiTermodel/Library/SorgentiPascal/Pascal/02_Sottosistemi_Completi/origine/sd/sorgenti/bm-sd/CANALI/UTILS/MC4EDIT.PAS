unit Mc4edit;

interface

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, StdCtrls{,menusfins};


type tipi=(Intero,Reale,Stringa);

type
  Tmc4edit = class(TEdit)
  private
   ftipo:tipi;
   fnumero,finteri,fdecimali:integer;
   numass:boolean;
   procedure KeyPress(var Key: Char); override;
   procedure settipo(const value:tipi);
   procedure setnumero(const value:integer);
   function  getnumero:integer;
   procedure setinteri(const value:integer);
   procedure setdecimali(const value:integer);
   procedure WMLButtonDblClk(var Message: TWMLButtonDblClk); message WM_LBUTTONDBLCLK;
    { Private declarations }
  protected
    procedure SetName(const Value: TComponentName); override;
    { Protected declarations }
  public

    constructor Create(AOwner: TComponent); override;
    { Public declarations }
  published
    property Mc4_Tipo:tipi read ftipo write settipo;
    property Mc4_Numero:integer read getnumero write setnumero;
    property Mc4_Interi:integer read finteri write setinteri ;
    property Mc4_Decimali:integer read fdecimali write setdecimali ;
    { Published declarations }
  end;

procedure Register;

implementation


procedure tmc4edit.KeyPress(var Key: Char);
begin
  inherited keypress(key);
  case Mc4_tipo of
   Intero
   :if not (key in['-','0'..'9',#8])  then
      begin
         messagedlg('Il campo accetta solo numeri interi',mtinformation,[mbok],0);
         key:=#0;
      end;
   Reale
   :if not (key in['-','.','0'..'9',#8])  then
      begin
         messagedlg('Il campo accetta solo numeri reali',mtinformation,[mbok],0);
         key:=#0;
      end;
  end;
end;

procedure tmc4edit.settipo(const value:tipi);
begin
  ftipo:=value;
end;

procedure tmc4edit.WMLButtonDblClk(var Message: TWMLButtonDblClk);
Begin
  inherited;
 { if ins=nil then application.createform(tins,ins);
  ins.showmodal;}
End;

function tmc4edit.getnumero:integer;
begin
  if not numass then result:=taborder
  else
  result:=fnumero;
end;

procedure tmc4edit.setnumero(const value:integer);
begin
  fnumero:=value;
  numass:=true;

end;

procedure tmc4edit.setinteri(const value:integer);
begin
  finteri:=value;
end;


procedure tmc4edit.setdecimali(const value:integer);
begin
  fdecimali:=value;
end;


constructor tmc4edit.Create(AOwner: TComponent);
begin
  inherited create(Aowner);
  numass:=false;
  ftipo:=Reale;
  fdecimali:=2;
  finteri:=5;
end;

procedure tmc4edit.SetName(const Value: TComponentName);
begin
  inherited SetName(Value);
end;


procedure Register;
begin
  RegisterComponents('Standard', [Tmc4edit]);
end;

end.
