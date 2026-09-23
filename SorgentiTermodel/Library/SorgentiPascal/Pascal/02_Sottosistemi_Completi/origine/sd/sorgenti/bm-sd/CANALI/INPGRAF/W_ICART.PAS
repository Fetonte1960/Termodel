
Program Icart;

{$R duct.res}


uses owindows,U_WCart,wintypes,Load_D,definiz,bwcc,genproc,Main_pr,main_win,
     graph,def_win,utilitie,defuti,winprocs,u_winput,halotp4,main_res,
     odialogs,Wm,u_inputc,strings;


type
  TCarApplication = object(TMyApplication)
    procedure InitMainWindow; virtual;
    Function Salva_d:boolean;virtual;
    end;
  PCarApplication=^TCarApplication;

  TCarWindow=object(TMyWindow)
    Mw:PWinCart;
    rb:pmioradio;
    constructor Init(AParent: PWindowsObject; ATitle: PChar);
    Procedure Menu_Com(Opzione:integer);Virtual {wm_First +Wm_menuselect};
    procedure setupwindow;virtual;
    procedure posizionares;Virtual;
    procedure Tasti_Par(x,y:integer);
    procedure Tasti_dis(x,y:integer);
    procedure Tasti_edit(x,y:integer);
    Procedure Init_res;Virtual;
    procedure paint(dc:hdc;var paintinfo:tpaintstruct);virtual;
    end;
  PCarWindow=^TCarWindow;
Var PuntCarWindow:PCarWindow;

type
{----------------------------------------------------------------------------}
     pTasti_par=^tTasti_par;
     tTasti_par=object(tdialres)
     Modo_cor:integer;
     Constructor init(aparent:pwindowsobject;aname:pchar;ax,ay:integer);
     Procedure Libero; Virtual Id_First+201;
     Procedure Estremo;Virtual Id_First+202;
     Procedure Perpend;Virtual Id_First+203;
     Procedure Vicino; Virtual Id_First+204;
     end;
{----------------------------------------------------------------------------}

type
{----------------------------------------------------------------------------}
     pTasti_dis=^tTasti_dis;
     tTasti_dis=object(tdialres)
     Constructor init(aparent:pwindowsobject;aname:pchar;ax,ay:integer);
     Procedure amb_r; Virtual Id_First+101;
     Procedure fin_r;Virtual Id_First+102;
     Procedure Por_r;Virtual Id_First+103;
     Procedure pterm_r; Virtual Id_First+104;
     procedure Nord_r; Virtual Id_First+105;
     procedure ncamb_r; Virtual Id_First+106;
     end;
{----------------------------------------------------------------------------}
     pTasti_edit=^tTasti_edit;
     tTasti_Edit=object(tdialres)
     Constructor init(aparent:pwindowsobject;aname:pchar;ax,ay:integer);
     Procedure cancl_r; Virtual Id_First+101;
     Procedure Cancf_r;Virtual Id_First+102;
     Procedure Cancs_r;Virtual Id_First+103;
     Procedure Blocchi_r; Virtual Id_First+104;
     procedure Est_r; Virtual Id_First+105;
     procedure Racc_r; Virtual Id_First+106;
     end;
{----------------------------------------------------------------------------}



procedure TCarApplication.InitMainWindow;
begin
  MainWindow := New(PCarwindow, Init(nil, 'principale'));
end;
{----------------------------------------------------------------------------}
Function TCarApplication.Salva_d:boolean;
begin
  Salva_d:=PuntCarWindow^.mw^.Salva_disegno;
end;
{----------------------------------------------------------------------------}
Procedure  TCarWindow.Menu_com(Opzione:integer);
begin
mw^.menu(opzione);
end;
{----------------------------------------------------------------------------}
constructor TCarWindow.Init(AParent: PWindowsObject; ATitle: PChar);
Var
    H_Max,W_Max:real;
    X_fin1,Y_fin1,x_fin2,y_fin2,risp,L_fin1,L_fin2,H_fin2:integer;
    temp:REAL;
begin
  TMywindow.Init(AParent, ATitle);
  PuntCarWindow:=@self;
  Attr.Menu := LoadMenu(HInstance,'Cart');
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
  {load_win(3,L_fin1+2*risp,1+2*risp+H_fin2,L_fin2);
  new(mw,init(@self,'Finestra di disegno'));}
  Num_win:=0;
  Tot_win:=2;

  FinUnica:=false;
end;


procedure fill_modi2(var pcb:pfill_edit);far;
var nom_p:string;
begin

  nom_p:=DRIVEPROGCART+nomeelencop;

  pcb^.lista_file(2,2,'zone_gr.msk',nom_p+'.zon',
                  40,0,0,30,1,40);
  pcb^.lista_file(3,2,'zone_gr.msk',nom_p+'.zon',
                  40,0,0,30,1,40);
  pcb^.lista_file(4,2,blocdrive+'muri.msk',nom_p+'.mur',
                  1,0,0,40,10,4);
  pcb^.lista_file(5,2,blocdrive+'espos.msk',nom_p+'.esp',
                  1,0,0,30,10,9);
  pcb^.lista_file(6,2,blocdrive+'muri.msk',nom_p+'.mur',
                  1,0,0,40,10,4);
  pcb^.lista_file(7,2,blocdrive+'espos.msk',nom_p+'.esp',
                  1,0,0,30,10,9);
end;

procedure fill_modi1(var pcb:pfill_edit);far;
var nom_p:string;
begin

  nom_p:=DRIVEPROGCART+nomeelencop;

  pcb^.lista_file(1,2,blocdrive+'muri.msk',nom_p+'.mur',
                  1,0,0,40,10,4);
  pcb^.lista_file(2,2,blocdrive+'espos.msk',nom_p+'.esp',
                  1,0,0,30,10,9);
  pcb^.lista_file(3,2,'fin_gr.msk',nom_p+'.fin',
                  20,4,2,40,1,21);
  pcb^.lista_file(7,2,blocdrive+'ponti.msk',nom_p+'.pon',
                  1,0,0,10,10,2);
  pcb^.lista_file(5,2,blocdrive+'porte.msk',nom_p+'.por',
                  1,6,4,10,10,6);
end;


procedure Modi_murifin;far;
begin
if NumCom=edit_simb then
  begin
  Edit_blocchi(Blocco_corr,false,tr_sel);
  end
else
  begin
  getdata:=false;
  setdata:=false;
  nasconditab('modicor1');
  mostratab('modicor');
  end;

end;

procedure Modi_amb;far;
begin
if NumCom=edit_simb then
  begin
  Edit_blocchi(Blocco_corr,false,tr_sel);
  end
else
  begin
  getdata:=false;
  setdata:=false;
  nasconditab('modicor');
  mostratab('modicor1');
  end;
end;

procedure initM_1;
var i:integer;
    nome:st8;
    tm:ttextmetric;
    dc:hdc;
begin
  new(m_1);
  new(m_2);
  with conf^ do
  with m_1^ do
  begin
    col_1:=Rcolore;
    tlin_1:=tlinea;
    TFin_1:=TipoFin;
    Sfin_1:=AreaFin;
    Tporta_1:=TipoPorta;
    Sporta_1:=AreaPorta;
    Tponte_1:=TipoPonte;
    lPonte1:=LunghPonte;
  end;
  with conf^ do
  with m_2^ do
  begin
  Anb_1:=NumeroAMB;
  Allog_1:=Alloggio;
  Zona_1:=Zona;
  Tpav_1:=TipoPav;
  Epav_1:=EspoPav;
  Tsof_1_1:=TipoSof;
  Esof_1:=EspoSof ;
  test_1:=TempEstNC;
  tinv_1:=TempInvNC ;
  end;

end;


{----------------------------------------------------------------------------}
procedure tcarwindow.setupwindow;
var a,cod:integer;
    H_Max,W_Max:real;
    X_fin1,Y_fin1,x_fin2,y_fin2,risp,L_fin1,L_fin2,H_fin2:integer;
    temp:REAL;
begin
inherited setupwindow;
(*  W_max:={640}larg_scheda;
  risp:=2;
  H_max:=W_max*750/1000;
  x_fin1:=risp;
  L_fin1:=round((w_max-risp*3)/3*2);
  L_fin2:=round((w_max-risp*6)/3);
  Temp:=L_fin2;
  H_fin2:=round(temp*750/1000);
  {PosX:=L_fin1+2*risp;
  POsY:=1+2*risp+H_fin2;}*)
end;
{----------------------------------------------------------------------------}
Procedure tcarwindow.Init_res;
Var  stato:word;
begin
  stato:=bf_checked;
  inherited init_res;
  rb^.setcheck(stato);
end;
(*
{----------------------------------------------------------------------------}
Procedure tTasti_par.SettaCur(Modo:integer);
begin
CancWcur;
case modo of
end;*)
{----------------------------------------------------------------------------}
constructor tTasti_par.init(aparent:pwindowsobject;aname:pchar;ax,ay:integer);
begin
  inherited init(aparent,aname,ax,ay);
  NEW(PuntCarWindow^.RB,initresource(@self,216));
end;
{----------------------------------------------------------------------------}
Procedure tTasti_par.Libero;
begin
if Numcom=0 then
  begin
  PuntCarWindow^.menu_com(tronco_dal);
  cod_Cur:=11;
  end
else
  begin
  if numcom=tronco_dal then
    begin
    Canccur;
    if fase=1 then cod_Cur:=11 else cod_Cur:=2;
    end;
  if numcom=tronco_spe then
    begin
    PuntCarWindow^.menu_com(tronco_dal);
    cod_Cur:=11;
    end;
  if numcom In[tronco_spe1,Tronco_perp] then
    begin
    Canccur;
    invMess(w_m(75){'Al punto'});{*TRIT*}
    NumCom:=tronco_dal;
    cod_Cur:=2;
    Fase:=2;
    end;
  end;
end;
{----------------------------------------------------------------------------}
Procedure tTasti_par.Estremo;
begin
if Numcom=0 then
  begin
  PuntCarWindow^.menu_com(tronco_dal);
  cod_Cur:=5;
  end
else
  begin
  if numcom=tronco_dal then
    begin
    Canccur;
    if fase=1 then cod_Cur:=5 else cod_Cur:=19;
    end;
  if numcom=tronco_spe then
    begin
    PuntCarWindow^.menu_com(tronco_dal);
    cod_Cur:=5;
    end;
  if numcom In [tronco_spe1,Tronco_perp] then
    begin
    Canccur;
    invMess(W_m(75){'Al punto'});{*TRIT*}
    NumCom:=tronco_dal;
    cod_Cur:=19;
    Fase:=2;
    end;

  end;
end;
{----------------------------------------------------------------------------}
Procedure tTasti_par.Perpend;
Var fatto:boolean;
begin
Fatto:=false;
if (Numcom=0)or(fase=1) then
  begin
  end
else
  begin
  if numcom In [tronco_dal,Tronco_spe1] then
    begin
    Fatto:=true;
    Canccur;
    invMess(W_m(51){'Selezionare parete'});
    NumCom:=tronco_perp;
    fase:=1;
    cod_Cur:=3;
    end;
  end;
if not fatto then Messagebeep(10);
end;
{----------------------------------------------------------------------------}
Procedure tTasti_par.Vicino;
begin
if Numcom=0 then
  begin
  PuntCarWindow^.menu_com(tronco_Spe);
  end
else
  begin
  if numcom=tronco_dal then
    begin
    Canccur;
    if fase=1 then PuntCarWindow^.menu_com(tronco_Spe)
    else
      begin
      CancCur;
      NumCom:=tronco_spe1;
      invmess(w_m(51){'Selezionare parete'});
      Fase:=1;
      Cod_cur:=3;
      end;
    end;
  end;
end;
{----------------------------------------------------------------------------}

procedure tCarWindow.Tasti_Par(x,y:integer);
var inpcord:pTasti_par;
begin
  inpcord:=new(pTasti_par,init(@self,'snaptro',x,y));
  application^.makewindow(inpcord);
  inpcord^.modo_cor:=0;
  inpcord^.show(sw_show);
end;

{----------------------------------------------------------------------------}

constructor tTasti_dis.init(aparent:pwindowsobject;aname:pchar;ax,ay:integer);
begin
  inherited init(aparent,aname,ax,ay);
end;

{----------------------------------------------------------------------------}
Procedure Ttasti_dis.amb_r;
begin
  PuntCarWindow^.menu_com(Ins_amb);
end;
{----------------------------------------------------------------------------}
{----------------------------------------------------------------------------}
Procedure Ttasti_dis.Fin_r;
begin
  PuntCarWindow^.menu_com(Ins_fin);
end;
{----------------------------------------------------------------------------}

{----------------------------------------------------------------------------}
Procedure Ttasti_dis.por_r;
begin
  PuntCarWindow^.menu_com(Ins_por);
end;
{----------------------------------------------------------------------------}

{----------------------------------------------------------------------------}
Procedure Ttasti_dis.pterm_r;
begin
  PuntCarWindow^.menu_com(Ins_pon);
end;
{----------------------------------------------------------------------------}

{----------------------------------------------------------------------------}
Procedure Ttasti_dis.nord_r;
begin
  PuntCarWindow^.menu_com(Ins_nord);
end;
{----------------------------------------------------------------------------}

{----------------------------------------------------------------------------}
Procedure Ttasti_dis.ncamb_r;
begin
  PuntCarWindow^.menu_com(Ins_ncamb);
end;
{----------------------------------------------------------------------------}


constructor tTasti_edit.init(aparent:pwindowsobject;aname:pchar;ax,ay:integer);
begin
  inherited init(aparent,aname,ax,ay);
end;

{----------------------------------------------------------------------------}
Procedure Ttasti_edit.cancf_r;
begin
  PuntCarWindow^.menu_com(canc_fin);
end;
{----------------------------------------------------------------------------}
Procedure Ttasti_edit.cancl_r;
begin
  PuntCarWindow^.menu_com(cancella);
end;

{----------------------------------------------------------------------------}
Procedure Ttasti_edit.cancs_r;
begin
  PuntCarWindow^.menu_com(canc_simb);
end;

{----------------------------------------------------------------------------}
Procedure Ttasti_edit.blocchi_r;
begin
  PuntCarWindow^.menu_com(edit_simb);
end;

{----------------------------------------------------------------------------}
Procedure Ttasti_edit.est_r;
begin
  PuntCarWindow^.menu_com(edit_est);
end;


{----------------------------------------------------------------------------}
Procedure Ttasti_edit.racc_r;
begin
  PuntCarWindow^.menu_com(edit_rac);
end;


procedure tCarWindow.Tasti_Dis(x,y:integer);
var inpcord:pTasti_dis;
begin
  inpcord:=new(pTasti_dis,init(@self,'menudis',x,y));
  application^.makewindow(inpcord);
  inpcord^.show(sw_show);
end;

procedure tCarWindow.Tasti_edit(x,y:integer);
var inpcord:pTasti_edit;
begin
  inpcord:=new(pTasti_edit,init(@self,'menuedit',x,y));
  application^.makewindow(inpcord);
  inpcord^.show(sw_show);
end;

procedure tcarwindow.paint(dc:hdc;var paintinfo:tpaintstruct);
var adc:hdc;ps:tpaintstruct;
begin
  twindow.paint(dc,paintinfo);
  {dc:=getdc(mytool^.hwindow);
  mytool^.paint(dc,ps);
  releasedc(mytool^.hwindow,dc);}
end;



procedure tcarwindow.posizionares;
var msg:tmessage;
    te,as:real;
    r,r1:trect;
    tm:ttextmetric;
    dc:hdc;
    H_Max,W_Max:real;
    X_fin1,Y_fin1,x_fin2,y_fin2,risp,L_fin1,L_fin2,H_fin2:integer;
    temp:REAL;
    ps:tpaintstruct;
begin
n_res:=1;
with el_res[n_res] do
begin
  x:=1;
  cod:=cost_mess;
  andle:=messaggio^.hwindow;
  as:=alt_scheda;
  getwindowrect(hwindow,r);
  getclientrect(hwindow,r1);
  te:=(r.bottom-r.top)-r1.bottom;
  dc:=getdc(messaggio^.hwindow);
  gettextmetrics(dc,tm);
  releasedc(messaggio^.hwindow,dc);
  y:=alt_scheda-(tm.tmheight+round(te)-7);
  h:=tm.tmHeight;
  w:=larg_scheda-1;
  movewindow(messaggio^.hwindow,x,y,w,h,false);
  {te:=te+tm.tmHeight-3;}

end;
n_res:=2;
with el_res[n_res] do
begin
  x:=2;
  cod:=cost_coord;
  coordinate(x,y);
end;

n_res:=3;
with el_res[n_res] do
begin
  cod:=cost_dist;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  dist_ang(x,y);;
end;

n_res:=4;
with el_res[n_res] do
begin
  cod:=cost_tasti;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  tasti_par(x,y);;
end;

n_res:=5;
with el_res[n_res] do
begin
  cod:=cost_zoom;
  x:=el_res[n_res-1].x+el_res[n_res-1].w;
  Set_Zoom(x,y);
end;


n_res:=n_res+1;
with el_res[n_res] do
begin
  risp:=2;
  temp:=el_res[1].y-el_res[n_res-1].h-3;
  as:=temp*1000/750;
  l_Fin1:=round(as);
  l_fin2:=larg_scheda-l_fin1-risp*3;
  Load_win(1,risp,risp,L_fin1);
  load_win(2,L_fin1+2*risp,risp,L_fin2);
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
end;
posx:=el_win[1].w_win+3*risp;
posy:=el_win[2].h_win+3*risp;
initm_1;
n_res:=n_res+1;
with el_res[n_res] do
begin
  nresource:=n_res;
  cod:=cost_dial1;
  if (el_res[1].h > 16) or (alt_scheda<767)  then nome:='MODICOR' else nome:='M1024';
  x:=posx;
  y:=posy;
  procarr[1]:=modi_amb;
  procarr[2]:=modi_murifin;
  posres:=true;
  w_usamaskera(m_1^,nome+'.msk',procarr,false,cod,fill_modi1);
  end;
n_res:=n_res+1;
with el_res[n_res] do
begin
  nresource:=n_res;
  cod:=cost_dial2;
  if (el_res[1].h > 16) or (alt_scheda<767) then nome:='MODICOR1'
  else
  begin
    nome:='M10241';
    dueres:=true;
  end;
  x:=posx;
  y:=posy;
  posres:=true;
  procarr[1]:=modi_amb;
  procarr[2]:=modi_murifin;
  w_usamaskera(m_2^,nome+'.msk',procarr,false,cod,fill_modi2);
  end;

if larg_scheda >799 then
begin
  n_res:=n_res+1;
  if not dueres then
  begin
    movewindow(mytool^.hwindow,el_res[5].x+el_res[5].w,
               el_res[5].y,larg_scheda-(el_res[5].x+el_res[5].w),el_res[5].h,true);
    with mytool^.attr do
    begin
      w:=larg_scheda-(el_res[5].x+el_res[5].w);
      h:=el_res[5].h;
    end;
  end
  else
  begin
    movewindow(mytool^.hwindow,el_res[5].x+el_res[5].w,
               el_res[5].y,el_res[n_res-1].x-risp-(el_res[5].x+el_res[5].w),el_res[5].h,true);
    with mytool^.attr do
    begin
      w:=el_res[n_res-1].x-risp-(el_res[5].x+el_res[5].w);
      h:=el_res[5].h;
    end;
  end;
  mytool^.switchto('toolbar_2');
end;

nresource:=n_res;

end;
{----------------------------------------------------------------------------}
var miafin:tCarapplication;
  nomep:string[80];
  nomepc:array[0..80] of char;
  ep:boolean;
  R:TRECT;
begin
  caricanomeprogetto(ep);
  nomep:='MC4 Software: Input strutture ( '+nomeprog+' )';
  strpcopy(nomepc,nomep);
  hd:=findwindow('TurboWindow',nomepc);
  if hd=0 then
  begin
    @Win31LockWindowUpdate :=
    GetProcAddress(GetModuleHandle('User'), PChar(294));
    VISBIT(r,'INPBIT');
    miafin.init('CART');
    showwindow(pmainwin^.hwindow,sw_Showmaximized);
    miafin.run;
    miafin.done;
  end
  else setactivewindow(hd);
end.