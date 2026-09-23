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