  
   PROCEDURE bilancia(flag : CHAR);

    FUNCTION CalcPerd(INDPadre, IND : LINK) : REAL;
        { Calcola le perdite dei pezzi di uno stesso tronco e restituisce
        la somma delle perdite.                                                     }
      VAR
        I, O, U, N, RifArch : INTEGER;
        PUN : LINK;
        A, PTee, PerdSum, Vvel, Cx : REAL;
        ch : CHAR;
      BEGIN
        { .. Nella posizione 0 ci sono i dati relativi alla braga da cui parte il
        ramo in esame                                 .. }
        IF INDPadre <> NIL THEN
          BEGIN
            O := Ult_Line(INDPadre);
            Vvel := CalcVel(INDPadre, O);
            PTee := IND^.T[0].C0*Pv(Vvel);
            IND^.T[0].Perdita := PTee;
            PerdSum := PTee;
          END
        ELSE
          BEGIN
            PTee := IND^.T[0].Perdita;
            PerdSum := PTee;
          END;


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
              ELSE IF l > 0 THEN Perdita := PerditaAttr(L, A_D, Portata)
              ELSE Perdita := 0;

              PerdSum := PerdSum+Perdita;

            END;              { for....... with ind^.t[o] do........... }

        IND^.T[NCompRamo+1].Perdita := PerdSum;
        CalcPerd := PerdSum;

      END;                    { funct.  calcperd }


    FUNCTION CalcolaPerdite(INDPadre, IND : LINK; PerdPr : REAL) : REAL;
        { calcola le perdite per i rami che dipendono da ind }
      VAR
        MaxPerdita : REAL;

      PROCEDURE Trova(INDPadre, IND : LINK; PerdPr : REAL);
        VAR O : BYTE;

        BEGIN
          IF IND <> NIL THEN
            BEGIN
              PerdPr := PerdPr+CalcPerd(INDPadre, IND);
              IF MaxPerdita < PerdPr THEN MaxPerdita := PerdPr;

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

    PROCEDURE DiamChange(IND, INDPADRE : LINK; Dir : INTEGER; Variaz : INTEGER);


      VAR
        O, R, U, k, OP, RifPadre : INTEGER;
        Rapporto : REAL;
        FLAG, PadreDI0R : BOOLEAN;
        Tp : CHAR;


      BEGIN
        MaxDimH := DPr2.DimH; MaxDimW := DPr2.DimW; Rapporto := DPr2.Rapp;
        PadreDI0R := FALSE;

        IF IndPadre <> NIL THEN
          BEGIN
            OP := Ult_Line(IndPadre);
            RifPadre := Find_Archivio(IndPadre^.T[OP].CodPezzo);
            IF Archivio[RifPadre].Main = 'P' THEN {.... di0r ....}
              BEGIN
                PadreDI0R := TRUE;
                MaxDimW := (Ind^.T[1].Portata/IndPadre^.T[OP].Portata)*IndPadre^.T[OP].W;
                MaxDimH := IndPadre^.T[OP].H;
                Rapporto := MaxDimH/MaxDimW;
              END;
          END;

        U := ULT_LINE(IND);
        FOR O := 1 TO U DO
          BEGIN
            FLAG := TRUE;
            R := FIND_ARCHIVIO(IND^.T[O].CodPezzo);
            IF (ARCHIVIO[R].NUscite = 1) AND (ARCHIVIO[R].TipoSez[2] IN ['H', 'A', 'C']) THEN
              IF O = 1 THEN FLAG := FALSE
              ELSE
                IF IND^.T[O-1].CHFlag = '*' THEN FLAG := FALSE;

            IF FLAG AND (IND^.T[O].CHFlag <> '*') THEN
              BEGIN
                Tp := ARCHIVIO[R].TipoSez[1];
                IF UPCASE(Tp) IN ['R', 'H', 'A'] THEN
                  BEGIN
                    Tp := 'R';
                    k := SearchDim(IND^.T[O].W, Tp);
                  END
                ELSE
                  BEGIN
                    Tp := 'C';
                    k := SearchDim(IND^.T[O].A_D, Tp);
                  END;

                IF k+Variaz > 0 THEN
                  BEGIN
                    Dim_St(k+Variaz, IND^.T[O].H, IND^.T[O].W, IND^.T[O].A_D, Tp, Rapporto);
                    IF PadreDI0R THEN Ind^.T[O].H := ROUND(MaxDimH);
                  END;
              END;

          END;                { for o:=1 to u do.......... }
      END;                    { proc.  diamchange }

    PROCEDURE equilibra(IND : LINK);
      VAR
        AttPerd : REAL;       { somma delle perdite degli elementi del nodo attuale    }
        AttMax : REAL;        { valore massimo di perdita che dipende dal nodo attuale }
        Ptent : REAL;         { Valore di perdita per un tentativo di dimensionamento
                              diametri. }
        Pl, PRagg, MinDiam : REAL;
        IOERR, I, RifArch, N, IndMin : INTEGER;
        NomeTab : STRING[18];

      PROCEDURE Trova(IndPadre, IND : LINK; Dir : INTEGER; PerdPr : REAL);
        VAR O : BYTE;
          Prova, Diff, PAttrLim, Vel : REAL;
          Cont, IndDim, I : INTEGER; { indice array dimensioni }
          ch : CHAR;
          Serranda : BOOLEAN;
        BEGIN
          Cont := 0;
          IF IND <> NIL THEN
            BEGIN
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

              AttPerd := IND^.T[NCompRamo+1].Perdita; { somma delle perdite per il ramo ind    }
              AttMax := Calcolaperdite(INDPadre, IND, PerdPr); { Valore di perdita max ad un terminale
                                                               dipendente da IND                      }

              GOTOXY(1, 21); CLREOL;
              GOTOXY(1, 21);
              WRITE('Da Nodo ');
              IF INDPADRE = NIL THEN WRITE('000')
              ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));
              WRITE('  a nodo ', CODTAB_FORM(IND^.CodTab));
              GOTOXY(1, 22); CLREOL;
              GOTOXY(1, 22); WRITE('Perdita calcolata  (Pa) :');
              GOTOXY(28, 22); WRITE(AttPerd:8:3);
              Serranda := FALSE;

              IF AttMax+ABS(DPr2.SbilDPu) < PerditaMax THEN
                BEGIN

                  { Ridimensiona questo nodo per raggiungere il valore di AttPerd tale che
                  PerditaMax-AttMax=0 : AttPerd deve incrementarsi di (PerditaMax-AttMax).
                  Dopo cio` si devono ricalcolare tutti i valori ai punti terminali che
                  dipendono da questo nodo.                                               }

                  PRagg := PerditaMax;
                  PTent := 0;

                  IF PerditaMax-AttMax > 0.1 THEN
                    BEGIN
                      MinDiam := IND^.T[1].A_D;
                      IndMin := 1;
                      REPEAT
                        Cont := Cont+1;
                        DiamChange(IND, INDPADRE, Dir, -1);
                        PAttrLim := PerditaAttr(1, Ind^.T[IndMin].A_D, Ind^.T[IndMin].Portata);
                        Vel := CalcVel(Ind, IndMin);

                        IF (PAttrLim <= PMaxHLV) AND (Vel <= VMaxHLV) THEN
                          BEGIN
                            {.. Ricontrolla i valori di C0 risalendo al padre (Prova Š una
                            variabile di comodo) ..}
                            IF IndPadre <> NIL THEN Prova := CalcolaPerdite(NIL, IndPadre, 0);
                            Ptent := CalcolaPerdite(INDPadre, IND, PerdPr);
                            AttPerd := IND^.T[NCompRamo+1].Perdita;
                            GOTOXY(28, 22); WRITE(AttPerd:8:3);
                          END
                        ELSE
                          BEGIN
                            DiamChange(Ind, INDPADRE, Dir, 1);
                            IF IndPadre <> NIL THEN Prova := CalcolaPerdite(NIL, IndPadre, 0);
                            Ptent := CalcolaPerdite(INDPadre, IND, PerdPr);
                            AttPerd := IND^.T[NCompRamo+1].Perdita;
                            GOTOXY(28, 22); WRITE(AttPerd:8:3);
                            Serranda := TRUE;
                          END;
                      UNTIL (PRagg < Ptent) OR (PAttrLim > PMaxHLV) OR (Vel > VMaxHLV) OR (Cont > 4) OR Serranda;

                      IF PRagg < PTent THEN
                        BEGIN
                          DiamChange(IND, INDPADRE, Dir, 1);
                          {.. Ricontrolla i valori di C0 risalendo al padre (Prova Š una
                          variabile di comodo) ..}
                          IF IndPadre <> NIL THEN Prova := CalcolaPerdite(NIL, IndPadre, 0);
                          Ptent := CalcolaPerdite(INDPadre, IND, PerdPr);
                          AttPerd := IND^.T[NCompRamo+1].Perdita;
                          GOTOXY(28, 22); WRITE(AttPerd:8:3);
                        END;
                    END;      { if perdite da recuperare < 0.1 then ............. }
                END;

              Trova(IND, IND^.Pc, 1, PerdPr+IND^.T[NCompRamo+1].Perdita);
              Trova(IND, IND^.Ps, 2, PerdPr+IND^.T[NCompRamo+1].Perdita);
              Trova(IND, IND^.Pd, 3, PerdPr+IND^.T[NCompRamo+1].Perdita);
            END;              { if ind<>nil then.......... }
        END;                  { proc. trova }

        {************** equilibra **************}
      BEGIN
        Trova(NIL, IND, 0, 0);
      END;                    { proc. equilibra }



      {........ MarcaTronchi .........
      inserisce un flag = true in corrispondenza dei pezzi appartenenti al tronco
      principale.................................................................}
    PROCEDURE MarcaTronchi(Ind : link);
      BEGIN
        IF Ind <> NIL THEN
          BEGIN
            Ind^.TR := TRUE;
            MarcaTronchi(Ind^.Pc);
          END;
      END;




      {-----------------------------  main of bilancia ------------------------------}
    VAR
      N : INTEGER;
    BEGIN
      WITH DPr2 DO
        BEGIN
          Densita := Dens; Viscosita := Visc; Eps := Rugosita;
        END;

      TEXTCOLOR(Col[2]);
      MarcaTronchi(P0);
      Equilibra(P0);
      EliminaAdattatori;
      Contcalc(P0, NIL);
      InserisciRiduzioni;
      PerditaMax := CalcolaPerdite(NIL, P0, 0);
      GOTOXY(1, 23);
      WRITE('Perdita massima = ', PerditaMax:8:3, ' Pa');

    END;

   PROCEDURE PreDim(Flag : CHAR);

      {$I portate   incluso esplicitato di seguito}

      {------------------------------  setportata  --------------------------------}
    PROCEDURE SETPORTATA(IND : LINK; Portata : REAL);
        { assegna lo stesso valore di portata ai pezzi di uno stesso tronco }
      VAR i : INTEGER;
      BEGIN
        O := Ult_Line(Ind);
        FOR i := 1 TO O DO IND^.T[i].Portata := Portata;
      END;                    { proc.  setportata }

      {-----------------------------  findportata  ---------------------------------}
    FUNCTION FINDPORTATA(IND : LINK) : REAL;
        { cerca un pezzo con zero uscite e ne preleva il valore di portata }
      VAR
        O : INTEGER;
      BEGIN
        O := ULT_LINE(IND);
        FindPortata := IND^.T[O].Portata;
      END;                    { func.  findportata }


      {------------------------------   cportate   ---------------------------------}
    PROCEDURE Cportate(IND : LINK; VAR Portata : REAL);
      VAR P1, P2, P3 : REAL;
      BEGIN
        Portata := 0; P1 := 0; P2 := 0; P3 := 0;
        IF IND <> NIL THEN
          BEGIN
            IF (IND^.Pc = NIL) AND (IND^.Ps = NIL) AND (IND^.Pd = NIL) THEN
              BEGIN
                Portata := FindPortata(IND);
                SETPORTATA(IND, Portata);
              END
            ELSE
              BEGIN
                Cportate(IND^.Pc, P1);
                Cportate(IND^.Ps, P2);
                Cportate(IND^.Pd, P3);
                Portata := P1+P2+P3;
                SETPORTATA(IND, Portata);
              END;
          END;
      END;                    { proc. cportate }

{ fine file portate}



    PROCEDURE D1(INDPADRE, IND : LINK);
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

    PROCEDURE Dimens1(INDPADRE, IND : LINK);
      BEGIN
        IF NOT(IND = NIL) THEN
          BEGIN
            D1(INDPADRE, IND);
            Dimens1(IND, IND^.Pc);
            Dimens1(IND, IND^.Ps);
            Dimens1(IND, IND^.Pd);
          END;
      END;                    { proc. dimens1 }



    FUNCTION CalcPerd(INDPadre, IND : LINK) : REAL;
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


    FUNCTION CalcolaPerdite(INDPadre, IND : LINK; PerdPr : REAL) : REAL;
        { calcola le perdite per i rami che dipendono da ind }
      VAR
        MaxPerdita : REAL;

      PROCEDURE Trova(INDPadre, IND : LINK; PerdPr : REAL);
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
    PROCEDURE MarcaTronchi(Ind : link);
      BEGIN
        IF Ind <> NIL THEN
          BEGIN
            Ind^.TR := TRUE;
            MarcaTronchi(Ind^.Pc);
          END;
      END;


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

(*  main of canali *)

        7 : IF NomeFile > '' THEN
              BEGIN
                Mandata := TRUE;
                IF Controllo(NIL, P0) THEN
                 begin
                    CASE Sel OF
                      1 : PreDim('D');
                      2 : BEGIN
                            PreDim('D');
                            Bilancia('E');
                            SerRami(1);
                          END;
                      3 : BEGIN
                            PreDim('D');
                            Bilancia('E');
                            SerTerm(1);
                          END;
                      4 : BEGIN
                            PreDim('D');
                            Bilancia('E');
                          END;
                      5 : Predim('V');
                      6 : SerRami(1);
                      7 : SerTerm(1);
                      8 : BEGIN
                            serrami(0);
                            serterm(0);
                          END;
                    end;
                 end;
                IO('S');
                HALT;
              END;
{            ELSE WRITE(#7);}
        8 : IF NomeFile > '' THEN
              BEGIN
                Mandata := FALSE;
                IF Controllo(NIL, P0) THEN
                 begin
                    CASE Sel OF
                      1 : PreDim('D');
                      2 : BEGIN
                            PreDim('D');
                            Bilancia('E');
                            SerRami(1);
                          END;
                      3 : BEGIN
                            PreDim('D');
                            Bilancia('E');
                            SerTerm(1);
                          END;
                      4 : BEGIN
                            PreDim('D');
                            Bilancia('E');
                          END;
                      5 : BEGIN
                            VelCost := DPr2.VCostante;
                            Predim('D');
                          END;
                      6 : Predim('V');
                      7 : SerRami(1);
                      8 : SerTerm(1);
                      9 : BEGIN
                            serrami(0);
                            serterm(0);
                          END;
                     end;
                 end;
                IO('S');
                HALT;
              END;
{            ELSE WRITE(#7);}