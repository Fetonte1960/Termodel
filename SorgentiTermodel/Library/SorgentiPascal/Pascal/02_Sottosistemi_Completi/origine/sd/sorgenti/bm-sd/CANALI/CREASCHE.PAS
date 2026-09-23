  OVERLAY PROCEDURE CreaSchema;
    CONST
      Nlinee = 3;
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

      {---------------------------  find_archivio  ---------------------------------}
    FUNCTION FIND_ARCHIVIO(Codice : ST5) : INTEGER;
        { Cerca all'interno di ARCHIVIO il codice di un pezzo e restituisce la posi_
        zione in tabella (indice dell'array ARCHIVIO) }
      VAR
        I, j : INTEGER;
        Trovato : BOOLEAN;
      BEGIN
        FOR I := 1 TO LENGTH(Codice) DO Codice[I] := UPCASE(Codice[I]);

        I := 1; Trovato := FALSE;
        WHILE (I <= NPezzi) AND NOT Trovato DO
          BEGIN
            FOR j := 1 TO 5 DO Archivio[i].CodPezzo[j] := UPCASE(Archivio[i].CodPezzo[j]);
            Trovato := (COPY(Archivio[I].CodPezzo, 1, LENGTH(Codice)) = Codice);
            IF NOT Trovato THEN i := i+1;
          END;

        IF NOT Trovato THEN FIND_ARCHIVIO := 0
        ELSE FIND_ARCHIVIO := I;

      END;                    { func.  find_archivio }


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


    PROCEDURE DefineWindowIBM(i, X1, Y1, X2, Y2 : INTEGER);
      BEGIN
        {DefineWindow(i,Trunc(X1/79*XMaxGlb+0.001),Trunc(Y1/199*YMaxGlb+0.001),
        Trunc(X2/79*XMaxGlb+0.5),Trunc(Y2/199*YMaxGlb+0.5));}
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

    PROCEDURE DisegnoA(L : REAL; VAR D : Componente; VAR U : PuntiUsc);
      BEGIN
        D[1].Xp := 0; D[1].Yp := 0; D[1].Zp := 0;
        D[1].Xa := L; D[1].Ya := 0; D[1].Za := 0;
        D[2].Xp := 0; D[2].Yp := 0; D[2].Zp := 0;
        D[2].Xa := L; D[2].Ya := 0; D[2].Za := 0;
        D[3].Xp := 0; D[3].Yp := 0; D[3].Zp := 0;
        D[3].Xa := 0; D[3].Ya := 0; D[3].Za := 0;

        WITH U[1] DO BEGIN X := 0; Y := 0; X1 := L; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
      END;

    PROCEDURE DisegnoFT(L : REAL; VAR D : Componente; VAR U : PuntiUsc);
      BEGIN
        D[1].Xp := 0; D[1].Yp := 0.5; D[1].Zp := 0;
        D[1].Xa := 1; D[1].Ya := 0.5; D[1].Za := 0;
        D[2].Xp := 0; D[2].Yp := -0.5; D[2].Zp := 0;
        D[2].Xa := 1; D[2].Ya := -0.5; D[2].Za := 0;
        D[3].Xp := 0; D[3].Yp := 0.5; D[3].Zp := 0;
        D[3].Xa := 0; D[3].Ya := -0.5; D[3].Za := 0;

        WITH U[1] DO BEGIN X := 0; Y := 0.5; X1 := 1; Y1 := 0.5; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := 0; Y := -0.5; X1 := 1; Y1 := -0.5; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
      END;


    PROCEDURE DisegnoB(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      CONST L = 1;
      VAR LAngY, LAngX : REAL;
      BEGIN
        LAngX := L+L*cosine[Ang];
        LAngY := -L*sine[Ang];

        D[1].Xp := 0; D[1].Yp := 0; D[1].Zp := 0;
        D[1].Xa := L; D[1].Ya := 0; D[1].Za := 0;
        D[2].Xp := L; D[2].Yp := 0; D[2].Zp := 0;
        D[2].Xa := LAngX; D[2].Ya := LAngY; D[2].Za := 0;
        D[3].Xp := 0; D[3].Yp := 0; D[3].Zp := 0;
        D[3].Xa := L; D[3].Ya := 0; D[3].Za := 0;

        WITH U[1] DO BEGIN X := L; Y := 0; X1 := LAngX; Y1 := LAngY; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
      END;


    PROCEDURE DisegnoC(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      CONST L = 2;
      VAR LAngY, LAngX, L2 : REAL;
      BEGIN
        L2 := L/2;
        LAngX := L2+L2*cosine[Ang];
        LAngY := -L2*sine[Ang];

        D[1].Xp := 0; D[1].Yp := 0; D[1].Zp := 0;
        D[1].Xa := L; D[1].Ya := 0; D[1].Za := 0;
        D[2].Xp := L2; D[2].Yp := 0; D[2].Zp := 0;
        D[2].Xa := LAngX; D[2].Ya := LangY; D[2].Za := 0;
        D[3].Xp := 0; D[3].Yp := 0; D[3].Zp := 0;
        D[3].Xa := 0; D[3].Ya := 0; D[3].Za := 0;

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


    PROCEDURE DisegnoD(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      CONST L = 1;
      VAR LAngY, LAngX : REAL;
      BEGIN
        LAngX := L+L*cosine[Ang];
        LAngY := -L*sine[Ang];

        D[1].Xp := 0; D[1].Yp := 0; D[1].Zp := 0;
        D[1].Xa := L; D[1].Ya := 0; D[1].Za := 0;
        D[2].Xp := L; D[2].Yp := 0; D[2].Zp := 0;
        D[2].Xa := LangX; D[2].Ya := LangY; D[2].Za := 0;
        D[3].Xp := L; D[3].Yp := 0; D[3].Zp := 0;
        D[3].Xa := LangX; D[3].Ya := -LangY; D[3].Za := 0;

        WITH U[1] DO BEGIN X := L; Y := 0; X1 := LangX; Y1 := LangY; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := L; Y := 0; X1 := LangX; Y1 := -LangY; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
      END;

    PROCEDURE DisegnoE(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      CONST L = 2;
      VAR LAngY, LAngX, L2 : REAL;
      BEGIN
        L2 := L/2;
        LAngX := L2+L2*cosine[Ang];
        LAngY := -L2*sine[Ang];

        D[1].Xp := 0; D[1].Yp := 0; D[1].Zp := 0;
        D[1].Xa := L; D[1].Ya := 0; D[1].Za := 0;
        D[2].Xp := L2; D[2].Yp := 0; D[2].Zp := 0;
        D[2].Xa := LangX; D[2].Ya := LAngY; D[2].Za := 0;
        D[3].Xp := L2; D[3].Yp := 0; D[3].Zp := 0;
        D[3].Xa := LangX; D[3].Ya := -LAngY; D[3].Za := 0;

        WITH U[1] DO BEGIN X := 0; Y := 0; X1 := L; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := L2; Y := 0; X1 := LAngX; Y1 := LAngY; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := L2; Y := 0; X1 := LAngX; Y1 := -LAngY; Z := 0; Z1 := 0; END;
      END;

    PROCEDURE DisegnoF(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      CONST L = 1;
      BEGIN
        D[1].Xp := 0; D[1].Yp := L; D[1].Zp := 0;
        D[1].Xa := 0; D[1].Ya := -L; D[1].Za := 0;
        D[2].Xp := 0; D[2].Yp := 0; D[2].Zp := 0;
        D[2].Xa := 0; D[2].Ya := 0; D[2].Za := 0;
        D[3].Xp := 0; D[3].Yp := 0; D[3].Zp := 0;
        D[3].Xa := 0; D[3].Ya := 0; D[3].Za := 0;

        WITH U[1] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
      END;


    PROCEDURE DisegnoG(Ang : INTEGER; VAR D : Componente; VAR U : PuntiUsc);
      CONST L = 1;
      BEGIN
        D[1].Xp := 0; D[1].Yp := L; D[1].Zp := 0;
        D[1].Xa := 0; D[1].Ya := -L; D[1].Za := 0;
        D[2].Xp := L; D[2].Yp := L; D[2].Zp := 0;
        D[2].Xa := L; D[2].Ya := -L; D[2].Za := 0;
        D[3].Xp := 0; D[3].Yp := 0; D[3].Zp := 0;
        D[3].Xa := 0; D[3].Ya := 0; D[3].Za := 0;

        WITH U[1] DO BEGIN X := 0; Y := 0; X1 := L; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[2] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
        WITH U[3] DO BEGIN X := 0; Y := 0; X1 := 0; Y1 := 0; Z := 0; Z1 := 0; END;
      END;



    PROCEDURE INSERT(Linea : RigaRamo; VAR Padre, Figlio : Pointer; Dir : INTEGER; VAR X0, Y0 : REAL);
      VAR P1, P, P2 : Pointer;
        ch : CHAR;
        RifArch, AngXY, AngXZ, AngYZ, Campo, Chiave : INTEGER;
        RiDis : BOOLEAN;
      BEGIN
        RiDis := (Figlio <> NIL);
        NEW(P1);
        P1^.Pc := NIL; P1^.Ps := NIL; P1^.Pd := NIL;

        WITH Linea DO
          BEGIN
            P1^.Cod := CodPezzo; P1^.Ang := Ang;
            P1^.Lungh := L;
            P1^.D := A_D; P1^.A := W; P1^.B := H;
            P1^.CHFlag := CHFlag;
            P1^.Port := Portata;
            P1^.Perdita := Perdita;
            P1^.Varie := ComVal;
            P1^.Phi := Phi;
            P1^.R := R;
            P1^.NTab := -1;
          END;

        RifArch := FIND_ARCHIVIO(P1^.Cod);

        CASE ARCHIVIO[RifArch].CodDis OF
          1 : DisegnoA(P1^.Lungh, P1^.Graph, P1^.Point);
          2 : WITH P1^ DO DisegnoB(Ang, Graph, Point);
          3 : WITH P1^ DO
                BEGIN
                  IF Ang = 0 THEN Ang := 90;
                  DisegnoC(Ang, Graph, Point);
                END;
          4 : WITH P1^ DO
                BEGIN
                  IF Ang = 0 THEN Ang := 90;
                  DisegnoD(Ang, Graph, Point);
                END;
          5 : WITH P1^ DO
                BEGIN
                  IF Ang = 0 THEN Ang := 90;
                  DisegnoE(Ang, Graph, Point);
                END;
          6 : DisegnoF(P1^.Ang, P1^.Graph, P1^.Point);
          7 : DisegnoG(P1^.Ang, P1^.Graph, P1^.Point);
          8 : DisegnoA(1.0, P1^.Graph, P1^.Point);
          10 : DisegnoFT(P1^.Lungh, P1^.Graph, P1^.Point);
        ELSE EXIT;
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

            WITH P^.Point[Dir] DO AngXZ := ArcTg(x, z, x1, z1);
            RuotaXZ((360-AngXZ) MOD 360, P^.Graph, P^.Point);
            WITH P^.Point[Dir] DO AngYZ := ArcTg(y, z, y1, z1);
            RuotaYZ((360-AngYZ) MOD 360, P^.Graph, P^.Point);
            WITH P^.Point[Dir] DO AngXY := ArcTg(x, y, x1, y1);
            DISPOSE(P);
          END
        ELSE
          BEGIN
            AngXY := 0; AngXZ := 0; AngYZ := 0;
          END;

        RuotaXY(AngXY, P1^.Graph, P1^.Point);
        RuotaYZ(AngYZ, P1^.Graph, P1^.Point);
        RuotaXZ(AngXZ, P1^.Graph, P1^.Point);

        RuotaXY(Prosp.AngXY, P1^.Graph, P1^.Point);
        RuotaYZ(Prosp.AngYZ, P1^.Graph, P1^.Point);
        RuotaXZ(Prosp.AngXZ, P1^.Graph, P1^.Point);

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
        X0 := X0+P1^.Point[1].X1; Y0 := Y0+P1^.Point[1].Y1;
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
      VAR f : FILE OF Canale;
        g : FILE OF REAL;
        RAngXY, RAngXZ, RAngYZ : REAL;
        Campo, Chiave : INTEGER;
        fp : TEXT;

      PROCEDURE Registra(P : Pointer);
        BEGIN
          IF P <> NIL THEN
            BEGIN
              WRITE(f, P^);
              Registra(P^.Pc);
              Registra(P^.Ps);
              Registra(P^.Pd);
            END;
        END;

      BEGIN
        ASSIGN(g, DATA_DRIVE+NomeFile+'.SCG');
        ASSIGN(f, DATA_DRIVE+NomeFile+'.SCH');
        REWRITE(f);
        REWRITE(g);

        WRITE(g, X0Init, Y0Init, XMin, XMax, YMin, YMax, LXMin, LXMax, LYMin, LYMax);
        WITH Prosp DO
          BEGIN
            RAngXY := AngXY; RAngXZ := AngXZ; RAngYZ := AngYZ;
            WRITE(g, RAngXY, RAngXZ, RAngYZ);
          END;
        CLOSE(g);
        Registra(P);
        CLOSE(f);
      END;


    PROCEDURE LoadAlbero;
      VAR f : FILE OF Canale;
        g : FILE OF REAL;
        RAngXY, RAngXZ, RAngYZ : REAL;
        Campo, Chiave : INTEGER;
        fp : TEXT;

      BEGIN

        ASSIGN(g, DATA_DRIVE+NomeFile+'.SCG');
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


    PROCEDURE beep;
      BEGIN
        SOUND(440);
        DELAY(500);
        NOSOUND;
      END;


    PROCEDURE Percorri(PLink, FLink : Link; Padre, Ind : Pointer; Dir : INTEGER; X0, Y0 : REAL);
      VAR i : INTEGER;
        ch : CHAR;
      BEGIN
        IF FLink <> NIL THEN
          BEGIN
            INSERT(FLink^.T[1], Padre, Ind, Dir, X0, Y0);

            FOR i := 2 TO LTabRamo DO
              IF FLink^.T[i].CodPezzo > '' THEN INSERT(FLink^.T[i], Padre, Ind, 1, X0, Y0);
            Padre^.NTab := FLink^.CodTab;
            GOTOXY(30, 23); CLREOL;
            GOTOXY(30, 23); WRITE(FLink^.CodTab);
            Percorri(FLink, FLink^.Pc, Padre, Padre^.Pc, 1, X0, Y0);
            IF FLink^.Pc <> NIL THEN DISPOSE(FLink^.Pc);
            WITH Padre^ DO
              BEGIN
                X0 := X0-Point[1].X1+Point[2].X1;
                Y0 := Y0+Point[1].Y1+Point[2].Y1;
              END;
            Percorri(FLink, FLink^.Ps, Padre, Padre^.Ps, 2, X0, Y0);
            IF FLink^.Ps <> NIL THEN DISPOSE(FLink^.Ps);
            WITH Padre^ DO
              BEGIN
                X0 := X0-Point[2].X1+Point[3].X1;
                Y0 := Y0+Point[2].Y1+Point[3].Y1;
              END;
            Percorri(FLink, FLink^.Pd, Padre, Padre^.Pd, 3, X0, Y0);
            IF FLink^.Pd <> NIL THEN DISPOSE(FLink^.Pd);
          END;
      END;


    BEGIN
      IF P0 = NIL THEN EXIT;
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

      TEXTCOLOR(bianco);
      GOTOXY(1, 22); WRITE(' Rigenerazione disegno unifilare.');
      GOTOXY(1, 23); WRITE(' Valutazione nodo : ');
      Percorri(NIL, P0, NIL, Rete, 1, X0Init, Y0Init);

      SaveAlbero(Rete);
    END;
