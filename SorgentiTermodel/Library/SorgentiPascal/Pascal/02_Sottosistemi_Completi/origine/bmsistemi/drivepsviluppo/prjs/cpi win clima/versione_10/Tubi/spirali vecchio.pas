//versione 1.16

unit spirali;
interface
uses libreriagenerale,sysutils,angoli,gestdim,varcarichi,definiz,{grafica2d,}impterm,setta_config_user,progress3d;
Procedure Disegnapannelli(nomerete:string);


var  debpann:boolean=false;
     //debpann:boolean=true;
       debcirc:integer=1003;
var   fdebpann:textfile;

implementation
uses ritornodxf;
//scrittura file per il 3D
// promemoria x diego incluso anche in disedificio
Type Ttubo3d=record
             xx1p,yy1p,zz1p,xx2p,yy2p,zz2p:real;
             pianolN:string[35];
             end;
var  FTubo3d:file of TTubo3d;
     Buftubo3d:TTubo3d;
//scrittura file 3D

procedure initdebpann;
begin
if debpann then
  begin
  assign(fdebpann,i_sl(percorsodrive)+'\pannelli.log');
  rewrite(fdebpann);
  end;
end;

procedure closedebpann;
begin
if debpann then
//close(fdebpann);
end;

procedure IlMioSort(var List : array of Real; var List2 : array of Integer;
    min, max : integer);
var
    i, j, best_j: integer;
    best_value,comodo   : real;
begin
    for i := min to max - 1 do
    begin
        best_value := List[i];
        best_j := i;
        for j := i + 1 to max do
        begin
            if (List[j] < best_value) Then
            begin
                best_value := List[j];
                best_j := j;
            end;
        end;    // for j := i + 1 to max do
        List[best_j] := List[i];
        List[i] := best_value;

        comodo:=  List2[best_j];     //  1.10   ordina i
        List2[best_j] := List2[i];   //  1.10    nodi
        List2[i] := trunc(comodo);  // di conseguenza ordina i nodi

    end;
end;



procedure Wdebpann(mess:string;ind:integer;duep:boolean;dx1,dy1,dx2,dy2:real);
begin
if  debpann then
  begin
  write(fdebpann,mess);
  if ind>=0 then  write(fdebpann,' ind:'+inttostr(ind));
  write(fdebpann,' x1:'+float_to_str(dx1,2)+' y1:'+float_to_str(dy1,2));
  if duep then write(fdebpann,' x2:'+float_to_str(dx2,2)+' y2:'+float_to_str(dy2,2));
  writeln(fdebpann,'');
  end;
end;

Procedure Centrotesto(var xcc,ycc:real;testo:string);
const Htesto=0.15;
begin
xcc:=xcc-(length(testo)*htesto/2)/2;
ycc:=ycc-htesto/2;
end;


Procedure Lineadeb(piano:string;xa,ya,xb,yb:real;ind:integer;colore:string);
Var dir,dirz,xcc,ycc:real;
begin
if debpann then
  begin
  calc_d(xa,ya,0,xb,yb,0,dir,dirz);
  cerchio_Dim(piano,xa,ya,0.02,'ESECUTIVO_RETE',colore,'1');
  cerchio_Dim(piano,xb,yb,0.02,'ESECUTIVO_RETE',colore,'1');
  linea_Dim(piano,xa,ya,xb,yb,'ESECUTIVO_RETE',colore,'1');
  xcc:=0;
  ycc:=0;
  Centrotesto(xcc,ycc,inttostr(ind));
  angoli.ModiCord1(xcc,ycc,0,0,dir,1);
  if ind<>-1 then Testo_Dim(piano,inttostr(ind),(xa+xb)/2+xcc,(ya+yb)/2+ycc,dir,'ESECUTIVO_RETE',colore);
  end;
end;


Procedure Crocedeb(Piano:string;xx,yy:real);
begin
if debpann then
  begin
  linea_Dim(piano,xx-0.04,yy-0.04,xx+0.04,yy+0.04,'ESECUTIVO_RETE','1','1');
  linea_Dim(piano,xx-0.04,yy+0.04,xx+0.04,yy-0.04,'ESECUTIVO_RETE','1','1');
  end;
end;

Function wdir(dd:real):string;
var tt:real;
begin
tt:=round(frac(dd/(2*pi))*2*pi/(PI/2));
//if dd>=0 then
if tt=0 then result:='0'
else
if tt=2 then result:='PI'
else
if tt=-2 then result:='-PI'
else
result:=float_to_str(tt,0)+'/2*PI';
//else result:='-'+float_to_str(round(frac(dd/2*pi)*2*pi/PI/2),0)+'/2*PI' ;
//result:=float_to_str(dd,2)+'('+result+')';
end;

function CalcAng1(xp1,yp1,xp2,yp2,xp3,yp3,xp4,yp4:real):real;
Var Dir,DirZ:real;var orientam:integer;Var Vert:Boolean;
begin
if Dis^[ultriga+1]=nil then new(Dis^[ultriga+1]);
with Dis^[ultriga+1]^ do
  begin
  x1:=xp1;
  x2:=xp2;
  y1:=yp1;
  y2:=yp2;
  z1:=0;
  z2:=0;
  end;
if Dis^[ultriga+2]=nil then new(Dis^[ultriga+2]);
with Dis^[ultriga+2]^ do
  begin
  x1:=xp3;
  x2:=xp4;
  y1:=yp3;
  y2:=yp4;
  z1:=0;
  z2:=0;
  end;
calcang(ultriga+1,ultriga+2,dir,dirz,orientam,vert,0);
result:=dir;
end;

Procedure Disegnapannello(var ripeti,ultriga1:integer; piano:string;indln:integer;passo:real);
const maXln=10000;

Type Tvet_LN=array[1..maXln] of
     record
     ln:frontht;
     end;
var Vet_ln:TVet_ln;
    NVet_ln,ia1,i,count,countiter,res,res_dep,res_zz,res_zz_dep,res_zz_dep_per2,min_res_1,giro,escludi_dep,k_prima,zig_zag,tipo,circuito,Ki,nodo_scelta,chiudi_sempre:integer;
    salta,pre_finepercorso,finepercorso,lnc:boolean;
    salta_dep,margine_di_fine,vicolocieco,minima_distanza_tratto,margine_int,dirini,dir_parallela,dir_prima_zigzag,dir_start,doppiop,xint,yint,dirz,xint_dep,yint_dep,dep_int,alfa,corridoio:real;
    xini,yini,xfine,yfine,sposta_x,sposta_y,dir,dir_ultimo,dir_zz,mindist_prima,xini_prima,yini_prima,x0_,x1_,y0_,y1_:real;
    xint_zz,yint_zz,xini_zz,yini_zz,per2,x_min,x_max,y_min,y_max:real;
    rx_sx:integer;
    dist_diagonale,count_per_margine:real;





Procedure DisegnaChiusura;
Var Lungr,dirr,ang1,ang2,xp1,yp1,xp2,yp2,xinterm,yinterm:real;
begin
with dis^[indln]^ do
  begin
  lungr:=sqrt(sqr(x2-x1)+sqr(y2-y1));
  calcdirez(indln,dirr,dirz);

 if ((dirr > pi/4) and (dirr < pi/2 + pi/4)) or ((dirr > pi + pi/4) and (dirr < pi + pi/2 + pi/4))
 then Arco_dim(Piano,x2,y2,doppiop/2,dirr+pi,dirr,'ESECUTIVO_RETE','5','')
 else Arco_dim(Piano,x2,y2,doppiop/2,dirr,dirr+pi,'ESECUTIVO_RETE','5','');



  xp1:=-doppiop/2;
  yp1:=doppiop;
  angoli.ModiCord1(xp1,yp1,x1,y1,dirr,1);
  xp2:=-doppiop/2;
  yp2:=lungr;
  angoli.ModiCord1(xp2,yp2,x1,y1,dirr,1);
  linea_Dim(piano,xp1,yp1,xp2,yp2,'ESECUTIVO_RETE','5','');


  xp1:=0;
  yp1:=doppiop;
  angoli.ModiCord1(xp1,yp1,x1,y1,dirr,1);
  xp2:=doppiop/2;
  yp2:=lungr;
  angoli.ModiCord1(xp2,yp2,x1,y1,dirr,1);
  xinterm:=(xp1+xp2)/2;
  yinterm:=(yp1+yp2)/2;
  linea_Dim(piano,xp1,yp1,xinterm,yinterm,'ESECUTIVO_RETE','1','');
  linea_Dim(piano,xinterm,yinterm,xp2,yp2,'ESECUTIVO_RETE','5','');

  xp2:=0;
  yp2:=lungr-0.02;
  angoli.ModiCord1(xp2,yp2,x1,y1,dirr,1);
  Centrotesto(xp2,yp2,inttostr(ia1 mod 1000));
  Testo_Dim(piano,inttostr(ia1 mod 1000),xp2,yp2,pi/2,'ESECUTIVO_RETE','3');


  //accorciamento tubo originale
  y2:=doppiop;
  x2:=0;
  angoli.ModiCord1(x2,y2,x1,y1,dirr,1);
  end;
end;

/////////////////////////////////////////
function Senso_di_rotazione:boolean;  //Prima di tutto stabilisce il senso di rotazione
Var dir_test:real;
    trov:integer;
    prx,pry,dist,mindist:real;
    k:integer;

function dist_min:real;

begin
prx:=0;pry:=100; //cerco le intersezioni in una direzione
angoli.modicord1(prx,pry,xini,yini,dir,1);

k:=0;
 repeat //  /Trovata la distanza tra tutte le intersezioni o depressioni.
  inc(k);
  with Vet_ln[k] do begin
   interspann(xint,yint,res,xini,prx,ln.x0,ln.x1,yini,pry,ln.y0,ln.y1,0.003,0);
   end;
  if res = 1 then begin
  //lineadeb(piano,xini,yini,xint,yint,-1,'6');
  dist:=sqrt(sqr(xint-xini)+sqr(yint-yini));
  if dist<2*doppiop then trov:=1;
  end;
until (k=NVet_ln);
end;

begin
rx_sx:=1;   //1 senso orario di default -1 senso antiorario di default
trov:=0;
dir_test:=dir ;
dir:=dir_test + pi/2;

dist_min;
if trov=1 then rx_sx:=-1;
dir:=dir_test - pi/2;
dist_min;
if trov=0 then  dir:=dir_test -  rx_sx* pi/2
else  dir:=dir_test;
end;                 //Fine funzione senso di rotazione
//////////////////////


function lineacorta:boolean;

const toll=1.01;

Var prx,pry,dir_z,dir3,D_eff:real;
    k,nmod,ordina,ordin,K_1,prossimo_nodo:integer;
    trov,acuto,vicolo:boolean;
    dist:Array[1..2000] of real;
    mindist1:Array[1..2000] of real;
    K_min:Array[1..2000] of integer;
    res_k:Array[1..2000] of integer;



Function calcola_diagonale():real;     //Calcola una diagonale per ipotizzare quanti tratti ci saranno
var piu_pi: integer;
begin
dist_diagonale:=0;
 for piu_pi:=0 to 1 do begin
  dir_zz:=dir+rx_sx*pi/4+pi*piu_pi;
  xini_zz:=0;
  yini_zz:=100;
  angoli.modicord1(xini_zz,yini_zz,xini,yini,dir_zz,1);

   repeat
  inc(k);
   with Vet_ln[k] do  begin
   interspann(xint_zz,yint_zz,res_zz,xini,xini_zz,ln.x0,ln.x1,yini,yini_zz,ln.y0,ln.y1,margine_int,doppiop);
   end;

  if (res_zz<>0)  then
  lineadeb(piano,xini,yini,xint_zz,yint_zz,-1,'6');
  until (k=NVet_ln);
  K:=0;
  if dist_diagonale<sqrt(sqr(xint_zz-xini)+sqr(yint_zz-yini)) then dist_diagonale:=sqrt(sqr(xint_zz-xini)+sqr(yint_zz-yini));
 end;
 if (dist_diagonale > 4*doppiop)    then count_per_margine:=  countiter + 1;// modifica 1.11
end;





Function Dist_eff(dd,rr,rr_dep:real;kk:integer;d_p:real):real;
var dln,dln1:real;
begin

result:=10E6;

if giro <> count then begin
         if (escludi_dep=count) then begin
          if dd>doppioP*2.8 then  escludi_dep := -1;
         end;

        if (rr=1)  then begin  // Intersezione   tipo 1

          if (pre_finepercorso=true) and (dd-doppiop<=margine_di_fine) then// (abs(d_p - dir)=pi/2) then //Evita un ritorno di 180 gradi troppo stretto
           finepercorso:=true

          else begin
         //verifica possibile zig zag
         result:=dd-doppiop;
         dirini:=d_p;//+(rx_sx-1)*(-pi/2); //dir+rx_sx*pi/2;
         //dirini:=dir+rx_sx*d_p;
         giro:=-1;
         tipo:=1;
         pre_finepercorso:=true;
         end;
        end;

        if (rr=2) and (rr_dep>0)  and (escludi_dep<>count) then  begin  //Zig Zag tipo 2
         result:=dd-doppiop;
         dirini:=dir+rx_sx*pi/2;
        // dir_prima_zigzag:=dir;
         giro:=count+1;
         tipo:=2;
         if escludi_dep <> -2 then Escludi_dep:=count+2;

         if (pre_finepercorso=true) and (dd-doppiop<=margine_di_fine) then //Evita un ritorno di 180 gradi troppo stretto
           finepercorso:=true  else  pre_finepercorso:=false;

        end;

        if (rr=2) and (rr_dep=0)   and (escludi_dep<>count) then  begin  //Depressione concorde con il senso di rotazione tipo 3
         result:=dd+doppiop;
         dirini:=dir-rx_sx*pi/2;
         if escludi_dep <> -2 then Escludi_dep:=count+1;
         giro:=-1;
         tipo:=3;

         //Prova a vedere se non entra in un vicolo cieco
         if (nodo_scelta <>countiter) and (dist[2]-result <= vicolocieco) and  (res_k[K_min[2]]=1) then begin
                result:=dist[2]-doppiop;
                //dirini:=dir+rx_sx*pi/2;
                dirini:=dir;
                 giro:=-1;
                 tipo:=3;
                 if nodo_scelta=0 then nodo_scelta:=countiter;
         end; ///// fine controllo vicolo cieco
        pre_finepercorso:=false;
        end;

        if (rr=-2) and (rr_dep=0)   and (escludi_dep<>count) then  begin  //Depressione non concorde col senso di rotazione (vicolo cieco) tipo 5
         result:=dd-doppiop;
         dirini:=dir+rx_sx*pi/2;
         giro:=-1;
         tipo:=5;
         pre_finepercorso:=false;
        end;

        if (rr=2) and (rr_dep<=2) and (escludi_dep=count) then  begin
         escludi_dep:=-1;
         result:=10E6;
        end;
end;

if giro = count then begin
         result:=doppiop*per2;
         dirini:=dir-rx_sx*pi/2;//dir_prima_zigzag;//d_p+pi;//dir-rx_sx*pi/2;
         giro:=-1;
         zig_zag:=count;
         tipo:=4;
         per2:=1;

 //Controlla se non entra in un vicolo cieco
         if (dist[2]-result  <= vicolocieco)  then begin
              //  result:=dist[2]-doppiop;
              //  if result<minima_distanza_tratto then result :=  doppiop;
              // dirini:=dir+rx_sx*pi/2;
                result :=  doppiop;
                dirini:=dirini+rx_sx*pi/2;;//d_p;//dirini+rx_sx*pi/2;
                giro:=-1;
                zig_zag:=count;
                tipo:=4;
         end; ///// fine controllo vicolo cieco
end;

end;






begin
Wdebpann('  Provo per direzione :'+Wdir(dir),-1,false,xini,yini,0,0);
prx:=0;pry:=100; //cerco le intersezioni in una direzione
angoli.modicord1(prx,pry,xini,yini,dir,1);
trov:=false;
k:=0;
K_1:=0;
mindist1[1]:=10E6;
trov:=false;
acuto:=true;
min_res_1:=0;
dist[199]:=10E6;

  //if (int(dir_start*10)=int(dirini*10)) and (count_per_margine<13)  then   calcola_diagonale();
  if (countiter>=count_per_margine) and (salta=false) and (rx_sx =-1) then calcola_diagonale();

  repeat //  /Trovata la distanza tra tutte le intersezioni o depressioni.
  inc(k);
  dist[k]:=10E6;

  with Vet_ln[k] do begin
   interspann(xint,yint,res,xini,prx,ln.x0,ln.x1,yini,pry,ln.y0,ln.y1,margine_int,doppioP*alfa);
   interspann(xint_dep,yint_dep,res_dep,xini,prx,ln.x0,ln.x1,yini,pry,ln.y0,ln.y1,margine_int,doppioP/1.5);
  end;

if (K_prima<>k)  then begin    // esclude vicoli ciechi trovati nel precendente count

 if (res<>0) and (countiter=16) then//  and  (count=1)  and (k=34)  then
   lineadeb(piano,xini,yini,xint,yint,-1,'6');

  K_min[k]:=0;
  if res<>0 then  begin
     dist[k]:=sqrt(sqr(xint-xini)+sqr(yint-yini));
     K_min[k]:=k;
     res_k[k]:=res;
     if (res=1) and (dist[k]<dist[199])  then  begin   //trova la prima intersezione vera
          min_res_1:=k; dist[199]:=dist[k]; end;    //Memorizza la distanza utile per decidere se entrare o meno in un corridoio
  end;

end;
until (k=NVet_ln); //Trovata la distanza tra tutte le intersezioni o depressioni.

IlMioSort (dist,K_min,0,NVet_ln-1);   //Ordina il vettore delle distanze in modo crescente. Il vettore nodi viene ordinato anchesso i base alle rispettive distanze

  ordina:=0;
  prossimo_nodo:=1;
 while (ordina<=5) do begin
 //Con le coordinate K_mi del punto più viciono stabilisce se è una depressione un zig zag o una intersezione. usa la funzione dist_eff()
  inc(ordina);

  /// per dopo
  dir_zz:=dir+rx_sx*pi/2;
  xini_zz:=0;
  yini_zz:=doppioP;
  res_dep:=0;
  angoli.modicord1(xini_zz,yini_zz,xini,yini,dir_zz,1);

   if (k_min[1]=0) then begin   //Controllo per evitare crash
    k_min[1]:=1;
    finepercorso:= true;
   end;

   with Vet_ln[k_min[1]] do  begin
   interspann(xint_zz,yint_zz,res_zz,xini_zz,prx,ln.x0,ln.x1,yini_zz,pry,ln.y0,ln.y1,margine_int,doppiop);
   interspann(xint_zz,yint_zz,res_zz_dep,xini_zz,prx,ln.x0,ln.x1,yini_zz,pry,ln.y0,ln.y1,margine_int,doppioP/1.5);  //prima era 1.5
   interspann(xint_zz,yint_zz,res_zz_dep_per2,xini_zz,prx,ln.x0,ln.x1,yini_zz,pry,ln.y0,ln.y1,margine_int,doppioP*2);  //prima era 1.5

   end;
   /// per dopo

  with Vet_ln[K_min[1]] do begin
   interspann(xint,yint,res,xini,prx,ln.x0,ln.x1,yini,pry,ln.y0,ln.y1,margine_int,doppioP*alfa);
   interspann(xint_dep,yint_dep,res_dep,xini,prx,ln.x0,ln.x1,yini,pry,ln.y0,ln.y1,margine_int,doppioP/1.8);  //prima era 1.5
  end;


     if (ordina>1) and (res_zz > 0) and (res=0)  then begin   //Trovato vicolo cieco dopo aver scartato la prima depressione... torna sui suoi passi
       dist[1]:=dist[200];
       K_min[1]:=K_min[200];
       ordina:=9;
       res_zz:=0; //Se torniamo alla depressione precedente sicuramente non sarà un vicolo cieco

          with Vet_ln[K_min[1]] do begin
          interspann(xint,yint,res,xini,prx,ln.x0,ln.x1,yini,pry,ln.y0,ln.y1,margine_int,doppioP*alfa);
          interspann(xint_dep,yint_dep,res_dep,xini,prx,ln.x0,ln.x1,yini,pry,ln.y0,ln.y1,margine_int,doppioP/1.5);
          end;
     end; ///////////////////  Trovato vicolo cieco dopo aver scartato la prima depressione... torna sui suoi passi


  if (ordina<3) and (res=2) and (res_dep=0) and (res_zz = 0)   and (dist[ordina+1] - dist[ordina]  <= salta_dep) and (dist[ordina] >doppioP) and (dist[ordina+1] >doppioP) then begin //and (dist[ordina+1] - dist[ordina]  > doppiop/1.5 ) then begin
       //evita due depressioni troppo vicine
       dist[200]:= dist[1];
       K_min[200]:=K_min[1];
       dist[1]:= dist[ordina+1];
       K_min[1]:=K_min[ordina+1];
  end

   else ordina:=9;

   end;



  //ricerca zic zac o depressione da vicolo cieco............

       if  (res_zz > 0)  and (res=2)  then begin    // res=2 trovato vicolo da depressione 'antigiro'
              // if (dist[199]-dist[1]< 20*doppioP)   then begin     // era 20 Decide se entrare in un corridoio o meno... Va assolutamente ancora implementata con un medoto decisionale vero!!!!
              if (nodo_scelta<>countiter) or (dist[199]-dist[1]< 5*doppioP) then begin
                 if nodo_scelta=0 then nodo_scelta:=countiter;
                 res:=-2;
                 res_dep:=0;
               end;
                               //lineadeb(piano,xini_zz,yini_zz,xint_zz,yint_zz,-1,'6');
        end;

        if  (res_zz = 2)  and (res=1)  and (res_zz_dep_per2<>2) then begin // and (count<>11) then begin    //trovato zig zag
                 res:=2;
                 res_dep:=2;
                 if res_zz_dep=2 then per2:=2;        //zig zag ampio
                //lineadeb(piano,xini_zz,yini_zz,xint_zz,yint_zz,-1,'6');

        end;
       // dir:=dir-rx_sx*pi/2;
     //.................................

 ////////////////////////////////////////Parallelismo con le altre linee ver 1.14//////
   with Vet_ln[K_min[1]] do begin
   Calc_D(ln.x0,ln.y0,0,ln.x1,ln.y1,0,dir_parallela,dirz);  //Calcola direzione lato da seguire
   end;

   if (rx_sx=1) then begin     // Corregge l'orientamente
     dir_parallela:=dir_parallela-(int(dir_parallela/(2*pi))*2*pi);
     dir:=dir-(int(dir/(2*pi))*2*pi);
     if dir<=0 then dir:=dir+2*pi;
     if  (dir_parallela-dir<0) then dir:=dir-2*pi;
    if  (dir_parallela-dir>pi) then dir_parallela:=pi+dir_parallela;
   end;

   if (rx_sx=-1) then begin     // Corregge l'orientamente
     dir_parallela:=dir_parallela-(int(dir_parallela/(2*pi))*2*pi);
     dir:=dir-(int(dir/(2*pi))*2*pi);
     if dir<=0 then dir:=dir+2*pi;
     if  (dir_parallela-dir<0) then dir:=dir-2*pi;
     if  (dir_parallela-dir<pi) then dir_parallela:=pi+dir_parallela;
   end;
///////////////////////////////// ver1.14 stanze con pareti non perpendicolari   /////

   mindist1[1]:=dist_eff(dist[1],res,res_dep,k_min[1],dir_parallela);     //calcola vera distanza e ricerca tipi di intersezione depressione o zigzag


salta:=false;
if (mindist1[1]=10E6) then begin
 count:=count-1;
 K_prima:=K_min[1];
 salta:=true;
end;  //Il nodo trovato non va bene lo ricalcola escluendo quello appena trovato


 if (mindist1[1]<minima_distanza_tratto) then begin// and (zig_zag <> count) then begin// and (int(dir*100)=int((dir_ultimo+rx_sx*pi/2)*100)) then begin
    dirini:=dir + rx_sx*pi/2;
    salta:=true;
 end;


if  (int(dir*100)=int((dir_ultimo+rx_sx*pi)*100)) and (count>0) then begin
 finepercorso:=true;  //Se cerca di tronare indietro finepercorso
  end;





 //Procede al disegno del tratto
if (not (salta)  or (zig_zag = count))  and not(finepercorso)   then begin

   if (int(dir_ultimo*100) <> int(dir*100)) or (count = 0) then begin
        prx:=0;
        pry:=mindist1[1];
        mindist_prima:=mindist1[1];
        xini_prima:= xini;
        yini_prima:= yini;
        angoli.modicord1(prx,pry,xini,yini,dir,1);
        inc(NVet_ln);
   end
  else begin       //Se la direzione è uguale a quella del tratto precedente disegna un unico tratto.
        prx:=0;
        pry:=mindist1[1]+mindist_prima;
        mindist_prima:=mindist1[1]+mindist_prima;
        xini:=xini_prima;
        yini:=yini_prima;
        angoli.modicord1(prx,pry,xini,yini,dir,1);
  end;

  lineadeb(piano,xini,yini,prx,pry,NVet_ln,'3'); //tratto spirale debug
  dir_ultimo:=dir;


   with Vet_ln[NVet_ln] do
    begin
    Wdebpann('  Aggiunta linea contorno N:'+inttostr(count),NVet_ln,true,xini,yini,prx,pry);
    ln.x0:=xini;
    ln.y0:=yini;
    ln.x1:=prx;
    ln.y1:=pry;
   end;







  if not debpann then//not debpann then
    begin
    inc(ultriga);
    if dis^[ultriga]=nil then new(dis^[ultriga]);
    dis^[ultriga]^:=dis^[indln]^;    //ver 1.06
    //dis^[ultriga]^.Piano:= piano;       //1.05
    dis^[indln]^.nlinea:=ultriga;
    with dis^[ultriga]^ do
      begin
      x1:=xini;
      y1:=yini;
      x2:=prx;
      y2:=pry;
      Nlinea:=0;
      tronco:=dis^[indln]^.tronco;
      Wdebpann('  Aggiunto tubo ',ultriga,true,dis^[ultriga]^.x1,dis^[ultriga]^.y1,dis^[ultriga]^.x2,dis^[ultriga]^.y2);

      //scrittura file per il 3D
      with Buftubo3d do
        begin
        xx1p:=x1;
        yy1p:=y1;
        zz1P:=0;;
        xx2p:=x2;
        yy2p:=y2;
        zz2p:=0;
        PianolN:=Piano;
        end;
      write(ftubo3d,buftubo3d);
      //scrittura file 3D

      end;
    end;

  xini:=prx;
  yini:=pry;
  indln:=ultriga;
  K_prima:=-1;

if zig_zag=count then zig_zag:=-1;
end;

//In caso di rotazione in senso antiorario deve avere + spazio per fare la chiusura (il filo blu è interno!)
if (finepercorso) and (rx_sx=-1) then begin

with Vet_ln[NVet_ln] do begin
  pry:=sqrt(sqr(ln.x1-ln.x0)+sqr(ln.y1-ln.y0))-doppiop;
  prx:=-doppiop/3;
  xini:= ln.x0;
  yini:=  ln.y0;

  angoli.modicord1(prx,pry,xini,yini,dir_ultimo,1);
  lineadeb(piano,xini,yini,prx,pry,NVet_ln,'3');

    ln.x0:=xini;
    ln.y0:=yini;
    ln.x1:=prx;
    ln.y1:=pry;
end;

   if  not debpann then//not debpann then
    begin
    if dis^[ultriga]=nil then new(dis^[ultriga]);
    dis^[ultriga]^:=dis^[indln]^;        //ver 1.06
  //  dis^[ultriga]^.Piano:= piano;       //1.05
    dis^[indln]^.nlinea:=ultriga;
    with dis^[ultriga]^ do
      begin
      x1:=xini;
      y1:=yini;
      x2:=prx;
      y2:=pry;
      Nlinea:=0;
      tronco:=dis^[indln]^.tronco;
      end;
    end;
 end;
 //////////////////////////////////// finepercorso in senso antiorario


end;












begin  //disegnapannello

calcdirez(indln,dir,dirz);
xini:=dis^[indln]^.x2;
yini:=dis^[indln]^.y2;


//Assegnazione variabili
doppiop:=passo*2;
margine_int:=0.03;
minima_distanza_tratto:=doppiop*0.9;
margine_di_fine:=doppiop*0.9;  //1.09;
salta_dep:=doppioP*4;
vicolocieco:=2.8*doppiop;   //ver: 1.08
alfa:=2; // margine intersezione
corridoio:=20*doppiop;
/////////////////////

count:=0;
{ TODO -oDiego -cModifica dividi :  }
//Debug_carica(percorsoDrive + Piano + '.inp',ia1,1);

ia1:=Cercapuntoloc_D(xini,Yini,Piano); //cerca locale dove si trova il terminale
//ia1:=Cercapuntoloc(xini,Yini,Piano); //cerca locale dove si trova il terminale
if ia1<>0 then
  begin

  nodo_scelta:=ripeti;

  //Carica il perimetro del locale
  Nvet_ln:=0;
  { TODO -oDiego -cModifica dividi :  }
 // carica(percorsoDrive + Piano + '.int',ia1,1);
  carica(percorsoDrive + Piano + '.inp',ia1,1);
  Wdebpann('-----------------------------------------------------------------------',-1,false,0,0,0,0);



  with dis^[indln]^ do Wdebpann('Inizio disegno tubo ',indln,true,x1,y1,x2,y2);
  for i:=1 to MaxNumAmb do
  begin
    with TabFtht^[i] do
    if sqrt(sqr(x1-x0)+sqr(y1-y0))> doppiop then
       begin
       inc(Nvet_ln);
       Vet_ln[Nvet_ln].ln:=TabFtht^[i];
       Wdebpann('Perimetro esterno ',Nvet_ln,true,x0,y0,x1,y1);
       lineadeb(piano,x0,y0,x1,y1,Nvet_ln,'2'); // disegna il perimetro esterno

       if x0<x_min then x_min:=x0;   //
       if x1<x_min then x_min:=x1;   //
       if x0>x_max then x_max:=x0;   //FORSE SERVIRA' IN FUTURO
       if x1>x_max then x_max:=x1;   // LO TENGO PER ORA
       if y0<y_min then y_min:=y0;   //
       if y1<y_min then y_min:=y1;   //
       if y0>y_max then y_max:=y0;   //
       if y1>y_max then y_max:=y1;   //

       inters1(xint,yint,res,x0,x1,dis^[indln]^.x1,dis^[indln]^.x2,y0,y1,dis^[indln]^.y1,dis^[indln]^.y2,0.003);
       if res=1 then
        begin
         Wdebpann('trovata intersezione con linea iniziale ',-1,false,xint,yint,x1,y1);
          calcdirez(indln,dir,dirz);
          with dis^[indln]^ do
           begin
           y2:=sqrt(sqr(xint-x1)+sqr(yint-y1))+doppiop;
           x2:=0;
           angoli.ModiCord1(x2,y2,x1,y1,dir,1);
           end;
         end;
       end;
     end;


  chiudi_sempre:=0;
  if nodo_scelta=0 then ultriga1:=ultriga else chiudi_sempre:=1;    // ver 1.12  scelta migliore tipo scacchi
  for i:=1 to  ultriga1 do
  if uppercase(dis^[i]^.Piano)=piano then
  if dis^[i]^.tronco<>0 then
  if dati^[dis^[i]^.tronco]^.term<>0 then //non inserisce i tubi prima del collettore
  if trovaamb(dis^[i]^.x1,dis^[i]^.y1)or trovaamb(dis^[i]^.x2,dis^[i]^.y2)
  or trovaamb((dis^[i]^.x1+dis^[i]^.x2)/2,(dis^[i]^.y1+dis^[i]^.y2)/2) then
  begin

    inc(Nvet_ln);
    with Vet_ln[Nvet_ln].ln do
      begin
      x0:=dis^[i]^.x1;
      x1:=dis^[i]^.x2;
      y0:=dis^[i]^.y1;
      y1:=dis^[i]^.y2;
      if i=indln then
      Wdebpann('Caricamento tubo adduzione',Nvet_ln,true,x0,y0,x1,y1)
      else Wdebpann('Caricamento tubo estraneo',Nvet_ln,true,x0,y0,x1,y1);
      lineadeb(piano,x0,y0,x1,y1,Nvet_ln,'2');

     end;


      /// Inserisce anche il segnmente di ritorno(segmento blu)  1.16 /////////

     if  not trovaamb(dis^[i]^.x1,dis^[i]^.y1) and not trovaamb(dis^[i]^.x2,dis^[i]^.y2)
     then begin
      Calc_D(dis^[i]^.x1,dis^[i]^.y1,0,dis^[i]^.x2,dis^[i]^.y2,0,dirini,dirz);
      dirini:=dirini-pi/2;
      sposta_x:=0;
      sposta_y:=doppiop/2;
      xini:=dis^[i]^.x1;
      yini:=dis^[i]^.y1;
      angoli.modicord1(sposta_x,sposta_y,xini,yini,dirini,1);
      xini:=  sposta_x;
      yini:=  sposta_y;
      xfine:=dis^[i]^.x2;
      yfine:=dis^[i]^.y2;
      sposta_x:=0;
      sposta_y:=doppiop/2;
      angoli.modicord1(sposta_x,sposta_y,xfine,yfine,dirini,1);
      xfine:=  sposta_x;
      yfine:=  sposta_y;
      //lineadeb(piano,xini,yini,xfine,yfine,Nvet_ln,'2');
      //////////////////////// inserisce segmento ritorno 1.16 //////////////

      inc(Nvet_ln);
      with Vet_ln[Nvet_ln].ln do
        begin
        x0:=xini;
        x1:=xfine;
        y0:=yini;
        y1:=yfine;
        lineadeb(piano,x0,y0,x1,y1,Nvet_ln,'2');
      end;

    end;

    end;


  xini:=dis^[indln]^.x2;
  yini:=dis^[indln]^.y2;



 Senso_di_rotazione;    //Direzione Iniziale


  count_per_margine:=4; //Per quando gira a sx
  per2:=1;     //zig zag con doppiop*per2 di separazione
  escludi_dep:=-1;   //gira l'angolo
  finepercorso:=false;
  pre_finepercorso:=false;//Evita 180gradi troppo stretti
  dirini:=dir;
  giro:= -1 ;
  K_prima:=-1;
  zig_zag:=-1;
  dir_start:=dir + rx_sx* 2*pi;



  /////////////////

    dirini:=dir;
  dir:=dirini+rx_sx*pi/2;

  countiter:=0; //modifica Diego

  while (countiter<=250) and not (finepercorso) do// and not (dir_start=dirini)   do
  begin

 if nodo_scelta<=countiter-4 then nodo_scelta:=0;  // ver 1.12  scelta migliore tipo scacchi

 if (rx_sx =-1) and (countiter> count_per_margine) and (count_per_margine <> 4) then
  margine_di_fine:= doppiop*2.2 //Se gira a sx devo evitare 180° finali troppo stretti.
 else   margine_di_fine:=doppiop*0.9;

 if (dir_start=dirini) and (alfa=2) then alfa:=1.8;
   dir:=dirini;
   lineacorta;
   inc(count);
   inc(countiter); //modifica Diego
   end;

  ///////////////////////
  if (nodo_scelta=0) or (chiudi_sempre=1) then begin
  if not (debpann)  then DisegnaChiusura;
  end;
   ripeti:= nodo_scelta;      // ver 1.12  scelta migliore tipo scacchi
   if  chiudi_sempre=1 then ripeti:=0;
  end;
end;

Procedure Disegnapannelli(nomerete:string);
Var a,i,j,k,ripeti,ultriga1,gouge:integer;
    dir,dirz:real;
begin
gouge:=0;
//ultriga:=1;
if not attiva_spirali then exit;  // modifica di diego da lasciare sino a collaudo completato
initdebpann;
//scrittura file per il 3D
//aggiungi il parametro nomerete alla procedura
assign(Ftubo3d,i_sl(percorsodrive)+nomerete+'.PNN');
rewrite(FTubo3d);
//scrittura file 3D


for j:=1 to npiani do
for i:=1 to ngterm  do
if i<>0 then begin
 ultriga1:=0;
 ripeti:=0;


with Gterm^[i]^ do
//if (not debpann)or(numamb=debcirc) then //solo per il debug
if uppercase(Gterm^[i]^.piano)=uppercase(Piani_D^[j].Cod) then
if uppercase(copy(tipoterm,1,4))='PANN' then
  begin
  inc(gouge);
  progress_3d(round(gouge/ngterm*100),'Calcolo pannelli,disegno spirali');

  try
      k:=1;
    while (k<ulttronco)and(dati^[k]^.Term<>i)do inc(k);
    k:=dati^[k]^.ti;
    while dis^[k]^.nlinea<>0 do k:=dis^[k]^.nlinea;
    Disegnapannello(ripeti,ultriga1,uppercase(piano),k,0.1);
    if ripeti>0 then
      begin
      Disegnapannello(ripeti,ultriga1,uppercase(piano),k,0.1); // ver 1.12  scelta migliore tipo scacchi
      end;
    except
  // se vuoi che faccia qulcosa in caso di errore lo puoi mettere qui
    end;
  end;


closedebpann;
end;
//scrittura file per il 3D
Close(FTubo3d);
//scrittura file 3D

end;
end.


