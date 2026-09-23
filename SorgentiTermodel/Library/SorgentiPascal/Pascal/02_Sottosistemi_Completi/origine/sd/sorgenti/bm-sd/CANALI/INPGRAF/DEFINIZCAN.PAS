unit definiz;
interface
{uses dos;}

{************************** Informazioni grafiche ************************}

Const lungdis=16000;

{$ifdef francia}
{$I GRAFCOST.fra}
{$endif}

{$ifdef inglese}
{$I GRAFCOST.eng}
{$endif}

{$ifdef italia}
{$I GRAFCOST.ita}
{$endif}

{$ifdef spagna}
{$I GRAFCOST.esp}
{$endif}
type cadrec=record
            entita:string[1];
            x1    :real;
            y1    :real;
            z1    :real;
            x2    :real;
            y2    :real;
            z2    :real;
            NPezzo:integer;
            Rid   :String[5];
            color :integer;
            tlinea:integer;
            tronco:integer; {-- Nø tronco contenente i dati  --}
            nlinea:integer; {-- prossima linea del tronco    --}
                            {-- Oppure N terminale se entita --}
                            {-- e` un terminale              --}
            flag  :boolean; {-- Serve per marcare il tratto  --}
end;

elenco=array[0..lungdis] of ^ cadrec;

var dis    :^elenco;
    fi     :file of cadrec;
    nrighe :integer;
    Ultriga:integer;
    riga:integer;


      {------ Elenco simboli grafici caricati -----------}

const Maxsimb=20;
TYPE ARSIMB=array [1..Maxsimb] of record iniz,fin,nviste:integer;m:real end;

var elsimb :^arsimb;
    nsimb  :integer;
type
      VetDim=record
             Codpezzo,gruppo:integer;
             Entita:string[1];
             Tlinea,Colore:integer;
             X1,Y1,X2,Y2,Z1,Z2:real;
             R,R2:real;
      end;
     RecPezzo=record
                 entita:string[1];
                 TLinea:integer;
                 X1,Y1,X2,Y2,R,R1:real;
              end;

elpezzo=Array[1..30] of RecPezzo;
elpezzo1=Array[1..50]of RecPezzo;


const maxpar=9;
type Int3d=record
            Entita:string[1];
            Par:array[1..maxpar]of real;
           end;

elpezzo3d=Array[1..30] of Int3d;
elpezzo13d=Array[1..50]of Int3d;


var
    Vettore:^VetDim;
    FDim:file of VetDim;


    DisPezzo:^elpezzo;
    DisPezzo1:^elpezzo1;

    DisPezzo3d:^elpezzo3d;
    DisPezzo13d:^elpezzo13d;
{******************** Informazioni numeriche Sulla rete ********************}

     {---------- Pezzi -------------}

const lungpezzi=16000;
      MaxD=30;
Type St5=String[5];
     St_1=String[1];

     recdesPz=record
                Descr:string[30];
                valor:string[10];
                Attrib:string[1];
              end;
     ArrDesc=array[1..MaxD]of RecDesPz;

type recpezzi=record
                Codice:st5;
                R,A,B:real;
                Flag:st_1;
                Lung:real;
                Ang,Rag,Perd,port,varie:real;
                {$ifdef newcr}
                TabDescr:ArrDesc;
                {$endif}
     end;

const lungdati=16000;

      pezzitr =31;
      NTabCan =2;

     {---------- Tronchi ------------}


type calcrec=record

               Num         :integer;    {- Numerazione tronchi -}
               x,y         :real;       {- Posizione etichetta -}
               Pezzi       :array[0..pezzitr] of integer;
               Ti          :integer;    {- Tratto iniziale (record disegno) -}
               Pros        :array[1..6] of integer;  {- Tronchi in uscita:    -}
     end;

punpezzi=^recpezzi;
elpezzi =array[1..lungpezzi] of punpezzi;
datirete=array[1..lungdati]  of ^ calcrec;

var dati     :^datirete;
    Vpezzi   :^elpezzi;
    fr       :file of calcrec;
    fp       :file of recpezzi;
    ntronchi :integer;
    Ulttronco:integer;
    Ultpezzo :integer;
    Nrami    :integer;
    NTrValid :integer; { contatore n. tronchi validi non cancellati cippo}
    NSecPezzi:integer; { numero sequenzione dei pezzi CR }

    {------ Terminali --------------}

Const MaxGTerm=200;

Type RecGTerm=Record
              cod:string[8];
              Port,perd:real;
              sbil     :real;
              NumTer:integer;
              Taratura:string[8];
              Diam:String[8];
              Montaggio:integer;
              end;

     ElGterm=array[1..Maxgterm]of RecGterm;

var
     FGT     :File of RecGTerm;
     Ngterm  :integer;
     UltGterm:integer;

   {------- Dati Generali ---------}

Type DatiInt=record
                Origine :integer;
                Sfavor:integer;
                Disdimens:boolean;
                DisUnif  :boolean;
                Nodi     :Boolean;
                Quota    :real;
                SL_Xsup,SL_Xinf,SL_YSup,SL_YInf:real;
                SXsup,SXinf,SYSup,SYInf,SZInf,SZSup:real;
                Ssezione   :boolean;
             end;

var RisultCalc:^DatiInt;
    FRisult   :File of DatiInt;

{*********************** Variabili di gestione *****************************}


var
    {--- Modo corrente di disegno ---}

    snapx,snapz,snapang,stampa_win,schermo_nero,
    stampa_adattata,Stampa_ass,Stampa_pianta,Stampa_numeri,
    ritorno,Stampa_colori,prevista:boolean;
    asp,fatt_stampa:real;
    PXSez,PYSez,PZsez:real;
    M_sez,C_sez:real;
    Nomesez:string[8];
    Nomepianta:string[8];
    ZMin_P,ZMax_P:real;

    {----- Limiti del disegno ------}

    limXi,limXs,limYI,limYS:real;
    S_limXi,S_limXs,S_limYI,S_limYS,S_limZI,S_limZS:real;

     {--- Limiti della finestra -----}

    L_Xsup,L_Xinf,L_YSup,L_YInf:real;
    Xsup,Xinf,YSup,YInf,ZInf,ZSup:real;
    sezione   :boolean;
    Sez_Dim   :Boolean;

    xp,yp:real;

    AltSez:string[4];

    {------ Variabili di uso libero ---}

    real1,real2,real3,real4:real;
    int1,int2,int3,int4:longint;
    XFilo,YFilo:real;

    {--------- Halo ------------------}

     {--- cursore iso---}

var  iso             :boolean;
     direz,direzprec :integer;

     {-- Array Pieni ---}

     PieniT   :boolean;
     PieniD   :boolean;
     PieniTerm:boolean;
     PieniP   :boolean;

     {-- Ultimo Nodo selezionato --}

     Trattosel:integer;

     {-- Record di configurazione --}

     AltNum,altnumr:real;
     {---- Altezza dei numeri --------}

type  Tipocan=Array[1..4] of string[5];

type recconf=record
             Rcolore   :integer;
             Tlinea   :integer;
             Rsnap    :real;
             griglia  :real;
             altnum   :integer;  {-- Scala --}
             ManRip   :String[1];
             CircRet  :String[1];
             Curve    :TipoCan;
             Br90     :array[1..3] of record
                                        RapLung:real;
                                        CodCan :TipoCan;
                                      end;
             BrD90     :array[1..3] of record
                                        RapLung:real;
                                        CodCan :TipoCan;
                                      end;
             Tee,Croce:TipoCan;

             BocVert  :record
                         TipoBoc:String[1];
                         CodBoc :TipoCan;
                       end;

             Bocoriz  :record
                         TipoBoc:String[1];
                         CodBoc :TipoCan;
                       end;
             end;

var conf:^recconf;
    fconf:file of recconf;

    {-- Colloquio con readcom --}

    Ntronco:integer;

    driveplt,drivearc,drivecart,drivearia,nomecommessa,driveprog,drivecca:string[50];
    NomeProg   :string[50];
    orto       :boolean;
    rigeneradlt:boolean;

  {--- Cofigurazione Dimensionato -----}

  {$I TipoCost }

{***************************** Varie ***************************************}


Const  maxxw:real=1000.0;maxyw:real=750;
       minxw:real=0.0;minyw:real=0;
       maxamp=100;
       maxmont=40;

       maxterm=50;
       maxtr=100;


       Curcol:integer=8;

type {frec=record
          DescrScheda:string[80];
          Scheda:string;
          Modo:integer;
          DescrDigitizer:string[80];
          Digitizer:string;
          DescrPlotter:string[80];
          Plotter:string;
          DescrStampante:string[80];
          Stampante:string;
          end;}

  RecMont=RECORD
          Cod      :string[8];
          TipTub   :string[8];
          CodTub   :string[8];
          LungTub  :real;
          CodPerd1 :string[8];
          Numperd1 :integer;
          CodPerd2 :string[8];
          Numperd2 :integer;
          CodPerd3 :string[8];
          Numperd3 :integer;
          end;
  ArMont=Array[1..MaxMont] of RecMont;
  PunMont=^ArMont;



curtype=array[1..maxamp]of record xo,yo,col1,col2 :word end;

var

xinfp,yinfp,xsupp,ysupp,zinfp,zsupp,
x,y,x1,y1,xw1,xw2,yw1,yw2   :real;
VAR Mont_D:PunMont;
FB        :TEXT;
Orz       :real;

scelta,
ultcom, cod,c1,sw,
mode,linesel :integer;

retino,controllo            :boolean;

{fc                          :file of frec;}

st1{,stpl,Device}             :string;
stpl,Device             :string[80];
line1,line2,line3           :curtype;

oldx,oldy,fscalag,orientg   :real;

{vrec                        :frec;}

montaggio                   :string[8];
Numerazione                 :boolean;

col:array[1..20]of integer;

xsp,ysp,s_up        :integer;
X_move,Y_Move:integer;

nomebl                      :string[50];

doppio1,doppio2             :double;

type
ptr_int  =^integer;
ptr_real =^real;
Ptr_st   =^String;

Var DimCur:integer;

Var ColSfond,ColText,ColDraw:integer;
    Cur:Boolean;
    XCur,YCur,ColCur:integer;
    xrb,yrb,xrb1,yrb1:integer;
    RBLine:Boolean;
    xrx,yrx,xrx1,yrx1:integer;
    Inx,Iny:real;
    RBx:Boolean;
    XPrecM,YPrecM:integer;
    Ton     :Boolean;
    olD_x,old_y:integer;
    Buf_image   :pointer;
    Stored      :boolean;
    XImage,YImage:integer;



type recstamp=record
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
var
  Fplot         :file of reCplot;
  Fstamp        :file of recstamp;
  {Vstamp        :recstamp;
  Vplot         :ReCplot;}
var
    fine:boolean;
    f:text;
    UnMis:integer;
    F_Unmis:File of integer;
    exit_char:char;

{-- Riduzioni automatiche --}

{$I Tiperid}

Type Stacchi=array[0..6]of integer;

CONST nhpgl=100;
      maxaggdis=20;


type recdis=record mov:boolean;x,y:integer end;
     recdisV=array[1..nhpgl]of recdis;
type DimDaDis = record
                 NProgettu   : string[8];
                 culuri      : integer;
                end;


     eldimdadis=array[1..maxaggdis] of dimdadis;

var
hpgl:^recdisV;
contline :integer;
FDeb:Text;
VaiColDim:^eldimdaDis;
naggdis:integer;
Piccolo,Rinfr_menu:boolean;
Ult_x,Ult_y:real;
Max_Wx:real;
Salva_val:real;
Salva_val1:real;
C_dist:real;
c_ang :real;
C_osnap:Boolean;
Grafica:boolean;
Punt_im:Array[1..20]of pointer;
Memo_im:string[80];
Save_im:boolean;
size:word;
memo_pi, trcollega:boolean;
Fetta,altw,larw,nfette:integer;
type FreOsnap = record
                   Vado : Boolean ;
                   Frx,Fry,FrAng : real;
                   Giadis    : boolean;
                   end;
var Trosnap : FreOsnap ; (* cippo Freosnap e Trosnap inseriti per disegnare
    una freccia dopo aver fatto un tronco con snap alla pianta e prima di
    selezionare la parete  allo scopo di far ricordare il tronco che si
     intende disegnare *)

CONST HHQQ = 70; { cippo hhqq coeffic. per gramdezza quote }
      HHNN = 70; { per i nodi }
var pianfilt :boolean;
{$I DEFGD}
implementation
end.
