unit main_w;
interface
uses defuti,owindows,objects,winprocs,wintypes,strings,inituti,utilitie,def_win,DEFINIZ,wm,OMEMORY
     {$ifdef delphi},messages{$endif};
type





pmiawindow=^tmainwindow;
TMainWindow = object(TWindow)
    BmpStatusBar: HBitmap;
    BmpStatusLine: HBitmap;
    BitMapHandle:hbitmap;
    BitInfo:TBitmap;
    Width,Height:integer;
    Fonte:tlogfont;
    ditta,indirizzo,citta:string[50];

    {toolbar:ptoolbar;}
    procedure WMDrawStatusLine(var Msg: owindows.TMessage); virtual wm_First + am_DrawStatusLine;
    procedure BlastStatusLine(PaintDC: HDC);
    procedure ReconstructStatusLine;
    procedure WMSize(var Msg: owindows.TMessage); virtual wm_First + wm_Size;
    procedure setupwindow;virtual;
    constructor Init(Aparent:pwindowsobject; TheTitle: PChar);
    destructor done;virtual;
    procedure Paint(PaintDC: HDC; var PaintInfo: TPaintStruct); virtual;
    procedure EnableCommand(Command: Word; EnableIt: Boolean);
    {
    procedure RedoClientRect;
    procedure CalcClientRect(var R: TRect);
    procedure HorizontalToolbar(var Msg: TMessage);
      virtual cm_First + cm_HorizontalToolbar;
    procedure RightVerticalToolbar(var Msg: TMessage);
      virtual cm_First + cm_RightVerticalToolbar;
    procedure LeftVerticalToolbar(var Msg: TMessage);
      virtual cm_First + cm_LeftVerticalToolbar;}
    Procedure Uscita(var msg:owindows.Tmessage);virtual cm_first +10032;
    Procedure HelpMaschera(var msg:Tmessage);virtual cm_first +10034;
    Procedure Helpcampo(var msg:Tmessage);virtual cm_first +10035;
    Procedure HelpErrori(var msg:Tmessage);virtual cm_first +10036;
    function  canclose:boolean;virtual;
    procedure writecaption(var msg:owindows.Tmessage);
 end;

var punmainwin:PmiaWindow;
implementation
{uses graph;}

{$ifdef free}
procedure AHIncr; far; external 'KERNEL' index 114;
{$endif}

Constructor TMainwindow.Init(Aparent:pwindowsobject; TheTitle: PChar);
type tnome=array[1..150] of real;
var i,k:integer;
    dc:hdc;
    nome:tnome;
    f:file of tnome;
    Drive1,patdr1:STRING;
    fileini:string;


{$ifdef free}

{$ifdef deb}
 function LoadBitmapFile(Name: PChar): Boolean;
  begin
  end;
{$else}

procedure GetBitmapData(var TheFile: File;
  BitsHandle: THandle; BitsByteSize: Longint);
type
  LongType = record
    case Word of
      0: (Ptr: Pointer);
      1: (Long: Longint);
      2: (Lo: Word;
	  Hi: Word);
  end;
var
  Count: Longint;
  Start, ToAddr, Bits: LongType;
begin
  Start.Long := 0;
  Bits.Ptr := GlobalLock(BitsHandle);
  Count := BitsByteSize - Start.Long;
  while Count > 0 do
  begin
    ToAddr.Hi := Bits.Hi + (Start.Hi * Ofs(AHIncr));
    ToAddr.Lo := Start.Lo;
    if Count > $4000 then Count := $4000;
    BlockRead(TheFile, ToAddr.Ptr^, Count);
    Start.Long := Start.Long + Count;
    Count := BitsByteSize - Start.Long;
  end;
  GlobalUnlock(BitsHandle);
end;


function OpenDIB(var TheFile: File): Boolean;
var
  bitCount: Word;
  size: Word;
  longWidth: Longint;
  DCHandle: HDC;
  BitsPtr: Pointer;
  BitmapInfo: PBitmapInfo;
  BitsHandle, NewBitmapHandle: THandle;
  NewPixelWidth, NewPixelHeight: Word;
begin
  OpenDIB := True;
  Seek(TheFile, 28);
  BlockRead(TheFile, bitCount, SizeOf(bitCount));
  if bitCount <= 8 then
  begin
    size := SizeOf(TBitmapInfoHeader) + ((1 shl bitCount) * SizeOf(TRGBQuad));
    BitmapInfo := MemAlloc(size);
    Seek(TheFile, SizeOf(TBitmapFileHeader));
    BlockRead(TheFile, BitmapInfo^, size);
    NewPixelWidth := BitmapInfo^.bmiHeader.biWidth;
    NewPixelHeight := BitmapInfo^.bmiHeader.biHeight;
    longWidth := (((NewPixelWidth * bitCount) + 31) div 32) * 4;
    BitmapInfo^.bmiHeader.biSizeImage := longWidth * NewPixelHeight;
    GlobalCompact(-1);
    BitsHandle := GlobalAlloc(gmem_Moveable or gmem_Zeroinit,
      BitmapInfo^.bmiHeader.biSizeImage);
    GetBitmapData(TheFile, BitsHandle, BitmapInfo^.bmiHeader.biSizeImage);
    DCHandle := CreateDC('Display', nil, nil, nil);
    BitsPtr := GlobalLock(BitsHandle);
    NewBitmapHandle :=
      CreateDIBitmap(DCHandle, BitmapInfo^.bmiHeader, cbm_Init, BitsPtr,
      BitmapInfo^, 0);
    DeleteDC(DCHandle);
    GlobalUnlock(BitsHandle);
    GlobalFree(BitsHandle);
    FreeMem(BitmapInfo, size);
    if NewBitmapHandle <> 0 then
    begin
      if BitmapHandle <> 0 then DeleteObject(BitmapHandle);
      BitmapHandle := NewBitmapHandle;
      Width := NewPixelWidth;
      Height := NewPixelHeight;
    end
    else
      OpenDIB := False;
  end
  else
    OpenDIB := False;
end;

function LoadBitmapFile(Name: PChar): Boolean;
var
  TheFile: File;
  TestWin30Bitmap: Longint;
begin
  LoadBitmapFile := False;
  Assign(TheFile, Name);
  Reset(TheFile, 1);
  Seek(TheFile, 14);
  BlockRead(TheFile, TestWin30Bitmap, SizeOf(TestWin30Bitmap));
  if TestWin30Bitmap = 40 then
    if OpenDIB(TheFile) then
    begin
      LoadBitmapFile := True;
      {IconImageValid := False;}
    end
    else
      MessageBox(HWindow, 'Unable to create Windows 3.0 bitmap from file.',
	Name, mb_Ok)
  else
      MessageBox(HWindow, 'Not a Windows 3.0 bitmap file.  Convert using Paintbrush.', Name, mb_Ok);
  Close(TheFile);
end;
{$endif}
{$endif}



begin

  TWindow.Init(aparent,TheTitle);
  
  {Toolbar := New(PToolbar, Init(@Self, 'Toolbar_3', -1,-1,5,5,tbhorizontal));}
  {dc:=getdc(hwindow);
  cont:=dc;
  Larg_scheda:=getdevicecaps(cont,horzres);
  Alt_scheda:=getdevicecaps(cont,vertres);}
  punmainwin:=@self;
  pmainwin:=@self;
  cur_asp:=loadcursor(0,idc_wait);
  dirwm:=get_drive;
  {initgrafica:=true;}
  tviswincl:=true;
  initprogram;
  BitMapHandle:=0;
  {releasedc(hwindow,dc);}

  {BitMapHandle:=LoadBitmap(HInstance, thetitle);
  GetObject(BitMapHandle, SizeOf(BitInfo), @BitInfo);}
  {$ifdef free}
   {$ifdef deb}
   {$else}
  if strcomp(thetitle,'') >0 then
   LoadBitmapFile(THetitle);
(* with Fonte do
  begin
  lfHeight:=-12;
  LfWidth :=0;
  LfEscapement:=0;
  LfOrientation:=0;
  lfWeight     :=Fw_extralight;
  LfItalic:=0;
  lfUnderline:=0;
  LfStrikeOut:=0;
  LfCharSet  :=ANSI_charSet;
  LfOutPrecision:=Out_Default_Precis;
  LfClipPrecision:=Clip_Default_Precis;
  LfQuality:=Draft_Quality;
  LfPitchAndFamily:=Variable_Pitch or ff_Roman;
  StrCopy(@lfFaceName,'Times new roman');
  end;
  patdr1:='';
  GetDir(0,Drive1);

  if exist(DRIVE1+'\nomeclie.dat') then patdr1:=drive1 else
  if exist(get_drive+'\nomeclie.dat') then patdr1:=get_drive;
  if patdr1>'' then
  begin
    assign(f,patdr1+'\nomeclie.dat');
    reset(f);
    read(f,nome);
    close(f);
    ditta:='';
    indirizzo:='';
    citta:='';
    for i:=1 to 150 do
    case i of
      1..50 :begin
               if nome[i]<>0 then ditta:= ditta+chr(round(nome[i]));
             end;
     51..100:begin
               if nome[i]<>0 then indirizzo:=indirizzo+chr(round(nome[i]));
             end;
    101..150:begin
              if nome[i]<>0 then citta:=citta+chr(round(nome[i]));
             end;
    end;
    ditta:=formst1(ditta);
    indirizzo:=formst1(indirizzo);
    citta:=formst1(citta);
  end
  else
  begin
    writemessage('hvac.msg',16);
    halt;
  end; *)
   {$endif}
  {$endif}
end;

procedure tmainwindow.writecaption(var msg:owindows.Tmessage);
var nomep:string[80];
    nomepc:array[0..80] of char;
begin
  nomep:=nomeprogetto;
  strpcopy(nomepc,nomep);
  oemtoansi(nomepc,nomepc);
  setcaption(nomepc);
  defWndProc(msg);
end;


{
procedure EnableEditorMenuItems(NewState: Boolean);

begin

  if Application^.MainWindow^.HWindow = 0 then Exit;

  with PMiaWindow(Application^.MainWindow)^ do

  begin
    EnableCommand(cm_first+10001, NewState);
  end;

end;
}
procedure TMainwindow.setupwindow;
var msg:owindows.tmessage;
begin
  inherited setupwindow;
  {EnableEditorMenuItems(False);}
  {CheckMenuItem(Attr.Menu, cm_HorizontalToolbar, mf_ByCommand or mf_Checked);}
  writecaption(msg);
end;
(*
procedure tmainwindow.RedoClientRect;
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
procedure tmainwindow.CalcClientRect(var R: TRect);
  procedure NotifyChildren( P: PWindow ); far;
  begin
    if P^.HWindow <> 0 then
      SendMessage(P^.HWindow, am_CalcParentClientRect, DenyRepaint, Longint(@R));
  end;
begin
  GetClientRect(HWindow, R);
  ForEach(@NotifyChildren);
end;
*)
procedure tmainwindow.EnableCommand(Command: Word; EnableIt: Boolean);
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
   {Toolbar^.EnableTool(Command, EnableIt);}
  end;
end;

(*
procedure tmainwindow.HorizontalToolbar(var Msg: TMessage);
begin
 { if Toolbar^.GetOrientation <> tbHorizontal then
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
    CheckMenuItem(Attr.Menu, cm_LeftverticalToolbar, mf_ByCommand or mf_UnChecked);
    CheckMenuItem(Attr.Menu, cm_RightverticalToolbar, mf_ByCommand or mf_UnChecked);
  end;
  }
end;

procedure tmainwindow.RightVerticalToolbar(var Msg: TMessage);
begin
  {
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
  }
end;

procedure tmainwindow.LeftVerticalToolbar(var Msg: TMessage);
begin
  {
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
  }
end;


*)


procedure TMainwindow.WMDrawStatusLine(var Msg: owindows.TMessage);


var
  hd:hwnd;
  i:integer;
  DC: HDC;
  Rect: TRect;
  StrM: array[0..128] of Char;
  strS:string[128];
  StrID: Integer;
  hOld: HFont;
  TextHeight: Integer;
  st:string[3];
  campo:integer;
  ntab:string;
  nt:st8;
begin
  DC := GetDC(HWindow);
  BlastStatusLine(DC);
  hOld := SelectObject(DC, GetStockObject(system_font));
  GetClientRect(HWindow, Rect);
  SetBKColor(DC, RGB(192, 192, 192));
  TextHeight :=  HiWord( GetTextExtent( DC, StrM, 1) );
  A_W:=MSG.WPARAM;
  IF a_w>0 then
  with tabellacorrente^[a_w] do
  begin
    ntab:=nome+'.msk';
    campo:=dialog^.campoattivo-100;
    if (campo >0) and (dialog^.Tab^[campo].Help >0)
    then
     strs:=ReadLineHelp(NTab,dialog^.Tab^[campo].Help,dialog^.Tab^[campo].NCAMPOTAB)
    else
     strs:='                                                      ';
  end
  else
  strs:=elstr^[1];
  strpcopy(strm,strs);
  oemtoansi(strm,strm);
  TextOut(DC, TextStart+10,
           Rect.bottom - StatusLineHeight + ( ( StatusLineHeight - TextHeight ) div 2),
           StrM, strlen(StrM));

  SelectObject(DC, hOld);
  ReleaseDC(HWindow, DC);
end;

procedure TMainwindow.WMSize(var Msg: owindows.TMessage);
var
  R: TRect;
  dc:hdc;
begin
  if (Scroller <> nil) and (Msg.WParam <> sizeIconic) then
    Scroller^.SetPageSize;
  if Msg.wParam = sizeNormal then
  begin
    GetWindowRect(HWindow, R);
    Attr.H := R.bottom - R.top;
    Attr.W := R.right - R.left;
  end;
  {RedoClientRect;}
  invalidaterect(hwindow,nil,false);
  ReconstructStatusLine;
end;

procedure TMainwindow.ReconstructStatusLine;
var
  Bmp: HBitmap;
  DC: HDC;
  DestDC: HDC;
  OldSrc: HBitmap;
  OldDest: HBitmap;
  Rect: TRect;
  SrcDC: HDC;
begin
  GetClientRect(HWindow, Rect);
  DC := GetDC(HWindow);
  SrcDC := CreateCompatibleDC(DC);
  DestDC := CreateCompatibleDC(DC);
  ReleaseDC(HWindow, DC);

  Bmp := LoadBitmap(HInstance, MakeIntResource(bmp_StatusLine));
  OldSrc := SelectObject(SrcDC, Bmp);
  if BmpStatusLine <> 0 then
    DeleteObject(BmpStatusLine);
  BmpStatusLine := CreateCompatibleBitmap(DC, Rect.Right, StatusLineHeight);
  OldDest := SelectObject(DestDC, BmpStatusLine);

  BitBlt(DestDC, 0, 0, 5, StatusLineHeight, SrcDC, 0, 0, srcCopy);
  StretchBlt(DestDC, 5, 0, Rect.Right - 5, StatusLineHeight,
             SrcDC, 6, 0, 20, StatusLineHeight, srcCopy);
  BitBlt(DestDC, Rect.Right - 5, 0, 5, StatusLineHeight, SrcDC, 59, 0, srcCopy);

  SelectObject(SrcDC, BmpStatusBar);
  BitBlt(DestDC, 40, 0, 10, StatusLineHeight,
         SrcDC, 0, 0, SrcCopy);
  BitBlt(DestDC, 100, 0, 10, StatusLineHeight,
         SrcDC, 0, 0, SrcCopy);
  BitBlt(DestDC, TextStart, 0, 10, StatusLineHeight,
         SrcDC, 0, 0, SrcCopy);


  SelectObject(SrcDC, OldSrc);
  BmpStatusLine := SelectObject(DestDC, OldDest);
  DeleteDC(SrcDC);
  DeleteDC(DestDC);
  DeleteObject(Bmp);
end;



Procedure TMainWindow.HelpMaschera(var msg:Tmessage);
VAR FileHlp:string;
begin
  if a_w in [1..maxtabelle] then
  begin
  FileHlp:=tabellacorrente^[a_w].nome+'.hlp';
  if exist(fileHlp) then vishelp(filehlp);
  end
  else vishelp('helpmask.hlp');
end;
Procedure TMainWindow.Helpcampo(var msg:Tmessage);
var stcam:st2;
VAR FileHlp:string;
begin
  if a_w > 0 then
  begin
    if Tabellacorrente^[a_w].maniglia>0 then
    with Tabellacorrente^[a_w] do
    begin
      str(dialog^.tab^[dialog^.campoprecedente-100].NCampoTab,Stcam);
      FileHlp:=tabellacorrente^[a_w].nome+'.h'+StCam;
    end;
  end
  else
  vishelp('helpcamp.hlp');
end;
Procedure TMainWindow.HelpErrori(var msg:Tmessage);
VAR FileHlp:string;
begin
  FileHlp:='errori.hlp';
  if exist(fileHlp) then vishelp(filehlp);
end;




procedure TMainwindow.BlastStatusLine(PaintDC: HDC);
var
  ClientRect: TRect;
  MemDC: HDC;
  OldBmp: THandle;
begin
  GetClientRect(HWindow, ClientRect);
  MemDC := CreateCompatibleDC(PaintDC);
  OldBmp := SelectObject(MemDC, BmpStatusLine);
  with ClientRect do
    BitBlt(PaintDC, 0, Bottom - StatusLineHeight, ClientRect.Right,
      StatusLineHeight, MemDC, 0, 0, SrcCopy);
  SelectObject(MemDC, OldBmp);
  DeleteDC(MemDC);
end;
procedure TMainwindow.Paint(PaintDC: HDC; var PaintInfo: TPaintStruct);
var r:trect;

    MemDC: HDC;
    OldBitmap: HBitmap;
    lef,top:integer;
    pc:array[0..50] of char;
    ps:string[50];
begin
  TWindow.Paint(PaintDC, PaintInfo);
  if BitMapHandle <> 0 then
  begin
    GetClientRect(HWindow, R);
    MemDC := CreateCompatibleDC(PaintDC);
    {if IsIconic(HWindow) and IconImageValid then
    begin
      OldBitmap := SelectObject(MemDC, IconizedBits);
      BitBlt(PaintDC, 0, 0, Width, Height, MemDC, 0, 0, SRCCopy);
    end
    else}
    begin
      SelectObject(MemDC, BitMapHandle);
      if false then
      begin
	GetClientRect(HWindow, R);
	SetCursor(LoadCursor(0, idc_Wait));
	StretchBlt(PaintDC, 0, 0, R.Right, R.Bottom, MemDC, 0, 0,
	  BitInfo.bmWidth, BitInfo.bmHeight, SRCCopy);
	SetCursor(LoadCursor(0, idc_Arrow));
      end
      else
      begin
        SelectObject(MemDC, BitMapHandle);
        Lef := R.Right div 2 - Width div 2;
        Top := R.Bottom div 2 - Height div 2;
        BitBlt(PaintDC, Lef, Top, Width, Height,
                   MemDC, 0, 0, SrcCopy);

        (*
        SetTextColor(Paintdc,0);
        SetBkMode(paintdc,transparent);
        deleteobject(selectobject(paintdc,createfontindirect(fonte)));

        fillchar(pc,sizeof(pc),0);
        {ps:='';
        ps:='Rilasciato a:';
        strpcopy(pc,ps);
        textout(paintdc,lef+95,top+200,pc,length(ps));}
        fillchar(pc,sizeof(pc),0);
        ps:='';
        ps:=ditta;
        strpcopy(pc,ps);
        textout(paintdc,lef+122,top+260,pc,length(ps));
        fillchar(pc,sizeof(pc),0);
        ps:='';
        ps:=indirizzo;
        strpcopy(pc,ps);
        textout(paintdc,lef+122,top+272,pc,length(ps));
        fillchar(pc,sizeof(pc),0);
        ps:='';
        ps:=citta;
        strpcopy(pc,ps);
        textout(paintdc,lef+122,top+284,pc,length(ps));    *)
      end;
       {	BitBlt(PaintDC, 0, 0, BitInfo.bmWidth, BitInfo.bmHeight, MemDC, 0, 0, SRCCopy);}
    end;
    DeleteDC(MemDC);
  end;
  BlastStatusLine(PaintDC);
  {visbit(r,'hvacbit');}
end;


destructor tmainwindow.done;
begin
  DeleteObject(BmpStatusLine);
  DeleteObject(BmpStatusBar);
  disposeprogram;
  twindow.done;
end;

procedure tmainwindow.uscita(var msg:owindows.tmessage);
var i:integer;
begin
  for I:= maxtabelle downto 1 do
  with tabellacorrente^[i] do
  begin
    if maniglia> 0 then
    begin
      setactivewindow(dialog^.hwindow);
      if conferma('utiliti.msg','',1)  then dialog^.ok(msg)
      else dialog^.cancel(msg);
      MANIGLIA:=0;
    end;
  end;
  postmessage(hwindow,wm_close,0,0);
end;
function tmainwindow.canclose:boolean;
var i:integer;
    msg:tmessage;
    f:text;
begin
  (*for I:= maxtabelle downto 1 do
  with tabellacorrente^[i] do
  begin
    if maniglia> 0 then
    begin
      setactivewindow(dialog^.hwindow);
      if conferma('utiliti.msg','',1)  then dialog^.ok(msg)
      else dialog^.cancel(msg);
      MANIGLIA:=0;
    end;
  end;
  *)
  inherited canclose;
  canclose:=true;
  assign(fpostab,'postab.dat');
  rewrite(fpostab);
  for i:=1 to ulttab do
    write(fpostab,postab^[i]);
  close(fpostab);
end;

end.
