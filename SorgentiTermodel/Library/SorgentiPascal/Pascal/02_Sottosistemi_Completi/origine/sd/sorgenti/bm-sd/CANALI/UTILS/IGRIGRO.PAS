unit Igrigro;
interface

Uses
  definiz,WM,dialogs;

function EsGrafico(visualizza:boolean;nome:string):boolean;

implementation


const
   MaxTemp=30;
   MinTemp=-20;
   MaxPress=3;
   NStrutt=150;
   NMater=950;
   NStrati=11;
const MaxWorldX: real=1000.0;
      MaxWorldY: real=1000.0;

type

   DATI=record
           SPES,TEMP:REAL;
           PV,PS:REAL;
           Nome:String[30];
        end;
   TABELLE=ARRAY[0..20] OF DATI;


var f,f1,fd:text;
    TabGraph:^Tabelle;
    fdis      :file of dis1;
 function Exist(Nome:string):boolean;
 var f:file;
 begin
    exist:=false;
    {$I-} assign(f,Nome);reset(f);{$I+}
    if (ioresult=0) then
    begin
      close(f);
      Exist:=true
    end;
 end;

FUNCTION SETLEFT(ST:STRING):STRING;
BEGIN
  WHILE (COPY(ST,1,1)=' ') AND (ST>'') DO ST:=COPY(ST,2,LENGTH(ST)-1);
  SETLEFT:=ST;
END;     { FUNC. SETLEFT }



FUNCTION SETRIGHT(ST:STRING):STRING;
VAR
  I:INTEGER;
BEGIN
  I:=LENGTH(ST);
  while (I > 1) and (ST[i] = ' ') do i:=i-1;
  if i = 1 then
   begin
     if st[i] = ' ' then i:=0;
   end;

  if i = 0 then SetRight:=''
  else SETRIGHT:=COPY(ST,1,I);

END;     { FUNC. SETRIGHT }

function UpString(St:string):string;
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
    UpString:=St;
 end;




Function FormST(ST:STRING):String;
begin
   result:=upstring((SetLeft(SetRight(St))));
end;

procedure GRAFICO(vis:boolean);
var
   Pa,S:REAL;
   I,j,k,b,ns,ndis:INTEGER;
   CH:CHAR;
   X,X1,Y,Y1,Ys,Ys1,xspes,a:real;
   hdt,hfc,hds,hgb,hgb1,xgb,fs,Somma:real;

   const fx=230;  {distanza tra i due grafici bassi}
         fy=5;
	 fyv=83.33333;
         xsgb=600; {x grafico basso}
         xtsg=550; {x partenza testo grafico basso}
         xdm=450;  {x descrizioni materiali}
         xsm=850;  {x spessori materiali}

procedure initdis;

var i:integer;
    s:string[80];
    p:array[0..80] of char;
begin

  for i:=1 to lungdisegno do
  with disegno^[i] do
  begin
    entita:='';
    colore:=7;
    testo:='';
    x1:=0;
    y1:=0;
    x2:=0;
    y2:=0;
  end;
end;


procedure inc;
begin

  if ndis=lungdisegno then
  begin
    write(fdis,disegno^);
    ndis:=1;
  end
  else ndis:=ndis+1;
end;
procedure caricavarsquare(xq1,yq1,xq2,yq2:real);
begin
  inc;
  disegno^[ndis].entita:='L';
  disegno^[ndis].tlinea:=0;
  disegno^[ndis].colore:=15;
  disegno^[ndis].x1:=xq1;
  disegno^[ndis].y1:=yq1;
  disegno^[ndis].x2:=xq2;
  disegno^[ndis].y2:=yq1;
  inc;
  disegno^[ndis].entita:='L';
  disegno^[ndis].colore:=15;
  disegno^[ndis].tlinea:=0;
  disegno^[ndis].x1:=xq2;
  disegno^[ndis].y1:=yq1;
  disegno^[ndis].x2:=xq2;
  disegno^[ndis].y2:=yq2;
  inc;
  disegno^[ndis].entita:='L';
  disegno^[ndis].tlinea:=0;
  disegno^[ndis].colore:=15;
  disegno^[ndis].x1:=xq2;
  disegno^[ndis].y1:=yq2;
  disegno^[ndis].x2:=xq1;
  disegno^[ndis].y2:=yq2;
  inc;
  disegno^[ndis].entita:='L';
  disegno^[ndis].tlinea:=0;
  disegno^[ndis].colore:=15;
  disegno^[ndis].x1:=xq1;
  disegno^[ndis].y1:=yq2;
  disegno^[ndis].x2:=xq1;
  disegno^[ndis].y2:=yq1;
  inc;
end;
procedure caricavarline(xi,yi,xf,yf:real;tlin,col:integer);
begin
  disegno^[ndis].entita:='L';
  disegno^[ndis].colore:=col;
  disegno^[ndis].tlinea:=tlin;
  disegno^[ndis].x1:=xi;
  disegno^[ndis].y1:=yi;
  disegno^[ndis].x2:=xf;
  disegno^[ndis].y2:=yf;
  inc;
end;
procedure caricavartesto(ts:string;x,y:real;col:integer);
begin
  with disegno^[ndis] do
    begin
      entita:='T';
      testo:=TS;
      colore:=col;
      x1:=X;
      y1:=Y;
    end;
    inc;
end;
begin
   new(tabgraph);
   initdis;
   {setbkcolor(0);}
   {assign(fdis,DRIVEPROG + Num+'.drw');
   rewrite(fdis);}
   for ndis := 1 to lungdisegno do
   begin
      disegno^[ndis].entita:='';
      disegno^[ndis].testo:='';
      disegno^[ndis].tlinea:=0;
      disegno^[ndis].x1:=0;
      disegno^[ndis].y1:=0;
      disegno^[ndis].x2:=0;
      disegno^[ndis].y2:=0;
   end;
   FOR I:=0 TO 20 DO
    begin
       TabGraph^[I].SPES:=0;
       TabGraph^[I].TEMP:=0;
       TabGraph^[i].Ps:=0;TabGraph^[i].Pv:=0;
       TabGraph^[i].Nome:=' ';
    end;
   S:=0;
   ns:=0;
   xspes:=0;
   for i:=-1 to NStrati do
    begin
       TabGraph^[I+1].SPES:=Tabe^[i].S;
       S:=S+Tabe^[i].S;
       TabGraph^[I+1].TEMP:=tabcalcolo^[i].TF;
       TabGraph^[i+1].Ps:=tabcalcolo^[i].Ps/1000;
       TabGraph^[i+1].Pv:=tabcalcolo^[i].Pv/1000;
       TabGraph^[i+1].Nome:=Tabe^[i].Nome;
       if tabgraph^[i+1].spes >0 then ns:=ns+1;
{       if xspes< textwidth(Tabe^[i].Nome) then xspes:=textwidth(Tabe^[i].Nome);}
    end;

   if S= 0 then exit;
   fs:=320/s;

 (***********************  TEMPERATURA     *********************)

   ndis:=1;
   hdt:=340;
   hgb:=hdT-(Maxtemp*fy);
   hgb1:=hdT-(Mintemp*fy);
   X1:=50; Y1:=(MaxTemp*fy)-(TabGraph^[1].Temp*fy);
   y1:=(hgb1-y1);
{   movabs1(@X1,@Y1);}
   X:=X1;
   Y:=y1;
   for i:=0 to NStrati do
    begin
       if TabGraph^[i].spes <> 0 then
        begin
           real1:=x;
           real2:=y;
           X:=(TabGraph^[i].spes)*fs+X1;
           Y:=(MaxTemp*fy)-(TabGraph^[i].Temp*fy);
           y:=(hgb1-y);
           {movabs1(@real1,@real2);
           setcolor(14);
           lnabs1(@X,@Y);}
           caricavarline(real1,real2,x,y,0,14);
           {setcolor(15);
           setfillstyle(0,0);
           setlinestyle(0,0,0);
           DrawSquare(x1,hgb,X,hgb1);}
	   caricavarsquare(x1,hgb,X,hgb1);
           X1:=X;
        end;
    end;
    xgb:=x;
    real1:=50;
    real2:=hgb1+5;
    {movabs1(@real1,@real2);
    setcolor(11);
    outtext(w_m(17)'ANDAMENTO TEMPERATURE (øC)');}
    caricavartesto(w_m(17){'ANDAMENTO TEMPERATURE (øC)'},REAL1,REAL2,11);
    real1:=0;
    b:=0;
    for i:= 6 downto -4 do
    begin
      a:=i*5;
      str(a:2:0,st1);
      real2:=hgb1-(b*25);
      real1:=0;
      {movabs1(@real1,@real2);
      setcolor(7);
      outtext(st1);
      movabs1(@real1,@real2);         }
      CARICAVARTESTO(st1,real1,real2,7);

      real3:=50;
      {setcolor(8);
      setlinestyle(1,0,0);}
      if i=0 then real3:=370;
      {lnabs1(@real3,@real2);}
      caricavarline(real1,real2,real3,real2,0,8);
      b:=b+1;
    end;
    real1:=50;
    real2:=140;
    real3:=0;
    {movabs1(@real1,@real2);
    setlinestyle(1,0,0);}
    for i:= 0 to 4 do
    begin
      somma:=i*s*100/4;
      str(somma:3:1,st1);
      real1:=(i*80)+50;
      real2:=140;
      {movabs1(@real1,@real2);
      setcolor(7);
      outtext(st1);}
      CARICAVARTESTO(st1,real1,real2,7);
      {movabs1(@real1,@real2);}
      real3:=190;
      {setcolor(8);
      lnabs1(@real1,@real3);}
      caricavarline(real1,real2,real1,real3,0,8);
    end;
    real1:=50;real2:=180;
{    movabs1(@real1,@real2);
    setlinestyle(0,0,0);}
    for i:=1 to 40 do
    begin
      real1:=(i*8)+50;
      real3:=190;
      {
      movabs1(@real1,@real2);
      lnabs1(@real1,@real3);}
      caricavarline(real1,real2,real1,real3,0,8);
     end;

(**********************  PRESSIONI ********************************)
    assign(fd,'debug.sce');
    rewrite(fd);
    X1:=xgb+fx;
    Y1:=(TabGraph^[1].Pv*fyV)+hgb;
    y:=y1;
    x:=x1;
    {setlinestyle(0,0,0);}
    for i:=1 to NStrati do
    begin
       if tabgraph^[i].spes> 0 then
       begin
         real1:=x;
         real2:=y;
         X:=(TabGraph^[i].spes*fs)+X1;
	 Y:=(TabGraph^[i].Pv*fyv)+hgb;
         {movabs1(@real1,@real2);
         setcolor(3);
         Lnabs1(@X,@Y);}
         caricavarline(real1,real2,x,y,0,3);
         {
         setcolor(15);
         setfillstyle(0,0);
         setlinestyle(0,0,0);
	 DrawSquare(X1,hgb,X,hgb1);}
         caricavarsquare(X1,hgb,X,hgb1);
         X1:=X;
       end;
    end;
    close(fd);
    X1:=xgb+fx;
    Ys1:=(TabGraph^[1].Ps*fyv)+hgb;
    y:=ys1;
    x:=x1;
    {setlinestyle(2,0,0);}
    for i:=1 to NStrati do
    begin
       if tabgraph^[i].spes> 0 then
       begin
         real1:=x;
         real2:=y;
         X:=(tabgraph^[i].spes*fs)+X1;
	 Y:=(tabgraph^[i].Ps*fyv)+hgb;
         {setcolor(4);
	 movabs1(@real1,@real2);
	 Lnabs1(@X,@Y);}
         caricavarline(real1,real2,x,y,2,4);
         {setcolor(15);}
         X1:=X;
       end;
    end;
    real1:=XGB+FX;
    real2:=hgb1+5;
    {movabs1(@real1,@real2);
    setcolor(11);
    outtext(w_m(18)'ANDAMENTO PRESSIONI (kPa)');}
    CARICAVARTESTO(w_m(18){'ANDAMENTO PRESSIONI (kPa)'},real1,real2,11);
    real1:=0;
    b:=0;
    for i:= 10 downto 0 do
    begin
      a:=i*0.3;
      str(a:2:1,st1);
      real2:=hgb1-(b*25);
      real1:=xtsg;
      {movabs1(@real1,@real2);
      setcolor(7);
      outtext(st1);}
      CARICAVARTESTO(st1,real1,real2,7);
     { movabs1(@real1,@real2);}
      real3:=xsgb;
      {setcolor(8);
      setlinestyle(1,0,0);
      lnabs1(@real3,@real2);}
      caricavarline(real1,real2,real3,real2,0,8);
      b:=b+1;
    end;
    real1:=xsgb;
    real2:=0;
    somma:=0;
{    movabs1(@real1,@real2);
    setlinestyle(1,0,0);}
    for i:= 0 to 4 do
    begin
      somma:=i*s*100/4;
      str(somma:3:1,st1);
      real1:=(i*80)+xsgb;
      real2:=140;
     { movabs1(@real1,@real2);
      setcolor(7);
      outtext(st1);}
      CARICAVARTESTO(st1,real1,real2,7);
      real3:=190;
{      movabs1(@real1,@real2);

      setcolor(8);
      lnabs1(@real1,@real3);}

      caricavarline(real1,real2,real1,real3,0,8);
    end;
    real1:=xsgb;real2:=180;
   { movabs1(@real1,@real2);
    setlinestyle(0,0,0);}
    for i:=1 to 40 do
    begin
      real1:=(i*8)+xsgb;
      real3:=190;
{      movabs1(@real1,@real2);
      lnabs1(@real1,@real3);}
      caricavarline(real1,real2,real1,real3,0,8);
    end;
 (******************** DESCRIZIONI   **********************************)

   hdt:=630;
   hgb:=hdt-(maxtemp*fy);
   hgb1:=hdt-(mintemp*fy);
   X1:=50;k:=1;
   for i:=0 to NStrati do
    begin
       if tabgraph^[i].spes > 0 then
        begin
          X:=(tabgraph^[i].spes*fs)+X1;
         { SETCOLOR(15);
          setfillstyle(0,0);
          drawsquare(X1,hgb,X,hgb1);}
          caricavarsquare(X1,hgb,X,hgb1);;
          if (i >= 2) then
           begin
            { SetLineStyle(1,0,0);}
             real1:=(X+X1)/2;
             real2:=hgb1-(k*25);
            { movabs1(@real1,@real2);
             setcolor(4);}
             real3:=2;
             {cir(@real3);}
             with disegno^[ndis] do
             begin
               entita:='C';
               colore:=4;
               x1:=real1;
               y1:=real2;
               x2:=real3;
             end;
             inc;
            { setcolor(8);}
	     real3:= xdm;
             real1:=(X+X1)/2;
             real2:=hgb1-(k*25);
             {movabs1(@real1,@real2);
             Lnabs1(@real3,@real2);}
             caricavarline(real1,real2,real3,real2,2,8);
             {SetLineStyle(0,0,0);
             setcolor(15);}
             real4:=tabgraph^[i].spes*100;
             str(real4:4:3,st1);
             st1:='cm '+st1+' ';
             {outtext(tabgraph^[i].Nome);}
             caricavartesto(tabgraph^[i].nome,real3,real2,15);
             {setcolor(2);}
             real1:=xsm;
             {movabs1(@real1,@real2);}
             caricavartesto(st1,real1,real2,3);
             {outtext(st1);}
             k:=k+1;
          end;
          {setfillstyle(i,1);}

         X1:=X;
       end;
    end;
    real1:=50;
    real2:=hgb1+5;
    {movabs1(@real1,@real2);
    setcolor(11);
    outtext(w_m(19)' COMPOSIZIONE   STRUTTURA');}
    caricavartesto(w_m(19){' COMPOSIZIONE   STRUTTURA'},real1,real2,11);
    ndisegno:=ndis;
    dispose(tabgraph);
end;


{
function Pressat(T:real):integer;
  var
    Press:array[1..600] of integer;
    g:file of integer;
    i,j:integer;

  begin
    assign(g,DRIVE2 + 'Pressioni');
    reset(g);
    for j:=1 to 600 do read(g,Press[j]);
    close(g);
    if T < -29.9 then Pressat:=39
    else
     begin
        if T > 29.9 then Pressat:=4218
        else
         begin
            T:=T+29.9;T:=T*10+1;
            if T > 300 then T:=T+1;
            i:=round(T);
            Pressat:=Press[i];
         end;
     end;
  end;




{--------------------------- Ricerca Codice in Archivio ----------------------}
procedure RicercaArc(campo:integer);

var j,i,k:integer;
    f:file of Arch;
    Trovato:boolean;

begin
   j:=1;
   k:=j+(campo div 3);
   Trovato:=false;
   i:=1;
   repeat
      if Tabe^[k].cod=Arc^[i].cod then
       begin
          campo:=campo+1;
          Tabe^[k].nome:=Arc^[i].nome;
          Trovato:=true;
       end
      else i:=i+1;
   until Trovato or (i > NMater);
 end;

{----------------------------- Ripresa Struttura -----------------------------}
procedure RipresaStruttura(Num:string);

var g:file of tab;
    f:file of ArrCalcolo;
    k:file of Contorno;
    a:char;
    i:integer;

begin
   if Exist(DRIVEPROG + Num +'.STR') then
    begin
       assign(g,DRIVEPROG + Num +'.STR');
       reset(g);
       read(g,Tabe^);
       close(g);
       if Exist(DRIVEPROG + Num + '.Con') then
        begin
           assign(k,DRIVEPROG + Num + '.Con');
           reset(k);
           read(k,Cond_Cont^);
           close(k);
        end;
    end
   else
    begin
       for i:=-1 to NStrati do
        with Tabe^[i] do
         begin
           cod:='';
           nome:='';
           s:=0;
         end;
    END;
END;

{$I Calcolo  }

procedure InitStruttura;
 var i:integer;
 begin
    for i:=-1 to NStrati do
     with Tabe^[i] do
      begin
         cod:='';
         nome:='';
         s:=0;
      end;
 end;


 function EsGrafico(visualizza:boolean;nome:string):boolean;
 var i:integer;
     ch:char;
     ft:textfile;
     dr:string;
     f:file of arch;
{----------------------------------- MAIN ------------------------------------}

begin

   assignfile(ft,'drive1.int');
   reset(ft);
   read(ft,dr);
   closefile(ft);


   assignfile(ft,dr+'\drivearc.int');
   reset(ft);
   read(ft,drivearc);
   closefile(ft);

   drivearc:=drivearc+'\igro\';


   assignfile(ft,dr+'\driveprg.int');
   reset(ft);
   read(ft,driveprog);
   closefile(ft);

   assignfile(ft,dr+'\nomecom.dat');
   reset(ft);
   read(ft,dr);
   closefile(ft);

   driveprog:=driveprog+'\'+dr+'\igro\';
   newfmes('IGRO');
   new(tabe);
   new(arc);
   new(cond_cont);
   new(tabcalcolo);
   new(tabePond);
   new(TabStampa);
   assignfile(f,drivearc+'archivio.gen');
   reset(f);
   read(f,arc^);
   closefile(f);
   RipresaStruttura(Nome);
   Calcolo;
   Grafico(visualizza);
   restorefmes;
   dispose(tabe);
   dispose(arc);
   dispose(cond_cont);
   dispose(tabcalcolo);
   dispose(tabePond);
   dispose(TabStampa);

end;


end.




