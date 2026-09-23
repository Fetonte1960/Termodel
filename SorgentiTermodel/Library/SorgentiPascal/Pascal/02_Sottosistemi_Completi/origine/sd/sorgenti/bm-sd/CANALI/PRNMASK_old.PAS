      CONST
        NTit = 8;
        MaxCampi = 20;
      TYPE
        ST136 = STRING[150];
        st240 = STRING[240];
        Rec = RECORD
                Tipo : CHAR;
                X : INTEGER;
                OAddr : INTEGER;
                CifreInt, CifreDec : INTEGER;
              END;
        TabellaRec = ARRAY[1..MaxCampi] OF Rec;
      VAR
        TitSt : ARRAY[1..NTit] OF ST136;
        LenTitolo : INTEGER;

        Tabella : TabellaRec;
        UltimoCampo : INTEGER;

        {----------------------------------  leggimask  ------------------------------}
      PROCEDURE LeggiMask(NomeF : string);
        CONST
          chx = 'ù';
        VAR
          f : TEXT;
          ch : CHAR;
          variabile : ST240;
          ComST : STRING[30];
          K, I, J, Cx : INTEGER;
          flag : INTEGER;
          FEND : BOOLEAN;
          Offset : INTEGER;

          {----------------  inittabella  -----------------}
        PROCEDURE InitTabella;
          VAR
            i : INTEGER;
          BEGIN
            FOR i := 1 TO MaxCampi DO
              WITH Tabella[i] DO
                BEGIN
                  Tipo := 'n';
                  X := 0;
                  OAddr := 0;
                  CifreInt := 0; CifreDec := 0;
                END;
          END;                { proc.  inittabella }


          {--------------------------  main of leggimask  --------------------------}
        BEGIN
          InitTabella;
          SETTADRIVEPRN(NOMEF);
          ASSIGN(f, NomeF);
          RESET(f);

          K := 0;
          WHILE (NOT EOF(F)) AND (K < NTit) DO
            BEGIN

              READLN(f, Variabile);
              IF POS(chx, Variabile) = 0 THEN
                BEGIN
                  K := K+1;
                  TitST[K] := Variabile;
                END
              ELSE
                BEGIN
                  Offset := 0;
                  I := 0;
                  REPEAT
                    Cx := POS(chx, Variabile);
                    IF Cx > 0 THEN
                      BEGIN
                        I := I+1;
                        WITH Tabella[I] DO
                          BEGIN
                            Variabile[Cx] := ' '; { cancella alt-157 }
                            Cx := Cx+1;
                            Tipo := UPCASE(Variabile[Cx]);
                            Variabile[Cx] := ' '; { cancella tipo $,i o r }
                            x := Cx;

                            ComST := '';
                            REPEAT
                              Cx := Cx+1;
                              ch := Variabile[Cx];
                              IF ch IN ['0'..'9'] THEN
                                BEGIN
                                  ComST := ComST+ch;
                                  Variabile[Cx] := ' ';
                                END;
                            UNTIL NOT(ch IN ['0'..'9']);

                            flag := 0;
                            VAL(ComST, CifreInt, flag);
                            IF (flag <> 0) OR (LENGTH(ComST) = 0) THEN CifreInt := 1;


                            IF ch = ':' THEN
                              BEGIN
                                Variabile[Cx] := ' ';
                                ComST := '';
                                REPEAT
                                  Cx := Cx+1;
                                  ch := Variabile[Cx];
                                  IF ch IN ['0'..'9'] THEN
                                    BEGIN
                                      Variabile[Cx] := ' ';
                                      ComST := ComST+ch;
                                    END;
                                UNTIL NOT(ch IN ['0'..'9']);
                                flag := 0;
                                VAL(ComST, CifreDec, flag);
                                IF (flag <> 0) OR (LENGTH(variabile) = 0) THEN CifreDec := 0;
                              END;

                            Oaddr := OffSet;
                            CASE Tipo OF
                              'I' : OffSet := OffSet+2;
                              'R' : OffSet := OffSet+6;
                              '$' : OffSet := OffSet+CifreInt+1;
                            ELSE
                            END;
                            UltimoCampo := I;
                          END; { with tabella[i].......... }
                      END;    { if cx > 0 then............}
                  UNTIL Cx = 0;
                  TitSt[NTit] := Variabile;
                END;          { if not fend then............ }
            END;              { while end }
          LenTitolo := K;
          CLOSE(f);
        END;                  { proc. leggimask }

        {-------------------------------  writecampi  --------------------------------}
      PROCEDURE WriteCampi(Rseg, Rofs : WORD);
        VAR
          I, K, L : INTEGER;
          Dato : ST80;
          PrintST : ST136;
          PInt : ^integer;
          PStr : ^st240;
          PReal : ^real;
        BEGIN

          PrintST := TitSt[NTit];
          FOR i := 1 TO UltimoCampo DO
            BEGIN
              WITH Tabella[I] DO
                BEGIN
                  L := CifreInt;
                  CASE Tipo OF
                    'I' : BEGIN
                            PInt := PTR(Rseg, Rofs+OAddr);
                            STR(PInt^:CifreInt, Dato);
                            IF PInt^ = 0 THEN Dato := '';
                          END;
                    'R' : BEGIN
                            PReal := PTR(Rseg, Rofs+OAddr);
                            IF CifreDec > 0 THEN L := L+1;
                            STR(PReal^:CifreInt:CifreDec, Dato);
                            IF PReal^ = 0 THEN Dato := '';
                          END;
                    '$' : BEGIN
                            PStr := PTR(Rseg, Rofs+OAddr);
                            Dato := PStr^;
                          END;
                  ELSE Dato := '';
                  END;
                  IF Tipo = '$' THEN Dato := FORMAT(SETLEFT(Dato), CifreInt)
                  ELSE
                    BEGIN
                      Dato := SETLEFT(Dato);
                      Dato := FORMAT('', CifreInt-LENGTH(Dato))+Dato;
                    END;
                  FOR K := x TO x+CifreInt-1 DO PrintST[K] := Dato[K-x+1];

                END;          { with tabella[i] do............. }
            END;              { for i:=1 to ultimocampo do.......... }

          WRITELN(GLST, PrintST);

        END;                  { proc.   writecampi }
        {----------------------------  writetitolo  ----------------------------------}
      PROCEDURE WriteTitolo;
        VAR
          I : INTEGER;
        BEGIN
          FOR I := 1 TO LenTitolo-1 DO WRITELN(GLST, TitST[I]);
        END;                  { proc.  writetitolo }
        {-----------------------------  writeult  -----------------------------------}
      PROCEDURE WriteUlt;
        BEGIN
          WRITELN(GLST, TitST[LenTitolo]);
        END;                  { proc. writeult }


