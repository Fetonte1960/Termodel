unit Minicalc;

interface
uses definiz,utilitie,wincrt,Wm,genproc,angoli,N_disdim,def_win,main_res,ioduct;


Procedure MiniCalcolo;

implementation
uses u_winput,RIDIS_U;

{-----------------------------------------------------------------------------}

{ Tipi e variabili che servono per il funzionamento della procedura
   adatta sezioni , copiate dal calcolo di canali                   }

const
    NCompRamo = 15 {pino31};
    ColRiga=71;
    LTabRamo = {16}Pezzitr; { Modificato solo per questa procedura }
    NPezzi = 260;

type
    st40=string[40];
    st80=string[80];

    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : ST40;
                 CodDis : INTEGER;
                 Main, Branch, Fonte : STRING[8];
                 Varie : STRING[10];
                 TipoSez : ST5;
                 NUscite : INTEGER;
               END;

   T_ARCHIVIO = ARRAY[1..NPezzi] OF RigaArch;


type
    RigaRamo = RECORD
                 CodPezzo : STRING[5];
                 Descr : STRING[40];
                 CHFlag : CHAR;
                 Portata, Perdita : REAL;
                 A_D : INTEGER;
                 H, W, Ang, Phi : INTEGER;
                 L, R, ComVal : REAL;
                 C0, X, Y : REAL;
               END;
    LINK = ^TabRamo;
    TabRamo = RECORD
                T : ARRAY[0..LTabRamo] OF RigaRamo;
                Ps, Pd, Pc : LINK;
                TR : BOOLEAN;
                CodTab : INTEGER;
              END;

    P_ark=ARRAY[1..NPezzi] OF RigaArch;


 VAR
    Sel : BYTE;
    NP : INTEGER;
    Cod : STRING[5];

    ARCHIVIO :^ P_ark;

    P0 : LINK;

    ARett, ACirc, VCR, VRC, RCirc, RRett, TRett : st5;


{------------- copiate  senza modifiche da U_riduz -----------------}
{  Le procedure e funzioni che seguono sono state copiate senza eseguire
   alcuna modifica dal calcolo di canali                                 }





  PROCEDURE INIT_LINE(IND : LINK; Line : INTEGER);
    BEGIN
      WITH IND^.T[Line] DO
        BEGIN
          CodPezzo := ''; Descr := ''; CHFlag := ' ';
          Portata := 0; Perdita := 0;
          A_D := 0; H := 0; W := 0;
          L := 0; R := 0; Ang := 0;
          ComVal := 0;
          X := 0; Y := 0; C0 := 0;
        END;
    END;
 {------------------------------  codtab_form  --------------------------------}
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
      END;
{--------------------------------  ult_line  ---------------------------------}
    FUNCTION ULT_LINE(IND : LINK) : INTEGER;
      VAR
        I : INTEGER;
        FEND : BOOLEAN;
      BEGIN
        FEND := FALSE;
        I := 0;
        REPEAT
          I := I+1;
          IF SETLEFT(IND^.T[I].CodPezzo) = '' THEN
            BEGIN
              I := I-1;
              FEND := TRUE
            END;
        UNTIL FEND OR (I > NCompRamo);
        IF Fend THEN ULT_LINE := I
        ELSE Ult_Line := 0;
      END;                    { func. ult_line }

{-------------------------------------------------------------------------}

    FUNCTION INSERT_LINE(IND : LINK; Posizione : INTEGER) : BOOLEAN;
      VAR
        I, N, O : INTEGER;
        CH : CHAR;
        Ind_1:link; {Q}
        I_1  :integer;

      BEGIN
        I := ULT_LINE(IND);

        IF I = NCompRamo THEN {Q}
          begin

          if (ind^.pc<>nil)and(ind^.pd=nil)and(ind^.ps=nil) then
            begin
            Ind_1:=ind^.Pc;
            I_1:=ULT_LINE(IND_1);

            if I_1=NCompRamo then I:=I+1  { piena anche la seconda }
            else
            FOR N := I_1 DOWNTO 1 DO IND_1^.T[N+1] := IND_1^.T[N];

            end
          else
            begin
            if (Ind=P0)or((Ind^.T[0].CodPezzo<>'')and
                          (Ind^.T[0].CodPezzo[1]<>' ')) then
              begin
              New(ind_1);
              for N :=0 to LTabRamo do INIT_LINE(IND_1, N);

              Ind_1^.pc    :=Ind^.pc;
              Ind_1^.pd    :=Ind^.pd;
              Ind_1^.ps    :=Ind^.ps;
              Ind_1^.CodTab:=Ind^.CodTab;
              ind_1^.Tr    :=ind^.Tr;

              ind^.pc      :=ind_1;
              ind^.pd      :=nil;
              ind^.ps      :=nil;
              end
            else I:=I+1;
            end;

          I:=i-1;
          IF I < NCompRamo THEN Ind_1^.T[1]:=Ind^.T[NCompRamo];

          end;               {Q}

        IF I = NCompRamo THEN
          BEGIN
            {$ifdef win}
            {$else}
            SOUND(100); DELAY(200); NOSOUND;
            {$Endif}
            GOTOXY(1, 22);
            WRITE(W_M(42),' ', CODTAB_FORM(IND^.CodTab));
            {'Spazio insufficiente per inserire un''altra riga nella tabella nø '}
            CLREOL;
            GOTOXY(1, 23); WRITE(W_M(36)); CLREOL; {'Premere un tasto per continuare.'}
            {$ifdef dos}
            READKBD(CH);
            {$endif}
            GOTOXY(1, 22); CLREOL; GOTOXY(1, 23); CLREOL;
            INSERT_LINE := FALSE;
          END
        ELSE
          BEGIN
            IF I >= Posizione THEN
              BEGIN
                FOR N := I DOWNTO Posizione DO IND^.T[N+1] := IND^.T[N];

                INIT_LINE(IND, N);

              END;            { if i>=1 then .......}
            INSERT_LINE := TRUE;
          END;                { else......... }
      END;                    { func.  insert_line }

{-----------------------------------------------------------------------}

 PROCEDURE INIT_ARCHIVIO;
      VAR i : INTEGER;
      BEGIN                   { init tab }
        FOR i := 1 TO NPezzi DO
          WITH Archivio^[i] DO
            BEGIN             { with dato }
              CodPezzo := '';
              Descr := '';
              CodDis := 0;
              Main := ''; Branch := ''; Fonte := '';
              Varie := '';
              TipoSez := '';
              NUscite := 0;
            END;              { with }

      END;

    FUNCTION TRANSFER_ARCHIVIO : INTEGER;
        { Serve per caricare la tabella 'ARCHIVIO.CAN' con le descrizioni relative ai
        codici dei pezzi }
      VAR i : INTEGER;
        F : FILE OF RigaArch;
        IOERR, N : INTEGER;
      BEGIN                   { lettura }
        Init_Archivio;
        ASSIGN(f, DRIVEARC+'archivio.can');
        {$I-} RESET(f);       {$I+}
        IF IORESULT = 0 THEN
          BEGIN
            i := 1;
            WHILE NOT EOF(f) DO
              BEGIN
                READ(f, Archivio^[i]);
                i := i+1;
              END;
            CLOSE(f);
          END;
        Transfer_Archivio := IORESULT;
      END;

FUNCTION FIND_ARCHIVIO(Codice : ST5) : INTEGER;
    VAR
      I, j : INTEGER;
      Trovato : BOOLEAN;
    BEGIN
      Codice:= UPString(Codice);
      Codice:= SetLeft(SetRight(Codice));

      I := 1; Trovato := FALSE;
      WHILE (I <= NPezzi) AND NOT Trovato DO
        BEGIN
           Archivio^[i].CodPezzo:= UPString(Archivio^[i].CodPezzo);
           Archivio^[i].CodPezzo:= SetLeft(SetRight(Archivio^[i].CodPezzo));
           Trovato := (Archivio^[I].CodPezzo = Codice);
           IF NOT Trovato THEN i := i+1;
        END;

      IF NOT Trovato THEN FIND_ARCHIVIO := 0
      ELSE FIND_ARCHIVIO := I;

    END;



        {----------------------------  adatta_sezioni  ---------------------------}
      PROCEDURE ADATTA_SEZIONI(IND, INDPadre : LINK; Dir : INTEGER);
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
          if indpadre<>nil then
            begin
            NP := ULT_LINE(INDPadre);
            IND^.T[0].CodPezzo:=INDPADRE^.T[NP].CodPezzo
            end;

          O := 0;
          REPEAT
            O := O+1;
            { o punta al pezzo di cui si valuta la sezione d'ingresso }

            {------------calcolo misure in out---------------------------------------}
            OUTRif := FIND_ARCHIVIO(IND^.T[O].CodPezzo);
            OUTSez := UPCASE(ARCHIVIO^[OUTRif].TipoSez[1]);
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
                        IF UPCASE(ARCHIVIO^[INRif].TipoSez[Dir+1]) = 'H' THEN HIN := Ind^.T[O-1].H;
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
                    WITH IND^.T[O] DO
                      BEGIN
                        CodPezzo := Cod;
                        Descr := ARCHIVIO^[Rif].Descr;

                        A_D := ROUND(DIN);
                        H := ROUND(HIN);
                        W := ROUND(WIN);

                        Portata := IND^.T[O+1].Portata;
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


{-------------------------------}

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


{***************************  UP_S              *******************************}
 Procedure Up_S(Var St:string);
 var c,i:integer;
 begin
    c := LENGTH(St);
    FOR i := 1 TO c DO
      St[i] := UPCASE(St[i]);
 end;


{***************************  StartConvers     *******************************}
{ Le procedure che seguono sono state copiate dai programmi Convcan e convcan1
  Sono state apportate le seguenti modifiche:
  1:Eliminati i controlli sugli errori.
  2:La variabile TAB1 e' stata sostituita con IND^
  3:E' stata introdotta la variabile Ind                             }


{*****************************************************************************}
Procedure minicalcolo1;
begin
end;

Procedure MiniCalcolo;

var fAr      : file of RigaArch;
    orient,NUsc,UltNodo:integer;
    vrt   :recVert;
    c_Dir,c_DirZ:real;
    CanVert:Boolean;
    Trovato        :Boolean;
    TabErrori:^TErrori;


var cont:integer;
    contat:integer;

    Dim_a,Dim_b,Dim_d:real;
(*
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Scambia        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Scambia(npezzo:integer;Var invers:boolean);

Var Temp:integer;

begin
if invers then
with Tab.T[NPezzo] do
  begin
  Temp:=H;
  H:=W;
  W:=temp;
  end;
end;
  *)
{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Converti     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Type RecDati=Record
     j,k,riga,Main,Br1,Br2:integer;
     Dir,DirZ:array[1..3]of real;
     canc:array[1..Pezzitr]of boolean;
     NewInd:array[1..Pezzitr]of integer;
     Inv_u:RecVert;
     Quota_N:real;
     indTab :integer;
     st_temp:string;
     End;
{
Procedure Num_er(ind,num:integer);
begin
TabErrori^[ind].Descrer:=W_m(num);
end;
}
Procedure Converti(IndPadre:link;tr1:integer;UltNodo:integer;UltDir1:real;
                 Invert:Boolean;MainV_D,MainInv:Boolean;Dir_adatta:integer);

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Scambia        *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Scambia(ind:link;npezzo:integer;Var invers:boolean);

Var Temp:integer;

begin
if invers then
with Ind^.T[NPezzo] do
  begin
  Temp:=H;
  H:=W;
  W:=temp;
  end;
end;
{***************************  InitTab        *******************************}

Procedure InitTab(Var BufCan:TabRamo);

var i:integer;

begin
  for i:=0 to LTabRamo do
  with BufCan.T[i] do
    begin
    CodPezzo :='';
    Descr    :='';
    CHFlag   :=' ';
    Portata  :=0;
    Perdita  :=0;
    A_D      :=0;
    H        :=0;
    W        :=0;
    Ang      :=0;
    Phi      :=0;
    L        :=0;
    R        :=0;
    ComVal   :=0;
    C0       :=0;
    X        :=0;
    Y        :=0;
    end;
with BufCan do
  begin
  ps:=nil;
  pc:=nil;
  pd:=nil;
  tr:=false;
  CodTab:=0;
  end;
end;

{---------------------------------------------------------------------}

Var P_dati:^recdati;
    Ind:link;
    i:integer;
    inverti:Boolean;

{*-*-*-*-*-*-*-*-*-*-*-*-*-*  Copia         *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Copia1(npezzo,NP:integer;invers:boolean);

{--------------------------------  SETright  ----------------------------------}
FUNCTION SETRIGHT(ST:STRING):STRING;
VAR
  I:INTEGER;
BEGIN
  I:=LENGTH(ST);
  while (I > 1) and (ST[i] = ' ') do i:=i-1;
  if i = 1 then
   begin
     if st[i] = ' ' then i:=0;
   end;

  if i = 0 then SetRight:=''
  else SETRIGHT:=COPY(ST,1,I);

END;     { FUNC. SETRIGHT }

Var i:integer;

begin
with ind^.T[npezzo] do
  begin
  VPezzi^[NP]^.Codice :=setright(CodPezzo);
  if VPezzi^[NP]^.Codice='' then VPezzi^[NP]^.Codice :='     ';
  VPezzi^[NP]^.Flag   :=CHFlag;
  VPezzi^[NP]^.Port   :=Portata;
  VPezzi^[NP]^.Perd   :=Perdita;
  VPezzi^[NP]^.R      :=A_D;

  if invers then
    begin
    VPezzi^[NP]^.B      :=W;
    VPezzi^[NP]^.A      :=H;
    end
  else
    begin
    VPezzi^[NP]^.B      :=H;
    VPezzi^[NP]^.A      :=W;
    end;

  VPezzi^[NP]^.Ang    :=Ang;
  VPezzi^[NP]^.Lung   :=L;
  VPezzi^[NP]^.Rag    :=R;
  VPezzi^[NP]^.Varie  :=ComVal;
  {writeln(phi);}
  end;
end;


 {*-*-*-*-*-*-*-*-*-*-*-*-*-*  Trascrivi     *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}
{***************************  Canale     *****************************}

Function Canale(Cod:string):Boolean;

begin
Canale:=False;
Cod :=UPstring(Cod);
while length(Cod)<5 do Cod:=Cod+' ';
if (Cod='310R ')or(Cod='310C ')or(Cod='     ') then Canale:=true;
end;

{***************************  Vuoto     *****************************}

Function Vuota(Cod:string):Boolean;

begin
Vuota:=False;
Cod :=setleft(Cod);
if Cod='' then Vuota:=true;
end;




{---------------------------------------------------------------------------}
{  Procedura copiata dal programma convcan1 con piccole modifiche  }

Procedure Trascrivi(tr:integer;Var Main_vd,MainInv:boolean;Var Ultdir:real;var Inverti:boolean);

var i,j,k:integer;

    Temp,Temp1:Array[1..Pezzitr] of Integer;
    TempCod,TempCod1:STring[5];
    uguale,trovato:boolean;
    ultp,ultTrov:integer;

begin
for i:=1 to PezziTR do
  begin
  Temp1[i]:=0;
  Temp[i]:=0;
  end;


if Dati^[tr]^.Pezzi[0]=0 then  Dati^[tr]^.Pezzi[0]:=NewPezzo;
if Dati^[tr]^.Pezzi[0]=0 then
  begin
  {stMes:=W_M(140);
  Fat_Er(false);}
  end;
{'Non c`e spazio per inserire gli adattamenti e le serrande',false);}
InitPezzo(VPezzi^[Dati^[tr]^.Pezzi[0]]^);
{fillchar(VPezzi^[Dati^[tr]^.Pezzi[0]]^,sizeof(VPezzi^[Dati^[tr]^.Pezzi[0]]^),0);}

if tr<>RisultCalc^.Origine then
  begin
  if Main_VD then Copia1(0,Dati^[tr]^.Pezzi[0],MainInv)
  else Copia1(0,Dati^[tr]^.Pezzi[0],inverti);
  end;


{writeln(lst,VPezzi^[Dati^[tr].Pezzi[0]].Codice,' ',Inverti);}
{writeln(lst,Dati^[tr].Num);}

k:=dati^[tr]^.ti;  {-- Cerca i pezzi collegati col disegno --}
UltTrov:=0;
repeat
if dis^[k]^.Npezzo<>0 then
  begin

  TempCod:=VPezzi^[Dati^[tr]^.Pezzi[dis^[k]^.Npezzo]]^.Codice;
  TempCod :=UPstring(TempCod);
  while length(TempCod)<5 do TempCod:=TempCod+' ';

  i:=UltTrov+1;
  trovato:=false;
  if i<=Pezzitr then
    repeat

    TempCod1:=UPString(Ind^.T[i].CodPezzo);
    while length(TempCod1)<5 do TempCod1:=TempCod1+' ';

    if (TempCod1=TempCod) Then
      begin
      if i=Pezzitr then
        begin
        dis^[k]^.Npezzo:=i;
        trovato:=true;
        Ulttrov:=i;
        end
      else
        begin

        if Canale(Ind^.T[i+1].CodPezzo)or(Ind^.T[i].Descr='') then
          begin
          if (Canale(Ind^.T[i-1].CodPezzo))or(vuota(Ind^.T[i+1].CodPezzo))or
             (Ind^.T[i].Descr='') then
            begin
            dis^[k]^.Npezzo:=i;
            trovato:=true;
            Ulttrov:=i;
            end;
          end
        end;
      end;

    i:=i+1;
    until (trovato)or(i>Pezzitr);

{  writeln(lst,trovato,':',dis^[k].Npezzo);}

  if not trovato then
    begin
    if dis^[k]^.Rid<>'' then
      begin
      dis^[k]^.Rid:='';
      dis^[k]^.NPezzo:=0;
      end
    else
      begin
      clrscr;
      gotoxy(5,10);
      writeln(W_M(141)+' ',Dati^[tr]^.num,' ',W_M(142),tempcod,W_M(143));
      {'Nodo ',Dati^[tr].num,': irregolarita sulla conversione, pezzo "',tempcod,'" mancante ');}
      repeat until keypressed;
      halt;
      end;
    end;
  end;

k:=dis^[k]^.NLinea;
until k=0;

i:=0;     {-- Rende della stessa lunghezza le tabelle e copia --}
repeat
i:=i+1;

Ind^.T[i].CodPezzo:=setleft( Ind^.T[i].CodPezzo);


if (Ind^.T[i].CodPezzo<>'')and(Dati^[tr]^.Pezzi[i]=0) then
  begin
  Dati^[tr]^.Pezzi[i]:=NewPezzo;
  if Dati^[tr]^.Pezzi[i]=0 then
    begin
    {W_M(140);
    Fat_Er(false);}
    end;
  {'Non c`e spazio per inserire gli adattamenti e le serrande',false);}
  end;


if (Ind^.T[i].CodPezzo<>'') then Copia1(i,Dati^[tr]^.Pezzi[i],False);

if (Ind^.T[i].CodPezzo='')and(Dati^[tr]^.Pezzi[i]<>0) then
  begin
  Vpezzi^[Dati^[tr]^.Pezzi[i]]^.Codice:='';
  Dati^[tr]^.Pezzi[i]:=0;
  end;

{
if Dati^[tr].Pezzi[i]<>0 then writeln(lst,VPezzi^[Dati^[tr].Pezzi[i]].codice);
}

until(i=Pezzitr);


if (tr1=1)and(dati^[1]^.pezzi[1]=0)then
  begin
  i:=i;
  end;

ultp:=0;
i:=Dati^[tr]^.Ti;

{writeln(lst,'prima',inverti,' UltDir:',Ultdir:3:2);}

Repeat
if Dis^[i]^.Npezzo<>0 then
  begin
  {Dis^[i].Npezzo:=Temp[Dis^[i].Npezzo];}
  For ultp:=Ultp+1 to Dis^[i]^.Npezzo-1 do Scambia(ind,Dati^[tr]^.Pezzi[Ultp],Inverti);
  if Dis^[i]^.Nlinea<>0 then
  CalcDirez1(i,Dis^[i]^.Nlinea,C_Dir,C_DirZ,UltDir,true,CanVert,Inverti)
  else Scambia(ind,Dati^[tr]^.Pezzi[Dis^[i]^.NPezzo],Inverti);
  {writeln(lst,VPezzi^[Dati^[tr].Pezzi[Dis^[i].NPezzo]].Codice,' ',Inverti,' UltDir:',Ultdir:3:2);}
  end;

CalcDirez(i,C_dir,C_DirZ);
if abs(abs(C_dirz)-Pi/2)>0.1 then UltDir:=C_dir;

i:=Dis^[i]^.NLinea;
until i=0;

end;

{-----------------------------------------------------------------------------------------------------}

begin
inverti:=false;
New(Ind);
New(P_dati);
with P_dati^ do
begin


CanVert:=False;
For i:=1 to 3 Do Inv_U[i]:=false;

i:=Dati^[tr1]^.Ti;
Repeat
if Dis^[i]^.NLinea<>0 then i:=Dis^[i]^.NLinea;
until Dis^[i]^.NLinea=0;
Quota_N:=Dis^[i]^.Z2*Conf^.altNum/40000;

NUsc:=0;

if Dati^[tr1]^.pros[2]<>0 then

  begin

  if dati^[tr1]^.pros[3]=0 then  {--- TEE ----}
    begin
    Nusc:=2;
    end

  else          {---- CROCE  ---}

    begin
    nusc:=3
    end;

  end;


For i:=1 to Pezzitr do
  begin
  Canc[i]:=true;
  NewInd[i]:=0;
  end;

   {-- Serve in Caso Di errore --}

Main:=0;
Br1:=0;
Br2:=0;
if Dati^[tr1]^.Pros[1]<>0 then Main:=1;
if Dati^[tr1]^.Pros[2]<>0 then Br1 :=2;
if Dati^[tr1]^.Pros[3]<>0 then Br2 :=3;

InitTab(Ind^);

 {-- Copia pezzo 0 --}

if Dati^[tr1]^.Pezzi[0]<>0 then
with Ind^.T[0] do
    begin
    St_temp :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Codice;
    Up_S(St_temp);
    CodPezzo:=St_temp;
    if VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Flag<>'' then
    CHFlag   :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Flag[1];
    Portata  :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Port;
    Perdita  :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Perd;
    A_D      :=round(VPezzi^[Dati^[tr1]^.Pezzi[0]]^.R);
    H        :=round(VPezzi^[Dati^[tr1]^.Pezzi[0]]^.B);
    W        :=round(VPezzi^[Dati^[tr1]^.Pezzi[0]]^.A);
    if (W=0)and(h=0)and(a_D=0) then
      begin
      A_D:=round(Dim_d);
      w:=round(Dim_a);
      h:=round(Dim_b);
      end;
    Ang      :=round(VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Ang);
    L        :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Lung;
    R        :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Rag;
    ComVal   :=VPezzi^[Dati^[tr1]^.Pezzi[0]]^.Varie;
    C0       :=0;
    X        :=0;
    Y        :=0;
    end;


if tr1<>RisultCalc^.Origine then
  begin
  if MainV_D then Scambia(ind,0,MainInv)
  else Scambia(ind,0,invert);
  end;

indTab:=0;
for i:=1 to pezzitr Do
if Dati^[tr1]^.Pezzi[i]<>0 then
  begin

  indTab:=indTab+1;

    {- Serve piu di una tabella -}

  if IndTab>=LTabRamo then
    begin
    contat:=contat+1;
    Ind^.CodTab:=Contat;
    Ind^.Pc:=P0;
    {Write(Fcan,Tab);}
    InitTab(Ind^);
    IndTab:=1;
    end;

  Main:=0;
  Br1:=0;
  Br2:=0;

  trovato:=false;

  k:=Dati^[tr1]^.Ti;

  repeat
  if dis^[k]^.NPezzo=i then trovato:=true;
  if not trovato then k:=dis^[k]^.Nlinea;
  until (trovato) or (k=0);

  if trovato then
    begin

    Ind^.T[indtab].Phi:=0;

    if (NUsc>1)and(trovato)and(dis^[k]^.NLinea=0) then
      begin


      SETBRANCH(k,Nusc,Main,Br1,Br2,Orient,Vrt,UltDir1,Invert,inv_U,MainV_D);

      CalcDirez(k,C_dir,C_DirZ);
      if abs(abs(C_dirz)-Pi/2)>0.1 then UltDir1:=C_dir;

      if ( ( (orient IN [2,4]) or ((orient IN[ 5,6])and(inv_U[br1]=Invert))
           )and(not(invert))
         )or
         (
           ( not((orient IN [2,4])or((orient IN[ 5,6])and(inv_U[br1]=Invert)))
           )
           and(invert)
         )
      then Ind^.T[indtab].Phi:=90;


               {-- Inverte l`ingresso degli stacchi --}

      MainInv:=Invert;

      J:=0;
      Repeat
      J:=J+1;
      if invert<>Inv_U[J] then
        begin
        MainInv:=Not(mainInv);
        Invert:=Not(Invert);
        end;
      Until (invert<>Inv_U[J])or(J=NUsc);

      end

    else
      begin
      Br1:=Dis^[k]^.Nlinea;
      if dis^[k]^.NLinea<>0 then
      CalcDirez1(k,Dis^[k]^.Nlinea,C_Dir,C_DirZ,UltDir1,true,CanVert,Invert);
      end

    end

  else Ind^.T[indtab].Phi:=0;

  {writeln(lst,Tab.T[indtab].Phi);}

  with Ind^.T[indtab] do
    begin
    St_temp :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Codice;
    Up_S(St_temp);
    CodPezzo:=St_temp;
    (*==>CodPezzo :=UpString(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Codice);*)
    if VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Flag<>'' then
    CHFlag   :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Flag[1];
    Portata  :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Port;
    Perdita  :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Perd;
    A_D      :=round(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.R);
    H        :=round(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.B);
    W        :=round(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.A);
    if (W=0)and(h=0)and(a_D=0) then
      begin
      A_D:=round(Dim_d);
      w:=round(Dim_a);
      h:=round(Dim_b);
      end;
    Ang      :=round(VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Ang);
    L        :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Lung;
    R        :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Rag;
    ComVal   :=VPezzi^[Dati^[tr1]^.Pezzi[i]]^.Varie;
    C0       :=0;
    X        :=0;
    Y        :=0;
    end;

  Scambia(Ind,indtab,invert);

  (*
    {-- Controllo errori --}

  if i < pezzitr then
   begin
      if Dati^[tr1]^.Pezzi[i+1] <> 0 then
        Controlla(i,Tab.T[indtab],1,UltNodo,Contat+1,Quota_N)
      else Controlla(i,Tab.T[indtab],NUsc,UltNodo,Contat+1,Quota_N)
   end
  else Controlla(i,Tab.T[indtab],NUsc,UltNodo,Contat+1,Quota_N)
  *)

  end;


 {-- Controllo errori --}
(*
if Dati^[tr1]^.Pezzi[1]=0 then
 with TabErrori^[IndErr] do
  begin
     DaNodo:=UltNodo;  Anodo:=Contat+1;
     Quota:=Quota_N;   NPezzo:=0;
     Num_er(IndErr,138);
     {====> DescrEr:=W_M(138);}
    { 'TABELLA RAMO VUOTA';}
     IndErr:=IndErr+1;
  end;
*)

if Main<>0 then Ind^.Pc:=p0;
if Br2<>0 then  Ind^.Ps:=p0;
if Br1<>0 then  Ind^.Pd:=p0;

if (br2=0)and(br1<>0)then
  begin
  Ind^.pd:=nil;
  Ind^.ps:=P0;
  end;

contat:=contat+1;
dati^[tr1]^.Num:=Contat;
Ind^.CodTab:=Contat;
{Write(Fcan,Tab);}

UltNodo:=Contat;
ELIMINA(IND);
ADATTA_SEZIONI(ind,indpadre,Dir_adatta);

dir_adatta:=1;
if Main<>0 then
  begin
  Converti(ind,Dati^[tr1]^.pros[Main],UltNodo,UltDir1,Inv_u[Main],MainV_D,MainInv,1);
  Inc(dir_adatta);
  end;
if Br2 <>0 then
  begin
  Converti(ind,Dati^[tr1]^.pros[Br2 ],UltNodo,UltDir1,Inv_u[Br2 ],MainV_D,MainInv,dir_adatta);
  Inc(dir_adatta);
  end;
if Br1 <>0 then
  begin
  Converti(ind,Dati^[tr1]^.pros[Br1 ],UltNodo,UltDir1,Inv_u[Br1 ],MainV_D,MainInv,dir_adatta);
  end;
Trascrivi(tr1,Mainv_d,MainInv,Ultdir1,inverti);

end;
dispose(P_dati);
Dispose(ind);
end;
begin
   Dim_a:=a_pezzo^.Nreal;
   Dim_b:=b_pezzo^.Nreal;
   Dim_d:=a_pezzo^.Nreal;
   if (Dim_a=0)and(dim_b=0)and(dim_d=0) then
     begin
     Dim_D:=500;
     Dim_a:=500;
     Dim_b:=500;
     end;
   Interf(1,0,0,0,'A',0);{*TR*}
   Interf(2,0,0,0,'0',0);
   Interf(3,0,0,0,'0',0);
   scelta:=11;
   Esegui_com(scelta);
   {-------------------}

   archivio:=nil;
   {TRANSFER_RIDUZIONI(DRIVEARC+'Riduzioni.ark','L');}
   RRett:=Riduz^.CodRidR;
   RCirc:=Riduz^.CodRidC;
   RCirc:=Riduz^.CodRidC;
   ARett:=Riduz^.CodAllR;
   ACirc:=Riduz^.CodAllC;
   TRett:=Riduz^.CodRotR;
   VCR:=Riduz^.CodTrasCR;
   VRC:=Riduz^.CodTrasRC;
   New(archivio);
   Transfer_archivio;
   Contat:=0;
   P0:=nil;
   if RisultCalc^.Origine<>0 Then
   Converti(P0,RisultCalc^.Origine,UltNodo,NotVert,False,false,false,1);

   (*else
   with TabErrori^[IndErr] do
     begin
     DescrEr:=W_M(138);
     {'Non esiste il disegno unifilare ';}
     IndErr:=IndErr+1;
     end;*)

   Dispose(archivio);

   Main_dim;

   EL_WIN[1].RIDIS_W:=TRUE;
   RIDIS;
   EL_WIN[1].RIDIS_W:=FALSE;
end;

end.

