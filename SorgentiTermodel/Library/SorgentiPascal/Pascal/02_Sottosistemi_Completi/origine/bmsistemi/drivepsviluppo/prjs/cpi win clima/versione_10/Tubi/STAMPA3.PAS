Unit stampa3;

{ *********** OPZIONE DI STAMPA 3 => ELENCO TERMINALI ****************** }

interface
uses
   {crt,
   dos,
   printer,
   print,
   defuti,
   utilitie,}
   {tubivar}definiz,
   iotubi,
   {wP,}
   load,
   UUtigen, LibreriaGenerale;

procedure elencoterminali(IndiceScelte : integer);

{==========================================================================}
implementation



{ *************************** InitTermal ******************************** }

procedure InitTermal;
var i : integer;

begin
 for i := 1 to ultgterm do
  begin
   new(Termal^[i]);
   With Termal^[i]^ do
    begin
      Terminale  := '';
      Tronco     := 0;
      Diametro   := '';
      Portata    := 0;
      Potenza    := 0;
      Perdite    := 0;
      CodPerdite := '';
      Sbilancio  := 0;
      ValvDiam   := '';
      Posizione  := ''; {Taratura}
    end;
  end;

end;

(*

function TrovaPotenza(codice  : st8;var perdita3 : st8) : real;
var k  : integer;
    tr : boolean;
begin
  perdita3 := '';

  k := 0;
  tr := false;

  repeat
    k := k+1;

    if ( UPSTRING(Term_D^[k].Cod) = UPSTRING(Codice) ) then tr := true;

  until tr OR ( k = maxterm);

  if tr then
   begin

     if Term_D^[k].CodPerd  >'' then Perdita3 := Term_D^[k].Codperd;

     TrovaPotenza := Term_D^[k].Pot;
   end
  else trovapotenza := 0;

end;
*)

procedure TrovaPotenza(codice  : st8;var perdita3 : st8;var pot : real);
var k  : integer;
    tr : boolean;
begin
  perdita3 := '';

  k := 0;
  tr := false;

  repeat
    k := k+1;

    if ( UPSTRING(Term_D^[k].Cod) = UPSTRING(Codice) ) then tr := true;

  until tr OR ( k = maxterm);

  if tr then
   begin

     if Term_D^[k].CodPerd  >'' then Perdita3 := Term_D^[k].Codperd;

     Pot := Term_D^[k].Pot;
   end
  else pot := 0;

end;

{ ************************** CaricaTermal ******************************* }

procedure CaricaTermal(Ind1,ind,IndGTerm : integer);
var CodiceP : st8;
    Potenza3: real;
    Moltiplicatore : integer; {se circuito con ritorno la perdita
                               del terminale va raddoppiata}

begin
   if ((Generalita_D^.RITORNO = cyes) and (rit=1)) then Moltiplicatore := 2
   else Moltiplicatore := 1;

   CodiceP := '';
   potenza3:= 0;

   TrovaPotenza(GTerm^[IndGTerm]^. cod,CodiceP,Potenza3);

   With Termal^[ind1]^ do
    begin
      Terminale  := GTerm^[IndGTerm]^.Cod;

      Tronco     := Dati^[ind]^.num;
      Diametro   := dati^[ind]^.coddiam;

      Portata    := GTerm^[IndGTerm]^.Port;

      Potenza    := Potenza3;

      Perdite    := GTerm^[IndGTerm]^.Perd * Moltiplicatore;

      CodPerdite := Upstring(CodiceP);

      Sbilancio  := GTerm^[IndGTerm]^.Sbil;

      ValvDiam   := UPSTRING(GTerm^[IndGTerm]^.Diam);

      Posizione  := GTerm^[IndGTerm]^.taratura; {Taratura}
    end;
  end;

{******************************** CaricaDati *******************************}


procedure CaricaDati(VAR UltimoTerminale : integer);

{..             i => indice di calcrec contiene i dati della rete
    Dati^[i].Term => indice di recGTerm contenente i dati dei terminali ..}


var  i,Ind   : integer;

begin

   Ind := 0;
   i := 0;

   REPEAT
   i := i+1;

   if (Dati^[i]^.Ti <> 0) then
     begin

       if (dati^[i]^.Term <> 0) then
        begin

          if GTerm^[Dati^[i]^.Term]^.NumTer = 0 then
           begin
             Ind := Ind+1;
             CaricaTermal(Ind,i,Dati^[i]^.Term);
           end;

        end;

     end;

   UNTIL i = UltTronco;

   Ultimoterminale := Ind;
end;

{ **************************  StampaElencoTerminali *********************** }


{***************************  StampaIntestazione ****************************}

procedure StampaIntestazione(StampaDicitura : boolean;descr : st50;nomeD : st10);
var totalerighe  : integer;

begin
  if StampaDicitura then
  begin
    Totalerighe := nrighe+LungTXT('Dicitura.prn')+LungTXT('Termal.prn') + 2;
    if Totalerighe > MaxRighe then AltraPagina(NumPag,NRighe);
    descr1.Descr := UpString(Descr);
    if descr = dicitura then
    begin  {rete principale}
  {***    StampaMask(SEG(descr),OFS(descr),'dicitura.prn',true);}
    end
    else
    begin  {sottoreti}
      descr1.nome  := '('+UpString(nomeD);
      descr1.rit:='           )';
{***    StampaMask(SEG(descr1),OFS(descr1),'dicit1.prn',true);}
    end;
    nrighe := nrighe+ LungTXT('Dicitura.prn');
  end;
  Totalerighe := nrighe+LungTXT('Termal.prn') + 2;
  if TotaleRighe > MaxRighe then AltraPagina(NumPag,NRighe);
  WriteTesto('termal.prn');
  nrighe := nrighe+LungTXT('Termal.prn');
end;

{ ************************** OrdinaTerminali ******************************** }

Procedure OrdinaTerminali(UltimoTerm : integer);

type
  Terminali2 = record
      Terminale2 : st8;
      Tronco2    : integer;
      Diametro2  : st8;
      Portata2   : real;
      Potenza2   : real;
      Perdite2   : real;
      CodPerdite2:st8;
      Sbilancio2 : real;
      ValvDiam2  : st8;
      Posizione2 : st8; {Taratura}
    end;


var
  i,k        : integer;
  Scambio    : boolean;
  Com        : terminali2;

procedure Initterminali2;
var j : integer;

begin
   With Com do
    begin
      Terminale2 :='';
      Tronco2    :=0;
      Diametro2  :='' ;
      Portata2   :=0 ;
      Potenza2   :=0 ;
      Perdite2   :=0 ;
      codPerdite2:='';
      Sbilancio2 :=0 ;
      ValvDiam2  :='' ;
      Posizione2 :='' ; {Taratura}
    end;

end;


{ -------------------------- main of OrdinaTerminali  ---------------------- }

begin
   InitTerminali2;

   repeat
    Scambio := False;
    i :=1;
    k :=i+1;

     repeat

      if Termal^[i]^.tronco > Termal^[k]^.tronco then
        Begin

           With Com do
            begin
              Terminale2 := Termal^[i]^.terminale;

              Tronco2    := Termal^[i]^.tronco;     {-Numerazione tronchi -}

              diametro2  := Termal^[i]^.diametro ;

              portata2   := Termal^[i]^.portata ;
              potenza2   := Termal^[i]^.potenza ;
              perdite2   := Termal^[i]^.Perdite;
              codPerdite2:= Termal^[i]^.CodPerdite;
              sbilancio2 := Termal^[i]^.sbilancio;

              valvdiam2  := Termal^[i]^.valvdiam;
              posizione2 := Termal^[i]^.posizione;
            end;




           With Termal^[i]^ do
            Begin
              Terminale  := Termal^[k]^.terminale ;

              Tronco     := Termal^[k]^.tronco ;     {-Numerazione tronchi -}

              diametro   := Termal^[k]^.diametro  ;

              portata    := Termal^[k]^.portata ;
              potenza    := Termal^[k]^.potenza ;
              perdite    := Termal^[k]^.Perdite ;
              codPerdite := Termal^[k]^.CodPerdite;
              sbilancio  := Termal^[k]^.sbilancio ;

              valvdiam   := Termal^[k]^.valvdiam ;
              posizione  := Termal^[k]^.posizione ;
            end;



           With Termal^[k]^ do
            Begin
              Terminale  := Com.terminale2;

              Tronco     := Com.tronco2;     {-Numerazione tronchi -}

              diametro   := Com.diametro2 ;

              portata    := Com.portata2;
              potenza    := Com.potenza2;
              perdite    := Com.Perdite2;
              codPerdite := Com.CodPerdite2;
              sbilancio  := Com.sbilancio2;

              valvdiam   := Com.valvdiam2;
              posizione  := Com.posizione2;
            end;

           Scambio := True;
        end
      else
        begin
           i := i+1;
           k := k+1;
        end;

     Until Scambio OR (i = UltimoTerm);

   Until not Scambio;

End;

{ --------------------- end of OrdinaTerminali---------------------------- }

{ ************************** StampaTermal ******************************** }

Procedure StampaTermal(StampaTipoRete : boolean;Intestazione1 : st50;Intest1 : st10;Ulty : integer);
type  reteF= record

            TerminaleF : st8;
            TroncoF    : st4;
            DiametroF  : st8;
            PortataF   : real;
            PotenzaF   : real;
            PerditeF   : real;
            CodPerditaf: st8;
            SbilancioF : real;
            ValvDiamF  : st8;
            PosizioneF : st8; {Taratura}
        end;

terminaliF= array[1..MAXGTERM] of ^RETEF;


var  i,k       : integer;
     Continua  : boolean;
     Fin       : ^TerminaliF;

{*-*-*-*-*-*-*-*-*-*-*-*-*-* InitFin *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure InitFin;
var i:integer;
begin
   for i:=1 to ultgterm do
   begin
   new(fin^[i]);
   With Fin^[i]^ do
    begin
      Terminalef := '';
      Troncof    := '';
      Diametrof  := '';
      Portataf   := 0;
      Potenzaf   := 0;
      Perditef   := 0;
      CodPerditaf:='';
      Sbilanciof := 0;
      ValvDiamf  := '';
      Posizionef := ''; {Taratura}
    end;
  end;
end;


{*-*-*-*-*-*-*-*-*-*-*-*-*-* CaricaFin *-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*}

Procedure CaricaFin;
var j : integer;

begin

  for j := 1 to Ulty do
  begin

  if Termal^[j]^.tronco <> 0 then
  begin

   with Fin^[j]^ do

    begin
      STR(Termal^[j]^.tronco,Fin^[j]^.troncof); {- Numerazione tronchi -}

      if PercorsoSfavorito then
      begin
        if Sfavorito <> 0 then
          begin
            if (rit=1) then
            begin
              if (Sfavorito = Termal^[j]^.tronco) then Fin^[j]^.Troncof := SetLeft(SetRight(Fin^[j]^.troncoF))+'*';
            end
            else
            if (Sfavorito = Termal^[j]^.tronco) then Fin^[j]^.Troncof := SetLeft(SetRight(Fin^[j]^.troncoF));
          end
        else
          begin
            if (rit=1) then
            begin
              if SfavoritoSot = Termal^[j]^.tronco then Fin^[j]^.troncoF := SetLeft(SetRight(Fin^[j]^.TroncoF))+'*';
            end
            else
             if SfavoritoSot = Termal^[j]^.tronco then Fin^[j]^.troncoF := SetLeft(SetRight(Fin^[j]^.TroncoF));
          end;
      end;

      Terminalef := Termal^[j]^.Terminale;
      Diametrof  := Termal^[j]^.Diametro;
      Portataf   := Termal^[j]^.portata;
      Potenzaf   := Termal^[j]^.Potenza;
      Perditef   := Termal^[j]^.Perdite;
      CodPerditaf:= Termal^[j]^.CodPerdite;
      Sbilanciof := Termal^[j]^.Sbilancio;
      ValvDiamf  := Termal^[j]^.ValvDiam;
      Posizionef := Termal^[j]^.Posizione; {Taratura}

    end;

  end;
  end;
end;



procedure StampaSfavorito;
begin
  if (rit=1) then
  begin
    WriteTesto('Sfavor.prn');
    nrighe := nrighe+LungTXT('Sfavor.prn');
  end;
end;

procedure StampaSfavorito1;
begin
  if (rit=1) then
  begin
    WriteTesto('Sfavor1.prn');
    nrighe := nrighe+LungTXT('Sfavor1.prn');
  end;
end;


begin
  new(Fin);

  Initfin;

  i := 1;
  CaricaFin;


  repeat

    Continua := false;

    StampaIntestazione(StampaTipoRete,Intestazione1,Intest1);

    k := nrighe;


    repeat

       if Fin^[i]^.TroncoF <> '' then
{***          StampaMask(SEG(fin^[i]^),OFS(fin^[i]^),'TermTab.prn',true);}

       i := i+1;
       k := k+1;

    until (i > Ulty) or (k > MaxRighe);

    NRighe := k;

    if ( (k > MaxRighe) and (i<= Ulty) ) then AltraPagina(NumPag,NRighe);

    if (i <= Ulty)then Continua := true
    else Continua := false;

  until not Continua;

  if  PercorsoSfavorito then
    begin
      if NRighe < MaxRighe then StampaSfavorito
      else StampaSfavorito1;
    end;

  Dispose(Fin);
end;


{ **************************  StampaElencoterminali ********************** }

Procedure StampaElencoterminali(TipodiRete : boolean;Intestazione :st50;Intest : st10;Ult : integer);
begin
  if Ult >1 then OrdinaTerminali(Ult);

  StampaTermal(TipoDiRete,intestazione,Intest,Ult);
end;

{ ********************* MainCaricaTermal ******************************* }

procedure MainCaricaTermal;
var jj         : integer;
    ok,FineSot : boolean;
    UltimoTerm : integer;


{ ----------------------- main of mainCaricaTermal ---------------------- }

begin
  UltimoTerm := 0;

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
                 MANRIP:=TRUE;
                 LoadDis(driveprog+vprog^[jj].Nome);
                 if UltTronco > 1 then
                 begin
                    InitTermal;
                    UltimoTerm := 0;
                    caricaDati(UltimoTerm);

                    if ( UpString(SottoreteSfavorita) = UpString(vprog^[jj].nome) ) then
                      begin
                         PercorsoSfavorito := True;
                         SfavoritoSot := Dati^[RisulTCalc^.Sfavor]^.num;
                      end
                    else PercorsoSfavorito := false;

                    If UltimoTerm > 0 then
                       Stampaelencoterminali(True,vprog^[jj].descr,vprog^[jj].nome,UltimoTerm);
                 end;
              end;
           end;
       FineSot := True;  {fine delle sottoreti}
     end
   else
     begin
        MANRIP:=TRUE;
        LoadDis(NumeroProg);

        if UltTronco > 1 then
         begin
           InitTermal;
           UltimoTerm := 0;

           CaricaDati(UltimoTerm);

           CercaSfavorito;

           if Sfavorito <> 0 then PercorsoSfavorito := true
           else PercorsoSfavorito := False;

           If UltimoTerm > 0 then
           Stampaelencoterminali(CiSonoSottoreti,dicitura,'',UltimoTerm);
        end;
        reteprinc := true;
     end;


until FineSot;

end;

{ ----------------------- end of mainCaricaTermal ----------------------- }




{***************************  StampaTitolo  *******************************}

Procedure StampaTitolo;
begin
  WriteTesto('Titolo3.prn');
  nrighe := nrighe+LungTXT('Titolo3.prn');
end;

{ *************************** ELENCOTERMINALI *************************** }
procedure elencoterminali(IndiceScelte : integer);

begin

  Altrapagina(numPag,Nrighe);

  StampaTitolo;

  trovasottoreti;

  mainCaricaTermal;

  if ( (IndiceScelte+1) > 4 ) then saltoPag
  else if (buffer.scelte[IndiceScelte+1] = 0 ) then saltopag;
end;


end.