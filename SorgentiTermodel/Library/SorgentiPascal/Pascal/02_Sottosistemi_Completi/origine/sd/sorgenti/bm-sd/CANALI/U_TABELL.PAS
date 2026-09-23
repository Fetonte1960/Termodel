{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit U_TAbell;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  utilitie,
  definiz,
  u_funz;

    PROCEDURE edit_tab;

implementation


   PROCEDURE edit_tab;

    VAR
      N : INTEGER;
      UnUsedIND : ARRAY[1..2000] OF LINK;
      NUnUsed : INTEGER;      { Indica il primo puntatore disponibile in UnUsedIND;
                              il valore 0 indica che l'array Š vuoto               }

      Directory : ARRAY[0..1000] OF BOOLEAN;

      fp : TEXT;

    PROCEDURE beep;
      BEGIN
        SOUND(440);
        DELAY(500);
        NOSOUND;
      END;


    PROCEDURE WRITEPT(P0 : LINK);
      BEGIN
        GOTOXY(1, 22);
        WRITE('Main:');
        IF P0^.Pc = NIL THEN WRITE(' - ') ELSE WRITE(CodTab_Form(P0^.Pc^.CodTab));
        WRITE('  Branch1:');
        IF P0^.Ps = NIL THEN WRITE(' - ') ELSE WRITE(CodTab_Form(P0^.Ps^.CodTab));
        WRITE('  Branch2:');
        IF P0^.Pd = NIL THEN WRITE(' - ') ELSE WRITE(CodTab_Form(P0^.Pd^.CodTab));

      END;


    PROCEDURE InitDir(P : Link);
      BEGIN
        IF P <> NIL THEN
          BEGIN
            Directory[P^.CodTab] := TRUE;
            InitDir(P^.Pc);
            InitDir(P^.Ps);
            InitDir(P^.Pd);
          END;
      END;




{------------------------------    rete    -----------------------------------}
    PROCEDURE RETE(IND, INDPadre : LINK; Dir : INTEGER);
      VAR indicetabellatrovata, PadreTrovata : link;
        f99 : FILE OF INTEGER;
        g : TEXT;
        nprog : st18;
        nn : INTEGER;
        metri : INTEGER;
        petot : REAL;
        {------------------------------  cercatabella  -------------------------------}
      FUNCTION CercaTabella(N : INTEGER) : LINK;
        VAR
          Trovata : BOOLEAN;
          TrovIND : LINK;
          Padre : link;
          {------------------  sumperd  ----------------}
        FUNCTION SumPerd(IND : LINK; N : INTEGER) : REAL;
          VAR
            I : INTEGER;
            P : REAL;
          BEGIN
            P := 0;
            FOR I := 0 TO N DO
              WITH Ind^.T[i] DO
                IF CodPezzo > '' THEN P := P+Perdita;
            SumPerd := P;
          END;

          {----------------  trova  ------------------}
        PROCEDURE Trova(Padre, IND : LINK; petot : REAL);
          VAR o : INTEGER;
          BEGIN
            IF (IND <> NIL) AND NOT Trovata THEN
              BEGIN
                o := ult_line(ind);
                petot := petot+sumperd(ind, o);
                IF IND^.CodTab = N THEN
                  BEGIN
                    Trovata := TRUE;
                    TrovIND := IND;
                    PadreTrovata := Padre;
                  END;
                Trova(Ind, IND^.Pc, petot);
                Trova(Ind, IND^.Ps, petot);
                Trova(Ind, IND^.Pd, petot);
              END;
          END;

          {------------  main of cercatabella  -------------}
        BEGIN
          Trovata := FALSE; TrovInd := NIL;
          Padre := NIL; petot := 0;
          Trova(Padre, P0, petot);
          CercaTabella := TrovIND;
        END;                  { func.  cercatabella }


        {----------------------------------  scroll  ---------------------------------}
      PROCEDURE SCROLL(RigaStart, NRighe : INTEGER; CH1 : CHAR);
          { Scroll del video a partire da StartRow per NRighe in basso;
          CH puo valere 'U' o 'D' a seconda se serve scroll UP o DOWN  }

          { le colonne start=1 & end=80 rimangono costanti }
        CONST
          ColStart = 2;
          ColEnd = 79;
        VAR
          RESULT : Record
                      Case integer of
                        0:  (AX,BX,CX,DX,BP,SI,DI,DS,ES,FLAGS:WORD);
                        1:  (AL,AH,BL,BH,CL,CH,DL,DH: Byte);
                   END;

        BEGIN
          WITH RESULT DO
            BEGIN
              IF CH1 = 'U' THEN AX := 6*256+1 ELSE AX := 7*256+1;
              CX := (RigaStart-1)*256+(ColStart-1);
              DX := (RigaStart+NRighe-2)*256+(ColEnd-1);
              BX := 0;
            END;

          INTR(16, DOS.REGISTERS(RESULT));
        END;                  { proc. scroll }

        {----------------------------  change_attrib  --------------------------------}
      PROCEDURE CHANGE_ATTRIB(Riga, Colonna, Lunghezza : INTEGER; Attrib : BYTE);
          { Setta gli attributi dei caratteri a partire da Riga (Y),Colonna (X) per
          Lunghezza ( n caratteri da modificare ) col valore Attrib }

        VAR
          I, F : INTEGER;
          RESULT : Record
                      Case integer of
                        0:  (AX,BX,CX,DX,BP,SI,DI,DS,ES,FLAGS:WORD);
                        1:  (AL,AH,BL,BH,CL,CH,DL,DH: Byte);
                   END;

        BEGIN
          RESULT.CX := 1;
          RESULT.BX := Attrib;
          FOR I := Colonna TO Colonna+Lunghezza-1 DO
            BEGIN
              GOTOXY(I, Riga);
              WITH RESULT DO
                BEGIN
                  AX := 2048;
                  INTR(16, Registers(RESULT));
                  AX := (AX AND 255)+2304;
                  INTR(16, Registers(RESULT));
                END;
            END;
        END;                  { proc. change_attrib }


        {---------------------------  init_ramo  -------------------------------------}
      PROCEDURE INIT_RAMO(VAR RAMO : LINK; INDPadre : LINK; Dir : INTEGER);
          { Crea un nuovo puntatore o ne utilizza uno disponibile in UnUsedIND e procede
          all'inizializzazione dei campi di questa nuova tabella.
          Grazie a INDPadre e Dir viene aggiornata la situazione di uno dei 3
          puntatori della tabella padre o quella di P0 se si tratta del primo elemento
          dell'albero }

        VAR
          I : INTEGER;
          F : BOOLEAN;
          CH : CHAR;

        BEGIN
          IF RAMO = NIL THEN
            BEGIN
              NEW(RAMO);
              Modifica_Ramo := FALSE;

              FOR I := 0 TO NCompRamo+1 DO INIT_LINE(RAMO, I);

              WITH RAMO^ DO
                BEGIN
                  Ps := NIL; Pd := NIL; Pc := NIL;
                  CodTab := -1; TR := FALSE;
                END;

              IF INDPadre = NIL THEN P0 := RAMO
              ELSE
                CASE Dir OF
                  1 : INDPadre^.Ps := RAMO;
                  2 : INDPadre^.Pd := RAMO;
                  3 : INDPadre^.Pc := RAMO;
                END;

              I := 1;
              WHILE Directory[I] AND (I < 1000) DO I := I+1;
              RAMO^.CodTab := I;
              Directory[I] := TRUE;
            END;              { if ramo=nil }
        END;                  { proc. init_ramo }

        {---------------------------------  box  -------------------------------------}
      PROCEDURE BOX(SX, SY, LX, LY, COL, BAK : INTEGER);
          { Disegna un rettangolo a partire dalla coordinata SX,SY (angolo in alto sin.)
          di dimensioni LX*LY }
        VAR
          I : INTEGER;
          S1, S2 : STRING[80];
        BEGIN
          TEXTCOLOR(COL);
          TEXTBACKGROUND(BAK);

          S1 := CHR(201);
          FOR I := 1 TO LX-2 DO S1 := S1+CHR(205);
          S1 := S1+CHR(187);
          GOTOXY(SX, SY);
          WRITE(S1);
          FOR I := 1 TO LY-2 DO
            BEGIN
              GOTOXY(SX, SY+I); WRITE(CHR(186));
              GOTOXY(SX+LX-1, SY+I); WRITE(CHR(186));
            END;
          GOTOXY(SX, SY+LY-1);
          S1[1] := CHR(200);
          S1[LX] := CHR(188);
          WRITE(S1);
        END;                  { proc. box }



        {-------------------------------  insert_nodo  -------------------------------}
      FUNCTION INSERT_NODO(VAR IND : LINK; INDPadre : LINK; Dir, NRiga : INTEGER) : BOOLEAN;
          { Crea una nuova tabella se viene aggiunta una derivazione in mezzo ad una
          lista di componenti di un ramo in modo che ogni tabella contenga una sola
          derivazione }
        VAR
          PUN : LINK;
          I, N, Ult : INTEGER;
          F : BOOLEAN;
          CH : char;
        BEGIN
          { nriga e` il numero della riga in cui c'e` la nuova derivazione }
          Ult := NCompRamo;
          WHILE (Ult > NRiga) AND (SETLEFT(IND^.T[Ult].CodPezzo) = '') DO Ult := Ult-1;
          { ult=posizione ultimo elemento tabella originale non sdoppiata }

          IF NRiga = Ult THEN
            BEGIN
              INSERT_NODO := FALSE;
              EXIT;
            END
          ELSE INSERT_NODO := TRUE;

          GOTOXY(1, 24);
          WRITE('Confermi l''inserimento del nodo [S/N] ');
          REPEAT
            F:=READ_KBD(CH,1);
            CH:=UPCASE(CH);
          UNTIL ((CH ='S') or (CH ='N')) and Not F ;
          GOTOXY(1, 24); CLREOL;

          IF CH ='N' THEN
            BEGIN
              INSERT_NODO := FALSE;
              EXIT;
            END;

          PUN := NIL;
          INIT_RAMO(PUN, INDPadre, Dir);
          PUN^.Pc := IND;

          FOR I := 1 TO NRiga DO PUN^.T[I] := IND^.T[I]; { copia le righe fino allo
                                                         sdoppio nella nuova tabel-
                                                         la.                       }

          FOR N := NRiga+1 TO Ult DO IND^.T[N-NRiga] := IND^.T[N];

          FOR N := Ult-NRiga+1 TO Ult DO INIT_LINE(IND, N);

          IND := PUN;
        END;                  { func. insert_nodo }


        {---------------------------------  delete_nodo  -----------------------------}
      PROCEDURE DELETE_NODO(IND, INDPadre : LINK; Dir : INTEGER);
          { Deleta tutto il ramo che dipende da IND e IND stesso tornando al livello di
          INDPadre. I puntatori che non servono piu` vengono salvati in UnUsedIND per
          riutilizzarli in seguito }
        BEGIN

          IF IND^.Ps <> NIL THEN DELETE_NODO(IND^.Ps, IND, 1);
          IF IND^.Pd <> NIL THEN DELETE_NODO(IND^.Pd, IND, 2);
          IF IND^.Pc <> NIL THEN DELETE_NODO(IND^.Pc, IND, 3);
          IF (IND^.Ps = NIL) AND (IND^.Pd = NIL) AND (IND^.Pd = NIL) THEN
            BEGIN
              NUnUsed := NUnUsed+1;
              UnUsedIND[NUnUsed] := IND;
              CASE Dir OF
                1 : INDPadre^.Ps := NIL;
                2 : INDPadre^.Pd := NIL;
                3 : INDPadre^.Pc := NIL;
              END;
              IF (INDPadre = NIL) AND (IND = P0) THEN P0 := NIL;
              Directory[IND^.CodTab] := FALSE;
            END;

        END;                  { proc.  delete_nodo }


        {--------------------------------  edit_ramo  --------------------------------}
      FUNCTION EDIT_RAMO(VAR RAMO : LINK; INDPadre : LINK;
                         Dir : INTEGER;
                         PerditaTot : REAL) : BYTE;
        LABEL
          StartEdit;

        CONST
          StartRow : INTEGER = 7;
          NRighe : INTEGER = 10;
          LarghTot : INTEGER = 78;

        VAR
          StartPage : INTEGER; { prima riga dei blocchi da visualizzare }
          Riga : INTEGER;     { riga in edit }
          Campo : INTEGER;    { campo in edit }
          HoldCampo : INTEGER; { ultimo campo prima di editare il valore aggiuntivo }
          XCampo, YCampo : INTEGER; { posizioni x e y del campo in edit }
          RifArch : INTEGER;  { indice di archivio per la riga attualmente in edit }
          Len : INTEGER;      { lunghezza del campo in edit }
          Tipo : INTEGER;
          CurPos : INTEGER;
          Error : INTEGER;
          ComST, SvST : ST80;
          FEND, F : BOOLEAN;
          I, N, O, W, IOERR : INTEGER;
          ExitChar, CH : CHAR;
          FlagIND : BOOLEAN;
          ModoVis : BYTE;
          V : REAL;
          ComIND, P1, P2, P3 : LINK;
          NCampi : INTEGER;
          Cifre, Dec : INTEGER;
          {------------------  sumperd  ----------------}
        FUNCTION SumPerd(IND : LINK; N : INTEGER) : REAL;
          VAR
            I : INTEGER;
            P : REAL;
          BEGIN
            P := 0;
            FOR I := 0 TO N DO
              WITH Ind^.T[i] DO
                IF CodPezzo > '' THEN P := P+Perdita;
            SumPerd := P;
          END;

          {-----------------------------  display_riga_ramo  ---------------------------}
        PROCEDURE DISPLAY_RIGA_RAMO(N : INTEGER);
          VAR
            ComST, ComST2 : STRING[80];
            DpProg : REAL;
            U, R : INTEGER;
          BEGIN
            U := ULT_LINE(RAMO);
            GOTOXY(2, StartRow+N-1);
            IF N = 0 THEN R := 0 ELSE R := StartPage+N-1;
            if (RAMO^.T[R].Phi < 0) or (RAMO^.T[R].Phi > 360) then RAMO^.T[R].Phi:=0;
            WITH RAMO^.T[R] DO
              CASE ModoVis OF
                1 : BEGIN
                      ComST := FORMAT(CodPezzo, 5)+#179;
                      ComST := ComST+FORMAT(Descr, 40)+#179;

                      ComST := ComST+CHFlag+#179; { visualizzazione flag ' ' o '*' }

                      IF A_D = 0 THEN ComST2 := '' ELSE STR(A_D:4, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 4)+#179;

                      IF W = 0 THEN ComST2 := '' ELSE STR(W:4, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 4)+#179;

                      IF H = 0 THEN ComST2 := '' ELSE STR(H:4, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 4)+CHR(179);

                      IF L = 0 THEN ComST2 := '' ELSE STR(L:5:2, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 6)+#179;

                      IF Ang = 0 THEN ComST2 := '' ELSE STR(Ang:3, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 3);
                    END;
                2 : BEGIN
                      ComST := FORMAT(CodPezzo, 5)+#179;
                      ComST := ComST+FORMAT(Descr, 40)+#179;

                      IF R = 0 THEN ComST2 := '' ELSE STR(R:2:1, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 4)+#179;

                      IF Portata = 0 THEN ComST2 := '' ELSE STR((Portata*metri):4:3, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 5)+#179;

                      IF (C0 = 0) OR (C0 >= 9999) THEN ComST2 := '' ELSE STR(C0:4:3, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 5)+#179;

                      IF Perdita = 0 THEN ComST2 := '' ELSE STR(Perdita:5:2, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 6)+#179;

                      IF StartPage+N-1 <= U THEN DpProg := PerditaTot+SumPerd(RAMO, StartPage+N-1)
                      ELSE DpProg := 0;
                      IF DpProg = 0 THEN ComST2 := '' ELSE STR(DpProg:5:2, ComST2);
                      ComST := ComST+FORMAT(SETLEFT(ComST2), 6);
                    END;
              END;
            WRITE(FORMAT(ComST, LarghTot));
          END;                { proc. display_riga_ramo }

          {--------------------------  display_page_ramo  ------------------------------}
        PROCEDURE DISPLAY_PAGE_RAMO;
          VAR
            I : INTEGER;
          BEGIN
            TEXTCOLOR(col[2]);
            TEXTBACKGROUND(col[1]);
            IF ModoVis = 1 THEN
              BEGIN
                GOTOXY(2, StartRow-3);
                WRITE(FORMAT('Cod  '+#179+FORMAT('   Descrizione', 40)+#179+' '
                +#179+' D  '+#179+' A  '+#179+' B  '
                +#179+' L    '+#179+'Angolo', LarghTot));
                GOTOXY(2, StartRow-2);
                WRITE(FORMAT('     '+#179+FORMAT('', 40)+#179+' '
                +#179+'[mm]'+#179+'[mm]'+#179+'[mm]'
                +#179+'  [m] '+#179+'[Deg] ', LarghTot));
              END
            ELSE
              BEGIN
                GOTOXY(2, StartRow-3);
                WRITE(FORMAT('Cod  '+#179+FORMAT('   Descrizione', 40)
                +#179+' R  '+#179+'  Q  '+#179+' Co  '
                +#179+'Perd. '+#179+'Dp prog', LarghTot));
                GOTOXY(2, StartRow-2);
                WRITE(FORMAT('     '+#179+FORMAT('', 40)
                +#179+'r/a '+#179+MaskMc+#179+'     '
                +#179+' [Pa] '+#179+' [Pa]  ', LarghTot));
              END;

            TEXTCOLOR(Col[2]);
            TEXTBACKGROUND(Col[1]);

            FOR I := 0 TO NRighe DO DISPLAY_RIGA_RAMO(I);
          END;                { proc. display_page_ramo }

          {------------------------------  write_riga_varie  ---------------------------}
        FUNCTION WRITE_RIGA_VARIE(RifArch : INTEGER) : INTEGER;
          BEGIN
            IF RifArch < 0 THEN RifArch := FIND_ARCHIVIO(RAMO^.T[StartPage+Riga-1].CodPezzo);
            GOTOXY(1, 20); CLREOL;
            IF RifArch > 0 THEN
              BEGIN
                GOTOXY(1, 20);
                WRITE(ARCHIVIO[RifArch].Varie);
                IF ARCHIVIO[RifArch].Varie > '' THEN
                  BEGIN
                    IF RAMO^.T[StartPage+Riga-1].ComVal = 0 THEN ComST := ''
                    ELSE STR(RAMO^.T[StartPage+Riga-1].ComVal:8:3, ComST);
                    GOTOXY(LENGTH(ARCHIVIO[RifArch].Varie)+1, 20);
                    WRITE(SETLEFT(ComST));
                  END;
              END;
            WRITE_RIGA_VARIE := RifArch;
          END;


        BEGIN
          StartEdit:
          StartPage := 1;
          ModoVis := 1;
          NCampi := 8;
          TEXTCOLOR(Col[2]);
          TEXTBACKGROUND(Col[1]);  {[ ======= ]}
          CLRSCR;

          IF BloccoTab <> NIL THEN
            BEGIN
              IF Ramo^.CodTab = BloccoTab^.CodTab THEN
                BOX(1, StartRow-4, 80, NRighe+5, Col[17] , Col[1])
              ELSE
                BOX(1, StartRow-4, 80, NRighe+5, col[2], col[1]);
            END
          ELSE
            BOX(1, StartRow-4, 80, NRighe+5, col[2], col[1]);


          IF RAMO = NIL THEN FlagIND := TRUE ELSE FlagIND := FALSE;
          INIT_RAMO(RAMO, INDPadre, Dir);

          IF RAMO = NIL THEN BEGIN EDIT_RAMO := 4; EXIT; END;

          DISPLAY_PAGE_RAMO;
          Riga := 1;
          Campo := 1;

          GOTOXY(60, 2); WRITE('a nodo : ', CODTAB_FORM(RAMO^.CodTab));
          GOTOXY(30, 2); WRITE('Da nodo : ');
          IF INDPadre = NIL THEN WRITE('000')
          ELSE WRITE(CODTAB_FORM(INDPadre^.CodTab));

          WRITEPT(RAMO);
          TEXTCOLOR(col[4]);
          GOTOXY(25, 19); WRITE(' Premi SHIFT - F9 Per l'' Help ');
          TEXTCOLOR(col[2]);
          GOTOXY(45, 22); WRITE('Perdita ramo [Pa] : ', SumPerd(RAMO, ULT_LINE(RAMO))+PerditaTot:8:3);

          FEND := FALSE;
          REPEAT
            CHANGE_ATTRIB(Riga+StartRow-1, 2, LarghTot, ColRiga);

            TEXTBACKGROUND(col[3]);  TEXTCOLOR(col[2]);
            GOTOXY(3, 2); WRITE('Riga ', StartPage+Riga-1, '    ');
            RifArch := WRITE_RIGA_VARIE(-1);
            TEXTCOLOR(col[7]); TEXTBACKGROUND(Col[5]);

            Tipo := 0;
            YCampo := Riga+StartRow-1;
            ComST := '';
            WITH RAMO^.T[StartPage+Riga-1] DO
              CASE Campo OF
                1 : BEGIN ComST := CodPezzo; XCampo := 2; Len := 5; Tipo := 3; END;
                2 : BEGIN ComST := Descr; XCampo := 8; Len := 40; Tipo := 3; END;
                3 : IF Modovis = 1 THEN
                      BEGIN
                        IF NOT(CHFlag IN [' ', '*', 'A', 'B']) THEN CHFlag := ' ';
                        Tipo := 3; ComST := ' '; ComST[1] := CHFlag; XCampo := 49; Len := 1;
                      END
                    ELSE
                      BEGIN V := R; XCampo := 49; Len := 4; Cifre := 3; Dec := 1; END;

                4 : IF Modovis = 1 THEN BEGIN V := A_D; XCampo := 51; Len := 4; Cifre := 4; Dec := 0; END
                    ELSE BEGIN V := (Portata*metri); XCampo := 54; Len := 5; Cifre := 4; Dec := 2; END;

                5 : IF Modovis = 1 THEN
                      BEGIN V := W; XCampo := 56; Len := 4; Cifre := 4; Dec := 0; END
                    ELSE
                      BEGIN V := C0; IF V >= 9999 THEN V := 0; XCampo := 60; Len := 5; Cifre := 4; Dec := 3; END;

                6 : IF ModoVis = 1 THEN BEGIN V := H; XCampo := 61; Len := 4; Cifre := 4; Dec := 0; END
                    ELSE BEGIN V := Perdita; XCampo := 66; Len := 6; Cifre := 5; Dec := 2; END;
                7 : IF ModoVis = 1 THEN BEGIN V := L; XCampo := 66; Len := 6; Cifre := 5; Dec := 2; END;
                8 : BEGIN V := Ang; XCampo := 73; Len := 3; Cifre := 3; Dec := 0; END;

                - 1 :BEGIN
                       V := ComVal;
                       Cifre := 8; Dec := 3;
                       Len := 9;
                       XCampo := LENGTH(ARCHIVIO[RifArch].Varie)+1;
                       YCampo := 20;
                     END;
              END;            { case campo of...... }

            IF (Tipo = 0) THEN
              BEGIN
                IF V = 0 THEN ComST := '' ELSE STR(V:Cifre:Dec, ComST);
                ComST := SETLEFT(ComST);
                Tipo := 1;
              END;
            SvST := ComST;
            CurPos := 1;
            REPEAT
              ComST := LINE_INPUT(XCampo, YCampo, Len, CurPos, ' ', ComST, Tipo, ExitChar, TRUE, F,1);

            UNTIL ORD(ExitChar) IN [6, 9, 10, 12, 13, 18, 21, 71, 75,
            77, 72, 80, 73, 92, 81, 27, 86, 68, 93, 94, 59..65];
            IF ORD(ExitChar) = 18 THEN
              BEGIN
                ComST := SvST; GOTOXY(XCampo, Riga+StartRow-1); WRITE(FORMAT(ComST, Len));
              END
            ELSE IF F THEN Modifica_RAMO := TRUE;
            TEXTCOLOR(col[2]);
            TEXTBACKGROUND(col[1]);
            O := ORD(ExitChar);

            IF (Tipo = 1) AND (SETLEFT(ComST) = '') THEN ComST := '0';
            Error := 0;
            IF Tipo = 1 THEN VAL(ComST, V, Error) ELSE V := 0;

            WITH RAMO^.T[StartPage+Riga-1] DO
              CASE Campo OF
                1 : BEGIN
                      CodPezzo := FORMAT(ComST, 5);
                      RifArch := FIND_ARCHIVIO(CodPezzo);
                      IF RifArch > 0 THEN
                        BEGIN
                          IF SETLEFT(ARCHIVIO[RifArch].Descr) > '' THEN
                            Descr := ARCHIVIO[RifArch].Descr;
                          IF NOT(O IN [13, 72, 73, 80, 81]) THEN RifArch := WRITE_RIGA_VARIE(RifArch);
                        END
                      ELSE  Descr := '';
                    END;
                2 : Descr := ComST;
                3 : BEGIN
                      IF ModoVis = 1 THEN
                        BEGIN
                          ComST := SETLEFT(ComST);
                          IF (LENGTH(ComST) = 0) THEN CHFlag := ' '
                          ELSE IF UPCASE(ComST[1]) IN ['*', 'A', 'B'] THEN CHFlag := UPCASE(ComST[1])
                          ELSE O := 0;
                        END
                      ELSE IF Error = 0 THEN R := V;
                    END;
                    4 : IF Error = 0 THEN IF ModoVis = 1 THEN A_D := TRUNC(V) ELSE Portata := V/metri;

                    5 : IF Error = 0 THEN IF ModoVis = 1 THEN W := TRUNC(V) ELSE IF C0 < 9999 THEN C0 := V;

                    6 : IF Error = 0 THEN IF ModoVis = 1 THEN H := TRUNC(V) ELSE Perdita := V;
                7 : IF Error = 0 THEN IF ModoVis = 1 THEN L := V;
                8 : IF Error = 0 THEN IF ModoVis = 1 THEN Ang := TRUNC(V);
                - 1 :BEGIN
                       VAL(ComST, V, Error);
                       IF Error = 0 THEN ComVal := V;
                       Campo := HoldCampo;
                       IF NOT(O IN [13, 72, 73, 80, 81]) THEN RifArch := WRITE_RIGA_VARIE(RifArch);
                       IF O IN [27, 13] THEN O := 0;
                     END;
              END;            { case campo of per controllare i dati e inserirli in tabella }

            WITH RAMO^.T[StartPage+Riga-1] DO
              BEGIN
                IF RifArch > 0 THEN
                IF (ARCHIVIO[RifArch].TipoSez[1] = 'R') AND (H <> 0) AND (W <> 0) THEN
                  A_D := TRUNC(1.3*Elev(1.0*H*W, 0.625)/Elev(1.0*H+W, 0.25)); { diametro equivalente }
                IF ((ModoVis = 1) AND (Campo IN [4, 5]) AND (V <> 0) AND F) THEN CHFlag := '*';
              END;


            IF RifArch > 0 THEN
              IF (ARCHIVIO[RifArch].NUscite <> 1) AND (O IN [9, 80]) THEN
                BEGIN
                  IF INSERT_NODO(RAMO, INDPadre, Dir, StartPage+Riga-1) THEN GOTO StartEdit;
                  ExitChar := ' '; O := 0;
                END;

            DISPLAY_RIGA_RAMO(Riga);

            IF (Riga = 0) AND (Campo = 6) AND (Error = 0) AND (O IN [72, 73, 75]) THEN O := 0;

            IF Error = 0 THEN
              CASE O OF
                71 : IF ARCHIVIO[RifArch].Varie > '' THEN
                       BEGIN
                         HoldCampo := Campo;
                         Campo := -1;
                       END;
                75 : IF Campo > 1 THEN Campo := Campo-1;
                13 : IF Campo < NCampi THEN Campo := Campo+1;
                72 : IF Riga > 1 THEN Riga := Riga-1
                     ELSE
                       IF StartPage > 1 THEN
                         BEGIN
                           StartPage := StartPage-1;
                           SCROLL(StartRow+1, NRighe, 'D');
                           DISPLAY_RIGA_RAMO(Riga);
                         END;
                80, 9:
                  BEGIN
                    IF O = 9 THEN Campo := 1;
                    IF Riga < NRighe THEN Riga := Riga+1
                    ELSE
                      IF StartPage+Riga-1 < NCompRamo THEN
                        BEGIN
                          StartPage := StartPage+1;
                          SCROLL(StartRow+1, NRighe, 'U');

                          DISPLAY_RIGA_RAMO(Riga-1);
                          DISPLAY_RIGA_RAMO(Riga);

                        END;
                  END;        { caso crsr down/ return }
                73 : BEGIN
                       IF StartPage-NRighe > 1 THEN { pgup }
                         BEGIN
                           StartPage := StartPage-NRighe;
                           IF StartPage < 1 THEN StartPage := 1;
                         END
                       ELSE StartPage := 1;
                       DISPLAY_PAGE_RAMO;
                       Riga := 1;
                     END;
                81 : IF StartPage < NCompRamo-NRighe+1 THEN { pgdn }
                       BEGIN
                         StartPage := StartPage+Nrighe;
                         IF StartPage > NCompRamo-Nrighe THEN StartPage := NCompRamo-Nrighe+1;
                         IF StartPage > Ult_Line(Ramo) THEN StartPage := Ult_Line(Ramo);
                         DISPLAY_PAGE_RAMO;
                         Riga := 1;
                       END;

                68 :          { *********  insert  *********   f10 = insert line }
                  IF INSERT_LINE(RAMO, StartPage+Riga-1) THEN DISPLAY_PAGE_RAMO;


                93 : BEGIN    { ********  delete  ********* }
                       I := NCompRamo;
                       WHILE (SETLEFT(RAMO^.T[I].CodPezzo) = '') AND (I > 1) DO I := I-1;
                       IF I >= StartPage+Riga-1 THEN
                         BEGIN
                           FOR N := StartPage+Riga-1 TO I DO RAMO^.T[N] := RAMO^.T[N+1];
                           INIT_LINE(RAMO, I);
                           Modifica_Ramo := TRUE;
                           DISPLAY_PAGE_RAMO;
                         END;
                     END;     { shift+f10 = delete line }
                64 : BEGIN
                       IF BloccoTab = NIL THEN NEW(BloccoTab);
                       BloccoTab^ := Ramo^;
                       BOX(1, StartRow-4, 80, NRighe+5, Col[17], Col[1]);
                     END;
                65 : BEGIN
                       IF BloccoTab <> NIL THEN
                         BEGIN
                           Ramo^.T := BloccoTab^.T;
                           Modifica_Ramo := TRUE;
                           DISPLAY_PAGE_RAMO;
                         END
                       ELSE WRITE(#7);
                     END;

                59..63 : BEGIN
                           I := ULT_LINE(RAMO);
                           N := FIND_ARCHIVIO(RAMO^.T[I].CodPezzo);
                           W := ARCHIVIO[N].NUscite;
                           FEND := TRUE;
                           CASE O OF
                             59 : IF Ramo <> P0 THEN EDIT_RAMO := 4
                                  ELSE
                                    BEGIN
                                      beep;
                                      fend := FALSE;
                                    END;
                             60 : IF (w >= 1) AND (i > 0) THEN EDIT_RAMO := 3
                                  ELSE
                                    BEGIN
                                      beep;
                                      fend := FALSE;
                                    END;
                             61 : IF (w > 1) AND (i > 0) THEN EDIT_RAMO := 1
                                  ELSE
                                    BEGIN
                                      beep;
                                      fend := FALSE;
                                    END;

                             62 : IF (W > 2) AND (i > 0) THEN EDIT_RAMO := 2
                                  ELSE
                                    BEGIN
                                      beep;
                                      fend := FALSE;
                                    END;
                             63 : BEGIN {.. f5  goto ramo ..}
                                    nn := 0;
                                    Error := 0;
                                    TEXTCOLOR(Col[4]); TEXTBACKGROUND(Col[3]);
                                    GOTOXY(1, 20);
                                    WRITE('Etichetta Nodo Finale: ');
                                    REPEAT
                                      comst := '';
                                      CurPos := 1;
                                      ComST := LINE_INPUT(24, 20, 5, CurPos, ' ', ComST, Tipo,
                                      ExitChar, TRUE, F,1);
                                      VAL(ComST, nn, Error);
                                    UNTIL Error = 0;
                                    TEXTCOLOR(Col[2]); TEXTBACKGROUND(Col[1]);

                                    indicetabellatrovata := cercatabella(nn);
                                    edit_ramo := 6;
                                  END;
                             {.. melky ..}
                           END;

                         END;
                92 : BEGIN    {shift - f9   melky }
                       ASSIGN(KGB, DATA_DRIVE+'HELP.TXT');
                       RESET(KGB);
                       GOTOXY(1, 18);
                       WHILE NOT EOF(KGB) DO
                         BEGIN
                           READLN(kgb, TESTO);
                           WRITELN(TESTO);
                         END;
                       CLOSE(KGB);
                       REPEAT UNTIL KEYPRESSED;
                       FOR i11 := 18 TO 21 DO
                         BEGIN
                           GOTOXY(1, i11); CLREOL;
                         END;
                       TEXTCOLOR(col[4]);
                       GOTOXY(25, 19); WRITE(' Premi SHIFT - F9 Per l'' Help ');
                       TEXTCOLOR(Col[2]);
                     END;
                10 : BEGIN
                       ModoVis := 3-ModoVis;
                       CASE ModoVis OF
                         1 : NCampi := 8;
                         2 : BEGIN NCampi := 6; IF Campo > 6 THEN Campo := 6; END;
                       END;
                       DISPLAY_PAGE_RAMO;
                     END;
                27 : BEGIN FEND := TRUE; EDIT_RAMO := 5; FEdit := FALSE; END;
                94 : BEGIN    { ctrl-f1   delete ramo dipendente dal nodo in edit }
                       DELETE_NODO(RAMO, INDPadre, Dir);
                       EDIT_RAMO := 4;
                       FEND := TRUE;
                     END;
              END;            { case o of.... }
          UNTIL FEND;
        END;                  { proc. edit_ramo }



        {-------------------------   percorrirete  --------------------------}
      PROCEDURE PercorriRete(IND, INDPadre : LINK; Dir : INTEGER; PerditaTot : REAL);
        VAR
          SCELTA : INTEGER;
        BEGIN
          IF FEdit THEN
            REPEAT
              SCELTA := EDIT_RAMO(IND, INDPadre, Dir, PerditaTot);

              CASE SCELTA OF
                1 : IF Ind <> NIL THEN PercorriRETE(IND^.Ps, IND, 1, PerditaTot+IND^.T[NCompRamo+1].Perdita)
                    ELSE beep;
                2 : IF Ind <> NIL THEN PercorriRETE(IND^.Pd, IND, 2, PerditaTot+IND^.T[NCompRamo+1].Perdita)
                    ELSE beep;
                3 : IF Ind <> NIL THEN PercorriRETE(IND^.Pc, IND, 3, PerditaTot+IND^.T[NCompRamo+1].Perdita)
                    ELSE beep;
                6 : IF Indicetabellatrovata <> NIL THEN
                      PercorriRETE(indicetabellatrovata, PadreTrovata, 1, Petot)
                    ELSE beep;
              END;

            UNTIL (SCELTA IN [4, 5]) OR NOT FEdit;
        END;                  { proc. percorrirete }


        {--------------  main of rete  -------------}
      BEGIN
        ASSIGN(g, Data_Drive+'prog.can');
        RESET(g);
        READLN(g, NProg); READLN(g, Riga);
        CLOSE(g);
        ASSIGN(f99, data_drive+nprog+'.msc');
        RESET(f99);
        READ(f99, metri);
        IF metri = 1 THEN MaskMc := 'mc/s ' ELSE maskmc := 'mc/h ';
        PercorriRete(IND, INDPadre, Dir, 0);
      END;

    BEGIN                     {   ... inizio edit_tab ...   }
      M_off;
      NUnUsed := 0;
      FOR N := 0 TO 1000 DO Directory[N] := FALSE;
      InitDir(P0);
      FEdit := TRUE;
      RETE(P0, NIL, 1);
      CLRSCR;
      M_on;
    END;


END.