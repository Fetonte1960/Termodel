
Program w_inputc;

{$ifdef francia}
{$R duct-fr.RES}

{$endif}

{$ifdef inglese}
{$R ducteng.RES}
{$R gducteng.RES}
{$endif}

{$ifdef spagna}
{$R ductesp.RES}
{$R gductesp.RES}
{$endif}

{$ifdef italia}
{$R duct-it.res}
{$R duct.RES}
{$endif}

uses owindows,
  U_Wduct,
  wintypes,
  Load_D,
  definiz,
  bwcc,
  genproc,
  Main_pr,
  main_win,
  graph,
  def_win,
  utilitie,
  defuti,
  winprocs,
  u_winput,
  halotp4,
  main_res,
  prntesto,
  odialogs,
  Wm,
  inputc,
  strings,
  load_p,
  inituti,
  gruti,
  toolbar,
  gestduct,
  prgduct {$ifdef delphi},
  messages {$else},
  win31 {$endif}
  {$IFDEF NEWCR},
  Minicalc
  {$endif};


type
  TDuctApplication = object(TMyApplication)
    procedure InitMainWindow; virtual;
    Function Salva_d:boolean;virtual;
    end;
  PDuctApplication=^TDuctApplication;

  TDuctWindow=object(TMyWindow)
    Mw:PWindutu;
    rb:pmioradio;
    constructor Init(AParent: PWindowsObject; ATitle: PChar);
    Procedure Menu_Com(Opzione:integer);Virtual ;
    procedure setupwindow;virtual;
    procedure wmsize(var msg:owindows.tmessage);Virtual wm_first+wm_size;
    Procedure Init_res;Virtual;
    procedure paint(dc:hdc;var paintinfo:tpaintstruct);virtual;
    procedure Disdim(var msg:Tmessage);virtual cm_first +10009;
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

    procedure archprg(var Msg: TMessage); virtual cm_First+ 10001;
    procedure Misure(var Msg: TMessage);virtual cm_First + 10002;
    procedure Costanti(var Msg: TMessage);virtual cm_First + 10003;
    procedure RIDUZ(var Msg: TMessage);virtual cm_First + 10004;
    procedure PEZZI(var Msg: TMessage);virtual cm_First + 10005;
    Procedure DatiGen(var msg:Tmessage);virtual cm_first +10006;
    Procedure DatiErr(var msg:Tmessage);virtual cm_first +10007;

    Procedure ElencoPiante(var msg:Tmessage);virtual cm_first +10010;
    Procedure ElencoSezioni(var msg:Tmessage);virtual cm_first +10011;
    procedure computoMetrico(var msg:Tmessage);virtual cm_first +10028;
    procedure w_cum(var msg:Tmessage);virtual cm_first +10033;
    procedure stampe(var msg:Tmessage);virtual cm_first +10027;
    procedure ese_stam(var Msg: TMessage);virtual cm_first + 10031;
    Procedure STAMPERTF(var msg:Tmessage);virtual cm_first +501;
    procedure eseguicalcolo;
    procedure eseguicword;Virtual cm_first +502;
    procedure eseguicword1;Virtual cm_first +503;
    procedure eseguiimpianti;Virtual cm_first +504;
    end;
  PDuctWindow=^TDuctWindow;
Var PuntDuctWindow:PDuctWindow;

{procedure usaforma;external 'arkpzz';}

procedure TDuctApplication.InitMainWindow;
begin
  MainWindow := New(PDuctwindow, Init(nil, 'principale'));
end;
{----------------------------------------------------------------------------}
Function TDuctApplication.Salva_d:boolean;
begin
  Salva_d:=PuntDuctWindow^.mw^.Salva_disegno;
end;
{----------------------------------------------------------------------------}
Procedure  TDuctWindow.Menu_com(Opzione:integer);
begin
mw^.menu(opzione);
end;
{----------------------------------------------------------------------------}
constructor TDuctWindow.Init(AParent: PWindowsObject; ATitle: PChar);
Var
    H_Max,W_Max:real;
    X_fin1,Y_fin1,x_fin2,y_fin2,risp,L_fin1,L_fin2,H_fin2:integer;
    temp:REAL;
begin
  TMywindow.Init(AParent, ATitle);
  PuntDuctWindow:=@self;
  Attr.Menu := winprocs.LoadMenu(HInstance,'Duct');
  W_max:={640}Larg_scheda;
  risp:=2;
  H_max:=W_max*750/1000;
  x_fin1:=risp;
  L_fin1:=round((w_max-risp*3)/3*2);
  L_fin2:=round((w_max-risp*6)/3);
  Temp:=L_fin2;
  H_fin2:=round(temp*750/1000);
  Load_win(1,risp,risp,L_fin1);
  new(mw,init(@self,'Finestra di disegno'));
  load_win(2,L_fin1+2*risp,risp,L_fin2);
  new(mw,init(@self,'Finestra di disegno'));

  load_win(3,L_fin1+2*risp,1+2*risp+H_fin2,L_fin2);
  new(mw,init(@self,'Finestra di disegno'));

{  if alt_scheda >599 then
  begin
    load_win(4,L_fin1+2*risp,1+2*risp+H_fin2,L_fin2);
    new(mw,init(@self,'Finestra di disegno'));
    tot_win:=4;
  end
  else }
  Tot_win:=3;

  Num_win:=0;
  FinUnica:=false;
  STAMPE_WORD:=TRUE;
  new(cati);
  fillchar(cati^,sizeof(cati^),0);

end;


{----------------------------------------------------------------------------}
procedure tDuctwindow.setupwindow;
begin
nomeprogetto:=w_mw(125){'- Mc4 Software - DUCT:Input grafico ( '}+nomeprog+' )';
inherited setupwindow;
if risultcalc^.disdimens then CheckMenuItem(pmainwin^.attr.menu,dis_dim,mf_checked)
else CheckMenuItem(pmainwin^.attr.menu,dis_dim,mf_unchecked);
if risultcalc^.disunif then CheckMenuItem(pmainwin^.attr.menu,dis_unif,mf_checked)
else CheckMenuItem(pmainwin^.attr.menu,dis_unif,mf_unchecked);
if risultcalc^.nodi then CheckMenuItem(pmainwin^.attr.menu,dis_nodi,mf_checked)
else CheckMenuItem(pmainwin^.attr.menu,dis_nodi,mf_unchecked);
if nomeprog='' then
postmessage(hwindow,wm_command,10001,0);
end;
{----------------------------------------------------------------------------}
Procedure tDuctwindow.Init_res;
Var  stato:word;
begin
  stato:=bf_checked;

  inherited init_res;
  {rb^.setcheck(stato);}
  if exist(driveprog+nomeprog+'.con') then
   begin
   assign(fconf,driveprog+nomeprog+'.con');
   reset(fconf);
   read(fconf,conf^);
   close(fconf);
   end
else conf^.rcolore:=1;
but_attivo[conf^.rcolore]^.setcheck(1);

end;

procedure tDuctwindow.paint(dc:hdc;var paintinfo:tpaintstruct);
var adc:hdc;ps:tpaintstruct;
begin
  twindow.paint(dc,paintinfo);
end;



procedure tductwindow.wmsize(var msg:owindows.tmessage);
var
    te,A_S:real;
    r,r1:trect;
    tm:ttextmetric;
    dc:hdc;
    H_Max,W_Max:real;
    X_fin1,Y_fin1,x_fin2,y_fin2,risp,L_fin1,L_fin2,H_fin2,i:integer;
    temp,xvista,yvista,orz,xvista_e,yvista_e,asez:REAL;
    ps:tpaintstruct;
    font:hfont;
    eccesso,alt_client:integer;
    P:TPOINT;
var filo,inpcord,viscord,snap,osnap,fin3,t_dial:pdialog;
begin
if nresource>0 then
begin
  for i:=1 to nresource do
  with el_res[i] do
  begin
    if dialogo<>nil then
    begin
      a_w:=0;
      st_8:=nome;
      if st_8>'' then a_w:=numerotabella(st_8,hd,2);
      if a_w>0 then
      with tabellacorrente^[a_w] do
      begin
        dialogo^.done;
        tabellacorrente^[a_w].nome:='';
        maniglia:=0;
        dialogo:=nil;
      end
      else
      begin
        dialogo^.done;
        dialogo:=nil;
      end;
    end;
  end;
  if mytool<>nil then
  begin
    mytool^.done;
    mytool:=nil;
  end;
  dueres:=false;
end;
larg_scheda:=loword(msg.lparam);
alt_scheda:=hiword(msg.lparam);
n_res:=1;
with el_res[n_res] do
begin
  x:=1;
  cod:=cost_mess;
  andle:=messaggio^.hwindow;
  A_S:=alt_scheda;
  getwindowrect(hwindow,r);
  getclientrect(hwindow,r1);
  te:=(r.bottom-r.top)-r1.bottom;
  dc:=getdc(messaggio^.hwindow);
  with fonte do
  begin
  lfHeight:=-10;
  lfWeight:=Fw_extrabold;
  LfPitchAndFamily:=Variable_Pitch or FF_SWISS;
  StrCopy(@lfFaceName,'Helv');
  end;
  font:=CreateFontIndirect(Fonte);
  sendmessage(andle,wm_setfont,font,0);
  gettextmetrics(dc,tm);
  releasedc(messaggio^.hwindow,dc);
  y:=alt_scheda-(tm.tmheight);
  h:=tm.tmHeight;
  w:=larg_scheda-1;
  movewindow(messaggio^.hwindow,x,y+1,w,h,false);

  with fonte do
  begin
  lfHeight:=-50;
  lfWeight:=Fw_extralight;
  LfPitchAndFamily:=Variable_Pitch or FF_roman;
  StrCopy(@lfFaceName,'Times new roman');
  end;

end;
n_res:=n_res+1;
with el_res[n_res] do
begin
  x:=2;
  cod:=cost_coord;
  coordinate(x,y);
end;

n_res:=n_res+1;
with el_res[n_res] do
begin
  cod:=cost_dist;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  dist_ang(x,y,0);;
end;

n_res:=n_res+1;
with el_res[n_res] do
begin
  cod:=Cost_filo;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;

  filo:=new(pdialfilo,init(@self,'filo1',x,y));
  application^.makewindow(filo);
  filo^.show(sw_show);
end;
{
n_res:=n_res+1;
with el_res[n_res] do
begin
  cod:=Cost_snap;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  snap:=new(pdialsnap,init(@self,'snap',x,y));
  application^.makewindow(snap);
  snap^.show(sw_show);
end;
}
n_res:=n_res+1;
with el_res[n_res] do
begin
  cod:=Cost_osnap;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  osnap:=new(pdialosnap,init(@self,'osnapd',x,y));
  application^.makewindow(osnap);
  osnap^.show(sw_show);
end;
{
n_res:=n_res+1;
with el_res[n_res] do
begin
  cod:=cost_zoom;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  Set_Zoom(x,y);
end;
}
n_res:=n_res+1;
with el_res[n_res] do
begin
  cod:=Cost_sez;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  fin3:=new(pdialfin3,init(@self,'fin3',x,y));
  application^.makewindow(fin3);
  fin3^.show(sw_show);
end;
n_res:=n_res+1;
with el_res[n_res] do
begin
  cod:=Cost_pezzo;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  fin3:=new(pdialepezzi,init(@self,'editpezzo',x,y));
  application^.makewindow(fin3);
  fin3^.show(sw_show);
end;

n_res:=n_res+1;
with el_res[n_res] do
begin
  risp:=2;
  temp:=el_res[1].y-el_res[n_res-1].h-2*risp;
  A_S:=temp*1000/750;
  l_Fin1:=round(A_S);
  l_fin2:=larg_scheda-l_fin1-risp*3;
  save_win(1);
  Load_win(1,risp,risp,L_fin1);
  save_win(2);
  load_win(2,L_fin1+2*risp,risp,L_fin2);
  if el_win[2].h_win>el_win[1].h_win  div 2 then
  begin
    l_fin2:=(l_fin1-risp) div 2;
    save_win(2);
    load_win(2,L_fin1+2*risp,risp,L_fin2);
  end;
  load_win(3,L_fin1+2*risp,el_win[2].y_ang+el_win[2].h_win+risp,L_fin2);
  eccesso:=0;
  (*eccesso:=(alt_scheda-el_res[2].h)-(el_win[2].h_win+el_win[3].h_win+el_res[1].h+2*risp+39);*)
  if eccesso<0 then
  begin
    l_fin2:=l_fin2+eccesso-1;
    save_win(2);
    load_win(2,L_fin1+2*risp,risp,L_fin2);
    save_win(3);
    load_win(3,L_fin1+2*risp,el_win[2].y_ang+el_win[2].h_win+risp,L_fin2);
  end;
  cod:=cost_mw1;
  x:=el_win[1].x_ang;
  y:=el_win[1].y_ang;
  h:=el_win[1].h_win;
  w:=el_win[1].w_win;
  andle:=el_win[1].andle;
  movewindow(andle,x,y,w,h,false);
end;

n_res:=n_res+1;
with el_res[n_res] do
begin
  andle:=el_win[2].andle;
  cod:=cost_mw2;
  x:=el_win[2].x_ang;
  y:=el_win[2].y_ang;
  h:=el_win[2].h_win;
  w:=el_win[2].w_win;
  movewindow(andle,x,y,w,h,false);
  el_win[2].active:=false;
end;
n_res:=n_res+1;
with el_res[n_res] do
begin
  andle:=el_win[3].andle;
  cod:=cost_mw3;
  x:=el_win[3].x_ang;

  if alt_scheda > 480 then
  y:=el_win[2].h_win+3*risp
  else y:=el_res[2].y-el_win[3].h_win-2*risp;
  y:=el_win[3].y_ang;
  h:=el_win[3].h_win;
  w:=el_win[3].w_win;
  el_win[3].active:=false;
  movewindow(andle,x,y,w,h,false);
end;

if alt_scheda >480 then
begin
  mytool:=new(ptoolbar,init(@self,'toolbar_2',0,0,0,0,tbtools));
  application^.makewindow(mytool);
  dueres:=true;
  n_res:=n_res+1;
  with el_res[n_res] do
  begin
    initproc;
    x:=el_win[1].w_win+3*risp;
    y:=el_res[n_res-2].h+el_res[n_res-2].y+2*risp;
    posx:=x;
    posy:=y;
    nresource:=n_res;
    cod:=cost_dial1;
    if UnMis=1 then NomeMskw:='dd1024s' else NomeMskw:='dd1024';
    nome:=NomeMskw;
    dueres:=true;
    procarr[1]:=copia2;
    procarr[26]:=drawbit;
    tab_testo:=false;

    w_iotabella(CATI^,NumPezzi+1,1,11,nomemskw+'.msk',false,procarr,false,cod,fill_listagen,nil);
  end;
  if dueres then n_res:=n_res+1;
  with el_res[n_res] do
  begin
    if dueres then
    begin
      x:=el_res[n_res-5].x+el_res[n_res-5].w;
      y:=el_res[2].y;
      h:=el_res[2].H;
      w:=round((larg_scheda-(el_res[n_res-5].w+el_res[n_res-5].x))-5);
    end
    else
    begin
      x:=el_res[n_res-1].x;
      y:=el_res[n_res-1].y+el_res[n_res-1].h+2*risp;
      w:=el_res[n_res-1].w;
      h:=el_win[1].h_win-(el_res[n_res-1].y+el_res[n_res-1].h)
    end;
    movewindow(mytool^.hwindow,x,y,w,h,true);
    with mytool^.attr do
    begin
      y:=el_res[n_res].y;
      x:=el_res[n_res].x;
      w:=el_res[n_res].w;
      h:=el_res[n_res].h;
    end;
  end;
  mytool^.switchto('toolbar_4');
  mytool^.show(sw_show);
end;

init_Res;
nresource:=n_res;
inherited wmsize(msg)

end;


procedure tductwindow.eseguicalcolo;
var ftext:text;
    buf:pchar;
    st:string;
    nt:integer;
    pc:array[0..200] of char;
begin
  CHDIR(get_drive+'\CCA\INPGRAF');
  pdw^.salva_dis;
  CHDIR(get_drive+'\CCA');
  assign(ftext,'prog.can');
  rewrite(ftext);
  write(ftext,NomeProg);
  close(ftext);

  buf:=@pc;
  getwindowtext(hwindow,buf,200);

  assign(ftext,'wintxt.dat');
  rewrite(ftext);
  st:=strpas(buf);
  write(ftext,st);
  close(ftext);
  if stampe_word then winexec('w_calc.exe pr',sw_showmaximized)
  else
  winexec('w_calc.exe',sw_showmaximized);
  CHDIR(get_drive+'\CCA\INPGRAF');
end;


procedure tductwindow.disdim(var Msg: TMessage);
VAR FTEXT:TEXT;
    st:string[200];
    pc:array[0..200] of char;
    buf:pchar;

begin
  {CHDIR('C:\MC4-L10\CCA');
  assign(ftext,'Dimen.sce');
  rewrite(ftext);
  write(ftext,' ');
  close(ftext);
  }


  buf:=@pc;
  getwindowtext(hwindow,buf,200);
  assign(ftext,'wintxt.dat');
  rewrite(ftext);
  st:=strpas(buf);
  write(ftext,st);
  close(ftext);

  st:=get_drive+'\CCA\INPGRAF\w_dimens.exe';
  strpcopy(pc,st);
  winexec(pc,sw_showmaximized);
  {CHDIR('C:\MC4-L10\CCA\INPGRAF');}
end;

Function ChiaveDiCalcolo(calc : integer) : integer;
 begin
    CASE Calc OF
          { MANDATA }
       51 : ChiaveDiCalcolo := 1;{predim. a perdita x attrito cost}
       52 : ChiaveDiCalcolo := 2;{Calc.+Bilanc. con serrande sui rami}
       53 : ChiaveDiCalcolo := 3;{Calc.+Bilanc. con serrande sui Term}
       54 : ChiaveDiCalcolo := 4;{Calc.+Bilanc. senza serrande}
       55 : ChiaveDiCalcolo := 5;{verif.di impianto esistente}
       56 : ChiaveDiCalcolo := 6;{Bilanc.con serrande sui rami}
       57 : ChiaveDiCalcolo := 7;{Bilanc.con serrande sui Term}
       58 : ChiaveDiCalcolo := 8;{Eliminazione serrande di taratura}

          { RIPRESA }
       61 : ChiaveDiCalcolo := 1;{predim. a perdita x attrito cost}
       62 : ChiaveDiCalcolo := 2;{Calc.+Bilanc. con serrande sui rami}
       63 : ChiaveDiCalcolo := 3;{Calc.+Bilanc. con serrande sui Term}
       64 : ChiaveDiCalcolo := 4;{Calc.+Bilanc. senza serrande}
       65 : ChiaveDiCalcolo := 5;{veloc.cost. e bilanc. della rete}
       66 : ChiaveDiCalcolo := 6;{verif.di una rete esistente}
       67 : ChiaveDiCalcolo := 7;{Bilanc.con serrande sui rami}
       68 : ChiaveDiCalcolo := 8;{Bilanc.con serrande sui Term}
       69 : ChiaveDiCalcolo := 9;{Eliminazione serrande di taratura}

    END;

end;

(*
procedure gestprg(scelta:integer);
var colleg:integer;
    fint:file of integer;
begin
case scelta of
51..58  :begin   { .. CALCOLO MANDATA --> collegato a canali.com .. }
                 Colleg:= 7; {mandata --> canali.com}
                 CHDIR(get_drive+'\CCA');
                 assign(fInt,'calc.sce'); {'\cca'}
                 rewrite(fInt);
                 write(fInt,Colleg);
                 close(fInt);

                 Colleg:=ChiaveDiCalcolo(Scelta);
                 assign(fInt,'calc1.sce'); {'\cca'}
                 rewrite(fInt);
                 write(fInt,Colleg);
                 close(fInt);
            end;

 61..69  :begin   { .. CALCOLO RIPRESA --> collegato a canali.com .. }
                 Colleg:= 8; {ripresa --> canali.com}
                 CHDIR(get_drive+'\CCA');
                 assign(fInt,'calc.sce'); {'\cca'}
                 rewrite(fInt);
                 write(fInt,Colleg);
                 close(fInt);

                 Colleg:=ChiaveDiCalcolo(Scelta);
                 assign(fInt,'calc1.sce'); {'\cca'}
                 rewrite(fInt);
                 write(fInt,Colleg);
                 close(fInt);
            end;
         end;
end;
 *)
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
  {GESTPRG(25);}
  winexec('editpzz.exe',sw_show);
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

Procedure Tductwindow.STAMPERTF(var msg:Tmessage);
BEGIN
  IF GETMENUSTATE(PMAINWIN^.ATTR.MENU,501,MF_BYCOMMAND)=MF_CHECKED THEN
  BEGIN
    checkmenuitem(PMAINWIN^.ATTR.MENU,501,MF_UNCHECKED);
    STAMPE_WORD:=FALSE;
    ENABLEmenuitem(PMAINWIN^.ATTR.MENU,10031,MF_ENABLED);
  END
  ELSE
  BEGIN
    checkmenuitem(PMAINWIN^.ATTR.MENU,501,MF_CHECKED);
    STAMPE_WORD:=TRUE;
    Enablemenuitem(PMAINWIN^.ATTR.MENU,10031,MF_GRAYED);
  END;
END;

procedure tductwindow.eseguicword;
var st0,st,st01:string[120];
    pc0:array[0..120] of char;

begin
  chdir(get_drive);
  st0:='convword.exe ';
  st:=get_drive+'\cca\word ';;
  st01:=get_drive+'\cca';
  st0:=st0+st+st01;
  strpcopy(pc0,st0);
  winexec(pc0,SW_show);
  chdir(get_drive+'\cca\inpgraf');
end;


procedure tductwindow.eseguicword1;
var st0,st,st01:string[150];
    pc0:array[0..150] of char;

begin
  st0:=get_drive+'\convword.exe ';
  st:=get_drive+'\cca\commet ';;
  st01:=get_drive+'\cca';
  st0:=st0+st+st01;
  strpcopy(pc0,st0);
  winexec(pc0,SW_show);
end;


procedure tductwindow.eseguiimpianti;

(*
var st0,st,st01:string[120];
    pc0:array[0..120] of char;


begin
  minicalcolo;
end;
*)
var f:text;
    pc80,cmp:array[0..80] of char;
    s,cms:string[80];


begin
  cms:=GET_drive+'\impianti\w_prgimp.exe';
  strpcopy(cmp,cms);
  hd:=getmodulehandle(cmp);
  if hd <> 0 then
  begin
    writemessage(get_drive+'\hvac.msg',11);
    exit;
  end;
  cms:=GET_drive+'\impianti\w_prgimp.exe 10006';
  strpcopy(cmp,cms);
  winexec(cmp,SW_show);
end;


procedure tductwindow.ese_stam(var Msg: TMessage);
begin
  gestprg(61);
  setcursor(cur_asp);
  faistampa(get_drive+'\cca');
end;


{----------------------------------------------------------------------------}
var miafin:tDuctapplication;
  nomep:string[80];
  nomepc:array[0..80] of char;
  ep:boolean;
  R:TRECT;
begin
    trcollega:=false;
    @Win31LockWindowUpdate :=
    GetProcAddress(GetModuleHandle('User'), PChar(294));
    {VISBIT(r,'INPBIT');}
    miafin.init('DUCT');
    showwindow(pmainwin^.hwindow,SW_SHOWMAXIMIZED);
    miafin.run;
    miafin.done;

end.
