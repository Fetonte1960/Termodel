

unit GLOBFUNZcan;

INTERFACE

uses definiz,definizcan,funzbase,{Gruti,piante,}angoli,{$ifdef win} winprocs,{$endif}
     Genproccan,dummyfunction,{halotp4,graph,}WM{$ifdef dos}ut_loca,{$endif}{,diseg,controll};


Function  InsNodo(Tratto,NTratto,Tipo,Nuovotr:integer):integer;
procedure initRec(indice,Modo:integer);
procedure initRec4(indice:integer); {cippo-messie 9/06/94
initrec4 si comporta come initrec con modo=4 solo che l'inizializzazione dei
pezzi parte da 0 anziche' 1. E' stata inserita poiche'qundo si inserisce o si
cancella un tronco occorre resettare tutti i pezzi dei suoi figli altrimenti
si creano problemi in dati tronco aggiorna}
procedure vaga;
Function  TipoNodo(Tratto:integer):integer;
function  SetFlag:boolean;
Procedure Ver_spez(xs,ys,zs:real;Trattos:integer;Var Cod:integer);
Function  NomeFile(Drive:string):String;
Procedure CancNum(tr:integer);
Procedure insersetflag(aaa,bbb:integer);

{---------------------------------------------------------------------------}
implementation

{***************************  CancNum          *******************************}

Procedure CancNum(tr:integer);

begin
end;




{****************************** VAGA *****************************************}

procedure vaga;

begin
end;
{************************** RICHIESTA1 ****************************************}

(*Procedure richiesta1(rich:st80);

var Fl:string;

begin
  real1:=0;real2:=0;real3:=900;real4:=750;
  setclip(@real1,@real2,@real3,@real4);
  int1:=15;
  int2:=0;
  settextclr(@int1,@int2);
  Fl:='                                                            ';
  real1:=1;real2:=15;
  MovTcurabs1(@real1,@real2);
  text1(@Fl);
  real1:=1;real2:=15;
  MovTcurabs1(@real1,@real2);
  text1(@rich);
  deltcur;
end;*)



{**************************** INSNODO *************************************}

   {-- Collega la nuova entita` Ntratto a Tratto sul grafo --}

Function InsNodo(Tratto,NTratto,Tipo,Nuovotr:integer):integer;
var i,titemp,TrTemp{,ulttemp}:integer;
    insertMode:boolean;

begin
  case tipo of
  1:begin                           {-- Interno ad un tronco --}
    {Ulttemp:=Ulttronco;cippo}
    NTronchi:=newtr;
    (* NuovoTr:=NuovoTr+(UlTtronco-UltTemp); cippo *)
    CancNum(dis^[tratto]^.TRonco);
    initrec(NTronchi,1);
    TrTemp:=NTronchi;

    with dati^[ntronchi]^ do     {* E *}
      begin
      Ti:=dis^[tratto]^.nlinea;
      for i:=1 to 6 do  pros[i]:=Dati^[dis^[tratto]^.tronco]^.pros[i];
      {Term:=Dati^[dis^[tratto].tronco].Term;}
      end;

    dis^[tratto]^.nlinea:=0;     {* 1 *}

    i:=Dati^[NTronchi]^.Ti;      {* 2,.. *}
    repeat
      dis^[i]^.tronco:=NTronchi;
      i:=dis^[i]^.NLinea;
      if i<>0 then if dis^[i]^.entita='T' then
        begin
        dis^[i]^.tronco:=NTronchi;
        i:=0;
        end;
    Until i=0;


    if Nuovotr=0 then
      begin
      insertMode:=false;
      NTronchi:=NewTr;
      NuovoTr:=NTronchi;
      initrec(NuovoTr,1);    (* cippo *)
      dati^[NuovoTr]^.Ti:=Ntratto;
      end
    else insertMode:=true;

(*   sopra in nuovotr=0    cippo
    initrec(NuovoTr,1);
    dati^[NuovoTr]^.Ti:=Ntratto;   {* D *}  *)
    InsNodo:=NuovoTr;

    titemp:=dati^[dis^[Tratto]^.tronco]^.Ti;
    initrec(dis^[Tratto]^.tronco,2);

    with dati^[dis^[Tratto]^.tronco]^ do    {* A *}
      begin
      Ti:=Titemp;
      Pros[1]:=NuovoTr;
      Pros[2]:=TrTemp;
      end;
    if not insertMode then Ntronchi:=Newtr;
    end;

  2:begin                              {-- Nodo finale --}
    CancNum(dis^[tratto]^.TRonco);
    dis^[tratto]^.nlinea:=Ntratto;  {* 2 *}
    InsNodo:=dis^[tratto]^.tronco;
    InitRec(dis^[tratto]^.tronco,4);
    end;

  3:begin                  {-- Nodo con rami --}

    with Dati^[Dis^[Tratto]^.Tronco]^ do
      begin

      i:=1;
      while (pros[i]<>0) and (i<6) do i:=I+1;
      if pros[i]<>0 then
        begin
        Write(chr(7));
        richiesta(W_M(97));  { 'Impossibile inserire altri tronchi sul nodo selezionato');}
        InsNodo:=0;
        end
      else
        begin
        if Nuovotr=0 then
          begin
          Ntronchi:=Newtr;
          pros[i]:=Ntronchi;   {* A *}
          initRec(NTronchi,1);          {* D *}
          dati^[NTronchi]^.Ti:=NTratto;

          InsNodo:=NTronchi;
          InitRec(dis^[tratto]^.tronco,4);
          InitRec4(dis^[tratto]^.tronco);  {cippo-messie 09/06/94}

          Ntronchi:=Newtr;  {cippo}

          end
        else
          begin
          pros[i]:=NuovoTr;
          InsNodo:=NuovoTr;
          end;
        end
      end

    end

  end

end;
{****************************** InitRec *************************************}

procedure initRec4(indice:integer);{cippo-messie 9/06/94 }

var i,j,k:integer;


begin

  For j:=1 to 6 do
   if dati^[indice]^.pros[j]<>0 then
    begin
     k:= dati^[indice]^.pros[j];
     For i:=0 to Pezzitr do
      if Dati^[k]^.Pezzi[i]<>0 then
       begin
        VPezzi^[dati^[k]^.Pezzi[i]]^.Codice:='';
        Dati^[k]^.Pezzi[i]:=0;
       end;
    end;

end;

{****************************** InitRec *************************************}

procedure initRec(indice,Modo:integer);

var i:integer;


begin

if Modo IN [2,3,4] then
  begin
  For i:=1 to Pezzitr do
  if Dati^[indice]^.Pezzi[i]<>0 then
    begin
    VPezzi^[dati^[indice]^.Pezzi[i]]^.Codice:='';
    Dati^[indice]^.Pezzi[i]:=0;
    end;
  end;

if modo=3 then
  begin

  with dati^[indice]^ do
    begin
    Num    :=0;
    {x      :=0;
    y      :=0; nuccio per cr}
    end;
  end;

if modo IN [1,2] then
  begin

  with dati^[indice]^ do
    begin
    Num    :=0;
    {x      :=0;
    y      :=0;}
    for i:=0 to pezzitr do pezzi[i]:=0;
    Ti     :=0;
    for i:=1 to 6 do pros[i]:=0;
    end;
  end;

end;

{**************************** TIPONODO *************************************}

{-- Classifica il tipo di nodo in cui termina tratto --}

Function TipoNodo(Tratto:integer):integer;

begin
if dis^[tratto]^.nlinea<>0 then Tiponodo:=1 {-- interno ad un tronco --}
  else
  begin
  with dati^[dis^[tratto]^.tronco]^ do
  if pros[1]=0 then Tiponodo:=2       {--  nodo finale   --}
  else Tiponodo:=3;                   {--  nodo con rami --}
  end;
end;
{************************** insersetflag      *******************}


Procedure insersetflag(aaa,bbb:integer);{pino}
var i:integer;
    m1,m2,c1,c2:real;
    trovato:boolean;


begin

trovato:=false;

if sezione then
  begin
  if abs(xsup-xinf)>1 then
    begin
    m1:=(ysup-yinf)/(xsup-xinf);
    c1:=yinf-m1*xinf;
    end
  else
    begin
    m1:=10E6;
    c1:=xinf;
    end;

  if m1>1000 then
    begin
    m1:=10E6;
    c1:=xinf;
    end;
  M_Sez:=m1;
  C_sez:=c1;
(*
writeln(lst,' Finestra orz:',orz,{'  xs:',xsup:5:0,'ys:',ysup:5:0,'xi:',xinf:5:0,'yi:',yinf:5:0,}'m1:',m1:10:3,'c1:',c1:10:3);
*)
  end;

For i:=aaa to bbb do
with Dis^[i]^ do
if Entita<>'' then
  begin
  if sezione then
    begin
    if abs(x2-x1)>1 then
      begin
      m2:=(y2-y1)/(x2-x1);
      c2:=y1-m2*x1;
      end
    else
      begin
      m2:=10E6;
      c2:=x1;
      if abs(y2-y1)<10E-6 then  {-- Tratto Verticale --}
        begin
        if ((m1<10E2)and(abs(Y1-(m1*X1+c1))<10))or
           ((m1>=10E2)and(abs(x1-c1)<10)) then
          begin
          m2:=m1;
          c2:=c1;
          end
        end
      end;

    if m2>1000 then
    begin
    m2:=10E6;
    c2:=x1;
    end;

    if (abs(m1-m2)<0.1)and( (abs(c1-c2)<10)or
       ((m2>=10E2)and(abs(c2-c1)<10)) ) then

    Flag:=true
    else Flag:=false;
(*
   if  flag then
  writeln(lst,i,{' x2: ',x2:5:0,'y2: ',y2:5:0,'x1: ',x1:5:0,'y1: ',y1:5:0,}'m2: ',m2:10:3,'c2: ',c2:10:3,'F:  ',flag);
*)
    end
  else
    begin
    //flag:=true:
    //if  (abs(Z1-Z2)<10)and(abs(Z1-RisultCalc^.Quota)<10) then Flag:=true
    //else Flag:=false;
    {writeln(lst,i,' RisultCalc.Quota: ',RisultCalc.Quota:5:0,'  z2: ',z2:5:0,'  z1: ',z1:5:0,'  Flag:',Flag);}
    end;
  trovato:=true;
  //Trovato:=(trovato)or(flag);
  //if (not(sezione))and(Ug(z2,risultCalc^.quota,2)) Then Trovato:=true;
  end;
{SetFlag:=trovato;}
end;





{***************************  SetFlag         *******************************}

function SetFlag:boolean;

var i:integer;
    m1,m2,c1,c2:real;
    trovato:boolean;
    tolleranza:real;   {cippo1 }

begin

trovato:=false;
//tolleranza:=0.01/(conf^.AltNum/40000);

if sezione then
  begin
  if abs(xsup-xinf)>1 then
    begin
    m1:=(ysup-yinf)/(xsup-xinf);
    c1:=yinf-m1*xinf;
    end
  else
    begin
    m1:=10E6;
    c1:=xinf;
    end;

  if m1>1000 then
    begin
    m1:=10E6;
    c1:=xinf;
    end;
  M_Sez:=m1;
  C_sez:=c1;
(*
writeln(lst,' Finestra orz:',orz,{'  xs:',xsup:5:0,'ys:',ysup:5:0,'xi:',xinf:5:0,'yi:',yinf:5:0,}'m1:',m1:10:3,'c1:',c1:10:3);
*)
  end;

For i:=1 to ultriga do
with Dis^[i]^ do
if Entita<>'' then
  begin
  if sezione then
    begin
    if abs(x2-x1)>1 then
      begin
      m2:=(y2-y1)/(x2-x1);
      c2:=y1-m2*x1;
      end
    else
      begin
      m2:=10E6;
      c2:=x1;
      if abs(y2-y1)<10E-6 then  {-- Tratto Verticale --}
        begin
        if ((m1<10E2)and(abs(Y1-(m1*X1+c1))<10))or
           ((m1>=10E2)and(abs(x1-c1)<10)) then
          begin
          m2:=m1;
          c2:=c1;
          end
        end
      end;

    if m2>1000 then
    begin
    m2:=10E6;
    c2:=x1;
    end;

    if (abs(m1-m2)<0.1)and( (abs(c1-c2)<10)or
       ((m2>=10E2)and(abs(c2-c1)<10)) ) then

    Flag:=true
    else Flag:=false;
(*
   if  flag then
  writeln(lst,i,{' x2: ',x2:5:0,'y2: ',y2:5:0,'x1: ',x1:5:0,'y1: ',y1:5:0,}'m2: ',m2:10:3,'c2: ',c2:10:3,'F:  ',flag);
*)
    end
  else
    begin
    (*
    if  (abs(Z2-RisultCalc^.Quota)<tolleranza)
        and(abs(Z1-RisultCalc^.Quota)<tolleranza)
    then begin
          Flag:=true;
          if abs(Z1-RisultCalc^.Quota) < abs(Z2-RisultCalc^.Quota)
           then RisultCalc^.Quota:=z1
           else RisultCalc^.Quota:=z2
         end
    else Flag:=false;
    *)
{    if  (abs(Z1-Z2)<10)and(abs(Z1-RisultCalc^.Quota)<10) then Flag:=true
    else Flag:=false;cippo scegliendo una quota si ha un margine di
    errore di un paio di cm ; ad es. con una scala 1:200 di circa 3 cm.}
    {writeln(lst,i,' RisultCalc^.Quota: ',RisultCalc^.Quota:5:0,'  z2: ',z2:5:0,'  z1: ',z1:5:0,'  Flag:',Flag);}
    end;
  Trovato:=(trovato)or(flag);
  //if (not(sezione))and(Ug(z2,RisultCalc^.quota,2)) Then Trovato:=true;
  end;
SetFlag:=trovato;
end;

{***************************  VER_SPEZ     *****************************}

Procedure Ver_spez(xs,ys,zs:real;Trattos:integer;Var Cod:integer);

Function Incluso(x,a,b:real):boolean;
begin
incluso:=((ug(a,b,2))and(ug(a,a,2)))or
         ((a<b)and(x>=a)and(x<=b))or
         ((b<a)and(x>=b)and(x<=a))
end;

begin
with Dis^[trattos]^ do
if ((Ug(xs,x1,2))and(Ug(ys,y1,2))and(Ug(zs,z1,2)))or
   ((Ug(xs,x2,2))and(Ug(ys,y2,2))and(Ug(zs,z2,2))) then
  begin
  {$ifdef dos}
  Write(chr(7));
  Richiesta(W_M(98));  { 'Punto non corretto'); }
  {$else}
  //messagebeep(10);
  {$endif}
  {Delay(500);}
  Cod:=130;
  end
else
  begin
  if (not(incluso(xs,x1,x2))or(not(incluso(ys,y1,y2)))) then
    begin
    Write(chr(7));
    Richiesta(W_M(98));  { 'Punto non corretto'); }
    {Delay(500);}
    Cod:=130;
    end;
  end;
end;

{***************************  NomeFile     *****************************}

Function NomeFile(Drive:string):String;

var Err:boolean;
    Nome:string;
begin
Err:=False;
repeat
//if Not(Err) then
//Nome:=ReadCom(W_M(99),'',0)  { 'Nome del file','',0) }
//else Nome:=ReadCom(W_M(100),'',0);  { 'Introdurre nome corretto','',0); }
{Err:=Not(ExistS(Drive+Nome))}
Until (Nome='')or(Not(Err));
NomeFile:=Nome;
end;

end.
