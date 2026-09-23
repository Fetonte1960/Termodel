program canali;

Uses
{$Ifdef Win}
  Wincrt,
{$else}
  Crt,
  Dos,
{$endif}

  Turbo3, {Unit found in TURBO3.TPU}
  Defuti,
  ut_funz,
  definiz,definizcan,
  U_riduz1,
  U_serter,
  U_serram,
  U_funz,
  U_canfst,
  U_selc0,
  scritte,
  WM;

{  U_creasce,
  U_crea3d,
  U_tabell;}


   PROCEDURE Stampa;

    PROCEDURE STAMPA_RAMO(IND : LINK; NomeMask : ST40; Definitiva : BOOLEAN);
      CONST
        MaxRighe = 60;
        TabIntest = 5;
      VAR
        PrnBuff : RECORD
                    NPZ : STRING[3];
                    Denom : STRING[5];
                    PORT, Diam, WW, HH, Lungh, Pattr : REAL;
                    Tab : STRING[5];
                    XP, YP, C0P, Vel, PPV, Perd, AttPerd : REAL;
                  END;
        FALT : BOOLEAN;
        CH : CHAR;
        Pag, Riga : INTEGER;
        Cambio, TrovatoMax : BOOLEAN;
        NumPezzo : INTEGER;
        MassimaPerdita : REAL;
        Ind1Max, Ind2Max : link;

        {$I PRNMASK       }
        {$I printmsk      }


      FUNCTION FILL_PrnBuff(INDPADRE, IND : LINK; N : INTEGER; PTot, PerdPezz : REAL;
                            Dir : INTEGER) : BOOLEAN;
        VAR
          RifArch : INTEGER;
          LN : INTEGER;
        BEGIN
          IF IND <> NIL THEN
            WITH IND^.T[N] DO
              WITH PrnBuff DO
                BEGIN
                  RifArch := FIND_ARCHIVIO(CodPezzo);
                  AttPerd := 0;
                  Diam := A_D;

                  NumPezzo := NumPezzo+1;

                  IF ARCHIVIO[RifArch].TipoSez[1] = 'R' THEN WW := W ELSE WW := 0;
                  HH := H;

                  IF (n = 0) THEN
                    BEGIN
                      IF (IND^.CodTab <> 1) THEN
                        BEGIN
                          CASE Dir OF
                            0 : NPZ := '  ';
                            1 : NPZ := 'Tr';
                            2 : NPZ := 'Rm1';
                            3 : NPZ := 'Rm2';
                          END;

                          NumPezzo := 1;
                          Denom := 'Prec.';
                          PORT := 0; Diam := 0; Lungh := 0; Pattr := 0;
                          Tab := '';
                          XP := 0; YP := 0; C0P := 0; Vel := 0; PPV := 0;
                          Vel := 0;
                          Perd := 0; AttPerd := PTot;
                          WW := 0; HH := 0;
                          WriteCampi(SEG(PrnBuff), OFS(PrnBuff));
                        END
                      ELSE
                        BEGIN
                          Fill_PrnBuff := FALSE;
                          NumPezzo := NumPezzo-1;
                          EXIT;
                        END;
                    END;

                  IF n = NCompRamo+1 THEN
                    BEGIN
                      LN := Ult_Line(Ind);
                      RifArch := FIND_ARCHIVIO(Ind^.T[LN].CodPezzo);
                      IF ARCHIVIO[RifArch].NUscite = 0 THEN NPZ := '***'
                      ELSE NPZ := '   ';
                      Perd := IND^.T[NCompRamo+1].Perdita;
                      Denom := 'Tot.';
                      PORT := 0; Diam := 0; HH := 0; WW := 0; Lungh := 0; Pattr := 0;
                      Tab := '';
                      XP := 0; YP := 0; C0P := 0; Vel := 0; PPV := 0;
                      AttPerd := PTot+PerdPezz;

                      Fill_PrnBuff := TRUE;
                      EXIT;
                    END;

                  IF (ARCHIVIO[RifArch].NUscite > 1) AND (N > 0) THEN
                    BEGIN
                      Fill_PrnBuff := FALSE;
                      EXIT;
                    END
                  ELSE
                    Fill_PrnBuff := TRUE;

                  Denom := CodPezzo;
                  PORT := (Portata*miscor);
                  STR(NumPezzo:2, NPZ);

                  IF n = 0 THEN
                    BEGIN
                      IF (INDPadre = NIL) OR (A_D = 0) THEN
                        BEGIN
                          C0 := 0;
                          PPV := 0;
                        END
                      ELSE
                        BEGIN
                          O := Ult_Line(INDPadre);
                          Vel := CalcVel(INDPadre, O);
                          PPV := Pv(Vel);
                        END;
                      Perd := C0*PPV;
                    END
                  ELSE
                    BEGIN
                      IF (archivio[rifarch].nuscite = 1) AND (ARCHIVIO[rifarch].TipoSez[2] IN ['H'])
                      AND (archivio[rifarch].coddis = 2) AND (UPCASE(dpr1.circuito[1]) = 'R') THEN
                        BEGIN
                          vel := calcvel(ind, n+1);
                          PPv := pv(vel);
                          perd := perdita;
                        END
                      ELSE
                        BEGIN
                          Vel := CalcVel(IND, N);
                          PPV := Pv(Vel);
                          Perd := Perdita;
                        END;
                    END;

                  AttPerd := PTot+PerdPezz;

                  XP := X; YP := Y; C0P := C0;

                  Tab := ARCHIVIO[RifArch].Fonte;
                  IF Denom = '' THEN
                    BEGIN
                      Tab := '';
                      Denom := '-----';
                    END;

                  Lungh := L;
                  IF (Lungh <> 0) AND (ARCHIVIO[RifArch].main = '') THEN
                    PAttr := Perd/Lungh
                  ELSE PAttr := 0;

                  IF N = 0 THEN BEGIN PORT := 0; Diam := 0; END;
                END;
        END;                  { proc. fill_prnbuff }

      PROCEDURE PRINT(INDPadre, IND : LINK; PTot : REAL; Dir : INTEGER);
        VAR
          I, J : INTEGER;
          PerdPezz : REAL;
          balance : REAL;
        BEGIN
          J := 1; Cambio := FALSE;

          IF NumPezzo = 0 THEN
            BEGIN
              Cambio := TRUE;
              IF miscor = 1 THEN LeggiMask(DATA_DRIVE+'PRNRAMO.msk')
              ELSE LeggiMask(DATA_DRIVE+'PRNRAMh.msk');
            END;

          WHILE (SETLEFT(IND^.T[J].CodPezzo) > '') AND (J < NCompRamo) DO J := J+1;
          IF SETLEFT(IND^.T[J].CodPezzo) = '' THEN J := J-1;

          IF Riga+J+LenTitolo+TabIntest > MaxRighe THEN
            BEGIN
              IF miscor = 1 THEN LeggiMask(DATA_DRIVE+'PRNRAMO.msk')
              ELSE LeggiMask(DATA_DRIVE+'PRNRAMh.msk');
              Cambio := TRUE;
              WRITE(GLST, CHR(12));
              Riga := J+LenTitolo+TabIntest;
              Pag := Pag+1;
              WRITE(GLST, #18);
              WRITELN(GLST,W_M(1),': ', nomefile);  { 'N.Progetto  : '}
              WRITELN(GLST);
              WRITELN(GLST, Format(W_M(23)+' '+DPr1.Riferimento, 60), Format('', 5),W_M(24),' ',Pag:3);
              {'Riferimento : ','Pag. '}
              WRITELN(GLST, #15);
              Riga := Riga+12;
            END
          ELSE Riga := Riga+J+LenTitolo+TabIntest;

          WRITELN(GLST); WRITELN(GLST);

          WRITE(GLST,W_M(25),' ');    {'Da nodo : ');}
          IF INDPadre = NIL THEN WRITE(GLST, '000')
          ELSE WRITE(GLST, CODTAB_FORM(INDPadre^.CodTab));
          WRITELN(GLST,'  ',W_M(26),' ', CODTAB_FORM(IND^.CodTab));   {'  a nodo : '}

          WriteTitolo;
          IF Cambio THEN LeggiMask(DATA_DRIVE+'PRNRAMO1.msk');

          I := -1;
          PerdPezz := 0;
          REPEAT
            I := I+1;
            PerdPezz := PerdPezz+IND^.T[I].Perdita;
            IF FILL_PrnBuff(INDPADRE, IND, I, PTot, PerdPezz, Dir) THEN
              WriteCampi(SEG(PrnBuff), OFS(PrnBuff));
          UNTIL (I = J) OR NOT FALT;

          IF FALT AND FILL_PrnBuff(INDPADRE, IND, NCompRamo+1, PTot, PerdPezz, Dir) THEN
            WriteCampi(SEG(PrnBuff), OFS(PrnBuff));

          WriteUlt;

          {.. test se la tabella e' una tabella terminale e calcolo e stampa
          della differenza di bilanciamento
          ..}
          IF prnbuff.npz = '***' THEN
            BEGIN
              balance := massimaperdita-prnbuff.attperd;
              printmask(data_drive+'balance.prn', SEG(balance), OFS(balance), TRUE);
            END;
        END;                  { proc. print }


      PROCEDURE MassimaPerd(IndPadre, IND : LINK; PTot : REAL);
        BEGIN
          IF IND <> NIL THEN
            BEGIN

              MassimaPerd(Ind, IND^.Pc, IND^.T[NCompRamo+1].Perdita+PTot);
              MassimaPerd(Ind, IND^.Ps, IND^.T[NCompRamo+1].Perdita+PTot);
              MassimaPerd(Ind, IND^.Pd, IND^.T[NCompRamo+1].Perdita+PTot);

              PTot := IND^.T[NCompRamo+1].Perdita+PTot;
              IF PTot > MassimaPerdita THEN
                BEGIN
                  MassimaPerdita := PTot;
                  Ind1Max := IndPadre;
                  Ind2Max := Ind;
                END;
            END;
        END;                  { proc. stampa }

      PROCEDURE CercaPercorso(Ind2Max, Ind : LINK);
        BEGIN
          IF IND <> NIL THEN
            BEGIN
              IF Ind = Ind2Max THEN TrovatoMax := TRUE;
              IF NOT TrovatoMax THEN CercaPercorso(Ind2Max, IND^.Pc);
              IF NOT TrovatoMax THEN CercaPercorso(Ind2Max, IND^.Ps);
              IF NOT TrovatoMax THEN CercaPercorso(Ind2Max, IND^.Pd);
            END;
          IF TrovatoMax THEN
            BEGIN
              indicepn := indicepn+1;
              percorsonodi[indicepn] := Ind^.codtab;
            END;
        END;


      PROCEDURE STAMPA(INDPadre, IND : LINK; PTot : REAL; Dir : INTEGER);
        BEGIN
          IF FALT AND NOT(IND = NIL) THEN
            BEGIN
              PRINT(INDPadre, IND, PTot, Dir);
              STAMPA(IND, IND^.Pc, IND^.T[NCompRamo+1].Perdita+PTot, 1);
              STAMPA(IND, IND^.Ps, IND^.T[NCompRamo+1].Perdita+PTot, 2);
              STAMPA(IND, IND^.Pd, IND^.T[NCompRamo+1].Perdita+PTot, 3);

            END;
        END;                  { proc. stampa }

        {********************* stampa_ramo *********************}
      BEGIN
        WITH DPr2 DO
          BEGIN
            Densita := Dens; Viscosita := Visc; Eps := Rugosita;
          END;
        FALT := TRUE;
        Pag := 1;
        Riga := 0;
        IF Definitiva THEN
          BEGIN
            WRITELN(GLST,W_M(1),': ', nomefile);  { 'N.Progetto  : '}
            WRITELN(GLST);
            WRITELN(GLST, Format(W_M(23)+' '+DPr1.Riferimento, 60), Format('', 5),W_M(24),' ',Pag:3);
              {'Riferimento : ','Pag. '}
{            TEXTCOLOR(Col[2]);
            WRITELN(Dpr2.SpessRivest:8:3);}

            PrintMask(DATA_DRIVE+'prnrif1.PRN', SEG(DPr1), OFS(DPr1), TRUE);
            PrintMask(DATA_DRIVE+'prnrif2.PRN', SEG(DPr2), OFS(DPr2), TRUE);
            WRITELN(GLST);
            Ind1Max := NIL; Ind2Max := NIL; MassimaPerdita := 0;
            MassimaPerd(NIL, P0, 0);
            TrovatoMax := FALSE;
            indicepn := 0;
            FOR indicepn := 1 TO 100 DO percorsonodi[indicepn] := 0;
            indicepn := 0;
            CercaPercorso(Ind2Max, P0);
            IF Ind2Max <> NIL THEN
              BEGIN
                WRITE(GLST,W_M(27),' ',MassimaPerdita:5:2,W_M(28),' ');
                {'  Massima Perdita  = ',' Pa    nel tratto '}
                IF IND1Max = NIL THEN WRITE(GLST, '000')
                ELSE WRITE(GLST, CODTAB_FORM(IND1Max^.CodTab));
                WRITELN(GLST, ' - ', CODTAB_FORM(IND2Max^.CodTab));
              END;

            FOR indicepn := 1 TO 100 DO pn8[indicepn] := '';
            {.. carico il vettore al contrario lo trasformo in stringa ..}
            contapn := 1;
            pn8[1] := '000';
            FOR indicepn := 100 DOWNTO 1 DO
              BEGIN
                IF (percorsonodi[indicepn] <> 0) THEN
                  BEGIN
                    contapn := contapn+1;
                    pn8[contapn] := codtab_form(percorsonodi[indicepn]);
                  END;
              END;
            printmask(data_drive+'persfa.prn', SEG(pn8), OFS(pn8), TRUE);
            WRITE(GLST, #12); Pag := Pag+1;

          END;
        WRITE(GLST, #18);
        WRITELN(GLST,W_M(1),': ', nomefile);  { 'N.Progetto  : '}
        WRITELN(GLST);
        WRITELN(GLST, Format(W_M(23)+' '+DPr1.Riferimento, 60), Format('', 5),W_M(24),' ',Pag:3);
        {'Riferimento : ','Pag. '}
        WRITELN(GLST, #15);
        WRITELN(GLST);

        Riga := Riga+2;
        NumPezzo := 0;

        STAMPA(NIL, IND, 0, 0);
        WRITE(GLST, CHR(18), CHR(12));
      END;                    { proc. stampa_ramo }


    PROCEDURE MENUPr;
      VAR Scelta : INTEGER;
        CH : CHAR;
        NomeFile : st18;
        fp : TEXT;
      BEGIN
        STAMPA_RAMO(P0, DATA_DRIVE+'PRNRAMO.MSK', TRUE);
      END;                    { proc. menupr }

      { main di stampa }
    VAR
      N : INTEGER;
    BEGIN
      ASSIGN(GLST, {Data_Drive+}'stampe.lst');
      REWRITE(GLST);
      MENUPR;
      CLOSE(GLST);
    END;


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
              ELSE
               begin
                  IF l > 0 THEN Perdita := PerditaAttr(L, A_D, Portata)
                  ELSE Perdita := 0;
               end;

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
{        VAR O : BYTE;}

        BEGIN
          IF IND <> NIL THEN
            BEGIN
              Wnodo(ind);
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
        VAR    { O : BYTE;}
          Prova, Diff, PAttrLim, Vel : REAL;
          Cont, IndDim, I : INTEGER; { indice array dimensioni }
          ch : CHAR;
          Serranda : BOOLEAN;
        BEGIN
          wnodo(ind);
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
              (*
              GOTOXY(1, 21); CLREOL;
              GOTOXY(1, 21);
              WRITE(W_M(25),' ');  {'Da Nodo '}
              IF INDPADRE = NIL THEN WRITE('000')
              ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));
              WRITE('  ',W_M(26),' ', CODTAB_FORM(IND^.CodTab)); { a nodo }
              GOTOXY(1, 22); CLREOL;
              GOTOXY(1, 22); WRITE(W_M(29));    {'Perdita calcolata  (Pa) :}
              GOTOXY(26, 22); WRITE(AttPerd:8:3);
              *)

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
                            {GOTOXY(26, 22); WRITE(AttPerd:8:3);}
                          END
                        ELSE
                          BEGIN
                            DiamChange(Ind, INDPADRE, Dir, 1);
                            IF IndPadre <> NIL THEN Prova := CalcolaPerdite(NIL, IndPadre, 0);
                            Ptent := CalcolaPerdite(INDPadre, IND, PerdPr);
                            AttPerd := IND^.T[NCompRamo+1].Perdita;
                            {GOTOXY(26, 22); WRITE(AttPerd:8:3);}
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
                          {GOTOXY(26, 22); WRITE(AttPerd:8:3);}
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
        wfase('Equilibratura');
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
      {$ifdef win}
      {$else}
      TEXTCOLOR(Col[2]);
      {$endif}
      MarcaTronchi(P0);
      Equilibra(P0);
      EliminaAdattatori;
      Contcalc(P0, NIL);
      InserisciRiduzioni;
      WFase('Calcolo perdite localizzate');{*TR*}
      PerditaMax := CalcolaPerdite(NIL, P0, 0);
      GOTOXY(10, 14);
      WRITE(W_M(30),' ', PerditaMax:8:3, ' Pa');
      {'Perdita massima =}
    END;


   PROCEDURE PreDim(Flag : CHAR);

      {$I portate  }

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
            (*
            GOTOXY(1, 21);
            WRITE(W_M(25),' ');  {('Da Nodo ');}
            IF INDPADRE = NIL THEN WRITE('000')
            ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));
            WRITE('  ',W_M(26),' ', CODTAB_FORM(IND^.CodTab)); {'  a nodo '}
            GOTOXY(1, 22); WRITE(W_M(31));
            {'Diametro calcolato (mm) : ');}
            *)

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
            WNodo(ind);
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
{               writeln(' diam: ',A_D,' indice: ',o,' l ',l);delay(500);}
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
              ELSE IF l > 0 THEN
               begin
                  Perdita := PerditaAttr(L, A_D, Portata);
               end;

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
{        VAR O : BYTE;}

        BEGIN
          IF IND <> NIL THEN
            BEGIN
              PerdPr := PerdPr+CalcPerd(INDPadre, IND);
              IF MaxPerdita < PerdPr THEN MaxPerdita := PerdPr;
              (*
              GOTOXY(1, 23);
              WRITE(W_M(25),' ');  {'Da nodo '}
              IF INDPADRE = NIL THEN WRITE('000')
              ELSE WRITE(CODTAB_FORM(INDPADRE^.CodTab));

              WRITE('  ',W_M(26),' ', CODTAB_FORM(IND^.CodTab));
              {  a nodo }
              *)
              WNodo(ind);
              Trova(IND, IND^.Pc, PerdPr);
              Trova(IND, IND^.Ps, PerdPr);
              Trova(IND, IND^.Pd, PerdPr);
            END;
        END;                  { proc. trova }

        {*************** calcolaperdite *****************}
      BEGIN
        Wfase('Calcolo perdite localizzate');{*TR*}
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

      RRett:=Riduz.CodRidR;
      RCirc:=Riduz.CodRidC;
      RCirc:=Riduz.CodRidC;
      ARett:=Riduz.CodAllR;
      ACirc:=Riduz.CodAllC;
      TRett:=Riduz.CodRotR;
      VCR:=Riduz.CodTrasCR;
      VRC:=Riduz.CodTrasRC;
(*

      ASSIGN(frid, DATA_DRIVE+'ridrett.dat');
      RESET(frid); READLN(frid, RRett); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'ridcirc.dat');
      RESET(frid); READLN(frid, RCirc); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'allrett.dat');
      RESET(frid); READLN(frid, ARett); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'allcirc.dat');
      RESET(frid); READLN(frid, ACirc); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'Trasf.dat');
      RESET(frid); READLN(frid, TRett); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'circrett.dat');
      RESET(frid); READLN(frid, VCR); CLOSE(frid);
      ASSIGN(frid, DATA_DRIVE+'rettcirc.dat');
      RESET(frid); READLN(frid, VRC); CLOSE(frid);
*)
      SYSTEM_DRIVE := '';

      PerditaMax := 0;
      WITH DPr2 DO
        BEGIN
          Densita := Dens; Viscosita := Visc; Eps := Rugosita;
        END;

      {$ifdef win}
      {$else}
      TEXTCOLOR(Col[2]);
      {$endif}
      MarcaTronchi(P0);
      Cportate(P0, PP);

      IF UPCASE(Flag) = 'D' THEN
        BEGIN
          EliminaAdattatori;
          wfase('Predimensionamento');{*TR*}
          Dimens1(NIL, P0);
          Contcalc(p0, NIL);
          {
          GOTOXY(1, 21); CLREOL;
          GOTOXY(1, 22); CLREOL;
          }
          PerditaMax := CalcolaPerdite(NIL, P0, 0);
          InserisciRiduzioni;
          Contcalc(p0, NIL);
        END;


      (*
      GOTOXY(1, 21);
      WRITE(W_M(32));  {'Fine fase di predimensionamento.'}
      GOTOXY(1, 22);
      WRITE(W_M(33));   {'Calcolo perdite.'}
      *)
      PerditaMax := CalcolaPerdite(NIL, P0, 0);

      GOTOXY(10, 14);
      WRITE(W_M(30),' ', PerditaMax:8:3, ' Pa'); CLREOL;
      {'Perdita massima =}

    END; {predim}

    {$I datigen }

   PROCEDURE IO(flag : CHAR);
      {$I iorete   }
    BEGIN
{      ControlloChiave(ctrlkey, 1);}
      CTRLKEY:=1;
      IF flag = 'L' THEN
        BEGIN
          P0 := NIL;
          Carica_Albero(NomeFile);
        END
      ELSE Salva_Albero(NomeFile);
    END;


   FUNCTION controllo(Padre, P : link) : BOOLEAN;
      {I canfst }
    VAR Errore : BOOLEAN;



    FUNCTION SelectAng(Cod : st5) : INTEGER;
      BEGIN
        CASE Cod[3] OF
          '2' : SelectAng := 20;
          '3' : SelectAng := 30;
          '4' : SelectAng := 45;
          '6' : SelectAng := 60;
          '7' : SelectAng := 75;
          '9' : SelectAng := 90;
        ELSE
        END;
      END;


    FUNCTION VerificaTratto(Padre, P : link) : BOOLEAN;
      VAR O, i, Rif : INTEGER;
        Error : BOOLEAN;
      FUNCTION CODTAB_FORM(CodTab : INTEGER) : ST5;
        VAR
          ComSt : ST5;
        BEGIN
          STR(CodTab, ComSt);
          CASE CodTab OF
            0..9 : ComST := '00'+ComSt;
            10..99 : ComSt := '0'+ComSt;
          END;
          CODTAB_FORM := FORMAT(ComSt, 3);
        END;                  { proc. codtab_form }

      BEGIN
        Error := FALSE;
        FOR i := 1 TO NCompRamo DO
          WITH P^.T[i] DO
            BEGIN
              IF (SetLeft(CodPezzo) = '') AND (i = 1) THEN
                BEGIN
                  WRITE(CHR(7));
                  {$ifdef win}
                  {$else}
                  TEXTCOLOR(Col[2]);
                  {$endif}
                  Error := TRUE;
                  GOTOXY(1, 22); CLREOL;
                  GOTOXY(1, 22); WRITE(W_M(34),' ');   {'Il tratto '}
                  IF Padre = NIL THEN WRITE('000')
                  ELSE WRITE(CODTAB_FORM(Padre^.CodTab));
                  WRITE('-', CODTAB_FORM(P^.CodTab),' ',W_M(35));
                  {' non contiene pezzi.'}
                  WRITELN; WRITELN(W_M(36));
                  {'Premere un tasto per proseguire.'}
                  REPEAT UNTIL KEYPRESSED;
                  GOTOXY(1, 22); CLREOL; WRITELN; CLREOL;
                END;
              IF SetLeft(CodPezzo) > '' THEN
                BEGIN
                  Rif := FIND_ARCHIVIO(CodPezzo);
                  IF Archivio[Rif].NUscite >= 2 THEN {... derivazione --> angolo ...}
                    IF Ang = 0 THEN Ang := 90;
                  IF Archivio[Rif].CodDis = 2 THEN {... curve --> angolo ...}
                    IF Ang = 0 THEN Ang := SelectAng(CodPezzo);
                  IF Archivio[Rif].NUscite = 0 THEN {... uscita/ingresso --> portata...}
                    IF Portata = 0 THEN
                      BEGIN
                        WRITE(CHR(7));
                        {$ifdef win}
                        {$else}
                        TEXTCOLOR(Col[2]);
                        {$endif}
                        Error := TRUE;
                        GOTOXY(1, 22); CLREOL;
                        GOTOXY(1, 22); WRITE(W_M(37),' ',I,' ',W_M(38),' ');
                        {WRITE('Introdurre un valore di portata per il pezzo ', I, ' del tratto ');}
                        IF Padre = NIL THEN WRITE('000')
                        ELSE WRITE(CODTAB_FORM(Padre^.CodTab));
                        WRITE('-', CODTAB_FORM(P^.CodTab), '.');
                        WRITELN; WRITELN(W_M(36)); {'Premere un tasto per proseguire.'}
                        REPEAT UNTIL KEYPRESSED;
                        GOTOXY(1, 22); CLREOL; WRITELN; CLREOL;
                      END;
                  IF (SetLeft(P^.T[i+1].CodPezzo) = '') AND (Archivio[Rif].NUscite <> 0) AND
                  (P^.Ps = NIL) AND (P^.Pc = NIL) AND (P^.Pd = NIL) THEN
                    BEGIN
                      WRITE(CHR(7));
                      {$ifdef win}
                      {$else}
                      TEXTCOLOR(Col[2]);
                      {$endif}
                      Error := TRUE;
                      GOTOXY(1, 22); CLREOL;
                      GOTOXY(1, 22); WRITE(W_M(39));  {'Introdurre un terminale nel tratto '}
                      IF Padre = NIL THEN WRITE('000')
                      ELSE WRITE(CODTAB_FORM(Padre^.CodTab));
                      WRITE('-', CODTAB_FORM(P^.CodTab), '.');
                      WRITELN; WRITELN(W_M(36));  {'Premere un tasto per proseguire.'}
                      REPEAT UNTIL KEYPRESSED;
                      GOTOXY(1, 22); CLREOL; WRITELN; CLREOL;
                    END;
                END;
            END;
        VerificaTratto := NOT Error;
      END;

    PROCEDURE Verifica(Padre, P : link);
      BEGIN
        IF (P <> NIL) AND NOT Errore THEN
          BEGIN
            Errore := NOT(VerificaTratto(Padre, P));
            IF Errore THEN EXIT
            ELSE
              BEGIN
                Verifica(P, P^.Pc);
                Verifica(P, P^.Ps);
                Verifica(P, P^.Pd);
              END;
          END;
      END;

    BEGIN                     {.... controllo ....}
      Errore := FALSE;
      Verifica(Padre, P0);
      Controllo := NOT Errore;
    END;

  var fRi:file of RecRiduz;
      fInt:file of integer;
{ --------------------------------- MAIN ----------------------------------- }

  BEGIN
    chdir('c:\cca');
    FILETRADUZ:='GESTDUCT.I';
    erroraddr:=nil;
    {$Ifdef Dos}
    Errori('Tprcart','Tpccart','Tprmcart');
    {$Endif}

     if Exist('Drive1.int') then
        begin
           assign(fp,'drive1.int');
           reset(fp);
           read(fp,Data_Drive);
           close(fp);
           DATA_DRIVE := Data_Drive+'\DATICCA\';
        end
    else  DATA_DRIVE := '\DATICCA\';              {.. main ..}

    ReadColor;
    {Mouse_init;}
    {$ifdef win}
    {$else}
    WINDOW(1, 3, 80, 25);
    TEXTBACKGROUND(Col[1]); TEXTCOLOR(Col[2]);
    {$endif}
    CLRSCR;
    NomeFile := '';
    IF Exist(DATA_DRIVE+'prog.can') THEN
     BEGIN
        ASSIGN(fp, DATA_DRIVE+'prog.can');
        RESET(fp);
        READ(fp, NomeFile);
        CLOSE(fp);
     END;
    if Exist(data_drive+nomefile+'.msc') then
     begin
        ASSIGN(FInt, data_drive+nomefile+'.msc');
        RESET(FInt);
        READ(FInt, miscor);
        CLOSE(FInt);
     end
    else Miscor:=1;
    IF Exist(DATA_DRIVE+'Riduzioni.ark') THEN
     BEGIN
        ASSIGN(fRi, DATA_DRIVE+'Riduzioni.ark');
        RESET(fRi);
        READ(fRi, Riduz);
        CLOSE(fRi);
(*        Riduz.CodRidR:=Format(Riduz.CodRidR,5);
        Riduz.CodRidC:=Format(Riduz.CodRidC,5);
        Riduz.CodAllR:=Format(Riduz.CodAllR,5);
        Riduz.CodAllC:=Format(Riduz.CodAllC,5);
        Riduz.CodRotR:=Format(Riduz.CodRotR,5);
        Riduz.CodTrasCR:=Format(Riduz.CodTrasCR,5);
        Riduz.CodTrasRC:=Format(Riduz.CodTrasRC,5); *)
     END
    else
     begin
        writeMessage('duct.msg',8);
        {$ifdef win}
        DoneWincrt;
        {$endif}
        halt;
     end;
    LeggiArk;
    Carica_Dim;
    VelCost := 0;             {... il dimensionamento avviene a perdita per attrito costante ..}
    Spa:=0;                   {... inizializzazione variabile spessore usato in selectC0 }
    IO('L');

    IF NOT Exist(DATA_DRIVE+NomeFile+'.gn1') OR NOT Exist(DATA_DRIVE+NomeFile+'.gn2') THEN
      DatiGen('I');           {... inizializza i files con i dati generali ...}

    MaxDimH := DPr2.DimH; MaxDimW := DPr2.DimW;

    if Exist('calc.sce') then
     begin
        assign(fInt,'calc.sce'); {'\cca'}
        reset(fInt);
        read(fInt,scelta);
        close(fInt);
        if Exist('calc1.sce') then
         begin
            assign(fInt,'calc1.sce'); {'\cca'}
            reset(fInt);
            read(fInt,sel);
            close(fInt);
         end;
     end
    else
      begin
      {$ifdef win}
      DoneWincrt;
      {$endif}
      halt;
      end;
    REPEAT
      CASE Scelta OF
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
                {$ifdef win}
                 DoneWincrt;
                {$endif}
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
                {$ifdef win}
                DoneWincrt;
                {$endif}
                HALT;
              END;
{            ELSE WRITE(#7);}
        9 : IF NomeFile > '' THEN
             begin
                Stampa;
                {$ifdef win}
                DoneWincrt;
                {$endif}
                HALT;
             end;
{            ELSE WRITE(#7);}

      END;
    UNTIL Scelta = 15;

  IO('S');
  END.

