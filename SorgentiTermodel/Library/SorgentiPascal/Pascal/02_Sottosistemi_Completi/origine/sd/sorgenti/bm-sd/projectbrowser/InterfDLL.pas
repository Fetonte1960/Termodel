unit InterfDLL;

interface

Uses windows,U3DSD,init_cad3d,sysutils,prova,Piani3d,gestudb,udbt,UdataLink,libreriagenerale,setta_config_user,grafica2d,reti3d,
     chiedilicenza,dialogs,config_var,Progress3d,controlla3d,Cambiaelab,Ugest_cad,filedialog,forms,init_l10,Funz_reti,
     CopiaLetturadisegno3d,creaDxfEdificio,log,UDataoutT,LetturaInMemoria,utility_dll,varcarichi,impterm,{upareti3d,Npareti3d,nfinestre3d  }
     u3dsdridotto,disedificio,Uopen_fileMulti,uleggiscrividati,Inport_climaenergia,esegui_estivo;

Function ComandoPJB(com:Pchar):boolean;
//Procedure ShowPJB;
Procedure NuovoProgettoPJB(Nomeprog:PChar);
Procedure ApriProgettoPJB(Nomeprog:PChar);
Procedure SalvaProgettoPJB(Nomeprog:PChar;Chiudi:boolean);
Procedure ChiudiPJB;
//Procedure ComandoPJB(com:Pchar);
Procedure Cambiadisegno(Piano,rete,isrete:Pchar);
Procedure Licenza(P_cliente,P_codice,P_versione:Pchar);
Function controllaprogetto(tipocalc:Pchar):boolean;
Function ProprietaEntita(x1,y1,z1,x2,y2,z2:Pchar):boolean;
Procedure Parete;
Procedure Finestra;
Procedure Ponte;
Procedure Locale;
Procedure ControllaDis;
Procedure InitVBA;
Function Init_VBA(var aggiornato:boolean):boolean;
Procedure CloseVba;
Procedure Controlla;
Procedure Calcoli;
Procedure CambiaElaborato;
Procedure Set_disegnocorrente;
Procedure AggiornaFileScript(Nome:Pchar);
Procedure ImportaProgetto(NewName,OldName:Pchar);
Procedure AggiornaDisegno3D;
Function  PreparaCalcoloConsumi:boolean;
Procedure CalcolaRete(NomeRete:Pchar);
Procedure ControllaDisegno(Piano,rete,Isrete:Pchar);
Procedure Cambia_Disegno(Piano,rete,isrete:Pchar);
Procedure AggiornaPotenza;
Procedure SalvaPrototipo(nomepro:Pchar);
Procedure CalcoloInvernale;
Procedure Comando(Com:Pchar);
Procedure CancellaDatabase;
function Esegui_Menu(Item:pchar):boolean;
Procedure ScegliTerminale(Par:Pchar);
Procedure Debug_Linea_3d(par:pchar);
Procedure DisposeMem;
Procedure AggiornaScriptPJB;
Procedure VersioneTrial;
Procedure VersioneTrial_pannelli;
Procedure NascondiPJB;
Procedure Aggiorna_Lettura(Piano_aggiorna:pchar);
Procedure SalvaPrPJB(Nomeprog:PChar);


var Disegnocorrente:string='';

implementation
const progbenvenuto='Casa colonica';
      estensprog='.bmt';

var init_perc_bmtermocad:boolean=false;

Procedure VersioneTrial;
begin
Versione_trial:=true;
Versione_Trial_pannelli:=true;
end;
Procedure VersioneTrial_pannelli;
begin
Versione_Trial_pannelli:=true;
end;
Procedure AggiornaScriptPJB;
begin
ScriptapriDiscor;
end;

Procedure DisposeMem;
begin
modoPjb:=true;
end;

Procedure Debug_Linea_3d(par:pchar);
begin
form1.Debugcubo(par);
end;

Procedure NascondiPJB;
begin
form1.Hide;
end;

function Esegui_Menu(Item:pchar):boolean;
Var voce:string;
    niente:boolean;
    i:integer;
begin
file_debug_pjb('Esegui_Menu('+strpas(Item)+')');
result:=true;
voce:=uppercase(strpas(item));
if voce='PIANI' then Piani_In_memoria:=false else
if voce='ARCHIVIOPARETI' then
  begin
  Strutture_In_memoria:=false;
  if fileexists(i_sl(percorsodrive)+'newform.txt')then
    begin
    openudbt;
    //gestNpareti3d;
    closeudbt;
    result:=false;
    end;
  end
else
if voce='ARCHIVIOFINESTRE' then
  begin
  Finestre_In_memoria:=false;
  if fileexists(i_sl(percorsodrive)+'newform.txt')then
    begin
    openudbt;
    //gestNfinestre3d;
    closeudbt;
    result:=false;
    end;
  end
else
if voce='CONFINE' then Confine_In_memoria:=false else
if voce='PONTI' then POnti_In_memoria:=false else
if (voce='LOCALI')or (voce='ESTIVO') then
  begin
  Locali_In_memoria:=false;
  if voce='ESTIVO' then
    begin
    attivapjb;
    AggiornaLetturaEdificio;
    if estivo_interno then estivo;
    disattivapjb;
    end;
  end
else
if voce='GENERATORI' then GENERATORI_In_memoria:=false else
if voce='IMPIANTI' then IMPIANTI_In_memoria:=false else
if voce='ZONE' then
  begin
  ZONE_In_memoria:=false;
  Locali_In_memoria:=false; //In caso si aggiornano i dati dei locali
  //leggi_mem_piani;
  //for i:=1 to npiani do // la lettura del disegno deve essere aggiornata
  //deletefile(filecontrollo(Piani_d^[i].Cod));
  end
else
if voce='ARCHIVIOPARETISPECIALI' then
Paretispeciali_in_memoria:=false else
if voce='ORARI' then ORARI_In_memoria:=false else
if voce='FABBRICATO' then FABBRICATO_In_memoria:=false else
if voce='TERMINALI' then TERMINALI_In_memoria:=false else
if voce='TIPIRETE' then TIPIRETE_In_memoria:=false else
if voce='ARCHTUBI' then Tubazioni_In_memoria:=false else
if voce='PERDITE' then PERDITE_In_memoria:=false else
if voce='PERDITECONCENTRATE' then Perdite_Conc_In_memoria:=false else
if voce='RETI' then RETI_In_memoria:=false else
if voce='SPECIALI' then ParetiSpeciali_In_memoria:=false else
if voce='STAMPA' then niente:=false else
if voce='FINANZIARIA' then niente:=false else
showmessage('Anomalia nel programma:Esegui_menù'+chr(13)+' comando '+voce+' non identificato.');
end;

Procedure Aggiorna_Lettura(Piano_aggiorna:pchar);
Var i:integer;
    ppp:string;
begin
leggi_mem_piani;
if npiani=0 then exit;
ppp:=uppercase(strpas(Piano_aggiorna));
for i:=1 to Npiani do
if uppercase(piani_D^[i].Cod)=ppp then break;
deletefile(filecontrollo(Piani_d^[i].Cod));
end;


Procedure Comando(Com:Pchar);
Var p_dll:string;
begin
if uppercase(com)='PIANI' then
  begin
  openudbt;
  Piani_In_memoria:=false;
  GestPiani3d;
  nocambia:=true;
  closeudbt;
  end
else
if uppercase(com)='RETI' then
  begin
  openudbt;
  RETI_In_memoria:=false;
  Gest_Reti3d;
  nocambia:=true;
  closeudbt;
  end
else
  begin
  p_dll:=copy(Percorso_dll,1,length(Percorso_dll)-length('dlltermico\'));
  if not init_perc_bmtermocad then
    begin
    Procedura_dll('DefinisciPercorsi','BmTermoCadDllUN',2,p_dll,Percorsodrive,'','');
    end;
  Procedura_dll('ITEM_MENU','BmTermoCadDllUN',1,strpas(com),'','','');
  end;
end;
Procedure ScegliTerminale(Par:Pchar);
Var parst,serie:string;
    i:integer;
    xpoint,ypoint,incr,lmax,POtInp:real;
begin
parst:=strpas(par);
azzeraidentif;
xpoint:=str_tofloat(leggiidentif1(parst));
ypoint:=str_tofloat(leggiidentif1(parst));
serie:=leggiidentif1(parst);
lmax:=str_tofloat(leggiidentif1(parst));
incr:=str_tofloat(leggiidentif1(parst));
Potinp:=str_tofloat(leggiidentif1(parst));
Scegli_terminale(Piano_cor_mem,serie,xpoint,ypoint,incr,lmax,POtInp,leggi_var('rete_prec_cad'))
end;
Procedure CalcoloInvernale;
Var p_dll:string;
begin
if PreparaCalcoloConsumi then
  begin
  p_dll:=copy(Percorso_dll,1,length(Percorso_dll)-length('dlltermico\'));
  if not init_perc_bmtermocad then
    begin
    Procedura_dll('DefinisciPercorsi','BmTermoCadDllUN',2,p_dll,Percorsodrive,'','');
    end;
  Procedura_dll('CalcoloL10','BmTermoCadDllUN',0,'','','','');
  end;
end;

Procedure SalvaPrototipo(nomepro:Pchar);
Var f1,f2:textfile;
    buf:string;
    gialetto:boolean;
begin
assign(f1,progcor);
assign(f2,strpas(nomepro));
reset(f1);
rewrite(f2);
gialetto:=false;
while not eof(f1) do
  begin
  if not gialetto then readln(f1,buf)
  else gialetto:=false;
  writeln(f2,buf);
  if (buf='--------------------------------------->ENTITA')or
     (buf='--------------------------------------->LOCALI')or
     (buf='--------------------------------------->RETI')or
     (buf='--------------------------------------->ELAB')or
     (buf='--------------------------------------->PIANI')then
         repeat
         readln(f1,buf);
         gialetto:=true;
         until pos('--------------------------------------->',buf)<>0;
  end;
close(f1);
close(f2);
end;
Procedure AggiornaPotenza;
begin
if L_inmemoria then exit;
//OpenUdbt;   Disattivato in attesa che non vengano spianati i dati ambiente
//Aggiorna_Potenze;
controlla_dis:=false;
Cambia_Disegno(Pchar(leggi_var('Piano_prec_cad')),Pchar(leggi_var('rete_prec_cad')),Pchar(leggi_var('is_prec_cad')));
end;
Procedure CalcolaRete(NomeRete:Pchar);
begin
file_debug_pjb('CalcolaRete('+strpas(NomeRete)+')');
progress_3d(-2,'Calcolo rete:'+Strpas(Nomerete));
//controlla_dis:=true;
if Calcola_reti_memoria(Strpas(Nomerete)) then exit;
Cambia_Disegno(Pchar(leggi_var('Piano_prec_cad')),Pchar(leggi_var('rete_prec_cad')),Pchar(leggi_var('is_prec_cad')));
nocambia:=true;
openudbt;
Aggiorna_Calc_reti(strPas(NomeRete));
dis_esecutivo:=leggi_var('is_prec_cad')='ELABORATI';
Caricadistubi(leggi_var('rete_prec_cad'),leggi_var('Piano_prec_cad'),true);
Edit_in_Cad:=false;
PassaalCad;
Closeudbt;
progress_3d(-1,'Calcolo reti:');
end;
Function PreparaCalcoloConsumi:boolean;
Var err:string;
begin
file_debug_pjb('PreparaCalcoloConsumi');
progress_3d(-2,'Preparazione dati sugli alloggi: ');
nocambia:=true;
openudbt;
err:=AggiornaLetturaEdificio;
result:=true;
if err<>'' then
  begin
  result:=false;
  showmessage(err);
  end;
Carica_generatori;
Closeudbt;
progress_3d(-1,'Elaborazione disegno: ');
end;
Procedure AggiornaDisegno3D;
begin
file_debug_pjb('AggiornaDisegno3D');
ShowPjb;
end;

Procedure Importa_Progetto(NewName,OldName:Pchar);
begin
//Apri_progetto_compattato(OldName);
//exit;
AttivaPJB;
leggi_mem_piani;
leggi_mem_confcad;
leggi_mem_reti;
leggi_mem_locali;
ApriTxtUDBT(Percorso_progetti,strpas(OldName));
Nambienti:=0;
Salva_locali(dmtutti.T_locali,dmtutti.T_Pareti,dmtutti.ds_locali);
Salva_piani(dmtutti.T_piani,dmtutti.T_PPiano,dmtutti.ds_piani);
Salva_ConfCad(dmtutti.T_ConfCad,dmtutti.T_ConfCad,dmtutti.ds_ConfCad);
Salva_reti(dmtutti.T_reti,dmtutti.T_reti,dmtutti.ds_reti);
disattivaPJB;
//ProgInport:=strpas(Newname);
//ApriProgettoPJB(OldName);
//ProgInport:='';
end;

Procedure ImportaProgetto(NewName,OldName:Pchar);
Var Nomeprogetto,PercProgetto,PasNome,buf:string;
    ff:textfile;
    i,j,maxnum:integer;
begin
Pasnome:=strpas(OldName);
assign(ff,pasnome);
reset(ff);
while not eof(ff) do readln(ff,buf);
close(ff);
if uppercase(buf)<>'#ENDFILE#' then
  begin
  showmessage('Il file è corrotto');
  exit;
  end;
Nomeprogetto:=copy(extractfilename(Oldname),1,length(extractfilename(Oldname))-4);
Percprogetto:=extractfilepath(Oldname);
Percprogetto:=I_sl(Percprogetto)+'Work_'+Nomeprogetto+'\';
if not fileexists(percprogetto+'disegno.txt') then
  begin
  showmessage('Non è stata eseguita le lettura del disegno in climaenergia'+chr(13)+'saranno inportati solo gli archivi.');
  Importa_Progetto(NewName,OldName);
  exit;
  end;
//Apri_progetto_compattato(OldName);
//exit;
AttivaPJB;
leggi_mem_confcad;
ApriTxtUDBT(Percorso_progetti,strpas(OldName));
Piani_in_memoria:=false;
leggi_mem_Piani;
Strutture_in_memoria:=false;
leggi_mem_Strutture;
confine_in_memoria:=false;
leggi_mem_confine;
reti_in_memoria:=false;
locali_in_memoria:=false;
leggi_mem_locali;
inporta_edificio_climaenergia(percprogetto+'disegno.txt');
Salva_Strutture(dmtutti.T_Strutture,dmtutti.T_Strati,dmtutti.ds_Strutture);
Salva_ParetiSpeciali(dmtutti.T_ParetiSpeciali,dmtutti.T_ParetiSpeciali,dmtutti.ds_ParetiSpeciali);
Salva_confine(dmtutti.T_confine,dmtutti.T_confine,dmtutti.ds_confine);
for i:=1 to Npiani do
  begin
  maxnum:=0;
  for j:=1  to Nambienti do
  if uppercase(ambienti_d^[j]^.Piano)=uppercase(piani_d^[i].Cod) then
  if strtoint(ambienti_d^[j]^.CodNum)>maxnum then maxnum:=strtoint(ambienti_d^[j]^.CodNum);
  AggiornaIniLocali(Perc_work,'Piano'+inttostr(Piani_D^[i].Indice),inttostr(maxnum+1000*piani_d^[i].Indice));
  end;
Nambienti:=0;
Cambia_Dis_mem(Cofcad_D^.PIANOCOR,'','EDIFICIO');
Salva_locali(dmtutti.T_locali,dmtutti.T_Pareti,dmtutti.ds_locali);
Salva_piani(dmtutti.T_piani,dmtutti.T_PPiano,dmtutti.ds_piani);
Salva_ConfCad(dmtutti.T_ConfCad,dmtutti.T_ConfCad,dmtutti.ds_ConfCad);
Salva_reti(dmtutti.T_reti,dmtutti.T_reti,dmtutti.ds_reti);
disattivaPJB;
//ProgInport:=strpas(Newname);
//ApriProgettoPJB(OldName);
//ProgInport:='';
end;

Procedure AggiornaFileScript(Nome:Pchar);
var ncg:boolean;
begin
//comandopjb('PROPRIETALOCALE');
//exit;
ncg:=nocambia;
nocambia:=true;
openudbt;
noscript:=false;
nocambia:=true;
Aggiornascript(strpas(nome));
//nocambia:=true;
noscript:=true;
Closeudbt;
nocambia:=ncg;
end;
Procedure CambiaElaborato;
begin
GestCambiaelab;
end;
Procedure Calcoli;
begin
//GestControlla3d(1);
openudbt;
copyfile(pchar(disegnocorrente),pchar(percorsodrive+'disegno.dxf'),false);
passaalcad;
formcompleta;
nocambia:=false;
form1.ShowModal;
passaalcad;
Set_disegnocorrente;
scriptriprendi;
nocambia:=true;
end;
Procedure Controlla;
begin
openudbt;
copyfile(pchar(disegnocorrente),pchar(percorsodrive+'disegno.dxf'),false);
Passaalcad;
showmessage(form1.Label389.Caption);
Passaalcad;
Set_disegnocorrente;
scriptriprendi;
end;
Procedure CloseVba;
begin
Libera_progress_3d;
chiudi_form:=true;
form1.Close;
dmtutti.free;
//showmessage('Chiusura Vba');
//form1.Free;
end;
Procedure Set_disegnocorrente;
begin
Disegnocorrente:=extractfilepath(Progetto_corrente);
Disegnocorrente:=i_sl(Disegnocorrente)+V_recconfcad.PIANOCOR+'.dxf';
copyfile(pchar(percorsodrive+'disegno.dxf'),pchar(disegnocorrente),false);
salva_var('DISEGNOCORRENTE',Disegnocorrente);
ScriptInterfaccia;
end;
Function Init_VBA(var aggiornato:boolean):boolean;
Var ss:string;
begin
result:=true;
openudbt;
aggiornato:=false;
Disegnocorrente:=percorsodrive+'disegno.dwg';
Disegnocorrente:=leggi_var('DISEGNOCORRENTE');
if pos('§',disegnocorrente)<>0 then
  begin
  form1.pagecontrol24.activepageindex:=1;
  form1.checkbox10.checked;
  end;
if not fileexists(Disegnocorrente)or (V_recconfcad.PIANOCOR='')or (leggi_var('PROGETTOCORRENTE')='') then
  begin
  aggiornato:=true;
  Setta_progetto('');
  //if fileexists(percorsodrive+'esempi\'+progbenvenuto+'\'+progbenvenuto+estensprog) then
  //Disegnocorrente:=percorsodrive+'esempi\'+progbenvenuto+'\'+progbenvenuto+estensprog
  //else  trasferito nel programma di avvio
    begin
    if leggi_var('NUOVOPROG')='TRUE' then
      begin
      ss:=dialognuovoprogetto;
      Setta_progetto(ss);
      if ss<>'' then
      if not Nuovo_progetto(true) then Setta_progetto('');
      end
    else form1.Apri1click(nil);
    if not fileexists(Progetto_corrente) then
      begin
      result:=false;
      exit;
      end
    else
      begin
      {  Trasferito in nuovo progetto
      If V_recconfcad.PIANOCOR='' then gestpiani3d;
      If V_recconfcad.PIANOCOR='' then
        begin
        result:=false;
        exit;
        end;
      }
      //per compilare correttamente il groupbox informativo sul progetto
      Disegnocorrente:=extractfilepath(Progetto_corrente);
      Disegnocorrente:=i_sl(Disegnocorrente)+V_recconfcad.PIANOCOR+'.dxf';
      salva_var('DISEGNOCORRENTE',Disegnocorrente);

      Passaalcad;
      Set_disegnocorrente;
      esegui_cad(false,Disegnocorrente);
      end;
    end;
  end
else
  begin
  Cambia_progetto(leggi_var('PROGETTOCORRENTE'));
  Passaalcad;
  Set_disegnocorrente;
  esegui_cad(false,Disegnocorrente);
  //visualizza_disegno(Disegnocorrente);
  end;
//nocambia:=true;
end;
Procedure InitVBA;
Var ft:Text;
    aggiornato:boolean;
begin
assign(ft,percorsodrive+'loaddis.scr');
rewrite(ft);
if not Init_vba(aggiornato) then
  begin
  writeln(ft,'-vbarun CloseVba');
  writeln(ft,'_exit ');
  end
else
  begin
  writeln(ft,'_open "'+Disegnocorrente+'"');
  if aggiornato then writeln(ft,'_Zoom E');
  end;
close(ft);
end;


Procedure Parete;
begin
ComandoPJB('PROPRIETAPARETE');
end;
Procedure Finestra;
begin
ComandoPJB('PROPRIETAFINESTRA');
end;
Procedure Ponte;
begin
ComandoPJB('PROPRIETAPONTE');
end;
Procedure Locale;
begin
ComandoPJB('PROPRIETALOCALE');
end;
Function ProprietaEntita(x1,y1,z1,x2,y2,z2:Pchar):boolean;
begin
showmessage('Modifica proprietà entità');
result:=true;
end;

Procedure Licenza(P_cliente,P_codice,P_versione:Pchar);
begin
ChiediLicenza.codlicenza:=strpas(P_codice);
ChiediLicenza.Cliente:=strpas(P_cliente);
//ChiediLicenza.versione:=strpas(P_cliente);
end;

Procedure ShowPJBModal;
begin
Bloccaredraw:=false;
openUdbT;
form1.showModal;
form1.pagecontrol4.ActivePageIndex:=0;
nocambia:=true;
closeUdbT;
nocambia:=false;
Bloccaredraw:=true;
end;
Procedure ApriProgettoPJB(Nomeprog:PChar);
Var percorso,nome:string;
begin
file_debug_pjb('ApriProgettoPJB('+strpas(Nomeprog)+')');
if apri_mem(nomeprog) then exit;
//showmessage('apertura progetto');
progress_3d(-2,'Apertura progetto: '+strpas(Nomeprog));
Bloccaredraw:=false;
nocambia:=true;
openudbt;
Setta_progetto(strpas(nomeprog));
nome:=extractfilename(strpas(nomeprog));
nome:=copy(nome,1,length(nome)-4);
percorso:=extractfilepath(strpas(Nomeprog));
Apri_progetto(strpas(Nomeprog),false);
perc_progcor:=i_sl(percorso)+'work_'+nome+'\';
Aggiorna_liberi;
nocambia:=true;
Closeudbt;
nocambia:=false;
Bloccaredraw:=true;
edit_in_cad:=false;
progress_3d(-1,'Apertura progetto: '+strpas(Nomeprog));
end;
Procedure NuovoProgettoPJB(Nomeprog:PChar);
Var percorso,nome:string;
begin
nome:=uppercase(strpas(Nomeprog));
nome:=copy(nome,length(nome)-2,3);
if nome='BAK' then
  begin
  nome:=uppercase(strpas(Nomeprog));
  nome:=copy(nome,1,length(nome)-3);
  NomeProg:=pchar(Nome);
  end;
file_debug_pjb('NuovoProgettoPJB('+strpas(Nomeprog)+')');
Initlog('Nuovoprogetto');
azzera_Lettura_In_memoria;
NuovoProgetto_mem_salva;
progress_3d(-2,'Nuovo progetto: '+strpas(Nomeprog));

Bloccaredraw:=false;
nocambia:=true;
openudbt;
Setta_progetto(strpas(nomeprog));
Nuovo_Progetto(false);
nome:=extractfilename(strpas(nomeprog));
nome:=copy(nome,1,length(nome)-4);
percorso:=extractfilepath(strpas(Nomeprog));
Salvaprogetto(false);
perc_progcor:=i_sl(percorso)+'work_'+nome+'\';
Aggiorna_liberi;
nocambia:=true;
Closeudbt;
nocambia:=false;
Bloccaredraw:=true;
edit_in_cad:=false;
NuovoProgetto_mem;
closelog;
progress_3d(-1,'Nuovo progetto: '+strpas(Nomeprog));
end;
Procedure CancellaDatabase;
begin
cancellafileestensione(percorso_progetti,'DB');
cancellafileestensione(percorso_progetti,'PX');
cancellafileestensione(percorso_progetti,'XG0');
cancellafileestensione(percorso_progetti,'YG0');
end;

Procedure SalvaProgettoPJB(Nomeprog:PChar;Chiudi:boolean);
Var percorso,nome:string;
begin
file_debug_pjb('SalvaProgettoPJB('+strpas(Nomeprog)+')');
if uppercase(strpas(nomeprog))<>uppercase(progcor) then
  begin
  Setta_progetto(strpas(nomeprog));
  nome:=extractfilename(strpas(nomeprog));
  nome:=copy(nome,1,length(nome)-4);
  percorso:=extractfilepath(strpas(Nomeprog));
  perc_progcor:=i_sl(percorso)+'work_'+nome+'\';
 //showmessage('Il progetto da salvare non è uguale al progetto corrente'+chr(13)+'nuovo progetto:'+strpas(nomeprog)+chr(13)+' progetto corrente:'+progcor);
  end;
if salva_mem(nomeprog,chiudi) then exit;
controlla_dis:=not chiudi;
Cambia_Disegno(Pchar(leggi_var('Piano_prec_cad')),Pchar(leggi_var('rete_prec_cad')),Pchar(leggi_var('is_prec_cad')));
progress_3d(-2,'Salvataggio progetto: '+strpas(Nomeprog));
Bloccaredraw:=false;
nocambia:=true;
openudbt;
Setta_progetto(strpas(nomeprog));
nome:=extractfilename(strpas(nomeprog));
nome:=copy(nome,1,length(nome)-4);
percorso:=extractfilepath(strpas(Nomeprog));
Salvaprogetto(false);
perc_progcor:=i_sl(percorso)+'work_'+nome+'\';
Aggiorna_liberi;
nocambia:=true;
Closeudbt;
nocambia:=false;
Bloccaredraw:=true;
progress_3d(-1,'Salvataggio progetto: '+strpas(Nomeprog));
end;

Procedure SalvaPrPJB(Nomeprog:PChar);
begin
SalvaProgettoPJB(Nomeprog,false);
end;

Procedure ChiudiPJB;
begin
file_debug_pjb('ChiudiPJB');
//salva_mem(pchar(progcor),true);
chiudiPjb_mem;
chiudi_form:=true;
form1.close;
form1Rid.close;
end;
Function controllaprogetto(tipocalc:Pchar):boolean;
begin
result:=true;
end;
//Procedure ComandoPJB(com:Pchar);
Function ComandoPJB(com:Pchar):boolean;
Var StCom:string;
//     result:boolean;
begin
//file_debug_pjb('ComandoPJB('+strpas(com)+')');
result:=false;
stcom:=uppercase(strpas(com));
if Stcom='PIANI' then
  begin
  Bloccaredraw:=false;
  nocambia:=true;
  OpenUdbt;
  form1.pagecontrol4.ActivePageIndex:=0;
  GestPiani3d;
  form1.pagecontrol4.ActivePageIndex:=0;
  nocambia:=true;
  CloseUdbt;
  nocambia:=false;
  Bloccaredraw:=true;
  result:=true;
  end;
if Stcom='RETI' then
  begin
  Bloccaredraw:=false;
  nocambia:=true;
  OpenUdbt;
  form1.pagecontrol4.ActivePageIndex:=0;
  Gest_reti3d;
  form1.pagecontrol4.ActivePageIndex:=0;
  nocambia:=true;
  CloseUdbt;
  nocambia:=false;
  Bloccaredraw:=true;
  result:=true;
  end;

if Stcom='2D' then
  begin
  Bloccaredraw:=false;
  nocambia:=true;
  OpenUdbt;
  nocambia:=false;
  form1.PageControl4.ActivePageIndex:=1;
  result:=true;
  end;
if Stcom='3D' then
  begin
  form1.PageControl4.ActivePageIndex:=0;
  nocambia:=true;
  closeUdbt;

  nocambia:=false;
  result:=true;
  end;
if pos('PROPRIETA',stcom)=1 then
  begin
  if copy(stcom,10,length(stcom)-9)='CHIUDI' then
    begin
    chiudiPJB;
    solo3d;
    end;
  nocambia:=true;
  OpenUdbt;
  nocambia:=false;
  FormProprieta(copy(stcom,10,length(stcom)-9));
  ShowPJBModal;
  result:=true;
  ultimo(copy(stcom,10,length(stcom)-9));
  end;
end;
Var Piano_prec_cad:string='';
    rete_prec_cad:string='';
    is_prec_cad:string='';

Procedure CambiaDisegno(Piano,rete,isrete:Pchar);
begin
file_debug_pjb('CambiaDisegno('+strpas(Piano)+','+strpas(rete)+','+strpas(isrete)+')');
if cambia_dis_mem(strpas(Piano),strpas(rete),strpas(isrete)) then exit;
controlla_dis:=false;
Cambia_Disegno(Piano,rete,isrete);
end;
Procedure ControllaDisegno(Piano,rete,Isrete:Pchar);
begin
file_debug_pjb('ControllaDisegno('+strpas(Piano)+','+strpas(rete)+','+strpas(isrete)+')');
if leggi_edificio_Inmemoria then exit;
Initlog('Controlladisegno');
controlla_dis:=True;
Cambia_Disegno(Piano,rete,isrete);
if uppercase(strpas(Isrete))<>'EDIFICIO' then
  begin
  nocambia:=true;
  OpenUdbt;
  Controlla_rete(strpas(rete),strpas(piano));
  CloseUdbt;
  end;
Closelog;
end;
Procedure Cambia_Disegno(Piano,rete,isrete:Pchar);
begin
if (piano='')or((rete='')and(strpas(Isrete)<>'EDIFICIO'))then exit;
if piano='' then
  begin
  showmessage('Piano non valido');
  exit;
  end;
if uppercase(strpas(Isrete))='EDIFICIO' then
progress_3d(-2,'Elaborazione disegno: '+strpas(piano))
else
  begin
  if rete='' then
    begin
    showmessage('rete non valida');
    exit;
    end;
  progress_3d(-2,'Elaborazione disegno: '+strpas(Isrete)+' '+strpas(piano)+'-'+strpas(rete));
  end;
Progress3d.Form2.FormStyle:=fsnormal;
//cliente:='Sara Agosta  ( BM SISTEMI )';
//codlicenza:='6Z48';
if not verificalicenza then exit;
form1.Caption:='ProjectBrowser , in licenza a: '+cliente;
nocambia:=true;
OpenUdbt;
if  edit_in_cad then
  begin
  dmtutti.T_ConfCad.Edit;
  is_prec_cad:=leggi_var('is_prec_cad');
  Piano_prec_cad:=leggi_var('Piano_prec_cad');
  rete_prec_cad:=leggi_var('rete_prec_cad');
  //dis_esecutivo:=uppercase(is_prec_cad)='ELABORATI';
  dis_esecutivo:=false;  //lo gestisce il CAD
  if Piano_prec_cad<>'' then
    begin
    V_recconfcad.Set_PIANOCOR(Piano_prec_cad);
    V_recconfcad.Set_ColoreTipoReteIRR(rete_prec_cad);
    if uppercase(is_prec_cad)='EDIFICIO' then form1.PageControl24.ActivePageIndex:=0
    else form1.PageControl24.ActivePageIndex:=1;
    end;
  dmtutti.T_ConfCad.POst;
  dmtutti.T_ConfCad.Edit;
  PassaAlCad;
  end;
dmtutti.T_ConfCad.Edit;
V_recconfcad.Set_PIANOCOR(strpas(Piano));
V_recconfcad.Set_ColoreTipoReteIRR(strpas(rete));
//dis_esecutivo:=uppercase(isrete)='ELABORATI';
dis_esecutivo:=false; //lo gestisce il CAD
if uppercase(strpas(Isrete))='EDIFICIO' then form1.PageControl24.ActivePageIndex:=0
else form1.PageControl24.ActivePageIndex:=1;
dmtutti.T_ConfCad.Post;
dmtutti.T_ConfCad.edit;
Apripiano(True,Piano);
PassaAlCad;
nocambia:=true;
Piano_prec_cad:=V_recconfcad.PIANOCOR;
rete_prec_cad:=V_recconfcad.ColoreTipoReteIRR;
is_prec_cad:=strpas(isrete);
salva_var('is_prec_cad',is_prec_cad);
salva_var('Piano_prec_cad',Piano_prec_cad);
salva_var('rete_prec_cad',rete_prec_cad);
CloseUdbt;
//nocambia:=false;
if not controlla_dis then
  begin
  countblocchi:=0;
  Salva_var('COUNTBLOCCHI',inttostr(countblocchi));
  end;
controlla_dis:=false;
progress_3d(-1,'Elaborazione disegno: ');
end;
Procedure ControllaDis;
begin
end;

end.
