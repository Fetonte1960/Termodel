

      {---------------------------  transfer_tab  ----------------------------------}
    FUNCTION TRANSFER_TAB(FileName : ST80) : INTEGER;
      VAR
        FL : FILE OF TabAsh;
        IOERR, N : INTEGER;
      BEGIN
          
        ASSIGN(FL, DATA_DRIVE+FileName+'.ASH');
        {$I-} RESET(FL) {$I+} ;
        IOERR := IORESULT;
        {$I-} READ(FL, RecC0) {$I+} ;
        IOERR := IORESULT;
        TRANSFER_TAB := IOERR;
        IF IOErr > 0 THEN
          BEGIN
            WRITE(CHR(7));
            CLRSCR; GOTOXY(1, 10);
            WRITELN('ERRORE nella lettura della tabella ', FileName, ' !');
            WRITELN('Il programma non pu• proseguire.');
          END;
        CLOSE(FL);
      END;                    { proc. transfer_tab }


      {------------------------------  insert_line  --------------------------------}
    FUNCTION INSERT_LINE(IND : LINK; Posizione : INTEGER) : BOOLEAN;
      VAR
        I, N, O : INTEGER;
        CH : CHAR;

        {--------------------------------  ult_line  ---------------------------------}
      FUNCTION ULT_LINE(IND : LINK) : INTEGER;
        VAR
          I : INTEGER;
          FEND : BOOLEAN;
        BEGIN
          FEND := FALSE;
          I := 0;
          REPEAT
            I := I+1;
            IF SETLEFT(IND^.T[I].CodPezzo) = '' THEN
              BEGIN
                I := I-1;
                FEND := TRUE
              END;
          UNTIL FEND OR (I > NCompRamo);
          IF Fend THEN ULT_LINE := I
          ELSE Ult_Line := 0;
        END;                  { func. ult_line }

        {------------------------------  codtab_form  --------------------------------}
      FUNCTION CODTAB_FORM(CodTab : INTEGER) : ST5;
        VAR
          ComSt : ST5;
        BEGIN
          STR(CodTab, ComSt);
          CASE CodTab OF
            0..9 : ComST := '00'+ComSt;
            10..99 : ComSt := '0'+ComSt;
          END;
          CODTAB_FORM := FORMAT(ComSt, 3);
        END;                  { proc. codtab_form }

      BEGIN
        I := ULT_LINE(IND);
        IF I = NCompRamo THEN
          BEGIN
            SOUND(100); DELAY(200); NOSOUND;
            GOTOXY(1, 24);
            WRITE('Spazio insufficiente per inserire un''altra riga nella tabella nø ', CODTAB_FORM(IND^.CodTab));
            GOTOXY(1, 25); WRITE('Premere un tasto per continuare.');

            READ(KBD, CH);

            GOTOXY(1, 24); CLREOL; GOTOXY(1, 25); CLREOL;
            INSERT_LINE := FALSE;
          END
        ELSE
          BEGIN
            IF I >= Posizione THEN
              BEGIN
                FOR N := I DOWNTO Posizione DO IND^.T[N+1] := IND^.T[N];

                INIT_LINE(IND, N);

              END;            { if i>=1 then .......}
            INSERT_LINE := TRUE;
          END;                { else......... }
      END;                    { func.  insert_line }

