  OVERLAY PROCEDURE SerTerm(flag : INTEGER);
    VAR
      SC, SR : st5;

    PROCEDURE WRITEPT(P0 : LINK);
      BEGIN
        GOTOXY(1, 22);
        WRITE('Ps=');
        IF P0^.Ps = NIL THEN WRITE('NIL') ELSE WRITE('***');
        WRITE('  Pd=');
        IF P0^.Pd = NIL THEN WRITE('NIL') ELSE WRITE('***');
        WRITE('  Pc=');
        IF P0^.Pc = NIL THEN WRITE('NIL') ELSE WRITE('***');
      END;

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
      END;                    { proc. codtab_form }

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
        UNTIL FEND OR (I = NCompRamo);
        ULT_LINE := I;
      END;                    { func. ult_line }

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
      BEGIN
        I := ULT_LINE(IND);
        IF I = NCompRamo THEN
          BEGIN
            SOUND(100); DELAY(200); NOSOUND;
            GOTOXY(1, 22);
            WRITE('Spazio insufficiente per inserire un''altra riga nella tabella nø ', CODTAB_FORM(IND^.CodTab)); CLREOL;
            GOTOXY(1, 23); WRITE('Premere un tasto per continuare.'); CLREOL;

            READ(KBD, CH);

            GOTOXY(1, 22); CLREOL; GOTOXY(1, 23); CLREOL;
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

      {------------------------------  cercatabella  -------------------------------}
    FUNCTION CercaTabella(N : INTEGER) : LINK;
      VAR
        Trovata : BOOLEAN;
        TrovIND : LINK;
        {----------------  trova  ------------------}
      PROCEDURE Trova(IND : LINK);
        BEGIN
          IF (IND <> NIL) AND NOT Trovata THEN
            BEGIN
              IF IND^.CodTab = N THEN
                BEGIN
                  Trovata := TRUE;
                  TrovIND := IND;
                END;
              Trova(IND^.Ps);
              Trova(IND^.Pc);
              Trova(IND^.Pd);
            END;
        END;

        {------------  main of cercatabella  -------------}
      BEGIN
        Trovata := FALSE;
        Trova(P0);
        CercaTabella := TrovIND;
      END;                    { func.  cercatabella }


      {-----------------------------    calcperd     -------------------------------}
    FUNCTION CalcPerd(IND : LINK) : REAL;
        { Calcola le perdite per attrito dei pezzi di uno stesso tronco e restituisce
        la somma delle perdite.                                                     }
      VAR
        O, U : INTEGER;
        PerdSum : REAL;
      BEGIN
        PerdSum := 0;

        U := ULT_LINE(IND);
        FOR O := 0 TO U DO
          WITH IND^.T[O] DO
            PerdSum := PerdSum+Perdita;
        CalcPerd := PerdSum;
      END;                    { funct.  calcperd }


      {--------------------------    calcolaperdite    -----------------------------}
    FUNCTION CalcolaPerdite(IND : LINK; PerdPr : REAL) : REAL;
        { calcola le perdite per i rami che dipendono da ind }
      VAR
        MaxPerdita : REAL;

        {----------------------------    trova     -------------------------------}
      PROCEDURE Trova(IND : LINK; PerdPr : REAL);
        VAR O : BYTE;

        BEGIN
          IF IND <> NIL THEN
            BEGIN
              PerdPr := PerdPr+CalcPerd(IND);
              IF MaxPerdita < PerdPr THEN MaxPerdita := PerdPr;

              Trova(IND^.Ps, PerdPr);
              Trova(IND^.Pc, PerdPr);
              Trova(IND^.Pd, PerdPr);
            END;
        END;                  { proc. trova }

        {*************** calcolaperdite *****************}
      BEGIN
        MaxPerdita := 0;
        Trova(IND, PerdPr);
        CalcolaPerdite := MaxPerdita;
      END;                    { proc. calcolaperdite }


      {------------------------------  serrandeterm  -------------------------------}
    PROCEDURE SerrandeTerm(IND : LINK);
      VAR
        I : INTEGER;

        {----------------------------    trova     -------------------------------}
      PROCEDURE Trova(INDPADRE, IND : LINK; PerdPr : REAL);
        VAR AttPerd : REAL;   { somma delle perdite degli elementi del nodo attuale    }
        BEGIN
          AttPerd := PerdPr+CalcPerd(Ind);
          IF (IND <> NIL) AND (IND^.Ps = NIL) AND (IND^.Pc = NIL) AND (IND^.Pd = NIL) THEN
            BEGIN

              IF PerditaMax-AttPerd > 0 THEN
                BEGIN
                  { inserimento serranda automatico prima del  }
                  I := ULT_LINE(IND); { diffusore }

                  IF INSERT_LINE(IND, I) THEN
                    WITH IND^.T[I] DO
                      BEGIN
                        CASE UPCASE(ARCHIVIO[FIND_ARCHIVIO(IND^.T[I+1].CodPezzo)].TipoSez[1]) OF
                          'C', 'D':CodPezzo := SC;
                          'R', 'A', 'H':CodPezzo := SR;
                        END;

                        Descr := ARCHIVIO[FIND_ARCHIVIO(CodPezzo)].Descr;
                        Portata := IND^.T[I+1].Portata;

                        Perdita := PerditaMax-AttPerd;
                        IF Perdita > DPr2.SerrTermMax THEN Perdita := DPr2.SerrTermMax;
                        ComVal := Perdita;
                        GOTOXY(1, 21);
                        WRITE('Da Nodo ');
                        IF INDPADRE = NIL THEN WRITE('000')
                        ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));
                        WRITE('  a nodo ', CODTAB_FORM(IND^.CodTab));
                        GOTOXY(1, 22); CLREOL;
                        GOTOXY(1, 22); WRITE('Inserimento serranda su terminale con perdita (Pa) :');
                        GOTOXY(54, 22); WRITE(ComVal:8:3);
                        A_D := IND^.T[I+1].A_D;
                        H := IND^.T[I+1].H;
                        W := IND^.T[I+1].W;
                        IND^.T[NCompRamo+1].Perdita := IND^.T[NCompRamo+1].Perdita+Perdita;
                      END;    { with ind^.t[i]   }
                END;

            END;              { if (ind<>nil) and (ind^.ps=nil) and (ind^.pc=nil) and (ind^.pd=nil).......... }

          IF ind <> NIL THEN
            BEGIN
              Trova(IND, IND^.Pc, AttPerd);
              Trova(IND, IND^.Ps, AttPerd);
              Trova(IND, IND^.Pd, AttPerd);
            END;
        END;                  { proc. trova }

        {************** serrandeterm **************}
      BEGIN
        Trova(NIL, IND, 0);
      END;                    { proc. serrandeterm }




      {---------------------------  eliminaserterm  -----------------------------}
    PROCEDURE EliminaSerTerm;

        {-------------------------------  delete_line  -----------------------------}
      PROCEDURE DELETE_LINE(IND : LINK; N : INTEGER);
        VAR
          O, U : INTEGER;
        BEGIN
          U := ULT_LINE(IND);
          FOR O := N TO U-1 DO IND^.T[O] := IND^.T[O+1];
          INIT_LINE(IND, U);
        END;                  { proc. delete_line }

      FUNCTION EQUI(C1, C2 : st5) : BOOLEAN;
        VAR i : INTEGER;
          B : BOOLEAN;
        BEGIN

          IF C1 = '' THEN B := FALSE
          ELSE
            BEGIN
              i := 1;
              REPEAT
                B := (UPCASE(C1[i]) = UPCASE(C2[i]));
                i := i+1;
              UNTIL NOT B OR (I > LENGTH(C2));
            END;
          EQUI := B;
        END;

        {------------------------------   elimina   --------------------------------}
      PROCEDURE Elimina(IND : LINK);
        VAR
          I, U, J : INTEGER;
        BEGIN
          U := ULT_LINE(IND);
          I := 1;
          REPEAT
            WITH Ind^.T[I] DO
              IF EQUI(CodPezzo, SR) OR EQUI(CodPezzo, SC) THEN
                BEGIN
                  DELETE_LINE(IND, I);
                  U := Ult_Line(Ind);
                END
              ELSE I := I+1;
          UNTIL I > U;

        END;                  { proc.  elimina }

        {-----------------------------    trova      -------------------------------}
      PROCEDURE Trova(IND : LINK);
        BEGIN
          IF IND <> NIL THEN
            BEGIN
              Elimina(IND);
              Trova(IND^.Ps);
              Trova(IND^.Pc);
              Trova(IND^.Pd);
            END;
        END;                  { proc. trova }

        {********************   main   of   eliminaserterm   *********************}
      BEGIN
        Trova(P0);
      END;                    { proc. eliminaserterm }



      {-----------------------------  main of serterm  ------------------------------}
    VAR
      N : INTEGER;
    BEGIN
      DATA_DRIVE := 'C:\DATICCA\';

      ASSIGN(frid, DATA_DRIVE+'SerrRett.dat');
      RESET(frid); READLN(frid, SR); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'SerrCirc.dat');
      RESET(frid); READLN(frid, SC); CLOSE(frid);

      SYSTEM_DRIVE := '';

      TEXTCOLOR(grigioligth);
      EliminaSerTerm;
      IF (flag = 1) THEN
        BEGIN
          PerditaMax := CalcolaPerdite(P0, 0);
          GOTOXY(1, 23); WRITE('Perdita massima (Pa) : ', PerditaMax:5:2); CLREOL;
          SerrandeTerm(P0);
        END;
    END;
