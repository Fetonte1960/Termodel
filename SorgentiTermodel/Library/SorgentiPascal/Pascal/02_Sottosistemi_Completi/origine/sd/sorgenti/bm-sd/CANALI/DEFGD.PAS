



CONST
  Versione = 600; {parametro della procedura ControlloChiave}
  VersTXT  = '6.00';{parametro usato per la testata del programma}
  MaxCmt   =60;
  MaxMis  = 400;
  MaxEPiante = 50;
  MaxSez=20;
  Nprogetti=30;
{I CCACOST.ita}
TYPE

  ST72=STRING[72];
  ST32=STRING[32];

  RecMisure = record
               Rett,Circ:integer;
              end;

  MisAr = array[1..MaxMis] of RecMisure;
  type
     TRecProg = record
                  Descr:stRING[50];
                  Nome:stRING[18];
               end;
     Tarchivio=array[1..nprogetti] of Trecprog;
  DatiProg1 = RECORD
                  Cliente, Localita        : STRING[40];
                  Progettista              : STRING[20];
                  Impianto                 : STRING[40];
                  NOrdine                  : STRING[20];
                  Disegno                  : STRING[8];
                  Riferimento              : STRING[40];
                  Edificio, Sistema, Zona  : STRING[40];
                  Circuito                 : STRING[40];
                  AltSulMare, Altezza      : INTEGER;
                  TempAria, UmRel          : REAL;
                END;

    DatiProg2 = RECORD
                  Visc, Dens                            : REAL;
                  RivestInt                             : STRING[20];
                  SpessRivest, Rugosita                 : REAL;
                  TipoSezione                           : STRING[20];
                  Rapp, DimW, DimH, DPuMTronco, MinTronco, MaxTronco, VelTronco : REAL;
                  DPuMRami, MinRami, MaxRami, VelRami   : REAL;
                  SbilDPu, SerrTermMax, SerrDPuMin      : REAL;
                  VCostante                             : REAL;
                END;

    RecPiante = record
                    NomeP  : STRING[8];
                    ZMin   : real;
                    ZMax   : real;
                end;

    EPianteAr = array[1..maxEPiante] of RecPiante;

    RecSezioni = record
                    NomeP            :STRING[8];
                    XIns,YIns,XOri   :real;
                    YOri,ZOri,Orient : real;
                    Scala            :integer;
                    A_S,BS,HS         : real;
                end;
    ElenSez = array[1..maxSez] of RecSezioni;

   RecErrori=record
               DaNodo,Anodo:integer;
               Quota:real;
               NPezzo:integer;
               Cod:string[5];
               DescrEr:string[48];
            end;
   TErrori=array[1..50] of RecErrori;




TYPE
    rec_inp = RECORD
                Tipo : string[1]; { record di input da input.msk}
                lato_maggiore : INTEGER;
                lung_max_tron : INTEGER;
                lam_spessore : REAL;
                lam_peso : REAL;
                tipo_giunzio : STring[2];
                cod_giu_tras : STring[7];
                pes_giu_tras : REAL;
                rin_int_num : INTEGER;
                rin_int_tip : STring[6];
                rin_int_pes : REAL;
                bul_tipo : STring[3];
                bul_passo : INTEGER;
                bul_peso : REAL;
              END;

    emul = ARRAY[1..MAXCMT] OF rec_inp;




VAR
   mul : ^emul;
   Mis    : ^MisAr;
   DPR1   : ^DatiProg1;
   DPR2   : ^DatiProg2;
   EPt    : ^EPianteAr;
   Sez    : ^ElenSez;
   vprogmto  :^Tarchivio;
   vprog     :^Tarchivio;
   erroreInp    :^TErrori;
   archivioprogetti:boolean;
   arcmisure       :boolean;
   costantididis   :boolean;
   arcriduz        :boolean;
   archiviopezzipc :boolean;
   datigen1,datigen2:boolean;
   piantecl,sezionicl,erroricl:boolean;
   farc   :file of Tarchivio;
  FLAG_DATI         :BOOLEAN;
  ftxt              :text;
  Titolo            :STRING[80];
  ch                :char;
  NumeroProg        :STRING[20];
  Sottorete         :STRING[20];
  Caricamento       :boolean;
  InitMask,InitMenu :boolean;
   ftext,fmenu      :text;
   ScMenu           :STRING[80];
   ERR, errore      :boolean;

   impag            :integer;
   NProg            :STRING[8];
   Init             :text;
   grafico          :array[1..5] of boolean;
   chiave           :integer;
   filet            :TEXT;
   GOSTAMP          : BOOLEAN; { VIENE USATA IN STAMPE ,MENUST,CARICHI}
   gorun            : boolean; { usata per la protezione chiave }

   Fint:file of integer;





{I DATICAD}
{I TIPOCOST}
{I defin_c}


