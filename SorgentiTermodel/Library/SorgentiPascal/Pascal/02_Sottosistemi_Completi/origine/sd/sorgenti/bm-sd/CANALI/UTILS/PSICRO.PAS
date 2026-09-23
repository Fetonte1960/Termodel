 {************************************************}
{                                                }
{   Demo program                                 }
{   Copyright (c) 1991 by Borland International  }
{                                                }
{************************************************}

program psicro;

{$R psicro.RES}

uses OWindows, ODialogs, WinTypes, WinProcs, Strings,wincrt;

const

  cm_Misc     = 101;

type

{ Application object }

  TEmpDataApp = object(TApplication)
    procedure InitMainWindow; virtual;
  end;

  PNumEdit = ^TNumEdit;
  TNumEdit = object(TEdit)
    Tipo,pint,pdec:integer;
    constructor Init(AParent: PWindowsObject; AnId: Integer;
      ATitle: PChar; X, Y, W, H: Integer; Digits: Word;
      Atipo,Apint,Apdec:integer);
    function Transfer(DataPtr: Pointer; TransferFlag: Word): Word; virtual;
  end;



  PDataMisc = ^TDataMisc;
  TDataMisc = record
    Test:real;
  end;


   Pmiscela = ^Tmiscela;
   tmiscela = object(TWindow)

    constructor Init(AParent: PWindowsObject; TheTitle: PChar);
     procedure InputMisc(var Msg: TMessage); virtual cm_First + cm_misc;
  end;

  PDataWindow = ^TDataWindow;
  TDataWindow = object(TWindow)
    misc:pmiscela;
    constructor Init(AParent: PWindowsObject; TheTitle: PChar);
    procedure InputMisc(var Msg: TMessage); virtual cm_First + cm_misc;
  end;

 constructor TMiscela.Init(AParent: PWindowsObject; TheTitle: PChar);
 var p:pedit;
 begin
   inherited init(Aparent,Thetitle);
   with attr do
   begin
   x:=1;y:=300;
   w:=100;
   h:=50;
   style:=ws_child or ws_border or ws_caption or ws_minimizebox or ws_sizebox;
   end;

   p:=new(pnumedit,init(@self,201,'pippo',20,20,200,30,10,1,0,0));
 end;

 procedure Tmiscela.InputMisc(var Msg: TMessage);
 begin
  if Msg.WParam = 0 then Msg.WParam := 1;
  DefWndProc(Msg);
end;
{ TNumEdit }


{ TDataWindow }

constructor TDataWindow.Init(AParent: PWindowsObject; TheTitle: PChar);
begin
  TWindow.Init(AParent, TheTitle);
  Attr.Menu := LoadMenu(HInstance, 'Menu_1');
  attr.style:=attr.style or ws_maximize;
  misc:=new(pmiscela,init(@self,'SEZIONE DI MISCELA'));
end;


procedure TDataWindow.InputMISC(var Msg: TMessage);
BEGIN
  misc^.show(sw_show);
end;

{ TEmpDataApp }

procedure TEmpDataApp.InitMainWindow;
begin
  MainWindow := New(PDataWindow, Init(nil, 'Psycrometric'));
end;

var
  EmpDataApp: TEmpDataApp;

begin
  EmpDataApp.Init('EmpDataApp');
  EmpDataApp.Run;
  EmpDataApp.Done;
end.
