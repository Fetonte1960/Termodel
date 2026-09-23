{$ifdef free}
{$define SPROTETTO}
{$undef PROTETTO}
{$ENDIF}
Unit defuti;

Interface

(*
 {$Ifdef dos}
  Crt,
  Dos;
{$endif}
{$Ifdef Win}
Wincrt,
OWindows,
wintypes,
odialogs;
{$Endif}
(*{$ifdef delphi}
messages,
{$endif}
objects;
  *)



 uses wintypes,objects,odialogs,OWindows{,Wincrt}{$ifdef delphi},messages{$Endif};
    const
       StatusLineHeight        =  20;
       TextStart               =  200;
       bmp_StatusBar           =  101;
       bmp_StatusLine          =  100;
       maxtabelle=50;
       maxtasti=30;
       Gmax=20;
       Fill='                                                                                ';
       MaxMenu=21;
       MaxCampi=300;
       MaxInfo=50;
       MIngX=20;
       MIngY=20;
       Maxunmisure=20;
       maxcampivis=50;
       {$IFDEF INPS}
       INPS1=73;
       {$ENDIF}
    type

       st255 = string[255];
       st240 = string[240];
       st126 = string[126];
       st80  = string[80] ;
       st70  = string[70] ;
       st64  = string[64] ;
       st66  = string[66] ;
       st60  = string[60] ;
       st50  = string[50] ;
       st55  = string[55] ;
       st48  = string[48] ;
       st45  = string[45] ;
       st35  = string[35] ;
       st32  = string[32] ;
       st30  = string[30] ;
       st27  = string[27] ;
       st25  = string[25] ;
       st24  = string[24] ;
       st23  = string[23] ;
       st18  = string[18] ;
       st16  = string[16] ;
       st15  = string[15] ;
       st14  = string[14] ;
       st12  = string[12] ;
       st11  = string[11] ;
       st10  = string[10] ;
       st8   = string[8]  ;
       st7   = string[7]  ;
       st6   = string[6]  ;
       st5   = string[5]  ;
       st4   = string[4]  ;
       st3   = string[3]  ;
       st2   = string[2]  ;
       st1   = string[1]  ;
       st40  = string[40] ;
       st20  = string[20] ;
       linestr = string[80];

       DatiMenu=array[1..MaxMenu]of record
				      testo:st80;
				      codice:integer;
				      carsp :integer;
				    end;

       umtemp=record
		 descum :st10;
		 coeffum:real;
		   dec  :integer;
	      end;

       Recunmisure=record
		   DescrInt:st20;
		   umint   :st10;
		   um      :array[1..2] of umtemp;
		   end;
       elunmisure= array[0..maxunmisure] of recunmisure;


       RecTab= record
	       Flag:boolean;
	       Tipo:char;
	       L:integer;
	       x,y:byte;        {integer}
	       BAddr,OAddr:longint;
	       CifreInt,CifreDec:Byte{integer};
	       help:Byte{string[80]};
	       NCampoTab:integer;
	       NlineUm,Num:integer;
	       subtipo:char;
	       {$ifdef win}
	       p:pedit;
	       pcb:pcombobox;
	       pck:pcheckbox;
	       prb:pradiobutton;
	       {$endif}
	       modificato:boolean;

	    end;

	rechlp= record
		  descr:string[64];
		  val  :string[16];
		end;
       recins=record
		 nfile:string[80];
		 ncampo:integer;
		 ncampoagg:integer;
		 NCAMPIRIGA:INTEGER;
	      end;
       tabellains= array[1..maxcampi] of recins;
       puntabins=^tabellains;
       TabellaRec = array[1..MaxCampi] of RecTab;
       TabellaMap = array[1..25] of st80;

       recmesum=record
		    n1,n2,lp:integer;
		end;
       tyinfo=array[1..maxinfo]of
		  record
		     ix,iy:integer
		  end;
	tabmesum  = Array[1..maxinfo] of recmesum;
	tabmess   = Array[1..maxinfo] of st80;
	tabvcomandi=array[1..20]of
		    record
		       comando:st80;
		       colonna:integer;
		       menu:boolean;
		       CODICE:INTEGER;
		     end;
	arvis=array[1..maxcampivis] of integer;
       {$ifdef win}
       proc= array [1..maxtasti] of procedure;
      {$endif}

      {$IFDEF INPS}
      CONST
       INPS2=78;
       {$ENDIF}
     var
       stampprn,tab_testo:boolean;
       FFileName: pchar;
       FlagStampa:boolean;
       {data_drive,}DRIVEMASK{,DRIVEPROG}:string[80];
       ar_ins:puntabins;
       setdata,getdata,Ins_data,Canc_data:boolean;
      {$ifdef win}
       tviswincl:boolean;
       cur_asp:hcursor;
       dueres,posres:boolean;
       posx,posy:integer;
       pmainwin:pwindow{sobject};
       pmainobj:pwindowsobject;

       procarr:proc;
       nstatico:integer;
       cancloseok:boolean;
       const
	  Win31LockWindowUpdate: function (Wnd: HWnd): Bool = nil;

	cm_HorizontalToolbar    =1;
	cm_RightVerticalToolbar =2;
	cm_LeftVerticalToolbar  =3;
       am_DrawStatusLine=wm_User + 200;
       am_DrawStatusLine1=wm_User + 201;
       var
       {$endif}
       basemask,offsetmask:longint;
       {Menu:DatiMenu;}
       Nmenu,Xmenu,Ymenu,SceltaMenu : integer;
       m_usa                        : boolean;
       ColTesto,ColTesto1,vv        : integer;
       ColFondo,ColFondo1           : integer;
       Tabella,TabMista             :^TabellaRec;
       tabellamista,ncampimista     : boolean;
       campivis                     : arvis;
       ArkUm,Umlav                  : ^elunmisure;
       fum                          : file of elunmisure;
       info                         : ^Tyinfo;
       info1                        : ^Tyinfo;
       mess                         : ^Tabmess;
       TESTAT                       :integer;
       infoum                       : ^Tyinfo;
       messum                       : ^tabmesum;
       UnMistemperatura             : integer;
       costMoltTemp,CostAddTemp     : real;
       Mappa                        : ^TabellaMap;
       MappaMista                   : ^TabellaMap;
       Ninfo,ninfoum                : integer;
       Ninfo1                       : integer;
       primocampo,UltimoCampo       : integer;
       ultimocampomista             : integer;
       nuovocampo,dimtab,ncampscuri : integer;
       PrimoAccesso,UltimoAccesso   : integer;
       CtrlKey,verso                : integer;
       nero,blu,verde,celeste,rosso,magenta,marrone,grigiolight,
       grigio,blulight,verdelight,celestelight,rossolight,magentalight,
       giallo,bianco : integer;
       STV,STV1                     : ST3;
       NUmCampiTab,NumCampiTab1     : Integer;
       {$IFDEF INPS}
       CONST

       INPS3=80;
       {$ENDIF}
var uscita,colon:integer;
    nomeprogetto:st80;
    rigamenu:st80;
    {fi:text;}
    tabellaaggiornata:boolean;
    ncol,ncom:integer;
    vcomandi:^Tabvcomandi;
    {nomemenu:st80;}
    mousepres,mousetemp:boolean;
    {mouset:string;}
    xprec,yprec:integer;
    M_X,M_y:integer;
    pdes,psin,pcen:boolean;
    {col:array[1..20]of integer;}
    {intero,reale,stringa,carattere:linestr;}
    M_TYPE:st80;
    glst,gfor:text;
    rimedio,causa,rapporto:st8;
    vecchiaexit:pointer;
    Exit_up:boolean;
    U_XMIN,U_YMIN,U_XMAX,U_YMAX:INteger;
    Nom_Mask:string[50];
    {$IFDEF INPS}
      CONST

       INPS4=83;
       {$ENDIF}

var BufOpz :^rechlp;
    Fopz   :File of rechlp;
    st_8   :st8;
    stampe_word:boolean;
    drive_lingua:string[50];

{$ifdef francia}
{$I Uticost.fra}
{$endif}

{$ifdef inglese}
{$I Uticost.eng}
{$endif}


{$ifdef italia}
{$I Uticost.ita}
{$endif}

{$ifdef tedesco}
{$I Uticost.ted}
{$endif}

{$ifdef slovacco}
{$I Uticost.slo}
{$endif}

{$ifdef ceco}
{$I Uticost.cec}
{$endif}

{$ifdef spagna}
{$I Uticost.spa}
{$endif}
implementation

end.

