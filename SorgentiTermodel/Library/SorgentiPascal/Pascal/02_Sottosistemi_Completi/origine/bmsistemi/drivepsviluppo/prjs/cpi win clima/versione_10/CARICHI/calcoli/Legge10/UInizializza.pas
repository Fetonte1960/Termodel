unit UInizializza;

interface
Uses
  Uvariabili,VarCarichi,metod10,MetodL10,Ustatistica,libreriagenerale,
  ULeggiscrividati;

Procedure Disponi;
Procedure Inizializza;
procedure PoniaNilTuttiPuntatori;
Procedure Inizializza_punt_L10;

implementation

procedure PoniaNilTuttiPuntatori;
begin
  Stampe_D := nil;
  Localita_D := nil;
  ArcLocalita_D := nil;
  ImPianto_D := nil;
  Ambienti_D := nil;
  Piani_D := nil;
  Zone_D := nil;
  Zone10 := nil;
  Finestre_D := nil;
  Orari_D := nil;
  Confine_D := nil;
  Esposizioni_D := nil;
  POnti_D := nil;
  Frontierelin_D := nil;
  Muri_d := nil;
  porte_D := nil;
  Frontiere_D := nil;
  Strutture_D := nil;
  PavSuTer := nil;
  ArchCom := nil;
  prog := nil;
  Zone11 := nil;
  DescGen1 := nil;
  C_D := nil;
  Prv := nil;
  tempmed := nil;
  Ambienti_R := nil;
  Tubaz_D := nil;
  MatTubaz_D := nil;
  Perd_D := nil;
  TipiRete_D := nil;
  TipoTerminali_D := nil;
end;

Procedure Inizializza_punt_L10;
Var
  i:integer;
begin
    {$Ifdef Versione_14}
    {$Else}
    PoniaNilTuttiPuntatori;
    initPuntatori;
    For i := 1 to MaxFrontiere do Frontiere_d^[i] := nil;
    For i := 1 to MaxfrontiereLin do FrontiereLin_d^[i] := nil;
    LeggiDati;
    {$Endif}
    New(RisFc);
    new(tempestmed);
    new(tempintmed);
    PDati10 := Dati10.Create;
    New(indmese);
    New(HbH);
    New(HdH);
    New(VERTEO);
    New(VERTN);
    New(VERTSUD);
    New(VERTNONE);
    New(VERTSOSE);
    New(prn_TotH);
    New(prn_lTf);
    New(prn_fin);
    New(POb_a);
    New(rec_prn);
    New(k10);
    New(TotHEspLocFissi);
    New(Ql);
    New(QI);
    New(TotQsi);
    New(TotQse);
    New(TabZona10);
    New(Fil);
    New(Fig);
    New(MatQhvs);
    New(MatQhr);
    New(MatQhr24);
    New(ED);
    New(EP);
    New(QP);
    New(CPM);
    New(ETUM);
    New(Q);
    New(generat);
    New(energM);
    New(DescGen);
    New(prn_pt);
    New(VentForzZona);
    new(NumF);
    new(NumP);
    new(St1Loc);
    new(St2Loc);
    new(St3Loc);
    new(Dm);
    new(tempac);
    new(TotDisp);
    new(STq);
    new(a);
    New(dclLoc);
    new(pvst1);
    new(ept);
end;

Procedure Inizializza;
begin
{$Ifdef Versione_14}
LeggiDatiT;
{$Else}
Inizializza_punt_L10;
{$Endif}
end;

Procedure Disponi;
Var
  i:integer;
begin
{$Ifdef Versione_14}
exit;
{$Endif}
    Dispose(RisFc);
    dispose(tempestmed);
    dispose(tempintmed);
    Dispose(indmese);
    Dispose(HbH);
    Dispose(HdH);
    Dispose(VERTEO);
    Dispose(VERTN);
    Dispose(VERTSUD);
    Dispose(VERTNONE);
    Dispose(VERTSOSE);
    Dispose(prn_TotH);
    Dispose(prn_lTf);
    Dispose(prn_fin);
    Dispose(POb_a);
    Dispose(rec_prn);
    Dispose(k10);
    Dispose(TotHEspLocFissi);
    Dispose(Ql);
    Dispose(QI);
    Dispose(TotQsi);
    Dispose(TotQse);
    Dispose(TabZona10);
    Dispose(Fig);
    Dispose(Fil);
    Dispose(MatQhvs);
    Dispose(MatQhr);
    Dispose(MatQhr24);
    Dispose(ED);
    Dispose(EP);
    Dispose(QP);
    Dispose(CPM);
    Dispose(ETUM);
    Dispose(Q);
    Dispose(generat);
    Dispose(energM);
    Dispose(DescGen);
    Dispose(prn_pt);
    Dispose(VentForzZona);
    Dispose(ept);
    DisposePuntatori;
end;

end.
