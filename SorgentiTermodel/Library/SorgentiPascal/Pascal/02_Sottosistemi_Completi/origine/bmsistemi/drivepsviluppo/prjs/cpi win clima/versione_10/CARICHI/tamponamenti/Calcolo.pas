Unit Calcolo;

Interface

uses
     Graphics, ExtCtrls, Math, SysUtils,
     UVariabiliPareti, LibreriaGenerale, UdataLink, udb, LbSpeedButton;

Procedure InitParete;
Function  CALCOLOIGRO(Image : TImage; df:string; panel : TPanel; indmese:integer;grafico:boolean; Info: TLBSpeedButton):boolean;
Function  StratoInDCond(Indice: Integer; var IndSt: Integer; NomeStrato: String): Boolean;

Implementation

Uses Usolomuri, UgraficoIgro, Wizardusolomuri;

Type Tabcondensa = record
                     Ti,Uri,Te,Ure,Condens: real;
                   end;

Var
  Tabcond:  array[1..12] of Tabcondensa;
  Condenstotale, EvapTotale: real;
  V_NoCondInt: string;
  V_DeltaPA1: real;
  V_SiCondInt: string;
  V_Condensato: real;
  V_NoCondSup: string;
  V_DeltaPA2: real;
  pannello: TPanel;
  k: integer;
  Codice: String;
  IndPar: Integer;

Function StratoInDCond(Indice: Integer; var IndSt: Integer; NomeStrato: String): Boolean;
var
  i: Integer;
  Nome: String;
begin
 {$IFDEF VERSIONE_13}
  Result := False;
  IndSt := 0;
  if PInfoParRisIgro(TabellaRis.Items[indice]).NStrCond <> 0 then
  begin
    For i := 1 to PInfoParRisIgro(TabellaRis.Items[indice]).NStrCond do
    begin
      Nome := PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[i].CodStraT;
      if CompareStr(Nome, NomeStrato) = 0 then
      begin
         IndSt := i;
         Result := True;
      end;
    end;
  end;
 {$ENDIF} 
end;

Procedure InitParete;
begin
  with V_TabStruttura do
  begin
    Cond_Cont^.Ti:=Ti;
    Cond_Cont^.EsTI:=EsTI;
    Cond_Cont^.Te:=Te;
    Cond_Cont^.EsTE:=EsTE;
    Cond_Cont^.URi:=URi;
    Cond_Cont^.EsURI:=EsURI;
    Cond_Cont^.URe:=URe;
    Cond_Cont^.EsURE:=EsURE;
    Cond_Cont^.wind:=wind;
    Cond_Cont^.PercInc:=PercInc;
    Cond_Cont^.EsG:=EsG;
    Cond_Cont^.epson:=epson;
    Cond_Cont^.TipoStrut:=TipoStrut;
    Cond_Cont^.alfa:=HI;
    Cond_Cont^.beta:=HE;
    Cond_Cont^.alfa_10:=alfa;
    Cond_Cont^.beta_10:=beta;
    Cond_Cont^.st_vet:=st_vet;
  end;
end;

{------------------- Ricerca Parametri Materiale in Archivio -----------------}
procedure CarParCalc(Mese:integer; Grafico: Boolean);
var
    i,k: Smallint;
    f: file of Arch;
    Trovato: boolean;
    Cod: string;
begin
  CaricaParete(Mese, Grafico);
  if Cond_Cont^.ALFA = 0 then exit;
  if Cond_Cont^.beta = 0 then exit;
  for k:=1 to NumStrati do
  begin
      tabcalcolo^[k + 1].lamda   := ArcIgro^[k].lamda;
      tabcalcolo^[k + 1].cond    := ArcIgro^[k].cond;
      tabcalcolo^[k + 1].mu      := ArcIgro^[k].mu;
      tabcalcolo^[k + 1].densita := ArcIgro^[k].densita;
      tabcalcolo^[k + 1].ct      := ArcIgro^[k].ct;
      tabcalcolo^[k + 1].spes    := ArcIgro^[k].spes/100;
     {$IFDEF VERSIONE_13}
      tabcalcolo^[k + 1].desc    := ArcIgro^[k].nome;
     {$ENDIF}
  end;

  with tabcalcolo^[0] DO
  begin
   {'strato aria';}
   LAMDA:=0;
   DT:=0;
   Spes := 0;
   TF:= Cond_Cont^.Ti;
   Ps:=Pressat(TF);
   mu:=0;
   DP:=0;
   Pv:=(Ps*Cond_Cont^.URi)/100;
   Densita:=0;
   DS:=0;
   CT:=0;
   CTS:=0;
   RV:=0;
   Cond:=0;
   R:=1/Cond_Cont^.ALFA;
  {$IFDEF VERSIONE_13}
   desc:='';
  {$ENDIF} 
  end;

  with tabcalcolo^[1] DO
  begin
   {'strato liminare interno';}
   LAMDA:=0;
   DT:=0;
   Spes := 0;
   TF:= 0;
   Ps:=0;
   mu:=0;
   DP:=0;
   Pv:=0;
   Densita:=0;
   DS:=0;
   CT:=0;
   CTS:=0;
   RV:=0;
   Cond:=0;
   R:=1/Cond_Cont^.ALFA;
  {$IFDEF VERSIONE_13}
   desc:='Lim.Interno';
  {$ENDIF}
  end;

  WITH tabcalcolo^[NumStrati+2] DO
  begin
     {'strato liminare esterno';}
     LAMDA:=0;DT:=0;
     Spes := 0;
     tf:=Cond_Cont^.te;
     Ps:=Pressat(TF);
     mu:=0;DP:=0;Densita:=0;
     CT:=0;CTS:=0;RV:=0;Cond:=0;
     Pv:=(Ps*Cond_Cont^.URe)/100;
     R:=1/Cond_Cont^.BETA;
    {$IFDEF VERSIONE_13}
     desc:='Lim.esterno';
    {$ENDIF} 
  end;
end;

{------------------------- Inizializzazione Tabella Calcolo ------------------}
Procedure InitTabCalc;
var i:Smallint;

begin
  for i := -1 to MaxStrati - 1 do
      with tabcalcolo^[i] do
      begin
         LAMDA := 0; R := 0; DT := 0; TF := 0;
         Ps := 0;
         mu := 0; DP := 0; Pv := 0; Densita := 0;
         DS := 0; CT := 0; CTS := 0; RV := 0; Cond := 0;
      end;
end;

function CALCOLOIGRO(Image : TImage; df:string; panel : Tpanel; indmese:integer; grafico:boolean; Info: TLBSpeedButton): boolean;

    function Calcolomese(panel : Tpanel; indmese:integer;grafico:boolean; Info: TLBSpeedButton;indpar:integer; deb:boolean) : boolean;
    Const
     MuAria=1;
     Sigma0=2E-10;
    var
        I, j, MyI: Smallint;
        sptot, xiniz, spcor, dtps, condensmax, {$IFDEF VERSIONE_12} condensstrato, rvac, rvbc,{$ENDIF} spessore, MassaS, ValLim: real;
        sstemp, ZonaClimatica, Classif: string;
        PareteVerM, PareteVer192: Boolean;
    begin
     if Panel <> nil then
        Panel.visible:=False;
     if Info <> nil then
        Info.Visible := False;   
     result:=False;
     Trasm:=0;
     InitTabCalc;
     CarParCalc(indmese, grafico);

     with TabCond[indmese] do
     begin
       Ti  := Cond_Cont^.Ti;
       Te  := Cond_Cont^.Te;
       Uri := Cond_Cont^.Uri;
       Ure := Cond_Cont^.Ure;
     end;

     if Cond_Cont^.ALFA=0 then exit;
     if Cond_Cont^.beta=0 then exit;


     for i:=2 to NumStrati + 1 do
      with tabcalcolo^[i] do
       begin
          if Lamda <> 0 then R:=Spes/Lamda
          else
           if Cond <> 0 then R:=1/Cond
           else R:=0;
          if Mu <> 0 then Rv:=(mu*Spes)/(Gamma*exp(-12*ln(10)))
          else Rv:=0;
       end;

     RT:=0; RVT:=0;
     if (cond_cont^.alfa_10 <> 0) and (cond_Cont^.beta_10 <> 0) then
         rt10 := (1/cond_cont^.alfa_10)+(1/cond_cont^.beta_10)
     else rt10 := 0;
     for i:=1 to NumStrati+2 do
       with tabcalcolo^[i] do
       begin
         Rt:=Rt+R;
         Rvt:=Rvt+Rv;
         Ds:=Densita*spes;
       end;
     {$IFDEF VERSIONE_12}
      if Panel <> nil then
        Panel.visible:=false;
      if Info <> nil then
        Info.Visible := False;
     {$ENDIF}
     IF RVT = 0 THEN
     begin
         rvt:=1;
     end
     else
     begin
         for i:=2 to NumStrati + 1 do rt10:=rt10+tabcalcolo^[i].r;
         Trasm:=1/RT;
         dm1.tt1.edit;
         //Emanuela 16/6/2004 inserito l'incremento
         if not SameValue(V_tabstruttura.PercInc, 0, 0) then
            V_tabstruttura.Set_Trasmitt(RoundR(3,Trasm + (Trasm * V_tabstruttura.PercInc)/100))
         else V_tabstruttura.Set_Trasmitt(RoundR(3,Trasm));
         trasm10:=1/rt10;
         V_tabstruttura.Set_TrasmittL10(RoundR(3,Trasm10));
         //Emanuela 3/9/2004 calcolo lo spessore totale in modo che il suo aggiornamento
         //sia sempre visibile
         Spessore := 0.0;
         for i:=2 to NumStrati + 1  do
             Spessore := Spessore + tabcalcolo^[i].Spes;
         V_tabstruttura.Set_SpessoreParete(Spessore * 100);
         // Emanuela
         dm1.tt1.POst;
         tabcalcolo^[1].DT:=(tabcalcolo^[1].R/RT)*(Cond_Cont^.TI-Cond_Cont^.TE);
         Tabcalcolo^[1].Tf:=Cond_Cont^.Ti-tabcalcolo^[1].DT;
         tabcalcolo^[1].Ps:=Pressat(tabcalcolo^[1].Tf);
         tabcalcolo^[1].Pv:=(tabcalcolo^[0].Ps*Cond_Cont^.URi)/100;

         tabcalcolo^[NumStrati+2].Tf:=Cond_Cont^.Te;
         tabcalcolo^[NumStrati+2].Ps:=Pressat(Cond_Cont^.TE);
         tabcalcolo^[NumStrati+2].Pv:=(tabcalcolo^[NumStrati+2].Ps*Cond_Cont^.URe)/100;
         tabcalcolo^[NumStrati+2].DT:=(tabcalcolo^[NumStrati+2].R/RT)*(Cond_Cont^.TI-Cond_Cont^.TE);

        {$IFDEF VERSIONE_13}
         for i:=1 to NumStrati + 2 DO
        {$ELSE}
         for i:=2 to NumStrati + 1 DO
        {$ENDIF}
         begin
             tabcalcolo^[i].DT:=(tabcalcolo^[i].R/RT)*(Cond_Cont^.TI-Cond_Cont^.TE);
             tabcalcolo^[i].TF:=tabcalcolo^[i-1].TF-tabcalcolo^[i].DT;
             tabcalcolo^[i].Ps:=Pressat(tabcalcolo^[i].TF);
            {$IFDEF VERSIONE_13}
             tabcalcolo^[i].DP:=(tabcalcolo^[i].RV/RVT)*(tabcalcolo^[0].Pv-tabcalcolo^[NumStrati+2].Pv);
            {$ELSE}
             tabcalcolo^[i].DP:=(tabcalcolo^[i].RV/RVT)*(tabcalcolo^[1].Pv-tabcalcolo^[NumStrati+2].Pv);
            {$ENDIF}
             tabcalcolo^[i].Pv := tabcalcolo^[i-1].Pv - tabcalcolo^[i].DP;
             if Cond_Cont^.TI-Cond_Cont^.TE <> 0 then
             begin
               tabcalcolo^[i].CTS := tabcalcolo^[i].DS * tabcalcolo^[i].Ct*((tabcalcolo^[i-1].TF+
                                     tabcalcolo^[i].TF) * 0.5 - Cond_Cont^.TE)/(Cond_Cont^.TI-Cond_Cont^.TE)
             end
             else tabcalcolo^[i].CTS:=0;
         end;
         sptot:=0;
         FOR I:=2 TO Numstrati + 1 do
            sptot:=sptot+tabcalcolo^[i].spes*100;
         spcor:=0;
        {$IFDEF VERSIONE_12}
         RVAC:=0;
        {$ENDIF}
        // calcolo della gci nel caso di condensa
         FOR I:=1 TO Numstrati+2 do
         begin
            // Calcolo della condensa
            V_Condensato:=0;
           {$IFDEF VERSIONE_13}
            tabcalcolo^[i].SVAC:=0;
            tabcalcolo^[i].PVa:=tabcalcolo^[0].PV;
            for j:=1 to i do
            begin
              if (j<>i)and(tabcalcolo^[j].Ps < tabcalcolo^[j].Pv) then  // condensa in più strati 6.26 6.27
              begin
                tabcalcolo^[i].SVAC:=0;
                tabcalcolo^[i].PVa:=tabcalcolo^[j].PS
              end;
              tabcalcolo^[i].SVAC:=tabcalcolo^[i].SVAC + (tabcalcolo^[j].Mu/MUAria) * tabcalcolo^[j].spes;// S=spessore equivalente aria
            end;
            if (i<>0)and(i<>Numstrati+2) then
            begin
              tabcalcolo^[i].SVBC:=0;
              tabcalcolo^[i].PVb:=tabcalcolo^[Numstrati+2].PV;
              for j:=numstrati+1 downto i+1   do
              begin
                if (j<>i)and(tabcalcolo^[j].Ps < tabcalcolo^[j].Pv) then  // condensa in più strati 6.26 6.27
                begin
                  tabcalcolo^[i].SVBC:=0;
                  tabcalcolo^[i].PVb:=tabcalcolo^[j].Ps
                end;
                tabcalcolo^[i].SVBC:=tabcalcolo^[i].SVBC+(tabcalcolo^[j].Mu/muAria)*tabcalcolo^[j].spes;
              end;
              // 6.26 6.27
              if (tabcalcolo^[i].SVBC <> 0) and (tabcalcolo^[i].SVAC <> 0) then
                 tabcalcolo^[I].Gci := 24*3600*GiorniMese(indMese)*Sigma0*((tabcalcolo^[i].PVa-tabcalcolo^[I].Ps)/tabcalcolo^[i].SVAC-(tabcalcolo^[I].Ps-tabcalcolo^[i].PVb)/tabcalcolo^[i].SVBC)
              else
                 tabcalcolo^[I].Gci := 0;
            end else  tabcalcolo^[I].Gci := 0;
            {$ELSE}
              RVAC := RVAC+tabcalcolo^[I].RV;  
            {$ENDIF}
            if tabcalcolo^[i-1].Ps < tabcalcolo^[i-1].Pv then  // Formazione condensa
            begin
             {$IFDEF VERSIONE_12}
              if Panel <> nil then
              begin
                 Panel.visible:=true;
              end;
              if Info <> nil then
                Info.Visible := True;
             {$ENDIF}   
              V_SiCondInt := 'X'; 
              if (i=0)or(i=Numstrati+1) then
              begin
                V_NoCondSup:='';
                V_DeltaPA2:=0;
              end
              else
              begin
               {$IFDEF VERSIONE_13}
                if V_Condensato < tabcalcolo^[I].Gci then V_Condensato := Roundr(4,tabcalcolo^[I].Gci);
               {$ELSE}
                RVBC:=0;
                for j:=i+1 to numstrati+1 do
                RVBC:=RVBC+tabcalcolo^[j].RV;
                if (RVBC <> 0) and (RVAC <> 0) then
                   Condensstrato := 30*86400*((tabcalcolo^[0].PV-tabcalcolo^[I].PV)/RVAC-(tabcalcolo^[Numstrati+1].PV-tabcalcolo^[I].PV)/RVBC)
                else Condensstrato := 0;
                if V_Condensato<condensstrato then V_Condensato:=Roundr(4,condensstrato);
               {$ENDIF}
                V_NoCondInt:='';
                V_DeltaPA1:=0;
              end;
            end
            else
            begin
              if (i=0)or(i=Numstrati+1) then
              begin
                // 5-08-2004 Emanuela - Valori che devono essere calcolati solo nel caso in cui
                //                      il mese di riferimento è Gennaio.
                if IndMese = 1 then
                begin
                  if V_NoCondSup = 'X' then
                   if V_DeltaPA2 < (tabcalcolo^[i-1].Ps - tabcalcolo^[i-1].Pv)then
                      V_DeltaPA2 := tabcalcolo^[i-1].Ps - tabcalcolo^[i-1].Pv;
                end;
              end
              else
              begin
                if IndMese = 1 then
                begin
                 // 5-08-2004 Emanuela - Valori che devono essere calcolati solo nel caso in cui
                 //                      il mese di riferimento è Gennaio.
                  if V_NoCondInt = 'X' then
                  if V_DeltaPA1 < (tabcalcolo^[i-1].Ps - tabcalcolo^[i-1].Pv)then
                     V_DeltaPA1:=tabcalcolo^[i-1].Ps - tabcalcolo^[i-1].Pv;
                end;
              end
            end;
         end;
     end; {end else}

  {$IFDEF VERSIONE_13}
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[Indmese].Ti   := Cond_Cont^.Ti;
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[Indmese].URi  := Cond_Cont^.Uri;
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[Indmese].Te   := Cond_Cont^.Te;
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[Indmese].URe  := Cond_Cont^.Ure;
  {$ENDIF}

  dm1.TT1.Edit;
  // Calcolo delle verifiche di legge della 192
  If IndMese = 1 then
  begin
     PareteVerM := False;
     PareteVer192 := False;
   //Emanuela 9-11-2005 calcolo della massa superficiale
     MassaS := 0;
     for Myi := 2 to NumStrati + 1 do
          MassaS := MassaS + (tabcalcolo^[Myi].spes * tabcalcolo^[Myi].densita);
     V_tabstruttura.Set_MassaSup(MassaS);
   {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    if Calcolo192 then
    begin
     V_TabStruttura.Set_ValLimM(230);
     //Emanuela 9-11-2005 controllo della massa superficiale secondo il comma 11 del
     //decreto 19-8-2005 n. 192
     if ((CompareStr(UpperCase(V_TabStruttura.interest), 'ESTERNA') = 0) and
          (CompareStr(UpperCase(V_TabStruttura.Categoria),'OPACO') = 0) and
          (CompareStr(UpperCase(V_TabStruttura.parsof),   'PARETE') = 0))
     then
        PareteVerM := True
     else if((CompareStr(Uppercase(V_TabStruttura.SeparaAlloggi), Uppercase('Divisorio separazione tra alloggi')) = 0) and
              (CompareStr(UpperCase(V_TabStruttura.interest), 'INTERNA') = 0) and
              (CompareStr(UpperCase(V_TabStruttura.Categoria),'OPACO') = 0))
          then PareteVerM := False
          else
            if (CompareStr(UpperCase(V_TabStruttura.interest), 'ESTERNA') = 0) and
               (CompareStr(UpperCase(V_TabStruttura.Categoria),'OPACO') = 0)   and
               (CompareStr(UpperCase(V_TabStruttura.parsof),   'SOFFITTO') = 0)
            then PareteVerM := True
            else
             if (CompareStr(UpperCase(V_TabStruttura.interest), 'ESTERNA') = 0) and
                (CompareStr(UpperCase(V_TabStruttura.Categoria),'OPACO') = 0)   and
                (CompareStr(UpperCase(V_TabStruttura.parsof),   'PAVIMENTO') = 0)
             then PareteVerM := True;
      if PareteVerM then
      begin
        if  V_TabStruttura.MassaSup >= 230 then
            V_tabstruttura.Set_VerificaMassaS('SI')
        else
            V_tabstruttura.Set_VerificaMassaS('NO');
      end
      else V_tabstruttura.Set_VerificaMassaS('--');
      if WizardFSoloMuri <> nil then
      begin
       if not (
                ((CompareStr(UpperCase(V_TabStruttura.interest), 'INTERNA') = 0) and
                 (CompareStr(UpperCase(V_TabStruttura.SeparaAlloggi), UpperCase('Divisorio separazione tra locali')) = 0))
                 or
                ((CompareStr(UpperCase(V_TabStruttura.interest), 'INTERNA') = 0) and
                 ((CompareStr(UpperCase(V_TabStruttura.parsof),  'SOFFITTO') = 0) or (CompareStr(UpperCase(V_TabStruttura.parsof), 'PAVIMENTO') = 0)) and
                 (CompareStr(UpperCase(V_TabStruttura.SeparaAlloggi), UpperCase('Divisorio separazione tra alloggi')) = 0))

               )
        then
        begin
           if PareteVerM then
           begin
             WizardFSoloMuri.lb_dpr192.Visible := True;
             WizardFSoloMuri.ST_VerMS.Visible := True;
             WizardFSoloMuri.LBSB_InfoMS192.Visible := True;
             if  V_TabStruttura.MassaSup >= 230 then
             begin
               WizardFSoloMuri.ST_VerMS.Color := $0000B700;
               WizardFSoloMuri.ST_VerMS.Caption := 'Positiva';
             end
             else
             begin
               WizardFSoloMuri.ST_VerMS.Color := $000000DF;
               WizardFSoloMuri.ST_VerMS.Caption := 'Negativa';
             end;
           end
           else
           begin
             WizardFSoloMuri.lb_dpr192.Visible := False;
             WizardFSoloMuri.ST_VerMS.Visible := False;
             WizardFSoloMuri.LBSB_InfoMS192.Visible := False;
           end;
       end
       else
       begin
             WizardFSoloMuri.lb_dpr192.Visible := False;
             WizardFSoloMuri.ST_VerMS.Visible := False;
             WizardFSoloMuri.LBSB_InfoMS192.Visible := False;
       end;
     end;
    end
    else
    begin
     if WizardFSoloMuri <> nil then
     begin
      WizardFSoloMuri.lb_dpr192.Visible := False;
      WizardFSoloMuri.St_VerMS.Visible := False;
      WizardFSoloMuri.LBSB_InfoMS192.Visible := False;
      V_tabstruttura.Set_VerificaMassaS('--');
     end; 
    end;
   {$IFEND}

   {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    if Calcolo192 then
    begin
     //Emanuela DPR 192
     ZonaClimatica := Info_ZonaClimatica_Fabbricato;
     Classif := Info_Classificazione_Fabbricato;
     if (CompareStr(UpperCase(V_TabStruttura.interest), 'ESTERNA') = 0) and
        (CompareStr(UpperCase(V_TabStruttura.parsof),   'PARETE') = 0) and
        (CompareStr(UpperCase(V_TabStruttura.Categoria),'OPACO') = 0)
     then
     begin
       if CompareStr(UpperCase(Classif), 'E8') <> 0 then
       begin
           case ZonaClimatica[1] of
             'A': ValLim := Tab2[1];
             'B': ValLim := Tab2[2];
             'C': ValLim := Tab2[3];
             'D': ValLim := Tab2[4];
             'E': ValLim := Tab2[5];
             'F': ValLim := Tab2[6];
           end;
           PareteVer192 := True;
       end;
     end
     else
       if (CompareStr(UpperCase(V_TabStruttura.interest), 'ESTERNA') = 0) and
          (CompareStr(UpperCase(V_TabStruttura.Categoria),'OPACO') = 0) and
          ((CompareStr(UpperCase(V_TabStruttura.parsof),   'SOFFITTO') = 0) or
           (CompareStr(UpperCase(V_TabStruttura.parsof),   'PAVIMENTO') = 0))
       then
       begin
         if CompareStr(UpperCase(Classif), 'E8') <> 0 then
         begin
         //modifica 311 diego
         if CompareStr(UpperCase(V_TabStruttura.parsof),   'SOFFITTO') = 0
           case ZonaClimatica[1] of
             'A': ValLim := Tab3[1];
             'B': ValLim := Tab3[2];
             'C': ValLim := Tab3[3];
             'D': ValLim := Tab3[4];
             'E': ValLim := Tab3[5];
             'F': ValLim := Tab3[6];
           end
         else
           case ZonaClimatica[1] of
             'A': ValLim := Tab3a[1];
             'B': ValLim := Tab3a[2];
             'C': ValLim := Tab3a[3];
             'D': ValLim := Tab3a[4];
             'E': ValLim := Tab3a[5];
             'F': ValLim := Tab3a[6];
           end
           PareteVer192 := True;
         end;
       end
       else
         if (CompareStr(UpperCase(V_TabStruttura.interest), 'ESTERNA') = 0) and
            (CompareStr(UpperCase(V_TabStruttura.Categoria),'TRASPARENTE') = 0) and
            (CompareStr(UpperCase(V_TabStruttura.parsof),   'PARETE') = 0) then
         begin
           case ZonaClimatica[1] of
             'A': ValLim := Tab4b[1];
             'B': ValLim := Tab4b[2];
             'C': ValLim := Tab4b[3];
             'D': ValLim := Tab4b[4];
             'E': ValLim := Tab4b[5];
             'F': ValLim := Tab4b[6];
           end;
           PareteVer192 := True;
         end
         else
         if (CompareStr(UpperCase(V_TabStruttura.interest), 'INTERNA') = 0)
         then
         begin
          if (CompareStr(UpperCase(V_TabStruttura.SeparaAlloggi), UpperCase('Divisorio separazione tra alloggi')) = 0) and
             (CompareStr(UpperCase(V_TabStruttura.parsof), 'PARETE') = 0)
          then
          begin
            if CompareStr(UpperCase(Classif), 'E1(1)') = 0 then
            begin
              case ZonaClimatica[1] of
                 'A': ValLim := Tab2[1];
                 'B': ValLim := Tab2[2];
                 'C': ValLim := 0.8;
                 'D': ValLim := 0.8;
                 'E': ValLim := 0.8;
                 'F': ValLim := 0.8;
              end;
              PareteVer192 := True;
            end;
          end
          else
          begin
            PareteVer192 := False;
            if WizardFSoloMuri <> nil then
            begin
              WizardFSoloMuri.St_Ver.Visible := False;
              WizardFSoloMuri.LB_InfoVer.Visible := False;
              WizardFSoloMuri.Label5.Visible := False;
              WizardFSoloMuri.Lb_ValLim.Visible := False;
              WizardFSoloMuri.ED_ValLim.Visible := False;
            end;  
          end;
         end;
      if ValLim = 0 then V_tabstruttura.Set_Verifica192('--')
      else
      begin
        if  V_TabStruttura.Trasmitt > ValLim then
            V_tabstruttura.Set_Verifica192('NO')
        else V_tabstruttura.Set_Verifica192('SI');
      end;
      V_TabStruttura.Set_ValLimT(ValLim);
      if WizardFSoloMuri <> nil then
      begin
        if not (
                ((CompareStr(UpperCase(V_TabStruttura.interest), 'INTERNA') = 0) and
                 (CompareStr(UpperCase(V_TabStruttura.SeparaAlloggi), UpperCase('Divisorio separazione tra locali')) = 0))
                 or
                ((CompareStr(UpperCase(V_TabStruttura.interest), 'INTERNA') = 0) and
                 ((CompareStr(UpperCase(V_TabStruttura.parsof),  'SOFFITTO') = 0) or (CompareStr(UpperCase(V_TabStruttura.parsof), 'PAVIMENTO') = 0)) and
                 (CompareStr(UpperCase(V_TabStruttura.SeparaAlloggi), UpperCase('Divisorio separazione tra alloggi')) = 0))

               )
        then
        begin
            if PareteVer192 then
            begin
              if  V_TabStruttura.Trasmitt > ValLim then
              begin
                WizardFSoloMuri.St_Ver.Brush.Color := $000000DF;
                WizardFSoloMuri.St_Ver.Caption := 'Negativa';
              end
              else
              begin
                WizardFSoloMuri.St_Ver.Brush.Color := $0000B700;
                WizardFSoloMuri.St_Ver.Caption := 'Positiva';
              end;
            end
            else
            begin
              WizardFSoloMuri.St_Ver.Brush.Color := $0000B700;
              WizardFSoloMuri.St_Ver.Caption := 'Positiva';
            end;
            WizardFSoloMuri.ED_ValLim.Text := FloatToStr(ValLim);
            WizardFSoloMuri.ST_Ver.Visible := True;
            WizardFSoloMuri.LB_InfoVer.Visible := True;
            WizardFSoloMuri.Label5.Visible := True;
            WizardFSoloMuri.Lb_ValLim.Visible := True;
            WizardFSoloMuri.ED_ValLim.Visible := True;
        end;
      end;
     end
     else
     begin
      if WizardFSoloMuri <> nil then
      begin
        WizardFSoloMuri.ST_Ver.Visible := False;
        WizardFSoloMuri.LB_InfoVer.Visible := False;
        WizardFSoloMuri.Label5.Visible := False;
        WizardFSoloMuri.Lb_ValLim.Visible := False;
        WizardFSoloMuri.ED_ValLim.Visible := False;
      end;  
     end;
    {$IFEND}
  end;
  // Definizione del grafico
  if (NumStrati <> 0) and (sptot <> 0) then
  begin
   FOR I:=0 TO Numstrati+2 do
    With tabcalcolo^[i] do
    begin
      if (i=0) and grafico then
      begin
        lineatemp(Image, -5,TF+dt,0,TF,sptot,1);
        lineapres(Image, -5,pv,0,pv,sptot,2);
        lineapres(Image, -5,Pressat(Cond_Cont^.TI),0,ps,sptot,3);
      end
      else
      begin
        if (i=Numstrati+2) and grafico then
        begin
          lineatemp(Image, sptot,TF+dt,sptot+5,TF,sptot,1);
          lineaPres(Image, sptot,tabcalcolo^[i-1].Pv,sptot+5,pv,sptot,2);
          lineaPres(Image, sptot,tabcalcolo^[i-1].Ps,sptot+5,ps,sptot,3);
        end
        else
          begin
               if Grafico then
                  begin
                       lineatemp(Image, spcor,TF+dt,spcor+spes*100,TF,sptot,1);
                       lineaPres(Image, spcor,tabcalcolo^[i-1].Pv,spcor+spes*100,pv,sptot,2);
                       lineaPres(Image, spcor,tabcalcolo^[i-1].Ps,spcor+spes*100,ps,sptot,3);
                  end;
               spcor:=spcor+spes*100;
          end;
      end;
    end;
  end;  
 {$IFDEF VERSIONE_12}
   // se c'è condensa ritorno true
  if Panel <> nil then
     Result := Panel.visible
  else Result := False;
 {$ENDIF}
end; // end calcolomese

{$IFDEF VERSIONE_13}
procedure OutDati(var PanelC: TPanel; var Info: TLBSpeedButton);
Const
  deb = False;
Var
  i, j, k, indS, IndCl: Integer;
  Fdeb: TextFile;
  Condensa, GCIP, GCIN, FrsiM, MaxCL: Real;
  MeseC, MeseIniziale, Mis: Integer;
  Trovato, PresCond: Boolean;
  Nome, NomeSTP: String;
begin
  if Panel <> Nil then
     Panel.Visible := False;
  if Info <> Nil then
     Info.Visible := False;

  //Emanuela: identificazione degli strati in cui si forma condensa
  for I := 1 to Numstrati+1 do
  begin
    Trovato := False;
    Condensa := 0;
    GCIP := 0;
    GCIN := 0;
    for J := 1 to 12 do
    begin
      with tabcalcolomesi[j] do
      begin
        if tabcalcolo[I].Gci < 0 then GCIN := GCIN +  abs(tabcalcolo[I].Gci)
        else GCIP := GCIP +  tabcalcolo[I].Gci;
        if (tabcalcolo[i].Ps < tabcalcolo[i].Pv) and (tabcalcolo[I].Gci > 0) then
        begin
          Trovato := True;
          if Condensa < tabcalcolo[I].Gci then
          begin
             Condensa := tabcalcolo[I].Gci;
             MeseC := j;
          end;
        end;
      end;
    end;
    if Trovato then
    begin
      PInfoParRisIgro(TabellaRis.Items[indPar]).CondInt := True;
      inc(PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond);
      Nome := IntToStr(I) + '-' + tabcalcolomesi[1].tabcalcolo[I].Desc;
      NomeStP := tabcalcolomesi[1].tabcalcolo[I-1].Desc;
      PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond].CodStraT := Nome;
      PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond].CodStraP := NomeStP;
      PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond].CondensaInt := Condensa;
      PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond].MeseCondI := RestituisciMese(MeseC);
      if GCIP < GCIN then
      begin
         PInfoParRisIgro(TabellaRis.Items[indPar]).Evap := True;
         PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond].QNoEvap := 0
      end
      else
      begin
        PInfoParRisIgro(TabellaRis.Items[indPar]).Evap := False;
        PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond].QNoEvap := GCIP - GCIN;
      end;
    end
  end;

  if deb then
  begin
    assign(Fdeb, IncludeTrailingPathDelimiter(Percorsodrive) + inttostr(indpar) + '.deb');
    rewrite(Fdeb);
    writeln(Fdeb,'Composizione parete , strati:'+inttostr(NumStrati));
    for I:=1 to Numstrati+2 do
      with tabcalcolomesi[2] do
      begin
        write(Fdeb,'     Strato:'+inttostr(I));
        write(Fdeb,' R:'+float_to_str(tabcalcolo[I].r,4));
        write(Fdeb,' mu:'+float_to_str(tabcalcolo[I].mu,2));
        write(Fdeb,' spes:'+float_to_str(tabcalcolo[I].spes,5));
        write(Fdeb,' Si:'+float_to_str((tabcalcolo[I].Mu)*tabcalcolo[I].spes,4));
        writeln(Fdeb,' :'+tabcalcolo[I].Desc);
      end;
    writeln(fdeb,'');
    writeln(fdeb,'Riepilogo delle condizioni igrometriche e condenza');
    writeln(fdeb,'');
  end;

  //Emanuela Indicazione del mese iniziale per ogni strato
  For I:=1 to Numstrati do
  begin
    MeseIniziale := 13;
    Trovato := False;
    PresCond := StratoInDCond(indPar, inds, IntToStr(I) + '-' + tabcalcolomesi[1].tabcalcolo[I].Desc);
    if PresCond then
    begin
      J := 10;
      while (not Trovato) and (j <= 12) do
      begin
         if tabcalcolomesi[j].Tabcalcolo[i].Gci > 0 then
         begin
           Trovato := True;
           MeseIniziale := j;
         end;
         inc(j);
      end;
      if MeseIniziale = 13 then
      begin
        j := 1;
        while (not Trovato) and (j <= 9) do
        begin
         if tabcalcolomesi[j].Tabcalcolo[i].Gci > 0 then
         begin
           Trovato := True;
           MeseIniziale := j;
         end;
         inc(j);
        end;
      end;
      if Trovato then
         PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[inds].MesInC := MeseIniziale;
    end;
  end;

  //Emanuela Indicazione del mese iniziale per la parete
  For I:=1 to PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond do
  begin
    MeseIniziale := 1;
    Mis := PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[i].MesInC;
    if MeseIniziale < Mis then
       MeseIniziale := Mis;
    PInfoParRisIgro(TabellaRis.Items[indPar]).MeseIn := MeseIniziale;
  end;

  For J:=1 to 12 do
    For I:=1 to Numstrati do
      tabcalcolomesi[J].Tabcalcolo[I].Mai:=0;

  // Emanuela Calcolo delle Mai per ogni strato
  for I:=1 to Numstrati+1 do
  begin
   PresCond := StratoInDCond(indPar, indS, IntToStr(I) + '-' + tabcalcolomesi[1].tabcalcolo[I].Desc);
   if PresCond then
   begin
      For J := PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[inds].MesInC to 12 do
      begin
        GCIP := roundTo(tabcalcolomesi[j].Tabcalcolo[I].GCi, -5);
        if j = PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[inds].MesInC then
           tabcalcolomesi[j].Tabcalcolo[I].Mai := GCIP
        else
        if j = 1 then
           tabcalcolomesi[j].Tabcalcolo[I].Mai := tabcalcolomesi[12].Tabcalcolo[I].Mai + GCIP
        else
           tabcalcolomesi[j].Tabcalcolo[I].Mai := tabcalcolomesi[j-1].Tabcalcolo[I].Mai + GCIP;
        if tabcalcolomesi[j].Tabcalcolo[I].Mai < 0 then
           tabcalcolomesi[j].Tabcalcolo[I].Mai := 0;
      end;

      For J := 1 to PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[inds].MesInC - 1 do
      begin
        GCIP := roundTo(tabcalcolomesi[j].Tabcalcolo[I].GCi, -5);
        if j = 1 then
          tabcalcolomesi[j].Tabcalcolo[I].Mai := tabcalcolomesi[12].Tabcalcolo[I].Mai + GCIP
        else
          tabcalcolomesi[j].Tabcalcolo[I].Mai := tabcalcolomesi[j-1].Tabcalcolo[I].Mai + GCIP;
        if tabcalcolomesi[j].Tabcalcolo[I].Mai < 0 then
           tabcalcolomesi[j].Tabcalcolo[I].Mai:=0;
      end;
   end
   else
    for j := 1 to 12 do
        tabcalcolomesi[j].Tabcalcolo[I].Mai:=0;
  end;

  // Emanuela azzero correttamente i GCI non influenti
  for I:=1 to Numstrati+1 do
  begin
   PresCond := StratoInDCond(indPar, indS, IntToStr(I) + '-' + tabcalcolomesi[1].tabcalcolo[I].Desc);
   if PresCond then
   begin
     for j := 1 to 12 do
     begin
       if j <> PInfoParRisIgro(TabellaRis.Items[indPar]).DCond[inds].MesInC then
       begin
         if j = 1 then
         begin
           If tabcalcolomesi[12].tabcalcolo[I].Mai = 0  then
              tabcalcolomesi[j].Tabcalcolo[I].Gci := 0;
         end
         else
         begin
           If tabcalcolomesi[j-1].tabcalcolo[I].Mai = 0 then
              tabcalcolomesi[j].Tabcalcolo[I].Gci := 0;
         end;
       end;
     end;  
    end
    else
     for j := 1 to 12 do
        tabcalcolomesi[j].Tabcalcolo[I].Gci := 0;
  end;

  // Emanuela Calcolo della Ma e della GA e dell'frsi mese per mese
  // Caricamento dati per la stampa
  InitDatiCondSup;
  for j := 1 to 12 do
  begin
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Pi   := tabcalcolomesi[j].tabcalcolo[1].Pv;
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Pe   := tabcalcolomesi[j].tabcalcolo[Numstrati+2].Pv;
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].TMin := 0;
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].FRSI := 0;
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC   := 0;
    PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].Ma   := 0;
    TabCondSup[j].Te  := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Te;
    TabCondSup[j].Ure := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].URe/100;
    TabCondSup[j].Ti  := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Ti;
    TabCondSup[j].Pe  := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Pe;
  end;

  //Emanuela Calcolo di GC

   for i := 2 to numstrati do
   begin
    PresCond := StratoInDCond(indPar, indS,IntToStr(I) + '-' + tabcalcolomesi[1].tabcalcolo[i].Desc);
    if PresCond then
    begin
     for j := PInfoParRisIgro(TabellaRis.Items[indPar]).MeseIn to 12 do
     begin
       with tabcalcolomesi[j] do
       begin
        GCIP := roundTo(tabcalcolo[i].Gci, -5);
        if j = PInfoParRisIgro(TabellaRis.Items[indPar]).MeseIn then
          PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC + GCIP
        else
         if j = 1 then
         begin
           PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC + GCIP
         end
         else
         begin
             PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC + GCIP;
         end;
        end;
       end;
     end;
   end;

   for i := 2 to numstrati do
   begin
    PresCond := StratoInDCond(indPar, indS, IntToStr(I) + '-' + tabcalcolomesi[1].tabcalcolo[i].Desc);
    for j := 1 to PInfoParRisIgro(TabellaRis.Items[indPar]).MeseIn - 1 do
    begin
      if PresCond then
      begin
       GCIP := roundTo(tabcalcolomesi[j].tabcalcolo[i].Gci, -5);
       if j = 1 then
       begin
         PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC + GCIP
       end
       else
       begin
         PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].GC + GCIP;
       end;
      end;
   end;
  end;

  //Emanuela Calcolo di MA
   for i := 2 to numstrati do
   begin
    PresCond := StratoInDCond(indPar, indS, IntToStr(I) + '-' + tabcalcolomesi[1].tabcalcolo[i].Desc);
    if PresCond then
      for j := PInfoParRisIgro(TabellaRis.Items[indPar]).MeseIn to 12 do
          PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].Ma := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].Ma + tabcalcolomesi[j].tabcalcolo[i].Mai;
   end;

   for i := 2 to numstrati do
   begin
    PresCond := StratoInDCond(indPar, indS, IntToStr(I) + '-' + tabcalcolomesi[1].tabcalcolo[i].Desc);
    if PresCond then
    begin
     for j := 1 to PInfoParRisIgro(TabellaRis.Items[indPar]).MeseIn - 1 do
         PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].Ma := PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].Ma + tabcalcolomesi[j].tabcalcolo[i].Mai;
    end;
   end;

  for j := PInfoParRisIgro(TabellaRis.Items[indPar]).MeseIn to 12 do
  begin
    if deb then   //Stampafile di report dettagliato
    begin
        write(fdeb,' Mese:' + inttostr(J));
        write(Fdeb,' Ti:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Ti,2));
        write(Fdeb,' URi:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].URI,2));
        write(Fdeb,' TE:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].TE,2));
        write(Fdeb,' URe:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].URE,2));
        write(Fdeb,' PI:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Pi,2));
        write(Fdeb,' PE:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].PE,2));
        write(Fdeb,' GC:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Gc,8));
        write(Fdeb,' Ma:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Ma,8));
        writeln(fdeb,'');
    end;
  end;

  for j := 1 to PInfoParRisIgro(TabellaRis.Items[indPar]).MeseIn - 1 do
  begin
    if deb then   //Stampafile di report dettagliato
    begin
        write(fdeb,' Mese:' + inttostr(J));
        write(Fdeb,' Ti:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Ti,2));
        write(Fdeb,' URi:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].URI,2));
        write(Fdeb,' TE:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].TE,2));
        write(Fdeb,' URe:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].URE,2));
        write(Fdeb,' PI:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Pi,2));
        write(Fdeb,' PE:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].PE,2));
        write(Fdeb,' GC:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Gc,8));
        write(Fdeb,' Ma:'+float_to_str(PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[J].Ma,8));
        writeln(fdeb,'');
    end;
  end;

  if numstrati <> 0 then
  begin
    //Emanuela: identificazione della condenza superficiale
    IndCl := ClasseDiUmidita;
    case IndCl of
        1: MaxCl := 270;
        2: MaxCl := 540;
        3: MaxCl := 810;
        4: MaxCl := 1080;
        5: MaxCl := 1080;
    end;
    for j := 1 to 12 do
    begin
      if IndCl = 5 then
        TabCondSup[j].DeltaPe := 1080
      else
      if (TabCondSup[j].Te >= -5) and (TabCondSup[j].Te <= 0) then
        TabCondSup[j].DeltaPe := MaxCl
      else
        if (TabCondSup[j].Te > 0) and (TabCondSup[j].Te <= 20) then
          TabCondSup[j].DeltaPe := MaxCl - (TabCondSup[j].Te *  MaxCl/20)
        else
        if TabCondSup[j].Te > 20 then
           TabCondSup[j].DeltaPe := 0;
      TabCondSup[j].PI   := TabCondSup[j].Pe + (TabCondSup[j].DeltaPe * 1.10);
      TabCondSup[j].Psi  := TabCondSup[j].PI / 0.8;
      TabCondSup[j].Tsi  := CalcoloTemp(TabCondSup[j].Psi);
      if (TabCondSup[j].Ti - TabCondSup[j].Te) <> 0 then
      begin
        if TabCondSup[j].TE <= 20 then
           TabCondSup[j].Frsi := (TabCondSup[j].Tsi - TabCondSup[j].Te)/(TabCondSup[j].Ti - TabCondSup[j].Te)
        else TabCondSup[j].Frsi := 0;
      end
      else TabCondSup[j].Frsi := 0;
      if TabCondSup[j].Frsi < 0 then TabCondSup[j].Frsi := 0;
      PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].TMin := TabCondSup[j].Tsi;
      PInfoParRisIgro(TabellaRis.Items[indPar]).Dati[j].FRSI := TabCondSup[j].Frsi;
    end;

    FrsiM := TabCondSup[1].FRSI;
    PInfoParRisIgro(TabellaRis.Items[indPar]).MeseSup := 'Gennaio';
    for j := 2 to 12 do
      if TabCondSup[j].FRSI > FrsiM then
      begin
         PInfoParRisIgro(TabellaRis.Items[indPar]).MeseSup := RestituisciMese(j);
         FrsiM := TabCondSup[j].FRSI;
      end;

    if (v_Tabstruttura.Trasmitt <> 0) and (v_Tabstruttura.beta <> 0) then
       PInfoParRisIgro(TabellaRis.Items[indPar]).FRSI := ((1/v_Tabstruttura.Trasmitt) - (1/v_Tabstruttura.beta)) / (1/v_Tabstruttura.Trasmitt);
    PInfoParRisIgro(TabellaRis.Items[indPar]).FrsiM := FrsiM;

    if CompareValue(FrsiM, PInfoParRisIgro(TabellaRis.Items[indPar]).FRSI, 0.0005) > 0 then
       PInfoParRisIgro(TabellaRis.Items[indPar]).CondSup := True;
  end;
  
  if PInfoParRisIgro(TabellaRis.Items[indPar]).CondInt or PInfoParRisIgro(TabellaRis.Items[indPar]).CondSup then
  begin
    if Panel <> Nil then
       Panel.Visible := True;
    if Info <> Nil then
       Info.Visible := True;
  end;

  if Deb then
  begin
    writeln(fdeb,'');
    writeln(fdeb,'Dettaglio per strato.(formula 22)');
    writeln(fdeb,'');
    for I := 1 to Numstrati+1 do
    begin
      write(Fdeb,'     Strato:'+inttostr(I));
      writeln(Fdeb,' :' + tabcalcolomesi[1].tabcalcolo[I].Desc);

      for J := 1 to 12 do
        with tabcalcolomesi[j] do
        begin
            if i<=Numstrati+1 then
            begin
              if tabcalcolo[i].Ps < tabcalcolo[i].Pv then
                 write(Fdeb,'*')
              else write(Fdeb,' ');
              write(Fdeb,'Mese'+Inttostr(J));
              write(Fdeb,' Pv:'+float_to_str(tabcalcolo[I].Pv,1));
              write(Fdeb,' Ps:'+float_to_str(tabcalcolo[I].Ps,1));
              write(Fdeb,' SAc:'+float_to_str(tabcalcolo[i].SVac,4));
              write(Fdeb,' Pva:'+float_to_str(tabcalcolo[i].Pva,1));
              write(Fdeb,' ScB:'+float_to_str(tabcalcolo[i].SVBc,4));
              write(Fdeb,' Pvb:'+float_to_str(tabcalcolo[i].Pvb,1));
              write(Fdeb,' GCi:'+float_to_str(tabcalcolo[I].Gci,5));
              write(Fdeb,' MAi:'+float_to_str(tabcalcolo[I].Mai,5));
            end;
            writeln(Fdeb,' ');
        end;
      if i = Numstrati+1 then
        begin
        write(Fdeb,'     Strato:'+inttostr(I+1));
        writeln(Fdeb,' :'+tabcalcolomesi[1].tabcalcolo[I+1].Desc);
        end;
      end;
    end;
   if deb then close(fdeb);
end;
{$ENDIF}

begin
  V_NoCondInt  := 'X';
  V_DeltaPA1   := 0;
  V_SiCondInt  := '';
  V_Condensato := 0;
  V_NoCondSup  := 'X';
  V_DeltaPA2   := 0;

{$IFDEF VERSIONE_13}
  IndPar := CercaIndiceTabella(dm1.TT1.FieldByName('Codice').AsString);
  if TabellaRis.Count <> 0 then
     PInfoParRisIgro(TabellaRis.Items[indPar]).NStrCond := 0;
{$ENDIF}
 if (CompareStr(UpperCase(v_TabStruttura.interest) , 'INTERNA') <> 0) then
 begin
  for k:=1 to 12 do
  begin
   {$IFDEF VERSIONE_13}
     if TabellaRis.Count <> 0 then
     begin
      Calcolomese(panel, k, False, Info, indpar, False);
      TabCalcolomesi[k].Tabcalcolo := Tabcalcolo^;
     end;
   {$ELSE}
    Calcolomese(panel, k, False, Info, 0, false);
   {$ENDIF}
    Tabcond[k].Condens:=V_condensato;
  end;
 {$IFDEF VERSIONE_13}
   if (TabellaRis.Count <> 0) and (v_TabStruttura.SpessoreParete <> 0) then
      OutDati(panel, Info);
 {$ENDIF}
  Condenstotale:=0;
  for k:=1 to 12 do Condenstotale:=Condenstotale+Tabcond[k].condens;
 end;
  
  with V_TabStruttura do
  begin
    dm1.TT1.edit;
    Set_NoCondInt(V_NoCondInt);
    Set_DeltaPA1(V_DeltaPA1);
    Set_SiCondInt(V_SiCondInt);
    Set_Condensato(Condenstotale);
    Set_NoCondSup(V_NoCondSup);
    Set_DeltaPA2(V_DeltaPA2);
    dm1.TT1.post;
  end;
 {$IFDEF VERSIONE_13}
  if TabellaRis.Count <> 0 then
  begin
     Calcolomese(nil, indmese, grafico, nil, indpar, False);
     Result := PInfoParRisIgro(TabellaRis.Items[indPar]).CondInt or PInfoParRisIgro(TabellaRis.Items[indPar]).CondSup;
  end;   
 {$ELSE}
  Result := Calcolomese(panel, indmese, grafico, info, 0, False);
 {$ENDIF}
end;
{-------------------------- Caricamento Tabella Calcoli ----------------------}

Procedure CALCPond(df:string);
var I:Smallint;

  begin
     Trasm:=0;
     InitTabCalc;
     CarParCalc(1,false);
     if(tabePond^[1].Nome <> '') and (tabePond^[1].S <> 0) or (tabePond^[2].Nome <> '') and (tabePond^[1].Nome <> '') and
       (tabePond^[1].S = 0) then
      begin
         for i:=1 to MaxStrati-1 do
          with tabcalcolo^[i] do
           begin
              Spes:=tabePond^[i].S;
              if Lamda <> 0 then R:=Spes/Lamda
              else
               if Cond <> 0 then R:=1/Cond
               else R:=0;
           end;

         RT:=0;

         for i:=1 to MaxStrati-1 do
           with tabcalcolo^[i] do
            begin
              if tabePond^[i].Cod > '' then
               begin
                  tabePond^[i].Tras:=1/(R+tabcalcolo^[0].R+tabcalcolo^[MaxStrati].R);
                  Rt:=Rt+1/(R+tabcalcolo^[0].R+tabcalcolo^[MaxStrati].R)*tabePond^[i].Perc;
               end;
            end;
         Trasm:=RT/100;
      end
     else
        Trasm:=1/((1/Cond_Cont^.ALFA)+(1/Cond_Cont^.BETA));
  end;


End.


