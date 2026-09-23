   PROCEDURE PreDim(Flag : CHAR);

      {$I portate  }

    PROCEDURE D1(Var INDPADRE,IND : LINK);
        { dimensiona il diametro dei pezzi di uno stesso tronco }
      VAR
        O, J, R, OP, RifPadre : INTEGER;
        FLAG, RamoCost : BOOLEAN;
        PORT, Rapporto : REAL;
        RifArch, H1, W1, Diam : INTEGER;
        CH : CHAR;
        TipoSezione : ARRAY[1..NCompRamo] OF CHAR;
        Misto : BOOLEAN;
      BEGIN

        PORT := IND^.T[1].Portata;

        IF Ind^.TR THEN
          BEGIN
            PMaxHLV := Dpr2.MaxTronco; VMaxHLV := Dpr2.VelTronco;
            AttrCost := Dpr2.DPuMTronco;
          END
        ELSE
          BEGIN
            PMaxHLV := Dpr2.MaxRami; VMaxHLV := Dpr2.VelRami;
            AttrCost := Dpr2.DPuMRami;
          END;

        MaxDimH := DPr2.DimH; MaxDimW := DPr2.DimW; Rapporto := DPr2.Rapp;

        IF IndPadre <> NIL THEN
          BEGIN
            OP := Ult_Line(IndPadre);
            RifPadre := Find_Archivio(IndPadre^.T[OP].CodPezzo);
            IF Archivio[RifPadre].Main = 'P' THEN {.... di0r ....}
              BEGIN
                MaxDimW := (PORT/IndPadre^.T[OP].Portata)*IndPadre^.T[OP].W;
                MaxDimH := IndPadre^.T[OP].H;
                Rapporto := MaxDimH/MaxDimW;
              END;
          END;



        O := ULT_LINE(IND);
        RamoCost := (Ind^.T[1].CHFlag = '*'); j := 2;
        WHILE RamoCost AND (j <= O) DO
          BEGIN
            RamoCost := (Ind^.T[j].CHFlag = '*') AND RamoCost;
            j := j+1;
          END;


        IF NOT(RamoCost) THEN
          BEGIN
            GOTOXY(1, 21);
            WRITE('Da Nodo ');
            IF INDPADRE = NIL THEN WRITE('000')
            ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));
            WRITE('  a nodo ', CODTAB_FORM(IND^.CodTab));
            GOTOXY(1, 22); WRITE('Diametro calcolato (mm) : ');


            FOR j := 1 TO O DO
              BEGIN
                RifArch := FIND_ARCHIVIO(Ind^.T[j].CodPezzo);
                IF ARCHIVIO[RifArch].TipoSez[1] IN ['A', 'R', 'H'] THEN TipoSezione[j] := 'R'
                ELSE TipoSezione[j] := 'C';
              END;

            Ch := TipoSezione[1]; Misto := FALSE;
            j := 1;
            WHILE NOT(Misto) AND (j <= O) DO
              BEGIN
                Misto := (Ch <> TipoSezione[j]);
                j := j+1;
              END;

            { .. velcost <> 0 dimensiona un impianto di ripresa a velocita' costante ..}
            IF VelCost = 0 THEN Diametro(1, PORT, Rapporto, H1, W1, Diam, Ch)
            ELSE DimVCost(1, PORT, Rapporto, H1, W1, Diam, Ch);

            FOR J := 1 TO O DO
              BEGIN
                WITH IND^.T[J] DO
                  IF (CHFlag <> '*') THEN
                    BEGIN
                      IF TipoSezione[j] = Ch THEN
                        BEGIN
                          A_D := TRUNC(Diam);
                          H := H1;
                          W := W1;
                        END;
                    END;
              END;

            IF Misto THEN
              BEGIN
                IF Ch = 'R' THEN Ch := 'C'
                ELSE Ch := 'R';
                { .. velcost <> 0 dimensiona un impianto di ripresa a velocita' costante ..}
                IF VelCost = 0 THEN Diametro(1, PORT, Rapporto, H1, W1, Diam, Ch)
                ELSE DimVCost(1, PORT, Rapporto, H1, W1, Diam, Ch);

                FOR J := 1 TO O DO
                  BEGIN
                    WITH IND^.T[J] DO
                      IF (CHFlag <> '*') THEN
                        BEGIN
                          IF TipoSezione[j] = Ch THEN
                            BEGIN
                              A_D := TRUNC(Diam);
                              H := H1;
                              W := W1;
                            END;
                        END;
                  END;
              END;
          END;

      END;                    { proc.  d1 }

    PROCEDURE Dimens1(Var INDPADRE, IND : LINK);
      BEGIN
        IF NOT(IND = NIL) THEN
          BEGIN
            D1(INDPADRE, IND);
            Dimens1(IND, IND^.Pc);
            Dimens1(IND, IND^.Ps);
            Dimens1(IND, IND^.Pd);
          END;
      END;                    { proc. dimens1 }



    FUNCTION CalcPerd(Var INDPadre, IND : LINK) : REAL;
        { Calcola le perdite per attrito dei pezzi di uno stesso tronco e restituisce
        la somma delle perdite.                                                     }
      VAR
        I, O, U, N, RifArch : INTEGER;
        PUN : LINK;
        A, PTee, PerdSum, Vvel, Cx : REAL;
        ch : CHAR;
      BEGIN
        IF INDPadre = NIL THEN
          BEGIN
            IND^.T[0].C0 := 0;
            PTee := 0;
          END
        ELSE
          BEGIN
            O := Ult_Line(INDPadre);
            Vvel := CalcVel(INDPadre, O);
            PTee := IND^.T[0].C0*Pv(Vvel);
          END;

        IND^.T[0].Perdita := PTee;
        PerdSum := PTee;

        U := ULT_LINE(IND);
        FOR O := 1 TO U DO
          WITH IND^.T[O] DO
            BEGIN
              RifArch := FIND_ARCHIVIO(CodPezzo);
              N := ARCHIVIO[RifArch].NUscite;

              IF ARCHIVIO[RifArch].Main > '' THEN
                BEGIN
                  Cx := SelectC0(IND, O);
                  IF Cx <> 0 THEN
                    BEGIN
                      IF (archivio[rifarch].nuscite = 1) AND (ARCHIVIO[rifarch].TipoSez[2] IN ['H'])
                      AND (archivio[rifarch].coddis = 2) AND (UPCASE(dpr1.circuito[1]) = 'R') THEN
                        BEGIN
                        END
                      ELSE
                        BEGIN
                          IF (N < 2) THEN Perdita := Cx*Pv(CalcVel(IND, O))
                          ELSE Perdita := 0;
                        END;
                    END
                END
              ELSE IF l > 0 THEN Perdita := PerditaAttr(L, A_D, Portata);

              PerdSum := PerdSum+Perdita;

            END;              { for....... with ind^.t[o] do........... }

        IND^.T[NCompRamo+1].Perdita := PerdSum;
        CalcPerd := PerdSum;

      END;                    { funct.  calcperd }


    FUNCTION CalcolaPerdite(Var INDPadre, IND : LINK; PerdPr : REAL) : REAL;
        { calcola le perdite per i rami che dipendono da ind }
      VAR
        MaxPerdita : REAL;

      PROCEDURE Trova(Var INDPadre, IND : LINK; PerdPr : REAL);
        VAR O : BYTE;

        BEGIN
          IF IND <> NIL THEN
            BEGIN
              PerdPr := PerdPr+CalcPerd(INDPadre, IND);
              IF MaxPerdita < PerdPr THEN MaxPerdita := PerdPr;

              GOTOXY(1, 23); WRITE('Da nodo ');
              IF INDPADRE = NIL THEN WRITE('000')
              ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));
              WRITE('  a nodo ', CODTAB_FORM(IND^.CodTab));

              Trova(IND, IND^.Pc, PerdPr);
              Trova(IND, IND^.Ps, PerdPr);
              Trova(IND, IND^.Pd, PerdPr);
            END;
        END;                  { proc. trova }

        {*************** calcolaperdite *****************}
      BEGIN

        MaxPerdita := 0;
        Trova(INDPadre, IND, PerdPr);
        CalcolaPerdite := MaxPerdita;
      END;                    { proc. calcolaperdite }



      {........ MarcaTronchi .........
      inserisce un flag = true in corrispondenza dei pezzi appartenenti al tronco
      principale.................................................................}

    PROCEDURE MarcaTronchi(Var Ind : link);
      BEGIN
        IF Ind <> NIL THEN
          BEGIN
            if (Ind^.pc<>nil) or (Ind^.ps<>nil) or (Ind^.pd<>nil) then
            begin
            Ind^.TR := TRUE;
            MarcaTronchi(Ind^.Pc);
            MarcaTronchi(Ind^.Pd);
            MarcaTronchi(Ind^.Ps);
            end;
          END;
      END;
    (*
    PROCEDURE MarcaTronchi(Ind : link);
      BEGIN
        IF Ind <> NIL THEN
          BEGIN
            Ind^.TR := TRUE;
            MarcaTronchi(Ind^.Pc);
          END;
      END;

    *)
      {-----------------------------  main of predim  ------------------------------}
    VAR
      N : INTEGER;
    BEGIN


      ASSIGN(frid, DATA_DRIVE+'ridrett.dat');
      RESET(frid); READLN(frid, RRett); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'ridcirc.dat');
      RESET(frid); READLN(frid, RCirc); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'Trasf.dat');
      RESET(frid); READLN(frid, TRett); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'circrett.dat');
      RESET(frid); READLN(frid, VCR); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'rettcirc.dat');
      RESET(frid); READLN(frid, VRC); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'allrett.dat');
      RESET(frid); READLN(frid, ARett); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'allcirc.dat');
      RESET(frid); READLN(frid, ACirc); CLOSE(frid);

      SYSTEM_DRIVE := '';

      PerditaMax := 0;
      WITH DPr2 DO
        BEGIN
          Densita := Dens; Viscosita := Visc; Eps := Rugosita;
        END;

      TEXTCOLOR(Col[2]);
      MarcaTronchi(P0);
      Cportate(P0, PP);

      IF UPCASE(Flag) = 'D' THEN
        BEGIN
          EliminaAdattatori;
          Dimens1(NIL, P0);
          Contcalc(p0, NIL);
          GOTOXY(1, 21); CLREOL;
          GOTOXY(1, 22); CLREOL;
          PerditaMax := CalcolaPerdite(NIL, P0, 0);
          InserisciRiduzioni;
          Contcalc(p0, NIL);
        END;

      GOTOXY(1, 21);
      WRITE('Fine fase di predimensionamento.');
      GOTOXY(1, 22);
      WRITE('Calcolo perdite.');
      PerditaMax := CalcolaPerdite(NIL, P0, 0);
      GOTOXY(1, 23);
      WRITE('Perdita massima = ', PerditaMax:8:3, ' Pa'); CLREOL;
    END; {predim}