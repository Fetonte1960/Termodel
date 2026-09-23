 {************************************************}
{                                                }
{   Demo program                                 }
{   Copyright (c) 1991 by Borland International  }
{                                                }
{************************************************}

program VDlgApp;

{$R duct1.RES}

uses OWindows, Objects, ODialogs, WinTypes, WinProcs, Strings,validate,WINCRT,utiwindlg;

const
  cm_Input1     = 201;
  cm_Input2     = 202;

  type
  TEmpDataApp = object(TApplication)
    constructor Init(AName: PChar);
    procedure InitMainWindow; virtual;

  end;

  PDataWindow = ^TDataWindow;
  TDataWindow = object(TdLgwindow)
    constructor Init(AParent: PWindowsObject; TheTitle: PChar);
    procedure wmrbuttondown(var msg:tmessage);virtual wm_first+wm_rbuttondown;
  end;

  PfinDis=^Tfindis;
  tfindis=object(twindow)
    constructor init(aparent:pwindowsobject; Atitle:pChar);
    procedure getwindowclass(var aclass:twndclass);virtual;
    function getClassname:pchar;virtual;
    procedure wmrbuttondown(var msg:tmessage);virtual wm_first+WM_RBUTTONDOWN;
  end;


VAR PDW:pDATAWINDOW;


procedure messaggio(st:string);
begin
  DATO:=st;
  Pdw^.transferdata(tf_setdata);
end;

Constructor TDataWindow.Init(AParent: PWindowsObject; TheTitle: PChar);
var p:pwindowsobject;
    p1:pchar;
begin
  tdlgwindow.Init(AParent, TheTitle);
  PDW:=@SELF;
  p:=new(pfindis,init(@self,'Finestra di disegno'));
  dato:='Messaggio';
  transferbuffer:=@dato;
  p:=new(pstatico,initresource(@self,200,30));
end;

procedure tdatawindow.wmrbuttondown(var msg:tmessage);
begin
  messaggio('Tasto premuto dentro la finestra bianca');
end;

function tfindis.getclassname:pchar;
begin
  getclassname:='FinestraDis';
end;

procedure tfindis.getwindowclass(var aclass:twndclass);
var classe:pchar;
begin
  twindow.getwindowclass(aclass);
  aclass.hbrbackground:=Getstockobject(black_brush);
end;

constructor tfindis.init(aparent:pwindowsobject;Atitle:Pchar);

begin
  inherited init(aparent,atitle);
  attr.style:=attr.style or ws_child or ws_visible or ws_border;
  attr.x:=1;attr.y:=1;attr.w:=552;attr.h:=425;
end;


Procedure tfindis.wmrbuttondown(var msg:Tmessage);
var ris:integer;
    st:string;
begin
  messaggio('Pulsante dentro la finestra nera');
end;

Constructor TEMPDATAapp.Init(AName: PChar);
begin
  TApplication.Init(AName);
end;

procedure TEmpDataApp.InitMainWindow;
begin
  MainWindow := New(PDATAWINDOW, Init(nil, 'PRINCIPALE'));
end;





var
  EmpDataApp: TEmpDataApp;
  i:integer;
begin

  EmpDataApp.Init('EmpDataApp');

  EmpDataApp.Run;
  EmpDataApp.Done;
end.
