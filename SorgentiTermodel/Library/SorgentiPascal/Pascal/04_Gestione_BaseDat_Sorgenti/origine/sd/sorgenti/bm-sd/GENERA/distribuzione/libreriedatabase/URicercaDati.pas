unit URicercaDati;

interface

uses SysUtils, Math, Uvariabili, UdataLink, Varcarichi, UMessaggiCarichi;

Type
   TIntPot = record
              NumAmb: Integer;
              NomeLoc, Piano, CodGen: String[30];
              Pot, Port, DispInf, Vol, Sup: Double;
            end;
   PMyTIntPot  = ^MyTIntPot;
   MyTIntPot = Record
                 RecIntPot: TIntPot;
                 Next: PMyTIntPot;
               end;

var
   TestaLFIntPot, CodaLFIntPot: PMyTIntPot;
   BufIntPOt: TintPOt;
   FIntPOt: file of Tintpot;

   Function Codicepar(Cod:String): Integer;
   Function CodiceZona_D(DescrZona: String): String;
   Function RestituisciClassZona(DescrZona10: String): String;
   Function CodiceFin(Cod:String): Integer;
   Function CodicePon(Cod: String): Integer;
   Function CodiceImpianto(Cod: String): Integer;
   Function CodiceZona(Cod: String): Integer;
   Function CodiceProfilo(Cod:String):Integer;
   Function CercaIndiceZone(CodiceZona: String): Integer;
   Function AltLordaPiano(CodPiano: String; Tipo: char): real;
   Function RestituisciAngoloFalda(CodiceConf: String): real;
   Function ConfineInterno(Cod: String; var TI: Real): Boolean;
   Procedure CreaListaIntPot;
   Procedure RicercaLocaleIntPot(CodAmb: Integer; Amb: RecAmb; TotDsp, VInt, DispInf: Real; CodGen: String);
   Procedure CreaFileIntPot(Nomefile: String);
   Procedure SvuotaListaIntPot;

implementation

{-----------------------------------------------------------------------------
  Procedure: Codicepar
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: Cod: String
  Result:    vInteger

  Cosa fa: Restituisce l'indice dove si trovano le informazioni della parete
-----------------------------------------------------------------------------}
Function Codicepar(Cod: String): Integer;
Var
  i: Integer;
  Trovato: Boolean;
begin
 // Emanuela 25/3/2005 - 14:23 Inserito controllo affinchè non vengano dati errori per le
 // pareti fittizie e di tipo Nessuno
 Result := 0;
 if (CompareStr(UpperCase(Cod), 'NESSUNO') <> 0) and (CompareStr(UpperCase(Cod), 'FITTIZIA') <> 0)
 then
 begin
   if Nstrutture <> 0 then
   begin
    i:=1;
    Trovato := False;
    while (i <= NStrutture) and (not Trovato) do
    begin
      if CompareStr(UpperCase(Cod), UpperCase(Strutture_d^[i]^.NFile)) = 0 then
         Trovato := True
      else inc(i);
    end;
    if not Trovato then
    begin
      Result := 0;
      Erroregen := True;
      echo('La parete di codice ' + cod + ' non è stata trovata in archivio');
    end
    else result:=i;
   end;
 end
 else result := 0;
end;

{-----------------------------------------------------------------------------
  Procedure: CodiceFin
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: Cod:String
  Result:    Integer

  Cosa fa: Restituisce l'indice dei dati della finestra
-----------------------------------------------------------------------------}
Function CodiceFin(Cod: String): Integer;
Var
  i: Integer;
  Trovato: Boolean;
begin
 Result := 0;
 if NFinestre <> 0 then
 begin
  i := 1;
  Trovato := False;
  while (i <= NFinestre) and (not Trovato) do
  begin
   if CompareStr(UpperCase(Cod), UpperCase(Finestre_d^[i].Codice)) = 0 then
      Trovato := True
   else inc(i);
  end;
  if not Trovato then
  begin
   result:=0;
   Erroregen:=true;
   if cod <> '' then echo('La finestra di codice '+ cod + ' non è stata trovata in archivio')
   else echo('Codice Finestra vuoto');
  end
  else result:=i;;
 end;
end;

{-----------------------------------------------------------------------------
  Procedure: CodicePon
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: Cod:String
  Result:    Integer

  Cosa fa: restituisce l'indice del ponte termico
-----------------------------------------------------------------------------}
Function CodicePon(Cod: String): Integer;
Var
 i: Integer;
 Trovato: Boolean;
begin
  Result := 0;
  if NPonti <>0 then
  begin
    i := 1;
    Trovato := False;
    while (i <= NPonti) and (not Trovato) do
    begin
      if CompareStr(UpperCase(Cod), UpperCase(Ponti_d^[i].Codice)) = 0 then
         Trovato := True
      else inc(i);
    end;
    if not Trovato then
    begin
      Result := 0;
      Erroregen := True;
      if cod <> '' then
         echo('Il Ponte di codice '+ cod + ' non è stato trovato in archivio')
      else echo('Codice Ponte Termico vuoto');
    end
    else result:=i;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CodiceZona
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: Cod:String
  Result:    Integer

  Cosa fa: Restituisce l'indice dei dati della zona
-----------------------------------------------------------------------------}
Function CodiceZona(Cod:String):Integer;
Var
  i: Integer;
  Trovato: Boolean;
begin
  Result := 0;
  if (NZone <> 0) and (CompareSTR(UpperCase(cod), UpperCase('Non risc')) <> 0) then
  begin
    i := 1;
    Trovato := False;
    while (i <= NZone) and (not Trovato) do
    begin
      if CompareStr(UpperCase(Cod), UpperCase(Zone_d^[i].Cod)) = 0 then
         Trovato := True
      else inc(i);
    end;
    if not Trovato then
    begin
      result := 0;
      Erroregen := true;
      echo('La Zona di codice ' + cod + ' non è stata trovata in archivio');
    end
    else result:=i;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CodiceImpianto
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: Cod:String
  Result:    Integer

  Cosa fa: Restituisce l'indice dei dati dell'impianto
-----------------------------------------------------------------------------}
Function CodiceImpianto(Cod: String): Integer;
Var
 i: Integer;
 Trovato: Boolean;
begin
 Result := 0;
 if CompareStr(UpperCase(Cod), 'NESSUNO') <> 0 then
 begin
  if NImpianti <> 0 then
  begin
    i:=1;
    Trovato := False;
    while (i <= NImpianti) and (not Trovato) do
    begin
      if CompareStr(UpperCase(Cod), UpperCase(Impianto_d^[i].Codice)) = 0 Then
         Trovato := True
      else inc(i);
    end;
    if not Trovato then
    begin
      result := 0;
      Erroregen := True;
      echo('L''impianto di codice '+ cod + ' non è stato trovato in archivio');
    end
    else Result := i;
  end;
 end;
end;

{-----------------------------------------------------------------------------
  Procedure: CodiceZona_D
  Author:    e.diquattro
  Date:      21-nov-2006
  Arguments: DescrZona: String
  Result:    String
  
  Cosa fa:
-----------------------------------------------------------------------------}
function CodiceZona_D(DescrZona: String): String;
var
  i: Integer;
begin
  Result := '';

  For i := 1 to NZone do
  begin
    if CompareStr(UpperCase(Zone_d^[i].Denom), UpperCase(DescrZona)) = 0 then
    begin
      Result := Zone_d^[i].Cod;
      exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: RestituisciClassZona
  Author:    Emanuela
  Date:      31-ago-2004
  Arguments: DescrZona10: String
  Result:    String

  Funzione che restituisce la classificazione della zona
-----------------------------------------------------------------------------}
function RestituisciClassZona(DescrZona10: String): String;
var
  i: Integer;
begin
  Result := '';
  For i := 1 to NZone do
  begin
    if CompareStr(UpperCase(Zone_d^[i].Denom), UpperCase(DescrZona10)) = 0 then
    begin
      Result := Zone_d^[i].Classif;
      exit;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CodiceProfilo
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: Cod: String
  Result:    Integer
  
  Cosa fa: Restituisce l'indice del profilo orario
-----------------------------------------------------------------------------}
Function CodiceProfilo(Cod: String): Integer;
Var
  i: Integer;
  Trovato: Boolean;
begin
  Result := 0;
  if NOrari <> 0 then
  begin
    i := 1;
    Trovato := False;
    while (i <= NOrari) and (not Trovato) do
    begin
      if CompareStr(UpperCase(Cod), UpperCase(Orari_d^[i].Codice)) = 0 then
         Trovato := True
      else inc(i);
    end;
    if not Trovato then
    begin
      result:=0;
      if cod <> '' then
      begin
        Erroregen := True;
        echo('L''andamento orario '+ cod + ' non è stato trovato in archivio');
      end;
    end
    else result:=i;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CercaIndiceZone
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: CodiceZona: String
  Result:    Integer
  
  Cosa fa: Funzione che trova l'indice della tabella della zona cercata
-----------------------------------------------------------------------------}
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

{-----------------------------------------------------------------------------
  Procedure: AltLordaPiano
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: CodPiano: String; Tipo: char
  Result:    real
  
  Cosa fa: Restituisce l'altezza lorda del piano o l'ltezza netta in base alla
           necessità
-----------------------------------------------------------------------------}
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
  Procedure: RestituisciAngoloFalda
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: CodiceConf: String
  Result:    real
  
  Cosa fa: Restituisce l'angolo di inclinazione di una falda
-----------------------------------------------------------------------------}
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

{-----------------------------------------------------------------------------
  Procedure: ConfineInterno
  Author:    e.diquattro
  Date:      20-nov-2006
  Arguments: Cod: String; var TI: Real
  Result:    Boolean
  
  Cosa fa: Restituisce se il confine è di tipo interno
-----------------------------------------------------------------------------}
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

{-----------------------------------------------------------------------------
  Procedure: CreaListaIntPot
  Author:    e.diquattro
  Date:      23-nov-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Creo la lista che conterrà le informazioni per gli ambienti
-----------------------------------------------------------------------------}
Procedure CreaListaIntPot;
begin
  TestaLFIntPot := nil;
  CodaLFIntPot  := nil;
end;

{-----------------------------------------------------------------------------
  Procedure: RicercaLocaleIntPot
  Author:    e.diquattro
  Date:      23-nov-2006
  Arguments: CodAmb: Integer; Amb: RecAmb; TotDsp, VInt, DispInf: Real; CodGen: String
  Result:    None
  
  Cosa fa: Verifico se già l'amniente è stato calcolato, in questo caso
           l'aggiorno, altrimenti nè creo uno nuovo e l'inserisco alla lista
-----------------------------------------------------------------------------}
Procedure RicercaLocaleIntPot(CodAmb: Integer; Amb: RecAmb; TotDsp, VInt, DispInf: Real; CodGen: String);
var
  TempIntPot, NewIntPot: PMyTIntPot;
  Trovato: Boolean;
begin
  TempIntPot := TestaLFIntPot;
  while (TempIntPot <> nil) and (not Trovato) do
  begin
      if TempIntPot.RecIntPot.NumAmb = CodAmb then
         Trovato := True
      else TempIntPot := TempIntPot.Next;
  end;
  if Trovato then
  begin
    TempIntPot.RecIntPot.CodGen := CodGen;
    TempIntPot.RecIntPot.Pot    := TotDsp;
    TempIntPot.RecIntPot.Port   := Amb.RicambioPersona;
    TempIntPot.RecIntPot.Vol    := VInt;
    TempIntPot.RecIntPot.Sup    := Amb.Superficie;
    TempIntPot.RecIntPot.DispInf := TotDsp - DispInf;
  end
  else
  begin
    New(NewIntPot);
    NewIntPot.RecIntPot.NumAmb  := StrToInt(Amb.CodNum);
    NewIntPot.RecIntPot.NomeLoc := Amb.Denom;
    NewIntPot.RecIntPot.Piano   := Amb.Piano;
    NewIntPot.RecIntPot.CodGen  := CodGen;
    NewIntPot.RecIntPot.Pot     := TotDsp;
    NewIntPot.RecIntPot.Port    := Amb.RicambioPersona;
    NewIntPot.RecIntPot.DispInf := TotDsp - DispInf;
    NewIntPot.RecIntPot.Vol     := VInt;
    NewIntPot.RecIntPot.Sup     := Amb.Superficie;
    NewIntPot.Next := nil;
    if TestaLFIntPot = nil then
    begin
     TestaLFIntPot := NewIntPot;
     CodaLFIntPot  := NewIntPot;
    end
    else
    begin
      CodaLFIntPot.Next := NewIntPot;
      CodaLFIntPot      := NewIntPot;
    end;
  end;
end;

{-----------------------------------------------------------------------------
  Procedure: CreaFileIntPot
  Author:    e.diquattro
  Date:      23-nov-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Crea il file che conserverà questi dati
-----------------------------------------------------------------------------}
Procedure CreaFileIntPot(Nomefile: String);
var
  TempIntPot: PMyTIntPot;
begin
  Assign(Fintpot, NomeFile);
  Rewrite(Fintpot);
  TempIntPot := TestaLFIntPot;
  while (TempIntPot <> nil) do
  begin
    bufIntpot.NumAmb  := TempIntPot.RecIntPot.NumAmb;
    bufIntpot.NomeLoc := TempIntPot.RecIntPot.NomeLoc;
    bufIntpot.POt     := TempIntPot.RecIntPot.Pot;
    bufIntpot.DispInf := TempIntPot.RecIntPot.DispInf;
    bufIntpot.Port    := TempIntPot.RecIntPot.Port;
    bufIntpot.Piano   := TempIntPot.RecIntPot.Piano;
    bufIntpot.Vol     := TempIntPot.RecIntPot.Vol;
    bufIntpot.Sup     := TempIntPot.RecIntPot.Sup;
   {$Ifdef L10}
    bufIntpot.CodGen  := TempIntPot.RecIntPot.CodGen;
   {$Else}
    bufIntpot.CodGen  := '';
   {$EndIF}
    Write(Fintpot, Bufintpot);
    TempIntPot := TempIntPot.Next;
  end;
  CloseFile(Fintpot);
  SvuotaListaIntPot;
end;

{-----------------------------------------------------------------------------
  Procedure: SvuotaListaIntPot
  Author:    e.diquattro
  Date:      23-nov-2006
  Arguments: None
  Result:    None
  
  Cosa fa: Svuota la lista e libera l'ho spazio prima di chiudere il calcolo
-----------------------------------------------------------------------------}
Procedure SvuotaListaIntPot;
var
  TempIntPot: PMyTIntPot;
begin
  TempIntPot := TestaLFIntPot;
  while (TempIntPot <> nil) do
  begin
    TestaLFIntPot := TempIntPot.Next;
    Dispose(TempIntPot);
    TempIntPot := TestaLFIntPot;
  end;
  CodaLFIntPot := nil;
end;

end.
