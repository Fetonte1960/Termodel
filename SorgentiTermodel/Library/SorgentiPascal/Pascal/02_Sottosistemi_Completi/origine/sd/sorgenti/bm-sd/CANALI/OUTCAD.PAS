PROGRAM outcad;
    {..traduce un file dati prodotto dal programma "SCHEMA" in un file di tipo
    TEXT interpretabile dal programma di calcolo "CANALI"...................}
  CONST
    Fill = '                                                                                ';
    NUsc = 3;
    NLinee = 3;
    NPezzi = 260;
  TYPE
    st5 = STRING[5];
    ST8 = STRING[8];
    st18 = STRING[18];
    st40 = STRING[40];
    st80 = STRING[80];
    st124 = STRING[124];
    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : ST40;
                 CodDis : INTEGER;
                 Main, Branch, Fonte : ST8;
                 Varie : STRING[10];
                 TipoSez : ST5;
                 NUscite : INTEGER;
               END;           { 95 }
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

  VAR ch : CHAR;
    C : Canale;
    X0Init, Y0Init : REAL;
    XMin, YMin, XMax, YMax : REAL;
    LXMin, LYMin, LXMax, LYMax : REAL;
    Rete : Pointer;
    Errore, NBranch : INTEGER;
    ARCHIVIO : ARRAY[1..NPezzi] OF RigaArch; { 4500 }
    DATA_DRIVE : STRING[40];
    NomeFile : st18;
    fpr : TEXT;

    {----------------------------  format_string  --------------------------------}
  FUNCTION FORMAT(ST : ST80; StLength : INTEGER) : ST80;
    BEGIN
      ST := COPY(ST, 1, StLength);
      FORMAT := ST+COPY(Fill, 1, StLength-LENGTH(ST));
    END;                      { func.  format }

    {$I funzarc}

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
          READLN(fp, NomeFile);
          CLOSE(fp);
        END;

      ASSIGN(g, DATA_DRIVE+NomeFile+'.SCG');
      ASSIGN(f, DATA_DRIVE+NomeFile+'.SCH');
      {$I-} RESET(f); RESET(g); {$I+}
      IF (IORESULT = 0) THEN
        BEGIN
          READ(g, X0Init, Y0Init, XMin, XMax, YMin, YMax, LXMin, LXMax, LYMin, LYMax);
          READ(g, RAngXY, RAngXZ, RAngYZ);
          NEW(Rete);
          IF NOT EOF(f) THEN Leggi(Rete);
          CLOSE(f);
        END;
    END;

  PROCEDURE Traduttore;
    VAR f, fc : TEXT;

    PROCEDURE ScriviControl(Phi : INTEGER; p1, p2, p3 : Pointer);
      VAR Riga : st124;
        Ns : STRING[4];
      BEGIN
        IF P1 = NIL THEN Riga := 'nil  '
        ELSE Riga := '***  ';
        IF P2 = NIL THEN Riga := Riga+'nil  '
        ELSE Riga := Riga+'***  ';
        IF P3 = NIL THEN Riga := Riga+'nil  '
        ELSE Riga := Riga+'***  ';
        STR(Phi:4, Ns);
        Riga := Riga+Ns;
        WRITELN(fc, Riga);
      END;


    PROCEDURE ScriviLinea(RifBr : st5; P : Pointer; x, y, z : REAL);
      CONST
        Spazio = '          ';
      VAR
        Riga : st124;
        D : STRING[10];
        i : INTEGER;
      BEGIN
        IF P = NIL THEN
          BEGIN
            WRITELN(f);
            EXIT;
          END;
        Riga := '';
        FOR i := 1 TO 10 DO Riga := Riga+Spazio;
        FOR i := 1 TO 5 DO P^.Cod[i] := UPCASE(P^.Cod[i]);

        INSERT(RifBr, Riga, 1);
        INSERT(P^.Cod, Riga, 10);
        STR(P^.D:4, D);
        INSERT(D, Riga, 20);
        STR(P^.A:4, D);
        INSERT(D, Riga, 28);
        STR(P^.B:4, D);
        INSERT(D, Riga, 36);
        STR(P^.Ang:4, D);
        INSERT(D, Riga, 44);
        STR(P^.Lungh*1000:8:0, D);
        INSERT(D, Riga, 52);
        STR(P^.Port:5:3, D);
        INSERT(D, Riga, 66);
        STR(P^.Perdita:5:3, D);
        INSERT(D, Riga, 76);
        IF ABS(x) < 0.001 THEN x := 0;
        STR(x*1000:10:1, D);
        INSERT(D, Riga, 86);
        IF ABS(y) < 0.001 THEN y := 0;
        STR(y*1000:10:1, D);
        INSERT(D, Riga, 98);
        IF ABS(z) < 0.001 THEN z := 0;
        STR(z*1000:10:1, D);
        INSERT(D, Riga, 110);
        WRITELN(f, Riga);
        ScriviControl(P^.Phi, P^.Pc, P^.Ps, P^.Pd);
      END;

    PROCEDURE ScriviTest(Padre, P : Pointer);
      CONST
        Spazio = '          ';
        Tr = '----------';
      VAR Tratt, Riga : STRING[124];
        D : STRING[10];
        i : INTEGER;
      BEGIN
        Riga := ''; Tratt := '';
        FOR i := 1 TO 13 DO
          BEGIN
            Riga := Riga+Spazio;
            Tratt := Tratt+Tr;
          END;
        FOR i := 1 TO 5 DO Padre^.Cod[i] := UPCASE(Padre^.Cod[i]);

        IF Padre = NIL THEN
          BEGIN
            WRITELN(f, Tratt);
            ScriviControl(0, NIL, NIL, NIL);
          END
        ELSE
          IF Padre^.Graph[1].Xp <> 0 THEN
            BEGIN
              STR(Padre^.Graph[1].Xp:3:0, D);
              WHILE D[1] = ' ' DO DELETE(D, 1, 1);

              INSERT('BR #'+D, Riga, 1);
              INSERT(':'+D, Riga, 15);
              INSERT(Padre^.Cod, Riga, 30);
              WRITELN(f);
              ScriviControl(0, NIL, NIL, NIL);
              WRITELN(f, Riga);
              ScriviControl(0, NIL, NIL, NIL);
              WRITELN(f, Tratt);
              ScriviControl(0, NIL, NIL, NIL);
            END;
      END;


    PROCEDURE Tratto(Dir : INTEGER; Padre, P : Pointer; x, y, z : REAL);
      VAR RifArch, Br : INTEGER;
        Codice, RifBr : st5;
      BEGIN
        IF P = NIL THEN EXIT;
        ScriviTest(Padre, P);
        REPEAT
          RifArch := FIND_ARCHIVIO(P^.Cod);
          IF RifArch > 0 THEN
            BEGIN
              IF (P^.Pc = NIL) AND (P^.Ps = NIL) AND (P^.Pd = NIL) THEN
                BEGIN
                  NBranch := NBranch+1;
                  Br := NBranch;
                  STR(Br:3, RifBr);
                  WHILE RifBr[1] = ' ' DO DELETE(RifBr, 1, 1);
                  RifBr := '('+RifBr+')';
                END
              ELSE
                BEGIN
                  IF ARCHIVIO[RifArch].NUscite > 1 THEN
                    BEGIN
                      NBranch := NBranch+1;
                      Br := NBranch;
                      STR(Br:3, RifBr);
                      WHILE RifBr[1] = ' ' DO DELETE(RifBr, 1, 1);
                      RifBr := ':'+RifBr;
                    END
                  ELSE
                    BEGIN
                      RifBr := '';
                      Br := 0;
                    END;
                END;
            END               {... if rifarch > 0 ...}
          ELSE
            BEGIN
              WRITE(CHR(7));
              HALT;
            END;


          P^.Graph[1].Xp := Br;
          ScriviLinea(RifBr, P, x, y, z);
          x := x+P^.Point[1].x1;
          y := y+P^.Point[1].y1;
          z := z+P^.Point[1].z1;
          P := P^.Pc;
        UNTIL P = NIL;

      END;


    PROCEDURE Visit(Dir : INTEGER; Padre, P : Pointer; x, y, z : REAL);
      VAR Br : INTEGER;
      BEGIN
        IF P <> NIL THEN
          BEGIN
            Tratto(Dir, Padre, P, x, y, z);

            REPEAT
              Visit(2, P, P^.Ps, x+P^.Point[2].x1, y+P^.Point[2].y1, z+P^.Point[2].z1);
              Visit(3, P, P^.Pd, x+P^.Point[3].x1, y+P^.Point[3].y1, z+P^.Point[3].z1);
              x := x+P^.Point[1].x1;
              y := y+P^.Point[1].y1;
              z := z+P^.Point[1].z1;
              P := P^.Pc;
            UNTIL P = NIL;
          END;
      END;


    BEGIN
      ASSIGN(f, DATA_DRIVE+NomeFile+'.TRL');
      REWRITE(f);
      ASSIGN(fc, DATA_DRIVE+NomeFile+'.CRL');
      REWRITE(fc);
      Visit(1, NIL, Rete, 0, 0, 0);
      CLOSE(f);
      CLOSE(fc);
    END;

  BEGIN
    DATA_DRIVE := 'C:\daticca\';
    Errore := Transfer_Archivio;
    NBranch := 0;
    LoadAlbero;
    Traduttore;
  END.
