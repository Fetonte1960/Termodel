{------------------------------  CalcPotenze  --------------------------------}

PROCEDURE CalcPotenze(A:INTEGER);

const PDRInv:array[0..23] of real
            = (0.18,0.16,0.15,0.12,0.11,0.07,0.04,0,0.03,0.08,0.16,0.34,0.56,0.85,0.96,1,0.97,0.88,
               0.72,0.49,0.37,0.3,0.34,0.2);


VAR
     CART                                  : ORE ;
     G0K,G1K,G2K,P1K,P2K                   : REAL;
     G0A,G1A,G2A,G0B,G1B,G2B               : REAL;
     SER,IER,WT,CTInv,KInv,KInv1,KInv2     : REAL;
     Trovato                               : BOOLEAN;
     Prec                                  : ARRAY[0..23] OF REAL;
     ERMax,ERMin,calcrovent,dat1zma,dat2zma: REAL;
     C,H,M,N                               : INTEGER;
     V1,V2,V3,V4                           : REAL;
     PV                                    : REAL;

BEGIN

  H:=TRANSFER_TAB('TAB33','L');


  WITH Ambienti_D^[A]^ DO

  BEGIN
                                       {** Portata ventilazione **}

    PV:=Superficie*HSoffitto*Ventilazione/3600;


    G0K:=Interpola(mftot,1);             {** 26.37 (TAB 34) **}
    G1K:=Interpola(mftot,2);
    G2K:=Interpola(mftot,3);
    P1K:=Interpola(mftot,4);

                                         {** 26.37 (43) (44) **}

    G0A:=G0K*Superficie+      TrasmGen+1.232*InfEst*HSoffitto*Superficie/3.6 ;
    G1A:=G1K*Superficie+P1K*( TrasmGen+1.232*InfEst*HSoffitto*Superficie/3.6 );
    G2A:=G2K*SUPERFICIE;


    SER:=ArCalc^[A]^.CTM.CTMAX / ( 2*Zone_D^[Zona].TolleranzaT );  {** 26.36 (40-41) **}

    if SER < 0 then SER:=0;

    if (Indimpianto<>0)and(ZONE_D^[zona].test<>0) and (zone_d^[Indimpianto].ProfiloImpiantoInv <> 0) and (zone_d^[Indimpianto].ProfiloImpianto <> 0) then
       {****** LOCALE SOLO RISCALDATO *******}
      BEGIN

      FOR M:=MeseInizio TO MeseFine DO

        BEGIN

        FOR h:=0 TO 23 DO CART[H]:=CT(H,M,A);     { ** Carichi Totali **}


                         {** APPORTO VENT. A PIENO REGIME **}

        dat1zma:=                         PV*
                              ROVENT(m,zona)*
                                  CP(M,Zona)*
              (-TImmComp(M,Zona)+TI(M,Zona))/
                                    100000.0;



        WT:=ArCalc^[A]^.CTM.CTMAX /2 - SER*(TI(M,Zona));   {** 26.36 (41) **}

        V4:=TI(M,ZONA);

        FOR H:=0 TO 23 DO

          BEGIN

          Prec[H]        :=0;
          dat^[EREst,H,M] :=0;
          dat^[TIE,H,M]   :={TI(M,Zona)}V4;

          END;

        V1:=TI(M,Zona)*(G0A+G1A+G2A);
        V2:=G0A/(SER+G0A)*WT;
        V3:=SER/(SER+G0A);

        ERMax:=ArCalc^[A]^.CTM.CTMAX*ZONE_D^[zona].CoeffIntermittEst;

        REPEAT

        FOR H:=0 TO 23 DO

          BEGIN               {** 26.37 (46) **}

          IER:={ TI(M,Zona)*(G0A+G1A+G2A) }V1                           -
               G1A *dat^ [ TIE,HE[H+23],M ]                              -
               G2A *dat^ [ TIE,HE[H+22],M ]                              +
               CarT[H]                                                  +
               P1K*( CarT[ HE[H+23] ]-dat^[EREST,HE[H+23],M] ) ;

          IF (Indimpianto=0)or(Profili_D^[Zone_D^[Indimpianto].ProfiloImpianto,H]=0) THEN

             { ** POTENZA FORNITA DALLA VENTILAZIONE ** }

          dat^[EREst,H,M] := Profili_D^[Zone_D^[Zona].ProfVentEst,H]*dat1zma

          ELSE

            begin                                           {** 26.37 (45) **}

            dat^[EREst,H,M]:={ G0A/(SER+G0A)*WT }V2 + { SER/(SER+G0A) }V3 *IER;

            if dat^[EREst,H,M] > ErMax then dat^[EREst,H,M]:=ErMax;
            if dat^[erest,H,M] < 0     then dat^[erest,h,m]:=0;

            end;


          dat^[TIE,H,M]:=(IER-dat^[EREst,H,M]) / G0A ;        {** 26.37 (47) **}

          END;   {for h:=0 to 23}

        H:=0;

        TROVATO:=TRUE;

          REPEAT

          IF ABS(dat^[EREST,H,M]-Prec[H]) > 10 THEN

            BEGIN

            FOR C:=0 TO 23 DO Prec[C]:=dat^[EREST,C,M];
            TROVATO:=FALSE;

            END;

          H:=H+1;

          UNTIL (H=24)or(trovato=false);

        UNTIL Trovato;

        {** ANNULLAMENTO POTENZA FORNITA DALLA VENTILAZIONE **}

        FOR H:=0 TO 23 DO
        IF (Indimpianto=0)or(PROFILI_D^[ ZONE_D^[ Indimpianto ].PROFILOIMPIANTO,H ]=0)
        THEN dat^[EREST,H,M]:=0;

        END;    { FOR M:=1 TO 12 DO.........}

      END;

{----------------------......... Calcolo potenze invernali .....--------------}


   //   if (Zone_D^[Ambienti_D^[A]^.Indimpianto].ProfiloImpiantoInv in[1..MaxProfili]) then {*E*}
      if false then // diego 3 aprile 2006 non serve il calcolo invernale
      BEGIN

      G0B:=G0K*Superficie+    TrasmGen+1.232*InfInv*HSoffitto*Superficie/3.6 ;
      G1B:=G1K*Superficie+P1K*(TrasmGen+1.232*InfInv*HSoffitto*Superficie/3.6);
      G2B:=G2K*Superficie;

      CTINV :=-(ArCalc^[A]^.QCTOTINV+ArCalc^[A]^.INSTOTINV);
      SER   := - CTInv* Zone_D^[Zona].CoeffIntermittInv /
                     ( 2*Zone_D^[Zona].TolleranzaT );
      WT    := CTInv*Zone_D^[Zona].CoeffIntermittInv / 2
                   - SER * (Zone_D^[Zona].TInv);

      FOR H:=0 TO 23 DO

        BEGIN

        Prec[H]        :=0;
        datb^[ERInv,H]  :=0;
        datb^[TIEInv,H] :=Zone_D^[Zona].TInv;

        END;

      Trovato :=FALSE;

      ERMin   :=CTINV*Zone_D^[Zona].CoeffIntermittInv;

      REPEAT

        FOR H:=0 TO 23 DO

          BEGIN

         { ** KInv,KInv1 = simulazione andamento orario carichi ** }

            { ** 0.66 = corettivo ET estive --> ET invernali ** }

           KInv :=                            (Zone_D^[Zona].TInv -
                                        Localita_D^.TInvEsternaBS -
                                   Localita_D^.ET*PDRInv[h]*0.66) /
                  (Zone_D^[Zona].TInv - Localita_D^.TInvEsternaBS);

           KInv1:=                            (Zone_D^[Zona].TInv -
                                        Localita_D^.TInvEsternaBS -
                       Localita_D^.ET*PDRInv[(h+23) mod 24]*0.66) /
                  (Zone_D^[Zona].TInv - Localita_D^.TInvEsternaBS);


           IER:=Zone_D^[Zona].TInv*(G0B+G1B+G2B)                      -
                G1B *(datb^[TIEInv,(H+23) MOD 24])                     -
                G2B *(datb^[TIEInv,(H+22) MOD 24]) + CTInv * KInv      +
                P1K *(CTInv*KInv1-datb^[ERInv,(H+23) MOD 24])          ;

           IF (indimpianto=0)or
              (Profili_D^[Zone_D^[Indimpianto].ProfiloImpiantoInv,H]=0) THEN

               datb^[ERInv,H]:=   (Profili_D^[Zone_D^[Zona].ProfVentInv,H] *
                                                                        PV *
                                                                       1.2 *
                                                                      0.35 *
                                                                       3.6 *
                               (Zone_D^[Zona].TimmInv-Zone_D^[Zona].TInv)) /
                                                                       100


           ELSE

            BEGIN

               datb^[ERInv,H]:=(G0B*WT+SER*IER) / (SER+G0B);
               if datb^[ERInv,H] < ErMin then datb^[ERInv,H]:=ErMin;
               IF datb^[ERINV,H] > 0     THEN datb^[ERINV,H]:=0;

            END;

          datb^[TIEInv,H]:=(IER-datb^[ERInv,H]) / G0B;

        END;

        H:=0;

        REPEAT

          IF ABS(datb^[ERINV,H]-Prec[H])> 10 THEN

          BEGIN

            FOR C:=0 TO 23 DO   Prec[C]:=datb^[ERInv,C];

            H:=24;

          END;

          H:=H+1;

        UNTIL H>=24;

        Trovato:=(H < 25);

      UNTIL Trovato;

      {** ANNULLAMENTO POTENZA FORNITA DALLA VENTILAZIONE **}

      FOR H:=0 TO 23 DO
      IF (Indimpianto=0)or(PROFILI_D^[ ZONE_D^[ Indimpianto ].PROFILOIMPIANTOINV,H ]=0)
      THEN datb^[ERINV,H]:=0
      ELSE
      datb^[ERInv,H]:=-datb^[ERInv,H];
      END;
  END;    { WITH Ambienti_D....... }


END;      { PROC. CalcPotenze }

{------------------------------  CalcPTMax  ----------------------------------}

PROCEDURE CalcPTMax(A:INTEGER);


VAR
  H,M     : INTEGER;
  PTS,PTT : REAL;

BEGIN


  WITH ArCalc^[A]^.PTM DO
  BEGIN

    PTMAX:=dat^[EREst,0,MeseInizio];
    PTTOTMAX:=PTMAX+dat^[LATEFF,0,MeseInizio];
    Ht:=0;     Mt:=MeseInizio;
    FOR M:=MeseInizio TO MeseFine DO
      FOR H:=0 TO 23 DO
      BEGIN
        PTS:=dat^[EREst,H,M];
        PTT:=PTS+dat^[LATEFF,H,M];

        IF PTT>PTTOTMAX THEN
         BEGIN
            PTTOTMAX:=PTT;
            PTMAX:=dat^[EREst,H,M];
            Ht:=H;
            Mt:=M;
         END;
      END;
  END;

END;     { PROC. CalcPTMax }

{----------------------------  CalcPTMaxInv  ---------------------------------}

PROCEDURE CalcPTMaxInv(A:INTEGER);

VAR
  H,M      :INTEGER;
  PTS      :REAL;

BEGIN

  WITH ArCalc^[A]^.PTMInv DO
  BEGIN
    PTMAX:=datb^[ERInv,0];    Ht:=0;
    FOR H:=0 TO 23 DO
    BEGIN
      PTS:=datb^[ERInv,H];
      IF PTS > PTMAX THEN BEGIN PTMAX:=datb^[ERInv,H]; Ht:=H; END;
    END;
  END;

END;     { PROC. CalcPTMaxInv }
