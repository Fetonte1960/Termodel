{$M 65000,16384,655360} {Turbo 3 default stack and heap}
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit inputcan;

interface

uses {printer,}definiz,funzbase,genproc,gruti,
     globfunz,key,Angoli,Blocco,tronco,Load_D,Vsez,Inser,Load_P,
     dxfoutu,Edit,riduz,init,halotp4,graph,Ridis_U,plot,Debug,WM,editquo,
     diseg,grafer,esiste,controll,defuti;

Procedure Prog_loop;
Procedure Prog_init;
Procedure Esegui(Var Scelta:Integer);
Procedure Errore(Mess:string);

Implementation

{***************************  Errore        *******************************}

Procedure Errore(Mess:string);


begin
Richiesta('');
Richiesta(Mess);
Write(chr(7));
{Delay(800);}
Richiesta('');
end;




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

setcolor(c1);

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
          if not(ug(dis^[i]^.z1<>dis^[i]^.z2,2)and ug(dis^[i]^.z1=RisultCalc.Quota,2)and(not(sezione))
          then cir(@real3);
          real1:=xg(x2,y2);real2:=yg(y2,z2);
          lnabs1(@real1,@real2);
          entita:='';
          if rid<>'' then disrid(i,0);
          DisBoc(i);
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
while SelezLinea(i)<>130 do
  begin
  prima:=i;
  if i<>0 then CancAlb(i);
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
             with RisultCalc do
             begin
               L_xinf:=xinf1;
               L_yinf:=yinf1;
               L_xsup:=xsup1;
               L_ysup:=ysup1;
             end;

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


         ridis;
       end;
{ P }   CH7:begin
         xinf:=xinfp;
         yinf:=yinfp;
         xsup:=xsupp;
         ysup:=ysupp;
         zinf:=zinfp;
         zsup:=zsupp;
         ridis;
       end;

{ L }   CH10:with risultCalc do
       begin
       xinf:=L_xinf;
       yinf:=L_yinf;
       xsup:=L_xsup;
       ysup:=L_ysup;
       ridis;
       end;

{ R }   CH9:begin
            Ridis;
            end;

  end;
st2:='';
scelta:=0;



end;

(*
{*************************** PLOTTAGGIO   ********************************}

PROCEDURE plot;

var i:integer;
    nome:string;
    f:text;
    segment:word;
    Punt   :pointer;
    ofset:word;
const
    { ofset:integer=2048;}
     parm:array[1..5] of integer=(1,5000,1,0,0);


begin
  assign(f,'plot.sce');
  rewrite(f);
  write(f,'p');
  close(f);
  real1:=0;
  real2:=0;
  real3:=16158*4;
  real4:=11040*4;
  setworld(@real1,@real2,@real3,@real4);
  {setclip(@minxw,@minyw,@maxxw,@maxyw);}
  setcolor(c1);
  clr;
  if memAVail<5000 then write(Chr(7));
  GetMem(Punt,5000);
  segment:=seg(Punt^);
  ofset:=ofs(punt^);
  nome:='lista.plt';
  setfont(@fonti);
  lopen(@nome,@segment,@ofset,@parm);

  inqAsp(@real1);
  real2:=16158*3;
  real3:=11040*3;
  real4:=(maxyw-MinYw)/(Maxxw-MinXw);
  real4:=real4*((real2+1)/(real3+1))*real1;
  real4:=1;
  SetAsp(@real4);

  int1:=316;
  inqerr(@int1,@int2);
  str(int2,st1);
  richiesta(st1);
  delay(500);
  setfont(@fonti);
  setcolor(@c1);
  clr;

    real1:=1;

    if exist(DataDrive+NomeProg+'.DIM') then
      begin
      Assign(Fdim,DataDrive+NomeProg+'.DIM');
      Reset(Fdim);
      While not(eof(Fdim)) do
        begin
        read(Fdim,Vettore);
          Case Vettore.Entita[1] of
  'L','F','*':begin
              setlnstyle(@Vettore.tlinea);
              real1:=(Vettore.x1);
              real2:=(Vettore.y1);
              movabs(@real1,@real2);
              real1:=(Vettore.x2);
              real2:=(Vettore.y2);
              setcolor(@Vettore.colore);
              lnabs(@real1,@real2)
              end;
          'A':begin
              setlnstyle(@Vettore.tlinea);
              real1:=(Vettore.x1);
              real2:=(Vettore.y1);
              movabs(@real1,@real2);
              real1:=Vettore.x2;
              real2:=Vettore.y2;
              setcolor(@Vettore.colore);
              real3:=Vettore.R;
              arc(@real3,@Real1,@real2)
              end;
          end
        end;
      close(FDim);
      end;
 for i:=1 to nrighe do
  begin
    case dis^[i].entita[1] of
    'L':begin
          setlnstyle(@dis^[i].tlinea);
          setcolor(@dis^[i].colore);
          real1:=xg(dis^[i].x1);
          real2:=yg(dis^[i].y1);
          movabs(@real1,@real2);
          real1:=xg(dis^[i].x2);
          real2:=yg(dis^[i].y2);
          lnabs(@real1,@real2)
        end;
    'T':begin
          setlnstyle(@dis^[i].tlinea);
          setcolor(@dis^[i].colore);
          real1:=dis^[i].x1;
          real2:=dis^[i].y1;
          setstclr(@dis^[i].colore,@dis^[i].colore);
          {disetic(round(dis^[i].x2),2,dati^[Dis^[i].tronco].term,real1,real2,dis^[i].y2);}
        end;
    'E':begin
          setlnstyle(@dis^[i].tlinea);
          setcolor(@dis^[i].colore);
          setstclr(@dis^[i].colore,@dis^[i].colore);
          real1:=dis^[i].x1;
          real2:=dis^[i].y1;
          disetic(round(dis^[i].x2),1,dis^[dis^[i].tronco].tronco,real1,real2,dis^[i].y2);
        end;

    end


{DisNumeri(15);}

deltcur;


 lclose;
 clr;
 setWorld(@minxw,@minyw,@maxxw,@maxyw);
 int1:=317 ;
 inqerr(@int1,@int2);
 str(int2,st1);
 richiesta(st1);
 delay(500);
 richiesta('');
 st1[1]:=' ';
 st1:='';
 st1:=readcom(W_M(5),CH1,0);
 { st1:=readcom('Volete salvare le modifiche','S',0);}
 if upcase(st1[1])=CH1 then Savedis(DataDrive+NomeProg);
 halt;
end;

{*************************** STAMPA ********************************}

Procedure Stampa;

const A:array[1..17] of integer=(-1,-1,1,0,0,0,0,-1,0,0,-1,-1,3,-1,-1,-1,0);
var st:string;
    ft:text;
    i:integer;
    m1:integer;
    p,p2:integer;
    p1:pointer;
    p3:pointer;
    d1:string;
   a1:array[1..32]of integer;


 begin
 int1:=1;


{ p:=0;
  getmem(p1,28*1024);
  getmem(p3,4*1024);
  p:=seg(p3^);
  p2:=ofs(p3^);
  for i:=1 to 32 do a1[i]:=0;

  a1[1]:=1792;a1[7]:=p2;a1[8]:=p;

  d1:='c:\discan\driver\videvint.dev';
  setdev(@d1);

  inqerr(@int1,@int2);
  if int1<>0 then writeln(lst,int1,'   ',int2);

  int1:=700;int2:=600;
  setdrange(@int1,@int2);

  inqerr(@int1,@int2);

  int1:=1;
  setcrange(@int1);
  inqerr(@int1,@int2);

  p:=seg(p1^);
  setseg(@p);
  setmattr(@a1);
  inqerr(@int1,@int2);

  m1:=0;
  initgraphics(@m1);
  setworld(@minxw,@minyw,@maxxw,@maxyw);
  inqerr(@int1,@int2);}

  setfont(@fonti);
  st:=vrec.stampante;
  setprn(@st);
  setpattr(@A);
  setclip(@minxw,@minyw,@maxxw,@maxyw);
  setcolor(@c1);
  clr;
  for i:=1 to Ultriga do
  if dis^[i].entita<>'' then
  begin
    case dis^[i].entita[1] of
    'L':begin
          setlnstyle(@dis^[i].tlinea);
          setLcolor(i);
          real1:=xg(dis^[i].x1,dis^[i].y1);
          real2:=yg(dis^[i].y1,dis^[i].z1);
          movabs(@real1,@real2);
          real1:=xg(dis^[i].x2,dis^[i].y2);
          real2:=yg(dis^[i].y2,dis^[i].z2);
          lnabs(@real1,@real2)
        end;
    'T':begin
          {setlnstyle(@dis^[i].tlinea);
          setcolor(@dis^[i].colore);
          real1:=dis^[i].x1;
          real2:=dis^[i].y1;
          setstclr(@dis^[i].colore,@dis^[i].colore);
          disetic(round(dis^[i].x2),2,dati^[Dis^[i].tronco].term,real1,real2,dis^[i].y2);}
        end;
    'E':begin
          {setlnstyle(@dis^[i].tlinea);
          setcolor(@dis^[i].colore);
          real1:=dis^[i].x1;
          real2:=dis^[i].y1;
          setstclr(@dis^[i].colore,@dis^[i].colore);
          disetic(round(dis^[i].x2),1,dis^[dis^[i].tronco].tronco,real1,real2,dis^[i].y2);}
        end;

    end
  end;


DisNumeri(15);

deltcur;

gprint;
int1:=302;
int2:=0;

inqerr(@int1,@int2);
if int2 <> 0 then
begin
  {Writeln(lst,'Stampante  ',int2);}
  str(int2,st1);
  richiesta('');
  richiesta(st1);
  repeat until keypressed;
end;
  setdev(@device);
  initgraphics(@mode);
  setworld(@minxw,@minyw,@maxxw,@maxyw);
end;


*)

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
  UsaMaskera(seg(conf),OfS(conf),'Modican.prv',
                 campo,Chiave,100,100,initmask,not(initmask),false,true);
  initmask:=false;

until (chiave=27);

if Conf.RSnap<0.01 then conf.RSnap:=0.01;

ridis;
Scelta:=0;
end;


{***************************    uscita    ********************************}
function uscita:boolean;

begin
st1:='';
sT1:=ReadCom(W_M(6),CH1,0);
{sT1:=ReadCom('Volete registrare le modifiche ?[s/n/Annulla]','S',0);}

case upcase(st1[1]) of
{S}  CH1:begin
        Savedis(DataDrive+NomeProg);
        dispose(dis);
        dispose(dati);
        closegraphics;
        uscita:=true;
        end;
{N}  CH2:begin

        dispose(dis);
        dispose(dati);
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

  {Errori('Tprcart','tpccart','Tprmcart');}


  ctrlkey:=1;

  {ControlloChiave(CtrlKey,18,500);}


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


  LoadNome;
  inizializza;


  loaddis(DataDrive+Nomeprog);
  nrighe:=newriga;
  ntronchi:=newtr;
  {ngterm:=newter;}
  Sfl:=SetFlag;
  Save_im:=true;
 { ridis;}
   ridis; {davide ins.}
  {Deb(0);}
End;

Procedure Esegui(Var Scelta:Integer);
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
        repeat
        QuotaPrec:=RisultCalc.Quota;
        str(RisultCalc.Quota*(Conf.AltNum/40000):6:2,st1);
        st1:=readcom(W_M(7),st1,0);
{        st1:=readcom('Nuova quota di lavoro [m]',st1,0);}
        st1:=Setleft(st1);
        val(st1,RisultCalc.quota,int1);
        until int1=0;
        RisultCalc.quota:=RisultCalc.quota/(Conf.AltNum/40000);
        if not((setflag)or(Vuoto)) then
          begin
          write(chr(7));
          richiesta(W_M(8));
          {richiesta('Nessun tronco alla quota selezionata');}
          RisultCalc.Quota:=quotaPrec;
          sfl:=setflag;
          scelta:=0;
          end
        else
        ridis;
      end;

    3:zoomg(0);

    4:if (pieniT)or(PieniD) then
      begin
      Richiesta('');
      Write(chr(7));
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
      if RisultCalc.DisDimens then
      Ms:=W_M(10)  {'Dimens-off'}
      else ms:=W_M(11); {'Dimens-on'}
      If RisultCalc.DisUnif then ms:=ms+W_M(12) { Unif-off }
      else ms:=ms+W_M(13); { Unif-on }
      If RisultCalc.Nodi then ms:=ms+W_M(14) { 'Nodi-off'}
      else ms:=ms+W_M(15); {'Nodi-on';}
        repeat
        St1:=Readcom(ms,CH15,33);  { D }
        st1[1]:=upcase(st1[1]);
        until (St1='')or(st1=CH15)or(st1=CH16)or(st1=CH37);   { D,U,N }

      if st1<>'' then

        case st1[1] of
{ D }        CH15:RisultCalc.DisDimens:=not(RisultCalc.DisDimens);
{ U }        CH16:RisultCalc.DisUnif:=not(RisultCalc.DisUnif);
{ N }        CH37:RisultCalc.Nodi:=not(RisultCalc.Nodi);
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
{ P }      CH12:begin
{ U }            st1:=readcom(W_M(17),CH16,0);
            {'Dimensionato/Unifilare','U',0);}
            case upcase(st1[1]) of
{D}            CH15: begin
                   dim :=1;
                   fds:=readcom(W_M(18),'1',0);
                   {'Introdurre il fattore di scala','1',0);}
                   val(fds,sp,i);
                   if sp <=0 then
                   begin
                     write(chr(7));
                     richiesta(W_M(19));
                     {'Valore non corretto');}
                     {delay(500);}
                   end;
                  end;
{U}            CH16: dim :=0;
            end;
            richiesta(W_M(20));
            plotter(1,dim,sp,datadrive+nomeprog+'.dim');
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
{S}      CH13:begin
{U}            st1:=readcom(W_M(17),CH16,0);
            {'Dimensionato/Unifilare','U',0);}
            case upcase(st1[1]) of
{D}            CH15: begin
                   dim :=1;
                   repeat
                   fds:=readcom(W_M(18),'1',0);
                   {'Introdurre il fattore di scala','1',0);}
                   val(fds,sp,i);
                   if sp <=0 then
                   begin
                     write(chr(7));
                     richiesta(W_M(19));
                     {'Valore non corretto');}
                     {delay(500);}
                   end;
                   until sp>0
                  end;
{U}            CH16: dim :=0;
            end;
            richiesta(W_M(20));
            plotter(0,dim,sp,datadrive+nomeprog+'.dim');
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
         SAVEDIS(DataDrive+NomeProg);
         scelta:=0
         end;

      15:begin
         st1:='';
{S}         sT1:=ReadCom(W_M(6),CH1,0);
         { 'Volete registrare le modifiche ?[s/n/Annulla]','S',0); }

         case upcase(st1[1]) of

{S}         CH1:begin
             Savedis(DataDrive+NomeProg);
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
