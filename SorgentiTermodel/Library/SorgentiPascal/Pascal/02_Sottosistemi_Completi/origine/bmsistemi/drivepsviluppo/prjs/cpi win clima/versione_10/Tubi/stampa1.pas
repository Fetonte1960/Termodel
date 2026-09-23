{ *********** OPZIONE DI STAMPA 1 => DIMENSIONAMENTO TUBAZIONI ************* }
{***************************  StampaPortate **********************************}

procedure StampaPortate;
var NumRighe : integer;


begin

  NumRighe := NRighe+LungTXT('Portate.prn');

  if NumRighe >maxrighe then AltraPagina(NumPag,nrighe);

{***  StampaMask(SEG(Port),OFS(Port),'Portate.prn',true);}

  nrighe := nrighe+lungTXT('portate.prn');

end;


{******************************* initportate *******************************}

procedure InitPortate;
var i   : integer;

begin
  if exist(numeroprog+'.ris') then
   begin
     assign(frisult,NumeroProg+'.ris');
     reset(frisult);
     read(frisult,RisultCalc^);
     close(FRisult);

    with Port do
     begin
      PortataTotL  := RisultCalc^.Portata;
      PortataTotKg := (RisultCalc^.Portata*Flum_D^.dens)/1000;
      Generalita_D^.ritorno := Upstring(Generalita_D^.RITORNO);
      DeltPtot := RisultCalc^.Perdita*divrit;
     end;
   end
 else
  begin
  with Port do
  begin
    PortataTotL  := 0;
    PortataTotKg := 0;
    Generalita_D^.ritorno := Upstring(Generalita_D^.RITORNO);
    DeltPtot := 0;
  end;
 end;
end;

{*************************** StampaDatiTubazioni ***************************}


{*************************** StampaIntestazione  ***************************}

procedure StampaIntestazione(StampaDicitura : boolean;descr : st50;nomeD : st10);
var totalerighe  : integer;
    descrl       : string;

begin
   if (StampaDicitura) or (rit=2) then
   begin
     Totalerighe := nrighe+LungTXT('Dicitura.prn')+LungTXT('Tubaz.prn') + 2;
     if Totalerighe > MaxRighe then AltraPagina(NumPag,NRighe);
     if (manrip) and (rit=2) then descrl:=descr +'  '+ w_m(24);   {   - MANDATA - }
     if (not(manrip)) and (rit=2) then descrl:= descr +'  '+ w_m(25); {   - RITORNO -}
     if (manrip) and (rit=1) then descrl:=descr;
     Descr1.Descr := UpString(Descr);
     if descr = dicitura then
     begin  {rete principale}
{***    StampaMask(SEG(descrl),OFS(descrl),'dicitura.prn',true);}
     end
     else
     begin  {sottoreti}
       if (manrip) and (rit=2)      then descr1.rit:=w_m(24);   {   - MANDATA - }
       if (not(manrip)) and (rit=2) then descr1.rit:=w_m(25);   {   - RITORNO -}
       if (manrip) and (rit=1)      then descr1.rit:=')';
       descr1.nome  := '('+UpString(nomeD);
{***    StampaMask(SEG(descr1),OFS(descr1),'dicit1.prn',true);}
     end;
     nrighe := nrighe+ LungTXT('Dicitura.prn');
   end;
   Totalerighe := nrighe+LungTXT('Tubaz.prn') + 2;
   if TotaleRighe > MaxRighe then AltraPagina(NumPag,NRighe);
   WriteTesto('tubaz.prn');
   nrighe := nrighe+LungTXT('Tubaz.prn');
end;

{***************************  InitCalcolo1 ***********************************}

procedure InitCalcolo1;
var  i   : integer;

begin
  for i := 1 to ulttronco do
  begin
    new(comodo^[i]);
    With Comodo^[i]^ do
    begin
      Num1       := 0;    {- Numerazione tronchi -}
      Tubo       := 0;
      Formula    := 0;
      DiamCod    := '';
      Velocita   := 0;
      Portata    := 0;
      Lung       := 0;
      DeltaH     := 0;
      DpDist     := 0;
      DpLoc      := 0;
      DpTot      := 0;
      DpProg     := 0;
      Squil      := 0;
      Terminale  := '';
    end;
  end;
end;

{ ************************** OrdinaCalcolo1  ******************************** }

Procedure OrdinaCalcolo1;

type
  Calcolo2 = record

               Num2       :Integer;    {- Numerazione tronchi -}
               Tubo2      :integer;
               Formula2   :integer;
               DiamCod2   :st8;

               Velocita2  :real;
               Portata2   :real;
               Lung2      :real;
               DeltaH2    :real;
               DpDist2    :real;
               DpLoc2     :real;
               DpTot2     :real;
               DpProg2    :real;
               Squil2     :real;
               Terminale2 :st8;
             end;




var
  i,k        : integer;
  Scambio    : boolean;
  Com        : Calcolo2;

procedure InitCalcolo2;
var j : integer;

begin
  With Com do
  begin
    Num2       := 0;    {- Numerazione tronchi -}
    Tubo2      := 0;
    Formula2   := 0;
    DiamCod2   := '';
    Velocita2  := 0;
    Portata2   := 0;
    Lung2      := 0;
    DeltaH2    := 0;
    DpDist2    := 0;
    DpLoc2     := 0;
    DpTot2     := 0;
    DpProg2    := 0;
    Squil2     := 0;
    Terminale2 := '';
  end;
end;


{ -------------------------- main of OrdinaCalcolo1  ---------------------- }

begin
  InitCalcolo2;
  repeat
    Scambio := False;
    i :=1;
    k :=i+1;
    repeat
      if Comodo^[i]^.Num1 > Comodo^[k]^.Num1 then
      Begin
        With Com do
        begin
          Num2       := Comodo^[i]^.num1;    {- Numerazione tronchi -}
          Tubo2      := Comodo^[i]^.Tubo;
          Formula2   := Comodo^[i]^.Formula;
          DiamCod2   := Comodo^[i]^.DiamCod;
          Velocita2  := Comodo^[i]^.Velocita;
          Portata2   := Comodo^[i]^.Portata;
          Lung2      := Comodo^[i]^.Lung;
          DeltaH2    := Comodo^[i]^.DeltaH;
          DpDist2    := Comodo^[i]^.DpDist;
          DpLoc2     := Comodo^[i]^.DpLoc;
          DpTot2     := Comodo^[i]^.DpTot;
          DpProg2    := Comodo^[i]^.DpProg;
          Squil2     := Comodo^[i]^.Squil;
          Terminale2 := Comodo^[i]^.Terminale;
        end;
        With Comodo^[i]^ do
        Begin
          Num1       := Comodo^[k]^.num1;    {- Numerazione tronchi -}
          Tubo       := Comodo^[k]^.Tubo;
          Formula    := Comodo^[k]^.Formula;
          DiamCod    := Comodo^[k]^.DiamCod;
          Velocita   := Comodo^[k]^.Velocita;
          Portata    := Comodo^[k]^.Portata;
          Lung       := Comodo^[k]^.Lung;
          DeltaH     := Comodo^[k]^.DeltaH;
          DpDist     := Comodo^[k]^.DpDist;
          DpLoc      := Comodo^[k]^.DpLoc;
          DpTot      := Comodo^[k]^.DpTot;
          DpProg     := Comodo^[k]^.DpProg;
          Squil      := Comodo^[k]^.Squil;
          Terminale  := Comodo^[k]^.Terminale;
        end;
        With Comodo^[k]^ do
        Begin
          Num1       := Com.num2;    {- Numerazione tronchi -}
          Tubo       := Com.Tubo2;
          Formula    := Com.Formula2;
          DiamCod    := Com.DiamCod2;
          Velocita   := Com.Velocita2;
          Portata    := Com.Portata2;
          Lung       := Com.Lung2;
          DeltaH     := Com.DeltaH2;
          DpDist     := Com.DpDist2;
          DpLoc      := Com.DpLoc2;
          DpTot      := Com.DpTot2;
          DpProg     := Com.DpProg2;
          Squil      := Com.Squil2;
          Terminale  := Com.Terminale2;
        end;
        Scambio := True;
      end
      else
      begin
        i := i+1;
        k := k+1;
      end;
    Until Scambio OR (i = UltTronco);
  Until not Scambio;
End;

{ --------------------- end of OrdinaCalcolo1  ------------------------------ }

{ ************************** StampaCalcolo1  ******************************** }

Procedure StampaCalcolo1(StampaTipoRete : boolean;Intestazione1 : st50;Intest1 : st10);
type  rete = record

               Num2       :st4;    {- Numerazione tronchi -}
               Tubo2      :integer;
               Formula2   :integer;
               DiamCod2   :st8;

               Velocita2  :real;
               Portata2   :real;
               Lung2      :real;
               DeltaH2    :real;
               DpDist2    :real;
               DpLoc2     :real;
               DpTot2     :real;
               DpProg2    :real;
               Squil2     :real;
               Terminale2 :st8;
             end;


StampeRete=array[1..lungdati] of ^rete;

var  i,k       : integer;
     Continua  : boolean;
     Fin       : ^StampeRete;

{*-*-*-*-*-*-*-*-*-*-*-*-*-* InitFin *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure InitFin;
var j : integer;

begin
  for j := 1 to ulttronco do
  begin
    new(fin^[j]);
    with fin^[j]^ do
    begin
      Num2       := '';    {- Numerazione tronchi -}
      Tubo2      := 0;
      Formula2   := 0;
      DiamCod2   := '';
      Velocita2  := 0;
      Portata2   := 0;
      Lung2      := 0;
      DeltaH2    := 0;
      DpDist2    := 0;
      DpLoc2     := 0;
      DpTot2     := 0;
      DpProg2    := 0;
      Squil2     := 0;
      Terminale2 := '';
    end;
  end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-* CaricaFin *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure CaricaFin;
var j : integer;

begin
  for j := 1 to UltTronco do
  begin
    if Comodo^[j]^.Num1 <> 0 then
    begin
      with Fin^[j]^ do
      begin
        STR(Comodo^[j]^.Num1,Fin^[j]^.Num2); {- Numerazione tronchi -}
        if PercorsoSfavorito then
        begin
          if Sfavorito <> 0 then
          begin
            if (Sfavorito = Comodo^[j]^.num1) and manrip then Fin^[j]^.Num2 := SetLeft(SetRight(Fin^[j]^.Num2))+'*';
            if (Sfavorito = Comodo^[j]^.num1) and (not(manrip)) then Fin^[j]^.Num2 := SetLeft(SetRight(Fin^[j]^.Num2));
          end
          else
          begin
            if (SfavoritoSot = Comodo^[j]^.num1) and manrip then Fin^[j]^.Num2 := SetLeft(SetRight(Fin^[j]^.Num2))+'*';
            if (SfavoritoSot = Comodo^[j]^.num1) and (not(manrip)) then Fin^[j]^.Num2 := SetLeft(SetRight(Fin^[j]^.Num2));
          end;
        end;
        Tubo2      := Comodo^[j]^.Tubo;
        Formula2   := Comodo^[j]^.Formula;
        DiamCod2   := Comodo^[j]^.DiamCod;
        Velocita2  := Comodo^[j]^.Velocita;
        Portata2   := Comodo^[j]^.Portata;
        Lung2      := Comodo^[j]^.Lung;
        DeltaH2    := Comodo^[j]^.DeltaH;
        DpDist2    := Comodo^[j]^.DpDist;
        DpLoc2     := Comodo^[j]^.DpLoc;
        DpTot2     := Comodo^[j]^.DpTot;
        DpProg2    := Comodo^[j]^.DpProg;
        Squil2     := Comodo^[j]^.Squil;
        Terminale2 := Comodo^[j]^.Terminale;
      end;{..with..}
    end; {..if..}
  end;{..for..}
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-* StampaSfavorito *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

procedure StampaSfavorito;
begin
  if manrip then
  begin
    WriteTesto('Sfavor.prn');
    nrighe := nrighe+LungTXT('Sfavor.prn');
  end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-* StampaSfavorito1 *-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

procedure StampaSfavorito1;
begin
  if manrip then
  begin
    WriteTesto('Sfavor1.prn');
    nrighe := nrighe+LungTXT('Sfavor1.prn');
  end;
end;


{ ************************** Main di StampaCalcolo1  ******************************** }


begin
  new(Fin);
  for i:=1 to lungdati do fin^[i]:=nil;

  Initfin;

  i := 1;
  CaricaFin;


  repeat

    Continua := false;

    StampaIntestazione(StampaTipoRete,Intestazione1,Intest1);

    k := nrighe;


    repeat

       if Fin^[i]^.Num2 <> '' then
       begin
{***       StampaMask(SEG(fin^[i]^),OFS(fin^[i]^),'TubiTab.prn',true);}
          k:=k+1;
       end;
       i := i+1;

    until (i > UltTronco) or (k > MaxRighe);

    NRighe := k;

    if ( (k > MaxRighe) and (i<= UltTronco) ) then AltraPagina(NumPag,NRighe);

    if (i <= UltTronco)then Continua := true
    else Continua := false;

  until not Continua;

  if  PercorsoSfavorito then
    begin
      if NRighe < MaxRighe then StampaSfavorito
      else StampaSfavorito1;
    end;

  Dispose(Fin);
end;

{***************************  StampaDatiTubazioni ***************************}

Procedure StampaDatiTubazioni(TipodiRete : boolean;Intestazione :st50;Intest : st10);
begin
  OrdinaCalcolo1;
  StampaCalcolo1(TipoDiRete,intestazione,Intest);
end;


{ ************************** CaricaCalcolo1  ******************************** }

procedure CaricaCalcolo1(Ind1,ind,IndGTerm : integer);
begin
  With Comodo^[Ind1]^ do
  begin
    Num1    := Dati^[Ind]^.Num;    {- Numerazione tronchi -}
    DiamCod := Dati^[Ind]^.CodDiam;
    portata := Dati^[Ind]^.PortEff;   {- Port. effettiva  -}
    lung    := Dati^[Ind]^.Lungh;
    Deltah  := Dati^[Ind]^.Dh;     {- Diff di quota  -}
    DpDist  := Dati^[Ind]^.Pd;     {- Perdite -}
    DpLoc   := Dati^[Ind]^.Pl;     {- Perdite -}
    DpTot   := (Dati^[Ind]^.Pd + Dati^[Ind]^.Pl);
    DpProg  := Dati^[Ind]^.Pp;     {- Perdite -}
    if (IndGTerm <>0) then
    begin
      Comodo^[Ind1]^.Squil     := GTerm^[IndGTerm]^.Sbil;
      Comodo^[Ind1]^.Terminale := GTerm^[IndGTerm]^.Cod;
    end
    else
    begin
      Comodo^[Ind1]^.Squil     := 0;
      Comodo^[Ind1]^.Terminale := '';
    end;
  end;
end;

{************************** RicercaDiam *********************************}

Procedure RicercaDiam(Indice,IndCalc : integer;VAR IndiceSez : integer);
var j1 : integer;
    Tr : boolean;

begin
  tr := false;
  j1 := 1;
  while ( not(tr) ) and (j1 <= maxsez) do
  begin
    if UpString(Tubaz_D^[Indice].Sez[j1].Dnom) =  UpString(Dati^[IndCalc]^.CodDiam) then tr := true
    else j1 := j1 + 1;
  end;
  if Tr then IndiceSez := j1
  else IndiceSez := 0;
end;

{*************************** CaricaIDatiDiDati *************************}


procedure CaricaIDatiDiDati;
{.. i => indice di calcrec contiene i dati della rete
    j => indice di recTubaz contenente i dati delle tubazioni
    IFormula => indice indicante il tipo di formula usata per quel tronco
    GT => indice di recGTerm contenente i dati dei terminali           ..}


var  i,j,IFormula,Ind,GT   : integer;

begin
  IFormula := 0;
  Ind := 0;
  i := 0;
  REPEAT
    i := i+1;
    if (Dati^[i]^.Ti <> 0) then
    begin
      if (Dati^[i]^.Term <> 0) then GT := Dati^[i]^.Term else GT := 0;
      j := 1;
      if (Dati^[i]^.Tipo <> '') then
      begin
        while ( (UpString(Dati^[i]^.Tipo) <> UpString(Tubaz_D^[j].Cod)) AND
              (j < maxTubaz) ) do j := j+1;
        if ( UpString(Dati^[i]^.Tipo) =  UpString(Tubaz_D^[j].Cod) ) then
        begin
          RicercaDiam(j,i,IFormula);
          Ind := Ind+1;
          if IFormula <> 0 then Comodo^[Ind]^.Formula := Tubaz_D^[j].Sez[IFormula].Form;
          Comodo^[Ind]^.Tubo := j;
          Comodo^[Ind]^.Velocita := 4*Dati^[i]^.PortEff/(PI*SQR(Dati^[i]^.diam))* 1000;
          CaricaCalcolo1(Ind,i,gt);
        end;
      end
      else
      begin
        Ind := Ind+1;
        Comodo^[Ind]^.Velocita := 4*Dati^[i]^.PortEff/(PI*SQR(Dati^[i]^.diam))* 1000;
        CaricaCalcolo1(ind,i,gt);
      end;
    end;
  UNTIL i = UltTronco;
end;
{ ********************* MainCaricaCalcolo1 ***************************** }

procedure MainCaricaCalcolo1;
var jj,ii      : integer;
    ok,FineSot : boolean;

{ ----------------------- main of mainCaricaCalcolo1 ---------------------- }

begin

  retePrinc := false;
  FineSot := false;
  repeat
    if retePrinc then
    begin
      ok := false;
      ExistSottorete(numeroprog1,ok);
      if ok then
      begin
        for jj := 1 to maxsot do
        begin
          if vprog^[jj].nome<>'' then
          begin
            for ii:=1 to rit do
            begin
              manrip:=(ii=1);
              LoadDis(driveprog+vprog^[jj].Nome);
              if UltTronco > 1 then
              begin
                InitCalcolo1;
                caricaIDatiDiDati;
                if ( UpString(SottoreteSfavorita) = UpString(vprog^[jj].nome) ) then
                begin
                  PercorsoSfavorito := True;
                  SfavoritoSot := Dati^[RisultCalc^.sfavor]^.num;
                end
                else PercorsoSfavorito := false;
                StampaDatiTubazioni(True,vprog^[jj].Descr,vprog^[jj].Nome);
              end;
            end;
          end;
        end;
      end;
      FineSot := True;  {fine delle sottoreti}
    end
    else
    begin
      for ii:=1 to rit do
      begin
        manrip:=(ii=1);
        LoadDis(NumeroProg);
        InitPortate;
        if UltTronco > 1 then
        begin
          InitCalcolo1;
          CaricaIDatiDiDati;
          ExistSottorete(numeroprog1,ok);
          CercaSfavorito;
          if Sfavorito <> 0 then PercorsoSfavorito := true
          else PercorsoSfavorito := False;
          StampaDatiTubazioni(CiSonoSottoreti,dicitura,'');
        end;
        reteprinc := true;
      end;
    end;
    if FineSot then  StampaPortate;
  until FineSot;
end;

{ ----------------------- end of mainCaricaCalcolo1 ----------------------- }

procedure InitFormule_Tubi;
var i,j : integer;
begin
   for i := 1 to 10 do FormuleUsate[i]  := cno;

   for i := 1 to MaxTubaz do TubiUsati[i]:= cno;
end;

{**************************** RicercaFormula_Tubi *************************** }

procedure RicercaFormula_Tubi;
{..  h => indice di calcrec  contiene i dati della rete
     i => indice di recTubaz contenente i dati delle tubazioni
 Indice=> indice di recTubaz[].sez[] contenente i dati relativi al singolo tubo ..}

var h,i,indice,k : integer;
    Tr,Trovato   : boolean;

begin
  h := 0;
  REPEAT
    h := h+1;
    if (dati^[h]^.Ti <> 0)  then
    begin
      i:=1;
      if (dati^[h]^.Tipo <> '') then
      begin
        while( (UpString(dati^[h]^.Tipo) <> UpString(Tubaz_D^[i].Cod) ) and (i< maxTubaz) )do
        begin
          i:=i+1;
        end;
        if (UpString(dati^[h]^.Tipo) = UpString(Tubaz_D^[i].Cod) ) then
        begin
          ricercaDiametro(i,h,Indice);
          TubiUsati[i]:= cyes;
        end;
      end;
    end;
  UNTIL h = ultTronco;
end;

{ *************************** MainRicercaFormula_Tubi ********************* }

Procedure MainRicercaFormula_Tubi;
{j => indice del record vprog^[] contenente il nome della sottorete.
      Attenzione ! Tale record non e` compattato                   }

var FineSot,ok : boolean;
    j,l,i      : integer;

begin

  InitFormule_Tubi;

  CiSonoSottoreti := false;
  RetePrinc := false;
  FineSot := false;

  for l:=1 to rit do
  begin
    manrip:=(l=1);
    repeat
      if RetePrinc then
      begin
        ok := false;
        ExistSottorete(numeroprog1,ok);
        if ok then
        begin
          for i := 1 to maxsot do
          begin
            LoadDis(driveprog+vprog^[i].Nome);
            RicercaFormula_Tubi;
          end;
          CiSonoSottoreti := True;
        end;
        FineSot := True;  {fine delle sottoreti}
      end
      else
      begin
        RetePrinc := true;
        if piuReti then LOADDIS(NUMEROPROG);
        RicercaFormula_tubi;
      end;
    until FineSot;
  end;
end;

{***************************  StampaTitolo  *******************************}

Procedure StampaTitolo;
begin
  WriteTesto('Titolo1.prn');
  nrighe := nrighe+LungTXT('Titolo1.prn');
end;

{***************************  StampaFormuleUsate ***************************}

procedure StampaFormuleUsate;
var i : integer;

begin
   WriteTesto('Form.prn');
   nrighe := lungtxt('Form.prn');
   i := 0;
   repeat
     i :=i+1;
     if FormuleUsate[i] = cyes then
     begin
       Form.num  := i;
       Form.Descr:= Formule[i];
{***     StampaMask(SEG(Form),OFS(Form),'ElencoF.prn',true);}
       nrighe := nrighe+lungTXT('ElencoF.prn');
     end;
   until (i = 10);
end;

{***************************  StampaTubazioniUsate ***************************}

procedure StampaTubazioniUsate;
var i     : integer;
    tr    : boolean;
    temp  :string;

begin
  i  := 0;
  repeat
    tr := false;
    WriteTesto('tubi.prn');

    {temp:='temp.lst';
    settadriveprn(temp);
    Assign(ft,temp);
    rewrite(ft);}

    repeat
      i :=i+1;
      if TubiUsati[i] = cyes then
      begin
        Tub.num  := i;
        Tub.Descr:= Tubaz_D^[i].Cod;
{***     StampaMask(SEG(Tub),OFS(Tub),'ElencoT.prn',true);}
       { WriteTemp('ElencoT.prn');}
        nrighe := nrighe+lungTXT('elencoT.prn');
        if NRighe >= MaxRighe then
        begin
          tr := true;
          {Close(ft);}
          AltraPagina(NumPag,nrighe);
{          writeTesto('temp.lst');}
        end;
      end;
    until (i = 20)or Tr;
  until not tr;
 { writeTesto('temp.lst');
  close(ft);}
end;

{***************************  StampaPerditediCarico ***************************}

procedure StampaPerditediCarico;
var descr : st60;
    fciccio: text;
    dd,TotRig: integer;

procedure InitPerdite;
begin
  with Perd do
  begin
    MaxVelSF   := Generalita_D^.maxvels;
    MaxDeltaSF := Generalita_D^.dps;
    MaxVel     := Generalita_D^.maxvele;
    MaxDelta   := Generalita_D^.dpe;
  end;
end;


{ ----------------------- main of stampaPerdite --------------------------- }

begin
  InitPerdite;
  dd := 0;
  totRig := NRighe+LungTxt('perdA.prn')*2+ LungTxt('Perdite.prn');
  if TotRig > MaxRighe then AltraPagina(NumPag,nrighe);

  {NumeroProg = Data_Drive+nome progetto};

  if Exist(numeroprog+'.CLC') then
  begin
    descr := '';
    Assign(fciccio,numeroprog+'.CLC');
    Reset(fciccio);
    while not Eof(fciccio) do
    begin
      readln(fciccio,descr);
{***   StampaMask(SEG(descr),OFS(descr),'PerdA.prn',true);}
      nrighe := nrighe+lungTXT('perdA.prn');
    end;
    Close(fciccio);
  end;
{***  StampaMask(SEG(perd),OFS(perd),'Perdite.prn',true);}
  nrighe := nrighe+lungTXT('perdite.prn');
  if NRighe >= MaxRighe then AltraPagina(NumPag,nrighe);
end;



{***************************  Dimensionamento ********************************}

Procedure Dimensionamento(IndiceScelte : integer);

begin



   AltraPagina(NumPag,nrighe);

   StampaTitolo;

   MainRicercaFormula_tubi;

   StampaFormuleUsate;

   StampaTubazioniUsate;

   StampaPerditediCarico;

   MainCaricaCalcolo1;

   if ( (IndiceScelte+1) > 4 ) then saltoPag
   else if (buffer.scelte[IndiceScelte+1] = 0 ) then saltopag;

end;
