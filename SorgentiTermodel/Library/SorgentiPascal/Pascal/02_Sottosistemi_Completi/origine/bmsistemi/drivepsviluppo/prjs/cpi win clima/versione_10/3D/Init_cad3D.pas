unit Init_cad3D;

interface
uses windows,Ugest_cad,gestudb,libreriagenerale,Ucompilaform,Udbt,Udb,
     letturadisegnobidimensionale,grafica2d,sysutils,forms,copialetturadisegno3d,
     {duplicapiani,}UdataLink,{HeaderDllTermico,Uchiamatedll1}UinitGeneral,{Upareti3d,}
     colore_pareti,{Ufinestre3D,}Gestione_dati,{ponti,}gest_form,confineparete3d,Impianti3D,Generatori3D,Zone3D,
     {$IfNdef usadll}
     {usolomuri,zone,impianti,ponti,stampe,datifabbricato,}
     {$endif}
     init_l10,
     dbtables,stdctrls,
     dbctrls,{Confine,}UOpen_filemulti,progress3d,Dxf_in_out,UDataoutT,CreaDxfEdificio,{varcarichi}
     {$Ifdef tubi_14}
     Funz_reti,
     {$Else}
     Interf3D_reti,
     {$endif}
     varcarichi,
     {$Ifdef estivo_14}
     initestivo,
     {$endif}
     {cardll,}
     setta_config_User,gesterrori,dialogs,Fasi_progetto,Piani3d,Errori3d,Falde3D,config_var,cambiaelab,
     filedialog;
Procedure InitPannelloClima;
Procedure Esegui_Autocad(cerca:boolean);
Procedure EseguiMenu(Item:String);
Procedure Script_Locale;
Procedure Script_parete;
procedure script_finestra;
procedure script_ponte;
Procedure CambiaLponte;
Procedure Script_Tubo;
Procedure Cambiatipopar;
Procedure CambiatipoF;
Procedure CambiaConfine;
Procedure CambiaTlinea;
Function nuovo_progetto(chiedipiani:boolean):boolean;
Procedure SalvaProgetto(conNome:boolean);
Function Apri_progetto(prg_cor:string;mem:boolean):boolean;
Procedure AggiornaProgetto(leggipiante,rinumera:boolean);
Procedure modificapercorsodxf;
Procedure EsportaDXF;
Procedure Inportadxf(agg3d,archivi,leggient:boolean);
Procedure Apri_piano;
Procedure CaricaPiantasfondo;
Procedure Aggiorna_tutto;
Procedure Caricadis_tubi;
Procedure CambiatipoTubo;
Procedure CambiaColoreTubo;
Procedure Script_Gestrete;
Procedure Script_Terminale;
Procedure CambiacoloreParete;
Procedure Cambiaponte;
Procedure ItemMenu(comm:string);
Procedure Visual_prog;
Procedure AggiornaTabcolori;
Procedure AggiornaTabConfini;
Procedure Combocolori;
Procedure EseguiMenuDll(Item:String);
Procedure PassaAlCad;
Procedure Aggiorna3D;
Procedure StopAggiorna;
Procedure StartAggiorna;
Procedure archiviopareti;
Procedure Archivioconfini;
Procedure Aggiornascript(nome:string);
Procedure AggiornaControls;
Procedure Cambia_Zona;
Function PianiSimili(codp:string):string;
Function Piani_Simili(codp:string):string;
Procedure CambiaPiano;
Procedure Cambia_confine_soff;
Procedure Gest_Falde3d;
Procedure Agg_combo_soff;
Procedure Agg_combo_Pav;
Procedure SalvaPOsform;
Procedure SalvaPOsProp;
Procedure LeggiPOsform;
Procedure Posiz_prop;
Procedure aggiorna_liberi;
Procedure GestConfineParete;
Procedure Gest_Pavim3d;
Procedure Tubi_edif(modo:integer);
function ed_reti:boolean;
Procedure settacoloreTubo;
function P_corr(pp:string):boolean;
function R_corr(rr:string):boolean;
Procedure Setta_progetto(nomepr:string);
Procedure set_percdxf(percdxf:string);
function Progetto_corrente:string;
Procedure visualizza_disegno(dis:string);
Procedure Ritorna_SD;
Procedure Vai_BM;
Procedure scriptOggetto;
Procedure cambia_Progetto(nprogetto:string);
Procedure cambiaProgetto(nprogetto:string);
Procedure CercaPiano;
Procedure Script_Collettore;
Procedure LeggiNomeProgetto;
function Perc_work:string;
Function Nome_dxf(nomepiano,nomerete,edif_rete:string):string;
Function Nome_dis(nomepiano,nomerete,edif_rete:string):string;

// DEFINIZIONE COMANDI ESTERNI AUTOCAD

Const maxcomandi=12;
      com_Calcoli=1;
      com_Proprieta=2;
      com_ApriProg=3;
      com_SalvaProg=4;
      com_SalvaNome=5;
      com_Esci=6;
      com_CambiaElab=7;
      com_Orient=8;
      com_3d=9;
      com_controlla=10;
      com_NuovoProg=11;
      com_Relaz=12;

Type comacad=record
              NomeComando,capt:string;
              datafile:integer;
              chiudiD:boolean;
              end;
Var Data_com:array[1..maxcomandi]of comacad=((nomeComando:'CALCOLI';capt:'Calcoli';chiudiD:false),
                                             (nomeComando:'PROPRIETA';capt:'';chiudiD:true),
                                             (nomeComando:'APRIPROG';capt:'';chiudiD:true),
                                             (nomeComando:'SALVAPROG';capt:'';chiudiD:false),
                                             (nomeComando:'SALVANOME';capt:'';chiudiD:true),
                                             (nomeComando:'ESCI';capt:'';chiudiD:true),
                                             (nomeComando:'CAMBIAELAB';capt:'Cambia elaborato';chiudiD:true),
                                             (nomeComando:'ORIENT';capt:'Orientamento dell'' edificio';chiudiD:false),
                                             (nomeComando:'3D';capt:'';chiudiD:false),
                                             (nomeComando:'Controlla';capt:'Analisi delle irregolarità del disegno';chiudiD:false),
                                             (nomeComando:'NUOVOPROG';capt:'';chiudiD:true),
                                             (nomeComando:'RELAZIONE';capt:'Creazione relazioni';chiudiD:False));


var nocambia:boolean=false;
    noscript:boolean=true;
    mempos:boolean=true;
    countblocchi:integer=0;
    perc_progcor:string;
    agg_visual:boolean=false;
    UltspoX,UltspoY:real;
    primoavvio:boolean=false;
    Sottoautocad:boolean=false;
    doppioclick:boolean=true;
    agg_3d:boolean=false;
    ProgInport:string='';
    Progcor:string;
implementation
uses U3dsd,interfdll,secondario;

const   Selezionare_ogni_volta='Selezionare ogni volta';
Var     ndxf:string;
        dataDxf,DataDxfEsci,datadxfSalvaprog,datadxfSalvaNome,datadxfApriprog,datadxfProprieta:integer;


      tl:array[1..6]of record
                       n:string[50];
                       v:boolean;
                       end;

      old_nocambia,oldstayontop:boolean;


const senzanome='Progetto senza nome';
      confauto='Autorilevato';

Procedure scriptOggetto;
Var scrbase:string;
begin
if (nocambia)and(noscript) then exit;
scrbase:='';
if form1.pagecontrol1.activepageindex=1 then //edificio
  case form1.pagecontrol2.activepageindex of
  0:scrbase:='Parete';
  1:scrbase:='Finestra';
  2:scrbase:='Ponte';
  3:scrbase:='Locale';
  end
else
  case form1.pagecontrol3.activepageindex of
  1:scrbase:='Tratto';
  2:scrbase:='Terminale';
  4:scrbase:='IRete';
  end;
if scrbase<>'' then copyfile(pchar(I_sl(percorsodrive)+scrbase+'.scr'),pchar(I_sl(percorsodrive)+'oggetto.scr'),false);
end;
Procedure Vai_BM;
Var ft:textfile;
    distribuzione:string;
begin
distribuzione:=copy(i_sl(libreriagenerale.PercorsoDrive),1,length(i_sl(libreriagenerale.PercorsoDrive))-length('versione_14\termotecnica\file_termico\Projectbrowser\'));
oldstayontop:=form1.formstyle<>fsNormal;
form1.formstyle:=fsNormal;
old_nocambia:=nocambia;
nocambia:=true;
closeudbt;
assign(ft,libreriagenerale.percorsodrive+'patharch.txt');
rewrite(ft);
writeln(ft,distribuzione+'archivi\clima\archivi');
close(ft);
end;
Procedure Ritorna_SD;
Var ft:textfile;
begin
openUdbt;
nocambia:=old_nocambia;
assign(ft,libreriagenerale.percorsodrive+'patharch.txt');
rewrite(ft);
writeln(ft,i_sl(libreriagenerale.PercorsoDrive)+'archivi\');
close(ft);
if oldstayontop then form1.formstyle:=fsstayontop;
end;

Procedure CercaPiano;
Var Pcc:string;
begin
pcc:=V_recconfcad.Pianocor;
with dmtutti.T_Piani do
  begin
  first;
  while (not (eof))and( V_recpia.Cod<>pcc) do next;
  end;
end;

Procedure visualizza_disegno(dis:string);
begin
CercaPiano;
ultspox:=V_recpia.AllineaX;
ultspoy:=V_recpia.Allineay;
chdir(Percorsodrive);
with  form1.OleContainer1 do
  begin
  DestroyObject;
  //if linked then showmessage('linked');
  if fileexists(dis) then
    begin
    CreateObjectFromFile(dis,false);
    //CreateLinkToFile(disegnocorrente,false);
    DoVerb(0);
    end
  else
  showmessage('Errore nell'' aggiornamento del CAD: non esiste il file '+dis);
  end;
//showmessage(form1.OleContainer1.ObjectVerbs.Strings[2]);
end;

function P_corr(pp:string):boolean;
begin
result:=uppercase(V_recconfcad.PIANOCOR)=uppercase(pp);
end;
function R_corr(rr:string):boolean;
begin
result:=uppercase(V_recconfcad.ColoreTipoReteIRR)=uppercase(rr);
end;


Procedure Tubi_edif(modo:integer);
begin
if modo=1 then
  Case form1.PageControl24.ActivePageIndex of
  0:begin
    form1.checkbox2.Checked:=true;
    form1.checkbox3.Checked:=false;
    form1.pagecontrol1.ActivePageIndex:=1;
    end;
  1:begin
    form1.checkbox2.Checked:=false;
    form1.checkbox3.Checked:=true;
    form1.pagecontrol1.ActivePageIndex:=2;
    end;
  end
else
  Case form1.PageControl1.ActivePageIndex of
  1:begin
    form1.checkbox2.Checked:=true;
    form1.checkbox3.Checked:=false;
    form1.pagecontrol24.ActivePageIndex:=0;
    end;
  2:begin
    form1.checkbox2.Checked:=false;
    form1.checkbox3.Checked:=true;
    form1.pagecontrol24.ActivePageIndex:=1;
    end;
  end;
end;

function ed_reti:boolean;
begin
result:=form1.checkbox2.Checked;
end;

Procedure aggiorna_liberi;
Var oldnc:boolean;
begin
oldnc:=nocambia;
Nocambia:=false;
CambiaTLinea;
nocambia:=oldnc;
end;

function Perc_work:string;
var solonome:string;
begin
perc_Progcor:=extractfilepath(progcor);
solonome:=extractfilename(progcor);
solonome:=copy(solonome,1,length(solonome)-4);
result:=i_sl(perc_Progcor)+'work_'+solonome+'\';
end;

Function Nome_dis(nomepiano,nomerete,edif_rete:string):string;
begin
if edif_rete='EDIFICIO' then result:=perc_work+'Edificio_'+nomepiano
else result:=perc_work+Nomerete+'_'+Nomepiano;
end;
Function Nome_dxf(nomepiano,nomerete,edif_rete:string):string;
Var grigio:string;
begin
grigio:='';
if tutto_grigio then grigio:='_grigio';
result:=Nome_dis(nomepiano,nomerete,edif_rete)+grigio+'.dxf';
end;

Procedure Setta_progetto(nomepr:string);
Var ft:textfile;
const prog_hello='ESEMPI\CONDOMINIO\CONDOMINIO.BMT';

begin
progcor:=nomepr;
perc_Progcor:=extractfilepath(progcor);
perc_Progcor:=i_sl(perc_Progcor);
assign(ft,percorsoDrive+'\nomeprog.txt');
rewrite(ft);
writeln(ft,progcor);
close(ft);
salva_var('PROGETTOCORRENTE',nomepr);
end;

function Progetto_corrente:string;
begin
result:=progcor;
end;
Procedure LeggiNomeProgetto;
Var ft:textfile;
    ss:string;
const prog_hello='ESEMPI\CONDOMINIO\CONDOMINIO.BMT';
begin
if fileexists(percorsoDrive+'\nomeprog.txt') then
  begin
  assign(ft,percorsoDrive+'\nomeprog.txt');
  reset(ft);
  readln(ft,progcor);
  close(ft);
  end
else progcor:=senzanome;

//gestisce il progetto esempio durante la prima installazione
if length(progcor)>length(prog_hello) then
  begin
  ss:=uppercase(copy(progcor,length(progcor)+1-length(prog_hello),length(prog_hello)));
  if ss=prog_hello then
    begin
    progcor:=extractfilepath(application.ExeName);
    progcor:=i_sl(progcor)+lowercase(prog_hello);
    end;
  end;
  //Visualprog;
end;


Procedure InitTlinea;
Var i:integer;
begin
for i:=1 to 6 do
  case i of
  1:tl[i].n:='0:CONTINUOUS: ( ________)';
  2:tl[i].n:='1:ACAD_ISO02W100:( __ __ __ )';
  3:tl[i].n:='2:ACAD_ISO03W100:( _  _ _ _ _)';
  4:tl[i].n:='3:ACAD_ISO04W100:( __.__._.)';
  5:tl[i].n:='4:ACAD_ISO05W100:( _..__..  )';
  6:tl[i].n:='5:ACAD_ISO06W100:( __...__  )';
  end;
end;

Procedure CancellaFileestensione(percorso,estens:string);
 Var sr:Tsearchrec;
     NomeFile : String;
     perc:string;
     Trovato : Integer;
 begin
 percorso:=i_sl(percorso);
 perc:=percorso+'*.'+estens;

     Trovato := FindFirst(perc,faanyfile,sr);
     while Trovato = 0 do
        begin
             NomeFile := percorso+ sr.Name;
             DeleteFile(NomeFile);
             Trovato := FindNext(sr);
        end;
end;


Procedure CancellafileTemporaneiEdificio;
begin
cancellafileestensione(percorsodrive,'3DM');
cancellafileestensione(percorsodrive,'IGI');
cancellafileestensione(percorsodrive,'BGI');
cancellafileestensione(percorsodrive,'IGG');
cancellafileestensione(percorsodrive,'BGG');
cancellafileestensione(percorsodrive,'EGI');
cancellafileestensione(percorsodrive,'FIN');
cancellafileestensione(percorsodrive,'INT');
cancellafileestensione(percorsodrive,'TXE');
cancellafileestensione(percorsodrive,'REP');
end;
Procedure CancellafileTemporanei;
Var  ff:file;
begin
if fileexists(percorsodrive+'\disegno.txt')then
  begin
  assignfile(ff,percorsodrive+'\disegno.txt');
  erase(ff);
  end;
if fileexists(percorsodrive+'\Tubi.txt')then
  begin
  assignfile(ff,percorsodrive+'\tubi.txt');
  erase(ff);
  end;
if fileexists(percorsodrive+'\disegno.dxf')then
  begin
  assignfile(ff,percorsodrive+'\disegno.dxf');
  erase(ff);
  end;
if fileexists(percorsodrive+'\copiadisegno.dxf')then
  begin
  assignfile(ff,percorsodrive+'\copiadisegno.dxf');
  erase(ff);
  end;
if fileexists(percorsodrive+'\Workdisegno.dxf')then
  begin
  assignfile(ff,percorsodrive+'\Workdisegno.dxf');
  erase(ff);
  end;
if fileexists(I_sl(percorsodrive)+NomeFile_Errori_Impianti)then
  begin
  assignfile(ff,I_sl(percorsodrive)+NomeFile_Errori_Impianti);
  erase(ff);
  end;
cancellafileestensione(percorsodrive,'o3D'); //Calcolo tubi
cancellafileestensione(percorsodrive,'o2D'); //Input tubi
cancellafileestensione(percorsodrive,'U3D');  //Calcolo Terminali
cancellafileestensione(percorsodrive,'U2D');  //Calcolo Terminali
cancellafileestensione(percorsodrive,'Q2D');  //quote
cancellafileestensione(percorsodrive,'T3D');  //Input terminali
cancellafileestensione(percorsodrive,'T2D');  //Input terminali
cancellafileestensione(percorsodrive,'RTT');
cancellafileestensione(percorsodrive,'LKK');
cancellafileestensione(percorsodrive,'FXF');
cancellafileestensione(percorsodrive,'BXF');
cancellafileestensione(percorsodrive,'REP'); //report
cancellafileestensione(percorsodrive,'INT'); //risultati dei calcoli e lettura disegno
cancellafileestensione(percorsodrive,'FIN'); //lettura disegno finestre
cancellafileestensione(percorsodrive,'TXE'); //controllo disegno
cancellafileestensione(percorsodrive,'RTF');
cancellafileestensione(percorsodrive,'EXE');
cancellafileestensione(percorsodrive,'BAK');
cancellafileestensione(percorsodrive,'DWG');
cancellafileestensione(percorsodrive,'PNN');//   Disegno pannelli in3 d
CancellafileTemporaneiEdificio;
end;


Procedure Agg_combo_soff;
//LKK#Confine/1/P:CMB#Non sc:CMB#Da piano:CMB#Esterno:CMB#Falda:#INI'Da piano':
Var Tmp:string;
begin
nocambia:=true;
with form1.DBConfineSoffitto do
  begin
  dmtutti.T_confcad.edit;
  dmtutti.T_confcad.POst;
  dmtutti.T_confcad.Close;
  //tmp:=text;
  items.Clear;
  items.Add('Non sc');
  items.Add('Da piano');
  items.Add('Esterno');
  dmtutti.T_Confine.First;
  while not dmtutti.T_Confine.eof do
    begin
    //if uppercase(V_recconf.TipoConfine)='PARETE INCLINATA' then
    if V_recconf.Inclin<90 then
    items.Add(V_recconf.Codice);
    dmtutti.T_Confine.next;
    end;
  //text:=tmp;
  dmtutti.T_confcad.open;
  dmtutti.T_confcad.edit;
  end;
nocambia:=false;
end;

Procedure Agg_combo_Pav;
Var Tmp:string;
begin
nocambia:=true;
with form1.DBConfinePavimento do
  begin
  dmtutti.T_confcad.edit;
  dmtutti.T_confcad.POst;
  dmtutti.T_confcad.Close;
  //tmp:=text;
  items.Clear;
  items.Add('Non sc');
  items.Add('Da piano');
  items.Add('Esterno');
  dmtutti.T_Confine.First;
  while not dmtutti.T_Confine.eof do
    begin
    //if uppercase(V_recconf.TipoConfine)='PARETE INCLINATA' then
    if V_recconf.Inclin>90 then
    items.Add(V_recconf.Codice);
    dmtutti.T_Confine.next;
    end;
  //text:=tmp;
  dmtutti.T_confcad.open;
  dmtutti.T_confcad.edit;
  end;
nocambia:=false;
end;




Procedure Gest_Falde3d;
Var tmp:string;
begin
dmtutti.T_Confcad.edit;
//tmp:=GestFalde3D;
Gest_ConfineParete3d(TgcSoffitto);
Agg_combo_soff;
//V_Recconfcad.Set_ConfSoffLoc(Tmp);
//dmtutti.T_Confcad.POst;
//dmtutti.T_Confcad.edit;
//compilaform(form1.gbsoffitto,'ConfCad',dmtutti.ds_confcad);
end;
Procedure Gest_Pavim3d;
Var tmp:string;
begin
dmtutti.T_Confcad.edit;
//tmp:=GestFalde3D;
Gest_ConfineParete3d(TgcPavim);
Agg_combo_Pav;
//V_Recconfcad.Set_ConfSoffLoc(Tmp);
//dmtutti.T_Confcad.POst;
//dmtutti.T_Confcad.edit;
//compilaform(form1.gbsoffitto,'ConfCad',dmtutti.ds_confcad);
end;

Procedure Cambia_confine_soff;
begin
if nocambia then exit;
nocambia:=true;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
{
if V_RecConfcad.ConfSoffLoc='Falda' then
  begin
  GestFalde3D;
  V_RecConfcad.set_ConfSoffLoc(V_RecConf.Codice);
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.Edit;
  end;
}
nocambia:=false;
script_Locale;
end;

Procedure CambiaPiano;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
Salvapiano_precedente(false);
Apripiano(form1.RadioButton1.Checked,form1.DBCombobox1.text);
caricadis_tubi;
prima_volta:=true;
ridisegna;
form1.pagecontrol4.ActivePageIndex:=1;
form1.edit41.SetFocus;//per evitare che lo scroll cambi il combo

if Pianisimili(V_recconfcad.PIANOCOR)<>'' then
    begin
    form1.RadioButton1.Checked:=false;
    Form1.RadioButton1Click(nil);
    end
  else
form1.RadioButton1.Checked:=true;

end;

Function PianiSimili(codp:string):string;
begin
result:='';
with dmtutti.T_Piani do
  begin
  first;
  while (not eof)and(V_recpia.Cod<>codp)do next;
  if V_recpia.Cod=codp then result:=V_recpia.copiadi;
  end;
end;
Function Piani_Simili(codp:string):string;
begin
result:=Pianisimili(codp);
if result<>'' then showmessage('Questo piano è una copia di '+result+' e non può essere modificato.');
end;

Procedure GestConfineParete;
Begin
nocambia:=true;
Gest_ConfineParete3d(TgcParete);
Aggiornatabconfini;
nocambia:=false;
end;

Procedure archiviopareti;
begin
EseguiMenuDll('ARCHIVIOPARETI');
//EseguiMenu('ARCHIVIOPARETI');  // Esegue gli archivi pareti
script_Parete;
AggiornaTabcolori;
compilaform(form1.gblocali,'ConfCad',dmtutti.ds_confcad);
//compilaform(FPiani3d.groupbox1,'Piani',dmtutti.ds_PIani);
end;
Procedure Archivioconfini;
begin
//EseguiMenuDll('CONFINE');
//EseguiMenu('CONFINE');
Gest_ConfineParete3d(TgcPavim);
AggiornaTabConfini;
script_Parete;
//compilaform(form1.gblocali,'ConfCad',dmtutti.ds_confcad);
//compilaform(FPiani3d.groupbox1,'Piani',dmtutti.ds_PIani);
end;


Function SetDataDxf(nomecom:string):integer;
Var sr:TsearchRec;
    trovato:integer;
begin
result:=0;
Trovato := FindFirst(i_sl(Percorsodrive)+nomecom+'.dxf',faarchive,sr);
//Trovato := FindFirst(i_sl(Percorsodrive)+'disegno.dxf',faarchive,sr);
If Trovato = 0 then  result:=sr.Time;
end;
Procedure StartAggiorna;
var prcor:string;
    i:integer;
begin
prcor:=extractfilepath(leggi_var('DISEGNOCORRENTE'));
for i:=1 to maxcomandi do
with data_com[i] do
  begin
  if fileexists(prcor+nomeComando+'.dxf')
  then copyfile(Pchar(prcor+nomeComando+'.dxf'),pchar(i_sl(percorsodrive)+nomeComando+'.dxf'),false );
  datafile:=setDataDxf(nomeComando);
  end;
{
if fileexists(prcor+'Apriprog.dxf') then copyfile(Pchar(prcor+'Apriprog.dxf'),pchar(i_sl(percorsodrive)+'Apriprog.dxf'),false );
if fileexists(prcor+'Salvaprog.dxf') then copyfile(Pchar(prcor+'Salvaprog.dxf'),pchar(i_sl(percorsodrive)+'Salvaprog.dxf'),false );
if fileexists(prcor+'Calcoli.dxf') then copyfile(Pchar(prcor+'Calcoli.dxf'),pchar(i_sl(percorsodrive)+'Calcoli.dxf'),false );
if fileexists(prcor+'Esci.dxf') then copyfile(Pchar(prcor+'Esci.dxf'),pchar(i_sl(percorsodrive)+'Esci.dxf'),false );
if fileexists(prcor+'Proprieta.dxf') then copyfile(Pchar(prcor+'Proprieta.dxf'),pchar(i_sl(percorsodrive)+'Proprieta.dxf'),false );

datadxf:=setDataDxf('Calcoli');
datadxfEsci:=setDataDxf('Esci');
datadxfSalvaprog:=setDataDxf('Salvaprog');
datadxfApriprog:=setDataDxf('Apriprog');
datadxfSalvaNome:=setDataDxf('SalvaNome');
datadxfProprieta:=setDataDxf('Proprieta');
}
form1.timer1.Enabled:=true;
end;
Procedure StopAggiorna;
begin
form1.timer1.Enabled:=false;
end;
Procedure Aggiorna3D;
Var prcor:string;
    agg:boolean;
    indcom:integer;
begin
form1.timer1.Enabled:=false;
prcor:=extractfilepath(leggi_var('DISEGNOCORRENTE'));
prcor:=i_sl(prcor);
indcom:=0;
repeat
inc(indcom);
until (indcom>maxcomandi)or(setdataDxf(Data_com[indcom].nomecomando)<>Data_com[indcom].datafile);

if indcom>maxcomandi then
begin
form1.timer1.Enabled:=true;
exit;
end;
with Data_com[indcom] do
  begin
  copyfile(pchar(i_sl(percorsodrive)+nomecomando+'.dxf'),pchar(I_sl(percorsodrive)+'disegno.dxf'),false);
  form1.timer1.Enabled:=false;
  datafile:=setdataDxf(nomecomando);
  riapri:=chiudiD;
  end;
{
InportaDXF(true,true,false);
prima_volta:=true;
ridisegna;
form1.display(false);
}
solonord:=false;
comando_acad:=true;
if Data_com[indcom].capt<>'' then //sottoform
begin
  form1.Hide;
  if Data_com[indcom].chiudiD then Passaalcad
  else
    begin
    oldpianocor:=V_recconfcad.PIANOCOR;
    Ndxf:=i_sl(percorsodrive)+Data_com[indcom].Nomecomando+'.dxf';
    InportaDXF(true,true,false);
    //pianocorr:=V_recconfcad.pianocor;
    edit_in_cad:=false;
    end;
  formridotta(indcom);
  sottoform:=true;
  form1.show;
  prima_volta:=true;
  ItemSelEdif:=0;
  form1.edit12.Text:='';
  ridisegna;
  if attivosecondario then form1.display(true);
  end
else
case indcom of

com_3d:
  begin
  Progress_3d(-2,'Lettura disegno');
  Ndxf:=i_sl(percorsodrive)+Data_com[indcom].nomecomando+'.dxf';
  InportaDXF(true,true,false);
  Progress_3d(50,'Generazione modello 3d');
  Form1.Button19Click(nil);
  Progress_3d(-1,'Generazione modello 3d');
  if attivosecondario then
    begin
    startaggiorna;
    end
  else
    begin
    edit_in_cad:=false;
    formridotta(indcom);
    form1.Menu:=nil;
    form1.pagecontrol4.ActivePageIndex:=0;
    form1.caption:='Visualizzazione tridimensionale';
    form1.pagecontrol1.enabled:=False;
    form1.panel28.enabled:=false;
    form1.Button14.Visible:=false;
    form1.formstyle:=fsStayOnTop;
    //sottoform:=true;
    oldpianocor:=v_recconfcad.PIANOCOR;
    end;
  end;
com_proprieta:
  begin
  Passaalcad;
  form1.Menu:=nil;
  form1.Button14.Visible:=false;
  form1.caption:='Modifica delle proprietà degli oggetti';
  form1.pagecontrol1.enabled:=true;
  form1.panel28.enabled:=true;
  form1.formstyle:=fsStayOnTop;
  //sottoform:=true;
  end;
com_esci:
begin
  chiudisecondario;
  form1.setfocus;
  form1.Hide;
  Passaalcad;
  comando_acad:=false;
  form1.Close;
  end;
com_salvaprog:
begin
  form1.SetFocus;
  form1.FormStyle:=fsstayontop;
  Progress_3d(-2,'Salvataggio in corso');
  Progress_3d(20,'Lettura disegno');
  Ndxf:=i_sl(percorsodrive)+'Salvaprog.dxf';
  InportaDXF(true,true,false);
  Progress_3d(50,'Salvataggio progetto');
  Salvaprogetto(false);
  form1.timer1.Enabled:=true;
  Progress_3d(-1,'Salvataggio in corso');
  form1.FormStyle:=fsstayontop;
  form1.Show;
  end;
com_Apriprog,com_nuovoProg:
begin
  form1.Hide;
  Progress_3d(-2,'Salvataggio in corso');
  Progress_3d(20,'Lettura disegno');
  Passaalcad;
  Progress_3d(50,'Salvataggio progetto');
  Salvaprogetto(false);
  Salva_var('DISEGNOCORRENTE','');
  Progress_3d(-1,'Salvataggio in corso');
  //dialogNuovoprogetto;
  formridotta(indcom);
  form1.show;
  //Init_vba(agg);
  //form1.timer1.Enabled:=true;

  end;
end;

end;
Procedure PassaAlCad;
var ftt:textfile;
    ss:string;
begin
if Piani_simili(V_recconfcad.PIANOCOR)<>'' then exit;
with form1 do
begin
if fasiprogetto('Autocad')then exit;
if not edit_in_cad then
  begin //form ingrandita
  {$IFNdef Dllbm}
  FormPannello;
  {$Endif}
  edit_in_cad:=true;
  Salvapiano_precedente(false);
  Ndxf:=i_sl(percorsodrive)+'disegno.dxf';
 // if {not controlla_dis}true then  //riesporta il disegno solo se il cad lo leggerà
    begin
    progress_3d(60,'Cambio elaborato');
    EsportaDXF;
    progress_3d(90,'Cambio elaborato');
    {$IFNdef Dllbm}
    copyfile(Pchar(i_sl(percorsodrive)+'disegno.dxf'),Pchar(leggi_var('DISEGNOCORRENTE')),false);
    {$Endif}
    end;
  {$IFNdef Dllbm}
  aggiornascript;
  StartAggiorna;
  Ridisegna;
  //bloccapannello:=true;
  scriptoggetto;
  {$Endif}
  {
  if controlla_dis then
    begin
    dmtutti.T_Piani.edit;
    V_recpia.Set_AllineaX(UltAllineaX);
    V_recpia.Set_AllineaY(UltAllineaY);
    dmtutti.T_Piani.POst;
    dmtutti.T_Piani.edit;
    end;
  }
  end
else
  begin
  salvaPOsprop;
  copyfile(pchar(I_sl(percorsodrive)+'disegno.dxf'),pchar(I_sl(percorsodrive)+'tempdisegno.dxf'),false);
  assignfile(ftt,I_sl(percorsodrive)+'disegno.dxf');
  {$I-}
  erase(ftt);
  {$I+}
  if ioresult=0 then
    begin
    copyfile(pchar(I_sl(percorsodrive)+'tempdisegno.dxf'),pchar(I_sl(percorsodrive)+'disegno.dxf'),false);
    end
  else
    begin
    showmessage('Disegno in elaborazione nel CAD esterno ,premere il pulsante "Passa a projectbrowser" della toolbar del cad esterno');
    //closefile(ftt);
    exit;
    end;
  {$IFNdef Dllbm}
  Formcompleta;
  {$Endif}
  edit_in_cad:=false;
  progress_3d(10,'Cambio elaborato');
  ScriptCadInterno;
  //AggiornaProgetto;
  Ndxf:=i_sl(percorsodrive)+'disegno.dxf';
  progress_3d(25,'Cambio elaborato');
  InportaDXF(true,true,false);
  progress_3d(50,'Cambio elaborato');
  bloccapannello:=false;
  prima_volta:=true;
  ridisegna;
  end;

end;
end;
Procedure InitDLL;
Var Percorsobase,pathcor:string;
begin
pathCor:=I_sl(percorsodrive);
PercorsoBase:=copy(pathcor,1,length(pathcor)-length('\file_termico\Cadesterno\'));
//CaricaDllTermico(percorsobase+'\file_termico\DLLtermico\');
//DefinisciPercorsi(Pchar(Percorsobase+'\file_termico'),Pchar(I_sl(percorsoDrive)));
end;
Procedure Item_menu_exe(comm:string);
Var Ret:integer;
    nomeexe,par1:string;
begin
par1:='';
nomeexe:='';
if comm='ARCHIVIOPARETI' then
  begin
  nomeexe:='Pareti';
  par1:='PARETI';
  end;
if comm='ARCHIVIOFINESTRE' then
  begin
  nomeexe:='Pareti';
  par1:='FINESTRE';
  end;

ret:=winexec(Pchar('"'+ i_sl(Percorsodrive) + nomeexe+'.exe" '+par1),SW_Normal);
end;
Procedure EseguiMenuDll(Item:String);
Var {ItemPchar:Pchar;}
    i:integer;
begin
if Item='CALCOLOL10' then
  begin
  Progress_3d(-2,'Calcolo consumi');
  Aggiorna_Tutto;
  errorecor:=0;
  Aggiornaerroriedificio;
  If errorecor=0 then Carica_generatori;
  end;
nocambia:=true;
//ItemPchar:=Pchar(uppercase(item));
if Item='PIANI3D' then GestPiani3d
else
  begin
  {closeUdbt;
  form1.TPareti.Close;
  form1.Tfinestre.Close;}
  if Item='CALCOLOL10' then
    begin
    Progress_3d(-1,'');
    if errorecor<>0  then
      begin
      if Ferrori3d=nil then Ferrori3d:=tferrori3d.Create(nil);
      with Ferrori3d.Memo1 do
        begin
        clear;
        for i:=1 to form1.Listbox1.items.Count do
        lines.Add(form1.listbox1.Items.Strings[i-1]);
        end;
      Ferrori3d.showmodal;
      end
    else
      begin
     { if usadll then calcoloL10
      else} Calcolo_Legge10(form1.CBVERSBM.Checked);
      end;
    end
  else
    begin
    if form1.CBVERSBM.Checked then
      begin
      Vai_bm;
      //Item_menu(pchar(Item)) ;
      Ritorna_sd;
      end
    else Itemmenu(Item);
    end;
  {OpenUdbt;
  form1.TPareti.Open;
  form1.Tfinestre.Open;}
  end;
aggiornacontrols;
nocambia:=false;
end;

Procedure Aggiorna_tutto;
Var i:integer;
    piano_corr:string;
begin
if TipoUser=usBM then apri_Progetto(Progcor,false)
else
  begin
  Leggi_archivi_lettura(false);
  Nambienti:=0;
  //for i:=1 to Nambienti do ambienti_D^[i]^.Piano:='';
  piano_corr:=v_recconfcad.PIANOCOR;
  Salvapiano_precedente(false);
  Leggi_piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.DS_Piani);
  for i:=1 to npiani do
  if Piani_D^[i].CopiaDi='' then
    begin
    Progress_3d(round((i-1)/Npiani*100),'Interpretazione disegni 2D');
    Apripiano(true,Piani_d^[i].Cod);
    SalvaPiano(Piani_d^[i].Cod,true,true);
    dmtutti.T_Piani.next;
    end;
  salva_archivi_lettura;
  dmtutti.T_ConfCad.Edit;
  v_recconfcad.set_PIANOCOR(piano_corr);
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.Edit;
  Apri_piano;
  ridisegna;
  //form1.display(false);
  //with dmtutti.T_Locali do
  //  begin
  //  First;
  //  while not eof do
  //    begin
  //    if V_recAmb.Piano='' then delete;
  //    next;
  //    end;
  //  end;
  end;
//calcolo_L10;
//Aggiorna_Calc_reti;
//form1.RadioButton2.Checked:=true;
ridisegna;
//Run_Calcolo_estivo;
Aggiornaerrori;
end;

Procedure CaricaPiantasfondo;
var nomePia:string;
begin
form1.OpenDialog2.Execute;
if fileexists(form1.OpenDialog2.FileName) then
  begin
  nomepia:=extractfilename(Form1.Opendialog2.FileName);
  copyfile(pchar(Form1.Opendialog2.FileName),Pchar(perc_progcor+nomepia),false);
  dmtutti.T_Piani.Edit;
  V_recpia.Set_Rif_Pianta(nomepia);
  dmtutti.T_Piani.POst;
  end;
end;

Procedure modificapercorsodxf;
begin
form1.savedialog2.execute;
end;



Procedure Visual_prog;
begin
//Fprogsemp.Caption:='EsseDi energie alternative  ( '+progcor+' )';
Form1.Caption:='Projectbrowser 3d  ( '+progcor+' )';
perc_Progcor:=extractfilepath(progcor);
perc_Progcor:=i_sl(perc_Progcor);
end;

Procedure Visual_percdxf;
Var ft:textfile;

begin
if fileexists(percorsoDrive+'\percdxf.txt') then
  begin
  assign(ft,percorsoDrive+'\percdxf.txt');
  reset(ft);
  readln(ft,ndxf);
  close(ft);
  end
else ndxf:=extractfilepath(application.ExeName)+'disegno.dxf';
Form1.memo2.lines.clear;
Form1.memo2.lines.Add(ndxf);
end;

Procedure set_percdxf(percdxf:string);
Var ft:textfile;

begin
assign(ft,percorsoDrive+'\percdxf.txt');
rewrite(ft);
writeln(ft,percdxf);
close(ft);
end;

Procedure Inportadxf(agg3d,archivi,leggient:boolean);
Var ndxf1:string;
begin
AzzeraDXf;
ndxf1:=ndxf;
if agg_visual then
  begin
  ndxf1:=extractfilepath(ndxf);
  ndxf1:=I_sl(ndxf1)+'copiadxf.dxf';
  copyfile(pchar(ndxf),pchar(ndxf1),false);
  end;
Input_dxf(ndxf1,false);
CaricaInputDXF(archivi,leggient,true);
if agg3d then
  begin
  Aggiornaerrori;
  Apri_piano;
  end;
end;
Procedure EsportaDXF;
begin
//Leggi_Entita(dmtutti.T_Entita,dmtutti.T_Attributi,dmtutti.ds_Entita);
//NEntita:=0;
AzzeraDXf;
InitSimbDXF;
AzzeraDXf;
Leggi_Strutture(dmtutti.T_Strutture,dmtutti.T_strati,dmtutti.ds_Strutture);
Leggi_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
Leggi_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
Leggi_Impianti(dmtutti.T_Impianti,dmtutti.T_Impianti,dmtutti.ds_Impianti);
Leggi_Confine(dmtutti.T_Confine,dmtutti.T_Confine,dmtutti.ds_Confine);
if form1.Pagecontrol24.ActivePageIndex=0 then
dxf_origine(V_recconfcad.PIANOCOR,'EDIFICIO',form1.cbsfondo.checked)
else dxf_origine(V_recconfcad.PIANOCOR,'RETE',form1.cbsfondo.checked);
if form1.Pagecontrol24.ActivePageIndex=0 then DxfEdificio(V_recconfcad.PIANOCOR);
if form1.Pagecontrol24.ActivePageIndex=1 then DXFRete(V_recconfcad.ColoreTipoReteIRR,V_recconfcad.PIANOCOR);
output_dxf(ndxf);
end;

Procedure cambia_Progetto(nprogetto:string);
Var ft:textfile;
begin
assign(ft,percorsoDrive+'\nomeprog.txt');
rewrite(ft);
writeln(ft,nprogetto);
close(ft);
progcor:=Nprogetto;
Visual_prog;
Salva_var('PROGETTOCORRENTE',Nprogetto);
end;


Function nuovo_progetto(chiedipiani:boolean):boolean;
Var progsel:string;
begin
result:=true;
//progsel:=dialogNuovoprogetto;
//if  progsel='' then exit;
//copyfile(pchar(percorsodrive+'\prototipo.dxf'),pchar(percorsodrive+'\disegno.dxf'),false);
//copyfile(pchar(percorsodrive+'\prototipo.dwg'),pchar(percorsodrive+'\disegno.dwg'),false);
//Fpannelloclima.Chiuditabelle;
Cancellafiletemporanei;
//copiaprototipo;
//CancellaFileCartellaO(Percorso_progetti);
//CloseUdbT;
nocambia:=true;
NuovoUdbT;

if fileexists(I_sl(Percorsodrive)+'prototipi\consumi\consumi.cct') then
ApriTxtUDBT(Percorso_progetti,I_sl(Percorsodrive)+'prototipi\consumi\consumi.cct');
OpenUDBT;
if chiedipiani then
  begin
  If V_recconfcad.PIANOCOR='' then gestpiani3d;
  If V_recconfcad.PIANOCOR='' then
    begin
    result:=false;
    exit;
    end;
  end;
nocambia:=true;
//NuovoTxt(pchar(percorso_progetti));
EseguiMenu('NUOVOFABBRICATO');
deletefile(percorso_progetti+'\nomeprog.txt');
//Cambia_progetto(Progsel);
SaveUdBT(Progcor);
OpenUdbt;
//Fpannelloclima.apritabelle;
//Fpannelloclima.InitCadParete('','','');
deletefile(Percorsodrive+'\disegno.wmf');
deletefile(Percorsodrive+'\disegno.Txt');
deletefile(percorsodrive+'\errori input edificio.txt');
Progettovuoto;//Grafica
AggiornaErrori;
form1.display(false);
ridisegna;
//Fpannelloclima.aggiornaform;
//initcbpiano;
//scriptstoploop;
//eseguiautocad;
nocambia:=false;
Aggiornacontrols;
cambiaprogetto(Progcor);
end;



Procedure cambiaProgetto(nprogetto:string);
Var ft:textfile;
begin
assign(ft,percorsoDrive+'\nomeprog.txt');
rewrite(ft);
writeln(ft,nprogetto);
close(ft);
progcor:=Nprogetto;
Visual_prog;
salva_var('PROGETTOCORRENTE',nprogetto);
end;


Function Apri_progetto(prg_cor:string;mem:boolean):boolean;
var Pathprog,nomeprog,path2,sss,vecchiopp,nome,perc,ss:string;
    ff:file;
    inport:boolean;
    //opendialog1:topendialog;
begin
result:=true;
//opendialog1:=TOpendialog.Create(nil);
//Fpannelloclima.chiuditabelle;
vecchiopp:=progcor;
if (prg_cor='')or(ProgInport<>'') then
  begin
  //Form1.Opendialog1.initialdir:=libreriagenerale.percorsodrive+'\esempi';
  //Form1.Opendialog1.Execute;
  if ProgInport='' then // inport da bm
  Form1.Opendialog1.FileName:=dialogApriprogetto
  else Form1.Opendialog1.FileName:=prg_cor;
  if (Form1.Opendialog1.FileName<>'') then
    begin
    nome:=extractfilename(Form1.Opendialog1.FileName);
    nome:=copy(nome,1,length(nome)-4);
    perc:=extractfilePath(Form1.Opendialog1.FileName);
    perc:=I_sl(perc);
    if fileexists(perc+'Work_'+Nome+'\Disegno.txt') then
      begin
      if ProgInport='' then // inport da bm
         begin
         showmessage('Inportazione di un progetto CPIWINCLIMA Versione 14 :verrà creato un nuovo progetto su cui trasferire i dati.');
         ss:=dialognuovoprogetto;
         end
      else ss:=ProgInport;
      Setta_progetto(ss);
      if ss<>'' then
        begin
        Nuovo_progetto(false);
        copyfile(Pchar(perc+'Work_'+Nome+'\Disegno.txt'),pchar(percorsodrive+'\disegno.txt'),false);
        copyfile(Pchar(perc+'Work_'+Nome+'\tubi.txt'),pchar(percorsodrive+'\tubi.txt'),false);
        nocambia:=true;
        inport:=true;
        ApriTxtUDBT(Percorso_progetti,Form1.Opendialog1.FileName);
        Leggi_archivi_lettura(false);
        NPiani:=0;
        AggiornaProgetto(inport,false);
        Salva_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
        salva_archivi_lettura;
        {$IfNdef DLLBM}
        crea_immaginiPareti;
        crea_immaginifinestre;
        {$endif}
        AggiornaControls;
        script_Parete;
        nocambia:=false;
        form1.display(true);
        exit;
        end
      else
        begin
        result:=false;
        exit;
        end;
      end
    else cambiaprogetto(Form1.Opendialog1.FileName);
    end
  else
    begin
    //Fpannelloclima.apritabelle;
    result:=false;
    exit;
    end;
  end
else
  begin
  cambiaprogetto(Prg_cor);
  Form1.Opendialog1.FileName:=progcor;
  end;
sss:=filecorretto(progcor);
if sss<>''  then
  begin
  //showmessage(sss);
  //showmessage('ppp');
  if not(fileexists(progcor))then
    begin
    Vecchiopp:=progcor;
    nome:=extractfilename(progcor);
    nome:=copy(nome,1,length(nome)-4);
    perc:=extractfilepath(progcor);
    perc:=I_sl(perc);
    createdir(perc+nome);
    Vecchiopp:=perc+nome+'\'+nome+copy(progcor,length(progcor)-3,4);
    Nuovo_Progetto(true);
    cambiaprogetto(Vecchiopp);
    SalvaProgetto(false);
    end
  else
    begin
    result:=false;
    cambiaprogetto(Vecchiopp);
    end;
  exit;
  end;
Progress_3d(-2,'Apertura progetto in corso (creazione database)');
ApriTxtUDBT(Percorso_progetti,progcor);
Progress_3d(1,'Apertura progetto in corso (cancellazione file temporanei)');
//OpenTxt(PChar(Percorso_progetti),pchar(progcor));
if fileexists(pchar(copy(Form1.Opendialog1.FileName,1,length(Form1.Opendialog1.FileName)-3)+'dwg')) then
  begin
  copyfile(pchar(copy(Form1.Opendialog1.FileName,1,length(Form1.Opendialog1.FileName)-3)+'dwg'),pchar(percorsodrive+'\disegno.dwg'),false);
  copyfile(pchar(percorsodrive+'\prototipo.dxf'),pchar(percorsodrive+'\disegno.dxf'),false);//elimina problema del mancato salvataggio  dwg
  end;
pathprog:=extractfilepath(Form1.Opendialog1.FileName);
nomeprog:=copy(extractfilename(Form1.Opendialog1.FileName),1,length(extractfilename(Form1.Opendialog1.FileName))-4);
Path2:=pathprog+'Work_'+Nomeprog+'\';

cancellafiletemporanei;

inport:=false;
{
if fileexists(pathprog+'\Disegno.txt') then
  begin
  copyfile(Pchar(pathprog+'\Disegno.txt'),pchar(percorsodrive+'\disegno.txt'),false);
  inport:=true;
  end;
if fileexists(pathprog+'\tubi.txt') then
  begin
  copyfile(Pchar(pathprog+'\tubi.txt'),pchar(percorsodrive+'\tubi.txt'),false);
  inport:=true;
  end;
if fileexists(path2+'Disegno.txt') then
  begin
  copyfile(Pchar(path2+'Disegno.txt'),pchar(percorsodrive+'\disegno.txt'),false);
  inport:=true;
  end;
if fileexists(path2+'Tubi.txt') then
  begin
  copyfile(Pchar(path2+'Tubi.txt'),pchar(percorsodrive+'\Tubi.txt'),false);
  inport:=true;
  //Aggiorna_Calc_reti;  momentaneamente
  end;
if fileexists(path2+'Datirelazione.ini') then
copyfile(Pchar(path2+'Datirelazione.ini'),pchar(percorsodrive+'\Datirelazione.ini'),false);
}
Progress_3d(3,'Apertura progetto in corso (estrazione dei disegni)');

if (not inport)and(not mem) then caricainputdxf(true,true,true);
//Fpannelloclima.apritabelle;

//opendialog1.Free;
prima_volta:=true;
if not mem then AggiornaProgetto(inport,true);
//AggiornaProgetto(true);
//form1.display(false);
form1.pagecontrol4.ActivePageIndex:=0;
//compilaform(form1.groupbox2,'ConfCad',dmtutti.ds_confcad);
Tubi_edif(1);
{$IfNdef DLLBM}
Aggiornacontrols;
prima_volta:=true;
ridisegna;
crea_immaginiPareti;
crea_immaginifinestre;
{$endif}
Progress_3d(-1,'Apertura progetto in corso');
end;

Procedure SalvaPOsProp;
begin
with form1 do
  begin
  if dllbm then exit;
  Salva_var('POSTOP_P',inttostr(top));
  Salva_var('POSLeft_P',inttostr(Left));
  end;
end;
Procedure SalvaPOsform;
Var tt:string;
begin
if form1.CBDoppio.Checked then tt:='TRUE'
else tt:='FALSE';
Salva_var('DOPPIO',tt);

with form1 do
//if cbdoppio.Checked then
  begin
  if ((edit_in_cad)and(not(dllbm)))or
     ((form1.Panel29.Visible)and(dllbm))  then
    begin
    if dllbm then exit;
    Salva_var('POSTOP_P',inttostr(top));
    Salva_var('POSLeft_P',inttostr(Left));
    end
  else
    begin
    Salva_var('POSTOP',inttostr(top));
    Salva_var('POSLeft',inttostr(Left));
    Salva_var('POSWidth',inttostr(Width));
    Salva_var('POSHeight',inttostr(Height));
    end
  end;
end;
Procedure POsiz_prop;
Var tmp:string;
begin
with form1 do
  begin
  tmp:=Leggi_var('POSTOP_P');
  if tmp<>'' then top:=strtoint(tmp);
  tmp:=Leggi_var('POSLeft_P');
  if tmp<>'' then Left:=strtoint(tmp);
  end;
end;
Procedure LeggiPOsform;
Var tmp:string;
begin
tmp:=leggi_Var('DOPPIO');
if tmp='TRUE' then form1.cbdoppio.Checked:=true
else  form1.cbdoppio.Checked:=false;
with form1 do
//if cbdoppio.Checked then
  begin
  windowState:=wsNormal;
  if (form1.Panel29.Visible)and(dllbm)  then
    begin
    tmp:=Leggi_var('POSTOP_P');
    if tmp<>'' then top:=strtoint(tmp);
    tmp:=Leggi_var('POSLeft_P');
    if tmp<>'' then Left:=strtoint(tmp);
    end
  else
    begin
    tmp:=Leggi_var('POSTOP');
    if tmp<>'' then top:=strtoint(tmp);
    tmp:=Leggi_var('POSLeft');
    if (tmp<>'')and(strtoint(tmp)<screen.DesktopWidth-50) then Left:=strtoint(tmp)
    else left:=0;
    //left:=930;
    tmp:=Leggi_var('POSWidth');
    if tmp<>'' then Width:=strtoint(tmp);
    tmp:=Leggi_var('POSHeight');
    if tmp<>'' then Height:=strtoint(tmp);
    end;
  end
//else  windowState:=wsMaximized;
end;


Procedure SalvaProgetto(conNome:boolean);
Var Perc,nome,sss:string;
begin
if (progcor<>senzanome)and(fileexists(progcor)) then
  begin
  perc:=extractfilepath(progcor);
  {$Ifndef dllbm}
  copyfile(pchar(progcor),pchar(i_sl(perc)+'Bak_'+eXtractfilename(progcor)),false);
  {$endif}
  end;
nocambia:=true;
with form1 do
  begin

 if (progcor=senzanome)or (connome) then
   begin
   savedialog1.initialdir:=libreriagenerale.percorsodrive+'\esempi';
   savedialog1.Execute;
   if savedialog1.FileName<>'' then
     begin
     nome:=extractfilename(savedialog1.FileName);
     nome:=copy(nome,1,length(nome)-4);
     perc:=extractfilepath(savedialog1.FileName);
     perc:=I_sl(perc);
     createdir(perc+nome);
     if progcor<>senzanome then copiaCartella(extractfilepath(progcor),perc+nome,extractfilename(progcor));
     cambiaprogetto(perc+nome+'\'+nome+'.bmt');
     end
   else exit;
   end;
// copyfile(pchar(percorsodrive+'\disegno.dwg'),pchar(copy(progcor,1,length(Progcor)-3)+'dwg'),false);
// SaveTxt(PChar(Percorso_progetti),pchar(progcor));
  AzzeraDxf;
  DxfEdificio('');
  Dxfrete('','');
  salva_entita(dmtutti.t_entita,dmtutti.T_attributi,dmtutti.ds_entita);
  PulisciLocali(true);
  SaveUdBT(Progcor);
  salva_var('ULTIMOPROGETTO',progcor);
 end;
nocambia:=false;

sss:=filesalvatocorretto(progcor);
if sss<>'' then
  begin
  showmessage(sss);
  perc:=extractfilepath(progcor);
  {$Ifndef dllbm}
  copyfile(pchar(i_sl(perc)+'Bak_'+eXtractfilename(progcor)),pchar(progcor),false);
  {$endif}
  end;
end;

Procedure ItemMenu(comm:string);
begin
//if comm='ARCHIVIOPARETI' then  Gest_Pareti3d;
//if comm='ARCHIVIOFINESTRE' then  Gest_Finestre3d;
if comm='IMPIANTI' then  Gest_Impianti3d;
if comm='ZONE' then  Gest_Zone3d;
if comm='GENERATORI' then  Gest_Generatori3d;
{if comm='PONTI'  then
      begin
      FPonti:=TFPonti.Create(nil);
      FPonti.ShowModal;
      FreeAndNil(FPonti);
      end;}
{$IfNdef usadll}
(*
Tabt:=False;
if comm='ARCHIVIOPARETI' then  AttivaMuri(Percorso_Progetti, Percorso_archivi,PercorsoDrive, Percorso_archivi);
if comm='ARCHIVIOFINESTRE' then  AttivaFinestre(Percorso_Progetti, Percorso_archivi,PercorsoDrive, Percorso_archivi);
if comm='CONFINE'  then
  begin
  FConfine:=TFconfine.Create(nil);
  FConfine.ShowModal;
  FreeAndNil(FConfine);
  end;
if comm='TIPIRETE'  then
      begin
        FTipirete:=TFTipirete.Create(nil);
        FTipirete.ShowModal;
        FreeAndNil(FTipiRete);
      end;

if comm='ZONE'  then
      begin
      Fzone:=TFzone.Create(nil);
      Fzone.ShowModal;
      FreeAndNil(FZone);
      end;
if comm='IMPIANTI'  then
  begin
  FImpianti:=TFimpianti.Create(nil);
  FImpianti.ShowModal;
  FreeAndNil(FImpianti);
  end;
if comm='STAMPE'  then
  begin
  FStampe:=TFstampe.Create(nil);
  FStampe.ShowModal;
  FreeAndNil(FStampe);
  end;
if comm='FABBRICATO'  then
  begin
  FDatifabbricato:=TFDatifabbricato.Create(nil);
  FDatifabbricato.ShowModal;
  FreeAndNil(FDatiFabbricato);
  end;
{
if comm=''  then
 begin
 end;
}

//if comm='NUOVOFABBRICATO'  then NuovoFabbricato;
if comm='ESTIVO'  then Run_estivo;
Tabt:=true;
*)
{$endif}
end;
Function no_slash(st:string):string;
begin
result:=st;
if st>'' then
if st[length(st)]='\' then result:=copy(st,1,length(st)-1);
end;
Procedure Esegui_Autocad(cerca:boolean);
begin
EseguiAutocad(cerca);
end;
Procedure Script_aggiorna;
begin
if edit_in_cad then scriptAggiorna;
end;
Procedure Script_Valvola;
begin
//ScriptValvola('','');
end;
Procedure Aggiornascript(nome:string);
begin
{$Ifdef dllbm}
exit;
{$Endif}
nome:=uppercase(nome);
//NO scriptloop;
//scriptCalcoli;
//scriptNuovo;
//scriptapri;
if (nome='')or (nome='COLLETTORE') then script_collettore;
if (nome='')or (nome='PARETE') then Script_Parete;
if (nome='') then ScriptProjectBRS;
if (nome='')or (nome='LOCALE') then Script_locale;
if (nome='')or (nome='TRATTO') then Script_Tubo;
if (nome='')or (nome='PONTE') then Script_Ponte;
if (nome='')or (nome='FINESTRA') then Script_finestra;
if (nome='')or (nome='TERMINALE') then Script_terminale;
if (nome='')or (nome='COMPONENTE') then Script_Valvola;
if (nome='')or (nome='IRETE')or (nome='RIMRETE')or (nome='RIPRETE') then Script_GESTRETE;
//ScriptNord('P1');
if (nome='') then Script_Aggiorna;
if (nome='') then Scriptsalva;
//ScriptPianta('0');
if (nome='')or (nome='ALLINEA') then ScriptAllinea('Edificio')
//ScriptPianta('0');

(*
//Procedure ScriptGestrete(Comando,piano,codice,l,nc,tc:string);
Script_Collettore;
Scriptedifon;
ScriptedifOFF;
ScriptTubiOFF;
ScriptDisTubiON;
ScriptInpTubiON;
*)
end;
{
Function POsizRigaFin(riga:string):boolean;
begin
result:=false;
with form1.tfinestre do
  begin
  Open;
  first;
  while (not eof)and(fields[4].asstring<>riga) do next;
  if  fields[4].asstring=riga then
    begin
    result:=true
    end;
  end;
end;
 }

Procedure ApritabFinestre;
Var pp:string;
begin
with form1 do
  begin
  dbimfinestre.Visible:=false;
  //if fileexists(percorso_progetti+'immaginif.db') then
  if V_recconfcad.Tipofinestra<>'' then
    begin
    //tfinestre.Open;
    pp:=percorso_progetti;
    //if posizRigafin(V_recconfcad.Tipofinestra) then
    if fileexists(I_sl(pp)+'Immagini_finestre\'+V_recconfcad.Tipofinestra+'.bmp') then
      begin
      dbimFinestre.Picture.LoadFromFile(I_sl(pp)+'Immagini_finestre\'+V_recconfcad.Tipofinestra+'.bmp');
      dbimFinestre.Visible:=true;
      end
    else
      begin
      dmtutti.T_ConfCad.Edit;
      v_recconfcad.set_Tipofinestra('');
      dmtutti.T_ConfCad.POst;
      dmtutti.T_ConfCad.Edit;
      end;
    end;
  end;
end;
procedure POsizConf(riga,tln:string);
Var i,ind,err:Integer;


begin
with dmtutti.T_Confine do
  begin
  form1.cbtlinea.text:='0:CONTINUOUS:(______)';
  first;
  i:=1;
  while (not eof)and(V_recconf.Codice<>riga) do begin next;inc(i) end;
  if V_recconf.Codice=riga then
    begin
    val(V_recconf.TLinea,ind,err);
    if (V_recconf.TLinea='')or(err<>0) then
      begin
      edit;
      V_recconf.set_TLinea(inttostr(i));
      Post;
      end;
    {
    if tln<>'' then
      begin
      edit;
      azzeraidentif;
      V_recconf.set_TLinea(leggiidentif1(tln));
      Post;
      end;
    }
    dmtutti.T_confcad.edit;
    V_recconfcad.set_TipoLineaParete(TlineaCad(strtoint(V_recconf.TLinea)));
    dmtutti.T_confcad.Post;
    dmtutti.T_confcad.edit;
    //form1.cbtlinea.text:=TlineaCad(strtoint(V_recconf.TLinea));//tl[strtoint(V_recconf.TLinea)+1].n;
    end;
 {
  for i:=1 to 6 do tl[i].v:=false;
  first;
  while (not eof)do
    begin
    val(fields[29].asstring,ind,err);
    if (ind<>0)and(err=0) then
    tl[ind+1].v:=true;
    next;
    end;
  if tln='' then
  for i:=2 to 6 do
  if not(tl[i].v) then form1.cbtlinea.Items.Add(tl[i].n);
  }
  end;

end;
procedure TLineaParete;
begin
//form1.cbTlinea.Items.Clear;
if (v_recconfcad.ConfineParete='')or(v_recconfcad.ConfineParete=confauto)then
form1.cbtlinea.Text:=tl[1].n
else POsizConf(v_recconfcad.ConfineParete,'');
end;
Procedure CambiaTlinea;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
PosizConf(v_recconfcad.ConfineParete,form1.cbtlinea.Text);
script_parete;
end;

Procedure Cambia_Zona;
begin
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
if (Uppercase(v_recconfcad.TipoZonaLoc)='SCALE')or
   (Uppercase(v_recconfcad.TipoZonaLoc)='GARAGES') then
   V_recconfcad.Set_ImpZonaLoc('NonRisc')
   else
     begin
     if V_recconfcad.ImpZonaLoc='NonRisc' then
     V_recconfcad.Set_ImpZonaLoc('Autonomo');
     end;
dmtutti.T_ConfCad.POst;
script_locale;
end;

Procedure CambiaConfine;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
TLineaParete;
Script_Parete;
end;
Procedure CambiatipoF;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
ApriTabfinestre;
Script_Finestra;
end;


function RestituisciNomeImmaginePT(Codice: String;Var descriz:string): String;
var
  Trovato: Boolean;
begin
 Result := '';
 Trovato := False;
 with dmtutti.T_POnti do
   begin
   First;
   while (not Eof) and (not Trovato) do
   begin
     if Codice = V_recponti.Codice then
     begin
       descriz:=  V_recponti.Denom;
       Result :=  V_recponti.Img;
       Trovato := True;
     end;
     Next;
   end;
 end;
end;

procedure CaricaImmaginePOnte(Codice: String);
var
  NomeFile, NomeImg,descriz: String;
begin
  NomeImg := RestituisciNomeImmaginePT(Codice,descriz);
  NomeFile := Percorso_Progetti + 'Immagini_Ponti_Termici\' + NomeImg;
  If FileExists(NomeFile) then
    begin
    form1.memo12.visible:=true;
    form1.memo12.Lines.Clear;
    form1.memo12.Lines.add(descriz);
    form1.dbImage1.Picture.LoadFromFile(NomeFile);
    form1.dbImage1.visible:=true;
    end
  else
    begin
    form1.memo12.visible:=false;
    form1.dbImage1.visible:=false;
    end;
end;

Procedure CambiaLponte;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
script_ponte;
end;

Procedure Cambiaponte;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
if V_recconfcad.LunghPonteTerm=0 then
V_recconfcad.set_LunghPonteTerm(2.7);
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
CaricaImmaginePOnte(V_recconfcad.TipoPontiTermici);
Script_ponte;
end;

Function Ind_CodPiano(cod:string):string;
var i:Integer;
begin
result:='';
if (cod='')or(Dmtutti.T_Piani.Eof) then exit;
cod:=uppercase(cod);
result:='';
with Dmtutti.T_Piani do
  begin
  open;
  first;
  if eof then
    begin
    append;
    POst;
    end;
  i:=1;
  while (not eof)and(uppercase(fieldbyname('Codice').Value)<>Cod) do
    begin
    inc(i);
    next;
    end;
  if uppercase(fieldbyname('Codice').Value)=Cod then
  result:='P'+fieldbyname('Indice').asstring;
  end;
end;

procedure script_finestra;
begin
if (nocambia)and(noscript) then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
ScriptFinestra({IndcodPiano(V_recconfcad.Pianocor)}'EDIFICIO',V_recconfcad.TipoFinestra,float_to_str(V_recconfcad.LarghFinestra,2),float_to_str(V_recconfcad.AltezFinestra,2),V_recconfcad.Lucernaio='SI',V_recconfcad.LucSpec='SI');
ScriptOggetto;
end;

procedure script_ponte;
begin
if (nocambia)and(noscript) then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
ScriptPonte('EDIFICIO',V_recconfcad.TipoPontiTermici,float_to_str(V_recconfcad.LunghPonteTerm,2));
ScriptOggetto;
end;

Procedure Script_parete;
begin
if (nocambia)and(noscript) then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
with form1 do
ScriptParete({IndcodPiano(V_recconfcad.Pianocor)}'EDIFICIO',CBColoreParete.Text,CbTLinea.Text);
ScriptOggetto;
end;
Procedure Script_tubo;
begin
if (nocambia)and(noscript) then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
with form1 do
Scripttubo({Ind_codPiano(V_recconfcad.Pianocor)}'RETE',V_recconfcad.ColoreTipoRete,'Continuous');
end;

Procedure Script_Terminale;
Var att:string;
begin
if (nocambia)and(noscript) then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
att:='D';
{
with form1 do
  begin
  if DBATTTERM.text<>'' then att:=DBATTTERM.text[1];
  if DBSimbTerm.text<>'' then
  ScriptTerminale(IndcodPiano(V_recconfcad.Pianocor),DBSimbTerm.text,att,EIncrpot.Text,Elargmax.Text,EPort.Text,EPot.text,Eperd.text,EMontaggio.text);
  end;
}
with v_recconfcad do
ScriptTerminale('',SimboloTerm,AttaccoTerm,float_to_str(IncrPotenza,2),float_to_str(IngombroMax,2),float_to_str(PortataIndip,2),float_to_str(PotenzaIndip,2),float_to_str(PerdCarIndip,2),MontaggTerm,Serieterm,FissaSerieterm,Modelloterm,FissaModelloterm);

end;

Procedure Script_Locale;
Var desca:string;
begin
if (nocambia)and(noscript) then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
desca:=V_recconfcad.DescrAmb;
if (not dllbm)and(form1.EAlloggio.Text<>'')and(pos('CENTRALIZZATO',upstring(form1.EAlloggio.Text))=0) then
desca:=form1.EAlloggio.Text+':'+desca;
with V_recconfcad do
Scriptlocale(desca,(Pianocor),TipoZonaLoc,ImpZonaLoc,TipoPavLoc,ConfPavLoc,TipoSoffLoc,ConfSoffLoc,CalcoloTemp,TIPOBXSCELTO,Altezza,Tinv,Test,Fconv,Ricaria,Appgra);
ScriptOggetto;
end;

Procedure Script_Collettore;
begin
if (nocambia)and(noscript) then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
ScriptCollettore('',float_tostr(v_recconfcad.NUsciteCollettore),v_recconfcad.AttaccoCollettore[1],v_recconfcad.ColoreTipoRete);
end;

Procedure Script_Gestrete;
Var pref:string;
begin
if (nocambia)and(noscript) then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
with form1 do
  begin
  pref:='D';
  if  V_recconfcad.TipoAttaccoIRR<>'' then
  pref:=V_recconfcad.TipoAttaccoIRR[1];
  ScriptGestrete('Irete'+pref,'Irete',CBTiporete.text,IndcodPiano(V_recconfcad.Pianocor)+'_TUBI',V_recconfcad.ColoreTipoReteIRR,'','','');
  ScriptGestrete('RIprete'+'S'{+pref},'RIPrete',CBTiporete.text,IndcodPiano(V_recconfcad.Pianocor)+'_TUBISIMB',V_recconfcad.ColoreTipoReteIRR,'','','');
  ScriptGestrete('Rimrete'+'S'{+pref},'Rimrete',CBTiporete.text,IndcodPiano(V_recconfcad.Pianocor)+'_TUBISIMB',V_recconfcad.CodRete,ELungtubo.text,ENumcurve.text,CBPerdloc.text);
  end;
end;


Procedure EseguiMenu(Item:string);
begin
 //chiuditabelle;
 Item:=UpperCase(Item);
 ItemMenu(pchar(Item));
 //ApriTabelle;
 //aggiornaForm;
end;

Procedure settacolorePar;
begin
with dmtutti.T_strutture do
  begin
  first;
  while (not eof)and(V_Tabstruttura.NFile<>V_recconfcad.TipoParete) do next;
  dmtutti.T_confcad.edit;
  V_recconfcad.set_ColoreParete(V_Tabstruttura.ColCAD);
  dmtutti.T_confcad.POst;
  dmtutti.T_confcad.edit;
  end;
end;
Procedure settacoloreTubo;
begin
with dmtutti.T_TipiRete do
  begin
  first;
  while (not eof)and(V_RecTipiRete.Cod<>V_recconfcad.CarCostruttRete) do next;
  dmtutti.T_confcad.edit;
  V_recconfcad.set_ColoreTipoRete(V_RecTipiRete.colore);
  dmtutti.T_confcad.POst;
  dmtutti.T_confcad.edit;
  end;
end;


Procedure Setta_colore(Modo:integer);
Var Table2:TTable;
     i,campo,Campocod:integer;
     Nomedb,SetCod:string;
     Var CBox:Tcombobox ;
begin
Table2:=TTable.Create(nil);
if modo=1 then
  begin  //Pareti
  nomedb:='strutture.db';
  //Cbox:=form1.cbcoloreParete;
  Campo:=3;
  CampoCod:=1;
  SetCod:=V_recconfcad.TipoParete;
  end
else
  begin  //Tipirete
  nomedb:='tipirete.db';
  //Cbox:=form1.cbcoloreTubo;
  Campo:=14;
  CampoCod:=1;
  SetCod:=V_recconfcad.CarCostruttRete;
  end;

with table2 do
  begin
  close;
  databasename:=percorso_progetti;
  tablename:=nomedb;
  open;
  initcolori;
  first;
  while not eof do
    begin
    arcolori[indcolore(fields[Campo].asstring)]:=true;
    next;
    end;
  cbox.Items.clear;
  for i:=1 to 50 do
  if not(arcolori[i]) then
  cbox.Items.Add(colore_cad(i));
  first;
  while (not eof)and(uppercase(SetCod)<>uppercase(fields[CampoCod].asstring)) do
  next;
  CBox.text:=fields[Campo].asstring;
  close;
  end;
Table2.free;
end;




Function POsiz_Riga(riga:string):boolean;
begin
//result:=false;
settacolorePar;
{
with form1.tPareti do
  begin
  Open;
  first;
  while (not eof)and(fields[4].asstring<>riga) do next;
  if  fields[4].asstring=riga then
    begin
    result:=true;
    settacolorePar;
    //setta_colore(1);
    //aggiornaTabcolori;
    end;
  end;
}
end;



Procedure ApritabPareti(var Img:TdbImage);
var perc:string;
begin
with Form1  do
  begin
  dbconfineparete.Visible:=true;
  //speedButton3.Visible:=true;
  label36.Visible:=true;
  label34.Visible:=true;
  cbcoloreparete.visible:=true;
  memo4.Visible:=false;
  Img.Visible:=false;
  if uppercase(V_recconfcad.TipoParete)='FITTIZIA' then
    begin
    memo4.lines.Clear;
    memo4.lines.Add('Parete virtuale che viene inserita per creare una suddivisione fittizia in un locale , al fine di potere inserire dei confini differenti per pavimeto e soffitto nelle due suddivisioni.In fase di calcolo i due locali verranno riunificati .');
    memo4.Visible:=true;
    label36.Visible:=false;
    label34.Visible:=false;
    dbconfineparete.Visible:=False;
    //speedButton3.Visible:=false;
    dmtutti.T_ConfCad.Edit;
    nocambia:=true;
    V_recconfcad.Set_ColoreParete('Rosso');
    cbcoloreparete.Text:='Rosso';
    cbcoloreparete.visible:=false;
    V_recconfcad.set_confineParete('Non Sc');
    V_recconfcad.Set_TipoLineaParete('FITTIZIA'{tl[2].n});
    //cbtlinea.Text:='FITTIZIA'{tl[2].n};
    dmtutti.T_ConfCad.POst;
    dmtutti.T_ConfCad.Edit;
    nocambia:=false;
    exit;
    end
  else
    begin
    dmtutti.T_ConfCad.Edit;
    V_recconfcad.set_confineParete('Autorilevato');
    V_recconfcad.Set_TipoLineaParete('0:CONTINUOUS:(__)');
    dmtutti.T_ConfCad.POst;
    dmtutti.T_ConfCad.Edit;
    settacolorePar;
    end;
  perc:=percorso_progetti;
  perc:=I_sl(perc)+'Immagini_Pareti\'+V_recconfcad.TipoParete+'.bmp';
  //if fileexists(percorso_progetti+'immagini.db') then
  if V_recconfcad.TipoParete<>'' then
  if fileexists(Perc) then
    begin
    //if posiz_Riga(V_recconfcad.TipoParete) then
    img.Picture.LoadFromFile(perc);
    img.Visible:=true;
    {else
      begin
      dmtutti.T_ConfCad.Edit;
      v_recconfcad.set_TipoParete('');
      dmtutti.T_ConfCad.POst;
      dmtutti.T_ConfCad.Edit;
      end;}
    end;
  end;
end;

Procedure Cambiatipopar;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
ApriTabPareti(form1.dbimpareti);
Script_Parete;
end;
Procedure CambiatipoTubo;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
Settacoloretubo;
Script_tubo;
end;


Procedure Combocolori;
Var i:integer;
begin
form1.CBCOLOREPARETE.Items.Clear;
for i:=1 to numcolori do
form1.CBCOLOREPARETE.Items.Add(colore_cad(i));
end;



Procedure CambiacolorePar;
var nuovocol:string;
    i:integer;

begin
 {
with form1 do
  begin

  nuovocol:=V_recconfcad.ColoreParete;
  with dmtutti.T_strutture do
    begin
    for i:=1 to numcolori do arcolori[i]:=false;
    first;
    while not eof do
      begin
      if Uppercase(V_TabStruttura.Categoria)='OPACO' then
      if Uppercase(V_TabStruttura.Parsof)='PARETE' then
      arcolori[indcolore(V_TabStruttura.ColCAD)]:=true;
      next;
      end;
    if arcolori[indcolore(Nuovocol)]then nuovocol:=nuovocolore;
    first;
    while (not eof)and(Uppercase(v_recconfcad.TipoParete)<>uppercase(V_TabStruttura.NFile)) do next;
    edit;
    dmtutti.T_confcad.Edit;
    V_recconfcad.set_ColoreParete(V_TabStruttura.ColCAD);
    if indcolore(V_recconfcad.ColoreParete)=0 then
      begin
      V_recconfcad.set_ColoreParete(nuovocolore);
      V_TabStruttura.set_ColCAD(V_recconfcad.ColoreParete);
      end;
    dmtutti.T_strutture.post;
    dmtutti.T_confcad.POst;
    dmtutti.T_confcad.Edit;

   first;
   while (not eof)and(Uppercase(v_recconfcad.TipoParete)<>uppercase(V_TabStruttura.NFile)) do next;
   edit;
   dmtutti.T_strutture.edit;
   dmtutti.T_strutture.post;
   dmtutti.T_strutture.edit;
   end;

  end;
 }
end;

Function Doppionicolori:string;
Var i:integer;
    nuovocol,colcor,codcor:string;
begin
result:='';
for i:=1 to numcolori do arcolori[i]:=false;
for i:=1 to numcolori do arcolori2[i]:=false;
with dmtutti do
  begin
  T_strutture.First;
  while not T_strutture.eof do
    begin
    if Uppercase(V_TabStruttura.Categoria)='OPACO' then
    if Uppercase(V_TabStruttura.Parsof)='PARETE' then
    arcolori[indcolore(V_TabStruttura.ColCAD)]:=true;
    t_strutture.Next
    end;
  T_strutture.First;
  while not T_strutture.eof do
    begin
    if Uppercase(V_TabStruttura.Categoria)='OPACO' then
    if Uppercase(V_TabStruttura.Parsof)='PARETE' then
      begin
      if arcolori2[indcolore(V_TabStruttura.ColCAD)] then
        begin
        colcor:=V_TabStruttura.ColCAD;
        codcor:=V_TabStruttura.NFile;
        nuovocol:=nuovocolore;
        if V_recconfcad.TipoParete=V_TabStruttura.NFile then
          begin
          T_strutture.First;
          while (not T_strutture.eof)and(codcor<>V_TabStruttura.NFile) do
            begin
            if Uppercase(V_TabStruttura.Categoria)='OPACO' then
            if Uppercase(V_TabStruttura.Parsof)='PARETE' then
            if colcor=V_TabStruttura.ColCAD then
              begin
              result:='Il colore '+V_TabStruttura.ColCAD+' è stato assegnato a due pareti , il colore della parete '+V_TabStruttura.NFile+' è stato riassegnato a '+nuovocol;
              t_strutture.edit;
              V_TabStruttura.set_ColCAD(nuovocol);
              t_strutture.POst;
              end;
            T_strutture.Next;
            end
          end
        else
          begin
          result:='Il colore '+V_TabStruttura.ColCAD+' è stato assegnato a due pareti , il colore della parete '+V_TabStruttura.NFile+' è stato riassegnato a '+nuovocol;
          t_strutture.edit;
          V_TabStruttura.set_ColCAD(nuovocol);
          t_strutture.POst;
          end;
        end;
      arcolori2[indcolore(V_TabStruttura.ColCAD)]:=true;
      end;
    t_strutture.Next
    end;
  end;
end;

Function VerificaDoppionicolori(cambiacolore:string):string;
Var i:integer;
    nuovocol:string;
begin
result:='';
if V_recconfcad.ColoreParete=Cambiacolore then exit;

for i:=1 to numcolori do arcolori[i]:=false;
with dmtutti do
  begin
  T_strutture.First;
  while not T_strutture.eof do
    begin
    if Uppercase(V_TabStruttura.Categoria)='OPACO' then
    if Uppercase(V_TabStruttura.Parsof)='PARETE' then
    arcolori[indcolore(V_TabStruttura.ColCAD)]:=true;
    t_strutture.Next
    end;
  T_strutture.First;
  while not T_strutture.eof do
    begin
    if Uppercase(V_TabStruttura.Categoria)='OPACO' then
    if Uppercase(V_TabStruttura.Parsof)='PARETE' then
    if V_recconfcad.TipoParete<>V_TabStruttura.NFile then
    if indcolore(cambiacolore)=indcolore(V_TabStruttura.ColCAD) then
    result:='Il colore '+Cambiacolore+' è stato già stato assegnato alla parete '+V_TabStruttura.ColCAD;
    t_strutture.Next
    end;
  end;
end;


Procedure Aggiorna_Tabcolori_tubi;
Var i:integer;
    nuovocol,salvacod,salvacol,colcor,codcor:string;
begin
with form1 do
  begin
  dmtutti.ds_ConfCad.Enabled:=false;
  dmtutti.T_ConfCad.Edit;
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.Edit;
  salvacod:=V_recconfcad.CarCostruttRete;
  salvacol:=V_recconfcad.ColoreTipoRete;
  cbcoloretubo.Items.clear;
  for i:=1 to numcolori do
    begin
    cbcoloretubo.Items.Add(colore_cad(i));
    arcolori[i]:=false;
    end;
  memo13.lines.Clear;
  dmtutti.T_tipirete.first;
  while not dmtutti.T_tipirete.eof do
    begin
    if (V_RecTipiRete.cod<>'')and(V_RecTipiRete.colore<>'') then
      begin
      codcor:=V_RecTipiRete.cod;
      colcor:=V_RecTipiRete.colore;
      if salvacod=V_RecTipiRete.cod then colcor:=salvacol;

      //if arcolori[indcolore(colcor)]then
      //showmessage('Due pareti hanno lo stesso colore
      //colcor:=nuovocolore;

      dmtutti.T_tipirete.Edit;
      V_RecTipiRete.set_colore(colcor);
      dmtutti.T_tipirete.Post;

      arcolori[indcolore(colcor)]:=true;
      form1.memo13.lines.Add(setlung(V_RecTipiRete.cod,12)+':'+colcor);
      end;
    dmtutti.T_tipirete.next;
    end;
  dmtutti.T_tipirete.first;
  while not dmtutti.T_tipirete.eof do
    begin
    if (V_RecTipiRete.cod<>'')and(V_RecTipiRete.colore='') then
      begin
      dmtutti.T_tipirete.Edit;
      V_RecTipiRete.set_colore(Nuovocolore);
      dmtutti.T_tipirete.Post;
      form1.memo13.lines.Add(setlung(V_RecTipiRete.cod,12)+':'+V_RecTipiRete.colore);
      end;
    dmtutti.T_tipirete.next;
    end;
  //form1.CBCOLOREPARETE.Items.Clear;
  //form1.CBCOLOREPARETE.Items.Add(salvacol);
  //for i:=1 to numcolori do
  //if not (arcolori[i]) then form1.CBCOLOREPARETE.Items.Add(colore_cad(i));
  //per annullare l'effetto di items.clear
  dmtutti.T_ConfCad.Edit;
  V_recconfcad.Set_CarCostruttRete(salvacod);
  V_recconfcad.Set_ColoreTipoRete(salvacol);
  form1.CBCOLORETubo.Refresh;
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.Edit;
  dmtutti.ds_ConfCad.Enabled:=true;
  end;

end;

Procedure AggiornaTabcolori_tubi;
Var doppiocol:string;
begin
Aggiorna_Tabcolori_tubi;
{
doppiocol:=doppionicolori;
if doppiocol<>'' then
  begin
  showmessage(doppiocol);
  Aggiorna_Tabcolori;
  end;
ridisegna;
}
end;

Procedure Aggiorna_Tabcolori;
Var i:integer;
    nuovocol,salvacod,salvacol,colcor,codcor:string;
begin
with form1 do
  begin
  dmtutti.ds_ConfCad.Enabled:=false;
  dbtipoparete.Items.clear;
  dmtutti.T_ConfCad.Edit;
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.Edit;
  salvacod:=V_recconfcad.TipoParete;
  salvacol:=V_recconfcad.ColoreParete;
  for i:=1 to numcolori do arcolori[i]:=false;
  dbtipoparete.Items.Clear;
  dbtipoparete.Items.add('Fittizia');
  memo10.lines.Clear;
  dmtutti.T_strutture.first;
  while not dmtutti.T_strutture.eof do
    begin
    if V_TabStruttura.NFile<>'' then
    if Uppercase(V_TabStruttura.Categoria)='OPACO' then
    if Uppercase(V_TabStruttura.Parsof)='PARETE' then
    //form1.ValueListEditor1.InsertRow('Parete',V_TabStruttura.ColCAD,true);
      begin
      codcor:=V_TabStruttura.NFile;
      colcor:=V_TabStruttura.ColCAD;
      if salvacod=V_TabStruttura.NFile then colcor:=salvacol;

      //if arcolori[indcolore(colcor)]then
      //showmessage('Due pareti hanno lo stesso colore
      //colcor:=nuovocolore;

      dmtutti.T_strutture.Edit;
      V_TabStruttura.set_ColCAD(colcor);
      dmtutti.T_strutture.Post;

      arcolori[indcolore(colcor)]:=true;
      form1.memo10.lines.Add(setlung(V_TabStruttura.NFile,12)+':'+colcor);
      dbtipoparete.Items.add(V_TabStruttura.NFile);
      end;
    dmtutti.T_strutture.next;
    end;
  //form1.CBCOLOREPARETE.Items.Clear;
  //form1.CBCOLOREPARETE.Items.Add(salvacol);
  //for i:=1 to numcolori do
  //if not (arcolori[i]) then form1.CBCOLOREPARETE.Items.Add(colore_cad(i));
  //per annullare l'effetto di items.clear
  dmtutti.T_ConfCad.Edit;
  V_recconfcad.Set_TipoParete(salvacod);
  V_recconfcad.Set_ColoreParete(salvacol);
  form1.CBCOLOREPARETE.Refresh;
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.Edit;
  dmtutti.ds_ConfCad.Enabled:=true;
  end;

end;
Procedure AggiornaTabcolori;
Var doppiocol:string;
begin
Aggiorna_Tabcolori;
doppiocol:=doppionicolori;
if doppiocol<>'' then
  begin
  showmessage(doppiocol);
  Aggiorna_Tabcolori;
  end;
ridisegna;
end;

function ConfineParete(tipo:string):boolean;
begin
result:=(tipo<>'PARETE INCLINATA')and(tipo<>'TERRENO');
end;

Procedure Aggiorna_Tabconfini;
Var i:integer;
    nuovocol,salvacod,salvacol{,colcor,codcor}:string;
begin
with form1 do
  begin
  dmtutti.T_ConfCad.Edit;
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.Edit;
  salvacod:=V_recconfcad.ConfineParete;
  salvacol:=V_recconfcad.TipoLineaParete;
  for i:=1 to numcolori do
    begin
    arcolori[i]:=false;
    arcolori2[i]:=false;
    end;
  dbconfineparete.Items.Clear;
  dbconfineparete.Items.add('Autorilevato');
  memo11.lines.Clear;
  dmtutti.T_confine.first;
  while not dmtutti.T_confine.eof do
    begin
    if V_RecConf.Codice<>'' then
    if confineparete(V_RecConf.Tipoconfine) then
    if NumValido(V_RecConf.Tlinea)then
    if strtoint(V_RecConf.Tlinea)<>-1 then
    arcolori[strtoint(V_RecConf.Tlinea)]:=true;
    dmtutti.T_confine.next;
    end;
  dmtutti.T_confine.first;
  while not dmtutti.T_confine.eof do
    begin
    if V_RecConf.Codice<>'' then
    if confineparete(V_RecConf.Tipoconfine) then
      begin
      //codcor:=V_RecConf.Codice;
      //colcor:=V_RecConf.Tlinea;
      //if salvacod=V_RecConf.Codice then colcor:=salvacol;

      if (not(NumValido(V_RecConf.Tlinea)))or(strtoint(V_RecConf.Tlinea)<=0)or(arcolori2[strtoint(V_RecConf.Tlinea)]) then
        begin
        dmtutti.T_confine.Edit;
        V_RecConf.set_Tlinea(IntTostr(nuovoIndcolore));
        dmtutti.T_confine.Post;
        end;
      form1.memo11.lines.Add(setlung(V_RecConf.Codice,12)+':'+TlineaCad(strtoint(V_RecConf.Tlinea)));
      dbconfineparete.Items.add(V_RecConf.Codice);
      arcolori2[strtoint(V_RecConf.Tlinea)]:=true;
      end;
    dmtutti.T_confine.next;
    end;
  //form1.CBCOLOREPARETE.Items.Clear;
  //form1.CBCOLOREPARETE.Items.Add(salvacol);
  //for i:=1 to numcolori do
  //if not (arcolori[i]) then form1.CBCOLOREPARETE.Items.Add(colore_cad(i));
  //per annullare l'effetto di items.clear

  //dmtutti.T_ConfCad.Edit;
  //V_recconfcad.Set_TipoParete(salvacod);
  //V_recconfcad.Set_ColoreParete(salvacol);
  //form1.CBCOLOREPARETE.Refresh;
  //dmtutti.T_ConfCad.POst;
  //dmtutti.T_ConfCad.Edit;
  end;

end;
Procedure AggiornaTabConfini;
begin
Aggiorna_TabConfini;
end;


Procedure CambiaColoreTubo;
begin
if nocambia then exit;
dmtutti.T_ConfCad.Edit;
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
//CambiacoloreTubi(2);
Script_Tubo;
end;

Procedure CambiacoloreParete;
begin
if nocambia then exit;
CambiacolorePar;
Aggiornatabcolori;
script_parete;
end;

Procedure Init_cad_3d(tipo,tipof,conf:string);
begin
{$ifNdef dllbm}
Aggiornascript('');
{$Endif}
end;
{ TODO -oDiego -cNavigazione : Personalizzazione pannello clima nel 3D }
Procedure Caricadis_tubi;
begin
Caricadistubi(V_recconfcad.ColoreTipoReteIRR,V_recconfcad.PIANOCOR,true);
rete_precedente:=V_recconfcad.ColoreTipoReteIRR;
end;

Procedure Apri_piano;
begin
//Salvapiano_precedente;
ItemSelEdif:=0;
form1.edit12.Text:='';
Apripiano(Form1.RadioButton1.Checked,Form1.DBCombobox1.text);
end;

Procedure AggiornaProgetto(leggipiante,rinumera:boolean);
begin
if leggipiante then
  begin
  CancellafileTemporaneiEdificio;
  leggidisegni(PercorsoDrive,rinumera);
  if fileexists(I_sl(PercorsoDrive) +'Tubi.txt')then
    begin
    Aggiorna_Calc_reti_BM;
    deletefile(I_sl(PercorsoDrive) +'Tubi.txt');
    end;
  end;
Apri_piano;
ridisegna;
//form1.display(false);
Visual_percdxf;
AggiornaErrori;
end;

Procedure AggiornaControls;
begin
nocambia:=true;
compilaform(Form1.groupbox56,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gb2d,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.groupbox6,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.groupbox2,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gbpareti,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gbpontitermici,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gbfinestre,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gblocali,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gbValvole,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gbTerminali,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gbDatiTerm1,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gbDatiterm2,'ConfCad',dmtutti.ds_confcad);
compilaform(form1.gbtiporete,'ConfCad',dmtutti.ds_confcad);//Tipo rete
compilaform(form1.groupbox57,'ConfCad',dmtutti.ds_confcad);//Tipo rete
compilaGriglia(form1.dbgrid1,'Pareti',dmtutti.ds_pareti);
compilaGriglia(form1.dbgrid2,'Locali',dmtutti.ds_Locali);
compilaform(form1.groupbox11,'Locali',dmtutti.ds_Locali);
compilaform(form1.groupbox12,'Locali',dmtutti.ds_Locali);
compilaform(form1.groupbox13,'Locali',dmtutti.ds_Locali);
compilaform(form1.groupbox4,'Locali',dmtutti.ds_Locali);
compilaform(form1.groupbox35,'Locali',dmtutti.ds_Locali);
compilaGriglia(form1.dbgrid3,'Carburanti',dmtutti.ds_Carburanti);
compilaGriglia(form1.dbgrid4,'Generatori',dmtutti.ds_Generatori);
//compilaGriglia(form1.dbgrid10,'Interventi',dmtutti.ds_Interventi);
//compilaform(form1.groupbox30,'Interventi',dmtutti.ds_Interventi);
//compilaform(form1.groupbox32,'Interventi',dmtutti.ds_Interventi);
//compilaform(form1.groupbox33,'Interventi',dmtutti.ds_Interventi);
compilaGriglia(form1.dbgrid5,'Entita',dmtutti.ds_Entita);//provvisorio
compilaGriglia(form1.dbgrid6,'Attributi',dmtutti.ds_Attributi);//provvisorio
compilaGriglia(form1.dbgrid7,'Piani',dmtutti.ds_Piani);
compilaform(form1.groupbox23,'Piani',dmtutti.ds_PIani);
form1.dbnavigator2.datasource:=dmtutti.ds_piani;
compilaGriglia(form1.dbgrid8,'Zone',dmtutti.ds_Zone);
compilaform(form1.groupbox26,'Zone',dmtutti.ds_Zone);
form1.dbnavigator3.datasource:=dmtutti.ds_Zone;
compilaGriglia(form1.dbgrid9,'Impianti',dmtutti.ds_Impianti);
compilaform(form1.groupbox28,'Impianti',dmtutti.ds_Impianti);
form1.dbnavigator4.datasource:=dmtutti.ds_Impianti;
compilaGriglia(form1.dbgrid11,'Reti',dmtutti.ds_Reti);
compilaform(form1.groupbox5,'Reti',dmtutti.ds_Reti);
compilaform(form1.GBConsumiRisc,'Risparmio',dmtutti.ds_Risparmio);
form1.dbnavigator5.datasource:=dmtutti.ds_Reti;
compilaGriglia(form1.dbgrid12,'Pareti',dmtutti.ds_Pareti);
compilaGriglia(form1.dbgridGeneratori,'Generatori',dmtutti.ds_Generatori);
form1.dbnGeneratori.datasource:=dmtutti.ds_Generatori;
compilaform(form1.GB_dimens,'Generatori',dmtutti.ds_Generatori);
compilaform(form1.GB_veriche192,'Generatori',dmtutti.ds_Generatori);
compilaform(form1.GBLocSemp,'Fabbricato',dmtutti.ds_Fabbricato);
compilaGriglia(form1.dbgFinsemp,'Finestre',dmtutti.ds_Finestre);
//form1.dbnallSemp.datasource:=dmtutti.ds_Semplificato;
//compilaGriglia(form1.dbgallSemp,'Semplificato',dmtutti.ds_Semplificato);
//compilaGriglia(form1.dbgMesisemp,'SempMesi',dmtutti.ds_SempMesi);
compilaGriglia(form1.DBGCarb,'Risparmio',dmtutti.ds_Risparmio);
//form1.Pagecontrol24.ActivePageIndex:=0;
 //dbgrid12  pareti
//compilaform(form1.groupbox31,'Interventi',dmtutti.ds_Interventi);
//compilaform(form1.groupbox31,'Interventi',dmtutti.ds_Interventi);
//compilaform(form1.groupbox31,'Interventi',dmtutti.ds_Interventi);
//compilaform(form1.groupbox31,'Interventi',dmtutti.ds_Interventi);
//compilaform(form1.groupbox31,'Interventi',dmtutti.ds_Interventi);
Apritabpareti(form1.dbimpareti);
Settacoloretubo;
combocolori;
AggiornaTabcolori;
AggiornaTabcolori_tubi;
AggiornaTabConfini;
ApritabFinestre;
nocambia:=false;
CambiaPonte;
end;
Procedure AggiornaPiano;
begin
Apri_piano;
prima_volta:=true;
ridisegna;
//form1.Redraw3d;
end;
Procedure rileggi_progetto_corrente;
var fdata:textfile;
    datacor,tt:string;
begin
if fileexists(progcor)then
    begin
    progress_3d(45,'Rilettura progetto corrente');
    ApriTxtUDBT(Percorso_progetti,progcor);
    {$I data}
    tt:=percorso_progetti;
    assign(fdata,I_sl(tt)+'data.db');
    rewrite(fdata);
    writeln(fdata,datacor);
    close(fdata);
    end;
end;
Procedure rileggi_progetto;
Const benvenuto='esempi\casa colonica.cct';
begin
  try
  rileggi_progetto_corrente;
  except
  showmessage('I file temporanei o il progetto '+progcor+' possono essere corrotti'+chr(13)+
               'riapertura del progetto di benvenuto');

  if fileexists (i_sl(percorsodrive)+benvenuto) then
    begin
    nuovoudbt;
    progcor:='';
    ApriProgettoPJB(pchar(i_sl(percorsodrive)+benvenuto));
    salva_var('ULTPROGBMCLIMA',i_sl(percorsodrive)+benvenuto);
    CambiaDisegno('Terra','','EDIFICIO');
    end
  else showmessage('Malfunzionamento nel programma'+chr(13)+
                    'il progetto di benvenuto :'+i_sl(percorsodrive)+benvenuto+chr(13)+
                    'non esiste');
  end;

end;

Procedure InitPannelloClima;
var i:integer;
    tt,datacor,bufdata:string;
    agg:boolean;
    fdata:textfile;
begin
progress_3d(30,'Inizializzazione projectbrowser (settaggi database)');
inizial;//modulo pareti decimalseparator
progress_3d(30,'percorso_progetti '+percorso_progetti);
progress_3d(30,'percorso_archivi '+percorso_archivi);
progress_3d(30,'Inizializzazione Projectbrowserdll (initUdbT)');
initUdbT(percorso_progetti,percorso_archivi);
tt:=percorso_progetti;
if not fileexists(I_sl(tt)+'Orari.db') then
  begin
  //showmessage('Creazione Database:'+I_sl(tt));
  progress_3d(35,'Database inesistenti , creazione (nuovoudbt).');
  NuovoUdbt;
  end;
LeggiNomeProgetto;
if progcor<>senzanome then
  begin
  if not fileexists(I_sl(tt)+'data.db') then rileggi_progetto
  else
    begin
    {$I data}
    assign(fdata,I_sl(tt)+'data.db');
    reset(fdata);
    readln(fdata,bufdata);
    close(fdata);
    if bufdata<>datacor then
      begin
      progress_3d(45,'Aggiornamento database');
      rileggi_progetto;
      end;
    end ;
  end
else
  begin
  salva_var('ULTPROGBMCLIMA','');
  progress_3d(45,'Esclusione progetto corrente');
  end;
progress_3d(50,'Lettura modello dxf');
scrivi_int:=true;
Input_dxf(Percorso_RisorseGen+'definizione simboli.dxf',true);
scrivi_int:=false;
progress_3d(58,'Apertura database (openudbt).');
openudbt;
progress_3d(60,'Inizializzazioni varie.');
{$Ifdef tubi_14}
Init_Calc_reti;
{$endif}
{$IFDEF DLLBM}
//exit;
{$Endif}

//VVInitGrafica;
//form1.Ultimoprogetto1.Caption:=leggi_var('ULTIMOPROGETTO');
//form1.checkbox2.Checked:=true;
//VVif not fileexists(leggi_var('ULTIMOPROGETTO')) then form1.Ultimoprogetto1.Visible:=false;
{$IfNdef AcadVba}
//if (paramcount=0)or (uppercase(paramstr(1))<>'PROGCOR') then
//tt:=leggi_var('DISEGNOCORRENTE');
//if leggi_var('DISEGNOCORRENTE')='' then
//CancellaFileestensione(percorso_progetti,'*');
{$Endif}
FPiani3d:=nil;
//Progress_3d(0,'Lettura piante');
//Personalizza;

//progress_3d(50,'Inizializzazione Projectbrowserdll');
//if not fileexists(percorso_progetti+'\orari.db')then nuovo_progetto;
//openudbt;
{
form1.groupbox9.Caption:='Locale:'+V_recamb.Denom;
form1.PageControl4.ActivePageIndex:=1;
form1.PageControl7.ActivePageIndex:=0;
form1.PageControl1.ActivePageIndex:=1;
form1.PageControl2.ActivePageIndex:=0;
form1.PageControl22.ActivePageIndex:=0;
form1.Panel_base.ActivePageIndex:=0;
form1.TabSheet17.TabVisible:=false;
form1.Tabcalcoli.TabVisible:=false;
form1.TSdialogo.TabVisible:=false;


form1.pagecontrol7.TabHeight:=1;
form1.pagecontrol7.Tabwidth:=1;
form1.pagecontrol7.ActivePageIndex:=0;
form1.pagecontrol24.ActivePageIndex:=0;
form1.SpeedButton23.Visible:=false;
}
//initpuntatori;


//AggiornaProgetto;
//VVAggiornaErrori;
//VVVisual_percdxf;
//VVpuliscifile;
{VV
with form1 do
  begin
  //tpareti.DatabaseName:=Percorso_progetti;
  //tpareti.tablename:='Immagini';
  //tFinestre.DatabaseName:=Percorso_progetti;
  //tFinestre.tablename:='ImmaginiF';
  dbimfinestre.DataField:='immagine';
  dbimpareti.DataField:='immagine';
  end;
}
//progress_3d(70,'Inizializzazione Projectbrowserdll');
//AggiornaControls;
//nocambia:=true;
//VVAggiornaPiano;
//VVTUbi_edif(1);
//VVinitTlinea;
//VVtlineaParete;
progress_3d(90,'Inizializzazioni varie 2');

//Init_config_user;//attiva le diverse configurazioni

//InitModuli;//bmtermocadDLL

{$Ifdef estivo_14}
//VV Init_Estivo;
{$endif}
//VV Init_CalcoloL10;

//Aggiorna_Calc_reti;
//Caricadis_tubi;
Visual_prog;
//Leggi_Entita(dmtutti.T_Entita,dmtutti.T_Attributi,dmtutti.ds_Entita);
//new(entita_d);
//no Personalizza;
//no initudb(Percorso_progetti);
//Tab0:=true;
//dm1.tt2.databasename:=Percorso_progetti;
//dm1.tt2.tablename:='Piani';
//dm1.tt0.databasename:=Percorso_progetti;
//dm1.tt0.tablename:='confcad';
//dm1.tt0.open;
//AggiornaForm;
//Pagecontrol1.ActivePageIndex:=0;
//Pagecontrol2.ActivePageIndex:=0;
Init_Cad_3d('','','');
//VV Init_cadEsterno;
//scriptloop;
//VV Run_CadEsterno;
//Progress_3d(-1,'Lettura piante');
//left:=screen.Width-width;
//top:=105;
//if top+height>screen.Height then
//top:=screen.Height-height;
// Istruzioni inserite da Emanuela per caricare l'immagine dei ponti termici
//DBTipoPontiTermici.ItemIndex := 0;
//DBTipoPontiTermici.Field.DataSet.Edit;
//DBTipoPontiTermici.Field.Value := DBTipoPontiTermici.Text;
//CaricaImmagine(DBTipoPontiTermici.Text);
//dbConfineParete.Items.Add('Esterno');
//dbConfineSoffitto.Items.Add('Esterno');
//dbConfinePavimento.Items.Add('Esterno');
//cbdisperdite.Items.Add('DISLIVELLO');
//dbConfineParete.ItemIndex := 0;
//dbConfineSoffitto.ItemIndex := 0;
//dbConfinePavimento.ItemIndex := 0;
//progress_3d(95,'Inizializzazione Projectbrowserdll');

//VVCambiaPonte;
//VVprima_volta:=true;
//VVridisegna;
form1.PageControl1.TabHeight:=1;
form1.PageControl1.Tabwidth:=1;
{ TODO -oDiego : Esclusione dll }
//initDll;
//scriptCadInterno;
Progress_3d(-1,'');
//VVleggiposform;
//VVif leggi_var('COUNTBLOCCHI')<>'' then
//VVcountblocchi:=strtoint(leggi_var('COUNTBLOCCHI'));
end;
end.
