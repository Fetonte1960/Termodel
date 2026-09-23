{************************************************}
{                                                }
{   Turbo Pascal for Windows                     }
{   Toolbar unit                                 }
{   Copyright (c) 1992 by Borland International  }
{                                                }
{************************************************}

unit ToolBar;

interface

{$R Tool.res}

uses Winprocs, Wintypes, Objects, OWindows, Strings,{$ifdef delphi}messages,{$else} Win31,{$endif}odialogs,graph,
     wm,utilitie,main_res
     {$ifdef cta}
     ,
     definiz
     {$endif};

const
  am_CalcParentClientRect = wm_User + 120;
  tbHorizontal   = $01;
  tbLeftVertical = $02;
  tbRightVertical= $04;
  tbtools        = $06;
  DenyRepaint  = 0;
  AllowRepaint = 1;

var ptoolst:pstatic;
type

  pcomandi=^tcomandi;
  {$ifdef cta}
  tcomandi=array[2001..2030] of string[30];
  {$else}

  tcomandi=array[101..200] of string[30];
  {$endif}


  PTool = ^TTool;
  TTool = object(Tobject)
    Parent: PWindowsObject;

    constructor Init(AParent: PWindowsObject);
    function GetWidth: Integer; virtual;
    function GetHeight: Integer; virtual;
    function HitTest(P: TPoint): Boolean; virtual;
    procedure Paint(DC, AMemDC: HDC; var PS: TPaintStruct); virtual;
    procedure BeginCapture(P: TPoint); virtual;
    procedure ContinueCapture(P: TPoint); virtual;
    function EndCapture(SendTo: HWnd; P: TPoint): Boolean; virtual;
    function HasCommand(Command: Word): Boolean; virtual;
    procedure Enable(State: Boolean); virtual;
    procedure SetOrigin(X, Y: Integer); virtual;
    procedure Read(var S: TStream); virtual;
    procedure Write(var S: TStream); virtual;

  end;

  PToolbar = ^TToolbar;
  TToolbar = object(TWindow)
    ResName: PChar;
    Tools: TCollection;
    Capture: PTool;
    Orientation: Word;
    constructor Init(AParent: PWindowsObject; AName: PChar; ax,ay,aw,ah:integer;orient:word);
    destructor Done; virtual;
    {constructor Load(var S: TStream);
    procedure Store(var S: TStream); virtual;}
    function  CreateTool(Num: Integer; Origin: TPoint; Command: Word;
      BitmapName: PChar): PTool; virtual;
    procedure EnableTool(Command: Word; NewState: Boolean); virtual;
    procedure FreeResName;
    function  GetClassName: PChar; virtual;
    procedure GetWindowClass(var WC: TWndClass); virtual;
    procedure SetResName(NewName: PChar);
    procedure NextToolOrigin(Num: Integer; var Origin: TPoint;
      P: PTool); virtual;
    procedure Paint(DC: HDC; var PS: TPaintStruct); virtual;
    procedure ReadResource; virtual;
    function  GetOrientation: Word;  virtual;
    procedure SetOrientation(NewOrient: Word);  virtual;
    procedure SwitchTo(NewName: PChar);
    procedure AMCalcParentClientRect(var Msg: Owindows.tmessage);
      virtual wm_First + AM_CalcParentClientRect;
    procedure WMLButtonDown(var Msg: owindows.TMessage);
      virtual wm_First + wm_LButtonDown;
    procedure WMMouseMove(var Msg: Owindows.tmessage);
      virtual wm_First + wm_MouseMove;
    procedure WMLButtonUp(var Msg: Owindows.tmessage);
      virtual wm_First + wm_LButtonUp;
  end;

  PToolSpacer = ^TToolSpacer;
  TToolSpacer = object(TTool)
    Size: Integer;
    constructor Init(AParent: PWindowsObject; ASize: Integer);
    function GetWidth: Integer; virtual;
    function GetHeight: Integer; virtual;
  end;

  PToolButton = ^TToolButton;
  TToolButton = object(TTool)
    bmGlyph: HBitmap;
    Command: Word;
    Capturing, IsPressed, IsEnabled: Boolean;
    R: TRect;
    GlyphSize: TPoint;
    CapDC, MemDC: HDC;
    constructor Init(AParent: PWindowsObject; X, Y: Integer; ACommand: Word;
      BitmapName: PChar);
    destructor Done; virtual;
    function HasCommand(ACommand: Word): Boolean; virtual;
    procedure Enable(State: Boolean); virtual;
    function GetWidth: Integer; virtual;
    function GetHeight: Integer; virtual;
    procedure SetOrigin(X, Y: Integer); virtual;
    function HitTest(P: TPoint): Boolean; virtual;
    procedure Paint(DC, AMemDC: HDC; var PS: TPaintStruct); virtual;
    procedure PaintState(DC, AMemDC: HDC);
    procedure BeginCapture(P: TPoint); virtual;
    procedure ContinueCapture(P: TPoint); virtual;
    function  EndCapture(SendTo: HWnd; P: TPoint): Boolean; virtual;
    procedure PressIn;
    procedure PressOut;
    procedure Read(var S: TStream); virtual;
    procedure Write(var S: TStream); virtual;
  end;

{const
  RToolbar: TStreamRec = (
    ObjType: 12301;
    VmtLink: Ofs(TypeOf(TToolbar)^);
    Load:    @TToolbar.Load;
    Store:   @TToolbar.Store);
 }

implementation
  var
    comandi:pcomandi;
{ Unit wide resourcs }

var
  WhitePen, DarkGrayPen, BlackPen: HPen;
  GrayBrush, GrayingBrush: HBrush;

function MaxValue(A, B: Integer): Integer;
begin
  if A > B then
    MaxValue := A
  else
    Maxvalue := B;
end;

{ TToolbar }

constructor TToolbar.Init(AParent: PWindowsObject; AName: PChar;ax,ay,aw,ah:integer;orient:word);
var i:integer;
    s:string;
begin
  inherited Init(AParent, '');
  Attr.Style := ws_child or ws_Visible or  ws_border;
  SetFlags(wb_MDIChild, False);
  DefaultProc := @DefWindowProc;
  Attr.X := ax;
  Attr.Y := ay;
  Attr.W := aw;
  Attr.H := ah;
  attr.style:=attr.style or WS_VISIBLE;
  Capture := nil;
  Orientation := orient;
  ResName := nil;
  SetResName(AName);

  Tools.Init(8, 8);

  ReadResource;
  {$ifdef cta}
  {$else}
  new(ptoolst,init(@self,101,'',2,210,150,20,40));
  {$endif}
  new(comandi);
  fillchar(comandi^,sizeof(comandi^),0);
  {$ifdef cta}
 for i:=2001 to 2030 do
  case i of
  2001:comandi^[i]:=VComp^[1].Descriz;
  2002:comandi^[i]:=VComp^[2].Descriz;
  2003:comandi^[i]:=VComp^[3].Descriz;
  2004:comandi^[i]:=VComp^[4].Descriz;
  2005:comandi^[i]:=VComp^[5].Descriz;
  2006:comandi^[i]:=VComp^[6].Descriz;
  2007:comandi^[i]:=VComp^[7].Descriz;
  2008:comandi^[i]:=VComp^[8].Descriz;
  2009:comandi^[i]:=VComp^[9].Descriz;
  2010:comandi^[i]:=VComp^[10].Descriz;
  2011:comandi^[i]:=VComp^[11].Descriz;
  2012:comandi^[i]:=VComp^[12].Descriz;
  2013:comandi^[i]:=VComp^[13].Descriz;
  2014:comandi^[i]:=VComp^[14].Descriz;
  2015:comandi^[i]:=VComp^[15].Descriz;
  2016:comandi^[i]:=VComp^[16].Descriz;
  2017:comandi^[i]:=VComp^[17].Descriz;
  2018:comandi^[i]:=VComp^[18].Descriz;
  2019:comandi^[i]:=VComp^[19].Descriz;
  2020:comandi^[i]:=VComp^[20].Descriz;
  2021:comandi^[i]:=VComp^[21].Descriz;
  2022:comandi^[i]:=VComp^[22].Descriz;
  2023:comandi^[i]:=VComp^[23].Descriz;
  2024:comandi^[i]:=VComp^[24].Descriz;
  2025:comandi^[i]:=VComp^[25].Descriz;
  2026:comandi^[i]:=VComp^[26].Descriz;
  2027:comandi^[i]:=VComp^[27].Descriz;
  2028:comandi^[i]:=VComp^[28].Descriz;
  2029:comandi^[i]:=VComp^[29].Descriz;
  2030:comandi^[i]:=VComp^[30].Descriz;
 end;
{$else}
  for i:=101 to 165 do
  case i of
  101:begin
       comandi^[i]:=w_mw(61){'Inserisce sottorete'};
      end;
  102:comandi^[i]:=w_mw(62){'Cambia quota attiva'};
  103:comandi^[i]:=w_mw(63){'Zoom finestra'};
  104:comandi^[i]:=w_mw(64){'Tronco dal punto'};
  105:comandi^[i]:=w_mw(65){'Tronco spezza'};
  106:comandi^[i]:=w_mw(66){'Inserisce ambiente'};
  107:comandi^[i]:=w_mw(67){'Inserisce blocco'};
  108:comandi^[i]:=w_mw(68){'Cancella un tronco'};
  109:comandi^[i]:=w_mw(69){'Cambia tipo tubazione '};
  110:comandi^[i]:=w_mw(70){'Configura input grafico'};
  111:comandi^[i]:=w_mw(71){'Inserisce Ambiente NC'};
  112:comandi^[i]:=w_mw(72){'Inserisce finestra'};
  113:comandi^[i]:=w_mw(73){'Inserisce porta'};
  114:comandi^[i]:=w_mw(74){'Inserisce ponte termico'};
  115:comandi^[i]:=w_mw(75){'Inserisce il nord'};
  116:comandi^[i]:=w_mw(76){'Zoom tutto'};
  117:comandi^[i]:=w_mw(77){'Zoom precedente'};
  118:comandi^[i]:=w_mw(78){'Zoom limiti'};
  119:comandi^[i]:=w_mw(79){'Zoom setta limiti'};
  120:comandi^[i]:=w_mw(80){'Ridisegna'};
  121:comandi^[i]:=w_mw(81){''};
  122:comandi^[i]:=w_mw(82){''};
  123:comandi^[i]:=w_mw(83){'Cancella simbolo'};
  124:comandi^[i]:=w_mw(84){'Salva il disegno'};
  125:comandi^[i]:=w_mw(85){''};
  126:comandi^[i]:=w_mw(86){'Aggiorna i dati della rete'};
  127:comandi^[i]:=w_mw(87){'Cancella linea rossa'};
  128:comandi^[i]:=w_mw(88){'Configura input grafico'};
  129:comandi^[i]:=w_mw(89){'Cambia il colore'};
  130:comandi^[i]:=w_mw(90){'Estende due linee'};
  131:comandi^[i]:=w_mw(91){'Raccorda due linee'};
  132:comandi^[i]:=w_mw(92){''};
  133:comandi^[i]:=w_mw(93){''};
  134:comandi^[i]:=w_mw(94){'Cancella in finestra'};
  135:comandi^[i]:=w_mw(95){'Crea un blocco'};
  136:comandi^[i]:=w_mw(96){'Edita i dati dei simboli'};
  137:comandi^[i]:=w_mw(97){'Edita i dati del terminale'};
  138:comandi^[i]:=w_mw(98){'Cancella un terminale'};
  139:comandi^[i]:=w_mw(99){'Cancella tutti i terminali'};
  140:comandi^[i]:=w_mw(100){'Cambia posizione quote'};
  141:comandi^[i]:=w_mw(101){'Rinumera gli ambienti'};
  142:comandi^[i]:=w_mw(102){'Stampa il disegno'};
  143:comandi^[i]:=w_mw(103){'Esporta il disegno in DXF'};
  144:comandi^[i]:=w_mw(104){'Crea un file HPGL'};
  145:comandi^[i]:=w_mw(105){'Esce dal programma'};
  146:comandi^[i]:=w_mw(106){''};
  147:comandi^[i]:=w_mw(107){'Allinea la sezione'};
  148:comandi^[i]:=w_mw(108){'Carica tutti i dati della rete'};
  149:comandi^[i]:=w_mw(109){'Attiva il disegno dimensionato'};
  150:comandi^[i]:=w_mw(110){'Attiva la vista in sezione'};
  151:comandi^[i]:=w_mw(111){'Visualizza i dati di un tronco'};
  152:comandi^[i]:=w_mw(112){'Visualizza i nodi'};
  153:comandi^[i]:=w_mw(113){'Visualizza il disegno unifilare'};
  154:comandi^[i]:=w_mw(114){'Visualizza la pianta'};
  155:comandi^[i]:=w_mw(115){'Disegna un terminale'};
  156:comandi^[i]:=w_mw(116){'Disegna il ritorno simmetrico'};
  157:comandi^[i]:=w_mw(117){'Attiva la rete di mandata'};
  158:comandi^[i]:=w_mw(118){'Attiva la rete di ritorno'};
  159:comandi^[i]:=w_mw(119){'Visualizza i diametri'};
  160:comandi^[i]:=w_mw(120){'Inserisce blocco spezza'};
  161:comandi^[i]:=w_mw(121){'Aggiorna da disco'};
  165:comandi^[i]:=w_mw(122){'Cambia filo'};
 end;
  {$endif}

end;

destructor TToolbar.Done;
begin
  inherited Done;
  Tools.Done;
  FreeResName;
end;

(*constructor TToolbar.Load(var S: TStream);
var
  X: Integer;

  procedure RestoreStates(P : PTool); far;
  begin
    P^.Read(S);
  end;

begin
  inherited Load(S);
  Attr.Style := ws_Child or ws_Visible or ws_Border;
  SetFlags(wb_MDIChild, False);
  DefaultProc := @DefWindowProc;
  Capture := nil;
  S.Read(Orientation, SizeOf(Orientation));
  Tools.Init(8,8);

  ResName := nil;
  S.Read(X, SizeOf(X));
  if X = 0 then
    S.Read(PtrRec(ResName).Ofs, SizeOf(Word))
  else
    ResName := S.StrRead;

  ReadResource;
  if Status <> em_InvalidChild then
    Tools.ForEach(@RestoreStates)
  else
    S.Status := stGetError;
end;


procedure TToolbar.Store(var S: TStream);
var
  X: Integer;

  procedure SaveStates(P : PTool); far;
  begin
    P^.Write(S);
  end;

begin
  inherited Store(S);
  S.Write(Orientation, SizeOf(Orientation));
  if HiWord(Longint(ResName)) <> 0 then
  begin
    X := 1;
    S.Write(X, SizeOf(X));
    S.StrWrite(ResName);
  end
  else
  begin
    X := 0;
    S.Write(X, SizeOf(X));
    S.Write(PtrRec(ResName).Ofs, SizeOf(Word));
  end;
  Tools.ForEach(@SaveStates);
end;

*)
procedure TToolbar.ReadResource;
const maxbut=100;
type
  ResRec = record
    Bitmap,
    Command: Word;
  end;
  PResArray = ^TResArray;
  TResArray = array [1..maxbut] of ResRec;

var
  ResIdHandle: THandle;
  ResDataHandle: THandle;
  ResDataPtr: PResArray;
  Count: Word;
  X: Word;
  Origin: TPoint;
  BitInfo: TBitmap;
  P: PTool;
  f:file of tresarray;
begin

  ResIDHandle := FindResource(HInstance, ResName, 'ToolBarData');
  ResDataHandle := LoadResource(HInstance, ResIDHandle);
  ResDataPtr := LockResource(ResDataHandle);
  if (ResIDHandle = 0) or (ResDataHandle = 0) or (ResDataPtr = nil) then
  begin
    Status := em_InvalidChild;
    Exit;
  end;
  X := 1;
  Origin.X := 2;
  Origin.Y := 2;
  count:=0;
  while ResDataPtr^[X].bitmap >0 do
  begin
    count:=count+1;
    x:=x+1;
  end;
  Inc(LongInt(ResDataPtr), SizeOf(Count)); { Skip Count }
  for X := 1 to Count do
    with ResDataPtr^[X] do
    begin

      P := CreateTool(X, Origin, Command, PChar(Bitmap));
      if P <> nil then
      begin
        NextToolOrigin(X, Origin, P);
        Tools.Insert(P);
      end;
    end;

  Inc(Attr.H, 8);
  Inc(Attr.W, 8);
  UnlockResource(ResDataHandle);
  FreeResource(ResDataHandle);
end;

function TToolbar.GetOrientation: Word;
begin
  GetOrientation := Orientation;
end;

procedure TToolbar.SetOrientation(NewOrient: Word);
var
  X: Integer;
  Origin: TPoint;

  procedure ResetOrigins(P : PTool); far;
  begin
    P^.SetOrigin(Origin.X, Origin.Y);
    NextToolOrigin(X, Origin, P);
    Inc(X);
  end;

begin
  Orientation := NewOrient;
  Attr.H := 5;
  Attr.W := 5;
  X := 0;
  Origin.X := 2;
  Origin.Y := 2;
  Tools.ForEach(@ResetOrigins);
  Inc(Attr.W, 8);
  Inc(Attr.H, 8);
  SetWindowPos(HWindow, 0, -1, -1, Attr.W, Attr.H,  swp_NoZOrder or
    swp_NoRedraw);
end;


{ You may override CreateTool to make Toolbar use a different
  kind of ToolButton object }

function TToolbar.CreateTool(Num: Integer; Origin: TPoint;
  Command: Word; BitmapName: PChar): PTool;
begin
  if Word(BitmapName) = 0 then
    CreateTool := New(PToolSpacer, Init(@Self, Command))
  else
    CreateTool := New(PToolButton, Init(@Self, Origin.X, Origin.Y, Command,
      BitmapName));
end;

procedure TToolbar.EnableTool(Command: Word; NewState: Boolean);
var
  P: PTool;

  function FoundIt(P: PTool): Boolean; far;
  begin
    FoundIt := P^.HasCommand(Command);
  end;

begin
  P := Tools.FirstThat(@FoundIt);
  if P <> nil then
    P^.Enable(NewState);
end;

function TToolbar.GetClassName: PChar;
begin
  GetClassName := 'bordlg';{OWLToolbar}
end;

procedure TToolbar.GetWindowClass(var WC: TWndClass);
begin
  TWindow.GetWindowClass(WC);
  {WC.hbrBackground := GetStockObject(LtGray_Brush);}
end;

{ NextToolOrigin should the origin for the next tool button based upon the
  current tool's size and the toolbar's primary orientation or layout
  system (horizontal, vertical, palette or other).  This method is called in
  the Toolbar's constructor after each tool that is added to the toolbar.

  The code below supports horizontal and vertical orientation.  Descendents
  of TToolbar can override this method to implement other layout schemes.}

procedure TToolbar.NextToolOrigin(Num: Integer; var Origin: TPoint;
  P: PTool);
begin
  case Orientation of
    tbtools :
      begin
        if origin.x+P^.GetWidth < attr.w then Inc(Origin.X, P^.GetWidth)
        else
        begin
          Inc(Origin.Y, P^.GetHeight);
          origin.x:=2;
          Inc(Origin.X, P^.GetWidth);
          p^.setorigin(2,origin.y);
        end;
        Attr.H := MaxValue(Attr.H, P^.GetHeight);
      end;

   tbHorizontal :
       begin
        Inc(Origin.X, P^.GetWidth);
        Attr.H := MaxValue(Attr.H, P^.GetHeight);
      end;
   tbLeftVertical,
   tbRightVertical:
     begin
       Inc(Origin.Y, P^.GetHeight);
       Attr.W := MaxValue(Attr.W, P^.GetWidth);
     end;
  end;
end;

procedure TToolbar.Paint(DC: HDC; var PS: TPaintStruct);
var
  MemDC: HDC;
  OldPen: HPen;

  procedure PaintIt(Item: PTool); far;
  begin
    Item^.Paint(DC, MemDC, PS);
  end;

begin

  OldPen := SelectObject(DC, WhitePen);
  MoveTo(DC, 0, 0);
  LineTo(DC, Attr.W + 1, 0);
  SelectObject(DC, OldPen);
  MemDC := CreateCompatibleDC(DC);
  Tools.ForEach(@PaintIt);
  DeleteDC(MemDC);

end;

{ FreeResName handles releasing memory, if necessary, occupied by a
  PChar / integer resource identifier }

procedure TToolbar.FreeResName;
begin
  if HiWord(Longint(ResName)) <> 0 then
    StrDispose(ResName);
end;

{ SetResName handles allocating memory, if necessary, to hold a PChar or
  integer resource identifier. }

procedure TToolbar.SetResName(NewName: PChar);
begin
  FreeResName;
  if HiWord(Longint(NewName)) <> 0 then
    ResName := StrNew(NewName)
  else
    ResName := NewName;
end;

{ Switch the Toolbar object to use a different toolbar resource. }

procedure TToolbar.SwitchTo(NewName: PChar);
var pu,pu1:tpoint;
    rect:trect;
    dc:hdc;
    tm:ttextmetric;
    y:integer;
    nfont,ofont:hfont;
begin
  Tools.Done;
  Tools.Init(8,8);
  SetResName(NewName);
  ReadResource;
  {$ifdef cta}
  {$else}
  StrCopy(@fonte.lfFaceName,'Ms San serif');
  fonte.lfheight:=-10;

  dc:=getdc(ptoolst^.hwindow);
  NFont:=CreateFontIndirect(Fonte);
  ofont:=SelectObject(dc, Nfont);
  deleteObject(TheFont);
  TheFont:=NFont;

  gettextmetrics(dc,tm);
  releasedc(ptoolst^.hwindow,dc);
  y:=attr.h-tm.tmHeight-4;
  movewindow(ptoolst^.hwindow,2,y-8,attr.w-2,tm.tmHeight+4,true);
  {$endif}
end;




procedure TToolbar.AMCalcParentClientRect( var Msg: Owindows.tmessage);
var
  TB,               { Toolbar rect in screen coords }
  PC,               { Parent client rect in screen coords  }
  NewTB,            { New toolbar rect in screen coords    }
  R   : TRect;      { scratch }
  S2PC, S2TB: TPoint; { Screen to local coord. conversion offsets }
  XOfs : Integer;
begin
  PC := PRect(Msg.LParam)^;
  R := PC;
  ClientToScreen(Parent^.HWindow, PPoint(@PC)^);
  ClientToScreen(Parent^.HWindow, PPoint(@PC.Right)^);
  S2PC.X := PC.Left - R.Left;
  S2PC.Y := PC.Top  - R.Top;

  GetWindowRect(HWindow, TB);
  S2TB.X := TB.Left ;
  S2TB.Y := TB.Top;

  if Orientation = tbHorizontal then
  begin
    if Bool(Msg.WParam) then  { We have permission to repaint & reposition }
    begin
      if TB.Right <> PC.Right then     { Parent client relative coords }
        SetWindowPos(HWindow, 0, -1, -1, PC.Right - S2TB.X + 1,
          TB.Bottom - S2TB.Y, swp_NoZOrder or swp_NoRedraw);
      if TB.Right < PC.Right then
      begin                      { Width increases, paint new area }
        SetRect(R, TB.Right - S2TB.X - 2, TB.Top - S2TB.Y - 1,
          PC.Right - S2TB.X + 1, TB.Bottom - S2TB.Y +1);
        InvalidateRect(HWindow, @R, True);
      end;
    end;
    if PC.Top < TB.Bottom then
      PC.Top := TB.Bottom;
  end
  else
  if (Orientation and (tbLeftVertical or tbRightVertical)) <> 0 then
  begin
    if Orientation = tbRightVertical then
      XOfs := PC.Right - (TB.Right - TB.Left) + 2
    else
      XOfs := PC.Left;
    SetRect(NewTB, XOfs - 1, PC.Top  - 1, XOfs + (TB.Right - TB.Left) - 1,
      PC.Bottom);
    if Bool(Msg.WParam) then   { We have permission to repaint & reposition }
    begin
      if TB.Bottom <> PC.Bottom then
        SetWindowPos(HWindow, 0, NewTB.Left - S2PC.X, NewTB.Top - S2PC.Y,
          NewTB.Right - NewTB.Left, NewTB.Bottom - NewTB.Top + 1,
          swp_NoZOrder or swp_NoRedraw);

      if (TB.Left <> NewTB.Left) or (TB.Top <> NewTB.Top) then
      begin
        InvalidateRect(HWindow, nil, True) { Window moved, paint it all }
      end
      else
      if TB.Bottom < NewTB.Bottom then  { Height grew, paint new area }
      begin
        SetRect(R, NewTB.Left - S2TB.X - 1, TB.Bottom - S2TB.Y - 2,
          NewTB.Right - S2TB.X, NewTB.Bottom - S2TB.Y);
        InvalidateRect(HWindow, @R, True);
      end;
    end;

    if (Orientation = tbLeftVertical) and (PC.Left < NewTB.Right) then
      PC.Left := NewTB.Right;
    if (Orientation = tbRightVertical) and (PC.Right > NewTB.Left) then
      PC.Right := NewTB.Left;
  end;

  { Map the screen coord PC record back into parent relative coords }
  SetRect(PRect(Msg.LParam)^, PC.Left - S2PC.X, PC.Top - S2PC.Y,
    PC.Right - S2PC.X, PC.Bottom - S2PC.Y);

end;


procedure TToolbar.WMLButtonDown(var Msg: owindows.TMessage);

  function IsHit(Item: PTool): Boolean; far;
  begin
    IsHit := Item^.HitTest(TPoint(Msg.LParam));
  end;

begin
  Capture  := Tools.FirstThat(@IsHit);
  if Capture <> nil then
    Capture^.BeginCapture(TPoint(Msg.LParam));
  {invalidaterect(hwindow,nil,true);}
end;

procedure TToolbar.WMMouseMove(var Msg: Owindows.tmessage);

function IsHit(Item: PTool): Boolean; far;
  begin
    IsHit := Item^.HitTest(TPoint(Msg.LParam));
  end;

begin
  Capture  := Tools.FirstThat(@IsHit);
  if (Capture <> nil) then
    Capture^.ContinueCapture(TPoint(Msg.LParam));
end;

procedure TToolbar.WMLButtonUp(var Msg: Owindows.tmessage);
begin
  if (Capture <> nil) and Capture^.EndCapture(Parent^.HWindow,
      TPoint(Msg.LParam)) then
    Capture := nil;
end;

{ TTool }

constructor TTool.Init(AParent: PWindowsObject);
begin
  Parent := AParent;
end;

function TTool.GetWidth: Integer;
begin
  GetWidth := 0;
end;

function TTool.GetHeight: Integer;
begin
  GetHeight := 0;
end;

function TTool.HitTest(P: TPoint): Boolean;
begin
  HitTest := False;
end;

procedure TTool.Paint(DC, AMemDC: HDC; var PS: TPaintStruct);
begin
end;

procedure TTool.BeginCapture(P: TPoint);
begin
end;

procedure TTool.ContinueCapture(P: TPoint);
begin
end;

function TTool.EndCapture(SendTo: HWnd; P: TPoint): Boolean;
begin
end;

procedure TTool.Enable(State: Boolean);
begin
end;

procedure TTool.SetOrigin(X, Y: Integer);
begin
end;

function TTool.HasCommand(Command: Word): Boolean;
begin
  HasCommand := False;
end;

procedure TTool.Read(var S: TStream);
begin
end;

procedure TTool.Write(var S: TStream);
begin
end;




{ TToolSpacer }

constructor TToolSpacer.Init(AParent: PWindowsObject; ASize: Integer);
begin
  inherited Init(AParent);
  Size := ASize;
end;

function TToolSpacer.GetWidth: Integer;
begin
  GetWidth := Size;
end;

function TToolSpacer.GetHeight: Integer;
begin
  GetHeight := Size;
end;

{ TToolButton }

const
  BorderWidth = 2;

constructor TToolButton.Init(AParent: PWindowsObject; X, Y: Integer;
  ACommand: Word; BitmapName: PChar);
var
  BI: TBitmap;
  GrayBM, OldBM: HBitmap;
  OldPen: HPen;
begin
  inherited Init(AParent);
  CapDC := 0;
  MemDC := 0;
  IsPressed := False;
  Capturing := False;
  IsEnabled := True;
  Command := ACommand;
  bmGlyph := LoadBitmap(HInstance, BitmapName);
  GetObject(bmGlyph, SizeOf(BI), @BI);
  GlyphSize.X := BI.bmWidth;
  GlyphSize.Y := BI.bmHeight;
  SetRect(R, X, Y, X + BI.bmWidth + BorderWidth * 2, Y + BI.bmHeight +
    BorderWidth * 2);
end;

destructor TToolButton.Done;
begin
  if Capturing then
  begin
    DeleteDC(MemDC);
    ReleaseDC(Parent^.HWindow, CapDC);
    ReleaseCapture;
  end;
  if bmGlyph <> 0 then DeleteObject(bmGlyph);
  inherited Done;
end;

function TToolButton.HasCommand(ACommand: Word): Boolean;
begin
  HasCommand := Command = ACommand;
end;

procedure TToolButton.Enable(State: Boolean);
begin
  if (IsEnabled <> State) and (Parent^.HWindow <> 0) then
    InvalidateRect(Parent^.HWindow, @R, False);
  IsEnabled := State;
end;

function TToolButton.GetWidth: Integer;
begin
  GetWidth := R.Right - R.Left;
end;

function TToolButton.GetHeight: Integer;
begin
  GetHeight := R.Bottom - R.Top;
end;

procedure TToolButton.SetOrigin(X, Y: Integer);
var
  BI : TBitmap;
begin
  GetObject(bmGlyph, SizeOf(BI), @BI);
  SetRect(R, X, Y, X + BI.bmWidth + BorderWidth * 2,
    Y + BI.bmHeight + BorderWidth * 2);
end;

function TToolButton.HitTest(P: TPoint): Boolean;
begin
  HitTest := Boolean(PtInRect(R, P));
end;

{ InitButtonBitmaps loads the button images that the tool button glyphs
  will be copied onto.  TToolButton assumes all the tool buttons on the
  toolbar will be the same size.  If you want variable sized (width or
  height or both) tool buttons, create a descendent of TToolButton and
  override this method to create or stretch the button image to suite
  each tool's glyph size.  Creating bitmaps for each toolbutton uses more
  memory than several toolbuttons referencing the same bitmap resource.
  String names are used to identify the bitmaps to avoid integer id
  collisions with other bitmaps in the application.
}


procedure TToolButton.Paint(DC, AMemDC: HDC; var PS: TPaintStruct);
begin
  PaintState(DC, AMemDC);
end;

procedure TToolButton.PaintState(DC, AMemDC: HDC);
var
  OldBitmap: HBitmap;
  OldBrush: HBrush;
  OldPen: HPen;
  Offset: Integer;
begin
  OldPen := SelectObject(DC, BlackPen);
  OldBrush := SelectObject(DC, GrayBrush);
  with R do
  begin
    Rectangle(DC, Left, Top, Right + 1, Bottom + 1);
    if not IsPressed then
    begin
      Offset := BorderWidth;
      SelectObject(DC, WhitePen);
      MoveTo(DC, Left + 1, Bottom - 1);
      LineTo(DC, Left + 1, Top + 1);
      LineTo(DC, Right - 1, Top + 1);
      SelectObject(DC, DarkGrayPen);
      MoveTo(DC, Right - 1, Top + 1);
      LineTo(DC, Right - 1, Bottom - 1);
      LineTo(DC, Left + 1, Bottom - 1);
    end
    else
    begin
      Offset := BorderWidth + 1;
      SelectObject(DC, DarkGrayPen);
      MoveTo(DC, Left + 1, Bottom - 1);
      LineTo(DC, Left + 1, Top + 1);
      LineTo(DC, Right, Top + 1);
    end;
  end;

  OldBitmap := SelectObject(AMemDC, bmGlyph);
  if IsEnabled then
    BitBlt(DC, R.Left + Offset, R.Top + Offset, GlyphSize.X, GlyphSize.Y,
      AMemDC, 0, 0, SrcCopy)
  else
  begin
    UnRealizeObject(GrayingBrush);
    OldBrush := SelectObject(DC, GrayingBrush);
    BitBlt(DC, R.Left + Offset, R.Top + Offset, GlyphSize.X, GlyphSize.Y,
      AMemDC, 0, 0, $00A803A9 {DPSoa});
  end;

  SelectObject(DC, OldBrush);
  SelectObject(DC, OldPen);
  SelectObject(AMemDC, OldBitmap);
end;

procedure TToolButton.PressIn;
begin
  if (not IsPressed) and IsEnabled then
  begin
    IsPressed := True;
    PaintState(CapDC, MemDC);
  end;
end;

procedure TToolButton.PressOut;
begin
  if IsPressed then
  begin
    IsPressed := False;
    PaintState(CapDC, MemDC);
  end;
end;

procedure TToolButton.BeginCapture(P: TPoint);
begin
  CapDC := GetDC(Parent^.HWindow);
  MemDC := CreateCompatibleDC(CapDC);
  IsPressed := False;
  Capturing := True;
  SetCapture(Parent^.HWindow);
  if HitTest(P) then
    PressIn;
end;

procedure TToolButton.ContinueCapture(P: TPoint);
var pc:array[0..40] of char;
    s:string[40];
begin
  if HitTest(P) then
    PressIn
  else
  PressOut;
  {$ifdef cta}
  IF (command >=2001) and (command <=2030) then s:=comandi^[command];
  {$else}
  s:=comandi^[command];
  {$endif}

  s:=oem_ans(s);
  {str(command,s);}
  {$ifdef cta}
  invmess(s);
  {$else}
  strpcopy(pc,s);
  ptoolst^.settext(pc);
  {$endif}
end;


{ The boolean function result of EndCapture indicates whether the tool button
  has released the mouse capture or not.  The Toolbar should not clear its
  capture field/state until the toolbutton says to.

  The SendTo parameter is the HWindow to notify that the tool button was clicked
  upon, if such is the case.  This code emulates a menu command message, but
  any message type could be used. }

function TToolButton.EndCapture(SendTo: HWnd; P: TPoint): Boolean;
begin
  if HitTest(P) then
  begin
    PressOut;
    PostMessage(SendTo, wm_Command, Command, 0);
  end;
  EndCapture := True;
  ReleaseCapture;
  Capturing := False;
  DeleteDC(MemDC);
  ReleaseDC(Parent^.HWindow, CapDC);
  MemDC := 0;
  CapDC := 0;
end;

{ Toolbuttons are not Loaded from the stream, but instead are constructed
  from the resource info and then allowed to read their state info from the stream.
  Conversely, the toolbuttons write state info but are not stored on the
  stream. }

procedure TToolButton.Read(var S: TStream);
begin
  S.Read(IsEnabled, SizeOf(IsEnabled));
end;

procedure TToolButton.Write(var S: TStream);
begin
  S.Write(IsEnabled, SizeOf(IsEnabled));
end;

{ Allocate unit wide resources }
procedure AllocateResources;
const
  coDarkGray = $808080;
var
  LBrush: TLogBrush;
begin
  { Allocate graying brush (used to disable buttons) }
  LBrush.lbStyle := bs_Pattern;
  Word(LBrush.lbHatch) := LoadBitmap(HInstance, 'GrayingBitmap');
  GrayingBrush := CreateBrushIndirect(LBrush);
  DeleteObject(Word(LBrush.lbHatch));

  { Allocate drawing pens and brushes }
  GrayBrush := GetStockObject(LtGray_Brush);
  WhitePen := GetStockObject(White_Pen);
  BlackPen := GetStockObject(Black_Pen);
  DarkGrayPen := CreatePen(ps_Solid, 1, coDarkGray);
end;

{ Free allocate resources }
procedure DeallocateResources;
begin
  DeleteObject(GrayingBrush);
  DeleteObject(DarkGrayPen);
end;

var
  SaveExit: Pointer;

procedure ExitToolBar; far;
begin
  DeallocateResources;
  ExitProc := SaveExit;
end;

begin
  SaveExit := ExitProc;
  ExitProc := @ExitToolBar;
  AllocateResources;
end.