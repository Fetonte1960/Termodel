{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit U_crea3d;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  utilitie,
  definiz;

  PROCEDURE CreaSchema3d;


{===========================================================================}

Implementation


  PROCEDURE CreaSchema3d;
    CONST
      Nlinee = 28;
      NUsc = 3;
    TYPE
      Trig = ARRAY[0..359] OF REAL;
      Uscita = RECORD
                 x, y, z, x1, y1, z1 : REAL;
               END;
      PuntiUsc = ARRAY[1..NUsc] OF Uscita;

      linea = RECORD
                Xp, Yp, Xa, Ya, Za, Zp : REAL;
              END;
      Componente = ARRAY[1..Nlinee] OF linea;
      PunComp = ^Componente;

      pointer = ^Canale;

      Canale = RECORD
                 Graph : Componente;
                 Point : PuntiUsc;
                 Cod : st5;
                 D, A, B : INTEGER;
                 CHFlag : STRING[1];
                 Lungh : REAL;
                 Ang : INTEGER;
                 R : REAL;
                 Perdita, PORT : REAL;
                 Varie : REAL;
                 NTab, Phi : INTEGER;
                 Ps, Pd, Pc : pointer;
               END;

      Angoli = RECORD
                 AngXY, AngXZ, AngYZ : INTEGER;
               END;

    VAR ch : CHAR;
      C : Canale;
      X0Init, Y0Init : REAL;
      XMin, YMin, XMax, YMax : REAL;
      LXMin, LYMin, LXMax, LYMax : REAL;
      Rete : Pointer;
      Rientro, FlagUscita : BOOLEAN;
      Prosp : Angoli;
      Sine, Cosine : Trig;
      Errore : INTEGER;
      DPrecc : PunComp;
      PointPrec : PuntiUsc;
      f : FILE OF canale;

    FUNCTION Angolo(a, b : REAL) : INTEGER;
      VAR Phi : REAL;
      BEGIN
        IF a = 0 THEN
          BEGIN
            IF b > 0 THEN Angolo := -90
            ELSE Angolo := 90;
          END
        ELSE
          BEGIN
            Phi := -ARCTAN(b/a);
            Angolo := ROUND((180/PI)*PhI);
          END;
      END;


    FUNCTION ArcTg(a, b, a1, b1 : REAL) : INTEGER;
      VAR Phi : INTEGER;
      BEGIN
        a := INT(a*1000)/1000;
        a1 := INT(a1*1000)/1000;
        b := INT(b*1000)/1000;
        b1 := INT(b1*1000)/1000;
        Phi := Angolo(a1-a, b1-b);
        IF a1-a < 0 THEN Phi := Phi+180;
        Phi := (Phi+360) MOD 360;
        ArcTg := Phi;
      END;


    PROCEDURE Ruota(VAR a, b : REAL; Ang : INTEGER);
      VAR a1, b1 : REAL;
      BEGIN
        a1 := a; b1 := b;
        a := a1*cosine[Ang]+b1*sine[Ang];
        b := -a1*sine[Ang]+b1*cosine[Ang];
      END;


    PROCEDURE RuotaXY(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      VAR i : INTEGER;
      BEGIN
        IF Ang = 0 THEN EXIT;

        FOR i := 1 TO Nlinee DO
          WITH D[i] DO
            BEGIN
              Ruota(Xp, Yp, Ang);
              Ruota(Xa, Ya, Ang);
            END;

        FOR i := 1 TO NUsc DO
          WITH U[i] DO
            BEGIN
              Ruota(X, Y, Ang);
              Ruota(X1, Y1, Ang);
            END;
      END;

    PROCEDURE RuotaXZ(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      VAR i : INTEGER;
      BEGIN
        IF Ang = 0 THEN EXIT;

        FOR i := 1 TO Nlinee DO
          WITH D[i] DO
            BEGIN
              Ruota(Xp, Zp, Ang);
              Ruota(Xa, Za, Ang);
            END;

        FOR i := 1 TO NUsc DO
          WITH U[i] DO
            BEGIN
              Ruota(X, Z, Ang);
              Ruota(X1, Z1, Ang);
            END;
      END;

    PROCEDURE RuotaYZ(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      VAR i : INTEGER;
      BEGIN
        IF Ang = 0 THEN EXIT;

        FOR i := 1 TO Nlinee DO
          WITH D[i] DO
            BEGIN
              Ruota(Yp, Zp, Ang);
              Ruota(Ya, Za, Ang);
            END;

        FOR i := 1 TO NUsc DO
          WITH U[i] DO
            BEGIN
              Ruota(Y, Z, Ang);
              Ruota(Y1, Z1, Ang);
            END;
      END;

    PROCEDURE Annulla(VAR D : Componente; VAR U : PuntiUsc);
      VAR I : INTEGER;
      BEGIN
        FOR i := 1 TO NLinee DO
          WITH D[i] DO
            BEGIN
              Xp := 0; Yp := 0; Zp := 0;
              Xa := 0; Ya := 0; Za := 0;
            END;

        FOR i := 1 TO NUsc DO
          WITH U[i] DO
            BEGIN
              X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0;
            END;
      END;

    PROCEDURE SezRett(A, B : REAL; VAR D : Componente);
      BEGIN
        D[1].Xp := 0; D[1].Yp := A/2; D[1].Zp := -B/2;
        D[1].Xa := 0; D[1].Ya := A/2; D[1].Za := B/2;

        D[2].Xp := 0; D[2].Yp := A/2; D[2].Zp := B/2;
        D[2].Xa := 0; D[2].Ya := -A/2; D[2].Za := B/2;

        D[3].Xp := 0; D[3].Yp := -A/2; D[3].Zp := B/2;
        D[3].Xa := 0; D[3].Ya := -A/2; D[3].Za := -B/2;

        D[4].Xp := 0; D[4].Yp := -A/2; D[4].Zp := -B/2;
        D[4].Xa := 0; D[4].Ya := A/2; D[4].Za := -B/2;

      END;

    PROCEDURE CollegaTrattiRett(VAR D : Componente; ASucc, BSucc, L : REAL);
      VAR
        DSucc : Componente;
        I : INTEGER;
      BEGIN
        SezRett(ASucc, BSucc, DSucc);
        FOR I := 5 TO 8 DO
          BEGIN
            D[I].Xp := D[I-4].Xp; D[I].Yp := D[I-4].Yp;
            D[I].Zp := D[I-4].Zp;
            D[I].Xa := DSucc[I-4].Xp+L; D[I].Ya := DSucc[I-4].Yp;
            D[I].Za := DSucc[I-4].Zp;
          END;
      END;

    PROCEDURE CollegaBranchC(VAR D : Componente; A, B, L : REAL);
      VAR I : INTEGER;
      BEGIN
        D[9].Xp := 0.1; D[9].Xa := 0.1;
        D[9].Yp := -A/2-0.1; D[9].Ya := -A/2;
        D[9].Zp := -B/2; D[9].Za := -B/2;

        D[10].Xp := L-0.1; D[10].Xa := L-0.1;
        D[10].Yp := -A/2-0.1; D[10].Ya := -A/2;
        D[10].Zp := -B/2; D[10].Za := -B/2;

        D[11].Xp := L-0.1; D[11].Xa := L-0.1;
        D[11].Yp := -A/2-0.1; D[11].Ya := -A/2;
        D[11].Zp := B/2; D[11].Za := B/2;

        D[12].Xp := 0.1; D[12].Xa := 0.1;
        D[12].Yp := -A/2-0.1; D[12].Ya := -A/2;
        D[12].Zp := B/2; D[12].Za := B/2;

        FOR I := 13 TO 16 DO
          BEGIN
            D[I].Xp := D[I-4].Xa; D[I].Xa := D[I-3].Xa;
            D[I].Yp := D[I-4].Ya; D[I].Ya := D[I-3].Ya;
            D[I].Zp := D[I-4].Za; D[I].Za := D[I-3].Za;
          END;

        D[16].Xa := D[9].Xa;
        D[16].Ya := D[9].Ya;
        D[16].Za := D[9].Za;

      END;

    PROCEDURE CollegaBranchC1(VAR D : Componente; A, B, L : REAL);
      VAR I : INTEGER;
      BEGIN
        D[17].Xp := 0.1; D[17].Xa := 0.1;
        D[17].Yp := A/2+0.1; D[17].Ya := A/2;
        D[17].Zp := -B/2; D[17].Za := -B/2;

        D[18].Xp := L-0.1; D[18].Xa := L-0.1;
        D[18].Yp := A/2+0.1; D[18].Ya := A/2;
        D[18].Zp := -B/2; D[18].Za := -B/2;

        D[19].Xp := L-0.1; D[19].Xa := L-0.1;
        D[19].Yp := A/2+0.1; D[19].Ya := A/2;
        D[19].Zp := B/2; D[19].Za := B/2;

        D[20].Xp := 0.1; D[20].Xa := 0.1;
        D[20].Yp := A/2+0.1; D[20].Ya := A/2;
        D[20].Zp := B/2; D[20].Za := B/2;

        FOR I := 21 TO 24 DO
          BEGIN
            D[I].Xp := D[I-4].Xa; D[I].Xa := D[I-3].Xa;
            D[I].Yp := D[I-4].Ya; D[I].Ya := D[I-3].Ya;
            D[I].Zp := D[I-4].Za; D[I].Za := D[I-3].Za;
          END;

        D[24].Xa := D[17].Xa;
        D[24].Ya := D[17].Ya;
        D[24].Za := D[17].Za;

      END;


    PROCEDURE CollegaBranchD(VAR D : Componente; A, B, L : REAL);
      VAR I : INTEGER;
      BEGIN
        D[9].Xp := 0.1; D[9].Xa := 0.1;
        D[9].Yp := -A/2-0.1; D[9].Ya := A/2+0.1;
        D[9].Zp := -B/2; D[9].Za := -B/2;

        D[10].Xp := L+0.1; D[10].Xa := L+0.1;
        D[10].Yp := -A/2-0.1; D[10].Ya := A/2+0.1;
        D[10].Zp := -B/2; D[10].Za := -B/2;

        D[11].Xp := L+0.1; D[11].Xa := L+0.1;
        D[11].Yp := -A/2-0.1; D[11].Ya := A/2+0.1;
        D[11].Zp := B/2; D[11].Za := B/2;

        D[12].Xp := 0.1; D[12].Xa := 0.1;
        D[12].Yp := -A/2-0.1; D[12].Ya := A/2+0.1;
        D[12].Zp := B/2; D[12].Za := B/2;

        CollegaTrattiRett(D, A, B, 0.1);

      END;


    PROCEDURE DisegnoA(ASucc, BSucc, A, B, L : REAL; VAR D : Componente; VAR U : PuntiUsc);
      BEGIN
        SezRett(A, B, D);
        CollegaTrattiRett(D, ASucc, BSucc, L);

        WITH U[1] DO
          BEGIN
            X := 0; Y := 0; Z := 0;
            X1 := L; Y1 := 0; Z1 := 0;
          END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 1; X1 := L; Y1 := 1; Z := 0; Z1 := 0; END;
      END;


    PROCEDURE DisegnoFT(ASin, BSin, ASucc, BSucc, A, B, L : REAL; VAR D : Componente; VAR U : PuntiUsc; Yc, Zc : INTEGER);
      BEGIN
        SezRett(A, B, D);

        WITH U[1] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := Yc*(ASucc/2); Z := 0; Z1 := Zc*(BSucc/2); END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := Yc*(-ASin/2); Z := 0; Z1 := Zc*(-BSin/2); END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 1; Y1 := 0; Z := 0; Z1 := 0; END;
      END;



    PROCEDURE DisegnoBL(A, B, LN : REAL; Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      VAR Cx, Cy, L, LAngY, LAngX, R1, R2 : REAL;
        Step, I, J : INTEGER;
      BEGIN
        L := LN;
        LAngX := L*Sine[Ang];
        LAngY := -L+L*Cosine[Ang];

        SezRett(A, B, D);
        Cx := 0; Cy := -LN; Step := ROUND(Ang/6);
        R1 := LN+A/2; R2 := LN-A/2;

        J := 1;
        FOR I := 5 TO 10 DO
          WITH D[I] DO
            BEGIN
              Xp := Cx+R1*Sine[(J-1)*Step];
              Yp := Cy+R1*Cosine[(J-1)*Step];
              Zp := -B/2;
              Xa := Cx+R1*Sine[J*Step];
              Ya := Cy+R1*Cosine[J*Step];
              Za := -B/2;
              J := J+1;
            END;

        FOR I := 11 TO 16 DO
          BEGIN
            D[I] := D[I-6];
            D[I].Zp := B/2;
            D[I].Za := B/2;
          END;

        J := 1;
        FOR I := 17 TO 22 DO
          WITH D[I] DO
            BEGIN
              Xp := Cx+R2*Sine[(J-1)*Step];
              Yp := Cy+R2*Cosine[(J-1)*Step];
              Zp := -B/2;
              Xa := Cx+R2*Sine[J*Step];
              Ya := Cy+R2*Cosine[J*Step];
              Za := -B/2;
              J := J+1;
            END;

        FOR I := 23 TO 28 DO
          BEGIN
            D[I] := D[I-6];
            D[I].Zp := B/2;
            D[I].Za := B/2;
          END;

        WITH U[1] DO BEGIN X := 0; Y := 0; X1 := LAngX; Y1 := LAngY; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := Cosine[Ang]; Y1 := -Sine[Ang]; Z := 0; Z1 := 0; END;
      END;


    PROCEDURE DisegnoBG(A, B, LN : REAL; Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      VAR Cx, Cy, L, LAngY, LAngX, R1, R2 : REAL;
        Step, I, J : INTEGER;
      BEGIN
        L := LN;
        LAngX := L*Sine[Ang];
        LAngY := -L+L*Cosine[Ang];

        SezRett(A, B, D);

        WITH D[5] DO
          BEGIN
            Xp := 0;
            Yp := A/2;
            Zp := -B/2;
            Xa := A/2+LN;
            Ya := A/2;
            Za := -B/2;
          END;

        D[6] := D[5];
        D[6].Za := B/2; D[6].Zp := B/2;

        WITH D[7] DO
          BEGIN
            Xp := 0;
            Yp := -A/2;
            Zp := -B/2;
            Xa := -A/2+LN;
            Ya := -A/2;
            Za := -B/2;
          END;

        D[8] := D[7];
        D[8].Za := B/2; D[8].Zp := B/2;

        WITH D[9] DO
          BEGIN
            Xp := A/2+LN;
            Yp := A/2;
            Zp := -B/2;
            Xa := (A/2+LN)*(1+Sine[Ang]);
            Ya := -LN*Cosine[Ang];
            Za := -B/2;
          END;

        D[10] := D[9];
        D[10].Za := B/2; D[10].Zp := B/2;

        WITH D[11] DO
          BEGIN
            Xp := -A/2+LN;
            Yp := -A/2;
            Zp := -B/2;
            Xa := (-A/2+LN)*(1+Sine[Ang]);
            Ya := -LN*Cosine[Ang];
            Za := -B/2;
          END;

        D[12] := D[11];
        D[12].Za := B/2; D[12].Zp := B/2;

        WITH U[1] DO BEGIN X := 0; Y := 0; X1 := LAngX; Y1 := LAngY; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := Cosine[Ang]; Y1 := -Sine[Ang]; Z := 0; Z1 := 0; END;
      END;


    PROCEDURE DisegnoC(ASucc, BSucc, A, B, LN, Lb : REAL; Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      VAR LAngY, LAngX, L, L1, L2 : REAL;
      BEGIN
        L := LN+0.2;
        L1 := A/2+0.1;
        L2 := L/2;
        LAngX := L2+L2*cosine[Ang];
        LAngY := -L1*sine[Ang];

        SezRett(A, B, D);
        CollegaTrattiRett(D, ASucc, BSucc, L);
        CollegaBranchC(D, A, Lb, L);

        WITH U[1] DO
          BEGIN
            X := 0; Y := 0;
            X1 := L; Y1 := 0;
            Z := 0; Z1 := 0;
          END;
        WITH U[2] DO
          BEGIN
            X := L2; Y := 0;
            X1 := LAngX; Y1 := LAngY;
            Z := 0; Z1 := 0;
          END;
        WITH U[3] DO
          BEGIN
            X := 0; Y := 0;
            X1 := 0; Y1 := 0;
            Z := 0; Z1 := 0;
          END;
      END;


    PROCEDURE DisegnoD(ASucc, BSucc, A, B, LN, Lb : REAL; Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      VAR L, LAngY, LAngX : REAL;
      BEGIN
        L := LN/2+0.1;
        LAngX := L+L*cosine[Ang];
        L := A/2+0.1;
        LAngY := -L*sine[Ang];

        SezRett(A, B, D);
        CollegaTrattiRett(D, A, B, L);
        CollegaBranchD(D, A, Lb, LN);

        WITH U[1] DO BEGIN X := LN/2+0.1; Y := 0; X1 := LangX; Y1 := LangY; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := LN/2+0.1; Y := 0; X1 := LangX; Y1 := -LangY; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
      END;


    PROCEDURE DisegnoE(ASucc, BSucc, A, B, LN, Lb : REAL; Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      VAR LAngY, LAngX, L, L1, L2 : REAL;
      BEGIN
        L := LN+0.2;
        L1 := A/2+0.1;
        L2 := L/2;
        LAngX := L2+L2*cosine[Ang];
        LAngY := -L1*sine[Ang];

        SezRett(A, B, D);
        CollegaTrattiRett(D, ASucc, BSucc, L);
        CollegaBranchC(D, A, Lb, L);
        CollegaBranchC1(D, A, Lb, L);

        WITH U[1] DO
          BEGIN
            X := 0; Y := 0;
            X1 := L; Y1 := 0;
            Z := 0; Z1 := 0;
          END;
        WITH U[2] DO
          BEGIN
            X := L2; Y := 0;
            X1 := LAngX; Y1 := LAngY;
            Z := 0; Z1 := 0;
          END;
        WITH U[3] DO
          BEGIN
            X := L2; Y := 0;
            X1 := LAngX; Y1 := -LAngY;
            Z := 0; Z1 := 0;
          END;
      END;



    PROCEDURE DisegnoF(A, B : REAL; Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      CONST L = 1;
      BEGIN
        SezRett(A, B, D);

        WITH U[1] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
      END;



    FUNCTION SelectAng(Cod : st5) : INTEGER;
      BEGIN
        CASE Cod[3] OF
          '2' : SelectAng := 20;
          '3' : SelectAng := 30;
          '4' : SelectAng := 45;
          '6' : SelectAng := 60;
          '7' : SelectAng := 75;
          '9' : SelectAng := 90;
        ELSE
        END;
      END;

    FUNCTION ErrSez(D1, D2 : Componente) : BOOLEAN;
      CONST NSez = 4;
        Appr = 0.001;
      VAR I : INTEGER;
        Rx, Ry, Rz : REAL;
        Trovato : BOOLEAN;
      BEGIN
        WITH D1[1] DO
          BEGIN
            Rx := Xp; Ry := Yp; Rz := Zp;
          END;

        I := 1;
        REPEAT
          WITH D2[I] DO
            BEGIN
              Trovato := ((ABS(Rx-Xp) < Appr) AND (ABS(Ry-Yp) < Appr) AND (ABS(Rz-Zp) < Appr));
            END;
          IF NOT Trovato THEN I := I+1;
        UNTIL Trovato OR (I > NSez);
        ErrSez := NOT Trovato;
      END;




    PROCEDURE INSERT(FLink : Link; Indice : INTEGER; VAR Padre, Figlio : Pointer; Dir : INTEGER; DPrec : Componente;
                     VAR DPrecC, DPrecS, DPrecD : Componente);
      VAR P1, P, P2 : Pointer;
        ch : CHAR;
        Temp, J, RifArch, AngXY, AngXZ, AngYZ, Campo, Chiave : INTEGER;
        RiDis, AzzeraAB : BOOLEAN;
        FSucc, Linea : RigaRamo;
        DisPadre, Dir1, LN, Lb, APrec, BPrec, ASucc, BSucc, ASin, BSin : INTEGER;
        TempR, Rapp : REAL;
        Prove, Angolo1, Angolo2, Angolo3 : INTEGER;
        Errore : BOOLEAN;
      BEGIN
        IF Indice < NCompRamo THEN FSucc := FLink^.T[Indice+1]
        ELSE FSucc := FLink^.Pc^.T[1];

        AzzeraAB := FALSE;
        Linea := FLink^.T[Indice];
        RifArch := FIND_ARCHIVIO(Linea.CodPezzo);

        IF Padre <> NIL THEN DisPadre := Archivio[FIND_ARCHIVIO(Padre^.Cod)].CodDis
        ELSE DisPadre := 0;

        CASE ARCHIVIO[RifArch].CodDis OF
          1, 6, 7, 8:
            WITH FSucc DO
              BEGIN
                ASucc := W;
                BSucc := H;
                IF (ASucc = 0) OR (BSucc = 0) THEN
                  BEGIN
                    ASucc := A_D;
                    BSucc := A_D;
                  END;
                Angolo1 := 0;
                Angolo2 := 0;
                Angolo3 := 0;
              END;
          2 :
            WITH Linea DO
              BEGIN
                IF R = 0 THEN Rapp := 1.5
                ELSE Rapp := R;
                ASucc := W;
                BSucc := H;
                IF (ASucc = 0) OR (BSucc = 0) THEN
                  BEGIN
                    ASucc := A_D;
                    BSucc := A_D;
                  END;
                IF Ang = 0 THEN Ang := SelectAng(CodPezzo);
                Angolo1 := Ang;
                Angolo2 := 0;
                Angolo3 := 0;
              END;
        ELSE
          BEGIN
            WITH FLink^.Pc^.T[1] DO
              BEGIN
                ASucc := W;
                BSucc := H;
                IF (ASucc = 0) OR (BSucc = 0) THEN
                  BEGIN
                    ASucc := A_D;
                    BSucc := A_D;
                  END;
              END;

            WITH Linea DO
              BEGIN
                IF Ang = 0 THEN Ang := 90;
                IF ARCHIVIO[RifArch].CodDis = 3 THEN
                  BEGIN
                    Angolo1 := 0;
                    Angolo2 := Ang;
                    Angolo3 := 0;
                  END;
                IF ARCHIVIO[RifArch].CodDis = 4 THEN
                  BEGIN
                    Angolo1 := Ang;
                    Angolo2 := Ang;
                    Angolo3 := 0;
                  END;
                IF ARCHIVIO[RifArch].CodDis = 5 THEN
                  BEGIN
                    Angolo1 := 0;
                    Angolo2 := Ang;
                    Angolo3 := Ang;
                  END;
                IF ARCHIVIO[RifArch].CodDis = 10 THEN
                  BEGIN
                    Angolo1 := 0;
                    Angolo2 := 0;
                    Angolo3 := 0;
                  END;
              END;

            IF FLink^.Ps <> NIL THEN
              BEGIN
                LN := FLink^.Ps^.T[1].W;
                Lb := FLink^.Ps^.T[1].H;
                IF (LN = 0) OR (Lb = 0) THEN
                  BEGIN
                    LN := FLink^.Ps^.T[1].A_D;
                    Lb := FLink^.Ps^.T[1].A_D;
                  END;
              END
            ELSE
              BEGIN
                LN := 0; Lb := 0;
              END;
          END;
        END;

        RiDis := (Figlio <> NIL);
        NEW(P1);
        P1^.Pc := NIL; P1^.Ps := NIL; P1^.Pd := NIL;

        WITH Linea DO
          BEGIN
            P1^.Cod := CodPezzo; P1^.Port := Portata; P1^.Ang := Ang;
            P1^.Lungh := L;
            P1^.D := A_D; P1^.A := W; P1^.B := H; P1^.Perdita := Perdita;
            P1^.Phi := Phi; P1^.NTab := -1;
            P1^.CHFlag := CHFlag;
            P1^.Varie := ComVal; P1^.R := R;
            IF (P1^.A = 0) OR (P1^.B = 0) THEN
              BEGIN
                P1^.A := A_D;
                P1^.B := A_D;
                AzzeraAB := TRUE;
              END;
          END;

        Errore := FALSE; Prove := 0;
        REPEAT

          WITH P1^ DO
            BEGIN
              IF Errore THEN
                BEGIN
                  IF (ARCHIVIO[RifArch].CodDis = 1) THEN Phi := 90
                  ELSE
                    BEGIN
                      Temp := A;
                      A := B;
                      B := Temp;
                      Temp := ASucc;
                      ASucc := BSucc;
                      BSucc := Temp;
                      Temp := LN;
                      LN := Lb;
                      Lb := Temp;
                    END;
                END;

              Annulla(Graph, Point);

              CASE ARCHIVIO[RifArch].CodDis OF
                1 : DisegnoA(ASucc/1000, BSucc/1000, A/1000, B/1000, Lungh, Graph, Point);
                2 :
                  BEGIN
                    IF Ang = 0 THEN Ang := SelectAng(Cod);
                    IF UPCASE(Cod[2]) = 'G' THEN
                      DisegnoBG(A/1000, B/1000, Rapp*A/1000, Ang, Graph, Point)
                    ELSE
                      DisegnoBL(A/1000, B/1000, Rapp*A/1000, Ang, Graph, Point);
                  END;
                3 :
                  BEGIN
                    IF Ang = 0 THEN Ang := 90;
                    DisegnoC(ASucc/1000, BSucc/1000, A/1000, B/1000, LN/1000, Lb/1000, Ang, Graph, Point);
                  END;
                4 :
                  BEGIN
                    IF Ang = 0 THEN Ang := 90;
                    DisegnoD(ASucc/1000, BSucc/1000, A/1000, B/1000, LN/1000, Lb/1000, Ang, Graph, Point);
                  END;
                5 :
                  BEGIN
                    IF Ang = 0 THEN Ang := 90;
                    DisegnoE(ASucc/1000, BSucc/1000, A/1000, B/1000, LN/1000, Lb/1000, Ang, Graph, Point);
                  END;
                6 : DisegnoF(A/1000, B/1000, Ang, Graph, Point);
                7, 8:BEGIN
                         IF Lungh = 0 THEN Lungh := 0.1;
                         DisegnoA(ASucc/1000, BSucc/1000, A/1000, B/1000, Lungh, Graph, Point);
                       END;
                10 :
                  BEGIN
                    IF Errore THEN DisegnoFT(ASucc/1000, BSucc/1000, LN/1000, Lb/1000, A/1000, B/1000, Lungh, Graph,
                      Point, 0, 1)
                    ELSE DisegnoFT(ASucc/1000, BSucc/1000, LN/1000, Lb/1000, A/1000, B/1000, Lungh, Graph, Point, 1, 0);
                  END;
              ELSE EXIT;
              END;
            END;

          IF AzzeraAB THEN
            BEGIN
              P1^.A := 0;
              P1^.B := 0;
            END;

          RuotaYZ(P1^.Phi, P1^.Graph, P1^.Point);

          IF Padre <> NIL THEN
            BEGIN
              NEW(P);
              P^ := Padre^;
              {*** riporta il pezzo precedente in pianta ***}
              RuotaXZ((360-Prosp.AngXZ) MOD 360, P^.Graph, P^.Point);
              RuotaYZ((360-Prosp.AngYZ) MOD 360, P^.Graph, P^.Point);
              RuotaXY((360-Prosp.AngXY) MOD 360, P^.Graph, P^.Point);

              IF (DisPadre = 10) OR (DisPadre = 2) THEN Dir1 := 3
              ELSE Dir1 := Dir;

              WITH P^.Point[Dir1] DO AngXZ := ArcTg(x, z, x1, z1);
              RuotaXZ((360-AngXZ) MOD 360, P^.Graph, P^.Point);
              WITH P^.Point[Dir1] DO AngYZ := ArcTg(y, z, y1, z1);
              RuotaYZ((360-AngYZ) MOD 360, P^.Graph, P^.Point);
              WITH P^.Point[Dir1] DO AngXY := ArcTg(x, y, x1, y1);
              DISPOSE(P);
            END
          ELSE
            BEGIN
              AngXY := 0; AngXZ := 0; AngYZ := 0;
            END;

          RuotaXY(AngXY, P1^.Graph, P1^.Point);
          RuotaYZ(AngYZ, P1^.Graph, P1^.Point);
          RuotaXZ(AngXZ, P1^.Graph, P1^.Point);

          {... confronto tra la sezione ottenuta e la sezione precedente (confronto
          tra le due piante) ... }
          IF Padre <> NIL THEN Errore := ErrSez(DPrec, P1^.Graph)
          ELSE Errore := FALSE;

          RuotaXY(Prosp.AngXY, P1^.Graph, P1^.Point);
          RuotaYZ(Prosp.AngYZ, P1^.Graph, P1^.Point);
          RuotaXZ(Prosp.AngXZ, P1^.Graph, P1^.Point);

          Prove := Prove+1;
        UNTIL NOT Errore OR (Prove > 1);


        {.... realizzazione sezione di uscita primo figlio (in pianta) ....}
        Annulla(DPrecc, PointPrec);
        SezRett(ASucc/1000, BSucc/1000, DPrecc);
        RuotaXY(Angolo1, DPrecc, PointPrec);
        RuotaYZ(P1^.Phi, DPrecc, PointPrec);
        RuotaXY(AngXY, DPrecc, PointPrec);
        RuotaYZ(AngYZ, DPrecc, PointPrec);
        RuotaXZ(AngXZ, DPrecc, PointPrec);

        IF ARCHIVIO[RifArch].NUscite > 1 THEN
          BEGIN
            {.... realizzazione sezione di uscita secondo figlio (in pianta) ....}
            Annulla(DPrecs, PointPrec);
            SezRett(LN/1000, Lb/1000, DPrecs);
            RuotaXY(Angolo2, DPrecs, PointPrec);
            RuotaYZ(P1^.Phi, DPrecs, PointPrec);
            RuotaXY(AngXY, DPrecs, PointPrec);
            RuotaYZ(AngYZ, DPrecs, PointPrec);
            RuotaXZ(AngXZ, DPrecs, PointPrec);
          END;

        IF ARCHIVIO[RifArch].NUscite > 2 THEN
          BEGIN
            {.... realizzazione sezione di uscita terzo figlio (in pianta) ....}
            Annulla(DPrecd, PointPrec);
            SezRett(LN/1000, Lb/1000, DPrecd);
            RuotaXY(Angolo3, DPrecd, PointPrec);
            RuotaYZ(P1^.Phi, DPrecd, PointPrec);
            RuotaXY(AngXY, DPrecd, PointPrec);
            RuotaYZ(AngYZ, DPrecd, PointPrec);
            RuotaXZ(AngXZ, DPrecd, PointPrec);
          END;

        IF Padre <> NIL THEN
          CASE Dir OF
            1 : Padre^.Pc := P1;
            2 : Padre^.Ps := P1;
            3 : Padre^.Pd := P1;
          END
        ELSE Rete := P1;



        P1^.Pc := Figlio;

        Figlio := P1^.Pc;
        Padre := P1;
      END;

    PROCEDURE CarTrig(VAR Sine, Cosine : Trig);
      VAR i : INTEGER;
      BEGIN
        FOR i := 0 TO 359 DO
          BEGIN
            Sine[i] := SIN((PI/180)*i);
            Cosine[i] := COS((PI/180)*i);
          END;
      END;



    PROCEDURE SaveAlbero(P : Pointer);
      VAR
        g : FILE OF REAL;
        RAngXY, RAngXZ, RAngYZ : REAL;

      BEGIN
        ASSIGN(g, DATA_DRIVE+NomeFile+'.3DG');
        REWRITE(g);

        WRITE(g, X0Init, Y0Init, XMin, XMax, YMin, YMax, LXMin, LXMax, LYMin, LYMax);
        WITH Prosp DO
          BEGIN
            RAngXY := AngXY; RAngXZ := AngXZ; RAngYZ := AngYZ;
            WRITE(g, RAngXY, RAngXZ, RAngYZ);
          END;
        CLOSE(g);
      END;


    PROCEDURE LoadAlbero;
      VAR
        g : FILE OF REAL;
        RAngXY, RAngXZ, RAngYZ : REAL;

      BEGIN
        ASSIGN(g, DATA_DRIVE+NomeFile+'.3DG');
        {$I-} RESET(g);       {$I+}
        IF (IORESULT = 0) THEN
          BEGIN
            READ(g, X0Init, Y0Init, XMin, XMax, YMin, YMax, LXMin, LXMax, LYMin, LYMax);
            WITH Prosp DO
              BEGIN
                READ(g, RAngXY, RAngXZ, RAngYZ);
                AngXY := ROUND(RAngXY); AngXZ := ROUND(RAngXZ); AngYZ := ROUND(RAngYZ);
              END;
            CLOSE(g);
          END;
      END;

    FUNCTION UltLine(IND : LINK) : INTEGER;
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
        UltLine := i;
      END;                    { func. ultline }


    PROCEDURE Percorri(FLink : Link; Padre, Ind : Pointer; Dir : INTEGER; D : PunComp);
      VAR i : INTEGER;
        D1, D2, D3 : PunComp;
        P1, P2, P3 : link;
        Pp, PrimoPezzo : pointer;
        N : INTEGER;
      BEGIN
        IF FLink <> NIL THEN
          BEGIN
            NEW(D1); NEW(D2); NEW(D3);
            GOTOXY(1, 22); WRITE(' Valutazione nodo : ', FLink^.CodTab); CLREOL;

            N := UltLine(FLink);
            INSERT(FLink, 1, Padre, Ind, Dir, D^, D1^, D2^, D3^);
            PrimoPezzo := Padre;

            FOR i := 2 TO N DO
              IF FLink^.T[i].CodPezzo > '' THEN INSERT(FLink, I, Padre, Ind, 1, D1^, D1^, D2^, D3^);

            FOR i := 1 TO N-1 DO
              BEGIN
                WRITE(f, PrimoPezzo^);
                Pp := PrimoPezzo;
                PrimoPezzo := PrimoPezzo^.Pc;
                DISPOSE(Pp);
                { Il pezzo n-esimo sara' il padre  dei rami successivi    .
                Verra' gestito solo quando i rami saranno stati valutati. }
              END;

            P1 := FLink^.Pc;
            P2 := FLink^.Ps;
            P3 := FLink^.Pd;

            { inserisce dei figli fittizi }
            IF P1 <> NIL THEN Padre^.Pc := PrimoPezzo
            ELSE Padre^.Pc := NIL;

            IF P2 <> NIL THEN Padre^.Ps := PrimoPezzo
            ELSE Padre^.Ps := NIL;

            IF P3 <> NIL THEN Padre^.Pd := PrimoPezzo
            ELSE Padre^.Pd := NIL;

            WRITE(f, Padre^);

            Padre^.NTab := FLink^.CodTab;

            DISPOSE(FLink);

            Percorri(P1, Padre, Padre^.Pc, 1, D1);
            Percorri(P2, Padre, Padre^.Ps, 2, D2);
            Percorri(P3, Padre, Padre^.Pd, 3, D3);

            DISPOSE(Padre);
            DISPOSE(D1); DISPOSE(D2); DISPOSE(D3);
          END;
      END;





    BEGIN
      DATA_DRIVE := 'C:\daticca\';
      X0Init := 0; Y0Init := 20;

      XMin := 0; XMax := 40;
      YMin := 0; YMax := 40;

      LXMin := 0; LXMax := 40;
      LYMin := 0; LYMax := 40;

      WITH Prosp DO
        BEGIN
          AngXY := 0; AngXZ := 0; AngYZ := 0;
        END;

      Rete := NIL;

      CarTrig(Sine, Cosine);

      LoadAlbero;

      ASSIGN(f, DATA_DRIVE+NomeFile+'.3DH');
      REWRITE(f);

      NEW(DPrecc);
      Percorri(P0, NIL, Rete, 1, DPrecc);

      CLOSE(f);

      CLRSCR;
      SaveAlbero(Rete);
    END;
end.