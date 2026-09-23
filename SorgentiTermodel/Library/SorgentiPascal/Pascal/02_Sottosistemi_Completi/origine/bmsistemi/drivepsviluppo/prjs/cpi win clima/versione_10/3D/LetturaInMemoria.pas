unit LetturaInMemoria;

interface
uses sysutils,LetturaDisegnoBidimensionale,libreriagenerale,Uvariabililettura,copialetturadisegno3d,uleggiscrividati,
     udbt,varcarichi,Udatalink,Dxf_in_out,creaDxfEdificio,init_cad3d,windows,config_var,progress3d,grafica2d,u3dsd,chiedilicenza,
     gestudb,setta_config_user,dialogs,copiacaricatabelle,funz_reti,ugrafodxf,disedificio,controls,angoli,forms,UOpen_fileMulti,inifiles;
Procedure Out_entita(Ent:pchar);
Function leggi_edificio_Inmemoria:boolean;
function AggiornaLetturaEdificio:string;
Procedure Init_Lettura_In_memoria;
function Cambia_Dis_mem(piano,rete,isrete:string):boolean;
Procedure azzera_Lettura_In_memoria;
function NuovoProgetto_mem:boolean;
function showpjb_mem:boolean;
function Salva_mem(nomepc:Pchar;chiudi:boolean):boolean;
Function Apri_mem(nomeprog:Pchar):boolean;
function NuovoProgetto_mem_salva:boolean;
Procedure EasyControllaDis;
Procedure Salva_Tabcol;
Function Calcola_reti_memoria(nomer:string):boolean;
Procedure file_debug_pjb(riga:string);
Procedure Prop3D(Riga:pchar);

Procedure chiudiPjb_mem;
Procedure DisAttivaPjb;
Procedure AttivaPjb;
Procedure set_indice_piano(nomep:string);
Procedure Aggiorna_reti(rete:pchar);
Procedure Aggiorna_esecutivi;
Procedure AffiancaPJB;
Procedure ShowPJB;
Procedure Salva_progetto_compattato(Nome_Compatto:Pchar);
Procedure Apri_progetto_compattato(Nome_Compatto:Pchar);
Function Cambiati_colori(PianoC,ReteC,IsreteC:string):boolean;
Procedure Cambia_colori_1(ent_inizio,ent_fine:integer);
Procedure Output_dxf_Col(nomedxf:string);
Procedure AggiornaIniLocali(percorso_ini,piano,numero:string);

var L_inmemoria:boolean=true;
    Piani_mem:boolean=false;
    Piano_cor_mem:string='';

implementation
const  fattorediscala=100;
type Tfunccor=(NoFunz,LetturaEdificio,LetturaRete,Salvaedificio,SalvaRete);

Var Funzione_cor:Tfunccor;
Var rete_cor_mem:string='';
    isrete_cor_mem:string='';
    trasmesso_disegno:boolean=false;
    indice_piano,posiz_piano:integer;
    anomalia:string='';
    colori_cambiati:boolean=false;


Procedure AggiornaIniLocali(percorso_ini,piano,numero:string);
Var ini:tinifile;
begin
Ini := TIniFile.Create(percorso_ini+'Impostazioni.ini');
ini.WriteString('Codice locale',piano,numero);
ini.Free;
end;

Procedure Salva_progetto_compattato(Nome_Compatto:Pchar);
Var i,J,K,Ent_inizio,Salvanambienti:integer;
    nomedis:string;
begin
//dmtutti.T_Entita.DatabaseName:='C:\bm sistemi srl\distribuzioni\versione_2012\termotecnica\file_termico\ProjectBrowser\Database';
//dmtutti.T_attributi.DatabaseName:='C:\bm sistemi srl\distribuzioni\versione_2012\termotecnica\file_termico\ProjectBrowser\Database';
AttivaPJB;
leggi_mem_piani;
leggi_mem_reti;
leggi_mem_locali;
Salvanambienti:=NAmbienti;
NAmbienti:=0;
Salva_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
Locali_In_memoria:=false;
Nentita:=0;
for i:=1 to npiani do
with piani_d^[i] do
  begin
  Ent_inizio:=Nentita;
  nomedis:=nome_dxf(cod,'','EDIFICIO');
  if fileexists (nomedis) then
    begin
    entita_iniziale:=Nentita;// serve per non azzerare le entita
    Input_dxf(nomedis,false);
    for j:=Ent_inizio+1 to Nentita do
    Entita_D^[j].Layer:='E:'+inttostr(i)+':'+Entita_D^[j].Layer+':';
    if cambiati_colori(cod,'','EDIFICIO') then Cambia_colori_1(Ent_inizio+1,Nentita);
    end;
  end;
for K:=1 to NGen do
for i:=1 to npiani do
with piani_d^[i] do
  begin
  Ent_inizio:=Nentita;
  nomedis:=nome_dxf(cod,GENERALITA_D1^[k].Codice,'RETE');
  if fileexists (nomedis) then
    begin
    entita_iniziale:=Nentita;// serve per non azzerare le entita dentro input dxf
    Input_dxf(nomedis,false);
    for j:=Ent_inizio+1 to Nentita do
    Entita_D^[j].Layer:='R:'+inttostr(k)+':P:'+inttostr(i)+':'+Entita_D^[j].Layer+':';
    if cambiati_colori(cod,GENERALITA_D1^[k].Codice,'RETE') then Cambia_colori_1(Ent_inizio+1,Nentita);
    end;
  end;
Salva_Entita(dmtutti.T_Entita,dmtutti.T_attributi,dmtutti.ds_entita);
entita_iniziale:=0;//ripristina la funzionalità normale di inputdxf
SaveUdBT(strpas(Nome_Compatto));

NAmbienti:=Salvanambienti;//ripristina la situazione iniziale dei locali
Salva_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
DisattivaPJB;
end;

Procedure Apri_progetto_compattato(Nome_Compatto:Pchar);
Var Ultimo_piano,Ultima_rete,i,j,k,prima_ent,Nentita_temp,ultloc:integer;
    ultimo_layer,layer_corretto,bb:string;
begin
AttivaPJB;
ApriTxtUDBT(Percorso_progetti,strpas(Nome_Compatto));
leggi_mem_piani;
leggi_mem_reti;
leggi_mem_entita;
if Nentita=0 then
  begin
  DisattivaPJB;
  exit;
  end;
Ultimo_layer:='';
Prima_ent:=1;
Nentita_temp:=Nentita;  //per poterlo modificare nel FOR
for i:=1 to Nentita_temp do
with entita_D^[i]^ do
if (ultimo_layer<>layer)or(i=Nentita_temp) then
  begin
  if ultimo_layer='' then
  ultimo_layer:=layer
  else
    begin
    entita_iniziale:=Prima_ent-1; //viene incrementata in output DXF
    if i=Nentita_temp then
      begin
      Nentita:=i;
      Layer:=Layer_corretto;
      end
    else Nentita:=i-1;
    if ultima_rete=0 then
      begin
      //agiorna ini per numerazione climacad
      ultloc:=0;
      for j:=entita_iniziale+1 to Nentita do
      if Entita_D^[j].Cod='B' then
      for k:=1 to Entita_D^[j].NAttrib do
      if Entita_D^[j].Attrib[k].CodA='COD' then
      if strtoint(Entita_D^[j].Attrib[k].Valore)>ultloc then
      ultloc:=strtoint(Entita_D^[j].Attrib[k].Valore);
      AggiornaIniLocali(perc_work,'Piano'+inttostr(Piani_D^[ultimo_piano].Indice),inttostr(ultloc));

      Output_dxf(nome_dxf(Piani_D^[ultimo_piano].Cod,'','EDIFICIO'));
      end
    else Output_dxf(nome_dxf(Piani_D^[ultimo_piano].Cod,GENERALITA_D1^[ultima_rete].Codice,'RETE'));
    prima_ent:=i;
    end;
  if  i<Nentita_temp then
    begin
    ultimo_layer:=layer;
    Azzeraidentif;
    bb:=leggiidentif1(layer);
    if bb='E' then
      begin
      Ultima_rete:=0;
      bb:=leggiidentif1(layer);
      ultimo_piano:=strtoint(bb);
      Layer_corretto:=leggiidentif1(layer);
      layer:=Layer_corretto;
      end
    else
      begin
      bb:=leggiidentif1(layer);
      Ultima_rete:=strtoint(bb);
      bb:=leggiidentif1(layer); //:P:
      bb:=leggiidentif1(layer);
      ultimo_piano:=strtoint(bb);
      Layer_corretto:=leggiidentif1(layer);
      layer:=Layer_corretto;
      end;
    end;
  end
else Layer:=Layer_corretto;

entita_iniziale:=0;//ripristina output dxf
Nentita:=0;
Salva_Entita(dmtutti.T_Entita,dmtutti.T_attributi,dmtutti.ds_entita);
DisattivaPJB;
end;

Procedure Non_salvato;
begin
//showmessage('Disegno non salvato');
end;


function salva_disegno:boolean;
var i:integer;
var modorete:string;

Function chiediconferma(mess:string):integer;
begin
  case messagedlg(mess,mtConfirmation,[mbyes,mbno],0) of
  mryes:result:=1;
  mrno:result:=2;
  end;
end;
begin
result:=trasmesso_disegno;
if not result then exit;
if nentita=0 then
  begin
  //protezione provvisoria per non salvare disegni vuoti
  if chiediconferma('E'' stato richiesto il salvataggio di un disegno vuoto'+chr(13)+
              'confermate il salvataggio')<>1 then result:=false;
  end;
if not result then exit;
if anomalia<>'' then
  begin
  result:=false;
  if uppercase(isrete_cor_mem)='EDIFICIO' then modorete:='edificio'
  else modorete:='rete';
  showmessage('Anomalia nel programma'+chr(13)+
              'è stato rilevato un simbolo '+anomalia+chr(13)+
              'mentre il programma è in modalità '+modorete+chr(13)+
              'il disegno non può essere salvato.');
  end;
anomalia:='';
end;

Procedure Output_dxf_Col(nomedxf:string);
begin
Leggi_Strutture(dmtutti.T_Strutture,dmtutti.T_Strati,dmtutti.ds_Strutture);
Salva_Tabcol; //Tabella allocazione colori
Output_dxf(nomedxf);
end;


Procedure Aggiorna_esecutivi;
begin
attivapjb;
if salva_disegno then
  begin
  file_debug_pjb('//comento Creato DXF '+nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
  Output_dxf_col(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
  copyfile(Pchar(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem)),pchar(i_sl(percorsodrive)+'disegno.dxf'),false);
  deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+Piano_cor_mem+'.U2d'));
  Trasmesso_disegno:=false;
  end
else Non_salvato;
Aggiornaesecutivi;
disattivapjb;
end;


Procedure ShowPJB;
var datacor:string;
begin
OpenDebugPJB;
WDebugPJB('Aggiorna 3D');
{$I Data}
form1.pagecontrol1.Visible:=false;
form1.panel28.Visible:=false;
form1.button19.Visible:=false;
form1.button24.Visible:=false;
form1.pagecontrol4.ActivePageIndex:=0;
form1.Caption:='Projectbrowser 3D '+num_vers+' db:'+datacor+' By EsseDi software';
if versione_trial then form1.Caption:=form1.Caption+' trial';
//form1.Caption:='ProjectBrowser , in licenza a: '+cliente;

if showpjb_mem then
  begin
  CloseDebugPJB;
  exit;
  end;
controlla_dis:=true;
//Cambia_Disegno(Pchar(leggi_var('Piano_prec_cad')),Pchar(leggi_var('rete_prec_cad')),Pchar(leggi_var('is_prec_cad')));
nocambia:=true;
Bloccaredraw:=false;
openUdbT;
form1.Button19Click(nil);
{$IFNdef Dllbm}
solo3d;
{$Endif}

form1.show;
closeUdbT;
nocambia:=false;
Bloccaredraw:=true;
CloseDebugPJB;
end;

Procedure Prop3D(Riga:pchar);
Var tipo:string;
    xogg,yogg,zogg,x1ogg,y1ogg,z1ogg,Z_piano:real;
    i:integer;
begin
//affiancaPJB;
if form1.Visible then
  begin
  leggi_mem_piani;
  z_piano:=0;
  for i:=1 to Npiani do
    begin
    if uppercase(piano_cor_mem)=uppercase(piani_d^[i].Cod) then break
    else z_piano:=z_piano+piani_d^[i].AltL;
    end;
  leggi_controllo(Piano_cor_mem);
  Azzeraidentif;
  tipo:=leggiidentif1(riga);
  XOgg:=str_tofloat(leggiidentif1(riga))-reccontrollo.or_x;
  YOgg:=str_tofloat(leggiidentif1(riga))-reccontrollo.or_Y;
  ZOgg:=str_tofloat(leggiidentif1(riga))+Z_piano;
  if tipo='L' then
    begin
    X1Ogg:=str_tofloat(leggiidentif1(riga))-reccontrollo.or_x;
    Y1Ogg:=str_tofloat(leggiidentif1(riga))-reccontrollo.or_y;
    Z1Ogg:=str_tofloat(leggiidentif1(riga))+Z_piano;
    end
  else
    begin
    X1Ogg:=0;
    Y1Ogg:=0;
    Z1Ogg:=0;
    end;
  Proprieta_PJB(Piano_cor_mem,rete_cor_mem,isrete_cor_mem,tipo,xogg,yogg,zogg,x1ogg,y1ogg,z1ogg);
  end;
end;
Procedure AffiancaPJB;
begin
with form1 do
  begin
  showpjb;
  top:=screen.DesktopTop;
  left:=round(screen.DesktopWidth/2+screen.DesktopLeft);
  Width:=round(screen.DesktopWidth/2);
  Height:=screen.DesktopHeight;
  end;
end;

Procedure file_debug_pjb(riga:string);
Var ffdeb:textfile;
const nomefdeb='debugpjb.txt';
begin
assign(ffdeb,I_sl(percorsodrive)+nomefdeb);
if riga='DELETE' then
  begin
  deletefile(pchar(I_sl(percorsodrive)+nomefdeb));
  exit;
  end;
if not fileexists(I_sl(percorsodrive)+nomefdeb) then
rewrite(ffdeb)
else
append(ffdeb);
writeln(ffdeb,riga);
close(ffdeb);
end;

Function Ind_piano_cor_mem:integer;
begin
result:=1;
while (result<npiani)and(uppercase(piano_cor_mem)<>uppercase(piani_d^[result].Cod)) do inc(result);
end;

Procedure salva_temp;
begin
cancellafileestensione(perc_work,'TXE');
cancellafileestensione(perc_work,'rep');
cancellafileestensione(perc_work,'int');
cancellafileestensione(perc_work,'fin');
CopiaCartellaEstenzione(percorsodrive,perc_work,'rep');
CopiaCartellaEstenzione(percorsodrive,perc_work,'int');
CopiaCartellaEstenzione(percorsodrive,perc_work,'txe');
CopiaCartellaEstenzione(percorsodrive,perc_work,'fin');
end;

Procedure Cerca_anomalia(nomebl:string);
begin
if (uppercase(copy(nomebl,1,3))='LOC') and (uppercase(isrete_cor_mem)<>'EDIFICIO') then
anomalia:='locale';
if (uppercase(copy(nomebl,1,3))='FIN') and (uppercase(isrete_cor_mem)<>'EDIFICIO') then
anomalia:='finestra';
if (uppercase(copy(nomebl,1,3))='PON') and (uppercase(isrete_cor_mem)<>'EDIFICIO') then
anomalia:='finestra';
if (uppercase(copy(nomebl,1,5))='IRETE') and (uppercase(isrete_cor_mem)='EDIFICIO') then
anomalia:='inizio rete';
if (uppercase(copy(nomebl,1,4))='TERM') and (uppercase(isrete_cor_mem)='EDIFICIO') then
anomalia:='terminale';
if (uppercase(copy(nomebl,1,7))='RIMRETE') and (uppercase(isrete_cor_mem)='EDIFICIO') then
anomalia:='rimando rete';
if (uppercase(copy(nomebl,1,7))='RIPRETE') and (uppercase(isrete_cor_mem)='EDIFICIO') then
anomalia:='ripresa rete';
end;



Var Ftabcol:textfile;
    Num_tabcol:integer;
    Ar_tabcol:array[1..maxstrutture]of
    record
    codarch,coloreLn,ColoreNuovo:string[12];
    end;
    Dati_trasmessi:boolean=false;




Procedure scrivi_controllo(cod:string);
Var fcontrollo:textfile;
begin
assign(fcontrollo,filecontrollo(cod));
rewrite(fcontrollo);
with reccontrollo do
  begin
  writeln(Fcontrollo,float_to_str(angolo,8));
  writeln(Fcontrollo,float_to_str(or_x,8));
  writeln(Fcontrollo,float_to_str(or_y,8));
  writeln(Fcontrollo,float_to_str(Altnetta,8));
  end;
close(fcontrollo);
end;




Procedure Cambia_colori_1(ent_inizio,ent_fine:integer);
Var i,j,k:integer;
    trov:boolean;
    coltemp:string;
begin
if (modopjb)and(not colori_cambiati)then exit;
if Num_tabcol=0 then exit;
for i:=ent_inizio to ent_fine do
with entita_d^[i]^ do
if cod='L' then
  begin
  coltemp:=uppercase(colore_CAD(strtoint(colore)));
  j:=0;
  trov:=false;
  while (j<Num_tabcol)and(not trov) do
    begin
    inc(j);
    trov:=coltemp=ar_tabcol[j].coloreLn;
    if trov then colore:=ar_tabcol[j].ColoreNuovo;
    end;
  end;
end;
Procedure Cambia_colori;  //per conpatibilita con vecchie funzioni
begin
Cambia_colori_1(1,Nentita);
end;


Procedure Leggi_tabcol(edif:boolean;Codelab:string);
Var Buf:string;
begin
num_tabcol:=0;
//if edif then
  begin
  if fileexists(Codelab+'.TCE') then
    begin
    assign(Ftabcol,Codelab+'.TCE');
    reset(Ftabcol);
    while not eof(Ftabcol) do
      begin
      inc(num_tabcol);
      readln(ftabcol,buf);
      azzeraidentif;
      ar_tabcol[num_tabcol].codarch:=leggiidentif1(buf);
      ar_tabcol[num_tabcol].coloreLn:=uppercase(leggiidentif1(buf));
      end;
    close(Ftabcol);
    end;
  end
//else
  //begin
  //end;
end;

Procedure Aggiorna_dxf(PianoC,ReteC,IsreteC:string);
Var i:integer;
begin
AzzeraDXf;
set_indice_piano(pianoc);
Input_dxf(nome_dxf(PianoC,ReteC,IsreteC),false);
CaricaInputDXF(true,false,false);
if isreteC='EDIFICIO' then
  begin
  Apripiano(true,PianoC);
  AzzeraDXf;
  DxfEdificio(PianoC);
  for i:=1 to nentita do
    begin
    entita_d^[i].X1:=entita_d^[i].X1+piani_d^[posiz_piano].allineax;
    entita_d^[i].X2:=entita_d^[i].X2+piani_d^[posiz_piano].allineax;
    entita_d^[i].Y1:=entita_d^[i].Y1+piani_d^[posiz_piano].allineaY;
    entita_d^[i].Y2:=entita_d^[i].Y2+piani_d^[posiz_piano].allineaY;
    end;
  Add_BloccoDxf(piani_d^[posiz_piano].allineaX,piani_d^[posiz_piano].allineaY,0,0,'ALLINEA','EDIFICIO');
  end
else
  begin
  AzzeraDXf;
  caricadistubi(ReteC,PianoC,true);
  Dxf_rete(ReteC,PianoC,false);
  end;
Output_dxf(nome_dxf(PianoC,ReteC,IsreteC));
piani_d^[posiz_piano].allineax:=0;
piani_d^[posiz_piano].allineay:=0;
end;

function aggiorna_simboli(PianoC,ReteC,IsreteC:string):boolean;
Var data1,data2:integer;
    sr:tsearchrec;
begin
result:=false;
{
//exit;
data1:=fileage(i_sl(percorsodrive)+'definizione simboli.dxf');
//showmessage(i_sl(percorsodrive)+'definizione simboli.dxf'+chr(13)+DateTimeToStr(FileDateToDateTime(data1)));
data2:=fileage(nome_dxf(PianoC,ReteC,IsreteC));
//showmessage(nome_dxf(PianoC,ReteC,IsreteC)+chr(13)+DateTimeToStr(FileDateToDateTime(data2)));
}
//if data1>data2 then
if fileexists(i_sl(percorsodrive)+'aggiornasimboli.txt') then
  begin
  showmessage('Aggiornamento simboli del disegno');
  //result:=true;
  Aggiorna_dxf(PianoC,ReteC,IsreteC)
  end;
end;
Function Cambiaticolori(PianoC,ReteC,IsreteC:string):boolean;
Var i,j,data1,data2:integer;
    edif,trov:boolean;
    sr:tsearchrec;
begin
result:=false;

if aggiorna_simboli(PianoC,ReteC,IsreteC)then exit;

edif:=IsreteC='EDIFICIO';
Leggi_tabcol(edif,Nome_dis(PianoC,ReteC,IsreteC));
if (num_tabcol=0) then exit;
if edif then
  begin
  Leggi_mem_Strutture;//(dmtutti.T_Strutture,dmtutti.T_Strati,dmtutti.ds_Strutture);
  if (Nstrutture=0) then exit;
  i:=0;
  while (i<num_tabcol) do
    begin
    inc(i);
    j:=0;
    trov:=false;
    while (j<Nstrutture)and(not trov) do
      begin
      inc(j);
      trov:=ar_tabcol[i].codarch=strutture_d^[j].nfile;
      if trov then
        begin
        if not result then result:=uppercase(ar_tabcol[i].coloreLN)<>uppercase(strutture_d^[j].colcad);
        ar_tabcol[i].ColoreNuovo:=inttostr(indcolore(strutture_d^[j].colcad));
        end;
      end;
    end;
  end
else
  begin
  Leggi_mem_TipiRete{(dmtutti.T_TipiRete,dmtutti.T_DiametriB,dmtutti.ds_TipiRete)};
  if (NTipiRete=0) then exit;
  i:=0;
  while (i<num_tabcol) do
    begin
    inc(i);
    j:=0;
    trov:=false;
    while (j<NTipiRete)and(not trov) do
      begin
      inc(j);
      trov:=ar_tabcol[i].codarch=TipiRete_D^[j].colore;
      if trov then
        begin
        if not result then result:=uppercase(ar_tabcol[i].coloreLN)<>uppercase(TipiRete_D^[j].colore);
        ar_tabcol[i].ColoreNuovo:=inttostr(indcolore(TipiRete_D^[j].colore));
        end;
      end;
    end;
  end;
//if result then showmessage('Colori cambiati');
end;
Function Cambiati_colori(PianoC,ReteC,IsreteC:string):boolean;
begin
if modopjb then
  begin
  result:=true;
  colori_cambiati:=Cambiaticolori(PianoC,ReteC,IsreteC);
  end
else result:=Cambiaticolori(PianoC,ReteC,IsreteC)
end;
Procedure Salva_Tabcol;
Var i:integer;
begin
if isrete_cor_mem='EDIFICIO' then
  begin
  if Piano_cor_mem='' then
  showmessage('nome vuoto');
  assign(Ftabcol,nome_dis(Piano_cor_mem,rete_cor_mem,isrete_cor_mem)+'.TCE');
  rewrite(Ftabcol);
  for i:=1 to Nstrutture do
  if strutture_d^[i].parsof='PARETE' then
  if strutture_d^[i].colcad<>'' then
    begin
    write(ftabcol,strutture_d^[i].nfile,':');
    writeln(ftabcol,strutture_d^[i].colcad);
    end;
  close(Ftabcol);
  end
else
  begin
  if Piano_cor_mem='' then
  showmessage('nome vuoto');
  assign(Ftabcol,nome_dis(Piano_cor_mem,rete_cor_mem,isrete_cor_mem)+'.TCE');
  rewrite(Ftabcol);
  for i:=1 to NTipiRete do
  if TipiRete_D^[i].colore<>'' then
    begin
    write(ftabcol,TipiRete_D^[i].cod,':');
    writeln(ftabcol,TipiRete_D^[i].colore);
    end;
  close(Ftabcol);
  end
end;

Procedure EasyControllaDis;
Var nomedis:string;
begin
openudbt;
AzzeraDXf;
with V_recconfcad do
  begin
  nomedis:=perc_work+'Edificio_'+V_recconfcad.pianocor+'.dxf';
  Input_dxf(nomedis,false);
  CaricaInputDXF(false,false,false);
  showmessage(erroreneldisegno);
  if erroreneldisegno<>letturacorretta then
    begin
    end
  end;
//closeudbt; ???
end;
Procedure set_indice_piano(nomep:string);
Var i:integer;
begin
i:=1;
while (i<Npiani)and(uppercase(nomep)<>uppercase(Piani_d^[i].Cod))do inc(i);
indice_piano:=Piani_d^[i].Indice;
posiz_piano:=i;
end;
Procedure AttivaPjb;
begin
Bloccaredraw:=true;
nocambia:=true;
openudbt;
end;
Procedure DisAttivaPjb;
begin
Closeudbt;
//nocambia:=false;
end;
Procedure salva_dis_cor;
begin
if Piano_cor_mem='' then exit;
if isrete_cor_mem ='EDIFICIO' then
  begin
  deletefile(pchar(filecontrollo(Piano_cor_mem)));
  end
else
  begin
  if rete_cor_mem='' then exit;
  deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+piano_cor_mem+'.U2d'));
  deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+piano_cor_mem+'.T2d'));
  end;
if salva_disegno then
  begin
  Output_dxf_col(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
  if isrete_cor_mem ='EDIFICIO' then
    begin
    Tutto_grigio:=true;
    Output_dxf_col(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
    Tutto_grigio:=false;
    end;
  end;
trasmesso_disegno:=false;
end;
function Salva_mem(nomepc:Pchar;chiudi:boolean):boolean;
Var Nome:string;
begin
result:=L_inmemoria;
if L_inmemoria then
  begin
  Nome:=strpas(nomepc);
  if trasmesso_disegno then
  if uppercase(nome)=uppercase(progcor) then
    begin
    salva_dis_cor;
    file_debug_pjb('//commento Creato DXF '+nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
    end
  else progcor:=nome;
  //if chiudi then
    begin
    AttivaPjb;
    Nentita:=0;
    Salva_Entita(dmtutti.T_Entita,dmtutti.T_attributi,dmtutti.ds_entita);
    SaveUdBT(nome);
    //aggiornamento risultati di calcolo
    salva_temp;
    DisattivaPjb;
    end;
  ///Salva_progetto_compattato(pchar(copy(nome,1,length(nome)-4)+'.BMT'));
  end;
end;
Function Apri_mem(nomeprog:Pchar):boolean;
Var Nome,percorso:string;
begin
result:=L_inmemoria;
if L_inmemoria then
  begin
  AttivaPjb;
  Sblocca_files(percorsodrive,'int');
  Sblocca_files(percorsodrive,'rep');
  Sblocca_files(percorsodrive,'txe');
  Sblocca_files(percorsodrive,'fin');

  if (fileexists(progcor))and(progcor<>nomeprog)then
  SaveUdBT(Progcor);
  Setta_progetto(strpas(nomeprog));
  nome:=extractfilename(strpas(nomeprog));
  nome:=copy(nome,1,length(nome)-4);
  percorso:=extractfilepath(strpas(Nomeprog));
  Apri_progetto(strpas(Nomeprog),true);
  perc_progcor:=i_sl(percorso)+'work_'+nome+'\';
  Leggi_mem_piani;
  //aggiornamento risultati di calcolo
  CopiaCartellaEstenzione(perc_work,percorsodrive,'int');
  CopiaCartellaEstenzione(perc_work,percorsodrive,'rep');
  CopiaCartellaEstenzione(perc_work,percorsodrive,'txe');
  CopiaCartellaEstenzione(perc_work,percorsodrive,'fin');
  //Aggiorna_liberi; riguarda la versione cad
  DisAttivaPjb;
  azzera_Lettura_In_memoria;
  end;
end;
function showpjb_mem:boolean;
begin
result:=L_inmemoria;
if L_inmemoria then
  begin
  progress_3d(-2,'Aggiornamento 3D');
  //salva_dis_cor;
  //azzera_Lettura_In_memoria;
  //form1.Caption:='ProjectBrowser , in licenza a: '+cliente;
  Bloccaredraw:=true;
  nocambia:=true;
  openUdbT;
  AggiornaLetturaEdificio;
  solo3d;
  form1.display(false);
  form1.show;
  form1.pagecontrol4.ActivePageIndex:=0;
  closeUdbT;
  Bloccaredraw:=true;
  progress_3d(-1,'Aggiornamento 3D');
  end;
end;

Procedure chiudiPjb_mem;
begin
if L_inmemoria then
  begin
  copyfile(pchar(nome_dxf(piano_cor_mem,rete_cor_mem,isrete_cor_mem)),pchar(i_sl(percorsodrive)+'Disegno.dxf'),false);
  end;
end;

function NuovoProgetto_mem:boolean;
begin
if L_inmemoria then
  begin
  //CancellaFileestensione(perc_work,'dxf'); da problemi
  //CancellaFileestensione(perc_work,'TCE');
  azzera_Lettura_In_memoria;
  end;
end;
function NuovoProgetto_mem_salva:boolean;
begin
if L_inmemoria then
  begin
  AttivaPjb;
  if fileexists(progcor) then SaveUdBT(Progcor);
  DisAttivaPjb;
  end;
end;
Procedure Azzera_dxf;
begin
PiantaEsterna:='';
Nentita:=0;
end;

Procedure Init_Lettura_In_memoria;
begin
//L_inmemoria:=fileexists(i_sl(percorsodrive)+'Farfalla.txt');
L_inmemoria:=true;
isrete_cor_mem:=leggi_var('is_prec_cad');
Piano_cor_mem:=leggi_var('Piano_prec_cad');
pianocor:=Piano_cor_mem;
rete_cor_mem:=leggi_var('rete_prec_cad');
with reccontrollo do
  begin
  or_x:=0;
  or_y:=0;
  end;
end;
Procedure azzera_Lettura_In_memoria;
begin
isrete_cor_mem:='EDIFICIO';
Piano_cor_mem:='';
rete_cor_mem:='';
Salva_var('Piano_prec_cad',Piano_cor_mem);
Salva_var('rete_prec_cad',rete_cor_mem);
Salva_var('is_prec_cad',isrete_cor_mem);
end;

Procedure Inserisci_riprese(piano,rete:string);
Var i:integer;
    Xor_pia,Yor_pia,xx_bl,yy_bl,zz_bl,angbl:real;
    frim:textfile;
    buf,ttt,nomerim,nomebl:string;
begin
leggi_mem_piani;
leggi_controllo(piano);
Xor_pia:=reccontrollo.Or_x;
Yor_pia:=reccontrollo.Or_Y;
for i:=1 to Npiani do
with piani_d^[i] do
if uppercase(cod)<>uppercase(piano) then
  begin
  if fileexists(nome_dis(cod,rete,'RETE')+'.rim') then
  if fileexists(filecontrollo(cod)) then
    begin
    leggi_controllo(cod);
    assign(frim,nome_dis(cod,rete,'RETE')+'.rim');
    reset(frim);
    while not eof(frim) do
      begin
      readln(frim,buf);
      azzeraidentif;
      nomebl:=uppercase(leggiidentif1(buf));
      if (pos('RIMRETE',nomebl)<>0) then
        begin
        nomerim:=uppercase(leggiidentif1(buf));
        if (pos('COLONNA',nomerim)<>0)or (nomerim=uppercase(piano)) then
          begin
          xx_bl:=str_tofloat(leggiidentif1(buf));
          yy_bl:=str_tofloat(leggiidentif1(buf));
          zz_bl:=str_tofloat(leggiidentif1(buf));
          angbl:=str_tofloat(leggiidentif1(buf));
          xx_bl:=xx_bl-reccontrollo.Or_x+xor_pia;
          yy_bl:=yy_bl-reccontrollo.Or_y+yor_pia;
          Add_BloccoDxf_col(xx_bl,yy_bl,0,angbl,'RIPRETE'+nomebl[8],'RETE','3');
          Add_Attrib_Dxf('CODICE',nomerim);
          end;
        end;
      end;
    close(frim);
    end;
  end;
leggi_controllo(piano);
end;

function Cambia_Dis_mem(piano,rete,isrete:string):boolean;
Var i:integer;
begin
Bloccaredraw:=true;
nocambia:=true;
openUdbT;
result:=L_inmemoria;
if not L_inmemoria then exit;
Leggi_mem_piani;
if (piano='')or((rete='')and(isrete<>'EDIFICIO')) then
  begin
  showmessage('Cambiamento disegno ,identificazione disegno irregolare  Piano:'+Piano+' Rete:'+rete);
  exit;
  end;
if isrete='EDIFICIO' then rete:='';
result:=false;
if L_inmemoria then
  begin
  result:=true;
  if (isrete_cor_mem<>'')and(piano_cor_mem<>'') then
    begin
    if salva_disegno then
      begin
      file_debug_pjb('//commento Creato DXF '+nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
      Output_dxf_col(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
      if isrete_cor_mem='EDIFICIO' then
        begin
        tutto_grigio:=true; // da utilizzare in visualizza piano precedente successiovo
        Output_dxf_col(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
        tutto_grigio:=false;
        deletefile(pchar(filecontrollo(Piano_cor_mem)));
        end
      else
        begin
        deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+piano_cor_mem+'.U2d'));
        deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+piano_cor_mem+'.T2d'));
        end;
      end;
    trasmesso_disegno:=false;
    end;
  if fileexists(nome_dxf(Piano,rete,isrete)) then
    begin
    if cambiati_colori(piano,rete,isrete) then
      begin
      AzzeraDXf;
      input_dxf(nome_dxf(Piano,rete,isrete),false);
      cambia_colori;
      if modopjb then
        begin
        for i:=2 to Nentita  do
        with entita_d^[i]^ do
        if (cod='B')and(nomebl='RIFEST')then
        valido:='N';
        leggi_mem_piani;
        set_indice_piano(piano);
        PiantaEsterna:=perc_work+Piani_D^[posiz_piano].Rif_Pianta;
        scalapiantaesterna:=Piani_D^[posiz_piano].ScalaP;
        Add_BloccoDxf_col(0,0,0,0,'RIFEST','PIANTA','1');
        end;
      output_dxf(i_sl(percorsodrive)+'Disegno.dxf');
      //SalvaPOsa;
      end
    else
    copyfile(pchar(nome_dxf(Piano,rete,isrete)),pchar(i_sl(percorsodrive)+'Disegno.dxf'),false)
    end
  else
    begin
    AzzeraDXf;
    if isrete<>'EDIFICIO' then Inserisci_riprese(piano,rete);
    output_dxf(i_sl(percorsodrive)+'Disegno.dxf');
    end;
  pianocor:=piano;
  isrete_cor_mem:=isrete;
  piano_cor_mem:=piano;
  rete_cor_mem:=rete;
  salva_var('is_prec_cad',isrete_cor_mem);
  salva_var('Piano_prec_cad',piano_cor_mem);
  salva_var('rete_prec_cad',rete_cor_mem);
  end;
closeUdbt;
end;

Var Num_amb_mem,C_ent:integer;
    Blocco_cor:string;
Procedure Out_entita(Ent:pchar);
Var EE,VV:string;

Procedure Funz_cor(ff:string);
Var i:integer;
begin
ff:=uppercase(ff);
Funzione_cor:=NoFunz;
if pos('LETTURA',ff)<>0 then
  begin
  Dati_trasmessi:=true;
  if isrete_cor_mem='EDIFICIO' then
    begin
    deletefile(pchar(filecontrollo(Piano_cor_mem)));
    Funzione_cor:=LetturaEdificio;
    ultft:=0;
    Num_amb_mem:=0;
    CopiaLetturadisegno3d.ultblocco:=0;
    minimox:=10E6;
    minimoy:=10E6;
    end
  else
    begin
    Funzione_cor:=LetturaRete;
    with dmtutti do
      begin
      leggi_reti(T_reti,T_reti,Ds_reti);
      leggi_Piani(T_Piani,T_PPiano,Ds_Piani);
      end;

    leggi_controllo(piano_cor_mem);  //spostamento origine rete

    indice_rete:=1;
    while (indice_rete<NGen)and(uppercase(GENERALITA_D1^[indice_rete].Codice)<>uppercase(rete_cor_mem)) do
    inc(indice_rete);
    deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+piano_cor_mem+'.U2d'));
    deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+piano_cor_mem+'.T2d'));
    Azzera_lettura;
    ultft:=0;
    end;
  end
else
if pos('SALVA',ff)<>0 then
  begin
  if isrete_cor_mem='EDIFICIO' then
    begin
    CopiaLetturadisegno3d.ultblocco:=0;
    Leggi_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
    set_indice_piano(Piano_cor_mem);
    //deletefile(pchar(filecontrollo(Piano_cor_mem)));  da gestire meglio
    trasmesso_disegno:=true;
    file_debug_pjb('//commento Out_entità : Salvaedificio');
    Funzione_cor:=SalvaEdificio;
    azzera_dxf;
    if fileexists(perc_work+piano_cor_mem+'.all') then deletefile(pchar(perc_work+piano_cor_mem+'.all'));
    end
  else
    begin
    salva_rimandi_dxf:=true;
    //deletefile(pchar(filecontrollo(Piano_cor_mem)));
    deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+piano_cor_mem+'.U2d'));
    deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+piano_cor_mem+'.T2d'));
    if fileexists(perc_work+'Elaborato_'+rete_cor_mem+'_'+piano_cor_mem+'.dxf') then deletefile(pchar(perc_work+'Elaborato_'+rete_cor_mem+'_'+piano_cor_mem+'.dxf'));
    trasmesso_disegno:=true;
    file_debug_pjb('//commento Out_entità : SalvaRete');
    Funzione_cor:=SalvaRete;
    azzera_dxf;
    end;
  end;
end;
procedure Settamin(px,py:real);
begin
if px<minimox then minimox:=px;
if py<minimoy then minimoy:=py;
end;
Procedure Selez_ln_3d(x1_l3d,y1_l3d,z1_l3d,x2_l3d,y2_l3d,z2_l3d:real);
begin
exit;
if isrete_cor_mem<>'EDIFICIO' then
  begin
  Valid_lineasel_3d:=true;
  leggi_controllo(isrete_cor_mem);
  lineasel_3d.piano:=piano_cor_mem;
  lineasel_3d.x1:=x1_l3d-reccontrollo.or_x;
  lineasel_3d.y1:=y1_l3d-reccontrollo.or_y;
  lineasel_3d.z1:=z1_l3d;
  lineasel_3d.x2:=x2_l3d-reccontrollo.or_x;
  lineasel_3d.y2:=y2_l3d-reccontrollo.or_y;
  lineasel_3d.z2:=z2_l3d;
  end;
end;

Procedure Add_linea_funz;
Var xl1,yl1,zl1,xl2,yl2,zl2:real;llayer,lcolore,ltlinea:string;
    i:integer;
begin
  case Funzione_cor of
  LetturaEdificio:
  if not lnsovrap then
    begin
    inc(ultft);
    with Ft^[ultft]  do
       begin
       x0:=str_tofloat(leggiidentif1(EE))*FattoreDiscala;
       y0:=str_tofloat(leggiidentif1(EE))*FattoreDiscala;
       z0:=str_tofloat(leggiidentif1(EE))*FattoreDiscala;
       x1:=str_tofloat(leggiidentif1(EE))*FattoreDiscala;
       y1:=str_tofloat(leggiidentif1(EE))*FattoreDiscala;
       z1:=str_tofloat(leggiidentif1(EE))*FattoreDiscala;
       for i:=1 to ultft-1 do
         begin
         if not lnsovrap then
         if Sovrapposte(x0,x1,Ft^[i].x0,Ft^[i].x1,y0,y1,Ft^[i].y0,Ft^[i].y1,10)<>0 then
           begin
           lnsovrap:=true;
           Sovrapx:=(x0+x1)/2;
           sovrapy:=(y0+y1)/2;;
           end;
         end;
       settamin(x0,y0);
       settamin(x1,y1);
       end;
    end;
  LetturaRete:
    begin
    xl1:=str_tofloat(leggiidentif1(EE))-reccontrollo.Or_x;
    yl1:=str_tofloat(leggiidentif1(EE))-reccontrollo.Or_y;
    zl1:=str_tofloat(leggiidentif1(EE));
    xl2:=str_tofloat(leggiidentif1(EE))-reccontrollo.Or_x;
    yl2:=str_tofloat(leggiidentif1(EE))-reccontrollo.Or_y;
    zl2:=str_tofloat(leggiidentif1(EE));
    Lcolore:=leggiidentif1(EE);
    LTlinea:=leggiidentif1(EE);
    lLayer:='RETE';
    //LTlinea:='Continuout';

    if  uppercase(Ltlinea)='FITTIZIA' then  //suddividi pannelli radianti
      begin
      inc(ultft);
      with Ft^[ultft]  do
         begin
         x0:=xl1*FattoreDiscala;
         y0:=yl1*FattoreDiscala;
         z0:=zl1*FattoreDiscala;
         x1:=xl2*FattoreDiscala;
         y1:=yl2*FattoreDiscala;
         z1:=zl2*FattoreDiscala;

         settamin(x0,y0);
         settamin(x1,y1);
         end;
       end;
    if (lLayer='RETE')and(uppercase(Ltlinea)<>'QUOTE')and(uppercase(Ltlinea)<>'FITTIZIA') then
      begin
      Selez_ln_3d(xl1,yl1,zl1,xl2,yl2,zl2);
      Add_Tubo_Inp(piano_cor_mem,xl1,yl1,zl1,xl2,yl2,zl2,'1',Ltlinea);
      Copia_Linea_Lettura;//Trasferisce da input a calcolo
      end;
    end;  
  SalvaEdificio,salvarete:
    begin
    xl1:=str_tofloat(leggiidentif1(EE));
    yl1:=str_tofloat(leggiidentif1(EE));
    zl1:=str_tofloat(leggiidentif1(EE));
    xl2:=str_tofloat(leggiidentif1(EE));
    yl2:=str_tofloat(leggiidentif1(EE));
    zl2:=str_tofloat(leggiidentif1(EE));
    lcolore:=leggiidentif1(EE);
    ltlinea:=leggiidentif1(EE);
    if Funzione_cor=SalvaEdificio then lLayer:='EDIFICIO'
    else lLayer:='RETE';
    Add_LineaDxf(xl1,yl1,zl1,xl2,yl2,zl2,llayer,lcolore,ltlinea);
    end;
  end;
end;

Procedure Add_Blocco_funz;
Var xbl,ybl,zbl,lang:real;
     Nomeb,llayer,colbl,ingx,ingy:string;
     fall:textfile;
begin
Xbl:=str_tofloat(leggiidentif1(EE));
ybl:=str_tofloat(leggiidentif1(EE));
zbl:=str_tofloat(leggiidentif1(EE));
lang:=str_tofloat(uppercase(leggiidentif1(EE)));
nomeB:=uppercase(leggiidentif1(EE));
cerca_anomalia(nomeb);
LLayer:=uppercase(leggiidentif1(EE));
colbl:=uppercase(leggiidentif1(EE));
if colbl='' then colbl:='1';
ingx:=uppercase(leggiidentif1(EE));
ingy:=uppercase(leggiidentif1(EE));
  case Funzione_cor of
  LetturaEdificio:
    begin
    if uppercase(copy(nomeb,1,3))='LOC' then
      begin
      inc(CopiaLetturadisegno3d.ultblocco);
      with Bll^[CopiaLetturadisegno3d.ultblocco] do
         begin
         inc(Num_amb_mem);
         Attrib1[1]:=inttostr(Num_amb_mem);//Numerazione provvisoria non valida in altri ambiti
         Nome:='AMB';
         x:=xbl*FattoreDiscala;
         y:=ybl*FattoreDiscala;
         end;
       end;
    end;
  LetturaRete:
  if LLayer='RETE' then
    begin
    blocco_cor:=nomeb;
    if copy(Nomeb,1,5)='IRETE' then
    with  GENERALITA_D1^[indice_rete] do
      begin
      xori:=xbl-reccontrollo.Or_x;
      yori:=ybl-reccontrollo.Or_y;
      zori:=zbl;
      Piano:=Piano_cor_mem;
      end
    else
    if copy(Nomeb,1,4)='TERM' then
      begin
      CaricaTerminale('??',float_To_str(xbl-reccontrollo.Or_x,10),float_To_str(ybl-reccontrollo.Or_y,10),float_To_str(zbl,10),'','','','','','','','','','','','','','','','','',piano_cor_mem,'','','','','','','');
      end
    else
    if (copy(Nomeb,1,7)='RIPRETE')or(copy(Nomeb,1,7)='RIMRETE') then
      begin
      Add_Rim_rete_mem(xbl-reccontrollo.Or_x,ybl-reccontrollo.Or_y,Nomeb);
      Copia_Linea_Lettura;//Trasferisce da input a calcolo
      end;
    end;
  SalvaEdificio,Salvarete:
    begin
    blocco_cor:=nomeb;
    //if Funzione_cor=SalvaEdificio then lLayer:='EDIFICIO'
    //else lLayer:='RETE';
    if nomeb='ALLINEA' then
      begin
      assign(fall,perc_work+piano_cor_mem+'.all');
      rewrite(fall);
      writeln(fall,'ALL:'+float_to_str(xbl,5)+':'+float_to_str(ybl,5)+':');
      close(fall);
      end;
    Add_BloccoDxf_col(xbl,ybl,zbl,LAng,nomeb,llayer,colbl);
    end;
  end;
end;

Procedure Numera_amb(Var numa:string);
begin
inc(CopiaLetturadisegno3d.ultblocco);
bll^[CopiaLetturadisegno3d.ultblocco].Attrib1[1]:=numa;
bll^[CopiaLetturadisegno3d.ultblocco].Nome:='AMB';
numa:=Numeralocale(CopiaLetturadisegno3d.Ultblocco,indice_piano);
end;


Var Coda,Vala,vala2:string;
    intval,num_piano,num_loc,ipc:integer;
begin
if not L_inmemoria then exit;
ee:=strpas(ent);
azzeraidentif;
vv:=leggiidentif1(EE);
if vv[1]='O' then
  begin
  file_debug_pjb('Out_entita('+strpas(Ent)+')');
  c_ent:=0;
  end
  else
  begin
  inc(c_ent);
  if c_ent<11 then file_debug_pjb('Out_entita('+strpas(Ent)+')');
  if c_ent=11 then file_debug_pjb('Omesse entità . . .');
  end;
  case vv[1] of
  'O':begin
      leggi_mem_piani;
      LnSovrap:=false;
      Funz_cor(leggiidentif1(EE));
      if funzione_cor=LetturaRete then  leggi_controllo(piano_cor_mem);
      end;
  'L':Add_linea_funz;
  'B':Add_Blocco_funz;
  'A':if Funzione_cor<>NoFunz then
      begin
      coda:=uppercase(leggiidentif1(EE));
      vala:=leggiidentif1(EE);
      vala2:=leggiidentif1(EE);
      if funzione_cor=LetturaRete then
        begin
        if (pos('TERM',uppercase(blocco_cor))<>0)and(coda='POTENZA')then
        add_pot_inp(str_tofloat(vala));
        end
      else
        begin
        //if coda='LINK' then
        //showmessage('Link');
        if (copy(blocco_cor,1,3)='LOC')and(coda='COD')then
          begin
          ipc:=ind_piano_cor_mem;
          num_piano:=Piani_d^[ipc].Indice;
          vala:=inttostr(num_piano*1000+strtoint(vala)mod(1000));
          end;
        if vala2<>'' then
        vala:=vala+':'+vala2;
        Add_Attrib_Dxf(coda,vala);
        end;
      end;
end;
//showmessage(vv);
end;

Procedure Scrivierrore;
Var Erinpgraf:textfile;
    bbe:string;
    count,i:integer;
    coloreln:string;
begin
assign(Erinpgraf,percorsodrive+'\errori_'+pianocor+'.txe');
rewrite(Erinpgraf);
Writeln(Erinpgraf,pianocor);
bbe:=erroreneldisegno;
bbe:=lowercase(bbe);
if bbe<>'' then
bbe[1]:=upcase(bbe[1]);
Writeln(Erinpgraf,bbe);

count:=0;   //alcuni locali non identificati con l'apposito simbolo
for i:=1 to LetturaDisegnoBidimensionale.ultimafrontiera do
if Ft^[i].error then inc(count);
if count>1 then
  begin
  errorex:=0;
  errorey:=0;
  end;
Writeln(Erinpgraf,floattostr(errorex/100));
Writeln(Erinpgraf,floattostr(errorey/100));
if count>1 then
  begin
  Nentita:=0;
  if npchiuso>0 then
    begin
    with Ft^[P_chiuso[1]] do
    Add_CerchioDxf(x0/100,y0/100,0,0.1,'0','1','Continuous'); //rosso
    with Ft^[P_chiuso[npchiuso]] do
      begin
      Add_CerchioDxf(x0/100,y0/100,0,0.1,'0','2','Continuous');//Giallo
      Add_CerchioDxf(x1/100,y1/100,0,0.1,'0','4','Continuous');//azzurro
      end;
    end;
  for i:=1 to LetturaDisegnoBidimensionale.ultimafrontiera do
  with Ft^[i] do
    begin
    Add_TestoDxf((x0/100+x1/100)/2,(y0/100+y1/100)/2,0,0,inttostr(i),'0','1');
    coloreln:='3'; //verde
    if (d='*') and (s='*') then coloreln:='2'; //Giallo
    if (d='*') and (s<>'*') then coloreln:='1'; // rosso
    if (d<>'*') and (s='*') then coloreln:='4'; // azzurro

    if (error)and((NPchiuso=0)or (i<>P_chiuso[npchiuso]))then
      begin
      Add_LineaDxf(x0/100,y0/100,0,x1/100,y1/100,0,'0','0','Continuous'); //Bianco
      Writeln(Erinpgraf,floattostr(x0/100));
      Writeln(Erinpgraf,floattostr(y0/100));
      Writeln(Erinpgraf,floattostr(x1/100));
      Writeln(Erinpgraf,floattostr(y1/100));
      end
    else Add_LineaDxf(x0/100,y0/100,0,x1/100,y1/100,0,'0',coloreln,'Continuous');
    Add_LineaDxf((x0+x1)/200,(y0+y1)/200,0,x1/100,y1/100,0,'0','5','Continuous'); //blu
    end;
  Output_dxf_col(i_sl(Percorsodrive)+'Errore lettura.dxf');
  end;
close(Erinpgraf);
end;




Function leggi_edificio_Inmemoria:boolean;
var i:integer;
    epan:string;
    epx,epy:real;
begin
result:=L_inmemoria;
if  L_inmemoria then
  begin
  if  Funzione_cor=LetturaEdificio then  deletefile(pchar(I_Sl(percorsodrive)+'\errori_'+Piano_cor_mem+'.txe'))
  else deletefile(pchar(I_Sl(percorsodrive)+'\errori_'+Piano_cor_mem+'_'+Rete_cor_mem+'.txe'));
  if dati_trasmessi then
    begin
    if  Funzione_cor=LetturaEdificio then
      begin
      dmtutti.T_confcad.open;
      Piano_cor_mem:=V_recconfcad.PIANOCOR;
      dmtutti.T_confcad.close;
      if Piano_cor_mem<>'' then
        begin
        pianocor:=Piano_cor_mem;
        spostaorigine;//disegno con coordinate < 0
        Analisi_disegno;
        RipristinaOrigine;
        Scrivierrore;
        end
      else showmessage('Piano corrente non valido');
      end
    else
      begin
      AttivaPjb;
      Anteprimareti;
      erroreneldisegno:=letturacorretta;
      if ultft>0 then //dividi pannelli radianti
      Analisi_disegno_pannelli(Piano_cor_mem,true,epan,epx,epy);
      Controllo_disegno(Rete_cor_mem,Piano_cor_mem,epan,epx/FATTOREDISCALA,epy/FATTOREDISCALA);
      DisAttivaPjb
      end;
    end
  else
    begin
    //showmessage('Irregolarità nel programma'+chr(13)+'Dati non trasmessi'+chr(13)+'Contattare l''assistenza.');
    showmessage('Disegno vuoto');
    if  Funzione_cor=LetturaEdificio then
    deletefile(pchar(filecontrollo(Piano_cor_mem)))
    else deletefile(pchar(i_sl(percorsodrive)+Rete_cor_mem+'-'+Piano_cor_mem+'.U2d'));
    end;
  Dati_trasmessi:=false;
  end;
end;

Var Fcontrollo:textfile;

function AggiornaLetturaEdificio:string;
Var i,jj:integer;
    errore,bufcontr,nomedis:string;
    unavolta,lettouno:boolean;

function Cancella_locali_vuoti:boolean;
var i,j,cdn,min_N,max_N,primo,ultimo,eliminati:integer;
begin
result:=false;
if Nambienti<>0 then
  begin
  primo:=0;
  for i:=1 to Nambienti do
  with ambienti_D^[i]^ do
    begin
    if codnum='' then
      begin
      if primo=0 then primo:=i
      end
    else
      begin
      if primo<>0 then
        begin
        ultimo:=i-1;
        break;
        end;
      end;
    end;
  eliminati:=Ultimo-primo+1;
  if primo<>0 then
    begin
    if Nambienti>Eliminati then
      begin
      for i:=primo to nambienti-eliminati do
      ambienti_D^[i]:=ambienti_D^[i+eliminati];
      end;
    nambienti:=Nambienti-eliminati;
    end;
  result:=primo<>0;
  end;
end;


Procedure Cancella_locali_piano;
var i,j,cdn,min_N,max_N,primo,ultimo,eliminati:integer;
begin
if Nambienti<>0 then
  begin
  primo:=0;
  min_n:=indice_piano*1000;
  max_n:=(indice_piano+1)*1000-1;
  for i:=1 to Nambienti do
  with ambienti_D^[i]^ do
    begin
    if codnum<>'' then
    cdn:=strtoint(codnum)
    else
      begin
      cdn:=0;
      //showmessage('Numerazione locale irregolare indice locale:'+inttostr(i)+' '+ambienti_D^[i]^.Denom);
      end;
    if (cdn>=min_n)and(cdn<=max_n) then
      begin
      codnum:='';
      if primo=0 then primo:=i;
      ultimo:=i;
      end;
    end;
  eliminati:=Ultimo-primo+1;
  if primo<>0 then
    begin
    if Nambienti>Eliminati then
      begin
      for i:=primo to nambienti-eliminati do
      ambienti_D^[i]:=ambienti_D^[i+eliminati];
      end;
    nambienti:=Nambienti-eliminati;
    end;
  end;
end;
Procedure Pulisci_locali;
Var iPiano,i,j:integer;
     trov:boolean;
begin
repeat until not (cancella_locali_vuoti);
for i:=1 to NAmbienti  do
if ambienti_D^[i].codnum<>'' then
 begin
 ipiano:=trunc(strtoint(ambienti_D^[i].codnum)/1000);
 trov:=false;
 for j:=1 to Npiani do
 if piani_d^[j].Indice=ipiano then
   begin
   trov:=true;
   break;
   end;
 if not trov then
   begin
   indice_piano:=ipiano;
   Cancella_locali_piano;
   end;
 end;
end;



Procedure controllo_piani;
Var i,j:integer;
begin
if npiani<2 then exit;
for i:=1 to npiani-1 do
for j:=i+1 to npiani do
  begin
  if Piani_D^[i].Indice= Piani_D^[j].Indice then
    begin
    showmessage('Numerazione dei piani irregolare ,contattare l''assistenza');
    exit;
    end;
  end;
end;
Procedure Init_controllo;
begin
if not unavolta then
  begin
  unavolta:=true;
  Leggi_archivi_lettura(false);
  end;
end;
Function Piani_copiati(indpiano:integer):string;
var i:integer;
begin
result:='';
for i:=1 to Npiani do
if i<>indpiano then
if piani_d^[i].CopiaDi=piani_d^[indpiano].cod then result:=result+piani_d^[i].cod;
end;
Var errore_1:string;
begin
if not L_inmemoria then exit;
errore_1:='';
controlla_dis:=false;
if salva_disegno then
   begin
   file_debug_pjb('//commento Generato DXF edificio '+nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
   Output_dxf_col(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
   tutto_grigio:=true; //serve per visualizza piano precedente o successivo
   Output_dxf_col(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
   tutto_grigio:=false;
   if fileexists(filecontrollo(piano_cor_mem))then
   deletefile(pchar(filecontrollo(piano_cor_mem)));
   end
else Non_salvato;
unavolta:=false;
lettouno:=false;
result:='';
Leggi_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
Leggi_mem_Locali;
controllo_piani;
Pulisci_locali;
Salva_Locali(dmtutti.T_Locali,dmtutti.T_Pareti,dmtutti.ds_Locali);
i:=0;
while (i<Npiani)and(errore='') do
  begin
  inc(i);
  with  Piani_D^[i] do
    begin
    dmtutti.T_ConfCad.Edit;
    V_recconfcad.set_PIANOCOR(cod);
    dmtutti.T_ConfCad.POst;
    dmtutti.T_ConfCad.Edit;
    errore:='';

    if copiadi='' then
    if not Leggi_controllo(cod) then errore:='Da controllare';

    if copiadi='' then
    if (errore<>'')or(reccontrollo.angolo<>V_recconfcad.AngNord)or
        (reccontrollo.Altnetta<>AltN)or
        (reccontrollo.copiadi<>Piani_copiati(i))then
      begin
      deletefile(pchar(filecontrollo(cod)));
      nomedis:=nome_dxf(cod,'','EDIFICIO');
      if fileexists(nomedis) then
        begin
        progress_3d(step_prog(i,Npiani),'lettura disegno del piano: '+cod);
        init_controllo;
        AzzeraDXf;
        for jj:=1 to Npiani do    //Cancella i locali dei cloni
        if (jj<>i)and(uppercase(cod)=uppercase(piani_D^[jj].copiadi)) then
          begin
          indice_piano:=piani_D^[jj].Indice;
          Cancella_locali_piano;
          end;
        set_indice_piano(cod);
        Cancella_locali_piano;
        Input_dxf(nomedis,false);
        CaricaInputDXF(false,false,false);
        lettouno:=true;
        //controlla_vuoti;
        if erroreneldisegno=letturacorretta then
          begin
          errore:='';
          reccontrollo.angolo:=V_recconfcad.AngNord;
          reccontrollo.or_x:=piani_d^[i].allineax;
          reccontrollo.or_y:=piani_d^[i].AllineaY;
          reccontrollo.copiadi:=Piani_copiati(i);
          reccontrollo.Altnetta:=AltN;
          scrivi_controllo(cod);
          end
        else errore:='Errori al piano '+cod+chr(13)+erroreneldisegno;
        end
      else errore:='';// il piano non è stato disegnato es. solo reti
      //else errore:='Il disegno dell''edificio al piano:'+copy(nomedis,1,length(nomedis)-4)+' non è stato realizzato.';
      end;
    end;
  if errore<>'' then // serve per fare il 3d quando il disegno non è completo su tutti i piani
    begin
    errore_1:=errore;
    errore:='';
    end;
  end;
errore:= errore_1;// serve per fare il 3d quando il disegno non è completo su tutti i piani
for i:=1 to npiani do
with piani_d^[i] do
  begin
  allineax:=0;
  allineay:=0;
  end;

if salva_disegno then
  begin
  trasmesso_disegno:=false;
  copyfile(pchar(nome_dxf(Piano_cor_mem,'','EDIFICIO')),pchar(i_sl(percorsodrive)+'Disegno.dxf'),false);
  end;

controlla_vuoti;


result:=errore;
if lettouno then salva_archivi_lettura;

dmtutti.T_ConfCad.Edit;
V_recconfcad.set_PIANOCOR(piano_cor_mem);
dmtutti.T_ConfCad.POst;
dmtutti.T_ConfCad.Edit;
end;
Function Calcola_reti_memoria_vitt(nomer:string;esegui:boolean):boolean;
Var i,j:integer;
    error:boolean;
begin

if nomer<>'' then rete_cor_mem:=nomer;
Calcolo_rete_in_memoria:=true;
result:=false;
if not L_inmemoria then exit;
result:=true;
progress_3d(-2,'Aggiornamento dati dal disegno');

nocambia:=true;
openudbt;
if salva_disegno then
  begin
  file_debug_pjb('//comento Creato DXF '+nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
  Output_dxf_col(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem));
  deletefile(pchar(i_sl(percorsodrive)+rete_cor_mem+'-'+Piano_cor_mem+'.U2d'));
  Trasmesso_disegno:=false;
  end
else Non_salvato;
Leggi_Piani(dmtutti.T_Piani,dmtutti.T_PPiano,dmtutti.ds_Piani);
error:=false;
i:=1;
while (i<=Npiani)and(not error) do
  begin
  if fileexists(nome_dxf(piani_d^[i].cod,rete_cor_mem,'RETE')) then
  error:= not leggi_controllo(piani_d^[i].cod);
  inc(i);
  end;
{ Disattivato per calcolo senza dispersioni
if error then
  begin
  dmtutti.t_reti.edit;
  V_recgen.set_report('I calcoli delle dispersioni non sono aggiornati');
  dmtutti.t_reti.post;
  closeudbt;
  exit;
  end;
 }
for i:=1 to Npiani do
with piani_d^[i] do
if copiadi='' then
if not fileexists(i_sl(percorsodrive)+rete_cor_mem+'-'+cod+'.U2d') then
if fileexists(nome_dxf(cod,rete_cor_mem,'RETE')) then
  begin
  AzzeraDXf;
  leggi_controllo(cod);
  Input_dxf(nome_dxf(cod,rete_cor_mem,'RETE'),false);
  for j:=1 to nentita do
  with entita_d^[j]^ do
  with reccontrollo do
    begin
    x1:=x1-or_x;
    y1:=y1-or_y;
    if cod='L' then
      begin
      x2:=x2-or_x;
      y2:=y2-or_y;
      end;
    end;
  dmtutti.T_confcad.Edit;
  V_RecConfcad.set_pianocor(cod);
  dmtutti.T_confcad.POst;
  dis_esecutivo:=false;
  CaricaInputDXF(false,false,false);
  end;
progress_3d(50,'Calcolo rete:'+rete_cor_mem);
Set_rete_calc(rete_cor_mem);
if esegui then
   begin
  deletefile(pchar(I_sl(percorsodrive)+rete_cor_mem+'.D3D')); 
  Aggiorna_Calc_reti(rete_cor_mem);
  progress_3d(80,'Aggiornamento disegni');
  //Provvisorio
  //copyfile(pchar(nome_dxf(Piano_cor_mem,rete_cor_mem,isrete_cor_mem)),pchar(i_sl(percorsodrive)+'Disegno.dxf'),false);

  dis_esecutivo:=false;
  if fileexists(I_sl(percorsodrive)+rete_cor_mem+'.D3D')Then //calcoli corretti
  for i:=1 to Npiani do
  with piani_d^[i] do
  if copiadi='' then
  if fileexists(nome_dxf(cod,rete_cor_mem,'RETE')) then
    begin
    Caricadistubi(rete_cor_mem,cod,false);
    AzzeraDXf;
    Dxfrete(rete_cor_mem,cod);
    leggi_controllo(cod);
    for j:=1 to nentita do
    with entita_d^[j]^ do
    with reccontrollo do
      begin
      x1:=x1+or_x;
      y1:=y1+or_y;
      if cod='L' then
        begin
        x2:=x2+or_x;
        y2:=y2+or_y;
        end;
      end;
    output_dxf(nome_dxf(cod,rete_cor_mem,'RETE'));
    if uppercase(cod)=uppercase(Piano_cor_mem) then
    copyfile(pchar(nome_dxf(cod,rete_cor_mem,'RETE')),pchar(i_sl(percorsodrive)+'Disegno.dxf'),false);
    end;

  dmtutti.T_confcad.Edit;
  V_RecConfcad.set_pianocor(Piano_cor_mem);
  dmtutti.T_confcad.POst;
  end;
Closeudbt;
progress_3d(-1,'Calcolo rete:'+rete_cor_mem);
end;
Function Calcola_reti_memoria(nomer:string):boolean;
begin
result:=Calcola_reti_memoria_vitt(nomer,true);
end ;
Procedure Aggiorna_reti(rete:pchar);
begin
Calcola_reti_memoria_vitt(strpas(rete),false);
end;
end.
