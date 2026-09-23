unit calcCD;

interface

Uses
  Messages,
  Dialogs,
  Math,
  VarCarichi, UVariabili, metod10, Procle10,
  CalcVent, SysUtils, LibreriaGenerale, FunzProc1;

  function CalcCdLegge(TotSup,TotVolume,Cda3,Cda4:real):real;
  Function CalcolaCdFen:real;
 // Emanuela DPR 192 funzione che restituisce il valore limite
  function ValLim_FabbEnergiaPrim(S_V, Perc: real): real;

implementation
var
    fx : file of reccd;
    y,i:Smallint;

 {---------------------------- Calcolo del CD per Legge ----------------------}
 {-----------------------------------------------------------------------------
  Procedure: CalcCdLegge
  Author:    Emanuela
  Date:      28-lug-2004
  Arguments: TotSup,TotVolume,Cda3,Cda4:real
  Result:    real

  funzione che effettua il calcolo del CDDiLegge
  -----------------------------------------------------------------------------}
  function CalcCdLegge(TotSup,TotVolume,Cda3,Cda4:real):real;
  var
     SV,CdLegge:real;
     IndData: Integer;
  begin
   if TotVolume <> 0 then SV := TotSup / TotVolume
   else SV:=0;
   //Pos_combo(drivecombo,'Fabbricato','DataCostr',Prog^.DataCostr)
   indData := IndFabbricatoDataCostr(Prog^.DataCostr);
   if 1 = indData then
    begin
       if SV <= 0.3 then CdLegge:=Cda3;
       if SV >= 0.9 then CdLegge:=Cda4;
       if (SV > 0.3) and (SV < 0.9) then CdLegge:=Cda3+((SV-0.3)/0.6)*(Cda4-Cda3);
    end
   else
    begin
       if SV <= 0.2 then CdLegge:=Cda3;
       if SV >= 0.9 then CdLegge:=Cda4;
       if (SV > 0.2) and (SV < 0.9) then CdLegge:=Cda3+((SV-0.2)/0.7)*(Cda4-Cda3);
    end;
   CalcCdLegge:=CdLegge;
  end;

{---------}
 {-----------------------------------------------------------------------------
  Procedure: CalcolaCdFen
  Author:    Emanuela
  Date:      28-lug-2004
  Arguments: None
  Result:    real
  Funzione che calcola il CDFen
 -----------------------------------------------------------------------------}

  Function CalcolaCdFen:real;
  var
      Cd1, cd2:real;
  begin
     if (Prog^.comune > '') then
     begin
      CalcoloCD1_CD2DM(Prog^.Gradi, Cd1, Cd2);
      CalcolaCdFen :=  CalcCdLegge(DescGen1^[gencor].supLord,DescGen1^[gencor].volLord,cd1,Cd2);
     end
     else CalcolaCdFen := 0;
  end;



{-----------------------------------------------------------------------------
  Procedure: ValLim_FabbEnergiaPrim
  Author:    e.diquattro
  Date:      24-nov-2005
  Arguments: S_V: real
  Result:    real
  
  Cosa fa: Emanuela DPR 192 funzione che restituisce il valore limite
-----------------------------------------------------------------------------}
 function ValLim_FabbEnergiaPrim(S_V, Perc: real): real;
 const
    b1 = 601.0;
    b2 = 900.0;
    c1 = 901.0;
    c2 = 1400.0;
    d1 = 1401.0;
    d2 = 2100.0;
    e1 = 2101.0;
    e2 = 3000.0;
    { Prima di gennaio 2008
    Tab1192b1 = 10;
    Tab1192b2 = 15;
    Tab1192b3 = 45;
    Tab1192b4 = 60;

    Tab1192c1 = 15;
    Tab1192c2 = 25;
    Tab1192c3 = 60;
    Tab1192c4 = 85;

    Tab1192d1 = 25;
    Tab1192d2 = 40;
    Tab1192d3 = 85;
    Tab1192d4 = 110;

    Tab1192e1 = 40;
    Tab1192e2 = 55;
    Tab1192e3 = 110;
    Tab1192e4 = 145;
    }
    //Gennaio 2008
    Tab1192b1 = 9.5;
    Tab1192b2 = 14;
    Tab1192b3 = 41;
    Tab1192b4 = 55;

    Tab1192c1 = 14;
    Tab1192c2 = 23;
    Tab1192c3 = 55;
    Tab1192c4 = 78;

    Tab1192d1 = 23;
    Tab1192d2 = 37;
    Tab1192d3 = 78;
    Tab1192d4 = 100;

    Tab1192e1 = 37;
    Tab1192e2 = 52;
    Tab1192e3 = 100;
    Tab1192e4 = 133;

 var
   G1, G2, V1, V2, V3, V4, F1, F2, Ris: Real;
   Zona: Char;
   Gradi: Integer;
 begin
  //Emanuela dpr 192 nuova tabella per i valori limite del FEN
  Gradi := Round(Prog^.Gradi);

  Case Gradi of
   0..600:     Zona := 'A';
   601..900:   Zona := 'B';
   901..1400:  Zona := 'C';
   1401..2100: Zona := 'D';
   2101..3000: Zona := 'E';
  else
   Zona := 'F';
  end;
  case Zona of
   'A':begin
         { Prima di gennaio 2008
         F1 := 10 * Perc;
         F2 := 45 * Perc;
         }
         //gennaio 2008
         F1 := 9.5 * Perc;
         F2 := 41 * Perc;
       end;
   'B':begin
         G1 := b1;
         G2 := b2;
         V1 := Tab1192B1 * Perc;
         V2 := Tab1192B2 * Perc;
         V3 := Tab1192B3 * Perc;
         V4 := Tab1192B4 * Perc;
       end;
   'C':begin
         G1 := c1;
         G2 := c2;
         V1 := Tab1192c1 * Perc;
         V2 := Tab1192C2 * Perc;
         V3 := Tab1192C3 * Perc;
         V4 := Tab1192C4 * Perc;
       end;
   'D':begin
         G1 := d1;
         G2 := d2;
         V1 := Tab1192D1 * Perc;
         V2 := Tab1192D2 * Perc;
         V3 := Tab1192D3 * Perc;
         V4 := Tab1192D4 * Perc;
       end;
   'E':begin
         G1 := e1;
         G2 := e2;
         V1 := Tab1192E1 * Perc;
         V2 := Tab1192E2 * Perc;
         V3 := Tab1192E3 * Perc;
         V4 := Tab1192E4 * Perc;
       end;
   'F':begin
         { Prima di gennaio 2008
         F1 := 55 * Perc;
         F2 := 145 * Perc;
         }
         //gennaio 2008
         F1 := 52 * Perc;
         F2 := 133 * Perc;
       end;
  end;
  if Caso = 1 then
    if (Zona <> 'A') and (Zona <> 'F') then
    begin
      {$IFDEF VERSIONE_12}
        DatiV192.ValMaxFAEP := V4;
      {$ELSE}
        DatiV192[Gencor -1].ValMaxFAEP := V4;
      {$ENDIF}
    end
    else
    begin
      {$IFDEF VERSIONE_12}
       DatiV192.ValMaxFAEP := F2;
      {$ELSE}
       DatiV192[GenCor - 1].ValMaxFAEP := F2;
      {$ENDIF}
    end;
  if (Zona <> 'A') and (Zona <> 'F') then
  begin
      F1 := RoundTo((V1-(V1-V2)*((Gradi-G1)/(G2-G1))), -3);
      F2 := RoundTo((V3-(V3-V4)*((Gradi-G1)/(G2-G1))), -3);
  end;
  if S_V <= 0.2 then Result := F1;
  if S_V >= 0.9 then Result := F2;
  if (S_V > 0.2) and (S_V < 0.9) then Result := F1 +((S_V-0.2)/0.7)*(F2 - F1);
 end;


END.




