{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit U_funC0;

Interface

Uses
  Crt, {Unit found in TURBO.TPL}
  Dos, {Unit found in TURBO.TPL}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  utilitie,
  definiz;

  PROCEDURE AngoliX(VAR Ind : link; N : INTEGER; VAR Alfa1, Alfa2 : INTEGER);
  FUNCTION SceltaAngolo(Var Ind : link; N,Cod : INTEGER ) : INTEGER;
  PROCEDURE SETC0(Var IND : LINK; Cod, D : INTEGER; C, Xu, Yu : REAL);

 implementation


      PROCEDURE AngoliX(Var Ind : link; N : INTEGER; VAR Alfa1, Alfa2 : INTEGER);
        VAR
          Lun : REAL;
          Ang1, Ang2, WIN, HIN, DIN, WOUT, HOUT, DOUT : INTEGER;
        BEGIN
          IF Ind^.T[n].CodPezzo[3] = '1' THEN Ind^.T[n].L := 0.800
          ELSE IF Ind^.T[n].CodPezzo[3] = '2' THEN Ind^.T[n].L := 1.000;
          Lun := Ind^.T[n].L*1000;
          WIN := Ind^.T[n].W; HIN := Ind^.T[n].H; DIN := Ind^.T[n].A_D;

          WOUT := Ind^.T[n+1].W; HOUT := Ind^.T[n+1].H; DOUT := Ind^.T[n+1].A_D;
          
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



      FUNCTION SceltaAngolo(Var Ind : link; N,Cod : INTEGER) : INTEGER;
        VAR
          Temp, Lun : REAL;
          Ang1, Ang2, WIN, HIN, DIN, WOUT, HOUT, DOUT : INTEGER;
        BEGIN
          IF Ind^.T[n].L = 0 THEN
            BEGIN
              IF Ind^.T[n].CodPezzo[3] = '1' THEN Ind^.T[n].L := 0.800
              ELSE IF Ind^.T[n].CodPezzo[3] = '2' THEN Ind^.T[n].L := 1.000;
            END;

          Lun := Ind^.T[n].L*1000;

          WIN := Ind^.T[n].W; HIN := Ind^.T[n].H; DIN := Ind^.T[n].A_D;

          WOUT := Ind^.T[n+1].W; HOUT := Ind^.T[n+1].H; DOUT := Ind^.T[n+1].A_D;

          Ang1 := 0;
          IF Lun = 0 THEN Ang1 := 180
          ELSE
            BEGIN
              IF Cod > 0 THEN
                BEGIN
                  IF UPCASE(Archivio[Cod].TipoSez[1]) IN ['A', 'R', 'H'] THEN
                    BEGIN
                      IF UPCASE(Archivio[Cod].TipoSez[2]) IN ['A', 'R', 'H'] THEN {rett/rett}
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
                      IF UPCASE(Archivio[Cod].TipoSez[2]) IN ['A', 'R', 'H'] THEN {circ/rett}
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


        {----------------  setc0  -------------------}
      PROCEDURE SETC0(VAR IND : LINK; Cod, D : INTEGER; C, Xu, Yu : REAL);
        VAR
          O : INTEGER;
          PUN : LINK;
          Fl : CHAR;
        BEGIN

          CASE D OF
            1 : PUN := IND^.Pc;
            2 : PUN := IND^.Ps;
            3 : PUN := IND^.Pd;
          END;

          Fl := ARCHIVIO[Cod].TipoSez[D+1];
          IF Fl IN ['A', 'H', 'R'] THEN Fl := 'R'
          ELSE Fl := 'C';

          IF PUN <> NIL THEN
            BEGIN
              PUN^.T[0].C0 := C;
              PUN^.T[0].X := Xu;
              PUN^.T[0].Y := Yu;

              O := NCompRamo;
              WHILE (SETLEFT(IND^.T[O].CodPezzo) = '') AND (O > 1) DO O := O-1;
              PUN^.T[0].Descr := IND^.T[O].CodPezzo;
              PUN^.T[0].CodPezzo := IND^.T[O].CodPezzo;

              PUN^.T[0].A_D := PUN^.T[1].A_D; { .. inserimento diametro .. }

              PUN^.T[0].H := PUN^.T[1].H; { .. inserimento h .. }
              PUN^.T[0].W := PUN^.T[1].W; { .. inserimento w .. }

              IF Fl = 'R' THEN
                WITH PUN^.T[0] DO IF (H+W <> 0) THEN
                  A_D := TRUNC(1.3*Elev(1.0*H*W, 0.625)/Elev(H+W, 0.25))
              ELSE
                BEGIN
                  PUN^.T[0].W := 0;
                  PUN^.T[0].H := 0;
                END;


              PUN^.T[0].Portata := IND^.T[O].Portata;
              CASE D OF
                1 : PUN^.T[0].Descr := '>> MAIN << '+PUN^.T[0].Descr;
                2, 3:PUN^.T[0].Descr := '>>BRANCH<< '+PUN^.T[0].Descr;
              END;
            END;
        END;                  { proc.  setc0 }
end.