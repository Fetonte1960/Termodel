unit UCompilafrontiere;

interface
Uses Dialogs, Math, DBTables, Classes,
     Varcarichi,Libreriagenerale,UMessaggiCarichi, UdataLink,
     udb, Utireport, sysutils, Variabiligenerali, Uti_term
    {$Ifdef L10}
    ,calccd
     {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}, GestioneGrafico{$ELSE} ,UStatistica {$IFEND}
     {$Else}
    {$EndIf};

Procedure CompilaFront;
Procedure CopiaDati;
Function  Codicepar(Cod:String):Integer;
//Emanuela funzioni realizzate per il caricamento delle zone legge10
Procedure CaricaDatiZonaL10(nZ: Integer; var nZL10: Integer; NImp: Integer; TInv: real);
function  EsisteZona(CodiceZona: String; NZ: Integer; var indZona: Integer): Boolean;
function  CercaIndiceZone(CodiceZona: String): Integer;
Procedure Compila_non_clima;
function  AltLordaPiano(CodPiano: String; Tipo: char): real;
Function  CodiceImpianto(Cod:String):Integer;
Function  RestituisciAngoloFalda(CodiceConf: String): real;
Procedure VerificaAggregati(var Amb: RecAmb; var VolumeAmb: double; var VLor: Real);
function  CercaMassaSuperficiale(CodPar: String): double;
function  EsistePareteAmb(CodPar, Confine, Lato: String; AmbO: RecAmb; var valP: Integer): Boolean;
procedure RipulisciAmbienteTemporaneo(var Amb: RecAmb);
function  SpessPar(codPar: String): real;
procedure CalcolaVolumeSpessori(AmbTemp: RecAmb; AltLordaP: Real; var VLordo: Real);
function  ConfineInterno(Cod: String; var TI: Real): Boolean;

implementation
{$Ifdef L10}
Uses Uvariabili;

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
   with DescGen1^[gencor] do
   begin
       dispers:=0;
       VolLord:=0;
       SupLord:=0;
       SV:=0;
       Dt:=Prog^.TInv-Prog^.TEst;
       Cdfen:=0;
       CdLeg:=0;
       CdAdot:=0;
       Fts:=0;
       GiorniRis:=0;
       Fen:=0;
       RicAr:=0;
       IrradS:=0;
       DtMed:=0;
       AppGr:=0;
       CorUtilAg:=0;
       RedETg:=0;
       FenLim:=0;
   End;
end;
{$Else}
Uses MainForm;
{$Endif}

Var Codiceparete:integer;
    EsposizCor:Integer;

Function Esposizpar(Cod,Lato:String):Integer;
Var i:integer;
    Tipo,codamb:string;
    Inclinaz,Ori,TCEST,TCINV,INCR_ESP, TI:Real;
begin
If Upstring(cod)='ESTERNO' then
begin
  i:=1;
  INCR_ESP:=1;
  Inclinaz:=90;
  Ori:=0;
  // ---------------------------------------------------------------------
  // Fabio 12 Genn 2oo5
  // Aggiunto incremento % automatico per esposione come da norma UNI 7357
  // ---------------------------------------------------------------------
  IF UpperCase(Lato)='OR' then Inclinaz:=0;
  IF UpperCase(Lato)='N'  then begin Ori:=0;   INCR_ESP:= 1.20; end;
  IF UpperCase(Lato)='NE' then begin Ori:=45;  INCR_ESP:= 1.20; end;
  IF UpperCase(Lato)='E'  then begin Ori:=90;  INCR_ESP:= 1.15; end;
  IF UpperCase(Lato)='SE' then begin Ori:=135; INCR_ESP:= 1.10; end;
  IF UpperCase(Lato)='S'  then begin Ori:=180; INCR_ESP:= 1.00; end;
  IF UpperCase(Lato)='SO' then begin Ori:=225; INCR_ESP:= 1.05; end;
  IF UpperCase(Lato)='O'  then begin Ori:=270; INCR_ESP:= 1.10; end;
  IF UpperCase(Lato)='NO' then begin Ori:=315; INCR_ESP:= 1.15; end;

  while (i<NEsposizioni)  and
        ((Ori <> Esposizioni_d^[i].Orient) or
         (Inclinaz <> Esposizioni_d^[i].Inclin) or
         ('E' <> UpperCase(Esposizioni_d^[i].Tipo))) do inc(i);
  if (Ori <> Esposizioni_d^[i].Orient)
      or (Inclinaz <> Esposizioni_d^[i].Inclin)
      or ('E' <> UpperCase(Esposizioni_d^[i].Tipo)) then
  begin
    Inc(Nesposizioni);
    with Esposizioni_D[Nesposizioni] do
    begin
      Inclin:=Inclinaz;
      Orient:=ori;
      Tipo:='E';
      Codice:=Lato;
      Denom:=Lato;
      result:=NEsposizioni;
      IncrSic := INCR_ESP;
      Trifinv:=0;
      TRifEst:=0;
      codpav:='';
      codost:='';
    end;
  end
  else  result:=i;
end
else
  if Upstring(lato[1])='L' then
  begin
    codamb:=copy(lato,2,length(lato)-1);
    i:=1;
    while (i<NAmbienti) and (Codamb<>Ambienti_d^[i].CodNum) do inc(i);
    if Codamb<>Ambienti_d^[i].CodNum then
    begin
      echo('Il confine con altro locale "'+ codamb + '" non trova corrispondenza.');
      result:=NEsposizioni;
    end
    else
      begin
      // Emanuela 12/07/2004 modificato perchè si deve tenere conto
      // della zona se è non riscaldato e non della denominazione
      if uppercase(Ambienti_d^[i].CodZona)=UpperCase('Non risc') then // Locali non climatizzati
      begin
        TCInv:=Ambienti_d^[i].TNInv;
        TCest:=Ambienti_d^[i].TNEst;
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
      if NEsposizioni<>0 then
      begin
        i:=1;
        while (i<NEsposizioni)and
              ((Upstring(Esposizioni_d^[i].Codice) <> 'LOCALE') or
               (Tcinv <> Esposizioni_d^[i].TrifInv) or
               (Tcinv <> Esposizioni_d^[i].TrifInv)) do inc(i);
      end;
      if (NEsposizioni=0)or
         ((Upstring(Esposizioni_d^[i].Codice)<>'LOCALE')or
        (Tcinv<>Esposizioni_d^[i].TrifInv)or(Tcinv<>Esposizioni_d^[i].TrifInv)) then
        begin
        inc(Nesposizioni);
        with Esposizioni_d^[Nesposizioni] do
        begin
           Codice:='LOCALE';
           Trifinv:=Tcinv;
           TRifEst:=Tcest;
           orient:=0;
           Inclin:=0;
           Tipo:='I';
           Denom:='LOCALE';
           result:=NEsposizioni;
           codpav:='';
           codost:='';
           IncrSic := 0;
        end
        end
        else result:=i;
      end;
  end
  else
  begin
    if NEsposizioni<>0 then
    begin
      i:=1;
      while (i<NEsposizioni)and(UpperCase(Cod) <> UpperCase(Esposizioni_d^[i].Codice)) do inc(i);
    end;
    if (NEsposizioni=0)or(UpperCase(Cod) <> UpperCase(Esposizioni_d^[i].Codice)) then
    begin
      result:=NEsposizioni;
      Erroregen := true;
      echo('Il Confine di codice '+ cod + ' non è stato trovato in archivio.');
    end
    else
    result:=i;
  end;
  EsposizCor:=result;
end;


Function Codicepar(Cod:String):Integer;
Var i:integer;
begin
 // Emanuela 25/3/2005 - 14:23 Inserito controllo affinchè non vengano dati errori per le
 // pareti fittizie e di tipo Nessuno
 if (CompareStr(UpperCase(Cod), 'NESSUNO') <> 0) and (CompareStr(UpperCase(Cod), 'FITTIZIA') <> 0)
 then
 begin
   if Nstrutture<>0 then
   begin
    i:=1;
    while (i<NStrutture)and(UpperCase(Cod) <> UpperCase(Strutture_d^[i]^.NFile)) do inc(i);
   end;
   if (Nstrutture=0)or(UpperCase(Cod) <> UpperCase(Strutture_d^[i]^.NFile)) then
   begin
    result:=0;
    Erroregen:=true;
    echo('La parete di codice '+ cod + ' non è stata trovata in archivio.');
   end
   else result:=i;
   codiceparete:=i;
 end
 else result := 0;
end;

Function CodiceFin(Cod:String):Integer;
Var i:integer;
begin
if NFinestre<>0 then
  begin
  i:=1;
  while (i<NFinestre)and(UpperCase(Cod) <> UpperCase(Finestre_d^[i].Codice)) do inc(i);
  end;
if (Nfinestre=0)or(UpperCase(Cod) <> UpperCase(Finestre_d^[i].Codice)) then
  begin
  result:=0;
  Erroregen:=true;
  if cod <> '' then echo('La finestra di codice '+ cod + ' non è stata trovata in archivio.')
  else echo('Messaggio di Servizio: codice Finestra vuoto.');
  end
else
result:=i;
end;


Function CodicePon(Cod:String):Integer;
Var i:integer;
begin
if NPonti<>0 then
  begin
  i:=1;
  while (i<NPonti)and(UpperCase(Cod) <> UpperCase(Ponti_d^[i].Codice)) do inc(i);
  end;
if (NPonti=0)or(UpperCase(Cod) <> UpperCase(Ponti_d^[i].Codice)) then
  begin
  result:=0;
  Erroregen:=true;
  if cod <> '' then echo('Il Ponte di codice '+ cod + ' non è stato trovato in archivio.')
   else echo('Messaggio di Servizio: codice Ponte Termico vuoto.');
  end
else
result:=i;
end;


Function CodiceZona(Cod:String):Integer;
Var i:integer;
begin
if NZone<>0 then
  begin
  i:=1;
  while (i<NZone)and(Upstring(Cod)<>Upstring(Zone_d^[i].Cod)) do inc(i);
  end;
// Emanuela 12/7/2004 inserita una condizione ainchè non venga controllata la zona non risc,
// inserita per identificare i locali non riscaldati
if ((NZone=0)or(UpperCase(Cod) <> UpperCase(Zone_d^[i].Cod))) and (UpperCase(cod) <> UpperCase('Non risc')) then
  begin
  result:=0;
  Erroregen:=true;
  echo('La Zona di codice '+ cod + ' non è stata trovata in archivio.');
  end
else
result:=i;
end;

Function CodiceImpianto(Cod:String):Integer;
Var i:integer;
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


Function CodiceProfilo(Cod:String):Integer;
Var i:integer;
begin
if NOrari<>0 then
  begin
  i:=1;
  while (i<NOrari)and(UpperCase(Cod) <> UpperCase(Orari_d^[i].Codice)) do inc(i);
  end;
if (NOrari=0)or(UpperCase(Cod) <> UpperCase(Orari_d^[i].Codice)) then
  begin
  result:=0;
  if cod<>'' then
    begin
    Erroregen:=true;
    echo('L''andamento orario '+ cod + ' non è stato trovato in archivio.');
    end;
  end
else
result:=i;
end;

Procedure CopiaProfilo;
Var i,j:Integer;
begin
{$Ifdef L10}
{$Else}
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
for j:=0 to 23 do Profili_D^[NProfili][j]:=100;
{$Endif}
end;


Procedure CopiaDati;
Var Nome1, Nome2, Comune:string;
    i, j, k, Numeroprovince, IndTabZone, indZona, npiante:integer;
    trovato: integer;
    ok: boolean;
    TabTemp: TTable;
    AltezzaNettaPiano, Qrel: real;
begin

 // --------------------------------
 // Copia i dati estivi del progetto
 // --------------------------------

 With prog^ do
 begin
    Localita_D^.HMare:=AltCom;
    Localita_D^.Lat:=LatCom;
    Localita_D^.Lon:=Longitudine;
    Localita_D^.MeriDRifOra:=MeriDRifOra;
    Localita_D^.OraLegFine:=OraLegFine;
    Localita_D^.OraLegInizio:=OraLegInizio;
    Localita_D^.TIestBS:=TEst;
    Localita_D^.TInvEsternaBS:=TEst;
    Localita_D^.TInvEsternaBU:=0{TInvEsternaBU};
    Localita_D^.TEstEsternaBS:=TEstEsternaBS;
    Localita_D^.TEstEsternaBU:=0{TEstEsternaBU};
    Localita_D^.UInvEsterna:=urest;
    Localita_D^.UEstEsterna:=UEstEsterna;
    Localita_D^.ET:=ET;
    Localita_D^.FattFoschia:=FattFoschia;
    Localita_D^.Riflettivita:=Riflettivita;
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
        Indrad:=fieldbyname('IndDatiIrrad').asinteger;
        indprov:=i;
        Sigla:=fieldbyname('Sigla Prov').value;
        nome:=fieldbyname('Prov').value;
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
        datc[j]:=fields[3+j].Value;
        altitudine:=fieldbyname('altitudine').asinteger;
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
  Nrisultati:=Ngeneratori;
 { TODO -oGenerale -cIndice : Definizione Zona di Legge }
 { Modificato l'inserimento delle zoneL10, affinche vengano correttamente caricate}

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
   Finestre_d^[i].Shading := Finestre_d^[i].ShadingSchermo + Finestre_d^[i].shadingVetro;
   Finestre_d^[i].PosizSchermo := Finestre_d^[i].TipoSchermatura;
   Finestre_d^[i].Rientranza := 0;
   Finestre_d^[i].DOrizz  := Finestre_d^[i].DistBalcomi;
   Finestre_d^[i].LOrizz  := Finestre_d^[i].ProfBalconi;
   Finestre_d^[i].LVertSX := Finestre_d^[i].ProfVerticaleSx;
   Finestre_d^[i].LVertDX := Finestre_d^[i].ProfVerticaleDx;
   Finestre_d^[i].DVertSX := Finestre_d^[i].DistVerticaleSx;
   Finestre_d^[i].DVertDX := Finestre_d^[i].DistVerticaleDx;
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

// Emanuela 28/7/2004 funzione che trova l'indice della tabella della zona cercata
function CercaIndiceZone(CodiceZona: String): Integer;
var
  i: Integer;
begin
  Result := 0;

  For i := 1 to NZone do
  begin
    if CompareStr(UpperCase(Zone_d^[i].Cod), UpperCase(CodiceZona)) = 0 then
    begin
      Result := i;
      exit;
    end;
  end;
end;

// Emanuela 27/7/2004 funzione che verifica se la zonaL10 esiste già nella tabella
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

//Emanuela 27/7/2004 procedura che carica i valori della zonaL10 e zonaL11
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
    zone10^[NZL10].Descr:='Non risc';
    zone10^[NZL10].Taria:= TInv;
  end
  else
  begin
    zone10^[NZL10].Descr:=Zone_d^[nZ].Denom;
    zone10^[NZL10].Taria:=Zone_d^[nZ].Tinv;
  end;
  zone10^[NZL10].NOreNotte:=Impianto_d^[NImp].NOreNotte;
  zone10^[NZL10].NOreGiorno:=Impianto_d^[NImp].NOreGiorno;
  zone10^[NZL10].DayWeekOff:=Impianto_d^[NImp].DayWeekOff;
  zone10^[NZL10].Tempmin:=round(Impianto_d^[NImp].Tempmin);
  zone10^[NZL10].TipoTerm:=Impianto_d^[NImp].TipoTerm;
  zone10^[NZL10].TipoProd:=Impianto_d^[NImp].TipoProd;
  zone10^[NZL10].TipoReg:=Impianto_d^[NImp].TipoReg;

  //Emanuela 17/9/2004 modifica necessari affinchè vengono considerate le zone non risc
  if nz = 0 then
  begin
   zone11^[NZL10].Classif := 'E1(1)';
   zone11^[NZL10].MotivVent:='';;
   zone11^[NZL10].TempOc:=0;
   zone11^[NZL10].AriaEst:=0;
   zone11^[NZL10].Affol:=0;
   zone11^[NZL10].N:=0;
   zone11^[NZL10].Ngo:=0;
  end
  else
  begin
    zone11^[NZL10].Classif:=Zone_d^[nZ].Classif;
   // Emanuela verifica della compatibilità con la versione 11
   if VerificaVersione <> 11 then
   begin
    Impianto_d^[NImp].Motivo  := Zone_d^[nZ].Motivo;
   end;
    zone11^[NZL10].MotivVent := Impianto_d^[NImp].Motivo;
    zone11^[NZL10].TempOc:=Zone_d^[nZ].TempOc;
    zone11^[NZL10].AriaEst:=Zone_d^[nZ].AriaEst;
    zone11^[NZL10].Affol:=Zone_d^[nZ].Affol;
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
    zone11^[NZL10].Ngo:=Zone_d^[nZ].Ngo;
  end;
    zone11^[NZL10].GeneratZona:='';
    zone11^[NZL10].PortLegM:=0;
    zone11^[NZL10].PotH2o:=0;
    zone11^[NZL10].AreaPav:=0;
    zone11^[NZL10].Ap:=0;
    zone10^[NZL10].UR:=Prog^.UR;
    zone10^[NZL10].ClSerram:=''; // Non è attivato Calcolo Analitico
    // Correzione per leggere dato di Zona e non dato di Progetto per Default - Emanuela 7-Dic-2oo4
    //zone10^[NZL10].PortNat:=Prog^.PortNat;
    zone10^[NZL10].PortNat := Zone_D^[nZ].InfInv + Zone_D^[nZ].PortMec;
    zone10^[NZL10].CalcAnal := 'S';

    // Correzione per leggere dato di Zona e non dato di Progetto per Default - Emanuela 7-Dic-2oo4
    //zone10^[NZL10].PortMec:=Prog^.PortMec;
    //zone10^[NZL10].VMVolImpOn:=Prog^.VMVolImpOn;
    //zone10^[NZL10].OreOn:=Prog^.OreOn;
    //zone10^[NZL10].EtaRecup:=Prog^.EtaRecup;


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
    zone10^[NZL10].TipoPav:=0;   // Non è attivato Calcolo Analitico Capacità Termica
    zone10^[NZL10].TipoEdif:=''; // Sostituito con Gestione Differenziata
    zone10^[NZL10].RendTerm:=0;  // ?
    zone10^[NZL10].PotNom:=0;    // Non attivato Calcolo Analitico Rend.Distribuzione
    zone10^[NZL10].Perc:=0;      // Non attivato Calcolo Analitico Rend.Distribuzione
    zone10^[NZL10].TempAT:=0;    // ?
    zone10^[NZL10].RendReg:=0;   // ?

end;

  Procedure Compila_non_clima;
  var i,j:Integer;
      N_r,N_C,N_Risc,trov:boolean;
  begin
   for i:=1 to NAmbienti do
   begin
    Ambienti_D^[i].Indimpianto:=CodiceImpianto(Ambienti_D^[i].Impianto);
    N_Risc := UpperCase(Ambienti_D^[i].CodZona) = 'NON RISC';
    if (ambienti_d^[i].Indimpianto <> 0) and (ambienti_d^[i].Indimpianto <= NImpianti) then
    begin
      N_R:= (ambienti_d^[i].Indimpianto=0)or(Impianto_D^[ambienti_d^[i].Indimpianto].GenInvt=non_risc);
      N_C:= (ambienti_d^[i].Indimpianto=0)or(Impianto_D^[ambienti_d^[i].Indimpianto].Genest=non_clima);
    end
    else
    begin
      N_R := False;
      N_C := False;
    end;
    if N_Risc then
    begin
      zone_D^[Nzone].ProfiloImpianto:=0;
      zone_D^[Nzone].ProfiloImpiantoInv:=0;
    end
    else
    begin
      if N_c or N_R then
      begin
        j:=1;
        while (j < NZone)and
        (zone_D^[j].Denom<>'NC_'+inttostr(ambienti_d^[i].Indimpianto))and
        (N_C and (zone_D^[j].TEst<>ambienti_d^[i].TNEst))and
        (N_R and (zone_D^[j].TInv<>ambienti_d^[i].TNInv)) do inc(j);

        if (zone_D^[j].Denom<>'NC_'+inttostr(ambienti_d^[i].Indimpianto))or
           (N_C and (zone_D^[j].TEst<>ambienti_d^[i].TNEst))or
           (N_R and (zone_D^[j].TInv<>ambienti_d^[i].TNInv)) then
        begin
        if nzone < MaxZone then
           inc(nzone);
        zone_d^[Nzone]:=zone_d^[ambienti_d^[i].Zona];
        zone_D^[Nzone].Denom:='NC_'+inttostr(ambienti_d^[i].Indimpianto);
        zone_D^[Nzone].cod:=zone_D^[Nzone].Denom ;
        ambienti_d^[i].Zona:=Nzone;
        ambienti_d^[i].codzona:=zone_D^[Nzone].cod;

        if N_C then
          begin
          zone_D^[Nzone].TEst:=ambienti_d^[i].TNEst;
          zone_D^[Nzone].ProfiloImpianto:=0;
          end;
        if N_R then
          begin
          zone_D^[Nzone].TInv:=ambienti_d^[i].TNInv;
          zone_D^[Nzone].ProfiloImpiantoInv:=0;
          end;
      end
      else
      begin
        ambienti_d^[i].Zona:=j;
        ambienti_d^[i].codzona:=zone_D^[j].cod;
      end;
     end;
    end; 
   end;

   for i:=1 to nImpianti do
   begin
     if Impianto_D^[i].Genest=non_clima then  Impianto_D^[i].EstProfiloVent := '';
     if Impianto_D^[i].Genest=non_risc then  Impianto_D^[i].InvProfiloVent := '';
   end;
end;

function AltLordaPiano(CodPiano: String; Tipo: char): real;
var
  i: Integer;
begin
  i := 1;
  Result := 0;
  CodPiano := UpperCase(CodPiano);
  while (i < NPiani) and (UpperCase(Piani_D[i].Cod) <> CodPiano) do
    inc(i);
  if (UpperCase(Piani_D[i].Cod) = CodPiano) then
  begin
    if Tipo = 'L' then
       Result := Piani_D[i].AltL
    else Result := Piani_D[i].AltN;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: VerificaAggregati
  Author:    e.diquattro
  Date:      27-apr-2006
  Arguments: var Amb: RecAmb; var VolumeAmb: Double
  Result:    None
  
  Cosa fa:
-----------------------------------------------------------------------------}

Procedure VerificaAggregati(var Amb: RecAmb; var VolumeAmb: double; var VLor: Real);
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
  Amb.NPar   := 0;
  Amb.Num    := 0;
  Amb.CodNum := '';
  Amb.CodZona := '';
  Amb.Denom   := '';
  Amb.Piano   := '';
  Amb.Superficie := 0;
  Amb.HSoffitto  := 0;
  Amb.Impianto   := '';
  Amb.InfInv     := 0;
  Amb.CodPROccupaz := '';
  Amb.NPersone     := 0;
  Amb.RicambioPersona := 0;
  Amb.SensibilePersona:= 0;
  Amb.LatentePersona := 0;
  Amb.CodPRApparecch := '';
  Amb.IlluminazFissa := 0;
  Amb.InfEst := 0;
  Amb.TNEst := 0;
  Amb.TNInv := 0;
  Amb.Ventilazione := 0;
  Amb.V := '';
  Amb.T_Pav := '';
  Amb.C_Pav := '';
  Amb.T_Soff := '';
  Amb.C_Soff := '';
  Amb.x1 := 0;
  Amb.Y1 := 0;
  Amb.Indimpianto := 0;
  Amb.Z10 := 0;
  Amb.Numimpianto := 0;
  Amb.ProfiloIlluminaz := 0;
  Amb.ProfiloApparecch := 0;
  Amb.ProfiloOccupaz := 0;
  Amb.IlluminazVar := 0;
  Amb.TipoIlluminaz := 0;
  Amb.RappRS := 0;
  Amb.CircolazAria := 0;
  Amb.inf_risc := 0;
  Amb.alfaSerra := 0;
  Amb.alloggio := 0;
  Amb.PotenzaWatt := 0;
  Amb.Zona := 0;
  Amb.AmbientiUguali := 0
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
   if (AmbTemp.Par[j].Lato[1] <> '-') and (CompareStr(UpperCase(AmbTemp.Par[j].Confine), 'FITT') = 0) then
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
     if (AmbTemp.Par[j].Lato[1] <> '-') and (CompareStr(UpperCase(AmbTemp.Par[j].Confine), 'FITT') = 0)then
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
  Procedure: CercaMassaSuperficiale
  Author:    e.diquattro
  Date:      05-apr-2006
  Arguments: CodPar: String
  Result:    double

  Cosa fa:  calcola la massa superficiale
-----------------------------------------------------------------------------}
    function CercaMassaSuperficiale(CodPar: String): double;
    var
      i, j: Integer;
    begin
      i := 1;
      Result := 0;
      CodPar := UpperCase(CodPar);
      while (i < NStrutture) and (UpperCase(Strutture_D[i].NFile ) <> CodPar) do
            inc(i);
      if (UpperCase(Strutture_D[i].NFile) = CodPar) then
          Result := Strutture_D[i].MassaSup;
    end;

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



Procedure CompilaFront;
Var i, j, Np, Nt:integer;
    prima, trov:boolean;
    suptot,totdisp,totdispAmb,totdispriga, IncrInt:real;
    esppar,CodPar:string;
    //Emanuela variabili DM
    //TotDispDM, TotDispAmbDM, TotDispRigaDM: real;

  Procedure CompilaMuri;
  var
    j, i:integer;
  begin
    j := 0;
    for i := 1 to Nstrutture do
    begin
     with Strutture_D[i]^ do
     begin
      inc(j);
      Muri_D^[j].Colore:='M';
      Muri_D^[j].IncrSic:=1;
      Muri_D^[j].CodArch:=i;
     end;
    end;
    NMuri:=NFrontiere;
  end;

  Procedure CompilaConfini;
  var
    i, j:integer;
  begin

    i := 0;
    for j := 1 to NConfini do
    begin
     with Confine_D^[j] do
     begin
      inc(i);
     { TODO -oFabio -cDafare : Esposizione con ostacoli da completare Fabio}
      Esposizioni_D^[i].Codice:=Codice;
      Esposizioni_D^[i].Denom:=Denom;
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

      Esposizioni_D^[i].Orient:=0;

      Esposizioni_D^[i].Inclin:=0;
      Esposizioni_D^[i].TrifEst:=TrifEst;
      Esposizioni_D^[i].TrifInv:=TrifInv;
      Esposizioni_D^[i].IncrSic:=IncrSic;
      Esposizioni_D^[i].CodPav:='';
      Esposizioni_D^[i].CodOst:='';
     end;
    end;
    NEsposizioni := NConfini;
  end;

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
      Frontiere_D^[Nfrontiere]^.CodAmb := CodiceAmb;
      Frontiere_D^[Nfrontiere]^.LungMuro := 0;
      Frontiere_D^[Nfrontiere]^.SupMuro := 0;
      Frontiere_D^[Nfrontiere]^.CodMuro2 := 0;
      Frontiere_D^[Nfrontiere]^.SupMuro2 := 0;
      Frontiere_D^[Nfrontiere]^.CodFinestra := 0;
      Frontiere_D^[Nfrontiere]^.ModFinestra := 0;
      Frontiere_D^[Nfrontiere]^.SupFinestra := 0;
      Frontiere_D^[Nfrontiere]^.CodPorta := 0;
      Frontiere_D^[Nfrontiere]^.ModPorta := 0;
      Frontiere_D^[Nfrontiere]^.SupPorta := 0;
      result:=Nfrontiere;
  end;


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
      FrontiereLin_D^[NFrontiereLin]^.CodNum := NFrontiereLin;
      FrontiereLin_D^[NFrontiereLin]^.CodAmb := CodiceAmb;
      FrontiereLin_D^[NFrontiereLin]^.CodEsp := 0;
      FrontiereLin_D^[NFrontiereLin]^.CodPonte1 := 0;
      FrontiereLin_D^[NFrontiereLin]^.LUNG1 := 0;
      FrontiereLin_D^[NFrontiereLin]^.CodPonte2 := 0;
      FrontiereLin_D^[NFrontiereLin]^.LUNG2 := 0;
      FrontiereLin_D^[NFrontiereLin]^.Kappa := 0;
      result:=NfrontiereLin;
  end;

  Function CalcSupNetta(Amb: recAmb; parete: integer):real;
  begin
    result := amb.Par[parete].Sup;
    with amb do
      if parete<Npar then
        if Par[parete+1].Lato='-' then
        begin
        inc(parete);
        while (Parete<=parete)and(Par[parete].Lato='-') do
        begin
          Result:=result-Par[parete].Sup;
          inc(parete);
        end;
      end;
  end;


type TIntPot = record
                NumAmb: Integer;
                NomeLoc, Piano, CodGen: String[30];
                Pot, Port, DispInf, Vol, Sup: Double;
               end;
 { TODO -oGenerale -cIndice : Inizio Calcolo Dispersioni }
Var
     BufIntPOt: TintPOt;
     FIntPOt: file of Tintpot;
     DispInf, AppVent, ventinf,Pot_Ventilazione, Tot_Ventilazione,
     TotApp_Vent, VolNetto,Dtcorr, IncrCorr, Angolo: real;  // Fabio 12 Genn 2oo5 Inserito Increm % per Esposizione
     TotDispNetto, TotDispNettoDM: real; // Emanuela 12 Lug 2oo4 -Variab somma disp senza infiltrazioni
{ TODO -oFabio -cAttenzione : Attenzione - Variabile per definire se il calcolo è OK }
     CalcoloVerificato: string;
     espesterna:boolean;
     VolInterno, SupLordaPar, AltLordaP, AltNettaP{, MassaFrontalePareteDM, CoeffCMDM, TrasmittDM}: Double;
     SpessTemp: Double;
     AmbTemp: RecAmb;
     EsisteGen: Boolean;
     Supnetta, VE:  real;
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
  assign(fintpot,percorsodrive+'\potinv.int');
  try
    {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    if FileExists(percorsodrive+'\potinv.int')
    then Reset(fintpot)
    else{$IfEND} Rewrite(fintpot);
    TotDisp:=0;
    TotDispNetto:=0;
    //TotDispNettoDM := 0;
    NFrontiere:=0;
    NFrontiereLin:=0;

    // ---------------------------------------
    //     Inizio Stampe Tabella DISPAMB
    // Dispersioni.rep - Relazione Dispersioni
    // ---------------------------------------

    Inizio_compart('DISPAMB');
    for i := 1 to Nambienti do
    begin
     if (uppercase(Ambienti_D^[i].CodZona)<> UpperCase('Non risc')) and (Pos('AGGRE-', Ambienti_D^[i].Denom) = 0)
     then
     {$IF (Defined(VERSIONE_12) or Defined(VERSIONE_13)) and Defined(L10)}
      if CompareStr(uppercase(DescGen1^[gencor].Descrizione), uppercase(Impianto_d^[CodiceImpianto(Ambienti_D^[i].Impianto)].GenInvt)) = 0
      then
     {$IFEND}
      begin
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
          VLordo:=VLordo + AmbTemp.Superficie * (AltLordaP + SpessTemp);
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
       // Emanuela e Fabio DM
       // totDispAmbDM := 0;
       // Emanuela e Fabio
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
        with AmbTemp.Par[j] do
        begin
         SupLordaPar := sup;
         {$IFDEF L10}
         if (Lato[1]<>'-') then
         begin
          if (j <> 1) and (j <> 2) then
          begin
            if (Alt = Alt2) and (alt = AltNettaP) then
             if Comparestr(UpperCase(AmbTemp.Piano), UpperCase(Piani_D^[1].Cod)) = 0 then
             begin
                SpessTemp := SpessPar(AmbTemp.Par[2].Cod);
                if Alt <> 0 then
                   supLordaPar := (Sup / Alt) * (AltLordaP + SpessTemp);
             end
             else
               if Alt <> 0 then
                  supLordaPar := (Sup / Alt) * AltLordaP;

            SpessTemp := SpessPar(Cod);
            if (Lato[1]='L') then
               Vlordo := Vlordo + (supLordaPar * SpessTemp/2)
            else
               Vlordo := Vlordo + (supLordaPar * SpessTemp);
          end;     
         end;
         {$ENDIF}
         if ((uppercase(confine)<>'NON SC') and (uppercase(confine)<>'INTERNO')) or
            ((Comparestr(UpperCase(AmbTemp.Piano), UpperCase(Piani_D^[1].Cod)) = 0) and  (Lato = 'OR')) or
            ((Comparestr(UpperCase(AmbTemp.Piano), UpperCase(Piani_D^[NPiani].Cod)) = 0) and  (Lato = 'OR'))
         then
         begin
          // Emanuela introdotta la condizione che consideri i lati divisori che hanno confine differente
          // ((Lato[1]='L') and (CompareStr(UpperCase(Confine), 'DIVISORI') <> 0))
          if (Lato[1]<>'L') or ((Lato[1]='L') and (CompareStr(UpperCase(Confine), 'DIVISORI') <> 0))
              and ((Lato[1]<>'-')or(espesterna)) then // Esposizione tra locali
          begin
           espesterna:=true;
           IncrCorr:=1;
           if lato <> '-' then
           begin
             // riga parete
             if codicepar(cod)<>0 then
             begin
               {$Ifdef L10}
                if CompareStr(UpperCase(Confine), 'DIVISORI') <> 0 then
                begin
                 if Lato <> 'OR' then
                 begin
                     // Caso pareti normali
                     // sommando le superfici dei lati degli angoli con le altre pareti
                     if Comparestr(UpperCase(AmbTemp.Piano), UpperCase(Piani_D^[1].Cod)) = 0 then
                     begin
                        if j <> AmbTemp.Npar then
                        begin
                          Nt := j;
                          trov := False;
                          while (Nt <= AmbTemp.Npar) and (not trov) do
                          begin
                           if AmbTemp.Par[Nt].Lato[1] <> '-' then
                           begin
                             supLordaPar := SupLordaPar + (SpessPar(AmbTemp.Par[Nt].Cod) * (AltLordaP + SpessPar(AmbTemp.Par[1].Cod)));
                             trov := True;
                           end;
                           inc(Nt);
                          end;
                        end
                        else
                         if AmbTemp.Par[3].Lato[1] <> '-' then
                            supLordaPar := SupLordaPar + (SpessPar(AmbTemp.Par[3].Cod) * (AltLordaP + SpessPar(AmbTemp.Par[1].Cod)));
                        Nt := j - 1;
                        trov := False;
                        while (Nt > 1) and (not trov) do
                        begin
                         if AmbTemp.Par[Nt].Lato[1] <> '-' then
                         begin
                           supLordaPar := SupLordaPar + (SpessPar(AmbTemp.Par[Nt].Cod) * (AltLordaP + SpessPar(AmbTemp.Par[1].Cod)));
                           trov := true;
                         end;
                         dec(Nt);
                        end;
                     end
                     else
                     begin
                        if j <> AmbTemp.Npar then
                        begin
                          Nt := j;
                          trov := False;
                          while (nt <= AmbTemp.Npar) and (not trov) do
                          begin
                           if AmbTemp.Par[Nt].Lato[1] <> '-' then
                           begin
                             supLordaPar := SupLordaPar + (SpessPar(AmbTemp.Par[Nt].Cod) * AltLordaP);
                             trov := True;
                           end;
                           inc(Nt);
                          end;
                        end
                        else
                          if AmbTemp.Par[3].Lato[1] <> '-' then
                             supLordaPar := SupLordaPar + (SpessPar(AmbTemp.Par[3].Cod) * AltLordaP);
                        Nt := j - 1;
                        trov := False;
                        while (nt > 1) and (not trov) do
                        begin
                         if AmbTemp.Par[Nt].Lato[1] <> '-' then
                         begin
                            supLordaPar := SupLordaPar + (SpessPar(AmbTemp.Par[j-1].Cod) * AltLordaP);
                            trov := true;
                         end;
                         dec(Nt);
                        end;
                     end;
                 end
                 else
                 begin
                    // caso pavimenti o soffitti
                    // Teniamo conto dell'angolo di inclinazione delle falde
                    if j = 2 then
                    begin
                      Angolo := RestituisciAngoloFalda(AmbTemp.Par[j].Confine)
                    end
                    else Angolo := 0;
                    // superfice spessori
                    For np := 3 to AmbTemp.Npar do
                    begin
                      Nt := np + 1;
                      trov := False;
                      while (nt <= AmbTemp.Npar) and (not trov) do
                      begin
                       if (AmbTemp.Par[nt].Lato[1] <> '-') and (CompareStr(UpperCase(AmbTemp.Par[nt].Confine), 'FITT') = 0) then
                       begin
                          SupLordaPar := SupLordaPar + ((SpessPar(AmbTemp.Par[nt].Cod) * SpessPar(AmbTemp.Par[np].Cod)) / cos(Angolo));
                          trov := True
                       end;
                       inc(nt);
                      end;
                    end;
                    Nt := AmbTemp.Npar;
                    trov := False;
                    while (nt > 1) and (not trov) do
                    begin
                       if AmbTemp.Par[nt].Lato[1] <> '-' then
                       begin
                          SupLordaPar := SupLordaPar + ((SpessPar(AmbTemp.Par[3].Cod) * SpessPar(AmbTemp.Par[nt].Cod)) / cos(Angolo));
                          trov := True;
                       end;
                       dec(nt);
                    end;
                    // superfice lati
                    For np:=3 to AmbTemp.Npar do
                    begin
                     if (AmbTemp.Par[np].Lato[1] <> '-') and (CompareStr(UpperCase(AmbTemp.Par[np].Confine), 'FITT') = 0) then
                     begin
                      if AmbTemp.Par[np].Alt <> 0 then
                       if AmbTemp.Par[np].Alt <> AmbTemp.Par[np].Alt2 then
                          SupLordaPar := SupLordaPar + ((SpessPar(AmbTemp.Par[np].Cod) * (AmbTemp.Par[np].Sup/((AmbTemp.Par[np].Alt + AmbTemp.Par[np].Alt2) / 2))) / cos(angolo))
                       else
                         SupLordaPar := SupLordaPar + ((SpessPar(AmbTemp.Par[np].Cod) * (AmbTemp.Par[np].Sup/AmbTemp.Par[np].Alt)) / cos(angolo))
                      else SupLordaPar := SupLordaPar + (AmbTemp.Par[np].Sup / Cos(Angolo));
                     end; 
                    end;
                 end;
                 SLorda := SLorda + SupLordaPar;
                 //SLorda:=Slorda+Sup;
                end;
               {$Endif}
                Supnetta:=calcSupNetta(AmbTemp, j);
                if ((uppercase(confine)<>'NON SC') and (uppercase(confine)<>'INTERNO')) then
                begin
                    with Frontiere_D^[Nuovafront(AmbTemp.num)]^ do
                    begin
                     SupMuro:=Supnetta;
                     codmuro:=Codiceparete;
                     Codesposiz:=EsposizPar(Confine,Lato);
                     if upstring(esposizioni_d[Codesposiz].Tipo)='E' then
                     begin
                      IncrCorr := esposizioni_d[Codesposiz].IncrSic;
                      DtCorr:=zone_d[AmbTemp.Zona].TInv-Prog.TEst;
                     end
                     else
                      DtCorr:=zone_d[AmbTemp.Zona].TInv-esposizioni_d[Codesposiz].TrifInv;
                    end;
                    // ------------------------------------
                    // Stampa valori dispersioni per Pareti
                    // ------------------------------------
                    WStrTab(Confine);              // Stampa colonna Confine
                    WStrTab(Lato);                 // Stampa colonna Lato
                    WRealeTab(DtCorr,2);           // Stampa colonna Delta T
                    // WRealeTab(zone_d[Ambienti_D^[i].zona].TInv-Prog.TEst,2);
                    WStrTab(Tipo);                 // Stampa colonna Categoria
                    WStrTab(Cod);                  // Stampa colonna Codice
                    // WStrTab(Strutture_d^[codicepar(cod)]^.Descr); // Stampa colonna Descrizione
                    if codicepar(cod) <> 0 then
                       WRealeTab(Strutture_d^[codicepar(cod)]^.Trasmitt,3); // Stampa colonna K-Klin
                    WRealeTab(SupLordaPar,2);      // Stampa colonna Superficie Lorda
                    WRealeTab(supnetta,2);         // Stampa colonna Superficie Netta
                    totdispriga:=Strutture_d^[codicepar(cod)]^.Trasmitt*supnetta*DTCorr*IncrCorr;
                    //Emanuela e Fabio calcolo della Qp corretta per DM
                    {MassaFrontalePareteDM := CercaMassaSuperficiale(Cod);
                    if MassaFrontalePareteDM < 100 then
                       CoeffCMDM := 0.98
                    else
                    if (MassaFrontalePareteDM >= 100) and (MassaFrontalePareteDM < 150) then
                        CoeffCMDM := 0.97
                    else
                    if (MassaFrontalePareteDM >= 150) and (MassaFrontalePareteDM < 200) then
                       CoeffCMDM := 0.95
                    else
                    if (MassaFrontalePareteDM >= 200) and (MassaFrontalePareteDM < 250) then
                        CoeffCMDM := 0.92
                    else
                    if (MassaFrontalePareteDM >= 250) and (MassaFrontalePareteDM < 300) then
                        CoeffCMDM := 0.88
                    else
                    if (MassaFrontalePareteDM >= 300) and (MassaFrontalePareteDM < 350) then
                        CoeffCMDM := 0.84
                    else
                    if (MassaFrontalePareteDM >= 350) and (MassaFrontalePareteDM < 400) then
                        CoeffCMDM := 0.80
                    else CoeffCMDM := 0.80; //caso non previsto dal DM
                    TrasmittDM := Strutture_d^[codicepar(cod)]^.Trasmitt * CoeffCMDM;
                    totdisprigaDM := TrasmittDM * supnetta * DTCorr * IncrCorr;   }
                    //Emanuela e Fabio
                    {$IFDEF L10}
                    AddStatistica(Strutture_d^[codicepar(cod)]^.Descr, totdispriga);
                    {$ENDIF}
                    totdispamb:=totdispamb+totdispriga;
                    //
                    //TotDispAmbDM := TotDispAmbDM + TotDispRigaDM;
                    WRealeTab((IncrCorr-1)*100,1); // Stampa colonna Incr% per Esposizione
                    WRealeTab(totdispriga,0);      // Stampa colonna Tot.Disp.[W]
                    FineRigaTabella;
                    Prima:=false;
                    suptot:=Sup;
                    esppar:=Lato;
                    CodPar:=Cod;
                end; {if prima del with}
             end; {end if codicepar}
           end
           else
            if tipo = TPonte then
            begin
              // riga ponte
              if CodicePon(cod) <> 0 then
              begin
                with FrontiereLin_D^[NuovaFrontLin(AmbTemp.num)]^ do
                begin
                 WStrTab('');            //Confine
                 WStrTab(Lato);
                 WRealeTab(DTCorr,2);
                 WStrTab(Tipo);
                 WStrTab(Cod);
                 CodEsp:=EsposizCor;
                 CodPonte1:=CodicePon(cod);
                 Lung1 := Num;
                 Kappa := Ponti_d^[CodicePon(cod)].KL;
                 WRealeTab(Ponti_d^[CodicePon(cod)].KL,3);
                 WRealeTab(Num, 2);       // Lunghezza del Ponte Termico
                 WRealeTab(0, 2);         // Superficie netta non utilizzata dal Ponte Termico
                 totdispriga:=Ponti_d^[CodicePon(cod)].KL*Num*DTCorr*IncrCorr;
                 // AddStatistica(Ponti_d^[CodicePon(cod)].Denom,totdispriga);
                 {$IFDEF L10}
                 AddStatistica(Ponti_d^[CodicePon(cod)].Codice, totdispriga);
                 {$ENDIF}
                 totdispamb:=totdispamb + totdispriga;
                 // Em
                 //TotDispAmbDM := TotDispAmbDM + TotDispRiga;
                 WRealeTab(0,0);         //Futuro inserimento incrementi
                 WRealeTab(totdispriga,0);
                 FineRigaTabella;
                end;
              end; {end fine CodicePon}
            end
            else
            if tipo = Tfin then
            begin
             // Emanuela 3/11/2005 inserita la condizione di non considerare le porte collefate
             // ha divisori le quali non scambiano.
             //if CompareStr(UpperCase(AmbTemp.Par[j-1].Confine), 'DIVISORI') <> 0 then
             if VerificaParetePrecedente(j-1, AmbTemp) then
             begin
              // riga finestra
              if codicefin(cod) <> 0 then
              begin
               with Frontiere_D^[Nuovafront(AmbTemp.Num)]^ do
               begin
                 SupTot:=suptot-sup;
                 SupMuro:=Sup;
                 WStrTab('');              // Stampa colonna Confine
                 WStrTab(Lato);            // Stampa colonna Lato
                 WRealeTab(DTCorr,2);      // Stampa colonna Delta T
                 WStrTab(Tipo);            // Stampa colonna Categ.
                 WStrTab(Cod);             // Stampa colonna Codice
                 Codesposiz:=EsposizCor;
                 codmuro:=Codiceparete;
                 Modfinestra:=1;
                 codfinestra:=Codicefin(cod);
                 SupFinestra:=Sup;
                 // 13 Gen 2oo5 - Fabio - Aggiunto Incremento per Esposizione alla finestra
                 if Codesposiz <> 0 then
                    IncrCorr := esposizioni_d[Codesposiz].IncrSic
                 else IncrCorr := 0;
                 // --------------------------------------
                 // Stampa valori dispersioni per Finestre
                 // --------------------------------------
                 WRealeTab(Finestre_d^[codicefin(cod)].Trasmittanza,3);  // Stampa la colonna K-Klin
                 WRealeTab(sup,2);                                       // Stampa colonna S.Lorda
                 WRealeTab(sup,2);                                       // Stampa colonna S.Netta
                 totdispriga:=Finestre_d^[codicefin(cod)].Trasmittanza*sup*DTCorr*IncrCorr;
                 {$IFDEF L10}
                 AddStatistica(Finestre_d^[codicefin(cod)].Denom, totdispriga);
                 {$ENDIF}
                 Prima:=false;
                 suptot:=Sup;
                 esppar:=Lato;
                 CodPar:=Cod;
                 totdispamb:=totdispamb+totdispriga;
                 // Emanuela e Fabio dm
                 //TotDispAmbDM := TotDispAmbDM + TotDispRiga;
                 // Emanuela e fabio
                 // 13 Gen 2oo5 - Fabio - Stampa valore Incremento per Esposizione della finestra
                 if IncrCorr <> 0 then
                    WRealeTab((IncrCorr - 1) * 100,1) // Stampa colonna Incr% per esposizione
                 else WRealeTab(IncrCorr,1);
                 // WRealeTab(Finestre_d^[codicefin(cod)].INCRSICUREZZAFINESTRA,1); // Stampa colonna Incr%
                 WRealeTab(totdispriga, 0); // Stampa colonna Tot.Disp.[W]
                 FineRigaTabella;
               end; {end with frontiere}
              end; {end if codicefin}
             end; {end if la parete precedente è un divisorio} 
            end;{ fine gestione degli if annidati per la gestione delle righe delle tabelle}
          end
          else espesterna:=false;
         end; {end if Confine <> Non SC}
        end;{end with ambTemp.Par[j]}
       end;{end for che scorre le pareti finestre e ponti termici dell'ambiente}
       FineTabella;
       with AmbTemp do
       begin
        // ----------------------------------------------------
        // Inizio Stampe relative alla relazione di Dispersioni
        // ----------------------------------------------------
        {TODO -oGenerale -cIndice : Inizio Stampe relative alla relazione di Dispersioni }
        // Calcolo della portata d'aria
        portAria := Ricambio_ariamch(0,NPersone*RicambioPersona,Ventilazione*Superficie*HSoffitto,0,0);
        // Calcolo delle dispersioni per infiltrazioni d'aria
        if zona <> 0 then
           DispInf := -Pot_sensAria(zone_d^[zona].TInv,Prog.TEst,InfInv*Superficie*HSoffitto,0)
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
        VolNetto := VolNetto +  Superficie * HSoffitto;
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
       // Emanuela e Fabio per DM
       //TotDispNettoDM := TotDispNettoDM + TotDispAmbDM;
       // Emanuela e Fabio
       // Emanuela 5/7/2006 calcolo dell'apporto per intermittenza
       W_Reale('DISPAMB',TotDispAmb,0);
       bufIntpot.DispInf := TotDispAmb;
       Totdispamb := TotDispAmb +  DispInf ;  ///
       IncrInt := (TotDispAmb * zone_d^[AmbTemp.zona].IncrIntV) /100;
       if IncrInt <> 0 then
          TotDispAmb := TotDispAmb + IncrInt;
       W_Reale('INCR_ZT',zone_d^[AmbTemp.zona].IncrIntV,0);
       W_Reale('POT_INCR_ZT', IncrInt,0);
       W_Reale('TOT_DISP_AMB',TotDispAmb+AppVent,0);
       TotApp_Vent := TotApp_Vent + AppVent;
       with bufIntpot do
       begin
          NumAmb  := strtoint(AmbTemp.codnum);
          NomeLoc := AmbTemp.Denom;
          POt     := TotdispAmb;
          Port    := AmbTemp.RicambioPersona;
          Piano   := AmbTemp.Piano;
          Vol     := VolInterno;
          Sup     := AmbTemp.Superficie;
         {$Ifdef L10}
          CodGen  := DescGen1^[gencor].Cod;
         {$Else}
          CodGen  := '';
         {$EndIF}  
       end;
       seek(Fintpot, FileSize(FintPot));
       write(fintpot,Bufintpot);
       TotDisp:=TotDisp+TotDispAmb;                                  // TotDisp=TotDisp+DispVent
       Tot_Ventilazione := Tot_Ventilazione + Pot_Ventilazione;      // TotDisp=TotDisp+DispVent
       Fine_gruppo;
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
    CloseFile(fintpot);
  except
    CloseFile(fintpot);
  end;
  {$Ifdef L10}
    { TODO -oGenerale -cIndice : Calcolo CD Fen e CD Legge }
   if EsisteGen then
   begin
    with DescGen1^[gencor] do
    begin

      //---------------------------------------------------
      // Da qui in poi si scrivono le variabili sul file DB
      // Solo scrittura non è possibile stampare sul rep
      //---------------------------------------------------
      // Inserisce comunque il valore di Vlordo ed Slorda
      // impostandolo uguale a Vnetto e Snetta se non si imposta
      // all'inizio del progetto. Modifica del 23 giugno 2oo4

     {$IFDEF VERSIONE_11}
      if Prog^.SuperficieLorda > 0 then Slorda := Prog^.SuperficieLorda;
      if Prog^.VolumeLordo > 0 then Vlordo := Prog^.VolumeLordo;
     {$ENDIF}
       
      DispCDInf:=TotDisp - Tot_Ventilazione - TotApp_Vent;        // Controllare bene questo dato
      if VolNetto <> 0 then
      begin
        //DispCDVol:=DispCDInf/VLordo
        DispCDVol:=DispCDInf/VolNetto // Emanuela 8 Mar 2005 Correzione Visualizzazione Rapporto Dispersioni / Volume Netto
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
      // Emanuela DM
      // dispersDM := TotDispNettoDM;
      // Emanuela
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
      // Emanuela e Fabio calcolo cd corretto
      // if (volLord*dt) <> 0 then cdadot := dispersDM/(volLord*dt);
      // Emanuela e Fabio
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
  //attivorep:=true;
end; {fine della Funzione compilaFront}

Function RestituisciAngoloFalda(CodiceConf: String): real;
var
  i: Integer;
  Trovato: Boolean;
begin
  i := 1;
  Trovato := False;
  Result := DegToRad(0);
  while (not Trovato) and (i <= NConfini) do
  begin
    if CompareStr(Confine_D^[i].Codice, CodiceConf) = 0 then
    begin
       Result := DegToRad(Confine_D^[i].Inclin);
       Trovato := True;
    end;
    inc(i);
  end;
end;

function  ConfineInterno(Cod: String; var TI: Real): Boolean;
var
  i: Integer;
begin
  Result := False;
  for i := 1 to NConfini do
  begin
    if (CompareStr(UpperCase(Confine_D^[i].TipoConfine), 'INTERNO') = 0) and
       (CompareStr(UpperCase(Confine_D^[i].Codice), UpperCase(Cod)) = 0)
    then
    begin
      Result := True;
      TI := Confine_D^[i].TrifInv;
      exit;
    end;
  end;
end;

end.


