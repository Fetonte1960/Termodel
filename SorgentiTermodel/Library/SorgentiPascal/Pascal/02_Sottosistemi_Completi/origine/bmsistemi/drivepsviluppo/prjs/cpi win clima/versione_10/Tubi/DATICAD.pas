{******************** Informazioni grafiche **********************************}
      {------- Record Disegno ------}

Const lungdis=16000;

type cadrec=record
            entita:string[1];
            codicetubo: Integer;
            // Emanuela 4/3/2004 inserito il tipo del tubo
            Tipo: String[10];
            Filtro:string[20];
            Settore:string[20];
            Rimando:string[50];
            lungtubo:real;
            NumPerd:integer;
            codperd:string[10];
            x1    :real;
            y1    :real;
            z1    :real;
            x2    :real;
            y2    :real;
            z2    :real;
            NPezzo:integer;  {-- Contiene l`indice del pezzo --}
            Rid   :String[5];
            color :string[15];
            tlinea:integer;
            tronco:integer; {-- Nø tronco contenente i dati  --}
            nlinea:integer; {-- prossima linea del tronco    --}
                            {-- Oppure N terminale se entita --}
                            {-- e` un terminale              --}
            flag  :boolean; {-- Serve per marcare il tratto  --}
            // Emanuela 17/03/2003: introdotto il flag visitato per evitare
            // di visitare archi già visistati
            Visitato: Boolean;
            // Emanuela 19/05/2004 aggiunto il piano
            Piano: String[10];
            PianoCAD: String[10];
            Angolo: real;
            Spec: String[2];
            end;

elenco=array[0..lungdis] of ^ cadrec;

var dis    :^elenco;
    f_i     :file of cadrec;
    nrighe :integer;
    Ultriga:integer;






{******************** Informazioni numeriche Sulla rete ********************}

Const LungDati=16000{400cippo};

     {---------- Tronchi ( TUBI )------------}


type calcrec=record

               Num     :Integer;    {- Numerazione tronchi -}
               CoDiceNodo:Integer;
               x,y     :real;       {- Posizione etichetta -}

               Tipo    :string[10];  {- Tipo Tubazione -}
               Dh      :real;       {- Diff di quota  -}
               lungh   :real;
               Coddiam :string[15];
               diam    :real;
               SWDiam  :string[1];  {- Diametro fissato -}
               port    :real;       {- Port. richiesta  -}
               PortEff :real;       {- Port. effettiva  -}
               Ti      :integer;    {- Tratto iniziale (record disegno) -}
               Term    :integer;    {- Terminale collegato              -}
               NPros:integer;{ Numero di archi }
               Pros    :array[1..6] of integer;  {- Tronchi in uscita:    -}
               pd,pl,pp,pr: real;       {- Perdite -}
               NPconc:integer;
               PConc   :array[1..5] of
                          record
                            N  :integer;
                            Cod:string[10];
                          end;
               Sfavorito:string[1];
               Velocita: Double;
               TipoRete:integer;
               Piano: String[10];
             end;


datirete =array[0..lungdati] of ^calcrec;

var dati     :^datirete;
    fr       :file of calcrec;
    ntronchi :integer;
    Ulttronco:integer;
    Nrami    :integer;
    Manrip   :boolean;



    { record di appoggio per la numerazione dei tronchi in ripresa }

type calcrec2=record

               Num     :integer;    {- Numerazione tronchi -}
               x,y     :real;       {- Posizione etichetta -}
               lungh   :real;       {- lunghezza tronco    -}
               Coddiam :string[15];  {- codice del diametro -}
               Ti      :integer;    {- Tratto iniziale (record disegno) -}
             end;


datirete2=array[0..lungdati] of ^calcrec2;

var dati2    :^datirete2;
    fr1      :file of calcrec2;



    {------ Terminali --------------}

Const MaxGTerm=16000;

Type RecGTerm=Record
               XTerm,Yterm,ZTerm:real;
               cod:string[20];
               numamb:integer;
               Codiceterminale:integer;
               Pot,Dt,Port,perd:real;
               sbil     :real;
               NumTer:integer;
               Taratura:string[8]; {-In calcolo contiene temporaneamente
                                    il codice perdite terminale  -}

               Diam:string[15];
               Montaggio:integer;
               { Emanuela 5/04/2004 inserite le variabili per contenere le altre proprietà
                 del terminale }
               TipoTerm, Modello, Serie: String[35];
               Piano: String[15];
               Profondita, Altezza, Larghezza, LarghezzaMax, IncrPotenza, Angolo: Real;
               NumElementi: Integer;
               XEtic, YEtic, ZEtic: Real;
               Spec: String[2];
              end;

     ElGterm=array[1..Maxgterm] of ^RecGterm;

type RecGTemp=Record
         x,y,z,
         pp,pd,pl,
         lungh,diam,
         sfav,port     :Real;
         IndM,IndR     :integer;
         CodDiam       :string[15];
         SWdiam        :string[1];
         Termin        :RecGTerm;
         PConc         :array[1..5] of
                         record
                           N   :integer;
                           Cod :string[8];
                         end;
         end;

     ElGtemp=array[1..Maxgterm] of ^RecGtemp;

var  Gterm   :^ElGTerm;
     FGT     :File of RecGTerm;
     FGTemp  :File of RecGTemp;
     FGTB    :^ElGtemp;
     Ngterm  :integer;
     UltGterm:integer;
     NomeP:string[50];

   {------- Dati Generali ---------}

Type DatiInt=record
                XOrig,Yorig,ZOrig:real;
                Origine :integer;
                Perdita :real;
                Portata :real;
                Sbil    :real;
                Sfavor  :integer;
             end;
   eldatisot=array[1..maxsot,1..2] of Datiint;

var RisultCalc:^DatiInt;
    FRisult   :File of DatiInt;


type arch=record
          descr:string[50];
          nome :string[8];
          end;
archivio=array[1..maxsot] of arch;

var it,i,nsot,nsottemp:integer;
    elsot:array[1..maxsot] of string[8];
    fa:file of archivio;
    vprog:^archivio;

    DatiSot:^eldatisot;

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
Peff        :boolean;
Peff1       :boolean;
wr,Rrit     :boolean;
piantubi    :boolean;
Nlink,rit   :integer;
maxsfav     :real;
ltx         :integer;

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
    {egistri:Registers;}
    Ton     :Boolean;
    olD_x,old_y:integer;
    Buf_image   :pointer;
    Stored      :boolean;
    XImage,YImage:integer;

    xinfp,yinfp,xsupp,ysupp,zinfp,zsupp,
x,y,x1,y1,xw1,xw2,yw1,yw2   :real;



FB        :TEXT;
Orz       :real;


ultcom, cod,c1,sw,
mode,linesel :integer;
UltIng,UltRot:String;

retino,controllo            :boolean;



st1,stpl,Device             :string;

{line1,line2,line3           :curtype;}

oldx,oldy,fscalag,orientg   :real;



montaggio                   :string[8];
Numerazione                 :boolean;



const maxperdloc=1000;
var
xnome:string;
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
ctrlkey,xsp,ysp,s_up        :integer;
X_move,Y_Move:integer;

type  Tipocan=Array[1..4] of string[5];

      {- Tubi -}
//Var Maxperd:Integer;
