unit STAMPA4;

Interface

uses {crt,
     dos,
     printer,
     print,
     defuti,
     utilitie,}
     {tubivar}definiz,varcarichi,
     iotubi,
     {wp,}
     load,
     UUtigen, LibreriaGenerale;

procedure computo(Indicescelte : integer);

Implementation

{********** OPZIONE DI STAMPA 4 =>  COMPUTO METRICO *********************}

Procedure RicercaD(Indice,IndCalc : integer;VAR IndiceSez : integer);
var j  : integer;
    Tr : boolean;

begin
  tr := false;
  j := 1;
  while ( not(tr) ) and (j <= maxsez) do
  begin
    if (Dati^[IndCalc]^.CodDiam = '' ) then
    begin

      {gotoxy(8,7);}
      write(w_m(1),' ',Dati^[IndCalc]^.Num ,w_m(2));    { Il Tronco N. /..../non ha codice diametro }
      halt;
    end;
    if UpString(Tubaz_D^[Indice].Sez[j].Dnom) =  UpString(Dati^[IndCalc]^.CodDiam)
    then tr := true
    else j := j+1;
  end;
  if Tr then IndiceSez := j
  else IndiceSez := 0;
end;

{**************************** InitTubiUsati *******************************}

Procedure InitTubiUsati;
var i,j  : integer;

begin
  for i := 1 to MaxTubaz do
  begin
    TubiTu[i].flag := cno;
    for j :=1 to maxsez do TubiTu[i].Dnum[j] := '';
  end;
end;

{**************************** CaricaTubiUsati *******************************}

Procedure CaricaTubiUsati;
var h,i,k,Indice : integer;
    Tr           : boolean;

begin
  for h := 1 to maxtubaz do tubus[h] := 0;
  Indice := 0;
  h := 0;
  repeat
    h := h+1;
    if (dati^[h]^.Ti <> 0)  then
    begin
      if (dati^[h]^.Tipo <> '') then
      begin
        i := 1;
        while( (UpString(dati^[h]^.Tipo) <> UpString(Tubaz_D^[i].Cod) ) and (i< maxTubaz) )do
        begin
          i := i+1;
        end;
        if ( UpString(dati^[h]^.Tipo) = UpString(Tubaz_D^[i].Cod) )then
        begin
          TubiTu[i].flag := cyes;
          ricercaD(i,h,Indice);
          k := 0;
          Tr := false;
          repeat
            k := k+1;
            if  (Tubaz_D^[i].Sez[Indice].DNom = TubiTu[i].Dnum[k] ) OR
            (TubiTu[i].DNum[k] = '') then
            begin
              Tr := True;
              if (TubiTu[i].DNum[k] = '') then TubiTu[i].DNum[k] := Tubaz_D^[i].Sez[Indice].DNom ;
            end;
          until Tr or (k = maxSez);
        end;
      end;
    end;
  until h = UltTronco;
  i := 0;
  for h := 1 to maxtubaz do
  begin
    if (tubiTu[h].flag = cyes) then
    begin
      i := i+1;
      tubus[i] := h;
    end;
  end;
end;

{**************************** TrovaTubiUsati *******************************}

procedure TrovaTubiUsati;
var ok,FineSot : boolean;
    jj,ii      : integer;

begin
  InitTubiUsati;
  retePrinc := false;
  FineSot := false;
  Repeat
    if RetePrinc then
    begin
      ok := false;
      ExistSottorete(numeroprog1,ok);
      if ok then
      begin
        for jj := 1 to maxsot do
        begin
          for ii := 1 to rit do
          begin
            manrip:=(ii=1);
            LoadDis(driveprog+vprog^[jj].Nome);
            CaricaTubiUsati;
          end;
        end;
      end;
      FineSot := True;
    end
    else
    begin
      for ii := 1 to rit do
      begin
        manrip:=(ii=1);
        LoadDis(NumeroProg);
        CaricaTubiUsati;
      end;
      RetePrinc := True;
    end;
  Until FineSot;
end;

{**************************** InitCOMPUTO *******************************}

Procedure InitComputo;
var i,j  : integer;
begin
  for i := 1 to maxtubaz do
  begin
    for j := 1 to (maxsez+1) do
    begin
      Com_M^[i].Descrizione := '';
      with Com_M^[i].DatiComp[j] do
      begin
        diametro   := '';
        lunghezza  := 0;
        peso       := 0;
        Area       := 0;
        Volume     := 0;
        PesoH2O    := 0;
      end;
    end;
  end;
end;

{**************************** TrovaDiametroL ******************************}

function TrovadiametroL(Codice:st8;indice :integer) :integer;
var i : integer;
    Tr: boolean;
begin
  Tr:= false;
  i := 0;
  repeat
    i := i+1;
    if (Tubaz_D^[indice].Sez[i].DNom = codice) then tr := true;
  until Tr or (i = maxsez);
  if Tr then TrovadiametroL := i
  else TrovaDiametroL := 0;
end;

{**************************** CaricaCOMPUTO *****************************}

procedure CaricaComputo(i,k: integer);

{.. i => indica il tipo di tubo utilizzato
    j => indice di calcolo1 dove si trovano i dati di stampa reletivi ai tubi
    k => indice del record per la stampa del computo metrico
    k1=> indice  "    "         "          "           "                    ..}

var
    j,Moltiplicatore,Dim,k1              : integer;
    DInterno,Spessore,Dtotale,Superficie : real;

{**************************** CaricaParziali *****************************}

procedure CaricaParziali(i1,dim1,IndComp:integer);
begin
  Dinterno :=(Tubaz_D^[i].Sez[Dim1].Dint)*0.001;{m}
  Spessore :=(Tubaz_D^[i].Sez[Dim1].Spes)*0.001;{m}

  {diametro totale}

  Dtotale    := Dinterno+(Spessore*2);{m}
  Superficie := ((SQR(Dtotale/2)*pi) - ( SQR(Dinterno/2)*pi));{m^2}

  With Com_M^[k].DatiComp[IndComp] do
  begin
    Area   := (DTotale/2) * 2 *pi  * Com_M^[k].DatiComp[IndComp].Lunghezza;{m^2}
    Volume := SQR(DInterno/2) * pi * Com_M^[k].DatiComp[IndComp].Lunghezza* 1000 ; {dm^3}
    Peso   := Superficie * Com_M^[k].DatiComp[IndComp].Lunghezza * Tubaz_D^[i].Dens; {kg}
    PesoH2O:= SQR(DInterno/2) * pi * Com_M^[k].DatiComp[IndComp].Lunghezza * FluM_D^.Dens;{kg}
  end;
end;

{*********************** Inizio di CaricaCOMPUTO **************************}

begin
  generalita_D^.ritorno := UpString(Generalita_D^.RITORNO);
  if (Generalita_D^.RITORNO = cyes) and (rit=1) then Moltiplicatore := 2
  else Moltiplicatore := 1;
  k1 := 0;
  repeat
    K1 := K1+1;
    if TubiTu[i].DNum[k1] > '' then
    begin
      dim := TrovaDiametroL(TubiTu[i].DNum[k1],i);
      j := 0;
      repeat
        j :=j+1;
        if dati^[j]^.Ti <> 0 then
        begin
          if ( UpString(Dati^[j]^.Tipo) =  UpString(Tubaz_D^[i].Cod) )  then
          begin
            if ( UPSTRING(TubiTu[i].DNum[k1]) = UPSTRING(dati^[j]^.CodDiam) )then
            begin

(*              {diametro interno}

              DInterno :=(Tubaz_D^[i].Sez[dim].DInt)* 0.001;{m}
              Spessore :=(Tubaz_D^[i].Sez[dim].Spes)* 0.001;{m}

              diametro totale}

              DTotale   := DInterno+(Spessore*2) ;{m}
              Superficie:= (  ( SQR(DTotale/2) * pi ) - ( SQR(DInterno/2) * pi ) );{m^2}   *)
              with Com_M^[k].DatiComp[k1] do
              begin
                Diametro := Dati^[j]^.CodDiam;
                Lunghezza:= Lunghezza + Dati^[j]^.Lungh * Moltiplicatore;{m}
              end;
            end;
          end;
        end;
      until j = ulttronco;
      CaricaParziali(i,dim,k1);
    end;
  until  (TubiTu[i].Dnum[k1] ='') or (k1 = maxsez);
end;

{*************************** CaricaTotali **********************************}

procedure caricatotali(i,k : integer);
var ji : integer;

{Calcolo dei Totali del computo relativo al tubo k }
begin
  ji := 0;
  repeat

    {Attenzione !!! all` indice (MaxSez+1) sono contenute le somme dei parziali del computo metrico }

    ji := ji+1;
    Com_M^[k].DatiComp[MaxSez+1].Diametro := '';
    Com_M^[k].DatiComp[MaxSez+1].Lunghezza:= Com_M^[k].DatiComp[ji].Lunghezza+ Com_M^[k].DatiComp[MaxSez+1].Lunghezza;
    Com_M^[k].DatiComp[MaxSez+1].Area     := Com_M^[k].DatiComp[ji].Area     + Com_M^[k].DatiComp[MaxSez+1].Area;
    Com_M^[k].DatiComp[MaxSez+1].Volume   := Com_M^[k].DatiComp[ji].Volume   + Com_M^[k].DatiComp[MaxSez+1].Volume;
    Com_M^[k].DatiComp[MaxSez+1].Peso     := Com_M^[k].DatiComp[ji].Peso     + Com_M^[k].DatiComp[MaxSez+1].Peso;
    Com_M^[k].DatiComp[MaxSez+1].PesoH2O  := Com_M^[k].DatiComp[ji].PesoH2O  + Com_M^[k].DatiComp[MaxSez+1].PesoH2O;
  until (TubiTu[i].Dnum[ji] ='') or (ji = maxsez);
end;

{ ************************* MainCaricaComputo *************************** }

procedure MainCaricaComputo;
{.. IndComputo_M    => indice del record per la stampa del computo metrico
    IndComputo_M1   => indice  "    "         "          "           "
    IndiceTubi      => indica il tipo di tubo utilizzato                  ..}

var FineSot,ok                                 : boolean;
    jj,IndiceTubi,IndComputo_M,IndComputo_M1,ii: integer;

begin
  InitComputo;
  IndiceTubi := 0;
  IndComputo_M := 0;
  repeat
    retePrinc := false;
    FineSot := false;
    IndiceTubi := IndiceTubi+1;
    IndComputo_M := IndComputo_M+1;
    IndComputo_M1:= 0;
    if Tubus[IndiceTubi] >0  then
    begin
      Com_M^[IndComputo_M].Descrizione := Tubaz_D^[Tubus[IndiceTubi]].Descr;
      Repeat
        if RetePrinc then
        begin
          ok := false;
          ExistSottorete(numeroprog1,ok);
          if ok then
          begin
            for jj := 1 to maxsot do
            begin
              for ii:=1 to rit do
              begin
                manrip:=(ii=1);
                LoadDis(driveprog+vprog^[jj].Nome);
                if UltTronco > 1 then
                CaricaComputo(Tubus[IndiceTubi],IndComputo_M);
              end;
            end;
          end;
          FineSot := True;
        end
        else
        begin
          for ii:=1 to rit do
          begin
            manrip:=(ii=1);
            LoadDis(NumeroProg);
            CaricaComputo(tubus[IndiceTubi],IndComputo_M);
          end;
          RetePrinc := True;
        end;
      Until FineSot;
      caricatotali(tubus[IndiceTubi],IndComputo_M);
    end;
  until (IndiceTubi = maxtubaz) OR (Tubus[IndiceTubi] = 0);
end;

{**************************** UltimoDiametro ******************************}

function UltimoDiametro(It : integer) : integer;
var i  : integer;

begin
  i := Maxsez;
  while ( (i >1 ) and (Com_M^[it].DatiComp[i].Diametro = '') ) do i := i-1;
  UltimoDiametro := i;
end;

{***************************  StampaTitolo4 *******************************}

Procedure StampaTitolo4;
begin
  WriteTesto('Titolo4.prn');
  nrighe := nrighe+LungTXT('Titolo4.prn');
end;

{**************************** StampaTipoTubo ******************************}

procedure  StampaTipoTubo(Indice : integer);
 var descr : st55;
begin
  descr := Com_M^[indice].Descrizione;
{***  StampaMask(SEG(descr),OFS(descr),'descr.prn',true);}
  nrighe := nrighe+lungTXT('descr.prn');
end;

{**************************** StampaParzIn ********************************}

procedure StampaParzIn;
var fluido : st8;
begin
  Fluido := UpString(Flum_D^.Cod);
{***  StampaMask(SEG(Fluido),OFS(Fluido),'CompIn.prn',true);}
  nrighe := nrighe+LungTXT('CompIn.prn');
end;

{**************************** StampaParziali ******************************}

procedure StampaParziali(Indice,Ult : integer);
var k1   : integer;

begin
  k1 := 0;
  repeat
    k1 := k1+1;
{***    StampaMask(SEG(Com_M^[indice].DatiComp[k1]),OFS(Com_M^[indice].DatiComp[k1]),'Computo.prn',true);}
    nrighe := nrighe+1;
  until (k1 = Ult);
end;

{**************************** StampaParzFin *******************************}

procedure StampaParzFin;
begin
  WriteTesto('compFin.prn');
  nrighe := nrighe+LungTXT('CompFin.prn');
end;

{**************************** StampaTotali ********************************}

procedure stampatotali(Indice : integer);
begin
{***  StampaMask(SEG(Com_M^[indice].DatiComp[maxsez+1]),OFS(Com_M^[indice].DatiComp[maxsez+1]),'Computo.prn',true);}
  nrighe := nrighe+1;
end;

{**************************** Procedi **************************************}

procedure Procedi(ind,UltimoD : integer);
begin
   StampaTipoTubo(ind);
   StampaParzIn;
   StampaParziali(ind,UltimoD);
   StampaParzFin;
   StampaTotali(ind);
end;

{**************************** StampaDati4 **********************************}

procedure StampaDati4;
var Ult,UltD,k,TotRighePag  : integer;

{**************************** UltimoTubo **********************************}

function UltimoTubo : integer;
var i  : integer;

begin
  i := MaxTubaz;
  while ( (i >1 ) and (Com_M^[i].Descrizione = '') ) do i := i-1;
  UltimoTubo := i;
end;

{************************* Main of StampaDati4 *****************************}

begin
  Ult := UltimoTubo;
  k := 0;
  repeat
    k := k+1;
    UltD := UltimoDiametro(k);
    TotRighePag :=nrighe+LungTxt('descr.prn')+LungTXT('CompIn.prn')+LungTXT('CompFin.prn')+UltD + 1;
    If TotRighePag <= MaxRighe then Procedi(k,UltD)
    else
    begin
      AltraPagina(NumPag,nrighe);
      procedi(k,UltD);
    end;
  until k = Ult;
end;

{**************************** StampaCOMPUTO *******************************}

procedure StampaComputo;
begin

  StampaTitolo4;

  StampaDati4;

end;


{**************************** InitRaccordi ******************************}

Procedure InitRaccordi;
var i : integer;
begin
  for i := 1 to MaxRacc do
  begin
    With Comp_Racc^[i] do
    begin
      CodD   := '';
      CodR   := '';
      NPezzi := 0;
    end;
  end;
end;

{*****************************  Carica  ************************************}

Procedure Carica(Ind : integer; VAR Ult : integer);

{***************************  UltZero  *************************************}

Procedure UltZero;
var  esci : boolean;

begin
  esci := false;
  repeat
    Ult := Ult+1;
    if (Dati^[Ind]^.PConc[Ult].Cod = '') then
    begin
      Ult :=Ult-1;
      esci := true;
    end
    else
    begin
      With Comp_Racc^[Ult] do
      begin
        CodD   := UPSTRING(Dati^[Ind]^.CodDiam);
        CodR   := UpString(Dati^[Ind]^.PConc[Ult].Cod);
        NPezzi := Dati^[Ind]^.PConc[Ult].N;
      end;
    end;
  until esci OR (Ult =5);
end;

{***************************  Ricerca *************************************}

procedure Ricerca;
var  i,j     : integer;
     trovato : boolean;

begin
  j := 0;
  repeat
    j := j+1;
    i := 0;
    repeat
      i := i+1;
      Trovato := false;
      if ( UPSTRING(Dati^[Ind]^.CodDiam) = UPSTRING(Comp_Racc^[i].CodD) ) AND
      (  ( UPSTRING(Dati^[Ind]^.PConc[j].Cod) = UPSTRING(Comp_Racc^[i].CodR) ) AND
      ( Dati^[Ind]^.PConc[j].Cod >'' )    )then
      begin
        Comp_Racc^[i].NPezzi := Comp_Racc^[i].NPezzi + Dati^[Ind]^.PConc[j].N;
        Trovato := True;
      end;
    until (i = Ult) OR Trovato;
    if (Not Trovato ) AND ( Dati^[Ind]^.PConc[j].Cod >'' ) then
    begin
      Ult := Ult+1;
      if ult > maxRacc then
       ult:=ult+0;
      With Comp_Racc^[Ult] do
      begin
        CodD   := UPSTRING(Dati^[Ind]^.CodDiam);
        CodR   := UpString(Dati^[Ind]^.PConc[j].Cod);
        NPezzi := Dati^[Ind]^.PConc[j].N;
      end;
    end;
  until j = 5;
end;

{------------------------------ main of Carica ---------------------------}

begin
 if Ult = 0 then UltZero
 else Ricerca;
end;

{**************************** CaricaRaccordi ****************************}

procedure CaricaRaccordi(Var UltRaccordo : integer);
var i,vv   : integer;

{ i => indice di calcrec}

begin
  i :=0;
  repeat
    i := i+1;

    { .. verifico se il tronco ha raccordi o perdite .. }

    if (dati^[i]^.ti <> 0 ) AND (dati^[i]^.PConc[1].cod <> '') then
    begin
      carica(I,UltRaccordo);
    end;
  until i=UltTronco;
end;

{ *************************** MainCaricaRaccordi ************************** }

procedure MainCaricaRaccordi(VAR UltimoRaccordo : integer;VAR Continua : boolean);

var FineSot,ok                                 : boolean;
    jj,ii                                      : integer;

begin
  InitRaccordi;
  retePrinc := false;
  FineSot := false;
  Repeat
    if RetePrinc then
    begin
      ok := false;
      ExistSottorete(numeroprog1,ok);
      if ok then
      begin
        for jj := 1 to maxsot do
        begin
          for ii:=1 to rit do
          begin
            manrip:=(ii=1);
            LoadDis(driveprog+vprog^[jj].Nome);
            if UltTronco > 1 then  CaricaRaccordi(UltimoRaccordo);
          end;
        end;
      end;
      FineSot := True;
    end
    else
    begin
      for ii:=1 to rit do
      begin
        manrip:=(ii=1);
        LoadDis(NumeroProg);
        CaricaRaccordi(UltimoRaccordo);
      end;
      RetePrinc := True;
    end;
  Until FineSot;
  if Comp_Racc^[1].CodD = '' then continua := false
  else Continua := true;
end;

{ ***************************** InitRacc1 ********************************* }

procedure InitRacc1;
var i : integer;
begin
  for i := 1 to MaxRacc do
  begin
    With Comp_R1^[i] do
    begin
      Codcm   :='';
      CodD1   := '';
      descrR  := '';
      NPezzi1 := 0;
    end;
  end;
end;

{************************ StampaRaccordi ********************************}

procedure StampaRaccordi(VAR Ult : integer);


{**************************** CaricaRacc1 ********************************}

procedure CaricaRacc1;
{.. Procedura che al posto del codice raccordo stampa la descrizione del raccordo ..}

var IR,IP,k : integer;

{.. Ir => indice record computo raccordi CMRaccordi
    Ip => indice record RecPerd
    k  => indice record di stampa raccordi CMRaccordi1       ..}

begin
  k  := 0;
  Ir := 0;
  repeat
    Ir := Ir+1;
    Ip :=1;
    if (Comp_Racc^[Ir].CodR[1] <>'^') AND (Comp_Racc^[Ir].CodR[1] <>'>') then
    begin
      while (Ip <= NPerd) and ( UpString(Comp_Racc^[Ir].CodR) <> UpString(Perd_D^[Ip].Cod) ) do ip := ip+1;
      if ( UpString(Comp_Racc^[Ir].CodR) = UpString(Perd_D^[Ip].Cod) ) then
      begin
        k := k+1;
        with Comp_R1^[k] do
        begin
          CodD1  := Comp_Racc^[Ir].CodD;
          Codcm := Perd_D^[Ip].Cod;
          DescrR := Perd_D^[Ip].Descr;
          Perd_D^[Ip].Rit :=UpString(Perd_D^[Ip].RIT);
          {               ch17 = R (Ritorno)             }
          If ( Perd_D^[Ip].RIT = ch17 ) and (rit=1) then NPezzi1 := Comp_Racc^[Ir].NPezzi* round(divrit)
          else NPezzi1:= Comp_Racc^[Ir].NPezzi;
        end;
      end
      else
      begin
        {gotoxy(8,9);}
        write(w_m(31),' ',Comp_Racc^[Ir].CodR );    {raccordo non presente in archivio perdite --> }
      end;
    end;
  until Ir = Ult;
  Ult := k;
end;

{************************ StampaTitoloComputo *****************************}

Procedure StampaTitoloComputo;
begin
  WriteTesto('Titolo4a.prn');
  nrighe := nrighe+LungTXT('Titolo4a.prn');
end;

{************************ StampaRacc1 *************************************}

procedure StampaRacc1;
var TotRighePag : integer;

{******************************* StampaR ***********************************}

procedure StampaR;
var k : integer;

{**************************** StampaInizio ********************************}

procedure StampaInizio;
begin
  WriteTesto('CompRIn.prn');
  nrighe := nrighe+LungTXT('CompRIn.prn');
end;

{********************* Main of StampaR *****************************}

begin
  StampaInizio;
  k := 0;
  repeat
    k := k+1;
{***    StampaMask(SEG(Comp_R1^[k]),OFS(Comp_R1^[k]),'ComputoR.prn',true);}
    nrighe := nrighe+1;
    if nrighe = MaxRighe then
    begin
      AltraPagina(NumPag,nrighe);
      StampaInizio;
    end;
  until k = Ult;
end;

{********************* Main of StampaRacc1 *****************************}

begin
  TotRighePag := nrighe + LungTXT('Titolo4a.prn') + LungTXT('CompRIn.prn') + 2 ;{2 = almeno due righe di dati}
  StampaTitoloComputo;
  if ToTRighePag <= MaxRighe then StampaR
  else
  begin
    AltraPagina(NumPag,Nrighe);
    StampaR;
  end;
end;

{********************* Main of StampaRaccordi *****************************}

begin
   InitRacc1;
   CaricaRacc1;
   StampaRacc1;
end;

{ **************************** CaricaValvole ************************** }

procedure  CaricaValvole(diametro : st8);
var i           : integer;
    Registrato  : boolean;

begin
  i := 0;
  Registrato := false;
  repeat
    i := i+1;
    if ( C_Valv^[i].CodD = '' ) then
    Begin
      C_Valv^[i].CodD := Diametro;
      C_Valv^[i].NPezzi := 0;
      Registrato := True;
    end;
    if ( UpString(C_Valv^[i].CodD) = Diametro ) then
    begin
      C_Valv^[i].NPezzi := C_Valv^[i].NPezzi + 1;
      Registrato := True;
    end;
  until Registrato or (i = 40);
end;

{***************************  StampaTitoloV *******************************}

Procedure StampaTitoloV;
var totale  : integer;
begin
  totale := nrighe + LungTXT('Titolo4b.prn') + LungTXT('DValvo.prn') + 2;
  if totale > maxrighe then altrapagina(numpag,nrighe);
  WriteTesto('Titolo4b.prn');
  nrighe := nrighe+LungTXT('Titolo4b.prn');
end;
{ **************************** Initvalvolvole ***************************** }

procedure InitValvole;
var i : integer;
begin
  for i := 1 to 40 do
  begin
    C_Valv^[i].CodD:= '';
    C_Valv^[i].NPezzi := 0;
  end;
end;
{ **************************** ValvoleDiTaratura ************************** }

Procedure ValvoleDiTaratura;

var
    k,k1,jj,ii : integer;
    FineSot,ok : boolean;

{ **************************** CaricaLeValvole ************************** }

procedure CaricaLeValvole;

var k   : integer;

begin
  k := 0;
  repeat
    k := k+1;
    if GTerm^[k]^.Cod > '' then
    begin
      GTerm^[k]^.Diam := UpString(GTerm^[k]^.Diam);
      if GTerm^[k]^.Diam >'' then CaricaValvole(GTerm^[k]^.Diam);
    end;
  until k = UltGTerm;
end;

{ ----------------------- main of ValvoleDiTaratura ----------------------- }

begin
  InitValvole;
  retePrinc := false;
  FineSot := false;
  Repeat
    if RetePrinc then
    begin
      ok := false;
      ExistSottorete(numeroprog1,ok);
      if ok then
      begin
        for jj := 1 to maxsot do
        begin
          for ii:=1 to rit do
          begin
            manrip:=(ii=1);
            LoadDis(driveprog+vprog^[jj].Nome);
            CaricaLeValvole;
          end;
        end;
      end;
      FineSot := True;
    end
    else
    begin
      for ii:=1 to rit do
      begin
        manrip:=(ii=1);
        LoadDis(NumeroProg);
        CaricaLeValvole;
      end;
      RetePrinc := True;
    end;
  Until FineSot;
end;

{ *************************** Descrizione ********************************* }

function Descrizione : st50;
var i : integer;
    Tr: boolean;

{ ***************************** LoadArch ******************************** }

procedure LoadArch;
type recarcv=record
                descr:string[50];
                cod  :string[8];
                end;
arvalv=array[1..10]of recarcv;

 var i:integer;
 var f:file of archvalv;
     f1:file of arvalv;
     vv:^arvalv;
 begin
    if Exist(drivearc+'valvole.ark') then
     begin
        {$I-}
        assign(f,drivearc+'valvole.ark');
        reset(f);
        read(f,VValv^);
        close(f);
        {$I+}
        if ioresult<>0 then
        begin
          assign(f1,drivearc+'valvole.ark');
          reset(f1);
          new(vv);
          fillchar(vv^,sizeof(vv^),0);
          read(f1,vv^);
          close(f1);
          fillchar(VValv^,sizeof(VValv^),0);
          for i:=1 to 10 do
           begin
              VValv^[i].Descr:=VV^[i].Descr;
              VValv^[i].Cod:=VV^[i].Cod;
           end;
          dispose(vv);
        end;
     end
    else
     begin
        for i:=1 to maxvalv do
         with VValv^[i] do
          begin
             Descr:='';
             COD:='';
          end;
      end;
  end;

(*
procedure LoadArch;
var fV : file of archvalv;

begin
  Assign(fv,Drivearc+'Valvole.ark');
  Reset(fv);
  Read(fv,VValv^);
  Close(fv);
end;
*)
{ ----------------------- main of Descrizione ----------------------------- }

begin
  LoadArch;
  i := 0;
  tr := false;
  repeat
    i := i+1;
    if ( UpString(Generalita_D^.ValvTipo) = UpString(VValv^[i].Cod) ) then
    begin
      Descrizione := UpString(VValv^[i].descr);
      tr := true;
    end;
  until Tr or (i = MaxValv);
  if not Tr then
  begin
    Descrizione := '';
    {gotoxy(8,8);ClrEol;}
    write(w_m(32),' ',Generalita_D^.ValvTipo);       { Manca la descrizione per il tipo valvola  --> }
  end;
end;

{ ********************** StampaValvoleDiTaratura ************************** }

Procedure StampaValvoleDiTaratura;
var
    RigheTotali,i : integer;

{ ********************** StampaDescrizione ******************************** }

procedure StampaDescrizione;
var descr   : st50;

begin
  Descr := Descrizione;
  RigheTotali := Nrighe + LungTXT('DValvo.prn') + 2;
  if RigheTotali > MaxRighe then AltraPagina(NumPag,Nrighe);
{***  StampaMask(SEG(descr),OFS(descr),'dValvo.prn',true);}
  nrighe := nrighe+lungTXT('dValvo.prn');
end;

{ ************************** StampaValvole ******************************** }

procedure StampaValvole;
var k    : integer;
    esci : boolean;

{ ************************** StampaInizio ******************************** }

procedure StampaInizio;
begin
  WriteTesto('CompVIn.prn');
  nrighe := nrighe+LungTXT('CompVIn.prn');
end;

{ ---------------------- main of StampaValvole ---------------------------- }

begin
  esci := false;
  k := 0;
  StampaInizio;
  repeat
    k := k+1;
    if C_Valv^[k].CodD = '' then esci := true;
    if not esci then
    begin
{      StampaMask(SEG(C_Valv^[k]),OFS(C_Valv^[k]),'ComputoV.prn',true);}
      nrighe := nrighe+1;
      if nrighe = MaxRighe then
      begin
        AltraPagina(NumPag,nrighe);
        StampaDescrizione;
        StampaInizio;
      end;
    end;
  until (k = 40) OR esci;
end;

{ ------------------- main of StampaValvoleDiTaratura -------------------- }

begin
  if C_Valv^[1].CodD > '' then
  begin
    StampaTitolov;
    StampaDescrizione;
    StampaValvole;
  end;
end;

{ **************************  CreaFileComputoTubi ********************** }

Procedure  CreaFileComputoTubi(NomeCMT:st80);

var
    STTUBI     : STRING;
    ftubi      :text;

{ .............................CaricaTubiText .......................... }

Procedure CaricaTubiText;
var
 a:st20;
 IndD,UltT,UltD  :integer;
 L,P :st10;
 IndiceTubi,IndComputo_M: integer;

begin

 IndD:=0;
 IndiceTubi:=0;
 IndComputo_M :=0;
{ a:='';}
  REPEAT
     IndiceTubi := IndiceTubi+1;
     IndComputo_M := IndComputo_M+1;

     if Tubus[IndiceTubi] >0  then
      begin
      IF (Com_M^[IndComputo_M].Descrizione = Tubaz_D^[Tubus[IndiceTubi]].Descr) THEN
       BEGIN
          {a:='TUBI|';
          A:= A+}
          A:=Tubaz_D^[Tubus[IndiceTubi]].COD;
          UltD :=0;
          UltD := UltimoDiametro(IndComputo_M);

          For IndD :=1 to UltD do
           begin
             with Com_m^[IndComputo_M].DatiComp[IndD] do
              begin
         {        L:='';
                 P:='';}
                 str(Lunghezza:8:1,L);
                 str(Peso:8:1,P);
                 L:=formst(L);
                 P:=formst(P);
                 STTUBI:=A+Diametro+',TUBI, ,'+L+','+P+', ,'+Tubaz_D^[Tubus[IndiceTubi]].Descr+
                         ',TUBI,'+eliminadir(NumeroProg)+', , ,';
                 writeLn(ftubi,STTUBI);
              end;
           end;  {.. end For ..}

       END; { .. end IF ..}
      end;
  UNTIL (IndiceTubi = maxtubaz) OR (Tubus[IndiceTubi] = 0);

end;

Procedure CaricaRaccordiText;
var indR,ii:integer;
    fine,Tr:boolean;
   { a:st30;}
    nump:st3;
begin
 IndR:=0;
 Fine:=False;
 repeat
  indR:=IndR+1;
  WITH Comp_R1^[IndR] do
  begin
    if CodD1 > '' then
       begin
        nump:='';
        ii:=0;
        tr:=true;
       { tr:=false;
        repeat
          ii:=ii+1;
          if ( UpString(Perd_d^[ii].Descr) ) = (UpString(DescrR)) then Tr:=True
        until tr or (ii=maxperd);}

        if tr then
         begin
            str(nPezzi1,NumP);
            STTUBI:={Perd_d^[ii].}Codcm+CodD1+',RACCORDI,'+formst(NUMP)+', , , ,'+{Perd_d^[ii].Descr}DescrR+
                    ',TUBI,'+eliminadir(NumeroProg)+', , ,';
            writeLn(ftubi,sttubi);
         end
       end
    else Fine:=True;
  end;
 until Fine or (indR=MaxRacc);
end;


Procedure CaricaValvoleText;
var k:integer;
    esci:boolean;
    nump:string;
begin
   esci:=false;
   k := 0;
   repeat
     k := k+1;
     if C_Valv^[k].CodD = '' then esci := true;
     if not esci then
     begin
       str(C_Valv^[k].NPezzi:5,NumP);
       STTUBI:=Generalita_D^.ValvTipo+C_Valv^[k].CodD+',VALVTAR,'+formst(NUMP)+', , , ,'+Descrizione+
               ',TUBI,'+eliminadir(NumeroProg)+', , ,';
       writeLn(ftubi,sttubi);
     end;
   until (k = 40) OR esci;
end;

{ ...................... main of CreaFileComputoTubi ...................... }

begin

  Assign(ftubi,nomeCMT); { salvo nei progetti di carterm }
  Rewrite(ftubi);

  CaricaTubiText;
  CaricaRaccordiText;
  CaricaValvoleText;

  Close(FTubi);


end;


{**************************** COMPUTO ***********************************}

procedure Computo(indiceScelte : integer);
var UltimoRaccordo : integer;
    gostampa       : boolean;

begin
  TrovaTubiUsati;
  MainCaricaComputo;
  AltraPagina(numPag,nrighe);
  StampaComputo;
  UltimoRaccordo := 0;
  gostampa := false;
  MainCaricaRaccordi(UltimoRaccordo,gostampa);
  if gostampa then   StampaRaccordi(UltimoRaccordo);
  if Generalita_D^.ValvTipo <> '' then
  begin
    ValvoleDiTaratura;
    StampaValvoleDiTaratura;
  end;
  if ( (IndiceScelte+1) > 4 ) then saltoPag
  else if (buffer.scelte[IndiceScelte+1] = 0 ) then saltopag;
  CreaFileComputoTubi(driveprog+eliminadir(NumeroProg)+'.cmm');
end;



end.
