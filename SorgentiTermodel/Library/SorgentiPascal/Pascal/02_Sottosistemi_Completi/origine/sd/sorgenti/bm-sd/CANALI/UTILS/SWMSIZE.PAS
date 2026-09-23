procedure tcarwindow.wmsize(var msg:owindows.tmessage);
var
    te,a_s:real;
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
cambiadir(get_drive+'\graphinp');
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
  andle:=main_res.messaggio^.hwindow;
  a_s:=alt_scheda;
  getwindowrect(hwindow,r);
  getclientrect(hwindow,r1);
  te:=(r.bottom-r.top)-r1.bottom;
  dc:=getdc(main_res.messaggio^.hwindow);
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
  releasedc(main_res.messaggio^.hwindow,dc);
  y:=alt_scheda-(tm.tmheight);
  h:=tm.tmHeight;
  w:=larg_scheda-1;
  movewindow(main_res.messaggio^.hwindow,x,y+1,w,h,false);
  {te:=te+tm.tmHeight-3;}
  with fonte do
  begin
  lfHeight:=-50;
  lfWeight:=Fw_extralight;
  LfPitchAndFamily:=Variable_Pitch or FF_roman;
  StrCopy(@lfFaceName,'Times new roman');
  end;
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
  dist_ang(x,y,1);;
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
  a_s:=temp*1000/750;
  if a_s > larg_scheda-220 then a_s:=larg_scheda-220;
  l_Fin1:=round(a_s);
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
  el_win[2].active:=false;
  movewindow(andle,x,y,w,h,false);
end;
posx:=el_win[1].w_win+3*risp;
posy:=el_win[2].h_win+3*risp;
initm_1;
n_res:=n_res+1;

{if alt_scheda-el_win[2].h_win >2*260}
if (r1.bottom-(el_win[2].h_win+el_res[1].h))>=2*260 then dueres:=true else dueres:=false;

if dueres then
begin
with el_res[n_res] do
begin
  nresource:=n_res;
  cod:=cost_dial1;
  {$ifdef scanplus}
  el_res[n_res].nome:='M1024S';
  procarr[27]:=okmuri;
  {$else}
  el_res[n_res].nome:='M1024';
  {$endif}
  x:=posx;
  y:=posy;
  procarr[1]:=modi_amb;
  procarr[2]:=modi_murifin;
  tab_testo:=false;
  w_usamaskera(m_1^,el_res[n_res].nome+'.msk',procarr,false,cod,fill_modi1,nil);
  dialogo:=tabellacorrente^[a_w].dialog;
  n_res:=n_res+1;
  {$ifdef scanplus}
  el_res[n_res].nome:='M10241S';
  {$else}
  el_res[n_res].nome:='M10241';
  {$endif}
  posx:=el_win[1].w_win+3*risp;
  posy:=el_win[2].h_win+260+3*risp;
  nresource:=n_res;
  cod:=cost_dial2;
  el_res[n_res].x:=posx;
  el_res[n_res].y:=posy;
  posres:=true;
  procarr[1]:=modi_amb;
  procarr[2]:=modi_murifin;
  tab_testo:=false;
  w_usamaskera(m_2^,el_res[n_res].nome+'.msk',procarr,false,cod,fill_modi2,nil);
  el_res[n_res].dialogo:=tabellacorrente^[a_w].dialog;
end
end
else
{if not dueres then}
with el_res[n_res] do
begin
  nresource:=n_res;
  cod:=cost_dial1;
  {$ifdef scanplus}
  el_res[n_res].nome:='MODICORS';
  {$else}
  el_res[n_res].nome:='MODICOR';
  {$endif}
  posx:=el_win[1].w_win+3*risp;
  posy:=el_win[2].h_win+3*risp;
  x:=posx;
  y:=posy;
  procarr[1]:=modi_amb;
  procarr[2]:=modi_murifin;
  {$ifdef scanplus}
  procarr[23]:=okmuri;
  {$endif}
  dueres:=false;
  tab_testo:=false;
  w_usamaskera(m_1^,el_res[n_res].nome+'.msk',procarr,false,cod,fill_modi1,nil);
  dialogo:=tabellacorrente^[a_w].dialog;
  n_res:=n_res+1;
   {$ifdef scanplus}
  el_res[n_res].nome:='MODICOS';
  {$else}
  el_res[n_res].nome:='MODICOR1';
  {$endif}
  posx:=el_win[1].w_win+3*risp;
  posy:=el_win[2].h_win+3*risp;
  nresource:=n_res;
  cod:=cost_dial2;
  el_res[n_res].x:=posx;
  el_res[n_res].y:=posy;
  posres:=true;
  procarr[1]:=modi_amb;
  procarr[2]:=modi_murifin;
  tab_testo:=false;
  w_usamaskera(m_2^,el_res[n_res].nome+'.msk',procarr,false,cod,fill_modi2,nil);
  el_res[n_res].dialogo:=tabellacorrente^[a_w].dialog;
end;

(*
n_res:=n_res+1;
with el_res[n_res] do
begin
  if dueres then
  begin
    {$ifdef scanplus}
    el_res[n_res].nome:='M10241S';
    {$else}
    el_res[n_res].nome:='M10241';
    {$endif}
    posx:=el_win[1].w_win+3*risp;
    posy:=el_res[n_res-1].y+risp+el_res[n_res-1].h;
  end
  else
  {$ifdef scanplus}
  el_res[n_res].nome:='MODICOS';
  {$else}
  el_res[n_res].nome:='MODICOR1';
  {$endif}

  posx:=el_win[1].w_win+3*risp;
  posy:=el_win[2].h_win+3*risp;
  nresource:=n_res;
  cod:=cost_dial2;
  x:=posx;
  y:=posy;
  posres:=true;
  procarr[1]:=modi_amb;
  procarr[2]:=modi_murifin;
  tab_testo:=false;
  w_usamaskera(m_2^,el_res[n_res].nome+'.msk',procarr,false,cod,fill_modi2,nil);
end;

*)
if alt_scheda>480 then
begin
  mytool:=new(ptoolbar,init(@self,'toolbar_2',0,0,0,0,tbtools));
  application^.makewindow(mytool);
  n_res:=n_res+1;
  if not dueres then
  begin
    with el_res[n_res] do
    begin
      x:=el_res[5].x+el_res[5].w;
      y:=el_res[5].y;
      w:=larg_scheda-(el_res[5].x+el_res[5].w);
      h:=el_res[5].h;
      movewindow(mytool^.hwindow,x,y,w,h,true);
      mytool^.attr.w:=w;
      mytool^.attr.h:=h;
    end;
  end
  else
  begin
    with el_res[n_res] do
    begin
      x:=el_res[5].x+el_res[5].w;
      y:=el_res[5].y;
      w:=el_res[n_res-1].x-risp-(el_res[5].x+el_res[5].w);
      h:=el_res[2].H;
      movewindow(mytool^.hwindow,x,y,w,h,true);
      with mytool^.attr do
      begin
        mytool^.attr.w:=w;
        mytool^.attr.h:=h;
      end;
    end;
  end;
  mytool^.switchto('toolbar_2');
  mytool^.show(sw_show);
end;
init_res;
nresource:=n_res;
restoredir;
inherited wmsize(msg);

end;

