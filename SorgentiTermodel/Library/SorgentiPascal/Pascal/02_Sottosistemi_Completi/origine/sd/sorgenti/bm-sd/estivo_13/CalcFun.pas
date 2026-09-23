{$R+}    {Range checking on}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$O+}
{$F+}
Unit CALCFUN;

Interface

Uses
CopiaVariabiligenerali,
Varcarichi,Varcarichi_estivo_14,
sysutils,
CopiaLibreriaGenerale;
//  crt,
//  dos,
//  defutig,
//  utigen,
//  {$ifdef delphi}
//   sysutils,
//{$endif}

//definiz,
//  {$ifdef calcoli}
//  CALCUTID,
//  {$else}
//  uwrite,
//  {$endif}
//  inpdati,

//  WM;


FUNCTION Interpola(X,Y:REAL):REAL;

FUNCTION TRANSFER_TAB(FileName:ST80;Modo:CHAR):INTEGER;


FUNCTION COMBR(H,M,E,F:INTEGER):REAL;

FUNCTION NH(H,M,E:INTEGER):REAL;

FUNCTION TI(M,Z:INTEGER):REAL;


FUNCTION TImmComp(M,Z:INTEGER):REAL;


FUNCTION TImmCompBU(M,Z:INTEGER):REAL;


FUNCTION PWS(T:REAL):REAL;


FUNCTION WSBX(T:REAL):REAL;


FUNCTION UImmComp(M,Z:INTEGER):REAL;


FUNCTION TDA(M,Z:INTEGER):REAL;


FUNCTION CP(M,Z:INTEGER):REAL;


FUNCTION CVAP(M,Z:INTEGER):REAL;


FUNCTION IDR(H,M,E:INTEGER):REAL;


FUNCTION IDF(H,M,E:INTEGER):REAL;


FUNCTION AD(H,M,E:INTEGER):REAL;


FUNCTION TD(H,M,E:INTEGER):REAL;

FUNCTION QIW(H,M,E,F:INTEGER):REAL;

FUNCTION ROEst(M,Z:INTEGER):REAL;

FUNCTION ROVENT(M,Z:INTEGER):REAL;

FUNCTION USEst(M,Z:INTEGER):REAL;

procedure Scrivi_real(Amb:PuntCalc;Tipo:st1;NomeFile:string);

procedure Leggi_real(Amb:PuntCalc;Tipo:st1;NomeFile:string);

procedure Scrivi_tab(Amb:PuntCalc;Tipo:st1;NomeFile:string);

procedure Leggi_tab(Amb:PuntCalc;Tipo:st1;NomeFile:string);

procedure Init_PCalc;

procedure memoria;

function IndLocNRis(Codice:real):integer;
{Function TrasmFin(IndF:integer): real;}


{===========================================================================}

Implementation


procedure Init_PCalc;
var i:integer;

begin
   new(ArCalc);

   for i:=1 to Nambienti do new(ArCalc^[i]);
   for i:=Nambienti+1 to MaxPointAmb do ArCalc^[i]:=nil;

end;


procedure Scrivi_real(Amb:PuntCalc;Tipo:st1;NomeFile:string);
var i:integer;
    fr:file of Real;
begin
   for i:=1 to NAmbienti do
    case Tipo[1] of
      'P' :begin
           assign(fr,NomeFile);
           rewrite(fr);
           write(fr,Amb^[i]^.PVent);
           close(fr);
           end;
      //'I' : write(fr,Amb^[i]^.InsTotInv);
      //'Q' : write(fr,Amb^[i]^.QcTotInv);
      'W' :begin
           assign(fr,NomeFile);
           rewrite(fr);
           write(fr,Amb^[i]^.w1);
           close(fr);
           end;
    end;
end;


procedure Leggi_real(Amb:PuntCalc;Tipo:st1;NomeFile:string);
var i:integer;
    fr:file of Real;
begin
   assign(fr,NomeFile);
   reset(fr);
   i:=0;
   while not eof(fr) do
    begin
      i:=i+1;
      case Tipo[1] of
         'P' : read(fr,Amb^[i]^.PVent);
         'I' : read(fr,Amb^[i]^.InsTotInv);
         'Q' : read(fr,Amb^[i]^.QcTotInv);
         'W' : read(fr,Amb^[i]^.w1);
      end;
    end;
   close(fr);
   if i <> Nambienti then writemessage('calcolo.msg',2); { mettere messaggio di errore }
end;

procedure Scrivi_tab(Amb:PuntCalc;Tipo:st1;NomeFile:string);
var i:integer;
    fg:file of CarichiMax;
    fp:file of PotenzeMax;
begin
   case Tipo[1] of
    'C':begin
           assign(fg,NomeFile);
           rewrite(fg);
           for i:=1 to NAmbienti do
           write(Fg,ArCalc^[i]^.CTM);
           close(fg);
        end;
    'P':begin
           assign(fp,NomeFile);
           rewrite(fp);
           for i:=1 to NAmbienti do
           write(fp,ArCalc^[i]^.PTM);
           close(fp);
        end;
   end;
end;

procedure Leggi_tab(Amb:PuntCalc;Tipo:st1;NomeFile:string);
var i:integer;
    fg:file of CarichiMax;
    fp:file of PotenzeMax;
begin
   case Tipo[1] of
    'C':begin
           assign(fg,NomeFile);
           reset(fg);
           i:=0;
           while not eof(fg) do
            begin
               i:=i+1;
               read(fg,ArCalc^[i]^.CTM);
            end;
           close(fg);
        end;
    'P':begin
           assign(fp,NomeFile);
           reset(fp);
           i:=0;
           while not eof(fp) do
            begin
               i:=i+1;
               read(fp,ArCalc^[i]^.PTM);
            end;
           close(fp);
        end;
    end;
     if i <> Nambienti then writemessage('calcolo.msg',2); { mettere messaggio di errore }
end;


{$I Tab31}
{$I Tab32}
{$I Tab33}
FUNCTION TRANSFER_TAB(FileName:ST80;Modo:CHAR):INTEGER;

VAR
  FL:FILE OF TabInterp;
  IOERR,N,i,j:INTEGER;
  ft:text;
BEGIN

filename:=uppercase(Filename);
if filename='TAB31' then
for i:=0 to dim_x do for j:=0 to dim_y do Tabc0^[i,j]:=tab31[i,j]
else if filename='TAB32'
then for i:=0 to dim_x do for j:=0 to dim_y do Tabc0^[i,j]:=tab32[i,j]
else if filename='TAB33' then
for i:=0 to dim_x do for j:=0 to dim_y do Tabc0^[i,j]:=tab33[i,j];
(*
  Modo:=UPCASE(Modo);
  ASSIGN(FL,FileName+'.ASH');
  IF Modo='L' THEN RESET(FL) ELSE REWRITE(FL);

  IOERR:=IOresult;
 IF Modo='L' THEN
 READ(FL,TabC0^)
 ELSE
 WRITE(FL,TabC0^)  ;
 IOERR:=IOresult;
 TRANSFER_TAB:=IOERR;
 CLOSE(FL);

 assign(ft,FileName+'.Pas');
 rewrite(ft);
 writeln(ft,'Const '+Filename+':ARRAY[0..Dim_X,0..Dim_Y] of REAL=(');
 for i:=0 to dim_X do
   begin
   write(ft,'(');
     for j:=0 to Dim_Y do
     begin
     write(ft,float_to_str(Tabc0^[i,j],4));
     if j<>Dim_y then write(ft,',');
     end;
   write(ft,')');
   if i<>Dim_x then write(ft,',');
   writeln(ft,'');
   end;
 writeln(ft,');');
 close(ft);
 *)
END;    { PROC. TRANSFER_TAB }

{-----------------------------  Interpola  -----------------------------------}

FUNCTION Interpola(X,Y:REAL):REAL;


VAR
  RAX,RBX,RAY,RBY,I,J:INTEGER;
  R1,R2,RC:REAL;
BEGIN
  RBX:=1;    RBY:=1;
  WHILE (X>TabC0^[RBX,0]) AND (RBX<DIM_X) DO RBX:=RBX+1;
  IF RBX=1 THEN RBX:=2;
  RAX:=RBX-1;
  WHILE (Y>TabC0^[0,RBY]) AND (RBY<DIM_Y) DO RBY:=RBY+1;
  IF RBY=1 THEN RBY:=2;
  RAY:=RBY-1;

  IF TabC0^[RBX,0]=X THEN
  BEGIN
    R1:=TabC0^[RBX,RAY];
    R2:=TabC0^[RBX,RBY];
  END
  ELSE
  BEGIN
    RC:=(X-TabC0^[RAX,0])/(TabC0^[RBX,0]-X);
    R1:=(RC*TabC0^[RBX,RAY]+TabC0^[RAX,RAY])/(1+RC);
    R2:=(RC*TabC0^[RBX,RBY]+TabC0^[RAX,RBY])/(1+RC);
  END;

  IF (RBY>1) AND (TabC0^[0,RBY]=0) THEN Interpola:=R1
  ELSE
    IF (TabC0^[0,RBY]=Y) THEN Interpola:=R2
    ELSE
    BEGIN
      RC:=(Y-TabC0^[0,RAY])/(TabC0^[0,RBY]-Y);
      Interpola:=(RC*R2+R1)/(1+RC);
    END;
END;     { FUNC.  Interpola }


{----------------------------------  COMBR  ----------------------------------}


FUNCTION COMBR(H,M,E,F:INTEGER):REAL;

const ET:array[1..12] of real
        = (-2.8,-3.47,-1.87,0.27,0.82,-0.35,-1.55,-0.06,1.87,3.85,3.45,0.4);
VAR
  LST,LST2,HA,HAesp:REAL;
  Alfa,Beta,AST:REAL;
  c,OS,HON,OD,OL,HVN:REAL;
  V,Sfin:REAL;
  notomb:boolean;

BEGIN
{
   // caricamento di informazioni per il calcolo
   Finestre_d^[i].Shading := Finestre_d^[i].ShadingSchermo + Finestre_d^[i].shadingVetro;
   Finestre_d^[i].PosizSchermo := Finestre_d^[i].TipoSchermatura;
   Finestre_d^[i].Rientranza := 0;
   Finestre_d^[i].DOrizz := Finestre_d^[i].DistBalcomi;
   Finestre_d^[i].LOrizz :=Finestre_d^[i].ProfBalconi;
   Finestre_d^[i].LVertSX := Finestre_d^[i].ProfVerticaleSx;
   Finestre_d^[i].LVertDX := Finestre_d^[i].ProfVerticaleDx;
   Finestre_d^[i].DVertSX := Finestre_d^[i].DistVerticaleSx;
   Finestre_d^[i].DVertDX := Finestre_d^[i].DistVerticaleDx;
 }


  WITH FINESTRE_D^[F]{.fin_cart} DO
  NOTOMB:=(RIENTRANZA=0)  AND
          (LORIZZ=0)      AND
          (LVERTDX=0)     AND
          (LVERTSX=0);

  IF F=0 THEN
  BEGIN
    Combr:=1;
    EXIT;
  END;
  c:=PI/180;

  IF                                    (R3^[H,M] <= 0.01) OR
                                                     (F=0) OR
                                                  (NOTOMB) OR
     ((Finestre_D^[F]{.fin_cart}.Altezza*Finestre_D^[F]{.fin_cart}.Larghezza)=0) THEN Combr:=1

  ELSE
      WITH Finestre_D^[F]{.fin_cart} DO
      BEGIN
        IF Esposizioni_D^[E].Inclin = 90 THEN
        BEGIN
            LST2:=15*(H-12);
            LST:=LST2;
            IF M IN [Localita_D^.OraLegInizio..Localita_D^.OraLegFine] THEN LST:=LST-15;
            AST:=LST+ET[M]+Localita_D^.MeridRifOra-Localita_D^.LON;
            HA:=AST*c;

            HAesp:=Esposizioni_D^[E].Orient*c;
            V:=COS(HAesp-HA);
            IF ABS(V)>0.01 THEN
              BEGIN
                Alfa:=SIN(HAesp-HA)/V;
                IF Alfa >=0 THEN
                 BEGIN
                   OS:=LVertSX*Alfa;
                   HON:=Larghezza-OS+DVertSX;
                 END
                ELSE BEGIN
                       OD:=-LVertDX*Alfa;
                       HON:=Larghezza-OD+DVertDX;
                     END;
               IF HON > Larghezza THEN HON:=Larghezza;
                HON:=HON-Rientranza*ABS(Alfa);          IF HON < 0 THEN HON:=0;
             END
             ELSE HON:=Larghezza;
             V:=R3^[H,M];
             IF ABS(V)>0.01 THEN
             BEGIN
               Beta:=V/SQRT(1-SQR(V));
               OL:=LOrizz*ABS(Beta);
               HVN:=Altezza-OL+DOrizz;
               IF HVN > Altezza THEN HVN:=Altezza;
               HVN:=HVN-Rientranza*ABS(Beta);
               IF HVN < 0 THEN HVN:=0;
            END
            ELSE HVN:=Altezza;

            Combr:=HON*HVN/(Altezza*Larghezza);
        END  {IF INCLINAZIONE=90}
        ELSE BEGIN
               V:=R3^[H,M];
               IF V>0 THEN
               BEGIN
                 OL:=Rientranza*SQRT(1-SQR(V))/V;
                 Sfin:=SuperfUnit;
                 IF Sfin = 0 THEN  Sfin:=Altezza*Larghezza;
                 HON:=SQRT(Sfin)-OL;
                 IF HON < 0 THEN HON:=0;
                 Combr:=HON*HON/Sfin;
              END
              ELSE Combr:=1;
            END;
   END;    { WITH Finestre_D^........ }

END;    { FUNC.  COMBR }


{-----------------------------------  NH  ------------------------------------}

FUNCTION NH(H,M,E:INTEGER):REAL;

VAR
  k,AL,BE,GA:REAL;
BEGIN
  k:=PI/180;
  WITH Esposizioni_D^[E] DO
  BEGIN
                             { FST=angolo azimuth     SND=inclinazione }
    AL:=COS(Inclin*k);
    BE:=SIN(Orient*k)*SIN(Inclin*k);
    GA:=COS(Orient*k)*SIN(Inclin*k);
  END;

  NH:=AL*R3^[H,M]+BE*R1^[H,M]+GA*R2^[H,M];
END;    { FUNC.  NH }


{------------   TI (temperatura interna compensata) -------------------------}


FUNCTION TI(M,Z:INTEGER):REAL;


var a:real;

BEGIN

  WITH Localita_D^ DO

  a:=(((TMAXBS[M]-TInvEsternaBS)/(TEstEsternaBS-TInvEsternaBS))*
          (Zone_D^[Z].TEst-Zone_D^[Z].TInv))+Zone_D^[Z].TInv;
  TI:=a;

END;    { FUNC. TI }

{------------   TImmComp (temperatura di immissione compensata) -------------------}


FUNCTION TImmComp(M,Z:INTEGER):REAL;


var a:real;

BEGIN

  WITH Localita_D^ DO

  a:=     (((TMAXBS[M]-TInvEsternaBS)/(TEstEsternaBS-TInvEsternaBS))*
          (Zone_D^[Z].TImmEst-Zone_D^[Z].TImmInv))+Zone_D^[Z].TImmInv;

  TImmComp:=a;

END;    { FUNC. TImmComp }

{------------   TImmCompBU (temperatura di immissione compensata BU) --------}


FUNCTION TImmCompBU(M,Z:INTEGER):REAL;


var a:real;

BEGIN

  WITH Localita_D^ DO

  a:=     (((TMAXBS[M]-TInvEsternaBS)/(TEstEsternaBS-TInvEsternaBS))*
          (Zone_D^[Z].TImmEstBU-Zone_D^[Z].TImmInvBU))+Zone_D^[Z].TImmInvBU;

  TImmCompBU:=a;


END;    { FUNC. TImmCompBU }

{----------------------------------   PWS   ----------------------------------}

FUNCTION PWS(T:REAL):REAL;


VAR
     T2,T3:REAL;

BEGIN
  T:=T+273.15;
  T2:=T*T;
  T3:=T2*T;
  IF T-273.15<0 THEN
  BEGIN
    PWS:=EXP(-5674.5359/T
             +6.3925247
             -0.9677843E-2  *T
             +0.62215701E-6 *T2
             +0.20747825E-8 *T3
             -0.9484024E-12 *T*T3
             +4.1635019 *Ln(T)         );
  END
  ELSE
  BEGIN
    PWS:=EXP(-5800.2206/T
             +1.3914993
             -0.048640239   *T
             +0.41764768E-4 *T2
             -0.14452093E-7 *T3
             +6.5459673 *Ln(T)         );
  END;

END;    { FUNC.  PWS }

{----------------------------------  WSBX  -----------------------------------}


FUNCTION WSBX(T:REAL):REAL;


VAR WS:REAL;

BEGIN

  WS:=PWS(T);
  WSBX:=0.62198*(WS/(PATM-WS));                         {** 6.8 (20) **}

END;    { FUNC. WSBX }

{------------   UImmComp (umidita` di immissione  compensata) ---------------------}


FUNCTION UImmComp(M,Z:INTEGER):REAL;


var TImm,TImmBU,WSBU,WImm:real;

BEGIN

    TImm:=TImmComp(M,Z);

    TImmBU:=TImmCompBU(M,Z);

    WSBU:=WSBX(TimmBU);                                  {** 6.8 (21) **}
    WImm:=((2501-2.381*TImmBU)*WSBU-(Timm-TImmBU)) /     {** 6.9 (33) **}
                  ( 2501+1.805*TImm-4.186*TImmBU);
    UImmComp:=WImm/(1+WImm);                             {** 6.4 (8)  **}


END;    { FUNC. UImmComp }


{------------------- TDA (temperatura di rugiada compensata) --------------}


FUNCTION TDA(M,Z:INTEGER):REAL;


VAR
   WSBU,WImm,Pw,Alf:REAL;

BEGIN

  WSBU:=WSBX(TimmCompBU(M,Z));                           {** 6.4 (8)  **}


                                                         {** 6.9 (33) **}
  WImm:=((2501-2.381*TImmCompBU(M,Z))*WSBU-(TimmComp(M,Z)-TImmCompBU(M,Z))) /
                          ( 2501+1.805*TImmComp(M,Z)-4.186*TImmCompBU(M,Z));

  Pw:=PATM*WIMM/(0.62198+WIMM);                          {**  6.8 (20) **}
  Alf:=ln(Pw);
  TDA:=-35.957-1.8726*Alf+1.1689*sqr(Alf);               {**  6.9 (35) **}

END;

{------------------------        CP            ----------------------------}


FUNCTION CP(M,Z:INTEGER):REAL;


BEGIN

   CP:=0.237*4186;

END;

{------------------------        CVAP          ----------------------------}


FUNCTION CVAP(M,Z:INTEGER):REAL;


BEGIN

   CVAP:=2453.48-2.368*(TI(M,Z)-20);

END;

{--------------------------  IDR  -----------------------------------------}


FUNCTION IDR(H,M,E:INTEGER):REAL;


VAR

  k,AL,BE,GA,NH,YS:REAL;

BEGIN

  k:=PI/180;
  IF Esposizioni_D^[E].Inclin<>180 THEN
  BEGIN
    WITH Esposizioni_D^[E] DO
    BEGIN
                               { FST=angolo azimuth     SND=inclinazione }
      AL:=COS(Inclin*k);
      BE:=SIN(Orient*k)*SIN(Inclin*k);
      GA:=COS(Orient*k)*SIN(Inclin*k);
    END;

    NH:=AL*R3^[H,M]+BE*R1^[H,M]+GA*R2^[H,M];

    if NH <= 0.0 then IDR:=0
                 else IDR:=IDN^[H,M]*NH*Localita_D^.FattFoschia;
  END
  ELSE
    IDR:=0;
END;   { FUNC.  IDR }

{--------------------------  IDF  --------------------------}


FUNCTION IDF(H,M,E:INTEGER):REAL;


const C : array[1..12] of real
        = (0.058,0.060,0.071,0.097,0.121,0.134,0.136,0.122,0.092,0.073,0.063,0.057);

VAR
  k,AL,UU,BE,GA,IDR,NH,YS:REAL;

BEGIN
  k:=PI/180;

  IF Esposizioni_D^[E].Inclin<>180 THEN
  BEGIN
    WITH Esposizioni_D^[E] DO
    BEGIN
                               { FST=angolo azimuth     SND=inclinazione }
      AL:=COS(Inclin*k);
      UU:=SIN(Inclin*k);
      BE:=SIN(Orient*k)*SIN(Inclin*k);
      GA:=COS(Orient*k)*SIN(Inclin*k);
    END;

    NH:=AL*R3^[H,M]+BE*R1^[H,M]+GA*R2^[H,M];

    if NH <= 0.0 then IDR:=0
                 else IDR:=IDN^[H,M]*NH*Localita_D^.FattFoschia;
    if NH > -0.2 then YS:=0.55+0.437*NH+0.313*sqr(NH)
                 else YS:=0.45;

    IDF:=IDN^[H,M]/Localita_D^.FattFoschia*((C[M]*AL)+
         ((C[M]*YS+0.5*Localita_D^.Riflettivita*(C[M]+R3^[H,M]))*UU));
  END
  ELSE
    IDF:=0;
END;    { FUNC. IDF }



{-----------------------------------  AD  ------------------------------------}


FUNCTION AD(H,M,E:INTEGER):REAL;


const AB : array[0..5] of real
         = (0.01154,0.77674,-3.94657,8.57881,-8.38135,3.01188);
VAR
  J:INTEGER;
  AdU,NhU,R:REAL;

BEGIN
  AdU:=0;
  NhU:=NH(H,M,E);
  R:=round(NhU*100);
  IF R > 0 THEN FOR J:=0 TO 5 DO AdU:=AdU+AB[J]*EXP(J*LN(NhU));
  AD:=AdU;
END;    { FUNC.  AD }

{-----------------------------------  TD  ------------------------------------}

FUNCTION TD(H,M,E:INTEGER):REAL;

const TR : array[0..5] of real
         = (-0.00885,2.71235,-0.62062,-7.07329,9.75995,-3.89922);
VAR
  J:INTEGER;
  TdU,NhU,R:REAL;
BEGIN
  TdU:=0;
  NhU:=NH(H,M,E);
  R:=round(NhU*100);
  IF R > 0 THEN FOR J:=0 TO 5 DO TdU:=TdU+TR[J]*EXP(J*LN(NhU));
  TD:=TdU;
END;    { FUNC.  AD }

{-----------------------------------  QIW  -----------------------------------}

FUNCTION QIW(H,M,E,F:INTEGER):REAL;

VAR
  CombrU,IdfU,IdrU,QTras,QAss:REAL;
BEGIN
  IF F=0 THEN BEGIN QIW:=0; EXIT; END;
  CombrU:=COMBR(H,M,E,F);
 // gotoxy(1,22);ClrEol;
 // str(CombrU:5:2,st_8);
 //gotoxy(1,22);writec(W_M(4)+' '+ST_8,43);  {' Combr = '}
  IdfU:=IDF(H,M,E);
  IdrU:=IDR(H,M,E);
  WITH Finestre_D^[F]{.fin_cart} DO
  BEGIN
    QTras:=Shading * (CombrU*IdrU*TD(H,M,E) + 2*IdfU*T0);
    QAss:=    0.32 * (CombrU*IdrU*AD(H,M,E) + 2*IdfU*A0);
{E}    IF UpString(PosizSchermo)=CH7 THEN QAss:=QAss*Shading;
    QIW:=(PercVetr/100) * (QTras+QAss);
  END;
END;    { FUNC. QIW }


{-------------------------------  ROEst  -------------------------------}

FUNCTION ROEst(M,Z:INTEGER):REAL;

VAR
  PWSX,W,NU:REAL;
BEGIN
  WITH Zone_D^[Z] DO
  BEGIN
    PWSX:=UEst*PWS(TI(M,Z))/100;
    W:=0.62198 * PWSX / (PATM-PWSX);
    NU:=(287055.0*(TEst+273.15)/PATM)*(1+1.6078*W);
    ROest:=1000*(1 + W) / NU;
  END;
END;     { FUNC. ROEst }

{-------------------------------  ROvent  -------------------------------}


FUNCTION ROVENT(M,Z:INTEGER):REAL;

VAR
  PWSX,W,NU:REAL;

BEGIN

  WITH Zone_D^[Z] DO

  BEGIN

    PWSX:=UEst*PWS(TImmComp(M,Z))/100;
    W:=0.62198 * PWSX / (PATM-PWSX);                         {** 6.8 (21) **}
    NU:=(287055.0*(TImmComp(M,Z)+273.15)/PATM)*(1+1.6078*W);
{    WRITELN('ROVENT:',1000*(1 + W) / NU);REPEAT UNTIL KEYPRESSED;}
    ROVent:=1000*(1 + W) / NU;

  END;

END;     { FUNC. ROVENT }

{-------------------------------  USEst  -------------------------------}


FUNCTION USEst(M,Z:INTEGER):REAL;

VAR
  PWSX,W:REAL;
BEGIN
  WITH Zone_D^[Z] DO
  BEGIN
    PWSX:=UEst * PWS(TI(M,Z)) / 100;
    W:=0.62198 * PWSX / (PATM-PWSX);
    USest:=W/(1+W);
  END;
END;     { FUNC. USEst }




{------------------ procedure memoria ---------------------------------------}


procedure memoria;
begin
end;

function IndLocNRis(Codice:real):integer;
var i:integer;
    Trovato:boolean;
begin
   i:=1;
   repeat
    with Ambienti_D^[i]^ do
     begin
        Trovato:=(Ambienti_D^[i]^.CodNum = floattostr(Codice));
        if not Trovato then i:=i+1;
    end;
   until Trovato or (i > NAmbienti);
  IndLocNRis:=i;
end;
{
Function TrasmFin(IndF:integer): real;
begin
   if finestre_d^[IndF].lineak = 0 then
     TrasmFin:=finestre_d^[IndF].trasmittanza
   else  TrasmFin:=finestre_d^[finestre_d^[IndF].lineak].trasmittanza;
end;
}
End.
