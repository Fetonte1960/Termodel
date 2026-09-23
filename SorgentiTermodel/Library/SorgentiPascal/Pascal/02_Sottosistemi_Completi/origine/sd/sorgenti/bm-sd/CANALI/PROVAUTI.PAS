program provauti;
  {************************************************}
{                                                }
{   Demo program                                 }
{   Copyright (c) 1991 by Borland International  }
{                                                }
{************************************************}



{$R gestduct.RES}
{$F+}
uses OWindows, Objects, ODialogs, WinTypes, WinProcs, Strings,validate,defuti,utiwin,
     bwcc;

const
  cm_Input1     = 10001;

{ Application object }

type
  TEmpDataApp = object(TApplication)
    constructor Init(AName: PChar);
    procedure InitMainWindow; virtual;

  end;
  PDataWindow = ^TDataWindow;
  TDataWindow = object(TWindow)
    constructor Init(AParent: PWindowsObject; TheTitle: PChar);
    procedure Input(var Msg: TMessage); virtual cm_First + cm_input1;
  end;






Constructor TDataWindow.Init(AParent: PWindowsObject; TheTitle: PChar);
begin
  TWindow.Init(AParent, TheTitle);
  Attr.Menu := LoadMenu(HInstance, 'Menu_1');
  (*attr.x:=0;attr.y:=0;attr.h:=480;attr.w:=640;*)
  attr.style:=attr.style or sw_maximize;
  pmainwindow:=@self;

end;
{$F+}

procedure stampaprog;far;
var
st:string[18];
pc:array[0..18] of char;
begin
  messagebeep(10);
  st:=vprog[numerolineatabella].nome;
  messagebeep(10);
  strpcopy(pc,st);
  messagebeep(10);
  messagebox(0,pc,'messaggio',0);
end;

procedure TDataWindow.Input(var Msg: TMessage);
begin
  fillchar(vprog,sizeof(vprog),0);
  vprog[1].descr:='descrizione';
  procarr[3]:=stampaprog;
  iotabella(vprog,nprogetti,10,2,'archprog',procarr);
end;




Constructor TEMPDATAapp.Init(AName: PChar);
begin
  TApplication.Init(AName);
  HAccTable := LoadAccelerators(HInstance, MakeIntResource('Accellerators_1'));
end;

procedure TEmpDataApp.InitMainWindow;
begin
  MainWindow := New(PDataWindow, Init(nil, 'Mc4 software- MC4-hvac | DUCT'));
end;





var
  EmpDataApp: TEmpDataApp;
begin

  EmpDataApp.Init('EmpDataApp');
  EmpDataApp.Run;
  EmpDataApp.Done;
end.
