
      {------------------------------  setportata  --------------------------------}
    PROCEDURE SETPORTATA(Var IND : LINK; Portata : REAL);
        { assegna lo stesso valore di portata ai pezzi di uno stesso tronco }
      VAR i : INTEGER;
      BEGIN
        O := Ult_Line(Ind);
        FOR i := 1 TO O DO IND.T[i].Portata := Portata;
      END;                    { proc.  setportata }

      {-----------------------------  findportata  ---------------------------------}
    FUNCTION FINDPORTATA(Var IND : LINK) : REAL;
        { cerca un pezzo con zero uscite e ne preleva il valore di portata }
      VAR
        O : INTEGER;
      BEGIN
        O := ULT_LINE(IND);
        FindPortata := IND.T[O].Portata;
      END;                    { func.  findportata }


      {------------------------------   cportate   ---------------------------------}
    PROCEDURE Cportate(Var IND : LINK; VAR Portata : REAL);
      VAR P1, P2, P3 : REAL;
      BEGIN
        Portata := 0; P1 := 0; P2 := 0; P3 := 0;
        IF IND.riga <> 0 THEN
          BEGIN
            IF (IND.Pc = 0) AND (IND.Ps = 0) AND (IND.Pd = 0) THEN
              BEGIN
                Portata := FindPortata(IND);
                SETPORTATA(IND, Portata);
              END
            ELSE
              BEGIN
                Cportate(TabCalc^[IND.Pc]^, P1);
                Cportate(TabCalc^[IND.Ps]^, P2);
                Cportate(TabCalc^[IND.Pd]^, P3);
                Portata := P1+P2+P3;
                SETPORTATA(IND, Portata);
              END;
          END;
      END;                    { proc. cportate }

