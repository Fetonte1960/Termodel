unit setta_config_User;

interface
uses windows,sysutils,ComCtrls,libreriagenerale,config_var,forms,ucompilaform,udbt,grafica2D,filedialog,dialogs;
Procedure Init_config_user;
Procedure solo3d;
Procedure FormProprieta(oggetto:string);
Procedure FormCompleta;
Procedure Ultimo(scr:string);
Procedure formridotta(comando:integer);
Procedure FormPannello;
Procedure OpenDebugPJB;
Procedure CloseDebugPJB;
Procedure WDebugPJB(testo:string);


Var TipoUser:(UsBm,UsDiego,UsCad,USSemp,UsL10)=USBM;
     DLLBM:boolean=false;
     Riapri:boolean=true;
     sottoform:boolean=false;
     comando_acad:boolean=false;
     oldpianocor:string;
     Attiva_pannelli:boolean=false;
     Attiva_spirali:boolean=false;
     Estivo_interno:boolean=false;
     Debug_PJB:boolean=false;
     Debug_PJB1:boolean=false;
     ModoPjb:boolean=false;
     Salva_vuoto:boolean=false;
     
Const UsaDll=false;

implementation
uses u3dsd,init_Cad3d;
var oldpost,oldposl,oldw,oldh:integer;
    restoresize:boolean=false;
    Attiva_Reti:boolean=false;
    FdebugPJB:textfile;

Procedure OpenDebugPJB;
begin
If Debug_PJB then
  begin
  Debug_PJB1:=true;
  assign(FdebugPJB,I_sl(percorsodrive)+'Log_pjb.txt');
  rewrite(FdebugPJB);
  end;
end;
Procedure CloseDebugPJB;
begin
If Debug_PJB then  close(FdebugPJB);
Debug_PJB1:=false;
end;
Procedure WDebugPJB(testo:string);
begin
If Debug_PJB1 then  writeln(FdebugPJB,testo);
end;


Procedure Ultimo(scr:string);
begin
copyfile(pchar(percorsodrive+scr+'.scr'),pchar(percorsodrive+'Ultimo.scr'),false);
end;

Procedure solo3d;
begin
form1.groupbox2.height:=38;
form1.Image1.top:=42;
//form1.Image1.enabled:=false;
form1.Panel29.Visible:=false;
form1.menu:=nil;
form1.cbdoppio.Visible:=false;
form1.cbdoppio.checked:=true;
salva_Var('DOPPIO','TRUE');
form1.Button14.Visible:=false;
form1.speedbutton4.Visible:=false;
form1.TabSheet60.TabVisible:=false;
//form1.dbcombobox1.Visible:=false;
form1.Pagecontrol4.Visible:=true;
form1.Pagecontrol24.Visible:=false;
form1.Pagecontrol4.Tabheight:=1;
form1.Pagecontrol4.Tabwidth:=1;
form1.groupbox1.visible:=true;
form1.borderstyle:=bsSizeable;
//form1.Pagecontrol4.enabled:=false;
form1.formstyle:=fsnormal;
form1.tspannello.TabVisible:=false;
//pannello in basso
{
form1.TabSheet2.Visible:=false;
form1.TabSheet3.Visible:=false;
form1.TabSheet18.Visible:=false;
form1.TabSheet20.Visible:=false;
form1.TsCanali.Visible:=false;
}
with form1.pclaterale do
  begin
  tabheight:=1;
  tabwidth:=1;
  ActivePageIndex:=2;//reti
  end;

{
if restoresize then
  begin
  form1.top:=oldpost;
  form1.left:=oldposl;
  form1.width:=oldw;
  form1.height:=oldh;
  restoresize:=false;
  end;
 }
LeggiPOsform;
end;
Procedure formridotta(comando:integer);
Var Lform,hform:integer;
    dimensionabile,dialogo,ridis:boolean;
    ss:string;
begin
doppioclick:=false;
dimensionabile:=false;
dialogo:=true;
ridis:=false;
form1.groupbox2.visible:=true;
form1.groupbox2.height:=38;
form1.Image1.top:=42;
form1.Panel29.Visible:=false;
form1.menu:=nil;
form1.cbdoppio.Visible:=false;
form1.Button14.Visible:=false;
form1.speedbutton4.Visible:=true;
form1.TabSheet60.TabVisible:=false;
form1.Pagecontrol4.Visible:=true;
form1.Pagecontrol24.Visible:=false;
form1.Pagecontrol4.Tabheight:=1;
form1.Pagecontrol4.Tabwidth:=1;
form1.groupbox1.visible:=true;
form1.cbdoppio.checked:=false;
salva_Var('DOPPIO','FALSE');

with form1 do
  begin
  groupbox2.Visible:=false;
  caption:=Data_com[comando].capt;
  formstyle:=fsstayontop;
  case comando of
  com_controlla:
    begin
    caption:=label389.Caption;
    form1.Image1.top:=0;
    height:=600;
    width:=600;
    PageControl4.activepageindex:=1;
    dialogo:=false;
    ridis:=true;
    end;
  com_calcoli,com_Relaz:
    begin
    pagecontrol7.TabHeight:=1;
    pagecontrol7.Tabwidth:=1;
    pagecontrol7.ActivePageIndex:=0;
    borderstyle:=bssizeable;
    menu:=mainmenu1;
    PageControl4.activepageindex:=2;
    File1.Visible:=false;
    Calcoli1.Visible:=false;
    height:=400;
    width:=500;
    dialogo:=false;
    if comando=com_calcoli then
    lbspeedbutton2.Caption:='Esegui calcoli'
    else lbspeedbutton2.Caption:='Crea relazione';
    end;
  com_NuovoProg,com_ApriProg:
    begin
    listaprogetti(listbox2);
    ss:=leggi_var('CARTELLAPROGETTI');
    label395.Caption:=ss;
    if comando=com_NuovoProg then
      begin
      Caption:='Creazione di un nuovo progetto';
      label396.Visible:=true;
      label397.Visible:=true;
      EdNome.Visible:=true;
      lbspeedbutton1.caption:='Crea';
      end
    else
      begin
      Caption:='Apertura di un progetto esistente';
      label396.Visible:=false;
      label397.Visible:=false;
      EdNome.Visible:=False;
      lbspeedbutton1.caption:='Apri';
      end;
    PageControl4.activepageindex:=7;
    height:=400;
    width:=700;
    end;
  com_CambiaElab:
    begin
    groupbox2.Visible:=true;
    pagecontrol4.ActivePageIndex:=1;
    //Pagecontrol24.TabHeight:=0;
    if attiva_reti then
      begin
      //pagecontrol24.Visible:=true;
      //groupbox2.Height:=70;
      //pagecontrol24.Height:=66;
      height:=83;
      width:=450;
      end
    else
      begin
      height:=83;
      width:=220;
      end;
    end;
  com_orient:
    begin
    solonord:=true;
    //form1.groupbox2.height:=38;
    groupbox2.Visible:=true;
    form1.Image1.top:=42;
    Pagecontrol24.visible:=true;
    Pagecontrol24.TabHeight:=1;
    Pagecontrol24.Tabwidth:=1;
    pagecontrol24.ActivePageIndex:=0;
    Pagecontrol24.Top:=0;
    Pagecontrol24.left:=0;
    pagecontrol4.ActivePageIndex:=1;
    height:=200;
    width:=250;
end;
  com_3d:
    begin
    doppioclick:=true;
    borderstyle:=bssizeable;
    dialogo:=false;
    dimensionabile:=true;
    //form1.Menu:=nil;
    form1.pagecontrol4.ActivePageIndex:=0;
    //form1.caption:='Visualizzazione tridimensionale';
    //form1.pagecontrol1.enabled:=False;
    //form1.panel28.enabled:=false;
    //form1.Button14.Visible:=false;
    form1.formstyle:=fsStayOnTop;
    end;
  end;
  if dimensionabile then
  Leggiposform
  else
    begin
    if dialogo then borderstyle:=bsdialog;
    //else BorderIcons := BorderIcons + [biMaximize];
    top:=round(screen.height/2)-round(height/2);
    left:=round(screen.width/2)-round(width/2);
    end;
  end;
sottoform:=true;
end;
Procedure FormCompleta;
begin
with form1 do
  begin
  groupbox58.Visible:=false;
  button14.Visible:=true;
  groupbox2.Visible:=true;
  end;
form_prop:=false;
form1.PageControl3.tabheight:=0;
form1.PageControl3.tabwidth:=0;
form1.PageControl4.tabheight:=0;
form1.PageControl4.tabwidth:=0;
form1.PageControl24.visible:=true;
form1.PageControl22.tabheight:=1;//verticale pareti
form1.PageControl22.tabwidth:=1;
form1.PageControl5.tabheight:=1;//verticale finestre
form1.PageControl5.tabwidth:=1;
form1.PageControl2.tabheight:=1;
form1.PageControl2.tabwidth:=1;
form1.PageControl1.visible:=False;
form1.Panel28.visible:=False;

form1.groupbox2.height:=70;
form1.Image1.top:=72;
form1.button17.Visible:=false;
form1.button16.Visible:=true;
form1.SpeedButton10.visible:=false;
form1.SpeedButton3.visible:=false;
form1.caption:='Projectbrowser : '+progetto_corrente;
form1.borderstyle:=bsSizeable;
//form1.PageControl2.TabHeight:=50;
//form1.PageControl2.TabWidth:=100;
//oldpost:=form1.top;
//oldposl:=form1.left;
//oldw:=form1.width;
//oldh:=form1.height;
//restoresize:=true;
form1.Panel29.Visible:=true;
form1.Pagecontrol4.Visible:=true;
//form1.Width:=form1.pagecontrol1.width+10;
//form1.height:=form1.pagecontrol1.height+65;
form1.formstyle:=fsNormal;
form1.groupbox1.visible:=true;
form1.button16.Caption:='Conferma modifiche';
form1.menu:=form1.mainmenu1;
form1.EAlloggio.Visible:=false;
form1.label183.caption:='Locale N.:';
form1.Label182.Caption:='?';
//LeggiPOsform;
salva_Var('DOPPIO','FALSE');
LeggiPOsform;
end;

Procedure FormPannello;
Var ss:string;
begin
with form1 do
  begin
  if mempos then Salvaposform;
  {$IFNDEF dllbm}
  //informazioni progetto
  form1.borderstyle:=bsdialog;
  groupbox58.Visible:=true;
  ss:=extractfilename(progetto_corrente);
  ss:=copy(ss,1,length(ss)-4);
  label19.Caption:=ss;
  groupbox58.caption:=extractfilepath(progetto_corrente);
  groupbox58.caption:=copy(groupbox58.caption,1,length(groupbox58.caption)-length(ss)-1);
  if length(groupbox58.caption)>30 then
  groupbox58.caption:=' .. '+copy(groupbox58.caption,length(groupbox58.caption)-30,30);
  groupbox58.caption:='Cartella:'+groupbox58.caption;

  ss:=extractfilename(Leggi_var('DISEGNOCORRENTE'));
  ss:=copy(ss,1,length(ss)-4);
  label38.Caption:=ss;
  {$endif}
  form1.Panel29.Visible:=true;
  groupbox1.Visible:=false;
  button16.Visible:=false;
  button17.Visible:=true;
  button14.Caption:='Ritorna al CAD Interno';
  speedButton2.Hint:='Ritorna al CAD Interno';
  //speedButton9.Hint:='Ritorna al CAD Interno';
  tabsheet4.Enabled:=false; //gestione
  tabsheet43.Enabled:=false; //piani
  speedButton10.visible:=true;
  speedButton3.visible:=true;
  if not cbdoppio.checked then
    begin
    caption:='Projectbrowser';
    //POsform:=poScreenCenter;
    //BorderIcons := BorderIcons - [biMaximize];
    menu:=nil;
    speedButton1.visible:=true;
    Panel_base.Visible:=false;
    Pagecontrol4.Visible:=false;
    form1.WindowState:=wsnormal;
    form1.Width:=Pagecontrol1.width+10;
    form1.Left:=screen.Width-pagecontrol1.Width-45;
    form1.Top:=105;
    form1.height:=485;
    form1.FormStyle:=fsstayontop;
    //tabsheet4.TabVisible:=false; //gestione
    //tabsheet43.TabVisible:=false; //piani
    if checkbox2.checked then
      begin
      Pagecontrol1.ActivePageIndex:=1;
      tabsheet6.TabVisible:=false; //reti
      end
    else
      begin
      tabsheet5.TabVisible:=false; //edificio
      Pagecontrol1.ActivePageIndex:=2;
      //tabsheet50.TabVisible:=false;//ELENCO RETI
      tabsheet50.Enabled:=false; //Reti
      end;
    end ;
  //else
  form1.pagecontrol1.enabled:=true;
  form1.panel28.enabled:=true;
  Pagecontrol4.ActivePageIndex:=1;
  Pagecontrol24.TabHeight:=0;
  Pagecontrol24.Tabwidth:=0;
  Pagecontrol24.Top:=7;
  Pagecontrol24.left:=204;
  form1.EAlloggio.Visible:=true;
  form1.Label183.Caption:='Alloggio';
  form1.Label182.Caption:='';
  pagecontrol1.ActivePageIndex:=pagecontrol24.ActivePageIndex+1;
  posiz_prop;
  end;
end;

Procedure FormProprieta(oggetto:string);
begin
with form1 do
  begin
  //BorderIcons := BorderIcons - [biMaximize];
  menu:=nil;
  end;
form1.Panel28.Visible:=true;//bottone disegna
form1.PageControl22.tabheight:=1;//verticale pareti
form1.PageControl22.tabwidth:=1;
form1.PageControl5.tabheight:=1;//verticale finestre
form_prop:=true;
form1.PageControl1.visible:=True;
form1.button17.Visible:=false;
form1.button16.Visible:=true;
form1.SpeedButton10.visible:=false;
form1.SpeedButton3.visible:=false;
form1.caption:=Oggetto;
form1.borderstyle:=bsdialog;
if oggetto='PARETE' then
  begin
  compilaform(form1.gbpareti,'confcad',dmtutti.ds_confcad);
  AggiornaTabcolori;
  form1.PageControl1.ActivePageIndex:=1;
  form1.PageControl2.ActivePageIndex:=0;
  end;
if oggetto='FINESTRA' then
  begin
  compilaform(form1.gbfinestre,'confcad',dmtutti.ds_confcad);
  form1.PageControl1.ActivePageIndex:=1;
  form1.PageControl2.ActivePageIndex:=1;
  end;
if oggetto='PONTE' then
  begin
  compilaform(form1.gbPontitermici,'confcad',dmtutti.ds_confcad);
  form1.PageControl1.ActivePageIndex:=1;
  form1.PageControl2.ActivePageIndex:=2;
  end;
if oggetto='LOCALE' then
  begin
  compilaform(form1.gblocali,'confcad',dmtutti.ds_confcad);
  form1.PageControl1.ActivePageIndex:=1;
  form1.PageControl2.ActivePageIndex:=3;
  form1.EAlloggio.Visible:=true;
  end;

form1.PageControl3.tabheight:=1;
form1.PageControl3.tabwidth:=1;

if (oggetto='RIMRETE')or(oggetto='RIPRETE') then
  begin
  compilaform(form1.gbtiporete,'confcad',dmtutti.ds_confcad);
  form1.groupbox7.Visible:=true;
  form1.groupbox8.Visible:=oggetto='RIMRETE';
  form1.PageControl25.Visible:=false;
  form1.PageControl1.ActivePageIndex:=2;
  form1.PageControl3.ActivePageIndex:=1;
  end;
if (oggetto='TRATTO') then
  begin
  compilaform(form1.gbtiporete,'confcad',dmtutti.ds_confcad);
  form1.groupbox7.Visible:=false;
  form1.groupbox8.Visible:=false;
  form1.PageControl25.Visible:=true;
  form1.PageControl1.ActivePageIndex:=2;
  form1.PageControl3.ActivePageIndex:=1;
  end;
if (oggetto='TERMINALE') then
  begin
  compilaform(form1.gbterminali,'confcad',dmtutti.ds_confcad);
  form1.gbterminali.Visible:=true;
  form1.gbvalvole.Visible:=false;
  form1.PageControl15.Visible:=true;
  form1.PageControl1.ActivePageIndex:=2;
  form1.PageControl3.ActivePageIndex:=2;
  end;
if (oggetto='COMPONENTE') then
  begin
  compilaform(form1.gbvalvole,'confcad',dmtutti.ds_confcad);
  form1.gbterminali.Visible:=false;
  form1.gbvalvole.Visible:=true;
  form1.PageControl15.Visible:=false;
  form1.PageControl1.ActivePageIndex:=2;
  form1.PageControl3.ActivePageIndex:=2;
  end;

with form1 do
  begin
  if (oggetto='EDIFICIO')or(oggetto='RETI') then
    begin
    GroupBox58.Visible:=true;
    if oggetto='EDIFICIO' then
      begin
      pagecontrol1.ActivePageIndex:=1;
      pagecontrol2.tabheight:=0;
      pagecontrol2.tabWidth:=0;
      end
    else
      begin
      end;
    end
  else
    begin
    form1.GroupBox58.Visible:=false;
    form1.pagecontrol2.tabheight:=1;
    form1.pagecontrol2.tabWidth:=1;
    end;
  end;

oldpost:=form1.top;
oldposl:=form1.left;
oldw:=form1.width;
oldh:=form1.height;
restoresize:=true;
form1.Panel29.Visible:=true;
form1.Pagecontrol4.Visible:=false;
form1.Width:=form1.pagecontrol1.width+10;
form1.height:=form1.pagecontrol1.height+65;
form1.formstyle:=fsStayOnTop;
form1.groupbox1.visible:=false;
form1.button16.Caption:='Disegna';

LeggiPOsform;
end;

Procedure Init_config_user;
begin
form1.TabSheet63.TabVisible:=false;
form1.TabSheet64.TabVisible:=false;
form1.TabSheet65.TabVisible:=false;
if form1.RadioButton1.Checked then form1.button16.Caption:='Conferma modifiche'
else form1.button16.Caption:='Dettagli';

if fileexists(I_sl(percorsodrive)+'Controllo.txt') then
  begin
  form1.groupbox20.Visible:=true;
  form1.Panel_base.Visible:=true;
  end;

if fileexists(I_sl(percorsodrive)+'Conf_L10.txt') then
  begin
  TipoUser:=UsL10;
  form1.TabSheet4.TabVisible:=false;
  form1.TabSheet6.TabVisible:=false;
  //form1.TabSheet24.TabVisible:=false;
  form1.TabSheet36.TabVisible:=false;
  form1.TabSheet44.TabVisible:=false;
  form1.TabSheet60.TabVisible:=false;
  form1.TabSheet20.TabVisible:=false;
  //form1.TabSheet54.TabVisible:=false;
  form1.TabSheet75.TabVisible:=false;
  form1.TabSheet76.TabVisible:=false;
  form1.TabSheet43.TabVisible:=false;
  form1.TabSheet83.TabVisible:=false;
  form1.TabSheet2.TabVisible:=false;
  form1.TabSheet3.TabVisible:=false;
  form1.CB_Reti.Visible:=false;
  end
else
if fileexists('c:\bmsistemi\semplificato.txt') then
  begin
  TipoUser:=Ussemp;
  form1.panel_base.Visible:=false;
  form1.pagecontrol1.Visible:=false;
  form1.TabSheet24.TabVisible:=false;
  form1.TabSheet36.TabVisible:=false;
  form1.TabSheet44.TabVisible:=false;
  form1.TabSheet15.TabVisible:=false;
  form1.TabSheet16.TabVisible:=false;
  end
else
  begin
  if fileexists('c:\bmsistemi\configdiego.txt') then
    begin
    TipoUser:=UsDIEGO;
    end
  else
    begin
    form1.TabSheet24.TabVisible:=false;
    form1.TabSheet36.TabVisible:=false;
    form1.TabSheet44.TabVisible:=false;
    if fileexists('c:\bmsistemi\configCAD.txt') then
      begin
      TipoUser:=UsCAD;
      end
    else
      begin
      form1.groupbox2.height:=120;
      form1.dbcombobox1.width:=140;
      form1.dbcombobox2.width:=140;
      form1.RadioButton2.Checked:=true;
      form1.groupbox20.Visible:=false;
      form1.groupbox21.Visible:=false;
      form1.groupbox27.Visible:=false;
      form1.speedbutton4.Visible:=false;
      form1.speedbutton5.Visible:=false;
      form1.tabsheet5.TabVisible:=false;
      form1.tabsheet6.TabVisible:=false;
      form1.tabsheet43.TabVisible:=false;
      form1.tabsheet4.caption:='Gestione visualizzazione del disegno 2d';
      TipoUser:=UsBM;
      end;
    end;
  end;
if fileexists(I_sl(percorsodrive)+'Conf_Reti.txt') then
  begin
  Attiva_reti:=true;
  form1.TabSheet83.TabVisible:=true;//edificio_reti
  form1.TabSheet6.TabVisible:=true; //Proprietà
  end;
If DllBM then  solo3d;

end;

end.
