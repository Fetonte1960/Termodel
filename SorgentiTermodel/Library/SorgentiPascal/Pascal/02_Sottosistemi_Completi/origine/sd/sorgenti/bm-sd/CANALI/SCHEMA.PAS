PROGRAM schema;
    {$I typedef.sys }
    {$I deftype.uti }
    {$I graphix.sys }
    {$I kernel.mc4  }
    {$I general.uti }

  CONST
    Nlinee = 3;
    NUsc = 3;
    NPezzi = 260;
    NLabel = 100;
  TYPE
    RecLab = RECORD
               X, Y : REAL;
               DeLab : STRING[20];
             END;
    Scritte = ARRAY[1..NLabel] OF RecLab;

    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : ST40;
                 CodDis : INTEGER;
                 Main, Branch, Fonte : ST8;
                 Varie : STRING[10];
                 TipoSez : ST5;
                 NUscite : INTEGER;
               END;           { 95 }
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
    melky : text;
    PhiPrec : INTEGER;
    C : Canale;
    X0Init, Y0Init : REAL;
    XMin, YMin, XMax, YMax : REAL;
    LXMin, LYMin, LXMax, LYMax : REAL;
    Rete : Pointer;
    Rientro, FlagUscita : BOOLEAN;
    flagb : boolean;
    Prosp : Angoli;
    Sine, Cosine : Trig;
    Prog : st18;
    ARCHIVIO : ARRAY[1..NPezzi] OF RigaArch; { 4500 }
    DATA_DRIVE : st80;
    Errore : INTEGER;
    Etic, PORT, Quote : Scritte;
    IndScritte : INTEGER;
    LabAble : BOOLEAN;
    Tf : TEXT; Head : st80;
    Fint : FILE OF INTEGER; PortMcHS : INTEGER;
    DescrPortMcHS : st80;


    {$I funzarc                 }
    {$I plotter.uti             }


  PROCEDURE InitScritte(VAR Vett : Scritte);
    VAR i : INTEGER;
    BEGIN
      IndScritte := 1;
      FOR i := 1 TO NLabel DO
        WITH Vett[i] DO
          BEGIN
            X := 0; Y := 0;
            DeLab := '';
          END;
    END;

  PROCEDURE DrawScritte(Vett : Scritte);
    VAR i   : INTEGER;
    BEGIN
      FOR i := 1 TO NLabel DO
        WITH Vett[i] DO
         begin
(*            if DeLab[1] = 'í' then
             begin
                DrawTextW(X, Y, 1, 'o');
                DeLab[1]:='/';
             end;   *)
            DrawTextW(X, Y, 1, DeLab);
         end;
    END;



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
      DefineWindow(i, TRUNC(X1/79*XMaxGlb+0.001), TRUNC(Y1/199*YMaxGlb+0.001),
      TRUNC(X2/79*XMaxGlb+0.5), TRUNC(Y2/199*YMaxGlb+0.5));
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


  PROCEDURE DrawComp(D : Componente; U : PuntiUsc; X0, Y0 : REAL);
    VAR i : INTEGER;
    BEGIN
      FOR i := 1 TO NLinee DO
        WITH D[i] DO DrawLine(Xp+X0, Yp+Y0, Xa+X0, Ya+Y0);
    END;



  PROCEDURE Attesa(VAR Sc : CHAR);
    BEGIN
      READ(KBD, Sc);
      IF Sc = CHR(27) THEN
        IF KEYPRESSED THEN READ(KBD, Sc);
    END;


  PROCEDURE Redraw(Ind : Pointer; X0, Y0 : REAL);
    VAR Scelta : CHAR;
    BEGIN
      IF Ind <> NIL THEN
        BEGIN
          DrawComp(Ind^.Graph, Ind^.Point, X0, Y0);
          ReDraw(Ind^.Pc, X0+Ind^.Point[1].X1, Y0+Ind^.Point[1].Y1);
          ReDraw(Ind^.Ps, X0+Ind^.Point[2].X1, Y0+Ind^.Point[2].Y1);
          ReDraw(Ind^.Pd, X0+Ind^.Point[3].X1, Y0+Ind^.Point[3].Y1);
          IF (Ind = Rete) AND LabAble THEN
            BEGIN
              DrawScritte(Etic);
              DrawScritte(PORT);
              DrawScritte(Quote);
            END;
        END;
    END;


  PROCEDURE RuotaSchemaXY(Ang : INTEGER; Ind : Pointer; X0, Y0 : REAL);
    VAR Scelta : CHAR;
    BEGIN
      IF Ang = 0 THEN EXIT;

      IF Ind <> NIL THEN
        BEGIN
          RuotaXY(Ang, Ind^.Graph, Ind^.Point);
          RuotaSchemaXY(Ang, Ind^.Pc, X0+Ind^.Point[1].X1, Y0+Ind^.Point[1].Y1);
          RuotaSchemaXY(Ang, Ind^.Ps, X0+Ind^.Point[2].X1, Y0+Ind^.Point[2].Y1);
          RuotaSchemaXY(Ang, Ind^.Pd, X0+Ind^.Point[3].X1, Y0+Ind^.Point[3].Y1);
        END;
    END;

  PROCEDURE RuotaSchemaXZ(Ang : INTEGER; Ind : Pointer; X0, Y0 : REAL);
    VAR Scelta : CHAR;
    BEGIN
      IF Ang = 0 THEN EXIT;

      IF Ind <> NIL THEN
        BEGIN
          RuotaXZ(Ang, Ind^.Graph, Ind^.Point);
          RuotaSchemaXZ(Ang, Ind^.Pc, X0+Ind^.Point[1].X1, Y0+Ind^.Point[1].Y1);
          RuotaSchemaXZ(Ang, Ind^.Ps, X0+Ind^.Point[2].X1, Y0+Ind^.Point[2].Y1);
          RuotaSchemaXZ(Ang, Ind^.Pd, X0+Ind^.Point[3].X1, Y0+Ind^.Point[3].Y1);
        END;
    END;

  PROCEDURE RuotaSchemaYZ(Ang : INTEGER; Ind : Pointer; X0, Y0 : REAL);
    VAR Scelta : CHAR;
    BEGIN
      IF Ang = 0 THEN EXIT;

      IF Ind <> NIL THEN
        BEGIN
          RuotaYZ(Ang, Ind^.Graph, Ind^.Point);
          RuotaSchemaYZ(Ang, Ind^.Pc, X0+Ind^.Point[1].X1, Y0+Ind^.Point[1].Y1);
          RuotaSchemaYZ(Ang, Ind^.Ps, X0+Ind^.Point[2].X1, Y0+Ind^.Point[2].Y1);
          RuotaSchemaYZ(Ang, Ind^.Pd, X0+Ind^.Point[3].X1, Y0+Ind^.Point[3].Y1);
        END;
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

  PROCEDURE Recall(P : Pointer);
    VAR
      Campo, Chiave : INTEGER;
      ch : CHAR;
    BEGIN
      SelectWindow(2);
      Campo := 1;

      P^.Port := P^.Port*PortMcHS;
      IF PortMcHS = 1 THEN
        UsaMaskera(SEG(P^.Cod), OFS(P^.Cod), DATA_DRIVE+'DatiPz.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE)
      ELSE
        UsaMaskera(SEG(P^.Cod), OFS(P^.Cod), DATA_DRIVE+'DatiPz1.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE);
      P^.Port := P^.Port/PortMcHS;

      SelectWindow(1);
    END;



  PROCEDURE INSERT(VAR Padre, Figlio : Pointer; Dir : INTEGER; X0, Y0 : REAL);
    VAR P1, P, P2 : Pointer;
      ch : CHAR;
      RifArch, AngXY, AngXZ, AngYZ, Campo, Chiave : INTEGER;
      RiDis : BOOLEAN;

    BEGIN

      RiDis := (Figlio <> NIL);
      NEW(P1);
      WITH P1^ DO
        BEGIN
          Pc := NIL; Ps := NIL; Pd := NIL; CHFlag := '';
          Cod := ''; PORT := 0; Ang := 0; R := 0; Lungh := 0;
          D := 0; A := 0; B := 0; Perdita := 0; Varie := 0;

          Phi := 0;

          NTab := -1;
        END;

      SelectWindow(2);
      REPEAT
        Campo := 1;

        P1^.Port := P1^.Port*PortMcHS;
        IF PortMcHS = 1 THEN
          UsaMaskera(SEG(P1^.Cod), OFS(P1^.Cod), DATA_DRIVE+'DatiPz.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE)
        ELSE
          UsaMaskera(SEG(P1^.Cod), OFS(P1^.Cod), DATA_DRIVE+'DatiPz1.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE);
        P1^.Port := P1^.Port/PortMcHS;

        RifArch := FIND_ARCHIVIO(P1^.Cod);
      UNTIL RifArch <> 0;

      SelectWindow(1);

      CASE ARCHIVIO[RifArch].CodDis OF
        1 : DisegnoA(P1^.Lungh, P1^.Graph, P1^.Point); {.. canali dritti ..}
        2 : WITH P1^ DO       {.. curve         ..}
              BEGIN
                IF Ang = 0 THEN Ang := SelectAng(Cod);
                DisegnoB(Ang, Graph, Point);
              END;
        3 : WITH P1^ DO       {.. tee Â ..}
              BEGIN
                IF Ang = 0 THEN Ang := 90;
                DisegnoC(Ang, Graph, Point);
              END;
        4 : WITH P1^ DO       {.. tee ´ ..}
              BEGIN
                IF Ang = 0 THEN Ang := 90;
                DisegnoD(Ang, Graph, Point);
              END;
        5 : WITH P1^ DO       {.. croce Å ..}
              BEGIN
                IF Ang = 0 THEN Ang := 90;
                DisegnoE(Ang, Graph, Point);
              END;
        6 : DisegnoF(P1^.Ang, P1^.Graph, P1^.Point); {.. bocchetta ..}
        7 : DisegnoG(P1^.Ang, P1^.Graph, P1^.Point); {.. inseriti  ..}
        8 : DisegnoA(1.0, P1^.Graph, P1^.Point); {.. raccordi  ..}
        10 : DisegnoFT(P1^.Lungh, P1^.Graph, P1^.Point); {.. di0r      ..}
      ELSE EXIT;
      END;

      NEW(P2);
      P2^ := P1^;
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

      REPEAT
        CopyScreen;
        P1^ := P2^;
        RuotaYZ(P1^.Phi, P1^.Graph, P1^.Point);

        RuotaXY(AngXY, P1^.Graph, P1^.Point);
        RuotaYZ(AngYZ, P1^.Graph, P1^.Point);
        RuotaXZ(AngXZ, P1^.Graph, P1^.Point);

        RuotaXY(Prosp.AngXY, P1^.Graph, P1^.Point);
        RuotaYZ(Prosp.AngYZ, P1^.Graph, P1^.Point);
        RuotaXZ(Prosp.AngXZ, P1^.Graph, P1^.Point);
        IF NOT(ARCHIVIO[RifArch].CodDis IN [1, 7, 8]) THEN
          BEGIN
            DrawComp(P1^.Graph, P1^.Point, X0, Y0);
            Attesa(ch);
            WITH P2^ DO
              CASE ch OF
                '-' : Phi := (Phi+270) MOD 360;
                '+' : Phi := (Phi+90) MOD 360;
              ELSE
              END;
            SwapScreen;
          END;
      UNTIL (ORD(ch) = 13) OR (ARCHIVIO[RifArch].CodDis IN [1, 7, 8]);


      DISPOSE(P2);

      IF Padre <> NIL THEN
        CASE Dir OF
          1 : Padre^.Pc := P1;
          2 : Padre^.Ps := P1;
          3 : Padre^.Pd := P1;
        END
      ELSE Rete := P1;

      P1^.Pc := Figlio;

      IF RiDis THEN
        BEGIN
          CLEARSCREEN;
          DrawBorder;
          ReDraw(Rete, X0Init, Y0Init);
        END
      ELSE DrawComp(P1^.Graph, P1^.Point, X0, Y0);

      Figlio := P1;
    END;


  PROCEDURE PurgeRamo(P : Pointer);
    VAR P1, P2, P3 : Pointer;
    BEGIN
      IF P <> NIL THEN
        BEGIN
          P1 := P^.Pc;
          P2 := P^.Ps;
          P3 := P^.Pd;
          DISPOSE(P);
          PurgeRamo(P1);
          PurgeRamo(P2);
          PurgeRamo(P3);
        END;
    END;


  PROCEDURE DeletePezzo(VAR Padre, Figlio : Pointer; Dir : INTEGER);
    VAR Pun : pointer;
    BEGIN
      IF Figlio = NIL THEN EXIT;

      IF Padre <> NIL THEN
        BEGIN
          Pun := Figlio^.Pc;
          CASE Dir OF
            1 : Padre^.Pc := Figlio^.Pc;
            2 : Padre^.Ps := Figlio^.Pc;
            3 : Padre^.Pd := Figlio^.Pc;
          END;

          PurgeRamo(Figlio^.Pd);
          PurgeRamo(Figlio^.Ps);
          DISPOSE(Figlio);

          Figlio := Pun;

          CLEARSCREEN;
          DrawBorder;
          ReDraw(Rete, X0Init, Y0Init);
        END;
    END;


  PROCEDURE Visual(X0, Y0 : REAL);
    BEGIN
      DrawLine(X0-0.5, Y0-0.5, X0+0.5, Y0+0.5);
      DrawLine(X0-0.5, Y0+0.5, X0+0.5, Y0-0.5);
    END;



  PROCEDURE Box(VAR x0, y0, x1, y1 : REAL);
    BEGIN
      DrawLine(x0, y0, x1, y0);
      DrawLine(x1, y0, x1, y1);
      DrawLine(x1, y1, x0, y1);
      DrawLine(x0, y1, x0, y0);
    END;



  PROCEDURE Zoom(x, y : REAL);
    BEGIN
      XMin := x-1; XMax := x+1;
      YMin := y-1; YMax := y+1;
      REPEAT
        CopyScreen;
        Box(XMin, YMin, XMax, YMax);
        READ(KBD, ch);
        CASE ch OF
          '-' :
            IF XMin < x THEN
              BEGIN
                XMin := XMin+1;
                XMax := XMax-1;
                YMin := YMin+1;
                YMax := YMax-1;
              END;
          '+' :
            BEGIN
              XMin := XMin-1;
              XMax := XMax+1;
              YMin := YMin-1;
              YMax := YMax+1;
            END;
        ELSE
        END;
        SwapScreen;
      UNTIL ORD(ch) = 13;

      DefineWorld(2, XMin, YMin, XMax, YMax);
      DefineWindowIBM(1, 19, 0, 79, 199);

      SelectWorld(2);
      SelectWindow(1);

      CLEARSCREEN;
      DrawBorder;
      ReDraw(Rete, X0Init, Y0Init);
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
    END;                      { proc. codtab_form }


  PROCEDURE MoveLabel(VAR X, Y : REAL; Lab : st40);
    VAR ch : CHAR;
        Lb : st40;
    BEGIN
       flagb := false;
(*      Lb := Lab;
      if Lab[1] = 'í' then
       begin
          DrawTextW(X, Y, 1, 'o');
          Lab[1]:='/';
       end; *)
      DrawTextW(X, Y, 1, Lab);
(*      Lab:=Lb; *)
      REPEAT
        Attesa(Ch);
        CASE ch OF
          'M' : X := X+1;
          'K' : X := X-1;
          'H' : Y := Y+1;
          'P' : Y := Y-1;
          'S' : BEGIN
                  Lab := '';
                  Ch := CHR(13);
                  SwapScreen;
                  CopyScreen;   flagb := true;
                END;
        ELSE
        END;

        IF ORD(ch) <> 13 THEN
          BEGIN
            SwapScreen;
            CopyScreen;
(*            Lab:=Lb;
            if Lab[1] = 'í' then
             begin
                DrawTextW(X, Y, 1, 'o');
                Lab[1]:='/';
             end;   *)
            DrawTextW(X, Y, 1, Lab);
          END;
      UNTIL ORD(ch) = 13;
      CopyScreen;
    END;



  PROCEDURE Etichetta(Ind : pointer; X0, Y0 : REAL);
    VAR Descr : st40;
      X01, Y01 : REAL;
    BEGIN
      IF Ind = NIL THEN EXIT;
      X01 := X0; Y01 := Y0;
      IF Ind^.NTab > -1 THEN
        BEGIN
          Descr := CodTab_Form(Ind^.NTab);
          MoveLabel(X0, Y0, Descr);
          WITH Etic[IndScritte] DO
            BEGIN
              X := X0;
              Y := Y0;
              DeLab := Descr;
            END;
          IndScritte := IndScritte+1;
        END
      ELSE
        IF Ind = Rete THEN
          BEGIN
            Descr := CodTab_Form(0);
            MoveLabel(X0, Y0, Descr);
            WITH Etic[IndScritte] DO
              BEGIN
                X := X0;
                Y := Y0;
                DeLab := Descr;
              END;
            IndScritte := IndScritte+1;
          END;
      Etichetta(Ind^.Pc, X01+Ind^.Point[1].X1, Y01+Ind^.Point[1].Y1);
      Etichetta(Ind^.Ps, X01+Ind^.Point[2].X1, Y01+Ind^.Point[2].Y1);
      Etichetta(Ind^.Pd, X01+Ind^.Point[3].X1, Y01+Ind^.Point[3].Y1);
    END;


  PROCEDURE Portata(Ind : pointer; X0, Y0 : REAL);
    VAR Descr : st40;
      X01, Y01 : REAL;
    BEGIN
      IF Ind = NIL THEN EXIT;
      X01 := X0; Y01 := Y0;
      IF (Ind^.Pc = NIL) THEN
        BEGIN
          STR(Ind^.Port:4:2, Descr);
          Descr := Descr+' mc/s';
          MoveLabel(X0, Y0, Descr);
          WITH PORT[IndScritte] DO
            BEGIN
              X := X0;
              Y := Y0;
              DeLab := Descr;
            END;
          IndScritte := IndScritte+1;
        END;
      Portata(Ind^.Pc, X01+Ind^.Point[1].X1, Y01+Ind^.Point[1].Y1);
      Portata(Ind^.Ps, X01+Ind^.Point[2].X1, Y01+Ind^.Point[2].Y1);
      Portata(Ind^.Pd, X01+Ind^.Point[3].X1, Y01+Ind^.Point[3].Y1);
    END;

  PROCEDURE Quota(Ind : pointer; X0, Y0 : REAL);
    VAR Descr, pr : st40;
      X01, Y01 : REAL;
    BEGIN
      IF Ind = NIL THEN EXIT;
      X01 := X0; Y01 := Y0;
      WITH Ind^ DO
        BEGIN
          IF (Cod[1] = '3') AND (Cod[2] = '1') THEN
            BEGIN
              IF UPCASE(Cod[4]) = 'R' THEN
                BEGIN
                  STR(A, Descr);
                  STR(B, pr);
                  Descr := Descr+'x'+pr;
                END
              ELSE
                BEGIN
                  STR(D:4, Descr);
                  Descr := 'd'+Descr;
                END;
              MoveLabel(X0, Y0, Descr);
              if not flagb then
               begin
                 WITH Quote[IndScritte] DO
                   BEGIN
                     X := X0;
                     Y := Y0;
                     DeLab := Descr;
                   END;
                 IndScritte := IndScritte+1;
               end;
            END;
        END;

      Quota(Ind^.Pc, X01+Ind^.Point[1].X1, Y01+Ind^.Point[1].Y1);
      Quota(Ind^.Ps, X01+Ind^.Point[2].X1, Y01+Ind^.Point[2].Y1);
      Quota(Ind^.Pd, X01+Ind^.Point[3].X1, Y01+Ind^.Point[3].Y1);

    END;



  PROCEDURE ZoomAll;
    BEGIN
      XMin := LxMin; XMax := LXMax;
      YMin := LYMin; YMax := LYMax;

      DefineWorld(2, XMin, YMin, XMax, YMax);
      DefineWindowIBM(1, 19, 0, 79, 199);

      SelectWorld(2);
      SelectWindow(1);

      CLEARSCREEN;
      DrawBorder;
      ReDraw(Rete, X0Init, Y0Init);
    END;


  PROCEDURE Limits;
    TYPE limiti = RECORD
                    X0, X1, Y0, Y1 : REAL;
                  END;
    VAR V : limiti;
      Campo, Chiave : INTEGER;
    BEGIN
      WITH V DO
        BEGIN
          X0 := LxMin; X1 := LXMax;
          Y0 := LYMin; Y1 := LYMax;
        END;

      SelectWindow(2);
      Campo := 1;
      UsaMaskera(SEG(V), OFS(V), DATA_DRIVE+'limiti.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE);
      SelectWindow(1);

      WITH V DO
        BEGIN
          LxMin := X0; LXMax := X1;
          LYMin := Y0; LYMax := Y1;
        END;

      DefineWorld(2, LXMin, LYMin, LXMax, LYMax);
      DefineWindowIBM(1, 19, 0, 79, 199);

      SelectWorld(2);
      SelectWindow(1);

      CLEARSCREEN;
      DrawBorder;
      ReDraw(Rete, X0Init, Y0Init);
    END;


  PROCEDURE Rotazione(Ind : Pointer; X0, Y0 : REAL);
    VAR Campo, Chiave : INTEGER;
    BEGIN
      WITH Prosp DO
        BEGIN

          RuotaSchemaXZ((360-AngXZ) MOD 360, Ind, 0, 0);
          RuotaSchemaYZ((360-AngYZ) MOD 360, Ind, 0, 0);
          RuotaSchemaXY((360-AngXY) MOD 360, Ind, 0, 0);

          SelectWindow(2);
          Campo := 1;
          UsaMaskera(SEG(Prosp), OFS(Prosp), DATA_DRIVE+'Angoli.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE);
          SelectWindow(1);

          RuotaSchemaXY(AngXY, Ind, 0, 0);
          RuotaSchemaYZ(AngYZ, Ind, 0, 0);
          RuotaSchemaXZ(AngXZ, Ind, 0, 0);


          CLEARSCREEN;
          DrawBorder;
          ReDraw(Rete, X0Init, Y0Init);
          FlagUscita := TRUE;
          Rientro := TRUE;
        END;
    END;


  PROCEDURE InsBlocco(IndPadre : Pointer; VAR Ind : pointer; X0, Y0 : REAL);
    VAR Campo, Chiave : INTEGER;
      Nome : st8;
      f : FILE OF Canale;
      g : FILE OF REAL;
      RAngXY, RAngXZ, RAngYZ : REAL;
      PAngXY, PAngXZ, PAngYZ : INTEGER;
      fp : TEXT;
      P, P1, P2 : pointer;
      Ridis, Trovato : BOOLEAN;
      PhiPrec, RifArch : INTEGER;

    PROCEDURE RuotaBlocco(Ind : Pointer; AngXY, AngYZ, AngXZ : INTEGER);
      BEGIN

        RuotaSchemaXY(AngXY, Ind, 0, 0);
        RuotaSchemaYZ(AngYZ, Ind, 0, 0);
        RuotaSchemaXZ(AngXZ, Ind, 0, 0);

        WITH Prosp DO
          BEGIN
            RuotaSchemaXY(AngXY, Ind, 0, 0);
            RuotaSchemaYZ(AngYZ, Ind, 0, 0);
            RuotaSchemaXZ(AngXZ, Ind, 0, 0);
          END;


      END;


    PROCEDURE Leggi(P : Pointer);
      VAR P1 : Pointer;
      BEGIN
        READ(f, P^);

        IF P^.Pc <> NIL THEN
          BEGIN
            NEW(P1); P^.Pc := P1;
            Leggi(P^.Pc);
          END;

        IF P^.Ps <> NIL THEN
          BEGIN
            NEW(P1); P^.Ps := P1;
            Leggi(P^.Ps);
          END;

        IF P^.Pd <> NIL THEN
          BEGIN
            NEW(P1); P^.Pd := P1;
            Leggi(P^.Pd);
          END;

      END;


    PROCEDURE SaveArea(P1 : pointer);
      VAR
        f1 : FILE OF Componente;
        f2 : FILE OF PuntiUsc;

      PROCEDURE SaveBlockTemp(P1 : pointer);
        BEGIN
          IF P1 <> NIL THEN
            BEGIN
              WRITE(f1, P1^.Graph);
              WRITE(f2, P1^.Point);
              SaveBlockTemp(P1^.Pc);
              SaveBlockTemp(P1^.Ps);
              SaveBlockTemp(P1^.Pd);
            END;
        END;

      BEGIN
        ASSIGN(f1, DATA_DRIVE+'Area1.blk'); ASSIGN(f2, DATA_DRIVE+'Area2.blk');
        REWRITE(f1); REWRITE(f2);
        SaveBlockTemp(P1);
        CLOSE(f1); CLOSE(f2);
      END;


    PROCEDURE LoadArea(P1 : pointer);
      VAR
        f1 : FILE OF Componente;
        f2 : FILE OF PuntiUsc;

      PROCEDURE LoadBlockTemp(P1 : pointer);
        BEGIN
          IF P1 <> NIL THEN
            BEGIN
              READ(f1, P1^.Graph);
              READ(f2, P1^.Point);
              LoadBlockTemp(P1^.Pc);
              LoadBlockTemp(P1^.Ps);
              LoadBlockTemp(P1^.Pd);
            END;
        END;

      BEGIN
        ASSIGN(f1, DATA_DRIVE+'Area1.blk'); ASSIGN(f2, DATA_DRIVE+'Area2.blk');
        RESET(f1); RESET(f2);
        LoadBlockTemp(P1);
        CLOSE(f1); CLOSE(f2);
      END;


    PROCEDURE CancellaArea;
      VAR
        f1 : FILE OF Componente;
        f2 : FILE OF PuntiUsc;
      BEGIN
        IF Exist(DATA_DRIVE+'Area1.blk') THEN
          BEGIN
            ASSIGN(f1, DATA_DRIVE+'Area1.blk'); ASSIGN(f2, DATA_DRIVE+'Area2.blk');
            ERASE(f1); ERASE(f2);
          END;
      END;


    BEGIN
      SelectWindow(2);
      Campo := 1; Nome := '';
      UsaMaskera(SEG(Nome), OFS(Nome), DATA_DRIVE+'Blocco.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE);

      ASSIGN(g, DATA_DRIVE+Nome+'.SCG');
      ASSIGN(f, DATA_DRIVE+Nome+'.SCH');
      {$I-} RESET(f); RESET(g); {$I+}
      IF (IORESULT = 0) THEN
        BEGIN
          READ(g, X0Init, Y0Init, XMin, XMax, YMin, YMax, LXMin, LXMax, LYMin, LYMax);
          WITH Prosp DO
            BEGIN
              READ(g, RAngXY, RAngXZ, RAngYZ);
            END;
          CLOSE(g);
          NEW(P1);
          IF NOT EOF(f) THEN Leggi(P1);
          CLOSE(f);
        END;


      IF P1 <> NIL THEN
        BEGIN
          RuotaSchemaXZ((360-TRUNC(RAngXZ)) MOD 360, P1, 0, 0);
          RuotaSchemaYZ((360-TRUNC(RAngYZ)) MOD 360, P1, 0, 0);
          RuotaSchemaXY((360-TRUNC(RAngXY)) MOD 360, P1, 0, 0);

          IF IndPadre <> NIL THEN
            BEGIN
              NEW(P);
              P^ := IndPadre^;
              {*** riporta il pezzo precedente in pianta ***}
              RuotaXZ((360-Prosp.AngXZ) MOD 360, P^.Graph, P^.Point);
              RuotaYZ((360-Prosp.AngYZ) MOD 360, P^.Graph, P^.Point);
              RuotaXY((360-Prosp.AngXY) MOD 360, P^.Graph, P^.Point);

              WITH P^.Point[1] DO PAngXZ := ArcTg(x, z, x1, z1);
              RuotaXZ((360-PAngXZ) MOD 360, P^.Graph, P^.Point);
              WITH P^.Point[1] DO PAngYZ := ArcTg(y, z, y1, z1);
              RuotaYZ((360-PAngYZ) MOD 360, P^.Graph, P^.Point);
              WITH P^.Point[1] DO PAngXY := ArcTg(x, y, x1, y1);
              DISPOSE(p);
            END
          ELSE
            BEGIN
              PAngXY := 0; PAngXZ := 0; PAngYZ := 0;
            END;

          SelectWindow(1);

          P2 := P1; Trovato := FALSE;
          WHILE (P2 <> NIL) AND NOT Trovato DO
            BEGIN
              RifArch := FIND_ARCHIVIO(P2^.Cod);
              Trovato := NOT(ARCHIVIO[RifArch].CodDis IN [1, 7, 8]);
              IF NOT Trovato THEN P2 := P2^.Pc;
            END;

          {---------------------------------------------------------------}
          RuotaBlocco(P1, PAngXY, PAngYZ, PAngXZ);
          {.da eliminare quando vengono eliminati i commenti successivi ..}

          {
          SaveArea(P1);
          repeat
          CopyScreen;
          if Trovato then RuotaSchemaYZ(P2^.Phi,P2,0,0);
          RuotaBlocco  (P1,PAngXY,PAngYZ,PAngXZ);
          ReDraw       (P1,X0,Y0);
          if Trovato then
          begin
          read(kbd,ch);
          with P2^ do
          case ch of
          '-':begin
          LoadArea(P1);
          P:=P2;
          while P <> nil do
          begin
          RifArch:=FIND_ARCHIVIO(P^.Cod);
          Trovato:=not(ARCHIVIO[RifArch].CodDis in[1,7,8]);
          if Trovato then
          with P^ do Phi:=(Phi + 270 ) mod 360;
          P:=P^.Pc;
          end;
          end;
          '+':begin
          LoadArea(P1);
          P:=P2;
          while P <> nil do
          begin
          RifArch:=FIND_ARCHIVIO(P^.Cod);
          Trovato:=not(ARCHIVIO[RifArch].CodDis in[1,7,8]);
          if Trovato then
          with P^ do Phi:=(Phi + 90 ) mod 360;
          P:=P^.Pc;
          end;
          end;
          else
          end;
          SwapScreen;
          end;
          until (ch = #13) or not Trovato;

          CancellaArea;
          }
          IF IndPadre <> NIL THEN IndPadre^.Pc := P1
          ELSE Rete := P1;

          P2 := P1;
          WHILE P2^.Pc <> NIL DO P2 := P2^.Pc; {cerco indirizzo ultimo elemento
                                               del tronco del blocco}
          Ridis := (Ind <> NIL);
          P2^.Pc := Ind;
          Ind := P1;

          IF Ridis THEN
            BEGIN
              CLEARSCREEN;
              DrawBorder;
              ReDraw(Rete, X0Init, Y0Init);
            END
          ELSE ReDraw(P1, X0, Y0);

        END;
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

  PROCEDURE Trasla(D : INTEGER; Fl : CHAR);
    VAR i : INTEGER;
    BEGIN
      IF Fl = 'O' THEN
        BEGIN
          X0Init := X0Init+D;
          FOR i := 1 TO NLabel DO
            BEGIN
              Etic[i].X := Etic[i].X+D;
              PORT[i].X := PORT[i].X+D;
              Quote[i].X := Quote[i].X+D;
            END;
        END
      ELSE
        BEGIN
          Y0Init := Y0Init+D;
          FOR i := 1 TO NLabel DO
            BEGIN
              Etic[i].Y := Etic[i].Y+D;
              PORT[i].Y := PORT[i].Y+D;
              Quote[i].Y := Quote[i].Y+D;
            END;
        END;

      CLEARSCREEN;
      DrawBorder;
      Redraw(Rete, X0Init, Y0Init);
      FlagUscita := TRUE;
      Rientro := TRUE;
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
      ASSIGN(fp, DATA_DRIVE+'prog.can');
      RESET(fp);
      IF IORESULT = 0 THEN
        BEGIN
          READLN(fp, Prog);
          CLOSE(fp);
        END;
      ASSIGN(g, DATA_DRIVE+Prog+'.SCG');
      ASSIGN(f, DATA_DRIVE+Prog+'.SCH');
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

    PROCEDURE Leggi(P : Pointer);
      VAR P1 : Pointer;
      BEGIN
        READ(f, P^);

        IF P^.Pc <> NIL THEN
          BEGIN
            NEW(P1); P^.Pc := P1;
            Leggi(P^.Pc);
          END;

        IF P^.Ps <> NIL THEN
          BEGIN
            NEW(P1); P^.Ps := P1;
            Leggi(P^.Ps);
          END;

        IF P^.Pd <> NIL THEN
          BEGIN
            NEW(P1); P^.Pd := P1;
            Leggi(P^.Pd);
          END;

      END;

    BEGIN
      ASSIGN(fp, DATA_DRIVE+'prog.can');
      {$I-} RESET(fp);        {$I+}
      IF IORESULT = 0 THEN
        BEGIN
          READLN(fp, Prog);
          CLOSE(fp);
        END;

      ASSIGN(g, DATA_DRIVE+Prog+'.SCG');
      ASSIGN(f, DATA_DRIVE+Prog+'.SCH');
      {$I-} RESET(f); RESET(g); {$I+}
      IF (IORESULT = 0) THEN
        BEGIN
          READ(g, X0Init, Y0Init, XMin, XMax, YMin, YMax, LXMin, LXMax, LYMin, LYMax);
          WITH Prosp DO
            BEGIN
              READ(g, RAngXY, RAngXZ, RAngYZ);
              AngXY := ROUND(RAngXY); AngXZ := ROUND(RAngXZ); AngYZ := ROUND(RAngYZ);
            END;
          CLOSE(g);
          NEW(Rete);
          IF NOT EOF(f) THEN Leggi(Rete);
          CLOSE(f);
        END;
    END;

  PROCEDURE EraseMask;
    VAR K : INTEGER;
    BEGIN
      SelectWindow(2);
      GOTOXY(1, 1);
      FOR k := 1 TO 22 DO WRITELN('                  ');
      SelectWindow(1);
    END;

  PROCEDURE beep;
    BEGIN
      SOUND(440);
      DELAY(500);
      NOSOUND;
    END;

  PROCEDURE ChangeMcHS;
    BEGIN
      IF PortMcHS = 1 THEN
        BEGIN
          PortMcHS := 3600;
          DescrPortMcHS := '  -  portate in mc/h';
        END
      ELSE
        BEGIN
          PortMcHS := 1;
          DescrPortMcHS := '  -  portate in mc/s';
        END;
      ASSIGN(Fint, DATA_DRIVE+Prog+'.msc'); REWRITE(Fint); WRITE(Fint, PortMcHS);
      CLOSE(Fint);
    END;



  PROCEDURE Percorri(Padre, Ind : Pointer; Dir : INTEGER; X0, Y0 : REAL);
    VAR Scelta : CHAR;
    BEGIN
      REPEAT
        IF FlagUscita THEN EXIT;

        CopyScreen;
        Visual(X0, Y0);
        Attesa(Scelta);
        SwapScreen;
        CASE scelta OF
          ';' : IF Ind = Rete THEN
                  BEGIN
                    beep;
                    Scelta := '0';
                  END;
          '<' : IF Ind <> NIL THEN
                  Percorri(Ind, Ind^.Pc, 1, X0+Ind^.Point[1].X1, Y0+Ind^.Point[1].Y1) {.. freccia avanti ..}
                ELSE beep;
          '=' : IF Ind <> NIL THEN
                  Percorri(Ind, Ind^.Ps, 2, X0+Ind^.Point[2].X1, Y0+Ind^.Point[2].Y1) {.. freccia in basso }
                ELSE beep;
          '>' : IF Ind <> NIL THEN
                  Percorri(Ind, Ind^.Pd, 3, X0+Ind^.Point[3].X1, Y0+Ind^.Point[3].Y1) {.. freccia in alto .}
                ELSE beep;
          '?' : BEGIN
                  InsBlocco(Padre, Ind, X0, Y0);
                END;
          'R' : INSERT(Padre, Ind, Dir, X0, Y0); {.. ins ..}
          'S' : BEGIN
                  DeletePezzo(Padre, Ind, Dir); {.. del ..}
                  IF Ind = NIL THEN EXIT;
                END;
          '@' : IF Rete <> NIL THEN Zoom(X0, Y0); { ..zoom definito.. }
          'A' : IF Rete <> NIL THEN ZoomAll; { ..zoom all     .. }
          'B' : Limits;       { ..limits       .. }
          'C' : Rotazione(Rete, 0, 0);
          'H' : Trasla(1, 'V');
          'P' : Trasla(-1, 'V');
          'K' : Trasla(-1, 'O');
          'M' : Trasla(1, 'O');
          't' : Trasla(10, 'O');
          's' : Trasla(-10, 'O');
          'I' : Trasla(10, 'V');
          'Q' : Trasla(-10, 'V');
          'D' : IF Ind <> NIL THEN Recall(Ind)
                ELSE beep;
          'T' : BEGIN
                  SwapScreen;
                  InitScritte(Etic);
                  LabAble := TRUE;
                  Etichetta(Rete, X0Init, Y0Init);
                END;
          'U' : BEGIN
                  SwapScreen;
                  InitScritte(PORT);
                  LabAble := TRUE;
                  Portata(Rete, X0Init, Y0Init);
                END;
          'V' : BEGIN
                  SwapScreen;
                  InitScritte(Quote);
                  LabAble := TRUE;
                  Quota(Rete, X0Init, Y0Init);
                END;

          'W' : BEGIN
                  InizializzaPlot(0, 1000, 15000, 11200);
                  Scale(ROUND(LXMin), ROUND(LXMax), ROUND(LYMin), ROUND(LYMax));
                  Plotter(Rete, X0Init, Y0Init);
                  PlotBorder;
                  LeavePlotter;
                END;
          'X' : LabAble := NOT(LabAble);
          'Y' : BEGIN
                  ChangeMcHS;
                  DefineHeader(1, Head+DescrPortMcHS); SetHeaderOn;
                  DrawBorder;
                END;
          '[' : HardCopy(FALSE, 1);
          '\' : BEGIN
                  HardCopy(FALSE, 1);
                  WRITE(LST, #12);
                END;
          #27 : FlagUscita := TRUE;
        ELSE
        END;
        EraseMask;
      UNTIL Scelta = ';';
    END;


  BEGIN
    ctrlkey := 1;
    DATA_DRIVE := 'C:\daticca\';
    assign (melky,'melky.dat');
    rewrite (melky);
    ASSIGN(Tf, DATA_DRIVE+'Testata.grp');
    RESET(Tf); READLN(Tf, Head);
    CLOSE(Tf);

    Prog := '';
    ASSIGN(Tf, DATA_DRIVE+'prog.can');
    {$I-} RESET(Tf);          {$I+}
    IF IORESULT = 0 THEN
      BEGIN
        READLN(Tf, Prog);
        CLOSE(Tf);
      END;

    ASSIGN(Fint, DATA_DRIVE+Prog+'.msc');
    {$I-} RESET(Fint);        {$I+}
    IF IORESULT = 0 THEN
      BEGIN
        READ(Fint, PortMcHS);
        CLOSE(Fint);
      END
    ELSE PortMcHS := 1;

    IF PortMcHS = 1 THEN DescrPortMcHS := '  -  portate in mc/s'
    ELSE DescrPortMcHS := '  -  portate in mc/h';

    Errore := Transfer_Archivio;

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

    InitGraphic;

    DefineWorld(2, XMin, YMin, XMax, YMax);

    DefineWindowIBM(1, 19, 0, 79, 199);

    DefineWindowIBM(2, 0, 0, 19, 199);
    SelectWindow(1);
    DefineHeader(1, Head+DescrPortMcHS); SetHeaderOn;

    DrawBorder;

    CarTrig(Sine, Cosine);

    LoadAlbero;
    InitScritte(Etic);
    InitScritte(PORT);
    InitScritte(Quote);
    LabAble := FALSE;

    DefineWorld(2, LXMin, LYMin, LXMax, LYMax);

    SelectWorld(2);
    SelectWindow(1);


    ReDraw(Rete, X0Init, Y0Init);

    REPEAT
      FlagUscita := FALSE;
      Rientro := FALSE;
      Percorri(NIL, Rete, 1, X0Init, Y0Init);
    UNTIL NOT Rientro;

    LeaveGraphic;
    SaveAlbero(Rete);
    close (melky);
  END.
