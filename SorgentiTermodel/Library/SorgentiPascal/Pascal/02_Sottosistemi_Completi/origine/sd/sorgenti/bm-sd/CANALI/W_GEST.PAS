program W_gest;
{$ifdef francia}
{$R gductfr.RES}
{$endif}

{$ifdef inglese}
{$R gducteng.RES}
{$endif}


{$ifdef italia}
{$R gestduct.RES}
{$endif}

{$ifdef tedesco}
{$R gducted.RES}
{$endif}

{$ifdef spagna}
{$R gductesp.RES}
{$endif}
{$F+}
uses OWindows, Objects, ODialogs, WinTypes, WinProcs, Strings,validate,defuti,
     gestduct,bwcc,wm,definiz,main_w,utilitie,prgduct,init_cca,prntesto;


type

  TGestDuctApp = object(TApplication)
    procedure InitMainWindow; virtual;
  end;

  PDuctWindow = ^TDuctWindow;
    tductwindow=object(tmainwindow)
    constructor init(Aparent:pwindowsobject;Thetitle:pchar);
    procedure archprg(var Msg: TMessage); virtual cm_First+ 10001;
    procedure Misure(var Msg: TMessage);virtual cm_First + 10002;
    procedure Costanti(var Msg: TMessage);virtual cm_First + 10003;
    procedure RIDUZ(var Msg: TMessage);virtual cm_First + 10004;
    procedure PEZZI(var Msg: TMessage);virtual cm_First + 10005;
    Procedure DatiGen(var msg:Tmessage);virtual cm_first +10006;
    Procedure DatiErr(var msg:Tmessage);virtual cm_first +10007;
    procedure Inp_graf(var msg:Tmessage);virtual cm_first +10008;
    procedure Dis_dim(var msg:Tmessage);virtual cm_first +10009;
    Procedure ElencoPiante(var msg:Tmessage);virtual cm_first +10010;
    Procedure ElencoSezioni(var msg:Tmessage);virtual cm_first +10011;
    procedure computoMetrico(var msg:Tmessage);virtual cm_first +10028;
    procedure w_cum(var msg:Tmessage);virtual cm_first +10033;
    procedure Mand_1(var msg:Tmessage);virtual cm_first +10012; {predim}
    procedure Mand_2(var msg:Tmessage);virtual cm_first +10013; {calc+bil+s rami}
    procedure Mand_3(var msg:Tmessage);virtual cm_first +10014; {calc+bil+s term}
    procedure Mand_4(var msg:Tmessage);virtual cm_first +10015; {calc+bil}
    procedure Mand_5(var msg:Tmessage);virtual cm_first +10029; {Verifica}
    procedure Mand_6(var msg:Tmessage);virtual cm_first +10016;
    procedure Mand_7(var msg:Tmessage);virtual cm_first +10017;
    procedure Mand_8(var msg:Tmessage);virtual cm_first +10018;

    procedure Ripr_1(var msg:Tmessage);virtual cm_first +10019;
    procedure Ripr_2(var msg:Tmessage);virtual cm_first +10020;
    procedure Ripr_3(var msg:Tmessage);virtual cm_first +10021;
    procedure Ripr_4(var msg:Tmessage);virtual cm_first +10022;
    procedure Ripr_5(var msg:Tmessage);virtual cm_first +10023;
    procedure Ripr_6(var msg:Tmessage);virtual cm_first +10030;
    procedure Ripr_7(var msg:Tmessage);virtual cm_first +10024;
    procedure Ripr_8(var msg:Tmessage);virtual cm_first +10025;
    procedure Ripr_9(var msg:Tmessage);virtual cm_first +10026;
    procedure stampe(var msg:Tmessage);virtual cm_first +10027;
    procedure ese_stam(var Msg: TMessage);virtual cm_first + 10031;
    procedure getwindowclass(var aclass:twndclass);virtual;
  end;


{--------------------------------------------------------------------------}


procedure tductwindow.getwindowclass(var aclass:twndclass);
var classe:pchar;
begin
  twindow.getwindowclass(aclass);
  aclass.hbrbackground:=Getstockobject(Ltgray_brush);
  aclass.hicon:=loadicon(hinstance,'DUCT');
end;

Constructor TDuctWindow.Init(Aparent:pwindowsobject; TheTitle: PChar);
begin
  inherited init(aparent,Thetitle);
  Attr.Menu := LoadMenu(HInstance, 'Menu_1');
initcca;
archivioprogetti:=true;
datigen1:=true;
datigen2:=true;
archiviopezzipc:=true;
arcriduz:=true;
arcmisure:=true;
piantecl:=true;
sezionicl:=true;
erroricl:=true;
costantididis:=true;
end;

procedure TDuctWindow.Archprg(var Msg: TMessage);
begin
  GESTPRG(21);
end;
procedure TDuctWindow.Misure(var Msg: TMessage);
begin
  GESTPRG(22);
end;
procedure TDuctWindow.costanti(var Msg: TMessage);
begin
  GESTPRG(23);
end;
procedure TDuctWindow.RIDUZ(var Msg: TMessage);
begin
  GESTPRG(24);
end;

procedure TDuctWindow.pezzi(var Msg: TMessage);
begin
  GESTPRG(25);
end;

procedure TDuctWindow.Datigen(var Msg: TMessage);
begin
  GESTPRG(31);
end;
procedure TDuctWindow.datiErr(var Msg: TMessage);
begin
  GESTPRG(32);
end;
procedure TDuctWindow.ElencoPiante(var Msg: TMessage);
begin
  GESTPRG(43);
end;

procedure TDuctWindow.ElencoSezioni(var Msg: TMessage);
begin
  GESTPRG(44);
end;


procedure eseguicalcolo;
begin
  assign(ftext,'prog.can');
  rewrite(ftext);
  write(ftext,NumeroProg);
  close(ftext);
  winexec('w_calc.exe',sw_showmaximized);
end;

procedure tductwindow.inp_graf(var Msg: TMessage);
var ps:string[80];
    pc:array[0..80]of char;
begin
gestprg(41);
ps:=GET_drive+'\cca\inpgraf\w_inputc.exe';
strpcopy(pc,ps);
if getmodulehandle(pc)=0 then
begin
  if numeroprog>'' then
  begin
    winexec(pc,sW_showmaximized);
  end
  else
  writemessage('duct.msg',11);
end
else
writemessage('duct.msg',12);
end;

procedure tductwindow.dis_dim(var Msg: TMessage);
var ps:string[80];
    pc:array[0..80]of char;
begin
  gestprg(42);
  ps:=GET_drive+'\cca\inpgraf\w_dimens.exe';
  strpcopy(pc,ps);
  winexec(pc,sw_showmaximized);
end;

procedure tductwindow.mand_1(var Msg: TMessage);
begin
  gestprg(51);
  eseguicalcolo;
end;

procedure tductwindow.mand_2(var Msg: TMessage);
begin
  gestprg(52);
  eseguicalcolo;
end;

procedure tductwindow.mand_3(var Msg: TMessage);
begin
  gestprg(53);
  eseguicalcolo;
end;

procedure tductwindow.mand_4(var Msg: TMessage);
begin
  gestprg(54);
  eseguicalcolo;
end;

procedure tductwindow.mand_5(var Msg: TMessage);
begin
  gestprg(55);
  eseguicalcolo;
end;

procedure tductwindow.mand_6(var Msg: TMessage);
begin
  gestprg(56);
  eseguicalcolo;
end;


procedure tductwindow.mand_7(var Msg: TMessage);
begin
  gestprg(57);
  eseguicalcolo;
end;

procedure tductwindow.mand_8(var Msg: TMessage);
begin
  gestprg(58);
  eseguicalcolo;
end;


procedure tductwindow.ripr_1(var Msg: TMessage);
begin
  gestprg(61);
  eseguicalcolo;
end;

procedure tductwindow.ripr_2(var Msg: TMessage);
begin
  gestprg(62);
  eseguicalcolo;
end;

procedure tductwindow.ripr_3(var Msg: TMessage);
begin
  gestprg(63);
  eseguicalcolo;
end;

procedure tductwindow.ripr_4(var Msg: TMessage);
begin
  gestprg(64);
  eseguicalcolo;
end;

procedure tductwindow.ripr_5(var Msg: TMessage);
begin
  gestprg(65);
  eseguicalcolo;
end;

procedure tductwindow.ripr_6(var Msg: TMessage);
begin
  gestprg(66);
  eseguicalcolo;
end;

procedure tductwindow.ripr_7(var Msg: TMessage);
begin
  gestprg(67);
  eseguicalcolo;
end;

procedure tductwindow.ripr_8(var Msg: TMessage);
begin
  gestprg(68);
  eseguicalcolo;
end;

procedure tductwindow.ripr_9(var Msg: TMessage);
begin
  gestprg(69);
  eseguicalcolo;
end;

procedure tductwindow.stampe(var Msg: TMessage);
begin
  gestprg(71);
  eseguicalcolo;
end;

procedure Tductwindow.computoMetrico(var msg:Tmessage);
begin
  gestprg(72);
end;

procedure Tductwindow.w_cum(var msg:Tmessage);
begin
  w_caricamisure;
end;

procedure tductwindow.ese_stam(var Msg: TMessage);
begin
  gestprg(61);
  setcursor(cur_asp);
  eseguistampa;
end;
procedure TGestductApp.InitMainWindow;
begin
  MainWindow := New(PDuctWindow, Init(nil, 'Mc4 software- MC4-hvac  DUCT'));
end;





var
  Gestductapp: TGestductApp;
  r:trect;
  f:text;
begin
  chdir(get_drive+'\cca');
  @Win31LockWindowUpdate :=
    GetProcAddress(GetModuleHandle('User'), PChar(294));
  visbit(r,'DUCT');
  assign(fi,'debug.txt');
  rewrite(fi);
  Gestductapp.Init('Gestduct');
  showwindow(pmainwin^.hwindow,sw_Showmaximized);
  Gestductapp.Run;
  Gestductapp.Done;
end.
