{----------------SUP (totale superfici scambianti) --------------------------}

function Sup(Amb:integer):Real;

var F      :integer;
    Superf :REAL;

BEGIN

SUPERF:=0;

FOR F:=1 TO NFRONTIERE DO
WITH FRONTIERE_D^[F]^ DO
IF CODAMB=AMB THEN SUPERF:=SUPERF+SUPMURO+SUPMURO2+SUPFINESTRA+SUPPORTA;

SUP:=SUPERF

END;

{-------------------- INT373 ------------------------------------------------}

PROCEDURE INT373;

TYPE OUTREC=RECORD DESC                                :STRING[20];
                   NUM                                 :INTEGER;
                   TINT,TEST,VOL,SUPER,DISP,INF        :REAL
            END;
 VAR
    RECINT :OUTREC;
    A      :INTEGER;
    FO     :FILE OF OUTREC;

BEGIN

//ASSIGN(FO,'INT373.DAT');REWRITE(FO);

FOR A:=1 TO NAMBIENTI DO
WITH AMBIENTI_D^[A]^ DO

  BEGIN

  WITH RECINT DO

    BEGIN

    DESC :=DENOM;
    NUM  :=AMBIENTIUGUALI;
    TINT :=ZONE_D^[ZONA].TINV;
    TEST :=LOCALITA_D^.TINVESTERNABS;
    SUPER:=SUP(A);
    VOL  :=SUPERFICIE*HSOFFITTO;
    DISP :=ArCalc^[A]^.QCTOTINV;
    INF  :=ArCalc^[A]^.INSTOTINV;

    END;

  //WRITE(FO,RECINT)

  END;

//CLOSE(FO);

END;

{----------------------------  CalcoloInvernale  ----------------------------}
PROCEDURE CalcoloInvernale;
VAR

{  h                        : file of Ambienti;}
  F,A,IndA                 : INTEGER;
  T,FFin,FPort,FMur1,FMur2 : REAL;
  PINFinv,CP2              : real;
  KTot                     : real;
  IncrEsp                  : real;

BEGIN
  for A:=1 to NAmbienti do
  with Ambienti_D^[A]^ do
   begin
      if (zone_d^[Zona].ProfiloImpiantoInv > 0) then
      begin
        PINFinv:=InfInv*Superficie*HSoffitto/3600;
        CP2:=0.306*4186/((0.0036667*Zone_D^[Zona].TInv)+1);
        ArCalc^[A]^.INSTOTinv:=PINFinv * CP2 *(Zone_D^[Zona].TInv-Localita_D^.TInvEsternaBS);
      end;
   end;


  scrivi_real(ArCalc,'I','instotinv.mic');
{  assign(h,'instotinv.mic');     rewrite(h);   write(h,InsTotInv);  close(h);}

  {.. Salvataggio InsTotInv ..}

{  for F:=1 to MaxAmbienti do QCTotInv[F]:=0;}

  for F:=1 to Nambienti do ArCalc^[F]^.QCTotInv:=0;

  FOR F:=1 TO NFrontiere DO
  WITH Frontiere_D^[F]^ DO
  BEGIN
    A:=CodAmb;
    if (InRange(A,1,NAmbienti)) then
     begin
     if (zone_d^[Ambienti_D^[CodAmb]^.Zona].ProfiloImpiantoInv > 0) {and (InRange(CodEsposiz,1,MaxEsposizioni))} then

   { if (A > 0) and ( A <= NAmbienti) and (CodEsposiz > 0) and ( CodEsposiz <= MaxEsposizioni) then}  {*E*}
     begin
        if InRange(CodEsposiz,1,MaxEsposizioni) then
         begin
            IncrEsp:=Esposizioni_D^[CodEsposiz].IncrSic;
            
  {E}       IF UpCase(Esposizioni_D^[CodEsposiz].Tipo[1])=CH7 THEN
              T:=Localita_D^.TInvEsternaBS
            ELSE
              T:=Esposizioni_D^[CodEsposiz].TrifInv;
         end
        else
         begin
            IncrEsp:=1;
            IndA:=IndLocNRis(codesposiz);
            if inrange(IndA,1,NAmbienti) then T:=Zone_d^[Ambienti_d^[IndA]^.Zona].TInv
            else T:=0;
         end;

        if (Ambienti_D^[A]^.Zona in [1..MaxZone]) then
         begin
           if CodFinestra in[1..MaxFinestre] then

           FFin:=Finestre_D^[CodFinestra]{.fin_cart}.Trasmittanza*
                                           SupFinestra*
                      Finestre_D^[CodFinestra]{.fin_cart}.IncrSic

           else FFin:=0;

           if CodPorta in [1..MaxPorte] then FPort:=Porte_D^[CodPorta].Trasmittanza*SupPorta*
              Porte_D^[CodPorta].IncrSic
           else FPort:=0;

           if CodMuro>0 then
           //if CodMuro in [1..NMuri] then
           FMur1:=Strutture_D^[Muri_D^[CodMuro].CodArch]^.Trasmitt*SupMuro*Muri_D^[CodMuro].IncrSic
           else FMur1:=0;

           if CodMuro2 >0 then
           //if CodMuro2 in [1..NMuri] then
           FMur2:=Strutture_D^[Muri_D^[CodMuro2].CodArch]^.Trasmitt*SupMuro2*
              Muri_D^[CodMuro2].IncrSic
           else FMur2:=0;

           ArCalc^[A]^.QCTOTINV:=ArCalc^[A]^.QCTOTINV+
           IncrEsp{Esposizioni_D^[CodEsposiz].IncrSic}*
           (Zone_D^[Ambienti_D^[A]^.Zona].TInv-T)*(FMur1+FMur2+FFin+FPort);


         end
        else ArCalc^[A]^.QCTOTInv:=0;
     end;
     end;
{    else
     if (A > 0) and (A <= NAmbienti) then ArCalc^[A]^.QCTOTInv:=0;}
  END;    { WITH Frontiere DO........ }


  FOR F:=1 TO NFrontiereLin DO
  WITH FrontiereLin_D^[F]^ DO
  BEGIN
    A:=CodAmb;
    if (InRange(A,1,NAmbienti)) then
     begin
     if (zone_d^[Ambienti_D^[CodAmb]^.Zona].ProfiloImpiantoInv > 0) {and (InRange(CodEsp,1,MaxEsposizioni))} then
{    if (A > 0) and (A <= NAmbienti) and (CodEsp > 0) and ( CodEsp<= MaxEsposizioni) then} {*E*}
     begin
        if inrange(CodEsp,1,maxEsposizioni) then
         begin
            IncrEsp:=Esposizioni_D^[CodEsp].IncrSic;
 {E}        IF UpCase(Esposizioni_D^[CodEsp].Tipo[1])=CH7 THEN T:=Localita_D^.TInvEsternaBS
            ELSE T:=Esposizioni_D^[CodEsp].TrifInv;
         end
        else
         begin
            IncrEsp:=1;
            IndA:=IndLocNRis(codesp);
            if inrange(IndA,1,NAmbienti) then T:=Zone_d^[Ambienti_d^[IndA]^.Zona].TInv
            else T:=0;
         end;


        if (Ambienti_D^[A]^.Zona in [1..MaxZone]) then
         begin
            KTot:=0;
            if (CodPonte1 in [1..MaxPonti]) then KTot:=KTot+Kappa_PT^.K(F){Ponti_D^[CodPonte1].KL}*LUNG1;
            if (CodPonte2 in [1..MaxPonti]) then KTot:=KTot+Kappa_PT^.K(F){Ponti_D^[CodPonte2].KL}*LUNG2;
            ArCalc^[A]^.QCTOTINV:=ArCalc^[A]^.QCTOTINV+
            IncrEsp{Esposizioni_D^[CodEsp].IncrSic}*
            (Zone_D^[Ambienti_D^[A]^.Zona].TInv-T)*(KTot);
         end
        else ArCalc^[A]^.QCTotInv:=0;
     end
    else ArCalc^[A]^.QCTotInv:=0;
    end;
  END;     { WITH FrontiereLin DO........ }

    scrivi_real(ArCalc,'Q','qctotinv.mic');
{  assign(h,'qctotinv.mic');     rewrite(h);   write(h,QcTotInv);  close(h);}
  {.. Salvataggio QcTotInv ..}

  INT373;

END;     { PROC. CalcoloInvernale }

