
Unit definizCan;

Interface

Uses
(*{$Ifdef Win}
  Wincrt,
{$else}
  Crt,
  Dos,
{$endif}*)
  defuti,
  Turbo3,definiz; {Unit found in TURBO3.TPU}

{$I GRAFCOST }
{$I DATICADCAN}

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
                  Descr:st50;
                  Nome:st18;
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



    frec=record
          DescrScheda     :string[80];
          Scheda          :string;
          Modo            :integer;
          DescrDigitizer  :string[80];
          Digitizer       :string;
          DescrPlotter    :string[80];
          Plotter         :string;
          DescrStampante  :string[80];
          Stampante       :string;
       end;
      RecRiduz = record
                    CodRidR:string[5];
                    LungRidR,AngRidR:real;
                    CodRidC:string[5];
                    LungRidC,AngRidC:real;
                    CodAllR:string[5];
                    LungAllR,AngAllR:real;
                    CodAllC:string[5];
                    LungAllC,AngAllC:real;
                    CodTrasRC:string[5];
                    LungTrasRC:real;
                    CodTrasCR:string[5];
                    LungTrasCR:real;
                    CodRotR:string[5];
                    LungRotR:real;
                    RagCurv,RagStac,RagTee:real;
                 end;
TYPE
    st1=string[1];
    rec_inp = RECORD
                Tipo : st1;   { record di input da input.msk}
                lato_maggiore : INTEGER;
                lung_max_tron : INTEGER;
                lam_spessore : REAL;
                lam_peso : REAL;
                tipo_giunzio : ST2;
                cod_giu_tras : ST7;
                pes_giu_tras : REAL;
                rin_int_num : INTEGER;
                rin_int_tip : ST6;
                rin_int_pes : REAL;
                bul_tipo : ST3;
                bul_passo : INTEGER;
                bul_peso : REAL;
              END;



VAR
   
   mul : ARRAY[1..MAXCMT] OF rec_inp;
   drivearc,driveplt,nomecommessa{,DRIVEPROG}:string;
   {$ifdef dos}
 //  REGISTRI:REGISTERS;
   {$endif}
   Mis    : ^MisAr;
   DPR1   : ^DatiProg1;
   DPR2   : ^DatiProg2;
   EPt    : ^EPianteAr;
   Sez    : ^ElenSez;
   Riduz  : ^RecRiduz;
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

  FLAG_DATI         :BOOLEAN;
  ftxt              :text;
  Titolo            :STRING[80];
  ch                :char;
  NumeroProg        :STRING;
  Sottorete         :STRING;
  Caricamento       :boolean;
  InitMask,InitMenu :boolean;
  Vrec              :frec;
   ftext,fmenu      :text;
   ScMenu           :STRING[80];
   ERR, errore, fine:boolean;

      impag            :integer;
      NProg            :STRING[8];
      Init             :text;
      grafico          :array[1..5] of boolean;
      scelta           :integer;
      chiave           :integer;
      filet            :TEXT;
      GOSTAMP          : BOOLEAN; { VIENE USATA IN STAMPE ,MENUST,CARICHI}
      gorun            : boolean; { usata per la protezione chiave }

      Fint:file of integer;
      Riga:integer;

Const  NPezzi = 260;

 type  oldint=shortint;

    RigaArch = RECORD
                 Codice:string[10];
                 CodPezzo : ST5;
                 Descr : string[41];
                 CodDis : OldInt;
                 Main, Branch, Fonte : STRING[8];
                 Varie : STRING[10];
                 TipoSez :STRING[5];// ST5;
                 NUscite : oldint;
               END;

 T_ARCHIVIO = ARRAY[1..NPezzi] OF RigaArch;

var Archivio :^T_archivio;
    farc:file of T_archivio;
{$I def_archpezzi}
{$I TIPOCOST}
{$I defin_c}

const maxtabcalc=1500;
type
Ptabcalc=^link;
artabcalc=array[0..maxtabcalc]of ptabcalc;
Var TabCalc:^artabcalc;
    UltTabc:integer;
 function ExistS(Nome:STRING):boolean;
 FUNCTION Elev(a, x : REAL) : REAL;
PROCEDURE INIT_LINE(ind :LINK; Line : INTEGER);
Function Add_tabcalc(ind:link):integer;


{=============================================================================}
Implementation
Function Add_tabcalc(ind:link):integer;
begin
inc(UltTabc);
if TabCalc^[UltTabc]=Nil then New(TabCalc^[UltTabc]);
TabCalc^[UltTabc]^:=Ind;
TabCalc^[UltTabc]^.riga:=UltTabc;
result:=UltTabc;
end;

   FUNCTION Elev(a, x : REAL) : REAL;
    BEGIN
      IF a > 0 THEN Elev := EXP(x*LN(a)) ELSE Elev := 0;
    END;

  PROCEDURE INIT_LINE(Ind: LINK; Line : INTEGER);
    BEGIN
      WITH IND.T[Line] DO
        BEGIN
          CodPezzo := ''; Descr := ''; CHFlag := ' ';
          Portata := 0; Perdita := 0;
          A_D := 0; H := 0; W := 0;
          L := 0; R := 0; Ang := 0;
          ComVal := 0;
          X := 0; Y := 0; C0 := 0;
        END;
    END;

 FUNCTION ExistS(Nome:STRING):boolean;
 var f:file;

  function Exist(Nome:STRING):boolean;
   begin
      exist:=false;
      {$I-} assign(f,Nome);reset(f);{$I+}
      if (ioresult=0) then
       begin
          close(f);
          Exist:=true
       end;
   end;
  procedure WriteMessage(Nome:STRING;i:integer);
   var f    : text;
       Riga : STRING[80];
       k    : integer;
   begin
(*      assign(f,Nome);
      reset(f);
      for k:=1 to i do readln(f,Riga);
      close(f);
      write(chr(7));
      {$Ifdef win}
      {$else}
      textbackground(4);   textcolor(14);
      {$endif}
      gotoxy(1,21);  write(Riga);
      {$Ifdef win}
      {$else}
      textbackground(1);   textcolor(15);   ClrEol;
      delay(1200);
      {$endif}
      gotoxy(1,21);     ClrEol;*)
   end;

 begin
    existS:=false;
    if not exist(nome) then
     begin
       assign(f,Nome);
       {$I-}  rewrite(f);  {$I+}
       if (ioresult=0) then
        begin
          close(f);
          erase(f);
          ExistS:=true
        end
       else writemessage('Duct.msg',3);
     end
    else existS:=true;
 end;



end.
