unit inputc;

interface

uses {printer,}definiz,defuti,funzbase,genproc,gruti,winapi,crt,
     globfunz,key,Angoli,Blocco,tronco,Load_D,Vsez,Inser,Load_P,
     dxfoutu,Edit,riduz,init,halotp4,graph,Ridis_U{,plot},Debug,WM,{editquo,}
     diseg,esiste,{$ifdef win}MultiLin,strings,winprocs,bwcc,{$endif}controll,init_cca;

Procedure Prog_loop;
Procedure Prog_init;
Procedure Esegui(Var Scelta:Integer);
Procedure Errore(Mess:string);

Implementation
{$ifdef win}
uses u_winput;
{$endif}
{$I error_g}
var st1:string;

Procedure aggtogli(vero:boolean);

var

    str2: string[2];
    risult: integer;
    size:longint;
    i,j:integer;
    trovato:boolean;
    sbaglio : boolean;
    datiprog:string;
begin
datiprog:='';
datiprog:=driveprog;
sbaglio:=false;

if vero then
begin
  inc(naggdis);
  with vaicoldim^[naggdis] do
  begin
    Nprogettu:=ReadCom('Progetto da aggiung. ','',0);
    NProgettu:=Setleft(setright(nprogettu));
    if not exist(datiprog+Nprogettu+'.ret') then
    begin
      richiesta('File inesistente');
      sbaglio:=true;
      dec(naggdis);
      exit;
    end
    else
    begin
      str2:='';
      str2:=ReadCom('Colore Progetto <1..15>  ','14',0);
      val(str2,culuri,risult);
      if (culuri<0) or  (culuri>16)  or  (risult<>0)then
      begin
        dec(naggdis);
        exit;
      end;
    end;
  end;
end
else
begin  { not vero}
  st1:=Setleft(setright(ReadCom('Progetto da togliere ','',0)));
  if not exist(datiprog+st1+'.ret')
  then
  begin
    richiesta('File inesistente');
    sbaglio:=true;
  end
  else
  begin
    trovato:=false;
    for j:=1 to maxaggdis do
    if (vaicoldim^[j].nprogettu=st1) and (vaicoldim^[j].nprogettu>'') then
    begin
      trovato:=true;
      vaicoldim^[j].nprogettu:='';
      i:=j;
    end;

    if not trovato then
    begin
      richiesta('Progetto inesistente');
      sbaglio:=true;
    end
    else
    begin
      for j:= i to maxaggdis-1 do
      vaicoldim^[j]:= vaicoldim^[j+1];
      dec(naggdis);
    end;
                         { end;}
  end;

end;
if not sbaglio then richiesta('');
end;

{***************************  Errore        *******************************}

Procedure Errore(Mess:string);


begin
Richiesta('');
Richiesta(Mess);
{$ifdef dos}
write(chr(7));
{$endif}
{Delay(800);}
Richiesta('');
end;

type el_int=array[1..16000] of integer;
var tr_canc:^el_int;
    trerased:integer;

{*************************** CANCELLA ************************************}
Procedure Cancella;
var i,j,p,res,prima:integer;
    trovato,fine,troncoterm:boolean;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  CancTr           *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure CancTr(tr:integer);

var i,j,k,p,prossimo,lineiniz:integer;
    trovato:boolean;

begin

cancNum(tr);
dati^[tr]^.Ti:=0;             {-- cancellazione dati tronco --}
for p:=0 to pezzitr do
if dati^[tr]^.pezzi[p]<>0 then
VPezzi^[dati^[tr]^.pezzi[p]]^.Codice:='';

i:=1;                        {-- Ricerca del tronco padre --}
trovato:=false;
  repeat

  if Dati^[i]^.Ti<>0 then

    begin
    j:=1;
      repeat
      if dati^[i]^.pros[j]=tr then   {-- Trovato il tronco padre --}

        begin
        if dati^[i]^.pros[3]=0 then  {-- caso 2 --}
          begin
          if j=1 then prossimo:=dati^[i]^.pros[2]
          else        prossimo:=dati^[i]^.pros[1];
          lineiniz:=dati^[i]^.ti;
          CancNum(i);
          initrec(i,2);

          with dati^[i]^ do   {* A *}
            begin
            ti:=Lineiniz;
            for k:=1 to 6 do pros[k]:=dati^[prossimo]^.pros[k];
            {Term:=dati^[prossimo].Term;}
            end;

          k:=dati^[i]^.ti;
          while dis^[k]^.nlinea<>0 do k:=dis^[k]^.nlinea;
          dis^[k]^.nlinea:=dati^[prossimo]^.ti;   {* 1 *}

          k:=dati^[prossimo]^.ti;    {* 2 *}
          repeat
            dis^[k]^.tronco:=i;
            k:=dis^[k]^.nlinea;
            if k<>0 then if dis^[k]^.entita='T' then
              begin
              dis^[k]^.Tronco:=i;
              k:=0;
              end;
          until k=0;

          cancNum(prossimo);
          dati^[prossimo]^.ti:=0;   {* Canc C *}
          for p:=0 to pezzitr do
          if dati^[prossimo]^.pezzi[p]<>0 then
          VPezzi^[dati^[prossimo]^.pezzi[p]]^.Codice:='';

          end

        else

          begin
          for k:=j to 5 do dati^[i]^.pros[k]:=dati^[i]^.pros[k+1];
          dati^[i]^.pros[6]:=0;
          end;
        initrec(i,4);{cippo-messie 09/06/94}
        initrec4(i); {cippo-messie 09/06/94}
        trovato:=true;
        end;

      j:=j+1;
      until (trovato) or (j>6);
    end;
  i:=i+1
  until (trovato) or (i>ulttronco);



end;

{-*-*-*-*-*-*-*- CancAlb ( recursiva ) -*-*-*-*-*-*-*-*-*-*-*-}

procedure CancAlb(riga:integer);
var  i,j,pz,tempti,tempterm:integer;
     inizia:boolean;

begin
c1:=0;
setcolor(c1);
int1:=0;
setxor(@int1);

       {-- Cancellazione tronco selezionato (disegno) --}

i:=dati^[dis^[riga]^.tronco]^.Ti;

TroncoTerm:=false;
Fine:=false;
Inizia:=false;
repeat
  case dis^[i]^.entita[1] of
  'L':begin
      with dis^[i]^ do
      begin
        if (i=riga)or(inizia) then {-- Cerca il tratto selezionato --}
        begin
          inizia:=true;
          real1:=xg(x1,y1);real2:=yg(y1,z1);
          movabs1A(@real1,@real2);
          real3:=3;
          if (dis^[i]^.z1<>dis^[i]^.z2)and ug(dis^[i]^.z1,RisultCalc^.Quota,2)and(not(sezione))
          then cir(@real3);
          real1:=xg(x2,y2);real2:=yg(y2,z2);
          lnabs1(@real1,@real2);
          {$ifdef win}
          with dis^[i]^ do
          multicirsez(x1,y1,z1,real3,1);
          Multi_line(i);
          {$endif}

          entita:='';
          if rid<>'' then disrid(i,0);
          DisBoc(i);
          {pino}
          inc(trerased);
          tr_canc^[trerased]:=i;
        end;

        if nlinea=0 then fine:=true
        else i:=nlinea;
        if nlinea=riga then nlinea:=0;
        end
      end;

  'T':begin
      setstclr(@c1,@c1);
      Troncoterm:=true;
      dis^[i]^.entita:='';
      end;
  end;

until (fine)or(Troncoterm);

    {-- Cancellazione tronchi figli --}

with dati^[dis^[riga]^.tronco]^ do

  begin
  if pros[1]=0 then troncoterm:=true;
  if not troncoterm then
    begin
    i:=0;
      repeat
      i:=i+1;
      if pros[i]<>0 then CancAlb(dati^[pros[i]]^.Ti)
      until (pros[i]=0)or(i=6);
    end;

  if Ti=prima then  {-- Conttrolla se il tratto selezionato e il primo --}
    begin
    cancNum(dis^[riga]^.tronco);
    CancTr(dis^[riga]^.tronco);
    ti:=0;
    for pz:=0 to pezzitr do
    if pezzi[pz]<>0 then
    VPezzi^[pezzi[pz]]^.Codice:='';
    end

  else

    begin          {-- Reinizializzazione tronco --}
    if riga=ti then
      begin
      CancNum(dis^[riga]^.tronco);
      ti:=0;
      for pz:=0 to pezzitr do
      if pezzi[pz]<>0 then
      VPezzi^[pezzi[pz]]^.Codice:='';

      end
    else
      begin
      tempti:=Ti;
      {tempterm:=term;}
      CancNum(dis^[riga]^.tronco);
      initRec(dis^[riga]^.tronco,2);

      ti:=tempti;
      {term:=tempterm;}
      end
    end
  end;

end;


{ if (abs(dis^[i].x1- dis^[riga].x2)<0.01) and (abs(dis^[i].y1 - dis^[riga].y2)<0.01) then }

begin
new(tr_canc);
fillchar(tr_canc^,sizeof(tr_canc^),0);
trerased:=0;
while SelezLinea(i)<>130 do
  begin
  prima:=i;
  if i<>0 then CancAlb(i);
  end;
for i:=1 to trerased do
begin
  fillchar(dis^[tr_canc^[i]]^,sizeof(dis^[tr_canc^[i]]^),0);
end;
scelta:=0;
richiesta('');
end;

{*************************** zoomg ****************************************}
procedure zoomg(sw:integer);

var temp,yinf1,ysup1,xinf1,xsup1,zinf1,zsup1:real;
    st2:string;
    ampx:real;
    xcen,ycen:real;

const rapp:real=1000/750;

begin
  delhcur;
  {delay(200);}
  ST2:='';
  if sezione then
  st2:=readcom(W_M(1),CH6,0)
{   st2:=readcom('Zoom /Finestra/Precedente/Tutto/Ridis','F',0)}
  else st2:=readcom(W_M(2),CH6,0);
{ else st2:=readcom('Zoom /Finestra/Prec./Tutto/Limiti/Set-lim/Ridis','F',0);}
  {delay(300);}
  richiesta('');
    case Upcase(st2[1]) of
{ S,F }  CH11,CH6:begin
          richiesta('');
          richiesta(W_M(3));
{          richiesta('Primo angolo');}
          readcord(xp,yp,cod,scelta,ST1,1);
          delhcur;
          richiesta('');
          {delay(200);}
          if cod=132 then
          begin
            richiesta(W_M(4));
{            richiesta('Secondo angolo');}
            readcord(x,y,cod,scelta,ST1,4);
            delbox;
            richiesta('');
            if cod = 132 then
            begin
              if xp>x then
              begin
                temp:=x;
                x:=xp;
               xp:=temp
             end;
             if yp>y then
             begin
               temp:=y;
               y:=yp;
              yp:=temp
             end;
             xinfp:=xinf;yinfp:=yinf;xsupp:=xsup;
             ysupp:=ysup;zinfp:=zinf;zsupp:=zsup;
             Save_im:=true;
             Memo_im:='';
             if abs(x-xp)/abs(y-yp)>=rapp then ampx:=abs(x-xp)/2
             else ampx:=abs(y-yp)*rapp/2;
             xcen:=(x+xp)/2;
             ycen:=(y+yp)/2;

             yinf1:=ye(xcen-ampx,ycen-ampx/rapp);
             ysup1:=ye(xcen+ampx,ycen+ampx/rapp);
             xinf1:=xe(xcen-ampx);
             xsup1:=xe(xcen+ampx);
             zinf1:=ze(ycen-ampx/rapp);
             zsup1:=ze(ycen+ampx/rapp);



             xinf:=xinf1;
             yinf:=yinf1;
             xsup:=xsup1;
             ysup:=ysup1;
             zinf:=zinf1;
             zsup:=zsup1;
             {
             writeln(lst,' Xinf:',Xinf:5:0,' Xsup:',Xsup:5:0,
                  ' Yinf:',Yinf:5:0,' Ysup:',Ysup:5:0,
                  ' Zinf:',Zinf:5:0,' Zsup:',Zsup:5:0);
             }
             if Upcase(st2[1]) = CH11 then  { S }
             with RisultCalc^ do
             begin
               L_xinf:=xinf1;
               L_yinf:=yinf1;
               L_xsup:=xsup1;
               L_ysup:=ysup1;
             end;

             piccolo:=false{cippo};
             pianfilt:=false; {cippo}
             ridis;
             st2[1]:=' ';
           end;
         end;
       end;
{ T }   CH8:begin
         if sezione then
         begin
             Xsup:=S_limXS;
             Xinf:=S_LIMXI;
             YSup:=S_LimYS;
             YInf:=S_LimYI;
             ZSup:=S_LimZS;
             ZInf:=S_LimZI;

         end
         else
         begin
           Xsup:=limXS;
           Xinf:=LIMXI;
           YSup:=LimYS;
           YInf:=LimYI;
         end;

         piccolo:=false{cippo};
         pianfilt:=false; {cippo}
         ridis;
       end;
{ P }   CH7:begin
         xinf:=xinfp;
         yinf:=yinfp;
         xsup:=xsupp;
         ysup:=ysupp;
         zinf:=zinfp;
         zsup:=zsupp;
         piccolo:=false{cippo};
         pianfilt:=false; {cippo}
         ridis;
       end;

{ L }   CH10:with RisultCalc^ do
       begin
       xinf:=L_xinf;
       yinf:=L_yinf;
       xsup:=L_xsup;
       ysup:=L_ysup;
       piccolo:=false{cippo};
       pianfilt:=false; {cippo}
       ridis;
       end;

{ R }   CH9:begin
            Ridis;
            end;

  end;
st2:='';
scelta:=0;



end;


{***************************** Modi ****************************************}

Procedure Modi;


var i,campo,chiave:integer;
    initmask:boolean;


begin

campo:=1;
chiave:=61;
initmask:=true;
repeat

  real1:=0;real2:=0;real3:=1000;real4:=750;
  setclip(@real1,@real2,@real3,@real4);
  UsaMaskera(seg(conf^),OfS(conf^),'Modican.prv',
                 campo,Chiave,100,100,initmask,not(initmask),false,true);
  initmask:=false;

until (chiave=27);

if conf^.RSnap<0.01 then conf^.RSnap:=0.01;

ridis;
Scelta:=0;
end;


{***************************    uscita    ********************************}
function uscita:boolean;
var i:integer;
begin
st1:='';
sT1:=ReadCom(W_M(6),CH1,0);
{sT1:=ReadCom('Volete registrare le modifiche ?[s/n/Annulla]','S',0);}

case upcase(st1[1]) of
{S}  CH1:begin
        Savedis(DriveProg+NomeProg);
      {  dispose(dis);
        dispose(dati); cippo}
        for i:=1 to lungpezzi do if Vpezzi^[i]<>nil Then Dispose(Vpezzi^[i]);
        for i:=0 to lungdis   do if Dis^[i]<>nil Then Dispose(Dis^[i]);
        for i:=1 to lungdati  do if Dati^[i]<>nil Then Dispose(Dati^[i]);
        dispose(dis);
        dispose(dati);
        dispose(VPezzi);
        closegraphics;
        uscita:=true;
        end;
{N}  CH2:begin

        {dispose(dis);
        dispose(dati);}
        for i:=1 to lungpezzi do if Vpezzi^[i]<>nil Then Dispose(Vpezzi^[i]);
        for i:=0 to lungdis   do if Dis^[i]<>nil Then Dispose(Dis^[i]);
        for i:=1 to lungdati  do if Dati^[i]<>nil Then Dispose(Dati^[i]);
        dispose(dis);
        dispose(dati);
        dispose(VPezzi);
        closegraphics;
        uscita:=true;
      end;
else
begin
  scelta:=0;
  richiesta('');
  uscita:=false;
end;
end;{case}
end;

{***************************    MAIN      ********************************}



var
    fc  :text;
    i,j :integer;
    Ms  :string;
    dim :integer;
    sfl :boolean;
    sp  :real;
    fds :string;
    QuotaPrec:real;
    std :string;
Procedure prog_init;

begin
  {chdir('c:\cca\inpgraf');}
  FILETRADUZ:='DUCT';
  fds:='';
  sp:=1;
  nomebl:='';
  orz:=0;
  sezione:=false;

  fine:=false;
  {exec('halortp4','');}

  Errori('Tprcart','tpccart','Tprmcart');


  {$ifdef protetto}
  ControlloChiave(CtrlKey,18,600);
  {$else}
  ctrlkey:=1;
  {$endif}
  (*
  assign(fc,'drive1.int');
  reset(fc);
  read(fc,datadrive);
  close(fc);
  DriveDrive:=DataDrive+'\CCA\Driver\';
  AriaDrive:=DataDrive+'\Carterm\';
  CartDrive:=DataDrive+w_m(146);{'\Graphinp\Progetti\';}
  PianteDrive:=DataDrive+'\DisPLt\';
  DataDrive:=datadrive+'\DatiCCA\';
  BlocDrive:=DataDrive+w_m(149);{'\Progetti\';}
  *)
  initcca;
  new(risultcalc);
  new(conf);
  new(vaicoldim);
  LoadNome;
  inizializza;
  loaddis(Driveprog+Nomeprog);
  nrighe:=newriga;
  ntronchi:=newtr;
  Sfl:=SetFlag;
  Save_im:=true;
  ridis; {davide ins.}

End;

Procedure Esegui(Var Scelta:Integer);
var intr1:integer;
begin
    case scelta of

    0:Begin
      TEST('graf');
      VAGA;
      end;

    1:begin

      vista;
      scelta:=0;
      end;

    2:begin
        QuotaPrec:=RisultCalc^.Quota;
        repeat
        str(quotaprec*(conf^.AltNum/40000):6:2,st1);
      {  str(RisultCalc^.Quota*(conf^.AltNum/40000):6:2,st1);}
        st1:=readcom(W_M(7),st1,0);
{        st1:=readcom('Nuova quota di lavoro [m]',st1,0);}
        st1:=Setleft(st1);
        val(st1,RisultCalc^.quota,intr1);
        until intr1=0;
        RisultCalc^.quota:=RisultCalc^.quota/(conf^.AltNum/40000);
        if not((setflag)or(Vuoto)) then
          begin
          {$ifdef dos}
          write(chr(7));
          {$endif}
          richiesta(W_M(8));
          {richiesta('Nessun tronco alla quota selezionata');}
          RisultCalc^.Quota:=quotaPrec;
          sfl:=setflag;
          scelta:=0;
          end
        else
        begin
         pianfilt:=false; {cippo}
         piccolo:=false;
         ridis;
        end;
      end;

    3:begin
       piccolo:=false{cippo};
       pianfilt:=false; {cippo}
       zoomg(0);
      end;
    4:if (pieniT)or(PieniD) then
      begin
      Richiesta('');
      {$ifdef dos}
      write(chr(7));
      {$endif}
      Richiesta(W_M(9));
      {Richiesta('Memoria piena:formare sottoreti!');}
      End
      else LOad_TRONCO;

    5:begin
      if not (vuoto) then riduzione;
      scelta:=0;
      end;

    6:begin
      if not (vuoto) then SaveBl(1);
      scelta:=0;
      end;

    7:begin
      if not (vuoto) then Ins_tro;
      scelta:=0;
      end;

    8:CANCELLA;

    9:begin
      if not (vuoto) then EDIT_Dis{Editquote};
      scelta:=0;
      end;


   10:Modi;

   11:begin
      if not vuoto then
        begin
        DATItronco;
        end;
      scelta:=0;
      end;

   12:begin
      if RisultCalc^.DisDimens then
      Ms:=W_M(10)  {'Dimens-off'}
      else ms:=W_M(11); {'Dimens-on'}
      If RisultCalc^.DisUnif then ms:=ms+W_M(12) { Unif-off }
      else ms:=ms+W_M(13); { Unif-on }
      If RisultCalc^.Nodi then ms:=ms+W_M(14) { 'Nodi-off'}
      else ms:=ms+W_M(15); {'Nodi-on';}
        repeat
        St1:=Readcom(ms,CH15,33);  { D }
        st1[1]:=upcase(st1[1]);
        until (St1='')or(st1=CH15)or(st1=CH16)or(st1=CH37);   { D,U,N }

      if st1<>'' then

        case st1[1] of
{ D }        'D':RisultCalc^.DisDimens:=not(RisultCalc^.DisDimens);
{ U }        'U':RisultCalc^.DisUnif:=not(RisultCalc^.DisUnif);
{ N }        'N':RisultCalc^.Nodi:=not(RisultCalc^.Nodi);
        end;
      scelta:=0;
      Ridis;

      end;





   13:BEGIN
      st1:='';
      repeat
        st1:=readcom(W_M(16),CH13,0);  { S }
        {'Plotter/Stampante grafica/Dxf/Annulla','S',0);}
      until upcase(st1[1]) in [CH12,CH13,CH14,CH3];  { P,S,D,A }
      case upcase(st1[1]) of
{ D }      CH14: begin
             dim :=1;

           end;
{ U }      CH16: dim :=0;
      end;
{ A }      if upcase(st1[1])<> CH3 then
      begin

      st1:='';


      case upcase(st1[1]) of
{ P }      'P':begin
{ U }            st1:=readcom(W_M(17),CH16,0);
            {'Dimensionato/Unifilare','U',0);}
            case upcase(st1[1]) of
{D}            'D': begin
                   dim :=1;
                   fds:=readcom(W_M(18),'1',0);
                   {'Introdurre il fattore di scala','1',0);}
                   val(fds,sp,i);
                   if sp <=0 then
                   begin
                     {$ifdef dos}
                     write(chr(7));
                     {$endif}
                     richiesta(W_M(19));
                     {'Valore non corretto');}
                     {delay(500);}
                   end;
                  end;
{U}            'U': dim :=0;
            end;
            richiesta(W_M(20));
            {plotter(1,dim,sp,driveprog+nomeprog+'.dim');}
            {'Preparazione file SPOOL.PLT in corso. Attendere!');}
            if uscita then
            begin
              assign(f,'plot.sce');
              rewrite(f);
              write(f,'p');
              close(f);
              halt;
            end;
          end;
{S}      'S':begin
{U}            st1:=readcom(W_M(17),CH16,0);
            {'Dimensionato/Unifilare','U',0);}
            case upcase(st1[1]) of
{D}            'D': begin
                   dim :=1;
                   repeat
                   fds:=readcom(W_M(18),'1',0);
                   {'Introdurre il fattore di scala','1',0);}
                   val(fds,sp,i);
                   if sp <=0 then
                   begin
                     {$ifdef dos}
                     write(chr(7));
                     {$endif}
                     richiesta(W_M(19));
                     {'Valore non corretto');}
                     {delay(500);}
                   end;
                   until sp>0
                  end;
{U}            'U': dim :=0;
            end;
            richiesta(W_M(20));
            {plotter(0,dim,sp,driveprog+nomeprog+'.dim');}
            {'Preparazione file SPOOL.PLT in corso. Attendere!');}
            if uscita then
            begin
              assign(f,'stam.sce');
              rewrite(f);
              write(f,'p');
              close(f);
              halt;
            end;
          end;
{D}      CH14:begin
          richiesta('');
          st1:='';
          std:='';

{T}          std:=readcom(W_M(24),CH18,0);
          {'Bidimensionale/Tridimensionale','T',0);}
          st1:=readcom(W_M(25),'',0);
          {'Digitare il nome del file','',0);}
          st1:=st1+'.dxf';
         { if exists(st1) then}
          begin
{B}            if upcase(std[1])=CH17 then dxfout(st1,TRUE) else dxfout(st1,FALSE);
          end;
        (*  else
            begin
            richiesta('');
            write(chr(7));
            richiesta(W_M(26)+upstring(st1)+W_M(27));
            {'Nome di file '}  { ' non valido' }
            end;*)
          scelta:=0;
          st1:='';
          st1[1]:=' ';
          ridis;
          end;

       else
          begin
          scelta:=0;
          richiesta('');
          end;
        end;
      end
      else
      begin
          scelta:=0;
          richiesta('');
       end;

      end;

      14:begin
         SAVEDIS(Driveprog+NomeProg);
         scelta:=0
         end;

      15:begin
           st1:='';
{S}         sT1:=ReadCom('Aggiungi/Togli','A',0);
           case upcase(st1[1]) of

             'A':begin
                  aggtogli(true);
                 end;

             'T':begin
                  aggtogli(false)
                 end;

           end;
           scelta:=0;
        {   richiesta('');}
         end;

      16:begin
         st1:='';
{S}         sT1:=ReadCom(W_M(6),CH1,0);
         { 'Volete registrare le modifiche ?[s/n/Annulla]','S',0); }

         case upcase(st1[1]) of

{S}         CH1:begin
             Savedis(Driveprog+NomeProg);
             dispose(dis);
             dispose(dati);
             closegraphics;
             fine:=true;
             end;
{N}         CH2:begin
             dispose(dis);
             dispose(dati);
             closegraphics;
             fine:=true;
             end;
         else
             begin
             scelta:=0;
             richiesta('');
             end;
         end;{case}

         end;

      else scelta:=0;


      end; {case}
end;

Procedure Prog_loop;
Begin
scelta:=0;
  repeat
  EseGui(scelta);
  until fine;
 { chdir('c:\sorgenti\ductgraf');}
end;

end.
