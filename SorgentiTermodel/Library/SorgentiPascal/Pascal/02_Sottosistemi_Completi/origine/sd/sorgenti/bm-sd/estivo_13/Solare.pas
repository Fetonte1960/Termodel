unit Solare;

interface
uses varcarichi;
PROCEDURE ValOraMesi(LA:REAL);
FUNCTION IDR(H,M,E:INTEGER):REAL;
FUNCTION IDF(H,M,E:INTEGER):REAL;
implementation
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
  //WFhmDB(IDN^,'IDN.DAT',1);
end;   { PROC. ValOraMesi }

{--------------------------  IDR  -----------------------------------------}


FUNCTION IDR(H,M,E:INTEGER):REAL;


VAR

  k,AL,BE,GA,NH,YS:REAL;

BEGIN

  k:=PI/180;
  IF Progetto_D^.Inclin<>180 THEN
  BEGIN
    WITH Progetto_D^ DO
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

  IF Progetto_D^.Inclin<>180 THEN
  BEGIN
    WITH Progetto_D^ DO
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




end.
