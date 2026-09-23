PROGRAM traslate;
    {.. decodifica un grafico nella corrispondente sequenza di tabelle
    interpretabile dal programma di calcolo                         ..}

    {$I deftype.uti  }

  FUNCTION Elev(a, x : REAL) : REAL;
      { a = base ; x = esponente }
    BEGIN
      IF a > 0 THEN Elev := EXP(x*LN(a)) ELSE Elev := 0;
    END;



  PROCEDURE StruttCorr(NProg : st18; Struttura : st8);
    BEGIN
      WINDOW(1, 2, 80, 25);
      GOTOXY(1, 1); CLREOL;
      TEXTBACKGROUND(nero); TEXTCOLOR(bianco);
      GOTOXY(1, 1);
      WRITE(' Progetto N. ', NProg);
      IF Struttura > '' THEN WRITE(' - ', 'Struttura corrente : ', Struttura);
      TEXTBACKGROUND(nero);
      WINDOW(1, 3, 80, 25);
    END;



  PROCEDURE testata(Fondo, Testo : INTEGER; titolo : st80);
    BEGIN
      WINDOW(1, 1, 80, 2);
      TEXTBACKGROUND(Fondo);
      GOTOXY(1, 1); CLREOL;
      TEXTCOLOR(Testo);
      GOTOXY(1, 1);
      GOTOXY(1, 1); WRITELN(Titolo);
      TEXTBACKGROUND(nero);
      WINDOW(1, 3, 80, 25);
    END;


  CONST
    Nlinee = 3;
    NUsc = 3;
    LTratto = 16;
    NPezzi = 260;
  TYPE
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


    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : ST40;
                 CodDis : INTEGER;
                 Main, Branch, Fonte : ST8;
                 Varie : STRING[10];
                 TipoSez : ST5;
                 NUscite : INTEGER;
               END;           { 95 }

    RigaRamo = RECORD
                 CodPezzo : STRING[5];
                 Descr : STRING[40];
                 CHFlag : CHAR;
                 Portata, Perdita : REAL;
                 A_D : INTEGER;
                 H, W, Ang, Phi : INTEGER;
                 L, R, ComVal : REAL;
                 C0, X, Y : REAL; { 104 }
               END;

    LINK = ^TabRamo;
    TabRamo = RECORD
                T : ARRAY[0..LTratto] OF RigaRamo;
                Ps, Pd, Pc : LINK;
                TR : BOOLEAN;
                NTab : INTEGER;
              END;

  VAR
    Ramo : link;
    f, fc : TEXT;
    j, Nl, IndiceTab : INTEGER;
    ch : CHAR;
    ARCHIVIO : ARRAY[1..NPezzi] OF RigaArch; { 4500 }
    DATA_DRIVE : st40;
    NomeFile : st18;
    Riga : st80;
    Fpr : TEXT;

  PROCEDURE INITRIGA(VAR A : RIGARAMO);
    BEGIN
      WITH A DO
        BEGIN
          CODPEZZO := '';
          DESCR := '';
          CHFLAG := ' ';
          A_D := 0;
          H := 0; W := 0;
          L := 0; ANG := 0;
          PORTATA := 0;
          R := 0; COMVAL := 0;
          C0 := 0; PERDITA := 0;
          X := 0; Y := 0;
          PHI := 0;
        END;
    END;


  PROCEDURE INITTAB(IND : LINK);
    VAR I : INTEGER;
    BEGIN
      FOR I := 0 TO LTRATTO DO
        INITRIGA(IND^.T[I]);

      WITH IND^ DO
        BEGIN
          NTAB := IndiceTab; IndiceTab := IndiceTab+1;
          PC := NIL; PS := NIL; PD := NIL;
        END;
    END;


  PROCEDURE CREATAB(VAR IND : LINK);
    BEGIN
      NEW(IND);
      INITTAB(IND);
    END;



    {$I funzarc  }

  PROCEDURE LoadGrafico;
    VAR f : FILE OF Canale;
      g : FILE OF REAL;
      h : FILE OF TabRamo;
      RAngXY, RAngXZ, RAngYZ : REAL;
      X0Init, Y0Init, XMin, XMax, YMin, YMax, LXMin, LXMax, LYMin, LYMax : REAL;
      IndTab : INTEGER;
      fp : TEXT;

    PROCEDURE CambioTabella(Dato : Canale);
      VAR Rif, i : INTEGER;
      BEGIN
        WITH Dato DO
          BEGIN
            Rif := Find_Archivio(Cod);
            IF (Archivio[Rif].NUscite <> 1) OR
            ((Pc = NIL) AND (Ps = NIL) AND (Pd = NIL)) OR
            (IndTab > LTratto-1) THEN
              BEGIN
                IF Pc <> NIL THEN Ramo^.Pc := PTR(SEG(Pc), OFS(Pc))
                ELSE Ramo^.Pc := NIL;

                IF Ps <> NIL THEN Ramo^.Ps := PTR(SEG(Ps), OFS(Ps))
                ELSE Ramo^.Ps := NIL;

                IF Pd <> NIL THEN Ramo^.Pd := PTR(SEG(Pd), OFS(Pd))
                ELSE Ramo^.Pd := NIL;

                WRITE(h, Ramo^);

                DISPOSE(Ramo);
                IndTab := 1;
                CreaTab(Ramo);
              END;
          END;
      END;


    PROCEDURE CaricaTab(Dato : Canale);
      VAR Rif : INTEGER;
        RPot : REAL;
      BEGIN
        Rif := Find_Archivio(Dato.Cod);
        WITH Ramo^.T[IndTab] DO
          BEGIN
            CodPezzo := Dato.Cod;
            IF Rif > 0 THEN Descr := Archivio[Rif].Descr
            ELSE Descr := '';
            IF Dato.CHFlag > '' THEN CHFLAG := Dato.CHFlag[1]
            ELSE CHFlag := ' ';
            A_D := Dato.D;
            H := Dato.B; W := Dato.A;
            IF (H <> 0) AND (W <> 0) THEN
              BEGIN
                RPot := 1.3*Elev(1.0*H*W, 0.625)/Elev(H+W, 0.25);
                A_D := TRUNC(RPot) { calcola diametro eqivalente } ;
              END;
            L := Dato.Lungh; ANG := Dato.Ang;
            PORTATA := Dato.Port;
            R := Dato.R;
            COMVAL := Dato.Varie;
            PERDITA := Dato.Perdita;
            Phi := Dato.Phi;
          END;

        IndTab := IndTab+1;
        CambioTabella(Dato);
      END;


    PROCEDURE Leggi;
      VAR P : Pointer;
      BEGIN
        NEW(P);
        READ(f, P^);
        CaricaTab(P^);
        IF P^.Pc <> NIL THEN Leggi;
        IF P^.Ps <> NIL THEN Leggi;
        IF P^.Pd <> NIL THEN Leggi;
        DISPOSE(p);
      END;


    BEGIN
      TEXTCOLOR(bianco); CLRSCR;
      ASSIGN(g, DATA_DRIVE+NomeFile+'.SCG');
      ASSIGN(f, DATA_DRIVE+NomeFile+'.SCH');
      {$I-} RESET(f); RESET(g); {$I+}
      IF (IORESULT = 0) THEN
        BEGIN
          READ(g, X0Init, Y0Init, XMin, XMax, YMin, YMax, LXMin, LXMax, LYMin, LYMax);
          READ(g, RAngXY, RAngXZ, RAngYZ);
          CLOSE(g);
          ASSIGN(h, DATA_DRIVE+NomeFile+'.CAN');
          REWRITE(h);
          CreaTab(Ramo); IndTab := 1;
          IF NOT EOF(f) THEN Leggi;
          CLOSE(h);
          CLOSE(f);
        END;
    END;


  BEGIN
    DATA_DRIVE := 'C:\daticca\';

    ASSIGN(FPr, DATA_DRIVE+'TESTATA.INT');
    RESET(FPr);
    READ(FPr, RIGA);
    CLOSE(FPr);

    CLRSCR;
    TESTATA(GRIGIOLIGTH, NERO, RIGA);
    TEXTCOLOR(BIANCO);


    ASSIGN(fpr, DATA_DRIVE+'prog.can');
    {$I-} RESET(fpr);         {$I+}
    IF IORESULT = 0 THEN
      BEGIN
        READLN(fpr, NomeFile);
        CLOSE(fpr);
      END
    ELSE HALT;
    StruttCorr(NomeFile, '');

    IndiceTab := 1;
    j := Transfer_Archivio;
    LoadGrafico;
  END.
