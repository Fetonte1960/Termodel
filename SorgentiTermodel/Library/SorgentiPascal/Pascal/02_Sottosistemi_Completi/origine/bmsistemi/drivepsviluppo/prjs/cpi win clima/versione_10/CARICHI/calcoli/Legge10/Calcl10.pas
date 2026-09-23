Unit Calcl10;

INTERFACE

Uses
  SysUtils, Libreriagenerale, Terreno,
  metodL10,{ProcCalc, ut_deb}
  metod10, UFunzioniLegge10{exStampCoz},
  Uvariabili,Varcarichi, Utireport, DBtables, FunzProc1, URicercaDati;

{procedure StampaLocaliNonRisc(var npag,Nr:smallint);}
procedure StampSupParOpa(var npag,Nr:smallint);                     //1A-Stampa superfici pareti opache
procedure SupFinTrasp(var npag,Nr:smallint);                        //1B-Stampa finestre trasparenti
procedure StampaLocaliNonRisc(var npag,nr:smallint;disp:boolean);   //1C-Stampa locali non riscaldati
procedure StampSupParLocFissi(var npag,Nr:smallint);                //1D-Stampa superfici pareti locali a temperarura fissa
procedure StampPontiEsterni(var npag,Nr:smallint);                  //1E-Stampa ponti termici esterni
procedure SupEsp;                                                   //Procedura Superfici Esposizioni


{ ************************************************************************* }

IMPLEMENTATION

procedure InitDatiPrn_rec;
begin
   fillchar(rec_prn^,sizeof(rec_prn^),0);
end;

procedure InitDatiPrn_Fin;
begin
   fillchar(prn_fin^,sizeof(prn_fin^),0);
end;


Procedure InitDatiPrn_Pt;
begin
   fillchar(prn_pt^,sizeof(prn_pt^),0);
end;

// -------------------------------------------
// Procedura Stampa Superfici Pareti Opache 1A  OK
// -------------------------------------------

procedure StampSupParOpa(var npag,Nr:smallint);

var y,Pag:smallint;

procedure SupParOpa(TipoMur,IndArcEsp:smallint);

{  Tipo Muro
   1:parete principale;
   2:parete secondaria;
   3:porta }

var i,x:smallint;
    area,slorda,snetta: real;
    Trovato: boolean;
    ALFA,He,Fs: real;

     procedure StampaLinea;
     begin
       POb_a^.SettaFrontCor(i);
       POb_a^.SettaMuroCor(x);
       with rec_prn^ do
        begin
           Cod:=X;
           if TipoMur = 3 then
            begin
               Descr:=Porte_D^[x].denom;
               K:=Porte_D^[x].TrasmL10{trasmittanza};
               ALFA:=Pob_A^.CALC_ALFA_F(false,x);
               He:=POb_a^.HE_F;
            end
           else
            begin
               Descr := Strutture_D^[x]^.descr;
               K := POb_a^.K_F;      {Strutture_D^[x]^.trasmitt;}
               ALFA := Pob_A^.CALC_ALFA_F(true,x);
               He := POb_a^.HE_F;    {Strutture_D^[x]^.he;}
            end;

           SupLord  := SLorda;
           SupNetta := SNetta;
           Esp:=esposizioni_d^[IndArcEsp].denom;

           if formst(esposizioni_d^[IndArcEsp].CodOst) > '' then
            begin
               calc_Fs1(IndArcEsp,1,x,fo,fa,true,fs);
               { il 2,3,7 parametro non servono a nulla }
            end
           else
            begin
               fo:=1;
               fa:=1;
            end;

           fs := fo*fa;
           Fer := POb_a^.FER_F(IndArcEsp);

           if (esposizioni_d^[IndArcEsp].inclin = 180) or (not Flag10) then
            begin
               He:=0;
               fs:=0;
               fo:=0;
               fa:=0;
               Fer:=0;
            end;
           if He <> 0 then Aei := FS*FER*SUPNetta*ALFA*K/He    // calcolo di AEI
           else Aei := 0;

           Ht := k*SupNetta;
           TotHt := TotHt+Ht;

          { if (esposizioni_d^[IndArcEsp].inclin = 90) or
              (esposizioni_d^[IndArcEsp].inclin = 0) then}

          // Calcolo dell'area equivalente delle superfici opache
             TotAeiOpa[Pob_A^.Cod_Esp_A] :=  TotAeiOpa[Pob_A^.Cod_Esp_A] + AEI;

       {    else TotAeiOpaIncl^[IndArcEsp]:=TotAeiOpaIncl^[IndArcEsp]+AEI;}


       // ---------------------------------
       // Tabella Strutture Edilizie Opache
       //     TABCARATT_EDIL_ZONA_TERM
       // ---------------------------------

            WStrTab(Strutture_D^[cod].NFile);
            WStrTab(Descr);
            WStrTab(Esp);
            WRealeTab(SupLord, 2);
            WRealeTab(SupNetta, 2);
            WRealeTab(K, 3);             //Dispersioni
            WRealeTab(Ht, 3);
            WRealeTab(fer, 1);           //Irraggiamento
            WRealeTab(fo, 1);
            WRealeTab(Fa, 1);
            WRealeTab(Aei, 2);
            //WrealeTab(TotHt, 2);
            TotGenHt := TotGenHt + TotHt;
            TotHt := 0;
            FineRigaTabella;
        end;
      end;


begin

{  esposizioni_d^[IndArcEsp].tipo:=Formst(esposizioni_d^[IndArcEsp].tipo);
   esposizioni_d^[IndArcEsp].CodPav:=Formst(esposizioni_d^[IndArcEsp].CodPav);}
   if (formst(esposizioni_d^[IndArcEsp].tipo)=CH7) and (formst(esposizioni_d^[IndArcEsp].CodPav)='') then
   begin
      if TipoMur = 3 then
       begin
          for x := 1 to NPorte do
           begin
              SLorda:=0;
              SNetta:=0;
              Trovato:=false;
              for i:=1 to NFrontiere do
              begin
                //if (zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc) and (Ambienti_D^[CodAmb]^.Denom>'')and (CodPorta=X) then
                if (Frontiere_D^[i]^.CodAmb >= 1 )and(Frontiere_D^[i]^.codamb <= NAmbienti) and (Frontiere_D^[i]^.CodEsposiz=IndArcEsp) then
                  // Emanuela 21/4/2006 messa anche la condizione che faccia parte dello stesso alloggio
                  if (Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.Z10=ZonaCalc) and
                     (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[Frontiere_D^[i]^.CodAmb].Impianto)].GenInvt)) = 0)
                      and
                     (Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.Denom>'')and (Frontiere_D^[i]^.CodPorta=X) then
                  begin
                    SLorda:=SLorda + (Frontiere_D^[i]^.SupPorta * Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.AmbientiUguali);
                    SNetta:=SNetta + (Frontiere_D^[i]^.SupPorta * Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.AmbientiUguali);
                    Trovato:=true;
                  end;
              end;
              if Trovato then
                 StampaLinea;
           end;
       end
      else
      begin
          //for x := 1 to MaxStrutture do
          // Emanuela 28/7/2004 cambiata la variabile MaxStrutture con NSrutture, affinchè nel ciclo
          // for consideriamo solo le strutture presenti
          for x := 1 to NStrutture do
          begin
             SLorda:=0;
             SNetta:=0;
             Trovato:=false;
             for i := 1 to NFrontiere do
             begin
               //if (zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc) and (Ambienti_D^[CodAmb]^.Denom > '') then
               if (Frontiere_D^[i]^.CodAmb >= 1 )and(Frontiere_D^[i]^.codamb <= NAmbienti) and (Frontiere_D^[i]^.CodEsposiz=IndArcEsp) then
                 if (Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.Z10 = ZonaCalc) and (Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.Denom > '') then
                    if (Frontiere_D^[i]^.CodMuro = X)  then
                    begin
                        if (Frontiere_D^[i]^.LungMuro <> 0) then
                        begin
                            Area:=0;
                            if Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.HSoffitto <> 0
                            then Area:=Frontiere_D^[i]^.LungMuro*Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.HSoffitto
                            else
                             begin
                                 if Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.Zona<>0 then
                                 begin
                                     if Zone_D^[Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.Zona].HSoffittoRicorr<>0 then
                                       Area:=Frontiere_D^[i]^.LungMuro*Zone_D^[Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.Zona].HSoffittoRicorr
                                     else Area:=Frontiere_D^[i]^.LungMuro * Prog^.AltPianoLorda;   // Edificio_D^.HSoffittoRicorr;
                                 end;
                            end;
                            Frontiere_D^[i]^.SupMuro:=Area;
                        end;
                        SLorda:=SLorda+(Frontiere_D^[i]^.SupMuro*Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.AmbientiUguali);
                        if (Frontiere_D^[i]^.CodMuro2<>X)  then SNetta:=SNetta+(Frontiere_D^[i]^.SupMuro-Frontiere_D^[i]^.SUPMURO2-Frontiere_D^[i]^.SUPFINESTRA-Frontiere_D^[i]^.SUPPORTA)*
                                                       Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.AmbientiUguali
                        else SNetta:=SNetta+(Frontiere_D^[i]^.SupMuro-Frontiere_D^[i]^.SUPFINESTRA-Frontiere_D^[i]^.SUPPORTA)*Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.AmbientiUguali;
                        Trovato:=true;
                    end
                    else
                    if (Frontiere_D^[i]^.CodMuro2=X)  then
                     begin
                        SLorda:=SLorda+Frontiere_D^[i]^.SupMuro2*Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.AmbientiUguali;
                        SNetta:=SNetta+Frontiere_D^[i]^.SupMuro2*Ambienti_D^[Frontiere_D^[i]^.CodAmb]^.AmbientiUguali;
                        Trovato:=true;
                     end;

             end; {For 1 to nfrontiere}
             if trovato then
                StampaLinea;
         end; {for 1 to nstrutture}
       end; {end if tipo muro}
   end;{end if esposizioni }
end;


begin
  {if flagstampa then
    begin
       writetesto('Titlefro.prn');
       nr:=nr+lungmask('Titlefro.prn');
    end;
   Pag:=0;
   close(glst);
   assign(glst,'stampe1.lst');
   rewrite(glst);}
   InitDatiPrn_Rec;

   // ---------------------------------------------
   // Tabella Caratteristiche Edilizie Zona Termica
   //           TABCARATT_EDIL_ZONA_TERM
   // ---------------------------------------------

  { TODO -oGenerale -cStampa : Relazione L10 Caratteristiche Pareti-Serramenti [TABCARATT_EDIL_ZONA_TERM] }

   rec_prn^.TotGenHt := 0;

   InizioTabella('TABCARATT_EDIL_ZONA_TERM', 11);
   for y:=1 to NEsposizioni do
       SupParOpa(1,y);
   for y:=1 to NEsposizioni do
       SupParOpa(3,y);
   FineTabella;
   prn_TotH^.HOpaEst:=rec_prn^.TotGenHt;
   // Stampa del totale di colonna del valore Ht
   W_Reale('TOT_HT_EDIL_ZONA_TERM', rec_prn^.TotGenHt, 2);

end;


// ----------------------------------------------------
// Procedura Stampa Superfici & Finestre Trasparenti 1B OK
// ----------------------------------------------------

procedure SupFinTrasp(var npag,Nr:smallint);

var i,x,indP,IndArcEsp:smallint;
    Trovato:boolean;
    Gamma,Fc,Ff,Fs, xx : REAL;
    Pag:smallint;

procedure StampaLineaF;

 begin
      POb_a^.SettaFrontCor(i);
      POb_a^.SettaFinCor(X);
      POb_a^.SettaEspCor(IndArcEsp);

       with Prn_fin^ do
        begin

           Cod   := x;
           descr := Pob_A^.Descr_fin;
           Esp   := esposizioni_d^[IndArcEsp].denom;
           k     := Pob_A^.k_Fin;
           Ht    := AREA*K;

           Alt   := Finestre_D^[x]{.fin_cart}.AltezzaFin;

           {Xa viene settato da calc_fs1}

        {   if formst(esposizioni_d^[IndArcEsp].CodOst) > '' then
            begin}
               fo:=1; fa:=1; Xa:=0;
               calc_Fs1(IndArcEsp,x,Piano,fo,fa,false,Xa);
        {    end
           else
            begin
               fo:=1; fa:=1; Xa:=0;
            end;}

           if (esposizioni_d^[IndArcEsp].inclin = 180 ) or (not Flag10) then
            begin
               gamma := 0;
               fs := 0;
               fc := 0;
               ff := 0;
            end
           else
            begin
               fs := fo*fa;
               Fc := Pob_A^.Fc_Fin;  // Shading schermo
               Ff := Pob_A^.Ff_Fin;  // Percentuale della parte vetrata
               gamma := Pob_A^.CoefTrasp_Fin;    // Shading Vetro
            end;
            xx := area;
            Aei := Fs*Fc*Ff*Gamma*Area;
            TotHt := TotHt + Ht;

        {   if (esposizioni_d^[IndArcEsp].inclin = 90) or
              (esposizioni_d^[IndArcEsp].inclin = 0) then}
             TotAeiTrasp[Pob_A^.Cod_Esp_A] :=  TotAeiTrasp[Pob_A^.Cod_Esp_A] + Aei;
      {     else TotAeiTraspIncl^[IndArcEsp]:=TotAeiTraspIncl^[IndArcEsp]+AEI;}

           {TotA[Pob_A^.Cod_Esp_A] :=  TotA[Pob_A^.Cod_Esp_A] +10;}

   // --------------------------------
   // Tabella Caratteristiche Finestre
   //    TABCARATT_FINEST_ZONA_TERM
   // --------------------------------

            WStrTab(Finestre_D^[cod].Codice);
            WStrTab(Descr);
            // Aggiungere colonna Piano in TABCARATT_FINEST_ZONA_TERM (vedi **)
            // Correzione del file Tabelle_L10.txt - Fabio 29-10-2004
            WstrTab(PianoAmb);
            WStrTab(Esp);
            WRealeTab(Num, 0);
            WRealeTab(Area, 2);
            WRealeTab(k, 3);
            WRealeTab(Ht, 3);
            WRealeTab(alt, 1);
            WRealeTab(XA, 1);
            WRealeTab(fo, 1);
            WRealeTab(fa, 2);
            WRealeTab(Prn_fin^.Aei, 2);
            TotGenHt := TotGenHt + TotHt;
            TotHt := 0;
            FineRigaTabella;

        end;
 end;


begin

  Prn_fin^.TotGenHt := 0;

  // Aggiungere colonna Piano in TABCARATT_FINEST_ZONA_TERM (vedi **)
  // Correzione del file Tabelle_L10.txt - Fabio 28-10-2004
  // PIANO_FIN_ZOT:Piano:real:12:
  // InizioTabella('TABCARATT_FINEST_ZONA_TERM', 13);
  InizioTabella('TABCARATT_FINEST_ZONA_TERM', 13);
  InitDatiPrn_Fin;

   for IndArcEsp:=1 to NEsposizioni do
    BEGIN
       if (formst(esposizioni_d^[IndArcEsp].tipo)=CH7) and (formst(esposizioni_d^[IndArcEsp].CodPav)='') then
        begin
           for x:=1 to NFinestre do
            begin
             if Frontiere_D^[1] <> nil then
             begin
               IndP:=trunc(Frontiere_D^[1]^.CodNum/1000);
               Trovato:=false;
               Prn_fin^.Area:=0;
               Prn_fin^.Num:=0;
               for i:=1 to NFrontiere do
                with Frontiere_D^[i]^ do
                 begin
                 //if(zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc)and(Ambienti_D^[CodAmb]^.Denom>'')and(CodFinestra=X) then

                    if (CodAmb >= 1 )and(codamb <= NAmbienti) and (CodEsposiz=IndArcEsp) then
                     // Emanuela 21/4/2006 messa la condizione che l'ambiente che l'ambiente appartenga
                     // allo stesso alloggio
                     if(Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                         (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                      and(Ambienti_D^[CodAmb]^.Denom>'')and(CodFinestra=X) then
                      begin
                         if IndP <> trunc(CodNum/1000) then
                          begin
                             Trovato:=false;
                             if Prn_fin^.Num > 0 then StampaLineaF;
                             IndP:=trunc(CodNum/1000);
                             Prn_fin^.Area:=0;
                             Prn_fin^.Num:=0;
                          end;
                         // Emanuela 27/9/2004 commentato perchè non ha significato
                          Prn_fin^.Piano := trunc(CodNum/1000);
                          Prn_fin^.PianoAmb:= Ambienti_D^[CodAmb]^.Piano;
                         Prn_fin^.Area:=Prn_fin^.Area+SupFinestra*Ambienti_D^[CodAmb]^.AmbientiUguali;
                         Prn_fin^.Num:=Prn_fin^.Num+ModFinestra*Ambienti_D^[CodAmb]^.AmbientiUguali;
                         Trovato:=true;
                      end;
                 end;
               if Trovato then StampaLineaF;
            end;
          end;
        end;
    END;

   prn_TotH^.HTraspEst:=Prn_fin^.TotGenHt;

   FineTabella;
   // Stampa del totale di colonna del valore Ht
   W_Reale('TOTALE_HT_FIN_ZONA_TERM', Prn_fin^.TotGenHt, 2);

end;



//----------------------------------
// Procedura Superfici & Esposizioni
//----------------------------------

procedure SupEsp;

var i,IndP,IndEsp:smallint;
    sup,AltMin,AltMax,Area:real;

begin
   fillChar(CalcEsp^,sizeof(CalcEsp^),0);

   for IndEsp:=1 to NEsposizioni do
    begin
       if (formst(esposizioni_d^[IndEsp].tipo)=CH7) and (FormSt(esposizioni_d^[IndEsp].CodOst)>'') then
        begin
           Sup:=0;
           AltMin:=1000000;
           AltMax:=0;

           for i:=1 to NFrontiere do
            with Frontiere_D^[i]^ do
             begin
                if (CodAmb >= 1 )and(codamb <= NAmbienti) and (CodEsposiz=IndEsp) then
                 if {(Zone_d^[Amb_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc) and} (Ambienti_D^[CodAmb]^.Denom > '') then
                  begin
                     if (LungMuro <> 0) then
                      begin
                         Area:=0;
                         if Ambienti_D^[CodAmb]^.HSoffitto<>0 then Area:=LungMuro*Ambienti_D^[CodAmb]^.HSoffitto
                          else
                           begin
                              if Ambienti_D^[CodAmb]^.Zona<>0 then
                               begin
                                  if Zone_D^[Ambienti_D^[CodAmb]^.Zona].HSoffittoRicorr<>0 then
                                    Area:=LungMuro*Zone_D^[Ambienti_D^[CodAmb]^.Zona].HSoffittoRicorr
                                  else Area:=LungMuro * Prog^.AltPianoLorda; //Edificio_D^.HSoffittoRicorr;
                               end;
                           end;
                         SupMuro:=Area;
                      end;
                     Sup:=Sup+SupMuro*Ambienti_D^[CodAmb]^.AmbientiUguali;
                     IndP:=trunc(CodNum/1000);
                     if AltMin > EPt^[IndP].ZMin then AltMin:=EPt^[IndP].ZMin;
                     if AltMax < EPt^[IndP].ZMax then AltMax:=EPt^[IndP].ZMax;
                  end;

             end;
           CalcEsp^[IndEsp].Sup:=Sup;
           CalcEsp^[IndEsp].Alt:=AltMax-AltMin;
        end
    end;
end;


// ---------------------------------------------
// Procedura Stampa dei Ponti Termici Esterni 1E
// ---------------------------------------------

procedure StampPontiEsterni(var npag,nr:smallint);

var i,IndP,SalP:smallint;
    Pag:smallint;
    trovato:boolean;
    TothP:real;

procedure StampaPontiEst(IndPonte:smallint);

 begin
       with Prn_Pt^ do
        begin
           descr :=ponti_d^[Indponte].denom;
           kLin  :=Kappa_PT^.K(SalP){ponti_d^[Indponte].KL};
           Ht    :=KLin*LungT;
           TotHt :=TotHt+Ht;

   // ---------------------------------------------
   // Tabella Caratteristiche Ponti Termici Esterni
   //           CARATT_PONTI_TERM_CONF_EST
   // ---------------------------------------------
            WStrTab(Ponti_D^[cod].Codice);
            WStrTab(Descr);
            WRealeTab(Num, 0);
            WRealeTab(LungT, 2);
            WRealeTab(KLin, 3);
            WRealeTab(Ht, 3);
            TotGenHt := TotGenHt + TotHt;
            TotHt := 0;
            FineRigaTabella;
        end;
        TotHP :=TotHP+Prn_Pt^.Ht;
end;


begin

   Rec_prn^.TotGenHt := 0;

   InizioTabella('CARATT_PONTI_TERM_CONF_EST',6);

   TothP:=0;
   Pag:=0;
   for i:=1 to NPonti do
   begin
       InitDatiPrn_Pt;
       trovato:=false;
       Prn_Pt^.LungT:=0;  Prn_Pt^.Num:=0;
       for IndP:=1 to NFrontiereLin do
        begin
           with FrontiereLin_D^[IndP]^ do
            begin
              if (i = CodPonte1) or (i=CodPonte2) then
                if (CodAmb >= 1 )and(codamb <= NAmbienti) and (CodEsp >= 1 )and(CodEsp <= NEsposizioni) then
                // Emanuela 21/4/2006 messa la condizione affinchè appartengono allo stesso alloggio
                if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                   (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0) and
                   (Ambienti_D^[CodAmb]^.Denom > '')and
                   (esposizioni_d^[CodEsp].tipo=CH7) then
                  begin
                     Trovato:=true;
                     SalP:=IndP;
                     if (i = CodPonte1) then
                      begin
                         Prn_Pt^.Cod:=i;
                         Prn_Pt^.Num:=Prn_Pt^.Num+1*Ambienti_D^[CodAmb]^.AmbientiUguali;
                         Prn_Pt^.LungT:=Prn_Pt^.LungT+Lung1*Ambienti_D^[CodAmb]^.AmbientiUguali;
                      end;
                     if (i = CodPonte2) then
                      begin
                         Prn_Pt^.Cod:=i;
                         Prn_Pt^.Num:=Prn_Pt^.Num+1*Ambienti_D^[CodAmb]^.AmbientiUguali;
                         Prn_Pt^.LungT:=Prn_Pt^.LungT+Lung2*Ambienti_D^[CodAmb]^.AmbientiUguali;
                      end;
                  end;
            end;

        end;
        if Trovato then StampaPontiEst(i);
    end;
   prn_TotH^.HPontEst:=TotHP;
   W_Reale('TOTALE_HT_PT_CONF_EST', Prn_Pt^.TotGenHt, 2);

  FineTabella;
end;


// -----------------------------------------------------------------------
// Procedura Stampa Superfici Scambianti con Locali a Temperatura Fissa 1D
// -----------------------------------------------------------------------

procedure StampSupParLocFissi(var npag,Nr:smallint);
const
 TipoP:array[1..6] of string =('PARETE','PARETE','PORTA','FINESTRA','PONTE TERMICO','VENTILAZIONE');

var y,Pag:smallint;

procedure StampParet(TipoMur,IndArcEsp:smallint);

var i,x,NumTot:smallint;
    area,slorda,snetta,LungK:real;
    Trovato:boolean;

procedure StampaLinea;
var Table: TTable;
    CodiceParete:String;
 begin
      CodiceParete:=IntToStr(x);

      POb_a^.SettaFrontCor(i);
      // TotHEspLocFissi^[IndArcEsp] := 0; Spostata in altra riga
       with prn_lTf^ do
        begin
           Cod:=x;
           Tipo:=Tipop[TipoMur];
           if TipoMur = 3 then
            begin
               Descr:=Porte_D^[x].denom;
               K:=Porte_D^[x].TrasmL10{trasmittanza};
            end;
           if TipoMur = 4 then
            begin
               POb_a^.SettaFinCor(X);
               Descr:=Finestre_D^[x]{.fin_cart}.denom;
               K:=Pob_A^.k_Fin;
            end;
           if TipoMur < 3 then
            begin
               POb_a^.SettaMuroCor(X);
               Descr:=Strutture_D^[x]^.descr;
               K:=Pob_A^.k_F;   {Strutture_D^[x]^.trasmitt;}
            end;

           SupLord:=SLorda;
           SupNetta:=SNetta;
           Lung:=LungK;
           Num:=NumTot;

           if TipoMur = 5 then
            begin
               Descr:=ponti_D^[x].denom;
               // Emanuela 4/2/2005 corretto errore nel caricamento dei valori dei ponti termici
               {K:=Kappa_PT^.K(i)}K := ponti_D^[x].KL;
               Ht:=Lung*k;
            end
           else
            begin
               Esp:=esposizioni_d^[IndArcEsp].denom;
               Ht:=k*SupNetta;
            end;

            // 22-07-2004 Emanuela - Eliminato il contributo dell' Ht dovuto ad
            //                       una esp.ne con il terreno

           if UpperCase(Esp) <> UpperCase('Terreno') then
            TotHEspLocFissi^[IndArcEsp]:=TotHEspLocFissi^[IndArcEsp]+Ht;

           Table:=TTable.create(nil);
           Table.DatabaseName:=Percorso_progetti;
           if TipoMur = 3 then Table.TableName:='Finestre.db'
           else if TipoMur = 4 then Table.TableName:='Finestre.db'
           else if TipoMur = 5 then Table.TableName:='Ponti.db'
                else Table.TableName:='Strutture.db';
           //Table.TableName:='Strutture.db';
           Table.open;
           if Table.Locate('Descrizione', Descr,[]) then
             CodiceParete:=Table.findfield('Codice').AsString;
           Table.Close;
           Freeandnil(Table);
   // -----------------------------------------------------------
   // Tabella Superfici Scambianti con Locali a Temperatura Fissa
   //                   TABCARATT_SCAMB_TEMP_FISSA
   // -----------------------------------------------------------

            WStrTab(Esp);
            WStrTab(Tipo);
            WStrTab(CodiceParete);
            //WStrTab(Descr);
            WRealeTab(k, 3);
            WRealeTab(Num, 0);
            WRealeTab(SupLord, 2);
            WRealeTab(SupNetta, 2);
            WRealeTab(Lung, 1);
            WRealeTab(Ht, 3);
            TotGenHt := TotGenHt + TotHt;
            TotHt := 0;
            FineRigaTabella;
        end;
end;

var a:string;
begin
//a:=esposizioni_d^[IndArcEsp].tipo;
//a:=upstring(a);
//   if  esposizioni_d^[IndArcEsp].tipo=CH8 then
   if (formst(esposizioni_d^[IndArcEsp].tipo)=CH8) and (formst(esposizioni_d^[IndArcEsp].CodPav)='') then
   // {   and (formst(esposizioni_d^[IndArcEsp].CodOst)='') then}
    begin
      SLorda:=0;
      SNetta:=0;
      LungK:=0;
      NumTot:=0;
      if TipoMur = 3 then
       begin
          for x:=1 to NPorte do
           begin
              SLorda:=0;
              SNetta:=0;
              NumTot:=0;
              Trovato:=false;
              for i:=1 to NFrontiere do
               with Frontiere_D^[i]^ do
                begin
                   if (CodAmb >= 1 )and(codamb <= NAmbienti) and (CodEsposiz=IndArcEsp) then
                   // Emanuela 21/4/2006 messa la condizione che l'ambiente appartenga allo stesso alloggio
                   if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                      (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0) and
                      (Ambienti_D^[CodAmb]^.Denom>'') and (CodPorta=X) then
                     begin
                        SLorda:=SLorda+(SupPorta*Ambienti_D^[CodAmb]^.AmbientiUguali);
                        SNetta:=SNetta+(SupPorta*Ambienti_D^[CodAmb]^.AmbientiUguali);
                        NumTot:=NumTot+(ModPorta*Ambienti_D^[CodAmb]^.AmbientiUguali);
                        Trovato:=true;
                     end;
                end;
              if Trovato then StampaLinea;
           end;
       end;
      if TipoMur = 4 then
       begin
          for x:=1 to Nfinestre do
           begin
              SLorda:=0;
              SNetta:=0;
              NumTot:=0;
              Trovato:=false;
              for i:=1 to NFrontiere do
               with Frontiere_D^[i]^ do
                begin
                //if (Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc)and(Ambienti_D^[CodAmb]^.Denom>'')and(Codfinestra=X)then

                   if (CodAmb >= 1 )and(codamb <= NAmbienti) and (CodEsposiz=IndArcEsp) then
                   // Emanuela 21/4/2006 messa la condizione che l'ambiente appartenga allo stesso alloggio
                   if (Ambienti_D^[CodAmb]^.Z10 = ZonaCalc) and
                      (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                     and (Ambienti_D^[CodAmb]^.Denom>'') and (Codfinestra=X)then
                     begin
                        SLorda:=SLorda+SupFinestra*Ambienti_D^[CodAmb]^.AmbientiUguali;
                        SNetta:=SNetta+SupFinestra*Ambienti_D^[CodAmb]^.AmbientiUguali;
                        NumTot:=NumTot+ModFinestra*Ambienti_D^[CodAmb]^.AmbientiUguali;
                        Trovato:=true;
                     end;
                end;
              if Trovato then StampaLinea;
           end;
       end;
      if TipoMur = 5 then
       begin
          for x:=1 to NPonti do
           begin
              LungK:=0;
              NumTot:=0;
              trovato:=false;
              for i:=1 to NFrontiereLin do
               begin
                  with FrontiereLin_D^[i]^ do
                   begin
                   //if (Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc) and (Ambienti_D^[CodAmb]^.Denom > '') then


                      if (x = CodPonte1) or (x=CodPonte2) then
                       // Emanuela 21/4/2006 messa la condizione che appartenga allo stesso alloggio
                       if (CodAmb >= 1 )and(codamb <= NAmbienti) and
                          (CodEsp=IndArcEsp) then
                       if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                          (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                         and (Ambienti_D^[CodAmb]^.Denom > '') then
                         begin
                            Trovato:=true;
                            if (x = CodPonte1) then
                             begin
                                NumTot:=NumTot+1*Ambienti_D^[CodAmb]^.AmbientiUguali;
                                LungK:=LungK+Lung1*Ambienti_D^[CodAmb]^.AmbientiUguali;
                             end;
                            if (x = CodPonte2) then
                             begin
                                NumTot:=NumTot+1*Ambienti_D^[CodAmb]^.AmbientiUguali;
                                LungK:=LungK+Lung2*Ambienti_D^[CodAmb]^.AmbientiUguali;
                             end;
                         end;
                   end;
               end;
              if Trovato then StampaLinea;
           end;
       end;
      if TipoMur < 3 then
       begin
          for x:=1 to MaxStrutture do
           begin
             SLorda:=0;
             SNetta:=0;
             Trovato:=false;
             for i:=1 to NFrontiere do
              with Frontiere_D^[i]^ do
               begin
                //if (Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc) and (Ambienti_D^[CodAmb]^.Denom > '') then

                  if (CodAmb >= 1 )and(codamb <= NAmbienti) and (CodEsposiz=IndArcEsp) then
                  // Emanuela 21/4/2006 messa la condizione che appartenga allo stesso alloggio
                  if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                     (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0) and
                     (Ambienti_D^[CodAmb]^.Denom > '') then
                    if (CodMuro=X)  then
                     begin
                        if (LungMuro <> 0) then
                         begin
                            Area:=0;
                            if Ambienti_D^[CodAmb]^.HSoffitto<>0 then Area:=LungMuro*Ambienti_D^[CodAmb]^.HSoffitto
                             else
                              begin
                                 if Ambienti_D^[CodAmb]^.Zona<>0 then
                                  begin
                                     if Zone_D^[Ambienti_D^[CodAmb]^.Zona].HSoffittoRicorr<>0 then
                                       Area:=LungMuro*Zone_D^[Ambienti_D^[CodAmb]^.Zona].HSoffittoRicorr
                                     else Area:=LungMuro * Prog^.AltPianoLorda;//Edificio_D^.HSoffittoRicorr;
                                  end;
                              end;
                            SupMuro:=Area;
                         end;
                        SLorda:=SLorda+SupMuro*Ambienti_D^[CodAmb]^.AmbientiUguali;
                        if (CodMuro2<>X)  then SNetta:=SNetta+(SupMuro-SUPMURO2-SUPFINESTRA-SUPPORTA)*
                                                       Ambienti_D^[CodAmb]^.AmbientiUguali
                        else SNetta:=SNetta+(SupMuro-SUPFINESTRA-SUPPORTA)*Ambienti_D^[CodAmb]^.AmbientiUguali;
                        Trovato:=true;
                     end
                    else
                    if (CodMuro2=X)  then
                     begin
                        SLorda:=SLorda+SupMuro2*Ambienti_D^[CodAmb]^.AmbientiUguali;
                        SNetta:=SNetta+SupMuro2*Ambienti_D^[CodAmb]^.AmbientiUguali;
                        Trovato:=true;
                     end;
               end;
            if trovato then StampaLinea;
           end;
       end;
    end;
end;


begin
   {Pag:=0;
   close(glst);
   assign(glst,'stampe1.lst');
   rewrite(glst);}

   InizioTabella('TABCARATT_SCAMB_TEMP_FISSA', 10);
   for y:=1 to NEsposizioni do
    begin
       TotHEspLocFissi^[y] := 0;
       StampParet(1,y); { muri     }
       StampParet(3,y); { porte    }
       StampParet(4,y); { finestre }
       StampParet(5,y); { ponti    }
    end;
    FineTabella;
   {if (Pag > 0) and flagstampa then
    begin
       writetesto('EspLncC.prn');
       Pag:=Pag+lungmask('EspLncC.prn');
    end;}
   {StampaMask(Longint(@prn_lTf^.TotHt),OFS(prn_lTf^.TotHt),'EspLncCD.prn',true);}
   {close(glst);}

   {assign(glst,'stampe.lst');
   append(glst);

   if Pag > 0 then StampaTab('EspLncA.prn','EspLncW.prn','EspLncC.prn',Pag,nr,npag);}

end;


// -----------------------------------------
// Procedura Stampa Locali Non Riscaldati 1C
// -----------------------------------------

procedure StampaLocaliNonRisc(var npag,nr:smallint;disp:boolean);
var i,j,Pag:smallint;
    ZonaNonRisc,Pass:boolean;
    totali:record
             totHiu    : real;
             TotHue    : real;
             TotHie    : real;
             TotHieTot : real;
             TotHiz    : real;
           end;

procedure ParetNonRisc(CercaAmb:smallint;EspAmbNr:real;TipoMur:smallint);
const
 TipoP:array[1..6] of string =('PARETE','PAVIMENTO','PORTA','FINESTRA','PONTE TERMICO','VENTILAZIONE');

var i,x,NumTotE,NumTotI,NumTotZ,IndP:smallint;
    area,slordaE,snettaE,LungKE,slordaI,snettaI,LungKI,slordaZ,snettaZ,LungKZ,X1,X2:real;
    TrovatoE,TrovatoI,TrovatoZ:boolean;
    CodLoc:real;

procedure StampaLineaNR(estern:boolean);

var PavTer1:RecPavSut;

 begin

       with prn_lnr^ do
        begin
           Hie:=0;
           Hiv:=0;
           if TipoMur <> 2 then Str(X,Cod);

           Tipo:=Tipop[TipoMur];

           if TipoMur =1 then
            begin
               POb_a^.SettaMuroCor(x);
               Descr:=Strutture_D^[x]^.descr;
               K:=Pob_A^.k_F;   {Strutture_D^[x]^.trasmitt;}
            end;

           if TipoMur = 3 then
            begin
               Descr:=Porte_D^[x].denom;
               K:=Porte_D^[x].TrasmL10{trasmittanza};
            end;
           if TipoMur = 4 then
            begin
               Descr:=Finestre_D^[x]{.fin_cart}.denom;
               POb_a^.SettaFinCor(X);
               K:=Pob_A^.k_Fin; {Finestre_D^[x].fin_cart.trasmittanza;}
            end;

           if TipoMur = 5 then
            begin
               Descr:=ponti_D^[x].denom;
               K:=Kappa_PT^.K(i){ponti_D^[x].kl};
            end;

           if Estern then
            begin
               Conf:='ESTERNO';
               SupLord:=SLordaE;
               SupNetta:=SNettaE;
               Lung:=LungKE;
               Num:=NumTotE;
               
               if TipoMur=5 then Hie:=Lung*k
               else Hie:=k*SupNetta;
            end
           else
            begin
               if TrovatoZ then
                begin
                   Conf:='ZONA RISC.';
                   SupLord:=SLordaZ;    SupNetta:=SNettaZ; Lung:=LungKZ; Num:=NumTotZ;
                   if TipoMur=5 then Hiv:=Lung*k
                   else Hiv:=k*SupNetta;
                   Totali.TotHiz:=Totali.TotHiz+hiv;
                end
               else
                begin
                   Conf:='ALTRA ZONA';
                   SupLord:=SLordaI;    SupNetta:=SNettaI; Lung:=LungKI; Num:=NumTotI;
                   if TipoMur=5 then Hiv:=Lung*k
                   else Hiv:=k*SupNetta;
                end;
              if disp then Conf:='ZONA RISC.';

            end;

           if TipoMur = 6 then
            begin
               SupLord:=0;    SupNetta:=0; Lung:=0; Num:=0;
               Descr:='';     K:=0;  cod:='';
               if Estern then Hie:=(ro/3600)*1.2*1000
               else
                begin
                   Hiv:=(ro/3600)*1.2*1000;
                   Totali.TotHiz:=Totali.TotHiz+hiv;
                end;
            end;
           if TipoMur =2 then
            begin
               K:=0;
               if (PavSuTer^[indp].Tipo = 4) then
                begin
                   if (PavSuTer^[indp].Area > 0 ) then
                    Hie:=(PavSuTer^[indp].Hg*SNettaE)/PavSuTer^[indp].Area;
                end
               else
                begin
                   PavTer1:=PavSuTer^[indp];
                   PavSuTer^[indp].area:=SNettaE;
                   PavSuTer^[indp].Perimetro:=LungkE;
                   if LungKE <> 0 then Hie:=CalcoloHg(IndP);
                   PavSuTer^[indp]:=pavTer1;
                end;
            end;


           Totali.TotHiu:=Totali.TotHiu+hiv;
           Totali.TotHue:=Totali.TotHue+hie;
        end;

 end;

// ---------------------------------------
// Funzione Controlla Pavimento su Terreno
// ---------------------------------------

function ControllaPavSuTer(var IndP:smallint;CE:smallint):boolean;

var Trov:boolean;

begin
   Trov:=false;
   if inrange(ce,1,maxesposizioni) then
    if (formst(esposizioni_d^[CE].CodPav) > '') then
     begin
        indp:=1;
        repeat
          Trov:=formst(PavSuTer^[indp].Codice)=formst(esposizioni_d^[CE].CodPav);
          if not Trov then indp:=indp+1;
        until Trov or (indp > maxPav);
     end;
   if Trov then
    begin
       ControllaPavSuTer:=true;
       prn_lnr^.Descr:=esposizioni_d^[CE].Denom;
       prn_lnr^.Cod:=PavSuTer^[indp].Codice;
    end
   else ControllaPavSuTer:=false;
end;


begin
   CodLoc:=EspAmbNr;
   SLordaE:=0;
   SNettaE:=0;
   LungKE:=0;
   NumTotE:=0;
   SLordaI:=0;
   SNettaI:=0;
   LungKI:=0;
   NumTotI:=0;
   SLordaZ:=0;
   SNettaZ:=0;
   LungKZ:=0;
   NumTotZ:=0;
   prn_lnr^.ro:=0;
     if TipoMur = 6 then
      begin
         TrovatoZ:=false;
         if Ambienti_D^[CercaAmb]^.InfInv > 0 then
          begin
             if Ambienti_D^[CercaAmb]^.HSoffitto<>0 then
              prn_lnr^.ro:=Ambienti_D^[CercaAmb]^.InfInv*Ambienti_D^[CercaAmb]^.superficie*
                           Ambienti_D^[CercaAmb]^.hsoffitto*Ambienti_D^[CercaAmb]^.AmbientiUguali
             else
              begin
                 if Ambienti_D^[CercaAmb]^.Zona<>0 then
                  begin
                     if Zone_D^[Ambienti_D^[CercaAmb]^.Zona].HSoffittoRicorr<>0 then
                       prn_lnr^.ro:=Ambienti_D^[CercaAmb]^.InfInv*Ambienti_D^[CercaAmb]^.superficie*
                                   Zone_D^[Ambienti_D^[CercaAmb]^.Zona].HSoffittoRicorr*Ambienti_D^[CercaAmb]^.AmbientiUguali
                     else prn_lnr^.ro:=Ambienti_D^[CercaAmb]^.InfInv*Ambienti_D^[CercaAmb]^.superficie*
                                       Prog^.AltPianoLorda {Edificio_D^.HSoffittoRicorr} * Ambienti_D^[CercaAmb]^.AmbientiUguali;
                  end;
              end;
            { prn_lnr^.ro:=prn_lnr^.ro; }
             StampaLineaNR(true);
          end;
         if Ambienti_D^[CercaAmb]^.Inf_risc > 0 then
          begin
             TrovatoZ:=true;
             if Ambienti_D^[CercaAmb]^.HSoffitto<>0 then
              prn_lnr^.ro:=Ambienti_D^[CercaAmb]^.Inf_risc*Ambienti_D^[CercaAmb]^.superficie*
                           Ambienti_D^[CercaAmb]^.hsoffitto*Ambienti_D^[CercaAmb]^.AmbientiUguali
             else
              begin
                 if Ambienti_D^[CercaAmb]^.Zona<>0 then
                  begin
                     if Zone_D^[Ambienti_D^[CercaAmb]^.Zona].HSoffittoRicorr<>0 then
                       prn_lnr^.ro:=Ambienti_D^[CercaAmb]^.Inf_Risc*Ambienti_D^[CercaAmb]^.superficie*
                                   Zone_D^[Ambienti_D^[CercaAmb]^.Zona].HSoffittoRicorr*Ambienti_D^[CercaAmb]^.AmbientiUguali
                     else prn_lnr^.ro:=Ambienti_D^[CercaAmb]^.Inf_Risc*Ambienti_D^[CercaAmb]^.superficie*
                                       Prog^.AltPianoLorda {Edificio_D^.HSoffittoRicorr} * Ambienti_D^[CercaAmb]^.AmbientiUguali;
                  end;
              end;
            { prn_lnr^.ro:=prn_lnr^.ro;}
             StampaLineaNR(false);
          end;

      end;
     if TipoMur = 3 then
       begin
          for x:=1 to NPorte do
           begin
              SLordaE:=0;
              SNettaE:=0;
              NumTotE:=0;
              TrovatoE:=false;
              SLordaI:=0;
              SNettaI:=0;
              NumTotI:=0;
              TrovatoI:=false;
              SLordaZ:=0;
              SNettaZ:=0;
              NumTotZ:=0;
              TrovatoZ:=false;

              for i:=1 to NFrontiere do
               with Frontiere_D^[i]^ do
                begin
                   if (CodPorta=X)then
                    begin
                       if (CodAmb = CercaAmb) then
                        begin
                           if inrange(CodEsposiz,1,maxesposizioni) then
                            if formst(esposizioni_d^[CodEsposiz].tipo)=CH7 then
                             begin
                                SLordaE:=SLordaE+SupPorta*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                SNettaE:=SNettaE+SupPorta*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                NumTotE:=NumTotE+1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                TrovatoE:=true;
                             end;
                        end
                       else
                        begin
                        //if Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc then

                           if (CodEsposiz=EspAmbNr) then
                            begin
                             // Emanuela 21/4/2006 messa la condizione che appartengono allo stesso alloggio
                             if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                                (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                             then
                                begin
                                   SLordaZ:=SLordaZ+SupPorta*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   SNettaZ:=SNettaZ+SupPorta*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   NumTotZ:=NumTotZ+1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   TrovatoZ:=true;
                                end
                               else
                                begin
                                   SLordaI:=SLordaI+SupPorta*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   SNettaI:=SNettaI+SupPorta*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   NumTotI:=NumTotI+1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   TrovatoI:=true;
                                end;

                            end;
                        end;
                    end;
                end;
              if TrovatoE then StampaLineaNR(true);
              if TrovatoZ then
               begin
                  StampaLineaNR(false);
                  Trovatoz:=false;
               end;
              if TrovatoI then StampaLineaNR(false);
           end;
       end;
      if TipoMur = 4 then
       begin
          for x:=1 to Nfinestre do
           begin
              SLordaE:=0;
              SNettaE:=0;
              NumTotE:=0;
              TrovatoE:=false;
              SLordaI:=0;
              SNettaI:=0;
              NumTotI:=0;
              TrovatoI:=false;
              SLordaZ:=0;
              SNettaZ:=0;
              NumTotZ:=0;
              TrovatoZ:=false;
              for i:=1 to NFrontiere do
               with Frontiere_D^[i]^ do
                begin
                   if (CodFinestra=X) then
                    begin
                       if (CodAmb = CercaAmb) then
                        begin
                           if inrange(CodEsposiz,1,maxesposizioni) then
                            if formst(esposizioni_d^[CodEsposiz].tipo)=CH7 then
                             begin
                                SLordaE:=SLordaE+SupFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                SNettaE:=SNettaE+SupFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                NumTotE:=NumTotE+ModFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                TrovatoE:=true;
                             end;
                        end
                       else
                        begin
                        //if Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc then

                           if (CodEsposiz=EspAmbNr) then
                            begin
                             // Emanuela 21/4/2006 messa la condizione che appartenga allo stesso alloggio
                             if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                                (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                                then
                                begin
                                   SLordaZ:=SLordaZ+SupFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   SNettaZ:=SNettaZ+SupFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   NumTotZ:=NumTotZ+ModFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   TrovatoZ:=true;
                                end
                               else
                                begin
                                   SLordaI:=SLordaI+SupFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   SNettaI:=SNettaI+SupFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   NumTotI:=NumTotI+ModFinestra*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   TrovatoI:=true;
                                end;
                            end;
                        end;
                    end;
                end;
              if TrovatoE then StampaLineaNR(true);
              if TrovatoZ then
               begin
                  StampaLineaNR(false);
                  Trovatoz:=false;
               end;
              if TrovatoI then StampaLineaNR(false);
           end;
       end;
      if TipoMur = 5 then
       begin
          for x:=1 to NPonti do
           begin
              LungKE:=0;
              NumTotE:=0;
              LungKI:=0;
              NumTotI:=0;
              trovatoE:=false;
              TrovatoI:=false;
              TrovatoZ:=false;
              LungKZ:=0;
              NumTotZ:=0;
              for i:=1 to NFrontiereLin do
               begin
                  with FrontiereLin_D^[i]^ do
                   begin
                      if (x = CodPonte1) or (x=CodPonte2) then
                       if (CodAmb = CercaAmb) then
                        begin
                           if inrange(CodEsp,1,maxesposizioni) then
                            if formst(esposizioni_d^[CodEsp].tipo)=CH7 then
                             begin
                                TrovatoE:=true;
                                if (x = CodPonte1) then
                                 begin
                                    NumTotE:=NumTotE+1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                    LungKE:=LungKE+Lung1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                 end;
                                if (x = CodPonte2) then
                                  begin
                                    NumTotE:=NumTotE+1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                    LungKE:=LungKE+Lung2*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                 end;
                             end;
                        end
                       else
                        begin
                           if (CodEsp=EspAmbNr) then
                            begin

                               X1:=0;  X2:=0;
                               if (x = CodPonte1) then
                                begin
                                   X1:=1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   X2:=Lung1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                end;
                               if (x = CodPonte2) then
                                begin
                                   X1:=X1+1*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                   X2:=X2+Lung2*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                                end;
                               //if Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc then
                               // Emanuela 21/4/2006 messa la condizione che appartengono allo stesso alloggio
                               if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                                  (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                                then
                                begin
                                   NumTotZ:=NumTotZ+trunc(X1);
                                   LungKZ:=LungKZ+X2;
                                   TrovatoZ:=true;
                                end
                               else
                                begin
                                   NumTotI:=NumTotI+trunc(X1);
                                   LungKI:=LungKI+X2;
                                   TrovatoI:=true;
                                end;
                            end;
                        end;
                   end;
               end;
              if TrovatoE then StampaLineaNR(true);
              if TrovatoZ then
               begin
                  StampaLineaNR(false);
                  Trovatoz:=false;
               end;
              if TrovatoI then StampaLineaNR(false);
           end;
       end;
      if TipoMur < 3 then
       begin
          for x:=1 to MaxStrutture do
           begin
             SLordaE:=0;
             SNettaE:=0;
             SLordaI:=0;
             SNettaI:=0;
             LungKe:=0;
             TipoMur:=1;
             TrovatoE:=false;
             TrovatoI:=false;
             SLordaZ:=0;
             SNettaZ:=0;
             NumTotZ:=0;
             TrovatoZ:=false;
             for i:=1 to NFrontiere do
              with Frontiere_D^[i]^ do
               begin
                  if (CodAmb = CercaAmb) or (CodEsposiz=EspAmbNr) then
                   BEGIN
                   if (CodMuro=X)  then
                    begin
                       if (LungMuro <> 0) then
                        begin
                           Area:=0;
                           if Ambienti_D^[CodAmb]^.HSoffitto<>0 then Area:=LungMuro*Ambienti_D^[CodAmb]^.HSoffitto
                            else
                             begin
                                if Ambienti_D^[CodAmb]^.Zona<>0 then
                                 begin
                                    if Zone_D^[Ambienti_D^[CodAmb]^.Zona].HSoffittoRicorr<>0 then
                                      Area:=LungMuro*Zone_D^[Ambienti_D^[CodAmb]^.Zona].HSoffittoRicorr
                                    else Area:=LungMuro * Prog^.AltPianoLorda {Edificio_D^.HSoffittoRicorr};
                                 end;
                             end;
                           SupMuro:=Area;
                        end;
                       if (CodAmb = CercaAmb) then
                        begin
                           if inrange(CodEsposiz,1,maxesposizioni) then
                            if (formst(esposizioni_d^[CodEsposiz].tipo)=CH7) then
                             {  (formst(esposizioni_d^[CodEsposiz].CodPav) > '') then }
                             begin
                                TrovatoE:=true;
                               { if ControllaPavSuTer(indp,CodEsposiz) then
                                 begin
                                   TipoMur:=2;
                                   if UnicoPav(CodEsposiz,CercaAmb) then
                                    begin
                                      SNettaE:=SNettaE+SupMuro*Amb_D^[CercaAmb]^.AmbientiUguali;
                                      LungKE:=LungKe+CalcPerimetro(cercaamb)*Amb_D^[CercaAmb]^.AmbientiUguali;
                                    end
                                   else
                                    begin
                                       SNettaE:=PavSuTer^[indp].area;
                                       LungKE:=PavSuTer^[indp].Perimetro;
                                    end;
                                end
                               else
                                begin}
                                   if (CodMuro2<>X)  then SNettaE:=SNettaE+(SupMuro-SUPMURO2-SUPFINESTRA-SUPPORTA)*
                                                                   Ambienti_D^[CercaAmb]^.AmbientiUguali
                                   else SNettaE:=SNettaE+(SupMuro-SUPFINESTRA-SUPPORTA)*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                               { end;}

                               SLordaE:=SLordaE+SupMuro*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                             end;
                        end
                       else
                        begin

                           X1:=SupMuro*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                           if (CodMuro2<>X)  then X2:=(SupMuro-SUPMURO2-SUPFINESTRA-SUPPORTA)*
                                                      Ambienti_D^[CercaAmb]^.AmbientiUguali
                           else X2:=(SupMuro-SUPFINESTRA-SUPPORTA)*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                           //if Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc then
                           // Emanuela 21/4/2006 messa la condizione che appartengono allo atesso alloggio
                           if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                              (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                            then
                            begin
                               SlordaZ:=SlordaZ+X1;
                               SNettaz:=SNettaZ+X2;
                               TrovatoZ:=true;
                            end
                           else
                            begin
                               SlordaI:=SlordaI+X1;
                               SNettaI:=SNettaI+X2;
                               TrovatoI:=true;
                            end;
                        end
                    end
                   else
                   if (CodMuro2=X)  then
                    begin
                       if (CodAmb = CercaAmb) then
                        begin
                           TrovatoE:=true;
                           SLordaE:=SLordaE+SupMuro2*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                           SNettaE:=SNettaE+SupMuro2*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                        end
                       else
                        begin
                           X1:=SupMuro2*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                           X2:=SupMuro2*Ambienti_D^[CercaAmb]^.AmbientiUguali;
                           //if Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc then
                           // Emanuela 21/4/2006 messa la condizione che appartenga allo stesso alloggio
                           if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                              (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                            then
                            begin
                               SlordaZ:=SlordaZ+X1;
                               SNettaz:=SNettaZ+X2;
                               TrovatoZ:=true;
                            end
                           else
                            begin
                               SlordaI:=SlordaI+X1;
                               SNettaI:=SNettaI+X2;
                               TrovatoI:=true;
                            end;
                        end
                    end;
                   END;
              end;
             if TrovatoE then StampaLineaNR(true);
             if TrovatoZ then
               begin
                  StampaLineaNR(false);
                  Trovatoz:=false;
               end;
             if TrovatoI then StampaLineaNR(false);
           end;
       end;
end;


// ---------------------------
// Funzione Trova Zona Termica
// ---------------------------

function TrovaZona(NumLocNRisc:real):Boolean;
var i:smallint;
    Trovato:boolean;

begin
   i:=1;
   Trovato:=false;
   repeat
    with Frontiere_D^[i]^ do
     begin
        if (CodEsposiz > 1000) and (CodEsposiz=NumLocNRisc) then
         begin
           if (CodAmb >= 1 )and(codamb <= NAmbienti) then
           if disp then
            begin
             if (Ambienti_D^[CodAmb]^.Denom > '') then Trovato:=true;
            end
           else // Emanuela 21/4/2006 messa la condizione che appartenga allo stesso alloggio
                if (Ambienti_D^[CodAmb]^.Z10=ZonaCalc) and
                   (CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[CodAmb].Impianto)].GenInvt)) = 0)
                and (Ambienti_D^[CodAmb]^.Denom > '')
                then Trovato:=true;
           //if (Zone_d^[Ambienti_D^[CodAmb]^.Zona].ZonaLegge10=ZonaCalc) and (Ambienti_D^[CodAmb]^.Denom > '') then Trovato:=true;
         end;
        if not Trovato then i:=i+1;
     end;
   until trovato or (i > NFrontiere);
   TrovaZona:=Trovato;
end;


begin

   prn_TotH^.HLocNr:=0;
   prn_TotH^.Hvent:=0;
   Pass:=true;

   for i:=1 to Nzone do
    begin
       //ZonaNonRisc:= (Zone_D^[i].zonalegge10=0) and (Zone_D^[i].HSoffittoRicorr <> 0);
       ZonaNonRisc:= false;
       {((Zone_D^[i].ProfiloImpiantoInv=0) and (Zone_D^[i].ProfiloImpianto=0)) or}
       if ZonaNonRisc then
        begin
           for j:=1 to NAmbienti do
            begin
               Totali.totHiz:=0;  Totali.totHue:=0;  Totali.totHiu:=0; Totali.TotHie:=0; Totali.TotHieTot:=0;

               if (Ambienti_D^[j]^.Zona=i) then
               if TrovaZona(strtofloat(Ambienti_D^[j]^.CodNum)) then
                begin                                   { cod 2 pavsuter }
                   ParetNonRisc(j,strtofloat(Ambienti_D^[j]^.CodNum),1); { pareti   }
                   ParetNonRisc(j,strtofloat(Ambienti_D^[j]^.CodNum),3); { porte    }
                   ParetNonRisc(j,strtofloat(Ambienti_D^[j]^.CodNum),4); { finestre }
                   ParetNonRisc(j,strtofloat(Ambienti_D^[j]^.CodNum),5); { ponti    }
                   ParetNonRisc(j,strtofloat(Ambienti_D^[j]^.CodNum),6); { ventilazione }
                end;

         (*      if Totali.TotHiu+Totali.TotHue <> 0 then
                Totali.TotHie:=(Totali.TotHiu*Totali.TotHue)/(Totali.TotHiu+Totali.TotHue)
               else Totali.TotHie:=0; *)

               if Totali.TotHiu+Totali.TotHue <> 0 then
                Totali.TotHieToT:=(Totali.TotHiu*Totali.TotHue)/(Totali.TotHiu+Totali.TotHue);
               if Totali.TotHiu <> 0 then
                Totali.TotHie:=Totali.TotHiz*Totali.TotHietot/Totali.TotHiu;
                  { Totali.TotHie:=Totali.TotHiz-Totali.TotHiz*((1/Totali.TotHue)/((1/Totali.TotHiu)+(1/Totali.TotHue)));}
              {  end
               else
                begin
                   Totali.TotHie:=0;
                   Totali.TotHieTot:=0;
                end; }
               prn_TotH^.HLocNr:=prn_TotH^.HLocNr+Totali.TotHie;

            end;
        end;
    end;

end;

end.


