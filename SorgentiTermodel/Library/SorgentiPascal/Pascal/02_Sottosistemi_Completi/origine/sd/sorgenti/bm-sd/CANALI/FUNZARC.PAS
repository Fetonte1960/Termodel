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

    END;                      { func.  find_archivio }

    {-----------------------------  init_archivio  -------------------------------}
  PROCEDURE INIT_ARCHIVIO;
    VAR
      I, IOERR : INTEGER;
      U : TEXT;
    BEGIN
      FOR I := 1 TO NPezzi DO
        WITH ARCHIVIO[I] DO
          BEGIN
            CodPezzo := '';
            Descr := '';
            CodDis := 0;
            Main := '';
            Branch := '';
            Fonte := '';
            Varie := '';
            TipoSez := ' ';
            NUscite := 1;
          END;                { with archivio[i] do....... }

    END;                      { proc. init_archivio }

    {---------------------------  transfer_archivio  -----------------------------}
  FUNCTION TRANSFER_ARCHIVIO : INTEGER;
      { Serve per caricare la tabella 'ARCHIVIO.CAN' con le descrizioni relative ai
      codici dei pezzi }
    VAR
      FL : FILE OF RigaArch;
      IOERR, N : INTEGER;
    BEGIN
      ASSIGN(FL, DATA_DRIVE+'ARCHIVIO.CAN');
      {$I-} RESET(FL);        {$I+}
      IOERR := IORESULT;
      N := 1;
      WHILE (N <= NPezzi) AND (IOERR = 0) AND NOT(EOF(FL)) DO
        BEGIN
          {$I-} READ(FL, ARCHIVIO[N]) {$I+} ;
          IOERR := IORESULT;
          N := N+1;
        END;
      TRANSFER_ARCHIVIO := IOERR;
      CLOSE(FL);
    END;                      { proc. transfer_archivio }

