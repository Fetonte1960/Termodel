PROGRAM schema3d;
    {$I typedef.sys             }
    {$I deftype.uti             }
    {$I graphix.sys             }
    {$I kernel.mc4              }
    {$I general.uti             }


  CONST
    Version = 402;
    Nlinee = 28;
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
    C : Canale;
    X0Init, Y0Init : REAL;
    XMin, YMin, XMax, YMax : REAL;
    LXMin, LYMin, LXMax, LYMax : REAL;
    Rete : Pointer;
    Rientro, FlagUscita : BOOLEAN;
    Prosp : Angoli;
    Sine, Cosine : Trig;
    Prog : st18;
    Duct : Integer;
    DATA_DRIVE : st80;
    Errore : INTEGER;
    Etic, PORT, Quote : Scritte;
    IndScritte : INTEGER;
    LabAble : BOOLEAN;

    {$I Chiave.pas              }
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
    VAR i : INTEGER;
    BEGIN
      FOR i := 1 TO NLabel DO
        WITH Vett[i] DO
          DrawTextW(X, Y, 1, DeLab);
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

  PROCEDURE DrawComp(D : Componente; U : PuntiUsc; X0, Y0 : REAL);
    VAR i : INTEGER;
    BEGIN
      FOR i := 1 TO NLinee DO
        WITH D[i] DO
          IF NOT((Xp = Xa) AND (Yp = Ya)) THEN DrawLine(Xp+X0, Yp+Y0, Xa+X0, Ya+Y0);
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
      UsaMaskera(SEG(P^.Cod), OFS(P^.Cod), DATA_DRIVE+'DatiPz.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE);
      SelectWindow(1);
    END;



  PROCEDURE CorreggiPezzo(Padre, Figlio : Pointer; Dir : INTEGER; X0, Y0 : REAL);
    VAR P1, P, P2 : Pointer;
      ch : CHAR;
      RifArch, AngXY, AngXZ, AngYZ, Campo, Chiave : INTEGER;
      RiDis : BOOLEAN;
    BEGIN
      IF Figlio = NIL THEN EXIT;
      NEW(P1); P1^ := Figlio^;
      RuotaXZ((360-Prosp.AngXZ) MOD 360, P1^.Graph, P1^.Point);
      RuotaYZ((360-Prosp.AngYZ) MOD 360, P1^.Graph, P1^.Point);
      RuotaXY((360-Prosp.AngXY) MOD 360, P1^.Graph, P1^.Point);

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

      RuotaXZ((360-AngXZ) MOD 360, P1^.Graph, P1^.Point);
      RuotaYZ((360-AngYZ) MOD 360, P1^.Graph, P1^.Point);
      RuotaXY((360-AngXY) MOD 360, P1^.Graph, P1^.Point);

      RuotaYZ((360-P1^.Phi) MOD 360, P1^.Graph, P1^.Point);

      NEW(P2);
      P2^ := P1^;
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

        DrawComp(P1^.Graph, P1^.Point, X0, Y0);

        Attesa(ch);
        WITH P2^ DO
          CASE ch OF
            '-' : Phi := (Phi+270) MOD 360;
            '+' : Phi := (Phi+90) MOD 360;
            'P' : IF Padre <> NIL THEN
                    BEGIN
                      Padre^.Point[Dir].Y := Padre^.Point[Dir].Y-0.025;
                      Padre^.Point[Dir].Y1 := Padre^.Point[Dir].Y1-0.025;
                      Y0 := Y0-0.025;
                    END;
            'H' : IF Padre <> NIL THEN
                    BEGIN
                      Padre^.Point[Dir].Y := Padre^.Point[Dir].Y+0.025;
                      Padre^.Point[Dir].Y1 := Padre^.Point[Dir].Y1+0.025;
                      Y0 := Y0+0.025;
                    END;
            'K' : IF Padre <> NIL THEN
                    BEGIN
                      Padre^.Point[Dir].X := Padre^.Point[Dir].X-0.025;
                      Padre^.Point[Dir].X1 := Padre^.Point[Dir].X1-0.025;
                      X0 := X0-0.025;
                    END;
            'M' : IF Padre <> NIL THEN
                    BEGIN
                      Padre^.Point[Dir].X := Padre^.Point[Dir].X+0.025;
                      Padre^.Point[Dir].X1 := Padre^.Point[Dir].X1+0.025;
                      X0 := X0+0.025;
                    END;
          ELSE
          END;
        SwapScreen;
      UNTIL (ORD(ch) = 13);


      DISPOSE(P2);
      Figlio^ := P1^;
      DISPOSE(P1);
      CLEARSCREEN;
      DrawBorder;
      ReDraw(Rete, X0Init, Y0Init);
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


  PROCEDURE MoveLabel(VAR X, Y : REAL; VAR Lab : st40);
    VAR ch : CHAR;
    BEGIN
      DrawTextW(X, Y, 1, Lab);
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
                  CopyScreen;
                END;
        ELSE
        END;

        IF ORD(ch) <> 13 THEN
          BEGIN
            SwapScreen;
            CopyScreen;
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
                  STR(D, Descr);
                  Descr := 'd '+Descr;
                END;
              MoveLabel(X0, Y0, Descr);

              WITH Quote[IndScritte] DO
                BEGIN
                  X := X0;
                  Y := Y0;
                  DeLab := Descr;
                END;
              IndScritte := IndScritte+1;

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

          RuotaSchemaXZ((360-AngXZ) MOD 360, Rete, 0, 0);
          RuotaSchemaYZ((360-AngYZ) MOD 360, Rete, 0, 0);
          RuotaSchemaXY((360-AngXY) MOD 360, Rete, 0, 0);

          SelectWindow(2);
          Campo := 1;
          UsaMaskera(SEG(Prosp), OFS(Prosp), DATA_DRIVE+'Angoli.msk', Campo, Chiave, bianco, verde, TRUE, FALSE, TRUE);
          SelectWindow(1);

          RuotaSchemaXY(AngXY, Rete, 0, 0);
          RuotaSchemaYZ(AngYZ, Rete, 0, 0);
          RuotaSchemaXZ(AngXZ, Rete, 0, 0);


          CLEARSCREEN;
          DrawBorder;
          ReDraw(Rete, X0Init, Y0Init);
          FlagUscita := TRUE;
          Rientro := TRUE;
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
      ASSIGN(g, DATA_DRIVE+Prog+'.3DG');
      ASSIGN(f, DATA_DRIVE+Prog+'.3DH');
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

      ASSIGN(g, DATA_DRIVE+Prog+'.3DG');
      ASSIGN(f, DATA_DRIVE+Prog+'.3DH');
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
          'Y' : CorreggiPezzo(Padre, Ind, Dir, X0, Y0);
          '[' : HardCopy(FALSE, 1);
          '\' : BEGIN
                  HardCopy(FALSE, 1);
                  WRITE(LST, #12);
                END;
          ']' : BEGIN
                  LeaveGraphic;
                  HALT;
                END;
          #27 : FlagUscita := TRUE;
        ELSE
        END;
        EraseMask;
      UNTIL Scelta = ';';
    END;

  BEGIN
    TEXTCOLOR(rosso);
    DATA_DRIVE := 'C:\Daticca\';

    Duct := 3;
    ControlloChiave (CtrlKey,Duct);

    X0Init := 0; Y0Init := 20;

    XMin := 0; XMax := 40;
    YMin := 0; YMax := 40;

    LXMin := 0; LXMax := 40;
    LYMin := 0; LYMax := 40;

    WITH Prosp DO
      BEGIN
        AngXY := 0; AngXZ := 0; AngYZ := 90;
      END;

    Rete := NIL;

    InitGraphic;

    DefineWorld(2, XMin, YMin, XMax, YMax);

    DefineWindowIBM(1, 19, 0, 79, 199);

    DefineWindowIBM(2, 0, 0, 19, 199);
    SelectWindow(1);
    DrawBorder;

    CarTrig(Sine, Cosine);

    Prog := '';
    LoadAlbero;
    InitScritte(Etic);
    InitScritte(PORT);
    InitScritte(Quote);

    DefineWorld(2, LXMin, LYMin, LXMax, LYMax);

    SelectWorld(2);
    SelectWindow(1);


    ReDraw(Rete, X0Init, Y0Init);

    REPEAT
      FlagUscita := FALSE;
      Rientro := FALSE;
      Percorri(NIL, Rete, 1, X0Init, Y0Init);
    UNTIL NOT Rientro;

    SaveAlbero(Rete);
    LeaveGraphic;
  END.
