unit UVariabili;

interface

uses SysUtils, varcarichi;

const
   CH12 = 'GENNAIO';
   CH13 = 'FEBBRAIO';
   CH14 = 'MARZO';
   CH15 = 'APRILE';
   CH16 = 'MAGGIO';
   CH17 = 'GIUGNO';
   CH18 = 'LUGLIO';
   CH19 = 'AGOSTO';
   CH20 = 'SETTEMBRE';
   CH21 = 'OTTOBRE';
   CH22 = 'NOVEMBRE';
   CH23 = 'DICEMBRE';
   CH7  = 'E';   {ESTERNO}
   CH8  = 'I';   {INTERNO}
   mesirisc_St  = 7;
   maxLungr     = 101;
   maxfrontiere1= 500;
   maxepiante   = 50;
   maxponti     = 200;
   Maxfac       = 100;
   MEsp         = 6;
   MaxPoint     = 16380;
   MaxTempAc    = 30;
   Maxtubaz     = 20;
   maxtt        = 50;
   maxE         = 50;
   maxCapTermica= 500;
  

type
   // Emanuela  record usato per l'articolo sette
   RecArticolo7 = record
                     Mese       : string[10];
                     RadSolare  : real;
                     AppInt     : real;
                     FabbReale  : real;
                     ValArt7    : real;
                  end;
   // Emanuela
   // Caricamento dei piani in questo record per il calcolo delle altezze
   RecPiante = record
                NomeP  : STRING[20];
                ZMin   : real;
                ZMax   : real;
               end;
   // Caricamento dei dati di facciata per il calcolo degli aggetti
   RecFacciata=record
                 cod            :string[8];
                 Frontale       :string[30];
                 Ang            :real;
                 DistFront      :real;
                 ProfFront      :real;
                 LateraleDestro :string[30];
                 DistDestro     :real;
                 ProfDestro     :Real;
                 LateraleLeft   :string[30];
                 DistLeft       :real;
                 ProfLeft       :real;
                 Orizzontale    :string[30];
                 DistOrizz      :real;
                 ProfOrizz      :real;
               end;
    // Record che contiene alcune informazioni di calcolo
    recstr10 = record
                  ka, kn, hi, he: real;
               end;
    // Record per le informazioni del calcolo delle zone
    RectabZona = record
                    nag1, ndg1: real;
                    Dsb: string[15];
                    k: real;
                    term: string[55];
                    a, b, fil1, fig1, t1, t2, goff, nag2, ndg2: real;
                 end;
    // record contenete una funzione per i ponti termici
    dati_Ponti= object
                   function K(Cod:Integer): real;
                end;
    // record dati calcolo generatore
    RecGenerat = record
                    Cp, Pf1, Pd1, Pfbs1, Fc, ETu, Etu100, Etu30, Qc, Qe: real;
                    DtH20Zona, Qpo1, Qbr1, Ta, cop: real;
                 end;
    // record con informazioni sul calcolo
    F_Tot_Gen = record
                  HOpaEst:real;
                  HTraspEst:real;
                  HPontEst:real;
                  HLocNR:real;
                  HVent:real;
                  HTerreno:real;
                  HTotZona:real;
                end;
    // verificare che informazione dovrebbe contenere
    rectac = record
              descr:string[40];
              cod:string[8];
              temp:array[1..12] of real;
             end;
    // verificare che informazione dovrebbe contenere
    stperm = record
               cod: smallint;
               desc: string[20];
               Num: smallint;
               Lun, Ltot, V, v_l: real;
               ArUn, ArTot, m, m_a, Ktot: real;
             end;

    strreal = record
                R1, R2, R3, R4, R5:real;
              end;

    Str3 = record
             schermo: string[25];
             ClSer:   string[20];
             Ric:     real;
           end;

   { ... Finestre e pareti trasparenti esterne ..}
    Fin_PTrasp = record
                  cod     : Smallint;
                  //descr   : string[20];
                  Descr   : String[100];
                  Esp     : string[20];
                  Piano   : Smallint;
                  PianoAmb   : String[30];
                  Num     : Smallint;
                  Area    : real;
                  k       : real;
                  Ht      : real;
                  alt     : real;
                  XA      : real;
                  fo      : real;
                  fa      : real;
                  Aei     : real;
                  TotHt   : real;
                  TotGenHt: real;         {Aggiunto per conteggiare il totale Ht}
                 end;

    {esposizioni interne con locali a temp.fissa }
    EspLocF = record
               Esp      : string[20];
               Tipo     : string[15];
               cod      : Smallint;
               Descr    : String[100];
               k        : real;
               Num      : Smallint;
               SupLord  : real;
               SupNetta : real;
               Lung     : real;
               Ht       : real;
               TotHt    : real; 
               TotGenHt : real;
              end;

    {... Frontiere Esterne Opache ...}
    F_Est_Opache = record
                    Cod         :Smallint;      {dati parete}
                    Descr       :String[100];
                    Esp         :string[20];
                    SupLord     :real;
                    SupNetta    :real;
                    K           :real;          {dispersioni}
                    Ht          :real;
                    fer         :real;          {irraggiamento}
                    fo          :real;
                    Fa          :real;
                    aei         :real;
                    TotHt       :real;
                    TotGenHt    :real;         {Aggiunto per conteggiare il totale Ht}
                   end;
    {ponti termici esterni }
    PTPE = record
             Cod    : Smallint;
             Descr  : String[100];
             Num    : Smallint;
             LungT  : real;
             KLin   : real;
             Ht     : real;
             TotHt  : real;
             TotGenHt : real;
            end;

    {esposizioni locali non riscaldati }
    EspLocNr = record
                   Conf     : string[10];
                   Tipo     : string[15];
                   cod      : string[8];
                   Descr    : string[20];
                   k        : real;
                   Num      : Smallint;
                   SupLord  : real;
                   SupNetta : real;
                   Lung     : real;
                   ro       : real;
                   Hiv      : real;
                   Hie      : real;
                end;
     // vedere a cosa serve
     RecFrontInt = RECORD
                    {$ifdef fcc}
                    CodA      :Smallint;
                    CodB      :Smallint;
                    {$endif}
                    CodZona1  :Smallint; { Codice Zona 1                           }
                    CodZona2  :Smallint; { Codice Zona 2                           }
                    LungMuro  :REAL;    { Lunghezza muro * HSoffito ==> SupParete }
                    CodMuro:Smallint;    { Codice descrizione Muro                 }
                    SupMuro:REAL;       { Superficie Muro non evidenz. in INPUT   }
                    {$ifdef fcc}
                    Orient1:real;
                    Orient2:real;
                    {$endif}
                   END;    { RecFront int }

    recCapTermica = record
                       CodZona   :Smallint;
                       CodStrut  :Smallint;
                       Tipo      :string[1];
                       DescStrut :string[30];
                       Sup       :real;
                       Cp        :real;
                       CTot      :real;
                    end;

    RecRadProv = Record
                   Ind:INTEGER;
                   T1:INTEGER;
                   datc:array[1..12] of REAL;
                   End;

    rpvst1 = record
               Espos:string[30];
               Nome:string[30];
               Codice    : string[8];
               CodPav    : smallint;
               Area      : real;
               Perimetro : real;
               LambdaTerr: real;
               descrd    : string[50];
               EpsonOrD  : real;
               Dis       : real;
               LambdaIs  : real;
               Hg        : real;
             end;

    stampQ = record
               DescM:string[115];
               Tot:array[1..12] of real;
             end;

  {$IF Defined(VERSIONE_12) or Defined(VERSIONE_13)}
    DatiAttCert = Record
                    Classif: String[255];
                    Vl, Sl, SupL, Sv: Real;
                    GIORNI_RISC: real;
                    ETA_DISTR, ETA_EMISS, ETA_REG: real;
                    ETA_GLOBALE, CD, QKW, QMJ, FEN, VLim: real;
                  End;

    DatiVerif192 = Record
                     VerifPareti, VerifiFinestre, VerificaVetri: Boolean;
                     ValMaxFAEP: Real;
                   end;
  {$IFEND}
    nxf = array[1..maxfinestre] of smallint;
    nxp = array[1..maxporte] of smallint;
    Ar_RecRadProv = array[1..MaxLungr]of RecRadProv;
    elrecac       = array[1..Maxtempac] of rectac;
    TabFacciata   = array[1..Maxfac] of recfacciata;
    elstr10       = array[1..Maxstrutture] of recstr10;
    TabCapTermica = array[1..maxCapTermica] of RecCapTermica;
    tabtempop     = array[1..Maxzone10,1..12] of real;
    EPianteAr     = array[1..MaxEPiante] of RecPiante;
    tabdatclim    = array[1..12] of real48;
    vetrealesp    = array[1..MaxEsposizioni]of real;
    VetReal       = array[1..12] of real;
    VetZ          = array[1..MaxZone10] of real;
    vetfz         = array[1..Maxzone10] of record
                                          vol,port:real;
                                         end;
    VetInt      = array[1..12] of Integer;
    vetFc       = array[1..maxfac] of record
                                       Fo,faOr,faVe:real;
                                      end;
    dispmese    = array[1..12] of record
                                   mese:string[10];
                                   tflu:real;
                                   energ:real;
                                  end;
    tcalcesp    = array[1..MaxEsposizioni] OF record
                                               Sup,Alt:real;
                                              end;
    mes = array[1..12] of string[3];
    TabCd = array[1..10,1..4] of REAL;
    MatReal = array[1..12,1..Maxzone10] of real;
    qdtubi  = array[1..12] of real;
    Tmese   = array[1..12] OF STRING[10];
    PTabDatClim =    ^tabdatclim;
Var
    ept:             ^EPianteAr;
    Facciata:        ^tabfacciata;
    k10:             ^elstr10;
    TabZona10:       ^RectabZona;
    Kappa_PT:        ^Dati_Ponti;
    Generat:         ^RecGenerat;
    prn_totH:        ^F_Tot_Gen;
    TempAC:          ^elrecac;
    NumF:            ^Nxf;
    NumP:            ^Nxp;
    St1Loc:          ^StPerm;
    St2Loc:          ^strReal;
    St3Loc:          ^Str3;
    Prn_Fin:         ^Fin_PTrasp;
    prn_LTF:         ^EspLocF;
    rec_prn:         ^F_Est_Opache;
    prn_PT:          ^PTPE;
    prn_LNR:         ^EspLocNr;
    CapTermica:      ^TabCapTermica;
    dclLoc:          ^Ar_RecRadProv;
    TempIntMEd:      ^tabtempop;
    TempEstMed:      ^tabdatclim;
    TotHEspLocFissi: ^vetrealesp;
    Ql:              ^VetReal;
    TotQse:          ^VetReal;
    TotQsi:          ^VetReal;
    Fig:             ^vetReal;
    Fil:             ^vetReal;
    TotDisp:         ^vetreal;
    MatQhvs:         ^MatReal;
    MatQhr24:        ^MatReal;
    MatQhr:          ^MatReal;
    Ed,Qp,Q,Ep:      ^VetReal;
    CpM,EtuM:        ^vetReal;
    Qi:              ^VetZ;
    VentForzZona:    ^vetfz;
    indmese:         ^VetInt;
    RisFc:           ^vetFc;
    energm :         ^dispmese;
    CalcEsp:         ^tcalcesp;
    StQ:             ^stampQ;
    DM:              ^mes;
    A, TabCDDM27:    ^TabCd;
    pvst1:           ^rpvst1;
    FFInt:   file of RecFrontInt;
    HbH, HdH  : PTabDatClim;
    VERTEO    : Ptabdatclim;
    VERTN     : Ptabdatclim;
    VERTSUD   : Ptabdatclim;
    VERTNONE  : Ptabdatclim;
    VERTSOSE  : Ptabdatclim;
    ValoreArt7: RecArticolo7;
    TotAeiOpa  : array[1..mesp] of real;
    TotAeiTrasp: array[1..mesp] of real;
    Ndisegno, Drivemask, Driveprog: String;
    MeseMagIns, mesirisc, ZonaCalc: SmallInt;
    StampatoGen, {Erroregen,} Flag10, CalcoloAll, errore: Boolean;
    drivematrice,drivecombo: String;
    AreaZona, VolumeZona, VentNatZona, VentTotZona, HvZona, MassaMuro: real;
    CapTermZona, totH2o, QhrEe, QhrEc, VELOCITAVENTO, TempStag, TotQs, MassaEdif: real;
    Eps, Egs, EgLim, EpLim, QS, Fen, FenLim, Qps: Real;
    // Emanuela dpr 192 variabile che contiene il valore del fabbisogno in KWh/m²anno
    QKW: Real;
    Mese_ITA: tmese =(CH12, CH13, CH14, CH15, CH16, CH17, CH18, CH19, CH20, CH21, CH22, CH23);
    EspArray: ARRAY[1..MESP] OF STRING[6]=('ORIZZ.','S','SO-SE','E-O','NO-NE','N');
    cdLegDM, cdAdotDM, DispersDM, TempVicinoAll: real;
    VicAss: Boolean;
    Provv: real;
    Caso: Integer; // contiene 'informazione in che caso ci troviamo per la 192
   {$IF Defined(VERSIONE_12)}
    DatiV192: DatiVerif192;
    DatiAtt: DatiAttCert;
   {$ELSEIF Defined(VERSIONE_13)}
    DatiAtt: array of DatiAttCert;
    DatiV192: array of DatiVerif192;
   {$IFEND}

implementation
 {-----------------------------------------------------------------------------
  Procedure: K
  Author:    e.diquattro
  Date:      16-feb-2006
  Arguments: Cod:integer
  Result:    real

  Cosa fa: restituisce il k-lineare del ponte termico
 -----------------------------------------------------------------------------}
  Function dati_Ponti.K(Cod: Integer): real;
  begin
     K := 0;
     k := FrontiereLin_D^[Cod]^.Kappa;
  end;


end.
