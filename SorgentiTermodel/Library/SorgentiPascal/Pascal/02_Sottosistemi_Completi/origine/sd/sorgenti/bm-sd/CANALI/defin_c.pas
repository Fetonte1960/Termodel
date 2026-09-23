(*{$R+}    {Range checking off}
{$B+}    {Boolean complete evaluation on}
{$S+}    {Stack checking on}
{$I+}    {I/O checking on}
{$N-}    {No numeric coprocessor}
{$F+}
{$O+}

Unit defin_cab;

Interface

Uses
{$Ifdef Win}
Wincrt,
{$else}
  Crt,
  Dos,
{$endif}
  Turbo3, {Unit found in TURBO3.TPU}
  defuti,
  {ut_funz}utilitie;
*)
  CONST
    Version = 500;

    NCompRamo = 15 {pino31};
    ColRiga=71;
    LTabRamo = 16;
 //   NPezzi = 260;

    DIM_X  = 16;
    DIM_Y  = 16;
    {MaxMis = 40;
  TYPE
    DatiProg1 = RECORD
                  Cliente, Localita : ST40;
                  Progettista : STRING[20];
                  Impianto : st40;
                  NOrdine : STRING[20];
                  Disegno : STRING[8];
                  Riferimento : STRING[40];
                  Edificio, Sistema, Zona : ST40;
                  Circuito : st40;
                  AltSulMare, Altezza : INTEGER;
                  TempAria, UmRel : REAL;
                END;
    DatiProg2 = RECORD
                  Visc, Dens : REAL;
                  RivestInt : STRING[20];
                  SpessRivest, Rugosita : REAL;
                  TipoSezione : STRING[20];
                  Rapp, DimW, DimH, DPuMTronco, MinTronco, MaxTronco, VelTronco : REAL;
                  DPuMRami, MinRami, MaxRami, VelRami : REAL;
                  SbilDPu, SerrTermMax, SerrDPuMin : REAL;
                  VCostante : REAL;
                END;
                }
(*
type  oldint=shortint;

type
    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : string[41];
                 CodDis : OldInt;
                 Main, Branch, Fonte : STRING[8];
                 Varie : STRING[10];
                 TipoSez :STRING[5];// ST5;
                 NUscite : oldint;
               END;
    vecchio
    RigaArch = RECORD
                 CodPezzo : ST5;
                 Descr : ST40;
                 CodDis : INTEGER;
                 Main, Branch, Fonte : STRING[8];
                 Varie : STRING[10];
                 TipoSez : ST5;
                 NUscite : INTEGER;
               END;
     *)
type
    RigaRamo = RECORD
                 indp:integer;
                 CodPezzo : STRING[5];
                 Descr : STRING[40];
                 CHFlag : CHAR;
                 Portata, Perdita : REAL;
                 A_D : INTEGER;
                 H, W, Ang, Phi : INTEGER;
                 L, R, ComVal : REAL;
                 C0, X, Y : REAL;
               END;
   // LINK = ^TabRamo;
    TabRamo = RECORD
                riga:integer;
                T : ARRAY[0..LTabRamo] OF RigaRamo;
                Ps, Pd, Pc :Integer;
                TR : BOOLEAN;
                CodTab : INTEGER;
              END;
    LINK =TabRamo;

(*    Da Carichi termici
  CONST
  DIM_X=16;
  DIM_Y=16;
TYPE
  TabInterp=ARRAY[0..DIM_X,0..DIM_Y] OF REAL48;

VAR
  TabC0:^TabInterp;
Canali originale
    ARR = ARRAY[0..DIM_X, 0..DIM_Y] OF REAL;
    TabAsh = RECORD
               TabC0 : ARR;
               TIPO : INTEGER;
             END;
*)
    ARR = ARRAY[0..DIM_X, 0..DIM_Y] OF REAL48;
    TabAsh = RECORD
               TabC0 : ARR;
               TIPO : shortint;
             END;

{      RecMisure = record
               Rett,Circ:integer;
              end;
      MisAr = array[1..MaxMis] of RecMisure;
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
                 end;}

 //    P_ark=ARRAY[1..NPezzi] OF RigaArch;

Var
    {FInt:file of integer;
    {Scelta,} Sel : INTEGER;
    {f,} f99 : FILE OF INTEGER;
    miscor, i11 : INTEGER;
    NomeFile : st18;
    {fp : TEXT;}
    Spa : REAL;
    a1 : STRING[4];
    {DATA_DRIVE : st40;}
  {  Riga,} riga1, riga2 : st80;
    contest : REAL;
    {DPr1  : DatiProg1;}
    {DPr2  : DatiProg2;}
    {Riduz : RecRiduz;}
    KGB : TEXT;
    TESTO : ST80;
    Eps, densita, viscosita : REAL;
    VelCost, AttrCost, PMaxHLV, VMaxHLV : REAL;
    maskmc : st18;
    contapn : INTEGER;
    //farc:file of P_ark;
    //VProgcan :^ P_ark;
    //ARCHIVIO :^ P_ark;
    percorsonodi : ARRAY[1..100] OF INTEGER;
    indicepn : INTEGER;
    pn8 : ARRAY[1..100] OF st3;
    SYSTEM_DRIVE : ST40;
    FileArchivio : ST40;

    P0 :integer;

    Modifica_Ramo : BOOLEAN;

    FEdit : BOOLEAN;
    O, A : INTEGER;

    P1, P2, P3, PP : REAL;
    PerditaMax : REAL;
    RecC0 : TabAsh;

    Mandata : BOOLEAN;
    frid : TEXT;
    ARett, ACirc, VCR, VRC, RCirc, RRett, TRett : st5;
    MaxDimW, MaxDimH : REAL;
    BloccoTab : link;
(*
    LC,LR :INTEGER;
   DCirc : ARRAY[1..MaxMis] OF INTEGER;
   DRett : ARRAY[1..MaxMis] OF INTEGER;
*)   
    {Mis:MisAr;}
    {GLST : TEXT;}

CONST
        LC = 23;
        LR = 16;
        DCirc : ARRAY[1..LC] OF INTEGER
        = (75, 100, 125, 150, 175, 200, 225, 250, 300, 350, 400, 450, 500, 600, 700, 800,
        900, 1000, 1200, 1400, 1600, 1800, 2000);
        DRett : ARRAY[1..LR] OF INTEGER
        = (100, 150, 200, 250, 300, 350, 400, 500, 600, 800,
        1000, 1200, 1400, 1600, 1800, 2000);



(*
  FUNCTION FIND_ARCHIVIO(Codice : ST5) : INTEGER;
    VAR
      I, j ,y: INTEGER;
      Trovato : BOOLEAN;
    BEGIN
{       while length(Codice)<5 do Codice:=Codice+' ';}
      Codice:=Format(Codice,5);
      Codice:=UpString(Codice);

      I := 1; Trovato := FALSE;
      WHILE (I <= NPezzi) AND NOT Trovato DO
        BEGIN
{           while length(Archivio[i].CodPezzo) < 5 do Archivio[i].CodPezzo:=Archivio[i].CodPezzo+' ';}
           Archivio[i].CodPezzo:=Format(Archivio[i].CodPezzo,5);
           Archivio[i].CodPezzo:=UpString(Archivio[i].CodPezzo);
           Trovato := Archivio[i].CodPezzo=Codice;
{           Trovato := (COPY(Archivio[I].CodPezzo, 1, LENGTH(Codice)) = Codice);}
           IF NOT Trovato THEN i := i+1;
        END;
      IF NOT Trovato THEN FIND_ARCHIVIO := 0
      ELSE FIND_ARCHIVIO := I;

    END;

  FUNCTION FIND_ARCHIVIO(Codice : ST5) : INTEGER;
    VAR
      I, j : INTEGER;
      Trovato : BOOLEAN;
    BEGIN
      Codice:= UPString(Codice);
      Codice:= SetLeft(SetRight(Codice));

      I := 1; Trovato := FALSE;
      WHILE (I <= NPezzi) AND NOT Trovato DO
        BEGIN
           Archivio^[i].CodPezzo:= UPString(Archivio^[i].CodPezzo);
           Archivio^[i].CodPezzo:= SetLeft(SetRight(Archivio^[i].CodPezzo));
           Trovato := (Archivio^[I].CodPezzo = Codice);
           IF NOT Trovato THEN i := i+1;
        END;

      IF NOT Trovato THEN FIND_ARCHIVIO := 0
      ELSE FIND_ARCHIVIO := I;

    END;

  PROCEDURE Carica_Dim;
  var
    j:integer;
    fMis:file of MisAr;
    Vuoto:boolean;
  BEGIN
     if Exist(DATA_DRIVE+'Misure.ark') then
      begin
         assign(fmis,DATA_DRIVE+'Misure.ark');
         reset(fmis);
         read(fmis,Mis);
         close(fmis);
         j:=1;
         repeat
            Vuoto:=Mis[j].Circ=0;
            if Not Vuoto then
             begin
                DCirc[j]:=Mis[j].Circ;
                j:=j+1;
             end;
         until (j > MaxMis) or Vuoto;
         if not Vuoto then LC:=j
         else LC:=MaxMis;
         j:=1;
         repeat
            Vuoto:=Mis[j].Rett=0;
            if Not Vuoto then
             begin
                DRett[j]:=Mis[j].Rett;
                j:=j+1;
             end;
         until (j > MaxMis) or Vuoto;
         if not Vuoto then LR:=j
         else LR:=MaxMis;
      end
     else
      begin
         write(chr(7));
         exit;
      end;
 end;
*)

