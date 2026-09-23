
{-------------------------------  CalcQACON  -----------------------------}

PROCEDURE CalcQACON(A:INTEGER);

VAR
  C,H,M:INTEGER;
  Prec:ARRAY[0..23] OF REAL;
  Trovato:BOOLEAN;

BEGIN

  FOR M:=MeseInizio TO MeseFine DO

  BEGIN

    FOR H:=0 TO 23 DO  BEGIN  Prec[H]:=0;  dat^[5,H,M]:=0; END;
    Trovato:=FALSE;

    REPEAT
      FOR H:=0 TO 23 DO
      begin
        dat^[5,H,M]:=V0Con*dat^[1,H,M];
        dat^[5,H,M]:=dat^[5,H,M]+V1Con*dat^[1,(H+23) MOD 24,M];
        dat^[5,H,M]:=dat^[5,H,M]+V2Con*dat^[1,(H+22) MOD 24,M];
        dat^[5,H,M]:=dat^[5,H,M]-ArCalc^[A]^.W1*dat^[5,(H+23) MOD 24,M];
      end;
      H:=0;
      REPEAT
        IF ABS(dat^[5,H,M]-Prec[H])>10 THEN
        BEGIN
          FOR C:=0 TO 23 DO Prec[C]:=dat^[5,C,M];
          H:=24;
        END;
        H:=H+1;
      UNTIL H>=24;

      IF H<25 THEN Trovato:=TRUE;

    UNTIL Trovato;

  END;     { FOR m:=MeseInizio to MeseFine DO.......... }

END;   { PROC.  CalcQACON }

{-------------------------------  CalcQAILL  -----------------------------}

PROCEDURE CalcQAILL(A:INTEGER);

VAR
  C,H,M:INTEGER;
  Prec:ARRAY[0..23] OF REAL;
  Trovato:BOOLEAN;
  Temp:real;
BEGIN

  FOR M:=MeseInizio TO MeseFine DO
  BEGIN
    FOR H:=0 TO 23 DO  BEGIN  Prec[H]:=0;  dat^[7,H,M]:=0; END;
    Trovato:=FALSE;

    REPEAT
      FOR H:=0 TO 23 DO
      begin
        dat^[7,H,M]:=(V0Ill*dat^[4,H,M]            +
                     V1Ill*dat^[4,(H+23) MOD 24,M]+
                     V2Ill*dat^[4,(H+22) MOD 24,M]-
                     ArCalc^[A]^.W1*dat^[7,(H+23) MOD 24,M]) ;
        IF dat^[7,H,M] < 0 THEN dat^[7,H,M]:=0;
      end;
      H:=0;
      REPEAT
        IF ABS(dat^[7,H,M]-Prec[H])>10 THEN
        BEGIN
          FOR C:=0 TO 23 DO Prec[C]:=dat^[7,C,M];
          H:=24;
        END;
        H:=H+1;
      UNTIL H>=24;

      IF H<25 THEN Trovato:=TRUE;
    UNTIL Trovato;

    Temp:=dat^[7,0,M];
    for h:=0 to 22 do dat^[7,h,m]:=dat^[7,h+1,m];
    dat^[7,23,m]:=Temp;

  END;     { FOR m:=MeseInizio to MeseFine DO.......... }

END;   { PROC.  CalcQAILL }

{-------------------------------  CalcQAIRR  -----------------------------}

PROCEDURE CalcQAIRR(A:INTEGER);

VAR
  C,H,M:INTEGER;
  Prec:ARRAY[0..23] OF REAL;
  Trovato:BOOLEAN;

BEGIN

  FOR M:=MeseInizio TO MeseFine DO
  BEGIN
    FOR H:=0 TO 23 DO  BEGIN  Prec[H]:=0;  dat^[6,H,M]:=0; END;
    Trovato:=FALSE;

    REPEAT

      FOR H:=0 TO 23 DO
      begin
        dat^[6,H,M]:=  (V0Con*dat^[2,H,M]  +
                       V1Con*dat^[2,(H+23) MOD 24,M]+
                       V2Con*dat^[2,(H+22) MOD 24,M]+
                       V0Irr*dat^[3,H,M]  +
                       V1Irr*dat^[3,(H+23) MOD 24,M]+
                       V2Irr*dat^[3,(H+22) MOD 24,M]-
                       ArCalc^[A]^.W1*dat^[6,(H+23) MOD 24,M]) ;
        IF dat^[6,H,M] < 0 THEN dat^[6,H,M]:=0;
      end;
      H:=0;
      REPEAT
        IF ABS(dat^[6,H,M]-Prec[H])>10 THEN
        BEGIN
          FOR C:=0 TO 23 DO Prec[C]:=dat^[6,C,M];
          H:=24;
        END;
        H:=H+1;
      UNTIL H>=24;

      IF H<25 THEN Trovato:=TRUE;
    UNTIL Trovato;

  END;     { FOR m:=MeseInizio to MeseFine DO.......... }

END;   { PROC.  CalcQAIRR }

{-------------------------------  CalcQAPS  -----------------------------}

PROCEDURE CalcQAPS(A:INTEGER);

VAR
  C,H,M:INTEGER;
  Prec:ARRAY[0..23] OF REAL;
  Trovato:BOOLEAN;
  Rapp:REAL;

BEGIN

  Rapp:=Ambienti_D^[A]^.RappRS;
    FOR H:=0 TO 23 DO  BEGIN  Prec[H]:=0;  datb^[5,H]:=0; END;
    Trovato:=FALSE;

    REPEAT
      FOR H:=0 TO 23 DO
      BEGIN
        datb^[5,H]:=V0Irr*Rapp*datb^[3,H]+
                   V1Irr*Rapp*datb^[3,(H+23) MOD 24]+
                   V2Irr*Rapp*datb^[3,(H+22) MOD 24] -
                   ArCalc^[A]^.W1*datb^[5,(H+23) MOD 24];
        IF datb^[5,H] < 0 THEN datb^[5,H]:=0;
      END;
      H:=0;
      REPEAT
        IF ABS(datb^[5,H]-Prec[H])>10 THEN
        BEGIN
          FOR C:=0 TO 23 DO Prec[C]:=datb^[5,C];
          H:=24;
        END;
        H:=H+1;
      UNTIL H>=24;

      IF H<25 THEN Trovato:=TRUE;
    UNTIL Trovato;

    FOR H:=0 TO 23 DO datb^[5,H]:=datb^[5,H] + (1-Rapp)*datb^[3,H];

END;   { PROC.  CalcQAPS }

{-------------------------------  CalcQOCS  -----------------------------}

PROCEDURE CalcQOCS(A:INTEGER);

VAR
  C,H,M:INTEGER;
  Prec:ARRAY[0..23] OF REAL;
  Trovato:BOOLEAN;
  CLF:real;

BEGIN

    FOR H:=0 TO 23 DO  BEGIN  Prec[H]:=0;  datb^[6,H]:=0; END;
    Trovato:=FALSE;

    CLF:=0.45;
    with Ambienti_D^[A]^ do
      if NPersone > 0 then
       begin
          if Superficie/NPersone <= 2 then CLF:=0;
       end;

    REPEAT
      FOR H:=0 TO 23 DO
        datb^[6,H]:=V0Irr*CLF*datb^[1,H]+
                   V1Irr*CLF*datb^[1,(H+23) MOD 24]+
                   V2Irr*CLF*datb^[1,(H+22) MOD 24] -
                   ArCalc^[A]^.W1*datb^[6,(H+23) MOD 24];
      H:=0;
      REPEAT
        IF ABS(datb^[6,H]-Prec[H])>10 THEN
        BEGIN
          FOR C:=0 TO 23 DO Prec[C]:=datb^[6,C];
          H:=24;
        END;
        H:=H+1;
      UNTIL H>=24;

      IF H<25 THEN Trovato:=TRUE;
    UNTIL Trovato;

    FOR H:=0 TO 23 DO datb^[6,H]:=datb^[6,H] + (1-CLF)*datb^[1,H];
END;   { PROC.  CalcQOCS }

{-------------------------------  CalcCoeff  -----------------------------}

PROCEDURE CalcCoeff(A:INTEGER);

var FCVal : real;

BEGIN

  FCVal:=FC(A);
  V0Irr:=(Interpola(MFtot,0));       { Riga 0 dati per irr. }
  V1Irr:=(1+ArCalc^[A]^.W1-V0Irr)*FCVal;
  V2Irr:=0;
  V0Irr:=V0Irr*FCVal;
  V0Con:=(Interpola(MFtot,1));       { Riga 1 dati per con. }
  V1Con:=(1+ArCalc^[A]^.W1-V0Con)*FCVal;
  V0Con:=V0Con*FCVal;
  V2Con:=0;
  V0Ill:=0;
  V1Ill:=0;
  CASE Ambienti_D^[A]^.TipoIlluminaz OF
    1:V1Ill:=0.45;
    2:V1Ill:=0.55;
    3:V1Ill:=0.65;
    4:V1Ill:=0.75;
  END;
  V2Ill:=(1+ArCalc^[A]^.W1-V1Ill)*FCVal;
  V1Ill:=V1Ill*FCVal;
END;     { PROC.  CalcCoeff }

{------------------------------  CalcCTMax  -------------------------------}

PROCEDURE CalcCTMax(A:integer);

VAR
  H,M,N   : INTEGER;
  CTS,CTT : REAL;

BEGIN


  WITH ArCalc^[A]^.CTM DO
  BEGIN
    CTMAX:=CT(0,MeseInizio,A);

    CTTOTMAX:=CTMAX+CTLAT(0,MeseInizio,A);
    Ht:=0;     Mt:=MeseInizio;

    FOR M:=MeseInizio TO MeseFine DO
     FOR H:=0 TO 23 DO
      BEGIN
        CTS:=CT(H,M,A);
        CTT:=CTS+CTLAT(H,M,A);
        IF CTT > CTTOTMAX THEN
         BEGIN
            CTTOTMAX:=CTT;
            CTMAX:=CTS;
            Ht:=H;
            Mt:=M;
         END;
      END;
  END;

END;     { PROC. CalcCTMax }
