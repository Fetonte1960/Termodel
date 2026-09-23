
{ ------------------------ dati per la stampa ------------------------------- }

CONST
 formule : array [1..10] of st20 =('Darcy-Weisback','William-Hazen','Darcy','Scimeni','Scimeni-Veronese',
                                   'De Marchi-Marchetti','Spitzglass ','','','');

 MaxRighe  = 50;
 dicitura = ' RETE PRINCIPALE ';
 Circ1    = ' Mandata e ritorno ';
 Circ2    = ' Mandata ';

TYPE
  st55 = string[55];


  ScelteStampe = array[1..4] of integer;

  Stampa = record
               Scelte     :ScelteStampe;
               NCopie     : integer;
            end;

  NumeroProgetto = record
                      progetto:string[8];
                      data    :string[12];
                      pagina  :integer;
                   end;

 dicit = record  {intestazione stampa1 e stampa2}
         nome  : st10;
         descr : st50;
      end;

  FormUsed   = record
                 num   : integer;
                 descr : st20;
              end;

  TubiUsed   = record
                 num   : integer;
                 descr : st20;
              end;

  perdite    = record
                 MaxVelSF   : real;
                 MaxDeltaSF : real;
                 MaxVel     : real;
                 MaxDelta   : real;
               end;


  Portate    = record
                  PortataTotL  : real;
                  PortataTotKg : real;
                  DeltPtot     : real;
               end;

  Calcolo1 = record

               Num1       :Integer;    {- Numerazione tronchi -}
               Tubo       :integer;
               Formula    :integer;
               DiamCod    :st8;

               Velocita   :real;
               Portata    :real;
               Lung       :real;
               DeltaH     :real;
               DpDist     :real;
               DpLoc      :real;
               DpTot      :real;
               DpProg     :real;
               Squil      :real;
               Terminale  :st8;
             end;


datirete1=array[1..lungdati] of calcolo1;

  stgen  = record            {DatiGenerali  --> pag.1}
          Prog        :st50;
          rev         :integer;
          datarev     :st32;
          Committente :st50;
          Progett     :st50;
        end;

  StFluido  = record         {DatiGenerali  --> pag.1}
             tipoFluido  : st8;
             TempM       : real;
             Press       : real;
             Densita     : real;
             Viscosita   : real;
          end;


  Computo  = record

            Diametro   : st8;
            Lunghezza  : real;
            Peso       : real;
            Area       : real;
            Volume     : real;
            PesoH2O    : real;
        end;

  Comp = array[1..MaxSez+1] of Computo;

  dati1  = record

         Descrizione : st55;
         DatiComp    : comp;
       end;

  DatiComputo = array[1..MaxTubaz] of dati1;

  {..   * = setDiam = contiene l`indice di RecTubaz .sez[*]  ..}
  SettaDiam = array[1..maxsez] of st8;
  TubiDatiN  = record
             flag : char;
             DNum : SettaDiam;
            end;

  TubiNum = array[1..MaxTubaz] of TubidatiN;

  Computok  = record

            Diametrok   : st8;
            Lunghezzak  : real;
            Pesok       : real;
            Areak       : real;
            Volumek     : real;
            PesoH2Ok    : real;
        end;

  Compk = array[1..MaxSez+1] of Computok;

  dati1k  = record

         Descrizionek : st55;
         DatiCompk    : compk;
       end;

  DatiComputok = array[1..MaxTubaz] of dati1k;

  CMRaccordi  = record

                 CodD  : st8;
                 CodR  : st8;
                 NPezzi: integer;
             end;

  CMRacc = array[1..100] of CMRaccordi;

  CMRaccordi1  = record

                 CodD1  : st8;
                 descrR : st20;
                 NPezzi1: integer;
             end;

  CMRacc1 = array[1..100] of CMRaccordi1;

  CMValvoleT  = record

                 CodD  : st8;
                 NPezzi: integer;
             end;

  CMValv = array[1..40] of CMValvoleT;

VAR
  numeroprog1      : st80;{usato solo in proc.altrapagina}
  FormuleUsate     : array[1..10] of char;  { S/N }
  TubiUsati        : array[1..MaxTubaz] of char;  {S/N}
  Tubus            : array[1..40] of integer;
  NomProgetto      : NumeroProgetto;
  NumPag,nrighe    : integer;
  Form             : FormUsed;
  Tub              : TubiUsed;
  buffer           : stampa;
  perd             : perdite;
  ft               : text;
  comodo           :^datirete1;
  Port             : portate;
  gen              : stgen;
  Com_M            : ^DatiComputo;
  k_Comp           : ^daticomputok;
  Comp_Racc        : ^CMRacc;
  Comp_R1          : ^CMRacc1;
  Descr1           : dicit;
  fluss            : StFluido;
  C_Valv           : ^CMValv;
  TubiTu           : TubiNum;

  CiSonoSottoreti,Esegui  : boolean;

{ ---------- variabili per il percorso + sfavorito della rete ---------------

  sono inizializzate nella procedura CercaSfavorito  in stampa1.pas          }

var
   PercorsoSfavorito             : Boolean;
   SottoreteSfavorita            : st8;
   sfavorito,SfavoritoSot,IndiceSfavorito : integer;

{ ---------------------- dati usati nella stampa 2 --------------------- }

type
     PLocalizzate = record
                  numT      : integer;
                  DiamP     : st8;
                  CodR      : st8;
                  NPezziR   : integer;
                  LEquiv    : real;
                  DpRacc    : real;
                  CodZ      : st8;
                  NPezziZ   : integer;
                  Perdzeta  : real;
                  DpZeta    : real;
                  DpTOT     : real;
               end;

   PrdStampa =array[1..5] of PLocalizzate;

var PLoc : PrdStampa;



{ ---------------------- dati usati nella stampa 3 --------------------- }

TYPE
   ELENCOTERM   = RECORD
            Terminale  : st8;
            Tronco     : integer;
            Diametro   : st8;
            Portata    : real;
            Potenza    : real;
            Perdite    : real;
            CodPerdite : st8; {codice della perdita}
            Sbilancio  : real;
            ValvDiam   : st8;
            Posizione  : st8; {Taratura}
        end;

terminali = array[1..MAXGTERM] of ElencoTerm;


var termal   : ^Terminali;



{ ---------------------------- tipi del programma setstamp ---------------- }

type recstamp=record
              Escape:integer;
              AvMod :integer;
              Canc  :integer;
              Nline :integer;
              end;

var vstamp            :recstamp;
