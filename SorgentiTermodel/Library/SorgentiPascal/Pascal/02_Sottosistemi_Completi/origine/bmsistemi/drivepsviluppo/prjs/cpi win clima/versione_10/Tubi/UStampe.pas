unit UStampe;

interface
Uses SysUtils, Definiz,Varcarichi, Utireport, Variabiligenerali, UdataLink, DB,
     DBTables, LibreriaGenerale, Math, Classes, Dialogs, Msg,pannelli;

Type
  PImpianto = ^Impianto;
  Impianto = Record
               CodImp, DescImp: String;
               Est: Char;
               Tiai, Tiae: Real;
               Sti, ste: Real;
             end;
var
  ListaImpianti: TList;

Procedure Prepararep(pathrep:string);
Procedure Settasfavorito;
// Funzioni e procedure create da Emanuela
Function DatiProgetto(Tag: Integer): String;
Procedure CreaTabellaTerminali;
Function DescrizioneLocale(Codice: Integer): String;
procedure CreaTabellaVentilConvettori;
Function EsistonoTerminali: Boolean;
Function EsistonoVentilConvettori: Boolean;
Function TipoCollettore(Codice: String): Boolean;
Function DescCollettore(Codice: String): String;
procedure StampaTerminali;
Procedure TrovaImpianto(CodiceL: Integer; Est: Char);
procedure DatiImpianto(CodImpianto: String; var Tai, Tae, Sti, Ste: real; var Desc: String);
procedure StampaImpianti;
procedure CaricaDatiImpianti;

implementation
uses init_cad3d;
  Procedure Settasfavorito;
    Function Itersetta(indtr:integer):boolean;
    Var i:integer;
    begin
      result:=false;
      With Dati^[indtr]^ do
      begin
        if indtr=risultcalc.Sfavor then result:=true
        else
        for i:=1 to npros do
        if not result then result:=Itersetta(pros[i]);
        if result then sfavorito:='*' else sfavorito:='';
      end
    end;
  begin
    itersetta(risultcalc.Origine);
  end;

 Function TipoCollettore(Codice: String): Boolean;
 var
   Trovato: Boolean;
   i: Integer;
 begin
   Result := False;
   i := 1;
   Trovato := False;
   While (not Trovato) and (i <= NTipiRete) do
   begin
     if TipiRete_D^[i].Cod = Codice Then
     begin
      if UpperCase(TipiRete_D^[i].TipoColle) = 'SI' then
      begin
       Trovato := True;
       Result := True;
      end;
     end;
     inc(i);
   end;
 end;

 Function DescCollettore(Codice: String): String;
 var
   Trovato: Boolean;
   i: Integer;
 begin
   Result := '';
   i := 1;
   Trovato := False;
   While (not Trovato) and (i <= NTipiRete) do
   begin
     if TipiRete_D^[i].Cod = Codice Then
     begin
      Trovato := True;
      Result := TipiRete_D^[i].Descr;
     end;
     inc(i);
   end;
 end;

 function UsatoTipo(Codice: String): Boolean;
 var
   Trovato: Boolean;
   i: Integer;
 begin
   Result := False;
   i := 1;
   Trovato := False;
   While (not Trovato) and (i <= Ulttronco) do
   begin
     if Dati^[i]^.Tipo = Codice Then
     begin
       Trovato := True;
       Result := True;
     end;
     inc(i);
   end;
 end;

 Procedure Prepararep(pathrep:string);
 Var Numtr, k, ind:integer;
     Maxvel,maxvelsfav,totlungsfav,totplsfav,totpdsfav,perdtermsfav:real;
     cotermsfav,tipotermsfav:string;
     ListaCollettori: TStringList;
     CodColl, PianoColl, DescColl, DiamColl, St: String;
 const divrit=2;

    Procedure IterStampa(indtr,Numpadre:integer);
    Var
       i, j:integer;
       Trovato: Boolean;
       DatiColl: String;
    begin
    With Dati^[indtr]^ do
    begin
     if (Lungh <> 0){and(sfavorito='*')} then
     begin
      if not TipoCollettore(Tipo) then
      begin
          WrealeTab(CodiceTubo, 0);
          WstrTab(Tipo);
          WstrTab(Piano);
          WstrTab(sfavorito);
          WrealeTab(Lungh, 2);
          if sfavorito='*' then
            begin
            totlungsfav:=totlungsfav+lungh;
            totplsfav:=totplsfav+pl;
            totpdsfav:=totpdsfav+pd;
            end;
          If term <> 0 then
          begin
           if Gterm^[term]^.Cod <> '???' then
           begin
              if sfavorito='*' then
              begin
                cotermsfav:=Gterm^[term]^.Cod;
                tipotermsfav:=Gterm^[term]^.Modello;
                perdtermsfav:=Gterm^[term]^.perd;
              end;
              WstrTab(Gterm^[term]^.Cod);
           end
           else WstrTab('');
           if NGEffTUtil < MaxGTerm then
              Inc(NGEffTUtil);
           if EffUtilT^[NGEffTUtil]=nil then new(EffUtilT^[NGEffTUtil]);
              EffUtilT^[NGEffTUtil]^ := Gterm^[term]^;
           WrealeTab(Gterm^[term]^.POt,0);
           WrealeTab(Gterm^[term]^.dt,0);
          end
          else
          begin
            WstrTab('');
            WstrTab('');
            WstrTab('');
          end;
          WstrTab(Coddiam);
          WrealeTab(Dati^[indtr]^.Porteff,2);
          WrealeTab(pd,2);
          WrealeTab(pl,2);
          WrealeTab(pd+pl,2);
          WrealeTab(Dati^[indtr]^.velocita,2);
          WrealeTab(pp,2);
          if term<>0 then WrealeTab(Gterm^[term]^.perd,2)
          else WrealeTab(0,2);
          velocita := 0;
          if not isZero(Diam) then
             velocita := porteff / 1000 / (sqr(Diam/2) * pi/1000000);
          if sfavorito<>'' then
          begin
            if velocita > MaxvelSfav then MaxvelSfav := velocita;
          end
          else
          begin
            if velocita > Maxvel then Maxvel := velocita;
          end;
          finerigatabella;
      end;

      //else
      if (not dis^[dati^[indtr]^.Ti].coll)and(dati^[indtr]^.pros[1]<>0)and(dis^[dati^[dati^[indtr]^.pros[1]]^.Ti].coll)then
      begin
        Trovato := False;
        DatiColl :='R. '+ inttostr(Dati^[indtr]^.codicetubo) + ':'+ Dati^[indtr]^.Piano + ':' + Dati^[indtr]^.Coddiam;
        {for j := 0 to ListaCollettori.Count - 1 do
          if CompareStr(ListaCollettori[j], DatiColl) = 0 then
             Trovato := True;
        if Not Trovato then }
           ListaCollettori.Add(DatiColl);
      end;
     end;
     for i:=1 to npros do
       iterstampa(pros[i],num);
    end;
   end;

  begin
  InitFileReport(i_sl(percorsodrive) +V_recgen.Codice +'tubi.rep');
  Inizio_compart(V_recgen.Codice);
   //Wrep_str('NOMECOMUNE', DatiProgetto(1));
   //Wrep_str('PROV', DatiProgetto(6));
    totlungsfav:=0;
    totplsfav:=0;
    totpDsfav:=0;
    settasfavorito;
    NumTr:=0;
    maxvel:=0;
    Maxvelsfav:=0;
    NGEffTUtil := 0;
    ListaImpianti := TList.Create;
    InizioTabella('TabTipiRete',6);
    for k := 1 to NTipiRete do
    begin
     if UsatoTipo(TipiRete_D^[k].Cod) then
     begin
      WstrTab(TipiRete_D^[k].Cod);
      WstrTab(TipiRete_D^[k].Descr);
      WstrTab(TipiRete_D^[k].SerieDiam);
      WstrTab(TipiRete_D^[k].TipoMat);
      WrealeTab(TipiRete_D^[k].Rug,4);
      WrealeTab(TipiRete_D^[k].Dens,2);
      finerigatabella;
     end;
    end;
    Finetabella;
    ListaCollettori := TStringList.Create;
    inizio_compart('RETE');
    with V_recgen do
    begin
      Wrep_str('Nomerete', 'RETE ' + Progetto + ' ' +  UpperCase(Codice));
      W_reale('dppred',dps,0);
      W_reale('Maxvpred',Maxvels,2);
      W_reale('dpbil',dpe,0);
      W_reale('Maxvelbil',Maxvele,2);
    end;
    W_reale('PortTot',risultCalc.portata,2);
    W_reale('PerdTot',risultCalc.perdita,2);
    InizioTabella('TabTratti',14);
    iterstampa(risultcalc.Origine,0);
    Finetabella;
    W_reale('Totlungsfav',Totlungsfav*Divrit,2);
    W_reale('totplsfav',totplsfav*Divrit,2);
    W_reale('totpdsfav',totpdsfav*Divrit,2);
    W_reale('perdtermsfav',perdtermsfav,2);
    Wrep_str('cotermsfav',cotermsfav);
    Wrep_str('tipotermsfav',tipotermsfav);
    W_reale('Maxvelsfav',maxvelsfav,2);
    W_reale('Maxvel',maxvel,2);
    InizioTabella('TabCollet',4);
    for k := 0 to ListaCollettori.Count - 1 do
    begin
      st := ListaCollettori[k];
      ind := Pos(':', St);
      CodColl := Copy(St, 1, ind - 1);
      st := Copy(St, ind + 1, Length(st) - 1);
      ind := Pos(':', St);
      PianoColl := Copy(St, 1, ind - 1);
      DiamColl  := Copy(St, ind + 1, Length(st) - 1);
      DescColl  := DescCollettore(CodColl);
      WstrTab(CodColl);
      WstrTab(DescColl);
      WstrTab(PianoColl);
      WstrTab(DiamColl);
      finerigatabella;
    end;
    Finetabella;
    StampaTerminali;
    StampaImpianti;
    W_reale('PORTATA',risultCalc.portata,2);
    W_reale('PERDITA',risultCalc.perdita,2);
    Fine_gruppo;
    FreeAndNil(ListaImpianti);
    FreeAndNil(ListaCollettori);
  fine_compart;
  CloseFileReport;
  //CalcoloPannelli; in questo punto il grafo non è corretto
  end;

  procedure StampaTerminali;
  begin
    if EsistonoTerminali then
    begin
      InizioTabella('TabTerminali',11);
      CreaTabellaTerminali;
      Finetabella;
    end;
    if EsistonoVentilconvettori then
    begin
      InizioTabella('TabVentilConvettori',11);
      CreaTabellaVentilConvettori;
      Finetabella;
    end;
  end;

{-----------------------------------------------------------------------------
  Procedure: DatiProgetto
  Author:    Emanuela
  Date:      06-set-2004
  Arguments: Tag: Integer
  Result:    String

  Funzione che restituisce i dati relativi al comue e provincia del progetto
-----------------------------------------------------------------------------}

  function DatiProgetto(Tag: Integer): String;
  var
    TableFab: TTable;
  begin
   if FileExists(Percorso_Progetti + 'Fabbricato.db') then
   begin
    TableFab := TTable.Create(nil);
    TableFab.DatabaseName := Percorso_Progetti;
    TableFab.Tablename := 'Fabbricato';
    Result := '';
    if TableFab.Exists then
    begin
     TableFab.Open;
     TableFab.First;
     if TableFab.Fields[tag].Text = '' then Result := ''
     else Result :=  TableFab.Fields[tag].AsString;
    end; {if exists}
    TableFab.Close;
    TableFab.Free;
   end
   else MessageDlg(goMSG('MSG_004032001',MSG_004032001), mtInformation, [mbOk], 0); 
  end;

{-----------------------------------------------------------------------------
  Procedure: CreaTabellaTerminali
  Author:    Emanuela
  Date:      06-set-2004
  Arguments: None
  Result:    None

  Procedure per la creazione della tabella dei terminali
-----------------------------------------------------------------------------}
  procedure CreaTabellaTerminali;
  var
    i: Integer;
  begin
   if NGEffTUtil <> 0 then
   begin
    For i := 1 to NGEffTUtil do
    begin
     if CompareStr(UpperCase(EffUtilT^[i].TipoTerm), UpperCase('Radiatori')) = 0 then
     begin
      TrovaImpianto(EffUtilT^[i].numamb, '-');
      wstrTab(EffUtilT^[i].Piano);
      //if EffUtilT^[i].numamb <> 0 then
      //   wstrTab(DescrizioneLocale(EffUtilT^[i].numamb))
      //else wstrTab('---');
      wstrTab(EffUtilT^[i].cod);
      wstrTab(EffUtilT^[i].Modello);
      wstrTab(EffUtilT^[i].Serie);
      WrealeTab(EffUtilT^[i].Port,3);
      WrealeTab(EffUtilT^[i].perd,3);
      WrealeTab(EffUtilT^[i].Pot,0);
      WrealeTab(EffUtilT^[i].Profondita * 100,1);
      WrealeTab(EffUtilT^[i].Altezza * 100,1);
      WrealeTab(EffUtilT^[i].Larghezza * 100,1);
      wstrTab(IntToStr(EffUtilT^[i].NumElementi));
      finerigatabella;
     end;
    end;
   end;
  end;

{-----------------------------------------------------------------------------
  Procedure: CreaTabellaVentilConvettori
  Author:    Emanuela
  Date:      14-giu-2005
  Arguments: None
  Result:    None
-----------------------------------------------------------------------------}
  procedure CreaTabellaVentilConvettori;
  var
    i: Integer;
  begin
   if NGEffTUtil <> 0 then
   begin
    For i := 1 to NGEffTUtil do
    begin
     if CompareStr(UpperCase(EffUtilT^[i].TipoTerm), UpperCase('Fancoil')) = 0 then
     begin
      TrovaImpianto(EffUtilT^[i].numamb, 'X');
      wstrTab(EffUtilT^[i].Piano);
      //if EffUtilT^[i].numamb <> 0 then
      //   wstrTab(DescrizioneLocale(EffUtilT^[i].cod))
      //else wstrTab('---');
      wstrTab(EffUtilT^[i].cod);
      wstrTab(EffUtilT^[i].Modello);
      wstrTab(EffUtilT^[i].Serie);
      WrealeTab(EffUtilT^[i].Port,3);
      WrealeTab(EffUtilT^[i].perd,3);
      WrealeTab(EffUtilT^[i].Pot,0);
      WrealeTab(EffUtilT^[i].PotE,0);
      WrealeTab(EffUtilT^[i].Profondita / 10, 1);
      WrealeTab(EffUtilT^[i].Altezza / 10, 1);
      WrealeTab(EffUtilT^[i].Larghezza / 10, 1);
      finerigatabella;
     end;
    end;
   end;
  end;

{-----------------------------------------------------------------------------
  Procedure: EsistonoTerminali
  Author:    Emanuela
  Date:      14-giu-2005
  Arguments: None
  Result:    Boolean
-----------------------------------------------------------------------------}
  Function EsistonoTerminali: Boolean;
  var
    i: Integer;
  begin
   Result := False;
   if NGTerm <> 0 then
   begin
    For i := 1 to Ngterm do
    begin
     if CompareStr(UpperCase(GTerm^[i].TipoTerm), UpperCase('Radiatori')) = 0 then
     begin
      Result := True;
      exit;
     end;
    end;
   end;
  end;

{-----------------------------------------------------------------------------
  Procedure: EsistonoVentilConvettori
  Author:    Emanuela
  Date:      14-giu-2005
  Arguments: None
  Result:    Boolean
-----------------------------------------------------------------------------}

  Function EsistonoVentilConvettori: Boolean;
  var
    i: Integer;
  begin
   Result := False;
   if NGTerm <> 0 then
   begin
    For i := 1 to Ngterm do
    begin
     if CompareStr(UpperCase(GTerm^[i].TipoTerm), UpperCase('Fancoil')) = 0 then
     begin
       Result := True;
       exit;
     end;
    end;
   end;
  end;

{-----------------------------------------------------------------------------
  Procedure: DescrizioneLocale
  Author:    Emanuela
  Date:      20-gen-2005
  Arguments: Codice: Integer
  Result:    String

  restituisce la descrizione del locale
-----------------------------------------------------------------------------}

  function DescrizioneLocale(Codice: Integer): String;
  var
    TabLocale: TTable;
    Trovato: Boolean;
  begin
   Result := '';
   if FileExists(Percorso_Progetti + 'Locali.db') then
   begin
     TabLocale := TTable.Create(nil);
     TabLocale.DatabaseName := Percorso_Progetti;
     TabLocale.Tablename := 'Locali';
     Trovato := False;
     if TabLocale.Exists then
     begin
       TabLocale.Open;
       TabLocale.First;
       while (not TabLocale.Eof) and (not Trovato) do
       begin
           if Codice = TabLocale.FieldByName('Codice').AsInteger then
           begin
             Result :=  TabLocale.FieldByName('Descrizione').AsString;
             Trovato := True;
           end;
           TabLocale.Next;
       end;
      TabLocale.Close;
      TabLocale.Free;
     end;
   end
   else MessageDlg(goMSG('MSG_004032002',MSG_004032002), mtInformation, [mbOk], 0);  
  end;

  Procedure TrovaImpianto(CodiceL: integer; Est: Char);
  var
    TableLoc: TTable;
    Imp: String;
    Trovato: Boolean;
    i: Integer;
    TempImp: PImpianto;
  begin
   if FileExists(Percorso_Progetti + 'Locali.db') then
   begin
    TableLoc := TTable.Create(nil);
    TableLoc.DatabaseName := Percorso_Progetti;
    TableLoc.Tablename := 'Locali.db';
    TableLoc.Open;
    TableLoc.First;
    Imp := '';
    if TableLoc.RecordCount > 0 then
    begin
     while (not TableLoc.Eof) and (TableLoc.Fields[1].asInteger <> CodiceL) do TableLoc.Next;
     Imp :=  TableLoc.Fields[7].AsString;
    end; {if exists}
    TableLoc.Close;
    TableLoc.Free;
   end
   else MessageDlg(goMSG('MSG_004032002',MSG_004032002), mtInformation, [mbOk], 0);
   Trovato := False;
   if ListaImpianti.Count <> 0 then
   begin
     i := 0;
     While (i < ListaImpianti.Count) and (not Trovato) do
     begin
       if CompareStr(PImpianto(ListaImpianti[i])^.CodImp, Imp) = 0 then
       begin
          Trovato := True;
          if PImpianto(ListaImpianti[i])^.Est = '-' then
             if Est = 'X' then PImpianto(ListaImpianti[i])^.Est := Est;
       end;
       inc(i);
     end;
   end;
   if (Not Trovato) and (Imp <> '') then
   begin
     New(TempImp);
     TempImp.CodImp := Imp;
     TempImp.Est    := Est;
     DatiImpianto(Imp, TempImp.Tiai, TempImp.Tiae, TempImp.Sti, TempImp.ste, TempImp.DescImp);
     ListaImpianti.Add(TempImp);
   end;
  end;
 (*
  procedure DatiImpianto(CodImpianto: String; var Tai, Tae, Sti, Ste: real; var Desc: String);
  var
    TableImp: TTable;
  begin
   if FileExists(Percorso_Progetti + 'Impianti.db') then
   begin
    TableImp := TTable.Create(nil);
    TableImp.DatabaseName := Percorso_Progetti;
    TableImp.Tablename := 'Impianti.db';
    if TableImp.Exists then
    begin
     TableImp.Open;
     TableImp.First;
     if CodImpianto <> '' then
     begin
       while (not TableImp.Eof) and (CompareStr(UpperCase(TableImp.Fields[0].Text), UpperCase(CodImpianto)) <> 0) do TableImp.Next;
     end;
     Desc := TableImp.FieldByName('Descrizione').AsString;
     Tai  := TableImp.FieldByName('I Temp. entrata acqua').AsFloat;
     Sti  := TableImp.FieldByName('I Salto termico acqua').AsFloat;
     Tae  := TableImp.FieldByName('E Temp. entrata acqua').AsFloat;
     Ste  := TableImp.FieldByName('E Salto termico acqua').AsFloat;
    end; {if exists}
    TableImp.Close;
    TableImp.Free;
   end
   else MessageDlg(goMSG('MSG_004032007',MSG_004032007), mtInformation, [mbOk], 0);
  end;
 *)
 procedure DatiImpianto(CodImpianto: String; var Tai, Tae, Sti, Ste: real; var Desc: String);
 begin
 end;
  procedure StampaImpianti;
  var
    i: Integer;
  begin
   InizioTabella('TabImpianti',6);
   if ListaImpianti.Count = 0 then
   begin
     CaricaDatiImpianti;
   end;
    For i := 0 to ListaImpianti.Count - 1 do
    begin
      wstrTab(PImpianto(ListaImpianti[i])^.CodImp);
      wstrTab(PImpianto(ListaImpianti[i])^.DescImp);
      if EsistonoTerminali then
      begin
        WrealeTab(PImpianto(ListaImpianti[i])^.Tiai,2);
        WrealeTab(PImpianto(ListaImpianti[i])^.Sti,2);
      end
      else
      begin
        wstrTab('---');
        wstrTab('---');
      end;
      if PImpianto(ListaImpianti[i])^.Est = 'X' then
      begin
        WrealeTab(PImpianto(ListaImpianti[i])^.Tiae,2);
        WrealeTab(PImpianto(ListaImpianti[i])^.ste,2);
      end
      else
      begin
        wstrTab('---');
        wstrTab('---');
      end;
      finerigatabella;
    end;
   FineTabella;
  end;

  procedure CaricaDatiImpianti;
  var
    TableImp: TTable;
    TempImp: PImpianto;
  begin
   if FileExists(Percorso_Progetti + 'Impianti.db') then
   begin
    TableImp := TTable.Create(nil);
    TableImp.DatabaseName := Percorso_Progetti;
    TableImp.Tablename := 'Impianti.db';
    TableImp.Open;
    TableImp.First;
    while (not TableImp.Eof) do
    begin
     New(TempImp);
     TempImp.CodImp := TableImp.FieldByName('Codice').AsString;
     TempImp.Est    := 'X';
     TempImp.DescImp := TableImp.FieldByName('Descrizione').AsString;
     //TempImp.Tiai    := TableImp.FieldByName('I Temp. entrata acqua').AsFloat;
     //TempImp.Sti     := TableImp.FieldByName('I Salto termico acqua').AsFloat;
     //TempImp.Tiae    := TableImp.FieldByName('E Temp. entrata acqua').AsFloat;
     //TempImp.ste     := TableImp.FieldByName('E Salto termico acqua').AsFloat;
     ListaImpianti.Add(TempImp);
     TableImp.Next;
    end;
    TableImp.Close;
    TableImp.Free;
   end
   else MessageDlg(goMSG('MSG_004032007',MSG_004032007), mtInformation, [mbOk], 0);
  end;

Procedure Reportcomplessivo;
Var i,j:integer;
    fout:textfile;
begin
//leggi_mem_piani;
//leggi_mem_reti;
//assign(fout,i_sl(percorsodrive)+'Tubi.rep');
//rewrite(fout);
//close(fout);
end;
end.
