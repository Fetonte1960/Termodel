{$R+}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

unit DisDim;

INTERFACE

uses definiz,halotp4,graph,diseg;

Procedure Disegna_dim(Vettore:Vetdim;setCol:integer);
procedure DimDlt(nOME,est1,est2:STRING);

{============================================================================}

Implementation

uses genproc;

Procedure Disegna_dim(Vettore:Vetdim;setCol:integer);
Var St1 : string ; (* cippo aggiunta var st1; necessario poichä st1 ä
                      dichiarata a livello superiore e crea problemi
                      con readcord(....,St1 )   *)

begin
if setcol<>0 then Vettore.Colore:=SetCol;

        if(
           ((Vettore.z1>=Zmin_p)and(Vettore.z1<=Zmax_p))or
           ((Vettore.z2>=Zmin_p)and(Vettore.z2<=Zmax_p)))
           then

          Case Vettore.Entita[1] of
  'L','F','*':begin
              setlnstyle(@Vettore.tlinea);
              real1:=xg1(Vettore.x1,Vettore.y1);
              real2:=yg1(Vettore.y1,Vettore.z1);
              movabs(@real1,@real2);
              real1:=xg1(Vettore.x2,Vettore.y2);
              real2:=yg1(Vettore.y2,Vettore.z2);
              setcolor(Vettore.colore);
              lnabs(@real1,@real2)
              end;
          'A':begin
              setlnstyle(@Vettore.tlinea);
              real1:=xg1(Vettore.x1,Vettore.y1);
              real2:=yg1(Vettore.y1,Vettore.z1);
              movabs(@real1,@real2);
              {$Ifdef win}
              getx:=round(real1);
              gety:=Round(real2);
              {$Endif}
              real1:=Vettore.x2;
              real2:=Vettore.y2;

              setcolor(Vettore.colore);
              if Not sezione Then
              real3:=xg1(Vettore.R,0)-Xg1(0,0)
              else real3:=Yg1(0,-Vettore.R)-Yg1(0,0);
              arc1(@real3,@Real1,@real2);
              end;
           'P':begin
              setlnstyle(@Vettore.tlinea);
              setcolor(Vettore.colore);
              PArc(Vettore,False);
              end;
           'C':begin
              setlnstyle(@Vettore.tlinea);
              real1:=xg1(Vettore.x1,Vettore.y1);
              real2:=yg1(Vettore.y1,Vettore.z1);
              movabsA(@real1,@real2);
              setcolor(Vettore.colore);
              If Not Sezione Then
              real3:=xg1(Vettore.R,0)-Xg1(0,0)
              else real3:=Yg1(0,-Vettore.R)-Yg1(0,0);
              cir(@Real3)
              end;
           'Q':begin
              setlnstyle(@Vettore.tlinea);
              setcolor(Vettore.colore);
              real1:=xg1(Vettore.x1,Vettore.y1);
              real2:=yg1(Vettore.y1,Vettore.z1);
              movTcurabs(@real1,@real2);
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
procedure DimDlt(nOME,est1,est2:STRING);
var filtro:boolean;
    Ingr_X,Ingr_Y,Spost_X,Spost_Y,xsp1,ysp1:real;
    Xinf_R,Yinf_R,Xsup_R,Ysup_R,XPrec_R,YPrec_R:integer;
    Fuori:boolean;


{------------------ DISLINEA ---------------------}
Procedure DisLinea;
   type dimrecdis=record mov:char;x,y:integer end;  { cippo Inserito x velocizzare}
        dimrecdisV=array[1..nhpgl]of dimrecdis;{ cippo dimensionato. mov e'  }
  { var  dimhpgl:^dimrecdisV;  }                 { char anziche boolean      }
{mov='0'=PU=true mov='1'=Pd=false mov='Z'=> x=z1 e y=z2
 mov='C=setcolor(x)=setcnstyle(y) cippo }


(*type recdis=record mov:boolean;x,y:integer end;
     RECDIS1=ARRAY[1..nhpgl]OF RECDIS; *)

   var {fdis:file of recdis;}
       FDIS1:FILE OF dimRECDISV;
       hpgl1:DimRECDISV;
       i:integer;

   BEGIN
  assign(fdis1,Nome+est1);
  reset(fdis1);

  while not eof(fdis1) do
   BEGIN
    READ(FDIS1,HPGL1);
(*    if    (((hpgl1[nhpgl-2].X>=Zmin_p)and(hpgl1[nhpgl-2].X<=Zmax_p))or
           ((hpgl1[nhpgl-2].Y>=Zmin_p)and(hpgl1[nhpgl-2].Y<=Zmax_p)))
    then if
        not (((hpgl1[nhpgl-1].X <XInf_R)and(hpgl1[nhpgl-1].X <XInf_R))or
            ((hpgl1[nhpgl-1].X >XSup_R)and(hpgl1[nhpgl-1].X >XSup_R))or
            ((hpgl1[nhpgl].Y <YInf_R)and(hpgl1[nhpgl].Y <YInf_R))or
            ((hpgl1[nhpgl].Y >YSup_R)and(hpgl1[nhpgl].Y >YSup_R)))
         THEN
    BEGIN { leggi blocco}
    fuori :=true;*)
    for i:=1 to nhpgl do
     begin
      Case HPGL1[i].mov of

  '1': if filtro then
           Begin
            XPrec_R:=hpgl1[i].X;
            YPrec_R:=hpgl1[i].Y;
            fuori:=true;
           end;

  '0': if filtro then
           Begin
            if (fuori)and(
               ((hpgl1[i].X <XInf_R)and(XPrec_R <XInf_R))or
               ((hpgl1[i].X >XSup_R)and(XPrec_R >XSup_R))or
               ((hpgl1[i].Y <YInf_R)and(YPrec_R <YInf_R))or
               ((hpgl1[i].Y >YSup_R)and(YPrec_R >YSup_R)))  then
                begin
                 XPrec_R:=hpgl1[i].X;
                 YPrec_R:=hpgl1[i].Y;
                 fuori:=true;
                end
           else
                begin
                 if fuori then
                  begin

                   real1:=XPrec_R*ingr_X+Spost_X;
                   real2:=YPrec_R*ingr_Y+Spost_Y;

                   XPrec_R:=Round(real1);
                   YPrec_R:=Round(real2);
                  end;

                  real1:=hpgl1[i].X*ingr_X+Spost_X;
                  real2:=hpgl1[i].Y*ingr_Y+Spost_Y;

                  int1:=round(real1);
                  int2:=round(real2);

                  line(XPrec_R,YPrec_R,int1,int2);
                  XPrec_R:=int1;
                  YPrec_R:=int2;

                  Fuori:=false;
                end;
           end;

       'Z':Begin
        if(
           ((hpgl1[i].X>=Zmin_p)and(hpgl1[i].X<=Zmax_p))or
           ((hpgl1[i].Y>=Zmin_p)and(hpgl1[i].Y<=Zmax_p)))
           then filtro := true
           else filtro:=False;

           end;


       'C':Begin
            SEtcolor  (hpgl1[i].X);
            SEtlnStyle(@hpgl1[i].Y);
           end;

      end;  {endcase}
     end;   {endfor}
 {   end;    {blocco}
    end;    {endwhile}

  close(fdis1);


   END;


{--------------------  DISQUOTE ------------------------}
   PRocedure  DISQUOTE;



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
    assign(fqqv,Nome+est2);
    reset(fqqv);
    filtro:=false;
    r1:=xg1(costant^.altquo*70,0)-Xg1(0,0);
    r2:=1;
    psetta:=0;
    SetSText(@r1,@r2,@psetta);
    setcolor(costant^.colq);
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
                real1:=xg1(costant.altquo*70,0)-Xg1(0,0);
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


{------------------- D i m D L T ---------------}
BEGIN

  xsp1:=xsp;
  ysp1:=ysp;


  ingr_X :=xsp1/(xsup-xinf);
  spost_X:=(22717.0-Xinf)*xsp1/(xsup-xinf);
  ingr_Y :=-Ysp1/(Ysup-Yinf);
  spost_Y:=ysp1-(17937.0-Yinf)*Ysp1/(Ysup-Yinf)-s_up;

  Xinf_R:=Round(Xinf-22717);
  Yinf_R:=Round(Yinf-17937);
  Xsup_R:=Round(XSup-22717);
  Ysup_R:=Round(YSup-17937);


  Filtro :=false;
  DISLINEA;

  DISQUOTE;

  {$R+}
  {$S+}

END;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*}


end.