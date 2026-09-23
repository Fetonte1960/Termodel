{ ******* OPZIONE DI STAMPA 2 =>  PERDITE DI CARICO LOCALIZZATE ******* }

{ ************************** InitperditeLoc *************************** }

Procedure InitperditeLoc;
var i  : integer;

begin
  for i := 1 to 5 do
  begin
    With  PLoc[i] do
    begin
      numT      := 0;
      DiamP     := '';
      CodR      := '';
      NPezziR   := 0;
      LEquiv    := 0;
      DpRacc    := 0;
      CodZ      := '';
      NPezziZ   := 0;
      Perdzeta  := 0;
      DpZeta    := 0;
      DpTOT     := 0;
    end;
  end;
end;


{ ************************* Compattadiametro **************************** }

procedure CompattaDiametro;
var  Tr  : boolean;
     i   : integer;

begin
  Tr := false;
  i := 1;
  repeat
    i := i+1;
    if Ploc[i].DiamP >'' then
    begin
      Tr := True;
      {carico il diametro e il numero tronco sulla prima perdita in assoluto}
      PLoc[1].DiamP := PLoc[i].DiamP;
      PLoc[1].NumT  := PLoc[i].NumT;
      PLoc[i].DiamP := '';
      PLoc[i].NumT  := 0;
    end;
  until Tr or (i= 5);
end;

{ ***************************** CompattoR ******************************* }

Procedure CompattoR(i : integer);

{ ***************************** Azzera ********************************** }

procedure Azzera;
begin
  with  PLoc[i+1] do
  begin
    CodR      := '';
    NPezziR   := 0;
    LEquiv    := 0;
    DpRacc    := 0;
  end;
end;

{ *************************** Main of CompattoR ************************** }

begin
  With PLoc[i] do
  begin
    CodR      := PLoc[i+1].CodR;
    NPezziR   := PLoc[i+1].NPezziR;
    LEquiv    := PLoc[i+1].LEquiv;
    DpRacc    := PLoc[i+1].DpRacc;
  end;
  if i = 4 then Azzera;
end;

{ ***************************** CompattaRaccordi ************************** }

Procedure CompattaRaccordi;
var
  k,ind,ult            : integer;
  Fine,CompattatoTutto   : boolean;


{ *************************** UltimoDaCompattare ************************* }


function UltimoDaCompattare : integer;
var id : integer;

begin
  id := 5;
  while (id > 1) and (PLoc[id].CodR ='') do id := id-1;
  UltimoDaCompattare := id;
end;

{ ************************ Main of CompattaRaccordi ********************** }

begin
  repeat
    Compattatotutto := True;
    Fine:= false;
    Ult := 0;
    ind := 0;
    repeat
      ind := ind+1;
      Ult := UltimoDaCompattare;
      if( (PLoc[ind].CodR) = '') and (Ult > 1) then
      begin
        Compattatotutto := false;
        if ult = 5 then ult := ult-1;
        for k := ind to Ult do CompattoR(k);
        Fine := true;
      end;
    until Fine or (ind = Ult);
  until CompattatoTutto;
end;

{ ***************************** CompattoZ ******************************* }

Procedure CompattoZ(i : integer);


{ ***************************** Azzera ******************************* }

procedure Azzera;
begin
  with  PLoc[i+1] do
  begin
    CodZ      := '';
    NPezziZ   := 0;
    Perdzeta  := 0;
    DpZeta    := 0;
  end;
end;

{ ***************************** Main of CompattoZ ************************* }

begin
  With PLoc[i] do
  begin
    CodZ      := PLoc[i+1].CodZ;
    NPezziZ   := PLoc[i+1].NPezziZ;
    Perdzeta  := PLoc[i+1].PerdZeta;
    DpZeta    := PLoc[i+1].DpZeta;
  end;
  if i = 4 then Azzera;
end;

{ ***************************** CompattaZeta ***************************** }

Procedure CompattaZeta;
var
  k,ind,ult            : integer;
  Fine,CompattatoTutto   : boolean;


{ ************************** UltimoDaCompattare ************************** }

function UltimoDaCompattare : integer;
var id : integer;

begin
  id := 5;
  while (id > 1) and (PLoc[id].CodZ ='') do id := id-1;
  UltimoDaCompattare := id;
end;

{ *********************** Main of CompattaZeta *************************** }

begin
  repeat
    Compattatotutto := True;
    Fine:= false;
    Ult := 0;
    ind := 0;
    repeat
      ind := ind+1;
      Ult := UltimoDaCompattare;
      if( (PLoc[ind].CodZ) = '') and (Ult > 1) then
      begin
        Compattatotutto := false;
        if ult = 5 then ult := ult-1;
        for k := ind to Ult do CompattoZ(k);
        Fine := true;
      end;
    until Fine or (ind = Ult);
  until CompattatoTutto;
  if PLoc[1].DiamP = '' then CompattaDiametro;
end;

{ ***************************** ScriviDpTot ***************************** }

procedure ScriviDpTot(valore : real);
var R,Z : integer;

{ ************************ UltimoRacc *********************************** }

function UltimoRacc : integer;
var ut,l : integer;

begin
  ut := 5;
  while (ut > 1) and (PLoc[ut].CodR ='') do ut := ut-1;
  UltimoRacc := ut;
end;

{ ************************ UltimoZeta *********************************** }

function UltimoZeta : integer;
var ut,l : integer;

begin
  ut := 5;
  while (ut > 1) and (PLoc[ut].CodZ ='') do ut := ut-1;
  UltimoZeta := ut;
end;

{ ************************ Main of ScriviDpTot *************************** }

begin
  R := UltimoRacc;
  Z := UltimoZeta;
  if (Z > 1) or (R > 1) then
  begin
    if Z >= R then PLoc[Z].DpTot := Valore else  PLoc[R].DpTot := Valore;
  end
  else PLoc[1].DpTot := Valore;
end;

{ ************************** StampaTitolo2 **************************** }

Procedure StampaTitolo2;
begin
  WriteTesto('Titolo2.prn');
  nrighe := nrighe+LungTXT('Titolo2.prn');
end;

{ ************************** StampaIntPLocalizzate ******************** }

procedure StampaIntPLocalizzate(StampaDicitura : boolean;descr : st50;nomeD:st10);
var TotaleRighe      : integer;
    descrl           : string;

begin
  if (StampaDicitura) or (rit=2) then
  begin
    Totalerighe := nrighe+LungTXT('Dicitura.prn')+LungTXT('RaccZeta.prn') + 2;
    if Totalerighe > MaxRighe then AltraPagina(NumPag,NRighe);
    if (manrip) and (rit=2) then descrl:=descr +'  '+w_m(24);    {   - MANDATA - }
    if (not(manrip)) and (rit=2) then descrl:= descr +'  '+w_m(25);{ - RITORNO - }
    if (manrip) and (rit=1) then descrl:=descr;
    Descr1.Descr := UpString(Descr);
    if descr = dicitura then
    begin  {rete principale}
{***      StampaMask(SEG(descrl),OFS(descrl),'dicitura.prn',true);}
    end
    else
    begin  {sottoreti}
      if (manrip) and (rit=2)      then descr1.rit:=w_m(24);    { - MANDATA - }
      if (not(manrip)) and (rit=2) then descr1.rit:=w_m(25);    { - RITORNO - }
      if (manrip) and (rit=1)      then descr1.rit:=')';
      descr1.nome  := '('+UpString(nomeD);
{***    StampaMask(SEG(descr1),OFS(descr1),'dicit1.prn',true);}
    end;
    nrighe := nrighe+ LungTXT('Dicitura.prn');
  end;
  Totalerighe := nrighe+LungTXT('RaccZeta.prn') + 2;
  if TotaleRighe > MaxRighe then AltraPagina(NumPag,NRighe);
  WriteTesto('RaccZeta.prn');
  nrighe := nrighe+LungTXT('RaccZeta.prn');
end;

{ ************************** Stampa *********************************** }

procedure stampa_n(nome :st50;nome1 :st10);
var NumRighe,i  : integer;

begin
  i := 0;
  repeat
    i := i+1;
    if (PLoc[i].CodR > '') OR (PLoc[i].CodZ >'') then
    begin
      NumRighe := NRighe+LungTXT('PLocaliz.prn');
      if NumRighe >maxrighe then
      begin
        AltraPagina(NumPag,nrighe);
        StampaIntPLocalizzate(false,nome,nome1);
        PLoc[i].NumT :=PLoc[1].NumT;
        PLoc[i].DiamP:=PLoc[1].DiamP;
      end;
{***      StampaMask(SEG(PLoc[i]),OFS(PLoc[i]),'PLocaliz.prn',true);}
      nrighe := nrighe+lungTXT('pLocaliz.prn');
    end;
  Until (i=5);
end;

{ ************************** TrovaPerdita ********************************* }

Function TrovaPerdita(Codice : st8): real;
var i       : integer;
    Trovato : boolean;

begin
  TrovaPerdita := 0;
  i := 0;
  Trovato := false;
  repeat
    i := i+1;
    if ( Upstring(Codice) = UpString(Perd_D^[i].Cod) ) then Trovato := True;
  until Trovato or (i = MaxPerd);
  if Trovato then TrovaPerdita := Perd_D^[i].Zeta
  else
  begin
    {gotoxy(8,8);}
    write(w_m(26),' ',Codice,w_m(27));  {La perdita  --> /..../  non e` presente in archivio }
  end;
end;

{ ************************  StampaLocalizzate ************************** }

procedure StampaLocalizzate(Tr : integer;nome1 : st50;name :st10;VAR PrintIntestazione : boolean);
{$I perdconc}
{.. Attenzione !!!
    TipoPerd = 0   => non ci sono perdite
    TipoPerd = 1   => ci sono perdite Zeta
    TipoPerd = 2   => ci sono Raccordi                    ..}


var perdita,velocita,PerdUn,TotaleDp    : real;
    CiSonoPerdite                       : boolean;
    k,TipoPerd                          : integer;

{*-*-*-*-*-*-*-*-*-*-*-*-*-* Initzeta *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure Initzeta(StampaDiametro : boolean);
begin
  With  PLoc[k] do
  begin
    if not StampaDiametro then
    begin
      numT      := Dati^[Tr]^.Num;
      DiamP     := Dati^[Tr]^.CodDiam;
    end
    else
    begin
      numT      := 0;
      DiamP     := '';
    end;
    CodR      := '';
    NPezziR   := 0;
    LEquiv    := 0;
    DpRacc    := 0;
{   CodZ      := UpString(dati^[tr].PConc[k].cod);}
    NPezziZ   := dati^[tr]^.PConc[k].N;
{   Perdzeta  := TrovaPerdita(CodZ);}
    DpZeta    := PerdUn/1000 ;
    DpTOT     := 0;
    TotaleDp  := TotaleDp + (PerdUn/1000 * NPezziZ);
  end;
end;

{*-*-*-*-*-*-*-*-*-*-*-*-*-* InitRaccordi *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure InitRaccordi(StampaDiametro : boolean);
begin
 With  PLoc[k] do
  begin
    if not StampaDiametro then
    begin
      numT      := Dati^[Tr]^.Num;
      DiamP     := Dati^[Tr]^.CodDiam;
    end
    else
    begin
      numT      := 0;
      DiamP     := '';
    end;
    CodR      := UpString(dati^[tr]^.PConc[k].cod);
    NPezziR   := dati^[tr]^.PConc[k].N;
    LEquiv    := PerdUn/Perdita;
    DpRacc    := PerdUn/1000;
    CodZ      := '';
    NPezziZ   := 0;
    Perdzeta  := 0;
    DpZeta    := 0;
    DpTOT     := 0;
    TotaleDp  := TotaleDp + (PerdUn/1000 * NPezziR);
  end;
end;

{ ------------------------ main of StampaLocalizzate ---------------------- }

begin
  TotaleDp := 0;
  with dati^[tr]^ do
  begin
    Perdita  :=(pd -FluM_D^.dens*DH*9.81/1E3 )*1E3/Lungh;{pascal}
    Velocita := 4*Dati^[Tr]^.PortEff/(PI*SQR(Dati^[Tr]^.diam))* 1000;
  end;
  k := 0;
  CiSonoPerdite := false;
  InitPerditeLoc;
  Repeat
    k := k+1;
    TipoPerd := 0;
    if dati^[Tr]^.Pconc[k].cod >'' then
    begin
      Perdun:=PerdConc(Dati^[Tr]^.Pconc[k].cod,velocita,perdita,dati^[Tr]^.diam,tipoperd);
      Case TipoPerd of

           1:begin     {perdite zeta}
               PLoc[k]. CodZ     := UpString(dati^[tr]^.PConc[k].cod);
               PLoc[k].Perdzeta  := TrovaPerdita(PLoc[k].CodZ);
               if PLoc[k].PerdZeta <> 0 then
               begin
                 InitZeta(CiSonoPerdite);
                 CisonoPerdite := True;
               end;
             end;

           2:begin     {raccordi}
               if PerdUn <> 0 then
               begin
                 InitRaccordi(CiSonoPerdite);
                 CisonoPerdite := True;
               end;
             end;

      end;{end del Case}
    end;
  Until k = 5;
  if CiSonoPerdite then
  begin
    CompattaZeta;
    CompattaRaccordi;
    ScriviDpTot(TotaleDp);
    if not PrintIntestazione then
    begin
      PrintIntestazione := true;
      StampaIntPLocalizzate(CiSonoSottoreti,nome1,name);
    end;
    Stampa_n(nome1,name);
  end;
end;

{ ------------------------- end of StampaLocalizzate ------------------ }

{ ************************** StampaPerdite **************************** }

Procedure StampaPerdite(nome : st50;Nome1 :st10);
var
 i,k                 : integer;
 Trovato, PerditeSi  : boolean;

Begin
  PerditeSi := false;
  i := 0;
  Repeat
    i := i+1;
    Trovato := false;
    k := 0;
    repeat
      k := k+1;
      if ( (dati^[k]^.Ti <> 0) and (dati^[k]^.Tipo <>'') ) then
      begin
        if (dati^[k]^.Num = i) then Trovato := true;
      end;
    until Trovato or (k = UltTronco) ;
    if Trovato then StampaLocalizzate(k,nome,nome1,PerditeSi);
  Until i= UltTronco;
End;

{ ************************** CaricaPerditeLoc ************************* }

procedure CaricaPerditeLoc;
var FineSot,Ok      : boolean;
    jj,ii           : integer;

begin
  Transfer_Perd(Drivearc+'archivio.prd','L');
  RetePrinc := false;
  Finesot := false;
  Repeat
    if RetePrinc then
    begin
      Ok := false;
      ExistSottorete(numeroprog1,ok);
      if ok then
      begin
        for jj := 1 to maxsot do
        begin
          for ii := 1 to rit do
          begin
            manrip:=(ii=1);
            LoadDis(driveprog+vprog^[jj].Nome);
            if UltTronco > 1 then Stampaperdite(vprog^[jj].Descr,vprog^[jj].Nome);
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
        LoadDis(numeroProg);
        StampaPerdite(dicitura,'');
      end;
      RetePrinc := true;
    end;
  Until Finesot; {fine delle sottoreti}
end;

{ ************************** PerditeLocalizzate *********************** }

Procedure PerditeLocalizzate(IndiceScelte  : integer);
begin
   AltraPagina(NumPag,nrighe);

   TrovaSottoreti;

   StampaTitolo2;

   CaricaPerditeLoc;

   if ( (IndiceScelte+1) > 4 ) then saltoPag
   else if (buffer.scelte[IndiceScelte+1] = 0 ) then saltopag;
end;

