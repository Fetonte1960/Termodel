{$R+}    {Range checking off}
{$B-}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

program inputcar;

{$R duct.res}

uses owindows, WinProcs,Strings, WinTypes, WinDos,inputcan,Graph,Ridis_u,
     read_c,win_uti,halotp4,definiz,funzbase,genproc,load_d,winD_menu,odialogs;

{----------------------------------------------------------------------------}
Function Sel_Linea(x,y:real):integer;

Var i,res,numlinea:integer;
  {  dialog:pdialogo;}
begin
NumLinea:=0;

if not vuoto then

  begin
        i:=0;
        res:=0;

        while (res=0) and (i<UltRiga) do

          begin
          i:=i+1;
          with dis^[i]^ do

            begin
            if (entita='L')and(flag) then
              begin
             { writeln(lst,' X1:',xg(x1,y1),' X2:',xg(x2,y2),' y1:',yg(y1,z1),' y2:',yg(y2,z2));}
              inters(real1,real2,res,xg(x1,y1),xg(x2,y2),x+5,x-5,yg(y1,z1),yg(y2,z2),y+5,y-5,0.001);
              if res=0 then
              inters(real1,real2,res,xg(x1,y1),xg(x2,y2),x-5,x+5,yg(y1,z1),yg(y2,z2),y+5,y-5,0.001);
              end;
            end;

          end;

        if res<>0 then
        NumLinea:=i
        else
          begin
          numlinea:=0;
          end;


  end;
sel_linea:=Numlinea;
end;

{----------------------------------------------------------------------------}
Const Tronco_dal=104;
      Zoom_f    =103;
      Zoom_t    =116;
      Zoom_p    =117;
      Zoom_l    =118;
      Zoom_s    =119;
      Zoom_r    =120;
      Cancella  =108;
      Dis_dim   =112;
      Dis_nodi  =123;
      Dis_unif  =124;
      M_osnap   =125;
      Car_tutti =111;
type
  TMyApplication = object(TApplication)
    procedure InitMainWindow; virtual;
    Function CanClose:Boolean;Virtual;
  end;


  PMyWindow = ^TMyWindow;
  TMyWindow = object(Win_menu)
  constructor Init(AParent: PWindowsObject; ATitle: PChar);
  Procedure Menu_Com(Opzione:integer);Virtual {wm_First +Wm_menuselect};
  end;

  PChWindow = ^TChWindow;
  TChWindow = object(TWindow)
  constructor Init(AParent: PWindowsObject; ATitle: PChar);
  function  getClassname:pchar;virtual;
  procedure getwindowclass(var aclass:twndclass);virtual;
  procedure Paint(PaintDC: HDC; var PaintInfo: TPaintStruct);Virtual;
  Procedure M_cur(var Msg: TMessage);virtual wm_First + wm_MouseMove;
  Procedure WMLButtonDown(var Msg: TMessage);Virtual wm_First + wm_LbuttonDown;
  Procedure WMRButtonDown(var Msg: TMessage);Virtual wm_First + wm_RbuttonDown;
  end;

Var NumCom,fase,Ult_com:integer;
{----------------------------------------------------------------------------}
procedure Esegui_com(var scelta:integer);
begin
assign(ffasi,'fasi.txt');
rewrite(ffasi);
writeln(ffasi,'Comando:',scelta:3);
win_er:='';
Ult_com:=NumCom;
Num_interf:=0;
esegui(scelta);
if win_er<>'' then  errore(win_er);
close(ffasi);
end;

{----------------------------------------------------------------------------}
procedure Annulla;
begin
CancCur;
Cod_cur:=0;
NumCom:=0;
end;
{----------------------------------------------------------------------------}

Procedure Interf(Nl:integer;I_x,I_y:real;I_code:integer;I_st:string;I_Uscita:integer);
begin
with interf_com[NL] do
  begin
  x:=I_x;
  y:=I_y;
  code:=I_code;
  uscita:=I_uscita;
  st:=I_st;
  end;
end;
{----------------------------------------------------------------------------}
procedure TMyApplication.InitMainWindow;
begin
  MainWindow := New(pmywindow, Init(nil, 'PRINCIPALE'));
end;
{----------------------------------------------------------------------------}
Function TMyApplication.CanClose;
Var risposta:integer;
begin
CanClose:=true;
Risposta:=MessageBox(0,'Volete salvare le modifiche','Mc4 , DUCT : richiesta di uscita',
           Mb_yesNoCancel or Mb_systemModal or Mb_iconexclamation);{*TR*}
  case risposta of
  idyes:Savedis(DataDrive+NomeProg);
  idcancel:CanClose:=False;
  end;
end;
{----------------------------------------------------------------------------}

constructor TMyWindow.Init(AParent: PWindowsObject; ATitle: PChar);
Var mw:Pchwindow;
    ms:Pstatico;
    riuscito:boolean;

begin
  tdlgwindow.Init(AParent, ATitle);
  PDW:=@SELF;
  dato:='Messaggio';
  transferbuffer:=@dato;
  ms:=new(pstatico,initresource(@self,200,30));

  {TWindow.Init(AParent, ATitle);
  Attr.Menu := LoadMenu(HInstance,'Menu_1');}

  Prog_init;
  Cod_cur:=0;
  Numcom:=0;
  ult_com:=0;
  new(mw,init(@self,'Finestra di disegno'));
{  dlg_posx:=1;dlg_posy:=426;
  dialog:=new(pdialogo,init(@self,'DIALOG_1'));}
end;
{----------------------------------------------------------------------------}



constructor TChWindow.Init(AParent: PWindowsObject; ATitle: PChar);
begin
  TWindow.Init(AParent, ATitle);
  attr.x:=0;
  attr.y:=0;
  attr.h:=H_win;
  attr.w:=W_win;
  attr.style:=attr.style or{ ws_overlappedwindow or} ws_child {or ws_caption}or ws_dlgframe {or ws_border};
{ fillchar(dato,sizeof(dato),0);
  dato.s:='Messaggio';}
  { new(mw,init(@self,'Piano XY2'));}
end;


function tchwindow.getclassname:pchar;
begin
  getclassname:='FinestraDis';
end;

procedure TchWindow.getwindowclass(var aclass:twndclass);
var classe:pchar;
begin
  twindow.getwindowclass(aclass);
  aclass.hbrbackground:=Getstockobject(black_brush);
end;


{----------------------------------------------------------------------------}

(*
Procedure TMyWindow.GetWindowClass(Var AWndClass:Twndclass);
begin

TWindow.GetWindowClass(AWndClass);
AWndClass.hbrBackground := GetStockObject(Black_brush);

end;
*)

{----------------------------------------------------------------------------}
Procedure InitCom;
begin
Fase:=1;
end;
{----------------------------------------------------------------------------}
Procedure EseGui_Zoom(tipo:string);
begin
Interf(1,0,0,0,Tipo,0);
scelta:=3;
Esegui_com(scelta);
annulla;
end;
{----------------------------------------------------------------------------}
Procedure Menu(scelta:integer);
Var Risposta:integer;
begin
initcom;
NumCom:=scelta;
Case scelta of
Zoom_f:Cod_cur:=1;

Tronco_dal:
    begin
    if vuoto then
      begin
      if c_osnap then cod_cur:=3 else Cod_cur:=11
      end
    else cod_cur:=5 ;
    retino:=true;
    end;
CanCella:
    if vuoto then Numcom:=0
    else cod_cur:=3;
Zoom_t:EseGui_zoom('T');{*TR*}
Zoom_p:EseGui_zoom('P');{*TR*}
Zoom_l:EseGui_zoom('L');{*TR*}
Zoom_s:EseGui_zoom('S');{*TR*}
Zoom_r:EseGui_zoom('R');{*TR*}
Car_tutti:
    begin
    Risposta:=MessageBox(0,
             'Tutti i dati tabellari precedentemente inputati verranno cancellati : confermi ?',
             'Caricamento dati dei pezzi',
           Mb_okCancel or Mb_systemModal or Mb_iconexclamation);{*TR*}
    if risposta=idok then
      begin
      Interf(1,0,0,0,'C',0);{*TR*}
      Interf(2,0,0,0,'S',0);{*TR*}
      Interf(3,0,0,0,'0.1',0);
      Interf(4,0,0,0,'10',0);
      scelta:=11;
      Esegui_com(scelta);
      end;
    annulla;
    end;
end;
end;
Procedure  TMyWindow.Menu_com(Opzione:integer);
begin
Menu(opzione);
end;
(*
{----------------------------------------------------------------------------}
Procedure TMYwindow.WMMenuSelect(var Msg: TMessage);
var i,a:Integer;
begin
{messagebeep(Mb_iconExclamation);}
for i:=1 to 10000 do a:=round(i/i);
{if (msg.LParamLo And MF_popup)=0  then messagebeep(10);}
if msg.LParamLo <>-1  then
if (msg.LParamLo And MF_popup)=0  then
if (msg.LParamLo And MF_SysMenu)=0 then
if (msg.LParamLo And MF_MouseSElect)<>0  then
  begin
  {messagebeep(10);}
    Case Msg.WParam of
    Dis_dim,Dis_nodi,dis_unif,M_osnap:
        begin
        if (msg.LParamLo And MF_Checked)=0  then
        CheCkMenuItem(msg.LParamHi,Msg.WParam,Mf_cheCked)
        else CheCkMenuItem(msg.LParamHi,Msg.WParam,Mf_UncheCked)
        end;
    end;
    Case Msg.WParam of
    M_osnap:
        begin           { Osnap }
        CancCur;
        C_osnap:=Not C_osnap;
        if (NumCom=Tronco_dal)and(Fase=2) then
          begin
          if C_osnap then Cod_cur:=3
          else
            begin
            if vuoto then Cod_cur:=11 else cod_cur:=5 ;
            end;
          end;
        end;
    else Menu(Msg.WParam);
    end;
  end;
end;
*)
{----------------------------------------------------------------------------}
procedure TChWindow.WMRButtonDown(var Msg: TMessage);
begin
if NumCom<>0 then Annulla else
begin
if ult_com<>0 then Menu(ult_com);
end;
end;
{----------------------------------------------------------------------------}
procedure TChWindow.WMLButtonDown(var Msg: TMessage);
var xpo,ypo:real;
    lnsel:integer;
   {scelta:integer;}

begin
cont:=GetDc(msg.receiver);
ConV_fr(Msg,Xpo,Ypo);
if cod_cur<>0 then Muovi_cu(xpo,ypo,Cod_cur);
Case NumCom of
Tronco_dal:
   case fase of   { Tronco }
    1:begin
      xp:=xpo;
      yp:=ypo;
      Conv_punt(Xpo,Ypo,GetX,GetY);
      if C_osnap then cod_cur:=3 else Cod_Cur:=2;
      Fase:=2;
      end;
    2:begin
      Interf(1,xp,yp,132,'',0);
      Interf(2,xpo,ypo,132,'',0);
      Interf(3,0,0,130,'',0);
      scelta:=4;
      esegui_com(scelta);
      if win_er='' then
        begin
        xp:=xpo;
        yp:=ypo;
        end;
      Conv_Punt(Xpo,Ypo,Getx,Gety);
      retino:=true;
      end;
    end;
Zoom_f:
    Case fase of  { Zoom Finestra }
    1:begin
      xp:=xpo;
      yp:=ypo;
      Cod_Cur:=4;
      Fase:=2;
      end;
    2:begin
      Interf(1,0,0,0,'F',0);
      Interf(2,xp,yp,132,'',0);
      Interf(3,xpo,ypo,132,'',0);
      scelta:=3;
      esegui_com(scelta);
      Annulla;
      end;
    end;
Cancella:
    begin                      { Cancella }
    lnsel:=sel_linea(xpo,ypo);
    if lnsel<>0 then
      begin
      Interf(1,0,0,132,'',lnsel);
      Interf(2,0,0,130,'',0);
      scelta:=8;
      CancCur;
      setrop2(cont,r2_Black);
      esegui_com(scelta);
      setrop2(cont,r2_CopyPen);
      if vuoto then Annulla;
      end
    else errore('Nessun tratto selezionato'); {*TR*}
    end;
end;
CancCur;
releasedc(msg.receiver,cont);
end;

{----------------------------------------------------------------------------}
 procedure TChWindow.Paint(PaintDC: HDC; var PaintInfo: TPaintStruct);
 begin
 Cont:=PaintDc;
 Notcur;
 W_paint;
 end;
{----------------------------------------------------------------------------}
procedure TChWindow.m_cur(var Msg: TMessage);
var xpo,ypo:real;
begin
cont:=GetDc(msg.receiver);
Conv_fr(Msg,Xpo,Ypo);
if cod_cur<>0 then Muovi_cu(xpo,ypo,Cod_cur);
releasedc(msg.receiver,cont);
end;

var miafin:tmyapplication;

begin
miafin.init('DUCT');
miafin.run;
miafin.done;
end.