unit uti_calc;
interface
{$ifdef win}
uses OWindows, Objects, ODialogs, WinTypes, WinProcs, Strings,
     bwcc{$ifdef delphi},messages{$endif},windos;

const wm_calc = wm_User + 200;


type


  TCalcApp = object(TApplication)
    procedure InitMainWindow; virtual;
    procedure run;virtual;

  end;

  Pcalc = ^Tcalc;
    tcalc=object(tdialog)
    statico:array[1..44] of pstatic;
    constructor init(Aparent:pwindowsobject;Thetitle:pchar);
    procedure calcolow(var msg:tmessage);virtual wm_first + wm_calc;
    procedure setupwindow; virtual;
    procedure wminitdialog(var msg:owindows.tmessage);virtual wm_first+wm_initdialog;
    procedure f1;virtual id_first+11;
    procedure ok(var msg:owindows.tmessage);virtual id_first+ id_ok;


  end;
  var
  vcalc:pcalc;
  calcapp:tcalcapp;
{$endif}
  procedure writeC(st:string;n:integer);
{--------------------------------------------------------------------------}

implementation

uses {$ifdef calcoli}calcolo_tubi{$else}stampe{$endif};
procedure writec(st:string;n:integer);
var pc:array[0..80] of char;
    ps:string[80];
begin
  {$ifdef dos}
  write(st);
  {$endif}
  {$IFdef win}
   ps:=st;
   strpcopy(pc,ps);
   oemtoansi(pc,pc);
   with vcalc^ do
   WITH statico[n]^ DO
   settext(pc);
  {$endif}
end;
{$ifdef win}
procedure tcalc.f1;
var i:integer;
    hd:hwnd;
begin
  setdlgitemtext(hwindow,11,'Comtinua');
  messagebeep(10);
end;

Constructor Tcalc.Init(Aparent:pwindowsobject; TheTitle: PChar);
var fp:text;
    i:integer;
begin
  inherited init(aparent,Thetitle);
  for i :=1 TO 20 do
  begin
    statico[i]:=new(pstatic,initresource(@self,i,80+1));
    statico[i]^.disabletransfer;
  end;
  VCALC:=@SELF;
end;

procedure tcalc.setupwindow;
var i:integer;

begin
  inherited setupwindow;
  for i:=1 TO 20 do
  begin
    statico[i]^.clear;
  end;
  settimer(hwindow,11,0,nil);
end;

procedure tcalc.wminitdialog(var msg:owindows.tmessage);
var x1,y1,w1,h1,larg_scheda,alt_Scheda:integer;
    CONT:HDC;
    r:trect;
begin

  cont:=getdc(Hwindow);
  Larg_scheda:=getdevicecaps(cont,horzres);
  Alt_scheda:=getdevicecaps(cont,vertres);
  releasedc(hwindow,cont);
  getwindowrect(hwindow,r);
  w1:=r.right-r.left;
  h1:=r.bottom-r.top;
  x1:=(larg_scheda-w1) div 2 ;
  y1:=(alt_scheda-h1) div 2;
  movewindow(hwindow,X1,Y1,w1,h1,false);
  inherited wminitdialog(msg);
   postmessage(vcalc^.hwindow,wm_calc,0,0);
end;
procedure tcalc.calcolow(var msg:tmessage);
var i:integer;
begin
  {$ifdef calcoli}
  calcoli;
  {$else}
  stampa_w;
  {$endif}
 { postmessage(hwindow,wm_close,0,0);}
end;
procedure tcalcapp.run;
begin
  inherited run;
end;

procedure tcalc.ok(var msg:owindows.tmessage);
var
f:file;
s:tsearchrec;
Fw:TEXT;
st:string[80];
pc:array[0..80] of char;
hd:thandle;
begin
  FindFirst('*.sce', FaArchive, s);
  while DosError = 0 do
  begin
    assign(f,s.Name);
    erase(f);
    FindNext(s);
  end;
  assign(fw,'wintxt.dat');
  reset(fw);
  read(fw,st);
  close(fw);
  strpcopy(pc,st);
  hd:=0;
  hd:=findwindow('TurboWindow',pc);
  if hd<> 0 then
  postmessage(hd,wm_command,161,0);
  postmessage(hwindow,wm_quit,0,0);
{  done;}
end;


procedure TcalcApp.InitMainWindow;
begin
  MainWindow := New(Pcalc, Init(nil, 'writewin'));
end;
{$endif}
end.




