unit UVariabiliPareti;

interface
uses IniFiles, Db, dbtables, SysUtils, Dialogs, MSG, 
     UDataLink, UDB, Classes, LibreriaGenerale, Math;
{$I Typedef}

Const
   maxpres = 600;
   NMater  = 950;
   Nstrati = maxstrati;
   GAMMA   = 187.52;

Type
   // Emanuela DPR 192: definizione tabella da usare per il confronto della
   // trasmittanza
   Tab2_192 = array[1..6] of double;

   Archivio = record
	       cod:string[5];
	       nome:string[30];
               spes:real;
	       lamda,Cond,mu,densita,ct:real;
	      end;

   Contorno = record
	       Ti,
               Te,
               URi,
               URe,
               wind,
               PercInc,
               EsTi,
               EsTe,
               EsURI,
               EsURE,
               EsG:real;
               TipoStrut:integer;
	       st_vet:string[1];epson,
               alfa,alfa_10,
               beta,beta_10:real;
	      end;
   // Emanuela
  {$IFDEF VERSIONE_13}
   PInfoParRisIgro = ^InfoParRisIgro;
   InfoRisIgro = record
                   Mese: String[10];
                   Ti : Real;
                   URi: Real;
                   Te : Real;
                   URe: Real;
                   Pi, Pe: Real;
                   TMin, FRSI, GC, Ma: Real;
                 end;
   DatiCondInt = record
                   CodStraT, CodStraP: String[50];
                   CondensaInt, QNoEvap: Real;
                   MeseCondI: String[10];
                   MesInC: SmallInt;
                 end;
   InfoParRisIgro = Record
                      CodParete: String[10];
                      CondInt, CondSup, Evap: Boolean;
                      Dati: array [1..12] of InfoRisIgro;
                      DCond: array [1..10] of DatiCondInt;
                      NStrCond: SmallInt;
                      MeseSup: String[10];
                      MeseIn: SmallInt;
                      FrsiM, Frsi: Real;
                    end;
    DatiStampa = Record
                      CodParete: String[10];
                      CondInt, CondSup, Evap: Boolean;
                      Dati: array [1..12] of InfoRisIgro;
                      MeseIn: SmallInt;
                 end;
    DatiCondSup = Record
                    Te, Ure, Pe, DeltaPe, PI: Real;
                    Psi, Tsi, Ti, frsi: Real;
                  end;
  {$ENDIF}
   //Emanuela
   Arch = array [0..NMater] of Archivio;

   materiali = record
		cod:string[5];
		nome:string[30];
		s:real;
	       end;
   Addutt = record
	      Alfai,Alfae,alfai_10,alfae_10:real;
	    end;


   tab = array [-1..NStrati] of materiali;

   materialiPon = record
                    cod:string[5];
                    nome:string[30];
                    s,perc,Tras:real;
	          end;
   tabPon = array [-1..NStrati] of materialiPon;

   RecCalcolo = record
		 spes,lamda,Cond,mu,densita,ct,r,dt,tf,ps,rv,dp,pv,ds,cts:real;
                {$IFDEF VERSIONE_13}
                 Gci,SVac,SVbc,Mai,PVa,Pvb:real;
                 desc:string[50];
                {$ENDIF}
	        end;

   ArrCalcolo = array[-1..NStrati]of RecCalcolo;
   recpres    = array[1..600] of Smallint;
   Stampa = record
	      nome:string[30];
	      densita,s,lamda,r,dt,tf,ps,mu,rv,dp,pv,ds,ct,cts:real;
	    end;

   ArrStampa = array [-1..NStrati] of Stampa;

const Press: recpres =({$I pression.pas});

Var
    k, c, ds, rt, rt10, Trasm, trasm10: real;
    RVT: real;
    AlfaI_E: Addutt;
    sts: boolean;
    NumStrati: Integer;
    Tab2, Tab3,tab3a, Tab4a, Tab4b: Tab2_192;

    Cond_Cont:  ^Contorno;
    tabe     :  ^tab;
    tabePond :  ^tabPon;
    ArcIgro:    ^arch;
    TabCalcolo: ^ArrCalcolo;
   {$IFDEF VERSIONE_13}
    TabCalcoloMesi: array[1..12] of record
                                      Tabcalcolo: ArrCalcolo;
                                    end;
   {$ENDIF}                                 
    TabStampa:  ^ArrStampa;
     // Emanuela
    Calcolo192: Boolean;
   {$IFDEF VERSIONE_13}
    TabellaRis: TList;
    TPMedieMensili: array [1..2,1..12] of real;
    TabCondSup: array [1..12] of DatiCondSup;
   {$ENDIF}

Procedure InitCalcolo;
Procedure CaricaParete(Mese: Integer; Graf: Boolean);
Procedure DisposeCalcolo;
//Emanuela DPR 192
Procedure AssegnaValoriTabella2;
// Emaneula DPR 192 Funzioni e procedure inserite la Emanuela
function Info_ZonaClimatica_Fabbricato: String;
function Info_Classificazione_Fabbricato: String;
Function Pressat(T:real):Real;
function RestituisciMese(IndM: SmallInt): String;
function GiorniMese(IndM: SmallInt): SmallInt;
{$IFDEF VERSIONE_13}
Procedure CreaTabellaRis;
Function  CercaIndiceTabella(Codice: String): Integer;
Procedure InserisciNuovaParete(Codice: String);
Procedure CreaFileIgro;
Procedure ChiudiTabella;
Function CalcoloURE(TE: Real; Mese: Integer): Real;
Procedure InitDatiCondSup;
Function ClasseDiUmidita: Integer;
Function CalcoloTemp(Psat: real): Real;
{$ENDIF}

implementation

function RestituisciMese(IndM: SmallInt): String;
begin
   case IndM of
    1: Result := 'Gennaio';
    2: Result := 'Febbraio';
    3: Result := 'Marzo';
    4: Result := 'Aprile';
    5: Result := 'Maggio';
    6: Result := 'Giugno';
    7: Result := 'Luglio';
    8: Result := 'Agosto';
    9: Result := 'Settembre';
    10: Result := 'Ottobre';
    11: Result := 'Novembre';
    12: Result := 'Dicembre';
   end;
end;

function GiorniMese(IndM: SmallInt): SmallInt;
begin
   case IndM of
    1: Result := 31;
    2: Result := 28;
    3: Result := 31;
    4: Result := 30;
    5: Result := 31;
    6: Result := 30;
    7: Result := 31;
    8: Result := 31;
    9: Result := 30;
    10: Result := 31;
    11: Result := 30;
    12: Result := 31;
   end;
end;

{$IFDEF VERSIONE_13}
Procedure InitDatiCondSup;
var
  i: Integer;
begin
  for i:= 1 to 12 do
  begin
    TabCondSup[i].Te      := 0;
    TabCondSup[i].Ure     := 0;
    TabCondSup[i].Pe      := 0;
    TabCondSup[i].DeltaPe := 0;
    TabCondSup[i].PI      := 0;
    TabCondSup[i].Psi     := 0;
    TabCondSup[i].Tsi     := 0;
    TabCondSup[i].Ti      := 0;
    TabCondSup[i].frsi    := 0;    
  end;
end;

Function ClasseDiUmidita: Integer;
var
  ClasseU: String;
Begin
  ClasseU := dm1.TT1.FieldByName('Classe Umid.Interna').AsString;
  if CompareStr(ClasseU, 'Magazzino') = 0 then
    Result := 1
  else
  if CompareStr(ClasseU, 'Ufficio - Negozio') = 0 then
    Result := 2
  else
  if CompareStr(ClasseU, 'Abitazione con basso indice di occupazione') = 0 then
    Result := 3
  else
  if CompareStr(ClasseU, 'Abitazione con alto indice di occupazione - Palestra - Cucina - Cantina - Edificio riscaldato con terminali') = 0 then
    Result := 4
  else
  if CompareStr(ClasseU, 'Abitazione con basso indice di occupazione') = 0 then
    Result := 5;
end;

{-----------------------------------------------------------------------------
  Procedure: CreaTabellaRis
  Author:    e.diquattro
  Date:      08-set-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Crea la Tebella dei risultati di calcolo per le pareti
-----------------------------------------------------------------------------}
Procedure CreaTabellaRis;
begin
  TabellaRis := TList.Create;
end;

{-----------------------------------------------------------------------------
  Procedure: CercaIndiceTabella
  Author:    e.diquattro
  Date:      08-set-2006
  Arguments: Codice
  Result:    Integer
  
  Cosa fa: restituisce la posizione della parete nella lista
-----------------------------------------------------------------------------}
Function  CercaIndiceTabella(Codice: String): Integer;
var
  i: Integer;
begin
  Result := 0;
  For i := 0 to TabellaRis.Count - 1 do
  begin
    if CompareStr(UpperCase(PInfoParRisIgro(TabellaRis.Items[i]).CodParete), UpperCase(Codice)) = 0 then
    begin
      Result := i;
      exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: InserisciNuovaParete
  Author:    e.diquattro
  Date:      08-set-2006
  Arguments: Codice: String
  Result:    None
  
  Cosa fa: Inserisci una nuova parete nella lista
-----------------------------------------------------------------------------}
Procedure InserisciNuovaParete(Codice: String);
var
  TempInfoP: PInfoParRisIgro;
  i, j: Integer;
begin
  New(TempInfoP);
  TempInfoP.CodParete :=codice {dm1.TT1.FieldByName('Codice').AsString};
  TempInfoP.CondInt := False;
  TempInfoP.CondSup := False;
  for i := 1 to 12 do
  begin
   case i of
    1: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    2: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    3: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    4: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    5: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    6: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    7: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    8: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    9: TempInfoP.Dati[i].Mese  := RestituisciMese(i);
    10: TempInfoP.Dati[i].Mese := RestituisciMese(i);
    11: TempInfoP.Dati[i].Mese := RestituisciMese(i);
    12: TempInfoP.Dati[i].Mese := RestituisciMese(i);
   end;
    TempInfoP.Dati[i].Ti   := 0;
    TempInfoP.Dati[i].URi  := 0;
    TempInfoP.Dati[i].Te   := 0;
    TempInfoP.Dati[i].URe  := 0;
    TempInfoP.Dati[i].Pi   := 0;
    TempInfoP.Dati[i].Pe   := 0;
    TempInfoP.Dati[i].TMin := 0;
    TempInfoP.Dati[i].FRSI := 0;
    TempInfoP.Dati[i].GC   := 0;
    TempInfoP.Dati[i].Ma   := 0;
  end;
  for j := 1 to 10 do
  begin
    TempInfoP.DCond[j].CondensaInt := 0;
    TempInfoP.DCond[j].MeseCondI   := '';
    TempInfoP.DCond[j].QNoEvap     := 0;
    TempInfoP.DCond[j].CodStraT    := '';
    TempInfoP.DCond[j].CodStraP    := '';
    TempInfoP.DCond[j].MesInC      := 1;
  end;
  TempInfoP.NStrCond := 0;
  TempInfoP.MeseSup  := '';
  TempInfoP.FrsiM    := 0;
  TempInfoP.Frsi     := 0;
  TempInfoP.MeseIn   := 1;
  TempInfoP.CondInt  := False;
  TempInfoP.CondSup  := False;
  TempInfoP.Evap     := False;
  TabellaRis.Add(TempInfoP);
end;

Procedure CreaFileIgro;
var
  FileIgro: file of DatiStampa;
  i, j: Integer;
  TempRisInfoPar: DatiStampa;
begin
  AssignFile(FileIgro, IncludeTrailingPathDelimiter(PercorsoDrive) + 'Igro.dat');
  Rewrite(FileIgro);
  for i := 0 to TabellaRis.Count - 1 do
  begin
    TempRisInfoPar.CodParete := PInfoParRisIgro(TabellaRis.Items[i]).CodParete;
    TempRisInfoPar.CondInt   := PInfoParRisIgro(TabellaRis.Items[i]).CondInt;
    TempRisInfoPar.CondSup   := PInfoParRisIgro(TabellaRis.Items[i]).CondSup;
    TempRisInfoPar.MeseIn    := PInfoParRisIgro(TabellaRis.Items[i]).MeseIn;
    TempRisInfoPar.CondInt   := PInfoParRisIgro(TabellaRis.Items[i]).CondInt;
    TempRisInfoPar.CondSup   := PInfoParRisIgro(TabellaRis.Items[i]).CondSup;
    TempRisInfoPar.Evap      := PInfoParRisIgro(TabellaRis.Items[i]).Evap;
    for j := 1 to 12 do
      TempRisInfoPar.Dati[j] := PInfoParRisIgro(TabellaRis.Items[i]).Dati[j];
    Write(FileIgro, TempRisInfoPar);
  end;
  CloseFile(FileIgro);
end;

Procedure ChiudiTabella;
begin
  TabellaRis.Clear;
  FreeAndNil(TabellaRis);
end;
{$ENDIF}

{-----------------------------------------------------------------------------
  Procedure: Info_ZonaClimatica_Fabbricato
  Author:    e.diquattro
  Date:      29-nov-2005
  Arguments: None
  Result:    String

  Cosa fa: Emanuela DPR 192 ritorna la zona climatica del progetto
-----------------------------------------------------------------------------}
function Info_ZonaClimatica_Fabbricato: String;
var
   TableF : TTable;
begin
  if FileExists(Percorso_Progetti + 'Fabbricato.db') then
  begin
     TableF := TTable.Create(Nil);
     TableF.DatabaseName := Percorso_progetti;
     TableF.TableName := 'Fabbricato.db';
     if TableF.Exists then
     begin
      TableF.Open;
      Result := TableF.FieldByName('Zona Climatica').AsString;
      TableF.Close;
     end; 
     FreeandNil(TableF);
  end
  else MessageDlg(goMSG('MSG_004032001',MSG_004032001), mtInformation, [mbOk], 0);   
end;

{-----------------------------------------------------------------------------
  Procedure: Info_Classificazione_Fabbricato
  Author:    e.diquattro
  Date:      29-nov-2005
  Arguments: None
  Result:    String
  
  Cosa fa: Emanuela DPR 192 ritorna la classificazione del progetto
-----------------------------------------------------------------------------}
function Info_Classificazione_Fabbricato: String;
var
   TableF : TTable;
begin
  if FileExists(Percorso_Progetti + 'Fabbricato.db') then
  begin
     TableF := TTable.Create(Nil);
     TableF.DatabaseName := Percorso_progetti;
     TableF.TableName := 'Fabbricato.db';
     TableF.Open;
     Result := TableF.FieldByName('Classe edificio').AsString;
     TableF.Close;
     FreeandNil(TableF);
  end
  else MessageDlg(goMSG('MSG_004032001',MSG_004032001), mtInformation, [mbOk], 0);   
end;

{-----------------------------------------------------------------------------
  Procedure: AssegnaValoriTabella2
  Author:    e.diquattro
  Date:      29-nov-2005
  Arguments: None
  Result:    None

  Cosa fa: Emanuela DPR 192, caricamento dei valori della tabella 2 necessaria
           per il controllo della trasmittanza 
-----------------------------------------------------------------------------}

Procedure AssegnaValoriTabella2;
var
  FIni: TIniFile;
  Anno: String;
begin
{
  FIni := TIniFile.Create(IncludeTrailingPathDelimiter(PercorsoDrive) + 'DatiRelazione.ini');
  Anno := FIni.ReadString('Anno', 'Anno', '2006');
  FIni.Free;
  if (CompareStr(Anno,'2006') = 0) or
     (CompareStr(Anno,'2007') = 0) or
     (CompareStr(Anno,'2008') = 0)
  then
} if false then
  begin
  //Emanuela DPR 192 valori limite della trasmittanza termica U delle strutture verticali opache espressa
  //in W/m²K dal 1/1/2006 fino al 31/12/2007
    Tab2[1] := 0.85;    //Zona climatica A
    Tab2[2] := 0.64;    //Zona climatica B
    Tab2[3] := 0.57;    //Zona climatica C
    Tab2[4] := 0.50;    //Zona climatica D
    Tab2[5] := 0.46;    //Zona climatica E
    Tab2[6] := 0.44;    //Zona climatica F
  //Emanuela DPR 192 valori limite della trasmittanza termica U delle strutture orizzontali opache espressa
  //in W/m²K dal 1/1/2006 fino al 31/12/2008
    Tab3[1] := 0.80;    //Zona climatica A
    Tab3[2] := 0.60;    //Zona climatica B
    Tab3[3] := 0.55;    //Zona climatica C
    Tab3[4] := 0.46;    //Zona climatica D
    Tab3[5] := 0.43;    //Zona climatica E
    Tab3[6] := 0.41;    //Zona climatica F
  //Emanuela DPR 192 valori limite della trasmittanza termica U delle strutture chiusure trasparenti espressa
  //in W/m²K dal 1/1/2006 fino al 31/12/2009
    Tab4a[1] := 5.5;    //Zona climatica A
    Tab4a[2] := 4.0;    //Zona climatica B
    Tab4a[3] := 3.3;    //Zona climatica C
    Tab4a[4] := 3.1;    //Zona climatica D
    Tab4a[5] := 2.8;    //Zona climatica E
    Tab4a[6] := 2.4;    //Zona climatica F
  //Emanuela DPR 192 valori limite della trasmittanza termica U delle strutture trasparenti espressa
  //in W/m²K dal 1/1/2006 fino al 31/12/2009
    Tab4b[1] := 5.0;    //Zona climatica A
    Tab4b[2] := 4.0;    //Zona climatica B
    Tab4b[3] := 3.0;    //Zona climatica C
    Tab4b[4] := 2.6;    //Zona climatica D
    Tab4b[5] := 2.4;    //Zona climatica E
    Tab4b[6] := 2.3;    //Zona climatica F
  end
  else
  begin
  //Emanuela DPR 192 valori limite della trasmittanza termica U delle strutture verticali opache espressa
  //Diego agg 311 in W/m²K dal 1/1/2008 in poi sino al2010
    Tab2[1] := 0.72;    //Zona climatica A
    Tab2[2] := 0.54;    //Zona climatica B
    Tab2[3] := 0.46;    //Zona climatica C
    Tab2[4] := 0.40;    //Zona climatica D
    Tab2[5] := 0.37;    //Zona climatica E
    Tab2[6] := 0.35;    //Zona climatica F
    //Diego agg 311 valori limite della trasmittanza termica U delle coperture espressa
  //in W/m²K dal 1/1/2008 in poi sino al2010
    Tab3[1] := 0.42;    //Zona climatica A
    Tab3[2] := 0.42;    //Zona climatica B
    Tab3[3] := 0.42;    //Zona climatica C
    Tab3[4] := 0.35;    //Zona climatica D
    Tab3[5] := 0.32;    //Zona climatica E
    Tab3[6] := 0.31;    //Zona climatica F

  //Diego agg 311 valori limite della trasmittanza termica U dei pavimenti espressa
  //in W/m²K dal 1/1/2008 in poi sino al2010
    Tab3a[1] := 0.74;    //Zona climatica A
    Tab3a[2] := 0.55;    //Zona climatica B
    Tab3a[3] := 0.49;    //Zona climatica C
    Tab3a[4] := 0.41;    //Zona climatica D
    Tab3a[5] := 0.38;    //Zona climatica E
    Tab3a[6] := 0.36;    //Zona climatica F
  //Diego agg 311 valori limite della trasmittanza termica U delle finestre espressa
  //in W/m²K dal 1/1/2008 in poi sino al2010
    Tab4a[1] := 5.0;    //Zona climatica A
    Tab4a[2] := 3.6;    //Zona climatica B
    Tab4a[3] := 3.0;    //Zona climatica C
    Tab4a[4] := 2.8;    //Zona climatica D
    Tab4a[5] := 2.4;    //Zona climatica E
    Tab4a[6] := 2.2;    //Zona climatica F
  //Diego agg 311 valori limite della trasmittanza termica U dei vetri espressa
  //in W/m²K dal 1/1/2008 in poi sino al2010
    Tab4b[1] := 4.5;    //Zona climatica A
    Tab4b[2] := 3.4;    //Zona climatica B
    Tab4b[3] := 2.3;    //Zona climatica C
    Tab4b[4] := 2.1;    //Zona climatica D
    Tab4b[5] := 1.9;    //Zona climatica E
    Tab4b[6] := 1.7;    //Zona climatica F
  end;
end;

Procedure InitCalcolo;
begin
  New(TabCalcolo);
  New(Cond_cont);
  New(Tabe);
  New(Tabepond);
  New(ArcIgro);
  New(TabStampa);
end;

function Pressat(T:real):Real;
var
     i,j:Smallint;
begin
  {$IFDEF VERSIONE_13}
    //ISO 13788  E7 E8
    if T>=0 then
    result:=610.5*exp(17.269*T/(237.3+T))
    else
    result:=610.5*exp(21.875*T/(265.5+T));
  {$ELSE}
    if T < -29.9 then Pressat:=39
    else
     begin
        if T > 29.9 then Pressat:=4218
        else
        begin
            T := T + 29.9;
            T := T * 10 + 1;
            if T > 300 then T := T+1;
            i := round(T);
            Pressat := Press[i];
        end;
     end;
  {$ENDIF}
end;

Function CalcoloURE(TE: Real; Mese: Integer): Real;
begin
 {$IFDEF VERSIONE_13}
  Result := (TPMedieMensili[2, mese] / Pressat(Te)) * 100;
 {$ENDIF}
end;

Function CalcoloTemp(Psat: real): Real;
var
  Temp: Real;
begin
  if PSat >= 610.5 then
    Temp := (237.3 * ln(psat/610.5)) / (17.269 - ln(psat / 610.5))
  else
  if Psat < 610.5 then
     Temp := (265.5 * ln(psat/610.5)) / (21.875 - ln(psat / 610.5));
  Result := RoundTo(Temp, -2);
end;

Procedure caricaParete(Mese:integer; Graf: Boolean);
Var
  i:integer;
begin
  with dm1.TT3 do
  begin
    i:=0;
    first;
    while not eof do
    begin
      if V_Recstrati.Descrizione <> '' then
      begin
        inc(i);
        ArcIgro^[i].Cod:=V_Recstrati.Nfile;
        ArcIgro^[i].Nome:=V_Recstrati.Descrizione;
        ArcIgro^[i].spes:=V_Recstrati.Spessore;
        ArcIgro^[i].lamda:=V_Recstrati.ConduttivitaLineare;
        ArcIgro^[i].cond:=V_Recstrati.Conduttanza;
        ArcIgro^[i].mu:=V_Recstrati.mu;
        ArcIgro^[i].densita:=V_Recstrati.Pesospecifico;
        ArcIgro^[i].ct:=V_Recstrati.Calorespecifico;
      end;
      next;
    end;
  end;

  Numstrati:=i;

  with cond_cont^ do
  begin
   Ti  :=  v_Tabstruttura.Ti;
   URi :=  v_Tabstruttura.URi;
   if (CompareStr(UpperCase(v_TabStruttura.interest) , 'INTERNA') = 0) then
   begin
     Te := v_Tabstruttura.Ti;
     URe := v_Tabstruttura.URi;
   end
   else
   begin
    {$IFDEF VERSIONE_13}
     if Graf and (Mese = 1) then
        Te := v_Tabstruttura.Te
     else Te  :=  TPMedieMensili[1,mese];
    {$ELSE}
      Te := v_Tabstruttura.Te;
    {$ENDIF}
     {$IFDEF VERSIONE_13}
      if Graf and (Mese = 1) then
       URe := v_Tabstruttura.URe
      else
       URe:= Round(CalcoloURE(TE, Mese));
     {$ELSE}
       URe := v_Tabstruttura.URe;
     {$ENDIF}
    end;
    wind:=      v_Tabstruttura.wind;
    PercInc:=   v_Tabstruttura.PercInc;
    EsTi:=      v_Tabstruttura.Ti;
    EsTe:=      v_Tabstruttura.EsTe;
    EsURI:=     v_Tabstruttura.EsURI;
    EsURE:=     v_Tabstruttura.EsURE;
    EsG:=       v_Tabstruttura.EsG;
    TipoStrut:= v_Tabstruttura.TipoStrut;
    st_vet:=    v_Tabstruttura.st_vet;
    epson:=     v_Tabstruttura.epson;
    alfa:=      v_Tabstruttura.HI;
    alfa_10:=   v_Tabstruttura.Alfa;
    beta:=      v_Tabstruttura.HE;
    beta_10:=   v_Tabstruttura.beta;
  end;

end;

Procedure DisposeCalcolo;
begin
  Dispose(TabCalcolo);
  Dispose(Cond_cont);
  Dispose(Tabepond);
  Dispose(Tabe);
  Dispose(ArcIgro);
  Dispose(TabStampa);
end;

end.
