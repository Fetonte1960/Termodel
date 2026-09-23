unit procle13;
interface

uses
  // proccalc, defutig,
  Dialogs,
  metod10,Varcarichi,UVariabili,utireport,SysUtils, LibreriaGenerale, FunzProc1, Udb;

procedure stampatotzona(var npag,nr:smallint);
Function UltimoPiano: smallint;
function CalcVolZona:real;
procedure StampVentRel(var npag,Nr:smallint);

implementation
uses Procle10;

procedure stampatotzona(var Npag,Nr:smallint);
//type
  {stampQ=record
            DescM:string[115];
            Tot:array[1..12] of real;
          end;}

var i,j,Pag,lm:smallint;
  //  StQ:^stampQ;
    str1,str2,str3,str4:string[20];
    DM:array[1..12] of string[3];
   // TotDisp:^vetreal;

procedure stampatempop;
var Ca,Cb:real;
    ica,icb,i,j:smallint;
    trasmMStr:real;
    Hk:real;

const arca:array[1..9] of real=(0.0,0.0,0.0,0.015,0.025,0.030,0.030,0.04,0.04);
      arcb:array[1..9,1..6] of real=((0.95,0.92,0.90,0.88,0.87,0.86),
                                     (0.95,0.92,0.90,0.88,0.87,0.86),
                                     (0.95,0.92,0.90,0.88,0.87,0.86),
                                     (0.97,0.95,0.94,0.92,0.91,0.90),
                                     (0.98,0.96,0.95,0.93,0.93,0.92),
                                     (0.99,0.98,0.96,0.95,0.95,0.95),
                                     (0.99,0.98,0.96,0.95,0.95,0.95),
                                     (0.99,0.98,0.96,0.95,0.95,0.95),
                                     (0.99,0.98,0.96,0.95,0.95,0.95));

function selicb(u:real):smallint;
begin
  if {(u>=0.2) and} (u<0.4) then selicb:=1;
  if (u>=0.4) and (u<0.6) then selicb:=2;
  if (u>=0.6) and (u<0.8) then selicb:=3;
  if (u>=0.8) and (u<1.0) then selicb:=4;
  if (u>=1.0) and (u<1.2) then selicb:=5;
  if (u>=1.2)             then selicb:=6;

end;

 { TODO -oGenerale -cIndice : Calcolo riepilogo di Zona }
begin
  j:=ZonaCalc;
  if zone10^[j].taria > 0 then
  begin
    //Hk:=HgZona+prn_TotH^.HtotZona+HTrasmEspNonRisc;
    Hk:=prn_TotH^.HTerreno + prn_TotH^.HtotZona + HTrasmEspNonRisc;
    if AreaZona <> 0 then trasmMStr:=(Hk-HvZona)/AreaZona
    else trasmMStr:=0;
    for i:=1 to 12 do
    begin
      ica:=pdati10.CodTipoTerm;  {usa zonaCalc}
      icb:=selicb(trasmMStr);
      ca:=arca[ica];
      cb:=arcb[ica,icb];
      tempintmed^[j,i]:=tempestmed^[i]+
                        ((zone10^[j].taria-tempestmed^[i])*
                        (1+ca*pdati10.PortMecNat/AreaZona)*cb);
    end;

    fillchar(stq^,sizeof(stq^),0);

    Stq^.DescM:=' [TOp] ANDAMENTO DELLA TEMPERATURA MEDIA OPERANTE NELLA ZONA  [øC]';
    for i:=1 to MesiRisc do Stq^.Tot[i]:=tempintmed^[ZonaCalc,Indmese^[i]];
  end;
end;
procedure ScambioEspNonRisc;

var i,j,a:smallint;
    TotH,SDt:STRING[20];
    Dt:real;
    tz: qdtubi;
    TotQa: array[1..12] of real;

procedure Trova_Temp(Cod1:string;var tz:qdtubi);
var k,j:smallint;
    Tr:boolean;

begin
  Cod1:=formst(Cod1);

  tr:=false;
  k:=1;
  repeat
   if Cod1=formst(tempac^[k].cod) then tr:=true;
     if not Tr then k:=k+1;
  until tr or (k > maxtempAC);

  if tr then
     for j:=1 to MesiRisc do tz[IndMese^[j]]:=tempac^[k].temp[IndMese^[j]];
end;

Function Trif_inv(Esp,mese:integer;TInt:real):real;
Var Dtmese,DtMax,dtesp:real;
begin
Dtmax:=Tint-TempEstMed^[1];
Dtmese:=Tint-TempEstMed^[mese];
dtesp:=Tint-esposizioni_d^[i].TrifInv;
result:=esposizioni_d^[esp].TrifInv-DtMax/dtesp*Dtmese
end;

begin

InizioTabella('TABRIEP_QA', 11);
for j:= 1 to 12 do TotQa[j]:= 0;
   for i:=1 to Nesposizioni do
    begin

       if (TotHEspLocFissi^[i] > 0) and (formst(esposizioni_d^[i].CodOst)='') then
        begin

           STR(TotHEspLocFissi^[i]:8:2,TotH);
           if Prog^.TempOff = '*' then
            begin
               fillchar(stq^,sizeof(stq^),0);
               Stq^.DescM:=' [dTa] DELTA T CON '+esposizioni_d^[i].denom+'  [øC]';
               // confini interni 19/6/2006 compensazione stagionale dei locali non riscaldati
               for j:=1 to MesiRisc do
                 //  Stq^.Tot[j]:=TempCalc(IndMese^[j])-Trif_Inv(i,j,TempCalc(IndMese^[j]);
                 Stq^.Tot[j]:=TempCalc(IndMese^[j])-esposizioni_d^[i].TrifInv;
               fillchar(stq^,sizeof(stq^),0);
               Stq^.DescM:=' [Qa] SCAMBIO CON '+esposizioni_d^[i].denom +' = 86400 x N x dTa x Ha [MJ] ; Ha = '+TotH;
               for j:=1 to MesiRisc do
                begin
                   Dt:=TempCalc(IndMese^[j])-esposizioni_d^[i].TrifInv;
                   //Dt:=TempCalc(IndMese^[j])- Trif_Inv(i,j,TempCalc(IndMese^[j]));
                   Stq^.Tot[j]:=0.0864*GiorMese(IndMese^[j])*Dt*TotHEspLocFissi^[i];
                   TotDisp^[j]:=TotDisp^[j]+Stq^.Tot[j];
                end;
            end
           else
            begin

            Dt:=pdati10.TiAmbx-esposizioni_d^[i].TrifInv;
            //Dt:=pdati10.TiAmbx-Trif_Inv(i,j,TempCalc(IndMese^[j]);
            Str(Dt:5:2,SDt);
            fillchar(stq^,sizeof(stq^),0);
            Stq^.DescM:=' [Qa] SCAMBIO CON '+esposizioni_d^[i].denom +' = 86400 x N x dTa x Ha [MJ] ; Ha = '+TotH+' Dta = '+SDt;

            Wrep_str('HAT', TotH);
            Wrep_str('DTA', Sdt);

             for j:=1 to MesiRisc do
              begin
                 Stq^.Tot[j]:=0.0864*GiorMese(IndMese^[j])*Dt*TotHEspLocFissi^[i];
                 TotDisp^[j]:=TotDisp^[j]+Stq^.Tot[j];
              end;
             for j:= 1 to MesiRisc do TotQa[j]:= TotQa[j]+ Stq^.Tot[j];
             for a:= 1 to 2 do
             begin

             // -----------------------------
             // Stampe Riepilogo Locali Fissi
             // -----------------------------

             WStrTab(esposizioni_d^[i].Codice);
             WStrTab(SDt);
             WRealeTab(TotHEspLocFissi^[i],1);
             WrealeTab(0,0);

             for j:=1 to 6 do
              if a = 1 then WrealeTab(DT,2)
               else WrealeTab(Stq^.Tot[j],0);
              if a = 1 then WstrTab('DTi [°C]')
              else WstrTab('QAi [MJ]');
             FineRigaTabella;
             end;
            end;
        end;
    end;

FineTabella;
for j:=1 to mesirisc_st do W_MesiL10_real(j,'QA_',TotQa[j],0,IndMese^[j], MesiRisc_St);

   for i:=1 to Nesposizioni do
    begin
       if (TotHEspLocFissi^[i] > 0) and (formst(esposizioni_d^[i].CodOst) > '')  then
        begin
           Trova_Temp(esposizioni_d^[i].CodOst,Tz);
           fillchar(stq^,sizeof(stq^),0);
           Stq^.DescM:=' [dTa] DELTA T CON '+esposizioni_d^[i].denom+'  [øC]';
           for j:=1 to MesiRisc do Stq^.Tot[j]:=TempCalc(IndMese^[j])-Tz[IndMese^[j]];
           fillchar(stq^,sizeof(stq^),0);
           STR(TotHEspLocFissi^[i]:8:2,TotH);
           Stq^.DescM:=' [Qa] SCAMBIO CON '+esposizioni_d^[i].denom +' = 86400 x N x dTa x Ha [MJ] ; Ha = '+TotH;
           for j:=1 to MesiRisc do
            begin
               Dt:=TempCalc(IndMese^[j])-Tz[IndMese^[j]];
               Stq^.Tot[j]:=0.0864*GiorMese(IndMese^[j])*Dt*TotHEspLocFissi^[i];
               TotDisp^[j]:=TotDisp^[j]+Stq^.Tot[j];
            end;
        end;
    end;
end;


begin
 //  new(TotDisp);
 //  new(STq);

   for i:=1 to 12 do
    if IndMese^[i] in[1..12] then
     begin
       DM[i]:=Mese_Ita[IndMese^[i]];
       MesiRisc:=i;
     end
   else DM[i]:='';
   for i:=1 to 12 do  TotDisp^[i]:=0;
   if Prog^.TempOff = '*' then  stampatempop;

   {  Dt con esterno  }
  { DtMed:=0;}
   fillchar(stq^,sizeof(stq^),0);
   if Prog^.TempOff = '*' then
   Stq^.DescM:=' [dTe] DELTA T CON L''ESTERNO  TOp - TEM [øC]'
   else Stq^.DescM:=' [dTe] DELTA T CON L''ESTERNO  T - TEM [øC]';
   for j:=1 to MesiRisc do
    begin

 { TODO -oFabio -cDa Fare : 05_07_2004 Verificare da quale tabella carica le temperature medi eprosp_VI_10349 }
       Stq^.Tot[j]:=DTEstZona(IndMese^[j]);
       {DtMed:=DtMed+Stq^.Tot[j];}
    end;

   for j:=1 to mesirisc_st do W_MesiL10_real(j,'DTE_',Stq^.Tot[j],2,IndMese^[j], MesiRisc_St);

  { DtMed:=DtMed/MesiRisc;}


   {  N giorni del Mese di riscaldamento }
   fillchar(stq^,sizeof(stq^),0);
   Stq^.DescM:=' [N] NUMERO GIORNI DEL MESE ';
   for j:=1 to MesiRisc do Stq^.Tot[j]:=GiorMese(IndMese^[j]);

   for j:=1 to mesirisc_st do W_MesiL10_real(j,'N_',Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);

   {  scambio con l esterno }
   fillchar(stq^,sizeof(stq^),0);
   Stq^.DescM:=' [Qest] SCAMBIO CON L''ESTERNO  86400 x N x dTe x Hest [MJ] ';
   for j:=1 to MesiRisc do
    begin
       Stq^.Tot[j]:=0.0864*GiorMese(IndMese^[j])*DTEstZona(IndMese^[j])*prn_TotH^.HtotZona;
       TotDisp^[j]:=TotDisp^[j]+Stq^.Tot[j];
    end;

    for j:=1 to mesirisc_st do W_MesiL10_real(j,'QT_',Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);
   {$IFDEF VERSIONE_13}
   { dm1.tt3.First;
    for i:=1 to 12 do
    begin
      dm1.tt3.edit;
      dm1.tt3.fieldbyname('Perdite').AsFloat := Round(Stq^.Tot[i]);
      dm1.tt3.Post;
      dm1.tt3.Next;
    end;  }
   {$ENDIF}
    W_Reale('HEST', prn_TotH^.HtotZona, 1);


    // 22-07-2004 Fabio - Parte commentata perchè sembra che non
    // abbia a che fare con calcoli relativi alla zona confinante con il terreno.
   {
   for j:=1 to MesiRisc do
      Stq^.Tot[j]:=0.0864*GiorMese(IndMese^[j])*DTEstZona(IndMese^[j])*prn_TotH^.HTerreno;
   for j:=1 to mesirisc_st do W_MesiL10_real(j,'QG_',Stq^.Tot[j],1);
   }

    // Stampa Totale HG del Terreno
    W_Reale('HGTERR', prn_TotH^.HTerreno, 2);


// 22-07-2004 Commentata - vedi sopra stessa data
//   if HgZona > 0 then
   if prn_TotH^.HTerreno > 0 then
    BEGIN
       if Prog^.TempOff = '*' then
        begin
           {  Dt con il terreno  }
           fillchar(stq^,sizeof(stq^),0);
           Stq^.DescM:=' [dTs] DELTA T PER LO SCAMBIO CON IL TERRENO  [øC]';
           for j:=1 to MesiRisc do Stq^.Tot[j]:=TempCalc(IndMese^[j])- calctestmed;
        end;

       {  scambio con il terreno }

       // 22-07-2004 Commentata - vedi sopra stessa data
       STR(prn_TotH^.HTerreno:8:2,Str1);
       fillchar(stq^,sizeof(stq^),0);
       if Prog^.TempOff = '*' then Stq^.DescM:=' [Qg] SCAMBIO CON IL TERRENO 86400 x N x dTs x Hg ('+str1+') [MJ] '
       else
        begin
           Str(pdati10.TiAmbx-calctestmed:5:2,Str2);
           Stq^.DescM:=' [Qg] SCAMBIO CON IL TERRENO 86400 x N x dTs ('+str2+') x Hg ('+str1+') [MJ] ';
           Wrep_str('DELTA_TS',Str2); // Stampa del valore dTs
        end;
       for j:=1 to MesiRisc do
        begin
//           22-07-2004 Commentata - vedi sopra stessa data
//           Stq^.Tot[j]:=0.0864*GiorMese(IndMese^[j])*(TempCalc(IndMese^[j])-calctestmed)*HgZona;
           Stq^.Tot[j]:=0.0864*GiorMese(IndMese^[j])*(TempCalc(IndMese^[j])-calctestmed)*prn_TotH^.HTerreno;
//           22-07-2004 Scommentata - perchè mancava il contributo di QG in QL
           TotDisp^[j]:=TotDisp^[j]+Stq^.Tot[j];
        end;
//  Eliminato il totale pavimento perchè aggiunto nel TotH
// Vedi il seguente punto : Stampa Totale HG del Terreno

       for j:=1 to mesirisc_st do W_MesiL10_real(j,'QG_',Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);


    END;
//   else
//    for j:=1 to mesirisc_st do W_MesiL10_real(j,'QG_',0,0);
   {  scambio per ventilazione }

   ScambioEspNonRisc;

   fillchar(stq^,sizeof(stq^),0);
   Stq^.DescM:=' [QL] TOTALE DISPERSIONI Qest + Qg + Qa  [MJ] ';
   for j:=1 to MesiRisc do
    begin
       Stq^.Tot[j]:=TotDisp^[j];
       Ql^[IndMese^[j]]:=Stq^.Tot[j];
    end;
   for j:=1 to mesirisc_st do
   begin
      if IndMese[j] in [1..12] then
         W_MesiL10_real(j, 'QL_', Ql^[IndMese^[j]], 0, IndMese^[j], MesiRisc_St);
   end;
   if Flag10 then
   BEGIN
   Stq^.DescM:='TOTALE IRRAGGIAMENTO Qs  [MJ] ';
   for j:=1 to MesiRisc do
      Stq^.Tot[j]:=TotQsi^[indMese^[j]]+TotQse^[indMese^[j]];

   for j:=1 to mesirisc_st do
    if Stq <> nil then
       W_MesiL10_real(j,'QS_',Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);
   for j:=1 to mesirisc_st do
    if (TotQsi <> nil) and (IndMese <> nil) then
     if IndMese[j] in [1..12] then
        W_MesiL10_real(j,'QSI_',TotQsi^[indMese^[j]],0,IndMese^[j], MesiRisc_St);
   for j:=1 to mesirisc_st do
    if (TotQse <> nil) and (IndMese <> nil) then
     if IndMese[j] in [1..12] then
        W_MesiL10_real(j,'QSE_',TotQse^[indMese^[j]],0,IndMese^[j], MesiRisc_St);
   {$IFDEF VERSIONE_13}
   { dm1.tt3.First;
    for i:=1 to 12 do
    begin
      dm1.tt3.edit;
      dm1.tt3.fieldbyname('App.Interni').AsFloat := Round(TotQse^[i]);
      dm1.tt3.fieldbyname('App.Solari').AsFloat := Round(TotQsi^[i]);
      dm1.tt3.fieldbyname('App.Totali').AsFloat := Round(Stq^.Tot[i]);
      dm1.tt3.Post;
      dm1.tt3.Next;
    end;    }
   {$ENDIF}

   // 03-08-2oo4 Stampa Tabella Articolo 7
   // Salvataggio del valore di Qs del mese di Marzo
   // Marzo come mese di maggiore insolazione (da controllare)
   ValoreArt7.Mese := 'Marzo';
   ValoreArt7.RadSolare := ValoreArt7.RadSolare + Stq^.Tot[5];
   STR(Qi^[ZonaCalc]:8:1,Str1);
   Stq^.DescM:='TOTALE APPORTI GRATUITI  ( Sorgenti Interne [Qi] '+Str1+' )'+' [MJ]';
   for j:=1 to MesiRisc do Stq^.Tot[j]:=Stq^.Tot[j]+Qi^[ZonaCalc];
   for j:=1 to mesirisc_st do W_MesiL10_real(j,'QGR_',Stq^.Tot[j]+Qi^[ZonaCalc],0,IndMese^[j], MesiRisc_st);

   Wrep_str('QI',Str1); // Stampa del valore Qi relativo alle sorgenti interne

   // Salvataggio del valore di Qi del mese di Marzo
   ValoreArt7.AppInt:= ValoreArt7.AppInt + Qi^[ZonaCalc];
   Stq^.DescM:=' GAMMA ';
   for j:=1 to MesiRisc do
       Stq^.Tot[j]:=CalcGamma(IndMese^[j]);
   for j:=1 to mesirisc_st do
       W_MesiL10_real(j,'GAM_',Stq^.Tot[j],2,IndMese^[j], MesiRisc_St);
   {$IFDEF VERSIONE_13}
   { dm1.tt3.First;
    for i:=1 to 12 do
    begin
      dm1.tt3.edit;
      dm1.tt3.fieldbyname('Eta').AsFloat := Round(Stq^.Tot[i]);
      dm1.tt3.fieldbyname('Gamma').AsFloat := Round(TotQsi^[i]);
      dm1.tt3.Post;
      dm1.tt3.Next;
    end;        }
   {$ENDIF}
   Stq^.DescM:=' [Eu] FATTORE DI UTILIZZAZIONE DEGLI APPORTI GRATUITI ';
   for j:=1 to MesiRisc do
    begin
{ TODO -oDiego -cDa Fare : ATTENZIONE:Apporti gratuiti provvisioriamene disabilitati }
       // 16/02/2004 ATTENZIONE:Apporti gratuiti provvisioriamene disabilitati
       //TotQsi^[j] := 0; lo sto facendo
       // 16/02/2004 ATTENZIONE:Apporti gratuiti provvisioriamene disabilitati

       Stq^.Tot[j]:=CalcEu(IndMese^[j]);
      { Ku:=Ku+Stq.Tot[j];
       ContKu:=ContKu+1;}
    end;
    for j:=1 to mesirisc_st do W_MesiL10_real(j,'EU_',Stq^.Tot[j],1,IndMese^[j], MesiRisc_St);
   END;
   {$IFDEF VERSIONE_13}
   { dm1.tt3.First;
    for i:=1 to 12 do
    begin
      dm1.tt3.edit;
      dm1.tt3.fieldbyname('Gamma').AsFloat := Stq^.Tot[i];
      dm1.tt3.Post;
      dm1.tt3.Next;
    end;    }
   {$ENDIF}



   for j:=1 to MesiRisc do
       CalcolaZona(IndMese^[j]);

   STR(TabZona10^.t1:3:2,Str1);
   STR(TabZona10^.t2:3:2,Str2);
   STR(Nag:2:0,Str3);
   STR(Ndg:2:0,Str4);

   Stq^.DescM:=' [Fig] FATTORE DI RIDUZIONE DELL''APPORTO DELLE SORGENTI INTERNE E SOLARI    t'' = '+Str1+' t" = '+Str2;
   for j:=1 to MesiRisc do Stq^.Tot[j]:=Fig^[IndMese^[j]];
   for j:=1 to mesirisc_st do W_MesiL10_real(j,'FIG_',Stq^.Tot[j],1,IndMese^[j], MesiRisc_St);

   Wrep_str('T01',Str1);  // Stampa di t'
   Wrep_str('T02',Str2);  // Stampa di t''

   Stq^.DescM:=' [Fil] FATTORE DI RIDUZIONE DELL''ENERGIA DISPERSA PER TRASMISSIONE E VENTILAZIONE   N''ag = '+
              Str3+' N''dg = '+Str4;
   for j:=1 to MesiRisc do Stq^.Tot[j]:=Fil^[IndMese^[j]];
   for j:=1 to mesirisc_st do W_MesiL10_real(j,'FIL_',Stq^.Tot[j],1,IndMese^[j], MesiRisc_St);

   Wrep_str('NAG',Str3);  // N° ore di spegnimento impianto dalle 8 alle 16
   Wrep_str('NDG',Str4);  // N° ore di attenuazione/spegnimento impianto dalle 8 alle 16

   Stq^.DescM:=' [Qh] FABBISOGNO IN REGIME CONTINUO = (QL-Qse)-Euú(Qi+Qsi)  [MJ] ';
   for j:=1 to MesiRisc do
    begin
       Stq^.Tot[j]:=(Ql^[IndMese^[j]]-TotQse^[IndMese^[j]])-
                       CalcEu(IndMese^[j])*(TotQsi^[IndMese^[j]]+Qi^[ZonaCalc]);
       if Stq^.Tot[j] < 1 then Stq^.Tot[j]:=0;
    end;
    for j:=1 to mesirisc_st do W_MesiL10_real(j,'QH_',Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);

   STR(TabZona10^.K:3:2,Str1);
   Stq^.DescM:=' [Qhvs] FABBISOGNO IN CONDIZIONI REALI (Intermittenza) = kú[Filú(QL-Qse)-EuúFigú(Qsi+Qi)] [MJ]   k = '+Str1;
   for j:=1 to MesiRisc do Stq^.Tot[j]:=MatQhvs^[IndMese^[j],Zonacalc];
   for j:=1 to mesirisc_st do W_MesiL10_real(j,'QHVS_',Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);

   Wrep_str('KAPPA',Str1);  // Stampa valore di Kappa
   STR(CalcEe:4:4,Str1);
   STR(CalcEc(IndMese^[1]):4:4,Str2);
   STR(Zone11^[ZonaCalc].PotH2O:8:1,Str3);
   Stq^.DescM:=' [Qhr] FABBISOGNO (Intermittenza) = Qhvs/(EeúEc) + Qh2o [MJ] Ee = '+Str1+' Ec = '+Str2+
              ' Qh2o ='+Str3;
   for j:=1 to MesiRisc do Stq^.Tot[j]:=MatQhr^[IndMese^[j],ZonaCalc];
   for j:=1 to mesirisc_st do W_MesiL10_real(j,'QHR_',Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);

{ TODO -oFabio -cControllare :
Controllare se i valori di Eta c ed Eta e vanno espressi in % oppure con
notazione 0.9912. }

//   Wrep_str('EE', Str1);        // Stampa valore Rendimento di emissione Eta E
//   Wrep_str('EC', Str2);        // Stampa valore Rendimento di regolazione Eta C

   W_reale('EE', Str_ToFloat(Str1)*100,2);        // Stampa valore Rendimento di emissione Eta E
   W_reale('EC', Str_ToFloat(Str2)*100,2);        // Stampa valore Rendimento di regolazione Eta C
 {$IF Defined(VERSIONE_12)}
  DatiAtt.ETA_EMISS := Str_ToFloat(Str1)*100;
  DatiAtt.ETA_REG   := Str_ToFloat(Str2)*100;
 {$ELSEIF Defined(VERSIONE_13)}
  DatiAtt[Gencor-1].ETA_EMISS := Str_ToFloat(Str1)*100;
  DatiAtt[Gencor-1].ETA_REG   := Str_ToFloat(Str2)*100;
 {$IFEND}
   Wrep_str('QH2O', Str3);      // Stampa valore QH2O
   Stq^.DescM:=' [Qhr-24] FABBISOGNO (24 ore)= Qh/(EeúEc) + Qh2o [MJ] Ee = '+Str1+' Ec = '+Str2+' Qh2o ='+Str3;
   for j:=1 to MesiRisc do Stq^.Tot[j]:=MatQhr24^[IndMese^[j],ZonaCalc];
   for j:=1 to mesirisc_st do W_MesiL10_real(j,'QHRC_',Stq^.Tot[j],0,IndMese^[j], MesiRisc_St);

   // Fabio 29-10-2004 Correzione: eliminate dalla stampa L10 informazioni ripetute
   // Wrep_str('EEC', Str1);        // Stampa valore Rendimento di emissione Eta E
   // Wrep_str('ECC', Str2);        // Stampa valore Rendimento di regolazione Eta C
   // Wrep_str('QH2OC', Str3);      // Stampa valore QH2O
end;

function CalcVolZona:real;
var
   i:smallint;
   Vol:real;
begin
  { PortMecZona:=0;}
  { PortNatZona:=0;}
   Vol:=0;
   for i:=1 to NAmbienti do
    with Ambienti_D^[i]^ do
     begin
     //if (Zone_D^[Zona].Zonalegge10=ZonaCalc) then

        if (Z10=ZonaCalc) then
         begin
            Vol:=Vol+(hsoffitto*superficie*AmbientiUguali);
           { PortMecZona:=PortMecZona+(hsoffitto*superficie*Ventilazione);} {m3/h}
           { PortNatZona:=PortNatZona+(hsoffitto*superficie*InfInv); } {m3/h}
         end;
     end;
   CalcVolZona:=Vol;

end;

Function UltimoPiano: smallint;
begin
   result := NPiani;
end;

procedure StampVentRel(var npag,Nr:smallint);

type
   RecSt=record
           Str1: string[20];
           V1,V2,V3,V4,V5:real;
         end;
var
   i,x:smallint;
   StVent:RecSt;

begin
   for i:=1 to NZone10 do
    begin
       fillchar(StVent,sizeof(StVent),0);
       StVent.Str1:=Zone10^[i].descr;
       StVent.V1:=VentForzZona^[i].Port;
       StVent.V2:=Zone11^[i].PortLegM;
       StVent.V3:=Zone10^[i].PortMec;
       if Zone10^[i].EtaRecup > 0 then
        begin
           StVent.V4:=Zone10^[i].PortMec;
           StVent.V5:=Zone10^[i].EtaRecup*100;
        end;
    end;
end;
  

end.
