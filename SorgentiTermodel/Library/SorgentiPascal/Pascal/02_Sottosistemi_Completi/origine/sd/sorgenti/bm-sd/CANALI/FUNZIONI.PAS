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

    FUNCTION SearchDim(Dim : INTEGER; flag : CHAR) : INTEGER;
      CONST
        LC = 23;
        LR = 16;
        DCirc : ARRAY[1..LC] OF INTEGER
        = (75, 100, 125, 150, 175, 200, 225, 250, 300, 350, 400, 450, 500, 600, 700, 800,
        900, 1000, 1200, 1400, 1600, 1800, 2000);
        DRett : ARRAY[1..LR] OF INTEGER
        = (100, 150, 200, 250, 300, 350, 400, 500, 600, 800,
        1000, 1200, 1400, 1600, 1800, 2000);
      VAR j : INTEGER;
      BEGIN
        j := 0;
        CASE flag OF
          'C', 'D':
            REPEAT
              j := j+1;
            UNTIL (Dim <= DCirc[j]) OR (j = LC);
          'R', 'A', 'H':
            REPEAT
              j := j+1;
            UNTIL (Dim <= DRett[j]) OR (j = LR);
        END;
        SearchDim := j;
      END;


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
      END;                    { func. ult_line }

      {-----------------------------  verifica misure  -----------------------------}
    PROCEDURE VERcalc(IND, indpadre : LINK);
        { verifica le misure dei pezzi di uno stesso tronco }
      CONST
        LR = 16;
        DRett : ARRAY[1..LR] OF INTEGER
        = (100, 150, 200, 250, 300, 350, 400, 500, 600, 800,
        1000, 1200, 1400, 1600, 1800, 2000);
      VAR
        I, O, RifArch, kp, ks, Cont : INTEGER;
        IPc, IPs : link;
        WDI0R, WTot : REAL;
      BEGIN
        Cont := 0;
        O := ULT_LINE(IND);
        WITH Ind^.T[O] DO
          BEGIN
            RifArch := FIND_ARCHIVIO(CodPezzo);
            IF Archivio[RifArch].Main = 'P' THEN {... di0r ...}
              BEGIN
                IPc := Ind^.Pc;
                IPs := Ind^.Ps;
                REPEAT
                  WDI0R := IPc^.T[1].W+IPs^.T[1].W;
                  WHILE (W > WDI0R) AND (WTot <> WDI0R) DO
                    BEGIN
                      WTot := WDI0R;
                      kp := SearchDim(IPc^.T[1].W, 'R');
                      ks := SearchDim(IPs^.T[1].W, 'R');
                      IF Ks > Kp THEN
                        BEGIN
                          IF Kp < LR THEN IPc^.T[1].W := DREtt[Kp+1]
                          ELSE IF Ks < LR THEN IPs^.T[1].W := DREtt[Ks+1];
                        END
                      ELSE
                        BEGIN
                          IF Ks < LR THEN IPs^.T[1].W := DREtt[Ks+1]
                          ELSE IF Kp < LR THEN IPc^.T[1].W := DREtt[Kp+1];
                        END;
                      WDI0R := IPc^.T[1].W+IPs^.T[1].W;
                    END;
                  WHILE (W < WDI0R) AND (WTot <> WDI0R) DO
                    BEGIN
                      WTot := WDI0R;
                      kp := SearchDim(IPc^.T[1].W, 'R');
                      ks := SearchDim(IPs^.T[1].W, 'R');
                      IF Ks > Kp THEN {.. privilegia il restringimento della sezione minore ..}
                        BEGIN
                          IF Kp > 1 THEN IPc^.T[1].W := DREtt[Kp-1] {.. se non e' possibile restringere ..}
                            {.. la sezione minore, restringe quella maggiore ..}
                          ELSE IF Ks > 1 THEN IPs^.T[1].W := DREtt[Ks-1];
                        END
                      ELSE
                        BEGIN
                          IF Ks > 1 THEN IPs^.T[1].W := DREtt[Ks-1]
                          ELSE IF Kp > 1 THEN IPc^.T[1].W := DREtt[Kp-1];
                        END;
                      WDI0R := IPc^.T[1].W+IPs^.T[1].W;
                    END;
                  Cont := Cont+1;
                UNTIL (WDI0R = W) OR (Cont > 3);
              END;
          END;


        FOR I := 1 TO O DO
          WITH IND^.T[I] DO
            BEGIN
              RifArch := FIND_ARCHIVIO(CodPezzo);
              {.. melky ..}
              IF (a_d = 0) AND (h*w = 0) THEN
                BEGIN
                  WRITE(' Errore nel tratto ');
                  IF INDpadre = NIL THEN WRITE('000')
                  ELSE WRITE(CODTAB_FORM(indpadre^.CodTab));
                  WRITELN(' - ', CODTAB_FORM(IND^.CodTab));
                  WRITELN(' pezzo ', codpezzo);
                  REPEAT UNTIL KEYPRESSED;
                  HALT;
                END;
              IF ARCHIVIO[RifArch].TipoSez[1] IN ['A', 'R', 'H'] THEN {.. rettangolari ..}
                BEGIN
                  IF H = 0 THEN H := A_D;
                  IF W = 0 THEN W := A_D;
                  A_D := TRUNC(1.3*Elev(1.0*H*W, 0.625)/Elev(H+W, 0.25));
                END
              ELSE            {.. circolari    ..}
                IF A_D = 0 THEN
                  BEGIN
                    A_D := TRUNC(1.3*Elev(1.0*H*W, 0.625)/Elev(H+W, 0.25));
                    H := 0; W := 0;
                  END;
            END;

      END;                    { proc.  verifica }


      {---------------------------- controllo misure -----------------------------}
    PROCEDURE Contcalc(IND, indpadre : LINK);
      BEGIN
        IF NOT(IND = NIL) THEN
          BEGIN
            Vercalc(IND, indpadre);
            Contcalc(IND^.Pc, ind);
            Contcalc(IND^.Ps, ind);
            Contcalc(IND^.Pd, ind);
          END;
      END;                    { proc. controllo }




      {-----------------------------  interpola  -----------------------------------}
    FUNCTION Interpola(X, Y : REAL) : REAL;
      VAR
        RAX, RBX, RAY, RBY, I, J, Dx, Dy : INTEGER;
        R1, R2, RC, Com, Y1, Y2, COM1, COM2 : REAL;
        ch : CHAR;

      FUNCTION Interp1(rbx, rby : INTEGER) : REAL;
        VAR X1, X2, C1, C2 : REAL;
        BEGIN
          x1 := RECC0.TabC0[rbx-1, 0]; c1 := RECC0.tabc0[rbx-1, rby];
          x2 := RECC0.TabC0[rbx, 0]; c2 := RECC0.tabc0[rbx, rby];
          Interp1 := (X-X1)/(X2-X1)*(C2-C1)+C1;
        END;

      BEGIN
        WITH RecC0 DO
          BEGIN
            Dx := DIM_X;
            WHILE (TabC0[Dx, 0] = 0) AND (Dx > 1) DO Dx := Dx-1;

            Dy := DIM_Y;
            WHILE (TabC0[0, Dy] = 0) AND (Dy > 1) DO Dy := Dy-1;

            IF X < TabC0[1, 0] THEN X := TabC0[1, 0];
            IF X > TabC0[Dx, 0] THEN X := TabC0[Dx, 0];

            IF Y < TabC0[0, 1] THEN Y := TabC0[0, 1];
            IF Y > TabC0[0, Dy] THEN Y := TabC0[0, Dy];

            IF (Dx = 1) AND (Dy = 1) THEN Com := TabC0[1, 1]
            ELSE
              BEGIN
                RBX := 1; RBY := 1;
                WHILE (X > TabC0[RBX, 0]) AND (RBX < Dx) DO RBX := RBX+1;

                WHILE (Y > TabC0[0, RBY]) AND (RBY < Dy) DO RBY := RBY+1;

                IF dy > 1 THEN
                  BEGIN
                    IF rby = 1 THEN rby := 2;
                    IF dx > 1 THEN
                      BEGIN
                        IF rbx = 1 THEN rbx := 2;
                        Com1 := Interp1(rbx, rby-1);
                        Com2 := Interp1(rbx, rby);
                      END
                    ELSE
                      BEGIN
                        com1 := tabc0[rbx, rby-1];
                        com2 := tabc0[rbx, rby];
                      END;
                  END
                ELSE
                  BEGIN
                    IF dx > 1 THEN
                      BEGIN
                        IF rbx = 1 THEN rbx := 2;
                        Com1 := Interp1(rbx, rby);
                        Com2 := Com1;
                      END
                    ELSE
                      BEGIN
                        com1 := tabc0[rbx, rby];
                        com2 := Com1;
                      END;
                  END;
              END;

            IF dy > 1 THEN
              BEGIN
                IF rby = 1 THEN rby := 2;
                Y1 := TabC0[0, RBY-1]; Y2 := TabC0[0, RBY];
                Com := (Y-Y1)/(Y2-Y1)*(Com2-Com1)+Com1;
              END
            ELSE Com := Com1;

            Interpola := Com;
          END;
      END;                    { func.  interpola }

    FUNCTION Elev(a, x : REAL) : REAL;
        { a = base ; x = esponente }
      BEGIN
        IF a > 0 THEN Elev := EXP(x*LN(a)) ELSE Elev := 0;
      END;

    FUNCTION Log(x : REAL) : REAL;
      BEGIN
        Log := LN(x)/LN(10);
      END;

    FUNCTION Circa(A, B, Apr : REAL) : BOOLEAN;
      BEGIN
        Circa := ((A > B-Apr) AND (A < B+Apr));
      END;

    FUNCTION Velocita(Q, D : REAL) : REAL;
      BEGIN
        Velocita := 4000000.0/(PI*SQR(D))*Q;
      END;


    FUNCTION Re(D, V : REAL) : REAL;
      BEGIN
        Re := (Densita/Viscosita)*D*V;
      END;


    FUNCTION Cattrito(D, Q : REAL) : REAL;
      VAR Fd : REAL;
        Fd1, Fd2 : REAL;
        Valore1, Valore2 : REAL;
        Valore : REAL;
        V : REAL;
      BEGIN
        Fd1 := 0.000000001;
        Fd2 := 0.1;
        V := Velocita(Q, D);
        REPEAT
          Valore1 := (1/SQRT(Fd1))+2*Log(Eps/(3.7*D)+2.51/(Re(D, V)*SQRT(Fd1)));
          Valore2 := (1/SQRT(Fd2))+2*Log(Eps/(3.7*D)+2.51/(Re(D, V)*SQRT(Fd2)));
          IF NOT(Valore1*Valore2 < 0) THEN
            BEGIN
              Fd1 := Fd2;
              Fd2 := Fd2+0.1;
            END;
        UNTIL Valore1*Valore2 < 0;

        REPEAT
          Fd := (Fd1+Fd2)/2;
          Valore := (1/SQRT(Fd))+2*Log(Eps/(3.7*D)+2.51/(Re(D, V)*SQRT(Fd)));
          IF NOT(Circa(Valore, 0, 0.01)) THEN
            BEGIN
              IF Valore1 < 0 THEN
                BEGIN
                  IF Valore < 0 THEN Fd1 := Fd
                  ELSE Fd2 := Fd;
                END
              ELSE
                BEGIN
                  IF Valore < 0 THEN Fd2 := Fd
                  ELSE Fd1 := Fd;
                END;
            END;
        UNTIL Circa(Valore, 0, 0.01);
        Cattrito := Fd;
      END;


    FUNCTION Pv(V : REAL) : REAL;
      BEGIN
        Pv := densita*(SQR(V)/2);
      END;


    FUNCTION PerditaAttr(L, D, Q : REAL) : REAL;
      VAR V : REAL;
      BEGIN
        V := Velocita(Q, D);
        PerditaAttr := (1000*L/D)*Cattrito(D, Q)*Pv(V);
      END;



    PROCEDURE Dim_St(I : INTEGER; VAR H, W, Dim : INTEGER; flag : CHAR; R : REAL);
      CONST
        LC = 23;
        LR = 16;
        DCirc : ARRAY[1..LC] OF INTEGER
        = (75, 100, 125, 150, 175, 200, 225, 250, 300, 350, 400, 450, 500, 600, 700, 800,
        900, 1000, 1200, 1400, 1600, 1800, 2000);
        DRett : ARRAY[1..LR] OF INTEGER
        = (100, 150, 200, 250, 300, 350, 400, 500, 600, 800,
        1000, 1200, 1400, 1600, 1800, 2000);
      VAR
        j, k : INTEGER;
        Trovato : BOOLEAN;
        RPot : REAL;
      BEGIN
        H := 0; W := 0;
        CASE flag OF
          'C', 'D':
            IF I < LC THEN Dim := DCirc[I]
            ELSE Dim := DCirc[LC];
          'R', 'H', 'A':
            BEGIN
              IF I < LR THEN W := DRett[I]
              ELSE W := DRett[LR];

              j := 1;
              REPEAT
                Trovato := (DRett[j]/W > R);
                IF NOT Trovato THEN j := j+1;
              UNTIL Trovato OR (j > LR);
              IF NOT Trovato THEN j := LR;

              IF j > 1 THEN
                BEGIN
                  IF ABS(R-DRett[j-1]/W) > ABS(R-DRett[j]/W) THEN H := DRett[j]
                  ELSE H := DRett[j-1];
                END
              ELSE H := DRett[j];

              IF W > MaxDimW THEN
                BEGIN
                  k := 1;
                  WHILE DRett[k] < MaxDimW DO k := k+1;
                  W := DRett[k];
                END;
              IF H > MaxDimH THEN
                BEGIN
                  k := 1;
                  WHILE DRett[k] < MaxDimH DO k := k+1;
                  H := DRett[k];
                END;

              RPot := 1.3*Elev(1.0*H*W, 0.625)/Elev(H+W, 0.25);
              Dim := TRUNC(RPot) { calcola diametro eqivalente } ;
            END;
        ELSE
          IF I < LC THEN Dim := DCirc[I]
          ELSE Dim := DCirc[LC];
        END;
      END;


    PROCEDURE Diametro(L, Q, R : REAL; VAR H, W, Dim : INTEGER; flag : CHAR);
      VAR Valore : REAL;
        Valore1, Valore2 : REAL;
        H1, H2, W1, W2, D1, D2 : INTEGER;
        V : REAL;
        IndDim : INTEGER;
      BEGIN
        flag := UPCASE(flag);
        D1 := 1; W1 := 1; H1 := 1;
        IndDim := 1; Dim_St(IndDim, H2, W2, D2, flag, R);
        REPEAT
          V := Velocita(Q, D1);
          Valore1 := ((1000*L)*Cattrito(D1, Q)*Pv(V))/AttrCost-D1;
          V := Velocita(Q, D2);
          Valore2 := ((1000*L)*Cattrito(D2, Q)*Pv(V))/AttrCost-D2;

          IF Valore1*Valore2 > 0 THEN
            BEGIN
              D1 := D2;
              H1 := H2;
              W1 := W2;
              IndDim := IndDim+1;
              Dim_St(IndDim, H2, W2, D2, flag, R);
              GOTOXY(28, 22); WRITE(D2:5);
            END;

        UNTIL (Valore1*Valore2 < 0) OR (Valore1 = Valore2);

        IF (ABS(Valore1) < ABS(Valore2)) AND (D1 <> 1) THEN
          BEGIN
            Dim := D1;
            H := H1;
            W := W1;
          END
        ELSE
          BEGIN
            Dim := D2;
            H := H2;
            W := W2;
          END;
      END;


    PROCEDURE DimVCost(L, Q, R : REAL; VAR H, W, Dim : INTEGER; flag : CHAR);
      VAR Valore : REAL;
        Vel1, Vel2 : REAL;
        H1, H2, W1, W2, D1, D2 : INTEGER;
        IndDim : INTEGER;
      BEGIN
        flag := UPCASE(flag);

        IndDim := 1; Dim_St(IndDim, H1, W1, D1, flag, R);
        IndDim := IndDim+1; Dim_St(IndDim, H2, W2, D2, flag, R);

        REPEAT

          Vel1 := Velocita(Q, D1);
          Vel2 := Velocita(Q, D2);

          IF Vel2 > VelCost THEN
            BEGIN
              D1 := D2;
              H1 := H2;
              W1 := W2;
              IndDim := IndDim+1;
              Dim_St(IndDim, H2, W2, D2, flag, R);
              GOTOXY(28, 22); WRITE(D2:5);
            END;

        UNTIL (Vel2 < VelCost) OR (Vel1 = Vel2);

        GOTOXY(28, 22); WRITE(D2:5);
        Dim := D1;
        H := H1;
        W := W1;
      END;
