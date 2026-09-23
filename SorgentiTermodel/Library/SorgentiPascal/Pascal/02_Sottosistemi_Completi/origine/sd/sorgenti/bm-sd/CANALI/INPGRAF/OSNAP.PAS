
{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit osnap;

interface

uses definiz,genproc,halotp4,graph,esiste{$ifdef win},winprocs{$endif};

Function Osn(Var P_x,P_y:real;xp,yp,xu,yu:real;codice:integer;VAR mess:string):Boolean;


{==========================================================================}
implementation

Procedure linea(xa,ya,xb,yb:real);
function xgraf(xeff:real):real;
begin
xgraf:=xg1(Xeff+22717,0);
end;
function ygraf(yeff:real):real;
begin
ygraf:=yg1(Yeff+17937,0);
end;

begin
xa:=xgraf(xa);
ya:=ygraf(ya);
xb:=xgraf(xb);
yb:=ygraf(yb);

setcolor(5);
movabs(@xa,@ya);
lnabs(@xb,@yb);
{repeat until keypressed;}
end;

{ **************************** Perp ********************************* }

procedure perp(var x,y:real;xpun,ypun,x1,y1,x2,y2:real);

var a,c,b,d:real;


 begin

   if (abs(x2-x1)>10E-6) and (abs(y2-y1)>10E-6)then  { retta qualsiasi di arrivo}
   begin
     a:=(y2-y1)/(x2-x1);   {by minardo}
     b:=y1-a*x1;
     c:=-1/a;
     d:=ypun+xpun*1/a;
     x:=(d-b)/(a-c);
     y:=a*x+b;
   end;

   if  (abs(x2-x1)<=10E-6)then
   begin
    x:=x1;
    y:=ypun;
   end;

   if (abs(y2-y1)<=10E-6) then
   begin
    x:= xpun;
    y:= y1;
   end;

 end;

{*************************************************************************}
(* cippo la funzione vicino VALE SOLO per pareti oriz. o vert. *)
Procedure Vicino(Var x,y:{integer}real;Var trovato:boolean;
                     X1,y1,x2,y2{:integer;},px,py,Ang,dist:real);
Var seno,coseno:real;

begin
Trovato:=false;
if abs(x2-x1)<abs(y2-y1) then { Verticale }
  begin
  if Px<x1 then
    begin
    x1:=x1-{round}(dist);
    Seno:=sin(ang);
    if Seno>0.01 then
     if Px<x1 then  (*cippo verifica che la distanza tra nodo parete > dist*)
      begin
      trovato:=true;
      x:=x1;
      y:={round}(Py+(x1-Px)*cos(ang)/seno);
      end;
    end
  else
    begin
    x1:=x1+{round}(dist);
    Seno:=sin(ang);
    if Seno<-0.01 then    (* cippo *)
     if Px>x1 then  (*cippo verifica che la distanza tra nodo parete > dist *)

      begin
      trovato:=true;
      x:=x1;
      y:={round}(Py-(Px-x1)*cos(ang)/seno);
      end;
    end
  end
else    { orizzontale}
  begin
  if Py<y1 then
    begin
    y1:=y1-{round}(dist);
    coseno:=cos(ang);
    if coseno>0.01 then
     if Py<y1 then  (*cippo verifica che la distanza tra nodo parete> dist *)

      begin
      y:=y1;
      Trovato:=true;
      x:={round}(px+(y1-py)*sin(ang)/coseno);
      end;
    end
  else
    begin
    y1:=y1+{round}(dist);
    coseno:=cos(ang);
    if coseno<-0.01 then
     if Py>y1 then  (*cippo verifica che la distanza tra nodo parete> dist *)

      begin
      y:=y1;
      Trovato:=true;
      x:={round}(px-(py-y1)*sin(ang)/coseno);
      end;
    end;
  end;
end;


{*************************************************************************}
(* cippo la funzione vicinosp  VALE SOLO per pareti oriz. o vert. *)
Procedure Vicinosp(Var x,y:{integer pino}real;Var trovato:boolean;
                     X1,y1,x2,y2{:integer;},px,py,Ang,dist:real);
Var seno,coseno:real;
begin

 Trovato:=false;
 if abs(x2-x1)<abs(y2-y1) then { Verticale }
   begin
    x1:=x1+{round}(dist);
    Seno:=sin(ang);
    if abs(Seno)>0.01 then
      begin
      trovato:=true;
      x:=x1;
      y:={round}(Py+(x1-Px)*cos(ang)/seno);
      end;
   end
 else    { orizzontale}
  begin
    y1:=y1+{round}(dist);
    coseno:=cos(ang);
    if abs(coseno)>0.01 then
      begin
      y:=y1;
      Trovato:=true;
      x:={round}(px+(y1-py)*sin(ang)/coseno);
      end;
  end;

end;

{**************************************************************************}



{**************************************************************************}


Function Osnap_P(Var pX,Py:{integer pino}real;tipo:integer;box:integer;Pianta:string;
                     xp1,yp1,xu1,yu1:real;Var mess:STRING):Boolean;

type recdis=record mov:boolean;x,y:integer end;
     RECDIS1=ARRAY[1..nhpgl]OF RECDIS;
     TMP=record
          xm,ym:array[1..2]of {integer} real;
          P_d:integer;
          end;

Var X_pr,Y_Pr:Integer;
    Max_x,Max_Y,Min_X,Min_Y:{Integer pino}real;
    FDIS1:file of RECDIS1;
    dentro_p,Dentro_c:Boolean;
    M_Line,Max_line:Integer;
    M_p:array[1..10] of TMP;
    trovato,troppi,Os_temp:Boolean;
    hpgl:recdis1;
    i:integer;
    Fdeb:text;
    dist,dist1,dist2:real;
    temp:{integer} real;
    R_1,R_2:real;



 {----}
{cippo introdotta perche se sono state selezionate piu linee sovrapposte
di pianta aventi tutte la stessa equazione si accetta la selezione;
da inserire in canali}
Function linecoincidenti:boolean;
var i : integer;
    coefang1,termnot1,vertnot1:real;
    coefangI,termnotI,vertnotI:real;
    risultato:boolean;
    verticale:boolean;
begin
 risultato:=true;
 if m_line>1 then
  begin
   with m_p[1] do
    begin
      verticale:=(abs(xm[1]-xm[2])<10e-3);
      if verticale then Vertnot1:=xm[1]
                   else
                    begin
                     Coefang1:=(Ym[1]-ym[2]) / (xm[1]-xm[2])  ;
                     Termnot1:=-coefang1*xm[1]+ym[1];
                    end
    end;
    for i:=2 to m_line do
    with m_p[i] do
    begin
     if verticale then
      begin
       if (abs(xm[1]-xm[2])<10e-3) then
                                    begin
                                     vertnotI :=xm[1];
                                     risultato:=(abs(Vertnot1-VertnotI)<10-3)
                                                and risultato
                                    end
                                   else risultato:=false
      end
     else   {not verticale}
      begin
       if (abs(xm[1]-xm[2])<10e-3) then risultato:=false
                                   else
                                    begin
                                     CoefangI:=(Ym[1]-ym[2]) / (xm[1]-xm[2]);
                                     TermnotI:=-coefangI*xm[1]+ym[1];
                                     risultato:=(abs(Termnot1-TermnotI)<10-3)
                                                and
                                                (abs(Coefang1-CoefangI)<10-3)
                                                and risultato
                                    end

      end;
    end;
  end;
  linecoincidenti:=risultato;
end;
{ se sono state selezionate piu linee si suppone che la finestra
  sia quella strettamente piu interna alle altre}
Function TrovaFinestra:boolean;
var xm1,xm2,ym1,ym2 :{integer} real;
    i:integer;
    risultato         :boolean;
    d1,di             :real;
begin
  Risultato:=true;
  if m_line>1 then
   begin
    With m_p[1] do
     begin
      xm1:=xm[1];
      xm2:=xm[2];
      ym1:=ym[1];
      ym2:=ym[2];
      r_1:=xm[1];
      r_2:=xm[2];
      d1:=sqr(r_1-r_2);
      r_1:=Ym[1];
      r_2:=ym[2];
      d1:=sqrt(d1+sqr(r_1-r_2));
      for i:=2 to m_line do
       with m_p[i] do
        begin
         r_1:=xm[1];
         r_2:=xm[2];
         di:=sqr(r_1-r_2);
         r_1:=Ym[1];
         r_2:=ym[2];
         di:=sqrt(di+sqr(r_1-r_2));
         if di<d1 then
               begin
                 xm1:=xm[1];
                 xm2:=xm[2];
                 ym1:=ym[1];
                 ym2:=ym[2];
                 d1:=di;
               end
       (*   else if ( (xm1<xm[1]) or (xm1<xm[2]) and      {or esclusivo}
                    not((xm1<xm[1]) and (xm2<xm[2]) )
                  )  and
                  ( (ym1<ym[1]) or (ym1<ym[2]) and
                    not((ym1<ym[1]) or (ym1<ym[2]) )
                  )
               then risultato:=false; *)
        end;
     if risultato then With m_p[1] do
                        begin
                        xm[1]:=xm1;
                        xm[2]:=xm2;
                        ym[1]:=ym1;
                        ym[2]:=ym2;
                        end;
     end;

   end;

  TrovaFinestra:=risultato;
end;

Function Dentro(Punto:RECDIS):boolean;
begin
Dentro:=false;

with punto do
if (x>Min_x)and(x<Max_x)and(y>Min_y)and(y<Max_y) then dentro:=true;
end;

 {-----}

Function Dentro1(Punto:RECDIS):boolean;
begin
Dentro1:=false;

with punto do
if ((x>Min_x)and(x<Max_x))or((y>Min_y)and(y<Max_y)) then dentro1:=true;
end;

 {------}

Function Dentro_L(Punto:RECDIS;xpr,ypr:real):boolean;

Var lato1,lato2:integer;

function lato(xc,yc:real):integer;
begin
lato:=0;
if xc>max_x then lato:=1;
if yc<min_y then lato:=2;
if xc<min_x then lato:=3;
if yc>max_y then lato:=4;
end;


begin
Dentro_L:=false;
lato1:=lato(punto.x,punto.y);
lato2:=lato(xpr,ypr);
if (lato1<>0) and (lato2<>0) then
  begin
  lato1:=lato1+2;
  if lato1>4 then lato1:=lato1-4;
  end;
if lato1=lato2 then Dentro_l:=true;
end;

{-------}

Function distanza(x1,y1,x2,y2:real):real;
begin
distanza:=sqrt(sqr(x2-x1)+sqr(y2-y1));
end;

begin

{initdeb;}

Max_x:=px+box;
Max_Y:=py+box;
Min_X:=px-box;
Min_Y:=py-box;
troppi:=false;
M_Line:=0;
Osnap_p:=false;
Os_temp:=false;
Max_Line:=10;

mess:='';
Dentro_p:=false;

if exist(Pianta+'.dlf')then    {cippo ex dlf}
begin
  assign(fdis1,Pianta+'.dlf' );
  reset(Fdis1);
end
else
if exist(Pianta+'.dlt')then    {cippo ex dlf}
begin
  assign(fdis1,Pianta+'.dlt' );
  reset(Fdis1);
end else Mess:='Non esiste il disegno architettonico';{*TR*}
if mess='' then
begin
  while (not eof(fdis1))and(not(troppi))do
  BEGIN
  READ(FDIS1,HPGL);

  for i:=1 to nhpgl do
    begin
    dentro_c:=dentro1(HPGL[i]);
      if not(HPGL[i].mov)  then
        begin

        if ((dentro_p) and (dentro_c)) then

        if dentro_L(HPGL[i],X_pr,Y_Pr) then

        if M_line < Max_line then
          begin

          M_line:=M_line+1;
          with m_p[M_Line] do
            begin
            xm[1]:=x_pr;
            xm[2]:=hpgl[i].x;
            ym[1]:=y_pr;
            ym[2]:=hpgl[i].y;
            end;
          end
        else troppi:=true;
        end;
      Dentro_p:=dentro_c;
      X_pr:=hpgl[i].x;
      Y_pr:=hpgl[i].y;

      end;
    end;
    close(FDis1);
  end;




  if M_Line >=1 then
    begin
    case tipo of
    1:if (M_line=1) or linecoincidenti then
      with m_p[1] do
        begin
        dist1 :=xm[1]-xm[2];
        dist1 :=sqr(dist1);
        dist2:=ym[1]-ym[2];
        dist2:=sqr(dist2);

        dist:=sqrt(dist1+dist2)/2;

        dist1 :=px-xm[1];
        dist1 :=sqr(dist1);
        dist2:=py-ym[1];
        dist2:=sqr(dist2);

        {with m_p[1] do linea(xm[1],ym[1],xm[2],ym[2]);}


        if sqrt(dist1+dist2) < dist then
          begin
          px:=m_p[1].xm[1];
          Py:=m_p[1].ym[1];
          end
        else
          begin
          px:=m_p[1].xm[2];
          Py:=m_p[1].ym[2];
          end;
        os_temp:=true;
        end;

    2,3:if (M_line=1) or linecoincidenti then
        begin
        if tipo=2 then
        with m_p[1] do
          begin
          {linea(xm[1],ym[1],xm[2],ym[2]);}
          perp(dist1,dist2,xp1,yp1,xm[1],ym[1],xm[2],ym[2]);
          px:={round}(dist1);
          py:={round}(dist2);
          os_temp:=true;
          end;
        end
       else
        begin
        if distanza(m_p[1].xm[1],m_p[1].ym[1],m_p[2].xm[1],m_p[2].ym[1])>
           distanza(m_p[1].xm[1],m_p[1].ym[1],m_p[2].xm[2],m_p[2].ym[2])  then
        with m_p[1] do
          begin
          temp:=xm[1];
          xm[1]:=xm[2];
          xm[2]:=temp;
          temp:=ym[1];
          ym[1]:=ym[2];
          ym[2]:=temp;
          end;

        dist1:=(m_p[1].xm[1]+m_p[2].xm[1])/2;
        m_p[1].xm[1]:={round}(dist1);
        dist1:=(m_p[1].ym[1]+m_p[2].ym[1])/2;
        m_p[1].ym[1]:={round}(dist1);
        dist1:=(m_p[1].xm[2]+m_p[2].xm[2])/2;
        m_p[1].xm[2]:={round}(dist1);
        dist1:=(m_p[1].ym[2]+m_p[2].ym[2])/2;
        m_p[1].ym[2]:={round}(dist1);

        if tipo=3 then
          begin
          {write(chr(7));
          linea(xp1,yp1,xu1,yu1);
          deb('xp1:',xp1);
          deb('yp1:',yp1);
          deb('xp2:',xu1);
          deb('yp2:',yu1);}
          dist1:=(m_p[1].xm[1]+m_p[1].xm[2])/2;
          m_p[1].xm[1]:={round}(dist1);
          dist1:=(m_p[1].ym[1]+m_p[1].ym[2])/2;
          m_p[1].ym[1]:={round}(dist1);
          end;

        with m_p[1] do
          begin
          if tipo=2 then perp(dist1,dist2,xp1,yp1,xm[1],ym[1],xm[2],ym[2])
          else perp(dist1,dist2,xm[1],ym[1],xp1,yp1,xu1,yu1);
          px:={round}(dist1);
          py:={round}(dist2);
          os_temp:=true;
          end;
        end;
      4:if (M_line=1) or linecoincidenti then
        begin
        with m_p[1] do
        Vicino(px,py,os_temp,xm[1],ym[1],xm[2],ym[2],xu1,yu1,C_ang,C_dist);
(*cippo*) if not os_temp then Mess:='Tronco non realizzabile               '; {*TR*}
        end
        else Mess:='Selezionata piu` di una linea'; {*TR*}

      5:if (M_line=1) or linecoincidenti then
        begin
        with M_p[1] do
          begin
          os_temp:=true;
          r_1:=xm[1];
          r_2:=xm[2];
          px:={round}((r_1+r_2)/2);
          r_1:=ym[1];
          r_2:=ym[2];
          py:={round}((r_1+r_2)/2);
          end;
        end
        else Mess:='Selezionata piu` di una linea'; {*TR*}

      6:if (M_line=1) or linecoincidenti then   {caso spezza ; cippo}
        begin
         with m_p[1] do
         VicinoSP(px,py,os_temp,xm[1],ym[1],xm[2],ym[2],xu1,yu1,C_ang,C_dist);
         if not os_temp then Mess:='Tronco non realizzabile      '; {*TR*}{cippo}
        end
        else Mess:='Selezionata piu` di una linea'; {*TR*}



     20:if (M_line=1) or linecoincidenti then
        begin
         os_temp:=true;
         dist:=c_dist;
         with m_p[1] do
         begin
          if abs(ym[1]-ym[2])<10E-4 then             {orizzontale}
           begin
            if yp1 > ym[1] then
                           begin
                            c_ang:=0;
                            r_1:=ym[1];
                            r_1:=r_1+dist;
                            py:={round}(r_1)             { or.+su}
                           end
                          else
                           begin
                            c_ang:=pi;
                            r_1:=Ym[1];
                            r_1:=r_1-dist;
                            py:={round}(r_1);
                           end
            end
          else
          if abs(xm[1]-xm[2])<10E-4 then    {verticale}
           if xp1 > xm[1] then begin
                               c_ang:=pi/2;               { ver+sin}
                               r_1:=xm[1];
                               r_1:=r_1+dist;
                               px:={round}(r_1)
                              end
                         else begin
                                c_ang:=3*pi/2;
                                r_1:=xm[1];
                                r_1:=r_1-dist;
                                px:={round}(r_1);
                              end

         end;

        end
        else Mess:='Selezionata piu` di una linea'; {*TR*}


     21:if ( (M_line=1) or linecoincidenti) and (trovafinestra) then
        begin
         os_temp:=true;
         dist:=c_dist;
         with m_p[1] do
          begin
           if abs(ym[1]-ym[2])<10E-4 then             {orizzontale}
            begin
             if yp1 > ym[1] then
                            begin
                             c_ang:=0;
                             r_1:=ym[1];
                             r_1:=r_1+dist;   { or.+su}
                             py:={round}(r_1);
                             r_1:=xm[1];
                             r_2:=xm[2];
                             r_1:=(r_1+r_2)/2;
                             px:={round}(r_1)
                            end
                           else
                            begin
                             c_ang:=pi;
                             r_1:=ym[1];
                             r_1:=r_1-dist;   { or.+su}
                             py:={round}(r_1);
                             r_1:=xm[1];
                             r_2:=xm[2];
                             r_1:=(r_1+r_2)/2;
                             px:={round}(r_1)

                            end
            end
           else
            if abs(xm[1]-xm[2])<10E-4 then    {verticale}
             if xp1 > xm[1] then begin
                                  c_ang:=pi/2;
                                  r_1:=xm[1];              { ver+sin}
                                  r_1:=r_1+dist;
                                  px:={round}(r_1);
                                  r_1:=ym[1];
                                  r_2:=ym[2];
                                  r_1:=(r_1+r_2)/2;
                                  py:={round}(r_1)
                                end
                           else begin
                                  c_ang:=3*pi/2;
                                  r_1:=xm[1];              { ver+sin}
                                  r_1:=r_1-dist;
                                  px:={round}(r_1);
                                  r_1:=ym[1];
                                  r_2:=ym[2];
                                  r_1:=(r_1+r_2)/2;
                                  py:={round}(r_1)

                                end
          end;   {with}

        end
        else Mess:='Selezionata piu` di una linea'; {*TR*}


    end

  end
else
if mess='' then Mess:='Nessuna linea selezionata';{*TR*}




if os_temp then osnap_p:=true
{$Ifdef win}
{$else}
else write(chr(7));
{$Endif}

end;


Function Osn(Var P_x,P_y:real;xp,yp,xu,yu:real;codice:integer;Var mess:string):Boolean;

const MaxEpiante=20;
      MaxSez    =20;




type

    RecPiante = record
                    NomeP  : string[8];
                    ZPMin  : real;
                    ZPMax  : real;
                end;

    EPianteAr = array[1..maxEPiante] of RecPiante;


var  EPt       :EPianteAr;



Var X_s,Y_s:{integer pino} real;
    dimbox:real;
    trovato_p:boolean;
    tiposnap:integer;
    temp:real;
    i:integer;
    fept:file of epiantear;

begin
mess:='';
{initdeb;}
{deb('xp:',xp);
deb('yp:',yp);
deb('xu:',xu);
deb('xu:',xu);}
if codice=11 then tiposnap:=1;
if codice=2  then tiposnap:=2;
if codice=7  then tiposnap:=3;
if codice=8  then tiposnap:=4;
if codice=9  then tiposnap:=5;
if codice=10 then tiposnap:=6;{cippo spezza pianta aggiunto}
if codice=20  then tiposnap:=20;{cippo snap terminale-parete}
if codice=21  then tiposnap:=21;{cippo centratofinestra}


X_s:={round}(P_x-22717);
Y_s:={round}(P_y-17937);

if codice IN [2,7,20,21] then
  begin
  Xp:={round}(xp-22717);
  Yp:={round}(yp-17937);
  end;

if codice In[7,8,10{cippo}] then
  begin
  Xu:={round}(xu-22717);
  Yu:={round}(yu-17937);
  end;

if not sezione  and (nomepianta='')then
begin
  ZMax_P:=10E6;
  ZMin_P:=-10E6;
  if exist(Driveplt+'WORK.pnt') then
    begin
    assign(fept,DrivePlt+'WORK.pnt');
    reset(fept);
    read(fept,Ept);
    close(Fept);
  end
  else exit;
  {$ifdef win}
  messagebeep(10);
  {$endif}
  i:=1;
  repeat
    with EpT[i] do
    if nomeP<>'' then
    begin
      if (RisultCalc^.Quota*conf^.AltNum/40000>=ZPmin)and(RisultCalc^.Quota*conf^.AltNum/40000<=ZPmax) then
      begin
        Nomepianta:=NomeP;
        ZMax_P:=ZPmax*40000/conf^.AltNum;
        ZMin_P:=ZPmin*40000/conf^.AltNum;
      end;
     end;
     i:=I+1;
  until (i>MaxEPiante)or(Nomepianta<>'');
end;
if sezione then DimBox:=ze(1)-ze(0)
else DimBox:=xe(1)-xe(0);
dimBox:=dimBox*5{C_DimBox};
trovato_p:=osnap_p(X_s,Y_s,Tiposnap,round(DimBox),driveplt+NomePianta,
                   xp,yp,xu,yu,Mess);
if Trovato_p then
  begin              {-- da completare nel caso di sezione --}
  P_x:=X_s+22717;
  P_y:=Y_s+17937;
  end;
Osn:=trovato_p;

{closedeb;}
end;



end.
