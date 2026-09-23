unit Funz_reti;

interface

uses windows,varcarichi,definiz,InitPunt_Tubi,copiaUCaricadati,libreriagenerale,UdbT,
     Udatalink,dxf_in_out,sysutils,UGrafodxf,mess_reti,OutDXFBM,dbtables,
     {Utireport,}Ustampe,ritornodxf,leggidxf,calcolo_tubi,impterm,{UDataOutT,}gestdim,angoli,
     uleggiscrividati,config_var,dialogs,pannelli,utireport{$Ifdef Canali},ucalcolareti{$Endif};

Procedure Init_Calc_reti;
Procedure Aggiorna_Calc_reti(rete_corrente:string);
Procedure Cambia_rete(Nomerete:string);
Procedure Azzera_inp_tubi(terminali:boolean);
Procedure Add_Tubo_Inp(Piano:string;x,y,z,x1,y1,z1:real;colore,tlinea:string);
procedure SalvaRete_I(rete,piano:string);
Procedure ADD_Term_inp(IndEnt:Integer);
procedure Add_pot_inp(pot_imp:real);
Procedure Add_Rim_rete(Nument:integer);
Procedure add_quota(xx1,yy1,xx2,yy2:real);
Function IS_Term(codb:string):boolean;
Procedure Set_Tipo_rete(Descr:string);
Procedure Controlla_rete(rete,piano:string);
Procedure Aggiorna_Calc_reti_BM;
function controllaprogetto(rete:string;agg:boolean):boolean;
Procedure Azzera_lettura;
Procedure Copia_Linea_Lettura;
Procedure Controllo_disegno(nomerete,nomePiano,errorepannelli:String;xerrore,yerrore:real);
Function Caricarete_Cad(rete:string):boolean;
Procedure controllo_tratti;
Procedure controllo_term;
Procedure Add_Rim_rete_mem(xbl,ybl:real;Nomebl:string);
Procedure Pos_etichetta(ind:integer;x_et,y_et:real;lab,rim_rip:string);
Procedure Salvacalcoli(nomepr:string);
Procedure Set_rete_calc(nomerete:string);
Procedure Aggiornaesecutivi;
Procedure Caricadistubi_1(nomePr,nomepia:string;Ris_Calc:Boolean);



Var Calcolo_rete_in_memoria:boolean=false;

implementation

uses grafica2d,init_cad3d,CreaDXFEdificio,CopiaLetturadisegno3d{,letturaInmemoria};
var
   existRipresa:boolean;
   XoriRip,Yoririp,ZoriRip:real;
   count_lettura:integer;
   Controllorete_in_memoria:boolean=false;
   Errore_pannelli,pianoepan:string;
   xepan,yepan:real;

Procedure Caricadistubi_1(nomePr,nomepia:string;Ris_Calc:Boolean);
begin
Caricadistubi(nomePr,nomepia,Ris_Calc);
end;

Procedure Leggi_contorni(Piano_corr:string);
Var i{,ultft}:integer;
    tutti:boolean;
 // Flin:file of  FRONT;
begin
{
piano_corr:=uppercase(piano_corr);
ultft:=0;
assign(flin,I_sl(percorsodrive)+nomep+'.igg');
reset(Flin);
while not eof Flin do
  begin
  inc(ultft);
  readln(Flin,Ft^[i]);
  end;
close(flin);
}
{
tutti:=piano_corr<>'';
Ncontorno:=0;
for i:=1 to npiani do
with piani_d^[i] do
if (tutti)or(piano_corr=uppercase(cod)) then
if fileexists(nome_dxf(cod,rete_corr,'RETE'))then
  begin
  if tutti then
    begin
    AzzeraDXf;
    Input_dxf(nome_dxf(cod,rete_corr,'RETE'),false);
    end;
  end;
}
end;

Procedure Add_contorno(indtubo:integer);
begin
with dis^[indtubo]^ do
Add_disegno_pannelli(x1,y1,x2,y2);
end;

Procedure Ripristina_orig_rete(piano:string);
Var  j:integer;
rec_controllo:record
             angolo:real;
             Or_x,or_y:real;
             end;
function filecontrollo(piano:string):string;
begin
result:=I_sl(percorsodrive)+'controllo_'+Piano+'.txe';
end;
function Leggi_controllo:boolean;
Var fcontrollo:textfile;
    bufcontr:string;
begin
result:=false;
if fileexists(filecontrollo(Piano)) then
  begin
  result:=true;
  assign(fcontrollo,filecontrollo(Piano));
  reset(fcontrollo);
  with rec_controllo do
    begin
    readln(Fcontrollo,bufcontr);
    angolo:=str_tofloat(bufcontr);
    readln(Fcontrollo,bufcontr);
    or_x:=str_tofloat(bufcontr);
    readln(Fcontrollo,bufcontr);
    or_y:=str_tofloat(bufcontr);
    close(fcontrollo);
    end;
  end
else
  begin
  rec_controllo.or_x:=0;
  rec_controllo.or_y:=0;
  end;
end;
begin
if not Calcolo_rete_in_memoria then exit;
Leggi_controllo;
for j:=1 to nentita do
with entita_d^[j]^ do
with rec_controllo do
  begin
  x1:=x1+or_x;
  y1:=y1+or_y;
  if cod='L' then
    begin
    x2:=x2+or_x;
    y2:=y2+or_y;
    end;
  end;
end;

Procedure Azzera_lettura;
begin
Ncontorno:=0;
ultriga:=0;
ultriga_I:=0;
NgTerm:=0;
NgTerm_I:=0;
count_lettura:=0;
testrete:=true;
end;
Procedure Copia_Linea_Lettura;
begin
inc(count_lettura);
inc(ultriga);
if dis^[ultriga]=nil then new(dis^[ultriga]);
dis^[ultriga]^:=dis_I^[ultriga_I]^;
with dis^[Ultriga]^ do
  begin
  Item_input:=count_lettura;
  tronco:=0;
  end;
end;
Procedure Controllo_disegno(nomerete,nomePiano,errorepannelli:String;xerrore,yerrore:real);
Var Ferrori:Textfile;
    org,i:integer;
begin
Leggi_mem_terminali;
CalcUnPiano:=nomePiano;
CalcUnaRete:=nomerete;
un_errore:=false;
existripresa:=false;
Assign(Ferrori,I_Sl(percorsodrive)+'\errori_'+nomepiano+'_'+nomerete+'.txe');
rewrite(Ferrori);
writeln(Ferrori,Nomepiano);
writeln(Ferrori,'Rete interpretata correttamente');
writeln(Ferrori,'0');
writeln(Ferrori,'0');
close(ferrori);
dmtutti.T_Reti.Edit;
calcunpiano:=uppercase(nomePiano);
Controllorete_in_memoria:=true;
if errorepannelli<>'' then
  begin
  inseriscierrore(errorepannelli,nomepiano,xerrore,yerrore);
  exit;
  end;
Caricarete_Cad(nomerete);
dmtutti.T_Reti.Edit;
//if (testrete)and(not existripresa)and(uppercase(piano)<>calcunpiano) then
//InserisciErrore('Inizio/ripresa rete assente',dis^[1]^.x1,dis^[1]^.y1);
if existripresa then
begin
// per permettere più colonne montanti
for i:=1 to ultriga do
with Dis^[i]^ do
if (rimando<>'')and(rimando[1]='B') then
  begin
  XoriRip:=Dis^[i]^.x1;
  Yoririp:=Dis^[i]^.y1;
  ZoriRip:=z1;
  ulttronco:=0;
  costruiscigrafo(XoriRip,YoriRip,ZoriRip,org,1);
  end
end
else
with GENERALITA_D1^[indice_rete] do
costruiscigrafo(Xori,Yori,Zori,org,1);
dmtutti.T_Reti.POst;
dmtutti.T_Reti.Edit;
Controllorete_in_memoria:=false;
CaricaCodiciTerminali;
controllo_term;
controllo_tratti;
end;

Procedure Set_Tipo_rete(Descr:string);
begin
 descr:=uppercase(descr);
 if descr='TUBAZIONI'then Tipo_rete:=TrTubi else
 if descr='CANALI'then Tipo_rete:=TrCanali;
end;
procedure SalvaRete_I(rete,piano:string);
Var i:integer;
     frc:file of cadrec;
     frT:file of recgterm;
     Fqt:file of recquo;
begin
if (rete='')or(piano='') then exit;
if dis_esecutivo  then
  begin
  // riprende il disegno dei tubi originale (scarta il disegno esecutivo )
  assign(frc,i_sl(percorsodrive)+rete+'-'+piano+'.U2d');
  reset(frc);
  ultriga_I:=0;
  while not eof(frc) do
    begin
    inc(ultriga_I);
    if dis_I^[ultriga_I]=nil then new(dis_I^[ultriga_I]);
    read(frc,dis_I^[ultriga_I]^);
    end;
  close(frc);
  end
else
  begin
  assign(frc,i_sl(percorsodrive)+rete+'-'+piano+'.U2d');
  rewrite(frc);
  for i:=1 to ultriga_I do
  write(frc,dis_I^[i]^);
  close(frc);
  end;

assign(Fqt,i_sl(percorsodrive)+rete+'-'+piano+'.Q2d');
rewrite(Fqt);
for i:=1 to Nquote do
write(Fqt,quote^[i]);
close(Fqt);
assign(frT,i_sl(percorsodrive)+rete+'-'+piano+'.T2d');
rewrite(frT);
for i:=1 to NGterm_I do
write(frT,Gterm_I^[i]^);
close(frT);
//controlla_rete(uppercase(rete),uppercase(piano));
end;

Procedure AggiornaQuote(rete:string);
Var i,j,k:integer;
    Fqt:file of recquo;
    bfq:recquo;
    trov:boolean;
    xint,yint,lmax,ll:real;
    res,indmax:integer;
 {$i inters}
function vic(v1,v2:real):boolean;
begin
result:=abs(v2-v1)<0.01;// 1 centimetro
end;
begin
apr:=0.005;
for i:=1 to  ulttronco do
with dati^[i]^ do
  begin
  x:=0;
  y:=0;
  Xbase:=0;
  yBase:=0;
  end;
for i:=1 to Npiani do
if fileexists(i_sl(percorsodrive)+rete+'-'+Piani_d^[i].Cod+'.Q2d') then
  begin
  assign(fqt,i_sl(percorsodrive)+rete+'-'+Piani_d^[i].Cod+'.Q2d');
  reset(fqt);
  while not eof(fqt) do
    begin
    read(fqt,bfq);
    j:=1;
    trov:=false;
    while (j<=ultriga)and(not trov) do
      begin
      with dis^[j]^ do
      if tronco<>0 then
      if uppercase(pianocad)=uppercase(Piani_d^[i].Cod) then
        begin
        inters(xint,yint,res,x1,x2,bfq.x1,bfq.x2,y1,y2,bfq.y1,bfq.y2);
        if (res<>0)and
           ( (vic(xint,bfq.x1)and vic(yint,bfq.y1) )or(vic(xint,bfq.x2)and vic(yint,bfq.y2))) then
          begin
          trov:=true;
          if vic(xint,bfq.x1)and vic(yint,bfq.y1) then
            begin
            with dati^[tronco]^ do
              begin
              xbase:=bfq.x1;
              ybase:=bfq.y1;
              x:=bfq.x2;
              y:=bfq.y2;
              end;
            end
          else
            begin
            with dati^[tronco]^ do
              begin
              xbase:=bfq.x2;
              ybase:=bfq.y2;
              x:=bfq.x1;
              y:=bfq.y1;
              end;
            end
          end;
        end;
      inc(j);
      end;
    end;
  close(fqt);
  end;
for k:=1 to Npiani do
//if fileexists(i_sl(percorsodrive)+rete+'-'+Piani_d^[i].Cod+'.Q2d') then
  begin
  if P_corr(Piani_d^[k].Cod)and R_corr(rete) then nquote:=0;
  assign(fqt,i_sl(percorsodrive)+rete+'-'+Piani_d^[k].Cod+'.Q2d');
  rewrite(fqt);
  for i:=1 to ulttronco do
  with dati^[i]^ do    
  if (dati^[i]^.Term=0)or(uppercase(copy(Gterm^[dati^[i]^.Term].TipoTerm,1,4))<>'PANN')then
  if uppercase(piano)=uppercase(Piani_d^[k].Cod) then
    begin
    if (x=0)and(Y=0) then
      begin
      x:=0;
      y:=0;
      j:=ti;
      lmax:=0;
      if j<>0 then
        repeat
        if not dis^[j].cl then
          begin
          ll:=sqrt(sqr(dis^[j]^.x2-dis^[j]^.x1)+sqr(dis^[j]^.y2-dis^[j]^.y1));
          if ll>lmax then
             begin
             lmax:=ll;
             indmax:=j;
             end;
          end;

        j:=dis^[j].nlinea;
        until j=0;
      if lmax>0 then // elimina le quote nel collettore
        begin
        j:=indmax;
        xbase:=(dis^[j]^.x1+dis^[j]^.x2)/2;
        ybase:=(dis^[j]^.y1+dis^[j]^.y2)/2;
        x:=xbase+0.1;
        y:=ybase+0.1;
        end;
      end;

    if (x<>0) or (y<>0) then
      begin
      bfq.x1:=x;
      bfq.y1:=y;
      bfq.x2:=xbase;
      bfq.y2:=ybase;
      bfq.quota1:=coddiam;
      bfq.quota2:={Tipo}inttostr(codicetubo);
      write(fqt,bfq);
      if P_corr(Piani_d^[k].Cod)and R_corr(rete) then
        begin
        inc(nquote);
        quote^[nquote]:=bfq;
        end;
      end;
    end;
  close(fqt);
  end;

end;

Function CercaCodPar(colp:string):string;
var i:integer;
    indcol:integer;
begin
result:='?'+colp;
if not(numvalido(colp)) then exit;
indcol:=strtoint(colp);
i:=1;
colp:=uppercase(colore_cad(indcol));
while (i<Nstrutture)and(uppercase(strutture_D^[i].ColCAD)<>colp)do inc(i);
if uppercase(strutture_D^[i].ColCAD)=colp then result:=strutture_D^[i].NFile;
end;

Function TipoDacolore(colp:string):string;
Var i:integer;
    indcol:integer;
    colporig:string;
begin
colporig:=colp;
if colp='FITTIZIA' then
  begin
  result:=colp;
  exit;
  end;
result:='?'+colp;
if not(numvalido(colp)) then
  begin
  showmessage(colp);
  exit;
  end;
indcol:=strtoint(colp);
i:=1;
colp:=uppercase(colore_cad(indcol));
while (i<NTipirete)and(uppercase(Tipirete_D^[i].Colore)<>colp)do inc(i);
if uppercase(Tipirete_D^[i].Colore)=colp then result:=Tipirete_D^[i].Cod
//else showmessage(colporig);
end;

Procedure add_quota(xx1,yy1,xx2,yy2:real);
begin
inc(nquote);
with quote^[Nquote] do
  begin
  x1:=xx1;
  y1:=yy1;
  x2:=xx2;
  y2:=yy2;
  end;
end;

Procedure Add_Tubo_Inp(Piano:string;x,y,z,x1,y1,z1:real;colore,tlinea:string);
Var ultrigaprec:integer;
    iscol:string;
begin
ultrigaprec:=ultriga;
if POs('COLLETTORE',uppercase(tlinea))<>0 then iscol:='C' else iscol:='T';
if uppercase(tlinea)='FITTIZIA' then colore:=Tlinea;//linea separazione pannelli
CaricaTubo(Ultriga_I+1,''{DN},  Piano, iscol,TipoDacolore(colore), X, Y, Z, X1, Y1, Z1);
if ultriga<>ultrigaprec then
  begin
  inc(ultriga_I);
  if dis_I^[ultriga_I]=Nil then new(dis_I^[ultriga_I]);
  dis_I^[ultriga_I]^:=dis^[ultriga]^;
  ultriga:=ultriga-1;
  end;
end;
Function IS_Term(codb:string):boolean;
begin
result:=false;
{codb:=Uppercase(copy(codb,1,5));
if (codb='T_RAD') then
result:=true
else }
  begin
  //if (length(codb)<4)or(codb[4]<>'_') then exit;
  codb:=Uppercase(copy(codb,1,4));
  if (codb='TERM') then
  result:=true;
  end;
end;

Function Valnum(valst:string):string;
var err:integer;
    num:real;
begin
result:='0';
val(valst,num,err);
if err=0 then result:=valst;
end;

type Reclabsosp=record
                tipo:char;
                L_lab:string;
                xx_lab,yy_lab:real;
                end;
Var ar_labSosp:array[1..1000]of reclabsosp;

Procedure Add_Rim_rete(Nument:integer);
var i:integer;
begin
with entita_D^[nument]^ do
  begin
  colore:=inttostr(indcolore(tipirete_D^[1].Colore));// provvisorio bisogna assegnare un colore al rimando
  Add_Tubo_Inp('',x1,y1,0,0,0,0,colore,tlinea);
  dis_I^[ultriga_i]^.x2:=x1;
  dis_I^[ultriga_i]^.y2:=y1;
  dis_I^[ultriga_i]^.Angolo:=ang;
  for i:=1 to nattrib do
  if attrib[i].coda='CODICE' then
  //if attrib[i].valore<>'' then
    begin
    //if attrib[i].coda='CODICE' then //port:=valnum(valore);
    if (copy(uppercase(nomebl),1,7)='RIMRETE') then
    dis_I^[ultriga_i]^.Rimando:='A-'+nomebl[8]+'-'+attrib[i].valore
    else dis_I^[ultriga_i]^.Rimando:='B-'+nomebl[8]+'-'+attrib[i].valore;
    end;
  if nlabsosp>0 then
  for i:=1 to nlabsosp do
  with ar_labsosp[i] do
  if (pos(l_lab,dis_I^[ultriga_i]^.Rimando)<>0)and(pos(tipo+'-',dis_I^[ultriga_i]^.Rimando)<>0) then
    begin
    dis_I^[ultriga_i]^.x_lab:=xx_lab;
    dis_I^[ultriga_i]^.y_lab:=yy_lab;
    end;
  end;
end;

Procedure Add_Rim_rete_mem(xbl,ybl:real;Nomebl:string);
begin
Add_Tubo_Inp('',xbl,ybl,0,0,0,0,'1','Continuous');
dis_I^[ultriga_i]^.x2:=xbl;
dis_I^[ultriga_i]^.y2:=ybl;
if (copy(uppercase(nomebl),1,7)='RIMRETE') then
dis_I^[ultriga_i]^.Rimando:='A-'
else dis_I^[ultriga_i]^.Rimando:='B-';
end;
Procedure Pos_etichetta(ind:integer;x_et,y_et:real;lab,rim_rip:string);
Var I:integer;
begin
if (ind<>0)and(GTerm_I^[ind]<>nil) then
with GTerm_I^[ind]^ do
  begin
  Xetic:=x_et;
  Yetic:=y_et;
  end
else
  begin
  //exit;
  if ultriga_I>0 then
    begin
    i:=1;
    while (i<ultriga_I)and(pos(lab,dis_I^[i]^.Rimando)=0 )do inc(i);
    with dis_I^[i]^  do
    if pos(lab,Rimando)<>0 then
      begin
      x_lab:=x_et;
      y_lab:=y_et;
      end
    else
      begin
      inc(Nlabsosp);
      with ar_labsosp[Nlabsosp] do
        begin
        if rim_rip=etic_rim then
        tipo:='A' else tipo:='B';
        L_lab:=lab;
        xx_lab:=x_et;
        yy_lab:=y_et;
        end;
      end;
    end;
  end;
end;

Procedure ADD_Term_inp(IndEnt:Integer);
Var j,k,q:integer;
     etx,ety:real;
     trov:boolean;
    codice, x1, y1, z1, tipo, modello, serie,fissamodello,fissaserie, potenzaI, prof, alt, larg, perdita, st,
  incr, largmax, angt, xe, ye, ze, piano, numel, port, spec, potest, codmont, valmont, nomebloccodxf: String;

begin
codice:='0'; x1:='0'; y1:='0'; z1:='0'; tipo:=''; modello:=''; serie:='';fissamodello:='';fissaserie:=''; potenzaI:='0'; prof:='0'; alt:='0'; larg:='0';
perdita:='0'; st:=''; incr:='0'; largmax:=''; angt:=''; xe:='0'; ye:='0'; ze:='0'; piano:=''; numel:='0'; port:='0';
spec:=''; potest:='0'; codmont:=''; valmont:='';

nomebloccodxf:=entita_D^[indent]^.NomeBl;

for j:=1 to entita_D^[indent]^.NAttrib do
with  entita_D^[indent]^.Attrib[j] do
if valore<>'' then
  begin
  if coda='PORT' then port:=valnum(valore);
  if coda='PERDITA' then perdita:=valnum(valore);
  if coda='COD' then Codice:=valore;
  if coda='LMAX' then LargMax:=valnum(valore);
  if coda='INCR' then Incr:=valnum(valore);
  if coda='MODELLO' then modello:=valore;
  if coda='SERIE' then serie:=valore;
  if coda='FISSAMODELLO' then Fissamodello:=valore;
  if coda='FISSASERIE' then Fissaserie:=valore;
  if coda='POTENZA' then
    begin
    POTEST:='0';
    PotenzaI:='0';
    if str_tofloat(valore)>0 then
      begin
      POTEST:='-1';
      PotenzaI:=valnum(valore);
      If (versione_trial){or(Versione_Trial_pannelli)} then
        begin
        potenzaI:='500';
        end;
      end;
    end;
  if coda='MONTAGGIO' then codmont:=valore;
  end;

  CaricaTerminale(codice, x1,y1, z1, tipo, modello,fissamodello, serie,fissaserie, potenzaI, prof, alt, larg, perdita, st,
  incr, largmax, angt, xe, ye, ze, piano, numel, port, spec, potest, codmont, valmont, nomebloccodxf);

with entita_D^[indent]^ do
  begin
  inc(NGterm_I);
  if GTerm_I^[NGterm_I]=Nil then new(GTerm_I^[NGterm_I]);
  Gterm_I^[NGterm_I]^:=Gterm^[NGterm]^ ;
  NGterm:=NGterm-1;
  Gterm_I^[NGterm_I]^.cod:=codice;
  Gterm_I^[NGterm_I]^.angolo:=ang;
  Gterm_I^[NGterm_I]^.XTerm:=x1;
  Gterm_I^[NGterm_I]^.YTerm:=Y1;
  Gterm_I^[NGterm_I]^.ZTerm:=Z1;
  Gterm_I^[NGterm_I]^.Codiceterminale:=NGterm_I;
  end;
  trov:=false;
  for k:=1 to Nentita do
  with entita_D^[k]^ do
  if (not trov)and(Cod='B')and(layer=entita_D^[indent]^.Layer)and(uppercase(nomebl)='ETICHETTA') then
  for q:=1 to nattrib do
  if (not trov)and(Uppercase(attrib[Q].CodA)='LINK')and(attrib[q].valore=codice) then
    begin
    trov:=true;
    Gterm_I^[NGterm_I]^.XEtic:=x1;
    Gterm_I^[NGterm_I]^.YEtic:=y1;
    end;


end;
procedure Add_pot_inp(pot_imp:real);
begin
Gterm^[NGterm]^.PotInp:=pot_imp;
end;
Procedure controllo_term;
Var i:integer;
     ex_calc,port_inp:boolean;
begin
ci_sono_pannelli:=false;
if ngterm=0 then exit;
ex_calc:=fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int');
//if not file-exists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int') then
//with gterm^[1]^ do
//InserisciErrore('I calcoli delle dispersioni non sono aggiornati','',Xterm,Yterm)
//else
  begin
  if ex_calc then CaricaCodiciTerminali
  else trova_modello;
  for i:=1 to NGterm do
  with gterm^[i]^ do
  if (cod<>'RIMANDO')and(PotInp=0)and(portInp=0)and(not ex_calc) then
  InserisciErrore('I calcoli delle dispersioni non sono aggiornati o manca la potenza o portata',piano,Xterm,Yterm)
  else
    begin
    if cod<>'RIMANDO' then
      begin
      //if (pot=0)and(potE=0) then
      //if not fileexists(IncludeTrailingPathDelimiter(percorsoDrive) + 'potinv.int') then
      //InserisciErrore('I calcoli delle dispersioni non sono aggiornati',Xterm,Yterm)
      //else
      if potInp<>0 then POt:=POtinp
      else
        begin
        if numamb=0 then
          begin
          if fileexists(I_sl(percorsoDrive) + gterm^[i]^.Piano + '.int') then
            begin
            if gterm^[i]^.piano='' then showmessage('Assegnazione piano terminale irregolare');
            InserisciErrore('Terminale fuori della sagoma dell''edificio ',gterm^[i]^.piano,Xterm,Yterm)
            end
          else  InserisciErrore('Controllo disegno edificio non andato a buon fine',piano,Xterm,Yterm);
          end
        else
        if (pot=0)and(potE=0) then
        InserisciErrore('Terminale con potenza = 0',piano,Xterm,Yterm);
        end;
      end;
    if taratura<>'*' then
    InserisciErrore('Terminale o rimando non collegato alla rete,controllare il 3D'+chr(13)+'gli oggetti non collegati sono evidenziati in rosso',piano,Xterm,Yterm);
    taratura:='';
    end;
  end;
if ci_sono_pannelli then
  begin
  if errore_pannelli<>'' then
  InserisciErrore(errore_pannelli,pianoepan,xepan,yepan)
  else controllo_pannelli;
  end;
end;
Procedure controllo_tratti;
Var i:integer;
begin
if un_errore then exit;
for i:=1 to ultriga do
with Dis^[i]^ do
if (tronco=0)and(not(CL)) then
InserisciErrore('Tratto non collegato alla rete,controllare il 3D'+chr(13)+'gli oggetti non collegati sono evidenziati in rosso',piano,(x1+x2)/2,(y1+y2)/2);
end;
Procedure Azzera_inp_tubi(terminali:boolean);
begin
if terminali then NGterm_I:=0;
Ultriga_I:=0;
Nquote:=0;
end;
Procedure Azzera_Calc_tubi;
Var ff:textfile;
begin
un_errore:=false;
AssignFile(Ff, I_SL(PercorsoDrive) + NomeFile_Errori_Impianti);
rewrite(FF);
close(FF);
NGterm:=0;
Ultriga:=0;
Ncontorno:=0;
ulttronco:=0;
end;
Procedure Init_Calc_reti;
Var i:Integer;
begin
Iniz_PuntTubi;
New(Valv_D);//spostato da UcaricaDati;
new(dis_I);
For i:=0 to lungdis do dis_I^[i] := nil;
New(Gterm_I);
For i:=1 to MaxGterm do Gterm_I^[i] := nil;
end;
{-----------------------------------------------------------------------------
  Procedure: TFMainTubi.VerificaErrori
  Author:    Emanuela
  Date:      30-lug-2004
  Arguments: None
  Result:    Boolean

  Funzione che verifica se sono trovati degli errori durante la ricostruzione
  del grafo della rete.
-----------------------------------------------------------------------------}
function VerificaErrori: Boolean;
var
  FErrori: TextFile;
  NErrori: Integer;
  Errore: String;
begin
result:=un_errore;
exit;
  // Emanuela inserimento degli errori nel file erroriimpianti.txt
  Result := False;
  NErrori := 0;
  if not fileexists(I_sl(percorsodrive)+ NomeFile_Errori_Impianti) then
    begin
    Assign(Ferrori,I_sl(percorsodrive)+ NomeFile_Errori_Impianti);
    rewrite(Ferrori);
    close(ferrori);
    end;
  AssignFile(FErrori, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_Errori_Impianti);
  try
    Reset(FErrori);
    while not Eof(FErrori) do
    begin
      Readln(FErrori, Errore);
      echo(Errore);
      inc(NErrori);
    end;
    CloseFile(FErrori);
  except
    CloseFile(FErrori);
  end;

  if NErrori <> 0 then
  begin
    Result := True;
    //Set_Errori_Impianti(Str_Calc_No_OK);
  end;
  //else Set_Errori_Impianti(Str_Tutto_OK);

end;

{-----------------------------------------------------------------------------
  Procedure: TFMainTubi.RipuliscifileErrore
  Author:    Emanuela
  Date:      30-lug-2004
  Arguments: None
  Result:    None

  Crea, se non esiste il file contenente gli errori, altrimenti lo ripulisce.
-----------------------------------------------------------------------------}
procedure RipuliscifileErrore;
var
  FErrori: TextFile;
begin
  AssignFile(FErrori, IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_Errori_Impianti);
  try
   Rewrite(FErrori);
   CloseFile(FErrori);
  except
   CloseFile(FErrori);
  end;
end;

Procedure Carica_perdite_mancanti;
Var tbperd:TTable;
    i,j,k:integer;
begin
tbperd:=TTable.create(nil);
tbperd.DatabaseName:=percorso_archivi;
tbperd.tablename:='Perdite.db';
tbperd.open;
leggi_perdite(dmtutti.T_perdite,dmtutti.T_perdite,dmtutti.ds_perdite);
for i:=1 to ulttronco do
with dati^[i]^ do
for j:=1 to Npconc do
  begin
  k:=1;
  while (k<Nperd)and(uppercase(Pconc[j].Cod)<>Uppercase(perd_D^[k].Cod)) do inc(k);
  if  (Nperd=0)or(uppercase(Pconc[j].Cod)<>Uppercase(perd_D^[k].Cod))then
  with tbperd do
    begin
    first;
    while (not eof)and(uppercase(fieldbyname('Codice').asstring)<>uppercase(uppercase(Pconc[j].Cod))) do next;
    if uppercase(fieldbyname('Codice').asstring)=uppercase(uppercase(Pconc[j].Cod)) then
      begin
      inc(NPerd);
      perd_D^[Nperd].Cod:=Pconc[j].Cod;
      perd_D^[Nperd].Descr:=fieldbyname('Descrizione').asstring;
      perd_D^[Nperd].Zeta:=fieldbyname('Coeff Zeta').asfloat;
      end;
    end
  end;
//eliminazione righe vuote
j:=0;
for i:=1 to Nperd do
  begin
  if perd_D^[i].Cod<>'' then
    begin
    inc(j);
    if i<>j then perd_D^[j]:=perd_D^[i];
    end;
  end;
Nperd:=j;

tbperd.close;
tbperd.free;
//salva_perdite(dmtutti.T_perdite,dmtutti.T_perdite,dmtutti.ds_perdite);
end;

Function eseguiCalcoli:boolean;
Var ss:string;
    i: Integer;

begin
result:=false;
if not VerificaErrori then
  begin
  result:=true;
  //Dmtutti.T_Reti.First;
  //while (not Dmtutti.T_Reti.Eof)and(uppercase(Nomerete)<>(uppercase(V_recgen.Codice))) do Dmtutti.T_Reti.next;
  //if  uppercase(Nomerete)=(uppercase(V_recgen.Codice) ) then
    begin
    AttivaoutBm:=True;
    risultCalc^.Origine := V_RecGen.Origine;
    // Emanuela 15/5/2005 correzione affinchè non venga considerato qualche origine che non ha
    // tubi associati
    if risultCalc^.Origine <> 0 then
      begin
      set_Tipo_rete(V_RecGen.progetto);
        Case Tipo_rete of
        {$IFDEF CANALI}
        TrCanali:begin
                     //percdll:=Percorso_RisorseGen+'\dlltermico';
                     Leggi_mem_tipirete;
                     Calcolareti(Pchar(percorsodrive),pchar(v_recgen.Codice));
                     Disrit_can(v_recgen.Codice);
                     //showmessage(v_recgen.Codice+'  '+V_RecGen.progetto);
                     //N.B. il calcolo scrive un file di testo con gli errori che va letto
                     //for i:=1 to listerrori.Count do FmainTubi.memo1.Lines.Add(listerrori.Strings[i]);
                     //closeerrori;
                     //Calcolo_Canali(percorsodrive,v_recgen.Codice);
                     //for i:=1 to listerrori.Count do FmainTubi.memo1.Lines.Add(listerrori.Strings[i]);
                 end;
        {$ENDIF}
        TrTubi: begin
                  if not Calcoli then result:=false
                  else
                  CalcoloPannelli;
                  AggiornaQuote(V_recgen.Codice);
                  disrit3d('ESECUTIVO_RETE');
                  //scaricadxf('1','');
                end;
        end;
      //DisRit;
      Dmtutti.T_Reti.Edit;
      Prepararep(IncludeTrailingPathDelimiter(PercorsoDrive) + 'Tubi.rep');
      V_RecGen.Set_Portata(RoundR(4,risultCalc^.Portata));
      V_RecGen.Set_Prevalenza(RoundR(2,risultCalc^.Perdita));
      Dmtutti.T_Reti.Post;
      end;
     //Dmtutti.T_Reti.Next;
    end;
  end;
end;

Procedure Cambia_rete(Nomerete:string);
begin
Dmtutti.T_Reti.First;
while (not Dmtutti.T_Reti.Eof)and(uppercase(Nomerete)<>(uppercase(V_recgen.Codice))) do Dmtutti.T_Reti.next;
if  uppercase(Nomerete)=(uppercase(V_recgen.Codice) ) then
eseguiCalcoli;
end;

Procedure CalcolatutteLereti;
begin
  if not VerificaErrori then
  begin
    ApriFileOutBM(IncludeTrailingPathDelimiter(percorsodrive) + 'tubirit.txt');
    //InitFileReport(IncludeTrailingPathDelimiter(PercorsoDrive) + 'Tubi.rep');
    //Wrep_str('NOMECOMUNE', DatiProgetto(1));
    //Wrep_str('PROV', DatiProgetto(6));
  //  ApriFo(PercorsoDrive + '\SoloTubi.dxf');end;

    Dmtutti.T_Reti.First;
    while not Dmtutti.T_Reti.Eof do
      begin
      eseguiCalcoli;
      Dmtutti.T_Reti.next;
      end;


    //if Tipo_Rete <> trCanali then scaricadxf('5','TR');
    //Fine_compart;
    //CloseFileReport;
    //scriviquotebm;
    AttivaoutBm := True;
    //scriviquote(IncludeTrailingPathDelimiter(PercorsoDrive) + 'WorkDisegno.dxf');
   // ChiudiFo;
    ChiudiFileOutBM;

    //FMainTubi.StartGrafica := True;
    Dmtutti.T_Reti.First;
     with V_RecGen do
     begin
      {$IFDEF VERSIONE_TRIAL}
        //FMainTubi.ED_Portata.Caption := '0.4517';
        //FMainTubi.ED_Prevalenza.Caption := '9.9864';
      {$ELSE}
        //str(Portata:6:4,ss);
        //FMainTubi.ED_Portata.Caption := ss;
        //str(Prevalenza:6:4,ss);
        //FMainTubi.ED_Prevalenza.Caption := ss;
      {$ENDIf}
      RisultCalc^.Origine := Origine;
     end;
    SettaFiltro;
    //Ridisegna;
  end;
end;

Procedure ScriviUnif3D(nomepr:string;scomponi:boolean);

Var Buf:cadrec;
    FU3d:file of cadrec;
 // {$Ifdef Canali}

//  {$Endif}
    i,j,count:integer;
    DisTemp: cadrec;
    arfile:array[1..Maxpiani]of record
                                exrete:boolean;
                                fcr:file of cadrec;
                                end;
    codpiano:string;

procedure scriviretepiano;
var j:integer;
begin
j:=1;
while (j<Npiani) and (dis^[i]^.PianoCAD<>piani_D^[j].Cod) do inc(j);
if dis^[i]^.PianoCAD=piani_D^[j].Cod then
  begin
  if not(arfile[j].exrete) then
    begin
    arfile[j].exrete:=true;
    assign(arfile[j].fcr,I_sl(PercorsoDrive)+nomepr+'-'+dis^[i]^.Pianocad+'.U2D');
    rewrite(arfile[j].fcr);
    end;
  write(arfile[j].fcr,dis^[i]^);
  end;
end;


begin
//for i:=1 to Npiani do arfile[i].exrete:=false;

assign(FU3d,IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.U3D');
try
  Rewrite(FU3d);
  For i:=1 to  ultriga do
  begin
    DisTemp := dis^[i]^;
    DisTemp.z1 := DisTemp.z1 {- RestituisciQuotaPiano(DisTemp.PianoCAD)};
    DisTemp.z2 := DisTemp.z2 {- RestituisciQuotaPiano(DisTemp.PianoCAD)};
    write(fu3d,DisTemp);
    //if scomponi then scriviretepiano; non fattibile dopo lo spezzettamento dei tratti
  end;
  close(Fu3d);
  except
  close(Fu3d);
  end;

//exit;  
if scomponi then
for i:=1 to Npiani do
if fileexists(nome_dxf(piani_d^[i].cod,nomepr,'RETE')) then
if fileexists(i_sl(percorsodrive)+nomepr+'-'+codpiano+'.u2d') then
  begin
  codpiano:=piani_d^[i].Cod;
  assign(fu3d,i_sl(percorsodrive)+nomepr+'-'+codpiano+'.u2d');
  reset(fu3d);
  ultriga_i:=0;
  while not eof(fu3d) do
    begin
    inc(ultriga_i);
    if dis_I^[ultriga_i]=nil then new(dis_I^[ultriga_i]);
    read(fu3d,dis_I^[ultriga_i]^);
    j:=1;
    while (j<ultriga)and(dis^[j].Piano<>codpiano)or(dis^[j].Item_input<>ultriga_i)do inc(j);
    dis_i^[ultriga_i].tronco:=dis^[j].tronco
    end;
  rewrite(Fu3d);
  for j:=1 to ultriga_i do
  write(fu3d,dis_I^[j]^);

  close(fu3d);
  end;

//{$Ifdef Canali}
end;
Procedure Salvacalcoli(nomepr:string);
Var i:integer;
    Buf1:calcrec;
    FD3d:file of calcrec;
    FO3d:file of DatiInt;
begin

assign(FD3d, IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.D3D');
try
  Rewrite(FD3d);
  For i:=1 to  Ulttronco do
  begin
    write(fd3d, dati^[i]^);
  end;
  close(Fd3d);
except
  close(Fd3d);
end;
assign(FO3d, IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.O3D');
try
  Rewrite(FO3d);
  write(fO3d,risultcalc^);
  close(FO3d);
except
  close(Fd3d);
end;
//{$Endif}
end;


Procedure ScriviTermf3D(nomepr:string;scomponi:boolean);
type
  RecTermImp= Record
                 numamb:integer;
                 Pot, PotE:real;
                 TipoTerm, Modello, Serie: String[35];
                 Piano: String[15];
                 Profondita, Altezza, Larghezza: Real;
                 NumElementi: Integer;
              end;
Var    arfileT:array[1..Maxpiani]of record
                                exrete:boolean;
                                fcr:file of recgterm;
                                end;
Var Buf:cadrec;
    FT3d:file of recGterm;
    FT: file of recTermImp;
    i:integer;
    TermTemp: RecGTerm;
    recTermTemp: RecTermImp;

procedure scriviTermpiano;
var j:integer;
begin
j:=1;
while (j<Npiani) and (Gterm^[i]^.Piano<>piani_D^[j].Cod) do inc(j);
if Gterm^[i]^.Piano=piani_D^[j].Cod then
  begin
  if not(arfileT[j].exrete) then
    begin
    arfileT[j].exrete:=true;
    assign(arfileT[j].fcr,I_sl(PercorsoDrive)+nomepr+'-'+Gterm^[i]^.Piano+'.T2D');
    rewrite(arfileT[j].fcr);
    end;
  write(arfileT[j].fcr,Gterm^[i]^);
  end;
end;
begin
for i:=1 to Npiani do arfileT[i].exrete:=false;

assign(Ft3d,IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.T3D');
try
  Rewrite(FT3d);
  assign(Ft,IncludeTrailingPathDelimiter(PercorsoDrive) + 'ImpTerm.TER');
  try
    Rewrite(FT);
    For i:=1 to  NGTerm do
    begin
        if scomponi then scrivitermpiano;
        TermTemp := GTerm^[i]^;
        TermTemp.ZTerm := TermTemp.ZTerm {- RestituisciQuotaPiano(TermTemp.Piano)};
        write(fT3d, TermTemp);
        recTermTemp.numamb      := TermTemp.numamb;
        recTermTemp.Pot         := TermTemp.Pot;
        recTermTemp.PotE        := TermTemp.PotE;
        recTermTemp.TipoTerm    := TermTemp.TipoTerm;
        recTermTemp.Modello     := TermTemp.Modello;
        recTermTemp.Serie       := TermTemp.Serie;
        recTermTemp.Piano       := TermTemp.Piano;
        recTermTemp.Profondita  := TermTemp.Profondita;
        recTermTemp.Altezza     := TermTemp.Altezza;
        recTermTemp.Larghezza   := TermTemp.Larghezza;
        recTermTemp.NumElementi := TermTemp.NumElementi;
        write(fT,recTermTemp);
    end;
    close(FT3d);
  except
    close(FT3d);
  end;
  close(FT);
except
  close(FT);
end;
for i:=1 to Npiani do if arfileT[i].exrete then close(arfileT[i].fcr);
end;

Procedure GeneraFile3D(nomePr: String;scomponi:boolean);
Var FO3d:file of DatiInt;

begin
  ScriviUnif3D(nomePr,scomponi);
  ScriviTermf3D(NomePr,false); //bisogna rivedere la quota Z prima di scomporre

  assign(FO3d, IncludeTrailingPathDelimiter(PercorsoDrive) + Nomepr + '.O3D');
  Rewrite(FO3d);
  write(fO3d,risultcalc^);
  close(FO3d);
end;



Procedure Aggiorna_Calc_reti_BM;
Var IndiceRete: Byte;
    org:integer;
begin
if not fileexists(I_sl(PercorsoDrive) +'Tubi.txt')then exit;

//form create

CopyFile(PChar(Percorso_Archivi + 'Perdite.db'), PChar(Percorso_Progetti + 'Perdite.db'), False);
CaricaArchivi;
//spostato da leggielencoreti
dmtutti.T_Reti.first;
while not dmtutti.T_Reti.Eof do
  begin
  dmtutti.T_Reti.edit;
  V_Recgen.set_V('');
  dmtutti.T_Reti.post;
  dmtutti.T_Reti.next;
  end;
risultcalc^.Origine:=0;

//if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + 'Disegno.dxf') then
//copyfile(Pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'Disegno.dxf'),Pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'WorkDisegno.dxf'),false)
//else
// begin
// copyfile(Pchar(IncludeTrailingPathDelimiter(Percorso_RisorseGenerale) + 'Risorse\Prototipobm.dxf'),Pchar(IncludeTrailingPathDelimiter(PercorsoDrive) + 'WorkDisegno.dxf'),false);
// input_dxf(I_sl(PercorsoDrive) + 'WorkDisegno.dxf');
// end;
//  copyfile(Pchar(I_sl(PercorsoDrive) + 'WorkDisegno.dxf'),Pchar(I_sl(PercorsoDrive) + 'CopiaDisegno.dxf'),false);
//  Read_Dxf(I_sl(PercorsoDrive) + 'copiadisegno.dxf', I_sl(PercorsoDrive) + 'DISEGNOTUBO.txt',true);
 if fileexists(I_sl(PercorsoDrive) +'Tubi.txt')then
 LeggiFileTubi(I_sl(PercorsoDrive) +'Tubi.txt')
 else exit;

 Dmtutti.T_Reti.First;
 IndiceRete := 1;
  While not Dmtutti.T_Reti.Eof do
  begin
   with V_Recgen do
    begin
         Dmtutti.T_Reti.Edit;
         costruiscigrafo(Xori,Yori,Zori,org,IndiceRete);
         Set_Origine(org);
         Dmtutti.T_Reti.Post;
         set_Tipo_rete(progetto);
    end;
    Dmtutti.T_Reti.Next;
    inc(IndiceRete);
  end;
CaricaDati;
//form activate
 settaFiltro;
 set_Tipo_rete(V_RecGen.progetto);

 // segue  esegui_calcoli;

CaricaCodiciTerminali;
// Emanuela
GeneraFile3D(v_recgen.Codice,true);
CalcolatutteLereti;

end;

function Risolvirimandi:boolean;
Var i,j,k,l,piuvicino:integer;
    codrete,pianosotto:string;
    xm,ym,zm,distmin:real;
    collegato:boolean;

function codrete1(ind:integer):string;
begin
with dis^[ind]^ do
result:=uppercase(copy(rimando,5,length(rimando)-4));
end;

function Indice_piano(codice:string):integer;
var ind:integer;
begin
codice:=uppercase(codice);
for ind:=1 to npiani  do
if uppercase(piani_d^[ind].cod)=codice then break;
result:=ind;
end;

begin
result:=false;

if testrete then
  begin
  for i:=1 to ultriga do
  with dis^[i]^ do
    begin
    if (rimando<>'')and(rimando[1]='A') then
      begin //crea un terminale virtuale al posto del rimando per il test del piano isolato
      x2:=x2+1;
      y2:=y2+1;
      z2:=z2+1;
      inc(ngterm);
      if Gterm^[ngterm]=nil then new(Gterm^[ngterm]);
      if ngterm>1 then Gterm^[ngterm]^:=Gterm^[ngterm-1]^;
      with Gterm^[ngterm]^ do
        begin
        cod:='RIMANDO';
        Xterm:=x2;
        Yterm:=Y2;
        Zterm:=z2;
        end;
      end;
    if (rimando<>'')and(rimando[1]='B') then
    //if existripresa then  per permettere più colonne montanti
    //InserisciErrore('Una sola ripresa rete è permessa :',piano,X2,Y2)
    //else
      begin
      existripresa:=true;
      x1:=x2-1;
      y1:=y2-1;
      z1:=z2-1;
      XoriRip:=x1;
      Yoririp:=y1;
      ZoriRip:=z1;
      end;
    end;
  end
else
  begin
  for k:=1 to npiani do
  for i:=1 to ultriga do
  with dis^[i]^ do
  if (rimando<>'')and(uppercase(piano)=uppercase(piani_d^[k].Cod)) then
    begin
    codrete:=uppercase(copy(rimando,5,length(rimando)-4));
    piuvicino:=0;
    for j:=1 to ultriga do
    if (dis^[j].rimando<>'')and(codrete=codrete1(j))and(indice_piano(dis^[j].Piano)>k) then
    if (piuvicino=0)or(sqrt(sqr(x1-dis^[j].x1)+sqr(y1-dis^[j].y1)+sqr(z1-dis^[j].z1))<distmin) then
      begin
      piuvicino:=j;
      distmin:=sqrt(sqr(x1-dis^[j].x1)+sqr(y1-dis^[j].y1)+sqr(z1-dis^[j].z1));
      end;
    if (piuvicino=0) then
      begin
      if ((x1=x2)and(y1=y2)and(z1=z2)) then
        begin
        inseriscierrore('Piano: '+piano+', non riesco a collegare '+codrete,piano,x1,y1);
        result:=true;
        end;
      end
    else
      begin
      if (x1<>x2)or(y1<>y2)or(z1<>z2)  then  //rimando di partenza già  collegato
        begin
        dis^[piuvicino]^.x2:=x1;
        dis^[piuvicino]^.y2:=y1;
        dis^[piuvicino]^.z2:=z1;
        end
     else
        begin
        x2:=(x1+dis^[piuvicino]^.x1)/2;
        Y2:=(Y1+dis^[piuvicino]^.Y1)/2;
        z2:=(Z1+dis^[piuvicino]^.z1)/2;
        dis^[piuvicino]^.x2:=x2;
        dis^[piuvicino]^.y2:=y2;
        dis^[piuvicino]^.z2:=z2;
        end;
      end;
    end;
  end;
end;

function Risolvirimandi1:boolean;
Var i,j:integer;
    codrete,pianosotto:string;
    xm,ym,zm:real;
    collegato:boolean;
function codrete1(ind:integer):string;
begin
with dis^[ind]^ do
result:=uppercase(copy(rimando,5,length(rimando)-4));
end;
Function Piano_sotto(ind1,ind2:integer):boolean;
Var cod1,cod2:string;
    i,indp1,indp2:integer;
    xtt,ytt,ztt:real;
begin
indp1:=0;
indp2:=0;
cod1:=dis^[ind1]^.Piano;
cod2:=dis^[ind2]^.Piano;
i:=0;
while (i<npiani)and((indp1=0)or(indp2=0)) do
  begin
  inc(i);
  if piani_d^[i].cod=cod1 then indp1:=i;
  if piani_d^[i].cod=cod2 then indp2:=i;
  end;
result:=indp1=(indp2+1);;
end;
begin
result:=false;
for i:=1 to ultriga do
with dis^[i]^ do
  begin
  if (rimando<>'')and(rimando[1]='A') then
  if not testrete then
    begin
    codrete:=uppercase(copy(rimando,5,length(rimando)-4));
    //pianosotto:='';
    //j:=1;
    //while (j<Npiani)and(Piani_d^[j].cod<>dis^[i]^.Piano)do inc(j);
    //if (j>1)and(Piani_d^[j].cod=dis^[i]^.Piano)then pianosotto:=Piani_d^[j-1].cod;
    (*
    //collegamento con cloni
    for j:=i+1 to ultriga do
    if (rimando<>'') then
      begin
      collegato:=not ((dis^[j]^.x1=dis^[j]^.x2 )and(dis^[j]^.y1=dis^[j]^.y2 )and(dis^[j]^.z1=dis^[j]^.z2 ));
      end;
    //fine collegamento con cloni
    *)
    j:=1;
    while (j<Ultriga)and((dis^[j]^.rimando='')or(dis^[j]^.rimando[1]='A')or
          ((codrete<>uppercase(dis^[j]^.piano))and(codrete<>codrete1(j))) ) do inc(j);
    if  (dis^[j]^.rimando<>'')and(dis^[j]^.rimando[1]='B')and
    ((codrete=uppercase(dis^[j]^.piano))or(codrete=codrete1(j))) then
      begin
      x2:=(x1+dis^[j]^.x2)/2;
      Y2:=(Y1+dis^[j]^.Y2)/2;
      z2:=(Z1+dis^[j]^.z2)/2;
      dis^[j]^.x1:=x2;
      dis^[j]^.y1:=y2;
      dis^[j]^.z1:=z2;
      end
    else
      begin
      inseriscierrore('Piano: '+piano+', rimando rete a'+codrete+' non trova corrispondenza in una ripresa rete',piano,0,0);
      result:=true;
      end;
    end
  else
    begin //crea un terminale virtuale al posto del rimando per il test del piano isolato
    x2:=x2+1;
    y2:=y2+1;
    z2:=z2+1;
    inc(ngterm);
    if Gterm^[ngterm]=nil then new(Gterm^[ngterm]);
    if ngterm>1 then Gterm^[ngterm]^:=Gterm^[ngterm-1]^;
    with Gterm^[ngterm]^ do
      begin
      cod:='RIMANDO';
      Xterm:=x2;
      Yterm:=Y2;
      Zterm:=z2;
      end;
    end;
  if (testrete)and(rimando<>'')and(rimando[1]='B') then
  if existripresa then
  InserisciErrore('Una sola ripresa rete è permessa :',piano,X2,Y2)
  else
    begin
    existripresa:=true;
    x1:=x2-1;
    y1:=y2-1;
    z1:=z2-1;
    XoriRip:=x1;
    Yoririp:=y1;
    ZoriRip:=z1;
    end;
  end;
for i:=1 to ultriga do
if not testrete then
with dis^[i]^ do
if (rimando<>'')and(rimando[1]='B') then
  begin
  if (x1=x2)and(y1=y2)and(z1=z2)then
    begin
    j:=1;
    while (j<ultriga)and((i=j)or(uppercase(dis^[j]^.rimando)<>uppercase(rimando))or(not Piano_sotto(i,j))) do inc(j);
    if (i<>j)and(uppercase(dis^[j]^.rimando)=uppercase(rimando))and(Piano_sotto(i,j)) then
      begin
      x1:=dis^[j]^.x2;
      y1:=dis^[j]^.y2;
      z1:=dis^[j]^.z2;
      end
    else
      begin
     InserisciErrore('Piano '+piano+' :ripresa rete non agganciata ad un rimando rete',piano,X1,Y1);
      {
      //inserito a scopo debug
      j:=1;
      while (j<ultriga)and((i=j)or(uppercase(dis^[j]^.rimando)<>uppercase(rimando))or(not Piano_sotto(i,j))) do
        begin
        if (i<>j)and (dis^[j]^.rimando<>'') then
          begin
          if uppercase(dis^[j]^.rimando)<>uppercase(rimando) then
          showmessage('Fallito confronto'+dis^[j]^.rimando+' '+rimando)
          else
          showmessage(piani_d^[j].Cod+'non è il pianosotto di '+piani_d^[i].Cod);
          end;
        inc(j);
        end;
      if (i<>j)and(dis^[j]^.rimando=rimando)and(Piano_sotto(i,j)) then
        begin
        x1:=dis^[j]^.x2;
        y1:=dis^[j]^.y2;
        z1:=dis^[j]^.z2;
        end
      }
      end;
    end
  end;
end;

Function Caricarete_Cad(rete:string):boolean;
Var i,j,k,l,count,countterm,P_ig,res:integer;
    frc:file of cadrec;
    FrT:file of recgterm;
    Piano,pianodup:string;
    z_corr,x_int,y_int,salvaapr:real;
    Ferrori:textfile;
    bufer:string;
    errore_pan:string;
    eex,eey:real;
{$I Inters}
begin
cisono_collettori:=false;
apr:=0.001;{0.003} //approssimazione di inters ( metri )
for l:=1 to Npiani do
if piani_D^[l].copiadi='' then
begin
z_corr:=0;
for i:=1 to Npiani do
begin
if (i=l)or (piani_D^[l].Cod=piani_D^[i].copiadi) then
begin
piano:=piani_D^[l].Cod;
pianodup:=piani_D^[i].Cod;
Leggi_contorni(Piano);
if uppercase(V_recgen.Piano)=uppercase(piano) then V_recgen.Set_Zori(z_corr);
if (calcunpiano='')or(calcunpiano=uppercase(piani_D^[i].Cod)) then
  begin
  if fileexists(i_sl(percorsodrive)+rete+'-'+piano+'.U2d')or(Controllorete_in_memoria) then
    begin
    if fileexists(i_sl(percorsodrive)+rete+'-'+piano+'.U2d') then
      begin
      assign(frc,i_sl(percorsodrive)+rete+'-'+piano+'.U2d');
      reset(frc);
      count:=0;
      if not Controllorete_in_memoria then init_disegno_pannelli;
      while not eof(Frc) do
        begin
        inc(count);
        inc(Ultriga);
        if dis^[Ultriga]=nil then new(dis^[Ultriga]);
        read(frc,dis^[Ultriga]^);
        {  disattivato in attesa di test
        if (dis^[Ultriga]^.rimando='')and(sqrt(sqr(dis^[Ultriga]^.x2-dis^[Ultriga]^.x1)+sqr(dis^[Ultriga]^.y2-dis^[Ultriga]^.y1)+sqr(dis^[Ultriga]^.z2-dis^[Ultriga]^.z1))<0.01) then
          begin
          dec(count);
          dec(ultriga);
          end
        else
        }
          begin
          if dis^[Ultriga]^.Tipo='FITTIZIA' then
            begin
            if not Controllorete_in_memoria then add_contorno(ultriga);
            dec(count);
            dec(ultriga);
            end
          else
            begin
            if (pos('?',dis^[Ultriga]^.Tipo)<>0)and(dis^[Ultriga]^.Rimando='') then
            InserisciErrore('Tipo tubazione errata',piano,(dis^[Ultriga]^.x1+dis^[Ultriga]^.x2)/2,(dis^[Ultriga]^.y1+dis^[Ultriga]^.y2)/2);
            dis^[Ultriga]^.piano:=pianodup;
            if (piano<>pianodup)and(pos('-A',dis^[Ultriga]^.Rimando)<>0) then dis^[Ultriga]^.Rimando[2]:='B';
            //nei piani duplicati trasforma i rimandi in riprese
            with dis^[Ultriga]^ do
              begin
              if cl then cisono_collettori:=true;
              Item_input:=count;
              z1:=z1+z_corr;
              z2:=z2+z_corr;
              tronco:=0;
              end;
            end
          end
        end;
      close(frc);
      end;
    if not Controllorete_in_memoria then
       begin
       leggi_controllo(piano);
       Analisi_disegno_pannelli(piano,false,errore_pan,eex,eey);
       if errore_pan<>'' then
         begin
         Errore_pannelli:=errore_pan;
         pianoepan:=piano;
         xepan:=eex;
         yepan:=eey;
         end;
        //da l'errore solo se ci sono pannelli serve se non si è disegnato l'edificio
       //InserisciErrore(errore_pan,piano,eex,eey);
       end;
    //spezza le linee che si intersecano con l'estremità di un'altra linea
    //salvaapr:=apr;
    j:=0;
    while j<ultriga do
      begin
      inc(j);
      k:=0;
      while k<ultriga do
        begin
        inc(k);
        //apr:=0.01;
        if k<>j then
        { disattivato in attesa di test
        if not((P_vic(dis^[j]^.x1,dis^[j]^.y1,0,dis^[k]^.x1,dis^[k]^.y1,0))or
                (P_vic(dis^[j]^.x1,dis^[j]^.y1,0,dis^[k]^.x2,dis^[k]^.y2,0))or
                (P_vic(dis^[j]^.x2,dis^[j]^.y2,0,dis^[k]^.x1,dis^[k]^.y1,0))or
                (P_vic(dis^[j]^.x2,dis^[j]^.y2,0,dis^[k]^.x2,dis^[k]^.y2,0))
              )then
        }
          begin
          //apr:=salvaapr;
          inters(x_int,y_int,res,dis^[j]^.x1,dis^[j]^.x2,dis^[k]^.x1,dis^[k]^.x2,dis^[j]^.y1,dis^[j]^.y2,dis^[k]^.y1,dis^[k]^.y2);
          if (res<>0)and(P_vic(x_int,y_int,0,dis^[k]^.x1,dis^[k]^.y1,0)or P_vic(x_int,y_int,0,dis^[k]^.x2,dis^[k]^.y2,0)) then
            begin
            inc(ultriga);
            if dis^[ultriga]=nil then new(dis^[ultriga]);
            dis^[ultriga]^:=dis^[j]^;
            dis^[ultriga]^.x1:=X_int;
            dis^[ultriga]^.y1:=y_int;
            dis^[j]^.x2:=X_int;
            dis^[j]^.y2:=y_int;
            dec(k);
            end;
          end;
        end;
      end;
    for j:=1 to ultriga do
    for k:=1 to ultriga do
    if k<>j then
    if (P_vic(dis^[j]^.x1,dis^[j]^.y1,dis^[j]^.z1,dis^[k]^.x1,dis^[k]^.y1,dis^[k]^.z1)and
        P_vic(dis^[j]^.x2,dis^[j]^.y2,dis^[j]^.z2,dis^[k]^.x2,dis^[k]^.y2,dis^[k]^.z2))or
        (P_vic(dis^[j]^.x1,dis^[j]^.y1,dis^[j]^.z1,dis^[k]^.x2,dis^[k]^.y2,dis^[k]^.z2)and
        P_vic(dis^[j]^.x2,dis^[j]^.y2,dis^[j]^.z2,dis^[k]^.x1,dis^[k]^.y1,dis^[k]^.z1)) then
    InserisciErrore('Tratti sovrapposti',piano,(dis^[j]^.x1+dis^[j]^.x2)/2,(dis^[j]^.y1+dis^[j]^.y2)/2);

    { disattivato in attesa di test
    for j:=1 to ultriga do
    with dis^[j]^ do
    if rimando='' then
    if sqrt(sqr(x2-x1)+sqr(y2-y1)+sqr(z2-z1))<0.01 then
    InserisciErrore('Tubo di lunghezza troppo corta',piano,(dis^[j]^.x1+dis^[j]^.x2)/2,(dis^[j]^.y1+dis^[j]^.y2)/2);
     }
    end;
  if fileexists(i_sl(percorsodrive)+rete+'-'+piano+'.T2d') then
    begin
    assign(frT,i_sl(percorsodrive)+rete+'-'+piano+'.T2d');
    reset(frT);
    countterm:=0;
    while not eof(frt) do
      begin
      inc(Ngterm);
      if GTerm^[Ngterm]=nil then new(GTerm^[Ngterm]);
      read(frt,GTerm^[Ngterm]^);
      inc(countterm);
      GTerm^[Ngterm]^.Piano:=pianodup;
      GTerm^[Ngterm]^.CodentDxf:=inttostr(countterm);
      with GTerm^[Ngterm]^ do
        begin
        //spostato perche quì non è caricato tipoterm
        //if (uppercase(copy(tipoterm,1,4))='PANN')and(errore_pannelli<>'') then
        //InserisciErrore(errore_pannelli,pianoepan,xepan,yepan);
        zterm:=zterm+Z_corr;
        taratura:='';
        end;
      end;
    close(frT);
    end;
  end;
end;
P_ig:=1;
if piani_D^[i].Piani_Uguali<>0 then P_ig:=piani_D^[i].Piani_Uguali;
z_corr:=z_corr+piani_D^[i].AltL*P_ig;
end;
end;
result:=not Risolvirimandi;
if testrete then result:=true
end;

Procedure Controllaerrorireti;
begin
Dmtutti.T_Reti.First;
While (not Dmtutti.T_Reti.Eof)and((calcUnarete='')or(calcUnarete=uppercase(V_Recgen.codice))) do
with V_Recgen do
  begin
  end;
end;

Procedure Set_rete_calc(nomerete:string);
begin
Calcunarete:=nomerete;
end;


Procedure Azzera_errori(nome_rete:string);
var i:integer;
begin
for i:=1 to npiani do
with piani_d^[i] do
if fileexists(I_Sl(percorsodrive)+'\errori_'+cod+'_'+nome_rete+'.txe') then
deletefile(I_Sl(percorsodrive)+'\errori_'+cod+'_'+nome_rete+'.txe');
end;
Procedure Aggiorna_Calc_reti_Cad(nome_rete_calc:string);
Var Indicerete,i,j:integer;
    org:integer;
    ff:textFile;
    una_rete:boolean;
begin
CopyFile(PChar(Percorso_Archivi + 'Perdite.db'), PChar(Percorso_Progetti + 'Perdite.db'), False);
nome_rete_calc:=uppercase(nome_rete_calc);
un_errore:=false;
Errore_pannelli:='';
existripresa:=false;
CaricaDati;
Set_indice_rete(nome_rete_calc);
leggi_mem_zone;
copiafilefiltro(percorso_archivi,percorso_progetti,'perdite_conc.*');
copiafilefiltro(percorso_archivi,percorso_progetti,'dett_perdite_conc.*');
leggi_mem_Perdite_Conc;
CaricaArchivi;
una_rete:=False;
ApriFileOutBM(IncludeTrailingPathDelimiter(percorsodrive) + 'tubirit.txt');

Azzera_Calc_tubi;
Azzera_errori(nome_rete_calc);
calcUnarete:=uppercase(calcUnarete);
Dmtutti.T_Reti.First;
IndiceRete := 1;
While (not Dmtutti.T_Reti.Eof)and(uppercase(V_Recgen.Codice)<>nome_rete_calc) do
  begin
  Dmtutti.T_Reti.Next;
  inc(IndiceRete);
  end;
if uppercase(V_Recgen.Codice)=nome_rete_calc then
  begin
  if ((calcUnarete='')or(calcUnarete=uppercase(V_Recgen.codice))) then
  with V_Recgen do
    begin
    Dmtutti.T_Reti.Edit;
    una_Rete:=true;
    set_report('');
    nome_rete:=codice;
    if (testrete)or(controllaprogetto(codice,false)) then
    if Caricarete_Cad(codice) then
      begin
      Carica_fileInt('inp');
      if ultriga<1 then
      InserisciErrore('Nessun tratto disegnato','',0,0)
      else
      if (testrete)and(not existripresa)and(uppercase(piano)<>calcunpiano) then
      InserisciErrore('Inizio/ripresa rete assente','',dis^[1]^.x1,dis^[1]^.y1);

      if (testrete)and(existripresa) then
        begin
        // per permettere più colonne montanti
        for i:=1 to ultriga do
        with Dis^[i]^ do
        if (rimando<>'')and(rimando[1]='B') then
          begin
          XoriRip:=Dis^[i]^.x1;
          Yoririp:=Dis^[i]^.y1;
          ZoriRip:=z1;
          ulttronco:=0;
          costruiscigrafo(XoriRip,YoriRip,ZoriRip,org,IndiceRete);
          end
        end
      else
        begin
        costruiscigrafo(Xori,Yori,Zori,org,IndiceRete);
        //GeneraFile3D(Codice,true); //modifica per vedere nel 3d cose non collegate disattivata (scompaiono i terminali)
        end;

      Carica_perdite_mancanti;
      Set_Origine(org);
      set_Tipo_rete(progetto);
      settaFiltro;
      set_Tipo_rete(progetto);
      //CaricaCodiciTerminali; spostato dentro controlloterm
      controllo_term;
      controllo_tratti;

      for i:=1 to NGterm do
      with GTerm^[i]^ do
      if uppercase(copy(tipoterm,1,4))<>'PANN' then
        begin
        for j:=1 to ulttronco do
        if dati^[j]^.Term=i then break;
        if (j<=ulttronco)and(dati^[j]^.Term=i) then
        cod:='R. '+inttostr(dati^[j]^.CodiceTubo);
        end;

      GeneraFile3D(Codice,true); //modifica per vedere nel 3d cose non collegate disattivata (scompaiono i terminali)
      set_Verifica('NO');
      Dmtutti.T_Reti.Edit;
      Dmtutti.T_Reti.Post;
      if not un_errore then
      if not TestRete then CalcoloPannelli;//Precalcolo per calcolare portata e lunghezza tubi


      if not TestRete then
      if eseguiCalcoli then
        begin
        salvacalcoli(Codice);
        Dmtutti.T_Reti.edit;
        set_report(Str_Calc_OK);
        set_Verifica('SI');
        Dmtutti.T_Reti.Post;
        //{$Ifdef Debugtubi}
        for i:=1 to Npiani do
        with piani_d^[i] do
         begin
         //AzzeraDXf;
         //InitSimbDXF;
         AzzeraDXf;
         LeggiNomeProgetto;
         Caricadistubi(nome_rete,cod,false);
         perc_progcor:=extractfilepath(progcor)+
                      'Work_'+
                      copy(extractfileName(progcor),1,length(extractfileName(progcor))-4)+'\';
         {$Ifdef Debugtubi}
         PiantaEsterna:=perc_progcor+Rif_Pianta;
         scalapiantaesterna:=ScalaP;
         Leggi_controllo(cod);
         with reccontrollo do
         Add_BloccoDxf_col(-or_x,-or_Y,0,0,'RIFEST','0','1');
         {$Endif}
         dis_esecutivo:=true;
         Dxf_rete(nome_rete,cod,false);
         //Dxf_esecutivo(nome_rete,cod);
         Ripristina_orig_rete(cod);
         {
         tutto_grigio:=true;
         output_dxf(pchar(perc_progcor+'Elaborato_'+nome_rete+'_'+cod+'_grigio.dxf'));
         tutto_grigio:=false;
         }
         output_dxf(pchar(perc_progcor+'Elaborato_'+nome_rete+'_'+cod+'.dxf'));
         //copyfile(pchar(i_sl(percorsodrive)+nome_rete+'_'+cod+'.dxf'),pchar(perc_progcor+nome_rete+'_'+cod+'.dxf'),false);
         AzzeraDXf;
         Dxf_esecutivo(nome_rete,cod);
         Ripristina_orig_rete(cod);
         output_dxf(perc_progcor+nome_rete+'_'+cod+'_G.dxf');
         end;
       //{$Endif}
       end
     else  Salvacalcoli(Codice);
     RisultCalc^.Origine := Origine;
     //GeneraFile3D(Codice,false); ???
     end;
    end;
  //Dmtutti.T_Reti.Next;
  //inc(IndiceRete);
  end;
if not testrete then
//if Tipo_Rete <> trCanali then scaricadxf('5','TR');
//Fine_compart;
//scriviquotebm;
AttivaoutBm := True;
//Provvisorio 3d scriviquote(IncludeTrailingPathDelimiter(PercorsoDrive) + 'WorkDisegno.dxf');
// ChiudiFo;
ChiudiFileOutBM;


if una_rete then
if not(Un_errore) then
  begin
  AssignFile(Ff, I_SL(PercorsoDrive) + NomeFile_Errori_Impianti);
  rewrite(FF);
  writeln(ff,Str_Calc_OK);
  close(FF);
  end;
end;

Procedure Aggiornaesecutivi;
var i,j,k:integer;
begin
perc_progcor:=extractfilepath(progcor)+
                'Work_'+
                 copy(extractfileName(progcor),1,length(extractfileName(progcor))-4)+'\';

leggi_mem_piani;
leggi_mem_reti;
for i:=1 to Ngen do
for j:=1 to Npiani do
with piani_d^[j] do
if fileexists(perc_progcor+GENERALITA_D1^[i].Codice+'_'+cod+'.dxf') then
if GENERALITA_D1^[i].report=Str_Calc_OK then
if fileexists(I_sl(PercorsoDrive) + GENERALITA_D1^[i].Codice + '.D3D') then
if not fileexists(perc_progcor+'Elaborato_'+GENERALITA_D1^[i].Codice+'_'+cod+'.dxf') then
  begin
  nome_rete:=GENERALITA_D1^[i].Codice;
  AzzeraDXf;
  leggi_controllo(cod);
  Input_dxf(perc_progcor+nome_rete+'_'+cod+'.dxf',false);
  for k:=1 to nentita do
  with entita_d^[k]^ do
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
  dis_esecutivo:=false;
  CaricaInputDXF(false,false,false);

  AzzeraDXf;
  LeggiNomeProgetto;
  Caricadistubi(nome_rete,cod,false);
  dis_esecutivo:=true;
  Dxf_rete(nome_rete,cod,false);
  Ripristina_orig_rete(cod);
  output_dxf(pchar(perc_progcor+'Elaborato_'+nome_rete+'_'+cod+'.dxf'));
  end;
end;

Procedure Aggiorna_Calc_reti(rete_corrente:string);
begin
testrete:=false;
{CalcUnaRete:='';}CalcUnPiano:='';
TestRete:=False;
progcor:=leggi_var('PROGETTOCORRENTE');
Leggi_Piani(DMtutti.T_Piani,DMtutti.T_PPiano,dmtutti.DS_Piani);
//exit;
if fileexists(I_sl(PercorsoDrive) +'Tubi.txt')then Aggiorna_Calc_reti_BM
else Aggiorna_Calc_reti_Cad(rete_corrente);
end;
function controllaprogetto(rete:string;agg:boolean):boolean;
Var Ferrori:textfile;
    bufer,piano:string;
    i:integer;
begin
Result:=true;
for i:=1 to npiani do
with piani_d^[i] do
if fileexists(i_sl(percorsodrive)+rete+'-'+piano+'.U2d') then
  begin
  if fileexists(I_Sl(percorsodrive)+'\errori_'+cod+'_'+rete+'.txe') then
    begin
    Assign(Ferrori,I_Sl(percorsodrive)+'\errori_'+cod+'_'+rete+'.txe');
    reset(Ferrori);
    Readln(Ferrori,bufer);
    Readln(Ferrori,bufer);
    close(ferrori);
    if agg then
    if (pos('controllare',bufer)=0)or(pos('riuscito',bufer)=0) then  Controlla_rete(rete,cod)
    else
    if pos('correttamente',bufer)=0 then
      begin
      result:=false;
      inseriscierrore('Piano:'+cod+', '+bufer,'',0,0);
      dmtutti.T_reti.post;
      dmtutti.T_reti.edit;
      end;
    end
  else if agg then Controlla_rete(rete,cod);
  end;
end;
Procedure Controlla_rete(rete,piano:string);
var Ferrori:TextFile;
begin
un_errore:=false;
Leggi_Piani(DMtutti.T_Piani,DMtutti.T_PPiano,dmtutti.DS_Piani);
Assign(Ferrori,I_Sl(percorsodrive)+'\errori_'+piano+'_'+rete+'.txe');
rewrite(Ferrori);
writeln(Ferrori,piano);
writeln(Ferrori,'Rete interpretata correttamente');
writeln(Ferrori,'0');
writeln(Ferrori,'0');
close(ferrori);
CalcUnaRete:=uppercase(rete);CalcUnPiano:=Uppercase(Piano);
TestRete:=true;
Aggiorna_Calc_reti_Cad(rete);
end;



end.
