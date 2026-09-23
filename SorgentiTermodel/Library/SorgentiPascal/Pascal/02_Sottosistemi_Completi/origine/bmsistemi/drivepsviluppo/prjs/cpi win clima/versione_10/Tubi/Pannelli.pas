unit Pannelli;

interface
uses dialogs,definiz,sysutils,utireport,impterm,varcarichi,libreriagenerale,grafica2d,udatalink,
     setta_config_user,ugrafodxf,copiacaricatabelle,calcolo_tubi,progress3d;
Procedure CalcoloPannelli;
function Controllo_pannelli:boolean;
procedure setindserie(iserie,imodello:integer);
Procedure Set_indice_rete(codrete:string);


function Calc_dt(pot_r,sup,tmand,tint:real):real;
function TMandata:real;
function DtAcqua:real;
Function Maxmatassa:real;
Function MaxPerdCirc:real;


implementation

Procedure Carica_ind_zone;
Var i:integer;
begin
for i:=1 to Nambienti do
CercaZona(ambienti_D^[i]^.CodZona,ambienti_D^[i]^.zona);
end;

Function Is_aggre(ind:integer):boolean;
begin
result:=false;
if (ind>0) and(ind<=nambienti) then
result:=uppercase(copy(ambienti_d^[ind]^.Denom,1,6))='AGGRE-'
else showmessage('?');

end;

Function ind_aggre(ind:integer):integer;
Var ttt:string;
begin
result:=0;
if is_aggre(ind) then
  begin
  ttt:=ambienti_d^[ind]^.Denom;
  result:=strtoint(copy(ttt,7,length(ttt)-6));
  end;
end;

Function Cerca_Amb(Namb:string):Integer;
Var i:integer;
Begin
result:=0;
if Nambienti=0 then exit;
I:=1;
while (i<Nambienti) and (Ambienti_D^[i].CodNum<>Namb) do INC(I);
if(Ambienti_D^[i].CodNum=Namb) Then
result:=i;
end;

function CercaPrinc(Numamb:integer):integer;
Var ind_a:integer;
begin
ind_a:=cerca_amb(intTostr(numamb));
if is_aggre(ind_a) then
result:=ind_aggre(ind_a)
else result:=numamb;
end;


function Controllo_pannelli:boolean;
Var i,indserie,indmodello,indamb:integer;
    //ci_sono_pannelli:boolean;
procedure Ins_err(mess:string);
begin
with GTerm^[i]^ do
InserisciErrore('Terminale:'+cod+' '+mess,piano,xterm,yterm);
end;

begin
result:=true;
if (not attiva_pannelli)or(not ci_sono_pannelli) then exit;
Carica_ind_zone;
For i:=1 to NGTerm do
if result then
with GTerm^[i]^ do
if uppercase(copy(tipoterm,1,4))='PANN' then
  begin
  indserie:=Ind_terminale(serie,modello,indmodello);
  if  (indserie=0)or(indmodello=0) then
    begin
    result:=false;
    Ins_err('definizione tipologia scorretta modello'+modello+' serie:'+serie+' ')
    end
  else
  with Terminali_D^[indserie].dettaglioterminali[indmodello] do
    begin
    if sviluppo<=0 then
      begin
      Ins_err(modello+' '+serie+' dati di archivio del pannello errati sviluppo:'+float_to_str(sviluppo,2));
      result:=false;
      end;
    if result then
    if QlimRes<=0 then
      begin
      Ins_err(modello+' '+serie+' dati di archivio del pannello errati resa,residenziale:'+float_to_str(QlimRes,2));
      result:=false;
      end;
    if result then
    if QlimMarg<=0 then
      begin
      Ins_err(modello+' '+serie+' dati di archivio del pannello errati resa, marginale:'+float_to_str(QlimMarg,2));
      result:=false;
      end;
    end;
  if result then
    begin
    indamb:=cerca_amb(inttostr(NumAmb));
    if indamb=0 then
      begin
      result:=false;
      Ins_err('Terminale non agganciato ad un locale');
      end;
    end;
  if result then
  if ambienti_d^[indamb].Zona=0 then
    begin
    result:=false;
    Ins_err('Locale:'+ambienti_d^[indamb].CodNum+' ha zona errata.');
    end;
  if result then
  if zone_d^[ambienti_d^[indamb].Zona].TInv<=0 then
    begin
    result:=false;
    Ins_err('Zona:'+zone_d^[ambienti_d^[indamb].zona].Denom+' ha temperatura errata ( '+float_to_str(zone_d^[ambienti_d^[indamb].Zona].TInv,0)+' ) .');
    end;
  end;
end;

Var indserie,indmodello:integer;
     Errore_pannelli:string;
procedure setindserie(iserie,imodello:integer);
begin
indserie:=iserie;
indmodello:=imodello;
end;
Var Indice_rete:integer;
Procedure Set_indice_rete(codrete:string);
begin
Indice_rete:=1;
while (Indice_rete<maxgen)and(uppercase(GENERALITA_D1^[Indice_rete].Codice)<>uppercase(codrete))do inc(Indice_rete);
end;
Function Maxmatassa:real;
begin
result:=GENERALITA_D1^[indice_rete].Lungmatassa;
if result=0 then result:=120;
end;

Function MaxPerdCirc:real; // Pa
begin
//400 mbar =40 kpa
result:=GENERALITA_D1^[indice_rete].PerdmaxCirc*1000;
if result=0 then result:=40000;
end;

function TMandata:real;
begin
result:=GENERALITA_D1^[Indice_rete].TAcqua;
end;
function DtAcqua:real;
begin
result:=GENERALITA_D1^[Indice_rete].DTAcqua;
end;

function dtmedialog(tmand,trit,tint:real):real;
begin
result:=(Tmand-Trit)/ln((Tmand-Tint)/(trit-tint));
end;
function Calc_dt(pot_r,sup,tmand,tint:real):real;
Var dtm,dtm1,dt,dtsup,dtinf,densp:real;
    ciclo:integer;
begin
densp:=pot_r/sup;
with Terminali_D^[indserie].dettaglioterminali[indmodello] do
dtm:=(densp)*dttlimres/Qlimres;
dtm1:=dtmedialog(tmand,tmand-1,tint);
if dtm1<=dtm then
  begin
  result:=DtAcqua;
  exit;
  end;
dtsup:=tmand-tint-1;
dtinf:=1;
dt:=(dtsup-dtinf)/2;
ciclo:=0;
  repeat
  inc(ciclo);
  dtm1:=dtmedialog(tmand,tmand-dt,tint);
  if dtm1>dtm then
    begin
    dtinf:=dt;
    dt:=(dtsup+dt)/2;
    end
  else
    begin
    dtsup:=dt;
    dt:=(dtinf+dt)/2;
    end;
  until  (abs(dtm1-dtm)<0.01)or(ciclo>30);
result:=dt;
if tmand-result<=tint then
  begin
  Errore_pannelli:='Aumentare la temperatura dell''acqua in entrata';
  result:=tmand-tint+0.1;
  end;
end;


Procedure CalcoloPannelli;
//parametro lmax del disegno
const zona_res=0;
      zona_marg=1;
      zona_bagni=2;

Var i,j,k,indamb,ia1,itl,itl1,numambterm,numprincterm,princtemp,tempint,troncot,tipo_rete,count:integer;
    estranei,potestranei,lungtubo:real;
    RTempLoc:array[1..maxambienti]of
      record
      num:integer;
      estr,estr_int,prich,ptot,passo_res,supres,supcol,passo_marg,supmarg,sup_tot,sup_amb,res_sup:real;
      servizi:boolean;
      end;
    NtempLoc:integer;

Tamb,pot_amb,dens_sfav,dens_pot:real;
Loc_sfav:integer;
   unpannello:boolean;


function t_mandata(indamb:integer):real;
Var i:integer;
    cod_inp:string;
begin
with ambienti_d^[indamb]^ do
  begin
  if indimpianto=0 then
    begin
    cod_inp:=uppercase(impianto);
    i:=1;
    while (i<nimpianti) and (uppercase(impianto_d^[i].Codice)<>cod_inp)do inc(i);
    indimpianto:=i;
    end;
  result:=impianto_d^[i].InvTimmH2O;
  end;
end;
function indTloc(numloc:integer):integer;
Var k,ialoc:integer;
begin
//Individuazione aggregati
ialoc:=cerca_amb(inttostr(Numloc));
if ind_aggre(ialoc)<>0 then numloc:=ind_aggre(ialoc);
result:=0;
k:=1;
while (k<NtempLoc)and(RtempLoc[k].num<>numloc) do inc(k);
if RtempLoc[k].num=numloc then result:=k;
if result=0 then
  begin
  inc(NtempLoc);
  with RTempLoc[NtempLoc] do
    begin
    num:=numloc;
    prich:=0;
    estr:=0;
    estr_int:=0;
    ptot:=0;
    sup_tot:=0;
    sup_amb:=0;
    passo_res:=0;supres:=0;passo_marg:=0;supmarg:=0;
    supcol:=0;
    servizi:=false;
    end;
  result:=NtempLoc;
  end;
end;

//#35:Passo::Real:DEC#2:
//#36:QlimRes::Real:DEC#2:
//#37:Sviluppo::Real:DEC#2:
//#38:ResSup::Real:DEC#2:
//#39:DtTLimRes::Real:DEC#2:
//#40:RivSup::String[100]:CMB#Standard UNI EN 1264-3:CMB#Ceramica,marmo,granito:CMB#Linoleum,materiali plastici:CMB#Legno e tappeti di spessore ridotto:CMB#Legno e tappeti di grosso spessore:
//#41:QlimMarg::Real:DEC#2:
//#42:QlimBagni::Real:DEC#2:
//#43:RuRd::Real:DEC#2:
function tipo_zona(indterm:integer):integer;

begin
result:=round(GTerm^[indterm]^.LarghezzaMax);
end;
Procedure Potpannello;
begin
end;
Function troncoterm(indterm:integer):integer;
var jj:integer;
begin
jj:=1;while (jj<ulttronco)and(dati^[jj]^.Term<>indterm) do inc(jj);
result:=jj;
end;

Function resa_res:real;
begin
result:=Terminali_D^[indserie].dettaglioterminali[indmodello].Qlimres;
end;
Function resa_marg:real;
begin
result:=Terminali_D^[indserie].dettaglioterminali[indmodello].QlimMarg;
end;
Function sviluppo_tubi:real;
begin
result:=Terminali_D^[indserie].dettaglioterminali[indmodello].sviluppo;
end;


function Calc_pot(indtloc:integer;sup:real;zonares:boolean):real;
Var POtres:real;
begin
//se la potenza residenziale è sufficiente distribuzione omogenea
//altrimenti il marginale rende di più
with RtempLoc[indtloc] do
   begin
   if prich/sup_tot<=resa_res  then result:=prich/sup_tot*sup
   else
     begin
     if zonares then result:=resa_res*sup
     else
       begin
       potres:=supres*resa_res;
       if (Prich-potres)/supmarg>resa_marg then
       result:=resa_marg*sup
       else result:=(prich-potres)/supmarg*sup;
       end;
     end;
   end;
end;

Function Potenza_invernale_locale(Numterm,numamb:integer):real;
begin
if versione_trial_pannelli then result:=1000
else
  begin
  if GTerm^[Numterm]^.PotInp<>0 then result:=GTerm^[Numterm]^.PotInp
  else result:=PotenzaInvernaleLocale(numamb);
  end;
end;



Var numerocirc,numambint,numerocircterm:integer;
    areacirc,temp_est:real;
    inp_pot:boolean;
begin
Errore_pannelli:='';
deletefile(I_sl(percorsodrive)+V_recgen.Codice +'_pannelli.rep');
if (not attiva_pannelli)or(not ci_sono_pannelli) then exit;

//caricamento del vettore dei locali principali
Carica_ind_zone;
NTempLoc:=0;

// Identifica i locali con un valore di input fissato dall'utente per la potenza
// e carica la potenza e la superficie dei locali.
for i:=1 to nambienti do
  begin
  numambint:=strtoint(ambienti_d^[i]^.codnum);
  itl:=indTloc(numambint);  //Locale principale
  inp_pot:=false;
  for j:=1 to NGterm do
  with GTerm^[j]^ do
    begin
    numambterm:=Cercapuntoloc(xterm,yterm,Piano); //Locale di appartenenza
    if (numambterm=numambint)and((potinp<>0)or(Versione_trial_pannelli)) then
      begin
      if Versione_trial_pannelli then RtempLoc[itl].prich:=RtempLoc[itl].prich+1000
      else
      RtempLoc[itl].prich:=RtempLoc[itl].prich+potinp;
      inp_pot:=true;
      end;
    end;
  if not inp_pot then RtempLoc[itl].prich:=RtempLoc[itl].prich+PotenzaInvernaleLocale(numambint);
  RtempLoc[itl].sup_amb:=RtempLoc[itl].sup_amb+ambienti_d^[i]^.Superficie;
  end;


// Oltre a trovare il locale più sfavorito ricava la superficie pannellata
// ed raggruppa i dati degli aggregati



//Numerazione pannelli  evita i vuoti dovuti a locali non riempiti
for j:=1 to Npiani do
  begin
  count:=0;
  for i:=1 to NGTerm do
  if uppercase(piani_d^[j].Cod)=Uppercase(GTerm^[i]^.Piano) then
  if uppercase(copy(GTerm^[i]^.tipoterm,1,4))='PANN' then
     begin
     Inc(count);
     GTerm^[i]^.cod:=inttostr(count);
     end;
  end;
For i:=1 to NGTerm do
with GTerm^[i]^ do
if uppercase(copy(tipoterm,1,4))='PANN' then
  begin
  progress_3d(round(i/ngterm*100),'Calcolo pannelli,individuazione sfavorito');
  Numerocirc:=Cercapuntoloc_D(xterm,yterm,Piano); //circuito di appartenenza
  //cod:='Circ. '+inttostr(numerocirc);
  areacirc:=Area_circ(Piano,Numerocirc);
  numambterm:=Cercapuntoloc(xterm,yterm,Piano); //Locale di appartenenza
  numamb:=( numambterm div 1000 )*1000+Numerocirc;
  itl:=indTloc(numambterm);  //Locale principale
  // memorizzo  la densità di potenza per calcolare i tubi estranei
  //RtempLoc[itl].prich:=RtempLoc[itl].prich+Potenza_Invernale_Locale(i,numambterm);
  RtempLoc[itl].Sup_tot:=RtempLoc[itl].sup_tot+areacirc;
  if (larghezzamax=zona_res) then
  RtempLoc[itl].Supres:=RtempLoc[itl].supres+areacirc
  else
  RtempLoc[itl].supmarg:=RtempLoc[itl].supmarg+areacirc;
  RtempLoc[itl].servizi:=tipo_zona(i)=zona_bagni;
  end;


if NTempLoc=0 then exit;

InitFileReport(I_sl(percorsodrive)+V_recgen.Codice +'_pannelli.rep');

Wrep_str('NOMER',V_recgen.Codice+' '+V_recgen.Descrrete);

// Ricerca del locale sfavorito
dens_sfav:=0;
loc_sfav:=0;

for i:=1 to NTempLoc do
with RtempLoc[i] do
if Sup_tot<>0 then //esclude disinpegni
if not servizi then
//if tipo_zona(i)<>zona_bagni then //vengono esclusi i servizi
   begin
   dens_pot:=prich/sup_tot;
   if dens_pot>dens_sfav then
     begin
     dens_sfav:=dens_pot;
     loc_sfav:=i;
     end;
   end;
if loc_sfav<>0 then
Wrep_str('LOCSFAV',inttostr(RtempLoc[loc_sfav].num)+' '+ambienti_D^[cerca_amb(inttostr(RtempLoc[loc_sfav].num))]^.Denom)
else Wrep_str('LOCSFAV','');
W_Reale('DENSSFAV',dens_sfav,1);
W_Reale('TH2OIN',Tmandata,1);
W_Reale('DTH2O',dtacqua,1);
InizioTabella('TABCIRCPANNELLI',17);
{ TODO -oDiego -cPannelli : Report tabella circuiti }




For i:=1 to NGTerm do
with GTerm^[i]^ do
if uppercase(copy(tipoterm,1,4))='PANN' then
  begin
  progress_3d(round(i/ngterm*100),'Calcolo pannelli,sviluppo del calcolo');
  indserie:=Ind_terminale(serie,modello,indmodello);
  Profondita:=Terminali_D^[indserie].dettaglioterminali[indmodello].Passo;
    begin
    Numerocirc:=Cercapuntoloc_D(xterm,yterm,Piano); //circuito di appartenenza
    numerocircterm:=Numerocirc;
    //if numerocirc=32 then
    //showmessage('!');
    areacirc:=Area_circ(Piano,Numerocirc);
    numambterm:=Cercapuntoloc(xterm,yterm,Piano);
    numprincterm:=cercaprinc(numambterm);
    indamb:=cerca_amb(inttostr(NumAmbTerm));
    itl:=indTloc(NumAmbterm);
    Larghezza:=0; //Lunghezza del circuito

    //Individua i tubi estranei che passano per questo circuito
    estranei:=0;
   For k:=1 to NGTerm do
    if k<>i then
    if uppercase(copy(GTerm^[k]^.tipoterm,1,4))='PANN' then
       begin
       //progress_3d(round(k/ngterm*100),'Tubi estranei del circuito'+inttostr(i)+'/'+inttostr(ngterm));
       troncot:=troncoterm(k);
       j:=dati^[troncot]^.ti;
         repeat
         if numerocirc=Cercapuntoloc_D((dis^[j]^.x2+dis^[j]^.x1)/2,(dis^[j]^.y2+dis^[j]^.y1)/2,Piano) then
           begin
           estranei:=estranei+sqrt(sqr(dis^[j]^.x2-dis^[j]^.x1)+sqr(dis^[j]^.y2-dis^[j]^.y1)+sqr(dis^[j]^.z2-dis^[j]^.z1))*2;
           end;
         j:=dis^[j]^.nlinea;
         until j=0;
       end;

    areacirc:=areacirc-estranei*profondita/1000;
    if areacirc<0 then
    areacirc:=0.3;
    troncot:=troncoterm(i);
    potestranei:=0;
//  elabora i tubi di collegamento di questo circuito
    Numerocirc:=numerocircterm; //circuito di appartenenza
    j:=dati^[troncot]^.ti;
      repeat
      if numerocirc<>Cercapuntoloc_D((dis^[j]^.x2+dis^[j]^.x1)/2,(dis^[j]^.y2+dis^[j]^.y1)/2,Piano) then
        begin
        lungtubo:=sqrt(sqr(dis^[j]^.x2-dis^[j]^.x1)+sqr(dis^[j]^.y2-dis^[j]^.y1)+sqr(dis^[j]^.z2-dis^[j]^.z1))*2;
        Larghezza:=Larghezza+lungtubo;
        ia1:=Cercapuntoloc((dis^[j]^.x2+dis^[j]^.x1)/2,(dis^[j]^.y2+dis^[j]^.y1)/2,Piano);
        if (ia1<>0) then
          begin
          princtemp:=cercaprinc(ia1);
          itl1:=indTloc(princtemp);

          //corridoi senza circuiti propri ma con tubi che vi transitano
          if RtempLoc[itl1].Sup_tot=0 then
          RtempLoc[itl1].Sup_tot:=RtempLoc[itl1].sup_amb;
          temp_est:=lungtubo*profondita/1000*RtempLoc[itl1].prich/RtempLoc[itl1].Sup_tot;
          potestranei:=potestranei+temp_est;


          //Verifica se il tubo scorre all'interno dello stesso locale principale
          if (ia1<>0)and(princtemp<>numprincterm) then
            begin
            //in questo modo non documenta il corridoio senza circuiti
            //itl:=1;
            //while (itl<Ntemploc)and(RtempLoc[itl].num<>princtemp)do inc(itl);
            //if RtempLoc[itl].num=princtemp then
            //in questo modo documenta il corridoio senza circuiti
            //tempint:=NTempLoc;
            //if ntemploc>tempint then //servito solo dai tubi di collegamento
            //RtempLoc[itl1].prich:=Potenza_Invernale_Locale(i,NumAmbTerm);

            RtempLoc[itl1].estr:=RtempLoc[itl1].estr+temp_est;
            RtempLoc[itl1].supcol:=RtempLoc[itl1].supcol+lungtubo*profondita/1000;
            end
           else
             RtempLoc[itl1].estr_int:=RtempLoc[itl1].estr_int+temp_est;
            end;
          end;
      j:=dis^[j]^.nlinea;
      until j=0;

    Profondita:=0; //Tubi zona res
    Altezza:=0;    //Tubi zona marg
    estranei:=Larghezza;
    Larghezza:=Larghezza+areacirc*Sviluppo_tubi;
    with  dati^[troncot]^ do
      begin
      npconc:=1;
      tipo_rete:=1;
      while (tipo_rete<Ntipirete)and(uppercase(tipirete_d^[Tipo_rete].Cod)<>uppercase(tipo))do inc(tipo_rete);
      if uppercase(tipirete_d^[Tipo_rete].Cod)=uppercase(tipo) then
      Aggiungi_perdita(troncot,tipirete_d^[Tipo_rete].TipoDiramazioni,1);
      lungh:=larghezza/2;
      end;

    Profondita:=Terminali_D^[indserie].dettaglioterminali[indmodello].Passo; //Tubi zona res
    if (Gterm^[i]^.PotInp<>0)or( Versione_trial_pannelli) then
      begin
     Gterm^[i]^.Pot:=Gterm^[i]^.PotInp;
     if Versione_trial_pannelli then Gterm^[i]^.Pot:=1000
     end
    else Gterm^[i]^.Pot:=Calc_pot(itl,areacirc,larghezzamax=zona_res); //Potenza massima erogabile dal circuito
    Gterm^[i]^.Dt:=Calc_dt(Gterm^[i]^.Pot,areacirc,tmandata,zone_D^[ambienti_D^[indamb]^.Zona].TInv);
    Gterm^[i]^.Port := (Gterm^[i]^.Pot+potestranei) * 2.427184E-4/Gterm^[i]^.Dt;


    WStrTab(cod); // N.	numero del circuito in riferimento al disegno
    WRealeTab(cercaprinc(NumAmbTerm),0); // Loc. numero del locale in cui si sviluppa il circuito
    WRealeTab(Larghezza,0); // L.Tot lunghezza totale del circuito
    if (larghezzamax=zona_res) then
      begin
      WRealeTab(areacirc,1); // S.res superficie in zona residenziale
      RtempLoc[itl].supres:=RtempLoc[itl].supres+areacirc;
      WRealeTab(Profondita,0); // PS.res passo in zona residenziale
      WRealeTab(dtmedialog(tmandata,tmandata-Gterm^[i]^.Dt,zone_D^[ambienti_D^[indamb]^.Zona].TInv),1); // Dtres sovrattemperatura media logaritmica in zona residenziale
      //WRealeTab(resa_res*ambienti_D^[indamb]^.Superficie,0); // Pres potenza in zona residenziale
      WRealeTab(Gterm^[i]^.Pot,0); // Pres potenza in zona residenziale
      WRealeTab(0,0); // S.mar superficie in zona marginale
      WRealeTab(0,0); // PS.mar passo in zona marginale
      WRealeTab(0,0); // Dtmar sovrattemperatura media logaritmica in zona marginale
      WRealeTab(0,0); // Pmar potenza in zona marginale
      end
    else
      begin
      WRealeTab(0,0); // S.mar superficie in zona residenziale
      WRealeTab(0,0); // PS.mar passo in zona residenziale
      WRealeTab(0,0); // Dtmar sovrattemperatura media logaritmica in zona residenziale
      WRealeTab(0,0); // Pmar potenza in zona residenziale
      WRealeTab(areacirc,1); // S.res superficie in zona marginale
      RtempLoc[itl].supmarg:=RtempLoc[itl].supmarg+areacirc;
      WRealeTab(Profondita,0); // PS.res passo in zona marginale
      WRealeTab(dtmedialog(tmandata,tmandata-Gterm^[i]^.Dt,zone_D^[ambienti_D^[indamb]^.Zona].TInv),1); // Dtres sovrattemperatura media logaritmica in zona residenziale
      //WRealeTab(resa_marg*ambienti_D^[indamb]^.Superficie,0); // Pres potenza in zona marginale
      WRealeTab(Gterm^[i]^.Pot,0); // Pres potenza in zona residenziale
      end;

    RtempLoc[itl].res_sup:=Terminali_D^[indserie].dettaglioterminali[indmodello].ResSup;
    //RtempLoc[itl].ptot:=RtempLoc[itl].ptot+resa_marg*ambienti_D^[indamb]^.Superficie;
    RtempLoc[itl].ptot:=RtempLoc[itl].ptot+Gterm^[i]^.Pot;

    WRealeTab(estranei,0); // LCol  lunghezza dei tubi di collegamento
    WRealeTab(potestranei,0); // Pcol potenza dei tubi di collegamento
    WRealeTab(Gterm^[i]^.dt,1); // DT °C
    WRealeTab(Gterm^[i]^.Port,4); // Port portata l/s
    WRealeTab(dati^[troncot]^.pr*2,2); // Perdi perdita di carico kpa
    WStrTab(Gterm^[i]^.taratura); //Regolaz  posizione della valvola di taratura

    FinerigaTabella;
    end;
  end;
Finetabella;
InizioTabella('TABLOCPANNELLI',14);
for i:=1 to NTempLoc do
   begin
   { TODO -oDiego -cPannelli : Report tabella locali }

   WInttab(RtempLoc[i].num);//N. numero del locale
   indamb:=cerca_amb(inttostr(RtempLoc[i].num));
   with ambienti_d^[indamb]^ do
    begin
    WStrTab(Piano);//Piano
    WStrTab(Denom);//Descr descrizione del locale
    WRealeTab(RtempLoc[i].sup_tot,1);//Sup superficie
    if RtempLoc[i].res_sup=0 then  RtempLoc[i].res_sup:=0.1;//disinpegni
    WRealeTab(RtempLoc[i].res_sup,3);//Rsup resistenza superficiale del rivestimento considerata per il calcolo
    //WRealeTab(zone_D^[Zona].TInv,1);//Temp temperatura interna
    WRealeTab(20,1);//Temp temperatura interna
    end;
  WRealeTab(RtempLoc[i].prich,0);//Pot  potenza da erogare
  WRealeTab(0,1);//Prad   potenza a detrarre erogata da altri dispositivi
  WRealeTab(0,1);//Psof    potenza a detrarre ricevuta da circuiti al piano di sopra
  WRealeTab(RtempLoc[i].ptot+RtempLoc[i].estr_int,0);//Pcirc potenza erogata dai circuiti
  WRealeTab(RtempLoc[i].estr,1);//Pes    potenza erogata dai tubi estranei
  WRealeTab(0,1);//Pbas  potenza erogata verso il basso
  WRealeTab(RtempLoc[i].ptot+RtempLoc[i].estr+RtempLoc[i].estr_int,1);//Ppan  potenza totale erogata dai pannelli
  if RtempLoc[i].prich<>0 then
  WRealeTab(((RtempLoc[i].ptot+RtempLoc[i].estr+RtempLoc[i].estr_int)/RtempLoc[i].prich)*100,0)//Perc  percentuale di copertura
  else WRealeTab(0,0);

  FinerigaTabella;
  end;
Finetabella;
CloseFileReport;
cod_valvoletaratura:=V_recgen.valvtipo;
valvsce:=cod_valvoletaratura<>'';
end;
end.
