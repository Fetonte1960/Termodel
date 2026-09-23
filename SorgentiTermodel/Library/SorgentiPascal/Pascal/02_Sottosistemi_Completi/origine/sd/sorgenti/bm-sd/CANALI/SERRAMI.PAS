  OVERLAY PROCEDURE serrami(flag : INTEGER);

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

    VAR SC, SR : st5;

      {-------------------------------  calcarea  ----------------------------------}
    FUNCTION CalcArea(IND : LINK; N : INTEGER) : REAL;
        { calcola la sezione del pezzo indicato }
      VAR
        RifArch : INTEGER;
      BEGIN
        WITH IND^.T[N] DO
          BEGIN
            RifArch := FIND_ARCHIVIO(CodPezzo);

            IF UPCASE(ARCHIVIO[RifArch].TipoSez[1]) IN ['D', 'C'] THEN
              CalcArea := (A_D/2)*(A_D/2)*3.14
            ELSE
              CalcArea := 1.0*H*W;
          END;
      END;                    { func.  calcarea }

      {---------------------------------  calcvel  ---------------------------------}
    FUNCTION CalcVel(IND : LINK; N : INTEGER) : REAL;
      VAR A, A1 : REAL;
        RifArch : INTEGER;
      BEGIN
        WITH IND^.T[N] DO RifArch := FIND_ARCHIVIO(CodPezzo);
        A := CalcArea(IND, N)/1000000.0; { sezione in mq }

        IF (UPCASE(Archivio[RifArch].TipoSez[2]) IN ['A', 'H', 'C']) AND (Archivio[RifArch].Nuscite = 1) THEN
          BEGIN
            IF (n = 15) THEN
              BEGIN
                a1 := calcarea(ind^.pc, 1)/1000000.0;
                IF a1 < a THEN a := a1;
              END
            ELSE
              BEGIN
                A1 := CalcArea(IND, N+1)/1000000.0; { sezione in mq }
                IF A1 < A THEN A := A1;
              END;
          END;

        IF (A <> 0) AND (N IN [0..NCompRamo]) THEN CalcVel := IND^.T[N].Portata/A
        ELSE CalcVel := 0;
      END;                    { func.  calcvel }


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

        Ind^.T[NCompRamo+1].Perdita := PerdSum;
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



      {-------------------------------  equilibra  ---------------------------------}
    PROCEDURE equilibra(IND : LINK);
      VAR
        AttPerd : REAL;       { somma delle perdite degli elementi del nodo attuale    }
        AttMax : REAL;        { valore massimo di perdita che dipende dal nodo attuale }
        Ptent : REAL;         { Valore di perdita per un tentativo di dimensionamento
                              diametri. }
        Pl, PRagg, MinDiam : REAL;
        IOERR, I, RifArch, N, IndMin : INTEGER;
        NomeTab : STRING[8];

        {----------------------------    trova     -------------------------------}
      PROCEDURE Trova(IndPadre, IND : LINK; Dir : INTEGER; PerdPr : REAL);
        VAR O : BYTE;
          Prova, Diff, PAttrLim, Vel : REAL;
          Cont, IndDim, I : INTEGER; { indice array dimensioni }
          ch : CHAR;
          Serranda : BOOLEAN;
        BEGIN
          IF Ind = NIL THEN EXIT;

          AttPerd := CalcPerd(Ind); { somma delle perdite per il ramo ind}
          AttMax := Calcolaperdite(IND, PerdPr); { Valore di perdita max ad un terminale
                                                 dipendente da IND                   }
          GOTOXY(1, 21);
          WRITE('Da Nodo ');
          IF INDPADRE = NIL THEN WRITE('000')
          ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));
          WRITE('  a nodo ', CODTAB_FORM(IND^.CodTab));
          GOTOXY(1, 22); CLREOL;
          GOTOXY(1, 22); WRITE('Perdita calcolata  (Pa) :');
          GOTOXY(28, 22); WRITE(AttPerd:8:3);

          IF AttMax < PerditaMax THEN
            BEGIN
              PRagg := PerditaMax;
              I := 1;
              RifArch := FIND_ARCHIVIO(IND^.T[1].CodPezzo);
              IF (ARCHIVIO[RifArch].TipoSez[2] IN ['H', 'A', 'C']) AND
              (ARCHIVIO[RifArch].NUscite = 1) THEN I := 2;
              Ptent := CalcolaPerdite(IND, PerdPr);

              IF DPr2.SbilDPu <= ABS(PRagg-PTent) THEN
                BEGIN

                  IF ABS(PRagg-PTent) > DPR2.SerrDPUMin THEN
                    IF INSERT_LINE(IND, I) THEN
                      WITH IND^.T[I] DO
                        BEGIN
                          CASE ARCHIVIO[FIND_ARCHIVIO(IND^.T[I+1].CodPezzo)].TipoSez[1] OF
                            'C', 'D':CodPezzo := SC;
                            'R', 'H', 'A':CodPezzo := SR;
                          END;
                          Descr := ARCHIVIO[FIND_ARCHIVIO(CodPezzo)].Descr;
                          Portata := IND^.T[I+1].Portata;

                          Perdita := ABS(Pragg-Ptent);
                          ComVal := Perdita;
                          A_D := IND^.T[I+1].A_D;
                          H := IND^.T[I+1].H;
                          W := IND^.T[I+1].W;
                          C0 := Perdita/(Densita*SQR(CalcVel(IND, I))/2);
                          IND^.T[NCompRamo+1].Perdita := IND^.T[NCompRamo+1].Perdita+Perdita;
                        END;  { with ind^.t[i]   }
                END;
            END;


          Trova(IND, IND^.Pc, 1, PerdPr+IND^.T[NCompRamo+1].Perdita);
          Trova(IND, IND^.Ps, 2, PerdPr+IND^.T[NCompRamo+1].Perdita);
          Trova(IND, IND^.Pd, 3, PerdPr+IND^.T[NCompRamo+1].Perdita);
        END;                  { proc. trova }

        {************** equilibra **************}
      BEGIN
        Trova(NIL, IND, 0, 0);
      END;                    { proc. equilibra }


      {---------------------------  eliminaserrami  -----------------------------}
    PROCEDURE EliminaSerRami;

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

        {********************   main   of   eliminaserrami   *********************}
      BEGIN
        Trova(P0);
      END;                    { proc. eliminaserrami }




      {-----------------------------  main of serrami  ------------------------------}
    VAR
      N : INTEGER;
    BEGIN
      DATA_DRIVE := 'C:\DATICCA\';

      ASSIGN(frid, DATA_DRIVE+'serramic.dat');
      RESET(frid); READLN(frid, SC); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'serramir.dat');
      RESET(frid); READLN(frid, SR); CLOSE(frid);

      SYSTEM_DRIVE := '';

      TEXTCOLOR(grigioligth);

      EliminaSerRami;
      IF flag = 1 THEN
        BEGIN
          PerditaMax := CalcolaPerdite(P0, 0);
          Densita := DPR2.Dens;
          Equilibra(P0);
        END;

    END;
