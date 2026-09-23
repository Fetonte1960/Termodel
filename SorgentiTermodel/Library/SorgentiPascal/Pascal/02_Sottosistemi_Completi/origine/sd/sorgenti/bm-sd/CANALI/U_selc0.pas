{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit U_selC0;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  utilitie,
  definizcan,
  U_funz,
  U_canfst,
  WM;

FUNCTION SelectC0(Var IND : LINK; N : INTEGER) : REAL;

{===========================================================================}

Implementation

      {-------------------------------  selectc0  ----------------------------------}
    FUNCTION SelectC0(VAR IND : LINK; N : INTEGER) : REAL;
      CONST
        Ka : ARRAY[1..11] OF REAL = (0, 20, 30, 45, 60, 75, 90, 110, 130, 150, 180);
        Kt : ARRAY[1..11] OF REAL = (0, 0.31, 0.45, 0.6, 0.78, 0.9, 1, 1.13, 1.2, 1.28, 1.4);
        Kb : ARRAY[1..9] OF REAL = (1, 2, 3, 4, 6, 8, 10, 14, 32767);
        Kr : ARRAY[1..9] OF REAL = (1.4, 1.26, 1.19, 1.14, 1.09, 1.06, 1.04, 1.0, 1.0);
      VAR
        NUscite, Cod, IOERR, Alfa1, Alfa2 : INTEGER;
        C1, C2, C3, C4 : REAL;
        C0c, C0s, C0d : REAL;
        Xc, Yc, Xs, Ys, Xd, Yd : REAL;
        xxx : TEXT;
        X, Y : REAL;
        Ch, CH1, CH2 : CHAR;
        r : REAL;
        Temp, TTipo : INTEGER;

      PROCEDURE AngoliX(Var Ind : link; N : INTEGER; VAR Alfa1, Alfa2 : INTEGER);
        VAR
          Lun : REAL;
          Ang1, Ang2, WIN, HIN, DIN, WOUT, HOUT, DOUT : INTEGER;
        BEGIN
          IF Ind.T[n].CodPezzo[3] = '1' THEN Ind.T[n].L := 0.800
          ELSE IF Ind.T[n].CodPezzo[3] = '2' THEN Ind.T[n].L := 1.000;
          Lun := Ind.T[n].L*1000;
          WIN := Ind.T[n].W; HIN := Ind.T[n].H; DIN := Ind.T[n].A_D;

          WOUT := Ind.T[n+1].W; HOUT := Ind.T[n+1].H; DOUT := Ind.T[n+1].A_D;

          Ang1 := 0;
          IF Lun = 0 THEN
            BEGIN
              Alfa1 := 180;
              Alfa2 := 180;
            END
          ELSE
            BEGIN
              IF WIN > WOUT THEN
                BEGIN
                  Alfa1 := ABS(TRUNC((180/PI)*ARCTAN((WIN-WOUT)/Lun)));
                  Alfa2 := ABS(TRUNC((180/PI)*ARCTAN((HIN-HOUT)/Lun)));
                END
              ELSE
                BEGIN
                  Alfa2 := ABS(TRUNC((180/PI)*ARCTAN((WIN-WOUT)/Lun)));
                  Alfa1 := ABS(TRUNC((180/PI)*ARCTAN((HIN-HOUT)/Lun)));
                END;
            END;
        END;



      FUNCTION SceltaAngolo(Var Ind : link; N : INTEGER) : INTEGER;
        VAR
          Temp, Lun : REAL;
          Ang1, Ang2, WIN, HIN, DIN, WOUT, HOUT, DOUT : INTEGER;
        BEGIN
          IF Ind.T[n].L = 0 THEN
            BEGIN
              IF Ind.T[n].CodPezzo[3] = '1' THEN Ind.T[n].L := 0.800
              ELSE IF Ind.T[n].CodPezzo[3] = '2' THEN Ind.T[n].L := 1.000;
            END;

          Lun := Ind.T[n].L*1000;

          WIN := Ind.T[n].W; HIN := Ind.T[n].H; DIN := Ind.T[n].A_D;

          WOUT := Ind.T[n+1].W; HOUT := Ind.T[n+1].H; DOUT := Ind.T[n+1].A_D;

          Ang1 := 0;
          IF Lun = 0 THEN Ang1 := 180
          ELSE
            BEGIN
              IF Cod > 0 THEN
                BEGIN
                  IF UPCASE(Archivio^[Cod].TipoSez[1]) IN ['A', 'R', 'H'] THEN
                    BEGIN
                      IF UPCASE(Archivio^[Cod].TipoSez[2]) IN ['A', 'R', 'H'] THEN {rett/rett}
                        BEGIN
                          Ang1 := ABS(TRUNC((180/PI)*ARCTAN((WIN-WOUT)/Lun)));
                          Ang2 := ABS(TRUNC((180/PI)*ARCTAN((HIN-HOUT)/Lun)));
                          IF Ang2 > Ang1 THEN Ang1 := Ang2; { sceglie l'angolo maggiore }
                        END
                      ELSE    {rett/circ}
                        BEGIN
                          Temp := SQRT(HIN*1.0*WIN*1.0);
                          Temp := 114.65*ARCTAN((DOUT-1.13*Temp)/(2*Lun));
                          Ang1 := TRUNC(ABS(Temp));
                        END;
                    END
                  ELSE
                    BEGIN
                      IF UPCASE(Archivio^[Cod].TipoSez[2]) IN ['A', 'R', 'H'] THEN {circ/rett}
                        BEGIN
                          Temp := SQRT(HOUT*1.0*WOUT*1.0);
                          Temp := 114.65*ARCTAN((1.13*Temp-DIN)/(2*Lun));
                          Ang1 := TRUNC(ABS(Temp));
                        END
                      ELSE    {circ/circ}
                        Ang1 := ABS(TRUNC((180/PI)*ARCTAN((DIN-DOUT)/Lun)));
                    END;
                END;
            END;

          SceltaAngolo := Ang1;
        END;



        {------------------  kadj  ------------------}
      FUNCTION KAdj(Ang : INTEGER) : REAL;
        VAR I : INTEGER;
        BEGIN
          I := 1; WHILE (Ka[I] < Ang) AND (I < 11) DO I := I+1;
          IF I <= 11 THEN KAdj := Kt[I] ELSE KAdj := 0;
        END;                  { func.  kadj }


        {-------------------  kre  ------------------}
      FUNCTION KRe(V : REAL) : REAL;
        VAR I : INTEGER;
        BEGIN
          I := 1; WHILE (Kb[I] < V) AND (I < 9) DO I := I+1;
          KRe := Kr[I];
        END;                  { func.  kre }

        {----------------  setc0  -------------------}
      PROCEDURE SETC0(Var IND : LINK; Cod, D : INTEGER; C, Xu, Yu : REAL);
        VAR
          O : INTEGER;
          PUN : LINK;
          Fl : CHAR;
        BEGIN

          CASE D OF
            1 : PUN := TabCalc^[IND.Pc]^;
            2 : PUN := TabCalc^[IND.Ps]^;
            3 : PUN := TabCalc^[IND.Pd]^;
          END;

          Fl := Archivio^[Cod].TipoSez[D+1];
          IF Fl IN ['A', 'H', 'R'] THEN Fl := 'R'
          ELSE Fl := 'C';

          IF PUN.riga <> 0 THEN
            BEGIN
              PUN.T[0].C0 := C;
              PUN.T[0].X := Xu;
              PUN.T[0].Y := Yu;

              O := NCompRamo;
              WHILE (SETLEFT(IND.T[O].CodPezzo) = '') AND (O > 1) DO O := O-1;
              PUN.T[0].Descr := IND.T[O].CodPezzo;
              PUN.T[0].CodPezzo := IND.T[O].CodPezzo;

              PUN.T[0].A_D := PUN.T[1].A_D; { .. inserimento diametro .. }

              PUN.T[0].H := PUN.T[1].H; { .. inserimento h .. }
              PUN.T[0].W := PUN.T[1].W; { .. inserimento w .. }

              IF Fl = 'R' THEN
                WITH PUN.T[0] DO IF (H+W <> 0) THEN
                  A_D := TRUNC(1.3*Elev(1.0*H*W, 0.625)/Elev(H+W, 0.25))
              ELSE
                BEGIN
                  PUN.T[0].W := 0;
                  PUN.T[0].H := 0;
                END;


              PUN.T[0].Portata := IND.T[O].Portata;
              CASE D OF
                1 : PUN.T[0].Descr := '>> MAIN << '+PUN.T[0].Descr;
                2, 3:PUN.T[0].Descr := '>>BRANCH<< '+PUN.T[0].Descr;
              END;
            END;
        END;                  { proc.  setc0 }

Procedure Caso36;
begin
WITH IND.T[N] DO
  begin
  { seleziona il c0 per il primo taglio x=a1/a0 e y=b/d0 }
  IF A_D <> 0 THEN
    begin
    if Ind.T[N+1].H<>0 then
    Yc := (Ind.T[N+1].H-Spa)/(A_D-Spa)
    else Yc := (sqrt(CalcArea(IND, N+1))-Spa)/(A_D-Spa);{ Nuovi pezzi 9-6-93 }
    end;
  C1 := CalcArea(IND, N);
  IF C1 <> 0 THEN
  Xc := CalcArea(IND, N+1)/C1;
  C0c := Interpola(Xc, Yc);
  end;
end;

procedure caso600;
begin
  WITH IND.T[N] DO
  begin
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  xc:=1;
  IF calcvel(ind, n) <> 0 THEN Yc := CalcVel(IND, n)/CalcVel(IND, N-1);
  C0c := Interpola(Xc, Yc);
  end;
end;

procedure caso601;
begin
  WITH IND.T[N] DO
  begin
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN Xs := TabCalc^[IND.PS]^.T[1].Portata/Portata;
  IF calcvel(ind, n) <> 0 THEN Ys := CalcVel(TabCalc^[IND.Ps]^, 1)/CalcVel(IND, N);
  C0s := Interpola(Xs, Ys);
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN Xc := TabCalc^[IND.PC]^.T[1].Portata/Portata;;
  IF calcvel(ind, n) <> 0 THEN Yc := CalcVel(TabCalc^[IND.Pc]^, 1)/CalcVel(IND, N);
  C0c := Interpola(Xc, Yc);
  end;
end;

procedure caso602;
begin
  WITH IND.T[N] DO
  begin
  IF IND.Pc <> 0 THEN C1 := CalcVel(TabCalc^[IND.Pc]^, 1) ELSE C1 := 0;
  C2 := CalcVel(IND, N);
  IF C2 <> 0 THEN Xc := C1/C2;
  C0c := Interpola(Xc, Yc);
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].branch);
  IF portata <> 0 THEN Xs := TabCalc^[IND.PS]^.T[1].Portata/Portata;
  IF calcvel(ind, n) <> 0 THEN Ys := CalcVel(TabCalc^[IND.Ps]^, 1)/CalcVel(IND, N);
  C0s := Interpola(Xs, Ys);
  IOERR := TRANSFER_TAB(Archivio^[Cod].branch);
  IF portata <> 0 THEN Xd := TabCalc^[IND.Pd]^.T[1].Portata/Portata;;
  IF calcvel(ind, n) <> 0 THEN Yd := CalcVel(TabCalc^[IND.Pd]^, 1)/CalcVel(IND, N);
  C0d := Interpola(Xd, Yd);
  end;
end;
procedure caso603;
begin
  WITH IND.T[N] DO
  begin
  IF IND.Pc <> 0 THEN C1 := CalcVel(TabCalc^[IND.Pc]^, 1) ELSE C1 := 0;
  C2 := CalcVel(IND, N);
  IF C2 <> 0 THEN Xc := C1/C2;
  C0c := Interpola(Xc, Yc);
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].branch);
  IF calcvel(ind, n) <> 0 THEN xs := CalcVel(TabCalc^[IND.Ps]^, 1);
  xs:=xs/c2;
  ys:=0;
  C0s := Interpola(Xs, Ys);
  IOERR := TRANSFER_TAB(Archivio^[Cod].branch);
  IF calcvel(ind, n) <> 0 THEN xd := CalcVel(TabCalc^[IND.Pd]^, 1);
  xd:=xd/c2;
  yd:=0;
  C0d := Interpola(Xd, Yd);
  end;
end;

Procedure Caso604;
begin
WITH IND.T[N] DO
  begin
  { seleziona il c0 per il primo taglio x=a1/a0 e y=b/d0 }
  IF A_D <> 0 THEN
    begin
    if TabCalc^[Ind.pc]^.t[N].H<>0 then
    Yc := (TabCalc^[Ind.pc]^.T[N].H-Spa)/(A_D-Spa)
    else Yc := (sqrt(CalcArea(TabCalc^[IND.pc]^, 1))-Spa)/(A_D-Spa);{ Nuovi pezzi 9-6-93 }
    end;
  C1 := CalcArea(IND, N);
  IF C1 <> 0 THEN
  Xc := CalcArea(TabCalc^[IND.pc]^, 1)/C1;
  C0c := Interpola(Xc, Yc);
  { seleziona il c0 per il primo taglio x=a1/a0 e y=b/d0 }
  IF A_D <> 0 THEN
    begin
    if TabCalc^[Ind.ps]^.t[N].H<>0 then
    Ys := (TabCalc^[Ind.ps]^.T[N].H-Spa)/(A_D-Spa)
    else Ys := (sqrt(CalcArea(TabCalc^[IND.ps]^, 1))-Spa)/(A_D-Spa);{ Nuovi pezzi 9-6-93 }
    end;
  C1 := CalcArea(IND, N);
  IF C1 <> 0 THEN
  Xs := CalcArea(TabCalc^[IND.ps]^, 1)/C1;
  C0s := Interpola(Xc, Yc);

  end;
end;

procedure caso605;
begin
  WITH IND.T[N] DO
  begin
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN Xs := TabCalc^[IND.PS]^.T[1].Portata/Portata;
  IF calcarea(ind, n) <> 0 THEN Ys := Calcarea(TabCalc^[IND.Ps]^, 1)/CalcArea(IND, N);
  C0s := Interpola(Xs, Ys);
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN Xc := TabCalc^[IND.PC]^.T[1].Portata/Portata;;
  IF calcarea(ind, n) <> 0 THEN Yc := Calcarea(TabCalc^[IND.Pc]^, 1)/CalcArea(IND, N);
  C0c := Interpola(Xc, Yc);
  end;
end;



procedure caso606;
begin
  WITH IND.T[N] DO
  begin
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN Xs := TabCalc^[IND.PS]^.T[1].Portata/Portata;
  Ys := Calcvel(TabCalc^[IND.Ps]^, 1);
  C0s := Interpola(Xs, Ys);
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN Xc := TabCalc^[IND.PC]^.T[1].Portata/Portata;;
  Yc := CalcVel(TabCalc^[IND.Pc]^, 1);
  C0c := Interpola(Xc, Yc);
  end;
end;

procedure caso607;
begin
  WITH IND.T[N] DO
  begin
  IF portata <> 0 THEN xc := TabCalc^[IND.PC]^.T[1].Portata/Portata;;
  yc:=0;
  C0c := Interpola(Xc, Yc);
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
  IF portata <> 0 THEN Xs := TabCalc^[IND.PS]^.T[1].Portata/Portata;
  Ys := Calcvel(TabCalc^[IND.Ps]^, 1);
  C0s := Interpola(Xs, Ys);
  IOERR := TRANSFER_TAB(Archivio^[Cod].branch);
  IF portata <> 0 THEN Xd := TabCalc^[IND.PD]^.T[1].Portata/Portata;;
  Yd := CalcVel(TabCalc^[IND.Pd]^, 1);
  C0d := Interpola(Xd, Yd);
  end;
end;

procedure caso608;
begin
  WITH IND.T[N] DO
  begin
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN Xc := TabCalc^[IND.PC]^.T[1].Portata/Portata;;
  IF calcarea(ind, n) <> 0 THEN Yc := Calcarea(TabCalc^[IND.Pc]^, 1)/CalcArea(IND, N);
  C0c := Interpola(Xc, Yc);
  IOERR := TRANSFER_TAB(Archivio^[Cod].branch);
  IF portata <> 0 THEN Xs :=TabCalc^[ IND.PS]^.T[1].Portata/Portata;
  IF calcarea(ind, n) <> 0 THEN Ys := Calcarea(TabCalc^[IND.Ps]^, 1)/CalcArea(IND, N);
  C0s := Interpola(Xs, Ys);
  IOERR := TRANSFER_TAB(Archivio^[Cod].branch);
  IF portata <> 0 THEN Xd := TabCalc^[IND.Pd]^.T[1].Portata/Portata;
  IF calcarea(ind, n) <> 0 THEN Yd := Calcarea(TabCalc^[IND.Pd]^, 1)/CalcArea(IND, N);
  C0d := Interpola(Xd, Yd);
  end;
end;
procedure caso609;
begin
  WITH IND.T[N] DO
  begin
 { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN ys := TabCalc^[IND.PS]^.T[1].Portata/Portata;
  IF calcarea(ind, n) <> 0 THEN Xs := Calcarea(TabCalc^[IND.Ps]^, 1)/CalcArea(IND, N);
  C0s := Interpola(Xs, Ys);
  IOERR := TRANSFER_TAB(Archivio^[Cod].main);
  IF portata <> 0 THEN Yc := TabCalc^[IND.PC]^.T[1].Portata/Portata;;
  IF calcarea(ind, n) <> 0 THEN Xc := Calcarea(TabCalc^[IND.Pc]^, 1)/CalcArea(IND, N);
  C0c := Interpola(Xc, Yc);
  end;
end;

        {----------------------   main  of  selectc0    ------------------}
      BEGIN
        Cod := FIND_ARCHIVIO(IND.T[N].CodPezzo);
        IF Cod = 0 THEN TTipo := 0
        ELSE
          BEGIN
            IF Archivio^[Cod].Main <> 'P' THEN
              BEGIN
                IOERR := TRANSFER_TAB(Archivio^[Cod].Main);
                TTipo := RecC0.Tipo;
              END
            ELSE TTipo := 0;
          END;
        c3 := 0; c4 := 0;
        C0c := 0; C0s := 0; C0d := 0;
        Xc := 0; Yc := 0;
        Xs := 0; Ys := 0;
        Xd := 0; Yd := 0;
        r := 1;

          WITH IND.T[N] DO
          CASE TTipo OF       { Prepara i valori di x e y in base al tipo di tabella
                              ashrae e utilizzarli in seguito in INTERPOLA        }

            4000 : BEGIN      {tabella idel'chik (diagramma 7.29) ripresa}

                     Xs := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                     Xc := TabCalc^[IND.Pc]^.T[1].Portata/Portata;
                     Xd := TabCalc^[ind.pd]^.t[1].portata/portata;
                     C1 := CALCAREA(IND, N);
                     IF C1 <> 0 THEN Ys := calcarea(TabCalc^[ind.ps]^, 1)/c1 ELSE ys := 0;
                     IF C1 <> 0 THEN Yc := calcarea(TabCalc^[ind.pc]^, 1)/c1 ELSE yc := 0;
                     IF C1 <> 0 THEN Yd := calcarea(TabCalc^[ind.pd]^, 1)/c1 ELSE yd := 0;

                     C0s := Interpola(Xs, Ys);
                     C0c := Interpola(Xc, Yc);
                     C0d := Interpola(Xd, Yd);
                   END;
            4001 : BEGIN      {tabella idel'*chik (diagramma 7.29) mandata}
                     IF IND.Pc <> 0 THEN C1 := CalcVel(TabCalc^[IND.Pc]^, 1) ELSE C1 := 0;
                     C2 := CalcVel(IND, N);
                     IF C2 <> 0 THEN Xc := C1/C2;
                     C0c := 1+1.5*SQR(Xc); {formula tratta dal diagramma 7.29 idel'chik}
                     IF ind.pc <> 0 THEN c1 := calcvel(TabCalc^[ind.ps]^, 1) ELSE c1 := 0;
                     IF c2 <> 0 THEN xs := c1/c2;
                     c0s := 1+1.5*SQR(xs);
                   END;


            1 : BEGIN         {## 3_1 }
                  IF R = 0 THEN R := 1.5;
                  Xc := R;
                  C0c := KAdj(Ang)*Interpola(Xc, Yc);
                END;
            2 : BEGIN
                END;
            3 : BEGIN         {## 7_8 }

                  Xc := ComVal; {.. comval = n ..}
                  C0c := Interpola(Xc, Yc);
                END;          { caso 3 }
            4 : BEGIN         {## 2_1 }

                  IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                  Xc := ComVal;
                  C0c := 1+Interpola(Xc, Yc); {.. comval = n ..}
                END;
            5 : BEGIN         {## 2_7 }

                  {.. r = 1.5 cancellato danilo perche' r/a puo' essere 0 ..}

                  IF UPCASE(Archivio^[Cod].TipoSez[1]) IN ['D', 'C'] THEN Xc := L*1000/(A_D-Spa)
                  ELSE Xc := L*1000/(W-Spa);
                  Yc := R;    { r/w }
                  C0c := Interpola(Xc, Yc);
                END;
            6 : BEGIN         {## 3_2 }

                  IF R = 0 THEN R := 1.5;
                  Xc := R;    { r/d }
                  Yc := ComVal; { numero spicchi }
                  C0c := KRe(Ang)*Interpola(Xc, Yc);
                END;
            7 : BEGIN         {## 3_3 }

                  Xc := Ang;
                  C0c := KRe(Re(A_D-Spa, CalcVel(IND, N))*1E-4)*Interpola(Xc, Yc);
                END;
            8 : BEGIN         {## 6_23 }
                  { seleziona il c0 del main con x=vs/vc }
                  IF IND.Ps <>0 THEN C1 := CalcVel(TabCalc^[IND.Pc]^, 1) ELSE C1 := 0;
                  C2 := CalcVel(IND, N);
                  IF C2 <> 0 THEN Xc := C1/C2;
                  C0c := Interpola(Xc, Yc);

                  { seleziona il c0 del branch con x=qb/qc e y=ab/ac }
                  Xs := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                  C1 := CalcArea(IND, N);
                  IF C1 <> 0 THEN Ys := CalcArea(TabCalc^[IND.Ps]^, 1)/C1;
                  CASE TRUNC(Ang) OF
                    0..37 : CH := 'A';
                    38..52 : CH := 'B';
                    53..74 : CH := 'C';
                    75..90 : CH := 'D';
                  ELSE
                    BEGIN
                      WRITELN(W_M(51)); {'L''angolo inserito e'' errato per tabella 6_23'}
                      //REPEAT UNTIL KEYPRESSED;
                      //**N Gestione errori
                      //HALT;
                    END;
                  END;
                  IOERR := TRANSFER_TAB(Archivio^[Cod].Main+CH);
                  C0s := Interpola(Xs, Ys);
                END;          { caso 8 }

            { 2_2 6_10 6_11 non c'e' nessun pezzo e non viene considerata
            neanche la tabella }

            201 : BEGIN       {7_10}
                    { in comval ci va' sm/a0
                    in r/d ci va y }

                    Xc := comval;
                    Yc := KRe(Re((A_D-Spa), CalcVel(Ind, N))*1E-4);
                    C0c := interpola(Xc, Yc);
                    { leggo la tabella 7_10b }
                    IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                    C0c := C0c*interpola(r, 0);
                  END;

            9 : BEGIN         {## 6_12...6_16, 6_18...6_21 }

                  {melky
                  il main di queste tabelle e' 6_23M
                  Tutte le tabelle che hanno come main 6_23 nell'ashrae
                  debbono fare riferimento come main alla 6_23
                  n.b. la 6_23 e la 6_23m se viste con il cantab
                  sono uguali ma diverso e il codice di riferimento 8 & 9 }

                  { seleziona il c0 del main con x=vs/vc }
                  IF IND.Pc <> 0 THEN C1 := CalcVel(TabCalc^[IND.Pc]^, 1) ELSE C1 := 0;
                  C2 := CalcVel(IND, N);
                  IF C2 <> 0 THEN Xc := C1/C2;
                  C0c := Interpola(Xc, Yc);

                  { calcola il c0s : quello del branch }
                  IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                  IF CalcVel(IND, N) <> 0 THEN Xs := CalcVel(TabCalc^[IND.Ps]^, 1)/CalcVel(IND, N);
                  C0s := Interpola(Xs, Ys);
                END;          { caso 9 }
            10 : BEGIN        {## 3_4 }
                   IF a_d <> 0 THEN
                     Xc := L*1000/(A_D-Spa);
                   C0c := KRe(Re(A_D-Spa, CalcVel(IND, N))*1E-4)*Interpola(Xc, Yc);
                 END;         { caso 10 }
            11 : BEGIN        {## 3_5 }
                   IF w <> 0 THEN
                     Xc := (H-Spa)/(W-Spa);
                   IF R = 0 THEN R := 1;
                   Yc := R;
                   C0c := Interpola(Xc, Yc);
                   { seleziona kre in base alla tabella ash3_5k }
                   IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                   C0c := C0c*KAdj(Ang)*Interpola(Re(A_D-Spa, CalcVel(IND, N))*1E-4, R);
                 END;         { caso 11 }
            12 : BEGIN        {## 3_6 }

                   IF w <> 0 THEN
                     Xc := (H-Spa)/(W-Spa);

                   Yc := ANG;
                   C0c := KRe(Re(A_D-Spa, CalcVel(IND, N))*1E-4)*Interpola(Xc, Yc);
                 END;         { caso 12 }
            13 : BEGIN        {## 6_17 }

                   Xc := CalcVel(TabCalc^[IND.Pc]^, 1)/CalcVel(IND, N); { x=vs/vc }
                   C0c := Interpola(Xc, Yc);

                   IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                   Xs := CalcVel1(IND.Ps, 1)/CalcVel(IND, N); { x=vb/vc }
                   C0s := Interpola(Xs, Ys);
                 END;         { caso 13 }
            14 : BEGIN        {## 6_34 }
                   IF Mandata THEN
                     BEGIN
                       Xc := CalcVel1(IND.Pc, 1)/CalcVel(IND, N); { x=v1b/vc }
                       Yc := Ang;
                       C0c := Interpola(Xc, Yc);
                       Xs := CalcVel1(IND.Ps, 1)/CalcVel(IND, N); { x=v1b/vc }
                       Ys := Ang;
                       C0s := Interpola(Xs, Ys);
                     END
                   ELSE
                     BEGIN
                       IOERR := TRANSFER_TAB(Archivio^[Cod].MAIN+'C');
                       Xc := TabCalc^[IND.Pc]^.T[1].Portata/Portata; { x=q1b/qc }
                       Yc := Ang;
                       C0c := Interpola(Xc, Yc);
                       IOERR := TRANSFER_TAB(Archivio^[Cod].MAIN+'C');
                       Xs := TabCalc^[IND.Pc]^.T[1].Portata/Portata; { x=q1b/qc }
                       Ys := Ang;
                       C0s := Interpola(Xs, Ys);
                     END;
                 END;         { caso 14 }
            15 : BEGIN        { tipo fittizio per  diff }
                   C0c := 0;
                 END;
            16 : BEGIN        {## 6_26 / 6_28 / 6_29 }

                   {melky
                   il main di queste tabelle e' 6_28M
                   Tutte le tabelle che hanno come main 6_23 nell'ashrae
                   debbono fare riferimento come main alla 6_23
                   n.b. la 6_23 e la 6_28m se viste con il cantab
                   sono uguali ma diverso e il codice di riferimento 8 & 9 }

                   { seleziona il c0 del main con x=vs/vc }
                   IF IND.Pc <> 0 THEN C1 := CalcVel1(IND.Pc, 1) ELSE C1 := 0;
                   C2 := CalcVel(IND, N);
                   IF C2 <> 0 THEN Xc := C1/C2;
                   C0c := Interpola(Xc, Yc);

                   { seleziona il c0 del branch con x=qb/qc e y=vb/vc }
                   IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                   IF portata <> 0 THEN Xs := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                   IF calcvel(ind, n) <> 0 THEN Ys := CalcVel1(IND.Ps, 1)/CalcVel(IND, N);
                   C0s := Interpola(Xs, Ys);
                 END;         { caso 16 }




            19 : BEGIN        {## 6_24  }

                   { selezione c0 main con due tabelle in base all'angolo }
                   {  x=as/ac    y=vs/vc  }
                   IF Ang = 90 THEN IOERR := TRANSFER_TAB(Archivio^[Cod].Main+'K');
                   Xc := CalcArea1(IND.Pc, 1)/CalcArea(IND, N);
                   IF IND.Pc <> 0 THEN C1 := CalcVel1(IND.PC, 1) ELSE C1 := 0;
                   C2 := CalcVel(IND, N);
                   IF C2 <> 0 THEN Yc := C1/C2;
                   C0c := Interpola(Xc, Yc);

                   { selezione branch per 6_24 con x=vb/vc   y=ang }
                   Ys := Ang;
                   IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                   IF IND.Ps <> 0 THEN C1 := CalcVel1(IND.PS, 1) ELSE C1 := 0;
                   C2 := CalcVel(IND, N);
                   IF C2 <> 0 THEN Xs := C1/C2;
                   C0s := Interpola(Xs, Ys);
                 END;         { caso 19 }
            20 : BEGIN        {##   }
                 END;         { caso 20 }

            23 : BEGIN        {## 6_3  }

                   {  selezione c0 main con x=qb/qc  }
                   C1 := TabCalc^[Ind.Pc]^.T[1].Portata;
                   IF C1 <> 0 THEN Xc := TabCalc^[IND.Ps]^.T[1].Portata/C1;
                   C0c := Interpola(Xc, Yc);

                   {  selezione c0 branch con x=ab/ac  y=qb/qc  }
                   IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                   Ys := Xc;  { qb/qc }
                   C1 := CalcArea1(IND.Pc, 1);
                   IF C1 <> 0 THEN Xs := CalcArea1(IND.Ps, 1)/C1;
                   C0s := Interpola(Xs, Ys);
                 END;         { caso 23 }
            24 : BEGIN        {## 6_36  }
                   IF Mandata THEN
                     BEGIN
                       { selezione c0 main con x=vs/vc }
                       C1 := CalcVel(IND, N);
                       IF C1 <> 0 THEN Xc := CalcVel1(IND.Pc, 1)/C1;
                       C0c := Interpola(Xc, Yc);

                       { seleziona il c0 del branch con x=qb/qc e y=ab/ac }
                       Xs := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                       Ys := CalcArea1(IND.Ps, 1)/CalcArea(IND, N);
                       IOERR := TRANSFER_TAB(Archivio^[Cod].Branch+'D');
                       C0s := Interpola(Xs, Ys);

                       { seleziona il c0 del branch con x=qb/qc e y=ab/ac }
                       Xd := TabCalc^[IND.Pd]^.T[1].Portata/Portata;
                       Yd := CalcArea1(IND.Pd, 1)/CalcArea(IND, N);
                       C0d := Interpola(Xd, Yd);
                     END      { if mandata then ......... }
                   ELSE
                     BEGIN
                       { qc = portata }
                       Xc := TabCalc^[IND.Pc]^.T[1].Portata/Portata;
                       IOERR := TRANSFER_TAB(Archivio^[Cod].MAIN+'C');
                       C0c := Interpola(Xc, Yc);

                       { selezione c0 branch }
                       C1 := CalcArea(IND, N);
                       C2 := CalcArea1(IND.Ps, 1);
                       IF C1 <> 0 THEN C1 := C2/C1 ELSE C1 := 0;
                       IF Portata <> 0 THEN Xs := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                       C2 := TabCalc^[IND.Ps]^.T[1].Portata;
                       IF C2 <> 0 THEN Ys := TabCalc^[IND.Pd]^.T[1].Portata/C2;
                       CH:='R';
                       CASE TRUNC(10*C1) OF
                         0..2 : CH := 'R';
                         3..4 : CH := 'U';
                         5..6 : CH := 'X';
                         7..8 : CH := 'Y';
                         9..10 : CH := 'Z';
{                      else
                        WRITELN(C1:5:4);}
                       END;
                       if TRUNC(10*C1)>10 then ch:='Z';
                       IOERR := TRANSFER_TAB(Archivio^[Cod].Main+CH);
                       C0s := Interpola(Xs, Ys);
                       {.. melky ..}
                       { selezione c0 branch }
                       C1 := CalcArea(IND, N);
                       C2 := CalcArea1(IND.Pd, 1);
                       IF C1 <> 0 THEN C1 := C2/C1 ELSE C1 := 0;
                       IF Portata <> 0 THEN Xd := TabCalc^[IND.Pd]^.T[1].Portata/Portata;
                       Yd := Ys;
                       CH:='R';
                       CASE TRUNC(10*C1) OF
                         0..2 : CH := 'R';
                         3..4 : CH := 'U';
                         5..6 : CH := 'X';
                         7..8 : CH := 'Y';
                         9..10 : CH := 'Z';
{        else
            WRITELN('ERRORE nella lettura della tabella ', Archivio^[Cod].CodPezzo,C1:5:4);}
                       END;
                       if TRUNC(10*C1)>10 then ch:='Z';
                       IOERR := TRANSFER_TAB(Archivio^[Cod].MAIN+CH);
                       C0d := Interpola(Xd, Yd);
                     END;     { if mandata ...... else ........... }
                 END;         { caso 24 }
            25 : BEGIN        {## 7_1 / 7_2 / 7_5  }
                   { selezione c0 con x=ang }
                   Xc := Ang;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 25 }
            26 : BEGIN        {## 7_12  }
                   { selezione c0 con  x=l/h  y=w/h  }
                   Xc := L*1000/(H-Spa); Yc := (W-spa)/(H-Spa);
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 26 }

            30 : BEGIN        {## 6_33 }

                   { selezione c0 con x=ab/ac  }
                   IF NOT Mandata THEN IOERR := TRANSFER_TAB(Archivio^[Cod].Main+'C');
                   C1 := CalcArea(IND, N);
                   IF C1 <> 0 THEN Xc := CalcArea1(IND.Pc, 1)/C1;
                   C0c := Interpola(Xc, Yc);
                   IF NOT Mandata THEN IOERR := TRANSFER_TAB(Archivio^[Cod].Main+'C');
                   C1 := CalcArea(IND, N);
                   IF C1 <> 0 THEN Xc := CalcArea1(IND.Ps, 1)/C1;
                   C0s := Interpola(Xc, Yc);
                 END;         { caso 30 }

            157 : c0c := 0.24;

            31 : BEGIN        {## 6_35  }
                   IF Mandata THEN
                     BEGIN
                       { selezione c0 main con x=vs/vc }
                       C1 := CalcVel(IND, N);
                       IF C1 <> 0 THEN Xc := CalcVel1(IND.Pc, 1)/C1;
                       C0c := Interpola(Xc, Yc);
                       { seleziona il c0 del branch con x=qb/qc e y=ab/ac }
                       IF portata <> 0 THEN Xs := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                       IF CalcArea(IND, N) <> 0 THEN Ys := CalcArea1(IND.PS, 1)/CalcArea(IND, N);
                       IOERR := TRANSFER_TAB(Archivio^[Cod].Branch+'B');
                       C0s := Interpola(Xs, Ys);

                       { seleziona il c0 del branch con x=qb/qc e y=ab/ac }
                       Xd := TabCalc^[IND.Pd]^.T[1].Portata/Portata;
                       Yd := CalcArea1(IND.Pd, 1)/CalcArea(IND, N);
                       C0d := Interpola(Xd, Yd);
                     END      { if mandata then........ }
                   ELSE       {------------------------  ripresa  ------------------------}
                     BEGIN
                       { qc = portata }
                       Xc := TabCalc^[IND.Pc]^.T[1].Portata/Portata;
                       C1 := CalcArea(IND, N);
                       C2 := CalcArea1(IND.Ps, 1);
                       IF C1 <> 0 THEN C1 := C2/C1 ELSE C1 := 0;
                       IF C2 <> 0 THEN Yc := CalcArea1(IND.Pd, 1)/C2;
                       CASE TRUNC(10*C1) OF
                         0..2 : CH := 'K';
                         3..4 : CH := 'J';
                         5..6 : CH := 'Q';
                         7..10 : CH := 'W';
                       END;
                       IOERR := TRANSFER_TAB(Archivio^[Cod].MAIN+CH);
                       C0c := Interpola(Xc, Yc);

                       { selezione c0 branch }
                       IF Portata <> 0 THEN Xs := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                       C2 := TabCalc^[IND.Ps]^.T[1].Portata;
                       IF C2 <> 0 THEN Ys := TabCalc^[IND.Pd]^.T[1].Portata/C2;
                       CASE TRUNC(10*C1) OF
                         0..2 : CH := 'R';
                         3..4 : CH := 'U';
                         5..6 : CH := 'X';
                         7..10 : CH := 'Y';
                       END;
                       IOERR := TRANSFER_TAB(Archivio^[Cod].MAIN+CH);
                       C0s := Interpola(Xs, Ys);
                       IF Portata <> 0 THEN Xd := TabCalc^[IND.Pd]^.T[1].Portata/Portata;
                       Yd := Ys;
                       C0d := Interpola(Xd, Yd);
                     END;     { if mandata ........ else .......... }
                 END;         { caso 31 }

            {..... zona riservata alla gestione di riduzioni ed allargamenti .....
            ..... tabelle 4.* , 5.*  e tabella aerimpianti per trasformazioni ...}

            4551 : BEGIN      { somma della tabella 4.5 con la tabella 5.1 }
                     AngoliX(Ind, N, Alfa1, Alfa2); {alfa1 ---> 5.1   alfa2 ---> 4.5}
                     IOERR := TRANSFER_TAB('ASH4_5');
                     {tabella 4.5}
                     Xc := Alfa2;
                     C1 := CalcArea(IND, N);
                     C2 := CalcArea(IND, N+1);
                     IF C1 > C2 THEN
                       BEGIN
                         IF C2 <> 0 THEN Yc := C1/C2;
                       END
                     ELSE
                       IF C1 <> 0 THEN Yc := C2/C1;
                     C0c := Interpola(Xc, Yc);
                     {c0c coefficiente tabella 4.5}

                     {tabella 5.1}
                     IOERR := TRANSFER_TAB('ASH5_1');
                     Xc := Alfa1;
                     C1 := CalcArea(IND, N-1);
                     C2 := CalcArea(IND, N+1);
                     IF C1 > C2 THEN
                       BEGIN
                         IF C2 <> 0 THEN Yc := C1/C2;
                       END
                     ELSE
                       IF C1 <> 0 THEN Yc := C2/C1;
                     C0c := Interpola(Xc, Yc)+C0c;
                     Xc := (Alfa1+Alfa2)/2;
                     {c0c coefficiente tabella 4.5 + coefficiente tabella 5.1}
                   END;
            17 : BEGIN        {## 5_1 }

                   IF Ang = 0 THEN Ang := SceltaAngolo(Ind, N);
                   Xc := Ang;
                   C1 := CalcArea(IND, N);
                   C2 := CalcArea(IND, N+1);
                   IF C1 > C2 THEN
                     BEGIN
                       IF C2 <> 0 THEN Yc := C1/C2;
                     END
                   ELSE
                     IF C1 <> 0 THEN Yc := C2/C1;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 17 }
            28 : BEGIN        {## 5_2 }
                   { selezione c0 con  x=ang  y=l/d  }

                   Xc := Ang;
                   IF UPCASE(Archivio^[Cod].TipoSez[1]) IN ['C', 'D'] THEN

                     BEGIN
                       Yc := L*1000;
                       Yc := Yc/(A_D-Spa);
                     END
                   ELSE
                     BEGIN
                       C1 := ((H-Spa)/((H-Spa)+W-Spa)); C1 := 1.0*C1*2*(W-Spa); Yc := L*1000/C1;
                     END;
                   C0c := interpola(xc, yc);
                   C1 := 0; C2 := 0;
                   C1 := CALCAREA(IND, N);
                   C2 := CALCAREA(IND, N+1);
                   IF c1 <> 0 THEN c2 := c2/c1 ELSE c2 := 0;
                   IOERR := TRANSFER_TAB(Archivio^[Cod].branch);
                   Ys := 0;
                   C0s := interpola(c2, Ys);
                   C0c := C0s*C0c;
                 END;         { caso 28 }
            29 : BEGIN        {## 5_3 }

                   { melky a0<a1 non viene considerato }

                   { selezione c0 con  x=re * 10e-4  }
                   Xc := Re(A_D-Spa, CalcVel(IND, N))*1E-4;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 29 }
            21 : BEGIN        {## 4_7c  }
                   { melky scelta angolo non va bene anche caso dopo}
                   { selezione c0 con x=ang  y=a1/a0  caso round=>rectangular  }
                   IF Ang = 0 THEN
                     BEGIN
                       c3 := SQRT(1.0*(Ind.T[n+1].W-Spa)*1.0*(Ind.T[n+1].H-Spa));
                       c4 := 1.13*c3*1.0;
                       c3 := c4-a_d-Spa;
                       c4 := c3/(2.0*l*1000);
                       c3 := ARCTAN(c4);
                       IF mandata THEN
                         BEGIN
                           IF calcarea(ind, n) > calcarea(ind, n+1) THEN
                             IOERR := TRANSFER_TAB(Archivio^[COD].BRANCH);
                           { MELKY
                           IN QUESTO CASO IL BRANCH NON VUOL DIRE CHE IL PEZZO HA UN
                           RAMO BRANCH MA VIENE UTILIZZATO SOLO PER CARICARE LA TABELLA
                           5_1
                           }
                         END
                       ELSE
                         BEGIN
                           IF calcarea(ind, n) < calcarea(ind, n+1) THEN
                             IOERR := TRANSFER_TAB('ASH5_1')
                         END;
                       c4 := 2*ABS(c3);
                       ang := ROUND((180/PI)*c4);
                       {               ang := 2*abs(round((180/pi)*c3));}
                     END;
                   Xc := Ang;
                   C1 := CalcArea(IND, N);
                   C2 := CalcArea(IND, N+1);
                   IF C1 > C2 THEN
                     BEGIN
                       IF C2 <> 0 THEN Yc := C1/C2;
                     END
                   ELSE
                     IF C1 <> 0 THEN Yc := C2/C1;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 21 }
            22 : BEGIN        {## 4_7r  }
                   { selezione c0 con x=ang  y=a1/a0  caso rectangular=>round  }
                   IF Ang = 0 THEN
                     BEGIN
                       c3 := SQRT(1.0*(Ind.T[n].W-Spa)*1.0*(Ind.T[n].H-Spa));
                       c4 := 1.13*c3*1.0;
                       c3 := ind.t[n+1].a_d-Spa-c4;
                       c4 := c3/(2.0*l*1000);
                       c3 := ARCTAN(c4);
                       IF mandata THEN
                         BEGIN
                           IF calcarea(ind, n) > calcarea(ind, n+1) THEN
                             IOERR := TRANSFER_TAB('ASH5_1');
                         END
                       ELSE
                         BEGIN
                           IF calcarea(ind, n) < calcarea(ind, n+1) THEN
                             IOERR := TRANSFER_TAB(Archivio^[COD].BRANCH);
                           { MELKY
                           IN QUESTO CASO IL BRANCH NON VUOL DIRE CHE IL PEZZO HA UN
                           RAMO BRANCH MA VIENE UTILIZZATO SOLO PER CARICARE LA TABELLA
                           5_1
                           }

                         END;
                       c4 := 2*ABS(c3);
                       ang := ROUND((180/PI)*c4);
                       {               ang := 2*abs(round((180/pi)*c3));}
                     END;
                   Xc := Ang;
                   C1 := CalcArea(IND, N);
                   C2 := CalcArea(IND, N+1);
                   IF C1 > C2 THEN
                     BEGIN
                       IF C2 <> 0 THEN Yc := C1/C2;
                     END
                   ELSE
                     IF C1 <> 0 THEN Yc := C2/C1;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 22 }
            27 : BEGIN        {## 4_6  }
                   { selezione c0 con  x=l/h  y=a1/a0  }

                   IF h <> 0 THEN Xc := L*1000/(H-Spa);
                   C1 := CalcArea(IND, N);
                   C2 := CalcArea(IND, N+1);
                   IF C1 > C2 THEN
                     BEGIN
                       IF C2 <> 0 THEN
                         Yc := C1/C2;
                     END
                   ELSE
                     BEGIN
                       IF C1 <> 0 THEN
                         Yc := C2/C1;
                     END;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 27 }
            32 : BEGIN        {##  4_1 / 4_3 / 4_5}

                   IF Ang = 0 THEN Ang := SceltaAngolo(Ind, N);
                   Xc := Ang;
                   C1 := CalcArea(IND, N);
                   C2 := CalcArea(IND, N+1);
                   IF C1 > C2 THEN
                     BEGIN
                       IF C2 <> 0 THEN Yc := C1/C2;
                     END
                   ELSE
                     IF C1 <> 0 THEN Yc := C2/C1;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 32 }
            35 : BEGIN        {## 4_8 .... 4_12 }

                   IF Ang = 0 THEN Ang := SceltaAngolo(Ind, N);
                   Yc := Ang;
                   Xc := CalcArea(IND, N+1)/CalcArea(IND, N);
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 35 }
            33 : BEGIN        {## 4_2/4_4 }

                   Cod := FIND_ARCHIVIO(CodPezzo);
                   IF UPCASE(Archivio^[Cod].TipoSez[1]) IN ['C', 'D'] THEN Xc := L*1000/(A_D-Spa)
                   ELSE
                     BEGIN
                       C1 := ((H-Spa)/((H-Spa)+W-Spa)); C1 := C1*2*W-Spa; Xc := L*1000/C1;
                     END;
                   C1 := CalcArea(IND, N);
                   C2 := CalcArea(IND, N+1);
                   IF C1 > C2 THEN
                     BEGIN
                       IF C2 <> 0 THEN Yc := C1/C2;
                     END
                   ELSE
                     IF C1 <> 0 THEN Yc := C2/C1;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 33 }

            {..... fine zona riservata alla gestione di riduzioni ed allargamenti .....}

            34 : BEGIN        {## 2_6s }

                   { seleziona il c0 del main con x=vs/vc }
                   C1 := CalcVel(IND, N);
                   IF C1 <> 0 THEN
                     Xc := CalcVel1(IND.Pc, 1)/C1;
                   C0c := Interpola(Xc, Yc);

                   { succeeding openings }
                   IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                   IF C1 <> 0 THEN
                     Xs := CalcVel1(IND.Ps, 1)/C1;
                   C0s := Interpola(Xs, Ys);
                 END;         { caso 34 }
            36 : Caso36;       {## 2_6f}

            38 : BEGIN        {## 3_7 / 3_7a / 3_7b / 3_7c}

                   IF W <> 0 THEN Xc := (H-Spa)/(W-Spa);
                   Yc := ComVal;
                   C0c := KAdj(Ang)*Interpola(Xc, Yc)
                 END;         { caso 38 }
            39 : BEGIN        {## 3_8 }

                   { controllata il 5/9/88 by melky o.k.}
                   ANG := 90;
                   Xc := ComVal;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 39 }
            40 : BEGIN        {## 3_9 }

                   { controllata il 5/9/88 by melky o.k.}

                   Xc := CalcVel(IND, N);
                   Yc := ComVal;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 40 }
            41 : BEGIN        {## 3_10 }
                   IF Mandata THEN
                     BEGIN
                       IF W <> 0 THEN Xc := (IND.T[N+1].W-Spa)/(W-Spa);
                       IF W <> 0 THEN Yc := (H-Spa)/(W-Spa);
                       C0c := KRe(Re(A_D-Spa, CalcVel(IND, N))*1E-4)*Interpola(Xc, Yc);
                     END
                   ELSE
                     BEGIN
                       C1 := IND.T[N+1].W-Spa;
                       C2 := IND.T[N+1].H-Spa;
                       IF C1 <> 0 THEN Xc := (W-Spa)/C1;
                       IF C1 <> 0 THEN Yc := C2/C1;
                       C0c := KRe(Re(A_D-Spa, CalcVel(IND, N+1))*1E-4)*Interpola(Xc, Yc);
                       ind.t[n].perdita := pv(calcvel(ind, n+1))*C0c;
                     END;
                 END;         { caso 41 }
            42 : BEGIN        {## 3_11 }

                   { controllata il 5/9/88 by melky o.k.}

                   Xc := 1000*L/(H-Spa);
                   C0c := KRe(Re(A_D-Spa, CalcVel(IND, N))*1E-4)*Interpola(Xc, Yc);
                   IF W/H <> 1 THEN
                     BEGIN
                       IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                       Xc := (w-Spa)/(h-Spa);
                       C0c := C0c*Interpola(Xc, Yc);
                     END;
                 END;         { caso 42 }
            43 : BEGIN        {## 3_12 }

                   { controllata il 5/9/88 by melky o.k.}

                   Xc := 1000*L/(W-Spa);
                   C0c := KRe(Re(A_D-Spa, CalcVel(IND, N))*1E-4)*Interpola(Xc, Yc);
                   IF H/W <> 1 THEN
                     BEGIN
                       IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                       Xc := (h-Spa)/(w-Spa);
                       C0c := C0c*Interpola(Xc, Yc);
                     END;
                 END;         { caso 43 }

            { 3_13 3_14 3_15 non vengono considerate melky }

            44 : BEGIN        {## 6_7 / 6_8 / 6_9 }

                   { controllata il 6/9/88 by melky o.k.}

                   { melky
                   le tabelle 6_7 6_8 e 6_9 hanno come main la tabella
                   6_3. sono state create le tabelle 6_7 6_8 e 6_9 che
                   non sono nient'altro che una duplicazione della 6_3 }

                   {  selezione c0 main con x=qb/qc  }
                   C1 := Portata;
                   IF C1 <> 0 THEN Xc := TabCalc^[IND.Ps]^.T[1].Portata/C1;
                   C0c := Interpola(Xc, Yc);

                   IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                   Xs := Xc;
                   Ys := CalcVel(IND, N);
                   C0s := Interpola(Xs, Ys);
                 END;         { caso 44 }
            45 : BEGIN        {## 7_6 / 7_7 }
                   Xc := Ang;
                   IF (H <> 0) AND (W <> 0) THEN Yc := ComVal*(W-Spa)/(2*((H-Spa)+W-Spa));
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 45 }
            46 : BEGIN        {## 7_4 }
                   IF H <> 0 THEN Xc := ComVal/(H-Spa);
                   IF W <> 0 THEN Yc := H-Spa/(W-Spa);
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 46 }
            47 : BEGIN        {## 7_3 }
                   Xc := ComVal;
                   C0c := Interpola(XC, Yc);
                 END;         { caso 47 }
            48 : BEGIN        {## 6_22 }

                   { melky
                   in tabella ho teta = 90 e r/w = 1 }

                   IF Portata <> 0 THEN Xc := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                   C1 := CalcArea1(IND.Pc, 1);
                   IF C1 <> 0 THEN Yc := CalcArea1(IND.Ps, 1)/C1;
                   C0c := Interpola(Xc, Yc);
                   Xs := Xc; Ys := Yc;
                   IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                   C0s := Interpola(Xs, Ys);
                 END;         { caso 48 }
            49 : BEGIN        {## 2_3 / 2_4 / 2_5 }

                   { controllata il 5/9/88 by melky o.k.}

                   Xc := Ang;
                   C1 := CalcArea(IND, N-1);
                   IF C1 <> 0 THEN
                     Yc := CalcArea(IND, N)/C1;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 49 }
            50 : BEGIN        {## 2_8 / 2_9 }

                   { controllata il 5/9/88 by melky o.k.}

                   Yc := Ang;
                   C1 := CalcArea(IND, N);
                   IF C1 <> 0 THEN
                     Xc := CalcArea(IND, N+1)/C1;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 50 }
            51 : BEGIN        {## 2_10 }

                   { controllata il 5/9/88 by melky o.k.}

                   Yc := Ang;
                   IF A_D <> 0 THEN
                     Xc := L*1000/(A_D-Spa);
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 51 }
            52 : BEGIN        {## 2_11 }

                   { controllata il 5/9/88 by melky o.k.}

                   C1 := IND.T[N-1].A_D-Spa;
                   IF C1 <> 0 THEN
                     Xc := (A_D-Spa)/C1;
                   C0c := Interpola(Xc, Yc);
                 END;         { caso 52 }
            100 : BEGIN       {## 1_1 }

                    { Controllata il 5/9/88 by melky o.k.

                    n.b. la griglia non viene considerata
                    }

                    IF UPCASE(Archivio^[Cod].TipoSez[1]) IN ['C', 'D'] THEN
                      BEGIN
                        Xc := L*1000/(A_D-Spa);
                        Yc := ComVal/(A_D-Spa); { t/d } { il t Š in mm. }
                      END
                    ELSE
                      BEGIN
                        C1 := ((H-Spa)/((H-Spa)+W-Spa)); C1 := C1*2*(W-Spa); xc := L*1000/C1;
                        C2 := ((H-Spa)/((H-Spa)+W-Spa)); C2 := C2*2*(W-Spa); Yc := comval*1000/C2; { t/d }
                      END;
                    C0c := Interpola(Xc, Yc);
                  END;        { caso 100 }
            101 : BEGIN       {## 1_2/1_3 }
                    xc := comval/(a_d-Spa);
                    C0c := Interpola(Xc, Yc);
                  END;        { caso 101 }

            102 : BEGIN       {## 1_4/1_5 }


                    Xc := Ang;


                    IF UPCASE(Archivio^[Cod].TipoSez[1]) IN ['C', 'D'] THEN Yc := L*1000/(A_D-Spa)
                    ELSE
                      BEGIN
                        C1 := ((H-Spa)/((H-Spa)+W-Spa)); C1 := C1*2*(W-Spa); Yc := L*1000/C1;
                      END;
                    C0c := Interpola(Xc, Yc);
                  END;        { caso 102 }
            103 : BEGIN       {## 1_6 }

                    { Controllata il 5/9/88 by melky o.k.

                    n.b. la griglia non viene considerata
                    }

                    Yc := Ang;

                    { se l'angolo e' = 0 ?????????????? }

                    Xc := L*1000/(A_D-Spa);
                    C0c := Interpola(Xc, Yc);
                  END;        { caso 103 }
            104 : BEGIN       {## 1_7 }

                    { ci sono 2 tabelle per reticoli circolari e rettangolari
                    ma la cosa non viene presa in considerazione }

                    Xc := Ang;

                    C0c := Interpola(Xc, Yc);
                  END;        { caso 104 }

            105 : BEGIN       {## 1_8s }

                    { Controllata il 5/9/88 by melky o.k.

                    }

                    { seleziona il c0 del main con x=qb/qc e y=ab/ac }

                    IF Portata <> 0 THEN
                      Xc := TabCalc^[IND.Ps]^.T[1].Portata/Portata;

                    C1 := CalcArea(IND, N);
                    IF C1 <> 0 THEN
                      Yc := CalcArea1(IND.Ps, 1)/C1;

                    C0c := Interpola(Xc, Yc);

                    { succeeding openings }
                    IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                    Xs := Xc; Ys := Yc;
                    C0s := Interpola(Xs, Ys);
                  END;        { caso 105 }
            110 : BEGIN       {## 1_8f }

                    { Controllata il 5/9/88 by melky o.k.

                    }

                    { seleziona il c0 del branch con x=ab/ac e y=b/d0}
                    C1 := IND.T[N].A_D-Spa;

                    IF C1 <> 0 THEN
                      begin
                      if Ind.T[N+1].H<>0 then
                      Yc := (Ind.T[N+1].H-Spa)/C1
                      else Yc := (sqrt(CalcArea(IND, N+1))-Spa)/C1
                      { nuovi pezzi 9-6-93 }
                      end;
                    C1 := CalcArea(IND, N);
                    IF C1 <> 0 THEN
                      Xc := CalcArea(IND, N+1)/C1;

                    C0c := Interpola(Xc, Yc);
                  END;        { caso 110 }
            106 : BEGIN       {## 6_1 }

                    { Controllata il 5/9/88 by melky o.k.

                    }

                    { nessun pezzo fa' riferimento a questa tabella ????????? }

                    { selezione c0 main con x=ab/ac  y=qb/qc }
                    C1 := CalcArea(IND, N);

                    IF C1 <> 0 THEN
                      Xc := CalcArea1(IND.Ps, 1)/C1;

                    IF Portata <> 0 THEN
                      Yc := TabCalc^[IND.Ps]^.T[1].Portata/Portata;

                    C0c := Interpola(Xc, Yc);

                    { selezione c0 branch con x=ab/ac  y=qb/qc }
                    IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                    Xs := Xc; Ys := Yc;
                    C0s := Interpola(Xs, Ys);
                  END;        { caso 106 }
            107 : BEGIN       {## 6_2 }

                    { Controllata il 5/9/88 by melky o.k.

                    }

                    { selezione c0 main con x=ab/ac  y=vs/vc }
                    C1 := CalcArea(IND, N);
                    IF C1 <> 0 THEN
                      Xc := CalcArea1(IND.Ps, 1)/C1;
                    C1 := CalcVel(IND, N);
                    IF C1 <> 0 THEN
                      Yc := CalcVel1(IND.Pc, 1)/C1;
                    C0c := Interpola(Xc, Yc);

                    { selezione c0 branch con x=ab/ac  y=vb/vc }
                    IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                    Xs := Xc;
                    C1 := CalcVel(IND, N);
                    IF C1 <> 0 THEN
                      Ys := CalcVel1(IND.Ps, 1)/C1;
                    C0s := Interpola(Xs, Ys);
                  END;        { caso 107 }


            108 : BEGIN       {## 6_3 }

                    { Controllata il 5/9/88 by melky o.k.

                    }

                    { selezione c0 main con x=qb/qc }
                    IF Portata <> 0 THEN
                      Xc := TabCalc^[IND.Ps]^.T[1].Portata/Portata;
                    C0c := Interpola(Xc, Yc);

                    { selezione c0 branch con x=ab/ac   y=qb/qc  }
                    IOERR := TRANSFER_TAB(Archivio^[Cod].Branch);
                    Ys := Xc;
                    C1 := CalcArea(IND, N);
                    IF C1 <> 0 THEN
                      Xs := CalcArea1(IND.Ps, 1)/C1;
                    C0s := Interpola(Xs, Ys);
                  END;        { caso 108 }

            { 6_6 6_27 6_30 6_31 6_32 non considerata ???? }

            109 : BEGIN       {## 6_4/6_5 }

                    { nessun pezzo fa' riferimento a questa tabella (ash6_4) ???? }

                    C1 := TabCalc^[IND.Pc]^.T[1].Portata;
                    IF C1 <> 0 THEN
                      Xc := TabCalc^[IND.Ps]^.T[1].Portata/C1;

                    C1 := CalcArea(IND, N);
                    IF c1 <> 0 THEN
                      Yc := CalcArea1(IND.Ps, 1)/c1;



                    CH1 := ' '; CH2 := ' ';
                    CASE TRUNC((calcarea1(ind.pc, 1)/c1)*10) OF
                      0..3 : BEGIN CH1 := 'A'; CH2 := 'G'; END;
                      4 : BEGIN CH1 := 'B'; CH2 := 'H'; END;
                      5 : BEGIN CH1 := 'C'; CH2 := 'I'; END;
                      6 : BEGIN CH1 := 'D'; CH2 := 'J'; END;
                      7, 8:BEGIN CH1 := 'E'; CH2 := 'K'; END;
                      9, 10:BEGIN CH1 := 'F'; CH2 := 'L'; END;
                    END;
                    IF CH1 <> 'A' THEN IOERR := TRANSFER_TAB(Archivio^[Cod].Main+CH1);
                    C0c := Interpola(Xc, Yc);
                    IOERR := TRANSFER_TAB(Archivio^[Cod].BRANCH+CH2);
                    Xs := Xc;

                    C1 := CalcArea(IND, N);
                    IF C1 <> 0 THEN
                      Ys := CalcArea1(IND.Ps, 1)/C1;

                    C0s := Interpola(Xs, Ys);
                  END;        { caso 109 }
          600:caso600;
          601:CASO601;
          602:caso602;
          603:caso603;
          604:caso604;
          605:caso605;
          606:caso606;
          607:caso607;
          608:caso608;
          609:caso609;
          ELSE

          END;                { case ttipo of }

        IF Archivio^[Cod].TipoSez[1] IN ['A', 'H', 'R'] THEN
          WITH IND.T[N] DO IF (H+W <> 0) THEN
            A_D := TRUNC(1.3*Elev(1.0*H*W, 0.625)/Elev(H+W, 0.25));

        IF Archivio^[Cod].NUscite > 1 THEN
          BEGIN
            SETC0(IND, Cod, 1, C0c, Xc, Yc);
            SETC0(IND, Cod, 2, C0s, Xs, Ys);
            SETC0(IND, Cod, 3, C0d, Xd, Yd);
            IND.T[N].X := 0;
            IND.T[N].Y := 0;
            IND.T[N].C0 := 0;
            SelectC0 := 0;
          END
        ELSE
          BEGIN
            IND.T[N].C0 := C0c;
            IND.T[N].X := Xc;
            IND.T[N].Y := Yc;
            SelectC0 := C0c;
          END;

      END;                    { proc.  selectc0 }
end.
