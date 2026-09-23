{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit F1;

Interface

Uses
  CalcFun,Varcarichi,Varcarichi_estivo_14,warning,
  copiaLibreriaGenerale,
  Risultati,psicrometrico,sysutils;
//  Crt, {Unit found in TURBO.TPL}
//  Dos, {Unit found in TURBO.TPL}
//  defutig,
//  utigen,
//  definiz,
//  {$ifdef calcoli}
//  CALCUTID,
//  {$else}
//  uwrite,
//  {$endif}

//  calcfun,
//  inpdati,WM;


procedure Fase1;
PROCEDURE DetPATM;

{=============================================================================}
Implementation

{-------------------------------  DetPATM  -----------------------------------}
PROCEDURE DetPATM;
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
          Trovato:=(Localita_D^.HMare <= C[T]);
          if not Trovato then T:=T+1;
       end
      else Trovato:=true;
   end;

  WITH Localita_D^  DO PATM:=A[T-1]+ (HMare-C[T-1])/(C[T]-C[T-1]) * (A[T]-A[T-1]);

END;     { PROC.   DetPATM }


{-------------------------------  FASE1  -------------------------------}

 PROCEDURE FASE1;

VAR
  F,F1,A,E:INTEGER;

{-----------------------------  CalcPortVent  --------------------------------}
PROCEDURE CalcPortVent;

//type  VentZone = Array[1..MaxZone] of real;

VAR  A         : INTEGER          ;
     //PVentZona : VentZone         ;
     g         : file of VentZone ;

BEGIN
  FOR A:=1 TO NImpianti DO PVentZona[A]:=0;

  FOR A:=1 TO NAmbienti DO
    WITH Ambienti_D^[A]^ DO
    if indimpianto<>0 then
    BEGIN
      ArCalc^[A]^.PVent:=Superficie * HSoffitto * Ventilazione / 3.6;

      IF NPersone*RicambioPersona > ArCalc^[A]^.PVent THEN ArCalc^[A]^.PVent:=NPersone*RicambioPersona;
      PVentZona[Indimpianto]:=PVentZona[Indimpianto]+ArCalc^[A]^.PVent*AmbientiUguali;
    END;

 // scrivi_Real(ArCalc,'P','Vent.mic');

 {assign(f,'Vent.mic');   rewrite(f);   write(f,PVent);    close(f);}
  {... salvataggio PVENT ...}

// assign(g,'VentZone.mic');   rewrite(g);   write(g,PVentZona);    close(g);
  {... salvataggio PVent
  Zona ...}
END;   { PROC. CalcPortVent }



{-------------------------------  DetTmax  -----------------------------------}
{ Determinazione Tmax (temperature massime) mensili }
procedure DetTmax (TES,TEW,ED:REAL);
CONST
 PDR:array[0..23] of integer
       =(82,87,92,96,99,100,98,93,84,71,56,39,23,11,3,0,3,10,21,34,47,58,68,76);
 KBS:ARRAY[1..12] OF REAL = (0.345,0.386,0.51,0.643,0.777,0.893,1.0,0.976,0.885,0.719,0.539,0.391);
 KBU:ARRAY[1..12] OF REAL = (0,0.072,0.227,0.429,0.682,0.887,1.0,0.98,0.896,0.639,0.363,0.102);

type  mes=array[1..12]of real;

var
  AR,TMINBU:real;
  M,H,z:integer;
  MM:INTEGER;
  f:file of Tyhm;
  bufti:mes;
  f1:file of mes;

begin

  FOR M:=1 TO 12 DO FOR H:=0 TO 23 DO TE^[H,M]:=0;

  WITH Localita_D^ DO
  BEGIN
  IF LAT > 0 THEN MM:=1 ELSE MM:=7;
  if exist(Drivearcc+nome+'.clm') then
    begin
    assign(f,Drivearcc+nome+'.clm');
    reset(f);
    read(f,Te^);
    close(f);
    for m:=1 TO 12 DO
      BEGIN
      TMAXBS[M]:=Te^[0,M];
      FOR H:=1 TO 23 DO IF Te^[H,M]>TmaxBs[M] then TMaxBS[M]:=Te^[H,M]
      end;
    end
  else
    begin
      AR:=TES-TEW;
      TMAXBS[MM]:=KBS[((MM+MM-2) MOD 12)+1]*AR+TEW;
      for M:=1 to 12 do
      begin
        TMAXBS[M]:=KBS[((M+MM-2) MOD 12)+1]*AR+TEW;
        FOR H:=0 TO 23 DO Te^[H,M]:=TMAXBS[M]-PDR[H]*ED/100;
      end;
    end;

    TMINBU:=TMAXBS[MM]-ET/2;
    for M:=1 to 12 do
     begin
      TMAXBU[M]:=KBU[((M+MM-2) MOD 12)+1]*(TEstEsternaBU-TMINBU)+TMINBU;
     end;
  END;   {  WIDTH Localita_D^ DO.............  }

//assign(f,'te.dat');REWRITE(f);write(f,te^);close(f); {visualizzazione TE}
WFhmDB(te^,'TE.DAT',1);
{** T interna compensata utilizzata nei grafici **}
(*
assign(f1,'ti.dat');REWRITE(f1);
for z:=1 to nzone  do
 begin
 for m:=1 to 12 do bufti[m]:=ti(m,z);
 write(f1,bufti)
 //WFhmDB(bufti,'TI.DAT',Z);
 end;
close(f1);
*)
end;   { PROC. DetTmax }

{-------------------------------  ValOraMesi  --------------------------------}
PROCEDURE ValOraMesi(LA:REAL);
const A:array[1..12] of integer
         = (1209,1193,1164,1115,1084,1069,1066,1088,1131,1172,1199,1212);
      B:array[1..12] of real
         = (0.142,0.144,0.156,0.180,0.196,0.205,0.207,0.201,0.177,0.160,0.149,0.142);
      DE:array[1..12] of real
         = (-20.0,-10.8,0.0,11.6,20.0,23.45,20.6,12.3,0.0,-10.5,-19.8,-23.45);
      ET:array[1..12] of real
         = (-2.8,-3.47,-1.87,0.27,0.82,-0.35,-1.55,-0.06,1.87,3.85,3.45,0.4);
var
  HA,c:REAL;
  H,M:integer;
  LON:INTEGER;     { longitudine della localita      }
  LST,LST2:INTEGER;
  AST:REAL;
begin
  c:=PI/180;
  for H:=0 to 23 do
  begin
    LST2:=15*(H-12);
    for M:=MeseInizio to MeseFine do
    begin
      LST:=LST2;

      IF M IN [Localita_D^.OraLegInizio..Localita_D^.OraLegFine] THEN LST:=LST-15;
      AST:=LST+ET[M]+Localita_D^.MeridRifOra-Localita_D^.LON;
      HA:=AST*c;
      R1^[H,M]:=-COS(DE[M]*c)*SIN(HA);
      R2^[H,M]:= SIN(DE[M]*c)*COS(LA*c) - COS(DE[M]*c)*SIN(LA*c)*COS(HA);
      R3^[H,M]:= SIN(DE[M]*c)*SIN(LA*c) + COS(DE[M]*c)*COS(LA*c)*COS(HA);

      if R3^[H,M]>0.01 THEN IDN^[H,M]:=A[M]*EXP(-B[M]/R3^[H,M])
                       ELSE IDN^[H,M]:=0;
    end;
  end;
  WFhmDB(IDN^,'IDN.DAT',1);
end;   { PROC. ValOraMesi }

{----------------------------------  A0T0Calc  -------------------------------}
{Calcolo di A0 e di T0}
PROCEDURE A0T0Calc;
const AB : array[0..5] of real
         = (0.01154,0.77674,-3.94657,8.57881,-8.38135,3.01188);
      TR : array[0..5] of real
         = (-0.00885,2.71235,-0.62062,-7.07329,9.75995,-3.89922);
VAR
  J:integer;
BEGIN
  A0:=0;
  T0:=0;
  for J:=0 to 5 do
  begin
    A0:=A0+AB[J]/(J+2);
    T0:=T0+TR[J]/(J+2);
  end;
END;     { PROC.  A0T0calc }


{-------------------------------  CalcUSImm  ---------------------------------}

PROCEDURE CalcUSImm;

VAR

  WSBU,WSBUinv:REAL;
  WImm,WImmInv:REAL;
  Pw,Alf:real;
  Z:INTEGER;

BEGIN

  FOR Z:=1 TO NImpianti DO

  WITH Zone_D^[Z] DO

  BEGIN

           {** INVERNO **}

    WSBUinv:=WSBX(TimmInvBU);
    WImmInv:=((2501-2.381*TImmInvBU)*WSBUinv-(TimmInv-TImmInvBU))/
                            ( 2501+1.805*TImmInv-4.186*TImmInvBU);
    USImmInv[Z]:=WImmInv / (1+WImmInv);

  END;

END;   { CalcUSImm }

{-------------------------------  CalcINFTOT  --------------------------------}

 PROCEDURE CalcINFTOT;

{ Determinazione carico termico per infiltrazione }

VAR
  H,M,A:INTEGER;
  PINFest,PINFinv:REAL;
  CP1,CP2,CVAP1:REAL;
  ROinv,USinv,v1,v2:REAL;


{---------------------------------  CalcKZ  ----------------------------------}
PROCEDURE CalcKZ(Z:INTEGER);

{ Calcola i valori di RO e US per tutte le zone }

VAR
  PWSX,W,NU:REAL;

BEGIN

    WITH Zone_D^[Z] DO

    BEGIN

      ROinv := 0;
      USinv := 0;

      PWSX  :=      UInv *
               PWS(TInv) /
                     100 ;

      W     :=     0.62198 *
                      PWSX /
               (PATM-PWSX) ;

      NU    := (287055.0*(TInv+273.15)/PATM) *
                                (1+1.6078*W) ;

      ROinv :=    1000 *
               (1 + W) /
                    NU ;

      PWSX  :=      UInv *
               PWS(TInv) /
                     100 ;

      W     :=     0.62198 *
                      PWSX /
               (PATM-PWSX) ;

      USinv := W/(1+W);

    END;

END;    { PROC.   CalcKZ }

{------------------------        CP            ----------------------------}

FUNCTION CP(M,Z:INTEGER):REAL;
BEGIN
  { CP:=0.237*4186; }
   CP:=0.306*4186/((0.0036667*Zone_D^[Z].TEst)+1);
END;


{------------------------  MAIN of CalcINFTOT  ----------------------------}

BEGIN

  OpenCan(8,'INSTOTes',NAmbienti,2);
  OpenCan(9,'INLTOTes',NAmbienti,2);

  FOR A:=1 TO NAmbienti DO
   WITH Ambienti_D^[A]^ DO
    IF Zona IN [1..NZone] THEN
    BEGIN
      LoadHM(8,A);     { INSTOTes }
      LoadHM(9,A);     { INLTOTes }

      CalcKZ(Zona);

      PINFest:=InfEst*Superficie*HSoffitto/3600;

      FOR m:=MeseInizio to MeseFine DO
      BEGIN
        CP1:=CP(M,Zona);
        CVAP1:=CVAP(M,Zona);
        v1:=ROest(M,Zona);
        v2:=USest(M,Zona);
        FOR H:=0 TO 23 DO
        BEGIN

          dat^[8,H,M]:=PINFest * CP1 * (Te^[H,M] - TI(M,Zona));
          dat^[9,H,M]:=1000*PINFest * {ROest(M,Zona)}v1 *
                            (US[H,M] - {USest(M,Zona)}v2) * CVAP1;
        END;
      END;

    END;
  CloseHM(8);
  CloseHM(9);
END;    { PROC.  CalcINFTOT }

{--------------------------------  CalcUsUr  ---------------------------------}

PROCEDURE CalcUsUr;
VAR
  H,M                                 :INTEGER;
  W,PWSBS,WSBS,PWSBU,WSBU,MU,XWS,WS,FI:REAL;
  F                                   :FILE OF Tab;

{---------------------------------  CalcWMAX  --------------------------------}

PROCEDURE CalcWMAX;
VAR
  M:INTEGER;
  WSBS,WSBU:REAL;
BEGIN
  FOR M:=MeseInizio TO MeseFine DO
  BEGIN
    WSBS:=WSBX(TMAXBS[M]);
    WSBU:=WSBX(TMAXBU[M]);

    if not((TMAXBS[M] = 0) and (TMAXBU[M] = 0)) then
      WMAX[M]:=((2501-2.381*TMAXBU[M])*WSBU-(TMAXBS[M]-TMAXBU[M]))   /
               ( 2501+1.805*TMAXBS[M]-4.186*TMAXBU[M])
    else WMAX[M]:=0;
  END;
END;    { PROC. CalcWMAX }

{--------------------------- START CALCUSUR ---------------------------------}

BEGIN

  For M:=1 TO 12 DO FOR H:=0 TO 23 DO
    BEGIN
    US[H,M]:=0;
    UR[H,M]:=0;
    END;

  CalcWMAX;
  FOR M:=MeseInizio TO MeseFine DO
   begin
    FOR H:=0 TO 23 DO
    BEGIN

      PWSBS:=PWS(Te^[H,M]);
      WSBS:=0.62198 * PWSBS/(PATM-PWSBS);
      MU:=WMAX[M]/WSBS;
      XWS:=PWSBS/PATM;       FI:=MU/(1-(1-MU)*XWS);
      IF FI <= 0.95 THEN
      BEGIN
        US[H,M]:=WMAX[M]/(1+WMAX[M]);
        UR[H,M]:=FI*100;
      END
      ELSE
      BEGIN
        PWSBS:=0.95 * PWSBS;
        WS:=0.62198 * PWSBS / (PATM-PWSBS);
        US[H,M]:=WS/(1+WS);
        UR[H,M]:=95;
      END;
    END;
   end;

   PWSBS:=PWS(Localita_D^.TInvEsternaBS);
   PWSBU:=PWS(Localita_D^.TInvEsternaBU);
   WSBS:=0.62198 * PWSBS/(PATM-PWSBS);
   WSBU:=0.62198 * PWSBU/(PATM-PWSBU);
   WITH Localita_D^ DO
   W:=((2501-2.381*TInvEsternaBU)*WSBU-(TInvEsternaBS-TInvEsternaBU)) /
       (2501+1.805*(TInvEsternaBS-4.186*TInvEsternaBU));
   MU:=W/WSBS;
   XWS:=PWSBS/PATM;
   FI:=MU/(1-(1-MU)*XWS);
   IF FI <= 0.95 THEN
    BEGIN
       UScost:=W/(1+W);
       URcost:=FI*100;
    END
   ELSE
    BEGIN
       PWSBS:=0.95 * PWSBS;
       WS:=0.62198 * PWSBS / (PATM-PWSBS);
       UScost:=WS/(1+WS);
       URcost:=95;
    END;

//{***}assign(f,'us.dat');rewrite(f);write(f,us);close(f);
//{***}assign(f,'ur.dat');rewrite(f);write(f,ur);close(f);

END;     { PROC. CalcUsUr }


Function CodiceProfilo(Cod:String):Integer;
Var i:integer;
begin
if NOrari<>0 then
  begin
  i:=1;
  while (i<NOrari)and(UpperCase(Cod) <> UpperCase(Orari_d^[i].Codice)) do inc(i);
  end;
if (NOrari=0)or(UpperCase(Cod) <> UpperCase(Orari_d^[i].Codice)) then
  begin
  result:=1;
  if cod<>'' then
    begin
    //Erroregen:=true;
    //echo('Andamento orario '+cod+ ' non trovato in archivio.');
    end;
  end
else
result:=i;
end;

Procedure CompilaZona_impianto;
Var i:integer;
begin
for i:=1 to NAmbienti do
with ambienti_d^[i]^ do
  begin
  infest:=infinv;
  end;
for i:=1 to NImpianti do
with impianto_d^[i] do
if (TimmEst<>0)and(URimmEst<>0)  then
  begin
  if Trugiada=0 then Trugiada:=CalcTbs(CalcUs(TimmEst,URimmEst),100);
  end;
begin
end;
for i:=1 to NImpianti do
with zone_d^[i] do
  begin
  tinv:=20;
  Uinv:=40;
  TimmEst:=Impianto_d^[i].TimmEst;
  URimmEst:=Impianto_d^[i].URimmEst;
  TimmInv:=Impianto_d^[i].TimmInv;
  URimmInv:=Impianto_d^[i].URimmInv;
  ProfVentEst:=CodiceProfilo(Impianto_d^[i].EstProfiloVent);
  ProfVentInv:=CodiceProfilo(Impianto_d^[i].InvProfiloVent);
  Profiloimpianto:=CodiceProfilo(Impianto_d^[i].INVProfiloImpianto);
  if uppercase(Impianto_d^[i].GenEst)='NON CLIMATIZZATO' then profiloimpianto:=0;
  ProfiloImpiantoInv:=CodiceProfilo(Impianto_d^[i].INVProfiloImpianto);
  //:=Impianto_d^[1];
  //:=Impianto_d^[1];
  //:=Impianto_d^[1];
  end;
end; {-------------}
Var i:integer;
BEGIN  {..Fase1..}
 // d_m1:=Td_m1.create(nil);
Fwarning:=TFwarning.create(nil);
controllogen;
if not erroregen then
  begin
  CompilaZona_impianto;
  DetPatM;
  for i:=1 to NImpianti do
  with zone_D^[i] do TimmEstBU:=calctbu(TimmEst,URimmEst,Localita_D^.hmare);
  with Localita_D^ do
    begin
    TEstEsternaBU:=calctbu(TEstEsternaBS,UEstEsterna,hmare);
    TInvEsternaBU:=calctbu(TInvEsternaBS,UInvEsterna,hmare);
    DetTmax(TEstEsternaBS,TInvEsternaBS,ET);
    end;

  ValOraMesi(Localita_D^.Lat);

  A0T0Calc;

  CalcUsUr;
  CalcPortVent;
  CalcUSImm;

  CalcInfTot;
  end;
END;    { PROC. CalcFASE1 }


end.