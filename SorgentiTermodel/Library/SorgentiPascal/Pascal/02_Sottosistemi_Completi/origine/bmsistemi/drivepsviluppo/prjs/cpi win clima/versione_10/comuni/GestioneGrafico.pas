unit GestioneGrafico;

interface

uses SysUtils, Math, Chart, Series, Graphics, Libreriagenerale, Varcarichi;

Const NReCVoci = 50;
     {$IFDEF VERSIONE_13}
      NRecGen = 50;
     {$ENDIF}
      ColPie:array[0..21] of Tcolor = (clRed,
                                       clGreen,
                                       clYellow,
                                       clBlue,
                                       clWhite,
                                       clGray,
                                       clAqua,
                                       clBlack,
                                       clDkGray,
                                       clFuchsia,
                                       clLime,
                                       clLtGray,
                                       clMaroon,
                                       clNavy,
                                       clOlive,
                                       clPurple,
                                       clSilver,
                                       clTeal,
                                       clMoneyGreen,
                                       clSkyBlue,
                                       clCream,
                                       clMedGray);

Type
  TRecVociDisp = record
                  Descrizione: String[50];
                  Dispersioni: Double;
                 end;
 {$IFDEF VERSIONE_12}
   TArVoci = Array [1..NRecVoci] of TRecVociDisp;
 {$ELSE}
   TArVoci = Array [1..NRecGen, 1..NRecVoci] of TRecVociDisp;
 {$ENDIF}
  Procedure InitStatistica;
  Procedure ResetStatistica;
  Procedure CloseStatistica;
  Procedure ADDStatistica(Nome:String; Valore: Real);
  Procedure DisplayStatistica(Var serie:TBarSeries; chart:tchart);
  Procedure AzzeraVoci;
  Procedure OrdinaVoci(var Voci_DT: Array of TRecVociDisp; Num: Integer);
{$Ifdef Versione_14}
Procedure Salva_statistica(Nomefile,titolo,unita:string;cancella:boolean);
{$Else}
{$Endif}

  Var Voci_d: TArVoci;
  Var VociStat: integer;

implementation
{$Ifdef Versione_14}
{$Else}
uses UFormL10;
{$Endif}

{-----------------------------------------------------------------------------
  Procedure: InitStatistica
  Author:    e.diquattro
  Date:      09-nov-2005
  Arguments: None
  Result:    None
  
  Cosa fa: inizializza l'array che conterrà le voci
-----------------------------------------------------------------------------}
  Procedure InitStatistica;
  Var
    i, j: Integer;
  begin
  {$IFDEF VERSIONE_12}
   For i := 1 to NRecVoci do
   begin
    Voci_D[i].Descrizione := '';
    Voci_D[i].Dispersioni := 0;
   end;
  {$ELSE}
   For i := 1 to NRecGen do
    For j := 1 to NRecVoci do
    begin
      Voci_D[i, j].Descrizione := '';
      Voci_D[i, j].Dispersioni := 0;
    end;
  {$ENDIF}
   Vocistat:=0;
  end;

{-----------------------------------------------------------------------------
  Procedure: ResetStatistica
  Author:    e.diquattro
  Date:      09-nov-2005
  Arguments: None
  Result:    None
  
  Cosa fa:  pone il numeto delle voci del grafico a zero
-----------------------------------------------------------------------------}
  Procedure ResetStatistica;
  begin
   VociStat:=0;
  end;

{-----------------------------------------------------------------------------
  Procedure: CloseStatistica
  Author:    e.diquattro
  Date:      09-nov-2005
  Arguments: None
  Result:    None
  
  Cosa fa: pone le voci del grafico uguali a zero
-----------------------------------------------------------------------------}

  Procedure CloseStatistica;
  begin
    VociStat := 0;
  end;

{-----------------------------------------------------------------------------
  Procedure: ADDStatistica
  Author:    e.diquattro
  Date:      09-nov-2005
  Arguments: Nome:String; Valore: Real
  Result:    None
  
  Cosa fa: aggiunge le vari voci delle dispersioni all'array
-----------------------------------------------------------------------------}

  Procedure ADDStatistica(Nome:String; Valore: Real);
  Var
    Trovato: Boolean;
    i: Integer;
  begin
   trovato:=false;
  {$IFDEF VERSIONE_12}
   if Vocistat <> 0 then
   begin
    i:=1;
    while (i < vocistat) and (UpperCase(Nome) <> UpperCase(Voci_D[i].Descrizione)) do inc(i);
    If UpperCase(Nome)=UpperCase(Voci_D[i].Descrizione) then
    begin
      Trovato:=true;
      if (Valore > 0) and (Voci_D[i].Descrizione <> 'Ventilazione') then
         Voci_D[i].DIspersioni := Voci_D[i].DIspersioni + abs(Valore);
    end;
   end;
   if not trovato then
   begin
      if (Valore > 0) and (Nome <> 'Ventilazione') then
      begin
       inc(vocistat);
       Voci_D[Vocistat].Descrizione := Nome;
       Voci_D[Vocistat].DIspersioni := abs(Valore);
      end;
   end;
  {$ELSE}
   if (Vocistat <> 0) and (Gencor <> 0) then
   begin
    i:=1;
    while (i < vocistat) and (UpperCase(Nome) <> UpperCase(Voci_D[Gencor,i].Descrizione)) do inc(i);
    If UpperCase(Nome)=UpperCase(Voci_D[Gencor,i].Descrizione) then
    begin
      Trovato:=true;
      if (Valore > 0) and (Voci_D[Gencor,i].Descrizione <> 'Ventilazione') then
         Voci_D[Gencor,i].DIspersioni := Voci_D[Gencor,i].DIspersioni + abs(Valore);
    end;
   end;
   if not trovato then
   begin
      if (Valore > 0) and (Nome <> 'Ventilazione') then
      begin
       inc(vocistat);
       Voci_D[Gencor, Vocistat].Descrizione := Nome;
       Voci_D[Gencor, Vocistat].DIspersioni := abs(Valore);
      end;
   end;
  {$ENDIF}
  end;

{-----------------------------------------------------------------------------
  Procedure: DisplayStatistica
  Author:    e.diquattro
  Date:      09-nov-2005
  Arguments: Var serie:TBarSeries; chart:tchart
  Result:    None

  Cosa fa: aggiunge le voci al grafico
-----------------------------------------------------------------------------}
{$Ifdef Versione_14}
  Var salvaStat:boolean=false;
      CancStat:boolean=true;
      Fstat:textfile;
{$Else}
{$Endif}

  Procedure DisplayStatistica(Var serie:TBarSeries; chart:tchart);
  Var
    i, NumVoci, j:integer;
    totale:real;
    totstr:string;
    Voci_dTemp: Array [1..NRecVoci] of TRecVociDisp;
    Trovato: Boolean;
  begin

    totale:=0;
    for i:=1 to NReCVoci do
    begin
        Voci_dTemp[i].DIspersioni := 0;
        Voci_dTemp[i].Descrizione := '';
    end;
    {$IFDEF VERSIONE_12}
    for i:=1 to vocistat do totale:=totale+Voci_D[i].DIspersioni;
    totstr := Format('%1.0F', [totale]);
    //str(totale:6:0,totstr);

    Chart.Title.Text.Clear;
    Chart.Title.Text.Add('ANDAMENTO DELLE DISPERSIONI');
    Chart.Title.Text.Add(totstr + ' [W]');
    if serie <> nil then serie.Clear;
    // Verifico se esistono voci von lo stesso valore le accorpo
    NumVoci := 0;
    j := 0;
    for i := 1 to vociStat do
    begin
      if CompareValue(roundto((Voci_D[i].Dispersioni/totale*100), -2), 1, 0.01) > 0 then
      begin
        inc(NumVoci);
        Voci_dTemp[NumVoci] := Voci_D[i];
      end
      else inc(j);
    end;
    {$Ifdef Versione_14}
    
    {$Else}
    if j <> 0 then
       FcalcL10.LB_frase.Caption := 'Le strutture non presenti nel grafico influiscono sulle dispersione per una percentuale inferione al 1%'
    else FcalcL10.LB_frase.Caption := '';
    {$Endif}
    OrdinaVoci(Voci_dTemp, NumVoci);
    if totale <> 0 then
       for i:=1 to NumVoci do
        serie.Add(roundTo((Voci_dTemp[i].DIspersioni/totale*100), -2), Voci_dTemp[i].Descrizione, colPIe[(i-1) mod 20]);
    for i:=1 to NumVoci do
    begin
      Voci_dTemp[i].DIspersioni := 0;
      Voci_dTemp[i].Descrizione := '';
    end;
   {$ELSE}
    for i:=1 to NRecVoci do
    begin
      Voci_dTemp[i].DIspersioni := 0;
      Voci_dTemp[i].Descrizione := '';
    end;
    for i:=1 to vocistat do
        totale:=totale+Voci_D[Gencor, i].DIspersioni;
    totstr := Format('%1.0F', [totale]);
    //str(totale:6:0,totstr);
    Chart.Title.Text.Clear;
    Chart.Title.Text.Add('ANDAMENTO DELLE DISPERSIONI');
    Chart.Title.Text.Add(totstr + ' [W]');
    if serie <> nil then serie.Clear;
    // Verifico se esistono voci con lo stesso valore le accorpo
    NumVoci := 0;
    j := 0;
    for i := 1 to vociStat do
    begin
     if Totale <> 0 then
     begin
      if CompareValue(roundto((Voci_D[Gencor, i].Dispersioni/totale*100), -2), 1, 0.01) > 0 then
      begin
        inc(NumVoci);
        Voci_dTemp[NumVoci] := Voci_D[Gencor, i];
      end
      else inc(j);
     end else j := vociStat + 1;
    end;
    {$Ifdef Versione_14}

    {$Else}
    if j <> 0 then
       FcalcL10.LB_frase.Caption := 'Le strutture non presenti nel grafico influiscono sulle dispersione per una percentuale inferione al 1%'
    else FcalcL10.LB_frase.Caption := '';
    {$Endif}

    OrdinaVoci(Voci_dTemp, NumVoci);
    if totale <> 0 then
       for i:=1 to NumVoci do
        begin
        serie.Add(roundTo((Voci_dTemp[i].DIspersioni/totale*100), -2), Voci_dTemp[i].Descrizione, colPIe[(i-1) mod 20]);
        {$Ifdef Versione_14}
        if salvastat then
          begin
          writeln(Fstat,float_tostr(roundTo((Voci_dTemp[i].DIspersioni/totale*100), -2)));
          writeln(Fstat,Voci_dTemp[i].Descrizione);
          end
         end;
    if cancstat then
        {$Else}
         end;
        {$Endif}
    for i:=1 to NumVoci do
    begin
      Voci_dTemp[i].DIspersioni := 0;
      Voci_dTemp[i].Descrizione := '';
    end;
   {$ENDIF}

end;
{$Ifdef Versione_14}
Procedure Salva_statistica(Nomefile,titolo,unita:string;cancella:boolean);
Var serie:TBarSeries; chart:tchart ;
begin
cancstat:=cancella;
serie:=TBarSeries.Create(nil);
chart:=tchart.Create(Nil) ;
assign(fstat,Nomefile);
rewrite(fstat);
writeln(Fstat,titolo);
writeln(Fstat,unita);
salvastat:=true;
DisplayStatistica(serie,chart);
salvastat:=false;
Close(Fstat);
serie.Free;
chart.Free;
cancstat:=true;
end;
{$Else}
{$Endif}

{-----------------------------------------------------------------------------
  Procedure: OrdinaVoci
  Author:    e.diquattro
  Date:      06-dic-2005
  Arguments: var Voci_DT:TArVoci; Num: Integer
  Result:    None

  Cosa fa:
-----------------------------------------------------------------------------}
  Procedure OrdinaVoci(var Voci_DT: Array of TRecVociDisp; Num: Integer);
  var
   i, j: Integer;
   Temp: TRecVociDisp;
  begin
   for i := 1 to Num - 1 do
   begin
     for j := i+1 to Num do
       if Voci_DT[i].Dispersioni < Voci_DT[j].Dispersioni then
       begin
         temp := Voci_DT[j];
         Voci_DT[j] := Voci_DT[i];
         Voci_DT[i] := Temp;
       end;
   end;
  end;

{-----------------------------------------------------------------------------
  Procedure: AzzeraVoci
  Author:    e.diquattro
  Date:      09-nov-2005
  Arguments: None
  Result:    None
  
  Cosa fa: azzera le varie voci
-----------------------------------------------------------------------------}
  Procedure AzzeraVoci;
  var
    i, j: Integer;
  begin
  {$IFDEF VERSIONE_12}
    for i:=1 to NReCVoci do
    begin
      Voci_D[i].DIspersioni := 0;
      Voci_D[i].Descrizione := '';
    end;
    ResetStatistica;
  {$ELSE}
   For i:= 1 to NRecGen do
    For j := 1 to NReCVoci do
    begin
      Voci_D[i, j].DIspersioni := 0;
      Voci_D[i, j].Descrizione := '';
    end;
    ResetStatistica;
  {$ENDIF}
  end;

end.
