unit UStatistica;

interface

uses Chart, Series, Graphics, Libreriagenerale;

Procedure CloseStatistica;
Procedure InitStatistica;
Procedure DisplayStatistica(Var Serie: TPieSeries; Chart: TChart);
Procedure ADDStatistica(Nome:string; Valore:real);
Procedure ResetStatistica;
Procedure AzzeraVoci;

implementation

Const NReCVoci = 50;

Const ColPie:array[0..15] of Tcolor = (clBlue, clGreen, clRed, clAqua, clBlack,
                                         clDkGray, clFuchsia, clGray, clLime,
                                         clLtGray, clMaroon, clNavy, clOlive,
                                         clPurple, clSilver, clTeal);

Type
  TRecVociDisp = record
                  Descrizione: String[50];
                  Dispersioni: Double;
                 end;
  TArVoci = Array [1..NRecVoci] of TRecVociDisp;

  Var Voci_d: TArVoci;
  Var VociStat: integer;

  Procedure InitStatistica;
  Var
    i: Integer;
  begin
   For i := 1 to NRecVoci do
   begin
    Voci_D[i].Descrizione := '';
    Voci_D[i].Dispersioni := 0;
   end;
   Vocistat:=0;
  end;

  Procedure ResetStatistica;
  begin
   VociStat:=0;
  end;

  Procedure CloseStatistica;
  begin
    VociStat := 0;
  end;

  Procedure  ADDStatistica(Nome:String; Valore: Real);
  Var
    Trovato: Boolean;
    i: Integer;
  begin
   trovato:=false;
   if Vocistat <> 0 then
   begin
    i:=1;
    while (i < vocistat) and (Upstring(Nome) <> Upstring(Voci_D[i].Descrizione)) do inc(i);
    If Upstring(Nome)=Upstring(Voci_D[i].Descrizione) then
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
  end;

  Procedure DisplayStatistica(Var serie:TPieSeries; chart:tchart);
  Var
    i:integer;
    totale:real;
    totstr:string;
  begin
    totale:=0;
    for i:=1 to vocistat do totale:=totale+Voci_D[i].DIspersioni;
    str(totale:6:0,totstr);
    Chart.Title.Text.Clear;
    Chart.Title.Text.Add('Calcolo delle dispersioni');
    Chart.Title.Text.Add(totstr + ' [W]');
    if serie <> nil then serie.Clear;
    if totale <>0 then
    for i:=1 to vocistat do
        serie.Add(round(Voci_D[i].DIspersioni/totale*100), Voci_D[i].Descrizione, colPIe[(i-1) mod 16])
  end;

  Procedure AzzeraVoci;
  var
    i: Integer;
  begin
   if VociStat <> 0 then
   begin
    for i:=1 to vocistat do
    begin
      Voci_D[i].DIspersioni := 0;
      Voci_D[i].Descrizione := '';
    end;
    ResetStatistica;
   end;
  end;

end.
