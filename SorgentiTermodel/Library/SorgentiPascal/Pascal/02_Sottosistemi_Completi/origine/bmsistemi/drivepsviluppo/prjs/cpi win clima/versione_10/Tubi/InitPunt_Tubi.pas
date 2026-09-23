unit InitPunt_Tubi;

interface

Uses
  Definiz,varcarichi
  {$Ifdef Versione_14}
  ,Init_Puntatori
  {$Endif}
  ;

  Procedure Iniz_PuntTubi;
  Procedure Dispose_PuntTubi;

implementation

  Procedure Iniz_PuntTubi;
  var
    i: Integer;
  begin
   New(GENERALITA_D1);
  {$Ifdef Versione_14}
  InitPuntatori;
  {$else}
   New(Tubaz_D);
   New(MatTubaz_D);
   New(Perd_D);
   New(TipiRete_D);
   New(TipoTerminali_D);
   New(PerdConc_D);
   New(Entita_d);
    {$IFDEF CANALI}
     New(Update_d);
    {$ENDIF}
  {$Endif}
   New(contorno);
   for i:=1 to Maxcontorno do contorno^[i]:=nil;
   Ncontorno:=0;
   New(Dis);
   new(quote);
   For i:=0 to lungdis do dis^[i] := nil;
   ultriga:=0;
   New(Dati);
   For i:=0 to lungdati do dati^[i] := nil;
   ulttronco:=0;
   New(Gterm);
   For i:=1 to MaxGterm do Gterm^[i] := nil;
   NGterm:=0;
   New(EffUtilT);
   For i:=1 to MaxGterm do EffUtilT^[i] := nil;
   NGEffTUtil:=0;
   New(Fgtb);
   For i:=1 to MaxGterm do Fgtb^[i] := nil;
   New(RisultCalc);
   New(el_unita);
   new(datisot);
   new(vprog);
   new(dati2);
   new(Blocchi);
   For i:=1 to LungBlocchi do Blocchi^[i] := nil;
   UltBlocco := 0;
   new(Piani_d);
   For i:=1 to  Maxlnfr do ar_ftht[i] := nil;
   TabFtht:=nil;
  end;

  Procedure Dispose_PuntTubi;
  var
    i: Integer;
  begin
   For i:=1 to lungdis do
      if dis^[i]<>nil then dispose(dis^[i]);
   Dispose(Dis);
   For i:=1 to lungdati do
    if dati^[i]<>nil then dispose(dati^[i]);
   Dispose(Dati);
   For i:=1 to Maxgterm do
      if Gterm^[i]<>nil then dispose(Gterm^[i]);
   Dispose(Gterm);
   For i:=1 to MaxGterm do
      if EffUtilT^[i] <> nil then dispose(EffUtilT^[i]);
   Dispose(EffUtilT);
   For i:=1 to Maxgterm do
      if Fgtb^[i] <>nil then dispose(Fgtb^[i] );
   Dispose(Fgtb);
   For i:=1 to lungBlocchi do
       if Blocchi^[i]<>nil then dispose(Blocchi^[i]);
   Dispose(Blocchi);
   Dispose(GENERALITA_D1);
   Dispose(Tubaz_D);
   Dispose(MatTubaz_D);
   Dispose(Perd_D);
   Dispose(TipiRete_D);
   Dispose(TipoTerminali_D);
   Dispose(PerdConc_D);
   Dispose(quote);
  {$IFDEF CANALI}
   Dispose(Update_d);
  {$ENDIF}
   Dispose(Piani_d);
   Dispose(RisultCalc);
   Dispose(el_unita);
   Dispose(datisot);
   Dispose(vprog);
   Dispose(dati2);
  end;

end.
