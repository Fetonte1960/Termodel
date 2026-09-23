
Unit F2;

Interface

Uses
  sysutils,warning,
  Varcarichi,Varcarichi_estivo_14,
  CalcFun,
  copiaLibreriaGenerale,
  Risultati;
//  Crt, {Unit found in TURBO.TPL}
//  Dos, {Unit found in TURBO.TPL}
//  definiz,
//  calcfun,UTIgen,
//  CALCUTID,
//  inpdati,defutig,WM;

 procedure Fase2;

{=============================================================================}

Implementation

{--------------------------------  FASE2  --------------------------------}


 PROCEDURE FASE2;

var QC,QC2:ore;         { Buffer per le 24 ore usato da CalcQC con dati
                          relativi a Mese,Esp,Strutt,Temperatura di una Zona }

{---------------------------------  IDT  -------------------------------------}

FUNCTION IDT(H,M,E:INTEGER):REAL;
{Calcolo dei coseni direttori, dell'angolo di incidenza, della radiazione
 diretta, di YS, della radiazione diffusa e totale su esposizione             }
const C : array[1..12] of real
        = (0.058,0.060,0.071,0.097,0.121,0.134,0.136,0.122,0.092,0.073,0.063,0.057);
VAR
  k,UU,BE,GA,NH,YS,IDR,IDF,AL,var1,var2,var3:REAL;
  Com:INTEGER;
BEGIN
  k:=PI/180;
    IF Esposizioni_D^[E].Inclin<>180 THEN
    BEGIN
      WITH Esposizioni_D^[E] DO
      BEGIN
                             { FST=angolo azimuth     SND=inclinazione }
        AL:=COS(Inclin*k);
        UU:=SIN(Inclin*k);
        BE:=SIN(Orient*k)*SIN(Inclin*k);
        GA:=COS(Orient*k)*SIN(Inclin*k);
      END;

      NH:=AL*R3^[H,M]+BE*R1^[H,M]+GA*R2^[H,M];
      Com:=(H+1) mod 24;   IF H=24 THEN H:=0;
      if (NH <= 0.0)  OR  ( R3^[H,M]-SIN(Orizzonte_D^[Com]*PI/180) <= 0)
        then IDR:=0
        else IDR:=IDN^[H,M]*NH*Localita_D^.FattFoschia;

      if NH > -0.2 then YS:=0.55+0.437*NH+0.313*sqr(NH)
                   else YS:=0.45;

      {

      IDF:=IDN^[H,M]/Localita_D^.FattFoschia*((C[M]*AL)+
           ((C[M]*YS+0.5*Localita_D^.Riflettivita*(C[M]+R3^[H,M]))*UU));
      }
      var1:=C[M]*AL;
      var2:=C[M]*YS;
      var3:=C[M]+R3^[H,M];
      var3:=var3*Localita_D^.Riflettivita*0.5;
      var3:=var3+var2;
      var3:=var3*uu;
      var3:=var3+var1;
      var1:=IDN^[H,M]/Localita_D^.FattFoschia;
      idf:=var1*var3;


      IDT:=IDR+IDF;

    END
    ELSE
      IDT:=0;
END;  { PROC. IDT }


{---------------------------------  CalcQCPT  --------------------------------}

PROCEDURE CalcQCPT;
{ Calcola il valore di QCPT e lo somma immediatamente a QCTOT in modo da non
  dovere memorizzare i valori di QCPT separatamente                           }
VAR
  H,M,A,E,F:INTEGER;
  TSP,Temp:REAL;
BEGIN
   OpenCan(1,'QCTOT'   ,0,2);
   FOR F:=1 TO NFrontiereLin DO
   WITH FrontiereLin_D^[F]^ DO
   BEGIN
     A:=CodAmb;
     E:=CodEsp;
     if (A > 0) and (a <= NAmbienti) and (E > 0) and ( E <= MaxEsposizioni) then {*E*}
    { (E in [1..MaxEsposizioni])}
      begin
         Temp:=Zone_D^[Ambienti_D^[A]^.Zona].TEst;
{E}         IF UpCase(Esposizioni_D^[E].Tipo[1]) = CH7 THEN
         FOR M:=MeseInizio TO MeseFine DO
          FOR H:=0 TO 23 DO
           BEGIN
              TSP:=Te^[H,M] +  0.6 * IDT(H,M,E) / 23;
              LoadHM(1,A);
              if CodPonte1 in [1..MaxPonti] then
                dat^[1,H,M]:=dat^[1,H,M]+(LUNG1*Kappa_PT^.K(F){Ponti_D^[CodPonte1].KL})*(TSP-Temp);
              if CodPonte2 in [1..MaxPonti] then
                dat^[1,H,M]:=dat^[1,H,M]+(LUNG2*Kappa_PT^.K(F){Ponti_D^[CodPonte2].KL})*(TSP-Temp);
           END;
      end;
   END;    { FOR F:=1 TO NFrontiereLin }
  CloseHM(1);
END;    { PROC. CalcQCPT }

{-----------------------------  CalcDatiAmbiente  ----------------------------}

PROCEDURE CalcDatiAmbiente;
VAR
  A,H,M,F,N,Npersone:INTEGER;

BEGIN
  OpenCan(2,'QIRRTOT' ,0,2);
  OpenCan(3,'QIRCTOT' ,0,2);
  OpenCan(4,'ILLTOT'  ,NAmbienti,2);

  OpenCan(1,'OCSTOT'  ,NAmbienti,1);
  OpenCan(2,'OCLTOT'  ,NAmbienti,1);
  OpenCan(3,'APSTOT'  ,NAmbienti,1);
  OpenCan(4,'APLTOT'  ,NAmbienti,1);

  FOR A:=1 TO NAmbienti DO

  BEGIN

 //   GOTOXY(1,8);  ClrEol;
 //   str(Ambienti_D^[A]^.codnum:5:0,st_8);
 //   WRITEC(W_M(125)+' '+st_8,1);  {'Calcolo dell`apporto delle sorgenti interne.   Ambiente nø : '}

    if (A>=1)and(a<=NAmbienti) then    {maxambienti}
     WITH Ambienti_D^[A]^ DO
      BEGIN
        LoadHM(2,A);  { QIRRTOT }
        LoadHM(3,A);  { QIRCTOT }
        LoadHM(4,A);  { ILLTOT  }

        LoadH(1,A);   { OCSTOT  }
        LoadH(2,A);   { OCLTOT  }
        LoadH(3,A);   { APSTOT  }
        LoadH(4,A);   { APLTOT  }

        FOR M:=MeseInizio TO MeseFine DO

         BEGIN

           FOR H:=0 TO 23 DO

            BEGIN

            {******  Illuminazione  ******}

            if (Superficie > 0) and (ProfiloIlluminaz in [1..MaxProfili]) then

               begin

               IF (dat^[2,H,M]+dat^[3,H,M])/Superficie < IlluminazVar THEN

                  dat^[4,H,M]:=  (IlluminazFissa+IlluminazVar)*
                                                   Superficie*
                               Profili_D^[ProfiloIlluminaz,H]/
                                                          100
                  ELSE

                  dat^[4,H,M]:=                IlluminazFissa*
                                                  Superficie*
                              Profili_D^[ProfiloIlluminaz,H]/
                                                         100;
               end

               else dat^[4,H,M]:=0;

                            {*****  Occupazione  *****}
             { TODO -oDiego -cERRORIMC4 : Profilo occupazione non viene controllato se è=0 }
            if ProfiloOccupaz in [1..MaxProfili] then

              begin
              datb^[1,H]:=                    Npersone*
                                     SensibilePersona*
                         Profili_D^[ProfiloOccupaz,H]/
                                                  100;

              datb^[2,H]:=                    Npersone*
                                       LatentePersona*
                         Profili_D^[ProfiloOccupaz,H]/
                                                  100;
              end
            else
              begin
              datb^[1,H]:=0;
              datb^[2,H]:=0;
              end;
                       {********  Apparecchiature  *********}

              if ProfiloApparecch in [1..MaxProfili] then

               begin

                  datb^[3,H]:=Profili_D^[ProfiloApparecch,H]*
                                              SensApparecch/
                                                        100;

                  datb^[4,H]:=Profili_D^[ProfiloApparecch,H]*
                                           LatenteApparecch/
                                                        100;
                end

              else

                begin

                  datb^[3,H]:=0;
                  datb^[4,H]:=0;

                end;

            END;    { FOR H:=0 TO 23 DO...........}

         END;    { For M:=1 TO....... }

      END; { WITH Ambienti_D^[A] DO.......}

  END;  { FOR A:=1 TO NAmbienti DO.............. }

  FOR N:=2 TO 4 DO CloseHM(N);
  FOR N:=1 TO 4 DO CloseH(N);

END;   { PROC. CalcDatiAmbiente }


{--------------------- Calcolo di TS -----------------------}

FUNCTION TS(H,M,E,S:INTEGER):REAL;
VAR
  A_S:REAL;
BEGIN
  CASE UpCase(Muri_D^[s].Colore[1]) OF
{C}    CH9:A_S:=0.65;
{M}    CH10:A_S:=0.83;
{S}    CH11:A_S:=1;
    ELSE A_S:=1;
  END;
  IF Esposizioni_D^[E].Inclin <> 180 THEN
    A_S:=Te^[H,M]+(A_S*IDT(H,M,E)/17)-(3.9*COS(Esposizioni_D^[E].Inclin*PI/180))
  ELSE A_S:=Te^[H,M];

  TS:=A_S;
END;    { FUNC.   TS }

{-------------------- Calcolo di TSP -----------------------}

FUNCTION TSP(H,M,E,P:INTEGER):REAL;
VAR
  A_S:REAL;
BEGIN
  CASE UpCase(Porte_D^[p].Colore[1]) OF
{C}    CH9:A_S:=0.65;
{M}    CH10:A_S:=0.83;
{S}    CH11:A_S:=1;
    ELSE A_S:=1;
  END;
  TSP:=Te^[H,M]+(A_S*IDT(H,M,E)/23);
END;   { FUNC. TSP }

{-------------------------  QCF  ---------------------------}

FUNCTION QCF(H,M,F:INTEGER;Temp:REAL):REAL;
BEGIN
  IF F IN [1..MaxFinestre] THEN
    QCF:=Finestre_D^[F]{.fin_cart}.Trasmittanza*(Te^[H,M]-Temp)*Finestre_D^[F]{.fin_cart}.IncrSic
  ELSE
    QCF:=0;
END;   { FUNC. QCF }

{-------------------------  QCP  ---------------------------}

FUNCTION QCP(H,M,E,P:INTEGER;Temp:REAL):REAL;
BEGIN
  IF P IN [1..MaxPorte] THEN
    QCP:=Porte_D^[P].Trasmittanza*(TSP(H,m,e,P)-Temp)*Porte_D^[P].IncrSic
  ELSE
    QCP:=0;
END;   { FUNC. QCP }

{---------------------------  KT  --------------------------}

FUNCTION KT(M:INTEGER):REAL;
BEGIN
  with Localita_D^ do
   KT:=(TmaxBS[M]-TInvEsternaBS)/(TEstEsternaBS-TInvEsternaBS);
END;    { FUNC. KT }

{--------------------------  TConf Nuccio 11-94 -------------------------}
Function TConf(Nfro:integer):Real;
var IndA:integer;
begin
with frontiere_d^[Nfro]^ do
 begin
   if inrange(CodEsposiz,1,maxEsposizioni) then TcOnf:=Esposizioni_D^[CodEsposiz].TrifEst
   else
    begin
       IndA:=IndLocNRis(codesposiz);
       if inrange(IndA,1,NAmbienti) then Tconf:=Zone_d^[Ambienti_d^[IndA]^.Zona].Test
       else TConf:=0;
    end;
 end;
end;

{--------------------------  QCI  --------------------------}

FUNCTION QCI(rg,M,I,S:INTEGER;Temp:REAL):REAL;
Var TQcI:real;
BEGIN
  IF (S>=1)and(S<=Nmuri) {IN [1..NMuri]} THEN
    TQCI:=Strutture_D^[Muri_D^[S].CodArch]^.Trasmitt*
         ({Esposizioni_D^[I].TrifEst}Tconf(rg)*KT(M)-Temp)*
         Muri_D^[S].IncrSic
  ELSE
    TQCI:=0;
QCI:=TQci;
END;       { FUNC. QCI }


{--------------------------  QCIP  -------------------------}

FUNCTION QCIP(rg,M,I,P:INTEGER;Temp:REAL):REAL;
Var TQcIP:real;
BEGIN
  IF P IN [1..MaxPorte] THEN
    TQCIP:=Porte_D^[P].Trasmittanza*(Tconf(rg){Esposizioni_D^[I].TrifEst}*KT(M)-Temp)*
          Porte_D^[P].IncrSic
  ELSE
    TQCIP:=0;
QCIP:=TQciP;
END;       { FUNC. QCIP }

{--------------------------  QCIF  -------------------------}

FUNCTION QCIF(rg,M,I,F:INTEGER;Temp:REAL):REAL;
Var TQcIF:real;
BEGIN
  IF F IN [1..MaxFinestre] THEN
    TQCIF:=Finestre_D^[F]{.fin_cart}.Trasmittanza*(Tconf(rg){Esposizioni_D^[I].TrifEst}*KT(M)-Temp)*
          Finestre_D^[F]{.fin_cart}.IncrSic
  ELSE
    TQCIF:=0;
QCIF:=TQciF;
END;       { FUNC. QCIF }



{------------------------------  CalcQC  -----------------------------------}

{Determinazione del flusso attraverso una parete}
PROCEDURE CalcQC(M,ee,ss,mur:INTEGER;Temp:REAL);
VAR
  Trovato:boolean;
  IOERR,C,h,Com,Com1,Com2:integer;
  TSItot,TSItotPrec,A_S:real;
  TSI:ARRAY[0..23] OF REAL;
  TSCom:ARRAY[0..23] OF REAL;
  TSIprec:ARRAY[0..23] OF REAL;
  Var TempNK,TempB0,TempB1,TempSc,TempD1:Real;
BEGIN
  FOR H:=0 TO 23 DO
  BEGIN
    QC[H]:=0;
    TSI[H]:=Temp;
    TSIprec[H]:=0;
    IF SS IN [1..MaxStrutture] THEN TSCom[H]:=TS(H,m,ee,mur)
    else TSCom[H]:=Temp;
  END;

TempNK:=STRUTTURE_D^[SS]^.NK;
TempB0:=STRUTTURE_D^[SS]^.B0;
TempB1:=STRUTTURE_D^[SS]^.B1;
TempSc:=STRUTTURE_D^[SS]^.Sc;
TempD1:=STRUTTURE_D^[SS]^.D1;


  IF NOT (SS IN [1..MaxStrutture]) THEN EXIT;

  TSItotPrec:=0;
  Trovato:=false;
  REPEAT
     TSItot:=0;
     Trovato:=FALSE;
     WITH Strutture_D^[ss]^ DO
      BEGIN
        FOR h:=0 TO 23 DO
         BEGIN

            TSI[H]:= D1*TSI[(H+23) MOD 24]      +
                     B0*TSCom[(h-Nk+24) MOD 24] +
                     B1*TSCom[(h-Nk+23) MOD 24] +
                     Temp*Sc;
         END;   {  h  }
      END;

     H:=0;
     REPEAT
        IF ABS(TSI[H]-TSIprec[H])>0.01 THEN
         BEGIN
           FOR C:=0 TO 23 DO TSIprec[C]:=TSI[C];
           H:=24;
         END;
        H:=H+1;
     UNTIL H>=24;

     IF H<25 THEN
      BEGIN
         FOR h:=0 TO 23 DO
          begin
             QC[h]:=Strutture_D^[ss]^.Hi*(TSI[H]-Temp);
          end;

         Trovato:=TRUE;
      END;

     TSItotPrec:=TSItot;
     TSItot:=0;
  UNTIL Trovato




END;    { FUNC.  CalcQC }



VAR
  ZoneIsoterme:SET OF 1..20;    { Insieme su cui si lavora attualmente        }
  ZoneGiaUsate:SET OF 1..20;    { Insieme per cui si sono gia fatti i calcoli }
  Temperatura:REAL;             { Temperatura comune alle zone isoterme       }
  N,Z,I,H,M,F,E,A:INTEGER;




{---------------------------  FASE2  -----------------------------}
var Fdeb:textfile;
    prima:real;

procedure debqc(step:string;amb,front:integer);
begin
//if (prima>=0)and(dat^[1,14,7]<0) then
if uppercase(ambienti_d^[amb].denom)='DIS._APT' then
WITH Frontiere_D^[Front]^ DO
      BEGIN

      prima:=-1;
             if (Esposizioni_D^[CodEsposiz].Tipo<>'E')and(Esposizioni_D^[CodEsposiz].TrifEst=0) then
              writeln(fdeb,step+'-Locale:'+ambienti_d^[amb].denom,
                           ' Frontiera:'+Inttostr(front),
                           ' Esposizione:'+Esposizioni_D^[CodEsposiz].codice,
                           ' tipo:'+Esposizioni_D^[CodEsposiz].Tipo,
                           ' Test:'+inttostr(round(Esposizioni_D^[CodEsposiz].TrifEst))
                           
              );

      end;
end;
procedure sPrima;
begin
prima:=dat^[1,14,7];
end;
BEGIN
//assign(fdeb,'N:\debugestivo.txt');
//rewrite(fdeb);
if not erroregen then
  begin
  OpenCan(1,'QCTOT'   ,NAmbienti,2);
  OpenCan(2,'QIRRTOT' ,NAmbienti,2);
  OpenCan(3,'QIRCTOT' ,NAmbienti,2);


  FOR A:=1 TO NAmbienti DO

    BEGIN

    LoadHM(1,A);  { QCTOT   }
    LoadHM(2,A);  { QIRRTOT }
    LoadHM(3,A);  { QIRCTOT }

    //sprima;

    FOR F:=1 TO NFrontiere DO

    WITH Frontiere_D^[F]^ DO

      BEGIN
      if (upcase(Esposizioni_D^[CodEsposiz].Tipo[1])<>'E')and
         (Esposizioni_D^[CodEsposiz].trifest<zone_D^[AMBIENTI_D^[A]^.ZONA].TEst)
      then warn(S_locale+':'+AMBIENTI_D^[A]^.denom+' ha esposizione verso confine con temperatura bassa :'+Esposizioni_D^[CodEsposiz].denom+'('+floattostr(Esposizioni_D^[CodEsposiz].trifest)+')');
      IF CodAmb = A THEN

      FOR M:=MeseInizio TO MeseFine DO

        BEGIN

        Temperatura:=TI(M,AMBIENTI_D^[A]^.ZONA);

        E:=CodEsposiz;
        {$B-}
{E}       {IF Esposizioni_D^[CodEsposiz].Tipo[1])=Esposizioni_D^[CodEsposiz].Tipo[1])=CH7 THEN}
          if inrange(CodEsposiz,1,maxEsposizioni) then
          begin   {begin x}
          IF (UpCase(Esposizioni_D^[CodEsposiz].Tipo[1])=CH7) THEN
          { mettere $b- Nuccio}

          {**** ESPOSIZIONI ESTERNE *****}

          BEGIN

          if codmuro2<>0 then

          CalcQC(M,E,Muri_D^[CodMuro2].CodArch,codmuro2,Temperatura);

 //  Diego (sembra errore eclatante ???)       else calcQC(m,e,0,0,temperatura);


          QC2:=QC;

          CalcQC(M,E,Muri_D^[CodMuro].CodArch,codmuro,Temperatura);
          //if qc[14]<0 then
          //CalcQC(M,E,Muri_D^[CodMuro].CodArch,codmuro,Temperatura);

          FOR H:=0 TO 23 DO

            begin

            QC[H]:=QC[H]*Muri_D^[CodMuro].IncrSic;
            IF CodMuro2<>0 THEN
            QC[H]:=QC[H] + QC2[H]*Muri_D^[CodMuro2].IncrSic;

            end;

            FOR H:=0 TO 23 DO

            BEGIN
            //prima:=dat^[1,H,M];

            dat^[1,H,M]:=                                  dat^[1,H,M]+
                                                        QC[H]*SupMuro+
                          QCF(H,M,CodFinestra,Temperatura)*SupFinestra+
                           QCP(H,M,E,CodPorta ,Temperatura)*SupPorta;


            IF CodFinestra in [1..MaxFinestre] then

              BEGIN
              { TODO -oDiego -cStruttura : Calcolo irraggiamento finestra }
{I}              IF UpCase(Finestre_D^[CodFinestra]{.fin_cart}.PosizSchermo[1])= CH8 THEN


              dat^[2,H,M]:=dat^[2,H,M]+QIW(H,M,E,CodFinestra)*SupFinestra

              ELSE   dat^[3,H,M]:=dat^[3,H,M]+QIW(H,M,E,CodFinestra)*SupFinestra;

              END;

            END;   { FOR H:=0 TO 23 DO.......... }

          END

          ELSE

          {***** ESPOSIZIONE INTERNA *********}
            begin
            FOR H:=0 TO 23 DO

            dat^[1,H,M]:=                                 dat^[1,H,M]+
                               QCI(f,M,E,CodMuro,Temperatura)*SupMuro+
                      QCIF(f,M,E,CodFinestra,Temperatura)*SupFinestra+
                         QCIP(f,M,E,CodPorta   ,Temperatura)*SupPorta;

            end
         end; {begin x}
        END;  { FOR M=MeseInizio TO MeseFine DO.......... }

      //debqc('end',a,f);
      END; { FOR F:=1 TO NFRONTIERE }

    END;  { FOR A:=1 TO  NAMBIENTI }

//close(fdeb);

  FOR N:=1 TO 3 DO CloseHM(N);

  CalcQCPT;


  CalcDatiAmbiente;
  end;
END;

end.