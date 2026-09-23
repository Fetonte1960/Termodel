        {--------------------------------  printmask  --------------------------------}
      PROCEDURE PrintMask(NomeF : st80; Base, Offset : WORD; notzero : BOOLEAN);
          {     stampa su carta la medesima maschera utilizzata in input col video      }
        CONST
          x = 'ù';
        TYPE
          st240 = STRING[240];
          ST80 = STRING[80];
        VAR
          f : TEXT;
          ch : CHAR;
          variabile : ST240;
          Dato : ST80;
          I, J : INTEGER;
          flag : INTEGER;

          PInt : ^integer;
          PReal : ^real;
          PStr : ^ST240;

          Tipo : CHAR;
          L : INTEGER;
          BAddr, OAddr : WORD;
          CifreInt, CifreDec : INTEGER;
        BEGIN
          ASSIGN(f, NomeF);
          RESET(f);
          WHILE NOT(EOF(f)) DO
            BEGIN
              READ(f, ch);

              IF ch = x THEN
                BEGIN
                  WRITE(GLST, ' ');
                  READ(f, Tipo);
                  i := 1;
                  variabile := '';
                  REPEAT
                    READ(f, ch);
                    i := i+1;
                    IF ch IN ['0'..'9'] THEN variabile := variabile+ch;
                  UNTIL NOT(ch IN ['0'..'9']);


                  flag := 0;
                  VAL(variabile, L, flag);
                  IF (flag <> 0) OR (LENGTH(variabile) = 0) THEN L := 0;

                  IF ch = ':' THEN
                    BEGIN
                      variabile := '';
                      REPEAT
                        READ(f, ch);
                        i := i+1;
                        IF ch IN ['0'..'9'] THEN variabile := variabile+ch;
                      UNTIL NOT(ch IN ['0'..'9']);
                      flag := 0;
                      VAL(variabile, CifreDec, flag);
                      IF (flag <> 0) OR (LENGTH(variabile) = 0) THEN CifreDec := 0;
                    END;

                  BAddr := Base; OAddr := OffSet;
                  CASE Tipo OF
                    'I' : BEGIN
                            CifreInt := L;
                            OffSet := OffSet+2;

                            PInt := PTR(BAddr, OAddr);
                            IF notzero AND (PInt^ = 0) THEN Dato := '  '
                            ELSE
                              BEGIN
                                STR(PInt^:L, Dato);
                                Dato := setleft(Dato);
                              END;
                          END;
                    'R' : BEGIN
                            IF L > 0 THEN L := L+1;
                            OffSet := OffSet+6;
                            CifreInt := L;

                            PReal := PTR(BAddr, OAddr);
                            IF notzero AND (PReal^ = 0) THEN Dato := '  '
                            ELSE
                              BEGIN
                                STR(PReal^:L:CifreDec, Dato);
                                Dato := setleft(Dato);
                              END;
                          END;
                    '$' : BEGIN
                            OffSet := OffSet+L+1;

                            PStr := PTR(BAddr, OAddr);
                            Dato := PStr^; Dato := setleft(dato);
                          END;
                  ELSE
                  END;
                  WRITE(GLST, format(Dato, L));
                  I := L-i;
                  WHILE NOT EOF(F) AND (I > 0) DO
                    BEGIN
                      READ(f, ch);
                      i := i-1;
                    END;
                END           { if ch = #157 then..........scrivi valore }
              ELSE WRITE(GLST, ch);
            END;

          CLOSE(f);
        END;
