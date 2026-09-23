{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit novitDim;

INTERFACE

uses definiz,halotp4,graph,diseg,DEFUTI,strings,winprocs,wintypes;

Procedure Disegna_dim(Vettore:Vetdim;setCol:integer);
procedure DimDlt1{(nOME,est1,est2:STRING)};

{============================================================================}

Implementation

uses genproc,esiste;



Procedure Disegna_dim(Vettore:Vetdim;setCol:integer);
Var St1 : string ; (* cippo aggiunta var st1; necessario poichä st1 ä
                      dichiarata a livello superiore e crea problemi
                      con readcord(....,St1 )   *)
    ai,af:real;

begin
if setcol<>0 then Vettore.Colore:=SetCol;

        if(
           ((Vettore.z1>=Zmin_p)and(Vettore.z1<=Zmax_p))or
           ((Vettore.z2>=Zmin_p)and(Vettore.z2<=Zmax_p)))
           then

          Case Vettore.Entita[1] of
  'L','F','*':begin
              setlnstyle(@Vettore.tlinea);
              real1:=xg(Vettore.x1,Vettore.y1);
              real2:=yg(Vettore.y1,Vettore.z1);
              movabs1(@real1,@real2);
              real1:=xg(Vettore.x2,Vettore.y2);
              real2:=yg(Vettore.y2,Vettore.z2);
              setcolor(Vettore.colore);
              lnabs1(@real1,@real2)
              end;
(*          'A':begin
              setlnstyle(@Vettore.tlinea);
              real1:=xg(Vettore.x1,Vettore.y1);
              real2:=ysp-yg(Vettore.y1,Vettore.z1);
              {$ifdef win}
              getx:=round(real1);
              gety:=Round(real2);
              {$endif}
              real1:=Vettore.x2;
              real2:=Vettore.y2;

              setcolor(Vettore.colore);
              if Not sezione Then
              real3:=xg(Vettore.R,0)-Xg(0,0)
              else real3:=Yg(0,-Vettore.R)-Yg(0,0);
              arc1(@real3,@Real1,@real2);
              end;*)
           'P':begin
              setlnstyle(@Vettore.tlinea);
              setcolor(Vettore.colore);
              PArc(Vettore,False);
              end;
           'C':begin
              setlnstyle(@Vettore.tlinea);
              real1:=xg(Vettore.x1,Vettore.y1);
              real2:=yg(Vettore.y1,Vettore.z1);
              movabs1A(@real1,@real2);
              setcolor(Vettore.colore);
              If Not Sezione Then
              real3:=xg(Vettore.R,0)-Xg(0,0)
              else real3:=Yg(0,-Vettore.R)-Yg(0,0);
              cir(@Real3)
              end;
           'Q':begin
              setlnstyle(@Vettore.tlinea);
              setcolor(Vettore.colore);
              real1:=xg(Vettore.x1,Vettore.y1);
              real2:=yg(Vettore.y1,Vettore.z1);
              movabs1(@real1,@real2);
              int1:=round(Vettore.y2);
              real1:=xg1(costant^.altquo*70,0)-Xg1(0,0);
              real2:=1;
              st1:=OutTextN(Vettore.R,Vettore.X2);
              SetSText(@real1,@real2,@Int1);
              SText(@st1);
              end;

          end
end;

{------------------------- D I M D L T --------------------------}
procedure DimDlt1{(nOME,est1,est2:STRING)};


type DimDaDis = record
                 NProgettu   : string[8];
                 culuri      : integer;
                end;


var filtro:boolean;
    Ingr_X,Ingr_Y,Spost_X,Spost_Y,xsp1,ysp1,XPrec_R,YPrec_R:real;
    Xinf_R,Yinf_R,Xsup_R,Ysup_R:longint;
    Fuori:boolean;
    FND : file of dimdadis;
    principale : boolean;
    pr : string;
    arrisetta,i:integer;

{------------------ DISLINEA ---------------------}
Procedure DisTutto(nome:string);
(*   type dimrecdis=record mov:char;x,y:integer end;  { cippo Inserito x velocizzare}
        dimrecdisV=array[1..nhpgl]of dimrecdis;{ cippo dimensionato. mov e'  }
  { var  dimhpgl:^dimrecdisV;  }                 { char anziche boolean      }
{mov='0'=PU=true mov='1'=Pd=false mov='Z'=> x=z1 e y=z2
 mov='C=setcolor(x)=setcnstyle(y) cippo }*)


(*type recdis=record mov:boolean;x,y:integer end;
     RECDIS1=ARRAY[1..nhpgl]OF RECDIS; *)

type ldimrecdis=record mov:char;x,y:integer end;
  {   dimrecdisV=array[1..nhpgl]of dimrecdis;}

type qdimrecdis = record
                   setta :integer;
                   x,y   :integer;
                   valore:string[10];
                  end;

type cdimrecdis = record
                   raggio:integer;
                   x,y   :integer;
                  end;

type adimrecdis = record
                   raggio:integer;
                   x,y   :integer;
                   alfa1,alfa2 :integer;
                  end;

type Zdimrecdis = record
                   x,y   :integer;
                  end;

type Sdimrecdis = record {setta colore e tipo di linea}
                   x,y   :integer;
                  end;

type dimrecdis=record
                Case Tipo : char{Possibilita} of

                      'L' : (linea:ldimrecdis);
                      'Q' : (quota:qdimrecdis);
                      'A' : (arco :adimrecdis);
                      'C' : (Cerchio:cdimrecdis);
                      'Z' : (piano:zdimrecdis);
                      'S' : (cambia:sdimrecdis);
               end;

      dimrecdisV=array[1..nhpgl]of dimrecdis;

   var {fdis:file of recdis;}
       FDIS1:FILE OF dimRECDISV;
       hpgl1:DimRECDISV;
       i:integer;
       r1,r2 :real;
       rr1,rr2,rr3,ai,af :real;
       psetta : integer;
       xyg100:real;
{ Procedure dlinea;
 begin


 end;

 Procedure dquote;
 begin


 end;

 Procedure darco;
 begin


 end;


 Procedure dcerchio;
 begin


 end;

 Procedure daltezza;
 begin


 end;

 Procedure dsetta;
 begin



 end;}
var fmdeb:text;
    vdim:vetdim;
    fdim:file of vetdim;

BEGIN
{assign(fdim,copy(nome,1,length(nome)-3)+'dim');
reset(fdim);
while not eof(fdim) do
begin
  read(fdim,vdim);
  disegna_dim(vdim,15);
end;
close(fdim);
}

assign(fmdeb,'c:\debug.txt');
rewrite(fmdeb);
r1:=xg1(costant^.altquo*65,0)-Xg1(0,0);
r2:=1;
psetta:=0;
SetSText(@r1,@r2,@psetta);
if principale then setcolor(costant^.colq);
if Not sezione Then  xyg100:=Xg1(0,0)
               else  xyg100:=Yg1(0,0);
assign(fdis1,Nome);
reset(fdis1);

while not eof(fdis1) do
 BEGIN
  READ(FDIS1,HPGL1);

   for i:=1 to nhpgl do
    begin
     Case HPGL1[i].tipo of

{-------------- linea --------------------------}

     'L': Case HPGL1[i].linea.mov of

           '1': if filtro then
                  Begin
                   XPrec_R:=hpgl1[i].linea.X;
                   YPrec_R:=hpgl1[i].linea.Y;
                   fuori:=true;
                  end;

           '0': if filtro then
                  Begin
                   if (fuori)and(
                      ((hpgl1[i].linea.X <XInf_R)and(XPrec_R <XInf_R))or
                      ((hpgl1[i].linea.X >XSup_R)and(XPrec_R >XSup_R))or
                      ((hpgl1[i].linea.Y <YInf_R)and(YPrec_R <YInf_R))or
                      ((hpgl1[i].linea.Y >YSup_R)and(YPrec_R >YSup_R)))  then
                    begin
                     XPrec_R:=hpgl1[i].linea.X;
                     YPrec_R:=hpgl1[i].linea.Y;
                     fuori:=true;
                    end
                   else
                    begin
                     if fuori then
                      begin
                       real1:=XPrec_R*ingr_X+Spost_X;
                       real2:=YPrec_R*ingr_Y+Spost_Y;

                       XPrec_R:=real1;
                       YPrec_R:=real2;
                      end;

                     real1:=hpgl1[i].linea.X*ingr_X+Spost_X;
                     real2:=hpgl1[i].linea.Y*ingr_Y+Spost_Y;
                     {
                     int1:=round(real1);
                     int2:=round(real2);
                     }
                     {$ifdef win}
                     line(XPrec_R,YPrec_R,real1,real2);
                     {$else}
                     line(round(XPrec_R),round(YPrec_R),round(real1),round(real2));
                     {$endif}
                     XPrec_R:=real1;
                     YPrec_R:=real2;

                     Fuori:=false;
                    end;
                  end;
          end;  {endcase linea}

{------------------ quote   ----------------}
     'Q':if filtro then
           begin
               { setlnstyle(@Vettore.tlinea);
                setcolor(Vettore.colore);
                real1:=xg1(Vettore.x1,Vettore.y1);
                real2:=yg1(Vettore.y1,Vettore.z1);
                movTcurabs(@real1,@real2);
                int1:=round(Vettore.y2);
                real1:=xg1(costant^.altquo*70,0)-Xg1(0,0);
                real2:=1;       }
                rr1:=hpgl1[i].quota.X*ingr_X+Spost_X;
                rr2:=hpgl1[i].quota.Y*ingr_Y+Spost_Y;
                movTcurabs(@rr1,@rr2);
{                st1:=OutTextN(Vettore.R,Vettore.X2);}
                {
                if hpgl1[i].quota.setta<>psetta then
                   begin

                   writeln(fmdeb,r1);
                   r1:=xg1(costant^.altquo*70,0)-Xg1(0,0);
                   r2:=1;
                   SetSText(@r1,@r2,@psetta);

                   psetta:=hpgl1[i].quota.setta;
                   end;}
                r1:=xg1(costant^.altquo*65,0)-Xg1(0,0);
                r2:=1;
                SetSText(@r1,@r2,@hpgl1[i].quota.setta);
                SText(@hpgl1[i].quota.valore);
           end;

{------------------ archi --------------}
     'A': if filtro then
            begin
              {setlnstyle(@Vettore.tlinea);
              real1:=xg1(Vettore.x1,Vettore.y1);
              real2:=yg1(Vettore.y1,Vettore.z1);
              movabs(@real1,@real2);}
              rr1:=hpgl1[i].arco.X*ingr_X+Spost_X;
              rr2:=hpgl1[i].arco.Y*ingr_Y+Spost_Y;
              if (rr1>-32000) and (rr1<32000) and (rr2>-32000) and (rr2<32000) then
              begin
                movabs(@rr1,@rr2);

                {$Ifdef win}
                getx:=round(rr1);
                gety:=Round(rr2);
               {$Endif}

                if Not sezione Then rr3:=hpgl1[i].arco.Raggio*ingr_X
                                       +Spost_X-Xyg100;

                int1:=round(rr3);
                if int1<1 then int1:=1;
                {$ifdef dos} {Sistemare per windows messieur}
                arc(getx,gety,hpgl1[i].arco.alfa1,hpgl1[i].arco.alfa2,int1);
                {$endif}
                {$ifdef win}
                ai:=hpgl1[i].arco.alfa1/180*pi;
                af:=hpgl1[i].arco.alfa2/180*pi;
                d_arc(rr1,rr2,ai,af,rr3);
                {$endif}
              end;
            end;
{------------------ cerchi -------------}
     'C':if filtro then
            begin
              rr1:=hpgl1[i].cerchio.X*ingr_X+Spost_X;
              rr2:=hpgl1[i].cerchio.Y*ingr_Y+Spost_Y;
              if (rr1>-32000) and (rr1<32000) and (rr2>-32000) and (rr2<32000) then
              begin
                movabs(@rr1,@rr2);
                {$Ifdef win}
                getx:=round(rr1);
                gety:=Round(rr2);
                {$Endif}
                if Not sezione Then rr3:=hpgl1[i].cerchio.Raggio*ingr_X
                                       +Spost_X-Xyg100;
                int1:=round(rr3);
                if int1<1 then int1:=1;
                circle(getx,gety,int1);
              end;
            end;
{------------------ altezza ----------------}
     'Z':if(
           ((hpgl1[i].piano.X>=Zmin_p)and(hpgl1[i].piano.X<=Zmax_p))or
           ((hpgl1[i].piano.Y>=Zmin_p)and(hpgl1[i].piano.Y<=Zmax_p)))
           then filtro := true
           else filtro:=False;



{---------------- settaggio colore e tipo di linea --------}
     'S':begin
          if principale then SEtcolor  (hpgl1[i].cambia.X);
          SEtlnStyle(@hpgl1[i].cambia.Y);
         end;


     end;  {endcase }

  end;   {endfor}
 end;    {endwhile}

  close(fdis1);
  close(fmdeb);

END;

(*
{--------------------  DISQUOTE ------------------------}
   PRocedure  DISQUOTE(nome:string);



   type qdimrecdis = record
                      setta :integer;
                      x,y   :integer;
                      valore:string[10];
                     end;
       Vqdimrecdis = array[1..Nhpgl] of qdimrecdis;

   var    fqqV : file of Vqdimrecdis;
          qbufV: Vqdimrecdis;
          r1,r2 :real;
          rr1,rr2 :real;
          psetta : integer;
          i:integer;

   BEGIN
    assign(fqqv,Nome);
    reset(fqqv);
    filtro:=false;
    r1:=xg1(costant^.altquo*70,0)-Xg1(0,0);
    r2:=1;
    psetta:=0;
    SetSText(@r1,@r2,@psetta);
    if principale then setcolor(costant^.colq);
    if (r1*100/abs(xsup_r-xinf_r)) > 6*10e-04 then
    BEGIN
     while not eof(fqqv) do
     BEGIN
      read(fqqv,qbufv);
      for i:=1 to nhpgl do

      if qbufv[i].valore = 'ZZZ'
          then    if(
                 ((qbufv[i].X>=Zmin_p)and(qbufv[i].X<=Zmax_p))or
                 ((qbufv[i].Y>=Zmin_p)and(qbufv[i].Y<=Zmax_p)))
                 then filtro := true
                 else filtro:=False
          else
           if filtro then
           begin
               { setlnstyle(@Vettore.tlinea);
                setcolor(Vettore.colore);
                real1:=xg1(Vettore.x1,Vettore.y1);
                real2:=yg1(Vettore.y1,Vettore.z1);
                movTcurabs(@real1,@real2);
                int1:=round(Vettore.y2);
                real1:=xg1(costant^.altquo*70,0)-Xg1(0,0);
                real2:=1;       }
                rr1:=qbufv[i].X*ingr_X+Spost_X;
                rr2:=qbufv[i].Y*ingr_Y+Spost_Y;
                movTcurabs(@rr1,@rr2);
{                st1:=OutTextN(Vettore.R,Vettore.X2);}
                if qbufv[i].setta<>psetta then
                   begin
                   SetSText(@r1,@r2,@qbufv[i].setta);
                   psetta:=qbufv[i].setta;
                   end;
                SText(@qbufv[i].valore);
           end;

     end; {endwhile}
    end;
    close(fqqv);
   END;

*)
{------------------- D i m D L T ---------------}
BEGIN

  xsp1:=xsp;
  ysp1:=ysp;


  ingr_X :=xsp1/(xsup-xinf);
  spost_X:=(22717.0-Xinf)*xsp1/(xsup-xinf);
  ingr_Y :=-Ysp1/(Ysup-Yinf);
  spost_Y:=ysp1-(17937.0-Yinf)*Ysp1/(Ysup-Yinf)-s_up;

  {$R-}
  Xinf_R:=Round(Xinf-22717);
  Yinf_R:=Round(Yinf-17937);
  Xsup_R:=Round(XSup-22717);
  Ysup_R:=Round(YSup-17937);
  {$R+}

  Filtro :=false;
  for i:=1 to naggdis do
  with vaicoldim^[i] do
          begin
            if nprogettu<>'' then
               begin
                 principale:= (culuri = 0);
                 If not principale then setcolor(culuri);
                 pr := setleft(setright(nprogettu));
                 {pr := format(pr,lenght(pr));}


                 if (not sezione) and
                    (exist(driveprog+pr+'.Dlp') ) {and
                    (exist(Datadrive+'progetti\'+pr+'.qqp') )} then
                  begin
                   distutto(driveprog+pr+'.Dlp');
                  { dislinea(Datadrive+'progetti\'+pr+'.Dlp');
                   disquote(Datadrive+'progetti\'+pr+'.qqp'); }
                  end;



                 if (sezione) and
                    (exist(driveprog+pr+'.Dls') ) {and
                    (exist(Datadrive+'progetti\'+pr+'.qqs') )} then
                  begin
                   distutto(driveprog+pr+'.Dls');

{                   dislinea(Datadrive+'progetti\'+pr+'.Dls');
                   disquote(Datadrive+'progetti\'+pr+'.qqs');}
                  end;



               end;
          end;
 if not principale then
        begin
                 principale := true;
                 if (not sezione) and
                    ( exist(driveprog+nomeprog+'.Dlp') ) {and
                     ( exist(Datadrive+nomeprog+'.qqp') )} then
                     begin
                      distutto(driveprog+nomeprog+'.Dlp');

{                      dislinea(Datadrive+nomeprog+'.Dlp');
                      disquote(Datadrive+nomeprog+'.qqp');}
                     end ;

                 if (sezione) and
                    ( exist(driveprog+nomeprog+'.Dls') ) {and
                     ( exist(Datadrive+nomeprog+'.qqs') )} then
                  begin
                   distutto(driveprog+nomeprog+'.Dls');

{                   dislinea(Datadrive+nomeprog+'.Dls');
                   disquote(Datadrive+nomeprog+'.qqs');}
                  end

      end;
 SetTextStyle(0,0,1);
 Settextjustify(0,0);
 arrisetta:=1;
 setlnstyle(@arrisetta);


  {$R+}
  {$S+}

END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*}


end.