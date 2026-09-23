      {--------------------------    inserisciriduzioni    ------------------------}
    PROCEDURE InserisciRiduzioni;
        { percorre tutta la rete per inserire adattatori di sezione }
      VAR
        ERR1, ERR2 : BOOLEAN;
        CH : CHAR;
        Sel : BYTE;
        UO, NP : INTEGER;
        Angolo, R : REAL;
        Cod : STRING[5];
        UIND : LINK;
        {----------------------------  adatta_sezioni  ---------------------------}
      PROCEDURE ADATTA_SEZIONI(IND, INDPadre : LINK; Dir : INTEGER);
        VAR O, N : INTEGER;
          AreaIN, AreaOUT, l, y : REAL;
          CodLun : CHAR;
          INSez, OUTSez : CHAR; { Sono le due sezioni che si incontrano nel senso del
                                flusso uscendo da un pezzo ed entrando in un altro.
                                Possono valere 'C' o 'R' ; se sono diverse sicura-
                                mente verra inserito un adattatore altrimenti si
                                controllano le dimensioni per valutare la necessit 
                                di inserire un 'allargamento' o una 'riduzione'   }
          PhiIn, PhiOut, INRif, OUTRif, Rif : INTEGER;
          Temp, HIN, WIN, DIN, HOUT, WOUT, DOUT : REAL;
          Modificabile : BOOLEAN;
        BEGIN
          N := ULT_LINE(IND);
          NP := ULT_LINE(INDPadre);

          O := 0;
          REPEAT
            O := O+1;
            { o punta al pezzo di cui si valuta la sezione d'ingresso }

            {------------calcolo misure in out---------------------------------------}
            OUTRif := FIND_ARCHIVIO(IND^.T[O].CodPezzo);
            OUTSez := UPCASE(ARCHIVIO[OUTRif].TipoSez[1]);
            IF OUTSez IN ['H', 'A'] THEN OUTSez := 'R'; { Tipo sezione d'uscita dello
                                                        eventuale raccordo  }
            IF OUTSez = 'D' THEN OUTSez := 'C';

            WITH IND^.T[O] DO
              BEGIN
                HOUT := H; WOUT := W; DOUT := A_D;
                PhiOut := Phi;
              END;            { dimensioni del pezzo o-esimo }


            {---------------------------------------------------}
            {il flag TIPOSEZ[dir+1] ha i seguenti significati:
            canali rettangolari
            - H modifica ammissibile solo sulla misura W
            - A modifica ammissibile sia su W che su H
            - R le dimensioni non sono modificabili
            canali circolari
            - C diametro modificabile
            - D diametro non modificabile                           }


            {..calcolo misure in ..}
            IF (O = 1) THEN
              BEGIN
                IF INDPadre <> NIL THEN { preleva dati uscita braga }
                  BEGIN
                    INRif := FIND_ARCHIVIO(INDPADRE^.T[Np].CodPezzo);
                    WITH INDPADRE^.T[Np] DO
                      BEGIN
                        INSez := UPCASE(ARCHIVIO[INRif].TipoSez[Dir+1]);
                        IF INSez IN ['H', 'A'] THEN INSez := 'R'; { Tipo sezione d'ingresso
                                                                  eventuale raccordo }
                        IF INSez = 'D' THEN INSez := 'C';

                        Modificabile := (UPCASE(ARCHIVIO[INRif].TipoSez[Dir+1]) IN ['H', 'A', 'C']);

                        IF INSez = 'R' THEN { raccordo con ingresso rettangolare }
                          BEGIN
                            IF Modificabile THEN WIN := WOUT
                            ELSE WIN := W;

                            IF UPCASE(ARCHIVIO[INRif].TipoSez[Dir+1]) = 'A' THEN HIN := HOUT
                            ELSE HIN := H;

                            DIN := 0;

                          END
                        ELSE  { raccordo con ingresso circolare  }
                          BEGIN
                            IF Modificabile THEN DIN := DOUT
                            ELSE DIN := A_D;
                            HIN := 0; WIN := 0;
                          END;
                        PhiIn := Phi;
                      END;
                  END         { if indpadre<>nil then......... }
                ELSE
                  WITH Ind^.T[O] DO
                    BEGIN
                      WIN := W; WOUT := W;
                      HIN := H; HOUT := H;
                      DIN := A_D; DOUT := A_D;
                      PhiIn := Phi;
                    END;
              END             { if o = 1  }

            ELSE
              BEGIN           { if o <> 1 }
                Dir := 1;
                INRif := FIND_ARCHIVIO(IND^.T[O-1].CodPezzo);
                INSez := UPCASE(ARCHIVIO[INRif].TipoSez[Dir+1]);
                IF INSez IN ['H', 'A'] THEN INSez := 'R'; { tipo sezione d'ingresso }
                IF INSez = 'D' THEN INSez := 'C';
                Modificabile := (UPCASE(ARCHIVIO[INRif].TipoSez[Dir+1]) IN ['H', 'A', 'C']);
                IF INSez = 'R' THEN { raccordo con ingresso rettangolare }
                  BEGIN
                    IF Modificabile THEN
                      BEGIN
                        WIN := WOUT; HIN := HOUT;
                        DIN := 0;
                        IF UPCASE(ARCHIVIO[INRif].TipoSez[Dir+1]) = 'H' THEN HIN := Ind^.T[O-1].H;
                      END
                    ELSE
                      BEGIN
                        WITH IND^.T[O-1] DO
                          BEGIN
                            HIN := H; WIN := W; DIN := 0;
                          END;
                      END;
                  END
                ELSE          { raccordo con ingresso circolare }
                  BEGIN
                    IF Modificabile THEN
                      BEGIN
                        WIN := 0; HIN := 0;
                        DIN := DOUT;
                      END
                    ELSE
                      BEGIN
                        WITH IND^.T[O-1] DO
                          BEGIN
                            HIN := 0; WIN := 0; DIN := A_D;
                          END;
                      END;
                  END;
                WITH Ind^.T[O-1] DO PhiIn := Phi;
              END;

            {    if PhiIn in [90,270] then
            begin
            Temp:=WIN;
            WIN:=HIN;
            HIN:=Temp;
            end;

            if PhiOut in [90,270] then
            begin
            Temp:=WOUT;
            WOUT:=HOUT;
            HOUT:=Temp;
            end;
            }
            { Sel = 0 nessuna riduzione
            Sel = 1 rett/rett (concentrica o eccentrica a secondo del codice con_
            tenuto nel file RIDRETT.DAT)
            Sel = 2 rotazione a 90ø (concentrica o eccentrica a secondo del codice
            contenuto in TRASF.DAT)
            Sel = 3 circ/circ (concentrica o eccentrica a secondo del codice con_
            tenuto in RIDCIRC.DAT)
            Sel = 4 circ/rett
            Sel = 5 rett/circ
            Sel = Sel + 10 se si tratta di un allargamento                         }

            Sel := 0;

            IF (INSez = 'R') AND (OUTSez = 'R') THEN { rett/rett }
              BEGIN
                IF (HIN <> HOUT) OR (WIN <> WOUT) THEN Sel := 1
                ELSE Sel := 0;
                IF ((HIN > HOUT) AND (WIN < WOUT)) OR ((HIN < HOUT) AND (WIN > WOUT)) THEN Sel := 2;
              END;

            IF (INSez = 'C') AND (OUTSez = 'C') THEN { circ/circ }
              BEGIN
                IF DIN <> DOUT THEN Sel := 3
                ELSE Sel := 0;
              END;

            IF ((INSez = 'C') AND (OUTSez = 'R')) THEN Sel := 4; { circ/rett }

            IF ((INSez = 'R') AND (OUTSez = 'C')) THEN Sel := 5; { rett/circ }

            IF INSez = 'R' THEN AreaIN := HIN*WIN
            ELSE AreaIN := 4*PI*SQR(DIN/2);

            IF OUTSez = 'R' THEN AreaOUT := HOUT*WOUT
            ELSE AreaOUT := 4*PI*SQR(DOUT/2);

            IF AreaOUT > AreaIN THEN Sel := Sel+10;

            IF (Sel <> 0) AND (Sel <> 10) THEN
              BEGIN
                IF INSERT_LINE(IND, O) THEN
                  BEGIN
                    CASE Sel OF
                      1 : BEGIN Cod := RRett; CodLun := Cod[3]; END;
                      2, 12:BEGIN Cod := TRett; CodLun := Cod[3]; END;
                      3 : BEGIN Cod := RCirc; CodLun := Cod[3]; END;
                      4, 14:BEGIN
                                Cod := VCR; CodLun := Cod[4];
                                IF DIN = 0 THEN DIN := DOUT;
                              END;
                      5, 15:BEGIN
                                Cod := VRC;
                                CodLun := Cod[4];
                                IF DIN = 0 THEN DIN := DOUT;
                              END;
                      11 : BEGIN Cod := ARett; CodLun := Cod[3]; END;
                      13 : BEGIN Cod := ACirc; CodLun := Cod[3]; END;
                    END;


                    Rif := FIND_ARCHIVIO(Cod);
                    WITH IND^.T[O] DO
                      BEGIN
                        CodPezzo := Cod;
                        Descr := ARCHIVIO[Rif].Descr;

                        A_D := ROUND(DIN);
                        H := ROUND(HIN);
                        W := ROUND(WIN);

                        Portata := IND^.T[O+1].Portata;

                        IF CodLun = '1' THEN L := 0.8
                        ELSE
                          IF CodLun = '2' THEN L := 1.0;

                      END;
                    O := O+1;
                    N := N+1; { nella tabella c'e` un pezzo in piu` }
                  END;        { if inserimento a buon fine   then ............ }

              END;

          UNTIL O >= N;       { for o:=1 to n do............. }
        END;                  { proc. adatta_sezioni }


        {----------------------------    trova     -------------------------------}
      PROCEDURE Trova(IND, INDPadre : LINK; Dir : INTEGER);
        BEGIN
          IF IND <> NIL THEN
            BEGIN
              Adatta_Sezioni(IND, INDPadre, Dir);

              Trova(IND^.Pc, IND, 1);
              Trova(IND^.Ps, IND, 2);
              Trova(IND^.Pd, IND, 3);
            END;
        END;                  { proc. trova }

        {********************   main   of   inserisciriduzioni   *********************}
      BEGIN
        Trova(P0, NIL, 0);
      END;                    { proc. inserisciriduzioni }



      {---------------------------  eliminaadattatori  -----------------------------}
    PROCEDURE EliminaAdattatori;

        {-------------------------------  delete_line  -----------------------------}
      PROCEDURE DELETE_LINE(IND : LINK; N : INTEGER);
        VAR
          O, U : INTEGER;
        BEGIN
          U := ULT_LINE(IND);
          FOR O := N TO U-1 DO IND^.T[O] := IND^.T[O+1];
          INIT_LINE(IND, U);
        END;                  { proc. delete_line }

      FUNCTION EQUI(C1, C2 : st5) : BOOLEAN;
        VAR i : INTEGER;
          B : BOOLEAN;
        BEGIN

          IF C1 = '' THEN B := FALSE
          ELSE
            BEGIN
              i := 1;
              REPEAT
                B := (UPCASE(C1[i]) = UPCASE(C2[i]));
                i := i+1;
              UNTIL NOT B OR (I > LENGTH(C2));
            END;
          EQUI := B;
        END;

        {------------------------------   elimina   --------------------------------}
      PROCEDURE Elimina(IND : LINK);
        VAR
          I, U, J : INTEGER;
        BEGIN
          U := ULT_LINE(IND);
          I := 1;
          REPEAT
            WITH Ind^.T[I] DO
              IF EQUI(CodPezzo, RRett) OR EQUI(CodPezzo, RCirc) OR EQUI(CodPezzo, TRett) OR
              EQUI(CodPezzo, VCR) OR EQUI(CodPezzo, VRC) OR EQUI(CodPezzo, ARett) OR
              EQUI(CodPezzo, ACirc) THEN
                BEGIN
                  DELETE_LINE(IND, I);
                  U := Ult_Line(Ind);
                END
              ELSE I := I+1;
          UNTIL I > U;

        END;                  { proc.  elimina }

        {-----------------------------    trova      -------------------------------}
      PROCEDURE Trova(IND : LINK);
        BEGIN
          IF IND <> NIL THEN
            BEGIN
              Elimina(IND);
              Trova(IND^.Ps);
              Trova(IND^.Pc);
              Trova(IND^.Pd);
            END;
        END;                  { proc. trova }

        {********************   main   of   eliminaadattatori   *********************}
      BEGIN
        Trova(P0);
      END;                    { proc. eliminaadattatori }

