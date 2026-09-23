{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit U_serter;

Interface

Uses

{$Ifdef Win}
  Dummyfunction,
{$else}
  Crt,
  Dos,
{$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  {ut_funz,}
  utilitie,
  definIZcan, {defin_ca,}
  WM,u_funz,
  scritte;

  PROCEDURE SerTerm(flag : INTEGER);

{===========================================================================}

Implementation



  PROCEDURE SerTerm(flag : INTEGER);
    VAR
      SC, SR : st5;

    PROCEDURE WRITEPT(P0 : integer);
      BEGIN
        GOTOXY(1, 22);
        WRITE('Ps=');
        IF TabCalc^[P0]^.Ps = 0 THEN WRITE('NIL') ELSE WRITE('***');
        WRITE('  Pd=');
        IF TabCalc^[P0]^.Pd = 0 THEN WRITE('NIL') ELSE WRITE('***');
        WRITE('  Pc=');
        IF TabCalc^[P0]^.Pc = 0 THEN WRITE('NIL') ELSE WRITE('***');
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
      if ind.riga<>0 then
        begin
        FEND := FALSE;
        I := 0;
        REPEAT
          I := I+1;
          IF SETLEFT(IND.T[I].CodPezzo) = '' THEN
            BEGIN
              I := I-1;
              FEND := TRUE
            END;
        UNTIL FEND OR (I = NCompRamo);
        ULT_LINE := I;
        end
      else ult_line:=1;
      END;                    { func. ult_line }

      {---------------------------  transfer_tab  ----------------------------------}
    FUNCTION TRANSFER_TAB(FileName : ST80) : INTEGER;
      VAR
        FL : FILE OF TabAsh;
        IOERR, N : INTEGER;
      BEGIN
        ASSIGN(FL, DRIVEarc+FileName+'.ASH');
        {$I-} RESET(FL) {$I+} ;
        IOERR := IORESULT;
        {$I-} READ(FL, RecC0) {$I+} ;
        IOERR := IORESULT;
        TRANSFER_TAB := IOERR;
        IF IOErr > 0 THEN
          BEGIN
            WRITE(CHR(7));
            CLRSCR; GOTOXY(1, 10);
            WRITELN(W_M(40),' ',FileName);  {'ERRORE nella lettura della tabella ', FileName);}
            WRITELN(W_M(41)); {'Il programma non pu• proseguire.'}
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
            {$ifdef win}
            {$else}
            //SOUND(100); DELAY(200); NOSOUND;
            {$endif}
            GOTOXY(1, 22);
            WRITE(W_M(42),' ',CODTAB_FORM(IND.CodTab)); CLREOL;
            {'Spazio insufficiente per inserire un''altra riga nella tabella nø '}
            GOTOXY(1, 23); WRITE(W_M(36)); CLREOL;  {'Premere un tasto per continuare.'}
            {$ifdef dos}
            //READKBD(CH);
            {$endif}
            GOTOXY(1, 22); CLREOL; GOTOXY(1, 23); CLREOL;
            INSERT_LINE := FALSE;
          END
        ELSE
          BEGIN
            IF I >= Posizione THEN
              BEGIN
                FOR N := I DOWNTO Posizione DO IND.T[N+1] := IND.T[N];

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
          IF (IND.riga <> 0) AND NOT Trovata THEN
            BEGIN
              IF IND.CodTab = N THEN
                BEGIN
                  Trovata := TRUE;
                  TrovIND := IND;
                END;
              Trova(TabCalc^[IND.Ps]^);
              Trova(TabCalc^[IND.Pc]^);
              Trova(TabCalc^[IND.Pd]^);
            END;
        END;

        {------------  main of cercatabella  -------------}
      BEGIN
        Trovata := FALSE;
        Trova(TabCalc^[P0]^);
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
          WITH IND.T[O] DO
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
          IF IND.riga <> 0 THEN
            BEGIN
              PerdPr := PerdPr+CalcPerd(IND);
              IF MaxPerdita < PerdPr THEN MaxPerdita := PerdPr;

              Trova(TabCalc^[IND.Ps]^, PerdPr);
              Trova(TabCalc^[IND.Pc]^, PerdPr);
              Trova(TabCalc^[IND.Pd]^, PerdPr);
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
      PROCEDURE Trova(INDPADRE:integer; IND : LINK; PerdPr : REAL);
        VAR AttPerd : REAL;   { somma delle perdite degli elementi del nodo attuale    }
        BEGIN
        IF IND.riga <> 0 then   {aggiunto cippo}
         Begin               {aggiunto cippo}
          AttPerd := PerdPr+CalcPerd(Ind);

          IF (IND.riga <> 0) AND (IND.Ps = 0) AND (IND.Pc = 0) AND (IND.Pd = 0) THEN
            BEGIN
            wnodo(ind);
              IF PerditaMax-AttPerd > 0 THEN
                BEGIN
                  { inserimento serranda automatico prima del  }
                  I := ULT_LINE(IND); { diffusore }

                  IF INSERT_LINE(IND, I) THEN
                    WITH IND.T[I] DO
                      BEGIN
                        CASE UPCASE(ARCHIVIO^[FIND_ARCHIVIO(IND.T[I+1].CodPezzo)].TipoSez[1]) OF
                          'C', 'D':CodPezzo := SC;
                          'R', 'A', 'H':CodPezzo := SR;
                        END;

                        Descr := ARCHIVIO^[FIND_ARCHIVIO(CodPezzo)].Descr;
                        Portata := IND.T[I+1].Portata;

                        Perdita := PerditaMax-AttPerd;
                        IF Perdita > DPr2^.SerrTermMax THEN Perdita := DPr2^.SerrTermMax;
                        ComVal := Perdita;
                        (*
                        GOTOXY(1, 21);
                        WRITE(W_M(25),' ');
                        {'Da Nodo '}
                        IF INDPADRE = NIL THEN WRITE('000')
                        ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));
                        WRITE('  ',W_M(26),' ',CODTAB_FORM(IND^.CodTab)); {'  a nodo '}
                        GOTOXY(1, 22); CLREOL;
                        GOTOXY(1, 22); WRITE(W_M(43),' ',ComVal:8:3); {'Inserimento serranda su terminale con perdita (Pa) :}
                        *)
                        A_D := IND.T[I+1].A_D;
                        H := IND.T[I+1].H;
                        W := IND.T[I+1].W;
                        IND.T[NCompRamo+1].Perdita := IND.T[NCompRamo+1].Perdita+Perdita;
                      END;    { with ind^.t[i]   }
                END;

            END;              { if (ind<>nil) and (ind^.ps=nil) and (ind^.pc=nil) and (ind^.pd=nil).......... }

          IF ind.riga <> 0 THEN
            BEGIN
              wfase('Inserimento serrande');
              Trova(IND.riga, TabCalc^[IND.Pc]^, AttPerd);
              Trova(IND.riga, TabCalc^[IND.Ps]^, AttPerd);
              Trova(IND.riga, TabCalc^[IND.Pd]^, AttPerd);
            END;
         END; {aggiunto cippo}
        END;                  { proc. trova }

        {************** serrandeterm **************}
      BEGIN
        Trova(0, IND, 0);
      END;                    { proc. serrandeterm }




      {---------------------------  eliminaserterm  -----------------------------}
    PROCEDURE EliminaSerTerm;

        {-------------------------------  delete_line  -----------------------------}
      PROCEDURE DELETE_LINE(IND : LINK; N : INTEGER);
        VAR
          O, U : INTEGER;
        BEGIN
          U := ULT_LINE(IND);
          FOR O := N TO U-1 DO IND.T[O] := IND.T[O+1];
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
            WITH Ind.T[I] DO
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
          IF IND.riga <> 0 THEN
            BEGIN
              Elimina(IND);
              Trova(TabCalc^[IND.Ps]^);
              Trova(TabCalc^[IND.Pc]^);
              Trova(TabCalc^[IND.Pd]^);
            END;
        END;                  { proc. trova }

        {********************   main   of   eliminaserterm   *********************}
      BEGIN
        Trova(TabCalc^[P0]^);
      END;                    { proc. eliminaserterm }



      {-----------------------------  main of serterm  ------------------------------}
    VAR
      N : INTEGER;
    BEGIN
{      DATA_DRIVE := 'C:\DATICCA\';  correzione del 11 11 91  }

      ASSIGN(frid, 'SerrRett.dat');
      RESET(frid); READLN(frid, SR); CLOSE(frid);
      ASSIGN(frid, 'SerrCirc.dat');
      RESET(frid); READLN(frid, SC); CLOSE(frid);

      SYSTEM_DRIVE := '';
      {$ifdef win}
      {$else}
      //TEXTCOLOR(Col[2]);
      {$endif}
      EliminaSerTerm;
      IF (flag = 1) THEN
        BEGIN
          PerditaMax := CalcolaPerdite(TabCalc^[P0]^, 0);
          GOTOXY(10, 14); WRITE(W_M(44),' ',PerditaMax:5:2); CLREOL; {'Perdita massima (Pa) :}
          SerrandeTerm(TabCalc^[P0]^);
        END;
    END;
end.