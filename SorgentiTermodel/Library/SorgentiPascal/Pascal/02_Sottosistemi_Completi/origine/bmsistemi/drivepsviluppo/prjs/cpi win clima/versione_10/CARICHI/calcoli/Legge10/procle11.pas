unit procle11;
interface
uses
  Math,
  SysUtils,
  UVariabili, Varcarichi,
  CalcHg, MetodL10, metod10, procle13, UFunzioniLegge10, URicercaDati,
  Utireport, LibreriaGenerale, FunzProc1, CalcCD, CalkAll;

type
 {                    PRINCIPALI RISULTATI DI CALCOLO
    'Valore dei rendimenti medi stagionali di progetto '
      [CalcEcs*100] - rendimento di regolazione   [%] : '
      [CalcEds*100] - rendimento di distribuzione [%] : '
      [CalcEes*100] - rendimento di emissione     [%] : '
    'Valore del rendimento globale medio stagionale'
      [EGS*100] - valore di progetto [%] : '
      [EGLIM] -   valore minimo imposto dal regolamento [%] : '
    'Valore del rendimento di produzione medio stagionale'
      [EPS] - valore di progetto [%] : '
      [EPLIM] - valore minimo imposto dal regolamento [%] : '
    'Valori dei rendimenti dei generatori con potenza termica utile nominale compresa tra 4 kw e 400 kw '
      [generat^.Etu100*100] - valore di progetto [100 %] : '
 }

  // Emanuela 21-07-2004 tipo di record dichiarato pubblico affinchè si possa
  // accedere da più funzioni alla variabile CpStA, la cui informazione Massa
  // è necessaria per la stampa
  
  CpTerAn = record
              Descr:string[55];
              Np:smallint;
              Massa, Area, CapT:real;
            end;
   
function CalcDtMed:real;
procedure StampCapTerm(var npag,nr:smallint);
procedure StampTotGenerat(var Npag,Nr:smallint;TipoCalc:smallint);
function CalcMassa(Np:smallint):real;
// Emanuela Dpr 192
procedure Dati_Gen;
{$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
procedure StampCarInt;
{$IFEND}

var
  // Emanuela 21-07-2004 tipo di variabile dichiarata pubblica affinchè si possa
  // accedere da più funzioni ad essa, la cui informazione Massa
  // è necessaria per la stampa
  CpStA: CpTerAn;

implementation

// --------------------------------------------------------------
// Correzione della Temperatura Interna di Progetto Ti Uni 10379
// quando ci sono due o più zone diverse nello stesso edificio
// Supporta il caso di edificio con tipologia E(8) - Vedi DPR 412
// --------------------------------------------------------------

function TempInt:real;
var Dt1,TotVol,VolZ:real;
    i,Ind,Classificaz:smallint;
begin
   TotVol:=0; ; Dt1:=0;
   for i:=1 to NZone10 do
    begin
       VolZ := CalcVolRisc(i);
       TotVol:=TotVol+VolZ;
       //Classificaz := Pos_Combo(drivecombo,'fabbricato','Classif',Zone11^[i].Classif);
       Classificaz := IndZoneClassif(Zone11^[i].Classif);
       if Classificaz = 14 {'E.8'} then Dt1:=Dt1+(18*VolZ)
       else Dt1:=Dt1+(20*VolZ);
    end;
  if TotVol <> 0 then TempInt:=Dt1/TotVol
  else Result := 0;
end;

procedure Scriviris(var Nr:smallint);

      function CalcEes:real;
      var i,j:smallint;
          TQhvs,Ees:real;
      begin
         Ees:=0;  TQhvs:=0;
         for j:=1 to 12 do

          for i:=1 to NZone10 do
          begin
           TQhvs:=TQhvs+MatQhvs^[j,i];
          end;
         if (QhrEe <> 0) then Ees:=TQhvs/QhrEe;
         CalcEes:=Ees;
      end;

      function CalcEcs:real;
      var i,j:smallint;
          TQhvs,Ecs:real;
      begin
         Ecs:=0;  TQhvs:=0;
         for j:=1 to 12 do
          for i:=1 to NZone10 do
           begin
              TQhvs:=TQhvs+MatQhvs^[j,i];
           end;
         if (QhrEc <> 0) then Ecs:=TQhvs/QhrEc;
         Result := Ecs;
      end;

      function CalcEdS:real;
      var
         i,j:smallint;
         TQnrd,TQhr,Eds:real;
      begin
         //if 1 = pos_combo(drivecombo,'Fabbricato','TipoDistr',Prog^.TipoDistr) then
         if 1 = IndFabbricatoDistr(Prog^.TipoDistr) then
         Begin
           TQhr:=0;  TQnrd:=0; Eds:=0;
           for j:=1 to 12 do
            begin
               TQnrd := TQnrd + pdati10.Qnrd(j);
               for i := 1 to NZone10 do TQhr := TQhr + MatQhr^[j,i];
            end;
           if (TQhr <> 0) then
            if (TQnrd/TQhr <> -1) then Eds:=1/(1+TQnrd/TQhr);
         end
         else Eds:= Ed^[IndMese^[1]];

         Result := Eds;
      end;


var
  Rend:real;
  Str2: string[5];
begin
  { Verifica Generatore di Calore con Potenza >= 400 KW }
    if pdati10.PnomUtil <= 400000 then
       rend := 84 + (2*Log10(pdati10.PnomUtil/1000))
    else rend := 83 + (2*Log10(pdati10.PnomUtil/1000));
  {[Rend] - valore minimo inposto dal regolamento [100 %]'}
    if pdati10.PnomUtil <= 400000 then
    begin
     {[generat^.Etu30*100] - valore di progetto [30 %]}
     {[rend] - valore minimo inposto dal regolamento [30 %]}
      rend:=80+(3*Log10(pdati10.PnomUtil/1000));
    end;
end;


// -------------------------------------------
// Stampa della Capacità Termica dell'Edificio
// -------------------------------------------

procedure StampCapTerm(var npag,nr:smallint);
type
   RecCapTerSt = record
                   CodStrut  :smallint;
                   DescStrut :string[30];
                   Tipo      :string[35];
                   Sup       :real;
                   Cp        :real;
                   CTot      :real;
                 end;
   strec = record
              hK,Tc:real;
           end;
var i, j, Ind: Smallint;
    CpSt: RecCapTerSt;
    TotCap, CapTV: real;
    Stval: stRec;
begin
    TotCap:=0;
    with CpStA do
    begin
       Descr := Zone10^[ZonaCalc].TipoEdif;
       Np := UltimoPiano;
       { TODO -oGenerale -cIndice : Calcolo Capacità Termica dell'Edificio }
      {$IFDEF VERSIONE_13}
       Ind := IndFabbricatoTipCostr(Zone10^[ZonaCalc].TipoCostrN);
       case ind of
         1: CapTv := 290;
         2: CapTv := 240;
         3: CapTv := 130;
         4: CapTv := 70;
       end;
       CapT := VolumeZona * CapTV; {kJ/K}
      {$ELSE}
       Massa:=CalcMassa(Np);
       if NPiani <> 0 then
          Area := AreaZona + 0.66 *((Np-1)/Np) * VolumeZona
       else Area := AreaZona;
       CapT := Area*Massa{*1000};  {kJ/øC}
      {$ENDIF}
       TotCap := CapT;  {Kj/øC}
       MassaEdif := (Area*Massa)/1000;
    end;
    CapTermZona := TotCap;
    StVal.hk := prn_TotH^.HTerreno + prn_TotH^.HtotZona;
    StVal.Tc := CalcTc;
end;

{-----------------------------------------------------------------------------
  Procedure: StampCarInt
  Author:    e.diquattro
  Date:      14-feb-2006
  Arguments:
  Result:    None
  
  Cosa fa:  Stampa dei Carichi Interni
-----------------------------------------------------------------------------}
{$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
procedure StampCarInt;
var
  i: smallint;
  AreaRisc, TotMJ: real;
begin
   AreaRisc:=CalcSupRisc(ZonaCalc);
   Qi^[ZonaCalc]:=0;
   InizioTabella('TAB_CARICHIINTERNI', 3);
   for i:=1 to NCarInt do
     if CompareStr(UpperCase(CarInterni^[i].CodZona), UpperCase(CodiceZona_D(Zone10^[ZonaCalc].descr))) = 0 then
     begin
      WStrTab(CarInterni^[i].Descr);
      if CompareStr(UpperCase(CarInterni^[i].Descr), 'APPARTAMENTI CON SUPERFICIE LORDA <= 200 M²') = 0 then
      begin
        TotMJ := (6.25 - 0.02 * AreaRisc) * 2.592;
        Qi^[ZonaCalc]:=Qi^[ZonaCalc] + TotMJ;
        WRealeTab(CarInterni^[i].NUnita, 0);
        WRealeTab(TotMJ, 2);
      end
      else
      if CompareStr(UpperCase(CarInterni^[i].Descr), 'APPARTAMENTI CON SUPERFICIE LORDA > 200 M²') = 0 then
      begin
        TotMJ := 450 * 2.592;
        Qi^[ZonaCalc]:=Qi^[ZonaCalc] + TotMJ;
        WRealeTab(CarInterni^[i].NUnita, 0);
        WRealeTab(TotMJ, 2);
      end
      else
      if CompareStr(UpperCase(CarInterni^[i].Descr), 'UFFICI') = 0 then
      begin
        TotMJ := (6 * AreaRisc) * 2.592;
        Qi^[ZonaCalc]:=Qi^[ZonaCalc] + TotMJ;
        WRealeTab(CarInterni^[i].NUnita, 0);
        WRealeTab(TotMJ, 2);
      end
      else
      if CompareStr(UpperCase(CarInterni^[i].Descr), 'EDIFICIO PER COMMERCIO') = 0 then
      begin
        TotMJ := (8 * AreaRisc) * 2.592;
        Qi^[ZonaCalc]:=Qi^[ZonaCalc] + TotMJ;
        WRealeTab(CarInterni^[i].NUnita, 0);
        WRealeTab(TotMJ, 2);
      end
      else
      if CarInterni^[i].NUnita <> 0 then
      begin
         Qi^[ZonaCalc]:=Qi^[ZonaCalc] + (CarInterni^[i].NUnita * CarInterni^[i].MjTOT);
         WRealeTab(CarInterni^[i].NUnita, 0);
         WRealeTab(CarInterni^[i].MjTOT * CarInterni^[i].NUnita, 2);
      end
      else
      if (CompareStr(UpperCase(CarInterni^[i].Descr), 'ALLUMINAZIONE(PICCOLO APPARTAMENTO < 50 M²)') = 0) or
         (CompareStr(UpperCase(CarInterni^[i].Descr), 'ALLUMINAZIONE(MEDIO APPARTAMENTO DA 50 A 100 M²)') = 0) or
         (CompareStr(UpperCase(CarInterni^[i].Descr), 'ALLUMINAZIONE(GRANDE APPARTAMENTO > 100 M²)') = 0)
      then
      begin
         Qi^[ZonaCalc]:=Qi^[ZonaCalc] + CarInterni^[i].MjTOT;
         WRealeTab(CarInterni^[i].NUnita, 0);
         WRealeTab(CarInterni^[i].MjTOT , 2);
      end;
      FineRigaTabella;
     end;
     FineTabella;
     W_Reale('TOT_CARICHIINT', Qi^[ZonaCalc], 2);
end;
{$IFEND}

function GiornRisc:smallint;
var i,n:smallint;
begin
   n:=183;
   case prog^.zonaCl[1] of
    'A':n:=105;
    'B':n:=121;
    'C':n:=137;
    'D':n:=166;
    'E':n:=183;
    'F':n:=200;
  {  'F':begin
           n:=GiorMese(IndMese^[1])-(prog^.GiornoIn-1);
           n:=n+prog^.Giornofin;
           for i:=2 to MesiRisc-1 do
            begin
               n:=n+GiorMese(IndMese^[i]);
            end;
        end;}
   end;
   GiornRisc:=n;
end;


function CalcIrradMed:real;
var ContIrrad,j:smallint;
    TotIrrad:real;
begin
   ContIrrad:=0;  TotIrrad:=0;
   for j:=1 to MesiRisc do
    if MeseIntero(indMese^[j]) then
     begin
        TotIrrad:=TotIrrad+(HbH^[indMese^[j]]+HdH^[indMese^[j]])*GiorMese(indMese^[j]);
        ContIrrad:=ContIrrad+GiorMese(indMese^[j]);
     end;
   if ContIrrad > 0 then CalcIrradMed:=11.57*(TotIrrad/ContIrrad)
   else CalcIrradMed:=0;
end;


function ValoreKu:real;
const
 TabKu:array[1..2,1..3] of real =((0.75,0.79,0.87),(0.94,0.96,1.0));
var
  IndZ:smallint;
begin
   IndZ:=1;
   case Prog^.ZonaCl[1] of
    'A','B':  IndZ:=1;
    'C','D':  IndZ:=2;
    'E','F':  IndZ:=3;
   end;
   if DescGen1^[gencor].Sv <= 0.2 then ValoreKu:=TabKu[1,IndZ]
   else
    if DescGen1^[gencor].Sv >= 0.9 then ValoreKu:=TabKu[2,IndZ]
    else
     ValoreKu:=TabKu[1,IndZ]+((TabKu[2,IndZ]-TabKu[1,IndZ])/(0.9-0.2))*(DescGen1^[gencor].Sv-0.2);

end;


Function RoundNum(Num:real):real;
var Num1:real;
 begin
    Num1:=Round(Num*10);
    RoundNum:=(Num1/10);
 end;

// ------------------------------------------------------------
// Calcolo della temperatura media stagionale dell'aria esterna
//            Teta em Uni 10379 per il calcolo del FEN
// ------------------------------------------------------------

function CalcDtMed:real;
var i,GM:smallint;
    Dtm,NumG:real;
begin
   DtM:=0;
   NumG:=0;

   GM:=GiorMese(IndMese^[1])-(prog^.GiornoIn-1);

   DtM:=DtM+GM*TempEstMed^[indMese^[1]];
   NumG:=NumG+GM;

   GM:=Prog^.GiornoFin;

   DtM:=DtM+GM*TempEstMed^[indMese^[MesiRisc]];
   NumG:=NumG+GM;

   for i:=2 to MesiRisc-1 do
    begin
       DtM:=DtM+GiorMese(indMese^[i])*TempEstMed^[indMese^[i]];
       NumG:=NumG+GiorMese(indMese^[i]);
    end;
   Dtm:=roundNum(Dtm/NumG);

   CalcDtMed:=TempInt-DtM;
end;

procedure CalcFen;
var
  i,j:smallint;
  VerCD, VerFen, VerRend: String;
  Cd1, Cd2, AP, BP, CP: Real;
begin
   Qs := 0;
   if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
   begin
     // Emanuela DPR 192 variabile che conterrà il fabbisogno il KWh/m²anno
     QKW := 0;
   end;

   for i:=1 to MesiRisc do
       Qs := Qs + Q^[indMese^[i]];

   DescGen1^[gencor].DtMed     := CalcDtMed;
   DescGen1^[gencor].GiorniRis := GiornRisc;
   Descgen1^[gencor].FBMJ      := Qs;

   if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
   begin
     // Emanuela DPR 192 calcolo il fabbisogno il KWh/m²anno
     if Slorda <> 0 then
     begin
        QKW := QS * 0.278/Slorda;
     end
     else QKW := 0;
     if SutilP <> 0 then
        Provv := QS * 0.278/SUtilP
     else Provv := 0;
   end;

  // Emanuela 31/7/2006 Calcolo del valore limite del FEAP
  // Emanuela DPR 192 conservo i valori in descgen
  Descgen1^[gencor].FBKW := QKW;
  if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
  begin
     Descgen1^[gencor].FBKWSU := Provv;
     // Emanuela DPR 192 calcolo del valore limite in base alla tabella 1
     if Caso = 3 then
       Descgen1^[gencor].ValLim := ValLim_FabbEnergiaPrim(Descgen1^[gencor].SV, 1.5)
     else
       Descgen1^[gencor].ValLim := ValLim_FabbEnergiaPrim(Descgen1^[gencor].SV, 1);
  end;

   // Emanuela 31/7/2006 Calcolo del FEN
   if (DescGen1^[gencor].VolLord*DescGen1^[gencor].GiorniRis*DescGen1^[gencor].DtMed) <> 0 then
       Fen := (Qs * 1000)/(DescGen1^[gencor].VolLord*DescGen1^[gencor].GiorniRis*DescGen1^[gencor].DtMed)
   else fen:=0;
   DescGen1^[gencor].CorUtilAg := ValoreKu;

   if flag10 then
   begin
       DescGen1^[gencor].IrradS:=CalcIrradMed;
       DescGen1^[gencor].AppGr:=CalcApport;
   end
   else
   begin
       DescGen1^[gencor].IrradS:=0;
       DescGen1^[gencor].AppGr:=0;
   end;

   DescGen1^[gencor].RicAr:=Portata_N;

   //Emanuela DPR 192 nuovo calcolo del rindimento globale medio stagionale impianto termico secondo la 192
   //approfondire è stato annullato ?
   {
   if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
     EgLim:=75+3*log10(pdati10.PNomUtil/1000)
   else
   }
     EgLim:=65+3*log10(pdati10.PNomUtil/1000);    // formula del rendimento globale medio stagionale - rendimenti limiti degli impianti
   EpLim:=77+3*log10(pdati10.PNomUtil/1000);      // formula per la sostituzione del generatore (rendimento di produzione medio stagionale)
   DescGen1^[gencor].RedETgRegol := EgLim;
   DescGen1^[gencor].RedETpRegol := EpLim;

   // ---------------------------------------------------------------------
   // Calcolo e Stampa del FEN limite - Valori stampati nella Relazione L10
   // VALORI LIMITE IMPIANTO (D.M. 30 LUGLIO 1986 - UNI 10379)
   // ---------------------------------------------------------------------

   if (DescGen1^[gencor].DtMed <> 0) then
   begin
       AP := (DescGen1^[gencor].CdFen+0.34*DescGen1^[gencor].RicAr);
       BP := (0.01*DescGen1^[gencor].IrradS/DescGen1^[gencor].DtMed);
       CP := (DescGen1^[gencor].AppGr/DescGen1^[gencor].DtMed);
       FenLim:=(AP - DescGen1^[gencor].CorUtilAg*(BP+CP))*(86.4/(EgLim/100))
   end
   else FenLim:=0;
   CalcoloCD1_CD2DM(Prog^.Gradi, Cd1, Cd2);
   DescGen1^[gencor].Fts:=Qs;
   DescGen1^[gencor].Fen:=Fen;
   DescGen1^[gencor].FenLim:=FenLim;
   if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
   begin
    {$IF Defined(VERSIONE_12)}
     DatiAtt.Vl   := DescGen1^[gencor].VolLord;
     DatiAtt.Sl   := DescGen1^[gencor].SupLord;
     DatiAtt.SupL := DescGen1^[gencor].SupUtileR;
     DatiAtt.Sv   := DescGen1^[gencor].SV;
     DatiAtt.GIORNI_RISC  := DescGen1^[gencor].GiorniRis;
     DatiAtt.ETA_GLOBALE := DescGen1^[gencor].RedETgRegol;
     DatiAtt.CD   := DescGen1^[gencor].CdAdot;
     DatiAtt.QKW  := DescGen1^[gencor].FBKWSU;
     DatiAtt.QMJ  := DescGen1^[gencor].FBMJ;
     DatiAtt.FEN  := DescGen1^[gencor].Fen;
     DatiAtt.VLim := DescGen1^[gencor].ValLim;
    {$ELSEIF Defined(VERSIONE_13)}
     DatiAtt[Gencor-1].Vl   := DescGen1^[gencor].VolLord;
     DatiAtt[Gencor-1].Sl   := DescGen1^[gencor].SupLord;
     DatiAtt[Gencor-1].SupL := DescGen1^[gencor].SupUtileR;
     DatiAtt[Gencor-1].Sv   := DescGen1^[gencor].SV;
     DatiAtt[Gencor-1].GIORNI_RISC  := DescGen1^[gencor].GiorniRis;
     DatiAtt[Gencor-1].ETA_GLOBALE := DescGen1^[gencor].RedETgRegol;
     DatiAtt[Gencor-1].CD   := DescGen1^[gencor].CdAdot;
     DatiAtt[Gencor-1].QKW  := DescGen1^[gencor].FBKWSU;
     DatiAtt[Gencor-1].QMJ  := DescGen1^[gencor].FBMJ;
     DatiAtt[Gencor-1].FEN  := DescGen1^[gencor].Fen;
     DatiAtt[Gencor-1].VLim := DescGen1^[gencor].ValLim;
    {$IFEND}
   end;

  {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13) and not DEFINED(VERSIONE_TRIAL)}
   if (DescGen1^[gencor].CdAdot = 0) and (DescGen1^[gencor].CdLeg = 0) then DescGen1^[gencor].CdVerificato := 'No'
   else
   begin
     if DescGen1^[gencor].CdAdot <= DescGen1^[gencor].CdLeg then DescGen1^[gencor].CdVerificato := 'Si'
     else DescGen1^[gencor].CdVerificato := 'No';
   end;
   if (DescGen1^[gencor].Fen = 0) and (DescGen1^[gencor].FenLim = 0) then DescGen1^[gencor].FenVerificato := 'No'
   else
   begin
     if DescGen1^[gencor].Fen <= DescGen1^[gencor].FenLim then DescGen1^[gencor].FenVerificato := 'Si'
     else DescGen1^[gencor].FenVerificato := 'No';
   end;
   if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
   begin
     Case Caso of
      //Rifatto da diego
      1:Begin
        DescGen1^[gencor].Verifica:='Si';
        Descgen1^[gencor].FBKWSU := Provv;
        if (Provv > Descgen1^[gencor].ValLim)
        then  DescGen1^[gencor].Verifica:='No'
        else
        if (Egs*100 < EgLim) or (not (DatiV192[Gencor-1].VerifPareti)) or
           (not(DatiV192[Gencor-1].VerifiFinestre)) or (not( DatiV192[Gencor-1].VerificaVetri))
        then  DescGen1^[gencor].Verifica:='No'
        else
        end;
      (*
      1: begin
           if (Provv <= Descgen1^[gencor].ValLim) then
           begin
             DescGen1^[gencor].Verifica:='Si';
             Sezione('CASO1',  'True');
             Sezione('CASO1A', 'False');
             Sezione('CASO2',  'False');
             Sezione('CASO3',  'False');
             Sezione('CASO4',  'False');
             Sezione('NOVER',  'False');
           end
           else
          {$IFDEF VERSIONE_12}
           if (Egs*100 >= EgLim) and DatiV192.VerifPareti and
              DatiV192.VerifiFinestre and DatiV192.VerificaVetri
          {$ELSE}
           if (Egs*100 >= EgLim) and DatiV192[Gencor-1].VerifPareti and
              DatiV192[Gencor-1].VerifiFinestre and DatiV192[Gencor-1].VerificaVetri
          {$ENDIF}
           then
           begin
            {$IFDEF VERSIONE_12}
             Provv := Descgen1^[gencor].ValLim;
            {$ELSE}
             Provv := Descgen1^[gencor].ValLim;
            {$ENDIF}
             Descgen1^[gencor].FBKWSU := Provv;
             DescGen1^[gencor].Verifica:='Si';
             Sezione('CASO1',  'False');
             Sezione('CASO1A', 'True');
             Sezione('CASO2',  'False');
             Sezione('CASO3',  'False');
             Sezione('CASO4',  'False');
             Sezione('NOVER',  'False');
           end
           else DescGen1^[gencor].Verifica:='No';
         end;
      *)
      2: begin
          {$IFDEF VERSIONE_12}
           if DatiV192.VerifPareti and DatiV192.VerifiFinestre and DatiV192.VerificaVetri
          {$ELSE}
           if DatiV192[Gencor-1].VerifPareti and DatiV192[Gencor-1].VerifiFinestre and DatiV192[Gencor-1].VerificaVetri
          {$ENDIF}
           then
           begin
             DescGen1^[gencor].Verifica:='Si';
             Sezione('CASO1',  'False');
             Sezione('CASO1A', 'False');
             Sezione('CASO2',  'True');
             Sezione('CASO3',  'False');
             Sezione('CASO4',  'False');
             Sezione('NOVER',  'False');
           end
           else DescGen1^[gencor].Verifica:='No';
         end;
      3: begin
           if (Provv <= Descgen1^[gencor].ValLim) then
           begin
              DescGen1^[gencor].Verifica:='Si';
              Sezione('CASO1',  'False');
              Sezione('CASO1A', 'False');
              Sezione('CASO2',  'False');
              Sezione('CASO3',  'True');
              Sezione('CASO4',  'False');
              Sezione('NOVER',  'False');
           end
           else DescGen1^[gencor].Verifica:='No';
         end;
      4: begin
           if (Provv <= Descgen1^[gencor].ValLim) and (Eps >= EpLim)
           then
           begin
              DescGen1^[gencor].Verifica:='Si';
              Sezione('CASO1',  'False');
              Sezione('CASO1A', 'False');
              Sezione('CASO2',  'False');
              Sezione('CASO3',  'False');
              Sezione('CASO4',  'True');
              Sezione('NOVER',  'False');
           end
           else DescGen1^[gencor].Verifica:='No';
         end;
      5: begin
           //da fare
         end;
     end;
   end
   else
   begin
     if ((Egs*100 >= EgLim) and (DescGen1^[gencor].Fen <= DescGen1^[gencor].FenLim)) and
         (DescGen1^[gencor].CdAdot <= DescGen1^[gencor].CdLeg)
     then
      DescGen1^[gencor].Verifica:='Si'
     else DescGen1^[gencor].Verifica:='No';
   end;
  {$ELSEIF DEFINED(VERSIONE_TRIAL)}
    if CompareStr(UpperCase(Prog.Calc192), 'SI') <> 0 then
    begin
     DescGen1^[gencor].CdVerificato := 'Si';
     DescGen1^[gencor].FenVerificato := 'Si';
     DescGen1^[gencor].Verifica := 'Si';
    end
    else DescGen1^[gencor].Verifica:='Si';
  {$IFEND}


   // ---------------------------------------------------------------------
   // Stampa Tabella FABBISOGNO ENERGETICO NORMALIZZATO (UNI 10379 PUNTO 4)
   // ---------------------------------------------------------------------
   W_Reale('QCONV_PRI',Qs,2);
   if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
   begin
     // Emanuela DPR 192 stampo il fabbisogno il KWh/m²anno nella relazione
     W_Reale('QCONV_KW',Provv,2);
     W_Reale('VALLIM', Descgen1^[gencor].ValLim, 2);
   end;
   W_Reale('TEMP_INT_PROG',TempInt,2);                            // Temp. interna di progetto
   W_Reale('TEMP_MED_STAG',tempint-DescGen1^[gencor].DtMed,2);    // Temp. media stagionale esterna
   W_Reale('RISCDAY',DescGen1^[gencor].GiorniRis,0);              // Giorni di riscaldamento
   W_Reale('V_STRUTT',DescGen1^[gencor].VolLord,2);               // Volume Lordo Struttura
   W_Reale('S_STRUTT',DescGen1^[gencor].SupLord,2);               // Superficie lorda Struttura
   W_Reale('SUP_UTIL',DescGen1^[gencor].SupUtileR,2);             // Superficie utile pavimento Struttura
   W_Reale('RAPP_SV', DescGen1^[gencor].SV, 2);                   // Rapporto SV
   W_Reale('DELTA_TEMP',CalcDtMed,2);                             // DELTA Temperatura
   W_Reale('FEN',FEN,3);                                          // FEN
   if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
   begin
     if CompareStr(UpperCase(DescGen1^[gencor].Verifica) ,'SI') <> 0 then
     begin
      Sezione('CASO1',  'False');
      Sezione('CASO1A', 'False');
      Sezione('CASO2',  'False');
      Sezione('CASO3',  'False');
      Sezione('CASO4',  'False');
      Sezione('NOVER',  'True');
     end;
   end;
   W_Reale('APPGRAINT',DescGen1^[gencor].AppGr,2);
   W_Reale('ETA_GS_LIM',DescGen1^[gencor].RedETgRegol,2);
   W_Reale('DELTA_TM',DescGen1^[gencor].DtMed,2);
   W_Reale('IRRAD_PIANO',DescGen1^[gencor].IrradS,2);
   W_Reale('COEFF_KU',DescGen1^[gencor].CorUtilAg,3);
   W_Reale('N_VOL_ARIA',DescGen1^[gencor].RicAr,2);
   W_Reale('FEN_LIM',FenLim,2);
   W_Reale('CD_LIM',DescGen1^[gencor].CdAdot,3);
   W_Reale('RAPP_SV',DescGen1^[gencor].SV,2);
   W_Reale('CD_LEGGE',DescGen1^[gencor].CdLeg,3);
   W_Reale('CD_MIN', CD1,3);              // CD Minimo di legge
   W_Reale('CD_MAX', CD2,3);              // CD Massimo di legge
   W_Reale('GRADGIO',Prog^.gradi,0);      // Gradi Giorno località
   W_Reale('UREL_INT',Prog^.UInv,2);      // Umidità relativa interna di progetto
   // Fabio 21/07/2004 Stampa della massa efficace dell'involucro edilizio
   W_Reale('MASSAED',CpStA.Massa,2);      // Massa efficace dell'involucro edilizio
end;

procedure CalcEta;
var i,j:smallint;
    TotQhvsZ:real;
begin
   TotQhvsZ:=0;  Qps:=0;  Qs:=0;

   for i:=1 to MesiRisc do
   begin
       Qps:=Qps+Qp^[indMese^[i]];
       Qs:=Qs+Q^[indMese^[i]];
       for j:=1 to Nzone10 do TotQhvsZ:=TotQhvsZ+MatQhvs^[indMese^[i],j];
   end;
   if Qs <> 0 then
    begin
       Eps:=(Qps/Qs)*100;
       Egs:=1/Qs*(TotQhvsZ+Toth2o); // Calcolo dell' Eta gs UNI 10348
    end
   else
    begin
       Eps:=0;
       Egs:=0;
    end;

  // if 2 = pos_combo(drivecombo,'GENERATORI','Tipo',DescGen^.Tipo) then
  if 2 = IndGeneratoreTipo(DescGen^.Tipo) then
    begin
       Generat^.etu100:=eps/100;
       Generat^.etu30:=eps/100;
    end;

{ TODO -oGenerale -cIndice : Stampe dei Rendimenti Eta gs ed Eta gs lim }
// ------------------------------------------------
// Stama Tabella
// RENDIMENTO GLOBALE MEDIO STAGIONALE  Eta gs
// DEL SISTEMA DI RISCALDAMENTO (UNI 10348 PUNTO 9)
// e dei Rendimenti Eta gs ed Eta gs_lim Uni 10348
// ------------------------------------------------
   //Emanuela 23/9/2004 Moltiplicato il valore per 100 per trasformarlo in percentuale
   DescGen1^[gencor].RedETg:=Egs * 100;
   DescGen1^[gencor].RedETp:=Eps;
   //W_Reale('ETA_GS',DescGen1^[gencor].RedETg * 100,2);
   W_Reale('ETA_GS', DescGen1^[gencor].RedETg, 2);
   W_Reale('SUM_QHVS',(TotQhvsZ+Toth2o),2);
   W_Reale('SUM_QSQJ',Qs,2);

//   Egs:=1/Qs*(TotQhvsZ+Toth2o); // Calcolo dell' Eta gs UNI 10348

end;

{ TODO -oGenerale -cIndice : Riepilogo finale e calcolo del rendimento del generatore }
// ----------------------------------------------------------------------
// Procedura di stampa delle tabelle:
// RENDIMENTO DI PRODUZIONE DEL GENERATORE - REGIME CONTINUO (UNI 10348)
// Riepilogo finale e calcolo del rendimento del generatore
// ----------------------------------------------------------------------
// TipoCalc = 0 then Regime Continuo
// TipoCalc = 1 then Regime Intermittenza

procedure StampTotGenerat(var Npag,Nr:smallint;TipoCalc:smallint);
var i,j,Ind,Pag,lm:smallint;

procedure StampEd(pref:String);
const
  AC:array[1..5,1..3] of real =((0.96,0.95,0.94),(0.96,0.95,0.94),(0.97,0.96,0.95),(0.97,0.96,0.95),(0.98,0.97,0.96));
   B:array[1..5,1..3] of real =((0.95,0.94,0.94),(0.93,0.93,0.93),(0.91,0.92,0.93),(0.89,0.90,0.91),(0.86,0.87,0.88));
   V:array[1..5] of real=(3000,7500,12500,17500,20000);
   A:array[1..3] of real=(10,20,25);

var TQhr:real;
    i,j,ind,Indx,Indy:smallint;
    Alt:real;

function CalcAlt:real;
var
    AltMin,AltMax:real;
    Indp:smallint;
 begin
    CalcAlt:=3;
    AltMin:=0;  AltMax:=0;
    for indP:=1 to maxEPiante do
     begin
        if AltMin > EPt^[IndP].ZMin then AltMin:=EPt^[IndP].ZMin;
        if AltMax < EPt^[IndP].ZMax then AltMax:=EPt^[IndP].ZMax;
     end;
    CalcAlt:=AltMax-AltMin;
 end;

begin
   fillchar(stq^,sizeof(stq^),0);
   Stq^.DescM:=' [Ed]  RENDIMENTO DI DISTRIBUZIONE';
   //Ind:=pos_Combo(drivecombo,'Fabbricato','TipoDistr',Prog^.TipoDistr);
   Ind := IndFabbricatoDistr(Prog^.TipoDistr);
   // ----------------------------------------------------
   // Attenzione modifica in attesa di cambiamento codice.
   // Attivazione norma per il Calcolo Analitico per le
   // Perdite nelle Tubazioni.
   // Ho incrementato l'indice Ind per far funzionare solo
   // i casi a) b) c) vedi pag. 6 UNI 10348 (vedi sotto)
   // ----------------------------------------------------

   if Ind <> 0 then Inc(Ind);

   // ----------------------------------------------------

   if Ind =1 then
    begin
       for j:=1 to MesiRisc do
        begin
           TQhr:=0;
           for i:=1 to NZone10 do
            begin
               if TipoCalc = 0 then Tqhr:=Tqhr+MatQhr24^[IndMese^[j],i]
               else TQhr:=TQhr+MatQhr^[IndMese^[j],i];
            end;
           if (TQhr <> 0) then
            begin
               if (pdati10.Qnrd(IndMese^[j])/TQhr <> -1 )then Ed^[IndMese^[j]]:=1/(1+pdati10.Qnrd(IndMese^[j])/TQhr)
               else Ed^[IndMese^[j]]:=1;
            end
           else Ed^[IndMese^[j]]:=0;
        end;
    end
   else
    begin
       indx:=0;
       repeat
          indx:=indx+1;
       until (DescGen1^[gencor].volLord <= V[indx]) or (indx=5);

       //Alt:=CalcAlt;
       indy:=0;
       repeat
          indy:=indy+1;
       until (Alt <= A[indy]) or (indy=3);

       Stq^.DescM:=Stq^.DescM+'  UNI 10348 PROSPETTO IV - TIPO EDIFICIO  '+Prog^.TipoDistr;
                           { - VOLUME EDIFICIO [m3]: '+Str1+' ALTEZZA EDIFICIO [m]: '+Str2;}

       if Ind = 3 then for j:=1 to MesiRisc do Ed^[IndMese^[j]]:=B[indx,indy]
       else for j:=1 to MesiRisc do Ed^[IndMese^[j]]:=AC[indx,indy];
    end;

   // Stampa della variabile Rendimenti di Distribuzione ETA d pag.5 UNI 10348
   // ------------------------------------------------------------------------
   Wrep_str('TipoDistrEdificio', Prog^.TipoDistr);
   for j:=1 to mesirisc_st do
    if IndMese[j] in [1..12] then
     W_MesiL10_real(j,'RP11'+pref,Ed^[IndMese^[j]],2, IndMese^[j], MesiRisc_St);
   if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
   begin
    {$IF Defined (VERSIONE_12)}
      DatiAtt.ETA_DISTR := Ed^[IndMese^[2]];
    {$ELSEIF Defined(VERSIONE_13)}
      DatiAtt[Gencor-1].ETA_DISTR := Ed^[IndMese^[2]];
    {$IFEND}
   end;
   for j:=1 to MesiRisc do Stq^.Tot[j]:=Ed^[IndMese^[j]];
end;


PROCEDURE StampTotQ;
var j,i:smallint;
    Tot1:real;
begin
   CalcFen;
end;

Var pref:string;
begin

// ---------------------------------
//  Tipo di calcolo
// {TipoCalc = 0 then continuo}
// {TipoCalc = 1 then intermittenza}
// ---------------------------------

  if tipocalc=0 then pref:='CC' else pref:='NC';

  //Ind:=pos_combo(drivecombo,'generatori','Tipo',DescGen^.Tipo);
  Ind := IndGeneratoreTipo(DescGen^.Tipo);
   for i:=1 to 12 do
    if IndMese^[i] in[1..12] then
     begin
       DM^[i]:=Mese_Ita[IndMese^[i]];
       MesiRisc:=i;
     end
   else DM^[i]:='';

   fillchar(stq^,sizeof(stq^),0);
   if TipoCalc = 0 then Stq^.DescM:=' [TotQhr-24] FABBISOGNO TOTALE ZONE  = Somma Qhr-24 [MJ]'
   else Stq^.DescM:=' [TotQhr] FABBISOGNO TOTALE ZONE  = Somma Qhr [MJ]';
   for j:=1 to MesiRisc do
    begin
       for i:=1 to NZone10 do
        begin
           if TipoCalc = 0 then Stq^.Tot[j]:=Stq^.Tot[j]+MatQhr24^[IndMese^[j],i]
           else Stq^.Tot[j]:=Stq^.Tot[j]+MatQhr^[IndMese^[j],i];
        end;
       if Ind = 4 then
        begin
           Qp^[IndMese^[j]] := Stq^.Tot[j];
           Q^[IndMese^[j]] :=  Stq^.Tot[j]/0.36;
        end;
    end;

   for j:=1 to mesirisc_st do
       W_MesiL10_real(j,'RP00'+pref,Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);


   if Ind <> 4 then
    begin
       //if 1=pos_combo(drivecombo,'Fabbricato','TipoDistr',Prog^.TipoDistr) then
       if 1 = IndFabbricatoDistr(Prog^.TipoDistr) then
        begin
           fillchar(stq^,sizeof(stq^),0);
           Stq^.DescM:='ENERGIA DISPERSA NELLE TUBAZIONI  [MJ]';
           for j:=1 to MesiRisc do Stq^.Tot[j]:=pdati10.Qnrd(IndMese^[j]);
         end;
       StampEd(pref);
    end
   else
    begin
       fillchar(stq^,sizeof(stq^),0);
       Stq^.DescM:=' [Ed]  RENDIMENTO DI DISTRIBUZIONE';
        for j:=1 to MesiRisc do
         begin
            Ed^[IndMese^[j]]:=1;
            Stq^.Tot[j]:=Ed^[IndMese^[j]];
         end;
     end;


   fillchar(stq^,sizeof(stq^),0);
   Stq^.DescM:=' [Qp] ENERGIA TERMICA FORNITA DAL SISTEMA DI PRODUZIONE = TotQhr/Ed [MJ]';
   for j:=1 to MesiRisc do
    begin
       if Ind < 4 then
        begin
           for i:=1 to NZone10 do
            begin
               if TipoCalc = 0 then Stq^.Tot[j]:=Stq^.Tot[j]+MatQhr24^[IndMese^[j],i]
               else Stq^.Tot[j]:=Stq^.Tot[j]+MatQhr^[IndMese^[j],i];
            end;
// Modifica Fabio  if 1=pos_combo(drivecombo,'Fabbricato','TipoDistr',Prog^.TipoDistr) then
// Indice (Ind) = 4 per effettuare il calcolo analitico

           //if 4 = pos_combo(drivecombo,'Fabbricato','TipoDistr',Prog^.TipoDistr) then
           if 4 = IndFabbricatoDistr(Prog^.TipoDistr) then
            Stq^.Tot[j]:=Stq^.Tot[j]+pdati10.Qnrd(IndMese^[j])
           else Stq^.Tot[j]:=Stq^.Tot[j]/Ed^[IndMese^[j]];
           Qp^[IndMese^[j]]:=Stq^.Tot[j];
        end
       else Stq^.Tot[j]:=Qp^[IndMese^[j]];
    end;

   // Stampa di [Qp] ENERGIA TERMICA FORNITA DAL SISTEMA DI PRODUZIONE = TotQhr/Ed [MJ]
   // ---------------------------------------------------------------------------------
    for j:=1 to mesirisc_st do W_MesiL10_real(j,'RP02'+pref,Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);
    fillchar(Cpm^,sizeof(CpM^),0);
   fillchar(etum^,sizeof(etum^),0);

   fillchar(stq^,sizeof(stq^),0);
   if Ind in[1..2] then
    begin

       for j:=1 to MesiRisc do calcQ_Gen(IndMese^[j],TipoCalc);

       Stq^.DescM:=' [Cp] FATTORE DI CARICO UTILE [%]';
       for j:=1 to MesiRisc do Stq^.Tot[j]:=cpm^[IndMese^[j]]*100;

       // Stampa del coefficiente Fattore di carico utile CP pag. 8 UNI 10348
//Originale       for j:=1 to mesirisc_st do W_MesiL10_real(j,'RP05'+pref,cpm^[j]*100,2);
       for j:=1 to mesirisc_st do
        if IndMese[j] in [1..12] then
           W_MesiL10_real(j,'RP05'+pref,cpm^[IndMese^[j]]*100,2,IndMese^[j], MesiRisc_St);


       Stq^.DescM:=' [Etu] RENDIMENTO TERMICO UTILE MEDIO MENSILE [%]';
       for j:=1 to MesiRisc do Stq^.Tot[j]:=Etum^[IndMese^[j]]*100;
       for j:=1 to mesirisc_st do W_MesiL10_real(j,'RP07'+pref,Stq^.Tot[j],2,IndMese^[j], MesiRisc_St);
       Stq^.DescM:=' [Ep] RENDIMENTO DI PRODUZIONE MEDIO MENSILE [%]';
       for j:=1 to MesiRisc do Stq^.Tot[j]:=Ep^[IndMese^[j]]*100;
       for j:=1 to mesirisc_st do W_MesiL10_real(j,'RP12'+pref,Stq^.Tot[j],2,IndMese^[j], MesiRisc_St);
    end;
   if Ind = 4 then
    begin
       Generat^.Etu30:=0.36;
       Generat^.Etu100:=0.36;
       Stq^.DescM:=' [Ep] RENDIMENTO DI PRODUZIONE MEDIO MENSILE [%]';
       for j:=1 to MesiRisc do
        begin
           Ep^[IndMese^[j]]:=0.36;
           Stq^.Tot[j]:=Ep^[IndMese^[j]]*100;
        end;
        for j:=1 to mesirisc_st do W_MesiL10_real(j,'RP12'+pref,Stq^.Tot[j],2,IndMese^[j], MesiRisc_St);
    end;
   if Ind = 3 then
    begin
       Generat^.Etu30:=1;
       Generat^.Etu100:=1;
       Stq^.DescM:=' [Ep] RENDIMENTO DI PRODUZIONE MEDIO MENSILE [%]';
       for j:=1 to MesiRisc do
        begin
           Q^[IndMese^[j]]:=Qp^[IndMese^[j]];
           Ep^[IndMese^[j]]:=1;
           Stq^.Tot[j]:=Ep^[IndMese^[j]]*100;
        end;
    for j:=1 to mesirisc_st do W_MesiL10_real(j,'RP12'+pref,Stq^.Tot[j],2,IndMese^[j], MesiRisc_St);
    end;

   fillchar(stq^,sizeof(stq^),0);
   Stq^.DescM:=' [Q] FABBISOGNO ENERGIA PRIMARIA = Qp/Ep [MJ]';
   for j:=1 to MesiRisc do Stq^.Tot[j] := Q^[IndMese^[j]];

   //if tipocalc=0 then
   
      for j:=1 to mesirisc_st do
          W_MesiL10_real(j,'RP10'+pref,Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);
   // for j:=1 to mesirisc_st do W_MesiL10_real(j,'SG05C'+pref,Stq^.Tot[j],1);

      // 3-08-2oo4 Tabella ARTICOLO 7 - COMMA 7 DEL DPR 412
      // Salvataggio del valore di Q del mese di Marzo
  if TipoCalc = 0 then // deve essere calcolato nel caso di regine continuo
  begin
      ValoreArt7.FabbReale := Stq^.Tot[5];
      if ValoreArt7.FabbReale <> 0 then
        ValoreArt7.ValArt7 := (ValoreArt7.RadSolare + ValoreArt7.AppInt) / ValoreArt7.FabbReale
        else ValoreArt7.ValArt7 := 0;

      // -----------------------------------------------
      // Stampa Tabella ARTICOLO 7 - COMMA 7 DEL DPR 412
      // -----------------------------------------------

      Wrep_str('MESE_MAXSOL',ValoreArt7.Mese);
      W_Reale('MAXRADSOL',ValoreArt7.RadSolare,2);
      W_Reale('QI',ValoreArt7.AppInt,2);
      W_Reale('FABBQ_PRIMARIA',ValoreArt7.FabbReale,2);
      W_Reale('ARTICOLO7',ValoreArt7.ValArt7 * 100,2);

      if ValoreArt7.ValArt7 * 100 < 20 then
       begin
        Wrep_str('SIGN','<');
        Wrep_Str('RISULTATO_ART7','Non è richiesta installazione di alcun dispositivo di regolazione.');
        DescGen1^[gencor].Articolo7 := 'Non è richiesta installazione di alcun dispositivo di regolazione.';
       end
        else
       begin
        Wrep_str('SIGN','>');
        Wrep_Str('RISULTATO_ART7','E'' richiesta l''installazione di dispositivi per la regolazione automatica della temperatura.');
        DescGen1^[gencor].Articolo7 := 'E'' richiesta installazione di un dispositivo di regolazione.';
       end;
   end;

   if TipoCalc = 0 then
    begin
       //CALCOLO DEL FEN
       StampTotQ;
    end
   else
    begin
       CalcEta;
       Scriviris(nr);
    end;
end;



function CalcMassa(Np:smallint):real;
CONST
  MatMassa:array[1..22,1..3] of real =((0,0,0),
                                       (75,75,85),
                                       (85,95,105),
                                       (95,105,115),
                                       (95,95,95),
                                       (105,95,95),
                                       (115,115,115),
                                       (115,125,125),
                                       (115,125,135),
                                       (125,135,135),
                                       (105,105,105),
                                       (115,125,135),
                                       (125,135,135),
                                       (125,125,115),
                                       (135,135,125),
                                       (145,135,125),
                                       (145,145,145),
                                       (155,155,155),
                                       (165,165,165),
                                       (145,155,155),
                                       (155,165,165),
                                       (165,165,165));
var Ind,Ind1,IndA,IndB,IndC,IndD:smallint;
begin
   case Np of
     1:ind1:=1;
     2:Ind1:=2;
     else Ind1:=3;
   end;
   if (CompareStr(Prog^.Intonaco, 'Malta') <> 0) and (CompareStr(Prog^.Intonaco, 'Gesso') <> 0) then
      Prog^.Intonaco := 'Gesso';
   if (CompareStr(Prog^.Isolamento, 'Assente o Esterno') <> 0) and (CompareStr(Prog^.Isolamento, 'Interno') <> 0) then
      Prog^.Isolamento := 'Assente o Esterno';

   {IndA:=pos_combo(drivecombo,'Fabbricato','Intonaco',Prog^.Intonaco);
   IndB:=pos_combo(drivecombo,'Fabbricato','Isolamento',Prog^.Isolamento);
   IndC:=pos_combo(drivecombo,'Fabbricato','ParetiEsterne',Prog^.ParetiEsterne);
   IndD:=pos_combo(drivecombo,'Fabbricato','Pavimenti',Prog^.Pavimenti); }
   IndA := IndFabbricatoIntonaco(Prog^.Intonaco);
   IndB := IndFabbricatoIsolamento(Prog^.Isolamento);
   IndC := IndFabbricatoParEst(Prog^.ParetiEsterne);
   IndD := IndFabbricatoPavimenti(Prog^.Pavimenti);

   if IndA = 1 then // Caso = Malta
    begin
     if IndB = 1 then // Caso = Isolamento Assente/Esterno
      begin
       case IndD of
        1:case IndC of  // Caso = Piastrelle
          1: Ind:=21;
          2: Ind:=20;
          3: Ind:=22;
          end;
        2:case IndC of  // Caso = Tessile
          1: Ind:=15;
          2: Ind:=14;
          3: Ind:=16;
          end;
        3:case IndC of  // Caso = Legno
          1: Ind:=18;
          2: Ind:=17;
          3: Ind:=19;
          end;
       end;
      end
     else            // Caso = Isolamento Interno
      begin
       case IndD of
        1: Ind:=13;
        2: Ind:=11;
        3: Ind:=12;
       end;
      end;
    end
   else            // Caso = Gesso
    begin
     if IndB = 1 then  // Caso Isolamento = Assente Esterno
      begin
       case IndD of
        1: if IndC = 1 then Ind:=10 else Ind:=9;    // Piastrelle
        2: if IndC = 1 then Ind:=6 else Ind:=5;     // Tessile
        3: if IndC = 1 then Ind:=8 else Ind:=7;     // Legno
       end;
      end
     else             // Caso Isolamento = Interno
      begin
       case IndD of
        1: Ind:=4;
        2: Ind:=2;
        3: Ind:=3;
       end;
      end;
    end;

   if (InRange(ind,2,22))
    and (InRange(ind1,1,3)) then CalcMassa:=MatMassa[ind,ind1]
   else CalcMassa:=0;
end;

{-----------------------------------------------------------------------------
  Procedure: Dati_Gen
  Author:    e.diquattro
  Date:      16-dic-2005
  Arguments: None
  Result:    None
  
  Cosa fa: Stampa i dati del generatore
-----------------------------------------------------------------------------}
procedure Dati_Gen;
var
  Ind:Smallint;
begin
   //Ind:=pos_combo(drivecombo,'Generatori','Tipo',DescGen^.Tipo);
   Ind := IndGeneratoreTipo(DescGen^.Tipo);
   if Ind = 1 then
   begin
     with DescGen^ do
     begin
       // ----------------------------------
       // Stampa Tabella
       // SISTEMA DI GENERAZIONE (UNI 10348)
       // ----------------------------------
           Sezione('CALDAIAR', 'True');
           Sezione('POMPACALORER', 'False');
           Wrep_str('DESC_IMPIANTO_TERMR',  DescrizioneImpianto(DescGen^.Cod));
           Wrep_str('MODELLO_GENR',         Model);
           W_Reale('NUM_GENERATORIR',       Numero, 0);
           Wrep_str('FLUIDO_VETTORER',      fluido);
           Wrep_str('COMBUSTIBILER',        combust);
           W_Reale('POT_NOM_UTILER',        PNom,   0);
           W_Reale('REND100_REGOLR', (84 + 2*log10(PNom)), 2);
           W_Reale('REND30_REGOLR',  (80 + 2*log10(PNom)), 2);
           W_Reale('POT_NOM_FOCOLARER',     Pfoc,   0);
           W_Reale('PERDITE_BRUC_ONR',      Pf,     2);
           W_Reale('PERDITE_BRUC_OFFR',     Pfbs,   2);
           W_Reale('PERDITE_INVOLUCROR',    Pd,     2);
           W_Reale('POT_ELETT_BRUCIATORER', Qbr,    0);
           W_Reale('TEMP_H2O_GENERATORER',  DescGen^.TempH2O,2);
           if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
           begin
             // Emanuela DPR 192 nuove variabili
             W_Reale('REND_CALD_100R', DescGen^.Rend100, 2);
             W_Reale('REND_CALD_30R', DescGen^.Rend30, 2);
           end;
     end;
   end
   else
     if Ind = 2 then
     begin

       // ----------------------------------
       // Stampa Tabella
       // SISTEMA DI GENERAZIONE (UNI 10348)
       // Parte per le pompe di calore
       // ----------------------------------
         Sezione('CALDAIAR', 'False');
         Sezione('POMPACALORER', 'True');
         if DescGen^.CopT <> 0 then Wrep_str('ENERGIA_PCALR', 'Chimica')
         else Wrep_str('ENERGIA_PCALR', 'Elettrica');
         Wrep_str('DESC_IMPIANTO_TERMR',  DescrizioneImpianto(DescGen^.Descrizione));
         Wrep_str('MODELLO_GENR',         DescGen^.Model);
         W_Reale('NUM_GENERATORIR',       DescGen^.Numero, 0);
         Wrep_str('FLUIDO_VETTORER',      DescGen^.fluido);
         Wrep_str('COMBUSTIBILER',        DescGen^.combust);
         W_Reale('POT_NOM_UTILER',        DescGen^.PNom,   0);
         W_Reale('POT_ELETT_BRUCIATORER', DescGen^.Qbr,   0);
         if DescGen^.CopT <> 0 then W_Reale('COP_POMPACALR', DescGen^.CopT,   1)
         else W_Reale('COP_POMPACALR', DescGen^.CopE,   1);
         if DescGen^.TempSorg = 0 then  Wrep_str('TEMP_H2O_SORGENTER', 'Costante')
         else  Wrep_str('TEMP_H2O_SORGENTER', 'Variabile');
         W_Reale('VALORE_TEMPERATURAR', DescGen^.TempSorg,   1);
      end;
end;

END.

