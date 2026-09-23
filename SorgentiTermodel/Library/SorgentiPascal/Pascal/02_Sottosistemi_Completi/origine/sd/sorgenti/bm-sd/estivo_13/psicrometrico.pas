unit Psicrometrico;

interface
Function CalcTBU(TBS,UR,Hmare:real):real;
FUNCTION CalcUS(T,UR:real):REAL;
PROCEDURE DetPATM(HMARE:real);
Function CalcTbs(Us,Ur:real):real;
Function CalcUR(TBs,TBU:real):Real;
Procedure InitPsicro(Quota:real);
Function CalcPortAria(T1,Ur1,T2,Ur2,Sens,Lat:real;Modo:Char):real;
Function CalcPortAriaInv(T1,T2,POt:real):real;
Function PotAriaInv(T1,T2,POt:real):Real;
Procedure PotAria(Portata,T1,UR1,T2,UR2:real;var sens,Lat:real);
Function POrtAriaVent(ricircolo,ricambio:real):real;

implementation
var
PATM:REAL;  { Pressione atmosferica }



{-------------------------------  DetPATM  -----------------------------------}
Procedure InitPsicro(Quota:real);
begin
DetPatm(Quota);
end;
PROCEDURE DetPATM(HMARE:real);
{ Determina valore pressione atmosferica in funzione dell'altezza sul mare }
CONST
  A:ARRAY[0..7] OF REAL    = (101325.0,95461.0,89874.0,79495.0,70108.0,61640.0,54020.0,47181.0);
  C:array[0..7] of integer = (0       ,500    ,1000   ,2000   ,3000   ,4000   ,5000   ,6000   );
VAR
  K,J:REAL;
  T:INTEGER;
  Trovato:boolean;
BEGIN
  T:=1;           Trovato:=false;

  while not Trovato do
   begin
      if T <= 7 then
       begin
          Trovato:=(HMare <= C[T]);
          if not Trovato then T:=T+1;
       end
      else Trovato:=true;
   end;

  PATM:=A[T-1]+ (HMare-C[T-1])/(C[T]-C[T-1]) * (A[T]-A[T-1]);

END;     { PROC.   DetPATM }

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
{-------------------------------  CalcUS  -------------------------------}


FUNCTION CalcUS(T,UR:real):REAL;

VAR
  PWSX,W:REAL;
BEGIN


PWSX:=UR * PWS(T) / 100;
W:=0.62198 * PWSX / (PATM-PWSX);
Result:=W/(1+W);

END;     { FUNC. CalcUS }

FUNCTION CalcPWdaUS(Us,Ur:real):REAL;

VAR
  PWSX,W:REAL;
BEGIN
W:=Us/(1-Us);
PWsX:=(W*Patm)/(0.62+w);
result:=Pwsx*100/Ur;
{
PWSX:=UR * PWS(T) / 100;
W:=0.62198 * PWSX / (PATM-PWSX);
Result:=W/(1+W);
}
END;     { FUNC. CalcUS }

{-------------------------------  CalcUsDaTBU  ---------------------------------}
Function CalcUSDaTBu(T,TBU:real):real;

VAR

  WSBU:REAL;
  W:REAL;
  Pw,Alf:real;

BEGIN
    WSBU:=WSBX(TBU);
    W:=((2501-2.381*TBU)*WSBU-(T-TBU))/
       ( 2501+1.805*T-4.186*TBU);
    result:=W / (1+W);
END;   { CalcUSDatbu }

Function CalcTBU(TBS,UR,Hmare:real):real;
Var W,t1,t2,TM,UsdaUr,UsdaTBU:real;
    ok:boolean;
    Count:integer;
Const ErroreMax=0.0001;
begin
if (tbs=0)and(UR=0) then
  begin
  result:=0;
  exit;
  end;
if ur>100 then ur:=100;
if ur<0 then ur:=0;
count:=0;
if (UR=100) then
  begin
  result:=TBS;
  exit;
  end;
detpatm(Hmare);
ok:=false;
UsDaUR:=CalcUS(TBS,Ur);
t1:=-15;t2:=TBS;
while (not ok)and(count<100) do
  begin
  inc(count);
  Tm:=(t1+t2)/2;
  USDaTBU:=CalcUsDaTBU(TBS,TM);
  if abs(USDaTBU-USDaUR)<ErroreMax then ok:=true
  else
  if  USDaTBU>USDaUR  then t2:=tm
  else t1:=tm
  end;
result:=TM;
end;

Function CalcTbs(Us,Ur:real):real;
Var T1,t2,Tm,PWS1,pws2:real;
    ok:boolean;
    Count:integer;
Const ErroreMax=1;
begin
count:=0;
ok:=false;
t1:=-15;t2:=50;
pws1:=CalcPwDaUs(Us,Ur);
while (not ok)and(count<100) do
  begin
  inc(count);
  Tm:=(t1+t2)/2;
  pws2:=PWS(Tm);
  if abs(pws2-pws1)<ErroreMax then ok:=true
  else
  if  pws1>pws2  then t1:=tm
  else t2:=tm
  end;
result:=TM;
end;

FUNCTION CalcURDaUs(T,US:real):REAL;

VAR
  PWSX,W:REAL;
BEGIN
W:=Us/(1-Us);
PWSX:=W*Patm/(0.62198+w);
result:=PWSX*100/PWS(T);
END;     { FUNC. CalcUS }

(*
 FUNCTION CalcUS(T,UR:real):REAL;

VAR
  PWSX,W:REAL;
BEGIN


PWSX:=UR * PWS(T) / 100;
W:=0.62198 * PWSX / (PATM-PWSX);
Result:=W/(1+W);

END;     { FUNC. CalcUS }
 *)
Function CalcUR(TBs,TBU:real):Real;
Var US:real;
begin
us:=CalcUsDaTbu(tbs,Tbu);
result:=CalcUrDaUs(tbs,us);
end;

{------------------- TDA (temperatura di rugiada ) --------------}


FUNCTION Rugiada(TBS,TBU:real):REAL;


VAR
   WSBU,WImm,Pw,Alf:REAL;

BEGIN

  WSBU:=WSBX(TBU);                           {** 6.4 (8)  **}


                                                         {** 6.9 (33) **}
  WImm:=((2501-2.381*TBU)*WSBU-(TBS-TBU)) /
                          ( 2501+1.805*TBS-4.186*TBU);

  Pw:=PATM*WIMM/(0.62198+WIMM);                          {**  6.8 (20) **}
  Alf:=ln(Pw);
  Result:=-35.957-1.8726*Alf+1.1689*sqr(Alf);               {**  6.9 (35) **}

END;

{-------------------------------  Densità  -------------------------------}


FUNCTION Densita(TBS,UR:real):REAL;

VAR
  PWSX,W,NU:REAL;

BEGIN

    PWSX:=UR*PWS(TBS)/100;
    W:=0.62198 * PWSX / (PATM-PWSX);                         {** 6.8 (21) **}
    NU:=(287055.0*(TBS+273.15)/PATM)*(1+1.6078*W);
{    WRITELN('ROVENT:',1000*(1 + W) / NU);REPEAT UNTIL KEYPRESSED;}
    Result:=1000*(1 + W) / NU;

END;     { FUNC. ROVENT }


{------------------------        CVAP          ----------------------------}


FUNCTION CalVAP(TBS:real):REAL;


BEGIN

   CalVAP:=2453.48-2.368*(TBS-20);

END;

{------------------------        CP            ----------------------------}


FUNCTION CalSens:REAL;


BEGIN

   Result:=0.237*4186;

END;
{-------------------------------  POtaria  -------------------------------}


Procedure PotAria(Portata,T1,UR1,T2,UR2:real;var sens,Lat:real);
Var Us1,Us2:real;
begin

Lat:= (                         POrtata*
                        Densita(T1,Ur1)*
                             CalVAP(T1)*
       (CalcUS(T2,Ur2)-CalcUS(T1,Ur1)))/
                                    100;

Sens:=(        POrtata*
       Densita(T1,Ur1)*
               Calsens*
              (T2-T1))/
              100000.0;
end;

Function CalcPortAria(T1,Ur1,T2,Ur2,Sens,Lat:real;Modo:Char):real;
Var SS,LL:real;
begin
POtAria(1,T1,Ur1,T2,Ur2,SS,LL);
  Case upcase(modo) of
  'S':result:=Sens/SS;
  'L':result:=Lat/LL;
  'T':result:=(Sens+Lat)/(SS+LL);
  end;
end;
Function PotAriaInv(T1,T2,POt:real):Real;
begin
result:=(T2-t1)*0.34;
end;
Function CalcPortAriaInv(T1,T2,POt:real):real;
begin
Result:=Pot/POtAriaInv(1,T1,T2);
end;
Function POrtAriaVent(ricircolo,ricambio:real):real;
begin
result:=ricircolo;
if ricambio>ricircolo then result:=ricambio;
end;

end.
