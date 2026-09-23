
{--------------------------------  CalcUmRel  --------------------------------}

PROCEDURE CalcUmRel(A:INTEGER);

VAR

     UIEMin,R,PINFest,WS,WSS,XWS,PWSBS,WS1,WS2,XWS1,PW,PW1,PW2:REAL;
     LATIMP,USTIE,USTIEMAX,USTIEMIN,VTOT,W,MU,UAMB,UINF,UVENT,CVAP:REAL;
     UEF     : ore;
     H,M,N : INTEGER;
     calcroest:real;

BEGIN
  //if a=23
  //then
  WITH Ambienti_D^[A]^ DO

  IF (ZONE_D^[ZONA].TEST<>0) AND
     (indimpianto<>0)and
     (zone_d^[Indimpianto].ProfiloImpiantoInv <> 0) and (zone_d^[Indimpianto].ProfiloImpianto <> 0) then
       {**** LOCALE SOLO RISCALDATO ********}
  BEGIN
    //if hsoffitto=0 then hsoffitto:=3;

    FOR M:=MeseInizio TO MeseFine DO
    BEGIN

     calcroest:=roest(m,zona);

     FOR H:=0 TO 23 DO UEF[H]:=USEst(M,Zona);

     if ArCalc^[A]^.ctm.cttotmax<>0 then R:=ArCalc^[A]^.CTM.CTMAX / ArCalc^[A]^.CTM.CTTOTMAX
     else R:=0.5;

     FOR N:=1 TO 3 DO
      FOR H:=0 TO 23 DO

       BEGIN

         LATIMP:=dat^[EREst,H,M]*(1-R)/R;

         IF dat^[EREst,H,M] < 0 THEN LATIMP:=0; {******************}

         PWSBS:=PWS(dat^[TIE,H,M]);
         UIEMin:=(Zone_D^[Zona].UEst-Zone_D^[Zona].TolleranzaU)/ 100;
         PW1:=(Zone_D^[Zona].UEst+Zone_D^[Zona].TolleranzaU) * PWSBS / 100;
         PW2:=(Zone_D^[Zona].UEst-Zone_D^[Zona].TolleranzaU) * PWSBS / 100;
         PW:=Zone_D^[Zona].UEst * PWSBS / 100;


         WSS:=0.62198 * PWSBS / (PATM-PWSBS);

         WS:=0.62198 * PW / (PATM-PW);

         WS1:=0.62198 * PW1 / (PATM-PW1);

         WS2:=0.62198 * PW2 / (PATM-PW2);

         USTIE:=WS/(1+WS);

         USTIEMAX:=WS1 / (1+WS1);

         USTIEMIN:=WS2 / (1+WS2);

         CVAP:=2453.48-2.368*(TI(M,Zona)-20);

         UAMB:=( ( (datb^[APLTOT,H]+datb^[OCLTOT,H]-LATIMP ) * 3.6) / CVAP) +
                                                       UEF[(H+23) mod 24] *
                                                   Superficie * HSoffitto *
                                                                 calcroest;

         PINFest:=InfEst*Superficie*HSoffitto;

         UINF   :=US[H,M] * PINFest * calcroest;

         UVENT  :=                               USTIE *
                                     ArCalc^[A]^.PVent *
               Profili_D^[Zone_D^[Zona].ProfVentEst,H] *
                                                 0.036 *
                                             calcroest ;

         UEF[H] :=                   (UAMB+UINF+UVENT) /
                                          ( (1+InfEst) *
                                Superficie * HSoffitto +
                                     ArCalc^[A]^.PVent *
               Profili_D^[Zone_D^[Zona].ProfVentEst,H] *
                                               0.036 ) /
                                             calcroest ;

         W               := UEF[H] / (1-UEF[H]);

         MU              := (W / WSS);

         dat^[UIE,H,M]    := 100 * ( MU/(1-(1-MU)*PWSBS/PATM) );

         dat^[LATEFF,H,M] := LATIMP;

         IF                               (UEF[H] <= USTIEMAX)  OR
              ((indimpianto=0)or
             (Profili_D^[Zone_D^[Indimpianto].ProfiloImpianto,H] = 0))

         THEN

          BEGIN

            IF (dat^[UIE,H,M] < UIEMin * 100) and (LatImp > 0) THEN

             BEGIN

                dat^[LATEFF,H,M]:=                LATIMP +
                                      (UEF[H]-USTIEMIN) *
                                 Superficie * HSoffitto *
                                                   CVAP *
                                              calcroest /
                                                    3.6 ;

                PW := UIEMin * PWSBS;

                WS := 0.62198 * PW / (PATM-PW);

                UEF[H] := WS/(1+WS);

                dat^[UIE,H,M] := UIEMin*100;

             END;

            IF dat^[UIE,H,M] > 95 THEN

             BEGIN

                PW:=0.95 * PWSBS;

                WS:=0.62198 * PW / (PATM-PW);

                UEF[H]:=WS/(1+WS);

                dat^[UIE,H,M]:=95;

             END;

          END

         ELSE

          BEGIN

             IF  (UEF[H] > USTIEMAX) then

              begin

                 if dat^[EREst,H,M] > 0 then

                  begin

                     dat^[LATEFF,H,M] :=                LATIMP +
                                            (UEF[H]-USTIEMAX) *
                                       Superficie * HSoffitto *
                                              CVAP* calcroest /
                                                          3.6 ;

                  end

                 else dat^[Lateff,H,M]:=0;

                 dat^[UIE,H,M]:=Zone_D^[Zona].UEst + Zone_D^[Zona].TolleranzaU;
                 UEF[H]:=USTIEMAX;

              end;

             if dat^[UIE,H,M] < UIEMin * 100 then

              begin

                 dat^[LATEFF,H,M] :=                LATIMP +
                                        (UEF[H]-USTIEMIN) *
                                   Superficie * HSoffitto *
                                                     CVAP *
                                                calcroest /
                                                      3.6 ;

                 PW:=UIEMin * PWSBS;

                 WS:=0.62198 * PW / (PATM-PW);

                 UEF[H]:=WS/(1+WS);

                 dat^[UIE,H,M]:=UIEMin*100;

              end;

          END;

         if dat^[LATEFF,H,M] < 0 then  dat^[LATEFF,H,M]:=0;

       END;      { FOR H:=0 TO 23 DO........ }

    END;

  END;    { WITH Ambienti........ DO......... }


END;   { PROC. CalcUmRel }
