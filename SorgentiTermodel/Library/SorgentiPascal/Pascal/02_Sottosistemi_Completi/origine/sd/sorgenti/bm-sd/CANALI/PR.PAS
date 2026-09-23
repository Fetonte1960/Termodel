{************************************************}
{                                                }
{   Toolbar Demo Program                         }
{   Copyright (c) 1992 by Borland International  }
{                                                }
{************************************************}

{ This is a modified version of MFILEAPP from the DEMOS\WIN\OWL
  subdirectory that shows how to use the TOOLBAR unit. }

program MDIFileEditor;

{$R gestduct.RES}

uses WinProcs, WinTypes, Objects, OWindows, ODialogs, OStdDlgs,
     OStdWnds, OMemory, Strings, WinDos, Toolbar, MFileC,main_win;

const
  { If we're running under Win 3.1, we'll use this function to prevent flicker }
  Win31LockWindowUpdate: function (Wnd: HWnd): Bool = nil;

type

  { Declare TMDIFileApp, a TApplication descendant }
  TMDIFileApp = object(TApplication)
    procedure InitMainWindow; virtual;
   { procedure InitInstance; virtual;}
  end;

  { Declare TMDIFileWindow, a TMDIWindow descendant }
  PMDIFileWindow = ^TMDIFileWindow;
  TMDIFileWindow = object(TmainWindow)

    {Toolbar: PToolbar;

    constructor Init(Aparent:pwindowsobject;ATitle: PChar);
    procedure EnableCommand(Command: Word; EnableIt: Boolean);
    procedure SetupWindow; virtual;
    procedure RedoClientRect;
    procedure CalcClientRect(var R: TRect);
    procedure HorizontalToolbar(var Msg: TMessage);
      virtual cm_First + cm_HorizontalToolbar;
    procedure RightVerticalToolbar(var Msg: TMessage);
      virtual cm_First + cm_RightVerticalToolbar;
    procedure LeftVerticalToolbar(var Msg: TMessage);
      virtual cm_First + cm_LeftVerticalToolbar;
    procedure WMSize(var Msg: TMessage);
      virtual wm_First + wm_Size;
   }
  end;

  { Declare TFileEditor, a TFileWindow desendant }

{ TFileEditor }

const
EditorCount: Integer = 0;

procedure EnableEditorMenuItems(NewState: Boolean);
begin

  { Bail out if the window is already closed}
  if Application^.MainWindow^.HWindow = 0 then Exit;

  with PMDIFileWindow(Application^.MainWindow)^ do
  begin
    EnableCommand(cm_FileSave, NewState);
    EnableCommand(cm_FileSaveAs, NewState);
    EnableCommand(cm_ArrangeIcons, NewState);
    EnableCommand(cm_TileChildren, NewState);
    EnableCommand(cm_CascadeChildren, NewState);
    EnableCommand(cm_CloseChildren, NewState);
    EnableCommand(cm_EditCut, NewState);
    EnableCommand(cm_EditCopy, NewState);
    EnableCommand(cm_EditPaste, NewState);
    EnableCommand(cm_EditDelete, NewState);
    EnableCommand(cm_EditClear, NewState);
    EnableCommand(cm_EditUndo, NewState);
    EnableCommand(cm_EditFind, NewState);
    EnableCommand(cm_EditReplace, NewState);
    EnableCommand(cm_EditFindNext, NewState);
  end;
end;



{ The main window object - TMDIFileWindow }
(*
constructor TMDIFileWindow.Init(Aparent:pwindowsobject;ATitle: PChar);
begin
  TWindow.Init(Aparent,ATitle);
  Attr.Style := Attr.Style or ws_ClipChildren;
  attr.menu:=loadmenu(HInstance,'menu_1');
  Toolbar := New(PToolbar, Init(@Self, 'Toolbar_3', tbHorizontal));
end;

{ Make sure the menus that require an editor are disabled and that the toolbar
  is synchronized with the disabled menu items. }
procedure TMDIFileWindow.SetupWindow;
var r:trect;
begin
  TWindow.SetupWindow;
  EnableEditorMenuItems(False);
  CheckMenuItem(Attr.Menu, cm_HorizontalToolbar, mf_ByCommand or mf_Checked);
end;



procedure TMDIFileWindow.RedoClientRect;
var R: TRect;

  procedure NotifyChildren( P: PWindow ); far;
  begin
    if P^.HWindow <> 0 then
      SendMessage(P^.HWindow, am_CalcParentClientRect, AllowRepaint, Longint(@R));
  end;
begin
  GetClientRect(HWindow, R);
  ForEach(@NotifyChildren);
end;

procedure TMDIFileWindow.CalcClientRect(var R: TRect);
  procedure NotifyChildren( P: PWindow ); far;
  begin
    if P^.HWindow <> 0 then
      SendMessage(P^.HWindow, am_CalcParentClientRect, DenyRepaint, Longint(@R));
  end;
begin
  GetClientRect(HWindow, R);
  ForEach(@NotifyChildren);
end;

procedure TMDIFileWindow.EnableCommand(Command: Word; EnableIt: Boolean);
var
  StateFlags: Word;
begin
  if Attr.Menu <> 0 then
  begin
    if EnableIt then
      StateFlags := mf_ByCommand or mf_Enabled
    else
      StateFlags := mf_ByCommand or mf_Disabled or mf_Grayed;
    EnableMenuItem(Attr.Menu, Command, StateFlags);
    Toolbar^.EnableTool(Command, EnableIt);
  end;
end;

procedure TMDIFileWindow.HorizontalToolbar(var Msg: TMessage);
begin
  if Toolbar^.GetOrientation <> tbHorizontal then
  begin
    if Assigned(Win31LockWindowUpdate) then
      Win31LockWindowUpdate(HWindow);
    Toolbar^.Show(sw_Hide);
    Toolbar^.SetOrientation(tbHorizontal);
    RedoClientRect;
    Toolbar^.Show(sw_Show);
    if Assigned(Win31LockWindowUpdate) then
      Win31LockWindowUpdate(0);
    CheckMenuItem(Attr.Menu, cm_HorizontalToolbar, mf_ByCommand or mf_Checked);
    CheckMenuItem(Attr.Menu, cm_LeftVerticalToolbar, mf_ByCommand or mf_UnChecked);
    CheckMenuItem(Attr.Menu, cm_RightVerticalToolbar, mf_ByCommand or mf_UnChecked);
  end;
end;

procedure TMDIFileWindow.RightVerticalToolbar(var Msg: TMessage);
begin
  if Toolbar^.GetOrientation <> tbRightVertical then
  begin
    if Assigned(Win31LockWindowUpdate) then
      Win31LockWindowUpdate(HWindow);
    Toolbar^.Show(sw_Hide);
    Toolbar^.SetOrientation(tbRightVertical);
    RedoClientRect;
    Toolbar^.Show(sw_Show);
    if Assigned(Win31LockWindowUpdate) then
      Win31LockWindowUpdate(0);
    CheckMenuItem(Attr.Menu, cm_HorizontalToolbar, mf_ByCommand or mf_UnChecked);
    CheckMenuItem(Attr.Menu, cm_LeftVerticalToolbar, mf_ByCommand or mf_UnChecked);
    CheckMenuItem(Attr.Menu, cm_RightVerticalToolbar, mf_ByCommand or mf_Checked);
  end;
end;

procedure TMDIFileWindow.LeftVerticalToolbar(var Msg: TMessage);
begin
  if Toolbar^.GetOrientation <> tbLeftVertical then
  begin
    if Assigned(Win31LockWindowUpdate) then
      Win31LockWindowUpdate(HWindow);
    Toolbar^.Show(sw_Hide);
    Toolbar^.SetOrientation(tbLeftVertical);
    RedoClientRect;
    Toolbar^.Show(sw_Show);
    if Assigned(Win31LockWindowUpdate) then
      Win31LockWindowUpdate(0);
    CheckMenuItem(Attr.Menu, cm_HorizontalToolbar, mf_ByCommand or mf_UnChecked);
    CheckMenuItem(Attr.Menu, cm_LeftVerticalToolbar, mf_ByCommand or mf_Checked);
    CheckMenuItem(Attr.Menu, cm_RightVerticalToolbar, mf_ByCommand or mf_UnChecked);
  end;
end;

{ Allow special windows such as the Toolbar the opportunity to say how much room
 they need outside the MDI client area.  The default Windows processing for
 wm_Size always sets the MDI client area to fill the main window's client area,
 and it forces a repaint.  We don't want that, so we don't call the inherited
 wm_Size or the Windows default message processor. }
procedure TMDIFileWindow.wmSize(var Msg: TMessage);
var
  R: TRect;
begin
  if (Scroller <> nil) and (Msg.WParam <> sizeIconic) then
    Scroller^.SetPageSize;
  if Msg.wParam = sizeNormal then
  begin
    GetWindowRect(HWindow, R);
    Attr.H := R.bottom - R.top;
    Attr.W := R.right - R.left;
  end;
  RedoClientRect;
end;


*)
{ Construct the TMDIFileApp's MainWindow of type TMDIFileWindow,
  loading its menu }
procedure TMDIFileApp.InitMainWindow;
var x: PWindowsObject;
begin
  MainWindow := New(PMDIFileWindow, Init(nil,
    'PR'));
  {PMDIFileWindow(MainWindow)^.ChildMenuPos := 3;}
  { Register types to be written to stream }
  {RegisterType(RWindow);
  RegisterType(REdit);
  RegisterType(RFileEditor);
  RegisterType(RToolbar);}
end;
(*
{ Initialize each MS-Windows application instance, loading an
  accelerator table
procedure TMDIFileApp.InitInstance;
begin
  TApplication.InitInstance;
  if Status = 0 then
  begin
    HAccTable := LoadAccelerators(HInstance, 'FileCommands');
    if HAccTable = 0 then
      Status := em_InvalidWindow;
  end;
end;                }
*)
{ Declare a variable of type TFileApp }
var
  MDIFileApp : TMDIFileApp;

{ Run the FileApp }
begin
  { In Windows 3.0, the following GetProcAddress call will return nil,
    but not cause a critical error message.  Any code that uses
    this function variable should always test it first with
    the Assigned system function. }

{  @Win31LockWindowUpdate :=
    GetProcAddress(GetModuleHandle('User'), PChar(294));}
  MDIFileApp.Init('MDIFileApp');
  MDIFileApp.Run;
  MDIFileApp.Done;
end.
