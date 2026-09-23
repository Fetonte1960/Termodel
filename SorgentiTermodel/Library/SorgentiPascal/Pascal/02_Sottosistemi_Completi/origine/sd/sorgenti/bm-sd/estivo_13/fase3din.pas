
{----------------- DINAMICA -------------------------------------------------}

PROCEDURE DINAMICA(A:integer);

VAR
  SumMFmuro                                       :REAL;
  Smax,Stot90,SInt90,SInt,StotScamb,Alt,SupParete :REAL;
  PerimTot,PerimScamb,PerimInt                    :REAL;
  Mu,Mu2,Fi,Po                                    :REAL;
  F                                               :INTEGER;

BEGIN

  SumMFmuro := 0;
  Alt       := Ambienti_D^[A]^.HSoffitto;
  SupParete := 0;
  Smax      := 0;
  Stot90    := 0;
  STotScamb := 0;

  FOR F:=1 TO NFrontiere DO

  WITH Frontiere_D^[F]^ DO

    IF Frontiere_D^[F]^.CodAmb=A THEN

    BEGIN

      //**if CodMuro in [1..NMuri] then
      if CodMuro >0 then
      begin

        if Muri_D^[CodMuro].CodArch in [1..MaxStrutture] then

        SumMFmuro :=                                      SumMFmuro +
                                                            SupMuro *
                    Strutture_D^[Muri_D^[CodMuro].CodArch]^.MFstrutt ;

      end;
      
      IF CodMuro2 >0 THEN
      //**IF CodMuro2 in [1..NMuri]  THEN

      SumMFmuro :=                                       SumMFmuro +
                                                          SupMuro2 *
                  Strutture_D^[Muri_D^[CodMuro2].CodArch]^.MFstrutt ;

      SupParete :=    SupMuro +
                     SupMuro2 +
                  SupFinestra +
                     SupPorta ;

      if (CodEsposiz > 0) and ( CodEsposiz <= MaxEsposizioni) then {*E*}
      {CodEsposiz in [1..MaxEsposizioni] then}

      begin

        IF Esposizioni_D^[CodEsposiz].Inclin=90 THEN

        BEGIN

          Stot90:=Stot90+SupParete;

          IF SupParete>Smax THEN Smax:=SupParete;

        END

        ELSE

        IF Esposizioni_D^[CodEsposiz].Inclin<>90 THEN

        StotScamb :=                                    StotScamb +
                                                        SupParete *
                    COS(Esposizioni_D^[CodEsposiz].Inclin*PI/180) ;

      end;

    END;    { FOR F:=1 TO NFrontiere DO With Frontiere_D^[F] DO.......... }

  if Alt <> 0 then

  begin

    IF Smax <> 0 THEN

    PerimTot:=2*( (Smax/Alt)+(Ambienti_D^[A]^.Superficie/(Smax/Alt)) )

    ELSE PerimTot:=4*SQRT(Ambienti_D^[A]^.Superficie);

    PerimScamb := Stot90/Alt;
    PerimInt   := PerimTot-PerimScamb;
    SInt90     := PerimInt*Alt;
    SInt       := 2*Ambienti_D^[A]^.Superficie-StotScamb;

    PScamb     := PerimScamb;

    MFtot      :=                               ( SumMFmuro +
                  (SInt90*Zone_D^[Ambienti_D^[A]^.zona].MassaFrontDivisInt/2) +
                 (SInt*Zone_D^[Ambienti_D^[A]^.zona].MassaFrontSoletteInt/2)) /
                                  Ambienti_D^[A]^.Superficie ;

  end

  else

  begin

    PScamb:=0;
    MFTot :=0;

  end;

  TrasmTot:=0;
  TrasmGen:=0;

  FOR F:=1 TO NFrontiere DO

  WITH Frontiere_D^[F]^ DO

  IF CODAMB=A THEN

  begin
  IF CodMuro >0 THEN
  //**  IF CodMuro in [1..NMuri] THEN

    begin

      if Muri_D^[CodMuro].CodArch in [1..MaxStrutture] then

      Mu:=Strutture_D^[Muri_D^[CodMuro].CodArch]^.Trasmitt*SupMuro

      ELSE Mu:=0;

    end

    else Mu:=0;

    IF CodMuro2<>0

    THEN Mu2 :=Strutture_D^[Muri_D^[CodMuro2].CodArch]^.Trasmitt *
                                                         SupMuro2
    ELSE Mu2:=0;

    IF CodPorta<>0    THEN Po:=Porte_D^[CodPorta].Trasmittanza*SupPorta

    ELSE Po:=0;

    IF CodFinestra<>0

    THEN Fi:=Finestre_D^[CodFinestra]{.fin_cart}.Trasmittanza*SupFinestra

    ELSE Fi:=0;

    if (CodEsposiz > 0) and ( CodEsposiz <= MaxEsposizioni) then  {*E*}
     IF Esposizioni_D^[CodEsposiz].Inclin = 90

      THEN TrasmTot:=TrasmTot+Mu+Mu2+Fi+Po;

    TrasmGen:=TrasmGen+Mu+Mu2+Fi+Po;

  END;

END;
