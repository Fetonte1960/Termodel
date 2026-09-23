    {-------------------------------  datigen  -----------------------------------}
   PROCEDURE DatiGen(Flag : CHAR);
    CONST
      ViscBase = 0.0181598; DensBase = 1.204;
    VAR
      fd1 : FILE OF DatiProg1;
      fd2 : FILE OF DatiProg2;
      NM, Campo, Chiave : INTEGER;
      W : BOOLEAN;
      KT, KE, KH : REAL;
    BEGIN
      WITH DPr1^ DO
        BEGIN
          Cliente := ''; Localita := ''; Progettista := ''; Impianto := '';
          NOrdine := ''; Disegno := ''; Riferimento := '';
          Edificio := ''; Sistema := ''; Zona := '';
          Circuito := '';
          AltSulMare := 0; Altezza := 0;
          TempAria := 20; UmRel := 0;
        END;

      WITH DPr2^ DO
        BEGIN
          Visc := ViscBase; Dens := DensBase;
          RivestInt := '';
          SpessRivest := 0; Rugosita := 0.15;
          TipoSezione := '';
          Rapp := 0.5; DimW := 2000; DimH := 2000;
          DPuMTronco := 0.8; MinTronco := 0.7; MaxTronco := 1.5; VelTronco := 12;
          DPuMRami := 0.8; MinRami := 0.7; MaxRami := 1.5; VelRami := 12;
          SbilDPu := 10; SerrTermMax := 30; SerrDPuMin := 10;
          VCostante := 0;
        END;
(*
      IF Flag = 'C' THEN
        BEGIN
          ASSIGN(Fd1, DATA_DRIVE+NomeFile+'.GN1');
          {$I-} RESET(Fd1) {$I+} ;
          IF IORESULT = 0 THEN READ(fd1, DPr1^);
          CLOSE(fd1);
          ASSIGN(Fd2, DATA_DRIVE+NomeFile+'.GN2');
          {$I-} RESET(Fd2) {$I+} ;
          IF IORESULT = 0 THEN READ(fd2, DPr2^);
          CLOSE(fd2);


          NM := 1;

          REPEAT
            Campo := 1;
            W := TRUE;
            CLRSCR;
            REPEAT
              CASE NM OF
                1 :
                  BEGIN
                    UsaMaskera(SEG(DPr1^), OFS(DPr1^), DATA_DRIVE+'RIF1.msk', Campo, Chiave, grigioligth,
                    bianco, W, TRUE, FALSE);
                    WITH DPr1^ DO
                      KE := Elev(1-(2.2557*0.00001)*AltSulMare, 4.73);
                    WITH DPr1^ DO
                      KT := Elev(293/(TempAria+273), 0.825);
                    KH := 1;
                    WITH DPr2^ DO
                      BEGIN
                        Dens := KT*KE*KH*DensBase;
                        Visc := KT*ViscBase;
                      END;
                  END;

                2 : UsaMaskera(SEG(DPr2^), OFS(DPr2^), DATA_DRIVE+'RIF2.msk', Campo, Chiave, grigioligth,
                  bianco, W, TRUE, FALSE);
              END;
              W := FALSE;
            UNTIL Chiave IN [10, 27];
            NM := 3-NM;
          UNTIL Chiave = 27;
        END;  *)

      //ASSIGN(Fd1, driveprog+NomeFile+'.GN1');
      //{$I-} REWRITE(Fd1) {$I+} ;
      //IF IORESULT = 0 THEN WRITE(fd1, DPr1^);
      //CLOSE(fd1);
      //ASSIGN(Fd2, driveprog+NomeFile+'.GN2');
      //{$I-} REWRITE(Fd2) {$I+} ;
      //IF IORESULT = 0 THEN WRITE(fd2, DPr2^);
      //CLOSE(fd2);

    END;                      { proc.  datigen }

(*
    {-------------------------------  menumand  ---------------------------------}
   PROCEDURE MenuMand(VAR Scelta : INTEGER);
    VAR f : FILE OF INTEGER;
    BEGIN

      ASSIGN(f, DATA_DRIVE+'Scelta.clc');
      REWRITE(f);
      Scelta := UsaMenu(DATA_DRIVE+'menucalc.mnu', 9);
      WRITE(f, Scelta);
      CLOSE(f);
      TEXTCOLOR(Col[2]); TEXTBACKGROUND(Col[1]);

    END;

    {-------------------------------  menurip  ---------------------------------}
   PROCEDURE MenuRip(VAR Scelta : INTEGER);
    VAR f : FILE OF INTEGER;
    BEGIN
      {
      ASSIGN(f, DATA_DRIVE+'Scelta.clc');
      Scelta := UsaMenu(DATA_DRIVE+'menuRip.mnu', 10);
      TEXTCOLOR(Col[2]); TEXTBACKGROUND(Col[1]);
      REWRITE(f);
      WRITE(f, Scelta);
      CLOSE(f);
      }
    END;
*)