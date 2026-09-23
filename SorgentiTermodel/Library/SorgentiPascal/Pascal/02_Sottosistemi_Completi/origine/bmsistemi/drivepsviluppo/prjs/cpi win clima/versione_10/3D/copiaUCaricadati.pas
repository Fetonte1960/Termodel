unit CopiaUCaricadati;

interface
uses db,dbtables,SysUtils,Definiz,varcarichi,UdbT,UDataOutT,LibreriaGenerale,Uleggiscrividati;

Procedure Caricadati;
Procedure CaricaArchivi;
Procedure OrdinaSiglaDiametri(var Tubazione: RecTubaz);

implementation

Procedure Caricadati;
begin
Leggi_Reti(DMtutti.T_reti,DMtutti.T_reti,dmtutti.DS_Reti);
Leggi_Terminali(DMtutti.T_Terminali,DMtutti.T_DettaglioTerminali,dmtutti.DS_Terminali);
Leggi_Locali(dmtutti.t_Locali,dmtutti.t_Pareti,dmtutti.ds_Locali);
end;

Procedure CaricaArchivi;
var
  i, j, K, nValv, nPos: Integer;
begin
 {$IFDEF CANALI}
  Leggi_Update(DMtutti.T_Update,DMtutti.T_Update,dmtutti.DS_Update);
 {$ENDIF}
  //Leggi_Piani(DMtutti.T_Piani,DMtutti.T_PPiano,dmtutti.DS_Piani);
  NTubaz := 0;
  Leggi_TiPiRete(DMtutti.T_TiPiRete,DMtutti.T_Diametri,dmtutti.DS_TiPiRete);
  for i := 1 to NTipiRete do
  begin
   with TipiRete_D^[i] do
   begin
    inc(NTubaz);

    Tubaz_D^[NTubaz].NSez := 0;
    for j := 1 to NSezB do
    begin
      if UpperCase(SezB[j].Utiliz) = UpperCase('SI') then
      begin
       inc(Tubaz_D^[NTubaz].NSez);
       Tubaz_D^[NTubaz].sez[Tubaz_D^[NTubaz].NSez].Dnom := SezB[j].DNom;
       Tubaz_D^[NTubaz].sez[Tubaz_D^[NTubaz].NSez].Dint := SezB[j].Dint;
       Tubaz_D^[NTubaz].sez[Tubaz_D^[NTubaz].NSez].spes := SezB[j].spes;
       Tubaz_D^[NTubaz].sez[Tubaz_D^[NTubaz].NSez].form := SezB[j].form;
      end;
    end;
    Tubaz_D^[NTubaz].Num := Num;
    Tubaz_D^[NTubaz].Cod := Cod;
    Tubaz_D^[NTubaz].Descr := Descr;
    Tubaz_D^[NTubaz].Dens := Dens;
    Tubaz_D^[NTubaz].Rug := Rug;
    OrdinaSiglaDiametri(Tubaz_D^[NTubaz]);
   end;
  end;
perdite_in_memoria:=false;
 Leggi_Perdite(DMtutti.T_Perdite,DMtutti.T_Perdite,dmtutti.DS_Perdite);
{$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
 DMtutti.t_Perdite_Conc.Close;
 DMtutti.t_Perdite_Conc.DatabaseName := Percorso_Archivi;
 //DMtutti.tt3.Close;
 //DMtutti.tt3.DatabaseName := Percorso_Archivi;
 Leggi_Perdite_Conc(DMtutti.T_Perdite_Conc,DMtutti.T_Dett_Perdite_Conc,dmtutti.DS_Perdite_Conc);
 // caricamento delle altre perdite
 for i := 1 to NPerditeConc do
 begin
   if (PerdConc_D^[i].NDPerdC <> 0) and (PerdConc_D^[i].NDPerdC <> 1) then
   begin
    for K := 1 to PerdConc_D^[i].NDPerdC do
    begin
      if NPerd < MaxPerd then
        inc(NPerd);
      Perd_D^[NPerd].Cod  := PerdConc_D^[i].Cod + '_' + FloatToSTr(PerdConc_D^[i].DPerdC[K].PCGiri);
      Perd_D^[NPerd].Descr:= PerdConc_D^[i].Descr;
      Perd_D^[NPerd].Leq  := 0;
      Perd_D^[NPerd].Zeta := PerdConc_D^[i].DPerdC[K].PCZeta ;
      Perd_D^[NPerd].Rit  := 'S';
    end;
   end
   else
   begin
     if NPerd < MaxPerd then
        inc(NPerd);
     Perd_D^[NPerd].Cod  := PerdConc_D^[i].Cod;
     Perd_D^[NPerd].Descr:= PerdConc_D^[i].Descr;
     Perd_D^[NPerd].Leq  := 0;
     Perd_D^[NPerd].Zeta := PerdConc_D^[i].DPerdC[j].PCZeta ;
     Perd_D^[NPerd].Rit  := 'S';
   end;
 end;
 //spostato il putatore
 //New(Valv_D);
 For i := 1 to MaxCod do
 begin
    Valv_D^[i].cod := '';
    Valv_D^[i].dmin := 0;
    Valv_D^[i].dmax := 0;
 end;
 nValv := 0;
 For i := 1 to NPerditeConc do
 begin
     inc(nValv);
     Valv_D^[nValv].cod := PerdConc_D^[i].Cod;
     Valv_D^[i].dmin := PerdConc_D^[i].DN;
     Valv_D^[i].dmax := PerdConc_D^[i].DN;
     nPos := 0;
     for j := 1 to PerdConc_D^[i].NDPerdC do
     begin
        inc(nPos);
        Valv_D^[nValv].tacche[nPos].cod := FloatToSTr(PerdConc_D^[i].DPerdC[j].PCGiri);
        // Emanuela se inseriamo il Kv nell'archivio, prendere il Kv
        Valv_D^[nValv].tacche[nPos].kv1 := PerdConc_D^[i].DPerdC[j].PCKV;
     end;
 end;
{$IFEND}
end;

{-----------------------------------------------------------------------------
  Procedure: OrdinaSiglaDiametri
  Author:    Emanuela
  Date:      28-giu-2005
  Arguments: var Tubazione: RecTubaz
  Result:    None

  Prima di utilizzare i tubi ordino in ordine crescente i diametri
-----------------------------------------------------------------------------}
Procedure OrdinaSiglaDiametri(var Tubazione: RecTubaz);
var
 i, j: Integer;
 Temp: Recsez;
begin
 for i := 1 to Tubazione.NSez do
 begin
   for j := i+1 to Tubazione.NSez do
     if Tubazione.Sez[i].Dint > Tubazione.Sez[j].Dint then
     begin
       temp := Tubazione.Sez[i];
       Tubazione.Sez[i] := Tubazione.Sez[j];
       Tubazione.Sez[j] := Temp;
     end;
 end;
end;

end.
