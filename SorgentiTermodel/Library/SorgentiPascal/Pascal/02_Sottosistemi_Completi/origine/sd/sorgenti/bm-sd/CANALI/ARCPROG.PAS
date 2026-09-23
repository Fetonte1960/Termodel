PROGRAM Archivio;
    {$R+}
    {$I deftype.new}
    {$I general.new}

  CONST LTabRamo = 16;
    Data_Drive = 'c:\DATICCA\';

  TYPE
    DatiProg1 = RECORD
                  Cliente, Localita        : ST40;
                  Progettista              : STRING[20];
                  Impianto                 : st40;
                  NOrdine                  : STRING[20];
                  Disegno                  : STRING[8];
                  Riferimento              : STRING[40];
                  Edificio, Sistema, Zona  : ST40;
                  Circuito                 : st40;
                  AltSulMare, Altezza      : INTEGER;
                  TempAria, UmRel          : REAL;
                END;

    DatiProg2 = RECORD
                  Visc, Dens                            : REAL;
                  RivestInt                             : STRING[20];
                  SpessRivest, Rugosita                 : REAL;
                  TipoSezione                           : STRING[20];
                  Rapp, DimW, DimH, DPuMTronco, MinTronco, MaxTronco, VelTronco : REAL;
                  DPuMRami, MinRami, MaxRami, VelRami   : REAL;
                  SbilDPu, SerrTermMax, SerrDPuMin      : REAL;
                  VCostante                             : REAL;
                END;

    RigaRamo = RECORD
                 CodPezzo         : STRING[5];
                 Descr            : STRING[40];
                 CHFlag           : CHAR;
                 Portata, Perdita : REAL;
                 A_D              : INTEGER;
                 H, W, Ang, Phi   : INTEGER;
                 L, R, ComVal     : REAL;
                 C0, X, Y         : REAL; { 104 }
               END;

    ST18 = STRING[18];

    LINK = ^TabRamo;
    TabRamo = RECORD
                T          : ARRAY[0..LTabRamo] OF RigaRamo;
                Ps, Pd, Pc : LINK;
                TR         : BOOLEAN;
                CodTab     : INTEGER;
              END;
  VAR
    NProg  : st18;
    g      : TEXT;
    pulito : st8;
    start  : INTEGER;
    P0     : link;
    DPR1   : DatiProg1;
    maskmc : st18;
    DPR2   : DatiProg2;
    Riga   : INTEGER;
    miscor : INTEGER;
    f99    : FILE OF INTEGER;
    pippo  : INTEGER;

  PROCEDURE StruttCorr(NProg : ST18; Struttura : st8);

    BEGIN
      IF exist(data_drive+nprog+'.msc') THEN
        BEGIN
          ASSIGN(f99, data_drive+nprog+'.msc');
          RESET(f99);
          READ(f99, miscor);
          CLOSE(f99);
        END;
      WINDOW(1, 2, 80, 25);
      GOTOXY(1, 1); CLREOL;
      TEXTBACKGROUND(nero); TEXTCOLOR(bianco);
      GOTOXY(1, 1);
      WRITE(' Progetto : ', NProg, '    ');
      IF (miscor = 1) THEN
        BEGIN
          WRITE('                  Portate in : mc/sec ');
          maskmc := 'mc/s ';
        END
      ELSE
        BEGIN
          IF miscor = 3600 THEN
            BEGIN
              WRITE('                  Portate in : mc/h ');
              maskmc := 'mc/h ';
            END;
        END;
      IF Struttura > '' THEN WRITE(' - ', 'Struttura corrente : ', Struttura);
      TEXTBACKGROUND(nero);
      WINDOW(1, 3, 80, 25);
    END;


    {-----------------------------  loadprog --------------------------------}
  PROCEDURE LoadProg(NomeFile : ST18);
    VAR
      Fl  : FILE OF TabRamo;
      fd1 : FILE OF DatiProg1;
      fd2 : FILE OF DatiProg2;
      IOERR, Campo, Chiave : INTEGER;
      {------------------------------    transfer    -------------------------------}
    PROCEDURE TRANSFER(VAR IND : LINK);
      BEGIN

        IF ((NOT(IND = NIL)) AND (IOERR = 0)) OR (P0 = NIL) THEN
          BEGIN
            NEW(IND);
            IF P0 = NIL THEN P0 := IND;
            {$I-} READ(Fl, IND^) {$I+} ;
            IOERR := IORESULT;
            TRANSFER(IND^.Pc);
            TRANSFER(IND^.Ps);
            TRANSFER(IND^.Pd);
          END;
      END;                    { proc. transfer }

      {--------------  main of loadprog  -------------}
    BEGIN
      ASSIGN(Fl, DATA_DRIVE+NomeFile+'.CAN');
      {$I-} RESET(Fl) {$I+} ;

      IOERR := IORESULT;

      IF IOERR <> 0 THEN EXIT;

      P0 := NIL;
      TRANSFER(P0);

      CLOSE(Fl);

      ASSIGN(Fd1, DATA_DRIVE+NomeFile+'.GN1');
      {$I-} RESET(Fd1) {$I+} ;

      IF IORESULT = 0 THEN READ(fd1, DPr1);

      CLOSE(fd1);

      ASSIGN(Fd2, DATA_DRIVE+NomeFile+'.GN2');
      {$I-} RESET(Fd2) {$I+} ;

      IF IORESULT = 0 THEN READ(fd2, DPr2);

      CLOSE(fd2);

    END;                      { proc.  loadprog }

    {-----------------------------  saveprog ---------------------------------}
  PROCEDURE SaveProg(NomeFile : ST18);
    VAR
      Fl : FILE OF TabRamo;
      fd1 : FILE OF DatiProg1;
      fd2 : FILE OF DatiProg2;
      IOERR, Campo, Chiave : INTEGER;
      {------------------------------    transfer    -------------------------------}
    PROCEDURE TRANSFER(IND : LINK);
      BEGIN
        IF (NOT(IND = NIL)) AND (IOERR = 0) THEN
          BEGIN
            {$I-} WRITE(Fl, IND^) {$I+} ;
            IOERR := IORESULT;
            TRANSFER(IND^.Pc);
            TRANSFER(IND^.Ps);
            TRANSFER(IND^.Pd);
          END;
      END;                    { proc. transfer }

      {--------------  main of saveprog  -------------}
    BEGIN
      ASSIGN(Fl, DATA_DRIVE+NomeFile+'.CAN');
      {$I-} REWRITE(Fl) {$I+} ;
      IOERR := IORESULT;
      TRANSFER(P0);
      CLOSE(Fl);

      ASSIGN(Fd1, DATA_DRIVE+NomeFile+'.GN1');
      REWRITE(Fd1);
      WRITE(fd1, DPr1);
      CLOSE(fd1);

      ASSIGN(Fd2, DATA_DRIVE+NomeFile+'.GN2');
      REWRITE(Fd2);
      WRITE(fd2, DPr2);
      CLOSE(fd2);
    END;                      { proc.  saveprog }

    {-----------------------------  saveprogsua ---------------------------------}
  PROCEDURE SaveProgsua(NomeFile : ST18);
    CONST dd = 'a:';
    VAR
      Fl : FILE OF TabRamo;
      fd1 : FILE OF DatiProg1;
      fd2 : FILE OF DatiProg2;
      IOERR, Campo, Chiave : INTEGER;
      {------------------------------    transfer    -------------------------------}
    PROCEDURE TRANSFERsua(IND : LINK);
      BEGIN
        IF (NOT(IND = NIL)) AND (IOERR = 0) THEN
          BEGIN
            {$I-} WRITE(Fl, IND^) {$I+} ;
            IOERR := IORESULT;
            TRANSFERsua(IND^.Pc);
            TRANSFERsua(IND^.Ps);
            TRANSFERsua(IND^.Pd);
          END;
      END;                    { proc. transfer }

      {--------------  main of saveprog  -------------}
    BEGIN
      GOTOXY(1, 22); WRITE('Copia file ', dd+NomeFile+'.CAN'); CLREOL;
      ASSIGN(Fl, dd+NomeFile+'.CAN');
      {$I-} REWRITE(Fl) {$I+} ;
      IOERR := IORESULT;
      TRANSFERsua(P0);
      CLOSE(Fl);

      GOTOXY(1, 22); WRITE('Copia file ', dd+NomeFile+'.GN1'); CLREOL;
      ASSIGN(Fd1, dd+NomeFile+'.GN1');
      REWRITE(Fd1);
      WRITE(fd1, DPr1);
      CLOSE(fd1);

      GOTOXY(1, 22); WRITE('Copia file ', dd+NomeFile+'.GN2'); CLREOL;
      ASSIGN(Fd2, dd+NomeFile+'.GN2');
      REWRITE(Fd2);
      WRITE(fd2, DPr2);
      CLOSE(fd2);
      GOTOXY(1, 22); CLREOL;
    END;                      { proc.  saveprog }


  PROCEDURE ArchProgetti(VAR NProg : st18; VAR Riga : INTEGER);
    CONST NProgetti = 100;
      NomeArch = 'c:\DATICCA\canali.prg';
    TYPE RecProg = RECORD
                     Descr : STRING[50];
                     Nome : STRING[18];
                   END;
      Archivio = ARRAY[1..NProgetti] OF RecProg;
    VAR i, Chiave, Campo : INTEGER;
      VProg : Archivio;
      f : FILE OF Archivio;
      InitMask : BOOLEAN;

      {------------------------iotabella1------------------------------------}
    PROCEDURE IOTabella1(ISeg, IOfs, NDat, DatP, DatR : INTEGER; VAR Chiave, Riga : INTEGER;
                         mask : st80; SetNRighe, InitMask, IWVal : BOOLEAN);
        {... ISeg & IOfs contengono il SEG e l'OFS della tabella
        ... NDat Š il numero totale di righe
        ... DatP Š il numero di righe per pagina
        ... DatR Š il numero di elementi per riga
        ... Riga contiene il N. della riga da cui si Š usciti
        ... IWVal e' true se si fa riferimento all'ultima tabella usata :
        in tal caso si puo' specificare con riga la riga di accesso alla tabella
        ... SetNRighe = true se si vogliono numerare  le righe della tabella
        in tal caso occorre che il primo campo della tabella
        venga introdotto in riga 8.
        }

      VAR ROfs, DOfs, i, j, k, campo, Lin, NPag, Limite : INTEGER;
        ExRet : BOOLEAN;
        PPrec, PSucc : ^char;


      BEGIN                   {maskera}
        IF IWVal THEN
          BEGIN
            CarAddress(ISeg, IOfs);
            IF Riga > 0 THEN
              BEGIN
                Campo := DatR*((Riga-1) MOD DatP)+1;

                NPag := (Riga DIV DatP)+1;
                IF Riga MOD DatP = 0 THEN NPag := NPag-1;

                i := (NPag-1)*DatP+1;

                DOfs := SpaceTab(IOfs);
                ROFs := DOfs DIV DatP; {..spazio occupato da una riga..}
                IOfs := IOfs+(NPag-1)*DOfs;

              END
          END
        ELSE
          BEGIN
            i := 1;
            Campo := 1;
          END;

        Riga := 0;

        REPEAT
          IF SetNRighe THEN
            BEGIN
              TEXTCOLOR(grigioligth);
              FOR j := i TO DatP+i-1 DO
                BEGIN
                  GOTOXY(2, j-i+6);
                  WRITE(j:3);
                END;
              TEXTCOLOR(bianco);
            END;

          UsaMaskera(ISeg, IOfs, mask, Campo, Chiave, grigioligth, bianco, InitMask, IWVal, TRUE, TRUE);
          IF InitMask THEN
            BEGIN
              DOfs := SpaceTab(IOfs);
              ROFs := DOfs DIV DatP; {..spazio occupato da una riga..}
            END;
          InitMask := FALSE;
          IWVal := FALSE;
          CASE Chiave OF
            63 : ;            {..cancellazione linea..}
            64 : ;            {..inserzione linea..}
            13 : IF campo < DatP*DatR THEN campo := campo+1;
            27, 59..63, 65..68:;
            77 :
              IF campo < DatP*DatR THEN campo := campo+1;
            75 :
              IF campo > 1 THEN campo := campo-1;
            80 :              {..freccia in giu'..}
              IF campo <= (DatP-1)*DatR THEN campo := campo+DatR;
            72 :              {..freccia in su'...}
              IF campo > DatR THEN campo := campo-DatR;
            81 :
              IF i < NDat-DatP THEN
                BEGIN
                  i := i+DatP;
                  IOfs := IOfs+DOfs;
                  IWVal := TRUE;
                END
              ELSE WRITE(CHR(7));
            73 :
              IF i > 1 THEN
                BEGIN
                  i := i-DatP;
                  IOfs := IOfs-DOfs;
                  IWVal := TRUE;
                END
              ELSE WRITE(CHR(7));
          END;                { case }
        UNTIL (chiave IN [27, 59..63]);
        Riga := i+(Campo DIV DatR);
        IF Campo MOD DatR = 0 THEN Riga := Riga-1;
      END;                    {maskera}


    PROCEDURE EliminaFile(Nome : st80);
      VAR u : FILE;
      BEGIN
        IF Exist(Nome) THEN
          BEGIN
            GOTOXY(1, 22); WRITE('Cancellazione file ', Nome); CLREOL;
            ASSIGN(u, Nome);
            ERASE(u);
          END;
      END;


    PROCEDURE EraseProg(Nome : st18);
      BEGIN
        IF Exist(Data_Drive+Nome+'.GN1') THEN EliminaFile(Data_Drive+Nome+'.GN1');
        IF Exist(Data_Drive+Nome+'.GN2') THEN EliminaFile(Data_Drive+Nome+'.GN2');
        IF Exist(Data_Drive+Nome+'.CAN') THEN EliminaFile(Data_Drive+Nome+'.CAN');
        IF Exist(Data_Drive+Nome+'.sch') THEN EliminaFile(Data_Drive+Nome+'.SCH');
        IF Exist(Data_Drive+Nome+'.scg') THEN EliminaFile(Data_Drive+Nome+'.SCG');
        IF Exist(Data_Drive+Nome+'.trl') THEN EliminaFile(Data_Drive+Nome+'.trl');
        IF Exist(Data_Drive+Nome+'.crl') THEN EliminaFile(Data_Drive+Nome+'.crl');
        IF Exist(Data_Drive+Nome+'.3dh') THEN EliminaFile(Data_Drive+Nome+'.3DH');
        IF Exist(Data_Drive+Nome+'.ls1') THEN EliminaFile(Data_Drive+Nome+'.ls1');
        IF Exist(Data_Drive+Nome+'.lst') THEN EliminaFile(Data_Drive+Nome+'.lst');
        IF Exist(Data_Drive+Nome+'.3dg') THEN EliminaFile(Data_Drive+Nome+'.3DG');
        IF Exist(Data_Drive+Nome+'.rnf') THEN EliminaFile(Data_Drive+Nome+'.rnf');
        IF Exist(Data_Drive+Nome+'.sps') THEN EliminaFile(Data_Drive+Nome+'.sps');
        IF Exist(Data_Drive+Nome+'.bul') THEN EliminaFile(Data_Drive+Nome+'.bul');
        IF Exist(Data_Drive+Nome+'.msc') THEN EliminaFile(Data_Drive+Nome+'.msc');
        GOTOXY(1, 22); CLREOL;
      END;



    PROCEDURE LoadArch;
      VAR i : INTEGER;
      BEGIN
        IF Exist(NomeArch) THEN
          BEGIN
            ASSIGN(f, NomeArch);
            RESET(f);
            READ(f, VProg);
            CLOSE(f);
          END
        ELSE
          BEGIN
            FOR i := 1 TO NProgetti DO
              WITH VProg[i] DO
                BEGIN
                  Descr := '';
                  Nome := '';
                END;
          END;
      END;

    PROCEDURE SaveArch;
      BEGIN
        ASSIGN(f, NomeArch);
        REWRITE(f);
        WRITE(f, VProg);
        CLOSE(f);
      END;


    FUNCTION Conferma(Titolo : st80; NProg : st18) : BOOLEAN;
      VAR ch : CHAR;
      BEGIN
        IF NProg = '' THEN Conferma := TRUE
        ELSE
          BEGIN
            WRITE(CHR(7));
            GOTOXY(1, 21);
            WRITELN(Titolo);
            WRITELN('Conferma ? (S/N) ');
            REPEAT
              READ(KBD, ch);
              IF NOT(UPCASE(ch) IN ['S', 'N']) THEN WRITE(CHR(7));
            UNTIL UPCASE(ch) IN ['S', 'N'];
            GOTOXY(1, 21); CLREOL;
            WRITELN; CLREOL;
            Conferma := (UPCASE(ch) = 'S');
          END;
      END;

    BEGIN
      CLRSCR;
      LoadArch;
      InitMask := TRUE;
      REPEAT
        IOTabella1(SEG(VProg), OFS(VProg), NProgetti, 10, 2, Chiave, Riga,
        Data_Drive+'Archprog.msk', TRUE, InitMask, NOT InitMask);
        InitMask := FALSE;
        CASE Chiave OF
          59 : WITH VProg[NProgetti] DO
                 IF (Nome = '') AND (Descr = '') THEN
                   BEGIN      {inserimento riga}
                     FOR i := NProgetti DOWNTO Riga+1 DO
                       VProg[i] := VProg[i-1];
                     WITH VProg[Riga] DO
                       BEGIN
                         Descr := '';
                         Nome := '';
                       END;
                   END
                 ELSE WRITE(CHR(7));
          60 : BEGIN
                 IF Conferma('A T T E N Z I O N E  !  I dati relativi al progetto saranno cancellati.',
                 VProg[Riga].Nome) THEN
                   BEGIN
                     EraseProg(VProg[Riga].Nome);
                     StruttCorr('', '');
                     FOR i := Riga TO NProgetti-1 DO
                       VProg[i] := VProg[i+1];
                     WITH VProg[NProgetti] DO
                       BEGIN
                         Descr := '';
                         Nome := '';
                       END;
                     NProg := '';
                   END;
               END;
          61 : BEGIN
                 NProg := VProg[Riga].Nome;
                 IF NProg > '' THEN
                   BEGIN
                     LoadProg(NProg);
                     StruttCorr(NProg, '');
                     {.. creazione del file .msc (unita' di misura corrente) ..}
                     IF (NOT exist(data_drive+nprog+'.msc')) THEN
                       BEGIN
                         ASSIGN(f99, data_drive+nprog+'.msc');
                         REWRITE(f99);
                         pippo := 1;
                         WRITE(f99, pippo);
                         CLOSE(f99);
                       END;
                   END
                 ELSE WRITE(CHR(7));
               END;
          62 : BEGIN
                 IF VProg[Riga].Nome > '' THEN
                   BEGIN
                     IF Exist(Data_Drive+VProg[Riga].Nome+'.GN1') THEN
                       BEGIN
                         IF Conferma('A T T E N Z I O N E  !  I vecchi dati del progetto saranno cancellati.',
                         VProg[Riga].Nome) THEN SaveProg(VProg[Riga].Nome);
                       END
                     ELSE SaveProg(VProg[Riga].Nome);
                   END
                 ELSE WRITE(CHR(7));
               END;
          63 : BEGIN          {.. salvataggio su a: ..}
                 IF VProg[Riga].Nome > '' THEN
                   BEGIN
                     {.. pulizia del nomefile ..}
                     start := POS('\', vprog[riga].nome);
                     pulito := COPY(vprog[riga].nome, start+1, 8);
                     saveprogsua(pulito);
                   END
                 ELSE WRITE(CHR(7));
               END;
        ELSE
        END;


      UNTIL Chiave = 27;
      SaveArch;
    END;

  BEGIN
    WINDOW(1, 3, 80, 25);
    CLRSCR;
    P0 := NIL; Riga := 1; NProg := '';
    IF Exist(Data_Drive+'prog.can') THEN
      BEGIN
        ASSIGN(g, Data_Drive+'prog.can');
        RESET(g);
        READLN(g, NProg); READLN(g, Riga);
        CLOSE(g);
      END;
    ArchProgetti(NProg, Riga);
    ASSIGN(g, Data_Drive+'prog.can');
    REWRITE(g);
    WRITELN(g, NProg); WRITELN(g, Riga);
    CLOSE(g);
  END.
