
      {-----------------------------  carica_albero --------------------------------}
    PROCEDURE CARICA_ALBERO(NomeFile : ST18);

      VAR
        Fl : FILE OF TabRamo;
        fd1 : FILE OF DatiProg1;
        fd2 : FILE OF DatiProg2;
        IOERR, Campo, Chiave : INTEGER;

    {-----------------------------    transfer    -------------------------------}
      PROCEDURE TRANSFER(VAR IND : LINK);

        BEGIN

          IF ((NOT(IND.riga = 0)) AND (IOERR = 0)) OR (P0 = 0) THEN
            BEGIN
              //NEW(IND);
              //IF P0 = NIL THEN P0:=IND;
              //{$I-} READ(Fl, IND^) {$I+} ;
              Wnodo(ind);
              IOERR := IORESULT;
              //TRANSFER(IND^.Pc);
              //TRANSFER(IND^.Ps);
              //TRANSFER(IND^.Pd);
             END;
        END;                  { proc. transfer }

        {--------------  main of carica_albero  -------------}
      BEGIN
        if exist(DRIVEprog+NomeFile+'.CAN') then
         begin
            ASSIGN(Fl, DRIVEprog+NomeFile+'.CAN');
            RESET(Fl);
            P0 := 0;
            wfase(w_m(59));{*TR*}
            //TRANSFER(P0);
            CLOSE(Fl);
            if exist(DRIVEprog+NomeFile+'.GN1') then
             begin
                ASSIGN(Fd1, DRIVEprog+NomeFile+'.GN1');
                RESET(Fd1) ;
                READ(fd1, DPr1^);
                CLOSE(fd1);
             end;
            if exist(DRIVEprog+NomeFile+'.GN2') then
             begin
                ASSIGN(Fd2, DRIVEprog+NomeFile+'.GN2');
                RESET(Fd2);
                READ(fd2, DPr2^);
                CLOSE(fd2);
             end;
         end;
      END;                    { proc.  carica_albero }

      {-----------------------------  salva_albero ---------------------------------}
    PROCEDURE SALVA_ALBERO(NomeFile : ST18);

      VAR
        Fl : FILE OF TabRamo;
        fd1 : FILE OF DatiProg1;
        fd2 : FILE OF DatiProg2;
        IOERR, Campo, Chiave : INTEGER;
        {------------------------------    transfer    -------------------------------}
      PROCEDURE TRANSFER(IND : LINK);
        BEGIN
        //  IF (NOT(IND = NIL)) AND (IOERR = 0) THEN
            BEGIN
              Wnodo(ind);
        //      {$I-} WRITE(Fl, IND^) {$I+} ;
              IOERR := IORESULT;
            //  TRANSFER(IND^.Pc);
             // TRANSFER(IND^.Ps);
            //  TRANSFER(IND^.Pd);
            END;
        END;                  { proc. transfer }

        {--------------  main of salva_albero  -------------}
      BEGIN
        ASSIGN(Fl, DRIVEprog+NomeFile+'.CAN');
        {$I-} REWRITE(Fl) {$I+} ;
        IOERR := IORESULT;
        WFase(w_m(60));{*TR*}
       // TRANSFER(P0);
        CLOSE(Fl);
      END;                    { proc.  salva_albero }

