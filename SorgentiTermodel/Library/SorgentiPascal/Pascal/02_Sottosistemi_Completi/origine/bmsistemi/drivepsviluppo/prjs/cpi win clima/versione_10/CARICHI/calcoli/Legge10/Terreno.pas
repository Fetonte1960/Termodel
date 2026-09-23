unit terreno;

interface
uses variabiligenerali,libreriagenerale,Varcarichi,metodL10,Uvariabili,
     Math, UtiReport, SysUtils, URicercaDati;

Type
    ElemParete = Record
                   CodiceParete: String;
                   NumPresenzeAmb: Integer;
                  end;


Procedure stampaPavSuTer; // inserire nelle procedure lanciate finestre
// Emanuela e Fabio 16-7-2004 Inserite le funzioni per il calcolo della
// superficie netta del pavimento che scambia sul terreno
Function SuperficiePavimento(ZonCalc: Integer; CodiceConfine: String): double;
Function SpessoreParete(CodiceParete: String): Double;

// Emanuela e Fabio 16-7-2004 Funzione per il calcolo del
// perimetro esposto netto del pavimento che scambia sul terreno
Function PerimetroEsposto(ZonCalc: Integer; CodiceConfine: String): Double;
Function VolumeZonaT(ZonCalc: Integer; CodiceConfine: String): Double;
Function ParetePrevalente(CodiceConfine: String): String;
Function CalcoloHg(ind :integer) : real;

implementation
uses UCompilaFrontiere;

function cercaprov(prov:string;var vvent:real;var zv:smallint):smallint;
var
  trovato:boolean;
  i,j:smallint;
  PROVA,PROVB:STRING;
begin
  i:=0;
  prova:=formst(prov);
  repeat
    i:=i+1;

    provb:=formst(prv^[i].nome);
    trovato:=prova=provb;
  until trovato or (i=maxlung);

  if trovato then
  begin
    vvent:=prv^[i].omega;
    //zv:=prv^[i].zv;
    // Emanuela 31/10/2005: mi sono accorta che non c'era nessun valore settato
    // in prv^[i].zv, per cui ho preso quello presente nei dati di progetto relativo
    // alla provincia di riferimento
    zv:=Prog^.Zonavent;
    cercaprov:=i;
  end;
end;

procedure dativento;
const zvconst:array['A'..'E',1..9] of smallint=((3,2,1,1,2,2,3,3,4),
                                               (2,0,1,2,2,3,3,4,4),
                                               (3,0,2,2,3,3,3,4,4),
                                               (3,0,3,3,3,4,4,4,4),
                                               (4,0,3,3,3,4,4,4,4));

      constc:array[1..4,1..4] of real=((1,1.78,2.78,4),
                                       (0.562,1,1.56,2.25),
                                       (0.36,0.64,1,1.44),
                                       (0.25,0.445,0.694,1));
var c1,c2,indp,zonadivento:smallint;
    c3,vven:real;
begin
   indp:=cercaprov(prog^.comunerif,vven,zonadivento);
  if formst(prog^.comune)<>formst(prog^.comunerif) then
  begin
  c2:=2;
  if prog^.distmar<=20 then c2:=1;
  if (prog^.distmar>20) and (prog^.distmar<=40) and (prog^.regvento[1]='A') then c2:=2;
  if ((prog^.distmar>20) and(prog^.regvento<>'A')) or ((prog^.regvento='A') and (prog^.distmar>40)) then
  begin
    if (prog^.altcom<=300) then c2:=3;
    if (prog^.altcom>300) and  (prog^.altcom<=500) then c2:=4;
    if (prog^.altcom>500) and  (prog^.altcom<=800) then c2:=5;
    if (prog^.altcom>800) and  (prog^.altcom<=1200) then c2:=6;
    if (prog^.altcom>1200) and (prog^.altcom<=1500) then c2:=7;
    if (prog^.altcom>1500) and (prog^.altcom<=2000) then c2:=8;
    if (prog^.altcom>2000) Then c2:=9;
  end;

  c1:=zvconst[upcase(prog^.regvento[1]),c2];
  c3:=constc[zonadivento,c1];
  velocitavento:=vven*c3;
  end
  else
  velocitavento:=vven;
end;


{-----------------------------------------------------------------------------
  Procedure: CalcoloHg
  Author:    e.diquattro
  Date:      26-gen-2006
  Arguments: ind :integer
  Result:    real

  Cosa fa: Coefficiente di accoppiamento termico in regine stazionario
-----------------------------------------------------------------------------}
Function CalcoloHg(ind :integer) : real;
const  pgreco = 3.142;
var DdT,UUo,DDelta,Hg,UU,UUf,UUw,pp,LLTerr : real;
    Tipo,IndPiante                         : integer;
    disegno                                : string;
    FinePiante                             : boolean;

{************ Procedure e funzioni interne al calcolodi HG per i pavimenti su terreno *****************}
    { ......................... Calcolo _W ............................. }
    {-----------------------------------------------------------------------------
      Procedure: Calcolo_W
      Author:    e.diquattro
      Date:      24-gen-2006
      Arguments: i:integer;var W1:real
      Result:    None

      Cosa fa:  calcolo dello spessore delle pareti perimetrali esterne dell'edificio
    -----------------------------------------------------------------------------}

    procedure Calcolo_W(i:integer; var W1:real);
    var j: integer;
        fine: boolean;
    begin
      fine:= false;
      j:=0;
      repeat
        j:=j+1;
        if (Strutture_D^[I]^.strati[j].nfile > '') then
            W1  := W1 + Strutture_D^[I]^.strati[j].spessore
        else Fine:=true;
      until fine or (j=maxstrati);
    end;

    { ........................... CalcoloUo ............................... }

    {-----------------------------------------------------------------------------
      Procedure: CalcoloUo
      Author:    e.diquattro
      Date:      24-gen-2006
      Arguments: dt:real
      Result:    real

      Cosa fa: Calcola la trasmittanza termica per pavimento su terreno (Uni 10346)
               Uo = Lambda / (0,457 + B1 + dt)
               dove:
               Lambda è la conduttività termica del terreno
               B1 è la dimensione caratteristica del pavimento
               dt è lo spessore equivalente totale
    -----------------------------------------------------------------------------}
    Function CalcoloUo(dt:real): real;
    var  B, W, Uo, LTerr : real;
         Code, IndPav  : integer;
    begin
      B:=0;
      w:=0;
      Uo :=0;
      LTerr :=0;

      indpav:=PavSuTer^[Ind].codpav;
      begin
        LTerr := PavSuter^[Ind].LambdaTerr;    //conduttività termica del terreno
        {dimensione caratteristica del terreno
         PavSuTer^[ind].Area: area del terreno
         PavSuTer^[ind].Perimetro: Perimetro sul terreno
         B = Area/ 1/2 * Perimetro}
        if PavSuTer^[ind].Perimetro <> 0 then
           B := PavSuTer^[ind].Area/ (1/2 * PavSuTer^[ind].Perimetro)
        else B := 0;

        Calcolo_W(IndPav,W); { spessore pareti perimetrali esterne dell'edificio}
      { Pavimenti ben isolati ==> dT > B  oppure  Pavimenti non isolati o moderatamente isolati ==> dT < B }
         Case Tipo of
          1,2,3 :begin
                   if dT > B then Uo := LTerr / ( 0.457 * B + dT)
                   Else Uo := ( (2 * LTerr) / (pgreco * B + dT) ) * Ln( (pgreco*B/dT) + 1 );
                 end;
              4 :begin
                   Uo := ( (2 * LTerr) / (pgreco * B + dT) ) * Ln( (pgreco*B/dT) + 1 );
                 end;
         end;
       End;
       CalcoloUo := Uo;
    end;


    {-----------------------------------------------------------------------------
      Procedure: CoefficienteDelta
      Author:    e.diquattro
      Date:      25-gen-2006
      Arguments: Tipo : Integer;dT : real
      Result:    real

      Cosa fa:  calcola il fattore di correzione relativo al tipo di isolamento
                di bordo
    -----------------------------------------------------------------------------}
    Function CoefficienteDelta(Tipo : Integer;dT : real): real;

    Function Delta: real;
    var  LIs,LTerr,DDis,R,DD  : real;
         IndPav               : integer;
    begin
      Delta:=0;

      R:=0;
      LIs:=0;
      LTerr:=0;
      DD :=0;
      DDis:=0;
      IndPav:=0;

      LIs := PavSuTer^[Ind].LambdaIs;    //conduttività termica dell'isolante
      LTerr:= PavSuTer^[ind].LambdaTerr; //lambda del terreno
      DDIs := PavSuTer^[Ind].DIs;        //spessore strato perimetrale dell'isolante
      DD := PavSuTer^[Ind].D;      {EpsonOrD;} // è la larghezza dell'isolamento di bordo
      {resistenza termica addizionale introdotta dall'isolamento di bordo orizzontale, cioè
       la differenza tra la resistenza termica dell'isolamento di bordo e quella della parte
       di suolo o di lastra rimpiazzata dall'isolamento}
      R := ( (DDIs/LIs)-(DDIs/LTerr) );

      case tipo of
       2 : begin  {Isolamento perimetrale Orizzontale}
             Delta := - (LTerr/Pgreco) * ( Ln( (DD/dT)+1)- Ln( (DD/(dT+ R*LTerr)) +1 ) );
           end;

       3 : begin  {Isolamento perimetrale Verticale}
             Delta := - (LTerr/PGreco)* ( Ln( (2*DD/dT)+1 ) - Ln( ( (2*DD)/(dT+R*LTerr) )+1 ) );
           end;
      end;

    end;

    { ............... main of CoefficienteDelta ............... }
    begin
      Case Tipo of
          1 : CoefficienteDelta := 0;
        2,3 : CoefficienteDelta := Delta;
      end;
    end;


    {-----------------------------------------------------------------------------
      Procedure: CalcoloU
      Author:    e.diquattro
      Date:      25-gen-2006
      Arguments: Ug,DT:real
      Result:    real

      Cosa fa: Per i pavimenti si spazio aerato, nel calcolo della Hg è necessario
               calcolare U che è la trasmittanza termica globale
               u = 1/(1/Up) + (1/Ux)
               dove Up: trasmittanza termica del pavimento al di sopra dello spazio
                        aerato
                    Ux: trasmittanza termica equivalente tra lo spazio aerato e
                        l'ambiente esterno
    -----------------------------------------------------------------------------}
    Function CalcoloU(Ug,DT:real) : real;
    var U,Uf,Ux,B,LTerr,Uw,p,KEpson,Fw,V : real;
        IndPav,Code,IndPar,IndPos,ps1,ps2:integer;
    begin
      U :=0;
      Uf:=0;
      Ux:=0;
      Uw:=0;
      B:=0;
      p:=0;
      LTerr :=0;
      KEpson :=0;
      Fw :=0;
      V := 0;
      Indpav:= PavSuTer^[Ind].CodPav;
      begin
         B := PavSuTer^[ind].Area/ (1/2 * PavSuTer^[ind].Perimetro);  //dimensione caratteristica del pavimento
         LTerr := PavSuter^[Ind].LambdaTerr;  //Lambda del terreno
         p:= PavSuTer^[Ind].H;    //altezza del pavimento sul livello del terreno esterno

         POb_a^.SettaMuroCor(indpav);
         uf:=Pob_A^.k_F;   //trasmittanza termica del pavimento al di sopra dello spazio aerato

         KEpson := PavSuTer^[Ind].Epson;  {EpsonOrD;}
         Prog^.CodUb:=formst1(Prog^.CodUb);
         //indpos:=pos_combo(drivecombo,'Fabbricato','CodUb',Prog^.CodUb);
         indpos := IndFabbricatoCodUb(Prog^.CodUb);
         // coefficiente di protezione del vento
         case indpos of
          {$IFDEF VERSIONE_13}
            3: fw := 0.10; { zone rurali}
            2: fw := 0.07; { periferia }
            1: fw := 0.04; { centro citta` }
          {$ELSE}
            3: fw := 0.10; { zone rurali}
            2: fw := 0.05; { periferia }
            1: fw := 0.02; { centro citta` }
          {$ENDIF}
         end;
         dativento;
         V := velocitavento;  //velocità media del vento
         { Uw => kx }
         IndPar:=PavSuTer^[Ind].CodMuro;

         POb_a^.SettaMuroCor(IndPar);
         Uw :=Pob_A^.k_F; {Strutture_d^[IndPar]^.Trasmitt} {CalcoloUw_Kx}

         Ux := Ug + (2*p * Uw /B) + 1450 * KEpson * V * Fw /B;
         U := 1 / ( 1/Uf + 1/Ux );
       end;
       CalcoloU:=U;
    end;

    {-----------------------------------------------------------------------------
      Procedure: CalcoloNewU
      Author:    e.diquattro
      Date:      25-gen-2006
      Arguments: Ug,DT:real
      Result:    real

      Cosa fa: Per i pavimenti interrati non riscaldati o parzialmente ruscaldati
               calcolare U che è la trasmittanza termica globale
               u = 1/(1/Up) + (A/AUbf + zPUbf+hPUw+033nV)
               dove Up: trasmittanza termica del pavimento al di sopra dello spazio
                        aerato
                    Ux: trasmittanza termica equivalente tra lo spazio aerato e
                        l'ambiente esterno
    -----------------------------------------------------------------------------}
    Function CalcoloNewU(Ubf, Ubw: real) : Real;
    var U, Uf, B, Uw, p, z, Fw, n, valint : Real;
        IndPav, IndPar: Integer;
    begin
      U :=0;
      Uf:=0;
      Uw:=0;
      B:=0;
      p:=0;
      Fw :=0;
      z := 0;
      n := 0;
      Indpav:= PavSuTer^[Ind].CodPav;
      begin
         B := PavSuTer^[ind].Area/ (1/2 * PavSuTer^[ind].Perimetro);  //dimensione caratteristica del pavimento
         p := PavSuTer^[Ind].H;               //altezza del pavimento sul livello del terreno esterno
         z := PavSuTer^[Ind].Z;               //profondità del pavimento del piano interrato rispetto al livello del terreno
         n := PavSuTer^[Ind].PortataAr;
         POb_a^.SettaMuroCor(indpav);
         uf := Pob_A^.k_F;   //trasmittanza termica del pavimento al di sopra dello spazio aerato
         IndPar:=PavSuTer^[Ind].CodMuro;

         POb_a^.SettaMuroCor(IndPar);
         Uw :=Pob_A^.k_F; {Strutture_d^[IndPar]^.Trasmitt} {CalcoloUw_Kx}
         ValInt := (PavSuTer^[Ind].Area* Ubf + z*PavSuTer^[Ind].Perimetro*Ubw + p*PavSuTer^[Ind].Perimetro*Uw + 0.33*n*PavSuTer^[Ind].Volume);

         U := 1 / ( 1/Uf + PavSuTer^[Ind].Area/ValInt);
       end;
       result := U;
    end;
  {-----------------------------------------------------------------------------
    Procedure: CalcoloDT
    Author:    e.diquattro
    Date:      26-gen-2006
    Arguments: Cmuro,cpav,tipo : integer
    Result:    real

    Cosa fa: Calcolo dello spessore equivalente del terreno
  -----------------------------------------------------------------------------}
  Function CalcoloDT(Cmuro,cpav,tipo : integer):real;
  var W,LTerr,SommaR,dt,trasm : real;
      Id,code           : integer;
  begin
      {Formula === > dT :=  w + LTerr* (Rsi+Rp+Rse);}

      w:=0;
      dt:=0;
      sommaR:=0;
      LTerr:=0;
      id:=cmuro;
      begin
        Calcolo_W(Id,W); {calcolo spessore}
        LTerr := PavSuTer^[Ind].LambdaTerr;
      (*
        Rsi:= 1/Strutture_D^[Indice].Hi; {adduttanza interna}
        Rse:= 1/Strutture_D^[Indice].He; {adduttanza esterna}
        Rp := (1/Strutture_D^[Indice].Trasmitt) - Rsi - Rse;
        dT := W + LTerr * (Rsi+Rp+Rse);
        *)
        if Tipo = 1 then
        begin
          trasm:=1/(1/7.7+1/25);
        end
        else
         begin
            POb_a^.SettaMuroCor(cpav);
            Trasm:=Pob_A^.k_F;   {Strutture_D^[Id]^.Trasmitt;}
         end;
        if trasm <> 0 then
        dT := W + LTerr * (1/Trasm);
      end;
      calcoloDt := Dt;
  end;

 {-----------------------------------------------------------------------------
    Procedure: CalcoloUf
    Author:    e.diquattro
    Date:      26-gen-2006
    Arguments: var p,dt,Lterr : real
    Result:    real

    Cosa fa: calcola la trasmittanza termica del pavimento al di sopra
             dello spazio aereato
  -----------------------------------------------------------------------------}
  Function CalcoloUf(var p,dt,Lterr : real) : real;
  var Uf,B  : real;
  begin
     Uf := 0;
     B  := 0;
     p  := 0;
     dT := 0;
     LTerr:=0;

     LTerr:= PavSuTer^[Ind].LambdaTerr;
     B := PavSuTer^[ind].Area / ( (1/2) * PavSuTer^[ind].Perimetro); //dimensione caratteristica del terreno
     p := PavSuTer^[ind].Z;    //profondità del pavimento al di sotto del livello del terreno esterno
     Dt:= CalcoloDt(pavSuTer^[Ind].CodMuro,pavSuTer^[Ind].CodPav,0); //spessore equivalemte totale del pavimento

     if ( dT + p/2 ) < B  then {pavimenti non isolati o moderatamente isolati }
         Uf := ( (2 * LTerr) / (pgreco * B + dT + p/2) ) * Ln( ( (pgreco * B) / (dT + p/2))+1)
     else  { Pavimenti ben Isolati }
         Uf := Lterr / (0.457 * B + dT + p/2);

     CalcoloUf := Uf;
  end;

  {-----------------------------------------------------------------------------
    Procedure: CalcoloUw
    Author:    e.diquattro
    Date:      26-gen-2006
    Arguments: p,Dt,LTerr: real
    Result:    real

    Cosa fa: calcolo trasmittanza termica delle pareti interrate
  -----------------------------------------------------------------------------}
  function CalcoloUw(p,Dt,LTerr: real) : real;
  var dW,Uw : real;

  begin
     dW := 0;
     Uw := 0;
     dW := CalcoloDT(PavSuTer^[ind].CodMuro,pavSuTer^[Ind].CodMuro,0);
     if p <> 0 then
        Uw := ( (2 * LTerr) / ( pgreco * p )) * (1+ ( (dT/2) / (dT+p) )) * Ln( (p/dW)+1 )
     else Uw := 0;
     CalcoloUw :=Uw;
  end;

{************ Procedure e funzioni interne al calcolodi HG per i pavimenti su terreno *****************}

{ ........................ MAIN CALCOLOHG ........................ }
begin

{ 1 ==>  Pavimenti su terreno non Isolato o unform. Isolato;
  2 ==>    "        "    "    con isolamento Perimetr. Orizzontale
  3 ==>    "        "    "    con isolamento Perimetr. Verticale
  4 ==>    "        su spazio aerato
  5 ==>  Pavimenti  su piano interrato
  6 ==>  Pavimenti interrati non riscaldati o parzialmente riscaldati}

  DdT :=0;
  UUo :=0;
  DDelta:=0;
  Hg:= 0;
  UU:=0;
  UUf:=0;
  UUw:=0;
  pp:=0;
  LLTerr:=0;

  Tipo := PavSuTer^[Ind].Tipo;

  Case tipo OF
    1,2,3 : begin
              DdT := CalcoloDt(PavSuTer^[Ind].CodMuro,pavSuTer^[Ind].CodPav,0);
              UUo := calcoloUo(DdT);
              DDelta := CoefficienteDelta(Tipo,DdT);
              Hg := ( UUo * PavSuTer^[Ind].Area + DDelta * PavSuTer^[Ind].Perimetro);
            end;
        4 : begin
              DdT := CalcoloDt(PavSuTer^[Ind].CodMuro,pavSuTer^[Ind].CodPav,1);
              UUo := CalcoloUo(DdT);
              UU := calcoloU(UUo,DdT);
              Hg := UU * PavSuTer^[Ind].Area;
            end;

        5 : begin
              UUf := CalcoloUf(pp,dDt,LLTerr);
              UUw := CalcoloUw(pp,dDt,LLTerr);
              Hg  := PavSuTer^[Ind].area * UUf + pp * PavSuTer^[Ind].Perimetro * UUw;
            end;
       //Nuovo caso per la norma 13370 sul Terreno   
        6:  begin
              DdT := CalcoloDt(PavSuTer^[Ind].CodMuro,pavSuTer^[Ind].CodPav,1);
              UUf := CalcoloUf(pp,dDt,LLTerr);
              UUw := CalcoloUw(pp,dDt,LLTerr);
              UU := CalcoloNewU(UUf, UUw);
              Hg := PavSuTer^[Ind].Area * UU;
            end;
  End;
  CalcoloHg := Hg;
end;


Procedure stampaPavSuTer;
var
  i: Smallint;

  function TrovaESpP(Cod:string):string;
  var trovato:boolean;
      i:smallint;
  begin
     Cod:=formst(Cod);
     i:=1;
     repeat
         Trovato:=Cod=Formst(esposizioni_d^[i].CodPav);
         if not Trovato then i:=i+1;
     until Trovato  or (i > maxEsposizioni);
     if trovato then TrovaEsPp:=esposizioni_d^[i].denom
     else TrovaEsPp:=' ';
  end;

{ main }

begin
  NPavsuTer:=0;
  for i:=1 to NCOnfini do
  begin
    if Upcase(confine_d^[i].tipoConfine[1])='T' then
    begin
      inc(NPavsuTer);
      //pavsuter^[NPavsuTer].Tipo:=pos_combo(drivecombo,'Confine','TipoP',TipoP);
      pavsuter^[NPavsuTer].Tipo       := IndConfineTPavimenti(confine_d^[i].TipoP);
      pavsuter^[NPavsuTer].Codice     := confine_d^[i].Codice;
      pavsuter^[NPavsuTer].LambdaTerr := confine_d^[i].LambdaTerr;
      pavsuter^[NPavsuTer].H          := confine_d^[i].H;
      pavsuter^[NPavsuTer].Epson      := confine_d^[i].Epson;
      pavsuter^[NPavsuTer].D          := confine_d^[i].D;
      pavsuter^[NPavsuTer].Z          := confine_d^[i].Z;
      pavsuter^[NPavsuTer].Dis        := confine_d^[i].Dis;
      pavsuter^[NPavsuTer].LambdaIs   := confine_d^[i].LambdaIs;
      pavsuter^[NPavsuTer].Hg         := confine_d^[i].Hg;
      if pavsuter^[NPavsuTer].Area = 0 then
         pavsuter^[NPavsuTer].Area := SuperficiePavimento(ZonaCalc, confine_d^[i].Codice);
      if pavsuter^[NPavsuTer].Perimetro = 0 then
         pavsuter^[NPavsuTer].Perimetro := PerimetroEsposto(ZonaCalc, confine_d^[i].Codice);
      if pavsuter^[NPavsuTer].Volume = 0 then
         pavsuter^[NPavsuTer].Volume := VolumeZonaT(ZonaCalc, confine_d^[i].Codice);
      if  pavsuter^[NPavsuTer].Tipo in [1..5] then
      begin
        // Emanuela e Fabio 16-07-2004 inserito il calcolo automatico della parete prevalente,
        // in modo da evitare la scelta manuale da parte dell'utente quando definisce il confine
        // su Terreno.
        if confine_d^[i].SiglaMuro = '' then
           confine_d^[i].SiglaMuro := ParetePrevalente(confine_d^[i].Codice);
        pavsuter^[NPavsuTer].CodMuro := Codicepar(confine_d^[i].SiglaMuro);
        pavsuter^[NPavsuTer].CodPav  := Codicepar(confine_d^[i].SiglaMuro);
      end;
    end;
    prn_TotH^.HTerreno := 0;
  end; {For che scorre i confini}

  InizioTabella('TABCARATT_SCAMB_TERRENO', 10);
  for i:=1 to NPavsuTer do
  begin
    if (pavsuter^[i].Area <> 0) and (pavsuter^[i].Perimetro <> 0) then
    begin
        pavsuter^[i].hg := CalcoloHg(i);
        // -----------------------------------------------------------------------
        // Stampa
        // Tabella CARATTERISTICHE ELEMENTI CHE SCAMBIANO CON IL TERRENO UNI 10346
        // -----------------------------------------------------------------------
         if pavsuter^[i].Hg <> 0 then
         begin
           WRealeTab(pavsuter^[i].Tipo,0);
           WStrTab(pavsuter^[i].Codice);
           WStrTab(Strutture_d^[pavsuter^[i].CodMuro]^.Descr);
           WRealeTab(pavsuter^[i].Area,1);
           WRealeTab(pavsuter^[i].Perimetro,2);
           WRealeTab(pavsuter^[i].LambdaTerr,3);
           WRealeTab(pavsuter^[i].D,1);
           WRealeTab(pavsuter^[i].Dis,1);
           WRealeTab(pavsuter^[i].LambdaIs,2);
           WRealeTab(pavsuter^[i].Hg,2);
         end;
       prn_TotH^.HTerreno := prn_TotH^.HTerreno + pavsuter^[i].HG;
       FinerigaTabella;
    end;
  end; {For che stampa i dati del terreno}
  finetabella;
end;

{-----------------------------------------------------------------------------
  Procedure: SpessoreParete
  Author:    e.diquattro
  Date:      26-gen-2006
  Arguments: CodiceParete: String
  Result:    Double
  
  Cosa fa: Emanuela e Fabio 16-7-2004 funzione che restituisce lo
           spessore della parete
-----------------------------------------------------------------------------}
Function SpessoreParete(CodiceParete: String): Double;
var
  i: Integer;
begin
  Result := 0;
  For i := 1 to NStrutture do
    if UpperCase(Strutture_D^[i].NFile) = UpperCase(CodiceParete) then
    begin
       Result := Strutture_D^[i].SpessoreParete / 100;
       exit;
    end;
end;

{-----------------------------------------------------------------------------
  Procedure: SuperficiePavimento
  Author:    e.diquattro
  Date:      26-gen-2006
  Arguments: ZonCalc: Integer
  Result:    double
  
  Cosa fa: Emanuela e Fabio Funzione che calcola superficie netta del
           pavimento su terreno
-----------------------------------------------------------------------------}
Function SuperficiePavimento(ZonCalc: Integer; CodiceConfine: String): double;
var
  I, J: Integer;
  SupPavimentoNetta, SuperficeDiv, SupAmb: Double;
begin
  Result := 0;
  SupPavimentoNetta := 0;
  for i := 1 to NAmbienti do
  begin
   if Ambienti_D^[i].Z10 = ZonCalc then
   begin
    if UpperCase(Ambienti_D^[i].C_Pav) = UpperCase(CodiceConfine) then
    begin
      SupAmb := Ambienti_D^[i].Superficie;
      for j := 1 to Ambienti_D^[i].NPar do
      begin
        if UpperCase(Ambienti_D^[i].Par[j].Confine) = UpperCase('Divisori') then
        begin
          SuperficeDiv := Ambienti_D^[i].Par[j].Num * (SpessoreParete(Ambienti_D^[i].Par[j].Cod) / 2);
          SupAmb := SupAmb - SuperficeDiv;
        end;
      end;
      SupPavimentoNetta := SupPavimentoNetta + SupAmb;
    end;
   end; {end if anbiente della zona}
  end;{end for}
  Result := SupPavimentoNetta;
end;

{-----------------------------------------------------------------------------
  Procedure: PerimetroEsposto
  Author:    e.diquattro
  Date:      26-gen-2006
  Arguments: ZonCalc: Integer
  Result:    Double

  Cosa fa:
-----------------------------------------------------------------------------}
Function PerimetroEsposto(ZonCalc: Integer; CodiceConfine: String): Double;
var
  I, J: Integer;
  PerPavimentoNetta, Perimetro: Double;
begin
  Result := 0;
  PerPavimentoNetta := 0;
  for i := 1 to NAmbienti do
  begin
   Perimetro := 0;
   if Ambienti_D^[i].Z10 = ZonCalc then
   begin
    if UpperCase(Ambienti_D^[i].C_Pav) = UpperCase(CodiceConfine) then
    begin
      for j := 1 to Ambienti_D^[i].NPar do
      begin
        if UpperCase(Ambienti_D^[i].Par[j].Confine) <> UpperCase('Divisori') then
        begin
          Perimetro := Perimetro + Ambienti_D^[i].Par[j].Num;
        end
        else
        begin
          Perimetro := Perimetro - (SpessoreParete(Ambienti_D^[i].Par[j].Cod));
        end;
      end;
      PerPavimentoNetta := PerPavimentoNetta + Perimetro;
    end;
   end; {end if ambiente della zona}
  end;{end for}
  Result := PerPavimentoNetta;
end;

{-----------------------------------------------------------------------------
  Procedure: Volume
  Author:    e.diquattro
  Date:      28-set-2006
  Arguments: ZonCalc: Integer; CodiceConfine: String
  Result:    Double
  
  Cosa fa:
-----------------------------------------------------------------------------}
Function VolumeZonaT(ZonCalc: Integer; CodiceConfine: String): Double;
var
  I: Integer;
  Vol: Double;
begin
  Result := 0;
  Vol := 0;
  for i := 1 to NAmbienti do
  begin
   if Ambienti_D^[i].Z10 = ZonCalc then
   begin
    if UpperCase(Ambienti_D^[i].C_Pav) = UpperCase(CodiceConfine) then
    begin
      Vol := Vol + (Ambienti_D^[i].Superficie * Ambienti_D^[i].HSoffitto);
    end;
   end; {end if ambiente della zona}
  end;{end for}
  Result := Vol;
end;

{-----------------------------------------------------------------------------
  Procedure: ParetePrevalente
  Author:    e.diquattro
  Date:      26-gen-2006
  Arguments: None
  Result:    String

  Cosa fa:
-----------------------------------------------------------------------------}
Function ParetePrevalente(CodiceConfine: String): String;
var i, j, n, k: integer;
    ListaPareteAmb: Array of ElemParete;
    Esiste: Boolean;
    TempElem: ElemParete;
begin
  Result := '';
  if NStrutture <> 0 then
  begin
    setlength(ListaPareteAmb, NStrutture);
    n := 0;

    for i := 1 to NStrutture do
     begin
      ListaPareteAmb[n].CodiceParete := Strutture_D^[i].NFile;
      ListaPareteAmb[n].NumPresenzeAmb := 0;
      inc(n);
     end;

    for i := 1 to NAmbienti do
    begin
      if UpperCase(Ambienti_D^[i].C_Pav) = UpperCase(CodiceConfine) then
      begin
       for j := 1 to Ambienti_D^[i].NPar do
        begin
          if UpperCase(Ambienti_D^[i].Par[j].Confine) <> UpperCase('Divisori') then
          begin
           for k := 0 to n-1 do
            begin
             if UpperCase(ListaPareteAmb[k].CodiceParete) = UpperCase(Ambienti_D^[i].Par[j].Cod) then
               begin
                Inc(ListaPareteAmb[k].NumPresenzeAmb);
               end;
            end;
          end;
        end;
      end;
    end;
   TempElem.CodiceParete := ListaPareteAmb[0].CodiceParete;
   TempElem.NumPresenzeAmb := ListaPareteAmb[0].NumPresenzeAmb;
   for k := 0 to n-1 do
    begin
     if ListaPareteAmb[k].NumPresenzeAmb > TempElem.NumPresenzeAmb then
      begin
       TempElem.CodiceParete := ListaPareteAmb[k].CodiceParete;
       TempElem.NumPresenzeAmb := ListaPareteAmb[k].NumPresenzeAmb;
      end;
     end;
  setlength(ListaPareteAmb, 0);
  Result := tempElem.CodiceParete;
 end; 
end;

end.
