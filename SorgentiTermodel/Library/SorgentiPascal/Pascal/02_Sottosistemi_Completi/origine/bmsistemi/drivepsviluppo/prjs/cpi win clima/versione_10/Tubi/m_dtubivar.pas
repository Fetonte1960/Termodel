
CONST
  Versione = 600; {parametro della procedura ControlloChiave}
  VersTXT  = '6.00';{parametro usato per la testata del programma}
  Maxtubaz=20;
//UDB  Maxsez  =40;
//  Maxperd =1000;
  Maxterm =1000;
  Maxmont =40;
  MaxFlu = 20;
  maxvalv= 200;
  maxtacche=20;
  maxcod   =40;
  nplot    =7;
  maxerrori=100;
  Maxsot   =30;

TYPE

  ST72=STRING[72];
  ST32=STRING[32];
  ST8 =STRING[8];
  // Emanuela è uno spazio troppo ridotto per alcuni path, quindi deve essere modificato
  //ST80=STRING[80];
  ST80=STRING[255];
  {
  RecGen=RECORD
           Progetto,Committ,Progettista:STRING[50];
           Revisione:Integer;
           Data:STRING[20];
           Luogo:STRING[32];
           ritorno:String[1];
           dps,maxvels,dpe,maxvele:real;
           valvtipo:string[8];
           perdmin:real;
           Tolleranza:real;
           Iterazioni:integer;
         END;
  }
  PunGen=^RecGen;

{UDB
  Recsez=RECORD
         Dnom:string[8];
         Dint:Real;
         spes:Real;
         form:integer;
         end;

  RecTubaz=RECORD
           Cod  :string[8];
           Descr:string[55];
           Dens :Real;
           Rug  :Real;
           sez:Array[1..maxsez] of Recsez;
           end;
  Artubaz=array[1..maxtubaz]of rectubaz;
  PunTubaz=^Artubaz;

  RecPerd=RECORD
          Cod  :string[8];
          Descr:string[20];
          Leq  :real;
          Zeta :real;
          Rit  :String[1];
          end;
  ArPerd=Array[1..maxperd]of recperd;
  Punperd=^Arperd;
}
  Recterm=RECORD
          Cod     :string[8];
          Port    :real;
          Pot     :real;
          porteff :real;
          Perd    :real;
          Codperd :st8;
          End;
  ArTerm=Array[1..MaxTerm]of RecTerm;
  PunTerm=^ArTerm;


  RecMont=RECORD
          Cod      :st8;
          TipTub   :st8;
          CodTub   :st8;
          LungTub  :real;
          CodPerd1 :st8;
          Numperd1 :integer;
          CodPerd2 :st8;
          Numperd2 :integer;
          CodPerd3 :st8;
          Numperd3 :integer;
          end;
  ArMont=Array[1..MaxMont] of RecMont;
  PunMont=^ArMont;

  RecFlu=RECORD
         cod      :st8;
         tm:real;
         pm:real;
         dens:real;
         visc:real;
         calsp:real;
         pesmol:real;
         callat:real;
         end;
 Arflu=Array[1..MaxFlu] of RecFlu;
 PunFlu=^ArFlu;


   RecFluM=RECORD
         cod    :st8;
         tm:real;
         pm:real;
         dens:real;
         visc:real;
         calsp:real;
         pesmol:real;
         callat:real;
         deltaT:real;
         end;
PunfluM=^RecFluM;

type rec_stamp = record
                 STepson:string[1];
                 STlaser:string[1];
                 LungMod:integer;
                 Ruotata:string[1];
                 PortaP :Integer;
                end;

type recplot=record
          tipo     :integer;
          TipoCarta:string[14];
          ruotata  :string[1];
          pORTA    :INTEGER;
          Penne    :array[1..8] of integer;
          end;


type recarcv=record
                descr:string[50];
                cod  :string[8];
                end;
archvalv=array[1..maxvalv]of recarcv;

RecValv=record
          cod:string[8];
          dmin:real;
          dmax:real;
          tacche:array[1..maxtacche]of record
                                          cod:string[8];
                                          kv1:real;
                                          kv2:real;
                                          Kv3:real;
                                          end;
          end;
elvalv=array[1..maxcod] of recvalv;
punvalv=^elvalv;
type
   RigaTubaz = record
                 Cod   :st8;
                 Descr:string[55];
                 dens,rug:real;
               end;
elfin= array[1..MaxTubaz] of RigaTubaz;
var Fin:^elfin;

type RecError=record
              Sottorete:string[8];
              terminale:string[8];
              tronco:string[4];
              descr:string[50];
              end;

elerrore=array[1..maxerrori] of recerror;
var erroriv:^elerrore;


VAR
  Generalita_D  :PunGen;
//UDB  Tubaz_d       :PunTubaz;
//  Perd_D        :Punperd;
  Term_D        :PunTerm;
  Mont_D        :PunMont;
  Flu_D         :PunFlu;
  Flum_D        :PunFluM;

  valv_D        :punvalv;
  vvalv         :^archvalv;
  Vstamp        :^recstamp;
  Vplot         :^ReCplot;
  Fplot         :file of reCplot;
  Fstamp        :file of recstamp;

//UDB  NTubaz:integer;
//  NPerd :integer;
  NTerm :Integer;
  Nmont :Integer;
  NFlu  :integer;



VAR
  FLAG_DATI:BOOLEAN;
  ftxt:text;
  Titolo:st80;
  ch : char;
  NumeroProg,nomeprog:st80;
  Sottorete :st80;
  xprogetto :st80;
  Caricamento:boolean;
  InitMask,InitMenu:boolean;
  Riga:integer;




VAR
   ftext:text;
   fmenu:text;
   ScMenu:st80;
   ERR, errore, fine:boolean;

var
      impag            :integer;
      NProg            :st8;
      Init             :text;
      grafico          :array[1..5] of boolean;
      scelta           :integer;
      chiave           :integer;
      filet            :TEXT;
      GOSTAMP          : BOOLEAN; { VIENE USATA IN STAMPE ,MENUST,CARICHI}
      gorun            : boolean; { usata per la protezione chiave }
      sceltaprec       : boolean;
      fdebug:text;
      Sanitario:boolean;
      tiposan:integer;

const Max_un=52;n_unita=52;

Type  Tel_unita=array[1..max_un,1..2] of real;
Var   el_unita:^TEl_unita;
      Press_ponpa:real;


{$I M_DATICAD}
{$I stvar}
VAR piantecl,sezionicl,archivioprogetti,erroricl,gencl,eltubcl,
    valvcl,perditecl,termcl,montcl,fluidicl,fluidocl:boolean;


