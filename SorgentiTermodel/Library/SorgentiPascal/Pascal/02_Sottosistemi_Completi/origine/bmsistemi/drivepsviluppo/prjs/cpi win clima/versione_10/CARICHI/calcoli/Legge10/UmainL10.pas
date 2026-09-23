unit UMainL10;

interface

uses Sysutils, DB, DBTables, Math, Dialogs, Classes,
     {my uses}
     CalcCD, Varcarichi, ULeggiscrividati, Udb, UInizializza, FunzProc1,
     UVariabili, UfunzioniLegge10, Utireport, procle11, procle13, Procle10,
     CalcL10, LibreriaGenerale, UCompilaFrontiere, UmessaggiCarichi,
     {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}GestioneGrafico{$ELSE} UStatistica {$IFEND}, Variabiligenerali, Terreno,
     CalcVent, Uti_Term, URicercaDati, MSG,udbt;
type
  // record per le potenze invernali
  TIntPot = record
               NumAmb: Integer;
               NomeLoc, Piano, CodGen: String[30];
               Pot, Port, DispInf, Vol, Sup: Double;
            end;

  Procedure CalcL10;
  Procedure CalcoloDispers;
  // Funzioni introdotte da Emanuela
  function LeggiDispersioneLocale(CodiceLocale:integer):double;
  Procedure Salva_Gen;
  // Emanuela creazione delle liste delle informazioni dell'alloggio
  procedure CaricaListeAlloggio(var ListaParAll, ListaFinPorAll, ListaZone10All: TStringList);
  Procedure AggiungiElementoLista(var Lista: TStringList; Codice: String);
  Function CodiceImp(Cod:String):Integer;
  Procedure DatiAttestato;
  Procedure AzzeraDatiAttestato;
  Procedure CreaConsumi;
  Procedure ChiudiConsumi;
 
 implementation

 uses {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
        uFormL10;
      {$ELSE}
        uProvaL10;
      {$IFEND}

  Procedure PreparaCalcolo;
  Var i:integer;
  begin
    Erroregen:=false;
    //Attivorep := true;
    drivematrice := drivecombo;
   {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13) and Defined(L10)}
    InitFilereport(IncludeTrailingPathDelimiter(PercorsoDrive) + 'Dispersioni' + NomeGeneratore + '.rep');
   {$ELSE}
    InitFilereport(IncludeTrailingPathDelimiter(PercorsoDrive) + 'Dispersioni.rep');
   {$IFEND}

    CopiaDati;        // Adatta i dati di input con i dati del Calcolo
    CompilaFront;
    CloseFileReport;
  end;

  Procedure ChiudiCalcolo;
  begin
   if dm1 <> nil then
   begin
    DM1.TT1.CLOSE;
    DM1.TT1.DatabaseName:=DP;
    Salva_Gen;
    if VerificaVersione <> 11 then
      begin
      dmtutti.T_Impianti.Close;
      Salva_Impianti(dmtutti.T_Impianti,dmtutti.T_Impianti,dmtutti.Ds_Impianti);
      dmtutti.T_Impianti.Open;
      end;
    dm1.TT1.Close;
   end;
  end;

  Procedure CalcoloDispers;
  begin
    PreparaCalcolo;
    if not erroregen then
    begin
      if FCalcL10 <> nil then
      begin
      {$IFDEF VERSIONE_12}
       DisplayStatistica(FcalcL10.series1,FcalcL10.GraficoDispersioni);
      {$ENDIF}
       // Emanuela 23/7/2004 Inserita la condizione per verificare quale relazione lanciare
       SetCalcDispOK(Str_Calc_OK);
      end;
    end
    else
    begin
      // Emanuela 23/7/2004 Inserita la condizione per verificare quale relazione lanciare
      // in questo caso ho inserito la condizione come se il calcolo fosse andato male
      SetCalcDispOK(Str_Calc_no_OK);
    end;
    if not FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcL10OK) then SetCalcL10OK(Str_Calc_no_OK);
    if not FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcTubiOK) then SetCalcTubiOK(Str_Calc_no_OK);
    ChiudiCalcolo;
  end;

  Procedure AggiungiElementoLista(var Lista: TStringList; Codice: String);
  var
    i: Integer;
    Trovato: Boolean;
  begin
    if Lista.Count = 0 then Lista.Add(Codice)
    else
    begin
     i := 0;
     Trovato := false;
     while (i <= Lista.Count-1) and (not Trovato) do
     begin
       if Lista[i] = Codice then Trovato := true;
       inc(i);
     end;
     if not Trovato then Lista.Add(Codice);
    end;
  end;

  Function CodiceImp(Cod:String):Integer;
  Var i: integer;
  begin
   i := 0;
   if CompareStr(Cod, 'Nessuno') <> 0 then
   begin
    if NImpianti<>0 then
    begin
      i:=1;
      while (i<NImpianti)and(UpperCase(Cod) <> UpperCase(Impianto_d^[i].Codice)) do inc(i);
    end;
    if (NImpianti=0)or(UpperCase(Cod) <> UpperCase(Impianto_d^[i].Codice)) then
    begin
      result:=0;
      Erroregen:=true;
      echo('L''impianto di codice '+ cod + ' non è stato trovato in archivio.');
    end;
   end;
   result:=i;
  end;

  // Emanuela creazione delle liste delle informazioni dell'alloggio
  procedure CaricaListeAlloggio(var ListaParAll, ListaFinPorAll, ListaZone10All: TStringList);
  var
    i, j, k: Integer;
  begin
   For i := 1 to NStrutture do
      if CompareStr(UpperCase(Strutture_D^[i]^.Categoria), 'TRASPARENTE') = 0 then
         AggiungiElementoLista(ListaParAll, Strutture_D^[i]^.NFile);
   For i := 1 to Nambienti do
   begin
    if CodiceImp(Ambienti_D^[i].Impianto) <> 0 then
    begin
      if ((uppercase(DescGen1^[gencor].Descrizione) = uppercase(Impianto_d^[CodiceImp(Ambienti_D^[i].Impianto)].GenInvt)))
      then
      begin
        for j := 1 to Ambienti_D^[i].NPar do
        begin
         // caricamento codice parete
         if (Ambienti_D^[i].Par[j].Lato[1]<>'-') then
         begin
           AggiungiElementoLista(ListaParAll, Ambienti_D^[i].Par[j].Cod);
         end
         else
         // caricamento codice finestra / porta
         if Ambienti_D^[i].Par[j].Tipo = Tfin then
         begin
           AggiungiElementoLista(ListaFinPorAll, Ambienti_D^[i].Par[j].Cod);
         end
        end;
        // caricamento zona10
        if Ambienti_D^[i]^.Z10 <> 0 then
           AggiungiElementoLista(ListaZone10All, Zone10^[Ambienti_D^[i]^.Z10].descr);
      end;
    end;
   end;
  end;

  Procedure CalcL10;
  Var a, i, jj, k, j, Cimp: integer;
      PressioneIgro: real;
      b, c: smallint;
      CodiceZona: string;
      SupCalpestabile, SupDisperdente, VolumeNetto, PotDisperdente: double;
      ListaParAll, ListaFinPorAll, ListaZone10All: TStringList;
  begin
   PreparaCalcolo;
   initvariab;
  {$IFDEF VERSIONE_13}
    //CreaConsumi;
  {$ENDIF}
   if not erroregen then
   begin
      for i:=1 to Nstrutture do
      begin
          // supponiamo che questa struttura debba contenere i valori della Legge10
          // Emanuela o1-o7-2oo4 Modificato per verifica dati di irradiazione solare pareti opache
          k10^[i].ka:=strutture_D[i].TrasmittL10;
          k10^[i].kn:=strutture_D[i].Trasmitt;
          k10^[i].hi:=strutture_D[i].alfa;
          k10^[i].he:=strutture_D[i].beta;
      end;
      // Emanuela creazione delle liste che conterranno le informazioni dell'alloggio
        ListaParAll    := TStringList.Create;
        ListaFinPorAll := TStringList.Create;
        ListaZone10All := TStringList.Create;
      // Emanuela caricamento delle liste che conterranno le info dell'alloggio
        CaricaListeAlloggio(ListaParAll, ListaFinPorAll, ListaZone10All);

        {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13) and Defined(L10)}
          InitFilereport(IncludeTrailingPathDelimiter(PercorsoDrive) + 'Legge10'+ NomeGeneratore +'.rep');
        {$ELSE}
          InitFilereport(IncludeTrailingPathDelimiter(PercorsoDrive) + 'Legge10.rep');
        {$IFEND}

          // ------------------------------------------------------------
          // Stampa delle Tabelle Caratteristiche termiche e igrometriche
          //  dei componenti opachi dell'involucro edilizio
          // ------------------------------------------------------------

        Inizio_compart('PARETI');
        for j := 0 to ListaParAll.Count - 1 do
        begin
         for i := 1 to NStrutture do
         begin
           //Unica stampa delle pareti
           if CompareStr(UpperCase(Strutture_D^[i].NFile), UpperCase(ListaParAll[j])) = 0 then
           begin
          // ------------------------------------
          // Stampe dei dati fuori tabella PARETI
          // ------------------------------------
          {$IFDEF VERSIONE_13}
             Strutture_D^[i]^.VerDlg192 := '*';
          {$ELSE}
             Strutture_D^[i]^.st_vet := '*';
          {$ENDIF}

             W_Reale('NUM_PAR',i,0);                                // Numero Parete = indice i
             WRep_str('COD_PAR',strutture_D^[i].NFile);             // Codice Parete = codice
             WRep_str('DESC_PAR',strutture_D^[i].Descr);            // Descrizione Parete = nome della parete
             WRep_str('TIPO_PAR',strutture_D^[i].Categoria);        // Tipo Parete = Tipologia OPACO-TRASPARENTE
             W_Reale('SPESS_PAR',strutture_D^[i].SpessoreParete,1); // Spessore Parete = Spessore Totale della Parete

          // ---------------------------------
          // Stampe dei dati in tabella PARETI
          // ---------------------------------

             iniziotabella('STRATO_PARETI',10);
             for jj:=1 to strutture_D^[i].Nstrati do
             with Strutture_D^[i].strati[jj] do
              begin

                 WRealeTab(jj,0);
                 WstrTab(NFile);
                 WstrTab(Descrizione);
                 WRealeTab(Spessore,1);
                 WRealeTab(ConduttivitaLineare,2);
                 WRealeTab(Conduttanza,2);
                 WRealeTab(PesoSpecifico,1);
                 if mu <> 0 then
                 begin
                  WRealeTab(193/mu,2);         // Delta a - Pi Materiale = Pi Aria / Mu Materiale
                  WRealeTab((193/mu)*1.1,2);   // Delta u - Pi Materiale + 10%
                 end
                 else
                 begin
                  WRealeTab(0,2);
                  WRealeTab(0,2);
                 end;


                 if Conduttanza = 0 then
                 begin
                   // Emanuela 5/10/2004 - Corretto errore nel caso in cui lo spessore è nullo
                   if Spessore <> 0 then
                      WRealeTab(1/(ConduttivitaLineare/(Spessore/100)),3)
                   else WRealeTab(0,3);
                 end
                 else WRealeTab(1/Conduttanza,3);

                 FinerigaTabella;

                 W_Reale('COND_UNIS_I',Strutture_D^[i].alfa,2);
                 W_Reale('COND_UNIS_E',Strutture_D^[i].beta,2);
                 W_Reale('TRAS_TOTALE',Strutture_D^[i].Trasmitt,3);
                 W_Reale('TRAS_ADOTTA',Strutture_D^[i].TrasmittL10,3);

                 if Strutture_D^[i].alfa <> 0 then          W_Reale('RESI_UNIS_I',(1/Strutture_D^[i].alfa),2);
                 if Strutture_D^[i].beta <> 0 then          W_Reale('RESI_UNIS_E',(1/Strutture_D^[i].beta),2);
                 if Strutture_D^[i].Trasmitt <> 0 then      W_Reale('RESI_TOTALE',(1/Strutture_D^[i].Trasmitt),3);
                 if Strutture_D^[i].TrasmittL10 <> 0 then   W_Reale('RESI_ADOTTA',(1/Strutture_D^[i].TrasmittL10),3);

                 // ---------------------------------------------
                 // Stampa Tabella
                 // VERIFICA IGROMETRICA - CONDIZIONI AL CONTORNO
                 // ---------------------------------------------

                 W_Reale('TI_INV',Strutture_D^[i].Ti,1);
                 W_Reale('TE_INV',Strutture_D^[i].Te,1);
                 W_Reale('TI_EST',Strutture_D^[i].EsTi,1);
                 W_Reale('TE_EST',Strutture_D^[i].EsTe,1);

                 PressioneIgro:=PVapore(Strutture_D^[i].Ti, Strutture_D^[i].URi);
                 W_Reale('PI_INV',PressioneIgro,0);
                 PressioneIgro:=PVapore(Strutture_D^[i].Te, Strutture_D^[i].URe);
                 W_Reale('PE_INV',PressioneIgro,0);
                 PressioneIgro:=PVapore(Strutture_D^[i].EsTi, Strutture_D^[i].EsURi);
                 W_Reale('PI_EST',PressioneIgro,0);
                 PressioneIgro:=PVapore(Strutture_D^[i].EsTe, Strutture_D^[i].EsURe);
                 W_Reale('PE_EST',PressioneIgro,0);

                 // -------------------------------
                 // Stampa Tabella
                 // VERIFICA FORMAZIONE DI CONDENSA
                 // -------------------------------

                 W_Reale('DELTA_PA1',Strutture_D^[i].DeltaPA1,1);
                 W_Reale('DELTA_PA2',Strutture_D^[i].DeltaPA2,1);
                 W_Reale('H2O_COND2',Strutture_D^[i].Condensato,1);
                 Wrep_str('OPZ_COND1',strutture_D^[i].NoCondInt);
                 Wrep_str('OPZ_COND2',strutture_D^[i].SiCondInt);
                 Wrep_str('OPZ_COND3',strutture_D^[i].NoCondSup);


            end;
            finetabella;

            if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
            begin
              // verifica trasmittanza 192
              if not (
                      ((CompareStr(UpperCase(Strutture_D^[i].interest), 'INTERNA') = 0) and
                       (CompareStr(UpperCase(Strutture_D^[i].Categoria), 'OPACO') = 0) and
                       (CompareStr(UpperCase(Strutture_D^[i].SeparaAlloggi), UpperCase('Divisorio separazione tra locali')) = 0))
                      or
                      ((CompareStr(UpperCase(Strutture_D^[i].interest), 'INTERNA') = 0) and
                       ((CompareStr(UpperCase(Strutture_D^[i].parsof), 'SOFFITTO') = 0) or (CompareStr(UpperCase(Strutture_D^[i].parsof), 'PAVIMENTO') = 0)) and
                       (CompareStr(UpperCase(Strutture_D^[i].SeparaAlloggi), UpperCase('Divisorio separazione tra alloggi')) = 0))
                     )
              then
              begin
                Sezione('PARETETR', 'True');
                W_Reale('TRAS_ADOTTA', Strutture_D^[i].Trasmitt, 3);
                W_Reale('TRAS_LIM', Strutture_D^[i].ValLimT, 2);
                WRep_str('VERK',Strutture_D^[i].Verifica192);
                if (not(CompareStr(UpperCase(Strutture_D^[i]^.Verifica192), 'SI') = 0 ))and
                   (not(CompareStr(UpperCase(Strutture_D^[i]^.Verifica192), 'PS') = 0 )) then
                  if CompareStr(UpperCase(Strutture_D^[i].Categoria), 'OPACO') = 0 then
                  begin
                   {$IFDEF VERSIONE_12}
                     DatiV192.VerifPareti := False;
                   {$ELSE}
                     DatiV192[Gencor-1].VerifPareti := False;
                   {$ENDIF}
                  end
                  else if CompareStr(UpperCase(Strutture_D^[i].Categoria), 'TRASPARENTE') = 0 then
                       begin
                        {$IFDEF VERSIONE_12}
                          DatiV192.VerificaVetri := False;
                        {$ELSE}
                          DatiV192[Gencor-1].VerificaVetri := False;
                        {$ENDIF}
                       end;
              end
              else
                Sezione('PARETETR', 'False');
              // verifica massa superficiale
              if not (
                      ((CompareStr(UpperCase(Strutture_D^[i].interest), 'INTERNA') = 0) and
                       (CompareStr(UpperCase(Strutture_D^[i].SeparaAlloggi), UpperCase('Divisorio separazione tra locali')) = 0))
                      or
                      ((CompareStr(UpperCase(Strutture_D^[i].interest), 'INTERNA') = 0) and
                       ((CompareStr(UpperCase(Strutture_D^[i].parsof), 'SOFFITTO') = 0) or (CompareStr(UpperCase(Strutture_D^[i].parsof), 'PAVIMENTO') = 0)) and
                       (CompareStr(UpperCase(Strutture_D^[i].SeparaAlloggi), UpperCase('Divisorio separazione tra alloggi')) = 0))
                     )
              then
              begin
                // Emanuela DPR 192 cotrollo e inserimento dei dati della massa superficiale
                if ((CompareStr(UpperCase(Strutture_D^[i].interest), 'ESTERNA') = 0) and
                    (CompareStr(UpperCase(Strutture_D^[i].Categoria),'OPACO') = 0) and
                    (CompareStr(UpperCase(Strutture_D^[i].parsof),   'PARETE') = 0))
                then
                begin
                   Sezione('PARETEMS', 'True');
                   W_Reale('MASSA_SUP', Strutture_D^[i].MassaSup, 2);
                   W_Reale('MASSA_LIM', Strutture_D^[i].ValLimM, 2);
                   WRep_str('VERM',Strutture_D^[i].VerificaMassaS);
                end
                else
                  if((Strutture_D^[i].SeparaAlloggi = 'Divisorio separazione tra alloggi') and
                    (CompareStr(UpperCase(Strutture_D^[i].interest), 'INTERNA') = 0))
                  then
                  begin
                    Sezione('PARETEMS', 'True');
                    W_Reale('MASSA_SUP', Strutture_D^[i].MassaSup, 2);
                    W_Reale('MASSA_LIM', Strutture_D^[i].ValLimM,  2);
                    WRep_str('VERM',Strutture_D^[i].VerificaMassaS);
                  end
                  else
                  if((CompareStr(UpperCase(Strutture_D^[i].interest),  'ESTERNA') = 0) and
                     (CompareStr(UpperCase(Strutture_D^[i].Categoria), 'OPACO') = 0) and
                     (CompareStr(UpperCase(Strutture_D^[i].parsof),    'PAVIMENTO') = 0))
                  then
                  begin
                   Sezione('PARETEMS', 'True');
                   W_Reale('MASSA_SUP', Strutture_D^[i].MassaSup, 2);
                   W_Reale('MASSA_LIM', Strutture_D^[i].ValLimM,  2);
                   WRep_str('VERM',Strutture_D^[i].VerificaMassaS);
                  end
                  else
                  if((CompareStr(UpperCase(Strutture_D^[i].interest), 'ESTERNA') = 0) and
                     (CompareStr(UpperCase(Strutture_D^[i].Categoria),'OPACO') = 0) and
                     (CompareStr(UpperCase(Strutture_D^[i].parsof),   'SOFFITTO') = 0))
                  then
                  begin
                   Sezione('PARETEMS', 'True');
                   W_Reale('MASSA_SUP', Strutture_D^[i].MassaSup, 2);
                   W_Reale('MASSA_LIM', Strutture_D^[i].ValLimM,  2);
                   WRep_str('VERM',Strutture_D^[i].VerificaMassaS);
                  end
                  else
                    Sezione('PARETEMS', 'False');
              end
              else Sezione('PARETEMS', 'False');
            end; {Fine verifica se il calcolo e secondo la 192}
        Fine_Gruppo;
       end;{end if strutture}
     end;{end for nstrutture}
    end;{end for listaparAll}
    Fine_Compart;

        // -o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o
        // FINE Stampa delle Tabelle Caratteristiche termiche e
        // igrometriche dei componenti opachi dell'involucro edilizio
        // -o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o-o

        // *****************************

        // -------------------------------------------------
        // Stampa delle Tabelle Caratteristiche termiche dei
        // componenti finestrati dell'involucro edilizio.
        // -------------------------------------------------

        Inizio_compart('FINESTRE');
        for j := 0 to ListaFinPorAll.Count - 1 do
        begin
          for i:=1 to NFinestre do
          begin
           if CompareStr(UpperCase(Finestre_D^[i].Codice), UpperCase(ListaFinPorAll[j])) =0  then
           begin
             with Finestre_D^[i] do
             begin
                {$IFDEF VERSIONE_13}
                 Finestre_D^[i].VerFDlg192 := '*';
                {$ELSE}
                 Finestre_D^[i].paretecontinua := '*';
                {$ENDIF}
                 W_Reale('NUM_FIN',i,0);
                 Wrep_str('COD_FIN',Finestre_D^[i].Codice);
                 Wrep_str('DESC_FIN',Finestre_D^[i].Denom);
                 Wrep_str('TIPO_FIN',Finestre_D^[i].FinPor);

                 Wrep_str('DESCFIN',Finestre_D^[i].Denom);
                 W_Reale('AGFIN',Finestre_D^[i].Ag,2);
                 W_Reale('AFFIN',Finestre_D^[i].Af,2);
                 W_Reale('LGFIN',Finestre_D^[i].Lg,2);
                 W_Reale('KGFIN',Finestre_D^[i].KgL10,3);
                 W_Reale('KFFIN',Finestre_D^[i].Kf,3);
                 W_Reale('KLFIN',Finestre_D^[i].Lineak,3);
                 W_Reale('KWFIN',Finestre_D^[i].Uw,3);

                 W_Reale('COND_UNIS_IF',Finestre_D^[i].Hi,2);
                 W_Reale('COND_UNIS_EF',Finestre_D^[i].He,2);

                 if Finestre_D^[i].Hi <> 0 then W_Reale('RESI_UNIS_IF',1/Finestre_D^[i].Hi,2)
                 else W_Reale('RESI_UNIS_IF',0,2);
                 if Finestre_D^[i].He <> 0 then W_Reale('RESI_UNIS_EF',1/Finestre_D^[i].He,2)
                 else W_Reale('RESI_UNIS_EF',0,2);

                 W_Reale('TRAS_TOTAL_F',Finestre_D^[i].Uw,3);  // Da modificare nel caso di serramento doppio
                 if Finestre_D^[i].Uw <> 0 then W_Reale('RESI_TOTAL_F',1/Finestre_D^[i].Uw,3);
                 if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
                 begin
                 // Emanuela DPR 192 controllo e inserimento dei dati sulla trasmittanza della finestra
                  if (CompareStr(UpperCase(Finestre_D^[i].FinPor), 'FINESTRA') = 0) then
                  begin
                     Sezione('FINETR', 'True');
                     W_Reale('TRASF_ADOTTA', Finestre_D^[i].Trasmittanza, 3);
                     W_Reale('TRASF_LIM', Finestre_D^[i].ValLimFT, 2);
                     WRep_str('VERF', Finestre_D^[i].VerificaF192);
                     if not (CompareStr(UpperCase(Finestre_D^[i].VerificaF192), 'SI') = 0) then
                     begin
                      {$IFDEF VERSIONE_12}
                        DatiV192.VerifiFinestre := False;
                      {$ELSE}
                        DatiV192[Gencor-1].VerifiFinestre := False;
                      {$ENDIF}
                     end;
                   end
                   else
                     Sezione('FINETR', 'False');
                 end; {Fine controllo se il calcolo viene effettuato secondo la 192}
             end;
             Fine_Gruppo;
           end; {end if }
          end; {end for i}
        end; {end for j}
        Fine_Compart;
        WRep_str('TCONDA',' ');
        WRep_str('TCONDB','X');
        WRep_str('VAR_KWH','kWh/mq/anno');
        Inizio_Compart('VENTZONE');
        { TODO -oGenerale -cIndice : Calcolo procedura principale }
        for j := 0 to  ListaZone10All.Count - 1 do
        begin
         for i:=1 to NZone10 do
         begin
          {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
            AzzeraDatiAttestato;
          {$IFEND}
          if CompareStr(UpperCase(zone10^[i].descr), UpperCase(ListaZone10All[j])) = 0 then
          begin
            zonaCalc := i;
            DatiVentZona;
            Fine_Gruppo;
          end;
         end;
        end; {end for j}
        Fine_Compart;
        // -----------------------------------------------
        // FINE Stampa
        // Tabelle Caratteristiche termiche dei componenti
        // finestrati dell'involucro edilizio.
        // -----------------------------------------------
        a:=1;
        // ---------------------
        // Stampa Dati Climatici
        // ---------------------
        Stampadaticlimatici;          //1 Avvia Stampa Dati Climatici
        b:=0;c:=0;
        // ---------------------------------------------------------
        // Azzeramento valori di radiazione solare e apporti interni
        // Tabella ARTICOLO 7 - COMMA 7 DEL DPR 412
        // ---------------------------------------------------------
        ValoreArt7.RadSolare := 0;
        ValoreArt7.AppInt := 0;
        ValoreArt7.Mese := '';
        ValoreArt7.FabbReale := 0;
        ValoreArt7.ValArt7 := 0;

        Inizio_Compart('RIEPZT');
        { TODO -oGenerale -cIndice : Calcolo procedura principale }
        for j := 0 to  ListaZone10All.Count - 1 do
        begin
          for i:=1 to NZone10 do
          begin
            if CompareStr(UpperCase(zone10^[i].descr), UpperCase(ListaZone10All[j])) = 0 then
            begin
              zonaCalc := i;
              // ---------------------------------------------
              // Stampe dati identificativi della Zona Termica
              // ---------------------------------------------
              CodiceZona := CodiceZona_D(zone10^[i].descr);
              Wrep_str('COD_ZTERM', CodiceZona);
              Wrep_str('NOME_ZTERM',  zone10^[i].descr);
              Wrep_str('CLASS_ZONA', RestituisciClassZona(zone10^[i].descr));
              // Calcolo della superficie calpestabile della zona
              SupCalpestabile := 0;
              VolumeNetto := 0;
              PotDisperdente := 0;
              for k:=1 to NAmbienti do
              begin
                CImp := CodiceImp(Ambienti_D^[K].Impianto);
                if CImp <> 0 then
                begin
                  if (UpperCase(Ambienti_D^[k].CodZona) = UpperCase(CodiceZona)) and
                     (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CImp].GenInvt)) = 0)
                  then
                  begin
                   SupCalpestabile := SupCalpestabile + Ambienti_D^[k].Superficie*Ambienti_D^[k].Ambientiuguali;
                   VolumeNetto := VolumeNetto + Ambienti_D^[k].Superficie * Ambienti_D^[k].HSoffitto*Ambienti_D^[k].Ambientiuguali;
                   PotDisperdente := PotDisperdente + LeggiDispersioneLocale(StrToInt(Ambienti_D^[k].CodNum));
                  end;
                end
                else echo('Il locale: ' + Ambienti_D^[k].Denom + ' del piano ' + Ambienti_D^[k].Piano + ' ha come codice impianto assegnato Nessuno, modificarlo');
              end;
              W_Reale('SUP_ZTERM', SupCalpestabile, 2);
              W_Reale('VOL_ZTERM', VolumeNetto, 2);
              W_Reale('PDISP_ZTERM', PotDisperdente, 2);
              InitTOt_Aei;
              Volumezona:=CalcVolRisc(i);
              Areazona:=CalcSupRisc(i);
              StampSupParOpa(b,c);                //1 Avvia Stampa Pareti Opache 1A
              SupFinTrasp(b,c);                   //2 Avvia Stampa Finestre Trasparenti 1B
              stampaPavSuTer;                     //5 Avvia stampa Pavimento su Terreno
              StampSupParLocFissi(b,c);           //3 Avvia Stampa Sup Par Loc Temp Fissa
              StampPontiEsterni(b,c);             //4 Avvia Stampa Ponti Termici Esterni
              StampCalcVent(b,c);
              StampTotH(b,c);                     //6 Avvia Stampa Totale H delle strutture
              stampaIrrag(b,c);                   // Stampa totale Irraggiamento per orientazione
             {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
              StampCarInt;                        // Stampa dei carichi termici
             {$IFEND}
              StampCapTerm(b,c);                  // Stampa della Capacità Termica Edificio
              stampatotzona(b,c);                 // Stampa del riepilogo di Zona
              Fine_Gruppo;
            end; {end if}
          end; {end for i}
        end; {end for j}
        Fine_Compart;

        //Emanuela: Stampa dei dati per il generatore secondo la 192
        if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
           Dati_Gen;
        StampTotGenerat(b,c,1); // Stampa tabella REND. di PRODUZ. DEL GEN.-REGIME CONTINUO (UNI 10348)
        StampTotGenerat(b,c,0); // Stampa tabella REND. di PRODUZ. DEL GEN.-REGIME NON CONTINUO (UNI 10348)
        //Emanuela 23/7/2004 Inserita la condizione per verificare quale relazione lanciare
        SetCalcL10OK(Str_Calc_OK);
        {$IF Defined(VERSIONE_12)}
         if FcalcL10 <> nil then
          DisplayStatistica(FcalcL10.series1, FcalcL10.GraficoDispersioni);
        {$ELSEIF Defined(VERSIONE_11)}
          DisplayStatistica(FcalcL10.series1, FcalcL10.GraficoDispersioni);
        {$IFEND}
        CloseFileReport;
       {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
       //Emanuela: Stampa dei dati per il certificato energetico secondo la 192
       if CompareStr(UpperCase(Prog.Calc192), 'SI') = 0 then
          DatiAttestato;
       {$IFEND}
        ChiudiCalcolo;
       {$IFDEF VERSIONE_13}
        // ChiudiConsumi;
       {$ENDIF}
        FreeAndNil(ListaParAll);
        FreeAndNil(ListaFinPorAll);
        FreeAndNil(ListaZone10All);
     end;  {end if erroregen}   
     if not FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcDispOK) then SetCalcDispOK(Str_Calc_no_OK);
     if not FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + NomeFile_CalcTubiOK) then SetCalcTubiOK(Str_Calc_no_OK);
  end;

  {-----------------------------------------------------------------------------
    Procedure: LeggiDispersioneLocale
    Author:    Emanuela
    Date:      07-lug-2004
    Arguments: None
    Result:    None

    Restituisce il valore della dispersione dell'ambiente
  -----------------------------------------------------------------------------}
  function LeggiDispersioneLocale(CodiceLocale:integer):double;
  var
    FPotInv: File of TIntPot;
    BufPotInv: TIntPot;
    i, j: Integer;
    Trovato: Boolean;
  begin
   result := 0;
   if FileExists(IncludeTrailingPathDelimiter(PercorsoDrive) + 'potinv.int') then
   begin
    Assign(FPotInv, IncludeTrailingPathDelimiter(PercorsoDrive) + 'potinv.int');
    try
      reset(FPotInv);
      while not Eof(FPotInv) do
      begin
        Read(FPotInv, BufPotInv);
        Trovato := False;
        with BufPotInv do
        begin
          if CodiceLocale = NumAmb then
           begin
              Trovato := True;
              Result := Pot;
           end;
        end;
      end;
      close(FPotInv);
    except
      close(FPotInv);
    end;
   end;
  end;

{-----------------------------------------------------------------------------
  Procedure: Salva_Gen
  Author:    e.diquattro
  Date:      21-dic-2005
  Arguments: None
  Result:    None

  Cosa fa: SALVA I DATI DEL GENRATORE CORRENTE
-----------------------------------------------------------------------------}

  Procedure Salva_Gen;
  var
    TabGen: TTable;
    i: Integer;
  begin

   if FileExists(Percorso_Progetti + 'Generatori.db') then
   begin
    TabGen := TTable.Create(nil);
    TabGen.DatabaseName := Percorso_Progetti;
    TabGen.TableName := 'Generatori.db';
    if TabGen.Exists then
    begin
      TabGen.Open;
    For i:=1 to Ngeneratori Do
    Begin
      TabGen.edit;
      TabGen.First;
      while (not TabGen.Eof) and (CompareStr(TabGen.Fields[1].AsString, DescGen1^[i].Descrizione) <> 0 ) do
            TabGen.Next;
      with DescGen1^[i] do
      Begin
        TabGen.Fields.DataSet.Edit;
        TabGen.fields[0].asstring := Cod;
        TabGen.fields[1].asstring := Descrizione;
        TabGen.fields[2].asstring := Tipo;
        TabGen.fields[3].asstring := Model;
        TabGen.fields[4].asinteger := Numero;
        TabGen.fields[5].asstring := fluido;
        TabGen.fields[6].asstring := combust;
        TabGen.fields[7].asfloat := RoundTo(PNom, -2);
        TabGen.fields[8].asfloat := RoundTo(Qpo, -2);
        TabGen.fields[9].asfloat := RoundTo(Pfoc, -2);
        TabGen.fields[10].asfloat := RoundTo(Pf,-3);
        TabGen.fields[11].asfloat := RoundTo(Pfbs,-3);
        TabGen.fields[12].asfloat := RoundTo(Pd,-3);
        TabGen.fields[13].asfloat := RoundTo(Qbr,-2);
        TabGen.fields[14].asstring := TipoInvol;
        TabGen.fields[15].asfloat := RoundTo(TempH2O, -2);
        TabGen.fields[16].asfloat := RoundTo(Rend100, -3);
        TabGen.fields[17].asfloat := RoundTo(Rend30, -3);
        TabGen.fields[18].asfloat := RoundTo(QAv, -3);
        TabGen.fields[19].asfloat := RoundTo(CopT, -2);
        TabGen.fields[20].asfloat := RoundTo(CopE, -2);
        TabGen.fields[21].asfloat := RoundTo(TempSorg, -2);
        TabGen.fields[22].asfloat := RoundTo(TempInt, -2);
        TabGen.fields[23].asstring := IndiceCP;
        TabGen.fields[24].asfloat := RoundTo(dispers, 0);
        TabGen.fields[25].asfloat := RoundTo(VolLord, -2);
        TabGen.fields[26].asfloat := RoundTo(SupLord, -2);
        TabGen.fields[27].asfloat := RoundTo(SV, -2);
        TabGen.fields[28].asfloat := RoundTo(Dt, -2);
        TabGen.fields[29].asfloat := RoundTo(Cdfen, -3);
        TabGen.fields[30].asfloat := RoundTo(CdLeg, -3);
        TabGen.fields[31].asfloat := RoundTo(CdAdot, -3);
        TabGen.fields[32].asfloat := RoundTo(Fts, -2);
        TabGen.fields[33].asfloat := RoundTo(GiorniRis, -2);
        TabGen.fields[34].asfloat := RoundTo(Fen, -2);
        TabGen.fields[35].asfloat := RoundTo(RicAr, -2);
        TabGen.fields[36].asfloat := RoundTo(IrradS, -2);
        TabGen.fields[37].asfloat := RoundTo(DtMed, -2);
        TabGen.fields[38].asfloat := RoundTo(AppGr, -2);
        TabGen.fields[39].asfloat := RoundTo(CorUtilAg, -2);
        TabGen.fields[40].asfloat := RoundTo(RedETg, -2);
        TabGen.fields[41].asfloat := RoundTo(FenLim, -2);
        TabGen.fields[42].asstring := Verifica;
        TabGen.fields[43].asfloat := RoundTo(DispCDInf, 0);
        TabGen.fields[44].asfloat := RoundTo(DispCDVol, -2);
        TabGen.fields[45].asfloat := RoundTo(RedETgRegol, -2);
        TabGen.fields[46].asstring:= Articolo7;
        TabGen.fields[47].asstring:= CdVerificato;
        TabGen.fields[48].asstring:= FenVerificato;
        TabGen.Fields[58].AsFloat := RoundTo(DescGen1^[i].ValLim, -2);
        TabGen.Fields[55].AsFloat := RoundTo(DescGen1^[i].FBMJ, -2);
        TabGen.Fields[56].AsFloat := RoundTo(DescGen1^[i].FBKW, -2);
        TabGen.Fields[59].AsFloat := RoundTo(DescGen1^[i].FBKWSU, -2);
        TabGen.Fields[57].AsFloat := RoundTo(DescGen1^[i].SupUtileR, -2);
        TabGen.Fields[61].AsFloat := RoundTo(DescGen1^[i].RedETp, -2);
        TabGen.Fields[62].AsFloat := RoundTo(DescGen1^[i].RedETpRegol, -2);
        TabGen.POst;
      end;
     end;
    end;
    TabGen.Close;
    TabGen.Free;
   end
   else MessageDlg(goMSG('MSG_004032017',MSG_004032017), mtInformation, [mbOk], 0);

  end;

{-----------------------------------------------------------------------------
  Procedure: DatiAttestato
  Author:    e.diquattro
  Date:      27-dic-2005
  Arguments: None
  Result:    None

  Cosa fa: imposta i dati per l'attestato energetico
-----------------------------------------------------------------------------}
  Procedure DatiAttestato;
  begin
    InitFilereport(PercorsoDrive + '\' + 'DatiAttestato'+ NomeGeneratore +'.rep');
    Wrep_str('NOMELOCALITA',prog^.Localita);
    Wrep_str('NOMECOMUNE',  prog^.Comune);
    Wrep_str('ZONA_GEO',    prog^.Zonageo);
    Wrep_str('REG_VENTO',   prog^.regvento);
    Wrep_str('ZONA_VENTO',  IntToStr(prog^.zonavent));
    Wrep_str('ZONA_CLIMA',  prog^.ZonaCl);
    W_reale('TEMP_ESTERNA', prog^.TEst, 2);
    W_reale('GRADI_GG',     prog^.gradi,     0);
   {$IF Defined(VERSIONE_12)}
    Wrep_str('CATEGORIA_EDIFICIO', DatiAtt.Classif);
    W_reale('VOL',                 DatiAtt.Vl,   2);
    W_reale('SUPEST',              DatiAtt.Sl,   2);
    W_reale('SUPUTIL',             DatiAtt.SupL, 2);
    W_reale('RAPPSV',              DatiAtt.Sv,   2);
    W_reale('GIORNI_RISC',         DatiAtt.GIORNI_RISC,  0);
    W_reale('ETA_DISTR',           DatiAtt.ETA_DISTR,    2);
    W_reale('ETA_EMISS',           DatiAtt.ETA_EMISS,    2);
    W_reale('ETA_REG',             DatiAtt.ETA_REG,      2);
    W_reale('ETA_GLOBALE',         DatiAtt.ETA_GLOBALE,  2);
    W_reale('CD',                  DatiAtt.CD,           2);
    W_reale('QKW',                 DatiAtt.QKW,          2);
    W_reale('QMJ',                 DatiAtt.QMJ,          2);
    W_reale('FEN',                 DatiAtt.FEN,          2);
    W_reale('QKW_LIMITE',          DatiAtt.VLim,         2);
    if DatiAtt.QKW <= 30 then
    begin
       W_Reale('IND_ENERG_A', DatiAtt.QKW, 2);
       W_Reale('FEN_A',       DatiAtt.FEN, 2);
    end
    else
    if (DatiAtt.QKW > 30) and (DatiAtt.QKW <= 50) then
    begin
       W_Reale('IND_ENERG_B', DatiAtt.QKW, 2);
       W_Reale('FEN_B',       DatiAtt.FEN, 2);
    end
    else
    if (DatiAtt.QKW > 50) and (DatiAtt.QKW <= 70) then
    begin
       W_Reale('IND_ENERG_C', DatiAtt.QKW, 2);
       W_Reale('FEN_C',       DatiAtt.FEN, 2);
    end
    else
    if (DatiAtt.QKW > 70) and (DatiAtt.QKW <= 90) then
    begin
       W_Reale('IND_ENERG_D', DatiAtt.QKW, 2);
       W_Reale('FEN_D',       DatiAtt.FEN, 2);
    end
    else
    if (DatiAtt.QKW > 90) and (DatiAtt.QKW <= 120) then
    begin
       W_Reale('IND_ENERG_E', DatiAtt.QKW, 2);
       W_Reale('FEN_E',       DatiAtt.FEN, 2);
    end
    else
    if (DatiAtt.QKW > 120) and (DatiAtt.QKW <= 160) then
    begin
       W_Reale('IND_ENERG_F', DatiAtt.QKW, 2);
       W_Reale('FEN_F',       DatiAtt.FEN, 2);
    end
    else
    if (DatiAtt.QKW > 160) then
    begin
       W_Reale('IND_ENERG_G', DatiAtt.QKW, 2);
       W_Reale('FEN_G',       DatiAtt.FEN, 2);
    end;
   {$ELSEIF Defined(VERSIONE_13)}
    Wrep_str('CATEGORIA_EDIFICIO', DatiAtt[gencor-1].Classif);
    W_reale('VOL',          DatiAtt[gencor-1].Vl,   2);
    W_reale('SUPEST',       DatiAtt[gencor-1].Sl,   2);
    W_reale('SUPUTIL',      DatiAtt[gencor-1].SupL, 2);
    W_reale('RAPPSV',       DatiAtt[gencor-1].Sv,   2);
    W_reale('GIORNI_RISC',  DatiAtt[gencor-1].GIORNI_RISC,  0);
    W_reale('ETA_DISTR',    DatiAtt[gencor-1].ETA_DISTR,    2);
    W_reale('ETA_EMISS',    DatiAtt[gencor-1].ETA_EMISS,    2);
    W_reale('ETA_REG',      DatiAtt[gencor-1].ETA_REG,      2);
    W_reale('ETA_GLOBALE',  DatiAtt[gencor-1].ETA_GLOBALE,  2);
    W_reale('CD',           DatiAtt[gencor-1].CD,           2);
    W_reale('QKW',          DatiAtt[gencor-1].QKW,          2);
    W_reale('QMJ',          DatiAtt[gencor-1].QMJ,          2);
    W_reale('FEN',          DatiAtt[gencor-1].FEN,          2);
    W_reale('QKW_LIMITE',   DatiAtt[gencor-1].VLim,         2);
    if DatiAtt[gencor-1].QKW <= 30 then
    begin
       W_Reale('IND_ENERG_A', DatiAtt[gencor-1].QKW, 2);
       W_Reale('FEN_A',       DatiAtt[gencor-1].FEN, 2);
    end
    else
    if (DatiAtt[gencor-1].QKW > 30) and (DatiAtt[gencor-1].QKW <= 50) then
    begin
       W_Reale('IND_ENERG_B', DatiAtt[gencor-1].QKW, 2);
       W_Reale('FEN_B',       DatiAtt[gencor-1].FEN, 2);
    end
    else
    if (DatiAtt[gencor-1].QKW > 50) and (DatiAtt[gencor-1].QKW <= 70) then
    begin
       W_Reale('IND_ENERG_C', DatiAtt[gencor-1].QKW, 2);
       W_Reale('FEN_C',       DatiAtt[gencor-1].FEN, 2);
    end
    else
    if (DatiAtt[gencor-1].QKW > 70) and (DatiAtt[gencor-1].QKW <= 90) then
    begin
       W_Reale('IND_ENERG_D', DatiAtt[gencor-1].QKW, 2);
       W_Reale('FEN_D',       DatiAtt[gencor-1].FEN, 2);
    end
    else
    if (DatiAtt[gencor-1].QKW > 90) and (DatiAtt[gencor-1].QKW <= 120) then
    begin
       W_Reale('IND_ENERG_E', DatiAtt[gencor-1].QKW, 2);
       W_Reale('FEN_E',       DatiAtt[gencor-1].FEN, 2);
    end
    else
    if (DatiAtt[gencor-1].QKW > 120) and (DatiAtt[gencor-1].QKW <= 160) then
    begin
       W_Reale('IND_ENERG_F', DatiAtt[gencor-1].QKW, 2);
       W_Reale('FEN_F',       DatiAtt[gencor-1].FEN, 2);
    end
    else
    if (DatiAtt[gencor-1].QKW > 160) then
    begin
       W_Reale('IND_ENERG_G', DatiAtt[gencor-1].QKW, 2);
       W_Reale('FEN_G',       DatiAtt[gencor-1].FEN, 2);
    end;
   {$IFEND}
    CloseFileReport;
  end;

{-----------------------------------------------------------------------------
  Procedure:
  Author:    e.diquattro
  Date:      28-dic-2005
  Arguments: Not available
  Result:    Not available

  Cosa fa:  azzera i campi dei dati attestato
-----------------------------------------------------------------------------}
  Procedure AzzeraDatiAttestato;
  begin
   {$IF Defined(VERSIONE_12)}
    DatiAtt.Classif      := '';
   // DatiAtt.Localita     := '';
   // DatiAtt.Comune       := '';
    DatiAtt.Vl           := 0;
    DatiAtt.Sl           := 0;
    DatiAtt.SupL         := 0;
    DatiAtt.Sv           := 0;
    {DatiAtt.ZONA_GEO     := '';
    DatiAtt.REG_VENTO    := '';
    DatiAtt.ZONA_VENTO   := '';
    DatiAtt.ZONA_CLIMA   := '';
    DatiAtt.TEMP_ESTERNA := 0;
    DatiAtt.GRADI_GG     := 0; }
    DatiAtt.GIORNI_RISC  := 0;
    DatiAtt.ETA_DISTR    := 0;
    DatiAtt.ETA_EMISS    := 0;
    DatiAtt.ETA_REG      := 0;
    DatiAtt.ETA_GLOBALE  := 0;
    DatiAtt.CD           := 0;
    DatiAtt.QKW          := 0;
    DatiAtt.QMJ          := 0;
    DatiAtt.FEN          := 0;
    DatiAtt.VLim         := 0;
   {$ELSEIF Defined(VERSIONE_13)}
    DatiAtt[gencor-1].Classif      := '';
   // DatiAtt[gencor-1].Localita     := '';
   // DatiAtt[gencor-1].Comune       := '';
    DatiAtt[gencor-1].Vl           := 0;
    DatiAtt[gencor-1].Sl           := 0;
    DatiAtt[gencor-1].SupL         := 0;
    DatiAtt[gencor-1].Sv           := 0;
   { DatiAtt[gencor-1].ZONA_GEO     := '';
    DatiAtt[gencor-1].REG_VENTO    := '';
    DatiAtt[gencor-1].ZONA_VENTO   := '';
    DatiAtt[gencor-1].ZONA_CLIMA   := '';
    DatiAtt[gencor-1].TEMP_ESTERNA := 0;
    DatiAtt[gencor-1].GRADI_GG     := 0;  }
    DatiAtt[gencor-1].GIORNI_RISC  := 0;
    DatiAtt[gencor-1].ETA_DISTR    := 0;
    DatiAtt[gencor-1].ETA_EMISS    := 0;
    DatiAtt[gencor-1].ETA_REG      := 0;
    DatiAtt[gencor-1].ETA_GLOBALE  := 0;
    DatiAtt[gencor-1].CD           := 0;
    DatiAtt[gencor-1].QKW          := 0;
    DatiAtt[gencor-1].QMJ          := 0;
    DatiAtt[gencor-1].FEN          := 0;
    DatiAtt[gencor-1].VLim         := 0;
   {$IFEND}
  end;

  Procedure CreaConsumi;
  Var i:Integer;
  Const
    NomeMese: array[1..12] of string = ('Gennaio','Febbraio','Marzo','Aprile','Maggio',
                                        'Giugno','Luglio','Agosto','Settembre','Ottobre',
                                        'Novembre','Dicembre');
  Begin
    dm1.TT3.Close;
    dm1.tt3.databasename:=percorso_progetti;
    dm1.tt3.tablename:='consumi';
    dm1.tt3.open;
    for i:=1 to 12 do
    begin
     dm1.tt3.first;
     if not dm1.tt3.eof then dm1.tt3.delete;
    end;
    for i:=1 to 12 do
    begin
      dm1.tt3.append;
      dm1.tt3.edit;
      dm1.tt3.fieldbyname('Indmese').asinteger:=i;
      dm1.tt3.fieldbyname('Mese').asstring:=nomemese[i];
      dm1.tt3.Post;
    end;
  end;

  Procedure ChiudiConsumi;
  begin
    dm1.tt3.close;
  end;
end.
