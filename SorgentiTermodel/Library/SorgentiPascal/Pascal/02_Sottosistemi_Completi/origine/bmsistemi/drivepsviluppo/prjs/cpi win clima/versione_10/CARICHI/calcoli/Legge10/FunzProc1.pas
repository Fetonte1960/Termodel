Unit FunzProc1;

INTERFACE

Uses
  SysUtils, Varcarichi, UVariabili, utireport,
  LibreriaGenerale, Metod10, URicercaDati;

  function CalcApport:real;
  function Log10(Num:real): real;
  function GiorMese(i:Smallint):Smallint;
  function TempCalc(mese:Smallint):real;
  function DescrizioneImpianto(CodiceGeneratore:String):String;
  function DTEstZona(mese:Smallint):real;
  function Nag:real;
  function HTrasmEspNonRisc:real;
  function CalcTc:real;
  function CalcGamma(mese:Smallint):real;
  procedure caricaAB(var a,b:real);
  procedure CalcolaZona(Mese:Smallint);
  function Portata_N:real;
  function CalcK(mese:Smallint):real;
  function CalcEe:real;
  function CalcEc(Mese:Smallint):real;
  function PerdPd:real;
  function CalcTa1(mese:Smallint):real;
  function CalcTa(mese,TipoCalc:Smallint):real;
  function CalcVolRisc(CalcZ:Smallint):real;
  function CalcSupRisc(CalcZ:Smallint):real;
  function IntersEtu(NumCp:real):real;
  procedure calcQ_Gen(mese,tipoCalc:Smallint);
  function MeseIntero(Mese:Smallint):boolean;
  procedure TrovaMeseInsol;
  function PortataMec:real;
  function CalcEu(mese:Smallint):real;
  function Ndg:real;

implementation

function Log10(Num:real):real;
begin
   if Num > 0 then Log10:=ln(Num)/ln(10)
   else Log10:=0;
end;

function GiorMese(i:Smallint):Smallint;
var n:Smallint;
begin
   n:=30;
   case i of
     4,6,9,11 : n:=30;
     2        : n:=28;
     1,3,5,7,8,10,12 : n:=31;

   end;
   GiorMese:=n;
end;

function TempCalc(mese:Smallint):real;
begin
   if Prog^.TempOff = '*' then TempCalc:=TempIntMed^[zonaCalc,mese]
   else TempCalc:=pdati10.TiAmbx;
end;

function DescrizioneImpianto(CodiceGeneratore:String):String;
var
i: integer;
begin
 Result := '';
 for i:= 1 to NImpianti do
  if CompareStr(UpperCase(ImPianto_D^[i].GenInvt), Uppercase(CodiceGeneratore)) = 0 then
  begin
    Result := ImPianto_D^[i].Descrizione;
    exit;
  end;
end;


function DTEstZona(mese:Smallint):real;
begin
   if Prog^.TempOff = '*' then
     DTEstZona:=TempIntMed^[zonacalc,mese]-TempEstMed^[mese]
   else
     DTEstZona:=pdati10.TiAmbx-TempEstMed^[mese];
end;

// Emanuela funzione modificata affinchè vengano presi i dati giusti dell'impianto relativi
// al generatore esaminato, dato che i dati memorizzati in zona non garantiscono questo
function Nag:real;
var
  i, GiorniW: Integer;
  Trovato: Boolean;
begin
  Trovato := False;
  i := 1;
  while (i <= NImpianti) and (not Trovato) do
  begin
    if CompareStr(UpperCase(ImPianto_D^[i].GenInvt), UpperCase(DescGen1^[gencor].Descrizione)) = 0 then
    begin
      GiorniW := ImPianto_D^[i].DayWeekOff;
      Trovato := True;
    end;
    inc(i);
  end;
   //if Zone10^[ZonaCalc].DayWeekOff > 0 then
  if GiorniW > 0 then
     Nag:=24-(24-pdati10.nag)*((7-GiorniW)/7)
   else Nag:=pdati10.nag;
end;

// Emanuela funzione modificata affinchè vengano presi i dati giusti dell'impianto relativi
// al generatore esaminato, dato che i dati memorizzati in zona non garantiscono questo
function Ndg:real;
var
  i, GiorniW: Integer;
  Trovato: Boolean;
begin
  Trovato := False;
  i := 1;
  while (i <= NImpianti) and (not Trovato) do
  begin
    if CompareStr(UpperCase(ImPianto_D^[i].GenInvt), UpperCase(DescGen1^[gencor].Descrizione)) = 0 then
    begin
      GiorniW := ImPianto_D^[i].DayWeekOff;
      Trovato := True;
    end;
    inc(i);
  end;
   //if Zone10^[ZonaCalc].DayWeekOff > 0 then
   if GiorniW > 0 then
     Ndg:=24-(24-pdati10.ndg)*((7 - GiorniW)/7)
   else Ndg:=pdati10.ndg;
end;

function HTrasmEspNonRisc:real;
var i:Smallint;
    TotHNR:real;
begin
   TotHNr:=0;
   for i:=1 to Nesposizioni do
    begin
       if TotHEspLocFissi^[i] > 0 then TotHNr:=TotHNr+TotHEspLocFissi^[i];
    end;
   HTrasmEspNonRisc:=TotHnr;
end;


{function CalcTc(mese:Smallint):real;}
function CalcTc:real;
var Tc,Hk:real;
 begin
{    Hk:=Ql^[mese]/(86400*GiorMese(mese)*DTEstZona(Mese));}
    //Hk:=HgZona+prn_totH^.HtotZona+HTrasmEspNonRisc;
    Hk:=prn_totH^.HTerreno + prn_totH^.HtotZona + HTrasmEspNonRisc;
    if Hk <> 0 then Tc:=(1000*CapTermZona)/(Hk*3600)
    else Tc:=21;
    if Tc > 80 then Tc:=80;
    if Tc < 20 then Tc:=20;
    CalcTc:=Tc;
 end;


function CalcGamma(mese:Smallint):real;
 begin
    if (Ql^[mese]-TotQse^[mese]) <> 0 then CalcGamma:=(TotQsi^[mese]+Qi^[ZonaCalc])/(Ql^[mese]-TotQse^[mese])
    else CalcGamma:=0;
 end;

function CalcEu(mese:Smallint):real;
const  A0=1; T0=16;
var Gamma1,A,Tc:real;
 begin
    Tc:=CalcTc;
    A:=a0+(Tc/T0);
    Gamma1:=CalcGamma(Mese);
    if Gamma1=1 then CalcEu:=A/(A+1)
    else CalcEu:=(1-Esp(Gamma1,A))/(1-Esp(Gamma1,A+1));
 end;

procedure caricaAB(var a,b:real);
begin
  case pdati10.CodTipoTerm of
  {$IFDEF VERSIONE_13}
    1,2,3:begin
            a:=1;
            b:=1;
          end;
        4:begin
            a:=0.85;
            b:=0.75;
          end;
        5:begin
            a:=0.7;
            b:=0.6;
          end;
      6,7:begin
            a:=0.55;
            b:=0.35;
          end;
        8:begin
            a:=0.40;
            b:=0.3;
          end;
   {$ELSE}
    1,2,3:begin
            a:=1;
            b:=1;
          end;
        4:begin
            a:=0.85;
            b:=0.75;
          end;
        5:begin
            a:=0.55;
            b:=0.35;
          end;
        6:begin
            a:=0.40;
            b:=0.3;
          end;
   {$ENDIF}
   end;
end;

function CalcK(mese:Smallint):real;
var risult:real;
    DtSb:real;
 begin
    DtSb:=Zone10^[ZonaCalc].TAria-Zone10^[ZonaCalc].TempMin;
{    if DtSb > 8 then write(chr(7),' dt sp maggiore di 8 ');}

    Risult:=1+(0.085-0.011*DtSb-0.00055*CalcTc)*(0.35*Nag-1.8);
    if risult > 1 then CalcK:=Risult
    else calcK:=1;
 end;

 function CalcEe:real;
 begin
   CalcEe:= pdati10.RendTerm;
 end;

function CalcEc(Mese:Smallint):real;
begin
   CalcEc := pdati10.RendReg(mese);
end;

procedure CalcolaZona(Mese:Smallint);
var i:Smallint;
    Ee,Ec,Eu,Tc:real;
    Str1:string;
begin
   with TabZona10^ do
   begin
       nag1:=pdati10.nag;
       ndg1:=pdati10.ndg;
       goff:=Zone10^[ZonaCalc].DayWeekOff;
       Nag2:=nag;
       Ndg2:=ndg;
       Tc:=calcTc;
       term:=pdati10.TipoTerm;
       CaricaAB(A,B);
       t1:=1.05*Nag+0.9*Ndg;
       t2:=Nag+0.6*Ndg;
       fil1:=((0.3*t1-1)*DTEstZona(mese)-24.4*t1*(1+EXP(1.5-0.15*Tc))+1072)/1000;
       fig1:=((Nag+0.2)*DTEstZona(mese)-32.8*t2+1070*(1+exp(0.2-0.16*Tc)))/1000;
       Fil^[mese]:=1-(A*(1-fil1));
       Fig^[mese]:=1-(B*(1-fig1));
       if Zone10^[ZonaCalc].TempMin = 0  then
       begin
           k:=1;
           Dsb:='Spegnimento';
       end
       else
       begin
           k:=CalcK(mese);
           Dsb:='        [øC]';
           Str(Zone10^[ZonaCalc].TAria-Zone10^[ZonaCalc].TempMin:4:2,Str1);
           i:=length(Str1);
           delete(Dsb,1,i);
           insert(str1,Dsb,1);
       end;

       Ee:=CalcEe;
       Ec:=CalcEc(mese);
       Eu:=CalcEu(Mese);

       if (Zone10^[ZonaCalc].NoreNotte+Zone10^[ZonaCalc].NoreGiorno+Zone10^[ZonaCalc].dayweekoff) = 0 then
       begin
           MatQhvs^[Mese,ZonaCalc]:=(Ql^[mese]-TotQse^[Mese])-Eu*(TotQsi^[Mese]+Qi^[ZonaCalc]);
           Fil^[mese]:=1;
           Fig^[mese]:=1;
           k:=1;
       end
       else
        MatQhvs^[Mese,ZonaCalc]:=k*(Fil^[mese]*(Ql^[mese]-TotQse^[mese])-Eu*Fig^[mese]*(TotQsi^[Mese]+Qi^[ZonaCalc]));

       if MatQhvs^[Mese,ZonaCalc] < 1 then MatQhvs^[Mese,ZonaCalc]:=0; { < 0 metto min di 1 perche mi stampava lo 0}

       if (Ee*Ec) > 0 then
       begin
           MatQhr24^[Mese,ZonaCalc]:=(((Ql^[mese]-TotQse^[Mese])-Eu*(TotQsi^[Mese]+Qi^[ZonaCalc]))/(Ee*Ec))+
                                     Zone11^[zonacalc].Poth2o;
           MatQhr^[Mese,ZonaCalc]:=(MatQhvs^[Mese,ZonaCalc]/(Ee*Ec))+Zone11^[zonacalc].Poth2o;
           Toth2o:=Toth2o+Zone11^[zonacalc].Poth2o*(Ee*Ec);
       end
       else
       begin
           MatQhr^[Mese,ZonaCalc]:=0;
           MatQhr24^[Mese,ZonaCalc]:=0;
       end;

       if MatQhr^[Mese,ZonaCalc] < 1 then MatQhr^[Mese,ZonaCalc]:=0;   { < 0  }
       if MatQhr24^[Mese,ZonaCalc] < 1 then MatQhr24^[Mese,ZonaCalc]:=0;

       if Ee <> 0 then QhrEe:=QhrEe+(MatQhvs^[Mese,ZonaCalc]/Ee);
       if Ec <> 0 then QhrEc:=QhrEc+(MatQhvs^[Mese,ZonaCalc]/Ec);
    end;
end;

function PerdPd:real;
var Ind:Smallint;
begin
   if pdati10.Pd > 0 then PerdPd:=pdati10.Pd
   else
    begin
       //Ind:=pos_combo(drivecombo,'Generatore','TipoInvol',pdati10.TipoInvol);
       ind := IndGeneratoreTipoInvolucro(pdati10.TipoInvol);
       case Ind of
        1:PerdPd:=1.72-0.44*log10(pdati10.PFoc/1000);
        2:PerdPd:=3.45-0.88*log10(pdati10.PFoc/1000);
        3:PerdPd:=6.90-1.76*log10(pdati10.PFoc/1000);
        4:PerdPd:=8.63-2.20*log10(pdati10.PFoc/1000);
        5:PerdPd:=10.35-2.64*log10(pdati10.PFoc/1000);
        else PerdPd:=1.72-0.44*log10(pdati10.PFoc/1000);
       end;
    end;
end;

{unction PerdPfbs:real;
var Ind:Smallint;
begin
   if pdati10.Pfbs > 0 then PerdPfbs:=pdati10.Pfbs
   else
    begin
       Ind:=pos_ins('descgen',15,pdati10.TipoCamin);
       case ind of
        1:PerdPfbs:=0.1;
        2:PerdPfbs:=0.6;
        3:PerdPfbs:=0.8;
        4:PerdPfbs:=0.6;
        else PerdPfbs:=0.1;
       end;
    end;
end;
}



function CalcTa1(mese:Smallint):real;
var gm:Smallint;
    mf,mi:byte;
    a,b:Smallint;
begin
  mi:=IndMese^[1];
  mf:=IndMese^[mesirisc];
  if mese =mi then
  begin
    GM:=GiorMese(IndMese^[1])-(prog^.GiornoIn-1);
    calcta1:=(24-Nag-Ndg)*3600*Gm;
  end
  else
  if mese =mf then
  calcta1:=(24-Nag-Ndg)*3600*Prog^.GiornoFin
  else calcta1:=(24-Nag-Ndg)*3600*GiorMese(mese);
     {  if mese <> mesirisc then calcta1:=(24-Nag-Ndg)*3600*GiorMese(mese)
                           else calcta1:=(24-Nag-Ndg)*3600*Prog^.GiornoFin;}
end;


function CalcTa(mese,TipoCalc:Smallint):real;
begin
   if TipoCalc = 0 then
       CalcTa:=24*3600*GiorMese(mese)
   else
     CalcTa:={(24-Nag-Ndg)*3600*GiorMese(mese);}Calcta1(mese);
end;




function CalcVolRisc(CalcZ:Smallint):real;
var
   i, j:Smallint;
   Vol:real;
begin
   Vol:=0;
   for i:=1 to NAmbienti do
    with Ambienti_D^[i]^ do
     begin
      // Emanuela 26/7/2006 non considerazione dei locali non riscaldati
      if CompareStr(UpperCase(Ambienti_D^[i].Impianto), 'NESSUNO') <> 0 then
      begin
        if CalcZ > 0 then
         begin
            //j := CodiceImp(Ambienti_D^[i].Impianto);
            j := CodiceImpianto(Ambienti_D^[i].Impianto);
            if ((z10=CalcZ) and
               (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[j].GenInvt)) = 0))
            then
               Vol:=Vol+(hsoffitto*superficie*AmbientiUguali);
            //if (zone_d^[Zona].ZonaLegge10=CalcZ) then Vol:=Vol+(hsoffitto*superficie*AmbientiUguali);
         end
        else
        if (Z10 > 0) then Vol:=Vol+(hsoffitto*superficie*AmbientiUguali);
        //if (Zone_D^[Zona].Zonalegge10 > 0) then Vol:=Vol+(hsoffitto*superficie*AmbientiUguali);
      end;
     end;
   CalcVolRisc:=Vol;
end;


function CalcSupRisc(CalcZ:Smallint):real;
var
   i:Smallint;
   Sup:real;
begin
   Sup:=0;
   for i:=1 to NAmbienti do
    with Ambienti_D^[i]^ do
     begin
        if CalcZ > 0 then
         begin
            if ((z10=CalcZ) and
               (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[i].Impianto)].GenInvt)) = 0))
            then Sup:=Sup+superficie*AmbientiUguali;
            //if (zone_d^[Zona].ZonaLegge10=CalcZ) then Sup:=Sup+superficie*AmbientiUguali;
         end
        else
        if (Z10 > 0) then Sup:=Sup+superficie*AmbientiUguali;
        //if (Zone_D^[Zona].Zonalegge10 > 0) then Sup:=Sup+superficie*AmbientiUguali;
     end;
   CalcSupRisc:=Sup;
end;

function IntersEtu(NumCp:real):real;
var I:Smallint;
    trovato:boolean;
    Cp1,Cp2,Etu1,Etu2:real;
begin
{
   i:=10;
   NumCp:=NumCp*100;
   Trovato:=false;
   repeat
     Trovato:=DescGen^.TabCp[i].Cp <= NumCp;
     if Not Trovato then i:=i-1;
   until Trovato or (i=1);
   if i=10 then IntersEtu:=DescGen^.TabCp[i].Eu/100;
   if i=1 then IntersEtu:=DescGen^.TabCp[i].Eu/100;
   if (i > 1) and (i < 10) then
    begin
       Cp1:=DescGen^.TabCp[i].CP;
       Cp2:=DescGen^.TabCp[i+1].CP;
       Etu1:=DescGen^.TabCp[i].Eu;
       Etu2:=DescGen^.TabCp[i+1].Eu;
       IntersEtu:=(Etu1+((NumCp-CP1)/(CP2-CP1))*(Etu2-Etu1))/100;
    end;
}    
end;

procedure calcQ_Gen(mese,tipoCalc:Smallint);
var {DtH20Zona:real;
    Qpo1,Qbr1:real;
    Ta:real;}
    {Cop:real;}
    Ind:Smallint;
    RFc:real;
    pd2,pf2,pfbs2,dt2:real;
    { qbr e qpo sono in W per cui li moltiplico per i secondi di funzionamento}
begin
   Generat^.Ta:=CalcTa(mese,tipoCalc);
   Generat^.Qpo1:=(pdati10.Qpo*Generat^.Ta)/1000000;
   Generat^.Qbr1:=(pdati10.Qbr*Generat^.Ta)/1000000;
   Generat^.DtH20Zona:=DescGen^.TempH2o-Zone10^[1].Taria;
  // Ind:=pos_combo(drivecombo,'Generatori','Tipo',DescGen^.Tipo);
   Ind := IndGeneratoreTipo(DescGen^.Tipo);
   if Ind in [1..2] then
   BEGIN
     if descGen^.flagCp = '*' then
      with Generat^ do
      begin
         if (pdati10.PNomUtil*Ta) <> 0 then
         Cp:=(Qp^[Mese]-(Qpo1*pdati10.Epo))/((pdati10.PNomUtil*Ta)/1000000)
         else Cp:=0;
         Etu:=IntersETU(Cp);
         if Etu <> 0 then Qc:=(Qp^[Mese]-Qpo1*pdati10.Epo)/Etu
         else Qc:=0;
         Etu100:=DescGen^.Rend100/100;
         Etu30:=DescGen^.Rend30/100;
      end
     else
     BEGIN
     if Ind = 1 then
     with Generat^ do
      begin

         // Generatore a Combustione

         if (pdati10.PNomUtil*Ta) <> 0 then
            Cp:=(Qp^[Mese]-(Qpo1*pdati10.Epo))/((pdati10.PNomUtil*Ta)/1000000)
         else Cp:=0;
         if DtH20Zona <> 0 then
            Pf1:= pdati10.Pf * exp(0.02*ln(DtH20Zona/50))
         else Pf1:= 0;
         Pd1:=PerdPd*(DtH20Zona/50);
         Pfbs1:=pdati10.Pfbs*(DtH20Zona/50);
         if (100-Pf1+Pfbs1) <> 0 then Fc:=(Pd1+Pfbs1+(100-pdati10.Pf-PerdPd)*Cp)/(100-Pf1+Pfbs1)
         else Fc:=0;
         if Fc <> 0 then Etu:=1-(Pf1+(Pd1/Fc)+Pfbs1*((1-FC)/FC))/100
         else Etu:=0;
         {rendimento 100%}

         Etu100:=0;
         { ricalcolo le perdite perche' la norma le da' con T generatore  = 70 }
         if DescGen^.Rend100 = 0 then
          begin
             Dt2:=70-Zone10^[1].Taria;
             Pf2:=pdati10.Pf*exp(0.02*ln(DtH20Zona/50));
             Pd2:=PerdPd*(DtH20Zona/50);
             Pfbs2:=pdati10.Pfbs*(DtH20Zona/50);

             if (100-Pf2+Pfbs2) <> 0 then RFc:=(Pd2+Pfbs2+100-pdati10.Pf-PerdPd)/(100-Pf2+Pfbs2)
             else RFc:=0;
             if RFc <> 0 then Etu100:=1-(Pf2+(Pd2/RFc)+Pfbs2*((1-RFC)/RFC))/100;
          end
         else Etu100:=DescGen^.Rend100/100;

         {rendimento 30%}

         etu30:=0;
         { ricalcolo le perdite perche' la norma le da' con T generatore  = 50 }
         if DescGen^.Rend30 = 0 then
          begin
             Dt2:=50-Zone10^[1].Taria;
             Pf2:=pdati10.Pf*exp(0.02*ln(Dt2/50));
             Pd2:=PerdPd*(Dt2/50);
             Pfbs2:=pdati10.Pfbs*(Dt2/50);

             if (100-Pf2+Pfbs2) <> 0 then RFc:=(Pd2+Pfbs2+(100-pdati10.Pf-PerdPd)*0.3)/(100-Pf2+Pfbs2)
             else RFc:=0;
             if RFc <> 0 then Etu30:=1-(Pf2+(Pd2/RFc)+Pfbs2*((1-RFC)/RFC))/100;
          end
         else Etu30:=DescGen^.Rend30/100;
         if Etu <> 0 then Qc:=(Qp^[Mese]-Qpo1*pdati10.Epo)/Etu
         else Qc:=0;

         // Stampe Nuovo Report

         if not StampatoGen then
         with DescGen^ do
          begin

           // Formato Stringa (Variabile Report, Variabile Base.dat)
           // Formato Numero  (Variabile Report, Variabile Base.dat, Num cifre Intere)

           StampatoGen := true;

           { TODO -oGenerale -cIndice : Stampa dati del generatore a combustione }

           // ----------------------------------
           // Stampa Tabella
           // SISTEMA DI GENERAZIONE (UNI 10348)
           // ----------------------------------
               Sezione('CALDAIA', 'True');
               Sezione('POMPACALORE', 'False');
               Wrep_str('DESC_IMPIANTO_TERM',  DescrizioneImpianto(DescGen^.Cod));
               Wrep_str('MODELLO_GEN',         Model);
               W_Reale('NUM_GENERATORI',       Numero, 0);
               Wrep_str('FLUIDO_VETTORE',      fluido);
               Wrep_str('COMBUSTIBILE',        combust);
               W_Reale('POT_NOM_UTILE',        PNom,   0);
               W_Reale('POT_NOM_FOCOLARE',     Pfoc,   0);
               W_Reale('PERDITE_BRUC_ON',      Pf,     2);
               W_Reale('PERDITE_BRUC_OFF',     Pfbs,   2);
               W_Reale('PERDITE_INVOLUCRO',    Pd,     2);
               W_Reale('POT_ELETT_BRUCIATORE', Qbr,    0);
               W_Reale('TEMP_H2O_GENERATORE',  DescGen^.TempH2O,2);
          end

      end;
     if Ind = 2 then
     with Generat^ do
      begin
         if Descgen^.CopE > 0 then Cop:=Descgen^.CopE*pdati10.Esen;
         if Descgen^.CopT > 0 then Cop:=Descgen^.CopT;
         if Descgen^.TempSorg > 0 then
          Cop:=Cop*((TempEstMed^[mese]+20)/(Descgen^.TempSorg+20))*((Descgen^.TempSorg+80)/(TempEstMed^[mese]+80));
         Qc:=(Qp^[Mese]-(Qpo1*pdati10.Epo))/Cop;


         // ----------------------------------
         // Stampa Tabella
         // SISTEMA DI GENERAZIONE (UNI 10348)
         // Parte per le pompe di calore
         // ----------------------------------

               Sezione('CALDAIA', 'False');
               Sezione('POMPACALORE', 'True');
               if DescGen^.CopT <> 0 then Wrep_str('ENERGIA_PCAL', 'Chimica')
               else Wrep_str('ENERGIA_PCAL', 'Elettrica');
               Wrep_str('DESC_IMPIANTO_TERM',  DescrizioneImpianto(DescGen^.Descrizione));
               Wrep_str('MODELLO_GEN',         DescGen^.Model);
               W_Reale('NUM_GENERATORI',       DescGen^.Numero, 0);
               Wrep_str('FLUIDO_VETTORE',      DescGen^.fluido);
               Wrep_str('COMBUSTIBILE',        DescGen^.combust);
               W_Reale('POT_NOM_UTILE',        DescGen^.PNom,   0);
               W_Reale('POT_ELETT_BRUCIATORE', DescGen^.Qbr,   0);
               if DescGen^.CopT <> 0 then W_Reale('COP_POMPACAL', DescGen^.CopT,   1)
               else W_Reale('COP_POMPACAL', DescGen^.CopE,   1);
               if DescGen^.TempSorg = 0 then  Wrep_str('TEMP_H2O_SORGENTE', 'Costante')
               else  Wrep_str('TEMP_H2O_SORGENTE', 'Variabile');
               W_Reale('VALORE_TEMPERATURA', DescGen^.TempSorg,   1);
      end;
     END;
     if pdati10.Esen <> 0 then Generat^.Qe:=(Generat^.Qbr1+Generat^.Qpo1)/pdati10.Esen
     else Generat^.Qe:=0;
     Q^[Mese]:=(Generat^.Qc+Generat^.Qe);  {mj}
     if Q^[Mese] < 1 then Q^[Mese]:=0;

     if Q^[Mese] <> 0 then Ep^[mese]:=Qp^[Mese]/Q^[Mese]
     else Ep^[mese]:=0;
   END;
   Cpm^[mese]:=Generat^.cp;
   Etum^[mese]:=Generat^.Etu;
end;

function MeseIntero(Mese:Smallint):boolean;
VAR zcl:string;
    MI:boolean;
begin
   MI:=false;
   zcl:=formst(PROG^.zonacl);
   case zcl[1] of
    'A':if Mese in[12,1,2] then MI:=true;
    'B':if Mese in[12,1..3] then MI:=true;
    'C':if Mese in[12,1..3] then MI:=true;
    'D':if Mese in[11,12,1..3] then MI:=true;
    'E':if Mese in[11,12,1..3] then MI:=true;
    'F':begin
           Mi:=true;
           if mese=prog^.MeseIn then
            begin
               if prog^.Giornoin <> 1 then Mi:=false;
            end;
           if mese=prog^.MeseFin then
            begin
               if prog^.GiornoFin < GiorMese(prog^.MeseFin) then Mi:=false;
            end;
        end;
   end;
   MeseIntero:=MI;
end;


(*function CalcIrradMed:real;
var ContIrrad,j:Smallint;
    TotIrrad:real;
begin
   ContIrrad:=0;  TotIrrad:=0;
   for j:=1 to MesiRisc do
    begin
       TotIrrad:=TotIrrad+(HbH^[indMese^[j]]/(GiorMese(indMese^[j])*86400))*1E6;  { W/m2 }
       ContIrrad:=ContIrrad+1;
    end;
   if ContIrrad > 0 then CalcIrradMed:=TotIrrad/ContIrrad
   else CalcIrradMed:=0;
end;*)




procedure TrovaMeseInsol;
var j:Smallint;
    TotI,TempDt:real;
begin
   TotI:=0; MeseMagIns:=0;
   for j:=1 to MesiRisc do
    if MeseIntero(indMese^[j]) then
     begin
        if TotI < (HbH^[indMese^[j]]+HdH^[indMese^[j]]) then
         begin
            TotI:=HbH^[indMese^[j]]+HdH^[indMese^[j]];
            MeseMagIns:=indMese^[j];
         end;
     end;
end;



function PortataMec:real;
var Port,TotVol,VolZ:real;
    i:Smallint;
begin
   TotVol:=0; Port:=0;
   for i:=1 to NZone10 do
    begin
       VolZ:=CalcVolRisc(i);
       TotVol:=TotVol+VolZ;
       Port:=Port+Zone10^[i].PortMec*VolZ;  {m3/h}
    end;
   if TotVol <> 0 then PortataMec:=Port/TotVol {vol/h}
   else PortataMec:=0;
end;


function Portata_N:real;
var Port,TotVol,VolZ:real;
    i,Ind:Smallint;
begin
   TotVol:=0; Port:=0;
   for i:=1 to NZone10 do

    with Zone11^[i] do
    begin
   { TODO -oGenerale -cIndice : Calcolo Portata Ventilazione n nel Fen Limite }
       //Emanuela 6/12/2004 Calcolo l'area del pavimento prima di calcolare la portata naturale
       AreaPav := CalcSupRisc(i);
       VolZ:=CalcVolRisc(i);
       TotVol:=TotVol+VolZ;
       if N > 0 then Port:=Port+(N*VolZ)
       else
        begin
           //Ind:=pos_combo(drivecombo,'zone','classifL10',pdati10.Classif(i));
           Ind := IndZoneClassif(pdati10.Classif(i));
           case ind of
             1,2,3:Port:=Port+0.5*VolZ;
             4..14:begin
                      if VolZ > 0 then Port:=Port+VolZ*(0.15*((24-TempOc)/24)+((AriaEst*TempOc*Affol*AreaPav)/(2400*VolZ)));
                   end;
           end;

{           if pdati10.classif(i) ='E.1(1)' then Port:=Port+0.5*VolZ
           else
           if VolZ > 0 then Port:=0.15*((24-TempOc)/24)+((AriaEst*TempOc*Affol*AreaPav)/(2400*VolZ));}
        end
    end;
  if TotVol <> 0 then Portata_N:=Port/TotVol {vol/h}
  else Portata_N:=0;
end;

// ---------------------------------------------------
// Calcolo degli Apporti Gratuiti Uni 10379 Prosp VIII
// ---------------------------------------------------

function CalcApport:real;
var ind:Smallint;
    Ap1:real;
    TotApp,TotVol,VolZ:real;
    i:Smallint;
begin
   TotVol:=0; TotApp:=0;
   for i:=1 to NZone10 do
    with Zone11^[i] do
    begin
       VolZ:=CalcVolRisc(i);
       TotVol:=TotVol+VolZ;
       ind:=1;
       //case pos_combo(drivecombo,'Zone','ClassifL10',pdati10.classif(i)) of
       case IndZoneClassif(pdati10.classif(i)) of
       1: Ind:=1;
       2: Ind:=2;
       3: Ind:=3;
       4: Ind:=4;
       5: Ind:=5;
       6,7,8:Ind:=6;
       9: Ind:=7;
       10: Ind:=8;
       11: Ind:=9;
       12: Ind:=10;
       13: Ind:=11;
       14: Ind:=12;
       end;
       case Ind of
         1:Ap1:=4;
         2:Ap1:=4*ngo/30;
         3:Ap1:=4;
         4:Ap1:=6;
         5:Ap1:=6;
         6:Ap1:=(8*TempOc*Ngo)/720;
         7:Ap1:=8;
         8:Ap1:=Ap;
         9:Ap1:=(4*TempOc*Ngo)/720;
        10:Ap1:=(4*TempOc*Ngo)/720;
        11:Ap1:=4;
        12:Ap1:=2;
       end;
       if VolZ <> 0 then TotApp:=TotApp+(Ap1*CalcSupRisc(i));
    end;
   if TotVol <> 0 then CalcApport:=TotApp/TotVol
   else CalcApport:=0;
end;

end.
