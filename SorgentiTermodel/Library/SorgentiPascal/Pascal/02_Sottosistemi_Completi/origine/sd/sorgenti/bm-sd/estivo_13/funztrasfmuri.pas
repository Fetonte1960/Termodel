unit FunztrasfMuri;

interface
uses Varcarichi;
PROCEDURE CALC_F_TRASF(NStrutt:INTEGER);
implementation
 {-----------------------------  CALC_F_TRASF  --------------------------------}
PROCEDURE CALC_F_TRASF(NStrutt:INTEGER);
{Calcolo coefficente funzione di trasferimento}
CONST
  IntNk:ARRAY[0..6] OF REAL=(3.5,7,11.5,16,20.5,25,25);
VAR
  I,J:integer;
  RJ:ARRAY[-1..MaxStrati] OF REAL;
  Nrj:INTEGER;     { Numero di strati relativi a RJ[n] :
                     per n=0 addutt. esterna ; per n=Nrj addutt. interna      }
  RT:REAL;         { Resistenza termica totale }
  TR:REAL;         { Trasmittanza              }
  RN,R01,R02:REAL;
  Z1,Z2:REAL;
  Cj,Ri,Ta0:REAL;
  Var TempNK,TempB0,TempB1,TempSc,TempD1:Real;
BEGIN
  WITH STRUTTURE_D^[NStrutt]^ DO
  BEGIN
    IF NStrati=0 THEN EXIT;
    { Calcolo di RJ per ogni componente della struttura }
    IF HE<>0 THEN RJ[0]:=1/HE ELSE RJ[0]:=0;
    { ????? manca l'aduttanza interna }
    MFstrutt:=0;
    FOR I:=1 TO NStrati DO
    BEGIN
      MFstrutt:=MFstrutt+Strati[I].PesoSpecifico*Strati[I].Spessore/100;
      IF Strati[I].Conduttanza<>0 THEN RJ[I]:=1/Strati[I].Conduttanza
      ELSE
        IF Strati[I].ConduttivitaLineare<>0 THEN
          RJ[I]:=(Strati[I].Spessore/100)/Strati[I].ConduttivitaLineare ELSE RJ[I]:=0;
    END;


    IF HI<>0 THEN RJ[NStrati+1]:=1/HI ELSE RJ[NStrati+1]:=0;
    Nrj:=NStrati+1;

    Rt:=0;
    FOR J:=0 TO Nrj DO Rt:=Rt+RJ[J];   { Calcolo resistenza totale }

    IF Rt<>0 THEN Tr:=1/Rt ELSE Tr:=0; { Calcolo trasmittanza      }

    (*if Nfile ='' then*)

    Trasmitt:=Tr;
     {
    if Exist (drive1+ NumeroProg + '.eln') then
     if TrovaStr(NFile,Tr) then Trasmitt:=Tr;
     }
    Z1:=0;     Z2:=0;
    FOR J:=0 TO Nrj DO
    BEGIN
      RN:=0;
      IF J > 0 THEN FOR I:=0 TO J-1 DO RN:=RN+RJ[I];

      R01:=RN/(RN+RJ[J]);
      R02:=RJ[J]/(RN+RJ[J]);

      Cj:=1;
      IF J>0 THEN CJ:=Strati[J].CaloreSpecifico*Strati[J].PesoSpecifico*Strati[J].Spessore/100;
      Z1:=Cj*R02*(1/6+1/3*R01)+R01*(Z1+R02*Z2);
      Z2:=Cj/3*(1+R01+sqr(R01))+Z2*sqr(R01);
    END;
    IF HI<>0 THEN Ri:=1/HI ELSE Ri:=0;

    Ta0:=(Z2*Ri*(Rt-Ri)/Rt) + Z1*(Rt-Ri);

    {if Ta0 < 28 then Ta0:=Ta0*0.09
    else Ta0:=Ta0*(ta0*0.004872-0.08);}

    I:=0;
    WHILE (IntNk[I]<Ta0) AND (I<6) DO I:=I+1;

    NK:=I;
    B0:=(Tr/Hi)*(1-(1-exp(-1/Ta0))*Ta0);
    B1:=(Tr/Hi)*(-exp(-1/Ta0)+(1-exp(-1/Ta0))*Ta0);
    Sc:=(1-(Tr/Hi))*(1-exp(-1/Ta0));
    D1:=exp(-1/Ta0);

    TempNK:=STRUTTURE_D^[NStrutt]^.NK;
    TempB0:=STRUTTURE_D^[NStrutt]^.B0;
    TempB1:=STRUTTURE_D^[NStrutt]^.B1;
    TempSc:=STRUTTURE_D^[NStrutt]^.Sc;
    TempD1:=STRUTTURE_D^[NStrutt]^.D1;



  END;  { WITH STRUTTURE_D^{NStrutt]..... DO..........}


END;    { PROC. CALC_F_TRASF }



end.
