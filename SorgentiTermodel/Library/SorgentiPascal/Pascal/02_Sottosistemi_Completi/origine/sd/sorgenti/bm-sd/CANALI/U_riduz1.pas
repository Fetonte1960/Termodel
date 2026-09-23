{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
Unit U_Riduz1;

Interface

Uses
{$Ifdef Win}
dummyfunction,
{$else}
  Crt,
  Dos,
{$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  utilitie,
  definizcan,{defin_ca}
  u_funz,
  wm,
  scritte;

    PROCEDURE InserisciRiduzioni;
    PROCEDURE EliminaAdattatori;

implementation

      {--------------------------    inserisciriduzioni    ------------------------}
    PROCEDURE InserisciRiduzioni;
        { percorre tutta la rete per inserire adattatori di sezione }
      VAR
        ERR1, ERR2 : BOOLEAN;
        CH : CHAR;
        Sel : integer;
        UO, NP : INTEGER;
        Angolo, R : REAL;
        Cod : STRING[5];
        UIND : LINK;
        {----------------------------  adatta_sezioni  ---------------------------}
      PROCEDURE ADATTA_SEZIONI(Var IND : LINK; INDPadre:integer; Dir : INTEGER);
        VAR O, N : INTEGER;
          AreaIN, AreaOUT, l, y ,LungMask,AngMask,Ain,Bin,Aus,Bus: REAL;
          INSez, OUTSez : CHAR; { Sono le due sezioni che si incontrano nel senso del
                                flusso uscendo da un pezzo ed entrando in un altro.
                                Possono valere 'C' o 'R' ; se sono diverse sicura-
                                mente verra inserito un adattatore altrimenti si
                                controllano le dimensioni per valutare la necessit 
                                di inserire un 'allargamento' o una 'riduzione'   }
          PhiIn, PhiOut, INRif, OUTRif, Rif : INTEGER;
          Temp, HIN, WIN, DIN, HOUT, WOUT, DOUT ,AngCalc: REAL;
          Modificabile : BOOLEAN;

         { ---------------- funzione calcolo tangente --------------- }
         function Tan(Ang:real):real;
          begin
             Tan:=sin(Ang)/cos(Ang);
          end;

        BEGIN
          N := ULT_LINE(IND);
          if indpadre<>0 then NP := ULT_LINE(TabCalc^[INDPadre]^);

          O := 0;
          REPEAT
            O := O+1;
            { o punta al pezzo di cui si valuta la sezione d'ingresso }

            {------------calcolo misure in out---------------------------------------}
            OUTRif := FIND_ARCHIVIO(IND.T[O].CodPezzo);
            OUTSez := UPCASE(ARCHIVIO^[OUTRif].TipoSez[1]);
            IF OUTSez IN ['H', 'A'] THEN OUTSez := 'R'; { Tipo sezione d'uscita dello
                                                        eventuale raccordo  }
            IF OUTSez = 'D' THEN OUTSez := 'C';

            WITH IND.T[O] DO
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
              BEGIN { TODO -oDiego -cMappa : Inserimento riduzioni su braghe }
                IF INDPadre <> 0 THEN { preleva dati uscita braga }
                  BEGIN
                    INRif := FIND_ARCHIVIO(TabCalc^[INDPADRE]^.T[Np].CodPezzo);
                    WITH TabCalc^[INDPADRE]^.T[Np] DO
                      BEGIN
                        INSez := UPCASE(ARCHIVIO^[INRif].TipoSez[Dir+1]);
                        IF INSez IN ['H', 'A'] THEN INSez := 'R'; { Tipo sezione d'ingresso
                                                                  eventuale raccordo }
                        IF INSez = 'D' THEN INSez := 'C';

                        Modificabile := (UPCASE(ARCHIVIO^[INRif].TipoSez[Dir+1]) IN ['H', 'A', 'C']);
                        IF INSez = 'R' THEN { raccordo con ingresso rettangolare }
                          BEGIN
                            if phi=0 then
                              begin
                              IF Modificabile THEN WIN := WOUT
                              ELSE WIN := W;

                              IF UPCASE(ARCHIVIO^[INRif].TipoSez[Dir+1]) = 'A' THEN HIN := HOUT
                              ELSE HIN := H;
                              end
                            else
                              begin
                              IF Modificabile THEN HIN := HOUT
                              ELSE HIN := H;

                              IF UPCASE(ARCHIVIO^[INRif].TipoSez[Dir+1]) = 'A' THEN WIN := WOUT
                              ELSE WIN := W;
                              end;

                            DIN := 0;

                          END
                        ELSE  { raccordo con ingresso circolare  }
                          BEGIN
                            IF Modificabile THEN DIN := DOUT
                            ELSE DIN := A_D;
                            HIN := 0; WIN := 0;
                          END;
                        PhiIn := Phi;
                        // Inserito da diego { TODO -oDiego -cModifiche diego : Compilazione pezzo 0 }
                        with ind.T[0] do
                          begin
                          CodPezzo:=TabCalc^[INDPADRE]^.T[Np].CodPezzo;
                          W:=round(WIN);
                          H:=round(HIN);
                          A_D:=round(DIN);
                          end;
                        //

                      END;
                  END         { if indpadre<>nil then......... }
                ELSE
                  WITH Ind.T[O] DO
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
                INRif := FIND_ARCHIVIO(IND.T[O-1].CodPezzo);
                INSez := UPCASE(ARCHIVIO^[INRif].TipoSez[Dir+1]);
                IF INSez IN ['H', 'A'] THEN INSez := 'R'; { tipo sezione d'ingresso }
                IF INSez = 'D' THEN INSez := 'C';
                Modificabile := (UPCASE(ARCHIVIO^[INRif].TipoSez[Dir+1]) IN ['H', 'A', 'C']);
                IF INSez = 'R' THEN { raccordo con ingresso rettangolare }
                  BEGIN
                    IF Modificabile THEN
                      BEGIN
                        WIN := WOUT; HIN := HOUT;
                        DIN := 0;
                        IF UPCASE(ARCHIVIO^[INRif].TipoSez[Dir+1]) = 'H' THEN HIN := Ind.T[O-1].H;
                      END
                    ELSE
                      BEGIN
                        WITH IND.T[O-1] DO
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
                        WITH IND.T[O-1] DO
                          BEGIN
                            HIN := 0; WIN := 0; DIN := A_D;
                          END;
                      END;
                  END;
                WITH Ind.T[O-1] DO PhiIn := Phi;
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
                    
                      1 : BEGIN
                             Cod := RRett;
                             if Cod[3] = '1' then LungMask:=0.8
                             else
                              begin
                                 if Riduz^.LungRidR <> 0 then LungMask:=Riduz^.LungRidR
                                 else
                                  begin
                                     if Riduz^.AngRidR <> 0 then
                                      begin
                                         if (Riduz^.AngRidR=90) or (Riduz^.AngRidR=-90)  or (Riduz^.AngRidR=270)
                                         then LungMask:=0
                                         else
                                          begin
                                             AngCalc:=Riduz^.AngRidR/180*pi;
                                             Ain:=ROUND(HIN);   Bin:=ROUND(WIN);
                                             Aus:=ROUND(HOUT);  Bus:=ROUND(WOUT);
                                             if (Ain-Aus) > (Bin-Bus) then  LungMask:=((Ain-Aus)/2)/tan(AngCalc/2)*0.001
                                             else  LungMask:=((Bin-Bus)/2)/tan(AngCalc/2)*0.001;
(*                                             gotoxy(1,1);
                                             write(Ain:5:2,' HIN ',Bin:5:2,' WIN ',Aus:5:2,' HOUT ',Bus:5:2,' WOUT  ',
                                             LungMask:8:4);delay(1000); *)
                                          end;
                                      end
                                     else LungMask:=0.8;
                                  end;
                              end;
                          END;
                      2, 12:BEGIN
                               Cod := TRett;
                               LungMask:=0.8;
                               if (Cod[3] <> '1') and (Riduz^.LungRotR > 0) then LungMask:=Riduz^.LungRotR;
                            END;
                      3 : BEGIN
                             Cod := RCirc;
                             if Cod[3] = '1' then LungMask:=0.8
                             else
                              begin
                                 if Riduz^.LungRidC <> 0 then LungMask:=Riduz^.LungRidC
                                 else
                                  begin
                                     if Riduz^.AngRidC <> 0 then
                                      begin
                                         if (Riduz^.AngRidC=90) or (Riduz^.AngRidC=-90)  or (Riduz^.AngRidC=270)
                                         then LungMask:=0
                                         else
                                          begin
                                             AngCalc:=Riduz^.AngRidC/180*pi;
                                             Ain:=ROUND(DIN);   Aus:=ROUND(DOUT);
                                             LungMask:=((Ain-Aus)/2)/tan(AngCalc/2)*0.001;
                                          end;
                                      end
                                     else LungMask:=0.8;
                                  end;
                              end;
                          END;
                      4, 14:BEGIN
                                Cod := VCR;
                                IF DIN = 0 THEN DIN := DOUT;
                                LungMask:=0.8;
                                if (Cod[3] <> '1') and (Riduz^.LungTrasCR > 0) then LungMask:=Riduz^.LungTrasCR;
                              END;
                      5, 15:BEGIN
                                Cod := VRC;
                                IF DIN = 0 THEN DIN := DOUT;
                                LungMask:=0.8;
                                if (Cod[3] <> '1') and  (Riduz^.LungTrasRC > 0 ) then LungMask:=Riduz^.LungTrasRC;
                              END;
                      11 : BEGIN
                              Cod := ARett;
                             if Cod[3] = '1' then LungMask:=0.8
                             else
                              begin
                                 if Riduz^.LungAllR <> 0 then LungMask:=Riduz^.LungAllR
                                 else
                                  begin
                                     if Riduz^.AngAllR <> 0 then
                                      begin
                                         if (Riduz^.AngAllR=90) or (Riduz^.AngAllR=-90)  or (Riduz^.AngAllR=270)
                                         then LungMask:=0
                                         else
                                          begin
                                             AngCalc:=Riduz^.AngAllR/180*pi;
                                             Ain:=ROUND(HIN);   Bin:=ROUND(WIN);
                                             Aus:=ROUND(HOUT);  Bus:=ROUND(WOUT);
                                             if (Aus-Ain) > (Bus-Bin) then  LungMask:=((Aus-Ain)/2)/tan(AngCalc/2)*0.001
                                             else  LungMask:=((Bus-Bin)/2)/tan(AngCalc/2)*0.001;
                                          end;
                                      end
                                     else LungMask:=0.8;
                                  end;
                              end;
                           END;
                      13 : BEGIN
                              Cod := ACirc;
                             if Cod[3] = '1' then LungMask:=0.8
                             else
                              begin
                                 if Riduz^.LungAllC <> 0 then LungMask:=Riduz^.LungAllC
                                 else
                                  begin
                                     if Riduz^.AngAllC <> 0 then
                                      begin
                                         if (Riduz^.AngAllC=90) or (Riduz^.AngAllC=-90)  or (Riduz^.AngAllC=270)
                                         then LungMask:=0
                                         else
                                          begin
                                             AngCalc:=Riduz^.AngAllC/180*pi;
                                             Ain:=ROUND(DIN);   Aus:=ROUND(DOUT);
                                             LungMask:=((Aus-Ain)/2)/tan(AngCalc/2)*0.001;
                                          end;
                                      end
                                     else LungMask:=0.8;
                                  end;
                              end;
                           END;
                    END;


                    Rif := FIND_ARCHIVIO(Cod);
                    WITH IND.T[O] DO
                      BEGIN
                        CodPezzo := Cod;
                        Descr := ARCHIVIO^[Rif].Descr;

                        A_D := ROUND(DIN);
                        H := ROUND(HIN);
                        W := ROUND(WIN);

                        Portata := IND.T[O+1].Portata;
{                        LungMask:=LungMask*1000;
                        LungMask:=Trunc(LungMask);}
                        L:=LungMask;

                      END;
                    O := O+1;
                    N := N+1; { nella tabella c'e` un pezzo in piu` }
                  END;        { if inserimento a buon fine   then ............ }

              END;

          UNTIL O >= N;       { for o:=1 to n do............. }
        END;                  { proc. adatta_sezioni }


        {----------------------------    trova     -------------------------------}
      PROCEDURE Trova(Var IND: LINK;INDPadre:integer;  Dir : INTEGER);
        BEGIN
          IF IND.riga <> 0 THEN
            BEGIN
              WNodo(Ind);
              Adatta_Sezioni(IND, INDPadre, Dir);

              Trova(TabCalc^[IND.Pc]^, IND.riga, 1);
              Trova(TabCalc^[IND.Ps]^, IND.riga, 2);
              Trova(TabCalc^[IND.Pd]^, IND.riga, 3);
            END;
        END;                  { proc. trova }

        {********************   main   of   inserisciriduzioni   *********************}
      BEGIN
        Wfase(w_m(54));{*TR*}
        Trova(TabCalc^[P0]^, 0, 0);
      END;                    { proc. inserisciriduzioni }



      {---------------------------  eliminaadattatori  -----------------------------}
    PROCEDURE EliminaAdattatori;

        {-------------------------------  delete_line  -----------------------------}
      PROCEDURE DELETE_LINE(Var IND : LINK; N : INTEGER);
        VAR
          O, U : INTEGER;
        BEGIN
          U := ULT_LINE(IND);
          FOR O := N TO U-1 DO IND.T[O] := IND.T[O+1];
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
      PROCEDURE Elimina(Var IND : LINK);
        VAR
          I, U, J : INTEGER;
        BEGIN
          U := ULT_LINE(IND);
          I := 1;
          REPEAT
            WITH Ind.T[I] DO
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
      PROCEDURE Trova(Var IND : LINK);
        BEGIN
          IF IND.riga <> 0 THEN
            BEGIN
              WNodo(ind);
              Elimina(IND);
              Trova(TabCalc^[IND.Ps]^);
              Trova(TabCalc^[IND.Pc]^);
              Trova(TabCalc^[IND.Pd]^);
            END;
        END;                  { proc. trova }

        {********************   main   of   eliminaadattatori   *********************}
      BEGIN
        WFase(w_m(55));{*TR*}
        Trova(TabCalc^[P0]^);
      END;                    { proc. eliminaadattatori }

END.
