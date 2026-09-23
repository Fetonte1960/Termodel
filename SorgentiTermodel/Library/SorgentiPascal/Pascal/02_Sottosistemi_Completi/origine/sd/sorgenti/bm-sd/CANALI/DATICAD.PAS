
{******************** Informazioni numeriche Sulla rete ********************}

(*
const lungdati=16000;

     {---------- Tronchi ------------}

type calcrec=record

               Num     :integer;    {- Numerazione tronchi -}
               x,y     :real;       {- Posizione etichetta -}

               Tipo    :string[8];  {- Tipo Tubazione -}
               Dh      :real;       {- Diff di quota  -}
               lungh   :real;
               Coddiam :string[8];
               diam    :real;
               SWDiam  :string[1];  {- Diametro fissato -}
               port    :real;       {- Port. richiesta  -}
               PortEff :real;       {- Port. effettiva  -}
               Ti      :integer;    {- Tratto iniziale (record disegno) -}
               Term    :integer;
               Pros    :array[1..6] of integer;  {- Tronchi in uscita:    -}
               pd,pl,pp,pr:real;       {- Perdite -}
               PConc   :array[1..5] of
                          record
                            N  :integer;
                            Cod:string[8];
                          end;
             end;


datirete=array[1..lungdati] of calcrec;

var dati     :^datirete;
    fr       :file of calcrec;
    ntronchi :integer;
    Ulttronco:integer;
    Nrami    :integer;

    {------ Terminali --------------}

Const MaxGTerm=200;

Type RecGTerm=Record
              cod:string[8];
              Port,perd:real;
              sbil     :real;
              NumTer:integer;
              Taratura:string[8]; {-In calcolo contiene temporaneamente
                                    il codice perdite terminale  -}

              Diam:string[8];
              Montaggio:integer;
              end;

     ElGterm=array[1..Maxgterm]of RecGterm;

var  Gterm   :^ElGTerm;
     FGT     :File of RecGTerm;
     Ngterm  :integer;
     UltGterm:integer;

   {------- Dati Generali ---------}

Type DatiInt=record
                Origine :integer;
                Perdita :real;
                Portata :real;
                Sbil    :real;
                Sfavor  :integer;
             end;

var RisultCalc:DatiInt;
    FRisult   :File of DatiInt;




var it,i,nsot,nsottemp:integer;
    elsot:array[1..10] of string[8];


    DatiSot:array[1..10] of Datiint;

ExSot:boolean;
RetePrinc:boolean;
ValvoleTaratura:boolean;
PerditaTotale:real;
PrimaPassata:boolean;
Verifica    :boolean;
Converge    :Boolean;
NIter       :integer;
Divrit      :real;
princsfavor :integer;
Nsottosfavor:integer;
sottosfavor :integer;
Flt         :text;
{uses odialogs;}
*)
{**************************** Informazioni grafiche ************************}


      {------- Record Disegno ------}

Const lungdis=16000;

{$I GRAFCOST }
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


(*

      {------ Record composizione simboli Grafici -------}


const
   Lungh = 300;
   NPuntiFaccia = 4;

type
   punto  = record
               X,Y,Z : real;
            end;
   faccia = array[1..NPuntiFaccia] of punto;

   RigaTab = record
                Codice : string[20];
                Punti  : Faccia   ;
             end;
   Disegno = array[1..Lungh] of RigaTab;

var tabella  :disegno;
    nrighetab:integer;

*)
      {------ Elenco simboli grafici caricati -----------}

const Maxsimb=20;
type simbol=array [1..Maxsimb] of record iniz,fin,nviste:integer;m:real end;


var elsimb :^simbol;
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
     e_DisPezzo=Array[1..30] of RecPezzo;
     e_DisPezzo1=Array[1..50]of RecPezzo;

var
    Vettore:^VetDim;
    FDim:file of VetDim;


    DisPezzo:^e_dispezzo;
    DisPezzo1:^e_dispezzo1;

{******************** Informazioni numeriche Sulla rete ********************}

     {---------- Pezzi -------------}

const lungpezzi=16000;

Type St5=String[5];
     St_1=String[1];

type recpezzi=record
                Codice:st5;
                R,A,B:real;
                Flag:st_1;
                Lung:real;
                Ang,Rag,Perd,port,varie:real;
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

(*
type calcrec=record

               Num     :integer;    {- Numerazione tronchi -}
               x,y     :real;       {- Posizione etichetta -}
               Pezzi   :array[1..15]of
                        record
                         Codice:string[5];
                         R,A,B:real;
                         Flag:string[1];
                         Lung:real;
                         Ang,R,Perd,port,varie:real;
                        end;
               Tipo    :string[8];  {- Tipo Tubazione -}
               Dh      :real;       {- Diff di quota  -}
               lungh   :real;
               Coddiam :string[8];
               diam    :real;
               SWDiam  :string[1];  {- Diametro fissato -}
               port    :real;       {- Port. richiesta  -}
               PortEff :real;       {- Port. effettiva  -}
               Ti      :integer;    {- Tratto iniziale (record disegno) -}
               Term    :integer;    {- Terminale collegato              -}
               Pros    :array[1..6] of integer;  {- Tronchi in uscita:    -}
               pd,pl,pp,pr:real;       {- Perdite -}
               PConc   :array[1..5] of
                          record
                            N  :integer;
                            Cod:string[8];
                          end;
             end;
*)

elpezzi =array[1..lungpezzi] of ^ recpezzi;
datirete=array[1..lungdati]  of ^ calcrec;

var dati     :^datirete;
    Vpezzi   :^elpezzi;
    fr       :file of calcrec;
    fp       :file of recpezzi;
    ntronchi :integer;
    Ulttronco:integer;
    Ultpezzo :integer;
    Nrami    :integer;

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

var  {Gterm   :^ElGTerm;}
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

    snapx,snapz,snapang:Boolean;
    asp:real;
    PXSez,PYSez,PZsez:real;
    M_sez,C_sez:real;
    Nomesez:string;
    Nomepianta:string;
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

    AltSez:string;

    {------ Variabili di uso libero ---}

    real1,real2,real3,real4:real;
    int1,int2,int3,int4:integer;
    XFilo,YFilo:real;

    {--------- Halo ------------------}

    const
       fonti :string='halo106.fnt';

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

var conf:recconf;
    fconf:file of recconf;


    {-- Colloquio con readcom --}

    Ntronco:integer;

    {-- Nome progetto --}
    {DataDrive  :string;
    DriveDrive :string;
    BlocDrive  :string;
    PianteDrive:String;
    CartDrive  :String;
    AriaDrive   :String;}
    NomeProg   :string;

  {--- Cofigurazione Dimensionato -----}


{***************************** Varie ***************************************}


Const  maxxw:real=1000.0;maxyw:real=750;
       minxw:real=0.0;minyw:real=0;
       maxamp=100;
       maxmont=40;

       maxterm=50;
       maxtr=100;
       

       Curcol:integer=8;

type (*frec=record
          DescrScheda:string[80];
          Scheda:string;
          Modo:integer;
          DescrDigitizer:string[80];
          Digitizer:string;
          DescrPlotter:string[80];
          Plotter:string;
          DescrStampante:string[80];
          Stampante:string;
          end;
*)
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

{scelta,}
ultcom, cod,c1,sw,
mode,linesel :integer;

retino,controllo            :boolean;

//**N fc                          :file of frec;

st1,stpl,Device             :string;

line1,line2,line3           :curtype;

oldx,oldy,fscalag,orientg   :real;

{vrec                        :frec;}

montaggio                   :string[8];
Numerazione                 :boolean;

col:array[1..20]of integer;

ctrlkey,xsp,ysp,s_up        :integer;
X_move,Y_Move:integer;

nomebl                      :string;

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
    {$ifdef win}
    {$else}
    {Registri:Registers;}
    {$endif}
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
  Vstamp        :^recstamp;
  Vplot         :^ReCplot;
var
    {fine:boolean;}
    f:text;
    UnMis:integer;
    F_Unmis:File of integer;
    exit_char:char;

{-- Riduzioni automatiche --}

{I Tiperid}

Type Stacchi=array[0..6]of integer;

CONST nhpgl=100;

type recdis=record mov:boolean;x,y:integer end;
     recdisV=array[1..nhpgl]of recdis;
var  hpgl:^recdisV;
     contline :integer;
     FDeb:Text;


     Piccolo,Rinfr_menu:boolean;
     Ult_x,Ult_y:real;
     Max_Wx:real;
     Salva_val:real;
     Salva_val1:real;

{- Osnap --}
C_dist:real;
c_ang :real;
C_osnap:Boolean;
Grafica:boolean;
Punt_im:Array[1..20]of pointer;
Memo_im:string;
Save_im:boolean;
size:word;
memo_pi:boolean;
Fetta,altw,larw,nfette:integer;

{implementation
end. }