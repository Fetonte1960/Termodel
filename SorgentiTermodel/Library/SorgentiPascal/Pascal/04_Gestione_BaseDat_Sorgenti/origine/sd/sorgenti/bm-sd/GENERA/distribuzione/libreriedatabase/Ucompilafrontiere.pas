unit UCompilafrontiere;

interface

Uses
 Dialogs, Math, DBTables, Classes, Varcarichi,Varcarichi_estivo_14,Libreriagenerale,UMessaggiCarichi, UdataLink,
 udb, Utireport, sysutils, Variabiligenerali, Uti_term, URicercaDati
 {$Ifdef L10}
 ,calccd
   {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}, GestioneGrafico{$ELSE} ,UStatistica {$IFEND}
 {$EndIf};



  Procedure Init_ris;
  Function  Esposizpar(Cod, Lato: String): Integer;
  Procedure CopiaProfilo;
  Procedure CopiaDati;
  Procedure CaricaDatiZonaL10(nZ: Integer; var nZL10: Integer; NImp: Integer; TInv: real);
  function  EsisteZona(CodiceZona: String; NZ: Integer; var indZona: Integer): Boolean;
  Procedure Compila_non_clima;
  Procedure VerificaAggregati(var Amb: RecAmb; var VolumeAmb: Real; var VLor: Real);
  function  EsistePareteAmb(CodPar, Confine, Lato: String; AmbO: RecAmb; var valP: Integer): Boolean;
  procedure RipulisciAmbienteTemporaneo(var Amb: RecAmb);
  function  SpessPar(codPar: String): real;
  procedure CalcolaVolumeSpessori(AmbTemp: RecAmb; AltLordaP: Real; var VLordo: Real);
  Procedure CompilaMuri;
  Function  CalcSupNetta(Amb: recAmb; parete: Integer): Real;
  Function  NuovaFrontLin(CodiceAmb: Integer): Integer;
  Function  NuovaFront(CodiceAmb: Integer): Integer;
  Procedure CompilaFront;
  procedure CalcoloSuperficieLordaParete(var Amb: recAmb; var SLP: Real; AN, AL: Real; indP: Integer);
  procedure CalcolaVolumeLordo(Amb: RecAmb; var VL, SpL: Real; AlTN, AltL: real; indPar: Integer);
  Procedure CaricaRigaParete(Amb: RecAmb; CodiceParete, indPar: Integer; SupNetta, SupL: Real; var TotdispAmb, DTCorr, IncrCorr, SupT: Real; var EspC: Integer);
  Procedure CaricaRigaPonte(Amb: RecAmb; indPar, EspCorr: Integer; DTCorr, IncrCorr: Real; var TotdispAmb: Real);
  Procedure CaricaRigaFinestra(Amb: RecAmb; CodiceParete, indPar, EspCorr: Integer; SupP, DTCorr: Real; var TotdispAmb: Real);
  function  VerificaParetePrecedente(Indice: Integer; AmbT: RecAmb): boolean;

implementation

{$Ifdef L10}
Uses Uvariabili;
{$Else}
Uses MainForm;
{$Endif}

{-----------------------------------------------------------------------------
  Procedure: Init_ris
  Author:    e.diquattro
  Date:      18-apr-2006
  Arguments: None
  Result:    None

  Cosa fa: inizializza i dati che conterranno i valori di calcolo
-----------------------------------------------------------------------------}
Procedure Init_ris;
begin
  {$Ifdef L10}
   with DescGen1^[gencor] do
   begin
       dispers  := 0;
       VolLord  := 0;
       SupLord  := 0;
       SV       := 0;
       Dt       := Prog^.TInv - Prog^.TEst;
       Cdfen    := 0;
       CdLeg    := 0;
       CdAdot   := 0;
       Fts      := 0;
       GiorniRis:= 0;
       Fen      := 0;
       RicAr    := 0;
       IrradS   := 0;
       DtMed    := 0;
       AppGr    := 0;
       CorUtilAg:= 0;
       RedETg   := 0;
       FenLim   := 0;
   end;
  {$Endif}
end;

{-----------------------------------------------------------------------------
  Procedure: CopiaDati
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Copia i dati degli archivi generali per il calcolo
-----------------------------------------------------------------------------}
Procedure CopiaDati;
Var
  Nome1, Nome2, Comune: String;
  i, j, k, Numeroprovince, IndTabZone, IndZona, npiante: Integer;
  Trovato: Integer;
  ok: boolean;
  TabTemp: TTable;
  AltezzaNettaPiano, Qrel: real;
begin

 // --------------------------------
 // Copia i dati estivi del progetto
 // --------------------------------
 With prog^ do
 begin
    Localita_D^.HMare         := AltCom;
    Localita_D^.Lat           := LatCom;
    Localita_D^.Lon           := Longitudine;
    Localita_D^.MeriDRifOra   := MeriDRifOra;
    Localita_D^.OraLegFine    := OraLegFine;
    Localita_D^.OraLegInizio  := OraLegInizio;
    Localita_D^.TIestBS       := TEst;
    Localita_D^.TInvEsternaBS := TEst;
    Localita_D^.TInvEsternaBU := 0{TInvEsternaBU};
    Localita_D^.TEstEsternaBS := TEstEsternaBS;
    Localita_D^.TEstEsternaBU := 0{TEstEsternaBU};
    Localita_D^.UInvEsterna   := urest;
    Localita_D^.UEstEsterna   := UEstEsterna;
    Localita_D^.ET            := ET;
    Localita_D^.FattFoschia   := FattFoschia;
    Localita_D^.Riflettivita  := Riflettivita;
 end;

  // Emanuela 6/9/2004 inseriti qua affinchè vengano stampati anche nella relazione delle
  // dispersioni
  Wrep_str('NOMECOMUNE', prog^.Comune);               // OK Comune della Località
  Wrep_str('PROV', prog^.ComuneRif);                  // OK Provincia della Località

  TabTemp := TTable.Create(nil);
  with TabTemp do
  begin
    databasename:=da;
    tablename:='dati_estivi_province.db';
    open;
    first;
    i:=1;
    while (Not eof) do
      with prv^[i] do
      begin
        Indrad:=fieldbyname('IndDatiIrrad').AsInteger;
        indprov:=i;
        Sigla:=fieldbyname('Sigla Prov').AsString;
        nome:=fieldbyname('Prov').AsString;
        Numeroprovince:=i;
        next;
        if i >= MaxLung then
           MessageDlg('Province maggiori del vettore', mtInformation, [mbOK], 0)
        else Inc(i);
      end;
    close;

    tablename:='Prosp_VI_10349.db';
    open;
    first;
    i:=1;
    while (Not eof) do
      with tempmed^[i] do
      begin
        Ind:=fieldbyname('N').asinteger;
        t1:=0;
        for j:=1 to 12 do
        datc[j]:=fields[3+j].AsFloat;
        altitudine:=fieldbyname('altitudine').AsInteger;
        next;
        if i >= MaxLungt then
           MessageDlg('Temperature medie maggiori del vettore', mtInformation, [mbOK], 0)
        else Inc(i);
      end;
    close;

    tablename:='Prosp_XIV.db';
    open;
    first;
    i:=1;
    while (Not eof) do
    begin
      for j:=1 to  Numeroprovince do
        with prv^[j] do
          if i=indrad then
          Omega:=fieldbyname('Velocita Vento').asinteger;
          next;
          if i >= MaxLung then
             MessageDlg('Province maggiori del vettore', mtInformation, [mbOK], 0)
          else Inc(i);
    end;
    Close;
    Free;
  end;
 {$IFDEF ESTIVO}
  Compila_non_clima;
  for i := 1 to NZone do
  begin
     Zone_D^[i].CoeffIntermittEst := (Zone_D^[i].IncrIntE / 100) + 1;
  end;
 {$ENDIF}
  Nrisultati := Ngeneratori;
  Nzone10 := 0;
  IndZona := 0;
  for i := 1 to NAmbienti do
  begin
    // Emanuela 2/12/2004 Controllo che con stiamo considerando le zone non risc
    if (NZone10 = 0) and (CompareStr(UpperCase(ambienti_d^[i]^.CodZona), UpperCase('Non risc')) <> 0) then
    begin
     // Inserimento della prima zona trovata
     IndTabZone := CercaIndiceZone(ambienti_d^[i]^.CodZona);
     if IndTabZone <> 0 then
     begin
        CaricaDatiZonaL10(IndTabZone, NZone10, ambienti_d^[i]^.NumImpianto, 0);
        ambienti_d^[i]^.Z10 := NZone10;
     end
     else
       Echo('Esiste una zona  ' + ambienti_d^[i]^.CodZona + ' associata all''ambiente ' + ambienti_d^[i]^.Denom + ' che non esiste nell''archivio zone');
    end
    else
    begin
      // Verifica se la zona esiste, se non esiste la inserisco
      IndZona := 0;
      // Emanuela 2/12/2004 Controllo che con stiamo considerando le zone non risc
      if not EsisteZona(ambienti_d^[i]^.CodZona, NZone10, IndZona) and (CompareStr(UpperCase(ambienti_d^[i]^.CodZona), UpperCase('Non risc')) <> 0) then
      begin
         IndTabZone := CercaIndiceZone(ambienti_d^[i]^.CodZona);
       if IndTabZone <> 0 then
       begin
         CaricaDatiZonaL10(IndTabZone, NZone10, ambienti_d^[i]^.NumImpianto, ambienti_d^[i]^.TNInv);
         ambienti_d^[i]^.Z10 := NZone10;
       end
       else
         Echo('Esiste una zona  ' + ambienti_d^[i]^.CodZona + ' associata all''ambiente ' + ambienti_d^[i]^.Denom + ' che non esiste nell''archivio zone');
      end
      else ambienti_d^[i]^.Z10 := IndZona;
    end;
  end; {fine del for che scorre gli ambienti}
  NZone11:=Nzone10;

  for i := 1 to NAmbienti do
  begin
    IndTabZone := CercaIndiceZone(ambienti_d^[i]^.CodZona);
    if IndTabZone <> 0 then
    begin
        // Emanuela 21/12/2004 controllo se il valore della ventilazione è stata inserita correttamente nell'ambiente
        if SameValue(ambienti_d^[i]^.Ventilazione, 0) then ambienti_d^[i]^.Ventilazione := Zone_D^[IndTabZone].VentMecTratt;
        if SameValue(ambienti_d^[i]^.InfEst, 0)       then ambienti_d^[i]^.InfEst := Zone_d^[IndTabZone].InfInv + Zone_d^[IndTabZone].PortMec;
        if SameValue(ambienti_d^[i]^.InfInv, 0)       then ambienti_d^[i]^.InfInv := Zone_d^[IndTabZone].InfInv + Zone_d^[IndTabZone].PortMec;
    end;
  end;

 for i := 1 to NAmbienti do
 begin
    if UpperCase(ambienti_d^[i]^.CodZona) = 'NON RISC' then
    begin
       AltezzaNettaPiano := AltLordaPiano(ambienti_d^[i]^.Piano, 'N');
       ambienti_d^[i]^.HSoffitto := AltezzaNettaPiano;
    end;
 end;

 for i := 1 to NFinestre do
 begin
   // caricamento di informazioni per il calcolo
   Finestre_d^[i].Shading      := Finestre_d^[i].ShadingSchermo + Finestre_d^[i].shadingVetro;
   Finestre_d^[i].PosizSchermo := Finestre_d^[i].TipoSchermatura;
   Finestre_d^[i].Rientranza   := 0;
   Finestre_d^[i].DOrizz       := Finestre_d^[i].DistBalcomi;
   Finestre_d^[i].LOrizz       := Finestre_d^[i].ProfBalconi;
   Finestre_d^[i].LVertSX      := Finestre_d^[i].ProfVerticaleSx;
   Finestre_d^[i].LVertDX      := Finestre_d^[i].ProfVerticaleDx;
   Finestre_d^[i].DVertSX      := Finestre_d^[i].DistVerticaleSx;
   Finestre_d^[i].DVertDX      := Finestre_d^[i].DistVerticaleDx;
 end;

{$IFDEF L10}
 {caricamento dei piani e delle Zmin e Zmax, perchè usate nel calcolo}
 npiante := 1;
 for i := 1 to NPiani do
 begin
   ept^[npiante].NomeP := Piani_D^[i].Cod;
   if i = 1 then
   begin
      ept^[npiante].ZMin := 0;
      ept^[npiante].ZMax := Piani_D^[i].AltL;
      QRel := Piani_D^[i].AltL;
   end
   else
   begin
     ept^[npiante].ZMin := QRel;
     ept^[npiante].ZMax := QRel + Piani_D^[i].AltL;
     QRel := QRel + Piani_D^[i].AltL;
   end;
   inc(npiante);
 end;
{$ENDIF}
end;

{-----------------------------------------------------------------------------
  Procedure: Esposizpar
  Author:    e.diquattro
  Date:      17-nov-2006
  Arguments: Cod,Lato:String
  Result:    Integer
  
  Cosa fa: Calcola l'incremento per esposizione e verifica se esistono vicini
           asseni o presenti
-----------------------------------------------------------------------------}
Function Esposizpar(Cod, Lato: String): Integer;
Var
 i: Integer;
 Tipo, codamb: String;
 Inclinaz, Ori, TCEST, TCINV, INCR_ESP, TI: Real;
 Trovato: Boolean;
begin
  Result := 0; 
  If CompareStr(Uppercase(cod), 'ESTERNO') = 0 then
  begin
    INCR_ESP := 1;
    Inclinaz := 90;
    Ori := 0;
    // ---------------------------------------------------------------------
    // Incremento % automatico per esposione come da norma UNI 7357
    // ---------------------------------------------------------------------
    IF UpperCase(Lato)='OR'then
       Inclinaz:=0
    else
    IF UpperCase(Lato)='N' then
    begin
     Ori := 0;
     INCR_ESP:= 1.20;
    end
    else
     IF UpperCase(Lato)='NE'then
     begin
       Ori := 45;
       INCR_ESP:= 1.20;
     end
     else
     IF UpperCase(Lato)='E' then
     begin
       Ori := 90;
       INCR_ESP:= 1.15;
     end
     else
     IF UpperCase(Lato)='SE' then
     begin
       Ori := 135;
       INCR_ESP:= 1.10;
     end
     else
     IF UpperCase(Lato)='S' then
     begin
       Ori := 180;
       INCR_ESP:= 1.00;
     end
     else
     IF UpperCase(Lato)='SO' then
     begin
       Ori := 225;
       INCR_ESP:= 1.05;
     end
     else
      IF UpperCase(Lato)='O' then
      begin
       Ori := 270;
       INCR_ESP := 1.10;
      end
      else
      IF UpperCase(Lato)='NO' then
      begin
       Ori := 315;
       INCR_ESP:= 1.15;
      end;

      i := 1;
      Trovato := False;
      while (i < NEsposizioni) and (not Trovato) do
      begin
        if ((Ori = Esposizioni_d^[i].Orient) and
            (Inclinaz = Esposizioni_d^[i].Inclin) and
            ('E' = UpperCase(Esposizioni_d^[i].Tipo)))
        then Trovato := True
        else inc(i);
      end;
      if not Trovato then
      begin
        Inc(Nesposizioni);
        with Esposizioni_D[Nesposizioni] do
        begin
          Inclin:=Inclinaz;
          Orient:=ori;
          Tipo:='E';
          Codice:= Lato;
          Denom := Lato;
          result:= NEsposizioni;
          IncrSic := INCR_ESP;
          Trifinv:=0;
          TRifEst:=0;
          codpav:='';
          codost:='';
        end;
      end
      else  result := i;
  end
  else
  begin
    if CompareStr(UpperCase(lato[1]), 'L') = 0 then
    begin
      codamb := copy(lato,2,length(lato)-1);
      i:=1;
      Trovato := False;
      while (i <= NAmbienti) and (not Trovato) do
      begin
        if (Codamb = Ambienti_d^[i].CodNum) then
           Trovato := True
        else inc(i);
      end;

      if not Trovato then
      begin
        echo ('Il confine con altro locale "' + codamb + '" non trova corrispondenza.');
        result := 0;
      end
      else
      begin
        // Emanuela 12/07/2004 modificato perchè si deve tenere conto
        // della zona se è non riscaldato e non della denominazione
        if CompareStr(UpperCase(Ambienti_d^[i].CodZona), 'NON RISC') = 0 then // Locali non climatizzati
        begin
          TCInv := Ambienti_d^[i].TNInv;
          TCest := Ambienti_d^[i].TNEst;
        end
        else
        begin
            // Emanuela Modifica per considerare il caso del vicino presente o del vicino assente
           {$IF (Defined(VERSIONE_12) or Defined(VERSIONE_13)) and Defined(L10)}
            if ConfineInterno(Cod, TI) then
               TCInv := TI
            else
            begin
             if VicAss and
               ((uppercase(DescGen1^[gencor].Descrizione) <> uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[i].Impianto)].GenInvt)))
             then TCInv := TempVicinoAll
             else TCInv := zone_d^[Ambienti_d^[i].Zona].TInv;
            end;
           {$ELSE}
             TCInv := zone_d^[Ambienti_d^[i].Zona].TInv;
           {$IFEND}
             TCEst:=zone_d^[Ambienti_d^[i].Zona].TEst;
        end;
        if NEsposizioni <> 0 then
        begin
          i:=1;
          Trovato := False;
          while (i <= NEsposizioni) and (not Trovato) do
          begin
             if (CompareStr(UpperCase(Esposizioni_d^[i].Codice),'LOCALE') = 0) and
                (Tcinv = Esposizioni_d^[i].TrifInv) and
                (Tcinv = Esposizioni_d^[i].TrifInv) then
                Trovato := True
             else inc(i);
          end;

          if not Trovato then
          begin
            inc(Nesposizioni);
            with Esposizioni_d^[Nesposizioni] do
            begin
               Codice := 'LOCALE';
               Trifinv := Tcinv;
               TRifEst := Tcest;
               orient  := 0;
               Inclin  := 0;
               Tipo    := 'I';
               Denom   := 'LOCALE';
               result  := NEsposizioni;
               codpav  := '';
               codost  := '';
               IncrSic := 0;
            end;
          end
          else result:=i;
        end; {se NEsposizione <> 0}
      end;
    end {If non trovata corrispondenza tra i confini associati ai divisori}
    else
    begin
      if NEsposizioni <> 0 then
      begin
        i := 1;
        Trovato := False;
        while (i <= NEsposizioni) and (not Trovato) do
        begin
          if CompareStr(UpperCase(Cod), UpperCase(Esposizioni_d^[i].Codice)) = 0 then
             Trovato := True
          else inc(i);
        end;
        if not Trovato then
        begin
          result := 0;
          Erroregen := true;
          echo('Il Confine di codice ' + cod + ' non è stato trovato in archivio.');
        end
        else result := i;
      end; {if NEsposizioni <> 0}
    end; {End If CompareStr(UpperCase(lato[1]), 'L')}
  end; {End If CompareStr(Uppercase(cod), 'ESTERNO')}
end;

{-----------------------------------------------------------------------------
  Procedure: CopiaProfilo
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Carica i dati dei profili orari
-----------------------------------------------------------------------------}
Procedure CopiaProfilo;
Var
  i, j:Integer;
begin
{$IFDEF ESTIVO}
  for i:=1 to NOrari do
    for j:=0 to 23 do
      With Orari_D[i] do
        case j of
          0:Profili_D^[i][j]:=Ora1;
          1:Profili_D^[i][j]:=Ora2;
          2:Profili_D^[i][j]:=Ora3;
          3:Profili_D^[i][j]:=Ora4;
          4:Profili_D^[i][j]:=Ora5;
          5:Profili_D^[i][j]:=Ora6;
          6:Profili_D^[i][j]:=Ora7;
          7:Profili_D^[i][j]:=Ora8;
          8:Profili_D^[i][j]:=Ora9;
          9:Profili_D^[i][j]:=Ora10;
          10:Profili_D^[i][j]:=Ora11;
          11:Profili_D^[i][j]:=Ora12;
          12:Profili_D^[i][j]:=Ora13;
          13:Profili_D^[i][j]:=Ora14;
          14:Profili_D^[i][j]:=Ora15;
          15:Profili_D^[i][j]:=Ora16;
          16:Profili_D^[i][j]:=Ora17;
          17:Profili_D^[i][j]:=Ora18;
          18:Profili_D^[i][j]:=Ora19;
          19:Profili_D^[i][j]:=Ora20;
          20:Profili_D^[i][j]:=Ora21;
          21:Profili_D^[i][j]:=Ora22;
          22:Profili_D^[i][j]:=Ora23;
          23:Profili_D^[i][j]:=Ora24;
        end;
  NProfili:=NOrari+1;
  for j:=0 to 23 do
      Profili_D^[NProfili][j] := 100;
{$ENDIF}
end;

{-----------------------------------------------------------------------------
  Procedure: EsisteZona
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: CodiceZona: String; NZ: Integer; var indZona: Integer
  Result:    Boolean

  Cosa fa: Funzione che verifica se la ZonaL10 esiste già nella tabella
-----------------------------------------------------------------------------}
function EsisteZona(CodiceZona: String; NZ: Integer; var indZona: Integer): Boolean;
var
  i: Integer;
  Descrizione: String;
begin
  Result := False;

  For i := 1 to NZone do
  begin
    if CompareStr(UpperCase(Zone_d^[i].Cod), UpperCase(CodiceZona)) = 0 then
    begin
      Descrizione := Zone_d^[i].Denom;
    end;
  end;

  for i := 1 to NZ do
  begin
    if CompareSTR(UpperCase(zone10^[i].descr), UpperCase(Descrizione)) = 0 then
    begin
      Result := True;
      indZona := i;
      exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CaricaDatiZonaL10
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: nZ: Integer; var nZL10: Integer; NImp: Integer; TInv: real
  Result:    None
  
  Cosa fa: procedura che carica i valori della zonaL10 e zonaL11
-----------------------------------------------------------------------------}
Procedure CaricaDatiZonaL10(nZ: Integer; var nZL10: Integer; NImp: Integer; TInv: real);
begin
 if NZL10 < MaxZone10 then
 begin
  inc(NZL10);
 end
 else
 begin
   MessageDLG('Non è possibile allocare altre Zone di legge, spazio insufficiente', mtInformation, [mbOK], 0);
 end;
  //Emanuela 17/9/2004 modifica necessari affinchè vengono considerate le zone non risc
  if nz = 0 then
  begin
    zone10^[NZL10].Descr := 'Non risc';
    zone10^[NZL10].Taria := TInv;
  end
  else
  begin
    zone10^[NZL10].Descr := Zone_d^[nZ].Denom;
    zone10^[NZL10].Taria := Zone_d^[nZ].Tinv;
  end;
  zone10^[NZL10].NOreNotte  := Impianto_d^[NImp].NOreNotte;
  zone10^[NZL10].NOreGiorno := Impianto_d^[NImp].NOreGiorno;
  zone10^[NZL10].DayWeekOff := Impianto_d^[NImp].DayWeekOff;
  zone10^[NZL10].Tempmin    := Round(Impianto_d^[NImp].Tempmin);
  zone10^[NZL10].TipoTerm   := Impianto_d^[NImp].TipoTerm;
  zone10^[NZL10].TipoProd   := Impianto_d^[NImp].TipoProd;
  zone10^[NZL10].TipoReg    := Impianto_d^[NImp].TipoReg;

  //Emanuela 17/9/2004 modifica necessari affinchè vengono considerate le zone non risc
  if nz = 0 then
  begin
   zone11^[NZL10].Classif   := 'E1(1)';
   zone11^[NZL10].MotivVent := '';
   zone11^[NZL10].TempOc    := 0;
   zone11^[NZL10].AriaEst   := 0;
   zone11^[NZL10].Affol     := 0;
   zone11^[NZL10].N         := 0;
   zone11^[NZL10].Ngo       := 0;
  end
  else
  begin
    zone11^[NZL10].Classif := Zone_d^[nZ].Classif;
   // Emanuela verifica della compatibilità con la versione 11
   if VerificaVersione <> 11 then
   begin
    Impianto_d^[NImp].Motivo  := Zone_d^[nZ].Motivo;
   end;
    zone11^[NZL10].MotivVent := Impianto_d^[NImp].Motivo;
    zone11^[NZL10].TempOc    := Zone_d^[nZ].TempOc;
    zone11^[NZL10].AriaEst   := Zone_d^[nZ].AriaEst;
    zone11^[NZL10].Affol     := Zone_d^[nZ].Affol;
    // Emanuela 6/12/2004 Introdotto il calcolo di n in base al DPR 412 art. 8 comma 9
    if SameValue(Zone_d^[nZ].N, 0) then
       zone11^[NZL10].N := Zone_d^[nZ].N
    else
    if SameValue(Impianto_d^[NImp].OreOn, 0) then zone11^[NZL10].N := 0
    else
    begin
      // Emanuela 29/12/2005 Trasformati i valori dei ricambi d'aria da m³/h persona in l/s
      zone11^[NZL10].N := (((Zone_d^[nZ].N * 0.277777) * Impianto_d^[NImp].OreOn) / 24) * 1.1;
    end;
    zone11^[NZL10].Ngo := Zone_d^[nZ].Ngo;
  end;
    zone11^[NZL10].GeneratZona := '';
    zone11^[NZL10].PortLegM    := 0;
    zone11^[NZL10].PotH2o      := 0;
    zone11^[NZL10].AreaPav     := 0;
    zone11^[NZL10].Ap          := 0;
    zone10^[NZL10].UR          := Prog^.UR;
    zone10^[NZL10].ClSerram    := ''; // Non è attivato Calcolo Analitico
    zone10^[NZL10].PortNat  := Zone_D^[nZ].InfInv + Zone_D^[nZ].PortMec;
    zone10^[NZL10].CalcAnal := 'S';

   // Emanuela verifica della compatibilità con la versione 11
   if VerificaVersione <> 11 then
   begin
    Impianto_d^[NImp].VMVolImpOn := Zone_D^[nZ].VMVolImpOn;
    Impianto_d^[NImp].OreOn      := Zone_D^[nZ].OreOn;
    Impianto_d^[NImp].RecsensInv := Zone_D^[nZ].EtaRecup;
   end;
    zone10^[NZL10].VMVolImpOn := Impianto_d^[NImp].VMVolImpOn;
    zone10^[NZL10].OreOn      := Impianto_d^[NImp].OreOn;
    zone10^[NZL10].EtaRecup   := Impianto_d^[NImp].RecsensInv;
    zone10^[NZL10].PortMec    := Zone_D^[nZ].VentMecTratt;
    zone10^[NZL10].TipoPav    := 0;  // Non è attivato Calcolo Analitico Capacità Termica
    zone10^[NZL10].TipoEdif   := ''; // Sostituito con Gestione Differenziata
    zone10^[NZL10].RendTerm   := 0;  // ?
    zone10^[NZL10].PotNom     := 0;  // Non attivato Calcolo Analitico Rend.Distribuzione
    zone10^[NZL10].Perc       := 0;  // Non attivato Calcolo Analitico Rend.Distribuzione
    zone10^[NZL10].TempAT     := 0;  // ?
    zone10^[NZL10].RendReg    := 0;  // ?
end;

{-----------------------------------------------------------------------------
  Procedure: Compila_non_clima
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Procedura che si occupa della compilazione dei dati per il calcolo
           estivo 
-----------------------------------------------------------------------------}
Procedure Compila_non_clima;
var
  i, j: Integer;
  N_r, N_C, N_Risc, Trov: boolean;
begin
 for i:=1 to NAmbienti do
 begin
  Ambienti_D^[i].Indimpianto:=CodiceImpianto(Ambienti_D^[i].Impianto);
  N_Risc := UpperCase(Ambienti_D^[i].CodZona) = 'NON RISC';
  if (ambienti_d^[i].Indimpianto <> 0) and (ambienti_d^[i].Indimpianto <= NImpianti) then
  begin
    N_R:= (ambienti_d^[i].Indimpianto=0)or(Impianto_D^[ambienti_d^[i].Indimpianto].GenInvt = non_risc);
    N_C:= (ambienti_d^[i].Indimpianto=0)or(Impianto_D^[ambienti_d^[i].Indimpianto].Genest  = non_clima);
  end
  else
  begin
    N_R := False;
    N_C := False;
  end;
  if N_Risc then
  begin
    zone_D^[Nzone].ProfiloImpianto    := 0;
    zone_D^[Nzone].ProfiloImpiantoInv := 0;
  end
  else
  begin
    if N_c or N_R then
    begin
      j:=1;
      while (j < NZone)and
      (zone_D^[j].Denom <> 'NC_' + inttostr(ambienti_d^[i].Indimpianto))and
      (N_C and (zone_D^[j].TEst<>ambienti_d^[i].TNEst))and
      (N_R and (zone_D^[j].TInv<>ambienti_d^[i].TNInv)) do inc(j);

      if (zone_D^[j].Denom <> 'NC_' + inttostr(ambienti_d^[i].Indimpianto))or
         (N_C and (zone_D^[j].TEst<>ambienti_d^[i].TNEst))or
         (N_R and (zone_D^[j].TInv<>ambienti_d^[i].TNInv)) then
      begin
      if nzone < MaxZone then
         inc(nzone);
      zone_d^[Nzone] := zone_d^[ambienti_d^[i].Zona];
      zone_D^[Nzone].Denom  := 'NC_'+inttostr(ambienti_d^[i].Indimpianto);
      zone_D^[Nzone].cod    := zone_D^[Nzone].Denom ;
      ambienti_d^[i].Zona   := Nzone;
      ambienti_d^[i].codzona:= zone_D^[Nzone].cod;

      if N_C then
        begin
        zone_D^[Nzone].TEst := ambienti_d^[i].TNEst;
        zone_D^[Nzone].ProfiloImpianto := 0;
        end;
      if N_R then
        begin
        zone_D^[Nzone].TInv := ambienti_d^[i].TNInv;
        zone_D^[Nzone].ProfiloImpiantoInv := 0;
        end;
    end
    else
    begin
      ambienti_d^[i].Zona := j;
      ambienti_d^[i].codzona := zone_D^[j].cod;
    end;
   end;
  end;
 end;

 for i:=1 to nImpianti do
 begin
   if Impianto_D^[i].Genest=non_clima then Impianto_D^[i].EstProfiloVent := '';
   if Impianto_D^[i].Genest=non_risc then  Impianto_D^[i].InvProfiloVent := '';
 end;
end;

{-----------------------------------------------------------------------------
  Procedure: VerificaAggregati
  Author:    e.diquattro
  Date:      27-apr-2006
  Arguments: var Amb: RecAmb; var VolumeAmb: Double
  Result:    None

  Cosa fa: Verifica degli aggregati e delle loro propretà per aggiungerle
           al locale principale
-----------------------------------------------------------------------------}
Procedure VerificaAggregati(var Amb: RecAmb; var VolumeAmb: Real; var VLor: Real);
var
  posI, cod, PosPar, valP: Integer;
  AltLordaP, spess: double;
Begin
  for posI:=1 to NAmbienti do
  begin
   if (Pos('AGGRE-', Ambienti_D^[PosI].Denom) <> 0) then
   begin
    Cod := StrToInt(Copy(Ambienti_d^[PosI].Denom, 7, Length(Ambienti_d^[PosI].Denom) - 6));
    if Cod = StrToInt(Amb.CodNum) then
    begin
      Amb.Superficie := Amb.Superficie + Ambienti_D^[posI].Superficie;
      VolumeAmb := VolumeAmb + (Ambienti_D^[posI].Superficie*Ambienti_D^[posI].Hsoffitto);
      AltLordaP := Ambienti_D^[posI].Hsoffitto + SpessPar(Ambienti_D^[posI].Par[2].Cod);
      if UpperCase(Amb.Piano) = UpperCase(Piani_D^[1].Cod) then
      begin
          // se siamo al primo piano dobbiamo considerare il pavimento
          Spess := SpessPar(Ambienti_D^[posI].Par[1].Cod);    //spessore parete pavimento
          // Al volume lordo del Locale sto aggiungento il volume ricalcolato
          // in base all'altezza lorda data dall'altezza del piano + spessore del pavimento
          VLor:=VLor + Ambienti_D^[posI].Superficie * (AltLordaP + Spess);
       end
       else
       begin
         // se non siamo al secondo piano non considero il pavimento ma sono l'altezza lorda
         VLor:=VLor + Ambienti_D^[posI].Superficie * AltLordaP;
      end;
      for PosPar := 1 to Ambienti_d^[PosI].NPar do
      begin
       if CompareStr(UpperCase(Ambienti_d^[PosI].Par[PosPar].Confine), 'FITT') <> 0 then
       begin
        ValP := 0;
        if EsistePareteAmb(Ambienti_d^[PosI].Par[PosPar].Cod, Ambienti_d^[PosI].Par[PosPar].Confine, Ambienti_d^[PosI].Par[PosPar].Lato, Amb, valP) then
        begin
         if Ambienti_d^[PosI].Par[PosPar + 1].Lato <> '-' then
         begin
          Amb.Par[valP].Sup := Amb.Par[valP].Sup + Ambienti_d^[PosI].Par[PosPar].Sup;
          Amb.Par[valP].Num := Amb.Par[valP].Num + Ambienti_d^[PosI].Par[PosPar].Num;
         end
         else
         begin
            if Amb.NPar < MaxPar then
               inc(Amb.NPar);
            Amb.Par[Amb.NPar] := Ambienti_d^[PosI].Par[PosPar];
         end;
        end
        else
        begin
          if Amb.NPar < MaxPar then
             inc(Amb.NPar);
          Amb.Par[Amb.NPar] := Ambienti_d^[PosI].Par[PosPar];
        end;
       end;
      end;
    end;
   end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: EsistePareteAmb
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: CodPar, Confine, Lato: String; AmbO: RecAmb; var valP: Integer
  Result:    Boolean
  
  Cosa fa: Verifica se esiste la parete nell'ambiente sotto osservazione
-----------------------------------------------------------------------------}
function EsistePareteAmb(CodPar, Confine, Lato: String; AmbO: RecAmb; var valP: Integer): Boolean;
var
  vP: Integer;
begin
  Result := False;
  if Lato <> '-' then
  begin
    for vP := 1 to AmbO.NPar do
    begin
      if (CompareStr(CodPar, AmbO.Par[VP].Cod) = 0) and (Confine = AmbO.Par[VP].Confine)
         and (Lato = AmbO.Par[VP].Lato)
      then
      begin
         Result := true;
         ValP := vP;
         exit;
      end;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: RipulisciAmbienteTemporaneo
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: var Amb: RecAmb
  Result:    None
  
  Cosa fa: Ripulisce i campi dell'ambiente temporaneo
-----------------------------------------------------------------------------}
procedure RipulisciAmbienteTemporaneo(var Amb: RecAmb);
var
  nP: Integer;
begin
  for nP := 1 to MaxPar do
  begin
    Amb.Par[np].Confine := '';
    Amb.Par[np].Lato    := '';
    Amb.Par[np].Tipo    := '';
    Amb.Par[np].Cod     := '';
    Amb.Par[np].Num     := 0;
    Amb.Par[np].Alt     := 0;
    Amb.Par[np].Sup     := 0;
    Amb.Par[np].Item    := 0;
    Amb.Par[np].Alt2    := 0;
  end;
  Amb.NPar             := 0;
  Amb.Num              := 0;
  Amb.CodNum           := '';
  Amb.CodZona          := '';
  Amb.Denom            := '';
  Amb.Piano            := '';
  Amb.Superficie       := 0;
  Amb.HSoffitto        := 0;
  Amb.Impianto         := '';
  Amb.InfInv           := 0;
  Amb.CodPROccupaz     := '';
  Amb.NPersone         := 0;
  Amb.RicambioPersona  := 0;
  Amb.SensibilePersona := 0;
  Amb.LatentePersona   := 0;
  Amb.CodPRApparecch   := '';
  Amb.IlluminazFissa   := 0;
  Amb.InfEst           := 0;
  Amb.TNEst            := 0;
  Amb.TNInv            := 0;
  Amb.Ventilazione     := 0;
  Amb.V                := '';
  Amb.T_Pav            := '';
  Amb.C_Pav            := '';
  Amb.T_Soff           := '';
  Amb.C_Soff           := '';
  Amb.x1               := 0;
  Amb.Y1               := 0;
  Amb.Indimpianto      := 0;
  Amb.Z10              := 0;
  Amb.Numimpianto      := 0;
  Amb.ProfiloIlluminaz := 0;
  Amb.ProfiloApparecch := 0;
  Amb.ProfiloOccupaz   := 0;
  Amb.IlluminazVar     := 0;
  Amb.TipoIlluminaz    := 0;
  Amb.RappRS           := 0;
  Amb.CircolazAria     := 0;
  Amb.inf_risc         := 0;
  Amb.alfaSerra        := 0;
  Amb.alloggio         := 0;
  Amb.PotenzaWatt      := 0;
  Amb.Zona             := 0;
  Amb.AmbientiUguali   := 0;
end;

{-----------------------------------------------------------------------------
  Procedure: SpessPar
  Author:    e.diquattro
  Date:      05-apr-2006
  Arguments: codPar: String
  Result:    real

  Cosa fa: calcola la somma degli spessori degli strati di una parete
-----------------------------------------------------------------------------}
function SpessPar(codPar: String): real;
var
  i: Integer;
begin
  i := 1;
  Result := 0;
  CodPar := UpperCase(CodPar);
  while (i < NStrutture) and (UpperCase(Strutture_D[i].NFile ) <> CodPar) do
    inc(i);
  if (UpperCase(Strutture_D[i].NFile) = CodPar) then
  begin
     Result := Strutture_D[i].SpessoreParete / 100;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CalcolaVolumeSpessori
  Author:    e.diquattro
  Date:      05-apr-2006
  Arguments: AmbTemp: RecAmb; AltLordaP: Real; var VLordo: Real
  Result:    None

  Cosa fa: Calcola il volume degli spigoli dell'incrocio delle pareti
-----------------------------------------------------------------------------}
procedure CalcolaVolumeSpessori(AmbTemp: RecAmb; AltLordaP: Real; var VLordo: real);
var
 j, i, m: Integer;
 Trovato: Boolean;
begin
  For j:=3 to AmbTemp.Npar do
  begin
   //il controllare che il lato sia <> '-' serve a non considerare ponti o finestre
   if (AmbTemp.Par[j].Lato[1] <> '-') and (CompareStr(UpperCase(AmbTemp.Par[j].Confine), 'FITT') <> 0) then
   begin
     m := j + 1;
     Trovato := False;
     while (m <= AmbTemp.Npar) and (not Trovato) do
     begin
      if AmbTemp.Par[m].Lato[1] <> '-' then
      begin
        if AmbTemp.Par[m].Lato[1] <> AmbTemp.Par[j].Lato then
        begin
          Vlordo := VLordo + SpessPar(AmbTemp.Par[m].Cod) * SpessPar(AmbTemp.Par[j].Cod) * AltLordaP;
          Trovato := True;
        end;
      end;
      inc(m);
     end;
   end;
  end;

  if AmbTemp.Npar <> 0 then
  begin
   m := AmbTemp.Npar;
   Trovato := False;
   while (m > 1) and (not Trovato) do
   begin
    if AmbTemp.Par[m].Lato[1] <> '-' then
    begin
      Vlordo := VLordo + SpessPar(AmbTemp.Par[3].Cod) * SpessPar(AmbTemp.Par[m].Cod) * AltLordaP;
      Trovato := True;
    end;
    dec(m);
   end;
  end
  else
   if AmbTemp.Par[3].Lato[1] <> '-' then
      Vlordo := VLordo + SpessPar(AmbTemp.Par[3].Cod) * AltLordaP;

  // spessore pavimento con le pareti per il primo piano
  if UpperCase(AmbTemp.Piano) = UpperCase(Piani_D^[1].Cod) then
  begin
    For j:=3 to AmbTemp.Npar do
    begin
     if (AmbTemp.Par[j].Lato[1] <> '-') and (CompareStr(UpperCase(AmbTemp.Par[j].Confine), 'FITT') <> 0)then
     begin
       m := j + 1;
       Trovato := False;
       while (m <= AmbTemp.Npar) and (not Trovato) do
       begin
        if AmbTemp.Par[m].Lato[1] <> '-' then
        begin
          if AmbTemp.Par[m].Lato[1] <> AmbTemp.Par[j].Lato then
          begin
            Vlordo := VLordo + SpessPar(AmbTemp.Par[m].Cod) * SpessPar(AmbTemp.Par[j].Cod) * SpessPar(AmbTemp.Par[2].Cod);
            Trovato := True;
          end;
        end;
        inc(m);
       end;
     end;
    end;

    if AmbTemp.Npar <> 0 then
    begin
      m := AmbTemp.Npar;
      Trovato := False;
      while (m > 1) and (not Trovato) do
      begin
       if AmbTemp.Par[m].Lato[1] <> '-' then
       begin
         Vlordo := VLordo + SpessPar(AmbTemp.Par[3].Cod) * SpessPar(AmbTemp.Par[m].Cod) * SpessPar(AmbTemp.Par[2].Cod);
         Trovato := True;
       end;
       dec(m);
      end;
    end
    else
     if AmbTemp.Par[3].Lato[1] <> '-' then
        Vlordo := VLordo + SpessPar(AmbTemp.Par[3].Cod) * SpessPar(AmbTemp.Par[2].Cod);
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CompilaMuri
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Procedura che carica i muri dell'edificio
-----------------------------------------------------------------------------}
Procedure CompilaMuri;
var
  j, i: Integer;
begin
  j := 0;
  for i := 1 to Nstrutture do
  begin
   with Strutture_D[i]^ do
   begin
    inc(j);
    Muri_D^[j].Colore  := 'M';
    Muri_D^[j].IncrSic := 1;
    Muri_D^[j].CodArch := i;
   end;
  end;
  NMuri:=NFrontiere;
end;

Procedure CompilaConfini;
var
  i, j: Integer;
begin
  i := 0;
  for j := 1 to NConfini do
  begin
   with Confine_D^[j] do
   begin
    inc(i);
   { TODO -oFabio -cDafare : Esposizione con ostacoli da completare Fabio}
    Esposizioni_D^[i].Codice := Codice;
    Esposizioni_D^[i].Denom  := Denom;
    //Esposizioni_D^[i].Tipo:='I'; // Copiare tipo quindi modificare in := Tipo
    // Emanuela 28/12/2004 inserito il tipo del confine in base al confine scelto
    if CompareStr(UpperCase(TipoConfine), UpperCase('INTERNO')) = 0 then
       Esposizioni_D^[i].Tipo := 'I'
    else if CompareStr(UpperCase(TipoConfine), UpperCase('ESTERNO')) = 0 then
            Esposizioni_D^[i].Tipo := 'E'
         else if CompareStr(UpperCase(TipoConfine), UpperCase('TERRENO')) = 0 then
                 Esposizioni_D^[i].Tipo := 'T'
              else if CompareStr(UpperCase(TipoConfine), UpperCase('PARETE INCLINATA')) = 0 then
                      Esposizioni_D^[i].Tipo := 'P';

    //------------------------------------------------------
    // aggiungere il campo Orient per ostacoli su base.dat ?
    // il campo già esiste bisogna solo attivarlo sotto ?
    //------------------------------------------------------

    Esposizioni_D^[i].Orient  := 0;
    Esposizioni_D^[i].Inclin  := 0;
    Esposizioni_D^[i].TrifEst := TrifEst;
    Esposizioni_D^[i].TrifInv := TrifInv;
    Esposizioni_D^[i].IncrSic := IncrSic;
    Esposizioni_D^[i].CodPav  := '';
    Esposizioni_D^[i].CodOst  := '';
   end;
  end;
  NEsposizioni := NConfini;
end;

{-----------------------------------------------------------------------------
  Procedure: NuovaFront
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: CodiceAmb: Integer
  Result:    integer
  
  Cosa fa: Crea una nuova frontiera
-----------------------------------------------------------------------------}
Function NuovaFront(CodiceAmb: Integer):integer;
begin
  if NFrontiere < MaxFrontiere then
  begin
    Inc(Nfrontiere);
  end
  else
  begin
   MessageDLG('Non è possibile allocare altre frontiere, spazio insufficiente', mtInformation, [mbOK], 0);
  end;
    if frontiere_d^[Nfrontiere] = nil then
       new(frontiere_d^[Nfrontiere]);
    Frontiere_D^[Nfrontiere]^.CodNum := NFrontiere;
    // Emanuela 28/7/2004: errore veramente grave assegnare al codice ambiente l'indice di
    // scorrimento del for, e senza assegnare quello correttamente dell'ambiente
    Frontiere_D^[Nfrontiere]^.CodAmb      := CodiceAmb;
    Frontiere_D^[Nfrontiere]^.LungMuro    := 0;
    Frontiere_D^[Nfrontiere]^.SupMuro     := 0;
    Frontiere_D^[Nfrontiere]^.CodMuro2    := 0;
    Frontiere_D^[Nfrontiere]^.SupMuro2    := 0;
    Frontiere_D^[Nfrontiere]^.CodFinestra := 0;
    Frontiere_D^[Nfrontiere]^.ModFinestra := 0;
    Frontiere_D^[Nfrontiere]^.SupFinestra := 0;
    Frontiere_D^[Nfrontiere]^.CodPorta    := 0;
    Frontiere_D^[Nfrontiere]^.ModPorta    := 0;
    Frontiere_D^[Nfrontiere]^.SupPorta    := 0;
    result := Nfrontiere;
end;


{-----------------------------------------------------------------------------
  Procedure: NuovaFrontLin
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: CodiceAmb: Integer
  Result:    integer
  
  Cosa fa: Crea le frontiere corrispondenti ai ponti termici
-----------------------------------------------------------------------------}
Function NuovaFrontLin(CodiceAmb: Integer):integer;
begin
  if NFrontiereLin < MaxFrontiereLin then
  begin
    Inc(NFrontiereLin);
  end
  else
  begin
    MessageDLG('Non è possibile allocare altre frontiereLin, spazio insufficiente', mtInformation, [mbOK], 0);
  end;

    if FrontiereLin_d^[NFrontiereLin] = nil then
       new(FrontiereLin_d^[NFrontiereLin]);
    // Emanuela 28/7/2004: errore veramente grave assegnare al codice ambiente l'indice di
    // scorrimento del for, e senza assegnare quello correttamente dell'ambiente
    FrontiereLin_D^[NFrontiereLin]^.CodNum    := NFrontiereLin;
    FrontiereLin_D^[NFrontiereLin]^.CodAmb    := CodiceAmb;
    FrontiereLin_D^[NFrontiereLin]^.CodEsp    := 0;
    FrontiereLin_D^[NFrontiereLin]^.CodPonte1 := 0;
    FrontiereLin_D^[NFrontiereLin]^.LUNG1     := 0;
    FrontiereLin_D^[NFrontiereLin]^.CodPonte2 := 0;
    FrontiereLin_D^[NFrontiereLin]^.LUNG2     := 0;
    FrontiereLin_D^[NFrontiereLin]^.Kappa     := 0;
    result:=NfrontiereLin;
end;

{-----------------------------------------------------------------------------
  Procedure: CalcSupNetta
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: Amb: recAmb; parete: integer
  Result:    real
  
  Cosa fa: Calcola la superficie netta di un ambiente
-----------------------------------------------------------------------------}
Function CalcSupNetta(Amb: recAmb; parete: integer): Real;
begin
  Result := amb.Par[parete].Sup;
  with amb do
    if parete < Npar then
      if Par[parete+1].Lato = '-' then
      begin
        inc(parete);
        while (Parete <= NPar) and (Par[parete].Lato = '-') do
        begin
          Result := result - Par[parete].Sup;
          inc(parete);
        end;
      end;
end;

{-----------------------------------------------------------------------------
  Procedure: CompilaFront
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Calcola le disporsioni di ogni alloggio
-----------------------------------------------------------------------------}
Procedure CompilaFront;
Var
  i, j, CodiceParAn, IndImp, EsposizCorr: Integer;
  suptot, totdisp, totdispAmb, totdispriga, IncrInt: Real;
  BufIntPOt: TintPOt;
  FIntPOt: File of Tintpot;
  DispInf, AppVent, ventinf, Pot_Ventilazione, Tot_Ventilazione: Real;
  TotApp_Vent, VolNetto, Dtcorr, IncrCorr: Real;
  TotDispNetto, SpessTemp: Real;
  CalcoloVerificato: string;
  VolInterno, SupLordaPar, AltLordaP, AltNettaP: Real;
  AmbTemp: RecAmb;
  EsisteGen: Boolean;
  Supnetta, VE: Real;
begin
  Erroregen:=false;
  CompilaConfini;
  CopiaProfilo;
  {$Ifdef L10}
  Init_ris;
  SLorda := 0;
  VLordo := 0;
  SUtilP := 0;
  EsisteGen := False;
  {$Endif}
  Tot_Ventilazione := 0;
  TotApp_Vent := 0;
  VolNetto := 0;
  VE := 0;
  TotDisp:=0;
  TotDispNetto:=0;
  NFrontiere:=0;
  NFrontiereLin:=0;

  // ---------------------------------------
  //     Inizio Stampe Tabella DISPAMB
  // Dispersioni.rep - Relazione Dispersioni
  // ---------------------------------------

  Inizio_compart('DISPAMB');
  for i := 1 to Nambienti do
  begin
   if (CompareStr(UpperCase(Ambienti_D^[i].CodZona), 'NON RISC') <> 0) and (Pos('AGGRE-', Ambienti_D^[i].Denom) = 0)
   then
   begin
   {$IF (Defined(VERSIONE_12) or Defined(VERSIONE_13)) and Defined(L10)}
    indImp := CodiceImpianto(Ambienti_D^[i].Impianto);
    if IndImp <> 0 then
    begin
      if CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[indImp].GenInvt)) = 0
      then
      begin
   {$IFEND}
       RipulisciAmbienteTemporaneo(AmbTemp);
       AmbTemp := Ambienti_D^[i]^;
       VolInterno := AmbTemp.Superficie * AmbTemp.Hsoffitto;
      {$IFDEF L10}
       if AmbTemp.HSoffitto = 0 then
          AltNettaP := AltLordaPiano(AmbTemp.Piano, 'N')
       else AltNettaP := AmbTemp.HSoffitto;
       AltLordaP := AltNettaP + SpessPar(AmbTemp.Par[2].Cod);
       if UpperCase(AmbTemp.Piano) = UpperCase(Piani_D^[1].Cod) then
       begin
          // se siamo al primo piano dobbiamo considerare il pavimento
          SpessTemp := SpessPar(AmbTemp.Par[1].Cod);    //spessore parete pavimento
          // Al volume lordo del Locale sto aggiungento il volume ricalcolato
          // in base all'altezza lorda data dall'altezza del piano + spessore del pavimento
          VLordo := VLordo + AmbTemp.Superficie * (AltLordaP + SpessTemp);
       end
       else
       begin
         // se non siamo al secondo piano non considero il pavimento ma sono l'altezza lorda
         VLordo:=VLordo + AmbTemp.Superficie * AltLordaP;
       end;
       VerificaAggregati(AmbTemp, VolInterno, VLordo);
       // Calcolo degli spigoli che si ottengono dall'incrocio delle pareti
       CalcolaVolumeSpessori(AmbTemp, AltLordaP, VLordo);
       if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
       begin
          //Emanuela DPR 192: sommo la superficie del pavimento del locale
          //SUtilP := SutilP + AmbTemp.Par[1].Sup;
          SUtilP := SutilP + AmbTemp.Superficie;
       end;
      {$ENDIF}
      {$IFDEF ESTIVO}
       VerificaAggregati(AmbTemp, VolInterno, VE);
      {$ENDIF}
       W_Reale('SUPAMB', AmbTemp.Superficie, 1);
       W_Reale('VOLAMB', VolInterno, 1);
      {$IFDEF L10}
       EsisteGen := True;
       AmbTemp.ProfiloIlluminaz := 1;
       AmbTemp.ProfiloApparecch := 1;
       AmbTemp.ProfiloOccupaz   := 1;
      {$ELSE}
       AmbTemp.ProfiloIlluminaz := Codiceprofilo(AmbTemp.CodPRIlluminaz);
       AmbTemp.ProfiloApparecch := Codiceprofilo(AmbTemp.CodPRApparecch);
       AmbTemp.ProfiloOccupaz   := Codiceprofilo(AmbTemp.CodPROccupaz);
      {$ENDIF}
       AmbTemp.zona             := CodiceZona(AmbTemp.codzona);
       AmbTemp.NumImpianto      := CodiceImpianto(AmbTemp.Impianto);
       totdispAmb:=0;
      {$IFDEF ESTIVO}
        Wrep_str('CODAMB',  AmbTemp.CodNum);
      {$ENDIF}
       Wrep_str('NOMEAMB', AmbTemp.denom);
       Wrep_str('CODZONA', AmbTemp.CodZona);
       Wrep_str('PIANOLOC', AmbTemp.Piano);

       // elabirazione della tabella TabdispAmb
       InizioTabella('TABDISPAMB',10);
       For j:=1 to AmbTemp.Npar do
       begin
         SupLordaPar := AmbTemp.Par[j].sup;
         // Verifico se ho a che fare con una parete
         if AmbTemp.Par[j].lato <> '-' then
         begin
          {$IFDEF L10}
            CalcolaVolumeLordo(AmbTemp, VLordo, SupLordaPar, AltNettaP, AltLordaP, j);
          {$ENDIF}
          if ((uppercase(AmbTemp.Par[j].confine)<>'NON SC') and (uppercase(AmbTemp.Par[j].confine)<>'INTERNO')) or
             ((Comparestr(UpperCase(AmbTemp.Piano), UpperCase(Piani_D^[1].Cod)) = 0) and  (AmbTemp.Par[j].Lato = 'OR')) or
             ((Comparestr(UpperCase(AmbTemp.Piano), UpperCase(Piani_D^[NPiani].Cod)) = 0) and  (AmbTemp.Par[j].Lato = 'OR'))
          then
          begin
              CodiceParAn := codicepar(AmbTemp.Par[j].cod);
              IncrCorr := 1;
              if CodiceParAn <> 0 then
              begin
                // Caso Pareti Esterne
                if ((AmbTemp.Par[j].Lato[1] <> 'L') or ((AmbTemp.Par[j].Lato[1] = 'L') and (CompareStr(UpperCase(AmbTemp.Par[j].Confine), 'DIVISORI') <> 0)))
                    and (uppercase(AmbTemp.Par[j].confine)<>'NON SC') then // Esposizione tra locali
                begin
                 {$IFDEF L10}
                 CalcoloSuperficieLordaParete(AmbTemp, SupLordaPar, AltNettaP, AltLordaP, j);
                 SLorda := SLorda + SupLordaPar;
                {$ENDIF}
                 Supnetta:=calcSupNetta(AmbTemp, j);
                 CaricaRigaParete(AmbTemp, CodiceParAn, j, SupNetta, SupLordaPar, TotdispAmb, DTCorr, IncrCorr, SupTot, EsposizCorr);
                end;
                // Caso divisori che confinano con alloggi differenti per cui c'è una temperatura differente
                // o confine interno
               {$IFDEF L10}
                if ((AmbTemp.Par[j].Lato[1] = 'L') and (CompareStr(UpperCase(AmbTemp.Par[j].Confine), 'DIVISORI') = 0)) then
                begin
                  // se il divisorio e tra alloggia a temperatura differente ed è settato il calcolo vicino assente
                  if VicAss and
                     (CompareStr(UpperCase(Strutture_D^[CodiceParAn].SeparaAlloggi), 'DIVISORIO SEPARAZIONE TRA ALLOGGI') = 0)
                  then
                  begin
                    {$IFDEF L10}
                     CalcoloSuperficieLordaParete(AmbTemp, SupLordaPar, AltNettaP, AltLordaP, j);
                     SLorda := SLorda + SupLordaPar;
                    {$ENDIF}
                     Supnetta:=calcSupNetta(AmbTemp, j);
                     CaricaRigaParete(AmbTemp, CodiceParAn, j, SupNetta, SupLordaPar, TotdispAmb, DTCorr, IncrCorr, SupTot, EsposizCorr);
                  end; {Se calcolo con Vicino Assente}
                end;
               {$ENDIF}
             end
             Else
              if AmbTemp.Par[j].cod = '' then
               Echo('Per l''ambiente ' + AmbTemp.Denom + ' del piano ' + AmbTemp.Piano + ' esistono pareti prive di tipologia');
           end;  {Condizione che considera solo la superficie delle pareti esterne}
         end
         else
         begin
           // Verifico se ho a che fare con un ponte termico
           if AmbTemp.Par[j].tipo = TPonte then
           begin
             CaricaRigaPonte(AmbTemp, j, EsposizCorr, DTCorr, IncrCorr, TotdispAmb);
           end
           else
           if AmbTemp.Par[j].tipo = Tfin then
           begin
            // Verifico se ho a che fare con una finestra
            CaricaRigaFinestra(AmbTemp, CodiceParAN, j, EsposizCorr, SupTot, DTCorr, TotdispAmb);
           end;
         end; {end if lato <> '-'}
       end;{end for che scorre le pareti finestre e ponti termici dell'ambiente}
       FineTabella;
       // fine elaborazione della tabella TabdispAmb

       with AmbTemp do
       begin
        // ----------------------------------------------------
        // Inizio Stampe relative alla relazione di Dispersioni
        // ----------------------------------------------------
        // Calcolo della portata d'aria
        portAria := Ricambio_ariamch(0, NPersone*RicambioPersona, Ventilazione*Superficie*HSoffitto, 0, 0);
        // Calcolo delle dispersioni per infiltrazioni d'aria
        if zona <> 0 then
           DispInf := -Pot_sensAria(zone_d^[zona].TInv,Prog.TEst, InfInv*Superficie*HSoffitto, 0)
        else DispInf := 0;
        {$IFDEF L10}
        AddStatistica('Infiltrazioni', dispinf);
        {$ENDIF}
        // Calcolo degli apporti dovuti alla ventilazione meccanica
        if (zona <> 0) and (NumImpianto <> 0) then
           Appvent := -Pot_sensAria(zone_d^[zona].TInv, Impianto_d^[NumImpianto].TimmInv,PortAria,0)
        else Appvent := 0;
        // Calcolo della potenza dovuta alla ventilazione
        if NumImpianto <> 0 then
           Pot_Ventilazione := Pot_sensAria(Prog.TEst,Impianto_d^[NumImpianto].TimmInv,PortAria,0)
        else Pot_Ventilazione := 0;
        VolNetto := VolNetto + Superficie * HSoffitto;
        // Pre Stampe Ventilazione di aria - Fabio 27 Apr 2oo4
        W_Reale('INFILTRAZIONI', InfInv, 2);
        W_Reale('RICAMB_PERSONA', RicambioPersona, 2);
        Wrep_int('NUM_PERSONE', NPersone);
        W_Reale('RIC_VOLUME', Ventilazione, 2);
        W_Reale('TEMP_IMM_ARIA', Impianto_d^[NumImpianto].TImmInv, 1);
        // Stampe Ventilazione di aria - Fabio 27 Apr 2oo4
        if NPersone <> 0 then
           W_Reale('PORT_VENT_A0', portAria/NPersone/3.6, 2);
        if (Superficie*HSoffitto) <> 0 then
           W_Reale('PORT_VENT_A1', portAria/(Superficie*HSoffitto), 2);
        W_Reale('PORT_VENT_A2', PortAria, 1);
        if (zona <> 0) and (NumImpianto <> 0) then
            W_Reale('DT_VENT', zone_d^[zona].TInv-Impianto_d^[NumImpianto].TimmInv, 2)
        else  W_Reale('DT_VENT', 0, 2);
        If CompareStr(FloatToStr(AppVent), '0') = 0 Then
           AppVent := Abs(AppVent);
        W_Reale('APP_VENT', AppVent, 0);
        // Stampe Infiltrazione di aria - Fabio 27 Apr 2oo4
        W_Reale('PORT_INF_A1', InfInv, 2);
        W_Reale('PORT_INF_A2', InfInv*Superficie*HSoffitto, 2);
        if zona <> 0 then
           W_Reale('DT_INF', zone_d^[zona].TInv-Prog^.TEst, 2)
        else W_Reale('DT_INF', 0, 2);
        W_Reale('DISP_INF', DispInf, 0);
       end; {End With AmbTemp}

       TotDispNetto := TotDispNetto + TotDispAmb;
       W_Reale('DISPAMB',TotDispAmb,0);
       Totdispamb := TotDispAmb +  DispInf ;
       IncrInt := (TotDispAmb * zone_d^[AmbTemp.zona].IncrIntV) /100;
       if IncrInt <> 0 then
          TotDispAmb := TotDispAmb + IncrInt;
       W_Reale('INCR_ZT',zone_d^[AmbTemp.zona].IncrIntV,0);
       W_Reale('POT_INCR_ZT', IncrInt,0);
       W_Reale('TOT_DISP_AMB',TotDispAmb+AppVent,0);
       TotApp_Vent := TotApp_Vent + AppVent;
      {$IFDEF L10}
       RicercaLocaleIntPot(StrToInt(AmbTemp.codnum), AmbTemp, TotDispAmb, VolInterno, DispInf, DescGen1^[gencor].Cod);
      {$ENDIF}
       TotDisp := TotDisp + TotDispAmb;
       Tot_Ventilazione := Tot_Ventilazione + Pot_Ventilazione;
       Fine_gruppo;
    {$IF (Defined(VERSIONE_12) or Defined(VERSIONE_13)) and Defined(L10)}
     end; {Vefifica se l'ambiente appartiene allo stesso generatore}
    end; {Verifica se l'impianto è nessuno}
    {$IFEND}
   end;{end gestione generale degli ambienti}
  end; {End del For che termina lo scorrimento degli ambienti}
  Fine_Compart;

  W_Reale('DISPTOT',TotDisp,0);
  if VolNetto <> 0 then
     W_Reale('DISP_VOL',Totdisp/VolNetto,2);
  W_Reale('DISPTOTNETTO',TotDispNetto,0);
  W_Reale('VENTTOT',Tot_Ventilazione,0);
  {$IFDEF L10}
  AddStatistica('Ventilazione',AppVent);
  {$ENDIF}
  TotDisp := TotDisp + Tot_Ventilazione + TotApp_Vent;
  W_Reale('TOTALE_GENERALE',Totdisp,0);
  CompilaMuri;

  {$Ifdef L10}
   if EsisteGen then
   begin
    with DescGen1^[gencor] do
    begin
     {$IFDEF VERSIONE_11}
      if Prog^.SuperficieLorda > 0 then Slorda := Prog^.SuperficieLorda;
      if Prog^.VolumeLordo > 0 then Vlordo := Prog^.VolumeLordo;
     {$ENDIF}
       
      DispCDInf:=TotDisp - Tot_Ventilazione - TotApp_Vent;
      if VolNetto <> 0 then
      begin
        DispCDVol:=DispCDInf/VolNetto
      end
      else DispCDVol := 0;

      // ----------------------------------------------------------
      // Emanuela + Fabio 12 o7 2oo4
      // Correzione  del valore delle disp in modo da tenere conto
      // quelle prive di infiltrazioni (Dispersioni x Trasmissione)
      // per il calcolo del CD di progetto come da Norma UNI 7357
      // Appendice E.
      // ----------------------------------------------------------
      //  dispers:=totdisp;

      dispers := TotDispNetto;
      VolLord := Vlordo;
      SupLord := SLorda;
      if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
      begin
        //Emanuela DPR 192: conservo la superficie del pavimento dell'alloggio o dell'edificio
        SupUtileR := SUtilP;
      end;

      if Vlordo<>0 then SV := SLorda/Vlordo
      else SV := 0;

      CdLeg := CalcolaCdFen;
      CdFEN := CalcolaCdFen;

      if (volLord*dt) <> 0 then cdadot:=dispers/(volLord*dt);
      Wrep_Str('GENERATORE',Descrizione);
    end;  {end with descgen}
    Descgen^ := Descgen1^[gencor];
   end
   else
   begin
     ErroreGen := True;
     echo('IL GENERATORE SELEZIONATO NON E'' ASSOCIATO A NESSUN IMPIANTO');
   end;
  {$Else}
    If FMainEstivo.CBContinuo.Checked then
    begin
      for i:=1 to Nzone do Zone_d^[i].ProfiloImpianto:=Nprofili;
    end;{end dell if cbcontinuo.checked}
  {$Endif}
end; {fine della Funzione compilaFront}

{-----------------------------------------------------------------------------
  Procedure: CalcolaVolumeLordo
  Author:    e.diquattro
  Date:      21-nov-2006
  Arguments: Amb: RecAmb; var VL, SpL: Real; AlTN, AltL: real; indPar: Integer
  Result:    None
  
  Cosa fa: Calcola il colume lordo della parete
-----------------------------------------------------------------------------}
procedure CalcolaVolumeLordo(Amb: RecAmb; var VL, SpL: Real; AlTN, AltL: real; indPar: Integer);
var
  SpessTemp: real;
begin
   if (Amb.Par[indPar].Lato[1] <> '-') then
   begin
    if (indPar <> 1) and (indPar <> 2) then
    begin
      if (Amb.Par[indPar].Alt = Amb.Par[indPar].Alt2) and (Amb.Par[indPar].alt = AltN) then
       if Comparestr(UpperCase(Amb.Piano), UpperCase(Piani_D^[1].Cod)) = 0 then
       begin
          SpessTemp := SpessPar(Amb.Par[2].Cod);
          if Amb.Par[indPar].Alt <> 0 then
             SpL := (Amb.Par[indPar].Sup / Amb.Par[indPar].Alt) * (AltL + SpessTemp);
       end
       else
         if Amb.Par[indPar].Alt <> 0 then
            SpL := (Amb.Par[indPar].Sup / Amb.Par[indPar].Alt) * AltL;

      SpessTemp := SpessPar(Amb.Par[indPar].Cod);
      if (Amb.Par[indPar].Lato[1]='L') then
         Vl := Vl + (spL * SpessTemp/2)
      else
         Vl := Vl + (spL * SpessTemp);
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CalcoloSuperficieLordaParete
  Author:    e.diquattro
  Date:      21-nov-2006
  Arguments: var Amb: recAmb; var SLP: Real; ; AN, AL: Real; indP: Integer
  Result:    None
  
  Cosa fa: calcola la superficie lorda della parete
-----------------------------------------------------------------------------}
procedure CalcoloSuperficieLordaParete(var Amb: recAmb; var SLP: Real; AN, AL: Real; indP: Integer);
var
  Nt, NP: Integer;
  Trov: Boolean;
  Angolo, Altezza: Real;
begin
 // riga parete
 if CompareStr(UpperCase(Amb.Par[indP].Confine), 'DIVISORI') <> 0 then
 begin
   if Amb.Par[indP].Lato <> 'OR' then
   begin
     // Caso pareti normali
     // sommando le superfici dei lati degli angoli con le altre pareti
     if Comparestr(UpperCase(Amb.Piano), UpperCase(Piani_D^[1].Cod)) = 0 then
     begin
        if indP = 3 then Nt := Amb.Npar
        else Nt := indP - 1;
        trov := False;
        while (Nt > 1) and (not trov) and (Nt <> indP) do
        begin
         if (Amb.Par[Nt].Lato[1] <> '-') and (Amb.Par[nt].Lato <> 'OR')
         then
         begin
          if (Comparestr(UpperCase(Amb.Par[nt].Confine), 'DIVISORI') <> 0) then
             SLP := SLP + (SpessPar(Amb.Par[Nt].Cod) * (AL + SpessPar(Amb.Par[1].Cod)));
          Trov := true;
         end;
         dec(Nt);
        end;
        if (indP = Amb.Npar) or ((indP = Amb.Npar - 1) and (Amb.Par[Amb.Npar].Lato[1] = '-'))
        then Nt := 3
        else Nt := indP + 1;
        trov := False;
        while (Nt <= Amb.NPar) and (not trov) and (Nt <> indP) do
        begin
         if (Amb.Par[Nt].Lato[1] <> '-') and (Amb.Par[nt].Lato <> 'OR')
         then
         begin
          if (Comparestr(UpperCase(Amb.Par[nt].Confine), 'DIVISORI') <> 0) then
              SLP := SLP + (SpessPar(Amb.Par[Nt].Cod) * (AL + SpessPar(Amb.Par[1].Cod)));
          Trov := true;
         end;
         inc(Nt);
        end;
     end
     else
     begin
        if indP = 3 then Nt := Amb.Npar
        else Nt := indP - 1;
        trov := False;
        while (nt > 1) and (not trov) do
        begin
         if (Amb.Par[Nt].Lato[1] <> '-') and (Amb.Par[nt].Lato <> 'OR')
         then
         begin
          if (Comparestr(UpperCase(Amb.Par[nt].Confine), 'DIVISORI') <> 0) then
            SLP := SLP + (SpessPar(Amb.Par[nt].Cod) * AL);
          trov := true;
         end;
         dec(Nt);
        end;
        if (indP = Amb.Npar) or ((indP = Amb.Npar - 1) and (Amb.Par[Amb.Npar].Lato[1] = '-'))
        then Nt := 3
        else Nt := indP + 1;
        trov := False;
        while (Nt <= Amb.NPar) and (not trov) and (Nt <> indP) do
        begin
         if (Amb.Par[Nt].Lato[1] <> '-') and (Amb.Par[nt].Lato <> 'OR')
         then
         begin
          if (Comparestr(UpperCase(Amb.Par[nt].Confine), 'DIVISORI') <> 0) then
              SLP := SLP + (SpessPar(Amb.Par[nt].Cod) * AL);
          Trov := true;
         end;
         inc(Nt);
        end;
     end;
   end
   else
   begin
      // caso pavimenti o soffitti
      // Teniamo conto dell'angolo di inclinazione delle falde
      if indP = 2 then
      begin
        Angolo := RestituisciAngoloFalda(Amb.Par[indP].Confine)
      end
      else Angolo := 0;
      // superfice spessori
      For np := 3 to Amb.Npar do
      begin
        Nt := np + 1;
        trov := False;
        while (nt <= Amb.Npar) and (not trov) do
        begin
         if (Amb.Par[nt].Lato[1] <> '-') and (CompareStr(UpperCase(Amb.Par[nt].Confine), 'FITT') <> 0) and (CompareStr(UpperCase(Amb.Par[nt].Confine), 'DIVISORI') <> 0)
            and (CompareStr(UpperCase(Amb.Par[np].Confine), 'DIVISORI') <> 0) and (CompareStr(UpperCase(Amb.Par[np].Lato[1]), '-') <> 0)
         then
         begin
            SLP := SLP + ((SpessPar(Amb.Par[nt].Cod) * SpessPar(Amb.Par[np].Cod)) / cos(Angolo));
            trov := True
         end;
         inc(nt);
        end;
      end;
      Nt := Amb.Npar;
      trov := False;
      while (nt > 1) and (not trov) do
      begin
       if (CompareStr(UpperCase(Amb.Par[nt].Confine), 'DIVISORI') = 0) then
         Trov := true
       else
       begin
         if (Amb.Par[nt].Lato[1] <> '-') and (CompareStr(UpperCase(Amb.Par[nt].Confine), 'FITT') <> 0) and (CompareStr(UpperCase(Amb.Par[nt].Confine), 'DIVISORI') <> 0)
            and (CompareStr(UpperCase(Amb.Par[3].Confine), 'DIVISORI') <> 0) and (CompareStr(UpperCase(Amb.Par[3].Lato[1]), '-') <> 0)
         then
         begin
          if (((Amb.Par[3].Lato[1] = 'N') or (Amb.Par[3].Lato[1] = 'S')) and
              ((Amb.Par[nt].Lato[1] = 'E') or (Amb.Par[nt].Lato[1] = 'O'))) or
             (((Amb.Par[3].Lato[1] = 'E') or (Amb.Par[3].Lato[1] = 'O')) and
              ((Amb.Par[nt].Lato[1] = 'N') or (Amb.Par[nt].Lato[1] = 'S')))
          then
          begin
            SLP := SLP + ((SpessPar(Amb.Par[3].Cod) * SpessPar(Amb.Par[nt].Cod)) / cos(Angolo));
            trov := True;
          end;
         end;
       end;
       dec(nt);
      end;
      // superfice lati
      For np:=3 to Amb.Npar do
      begin
       if (Amb.Par[np].Lato[1] <> '-') and (CompareStr(UpperCase(Amb.Par[np].Confine), 'FITT') <> 0) and (CompareStr(UpperCase(Amb.Par[np].Confine), 'DIVISORI') <> 0)
       then
       begin
        if Amb.Par[np].Alt <> 0 then
         if Amb.Par[np].Alt <> Amb.Par[np].Alt2 then
            SLP := SLP + ((SpessPar(Amb.Par[np].Cod) * (Amb.Par[np].Sup/((Amb.Par[np].Alt + Amb.Par[np].Alt2) / 2))) / cos(angolo))
         else
           SLP := SLP + ((SpessPar(Amb.Par[np].Cod) * (Amb.Par[np].Sup/Amb.Par[np].Alt)) / cos(angolo))
        else SLP := SLP + (Amb.Par[np].Sup / Cos(Angolo));
       end;
      end;
   end;
  end; {if sto considerando solo le pareti esterne}
 end;

{-----------------------------------------------------------------------------
  Procedure: CaricaRigaParete
  Author:    e.diquattro
  Date:      22-nov-2006
  Arguments: Amb: RecAmb; CodiceParete, indPar: Integer; SupNetta, SupL: Real; var TotdispAmb: Real
  Result:    None
  
  Cosa fa: Carica i dati della riga della parete
-----------------------------------------------------------------------------}
 Procedure CaricaRigaParete(Amb: RecAmb; CodiceParete, indPar: Integer; SupNetta, SupL: Real; var TotdispAmb, DTCorr, IncrCorr, SupT: Real; var EspC: Integer);
 var
   IndF, IndEsp: Integer;
   TotDispRiga: Real;
 begin
  IndF := Nuovafront(Amb.num);
  Frontiere_D^[indF]^.SupMuro := Supnetta;
  Frontiere_D^[indF]^.codmuro := Codiceparete;
  IndEsp := EsposizPar(Amb.Par[indPar].Confine, Amb.Par[indPar].Lato);
  Frontiere_D^[indF]^.Codesposiz := IndEsp;
  if IndEsp <> 0 then
  begin
    if UpperCase(Esposizioni_d[IndEsp].Tipo)='E' then
    begin
      IncrCorr := Esposizioni_d[IndEsp].IncrSic;
      DtCorr   := Zone_d[Amb.Zona].TInv-Prog.TEst;
    end
    else DtCorr := Zone_d[Amb.Zona].TInv - esposizioni_d[IndEsp].TrifInv;;
  end;

  // ------------------------------------
  // Stampa valori dispersioni per Pareti
  // ------------------------------------
  WStrTab(Amb.Par[indPar].Confine);                     // Stampa colonna Confine
  WStrTab(Amb.Par[indPar].Lato);                        // Stampa colonna Lato
  WRealeTab(DtCorr, 2);                                 // Stampa colonna Delta T
  // WRealeTab(zone_d[Ambienti_D^[i].zona].TInv-Prog.TEst,2);
  WStrTab(Amb.Par[indPar].Tipo);                        // Stampa colonna Categoria
  WStrTab(Amb.Par[indPar].Cod);                         // Stampa colonna Codice
  // WStrTab(Strutture_d^[codicepar(cod)]^.Descr);      // Stampa colonna Descrizione
  if CodiceParete <> 0 then
     WRealeTab(Strutture_d^[CodiceParete]^.Trasmitt,3); // Stampa colonna K-Klin
  WRealeTab(SupL, 2);                                   // Stampa colonna Superficie Lorda
  WRealeTab(supnetta, 2);                               // Stampa colonna Superficie Netta
  totdispriga:=Strutture_d^[CodiceParete]^.Trasmitt * supnetta * DTCorr * IncrCorr;
  {$IFDEF L10}
  AddStatistica(Strutture_d^[CodiceParete]^.Descr, totdispriga);
  {$ENDIF}
  totdispamb := totdispamb+totdispriga;
  WRealeTab((IncrCorr - 1) * 100, 1);                    // Stampa colonna Incr% per Esposizione
  WRealeTab(totdispriga, 0);                             // Stampa colonna Tot.Disp.[W]
  FineRigaTabella;
  SupT := Amb.Par[indPar].Sup;
  EspC := IndEsp;
 end;

{-----------------------------------------------------------------------------
  Procedure: CaricaRigaPonte
  Author:    e.diquattro
  Date:      22-nov-2006
  Arguments: Amb: RecAmb; indPar, EspCorr: Integer; DTCorr: Real; var TotdispAmb: Real
  Result:    None
  
  Cosa fa: arica i dati della riga del ponte termico
-----------------------------------------------------------------------------}
 Procedure CaricaRigaPonte(Amb: RecAmb; indPar, EspCorr: Integer; DTCorr, IncrCorr: Real; var TotdispAmb: Real);
 var
  IndPonte, IndFP: Integer;
  TotDispRiga: Real;
 begin
  IndPonte := CodicePon(Amb.Par[indPar].cod);
  IndFP := NuovaFrontLin(Amb.num);
  if IndPonte <> 0 then
  begin
     FrontiereLin_D^[IndFP]^.CodEsp    := EspCorr;
     FrontiereLin_D^[IndFP]^.CodPonte1 := IndPonte;
     FrontiereLin_D^[IndFP]^.Lung1     := Amb.Par[indPar].Num;
     FrontiereLin_D^[IndFP]^.Kappa     := Ponti_d^[IndPonte].KL;
     WStrTab('');                      //Confine
     WStrTab(Amb.Par[indPar].Lato);
     WRealeTab(DTCorr,2);
     WStrTab(Amb.Par[indPar].Tipo);
     WStrTab(Amb.Par[indPar].Cod);
     WRealeTab(Ponti_d^[IndPonte].KL, 3);
     WRealeTab(Amb.Par[indPar].Num, 2);                // Lunghezza del Ponte Termico
     WRealeTab(0, 2);                  // Superficie netta non utilizzata dal Ponte Termico
     totdispriga:=Ponti_d^[IndPonte].KL * Amb.Par[indPar].Num * DTCorr * IncrCorr;
    {$IFDEF L10}
     AddStatistica(Ponti_d^[IndPonte].Codice, totdispriga);
    {$ENDIF}
     totdispamb := totdispamb + totdispriga;
     WRealeTab(0,0);         //Futuro inserimento incrementi
     WRealeTab(totdispriga,0);
     FineRigaTabella;
  end; {end fine CodicePon}
 end;

 Procedure CaricaRigaFinestra(Amb: RecAmb; CodiceParete, indPar, EspCorr: Integer; SupP, DTCorr: Real; var TotdispAmb: Real);
 var
   indFin, IndF, CE: Integer;
   SupTot, totdispriga: Real;
   IncrCorr: Real;
 begin
   // Emanuela 3/11/2005 inserita la condizione di non considerare le porte collefate
   // ha divisori le quali non scambiano.
   if VerificaParetePrecedente(indPar-1, Amb) then
   begin
    // riga finestra
    IndFin := codicefin(Amb.Par[indPar].cod);
    if indFin <> 0 then
    begin
     IndF := Nuovafront(Amb.Num);
     SupTot  := supP - Amb.Par[indPar].Sup;
     Frontiere_D^[IndF]^.SupMuro := Amb.Par[indPar].Sup;
     WStrTab('');                              // Stampa colonna Confine
     WStrTab(Amb.Par[indPar].Lato);            // Stampa colonna Lato
     WRealeTab(DTCorr, 2);                      // Stampa colonna Delta T
     WStrTab(Amb.Par[indPar].Tipo);            // Stampa colonna Categ.
     WStrTab(Amb.Par[indPar].Cod);             // Stampa colonna Codice
     Frontiere_D^[IndF]^.Codesposiz  := EspCorr;
     Frontiere_D^[IndF]^.CodMuro     := Codiceparete;
     Frontiere_D^[IndF]^.Modfinestra := 1;
     Frontiere_D^[IndF]^.CodFinestra := indFin;
     Frontiere_D^[IndF]^.SupFinestra := Amb.Par[indPar].Sup;
     // 13 Gen 2oo5 - Fabio - Aggiunto Incremento per Esposizione alla finestra
     if EspCorr <> 0 then
        IncrCorr := esposizioni_d[EspCorr].IncrSic
     else IncrCorr := 0;
     // --------------------------------------
     // Stampa valori dispersioni per Finestre
     // --------------------------------------
     WRealeTab(Finestre_d^[codicefin(Amb.Par[indPar].cod)].Trasmittanza,3);  // Stampa la colonna K-Klin
     WRealeTab(Amb.Par[indPar].sup,2);                                       // Stampa colonna S.Lorda
     WRealeTab(Amb.Par[indPar].sup,2);                                       // Stampa colonna S.Netta
     totdispriga:=Finestre_d^[codicefin(Amb.Par[indPar].cod)].Trasmittanza* Amb.Par[indPar].sup * DTCorr * IncrCorr;
     {$IFDEF L10}
     AddStatistica(Finestre_d^[codicefin(Amb.Par[indPar].cod)].Denom, totdispriga);
     {$ENDIF}
     totdispamb := totdispamb+totdispriga;
     //Stampa valore Incremento per Esposizione della finestra
     if IncrCorr <> 0 then
        WRealeTab((IncrCorr - 1) * 100,1) // Stampa colonna Incr% per esposizione
     else WRealeTab(IncrCorr,1);
     WRealeTab(totdispriga, 0); // Stampa colonna Tot.Disp.[W]
     FineRigaTabella;
    end;
   end; 
 end;

{-----------------------------------------------------------------------------
  Procedure: VerificaParetePrecedente
  Author:    e.diquattro
  Date:      22-nov-2006
  Arguments: Indice: Integer; AmbT: RecAmb
  Result:    boolean
  
  Cosa fa: Verifica la tipologia della parete precedente
-----------------------------------------------------------------------------}
 function VerificaParetePrecedente(Indice: Integer; AmbT: RecAmb): boolean;
 var
  Trovato: Boolean;
 begin
  Trovato := False;
  while (Indice <> 0) and (not Trovato) do
  begin
    if CompareStr(UpperCase(AmbT.Par[Indice].Tipo), 'PARETE') = 0 then
    begin
      Trovato := True;
      if CompareStr(UpperCase(AmbT.Par[Indice].Confine), 'DIVISORI') = 0 then
         Result := False
      else Result := True;
    end;
    Indice := Indice - 1;
  end;
 end;

end.


