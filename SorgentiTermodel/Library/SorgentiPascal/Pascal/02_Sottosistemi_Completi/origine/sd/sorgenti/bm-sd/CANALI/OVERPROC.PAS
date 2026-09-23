{$A+,B-,D+,E+,F+,I+,L+,N-,O+,R+,S+,V+}
{$M 16384,0,655360}



unit overproc;
interface
uses crt,defuti,utilitie,defcom,printer,print;

PROCEDURE STAMPAbulloni(prog:string);
PROCEDURE STAMPArinforzi(prog:string);
PROCEDURE STAMPAspessori(prog:string);
PROCEDURE StampaLst(VAR esten : st3;prog:string);
PROCEDURE azzera_test1;

implementation

  PROCEDURE azzera_test1;
    BEGIN
      test1.name := '';
      test1.data := '';
      test1.pag := 0;
      test1.ntab := '';
    END;

   PROCEDURE STAMPAbulloni(PROG:STRING);
    CONST NPperPag = 40;
    VAR
      i, Cont, T : INTEGER;

    PROCEDURE contabulloni;
      VAR i, j, a : INTEGER;
        totale : INTEGER;
        peso : REAL;
        codb : STRING[3];

      BEGIN
        peso := 0;
        a := 0;
        FOR i := 1 TO 250 DO
          BEGIN
            flagb[i] := TRUE;
            a2^[i].codicebullone := '';
            a2^[i].quantitabullone := 0;
            a2^[i].pesobullone := 0;
          END;
        FOR i := 1 TO TBmw-1 DO
          BEGIN
            IF FlagB[i] THEN
              BEGIN
                FlagB[i] := FALSE;
                totale := a1^[i].quantitabullone;
                peso := a1^[i].pesobullone;
                FOR j := i+1 TO Tbmw DO
                  BEGIN
                    IF ((a1^[i].codicebullone = a1^[j].codicebullone) AND
                    (FlagB[j])) THEN
                      BEGIN
                        totale := totale+a1^[j].quantitabullone;
                        peso := peso+a1^[j].pesobullone;
                        codb := a1^[j].codicebullone;
                        FlagB[j] := FALSE;
                      END;
                  END;
                a := a+1;
                a2^[a].codicebullone := A1^[I].CODICEBULLONE;{ !!!! }
                a2^[a].quantitabullone := totale;
                a2^[a].pesobullone := peso;
                totale := 0;
                peso := 0;
              END;
          END;
        IF FlagB[Tbmw] THEN
          BEGIN
            a := a+1;
            a2^[a].codicebullone := a1^[Tbmw].codicebullone;
            a2^[a].quantitabullone := a1^[TBMW].quantitabullone;
            a2^[a].pesobullone := a1^[TBMW].pesobullone;
          END;
        FOR i := 1 TO a DO
          BEGIN
            a1^[i].codicebullone := a2^[i].codicebullone;
            a1^[i].quantitabullone := a2^[i].quantitabullone;
            a1^[i].pesobullone := a2^[i].pesobullone;
          END;
        TBMW := a;
      END;



    BEGIN
      IF TBMW > 0 THEN
        BEGIN
          contabulloni;
{          ASSIGN(glst, data_drive+prog+'.bul');
          REWRITE(glst);}
          WRITELN(glst, CHR(18));
          cont := 1;
          t := TBMW;
          azzera_test1;
          test1.name := prog;
          test1.data := getdate;
          test1.ntab := progcmt;
          FOR i := 1 TO t DO
            BEGIN
              IF Cont MOD NPperPag = 1 THEN
                BEGIN
                  conta := conta+1;
                  test1.pag := conta;
                  stampamask(SEG(test1), OFS(test1), data_drive+'cmtcmt.prn', TRUE);
                  WriteTesto(data_drive+'Testbul.prn');
                END;
              StampaMask(SEG(a1^[I]), OFS(a1^[I]),
              data_drive+'rigabul.prn', TRUE);
              Cont := Cont+1;
              IF Cont MOD NPperPag = 0 THEN
                BEGIN
                  WriteTesto(data_drive+'Ultbul.prn');
{                  SaltoPag;}
                  Cont := 1;
                END;
            END;
          IF Cont MOD NPperPag <> 0 THEN
            BEGIN
              WriteTesto(data_drive+'Ultbul.prn');
{              SaltoPag;}
            END;
{          CLOSE(glst);}
        END;
    END;

   PROCEDURE STAMPArinforzi(prog:string);
    CONST NPperPag = 40;
    VAR
      i, Cont, T : INTEGER;

    PROCEDURE contarinforzi;
      VAR i, j, a : INTEGER;
        totale : INTEGER;
        peso : REAL;
        codb : STRING[6];

      BEGIN
        peso := 0;
        a := 0;
        FOR i := 1 TO 250 DO
          BEGIN
            FlagB[i] := TRUE;
            b2^[i].codrinf := '';
            b2^[i].numrinf := 0;
            b2^[i].pesrinf := 0;
          END;

        FOR i := 1 TO TKtm-1 DO
          BEGIN
            IF FlagB[i] THEN
              BEGIN
                FlagB[i] := FALSE;
                totale := b1^[i].numrinf;
                peso := b1^[i].pesrinf;
                FOR j := i+1 TO TKtm DO
                  BEGIN
                    IF ((b1^[i].codrinf = b1^[j].codrinf) AND
                    (FlagB[j])) THEN
                      BEGIN
                        totale := totale+b1^[j].numrinf;
                        peso := peso+b1^[j].pesrinf;
                        codb := b1^[j].codrinf;
                        FlagB[j] := FALSE;
                      END;
                  END;
                a := a+1;
                b2^[a].codrinf := codb;
                b2^[a].numrinf := totale;
                b2^[a].pesrinf := peso;
                totale := 0;
                peso := 0;
              END;
          END;
        IF FlagB[Tktm] THEN
          BEGIN
            a := a+1;
            b2^[a].codrinf := b1^[Tktm].codrinf;
            b2^[a].numrinf := b1^[Tktm].numrinf;
            b2^[a].pesrinf := b1^[Tktm].pesrinf;
          END;
        FOR i := 1 TO a DO
          BEGIN
            b1^[i].codrinf := b2^[i].codrinf;
            b1^[i].numrinf := b2^[i].numrinf;
            b1^[i].pesrinf := b2^[i].pesrinf;
          END;
        Tktm := a;
      END;



    BEGIN
      IF TKTM > 0 THEN
        BEGIN
          contarinforzi;
{          ASSIGN(glst, data_drive+prog+'.rnf');
          REWRITE(glst);}
          WRITELN(glst, CHR(18));
          cont := 1;
          t := Tktm;
          azzera_test1;
          test1.name := prog;
          test1.data := getdate;
          test1.ntab := progcmt;
          FOR i := 1 TO t DO
            BEGIN
              IF Cont MOD NPperPag = 1 THEN
                BEGIN
{                  conta := conta+1;
                  test1.pag := conta;
                  stampamask(SEG(test1), OFS(test1), data_drive+'cmtcmt.prn', TRUE);}
                  WriteTesto(data_drive+'Testrnf.prn');
                END;
              StampaMask(SEG(b1^[I]), OFS(b1^[I]),
              data_drive+'rigarnf.prn', TRUE);
              Cont := Cont+1;
              IF Cont MOD NPperPag = 0 THEN
                BEGIN
                  WriteTesto(data_drive+'Ultrnf.prn');
{                  SaltoPag;}
                  Cont := 1;
                END;
            END;
          IF Cont MOD NPperPag <> 0 THEN
            BEGIN
              WriteTesto(data_drive+'Ultrnf.prn');
{              SaltoPag;}
            END;
{          CLOSE(glst);}
        END;
    END;

    PROCEDURE STAMPAspessori(prog:string);
    CONST NPperPag = 40;
    VAR
      i, Cont, T : INTEGER;

    PROCEDURE contaspessori;
      VAR i, j, a : INTEGER;
        totale : INTEGER;
        spess : REAL;
        super : REAL;
        peso : REAL;

      BEGIN
        peso := 0;
        TOTALE := 0;
        SPESS := 0;
        SUPER := 0;
        a := 0;
        FOR i := 1 TO 250 DO
          BEGIN
            FlagB[i] := TRUE;
            c2^[i].tot := 0;
            c2^[i].sps := 0;
            c2^[i].sup := 0;
            c2^[i].pes := 0;
          END;

        FOR i := 1 TO TNut-1 DO
          BEGIN
            IF FlagB[i] THEN
              BEGIN
                FlagB[i] := FALSE;
                totale := 1;
                spess := c1^[i].sps;
                peso := c1^[i].pes;
                super := c1^[i].sup;
                FOR j := i+1 TO TNut DO
                  BEGIN
                    IF ((c1^[i].sps = c1^[j].sps) AND
                    (FlagB[j])) THEN
                      BEGIN
                        totale := totale+1;
                        peso := peso+c1^[j].pes;
                        super := super+c1^[j].sup;
                        FlagB[j] := FALSE;
                      END;
                  END;
                a := a+1;
                c2^[a].tot := totale;
                c2^[a].sps := spess;
                c2^[a].pes := peso;
                c2^[a].sup := super;
                totale := 0;
                spess := 0;
                super := 0;
                peso := 0;
              END;
          END;
        IF FlagB[TNut] THEN
          BEGIN
            a := a+1;
            c2^[a].tot := 1;
            c2^[a].sps := c1^[TNut].sps;
            c2^[a].pes := c1^[TNut].pes;
            c2^[a].sup := c1^[TNut].sup;
          END;
        FOR i := 1 TO a DO
          BEGIN
            c1^[i].tot := c2^[i].tot;
            c1^[i].sps := c2^[i].sps;
            c1^[i].pes := c2^[i].pes;
            c1^[i].sup := c2^[i].sup;
          END;
        TNut := a;
      END;



    BEGIN
      IF TNut > 0 THEN
        BEGIN
          contaspessori;
{          ASSIGN(glst, data_drive+prog+'.sps');
          REWRITE(glst);}
          WRITELN(glst, CHR(18));
          cont := 1;
          t := TNut;
          azzera_test1;
          test1.name := prog;
          test1.data := getdate;
          test1.ntab := progcmt;
          FOR i := 1 TO t DO
            BEGIN
              IF Cont MOD NPperPag = 1 THEN
                BEGIN
                  conta := conta+1;
                  test1.pag := conta;
                  stampamask(SEG(test1), OFS(test1), data_drive+'cmtcmt.prn', TRUE);
                  WriteTesto(data_drive+'Testsps.prn');
                END;
              StampaMask(SEG(c1^[I]), OFS(c1^[I]),
              data_drive+'rigasps.prn', TRUE);
              Cont := Cont+1;
              IF Cont MOD NPperPag = 0 THEN
                BEGIN
                  WriteTesto(data_drive+'Ultsps.prn');
                  SaltoPag;
                  Cont := 1;
                END;
            END;
          IF Cont MOD NPperPag <> 0 THEN
            BEGIN
              WriteTesto(data_drive+'Ultsps.prn');
              SaltoPag;
            END;
{          CLOSE(glst);}
        END;
    END;

    PROCEDURE StampaLst(VAR esten : st3;prog:string);
    VAR f0 : TEXT;
      ch : STRING[126];
      I : INTEGER;

    BEGIN
       IF Exist(data_drive+prog+'.'+esten) THEN
        BEGIN
           ASSIGN(f0, data_drive+prog+'.'+esten);
           RESET(f0);
           WHILE NOT EOF(f0) DO
            BEGIN
               READLN(f0, ch);
               WRITELN(LST, ch);
            END;
           CLOSE(f0);
        END;
    END;
end.